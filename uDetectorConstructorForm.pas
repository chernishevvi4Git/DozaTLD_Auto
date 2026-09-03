unit uDetectorConstructorForm;

interface

uses
 
//  Messages, DynVarsEh,
  SysUtils, Variants, Classes, Graphics, StrUtils, Controls,
  Forms, Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  GridsEh, DBAxisGridsEh, DBGridsEh, MemTableDataEh, DB, SQLDB, MemTableEh,
  uDetector, uEnterNewDetTypeForm, DataDriverEh, ExtCtrls, StdCtrls, Buttons,
  taGraph, taSeries, uUsersManagement, uDataModule, uLogPassForm;
// Data.Win.ADODB, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart,System.UITypes, AnsiStrings, EhLibVCL,

type

  { TDetectorConstructorForm }

  TDetectorConstructorForm = class(TForm)
    BtnSaveChanges: TButton;
    DBGridEhDetType: TDBGridEh;
    DataSourceDetType: TDataSource;
    EditK1Profile: TEdit;
    EditK2Profile: TEdit;
    LabelK1Profile: TLabel;
    LabelK2Profile: TLabel;
    LblK1Profile: TLabel;
    LblK2Profile: TLabel;
    MemTableEhDetType: TMemTableEh;
    DataSetDriverEhDetType: TDataSetDriverEh;
    ADOQueryDetType: TSQLQuery;
    PanelGrid: TPanel;
    PanelTopGrid: TPanel;
    LblDetType: TLabel;
    PanelChart: TPanel;
    ChartTempProfile: TChart;
    SeriesTempProfile: TLineSeries;
    ADOQueryTempProfile: TSQLQuery;
    PanelButtom: TPanel;
    PanelTop: TPanel;
    LblProfile: TLabel;
    PanelCenter: TPanel;
    GroupBoxPreHeating: TGroupBox;
    EditPreHeatTime: TEdit;
    EditPreHeatTemp: TEdit;
    LblTime: TLabel;
    LblTemp: TLabel;
    GroupBoxMeasuring: TGroupBox;
    EditMeasuringTemp: TEdit;
    EditMeasuringTime: TEdit;
    GroupBoxBurn: TGroupBox;
    EditBurnTime: TEdit;
    EditBurnTemp: TEdit;
    EditMeasuringSpeed: TEdit;
    LblSpeed: TLabel;
    LblDetName: TLabel;
    EditDetName: TEdit;
    GroupBoxProfileParam: TGroupBox;
    LblFullMeasureTime: TLabel;
    EditFullTime: TEdit;
    LblMethod: TLabel;
    PanelDosTypeBottom: TPanel;
    BtnClose: TButton;
    PanelBottomGrid: TPanel;
    SpeedBtnAddDetType: TSpeedButton;
    SpeedBtnDelDetType: TSpeedButton;
    LblProfileErr: TLabel;
    LblMethodErr: TLabel;
    CBoxMethod: TComboBox;
    EditPreHeatSpeed: TEdit;
    EditBurnSpeed: TEdit;
    ComboBoxUserMethod: TComboBox;
    LabelUserMethod: TLabel;
    procedure BtnSaveChangesClick(Sender: TObject);
    procedure CBoxMethodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure ComboBoxUserMethodKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditBurnTempKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditBurnTimeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditEnable(Sender: TObject);
    procedure EditDisable(Sender: TObject);
    procedure EditK1ProfileChange(Sender: TObject);
    procedure EditK1ProfileKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditK2ProfileChange(Sender: TObject);
    procedure EditK2ProfileKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditMeasuringSpeedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditMeasuringTempKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditMeasuringTimeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditPreHeatTempKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditPreHeatTimeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DBGridEhDetTypeCellClick(Column: TColumnEh);
    procedure BtnCloseClick(Sender: TObject);
    procedure EditPreHeatTimeChange(Sender: TObject);
    procedure EditPreHeatTempChange(Sender: TObject);
    procedure EditMeasuringTimeChange(Sender: TObject);
    procedure EditMeasuringTempChange(Sender: TObject);
    procedure EditBurnTimeChange(Sender: TObject);
    procedure EditBurnTempChange(Sender: TObject);
    procedure EditMeasuringSpeedChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEhDetTypeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedBtnSaveChangesClick(Sender: TObject);
    procedure SpeedBtnAddDetTypeClick(Sender: TObject);
    procedure SpeedBtnDelDetTypeClick(Sender: TObject);
    procedure CBoxMethodChange(Sender: TObject);
    procedure PanelGridResize(Sender: TObject);
    procedure ComboBoxUserMethodChange(Sender: TObject);
  private
    { Private declarations }
    FTempProfile        : TTempProfile;
    FTime_preheating    : integer;
    FTemp_preheating    : integer;
    FTime_measurment    : integer;
    FTemp_measurment    : integer;
    FTime_burn          : integer;
    FTemp_burn          : integer;
    FSpeed              : double;
    FEditAvailable      : boolean;
    FK1Profile          : double;
    FK2Profile          : double;

    function CheckProfileEdits: boolean;
    function GetEnableControls: boolean;
    function IsValidK1Profile(aEdit: TEdit; aLabel: TLabel; aText: string): boolean;
    function IsValidK2Profile(aEdit: TEdit; aLabel: TLabel; aText: string): boolean;
    function IsNotCuChecked: boolean;
    procedure SetTempProfile(Value: TTempProfile);
    procedure SetTime_preheating(Value: integer);
    procedure SetTemp_preheating(Value: integer);
    procedure SetTime_measurment(Value: integer);
    procedure SetTemp_measurment(Value: integer);
    procedure SetTime_burn(Value: integer);
    procedure SetTemp_burn(Value: integer);
    procedure SetSpeed(Value: double);
    procedure SaveDetType;
    procedure CalcFullTime;
    procedure LoadCBoxMethod;
    procedure LoadCBoxUserMethod;
    procedure DeleteDetType(aDetTypeName: String);
    procedure ChangeProfileEdit(var FValue: integer; Value: integer; Edit: TEdit);
    procedure ChangeSpeedEdit(var FValue: double; Value: double; Edit: TEdit);
    procedure ResizePanelLeft(DBGrid: TDbGridEh; MemTable: TMemTableEh);
    procedure SetEditAvailable(const Value: boolean);
    procedure CheckEnableControls;
    procedure UnlockControls(Value: boolean);
  public
    { Public declarations }
    DetTypeName : String;
    procedure LoadTempProfile;
    procedure RefreshDetTypeList;
    procedure UpdateTempProfile;
    property TempProfile: TTempProfile read FTempProfile write SetTempProfile;
    property Time_preheating: integer read FTime_preheating write SetTime_preheating;
    property Temp_preheating: integer read FTemp_preheating write SetTemp_preheating;
    property Time_measurment: integer read FTime_measurment write SetTime_measurment;
    property Temp_measurment: integer read FTemp_measurment write SetTemp_measurment;
    property Time_burn: integer read FTime_burn write SetTime_burn;
    property Temp_burn: integer read FTemp_burn write SetTemp_burn;
    property Speed: double read FSpeed write SetSpeed;
    property EditAvailable: boolean read FEditAvailable write SetEditAvailable;
  end;

