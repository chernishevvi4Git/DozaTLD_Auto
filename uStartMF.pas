unit uStartMF;

interface

uses
 
// Messages,
  SysUtils, Variants, Math, Classes, Graphics, TypInfo,
  Controls, Forms, Dialogs, StdCtrls,
  uDatamodule,
  uDetector,
  uConst,
  uTLDCommand,
  uLogPassForm,
  uDosimeterConstructorForm,
  uDosimeter, DB, SQLDB, ComCtrls, ExtCtrls,
  Menus, Buttons, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  //DynVarsEh,
  GridsEh, DBAxisGridsEh, DBGridsEh, MemTableDataEh, MemTableEh, DataDriverEh,
  DBCtrlsEh, ComboEx,
  uTypes,
  ATGauge;

// Data.Win.ADODB, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, JvExControls, JvSpeedButton,JvExExtCtrls,JvExtComponent,EhLibVCL, Vcl.Samples.Gauges

type

  TStringColuntName = (fulldosid,dosimetertype,kdos,comment,processed,sourcedose);

  { TStartMeasureW }

  TStartMeasureW = class(TForm)
    ButtonClose: TButton;
    CBoxDosList: TComboBox;
    CBoxRadType: TComboBox;
    EditCalibrDose: TEdit;
    EditDarkCurrent: TEdit;
    LblCalibrDose: TLabel;
    LblCalibrRadType: TLabel;
    LblErr: TLabel;
    LblKSI1: TLabel;
    MemTableEhQueuecomment: TStringField;
    MemTableEhQueuedosimetertype: TStringField;
    MemTableEhQueuefulldoseid: TStringField;
    MemTableEhQueueprocessed: TBooleanField;
    Panel2: TPanel;
    PanelQueue: TPanel;
    PanelTop: TPanel;
    LblTopCaption: TLabel;
    PanelBottom: TPanel;
    PanelDosName: TPanel;
    ImageWarning: TImage;
    PanelImage: TPanel;
    ImageStart: TImage;
    PopupMenuSkip: TPopupMenu;
    pmLost: TMenuItem;
    pmBroken: TMenuItem;
    pmAnother: TMenuItem;
    LblDosTypeVal: TLabel;
    LblEnterDosNumber: TLabel;
    PanelMain: TPanel;
    DBGridEhQueue: TDBGridEh;
    DataSourceQueue: TDataSource;
    MemTableEhQueue: TMemTableEh;
    ADOQueryStartMW: TSQLQuery;
    ShapeConturKSI: TShape;
    ShapeConturDC: TShape;
    SpeedBtnQueueUp: TSpeedButton;
    SpeedBtnQueueDown: TSpeedButton;
    SpeedBtnQueueDel: TSpeedButton;
    SpeedBtnQueueAdd: TSpeedButton;
    PanelInformation: TPanel;
    LblAttention: TLabel;
    LblNumber: TLabel;
    CBoxDosType: TComboBox;
    EditKSI: TEdit;
    LblKSI: TLabel;
    PanelMiddle: TPanel;
    PageControlStart: TPageControl;
    TabSheetStartLoad: TTabSheet;
    TabSheetStartIDK: TTabSheet;
    TabSheetStartQueue: TTabSheet;
    PanelQueueRight: TPanel;
    TabSheetStartMeas: TTabSheet;
    PanelPageIDK: TPanel;
    LblPageFIO: TLabel;
    EditPageIDKPersNumber: TEdit;
    EditPageIDKFIO: TEdit;
    PanelPageMeas: TPanel;
    EditPageMeasStatusD1: TEdit;
    GaugePageMeasStatusD1: TATGauge;
    LblPageMeasD1: TLabel;
    EditPageMeasStatusD2: TEdit;
    EditPageMeasStatusD3: TEdit;
    EditPageMeasStatusD4: TEdit;
    GaugePageMeasStatusD2: TATGauge;
    GaugePageMeasStatusD3: TATGauge;
    GaugePageMeasStatusD4: TATGauge;
    LblPageMeasD2: TLabel;
    LblPageMeasD3: TLabel;
    LblPageMeasD4: TLabel;
    LblPageMeasComment: TLabel;
    MemoPageMeasComment: TMemo;
    LblOrg: TLabel;
    LblDep: TLabel;
    EditOrg: TEdit;
    EditDep: TEdit;
    LblPageIDKPersNumber: TLabel;
    LblFilter: TLabel;
    CBoxFiilter: TComboBox;
    ShapeContur: TShape;
    PaneQueuelGrid: TPanel;
    TabSheetStartCalibr: TTabSheet;
    PanelCalibrRight: TPanel;
    SpeedButtonCalibrAdd: TSpeedButton;
    SpeedButtonCalibrDel: TSpeedButton;
    SpeedButtonCalibrDown: TSpeedButton;
    SpeedButtonCalibrUp: TSpeedButton;
    PanelCalibrlGrid: TPanel;
    DBGridEhCalibr: TDBGridEh;
    MemTableEhCalibr: TMemTableEh;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField4: TStringField;
    BooleanField1: TBooleanField;
    DataSourceCalibr: TDataSource;
    PanelCalibrBottom: TPanel;
    BtnCalibrPageClose: TButton;
    EditPageCalibrKDos: TEdit;
    LblPageCalibrKDos: TLabel;
    PanelBottomGrid: TPanel;
    BtnPageCalibrFinish: TButton;
    StringField5: TStringField;
    PanelQueueBottom: TPanel;
    BtnQueuePageClose: TButton;
    Panel1: TPanel;
    LblPageQueueComment: TLabel;
    EditPageQueueComment: TEdit;
    BtnPageQueueFinish: TButton;
    procedure BtnNextClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure CBoxDosListChange(Sender: TObject);
    procedure CBoxDosListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBoxDosListSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure DBGridEhQueueCellClick(Column: TColumnEh);
    procedure PageControlStartChange(Sender: TObject);
    procedure SpeedBtnQueueDownClick(Sender: TObject);
    procedure SpeedBtnQueueUpClick(Sender: TObject);
    procedure SpeedBtnQueueDelClick(Sender: TObject);
    procedure SpeedBtnQueueAddClick(Sender: TObject);
    procedure BtnQueueClick(Sender: TObject);
    procedure CBoxDosTypeChange(Sender: TObject);
    procedure CBoxDosTypeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditCalibrDoseKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditEnable(Sender: TObject);
    procedure EditDisable(Sender: TObject);
    procedure FormClose(Sender: TObject; var anAction: TCloseAction);
    procedure SpeedBtnStopMeasClick(Sender: TObject);
    procedure MemoPageMeasCommentChange(Sender: TObject);
    procedure EditPageIDKPersNumberChange(Sender: TObject);
    procedure EditPageIDKFIOChange(Sender: TObject);
    procedure EditOrgChange(Sender: TObject);
    procedure EditDepChange(Sender: TObject);
    procedure CBoxFiilterChange(Sender: TObject);
    procedure SpeedButtonCalibrAddClick(Sender: TObject);
    procedure SpeedButtonCalibrDelClick(Sender: TObject);
    procedure SpeedButtonCalibrDownClick(Sender: TObject);
    procedure DBGridEhCalibrCellClick(Column: TColumnEh);
    procedure SpeedButtonCalibrUpClick(Sender: TObject);
    procedure EditCalibrDoseChange(Sender: TObject);
    procedure BtnPageCalibrFinishClick(Sender: TObject);
    procedure BtnQueuePageCloseClick(Sender: TObject);
    procedure BtnCalibrPageCloseClick(Sender: TObject);
    procedure EditPageQueueCommentChange(Sender: TObject);
    procedure BtnPageQueueFinishClick(Sender: TObject);
    procedure CBoxRadTypeChange(Sender: TObject);
  private
    FQueuePanelHeight  : integer;
    FNewDosimeter      : TNewDosimeter;
    FCalibrSourceDose  : double;
    FRadTypeIndex      : integer;
    FStartView         : TProcessType;

    procedure SetStartView(AValue: TProcessType);
    procedure UpdateForm;
    procedure UpdateQueueGrid(DBGridEh: TDBGridEh);
    procedure UpdateCalibrGrid(DBGridEh: TDBGridEh);
    procedure PanelInfPanelHide(aVisible: boolean);

    procedure LoadQueueFromFile(MemTable: TMemTableEh; DBGridEh: TDBGridEh);
    procedure LoadCalibrFromFile(MemTable: TMemTableEh; DBGridEh: TDBGridEh);
    procedure LoadFromFile(MemTable: TMemTableEh; DBGridEh: TDBGridEh; FileName: String; Separator: char);
    procedure AddNewDosimeter(FullNumber: String);
    procedure ParseDosNumber(FullNumber: String; var aNumber: String; var aPostfix: String);
    procedure HideDetectors(DetCnt: integer);

    //procedure SetSourceDose(Value: double);
    //procedure SetMeasComment(Value: String);

    function IsQueueChanged                             : boolean;
    function IsDosimeterAvalable(FullDosID: String)     : boolean;
    function GetSQLManyColFiltered                      : String;
    function GetCalibrSourceDose                        : double;
    { Private declarations }
  public
    MeasComment       : String;

    //procedure ShowModal(const Value: TProcessType); overload;
    procedure NextDosimeterInQueue;
    procedure EnableControls(Value: boolean);
    procedure PanelQueuePanelHide(aVisible: boolean);
    procedure LoadDosimeterPicture(DosType: integer; PictureIndex: integer);
    procedure LoadFilterPicture(PictureIndex: integer);
    procedure ChangeControls(Step: integer);
    procedure FirstStep;
    procedure NextStep;
    procedure PreviousStep;
    procedure SaveToQueueFile;
    procedure SaveToCalibrationFile;
    procedure AddDosToCalibrationFile(DosName: String);
    //procedure SetKDosInCalibrationFile(KDos: double);
    procedure SetFinishMeasInQueueFile(DosNumber: String);
    procedure SetCommentInQueueFile(DosNumber: String);
    procedure FinishCalibraion;
    procedure FinishQueue;
    procedure RenameTXTFile(FileName: String);

    function GetDosPicture(DosType: integer; PictureIndex: integer): String;
    function IsValidDosNumber(DosNumber: String): boolean;
    function CalcKDos: double;
    function GetAverageKDos: double;

    property StartView: TProcessType read FStartView write SetStartView;
    //property MeasComment: String read FMeasComment write SetMeasComment;
    property CalibrSourceDose: double read GetCalibrSourceDose write FCalibrSourceDose;
    { Public declarations }
  end;

const
  cInfHeight = 230;

var
  StartMeasureW: TStartMeasureW;

implementation

uses
  uLanguages,
  EhLibMTE,
  uSeparator,
  uFunctions,
  uLog,
  uAddDosInQueue,
  uAddDosInCalibr,
  uMainForm;
{$R *.dfm}

function TStartMeasureW.GetAverageKDos: double;
var
  i         : integer;
  sumK      : double;
