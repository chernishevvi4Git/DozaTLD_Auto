unit uTLDCommandSeries;
{ #todo 1 -oЧернышев -c'БД, калибровка' : Индивидуальная калибровка }
{ #done -oЧернышев : Сделать режим облучения }
interface

uses
  Classes, SysUtils, ExtCtrls, uTLDCommand, uConst, uTypes;


type
  TTLD_Mode = (
      modeNothing          // Ничего не делать (для прекращения запросов)
    , modeMotorsInit       // Алгоритм первичной инициализации шаговых двигателей
    , modeMotorsToStart    // Шаговые двигатели в начальное положение (окончание типовых алгоритмов с перемещениями)
    , modeInitiation       // Алгоритм первичной инициализации всей установки
    , modeIdle             // Режим ожидания (ожидание команды пользователя для продолжения)
    , modeCheckAir         // Подпрограмма чтения измерения (без перемещений)
    , modeMeasuring        // Алгоритм измерения кассет (с перемещениями)
    , modeBurning          // Подпрограмма отжига
    , modeGrading          // Алгоритм перекидывания кассет из входной кассетницы в выходную (с контролем принадлежности)
    , modePushOut          // Подпрограмма выброса кассеты
    , modeDelay            // Подпрограмма ожидания для остывания (по времени)   - по температуре AirHeat_A6_...
    , modeFailBitCar       // Программа обработки ошибки "Закусило каретку при захвате кассеты"
    , modeIrradiation      // Программа облучения дозиметров
    , modeCalybrIrrad      // Программа калибровки облучателя
    , modeCalybrDosimeters // Программа калибровки дозиметров по внутреннему источнику
    , modeExit             // Завершение работы, снятие напряжения, предложение пользователю выключить установку
    );
  TCommand  = procedure(Params: String; Tag: Int64) of object;                      // команда
  //TCommands = array of procedure of object; // Массив указателей на команды
  TCommands = array of TCommand; // Массив указателей на команды

  TConnectedState = word; // по битам наличие связи

  TDialogType = (dNone, dInfo, dFail, dReserv); // типы диалогов

  { TTLD_CommandSeries }

  tTLD_CommandSeries = class
    FTLD_Mode: TTLD_Mode;                          // Текущий режим (работа по списку команд)
    Commands : array [TTLD_Mode] of TCommands;     // Списки команд
    FiCMD : integer;                               // Текущая команда в каждой серии (индивидуальные позиции для возможности писать макрокоманды)
  private
    //FConnectedFlag                  : boolean;     // признак связи со всеми приборами
    Cmd: tTLD_Auto;                                // Отсылка к TLDCommand (по сути = MainForm.TLDCommand)
    FCurrentProcess: TProcessType;
    Timer : TTimer;
    PreviosMode : TTLD_Mode;                       // Предыдущий режим (используется для подпрограмм когда нужно)
    PreviosCMD : integer;                          // Предыдущий индекс (используется для подпрограмм когда нужно)
    //UIMessageString : string;                      // Строковое описание последней ошибки
    //procedure SetConnectedFlag(aConnectedFlag: boolean);
    procedure OnTimer(Sender: TObject);            // Процедура таймера запросов/перезапросов по COM-порту
    procedure OnSuccesExecuteLastCommand;
    procedure OnCMDAccident(anAccident: TAccident; accMessage: string);// При аварийной ситуации

    procedure SetTLD_Mode(aTLD_Mode: TTLD_Mode);
    procedure SetiCMD(aiCMD: integer);
    procedure SetConnectedState(aConnectedState: TConnectedState);
    function GetConnectedState: TConnectedState;
    function GetCurrentProcessName: string;

  public
    isEmulator                      : boolean;
    DisableScaner                   : boolean; // Отключить сканер, заменить сканируемое на ручной ввод
    AllowExit                       : boolean;  // разрешение на выход из программы
    ManualBarCode                   : string;  // Значение штрихкода, которое будет использоваться при отключении сканера

    OnManualScanerEntered           : procedure of object;       // После использования подменной строки при чтении сканером
    OnChooseMode                    : procedure of object;       // После выбора режима перед его стартом
    OnChangeConnectionState         : procedure(anOldConnectionState, aNewConnectionState: word) of object; // После изменения состояния связи с приборами
    OnMeasureScanDosimeter          : procedure of object;       // ПЕРЕДАТЬ ШТРИХКОД ОСНОВНОЙ ПРОГРАММЕ ПРИ ЧТЕНИИ В ИЗМЕРЕНИИ
    OnChangeTLDMode                 : procedure(aTLD_Mode: TTLD_Mode) of object;    // После изменения режима
    OnChangeiCMD                    : procedure(aiCMD: integer; Addr: Pointer) of object;          // После изменения номера команды
    OnEndMeasure                    : procedure(aCarretPosition:TCarretePosition; aFinished: boolean) of object;  // Окончание измерения
    OnReceiveCommand_CloseStartMFWindow : procedure of object;               // на закрытие окна
    OnReceiveCommand_MeasureStopped : procedure of object;                   // на остановку
    OnCheckDarkCurrent              : procedure(aTestPassed:boolean; aDarkCurrent1,aDarkCurrent2:real) of object;
    OnCheckKSI                      : procedure(aTestPassed:boolean; aKSI1,aKSI2:real) of object;
    OnUIAnswerForFailure            : function(aCaption, aMessage: string; aDialogType: TDialogType; anAccidentNumber: integer): integer of object;

    //property CurrentProcess         : TProcessType read FCurrentProcess write SetCurrentProcess; // Номер текущего процесса
    property CurrentProcessName     : string read GetCurrentProcessName; // Строка текущего процесса

    property TLD_Mode               : TTLD_Mode read FTLD_Mode write SetTLD_Mode;   // Текущий режим (работа по списку команд)
    property iCMD                   : integer read FiCMD write SetiCMD;             // Текущая команда в каждой серии (индивидуальные позиции для возможности писать макрокоманды)
    property ConnectState           : TConnectedState read GetConnectedState write SetConnectedState;

    constructor Create(aCmd : tTLD_Auto);
    destructor Destroy; override;
    procedure SetCurrentProcess(AValue: TProcessType);

    procedure ExecuteNextCommand;                          // переделать по вызову короткого таймера чтобы не флудить в стек кучу вызовов
    procedure ExecuteRepeatCommand;                        // повторный вызов при неответе
    procedure ExecuteSkip(Steps: integer);                 //   - Команда Goto в пределах выбранного алгоритма на NumSteps шагов вперёд (для отката назад нужно использовать отрицательное смещение)

    procedure DeviceStartMeasures(aMeasuresMode: integer); // Запуск цикла измерений
    procedure DeviceStopEmergency;                         // Аварийная остановка

    function CMD_GetCommandIndex(aTLD_Mode: TTLD_Mode; beginIndex: integer; FindCommand: TCommand):integer;   //   Возвращает индекс команды в серии, начиная с beginIndex. Если не найдёт = -1

    procedure CMD_CommonSkip(Params: String; Tag: Int64);                      //   - Команда Goto в пределах выбранного алгоритма на NumSteps шагов вперёд (для отката назад нужно использовать отрицательное смещение)
    procedure CMD_CommonSkipNextIfNotFirst(Params: String; Tag: Int64);        //   - Пропускаем следующую команду, если установка уже была запущена раньше (повторный запуск программы или запуск по перехвату...)
    procedure CMD_CommonChooseMode(Params: String; Tag: Int64);                //   - ВЫБОР РЕЖИМА В ЗАВИСИМОСТИ ОТ СОСТОЯНИЯ
    procedure CMD_CommonCheckBeforeSwapping(Params: String; Tag: Int64);       //   - Проверка перед переброской кассет
    procedure CMD_CommonCheckCassA_Down(Params: String; Tag: Int64);           //   - Проверка - кассетница А должна быть опущена и быть в наличии
    procedure CMD_CommonCheckCassB_Down(Params: String; Tag: Int64);           //   - Проверка - кассетница Б должна быть опущена и быть в наличии
    procedure CMD_CommonCheckCassAB_Up(Params: String; Tag: Int64);            //   - Проверка -  обе кассетницы должны быть подняты
    procedure CMD_CommonCheckCassA_Up(Params: String; Tag: Int64);             //   - Проверка состояния ШД2 - он должен быть в положении ВЕРХ, поднять вверх при необходимости
    procedure CMD_CommonCheckCassB_Up(Params: String; Tag: Int64);             //   - Проверка состояния ШД3 - он должен быть в положении ВЕРХ, поднять вверх при необходимости
    procedure CMD_CommonCheckDarkCurrent(Params: String; Tag: Int64);          //   - Проверка темнового тока
    procedure CMD_CommonCheckCICurrent(Params: String; Tag: Int64);            //   - Проверка тока от контрольного источника
    procedure CMD_CommonCheckEndMeasure(Params: String; Tag: Int64);           //   - Проверка не пора ли заканчивать измерение
    procedure CMD_CommonGetScan(Params: String; Tag: Int64);                   //   - Чтение штрихкода сканером - передача кода в основной модуль при измерении
    procedure CMD_CommonGetScanFake(Params: String; Tag: Int64);               //   - Для отладки - Чтение фиксированного штрихкода сканером
    procedure CMD_CommonCheckDosimeter(Params: String; Tag: Int64);            //   - Ветвление по результатам проверки кода кассеты из основного модуля программы
    procedure CMD_CommonCheckSystem(Params: String; Tag: Int64);               //   - Проверка необходимости инициализировать моторы - запуск инициализации если обнаружена потребность
    procedure CMD_CommonUI_CloseStartMFWindow(Params: String; Tag: Int64);     //   - Закрыть окно StartMF или аналогичное
    procedure CMD_CommonUI_CheckUserAnswer(Params: String; Tag: Int64);        //   - Вывод сообщения об ошибке и ожидание действия пользователя
    procedure CMD_CommonUI_CheckEndMeasure(Params: String; Tag: Int64);        //   - Сообщение с подтверждением об окончании серии измерений
    procedure CMD_OutputUI_StartMeasure(Params: String; Tag: Int64);           //   - Информирование MainForm программы о начале измерения кассеты
    procedure CMD_OutputUI_StopMeasure(Params: String; Tag: Int64);            //   - Информирование MainForm программы об окончании измерения кассеты + проверка целевой температуры ФЭУ, если не соответствует заданной - запуск инициализации
    procedure CMD_CommonCheckScan4Empty(Params: String; Tag: Int64);           //   - Проверка состояния считанного кода со сканера - он должен быть N404040 - иначе или сбой, или нужно сбросить дозиметр

    procedure CMD_CommonCheckAir(Params: String; Tag: Int64);                  //   - Проверка состояния прокачки

    procedure CMD_CommonGoInit(Params: String; Tag: Int64);                    //   - ПЕРЕХОД В РЕЖИМ "Initialization"
    procedure CMD_CommonGoIdle(Params: String; Tag: Int64);                    //   - ПЕРЕХОД В РЕЖИМ "Idle" (ожидание)
    procedure CMD_CommonGoMotorsInit(Params: String; Tag: Int64);              //   - ПЕРЕХОД В РЕЖИМ "MotorsInit"
    procedure CMD_CommonGoSwapping(Params: String; Tag: Int64);                //   - ПЕРЕХОД В РЕЖИМ "Swapping" (смена кассеты)
    procedure CMD_CommonGoMeasuring(Params: String; Tag: Int64);               //   - ПЕРЕХОД В РЕЖИМ "Measuring" (Измерение одной кассеты)

    procedure CMD_CommonCallMotorsToStart(Params: String; Tag: Int64);         //   - ПРОЦЕДУРА, ПЕРЕХОД В РЕЖИМ "MotorsToStart" (Начальное положение шаговых двигателей)
    //procedure CMD_CommonReturnIfCheckMotorsAtStart(Params: String; Tag: Int64);//   - Проверка на окончание ожидания времени, Возврат в режим, из которого вызвали

    //procedure CMD_CommonCallCheckAir(Params: String; Tag: Int64);         //   - ПРОЦЕДУРА, ПЕРЕХОД В РЕЖИМ "Чтение измерения" (2 пары по 300 значений из ФЭУ)
    procedure CMD_CommonReturnIfEndMeasure(Params: String; Tag: Int64);        //   - Проверка на окончание текущего измерения и сохранение результатов, Возврат в режим, из которого вызвали

    procedure CMD_CommonDelay5(Params: String; Tag: Int64);                    //   - "Ожидание 5 sec"
    procedure CMD_CommonGoDelay(Params: String; Tag: Int64);                   //   - ПЕРЕХОД В РЕЖИМ "Ожидание" (из подпрограмм)
    procedure CMD_CommonWaitIrradiation(Params: String; Tag: Int64);           //   - ПЕРЕХОД В РЕЖИМ "Ожидание облучения"
    procedure CMD_CommonCallDelay(Params: String; Tag: Int64);                 //   - ПРОЦЕДУРА, ПЕРЕХОД В РЕЖИМ "Ожидание"

    procedure CMD_CommonReturnIfEndTime(Params: String; Tag: Int64);           //   - Проверка на окончание ожидания времени, Возврат в режим, из которого вызвали

    procedure CMD_CommonCallBurningIfNeed(Params: String; Tag: Int64);         //   - Проверка на отжиг в профиле, и если он есть - вызов подпрограммы отжига

    procedure CMD_CommonCallPushOut(Params: String; Tag: Int64);               //   - ПРОЦЕДУРА, ПЕРЕХОД В РЕЖИМ "PushOut" (сталкивание кассеты)

    procedure CMD_CommonGoProcessNumber(Params: String; aProcessNumber: Int64);//   - ПЕРЕХОД В РЕЖИМ, Определённый тэгом ord(ProcessType)
    procedure CMD_CommonCall(Params: String; Tag: Int64);                      //   - Вызов подпрограммы по имени (Params = TLD_Mode_Name)
    procedure CMD_CommonReturn(Params: String; Tag: Int64);                    //   - Возврат в режим, из которого вызвали

    procedure CMD_CommonShutDown(Params: String; Tag: Int64);                  //   - Выход из программы после завершения процедур

    procedure TimerStop;                                                       //   Временная остановка машины состояний (в ожидании реакции пользователя, например)
    procedure TimerGo;                                                         //   Продолжение работы машины состояний

  end;

const
  cConnectAll = 127 - 4 - 8; // со всеми приборами есть связь (кроме устаревших)

implementation
uses DateUtils, uLanguages, System.UITypes, Forms, uTimerMessages, TypInfo;
{ TTLD_CommandSeries }

var
  TimerCount: Int64 = 0;
  RepeatTime: TDatetIme = 0;
procedure tTLD_CommandSeries.OnTimer(Sender: TObject);
const
  cRepeatTime = 1;            // интервал между попытками повторной команды
begin
  if not Assigned(Cmd)then Exit; // отсекаем стартовые процессы
  if isEmulator then
  begin

    if (CountActiveTimerMessages=0) then OnSuccesExecuteLastCommand; // эмуляция успешного выполнения последней команды для выполнения следующей
    Exit;
  end;

  // Вставка для работы с удалённым компом
  if Cmd.IsTranslatorServer and not Cmd.IsTranslatorClient then // Если мы сервер - ничего не делаем сами, только индицируем оное
  begin
    Cmd.Panel.Output.Status := Cmd.Panel.Output.Status.SetBit(1);
    Cmd.NNUserPanelWrite1000;
    Exit;
  end
    else Cmd.Panel.Output.Status := Cmd.Panel.Output.Status.ClearBit(1);

  if Cmd.NoAnswerCount>MaxNoAnswer then // когда прошло слишком много времени, а прибор всё-же не отвечает
  begin
    case Cmd.CNTQuery of
      01..30:   if Cmd.Motors.Connected  then begin Cmd.Motors.Connected  := false; CMD_CommonUI_CheckUserAnswer(rsMotorsBoardConFail, cUI_MotorsBoardConFail ); end;
      31..50:   if Cmd.AirHeat.Connected then begin Cmd.AirHeat.Connected := false; CMD_CommonUI_CheckUserAnswer(rsAirHeatBoardConFail,cUI_AirHeatBoardConFail); end;
      //81..90:   if Cmd.MonitorBoard.Connected then begin Cmd.MonitorBoard.Connected := false; CMD_CommonUI_CheckUserAnswer(rsMonitorBoardConFail,cUI_MonitorBoardConFail); end;
      //51..60:   if Cmd.PMTBoard.Connected     then begin Cmd.PMTBoard.Connected     := false; CMD_CommonUI_CheckUserAnswer(rsPMTBoardConFail,    cUI_PMTBoardConFail    ); end;
      61..70:   if Cmd.Scaner.Connected    then begin Cmd.Scaner.Connected    := false; CMD_CommonUI_CheckUserAnswer(rsScanBoardConFail,   cUI_ScanBoardConFail   ); end;
      151..170: if Cmd.PMT.Connected       then begin Cmd.PMT.Connected       := false; CMD_CommonUI_CheckUserAnswer(rsPMTNewConFail,      cUI_PMTNewConFail      ); end;
    end;
    Cmd.NoAnswerCount:=0;
    Cmd.SendPacketTime:=Now;
    ExecuteNextCommand;
  end
  else // если не превышено "слишком большое время"
  if (SecondsBetween(Cmd.SendPacketTime,Now)>cRepeatTime) // прошло многовато времени с последнего запроса
    and (SecondsBetween(RepeatTime,Now)>cRepeatTime) // и превышено время повтора
    and (TLD_Mode<>modeNothing) // не включен режим бездействия
    and (CountActiveTimerMessages=0) // нет диалоговых окон
    then // когда прибор не отвечает - повторяем команду несколько раз
  begin
    Cmd.NoAnswerCount := Cmd.NoAnswerCount + 1;
    RepeatTime:=Now;
    ExecuteRepeatCommand;
  end;

  if not Cmd.Panel.DontUse then
  begin

    if Cmd.Panel.Connected then
    begin
      Cmd.Panel.Connected := Cmd.ModbusClient.Connected;
        if not Cmd.Panel.Connected then CMD_CommonUI_CheckUserAnswer(rsPanelConnectionFailure, cUI_UIPanelConFail);
    end;
    Cmd.Panel.Connected := Cmd.ModbusClient.Connected;
  end;

  ConnectState :=
     ord(Cmd.Motors.Connected) +
     ord(Cmd.AirHeat.Connected) shl 1 +
     //ord(Cmd.MonitorBoard.Connected) shl 2 +
     //ord(Cmd.PMTBoard.Connected) shl 3 +
     ord(Cmd.Scaner.Connected) shl 4 +
     ord(Cmd.PMT.Connected) shl 5 +
     ord(Cmd.Panel.Connected or Cmd.Panel.DontUse) shl 6;

  if Cmd.Panel.Output.Connected<>cConnectAll
    then Cmd.Panel.Output.Status := Cmd.Panel.Output.Status or cPanelStatusBit_DisConnected
    else Cmd.Panel.Output.Status := Cmd.Panel.Output.Status and not cPanelStatusBit_DisConnected;

  TimerCount := TimerCount + 1;
  try
    if not Cmd.Panel.DontUse then
      if not Cmd.ModbusClient.Connected then
        if (TimerCount mod 60)=0 then
          if not Cmd.Emulator then
            Cmd.ModbusClient.Connect;
  except
  end;

  Cmd.Panel.Output.AutoIncrement := TimerCount mod 65536;
  Cmd.NNUserPanelReadBase;
  Cmd.NNUserPanelWrite1000;
end;

procedure tTLD_CommandSeries.OnSuccesExecuteLastCommand;
begin
//  if IsLastCommand then Sleep(100);
  Cmd.NoAnswerCount:=0;

  Cmd.ClearCallParams;
  if Timer.Enabled then // Выключаем работу машины состояний когда выключен таймер
    ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.OnCMDAccident(anAccident: TAccident; accMessage: string);
begin
  CMD_CommonGoIdle('',0);
  CMD_CommonUI_CheckUserAnswer(rsAccLowFlow,cUI_LowFlow);
  //CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus and $FFF9;  // сбрасываем биты 1 и 2
  //CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus or $0004;   // устанавливаем бит 2 - Accident
  //if Assigned(OnAccident) then OnAccident(AnAccident,accMessage);
end;

procedure tTLD_CommandSeries.SetCurrentProcess(AValue: TProcessType);
begin
  if FCurrentProcess=AValue then Exit;
  FCurrentProcess:=AValue;
  CMD_CommonGoProcessNumber('',ord(AValue));
end;

procedure tTLD_CommandSeries.SetTLD_Mode(aTLD_Mode: TTLD_Mode);
begin
  FTLD_Mode:= aTLD_Mode;
  if Assigned(OnChangeTLDMode) then OnChangeTLDMode(aTLD_Mode);
  Cmd.Panel.Output.TLD_Mode:=Ord(aTLD_Mode);
  Cmd.Panel.Output.TLD_Mode_Length:=Length(Commands[aTLD_Mode]);
end;

procedure tTLD_CommandSeries.SetiCMD(aiCMD: integer);
begin
  FiCMD := aiCMD;
  if FiCMD<-1 then FiCMD:=-1;
  if Assigned(OnChangeiCMD) then OnChangeiCMD(aiCMD,Nil);
  //if FiCMD=-1
  //  then if Assigned(OnChangeiCMD) then OnChangeiCMD(aiCMD,Nil)
  //  else if Assigned(OnChangeiCMD) then OnChangeiCMD(aiCMD,@Commands[TLD_Mode][FiCMD]);
  Cmd.Panel.Output.TLD_Command:=aiCMD;
end;

procedure tTLD_CommandSeries.SetConnectedState(aConnectedState: TConnectedState);
begin
  if Cmd.Panel.Output.Connected<>aConnectedState then
  begin
    OnChangeConnectionState(Cmd.Panel.Output.Connected,aConnectedState);
    Cmd.Panel.Output.Connected:=aConnectedState;
  end;
end;

function tTLD_CommandSeries.GetConnectedState: TConnectedState;
begin
  result:=Cmd.Panel.Output.Connected;
end;

function tTLD_CommandSeries.GetCurrentProcessName: string;
begin
  case FCurrentProcess of
    cIdle:             result := rsIdle;
    cInit:             result := rsInit;
    cStartSingleMeas:  result := rscStartSingleMeas;
    cStartSeriaMeas:   result := rscStartSeriaMeas;
    cStartCalibration: result := rscStartCalibration;
    cTesting:          result := rscTesting;
    cBurning:          result := rscBurning;
    cIrradiation:      result := rscIrradiation;
    cGrading:          result := rscGrading;
    cRegistration:     result := rscRegistration;
    else               result := rsUnknownProcess;
  end;
end;

procedure tTLD_CommandSeries.CMD_CommonChooseMode(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonChooseMode,'',cMsgRead,cMsgPriorityInf);

  if Assigned(OnChooseMode) then OnChooseMode;

  // сделать ветвление по режимам по условиям
  if (TLD_Mode = modeMeasuring) or (TLD_Mode = modeBurning) or (TLD_Mode = modeGrading) then
  begin // контроль работы
// Нажат стоп
    if Cmd.ChangeData.IsStopped then
    begin
      Cmd.ChangeData.IsStopped := false;
      CMD_CommonGoIdle(Format(rsCommonUIStopByUser,[CurrentProcessName]),cUI_StopByUser);
      Exit;
    end
      //ExecuteSkip(-1) // держимся тут пока не отжато
// Пропала связь c одним из приборов пока мы что-то делали --> принудительно перейдём в ожидание
    else if (ConnectState<>cConnectAll) and (TLD_Mode <> modeIdle) then
    begin
      CMD_CommonGoIdle('',0);      //   - ПЕРЕХОД В РЕЖИМ "Idle" (ожидание)
      //if iCMD=-1 then ExecuteNextCommand;
      Exit;
    end;
  end;

  //ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckBeforeSwapping(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckBeforeSwapping,'',cMsgRead,cMsgPriorityInf);
  if (CMD.Motors.ReadMotor[2].Message and $4000 = 0) and (CMD.Motors.ReadMotor[3].Message and $4000 = 0)   // кассетницы должны быть подняты
    then ExecuteNextCommand
    else
      begin
        CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsBadCheckBeforeSwapping,'',cMsgRead,cMsgPriorityInf);
        CMD_CommonGoIdle('',0);      //   - ПЕРЕХОД В РЕЖИМ "Idle" (ожидание)
      end
end;

procedure tTLD_CommandSeries.CMD_CommonCheckCassA_Down(Params: String; Tag: Int64); // после опускания кассетницы A
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckCassA_Down,'',cMsgRead,cMsgPriorityInf);

  // если эмуляция - проскакиваем сразу
  if isEmulator then
  begin
    ExecuteNextCommand;
    Exit;
  end;

  if (Cmd.Motors.ReadMotor[2].Message and $4000 = 0) or  //OP1 - CheckBox_Motors_OP1.Checked := ReadMotor[2].Message and $4000 <> 0; // D14
     (Cmd.Motors.ReadMotor[2].Message and $8000 = 0)     //PS3 - CheckBox_Motors_PS3.Checked := ReadMotor[2].Message and $8000 <> 0; // D15
  then // Нет кассетницы А (входной)
  begin
    if Assigned(OnReceiveCommand_MeasureStopped) then OnReceiveCommand_MeasureStopped;
    CMD_CommonUI_CheckUserAnswer(rsCommonBadCheckCassA_Down,cUI_ErrCassA_Down);
    //CMD_CommonCallMotorsToStart;
  end
    else
      ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckCassB_Down(Params: String; Tag: Int64); // после опускания кассетницы B
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckCassB_Down,'',cMsgRead,cMsgPriorityInf);

  // если эмуляция - проскакиваем сразу
  if isEmulator then
  begin
    ExecuteNextCommand;
    Exit;
  end;

  if (Cmd.Motors.ReadMotor[3].Message and $4000 = 0) or  //OP2 - CheckBox_Motors_OP2.Checked := ReadMotor[3].Message and $4000 <> 0; // D14
     (Cmd.Motors.ReadMotor[3].Message and $8000 = 0)     //PS4 - CheckBox_Motors_PS4.Checked := ReadMotor[3].Message and $8000 <> 0; // D15
  then // Нет одной из кассетниц
  begin
    if Assigned(OnReceiveCommand_MeasureStopped) then OnReceiveCommand_MeasureStopped;
    CMD_CommonUI_CheckUserAnswer(rsCommonBadCheckCassB_Down,cUI_ErrCassB_Down);
  end
    else
      ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckCassAB_Up(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckCassAB_Up,'',cMsgRead,cMsgPriorityInf);

  // если эмуляция - проскакиваем сразу
  if isEmulator then
  begin
    ExecuteNextCommand;
    Exit;
  end;

  if (Cmd.Motors.ReadMotor[2].Message and $4000 = 1) or  //OP1 - D14
     (Cmd.Motors.ReadMotor[3].Message and $4000 = 1)     //OP2 - D14
  then // Нет одной из кассетниц
  begin
    if Assigned(OnReceiveCommand_MeasureStopped) then OnReceiveCommand_MeasureStopped;
    CMD_CommonUI_CheckUserAnswer(rsCommonBadCassAB_Up,cUI_ErrCassAB_Up);
  end
    else
      ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckDarkCurrent(Params: String; Tag: Int64);