const
  cNoVal = -1;
  cK1ProfileDefault = 1;
  cK2ProfileDefault = 0;
  cMaxPartProfileTime = 10000;
  cMaxPartProfileTemp = 1000;
  cMaxSpeed = 40;
//  cColumnWidth_0 = 70;
//  cColumnWidth_1 = 70;
//  cColumnWidth_2 = 160;
//  cColumnWidth_3 = 200;
//  cColumnWidth_4 = 120;
//  cColumnWidth_5 = 140;
var
  DetectorConstructorForm: TDetectorConstructorForm;

implementation

uses
  EhLibMTE,
  uMainForm,
  uDosimeterTypeConstructorForm,
  uConst,
  uSeparator,
  uFunctions,
  uLanguages,
  uLog;
{$R *.dfm}

{ TDetectorType }

procedure TDetectorConstructorForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TDetectorConstructorForm.CalcFullTime;
var
  fullTime: integer;
begin
  fullTime:=StrToIntRegion(EditPreHeatTime.Text)+StrToIntRegion(EditMeasuringTime.Text)+StrToIntRegion(EditBurnTime.Text);

  if fullTime > 0 then
    EditFullTime.Text:=IntToStr(fullTime)
  else
    EditFullTime.Clear;
end;

procedure TDetectorConstructorForm.CBoxMethodChange(Sender: TObject);
begin
  CheckProfileEdits;
end;

procedure TDetectorConstructorForm.ChangeProfileEdit(var FValue: integer; Value: integer; Edit: TEdit);
begin
  if Value <> cNoVal then
    Edit.Text:=IntToStr(Value)
  else
    Edit.Clear;

  if FValue<>Value then
  begin
    FValue:=Value;
    CheckProfileEdits;
    CalcFullTime;
    UpdateTempProfile;
  end;
end;

procedure TDetectorConstructorForm.ChangeSpeedEdit(var FValue: double; Value: double; Edit: TEdit);
begin
  if Value <> cNoVal then
    Edit.Text:=FloatToStr(Value)
  else
    Edit.Clear;

  if FValue<>Value then
  begin
    FValue:=Value;
    CheckProfileEdits;
    CalcFullTime;
    UpdateTempProfile;
  end;
end;

function TDetectorConstructorForm.CheckProfileEdits: boolean;
var
  flagProfile     : boolean;
  flagMethod      : boolean;
  flagUserMethod  : boolean;
  flagKProfile    : boolean;