begin
  if MemTableEhCalibr.RecordCount>0 then
  begin
    sumK:=0;

    MemTableEhCalibr.First;

    for i := 0 to MemTableEhCalibr.RecordCount-1 do
    begin
      sumK:=sumK+StrToFloatRegion(MemTableEhCalibr.FieldByName(cKDos).AsString);
      MemTableEhCalibr.Next;
    end;

    Result:=RoundToCN(sumK/MemTableEhCalibr.RecordCount,cAfterComma);

    EditPageCalibrKDos.Text:=FloatToStrRegion(Result);
  end
  else
  begin
    Result:=-1;
    EditPageCalibrKDos.Clear;
  end;
end;

function TStartMeasureW.GetDosPicture(DosType: integer; PictureIndex: integer): String;
const
  cUnknown = 'Unknown';
var
  dosName     : String;
  dosDirectry : String;
begin
  Result:='';

  dosName:=TLDDataModule.GetDosType(DosType);
  dosDirectry:=extractfilepath(Application.ExeName)+'Images'+PathDelim+'Dosimeters'+PathDelim+dosName;

  if not DirectoryExists(dosDirectry) then
    dosDirectry:=extractfilepath(Application.ExeName)+'Images'+PathDelim+'Dosimeters'+PathDelim+cUnknown;

  if DirectoryExists(dosDirectry) then
  case PictureIndex of
    cPictureDosNumber: Result:=dosDirectry+PathDelim+'Number.bmp';
    cPictureDosLoadD1: Result:=dosDirectry+PathDelim+'D1.bmp';
    cPictureDosLoadD2: Result:=dosDirectry+PathDelim+'D2.bmp';
    cPictureDosLoadD3: Result:=dosDirectry+PathDelim+'D3.bmp';
    cPictureDosLoadD4: Result:=dosDirectry+PathDelim+'D4.bmp';
  end;

  if useLanguageFile then
    if FileExists('Language'+PathDelim+ Result) then
      Result:='Language'+PathDelim+ Result;
end;

function TStartMeasureW.IsValidDosNumber(DosNumber: String): boolean;
var
  number: integer;
begin
//  if DosNumber.IsEmpty then
  if DosNumber='' then
  begin
    if not LblErr.Visible then
      LblErr.Visible:=true;

    LblErr.Caption:=rsInputDosimeterNumber;
    Result:=false;
  end
  else if not TryStrToInt(DosNumber[1],number) then
  begin
    if not LblErr.Visible then
      LblErr.Visible:=true;

    LblErr.Caption:=rsDosNumMustStartCiph;
    Result:=false;
  end
  else
  begin
    if LblErr.Visible then
      LblErr.Visible:=false;

    Result:=true;
  end;
end;

procedure TStartMeasureW.LoadDosimeterPicture(DosType: integer;
  PictureIndex: integer);
var
  imagePath: String;
begin
  imagePath:=GetDosPicture(DosType,PictureIndex);
  if useLanguageFile then
    if FileExists('Language'+PathDelim+ imagePath) then
      imagePath:='Language'+PathDelim+ imagePath;
  if FileExists(imagePath) then
    ImageStart.Picture.Bitmap.LoadFromFile(imagePath)
  else
    WriteLog(Format(rsImageNotFound,[imagePath]));
end;

procedure TStartMeasureW.LoadFilterPicture(PictureIndex: integer);
var
  PicturePath: String;
begin
  PicturePath :='';
  case PictureIndex of
    0:
    begin
      PicturePath := extractfilepath(Application.ExeName)+'Images'+PathDelim+'Dosimeters'+PathDelim+'Filter'+PathDelim+'Filter_Need_To_Installed.bmp';
    end;
    1:
    begin
      PicturePath := extractfilepath(Application.ExeName)+'Images'+PathDelim+'Dosimeters'+PathDelim+'Filter'+PathDelim+'Filter_Installed.bmp';
    end;
    2:
    begin
      PicturePath := extractfilepath(Application.ExeName)+'Images'+PathDelim+'Dosimeters'+PathDelim+'Filter'+PathDelim+'Filter_Not_Installed.bmp';
    end;
  end;
  if useLanguageFile then
    if FileExists('Language'+PathDelim+ PicturePath) then
      PicturePath:='Language'+PathDelim+ PicturePath;
  ImageStart.Picture.Bitmap.LoadFromFile(PicturePath);
end;

procedure TStartMeasureW.AddDosToCalibrationFile(DosName: String);
var
  i             : integer;
  fullPath      : String;
  strList       : TStringList;
  insertString  : String;
  headerString  : String;
  useQueue      : boolean;
begin
  fullPath:=extractfilepath(Application.ExeName)+cCalibration+PathDelim+cCalibration+cExtTXT;
  useQueue:=false;

  if Assigned(MainForm.Dosimeter) then
  begin
    strList:=TStringList.Create;

    insertString:=Format('%s;%s;%s;%s;%s;',[MainForm.Dosimeter.FullNumber,
                                               MainForm.Dosimeter.DosType,
                                               '-1',
                                               '1',
                                               'False']);
    if FileExists(fullPath) then
    begin
      strList.LoadFromFile(fullPath);


      for i := 1 to strList.Count-1 do
      begin
        if (Pos(MainForm.Dosimeter.FullNumber+';',strList[i])>0) AND
           (Pos(';'+MainForm.Dosimeter.DosType+';',strList[i])>0) AND
           (Pos(';'+'-1'+';',strList[i])>0) then
        begin
          strList[i]:=insertString;
          useQueue:=true;
        end;

      end;

      if not useQueue then
        strList.Add(insertString);

    end
    else
    begin
      headerString:=Format('%s;%s;%s;%s;%s;',[cFullDosID,
                                              cFieldDosType,
                                              cSourceDose,
                                              cKDos,
                                              cProcessed]);
      strList.Add(headerString);
      strList.Add(insertString);
    end;

    strList.SaveToFile(fullPath);
    strList.Free;
  end;
end;

procedure TStartMeasureW.AddNewDosimeter(FullNumber: String);
var
  dosNumber   : String;
  dosPostfix  : String;
  formulaindex: integer;
begin

  ParseDosNumber(FullNumber,dosNumber,dosPostfix);

  FNewDosimeter.DosId:=dosNumber;
  FNewDosimeter.Postfix:=dosPostfix;
  FNewDosimeter.Organization:='';
  FNewDosimeter.Department:='';
  FNewDosimeter.DosTypeId:=TLDDataModule.GetDosTypeID(CBoxDosType.Items[CBoxDosType.ItemIndex]);
  FNewDosimeter.DosType:=TLDDataModule.GetDosType(FNewDosimeter.DosTypeId);
  FNewDosimeter.Status:=cDosNotCalibrated;
  FNewDosimeter.Partid:=0;
  FNewDosimeter.Tldid:=MainForm.DeviceID;

  FNewDosimeter.K1:=NaN;
  FNewDosimeter.K2:=NaN;
  FNewDosimeter.K3:=NaN;
  FNewDosimeter.K4:=NaN;
  FNewDosimeter.K5:=NaN;
  FNewDosimeter.Kgn:=NaN;

  formulaindex:=TLDDataModule.GetDosTypeFormulaID(FNewDosimeter.DosType);
  case cDetMeasValTxt_Index[formulaIndex] of
    c_none:
    begin

    end;
    cHp_10g_1d,
    cHp_10g_2d,
    cHp_10g_3d,
    cHp_10g_4d,
    cHp_007g_1d,
    cHp_007g_2d,
    cHp_007g_3d,
    cHp_007g_4d,
    cHp_007gb_1d,
    cHp_007gb_2d,
    cHp_007gb_3d,
    cHp_007gb_4d,
    cHp_3_1d,
    cHp_3_2d,
    cHp_3_3d,
    cHp_3_4d,
    cHp_star_g_1d,
    cHp_star_g_2d,
    cHp_star_g_3d,
    cHp_star_g_4d,
    cH_007_dir_g_1d,
    cH_007_dir_g_2d,
    cH_007_dir_g_3d,
    cH_007_dir_g_4d,
    cD_1d,
    cD_2d,
    cD_3d,
    cD_4d:
    begin
      FNewDosimeter.K1:=1;
    end;
    cHp_10g_2d_Hp_10n_2d,
    cHp_10g_2d_Hp_10n_1d,
    cHp_10g_1d_Hp_10n_2d,
    cHp_10g_1d_Hp_10n_1d,
    cHp_10g_1d_Hp_007g_1d:
    begin
      FNewDosimeter.K1:=1;
      FNewDosimeter.K2:=1;
      FNewDosimeter.Kgn:=1;
    end;
    cHp_10g_Hp_10n_Hp_007g_Hp_3:
    begin
      FNewDosimeter.K1:=1;
      FNewDosimeter.K2:=1;
      FNewDosimeter.K3:=1;
      FNewDosimeter.K4:=1;
      FNewDosimeter.Kgn:=1;
    end;
    cHp_10g_1d_Hp_007g_1d_Hp_3_1d,
    cHp_10g_2d_Hp_10n_2d_f6776:
    begin
      FNewDosimeter.K1:=1;
      FNewDosimeter.K2:=1;
      FNewDosimeter.K3:=1;
      FNewDosimeter.K4:=1;
    end
    else
    begin
      FNewDosimeter.K1:=1;
    end;
  end;

  try
    ADOQueryStartMW.SQL.Clear; // очистить текст sql
    ADOQueryStartMW.SQL.Add('INSERT INTO tlddosimeterid('+cFieldDosID+','
                                                         +cFieldDosPostfix+','
                                                         +cFieldDosTypeID+','
                                                         +cFieldDosType+','
                                                         +cFieldDosStatus+','
                                                         +cField_k1+','
                                                         +cField_k2+','
                                                         +cField_k3+','
                                                         +cField_k4+','
                                                         +cField_k5+','
                                                         +cField_kgn+','
                                                         +cFieldTldID+','
                                                         +cFieldPartID+','
                                                         +cFieldRegTime+','
                                                         +cFieldVerTime+','
                                                         +cFieldOrg+','
                                                         +cFieldDepartment+','
                                                         +cFieldLastMeasComment+')'
                                           +'VALUES('+#39+FNewDosimeter.DosId+#39+','
                                                     +#39+FNewDosimeter.Postfix+#39+','
                                                     +#39+IntToStr(FNewDosimeter.DosTypeId)+#39+','
                                                     +#39+FNewDosimeter.DosType+#39+','
                                                     +#39+IntToStr(FNewDosimeter.Status)+#39+','
                                                         +FloatToStrRegion(FNewDosimeter.K1)+','
                                                         +FloatToStrRegion(FNewDosimeter.K2)+','
                                                         +FloatToStrRegion(FNewDosimeter.K3)+','
                                                         +FloatToStrRegion(FNewDosimeter.K4)+','
                                                         +FloatToStrRegion(FNewDosimeter.K5)+','
                                                         +FloatToStrRegion(FNewDosimeter.Kgn)+','
                                                         +IntToStr(FNewDosimeter.Tldid)+','
                                                         +IntToStr(FNewDosimeter.Partid)+','
                                                     +#39+DateTimeToStr(Now)+#39+','
                                                     +#39+DateToStr(FNewDosimeter.Vertime)+#39+','
                                                     +#39+FNewDosimeter.Organization+#39+','
                                                     +#39+FNewDosimeter.Department+#39+','
                                                     +#39+FNewDosimeter.DosComment+#39
                                                     +')');

    ADOQueryStartMW.ExecSQL;
    WriteLog(rsAddedDosimeter + FNewDosimeter.DosId);
  except
    Showmessage(rsErrAddedDosimeter + FNewDosimeter.DosId);
    WriteLog(rsErrAddedDosimeter + FNewDosimeter.DosId);
  end;