var
  TestPassed: boolean;
  //DarkCurrent: real;
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  //CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsCommonCheckDarkCurrent,[Cmd.PMTBoard.RealTimeCount[1],Cmd.PMTBoard.RealTimeCount[2]]),'',cMsgRead,cMsgPriorityInf);
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsCommonCheckDarkCurrent,[Cmd.PMT.Dark_current_val_ch1,Cmd.PMT.Dark_current_val_ch2]),'',cMsgRead,cMsgPriorityInf);

  // если эмуляция - проскакиваем сразу
  if isEmulator then
  begin
    ExecuteNextCommand;
    Exit;
  end;

  //DarkCurrent:= (Cmd.PMT.Dark_current_val_ch1 + Cmd.PMTBoard.RealTimeCount[2])/2;
  TestPassed:=(Cmd.PMT.Dark_current_val_ch1>=0) and (Cmd.PMT.Dark_current_val_ch2>=0); // Вписать правильное условие!!!   // границы потом уточнить
  if (OnCheckDarkCurrent<>Nil) then OnCheckDarkCurrent(TestPassed,Cmd.PMT.Dark_current_val_ch1,Cmd.PMT.Dark_current_val_ch2);
  if not TestPassed then // Выход темнового тока за границы допустимых значений
  begin
    CMD_CommonUI_CheckUserAnswer(rsCommonBadDarkCurrent,cUI_DarkCurrent);
  end
    else
      ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckCICurrent(Params: String; Tag: Int64);
