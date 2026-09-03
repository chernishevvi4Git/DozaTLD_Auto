unit uMyCOMPort;

interface

uses sysutils, DateUtils, Dialogs, Classes, syncobjs, Controls, StdCtrls, Forms,
  {$IFDEF MSWINDOWS}
  Windows,
  {$ELSE}
  {$ENDIF}
  Synaser;
// PsAPI,

type
  //RBuff = packed array [0 .. {255}65535{4095}] of byte; // массив для синхронного опроса, чтобы передать packed array как параметр процедуры
  RBuff = packed array [0 .. 4095] of byte; // массив для синхронного опроса, чтобы передать packed array как параметр процедуры
  TCOMPortSyn = class;

  TMyThreadSyn = class(TThread)
  private
    Parent: TCOMPortSyn;
    FLock              : SyncObjs.TCriticalSection; // защищает PacketWithCRC/CountBytesToWrite/NeedSend/FConnectionFault от гонки между главным потоком и этим потоком
    PacketWithCRC      : RBuff;
    CountBytesToWrite  : integer;
    NeedSend           : boolean;
    FConnectionFault   : boolean; // выставляется при исключении в цикле обмена с портом; наблюдается снаружи (TTLD_Auto.WatchdogTimerTick), который и выполняет реальное восстановление
    FLastFaultMessage  : string;
  protected
    procedure Execute; override;
  public
    constructor Create(aParent: TCOMPortSyn);
    destructor Destroy; override;
    function IsSendPending: boolean;                            // потокобезопасная проверка: предыдущая передача еще не завершена
    procedure PrepareSend(const aBuff: RBuff; aBytes: integer);  // потокобезопасно выставляет буфер на отправку фоновым потоком
    function HasConnectionFault: boolean;                        // потокобезопасно: было ли зафиксировано исключение при обмене с портом
    function GetLastFaultMessage: string;                        // потокобезопасно: текст последнего исключения (для лога)
//    procedure SynchroQueryPort(aSendBuff: RBuff; aSendBytes: Dword; var aReceiveBuff: RBuff; var aReceiveBytes: Integer; var aAnswer: Boolean); overload;
  end;


  { TCOMPortSyn }

  TCOMPortSyn = class(TObject)
  private
      //FConnected                       : boolean; // инициализирован ли COM порт
      FCOM                             : RAWByteString;
      RS                               : RAWByteString;
      //QueryFlag                        : Boolean; // если пришел пакет true
      ReceiveBuff                      : RBuff; // буфер в который переписываются принятые данные
      COMPortReceiveBytes              : integer;
      procedure QueryPort;             // процедура опроса порта
      procedure ReceiveModBusData;     // в этих процедурах вызываются процедуры передачи данных в основной поток
      //procedure SetConnected(aConnected: boolean);
  public
      CP: TBlockSerial;
      MyThread: TMyThreadSyn;
      AsynchroOnReceiveModbus: procedure(aBytes: Cardinal; aReceiveBuff: RBuff) of object; // для асинхронного Modbus опроса
      constructor Create;
      destructor Destroy; override;
      function SetConfig(aBaudRate: integer; aByteSize: integer; aStopBits: integer; aParity: char): boolean;
      //property Connected: Boolean read FConnected write SetConnected;
  end;
  EProtocolFailure = class(Exception);
  EProtocolCancel = class(Exception);

implementation
uses uLanguages;

constructor TCOMPortSyn.Create;
begin
  inherited Create;
  CP:= TBlockSerial.Create;
  RS:='';
end;

destructor TCOMPortSyn.Destroy;
begin
  //FConnected:=False;
  if Assigned(MyThread) then
  begin
    MyThread.Terminate;  // сигнализируем потоку завершиться...
    MyThread.WaitFor;    // ...и дожидаемся, пока Execute реально выйдет из цикла (сам поток уже закрывает CP последним действием внутри себя)
    FreeAndNil(MyThread);
  end
  else
    CP.CloseSocket; // поток не был создан (например, не удалось открыть порт при первом подключении) - закрываем сами

  CP.Free;
  inherited Destroy;
end;

function TCOMPortSyn.SetConfig(aBaudRate: integer; aByteSize: integer; aStopBits: integer; aParity: char): boolean;
begin
  try
    CP.RaiseExcept := False;
    CP.LinuxLock := False; // это требуется для Linux. Если это не установить, то не удастся открыть порт.
    CP.Config(aBaudRate,aByteSize,aParity, aStopBits, false, false);
    result :=true;
  except
    result :=false;
  end;
end;