begin

  StrToFloatRegion(EditBurnTemp.Text);

  if (StrToFloatRegion(EditPreHeatTime.Text)>=0) AND
     (StrToFloatRegion(EditPreHeatTemp.Text)>=0) AND
     (StrToFloatRegion(EditMeasuringTime.Text)>=0) AND
     (StrToFloatRegion(EditMeasuringTemp.Text)>=0) AND
     (StrToFloatRegion(EditBurnTime.Text)>=0) AND
     (StrToFloatRegion(EditBurnTemp.Text)>=0) AND
     (StrToFloatRegion(EditMeasuringSpeed.Text)>=0)
  then
  begin
    LblProfileErr.Visible:=false;
    flagProfile:=true;
  end
  else
  begin
    LblProfileErr.Visible:=true;
    flagProfile:=false;
  end;

  if CBoxMethod.ItemIndex>0 then
  begin
    LblMethodErr.Visible:=false;
    flagMethod:=true;
  end
  else
  begin
    LblMethodErr.Visible:=true;
    flagMethod:=false;
  end;

  flagUserMethod:=true;


  if (CBoxMethod.ItemIndex>=0) and (CBoxMethod.Items[CBoxMethod.ItemIndex]=cMethod_User) then
  begin
    LabelUserMethod.Visible:=true;
    ComboBoxUserMethod.Visible:=true;
    if ComboBoxUserMethod.ItemIndex>0 then
      LblMethodErr.Visible:=false
    else
    begin
      flagUserMethod:=false;
      LblMethodErr.Visible:=true;
    end;
  end
  else
  begin
    ComboBoxUserMethod.ItemIndex:=ComboBoxUserMethod.Items.IndexOf(cMethod_None);
    LabelUserMethod.Visible:=false;
    ComboBoxUserMethod.Visible:=false;
  end;

  if flagProfile then
  try
    if StrToFloatRegion(EditPreHeatTemp.Text) > StrToFloatRegion(EditPreHeatTime.Text) * StrToIntRegion(EditPreHeatSpeed.Text) then
      EditPreHeatTemp.Color := clYellow
    else
      EditPreHeatTemp.Color := clWhite;

    if StrToFloatRegion(EditMeasuringTemp.Text) > StrToFloatRegion(EditMeasuringTime.Text) * StrToFloatRegion(EditMeasuringSpeed.Text) + StrToFloatRegion(EditPreHeatTemp.Text) then
      EditMeasuringTemp.Color := clYellow
    else
      EditMeasuringTemp.Color := clWhite;

    if StrToFloatRegion(EditBurnTemp.Text) > StrToFloatRegion(EditBurnTime.Text) * StrToFloatRegion(EditBurnSpeed.Text) + StrToFloatRegion(EditMeasuringTemp.Text) then
      EditBurnTemp.Color := clYellow
    else
      EditBurnTemp.Color := clWhite;

    if (EditPreHeatTemp.Color = clYellow) OR
      (EditMeasuringTemp.Color = clYellow) OR
      (EditBurnTemp.Color = clYellow) then
      flagProfile:=false
    else
      flagProfile:=true;

  except

  end;

  if IsValidK1Profile(EditK1Profile,LblK1Profile,'знечение должно быть в диапазоне от 0.8 до 1') AND IsValidK2Profile(EditK2Profile,LblK2Profile,'знечение должно <= 0') then
    flagKProfile:=true
  else
    flagKProfile:=false;

  if flagProfile AND flagMethod AND flagUserMethod AND IsNotCuChecked then
  begin
    if AW.IsHaveIRight(crMain_DetectorType) then
    begin
      if flagKProfile then
        BtnSaveChanges.Enabled:=true
      else
        BtnSaveChanges.Enabled:=false;

      EditK1Profile.Enabled:=true;
      EditK2Profile.Enabled:=true;
    end;
    Result:=true;
  end
  else
  begin
    BtnSaveChanges.Enabled:=false;

    EditK1Profile.Enabled:=false;
    EditK2Profile.Enabled:=false;
    //UnlockControls(false);
    Result:=false;
  end;

end;

procedure TDetectorConstructorForm.ComboBoxUserMethodChange(Sender: TObject);
begin
  CheckProfileEdits;
//  if ComboBoxUserMethod.ItemIndex>0 then
//    LblMethodErr.Visible:=false
//  else
//    LblMethodErr.Visible:=true;
end;

procedure TDetectorConstructorForm.DBGridEhDetTypeCellClick(Column: TColumnEh);
begin
  LoadTempProfile;
end;

procedure TDetectorConstructorForm.DBGridEhDetTypeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LoadTempProfile;
end;

procedure TDetectorConstructorForm.EditDisable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=false;
end;

procedure TDetectorConstructorForm.EditK1ProfileChange(Sender: TObject);
begin
  CheckProfileEdits;
end;

procedure TDetectorConstructorForm.EditK1ProfileKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,EditK2Profile);
end;

procedure TDetectorConstructorForm.EditK2ProfileChange(Sender: TObject);
begin
  CheckProfileEdits;
end;

procedure TDetectorConstructorForm.EditK2ProfileKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,BtnSaveChanges);
end;

procedure TDetectorConstructorForm.EditMeasuringSpeedKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,EditBurnTime);
end;

procedure TDetectorConstructorForm.EditMeasuringTempKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,EditMeasuringSpeed);
end;

procedure TDetectorConstructorForm.EditMeasuringTimeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,EditMeasuringTemp);
end;

procedure TDetectorConstructorForm.EditPreHeatTempKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,EditMeasuringTime);
end;

procedure TDetectorConstructorForm.EditPreHeatTimeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,EditPreHeatTemp);
end;

procedure TDetectorConstructorForm.EditEnable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=true;
end;

procedure TDetectorConstructorForm.EditBurnTimeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,EditBurnTemp);
end;

procedure TDetectorConstructorForm.EditBurnTempKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,CBoxMethod);
end;