var
  TestPassed: boolean;
  //KSICurrent: real;
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsCommonCheckCICurrent,[Cmd.PMT.Ref_src_val_ch1,Cmd.PMT.Ref_src_val_ch2]),'',cMsgRead,cMsgPriorityInf);

  // если эмуляция - проскакиваем сразу
  if isEmulator then
  begin
    ExecuteNextCommand;
    Exit;
  end;

  //KSICurrent:= (Cmd.PMTBoard.RealTimeCount[1] + Cmd.PMTBoard.RealTimeCount[2])/2;
  TestPassed:=(Cmd.PMT.Ref_src_val_ch1>=0) and (Cmd.PMT.Ref_src_val_ch2>=0);  // границы потом уточнить
  if (OnCheckKSI<>Nil) then OnCheckKSI(TestPassed,Cmd.PMT.Ref_src_val_ch1,Cmd.PMT.Ref_src_val_ch2);
  if not TestPassed then // Выход тока при подсветке за границы допустимых значений
  begin
    CMD_CommonUI_CheckUserAnswer(rsCommonBadCICurrent,cUI_CICurrent);
  end
    else
      begin
        ExecuteNextCommand;
      end;
end;

var
  CountFailScan: integer = 0;
procedure tTLD_CommandSeries.CMD_CommonGetScan(Params: String; Tag: Int64);
var
  i,Test: integer;
  S: string;
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  // получение строки штрихкода для лога
  S:='';
  with Cmd.Scaner do
  begin
    for i:=0 to BarCodeLength-1 do
    begin
      if BarCode[i]<32
      then S := S + AnsiChar(BarCode[i]+32)
      else S := S + AnsiChar(BarCode[i]);
    end;
  end;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',format(rsCommonCheckScan,[S]),'',cMsgRead,cMsgPriorityInf);

  Cmd.ChangeData.DosimeterFound:=dsfNone; // Очищаем предыдущее состояние пользовательской оценки штрихкода
  Test:=0;
  for i:=0 to CMD.Scaner.BarCodeLength-1 do
    Test := Test or CMD.Scaner.BarCode[i];

  if (Test=0) and DisableScaner then Test:=-1;

  if (CMD.BarCodeString='40404040N') or (CMD.BarCodeString='404040N') or (CMD.BarCodeString='404040') or (CMD.BarCodeString='40404040') then // штрихкод подложки
  begin   //нет кассеты, читается штрихкод из каретки
    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsNoCheckScan+' code 1','',cMsgRead,cMsgPriorityInf);
    CountFailScan:=0;
    CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus.ClearBit(procstateDosimeterInMove); // Дозиметра на каретке нет
    CMD_CommonUI_CheckEndMeasure('',0); // ОКОНЧАНИЕ КАССЕТ В КАССЕТНИЦЕ - в автозавершение
    Exit;
  end
    else
  if (Test = 0) then //нет кассеты, но нет и каретки - сбой позиционирования каретки или сбой сканера
  begin
    // если такое произошло - возможно каретка закусилась с кассетницей и не доехала, попробуем преодолеть
    CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus.ClearBit(procstateDosimeterInMove); // Дозиметра на каретке нет
    CountFailScan := CountFailScan + 1;
    if CountFailScan<=2 then
    begin
      iCMD:=iCMD-1; // или -2?
      CMD_CommonCall(GetEnumName(TypeInfo(TTLD_Mode),ord(modeFailBitCar)),0);  // подпрограмма
      Exit;
    end
      else
    begin
      CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsNoCheckScan+' code 2','',cMsgRead,cMsgPriorityInf);
      CMD_CommonUI_CheckUserAnswer(rsCommonBadScan,cUI_BadScan);
      Exit;
    end;
  end
    else //код распознан
      begin
        CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',format(rsCheckScan,[ManualBarCode]),'',cMsgRead,cMsgPriorityInf);
        CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus.SetBit(procstateDosimeterInMove); // Дозиметр на каретке
        CountFailScan:=0;
        if DisableScaner then CMD.BarCodeString := ManualBarCode;

        if (OnMeasureScanDosimeter<>Nil) then OnMeasureScanDosimeter;
        ExecuteNextCommand;
        Exit;
      end;