procedure TCOMPortSyn.ReceiveModBusData;
begin
  if Assigned(AsynchroOnReceiveModbus) then // ассинхронный опрос
    AsynchroOnReceiveModbus(COMPortReceiveBytes,ReceiveBuff);
  COMPortReceiveBytes := 0;
  FillChar(ReceiveBuff, SizeOf(ReceiveBuff), #0);//////!!!!!!!!!!!!
end;

//procedure TCOMPortSyn.SetConnected(aConnected: boolean);
//begin
//  if aConnected=FConnected then Exit;
//  FConnected:=aConnected;
//
//  if aConnected
//  then CP.Connect(FCom)
//  else CP.CloseSocket;
//
//end;

constructor TMyThreadSyn.Create(aParent: TCOMPortSyn);
begin
  Inherited Create(false);
  Parent := aParent;
  FLock := SyncObjs.TCriticalSection.Create;
end;

function TMyThreadSyn.IsSendPending: boolean;
begin
  FLock.Enter;
  try
    Result := NeedSend;
  finally
    FLock.Leave;
  end;
end;

procedure TMyThreadSyn.PrepareSend(const aBuff: RBuff; aBytes: integer);
begin
  FLock.Enter;
  try
    PacketWithCRC := aBuff;
    CountBytesToWrite := aBytes;
    NeedSend := True;
  finally
    FLock.Leave;
  end;
end;

function TMyThreadSyn.HasConnectionFault: boolean;
begin
  FLock.Enter;
  try
    Result := FConnectionFault;
  finally
    FLock.Leave;
  end;
end;

function TMyThreadSyn.GetLastFaultMessage: string;
begin
  FLock.Enter;
  try
    Result := FLastFaultMessage;
  finally
    FLock.Leave;
  end;
end;

procedure TMyThreadSyn.Execute;
var
  LocalBuff  : RBuff;
  LocalBytes : integer;
  DoSend     : boolean;
begin
  //Parent.CP.Connect(FCom);
  repeat
    try
      Parent.QueryPort; // процедура опроса порта будет производиться пока поток не будет прекращен

      DoSend := False;
      FLock.Enter;
      try
        if NeedSend then
        begin
          LocalBuff  := PacketWithCRC;   // копируем под блокировкой, чтобы дальше не держать лок на время реального ввода-вывода
          LocalBytes := CountBytesToWrite;
          DoSend := True;
        end;
      finally
        FLock.Leave;
      end;

      if DoSend then
      try
        Sleep(10);
        Parent.CP.SendBuffer(@LocalBuff,LocalBytes);
      finally
        FLock.Enter;
        try
          NeedSend:=False; // сбрасываем флаг только после копирования/отправки, под той же блокировкой, что и запись нового буфера
        finally
          FLock.Leave;
        end;
      end;
    except
      on E: Exception do
      begin
        // Раньше здесь исключение просто проглатывалось без следа и без восстановления.
        // Сейчас: фиксируем факт и текст ошибки потокобезопасно; реальную переинициализацию
        // порта выполняет главный поток (TTLD_Auto.WatchdogTimerTick), т.к. пересоздавать
        // COMPortSyn/этот же поток изнутри самого себя небезопасно (поток не может дождаться
        // собственного завершения).
        FLock.Enter;
        try
          FConnectionFault := True;
          FLastFaultMessage := E.Message;
        finally
          FLock.Leave;
        end;
        Sleep(200); // не долбим порт исключениями в тесном цикле, пока внешний наблюдатель не переинициализирует связь
      end;
    end;
    sleep(10);  // чтобы не сильно грузитьсистему ставим задержку, заведомо меньше установлденым таймаутам приема пакетов
  until Terminated;
  try
    Parent.CP.CloseSocket;
  except
  end;
end;

destructor TMyThreadSyn.Destroy;
begin
  FLock.Free;
  inherited;
end;

procedure TCOMPortSyn.QueryPort;
var
  MyBuff  : RBuff; // буфер для чтения данных
  DT: TDateTime;
  BR: Integer;
  ByteReaded                       : Dword; // количество считанных байт
begin
  //QueryFlag := false;//AsynchroAnswer := false;
  ByteReaded := 0;

//    sleep(100); // делаем небольшую паузу, если надо

  DT:=Now;
  ByteReaded:=CP.WaitingData;

  if ByteReaded > 0 then
  repeat
    BR:=ByteReaded;
    sleep(10);
    ByteReaded:=CP.WaitingData;
  until (BR=ByteReaded) and (MilliSecondsBetween(DT,Now)>300); // MaxWaitTime


  FillChar(MyBuff, SizeOf(MyBuff), #0); // очень не эффективно
//  FillChar(ReceiveBuff, SizeOf(ReceiveBuff), #0);

  CP.RecvBuffer(@MyBuff, ByteReaded);

  if ByteReaded > 0 then
  begin
    Move(MyBuff[0], ReceiveBuff[0], ByteReaded);
    COMPortReceiveBytes:=ByteReaded;

    MyThread.Synchronize(@ReceiveModBusData);
  end;
end;


end.

