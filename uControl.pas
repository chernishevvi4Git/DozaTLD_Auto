unit uControl;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs,
  Buttons, StdCtrls, Menus,
  Math,
  uLanguages,
  uDetector,
  uConst,
  uTLDCommand, TaSeries, ExtCtrls, Spin, ComCtrls, ValEdit, IdTCPClient,
  TAGraph;
type

  { TControlW }

  TControlW = class(TForm)
    Button_AirHeat_ReadAll1: TButton;
    Button_AirHeat_ReadAll2: TButton;
    Button_Algorithm_TestEvent: TButton;
    Button_AirHeat_ReadAll: TButton;
    Button_AirHeat_WriteProfile: TButton;
    Button_AirHeat_WriteStatus: TButton;
    Button_Algorithm_Swapping: TButton;
    Button_Algorithm_PushOut: TButton;
    Button_Algorithm_WriteFile: TButton;
    Button_Monitor_ReadAll: TButton;
    Button_PMTNew_SetDevNumber: TButton;
    Button_PMTNew_GetDevNumber: TButton;
    Button_Monitor_WriteAll: TButton;
    Button_Monitor_WriteAll1: TButton;
    Button_PMTNew_SetCTime: TButton;
    Button_Motors_GoTo: TButton;
    Button_Motors_Init: TButton;
    Button_Motors_Init251: TButton;
    Button_Motors_Init252: TButton;
    Button_Algorithm_InitMotors: TButton;
    Button_Motors_PowerLine1Off: TButton;
    Button_PMTNew_DarkCurrentStart1: TButton;
    Button_PMTNew_Led1Off: TButton;
    Button_Motors_PowerLine1On: TButton;
    Button_PMTNew_Led2Off: TButton;
    Button_PMTNew_Led1On: TButton;
    Button_Motors_PowerLine2Off: TButton;
    Button_Motors_PowerLine3Off: TButton;
    Button_Motors_PowerLine2On: TButton;
    Button_Motors_PowerLine3On: TButton;
    Button_Motors_ReadBase: TButton;
    Button_Motors_ReadParams1: TButton;
    Button_Motors_ReadParams2: TButton;
    Button_Motors_Stop: TButton;
    Button_Motors_WriteDigitalOutput: TButton;
    Button_Algorithm_Read: TButton;
    Button_Motors_WriteParams4One: TButton;
    Button_Motors_WriteParams2EEPROM: TButton;
    Button_Motors_WriteStat: TButton;
    Button_Panel_Save: TButton;
    Button_Algorithm_ReadAll: TButton;
    Button_Algorithm_Write: TButton;
    Button_PMTNew_PeltierOff: TButton;
    Button_PMTNew_Led2On: TButton;
    Button_PMTNew_PeltierOn: TButton;
    Button_PMTNew_ReadBase: TButton;
    Button_PMTNew_SetTime: TButton;
    Button_PMTNew_RereadKTV: TButton;
    Button_PMTNew_Start: TButton;
    Button_PMTNew_DarkCurrentStart: TButton;
    Button_PMT_ReadAll: TButton;
    Button_PMT_WriteAll: TButton;
    Button_ScanBoard_ReadAll: TButton;
    Button_Panel_ReadAll: TButton;
    ChartControl: TChart;
    CheckBox_Algorithm_IsEmulator: TCheckBox;
    CheckBox_Algorithm_ConnectionAirHeat: TCheckBox;
    CheckBox_Algorithm_ConnectionMonitor: TCheckBox;
    CheckBox_Algorithm_ConnectionPMT: TCheckBox;
    CheckBox_Algorithm_ConnectionPMTNew: TCheckBox;
    CheckBox_Algorithm_ConnectionScaner: TCheckBox;
    CheckBox_Algorithm_ConnectionPanel: TCheckBox;
    CheckBox_Algorithm_UseChooseCB: TCheckBox;
    CheckBox_Algorithm_ConnectionMotors: TCheckBox;
    CheckBox_Motors_PowerLine3: TCheckBox;
    CheckBox_Motors_IgnoreErrors: TCheckBox;
    CheckBox_AirHeat_OldVersion: TCheckBox;
    CheckBox_PMTNew_Led1: TCheckBox;
    CheckBox_PMTNew_Led2: TCheckBox;
    CheckBox_PMTNew_Peltier: TCheckBox;
    CheckBox_PMTNew_Measuring: TCheckBox;
    CheckBox_Scaner_Disable: TCheckBox;
    CheckBox_Motors_PS5: TCheckBox;
    CheckBox_Panel_DontUse: TCheckBox;
    CheckBox_Scaner_DisableOnlyOne: TCheckBox;
    CheckGroup_AirHeat_Position: TCheckGroup;
    ComboBox_Algorithm_VarType: TComboBox;
    Edit_AirHeat_ErrorCode: TEdit;
    Edit_Algorithm_CurrentCmdString: TEdit;
    Edit_Algorithm_RemoteCOM_IP: TEdit;
    Edit_Algorithm_EventNumber: TEdit;
    ComboBox_Algorithm_Parameter: TComboBox;
    CSeriesSRC1: TLineSeries;
    CSeriesGlade2: TLineSeries;
    Edit_Algorithm_HexValue: TEdit;
    Edit_PMTNew_ControlTime: TEdit;
    Edit_PMTNew_DevNumber: TEdit;
    Edit_PMTNew_CurrentTemp_Ch2: TEdit;
    Edit_PMTNew_DarkCurrent1: TEdit;
    Edit_PMTNew_DarkCurrent2: TEdit;
    Edit_PMTNew_CurrentTemp_Ch1: TEdit;
    Edit_PMTNew_LedCurrent1: TEdit;
    Edit_PMTNew_LedCurrent2: TEdit;
    Edit_PMTNew_TargetTemperature: TEdit;
    Edit_Motors_EEPROMCounter: TEdit;
    Edit_Motors_StatKorrMax: TEdit;
    Edit_Motors_StatKorrMin: TEdit;
    Edit_Motors_StatErr: TEdit;
    Edit_Motors_StatTo1: TEdit;
    Edit_Motors_StatMoves: TEdit;
    Edit_Motors_DeviceNumber: TEdit;
    Edit_Motors_Results: TEdit;
    Edit_Motors_NumVars: TEdit;
    Edit_Algorithm_CurrentCmdID: TEdit;
    Edit_Algorithm_Address: TEdit;
    Edit_Algorithm_Value: TEdit;
    Edit_Motors_StatKorrAvg: TEdit;
    Edit_PMTNew_CP1: TEdit;
    Edit_PMTNew_CP2: TEdit;
    Edit_Panel_BaseAdr: TEdit;
    Edit_Panel_Length: TEdit;
    Edit_PMTNew_LastNumber1: TEdit;
    Edit_PMTNew_LastNumber2: TEdit;
    Edit_PMTNew_MeasureTime: TEdit;
    Edit_ScanBoard_BarCodeManual: TEdit;
    GroupBox1: TGroupBox;
    LblDevAirError: TLabel;
    LblDevNumber33: TLabel;
    LblDevNumber35: TLabel;
    LblDevNumber37: TLabel;
    LblDevNumber43: TLabel;
    LblDevNumber44: TLabel;
    LblDevNumber45: TLabel;
    LblDevNumber46: TLabel;
    LblDevNumber47: TLabel;
    LblDevNumber48: TLabel;
    LblDevNumber49: TLabel;
    LblDevNumber50: TLabel;
    LblDevNumber51: TLabel;
    LblDevNumber52: TLabel;
    LblDevNumber53: TLabel;
    LblDevNumber54: TLabel;
    LblDevNumber55: TLabel;
    LblDevNumber56: TLabel;
    LblDevNumber57: TLabel;
    LblDevNumber58: TLabel;
    LblDevNumber59: TLabel;
    LblDevNumber60: TLabel;
    LblDevNumber61: TLabel;
    LblDevNumber62: TLabel;
    LblDevNumber63: TLabel;
    LblDevNumber65: TLabel;
    LblDevNumber66: TLabel;
    LblDevNumber67: TLabel;
    LblDevNumber68: TLabel;
    PLogSaveToFile: TMenuItem;
    PLogPause: TMenuItem;
    Panel1: TPanel;
    CSeriesSRC2: TLineSeries;
    CheckBox_Motors_OP0: TCheckBox;
    CheckBox_Motors_OP1: TCheckBox;
    CheckBox_Motors_OP2: TCheckBox;
    CheckBox_Motors_OP3: TCheckBox;
    CheckBox_Motors_OP4: TCheckBox;
    CheckBox_Motors_OP5: TCheckBox;
    CheckBox_Motors_PowerLine1: TCheckBox;
    CheckBox_Motors_PowerLine2: TCheckBox;
    CheckBox_Motors_PS1: TCheckBox;
    CheckBox_Motors_PS2: TCheckBox;
    CheckBox_Motors_PS3: TCheckBox;
    CheckBox_Motors_PS4: TCheckBox;
    CheckBox_ScanBoard_MainChannelStatus: TCheckBox;
    CheckBox_ScanBoard_Recognised: TCheckBox;
    ComboBox_Algorithm_Choose: TComboBox;
    Edit_AirHeat_Flow1: TEdit;
    Edit_AirHeat_Flow2: TEdit;
    Edit_AirHeat_Flow3: TEdit;
    Edit_AirHeat_Flow4: TEdit;
    Edit_AirHeat_HeatRate: TEdit;
    Edit_AirHeat_HeatTemp: TEdit;
    Edit_AirHeat_HeatTime: TEdit;
    Edit_AirHeat_Mode: TEdit;
    Edit_AirHeat_PreHeatRate: TEdit;
    Edit_AirHeat_PreHeatTemp: TEdit;
    Edit_AirHeat_PreHeatTime: TEdit;
    Edit_AirHeat_Pressure: TEdit;
    Edit_AirHeat_Status: TEdit;
    Edit_AirHeat_Temperature1: TEdit;
    Edit_AirHeat_Temperature2: TEdit;
    Edit_AirHeat_Temperature3: TEdit;
    Edit_AirHeat_Temperature4: TEdit;
    Edit_Monitor_CurrentTemperature: TEdit;
    Edit_Monitor_RLCIntencity1: TEdit;
    Edit_Monitor_RLCIntencity2: TEdit;
    Edit_Monitor_RLCIntencity3: TEdit;
    Edit_Monitor_RLCIntencity4: TEdit;
    Edit_Monitor_TargetTemperature: TEdit;
    Edit_Motors_CommonStatus: TEdit;
    Edit_Motors_Inputs: TEdit;
    Edit_Motors_Outputs: TEdit;
    Edit_Motors_ProtocolVersion: TEdit;
    Edit_PMTBoard_CounterTriggering: TEdit;
    Edit_PMTBoard_CPS: TEdit;
    Edit_PMTBoard_DeviceAddress: TEdit;
    Edit_PMTBoard_HVFineAdjustment1: TEdit;
    Edit_PMTBoard_HVFineAdjustment2: TEdit;
    Edit_PMTBoard_HVInitialValue1: TEdit;
    Edit_PMTBoard_HVInitialValue2: TEdit;
    Edit_PMTBoard_MeasureCount1: TEdit;
    Edit_PMTBoard_MeasureCount2: TEdit;
    Edit_PMTBoard_MeasureTime: TEdit;
    Edit_PMTBoard_PreHeatCount1: TEdit;
    Edit_PMTBoard_PreHeatCount2: TEdit;
    Edit_PMTBoard_PreheatTime: TEdit;
    Edit_PMTBoard_RealTimeCount1: TEdit;
    Edit_PMTBoard_RealTimeCount2: TEdit;
    Edit_PMTBoard_UID1: TEdit;
    Edit_PMTBoard_UID2: TEdit;
    Edit_ScanBoard_BarCodeLength: TEdit;
    Edit_ScanBoard_BarCode: TEdit;
    GroupBoxLog: TGroupBox;
    LblDevNumber1: TLabel;
    LblDevNumber10: TLabel;
    LblDevNumber11: TLabel;
    LblDevNumber12: TLabel;
    LblDevNumber13: TLabel;
    LblDevAirStatus: TLabel;
    LblDevAirMode: TLabel;
    LblDevNumber16: TLabel;
    LblDevNumber17: TLabel;
    LblDevNumber18: TLabel;
    LblDevNumber19: TLabel;
    LblDevNumber2: TLabel;
    LblDevNumber20: TLabel;
    LblDevNumber21: TLabel;
    LblDevNumber22: TLabel;
    LblDevNumber23: TLabel;
    LblDevNumber24: TLabel;
    LblDevNumber25: TLabel;
    LblDevNumber26: TLabel;
    LblDevNumber27: TLabel;
    LblDevNumber28: TLabel;
    LblDevNumber29: TLabel;
    LblDevNumber3: TLabel;
    LblDevNumber30: TLabel;
    LblDevNumber31: TLabel;
    LblDevNumber32: TLabel;
    LblDevNumber34: TLabel;
    LblDevNumber36: TLabel;
    LblDevNumber38: TLabel;
    LblDevNumber39: TLabel;
    LblDevNumber4: TLabel;
    LblDevNumber40: TLabel;
    LblDevNumber41: TLabel;
    LblDevNumber5: TLabel;
    LblDevNumber6: TLabel;
    LblDevNumber7: TLabel;
    LblDevNumber8: TLabel;
    LblDevNumber9: TLabel;
    LblMeas1: TLabel;
    LblMeas2: TLabel;
    Label_Motors_Info: TLabel;
    MemoCommandLog: TMemo;
    MemoLog: TMemo;
    PageControl1: TPageControl;
    PopupMenuLog: TPopupMenu;
    PLogClear: TMenuItem;
    LabelIT: TLabel;
    LabelTC: TLabel;
    ProgressBar_Motors_Go: TProgressBar;
    CSeriesGlade1: TLineSeries;
    CSeriesInterestRegion: TAreaSeries;
    CSeriesTempProfil: TLineSeries;
    LogSaveDialog: TSaveDialog;
    RadioButton_PMTNew_Car23: TRadioButton;
    RadioButton_PMTNew_Car14: TRadioButton;
    Separator1: TMenuItem;
    SE_MotorNumber: TSpinEdit;
    SE_MotorPoint: TSpinEdit;
    BtnGoIdle: TSpeedButton;
    SpeedBtnStop: TSpeedButton;
    Splitter1: TSplitter;
    Tabcontrol_Motors_Options: TTabControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TGButton_Algorithm_RemoteCOMGo: TToggleBox;
    ValueListEditor_Motors_Commands: TValueListEditor;
    ValueListEditor_Motors_Options: TValueListEditor;
    ValueListEditor_Motors_Statuses: TValueListEditor;
    ValueListEditor_ScanBoard_BarCode: TValueListEditor;
    ValueListEditor_UserPanel_Data: TValueListEditor;
    procedure BtnGoIdleClick(Sender: TObject);
    procedure Button_AirHeat_ReadAll1Click(Sender: TObject);
    procedure Button_AirHeat_ReadAll2Click(Sender: TObject);
    procedure Button_AirHeat_ReadAllClick(Sender: TObject);
    procedure Button_AirHeat_WriteProfileClick(Sender: TObject);
    procedure Button_AirHeat_WriteStatusClick(Sender: TObject);
    procedure Button_Algorithm_RemoteCOMGoClick(Sender: TObject);
    procedure Button_Algorithm_InitMotorsClick(Sender: TObject);
    procedure Button_Algorithm_MeasuringClick(Sender: TObject);
    procedure Button_Algorithm_PushOutClick(Sender: TObject);
    procedure Button_Algorithm_ReadAllClick(Sender: TObject);
    procedure Button_Algorithm_ReadClick(Sender: TObject);
    procedure Button_Algorithm_SwappingClick(Sender: TObject);
    procedure Button_Algorithm_TestEventClick(Sender: TObject);
    procedure Button_Algorithm_WriteClick(Sender: TObject);
    procedure Button_Algorithm_WriteFileClick(Sender: TObject);
    procedure Button_PMTNew_GetDevNumberClick(Sender: TObject);
    procedure Button_Monitor_ReadAllClick(Sender: TObject);
    procedure Button_PMTNew_SetCTimeClick(Sender: TObject);
    procedure Button_PMTNew_SetDevNumberClick(Sender: TObject);
    procedure Button_Monitor_WriteAll1Click(Sender: TObject);
    procedure Button_Monitor_WriteAllClick(Sender: TObject);
    procedure Button_Motors_Init251Click(Sender: TObject);
    procedure Button_Motors_Init252Click(Sender: TObject);
    procedure Button_Motors_PowerLine3OffClick(Sender: TObject);
    procedure Button_Motors_PowerLine3OnClick(Sender: TObject);
    procedure Button_Motors_ReadStatisticClick(Sender: TObject);
    procedure Button_Motors_WriteParams2EEPROMClick(Sender: TObject);
    procedure Button_Motors_WriteParams4OneClick(Sender: TObject);
    procedure Button_Motors_WriteStatClick(Sender: TObject);
    procedure Button_Panel_InitClick(Sender: TObject);
    procedure Button_Panel_ReadAllClick(Sender: TObject);
    procedure Button_Panel_SaveClick(Sender: TObject);
    procedure Button_PMTNew_DarkCurrentStart1Click(Sender: TObject);
    procedure Button_PMTNew_DarkCurrentStartClick(Sender: TObject);
    procedure Button_PMTNew_Led1OffClick(Sender: TObject);
    procedure Button_PMTNew_Led1OnClick(Sender: TObject);
    procedure Button_PMTNew_Led2OffClick(Sender: TObject);
    procedure Button_PMTNew_Led2OnClick(Sender: TObject);
    procedure Button_PMTNew_PeltierOffClick(Sender: TObject);
    procedure Button_PMTNew_PeltierOnClick(Sender: TObject);
    procedure Button_PMTNew_ReadBaseClick(Sender: TObject);
    procedure Button_PMTNew_RereadKTVClick(Sender: TObject);
    procedure Button_PMTNew_SetTimeClick(Sender: TObject);
    procedure Button_PMTNew_StartClick(Sender: TObject);
    procedure Button_PMT_ReadAllClick(Sender: TObject);
    procedure Button_PMT_WriteAllClick(Sender: TObject);
    procedure Button_ScanBoard_ReadAllClick(Sender: TObject);
    procedure CheckBox_AirHeat_OldVersionChange(Sender: TObject);
    procedure CheckBox_Algorithm_IsEmulatorChange(Sender: TObject);
    procedure CheckBox_Motors_IgnoreErrorsChange(Sender: TObject);
    //procedure CheckBox_AirHeat_IsEmulatorChange(Sender: TObject);
    procedure CheckBox_Panel_DontUseChange(Sender: TObject);
    procedure CheckBox_Scaner_DisableChange(Sender: TObject);
    procedure CheckBox_Algorithm_UseChooseCBChange(Sender: TObject);
    procedure ComboBox_Algorithm_ChooseChange(Sender: TObject);
    procedure Edit_Algorithm_ValueChange(Sender: TObject);
    procedure Edit_ScanBoard_BarCodeManualChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PLogPauseClick(Sender: TObject);
    procedure PLogSaveToFileClick(Sender: TObject);
    procedure SE_MotorNumberChange(Sender: TObject);
    procedure MemoLogChange(Sender: TObject);
    procedure MemoCommandLogChange(Sender: TObject);
    procedure PLogClearClick(Sender: TObject);
    procedure Button_Motors_GoToClick(Sender: TObject);
    procedure Button_Motors_InitClick(Sender: TObject);
    procedure Button_Motors_PowerLine1OffClick(Sender: TObject);
    procedure Button_Motors_PowerLine1OnClick(Sender: TObject);
    procedure Button_Motors_PowerLine2OffClick(Sender: TObject);
    procedure Button_Motors_PowerLine2OnClick(Sender: TObject);
    procedure Button_Motors_ReadBaseClick(Sender: TObject);
    procedure Button_Motors_ReadParams1Click(Sender: TObject);
    procedure Button_Motors_ReadParams2Click(Sender: TObject);
    procedure Button_Motors_StopClick(Sender: TObject);
    procedure Button_Motors_WriteDigitalOutputClick(Sender: TObject);

    procedure OnMotorsReadProgress(aMotorID: integer);   // После чтения текущего прогресса команды перемещения мотора
    procedure OnMotorsReadBase;                          // После чтения состояния моторной платы
    procedure OnMotorsSetPosition(aMotorID: integer);    // После позиционирования шагового двигателя
    procedure OnMotorsStop(aMotorID: integer);           // После аварийной остановки шагового двигателя
    procedure OnMotorsInit(aMotorID: integer);           // После инициализация шагового двигателя
    procedure OnMotorsReadRWParams1;                     // После считывания записываемых параметров моторного блока (РЕГИСТРЫ 40-46)
    procedure OnMotorsReadRWParams2;                     // После считывания записываемых параметров моторного блока (РЕГИСТРЫ 101-172)
    procedure OnAirHeatReadAll;                          // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ ПЛАТЫ НАГРЕВАТЕЛЯ ВОЗДУХА
    procedure OnMonitorReadAll;                          // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ МОНИТОРА
    procedure OnPMTBoardReadAll;                         // ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ ФЭУ
    procedure OnPMTBoardWriteAll;                        // ЗАПИСАТЬ ВСЕ ПАРАМЕТРЫ ФЭУ
    procedure OnPMTNewReadBase;                          // ПРОЧИТАТЬ ПАРАМЕТРЫ НОВОГО ФЭУ
    procedure OnPMTNewReadKTV;                           // ПРОЧИТАТЬ КТВ
    procedure OnPMTNewGetDevNumber;                      // ПРОЧИТАТЬ DEVICE NUMBER
    //procedure OnScanBoardStartRead;                      // ЗАПУСК ЧТЕНИЯ ШТРИХКОДА
    procedure OnScanBoardReadBase;                       // ПРОЧИТАТЬ СОСТОЯНИЕ ГОТОВНОСТИ ВЫПОЛНЕНИЯ ЧТЕНИЯ ШТРИХКОДА
    procedure OnScanBoardReadBarCode;                    // ВЕРНУТЬ ШТРИХКОД
    procedure OnChooseMode;                              // Смена режима на заданный
    procedure OnManualScanerEntered;                     // После использования подменной строки при чтении сканером
    //procedure On;


    procedure SE_MotorPointChange(Sender: TObject);
    procedure OnChangeiCMD(aiCMD: integer; Addr: Pointer);    // После изменения номера команды
    procedure SpeedBtnStopClick(Sender: TObject);
    procedure Tabcontrol_Motors_OptionsChange(Sender: TObject);
    procedure TGButton_Algorithm_RemoteCOMGoChange(Sender: TObject);

  private
    procedure ClearChart;
    procedure SaveTxtResult(aName: String; Ktv: String; Tmp: String);
    function GetValByAdr(anAdr: dword; anDevType: word): string;

    { Private declarations }
  public

    { Public declarations }
  end;