end;

procedure TStartMeasureW.BtnCalibrPageCloseClick(Sender: TObject);
begin
  PreviousStep;
end;

procedure TStartMeasureW.BtnCancelClick(Sender: TObject);
begin
  PreviousStep;
end;

procedure TStartMeasureW.BtnPageCalibrFinishClick(Sender: TObject);
begin
  FinishCalibraion;
end;

procedure TStartMeasureW.BtnPageQueueFinishClick(Sender: TObject);
begin
  FinishQueue;
end;

procedure TStartMeasureW.BtnNextClick(Sender: TObject);
var
  newDosName: String;
  newDosType: String;
begin
  case StartView of
    cStartSingleMeas,
    cStartSeriaMeas,
    cTesting,
    cBurning,
    cGrading:
    begin
      if TLDDataModule.IsDosimeterExist(CBoxDosList.Text) then
      begin
        NextStep;
        if LblErr.Visible then LblErr.Visible:=false;
      end
      else
      begin
        if CBoxDosList.Text<>'' then
          LblEnterDosNumber.Caption:=rsDosimeterNotInList;

        if not LblEnterDosNumber.Visible then LblEnterDosNumber.Visible:=true;
        ImageStart.Picture:=nil;
      end;
    end;
    cIrradiation,
    cStartCalibration,
    cRegistration:
    begin
      if not TLDDataModule.IsDosimeterExist(CBoxDosList.Text) and (IsValidDosNumber(CBoxDosList.Text))then
      begin
        if CBoxDosType.ItemIndex >= 0 then
        begin
          newDosName:=CBoxDosList.Text;
          newDosType:=CBoxDosType.Text;

          AddNewDosimeter(CBoxDosList.Text);

          UpdateForm;
          CBoxDosList.ItemIndex:=CBoxDosList.Items.IndexOf(newDosName);   // возвращаем фокус на добавленный дозиметр
          CBoxDosType.ItemIndex:=CBoxDosType.Items.IndexOf(newDosType);
        end
        else
        begin
          LblErr.Caption:=rsGiveDosimeterType + '!';
          if not LblErr.Visible then LblErr.Visible:=true;
        end;
      end;

      if TLDDataModule.IsDosimeterExist(CBoxDosList.Text) then
      begin
        if CalibrSourceDose>0 then
        begin
          NextStep;
          if LblErr.Visible then LblErr.Visible:=false;
        end
        else
        begin
          LblErr.Caption:=rsGiveDose;
          if not LblErr.Visible then LblErr.Visible:=true;
        end;
      end;

    end;
  end;
end;

procedure TStartMeasureW.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TStartMeasureW.CBoxDosListChange(Sender: TObject);
var
  i,SumDet: integer;
begin
  MainForm.TLDCommand.ChangeData.DosimeterFound := dsfNotFound; // Передача весточки в машину состояний
  if IsDosimeterAvalable(CBoxDosList.Text) then
  begin
    if Assigned(MainForm.Dosimeter) then FreeAndNil(MainForm.Dosimeter);

    MainForm.Dosimeter:=TDosimeter.Create(CBoxDosList.Text);
    MainForm.HideDetectorsPanel(MainForm.GetDetCnt(MainForm.Dosimeter.DosType));
    MainForm.Dosimeter.OnChangeFullNumber(Self);
    MainForm.Dosimeter.OnChangeValidity(Self);
    MainForm.Dosimeter.OnChangeDose(Self);
    MainForm.Dosimeter.OnChangeErr(Self);
    MainForm.Dosimeter.OnChangeStatus(Self);
    MainForm.Dosimeter.OnChangeDoseType(Self);
    MainForm.Dosimeter.OnChangeKS(Self);
    MainForm.Dosimeter.OnChangeK(Self);
    MainForm.Dosimeter.OnChangeKFilter(Self);
    MainForm.Dosimeter.OnChangeKDevice(Self);
    MainForm.Dosimeter.OnChangeFormula(Self);
    MainForm.Dosimeter.OnChangeMeasTime(Self);
    MainForm.Dosimeter.OnChangeVerTime(Self);

    MainForm.Dosimeter.TldUser:=AW.CurrentUser.Login;
    MainForm.Dosimeter.Organization:=EditOrg.Text;
    MainForm.Dosimeter.Department:=EditDep.Text;
    MainForm.Dosimeter.Fio:=EditPageIDKFIO.Text;
    MainForm.Dosimeter.PersNumber:=StrToIntRegion(EditPageIDKPersNumber.Text);

    MainForm.Dosimeter.OnChangeOrganization(Self);
    MainForm.Dosimeter.OnChangeDepartment(Self);
    MainForm.Dosimeter.OnChangePersNumber(Self);
    MainForm.Dosimeter.OnChangeFio(Self);
    MainForm.Dosimeter.OnChangeMeasComment(Self);
    MainForm.Dosimeter.OnShowTempProfileWrite(Self);

    case StartView of
      cStartSeriaMeas:
        MainForm.Dosimeter.MeasComment:=EditPageQueueComment.Text;
    end;

    HideDetectors(MainForm.GetDetCnt(MainForm.Dosimeter.DosType));

    EditPageIDKPersNumber.Clear;
    EditPageIDKFIO.Clear;

    LblEnterDosNumber.Caption:=rsGiveDosimeterNumber;

    LoadDosimeterPicture(StrToInt(MainForm.Dosimeter.DosTypeID),cPictureDosNumber);

    if CBoxDosType.Enabled then CBoxDosType.Enabled:=false;

    if StartMeasureW.EditOrg.GetTextLen=0 then
      StartMeasureW.EditOrg.Text:=MainForm.Dosimeter.Organization;

    if StartMeasureW.EditDep.GetTextLen=0 then
      StartMeasureW.EditDep.Text:=MainForm.Dosimeter.Department;

    LblEnterDosNumber.Visible:=false;
    LblErr.Visible:=false;
    //BtnNext.Enabled:=true;

    if Showing then
      if MainForm.HidePanels then
        MainForm.HidePanels:=false;

    MainForm.TLDCommand.ChangeData.DosimeterFound := dsfFound; // Передача весточки в машину состояний
    SumDet:=0;
    for i:=0 to MainForm.Dosimeter.DetectorsList.Count-1 do
      if MainForm.Dosimeter.DetectorsList.Items[i]<>Nil then SumDet:=SumDet+1;
    MainForm.TLDCommand.ChangeData.DetectorCount := SumDet;
    MainForm.TLDCommand.Panel.Output.DetectorsCount := SumDet;


    //MainForm.GetTempProfileToUI(TDetector(MainForm.Dosimeter.DetectorsList[1]).DetTypeComment);

    //MainForm.TLDCommand.ChangeData.TimeToSet := TDetector(MainForm.Dosimeter.DetectorsList[1]).MeasureTime.; // for first detectors (2,3)

    //TDetector(MainForm.Dosimeter.DetectorsList[0]).MeasureTime;
  end
  else
  begin
    case StartView of
      cStartSingleMeas,
      cStartSeriaMeas,
      cBurning,
      cGrading,
      cTesting:
      begin
        //BtnNext.Enabled:=false;
        ImageStart.Picture:=nil;
        LblEnterDosNumber.Visible:=true;

        CBoxDosType.ItemIndex:=-1;

        if CBoxDosList.Text<>'' then
          LblEnterDosNumber.Caption:=rsDosimeterNotInList;
      end;
      cIrradiation,
      cStartCalibration,
      cRegistration:
      begin
        //BtnNext.Enabled:=false;

        if CBoxDosType.ItemIndex<0 then
        begin
          //BtnNext.Enabled:=false;
          ImageStart.Picture:=nil;
          LblEnterDosNumber.Visible:=true;
        end;

        if not CBoxDosType.Enabled then
        begin
          CBoxDosType.Enabled:=true;
          CBoxDosType.ItemIndex:=-1;
        end;

        //CBoxDosType.Enabled:=true;
        //CBoxDosType.ItemIndex:=-1;

        if (CBoxDosList.Text<>'') AND (CBoxDosType.ItemIndex<0) then
          LblEnterDosNumber.Caption:=rsDosimeterNotFound;
      end;
    end;
  end;
end;

procedure TStartMeasureW.CBoxDosListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = cVK_Enter) then
  begin
    if not CBoxDosType.Enabled then
    begin
      if PageControlStart.ActivePage=TabSheetStartLoad then
      begin
        //if BtnNext.Enabled then BtnNext.SetFocus;
      end;
    end
    else
      CBoxDosType.SetFocus;
  end;
end;

procedure TStartMeasureW.CBoxDosListSelect(Sender: TObject);
begin
  {if not CBoxDosType.Enabled then
    if BtnNext.Enabled then BtnNext.SetFocus
  else
    CBoxDosType.SetFocus; }
end;

procedure TStartMeasureW.BtnQueueClick(Sender: TObject);
begin
  if PanelQueue.Visible then
  begin
    PanelQueue.Visible:=false;
    StartMeasureW.Height:=StartMeasureW.Height-PanelQueue.Height;
  end
  else
  begin
    PanelQueue.Visible:=true;
    StartMeasureW.Height:=StartMeasureW.Height+PanelQueue.Height;
  end;
end;

procedure TStartMeasureW.BtnQueuePageCloseClick(Sender: TObject);
begin
  PreviousStep;
end;

procedure TStartMeasureW.PanelInfPanelHide(aVisible: boolean);
begin
  if PanelInformation.Visible<> Visible then
  begin
    if not Visible then
    begin
      PanelInformation.Visible:=false;
      StartMeasureW.Height:=StartMeasureW.Height-cInfHeight;
    end
    else
    begin
      PanelInformation.Visible:=true;
      StartMeasureW.Height:=StartMeasureW.Height+cInfHeight;
    end;
  end;
end;

procedure TStartMeasureW.PanelQueuePanelHide(aVisible: boolean);
begin
  if PanelQueue.Visible <> Visible then
  begin
    if not Visible then
    begin
      PanelQueue.Visible:=false;
      StartMeasureW.Height:=StartMeasureW.Height-PanelQueue.Height;
    end
    else
    begin
      PanelQueue.Visible:=true;
      StartMeasureW.Height:=StartMeasureW.Height+PanelQueue.Height;
    end;
  end;