end;

var
  TestNum: integer=1;
procedure tTLD_CommandSeries.CMD_CommonGetScanFake(Params: String; Tag: Int64);
//var
//  i,Test: integer;
//  S: string;
begin
  //Cmd.CNTQuery:=cCNTCommon;;
  //// получение строки штрихкода для лога
  //S:='';
  //with Cmd.Scaner do
  //begin
  //  for i:=0 to BarCodeLength-1 do
  //  begin
  //    if BarCode[i]<32
  //    then S := S + AnsiChar(BarCode[i]+32)
  //    else S := S + AnsiChar(BarCode[i]);
  //  end;
  //end;
  //CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',format(rsCommonCheckScan,[S]),'',cMsgRead,cMsgPriorityInf);
  //
  //Cmd.ChangeData.DosimeterFound:=dsfNone; // Очищаем предыдущее состояние пользовательской оценки штрихкода
  //Test:=0;
  //for i:=0 to CMD.Scaner.BarCodeLength-1 do
  //  Test := Test or CMD.Scaner.BarCode[i];
  //
  ////if ((CMD.Scaner.BarCodeLength = 7) and (CMD.Scaner.BarCode[0]=0) and (CMD.Scaner.BarCode[1]=52) and (CMD.Scaner.BarCode[2]=78) and (CMD.Scaner.BarCode[3]=52) and (CMD.Scaner.BarCode[4]=48) and (CMD.Scaner.BarCode[5]=52) and (CMD.Scaner.BarCode[6]=48))
  ////   or (CMD.BarCodeString='40404040N') or (CMD.BarCodeString='404040N') or (CMD.BarCodeString='404040') or (CMD.BarCodeString='40404040')
  //if (CMD.BarCodeString='40404040N') or (CMD.BarCodeString='404040N') or (CMD.BarCodeString='404040') or (CMD.BarCodeString='40404040')
  //then // штрихкод подложки
  //begin   //нет кассеты, читается штрихкод из каретки
  //  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsNoCheckScan,'',cMsgRead,cMsgPriorityInf);
  //  UIMessageString := rsCommonNoDosimeter;
  //  CMD_CommonUI_CheckEndMeasure; // ОКОНЧАНИЕ КАССЕТ В КАССЕТНИЦЕ - в автозавершение
  //end
  //  else
  //if (Test = 0) then //нет кассеты, но нет и каретки - сбой позиционирования каретки или сбой сканера
  //begin
  //  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsNoCheckScan,'',cMsgRead,cMsgPriorityInf);
  //  UIMessageString := rsCommonBadScan;
  //  Cmd.CNTQuery:=cCNT_UI_BadScan;
  //  CMD_CommonUI_CheckUserAnswer;
  //end
  //  else //код распознан
  //    begin
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //      //CMD.BarCodeString:='8485'+IntToStr(TestNum+1)+'TST';
  //      CMD.BarCodeString:='84854TST';
  //        TestNum := TestNum mod 3 +1;
  //        if (OnMeasureScanDosimeter<>Nil) then OnMeasureScanDosimeter;
  //        ExecuteNextCommand;
  //        Exit;
  //
  //
  //
  //
  //
  //
  //
  //
  //      if (OnMeasureScanDosimeter<>Nil) then OnMeasureScanDosimeter;
  //      ExecuteNextCommand;
  //    end;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckDosimeter(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  case Cmd.ChangeData.DosimeterFound of
  dsfNone:
    begin
      //CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsInternalError,[UIMessageString]),'',cMsgRead,cMsgPriorityInf);
      Cmd.Panel.Output.ProcessStatus:=Cmd.Panel.Output.ProcessStatus.ClearBit(procstateScanInDB);// and $FFFE;  // сбрасываем бит 0 // Сбрасываем дозиметр в интерфейсе панели
      CMD_CommonUI_CheckUserAnswer('No Dosimeter Status',cUI_AlgorithmErr);
    end;
  dsfFound:
    if (Cmd.ChangeData.DosimeterFound = dsfFound) then
    begin
      CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCasseteFound,'',cMsgRead,cMsgPriorityInf);
      Cmd.Panel.Output.ProcessStatus:=Cmd.Panel.Output.ProcessStatus.SetBit(procstateScanInDB);// 0R $0001;  // устанавливаем бит 0

      ExecuteNextCommand; // продолжаем измерение
    end;
  dsfNotFound:
    begin
      CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCasseteMotRecognized,'',cMsgRead,cMsgPriorityInf);
      iCMD:=-1; // Начнём заново цикл измерения после выталкивания
      Cmd.Panel.Output.ProcessStatus:=Cmd.Panel.Output.ProcessStatus.ClearBit(procstateScanInDB);// and $FFFE;  // сбрасываем бит 0 // Сбрасываем дозиметр в интерфейсе панели
      CMD_CommonCallPushOut('',0);      //   - ВЫЗОВ "PushOut" (сталкивание кассеты)
    end;
  end;
end;

procedure tTLD_CommandSeries.CMD_CommonReturnIfEndMeasure(Params: String; Tag: Int64); // устаревшее
var
  i: integer;
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  try
    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsReturnIfMeasure,[Cmd.AirHeat.Temperature[2]/10,Cmd.PMT.Measure_instant_ch1,Cmd.AirHeat.Temperature[3]/10,Cmd.PMT.Measure_instant_ch2]),'',cMsgRead,cMsgPriorityInf);
  except
    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ','CMD_CommonCheckEndMeasure Format Error','',cMsgRead,cMsgPriorityInf);
  end;
  // добавляем по элементу в массивы
  //if High(Cmd.TempResult)<>High(Cmd.ImpulseResult) then
  //begin
  //  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsInternalError,['ImpulseResult<>TempResult']),'',cMsgRead,cMsgPriorityInf);
  //  UIMessageString:=Format(rsInternalError,['ImpulseResult<>TempResult']);
  //  CMD_CommonUI_CheckUserAnswer; //   - Вывод сообщения об ошибке и ожидание действия пользователя
  //
  //end;

  //Setlength(Cmd.TempResult,i+2);
  i:=High(Cmd.ImpulseResult);
  Setlength(Cmd.ImpulseResult,i+2);
  i:=High(Cmd.ImpulseResult); //i+1 = новый последний элемент

  Cmd.TempResult[i]    := Cmd.AirHeat.Temperature[2]; //1,3 det
  Cmd.ImpulseResult[i] := Round(Cmd.PMT.Measure_instant_ch1*10);   //1,3 det с учетом за 100мс  ?

  if SecondsBetween(Cmd.StartTime,Now)>10 // переделать под профиль
  then
    begin
      CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsGetMeasureDone,'',cMsgRead,cMsgPriorityInf);
      TLD_Mode := PreviosMode;
      iCMD := PreviosCMD;
      ExecuteNextCommand;
    end
  else
    ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonGoDelay(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCallDelay,'',cMsgRead,cMsgPriorityInf);
  TLD_Mode := modeDelay;
  iCMD:=-1;

  CMD.StartTime:=Now;

  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonWaitIrradiation(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  PreviosMode := TLD_Mode;
  PreviosCMD := iCMD;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCallDelay,'',cMsgRead,cMsgPriorityInf);

  Cmd.ChangeData.WaitTime := round(Cmd.Motors.IrradiationTime*60); // ожидание

  TLD_Mode := modeDelay;
  iCMD:=-1;

  CMD.StartTime:=Now;

  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonDelay5(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsDelay5,'',cMsgRead,cMsgPriorityInf);

  Timer.Enabled := false;
  try
    Sleep(5000);
    Cmd.SendPacketTime:=Now;
  finally
    Timer.Enabled := true;
  end;
  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonReturnIfEndTime(Params: String; Tag: Int64);
var
  sb: integer;
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;
  sb:= SecondsBetween(Cmd.StartTime,Now);
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsCommonCheckEndTime,[sb,Cmd.ChangeData.WaitTime]),'',cMsgRead,cMsgPriorityInf);
  if sb>Cmd.ChangeData.WaitTime
  then
    begin
      CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsWaitTimeDone,'',cMsgRead,cMsgPriorityInf);
      TLD_Mode := PreviosMode;
      iCMD := PreviosCMD;
      ExecuteNextCommand;
    end
  else
    ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonUI_CheckUserAnswer(Params: String; Tag: Int64);
var
  Res: integer;
  DialogType: TDialogType;