var
  ControlW: TControlW;

const
  cLogMaxStrings = 10000;


implementation
{$R *.dfm}

uses
  uTLDCommandSeries,
  uSeparator,
  uFunctions,
  IdModBusClient,
  uMainForm;

procedure TControlW.SaveTxtResult(aName: String; Ktv: String; Tmp: String);
var
  i         : integer;
  ts1       : TStringList;
  ts2       : TStringList;
  FileName  : String;
  myFile    : TextFile;
begin
  ts1:=nil;
  ts2:=nil;

  if Ktv<>'{}' then
  begin
    ts1:=TStringList.Create;
    ts1.Delimiter:=',';                                        // устанавливаем разделитель
    ts1.DelimitedText:=Ktv;
    ts1.Text:=StringReplace(ts1.Text,'{','',[rfreplaceall]);    // удаляем фигурные скобки
    ts1.Text:=StringReplace(ts1.Text,'}','',[rfreplaceall]);
  end;

  if Tmp<>'{}' then
  begin
    ts2:=TStringList.Create;
    ts2.Delimiter:=',';                                        // устанавливаем разделитель
    ts2.DelimitedText:=Tmp;
    ts2.Text:=StringReplace(ts2.Text,'{','',[rfreplaceall]);    // удаляем фигурные скобки
    ts2.Text:=StringReplace(ts2.Text,'}','',[rfreplaceall]);
  end;

  if (ts1<>nil) and (ts2<>nil) then
  begin
    if (ts1.Count>0) and (ts2.Count>0) then
    begin
      FileName := Name+'.txt';
      AssignFile(MyFile, FileName);
      ReWrite(MyFile);
      for i := 0 to ts1.Count-1 do
      begin
        WriteLn(MyFile,IntToStr(i+1)+' '+ts1[i]+' '+FloatToStrRegion(RoundToCN(StrToFloatRegion(ts2[i]),-2)));
      end;
    end;
  end;

  CloseFile(MyFile);
  ts1.Free;
  ts2.Free;