end;

procedure TStartMeasureW.ParseDosNumber(FullNumber: String; var aNumber: String; var aPostfix: String);
var
  i       : integer;
  n       : integer;
  number  : String;
  postfix : String;
begin
  n:=0;
  number:=FullNumber;
  postfix:=cEmptyData;

  for i := Low(FullNumber) to High(FullNumber) do
  begin
    if not TryStrToInt(FullNumber[i],n) then
    begin
      number:=copy(FullNumber,Low(FullNumber),i-1);
      if Length(FullNumber)-i > 0 then
        postfix:=copy(FullNumber,i)
      else
        postfix:=cEmptyData;
      break
    end;

  end;
  aNumber:=number;
  aPostfix:=postfix;
end;

function TStartMeasureW.CalcKDos: double;
begin
  if Assigned(MainForm.Dosimeter) then
  begin
    case MainForm.Dosimeter.FormulaID of
      cHp_10g_1d,
      cHp_10g_2d,
      cHp_10g_3d,
      cHp_10g_4d:
      begin
        Result:=RoundToCN(MainForm.Dosimeter.Dose_Hp_10g/CalibrSourceDose,cAfterComma);
      end;
      cHp_007g_1d,
      cHp_007g_2d,
      cHp_007g_3d,
      cHp_007g_4d,
      cHp_007gb_1d,
      cHp_007gb_2d,
      cHp_007gb_3d,
      cHp_007gb_4d:
      begin
        Result:=RoundToCN(MainForm.Dosimeter.Dose_Hp_007/CalibrSourceDose,cAfterComma);
      end;
      cHp_3_1d,
      cHp_3_2d,
      cHp_3_3d,
      cHp_3_4d:
      begin
        Result:=RoundToCN(MainForm.Dosimeter.Dose_Hp_3/CalibrSourceDose,cAfterComma);
      end;
      cHp_star_g_1d,
      cHp_star_g_2d,
      cHp_star_g_3d,
      cHp_star_g_4d:
      begin
        Result:=RoundToCN(MainForm.Dosimeter.Dose_H_star/CalibrSourceDose,cAfterComma);
      end;
      cH_007_dir_g_1d,
      cH_007_dir_g_2d,
      cH_007_dir_g_3d,
      cH_007_dir_g_4d:
      begin
        Result:=RoundToCN(MainForm.Dosimeter.Dose_H_007/CalibrSourceDose,cAfterComma);
      end;
      cD_1d,
      cD_2d,
      cD_3d,
      cD_4d:
      begin
        Result:=RoundToCN(MainForm.Dosimeter.Dose_D/CalibrSourceDose,cAfterComma);
      end;
      else
        Result:=-1;
    end;

  end
  else
    Result:=-1;
end;

procedure TStartMeasureW.CBoxDosTypeChange(Sender: TObject);

begin
  if CBoxDosType.ItemIndex >= 0 then
  begin
    LblErr.Visible:=false;
    LblEnterDosNumber.Visible:=false;
    LoadDosimeterPicture(TLDDataModule.GetDosTypeID(CBoxDosType.Text),cPictureDosNumber);
    //if not BtnNext.Enabled then BtnNext.Enabled:=true;
  end;
end;

procedure TStartMeasureW.CBoxDosTypeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  cVK_Enter = $0D;          //  кнопка Enter
begin
  if (Key = cVK_Enter) then
  begin
    EditCalibrDose.SetFocus;  //?
  end;
end;

function TStartMeasureW.IsDosimeterAvalable(FullDosID: String): boolean;
begin
  case StartView of
    cStartSingleMeas,
    cStartCalibration,
    cTesting:
      Result:=TLDDataModule.IsDosimeterExist(FullDosID);
    cStartSeriaMeas,
    cRegistration:
    begin
      if CBoxDosList.Items.IndexOf(FullDosID)>=0 then
        Result:=true
      else
        Result:=false;
    end;
    else
      Result:=false;
  end
end;

procedure TStartMeasureW.ChangeControls(Step: integer);
begin
  case Step of
    cTablePosStart:
    begin
      
    end;
    cTablePosFilter:
    begin
      //LblCurrentStep.Caption:=rsCheckFilter;
//      BtnCancel.Caption:=rsBack;
      //BtnNext.Caption:=rsSmNext;

      LoadFilterPicture(0);

      //if JvSpeedBtnSkip.Visible then JvSpeedBtnSkip.Visible:=false;
      if CBoxFiilter.Enabled then CBoxFiilter.Enabled:=false;
      if CBoxDosList.Enabled then CBoxDosList.Enabled:=false;
      if CBoxDosType.Enabled then CBoxDosType.Enabled:=false;
      //if EditCalibrDose.Enabled then EditCalibrDose.Enabled:=false;
      if CBoxRadType.Enabled then CBoxRadType.Enabled:=false;

      if not DBGridEhQueue.Enabled then DBGridEhQueue.Enabled:=true;
      if not SpeedBtnQueueAdd.Enabled then SpeedBtnQueueAdd.Enabled:=true;
      if not SpeedBtnQueueUp.Enabled then SpeedBtnQueueUp.Enabled:=true;
      if not SpeedBtnQueueDown.Enabled then SpeedBtnQueueDown.Enabled:=true;
      if not SpeedBtnQueueDel.Enabled then SpeedBtnQueueDel.Enabled:=true;
    end;
    cTablePosKSI:
    begin
      //LblCurrentStep.Caption := rsSmKSIReading;
//      BtnCancel.Caption := rsBack;
      //BtnNext.Caption := rsSmNext;

      if LblEnterDosNumber.Visible then LblEnterDosNumber.Visible:=false;

      LoadDosimeterPicture(StrToInt(MainForm.Dosimeter.DosTypeID),cPictureDosNumber);

      //if JvSpeedBtnSkip.Visible then JvSpeedBtnSkip.Visible:=false;
      if CBoxFiilter.Enabled then CBoxFiilter.Enabled:=false;
      if CBoxDosList.Enabled then CBoxDosList.Enabled:=false;
      if CBoxDosType.Enabled then CBoxDosType.Enabled:=false;
      //if EditCalibrDose.Enabled then EditCalibrDose.Enabled:=false;
      if CBoxRadType.Enabled then CBoxRadType.Enabled:=false;

      if DBGridEhQueue.Enabled then DBGridEhQueue.Enabled:=false;
      if SpeedBtnQueueAdd.Enabled then SpeedBtnQueueAdd.Enabled:=false;
      if SpeedBtnQueueUp.Enabled then SpeedBtnQueueUp.Enabled:=false;
      if SpeedBtnQueueDown.Enabled then SpeedBtnQueueDown.Enabled:=false;
      if SpeedBtnQueueDel.Enabled then SpeedBtnQueueDel.Enabled:=false;
    end;
    cTablePosD1:
    begin
      //LblCurrentStep.Caption:= rsSmLoadD1;
//      BtnCancel.Caption := rsBack;
      //BtnNext.Caption := rsSmNext;

      LoadDosimeterPicture(StrToInt(MainForm.Dosimeter.DosTypeID),cPictureDosLoadD1);

      //if not JvSpeedBtnSkip.Visible then JvSpeedBtnSkip.Visible:=true;
      if CBoxDosList.Enabled then CBoxDosList.Enabled:=false;
      if CBoxDosType.Enabled then CBoxDosType.Enabled:=false;
      //if EditCalibrDose.Enabled then EditCalibrDose.Enabled:=false;
      if CBoxRadType.Enabled then CBoxRadType.Enabled:=false;

      if DBGridEhQueue.Enabled then DBGridEhQueue.Enabled:=false;
      if SpeedBtnQueueAdd.Enabled then SpeedBtnQueueAdd.Enabled:=false;
      if SpeedBtnQueueUp.Enabled then SpeedBtnQueueUp.Enabled:=false;
      if SpeedBtnQueueDown.Enabled then SpeedBtnQueueDown.Enabled:=false;
      if SpeedBtnQueueDel.Enabled then SpeedBtnQueueDel.Enabled:=false;
    end;
    cTablePosD2:
    begin
      //LblCurrentStep.Caption := rsSmLoadD2;
//      BtnCancel.Caption := rsBack;
      //BtnNext.Caption := rsSmNext;

      LoadDosimeterPicture(StrToInt(MainForm.Dosimeter.DosTypeID),cPictureDosLoadD2);

      //if not JvSpeedBtnSkip.Visible then JvSpeedBtnSkip.Visible:=true;
      if CBoxDosList.Enabled then CBoxDosList.Enabled:=false;
      if CBoxDosType.Enabled then CBoxDosType.Enabled:=false;
      //if EditCalibrDose.Enabled then EditCalibrDose.Enabled:=false;
      if CBoxRadType.Enabled then CBoxRadType.Enabled:=false;

      if DBGridEhQueue.Enabled then DBGridEhQueue.Enabled:=false;
      if SpeedBtnQueueAdd.Enabled then SpeedBtnQueueAdd.Enabled:=false;
      if SpeedBtnQueueUp.Enabled then SpeedBtnQueueUp.Enabled:=false;
      if SpeedBtnQueueDown.Enabled then SpeedBtnQueueDown.Enabled:=false;
      if SpeedBtnQueueDel.Enabled then SpeedBtnQueueDel.Enabled:=false;
    end;
    cTablePosD3:
    begin
      //LblCurrentStep.Caption := rsSmLoadD3;
//      BtnCancel.Caption := rsBack;
      //BtnNext.Caption := rsSmNext;

      LoadDosimeterPicture(StrToInt(MainForm.Dosimeter.DosTypeID),cPictureDosLoadD3);

      //if not JvSpeedBtnSkip.Visible then JvSpeedBtnSkip.Visible:=true;
      if CBoxDosList.Enabled then CBoxDosList.Enabled:=false;
      if CBoxDosType.Enabled then CBoxDosType.Enabled:=false;
      //if EditCalibrDose.Enabled then EditCalibrDose.Enabled:=false;
      if CBoxRadType.Enabled then CBoxRadType.Enabled:=false;

      if DBGridEhQueue.Enabled then DBGridEhQueue.Enabled:=false;
      if SpeedBtnQueueAdd.Enabled then SpeedBtnQueueAdd.Enabled:=false;
      if SpeedBtnQueueUp.Enabled then SpeedBtnQueueUp.Enabled:=false;
      if SpeedBtnQueueDown.Enabled then SpeedBtnQueueDown.Enabled:=false;
      if SpeedBtnQueueDel.Enabled then SpeedBtnQueueDel.Enabled:=false;
    end;
    cTablePosD4:
    begin
      //LblCurrentStep.Caption := rsSmLoadD4;
