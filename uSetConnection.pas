unit uSetConnection;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ELSE}
  {$ENDIF}
  LCLType,
  Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, Buttons, StdCtrls,
  StrUtils,
  ExtCtrls,
  Synaser,
  uLanguages;

type
  TSetW = class(TForm)
    CBComPort: TComboBox;
    CBBaudRate_: TComboBox;
    GBCOMPort: TGroupBox;
    CBoxStopBit: TComboBox;
    CBParity: TComboBox;
    LabelPort: TLabel;
    LabelBaudRate: TLabel;
    LabelStopBit: TLabel;
    LabelParity: TLabel;
    PanelPortState: TPanel;
    BtnClose: TButton;
    procedure CBComPortKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButtonTestConnectionClick(Sender: TObject);
    procedure CBComPortChange(Sender: TObject);
    //procedure CBBaudRateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    function GetCOMPorts: String;
    procedure GetComPorts_old(aList: TStrings; aNameStart: String);
    //procedure ConnectionState; // проверка связи с COM-порта
    { Public declarations }
  end;

var
  SetW: TSetW;


implementation
uses Registry,
     uConst,
     uMainForm;
{$R *.dfm}

{uses
  uConst,
  uMainForm;}

function GetNextSubstring(aBuf: String; var aStartPos: integer): String;
var
  vLastPos: integer;