begin
  CMD.SaveCallParams(Params, Tag);
  //Timer.Enabled := false;
  //if Params<>'' then UIMessageString := Params; // при прямом вызове алгоритмических ошибок
  case Tag of  // для предопределённых сообщений - основное использование
    cUI_MotorsBoardFail,
    cUI_MotorsBoardConFail,
    cUI_AirHeatBoardConFail,
    cUI_MonitorBoardConFail,
    cUI_PMTBoardConFail,
    cUI_ScanBoardConFail,
    cUI_PMTNewConFail,
    cUI_COMPortFail,
    cUI_UIPanelConFail,
    cUI_DarkCurrent,
    cUI_CICurrent,
    cUI_BadScan,
    cUI_ErrCassA_Down,
    cUI_ErrCassB_Down,
    cUI_StopByUser,
    cUI_EndMeasure: DialogType := dInfo;
               else DialogType := dFail;
  end;

  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Params + ' (' + IntToStr(Tag) +')','',cMsgRead,cMsgPriorityInf);
  CMD.Panel.Output.AccidentNumber := Tag; // номер сообщения в панель
  CMD.Panel.Output.ProcessStatus:=CMD.Panel.Output.ProcessStatus.ClearBit(procstateInfoMessage);// and $FFF9; // сбрасываем биты 1 и 2
  CMD.Panel.Output.ProcessStatus:=CMD.Panel.Output.ProcessStatus.ClearBit(procstateFailMessage);// and $FFF9;
  case DialogType of // Диалог на панели
    dNone   : ;// None
    dInfo   : CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus.SetBit(procstateInfoMessage);   // устанавливаем бит 1 - Info Meassage,Question
    dFail   : CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus.SetBit(procstateFailMessage);   // устанавливаем бит 2 - Fail Meassage,Question
    dReserv : begin
                //CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus or $0006;   // устанавливаем биты 1,2 - Reserved
                CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus.SetBit(procstateInfoMessage);   // устанавливаем бит 1 - Info Meassage,Question
                CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus.SetBit(procstateFailMessage);   // устанавливаем бит 2 - Fail Meassage,Question
              end;
  end;
  try
    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsCommonCheckUserAnswer,[Params]),'',cMsgRead,cMsgPriorityInf);
    Res:=0;
    if Assigned(OnUIAnswerForFailure)
      then Res:=OnUIAnswerForFailure(rsCommonCheckUserAnswer, Params, DialogType, CMD.Panel.Output.AccidentNumber); // Диалог на компе

    case Res of
      mrAbort:
        begin
          CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAnswerAbort,'',cMsgRead,cMsgPriorityInf);
          if Assigned(OnReceiveCommand_MeasureStopped) then OnReceiveCommand_MeasureStopped;
          TLD_Mode := modeNothing;
          iCMD := -1;
          ExecuteNextCommand;
        end;
      mrRetry:
        begin
          CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAnswerRetry,'',cMsgRead,cMsgPriorityInf);
          //iCMD := iCMD - 1;
          //if Commands[TLD_Mode][iCMD]=@Cmd.NNScan_Start_CS then iCMD := iCMD - 1; // Если проблема в оценке сканирования, то повторять нужно не оценку, а само сканирование
          iCMD := -1;
          ExecuteNextCommand;
        end;
      mrCancel:
        begin
          CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAnswerCancel,'',cMsgRead,cMsgPriorityInf);
          if Assigned(OnReceiveCommand_MeasureStopped) then OnReceiveCommand_MeasureStopped;
          TLD_Mode := modeIdle;
          iCMD := -1;
          ExecuteNextCommand;
        end;
      mrOk:
        begin
          CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAnswerOk,'',cMsgRead,cMsgPriorityInf);
          //if Assigned(OnReceiveCommand_MeasureStopped) then OnReceiveCommand_MeasureStopped;
          //TLD_Mode := modeIdle;
          iCMD := -1;
          ExecuteNextCommand;
        end;
      mrIgnore:
        begin
          CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAnswerCancel,'',cMsgRead,cMsgPriorityInf);
          //iCMD :=  -1;
          ExecuteNextCommand;
        end;
      else
        ExecuteNextCommand;
    end;
  finally
    //Timer.Enabled:=true;
  end;
end;

procedure tTLD_CommandSeries.CMD_CommonUI_CheckEndMeasure(Params: String; Tag: Int64);
//var
//  Res: integer;
begin
  CMD.SaveCallParams(Params, Tag);
  CMD_CommonUI_CheckUserAnswer(Format(rsCommonUICheckEnd,[CurrentProcessName]),cUI_EndMeasure);
{
  CMD.Panel.Output.AccidentNumber := 8; //cCNT_UI_EndMeasure -->8 в панели
  CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus and $FFF9;  // сбрасываем биты 1 и 2
  CMD.Panel.Output.ProcessStatus := CMD.Panel.Output.ProcessStatus or $0002;   // устанавливаем бит 2 - Info Meassage,Question
  //Timer.Enabled := false;
  try
    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsCommonCheckUserAnswer,[UIMessageString]),'',cMsgRead,cMsgPriorityInf);
    Res:=0;
    if Assigned(OnUIEndMeasure)
      then Res:=OnUIEndMeasure(rsCommonUITitle,rsCommonUICheckEnd);

    case Res of
      mrAbort:
        begin
          CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAnswerAbort,'',cMsgRead,cMsgPriorityInf);
          if Assigned(OnReceiveCommand_MeasureStopped) then OnReceiveCommand_MeasureStopped;
          TLD_Mode := modeIdle;
          iCMD := -1;
          ExecuteNextCommand;
        end;
      mrRetry:
        begin
          CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAnswerRetry,'',cMsgRead,cMsgPriorityInf);
          iCMD :=  -1;
          ExecuteNextCommand;
        end;
      mrOk:
        begin
          CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAnswerOk,'',cMsgRead,cMsgPriorityInf);
          if Assigned(OnReceiveCommand_MeasureStopped) then OnReceiveCommand_MeasureStopped;
          TLD_Mode := modeIdle;
          iCMD := -1;
          ExecuteNextCommand;
        end;
      mrCancel:
        begin
          CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAnswerCancel,'',cMsgRead,cMsgPriorityInf);
          if Assigned(OnReceiveCommand_MeasureStopped) then OnReceiveCommand_MeasureStopped;
          TLD_Mode := modeIdle;
          iCMD := -1;
          ExecuteNextCommand;
        end;
      mrIgnore:
        begin
          CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAnswerCancel,'',cMsgRead,cMsgPriorityInf);
          ExecuteNextCommand;
        end;
      else
        ExecuteNextCommand;
    end;
  finally
    //Timer.Enabled:=true;
  end;
}
end;

procedure tTLD_CommandSeries.CMD_OutputUI_StartMeasure(Params: String; Tag: Int64);//   - Информирование MainForm программы о начале измерения кассеты
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;
  if Assigned(Cmd) and Assigned(Cmd.OnTLDMeasuring) then Cmd.OnTLDMeasuring(True);
  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_OutputUI_StopMeasure(Params: String; Tag: Int64);//   - Информирование MainForm программы об окончании измерения кассеты
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;
  if Assigned(Cmd) and Assigned(Cmd.OnTLDMeasuring) then Cmd.OnTLDMeasuring(False);
  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonUI_CloseStartMFWindow(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  if Assigned(OnReceiveCommand_CloseStartMFWindow) then OnReceiveCommand_CloseStartMFWindow;
  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckSystem(Params: String; Tag: Int64);//   - Проверка необходимости инициализировать моторы - запуск инициализации если обнаружена потребность
var
  i: integer;
  InitRequired: boolean;
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckMotorsInit,'',cMsgRead,cMsgPriorityInf);

  // если эмуляция - проскакиваем сразу
  if isEmulator then
  begin
    ExecuteNextCommand;
    Exit;
  end;

  // Установлена ли целевая температура в элементе Пельтье?
  //if Cmd.MonitorBoard.TargetTemperature<>Cmd.MonitorBoard.TargetTempFromIni*10 then // не прописалась температура в Пельтье
  if Abs(Cmd.PMT.Temp_setpoint-Cmd.PMT.TargetTempFromIni)>0.1 then // не соответствует инишке - не прописалась температура в Пельтье из инишки
  begin
    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',format(rsTargetPMTTempFailure,[Cmd.PMT.Temp_setpoint,Cmd.PMT.TargetTempFromIni]),'',cMsgRead,cMsgPriorityInf);
    CMD_CommonGoInit('',0);
    Exit;
  end;

  // Проинициализирована ли плата управления шаговыми двигателями?
  InitRequired:= false;
  for i:=1 to 5 do
    if Cmd.Motors.ReadMotor[i].Status = 4 then
      InitRequired:= true;
  if InitRequired then
  begin
    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsInitRequired,'',cMsgRead,cMsgPriorityInf);
    if Assigned(OnReceiveCommand_MeasureStopped) then OnReceiveCommand_MeasureStopped;
    CMD_CommonGoMotorsInit('',0);
    Exit;
  end;

  // Нет ли ошибки в плате управления шаговыми двигателями?
  if Cmd.Motors.Common_Status<>0 then
  begin
    CMD_CommonUI_CheckUserAnswer(Format(rsFailureMotorsCommon,[CMD.Motors.Common_Status]),cUI_MotorsBoardFail);
    Exit;
  end;

  // Установлен ли фильтр?
  if Cmd.Motors.DigitalInput and $0001 = 0 then
  begin
    CMD_CommonUI_CheckUserAnswer(rsCheckFiltrFailure,cUI_FilterFail);
    Exit;
  end;

  //Контроль положения каретки
  if Cmd.Panel.Output.Motors_D1_Position>=5 then
  begin
    if (Cmd.Motors.ReadMotor[2].Message and $4000 <> 0) then // Кассетница А опущена
    begin
      iCMD:=iCMD-1; // выполняем доп.операцию и возвращаемся сюда же
      Cmd.NNMotors_Go2To1_CS('',0); // поднимаем перед перемещением
      Exit;
    end;
    if (Cmd.Motors.ReadMotor[3].Message and $4000 <> 0) then // Кассетница Б опущена
    begin
      iCMD:=iCMD-1; // выполняем доп.операцию и возвращаемся сюда же
      Cmd.NNMotors_Go3To1_CS('',0); // поднимаем перед перемещением
      Exit;
    end;
    if (Cmd.Motors.ReadMotor[2].Message and $4000 = 0) and // Кассетница А поднята
       (Cmd.Motors.ReadMotor[3].Message and $4000 = 0) then // Кассетница Б поднята
    begin
      CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsMotorsGo4Required,'',cMsgRead,cMsgPriorityInf);
      iCMD:=iCMD-1; // выполняем доп.операцию и возвращаемся сюда же
      Cmd.NNMotors_Go1To4_CS('',0);
      Exit;
    end;
  end;

  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckCassA_Up(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckMotor2,'',cMsgRead,cMsgPriorityInf);
  if Cmd.Motors.ReadMotor[2].Message and $4000 <> 0 then
  begin
    Cmd.NNMotors_Go2To1_CS('',0);
  end
    else ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckCassB_Up(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckMotor3,'',cMsgRead,cMsgPriorityInf);
  if Cmd.Motors.ReadMotor[3].Message and $4000 <> 0 then
  begin
    Cmd.NNMotors_Go3To1_CS('',0);
  end
    else ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckScan4Empty(Params: String; Tag: Int64);