//      BtnCancel.Caption := rsBack;
      //BtnNext.Caption := rsSmNext;

      LoadDosimeterPicture(StrToInt(MainForm.Dosimeter.DosTypeID),cPictureDosLoadD4);

      //if not JvSpeedBtnSkip.Visible then JvSpeedBtnSkip.Visible:=true;
      if CBoxDosList.Enabled then CBoxDosList.Enabled:=false;
      if CBoxDosType.Enabled then CBoxDosType.Enabled:=false;
      //if EditCalibrDose.Enabled then EditCalibrDose.Enabled:=false;
      if CBoxRadType.Enabled then CBoxRadType.Enabled:=false;

      if DBGridEhQueue.Enabled then DBGridEhQueue.Enabled:=false;
      if SpeedBtnQueueAdd.Enabled then SpeedBtnQueueAdd.Enabled:=false;
      if SpeedBtnQueueUp.Enabled then SpeedBtnQueueUp.Enabled:=false;
      if SpeedBtnQueueDown.Enabled then SpeedBtnQueueDown.Enabled:=false;
      if SpeedBtnQueueDel.Enabled then SpeedBtnQueueDel.Enabled:=false;
    end;
    cTableMeasuring:
    begin

    end;
    8:
    begin

    end;
    9:
    begin

    end;
  end;
end;

procedure TStartMeasureW.CBoxFiilterChange(Sender: TObject);
begin
  if CBoxFiilter.ItemIndex > 0 then
  begin
    MainForm.UseKFilter:=true;
    ShapeContur.Visible:=true;
  end
  else
  begin
    MainForm.UseKFilter:=false;
    ShapeContur.Visible:=false;
  end;
end;

procedure TStartMeasureW.CBoxRadTypeChange(Sender: TObject);
begin
  FRadTypeIndex:=CBoxRadType.ItemIndex;
end;

procedure TStartMeasureW.SpeedBtnQueueDownClick(Sender: TObject);
var
  reqNo: integer;
begin
  reqNo:=MemTableEhQueue.RecNo-1;

  if reqNo < MemTableEhQueue.RecordCount-1 then
  begin
    MemTableEhQueue.MoveRecord(reqNo,reqNo+1,0,false);
    DBGridEhQueueCellClick(DBGridEhQueue.Columns[0]);
  end;
end;

procedure TStartMeasureW.SpeedBtnStopMeasClick(Sender: TObject);
begin
  Close;
end;

procedure TStartMeasureW.SpeedButtonCalibrAddClick(Sender: TObject);
begin
  AddInCalibrW.ShowModal;
end;

procedure TStartMeasureW.SpeedButtonCalibrDelClick(Sender: TObject);
begin
  MemTableEhCalibr.Delete;
  GetAverageKDos;
  SaveToCalibrationFile;
end;

procedure TStartMeasureW.SpeedButtonCalibrDownClick(Sender: TObject);
var
  reqNo: integer;
begin
  reqNo:=MemTableEhCalibr.RecNo-1;

  if reqNo < MemTableEhCalibr.RecordCount-1 then
  begin
    MemTableEhCalibr.MoveRecord(reqNo,reqNo+1,0,false);
    DBGridEhCalibrCellClick(DBGridEhCalibr.Columns[0]);
  end;

  SaveToCalibrationFile;
end;

procedure TStartMeasureW.SpeedButtonCalibrUpClick(Sender: TObject);
var
  reqNo: integer;
begin
  reqNo:=MemTableEhCalibr.RecNo-1;

  if reqNo > 0 then
  begin
    MemTableEhCalibr.MoveRecord(reqNo-1,reqNo,0,false);
    DBGridEhCalibrCellClick(DBGridEhCalibr.Columns[0]);
  end;

  SaveToCalibrationFile;
end;

procedure TStartMeasureW.SpeedBtnQueueUpClick(Sender: TObject);
var
  reqNo: integer;
begin
  reqNo:=MemTableEhQueue.RecNo-1;

  if reqNo > 0 then
  begin
    MemTableEhQueue.MoveRecord(reqNo-1,reqNo,0,false);
    DBGridEhQueueCellClick(DBGridEhQueue.Columns[0]);
  end;
end;

procedure TStartMeasureW.SpeedBtnQueueAddClick(Sender: TObject);
begin
  AddInQueueW.Showmodal;
end;

procedure TStartMeasureW.SpeedBtnQueueDelClick(Sender: TObject);
begin
  MemTableEhQueue.Delete;
  DBGridEhQueueCellClick(DBGridEhQueue.Columns[0]);
  SaveToQueueFile;
end;

procedure TStartMeasureW.DBGridEhCalibrCellClick(Column: TColumnEh);
begin
  CBoxDosType.ItemIndex:=CBoxDosType.Items.IndexOf(MemTableEhCalibr.FieldByName(cFieldDosType).AsString);
  CBoxDosType.OnChange(Self);
  CBoxDosList.Text:=MemTableEhCalibr.FieldByName(cFullDosID).AsString;
end;

procedure TStartMeasureW.DBGridEhQueueCellClick(Column: TColumnEh);
begin
  CBoxDosList.ItemIndex:=CBoxDosList.Items.IndexOf(MemTableEhQueue.FieldByName(cFullDosID).AsString);

  if MemTableEhQueue.FieldByName(cComment).AsString<>'' then
    EditPageQueueComment.Text:=MemTableEhQueue.FieldByName(cComment).AsString;
end;

procedure TStartMeasureW.PageControlStartChange(Sender: TObject);
begin

end;

procedure TStartMeasureW.EditCalibrDoseChange(Sender: TObject);
begin
  if IsReal(EditCalibrDose.Text) then
  begin
    FCalibrSourceDose:=StrToFloatRegion(EditCalibrDose.Text);
    LblErr.Visible:=false;
  end
  else
  begin
    FCalibrSourceDose:=-1;
    LblErr.Caption := rsIncorrectValue;
    LblErr.Visible:=true;
  end;
end;

procedure TStartMeasureW.EditCalibrDoseKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  cVK_Enter = $0D;          //  кнопка Enter
begin
  if (Key = cVK_Enter) then
  begin
    //if BtnNext.Enabled then BtnNext.SetFocus
  end;
end;

procedure TStartMeasureW.EditDepChange(Sender: TObject);
begin
  if Assigned(MainForm.Dosimeter) then
    MainForm.Dosimeter.Department:=EditDep.Text;
end;

procedure TStartMeasureW.EditDisable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=false;
end;

procedure TStartMeasureW.EditEnable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=true;
end;

procedure TStartMeasureW.EditOrgChange(Sender: TObject);
begin
  if Assigned(MainForm.Dosimeter) then
    MainForm.Dosimeter.Organization:=EditOrg.Text;
end;

procedure TStartMeasureW.EditPageIDKFIOChange(Sender: TObject);
begin
  if Assigned(MainForm.Dosimeter) then
    MainForm.Dosimeter.Fio:=EditPageIDKFio.Text;
end;

procedure TStartMeasureW.EditPageIDKPersNumberChange(Sender: TObject);
begin
  if Assigned(MainForm.Dosimeter) then
    MainForm.Dosimeter.PersNumber:=StrToIntRegion(EditPageIDKPersNumber.Text);
end;

procedure TStartMeasureW.EditPageQueueCommentChange(Sender: TObject);
begin
  CBoxDosListChange(Self);
end;

procedure TStartMeasureW.EnableControls(Value: boolean);
begin
  CBoxFiilter.Enabled:=Value;
  DBGridEhQueue.Enabled:=Value;
  SpeedBtnQueueAdd.Enabled:=Value;
  SpeedBtnQueueUp.Enabled:=Value;
  SpeedBtnQueueDown.Enabled:=Value;
  SpeedBtnQueueDel.Enabled:=Value;
end;

procedure TStartMeasureW.FormClose(Sender: TObject; var anAction: TCloseAction);
begin
 // MainForm.CheckDBGridRowCount(MainForm.DBGridEhOnlyMeas);
end;

procedure TStartMeasureW.FormCreate(Sender: TObject);
begin
  FStartView :=cIdle;

  PanelQueue.Color:=RGBToColor(230,230,230);
  FQueuePanelHeight:=PanelQueue.Height;

  CBoxRadType.Items.Add(rsRadTypeGamma);
  CBoxRadType.Items.Add(rsRadTypeNeutron);
  CBoxRadType.ItemIndex:=0;
end;

procedure TStartMeasureW.FormShow(Sender: TObject);
begin
  if MainForm.SettingsSkipDetector <> cSkipDetectorAutoDisable then
    FirstStep;
end;

procedure TStartMeasureW.FinishCalibraion;
begin
  RenameTXTFile(cCalibration);
  LoadCalibrFromFile(MemTableEhCalibr,DBGridEhCalibr);
  GetAverageKDos;
  UpdateCalibrGrid(DBGridEhCalibr);
  EditCalibrDose.Clear;
end;

procedure TStartMeasureW.FinishQueue;
begin
  RenameTXTFile(cQueue);
  LoadQueueFromFile(MemTableEhQueue,DBGridEhQueue);
  UpdateQueueGrid(DBGridEhQueue);
  EditPageQueueComment.Clear;
  CBoxDosList.Items.Clear;
  if LblErr.Visible then LblErr.Visible:=false;
end;

procedure TStartMeasureW.FirstStep;
begin
  //MainForm.TLDCommand.NNSource;

  MeasComment:='';
  MemoPageMeasComment.Lines.Clear;
  EditKSI.Clear;

  if TabSheetStartIDK.TabVisible then TabSheetStartIDK.TabVisible:=False;

  //if EditCalibrDose.Visible then
    //if not EditCalibrDose.Enabled then EditCalibrDose.Enabled:=true;

  if CBoxRadType.Visible then
    if not CBoxRadType.Enabled then CBoxRadType.Enabled:=true;

  //LblCurrentStep.Visible:=true;
  //JvSpeedBtnSkip.Visible:=false;
//  BtnCancel.Enabled:=true;
  //BtnNext.Enabled:=true;

  EnableControls(True);

  LblEnterDosNumber.Visible:=True;

  ImageStart.Picture:=nil;

  //JvSpeedBtnSkip.Visible:=False;

  LblErr.Visible:=False;
  LblTopCaption.Caption:=rsStartNewMeasurement;
  //LblCurrentStep.Caption:=rsGiveDosimeterNumber2;
//  BtnCancel.Caption:=rsClose;

  LblEnterDosNumber.Caption:=rsInputDosimeterNumber;

  UpdateForm;
end;