begin
  if (aStartPos < 1) then
    begin
      raise ERangeError.Create(rsErrStartPos0);
    end;

  if (aStartPos > Length(aBuf) ) then
    begin
      Result := '';
      Exit;
    end;

  vLastPos := PosEx(#0, aBuf, aStartPos);
  Result := Copy(aBuf, aStartPos, vLastPos - aStartPos);
  aStartPos := aStartPos + (vLastPos - aStartPos) + 1;
end;

function SortComPorts(ComList: string): string;
var
  SL: TStringList;
  St1,St2: string;
  i,j: integer;
begin
  SL := TStringList.Create;
  SL.CommaText := ComList;

  SL.Sort;
  result := SL.CommaText;
  SL.free;
end;

{$IFDEF MSWINDOWS}
function TSetW.GetCOMPorts: string;
var
  reg: TRegistry;
  l, v: TStringList;
  n: integer;
  ComList: string;
begin
  l := TStringList.Create;
  v := TStringList.Create;
  reg := TRegistry.Create;
  try
{$IFNDEF VER100}
{$IFNDEF VER120}
    reg.Access := KEY_READ;
{$ENDIF}
{$ENDIF}
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('\HARDWARE\DEVICEMAP\SERIALCOMM', false);
    reg.GetValueNames(l);
    for n := 0 to l.Count - 1 do
      v.Add(reg.ReadString(l[n]));
    ComList := v.CommaText;
  finally
    reg.Free;
    l.Free;
    v.Free;
  end;
  // добавить выделение активных
  result := ComList;
end;

{$ENDIF}
{$IFNDEF MSWINDOWS}
function TSetW.GetCOMPorts: string;
const
  cDev='/dev/';
var
  Index: Integer;
  Data: string;
  TmpPorts: String;
  sr : TSearchRec;
  ComList: string;
begin
  try
    TmpPorts := '';
    if FindFirst('/sys/class/tty/*', Longint($FFFFFFFF), sr) = 0 then
    begin
      repeat
        if (sr.Attr and $FFFFFFFF) = Sr.Attr then
          if DirectoryExists('/sys/class/tty/'+sr.Name+'/device/driver') then
            if not DirectoryExists('/sys/class/tty/'+sr.Name+'/device/driver/serial8250') then
            begin
              data := cDev+sr.Name;
              TmpPorts := TmpPorts + ',' + Data;
            end;
      until FindNext(sr) <> 0;
    end;
    FindClose(sr);
  finally
    ComList:=TmpPorts;
  end;
  if ComList<>'' then
    if ComList[1]=',' then
      ComList:=copy(ComList,2,length(ComList)-1);
  result := SortComPorts(ComList);
end;
{$ENDIF}

procedure TSetW.GetComPorts_old(aList: TStrings; aNameStart: String);   // процедура получения списка COM-портов, если aFlag-True: считываем список из ини-файла; если aFlag-False: выполняеи поиск доступных COM-портов на ПК
var
  vBuf: String;
  vRes: Integer;
  vErr: Integer;
  vBufSize: Integer;
  vNameStartPos: Integer;
  vName: String;
begin
  {$IFDEF MSWINDOWS}
  begin
    vBufSize := 1024 * 5;
    vRes := 0;

    while vRes = 0 do
      begin
        Setlength(vBuf, vBufSize) ;
        SetLastError(ERROR_SUCCESS);
        vRes := QueryDosDevice(nil, @vBuf[1], vBufSize) ;
        vErr := GetLastError();

        //Вариант для двухтонки
        if (vRes <> 0) and (vErr = ERROR_INSUFFICIENT_BUFFER) then
          begin
            vBufSize := vRes;
            vRes := 0;
          end;

        if (vRes = 0) and (vErr = ERROR_INSUFFICIENT_BUFFER) then
          begin
            vBufSize := vBufSize + 1024;
          end;

        if (vErr <> ERROR_SUCCESS) and (vErr <> ERROR_INSUFFICIENT_BUFFER) then
          begin
            raise Exception.Create(SysErrorMessage(vErr) );
          end
      end;
    SetLength(vBuf, vRes) ;

    vNameStartPos := 1;
    vName := GetNextSubstring(vBuf, vNameStartPos);

    aList.BeginUpdate();
    try
      aList.Clear();
      while vName <> '' do
        begin
          if pos(aNameStart, vName)=1 then
            aList.Add(vName);
          vName := GetNextSubstring(vBuf, vNameStartPos);
        end;
    finally
      aList.EndUpdate();
    end;
  end;
  {$ELSE}
  {$ENDIF}
end;

procedure TSetW.CBComPortChange(Sender: TObject);
begin
  MainForm.COMName:=CBComPort.Items[CBComPort.ItemIndex];
  MainForm.TLDCommand.COM:=CBComPort.Items[CBComPort.ItemIndex];
  //MainForm.TLDCommand.TLDConnect:=True;
  MainForm.TLDCommand.AnswerTime:=Now;
  //ConnectionState;
  //if MainForm.TLDCommand.ReceivePacketActive then
  //  MainForm.TLDCommand.ReceivePacketActive:=False;
end;

procedure TSetW.BtnCloseClick(Sender: TObject);
begin
  FreeAndNil(MainForm.TLDCommand.COMPortSyn);
end;

//procedure TSetW.CBBaudRateChange(Sender: TObject);
//begin
//  MainForm.TLDCommand.BaudRate:=StrToInt(CBBaudRate_.Items[CBBaudRate_.ItemIndex]);
//  ConnectionState;
//end;

procedure TSetW.CBComPortKeyPress(Sender: TObject; var Key: Char);
begin
  Key := Char(0);
end;
//
//procedure TSetW.ConnectionState;
//begin
//  if Assigned(MainForm.TLDCOmmand.COMPortSyn) then
//  begin
//    if MainForm.TLD_CommandSeries.ConnectedFlag then
//    begin
//      MainForm.LblComState.Caption:=rsOpenPort;
//      PanelPortState.Caption:=rsOpenPort;
//    end
//    else
//    begin
//      MainForm.LblComState.Caption:=rsCantOpenPort;
//      PanelPortState.Caption:=rsCantOpenPort;
//    end;
//  end;
//end;

procedure TSetW.FormShow(Sender: TObject);
begin
  if MainForm.TLDCommand.COM <> cEmulator then
  begin
    //GetComPorts(CBComPort.Items,'COM');
    CBComPort.ItemIndex:=CBComPort.Items.IndexOf(MainForm.TLDCommand.COM);
    //CBBaudRate_.ItemIndex:=CBBaudRate_.Items.IndexOf(IntToStr(MainForm.TLDCommand.BaudRate));
    //CBoxStopBit.ItemIndex:=MainForm.TLDCommand.StopBits;
    //CBParity.ItemIndex:=MainForm.TLDCommand.Parity;

    if MainForm.TLDCommand.ConnectedPort then
      PanelPortState.Caption:=rsOpenPort
    else
      PanelPortState.Caption:=rsCantOpenPort;
  end
  else
  begin
    CBComPort.Items.Clear;
    CBComPort.Items.Add(cEmulator);
    CBComPort.ItemIndex:=0;
    CBComPort.Enabled:=false;
    PanelPortState.Caption:=rsEmulator;
  end;

end;

procedure TSetW.SpeedButtonTestConnectionClick(Sender: TObject);
begin
//  MainForm.COMName:=ComboBoxComPort.Items[ComboBoxComPort.ItemIndex];
//  MainForm.TLDModBus.ChangePort(ComboBoxComPort.Items[ComboBoxComPort.ItemIndex]);
//  MainForm.TLDModBus.ReceivePacketActive:=False;

  {if MainForm.TLDModBus.ConnectedPort then
    MainForm.OnConnectionState('Порт открыт',MainForm.TLDModBus.COMName)
  else
    MainForm.OnConnectionState('Неудалось открыть порт',MainForm.TLDModBus.COMName);}

end;

end.