procedure TDetectorConstructorForm.CBoxMethodKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ComboBoxUserMethod.Visible then
    SetFocusOnNextEditAfterEnterIfVisible(Key,ComboBoxUserMethod,EditK1Profile)
  else if BtnSaveChanges.Enabled then
    SetFocusOnNextEditAfterEnterIfEnabled(Key,EditK1Profile,BtnSaveChanges);
end;

procedure TDetectorConstructorForm.BtnSaveChangesClick(Sender: TObject);
begin
  SaveDetType;
  DosimeterTypeConstructorForm.LoadDosTypeParameters;
end;

procedure TDetectorConstructorForm.ComboBoxUserMethodKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if BtnSaveChanges.Enabled then
    SetFocusOnNextEditAfterEnterIfEnabled(Key,EditK1Profile,BtnSaveChanges)
end;

procedure TDetectorConstructorForm.EditBurnTempChange(Sender: TObject);
begin
  if (EditBurnTemp.Text<>'') AND (Temp_burn<>StrToIntRegion(EditBurnTemp.Text)) then
    Temp_burn:=StrToIntRegion(EditBurnTemp.Text)
  else
    CheckProfileEdits;
end;

procedure TDetectorConstructorForm.EditBurnTimeChange(Sender: TObject);
begin
  if (EditBurnTime.Text<>'') AND (Time_burn<>StrToIntRegion(EditBurnTime.Text)) then
  begin
    CheckProfileEdits;
    Time_burn:=StrToIntRegion(EditBurnTime.Text);
  end
  else
    CheckProfileEdits;
end;

function TDetectorConstructorForm.IsNotCuChecked: boolean;
begin
  if DetTypeName = cDetMat_LiF_Cu_P then
    Result:=false
  else
    Result:=true;
end;

function TDetectorConstructorForm.IsValidK1Profile(aEdit: TEdit; aLabel: TLabel; aText: string): boolean;
const
  ck1_Low = 0.8;
  ck2_High = 1;
begin
  if IsReal(aEdit.Text) then
  begin
    aLabel.Caption:='';
    aLabel.Visible:=false;
    aEdit.Color:=clWhite;

    FK1Profile:=StrToFloatRegion(aEdit.Text);
    if (FK1Profile>ck2_High) OR (FK1Profile<ck1_Low)then
    begin
      aLabel.Caption:=aText;
      aLabel.Visible:=true;
      aEdit.Color:=clYellow;
      Result:=false;
    end
    else
    begin
      aLabel.Caption:='';
      aLabel.Visible:=false;
      aEdit.Color:=clWhite;
      Result:=true;
    end;

  end
  else
  begin
    FK1Profile:=cK1ProfileDefault;
    aLabel.Caption:=rsEnterCorrectValue;
    aLabel.Visible:=true;
    aEdit.Color:=clYellow;
    Result:=false;
  end;
end;

function TDetectorConstructorForm.IsValidK2Profile(aEdit: TEdit; aLabel: TLabel; aText: string): boolean;
begin
  if IsRealNAN(aEdit.Text) then
  begin
    aLabel.Caption:='';
    aLabel.Visible:=false;
    aEdit.Color:=clWhite;

    FK2Profile:=StrToFloatRegion(aEdit.Text);
    if (FK2Profile>0) then
    begin
      aLabel.Caption:=aText;
      aLabel.Visible:=true;
      aEdit.Color:=clYellow;
      Result:=false;
    end
    else
    begin
      aLabel.Caption:='';
      aLabel.Visible:=false;
      aEdit.Color:=clWhite;
      Result:=true;
    end;

  end
  else
  begin
    FK2Profile:=cK2ProfileDefault;
    aLabel.Caption:=rsEnterCorrectValue;
    aLabel.Visible:=true;
    aEdit.Color:=clYellow;
    Result:=false;
  end;
end;

procedure TDetectorConstructorForm.EditMeasuringTempChange(Sender: TObject);
begin
  if (EditMeasuringTemp.Text<>'') AND (Temp_measurment<>StrToIntRegion(EditMeasuringTemp.Text)) then
    Temp_measurment:=StrToIntRegion(EditMeasuringTemp.Text)
  else
    CheckProfileEdits;
end;

procedure TDetectorConstructorForm.EditMeasuringTimeChange(Sender: TObject);
begin
  if (EditMeasuringTime.Text<>'') AND (Time_measurment<>StrToIntRegion(EditMeasuringTime.Text)) then
    Time_measurment:=StrToIntRegion(EditMeasuringTime.Text)
  else
    CheckProfileEdits;
end;

procedure TDetectorConstructorForm.EditPreHeatTempChange(Sender: TObject);
begin
  if (EditPreHeatTemp.Text<>'') AND (Temp_preheating<>StrToIntRegion(EditPreHeatTemp.Text)) then
    Temp_preheating:=StrToIntRegion(EditPreHeatTemp.Text)
  else
    CheckProfileEdits;
end;

procedure TDetectorConstructorForm.EditPreHeatTimeChange(Sender: TObject);
begin
  if (EditPreHeatTime.Text<>'') AND (Time_preheating<>StrToIntRegion(EditPreHeatTime.Text)) then
    Time_preheating:=StrToIntRegion(EditPreHeatTime.Text)
  else
    CheckProfileEdits;
end;