var
  i,Test: integer;
  S: string;
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckScan4Empty,'',cMsgRead,cMsgPriorityInf);

  // если эмуляция - проскакиваем сразу
  if isEmulator then
  begin
    ExecuteNextCommand;
    Exit;
  end;

  Test:=0;
  for i:=0 to CMD.Scaner.BarCodeLength-1 do
    Test := Test or CMD.Scaner.BarCode[i];

  if (CMD.BarCodeString='40404040N') or (CMD.BarCodeString='404040N') or (CMD.BarCodeString='404040') or (CMD.BarCodeString='40404040')
  then // штрихкод подложки
  begin   //нет кассеты, читается штрихкод из каретки
    ExecuteNextCommand;
  end
    else
  if (Test = 0) then //нет кассеты, но нет и каретки - сбой позиционирования каретки или сбой сканера
  begin
    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsNoCheckScan,'',cMsgRead,cMsgPriorityInf);
    CMD_CommonUI_CheckUserAnswer(rsCommonBadScan,cUI_BadScan);
  end
    else //код распознан - кассета в наличии
      begin // - сбрасываем, её не должно быть
        CMD_CommonCallPushOut('',0);
      end;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckAir(Params: String; Tag: Int64); // проверка только на первом заходе, так как продувку включаем только на первом заходе
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckAir,'',cMsgRead,cMsgPriorityInf);
  if CMD.isFirstTimeStart and ((CMD.AirHeat.Flow[2] <= CMD.cMinFlow) or (CMD.AirHeat.Flow[3] <= CMD.cMinFlow)) then // аварийная остановка из-за малой прокачки на температуре
  begin
    CMD.NNAccident(accLowFlow);
    //CMD_CommonUI_CheckUserAnswer(rsCommonUICheckEnd,cUI_EndMeasure);
    Exit; // Прерываем цикл запросов
  end
    else ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonGoInit(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonGoInit,'',cMsgRead,cMsgPriorityInf);
  TLD_Mode := modeInitiation;
  iCMD:=-1;
  //ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonGoIdle(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  if Tag>0 then
  begin
    CMD_CommonUI_CheckUserAnswer(Params, Tag);
  end;
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonGoIdle,'',cMsgRead,cMsgPriorityInf);
  TLD_Mode := modeIdle;
  iCMD:=-1;
  //ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonGoMotorsInit(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonGoMotorsInit,'',cMsgRead,cMsgPriorityInf);
  TLD_Mode := modeMotorsInit;
  iCMD:=-1;
  //ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonGoSwapping(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonGoSwapping,'',cMsgRead,cMsgPriorityInf);
  TLD_Mode := modeGrading;
  iCMD:=-1;
  //ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCallPushOut(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.Panel.Output.ProcessStatus:=Cmd.Panel.Output.ProcessStatus.SetBit(procstateWasPushOut);

  Cmd.CNTQuery:=cCNTCommon;;
  PreviosMode := TLD_Mode;
  PreviosCMD := iCMD;

  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonGoPushOut,'',cMsgRead,cMsgPriorityInf);
  TLD_Mode := modePushOut;
  iCMD:=-1;
  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCall(Params: String; Tag: Int64);
var
  bufTLD_Mode: TTLD_Mode;
begin
  CMD.SaveCallParams(Params, Tag);
  for bufTLD_Mode:=Low(TTLD_Mode) to High(TTLD_Mode) do
  if GetEnumName(TypeInfo(TTLD_Mode),ord(bufTLD_Mode))=Params then
  begin
    Cmd.CNTQuery:=cCNTCommon;;
    PreviosMode := TLD_Mode;
    PreviosCMD := iCMD;

    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',format(rsCommonCall,[Params,GetEnumName(TypeInfo(TTLD_Mode),ord(TLD_Mode)),iCMD]),'',cMsgRead,cMsgPriorityInf);
    TLD_Mode := bufTLD_Mode;
    iCMD:=-1;
    ExecuteNextCommand;
    break;
  end;
end;

procedure tTLD_CommandSeries.CMD_CommonReturn(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',Format(rsCommonReturn,[TLD_Mode, PreviosMode, PreviosCMD]),'',cMsgRead,cMsgPriorityInf);
  TLD_Mode := PreviosMode;
  iCMD := PreviosCMD;
  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonShutDown(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  AllowExit:=True;
  Halt(0);
end;

procedure tTLD_CommandSeries.TimerStop;
begin
  Timer.Enabled:=False;

end;

procedure tTLD_CommandSeries.TimerGo;
begin
  //Cmd.SendPacketTime:=Now;
  Timer.Enabled:=True;
end;

procedure tTLD_CommandSeries.CMD_CommonGoMeasuring(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonGoMeasuring,'',cMsgRead,cMsgPriorityInf);
  TLD_Mode := modeMeasuring;
  iCMD:=-1;
  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonGoProcessNumber(Params: String; aProcessNumber: Int64);
begin
  CMD.SaveCallParams(Params, aProcessNumber);
  Cmd.CNTQuery:=cCNTCommon;;
  case TProcessType(aProcessNumber) of
    cIdle            : TLD_Mode := modeIdle;
    cStartSingleMeas : TLD_Mode := modeMeasuring;
    cStartSeriaMeas  : TLD_Mode := modeMeasuring;
    cStartCalibration: TLD_Mode := modeCalybrDosimeters;
    cTesting         : TLD_Mode := modeGrading;
    cBurning         : TLD_Mode := modeBurning;
    cIrradiation     : TLD_Mode := modeIrradiation;
    cGrading         : TLD_Mode := modeIdle; { #todo -oЧернышев : добавить режимы Grading, Registration }
    cRegistration    : TLD_Mode := modeIdle;
  end;

  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : ',UpperCase(CurrentProcessName),'',cMsgRead,cMsgPriorityInf);

  iCMD:=-1;
  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCallMotorsToStart(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  PreviosMode := TLD_Mode;
  PreviosCMD := iCMD;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCallMotorsToStart,'',cMsgRead,cMsgPriorityInf);
  TLD_Mode := modeMotorsToStart;
  iCMD:=-1;
  ExecuteNextCommand;
end;

//procedure tTLD_CommandSeries.CMD_CommonReturnIfCheckMotorsAtStart(Params: String; Tag: Int64);
//begin
  //Cmd.CNTQuery:=cCNTCommon;;
  //if True // Всякие проверки текущих датчиков
  //then
  //  begin
  //    CMD.OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonMotorsStarted,'',cMsgRead,cMsgPriorityInf);
  //    TLD_Mode := PreviosMode;
  //    iCMD := PreviosCMD;
  //    ExecuteNextCommand;
  //  end
  //else
  //  begin
  //    UIMessageString := rsMotorsFailure;
  //    Cmd.CNTQuery:=cCNTCommon;
  //    CMD_CommonUI_CheckUserAnswer;
  //  end;
//end;

//procedure tTLD_CommandSeries.CMD_CommonCallCheckAir(Params: String; Tag: Int64);
//begin
//  Cmd.CNTQuery:=cCNTCommon;;
//  PreviosMode := TLD_Mode;
//  PreviosCMD := iCMD;
//  CMD.OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCallCheckAir,'',cMsgRead,cMsgPriorityInf);
//  TLD_Mode := modeCheckAir;
//  iCMD:=-1;
//
//  ExecuteNextCommand;
//end;

procedure tTLD_CommandSeries.CMD_CommonCallDelay(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  PreviosMode := TLD_Mode;
  PreviosCMD := iCMD;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCallDelay,'',cMsgRead,cMsgPriorityInf);
  TLD_Mode := modeDelay;
  iCMD:=-1;

  CMD.StartTime:=Now;

  ExecuteNextCommand;
end;
{
procedure tTLD_CommandSeries.SetConnectedFlag(aConnectedFlag: boolean);
begin
  if aConnectedFlag <> FConnectedFlag then
  begin
    FConnectedFlag:=aConnectedFlag;

    //if aConnectedFlag then
    //  CMd.OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsConnectionIsOn,'',cMsgNone,cMsgPriorityInf)
    //else
    //  CMd.OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsNoAnswer,'',cMsgNone,cMsgPriorityInf);

    //if Cmd.COMPortSyn.Connected then Cmd.COMPortSyn.Connected:=false;

    //if OnChangeConnectionState<>Nil then OnChangeConnectionState(not aConnectedFlag);   // передаем событие на главную форму (почему-то false-есть связь)
  end;

end;
}

destructor tTLD_CommandSeries.Destroy;
begin
  Timer.Free;
end;

procedure tTLD_CommandSeries.ExecuteNextCommand;
var
  i : integer;
begin
  Assert(True);

  Assert(TLD_Mode>=Low(Commands));
  Assert(TLD_Mode<=High(Commands));

  i := iCMD; // индекс текущей команды

  i:=i+1; // индекс следующей команды
  if i>High(Commands[TLD_Mode]) then i:=Low(Commands[TLD_Mode]);

  if TLD_Mode<>modeNothing then
  begin
    Assert(i>=Low(Commands[TLD_Mode]));
    Assert(i<=High(Commands[TLD_Mode]));
    iCMD := i;
    if Commands[TLD_Mode][iCMD]<> Nil
      then Commands[TLD_Mode][iCMD]('',0);  // Вызов процедуры запроса
  end;
end;

procedure tTLD_CommandSeries.ExecuteRepeatCommand;
begin
  if TLD_Mode=modeNothing then Exit;
  if (iCMD=-1) then
  begin
    ExecuteNextCommand;
    Exit;
  end;

  if Assigned(Commands[TLD_Mode][iCMD]) then // Исключения, при которых повтор делать не надо
    if   (Commands[TLD_Mode][iCMD]=@CMD_CommonChooseMode)
      or (Commands[TLD_Mode][iCMD]=@CMD_CommonUI_CheckEndMeasure)
      or (Commands[TLD_Mode][iCMD]=@CMD_CommonUI_CheckUserAnswer)
        //or (TLD_Mode=modeIdle)
        //or (TLD_Mode=modeInitiation)
    then
      begin
        ExecuteNextCommand;
        Exit;
      end;

  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonRepeat,'',cMsgRead,cMsgPriorityInf);
  if TLD_Mode<>modeNothing then
    if Commands[TLD_Mode][iCMD]<> Nil
      then Commands[TLD_Mode][iCMD]('',0);  // Вызов процедуры запроса
end;

procedure tTLD_CommandSeries.DeviceStartMeasures(aMeasuresMode: integer);
begin
  Cmd.CNTQuery:=cCNTCommon;;
  CMD_CommonGoMeasuring('',0);
end;

procedure tTLD_CommandSeries.DeviceStopEmergency;
begin
  Cmd.CNTQuery:=cCNTCommon;;
  Cmd.NNStopMeasuring;
  CMD_CommonGoIdle('',0);
end;

function tTLD_CommandSeries.CMD_GetCommandIndex(aTLD_Mode: TTLD_Mode;
  beginIndex: integer; FindCommand: TCommand): integer;
var
  i: integer;
begin
  result:=-1;
  for i:=beginIndex to High(Commands[aTLD_Mode]) do
  if Commands[aTLD_Mode][i]=FindCommand then
  begin
    result:=i;
    Break;
  end;
end;

procedure tTLD_CommandSeries.CMD_CommonSkip(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonSkipNextIfNotFirst(Params: String;
  Tag: Int64);
begin // Вывод делаем по флагу инициализации основного двигателя
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckMotorsInit,'',cMsgRead,cMsgPriorityInf);

  // Проинициализирована ли плата управления шаговыми двигателями?
  if (Cmd.Motors.ReadMotor[1].Status <> 4) then
  begin
    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsFirstTimeStarted,'',cMsgRead,cMsgPriorityInf);
    CMD.isFirstTimeStart:=False;
    ExecuteSkip(1);
  end
    else
      CMD.isFirstTimeStart:=True;

  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.ExecuteSkip(Steps: integer);
begin
  Cmd.CNTQuery:=cCNTCommon;;
  iCMD := iCMD + Steps;
  if iCMD>High(Commands[TLD_Mode]) then iCMD := High(Commands[TLD_Mode]);
  if iCMD<Low(Commands[TLD_Mode]) then iCMD := Low(Commands[TLD_Mode]);
  //ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCheckEndMeasure(Params: String; Tag: Int64);
var
  i,Skip: integer;
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCheckEndMeasure,'',cMsgRead,cMsgPriorityInf);
  if (Cmd.Algorithms.CurrentCarretePosition = carDet23) and (Cmd.ChangeData.DetectorCount<=2) or
     (Cmd.Algorithms.CurrentCarretePosition = carDet14) and (Cmd.ChangeData.DetectorCount>=3) then // EndMeasure
  begin
    try
      Timer.Enabled:=false; // Если обработка затянется - это не должно разрушить логику, отключим на всякий случай таймер
      try
        if Assigned (OnEndMeasure) then OnEndMeasure(Cmd.Algorithms.CurrentCarretePosition,true);
      finally
        Timer.Enabled:=true;
      end;
    except
    end;
    if (Cmd.Algorithms.CurrentCarretePosition = carDet23) then // Измерение закончено
    begin // поиск индекса для перехода к следующему измерению
      //ExecuteSkip(12); // перепрыгиваем измерение второй пары (GOTO)
      Skip:=0;
      for i:=iCMD+1 to High(Commands[TLD_Mode]) do
      if Commands[TLD_Mode][i]=@CMD_CommonCheckEndMeasure then
      begin
        Skip:=i - iCMD;
        Break;
      end;
      ExecuteSkip(Skip); // перепрыгиваем измерение второй пары (GOTO)
    end;
  end
    else
      try
        Timer.Enabled:=false; // Если обработка затянется - это не должно разрушить логику, отключим на всякий случай таймер
        try
          if Assigned (OnEndMeasure) then OnEndMeasure(Cmd.Algorithms.CurrentCarretePosition,false);
        finally
          Timer.Enabled:=true;
        end;
      except
      end;

  ExecuteNextCommand;