end;

procedure TControlW.MemoCommandLogChange(Sender: TObject);
begin
  if MemoCommandLog.Lines.Count > cLogMaxStrings then
    MemoCommandLog.Lines.Clear;
end;

procedure TControlW.MemoLogChange(Sender: TObject);
begin
  if MemoLog.Lines.Count > cLogMaxStrings then
    MemoLog.Lines.Clear;
end;

procedure TControlW.PLogClearClick(Sender: TObject);
begin
  MemoLog.Clear;
  MemoCommandLog.Clear;
end;

procedure TControlW.Button_Motors_GoToClick(Sender: TObject);
begin
  ProgressBar_Motors_Go.Position:=0;
  MainForm.TLDCommand.NNMotorsSetPosition(cRunSingle,SE_MotorNumber.Value, SE_MotorPoint.Value);
end;

procedure TControlW.Button_Motors_InitClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotorsInit(SE_MotorNumber.Value);
end;

procedure TControlW.Button_Motors_Init251Click(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotors_Init1_251_CS('',1);
end;

procedure TControlW.Button_Motors_Init252Click(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotors_Init1_252_CS('',1);
end;

procedure TControlW.Button_Motors_ReadStatisticClick(Sender: TObject);
begin
end;

procedure TControlW.Button_Motors_WriteParams2EEPROMClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotorsWriteEEPROM;
end;

procedure TControlW.Button_Motors_WriteParams4OneClick(Sender: TObject);
var
  i,tc,nv: integer;
  St: string;
begin
  Button_Motors_WriteParams2EEPROM.Visible:=True;

  tc := Tabcontrol_Motors_Options.TabIndex + 1;

  MainForm.TLDCommand.Motors.WriteMotor[tc].MaxSteps := StrToInt(Edit_Motors_Results.Text);
  MainForm.TLDCommand.Motors.WriteMotor[tc].NumVars  := StrToInt(Edit_Motors_NumVars.Text);
  nv := min(10,MainForm.TLDCommand.Motors.WriteMotor[tc].NumVars);

  for i:=1 to nv do
  begin
    St := ValueListEditor_Motors_Options.Values['т.'+IntToStr(i)];
    if St<>'' then MainForm.TLDCommand.Motors.WriteMotor[tc].Vars[i] := StrToInt(St);
  end;

  MainForm.TLDCommand.NNMotorsWriteParams4One(tc);
end;

procedure TControlW.Button_Motors_WriteStatClick(Sender: TObject);
begin
  MainForm.TLDCommand.Motors.DeviceNumber     := StrToInt(Edit_Motors_DeviceNumber.Text);
  MainForm.TLDCommand.Motors.Stat_NumMoves    := StrToInt(Edit_Motors_StatMoves.Text);
  MainForm.TLDCommand.Motors.Stat_NumMovesTo1 := StrToInt(Edit_Motors_StatTo1.Text);
  MainForm.TLDCommand.Motors.Stat_NumErrMoves := StrToInt(Edit_Motors_StatErr.Text);
  MainForm.TLDCommand.Motors.StatCorr_Max     := StrToInt(Edit_Motors_StatKorrMax.Text);
  MainForm.TLDCommand.Motors.StatCorr_Min     := StrToInt(Edit_Motors_StatKorrMin.Text);
  MainForm.TLDCommand.Motors.StatCorr_Avg     := StrToInt(Edit_Motors_StatKorrAvg.Text);

  MainForm.TLDCommand.NNMotorsWriteStatParams;
end;

procedure TControlW.Button_Panel_InitClick(Sender: TObject);
begin
end;

procedure TControlW.Button_Panel_ReadAllClick(Sender: TObject);
var
  i: integer;
  WA: array of word;
  WRD: Word;
  MAdr,MLength : word;
begin
  //SetLength(WA,125);
  MLength:=StrToInt(Edit_Panel_Length.Text);
  MAdr:=StrToInt(Edit_Panel_BaseAdr.Text);
  SetLength(WA,MLength);
  MainForm.TLDCommand.ModbusClient.ReadHoldingRegisters(MAdr,MLength,WA);
  ValueListEditor_UserPanel_Data.Clear;
  for i:=0 to High(WA) do
  begin
    MainForm.TLDCommand.Panel.Input.WordArray[i]:=WA[i];
    ValueListEditor_UserPanel_Data.Values[IntToStr(i)]:=intToStr(WA[i]);
  end;
end;

procedure TControlW.Button_Panel_SaveClick(Sender: TObject);
var
  i: integer;
  WA: array of word;
  MAdr : word;
begin
  MAdr:=StrToInt(Edit_Panel_BaseAdr.Text);
  SetLength(WA,ValueListEditor_UserPanel_Data.RowCount-1);
  for i:=0 to High(WA) do
  begin
    WA[i]:=StrToInt(ValueListEditor_UserPanel_Data.Values[IntToStr(i)]);
    //MainForm.TLDCommand.Panel.WordArray[i]:=WA[i];
  end;
  MainForm.TLDCommand.ModbusClient.WriteRegisters(MAdr,WA);
end;

procedure TControlW.Button_PMTNew_DarkCurrentStart1Click(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMT_SrcCurStart_CS('',0);
end;

procedure TControlW.Button_PMTNew_DarkCurrentStartClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMT_DarkCurStart_CS('',0);
end;

procedure TControlW.Button_PMTNew_Led1OffClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMTSwitch(1,0);
end;

procedure TControlW.Button_PMTNew_Led1OnClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMTSwitch(1,1);
end;

procedure TControlW.Button_PMTNew_Led2OffClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMTSwitch(2,0);
end;

procedure TControlW.Button_PMTNew_Led2OnClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMTSwitch(2,1);
end;

procedure TControlW.Button_PMTNew_PeltierOffClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMTSwitch(3,0);
end;

procedure TControlW.Button_PMTNew_PeltierOnClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMTSwitch(3,1);
end;

procedure TControlW.Button_PMTNew_ReadBaseClick(Sender: TObject);
begin
  MainForm.TLDCommand.Algorithms.CurrentCarretePosition := carDet23;
  if RadioButton_PMTNew_Car14.Checked then MainForm.TLDCommand.Algorithms.CurrentCarretePosition := carDet14;
  MainForm.TLDCommand.NNPMT_ReadBase_CS('',cRunSingle);
end;

procedure TControlW.Button_PMTNew_RereadKTVClick(Sender: TObject);
var
  i: integer;
begin
  MainForm.TLDCommand.Algorithms.CurrentCarretePosition := carDet23;
  if RadioButton_PMTNew_Car14.Checked then MainForm.TLDCommand.Algorithms.CurrentCarretePosition := carDet14;
  MainForm.TLDCommand.PMT.CurrentReaded:=0;
  ClearChart;
  for i:=0 to 299 do  // переворачиваем
  begin
    MainForm.TLDCommand.PMT.Buffer_total[i].Channel1:=0;
    MainForm.TLDCommand.PMT.Buffer_total[i].Channel2:=0;
  end;

  MainForm.TLDCommand.NNPMT_ReadChannels_CS('',cRunSingle);
end;

procedure TControlW.Button_PMTNew_SetTimeClick(Sender: TObject);
begin
  MainForm.TLDCommand.Algorithms.CurrentCarretePosition := carDet23;
  if RadioButton_PMTNew_Car14.Checked then MainForm.TLDCommand.Algorithms.CurrentCarretePosition := carDet14;
  ClearChart;
  MainForm.TLDCommand.ChangeData.Detectors[MainForm.TLDCommand.Algorithms.CurrentCarretePosition].sumTimes:=StrToInt(Edit_PMTNew_MeasureTime.Text);
  MainForm.TLDCommand.NNPMT_SetTime_CS('',cRunSingle);
end;

procedure TControlW.Button_PMTNew_StartClick(Sender: TObject);
begin
  ClearChart;
  MainForm.TLDCommand.Algorithms.CurrentCarretePosition := carDet23;
  if RadioButton_PMTNew_Car14.Checked then MainForm.TLDCommand.Algorithms.CurrentCarretePosition := carDet14;
  MainForm.TLDCommand.NNPMTStart(cRunSingle);
end;

procedure TControlW.Button_Motors_PowerLine1OffClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotors_PL1Off_CS('',cRunSingle);
end;

procedure TControlW.Button_Motors_PowerLine1OnClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotors_PL1On_CS('',cRunSingle);
end;

procedure TControlW.Button_Motors_PowerLine2OffClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotors_PL2Off_CS('',cRunSingle);
end;

procedure TControlW.Button_Motors_PowerLine2OnClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotors_PL2On_CS('',cRunSingle);
end;

procedure TControlW.Button_Motors_PowerLine3OnClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotors_PL3On_CS('',cRunSingle);
end;

procedure TControlW.Button_Motors_PowerLine3OffClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotors_PL3Off_CS('',cRunSingle);
end;

procedure TControlW.Button_Motors_ReadBaseClick(Sender: TObject);
var
  i: integer;
begin
  MainForm.TLDCommand.NNMotors_ReadBase_CS('',cRunSingle);
end;

procedure TControlW.Button_Motors_ReadParams1Click(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotorsReadRWParams1;
end;

procedure TControlW.Button_Motors_ReadParams2Click(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotorsReadRWParams2;
end;

procedure TControlW.Button_Motors_StopClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotorsStop(SE_MotorNumber.Value);
end;

procedure TControlW.Button_Motors_WriteDigitalOutputClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNMotorsWriteDigitalOutput(StrToInt(Edit_Motors_Outputs.Text));
end;

procedure TControlW.OnMotorsReadProgress(aMotorID: integer);
begin
  ProgressBar_Motors_Go.Position := MainForm.TLDCommand.Motors.ReadMotor[aMotorID].Progress;
end;

procedure TControlW.OnMotorsReadBase;
var
  i: integer;
begin
  with MainForm.TLDCommand.Motors do
  begin
    Edit_Motors_ProtocolVersion.Text := IntToStr(Protocol);
    Edit_Motors_CommonStatus.Text := HexStr(Common_Status,4);
    Edit_Motors_Inputs.Text := HexStr(DigitalInput,4);
    Edit_Motors_Outputs.Text := HexStr(DigitalOutput,4);
    ValueListEditor_Motors_Statuses.Clear;
    for i:=1 to 6 do
    begin
      ValueListEditor_Motors_Statuses.Values[IntToStr(i)] := HexStr(ReadMotor[i].Status,4)+' - '+HexStr(ReadMotor[i].Message,4);
    end;

    CheckBox_Motors_PowerLine1.Checked := Power_Status and $01 <> 0;   // D0
    CheckBox_Motors_PowerLine2.Checked := Power_Status and $02 <> 0;   // D1
    CheckBox_Motors_PowerLine3.Checked := Power_Status and $03 <> 0;   // D2
    Button_Motors_PowerLine1On.Enabled := not CheckBox_Motors_PowerLine1.Checked;
    Button_Motors_PowerLine1Off.Enabled := CheckBox_Motors_PowerLine1.Checked;
    Button_Motors_PowerLine2On.Enabled := not CheckBox_Motors_PowerLine2.Checked;
    Button_Motors_PowerLine2Off.Enabled := CheckBox_Motors_PowerLine2.Checked;
    Button_Motors_PowerLine3On.Enabled := not CheckBox_Motors_PowerLine3.Checked;
    Button_Motors_PowerLine3Off.Enabled := CheckBox_Motors_PowerLine3.Checked;
    CheckBox_Motors_OP0.Checked := ReadMotor[1].Message and $2000 <> 0; // D13
    CheckBox_Motors_OP1.Checked := ReadMotor[2].Message and $4000 <> 0; // D14
    CheckBox_Motors_OP2.Checked := ReadMotor[3].Message and $4000 <> 0; // D14
    CheckBox_Motors_OP3.Checked := ReadMotor[4].Message and $4000 <> 0; // D14
    CheckBox_Motors_OP4.Checked := ReadMotor[5].Message and $4000 <> 0; // D14
    CheckBox_Motors_OP5.Checked := ReadMotor[5].Message and $8000 <> 0; // D15
    CheckBox_Motors_PS1.Checked := ReadMotor[1].Message and $4000 <> 0; // D14
    CheckBox_Motors_PS2.Checked := ReadMotor[1].Message and $8000 <> 0; // D15
    CheckBox_Motors_PS3.Checked := ReadMotor[2].Message and $8000 <> 0; // D15
    CheckBox_Motors_PS4.Checked := ReadMotor[3].Message and $8000 <> 0; // D15
    CheckBox_Motors_PS5.Checked := MainForm.TLDCommand.Motors.DigitalInput and $0001 <> 0; // D0 Input;
    ProgressBar_Motors_Go.Position := ReadMotor[SE_MotorNumber.Value].Progress;

    if CheckBox_Motors_OP1.Checked
    then CheckBox_Motors_PS3.Font.Style:=[]
    else CheckBox_Motors_PS3.Font.Style:=[fsStrikeOut];
    if CheckBox_Motors_OP2.Checked
    then CheckBox_Motors_PS4.Font.Style:=[]
    else CheckBox_Motors_PS4.Font.Style:=[fsStrikeOut];

  //Protocol         : word;                                //   0:    // версия протокола 1 - базовая
  //Common_Status    : word;                                //   1:
  //ReadMotor        : packed array[1..6] of TReadMotorData; //   2-19; // данные от шаговых двигателей
                                          //TReadMotorData = packed record
                                          //  Status    : word;
                                          //  Message   : word;
                                          //  Progress  : word;
                                          //end;
  //Power_Status    : word;                                 //   20:
  //DigitalOutput   : word;                                 //   21:   // цифровые выходы
  //DigitalInput    : word;                                 //   22:   // цифровые входы
  //Reserved1       : packed array [0..16] of word;         //   23:
  //Motor_Command   : packed array[1..6] of word;           //   40-45:
  //Power_Command   : word;                                 //   46:
  //Reserved2       : packed array [0..53] of word;         //   47:
  //WriteMotor      : packed array[1..6] of TWriteMotorData;//   101-172;
  end;
end;

procedure TControlW.OnMotorsSetPosition(aMotorID: integer);
begin
//
end;

procedure TControlW.OnMotorsStop(aMotorID: integer);
begin
//
end;

procedure TControlW.OnMotorsInit(aMotorID: integer);
begin
//
end;

procedure TControlW.OnMotorsReadRWParams1;
var
  i: integer;
begin
  with MainForm.TLDCommand.Motors do
  begin
    ValueListEditor_Motors_Commands.Clear;
    for i:=1 to 6 do
    begin
      ValueListEditor_Motors_Commands.Values[IntToStr(i)] := HexStr(Motor_Command[i],4);
    end;
    ValueListEditor_Motors_Commands.Values['Power'] := HexStr(Power_Command,4);
  end;
end;

procedure TControlW.OnMotorsReadRWParams2;
begin
  Button_Motors_ReadParams2.Enabled:=True;
  Tabcontrol_Motors_OptionsChange(Nil);
  with MainForm.TLDCommand.Motors do
  begin
    Edit_Motors_DeviceNumber.Text:=IntToStr(DeviceNumber);
    Edit_Motors_StatMoves.Text:=IntToStr(Stat_NumMoves);
    Edit_Motors_StatTo1.Text:=IntToStr(Stat_NumMovesTo1);
    Edit_Motors_StatErr.Text:=IntToStr(Stat_NumErrMoves);
    Edit_Motors_StatKorrMax.Text:=IntToStr(StatCorr_Max);
    Edit_Motors_StatKorrMin.Text:=IntToStr(StatCorr_Min);
    Edit_Motors_StatKorrAvg.Text:=IntToStr(StatCorr_Avg);
    Edit_Motors_EEPROMCounter.Text:=IntToStr(EEPROMCounter);
  end;
end;

procedure TControlW.OnAirHeatReadAll;
begin
  with MainForm.TLDCommand.AirHeat do
  begin
    Edit_AirHeat_Pressure.Text := IntToStr(Pressure);
    Edit_AirHeat_Temperature1.Text := FloatToStr(Temperature[1]/10);
    Edit_AirHeat_Temperature2.Text := FloatToStr(Temperature[2]/10);
    Edit_AirHeat_Temperature3.Text := FloatToStr(Temperature[3]/10);
    Edit_AirHeat_Temperature4.Text := FloatToStr(Temperature[4]/10);
    Edit_AirHeat_Flow1.Text := IntToStr(Flow[1]);
    Edit_AirHeat_Flow2.Text := IntToStr(Flow[2]);
    Edit_AirHeat_Flow3.Text := IntToStr(Flow[3]);
    Edit_AirHeat_Flow4.Text := IntToStr(Flow[4]);
    Edit_AirHeat_Status.Text := IntToStr(HeatStatus);
    Edit_AirHeat_Mode.Text := IntToStr(HeatMode);
    Edit_AirHeat_PreHeatTemp.Text := IntToStr(PreHeatTemperature);
    Edit_AirHeat_PreHeatTime.Text := IntToStr(PreHeatTime);
    Edit_AirHeat_PreHeatRate.Text := IntToStr(PreHeatRate);
    Edit_AirHeat_HeatTemp.Text := IntToStr(HeatTemperature);
    Edit_AirHeat_HeatTime.Text := IntToStr(HeatTime);
    Edit_AirHeat_HeatRate.Text := IntToStr(HeatRate);
    Edit_AirHeat_ErrorCode.Text := IntToStr(ErrorCode);

    // OLD Version
    //0x00 0x00	Pressure Reading	R	Deactivated
    //0x00 0x01	Thermocouple Channel 1 Temperature	R	Example: 0x1770 = 6000 -> 600.0℃
    //0x00 0x02	Thermocouple Channel 2 Temperature	R	Example: 0x1770 = 6000 -> 600.0℃
    //0x00 0x03	Thermocouple Channel 3 Temperature	R	Example: 0x1770 = 6000 -> 600.0℃
    //0x00 0x04	Thermocouple Channel 4 Temperature	R	Example: 0x1770 = 6000 -> 600.0℃
    //0x00 0x05	Flow Channle 1	R	Example: 0x07D0 = 2000 -> 2000CC/s
    //0x00 0x06	Flow Channle 2	R	Example: 0x07D0 = 2000 -> 2000CC/s
    //0x00 0x07	Flow Channle 3	R	Example: 0x07D0 = 2000 -> 2000CC/s
    //0x00 0x08	Flow Channle 4	R	Example: 0x07D0 = 2000 -> 2000CC/s
    //0x00 0x09	Heating status	R/W	"Channle 1 Enable: Heating status & 0x01
    //Channle 2 Enable: Heating status & 0x02
    //Channle 3 Enable: Heating status & 0x04
    //Channle 4 Enable: Heating status & 0x08
    //Channle 1 Status: Heating status & 0x0007
    //Channle 2 Status: Heating status & 0x0070
    //Channle 3 Status: Heating status & 0x0700
    //Channle 4 Status: Heating status & 0x7000
    //For each channle:
    //0 -> Ready
    //1 -> Preheating
    //2 -> Preheat Keep
    //3 -> Heating
    //4 -> Heat Keep
    //5 -> Wait Cooling"
    //0x00 0x0A	Heat Mode	R/W	Deactivated
    //0x00 0x0B	Preheat Temperature	R/W	Example: 0x00 0x87 = 135 -> 135℃
    //0x00 0x0C	Preheat Rate	R/W	Example: 0x00 0x19 = 25 -> 25℃/s
    //0x00 0x0E	Preheat Time	R/W	Example: 0x00 0x19 = 25 -> 25 s
    //0x00 0x0F	Heat Temperature	R/W	Example: 0x00 0xF0 = 240 -> 240℃
    //0x00 0x10	Heat Rate	R/W	Example: 0x00 0x19 = 25 -> 25℃/s
    //0x00 0x11	Heat Time	R/W	Example: 0x00 0x19 = 25 -> 25 s

    // NEW Version
    // 04 Function
    //Register    Address    Register Name    R/W    Description and Conversion    Example
    //0x0000    Thermocouple CH1    Temperature    R    Example: 0x1770 = 6000 -> 600.0    degC
    //0x0001    Thermocouple CH2    Temperature    R    Example: 0x1770 = 6000 -> 600.0    degC
    //0x0002    Thermocouple CH3    Temperature    R    Example: 0x1770 = 6000 -> 600.0    degC
    //0x0003    Thermocouple CH4    Temperature    R    Example: 0x1770 = 6000 -> 600.0    degC
    //0x0004    Flow CH1    R    Example: 0x03E8 = 1000
    //0x0005    Flow CH2    R    Example: 0x03E8 = 1000
    //0x0006    Flow CH3    R    Example: 0x03E8 = 1000
    //0x0007    Flow CH4    R    Example: 0x03E8 = 1000
    //0x0008    HeatStatus    R    See the HeatStatus bit definition    below
    //0x0009    Pressure    R    Reserved
    //0x000A    ErrorCode    R    See the ErrorCode bit definition below
    // 03 Function
    //Register    Address    Register    Name    R/W    Range    Default    Description
    //0x0000    preHeatTemp    R/W    50-200    135    Preheat temperature. Example:    0x0087 -> 135 degC
    //0x0001    preHeatRate    R/W    Fixed    15    15    Only accepts 0x000F
    //0x0002    preHeatTime    R/W    0-60    8    Unit: seconds. Write 0 to skip    preheat hold
    //0x0003    HeatTemp    R/W    100-    500    270    Heating temperature. Example:    0x010E -> 270 degC
    //0x0004    HeatRate    R/W    Fixed    15    15    Only accepts 0x000F
    //0x0005    HeatTime    R/W    1-120    20    Unit: seconds
    //0x0006    Position    R/W    0x00-    0x0F    0    Channel selection bit mask
    //0x0007    HeatingCtrl    R/W    0-1    0    Write 0 to stop and 1 to start. Read    returns 1 if any channel is heating,    otherwise 0
  end;
end;

procedure TControlW.OnMonitorReadAll;
begin
{
  with MainForm.TLDCommand.MonitorBoard do
  begin
    Edit_Monitor_CurrentTemperature.Text := FloatToStr(CurrentTemperature/10);
    Edit_Monitor_TargetTemperature.Text := FloatToStr(TargetTemperature/10);
    Edit_Monitor_RLCIntencity1.Text := FloatToStr(ReferenceLight[1]/10);
    Edit_Monitor_RLCIntencity2.Text := FloatToStr(ReferenceLight[2]/10);
    Edit_Monitor_RLCIntencity3.Text := FloatToStr(ReferenceLight[3]/10);
    Edit_Monitor_RLCIntencity4.Text := FloatToStr(ReferenceLight[4]/10);

    //0x00 0x00	Current PMT Temperature	R	Example: 0x0076 = 118 ->11.8℃
    //0x00 0x01	PMT Target Temperature	R/W	Example: 0x0064 = 100 -> 10.0℃
    //0x00 0x02	Reference Light Channel 1 Intensity	R/W	Example: 0x0064 = 100 -> 10.0% Power
    //0x00 0x03	Reference Light Channel 2 Intensity	R/W	Example: 0x03E8 = 1000 -> 100.0% Power
    //0x00 0x04	Reference Light Channel 3 Intensity	R/W	"Example: 0x0000 = 0 -> 0% Power,
    // means close reference light"
    //0x00 0x05	Reference Light Channel 4 Intensity	R/W	Example: 0x0051 = 81 -> 8.1% Power
  end;
}
end;

procedure TControlW.OnPMTBoardReadAll;
begin
{
  with MainForm.TLDCommand.PMTBoard do
  begin
    Edit_PMTBoard_CounterTriggering.Text := IntToStr(CounterTrigerring);
    Edit_PMTBoard_HVFineAdjustment1.Text := IntToStr(VoltageAdjustment[1]);
    Edit_PMTBoard_HVFineAdjustment2.Text := IntToStr(VoltageAdjustment[2]);
    Edit_PMTBoard_PreheatTime.Text := IntToStr(PreHeatTime);
    Edit_PMTBoard_MeasureTime.Text := IntToStr(MeasureTime);

    Edit_PMTBoard_RealTimeCount1.Text := FloatToStr(RealTimeCount[1]);
    Edit_PMTBoard_RealTimeCount2.Text := FloatToStr(RealTimeCount[2]);
    Edit_PMTBoard_PreheatCount1.Text := FloatToStr(PreheatCount[1]);
    Edit_PMTBoard_PreHeatCount2.Text := FloatToStr(PreheatCount[2]);
    Edit_PMTBoard_MeasureCount1.Text := FloatToStr(MeasureCount[1]);
    Edit_PMTBoard_MeasureCount2.Text := FloatToStr(MeasureCount[2]);
    Edit_PMTBoard_UID1.Text := IntToStr(UID[1]);
    Edit_PMTBoard_UID2.Text := IntToStr(UID[2]);
    Edit_PMTBoard_HVInitialValue1.Text := IntToStr(HighVoltageInit[1]);
    Edit_PMTBoard_HVInitialValue2.Text := IntToStr(HighVoltageInit[2]);
    Edit_PMTBoard_CPS.Text := IntToStr(CPS);
    Edit_PMTBoard_DeviceAddress.Text := IntToStr(DeviceAddress);

    //0x00 0x00	Counter triggering	R/W
    //0x00 0x01	Channel 1 High Voltage Fine Adjustment	R/W
    //0x00 0x02	Channel 2 High Voltage Fine Adjustment	R/W
    //0x00 0x03	Preheat Time	R/W
    //0x00 0x04	Measure Time	R/W
    //0x00 0x05		/
    //0x00 0x06	Channel 1 Real-Time Count	R	Float AB CD
    //0x00 0x07
    //0x00 0x08	Channel 2 Real-Time Count	R	Float AB CD
    //0x00 0x09
    //0x00 0x0A	Channel 1 Preheat Count	R	Float AB CD
    //0x00 0x0B
    //0x00 0x0C	Channel 2 Preheat Count	R	Float AB CD
    //0x00 0x0D
    //0x00 0x0E	Channel 1 Measure Count	R	Float AB CD
    //0x00 0x0F
    //0x00 0x10	Channel 2 Measure Count	R	Float AB CD
    //0x00 0x11
    //0x00 0x12	Channel 1 UID	R
    //0x00 0x13
    //0x00 0x14	Channel 2 UID	R
    //0x00 0x15
    //0x00 0x16	Channel 1 High Voltage Initial Value	R
    //0x00 0x17	Channel 2 High Voltage Initial Value	R
    //0x00 0x00	CPS	R
    //0x00 0x00	Device Address	R
  end;
}
end;

procedure TControlW.OnPMTBoardWriteAll;
begin
//
end;

procedure TControlW.OnPMTNewReadBase;
begin
  with MainForm.TLDCommand.PMT do
  begin
    Edit_PMTNew_CP1.Text := IntToStr(Measure_instant_ch1);
    Edit_PMTNew_CP2.Text := IntToStr(Measure_instant_ch2);
    Edit_PMTNew_LastNumber1.Text := IntToStr(Measure_num_ch1);
    Edit_PMTNew_LastNumber2.Text := IntToStr(Measure_num_ch2);
    Edit_PMTNew_MeasureTime.Text := IntToStr(Measure_time);

    Edit_PMTNew_CurrentTemp_Ch1.Text := FloatToStrRegionF(Temp_ch1,ffGeneral,6,1);
    Edit_PMTNew_CurrentTemp_Ch2.Text := FloatToStrRegionF(Temp_ch2,ffGeneral,6,1);
    Edit_PMTNew_TargetTemperature.Text := FloatToStrRegionF(Temp_setpoint,ffGeneral,6,1);
    Edit_PMTNew_DarkCurrent1.Text := IntToStr(Dark_current_val_ch1);
    Edit_PMTNew_DarkCurrent2.Text := IntToStr(Dark_current_val_ch2);
    Edit_PMTNew_LedCurrent1.Text := IntToStr(Ref_src_val_ch1);
    Edit_PMTNew_LedCurrent2.Text := IntToStr(Ref_src_val_ch2);
    CheckBox_PMTNew_Led1.Checked := Enable_led_1<>0;
    CheckBox_PMTNew_Led2.Checked := Enable_led_2<>0;
    CheckBox_PMTNew_Peltier.Checked := Peltier_enable<>0;
    Button_PMTNew_Led1Off.Enabled:=CheckBox_PMTNew_Led1.Checked;
    Button_PMTNew_Led2Off.Enabled:=CheckBox_PMTNew_Led2.Checked;
    Button_PMTNew_PeltierOff.Enabled:=CheckBox_PMTNew_Peltier.Checked;
    Button_PMTNew_Led1On.Enabled:=not CheckBox_PMTNew_Led1.Checked;
    Button_PMTNew_Led2On.Enabled:=not CheckBox_PMTNew_Led2.Checked;
    Button_PMTNew_PeltierOn.Enabled:=not CheckBox_PMTNew_Peltier.Checked;
    Edit_PMTNew_ControlTime.Text:=FloatToStrRegionF(Dark_ref_Time,ffGeneral,6,1);
    CheckBox_PMTNew_Measuring.Checked := (IsMeasuring<>0);

    //PMTNew
    //Measure_instant_ch1	0x00	LONG	R	Мгновенное значение канал 1
    //Measure_instant_ch2	0x02	LONG	R	Мгновенное значение канал 2
    //Measure_num_ch1	0x04	SHORT	R	Количество накопленных данных канал 1
    //Measure_num_ch2	0x05	SHORT	R	Количество накопленных данных канал 2
    //Measure_time	0x06	SHORT	RW	Длительность измерения, с
    //Restart	0x07	SHORT	RW	Перезапуск измерения
    //MB_REG_BUFFER_CH1	0x08	Memory Area	R	КТВ канал 1
    //MB_REG_BUFFER_CH2	0x260	Memory Area	R	КТВ канал 2
    //Buffer_total	0x4B8	Memory Area	R	КТВ с обоих каналов (общий буфер)	4321

    //PMTNew2
    //MB_REG_MEASURE_INSTANT_CH1	0x00	LONG	R	Мгновенное значение канал 1
    //MB_REG_MEASURE_INSTANT_CH2	0x02	LONG	R	Мгновенное значение канал 2
    //MB_REG_MEASURE_NUM_CH1	0x04	SHORT	R	Количество накопленных данных канал 1
    //MB_REG_MEASURE_NUM_CH2	0x05	SHORT	R	Количество накопленных данных канал 2
    //MB_REG_MEASURE_TIME	0x06	SHORT	RW	Длительность измерения, с
    //MB_REG_RESTART            0x07	SHORT	RW	Перезапуск измерения
    //MB_REG_DARK_CURRENT_START	0x08	SHORT	RW	Запуск измерение темнового тока
    //MB_REG_REF_SRC_START	0x09	SHORT	RW	Запуск измерения контрольного источника
    //MB_REG_ENABLE_LED_1	0x0A	SHORT	RW	Вкл/Выкл светодиода 1
    //MB_REG_ENABLE_LED_2	0x0B	SHORT	RW	Вкл/Выкл светодиода 2
    //MB_REG_DARK_CURRENT_VAL_CH1	0x0C	LONG	R	Значение теневого тока канал 1
    //MB_REG_DARK_CURRENT_VAL_CH2	0x0E	LONG	R	Значение теневого тока канал 2
    //MB_REG_REF_SRC_VAL_CH1	0x10	LONG	R	Значение контрольного источника канал 1
    //MB_REG_REF_SRC_VAL_CH2	0x12	LONG	R	Значение контрольного источника канал 2
    //MB_REG_TEMP_CH1	0x14	FLOAT	R	Температура датчик 1
    //MB_REG_TEMP_CH2	0x16	FLOAT	R	Температура датчик 2
    //MB_REG_TEMP_SETPOINT	0x18	FLOAT	RW	Заданная температура
    //MB_REG_PELTIER_ENABLE	0x19	SHORT	RW	Вкл/выкл Пельтье
    //MB_REG_MANUAL_MODE	0x1A	SHORT	RW	Флаг ручного режима
    //MB_REG_PWM_SETPOINT	0x1B	SHORT	RW	Заданный ШИМ сигнал
    //MB_REG_PWM_ACTUAL	0x1C	SHORT	R	Фактический ШИМ сигнал
    //MB_REG_PWM_MAX	0x1D	SHORT	RW	Максимальная скважность
    //MB_REG_PWM_MIN	0x1E	SHORT	RW	Минимальная скважность
    //MB_REG_UNUZED_AREA	0x1F	UNUZED_SHORT	R	UNUZED_AREA
    //MB_REG_BUFFER_TOTAL	0x4B8	Memory Area	R	КТВ с обоих каналов (общий буфер)
    //MB_REG_DEVICE_ID	0x968	LONG	RW	Номер установки
    //MB_REG_MODBUS_ADRESS	0x96A	SHORT	RW	Адрес modbus
  end;
end;

procedure TControlW.OnPMTNewReadKTV;
var
  i: integer;
begin
  with MainForm.TLDCommand.PMT do
  begin
    CSeriesGlade1.Clear;
    CSeriesGlade2.Clear;
    CSeriesSRC1.Clear;
    CSeriesSRC2.Clear;
    CSeriesInterestRegion.Clear;
    CSeriesTempProfil.Clear;
    for i:=0 to CurrentReaded-1 do
    begin
      CSeriesSRC1.AddXY(i,Buffer_total[i].Channel1);
      CSeriesSRC2.AddXY(i,Buffer_total[i].Channel2);
    end;
  end;
  //MemoCommandLog.Lines.Add('КТВ Считано'+IntToStr(MainForm.TLDCommand.PMT.CurrentReaded)+'  ('+'NUM_CH1='+IntToStr(MainForm.TLDCommand.PMT.Measure_num_ch1)+') из 300');
end;

procedure TControlW.OnPMTNewGetDevNumber;
begin
  Edit_PMTNew_DevNumber.Text := IntToStr(MainForm.TLDCommand.PMT.Device_id);
end;

//procedure TControlW.OnScanBoardStartRead;
//begin
////
//end;

procedure TControlW.OnScanBoardReadBase;
begin
  with MainForm.TLDCommand.Scaner do
  begin
    CheckBox_ScanBoard_Recognised.Checked := BarCodeScanStatus=1;
    CheckBox_ScanBoard_MainChannelStatus.Checked := BarrelSensor=1;
    Edit_ScanBoard_BarCodeLength.Text:=IntToStr(BarCodeLength);

    //0x00 0x00	Barcode scan control bit	R/W	1: Start barcode scanning | 0: Idel
    //0x00 0x01	Barcode scan status	R	1: Barcode recognized | 0: No barcode detected
    //0x00 0x02	Barrel sensor	R	Single bit represents a barrel channel status
    //0x00 0x03	Barcode Length	R
    //0x00 0x04	Barcode	R	"Determine the number of barcode data registers based on the barcode length (each register stores 2 ASCII characters). When reading barcode data, first check the scan status bit and barcode length. If the barcode scan is completed, read the corresponding number of registers according to the decoded length.
    //Barcode length exceeding 40 characters will trigger overflow error.
    //Number of registers = [barcode length / 2] (rounded up)"
    //0x00 0x05	Barcode	R
    //~	Barcode	R
    //0x00 0x2A	Barcode	R
    //0x00 0x 2B	Barcode	R
  end;
end;

procedure TControlW.OnScanBoardReadBarCode;
var
  i: integer;
  St: ansistring;
begin
  St:='';
  with MainForm.TLDCommand.Scaner do
  begin
    ValueListEditor_ScanBoard_BarCode.Clear;
    for i:=0 to BarCodeLength-1 do
    begin
      ValueListEditor_ScanBoard_BarCode.Values['Байт '+inttoStr(i)]:=inttoStr(BarCode[i])+' ('+AnsiChar(max(BarCode[i],32))+')';
      St:=St+AnsiChar(max(BarCode[i],32));
    end;
  end;
  Edit_ScanBoard_BarCode.Text := St;
//  Edit_ScanBoard_BarCode.Text := AnsiToUtf8(St);
end;

procedure TControlW.OnChooseMode;
begin
  if CheckBox_Algorithm_UseChooseCB.Checked then ComboBox_Algorithm_ChooseChange(Nil);
end;

procedure TControlW.OnManualScanerEntered;
begin
  if CheckBox_Scaner_DisableOnlyOne.Checked then CheckBox_Scaner_Disable.Checked:=False;
end;

procedure TControlW.SE_MotorPointChange(Sender: TObject);
begin
  Label_Motors_Info.Caption:='';
  case SE_MotorNumber.Value of
    1: Label_Motors_Info.Caption:='M0 (Тракт)';
    2: Label_Motors_Info.Caption:='M1 (Кассетница А)';
    3: Label_Motors_Info.Caption:='M2 (Кассетница Б)';
    4: Label_Motors_Info.Caption:='M3 (Выталкиватель)';
    5: Label_Motors_Info.Caption:='M4 (Облучатель)';
    else
      Label_Motors_Info.Caption:='';
  end;
  if SE_MotorNumber.Value=1 then // Тракт
    case SE_MotorPoint.Value of
      1: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': OP0';
      2: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Камера (Канал 2)';
      3: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Камера (Канал 1)';
      4: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Сканер';
      5: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Кассетница Б и Выталкиватель';
      6: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Кассетница А';
      else Label_Motors_Info.Caption:=Label_Motors_Info.Caption + 'нет мотора';
    end;
  if SE_MotorNumber.Value=2 then // Подъём/опускание кассетницы А
    case SE_MotorPoint.Value of
      1: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Подъём';
      2: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Опускание';
      else Label_Motors_Info.Caption:=Label_Motors_Info.Caption + '- нет команды';
    end;
  if SE_MotorNumber.Value=3 then // Подъём/опускание кассетницы Б
    case SE_MotorPoint.Value of
      1: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Подъём';
      2: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Опускание';
      else Label_Motors_Info.Caption:=Label_Motors_Info.Caption + '- нет команды';
    end;
  if SE_MotorNumber.Value=4 then // Выталкиватель
    case SE_MotorPoint.Value of
      1: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Норм';
      2: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Толкнуть';
      else Label_Motors_Info.Caption:=Label_Motors_Info.Caption + '- нет команды';
    end;

  if SE_MotorNumber.Value=5 then // Облучатель
    case SE_MotorPoint.Value of
      1: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Закрыть';
      2: Label_Motors_Info.Caption:=Label_Motors_Info.Caption + ': Открыть';
      else Label_Motors_Info.Caption:=Label_Motors_Info.Caption + '- нет команды';
    end;

//   - точка выброса непригодных
end;

procedure TControlW.OnChangeiCMD(aiCMD: integer; Addr: Pointer);
begin
  Edit_Algorithm_CurrentCmdID.Text := IntToStr(aiCMD);
  //Edit_Algorithm_CurrentCmdString.Text:=GetDetailedInfo(Addr);
  //Edit_Algorithm_CurrentCmdString.Text:=BackTraceStrFunc(Addr);
  //Edit_Algorithm_CurrentCmdString.Text:='';
  //try
  //  Edit_Algorithm_CurrentCmdString.Text:=  MainForm.TLD_CommandSeries.MethodName(Addr);
  //except
  //  try
  //   Edit_Algorithm_CurrentCmdString.Text:=  MainForm.TLDCommand.MethodName(Addr);
  //  except
  //  end;
  //end;

  if not CheckBox_Algorithm_UseChooseCB.Checked then
  begin
    Button_Algorithm_ReadAllClick(Nil);
  end;
end;

procedure TControlW.SpeedBtnStopClick(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.iCMD := -1;
  MainForm.TLD_CommandSeries.TLD_Mode := modeNothing;
  ComboBox_Algorithm_Choose.ItemIndex:=0;

  MainForm.TLDCommand.PMT.CurrentReaded:=300; // Прерывание цикла чтения КТВ
  MainForm.TLDCommand.PMT.Measure_num_ch1:=300;
end;

procedure TControlW.Tabcontrol_Motors_OptionsChange(Sender: TObject);
var
  i,tc,nv: integer;
begin
  tc := Tabcontrol_Motors_Options.TabIndex + 1;
  Edit_Motors_Results.Text := IntToStr(MainForm.TLDCommand.Motors.WriteMotor[tc].MaxSteps);
  Edit_Motors_NumVars.Text := IntToStr(MainForm.TLDCommand.Motors.WriteMotor[tc].NumVars);
  ValueListEditor_Motors_Options.Clear;
  nv := MainForm.TLDCommand.Motors.WriteMotor[tc].NumVars;
  for i:=1 to nv do
    ValueListEditor_Motors_Options.Values['т.'+IntToStr(i)] := IntToStr(MainForm.TLDCommand.Motors.WriteMotor[tc].Vars[i]);
end;

procedure TControlW.TGButton_Algorithm_RemoteCOMGoChange(Sender: TObject);
begin
  MainForm.TLDCommand.Host:=Edit_Algorithm_RemoteCOM_IP.Text;
  if TGButton_Algorithm_RemoteCOMGo.Checked then
  begin
    MainForm.TLDCommand.TransServer.Send(MainForm.TLDCommand.Host,cTranslatorPort,cRemoteCaptureString);
    MainForm.TLDCommand.IsTranslatorClient:=True;
    MainForm.TLDCommand.LogModBusExchange('    CLIENT STARTED');
    MainForm.TLDCommand.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : <- ','    CLIENT STARTED','',cMsgNone,cMsgPriorityInf);
  end
    else
  begin
    MainForm.TLDCommand.TransServer.Send(MainForm.TLDCommand.Host,cTranslatorPort,cRemoteFreeString);
    MainForm.TLDCommand.IsTranslatorClient:=False;
    MainForm.TLDCommand.LogModBusExchange('    CLIENT STOPPED');
    MainForm.TLDCommand.LogCommand(FormatDateTime('hh:mm:ss.zzz',Now)+' : <- ','    CLIENT STOPPED','',cMsgNone,cMsgPriorityInf);
  end
end;

procedure TControlW.ClearChart;
var
  i: integer;
  item: TTwoChanels;
begin
  CSeriesSRC1.Clear;
  CSeriesSRC2.Clear;
  for i:=0 to 299 do
  begin
    MainForm.TLDCommand.PMT.Buffer_total[i].Channel1:=0;
    MainForm.TLDCommand.PMT.Buffer_total[i].Channel2:=0;
  end;
end;

procedure TControlW.SE_MotorNumberChange(Sender: TObject);
var
  i,j: integer;
begin
  i := SE_MotorNumber.Value;
  j := MainForm.TLDCommand.Motors.WriteMotor[i].MaxSteps;
  if j<>0 then
    SE_MotorPoint.MaxValue := j;
  if (MainForm.TLDCommand.Motors.Motor_Command[i]<=20) then
    SE_MotorPoint.Value := MainForm.TLDCommand.Motors.Motor_Command[i];
{
  if (i=1) or (i=2) or (i=5) then
  begin // Двигатели 1,2,5
    SE_MotorPoint.Enabled := True;
    Button_Motors_GoTo.Enabled := True;
    Button_Motors_Init.Enabled := True;
    Button_Motors_Stop.Enabled := True;
  end
  else
  begin // Двигатели 3,4,6
    SE_MotorPoint.Enabled := False;
    Button_Motors_GoTo.Enabled := False;
    Button_Motors_Init.Enabled := False;
    Button_Motors_Stop.Enabled := False;
  end;
}
  SE_MotorPointChange(Sender);
  Button_Motors_Init251.Visible := (i=1);   // только для ШГ1
  Button_Motors_Init252.Visible := (i=1);   // только для ШГ1
end;

procedure TControlW.Button_AirHeat_ReadAllClick(Sender: TObject);
var
  i: integer;
begin
  MainForm.TLDCommand.NNAirHeatReadAll;
end;

procedure TControlW.Button_AirHeat_ReadAll1Click(Sender: TObject);
var
  Positions: Word;
begin
  Positions:=0;
  if CheckGroup_AirHeat_Position.Checked[0] then Positions := Positions + 1;
  if CheckGroup_AirHeat_Position.Checked[1] then Positions := Positions + 2;
  if CheckGroup_AirHeat_Position.Checked[2] then Positions := Positions + 4;
  if CheckGroup_AirHeat_Position.Checked[3] then Positions := Positions + 8;

  MainForm.TLDCommand.NNAirHeat_Start_CS('',Positions);
end;

procedure TControlW.BtnGoIdleClick(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.CMD_CommonGoIdle('',cRunSingle);
end;

procedure TControlW.Button_AirHeat_ReadAll2Click(Sender: TObject);
begin
  MainForm.TLDCommand.NNAirHeat_Stop_CS('',1);
end;

procedure TControlW.Button_AirHeat_WriteProfileClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNAirHeatWriteProfile(cRunSingle,Edit_AirHeat_Mode.Text,Edit_AirHeat_PreHeatTemp.Text,Edit_AirHeat_PreHeatRate.Text,Edit_AirHeat_PreHeatTime.Text,Edit_AirHeat_HeatTemp.Text,Edit_AirHeat_HeatRate.Text,Edit_AirHeat_HeatTime.Text);
  //Sleep(200);
  //Application.ProcessMessages;
end;

procedure TControlW.Button_AirHeat_WriteStatusClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNAirHeatWriteStatus(StrToInt(Edit_AirHeat_Status.Text));
  //Sleep(200);
  //Application.ProcessMessages;
end;

procedure TControlW.Button_Algorithm_RemoteCOMGoClick(Sender: TObject);
begin
end;

procedure TControlW.Button_Algorithm_InitMotorsClick(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.CMD_CommonGoMotorsInit('',0);               //   - ПЕРЕХОД В РЕЖИМ "MotorsInit"
end;

procedure TControlW.Button_Algorithm_MeasuringClick(Sender: TObject);
begin
end;

procedure TControlW.Button_Algorithm_PushOutClick(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.CMD_CommonCallPushOut('',0);               //   - ПЕРЕХОД В РЕЖИМ "MotorsInit"
end;

procedure TControlW.Button_Algorithm_ReadAllClick(Sender: TObject);
begin
  ComboBox_Algorithm_Choose.ItemIndex := ord(MainForm.TLD_CommandSeries.TLD_Mode);
  Edit_Algorithm_CurrentCmdID.Text := IntToStr(MainForm.TLD_CommandSeries.iCMD);
  CheckBox_Algorithm_ConnectionAirHeat.Checked := MainForm.TLDCommand.AirHeat.Connected;
  //CheckBox_Algorithm_ConnectionMonitor.Checked := MainForm.TLDCommand.MonitorBoard.Connected;
  CheckBox_Algorithm_ConnectionMotors.Checked  := MainForm.TLDCommand.Motors.Connected;
  //CheckBox_Algorithm_ConnectionPMT.Checked     := MainForm.TLDCommand.PMTBoard.Connected;
  CheckBox_Algorithm_ConnectionPMTNew.Checked  := MainForm.TLDCommand.PMT.Connected;
  CheckBox_Algorithm_ConnectionScaner.Checked  := MainForm.TLDCommand.Scaner.Connected;
  CheckBox_Algorithm_ConnectionPanel.Checked   := MainForm.TLDCommand.Panel.Connected;
end;

procedure TControlW.Edit_Algorithm_ValueChange(Sender: TObject);
begin
  try
    case ComboBox_Algorithm_VarType.ItemIndex of
      0: Edit_Algorithm_HexValue.Text := '$'+IntToHex(StrToInt(Edit_Algorithm_Value.Text),2);
      1: Edit_Algorithm_HexValue.Text := '$'+IntToHex(StrToInt(Edit_Algorithm_Value.Text),4);
      2: Edit_Algorithm_HexValue.Text := '$'+IntToHex(Swap(word(StrToInt(Edit_Algorithm_Value.Text))),4);
    end;
  except
  end;
end;

function TControlW.GetValByAdr(anAdr: dword; anDevType: word): string;
var
  i: dword;
  valW: word;
  valAdr: word;
begin
  case ComboBox_Algorithm_VarType.ItemIndex of
    0:
    begin
      case ComboBox_Algorithm_Parameter.ItemIndex of
        0: valW:=MainForm.TLDCommand.Motors.ByteArray[anAdr];
        1: valW:=MainForm.TLDCommand.AirHeat.ByteArray[anAdr];
        2: valW:=MainForm.TLDCommand.PMT.ByteArray[anAdr];
        3: valW:=MainForm.TLDCommand.Scaner.ByteArray[anAdr];
        4: valW:=MainForm.TLDCommand.Panel.Output.Write1000[anAdr];
      end;
      if ComboBox_Algorithm_VarType.ItemIndex=0
      then result := IntToStr(valW)
      else result := '$'+IntToHex(valW,2);
    end;
    1:
    begin
      ValAdr := anAdr;
      case ComboBox_Algorithm_Parameter.ItemIndex of
        0: valW:=MainForm.TLDCommand.Motors.ByteArray[ValAdr]*256 + MainForm.TLDCommand.Motors.ByteArray[ValAdr+1];
        1: valW:=MainForm.TLDCommand.AirHeat.ByteArray[ValAdr]*256 +MainForm.TLDCommand.AirHeat.ByteArray[ValAdr+1];
        2: valW:=MainForm.TLDCommand.PMT.ByteArray[ValAdr]*256 +MainForm.TLDCommand.PMT.ByteArray[ValAdr+1];
        3: valW:=MainForm.TLDCommand.Scaner.ByteArray[ValAdr]*256 +MainForm.TLDCommand.Scaner.ByteArray[ValAdr+1];
        4: valW:=MainForm.TLDCommand.Panel.Output.Write1000[ValAdr]*256 + MainForm.TLDCommand.Panel.Output.Write1000[ValAdr+1];
      end;
      if ComboBox_Algorithm_VarType.ItemIndex=1
      then result := IntToStr(valW)
      else result := '$'+IntToHex(valW,4);
    end;
    2:
    begin
      ValAdr := anAdr;
      case ComboBox_Algorithm_Parameter.ItemIndex of
        0: valW:=MainForm.TLDCommand.Motors.ByteArray[ValAdr+1]*256 + MainForm.TLDCommand.Motors.ByteArray[ValAdr];
        1: valW:=MainForm.TLDCommand.AirHeat.ByteArray[ValAdr+1]*256 +MainForm.TLDCommand.AirHeat.ByteArray[ValAdr];
        2: valW:=MainForm.TLDCommand.PMT.ByteArray[ValAdr+1]*256 +MainForm.TLDCommand.PMT.ByteArray[ValAdr];
        3: valW:=MainForm.TLDCommand.Scaner.ByteArray[ValAdr+1]*256 +MainForm.TLDCommand.Scaner.ByteArray[ValAdr];
        4: valW:=MainForm.TLDCommand.Panel.Output.Write1000[ValAdr+1]*256 + MainForm.TLDCommand.Panel.Output.Write1000[ValAdr];
      end;
      result := IntToStr(valW);
    end;
  end;
end;

procedure TControlW.Button_Algorithm_ReadClick(Sender: TObject);
var
  valAdr: word;
  valParam: word;
begin
  ValAdr := StrToInt(Edit_Algorithm_Address.Text);
  ValParam:=ComboBox_Algorithm_Parameter.ItemIndex;
  Edit_Algorithm_Value.Text := GetValByAdr(ValAdr, ValParam);
end;

procedure TControlW.Button_Algorithm_WriteClick(Sender: TObject);
var
  valW: int64;
  Adr: dword;
  valB1,valB2 : byte;
begin
  valW := StrToInt(Edit_Algorithm_Value.Text);
  Adr := StrToInt(Edit_Algorithm_Address.Text);
  case ComboBox_Algorithm_VarType.ItemIndex of
    0,1: begin valB1:=ValW mod 256;  valB2:=ValW div 256; end;
    2:   begin valB2:=ValW mod 256;  valB1:=ValW div 256; end;
  end;

  case ComboBox_Algorithm_Parameter.ItemIndex of
    0: MainForm.TLDCommand.Motors.ByteArray[Adr]  :=  valB1;
    1: MainForm.TLDCommand.AirHeat.ByteArray[Adr] :=  valB1;
    2: MainForm.TLDCommand.PMT.ByteArray[Adr]       :=  valB1;
    3: MainForm.TLDCommand.Scaner.ByteArray[Adr]    :=  valB1;
    4: MainForm.TLDCommand.Panel.Output.Write1000[Adr]    :=  valB1;
  end;

  if ComboBox_Algorithm_VarType.ItemIndex <> 0 then
  begin
    case ComboBox_Algorithm_Parameter.ItemIndex of
      0: MainForm.TLDCommand.Motors.ByteArray[Adr+1]  :=  valB2;
      1: MainForm.TLDCommand.AirHeat.ByteArray[Adr+1] :=  valB2;
      2: MainForm.TLDCommand.PMT.ByteArray[Adr+1]       :=  valB2;
      3: MainForm.TLDCommand.Scaner.ByteArray[Adr+1]    :=  valB2;
      4: MainForm.TLDCommand.Panel.Output.Write1000[Adr+1]    :=  valB2;
    end;
  end;
end;

procedure TControlW.Button_Algorithm_WriteFileClick(Sender: TObject);
var
  i: dword;
  iSt,iStHex: string;
  valSt,valStHex: string;
  valAdr: word;
  valParam: word;
  MaxLen: dword;
  FT: TextFile;
  Path: string;
begin
  ValParam:=ComboBox_Algorithm_Parameter.ItemIndex;
  MaxLen:=0;
  case ComboBox_Algorithm_Parameter.ItemIndex of
    0: MaxLen := length(MainForm.TLDCommand.Motors.ByteArray);
    1: MaxLen := length(MainForm.TLDCommand.AirHeat.ByteArray);
    2: MaxLen := length(MainForm.TLDCommand.PMT.ByteArray);
    3: MaxLen := length(MainForm.TLDCommand.Scaner.ByteArray);
    4: MaxLen := length(MainForm.TLDCommand.Panel.Output.Write1000);
  end;
  Path:=AppDir+'DataBaseLog'+PathDelim+'Val_'+ComboBox_Algorithm_Parameter.Text +'.csv';
  AssignFile(FT,Path);
  Rewrite(FT);
  writeln(FT,'Addr; HexAddr; Byte; Hex');
  for i:=0 to MaxLen-1 do
  begin
//      iSt:=IntToStr(i);
    iSt:=Format('%.4d',[i]);
    iStHex:='$'+IntToHex(i,4);
    valSt:=GetValByAdr(i,ValParam);
    valStHex:='$'+IntToHex(StrToInt(valSt),2);
    writeln(FT,iSt+' ; '+iStHex+'; '+valSt+' ; '+valStHex);
  end;
  CloseFile(FT);
  ShowMessage(Format(rsFileWritten,[Path]));
  //Edit_Algorithm_Value.Text := IntToStr(valW);
end;

procedure TControlW.Button_Algorithm_SwappingClick(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.CMD_CommonGoSwapping('',0);                 //   - ПЕРЕХОД В РЕЖИМ "Swapping"
end;

procedure TControlW.Button_Algorithm_TestEventClick(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.CMD_CommonUI_CheckUserAnswer('Test',StrToInt(Edit_Algorithm_EventNumber.Text));
end;

procedure TControlW.Button_Monitor_ReadAllClick(Sender: TObject);
begin
  //MainForm.TLDCommand.NNMonitorReadAll;
end;

procedure TControlW.Button_PMTNew_SetCTimeClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMTSetControlTime(StrToInt(Edit_PMTNew_ControlTime.Text));
end;

procedure TControlW.Button_PMTNew_GetDevNumberClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMTGetDevNumber;
end;

procedure TControlW.Button_PMTNew_SetDevNumberClick(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMTSetDevNumber(StrToInt(Edit_PMTNew_DevNumber.Text));
  MainForm.TLDCommand.PMT.Device_id := StrToInt(Edit_PMTNew_DevNumber.Text);
end;

procedure TControlW.Button_Monitor_WriteAll1Click(Sender: TObject);
begin
  MainForm.TLDCommand.NNPMTTargetTemp(StrToFloat(Edit_PMTNew_TargetTemperature.Text));
end;

procedure TControlW.Button_Monitor_WriteAllClick(Sender: TObject);
begin
  //MainForm.TLDCommand.NNMonitorWriteAll(Edit_Monitor_TargetTemperature.Text,Edit_Monitor_RLCIntencity1.Text,Edit_Monitor_RLCIntencity2.Text,Edit_Monitor_RLCIntencity3.Text,Edit_Monitor_RLCIntencity4.Text);
end;

procedure TControlW.Button_PMT_ReadAllClick(Sender: TObject);
begin
  //MainForm.TLDCommand.NNPMTBoardReadAll;
end;

procedure TControlW.Button_PMT_WriteAllClick(Sender: TObject);
begin
  //MainForm.TLDCommand.NNPMTBoardWriteAll(Edit_PMTBoard_CounterTriggering.Text,Edit_PMTBoard_HVFineAdjustment1.Text,Edit_PMTBoard_HVFineAdjustment2.Text,Edit_PMTBoard_PreheatTime.Text,Edit_PMTBoard_MeasureTime.Text);
end;

procedure TControlW.Button_ScanBoard_ReadAllClick(Sender: TObject);
var
  i: integer;
begin
  MainForm.TLDCommand.NNScan_Start_CS('',cRunSingle);
end;

procedure TControlW.CheckBox_AirHeat_OldVersionChange(Sender: TObject);
begin
  MainForm.TLDCommand.AirHeat.OldVersion := CheckBox_AirHeat_OldVersion.Checked;
  LblDevAirStatus.Enabled := CheckBox_AirHeat_OldVersion.Checked;
  LblDevAirMode.Enabled := CheckBox_AirHeat_OldVersion.Checked;
  Edit_AirHeat_Status.Enabled := CheckBox_AirHeat_OldVersion.Checked;
  Edit_AirHeat_Mode.Enabled := CheckBox_AirHeat_OldVersion.Checked;
  Button_AirHeat_WriteStatus.Enabled := CheckBox_AirHeat_OldVersion.Checked;
  CheckGroup_AirHeat_Position.Enabled:= not CheckBox_AirHeat_OldVersion.Checked;
end;

procedure TControlW.CheckBox_Algorithm_IsEmulatorChange(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.isEmulator := CheckBox_Algorithm_IsEmulator.Checked;
  if CheckBox_Algorithm_IsEmulator.Checked then
  begin
     //Для прохождения проверок при инициализации:
    MainForm.TLDCommand.Motors.DigitalInput := $0001;
    MainForm.TLDCommand.Motors.ReadMotor[2].Message := $4000 OR $8000;
    MainForm.TLDCommand.Motors.ReadMotor[3].Message := $4000 OR $8000;

    MainForm.TLD_CommandSeries.ConnectState := cConnectAll;

  end;
end;

procedure TControlW.CheckBox_Motors_IgnoreErrorsChange(Sender: TObject);
begin
  MainForm.TLDCommand.Motors.IgnoreAnswerError:=CheckBox_Motors_IgnoreErrors.checked;
end;

//
//procedure TControlW.CheckBox_AirHeat_IsEmulatorChange(Sender: TObject);
//begin
//
//end;

procedure TControlW.CheckBox_Panel_DontUseChange(Sender: TObject);
begin
  MainForm.TLDCommand.Panel.DontUse := CheckBox_Panel_DontUse.Checked;
end;

procedure TControlW.CheckBox_Scaner_DisableChange(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.DisableScaner:=CheckBox_Scaner_Disable.Checked;
  Edit_ScanBoard_BarCodeManual.Enabled:=CheckBox_Scaner_Disable.Checked;
  CheckBox_Scaner_DisableOnlyOne.Enabled:=CheckBox_Scaner_Disable.Checked;
end;

procedure TControlW.CheckBox_Algorithm_UseChooseCBChange(Sender: TObject);
begin
  ComboBox_Algorithm_Choose.Enabled := CheckBox_Algorithm_UseChooseCB.Checked;
end;

procedure TControlW.ComboBox_Algorithm_ChooseChange(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.iCMD := -1;
  MainForm.TLD_CommandSeries.TLD_Mode := TTLD_Mode(ComboBox_Algorithm_Choose.ItemIndex);
end;

procedure TControlW.Edit_ScanBoard_BarCodeManualChange(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.ManualBarCode:=Edit_ScanBoard_BarCodeManual.Text;
end;

procedure TControlW.FormActivate(Sender: TObject);
begin
  MainForm.TLDCommand.OnMotorsReadBase                := @OnMotorsReadBase;
  MainForm.TLDCommand.OnMotorsReadProgress            := @OnMotorsReadProgress;
  MainForm.TLDCommand.OnMotorsSetPosition             := @OnMotorsSetPosition;                       //  После позиционирования шагового двигателя
  MainForm.TLDCommand.OnMotorsStop                    := @OnMotorsStop;                              //  После аварийной остановки шагового двигателя
  MainForm.TLDCommand.OnMotorsInit                    := @OnMotorsInit;                              //  После инициализация шагового двигателя
  MainForm.TLDCommand.OnMotorsReadRWParams1           := @OnMotorsReadRWParams1;                     //  После считывания записываемых параметров моторного блока (РЕГИСТРЫ 40-46)
  MainForm.TLDCommand.OnMotorsReadRWParams2           := @OnMotorsReadRWParams2;                     //  После считывания записываемых параметров моторного блока (РЕГИСТРЫ 101-172)
  MainForm.TLDCommand.OnAirHeatReadAll                := @OnAirHeatReadAll;                          //  После ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ ПЛАТЫ НАГРЕВАТЕЛЯ ВОЗДУХА
  MainForm.TLDCommand.OnMonitorReadAll                := @OnMonitorReadAll;                          //  После ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ МОНИТОРА
  MainForm.TLDCommand.OnPMTBoardReadAll               := @OnPMTBoardReadAll;                         //  После ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ ФЭУ
  MainForm.TLDCommand.OnPMTBoardWriteAll              := @OnPMTBoardWriteAll;                        //  После ЗАПИСАТЬ ВСЕ ПАРАМЕТРЫ ФЭУ
  MainForm.TLDCommand.OnPMTNewReadBase                := @OnPMTNewReadBase;                          //  После ПРОЧИТАТЬ ВСЕ ПАРАМЕТРЫ НОВОГО ФЭУ
  MainForm.TLDCommand.OnPMTNewReadKTV                 := @OnPMTNewReadKTV;                           //  После ОТОБРАЗИТЬ КТВ
  MainForm.TLDCommand.OnPMTNewGetDevNumber            := @OnPMTNewGetDevNumber;                      //  После ОТОБРАЗИТЬ DEV NUMBER
  //MainForm.TLDCommand.OnScanBoardStartRead            := @OnScanBoardStartRead;                      //  После ЗАПУСК ЧТЕНИЯ ШТРИХКОДА
  MainForm.TLDCommand.OnScanBoardReadBase             := @OnScanBoardReadBase;                       //  После ПРОЧИТАТЬ СОСТОЯНИЕ ГОТОВНОСТИ ВЫПОЛНЕНИЯ ЧТЕНИЯ ШТРИХКОДА
  MainForm.TLDCommand.OnScanBoardReadBarCode          := @OnScanBoardReadBarCode;                    //  После ЧТЕНИЯ ШТРИХКОДА
  MainForm.TLD_CommandSeries.OnChooseMode             := @OnChooseMode;                              //  ВЕРНУТЬ РЕЖИМ НА УСТАНОВЛЕННЫЙ
  MainForm.TLD_CommandSeries.OnChangeiCMD             := @OnChangeiCMD;                              //  ОТОБРАЗИТЬ НОМЕР ШАГА
  MainForm.TLD_CommandSeries.OnManualScanerEntered    := @OnManualScanerEntered;                     // После использования подменной строки при чтении сканером
  Edit_Algorithm_RemoteCOM_IP.Text := MainForm.TLDCommand.Host;
  CheckBox_AirHeat_OldVersion.Checked := MainForm.TLDCommand.AirHeat.OldVersion;
  CheckGroup_AirHeat_Position.Checked[1]:=True;
  CheckGroup_AirHeat_Position.Checked[2]:=True;
end;

procedure TControlW.FormDeactivate(Sender: TObject);
begin
  MainForm.TLDCommand.OnMotorsReadBase                := Nil;
  MainForm.TLDCommand.OnMotorsReadProgress            := Nil;
  MainForm.TLDCommand.OnMotorsSetPosition             := Nil;
  MainForm.TLDCommand.OnMotorsStop                    := Nil;
  MainForm.TLDCommand.OnMotorsInit                    := Nil;
  MainForm.TLDCommand.OnMotorsReadRWParams1           := Nil;
  MainForm.TLDCommand.OnMotorsReadRWParams2           := Nil;
  MainForm.TLDCommand.OnAirHeatReadAll                := Nil;
  MainForm.TLDCommand.OnMonitorReadAll                := Nil;
  MainForm.TLDCommand.OnPMTBoardReadAll               := Nil;
  MainForm.TLDCommand.OnPMTBoardWriteAll              := Nil;
  MainForm.TLDCommand.OnPMTNewReadBase                := Nil;
  MainForm.TLDCommand.OnPMTNewReadKTV                 := Nil;
  MainForm.TLDCommand.OnPMTNewGetDevNumber            := Nil;
  //MainForm.TLDCommand.OnScanBoardStartRead            := Nil;
  MainForm.TLDCommand.OnScanBoardReadBase             := Nil;
  MainForm.TLDCommand.OnScanBoardReadBarCode          := Nil;
  MainForm.TLD_CommandSeries.OnChooseMode             := Nil;
  MainForm.TLD_CommandSeries.OnChangeiCMD             := Nil;
  MainForm.TLD_CommandSeries.OnManualScanerEntered    := Nil;
end;

procedure TControlW.FormDestroy(Sender: TObject);
begin
end;

procedure TControlW.PageControl1Change(Sender: TObject);
begin

end;

procedure TControlW.PLogPauseClick(Sender: TObject);
begin
end;

procedure TControlW.PLogSaveToFileClick(Sender: TObject);
begin
  If LogSaveDialog.Execute then
  begin
    MemoCommandLog.Lines.SaveToFile(LogSaveDialog.FileName+'.log');
    MemoLog.Lines.SaveToFile(LogSaveDialog.FileName+'.inout');
  end;
end;


end.