procedure TDetectorConstructorForm.EditMeasuringSpeedChange(Sender: TObject);
begin
  if (EditMeasuringSpeed.Text<>'') AND (Speed<>StrToFloatRegion(EditMeasuringSpeed.Text)) then
    Speed:=StrToFloatRegion(EditMeasuringSpeed.Text)
  else
    CheckProfileEdits;
end;

procedure TDetectorConstructorForm.FormCreate(Sender: TObject);
const
  cMaxSpeed = '40';
begin
  EditPreHeatSpeed.Text:=cMaxSpeed;
  EditBurnSpeed.Text:=cMaxSpeed;

  LblProfileErr.Caption:=Format('%s!',[rsProfileParamsEmpty]);
  LblProfileErr.Visible:=false;
  LblMethodErr.Caption:=Format('%s!',[rsMethodEmpty]);
  LblMethodErr.Visible:=false;

  FTime_preheating:=cNoVal;
  FTemp_preheating:=cNoVal;
  FTime_measurment:=cNoVal;
  FTemp_measurment:=cNoVal;
  FTime_burn:=cNoVal;
  FTemp_burn:=cNoVal;
  FSpeed:=cNoVal;

  FK1Profile:=cK1ProfileDefault;
  FK2Profile:=cK2ProfileDefault;
end;

procedure TDetectorConstructorForm.FormShow(Sender: TObject);
begin
  EditAvailable:=false;
  RefreshDetTypeList;
  LoadCBoxMethod;
  LoadCBoxUserMethod;
  LoadTempProfile;
end;

function TDetectorConstructorForm.GetEnableControls: boolean;
begin
 case IndexStr(AnsiString(DetTypeName), cDetTypes) of
    0..Length(cDetTypes):
      Result:=false;
    else
      Result:=true;
  end;
end;

procedure TDetectorConstructorForm.LoadCBoxMethod;
var
  i: integer;
begin
  CBoxMethod.Clear;

  for i:=Low(cMethodsArray) to High(cMethodsArray) do
    CBoxMethod.Items.Add(cMethodsArray[i]);
end;

procedure TDetectorConstructorForm.LoadCBoxUserMethod;
var
  path      : String;
  sr        : TSearchRec;
  fileName  : String;
begin
  ComboBoxUserMethod.Clear;

  ComboBoxUserMethod.Items.Add(cMethod_None);

  path:=extractfilepath(Application.ExeName)+'Options'+PathDelim+'Method';

  if DirectoryExists(path) then
  begin
    if FindFirst(path+PathDelim+'*'+cExtMTD, faAnyFile, sr)=0  then
    repeat
      fileName:=StringReplace(sr.Name,cExtMTD,'',[rfreplaceall]);
      ComboBoxUserMethod.Items.Add(fileName);
    until FindNext(sr)<>0;
    FindClose(sr);
  end;

  ComboBoxUserMethod.ItemIndex:=ComboBoxUserMethod.Items.IndexOf(cMethod_User);
end;

procedure TDetectorConstructorForm.CheckEnableControls;
begin
  case IndexStr(AnsiString(DetTypeName), cDetTypes) of
    0..Length(cDetTypes):
      UnlockControls(false);
    else
      UnlockControls(true);
  end;
end;

procedure TDetectorConstructorForm.LoadTempProfile;
var
  detectorTypeID  : String;
  _tempProfile    : String;
  detectorType    : String;
  comment         : String;
  method          : String;
  k1profile       : String;
  k2profile       : String;
  i               : integer;
  ts              : TStringList;
  strVal          : String;
  strParam        : String;
begin

  if TLDDataModule.IsDBConnected then
  begin
    DetTypeName:=DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetType).AsString;
    detectorTypeID:=DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetTypeID).AsString;
//    if not detectorTypeID.IsEmpty then
    if detectorTypeID<>'' then
    begin
      TLDDataModule.ADOQuery.Active:=False;
      TLDDataModule.ADOQuery.SQL.Clear;
      TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldtempProfile+','
                                              +cFieldDetType+','
                                              +cFieldDetTypeComment+','
                                              +cFieldK1Profile+','
                                              +cFieldK2Profile+','
                                              +cFieldMethod+' '
                                       +'FROM '+cDBTableDetType+' '
                                      +'WHERE '+cFieldDetTypeID+'='+detectorTypeID);
      TLDDataModule.ADOQuery.Active:=True;

      _tempProfile:=TLDDataModule.ADOQuery.FieldByName(cFieldtempProfile).AsString;
      detectorType:=TLDDataModule.ADOQuery.FieldByName(cFieldDetType).AsString;
      comment:=TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeComment).AsString;
      k1profile:=TLDDataModule.ADOQuery.FieldByName(cFieldK1Profile).AsString;
      k2profile:=TLDDataModule.ADOQuery.FieldByName(cFieldK2Profile).AsString;
      method:=TLDDataModule.ADOQuery.FieldByName(cFieldMethod).AsString;
      LblProfile.Caption:=Format(rsTemperatureProfile,[detectorType]);

      CBoxMethod.ItemIndex:=CBoxMethod.Items.IndexOf(method);

      EditDetName.Text:=detectorType;
      EditK1Profile.Text:=k1profile;
      EditK2Profile.Text:=k2profile;

      if CBoxMethod.Items.IndexOf(method) > 0 then
        CBoxMethod.ItemIndex:=CBoxMethod.Items.IndexOf(method)
      else if Pos(cMethod_User,method)>0 then
      begin
        CBoxMethod.ItemIndex:=CBoxMethod.Items.IndexOf(cMethod_User);
        method:=StringReplace(method,cMethod_User+'_','',[rfReplaceAll]);
        ComboBoxUserMethod.ItemIndex:=ComboBoxUserMethod.Items.IndexOf(method);
      end
      else
        CBoxMethod.ItemIndex:=CBoxMethod.Items.IndexOf(cMethod_None);