function TStartMeasureW.GetSQLManyColFiltered: String;
begin
  Result:='SELECT CASE postfix WHEN '+#39'-'+#39+' THEN CAST(dosimeterid AS TEXT) ELSE CAST (dosimeterid AS TEXT) || postfix END AS fulldosid, '
           +cFieldDosType+','
           +cFieldRegTime+','
           +'CASE status WHEN '+IntToStr(cDosCalibrated)+' then '+#39+rsDosCalibrated+#39+' WHEN '+IntToStr(cDosNotCalibrated)+' then '+#39+rsDosNotCalibrated+#39+' ELSE '+#39+rsDosDecommissioned+#39+' END AS stringstate'+','
           +cFieldDosStatus+','
           +cFieldOrg+','
           +cFieldDepartment+','
           +cFieldPartID+' '
           +'FROM tlddosimeterid WHERE '
           +'(CAST (dosimeterid AS TEXT) LIKE '+#39+MainForm.Filter+'%'+#39+' OR CAST (dosimeterid AS TEXT) || postfix LIKE '+#39+MainForm.Filter+'%'+#39+')'
          +' AND '
           +MainForm.GetFilterDosOrganization(MainForm.CBoxProcessOrgName)
           +' AND '
           +MainForm.GetFilterDosDepartment(MainForm.CBoxProcessDep)
           +' AND '
           +MainForm.GetFilterDosType(MainForm.CBoxProcessDosType)
           +' AND '
           +MainForm.GetFilterDosPartID(MainForm.CBoxProcessDosPart)
           +' AND '
           +MainForm.GetFilterDosStatus(MainForm.CBoxProcessStatus)+' '
           +'ORDER BY '+cFieldDosID;
end;

procedure TStartMeasureW.HideDetectors(DetCnt: integer);
begin
  case DetCnt of
    cDetPos1:
    begin
      LblPageMeasD1.Visible:=true;
      GaugePageMeasStatusD1.Visible:=true;
      EditPageMeasStatusD1.Visible:=true;
      LblPageMeasD2.Visible:=false;
      GaugePageMeasStatusD2.Visible:=false;
      EditPageMeasStatusD2.Visible:=false;
      LblPageMeasD3.Visible:=false;
      GaugePageMeasStatusD3.Visible:=false;
      EditPageMeasStatusD3.Visible:=false;
      LblPageMeasD4.Visible:=false;
      GaugePageMeasStatusD4.Visible:=false;
      EditPageMeasStatusD4.Visible:=false;
    end;
    cDetPos2:
    begin
      LblPageMeasD1.Visible:=true;
      GaugePageMeasStatusD1.Visible:=true;
      EditPageMeasStatusD1.Visible:=true;
      LblPageMeasD2.Visible:=true;
      GaugePageMeasStatusD2.Visible:=true;
      EditPageMeasStatusD2.Visible:=true;
      LblPageMeasD3.Visible:=false;
      GaugePageMeasStatusD3.Visible:=false;
      EditPageMeasStatusD3.Visible:=false;
      LblPageMeasD4.Visible:=false;
      GaugePageMeasStatusD4.Visible:=false;
      EditPageMeasStatusD4.Visible:=false;
    end;
    cDetPos3:
    begin
      LblPageMeasD1.Visible:=true;
      GaugePageMeasStatusD1.Visible:=true;
      EditPageMeasStatusD1.Visible:=true;
      LblPageMeasD2.Visible:=true;
      GaugePageMeasStatusD2.Visible:=true;
      EditPageMeasStatusD2.Visible:=true;
      LblPageMeasD3.Visible:=true;
      GaugePageMeasStatusD3.Visible:=true;
      EditPageMeasStatusD3.Visible:=true;
      LblPageMeasD4.Visible:=false;
      GaugePageMeasStatusD4.Visible:=false;
      EditPageMeasStatusD4.Visible:=false;
    end;
    cDetPos4:
    begin
      LblPageMeasD1.Visible:=true;
      GaugePageMeasStatusD1.Visible:=true;
      EditPageMeasStatusD1.Visible:=true;
      LblPageMeasD2.Visible:=true;
      GaugePageMeasStatusD2.Visible:=true;
      EditPageMeasStatusD2.Visible:=true;
      LblPageMeasD3.Visible:=true;
      GaugePageMeasStatusD3.Visible:=true;
      EditPageMeasStatusD3.Visible:=true;
      LblPageMeasD4.Visible:=true;
      GaugePageMeasStatusD4.Visible:=true;
      EditPageMeasStatusD4.Visible:=true;
    end;
  end;
end;

function TStartMeasureW.IsQueueChanged: boolean;
var
  i             : integer;
  recNo         : integer;
  strListGrid   : TStringList;
  strListFile   : TStringList;
  f             : TextFile;
  s             : String;
  fullPath      : String;
  res           : boolean;
begin
  res:=true;

  fullPath:=extractfilepath(Application.ExeName)+cQueue+PathDelim+cQueue+cExtTXT;

  strListFile:=TStringList.Create;
  strListGrid:=TStringList.Create;

  if FileExists(fullPath) then
  try
    AssignFile(f,fullPath);
    Reset(f);

    while not EOF(f) do
    begin
      readln(f,s);
      strListFile.Add(s);
    end;

    CloseFile(f);

    recNo:=MemTableEhQueue.RecNo;
    MemTableEhQueue.First;

    for i:=1 to MemTableEhQueue.RecordCount-1 do
    begin
      strListGrid.Add(MemTableEhQueue.FieldByName(cFullDosID).AsString+';'+MemTableEhQueue.FieldByName(cFieldDosType).AsString+';'+MemTableEhQueue.FieldByName(cProcessed).AsString+';'+MemTableEhQueue.FieldByName(cComment).AsString+';');
      MemTableEhQueue.Next;
    end;
    MemTableEhQueue.RecNo:=recNo;

    if strListGrid.Equals(strListFile) then
      res:=False
    else
      res:=True;
  finally
    strListGrid.Free;
    strListFile.Free;
    Result:=res;
  end
  else
    Result:=res;
end;

procedure TStartMeasureW.NextDosimeterInQueue;
begin
  SpeedBtnQueueDownClick(Self);
end;

procedure TStartMeasureW.PreviousStep;
begin
  if Assigned(MainForm.Dosimeter) then            // проверяем на существование дозиметра (если выбрали из комбобокса)
  begin
    case MainForm.Dosimeter.TablePos of           // функционал кнопки меняется в зависимости значения счетчика
      cTablePosStart:                             // находимся в режиме выбора дозиметра
      begin
        MainForm.Start:=false;

        CBoxDosType.ItemIndex:=-1;
        MainForm.Dosimeter.TablePos:=cTablePosStart;
        MainForm.GetMeasData;
        if MainForm.Start then MainForm.Start:=false;
        MainForm.CheckDBGridRowCount(MainForm.DBGridEhOnlyMeas);
        Close;
      end;
      cTablePosFilter:
      begin
        MainForm.BackMeasure;
      end;
      cTablePosKSI:
      begin
        MainForm.BackMeasure;
      end;
      cTablePosD1:
      begin
        MainForm.Dosimeter.SetDetsState(stDetNotMeasured);
        MainForm.BackMeasure;
      end;
      cTablePosD2:
      begin
        TDetector(MainForm.Dosimeter.DetectorsList[0]).State:=stDetWaitLoad;
        MainForm.BackMeasure;
      end;
      cTablePosD3:
      begin
        TDetector(MainForm.Dosimeter.DetectorsList[1]).State:=stDetWaitLoad;
        MainForm.BackMeasure;
      end;
      cTablePosD4:
      begin
        TDetector(MainForm.Dosimeter.DetectorsList[2]).State:=stDetWaitLoad;
        MainForm.BackMeasure;
      end;
      cTableMeasuring:
      begin

      end
      else
        if MainForm.Start then MainForm.Start:=false;
        Close;
    end;
  end
  else
  begin
    if MainForm.Start then MainForm.Start:=false;
    Close;
  end;
end;

procedure TStartMeasureW.RenameTXTFile(FileName: String);
var
  fullPathOldFile  : String;
  fullPathNewFile  : String;
  newFileName      : String;
begin
  fullPathOldFile:=extractfilepath(Application.ExeName)+FileName+PathDelim+FileName+cExtTXT;

  if FileExists(fullPathOldFile) then
  begin
    newFileName:=Format('%s_%s',[FormatDateTime('yyyy_mm_dd_hh_mm_ss',Now),FileName]);
    fullPathNewFile:=extractfilepath(Application.ExeName)+FileName+PathDelim+newFileName+cExtTXT;

    RenameFile(fullPathOldFile,fullPathNewFile);
  end;
end;

procedure TStartMeasureW.NextStep;
begin
  if Assigned(MainForm.Dosimeter) then            // проверяем на существование дозиметра (если выбрали из комбобокса)
  begin
    case MainForm.Dosimeter.TablePos of           // функционал кнопки меняется в зависимости значения счетчика
      cTablePosStart:                             // находимся в режиме выбора дозиметра
      begin
        MainForm.Dosimeter.OnChangeDoseType(Self);
//        if MainForm.Queue and IsQueueChanged then SaveToQueueFile;
        MainForm.StartMeasure;
        if (StartMeasureW.StartView<>cTesting) AND (MainForm.UseControlComment) then
          MainForm.Dosimeter.MeasComment:=MainForm.ControlComment;
      end;
      cTablePosFilter:                             // находимся в режиме проверки установи фильтра
      begin
        MainForm.StartMeasure;
      end;
      cTablePosKSI:                               // находимся в режиме считывания КСИ
      begin
        MainForm.Dosimeter.SetDetsState(stDetWaitLoad);
        MainForm.Dosimeter.Validity:=stDosWaitLoad;
        MainForm.StartMeasure;
      end;
      cTablePosD1:                                // находимся в режиме загрузки детектора Д1
      begin
        TDetector(MainForm.Dosimeter.DetectorsList[0]).State:=stDetWaitMeas;
        MainForm.StartMeasure;
      end;
      cTablePosD2:                                // находимся в режиме загрузки детектора Д2
      begin
        TDetector(MainForm.Dosimeter.DetectorsList[1]).State:=stDetWaitMeas;
        MainForm.StartMeasure;
      end;
      cTablePosD3:                                // находимся в режиме загрузки детектора Д3
      begin
        TDetector(MainForm.Dosimeter.DetectorsList[2]).State:=stDetWaitMeas;
        MainForm.StartMeasure;
      end;
      cTablePosD4:                                // находимся в режиме загрузки детектора Д4
      begin
        TDetector(MainForm.Dosimeter.DetectorsList[3]).State:=stDetWaitMeas;
        MainForm.StartMeasure;                  // закрываем окно после пропуска последнего детектора
      end;
      cTableMeasuring:
      begin
//        if TabSheetStartload.TabVisible then TabSheetStartLoad.TabVisible:=false;
//        if not TabSheetStartMeas.TabVisible then TabSheetStartMeas.TabVisible:=true;
      end;
    end;
  end
  else
    Close;
end;

procedure TStartMeasureW.SaveToQueueFile;
var
  i         : integer;
  recNo     : integer;
  strList   : TStringList;
  fullPath  : String;