end;

procedure tTLD_CommandSeries.CMD_CommonCallBurningIfNeed(Params: String; Tag: Int64);
begin
  CMD.SaveCallParams(Params, Tag);
  Cmd.CNTQuery:=cCNTCommon;;
  CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonCallBurning,'',cMsgRead,cMsgPriorityInf);
  Cmd.StartTime:=Now; // Для ожидания окончания
  if Cmd.ChangeData.Detectors[Cmd.Algorithms.CurrentCarretePosition].time_burn>0 then
  begin
    CMD.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonBurningOn,'',cMsgRead,cMsgPriorityInf);
    PreviosMode := TLD_Mode;
    PreviosCMD := iCMD;

    TLD_Mode := modeBurning;
    iCMD:=-1;
    ExecuteNextCommand;
  end
    else ExecuteNextCommand;
end;

constructor tTLD_CommandSeries.Create(aCmd: tTLD_Auto);
begin
  Cmd := aCmd;
  PreviosMode := modeIdle;                // Предыдущий режим (используется для подпрограмм когда нужно)
  PreviosCMD := 0;                        // Предыдущий индекс (используется для подпрограмм когда нужно)
  AllowExit := false;
  //FConnectedFlag:=false;
  DisableScaner:=false;
  ManualBarCode:='';
  isEmulator:=false;
  SetCurrentProcess(cInit);
  TLD_Mode := modeInitiation;
  if CMD.IsTranslatorServer then TLD_Mode := modeNothing;
  iCMD := -1;

  Commands[modeIdle] := [            // ОЖИДАНИЕ - проверки системы, ожидание запуска какого-либо процесса
    @Cmd.NNMotors_ReadBase_CS,
    @Cmd.NNAirHeat_ReadTemp_CS,
    @Cmd.NNPMT_ReadBase_CS,
    @Cmd.NNScan_ReadBase_CS,
    @CMD_CommonCheckSystem,          //   - Проверка необходимости инициализировать моторы - запуск инициализации если обнаружена потребность
    @Cmd.NNPanel_WinBase_CS,
    @CMD_CommonChooseMode
  ];

  Commands[modeMotorsInit] :=[       // ИНИЦИАЛИЗАЦИЯ всех шаговых двигателей
    @Cmd.NNPanel_WinMotors_CS,
    @Cmd.NNMotors_PL1Off_CS,
    @Cmd.NNMotors_PL2Off_CS,
    @Cmd.NNMotors_PL1On_CS,
    @Cmd.NNMotors_PL2On_CS,
    @CMD_CommonCallDelay,            // Задержка чтобы успело подняться напряжение до нужного уровня (Игорь говорит 15 секунд), установливается в Cmd.NNMotors_PL2On_CS

    @Cmd.NNMotors_Init5_253_CS,
    @Cmd.NNMotors_Init4_253_CS,
    @Cmd.NNMotors_Init1_253_CS,
    @Cmd.NNMotors_Init2_253_CS,
    @Cmd.NNMotors_Init1_253_CS,
    @Cmd.NNMotors_Init3_253_CS,
    @Cmd.NNMotors_Init1_252_CS,
    @Cmd.NNMotors_Init1_251_CS,

    @Cmd.NNMotors_Go2To1_CS,         // добавка для исключения неправильной инициализации язычка выталкивателя
    @Cmd.NNMotors_Go3To1_CS,
    @Cmd.NNMotors_Go1To1_CS,
    @Cmd.NNMotors_Init4_253_CS,

    @Cmd.NNScan_Start_CS,            // Сканировать штрихкод .. Первая инициациация сканера - попытка побороть хроническое первичное невыполнение команды после старта
    @CMD_CommonGoIdle
  ];

  Commands[modeMotorsToStart] := [   // - 2 DEL ?
    @Cmd.NNPanel_WinMotors_CS,
    @Cmd.NNMotors_Go2To1_CS,
    @Cmd.NNMotors_Go3To1_CS,
    @Cmd.NNMotors_Go1To1_CS,
    @Cmd.NNMotors_ReadBase_CS,
    @CMD_CommonCheckCassAB_Up,
    @CMD_CommonReturn                //   - Возврат в режим, из которого вызвали
    //CMD_CommonReturnIfCheckMotorsAtStart
  ];

  Commands[modeInitiation]  := [     // ИНИЦИАЛИЗАЦИЯ УСТАНОВКИ
    @Cmd.NNMotors_GetDeviceID_CS,
    @Cmd.NNMotors_PL1On_CS,
    @Cmd.NNMotors_PL2On_CS,

    @Cmd.NNMotors_ReadBase_CS,
    @Cmd.NNAirHeat_CheckAir_CS,
    @CMD_CommonSkipNextIfNotFirst,
    @CMD_CommonSkip,                 // вместо старт пока идут игры без газа
    //@Cmd.NNAirHeat_Start_CS,       // Старт

    @Cmd.NNPanel_WinBase_CS,
    @Cmd.NNAirHeat_ReadTemp_CS,
    @Cmd.NNPMT_SetPeltierTemp_CS,
    @Cmd.NNPMT_ReadBase_CS,
    @Cmd.NNScan_Start_CS,
    @CMD_CommonCheckSystem,          //   - Проверка необходимости инициализировать моторы - запуск инициализации если обнаружена потребность
    @CMD_CommonCheckCassA_Up,        // - Проверка состояния ШД2 - он должен быть в положении ВЕРХ, поднять вверх при необходимости
    @CMD_CommonCheckCassB_Up,        // - Проверка состояния ШД3 - он должен быть в положении ВЕРХ, поднять вверх при необходимости
    @Cmd.NNMotors_Go1To4_CS,         // - На проверку наличия кассеты
    @Cmd.NNScan_ReadBase_CS,         // - Чтение Скан
    @Cmd.NNScan_Start_CS,            // - Старт Скан - чтобы сканер очнулся при первом обращении
    @CMD_CommonCheckScan4Empty,      // - Проверка состояния считанного кода со сканера - он должен быть N404040 - иначе или сбой, или запустится подпрограмма сброса (нужно сбросить старый застрявший дозиметр)
    @Cmd.NNMotors_Go1To1_CS,         // отъезжаем подальше чтоб не мешаться опусканию кассет
    @Cmd.NNMotors_Go2To2_CS,         // опускаем для проверки
    @Cmd.NNMotors_Go3To2_CS,         // опускаем для проверки
    @Cmd.NNMotors_ReadBase_CS,       // чтение состояния для проверки наличия кассетниц
    @CMD_CommonCheckCassA_Down,      // продолжаем только при наличии кассетницы А
    @CMD_CommonCheckCassB_Down,      // продолжаем только при наличии кассетницы Б
    @Cmd.NNMotors_Go2To1_CS,         // поднимаем обратно
    @Cmd.NNMotors_Go3To1_CS,         // поднимаем обратно
    @Cmd.NNMotors_ReadBase_CS,       // чтение состояния для проверки удачного поднятия
    @CMD_CommonCheckCassAB_Up,       // продолжаем только если всё ОК

    //@CMD_CommonCallCheckAir,       // Проверка потока воздуха
    @Cmd.NNAirHeat_ReadTemp_CS,
    @CMD_CommonCheckAir,
    @Cmd.NNAirHeat_Stop_CS,          // Принудительная остановка измерения
    //@CMD_CommonReturn,

    //@Cmd.NNMotors_Go1To1_CS,       // Каретку в начальное положение   // - может лучше в 4 или 5?
    @CMD_CommonGoIdle
  ];

  Commands[modeBurning] := [
    @Cmd.NNAirHeat_WriteProfBurn_CS, // профиль отжига
    @Cmd.NNAirHeat_Start_CS,         // Старт
    @Cmd.NNAirHeat_CoolingDown_CS,   // Ожидание остывания по температуре
    //@CMD_CommonGoDelay               // возврат из Delay - вернёт куда надо, а двойной вызов подпрограммы работать не будет
    @CMD_CommonReturn                // возврат из Delay - вернёт куда надо, а двойной вызов подпрограммы работать не будет
  ];

  Commands[modeCheckAir] := [
    @Cmd.NNAirHeat_CheckAir_CS,      // Запись низкотемпературного профиля для контроля потока
    @Cmd.NNAirHeat_Start_CS,         // Старт
    @CMD_CommonDelay5,               // Задержка 5 сек
    @Cmd.NNAirHeat_ReadTemp_CS,      // Читаем температуру и поток
    @CMD_CommonCheckAir,             // Если поток ниже нормы - блокируем работу
    @CMD_CommonReturn                // Возврат из подпрограммы
  ];

  Commands[modeMeasuring] := [
    @Cmd.NNPanel_WinMotors_CS,       // Motors --> UserPanel
    @CMD_CommonCheckSystem,          // Общая проверка состояния установки перед началом измерения
    @Cmd.NNMotors_PosMonitoring_CS,  // периодическое контрольное перемещение в 1 (начальное положение + потом будет контроль механизмов позиционирования)

    @Cmd.NNMotors_Go1To4_CS,         // обеспечить позицию кассеты не под кассетницей
    @Cmd.NNMotors_Go2To2_CS,         // опустить входную кассетницу А
    @CMD_CommonCheckCassA_Down,      // контроль
    @Cmd.NNMotors_Go1To6_CS,         // подъехать за кассетой в А
    @Cmd.NNMotors_Go1To4_CS,         // захват кассеты в А и переезд на чтение штрихкода
    @Cmd.NNPanel_WinScan_CS,         // Scan --> UserPanel
    @Cmd.NNScan_Start_CS,            // Сканировать штрихкод
    @CMD_CommonGetScan,              // Проверить и если ОК - инициировать передачу штрихкода в Main, если нет разбираемся
    @CMD_CommonCheckDosimeter,       // продолжение если дозиметр есть в базе

    //@Cmd.NNPMTBoardP1,               // чтение темнового тока
    //@CMD_CommonCheckDarkCurrent,     // продолжаем, если темновой ток ОК

    //@Cmd.NNMonitorM3,                // CI on (включаем подсветку)
    //@Cmd.NNPMTBoardP1,               // чтение тока от подсветки
    //@CMD_CommonCheckCICurrent,       // продолжаем, если ток от подсветки ОК
    //@Cmd.NNMonitorM2,                // CI off (выключаем подсветку)

    @CMD_OutputUI_StartMeasure,      // Показать в UI что началось измерение
    @Cmd.NNMotors_Go1To2_CS,         // под измерение 2,3
    @Cmd.NNPanel_WinKTV1_CS,         // KTV1 --> UserPanel
    //@Cmd.NNMotors_PL3Off_CS,         // Отключить Пельтье на момент измерения (подавление шумов от него)
    @Cmd.NNAirHeat_ReadTemp_CS,      // Прочитаем свежую температурку
    @Cmd.NNAirHeat_WriteProfMeas_CS, // Запись профиля нагрева
    //@Cmd.NNAirHeat_Start_CS,       // Старт
    @CMD.NNPMT_SetTime_CS,           // Запуск измерения КТВ
    @CMD.NNPMT_ReadChannels_CS,      // Last Start Read KTV
    @Cmd.NNAirHeat_Stop_CS,          // Стоп нагрева
    //@Cmd.NNMotors_PL3On_CS,          // Включить Пельтье обратно
    //@CMD_CommonSkip,                 //
    @CMD_CommonUI_CloseStartMFWindow,// Закрываем окошко
    @CMD_CommonCheckEndMeasure,      // проверка окончания измерения
    @CMD_CommonCallBurningIfNeed,    // Вызов подпрограммы отжига, если требуется
    @Cmd.NNAirHeat_CoolingDown_CS,   // Ожидание остывания по температуре

    @Cmd.NNMotors_Go1To3_CS,         // под измерение 1,4
    @Cmd.NNPanel_WinKTV2_CS,         // KTV2 --> UserPanel
    //@Cmd.NNMotors_PL3Off_CS,         // Отключить Пельтье на момент измерения (подавление шумов от него)
    @Cmd.NNAirHeat_ReadTemp_CS,      // Прочитаем свежую температурку
    @Cmd.NNAirHeat_WriteProfMeas_CS, // Запись профиля нагрева
    //@Cmd.NNAirHeat_Start_CS,         // Старт
    @CMD.NNPMT_SetTime_CS,           // Запуск чтения результатов измерения КТВ
    @CMD.NNPMT_ReadChannels_CS,      // Last Start Read KTV
    @Cmd.NNAirHeat_Stop_CS,          // Стоп нагрева
    //@Cmd.NNMotors_PL3On_CS,          // Включить Пельтье обратно
    @CMD_CommonSkip,                 //
    @CMD_CommonCheckEndMeasure,      // проверка окончания
    @CMD_CommonCallBurningIfNeed,    // Вызов подпрограммы отжига, если требуется
    @Cmd.NNAirHeat_CoolingDown_CS,   // Ожидание остывания по температуре

    @Cmd.NNMotors_Go3To2_CS,         // опускаем кассетницу Б
    @CMD_CommonCheckCassB_Down,      // контроль

    @Cmd.NNMotors_Go1To5_CS,         // едем и таким образом складываем кассету в кассетницу Б
    @Cmd.NNMotors_Go3To1_CS,         // поднимаем кассетницу Б
    @CMD_CommonCheckCassB_Up,        // контроль
    @Cmd.NNPanel_WinBase_CS,         // Основное окно --> UserPanel
    @CMD_CommonSkip,                 // Заглушка (для исключения странности IsPaused)
    //@CMD_OutputUI_StopMeasure,       // Показать в UI что измерение завершено
    //@CMD_CommonCallMotorsToStart,    // Моторы к началу
    @CMD_CommonSkip,                 // Заглушка (для исключения странности IsPaused)
    @CMD_CommonChooseMode            // Выход
  ];

  Commands[modeGrading] := [
    @Cmd.NNMotors_ReadBase_CS,
    @CMD_CommonCheckBeforeSwapping,
    @Cmd.NNMotors_Go1To4_CS,
    @Cmd.NNMotors_Go3To2_CS,
    @Cmd.NNMotors_Go1To5_CS,
    @Cmd.NNMotors_Go1To4_CS,
    @Cmd.NNMotors_Go3To1_CS,
    @Cmd.NNScan_Start_CS,
    //@CMD_CommonGetScan,                // ? Проверить и если ОК - инициировать передачу штрихкода в Main, если нет разбираемся
    @CMD_CommonCheckDosimeter,
    @Cmd.NNMotors_Go2To2_CS,
    @Cmd.NNMotors_Go1To6_CS,
    @Cmd.NNMotors_Go2To1_CS,
    @CMD_CommonChooseMode
  ];

  Commands[modePushOut] := [
    @Cmd.NNMotors_Go1To5_CS,
    @Cmd.NNMotors_Go4To1_CS,
    @Cmd.NNMotors_Go1To4_CS,             // Перед выходом позиционируемся обратно к сканеру - на проверку наличия кассеты
    @CMD_CommonReturn
  ];

  Commands[modeDelay] := [
    //@Cmd.NNPMTBoardP1,
    @Cmd.NNAirHeat_ReadTemp_CS,
    @CMD_CommonReturnIfEndTime
  ];

  Commands[modeFailBitCar]  := [
    @Cmd.NNMotors_Go1To6_CS,
    @Cmd.NNMotors_Go1To4_CS,
    @Cmd.NNScan_Start_CS,
    @CMD_CommonReturn
  ];

  Commands[modeIrradiation]  := [
  @Cmd.NNPanel_WinMotors_CS,
  @CMD_CommonCheckSystem,                //   - Проверка необходимости инициализировать моторы - запуск инициализации если обнаружена потребность
  @Cmd.NNMotors_PosMonitoring_CS,        // периодическое контрольное перемещение в 1 (начальное положение + потом будет контроль механизмов позиционирования)

  @Cmd.NNMotors_Go2To2_CS,               // опустить входную кассетницу А
  @CMD_CommonCheckCassA_Down,            // контроль
  @Cmd.NNMotors_Go1To6_CS,               // подъехать за кассетой в А
  @Cmd.NNMotors_Go1To4_CS,               // захват кассеты в А и переезд на чтение штрихкода

  @Cmd.NNPanel_WinScan_CS,
  @Cmd.NNScan_Start_CS,                  // Сканировать штрихкод
  @CMD_CommonGetScan,                    // Проверить и если ОК - инициировать передачу штрихкода в Main, если нет разбираемся
  @CMD_CommonCheckDosimeter,             // продолжение, если дозиметр есть в базе

  @Cmd.NNMotors_Go3To2_CS,               // опускаем кассетницу Б
  @CMD_CommonCheckCassB_Down,            // контроль

  @Cmd.NNMotors_Go1To1_CS,               // под облучатель
  @Cmd.NNMotors_Go5To2_CS,               // открыть заслонку
  @CMD_CommonWaitIrradiation,            // Задержка на установлененое время
  @Cmd.NNMotors_Go5To1_CS,               // закрыть заслонку


  @Cmd.NNMotors_Go1To5_CS,               // едем и таким образом складываем кассету в кассетницу Б
  @Cmd.NNMotors_Go3To1_CS,               // поднимаем кассетницу Б
  @CMD_CommonCheckCassB_Up,              // контроль
  @Cmd.NNPanel_WinBase_CS,

  @CMD_OutputUI_StopMeasure,             // Показать в UI что измерение завершено

  @CMD_CommonChooseMode                  // Выход
  ];
  Commands[modeCalybrIrrad]  := [
    @CMD_CommonChooseMode
  ];
  Commands[modeCalybrDosimeters]  := [
    @CMD_CommonChooseMode
  ];

  Commands[modeExit]  := [          // Завершение работы, снятие напряжения, предложение пользователю выключить установку
  @Cmd.NNMotors_Go2To1_CS,
  @Cmd.NNMotors_Go3To1_CS,
  @Cmd.NNMotors_Go1To4_CS,
  @Cmd.NNMotors_PL1Off_CS,
  @Cmd.NNMotors_PL2Off_CS,
  @Cmd.NNPanel_WinPowerOff_CS,
  @CMD_CommonShutDown
  //@CMD_CommonGoIdle
  ];


  Cmd.OnSuccesExecute                 := @OnSuccesExecuteLastCommand;
  Cmd.OnCMDAccident                   := @OnCMDAccident;

  OnChooseMode                        := Nil;
  OnChangeConnectionState             := Nil;
  OnMeasureScanDosimeter              := Nil;
  OnChangeTLDMode                     := Nil;
  OnChangeiCMD                        := Nil;
  OnEndMeasure                        := Nil;
  OnReceiveCommand_CloseStartMFWindow := Nil;
  OnReceiveCommand_MeasureStopped     := Nil;
  OnUIAnswerForFailure                := Nil;
  OnManualScanerEntered               := Nil;


  Timer:=TTimer.Create(nil);         // создание таймера для опроса
  Timer.Interval := 500;             // интервал опроса
  Timer.OnTimer := @OnTimer;         // процедура, работающая по срабатыванию таймера
  Timer.Enabled := True;
end;

end.