//      if not comment.IsEmpty then
      if comment<>'' then
      begin
        if comment <> cEmpty then
        begin
          ts:=TStringList.Create;
          ts.Delimiter:='|';                                        // устанавливаем разделитель
          ts.DelimitedText:=comment;

          if ts.Count>0 then
          begin
            // начинаем с 2 т.к. первые два значения в массиве термопрофиля - длительность нагрева и допустимое отклонение при нагреве
            for i := 0 to ts.Count-1 do
            begin
              strVal:=ts[i];
              strParam:=ts[i];
              Delete(strVal,1,Pos('=',strVal));
              Delete(strParam,Pos('=',strParam),Length(strParam)-Pos('=',strParam)+1);

              case AnsiIndexStr(strParam,[cTimePreheat,cTempPreheat,cTimeMeas,cTempMeas,cTimeBurn,cTempBurn,cSpeedHeating]) of
                0:
                begin
                  Time_preheating:=StrToIntRegion(strVal);
                end;
                1:
                begin
                  Temp_preheating:=StrToIntRegion(strVal);
                end;
                2:
                begin
                  Time_measurment:=StrToIntRegion(strVal);
                end;
                3:
                begin
                  Temp_measurment:=StrToIntRegion(strVal);
                end;
                4:
                begin
                  Time_burn:=StrToIntRegion(strVal);
                end;
                5:
                begin
                  Temp_burn:=StrToIntRegion(strVal);
                end;
                6:
                begin
                  Speed:=StrToFloatRegion(strVal);
                end;
              end;
            end;
          end;

          ts.free;
        end
        else
          begin
            Time_preheating:=cNoVal;
            Temp_preheating:=cNoVal;
            Time_measurment:=cNoVal;
            Temp_measurment:=cNoVal;
            Time_burn:=cNoVal;
            Temp_burn:=cNoVal;
            Speed:=cNoVal;
          end;
      end;

      if _tempProfile<>'' then
      begin
        ts:=TStringList.Create;
        ts.Delimiter:=',';                                        // устанавливаем разделитель
        ts.DelimitedText:=_tempProfile;
        ts.Text:=StringReplace(ts.Text,'{','',[rfreplaceall]);    // удаляем фигурные скобки
        ts.Text:=StringReplace(ts.Text,'}','',[rfreplaceall]);

        SeriestempProfile.Clear;

        if ts.Count>0 then
        begin
          // начинаем с 2 т.к. первые два значения в массиве терсопрофиля - длительность нагрева и допустимое отклонение при нагреве
          for i := 2 to ts.Count-1 do SeriestempProfile.AddXY(i,StrToFloatRegion(ts[i])/10);
        end;

        ts.free;
      end;

      CheckProfileEdits;
      CheckEnableControls;
    end;
  end;
end;

procedure TDetectorConstructorForm.UnlockControls(Value: boolean);
begin
  if AW.IsHaveIRight(crMain_DetectorType) then
  begin
    EditPreHeatTime.Enabled:=Value;
    EditPreHeatTemp.Enabled:=Value;
    EditPreHeatSpeed.Enabled:=Value;
    EditMeasuringTime.Enabled:=Value;
    EditMeasuringTemp.Enabled:=Value;
    EditMeasuringSpeed.Enabled:=Value;
    EditBurnTime.Enabled:=Value;
    EditBurnTemp.Enabled:=Value;
    EditBurnSpeed.Enabled:=Value;
    EditFullTime.Enabled:=Value;
    CBoxMethod.Enabled:=Value;
  //  SpeedBtnSaveChanges.Enabled:=Value;
  //  SpeedBtnAddDetType.Enabled:=Value;
    SpeedBtnDelDetType.Enabled:=Value;
  end;
end;

procedure TDetectorConstructorForm.PanelGridResize(Sender: TObject);
begin
  ResizePanelLeft(DBGridEhDetType,MemTableEhDetType);
end;

procedure TDetectorConstructorForm.RefreshDetTypeList;
begin
  if TLDDataModule.IsDBConnected then
  begin
    ADOQueryDetType.SQL.Clear;
    ADOQueryDetType.SQL.Add('SELECT '
                                    +cFieldDetTypeID+','
                                    +cFieldDetType+','
                                    +cFieldMethod+' '
                             +'FROM '
                                    +cDBTableDetType+' '
                           +'WHERE '
                                    +cFieldDetTypeID+'>0'+' '
                        +'ORDER BY '
                                    +cFieldDetTypeID);
    ADOQueryDetType.Active:=true;

    ADOQueryDetType.Open;

    if MemTableEhDetType.Active then MemTableEhDetType.Active:=false;

    MemTableEhDetType.Active:=true;