begin
  fullPath:=extractfilepath(Application.ExeName)+cQueue+PathDelim+cQueue+cExtTXT;

  strList:=TStringList.Create;
  recNo:=MemTableEhQueue.RecNo;

  strList.Add(cFullDosID+';'
             +cFieldDosType+';'
             +cProcessed+';'
             +cComment+';');

  MemTableEhQueue.First;

  for i:=0 to MemTableEhQueue.RecordCount-1 do
  begin
    strList.Add(MemTableEhQueue.FieldByName(cFullDosID).AsString+';'+MemTableEhQueue.FieldByName(cFieldDosType).AsString+';'+MemTableEhQueue.FieldByName(cProcessed).AsString+';'+MemTableEhQueue.FieldByName(cComment).AsString+';');
    MemTableEhQueue.Next;
  end;

  MemTableEhQueue.RecNo:=recNo;

  strList.SaveToFile(fullPath);

  strList.Free;
end;

procedure TStartMeasureW.SaveToCalibrationFile;
var
  i         : integer;
  strList   : TStringList;
  fullPath  : String;
begin
  fullPath:=extractfilepath(Application.ExeName)+cCalibration+PathDelim+cCalibration+cExtTXT;

  strList:=TStringList.Create;

  strList.Add(cFullDosID+';'
             +cFieldDosType+';'
             +cSourceDose+';'
             +cKDos+';'
             +cProcessed+';');

  MemTableEhCalibr.First;

  for i:=0 to StartMeasureW.MemTableEhCalibr.RecordCount-1 do
  begin
    strList.Add(MemTableEhCalibr.FieldByName(cFullDosID).AsString+';'
               +MemTableEhCalibr.FieldByName(cFieldDosType).AsString+';'
               +MemTableEhCalibr.FieldByName(cSourceDose).AsString+';'
               +MemTableEhCalibr.FieldByName(cKDos).AsString+';'
               +MemTableEhCalibr.FieldByName(cProcessed).AsString+';');
    MemTableEhCalibr.Next;
  end;

  strList.SaveToFile(fullPath);
  strList.Free;

end;

procedure TStartMeasureW.SetCommentInQueueFile(DosNumber: String);
const
  cSeparator = ';';
var
  i               : integer;
  strList         : TStringList;
  fullPath        : String;
  replaceString   : String;
begin
  fullPath:=extractfilepath(Application.ExeName)+cQueue+PathDelim+cQueue+cExtTXT;

  if (FileExists(fullPath) AND Assigned(MainForm.Dosimeter)) then
  begin
    strList:=TStringList.Create;
    strList.LoadFromFile(fullPath);

    replaceString:=Format('%s;%s;%s;%s;',[MainForm.Dosimeter.FullNumber,
                                          MainForm.Dosimeter.DosType,
                                          'False',
                                          EditPageQueueComment.Text]);

    for i := 1 to strList.Count-1 do
    begin
      if (Pos(MainForm.Dosimeter.FullNumber+';',strList[i])>0) AND (Pos(';'+'False'+';',strList[i])>0) then
        strList[i]:=replaceString;
    end;

    strList.SaveToFile(fullPath);
    strList.Free;
  end;
end;

procedure TStartMeasureW.SetFinishMeasInQueueFile(DosNumber: String);
const
  cSeparator = ';';
var
  i               : integer;
  strList         : TStringList;
  fullPath        : String;
  replaceString   : String;
begin
  fullPath:=extractfilepath(Application.ExeName)+cQueue+PathDelim+cQueue+cExtTXT;

  if (FileExists(fullPath) AND Assigned(MainForm.Dosimeter)) then
  begin
    strList:=TStringList.Create;
    strList.LoadFromFile(fullPath);

    replaceString:=Format('%s;%s;%s;%s;',[MainForm.Dosimeter.FullNumber,
                                          MainForm.Dosimeter.DosType,
                                          'True',
                                          MainForm.Dosimeter.MeasComment]);

    for i := 1 to strList.Count-1 do
    begin
      if (Pos(DosNumber+';',strList[i])>0) then
        strList[i]:=replaceString;
    end;

    strList.SaveToFile(fullPath);
    strList.Free;
  end;
end;
{
procedure TStartMeasureW.SetKDosInCalibrationFile(KDos: double);
const
  cSeparator = ';';
var
  i               : integer;
  strList         : TStringList;
  fullPath        : String;
  replaceString   : String;
begin
  fullPath:=extractfilepath(Application.ExeName)+cCalibration+PathDelim+cCalibration+cExtTXT;

  if (FileExists(fullPath) AND Assigned(MainForm.Dosimeter)) then
  begin
    strList:=TStringList.Create;
    strList.LoadFromFile(fullPath);

    replaceString:=Format('%s;%s;%s;%s;%s;',[MainForm.Dosimeter.FullNumber,
                                             MainForm.Dosimeter.DosType,
                                             EditCalibrDose.Text,
                                             FloatToStrRegion(KDos),
                                             'True']);

    for i := 1 to strList.Count-1 do
    begin
      if (Pos(MainForm.Dosimeter.FullNumber+';',strList[i])>0) AND (Pos(';'+'False'+';',strList[i])>0) then
        strList[i]:=replaceString;
    end;

    strList.SaveToFile(fullPath);
    strList.Free;
  end;
end;
}
//procedure TStartMeasureW.SetMeasComment(Value: String);
//begin
//  FMeasComment:=Value;
//end;

function TStartMeasureW.GetCalibrSourceDose: double;
begin
  if IsReal(EditCalibrDose.Text) then
  begin
    FCalibrSourceDose:=StrToFloatRegion(EditCalibrDose.Text);
  end
  else
    FCalibrSourceDose:=-1;

  Result:=FCalibrSourceDose;
end;

//procedure TStartMeasureW.ShowModal(const Value: TProcessType);
//begin
//  StartView:=Value;
//  inherited ShowModal;
//end;

procedure TStartMeasureW.LoadQueueFromFile(MemTable: TMemTableEh; DBGridEh: TDBGridEh);
var
  fullPath  : String;
begin
  fullPath:=extractfilepath(Application.ExeName)+cQueue+PathDelim+cQueue+cExtTXT;

  if FileExists(fullPath) then
    LoadFromFile(MemTable,DBGridEh,fullPath,';')
  else
    MemTable.EmptyTable;
end;

procedure TStartMeasureW.LoadCalibrFromFile(MemTable: TMemTableEh; DBGridEh: TDBGridEh);
var
  fullPath    : String;
begin
  fullPath:=extractfilepath(Application.ExeName)+cCalibration+PathDelim+cCalibration+cExtTXT;

  if FileExists(fullPath) then
    LoadFromFile(MemTable,DBGridEh,fullPath,';')
  else
    MemTable.EmptyTable;
end;