//    DBGridEhDetType.Columns[DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetTypeID).Index].Alignment:=taLeftJustify;
//    DBGridEhDetType.Columns[DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetTypeID).Index].Title.Caption:=Format(' %s',['ID']);
    DBGridEhDetType.Columns[DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetTypeID).Index].Visible:=false;
    DBGridEhDetType.Columns[DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetType).Index].Title.Caption:=Format(' %s',[rsMatherial]);
    DBGridEhDetType.Columns[DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldMethod).Index].Title.Caption:=Format(' %s',[rsCalcMethod]);

//    DBGridEhDetType.Columns[DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetTypeID).Index].Footer.ValueType := fvtStaticText;
//    DBGridEhDetType.Columns[DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetType).Index].Footer.ValueType := fvtStaticText;
//    DBGridEhDetType.Columns[DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetTypeID).Index].Footer.Value:=Format(' %s',['Типов']);
//    DBGridEhDetType.Columns[DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetType).Index].Footer.Value:=Format('- %d',[ADOQueryDetType.RecordCount]);

    DBGridEhDetType.DataSource.DataSet.Locate(cFieldDetType,DetTypeName,[]);

    DetTypeName:=DBGridEhDetType.DataSource.DataSet.FieldByName(cFieldDetType).AsString;

    ResizePanelLeft(DBGridEhDetType,MemTableEhDetType);

    ADOQueryDetType.Close;
  end;
end;

procedure TDetectorConstructorForm.ResizePanelLeft(DBGrid: TDbGridEh; MemTable: TMemTableEh);
const
  cAddFieldSize = 8;
var
  i                  : integer;
  indicatorColWidth  : integer;
  columnsWidth       : integer;
  columnName         : String;
begin
  columnsWidth:=0;

  indicatorColWidth:=DBGrid.CalcIndicatorColWidth+cAddFieldSize+DBGrid.VertScrollBar.Width;

  if MemTable.Active then
  begin

    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDetTypeID).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDetTypeID).Index].Width:=cColumnWidth_1;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDetType).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDetType).Index].Width:=cColumnWidth_5;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMethod).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMethod).Index].Width:=cColumnWidth_3;

    for i := 0 to DBGrid.Columns.Count-1 do
    begin
      if (DBGrid.Columns[i].Visible) then
      begin
        columnsWidth:=columnsWidth+DBGrid.Columns[i].Width;
        columnName:=DBGrid.Columns[i].FieldName;
      end;
    end;

    columnsWidth:=columnsWidth-DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(columnName).Index].Width+indicatorColWidth;

    if (DBGrid.Width-columnsWidth)>cColumnWidth_1 then
      DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(columnName).Index].Width:=DBGrid.Width-columnsWidth
    else
      DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(columnName).Index].Width:=cColumnWidth_3;
  end;

end;

procedure TDetectorConstructorForm.SetTempProfile(Value: TTempProfile);
var
  i: integer;
begin
  FTempProfile:=Value;
  SeriesTempProfile.Clear;
  for i := 2 to Length(Value)-1 do SeriesTempProfile.AddXY(i,(Value[i])/10);
end;

procedure TDetectorConstructorForm.SaveDetType;
var
  strComment      : String;
  strTempProfile  : String;
  strMethod       : String;
  i               : integer;
begin
  strComment:=cTimePreheat+'='+EditPreHeatTime.Text+'|'+
              cTempPreheat+'='+EditPreHeatTemp.Text+'|'+
              cTimeMeas+'='+EditMeasuringTime.Text+'|'+
              cTempMeas+'='+EditMeasuringTemp.Text+'|'+
              cTimeBurn+'='+EditBurnTime.Text+'|'+
              cTempBurn+'='+EditBurnTemp.Text+'|'+
              cSpeedHeating+'='+EditMeasuringSpeed.Text+'|';

  strTempProfile:='{';

  for i := 0 to Length(TempProfile)-1 do
  begin
    if i < Length(TempProfile)-1 then
      strTempProfile:=strTempProfile+IntToStr(TempProfile[i])+','
    else
      strTempProfile:=strTempProfile+IntToStr(TempProfile[i]);
  end;

  strTempProfile:=strTempProfile+'}';

  if (CBoxMethod.Items[CBoxMethod.ItemIndex]=cMethod_User) AND (ComboBoxUserMethod.ItemIndex>0) then
    strMethod:=Format('%s_%s',[cMethod_User,ComboBoxUserMethod.Text])
  else
    strMethod:=CBoxMethod.Text;

  ADOQueryTempProfile.SQL.Clear; // очистить текст sql
  ADOQueryTempProfile.SQL.Add('UPDATE '+cDBTableDetType+' SET '+cFieldMethod+'='+#39+strMethod+#39+','
                                                               +cFieldTempProfile+'='+#39+strTempProfile+#39+','
                                                               +cFieldK1Profile+'='+#39+FloatToStrRegion(FK1Profile)+#39+','
                                                               +cFieldK2Profile+'='+#39+FloatToStrRegion(FK2Profile)+#39+','
                                                               +cFieldDetTypeComment+'='+#39+strComment+#39
                                                               +' WHERE '+cFieldDetType+'='+#39+EditDetName.Text+#39);
  ADOQueryTempProfile.ExecSQL;

  RefreshDetTypeList;
  LoadTempProfile;

  WriteLog(Format('%s "%s" - %s %s',[rsDetectorParamsUpdated,EditDetName.Text,strComment,CBoxMethod.Text]));
end;

procedure TDetectorConstructorForm.SetEditAvailable(const Value: boolean);
begin
  FEditAvailable:=Value;
//
//  EditPreHeatTime.Enabled:=Value;
//  EditPreHeatTemp.Enabled:=Value;
//  EditPreHeatSpeed.Enabled:=Value;
//  EditMeasuringTime.Enabled:=Value;
//  EditMeasuringTemp.Enabled:=Value;
//  EditMeasuringSpeed.Enabled:=Value;
//  EditBurnTime.Enabled:=Value;
//  EditBurnTemp.Enabled:=Value;
//  EditBurnSpeed.Enabled:=Value;
//  EditFullTime.Enabled:=Value;
//  CBoxMethod.Enabled:=Value;
//  SpeedBtnSaveChanges.Enabled:=Value;
//  SpeedBtnAddDetType.Enabled:=Value;
//  SpeedBtnDelDetType.Enabled:=Value;
//  DBGridEhDetType.Enabled:=Value;
//
//  if Value then
//    SpeedBtnEditAvailable.Caption:='Заблокировать'
//  else
//    SpeedBtnEditAvailable.Caption:='Разблокировать';

  CheckEnableControls;
end;

procedure TDetectorConstructorForm.SetSpeed(Value: double);
var
  val: double;
begin
  if Value <= cMaxSpeed then val:=Value else val:=cMaxSpeed;
  ChangeSpeedEdit(FSpeed,val,EditMeasuringSpeed);
end;

procedure TDetectorConstructorForm.SetTemp_burn(Value: integer);
var
  val: integer;
begin
  if Value <= cMaxPartProfileTemp then val:=Value else val:=cMaxPartProfileTemp;
  ChangeProfileEdit(FTemp_burn,val,EditBurnTemp);
end;

procedure TDetectorConstructorForm.SetTemp_measurment(Value: integer);
var
  val: integer;
begin
  if Value <= cMaxPartProfileTemp then val:=Value else val:=cMaxPartProfileTemp;
  ChangeProfileEdit(FTemp_measurment,val,EditMeasuringTemp);
end;

procedure TDetectorConstructorForm.SetTemp_preheating(Value: integer);
var
  val: integer;
begin
  if Value <= cMaxPartProfileTemp then val:=Value else val:=cMaxPartProfileTemp;
  ChangeProfileEdit(FTemp_preheating,val,EditPreHeatTemp);
end;

procedure TDetectorConstructorForm.SetTime_burn(Value: integer);
var
  val: integer;
begin
  if Value <= cMaxPartProfileTime then val:=Value else val:=cMaxPartProfileTime;
  ChangeProfileEdit(FTime_burn,val,EditBurnTime);
end;

procedure TDetectorConstructorForm.SetTime_measurment(Value: integer);
var
  val: integer;
begin
  if Value <= cMaxPartProfileTime then val:=Value else val:=cMaxPartProfileTime;
  ChangeProfileEdit(FTime_measurment,val,EditMeasuringTime);
end;

procedure TDetectorConstructorForm.SetTime_preheating(Value: integer);
var
  val: integer;
begin
  if Value <= cMaxPartProfileTime then val:=Value else val:=cMaxPartProfileTime;
  ChangeProfileEdit(FTime_preheating,val,EditPreHeatTime);
end;

procedure TDetectorConstructorForm.SpeedBtnAddDetTypeClick(Sender: TObject);
begin
  EnterNewDetTypeForm.ShowModal;
end;

procedure TDetectorConstructorForm.SpeedBtnDelDetTypeClick(Sender: TObject);
var
  temp  : word;
begin
  temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format(rsDeleteDetectorType,[DetTypeName]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

  case temp of
    mrYes:                   // если нажали продолжить
    begin
      DeleteDetType(DetTypeName);
    end;
  end;
end;

procedure TDetectorConstructorForm.DeleteDetType(aDetTypeName: String);
begin
  if not TLDDataModule.IsDetectorTypeUsed(aDetTypeName) then
  begin
    if TLDDataModule.DeleteDetectorType(aDetTypeName) then
    begin
      DetTypeName:='';
      RefreshDetTypeList;
      LoadTempProfile;
    end
    else
      MessageDlg(Format('%s "%s". %s - %s',[rsErrDeleteDetectorType,aDetTypeName,rsDetailInfoAtFile,Application.ExeName+PathDelim+cLogFileName]),mtError,[mbOK],0);
  end
  else
    MessageDlg(Format(rsDeleteDetectorTypeDenied,[aDetTypeName]),mtError, [mbOK], 0);
end;

procedure TDetectorConstructorForm.SpeedBtnSaveChangesClick(Sender: TObject);
begin
  SaveDetType;
  DosimeterTypeConstructorForm.LoadDosTypeParameters;
end;

procedure TDetectorConstructorForm.UpdateTempProfile;
begin
  TempProfile:=CalcProfile(MainForm.TempDeviation,Time_preheating,Temp_preheating,Time_measurment,Temp_measurment,Time_burn,Temp_burn,Speed);
end;

end.