procedure TStartMeasureW.MemoPageMeasCommentChange(Sender: TObject);
begin
  MeasComment:=StringReplace(MemoPageMeasComment.Text,#13#10,'',[rfReplaceAll, rfIgnoreCase]);
end;

procedure TStartMeasureW.LoadFromFile(MemTable: TMemTableEh; DBGridEh: TDBGridEh; FileName: String; Separator: char);
const
  cDosNumber  = 1;
  cDosType    = 2;
  cDosUse     = 3;
  cDosComment = 4;
var
  f                 : TextFile;
  s,s1,s2           : String;
  colName,colString : String;
  strVal            : TStringColuntName;
begin

  AssignFile(f, FileName);
  Reset(f);

  MemTable.Open;
  MemTable.EmptyTable;

  readln(f,s);

  while not eof(f) do
  begin
    readln(f,s1);

    colString:=s;

    MemTable.Append;

    while pos(separator, s1)<>0 do
    begin
      s2 := copy(s1,1,pos(Separator, s1)-1);
      colName:=copy(colString,1,pos(Separator, colString)-1);

      delete (s1, 1, pos(Separator, s1));
      delete (colString, 1, pos(Separator, colString));

      StrVal:=TStringColuntName(GetEnumValue(TypeInfo(TStringColuntName),colName));

      case StrVal of
        fulldosid:
        begin
          MemTable.FieldByName(cFullDosID).AsString:=s2;
        end;
        dosimetertype:
        begin
          MemTable.FieldByName(cFieldDosType).AsString:=s2;
        end;
        processed:
        begin
          MemTable.FieldByName(cProcessed).AsBoolean:=StrToBool(s2);
        end;
        comment:
        begin
          MemTable.FieldByName(cComment).AsString:=s2;
          if s2<>'' then
            EditPageQueueComment.Text:=s2;
        end;
        kdos:
        begin
          MemTable.FieldByName(cKDos).AsString:=s2;
        end;
        sourcedose:
        begin
          if EditCalibrDose.Visible then
          begin
            MemTable.FieldByName(cSourceDose).AsString:=s2;
            if s2<>'-1' then
              EditCalibrDose.Text:=s2;
          end;
        end;
      end;

    end;

    MemTable.Post;

  end;

//  case StartView of
//    cContinueSeria:
//      DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cComment).Index].Visible:=false;
//    cStartCalibration:
//      DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cSourceDose).Index].Visible:=false;
//  end;

  CloseFile(f);
end;

procedure TStartMeasureW.UpdateForm;
var
  i   : integer;
  cnt : integer;
begin
  cnt:=-1;

  CBoxFiilter.Visible:=true;

  CBoxDosList.Enabled:=true;
  CBoxDosList.ItemIndex:=-1;
  CBoxDosList.Clear;
  CBoxDosList.SetFocus;

  CBoxDosType.ItemIndex:=-1;
  CBoxDosType.Clear;
  CBoxDosType.Enabled:=false;

  //LblCalibrDose.Visible:=false;
  //EditCalibrDose.Visible:=false;
  //LblCalibrRadType.Visible:=false;
  //CBoxRadType.Visible:=false;

  PageControlStart.ActivePage:=TabSheetStartLoad;
  if not TabSheetStartload.TabVisible then TabSheetStartLoad.TabVisible:=true;
  if TabSheetStartMeas.TabVisible then TabSheetStartMeas.TabVisible:=false;

  ADOQueryStartMW.Active:=false;
  ADOQueryStartMW.SQL.Clear;

  ADOQueryStartMW.SQL.Add('SELECT '+cFieldDosType+' FROM '+cDBTableDosType+' WHERE '+cFieldDosTypeID+'> 0 '+'ORDER BY '+cFieldDosTypeID);
  ADOQueryStartMW.Active:=True;

  for i := 1 to ADOQueryStartMW.RecordCount do
  begin
    CBoxDosType.Items.Add(ADOQueryStartMW.FieldValues[cFieldDosType]);
    if i <> ADOQueryStartMW.RecordCount then ADOQueryStartMW.Next;
  end;

  case StartView of
    cStartSingleMeas,
    cBurning,
    cGrading,
    cIrradiation,
    cTesting:
    begin
      if TabSheetStartQueue.TabVisible then TabSheetStartQueue.TabVisible:=false;
      if TabSheetStartCalibr.TabVisible then TabSheetStartCalibr.TabVisible:=false;
      if not TabSheetStartIDK.TabVisible then TabSheetStartIDK.TabVisible:=true;

      ADOQueryStartMW.Active:=False;
      ADOQueryStartMW.SQL.Clear;
      ADOQueryStartMW.SQL.Add(TLDDataModule.GetSQLSingleCol(MainForm.DeviceID));
      ADOQueryStartMW.Active:=True;

      for i := 1 to ADOQueryStartMW.RecordCount do
      begin
        CBoxDosList.Items.Add(ADOQueryStartMW.FieldValues[cFullDosID]);

        if i <> ADOQueryStartMW.RecordCount then ADOQueryStartMW.Next;
      end;

      if MemTableEhQueue.Active then MemTableEhQueue.Active:=false;
    end;
//    cStartSeriaMeas:
//    begin
//      if not TabSheetStartQueue.TabVisible then TabSheetStartQueue.TabVisible:=true;
//      if not TabSheetStartIDK.TabVisible then TabSheetStartIDK.TabVisible:=true;
//      if TabSheetStartCalibr.TabVisible then TabSheetStartCalibr.TabVisible:=false;
//
//      ADOQueryStartMW.Active:=False;
//      ADOQueryStartMW.SQL.Clear;
//      ADOQueryStartMW.SQL.Add(GetSQLManyCol);
//      ADOQueryStartMW.Active:=True;
//
//      if MemTableEhQueue.Active then MemTableEhQueue.Active:=false;
//
//      MemTableEhQueue.Active:=true;
//      MemTableEhQueue.Open;
//      MemTableEhQueue.EmptyTable;
//
//      for i := 1 to ADOQueryStartMW.RecordCount do
//      begin
//        CBoxExDosList.Items.Add(ADOQueryStartMW.FieldValues[cFullDosID]);
//
//        MemTableEhQueue.Append;
//        MemTableEhQueue.FieldByName(cFullDosID).AsString:=ADOQueryStartMW.FieldValues[cFullDosID];
//        MemTableEhQueue.FieldByName(cFieldDosType).AsString:=ADOQueryStartMW.FieldValues[cFieldDosType];
//        MemTableEhQueue.FieldByName(cProcessed).AsBoolean:=false;
//        MemTableEhQueue.Post;
//
//        if i <> ADOQueryStartMW.RecordCount then ADOQueryStartMW.Next;
//      end;
//
//      UpdateQueueGrid(DBGridEhQueue);
//
//      MemTableEhQueue.First;
//    end;
    cStartSeriaMeas:
    begin
      if not TabSheetStartQueue.TabVisible then TabSheetStartQueue.TabVisible:=true;
      if not TabSheetStartIDK.TabVisible then TabSheetStartIDK.TabVisible:=true;
      if TabSheetStartCalibr.TabVisible then TabSheetStartCalibr.TabVisible:=false;

      CBoxDosList.ItemIndex:=-1;
      CBoxDosList.Items.Clear;
      CBoxDosList.Text:='';

      if MemTableEhQueue.Active then MemTableEhQueue.Active:=false;
      MemTableEhQueue.Active:=true;

      LoadQueueFromFile(MemTableEhQueue,DBGridEhQueue);

      MemTableEhQueue.First;
      for i := 0 to MemTableEhQueue.RecordCount-1 do
      begin
        if not MemTableEhQueue.FieldValues[cProcessed] then
          CBoxDosList.Items.Add(MemTableEhQueue.FieldValues[cFullDosID]);
        if not MemTableEhQueue.FieldValues[cProcessed] AND cnt<0 then
          cnt:=i+1;

        MemTableEhQueue.Next;
      end;

      UpdateQueueGrid(DBGridEhQueue);

      if (cnt < 0) AND (MemTableEhQueue.RecordCount>0) then
      begin
        LblErr.Caption:=rsMeasSerieEnd;
        LblErr.Visible:=True;
        LblEnterDosNumber.Visible:=False;
        ImageStart.Picture:=nil;
        MemTableEhQueue.Last;
      end
      else
      begin
        MemTableEhQueue.RecNo:=cnt;
        DBGridEhQueueCellClick(DBGridEhQueue.Columns[0]);
      end;

    end;
    cStartCalibration:
    begin
      if not TabSheetStartQueue.TabVisible then TabSheetStartQueue.TabVisible:=true;
      if TabSheetStartCalibr.TabVisible then TabSheetStartCalibr.TabVisible:=false;
      if TabSheetStartIDK.TabVisible then TabSheetStartIDK.TabVisible:=false;
      //begin
      //  StartMeasureW.TabSheetStartCalibr.TabVisible:=True;
      //  StartMeasureW.PageControlStart.TabIndex:=StartMeasureW.TabSheetStartCalibr.TabIndex;
      //  StartMeasureW.Show;
      //end;

      LblTopCaption.Caption:=rsCalibrationPrepare;

      ADOQueryStartMW.Active:=False;
      ADOQueryStartMW.SQL.Clear;
      ADOQueryStartMW.SQL.Add(TLDDataModule.GetSQLManyCol);
      ADOQueryStartMW.Active:=True;

      for i := 1 to ADOQueryStartMW.RecordCount do
      begin
        CBoxDosList.Items.Add(ADOQueryStartMW.FieldValues[cFullDosID]);

        if i <> ADOQueryStartMW.RecordCount then ADOQueryStartMW.Next;
      end;

      //LblCalibrDose.Visible:=true;
      //EditCalibrDose.Visible:=true;
      //LblCalibrRadType.Visible:=true;
      //CBoxRadType.Visible:=true;

      //if MemTableEhQueue.Active then MemTableEhQueue.Active:=false;
      //MemTableEhQueue.Active:=true;
      //if MemTableEhCalibr.Active then MemTableEhCalibr.Active:=false;
      //MemTableEhCalibr.Active:=true;

      //LoadQueueFromFile(MemTableEhQueue,DBGridEhQueue);

      //MemTableEhCalibr.First;
      //for i := 0 to MemTableEhQueue.RecordCount-1 do
      //begin
      //  if not MemTableEhCalibr.FieldValues[cProcessed] then
      //    CBoxDosList.Items.Add(MemTableEhCalibr.FieldValues[cFullDosID]);
      //  if not MemTableEhCalibr.FieldValues[cProcessed] AND cnt<0 then
      //    cnt:=i+1;
      //
      //  MemTableEhCalibr.Next;
      //end;
      //
      //UpdateQueueGrid(DBGridEhCalibr);
      //
      //if (cnt < 0) AND (MemTableEhCalibr.RecordCount>0) then
      //begin
      //  LblErr.Caption:=rsMeasSerieEnd;
      //  LblErr.Visible:=True;
      //  LblEnterDosNumber.Visible:=False;
      //  ImageStart.Picture:=nil;
      //  MemTableEhQueue.Last;
      //end
      //else
      //begin
      //  MemTableEhCalibr.RecNo:=cnt;
      //  DBGridEhQueueCellClick(DBGridEhQueue.Columns[0]);
      //end;

    end;
  end;

  for i := 0 to CBoxDosList.Items.Count-1 do
  begin
    if CBoxDosList.Items[i] = MainForm.EditProcessDosNumber.Text  then
    begin
      CBoxDosList.ItemIndex:=i;
      break;
    end;
  end;
end;

procedure TStartMeasureW.SetStartView(AValue: TProcessType);
begin
  if FStartView=AValue then Exit;
  if Assigned(MainForm.TLD_CommandSeries) then MainForm.TLD_CommandSeries.SetCurrentProcess(AValue);
  FStartView:=AValue;
end;

procedure TStartMeasureW.UpdateQueueGrid(DBGridEh: TDBGridEh);
const
  cScrollBarVisible = 25;
  cScrollBarHide    = 8;
  cWidthFullDosID   = 150;
  cWidthProcessed   = 30;
  cRowsForScrollCnt = 7;
var
  i                  : integer;
	indicatorColWidth  : integer;
  columnsWidth       : integer;
begin
  columnsWidth:=0;

  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cFullDosID).Index].Title.caption:=Format(' %s',[rsDosimeter]);
  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cFieldDosType).Index].Title.caption:=Format(' %s',[rsDosimeterType]);
  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cProcessed).Index].Title.caption:=Format(' %s',[WideCharToString('')]);

  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cFullDosID).Index].Width:=cWidthFullDosID;
  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cProcessed).Index].Width:=cWidthProcessed;

  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cComment).Index].Visible:=false;

  if DBGridEh.RowCount>cRowsForScrollCnt then
    indicatorColWidth:=DBGridEh.CalcIndicatorColWidth+cScrollBarVisible+DBGridEh.VertScrollBar.Width
  else
    indicatorColWidth:=DBGridEh.CalcIndicatorColWidth+cScrollBarHide+DBGridEh.VertScrollBar.Width;

  for i := 0 to DBGridEh.Columns.Count-1 do
  begin
    if (DBGridEh.Columns[i].Visible) then
      columnsWidth:=DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cFullDosID).Index].Width+DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cProcessed).Index].Width;
  end;

  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cFieldDosType).Index].Width:=DBGridEhQueue.Width-columnsWidth-indicatorColWidth;

end;

procedure TStartMeasureW.UpdateCalibrGrid(DBGridEh: TDBGridEh);
const
  cScrollBarVisible = 26;
  cScrollBarHide    = 9;
  cWidthFullDosID   = 100;
  cWidthKDos        = 100;
  cWidthProcessed   = 30;
  cRowsForScrollCnt = 7;
var
  i                  : integer;
	indicatorColWidth  : integer;
  columnsWidth       : integer;
begin
  columnsWidth:=0;

  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cFullDosID).Index].Title.caption:=Format(' %s',[rsDosimeter]);
  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cFieldDosType).Index].Title.caption:=Format(' %s',[rsDosimeterType]);
  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cKDos).Index].Title.caption:=Format(' %s',[rsDosK]);
  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cProcessed).Index].Title.caption:=Format(' %s',[WideCharToString('')]);

  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cFullDosID).Index].Width:=cWidthFullDosID;
  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cKDos).Index].Width:=cWidthKDos;
  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cProcessed).Index].Width:=cWidthProcessed;

  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cSourceDose).Index].Visible:=false;

  if DBGridEh.RowCount>cRowsForScrollCnt then
    indicatorColWidth:=DBGridEh.CalcIndicatorColWidth+cScrollBarVisible+DBGridEh.VertScrollBar.Width
  else
    indicatorColWidth:=DBGridEh.CalcIndicatorColWidth+cScrollBarHide+DBGridEh.VertScrollBar.Width;

  for i := 0 to DBGridEh.Columns.Count-1 do
  begin
    if (DBGridEh.Columns[i].Visible) then
      columnsWidth:=DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cFullDosID).Index].Width
                   +DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cKDos).Index].Width
                   +DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cProcessed).Index].Width;
  end;

  DBGridEh.Columns[DBGridEh.DataSource.DataSet.FieldByName(cFieldDosType).Index].Width:=DBGridEhQueue.Width-columnsWidth-indicatorColWidth;

end;

end.
