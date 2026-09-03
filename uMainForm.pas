unit uMainForm;

interface

uses
  {$IFDEF MSWINDOWS}
   Windows,
   CommCtrl,
  {$ELSE}
  FileUtil,
  {$ENDIF}
  Messages,
  LCLType,
  SysUtils, Variants, Classes,System.UITypes, Graphics,
  Controls, Forms, Dialogs, Inifiles, StrUtils, DateUtils,
  Buttons, StdCtrls, ExtCtrls,
  TAGraph, TASeries, TACustomSeries,
  Menus, ComCtrls,Math,
  TypInfo,
  uTLDCommand,
  uSeparator,
  uLanguages,
  uLog,
  uLogWindow,
  uLogPassForm,
  uMyCOMPort,
  uVersion,
  uSetConnection,
  uDosimeter,
  uDetector,
  uStartMF,
  uControl,
  uConst,
  uOpenDB,
  uCalcForm,
  uFunctions,
  uDataGeneratorForm,
  uFinishMF,
  uModel,
  uBackupForm,
  uImportDosimeters,
  uCalibrationForm,
  uKDosimeterForm,
  uDetectorConstructorForm,
  uDosimeterTypeConstructorForm,
  uReportForm,
  uImportInCurrentDBForm,
  uSQLFilterForm,
  uDosEditForm,
  uQueueForm,
  uImportMeasForm,
  uAddUserForm,
  uUsersManagement,
  uChangePassForm,
  uSplashScreen,
  uDosimeterPartForm,
  uDosimeterConstructorForm,
  uWarningComment,
  uUserWarningCommentForm,
  uWarningErrorForm,
  uUserFirstStartForm,
  uExportDosAndSettingsForm,
  uSendToCalibrForm,
  uChangeDosNameInMeas,
  UOptions,
  ActnList,
  ImgList,
  Grids, DBGrids, DB, SQLDB,
  JvButton,
  ATGauge, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  GridsEh, DBAxisGridsEh, DBGridsEh, MemTableDataEh, DataDriverEh, MemTableEh,
  CheckLst,
//  IdMessage, CheckLst,
  DateTimePicker,
  ComboEx,
  TAChartUtils, TATransformations,
  uTLDCommandSeries,
  uTypes,
  DataSetImpExpEh;

{$IFDEF MSWINDOWS}
const
  WM_GOTOFOREGROUND = WM_USER+1;
//  cShow         = 0;
//  cSave         = 1;
//  cSaveAndShow  = 2;
{$ELSE}
{$ENDIF}

type
  TOpenReportType = (orptSaveAndShow,orptSave,orptSaveAs);
  TOpenReportSource = (orpsMeasList,orpsDosList);

  { TMainForm }

  TMainForm = class(TForm)
    CAT_Auto1: TChartAxisTransformations;
    CAT_Auto1AutoScaleAxisTransform1: TAutoScaleAxisTransform;
    CAT_Auto1AutoScaleAxisTransform2: TAutoScaleAxisTransform;
    CAT_Auto2: TChartAxisTransformations;
    CBoxDosimeterTest: TComboBox;
    pmRegistration: TMenuItem;
    pmGrading: TMenuItem;
    pmIrradiation: TMenuItem;
    pmBurning: TMenuItem;
    PanelProcessDosPar: TPanel;
    PanelMeasDosPar: TPanel;
    ppProcessChangeNumber: TMenuItem;
    ppMeasChangeNumber: TMenuItem;
    RadioButton_backup: TRadioButton;
    RadioButton_sql: TRadioButton;
    SpeedBtnPause: TSpeedButton;
    sppProcessColLastMeasDate: TMenuItem;
    sppMeasColLastMeasDate: TMenuItem;
    TimerMeasure: TTimer;
    EditTemp: TEdit;
    PanelBackground: TPanel;
    PanelMeasLeft: TPanel;
    PanelMeasData: TPanel;
    SpeedBtnStart: TSpeedButton;
    SpeedBtnStop: TSpeedButton;
    TLDChartMeasDataD1: TChart;
    SeriesMeasD1KTV: TLineSeries;
    SeriesMeasD1Temp: TLineSeries;
    TLDChartMeasDataD2: TChart;
    SeriesMeasD2KTV: TLineSeries;
    SeriesMeasD2Temp: TLineSeries;
    TLDChartMeasDataD3: TChart;
    SeriesMeasD3KTV: TLineSeries;
    SeriesMeasD3Temp: TLineSeries;
    TLDChartMeasDataD4: TChart;
    SeriesMeasD4KTV: TLineSeries;
    SeriesMeasD4Temp: TLineSeries;
    PanelMeasDataDets: TPanel;
    PanelMeasDataD1: TPanel;
    PanelMeasDataD2: TPanel;
    PanelMeasDataD3: TPanel;
    PanelMeasDataD4: TPanel;
    TLDStateEdit: TEdit;
    PanelMeasLeftGrid: TPanel;
    SpeedButtonChangeUser: TSpeedButton;
    PanelUser: TPanel;
    LblUser: TLabel;
    TimerOpenFilter: TTimer;
    PanelMeasLeftFilter: TPanel;
    LblMeasDataDoseD1: TLabel;
    PanelMeasDataDos: TPanel;
    LblMeasDataDosDose: TLabel;
    LblMeasDataKDos: TLabel;
    LblMeasDataDosVer: TLabel;
    LblMeasDataDosMeasTime: TLabel;
    LblMeasDataNameD1: TLabel;
    LblMeasDataNameD2: TLabel;
    LblMeasDataNameD3: TLabel;
    LblMeasDataNameD4: TLabel;
    PanelMeasDataD1Chart: TPanel;
    PanelMeasDataD2Chart: TPanel;
    PanelMeasDataD3Chart: TPanel;
    PanelMeasDataD4Chart: TPanel;
    SpeedBtnMeasSettingsD1: TSpeedButton;
    LblMeasDataDosNumber: TLabel;
    LblMeasDataFormulaDos: TLabel;
    LblMeasDataComment: TLabel;
    LblMeasDataStatusD1: TLabel;
    LblMeasDataStatusD2: TLabel;
    EditMeasDataD2Dose: TEdit;
    LblMeasDataDoseD2: TLabel;
    EditMeasDataD2Status: TEdit;
    LblMeasDataStatusD3: TLabel;
    EditMeasDataD3Dose: TEdit;
    LblMeasDataDoseD3: TLabel;
    EditMeasDataD3Status: TEdit;
    EditMeasDataD4Dose: TEdit;
    EditMeasDataD4Status: TEdit;
    LblMeasDataDoseD4: TLabel;
    LblMeasDataStatusD4: TLabel;
    LblMeasDataDosOrg: TLabel;
    LblMeasDataDosDep: TLabel;
    LblMeasDataDosPersNumber: TLabel;
    LblMeasDataDosIDK: TLabel;
    EditMeasDataD1Dose: TEdit;
    EditMeasDataDose: TEdit;
    EditMeasDataDosStatus: TEdit;
    LblMeasDataDosKS: TLabel;
    EditMeasDataD1Status: TEdit;
    GaugeMeasDataD1: TATGauge;
    LblMeasDataKDosVal: TLabel;
    LblMeasDataFormulaDosVal: TLabel;
    LblMeasDataDosMeasTimeVal: TLabel;
    LblMeasDataDosVerVal: TLabel;
    GaugeMeasDataD2: TATGauge;
    GaugeMeasDataD3: TATGauge;
    GaugeMeasDataD4: TATGauge;
    DBGridEhDos: TDBGridEh;
    LblMeasDataCommentD1: TLabel;
    LblMeasDataCommentD2: TLabel;
    LblMeasDataCommentD3: TLabel;
    LblMeasDataCommentD4: TLabel;
    LblMeasDataCommentD1Value: TLabel;
    LblMeasDataCommentD2Value: TLabel;
    LblMeasDataCommentD3Value: TLabel;
    LblMeasDataCommentD4Value: TLabel;
    DBGridEhMeasList: TDBGridEh;
    DBGridEhOnlyMeas: TDBGridEh;
    LblMeasDataDosStatus: TLabel;
    LblMeasDataDosKSVal: TLabel;
    LblMeasDataFilter: TLabel;
    ChartMeasHorBtnsD1: TPanel;
    SpeedBtnMeasZoomHorMinusD1: TSpeedButton;
    ImageListMain: TImageList;
    SpeedBtnMeasZoomHorPlusD1: TSpeedButton;
    SpeedBtnMeasStepLeftD1: TSpeedButton;
    SpeedBtnMeasStepRightD1: TSpeedButton;
    ChartMeasVertBtnsD1: TPanel;
    SpeedBtnMeasZoomVertPlusD1: TSpeedButton;
    SpeedBtnMeasZoomVertMinusD1: TSpeedButton;
    SpeedBtnMeasStepUpD1: TSpeedButton;
    SpeedBtnMeasStepDownD1: TSpeedButton;
    SpeedBtnMeasAutoSizeD1: TSpeedButton;
    ChartMeasHorBtnsD2: TPanel;
    SpeedBtnMeasZoomHorMinusD2: TSpeedButton;
    SpeedBtnMeasZoomHorPlusD2: TSpeedButton;
    SpeedBtnMeasStepLeftD2: TSpeedButton;
    SpeedBtnMeasStepRightD2: TSpeedButton;
    SpeedBtnMeasAutoSizeD2: TSpeedButton;
    ChartMeasVertBtnsD2: TPanel;
    SpeedBtnMeasZoomVertPlusD2: TSpeedButton;
    SpeedBtnMeasZoomVertMinusD2: TSpeedButton;
    SpeedBtnMeasStepUpD2: TSpeedButton;
    SpeedBtnMeasStepDownD2: TSpeedButton;
    SpeedBtnMeasSettingsD2: TSpeedButton;
    ChartMeasHorBtnsD3: TPanel;
    SpeedBtnMeasZoomHorMinusD3: TSpeedButton;
    SpeedBtnMeasZoomHorPlusD3: TSpeedButton;
    SpeedBtnMeasStepLeftD3: TSpeedButton;
    SpeedBtnMeasStepRightD3: TSpeedButton;
    SpeedBtnMeasAutoSizeD3: TSpeedButton;
    ChartMeasVertBtnsD3: TPanel;
    SpeedBtnMeasZoomVertPlusD3: TSpeedButton;
    SpeedBtnMeasZoomVertMinusD3: TSpeedButton;
    SpeedBtnMeasStepUpD3: TSpeedButton;
    SpeedBtnMeasStepDownD3: TSpeedButton;
    SpeedBtnMeasSettingsD3: TSpeedButton;
    ChartMeasHorBtnsD4: TPanel;
    SpeedBtnMeasZoomHorMinusD4: TSpeedButton;
    SpeedBtnMeasZoomHorPlusD4: TSpeedButton;
    SpeedBtnMeasStepLeftD4: TSpeedButton;
    SpeedBtnMeasStepRightD4: TSpeedButton;
    SpeedBtnMeasAutoSizeD4: TSpeedButton;
    ChartMeasVertBtnsD4: TPanel;
    SpeedBtnMeasZoomVertPlusD4: TSpeedButton;
    SpeedBtnMeasZoomVertMinusD4: TSpeedButton;
    SpeedBtnMeasStepUpD4: TSpeedButton;
    SpeedBtnMeasStepDownD4: TSpeedButton;
    SpeedBtnMeasSettingsD4: TSpeedButton;
    SeriesMeasD1Gaus: TAreaSeries;
    SeriesMeasD2Gaus: TAreaSeries;
    SeriesMeasD3Gaus: TAreaSeries;
    SeriesMeasD4Gaus: TAreaSeries;
    PopupMenuDosGrid: TPopupMenu;
    ppDosGridCalibration: TMenuItem;
    PopupMenuProcessGrid: TPopupMenu;
    ppProcessGridCalibration: TMenuItem;
    ppProcessGridRecalc: TMenuItem;
    PanelBottom: TPanel;
    PanelDB: TPanel;
    LblDBName: TLabel;
    SplitterMeas: TSplitter;
    ppProcessGridDel: TMenuItem;
    SpeedBtnMeasCalcD1: TSpeedButton;
    SpeedBtnMeasCalcD2: TSpeedButton;
    SpeedBtnMeasCalcD3: TSpeedButton;
    SpeedBtnMeasCalcD4: TSpeedButton;
    ppProcessGridSendToModel: TMenuItem;
    ppDosGridDecommissioned: TMenuItem;
    PopupMenuCBoxMeasProcess: TPopupMenu;
    ppCBoxMeasProcessCheckAll: TMenuItem;
    ppCBoxMeasProcessDropAll: TMenuItem;
    ppCheckMeasProcessBoxInvert: TMenuItem;
    ImageTemp: TImage;
    PopupMenuStart: TPopupMenu;
    pmSingleMeas: TMenuItem;
    pmSeriaMeas: TMenuItem;
    pmCalibration: TMenuItem;
//    JvSpeedBtnStart: TJvSpeedButton;
    JvSpeedBtnStart: TSpeedButton;
    PageControlMain: TPageControl;
    TabSheetMeas: TTabSheet;
    TabSheetDos: TTabSheet;
    TabSheetMeasProcessing: TTabSheet;
    PanelMeasButtons: TPanel;
    PanelProcessButtons: TPanel;
    PanelProcessData: TPanel;
    PanelProcessLeft: TPanel;
    SplitterProcess: TSplitter;
    PanelDosLeft: TPanel;
    PanelDosData: TPanel;
    PanelDosButtons: TPanel;
    SplitterDos: TSplitter;
    PanelProcessDataDos: TPanel;
    LblProcessDataDosNumber: TLabel;
    LblProcessDataDosDose: TLabel;
    LblProcessDataComment: TLabel;
    LblProcessDataDosDep: TLabel;
    LblProcessDataDosIDK: TLabel;
    LblProcessDataDosMeasTime: TLabel;
    LblProcessDataDosMeasTimeVal: TLabel;
    LblProcessDataDosOrg: TLabel;
    LblProcessDataDosPersNumber: TLabel;
    LblProcessDataDosVerVal: TLabel;
    LblProcessDataFormulaDos: TLabel;
    LblProcessDataFormulaDosVal: TLabel;
    LblProcessDataKDos: TLabel;
    LblProcessDataKDosVal: TLabel;
    LblProcessDataDosKS: TLabel;
    LblProcessDataDosVer: TLabel;
    LblProcessDataDosNumberVal: TLabel;
    LblProcessDataDosStatus: TLabel;
    LblProcessDataDosKSVal: TLabel;
    LblProcessDataFilter: TLabel;
    EditProcessDataDose: TEdit;
    EditProcessDataDosStatus: TEdit;
    PanelProcessDataDets: TPanel;
    PanelProcessDataD1: TPanel;
    LblProcessDataNameD1: TLabel;
    LblProcessDataDoseD1: TLabel;
    LblProcessDataStatusD1: TLabel;
    GaugeProcessDataD1: TATGauge;
    LblProcessDataCommentD1: TLabel;
    LblProcessDataCommentD1Value: TLabel;
    EditProcessDataD1Dose: TEdit;
    EditProcessDataD1Status: TEdit;
    PanelProcessDataD2: TPanel;
    LblProcessDataNameD2: TLabel;
    LblProcessDataStatusD2: TLabel;
    LblProcessDataDoseD2: TLabel;
    GaugeProcessDataD2: TATGauge;
    LblProcessDataCommentD2: TLabel;
    LblProcessDataCommentD2Value: TLabel;
    EditProcessDataD2Dose: TEdit;
    EditProcessDataD2Status: TEdit;
    PanelProcessDataD3: TPanel;
    LblProcessDataNameD3: TLabel;
    LblProcessDataStatusD3: TLabel;
    LblProcessDataDoseD3: TLabel;
    GaugeProcessDataD3: TATGauge;
    LblProcessDataCommentD3: TLabel;
    LblProcessDataCommentD3Value: TLabel;
    EditProcessDataD3Dose: TEdit;
    EditProcessDataD3Status: TEdit;
    PanelProcessDataD4: TPanel;
    LblProcessDataNameD4: TLabel;
    LblProcessDataDoseD4: TLabel;
    LblProcessDataStatusD4: TLabel;
    GaugeProcessDataD4: TATGauge;
    LblProcessDataCommentD4: TLabel;
    LblProcessDataCommentD4Value: TLabel;
    EditProcessDataD4Dose: TEdit;
    EditProcessDataD4Status: TEdit;
    PanelProcessDataD1Chart: TPanel;
    TLDChartProcessDataD1: TChart;
    SeriesProcessD1KTV: TLineSeries;
    SeriesProcessD1Temp: TLineSeries;
    SeriesProcessD1Gaus: TAreaSeries;
    ChartProcessHorBtnsD1: TPanel;
    SpeedBtnProcessZoomHorMinusD1: TSpeedButton;
    SpeedBtnProcessZoomHorPlusD1: TSpeedButton;
    SpeedBtnProcessStepLeftD1: TSpeedButton;
    SpeedBtnProcessStepRightD1: TSpeedButton;
    SpeedBtnProcessAutoSizeD1: TSpeedButton;
    ChartProcessVertBtnsD1: TPanel;
    SpeedBtnProcessZoomVertPlusD1: TSpeedButton;
    SpeedBtnProcessZoomVertMinusD1: TSpeedButton;
    SpeedBtnProcessStepUpD1: TSpeedButton;
    SpeedBtnProcessStepDownD1: TSpeedButton;
    SpeedBtnProcessSettingsD1: TSpeedButton;
    SpeedBtnProcessCalcD1: TSpeedButton;
    PanelProcessDataD2Chart: TPanel;
    TLDChartProcessDataD2: TChart;
    SeriesProcessD2KTV: TLineSeries;
    SeriesProcessD2Temp: TLineSeries;
    SeriesProcessD2Gaus: TAreaSeries;
    ChartProcessHorBtnsD2: TPanel;
    SpeedBtnProcessZoomHorMinusD2: TSpeedButton;
    SpeedBtnProcessZoomHorPlusD2: TSpeedButton;
    SpeedBtnProcessStepLeftD2: TSpeedButton;
    SpeedBtnProcessStepRightD2: TSpeedButton;
    SpeedBtnProcessAutoSizeD2: TSpeedButton;
    ChartProcessVertBtnsD2: TPanel;
    SpeedBtnProcessZoomVertPlusD2: TSpeedButton;
    SpeedBtnProcessZoomVertMinusD2: TSpeedButton;
    SpeedBtnProcessStepUpD2: TSpeedButton;
    SpeedBtnProcessStepDownD2: TSpeedButton;
    SpeedBtnProcessSettingsD2: TSpeedButton;
    SpeedBtnProcessCalcD2: TSpeedButton;
    PanelProcessDataD3Chart: TPanel;
    TLDChartProcessDataD3: TChart;
    SeriesProcessD3KTV: TLineSeries;
    SeriesProcessD3Temp: TLineSeries;
    SeriesProcessD3Gaus: TAreaSeries;
    ChartProcessHorBtnsD3: TPanel;
    SpeedBtnProcessZoomHorMinusD3: TSpeedButton;
    SpeedBtnProcessZoomHorPlusD3: TSpeedButton;
    SpeedBtnProcessStepLeftD3: TSpeedButton;
    SpeedBtnProcessStepRightD3: TSpeedButton;
    SpeedBtnProcessAutoSizeD3: TSpeedButton;
    ChartProcessVertBtnsD3: TPanel;
    SpeedBtnProcessZoomVertPlusD3: TSpeedButton;
    SpeedBtnProcessZoomVertMinusD3: TSpeedButton;
    SpeedBtnProcessStepUpD3: TSpeedButton;
    SpeedBtnProcessStepDownD3: TSpeedButton;
    SpeedBtnProcessSettingsD3: TSpeedButton;
    SpeedBtnProcessCalcD3: TSpeedButton;
    PanelProcessDataD4Chart: TPanel;
    TLDChartProcessDataD4: TChart;
    SeriesProcessD4KTV: TLineSeries;
    SeriesProcessD4Temp: TLineSeries;
    SeriesProcessD4Gaus: TAreaSeries;
    ChartProcessHorBtnsD4: TPanel;
    SpeedBtnProcessZoomHorMinusD4: TSpeedButton;
    SpeedBtnProcessZoomHorPlusD4: TSpeedButton;
    SpeedBtnProcessStepLeftD4: TSpeedButton;
    SpeedBtnProcessStepRightD4: TSpeedButton;
    SpeedBtnProcessAutoSizeD4: TSpeedButton;
    ChartProcessVertBtnsD4: TPanel;
    SpeedBtnProcessZoomVertPlusD4: TSpeedButton;
    SpeedBtnProcessZoomVertMinusD4: TSpeedButton;
    SpeedBtnProcessStepUpD4: TSpeedButton;
    SpeedBtnProcessStepDownD4: TSpeedButton;
    SpeedBtnProcessSettingsD4: TSpeedButton;
    SpeedBtnProcessCalcD4: TSpeedButton;
    PanelProcessLeftFilter: TPanel;
    LblProcessDep: TLabel;
    LblProcessDosPart: TLabel;
    LblProcessDosType: TLabel;
    LblProcessOrgName: TLabel;
    LblProcessDate: TLabel;
    LblProcessDateFrom: TLabel;
    LblProcessDateTo: TLabel;
    LblProcessResult: TLabel;
    LblProcessStatus: TLabel;
    LblProcessPersNumber: TLabel;
    SpBtnProcessDropOrgName: TSpeedButton;
    LblProcessComment: TLabel;
    SpBtnProcessDropDep: TSpeedButton;
    SpBtnProcessDropDosPart: TSpeedButton;
    SpBtnProcessDropDosType: TSpeedButton;
    SpBtnProcessDropStatus: TSpeedButton;
    SpBtnProcessDropPersNumber: TSpeedButton;
    SpBtnProcessDropResult: TSpeedButton;
    SpBtnProcessDropIDK: TSpeedButton;
    SpBtnProcessDropDateFrom: TSpeedButton;
    SpBtnProcessDropDateTo: TSpeedButton;
    LblProcessIDK: TLabel;
    SpBtnProcessDropComment: TSpeedButton;
    SpBtnProcessSQLFilter: TSpeedButton;
    SpBtnProcessDropSQLScript: TSpeedButton;
    LblProcessDosName: TLabel;
    SpBtnProcessDropDosNumber: TSpeedButton;
    CBoxProcessDep: TComboBox;
    CBoxProcessDosPart: TComboBox;
    CBoxProcessDosType: TComboBox;
    CBoxProcessOrgName: TComboBox;
    DateTimePickerProcessFrom: TDateTimePicker;
    DateTimePickerProcessTo: TDateTimePicker;
    CBoxProcessResult: TComboBox;
    CBoxProcessPersNumber: TComboBox;
    CBoxProcessStatus: TComboBox;
    CBoxProcessIDK: TComboBox;
    CBoxProcessComment: TComboBox;
    EditProcessDosNumber: TEdit;
    PanelProcessLeftBottom: TPanel;
    PanelProcessLeftGrid: TPanel;
    DBGridEhProcess: TDBGridEh;
    PanelDosLeftGrid: TPanel;
    PanelDosLeftFilter: TPanel;
    LblDosDep: TLabel;
    LblDosDosPart: TLabel;
    LblDosDosType: TLabel;
    LblDosOrgName: TLabel;
    LblDosDate: TLabel;
    LblDosDateFrom: TLabel;
    LblDosDateTo: TLabel;
    LblDosStatus: TLabel;
    LblDosPersNumber: TLabel;
    ImageDosSpring: TImage;
    SpBtnDosDropOrgName: TSpeedButton;
    LblDosComment: TLabel;
    SpBtnDosDropDep: TSpeedButton;
    SpBtnDosDropDosPart: TSpeedButton;
    SpBtnDosDropDosType: TSpeedButton;
    SpBtnDosDropStatus: TSpeedButton;
    SpBtnDosDropPersNumber: TSpeedButton;
    SpBtnDosDropIDK: TSpeedButton;
    SpBtnDosDropDateFrom: TSpeedButton;
    SpBtnDosDropDateTo: TSpeedButton;
    ImageDosSpringUp: TImage;
    LblDosIDK: TLabel;
    SpBtnDosDropComment: TSpeedButton;
    SpBtnDosSQLFilter: TSpeedButton;
    SpBtnDosDropSQLScript: TSpeedButton;
    ImageDosSpringDown: TImage;
    LblDosDosName: TLabel;
    SpBtnDosDropDosNumber: TSpeedButton;
    CBoxDosDep: TComboBox;
    CBoxDosDosPart: TComboBox;
    CBoxDosDosType: TComboBox;
    CBoxDosOrgName: TComboBox;
    DateTimePickerDosFrom: TDateTimePicker;
    DateTimePickerDosTo: TDateTimePicker;
    CBoxDosPersNumber: TComboBox;
    CBoxDosStatus: TComboBox;
    CBoxDosIDK: TComboBox;
    CBoxDosComment: TComboBox;
    EditDosDosNumber: TEdit;
    PanelDosLeftBottom: TPanel;
    EditDosDataDosTypeVal: TEdit;
    EditDosDataFormulaDosVal: TEdit;
    EditDosDataDosIDKVal: TEdit;
    EditDosDataDosPersNumberVal: TEdit;
    EditDosDataDosOrgVal: TEdit;
    EditDosDataDosDepVal: TEdit;
    LblDosDataDosIDK: TLabel;
    LblDossDataDosPersNumber: TLabel;
    LblDosDataDosOrg: TLabel;
    LblDosDataDosDepVal: TLabel;
    EditDosDataDosFIOVal: TEdit;
    LblDosDataDosFioVal: TLabel;
//    JvDateTimePickerMeas: TJvDatePickerEdit;
    JvDateTimePickerMeas: TDateTimePicker;
    SpBtnPrev: TSpeedButton;
    SpBtnNext: TSpeedButton;
    ImageMeasLogo: TImage;
    TabSheetSettings: TTabSheet;
    PanelPermitLeft: TPanel;
    PanelPermitLeftBottom: TPanel;
    PanelPermitLeftGrid: TPanel;
    PanelPermitData: TPanel;
    SG_Users: TStringGrid;
    PanelPermitDataTop: TPanel;
    Label_SetAsTemplate: TLabel;
    StatusBarPermit: TStatusBar;
    CLB_Permits: TCheckListBox;
    PanelPermitDataHeader: TPanel;
    LblPermits: TLabel;
    SplitterPermit: TSplitter;
    ShapeCenter: TShape;
    ShapeRight: TShape;
    PanelPermitDataHelp: TPanel;
    LabelPermitHelp: TLabel;
    MemTableEhMeasList: TMemTableEh;
    DataSetDriverEhMeasList: TDataSetDriverEh;
    DataSetDriverEhDosList: TDataSetDriverEh;
    MemTableEhDosList: TMemTableEh;
    DataSetDriverEhProcessList: TDataSetDriverEh;
    MemTableEhProcessList: TMemTableEh;
    DataSourceMeasList: TDataSource;
    ADOQueryMeasList: TSQLQuery;
    DataSourceDosList: TDataSource;
    ADOQueryDosList: TSQLQuery;
    DataSourceProcessList: TDataSource;
    ADOQueryProcessList: TSQLQuery;
    CB_SetAsTemlate: TComboBox;
    AddUserSpeedBtn: TSpeedButton;
    DeleteUserSpeedBtn: TSpeedButton;
    ChangePassSpeedBtn: TSpeedButton;
    SpeedBtnDosReg: TSpeedButton;
    ppProcessGridGap1: TMenuItem;
    ppProcessCheckColumn: TMenuItem;
    sppProcessColMeasID: TMenuItem;
    sppProcessColMeasTime: TMenuItem;
    sppProcessColHp10g: TMenuItem;
    sppProcessColStatusMeas: TMenuItem;
    sppProcessColDosType: TMenuItem;
    sppProcessColKSI: TMenuItem;
    sppProcessColDateRegister: TMenuItem;
    sppProcessColDateVerification: TMenuItem;
    sppProcessColStatusDos: TMenuItem;
    sppProcessColOrg: TMenuItem;
    sppProcessColDep: TMenuItem;
    sppProcessColPart: TMenuItem;
    sppProcessColCommentDos: TMenuItem;
    sppProcessColCommentMeas: TMenuItem;
    sppProcessColPersNumber: TMenuItem;
    sppProcessColFIO: TMenuItem;
    sppProcessColDeviceUser: TMenuItem;
    LblDosDataDosType: TLabel;
    LblDosDataDosVer: TLabel;
    LblDosDataDosReg: TLabel;
    LblDosDataDosVerVal: TLabel;
    LblDosDataDosVal: TLabel;
    SpeedBtnDosTypeInf: TSpeedButton;
    EditDosMeasVal_1: TEdit;
    EditDosMeasVal_2: TEdit;
    EditDosMeasVal_3: TEdit;
    EditDosMeasVal_4: TEdit;
    EditD1: TEdit;
    SpeedBtnD1Inf: TSpeedButton;
    EditD2: TEdit;
    SpeedBtnD2Inf: TSpeedButton;
    EditD3: TEdit;
    SpeedBtnD3Inf: TSpeedButton;
    EditD4: TEdit;
    SpeedBtnD4Inf: TSpeedButton;
    LblK_1: TLabel;
    EditK_1: TEdit;
    EditK_2: TEdit;
    EditK_3: TEdit;
    EditK_4: TEdit;
    LblK_2: TLabel;
    LblK_3: TLabel;
    LblK_4: TLabel;
    CBDosDataDosStatus: TComboBox;
    LblStatus: TLabel;
    BtnDosSave: TButton;
    PanelDosParam: TPanel;
    PanelDosParamBottom: TPanel;
    PanelDosLeftBottomButtons: TPanel;
    SeriesMeasD1TempWrite: TLineSeries;
    SeriesMeasD2TempWrite: TLineSeries;
    SeriesMeasD3TempWrite: TLineSeries;
    SeriesMeasD4TempWrite: TLineSeries;
    SeriesMeasD1Fon: TAreaSeries;
    SeriesMeasD2Fon: TAreaSeries;
    SeriesMeasD3Fon: TAreaSeries;
    SeriesMeasD4Fon: TAreaSeries;
    SeriesProcessD1Fon: TAreaSeries;
    SeriesProcessD2Fon: TAreaSeries;
    SeriesProcessD3Fon: TAreaSeries;
    SeriesProcessD4Fon: TAreaSeries;
    SeriesProcessD1TempWrite: TLineSeries;
    SeriesProcessD2TempWrite: TLineSeries;
    SeriesProcessD3TempWrite: TLineSeries;
    SeriesProcessD4TempWrite: TLineSeries;
//    ChartToolBorderMeasD1: TSeriesRegionTool;
//    ChartToolBorderMeasD2: TSeriesRegionTool;
//    ChartToolBorderMeasD3: TSeriesRegionTool;
//    ChartToolBorderMeasD4: TSeriesRegionTool;
//    ChartToolBorderProcessD1: TSeriesRegionTool;
//    ChartToolBorderProcessD2: TSeriesRegionTool;
//    ChartToolBorderProcessD3: TSeriesRegionTool;
//    ChartToolBorderProcessD4: TSeriesRegionTool;
    PageControlDosParam: TPageControl;
    TabSheetDosParamMain: TTabSheet;
    TabSheetDosParamIDK: TTabSheet;
    PanelDosParamMainBack: TPanel;
    PanelDosParamIDKBack: TPanel;
    LblMeasDosFormulaValue: TLabel;
    LblK_5: TLabel;
    EditK_5: TEdit;
    LblK_gn: TLabel;
    EditK_gn: TEdit;
    EditFormulaVal_4: TEdit;
    EditFormulaVal_3: TEdit;
    EditFormulaVal_2: TEdit;
    EditFormulaVal_1: TEdit;
    EditValErrK2_1: TEdit;
    EditValErrK2_2: TEdit;
    EditValErrK2_3: TEdit;
    EditValErrK2_4: TEdit;
    LblValPercent_4: TLabel;
    LblValPercent_3: TLabel;
    LblValPercent_2: TLabel;
    LblValPercent_1: TLabel;
    GBoxD1: TGroupBox;
    LblMeasValD1: TLabel;
    LblMaterialD1: TLabel;
    LblKD1: TLabel;
    LblMethodD1: TLabel;
    EditMeasValD1: TEdit;
    EditKD1: TEdit;
    EditMethodD1: TEdit;
    GBoxD2: TGroupBox;
    LblMeasValD2: TLabel;
    LblMaterialD2: TLabel;
    LblKD2: TLabel;
    LblMethodD2: TLabel;
    EditMeasValD2: TEdit;
    EditKD2: TEdit;
    EditMethodD2: TEdit;
    GBoxD3: TGroupBox;
    LblMeasValD3: TLabel;
    LblMaterialD3: TLabel;
    LblKD3: TLabel;
    LblMethodD3: TLabel;
    EditMeasValD3: TEdit;
    EditKD3: TEdit;
    EditMethodD3: TEdit;
    GBoxD4: TGroupBox;
    LblMeasValD4: TLabel;
    LblMaterialD4: TLabel;
    LblKD4: TLabel;
    LblMethodD4: TLabel;
    EditMeasValD4: TEdit;
    EditKD4: TEdit;
    EditMethodD4: TEdit;
    GBPart: TGroupBox;
    LblErr1: TLabel;
    LblErr2: TLabel;
    LblErr3: TLabel;
    LblErr4: TLabel;
    GBFormulas: TGroupBox;
    PopupMenuCBoxDos: TPopupMenu;
    ppCBoxDosCheckAll: TMenuItem;
    ppCBoxDosDropAll: TMenuItem;
    ppCheckDosBoxInvert: TMenuItem;
    CheckBoxShowToDel: TCheckBox;
    sppProcessColHp10n: TMenuItem;
    sppProcessColHp3: TMenuItem;
    sppProcessColHp007: TMenuItem;
    sppProcessColHstar: TMenuItem;
    sppProcessColH007: TMenuItem;
    sppProcessColD: TMenuItem;
    ppDosGridGap1: TMenuItem;
    ppDosCheckColumn: TMenuItem;
    sppDosColDosType: TMenuItem;
    sppDosColStatusDos: TMenuItem;
    sppDosCol_k1: TMenuItem;
    sppDosCol_k2: TMenuItem;
    sppDosCol_k3: TMenuItem;
    sppDosCol_k4: TMenuItem;
    sppDosCol_k5: TMenuItem;
    sppDosCol_kgn: TMenuItem;
    sppDosColPart: TMenuItem;
    sppDosColDateRegister: TMenuItem;
    sppDosColDateVerification: TMenuItem;
    sppDosColOrg: TMenuItem;
    sppDosColDep: TMenuItem;
    sppDosColLastMeasComment: TMenuItem;
    ImageProcessLogo: TImage;
    PageControlMeasDosPar: TPageControl;
    PGMeasPage_TSMainPar: TTabSheet;
    PGMeasPage_TSIDK: TTabSheet;
    PGMeasPage_TSAdditionPar: TTabSheet;
    PageControlProcessDosPar: TPageControl;
    PGProcessPage_TSMainPar: TTabSheet;
    PGProcessPage_TSAdditionPar: TTabSheet;
    PGProcessPage_TSIDK: TTabSheet;
    sppProcessColDose: TMenuItem;
    LblMeasDataDosFio: TLabel;
    LblProcessDataDosFio: TLabel;
    EditMeasDataDosOrg: TEdit;
    EditMeasDataDosDep: TEdit;
    EditMeasDataDosFio: TEdit;
    EditMeasDataDosPersNumber: TEdit;
    EditMeasDataDosIDK: TEdit;
    PanelMeasDataDosNumber: TPanel;
    PanelProcessDataDosNumber: TPanel;
    EditProcessDataDosIDK: TEdit;
    EditProcessDataDosPersNumber: TEdit;
    EditProcessDataDosFio: TEdit;
    EditProcessDataDosOrg: TEdit;
    EditProcessDataDosDep: TEdit;
    SpeedBtnMeasSaveIDK: TSpeedButton;
    SpeedBtnProcessSaveIDK: TSpeedButton;
    PopupMenuMeasGrid: TPopupMenu;
    ppMeasCheckColumn: TMenuItem;
    sppMeasColMeasID: TMenuItem;
    sppMeasColMeasTime: TMenuItem;
    sppMeasColKSI: TMenuItem;
    sppMeasColDose: TMenuItem;
    sppMeasColHp10g: TMenuItem;
    sppMeasColHp10n: TMenuItem;
    sppMeasColHp007: TMenuItem;
    sppMeasColHp3: TMenuItem;
    sppMeasColHstar: TMenuItem;
    sppMeasColH007: TMenuItem;
    sppMeasColD: TMenuItem;
    sppMeasColStatusMeas: TMenuItem;
    sppMeasColDosType: TMenuItem;
    sppMeasColDateRegister: TMenuItem;
    sppMeasColDateVerification: TMenuItem;
    sppMeasColStatusDos: TMenuItem;
    sppMeasColOrg: TMenuItem;
    sppMeasColDep: TMenuItem;
    sppMeasColPart: TMenuItem;
    sppMeasColCommentDos: TMenuItem;
    sppMeasColCommentMeas: TMenuItem;
    sppMeasColPersNumber: TMenuItem;
    sppMeasColFIO: TMenuItem;
    sppMeasColDeviceUser: TMenuItem;
    MenuItem27: TMenuItem;
    ppMeasSendToProcess: TMenuItem;
    LblMeasDataDosNumberVal: TLabel;
    pmTesting: TMenuItem;
    TimerTest: TTimer;
    SpeedBtnPartInf: TSpeedButton;
    ppMeasExportToFile: TMenuItem;
    SaveDialogMainForm: TSaveDialog;
    ppMeasSaveToFile: TMenuItem;
    ppMeasSaveToFileWithiDetDose: TMenuItem;
    TimerSourceTest: TTimer;
    ppProcessExportToFile: TMenuItem;
    ppProcessSaveToFile: TMenuItem;
    ppProcessSaveToFileWithiDetDose: TMenuItem;
    SeriesMeasD1Glade: TLineSeries;
    SeriesMeasD2Glade: TLineSeries;
    SeriesMeasD3Glade: TLineSeries;
    SeriesMeasD4Glade: TLineSeries;
    SeriesProcessD1Glade: TLineSeries;
    SeriesProcessD2Glade: TLineSeries;
    SeriesProcessD3Glade: TLineSeries;
    SeriesProcessD4Glade: TLineSeries;
    EditValErrK1_1: TEdit;
    ShapeErr_1: TShape;
    LblHErr_1: TLabel;
    LblPlus_1: TLabel;
    EditValErrK1_2: TEdit;
    ShapeErr_2: TShape;
    LblHErr_2: TLabel;
    LblPlus_2: TLabel;
    EditValErrK1_3: TEdit;
    ShapeErr_3: TShape;
    LblHErr_3: TLabel;
    LblPlus_3: TLabel;
    ShapeErr_4: TShape;
    EditValErrK1_4: TEdit;
    LblHErr_4: TLabel;
    LblPlus_4: TLabel;
    sppMeasColHp10g_Err: TMenuItem;
    sppMeasColHp10n_Err: TMenuItem;
    sppMeasColHp007_Err: TMenuItem;
    sppMeasColHp3_Err: TMenuItem;
    sppMeasColHstar_Err: TMenuItem;
    sppMeasColH007_Err: TMenuItem;
    sppMeasColD_Err: TMenuItem;
    sppProcessColHp10g_Err: TMenuItem;
    sppProcessColHp10n_Err: TMenuItem;
    sppProcessColHp007_Err: TMenuItem;
    sppProcessColHp3_Err: TMenuItem;
    sppProcessColHstar_Err: TMenuItem;
    sppProcessColH007_Err: TMenuItem;
    sppProcessColD_Err: TMenuItem;
    TabSheetDosFormula: TTabSheet;
    LblDosPartName: TLabel;
    PanelGBPartTop: TPanel;
    PanelGBPartClient: TPanel;
    LblDotK1: TLabel;
    LblDotK2: TLabel;
    LblDotK3: TLabel;
    LblDotK4: TLabel;
    LblDotK5: TLabel;
    LblDotKgn: TLabel;
    EditDosPart: TEdit;
    BtnExcludeFromPart: TButton;
    BtnDecommissionDos: TButton;
    BtnOpenCalibr: TButton;
    SpeedBtnMeasDataWarningD1: TSpeedButton;
    SpeedBtnMeasDataWarningD2: TSpeedButton;
    SpeedBtnMeasDataWarningD3: TSpeedButton;
    SpeedBtnMeasDataWarningD4: TSpeedButton;
    SpeedBtnProcessDataWarningD1: TSpeedButton;
    SpeedBtnProcessDataWarningD2: TSpeedButton;
    SpeedBtnProcessDataWarningD3: TSpeedButton;
    SpeedBtnProcessDataWarningD4: TSpeedButton;
//    JvSpeedBtnMeasDosStatus: TJvSpeedButton;
    JvSpeedBtnMeasDosStatus: TSpeedButton;
    GBoxLastMeas: TGroupBox;
    LblLastMeasDate: TLabel;
    LblLastMeasDateVal: TLabel;
    LblLastMeasResult: TLabel;
    EditLastMeasResult: TEdit;
    sppDosColLastMeasTime: TMenuItem;
    sppDosColLastMeasResult: TMenuItem;
    SpeedBtnMeasUserWarning: TSpeedButton;
    SpeedBtnProcessUserWarning: TSpeedButton;
//    JvSpeedBtnProcessDosStatus: TJvSpeedButton;
    JvSpeedBtnProcessDosStatus: TSpeedButton;
    PageControlSettings: TPageControl;
    TabSheetUserPermit: TTabSheet;
    PanelUserPermitBackground: TPanel;
    PanelSettingsBackground: TPanel;
    TabSheetDeviceControl: TTabSheet;
    PanelDeviceControlBackground: TPanel;
    BtnImportDataBase: TButton;
    ButtonControlDevice: TButton;
    ButtonModel: TButton;
    BtnDeleteDiscommissionDosimeters: TButton;
    BtnDeleteMarkedToDelMeas: TButton;
    ButtonAbout: TButton;
    SpeedBtnMeasExit: TSpeedButton;
    EditMeasDataComment: TEdit;
    SpeedBtnMeasSaveParam: TSpeedButton;
    EditProcessDataComment: TEdit;
    SpeedBtnProcessSaveParam: TSpeedButton;
    SpeedBtnProcessExit: TSpeedButton;
    SpeedBtnDosExit: TSpeedButton;
    PanelSettingsButtons: TPanel;
    SpeedBtnSettingsExit: TSpeedButton;
    TabSheetDataBase: TTabSheet;
    PanelDataBaseBackground: TPanel;
    SpeedBtnMeasDet1Inf: TSpeedButton;
    SpeedBtnMeasDet2Inf: TSpeedButton;
    SpeedBtnMeasDet3Inf: TSpeedButton;
    SpeedBtnMeasDet4Inf: TSpeedButton;
    SpeedBtnProcessDet1Inf: TSpeedButton;
    SpeedBtnProcessDet2Inf: TSpeedButton;
    SpeedBtnProcessDet3Inf: TSpeedButton;
    SpeedBtnProcessDet4Inf: TSpeedButton;
    SpeedBtnMeasDosTypeInf: TSpeedButton;
    SpeedBtnProcessDosTypeInf: TSpeedButton;
    PanelDataBaseLeft: TPanel;
    PanelDataBaseGrid: TPanel;
    DBGridEhDB: TDBGridEh;
    MemTableEhDBList: TMemTableEh;
    DataSetDriverEhDBList: TDataSetDriverEh;
    ADOQueryDBList: TSQLQuery;
    DataSourceDBList: TDataSource;
    BtnDeleteDB: TButton;
    ProgressBarDB: TProgressBar;
    PanelProgressBar: TPanel;
    LabelBDProcess: TLabel;
    BtnResstoreDB: TButton;
    BtnExport: TButton;
    SaveDialogDB: TSaveDialog;
    GroupBoxDataMeas: TGroupBox;
    GroupBoxCOMPortSettings: TGroupBox;
    LblCOMPortNumber: TLabel;
    ComboBoxPortNumber: TComboBox;
    BtnClearPort: TButton;
    LblComState: TLabel;
    PanelStatus: TPanel;
    GroupBoxMeasSettings: TGroupBox;
    CBoxSettingsShowOriginalKTV: TCheckBox;
    CBoxSettingsShowGladeKTV: TCheckBox;
    CBoxSettingsAutoResetDevice: TCheckBox;
    CBoxSettingsUseAutoComment: TCheckBox;
    MemoSettingsAutoComment: TMemo;
    GroupBoxDeviceSettings: TGroupBox;
    LblSettingsKSDeviation: TLabel;
    LblSettingsKSNormalValue: TLabel;
    LblSettingsDevID: TLabel;
    LblSettingsKFilter: TLabel;
    EditSettingsDevID: TEdit;
    EditSettingsKSNormalValue: TEdit;
    EditSettingsKSDeviation: TEdit;
    EditSettingsKFilter: TEdit;
    BtnSettingsSaveParameters: TButton;
    PanelDataBaseTop: TPanel;
    GroupBoxExpImp: TGroupBox;
    GroupBoxReserveDB: TGroupBox;
    PopupMenuCBoxOnlyMeas: TPopupMenu;
    ppCBoxOnlyMeasCheckAll: TMenuItem;
    ppCBoxOnlyMeasDropAll: TMenuItem;
    ppCheckOnlyMeasBoxInvert: TMenuItem;
    EditSettingsSoftwareVer: TEdit;
    LblSettingsSoftwareVer: TLabel;
    sppProcessColDeviceID: TMenuItem;
    sppMeasColDeviceID: TMenuItem;
    sppDosColDeviceID: TMenuItem;
    SpeedBtnProcessOpenFilter: TSpeedButton;
    SpeedBtnProcessDropAllFilter: TSpeedButton;
    SpeedBtnDosOpenFilter: TSpeedButton;
    SpeedBtnDosDropAllFilter: TSpeedButton;
    SpeedBtnDosRegFromFile: TSpeedButton;
    ScrollBoxDosimeters: TScrollBox;
    LblMeasDosValue: TLabel;
    EditDosDataDosVal: TEdit;
    PageDosNumber: TPageControl;
    TabSheetDosNumber: TTabSheet;
    TabSheetDosGroupOperations: TTabSheet;
    PanelGroupOperations: TPanel;
    BtnDecommissionDosGroup: TButton;
    BtnExcludeFromPartGroup: TButton;
    EditDosDataDosDepValGroup: TEdit;
    LblDosDataDosDepValGroup: TLabel;
    EditDosDataDosOrgValGroup: TEdit;
    LblDosDataDosOrgGroup: TLabel;
    GroupBoxAdditionalParameters: TGroupBox;
    BtnSaveDosAdditionalParametersGroup: TButton;
    BtnOpenCalibrGroup: TButton;
    BtnDosCancel: TButton;
    GroupBoxDeviceTest: TGroupBox;
    LblTestSourceTime: TLabel;
    LblTestSourceKIncrease: TLabel;
    LblTestSourceTimeIncreaseCycle: TLabel;
    LblTestSourceDosimeterName: TLabel;
    BtnStartTesting: TButton;
    CBoxTestSourceUse: TCheckBox;
    CBoxTestSourceTimeIncrease: TCheckBox;
    CBoxTestWriteModbusLog: TCheckBox;
    EditTestSourceTime: TEdit;
    EditTestSourceKIncrease: TEdit;
    EditTestSourceTimeIncreaseCycle: TEdit;
    LblTestDosNameErr: TLabel;
    SpeedBtnDosConstructor: TSpeedButton;
    DataSetTextExporterEhDosList: TDataSetTextExporterEh;
    SpeedExportDosimeters: TSpeedButton;
    ButtonExportConfig: TButton;
    ButtonImportConfig: TButton;
    OpenDialogDeviceSettings: TOpenDialog;
    LblDBReserveComment: TLabel;
    EditReserveDBComment: TEdit;
    SpeedBtnSaveReserveComment: TSpeedButton;
    GroupBoxCurrentDB: TGroupBox;
    SpeedBtnSaveCurrentComment: TSpeedButton;
    EditCurrentDBComment: TEdit;
    LblDBCurrentComment: TLabel;
    SpeedBtnDetConstructor: TSpeedButton;
    SpeedBtnShowMeasRpt: TSpeedButton;
//    JvSpeedBtnMeasRpt: TJvSpeedButton;
    JvSpeedBtnMeasRpt: TSpeedButton;
    PopupMenuMeasRpt: TPopupMenu;
    pmRptMeasShowAndSave: TMenuItem;
    pmRptMeasSave: TMenuItem;
    pmRptMeasSaveAs: TMenuItem;
    SpeedBtnShowDosRpt: TSpeedButton;
//    JvSpeedBtnDosRpt: TJvSpeedButton;
    JvSpeedBtnDosRpt: TSpeedButton;
    PopupMenuDosRpt: TPopupMenu;
    pmRptDosShowAndSave: TMenuItem;
    pmRptDosSave: TMenuItem;
    pmRptDosSaveAs: TMenuItem;
    CBoxProcessDeviceID: TComboBox;
    LblProcessDevID: TLabel;
    SpBtnProcessDropDevID: TSpeedButton;
    LblDosDevID: TLabel;
    CBoxDosDeviceID: TComboBox;
    SpBtnDosDropDevID: TSpeedButton;
    TabSheetCalibration: TTabSheet;
    PanelCalibrationButtons: TPanel;
    SpeedBtnCalibrationExit: TSpeedButton;
    SplitterCalibration: TSplitter;
    PanelCalibrationLeft: TPanel;
    PanelCalibrationLeftGrid: TPanel;
    PanelCalibrationData: TPanel;
    PanelCalibrationChartK1: TPanel;
    PopupMenuCalibrGrid: TPopupMenu;
    ppCalibrCheckColumn: TMenuItem;
    sppCalibrColDeviceID: TMenuItem;
    sppCalibrColMeasID: TMenuItem;
    sppCalibrColDosType: TMenuItem;
    sppCalibrColMeasTime: TMenuItem;
    sppCalibrColKSI: TMenuItem;
    sppCalibrColDose: TMenuItem;
    sppCalibrColHp10g: TMenuItem;
    sppCalibrColHp10n: TMenuItem;
    sppCalibrColHp007: TMenuItem;
    sppCalibrColHp3: TMenuItem;
    sppCalibrColHstar: TMenuItem;
    sppCalibrColH007: TMenuItem;
    sppCalibrColD: TMenuItem;
    MenuItem35: TMenuItem;
    sppCalibrColK1: TMenuItem;
    sppCalibrColK2: TMenuItem;
    sppCalibrColK3: TMenuItem;
    sppCalibrColK4: TMenuItem;
    sppCalibrColK5: TMenuItem;
    sppCalibrColKgn: TMenuItem;
    ppProcessGridSendToCalibration: TMenuItem;
    ppMeasGridSendToCalibration: TMenuItem;
    ppCalibrRemoveFromList: TMenuItem;
    BntClean: TButton;
    BtnStartCalibr: TButton;
    DBGridEhCalcKDos: TDBGridEh;
    DataSourceCalcKDos: TDataSource;
    MemTableEhCalcKDos: TMemTableEh;
    MemTableEhCalcKDosdose: TStringField;
    MemTableEhCalcKDosradiationtype: TStringField;
    MemTableEhCalcKDoscalibrationvalue: TStringField;
    MemTableEhCalcKDosdosimetertype: TStringField;
    MemTableEhCalcKDosfulldosid: TStringField;
    MemTableEhCalcKDosmeasurmentid: TStringField;
    MemTableEhCalcKDosksi: TStringField;
    MemTableEhCalcKDostldid: TStringField;
    ChartK1Dos: TChart;
    MemTableEhCalcKDosk22: TFloatField;
    SeriesK1Err: TLineSeries;
    MemTableEhCalcKDoskgn: TFloatField;
    MemTableEhCalcKDosk5: TFloatField;
    MemTableEhCalcKDosk4: TFloatField;
    MemTableEhCalcKDosk3: TFloatField;
    MemTableEhCalcKDosk2: TFloatField;
    MemTableEhCalcKDoshp10g: TFloatField;
    MemTableEhCalcKDosd: TFloatField;
    MemTableEhCalcKDosh007: TFloatField;
    MemTableEhCalcKDoshstar: TFloatField;
    MemTableEhCalcKDoshp007: TFloatField;
    MemTableEhCalcKDoshp3: TFloatField;
    MemTableEhCalcKDoshp10n: TFloatField;
    PanelCalibrLeftFilter: TPanel;
    PanelCalibrLeftBottom: TPanel;
    SpeedBtnCalibrOpenFilter: TSpeedButton;
    SeriesK1Avg: TLineSeries;
//    ChartToolBannerK1: TBannerTool;
    SeriesK1: TLineSeries;
    MemTableEhCalcKDosformula_id_dos: TStringField;
    BtnCalibrAccept: TButton;
    ADOQueryCalibrList: TSQLQuery;
    PanelCalibrationBottomGrid: TPanel;
    MemTableEhCalcKDospartname: TStringField;
    MemTableEhCalcKDospartid: TStringField;
    sppCalibrPartName: TMenuItem;
    PanelCalibrationK: TPanel;
    EditK_5_Calibr: TEdit;
    LblK_5_Calibr: TLabel;
    LblDotK5_Calibr: TLabel;
    EditK_4_Calibr: TEdit;
    LblK_4_Calibr: TLabel;
    LblDotK4_Calibr: TLabel;
    EditK_3_Calibr: TEdit;
    LblK_3_Calibr: TLabel;
    LblDotK3_Calibr: TLabel;
    EditK_2_Calibr: TEdit;
    LblK_2_Calibr: TLabel;
    LblDotK2_Calibr: TLabel;
    EditK_gn_Calibr: TEdit;
    LblK_gn_Calibr: TLabel;
    LblDotKgn_Calibr: TLabel;
    EditK_1_Calibr: TEdit;
    LblDotK1_Calibr: TLabel;
    LblK_1_Calibr: TLabel;
    GBoxKDos: TGroupBox;
    DateTimePickerCalibr: TDateTimePicker;
    LblCalibrDate: TLabel;
    LabelCalibrKErr: TLabel;
    PanelCalibrationChartK2: TPanel;
    ChartK2Dos: TChart;
    SeriesK2Err: TLineSeries;
    SeriesK2Avg: TLineSeries;
    SeriesK2: TLineSeries;
//    ChartToolBannerK2: TBannerTool;
    PanelCalibrationChartKgn: TPanel;
    ChartKgnDos: TChart;
    SeriesKgnErr: TLineSeries;
    SeriesKgnAvg: TLineSeries;
    SeriesKgn: TLineSeries;
//    ChartToolBannerKgn: TBannerTool;
    PanelCalibrChartK: TPageControl;
    TabSheetK1: TTabSheet;
    TabSheetK2: TTabSheet;
    TabSheetKgn: TTabSheet;
    TabSheetK3: TTabSheet;
    TabSheetK4: TTabSheet;
    TabSheetK5: TTabSheet;
    EditKSAvg: TEdit;
    GroupBox1: TGroupBox;
    MemTableEhCalcKDosvalidity: TStringField;
    LabelCalibrMeasListErr: TLabel;
    MemTableEhCalcKDoserr_D_Percent: TStringField;
    MemTableEhCalcKDoserr_H_007_Percent: TStringField;
    MemTableEhCalcKDoserr_H_star_Percent: TStringField;
    MemTableEhCalcKDoserr_Hp_007_Percent: TStringField;
    MemTableEhCalcKDoserr_Hp_3_Percent: TStringField;
    MemTableEhCalcKDoserr_Hp_10n_Percent: TStringField;
    MemTableEhCalcKDoserr_Hp_10g_Percent: TStringField;
    TabSheetKS: TTabSheet;
    ChartKSDos: TChart;
    SeriesKSAvg: TLineSeries;
    SeriesKS: TLineSeries;
    procedure CBoxDosimeterTestChange(Sender: TObject);
    procedure CBoxDosimeterTestKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmBurningClick(Sender: TObject);
    procedure pmGradingClick(Sender: TObject);
    procedure pmIrradiationClick(Sender: TObject);
    procedure pmRegistrationClick(Sender: TObject);
    procedure PopupMenuDosGridPopup(Sender: TObject);
    procedure PopupMenuMeasGridPopup(Sender: TObject);
    procedure PopupMenuProcessGridPopup(Sender: TObject);
    procedure PopupSpeedBtnClick(Sender: TObject);

    procedure MemoCmdLogChange(Sender: TObject);
    procedure MenuFileExitClick(Sender: TObject);
    procedure MenuInfAboutClick(Sender: TObject);
    procedure MenuSetComClick(Sender: TObject);
    procedure MenuSetControlClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ppMeasChangeNumberClick(Sender: TObject);
    procedure ppProcessChangeNumberClick(Sender: TObject);
    procedure RadioButton_backupChange(Sender: TObject);
    procedure RadioButton_sqlChange(Sender: TObject);
    procedure SpeedBtnPauseClick(Sender: TObject);
    procedure TimerMeasureTimer(Sender: TObject);
    procedure SpeedBtnWinCascadeClick(Sender: TObject);
    procedure MenuMeasDBClick(Sender: TObject);
    procedure MenuSetChangeUserClick(Sender: TObject);
    procedure MenuSetEditUsersListClick(Sender: TObject);
    procedure SpeedBtnStartClick(Sender: TObject);
    procedure SpeedBtnStopClick(Sender: TObject);
    procedure SplitterVTopMoved(Sender: TObject);
    procedure SplitterVBottomMoved(Sender: TObject);
    procedure PanelDataResize(Sender: TObject);
    procedure DBGridDosCellClick(Column: TColumn);
    procedure EditMeasDosNumberChange(Sender: TObject);
    procedure EditMeasDosNumberKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridDosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridMeasureDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure SpeedButtonChangeUserClick(Sender: TObject);
    procedure TimerOpenFilterTimer(Sender: TObject);
    procedure SpeedBtnMeasSettingsD1Click(Sender: TObject);
    procedure SpeedBtnMeasSettingsD2Click(Sender: TObject);
    procedure SpeedBtnMeasSettingsD3Click(Sender: TObject);
    procedure SpeedBtnMeasSettingsD4Click(Sender: TObject);
    procedure CBoxMeasOrgNameChange(Sender: TObject);
    procedure CBoxMeasDepChange(Sender: TObject);
    procedure CBoxMeasDosPartChange(Sender: TObject);
    procedure CBoxMeasDosTypeChange(Sender: TObject);
    procedure CBoxMeasStatusChange(Sender: TObject);
    procedure CBoxMeasPersNumberChange(Sender: TObject);
    procedure CBoxMeasResultChange(Sender: TObject);
    procedure CBoxMeasIDKChange(Sender: TObject);
    procedure DateTimePickerMeasFromChange(Sender: TObject);
    procedure DateTimePickerMeasToChange(Sender: TObject);
    procedure TimerOpenAddDosParTimer(Sender: TObject);
    procedure DBGridEhDosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEhMeasureDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure MenuMeasGeneneratorClick(Sender: TObject);
    procedure DBGridEhDosSearchPanelSearchEditChange(Grid: TCustomDBGridEh; SearchEdit: TDBGridSearchPanelTextEditEh);
    procedure CBoxMeasCommentChange(Sender: TObject);
    procedure DBGridEhMeasListCellClick(Column: TColumnEh);
    procedure DBGridEhOnlyMeasCellClick(Column: TColumnEh);
    procedure DBGridEhMeasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure MenuMeasDosImportClick(Sender: TObject);
    procedure MenuMeasModelClick(Sender: TObject);
    procedure DBGridEhOnlyMeasKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MenuFileDBClick(Sender: TObject);
    procedure DBGridEhKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedBtnMeasZoomHorPlusD1Click(Sender: TObject);
    procedure SpeedBtnMeasZoomHorMinusD1Click(Sender: TObject);
    procedure TLDChartMeasDataD1Zoom(Sender: TObject);
    procedure SpeedBtnMeasStepLeftD1Click(Sender: TObject);
    procedure SpeedBtnMeasStepRightD1Click(Sender: TObject);
    procedure SpeedBtnMeasZoomVertPlusD1Click(Sender: TObject);
    procedure SpeedBtnMeasZoomVertMinusD1Click(Sender: TObject);
    procedure SpeedBtnMeasStepUpD1Click(Sender: TObject);
    procedure SpeedBtnMeasStepDownD1Click(Sender: TObject);
    procedure SpeedBtnMeasAutoSizeD1Click(Sender: TObject);
    procedure SpeedBtnMeasAutoSizeD2Click(Sender: TObject);
    procedure SpeedBtnMeasZoomHorPlusD2Click(Sender: TObject);
    procedure SpeedBtnMeasZoomHorMinusD2Click(Sender: TObject);
    procedure SpeedBtnMeasStepLeftD2Click(Sender: TObject);
    procedure SpeedBtnMeasStepRightD2Click(Sender: TObject);
    procedure SpeedBtnMeasZoomVertPlusD2Click(Sender: TObject);
    procedure SpeedBtnMeasZoomVertMinusD2Click(Sender: TObject);
    procedure SpeedBtnMeasStepUpD2Click(Sender: TObject);
    procedure SpeedBtnMeasStepDownD2Click(Sender: TObject);
    procedure SpeedBtnMeasZoomHorPlusD3Click(Sender: TObject);
    procedure SpeedBtnMeasZoomHorMinusD3Click(Sender: TObject);
    procedure SpeedBtnMeasStepLeftD3Click(Sender: TObject);
    procedure SpeedBtnMeasStepRightD3Click(Sender: TObject);
    procedure SpeedBtnMeasZoomVertPlusD3Click(Sender: TObject);
    procedure SpeedBtnMeasZoomVertMinusD3Click(Sender: TObject);
    procedure SpeedBtnMeasStepUpD3Click(Sender: TObject);
    procedure SpeedBtnMeasStepDownD3Click(Sender: TObject);
    procedure SpeedBtnMeasAutoSizeD3Click(Sender: TObject);
    procedure SpeedBtnMeasZoomHorPlusD4Click(Sender: TObject);
    procedure SpeedBtnMeasZoomHorMinusD4Click(Sender: TObject);
    procedure SpeedBtnMeasStepLeftD4Click(Sender: TObject);
    procedure SpeedBtnMeasStepRightD4Click(Sender: TObject);
    procedure SpeedBtnMeasZoomVertPlusD4Click(Sender: TObject);
    procedure SpeedBtnMeasZoomVertMinusD4Click(Sender: TObject);
    procedure SpeedBtnMeasStepUpD4Click(Sender: TObject);
    procedure SpeedBtnMeasStepDownD4Click(Sender: TObject);
    procedure SpeedBtnMeasAutoSizeD4Click(Sender: TObject);
    procedure ppDosGridCalibrationClick(Sender: TObject);
    procedure ppProcessGridCalibrationClick(Sender: TObject);
    procedure ppProcessGridRecalcClick(Sender: TObject);
    procedure MenuMeasDetTypeConstructorClick(Sender: TObject);
    procedure MenuMeasReportClick(Sender: TObject);
    procedure ppProcessGridDelClick(Sender: TObject);
    procedure BtnCalcD1Click(Sender: TObject);
    procedure BtnCalcD2Click(Sender: TObject);
    procedure BtnCalcD3Click(Sender: TObject);
    procedure BtnCalcD4Click(Sender: TObject);
    procedure SpeedBtnMeasCalcD1Click(Sender: TObject);
    procedure SpeedBtnMeasCalcD2Click(Sender: TObject);
    procedure SpeedBtnMeasCalcD3Click(Sender: TObject);
    procedure SpeedBtnMeasCalcD4Click(Sender: TObject);
    procedure PanelMeasLeftResize(Sender: TObject);
    procedure MenuMeasDosConstructorClick(Sender: TObject);
    procedure ppProcessGridSendToModelClick(Sender: TObject);
    procedure ppDosGridDecommissionedClick(Sender: TObject);
    procedure ppCBoxMeasProcessCheckAllClick(Sender: TObject);
    procedure ppCBoxMeasProcessDropAllClick(Sender: TObject);
    procedure ppCheckMeasProcessBoxInvertClick(Sender: TObject);
    procedure DBGridEhOnlyMeasTitleClick(Column: TColumnEh);
    procedure DBGridEhMeasListTitleClick(Column: TColumnEh);
    procedure DBGridEhDosTitleClick(Column: TColumnEh);
    procedure MenuFileImportDataBaseClick(Sender: TObject);
    procedure SpBtnMeasSQLFilterClick(Sender: TObject);
    procedure MenuMeasQueueClick(Sender: TObject);
    procedure pmSingleMeasClick(Sender: TObject);
    procedure pmSeriaMeasClick(Sender: TObject);
    procedure pmCalibrationClick(Sender: TObject);
    procedure PageControlMainChange(Sender: TObject);
    procedure PanelProcessLeftResize(Sender: TObject);
    procedure SpeedBtnProcessOpenFilterClick(Sender: TObject);
    procedure CBoxProcessOrgNameChange(Sender: TObject);
    procedure CBoxProcessDepChange(Sender: TObject);
    procedure CBoxProcessDosPartChange(Sender: TObject);
    procedure CBoxProcessDosTypeChange(Sender: TObject);
    procedure EditProcessDosNumberChange(Sender: TObject);
    procedure CBoxProcessStatusChange(Sender: TObject);
    procedure CBoxProcessPersNumberChange(Sender: TObject);
    procedure CBoxProcessIDKChange(Sender: TObject);
    procedure CBoxProcessResultChange(Sender: TObject);
    procedure CBoxProcessCommentChange(Sender: TObject);
    procedure DateTimePickerProcessFromChange(Sender: TObject);
    procedure DateTimePickerProcessToChange(Sender: TObject);
    procedure SpBtnProcessDropOrgNameClick(Sender: TObject);
    procedure SpBtnProcessDropDepClick(Sender: TObject);
    procedure SpBtnProcessDropDosPartClick(Sender: TObject);
    procedure SpBtnProcessDropDosTypeClick(Sender: TObject);
    procedure SpBtnProcessDropDosNumberClick(Sender: TObject);
    procedure SpBtnProcessDropStatusClick(Sender: TObject);
    procedure SpBtnProcessDropPersNumberClick(Sender: TObject);
    procedure SpBtnProcessDropIDKClick(Sender: TObject);
    procedure SpBtnProcessDropDateFromClick(Sender: TObject);
    procedure SpBtnProcessDropDateToClick(Sender: TObject);
    procedure SpBtnProcessDropResultClick(Sender: TObject);
    procedure SpBtnProcessDropCommentClick(Sender: TObject);
    procedure SpBtnProcessDropSQLScriptClick(Sender: TObject);
    procedure SpeedBtnProcessDropAllFilterClick(Sender: TObject);
    procedure EditEnable(Sender: TObject);
    procedure EditDisable(Sender: TObject);
    procedure OnClickDosEdit(Sender: TObject);
    procedure SpeedBtnProcessEditMeasClick(Sender: TObject);
    procedure CBoxDosOrgNameChange(Sender: TObject);
    procedure CBoxDosDepChange(Sender: TObject);
    procedure EditDosDosNumberChange(Sender: TObject);
    procedure CBoxDosDosPartChange(Sender: TObject);
    procedure CBoxDosDosTypeChange(Sender: TObject);
    procedure CBoxDosStatusChange(Sender: TObject);
    procedure CBoxDosPersNumberChange(Sender: TObject);
    procedure CBoxDosIDKChange(Sender: TObject);
    procedure DateTimePickerDosFromChange(Sender: TObject);
    procedure DateTimePickerDosToChange(Sender: TObject);
    procedure SpBtnDosDropOrgNameClick(Sender: TObject);
    procedure SpBtnDosDropDepClick(Sender: TObject);
    procedure SpBtnDosDropDosPartClick(Sender: TObject);
    procedure SpBtnDosDropDosTypeClick(Sender: TObject);
    procedure SpBtnDosDropDosNumberClick(Sender: TObject);
    procedure SpBtnDosDropStatusClick(Sender: TObject);
    procedure SpBtnDosDropPersNumberClick(Sender: TObject);
    procedure SpBtnDosDropIDKClick(Sender: TObject);
    procedure SpeedBtnDosDropAllFilterClick(Sender: TObject);
    procedure SpeedBtnDosOpenFilterClick(Sender: TObject);
    procedure DBGridEhDosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateTimePickerMeasChange(Sender: TObject);
    procedure JvDateTimePickerMeasChange(Sender: TObject);
    procedure SpBtnPrevClick(Sender: TObject);
    procedure SpBtnNextClick(Sender: TObject);
    procedure SpBtnProcessSQLFilterClick(Sender: TObject);
    procedure MenuMeasDosTypeConstructorClick(Sender: TObject);
    procedure PanelPermitLeftResize(Sender: TObject);
    procedure MenuFileImportMeasClick(Sender: TObject);
    procedure CLB_PermitsClick(Sender: TObject);
    procedure CLB_PermitsClickCheck(Sender: TObject);
    procedure SG_UsersClick(Sender: TObject);
    procedure SG_UsersKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CB_SetAsTemlateChange(Sender: TObject);
    procedure CB_SetAsTemlateDropDown(Sender: TObject);
    procedure AddUserSpeedBtnClick(Sender: TObject);
    procedure DeleteUserSpeedBtnClick(Sender: TObject);
    procedure ChangePassSpeedBtnClick(Sender: TObject);
    procedure SpeedBtnCalibrationClick(Sender: TObject);
    procedure SpeedBtnDosRegClick(Sender: TObject);
    procedure SpeedBtnDosTypeClick(Sender: TObject);
    procedure SpeedBtnDetTypeClick(Sender: TObject);
    procedure SpeedBtnImportDosClick(Sender: TObject);
    procedure MenuMeasStartClick(Sender: TObject);
    procedure SpeedBtnD1InfClick(Sender: TObject);
    procedure SpeedBtnD2InfClick(Sender: TObject);
    procedure SpeedBtnD3InfClick(Sender: TObject);
    procedure SpeedBtnD4InfClick(Sender: TObject);
    procedure SpeedBtnDosTypeInfClick(Sender: TObject);
    procedure BtnDosCancelClick(Sender: TObject);
    procedure MenuMeasDelDiscomDosClick(Sender: TObject);
    procedure BtnDosSaveClick(Sender: TObject);
    procedure PageControlDosParamChange(Sender: TObject);
    procedure ppCBoxDosCheckAllClick(Sender: TObject);
    procedure ppCBoxDosDropAllClick(Sender: TObject);
    procedure CheckBoxShowToDelClick(Sender: TObject);
    procedure MenuMeasDelMarkedToDelMeasClick(Sender: TObject);
    procedure sppProcessColDosTypeClick(Sender: TObject);
    procedure sppProcessColMeasIDClick(Sender: TObject);
    procedure sppProcessColMeasTimeClick(Sender: TObject);
    procedure sppProcessColKSIClick(Sender: TObject);
    procedure sppProcessColHp10gClick(Sender: TObject);
    procedure sppProcessColHp10nClick(Sender: TObject);
    procedure sppProcessColHp007Click(Sender: TObject);
    procedure sppProcessColHp3Click(Sender: TObject);
    procedure sppProcessColHstarClick(Sender: TObject);
    procedure sppProcessColH007Click(Sender: TObject);
    procedure sppProcessColDClick(Sender: TObject);
    procedure sppProcessColStatusMeasClick(Sender: TObject);
    procedure sppProcessColDateRegisterClick(Sender: TObject);
    procedure sppProcessColDateVerificationClick(Sender: TObject);
    procedure sppProcessColLastMeasDateClick(Sender: TObject);
    procedure sppProcessColStatusDosClick(Sender: TObject);
    procedure sppProcessColOrgClick(Sender: TObject);
    procedure sppProcessColDepClick(Sender: TObject);
    procedure sppProcessColPartClick(Sender: TObject);
    procedure sppProcessColCommentDosClick(Sender: TObject);
    procedure sppProcessColCommentMeasClick(Sender: TObject);
    procedure sppProcessColPersNumberClick(Sender: TObject);
    procedure sppProcessColFIOClick(Sender: TObject);
    procedure sppProcessColDeviceUserClick(Sender: TObject);
    procedure sppDosColDosTypeClick(Sender: TObject);
    procedure sppDosColStatusDosClick(Sender: TObject);
    procedure sppDosCol_k1Click(Sender: TObject);
    procedure sppDosCol_k2Click(Sender: TObject);
    procedure sppDosCol_k3Click(Sender: TObject);
    procedure sppDosCol_k4Click(Sender: TObject);
    procedure sppDosCol_k5Click(Sender: TObject);
    procedure sppDosCol_kgnClick(Sender: TObject);
    procedure sppDosColPartClick(Sender: TObject);
    procedure sppDosColDateRegisterClick(Sender: TObject);
    procedure sppDosColDateVerificationClick(Sender: TObject);
    procedure sppDosColOrgClick(Sender: TObject);
    procedure sppDosColDepClick(Sender: TObject);
    procedure sppDosColLastMeasCommentClick(Sender: TObject);
    procedure PanelDosLeftResize(Sender: TObject);
    procedure CBDosDataDosStatusChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure sppProcessColDoseClick(Sender: TObject);
    procedure PageControlMeasDosParChange(Sender: TObject);
    procedure PageControlProcessDosParChange(Sender: TObject);
    procedure EditsMeasIDKChanges(Sender: TObject);
    procedure EditsProcessIDKChanges(Sender: TObject);
    procedure SpeedBtnMeasSaveIDKClick(Sender: TObject);
    procedure SpeedBtnProcessSaveIDKClick(Sender: TObject);
    procedure SpeedBtnMeasEditMeasClick(Sender: TObject);
    procedure sppMeasColMeasIDClick(Sender: TObject);
    procedure sppMeasColMeasTimeClick(Sender: TObject);
    procedure sppMeasColKSIClick(Sender: TObject);
    procedure sppMeasColDoseClick(Sender: TObject);
    procedure sppMeasColHp10gClick(Sender: TObject);
    procedure sppMeasColHp10nClick(Sender: TObject);
    procedure sppMeasColHp007Click(Sender: TObject);
    procedure sppMeasColHp3Click(Sender: TObject);
    procedure sppMeasColHstarClick(Sender: TObject);
    procedure sppMeasColH007Click(Sender: TObject);
    procedure sppMeasColDClick(Sender: TObject);
    procedure sppMeasColStatusMeasClick(Sender: TObject);
    procedure sppMeasColDosTypeClick(Sender: TObject);
    procedure sppMeasColDateRegisterClick(Sender: TObject);
    procedure sppMeasColDateVerificationClick(Sender: TObject);
    procedure sppMeasColLastMeasDateClick(Sender: TObject);
    procedure sppMeasColStatusDosClick(Sender: TObject);
    procedure sppMeasColOrgClick(Sender: TObject);
    procedure sppMeasColDepClick(Sender: TObject);
    procedure sppMeasColPartClick(Sender: TObject);
    procedure sppMeasColCommentDosClick(Sender: TObject);
    procedure sppMeasColCommentMeasClick(Sender: TObject);
    procedure sppMeasColPersNumberClick(Sender: TObject);
    procedure sppMeasColFIOClick(Sender: TObject);
    procedure sppMeasColDeviceUserClick(Sender: TObject);
    procedure DBGridEhOnlyMeasCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
    procedure pmTestingClick(Sender: TObject);
    procedure ReinintBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure DBGridEhProcessCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
    procedure TimerTestTimer(Sender: TObject);
    procedure DBGridEhDosCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
    procedure ppMeasSaveToFileClick(Sender: TObject);
    procedure TimerSourceTestTimer(Sender: TObject);
    procedure ppMeasSaveToFileWithiDetDoseClick(Sender: TObject);
    procedure ppProcessSaveToFileClick(Sender: TObject);
    procedure ppProcessSaveToFileWithiDetDoseClick(Sender: TObject);
    procedure sppMeasColHp10g_ErrClick(Sender: TObject);
    procedure sppMeasColHp10n_ErrClick(Sender: TObject);
    procedure sppMeasColHp007_ErrClick(Sender: TObject);
    procedure sppMeasColHp3_ErrClick(Sender: TObject);
    procedure sppMeasColHstar_ErrClick(Sender: TObject);
    procedure sppMeasColH007_ErrClick(Sender: TObject);
    procedure sppMeasColD_ErrClick(Sender: TObject);
    procedure sppProcessColHp10g_ErrClick(Sender: TObject);
    procedure sppProcessColHp10n_ErrClick(Sender: TObject);
    procedure sppProcessColHp007_ErrClick(Sender: TObject);
    procedure sppProcessColHp3_ErrClick(Sender: TObject);
    procedure sppProcessColHstar_ErrClick(Sender: TObject);
    procedure sppProcessColH007_ErrClick(Sender: TObject);
    procedure sppProcessColD_ErrClick(Sender: TObject);
    procedure SpeedBtnPartInfClick(Sender: TObject);
    procedure BtnExcludeFromPartClick(Sender: TObject);
    procedure BtnDecommissionDosClick(Sender: TObject);
    procedure BtnOpenCalibrClick(Sender: TObject);
    procedure SpeedBtnMeasDataWarningD1Click(Sender: TObject);
    procedure SpeedBtnMeasDataWarningD2Click(Sender: TObject);
    procedure SpeedBtnMeasDataWarningD3Click(Sender: TObject);
    procedure SpeedBtnMeasDataWarningD4Click(Sender: TObject);
    procedure SpeedBtnProcessDataWarningD1Click(Sender: TObject);
    procedure SpeedBtnProcessDataWarningD2Click(Sender: TObject);
    procedure SpeedBtnProcessDataWarningD3Click(Sender: TObject);
    procedure SpeedBtnProcessDataWarningD4Click(Sender: TObject);
    procedure sppDosColLastMeasTimeClick(Sender: TObject);
    procedure sppDosColLastMeasResultClick(Sender: TObject);
    procedure ppDosStatusDropWarningClick(Sender: TObject);
    procedure SpeedBtnMeasUserWarningClick(Sender: TObject);
    procedure SpeedBtnProcessUserWarningClick(Sender: TObject);
    procedure ButtonDataBaseClick(Sender: TObject);
    procedure BtnImportDataBaseClick(Sender: TObject);
    procedure ButtonComPortSettingsClick(Sender: TObject);
    procedure ButtonChangeUserClick(Sender: TObject);
    procedure ButtonControlDeviceClick(Sender: TObject);
    procedure ButtonModelClick(Sender: TObject);
    procedure BtnDeleteDiscommissionDosimetersClick(Sender: TObject);
    procedure BtnDeleteMarkedToDelMeasClick(Sender: TObject);
    procedure ButtonAboutClick(Sender: TObject);
    procedure SpeedBtnMeasExitClick(Sender: TObject);
    procedure EditMeasDataCommentChange(Sender: TObject);
    procedure SpeedBtnMeasSaveParamClick(Sender: TObject);
    procedure SpeedBtnProcessSaveParamClick(Sender: TObject);
    procedure EditProcessDataCommentChange(Sender: TObject);
    procedure SpeedBtnProcessExitClick(Sender: TObject);
    procedure SpeedBtnDosExitClick(Sender: TObject);
    procedure SpeedBtnSettingsExitClick(Sender: TObject);
    procedure CBoxKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedBtnMeasDet1InfClick(Sender: TObject);
    procedure SpeedBtnMeasDet2InfClick(Sender: TObject);
    procedure SpeedBtnMeasDet3InfClick(Sender: TObject);
    procedure SpeedBtnMeasDet4InfClick(Sender: TObject);
    procedure SpeedBtnProcessDet1InfClick(Sender: TObject);
    procedure SpeedBtnProcessDet2InfClick(Sender: TObject);
    procedure SpeedBtnProcessDet3InfClick(Sender: TObject);
    procedure SpeedBtnProcessDet4InfClick(Sender: TObject);
    procedure JvSpeedBtnMeasDosStatusClick(Sender: TObject);
    procedure JvSpeedBtnProcessDosStatusClick(Sender: TObject);
    procedure ImageMeasPageLogoClick(Sender: TObject);
    procedure SpeedBtnMeasDosTypeInfClick(Sender: TObject);
    procedure PageControlSettingsChange(Sender: TObject);
    procedure DBGridEhDBDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEhDBKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridEhDBCellClick(Column: TColumnEh);
    procedure BtnDeleteDBClick(Sender: TObject);
    procedure BtnExportClick(Sender: TObject);
    procedure TabSheetMeasShow(Sender: TObject);
    procedure TabSheetMeasProcessingShow(Sender: TObject);
    procedure BtnResstoreDBClick(Sender: TObject);
    procedure BtnClearPortClick(Sender: TObject);
    procedure TabSheetDeviceControlShow(Sender: TObject);
    procedure ComboBoxPortNumberChange(Sender: TObject);
    //procedure ComboBoxBoudRateChange(Sender: TObject);
    //procedure ComboBoxStopBitChange(Sender: TObject);
    //procedure ComboBoxParityChange(Sender: TObject);
    procedure CBoxSettingsShowOriginalKTVClick(Sender: TObject);
    procedure CBoxSettingsShowGladeKTVClick(Sender: TObject);
    procedure CBoxSettingsAutoResetDeviceClick(Sender: TObject);
    procedure CBoxSettingsUseAutoCommentClick(Sender: TObject);
    procedure MemoSettingsAutoCommentChange(Sender: TObject);
    procedure BtnSettingsSaveParametersClick(Sender: TObject);
    procedure ppCBoxOnlyMeasCheckAllClick(Sender: TObject);
    procedure ppCBoxOnlyMeasDropAllClick(Sender: TObject);
    procedure sppProcessColDeviceIDClick(Sender: TObject);
    procedure sppMeasColDeviceIDClick(Sender: TObject);
    procedure sppDosColDeviceIDClick(Sender: TObject);
    procedure SpeedBtnDosRegFromFileClick(Sender: TObject);
    procedure BtnDecommissionDosGroupClick(Sender: TObject);
    procedure BtnSaveDosAdditionalParametersGroupClick(Sender: TObject);
    procedure PageDosNumberChange(Sender: TObject);
    procedure BtnOpenCalibrGroupClick(Sender: TObject);
    procedure EditDosDataDosOrgValKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditDosDataDosDepValKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditDosDataDosOrgValGroupKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditDosDataDosDepValGroupKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditMeasDataCommentKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditMeasDataDosFioKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditMeasDataDosOrgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditMeasDataDosDepKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditMeasDataDosPersNumberKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditProcessDataCommentKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditProcessDataDosFioKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditProcessDataDosPersNumberKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditProcessDataDosOrgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditProcessDataDosDepKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CBoxTestSourceUseClick(Sender: TObject);
    procedure CBoxTestSourceTimeIncreaseClick(Sender: TObject);
    procedure CBoxTestWriteModbusLogClick(Sender: TObject);
    procedure EditTestSourceTimeChange(Sender: TObject);
    procedure EditTestSourceTimeIncreaseCycleChange(Sender: TObject);
    procedure EditTestSourceKIncreaseChange(Sender: TObject);
    procedure EditTestSourceDosimeterNameChange(Sender: TObject);
    procedure BtnStartTestingClick(Sender: TObject);
    procedure SpeedBtnDosConstructorClick(Sender: TObject);
    procedure SpeedExportDosimetersClick(Sender: TObject);
    procedure DataSetTextExporterEhDosListFinishExport(Sender: TObject);
    procedure ButtonExportConfigClick(Sender: TObject);
    procedure ButtonImportConfigClick(Sender: TObject);
    procedure EditReserveDBCommentChange(Sender: TObject);
    procedure EditReserveDBCommentKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedBtnSaveReserveCommentClick(Sender: TObject);
    procedure EditCurrentDBCommentChange(Sender: TObject);
    procedure SpeedBtnSaveCurrentCommentClick(Sender: TObject);
    procedure SpeedBtnDetConstructorClick(Sender: TObject);
    procedure SpeedBtnShowMeasRptClick(Sender: TObject);
    procedure pmRptMeasShowAndSaveClick(Sender: TObject);
    procedure pmRptMeasSaveClick(Sender: TObject);
    procedure pmRptMeasSaveAsClick(Sender: TObject);
    procedure BntCleanClick(Sender: TObject);
    procedure SpeedBtnShowDosRptClick(Sender: TObject);
    procedure pmRptDosShowAndSaveClick(Sender: TObject);
    procedure pmRptDosSaveClick(Sender: TObject);
    procedure pmRptDosSaveAsClick(Sender: TObject);
    procedure CBoxProcessDeviceIDChange(Sender: TObject);
    procedure SpBtnProcessDropDevIDClick(Sender: TObject);
    procedure SpBtnDosDropDevIDClick(Sender: TObject);
    procedure CBoxDosDeviceIDChange(Sender: TObject);
    procedure CBoxExTestSourceDosimeterNameChange(Sender: TObject);
    procedure CBoxExTestSourceDosimeterNameKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedBtnCalibrationExitClick(Sender: TObject);
    procedure DBGridEhCalibrationCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
    procedure sppCalibrColDeviceIDClick(Sender: TObject);
    procedure sppCalibrColMeasIDClick(Sender: TObject);
    procedure sppCalibrColDosTypeClick(Sender: TObject);
    procedure sppCalibrColMeasTimeClick(Sender: TObject);
    procedure sppCalibrColKSIClick(Sender: TObject);
    procedure sppCalibrColDoseClick(Sender: TObject);
    procedure sppCalibrColHp10gClick(Sender: TObject);
    procedure sppCalibrColHp10nClick(Sender: TObject);
    procedure sppCalibrColHp007Click(Sender: TObject);
    procedure sppCalibrColHp3Click(Sender: TObject);
    procedure sppCalibrColHstarClick(Sender: TObject);
    procedure sppCalibrColH007Click(Sender: TObject);
    procedure sppCalibrColDClick(Sender: TObject);
    procedure sppCalibrColK1Click(Sender: TObject);
    procedure sppCalibrColK2Click(Sender: TObject);
    procedure sppCalibrColK3Click(Sender: TObject);
    procedure sppCalibrColK4Click(Sender: TObject);
    procedure sppCalibrColK5Click(Sender: TObject);
    procedure sppCalibrColKgnClick(Sender: TObject);
    procedure PanelCalibrationLeftResize(Sender: TObject);
    procedure ppProcessGridSendToCalibrationClick(Sender: TObject);
    procedure ppMeasGridSendToCalibrationClick(Sender: TObject);
    procedure ppCalibrRemoveFromListClick(Sender: TObject);
    procedure BtnStartCalibrClick(Sender: TObject);
    procedure SpeedBtnCalibrOpenFilterClick(Sender: TObject);
    procedure DBGridEhCalcKDosCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
    procedure SeriesK1Click(Sender: TChartSeries; ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DBGridEhCalcKDosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ppCalcKDosDelClick(Sender: TObject);
    procedure CBoxGroupByDosNumberClick(Sender: TObject);
    procedure sppCalibrPartNameClick(Sender: TObject);
    procedure BtnCalibrAcceptClick(Sender: TObject);
    procedure DBGridEhCalcKDosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure EditK_1_CalibrChange(Sender: TObject);
    procedure EditK_2_CalibrChange(Sender: TObject);
    procedure EditK_gn_CalibrChange(Sender: TObject);
    procedure DBGridEhCalcKDosTitleClick(Column: TColumnEh);
    procedure SeriesKSClick(Sender: TChartSeries; ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DBGridEhOnlyMeasColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure DBGridEhProcessColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure DBGridEhDosColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure DBGridEhCalcKDosColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
  private
    FFilter                         : String;
    FInformation                    : boolean;

    // параметры установки
    FDeviceID                       : integer;  // ID установки
    FConstructiveVersion            : integer;  // версия конструктива
    FDBVersion                      : integer;  // версия БД
    FKSLevel                        : integer;  // установленное значение контрольной светосуммы для каждого ящика
    FKSDelta                        : integer;  // допустимое отклонение контрольной суммы от установленного значения (в процентах)
    FKFilter                        : double;   // коэффициент фильтра для больших доз
    FKDevice                        : double;   // коэффициент установки
    FUseKFilter                     : boolean;  // использовать фильтр

    FSoftwareVer                    : integer;  // версия ПО (build)

    FCOMName                        : String;   // параметры COM-порта
    FBaudRate                       : integer;  // параметры COM-порта
    FStopBits                       : integer;  // параметры COM-порта
    FParity                         : integer;  // параметры COM-порта
    FByteSize                       : integer;  // параметры COM-порта

    FKTime                          : integer;  // добавка для перехода в десятые секунды, введена, чтобы в будущем уйти от десятых долей
    FTempDeviation                  : integer;  // допустимое отклонение температурного профиля

    FStatusBarDB                    : String;   // значение статус-бара состояния связи с базой данных
    FStatusBarUser                  : String;   // значение статус-бара текущего пользователя

    TLDState                        : word;     // статус установки

    FTmpState                       : integer;

    CntD                            : integer;  // счетчик для отслеживания отсылки комманд на измерение детектора

    FHideD1                         : boolean;
    FHideD2                         : boolean;
    FHideD3                         : boolean;
    FHideD4                         : boolean;

    FShowDelMeas                    : boolean;
    FDosShowFromAllDevices          : boolean;
    FShowOriginalKTV                : boolean;
    FShowGladeKTV                   : boolean;
    FUseControlComment              : boolean;
    FControlComment                 : String;
    FAutoReset                      : boolean;
    FLastUserWarning                : String;
    FUseDevFilterIndBit             : boolean;
    FDosCntAutoCreatePart           : integer;
    FSettingsSkipDetector           : integer;

    FMaximazeD1Chart                : boolean;
    FMaximazeD2Chart                : boolean;
    FMaximazeD3Chart                : boolean;
    FMaximazeD4Chart                : boolean;

    ListDosInf                      : TStringList;
    ListMeasInf                     : TStringList;

    FFilterPanelHeight              : integer;
    FFilterDosPanelHeight           : integer;
    FFilterCalibrPanelHeight        : integer;
    FOpenFilterMeasPanel            : boolean;
    FOpenFilterDosPanel             : boolean;
    FOpenFilterProcessPanel         : boolean;
    FOpenFilterCalibrPanel          : boolean;

    FIDForQuery                     : String;
    FIDMeasForQuery                 : String;
    FDosTypeForQuery                : String;

    //FQueue                          : boolean;

    FPermitSelectedRowUser          : integer;
    FPermitMask                     : int64;

    FConfirmationRequest            : boolean;

    FMeasColumnMeasID               : boolean;
    FMeasColumnMeasDateTime         : boolean;
    FMeasColumnKSI                  : boolean;
    FMeasColumnDose                 : boolean;
    FMeasColumnHp10g                : boolean;
    FMeasColumnHp10n                : boolean;
    FMeasColumnHp007                : boolean;
    FMeasColumnHp3                  : boolean;
    FMeasColumnHStar                : boolean;
    FMeasColumnH007                 : boolean;
    FMeasColumnD                    : boolean;
    FMeasColumnHp10g_Err            : boolean;
    FMeasColumnHp10n_Err            : boolean;
    FMeasColumnHp007_Err            : boolean;
    FMeasColumnHp3_Err              : boolean;
    FMeasColumnHStar_Err            : boolean;
    FMeasColumnH007_Err             : boolean;
    FMeasColumnD_Err                : boolean;
    FMeasColumnMeasValidity         : boolean;
    FMeasColumnDosType              : boolean;
    FMeasColumnDosReg               : boolean;
    FMeasColumnDosVer               : boolean;
    FMeasColumnDosStatus            : boolean;
    FMeasColumnOrganization         : boolean;
    FMeasColumnDepartment           : boolean;
    FMeasColumnPartID               : boolean;
    FMeasColumnMeasComment          : boolean;
    FMeasColumnPersNumber           : boolean;
    FMeasColumnFIO                  : boolean;
    FMeasColumnTLDUser              : boolean;
    FMeasColumnLastMeasComment      : boolean;
    FMeasColumnLastMeasTime         : boolean;
    FMeasColumnTldID                : boolean;

    FProcessColumnMeasID            : boolean;
    FProcessColumnMeasDateTime      : boolean;
    FProcessColumnKSI               : boolean;
    FProcessColumnDose              : boolean;
    FProcessColumnHp10g             : boolean;
    FProcessColumnHp10n             : boolean;
    FProcessColumnHp007             : boolean;
    FProcessColumnHp3               : boolean;
    FProcessColumnHStar             : boolean;
    FProcessColumnH007              : boolean;
    FProcessColumnD                 : boolean;
    FProcessColumnHp10g_Err         : boolean;
    FProcessColumnHp10n_Err         : boolean;
    FProcessColumnHp007_Err         : boolean;
    FProcessColumnHp3_Err           : boolean;
    FProcessColumnHStar_Err         : boolean;
    FProcessColumnH007_Err          : boolean;
    FProcessColumnD_Err             : boolean;
    FProcessColumnMeasValidity      : boolean;
    FProcessColumnDosType           : boolean;
    FProcessColumnDosReg            : boolean;
    FProcessColumnDosVer            : boolean;
    FProcessColumnDosStatus         : boolean;
    FProcessColumnOrganization      : boolean;
    FProcessColumnDepartment        : boolean;
    FProcessColumnPartID            : boolean;
    FProcessColumnMeasComment       : boolean;
    FProcessColumnPersNumber        : boolean;
    FProcessColumnFIO               : boolean;
    FProcessColumnTLDUser           : boolean;
    FProcessColumnLastMeasComment   : boolean;
    FProcessColumnLastMeasTime      : boolean;
    FProcessColumnTldID             : boolean;

    FCalibrColumnMeasID             : boolean;
    FCalibrColumnMeasDateTime       : boolean;
    FCalibrColumnKSI                : boolean;
    FCalibrColumnDose               : boolean;
    FCalibrColumnK1                 : boolean;
    FCalibrColumnK2                 : boolean;
    FCalibrColumnK3                 : boolean;
    FCalibrColumnK4                 : boolean;
    FCalibrColumnK5                 : boolean;
    FCalibrColumnKgn                : boolean;
    FCalibrColumnHp10g              : boolean;
    FCalibrColumnHp10n              : boolean;
    FCalibrColumnHp007              : boolean;
    FCalibrColumnHp3                : boolean;
    FCalibrColumnHStar              : boolean;
    FCalibrColumnH007               : boolean;
    FCalibrColumnD                  : boolean;
    FCalibrColumnHp10g_Err          : boolean;
    FCalibrColumnHp10n_Err          : boolean;
    FCalibrColumnHp007_Err          : boolean;
    FCalibrColumnHp3_Err            : boolean;
    FCalibrColumnHStar_Err          : boolean;
    FCalibrColumnH007_Err           : boolean;
    FCalibrColumnD_Err              : boolean;
    FCalibrColumnMeasValidity       : boolean;
    FCalibrColumnDosType            : boolean;
    FCalibrColumnDosReg             : boolean;
    FCalibrColumnDosVer             : boolean;
    FCalibrColumnDosStatus          : boolean;
    FCalibrColumnOrganization       : boolean;
    FCalibrColumnDepartment         : boolean;
    FCalibrColumnPartID             : boolean;
    FCalibrColumnMeasComment        : boolean;
    FCalibrColumnPersNumber         : boolean;
    FCalibrColumnFIO                : boolean;
    FCalibrColumnTLDUser            : boolean;
    FCalibrColumnLastMeasComment    : boolean;
    FCalibrColumnTldID              : boolean;

    FDosColumnDosType               : boolean;
    FDosColumnDosState              : boolean;
    FDosColumnk1                    : boolean;
    FDosColumnk2                    : boolean;
    FDosColumnk3                    : boolean;
    FDosColumnk4                    : boolean;
    FDosColumnk5                    : boolean;
    FDosColumnkgn                   : boolean;
    FDosColumnPartID                : boolean;
    FDosColumnRegTime               : boolean;
    FDosColumnVerTime               : boolean;
    FDosColumnOrg                   : boolean;
    FDosColumnDep                   : boolean;
    FDosColumnLastMeasTime          : boolean;
    FDosColumnLastMeasResult        : boolean;
    FDosColumnLastMeasComment       : boolean;
    FDosColumnTldID                 : boolean;

    FUserWarningComment             : boolean;

    FStartTestingCommentTime        : TDateTime;
    FStartTestingTime               : TDateTime;
    FStartSourceTestingTime         : TDateTime;

    FWorkingTime                    : integer;

    FTestSourceUse                  : boolean;       // флаг использования источника в режиме тестирования
    FTestSourceTimeIncrease         : boolean;       // флаг разрешения увеличения времени экспозиции детектора под источником в FTestSourceKIncrease раз
    FTestSourceTimeIncreaseCycle    : integer;       // количество раз, которое будет измерен детектор за указанный интервал времени FTestSourceTime
    FTestSourceTimeCurrentCycle     : integer;       // счетчик измерений в одном временном цикле
    FTestSourceKIncrease            : double;        // коэффициент на который умножается время экспозиции детектора под источником, если взведен флаг FTestSourceTimeIncrease
    FTestSourceTime                 : integer;       // время экспозиции детектора под источником, если взведен флаг FTestSourceUse
    FTestSourceDosimeterName        : String;
    FTestWriteModbusLog             : boolean;

    FReportWithDets                 : boolean;                   // формировать отчет с данными по детекторам
    FGroupDosOperation              : boolean;
    FCalibrationPressed             : boolean;

    UI_Delay                        : array [TDialogType] of integer;

//    FTestSource                     : boolean;
    function Autentification        : boolean;                   // функция аутентификации
    function CheckDBTables          : boolean;

    function CheckFilteredDosNumber : boolean;
    function GetGridDosNumber       : String;
    function IsHideD1               : boolean;
    function IsHideD2               : boolean;
    function IsHideD3               : boolean;
    function IsHideD4               : boolean;

    function IsUseFilterCB(ComboBox: TComboBox): boolean;
    function IsUseFilterEdit(Edit: TEdit): boolean;
    function IsUseFilterDatePicker(DateTimePicker: TDateTimePicker): boolean;

    function IsUseSQLScript         : boolean;

    function GetValForQuery(MeasID: String): boolean;
    function IsNotEmptyDet(dosType, detType: String) : boolean;
    function ChangeBytesDetCnt(Byte: word; BitPos: integer; BitState: boolean): word;
    function EmulatorLoadResults(FileName: String): boolean;

    procedure OnReceiveDeviceID(Value: integer);                     // считывание ID установки
    procedure OnReceiveConstructiveVer(Value: integer);              // считывание версии конструктива
    procedure OnReceiveSoftwareVer(Value: String);                   // весрия прошивки
    procedure OnReceiveTemp;                                         // отображение текущей температуры (показания считаются из счвитанной структуры)
    procedure OnReceiveWorkingTime(WorkingTime: dword);              // отображение времени работы установки
    procedure OnReceiveTempProfile;                                  // отображение заданного профиля нагрева
    procedure OnReceiveResults;                                      // отображение измеренных данных
    procedure OnEndMeasure(aCarretPosition:TCarretePosition; aFinished: boolean); // Окончание измерения
    procedure OnReceiveCommand_CloseStartMFWindow;
    procedure OnReceiveCommand_MeasureStopped;
    procedure OnReceiveKS(Value: integer);                           // КСИ
    procedure OnReseiveTablePos(Value: integer);                     // положение стола
    procedure OnCheckDarkCurrent(aTestPassed: boolean; aDarkCurrent1,aDarkCurrent2: real);
    procedure OnCheckKSI(aTestPassed: boolean; aKSI1,aKSI2: real);
    procedure OnMeasureScanDosimeter;                                // После скана штрихкода
    procedure OnGetPanelCommand(aCmd: word);
    function OnUIAnswer(aCaption,aMessage: string; aDialogType: TDialogType; anAccidentNumber: integer): integer;
    //procedure OnAccident(anAccident: TAccident; accMessage: string); // При аварийной ситуации
    procedure OnPanelDisconnect(aDisconnectType: word);              // При отключении панели


    procedure SetCOMName (aCOMName: String);     // параметры COM-порта
//    procedure SetBaudRate (aBaudRate: integer);
//    procedure SetStopBits (aStopBits: integer);
//    procedure SetParity (aParitye: integer);
//    procedure SetByteSize (aByteSize: integer);

    procedure ReadFilterIni;                     // считывание параметров фильтра
    procedure ReadFilterIniAll;                  // считывание параметров всех фильтров
    procedure SaveFilterTextIni(Section: String; ParameterName: String; Value: String);
    procedure SaveFilterBoolIni(ParameterName: String; Value: boolean);
    procedure SaveFilterDateIni(ParameterName: String; Value: String);
    procedure SaveBoolToIni(SectionName,ParameterName: String; Value: boolean);
    procedure ReadDeivceIdIni;                   //
    procedure SaveDetTXTResults(aName: String);      // запись результатов в файл
    procedure SaveDosTXTResults(aName: String; Path: String); overload;
    procedure RefreshDetKtvTmp;                  // запись данных в из считывателя в структуру данных
    procedure WritePacketLog(aLog: String);      // запись лог приемо-передачи пакетов
    procedure WriteCommandLog(aLog: String);     // запись лога комманод
    procedure ParsingCMDParameters;              // процедура парсинга парамтров с которыми запускается программа, указанных в ярлыке
    procedure SetStatusBarDB(aStatusBarDB: String);
    procedure SetStatusBarUser(aStatusBarUser: String);
    procedure ClearCharts;
    procedure ClearLebels;
    procedure SetHidePanels(Value: boolean);
    procedure CheckState;
    procedure SetTmpState(aTmpState: integer);
    procedure SetHideD1(aHide: boolean);
    procedure SetHideD2(aHide: boolean);
    procedure SetHideD3(aHide: boolean);
    procedure SetHideD4(aHide: boolean);
    procedure SetOpenFilterDosPanel(Value: boolean);
    procedure SetOpenFilterProcessPanel(Value: boolean);
    procedure SetOpenFilterCalibrPanel(Value: boolean);
    procedure SetUseFilterDate(DataPicker: TDateTimePicker; SpeedBtn: TSpeedButton; aUse: boolean);
    procedure SetUseSQLScript(aUse: boolean);
    procedure SetFilter(aFilter: String);
    procedure SetDeviceID(Value: integer);
    procedure SetConstructiveVersion(Value: integer);
    procedure SetKSLevel(Value: integer);
    procedure SetKSDelta(Value: integer);
    procedure SetKFilter(Value: double);
    procedure SetKDevice(Value: double);
    procedure SetUseKFilter(Value: boolean);
    procedure SetIDForQuery(const Value: String);
    procedure SetIDMeasForQuery(const Value: String);
    procedure SetDosTypeForQuery(const Value: String);
    procedure SetStart(const Value: boolean);
    procedure SetInformation(const Value: boolean);
    //procedure SetQueue(const Value: boolean);
    procedure SetOnlyMeasPage(const Value: boolean);
    procedure SetShowDelMeas(const Value: boolean);
    procedure SetDosShowFromAllDevices(const Value: boolean);

    procedure ShowInChart(aChart: TChart; aSeriea: integer; aData : String; aDosimeterID: String);
    procedure ShowDetectorInf(Dose: String;
                              Err: String;
                              DetType: String;
                              DetPos: integer;
                              DetState: TDetectorState);

    procedure ShowCalcFunctions(aDetPos: integer);
    procedure DetectorProcessing(EditStatus,EditStatusMeas: TEdit; Gauge,GaugeMeas: TATGauge; DetPos: integer);
    procedure SkipDetector(DetPos: integer; DetState: TDetectorState);
    procedure DeleteDiscommissionDosimeters;
    procedure DeleteMarkedToDelMeas;

    procedure LoadComboBoxFromIni(ComboBox: TComboBox; Value: String);
    procedure LoadDateTimeFromIni(Value: String; DataPicker: TDateTimePicker; SpeedBtn: TSpeedButton);
    procedure LoadCheckBoxFromIni(CheckBox: TCheckBox; Value: boolean);
    procedure LoadCBoxSourceTest;

    procedure ShowFinishMeasureW(NewMeasure: boolean);
    procedure ShowStopMeasureW;
    procedure UpdateFinishMeasureW;
    procedure EmulatorResults;

    procedure DChartZoomHorPlus(Chart: TChart);
    procedure DChartZoomHorMinus(Chart: TChart);
    procedure DChartZoomVertPlus(Chart: TChart);
    procedure DChartZoomVertMinus(Chart: TChart);
    procedure DChartOffsetHorLeft(Chart: TChart);
    procedure DChartOffsetHorRight(Chart: TChart);
    procedure DChartOffsetVertUp(Chart: TChart);
    procedure DChartOffsetVertDown(Chart: TChart);
    procedure DChartAutoSize(Chart: TChart);

    procedure LoadComboBox(ComboBox: TComboBox; Field: String);

    //procedure StartMeas(const Value: integer);
    procedure StartMeas(const Value: TProcessType);

    function GetFilterDos(Field: String): String;
    function GetFilterMeas(Field: String): String;
    function GetUserIndexFromSG(UserName: String): integer;
    function IsEditIDKChanged(EditPersNumberFIO, EditPersNumber, EditOrg, EditDep: TEdit): boolean;
    function IsEditCommentChanged(EditComment: TEdit): boolean;
    function IsEditReserveDBCommentChanged(EditDBComment: TEdit): boolean;
    function IsEditCurrentDBCommentChanged(EditDBComment: TEdit): boolean;
    function IsIdenticalSelectedDosTypes: boolean;

    procedure ResizeDosPanelLeft(DBGrid: TDbGridEh; MemTable: TMemTableEh);
    procedure ResizeMeasPanelLeft(DBGrid: TDbGridEh; MemTable: TMemTableEh);
    procedure ResizeDetPanels(PanelData         : TPanel;
                              PanelDataDos      : TPanel;
                              PanelButtons      : TPanel;
                              PanelDataDets     : TPanel;
                              PanelDataD1       : TPanel;
                              PanelDataD1Chart  : TPanel;
                              PanelDataD2       : TPanel;
                              PanelDataD2Chart  : TPanel;
                              PanelDataD3       : TPanel;
                              PanelDataD3Chart  : TPanel;
                              PanelDataD4       : TPanel;
                              PanelDataD4Chart  : TPanel;
                              MaximazeD1Chart   : boolean;
                              MaximazeD2Chart   : boolean;
                              MaximazeD3Chart   : boolean;
                              MaximazeD4Chart   : boolean);
    procedure OnShowDosEdit(Sender: TObject);

    procedure SetTestSource(const Value: boolean);
    procedure SetTestSourceTimeIncrease(const Value: boolean);
    procedure SetTestWriteModbusLog(const Value: boolean);
    procedure SetTestSourceTime(const Value: integer);
    procedure SetTestSourceTimeIncreaseCycle(const Value: integer);
    procedure SetTestSourceKIncrease(const Value: double);
    procedure SetTestSourceDosimeterName(const Value: String);

    procedure SetMaximaizeD1Chart(const Value: boolean);
    procedure SetMaximaizeD2Chart(const Value: boolean);
    procedure SetMaximaizeD3Chart(const Value: boolean);
    procedure SetMaximaizeD4Chart(const Value: boolean);
    procedure DefaultChartSize;

    procedure SetPermitSelectedRowUser(const Value: integer);
    procedure SetPermitMask(const Value: int64);
    procedure RefreshPermit_Page;
    procedure RefreshPermit_CLB;
    procedure GetUserPermit(aUser: integer);
    procedure WritePermitToUser(aPermit: int64; aUser: String);
    procedure LoadColumnsGridMeas;
    procedure LoadColumnsGridDos;
    procedure ShowMeasGridColumns(Field: String; const Value: boolean);

    procedure ChangeDosNumber;
    procedure DropCalibrationParameters;

    procedure SetMeasColumnMeasID(const Value: boolean);
    procedure SetMeasColumnMeasDateTime(const Value: boolean);
    procedure SetMeasColumnKSI(const Value: boolean);
    procedure SetMeasColumnDose(const Value: boolean);
    procedure SetMeasColumnHp10g(const Value: boolean);
    procedure SetMeasColumnHp10n(const Value: boolean);
    procedure SetMeasColumnHp007(const Value: boolean);
    procedure SetMeasColumnHp3(const Value: boolean);
    procedure SetMeasColumnHStar(const Value: boolean);
    procedure SetMeasColumnH007(const Value: boolean);
    procedure SetMeasColumnD(const Value: boolean);
    procedure SetMeasColumnH007_Err(const Value: boolean);
    procedure SetMeasColumnHp007_Err(const Value: boolean);
    procedure SetMeasColumnHp10g_Err(const Value: boolean);
    procedure SetMeasColumnHp10n_Err(const Value: boolean);
    procedure SetMeasColumnHp3_Err(const Value: boolean);
    procedure SetMeasColumnHStar_Err(const Value: boolean);
    procedure SetMeasColumnD_Err(const Value: boolean);
    procedure SetMeasColumnMeasValidity(const Value: boolean);
    procedure SetMeasColumnDosType(const Value: boolean);
    procedure SetMeasColumnDosReg(const Value: boolean);
    procedure SetMeasColumnDosVer(const Value: boolean);
    procedure SetMeasColumnDosStatus(const Value: boolean);
    procedure SetMeasColumnOrganization(const Value: boolean);
    procedure SetMeasColumnDepartment(const Value: boolean);
    procedure SetMeasColumnPartID(const Value: boolean);
    procedure SetMeasColumnMeasComment(const Value: boolean);
    procedure SetMeasColumnPersNumber(const Value: boolean);
    procedure SetMeasColumnFIO(const Value: boolean);
    procedure SetMeasColumnTLDUser(const Value: boolean);
    procedure SetMeasColumnLastMeasComment(const Value: boolean);
    procedure SetMeasColumnLastMeasTime(const Value: boolean);
    procedure SetMeasColumnTldID(const Value: boolean);

    procedure SetProcessColumnMeasID(const Value: boolean);
    procedure SetProcessColumnMeasDateTime(const Value: boolean);
    procedure SetProcessColumnKSI(const Value: boolean);
    procedure SetProcessColumnDose(const Value: boolean);
    procedure SetProcessColumnHp10g(const Value: boolean);
    procedure SetProcessColumnHp10n(const Value: boolean);
    procedure SetProcessColumnHp007(const Value: boolean);
    procedure SetProcessColumnHp3(const Value: boolean);
    procedure SetProcessColumnHStar(const Value: boolean);
    procedure SetProcessColumnH007(const Value: boolean);
    procedure SetProcessColumnD(const Value: boolean);
    procedure SetProcessColumnH007_Err(const Value: boolean);
    procedure SetProcessColumnHp007_Err(const Value: boolean);
    procedure SetProcessColumnHp10g_Err(const Value: boolean);
    procedure SetProcessColumnHp10n_Err(const Value: boolean);
    procedure SetProcessColumnHp3_Err(const Value: boolean);
    procedure SetProcessColumnHStar_Err(const Value: boolean);
    procedure SetProcessColumnD_Err(const Value: boolean);
    procedure SetProcessColumnMeasValidity(const Value: boolean);
    procedure SetProcessColumnDosType(const Value: boolean);
    procedure SetProcessColumnDosReg(const Value: boolean);
    procedure SetProcessColumnDosVer(const Value: boolean);
    procedure SetProcessColumnDosStatus(const Value: boolean);
    procedure SetProcessColumnOrganization(const Value: boolean);
    procedure SetProcessColumnDepartment(const Value: boolean);
    procedure SetProcessColumnPartID(const Value: boolean);
    procedure SetProcessColumnMeasComment(const Value: boolean);
    procedure SetProcessColumnPersNumber(const Value: boolean);
    procedure SetProcessColumnFIO(const Value: boolean);
    procedure SetProcessColumnTLDUser(const Value: boolean);
    procedure SetProcessColumnLastMeasComment(const Value: boolean);
    procedure SetProcessColumnLastMeasTime(const Value: boolean);
    procedure SetProcessColumnTldID(const Value: boolean);

    procedure SetCalibrColumnMeasID(const Value: boolean);
    procedure SetCalibrColumnMeasDateTime(const Value: boolean);
    procedure SetCalibrColumnKSI(const Value: boolean);
    procedure SetCalibrColumnDose(const Value: boolean);
    procedure SetCalibrColumnK1(const Value: boolean);
    procedure SetCalibrColumnK2(const Value: boolean);
    procedure SetCalibrColumnK3(const Value: boolean);
    procedure SetCalibrColumnK4(const Value: boolean);
    procedure SetCalibrColumnK5(const Value: boolean);
    procedure SetCalibrColumnKgn(const Value: boolean);
    procedure SetCalibrColumnHp10g(const Value: boolean);
    procedure SetCalibrColumnHp10n(const Value: boolean);
    procedure SetCalibrColumnHp007(const Value: boolean);
    procedure SetCalibrColumnHp3(const Value: boolean);
    procedure SetCalibrColumnHStar(const Value: boolean);
    procedure SetCalibrColumnH007(const Value: boolean);
    procedure SetCalibrColumnD(const Value: boolean);
    procedure SetCalibrColumnH007_Err(const Value: boolean);
    procedure SetCalibrColumnHp007_Err(const Value: boolean);
    procedure SetCalibrColumnHp10g_Err(const Value: boolean);
    procedure SetCalibrColumnHp10n_Err(const Value: boolean);
    procedure SetCalibrColumnHp3_Err(const Value: boolean);
    procedure SetCalibrColumnHStar_Err(const Value: boolean);
    procedure SetCalibrColumnD_Err(const Value: boolean);
    procedure SetCalibrColumnMeasValidity(const Value: boolean);
    procedure SetCalibrColumnDosType(const Value: boolean);
    procedure SetCalibrColumnDosReg(const Value: boolean);
    procedure SetCalibrColumnDosVer(const Value: boolean);
    procedure SetCalibrColumnDosStatus(const Value: boolean);
    procedure SetCalibrColumnOrganization(const Value: boolean);
    procedure SetCalibrColumnDepartment(const Value: boolean);
    procedure SetCalibrColumnPartID(const Value: boolean);
    procedure SetCalibrColumnMeasComment(const Value: boolean);
    procedure SetCalibrColumnPersNumber(const Value: boolean);
    procedure SetCalibrColumnFIO(const Value: boolean);
    procedure SetCalibrColumnTLDUser(const Value: boolean);
    procedure SetCalibrColumnLastMeasComment(const Value: boolean);
    procedure SetCalibrColumnTldID(const Value: boolean);

    procedure SetDosColumnDosType(const Value: boolean);
    procedure SetDosColumnDosState(const Value: boolean);
    procedure SetDosColumnk1(const Value: boolean);
    procedure SetDosColumnk2(const Value: boolean);
    procedure SetDosColumnk3(const Value: boolean);
    procedure SetDosColumnk4(const Value: boolean);
    procedure SetDosColumnk5(const Value: boolean);
    procedure SetDosColumnkgn(const Value: boolean);
    procedure SetDosColumnPartID(const Value: boolean);
    procedure SetDosColumnRegTime(const Value: boolean);
    procedure SetDosColumnVerTime(const Value: boolean);
    procedure SetDosColumnOrg(const Value: boolean);
    procedure SetDosColumnDep(const Value: boolean);
    procedure SetDosColumnLastMeasTime(const Value: boolean);
    procedure SetDosColumnLastMeasResult(const Value: boolean);
    procedure SetDosColumnLastMeasCommen(const Value: boolean);
    procedure SetDosColumnTldID(const Value: boolean);

    procedure SetCalibrationPressed(const Value: boolean);
    procedure EditCalibrK(SeriaAvg: TLineSeries; SeriaValue: TLineSeries; Edit: TEdit);

    procedure SetUserWarningComment(const Value: boolean);

    procedure ExportToCSV(DBGrid: TDBGridEh; UseDetDose: boolean);

    {$IFDEF MSWINDOWS}
    procedure WMGotoForeground(var Msg:TMessage);message WM_GOTOFOREGROUND;
    {$ELSE}
    {$ENDIF}
    procedure SetShowOriginalKTV(const Value: boolean);
    procedure SetShowGladeKTV(const Value: boolean);   // процедура для отслеживания повторного запуска ПО
    procedure SetUseControlComment(const Value: boolean);
    procedure SetControlComment(const Value: String);

    procedure CheckVisibleKTV;
    procedure CheckValidTestDosName;
    procedure SetAutoReset(const Value: boolean);
    procedure SetDosCntAutoCreatePart(const Value: integer);
    procedure SetSettingsSkipDetector(const Value: integer);
    procedure ShowDetectorComment(DetPos: integer);
    procedure EscDosPageEdit(Key: Word);
    procedure EscMeasPageEdit(Key: Word);
    procedure EscBDCommentEdit(Key: Word);

    procedure SaveGridsParametersMeas;
    procedure SaveGridsParametersProcess;
    procedure SaveGridsParametersDos;
    procedure SaveGridsParametersCalibr;

    procedure RestoreGridParametersMeas;
    procedure RestoreGridParametersProcess;
    procedure RestoreGridParametersDos;
    procedure RestoreGridParametersCalibr;

    procedure SetSaveDialogDBFilter;
    { Private declarations }
  public
    Dosimeter         : TDosimeter;
    TLDCommand        : TTLD_Auto;
    TLD_CommandSeries : TTLD_CommandSeries;

    FStart            : boolean;  //
    FirstStart        : boolean;
    FOnlyMeasPage     : boolean;

    CMDParUserName    : String;   // параметры командной строки
    CMDParPass        : String;   // параметры командной строки
    UseUserNameCMDPar : boolean;  // флаг отслеживающий запуск программы с параметрами: /user:Operator /password
    CMDDeveloperMode  : boolean;  // флаг для доступа в режим разработчика

    SQLMeasureQuery   : String;

    FilterMeasDosNumber     : String;
    FilterDosDosNumber      : String;
    FilterProcessDosNumber  : String;
    FilterCalibrDosNumber   : String;

    Splash                  : TSplash;

    Peltier_TargetTempFromIni: Single; // Целевая температура элемента Пельтье для охлаждения ФЭУ (здесь как буфер из INI-файла)
    Old_AirHeat_FromIni     : Boolean; // Целевая температура элемента Пельтье для охлаждения ФЭУ (здесь как буфер из INI-файла)

    function CalcProfile(time_preheating, temp_preheating, time_measurment, temp_measurment, time_burn, temp_burn: integer; speed: double): TTempProfile;
    function GetDetCnt(dosType: String): word;
    function GetFilterMeasDosName: String;
    function GetFilterDosDosName: String;
    function GetFilterProcessDosName: String;
    function GetFilterDosType(ComboBox: TComboBox): String;
    function GetFilterDosOrganization(ComboBox: TComboBox): String;
    function GetFilterDosDepartment(ComboBox: TComboBox): String;
    function GetFilterDosStatus(ComboBox: TComboBox): String;
    function GetFilterDosPartID(ComboBox: TComboBox): String;
    function GetFilterDosValidity(ComboBox: TComboBox): String;
    function GetFilterMeasComment(ComboBox: TComboBox): String;
    function GetFilterDosTime(DateTimeFrom: TDateTimePicker;DateTimeTo: TDateTimePicker): String;
//    function GetFilterMeasTime(DateTime: TJvDatePickerEdit): String;
    function GetFilterMeasTime(DateTime: TDateTimePicker): String;
    function GetFilterMeasToDel(Value: boolean): String;
    function GetFilterShowAllDevices(Value: boolean): String;
    function GetFilterSQL: String;
    function GetFilterDeviceID(ComboBox: TComboBox): String;
    function IsHidePanels: boolean;

    function GetDetStateAfterCalc(Value: TOutEnum): TDetectorState;
    function IsValidDBVersion: boolean;

    function IsLastMeasInDosimeter: boolean;

    procedure OnCommandLog(Time, Msg, Inf: String; MsgType, MsgPriority: integer);   // отображение обмена Modbus-пакетов
    procedure OnReceiveModBusExchange(Log: String);                    // отображение обмена Modbus-пакетов

    procedure OpenCOMPort;          // процедура открытия COM-порта
    procedure CloseCOMPort;         // закрыть COM-порт
    procedure ReinitializeCOMPort;  // переинициализировать COM-порт
    procedure StartMeasure;         // процедура запуска измерения
    procedure StartTesting;         // процедура запуска тестирования
    procedure BackMeasure;
    procedure CheckDBConnection;        // проверка подключения к БД
    procedure Check_ASIDK_DBConnection; // проверка подключения к БД АСИДК
    procedure ResetDosimeterData;         // процедура "сброса/очистки" объекта дозиметр

    procedure ChangeComboBox(ComboBox: TComboBox; Btn: TSpeedButton; BtnVisible : boolean);
    procedure CheckComboBox(ComboBox: TComboBox; Btn: TSpeedButton; BtnVisible : boolean);
    procedure ChangeEdit(Edit: TEdit; Btn: TSpeedButton; BtnVisible : boolean);
    procedure CheckEdit(Edit: TEdit; Btn: TSpeedButton; BtnVisible : boolean);

    procedure ChangeDosDoseEdit(Edit: TEdit; Validity: TDosimeterValidity; aText: String);
    procedure ChangeDosValidityEdit(Edit: TEdit; Validity: TDosimeterValidity);
    procedure ChangeDosStatusEdit(Edit: TEdit; Status: TDosimeterStatus);
    procedure ChangeDataLabel(Lbl: TLabel; DateTime: TDateTime);
//    procedure ChangeStringLabel(Lbl: TLabel; Text: String);
    procedure ChangeDataEdit(Edit: TEdit; DateTime: TDateTime);
    procedure ChangeStringEdit(Edit: TEdit; aText: String; aColor: TColor);

    procedure LoadComboBoxValue(ComboBox: TComboBox; Value: String; Btn: TSpeedButton);
    procedure ChangeDatePicker(DatePicker: TDateTimePicker; Btn: TSpeedButton; BtnVisible : boolean);
    procedure ChangeDateMeasPicker(DatePicker: TDateTimePicker);
    procedure CheckDatePicker(DatePicker: TDateTimePicker; Btn: TSpeedButton; BtnVisible : boolean);
    procedure LoadFilters;
    procedure LoadFiltersAll;
    procedure CheckFilters;
    procedure CheckFiltersAll;
    procedure UpdateBtnFilters;

    procedure UpdateDataDosFilter(Filter: String);               // обноволение таблицы дозиметров по фильтру
    procedure UpdateGridMeasFilter(Filter: String);              // обноволение таблицы измерений по фильтру
    procedure UpdateGridProcessFilter(Filter: String);           // обноволение таблицы обработки измерений по фильтру
    procedure UpdateGridCalibrationFilter(Filter: String);

    procedure ReadTLDSettings;

    procedure GridDropAll(Value: TDbGridEh);
    procedure GridSelectAll(Value: TDbGridEh);
    procedure GridBeforePopupMenuShow(Value: TDbGridEh);

    procedure ShowDetectorData(Seria: TLineSeries; Data: String); overload;
    procedure ShowDetectorData(Seria: TLineSeries; Data: string; aK1Profile, aK2Profile: double); overload;
    procedure ShowDetectorData(Seria: TAreaSeries; Data: String); overload;
//    procedure ShowDetectorData(Tool: TSeriesRegionTool; LeftBorder, RightBorder: double; Active: boolean); overload;
    procedure ShowDetectorDataGlade(SeriaImpuls,SeriaGalde: TLineSeries);

    procedure DSeriaAutoSize(Chart: TChart; Seria: TLineSeries);

    procedure CheckDosInGrid(DosNumb: String);
    procedure UpdateMemoDosInf(Filter: String);
    procedure SetDetStateEdit(EditDState: TEdit; DState: TDetectorState);
    procedure SetDetEdit(EditD: TEdit; Value: String; Err: String; DState: TDetectorState); overload;
    procedure SetDetEdit(EditD: TEdit; Value: String; DState: TDetectorState); overload;
    procedure SetDetComment(LabelComment: TLabel; DComment: String);
    procedure EnabledSpeedBtns(aBtnStart, aBtnStop, aBtnPause: boolean);             // состояния кнопока (вкл/выкл) в процессе работы программы
    procedure SelectColorPanelFilter(aColor: TColor);
    procedure CreateDosimeterData;  // добавление новой (чистой) записи в таблицу результатов измерений (при старте измерений после считывания КСИ)
    procedure OnTLDError(aOnTLDError: boolean);                  // состояние ТЛД
    procedure OnChangeConnectionState(anOldConnectionState, aNewConnectionState: TConnectedState);    // изменение состояния связи
    procedure OnChangeTLDMode(aTLD_Mode: TTLD_Mode);
    procedure OnTLDDetsLoad(aTLDDetsLoad: boolean);              // загрузка детекторов
    procedure OnTLDDetsMeas(aTLDDetsMeas: boolean);              // измерение детекторов
    procedure OnTLDStoveCooling(aTLDStoveCooling: boolean);      // измерение детекторов
    procedure OnChangeDetDose(Sender: TObject);
    procedure OnChangeDetLightSum(Sender: TObject);
    procedure OnChangeDetErr(Sender: TObject);
    procedure OnChangeDetState(Sender: TObject);
    procedure OnChangeDetType(Sender: TObject);
    procedure OnChangeDetComment(Sender: TObject);
    procedure OnChangeDetTypeComment(Sender: TObject);
    procedure OnShowDetData(Sender: TObject);
    procedure OnDBConnection(Connection: boolean);
    procedure OnChangeDosimeterNumber(Sender: TObject);
    procedure OnChangeDosimeterPostfix(Sender: TObject);
    procedure OnChangeDosimeterFullNumber(Sender: TObject);
    procedure OnChangeDosimeterDose(Sender: TObject);
    procedure OnChangeDosimeterDoseType(Sender: TObject);
    procedure OnChangeDosimeterMeasValues(Sender: TObject);
    procedure OnChangeDosimeterErr(Sender: TObject);
    procedure OnChangeDosimeterMeasTime(Sender: TObject);
    procedure OnChangeDosimeterVerTime(Sender: TObject);
    procedure OnChangeDosimeterRegTime(Sender: TObject);
    procedure OnChangeDosimeterStatus(Sender: TObject);
    procedure OnChangeDosimeterValidity(Sender: TObject);
    procedure OnChangeDosimeterKS(Sender: TObject);
    procedure OnChangeDosimeterK(Sender: TObject);
    procedure OnChangeDosimeterKFilter(Sender: TObject);
    procedure OnChangeDosimeterKDevice(Sender: TObject);
    procedure OnChangeDosimeterFormula(Sender: TObject);
    procedure OnChangeDosimeterFormulaID(Sender: TObject);
    procedure OnChangeDosimeterPersNumber(Sender: TObject);
    procedure OnChangeDosimeterOrganization(Sender: TObject);
    procedure OnChangeDosimeterDepartment(Sender: TObject);
    procedure OnChangeDosimeterPart(Sender: TObject);
    procedure OnChangeDosimeterFIO(Sender: TObject);
    procedure OnChangeDosimeterMeasComment(Sender: TObject);
    procedure OnChangeLastMeasComment(Sender: TObject);
    procedure OnChangeLastMeasResult(Sender: TObject);
    procedure OnChangeLastMeasTime(Sender: TObject);
    procedure OnShowDosimeterTempProfileWrite(Sender: TObject);


    procedure UpdateDosimeterResStatusAndMeasTime;
    procedure UpdateDosimeterResStatus;
    procedure SaveMeasComment;
    procedure SaveDosimeterData;
    procedure SetDBGridData;
    procedure UpdateDosimeterIDKParam(EditFio,EditPersNumber,EditOrg,EditDep: TEdit);
    procedure UpdateMeasComment(EditComment: TEdit; Comment: String);
    procedure UpdateDosimeterAdditionalParameters;
    procedure UpdateDosimeterLastMeas;
    procedure UpdateDetectorComment(MeasurmentID    : integer;
                                    DetPos          : integer;
                                    DetComment      : String);
    procedure InsertDetectorStateAndComment(MeasurmentID    : integer;
                                            DetectorType    : String;
                                            DetectorTypeID  : integer;
                                            DetPos          : integer;
                                            MeasurmentTime  : String;
                                            DetState        : TDetectorState;
                                            DetComment      : String
                                            ); // запись в БД статуса и комментария (используется при пропуске детекторов)

    procedure InsertDetectorKtvTmp(DetPos: integer); // запись в БД результатов измерений детекторов

    procedure UpdateDetectorMeasData(DetPos: integer); // перезапись результатов измерений детекторов

    procedure UpdateDetectorState(MeasurmentID    : integer;
                                  DetPos          : integer;
                                  DetState        : TDetectorState
                                  ); // перезапись состояний детекторов

    procedure SaveCurrentDetectorsData;     // сохранение текущих измерений по детекторам на момент остановки

    procedure LoadDetData(ADOQuery: TSQLQuery; aDosimeter: TDosimeter; MeasID: String);
    procedure LoadDosWithMeasData(ADOQuery: TSQLQuery; aDosimeter: TDosimeter; MeasID: String);
    procedure LoadDosData(ADOQuery: TSQLQuery; aDosimeter: TDosimeter);
    procedure LoadDosPartCB(ADOQuery: TSQLQuery; CBox: TComboBox);

    procedure CalcDetectorDose;
    procedure GetDosData;
    procedure GetMeasData;
    procedure GetCalibrData;

    procedure UpdateAllGridPages;
    procedure UpdateGridPageSoft;
    procedure UpdateGridPageStart;
    procedure UpdateGridMeasAndProcessPages;
    procedure UpdateGridMeasPage;
    procedure UpdateGridProcessPage;
    procedure UpdateGridCalibrPage;
    procedure UpdateGridDosPage;

    procedure RecalcGroupDose;
    procedure RecalcGroupDosimeterDose;
    procedure RecalcDosimeterDose;
    procedure RecalcDetectorsDose;
    procedure RecalcCurrentDosimeterDose(DosID,MeasID: String);
    procedure UpdateDetectorGausFon(DetPos: integer);
    procedure MarkToDelMeasurement;
    procedure DecommissionDos;
    procedure ExcludeDosimeterFromPart;
    procedure SaveAdditionalParameters;
    procedure SetInterfaceByPermits;

    procedure CheckVisibleGridFields;
    procedure CheckDBGridRowCount(DBGrid: TDBGridEh);

    procedure SetUserWarning(SetWarning: boolean);
    procedure RefreshDBList;
    function IsGroupDosOperations: boolean;
    function RestoreDBFromBackup(DBName: String): integer;

    procedure ProgressBarDBStart(aProgressBar: TProgressBar; aText: String);
    procedure ProgressBarFinish(aProgressBar: TProgressBar);
    procedure ProgressBarErr(aProgressBar: TProgressBar);
    procedure ProgressBarHide(aProgressBar: TProgressBar);

    procedure HideDetectorsPanel(DetCnt: word);
    procedure OpenCalibrForm;
    procedure SQLScriptChange(aVisible: boolean);

    procedure CheckDBCommentEdit;

    procedure OpenDozaReportBuilder(ReportType: String; DBGrid: TDBGridEh; orpType: TOpenReportType; orpSource: TOpenReportSource);


    procedure StartCalibration;
    procedure SetFooterCalcKDosGrid(Field: String; K_avg: double);
    procedure LoadCalibrK(K1,K2,K3,K4,K5,Kgn: double);

    procedure AcceptKDos;
    procedure UpdateK;

    procedure GetTempProfileToUI(aCarretePosition: TCarretePosition; aComment: string);

    function IsStart: boolean;
    function IsCalibrKValid(Edit: TEdit): boolean;
    function IsCalibrKEditsValid: boolean;
    function GetDosMeasWithOldK(DosList: TStringList): TStringList;
    function GetDosMeasWithOldKInPart(PartID: integer; CalibrDate: TDate): TStringList;
    function CheckValidMeasToCalibr(DBGrid: TDbGridEh): boolean;
    function IsValidCalibrationList: boolean;
    function IsValidCalibrMeas(MeasId: String): boolean;

    property StatusBarDB: String read FStatusBarDB write SetStatusBarDB;
    property StatusBarUser: String read FStatusBarUser write SetStatusBarUser;
    property IsDosEnter: boolean read CheckFilteredDosNumber;
    property TmpState: integer read FTmpState write SetTmpState;
    property HideD1: boolean read IsHideD1 write SetHideD1;
    property HideD2: boolean read IsHideD2 write SetHideD2;
    property HideD3: boolean read IsHideD3 write SetHideD3;
    property HideD4: boolean read IsHideD4 write SetHideD4;
    property HidePanels: boolean read IsHidePanels write SetHidePanels;
    property ShowDelMeas: boolean read FShowDelMeas write SetShowDelMeas;
    property DosShowFromAllDevices: boolean read FDosShowFromAllDevices write SetDosShowFromAllDevices;
    property ShowOriginalKTV: boolean read FShowOriginalKTV write SetShowOriginalKTV;
    property ShowGladeKTV: boolean read FShowGladeKTV write SetShowGladeKTV;
    property UseControlComment: boolean read FUseControlComment write SetUseControlComment;
    property ControlComment: String read FControlComment write SetControlComment;
    property AutoReset: boolean read FAutoReset write SetAutoReset;
    property DosCntAutoCreatePart: integer read FDosCntAutoCreatePart write SetDosCntAutoCreatePart;
    property SettingsSkipDetector: integer read FSettingsSkipDetector write SetSettingsSkipDetector;

    property TempDeviation: integer read FTempDeviation write FTempDeviation;

    property OpenFilterDosPanel         : boolean read FOpenFilterDosPanel write SetOpenFilterDosPanel;
    property OpenFilterProcessPanel     : boolean read FOpenFilterProcessPanel write SetOpenFilterProcessPanel;
    property OpenFilterCalibrPanel      : boolean read FOpenFilterCalibrPanel write SetOpenFilterCalibrPanel;
    property CheckSQLScript             : boolean read IsUseSQLScript write SetUseSQLScript;

    property Filter : String read FFilter write SetFilter;

    property TestSourceUse: boolean read FTestSourceUse write SetTestSource;
    property TestSourceTimeIncrease: boolean read FTestSourceTimeIncrease write SetTestSourceTimeIncrease;
    property TestWriteModbusLog: boolean read FTestWriteModbusLog write SetTestWriteModbusLog;
    property TestSourceTime: integer read FTestSourceTime write SetTestSourceTime;
    property TestSourceTimeIncreaseCycle: integer read FTestSourceTimeIncreaseCycle write SetTestSourceTimeIncreaseCycle;
    property TestSourceKIncrease: double read FTestSourceKIncrease write SetTestSourceKIncrease;
    property TestSourceDosimeterName: String read FTestSourceDosimeterName write SetTestSourceDosimeterName;

    property SoftwareVer: integer read FSoftwareVer write FSoftwareVer;
    property DeviceID: integer read FDeviceID write SetDeviceID;
    property ConstructiveVersion: integer read FConstructiveVersion write SetConstructiveVersion;
    property KSLevel: integer read FKSLevel write SetKSLevel;
    property KSDelta: integer read FKSDelta write SetKSDelta;
    property KFilter: double read FKFilter write SetKFilter;
    property KDevice: double read FKDevice write SetKDevice;
    property UseKFilter: boolean read FUseKFilter write SetUseKFilter;

    property IDForQuery: String read FIDForQuery write SetIDForQuery;
    property IDMeasForQuery: String read FIDMeasForQuery write SetIDMeasForQuery;
    property DosTypeForQuery: String read FDosTypeForQuery write SetDosTypeForQuery;

    property IsCorrectValForQuery[MeasID: String]: boolean read GetValForQuery;
    property Start: boolean read IsStart write SetStart;
    property Information: boolean read FInformation write SetInformation;
    //property Queue: boolean read FQueue write SetQueue;
    property OnlyMeasPage: boolean read FOnlyMeasPage write SetOnlyMeasPage;

    property MaximaizeD1Chart: boolean read FMaximazeD1Chart write SetMaximaizeD1Chart;
    property MaximaizeD2Chart: boolean read FMaximazeD2Chart write SetMaximaizeD2Chart;
    property MaximaizeD3Chart: boolean read FMaximazeD3Chart write SetMaximaizeD3Chart;
    property MaximaizeD4Chart: boolean read FMaximazeD4Chart write SetMaximaizeD4Chart;

    property PermitSelectedRowUser: integer read FPermitSelectedRowUser write SetPermitSelectedRowUser;
    property PermitMask: int64 read FPermitMask write SetPermitMask;

    property MeasColumnMeasID: boolean read FMeasColumnMeasID write SetMeasColumnMeasID;
    property MeasColumnMeasDateTime: boolean read FMeasColumnMeasDateTime write SetMeasColumnMeasDateTime;
    property MeasColumnKSI: boolean read FMeasColumnKSI write SetMeasColumnKSI;
    property MeasColumnDose: boolean read FMeasColumnDose write SetMeasColumnDose;
    property MeasColumnHp10g: boolean read FMeasColumnHp10g write SetMeasColumnHp10g;
    property MeasColumnHp10n: boolean read FMeasColumnHp10n write SetMeasColumnHp10n;
    property MeasColumnHp007: boolean read FMeasColumnHp007 write SetMeasColumnHp007;
    property MeasColumnHp3: boolean read FMeasColumnHp3 write SetMeasColumnHp3;
    property MeasColumnHStar: boolean read FMeasColumnHStar write SetMeasColumnHStar;
    property MeasColumnH007: boolean read FMeasColumnH007 write SetMeasColumnH007;
    property MeasColumnD: boolean read FMeasColumnD write SetMeasColumnD;
    property MeasColumnHp10g_Err: boolean read FMeasColumnHp10g_Err write SetMeasColumnHp10g_Err;
    property MeasColumnHp10n_Err: boolean read FMeasColumnHp10n_Err write SetMeasColumnHp10n_Err;
    property MeasColumnHp007_Err: boolean read FMeasColumnHp007_Err write SetMeasColumnHp007_Err;
    property MeasColumnHp3_Err: boolean read FMeasColumnHp3_Err write SetMeasColumnHp3_Err;
    property MeasColumnHStar_Err: boolean read FMeasColumnHStar_Err write SetMeasColumnHStar_Err;
    property MeasColumnH007_Err: boolean read FMeasColumnH007_Err write SetMeasColumnH007_Err;
    property MeasColumnD_Err: boolean read FMeasColumnD_Err write SetMeasColumnD_Err;
    property MeasColumnMeasValidity: boolean read FMeasColumnMeasValidity write SetMeasColumnMeasValidity;
    property MeasColumnDosType: boolean read FMeasColumnDosType write SetMeasColumnDosType;
    property MeasColumnDosReg: boolean read FMeasColumnDosReg write SetMeasColumnDosReg;
    property MeasColumnDosVer: boolean read FMeasColumnDosVer write SetMeasColumnDosVer;
    property MeasColumnDosStatus: boolean read FMeasColumnDosStatus write SetMeasColumnDosStatus;
    property MeasColumnOrganization: boolean read FMeasColumnOrganization write SetMeasColumnOrganization;
    property MeasColumnDepartment: boolean read FMeasColumnDepartment write SetMeasColumnDepartment;
    property MeasColumnPartID: boolean read FMeasColumnPartID write SetMeasColumnPartID;
    property MeasColumnMeasComment: boolean read FMeasColumnMeasComment write SetMeasColumnMeasComment;
    property MeasColumnPersNumber: boolean read FMeasColumnPersNumber write SetMeasColumnPersNumber;
    property MeasColumnFIO: boolean read FMeasColumnFIO write SetMeasColumnFIO;
    property MeasColumnTLDUser: boolean read FMeasColumnTLDUser write SetMeasColumnTLDUser;
    property MeasColumnLastMeasComment: boolean read FMeasColumnLastMeasComment write SetMeasColumnLastMeasComment;
    property MeasColumnLastMeasTime: boolean read FMeasColumnLastMeasTime write SetMeasColumnLastMeasTime;
    property MeasColumnTldID: boolean read FMeasColumnTldID write SetMeasColumnTldID;

    property ProcessColumnMeasID: boolean read FProcessColumnMeasID write SetProcessColumnMeasID;
    property ProcessColumnMeasDateTime: boolean read FProcessColumnMeasDateTime write SetProcessColumnMeasDateTime;
    property ProcessColumnKSI: boolean read FProcessColumnKSI write SetProcessColumnKSI;
    property ProcessColumnDose: boolean read FProcessColumnDose write SetProcessColumnDose;
    property ProcessColumnHp10g: boolean read FProcessColumnHp10g write SetProcessColumnHp10g;
    property ProcessColumnHp10n: boolean read FProcessColumnHp10n write SetProcessColumnHp10n;
    property ProcessColumnHp007: boolean read FProcessColumnHp007 write SetProcessColumnHp007;
    property ProcessColumnHp3: boolean read FProcessColumnHp3 write SetProcessColumnHp3;
    property ProcessColumnHStar: boolean read FProcessColumnHStar write SetProcessColumnHStar;
    property ProcessColumnH007: boolean read FProcessColumnH007 write SetProcessColumnH007;
    property ProcessColumnD: boolean read FProcessColumnD write SetProcessColumnD;
    property ProcessColumnHp10g_Err: boolean read FProcessColumnHp10g_Err write SetProcessColumnHp10g_Err;
    property ProcessColumnHp10n_Err: boolean read FProcessColumnHp10n_Err write SetProcessColumnHp10n_Err;
    property ProcessColumnHp007_Err: boolean read FProcessColumnHp007_Err write SetProcessColumnHp007_Err;
    property ProcessColumnHp3_Err: boolean read FProcessColumnHp3_Err write SetProcessColumnHp3_Err;
    property ProcessColumnHStar_Err: boolean read FProcessColumnHStar_Err write SetProcessColumnHStar_Err;
    property ProcessColumnH007_Err: boolean read FProcessColumnH007_Err write SetProcessColumnH007_Err;
    property ProcessColumnD_Err: boolean read FProcessColumnD_Err write SetProcessColumnD_Err;
    property ProcessColumnMeasValidity: boolean read FProcessColumnMeasValidity write SetProcessColumnMeasValidity;
    property ProcessColumnDosType: boolean read FProcessColumnDosType write SetProcessColumnDosType;
    property ProcessColumnDosReg: boolean read FProcessColumnDosReg write SetProcessColumnDosReg;
    property ProcessColumnDosVer: boolean read FProcessColumnDosVer write SetProcessColumnDosVer;
    property ProcessColumnDosStatus: boolean read FProcessColumnDosStatus write SetProcessColumnDosStatus;
    property ProcessColumnOrganization: boolean read FProcessColumnOrganization write SetProcessColumnOrganization;
    property ProcessColumnDepartment: boolean read FProcessColumnDepartment write SetProcessColumnDepartment;
    property ProcessColumnPartID: boolean read FProcessColumnPartID write SetProcessColumnPartID;
    property ProcessColumnMeasComment: boolean read FProcessColumnMeasComment write SetProcessColumnMeasComment;
    property ProcessColumnPersNumber: boolean read FProcessColumnPersNumber write SetProcessColumnPersNumber;
    property ProcessColumnFIO: boolean read FProcessColumnFIO write SetProcessColumnFIO;
    property ProcessColumnTLDUser: boolean read FProcessColumnTLDUser write SetProcessColumnTLDUser;
    property ProcessColumnLastMeasComment: boolean read FProcessColumnLastMeasComment write SetProcessColumnLastMeasComment;
    property ProcessColumnLastMeasTime: boolean read FProcessColumnLastMeasTime write SetProcessColumnLastMeasTime;
    property ProcessColumnTldID: boolean read FProcessColumnTldID write SetProcessColumnTldID;

    property CalibrColumnMeasID: boolean read FCalibrColumnMeasID write SetCalibrColumnMeasID;
    property CalibrColumnMeasDateTime: boolean read FCalibrColumnMeasDateTime write SetCalibrColumnMeasDateTime;
    property CalibrColumnKSI: boolean read FCalibrColumnKSI write SetCalibrColumnKSI;
    property CalibrColumnDose: boolean read FCalibrColumnDose write SetCalibrColumnDose;

    property CalibrColumnK1: boolean read FCalibrColumnK1 write SetCalibrColumnK1;
    property CalibrColumnK2: boolean read FCalibrColumnK2 write SetCalibrColumnK2;
    property CalibrColumnK3: boolean read FCalibrColumnK3 write SetCalibrColumnK3;
    property CalibrColumnK4: boolean read FCalibrColumnK4 write SetCalibrColumnK4;
    property CalibrColumnK5: boolean read FCalibrColumnK5 write SetCalibrColumnK5;
    property CalibrColumnKgn: boolean read FCalibrColumnKgn write SetCalibrColumnKgn;

    property CalibrColumnHp10g: boolean read FCalibrColumnHp10g write SetCalibrColumnHp10g;
    property CalibrColumnHp10n: boolean read FCalibrColumnHp10n write SetCalibrColumnHp10n;
    property CalibrColumnHp007: boolean read FCalibrColumnHp007 write SetCalibrColumnHp007;
    property CalibrColumnHp3: boolean read FCalibrColumnHp3 write SetCalibrColumnHp3;
    property CalibrColumnHStar: boolean read FCalibrColumnHStar write SetCalibrColumnHStar;
    property CalibrColumnH007: boolean read FCalibrColumnH007 write SetCalibrColumnH007;
    property CalibrColumnD: boolean read FCalibrColumnD write SetCalibrColumnD;
    property CalibrColumnHp10g_Err: boolean read FCalibrColumnHp10g_Err write SetCalibrColumnHp10g_Err;
    property CalibrColumnHp10n_Err: boolean read FCalibrColumnHp10n_Err write SetCalibrColumnHp10n_Err;
    property CalibrColumnHp007_Err: boolean read FCalibrColumnHp007_Err write SetCalibrColumnHp007_Err;
    property CalibrColumnHp3_Err: boolean read FCalibrColumnHp3_Err write SetCalibrColumnHp3_Err;
    property CalibrColumnHStar_Err: boolean read FCalibrColumnHStar_Err write SetCalibrColumnHStar_Err;
    property CalibrColumnH007_Err: boolean read FCalibrColumnH007_Err write SetCalibrColumnH007_Err;
    property CalibrColumnD_Err: boolean read FCalibrColumnD_Err write SetCalibrColumnD_Err;
    property CalibrColumnMeasValidity: boolean read FCalibrColumnMeasValidity write SetCalibrColumnMeasValidity;
    property CalibrColumnDosType: boolean read FCalibrColumnDosType write SetCalibrColumnDosType;
    property CalibrColumnDosReg: boolean read FCalibrColumnDosReg write SetCalibrColumnDosReg;
    property CalibrColumnDosVer: boolean read FCalibrColumnDosVer write SetCalibrColumnDosVer;
    property CalibrColumnDosStatus: boolean read FCalibrColumnDosStatus write SetCalibrColumnDosStatus;
    property CalibrColumnOrganization: boolean read FCalibrColumnOrganization write SetCalibrColumnOrganization;
    property CalibrColumnDepartment: boolean read FCalibrColumnDepartment write SetCalibrColumnDepartment;
    property CalibrColumnPartID: boolean read FCalibrColumnPartID write SetCalibrColumnPartID;
    property CalibrColumnMeasComment: boolean read FCalibrColumnMeasComment write SetCalibrColumnMeasComment;
    property CalibrColumnPersNumber: boolean read FCalibrColumnPersNumber write SetCalibrColumnPersNumber;
    property CalibrColumnFIO: boolean read FCalibrColumnFIO write SetCalibrColumnFIO;
    property CalibrColumnTLDUser: boolean read FCalibrColumnTLDUser write SetCalibrColumnTLDUser;
    property CalibrColumnLastMeasComment: boolean read FCalibrColumnLastMeasComment write SetCalibrColumnLastMeasComment;
    property CalibrColumnTldID: boolean read FCalibrColumnTldID write SetCalibrColumnTldID;

    property DosColumnDosType: boolean read FDosColumnDosType write SetDosColumnDosType;
    property DosColumnDosState: boolean read FDosColumnDosState write SetDosColumnDosState;
    property DosColumnk1: boolean read FDosColumnk1 write SetDosColumnk1;
    property DosColumnk2: boolean read FDosColumnk2 write SetDosColumnk2;
    property DosColumnk3: boolean read FDosColumnk3 write SetDosColumnk3;
    property DosColumnk4: boolean read FDosColumnk4 write SetDosColumnk4;
    property DosColumnk5: boolean read FDosColumnk5 write SetDosColumnk5;
    property DosColumnkgn: boolean read FDosColumnkgn write SetDosColumnkgn;
    property DosColumnPartID: boolean read FDosColumnPartID write SetDosColumnPartID;
    property DosColumnRegTime: boolean read FDosColumnRegTime write SetDosColumnRegTime;
    property DosColumnVerTime: boolean read FDosColumnVerTime write SetDosColumnVerTime;
    property DosColumnOrg: boolean read FDosColumnOrg write SetDosColumnOrg;
    property DosColumnDep: boolean read FDosColumnDep write SetDosColumnDep;
    property DosColumnLastMeasTime: boolean read FDosColumnLastMeasTime write SetDosColumnLastMeasTime;
    property DosColumnLastMeasResult: boolean read FDosColumnLastMeasResult write SetDosColumnLastMeasResult;
    property DosColumnLastMeasComment: boolean read FDosColumnLastMeasComment write SetDosColumnLastMeasCommen;
    property DosColumnTldID: boolean read FDosColumnTldID write SetDosColumnTldID;

    property CalibrationPressed: boolean read FCalibrationPressed write SetCalibrationPressed;

    property UserWarningComment: boolean read FUserWarningComment write SetUserWarningComment;

    property COMName: String read FCOMName write SetCOMName;

    {
    property COMName: String read FCOMName write SetCOMName;     // параметры COM-порта
    property BaudRate: integer read FBaudRate write SetBaudRate;
    property Parity: integer read FParity write SetParity;
    property StopBits: integer read FStopBits write SetStopBits;
    property ByteSize: integer read FByteSize write SetByteSize;
    }

    { Public declarations }
  end;

const
  cPanelDBWidthAdd  = 4;
  cGridFontSize     = 12;
  cGridDBFontSize   = 20;

var
  MainForm    : TMainForm;

  ProcessType : TProcessType;

  AppDir      : string;



implementation
uses
  uDataModule,
  EhLibMTE,
  uTimerMessages,
  SlavaTools,
  Process,
  uStartIrradiation,
  uStartGrading,
  uStartBurning,
  uPowerOff,
  RTTI;
{$R *.dfm}

function TMainForm.CalcProfile(time_preheating, temp_preheating, time_measurment, temp_measurment, time_burn, temp_burn: integer; speed: double): TTempProfile;
const
  cMaxSpeed           = 40;                      //  максимальная скорость нагрева
//  cMesurmentsSpeed    = 5;                     //  скорость нагрева при измерении детекторов
  cStartTemp          = 0;                       //  начальная температура печки
  cChannels           = 300;                     //  количество каналов
  cDeviation          = 10;                      //  допустимое отклонение при нагреве
  cTen                = 10;                      //  коэффициент для домножения (профиль выражен в десятых градуса)
//  сTimeAdd            = 10;                    //  добавка для перехода в десятые секунды, введена, чтобы в будущем уйти от десятых долей
var
  i                   : integer;
  allTime             : integer;                 //  время измерения
  channelLength       : double;                  //  длительность канала
  preheatingChannels  : integer;                 //  количество каналов на преднагрев
  measurmentsChannels : integer;                 //  количество каналов на измерение
  burningChannels     : integer;                 //  количество каналов на дожиг
  maxSpeedChannel     : double;                  //  максимальная скорость нагрева
  SpeedChannel        : double;                  //  задаваемая скорость нагрева
  Profile             : TTempProfile;            //  массив температурного профиля (с длительностью нагрева и отклонением)
  FloatProfile        : array [0..299] of double;
begin
  allTime:=0;
  channelLength:=0;
  preheatingChannels:=0;
  measurmentsChannels:=0;
  burningChannels:=0;
  maxSpeedChannel:=0;
  SpeedChannel:=0;

  FillChar(profile, SizeOf(result), 0);
  allTime:=time_preheating+time_measurment+time_burn;            // общее время измерения
  if allTime>0 then
  begin
    channelLength:=(allTime/cChannels);                          // считаем длительность канала

    preheatingChannels:=round((time_preheating)/channelLength);  // считаем количество каналов на преднагрев

    maxSpeedChannel:=((cMaxSpeed*channelLength)*FKTime);           // считаем максимальную скорость нагрева, градусы на канал

    temp_preheating:=temp_preheating*cTen;  // выражаем в десятых градуса температуру преднагрева
    temp_measurment:=temp_measurment*cTen;  // выражаем в десятых градуса температуру измерения
    temp_burn:=temp_burn*cTen;              // выражаем в десятых градуса температуру дожига

    FillChar(FloatProfile, SizeOf(FloatProfile), 0);
    FloatProfile[0]:=cStartTemp*cTen;                   // первый элемент массива - начальная температура

    for i := 1 to preheatingChannels do                 // считаем профиль преднагрева
    begin
      if (FloatProfile[i-1]+maxSpeedChannel) < temp_preheating then    // до заданной температуры преднагрева (temp_heating), греем с максимальной скоростью
        FloatProfile[i]:=FloatProfile[i-1]+maxSpeedChannel
      else                                                             // если нагрели до температуры преднагрева - пишем температуру преднагрева (temp_heating) в течении оставшегося времени преднагрева (полка_преднагрева)
        FloatProfile[i]:=temp_preheating;
    end;

    burningChannels:=round((time_burn)/channelLength);            //  считаем каналы на дожиг
    measurmentsChannels:=cChannels-burningChannels;               //  считаем каналы на измерение
    speedChannel:=((Speed*channelLength)*FKTime);                 //  считаем задаваемую скорость (speed) нагрева градусы на канал

    for i := preheatingChannels+1 to measurmentsChannels-1 do     // считаем профиль измерения
    begin
      if (FloatProfile[i-1]+speedChannel) < temp_measurment then  // до заданной температуры измерения (temp_measurment), греем с заданной скоростью
        FloatProfile[i]:=FloatProfile[i-1]+speedChannel
      else                                                        // если нагрели до температуры измерения - пишем температуру измерения (temp_measurment) в течении оставшегося времени измерения (полка_измерения)
        FloatProfile[i]:=temp_measurment;
    end;

    for i := measurmentsChannels to High(FloatProfile) do         // считаем профиль дожига
    begin
      if (FloatProfile[i-1]+maxSpeedChannel) < temp_burn then     // до заданной температуры дожига (temp_burn), греем с максимальной скоростью
        FloatProfile[i]:=FloatProfile[i-1]+maxSpeedChannel
      else                                                        // если нагрели до температуры дожига - пишем температуру дожигап (temp_burn) в течении оставшегося времени дожига (полка_дожига)
        FloatProfile[i]:=temp_burn;
    end;

    Profile[0]:=allTime*FKTime;             // первый байт профиля - время измерения
    Profile[1]:=cDeviation*cTen;            // второй байт профиля - отклонение при нагреве

    for i := 2 to High(Profile) do          // начиная с третьего байта записываем округленный до десятых градусов профиль
      Profile[i]:=Round(FloatProfile[i-2]);

  end;

  result := Profile;

end;

procedure TMainForm.CheckEdit(Edit: TEdit; Btn: TSpeedButton; BtnVisible: boolean);
begin
  if (BtnVisible) then
  begin
    Btn.Visible:=True;
  end
  else
  begin
    Btn.Visible:=False;
    if Edit.Text <> '' then
      Edit.Clear;
  end;
end;

procedure TMainForm.CBoxGroupByDosNumberClick(Sender: TObject);
//var
//  footerNode  : TGroupDataTreeNodeEh;
begin
//  DBGridEhCalcKDos.DataGrouping.Active:=CBoxGroupByDosNumber.Checked;
//  DBGridEhCalcKDos.DataGrouping.Footers[0].Visible:=CBoxGroupByDosNumber.Checked;

//  if CBoxGroupByDosNumber.Checked then
//    DBGridEhCalcKDos.FooterRowCount:=0
//  else
//    DBGridEhCalcKDos.FooterRowCount:=1;
//
//  footerNode:=DBGridEhCalcKDos.DataGrouping.GroupDataTree.Root;
//  footerNode.ResetFooters;
end;

procedure TMainForm.CheckBoxShowToDelClick(Sender: TObject);
begin
  SaveFilterBoolIni(cFilterProcessShowDelMeas,CheckBoxShowToDel.Checked);
  ShowDelMeas:=CheckBoxShowToDel.Checked;
end;

procedure TMainForm.CheckComboBox(ComboBox: TComboBox; Btn: TSpeedButton; BtnVisible: boolean);
begin
  if (BtnVisible) then
  begin
    Btn.Visible:=True;
  end
  else
  begin
    Btn.Visible:=False;
    if ComboBox.ItemIndex >= 0 then
      ComboBox.ItemIndex:=-1
    else if ComboBox.Text <> '' then
      ComboBox.Text:='';
  end;
end;

procedure TMainForm.CheckDatePicker(DatePicker: TDateTimePicker; Btn: TSpeedButton; BtnVisible: boolean);
begin
  if (BtnVisible) then
  begin
//    DatePicker.Format:='';
    Btn.Visible:=True;
  end
  else
  begin
//    DatePicker.Format:=#32;   // очищаем DateTimePicker
    Btn.Visible:=False;
  end;
end;

procedure TMainForm.ChangeComboBox(ComboBox: TComboBox; Btn: TSpeedButton; BtnVisible: boolean);
begin
  CheckComboBox(ComboBox,Btn,BtnVisible);
  LoadFilters;
  ReadFilterIni;
  UpdateBtnFilters;
  UpdateAllGridPages;
end;

procedure TMainForm.ChangeDateMeasPicker(DatePicker: TDateTimePicker);
begin
//  CheckDatePicker(DatePicker,Btn,BtnVisible);
//  SaveFilterValues;
//  LoadFilters;
//  LoadFilterValues;
//  ReadFilterIni;
//  UpdateBtnFilters;
  UpdateAllGridPages;
end;

procedure TMainForm.ChangeDatePicker(DatePicker: TDateTimePicker; Btn: TSpeedButton; BtnVisible: boolean);
begin
  CheckDatePicker(DatePicker,Btn,BtnVisible);
  LoadFilters;
  ReadFilterIni;
  UpdateBtnFilters;
  UpdateAllGridPages;
end;

procedure TMainForm.ChangeDosDoseEdit(Edit: TEdit; Validity: TDosimeterValidity; aText: String);
begin
  Edit.Text:=aText;

  if not Edit.Visible then Edit.Visible:=true;

  case Dosimeter.Validity of
    stDosNotMeasured:
    begin
      Edit.Color:=clSilver;
    end;
    stDosWaitLoad:
    begin
      Edit.Color:=clSilver;
    end;
    stDosWaitMeasD1:
    begin
      Edit.Color:=clSilver;
    end;
    stDosWaitMeasD2:
    begin
      Edit.Color:=clSilver;
    end;
    stDosWaitMeasD3:
    begin
      Edit.Color:=clSilver;
    end;
    stDosWaitMeasD4:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasInProgressD1:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasInProgressD2:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasInProgressD3:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasInProgressD4:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasFinishedD1:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasFinishedD2:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasFinishedD3:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasFinishedD4:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasErrorD1:
    begin
      Edit.Color:=clSkyBlue;
    end;
    stDosMeasErrorD2:
    begin
      Edit.Color:=clSkyBlue;
    end;
    stDosMeasErrorD3:
    begin
      Edit.Color:=clSkyBlue;
    end;
    stDosMeasErrorD4:
    begin
      Edit.Color:=clSkyBlue;
    end;
    stDosMeasStoppedD1:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasStoppedD2:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasStoppedD3:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasStoppedD4:
    begin
      Edit.Color:=clSilver;
    end;
    stDosMeasFinished:
    begin
      Edit.Color:=clBtnFace;
    end;
    stDosMeasWarning:
    begin
      Edit.Color:=clSkyBlue;
    end;
    stDosMeasError:
    begin
      Edit.Color:=clYellow;
    end;
    stDosMeasAccepted:
    begin
      Edit.Color:=clBtnFace;
    end;
    stDosMeasUserWarning:
    begin
      Edit.Color:=RGBToColor(255,204,255);
    end
    else
    begin
      Edit.Color:=clSilver;
    end;
  end;
end;

procedure TMainForm.ChangeDosValidityEdit(Edit: TEdit; Validity: TDosimeterValidity);
  procedure SetBtnWarning(Value: boolean);
  begin
    if Value then
    begin
      SpeedBtnMeasUserWarning.Down:=true;
      SpeedBtnMeasUserWarning.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Mark.bmp');
      SpeedBtnProcessUserWarning.Down:=true;
      SpeedBtnProcessUserWarning.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Mark.bmp');
    end
    else
    begin
      SpeedBtnMeasUserWarning.Down:=false;
      SpeedBtnMeasUserWarning.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Empty.bmp');
      SpeedBtnProcessUserWarning.Down:=false;
      SpeedBtnProcessUserWarning.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Empty.bmp');
    end;

//    case PageControlMain.ActivePage.PageIndex of
//      cPageMeasIndex:
//      begin
//        if Value then
//        begin
//          SpeedBtnMeasUserWarning.Down:=true;
//          SpeedBtnMeasUserWarning.Glyph.LoadFromFile('Images\Menu\Mark.bmp');
//        end
//        else
//        begin
//          SpeedBtnMeasUserWarning.Down:=false;
//          SpeedBtnMeasUserWarning.Glyph.LoadFromFile('Images\Menu\Empty.bmp');
//        end;
//      end;
//      cPageProcessIndex:
//      begin
//        if Value then
//        begin
//          SpeedBtnProcessUserWarning.Down:=true;
//          SpeedBtnProcessUserWarning.Glyph.LoadFromFile('Images\Menu\Mark.bmp');
//        end
//        else
//        begin
//          SpeedBtnProcessUserWarning.Down:=false;
//          SpeedBtnProcessUserWarning.Glyph.LoadFromFile('Images\Menu\Empty.bmp');
//        end;
//      end;
//    end;

  end;
begin
  case Validity of
    stDosNotMeasured:
    begin
      Edit.Text:=rsSmNotMeasured;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosWaitLoad:
    begin
      Edit.Text:=rsSmLoadingDetectors;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosWaitMeasD1:
    begin
      Edit.Text:=rsSmWaitingMeasD1;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosWaitMeasD2:
    begin
      Edit.Text:=rsSmWaitingMeasD2;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosWaitMeasD3:
    begin
      Edit.Text:=rsSmWaitingMeasD3;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosWaitMeasD4:
    begin
      Edit.Text:=rsSmWaitingMeasD4;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasInProgressD1:
    begin
      Edit.Text:=rsSmMeasD1;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasInProgressD2:
    begin
      Edit.Text:=rsSmMeasD2;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasInProgressD3:
    begin
      Edit.Text:=rsSmMeasD3;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasInProgressD4:
    begin
      Edit.Text:=rsSmMeasD4;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasFinishedD1:
    begin
      Edit.Text:=rsSmMeasD1Finished;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasFinishedD2:
    begin
      Edit.Text:=rsSmMeasD2Finished;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasFinishedD3:
    begin
      Edit.Text:=rsSmMeasD3Finished;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasFinishedD4:
    begin
      Edit.Text:=rsSmMeasD4Finished;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasErrorD1:
    begin
      Edit.Text:=rsSmErrorMeasD1;
      Edit.Color:=clSkyBlue;
      SetBtnWarning(false);
    end;
    stDosMeasErrorD2:
    begin
      Edit.Text:=rsSmErrorMeasD2;
      Edit.Color:=clSkyBlue;
      SetBtnWarning(false);
    end;
    stDosMeasErrorD3:
    begin
      Edit.Text:=rsSmErrorMeasD3;
      Edit.Color:=clSkyBlue;
      SetBtnWarning(false);
    end;
    stDosMeasErrorD4:
    begin
      Edit.Text:=rsSmErrorMeasD4;
      Edit.Color:=clSkyBlue;
      SetBtnWarning(false);
    end;
    stDosMeasStoppedD1:
    begin
      Edit.Text:=rsSmMeasDosStopped;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasStoppedD2:
    begin
      Edit.Text:=rsSmMeasDosStopped;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasStoppedD3:
    begin
      Edit.Text:=rsSmMeasDosStopped;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasStoppedD4:
    begin
      Edit.Text:=rsSmMeasDosStopped;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
    stDosMeasFinished:
    begin
      Edit.Text:=rsSmMeasFinished;
      Edit.Color:=clBtnFace;
      SetBtnWarning(false);
    end;
    stDosMeasWarning:
    begin
      Edit.Text:=rsSmWarning;
      Edit.Color:=clSkyBlue;
      SetBtnWarning(false);
    end;
    stDosMeasError:
    begin
      Edit.Text:=rsSmMeasError;
      Edit.Color:=clYellow;
      SetBtnWarning(false);
    end;
    stDosMeasAccepted:
    begin
      Edit.Text:=rsSmMeasAccepted;
      Edit.Color:=clBtnFace;
      SetBtnWarning(false);
    end;
    stDosMeasUserWarning:
    begin
      if Assigned(Dosimeter) then
      begin
        Edit.Text:=Dosimeter.LastMeasComment;
      end;
      Edit.Color:=RGBToColor(255,204,255);
      SetBtnWarning(true);
    end;
    else
    begin
      Edit.Text:=rsSmMeasError;
      Edit.Color:=clSilver;
      SetBtnWarning(false);
    end;
  end;
end;

procedure TMainForm.ChangeDosStatusEdit(Edit: TEdit; Status: TDosimeterStatus);
begin
  case GetDosStatus(Status) of
    cDosCalibrated:
    begin
      Edit.Text:=rsDosCalibrated;
      Edit.Color:=clBtnFace;
    end;
    cDosNotCalibrated:
    begin
      Edit.Text:=rsDosNotCalibrated;
      Edit.Color:=clSkyBlue;
    end;
    cDosDecommissioned:
    begin
      Edit.Text:=rsDosDecommissioned;
      Edit.Color:=clSilver;
    end
    else
    begin
      Edit.Text:='';
      Edit.Color:=clSilver;
    end;
  end;
end;

procedure TMainForm.ChangeDataEdit(Edit: TEdit; DateTime: TDateTime);
begin
  if DateTimeToStr(DateTime) = cZeroDate then
    Edit.Text:=cEmptyData
  else
    Edit.Text:=DateTimeToStr(DateTime);
end;

procedure TMainForm.ChangeDataLabel(Lbl: TLabel; DateTime: TDateTime);
begin
  if DateTimeToStr(DateTime) = cZeroDate then
    Lbl.Caption:=cEmptyData
  else
    Lbl.Caption:=DateTimeToStr(DateTime);
end;

procedure TMainForm.ChangeStringEdit(Edit: TEdit; aText: String; aColor: TColor);
begin
  Edit.Color:=aColor;

  if aText = '' then
  begin
    Edit.Text:=''//cEmptyData
  end
  else
    Edit.Text:=aText;
end;


//procedure TMainForm.ChangeFloatToStrEdit(Edit: TEdit; Text: String; Color: TColor);
//begin
//  Edit.Color:=Color;
//
//  if Text = '0' then
//  begin
//    Edit.Text:=cEmptyData
//  end
//  else
//    Edit.Text:=Text;
//end;

procedure TMainForm.ChangeEdit(Edit: TEdit; Btn: TSpeedButton; BtnVisible: boolean);
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      FilterMeasDosNumber:=Edit.Text;
    end;
    cPageDosIndex:
    begin
      FilterDosDosNumber:=Edit.Text;
    end;
    cPageProcessIndex:
    begin
      FilterProcessDosNumber:=Edit.Text;
    end;
  end;

  CheckEdit(Edit,Btn,BtnVisible);
  LoadFilters;
  ReadFilterIni;
  UpdateBtnFilters;
  UpdateAllGridPages;
end;

procedure TMainForm.ChangePassSpeedBtnClick(Sender: TObject);
begin
  UChangePassW.UserIndex:=PermitSelectedRowUser;
  UChangePassW.Login:=AW.Users[PermitSelectedRowUser].Login;
  UChangePassW.ShowModal;
end;

///////MEAS

procedure TMainForm.CBoxMeasOrgNameChange(Sender: TObject);
begin
//  SaveFilterTextIni(cFilterMeasOrganization,CBoxMeasOrgName.Text);
//  ChangeComboBox(TCombobox(Sender),SpBtnMeasDropOrgName,True);
end;

procedure TMainForm.CBoxMeasDepChange(Sender: TObject);
begin
//  SaveFilterTextIni(cFilterMeasDepartment,CBoxMeasDep.Text);
//  ChangeComboBox(TCombobox(Sender),SpBtnMeasDropDep,True);
end;

procedure TMainForm.CBoxMeasDosPartChange(Sender: TObject);
begin
//  SaveFilterTextIni(cFilterMeasDosPath,CBoxMeasDosPart.Text);
//  ChangeComboBox(TCombobox(Sender),SpBtnMeasDropDosPart,True);
end;

procedure TMainForm.CBoxMeasDosTypeChange(Sender: TObject);
begin
//  SaveFilterTextIni(cFilterMeasDosType,CBoxMeasDosType.Text);
//  ChangeComboBox(TCombobox(Sender),SpBtnMeasDropDosType,True);
end;

procedure TMainForm.CBoxMeasStatusChange(Sender: TObject);
begin
//  SaveFilterTextIni(cFilterMeasDosStatus,CBoxMeasStatus.Text);
//  ChangeComboBox(TCombobox(Sender),SpBtnMeasDropStatus,True);
end;

procedure TMainForm.CBoxMeasPersNumberChange(Sender: TObject);
begin
//  SaveFilterTextIni(cFilterMeasPersNumber,CBoxMeasPersNumber.Text);
//  ChangeComboBox(TCombobox(Sender),SpBtnMeasDropPersNumber,True);
end;

procedure TMainForm.CBoxMeasIDKChange(Sender: TObject);
begin
//  SaveFilterTextIni(cFilterMeasIDK,CBoxMeasIDK.Text);
//  ChangeComboBox(TCombobox(Sender),SpBtnMeasDropIDK,True);
end;

procedure TMainForm.CBoxMeasResultChange(Sender: TObject);
begin
//  SaveFilterTextIni(cFilterMeasResult,CBoxMeasResult.Text);
//  ChangeComboBox(TCombobox(Sender),SpBtnMeasDropResult,True);
end;

procedure TMainForm.CBoxMeasCommentChange(Sender: TObject);
begin
//  SaveFilterTextIni(cFilterMeasComment,CBoxMeasComment.Text);
//  ChangeComboBox(TCombobox(Sender),SpBtnMeasDropComment,True);
end;

procedure TMainForm.DateTimePickerMeasChange(Sender: TObject);
begin
//  SaveFilterDateIni(cFilterProcessTimeFrom,DateTimeToStr(DateTimePickerProcessFrom.DateTime));
//  ChangeDateMeasPicker(TDateTimePicker(Sender));
  UpdateAllGridPages;
//  ShowMessage('111');
end;

procedure TMainForm.DateTimePickerMeasFromChange(Sender: TObject);
begin
//  SaveFilterDateIni(cFilterMeasTimeFrom,DateTimeToStr(DateTimePickerMeasFrom.DateTime));
//  ChangeDatePicker(TDateTimePicker(Sender),SpBtnMeasDropDateFrom,True);
end;

procedure TMainForm.DateTimePickerMeasToChange(Sender: TObject);
begin
//  SaveFilterDateIni(cFilterMeasTimeTo,DateTimeToStr(DateTimePickerMeasTo.DateTime));
//  ChangeDatePicker(TDateTimePicker(Sender),SpBtnMeasDropDateTo,True);
end;

procedure TMainForm.CBoxDosOrgNameChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosOrganization,CBoxDosOrgName.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnDosDropOrgName,True);
end;

procedure TMainForm.CBDosDataDosStatusChange(Sender: TObject);
const
  cNotCalibrated = '-1';
begin
  if CBDosDataDosStatus.Items[CBDosDataDosStatus.ItemIndex]=rsDosNotCalibrated then
  begin
    if StrToIntRegion(EditK_1.Text)>0 then EditK_1.Text:=cNotCalibrated;
    if StrToIntRegion(EditK_2.Text)>0 then EditK_2.Text:=cNotCalibrated;
    if StrToIntRegion(EditK_3.Text)>0 then EditK_3.Text:=cNotCalibrated;
    if StrToIntRegion(EditK_4.Text)>0 then EditK_4.Text:=cNotCalibrated;
    if StrToIntRegion(EditK_5.Text)>0 then EditK_5.Text:=cNotCalibrated;
    if StrToIntRegion(EditK_gn.Text)>0 then EditK_gn.Text:=cNotCalibrated;
  end;
end;

procedure TMainForm.CBoxDosDepChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDepartment,CBoxDosDep.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnDosDropDep,True);
end;

procedure TMainForm.CBoxDosDeviceIDChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDeviceID,CBoxDosDeviceID.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnDosDropDevID,True);
end;

procedure TMainForm.CBoxDosDosPartChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDosPath,CBoxDosDosPart.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnDosDropDosPart,True);
end;

procedure TMainForm.CBoxDosDosTypeChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDosType,CBoxDosDosType.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnDosDropDosType,True);
end;

procedure TMainForm.CBoxDosStatusChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDosStatus,CBoxDosStatus.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnDosDropStatus,True);
end;

procedure TMainForm.CBoxExTestSourceDosimeterNameChange(Sender: TObject);
begin
  if CBoxDosimeterTest.Text<>'' then
  begin
    FTestSourceDosimeterName:=CBoxDosimeterTest.Text;
    CheckValidTestDosName;
  end;
end;

procedure TMainForm.CBoxExTestSourceDosimeterNameKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  cVK_Enter = $0D;          //  кнопка Enter
begin
  if (Key = cVK_Enter) then
  begin
    CheckValidTestDosName;
  end;
end;

procedure TMainForm.CBoxKeyPress(Sender: TObject; var Key: Char);
begin
  Key:=#0;
end;

procedure TMainForm.CBoxDosPersNumberChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosPersNumber,CBoxDosPersNumber.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnDosDropPersNumber,True);
end;

procedure TMainForm.CBoxDosIDKChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosIDK,CBoxDosIDK.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnDosDropIDK,True);
end;

procedure TMainForm.DataSetTextExporterEhDosListFinishExport(Sender: TObject);
begin
  MessageDlg(Format('%s',['Экспорт выполнен']),mtInformation,[mbOK],0);
end;

procedure TMainForm.DateTimePickerDosFromChange(Sender: TObject);
begin
  SaveFilterDateIni(cFilterDosTimeFrom,DateTimeToStr(DateTimePickerDosFrom.DateTime));
  ChangeDatePicker(TDateTimePicker(Sender),SpBtnDosDropDateFrom,True);
end;

procedure TMainForm.DateTimePickerDosToChange(Sender: TObject);
begin
  SaveFilterDateIni(cFilterDosTimeTo,DateTimeToStr(DateTimePickerDosTo.DateTime));
  ChangeDatePicker(TDateTimePicker(Sender),SpBtnDosDropDateTo,True);
end;

procedure TMainForm.CBoxProcessOrgNameChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessOrganization,CBoxProcessOrgName.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnProcessDropOrgName,True);
end;

procedure TMainForm.CBoxProcessDepChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessDepartment,CBoxProcessDep.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnProcessDropDep,True);
end;

procedure TMainForm.CBoxProcessDeviceIDChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessDeviceID,CBoxProcessDeviceID.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnProcessDropDevID,True);
end;

procedure TMainForm.CBoxProcessDosPartChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessDosPath,CBoxProcessDosPart.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnProcessDropDosPart,True);
end;

procedure TMainForm.CBoxProcessDosTypeChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessDosType,CBoxProcessDosType.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnProcessDropDosType,True);
end;

procedure TMainForm.EditProcessDataCommentChange(Sender: TObject);
begin
  SpeedBtnProcessSaveParam.Enabled:=IsEditCommentChanged(EditProcessDataComment);
end;

procedure TMainForm.EditProcessDataCommentKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscMeasPageEdit(Key);
end;

procedure TMainForm.EditProcessDataDosDepKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscMeasPageEdit(Key);
end;

procedure TMainForm.EditProcessDataDosFioKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscMeasPageEdit(Key);
end;

procedure TMainForm.EditProcessDataDosOrgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscMeasPageEdit(Key);
end;

procedure TMainForm.EditProcessDataDosPersNumberKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscMeasPageEdit(Key);
end;

procedure TMainForm.EditProcessDosNumberChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessNumber,EditProcessDosNumber.Text);

  if EditProcessDosNumber.Text <> '' then
    ChangeEdit(TEdit(Sender),SpBtnProcessDropDosNumber,True)
  else
    ChangeEdit(TEdit(Sender),SpBtnProcessDropDosNumber,False);
end;

procedure TMainForm.EditsMeasIDKChanges(Sender: TObject);
begin
  SpeedBtnMeasSaveIDK.Enabled:=IsEditIDKChanged(EditMeasDataDosFio,EditMeasDataDosPersNumber,EditMeasDataDosOrg,EditMeasDataDosDep);
end;

procedure TMainForm.EditsProcessIDKChanges(Sender: TObject);
begin
  SpeedBtnProcessSaveIDK.Enabled:=IsEditIDKChanged(EditProcessDataDosFio,EditProcessDataDosPersNumber,EditProcessDataDosOrg,EditProcessDataDosDep);
end;

procedure TMainForm.EditTestSourceDosimeterNameChange(Sender: TObject);
begin
  FTestSourceDosimeterName:=CBoxDosimeterTest.Text;
end;

procedure TMainForm.EditTestSourceKIncreaseChange(Sender: TObject);
begin
  FTestSourceKIncrease:=StrToFloatRegion(EditTestSourceKIncrease.Text);
end;

procedure TMainForm.EditTestSourceTimeChange(Sender: TObject);
begin
  FTestSourceTime:=StrToInt(EditTestSourceTime.Text);
end;

procedure TMainForm.EditTestSourceTimeIncreaseCycleChange(Sender: TObject);
begin
  FTestSourceTimeIncreaseCycle:=StrToInt(EditTestSourceTimeIncreaseCycle.Text);
end;

procedure TMainForm.CBoxProcessStatusChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessDosStatus,CBoxProcessStatus.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnProcessDropStatus,True);
end;

procedure TMainForm.CBoxSettingsAutoResetDeviceClick(Sender: TObject);
begin
  AutoReset:=CBoxSettingsAutoResetDevice.Checked;
end;

procedure TMainForm.CBoxSettingsShowGladeKTVClick(Sender: TObject);
begin
  ShowGladeKTV:=CBoxSettingsShowGladeKTV.Checked;
end;

procedure TMainForm.CBoxSettingsShowOriginalKTVClick(Sender: TObject);
begin
  ShowOriginalKTV:=CBoxSettingsShowOriginalKTV.Checked;
end;

procedure TMainForm.CBoxSettingsUseAutoCommentClick(Sender: TObject);
begin
  UseControlComment:=CBoxSettingsUseAutoComment.Checked;
end;

procedure TMainForm.CBoxTestSourceTimeIncreaseClick(Sender: TObject);
begin
  FTestSourceTimeIncrease:=CBoxTestSourceTimeIncrease.Checked;
end;

procedure TMainForm.CBoxTestSourceUseClick(Sender: TObject);
begin
  FTestSourceUse:=CBoxTestSourceUse.Checked;
end;

procedure TMainForm.CBoxTestWriteModbusLogClick(Sender: TObject);
begin
  FTestWriteModbusLog:=CBoxTestWriteModbusLog.Checked;
end;

procedure TMainForm.CB_SetAsTemlateChange(Sender: TObject);
begin
  if (CB_SetAsTemlate.ItemIndex<>-1) AND (AW.Users[PermitSelectedRowUser].Login<>AW.CurrentUser.Login) then
  begin
    PermitMask:=cpTemplatePermits[CB_SetAsTemlate.ItemIndex];
    RefreshPermit_CLB;
    WritePermitToUser(PermitMask, AW.Users[PermitSelectedRowUser].Login);
  end;
end;

procedure TMainForm.CB_SetAsTemlateDropDown(Sender: TObject);
begin
  CB_SetAsTemlate.Font.Color:=clWindowText;
  CB_SetAsTemlate.Color:=clWindow;
end;

procedure TMainForm.CBoxProcessPersNumberChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessPersNumber,CBoxProcessPersNumber.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnProcessDropPersNumber,True);
end;

procedure TMainForm.CBoxProcessIDKChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessIDK,CBoxProcessIDK.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnProcessDropIDK,True);
end;

procedure TMainForm.CBoxProcessResultChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessResult,CBoxProcessResult.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnProcessDropResult,True);
end;

procedure TMainForm.CBoxProcessCommentChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessComment,CBoxProcessComment.Text);
  ChangeComboBox(TCombobox(Sender),SpBtnProcessDropComment,True);
end;

procedure TMainForm.DateTimePickerProcessFromChange(Sender: TObject);
begin
  SaveFilterDateIni(cFilterProcessTimeFrom,DateTimeToStr(DateTimePickerProcessFrom.DateTime));
  ChangeDatePicker(TDateTimePicker(Sender),SpBtnProcessDropDateFrom,True);
end;

procedure TMainForm.DateTimePickerProcessToChange(Sender: TObject);
begin
  SaveFilterDateIni(cFilterProcessTimeTo,DateTimeToStr(DateTimePickerProcessTo.DateTime));
  ChangeDatePicker(TDateTimePicker(Sender),SpBtnProcessDropDateTo,True);
end;

procedure TMainForm.PageControlDosParamChange(Sender: TObject);
  procedure SetLblCaptionUnicode(Lbl: TLabel; Value: String);
  begin
    Lbl.Caption:=Value;
  end;
begin
   case PageControlDosParam.ActivePageIndex of
    cPageDosMainParams:
    begin
{
      SetLblCaptionUnicode(LblErr1,Format('%s %s ',[cuUnicodeSymbol_Delta,cEqual]));
      SetLblCaptionUnicode(LblErr2,Format('%s %s ',[cuUnicodeSymbol_Delta,cEqual]));
      SetLblCaptionUnicode(LblErr3,Format('%s %s ',[cuUnicodeSymbol_Delta,cEqual]));
      SetLblCaptionUnicode(LblErr4,Format('%s %s ',[cuUnicodeSymbol_Delta,cEqual]));

      SetLblCaptionUnicode(LblDotK1,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK2,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK3,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK4,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK5,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotKgn,Format('%s',[cuUnicodeSymbol_Dot]));
}

      SetLblCaptionUnicode(LblErr1,Format('%s %s ',[cuUnicodeSymbol_Delta,cEqual]));
      SetLblCaptionUnicode(LblErr2,Format('%s %s ',[cuUnicodeSymbol_Delta,cEqual]));
      SetLblCaptionUnicode(LblErr3,Format('%s %s ',[cuUnicodeSymbol_Delta,cEqual]));
      SetLblCaptionUnicode(LblErr4,Format('%s %s ',[cuUnicodeSymbol_Delta,cEqual]));

      SetLblCaptionUnicode(LblDotK1,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK2,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK3,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK4,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK5,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotKgn,Format('%s',[cuUnicodeSymbol_Dot]));

    end;
  end;
end;

procedure TMainForm.PageControlMainChange(Sender: TObject);
begin
  if not Start then
    UpdateGridPageSoft;
end;

procedure TMainForm.PageControlMeasDosParChange(Sender: TObject);
begin
  case PageControlMeasDosPar.ActivePage.PageIndex of
    cPageMeasProcessMainParam:
    begin
      ChangeStringEdit(EditMeasDataComment,Dosimeter.MeasComment,clWhite);
      SpeedBtnMeasSaveParam.Enabled:=IsEditCommentChanged(EditMeasDataComment);
    end;
    cPageMeasProcessIDKParam:
    begin
      EditMeasDataDose.SetFocus;

      if Assigned(Dosimeter) then
      begin
        ChangeStringEdit(EditMeasDataDosFio,Dosimeter.Fio,clWhite);
        if Dosimeter.PersNumber = -1 then
          ChangeStringEdit(EditMeasDataDosPersNumber,'',clWhite)
        else
          ChangeStringEdit(EditMeasDataDosPersNumber,IntToStr(Dosimeter.PersNumber),clWhite);

        ChangeStringEdit(EditMeasDataDosOrg,Dosimeter.Organization,clWhite);
        ChangeStringEdit(EditMeasDataDosDep,Dosimeter.Department,clWhite);

        SpeedBtnMeasSaveIDK.Enabled:=IsEditIDKChanged(EditMeasDataDosFio,EditMeasDataDosPersNumber,EditMeasDataDosOrg,EditMeasDataDosDep);
      end;
    end;
  end;
end;

procedure TMainForm.PageControlProcessDosParChange(Sender: TObject);
begin

  case PageControlProcessDosPar.ActivePage.PageIndex of
    cPageMeasProcessMainParam:
    begin
      ChangeStringEdit(EditProcessDataComment,Dosimeter.MeasComment,clWhite);
      SpeedBtnProcessSaveParam.Enabled:=IsEditCommentChanged(EditProcessDataComment);
    end;
    cPageMeasProcessIDKParam:
    begin
      EditProcessDataDose.SetFocus;

      if Assigned(Dosimeter) then
      begin
        ChangeStringEdit(EditProcessDataDosFio,Dosimeter.Fio,clWhite);
        if Dosimeter.PersNumber = -1 then
          ChangeStringEdit(EditProcessDataDosPersNumber,'',clWhite)
        else
          ChangeStringEdit(EditProcessDataDosPersNumber,IntToStr(Dosimeter.PersNumber),clWhite);

        ChangeStringEdit(EditProcessDataDosOrg,Dosimeter.Organization,clWhite);
        ChangeStringEdit(EditProcessDataDosDep,Dosimeter.Department,clWhite);

        SpeedBtnMeasSaveIDK.Enabled:=IsEditIDKChanged(EditProcessDataDosFio,EditProcessDataDosPersNumber,EditProcessDataDosOrg,EditProcessDataDosDep);
      end;
    end;
  end;

//  if PageControlProcessDosPar.ActivePage=PGProcessPage_TSIDK then
//  begin
//    EditProcessDataDose.SetFocus;
//
//    if Assigned(Dosimeter) then
//    begin
//      ChangeStringEdit(EditProcessDataDosFio,Dosimeter.Fio,clWhite);
//      if Dosimeter.PersNumber = -1 then
//        ChangeStringEdit(EditProcessDataDosPersNumber,'',clWhite)
//      else
//        ChangeStringEdit(EditProcessDataDosPersNumber,IntToStr(Dosimeter.PersNumber),clWhite);
//
//      ChangeStringEdit(EditProcessDataDosOrg,Dosimeter.Organization,clWhite);
//      ChangeStringEdit(EditProcessDataDosDep,Dosimeter.Department,clWhite);
//
//      SpeedBtnProcessSaveIDK.Enabled:=IsEditIDKChanged(EditProcessDataDosFio,EditProcessDataDosPersNumber,EditProcessDataDosOrg,EditProcessDataDosDep);
//    end;
//  end;
end;

procedure TMainForm.PageControlSettingsChange(Sender: TObject);
var
  userIndex: integer;
begin
  case PageControlSettings.ActivePage.PageIndex of
    cPageSettingsDeviceIndex:
    begin
      LoadCBoxSourceTest;
      CheckValidTestDosName;
      TabSheetDeviceControlShow(self);
    end;
    cPageSettingsDatabaseIndex:
    begin
      RefreshDBList;
      CheckDBCommentEdit;
      ProgressBarHide(ProgressBarDB);
      SetSaveDialogDBFilter;
    end;
    cPageSettingsPermitIndex:
    begin
      userIndex:=GetUserIndexFromSG(AW.CurrentUser.Login);
      if userIndex>0 then
        SG_Users.Row:=userIndex
    end;
  end;
end;

procedure TMainForm.PageDosNumberChange(Sender: TObject);
begin
  EditDosDataDosOrgValGroup.Clear;
  EditDosDataDosDepValGroup.Clear;
end;

procedure TMainForm.PanelPermitLeftResize(Sender: TObject);
begin
  SG_Users.RowHeights[0]:=50;
  SG_Users.ColWidths[0]:=100;
  SG_Users.ColWidths[1]:=PanelPermitLeft.Width-(SG_Users.ColWidths[0]);
  PanelDB.Width:=PanelPermitLeftGrid.Width+cPanelDBWidthAdd;
end;

procedure TMainForm.PanelMeasLeftResize(Sender: TObject);
begin
  ResizeMeasPanelLeft(DBGridEhOnlyMeas,MemTableEhMeasList);
end;

procedure TMainForm.PanelProcessLeftResize(Sender: TObject);
begin
  ResizeMeasPanelLeft(DBGridEhProcess,MemTableEhProcessList);
end;

function TMainForm.CheckValidMeasToCalibr(DBGrid: TDbGridEh): boolean;
var
  i             : integer;
  cntNotValid   : integer;
  cntZeroDose   : integer;
  measId        : String;
  measState     : integer;
  function CheckNANGrid(Field: String; Grid: TDBGridEh): double;
  begin
    if Grid.DataSource.DataSet.FieldByName(Field).AsVariant <> Null then
      Result:=Grid.DataSource.DataSet.FieldByName(Field).AsFloat
    else
      Result:=NAN;
  end;
  function CheckValue(Value: double): boolean;
  begin
    if (Value.IsNan) OR (Value > 0) then
      Result:=true
    else
      Result:=false;
  end;
begin
  measState:=0;

  cntNotValid:=0;
  cntZeroDose:=0;

  for i := 0 to DBGrid.SelectedRows.Count-1 do
  begin
    DBGrid.DataSource.DataSet.GotoBookmark(DBGrid.SelectedRows.Items[i]);

    measId:=DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;
    measState:=DBGrid.DataSource.DataSet.FieldByName(cFieldValidity).AsInteger;

    case measState of
      cDosNotMeasured .. cDosMeasFinishedD4,cDosMeasStoppedD1 .. cDosMeasStoppedD4,cDosMeasError:
      begin
        inc(cntNotValid);
      end;
    end;

    if not CheckValue(CheckNANGrid(cFieldHp10g, DBGrid)) then inc (cntZeroDose);
    if not CheckValue(CheckNANGrid(cFieldHp3, DBGrid)) then inc (cntZeroDose);
    if not CheckValue(CheckNANGrid(cFieldHp007, DBGrid)) then inc (cntZeroDose);
    if not CheckValue(CheckNANGrid(cFieldHstar, DBGrid)) then inc (cntZeroDose);
    if not CheckValue(CheckNANGrid(cFieldH007, DBGrid)) then inc (cntZeroDose);
    if not CheckValue(CheckNANGrid(cFieldD, DBGrid)) then inc (cntZeroDose);

  end;

  if (cntNotValid = 0) AND (cntZeroDose = 0) then
    Result:=true
  else
    Result:=false;

end;

procedure TMainForm.CheckValidTestDosName;
begin
  if TLDDataModule.IsDosimeterExist(FTestSourceDosimeterName) then
  begin
    LblTestDosNameErr.Visible:=false;
    BtnStartTesting.Enabled:=true;
  end
  else
  begin
    LblTestDosNameErr.Visible:=true;
    BtnStartTesting.Enabled:=false;
  end;
end;

procedure TMainForm.CheckVisibleGridFields;
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFullDosID).Index].Visible:=true;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldDosMeasID).Index].Visible:=MeasColumnMeasID;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldMeasureTime).Index].Visible:=MeasColumnMeasDateTime;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldKSI).Index].Visible:=MeasColumnKSI;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldDose).Index].Visible:=MeasColumnDose;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldHp10g).Index].Visible:=MeasColumnHp10g;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldHp10n).Index].Visible:=MeasColumnHp10n;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldHp007).Index].Visible:=MeasColumnHp007;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldHp3).Index].Visible:=MeasColumnHp3;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldHstar).Index].Visible:=MeasColumnHStar;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldH007).Index].Visible:=MeasColumnH007;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldD).Index].Visible:=MeasColumnD;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Visible:=MeasColumnMeasValidity;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldValidity).Index].Visible:=false;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible:=MeasColumnDosType;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Visible:=MeasColumnDosReg;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Visible:=MeasColumnDosVer;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Visible:=MeasColumnDosStatus;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldOrg).Index].Visible:=MeasColumnOrganization;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Visible:=MeasColumnDepartment;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Visible:=MeasColumnPartID;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldMeasComment).Index].Visible:=MeasColumnMeasComment;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldPersNumber).Index].Visible:=MeasColumnPersNumber;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldFio).Index].Visible:=MeasColumnFIO;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldTldUser).Index].Visible:=MeasColumnTLDUser;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible:=MeasColumnTldID;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldToDel).Index].Visible:=false;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Visible:=MeasColumnLastMeasTime;
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Visible:=MeasColumnLastMeasComment;
    end;
    cPageDosIndex:
    begin
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFullDosID).Index].Visible:=true;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible:=DosColumnDosType;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldStringState).Index].Visible:=DosColumnDosState;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Visible:=false;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_k1).Index].Visible:=DosColumnk1;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_k2).Index].Visible:=DosColumnk2;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_k3).Index].Visible:=DosColumnk3;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_k4).Index].Visible:=DosColumnk4;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_k5).Index].Visible:=DosColumnk5;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_kgn).Index].Visible:=DosColumnkgn;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Visible:=DosColumnPartID;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Visible:=DosColumnRegTime;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Visible:=DosColumnVerTime;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldOrg).Index].Visible:=DosColumnOrg;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Visible:=DosColumnDep;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Visible:=DosColumnLastMeasTime;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Visible:=DosColumnLastMeasResult;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Visible:=DosColumnLastMeasComment;
      DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible:=DosColumnTldID;
    end;
    cPageProcessIndex:
    begin
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFullDosID).Index].Visible:=true;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosMeasID).Index].Visible:=ProcessColumnMeasID;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldMeasureTime).Index].Visible:=ProcessColumnMeasDateTime;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldKSI).Index].Visible:=ProcessColumnKSI;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDose).Index].Visible:=ProcessColumnDose;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldHp10g).Index].Visible:=ProcessColumnHp10g;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldHp10n).Index].Visible:=ProcessColumnHp10n;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldHp007).Index].Visible:=ProcessColumnHp007;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldHp3).Index].Visible:=ProcessColumnHp3;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldHstar).Index].Visible:=ProcessColumnHStar;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldH007).Index].Visible:=ProcessColumnH007;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldD).Index].Visible:=ProcessColumnD;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Visible:=ProcessColumnMeasValidity;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldValidity).Index].Visible:=false;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible:=ProcessColumnDosType;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Visible:=ProcessColumnDosReg;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Visible:=ProcessColumnDosVer;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Visible:=ProcessColumnDosStatus;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldOrg).Index].Visible:=ProcessColumnOrganization;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Visible:=ProcessColumnDepartment;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Visible:=ProcessColumnPartID;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldMeasComment).Index].Visible:=ProcessColumnMeasComment;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldPersNumber).Index].Visible:=ProcessColumnPersNumber;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldFio).Index].Visible:=ProcessColumnFIO;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldTldUser).Index].Visible:=ProcessColumnTLDUser;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible:=ProcessColumnTldID;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldToDel).Index].Visible:=false;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Visible:=ProcessColumnLastMeasTime;
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Visible:=ProcessColumnLastMeasComment;
    end;
  end;
end;

procedure TMainForm.CheckVisibleKTV;
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      SeriesMeasD1KTV.Active:=ShowOriginalKTV;
      SeriesMeasD2KTV.Active:=ShowOriginalKTV;
      SeriesMeasD3KTV.Active:=ShowOriginalKTV;
      SeriesMeasD4KTV.Active:=ShowOriginalKTV;

      SeriesMeasD1Glade.Active:=ShowGladeKTV;
      SeriesMeasD2Glade.Active:=ShowGladeKTV;
      SeriesMeasD3Glade.Active:=ShowGladeKTV;
      SeriesMeasD4Glade.Active:=ShowGladeKTV;
    end;
    cPageProcessIndex:
    begin
      SeriesProcessD1KTV.Active:=ShowOriginalKTV;
      SeriesProcessD2KTV.Active:=ShowOriginalKTV;
      SeriesProcessD3KTV.Active:=ShowOriginalKTV;
      SeriesProcessD4KTV.Active:=ShowOriginalKTV;

      SeriesProcessD1Glade.Active:=ShowGladeKTV;
      SeriesProcessD2Glade.Active:=ShowGladeKTV;
      SeriesProcessD3Glade.Active:=ShowGladeKTV;
      SeriesProcessD4Glade.Active:=ShowGladeKTV;
    end;
  end;
end;

procedure TMainForm.PanelCalibrationLeftResize(Sender: TObject);
begin
  ResizeMeasPanelLeft(DBGridEhCalcKDos,MemTableEhCalcKDos);
end;

procedure TMainForm.PanelDataResize(Sender: TObject);
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      ResizeDetPanels(PanelMeasData,
                      PanelMeasDataDos,
                      PanelMeasButtons,
                      PanelMeasDataDets,
                      PanelMeasDataD1,
                      PanelMeasDataD1Chart,
                      PanelMeasDataD2,
                      PanelMeasDataD2Chart,
                      PanelMeasDataD3,
                      PanelMeasDataD3Chart,
                      PanelMeasDataD4,
                      PanelMeasDataD4Chart,
                      FMaximazeD1Chart,
                      FMaximazeD2Chart,
                      FMaximazeD3Chart,
                      FMaximazeD4Chart);
    end;
    cPageDosIndex:
    begin

    end;
    cPageProcessIndex:
    begin
      ResizeDetPanels(PanelProcessData,
                      PanelProcessDataDos,
                      PanelProcessButtons,
                      PanelProcessDataDets,
                      PanelProcessDataD1,
                      PanelProcessDataD1Chart,
                      PanelProcessDataD2,
                      PanelProcessDataD2Chart,
                      PanelProcessDataD3,
                      PanelProcessDataD3Chart,
                      PanelProcessDataD4,
                      PanelProcessDataD4Chart,
                      FMaximazeD1Chart,
                      FMaximazeD2Chart,
                      FMaximazeD3Chart,
                      FMaximazeD4Chart);
    end;
  end;
end;

procedure TMainForm.PanelDosLeftResize(Sender: TObject);
begin
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.ResizeDetPanels(PanelData         : TPanel;
                                    PanelDataDos    : TPanel;
                                    PanelButtons    : TPanel;
                                    PanelDataDets     : TPanel;
                                    PanelDataD1       : TPanel;
                                    PanelDataD1Chart  : TPanel;
                                    PanelDataD2       : TPanel;
                                    PanelDataD2Chart  : TPanel;
                                    PanelDataD3       : TPanel;
                                    PanelDataD3Chart  : TPanel;
                                    PanelDataD4       : TPanel;
                                    PanelDataD4Chart  : TPanel;
                                    MaximazeD1Chart   : boolean;
                                    MaximazeD2Chart   : boolean;
                                    MaximazeD3Chart   : boolean;
                                    MaximazeD4Chart   : boolean);
var
  HeightPanelD  : integer;
  WidthPanelD   : integer;

  TopPanelD1    : integer;
  TopPanelD2    : integer;
  TopPanelD3    : integer;
  TopPanelD4    : integer;
begin

  WidthPanelD:=PanelData.Width-7;

  HeightPanelD:=Round(PanelData.Height-PanelDataDos.Height)-1;          // если показываем только один детектор

  if (NOT HideD1 AND NOT HideD2 AND NOT HideD3 AND NOT HideD4) then               // если 4 детектора
  begin
    HeightPanelD:=Round((PanelData.Height-PanelDataDos.Height)/4)-1;
  end;

  if (HideD4 AND NOT HideD1 AND NOT HideD2 AND NOT HideD3) then                   // если 3 детектора
  begin
    HeightPanelD:=Round((PanelData.Height-PanelDataDos.Height)/3)-1;
  end;

  if (HideD3 AND HideD4 AND NOT HideD1 AND NOT HideD2) then                       // если 2 детектора
  begin
    HeightPanelD:=Round((PanelData.Height-PanelDataDos.Height)/2)-1;
  end;

  TopPanelD1:=PanelData.Top-PanelButtons.Height;
  TopPanelD2:=HeightPanelD;
  TopPanelD3:=HeightPanelD*2;
  TopPanelD4:=HeightPanelD*3;

  PanelDataD1.Top:=TopPanelD1;
  PanelDataD1.Height:=HeightPanelD;
  PanelDataD1Chart.Left:=PanelDataD1.Width+1;

  PanelDataD2.Top:=TopPanelD2;
  PanelDataD2.Height:=HeightPanelD;
  PanelDataD2Chart.Left:=PanelDataD2.Width+1;

  PanelDataD3.Top:=TopPanelD3;
  PanelDataD3.Height:=HeightPanelD;
  PanelDataD3Chart.Left:=PanelDataD3.Width+1;

  PanelDataD4.Top:=TopPanelD4;
  PanelDataD4.Height:=HeightPanelD;
  PanelDataD4Chart.Left:=PanelDataD4.Width+1;

  if (not MaximazeD1Chart) and (not MaximazeD2Chart) and (not MaximazeD3Chart) and (not MaximazeD4Chart) then
  begin
    PanelDataD1Chart.Top:=TopPanelD1;
    PanelDataD1Chart.Width:=WidthPanelD-PanelDataD1.Width+4;
    PanelDataD1Chart.Height:=HeightPanelD;

    PanelDataD2Chart.Top:=TopPanelD2;
    PanelDataD2Chart.Width:=WidthPanelD-PanelDataD2.Width+4;
    PanelDataD2Chart.Height:=HeightPanelD;

    PanelDataD3Chart.Top:=TopPanelD3;
    PanelDataD3Chart.Width:=WidthPanelD-PanelDataD3.Width+4;
    PanelDataD3Chart.Height:=HeightPanelD;

    PanelDataD4Chart.Top:=TopPanelD4;
    PanelDataD4Chart.Width:=WidthPanelD-PanelDataD4.Width+4;
    PanelDataD4Chart.Height:=HeightPanelD;
  end
  else if MaximazeD1Chart then
  begin
    PanelDataD1Chart.Width:=PanelDataDets.Width-PanelDataD1.Width-1;
    PanelDataD1Chart.Height:=PanelDataDets.Height;
  end
  else if MaximazeD2Chart then
  begin
    PanelDataD2Chart.Width:=PanelDataDets.Width-PanelDataD1.Width-1;
    PanelDataD2Chart.Height:=PanelDataDets.Height;
  end
  else if MaximazeD3Chart then
  begin
    PanelDataD3Chart.Width:=PanelDataDets.Width-PanelDataD1.Width-1;
    PanelDataD3Chart.Height:=PanelDataDets.Height;
  end
  else if MaximazeD4Chart then
  begin
    PanelDataD4Chart.Width:=PanelDataDets.Width-PanelDataD1.Width-1;
    PanelDataD4Chart.Height:=PanelDataDets.Height;
  end;
end;

procedure TMainForm.ResizeMeasPanelLeft(DBGrid: TDbGridEh; MemTable: TMemTableEh);
const
  cAddFieldSize = 10;
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
    if DBGrid.DataSource.DataSet.FindField(cFullDosID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Title.caption:=Format(' %s',[rsDosimeter]);

    if (DBGrid.DataSource.DataSet.FindField(cFieldDosMeasID)<>nil) then
    begin
      DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).Index].Title.caption:=Format(' %s',[rsSmMeasID]);
      //*DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).Index].Footer.ValueType:=fvtStaticText;
      //*DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).Index].Footer.Value:=Format('%s - %d',[rsSmMeasShort,DBGrid.DataSource.DataSet.RecordCount]);
    end;

    if DBGrid.DataSource.DataSet.FindField(cFieldMeasureTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasureTime).Index].Title.caption:=Format(' %s',[rsSmMeasDate]);
    if DBGrid.DataSource.DataSet.FindField(cFieldKSI)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldKSI).Index].Title.caption:=Format(' %s',[rsSmKS]);
    if DBGrid.DataSource.DataSet.FindField(cFieldDose)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDose).Index].Title.caption:=Format(' %s, %s',[rsDosDose,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldCalibrationValue)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldCalibrationValue).Index].Title.caption:=Format(' %s, %s',[rsSmCalibrDose,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldRadiationType)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRadiationType).Index].Title.caption:=Format(' %s',[rsSmDoseType]);
    if DBGrid.DataSource.DataSet.FindField(cField_k1)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k1).Index].Title.Caption:=Format(' %s',[cK1]);
    if DBGrid.DataSource.DataSet.FindField(cField_k2)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k2).Index].Title.Caption:=Format(' %s',[cK2]);
    if DBGrid.DataSource.DataSet.FindField(cField_k3)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k3).Index].Title.Caption:=Format(' %s',[cK3]);
    if DBGrid.DataSource.DataSet.FindField(cField_k4)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k4).Index].Title.Caption:=Format(' %s',[cK4]);
    if DBGrid.DataSource.DataSet.FindField(cField_k5)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k5).Index].Title.Caption:=Format(' %s',[cK5]);
    if DBGrid.DataSource.DataSet.FindField(cField_kgn)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_kgn).Index].Title.Caption:=Format(' %s',[cKgn]);
    if DBGrid.DataSource.DataSet.FindField(cFieldHp10g)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g).Index].Title.caption:=Format(' %s, %s',[cHp_10g,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldHp10n)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n).Index].Title.caption:=Format(' %s, %s',[cHp_10n,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldHp007)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007).Index].Title.caption:=Format(' %s, %s',[cHp_007,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldHp3)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3).Index].Title.caption:=Format(' %s, %s',[cHp_3,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldHstar)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar).Index].Title.caption:=Format(' %s, %s',[cH_star,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldH007)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007).Index].Title.caption:=Format(' %s, %s',[cH_007_dir,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldD)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD).Index].Title.caption:=Format(' %s, %s',[cD,rsUntmGy]);
    if DBGrid.DataSource.DataSet.FindField(cFieldHp10g_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g_Err).Index].Title.caption:=Format('%s%s, %s',[cuUnicodeSymbol_Delta,cHp_10g,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldHp10n_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n_Err).Index].Title.caption:=Format('%s%s, %s',[cuUnicodeSymbol_Delta,cHp_10n,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldHp007_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007_Err).Index].Title.caption:=Format('%s%s, %s',[cuUnicodeSymbol_Delta,cHp_007,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldHp3_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3_Err).Index].Title.caption:=Format('%s%s, %s',[cuUnicodeSymbol_Delta,cHp_3,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldHstar_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar_Err).Index].Title.caption:=Format('%s%s, %s',[cuUnicodeSymbol_Delta,cH_star,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldH007_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007_Err).Index].Title.caption:=Format('%s%s, %s',[cuUnicodeSymbol_Delta,cH_007_dir,rsUntmSv]);
    if DBGrid.DataSource.DataSet.FindField(cFieldD_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD_Err).Index].Title.caption:=Format('%s%s, %s',[cuUnicodeSymbol_Delta,cD,rsUntmGy]);
    if DBGrid.DataSource.DataSet.FindField(cFieldStringValidity)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Title.caption:=Format(' %s',[rsSmMeasStatus]);
    if DBGrid.DataSource.DataSet.FindField(cFieldDosType)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Title.caption:=Format(' %s',[rsFltDosType]);
    if DBGrid.DataSource.DataSet.FindField(cFieldRegTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Title.caption:=Format(' %s',[rsSmRegistrationDate]);
    if DBGrid.DataSource.DataSet.FindField(cFieldVerTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Title.caption:=Format(' %s',[rsSmVerificationDate]);
    if DBGrid.DataSource.DataSet.FindField(cFieldLastMeasTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Title.caption:=Format(' %s',[rsSmLastMeasTime]);
    if DBGrid.DataSource.DataSet.FindField(cFieldDosStatus)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Title.caption:=Format(' %s',[rsDosStatus]);
    if DBGrid.DataSource.DataSet.FindField(cFieldOrg)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldOrg).Index].Title.caption:=Format(' %s',[rsFltOrg]);
    if DBGrid.DataSource.DataSet.FindField(cFieldDepartment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Title.caption:=Format(' %s',[rsFltDep]);
    if DBGrid.DataSource.DataSet.FindField(cFieldDosPartName)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Title.caption:=Format(' %s',[rsFltPart]);
    if DBGrid.DataSource.DataSet.FindField(cFieldMeasComment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasComment).Index].Title.caption:=Format(' %s',[rsSmCommentToMeas]);
    if DBGrid.DataSource.DataSet.FindField(cFieldPersNumber)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldPersNumber).Index].Title.caption:=Format(' %s',[rsFltPersNumber]);
    if DBGrid.DataSource.DataSet.FindField(cFieldFio)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldFio).Index].Title.caption:=Format(' %s',[rsFIO]);
    if DBGrid.DataSource.DataSet.FindField(cFieldTldUser)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldUser).Index].Title.caption:=Format(' %s',[rsSmTLDUser]);
    if DBGrid.DataSource.DataSet.FindField(cFieldTldID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldID).Index].Title.caption:=Format(' %s',[rsSmTldID]);

    if DBGrid.DataSource.DataSet.FindField(cFieldLastMeasComment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Title.caption:=Format(' %s',[rsSmCommentToDos]);

    case PageControlMain.ActivePage.PageIndex of
      cPageMeasIndex:
      begin
        if DBGrid.DataSource.DataSet.FindField(cFullDosID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Visible:=true;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosMeasID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).Index].Visible:=MeasColumnMeasID;
        if DBGrid.DataSource.DataSet.FindField(cFieldMeasureTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasureTime).Index].Visible:=MeasColumnMeasDateTime;
        if DBGrid.DataSource.DataSet.FindField(cFieldKSI)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldKSI).Index].Visible:=MeasColumnKSI;
        if DBGrid.DataSource.DataSet.FindField(cFieldDose)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDose).Index].Visible:=MeasColumnDose;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10g)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g).Index].Visible:=MeasColumnHp10g;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10n)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n).Index].Visible:=MeasColumnHp10n;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp007)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007).Index].Visible:=MeasColumnHp007;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp3)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3).Index].Visible:=MeasColumnHp3;
        if DBGrid.DataSource.DataSet.FindField(cFieldHstar)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar).Index].Visible:=MeasColumnHStar;
        if DBGrid.DataSource.DataSet.FindField(cFieldH007)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007).Index].Visible:=MeasColumnH007;
        if DBGrid.DataSource.DataSet.FindField(cFieldD)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD).Index].Visible:=MeasColumnD;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10g_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g_Err).Index].Visible:=MeasColumnHp10g_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10n_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n_Err).Index].Visible:=MeasColumnHp10n_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp007_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007_Err).Index].Visible:=MeasColumnHp007_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp3_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3_Err).Index].Visible:=MeasColumnHp3_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHstar_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar_Err).Index].Visible:=MeasColumnHStar_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldH007_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007_Err).Index].Visible:=MeasColumnH007_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldD_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD_Err).Index].Visible:=MeasColumnD_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldFormulaId_Dos)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldFormulaId_Dos).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldStringValidity)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Visible:=MeasColumnMeasValidity;
        if DBGrid.DataSource.DataSet.FindField(cFieldValidity)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldValidity).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosType)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible:=MeasColumnDosType;
        if DBGrid.DataSource.DataSet.FindField(cFieldRegTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Visible:=MeasColumnDosReg;
        if DBGrid.DataSource.DataSet.FindField(cFieldVerTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Visible:=MeasColumnDosVer;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosStatus)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Visible:=MeasColumnDosStatus;
        if DBGrid.DataSource.DataSet.FindField(cFieldOrg)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldOrg).Index].Visible:=MeasColumnOrganization;
        if DBGrid.DataSource.DataSet.FindField(cFieldDepartment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Visible:=MeasColumnDepartment;
        if DBGrid.DataSource.DataSet.FindField(cFieldPartID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldPartID).Index].Visible:=False;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosPartName)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Visible:=MeasColumnPartID;
        if DBGrid.DataSource.DataSet.FindField(cFieldMeasComment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasComment).Index].Visible:=MeasColumnMeasComment;
        if DBGrid.DataSource.DataSet.FindField(cFieldPersNumber)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldPersNumber).Index].Visible:=MeasColumnPersNumber;
        if DBGrid.DataSource.DataSet.FindField(cFieldFio)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldFio).Index].Visible:=MeasColumnFIO;
        if DBGrid.DataSource.DataSet.FindField(cFieldTldUser)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldUser).Index].Visible:=MeasColumnTLDUser;
        if DBGrid.DataSource.DataSet.FindField(cFieldTldID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible:=MeasColumnTldID;
        if DBGrid.DataSource.DataSet.FindField(cFieldToDel)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldToDel).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldLastMeasTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Visible:=MeasColumnLastMeasTime;
        if DBGrid.DataSource.DataSet.FindField(cFieldLastMeasComment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Visible:=MeasColumnLastMeasComment;
      end;
      cPageProcessIndex:
      begin
        if DBGrid.DataSource.DataSet.FindField(cFullDosID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Visible:=true;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosMeasID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).Index].Visible:=ProcessColumnMeasID;
        if DBGrid.DataSource.DataSet.FindField(cFieldMeasureTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasureTime).Index].Visible:=ProcessColumnMeasDateTime;
        if DBGrid.DataSource.DataSet.FindField(cFieldKSI)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldKSI).Index].Visible:=ProcessColumnKSI;
        if DBGrid.DataSource.DataSet.FindField(cFieldDose)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDose).Index].Visible:=ProcessColumnDose;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10g)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g).Index].Visible:=ProcessColumnHp10g;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10n)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n).Index].Visible:=ProcessColumnHp10n;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp007)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007).Index].Visible:=ProcessColumnHp007;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp3)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3).Index].Visible:=ProcessColumnHp3;
        if DBGrid.DataSource.DataSet.FindField(cFieldHstar)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar).Index].Visible:=ProcessColumnHStar;
        if DBGrid.DataSource.DataSet.FindField(cFieldH007)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007).Index].Visible:=ProcessColumnH007;
        if DBGrid.DataSource.DataSet.FindField(cFieldD)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD).Index].Visible:=ProcessColumnD;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10g_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g_Err).Index].Visible:=ProcessColumnHp10g_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10n_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n_Err).Index].Visible:=ProcessColumnHp10n_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp007_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007_Err).Index].Visible:=ProcessColumnHp007_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp3_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3_Err).Index].Visible:=ProcessColumnHp3_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHstar_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar_Err).Index].Visible:=ProcessColumnHStar_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldH007_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007_Err).Index].Visible:=ProcessColumnH007_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldD_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD_Err).Index].Visible:=ProcessColumnD_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldFormulaId_Dos)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldFormulaId_Dos).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldStringValidity)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Visible:=ProcessColumnMeasValidity;
        if DBGrid.DataSource.DataSet.FindField(cFieldValidity)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldValidity).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosType)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible:=ProcessColumnDosType;
        if DBGrid.DataSource.DataSet.FindField(cFieldRegTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Visible:=ProcessColumnDosReg;
        if DBGrid.DataSource.DataSet.FindField(cFieldVerTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Visible:=ProcessColumnDosVer;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosStatus)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Visible:=ProcessColumnDosStatus;
        if DBGrid.DataSource.DataSet.FindField(cFieldOrg)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldOrg).Index].Visible:=ProcessColumnOrganization;
        if DBGrid.DataSource.DataSet.FindField(cFieldDepartment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Visible:=ProcessColumnDepartment;
        if DBGrid.DataSource.DataSet.FindField(cFieldPartID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldPartID).Index].Visible:=False;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosPartName)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Visible:=ProcessColumnPartID;
        if DBGrid.DataSource.DataSet.FindField(cFieldMeasComment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasComment).Index].Visible:=ProcessColumnMeasComment;
        if DBGrid.DataSource.DataSet.FindField(cFieldPersNumber)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldPersNumber).Index].Visible:=ProcessColumnPersNumber;
        if DBGrid.DataSource.DataSet.FindField(cFieldFio)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldFio).Index].Visible:=ProcessColumnFIO;
        if DBGrid.DataSource.DataSet.FindField(cFieldTldUser)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldUser).Index].Visible:=ProcessColumnTLDUser;
        if DBGrid.DataSource.DataSet.FindField(cFieldTldID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible:=ProcessColumnTldID;
        if DBGrid.DataSource.DataSet.FindField(cFieldToDel)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldToDel).Index].Visible:=true;
        if DBGrid.DataSource.DataSet.FindField(cFieldLastMeasTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Visible:=ProcessColumnLastMeasTime;
        if DBGrid.DataSource.DataSet.FindField(cFieldLastMeasComment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Visible:=ProcessColumnLastMeasComment;
      end;
      cPageCalibrationIndex:
      begin
        if DBGrid.DataSource.DataSet.FindField(cFullDosID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Visible:=true;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosMeasID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).Index].Visible:=CalibrColumnMeasID;
        if DBGrid.DataSource.DataSet.FindField(cFieldMeasureTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasureTime).Index].Visible:=CalibrColumnMeasDateTime;
        if DBGrid.DataSource.DataSet.FindField(cFieldKSI)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldKSI).Index].Visible:=CalibrColumnKSI;
        if DBGrid.DataSource.DataSet.FindField(cFieldDose)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDose).Index].Visible:=CalibrColumnDose;
        if DBGrid.DataSource.DataSet.FindField(cField_k1)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k1).Index].Visible:=CalibrColumnK1;
        if DBGrid.DataSource.DataSet.FindField(cField_k2)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k2).Index].Visible:=CalibrColumnK2;
        if DBGrid.DataSource.DataSet.FindField(cField_k3)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k3).Index].Visible:=CalibrColumnK3;
        if DBGrid.DataSource.DataSet.FindField(cField_k4)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k4).Index].Visible:=CalibrColumnK4;
        if DBGrid.DataSource.DataSet.FindField(cField_k5)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k5).Index].Visible:=CalibrColumnK5;
        if DBGrid.DataSource.DataSet.FindField(cField_kgn)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_kgn).Index].Visible:=CalibrColumnKgn;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10g)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g).Index].Visible:=CalibrColumnHp10g;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10n)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n).Index].Visible:=CalibrColumnHp10n;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp007)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007).Index].Visible:=CalibrColumnHp007;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp3)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3).Index].Visible:=CalibrColumnHp3;
        if DBGrid.DataSource.DataSet.FindField(cFieldHstar)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar).Index].Visible:=CalibrColumnHStar;
        if DBGrid.DataSource.DataSet.FindField(cFieldH007)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007).Index].Visible:=CalibrColumnH007;
        if DBGrid.DataSource.DataSet.FindField(cFieldD)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD).Index].Visible:=CalibrColumnD;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10g_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g_Err).Index].Visible:=CalibrColumnHp10g_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp10n_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n_Err).Index].Visible:=CalibrColumnHp10n_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp007_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007_Err).Index].Visible:=CalibrColumnHp007_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHp3_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3_Err).Index].Visible:=CalibrColumnHp3_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldHstar_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar_Err).Index].Visible:=CalibrColumnHStar_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldH007_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007_Err).Index].Visible:=CalibrColumnH007_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldD_Err)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD_Err).Index].Visible:=CalibrColumnD_Err;
        if DBGrid.DataSource.DataSet.FindField(cFieldFormulaId_Dos)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldFormulaId_Dos).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldStringValidity)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Visible:=CalibrColumnMeasValidity;
        if DBGrid.DataSource.DataSet.FindField(cFieldValidity)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldValidity).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosType)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible:=CalibrColumnDosType;
        if DBGrid.DataSource.DataSet.FindField(cFieldRegTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Visible:=CalibrColumnDosReg;
        if DBGrid.DataSource.DataSet.FindField(cFieldVerTime)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Visible:=CalibrColumnDosVer;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosStatus)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Visible:=CalibrColumnDosStatus;
        if DBGrid.DataSource.DataSet.FindField(cFieldOrg)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldOrg).Index].Visible:=CalibrColumnOrganization;
        if DBGrid.DataSource.DataSet.FindField(cFieldDepartment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Visible:=CalibrColumnDepartment;
        if DBGrid.DataSource.DataSet.FindField(cFieldPartID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldPartID).Index].Visible:=False;
        if DBGrid.DataSource.DataSet.FindField(cFieldDosPartName)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Visible:=CalibrColumnPartID;
        if DBGrid.DataSource.DataSet.FindField(cFieldMeasComment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasComment).Index].Visible:=CalibrColumnMeasComment;
        if DBGrid.DataSource.DataSet.FindField(cFieldPersNumber)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldPersNumber).Index].Visible:=CalibrColumnPersNumber;
        if DBGrid.DataSource.DataSet.FindField(cFieldFio)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldFio).Index].Visible:=CalibrColumnFIO;
        if DBGrid.DataSource.DataSet.FindField(cFieldTldUser)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldUser).Index].Visible:=CalibrColumnTLDUser;
        if DBGrid.DataSource.DataSet.FindField(cFieldTldID)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible:=CalibrColumnTldID;
        if DBGrid.DataSource.DataSet.FindField(cFieldToDel)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldToDel).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldLastMeasComment)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Visible:=CalibrColumnLastMeasComment;

        if DBGrid.DataSource.DataSet.FindField(cFieldVirt_Err_Hp_10g_Percent)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVirt_Err_Hp_10g_Percent).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldVirt_Err_Hp_10n_Percent)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVirt_Err_Hp_10n_Percent).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldVirt_Err_Hp_3_Percent)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVirt_Err_Hp_3_Percent).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldVirt_Err_Hp_007_Percent)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVirt_Err_Hp_007_Percent).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldVirt_Err_H_star_Percent)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVirt_Err_H_star_Percent).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldVirt_Err_H_007_Percent)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVirt_Err_H_007_Percent).Index].Visible:=false;
        if DBGrid.DataSource.DataSet.FindField(cFieldVirt_Err_D_Percent)<>nil then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVirt_Err_D_Percent).Index].Visible:=false;
      end;
    end;
    if (DBGrid.DataSource.DataSet.FindField(cFieldTldID)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldID).Index].Width:=cColumnWidth_3;
    if (DBGrid.DataSource.DataSet.FindField(cFullDosID)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Width:=cColumnWidth_2;
    if (DBGrid.DataSource.DataSet.FindField(cFieldDosMeasID)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).Index].Width:=cColumnWidth_7;
    if (DBGrid.DataSource.DataSet.FindField(cFieldMeasureTime)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasureTime).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasureTime).Index].Width:=cColumnWidth_5;
    if (DBGrid.DataSource.DataSet.FindField(cFieldKSI)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldKSI).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldKSI).Index].Width:=cColumnWidth_1;
    if (DBGrid.DataSource.DataSet.FindField(cFieldDose)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDose).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDose).Index].Width:=cColumnWidth_6;

    if (DBGrid.DataSource.DataSet.FindField(cFieldCalibrationValue)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldCalibrationValue).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldCalibrationValue).Index].Width:=cColumnWidth_5;
    if (DBGrid.DataSource.DataSet.FindField(cFieldRadiationType)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRadiationType).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRadiationType).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cField_k1)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k1).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k1).Index].Width:=cColumnWidth_2;
    if (DBGrid.DataSource.DataSet.FindField(cField_k2)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k2).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k2).Index].Width:=cColumnWidth_2;
    if (DBGrid.DataSource.DataSet.FindField(cField_k3)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k3).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k3).Index].Width:=cColumnWidth_2;
    if (DBGrid.DataSource.DataSet.FindField(cField_k4)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k4).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k4).Index].Width:=cColumnWidth_2;
    if (DBGrid.DataSource.DataSet.FindField(cField_k5)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k5).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k5).Index].Width:=cColumnWidth_2;
    if (DBGrid.DataSource.DataSet.FindField(cField_kgn)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_kgn).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_kgn).Index].Width:=cColumnWidth_2;

    if (DBGrid.DataSource.DataSet.FindField(cFieldHp10g)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldHp10n)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldHp007)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldHp3)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldHstar)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldH007)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldD)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldHp10g_Err)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g_Err).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10g_Err).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldHp10n_Err)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n_Err).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp10n_Err).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldHp007_Err)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007_Err).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp007_Err).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldHp3_Err)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3_Err).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHp3_Err).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldHstar_Err)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar_Err).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldHstar_Err).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldH007_Err)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007_Err).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldH007_Err).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldD_Err)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD_Err).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldD_Err).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldStringValidity)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Width:=cColumnWidth_5;
    if (DBGrid.DataSource.DataSet.FindField(cFieldDosType)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldRegTime)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Width:=cColumnWidth_5;
    if (DBGrid.DataSource.DataSet.FindField(cFieldVerTime)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldLastMeasTime)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Width:=cColumnWidth_5;
    if (DBGrid.DataSource.DataSet.FindField(cFieldDosStatus)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Width:=cColumnWidth_5;
    if (DBGrid.DataSource.DataSet.FindField(cFieldOrg)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldOrg).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldOrg).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldDepartment)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Width:=cColumnWidth_4;
    if (DBGrid.DataSource.DataSet.FindField(cFieldDosPartName)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Width:=cColumnWidth_3;
    if (DBGrid.DataSource.DataSet.FindField(cFieldMeasComment)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasComment).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldMeasComment).Index].Width:=cColumnWidth_5;
    if (DBGrid.DataSource.DataSet.FindField(cFieldPersNumber)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldPersNumber).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldPersNumber).Index].Width:=cColumnWidth_5;
    if (DBGrid.DataSource.DataSet.FindField(cFieldFio)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldFio).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldFio).Index].Width:=cColumnWidth_3;
    if (DBGrid.DataSource.DataSet.FindField(cFieldTldUser)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldUser).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldUser).Index].Width:=cColumnWidth_5;

    if (DBGrid.DataSource.DataSet.FindField(cFieldLastMeasComment)<>nil) AND (DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Visible) then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Width:=cColumnWidth_5;

    for i := 0 to DBGrid.Columns.Count-1 do
    begin
      DBGrid.Columns[i].Title.Font.Size:=cGridFontSize;
      DBGrid.Columns[i].Alignment:=taLeftJustify;

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

  PanelDB.Width:=PanelMeasLeft.Width+cPanelDBWidthAdd;
end;

procedure TMainForm.ResizeDosPanelLeft(DBGrid: TDbGridEh; MemTable: TMemTableEh);
const
  cAddFieldSize = 26;
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

    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Title.Caption:=Format(' %s',[rsDosimeter]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Title.Caption:=Format(' %s',[rsDosimeterType]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringState).Index].Title.Caption:=Format(' %s',[rsFltDosStatus]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k1).Index].Title.Caption:=Format(' %s',[cK1]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k2).Index].Title.Caption:=Format(' %s',[cK2]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k3).Index].Title.Caption:=Format(' %s',[cK3]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k4).Index].Title.Caption:=Format(' %s',[cK4]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k5).Index].Title.Caption:=Format(' %s',[cK5]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_kgn).Index].Title.Caption:=Format(' %s',[cKgn]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Title.Caption:=Format(' %s',[rsFltPart]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Title.Caption:=Format(' %s',[rsSmRegistrationDate]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Title.Caption:=Format(' %s',[rsSmVerificationDate]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldOrg).Index].Title.Caption:=Format(' %s',[rsFltOrg]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Title.Caption:=Format(' %s',[rsFltDep]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Title.Caption:=Format(' %s',[rsSmLastMeasComment]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Title.Caption:=Format(' %s',[rsSmLastMeasStatus]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Title.Caption:=Format(' %s',[rsSmLastMeasTime]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldID).Index].Title.Caption:=Format(' %s',[rsSmTldID]);

    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Footer.ValueType := fvtStaticText;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Footer.Value:=Format('%s - %d',[rsSmDosimeters,DBGrid.DataSource.DataSet.RecordCount]);

    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Visible:=true;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosID).Index].Visible:=false;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPostfix).Index].Visible:=false;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible:=DosColumnDosType;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosTypeID).Index].Visible:=false;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringState).Index].Visible:=DosColumnDosState;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Visible:=false;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k1).Index].Visible:=DosColumnk1;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k2).Index].Visible:=DosColumnk2;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k3).Index].Visible:=DosColumnk3;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k4).Index].Visible:=DosColumnk4;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k5).Index].Visible:=DosColumnk5;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_kgn).Index].Visible:=DosColumnkgn;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldPartID).Index].Visible:=false;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Visible:=DosColumnPartID;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Visible:=DosColumnRegTime;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Visible:=DosColumnVerTime;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldOrg).Index].Visible:=DosColumnOrg;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Visible:=DosColumnDep;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasResult).Index].Visible:=False;

    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Visible:=DosColumnLastMeasTime;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Visible:=DosColumnLastMeasResult;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Visible:=DosColumnLastMeasComment;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible:=DosColumnTldID;

    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldTldID).Index].Width:=cColumnWidth_3;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Width:=cColumnWidth_5;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Width:=cColumnWidth_4;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringState).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringState).Index].Width:=cColumnWidth_6;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosStatus).Index].Width:=cColumnWidth_1;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k1).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k1).Index].Width:=cColumnWidth_2;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k2).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k2).Index].Width:=cColumnWidth_2;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k3).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k3).Index].Width:=cColumnWidth_2;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k4).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k4).Index].Width:=cColumnWidth_2;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k5).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_k5).Index].Width:=cColumnWidth_2;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_kgn).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cField_kgn).Index].Width:=cColumnWidth_2;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Width:=cColumnWidth_3;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Width:=cColumnWidth_5;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Width:=cColumnWidth_4;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldOrg).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldOrg).Index].Width:=cColumnWidth_4;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Width:=cColumnWidth_4;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldStringValidity).Index].Width:=cColumnWidth_6;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Width:=cColumnWidth_5;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Width:=cColumnWidth_6;

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

  PanelDB.Width:=PanelDosLeft.Width+cPanelDBWidthAdd;
end;

procedure TMainForm.ParsingCMDParameters;
var
  i,j,k: integer;
  StParams: String;  // строка с параметрами введенными пользовталем
  StParamsU: String; // строка с параметрами переведенная в верхний регистре
begin
// осуществляем разбор параметров с которыми была запущена программа
  for i := 1 to ParamCount do  // запускаем цикл начиная с 1 т.к. нулевой парметр это путь к .exe файлу, он нам не нужен.
  begin
    StParams:=StParams+ParamStr(i)+' ';      // формируем строку с параметрами и дописываем в конец строки пробел, он будет символом конца значения параметра (имена пользователей и пароли не должны содержать пробелы!)
  end;
    StParamsU:=UpperCase(StParams);          // переводим строку в верхний регистр
// имя пользователя
  j:=Pos('/USER:', StParamsU);             // запиминаем позицию искомого параметра (имя пользователя)
  if j>0 then
  begin
    k:=PosEx(' ',StParams,j);              // находим символ конца параметра (пробел)
    CMDParUserName:=copy(StParams,j+6,k-j-6);  // копируем имя пользователя в соответствующую перемнную
    UseUserNameCMDPar:=True;                // если указано имя пользователя в параметрах, то взводим флаг использования параметров в true
  end;
// пароль
  j:=Pos('/PASSWORD:', StParamsU);         // запиминаем позицию искомого параметра (пароль)
  if j>0 then
  begin
    k:=PosEx(' ',StParams,j);
    CMDParPass:=copy(StParams,j+10,k-j-10);// копируем пароль в соответствующую перемнную
  end;

  j:=Pos('/DEVELOPERMODE', StParamsU);     // запиминаем позицию искомого параметра (ражим разработчика)
  if j>0 then
  begin
    CMDDeveloperMode:=True;
  end;
end;

procedure TMainForm.pmCalibrationClick(Sender: TObject);
begin
  StartMeas(cStartCalibration);
end;

procedure TMainForm.pmBurningClick(Sender: TObject);
begin
  StartMeas(cBurning);
end;

procedure TMainForm.pmGradingClick(Sender: TObject);
begin
  StartMeas(cGrading);
end;

procedure TMainForm.pmIrradiationClick(Sender: TObject);
begin
  StartMeas(cIrradiation);
end;

procedure TMainForm.pmRegistrationClick(Sender: TObject);
begin
  StartMeas(cRegistration);
end;

procedure TMainForm.pmRptDosSaveAsClick(Sender: TObject);
begin
  OpenDozaReportBuilder(cReport_tld_dosimeter_coef_pdf,DBGridEhDos,orptSaveAs,orpsDosList);
end;

procedure TMainForm.pmRptDosSaveClick(Sender: TObject);
begin
  OpenDozaReportBuilder(cReport_tld_dosimeter_coef_pdf,DBGridEhDos,orptSave,orpsDosList);
end;

procedure TMainForm.pmRptDosShowAndSaveClick(Sender: TObject);
begin
  OpenDozaReportBuilder(cReport_tld_dosimeter_coef_pdf,DBGridEhDos,orptSaveAndShow,orpsDosList);
end;

procedure TMainForm.pmRptMeasSaveAsClick(Sender: TObject);
begin
  OpenDozaReportBuilder(cReport_tld_dosimeter_res_pdf,DBGridEhProcess,orptSaveAs,orpsMeasList);
end;

procedure TMainForm.pmRptMeasSaveClick(Sender: TObject);
begin
  OpenDozaReportBuilder(cReport_tld_dosimeter_res_pdf,DBGridEhProcess,orptSave,orpsMeasList);
end;

procedure TMainForm.pmRptMeasShowAndSaveClick(Sender: TObject);
begin
  OpenDozaReportBuilder(cReport_tld_dosimeter_res_pdf,DBGridEhProcess,orptSaveAndShow,orpsMeasList);
end;

procedure TMainForm.pmSingleMeasClick(Sender: TObject);
begin
  StartMeas(cStartSingleMeas);
end;

procedure TMainForm.pmTestingClick(Sender: TObject);
begin
  FStartTestingCommentTime:=Now;
  OnCommandLog(TimeToStr(Now)+' : -> ', rsLogStartTest,'',cMsgInf,cMsgPriorityInf);
  StartMeas(cTesting);
end;

procedure TMainForm.pmSeriaMeasClick(Sender: TObject);
begin
  StartMeas(cStartSeriaMeas);
end;

procedure TMainForm.ppCalcKDosDelClick(Sender: TObject);
var
  i       : integer;
begin
  if DBGridEhCalcKDos.SelectedRows.Count > 0 then
  begin
    for i := 0 to DBGridEhCalcKDos.SelectedRows.Count-1 do
    begin
      DBGridEhCalcKDos.DataSource.DataSet.GotoBookmark(DBGridEhCalcKDos.SelectedRows.Items[i]);
      DBGridEhCalcKDos.DataSource.DataSet.Delete;
    end;
    StartCalibration;

  end
  else
    MessageDlg(rsNotChooseMeasure,mtWarning,[mbOK], 0);
end;

procedure TMainForm.ppCalibrRemoveFromListClick(Sender: TObject);
var
  i       : integer;
  measId  : String;
begin
  if DBGridEhCalcKDos.SelectedRows.Count > 0 then
  begin
    for i := 0 to DBGridEhCalcKDos.SelectedRows.Count-1 do
    begin
      DBGridEhCalcKDos.DataSource.DataSet.GotoBookmark(DBGridEhCalcKDos.SelectedRows.Items[i]);
      measId:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;

      TLDDataModule.ChangeMeasState(measId,cMeasStNormal);
      //DBGridEhCalcKDos.DataSource.DataSet.Delete;
    end;

    UpdateGridCalibrationFilter(FilterCalibrDosNumber);
    StartCalibration;
    //if CalibrationPressed then StartCalibration;
  end
  else
    MessageDlg(rsNotChooseMeasure,mtWarning,[mbOK], 0);

//  if DBGridEhCalcKDos.SelectedRows.Count = 0 then
//  begin
//    DropCalibrationParameters;
////    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_k1).Index].Footer.ValueType:=fvtNon;
////    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_k2).Index].Footer.ValueType:=fvtNon;
////    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_k3).Index].Footer.ValueType:=fvtNon;
////    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_k4).Index].Footer.ValueType:=fvtNon;
////    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_k5).Index].Footer.ValueType:=fvtNon;
////    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_kgn).Index].Footer.ValueType:=fvtNon;
//  end;
end;

procedure TMainForm.ppCBoxDosCheckAllClick(Sender: TObject);
begin
  GridSelectAll(DBGridEhDos);
end;

procedure TMainForm.ppCBoxDosDropAllClick(Sender: TObject);
begin
  GridDropAll(DBGridEhDos);
end;

procedure TMainForm.ppCBoxMeasProcessCheckAllClick(Sender: TObject);
begin
  GridSelectAll(DBGridEhProcess);
end;

procedure TMainForm.ppCBoxMeasProcessDropAllClick(Sender: TObject);
begin
  GridDropAll(DBGridEhProcess);
end;

procedure TMainForm.ppCBoxOnlyMeasCheckAllClick(Sender: TObject);
begin
  GridSelectAll(DBGridEhOnlyMeas);
end;

procedure TMainForm.ppCBoxOnlyMeasDropAllClick(Sender: TObject);
begin
  GridDropAll(DBGridEhOnlyMeas);
end;

procedure TMainForm.ppCheckMeasProcessBoxInvertClick(Sender: TObject);
var
  i,j: integer;
//  list: TList<integer>;
  list: array of integer;
begin
  if (DBGridEhOnlyMeas.SelectedRows.Count>0) AND (DBGridEhOnlyMeas.SelectedRows.Count<>DBGridEhOnlyMeas.RowCount-1) then
  begin
//    list:=TList<integer>.Create;
    SetLength(list,0);

    DBGridEhOnlyMeas.DataSource.DataSet.First;
    for i := 0 to DBGridEhOnlyMeas.RowCount-1 do
    begin
      if DBGridEhOnlyMeas.SelectedRows.CurrentRowSelected then
      begin
        SetLength(list,length(list)+1);
        list[high(list)]:=DBGridEhOnlyMeas.DataSource.DataSet.RecNo;
//        list.Add(DBGridEhOnlyMeas.DataSource.DataSet.RecNo);
      end;
      DBGridEhOnlyMeas.DataSource.DataSet.Next;
    end;

    DBGridEhOnlyMeas.SelectedRows.SelectAll;

    DBGridEhOnlyMeas.DataSource.DataSet.First;
    DBGridEhOnlyMeas.DataSource.DataSet.GotoBookmark(DBGridEhOnlyMeas.SelectedRows.Items[0]);
    for i := 0 to DBGridEhOnlyMeas.RowCount-1 do
    begin
      for j := low(list) to high(list) do
      begin
        if (list[j] = DBGridEhOnlyMeas.DataSource.DataSet.RecNo) then
        begin
          DBGridEhOnlyMeas.SelectedRows.CurrentRowSelected:=false;
        end;
      end;
      DBGridEhOnlyMeas.DataSource.DataSet.Next;
    end;

    DBGridEhOnlyMeas.DataSource.DataSet.First;

//    list.Destroy;
  end
  else if (DBGridEhOnlyMeas.SelectedRows.Count = 0) then
    GridSelectAll(DBGridEhOnlyMeas)
  else
    GridDropAll(DBGridEhOnlyMeas);
end;

procedure TMainForm.ppDosGridCalibrationClick(Sender: TObject);
begin
  OpenCalibrForm;
end;

procedure TMainForm.ppDosGridDecommissionedClick(Sender: TObject);
begin
  DecommissionDos;
end;

procedure TMainForm.ppDosStatusDropWarningClick(Sender: TObject);
begin
  SetUserWarning(False);
end;

procedure TMainForm.ppMeasSaveToFileClick(Sender: TObject);
begin
  ExportToCSV(DBGridEhOnlyMeas,ppMeasSaveToFileWithiDetDose.Checked);
end;

procedure TMainForm.ppMeasSaveToFileWithiDetDoseClick(Sender: TObject);
begin
  SaveBoolToIni(cSectionSettings,cSettingsReportWithDets,ppMeasSaveToFileWithiDetDose.Checked);
end;

procedure TMainForm.ppProcessGridCalibrationClick(Sender: TObject);
begin
  if DBGridEhOnlyMeas.SelectedRows.Count > 0 then KDosimeterForm.Show;
end;

procedure TMainForm.ppProcessGridDelClick(Sender: TObject);
begin
  MarkToDelMeasurement;
end;

procedure TMainForm.ppProcessGridRecalcClick(Sender: TObject);
begin
  RecalcGroupDose;
end;

procedure TMainForm.ppProcessGridSendToCalibrationClick(Sender: TObject);
var
  temp: word;
begin
  if DBGridEhProcess.SelectedRows.Count > 0 then
    if CheckValidMeasToCalibr(DBGridEhProcess) then
      SendToCalibrW.ShowModal
    else
    begin

      temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s',[rsMsgFoundInvalidMeasToCalibr]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

      case temp of
        mrYes: SendToCalibrW.ShowModal;

      end;
    end
  else
    MessageDlg(rsNotChooseMeasure,mtWarning,[mbOK], 0);
end;

procedure TMainForm.ppProcessGridSendToModelClick(Sender: TObject);
var
  path: String;
begin
  if Assigned(Dosimeter) then
  begin
    path:=ExtractFileDir(Application.ExeName)+PathDelim+'Model';
    SaveDosTXTResults(Dosimeter.FullNumber,path);
    ModelW.EditChartPeak.Text:=path+PathDelim+Dosimeter.FullNumber+'_d1'+'.txt';
    ModelW.Show;
  end;
end;

procedure TMainForm.ppProcessSaveToFileClick(Sender: TObject);
begin
  ExportToCSV(DBGridEhProcess,ppProcessSaveToFileWithiDetDose.Checked);
end;

procedure TMainForm.ppProcessSaveToFileWithiDetDoseClick(Sender: TObject);
begin
  SaveBoolToIni(cSectionSettings,cSettingsReportWithDets,ppProcessSaveToFileWithiDetDose.Checked);
end;

procedure TMainForm.GridDropAll(Value: TDbGridEh);
begin
  Value.SelectedRows.Clear;
  //TDbGridEh(Value).SelectedRows.Clear;
end;

procedure TMainForm.GridSelectAll(Value: TDbGridEh);
begin
  Value.SelectedRows.SelectAll;
  //TDbGridEh(Value).SelectedRows.SelectAll;
end;

procedure TMainForm.GridBeforePopupMenuShow(Value: TDbGridEh);
begin
  if not Start then
  begin
    if TDbGridEh(Value).SelectedRows.Count = 1 then
    begin

      TDbGridEh(Value).SelectedRows.Clear;
      TDbGridEh(Value).SelectedRows.CurrentRowSelected:=true;

      case PageControlMain.ActivePage.PageIndex of
        cPageMeasIndex,cPageProcessIndex:
        begin
          GetMeasData;
        end;
        cPageDosIndex:
        begin
          GetDosData;
        end;
      end;
    end;
  end;
end;

function TMainForm.IsGroupDosOperations: boolean;
begin
  if DBGridEhDos.SelectedRows.Count>1 then
  begin
    BtnDecommissionDos.Visible:=false;
    TabSheetDosNumber.TabVisible:=false;
    TabSheetDosGroupOperations.TabVisible:=true;
    FGroupDosOperation:=true;
    Result:=true;
  end
  else
  begin
    BtnDecommissionDos.Visible:=true;
    TabSheetDosNumber.TabVisible:=true;
    TabSheetDosGroupOperations.TabVisible:=false;
    FGroupDosOperation:=false;
    Result:=false;
  end;
end;

procedure TMainForm.SelectColorPanelFilter(aColor: TColor);
begin
  PanelMeasLeftFilter.Color:=aColor;

  PanelDosLeftFilter.Color:=aColor;
//  PanelDosFilterBtn.Color:=aColor;

  PanelProcessLeftFilter.Color:=aColor;

  PanelCalibrLeftFilter.Color:=aColor;
//  PanelProcessFilterBtn.Color:=aColor;
end;

procedure TMainForm.SeriesK1Click(Sender: TChartSeries; ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DBGridEhCalcKDos.SelectedRows.Clear;
//  DBGridEhCalcKDos.DataSource.DataSet.Locate(cFieldDosMeasID,SeriesK1.XLabel[ValueIndex],[]);
  DBGridEhCalcKDos.SelectedRows.CurrentRowSelected:=true;

  GetCalibrData;
end;

procedure TMainForm.SeriesKSClick(Sender: TChartSeries; ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DBGridEhCalcKDos.SelectedRows.Clear;
//  DBGridEhCalcKDos.DataSource.DataSet.Locate(cFieldDosMeasID,SeriesKS.XLabel[ValueIndex],[]);
  DBGridEhCalcKDos.SelectedRows.CurrentRowSelected:=true;

  GetCalibrData;
end;

procedure TMainForm.SetMeasColumnD(const Value: boolean);
begin
  FMeasColumnD:=Value;

  sppMeasColD_Err.Visible:=Value;
  sppMeasColD_Err.Checked:=Value;
  MeasColumnD_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasD,Value);
end;

procedure TMainForm.SetMeasColumnDepartment(const Value: boolean);
begin
  FMeasColumnDepartment:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasDepartment,Value);
end;

procedure TMainForm.SetMeasColumnLastMeasComment(const Value: boolean);
begin
  FMeasColumnLastMeasComment:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasLastMeasComment,Value);
end;

procedure TMainForm.SetMeasColumnLastMeasTime(const Value: boolean);
begin
  FMeasColumnLastMeasTime:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasLastMeasTime,Value);
end;

procedure TMainForm.SetMeasColumnDose(const Value: boolean);
begin
  FMeasColumnDose:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasDose,Value);
end;

procedure TMainForm.SetMeasColumnDosReg(const Value: boolean);
begin
  FMeasColumnDosReg:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasDosReg,Value);
end;

procedure TMainForm.SetMeasColumnDosStatus(const Value: boolean);
begin
  FMeasColumnDosStatus:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasDosStatus,Value);
end;

procedure TMainForm.SetMeasColumnDosType(const Value: boolean);
begin
  FMeasColumnDosType:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasDosType,Value);
end;

procedure TMainForm.SetMeasColumnDosVer(const Value: boolean);
begin
  FMeasColumnDosVer:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasDosVer,Value);
end;

procedure TMainForm.SetMeasColumnD_Err(const Value: boolean);
begin
  FMeasColumnD_Err := Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasD_Err,Value);
end;

procedure TMainForm.SetMeasColumnFIO(const Value: boolean);
begin
  FMeasColumnFIO:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasFIO,Value);
end;

procedure TMainForm.SetMeasColumnH007(const Value: boolean);
begin
  FMeasColumnH007:=Value;

  sppMeasColH007_Err.Visible:=Value;
  sppMeasColH007_Err.Checked:=Value;
  MeasColumnH007_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasH007,Value);
end;

procedure TMainForm.SetMeasColumnH007_Err(const Value: boolean);
begin
  FMeasColumnH007_Err := Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasH007_Err,Value);
end;

procedure TMainForm.SetMeasColumnHp007(const Value: boolean);
begin
  FMeasColumnHp007:=Value;

  sppMeasColHp007_Err.Visible:=Value;
  sppMeasColHp007_Err.Checked:=Value;
  MeasColumnHp007_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasHp007,Value);
end;

procedure TMainForm.SetMeasColumnHp007_Err(const Value: boolean);
begin
  FMeasColumnHp007_Err := Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasHp007_Err,Value);
end;

procedure TMainForm.SetMeasColumnHp10g(const Value: boolean);
begin
  FMeasColumnHp10g:=Value;

  sppMeasColHp10g_Err.Visible:=Value;
  sppMeasColHp10g_Err.Checked:=Value;
  MeasColumnHp10g_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasHp10g,Value);
end;

procedure TMainForm.SetMeasColumnHp10g_Err(const Value: boolean);
begin
  FMeasColumnHp10g_Err := Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasHp10g_Err,Value);
end;

procedure TMainForm.SetMeasColumnHp10n(const Value: boolean);
begin
  FMeasColumnHp10n:=Value;

  sppMeasColHp10n_Err.Visible:=Value;
  sppMeasColHp10n_Err.Checked:=Value;
  MeasColumnHp10n_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasHp10n,Value);
end;

procedure TMainForm.SetMeasColumnHp10n_Err(const Value: boolean);
begin
  FMeasColumnHp10n_Err := Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasHp10n_Err,Value);
end;

procedure TMainForm.SetMeasColumnHp3(const Value: boolean);
begin
  FMeasColumnHp3:=Value;

  sppMeasColHp3_Err.Visible:=Value;
  sppMeasColHp3_Err.Checked:=Value;
  MeasColumnHp3_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasHp3,Value);
end;

procedure TMainForm.SetMeasColumnHp3_Err(const Value: boolean);
begin
  FMeasColumnHp3_Err := Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasHp3_Err,Value);
end;

procedure TMainForm.SetMeasColumnHStar(const Value: boolean);
begin
  FMeasColumnHStar:=Value;

  sppMeasColHStar_Err.Visible:=Value;
  sppMeasColHStar_Err.Checked:=Value;
  MeasColumnHStar_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasHStar,Value);
end;

procedure TMainForm.SetMeasColumnHStar_Err(const Value: boolean);
begin
  FMeasColumnHStar_Err := Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasHstar_Err,Value);
end;

procedure TMainForm.SetMeasColumnKSI(const Value: boolean);
begin
  FMeasColumnKSI:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasKSI,Value);
end;

procedure TMainForm.SetMeasColumnMeasComment(const Value: boolean);
begin
  FMeasColumnMeasComment:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasComment,Value);
end;

procedure TMainForm.SetMeasColumnMeasDateTime(const Value: boolean);
begin
  FMeasColumnMeasDateTime:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasDateTime,Value);
end;

procedure TMainForm.SetMeasColumnMeasID(const Value: boolean);
begin
  FMeasColumnMeasID:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasID,Value);
end;

procedure TMainForm.SetMeasColumnMeasValidity(const Value: boolean);
begin
  FMeasColumnMeasValidity:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasValidity,Value);
end;

procedure TMainForm.SetMeasColumnOrganization(const Value: boolean);
begin
  FMeasColumnOrganization:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasOrganization,Value);
end;

procedure TMainForm.SetMeasColumnPartID(const Value: boolean);
begin
  FMeasColumnPartID:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasPartID,Value);
end;

procedure TMainForm.SetMeasColumnPersNumber(const Value: boolean);
begin
  FMeasColumnPersNumber:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasPersNumber,Value);
end;

procedure TMainForm.SetMeasColumnTldID(const Value: boolean);
begin
  FMeasColumnTldID:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasTldID,Value);
end;

procedure TMainForm.SetMeasColumnTLDUser(const Value: boolean);
begin
  FMeasColumnTLDUser:=Value;
  SaveBoolToIni(cSectionGridColumnsMeas,cColumnMeasTLDUser,Value);
end;

procedure TMainForm.SetAutoReset(const Value: boolean);
begin
  FAutoReset := Value;
end;

procedure TMainForm.SetCalibrationPressed(const Value: boolean);
begin
  FCalibrationPressed:=Value;

  LabelCalibrKErr.Visible:=false;
  BtnCalibrAccept.Enabled:=Value;
  DateTimePickerCalibr.Enabled:=Value;
end;

procedure TMainForm.SetCalibrColumnD(const Value: boolean);
begin
  FCalibrColumnD:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrD,Value);
end;

procedure TMainForm.SetCalibrColumnDepartment(const Value: boolean);
begin
  FCalibrColumnDepartment:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrDepartment,Value);
end;

procedure TMainForm.SetCalibrColumnDose(const Value: boolean);
begin
  FCalibrColumnDose:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrDose,Value);
end;

procedure TMainForm.SetCalibrColumnDosReg(const Value: boolean);
begin
  FCalibrColumnDosReg:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrDosReg,Value);
end;

procedure TMainForm.SetCalibrColumnDosStatus(const Value: boolean);
begin
  FCalibrColumnDosStatus:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrDosStatus,Value);
end;

procedure TMainForm.SetCalibrColumnDosType(const Value: boolean);
begin
  FCalibrColumnDosType:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrDosType,Value);
end;

procedure TMainForm.SetCalibrColumnDosVer(const Value: boolean);
begin
  FCalibrColumnDosVer:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrDosVer,Value);
end;

procedure TMainForm.SetCalibrColumnD_Err(const Value: boolean);
begin
  FCalibrColumnD_Err:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrD_Err,Value);
end;

procedure TMainForm.SetCalibrColumnFIO(const Value: boolean);
begin
  FCalibrColumnFIO:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrFIO,Value);
end;

procedure TMainForm.SetCalibrColumnH007(const Value: boolean);
begin
  FCalibrColumnH007:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrH007,Value);
end;

procedure TMainForm.SetCalibrColumnH007_Err(const Value: boolean);
begin
  FCalibrColumnH007_Err:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrH007_Err,Value);
end;

procedure TMainForm.SetCalibrColumnHp007(const Value: boolean);
begin
  FCalibrColumnHp007:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrHp007,Value);
end;

procedure TMainForm.SetCalibrColumnHp007_Err(const Value: boolean);
begin
  FCalibrColumnHp007_Err:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrHp007_Err,Value);
end;

procedure TMainForm.SetCalibrColumnHp10g(const Value: boolean);
begin
  FCalibrColumnHp10g:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrHp10g,Value);
end;

procedure TMainForm.SetCalibrColumnHp10g_Err(const Value: boolean);
begin
  FCalibrColumnHp10g_Err:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrHp10g_Err,Value);
end;

procedure TMainForm.SetCalibrColumnHp10n(const Value: boolean);
begin
  FCalibrColumnHp10n:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrHp10n,Value);
end;

procedure TMainForm.SetCalibrColumnHp10n_Err(const Value: boolean);
begin
  FCalibrColumnHp10n_Err:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrHp10n_Err,Value);
end;

procedure TMainForm.SetCalibrColumnHp3(const Value: boolean);
begin
  FCalibrColumnHp3:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrHp3,Value);
end;

procedure TMainForm.SetCalibrColumnHp3_Err(const Value: boolean);
begin
  FCalibrColumnHp3_Err:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrHp3_Err,Value);
end;

procedure TMainForm.SetCalibrColumnHStar(const Value: boolean);
begin
  FCalibrColumnHStar:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrHStar,Value);
end;

procedure TMainForm.SetCalibrColumnHStar_Err(const Value: boolean);
begin
  FCalibrColumnHStar_Err:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrHStar_Err,Value);
end;

procedure TMainForm.SetCalibrColumnK1(const Value: boolean);
begin
  FCalibrColumnK1:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrK1,Value);
end;

procedure TMainForm.SetCalibrColumnK2(const Value: boolean);
begin
  FCalibrColumnK2:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrK2,Value);
end;

procedure TMainForm.SetCalibrColumnK3(const Value: boolean);
begin
  FCalibrColumnK3:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrK3,Value);
end;

procedure TMainForm.SetCalibrColumnK4(const Value: boolean);
begin
  FCalibrColumnK4:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrK4,Value);
end;

procedure TMainForm.SetCalibrColumnK5(const Value: boolean);
begin
  FCalibrColumnK5:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrK5,Value);
end;

procedure TMainForm.SetCalibrColumnKgn(const Value: boolean);
begin
  FCalibrColumnKgn:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrKgn,Value);
end;

procedure TMainForm.SetCalibrColumnKSI(const Value: boolean);
begin
  FCalibrColumnKSI:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrKSI,Value);
end;

procedure TMainForm.SetCalibrColumnLastMeasComment(const Value: boolean);
begin
  FCalibrColumnLastMeasComment:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrLastMeasComment,Value);
end;

procedure TMainForm.SetCalibrColumnMeasComment(const Value: boolean);
begin
  FCalibrColumnMeasComment:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrComment,Value);
end;

procedure TMainForm.SetCalibrColumnMeasDateTime(const Value: boolean);
begin
  FCalibrColumnMeasDateTime:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrDateTime,Value);
end;

procedure TMainForm.SetCalibrColumnMeasID(const Value: boolean);
begin
  FCalibrColumnMeasID:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrID,Value);
end;

procedure TMainForm.SetCalibrColumnMeasValidity(const Value: boolean);
begin
  FCalibrColumnMeasValidity:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrValidity,Value);
end;

procedure TMainForm.SetCalibrColumnOrganization(const Value: boolean);
begin
  FCalibrColumnOrganization:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrOrganization,Value);
end;

procedure TMainForm.SetCalibrColumnPartID(const Value: boolean);
begin
  FCalibrColumnPartID:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrPartID,Value);
end;

procedure TMainForm.SetCalibrColumnPersNumber(const Value: boolean);
begin
  FCalibrColumnPersNumber:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrPersNumber,Value);
end;

procedure TMainForm.SetCalibrColumnTldID(const Value: boolean);
begin
  FCalibrColumnTldID:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrTldID,Value);
end;

procedure TMainForm.SetCalibrColumnTLDUser(const Value: boolean);
begin
  FCalibrColumnTLDUser:=Value;
  SaveBoolToIni(cSectionGridColumnsCalibr,cColumnCalibrTLDUser,Value);
end;

procedure TMainForm.SetCOMName(aCOMName: String);
begin
  FCOMName:=aCOMName;
end;

procedure TMainForm.SetControlComment(const Value: String);
begin
  FControlComment := Value;
end;

procedure TMainForm.SetDetComment(LabelComment: TLabel; DComment: String);
begin
  LabelComment.Caption:=DComment;
end;

procedure TMainForm.SetDetEdit(EditD: TEdit; Value: String; DState: TDetectorState);
begin
case DState of
    stDetNotMeasured:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetWaitLoad:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetWaitMeas:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetMeasInProgress:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetMeasFinished:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clWhite;
    end;
    stDetMeasError:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clYellow;
    end;
    stDetLost:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetBroken:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetSkiped:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetMeasStopped:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetProcessedError:
    begin
      EditD.Text:=Format('%s',[cEmptyData]);
      EditD.Color:=clYellow;
    end;
    stDetProcessedWarning:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clSkyBlue;
    end;
    stDetProcessed:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clBtnFace;
    end;
    stDetAcceptedError:
    begin
      EditD.Text:=Format('%s',[cEmptyData]);
      EditD.Color:=clBtnFace;
    end;
    stDetAcceptedWarning:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clBtnFace;
    end;
    stDetAccepted:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clBtnFace;
    end;
  end;
end;

procedure TMainForm.SetDetEdit(EditD: TEdit; Value: String; Err: String; DState: TDetectorState);
begin
  case DState of
    stDetNotMeasured:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetWaitLoad:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetWaitMeas:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetMeasInProgress:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetMeasFinished:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clWhite;
    end;
    stDetMeasError:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clYellow;
    end;
    stDetLost:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetBroken:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetSkiped:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetMeasStopped:
    begin
      EditD.Text:=cEmptyData;
      EditD.Color:=clSilver;
    end;
    stDetProcessedError:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clYellow;
    end;
    stDetProcessedWarning:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clSkyBlue;
    end;
    stDetProcessed:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clBtnFace;
    end;
    stDetAcceptedError:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clBtnFace;
    end;
    stDetAcceptedWarning:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clBtnFace;
    end;
    stDetAccepted:
    begin
      EditD.Text:=Format('%s %s',[Value,rsUntmSv]);
      EditD.Color:=clBtnFace;
    end;
  end;
end;

procedure TMainForm.SetDetStateEdit(EditDState: TEdit; DState: TDetectorState);
begin
  case DState of
    stDetNotMeasured:
    begin
      EditDState.Text:=rsSmNotMeasured;
      EditDState.Color:=clSilver;
    end;
    stDetWaitLoad:
    begin
      EditDState.Text:=rsSmWaitingLoad;
      EditDState.Color:=clSilver;
    end;
    stDetWaitMeas:
    begin
      EditDState.Text:=rsSmWaitingMeas;
      EditDState.Color:=clSilver;
    end;
    stDetMeasInProgress:
    begin
      EditDState.Text:=rsSmMeasInProcess;
      EditDState.Color:=clSilver;
    end;
    stDetMeasFinished:
    begin
      EditDState.Text:=rsSmMeasFinished;
      EditDState.Color:=clWhite;
    end;
    stDetMeasError:
    begin
      EditDState.Text:=rsSmMeasError;
      EditDState.Color:=clYellow;
    end;
    stDetLost:
    begin
      EditDState.Text:=rsSmDetLost;
      EditDState.Color:=clSilver;
    end;
    stDetBroken:
    begin
      EditDState.Text:=rsSmDetBroken;
      EditDState.Color:=clSilver;
    end;
    stDetSkiped:
    begin
      EditDState.Text:=rsSmDetSkipped;
      EditDState.Color:=clSilver;
    end;
    stDetMeasStopped:
    begin
      EditDState.Text:=rsSmMeasDosStopped;
      EditDState.Color:=clSilver;
    end;
    stDetProcessedError:
    begin
      EditDState.Text:=rsSmProcessedError;
      EditDState.Color:=clYellow;
    end;
    stDetProcessedWarning:
    begin
      EditDState.Text:=rsSmProcessedWarning;
      EditDState.Color:=clSkyBlue;
    end;
    stDetProcessed:
    begin
      EditDState.Text:=rsSmMeasSucceed;
      EditDState.Color:=clBtnFace;
    end;
    stDetAcceptedError:
    begin
      EditDState.Text:=rsSmProcessedError;
      EditDState.Color:=clBtnFace;
    end;
    stDetAcceptedWarning:
    begin
      EditDState.Text:=rsSmProcessedWarning;
      EditDState.Color:=clBtnFace;
    end;
    stDetAccepted:
    begin
      EditDState.Text:=rsSmMeasSucceed;
      EditDState.Color:=clBtnFace;
    end;
  end;

end;

procedure TMainForm.SetDeviceID(Value: integer);
begin
  if TLDDataModule.IsDeviceIdExist(Value) then
    FDeviceID:=Value
  else
    FDeviceID:=-1;

  // считываем параметры установки
  TLDDataModule.ReadTLDSettings(FDeviceID,FKSLevel,FKSDelta,FKFilter,FKDevice);
  ReadTLDSettings;
end;

procedure TMainForm.SetConstructiveVersion(Value: integer);
begin
  FConstructiveVersion:=Value;
end;

procedure TMainForm.SetDosCntAutoCreatePart(const Value: integer);
begin
  FDosCntAutoCreatePart:=Value;
end;

procedure TMainForm.SetSettingsSkipDetector(const Value: integer);
begin
  FSettingsSkipDetector:=Value;
end;

procedure TMainForm.SetDosColumnDep(const Value: boolean);
begin
  FDosColumnDep:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosDepartment,Value);
end;

procedure TMainForm.SetDosColumnLastMeasCommen(const Value: boolean);
begin
  FDosColumnLastMeasComment:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosLastMeasComment,Value);
end;

procedure TMainForm.SetDosColumnLastMeasResult(const Value: boolean);
begin
  FDosColumnLastMeasResult:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosLastMeasResult,Value);
end;

procedure TMainForm.SetDosColumnLastMeasTime(const Value: boolean);
begin
  FDosColumnLastMeasTime:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosLastMeasTime,Value);
end;

procedure TMainForm.SetDosColumnDosState(const Value: boolean);
begin
  FDosColumnDosState:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosStatus,Value);
end;

procedure TMainForm.SetDosColumnDosType(const Value: boolean);
begin
  FDosColumnDosType:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosType,Value);
end;

procedure TMainForm.SetDosColumnk1(const Value: boolean);
begin
  FDosColumnk1:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosk1,Value);
end;

procedure TMainForm.SetDosColumnk2(const Value: boolean);
begin
  FDosColumnk2:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosk2,Value);
end;

procedure TMainForm.SetDosColumnk3(const Value: boolean);
begin
  FDosColumnk3:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosk3,Value);
end;

procedure TMainForm.SetDosColumnk4(const Value: boolean);
begin
  FDosColumnk4:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosk4,Value);
end;

procedure TMainForm.SetDosColumnk5(const Value: boolean);
begin
  FDosColumnk5:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosk5,Value);
end;

procedure TMainForm.SetDosColumnkgn(const Value: boolean);
begin
  FDosColumnkgn:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDoskgn,Value);
end;

procedure TMainForm.SetDosColumnOrg(const Value: boolean);
begin
  FDosColumnOrg:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosOrganization,Value);
end;

procedure TMainForm.SetDosColumnPartID(const Value: boolean);
begin
  FDosColumnPartID:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosPartID,Value);
end;

procedure TMainForm.SetDosColumnRegTime(const Value: boolean);
begin
  FDosColumnRegTime:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosReg,Value);
end;

procedure TMainForm.SetDosColumnTldID(const Value: boolean);
begin
  FDosColumnTldID:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosTldID,Value);
end;

procedure TMainForm.SetDosColumnVerTime(const Value: boolean);
begin
  FDosColumnVerTime:=Value;
  SaveBoolToIni(cSectionGridColumnsDos,cColumnDosVer,Value);
end;

procedure TMainForm.SetDosShowFromAllDevices(const Value: boolean);
begin
  if FDosShowFromAllDevices <> Value then
  begin
    FDosShowFromAllDevices:=Value;
    LoadFilters;
    ReadFilterIni;
    UpdateAllGridPages;
  end;
end;

procedure TMainForm.SetDosTypeForQuery(const Value: String);
begin
  FDosTypeForQuery:=Value;
end;

procedure TMainForm.SetFilter(aFilter: String);
begin
  FFilter:=aFilter;
end;

procedure TMainForm.SetHideD1(aHide: boolean);
begin
  if FHideD1 <> aHide then
  begin
    FHideD1 := aHide;
    if HideD1 then
    begin
      PanelMeasDataD1.Height:=0;
      PanelMeasDataD1Chart.Height:=0;
      PanelMeasDataD1.Visible:=false;
      PanelMeasDataD1Chart.Visible:=false;
    end
    else
    begin
      PanelMeasDataD1.Visible:=true;
      PanelMeasDataD1Chart.Visible:=true;
    end;
  end;
end;

procedure TMainForm.SetHideD2(aHide: boolean);
begin
  if FHideD2 <> aHide then
  begin
    FHideD2 := aHide;
    if FHideD2 then
    begin
      PanelMeasDataD2.Height:=0;
      PanelMeasDataD2Chart.Height:=0;
      PanelMeasDataD2.Visible:=false;
      PanelMeasDataD2Chart.Visible:=false;
    end
    else
    begin
      PanelMeasDataD2.Visible:=true;
      PanelMeasDataD2Chart.Visible:=true;
    end;
  end;
end;

procedure TMainForm.SetHideD3(aHide: boolean);
begin
  if FHideD3 <> aHide then
  begin
    FHideD3 := aHide;
    if FHideD3 then
    begin
      PanelMeasDataD3.Height:=0;
      PanelMeasDataD3Chart.Height:=0;
      PanelMeasDataD3.Visible:=false;
      PanelMeasDataD3Chart.Visible:=false;
    end
    else
    begin
      PanelMeasDataD3.Visible:=true;
      PanelMeasDataD3Chart.Visible:=true;
    end;
  end;
end;

procedure TMainForm.SetHideD4(aHide: boolean);
begin
  if FHideD4 <> aHide then
  begin
    FHideD4 := aHide;
    if FHideD4 then
    begin
      PanelMeasDataD4.Height:=0;
      PanelMeasDataD4Chart.Height:=0;
      PanelMeasDataD4.Visible:=false;
      PanelMeasDataD4Chart.Visible:=false;
    end
    else
    begin
      PanelMeasDataD4.Visible:=true;
      PanelMeasDataD4Chart.Visible:=true;
    end;
  end;
end;

procedure TMainForm.SetIDForQuery(const Value: String);
begin
  FIDForQuery := Value;
  LblMeasDataDosNumberVal.Caption:=FIDForQuery;
end;

procedure TMainForm.SetIDMeasForQuery(const Value: String);
begin
  FIDMeasForQuery := Value;
end;

procedure TMainForm.SetInformation(const Value: boolean);
begin
  FInformation:=Value;
end;

procedure TMainForm.SetInterfaceByPermits;
var
  bRight   : boolean;
begin
  bRight:=AW.IsHaveIRight(crMain_Page_Processing);
    PageControlMain.Pages[cPageProcessIndex].TabVisible:=bRight;
    ppDosGridCalibration.Visible:=bRight;

  bRight:=AW.IsHaveIRight(crMain_Page_Dosimeters);
    PageControlMain.Pages[cPageDosIndex].TabVisible:=bRight;

  bRight:=AW.IsHaveIRight(crMain_Page_Settings);
    PageControlMain.Pages[cPageSettingsIndex].TabVisible:=bRight;

  bRight:=AW.IsHaveIRight(crMain_DataBase);
    TabSheetDataBase.TabVisible:=bRight;

  bRight:=AW.IsHaveIRight(crMain_DosimeterType);
    DosimeterTypeConstructorForm.CBoxDetsCnt.Enabled:=bRight;
    DosimeterTypeConstructorForm.CBoxMeasValue.Enabled:=bRight;
    DosimeterTypeConstructorForm.ComboBoxD1.Enabled:=bRight;
    DosimeterTypeConstructorForm.ComboBoxD2.Enabled:=bRight;
    DosimeterTypeConstructorForm.ComboBoxD3.Enabled:=bRight;
    DosimeterTypeConstructorForm.ComboBoxD4.Enabled:=bRight;
    DosimeterTypeConstructorForm.EditValErrK1_1.Enabled:=bRight;
    DosimeterTypeConstructorForm.EditValErrK2_1.Enabled:=bRight;
    DosimeterTypeConstructorForm.EditValErrK1_2.Enabled:=bRight;
    DosimeterTypeConstructorForm.EditValErrK2_2.Enabled:=bRight;
    DosimeterTypeConstructorForm.EditValErrK1_3.Enabled:=bRight;
    DosimeterTypeConstructorForm.EditValErrK2_3.Enabled:=bRight;
    DosimeterTypeConstructorForm.EditValErrK1_4.Enabled:=bRight;
    DosimeterTypeConstructorForm.EditValErrK2_4.Enabled:=bRight;
    DosimeterTypeConstructorForm.SpeedBtnDelDosPart.Enabled:=bRight;
    DosimeterTypeConstructorForm.SpeedBtnAddDosType.Enabled:=bRight;
    DosimeterTypeConstructorForm.BtnSaveChanges.Enabled:=bRight;

  bRight:=AW.IsHaveIRight(crMain_DetectorType);
    DetectorConstructorForm.EditPreHeatTime.Enabled:=bRight;
    DetectorConstructorForm.EditPreHeatTemp.Enabled:=bRight;
    DetectorConstructorForm.EditPreHeatSpeed.Enabled:=bRight;
    DetectorConstructorForm.EditMeasuringTime.Enabled:=bRight;
    DetectorConstructorForm.EditMeasuringTemp.Enabled:=bRight;
    DetectorConstructorForm.EditMeasuringSpeed.Enabled:=bRight;
    DetectorConstructorForm.EditBurnTime.Enabled:=bRight;
    DetectorConstructorForm.EditBurnTemp.Enabled:=bRight;
    DetectorConstructorForm.EditBurnSpeed.Enabled:=bRight;
    DetectorConstructorForm.EditFullTime.Enabled:=bRight;
    DetectorConstructorForm.CBoxMethod.Enabled:=bRight;
    DetectorConstructorForm.SpeedBtnDelDetType.Enabled:=bRight;
    DetectorConstructorForm.SpeedBtnAddDetType.Enabled:=bRight;
    DetectorConstructorForm.BtnSaveChanges.Enabled:=bRight;

  bRight:=AW.IsHaveIRight(crMain_OpenCalcWindow);
    SpeedBtnMeasDataWarningD1.Enabled:=bRight;
    SpeedBtnMeasDataWarningD2.Enabled:=bRight;
    SpeedBtnMeasDataWarningD3.Enabled:=bRight;
    SpeedBtnMeasDataWarningD4.Enabled:=bRight;
    SpeedBtnProcessDataWarningD1.Enabled:=bRight;
    SpeedBtnProcessDataWarningD2.Enabled:=bRight;
    SpeedBtnProcessDataWarningD3.Enabled:=bRight;
    SpeedBtnProcessDataWarningD4.Enabled:=bRight;

  bRight:=AW.IsHaveIRight(crMain_DosRegistration);
    SpeedExportDosimeters.Enabled:=bRight;
    SpeedBtnDosRegFromFile.Enabled:=bRight;
    SpeedBtnDosReg.Enabled:=bRight;

  bRight:=AW.IsHaveIRight(crMain_ServiceFunctions);
    CBoxSettingsShowOriginalKTV.Enabled:=bRight;
    CBoxSettingsShowGladeKTV.Enabled:=bRight;
    CBoxSettingsAutoResetDevice.Enabled:=bRight;
    CBoxSettingsUseAutoComment.Enabled:=bRight;
    MemoSettingsAutoComment.Enabled:=bRight;
    EditSettingsKSNormalValue.Enabled:=bRight;
    EditSettingsKSDeviation.Enabled:=bRight;
    EditSettingsKFilter.Enabled:=bRight;
    BtnSettingsSaveParameters.Enabled:=bRight;
    ButtonExportConfig.Enabled:=bRight;
    ButtonImportConfig.Enabled:=bRight;
    ButtonControlDevice.Enabled:=bRight;
    CBoxTestSourceUse.Enabled:=bRight;
    CBoxTestSourceTimeIncrease.Enabled:=bRight;
    CBoxTestWriteModbusLog.Enabled:=bRight;
    EditTestSourceTime.Enabled:=bRight;
    EditTestSourceKIncrease.Enabled:=bRight;
    EditTestSourceTimeIncreaseCycle.Enabled:=bRight;
    CBoxDosimeterTest.Enabled:=bRight;

  bRight:=AW.IsHaveIRight(crMain_DeleteDecommissionDos);

  bRight:=AW.IsHaveIRight(crMain_Calibration);
    pmCalibration.Visible:=bRight;
    ppMeasGridSendToCalibration.Visible:=bRight;
    ppProcessGridSendToCalibration.Visible:=bRight;
    TabSheetCalibration.TabVisible:=bRight;
    ppDosGridCalibration.Enabled:=bRight;
    BtnOpenCalibr.Enabled:=bRight;
    BtnOpenCalibrGroup.Enabled:=bRight;
    DosimeterPartForm.SpeedBtnSaveChanges.Enabled:=bRight;
    DosimeterPartForm.SpeedBtnDelDosPart.Enabled:=bRight;

  bRight:=AW.IsHaveIRight(crMain_DeleteDeletedMeas);
    BtnDeleteMarkedToDelMeas.Enabled:=bRight;

  bRight:=AW.IsHaveIRight(crMain_DeleteMeas);
    ppProcessGridDel.Enabled:=bRight;


  bRight:=AW.IsHaveIRight(crMain_DecommissionDos);
    ppDosGridDecommissioned.Enabled:=bRight;
    BtnDecommissionDos.Enabled:=bRight;
    BtnDecommissionDosGroup.Enabled:=bRight;

  bRight:=AW.IsHaveIRight(crMain_Page_Permit);
    TabSheetUserPermit.TabVisible:=bRight;

  bRight:=AW.IsHaveIRight(crMain_ChangeDosNumber);
    ppMeasChangeNumber.Enabled:=bRight;
    ppProcessChangeNumber.Enabled:=bRight;

  bRight:=AW.IsHaveIRight(crMain_Page_Meas_ShowDosParam);
    PageControlMeasDosPar.Visible:= bRight;

  bRight:=AW.IsHaveIRight(crALL_DOZA_MANUFACTURER);
    ButtonModel.Visible:=bRight;
end;

//procedure TMainForm.SetQueue(const Value: boolean);
//begin
//  if FQueue <> Value then
//  begin
//    FQueue:=Value;
//  end;
//end;

procedure TMainForm.SetKDevice(Value: double);
begin
  FKDevice:=Value;
end;

procedure TMainForm.SetKFilter(Value: double);
begin
  FKFilter:=Value;
end;

procedure TMainForm.SetKSDelta(Value: integer);
begin
  FKSDelta:=Value;
end;

procedure TMainForm.SetKSLevel(Value: integer);
begin
  FKSLevel:=Value;
end;

procedure TMainForm.SetOnlyMeasPage(const Value: boolean);
var
  i: integer;
begin
  FOnlyMeasPage:=Value;
  PageControlMain.ActivePageIndex:=cPageMeasIndex;

  for i := 1 to PageControlMain.PageCount-1 do
    PageControlMain.Pages[i].TabVisible:=not Value;
end;

procedure TMainForm.SetOpenFilterCalibrPanel(Value: boolean);
begin
  FOpenFilterCalibrPanel:=Value;

  if FOpenFilterCalibrPanel then
  begin
    PanelCalibrLeftFilter.Height := FFilterCalibrPanelHeight;
    SpeedBtnCalibrOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Up.bmp');
  end
  else
  begin
    PanelCalibrLeftFilter.Height := 0;
    SpeedBtnCalibrOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Down.bmp');
  end;
end;

procedure TMainForm.SetOpenFilterDosPanel(Value: boolean);
begin
  FOpenFilterDosPanel:=Value;

  if FOpenFilterDosPanel then
  begin
    PanelDosLeftFilter.Height := FFilterDosPanelHeight;
    SpeedBtnDosOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Up.bmp');
  end
  else
  begin
    PanelDosLeftFilter.Height := 0;
    SpeedBtnDosOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Down.bmp');
  end;
end;

procedure TMainForm.SetOpenFilterProcessPanel(Value: boolean);
begin
  FOpenFilterProcessPanel:=Value;

  if FOpenFilterProcessPanel then
  begin
    PanelProcessLeftFilter.Height := FFilterPanelHeight;
    SpeedBtnProcessOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Up.bmp');
  end
  else
  begin
    PanelProcessLeftFilter.Height := 0;
    SpeedBtnProcessOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Down.bmp');
  end;
end;

procedure TMainForm.SetUserWarning(SetWarning: boolean);
  procedure UpdateData;
  var
    index: integer;
  begin

    case PageControlMain.ActivePage.PageIndex of
      cPageMeasIndex:
      begin
        index:=DBGridEhOnlyMeas.DataSource.DataSet.RecNo;

        UpdateDosimeterResStatus;

        if IsLastMeasInDosimeter then UpdateDosimeterLastMeas;

        UpdateGridMeasAndProcessPages;

        DBGridEhOnlyMeas.DataSource.DataSet.RecNo:=index;
        DBGridEhOnlyMeas.SelectedRows.CurrentRowSelected:=true;
      end;
      cPageProcessIndex:
      begin
        index:=DBGridEhProcess.DataSource.DataSet.RecNo;

        UpdateDosimeterResStatus;
        UpdateDosimeterLastMeas;
        UpdateGridMeasAndProcessPages;

        DBGridEhProcess.DataSource.DataSet.RecNo:=index;
        DBGridEhProcess.SelectedRows.CurrentRowSelected:=true;
      end;
    end;

    GetMeasData;

    DBGridEhDos.DataSource.DataSet.Active:=false;
    DBGridEhDos.DataSource.DataSet.Active:=true;
  end;
begin
  if Assigned(Dosimeter) then
  begin
    if SetWarning then
    begin
      if UserWarningComment then
      begin
        if (SpeedBtnMeasUserWarning.Down) AND (SpeedBtnProcessUserWarning.Down) then
          UserWarningCommentForm.DefaultMsg:=Dosimeter.LastMeasComment
        else
          UserWarningCommentForm.DefaultMsg:=FLastUserWarning;

        UserWarningCommentForm.ShowModal;

        if UserWarningCommentForm.SaveBtnPressed then
        begin
          FLastUserWarning:=UserWarningCommentForm.EditUserMsg.Text;
          SaveFilterTextIni(cSectionSettings,cSettingsLastUserWarning,FLastUserWarning);
          Dosimeter.LastMeasComment:=FLastUserWarning;
          Dosimeter.Validity:=stDosMeasUserWarning;
          UpdateData;
        end;
      end
      else
      begin
        Dosimeter.Validity:=stDosMeasUserWarning;
        Dosimeter.LastMeasComment:=rsDosMeasForProcessing;
        UpdateData;
      end;
    end
    else
    begin
      Dosimeter.Validity:=Dosimeter.GetDosimeterValidity;
      Dosimeter.LastMeasComment:='';
      UpdateData;
    end;
  end;
end;

procedure TMainForm.SetUserWarningComment(const Value: boolean);
begin
  FUserWarningComment:=Value;
//  SaveBoolToIni(cSectionSettings,cUseUserWarningComment,Value);
end;

procedure TMainForm.SetPermitMask(const Value: int64);
begin
  if Value<>FPermitMask then
  begin
    FPermitMask:=Value;
  end;
  StatusBarPermit.Panels[0].Text := IntToHex(FPermitMask);
end;

procedure TMainForm.SetPermitSelectedRowUser(const Value: integer);
begin
  if Value<>FPermitSelectedRowUser then
  begin
    FPermitSelectedRowUser:=Value;
  end;
end;

procedure TMainForm.SetProcessColumnD(const Value: boolean);
begin
  FProcessColumnD:=Value;

  sppProcessColD_Err.Visible:=Value;
  sppProcessColD_Err.Checked:=Value;
  ProcessColumnD_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessD,Value);
end;

procedure TMainForm.SetProcessColumnDepartment(const Value: boolean);
begin
  FProcessColumnDepartment:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessDepartment,Value);
end;

procedure TMainForm.SetProcessColumnDose(const Value: boolean);
begin
  FProcessColumnDose:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessDose,Value);
end;

procedure TMainForm.SetProcessColumnDosReg(const Value: boolean);
begin
  FProcessColumnDosReg:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessDosReg,Value);
end;

procedure TMainForm.SetProcessColumnDosStatus(const Value: boolean);
begin
  FProcessColumnDosStatus:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessDosStatus,Value);
end;

procedure TMainForm.SetProcessColumnDosType(const Value: boolean);
begin
  FProcessColumnDosType:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessDosType,Value);
end;

procedure TMainForm.SetProcessColumnDosVer(const Value: boolean);
begin
  FProcessColumnDosVer:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessDosVer,Value);
end;

procedure TMainForm.SetProcessColumnD_Err(const Value: boolean);
begin
  FProcessColumnD_Err := Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessD_Err,Value);
end;

procedure TMainForm.SetProcessColumnFIO(const Value: boolean);
begin
  FProcessColumnFIO:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessFIO,Value);
end;

procedure TMainForm.SetProcessColumnH007(const Value: boolean);
begin
  FProcessColumnH007:=Value;

  sppProcessColH007_Err.Visible:=Value;
  sppProcessColH007_Err.Checked:=Value;
  ProcessColumnH007_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessH007,Value);
end;

procedure TMainForm.SetProcessColumnH007_Err(const Value: boolean);
begin
  FProcessColumnH007_Err := Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessH007_Err,Value);
end;

procedure TMainForm.SetProcessColumnHp007(const Value: boolean);
begin
  FProcessColumnHp007:=Value;

  sppProcessColHp007_Err.Visible:=Value;
  sppProcessColHp007_Err.Checked:=Value;
  ProcessColumnHp007_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessHp007,Value);
end;

procedure TMainForm.SetProcessColumnHp007_Err(const Value: boolean);
begin
  FProcessColumnHp007_Err := Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessHp007_Err,Value);
end;

procedure TMainForm.SetProcessColumnHp10g(const Value: boolean);
begin
  FProcessColumnHp10g:=Value;

  sppProcessColHp10g_Err.Visible:=Value;
  sppProcessColHp10g_Err.Checked:=Value;
  ProcessColumnHp10g_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessHp10g,Value);
end;

procedure TMainForm.SetProcessColumnHp10g_Err(const Value: boolean);
begin
  FProcessColumnHp10g_Err := Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessHp10g_Err,Value);
end;

procedure TMainForm.SetProcessColumnHp10n(const Value: boolean);
begin
  FProcessColumnHp10n:=Value;

  sppProcessColHp10n_Err.Visible:=Value;
  sppProcessColHp10n_Err.Checked:=Value;
  ProcessColumnHp10n_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessHp10n,Value);
end;

procedure TMainForm.SetProcessColumnHp10n_Err(const Value: boolean);
begin
  FProcessColumnHp10n_Err := Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessHp10n_Err,Value);
end;

procedure TMainForm.SetProcessColumnHStar(const Value: boolean);
begin
  FProcessColumnHStar:=Value;

  sppProcessColHStar_Err.Visible:=Value;
  sppProcessColHStar_Err.Checked:=Value;
  ProcessColumnHStar_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessHStar,Value);
end;

procedure TMainForm.SetProcessColumnHStar_Err(const Value: boolean);
begin
  FProcessColumnHStar_Err := Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessHStar_Err,Value);
end;

procedure TMainForm.SetProcessColumnKSI(const Value: boolean);
begin
  FProcessColumnKSI:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessKSI,Value);
end;

procedure TMainForm.SetProcessColumnMeasComment(const Value: boolean);
begin
  FProcessColumnMeasComment:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessComment,Value);
end;

procedure TMainForm.SetProcessColumnLastMeasComment(const Value: boolean);
begin
  FProcessColumnLastMeasComment:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessLastMeasComment,Value);
end;

procedure TMainForm.SetProcessColumnLastMeasTime(const Value: boolean);
begin
  FProcessColumnLastMeasTime:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessLastMeasTime,Value);
end;

procedure TMainForm.SetProcessColumnTldID(const Value: boolean);
begin
  FProcessColumnTldID:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessTldID,Value);
end;

procedure TMainForm.SetProcessColumnMeasDateTime(const Value: boolean);
begin
  FProcessColumnMeasDateTime:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessDateTime,Value);
end;

procedure TMainForm.SetProcessColumnMeasID(const Value: boolean);
begin
  FProcessColumnMeasID:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessID,Value);
end;

procedure TMainForm.SetProcessColumnMeasValidity(const Value: boolean);
begin
  FProcessColumnMeasValidity:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessValidity,Value);
end;

procedure TMainForm.SetProcessColumnOrganization(const Value: boolean);
begin
  FProcessColumnOrganization:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessOrganization,Value);
end;

procedure TMainForm.SetProcessColumnPartID(const Value: boolean);
begin
  FProcessColumnPartID:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessPartID,Value);
end;

procedure TMainForm.SetProcessColumnPersNumber(const Value: boolean);
begin
  FProcessColumnPersNumber:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessPersNumber,Value);
end;

procedure TMainForm.SetProcessColumnTLDUser(const Value: boolean);
begin
  FProcessColumnTLDUser:=Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessTLDUser,Value);
end;

procedure TMainForm.SetProcessColumnHp3(const Value: boolean);
begin
  FProcessColumnHp3:=Value;

  sppProcessColHp3_Err.Visible:=Value;
  sppProcessColHp3_Err.Checked:=Value;
  ProcessColumnHp3_Err:=Value;

  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessHp3,Value);
end;

procedure TMainForm.SetProcessColumnHp3_Err(const Value: boolean);
begin
  FProcessColumnHp3_Err := Value;
  SaveBoolToIni(cSectionGridColumnsProcess,cColumnProcessHp3_Err,Value);
end;

procedure TMainForm.SetShowDelMeas(const Value: boolean);
begin
  if FShowDelMeas<>Value then
  begin
    FShowDelMeas:=Value;
    LoadFilters;
    ReadFilterIni;
    UpdateAllGridPages;
  end;
end;

procedure TMainForm.SetShowGladeKTV(const Value: boolean);
begin
  FShowGladeKTV := Value;
  UpdateGridPageSoft;
end;

procedure TMainForm.SetShowOriginalKTV(const Value: boolean);
begin
  FShowOriginalKTV := Value;
  UpdateGridPageSoft;
end;

procedure TMainForm.SetStart(const Value: boolean);
begin
  FStart:=Value;
  if Value then
  begin
    EnabledSpeedBtns(false,true,false);



  end
  else
  begin
    TabSheetMeasProcessing.Enabled:=true;

    TLDState:=0;
///    if Assigned(TLDCommand.COMPort) AND (TLDCommand.COMPort.Connected) AND TLDCommand.AnswerFlag then
    EnabledSpeedBtns(true,true,true);
//**//    if StartMeasureW.Showing then StartMeasureW.Close;
  end;
end;

procedure TMainForm.SetStatusBarDB(aStatusBarDB: String);
begin
  FStatusBarDB:=aStatusBarDB;
  LblDBName.Caption:=FStatusBarDB;
end;

procedure TMainForm.SetStatusBarUser(aStatusBarUser: String);
begin
  FStatusBarUser:=aStatusBarUser;
  LblUser.Caption:=FStatusBarUser;
end;

procedure TMainForm.SpeedBtnD1InfClick(Sender: TObject);
begin
  DetectorConstructorForm.DetTypeName:=EditD1.Text;
  DetectorConstructorForm.ShowModal;
end;

procedure TMainForm.SpeedBtnD2InfClick(Sender: TObject);
begin
  DetectorConstructorForm.DetTypeName:=EditD2.Text;
  DetectorConstructorForm.ShowModal;
end;

procedure TMainForm.SpeedBtnD3InfClick(Sender: TObject);
begin
  DetectorConstructorForm.DetTypeName:=EditD3.Text;
  DetectorConstructorForm.ShowModal;
end;

procedure TMainForm.SpeedBtnD4InfClick(Sender: TObject);
begin
  DetectorConstructorForm.DetTypeName:=EditD4.Text;
  DetectorConstructorForm.ShowModal;
end;

procedure TMainForm.SpeedBtnDetTypeClick(Sender: TObject);
begin
  DetectorConstructorForm.ShowModal;
end;

// ПЕРЕПИСАТЬ
procedure TMainForm.SpeedBtnDosDropAllFilterClick(Sender: TObject);
begin
  if IsUseFilterCB(CBoxDosOrgName) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterDosOrganization,'');
    CheckComboBox(CBoxDosOrgName,SpBtnDosDropOrgName,false);
  end;
  if IsUseFilterCB(CBoxDosDep) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterDosDepartment,'');
    CheckComboBox(CBoxDosDep,SpBtnDosDropDep,false);
  end;
  if IsUseFilterCB(CBoxDosDosPart) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterDosDosPath,'');
    CheckComboBox(CBoxDosDosPart,SpBtnDosDropDosPart,false);
  end;
  if IsUseFilterCB(CBoxDosDosType) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterDosDosType,'');
    CheckComboBox(CBoxDosDosType,SpBtnDosDropDosType,false);
  end;
  if IsUseFilterEdit(EditDosDosNumber) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterDosDosNumber,'');
    CheckEdit(EditDosDosNumber,SpBtnDosDropDosNumber,false);
  end;
  if IsUseFilterCB(CBoxDosStatus) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterDosDosStatus,'');
    CheckComboBox(CBoxDosStatus,SpBtnDosDropStatus,false);
  end;
  if IsUseFilterCB(CBoxDosDeviceID) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterDosDeviceID,'');
    CheckComboBox(CBoxDosDeviceID,SpBtnDosDropDevID,false);
  end;
  if IsUseFilterCB(CBoxDosPersNumber) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterDosPersNumber,'');
    CheckComboBox(CBoxDosPersNumber,SpBtnDosDropPersNumber,false);
  end;
  if IsUseFilterCB(CBoxDosIDK) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterDosIDK,'');
    CheckComboBox(CBoxDosIDK,SpBtnDosDropIDK,false);
  end;

  if IsUseSQLScript then SQLScriptChange(false);

  TSpeedButton(Sender).Visible:=False;
  LoadFilters;
  UpdateAllGridPages;
end;

procedure TMainForm.SpeedBtnDosExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.SpeedBtnDosOpenFilterClick(Sender: TObject);
begin
  if PanelDosLeftFilter.Height > 1 then
  begin
    FOpenFilterDosPanel:=false;
    TimerOpenFilter.Enabled:=true;
    SpeedBtnDosOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Down.bmp');
    SaveFilterBoolIni(cFilterDosEnable,false);
  end
  else
  begin
    FOpenFilterDosPanel:=true;
    TimerOpenFilter.Enabled:=true;
    SpeedBtnDosOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Up.bmp');
    SaveFilterBoolIni(cFilterDosEnable,true);
  end;
end;

procedure TMainForm.SpeedBtnDosRegClick(Sender: TObject);
begin
  DosimeterConstructorForm.ShowModal;
end;

procedure TMainForm.SpeedBtnDosRegFromFileClick(Sender: TObject);
begin
  ImportDosimetersW.LoadFromFile:=True;
  ImportDosimetersW.ShowModal;
end;

procedure TMainForm.SpeedBtnDosTypeClick(Sender: TObject);
begin
  DosimeterTypeConstructorForm.DosTypeName:=EditDosDataDosTypeVal.Text;
  DosimeterTypeConstructorForm.ShowModal;
end;

procedure TMainForm.SpeedBtnDosTypeInfClick(Sender: TObject);
begin
  DosimeterTypeConstructorForm.DosTypeName:=EditDosDataDosTypeVal.Text;
  DosimeterTypeConstructorForm.ShowModal;
end;

procedure TMainForm.SpeedBtnMeasSaveIDKClick(Sender: TObject);
begin
  UpdateDosimeterIDKParam(EditMeasDataDosFio,EditMeasDataDosPersNumber,EditMeasDataDosOrg,EditMeasDataDosDep);
  PageControlMeasDosParChange(Self);
end;

procedure TMainForm.SpeedBtnMeasSaveParamClick(Sender: TObject);
begin
  UpdateMeasComment(EditMeasDataComment,EditMeasDataComment.Text);
  PageControlMeasDosParChange(Self);
end;

procedure TMainForm.SpeedBtnSaveCurrentCommentClick(Sender: TObject);
begin
  TLDDataModule.UpdateDBComment(cDefaultDB,EditCurrentDBComment.Text);
  EditCurrentDBComment.OnChange(Self);
end;

procedure TMainForm.SpeedBtnSaveReserveCommentClick(Sender: TObject);
begin
  TLDDataModule.UpdateDBComment(DataSourceDBList.DataSet.FieldByName(cDBName).AsString,EditReserveDBComment.Text);
  EditReserveDBComment.OnChange(Self);
end;

procedure TMainForm.SpeedBtnSettingsExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.SpeedBtnStartClick(Sender: TObject);
begin
  TLDCommand.ChangeData.IsStopped := false;
  if SpeedBtnPause.Down then
  begin
    SpeedBtnPause.Down:=false;
    //SpeedBtnPauseClick(Nil);
    if TLD_CommandSeries.TLD_Mode = modeMeasuring then Exit;
  end;
  //TLDCommand.UserCommunication.DosimeterFound := dsfNotFound; // Передача весточки в машину состояний
  //TLD_CommandSeries.DeviceStartMeasures(0);
  StartMeas(cStartSingleMeas);
end;

procedure TMainForm.SpeedBtnMeasStepDownD1Click(Sender: TObject);
begin
  DChartOffsetVertDown(TLDChartMeasDataD1);
end;

procedure TMainForm.SpeedBtnMeasStepDownD2Click(Sender: TObject);
begin
  DChartOffsetVertDown(TLDChartMeasDataD2);
end;

procedure TMainForm.SpeedBtnMeasStepDownD3Click(Sender: TObject);
begin
  DChartOffsetVertDown(TLDChartMeasDataD3);
end;

procedure TMainForm.SpeedBtnMeasStepDownD4Click(Sender: TObject);
begin
  DChartOffsetVertDown(TLDChartMeasDataD4);
end;

procedure TMainForm.SpeedBtnMeasStepLeftD1Click(Sender: TObject);
begin
  DChartOffsetHorLeft(TLDChartMeasDataD1);
end;

procedure TMainForm.SpeedBtnMeasStepLeftD2Click(Sender: TObject);
begin
  DChartOffsetHorLeft(TLDChartMeasDataD2);
end;

procedure TMainForm.SpeedBtnMeasStepLeftD3Click(Sender: TObject);
begin
  DChartOffsetHorLeft(TLDChartMeasDataD3);
end;

procedure TMainForm.SpeedBtnMeasStepLeftD4Click(Sender: TObject);
begin
  DChartOffsetHorLeft(TLDChartMeasDataD4);
end;

procedure TMainForm.SpeedBtnMeasStepRightD1Click(Sender: TObject);
begin
  DChartOffsetHorRight(TLDChartMeasDataD1);
end;

procedure TMainForm.SpeedBtnMeasStepRightD2Click(Sender: TObject);
begin
  DChartOffsetHorRight(TLDChartMeasDataD2);
end;

procedure TMainForm.SpeedBtnMeasStepRightD3Click(Sender: TObject);
begin
  DChartOffsetHorRight(TLDChartMeasDataD3);
end;

procedure TMainForm.SpeedBtnMeasStepRightD4Click(Sender: TObject);
begin
  DChartOffsetHorRight(TLDChartMeasDataD4);
end;

procedure TMainForm.SpeedBtnStopClick(Sender: TObject);
begin
  if SpeedBtnPause.Down then SpeedBtnPause.Down:=false;
//
//  if TimerMeasure.Enabled then            // останавливаем таймер
//    TimerMeasure.Enabled := False;
//
  if TimerTest.Enabled then               // останавливаем таймер
    TimerTest.Enabled := False;

  if TimerSourceTest.Enabled then         // останавливаем таймер
    TimerSourceTest.Enabled := False;

  //if Assigned(TLDCommand.COMPortSyn) then
    //if TLDCommand.COMPortSyn.Connected then

  { #todo -oЧернышев : Ввести запрос на экстренное прерывание измерения в случае второго нажатия при измерении }
  //if TLDCommand.ChangeData.IsStopped then
  //SpeedBtnPause.Visible:=True;

  if Sender<>Nil then
  begin
    TLDCommand.ChangeData.IsStopped := True;
  end;

  CntD:=0;
  TLDState:=0;

  if Start then
  begin
    Start:=False;

    if TLDCommand.StartMeasuringFlag then
      TLDCommand.StartMeasuringFlag:=false;
{
    if not StartMeasureW.Showing then
    begin
      if Dosimeter <> nil then
      begin
        Dosimeter.Validity:=stDosMeasStoppedD1;
        Dosimeter.MeasTime:=Now;
        Dosimeter.CntDetector.State:=stDetMeasStopped;
        SaveDetTXTResults(Format('%s_%s_%s_%s%d',[DateTimeToStr_Format(Now),'Dosimeter',Dosimeter.FullNumber,'Detector',Dosimeter.DetectorsCnt+1]));  // сохранение результатов измерений детектора в текстовом файле
        SaveCurrentDetectorsData; // сохранение текущих измерений по детекторам на момент остановки
        SaveDosimeterData;
        ShowStopMeasureW;
      end;
    end
    else
      StartMeasureW.Close;
      }
  end;
end;

procedure TMainForm.AddUserSpeedBtnClick(Sender: TObject);
begin
  CB_SetAsTemlate.Font.Color:=clWindowText;
  AddUW.PermitComboBox.Items.SetStrings(CB_SetAsTemlate.Items);
  if AddUW.ShowModal=mrOK then
  begin
    RefreshPermit_Page;
    SG_Users.Row:=SG_Users.RowCount-1;
  end;
end;

function TMainForm.ChangeBytesDetCnt(Byte: word; BitPos: integer; BitState: boolean): word;
var
  detByte: word;
begin
  detByte:=Byte;
  if IsBitOn(detByte,BitPos) <> BitState then detByte:=SetBit(detByte,BitPos,BitState);
  result := detByte;
end;

procedure TMainForm.CheckDBCommentEdit;
begin
  if TLDDataModule.IsDBConnected then
  begin
    EditReserveDBComment.Text:=TLDDataModule.GetDataBaseComment(DataSourceDBList.DataSet.FieldByName(cDBName).AsString);
    EditCurrentDBComment.Text:=TLDDataModule.GetDataBaseComment(cDefaultDB);
  end;
end;

procedure TMainForm.CheckDBConnection;
begin
  if TLDDataModule.IsConnected then
  begin
    OnCommandLog(TimeToStr(Now)+' : -> ',format(rsDBConnectionOK,[TLDDataModule.DBName]),'',cMsgInf,cMsgPriorityInf);
    StatusBarDB:=rsDB +': '+ TLDDataModule.DBName;
  end
  else
  begin
    if (TLDDataModule.DBName = cPostgreDefaultDB) or (TLDDataModule.DBName = '') then
    begin
      OnCommandLog(TimeToStr(Now)+' : -> ',rsDBisNotOpen,'',cMsgRead,cMsgPriorityInf);
      StatusBarDB:=rsDBisNotOpen;
    end
    else
    begin
      OnCommandLog(TimeToStr(Now)+' : -> ',rsDBConnectionFaultShort + ' - "'+TLDDataModule.DBName+'"','',cMsgInf,cMsgPriorityInf);
      StatusBarDB:=rsDBConnectionFaultShort + ': '+TLDDataModule.DBName;
    end;
  end;

  IsStart;
end;

procedure TMainForm.CheckDBGridRowCount(DBGrid: TDBGridEh);
begin
  if DBGrid.DataSource.DataSet.RecordCount = 0 then
  begin
    ClearCharts;
    ClearLebels;
    HidePanels:=true;
  end
  else
    HidePanels:=false;
end;

procedure TMainForm.Check_ASIDK_DBConnection;
begin
  if TLDDataModule.Is_ASIDK_Connected then
  begin
    OnCommandLog(TimeToStr(Now)+' : -> ',format(rsDB_ASIDKConnestionOK,[TLDDataModule.ASIDK_DBName]),'',cMsgInf,cMsgPriorityInf);
    StatusBarDB:=StatusBarDB+'; ' + rsDB_ASIDK + ': '+TLDDataModule.ASIDK_DBName;
  end
  else
  begin
    if (TLDDataModule.ASIDK_DBName = cPostgreDefaultDB) or (TLDDataModule.ASIDK_DBName = '') then
    begin
      OnCommandLog(TimeToStr(Now)+' : -> ',rsDB_ASIDKisNotOpen,'',cMsgInf,cMsgPriorityInf);
      StatusBarDB:=StatusBarDB+'; '+ rsDB_ASIDKisNotOpen;
    end
    else
    begin
      OnCommandLog(TimeToStr(Now)+' : -> ',rsDB_ASIDKConnectionFaultShort + ' - "'+TLDDataModule.ASIDK_DBName+'"','',cMsgInf,cMsgPriorityInf);
      StatusBarDB:=StatusBarDB+'; ' + rsDB_ASIDKConnectionFaultShort + ': ' + TLDDataModule.ASIDK_DBName;
    end;
  end;
end;

procedure TMainForm.CLB_PermitsClick(Sender: TObject);
var
  i  : word;
begin
  for i:=0 to cPermitsCount-1 do
    if CLB_Permits.Selected[i] then
      LabelPermitHelp.Caption:=cLabelPermitHelp[cPermitIndex[i]];
end;

procedure TMainForm.CLB_PermitsClickCheck(Sender: TObject);
var
  i               : word;
  newPermitMask   : int64;
  oldBitSettings  : boolean;
  oldBitPermit    : boolean;
  newBitSettings  : boolean;
  newBitPermit    : boolean;
  procedure ConfirmPermit(Permit: String);
  var
    temp            : word;
  begin
    temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s - "%s"?',[rsConfirmSelfPermit,Permit]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

    case temp of
      mrYes:
      begin
        PermitMask:=newPermitMask;
        WritePermitToUser(PermitMask, AW.Users[PermitSelectedRowUser].Login);
      end;
      mrNo:
        SG_UsersClick(Self);
    end;
  end;
begin
  CB_SetAsTemlate.Font.Color:=clWindowText;
  CB_SetAsTemlate.ItemIndex:=-1;

  if AW.Users[PermitSelectedRowUser].UserId = AW.CurrentUser.UserId then
  begin
    oldBitSettings:=IsBit64On(AW.CurrentUser.Permit,crMain_Page_Settings);
    oldBitPermit:=IsBit64On(AW.CurrentUser.Permit,crMain_Page_Permit);
    newPermitMask:=0;

    for i:=0 to cPermitsCount-1 do
      newPermitMask:=SetBit64(newPermitMask,cPermitIndex[i],CLB_Permits.Checked[i]);

    newBitSettings:=IsBit64On(newPermitMask,crMain_Page_Settings);
    newBitPermit:=IsBit64On(newPermitMask,crMain_Page_Permit);

    if oldBitSettings AND not newBitSettings then
      ConfirmPermit(cPermitTexts[crMain_Page_Settings])
    else
    if oldBitPermit AND not newBitPermit then
      ConfirmPermit(cPermitTexts[crMain_Page_Permit])
    else
    begin
      PermitMask:=newPermitMask;
      WritePermitToUser(PermitMask, AW.Users[PermitSelectedRowUser].Login);
    end
  end
  else
  begin
    newPermitMask:=0;
    for i:=0 to cPermitsCount-1 do
      newPermitMask:=SetBit64(newPermitMask,cPermitIndex[i],CLB_Permits.Checked[i]);

    PermitMask:=newPermitMask;
    WritePermitToUser(PermitMask, AW.Users[PermitSelectedRowUser].Login);
  end;
end;

procedure TMainForm.WritePermitToUser(aPermit: int64; aUser: String);
var
  i: integer;
begin
  for i:=Low(AW.Users) to High(AW.Users) do
    if aUser = AW.Users[i].Login then
      AW.Users[i].Permit := aPermit;
  if aUser = AW.CurrentUser.Login then
  begin
    AW.CurrentUser.Permit := aPermit;
    SetInterfaceByPermits;
    if CalcForm.Showing then CalcForm.SetInterfaceByPermits;
  end;
  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add(Format('UPDATE %s SET %s = %d WHERE %s = '+#39+'%s'+#39,[cDBTableUser,cFieldUserPermission,aPermit,cFieldUserName,aUser]));
    TLDDataModule.ADOQuery.ExecSQL;
    TLDDataModule.ADOQuery.Close;

    WriteLog(Format(rsUserRightsChanged,[aUser,aPermit]));
  end;
end;

procedure TMainForm.CheckDosInGrid(DosNumb: String);
var
  i     : integer;
  flag  : boolean;
begin

  DBGridEhDos.DataSource.DataSet.First;
  flag:=false;

  for i := 0 to DBGridEhDos.DataSource.DataSet.RecordCount-1 do
  begin
    if (DosNumb = DBGridEhDos.DataSource.DataSet.Fields[0].AsString) then
    begin
      flag:=true;
      break;
    end;
    DBGridEhDos.DataSource.DataSet.Next;
  end;

  if not flag then DBGridEhDos.DataSource.DataSet.First;

end;

procedure TMainForm.ClearCharts;
var
  i: integer;
begin

  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      SeriesMeasD1TempWrite.Clear;
      SeriesMeasD1Glade.Clear;
      SeriesMeasD1Temp.Clear;
      SeriesMeasD1KTV.Clear;
      SeriesMeasD1Fon.Clear;
      SeriesMeasD1Gaus.Clear;

      SeriesMeasD2TempWrite.Clear;
      SeriesMeasD2Glade.Clear;
      SeriesMeasD2Temp.Clear;
      SeriesMeasD2KTV.Clear;
      SeriesMeasD2Fon.Clear;
      SeriesMeasD2Gaus.Clear;

      SeriesMeasD3TempWrite.Clear;
      SeriesMeasD3Glade.Clear;
      SeriesMeasD3Temp.Clear;
      SeriesMeasD3KTV.Clear;
      SeriesMeasD3Fon.Clear;
      SeriesMeasD3Gaus.Clear;

      SeriesMeasD4TempWrite.Clear;
      SeriesMeasD4Glade.Clear;
      SeriesMeasD4Temp.Clear;
      SeriesMeasD4KTV.Clear;
      SeriesMeasD4Fon.Clear;
      SeriesMeasD4Gaus.Clear;

      //TLDChartMeasDataD1.ClearSeries;
      //TLDChartMeasDataD2.ClearSeries;
      //TLDChartMeasDataD3.ClearSeries;
      //TLDChartMeasDataD4.ClearSeries;
      {
      for i := 0 to TLDChartMeasDataD1.SeriesCount-1 do  TLDChartMeasDataD1.Series[i].Clear;
      for i := 0 to TLDChartMeasDataD2.SeriesCount-1 do  TLDChartMeasDataD2.Series[i].Clear;
      for i := 0 to TLDChartMeasDataD3.SeriesCount-1 do  TLDChartMeasDataD3.Series[i].Clear;
      for i := 0 to TLDChartMeasDataD4.SeriesCount-1 do  TLDChartMeasDataD4.Series[i].Clear;
      }
      {
      ChartToolBorderMeasD1.Visible:=False;
      ChartToolBorderMeasD2.Visible:=False;
      ChartToolBorderMeasD3.Visible:=False;
      ChartToolBorderMeasD4.Visible:=False;
      }
      {
      TLDChartMeasDataD1.Axes.Left.Minimum:=0;
      TLDChartMeasDataD2.Axes.Left.Minimum:=0;
      TLDChartMeasDataD3.Axes.Left.Minimum:=0;
      TLDChartMeasDataD4.Axes.Left.Minimum:=0;
      TLDChartMeasDataD1.Axes.Left.Maximum:=0;
      TLDChartMeasDataD2.Axes.Left.Maximum:=0;
      TLDChartMeasDataD3.Axes.Left.Maximum:=0;
      TLDChartMeasDataD4.Axes.Left.Maximum:=0;
      TLDChartMeasDataD1.Axes.Left.AutomaticMaximum:=true;
      TLDChartMeasDataD2.Axes.Left.AutomaticMaximum:=true;
      TLDChartMeasDataD3.Axes.Left.AutomaticMaximum:=true;
      TLDChartMeasDataD4.Axes.Left.AutomaticMaximum:=true;
      }
    end;
    cPageProcessIndex:
    begin
      SeriesProcessD1TempWrite.Clear;
      SeriesProcessD1Glade.Clear;
      SeriesProcessD1Temp.Clear;
      SeriesProcessD1KTV.Clear;
      SeriesProcessD1Fon.Clear;
      SeriesProcessD1Gaus.Clear;

      SeriesProcessD2TempWrite.Clear;
      SeriesProcessD2Glade.Clear;
      SeriesProcessD2Temp.Clear;
      SeriesProcessD2KTV.Clear;
      SeriesProcessD2Fon.Clear;
      SeriesProcessD2Gaus.Clear;

      SeriesProcessD3TempWrite.Clear;
      SeriesProcessD3Glade.Clear;
      SeriesProcessD3Temp.Clear;
      SeriesProcessD3KTV.Clear;
      SeriesProcessD3Fon.Clear;
      SeriesProcessD3Gaus.Clear;

      SeriesProcessD4TempWrite.Clear;
      SeriesProcessD4Glade.Clear;
      SeriesProcessD4Temp.Clear;
      SeriesProcessD4KTV.Clear;
      SeriesProcessD4Fon.Clear;
      SeriesProcessD4Gaus.Clear;

      //TLDChartProcessDataD1.ClearSeries;
      //TLDChartProcessDataD2.ClearSeries;
      //TLDChartProcessDataD3.ClearSeries;
      //TLDChartProcessDataD4.ClearSeries;
      {
      for i := 0 to TLDChartProcessDataD1.SeriesCount-1 do  TLDChartProcessDataD1.Series[i].Clear;
      for i := 0 to TLDChartProcessDataD2.SeriesCount-1 do  TLDChartProcessDataD2.Series[i].Clear;
      for i := 0 to TLDChartProcessDataD3.SeriesCount-1 do  TLDChartProcessDataD3.Series[i].Clear;
      for i := 0 to TLDChartProcessDataD4.SeriesCount-1 do  TLDChartProcessDataD4.Series[i].Clear;
      }
      {
      ChartToolBorderProcessD1.Visible:=False;
      ChartToolBorderProcessD2.Visible:=False;
      ChartToolBorderProcessD3.Visible:=False;
      ChartToolBorderProcessD4.Visible:=False;
      }
      {
      TLDChartProcessDataD1.Axes.Left.Minimum:=0;
      TLDChartProcessDataD2.Axes.Left.Minimum:=0;
      TLDChartProcessDataD3.Axes.Left.Minimum:=0;
      TLDChartProcessDataD4.Axes.Left.Minimum:=0;
      TLDChartProcessDataD1.Axes.Left.Maximum:=0;
      TLDChartProcessDataD2.Axes.Left.Maximum:=0;
      TLDChartProcessDataD3.Axes.Left.Maximum:=0;
      TLDChartProcessDataD4.Axes.Left.Maximum:=0;
      TLDChartProcessDataD1.Axes.Left.AutomaticMaximum:=true;
      TLDChartProcessDataD2.Axes.Left.AutomaticMaximum:=true;
      TLDChartProcessDataD3.Axes.Left.AutomaticMaximum:=true;
      TLDChartProcessDataD4.Axes.Left.AutomaticMaximum:=true;
      }
    end;
  end;

end;

procedure TMainForm.ClearLebels;
  procedure ChangeStringLabelBracket(Lbl: TLabel; const cText: String; Text: String);
  begin
    if Text = '' then
      Lbl.Caption:=Format('%s (%s)',[cText,cEmptyData])
    else
      Lbl.Caption:=Format('%s (%s)',[cText,Text]);
  end;
  procedure ChangeStringLabel(Lbl: TLabel; Text: String);
  begin
    if Text = '' then
      Lbl.Caption:=Format('%s',[cEmptyData])
    else
      Lbl.Caption:=Format('%s',[Text]);
  end;
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      ChangeStringLabelBracket(LblMeasDataDosNumberVal,'','');
      ChangeStringEdit(EditMeasDataDose,'',clBtnFace);
      ChangeStringEdit(EditMeasDataDosStatus,'',clBtnFace);
      ChangeStringLabelBracket(LblMeasDataDosKSVal,'','');
      ChangeStringLabelBracket(LblMeasDataKDosVal,'','');
      ChangeStringLabelBracket(LblMeasDataDosMeasTimeVal,'','');
      ChangeStringLabelBracket(LblMeasDataDosVerVal,'','');
      ChangeStringLabelBracket(LblMeasDataFormulaDosVal,'','');
      ChangeStringEdit(EditMeasDataComment,'',clWhite);
      ChangeStringEdit(EditMeasDataDosOrg,'',clWhite);
      ChangeStringEdit(EditMeasDataDosDep,'',clWhite);
      ChangeStringEdit(EditMeasDataDosFio,'',clWhite);
      ChangeStringEdit(EditMeasDataDosPersNumber,'',clWhite);
      ChangeStringEdit(EditMeasDataDosIDK,'',clBtnFace);
      ChangeStringLabelBracket(LblMeasDataFilter,'','');

      ChangeStringEdit(EditMeasDataD1Dose,'',clBtnFace);
      ChangeStringEdit(EditMeasDataD1Status,'',clBtnFace);
      ChangeStringLabelBracket(LblMeasDataNameD1,rsDetector1,'');
      ChangeStringLabelBracket(LblMeasDataCommentD1Value,'','');

      ChangeStringEdit(EditMeasDataD2Dose,'',clBtnFace);
      ChangeStringEdit(EditMeasDataD2Status,'',clBtnFace);
      ChangeStringLabelBracket(LblMeasDataNameD2,rsDetector2,'');
      ChangeStringLabelBracket(LblMeasDataCommentD2Value,'','');

      ChangeStringEdit(EditMeasDataD3Dose,'',clBtnFace);
      ChangeStringEdit(EditMeasDataD3Status,'',clBtnFace);
      ChangeStringLabelBracket(LblMeasDataNameD3,rsDetector3,'');
      ChangeStringLabelBracket(LblMeasDataCommentD3Value,'','');

      ChangeStringEdit(EditMeasDataD4Dose,'',clBtnFace);
      ChangeStringEdit(EditMeasDataD4Status,'',clBtnFace);
      ChangeStringLabelBracket(LblMeasDataNameD4,rsDetector4,'');
      ChangeStringLabelBracket(LblMeasDataCommentD4Value,'','');
    end;
    cPageDosIndex:
    begin

    end;
    cPageProcessIndex:
    begin
      ChangeStringLabelBracket(LblProcessDataDosNumberVal,'','');
      ChangeStringEdit(EditProcessDataDose,'',clBtnFace);
      ChangeStringEdit(EditProcessDataDosStatus,'',clBtnFace);
      ChangeStringLabelBracket(LblProcessDataDosKSVal,'','');
      ChangeStringLabelBracket(LblProcessDataKDosVal,'','');
      ChangeStringLabelBracket(LblProcessDataDosMeasTimeVal,'','');
      ChangeStringLabelBracket(LblProcessDataDosVerVal,'','');
      ChangeStringLabelBracket(LblProcessDataFormulaDosVal,'','');
      ChangeStringLabelBracket(LblProcessDataFilter,'','');

      ChangeStringEdit(EditProcessDataDosOrg,'',clWhite);
      ChangeStringEdit(EditProcessDataDosDep,'',clWhite);
      ChangeStringEdit(EditProcessDataDosPersNumber,'',clWhite);
      ChangeStringEdit(EditProcessDataDosIDK,'',clWhite);

      ChangeStringEdit(EditProcessDataD1Dose,'',clBtnFace);
      ChangeStringEdit(EditProcessDataD1Status,'',clBtnFace);
      ChangeStringLabelBracket(LblProcessDataNameD1,rsDetector1,'');
      ChangeStringLabelBracket(LblProcessDataCommentD1Value,'','');

      ChangeStringEdit(EditProcessDataD2Dose,'',clBtnFace);
      ChangeStringEdit(EditProcessDataD2Status,'',clBtnFace);
      ChangeStringLabelBracket(LblProcessDataNameD2,rsDetector2,'');
      ChangeStringLabelBracket(LblProcessDataCommentD2Value,'','');

      ChangeStringEdit(EditProcessDataD3Dose,'',clBtnFace);
      ChangeStringEdit(EditProcessDataD3Status,'',clBtnFace);
      ChangeStringLabelBracket(LblProcessDataNameD3,rsDetector3,'');
      ChangeStringLabelBracket(LblProcessDataCommentD3Value,'','');

      ChangeStringEdit(EditProcessDataD4Dose,'',clBtnFace);
      ChangeStringEdit(EditProcessDataD4Status,'',clBtnFace);
      ChangeStringLabelBracket(LblProcessDataNameD4,rsDetector4,'');
      ChangeStringLabelBracket(LblProcessDataCommentD4Value,'','');
    end;
  end;
end;

procedure TMainForm.CloseCOMPort;
begin
//  if Assigned(TLDCommand) then FreeAndNil(TLDCommand);
  if Assigned(TLDCommand) then
    if Assigned(TLDCommand.COMPortSyn) then
      if Assigned(TLDCommand.COMPortSyn.CP) then
        TLDCommand.COMPortSyn.CP.CloseSocket;{ #todo -oЧернышев : Переделать для потоковой безопасности }
end;

//procedure TMainForm.ComboBoxBoudRateChange(Sender: TObject);
//begin
//  TLDCommand.BaudRate:=StrToInt(ComboBoxBoudRate.Items[ComboBoxBoudRate.ItemIndex]);
//  SetW.ConnectionState;
//end;

//procedure TMainForm.ComboBoxParityChange(Sender: TObject);
//begin
//  TLDCommand.StopBits:=StrToInt(ComboBoxParity.Items[ComboBoxParity.ItemIndex]);
//  SetW.ConnectionState;
//end;

procedure TMainForm.ComboBoxPortNumberChange(Sender: TObject);
begin
  COMName:=ComboBoxPortNumber.Items[ComboBoxPortNumber.ItemIndex];
//  TLDCommand.COM:=ComboBoxPortNumber.Items[ComboBoxPortNumber.ItemIndex];
//  TLDCommand.TLDConnect:=True;
//  TLDCommand.AnswerTime:=Now;
//  SetW.ConnectionState;
//  if TLDCommand.ReceivePacketActive then
//    TLDCommand.Re['{F30BDEB3-E4D0-45A8-B656-8CA6EC0AD895}']ceivePacketActive:=False;
  ReinitializeCOMPort;
  TabSheetDeviceControlShow(self);
  FWorkingTime:=0;
end;

//procedure TMainForm.ComboBoxStopBitChange(Sender: TObject);
//begin
//  TLDCommand.StopBits:=StrToInt(ComboBoxStopBit.Items[ComboBoxStopBit.ItemIndex]);
//  SetW.ConnectionState;
//end;

procedure TMainForm.SetHidePanels(Value: boolean);
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      PanelMeasDataDos.Visible:=not Value;
      PanelMeasDataDets.Visible:=not Value;
    end;
    cPageDosIndex:
    begin

    end;
    cPageProcessIndex:
    begin
      PanelProcessDataDos.Visible:=not Value;
      PanelProcessDataDets.Visible:=not Value;
    end;
  end;
end;

procedure TMainForm.DBGridDosCellClick(Column: TColumn);
begin
  FilterDosDosNumber:=GetGridDosNumber;

  if (EditDosDosNumber.Text=FilterDosDosNumber) then
    EditDosDosNumberChange(Self)
  else
    EditDosDosNumber.Text:=FilterDosDosNumber;
end;

var
  flg : boolean = true;
procedure TMainForm.DBGridDosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  // построчное выделение
	//if TDBGrid(Sender).DataSource.DataSet.RecNo mod 2 = 1 then
  //  TDBGrid(Sender).Canvas.Brush.Color:=clCream;//RGB($CC,$CC,$99);

  TDBGrid(Sender).Canvas.Brush.Color:=clBtnFace;

	// Восстанавливаем выделение текущей позиции курсора
	if  gdSelected   in State then
  begin
		TDBGrid(Sender).Canvas.Brush.Color:= clHighLight;
		TDBGrid(Sender).Canvas.Font.Color := clHighLightText;
	end;

	// Просим GRID перерисоваться самому
//******	TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

//  // Этот вариант раскраски строк без выделение текуще строки
//  if DataCol = 0 then flg:= not flg;
//
//  with Sender as TDBGrid do
//  begin
//    Canvas.Font.Color := clBlack;
//    if flg then
//      Canvas.Brush.Color:= clCream
//    else
//      Canvas.Brush.Color:= clWhite;
//    DefaultDrawColumnCell(Rect, DataCol, Column, State);
//  end; {with}

end;

procedure TMainForm.DBGridEhMeasListCellClick(Column: TColumnEh);
begin
//  LoadMeasData;
end;

procedure TMainForm.DBGridEhMeasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  st      : integer;
  to_del  : boolean;
begin

  st:=Column.Field.DataSet.FieldByName(cFieldValidity).AsInteger;

  case st of
    cDosNotMeasured .. cDosMeasFinishedD4,cDosMeasStoppedD1 .. cDosMeasStoppedD4:
    begin
      TDBGridEh(Sender).Canvas.Brush.Color:=clSilver;
    end;
    cDosMeasFinished:
    begin
      TDBGridEh(Sender).Canvas.Brush.Color:=clWhite;
    end;
    cDosMeasError:
    begin
      TDBGridEh(Sender).Canvas.Brush.Color:=clYellow;
    end;
    cDosMeasWarning:
    begin
      TDBGridEh(Sender).Canvas.Brush.Color:=clSkyBlue;
    end;
    cDosMeasUserWarning:
    begin
      TDBGridEh(Sender).Canvas.Brush.Color:=RGBToColor(255,204,255);
    end;
    cDosMeasAccepted:
    begin
      TDBGridEh(Sender).Canvas.Brush.Color:=clWhite;//clBtnFace;
    end;
    else
    begin
      TDBGridEh(Sender).Canvas.Brush.Color:=clSkyBlue;
    end;
  end;

	// Восстанавливаем выделение текущей позиции курсора
  if gdSelected in State then
  begin
    TDBGridEh(Sender).Canvas.Font.Color:=clBlack;
    TDBGridEh(Sender).Canvas.Font.Style:=[fsBold];
  end;

  // Просим GRID перерисоваться самому
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

  TDBGridEh(Sender).Canvas.Pen.Width:=cPenNormalWidth;

  // перечеркиваем удаленные измерения
  to_del:=Column.Field.DataSet.FieldByName(cFieldToDel).AsBoolean;

  if to_del then
  begin
    TDBGridEh(Sender).Canvas.Pen.Color:=clBlack;
    TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top + Round(Rect.Height/2));
    TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top + Round(Rect.Height/2));
  end;

  // рамка вокруг выделенного измерения

  if not Start then
  begin
    if TDBGridEh(Sender).SelectedRows.CurrentRowSelected=true then
    begin
      TDBGridEh(Sender).Canvas.Pen.Color:=clBlack;
      //TDBGridEh(Sender).Canvas.Pen.Color:=clHighlight;
      TDBGridEh(Sender).Canvas.Pen.Width:=cPenStrikeoutWidth;
      TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top);
      TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top);
      TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top + Rect.Height-1);
      TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top + Rect.Height-1);
    end;
  end;

end;

procedure TMainForm.DBGridEhMeasListTitleClick(Column: TColumnEh);
//var
//  measID: String;
begin
//  measID:=DataSourceMeasList.DataSet.FieldByName(cFieldDosMeasID).AsString;
//  if measID <> '' then DBGridEhOnlyMeas.DataSource.DataSet.Locate(cFieldDosMeasID,measID,[]);
//  LoadMeasData;
end;

procedure TMainForm.DBGridEhCalcKDosCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
begin
  GetCalibrData;
end;

procedure TMainForm.DBGridEhCalcKDosColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  SaveGridsParametersCalibr;
end;

procedure TMainForm.DBGridEhCalcKDosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
const
  cErrLevel = 100;
var
  st                 : integer;
  measId             : String;
  err_Hp_10g_Percent : double;
  err_Hp_10n_Percent : double;
  err_Hp_3_Percent   : double;
  err_Hp_007_Percent : double;
  err_H_star_Percent : double;
  err_H_007_Percent  : double;
  err_D_Percent      : double;
begin
  if TDBGridEh(Sender).DataSource.DataSet.RecordCount>0 then
  begin

    st:=-1;

    err_Hp_10g_Percent:=-1;
    err_Hp_10n_Percent:=-1;
    err_Hp_3_Percent:=-1;
    err_Hp_007_Percent:=-1;
    err_H_star_Percent:=-1;
    err_H_007_Percent:=-1;
    err_D_Percent:=-1;

    if (Column.Field.DataSet.FieldByName(cFieldValidity).AsString<>'') then st:=Column.Field.DataSet.FieldByName(cFieldValidity).AsInteger;
    if (Column.Field.DataSet.FieldByName(cFieldDosMeasID).AsString<>'') then measId:=Column.Field.DataSet.FieldByName(cFieldDosMeasID).AsString;

    if Column.Field.DataSet.FieldByName(cFieldVirt_Err_Hp_10g_Percent).AsString<>'NAN' then err_Hp_10g_Percent := RoundToCN(Column.Field.DataSet.FieldByName(cFieldVirt_Err_Hp_10g_Percent).AsFloat,-1);
    if Column.Field.DataSet.FieldByName(cFieldVirt_Err_Hp_10n_Percent).AsString<>'NAN' then err_Hp_10n_Percent := RoundToCN(Column.Field.DataSet.FieldByName(cFieldVirt_Err_Hp_10n_Percent).AsFloat,-1);
    if Column.Field.DataSet.FieldByName(cFieldVirt_Err_Hp_3_Percent).AsString<>'NAN' then err_Hp_3_Percent := RoundToCN(Column.Field.DataSet.FieldByName(cFieldVirt_Err_Hp_3_Percent).AsFloat,-1);
    if Column.Field.DataSet.FieldByName(cFieldVirt_Err_Hp_007_Percent).AsString<>'NAN' then err_Hp_007_Percent := RoundToCN(Column.Field.DataSet.FieldByName(cFieldVirt_Err_Hp_007_Percent).AsFloat,-1);
    if Column.Field.DataSet.FieldByName(cFieldVirt_Err_H_star_Percent).AsString<>'NAN' then err_H_star_Percent := RoundToCN(Column.Field.DataSet.FieldByName(cFieldVirt_Err_H_star_Percent).AsFloat,-1);
    if Column.Field.DataSet.FieldByName(cFieldVirt_Err_H_007_Percent).AsString<>'NAN' then err_H_007_Percent := RoundToCN(Column.Field.DataSet.FieldByName(cFieldVirt_Err_H_007_Percent).AsFloat,-1);
    if Column.Field.DataSet.FieldByName(cFieldVirt_Err_D_Percent).AsString<>'NAN' then err_D_Percent := RoundToCN(Column.Field.DataSet.FieldByName(cFieldVirt_Err_D_Percent).AsFloat,-1);

    if st>=0 then
      case st of
        cDosNotMeasured .. cDosMeasFinishedD4,cDosMeasStoppedD1 .. cDosMeasStoppedD4:
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=clSilver;
        end;
        cDosMeasFinished:
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=clWhite;
        end;
        cDosMeasError:
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=clYellow;
        end;
        cDosMeasWarning:
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=clSkyBlue;
        end;
        cDosMeasUserWarning:
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=RGBToColor(255,204,255);
        end;
        cDosMeasAccepted:
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=clWhite;//clBtnFace;
        end;
        else
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=clSkyBlue;
        end;
      end;

    if measid<>'' then
      if not IsValidCalibrMeas(measid) then
        TDBGridEh(Sender).Canvas.Brush.Color:=clYellow;

    if ((not err_Hp_10g_Percent.IsNan) AND (err_Hp_10g_Percent>cErrLevel)) OR
       ((not err_Hp_10n_Percent.IsNan) AND (err_Hp_10n_Percent>cErrLevel)) OR
       ((not err_Hp_3_Percent.IsNan) AND (err_Hp_3_Percent>cErrLevel)) OR
       ((not err_Hp_007_Percent.IsNan) AND (err_Hp_007_Percent>cErrLevel)) OR
       ((not err_H_star_Percent.IsNan) AND (err_H_star_Percent>cErrLevel)) OR
       ((not err_H_007_Percent.IsNan) AND (err_H_007_Percent>cErrLevel)) OR
       ((not err_D_Percent.IsNan) AND (err_D_Percent>cErrLevel))
    then
      TDBGridEh(Sender).Canvas.Brush.Color:=clYellow;

  //*//  TDBGridEh(Sender).Canvas.Brush.Color:=clWhite;//clBtnFace;

    // Восстанавливаем выделение текущей позиции курсора
    if gdSelected in State then
    begin
      TDBGridEh(Sender).Canvas.Font.Color:=clBlack;
      TDBGridEh(Sender).Canvas.Font.Style:=[fsBold];
    end;



    // Просим GRID перерисоваться самому
    TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

    TDBGridEh(Sender).Canvas.Pen.Width:=cPenNormalWidth;

  //  // перечеркиваем удаленные измерения
  //  st:=StrToIntRegion(Column.Field.DataSet.FieldByName(cFieldToDel).AsString);
  //
  //  if st = cMarkedToDelMeas then
  //  begin
  //    TDBGridEh(Sender).Canvas.Pen.Color:=clBlack;
  //    TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top + Round(Rect.Height/2));
  //    TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top + Round(Rect.Height/2));
  //  end;

    // рамка вокруг выделенного измерения

    if not Start then
    begin
      if TDBGridEh(Sender).SelectedRows.CurrentRowSelected=true then
      begin
        TDBGridEh(Sender).Canvas.Pen.Color:=clBlack;
        //TDBGridEh(Sender).Canvas.Pen.Color:=clHighlight;
        TDBGridEh(Sender).Canvas.Pen.Width:=cPenStrikeoutWidth;
        TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top);
        TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top);
        TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top + Rect.Height-1);
        TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top + Rect.Height-1);
      end;
    end;
  end;
end;

procedure TMainForm.DBGridEhCalcKDosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  GetCalibrData;
end;

procedure TMainForm.DBGridEhCalcKDosTitleClick(Column: TColumnEh);
begin
  StartCalibration;
end;

procedure TMainForm.DBGridEhCalibrationCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
begin
  GetMeasData;
end;

procedure TMainForm.DBGridEhDBCellClick(Column: TColumnEh);
begin
  CheckDBCommentEdit;
end;

procedure TMainForm.DBGridEhDBDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  if not Start then
  begin
    if TDBGridEh(Sender).SelectedRows.CurrentRowSelected=true then
    begin
      TDBGridEh(Sender).Canvas.Pen.Color:=clBlack;
      TDBGridEh(Sender).Canvas.Pen.Width:=cPenStrikeoutWidth;
      TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top);
      TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top);
      TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top + Rect.Height-1);
      TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top + Rect.Height-1);
    end;
  end;
end;

procedure TMainForm.DBGridEhDBKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = VK_UP) OR
     (Key = VK_DOWN) OR
     (Key = VK_END) OR
     (Key = VK_HOME) OR
     (Key = VK_PRIOR) OR
     (Key = VK_NEXT)) then
  begin
    if NOT (ssShift in Shift) then
    begin
      TDBGridEh(Sender).SelectedRows.Clear;
      TDBGridEh(Sender).SelectedRows.CurrentRowSelected:=true;
      CheckDBCommentEdit;
    end;
  end;
end;

procedure TMainForm.DBGridEhDosCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
begin
  GetDosData;
  IsGroupDosOperations;
end;

procedure TMainForm.DBGridEhDosColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  SaveGridsParametersDos;
end;

procedure TMainForm.DBGridEhDosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  st        : integer;
  validity  : integer;
begin

  validity:=Column.Field.DataSet.FieldByName(cFieldLastMeasResult).AsInteger;
  st:=Column.Field.DataSet.FieldByName(cFieldDosStatus).AsInteger;

  case validity of
    cDosMeasWarning:
    begin
      TDBGridEh(Sender).Canvas.Brush.Color:=clSkyBlue;
    end;
    cDosMeasError:
    begin
      TDBGridEh(Sender).Canvas.Brush.Color:=clYellow;
    end;
    cDosMeasUserWarning:
    begin
      TDBGridEh(Sender).Canvas.Brush.Color:=RGBToColor(255,204,255);
    end;
    else
    begin
      case st of
        cDosCalibrated:
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=clWhite;
        end;
        cDosNotCalibrated:
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=RGBToColor(224,224,224);
        end;
        cDosDecommissioned:
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=RGBToColor(224,224,224);
        end
        else
        begin
          TDBGridEh(Sender).Canvas.Brush.Color:=RGBToColor(224,224,224);
        end;
      end;
    end;
  end;

	// Восстанавливаем выделение текущей позиции курсора
	if gdSelected in State then
  begin
    TDBGridEh(Sender).Canvas.Font.Color:=clBlack;
    TDBGridEh(Sender).Canvas.Font.Style:=[fsBold];
	end;

	// Просим GRID перерисоваться самому
	TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

  if st = cDosDecommissioned then
  begin
    TDBGridEh(Sender).Canvas.Pen.Color:=clBlack;
    TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top + Round(Rect.Height/2));
    TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top + Round(Rect.Height/2));
  end;

  TDBGridEh(Sender).Canvas.Pen.Width:=cPenNormalWidth;

  // рамка вокруг выделенного измерения
  if TDBGridEh(Sender).SelectedRows.CurrentRowSelected=true then
  begin
    TDBGridEh(Sender).Canvas.Pen.Color:=clBlack;
    TDBGridEh(Sender).Canvas.Pen.Width:=cPenStrikeoutWidth;
    TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top);
    TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top);
    TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top + Rect.Height-1);
    TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top + Rect.Height-1);
  end;

  IsGroupDosOperations;

end;

procedure TMainForm.DBGridEhDosKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = VK_UP) OR
     (Key = VK_DOWN) OR
     (Key = VK_END) OR
     (Key = VK_HOME) OR
     (Key = VK_PRIOR) OR
     (Key = VK_NEXT)) then
  begin
    if NOT (ssShift in Shift) then
    begin
      TDBGridEh(Sender).SelectedRows.Clear;
      TDBGridEh(Sender).SelectedRows.CurrentRowSelected:=true;
      GetDosData;
    end
    else
      GetDosData;
  end;

end;

procedure TMainForm.DBGridEhDosSearchPanelSearchEditChange(Grid: TCustomDBGridEh; SearchEdit: TDBGridSearchPanelTextEditEh);
begin
  Filter:=SearchEdit.Text;
end;

procedure TMainForm.DBGridEhDosTitleClick(Column: TColumnEh);
begin
  GetDosData;
end;

procedure TMainForm.DBGridEhKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = VK_UP) OR
     (Key = VK_DOWN) OR
     (Key = VK_END) OR
     (Key = VK_HOME) OR
     (Key = VK_PRIOR) OR
     (Key = VK_NEXT)) then
  begin
    if NOT (ssShift in Shift) then
    begin

      TDBGridEh(Sender).SelectedRows.Clear;
      TDBGridEh(Sender).SelectedRows.CurrentRowSelected:=true;
      GetMeasData;
    end
    else
      GetMeasData;
  end;
end;

procedure TMainForm.SG_UsersClick(Sender: TObject);
begin
  GetUserPermit(SG_Users.Row{-1});

  if (AW.Users[PermitSelectedRowUser].Login=AW.CurrentUser.Login) then
    CB_SetAsTemlate.Enabled:=false
  else
    CB_SetAsTemlate.Enabled:=true;
end;

procedure TMainForm.SG_UsersKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  GetUserPermit(SG_Users.Row{-1});
end;

function TMainForm.GetUserIndexFromSG(UserName: String): integer;
var
  i     : integer;
  res   : integer;
begin
  res:=-1;

  for i := 0 to SG_Users.RowCount-1 do
  begin
    if SG_Users.Cells[1,i] = UserName then
    begin
      res:=i;
      break;
    end;
  end;

  Result:=res;
end;

procedure TMainForm.GetUserPermit(aUser: integer);
var
  i: integer;
begin
  if aUser>=0 then
  begin
    if PermitSelectedRowUser<>aUser then CB_SetAsTemlate.ItemIndex := -1;
    PermitSelectedRowUser:=aUser;
    PermitMask:=AW.Users[PermitSelectedRowUser].Permit;
    RefreshPermit_CLB;
    CB_SetAsTemlate.Font.Color :=clWindowText;
    for i:=0 to cpTemplateCount-1 do
      if cpTemplatePermits[i] = PermitMask then
      begin
        CB_SetAsTemlate.Color := cl3DLight;
        CB_SetAsTemlate.ItemIndex := i;
      end;
  end;
end;

procedure TMainForm.RefreshPermit_Page;
var
  i: integer;
begin
  SG_Users.Cells[0,0] := cNumberSymbol;
  SG_Users.Cells[1,0] := rsFIO;

  SG_Users.RowCount := Length(AW.Users){+1};

  for i := 1 to Length(AW.Users)-1 do
  begin
    SG_Users.Cells[0,i] := IntToStr(i);
    SG_Users.Cells[1,i] := AW.Users[i].Login;
  end;

  CLB_Permits.Clear;
  for i := 0 to cPermitsCount-1 do
    CLB_Permits.Items.Add(cPermitTexts[cPermitIndex[i]]);

  CB_SetAsTemlate.Clear;
  for i := 0 to cpTemplateCount-1 do
  begin
    CB_SetAsTemlate.Items.Add(cpTemplateTexts[i]);
    CB_SetAsTemlate.Font.Color:=clGray;
  end;

  SG_UsersClick(Self);

end;

procedure TMainForm.ReinitializeCOMPort;
begin
  CloseCOMPort;
  OpenCOMPort;
  //SetW.ConnectionState;
end;

procedure TMainForm.RefreshPermit_CLB;
var
  i: integer;
begin
  for i := 0 to cPermitsCount-1 do
    CLB_Permits.Checked[i] := IsBit64On(PermitMask,cPermitIndex[i]);
end;

procedure TMainForm.GetCalibrData;
var
  i         : integer;
  measNumber: String;
begin
{
  measNumber:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;

  if TabSheetK1.TabVisible then
  begin
    for i := 0 to SeriesK1Err.XValues.Count-1 do
    begin
      SeriesK1Err.ValueColor[i]:=$00A36644;
      SeriesK1.ValueColor[i]:=$00A36644;
    end;

    for i := 0 to SeriesK1Err.XValues.Count-1 do
    if SeriesK1.XLabel[i] = measNumber then
    begin
      SeriesK1Err.ValueColor[i]:=$00ff00E6;
      SeriesK1.ValueColor[i]:=$00ff00E6;
    end;
  end;

  if TabSheetK2.TabVisible then
  begin
    for i := 0 to SeriesK2Err.XValues.Count-1 do
    begin
      SeriesK2Err.ValueColor[i]:=$00A36644;
      SeriesK2.ValueColor[i]:=$00A36644;
    end;

    for i := 0 to SeriesK2Err.XValues.Count-1 do
    if SeriesK2.XLabel[i] = measNumber then
    begin
      SeriesK2Err.ValueColor[i]:=$00ff00E6;
      SeriesK2.ValueColor[i]:=$00ff00E6;
    end;
  end;

  if TabSheetKgn.TabVisible then
  begin
    for i := 0 to SeriesKgnErr.XValues.Count-1 do
    begin
      SeriesKgnErr.ValueColor[i]:=$00A36644;
      SeriesKgn.ValueColor[i]:=$00A36644;
    end;

    for i := 0 to SeriesKgnErr.XValues.Count-1 do
    if SeriesKgn.XLabel[i] = measNumber then
    begin
      SeriesKgnErr.ValueColor[i]:=$00ff00E6;
      SeriesKgn.ValueColor[i]:=$00ff00E6;
    end;
  end;

  if TabSheetKS.TabVisible then
  begin
    for i := 0 to SeriesKS.XValues.Count-1 do
    begin
      SeriesKS.ValueColor[i]:=$00A36644;
    end;

    for i := 0 to SeriesKS.XValues.Count-1 do
    if SeriesKS.XLabel[i] = measNumber then
    begin
      SeriesKS.ValueColor[i]:=$00ff00E6;
    end;
  end;
}
end;

procedure TMainForm.GetMeasData;
var
  dosName   : String;
  dosMeasID : String;
  procedure CreateDosimeter(aDosName: String; aDosMeasID: String);
  begin
//    if (not dosName.IsEmpty) and (not dosMeasID.IsEmpty) then
    if (dosName<>'') and (dosMeasID<>'') then
    begin
      if Assigned(Dosimeter) then FreeAndNil(Dosimeter);

      Dosimeter:=TDosimeter.Create(aDosName,aDosMeasID);
      Dosimeter.MeasurementID:=StrToInt(aDosMeasID);
      Dosimeter.FullNumber:=aDosName;
      HideDetectorsPanel(GetDetCnt(Dosimeter.DosType));
      LoadDosWithMeasData(TLDDataModule.ADOQuery,Dosimeter,aDosMeasID);
    end
    else
      if Assigned(Dosimeter) then FreeAndNil(Dosimeter);
  end;
begin
  if not Start then
  begin
    if TLDDataModule.IsDBConnected then
    begin
////**      ClearLebels;

      case PageControlMain.ActivePage.PageIndex of
        cPageMeasIndex:
        begin
          dosName:=DataSourceMeasList.DataSet.FieldByName(cFullDosID).AsString;
          dosMeasID:=DataSourceMeasList.DataSet.FieldByName(cFieldDosMeasID).AsString;
          CreateDosimeter(dosName,dosMeasID);

          LoadDetData(TLDDataModule.ADOQuery,Dosimeter,dosMeasID);
        end;
        cPageProcessIndex:
        begin
          dosName:=DataSourceProcessList.DataSet.FieldByName(cFullDosID).AsString;
          dosMeasID:=DataSourceProcessList.DataSet.FieldByName(cFieldDosMeasID).AsString;
          CreateDosimeter(dosName,dosMeasID);

          LoadDetData(TLDDataModule.ADOQuery,Dosimeter,dosMeasID);
        end;
        cPageCalibrationIndex:
        begin
          dosName:=DataSourceCalcKDos.DataSet.FieldByName(cFullDosID).AsString;
          dosMeasID:=DataSourceCalcKDos.DataSet.FieldByName(cFieldDosMeasID).AsString;
          CreateDosimeter(dosName,dosMeasID);

          LoadDetData(TLDDataModule.ADOQuery,Dosimeter,dosMeasID);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.GetDosData;
var
  dosName   : String;
begin
  if not Start then
  begin
    if TLDDataModule.IsDBConnected then
    begin
      //***PageControlDosParam.ActivePageIndex:=cPageDosMainParams;

      dosName:=DataSourceDosList.DataSet.FieldByName(cFullDosID).AsString;

//      if (not dosName.IsEmpty) then
      if (dosName<>'') then
      begin
        if Assigned(Dosimeter) then FreeAndNil(Dosimeter);

        Dosimeter:=TDosimeter.Create(dosName);
        Dosimeter.FullNumber:=dosName;
        HideDetectorsPanel(GetDetCnt(Dosimeter.DosType));
        LoadDosData(TLDDataModule.ADOQuery,Dosimeter);

//        if CtrlDown then // проверка на нажатие клавиши Ctrl
//        begin
//          DBGridEhDos.SelectedRows.CurrentRowSelected:=true;
//        end
//        else
//        begin
//          DBGridEhDos.SelectedRows.Clear;
//
//          if DBGridEhDos.SelectedRows.CurrentRowSelected then
//            DBGridEhDos.SelectedRows.CurrentRowSelected:=false
//          else
//            DBGridEhDos.SelectedRows.CurrentRowSelected:=true;
//        end;

      end;
    end;

  end;
end;

function TMainForm.GetDosMeasWithOldK(DosList: TStringList): TStringList;
var
  i,j        : integer;
  fullDosId  : String;
  strList    : TStringList;
  dosID      : String;
  measID     : String;
begin
  Result := TStringList.Create;

  Splash.ProgressBar.Minimum:=0;
  Splash.ProgressBar.Maximum:=DosList.Count;
  Splash.Show(false);
  Splash.SetCaption(rsProcessing);

  for i := 0 to DosList.Count-1 do
  begin
    fullDosId:=DosList[i];

    strList:=TLDDataModule.GetMeasFromDate(DateTimePickerCalibr.Date);
    if Assigned(strList) then
    begin
      for j := 0 to strList.Count-1 do
      begin
        dosID:=copy(strList[j],1,pos('[',strList[j])-1);
        measID:=strList[j];
        delete(measID, 1, pos('[', measID));
        delete(measID, pos(']', measID),1);

        if (dosID = fullDosId) then
        begin
          Result.Add(strList[j]);
        end;

        Splash.ProgressBar.Position:=i;
      end;
    end;

  end;

  Splash.Close;
end;

function TMainForm.GetDosMeasWithOldKInPart(PartID: integer; CalibrDate: TDate): TStringList;
var
  i,j                 : integer;
  strListDosInPart    : TStringList;
  strListMeasFromDate : TStringList;
  dosID               : String;
  measID              : String;
begin
  Result := TStringList.Create;

  strListMeasFromDate:=TLDDataModule.GetMeasFromDate(CalibrDate);
  strListDosInPart:=TLDDataModule.GetDosListInPart(PartID);

  Splash.ProgressBar.Minimum:=0;
  Splash.ProgressBar.Maximum:=strListDosInPart.Count;
  Splash.Show(false);
  Splash.SetCaption(rsProcessing);

  if Assigned(strListDosInPart) then
  begin
    for i := 0 to strListDosInPart.Count-1 do
    begin

      if Assigned(strListMeasFromDate) then
      begin
        for j := 0 to strListMeasFromDate.Count-1 do
        begin
          dosID:=copy(strListMeasFromDate[j],1,pos('[',strListMeasFromDate[j])-1);
          measID:=strListMeasFromDate[j];
          delete(measID, 1, pos('[', measID));
          delete(measID, pos(']', measID),1);

          if (strListDosInPart[i] = dosID) then
          begin
            Result.Add(strListMeasFromDate[j]);
          end;
        end;
      end;

      Splash.ProgressBar.Position:=i;

    end;
  end;

  strListMeasFromDate.Free;
  strListDosInPart.Free;
  Splash.Close;
end;

procedure TMainForm.LoadDetData(ADOQuery: TSQLQuery; aDosimeter: TDosimeter; MeasID: String);
var
  i  : integer;
  f1,
  f2: float;
  function CheckStringNan(Field: String; ADOQuery: TSQLQuery): String;
  begin
    if ADOQuery.FieldByName(Field).AsVariant <> Null then
      Result:=ADOQuery.FieldByName(Field).AsString
    else
      Result:='0';
  end;
  procedure ClearDetsEdit(EditMeasDataDDose,EditMeasDataDStatus: TEdit;SpeedBtnMeasDataWarningD: TSpeedButton);
  begin
    SetDetEdit(EditMeasDataDDose,cEmptyData,cEmptyData,stDetNotMeasured);
    SetDetStateEdit(EditMeasDataDStatus,stDetNotMeasured);
    SpeedBtnMeasDataWarningD.Visible:=false;
  end;
begin
  if (aDosimeter <> nil) then
  begin
    for i := 0 to aDosimeter.DetectorsList.Count-1  do
    begin
      if (aDosimeter.DetectorsList[i] <> nil) then
      begin
        ADOQuery.Active:=False;
        ADOQuery.DisableControls;
        ADOQuery.SQL.Clear;
        ADOQuery.SQL.Add('SELECT '
                                +cFieldDose+','
                                +cFieldDetErr+','
                                +cFieldDetType+','
                                +cFieldMeasureTime+','
                                +cFieldAutoProc+','
                                +cFieldDetStatus+','
                                +cFieldDetComment+','
                                +cFieldBt+','
                                +cFieldBx0+','
                                +cFieldBy0+','
                                +cFieldBxy0+','
                                +cFieldBdy+','
                                +cFieldGm1+','
                                +cFieldGa1+','
                                +cFieldGsl+','
                                +cFieldDgm2+','
                                +cFieldDga2+','
                                +cFieldGsr+','
                                +cFieldN1+','
                                +cFieldN2+','
                                +cFieldS+','
                                +cFieldBn1+','
                                +cFieldBn1Width+','
                                +cFieldBn2+','
                                +cFieldBn2Width+','
                                +cFieldPeakFound+','
                                +cFieldFonFound+','
                                +cFieldKTV+','
                                +cFieldTempProfile+','
                                +cFieldTempProfileWrite+','
                                +cFieldCalcFon+','
                                +cFieldCalcGaus+' '
                                +'FROM '+cDBTableDetRes+' WHERE ('+cFieldDosMeasID+' = '+MeasID+' AND '
                                                                  +cFieldDetPosition+' = '+#39+IntToStr(TDetector(aDosimeter.DetectorsList[i]).Position)+#39+')'); // запрашиваем массив из 300 значений

        ADOQuery.Active:=True;

        f1 := ADOQuery.FieldByName(cFieldBxy0).AsFloat;
        f2 := ADOQuery.FieldByName(cFieldBdy).AsFloat;

        // найти почему не грузится столбец КТВ
        with TDetector(aDosimeter.DetectorsList[i]) do
        begin
          Ktv           := ADOQuery.FieldByName(cFieldKTV).AsString;
          Tmp           := ADOQuery.FieldByName(cFieldTempProfile).AsString;
          TmpWrite      := ADOQuery.FieldByName(cFieldTempProfileWrite).AsString;
          Fon           := ADOQuery.FieldByName(cFieldCalcFon).AsString;
          Gaus          := ADOQuery.FieldByName(cFieldCalcGaus).AsString;
          DetType       := ADOQuery.FieldByName(cFieldDetType).AsString;
          Bt            := ADOQuery.FieldByName(cFieldBt).AsFloat;
          Bx0           := ADOQuery.FieldByName(cFieldBx0).AsFloat;
          By0           := ADOQuery.FieldByName(cFieldBy0).AsFloat;
          Bxy0          := ADOQuery.FieldByName(cFieldBxy0).AsFloat;
          Bdy           := ADOQuery.FieldByName(cFieldBdy).AsFloat;
          Gm1           := ADOQuery.FieldByName(cFieldGm1).AsFloat;
          Ga1           := ADOQuery.FieldByName(cFieldGa1).AsFloat;
          Gsl           := ADOQuery.FieldByName(cFieldGsl).AsFloat;
          Dgm2          := ADOQuery.FieldByName(cFieldDgm2).AsFloat;
          Dga2          := ADOQuery.FieldByName(cFieldDga2).AsFloat;
          Gsr           := ADOQuery.FieldByName(cFieldGsr).AsFloat;
          N1            := ADOQuery.FieldByName(cFieldN1).AsFloat;
          N2            := ADOQuery.FieldByName(cFieldN2).AsFloat;
          S             := ADOQuery.FieldByName(cFieldS).AsFloat;
          BN1           := ADOQuery.FieldByName(cFieldBn1).AsFloat;
          BN1_width     := ADOQuery.FieldByName(cFieldBn1Width).AsFloat;
          BN2           := ADOQuery.FieldByName(cFieldBn2).AsFloat;
          BN2_width     := ADOQuery.FieldByName(cFieldBn2Width).AsFloat;
          PeakFound     := StrToBool(ADOQuery.FieldByName(cFieldPeakFound).AsString);
          FonFound      := StrToBool(ADOQuery.FieldByName(cFieldFonFound).AsString);
          Comment       := ADOQuery.FieldByName(cFieldDetComment).AsString;
          AutoProcessing:= StrToBool(CheckStringNan(cFieldAutoProc,ADOQuery));
          //AutoProcessing:= StrToBool(TLDDataModule.ADOQueryMeasDetsResult.FieldByName(cFieldAutoProc).AsString);
          State         := TDetectorState(ADOQuery.FieldByName(cFieldDetStatus).AsInteger);
          Err           := ADOQuery.FieldByName(cFieldDetErr).AsFloat;                        // последовательность чтения Err затем Dose важна
          Dose          := ADOQuery.FieldByName(cFieldDose).AsFloat;
          MeasureTime   := ADOQuery.FieldByName(cFieldMeasureTime).AsDateTime;
          IsReadFromDB  := true;
          OnShowData(TDetector(aDosimeter.DetectorsList[i]));
        end;

        ADOQuery.Active:=False;
      end
      else
      begin

        case PageControlMain.ActivePage.PageIndex of
          cPageMeasIndex:
          begin
            case i of
              cDetPos1-1: ClearDetsEdit(EditMeasDataD1Dose,EditMeasDataD1Status,SpeedBtnMeasDataWarningD1);
              cDetPos2-1: ClearDetsEdit(EditMeasDataD2Dose,EditMeasDataD2Status,SpeedBtnMeasDataWarningD2);
              cDetPos3-1: ClearDetsEdit(EditMeasDataD3Dose,EditMeasDataD3Status,SpeedBtnMeasDataWarningD3);
              cDetPos4-1: ClearDetsEdit(EditMeasDataD4Dose,EditMeasDataD4Status,SpeedBtnMeasDataWarningD4);
            end;
          end;
          cPageProcessIndex:
          begin
            case i of
              cDetPos1-1: ClearDetsEdit(EditProcessDataD1Dose,EditProcessDataD1Status,SpeedBtnProcessDataWarningD1);
              cDetPos2-1: ClearDetsEdit(EditProcessDataD2Dose,EditProcessDataD2Status,SpeedBtnProcessDataWarningD2);
              cDetPos3-1: ClearDetsEdit(EditProcessDataD3Dose,EditProcessDataD3Status,SpeedBtnProcessDataWarningD3);
              cDetPos4-1: ClearDetsEdit(EditProcessDataD4Dose,EditProcessDataD4Status,SpeedBtnProcessDataWarningD4);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.LoadDosWithMeasData(ADOQuery: TSQLQuery; aDosimeter: TDosimeter; MeasID: String);
  function CheckNan(Field: String; ADOQuery: TSQLQuery): double;
  begin
    if ADOQuery.FieldByName(Field).AsVariant <> Null then
      Result:=ADOQuery.FieldByName(Field).AsFloat
    else
      Result:=NAN;
  end;
begin
  if (aDosimeter <> nil) then
  begin
    ADOQuery.Active:=False;
    ADOQuery.DisableControls;

    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '
                            +cFieldHp10g+','
                            +cFieldHp10n+','
                            +cFieldHp3+','
                            +cFieldHp007+','
                            +cFieldHstar+','
                            +cFieldH007+','
                            +cFieldD+','
                            +cFieldHp10g_err+','
                            +cFieldHp10n_err+','
                            +cFieldHp3_err+','
                            +cFieldHp007_err+','
                            +cFieldHstar_err+','
                            +cFieldH007_err+','
                            +cFieldD_err+','
                            +cFieldError+','
                            +cFieldKSI+','
                            +cFieldDosType+','
                            +cField_k1+','
                            +cField_k2+','
                            +cField_k3+','
                            +cField_k4+','
                            +cField_k5+','
                            +cField_kgn+','
                            +cField_ecc1+','
                            +cField_ecc2+','
                            +cField_ecc3+','
                            +cField_ecc4+','
                            +cFieldKFilter+','
                            +cFieldFormulaId_Dos+','
                            +cFieldFormulaId_Val_1+','
                            +cFieldFormulaId_Val_2+','
                            +cFieldFormulaId_Val_3+','
                            +cFieldFormulaId_Val_4+','
                            +cFieldFormula_Err_k1_1+','
                            +cFieldFormula_Err_k2_1+','
                            +cFieldFormula_Err_k1_2+','
                            +cFieldFormula_Err_k2_2+','
                            +cFieldFormula_Err_k1_3+','
                            +cFieldFormula_Err_k2_3+','
                            +cFieldFormula_Err_k1_4+','
                            +cFieldFormula_Err_k2_4+','
                            +cFieldMeasureTime+','
                            +cFieldRegTime+','
                            +cFieldVerTime+','
                            +cFieldMeasComment+','
                            +cFieldPersNumber+','
                            +cFieldOrg+','
                            +cFieldDepartment+','
                            +cFieldFio+','
                            +cFieldPartID+','
                            +cFieldValidity+','
                            +cFieldDosStatus+' '
                            +'FROM '+cDBTableDosRes+' WHERE ('+cFieldDosMeasID+' = '+MeasID+')');
//                            +'FROM '+cDBTableDosRes+' WHERE ('+cFieldDosMeasID+' = '+MeasID+') AND ('+cFieldTldID+' = '+IntToStr(DeviceID)+')');
    ADOQuery.Active:=True;

    aDosimeter.Validity            := TDosimeterValidity(ADOQuery.FieldByName(cFieldValidity).AsInteger);
    aDosimeter.Error               := ADOQuery.FieldByName(cFieldError).AsString;

    aDosimeter.Dose_Hp_10g         := CheckNan(cFieldHp10g, ADOQuery);
    aDosimeter.Dose_Hp_10n         := CheckNan(cFieldHp10n, ADOQuery);
    aDosimeter.Dose_Hp_3           := CheckNan(cFieldHp3, ADOQuery);
    aDosimeter.Dose_Hp_007         := CheckNan(cFieldHp007, ADOQuery);
    aDosimeter.Dose_H_star         := CheckNan(cFieldHstar, ADOQuery);
    aDosimeter.Dose_H_007          := CheckNan(cFieldH007, ADOQuery);
    aDosimeter.Dose_D              := CheckNan(cFieldD, ADOQuery);

    aDosimeter.Err_Hp_10g          := CheckNan(cFieldHp10g_err, ADOQuery);
    aDosimeter.Err_Hp_10n          := CheckNan(cFieldHp10n_err, ADOQuery);
    aDosimeter.Err_Hp_3            := CheckNan(cFieldHp3_err, ADOQuery);
    aDosimeter.Err_Hp_007          := CheckNan(cFieldHp007_err, ADOQuery);
    aDosimeter.Err_H_star          := CheckNan(cFieldHstar_err, ADOQuery);
    aDosimeter.Err_H_007           := CheckNan(cFieldH007_err, ADOQuery);
    aDosimeter.Err_D               := CheckNan(cFieldD_err, ADOQuery);

    aDosimeter.KFilter             := ADOQuery.FieldByName(cFieldKFilter).AsFloat;
    aDosimeter.DosType             := ADOQuery.FieldByName(cFieldDosType).AsString;
    aDosimeter.KS                  := ADOQuery.FieldByName(cFieldKSI).AsInteger;
    aDosimeter.FormulaID           := ADOQuery.FieldByName(cFieldFormulaId_Dos).AsInteger;
    aDosimeter.Formula             := cDetMeasValTxt_AllVal[ADOQuery.FieldByName(cFieldFormulaId_Dos).AsInteger];
    aDosimeter.FormulaID_Val_1     := ADOQuery.FieldByName(cFieldFormulaId_Val_1).AsInteger;
    aDosimeter.FormulaID_Val_2     := ADOQuery.FieldByName(cFieldFormulaId_Val_2).AsInteger;
    aDosimeter.FormulaID_Val_3     := ADOQuery.FieldByName(cFieldFormulaId_Val_3).AsInteger;
    aDosimeter.FormulaID_Val_4     := ADOQuery.FieldByName(cFieldFormulaId_Val_4).AsInteger;
    aDosimeter.Formula_Val_ErrK1_1 := ADOQuery.FieldByName(cFieldFormula_Err_k1_1).AsFloat;
    aDosimeter.Formula_Val_ErrK2_1 := ADOQuery.FieldByName(cFieldFormula_Err_k2_1).AsFloat;
    aDosimeter.Formula_Val_ErrK1_2 := ADOQuery.FieldByName(cFieldFormula_Err_k1_2).AsFloat;
    aDosimeter.Formula_Val_ErrK2_2 := ADOQuery.FieldByName(cFieldFormula_Err_k2_2).AsFloat;
    aDosimeter.Formula_Val_ErrK1_3 := ADOQuery.FieldByName(cFieldFormula_Err_k1_3).AsFloat;
    aDosimeter.Formula_Val_ErrK2_3 := ADOQuery.FieldByName(cFieldFormula_Err_k2_3).AsFloat;
    aDosimeter.Formula_Val_ErrK1_4 := ADOQuery.FieldByName(cFieldFormula_Err_k1_4).AsFloat;
    aDosimeter.Formula_Val_ErrK2_4 := ADOQuery.FieldByName(cFieldFormula_Err_k2_4).AsFloat;
    aDosimeter.MeasTime            := ADOQuery.FieldByName(cFieldMeasureTime).AsDateTime;
    aDosimeter.VerTime             := ADOQuery.FieldByName(cFieldVerTime).AsDateTime;
    aDosimeter.MeasComment         := ADOQuery.FieldByName(cFieldMeasComment).AsString;
    aDosimeter.PersNumber          := ADOQuery.FieldByName(cFieldPersNumber).AsInteger;
    aDosimeter.Organization        := ADOQuery.FieldByName(cFieldOrg).AsString;
    aDosimeter.Department          := ADOQuery.FieldByName(cFieldDepartment).AsString;
    aDosimeter.FIO                 := ADOQuery.FieldByName(cFieldFIO).AsString;

    aDosimeter.Status              := TDosimeterStatus(ADOQuery.FieldByName(cFieldDosStatus).AsInteger);
    aDosimeter.K1                  := CheckNan(cField_k1, ADOQuery);
    aDosimeter.K2                  := CheckNan(cField_k2, ADOQuery);
    aDosimeter.K3                  := CheckNan(cField_k3, ADOQuery);
    aDosimeter.K4                  := CheckNan(cField_k4, ADOQuery);
    aDosimeter.K5                  := CheckNan(cField_k5, ADOQuery);
    aDosimeter.Kgn                 := CheckNan(cField_kgn, ADOQuery);

    Dosimeter.Ecc1                := CheckNan(cField_ecc1, ADOQuery);
    Dosimeter.Ecc2                := CheckNan(cField_ecc2, ADOQuery);
    Dosimeter.Ecc3                := CheckNan(cField_ecc3, ADOQuery);
    Dosimeter.Ecc4                := CheckNan(cField_ecc4, ADOQuery);

    aDosimeter.Coefficients.Drop;

    if ADOQuery.FieldByName(cField_k1).AsFloat <> 0 then aDosimeter.Coefficients.Add(cField_k1,ADOQuery.FieldByName(cField_k1).AsFloat);
    if ADOQuery.FieldByName(cField_k2).AsFloat <> 0 then aDosimeter.Coefficients.Add(cField_k2,ADOQuery.FieldByName(cField_k2).AsFloat);
    if ADOQuery.FieldByName(cField_k3).AsFloat <> 0 then aDosimeter.Coefficients.Add(cField_k3,ADOQuery.FieldByName(cField_k3).AsFloat);
    if ADOQuery.FieldByName(cField_k4).AsFloat <> 0 then aDosimeter.Coefficients.Add(cField_k4,ADOQuery.FieldByName(cField_k4).AsFloat);
    if ADOQuery.FieldByName(cField_k5).AsFloat <> 0 then aDosimeter.Coefficients.Add(cField_k5,ADOQuery.FieldByName(cField_k5).AsFloat);
    if ADOQuery.FieldByName(cField_kgn).AsFloat <> 0 then aDosimeter.Coefficients.Add(cField_kgn,ADOQuery.FieldByName(cField_kgn).AsFloat);

    aDosimeter.OnChangeK(Self);

    aDosimeter.PartID              := ADOQuery.FieldByName(cFieldPartID).AsInteger;
    ADOQuery.Active:=False;
  end;
end;

procedure TMainForm.LoadDosData(ADOQuery: TSQLQuery; aDosimeter: TDosimeter);
begin
  if (aDosimeter <> nil) then
  begin
    ADOQuery.Active:=False;
    ADOQuery.DisableControls;

    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '
                            +cFieldDosType+','
                            +cFieldPartID+','
                            +cFieldVerTime+','
                            +cFieldRegTime+','
                            +cFieldOrg+','
                            +cFieldDepartment+','
                            +cField_k1+','
                            +cField_k2+','
                            +cField_k3+','
                            +cField_k4+','
                            +cField_k5+','
                            +cField_kgn+','
                            +cFieldDosStatus+','
                            +cFieldLastMeasResult+','
                            +cFieldLastMeasTime+','
                            +cFieldLastMeasComment+' '
                            +'FROM '+cDBTableDosID+' WHERE '+cFieldDosID+' = '+IntToStr(aDosimeter.ID)+' AND '+cFieldDosPostfix+'='+#39+aDosimeter.Postfix+#39);

    ADOQuery.Active:=True;

    aDosimeter.DosType:=ADOQuery.FieldByName(cFieldDosType).AsString;
    aDosimeter.KS:=0;
    aDosimeter.MeasTime:=StrToDateTime(cZeroDate);
    aDosimeter.VerTime:=ADOQuery.FieldByName(cFieldVerTime).AsDateTime;
    aDosimeter.RegTime:=ADOQuery.FieldByName(cFieldRegTime).AsDateTime;
    aDosimeter.LastMeasTime:=ADOQuery.FieldByName(cFieldLastMeasTime).AsDateTime;

    if TLDDataModule.ASIDK_Use then
    begin
      TLDDataModule.ADOQueryASIDK.Active:=False;
      TLDDataModule.ADOQueryASIDK.DisableControls;
      TLDDataModule.ADOQueryASIDK.SQL.Clear;

      TLDDataModule.ADOQueryASIDK.SQL.Add('SELECT * FROM '+cASIDK_dozatld_whohas+'('+#39+IntToStr(aDosimeter.ID)+aDosimeter.Postfix+#39+');');
      TLDDataModule.ADOQueryASIDK.Active:=True;
      aDosimeter.Fio:=TrimRight(TLDDataModule.ADOQueryASIDK.FieldByName(cASIDK_id_fullname).AsString);
      aDosimeter.PersNumber:=StrToIntRegion(TrimRight(TLDDataModule.ADOQueryASIDK.FieldByName(cASIDK_id_person).AsString));
      aDosimeter.Organization:=TrimRight(TLDDataModule.ADOQueryASIDK.FieldByName(cASIDK_organization).AsString);
      aDosimeter.Department:=TrimRight(TLDDataModule.ADOQueryASIDK.FieldByName(cASIDK_department).AsString);
    end
    else
    begin
      aDosimeter.PersNumber:=-1;
      aDosimeter.Organization:=ADOQuery.FieldByName(cFieldOrg).AsString;
      aDosimeter.Department:=ADOQuery.FieldByName(cFieldDepartment).AsString;
    end;

    aDosimeter.Status:=TDosimeterStatus(ADOQuery.FieldByName(cFieldDosStatus).AsInteger);
    aDosimeter.LastMeasResult:=TDosimeterValidity(ADOQuery.FieldByName(cFieldLastMeasResult).AsInteger);
    aDosimeter.LastMeasComment:=ADOQuery.FieldByName(cFieldLastMeasComment).AsString;
    aDosimeter.PartID:=ADOQuery.FieldByName(cFieldPartID).AsInteger;

    aDosimeter.OnChangeMeasValues(Self);
    aDosimeter.OnChangeFormula(Self);
    aDosimeter.OnChangeFullNumber(Self);
    aDosimeter.OnChangeValidity(Self);
    aDosimeter.OnChangeDose(Self);
    aDosimeter.OnChangeErr(Self);
    aDosimeter.OnChangeK(Self);

    ADOQuery.Active:=False;
  end;
end;

procedure TMainForm.LoadDosPartCB(ADOQuery: TSQLQuery; CBox: TComboBox);
var
  i: integer;
begin
  ADOQuery.Active:=False;

  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('SELECT '
                          +cFieldDosPartName+' '
                          +'FROM '+cDBTableDosPart+' ORDER BY '+cFieldPartID);
  ADOQuery.Active:=True;
  ADOQuery.FindFirst;

  CBox.Clear;
  for i:=0 to ADOQuery.RecordCount-1 do
  begin
    CBox.Items.Add(ADOQuery.FieldByName(cFieldDosPartName).AsString);
    if i<>ADOQuery.RecordCount-1 then ADOQuery.Next;
  end;

  ADOQuery.Active:=True;
end;

function TMainForm.GetFilterShowAllDevices(Value: boolean): String;
begin
  if Value then
    result := '('+cFieldTldID+' NOTNULL)'
  else
    result := '('+cFieldTldID+' = '+IntToStr(DeviceID)+')';
end;

function TMainForm.GetFilterSQL: String;
begin
  if CheckSQLScript then
  begin
    if SQLFilterForm.CheckScript then
    begin
      Result:=SQLFilterForm.ResultSQLString;
    end
    else
    begin
      SQLFilterForm.DropScript;
      if SQLFilterForm.CheckScript then Result:=SQLFilterForm.ResultSQLString else Result:=' ORDER BY measurmenttime DESC';
    end;
  end
    else Result:=' ORDER BY measurmenttime DESC';
end;

function TMainForm.GetFilterMeasToDel(Value: boolean): String;
begin
  if Value then
    //result := '('+cFieldToDel+' LIKE '+#39+'%'+#39+')'
    //result := '('+cFieldToDel+'='+BoolToStrRegion(Value)+' OR '+cFieldToDel+'='+BoolToStrRegion(not Value)+')'
    result := '('+cFieldToDel+' NOTNULL)'
  else
    result := '('+cFieldToDel+'='+BoolToStrRegion(Value)+')';
end;

function TMainForm.GetFilterMeas(Field: String): String;
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
//      case AnsiIndexStr(Field,[cFieldOrg,cFieldDepartment,cFieldPartID,cFieldDosType,cFieldDosStatus,cFieldValidity,cFieldMeasComment]) of
//        0:
//        begin
//          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterMeasDosName,GetFilterDosDepartment(CBoxMeasDep),GetFilterDosPartID(CBoxMeasDosPart),GetFilterDosType(CBoxMeasDosType),GetFilterDosStatus(CBoxMeasStatus),GetFilterDosValidity(CBoxMeasResult),GetFilterMeasComment(CBoxMeasComment),GetFilterDosTime(DateTimePickerMeasFrom,DateTimePickerMeasTo)]);
//        end;
//        1:
//        begin
//          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterMeasDosName,GetFilterDosOrganization(CBoxMeasOrgName),GetFilterDosPartID(CBoxMeasDosPart),GetFilterDosType(CBoxMeasDosType),GetFilterDosStatus(CBoxMeasStatus),GetFilterDosValidity(CBoxMeasResult),GetFilterMeasComment(CBoxMeasComment),GetFilterDosTime(DateTimePickerMeasFrom,DateTimePickerMeasTo)]);
//        end;
//        2:
//        begin
//          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterMeasDosName,GetFilterDosOrganization(CBoxMeasOrgName),GetFilterDosDepartment(CBoxMeasDep),GetFilterDosType(CBoxMeasDosType),GetFilterDosStatus(CBoxMeasStatus),GetFilterDosValidity(CBoxMeasResult),GetFilterMeasComment(CBoxMeasComment),GetFilterDosTime(DateTimePickerMeasFrom,DateTimePickerMeasTo)]);
//        end;
//        3:
//        begin
//          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterMeasDosName,GetFilterDosOrganization(CBoxMeasOrgName),GetFilterDosDepartment(CBoxMeasDep),GetFilterDosPartID(CBoxMeasDosPart),GetFilterDosStatus(CBoxMeasStatus),GetFilterDosValidity(CBoxMeasResult),GetFilterMeasComment(CBoxMeasComment),GetFilterDosTime(DateTimePickerMeasFrom,DateTimePickerMeasTo)]);
//        end;
//        4:
//        begin
//          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterMeasDosName,GetFilterDosOrganization(CBoxMeasOrgName),GetFilterDosDepartment(CBoxMeasDep),GetFilterDosPartID(CBoxMeasDosPart),GetFilterDosType(CBoxMeasDosType),GetFilterDosValidity(CBoxMeasResult),GetFilterMeasComment(CBoxMeasComment),GetFilterDosTime(DateTimePickerMeasFrom,DateTimePickerMeasTo)]);
//        end;
//        5:
//        begin
//          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterMeasDosName,GetFilterDosOrganization(CBoxMeasOrgName),GetFilterDosDepartment(CBoxMeasDep),GetFilterDosPartID(CBoxMeasDosPart),GetFilterDosType(CBoxMeasDosType),GetFilterDosStatus(CBoxMeasStatus),GetFilterMeasComment(CBoxMeasComment),GetFilterDosTime(DateTimePickerMeasFrom,DateTimePickerMeasTo)]);
//        end;
//        6:
//        begin
//          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterMeasDosName,GetFilterDosOrganization(CBoxMeasOrgName),GetFilterDosDepartment(CBoxMeasDep),GetFilterDosPartID(CBoxMeasDosPart),GetFilterDosType(CBoxMeasDosType),GetFilterDosStatus(CBoxMeasStatus),GetFilterDosValidity(CBoxMeasResult),GetFilterDosTime(DateTimePickerMeasFrom,DateTimePickerMeasTo)]);
//        end;
//      end;
    end;
    cPageProcessIndex:
    begin
      case AnsiIndexStr(Field,[cFieldOrg,cFieldDepartment,cFieldPartID,cFieldDosType,cFieldDosStatus,cFieldValidity,cFieldMeasComment,cFieldTldID]) of
        0:
        begin
          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterProcessDosName,GetFilterDosDepartment(CBoxProcessDep),GetFilterDosPartID(CBoxProcessDosPart),GetFilterDosType(CBoxProcessDosType),GetFilterDosStatus(CBoxProcessStatus),GetFilterDosValidity(CBoxProcessResult),GetFilterMeasComment(CBoxProcessComment),GetFilterDeviceID(CBoxProcessDeviceID),GetFilterMeasToDel(ShowDelMeas),GetFilterDosTime(DateTimePickerProcessFrom,DateTimePickerProcessTo)]);
        end;
        1:
        begin
          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterProcessDosName,GetFilterDosOrganization(CBoxProcessOrgName),GetFilterDosPartID(CBoxProcessDosPart),GetFilterDosType(CBoxProcessDosType),GetFilterDosStatus(CBoxProcessStatus),GetFilterDosValidity(CBoxProcessResult),GetFilterMeasComment(CBoxProcessComment),GetFilterDeviceID(CBoxProcessDeviceID),GetFilterMeasToDel(ShowDelMeas),GetFilterDosTime(DateTimePickerProcessFrom,DateTimePickerProcessTo)]);
        end;
        2:
        begin
          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterProcessDosName,GetFilterDosOrganization(CBoxProcessOrgName),GetFilterDosDepartment(CBoxProcessDep),GetFilterDosType(CBoxProcessDosType),GetFilterDosStatus(CBoxProcessStatus),GetFilterDosValidity(CBoxProcessResult),GetFilterMeasComment(CBoxProcessComment),GetFilterDeviceID(CBoxProcessDeviceID),GetFilterMeasToDel(ShowDelMeas),GetFilterDosTime(DateTimePickerProcessFrom,DateTimePickerProcessTo)]);
        end;
        3:
        begin
          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterProcessDosName,GetFilterDosOrganization(CBoxProcessOrgName),GetFilterDosDepartment(CBoxProcessDep),GetFilterDosPartID(CBoxProcessDosPart),GetFilterDosStatus(CBoxProcessStatus),GetFilterDosValidity(CBoxProcessResult),GetFilterMeasComment(CBoxProcessComment),GetFilterDeviceID(CBoxProcessDeviceID),GetFilterMeasToDel(ShowDelMeas),GetFilterDosTime(DateTimePickerProcessFrom,DateTimePickerProcessTo)]);
        end;
        4:
        begin
          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterProcessDosName,GetFilterDosOrganization(CBoxProcessOrgName),GetFilterDosDepartment(CBoxProcessDep),GetFilterDosPartID(CBoxProcessDosPart),GetFilterDosType(CBoxProcessDosType),GetFilterDosValidity(CBoxProcessResult),GetFilterMeasComment(CBoxProcessComment),GetFilterDeviceID(CBoxProcessDeviceID),GetFilterMeasToDel(ShowDelMeas),GetFilterDosTime(DateTimePickerProcessFrom,DateTimePickerProcessTo)]);
        end;
        5:
        begin
          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterProcessDosName,GetFilterDosOrganization(CBoxProcessOrgName),GetFilterDosDepartment(CBoxProcessDep),GetFilterDosPartID(CBoxProcessDosPart),GetFilterDosType(CBoxProcessDosType),GetFilterDosStatus(CBoxProcessStatus),GetFilterMeasComment(CBoxProcessComment),GetFilterDeviceID(CBoxProcessDeviceID),GetFilterMeasToDel(ShowDelMeas),GetFilterDosTime(DateTimePickerProcessFrom,DateTimePickerProcessTo)]);
        end;
        6:
        begin
          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterProcessDosName,GetFilterDosOrganization(CBoxProcessOrgName),GetFilterDosDepartment(CBoxProcessDep),GetFilterDosPartID(CBoxProcessDosPart),GetFilterDosType(CBoxProcessDosType),GetFilterDosStatus(CBoxProcessStatus),GetFilterDosValidity(CBoxProcessResult),GetFilterDeviceID(CBoxProcessDeviceID),GetFilterMeasToDel(ShowDelMeas),GetFilterDosTime(DateTimePickerProcessFrom,DateTimePickerProcessTo)]);
        end;
        7:
        begin
          Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s AND %s %s',[GetFilterProcessDosName,GetFilterDosOrganization(CBoxProcessOrgName),GetFilterDosDepartment(CBoxProcessDep),GetFilterDosPartID(CBoxProcessDosPart),GetFilterDosType(CBoxProcessDosType),GetFilterDosStatus(CBoxProcessStatus),GetFilterDosValidity(CBoxProcessResult),GetFilterMeasComment(CBoxProcessComment),GetFilterMeasToDel(ShowDelMeas),GetFilterDosTime(DateTimePickerProcessFrom,DateTimePickerProcessTo)]);
        end;
      end;
    end;
  end;
end;

function TMainForm.GetFilterDeviceID(ComboBox: TComboBox): String;
begin
  if ComboBox.Text = '' then
    result := '('+cFieldTldID+' > -1000)'
  else
    result := '('+cFieldTldID+' = '+ComboBox.Text+')';
end;

function TMainForm.GetFilterDos(Field: String): String;
begin
  case AnsiIndexStr(Field,[cFieldOrg,cFieldDepartment,cFieldPartID,cFieldDosType,cFieldDosStatus,cFieldTldID]) of
    0:
    begin
      Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s',[GetFilterDosDosName,GetFilterDosDepartment(CBoxDosDep),GetFilterDosPartID(CBoxDosDosPart),GetFilterDosType(CBoxDosDosType),GetFilterDosStatus(CBoxDosStatus),GetFilterDeviceID(CBoxDosDeviceID)]);
    end;
    1:
    begin
      Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s',[GetFilterDosDosName,GetFilterDosOrganization(CBoxDosOrgName),GetFilterDosPartID(CBoxDosDosPart),GetFilterDosType(CBoxDosDosType),GetFilterDosStatus(CBoxDosStatus),GetFilterDeviceID(CBoxDosDeviceID)]);
    end;
    2:
    begin
      Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s',[GetFilterDosDosName,GetFilterDosOrganization(CBoxDosOrgName),GetFilterDosDepartment(CBoxDosDep),GetFilterDosType(CBoxDosDosType),GetFilterDosStatus(CBoxDosStatus),GetFilterDeviceID(CBoxDosDeviceID)]);
    end;
    3:
    begin
      Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s',[GetFilterDosDosName,GetFilterDosOrganization(CBoxDosOrgName),GetFilterDosDepartment(CBoxDosDep),GetFilterDosPartID(CBoxDosDosPart),GetFilterDosStatus(CBoxDosStatus),GetFilterDeviceID(CBoxDosDeviceID)]);
    end;
    4:
    begin
      Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s',[GetFilterDosDosName,GetFilterDosOrganization(CBoxDosOrgName),GetFilterDosDepartment(CBoxDosDep),GetFilterDosPartID(CBoxDosDosPart),GetFilterDosType(CBoxDosDosType),GetFilterDeviceID(CBoxDosDeviceID)]);
    end;
    5:
    begin
      Result:=Format('WHERE %s AND %s AND %s AND %s AND %s AND %s',[GetFilterDosDosName,GetFilterDosOrganization(CBoxDosOrgName),GetFilterDosDepartment(CBoxDosDep),GetFilterDosPartID(CBoxDosDosPart),GetFilterDosType(CBoxDosDosType),GetFilterDosStatus(CBoxDosStatus)]);
    end
    else Result:='';
  end;
end;

procedure TMainForm.LoadColumnsGridDos;
begin
  sppDosColDosType.Checked:=DosColumnDosType;
  sppDosColStatusDos.Checked:=DosColumnDosState;
  sppDosCol_k1.Checked:=DosColumnk1;
  sppDosCol_k2.Checked:=DosColumnk2;
  sppDosCol_k3.Checked:=DosColumnk3;
  sppDosCol_k4.Checked:=DosColumnk4;
  sppDosCol_k5.Checked:=DosColumnk5;
  sppDosCol_kgn.Checked:=DosColumnkgn;
  sppDosColPart.Checked:=DosColumnPartID;
  sppDosColDateRegister.Checked:=DosColumnRegTime;
  sppDosColDateVerification.Checked:=DosColumnVerTime;
  sppDosColOrg.Checked:=DosColumnOrg;
  sppDosColDep.Checked:=DosColumnDep;
  sppDosColLastMeasComment.Checked:=DosColumnLastMeasComment;
  sppDosColDeviceID.Checked:=DosColumnTldID;
//  ppDosStatusSetWarningComment.Checked:=UserWarningComment;
end;

procedure TMainForm.LoadColumnsGridMeas;
begin
  sppMeasColMeasID.Checked:=MeasColumnMeasID;
  sppMeasColMeasTime.Checked:=MeasColumnMeasDateTime;
  sppMeasColKSI.Checked:=MeasColumnKSI;
  sppMeasColDose.Checked:=MeasColumnDose;
  sppMeasColHp10g.Checked:=MeasColumnHp10g;
  sppMeasColHp10n.Checked:=MeasColumnHp10n;
  sppMeasColHp007.Checked:=MeasColumnHp007;
  sppMeasColHp3.Checked:=MeasColumnHp3;
  sppMeasColHstar.Checked:=MeasColumnHStar;
  sppMeasColH007.Checked:=MeasColumnH007;
  sppMeasColD.Checked:=MeasColumnD;

  sppMeasColHp10g_Err.Visible:=MeasColumnHp10g;
  sppMeasColHp10g_Err.Checked:=MeasColumnHp10g_Err;

  sppMeasColHp10n_Err.Visible:=MeasColumnHp10n;
  sppMeasColHp10n_Err.Checked:=MeasColumnHp10n_Err;

  sppMeasColHp007_Err.Visible:=MeasColumnHp007;
  sppMeasColHp007_Err.Checked:=MeasColumnHp007_Err;

  sppMeasColHp3_Err.Visible:=MeasColumnHp3;
  sppMeasColHp3_Err.Checked:=MeasColumnHp3_Err;

  sppMeasColHstar_Err.Visible:=MeasColumnHStar;
  sppMeasColHstar_Err.Checked:=MeasColumnHStar_Err;

  sppMeasColH007_Err.Visible:=MeasColumnH007;
  sppMeasColH007_Err.Checked:=MeasColumnH007_Err;

  sppMeasColD_Err.Visible:=MeasColumnD;
  sppMeasColD_Err.Checked:=MeasColumnD_Err;

  sppMeasColStatusMeas.Checked:=MeasColumnMeasValidity;
  sppMeasColDosType.Checked:=MeasColumnDosType;
  sppMeasColDateRegister.Checked:=MeasColumnDosReg;
  sppMeasColDateVerification.Checked:=MeasColumnDosVer;
  sppMeasColStatusDos.Checked:=MeasColumnDosStatus;
  sppMeasColOrg.Checked:=MeasColumnOrganization;
  sppMeasColDep.Checked:=MeasColumnDepartment;
  sppMeasColPart.Checked:=MeasColumnPartID;
  sppMeasColCommentMeas.Checked:=MeasColumnMeasComment;
  sppMeasColPersNumber.Checked:=MeasColumnPersNumber;
  sppMeasColFIO.Checked:=MeasColumnFIO;
  sppMeasColDeviceUser.Checked:=MeasColumnTLDUser;
  sppMeasColDeviceID.Checked:=MeasColumnTldID;
  sppMeasColLastMeasDate.Checked:=MeasColumnLastMeasTime;
  sppMeasColCommentDos.Checked:=MeasColumnLastMeasComment;

  sppProcessColMeasID.Checked:=ProcessColumnMeasID;
  sppProcessColMeasTime.Checked:=ProcessColumnMeasDateTime;
  sppProcessColKSI.Checked:=ProcessColumnKSI;
  sppProcessColDose.Checked:=ProcessColumnDose;
  sppProcessColHp10g.Checked:=ProcessColumnHp10g;
  sppProcessColHp10n.Checked:=ProcessColumnHp10n;
  sppProcessColHp007.Checked:=ProcessColumnHp007;
  sppProcessColHp3.Checked:=ProcessColumnHp3;
  sppProcessColHstar.Checked:=ProcessColumnHStar;
  sppProcessColH007.Checked:=ProcessColumnH007;
  sppProcessColD.Checked:=ProcessColumnD;

  sppProcessColHp10g_Err.Visible:=ProcessColumnHp10g;
  sppProcessColHp10g_Err.Checked:=ProcessColumnHp10g_Err;

  sppProcessColHp10n_Err.Visible:=ProcessColumnHp10n;
  sppProcessColHp10n_Err.Checked:=ProcessColumnHp10n_Err;

  sppProcessColHp007_Err.Visible:=ProcessColumnHp007;
  sppProcessColHp007_Err.Checked:=ProcessColumnHp007_Err;

  sppProcessColHp3_Err.Visible:=ProcessColumnHp3;
  sppProcessColHp3_Err.Checked:=ProcessColumnHp3_Err;

  sppProcessColHstar_Err.Visible:=ProcessColumnHStar;
  sppProcessColHstar_Err.Checked:=ProcessColumnHStar_Err;

  sppProcessColH007_Err.Visible:=ProcessColumnH007;
  sppProcessColH007_Err.Checked:=ProcessColumnH007_Err;

  sppProcessColD_Err.Visible:=ProcessColumnD;
  sppProcessColD_Err.Checked:=ProcessColumnD_Err;

  sppProcessColStatusMeas.Checked:=ProcessColumnMeasValidity;
  sppProcessColDosType.Checked:=ProcessColumnDosType;
  sppProcessColDateRegister.Checked:=ProcessColumnDosReg;
  sppProcessColDateVerification.Checked:=ProcessColumnDosVer;
  sppProcessColStatusDos.Checked:=ProcessColumnDosStatus;
  sppProcessColOrg.Checked:=ProcessColumnOrganization;
  sppProcessColDep.Checked:=ProcessColumnDepartment;
  sppProcessColPart.Checked:=ProcessColumnPartID;
  sppProcessColCommentMeas.Checked:=ProcessColumnMeasComment;
  sppProcessColPersNumber.Checked:=ProcessColumnPersNumber;
  sppProcessColFIO.Checked:=ProcessColumnFIO;
  sppProcessColDeviceUser.Checked:=ProcessColumnTLDUser;
  sppProcessColDeviceID.Checked:=ProcessColumnTldID;
  sppProcessColLastMeasDate.Checked:=ProcessColumnLastMeasTime;
  sppProcessColCommentDos.Checked:=ProcessColumnLastMeasComment;

  sppCalibrColMeasID.Checked:=CalibrColumnMeasID;
  sppCalibrColMeasTime.Checked:=CalibrColumnMeasDateTime;
  sppCalibrColKSI.Checked:=CalibrColumnKSI;
  sppCalibrColDose.Checked:=CalibrColumnDose;
  sppCalibrColHp10g.Checked:=CalibrColumnHp10g;
  sppCalibrColHp10n.Checked:=CalibrColumnHp10n;
  sppCalibrColHp007.Checked:=CalibrColumnHp007;
  sppCalibrColHp3.Checked:=CalibrColumnHp3;
  sppCalibrColHstar.Checked:=CalibrColumnHStar;
  sppCalibrColH007.Checked:=CalibrColumnH007;
  sppCalibrColD.Checked:=CalibrColumnD;

  sppCalibrColK1.Checked:=CalibrColumnK1;
  sppCalibrColK2.Checked:=CalibrColumnK2;
  sppCalibrColK3.Checked:=CalibrColumnK3;
  sppCalibrColK4.Checked:=CalibrColumnK4;
  sppCalibrColK5.Checked:=CalibrColumnK5;
  sppCalibrColKgn.Checked:=CalibrColumnKgn;

  sppCalibrColDosType.Checked:=CalibrColumnDosType;
  sppCalibrColDeviceID.Checked:=CalibrColumnTldID;
end;

procedure TMainForm.LoadComboBox(ComboBox: TComboBox; Field: String);
var
  i           : integer;
  tableName   : String;
  filterName  : String;
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex,cPageProcessIndex:
    begin
      if ComboBox.Name='CBoxDosDosPart' then
      begin
        tableName:=cDBTableDosPart;
        Field:=cFieldDosPartName;
      end
      else
      begin
        tableName:=cDBTableDosRes;
        filterName:=GetFilterMeas(Field);
      end;
    end;
    cPageDosIndex:
    begin
      if ComboBox.Name='CBoxDosDosPart' then
      begin
        tableName:=cDBTableDosPart;
        Field:=cFieldDosPartName;
      end
      else
      begin
        tableName:=cDBTableDosID;
        filterName:=GetFilterDos(Field);
      end;
    end
    else
    begin
      if ComboBox.Name='CBoxDosDosPart' then
      begin
        tableName:=cDBTableDosPart;
        Field:=cFieldDosPartName;
      end
      else
      begin
        tableName:=cDBTableDosRes;
        filterName:=GetFilterMeas(Field);
      end;
    end;
  end;

  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
//  TLDDataModule.ADOQueryInf.SQL.Add(Format('SELECT DISTINCT %s FROM %s %s ORDER BY %s',[Field,tableName,filterName,Field]));

  TLDDataModule.ADOQuery.SQL.Add('SELECT DISTINCT '+Field+' FROM '+tableName+' '+filterName+' ORDER BY '+Field);
  TLDDataModule.ADOQuery.Active:=True;
  TLDDataModule.ADOQuery.First;

  ComboBox.Items.Clear;
  for i := 1 to TLDDataModule.ADOQuery.RecordCount do
  begin
    if Field = cFieldValidity then
    begin
      if ComboBox.Items.IndexOf(GetDosStrValidity(TLDDataModule.ADOQuery.FieldByName(Field).AsInteger)) < 0 then ComboBox.Items.Add(GetDosStrValidity(TLDDataModule.ADOQuery.FieldByName(Field).AsInteger))
    end
    else if Field = cFieldDosStatus then
      ComboBox.Items.Add(GetDosStrStatus(TLDDataModule.ADOQuery.FieldByName(Field).AsInteger))
    else
      ComboBox.Items.Add(TLDDataModule.ADOQuery.FieldByName(Field).AsString);

    TLDDataModule.ADOQuery.Next;
  end;

  TLDDataModule.ADOQuery.Close;
end;

//var
////  infoObject: TStringObject;
//  dataObject: TStringList;
//function IndexOfObjectText(const S: String): Integer;
//var
//  I : Integer;
//begin
//  Result := -1;
//  for I := 0 to dataObject.Count-1 do
//  begin
//    if TObject(dataObject.Objects[I]).stringData.IndexOf(S) <> -1 then
//    begin
//      Result := I;
//      Exit;
//    end;
//  end;
//end;

procedure TMainForm.LoadComboBoxFromIni(ComboBox: TComboBox; Value: String);
begin
  if (ComboBox.Items.IndexOf(Value) >= 0) AND (Value <> '')then
    ComboBox.ItemIndex:=StringsIndexof(ComboBox.Items,Value) // поиск в комбобоксе с учетом регистра
  else
    ComboBox.ItemIndex:=-1;
end;

procedure TMainForm.LoadDateTimeFromIni(Value: String; DataPicker: TDateTimePicker; SpeedBtn: TSpeedButton);
begin
  if Value <> '' then
  begin
    DataPicker.DateTime:=StrToDateTime(Value);
    SetUseFilterDate(DataPicker,SpeedBtn,true);
  end
  else
    SetUseFilterDate(DataPicker,SpeedBtn,false);
end;

procedure TMainForm.LoadCBoxSourceTest;
var
  i: integer;
begin
  CBoxDosimeterTest.Clear;

  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add(TLDDataModule.GetSQLSingleCol(DeviceID));
  TLDDataModule.ADOQuery.Active:=True;

  for i := 1 to TLDDataModule.ADOQuery.RecordCount do
  begin
    CBoxDosimeterTest.Items.Add(TLDDataModule.ADOQuery.FieldValues[cFullDosID]);

    if i <> TLDDataModule.ADOQuery.RecordCount then TLDDataModule.ADOQuery.Next;
  end;

  CBoxDosimeterTest.Text:=TestSourceDosimeterName;
end;

procedure TMainForm.LoadCheckBoxFromIni(CheckBox: TCheckBox; Value: boolean);
begin
  if CheckBox.Checked<>Value then
    CheckBox.Checked:=Value;
end;

procedure TMainForm.ShowCalcFunctions(aDetPos: integer);
begin

  CheckVisibleKTV;

  case aDetPos of
    cDetPos1:
    begin
      ShowDetectorData(SeriesMeasD1KTV,TDetector(Dosimeter.CntDetector).Ktv);
      ShowDetectorData(SeriesMeasD1Gaus,TDetector(Dosimeter.CntDetector).Gaus);
      ShowDetectorData(SeriesMeasD1Fon,TDetector(Dosimeter.CntDetector).Fon);
//      ShowDetectorData(ChartToolBorderMeasD1,TDetector(Dosimeter.CntDetector).N1,TDetector(Dosimeter.CntDetector).N2,TDetector(Dosimeter.CntDetector).PeakFound);
      ShowDetectorDataGlade(SeriesMeasD1KTV,SeriesMeasD1Glade);
      DSeriaAutoSize(TLDChartMeasDataD1,SeriesMeasD1KTV);
    end;
    cDetPos2:
    begin
      ShowDetectorData(SeriesMeasD2KTV,TDetector(Dosimeter.CntDetector).Ktv);
      ShowDetectorData(SeriesMeasD2Gaus,TDetector(Dosimeter.CntDetector).Gaus);
      ShowDetectorData(SeriesMeasD2Fon,TDetector(Dosimeter.CntDetector).Fon);
//      ShowDetectorData(ChartToolBorderMeasD2,TDetector(Dosimeter.CntDetector).N1,TDetector(Dosimeter.CntDetector).N2,TDetector(Dosimeter.CntDetector).PeakFound);
      ShowDetectorDataGlade(SeriesMeasD2KTV,SeriesMeasD2Glade);
      DSeriaAutoSize(TLDChartMeasDataD2,SeriesMeasD2KTV);
    end;
    cDetPos3:
    begin
      ShowDetectorData(SeriesMeasD3KTV,TDetector(Dosimeter.CntDetector).Ktv);
      ShowDetectorData(SeriesMeasD3Gaus,TDetector(Dosimeter.CntDetector).Gaus);
      ShowDetectorData(SeriesMeasD3Fon,TDetector(Dosimeter.CntDetector).Fon);
//      ShowDetectorData(ChartToolBorderMeasD3,TDetector(Dosimeter.CntDetector).N1,TDetector(Dosimeter.CntDetector).N2,TDetector(Dosimeter.CntDetector).PeakFound);
      ShowDetectorDataGlade(SeriesMeasD3KTV,SeriesMeasD3Glade);
      DSeriaAutoSize(TLDChartMeasDataD3,SeriesMeasD3KTV);
    end;
    cDetPos4:
    begin
      ShowDetectorData(SeriesMeasD4KTV,TDetector(Dosimeter.CntDetector).Ktv);
      ShowDetectorData(SeriesMeasD4Gaus,TDetector(Dosimeter.CntDetector).Gaus);
      ShowDetectorData(SeriesMeasD4Fon,TDetector(Dosimeter.CntDetector).Fon);
//      ShowDetectorData(ChartToolBorderMeasD4,TDetector(Dosimeter.CntDetector).N1,TDetector(Dosimeter.CntDetector).N2,TDetector(Dosimeter.CntDetector).PeakFound);
      ShowDetectorDataGlade(SeriesMeasD4KTV,SeriesMeasD4Glade);
      DSeriaAutoSize(TLDChartMeasDataD4,SeriesMeasD4KTV);
    end;
  end;
end;

procedure TMainForm.ShowDetectorInf(Dose: String;
                                    Err: String;
                                    DetType: String;
                                    DetPos: integer;
                                    DetState: TDetectorState);
begin
  case DetPos of
    cDetPos1:
    begin
      SetDetEdit(EditMeasDataD1Dose,Dose,Err,DetState);
      //SetDetEdit(EditD1Err,Err,DetState);
      SetDetStateEdit(EditMeasDataD1Status,DetState);
    end;
    cDetPos2:
    begin
      SetDetEdit(EditMeasDataD2Dose,Dose,Err,DetState);
      //SetDetEdit(EditD2Err,Err,DetState);
      SetDetStateEdit(EditMeasDataD2Status,DetState);
    end;
    cDetPos3:
    begin
      SetDetEdit(EditMeasDataD3Dose,Dose,Err,DetState);
      //SetDetEdit(EditD3Err,Err,DetState);
      SetDetStateEdit(EditMeasDataD3Status,DetState);
    end;
    cDetPos4:
    begin
      SetDetEdit(EditMeasDataD4Dose,Dose,Err,DetState);
      //SetDetEdit(EditD4Err,Err,DetState);
      SetDetStateEdit(EditMeasDataD4Status,DetState);
    end;
  end;
end;

procedure TMainForm.ShowInChart(aChart: TChart; aSeriea: integer; aData: String; aDosimeterID: String);
var
  i      : integer;
  ts     : TStringList;
begin
  if aData<>'{}' then
  begin
    ts:=TStringList.Create;
    ts.Delimiter:=',';                                        // устанавливаем разделитель
    ts.DelimitedText:=aData;
    ts.Text:=StringReplace(ts.Text,'{','',[rfreplaceall]);    // удаляем фигурные скобки
    ts.Text:=StringReplace(ts.Text,'}','',[rfreplaceall]);

    TLineSeries(aChart.Series[aSeriea]).Clear; // очищаем чарт
    aChart.Title.Text.Text := format(rsChartTitle,[aDosimeterID]);

    if ts.Count>0 then
    begin
      for i := 0 to ts.Count-1 do                             // выводим в TChart
      begin
        TLineSeries(aChart.Series[aSeriea]).AddXY(i,StrToFloatRegion(ts[i]));
      end;
    end;

    ts.Free;

  end;
end;

procedure TMainForm.ShowDetectorData(Seria: TLineSeries; Data: String);
var
  i      : integer;
  ts     : TStringList;
begin
  if Data<>'{}' then
  begin
    ts:=TStringList.Create;
    ts.Delimiter:=',';                                        // устанавливаем разделитель
    ts.DelimitedText:=Data;
    ts.Text:=StringReplace(ts.Text,'{','',[rfreplaceall]);    // удаляем фигурные скобки
    ts.Text:=StringReplace(ts.Text,'}','',[rfreplaceall]);

    Seria.Clear;

    if ts.Count>0 then
    begin
      if ts.Count>300 then                                                                                             //
        for i := 2 to ts.Count-1 do Seria.AddXY(i-2,(StrToFloatRegion(ts[i]))/10)
      else
        for i := 0 to ts.Count-1 do Seria.AddXY(i,StrToFloatRegion(ts[i]))
    end;

    ts.Free;

  end;
end;

procedure TMainForm.ShowDetectorData(Seria: TLineSeries; Data: string; aK1Profile, aK2Profile: double);
var
  i      : integer;
  ts     : TStringList;
begin
  if Data<>'{}' then
  begin
    ts:=TStringList.Create;
    ts.Delimiter:=',';                                        // устанавливаем разделитель
    ts.DelimitedText:=Data;
    ts.Text:=StringReplace(ts.Text,'{','',[rfreplaceall]);    // удаляем фигурные скобки
    ts.Text:=StringReplace(ts.Text,'}','',[rfreplaceall]);

    Seria.Clear;

    if ts.Count>0 then
    begin
      if aK1Profile>0 then
        for i := 0 to ts.Count-1 do Seria.AddXY(i,(StrToFloatRegion(ts[i])*aK1Profile-aK2Profile))
      else
        for i := 0 to ts.Count-1 do Seria.AddXY(i,(StrToFloatRegion(ts[i]))/10)
    end;

    ts.Free;

  end;
end;

procedure TMainForm.ShowDetectorData(Seria: TAreaSeries; Data: String);
var
  i      : integer;
  ts     : TStringList;
begin
  if Data<>'{}' then
  begin
    ts:=TStringList.Create;
    ts.Delimiter:=',';                                        // устанавливаем разделитель
    ts.DelimitedText:=Data;
    ts.Text:=StringReplace(ts.Text,'{','',[rfreplaceall]);    // удаляем фигурные скобки
    ts.Text:=StringReplace(ts.Text,'}','',[rfreplaceall]);

    Seria.Clear;

    if ts.Count>0 then
    begin
      for i := 0 to ts.Count-1 do Seria.AddXY(i,StrToFloatRegion(ts[i]));
    end;

    ts.Free;

  end;
end;

procedure TMainForm.ShowDetectorComment(DetPos: integer);
begin
  if Assigned(Dosimeter) then
  begin
    if Assigned(Dosimeter.DetectorsList[DetPos-1]) then
    begin
      WarningCommentForm.MemoMsg.Text:=TDetector(Dosimeter.DetectorsList[DetPos-1]).Comment;

      case TDetector(Dosimeter.DetectorsList[DetPos-1]).State of
        stDetProcessedError:
          WarningCommentForm.Caption:=rsDosMeasErr;
        stDetProcessedWarning:
          WarningCommentForm.Caption:=rsDosMeasWarning;
      end;

      WarningCommentForm.DetPos:=DetPos;
      WarningCommentForm.ShowModal;
    end;
  end;
end;

{ надо сначала найти замену TSeriesRegionTool
procedure TMainForm.ShowDetectorData(Tool: TSeriesRegionTool; LeftBorder, RightBorder: double; Active: boolean);
begin
  if not Active then
  begin
    Tool.Visible:=true;
    Tool.LowerBound:=LeftBorder;
    Tool.UpperBound:=RightBorder;
  end
  else
    Tool.Visible:=false;
end;
}

procedure TMainForm.DBGridEhMeasureDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  st    : integer;
begin
  // Этот вариант раскраски строк оставляет выделение текуще строки
  // Красим нечетные строки
	//if TDBGrid(Sender).DataSource.DataSet.RecNo mod 2 = 1 then
  //  TDBGrid(Sender).Canvas.Brush.Color:=clCream;//RGB($CC,$CC,$99);

  st:=Column.Field.DataSet.FieldByName(cFieldValidity).AsInteger;

  case st of
    cDosNotMeasured:
    begin
      TDBGrid(Sender).Canvas.Brush.Color:=clSilver;
    end;
    cDosMeasAccepted:
    begin
      TDBGrid(Sender).Canvas.Brush.Color:=clBtnFace;
    end;
    else
    begin
      TDBGrid(Sender).Canvas.Brush.Color:=clYellow;
    end;
  end;

	// Восстанавливаем выделение текущей позиции курсора
	if  gdSelected   in State then
  begin
		TDBGrid(Sender).Canvas.Brush.Color:= clHighLight;
		TDBGrid(Sender).Canvas.Font.Color := clHighLightText;
	end;

	// Просим GRID перерисоваться самому
	TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;

procedure TMainForm.DBGridEhOnlyMeasCellClick(Column: TColumnEh);
begin
  GetMeasData;
end;

procedure TMainForm.DBGridEhOnlyMeasCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
begin
  GetMeasData;
end;

procedure TMainForm.DBGridEhOnlyMeasColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  SaveGridsParametersMeas;
end;

procedure TMainForm.DBGridEhOnlyMeasKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  GetMeasData;
end;

procedure TMainForm.DBGridEhOnlyMeasTitleClick(Column: TColumnEh);
var
  measID: String;
begin
  measID:=DataSourceMeasList.DataSet.FieldByName(cFieldDosMeasID).AsString;
  if measID <> '' then DBGridEhOnlyMeas.DataSource.DataSet.Locate(cFieldDosMeasID,measID,[]);
  GetMeasData;
end;

procedure TMainForm.DBGridEhProcessCellMouseClick(Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
begin
  GetMeasData;
end;

procedure TMainForm.DBGridEhProcessColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  SaveGridsParametersProcess;
end;

procedure TMainForm.DBGridMeasureDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  // Этот вариант раскраски строк оставляет выделение текуще строки
  // Красим нечетные строки
	//if TDBGrid(Sender).DataSource.DataSet.RecNo mod 2 = 1 then
  //  TDBGrid(Sender).Canvas.Brush.Color:=clCream;//RGB($CC,$CC,$99);

  TDBGrid(Sender).Canvas.Brush.Color:=clBtnFace;

	// Восстанавливаем выделение текущей позиции курсора
	if  gdSelected   in State then
  begin
		TDBGrid(Sender).Canvas.Brush.Color:= clHighLight;
		TDBGrid(Sender).Canvas.Font.Color := clHighLightText;
	end;

	// Просим GRID перерисоваться самому
///******	TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;

procedure TMainForm.DChartAutoSize(Chart: TChart);
const
  cKTVSeria = 2;
//var
//  dr: TDoubleRect;
begin
// потом поищем методы
//  dr := Chart.GetFullExtent; //, и уже из него вытаскивай значения a.Y/b.Y
//  dr := Chart.CurrentExtent; //, и уже из него вытаскивай значения a.Y/b.Y
  Chart.AxisList[0].Range.UseMin:=false;
  Chart.AxisList[1].Range.UseMin:=false;
  Chart.AxisList[2].Range.UseMin:=false;
  Chart.AxisList[0].Range.UseMax:=false;
  Chart.AxisList[1].Range.UseMax:=false;
  Chart.AxisList[2].Range.UseMax:=false;
//  Chart.AxisList[2].Range.Max := 350;
//  Chart.LeftAxis.Range.UseMax:=true;


 { Chart.LeftAxis.AutomaticMaximum:=false;
  Chart.LeftAxis.Maximum:=Chart.Series[cKTVSeria].MaxYValue; // максимум только по КТВ
  Chart.RightAxis.AutomaticMinimum:=True;
  Chart.RightAxis.AutomaticMaximum:=True;
  Chart.BottomAxis.AutomaticMaximum:=True;
  Chart.BottomAxis.AutomaticMinimum:=True;
  }

end;

procedure TMainForm.DSeriaAutoSize(Chart: TChart; Seria: TLineSeries);
var
   i: integer;
begin
  //Chart.LeftAxis.Range.Max:=500;
  //Chart.LeftAxis.Range.UseMax:=true;




//  Chart.AxisList[0].Range.Max:=250;
//  Chart.AxisList[2].Range.Max:=15;

  // масштаб присваивается все равно обоим осям

  for i:=0 to Chart.AxisList.Count-1 do
  begin
    Chart.AxisList[i].Range.UseMin:=false;
    Chart.AxisList[i].Range.UseMax:=false;
  end

  {Chart.AxisList[0].Range.UseMin:=false;
  Chart.AxisList[1].Range.UseMin:=false;
  Chart.AxisList[2].Range.UseMin:=false;
  Chart.AxisList[0].Range.UseMax:=false;
  Chart.AxisList[1].Range.UseMax:=false;
  Chart.AxisList[2].Range.UseMax:=false;}


  { потом поищем методы
  Chart.Axes.Left.AutomaticMaximum:=false;
  Chart.Axes.Left.Maximum:=Seria.MaxYValue; // максимум только по КТВ
  Chart.Axes.Right.AutomaticMinimum:=True;
  Chart.Axes.Right.AutomaticMaximum:=True;
  Chart.Axes.Bottom.AutomaticMaximum:=True;
  Chart.Axes.Bottom.AutomaticMinimum:=True;
  }
end;

procedure TMainForm.DChartOffsetHorLeft(Chart: TChart);
var
  XMin: double;
  XMax: double;
begin
  { потом поищем методы
  XMin:=Chart.Axes.Bottom.Minimum - cOffsetStep;
  XMax:=Chart.Axes.Bottom.Maximum - cOffsetStep;

  if XMax > XMin then
  begin
    if XMin >= cLeftBottomBorder then
    begin
      Chart.Axes.Bottom.Maximum:=XMax;
      Chart.Axes.Bottom.Minimum:=XMin;
    end
    else
    begin
      Chart.Axes.Bottom.Minimum:=cLeftBottomBorder;
    end;
  end;
  }
end;

procedure TMainForm.DChartOffsetHorRight(Chart: TChart);
var
  XMin: double;
  XMax: double;
begin
  { потом поищем методы
  XMin:=Chart.Axes.Bottom.Minimum + cOffsetStep;
  XMax:=Chart.Axes.Bottom.Maximum + cOffsetStep;

  if XMax > XMin then
  begin
    if XMax <= cRightBottomBorder then
    begin
      Chart.Axes.Bottom.Maximum:=XMax;
      Chart.Axes.Bottom.Minimum:=XMin;
    end
    else
    begin
      Chart.Axes.Bottom.Maximum:=cRightBottomBorder;
    end;
  end;
  }
end;

procedure TMainForm.DChartOffsetVertDown(Chart: TChart);
var
  YMin: double;
  YMax: double;
begin
  { потом поищем методы
  Chart.Axes.Left.AutomaticMaximum:=False;
  Chart.Axes.Left.AutomaticMinimum:=False;
  Chart.Axes.Bottom.AutomaticMaximum:=False;
  Chart.Axes.Bottom.AutomaticMinimum:=False;

  YMin:=Chart.Axes.Left.Minimum - (Chart.Axes.Left.Maximum/10);
  YMax:=Chart.Axes.Left.Maximum - (Chart.Axes.Left.Maximum/10);

  if YMax > YMin then
  begin
    if YMin >= 0 then
    begin
      Chart.Axes.Left.Maximum:=YMax;
      Chart.Axes.Left.Minimum:=YMin;
    end
    else
    begin
      Chart.Axes.Left.Minimum:=0;
    end;
  end;
}
end;

procedure TMainForm.DChartOffsetVertUp(Chart: TChart);
var
  YMin: double;
  YMax: double;
begin
  { потом поищем методы
  Chart.Axes.Left.AutomaticMaximum:=False;
  Chart.Axes.Left.AutomaticMinimum:=False;
  Chart.Axes.Bottom.AutomaticMaximum:=False;
  Chart.Axes.Bottom.AutomaticMinimum:=False;

  YMin:=Chart.Axes.Left.Minimum + (Chart.Axes.Left.Maximum/10);
  YMax:=Chart.Axes.Left.Maximum + (Chart.Axes.Left.Maximum/10);

  if YMax > YMin then
  begin
    Chart.Axes.Left.Minimum:=YMin;
    Chart.Axes.Left.Maximum:=YMax;
  end;

//  if YMin <= 0 then
//  begin
//    TLDChartD1.Axes.Left.Maximum:=YMax;
//    TLDChartD1.Axes.Left.Minimum:=YMin;
//  end
//  else
//  begin
//    TLDChartD1.Axes.Left.Maximum:=0;
//  end;
}
end;

procedure TMainForm.DChartZoomHorMinus(Chart: TChart);
var
  XMin: double;
  XMax: double;
begin
  { потом поищем методы
  Chart.Axes.Left.AutomaticMaximum:=False;
  Chart.Axes.Left.AutomaticMinimum:=False;
  Chart.Axes.Bottom.AutomaticMaximum:=False;
  Chart.Axes.Bottom.AutomaticMinimum:=False;

  XMin:=Chart.Axes.Bottom.Minimum - cZoomStep;
  XMax:=Chart.Axes.Bottom.Maximum + cZoomStep;

  if XMax > XMin then
  begin
    if XMin >= cLeftBottomBorder then Chart.Axes.Bottom.Minimum:=XMin else Chart.Axes.Bottom.Minimum:=cLeftBottomBorder;
    if XMax <= cRightBottomBorder then Chart.Axes.Bottom.Maximum:=XMax else Chart.Axes.Bottom.Maximum:=cRightBottomBorder;
  end;
}
end;

procedure TMainForm.DChartZoomHorPlus(Chart: TChart);
var
  XMin: double;
  XMax: double;
begin
  { потом поищем методы
  Chart.Axes.Left.AutomaticMaximum:=False;
  Chart.Axes.Left.AutomaticMinimum:=False;
  Chart.Axes.Bottom.AutomaticMaximum:=False;
  Chart.Axes.Bottom.AutomaticMinimum:=False;

  XMin:=Chart.Axes.Bottom.Minimum + cZoomStep;
  XMax:=Chart.Axes.Bottom.Maximum - cZoomStep;

  if XMax > XMin then
  begin
    Chart.Axes.Bottom.Minimum:=XMin;
    Chart.Axes.Bottom.Maximum:=XMax;
  end;
}
end;

procedure TMainForm.DChartZoomVertMinus(Chart: TChart);
var
  YMin: double;
  YMax: double;
begin
  { потом поищем методы
  Chart.Axes.Left.AutomaticMaximum:=False;
  Chart.Axes.Left.AutomaticMinimum:=False;
  Chart.Axes.Bottom.AutomaticMaximum:=False;
  Chart.Axes.Bottom.AutomaticMinimum:=False;

  YMin:=Chart.Axes.Left.Minimum;
  YMax:=Chart.Axes.Left.Maximum+(Chart.Axes.Left.Maximum/10);

  if YMax > YMin then
  begin
    Chart.Axes.Left.Minimum:=YMin;
    Chart.Axes.Left.Maximum:=YMax;
  end;
}
end;

procedure TMainForm.DChartZoomVertPlus(Chart: TChart);
var
  YMin: double;
  YMax: double;
begin
  { потом поищем методы
  Chart.Axes.Left.AutomaticMaximum:=False;
  Chart.Axes.Left.AutomaticMinimum:=False;
  Chart.Axes.Bottom.AutomaticMaximum:=False;
  Chart.Axes.Bottom.AutomaticMinimum:=False;

  YMin:=Chart.Axes.Left.Minimum;
  YMax:=Chart.Axes.Left.Maximum-(Chart.Axes.Left.Maximum/10);

  if YMax > YMin then
  begin
    Chart.Axes.Left.Minimum:=YMin;
    Chart.Axes.Left.Maximum:=YMax;
  end;
}
end;

function TMainForm.EmulatorLoadResults(FileName: String): boolean;
var
  f       : TextFile;
  s, s2   : String;
  ch      : integer;
  tmp     : integer;
  k_tv     : integer;
begin

  if FileExists(FileName) then
  begin
    AssignFile(f, FileName);
    Reset(f);

    FillChar(TLDCommand.TempResult, SizeOf(TLDCommand.TempResult), #0);
    FillChar(TLDCommand.ImpulseResult, SizeOf(TLDCommand.ImpulseResult), #0);

    while not eof(f) do
    begin
      readln(f,s);
      // канал
      s2:=copy(s,1,pos(' ', s)-1);
      ch:=StrToInt(s2);
      delete(s, 1, pos(' ', s));
      // ктв
      s2:=copy(s,1,pos(' ', s)-1);
      //k_tv:=StrToInt(s2);
      k_tv:=Round(StrToFloatRegion(s2));
      delete(s, 1, pos(' ', s));
      // температура
      tmp:=Round(StrToFloatRegion(s)*10);

      //SetLength(TLDCommand.TempResult,ch);
      SetLength(TLDCommand.ImpulseResult,ch);

      TLDCommand.TempResult[ch-1]:=tmp;
      TLDCommand.ImpulseResult[ch-1]:=k_tv;
    end;

    CloseFile(f);
    Result:=true;
  end
  else
  begin
    FillChar(TLDCommand.TempResult,sizeof(TLDCommand.TempResult),0);
    FillChar(TLDCommand.ImpulseResult,sizeof(TLDCommand.ImpulseResult),0);
    Result:=false;
  end;

end;

procedure TMainForm.EmulatorResults;
var
  i         : integer;
  s_BigDose : integer;
begin
  case Dosimeter.DetectorsCnt of
    0:
    //    if not SeriesMeasD1KTV.Visible then SeriesMeasD1KTV.Visible:=true;
      if not SeriesMeasD1KTV.active then SeriesMeasD1KTV.active:=true;
    1:
      if not SeriesMeasD2KTV.active then SeriesMeasD2KTV.active:=true;
    2:
      if not SeriesMeasD3KTV.active then SeriesMeasD3KTV.active:=true;
    3:
      if not SeriesMeasD4KTV.active then SeriesMeasD4KTV.active:=true;
  end;

  if Length(TLDCommand.TempResult)>0 then
  begin
    for i := 0 to Length(TLDCommand.TempResult)-1 do
    begin
      if Assigned(Dosimeter) and (Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]<>nil) then
      begin
        case Dosimeter.DetectorsCnt of
          0:
          begin
            SeriesMeasD1Temp.AddXY(i,TLDCommand.TempResult[i]/10);
            Dosimeter.CntDetector.Temp_Buff[i]:=TLDCommand.TempResult[i];
            //TLDChartMeasDataD1.Series[1].AddXY(i,TLDCommand.TempResult[i]/10);
          end;
          1:
          begin
            SeriesMeasD2Temp.AddXY(i,TLDCommand.TempResult[i]/10);
            Dosimeter.CntDetector.Temp_Buff[i]:=TLDCommand.TempResult[i];
            //TLDChartMeasDataD2.Series[1].AddXY(i,TLDCommand.TempResult[i]/10);
          end;
          2:
          begin
            SeriesMeasD3Temp.AddXY(i,TLDCommand.TempResult[i]/10);
            Dosimeter.CntDetector.Temp_Buff[i]:=TLDCommand.TempResult[i];
            //TLDChartMeasDataD3.Series[1].AddXY(i,TLDCommand.TempResult[i]/10);
          end;
          3:
          begin
            SeriesMeasD4Temp.AddXY(i,TLDCommand.TempResult[i]/10);
            Dosimeter.CntDetector.Temp_Buff[i]:=TLDCommand.TempResult[i];
            //TLDChartMeasDataD4.Series[1].AddXY(i,TLDCommand.TempResult[i]/10);
          end;
        end;

      end;
    end;
  end;

  if Length(TLDCommand.ImpulseResult)>0 then
  begin
    s_BigDose:=0;
    for i := 0 to Length(TLDCommand.ImpulseResult)-1 do
    begin
      if Assigned(Dosimeter) and (Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]<>nil) then
      begin
        case Dosimeter.DetectorsCnt of
          0:
            begin
              SeriesMeasD1KTV.AddXY(i,TLDCommand.ImpulseResult[i]);
              Dosimeter.CntDetector.KTV_Buff[i]:=TLDCommand.ImpulseResult[i];
              //TLDChartMeasDataD1.Series[0].AddXY(i,TLDCommand.ImpulseResult[i]);

// тест работы по отслеживанию больших доз
//              if i<=Dosimeter.CntDetector.N1 then s_BigDose:=s_BigDose+TLDCommand.ImpulseResult[i];
//
//              if s_BigDose > 200 then
//              begin
//                OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s',['Обнаружен признак большой дозы']),Format('%s',['Измерение остановлено.'+#13#10+'Установите фильтр и повторите измерение.']),cMsgBigDose,cMsgPriorityError);
//                exit;
//              end;

              GaugeMeasDataD1.Progress:=Length(TLDCommand.ImpulseResult);
              if StartMeasureW.Showing then
                StartMeasureW.GaugePageMeasStatusD1.Progress:=Length(TLDCommand.ImpulseResult);
              
            end;
          1:
            begin
              SeriesMeasD2KTV.AddXY(i,TLDCommand.ImpulseResult[i]);
              Dosimeter.CntDetector.KTV_Buff[i]:=TLDCommand.ImpulseResult[i];
              //TLDChartMeasDataD2.Series[0].AddXY(i,TLDCommand.ImpulseResult[i]);
              GaugeMeasDataD2.Progress:=Length(TLDCommand.ImpulseResult);
              if StartMeasureW.Showing then
                StartMeasureW.GaugePageMeasStatusD2.Progress:=Length(TLDCommand.ImpulseResult);
            end;
          2:
            begin
              SeriesMeasD3KTV.AddXY(i,TLDCommand.ImpulseResult[i]);
              Dosimeter.CntDetector.KTV_Buff[i]:=TLDCommand.ImpulseResult[i];
              //TLDChartMeasDataD3.Series[0].AddXY(i,TLDCommand.ImpulseResult[i]);
              GaugeMeasDataD3.Progress:=Length(TLDCommand.ImpulseResult);
              if StartMeasureW.Showing then
                StartMeasureW.GaugePageMeasStatusD3.Progress:=Length(TLDCommand.ImpulseResult);
            end;
          3:
            begin
              SeriesMeasD4KTV.AddXY(i,TLDCommand.ImpulseResult[i]);
              Dosimeter.CntDetector.KTV_Buff[i]:=TLDCommand.ImpulseResult[i];
              //TLDChartMeasDataD4.Series[0].AddXY(i,TLDCommand.ImpulseResult[i]);
              GaugeMeasDataD4.Progress:=Length(TLDCommand.ImpulseResult);
              if StartMeasureW.Showing then
                StartMeasureW.GaugePageMeasStatusD3.Progress:=Length(TLDCommand.ImpulseResult);
            end;
        end;

      end;
    end;
  end;
end;

procedure TMainForm.EditEnable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=true;
end;

procedure TMainForm.EditK_1_CalibrChange(Sender: TObject);
begin
  EditCalibrK(SeriesK1Avg,SeriesK1,EditK_1_Calibr);
//  ChartToolBannerK1.Text:=EditK_1_Calibr.Text;
end;

procedure TMainForm.EditK_2_CalibrChange(Sender: TObject);
begin
  EditCalibrK(SeriesK2Avg,SeriesK2,EditK_2_Calibr);
//  ChartToolBannerK2.Text:=EditK_2_Calibr.Text;
end;

procedure TMainForm.EditK_gn_CalibrChange(Sender: TObject);
begin
  EditCalibrK(SeriesKgnAvg,SeriesKgn,EditK_gn_Calibr);
//  ChartToolBannerKgn.Text:=EditK_gn_Calibr.Text;
end;

procedure TMainForm.EditReserveDBCommentChange(Sender: TObject);
begin
  SpeedBtnSaveReserveComment.Enabled:=IsEditReserveDBCommentChanged(EditReserveDBComment);
end;

procedure TMainForm.EditReserveDBCommentKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscBDCommentEdit(Key);
end;

procedure TMainForm.EditCalibrK(SeriaAvg: TLineSeries; SeriaValue: TLineSeries; Edit: TEdit);
var
  i: integer;
begin
  if IsCalibrKValid(Edit) then
  begin
    SeriaAvg.Clear;
//    if SeriaValue.XValues.Count>0 then
    if SeriaValue.Count>0 then
//      for i := 0 to SeriaValue.XValues.Count do SeriaAvg.AddXY(SeriaValue.XValues[i],StrToFloatRegion(Edit.Text));
      for i := 0 to SeriaValue.Count-1 do SeriaAvg.AddXY(SeriaValue.XValues[i,0],StrToFloatRegion(Edit.Text));
  end;

  CalibrationPressed:=IsCalibrKEditsValid;
  LabelCalibrKErr.Visible:=not CalibrationPressed;
end;

procedure TMainForm.EditCurrentDBCommentChange(Sender: TObject);
begin
  SpeedBtnSaveCurrentComment.Enabled:=IsEditCurrentDBCommentChanged(EditCurrentDBComment);
end;

procedure TMainForm.EditDisable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=false;
end;

procedure TMainForm.EditDosDataDosDepValGroupKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscDosPageEdit(Key);
end;

procedure TMainForm.EditDosDataDosDepValKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscDosPageEdit(Key);
end;

procedure TMainForm.EditDosDataDosOrgValGroupKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscDosPageEdit(Key);
end;

procedure TMainForm.EditDosDataDosOrgValKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscDosPageEdit(Key);
end;

procedure TMainForm.EditDosDosNumberChange(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDosNumber,EditDosDosNumber.Text);

  if EditDosDosNumber.Text <> '' then
    ChangeEdit(TEdit(Sender),SpBtnDosDropDosNumber,True)
  else
    ChangeEdit(TEdit(Sender),SpBtnDosDropDosNumber,False);
end;

procedure TMainForm.EditMeasDataCommentChange(Sender: TObject);
begin
  SpeedBtnMeasSaveParam.Enabled:=IsEditCommentChanged(EditMeasDataComment);
end;

procedure TMainForm.EditMeasDataCommentKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscMeasPageEdit(Key);
end;

procedure TMainForm.EditMeasDataDosDepKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscMeasPageEdit(Key);
end;

procedure TMainForm.EditMeasDataDosFioKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscMeasPageEdit(Key);
end;

procedure TMainForm.EditMeasDataDosOrgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscMeasPageEdit(Key);
end;

procedure TMainForm.EditMeasDataDosPersNumberKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EscMeasPageEdit(Key);
end;

procedure TMainForm.EditMeasDosNumberChange(Sender: TObject);
begin
//  SaveFilterTextIni(cFilterMeasNumber,EditMeasDosNumber.Text);
//
//  if EditMeasDosNumber.Text <> '' then
//    ChangeEdit(TEdit(Sender),SpBtnMeasDropDosNumber,True)
//  else
//    ChangeEdit(TEdit(Sender),SpBtnMeasDropDosNumber,False);
end;

procedure TMainForm.EditMeasDosNumberKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
   cVK_Enter = $0D;          //  кнопка Enter
begin
//
//  if (Key = сVK_Enter) then
//  begin
//    //**UpdateData;
//    UpdateDataMeasFilter(FilterDosNumber);
//    EditCurrentDosNumber.Text:=EditMeasDosNumber.Text;
//
//    //EditCurrentDosNumber.Text:=EditMeasDosNumber.Text;
//
//    SpeedBtnStartClick(Self);
//
//  end;
end;

procedure TMainForm.EnabledSpeedBtns(aBtnStart, aBtnStop, aBtnPause: boolean);
var
  BRight: boolean;
begin
//  exit; // какая-то хирабора если оставить выполнение

  if IsBitOn(TLDState,0) then
  begin
    SpeedBtnStart.Enabled:=false;
    JvSpeedBtnStart.Enabled:=false;;
    //SpeedBtnPause.Enabled:=false;
    SpeedBtnMeasUserWarning.Enabled:=false;
    JvSpeedBtnMeasDosStatus.Enabled:=false;
    SpeedBtnProcessUserWarning.Enabled:=false;
    JvSpeedBtnProcessDosStatus.Enabled:=false;
  end
  else
  begin
    SpeedBtnStart.Enabled:=aBtnStart;
    JvSpeedBtnStart.Enabled:=aBtnStart;
    SpeedBtnStop.Enabled:=aBtnStop;
    //SpeedBtnPause.Enabled:=aBtnPause;
    SpeedBtnMeasUserWarning.Enabled:=aBtnStart;
    JvSpeedBtnMeasDosStatus.Enabled:=aBtnStart;
    SpeedBtnProcessUserWarning.Enabled:=aBtnStart;
    JvSpeedBtnProcessDosStatus.Enabled:=aBtnStart;

    BRight := AW.IsHaveIRight(crMain_OpenCalcWindow);
    BRight := BRight and aBtnStart;

    SpeedBtnMeasDataWarningD1.Enabled:=BRight;
    SpeedBtnMeasDataWarningD2.Enabled:=BRight;
    SpeedBtnMeasDataWarningD3.Enabled:=BRight;
    SpeedBtnMeasDataWarningD4.Enabled:=BRight;
    SpeedBtnProcessDataWarningD1.Enabled:=BRight;
    SpeedBtnProcessDataWarningD2.Enabled:=BRight;
    SpeedBtnProcessDataWarningD3.Enabled:=BRight;
    SpeedBtnProcessDataWarningD4.Enabled:=BRight;
  end;
end;

procedure TMainForm.EscBDCommentEdit(Key: Word);
begin
  if (Key = VK_ESCAPE) then CheckDBCommentEdit;
end;

procedure TMainForm.EscDosPageEdit(Key: Word);
begin
  if (Key = VK_ESCAPE) then LoadDosData(TLDDataModule.ADOQuery,Dosimeter);
end;

procedure TMainForm.EscMeasPageEdit(Key: Word);
begin
  if (Key = VK_ESCAPE) then LoadDosWithMeasData(TLDDataModule.ADOQuery,Dosimeter,IntToStr(Dosimeter.MeasurementID));
end;

procedure TMainForm.ExcludeDosimeterFromPart;
var
  i           : integer;
  dosName     : String;
  dosPart     : String;
  dosPartID   : integer;
  temp        : word;
  msg         : String;
  fullNumber  : String;
begin
  dosPartID:=0;
  dosName:='';
  dosPart:='';

  fullNumber:=MainForm.Dosimeter.FullNumber;

  if DBGridEhDos.SelectedRows.Count > 0 then
  begin
    if (DBGridEhDos.SelectedRows.Count > 1) AND (DBGridEhDos.SelectedRows.Count < 10)then
    begin
      for i := 0 to DBGridEhDos.SelectedRows.Count-1 do
      begin
        DBGridEhDos.DataSource.DataSet.GotoBookmark(DBGridEhDos.SelectedRows.Items[i]);
        if dosName<>'' then
          dosName:=dosName+', "'+DBGridEhDos.DataSource.DataSet.FieldByName(cFullDosID).AsString+'"'
        else
          dosName:='"'+DBGridEhDos.DataSource.DataSet.FieldByName(cFullDosID).AsString+'"';

        if (dosPartID<>DBGridEhDos.DataSource.DataSet.FieldByName(cFieldPartID).AsInteger) then
        begin
          dosPartID:=DBGridEhDos.DataSource.DataSet.FieldByName(cFieldPartID).AsInteger;
          if dosPart<>'' then
          begin
            if AnsiPos('"'+TLDDataModule.GetPartName(dosPartID)+'"',dosPart) = 0 then
              dosPart:=dosPart+',"'+TLDDataModule.GetPartName(dosPartID)+'"'
          end
          else
            dosPart:='"'+TLDDataModule.GetPartName(dosPartID)+'"';
        end;
      end;
      msg:=Format(rsPartyExclude,[dosName,dosPart]);
    end
    else if DBGridEhDos.SelectedRows.Count = 1 then
    begin
      DBGridEhDos.DataSource.DataSet.GotoBookmark(DBGridEhDos.SelectedRows.Items[0]);
      dosName:='"'+DBGridEhDos.DataSource.DataSet.FieldByName(cFullDosID).AsString+'"';
      msg:=Format(rsPartyExcludeOne,[dosName,'"'+EditDosPart.Text+'"']);
    end
    else
    begin
      msg:=Format(rsPartyExclude,['('+IntToStr(DBGridEhDos.SelectedRows.Count)+')'+rsNums,dosPart]);
    end;

    temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s',[msg]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

    case temp of
      mrYes:
      begin
        for i := 0 to DBGridEhDos.SelectedRows.Count-1 do
        begin
          DBGridEhDos.DataSource.DataSet.GotoBookmark(DBGridEhDos.SelectedRows.Items[i]);
          dosName:=DBGridEhDos.DataSource.DataSet.FieldByName(cFullDosID).AsString;

          TLDDataModule.ExcludeDosimeterFromPart(dosName);
        end;

        UpdateAllGridPages;

        DBGridEhDos.SelectedRows.Clear;
        DBGridEhDos.DataSource.DataSet.Locate(cFullDosID,fullNumber,[]);
        DBGridEhDos.SelectedRows.CurrentRowSelected:=true;
        GetDosData;
      end;
    end;
  end;
end;

procedure TMainForm.ExportToCSV(DBGrid: TDBGridEh; UseDetDose: boolean);
var
  i,j             : integer;
  list            : TStringList;
  delimiterString : String;
  fullPath        : String;
  measId          : String;
begin
  SaveDialogMainForm.DefaultExt:='csv';
  SaveDialogMainForm.Filter:='|'+'*'+cExtCSV;
  SaveDialogMainForm.InitialDir:=extractfilepath(Application.ExeName)+cReport+PathDelim;
  SaveDialogMainForm.FileName:=Format('%s_%s_№%s_%s',[cReport,cDozaTLD,IntToStr(DeviceID),DeleteDividers(DateTimeToStr(Now))]);

  if SaveDialogMainForm.Execute then
  begin
    fullPath:=SaveDialogMainForm.FileName;

    list:=TStringList.Create;
    delimiterString:='';

    for i := 0 to DBGrid.Columns.Count-1 do
    begin
      if DBGrid.Columns[i].Visible then
        delimiterString:=delimiterString+DBGrid.Columns[i].Title.caption+';';
    end;

    if UseDetDose then
    begin
      delimiterString:=delimiterString+rsDetector1+';';
      delimiterString:=delimiterString+rsDetector2+';';
      delimiterString:=delimiterString+rsDetector3+';';
      delimiterString:=delimiterString+rsDetector4+';';
    end;

    list.Add(delimiterString);

    for i := 0 to DBGrid.SelectedRows.Count-1 do
    begin
      delimiterString:='';
      DBGrid.DataSource.DataSet.GotoBookmark(DBGrid.SelectedRows.Items[i]);

      for j := 0 to DBGrid.Columns.Count-1 do
      begin
        if DBGrid.Columns[j].Visible then
          if Pos(';',DBGrid.Fields[j].AsString)>0 then
            delimiterString:=delimiterString+'"'+DBGrid.Fields[j].AsString+'"'+';'
          else
            delimiterString:=delimiterString+DBGrid.Fields[j].AsString+';';
      end;

      if UseDetDose then
      begin
        measId:=DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;
        delimiterString:=delimiterString+TLDDataModule.GetDetDose(measId,cDetPos1)+';';
        delimiterString:=delimiterString+TLDDataModule.GetDetDose(measId,cDetPos2)+';';
        delimiterString:=delimiterString+TLDDataModule.GetDetDose(measId,cDetPos3)+';';
        delimiterString:=delimiterString+TLDDataModule.GetDetDose(measId,cDetPos4)+';';
      end;


      list.Add(delimiterString);
    end;

    list.SaveToFile(fullPath);
    list.Free;
  end;
end;

procedure TMainForm.MenuFileDBClick(Sender: TObject);
begin
  OpenDB.Show;
end;

procedure TMainForm.MenuFileExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.MenuFileImportDataBaseClick(Sender: TObject);
begin
  ImportInCurrentDBForm.Show;
end;

procedure TMainForm.MenuMeasDosImportClick(Sender: TObject);
begin
  ImportDosimetersW.ShowModal;
end;

procedure TMainForm.MenuFileImportMeasClick(Sender: TObject);
begin
  ImportMeasForm.Show;
end;

procedure TMainForm.RefreshDBList;
const
  cAddFieldSize = 35;
  procedure DBGridSetFocus(aLine: integer);
  begin
    if aLine>0 then
      DBGridEhDB.DataSource.DataSet.RecNo:=aLine;
  end;
begin
  if not TLDDataModule.IsConnected then
  begin
    TLDDataModule.ConnectToDB(cPostgreDefaultDB);
  end;

  // получаем список доступных баз данных, с нумерацией по порядку, за исключением предустановленных баз (postgres, template1, template0)
  ADOQueryDBList.SQL.Clear;
  ADOQueryDBList.SQL.Add('SELECT '+cDBName+' '
                        +'FROM pg_database WHERE '
                        +'('+cDBName+' <> '+#39+'User'+#39+') AND '
                        +'('+cDBName+' <> '+#39+'postgres'+#39+') AND '
                        +'('+cDBName+' <> '+#39+cDefaultDB+#39+') AND '
                        +'('+cDBName+' <> '+#39+'template1'+#39+') AND '
                        +'('+cDBName+' <> '+#39+'template0'+#39+') ORDER BY '+cDBName);
  ADOQueryDBList.Open;

  if MemTableEhDBList.Active then MemTableEhDBList.Active:=false;
  MemTableEhDBList.Active:=true;

//  DBGridEhDB.Columns[DBGridEhDB.DataSource.DataSet.FieldByName(cDBName).Index].Width:=220;
  DBGridEhDB.Columns[DBGridEhDB.DataSource.DataSet.FieldByName(cDBName).Index].Title.caption:=' '+rsReservedCopyName;
  DBGridEhDB.Columns[DBGridEhDB.DataSource.DataSet.FieldByName(cDBName).Index].Title.Font.Size:=cGridDBFontSize;
  DBGridEhDB.Columns[DBGridEhDB.DataSource.DataSet.FieldByName(cDBName).Index].Alignment:=taLeftJustify;

//  indicatorColWidth:=DBGridEhDB.CalcIndicatorColWidth+cAddFieldSize+DBGridEhDB.VertScrollBar.Width;

  DBGridEhDB.Columns[DBGridEhDB.DataSource.DataSet.FieldByName(cDBName).Index].Width:=DBGridEhDB.Width-DBGridEhDB.DefaultCalcIndicatorRowNumAreaWidth-cAddFieldSize;//cAddFieldSize{-indicatorColWidth};

  if (PageControlSettings.ActivePage=TabSheetDataBase) AND (PageControlMain.ActivePage=TabSheetSettings) then
  begin
    DBGridEhDB.SetFocus;
    DBGridSetFocus(TLDDataModule.GetDBGridStringNumber(DBGridEhDB, TLDDataModule.DBName));
    DBGridEhDB.SelectedRows.CurrentRowSelected:=true;
  end;
end;

procedure TMainForm.RefreshDetKtvTmp;
var
  i: integer;
  St : String;
begin
  if Assigned(Dosimeter) then
  begin
    if Assigned(Dosimeter.CntDetector) then
    begin

      // переводим массив ктв в строку
      if Length(Dosimeter.CntDetector.KTV_Buff)>0 then
      begin
        St:=IntToStr(Dosimeter.CntDetector.KTV_Buff[0]);
        for i := 1 to Length(Dosimeter.CntDetector.KTV_Buff)-1 do
          St := St + ',' + IntToStr(Dosimeter.CntDetector.KTV_Buff[i]);
        Dosimeter.CntDetector.Ktv:=St;
      end;

      // переводим массив температурного профиля в строку
      if Length(Dosimeter.CntDetector.Temp_Buff)>0 then
      begin
        St := FloatToStrRegion(Dosimeter.CntDetector.Temp_Buff[0]/10);
        for i := 1 to Length(Dosimeter.CntDetector.Temp_Buff)-1 do
          St := St + ',' + FloatToStrRegion(Dosimeter.CntDetector.Temp_Buff[i]/10);
        Dosimeter.CntDetector.Tmp:=St;
      end;
    end;
  end;
//  if Assigned(Dosimeter) then
//  begin
//    // переводим массив ктв в строку
//    if Length(TLDCommand.ImpulseResult)>0 then
//    begin
//      St:=IntToStr(TLDCommand.ImpulseResult[0]);
//      for i := 1 to Length(TLDCommand.ImpulseResult)-1 do
//        St := St + ',' + IntToStr(TLDCommand.ImpulseResult[i]);
//      Dosimeter.CntDetector.Ktv:=St;
//    end;
//
//    // переводим массив температурного профиля в строку
//    if Length(TLDCommand.TempResult)>0 then
//    begin
//      St := FloatToStrRegion(TLDCommand.TempResult[0]/10);
//      for i := 1 to Length(TLDCommand.TempResult)-1 do
//        St := St + ',' + FloatToStrRegion(TLDCommand.TempResult[i]/10);
//      Dosimeter.CntDetector.Tmp:=St;
//    end;
//  end;
end;

procedure TMainForm.CalcDetectorDose;
var
  i       : integer;
  k_tv     : String;
  tmp     : String;
  fon     : String;
  gaus    : String;
begin
  k_tv:='';
  tmp:='';
  fon:='';
  gaus:='';

  if (StartMeasureW.StartView <> cTesting) OR ((StartMeasureW.StartView = cTesting) AND FTestSourceUse) then
  begin
    if Length(TLDCommand.ImpulseResult)>0 then
    begin
      for i := 0 to Length(TLDCommand.ImpulseResult)-1 do
      begin
        // для расчетного модуля
        Dosimeter.CntDetector.BuffPulses[i] := TLDCommand.ImpulseResult[i];
      end;
      CalcForm.CalcDetector(Dosimeter.CntDetector);
    end;

    Dosimeter.CntDetector.State:=GetDetStateAfterCalc(CalcForm.OutEnum);

    Dosimeter.CalcDetectorDose(Dosimeter.CntDetector.Position);

//**    if Dosimeter.CntDetector.FonFound then
    begin
      for i := 0 to Length(CalcForm.BuffBackground)-1 do
      begin
        if Dosimeter.CntDetector.Fon='' then
          Dosimeter.CntDetector.Fon:=SingleToStrRegion(CalcForm.BuffBackground[i])
        else
          Dosimeter.CntDetector.Fon:=Dosimeter.CntDetector.Fon+','+SingleToStrRegion(CalcForm.BuffBackground[i]);
      end;
    end;

//**    if Dosimeter.CntDetector.PeakFound then
    begin
      for i := 0 to Length(CalcForm.Peak_R1)-1 do
      begin
        if Dosimeter.CntDetector.Gaus='' then
          Dosimeter.CntDetector.Gaus:=SingleToStrRegion(CalcForm.Peak_R1[i]+CalcForm.BuffBackground[i])
        else
          Dosimeter.CntDetector.Gaus:=Dosimeter.CntDetector.Gaus+','+SingleToStrRegion(CalcForm.Peak_R1[i]+CalcForm.BuffBackground[i]);
      end;
    end;
  end
  else
  begin
    if Length(TLDCommand.ImpulseResult)>0 then
    begin
      for i := 0 to Length(TLDCommand.ImpulseResult)-1 do
      begin
        Dosimeter.CntDetector.BuffPulses[i]:=TLDCommand.ImpulseResult[i];
        Dosimeter.CntDetector.Dose:=Dosimeter.CntDetector.Dose+TLDCommand.ImpulseResult[i]
      end;
      Dosimeter.CntDetector.State:=stDetProcessed;
    end;
  end;

end;

procedure TMainForm.InsertDetectorStateAndComment(MeasurmentID    : integer;
                                                  DetectorType    : String;
                                                  DetectorTypeID  : integer;
                                                  DetPos          : integer;
                                                  MeasurmentTime  : String;
                                                  DetState        : TDetectorState;
                                                  DetComment      : String);
begin
  TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
  TLDDataModule.ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetRes+'('+cFieldDosMeasID+','
                                                                +cFieldDetType+','
                                                                +cFieldDetTypeID+','
                                                                +cFieldDetPosition+','
                                                                +cFieldMeasureTime+','
                                                                +cFieldDetStatus+','
                                                                +cFieldMethod+','
                                                                +cFieldDetTypeComment+','
                                                                +cFieldDetMeasVal+','
                                                                +cFieldDetKName+','
                                                                +cFieldTempProfile+','
                                                                +cFieldTempProfileWrite+','
                                                                +cFieldKTV+','
                                                                +cFieldCalcFon+','
                                                                +cFieldCalcGaus+','
                                                                +cFieldAutoProc+','
                                                                +cFieldK1Profile+','
                                                                +cFieldK2Profile+','
                                                                +cFieldDetComment+
                                                                ') '+
                                                         'VALUES('+IntToStr(MeasurmentID)+','
                                                              +#39+DetectorType+#39+','
                                                                  +IntToStr(DetectorTypeID)+','
                                                                  +IntToStr(DetPos)+','
                                                              +#39+MeasurmentTime+#39+','
                                                                  +IntToStr(GetDetState(DetState))+','
                                                              +#39+TDetector(Dosimeter.DetectorsList[DetPos-1]).Method+#39+','
                                                              +#39+TDetector(Dosimeter.DetectorsList[DetPos-1]).DetTypeComment+#39+','
                                                              +#39+TDetector(Dosimeter.DetectorsList[DetPos-1]).MeasValue+#39+','
                                                              +#39+TDetector(Dosimeter.DetectorsList[DetPos-1]).KName+#39+','
                                                              +#39+'{'+cProfile_none+'}'+#39+','
                                                              +#39+'{'+cProfile_Res_none+'}'+#39+','
                                                              +#39+'{'+cProfile_none+'}'+#39+','
                                                              +#39+'{'+cProfile_Res_none+'}'+#39+','
                                                              +#39+'{'+cProfile_Res_none+'}'+#39+','
                                                              +#39+BoolToStrRegion(False)+#39+','
                                                              +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).K1Profile)+#39+','
                                                              +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).K2Profile)+#39+','
                                                              +#39+DetComment+#39+
                                                                ')');
  TLDDataModule.ADOQuery.ExecSQL;
end;

procedure TMainForm.ImageMeasPageLogoClick(Sender: TObject);
begin
  VW.ShowModal;
end;

procedure TMainForm.InsertDetectorKtvTmp(DetPos: integer);
begin
  RefreshDetKtvTmp;

  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
  TLDDataModule.ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetRes+'('+cFieldDosMeasID+','
                                                                  +cFieldDetType+','
                                                                  +cFieldDetTypeID+','
                                                                  +cFieldDetPosition+','
                                                                  +cFieldKTV+','
                                                                  +cFieldTempProfile+','
                                                                  +cFieldTempProfileWrite+','
                                                                  +cFieldMeasureTime+','
                                                                  +cFieldDetComment+','
                                                                  +cFieldMethod+','
                                                                  +cFieldDetTypeComment+','
                                                                  +cFieldDetMeasVal+','
                                                                  +cFieldDetKName+','
                                                                  +cFieldK1Profile+','
                                                                  +cFieldK2Profile+','
                                                                  +cFieldDetStatus+
                                                                ') '+
                                                         'VALUES('+IntToStr(Dosimeter.MeasurementID)+','
                                                              +#39+Dosimeter.CntDetector.DetType+#39+','
                                                                  +IntToStr(TDetector(Dosimeter.DetectorsList[DetPos-1]).DetTypeID)+','
                                                                  +IntToStr(Dosimeter.DetectorsCnt+1)+','
                                                         +#39+#123+Dosimeter.CntDetector.Ktv+#125+#39+','
                                                         +#39+#123+Dosimeter.CntDetector.Tmp+#125+#39+','
                                                         +#39+#123+Dosimeter.CntDetector.TmpWrite+#125+#39+','
                                                              +#39+DateTimeToStr(Now)+#39+','
                                                              +#39+Dosimeter.CntDetector.Comment+#39+','
                                                              +#39+TDetector(Dosimeter.DetectorsList[DetPos-1]).Method+#39+','
                                                              +#39+TDetector(Dosimeter.DetectorsList[DetPos-1]).DetTypeComment+#39+','
                                                              +#39+TDetector(Dosimeter.DetectorsList[DetPos-1]).MeasValue+#39+','
                                                              +#39+TDetector(Dosimeter.DetectorsList[DetPos-1]).KName+#39+','
                                                              +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).K1Profile)+#39+','
                                                              +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).K2Profile)+#39+','
                                                                  +IntToStr(GetDetState(Dosimeter.CntDetector.State))+
                                                                ')');
  TLDDataModule.ADOQuery.ExecSQL;
end;

procedure TMainForm.UpdateDetectorMeasData(DetPos: integer);
begin
  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
  TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDetRes+' SET ('+cFieldDose+','
                                                                  +cFieldDetErr+','
                                                                  +cFieldCalcFon+','
                                                                  +cFieldCalcGaus+','
                                                                  +cFieldMeasureTime+','
                                                                  +cFieldAutoProc+','
                                                                  +cFieldDetStatus+','
                                                                  +cFieldBt+','
                                                                  +cFieldBx0+','
                                                                  +cFieldBy0+','
                                                                  +cFieldBxy0+','
                                                                  +cFieldBdy+','
                                                                  +cFieldGm1+','
                                                                  +cFieldGa1+','
                                                                  +cFieldGsl+','
                                                                  +cFieldDgm2+','
                                                                  +cFieldDga2+','
                                                                  +cFieldGsr+','
                                                                  +cFieldN1+','
                                                                  +cFieldN2+','
                                                                  +cFieldS+','
                                                                  +cFieldBn1+','
                                                                  +cFieldBn1Width+','
                                                                  +cFieldBn2+','
                                                                  +cFieldBn2Width+','
                                                                  +cFieldPeakFound+','
                                                                  +cFieldFonFound+','
                                                                  +cFieldK1Profile+','
                                                                  +cFieldK2Profile+','
                                                                  +cFieldDetComment+' '
                                                               +')'
                                                          +' = ('
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Dose)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Err)+#39+','
                                                          +#39+#123+TDetector(Dosimeter.DetectorsList[DetPos-1]).Fon+#125+#39+','
                                                          +#39+#123+TDetector(Dosimeter.DetectorsList[DetPos-1]).Gaus+#125+#39+','
                                                          +#39+DateTimeToStr(Now)+#39+','
                                                          +#39+BoolToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).AutoProcessing)+#39+','
                                                          +IntToStr(GetDetState(TDetector(Dosimeter.DetectorsList[DetPos-1]).State))+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Bt)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Bx0)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).By0)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Bxy0)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Bdy)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Gm1)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Ga1)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Gsl)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Dgm2)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Dga2)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).Gsr)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).N1)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).N2)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).S)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).BN1)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).BN1_width)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).BN2)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).BN2_width)+#39+','
                                                          +#39+BoolToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).PeakFound)+#39+','
                                                          +#39+BoolToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).FonFound)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).K1Profile)+#39+','
                                                          +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[DetPos-1]).K2Profile)+#39+','
                                                          +#39+TDetector(Dosimeter.DetectorsList[DetPos-1]).Comment+#39+' '
                                                            +')'
                                                            +'WHERE ('+cFieldDosMeasID+' = '+IntToStr(Dosimeter.MeasurementID)+') AND ('+cFieldDetPosition+' = '+IntToStr(DetPos)+');'
                                                          +'COMMIT;');
  TLDDataModule.ADOQuery.ExecSQL;
end;

procedure TMainForm.UpdateDetectorState(MeasurmentID    : integer;
                                        DetPos          : integer;
                                        DetState        : TDetectorState);
begin
  if TLDDataModule.ADOQuery.Active then TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
  TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDetRes+' SET '+cFieldDetStatus+
                                                          ' = '+IntToStr(GetDetState(DetState))+
                                                          ' WHERE ('+cFieldDosMeasID+' = '+IntToStr(MeasurmentID)+' AND '+cFieldDetPosition+' = '+IntToStr(DetPos)+')');
  TLDDataModule.ADOQuery.ExecSQL;
end;

procedure TMainForm.SaveAdditionalParameters;
var
  fullNumber: String;
begin
  fullNumber:=MainForm.Dosimeter.FullNumber;
  UpdateDosimeterAdditionalParameters;
  UpdateAllGridPages;

  DBGridEhDos.SelectedRows.Clear;
  DBGridEhDos.DataSource.DataSet.Locate(cFullDosID,fullNumber,[]);
  DBGridEhDos.SelectedRows.CurrentRowSelected:=true;
  GetDosData;
end;

procedure TMainForm.SaveBoolToIni(SectionName,ParameterName: String; Value: boolean);
var
  ConfigIni: TInifile;
begin
  ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    ConfigIni.WriteBool(SectionName, ParameterName, Value);
  finally
    ConfigIni.Free;
  end;
end;

procedure TMainForm.SaveCurrentDetectorsData;
var
  i,j: integer;
  St: String;
begin
  if Dosimeter.MeasurementID>0 then
  begin
    for i := Dosimeter.DetectorsCnt to Dosimeter.DetectorsList.Count-1 do
    begin
      if TDetector(Dosimeter.DetectorsList[i]) <> nil then
      begin
        if Length(TLDCommand.ImpulseResult)>0 then
        begin
          St := IntToStr(TLDCommand.ImpulseResult[0]);
          for j := 1 to Length(TLDCommand.ImpulseResult)-1 do
            St := St + ',' + IntToStr(TLDCommand.ImpulseResult[j]);
          TDetector(Dosimeter.DetectorsList[i]).Ktv := St;
        end;

        // переводим массив температурного профиля в строку для даписи в БД
        if Length(TLDCommand.TempResult)>0 then
        begin
          St:=FloatToStrRegion(TLDCommand.TempResult[0]/10);
          for j := 1 to Length(TLDCommand.TempResult)-1 do
            St := St+','+FloatToStrRegion(TLDCommand.TempResult[j]/10);
          TDetector(Dosimeter.DetectorsList[i]).Tmp := St;
        end;

        FillChar(TLDCommand.TempResult, SizeOf(TLDCommand.TempResult), #0);
        FillChar(TLDCommand.ImpulseResult, SizeOf(TLDCommand.ImpulseResult), #0);

        TLDDataModule.ADOQuery.Close;
        TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
        TLDDataModule.ADOQuery.SQL.Add('INSERT INTO tlddetectorres('+cFieldDosMeasID+','
                                                                    +cFieldDetType+','
                                                                    +cFieldDetTypeID+','
                                                                    +cFieldDose+','
                                                                    +cFieldDetErr+','
                                                                    +cFieldDetPosition+','
                                                                    +cFieldKTV+','
                                                                    +cFieldTempProfile+','
                                                                    +cFieldTempProfileWrite+','
                                                                    +cFieldCalcFon+','
                                                                    +cFieldCalcGaus+','
                                                                    +cFieldCoefficient+','
                                                                    +cFieldMeasureTime+','
                                                                    +cFieldAutoProc+','
                                                                    +cFieldMethod+','
                                                                    +cFieldDetComment+','
                                                                    +cFieldDetTypeComment+','
                                                                    +cFieldDetStatus+
                                                                  ') '+
                                                           'VALUES('+IntToStr(Dosimeter.MeasurementID)+','
                                                                +#39+TDetector(Dosimeter.DetectorsList[i]).DetType+#39+','
                                                                    +IntToStr(TDetector(Dosimeter.DetectorsList[i]).DetTypeID)+','
                                                                +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[i]).Dose)+#39+','
                                                                +#39+FloatToStrRegion(TDetector(Dosimeter.DetectorsList[i]).Err)+#39+','
                                                                    +IntToStr(i+1)+','
                                                           +#39+#123+TDetector(Dosimeter.DetectorsList[i]).Ktv+#125+#39+','
                                                           +#39+#123+TDetector(Dosimeter.DetectorsList[i]).Tmp+#125+#39+','
                                                           +#39+#123+TDetector(Dosimeter.DetectorsList[i]).TmpWrite+#125+#39+','
                                                           +#39+#123+TDetector(Dosimeter.DetectorsList[i]).Fon+#125+#39+','
                                                           +#39+#123+TDetector(Dosimeter.DetectorsList[i]).Gaus+#125+#39+','
                                                                +#39+cEmptyData+#39+','
                                                                +#39+DateTimeToStr(Now)+#39+','
                                                                +#39+BoolToStrRegion(TDetector(Dosimeter.DetectorsList[i]).AutoProcessing)+#39+','
                                                                +#39+TDetector(Dosimeter.DetectorsList[i]).Method+#39+','
                                                                +#39+TDetector(Dosimeter.DetectorsList[i]).Comment+#39+','
                                                                +#39+TDetector(Dosimeter.DetectorsList[i]).DetTypeComment+#39+','
                                                                    +IntToStr(GetDetState(TDetector(Dosimeter.DetectorsList[i]).State))+
                                                                  ')');
        TLDDataModule.ADOQuery.ExecSQL;
      end;
    end;
  end;
end;

procedure TMainForm.UpdateDosimeterAdditionalParameters;
var
  i               : integer;
  dosName         : String;
  organization    : String;
  department      : String;
begin
  for i := 0 to DBGridEhDos.SelectedRows.Count-1 do
  begin
    DBGridEhDos.DataSource.DataSet.GotoBookmark(DBGridEhDos.SelectedRows.Items[i]);
    dosName:=DBGridEhDos.DataSource.DataSet.FieldByName(cFullDosID).AsString;
    if FGroupDosOperation then
    begin
      organization:=EditDosDataDosOrgValGroup.Text;
      department:=EditDosDataDosDepValGroup.Text;
    end
    else
    begin
      organization:=EditDosDataDosOrgVal.Text;
      department:=EditDosDataDosDepVal.Text;
    end;
    TLDDataModule.UpdateAdditionalParametersInDos(dosName,organization,department);
  end;
end;

procedure TMainForm.UpdateDetectorComment(MeasurmentID    : integer;
                                          DetPos          : integer;
                                          DetComment      : String);
begin
  TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
  TLDDataModule.ADOQuery.SQL.Add('UPDATE tlddetectorres SET '+cFieldDetComment+
                                                         ' = '+#39+DetComment+#39+
                                                             ' WHERE ('+cFieldDosMeasID+' = '+IntToStr(MeasurmentID)+' AND '+cFieldDetPosition+' = '+IntToStr(DetPos)+')');
  TLDDataModule.ADOQuery.ExecSQL;
end;

procedure TMainForm.CreateDosimeterData;
var
  measID: integer;
begin
// добавляем новую (чистую) запись в результатах измерений
  try

    measID:=TLDDataModule.GetNewMeasID;

    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql

    TLDDataModule.ADOQuery.SQL.Add('INSERT INTO tlddosimeterres ('+cFieldDosMeasID+','
                                                                 +cFieldDosType+','
                                                                 +cFieldDosTypeID+','
                                                                 +cFieldDosID+','
                                                                 +cFieldDosPostfix+','
                                                                 +cFieldKSI+','
                                                                 +cFieldError+','
                                                                 +cFieldFormula+','
                                                                 +cFieldMeasureTime+','
                                                                 +cFieldRegTime+','
                                                                 +cFieldVerTime+','
                                                                 +cFieldValidity+','
                                                                 +cFieldDosStatus+','
                                                                 +cFieldHp10g+','
                                                                 +cFieldHp10n+','
                                                                 +cFieldHp3+','
                                                                 +cFieldHp007+','
                                                                 +cFieldHstar+','
                                                                 +cFieldH007+','
                                                                 +cFieldD+','
                                                                 +cFieldHp10g_err+','
                                                                 +cFieldHp10n_err+','
                                                                 +cFieldHp3_err+','
                                                                 +cFieldHp007_err+','
                                                                 +cFieldHstar_err+','
                                                                 +cFieldH007_err+','
                                                                 +cFieldD_err+','
                                                                 +cField_k1+','
                                                                 +cField_k2+','
                                                                 +cField_k3+','
                                                                 +cField_k4+','
                                                                 +cField_k5+','
                                                                 +cField_kgn+','
                                                                 +cField_ecc1+','
                                                                 +cField_ecc2+','
                                                                 +cField_ecc3+','
                                                                 +cField_ecc4+','
                                                                 +cFieldPartID+','
                                                                 +cFieldDosPartName+','
                                                                 +cFieldTldID+','
                                                                 +cFieldSoftwareVer+','
                                                                 +cFieldTldUser+','
                                                                 +cFieldPersNumber+','
                                                                 +cFieldFio+','
                                                                 +cFieldOrg+','
                                                                 +cFieldDepartment+','
                                                                 +cFieldLastMeasComment+','
                                                                 +cFieldLastMeasTime+','
                                                                 +cFieldMeasComment+
                                                               ') '+
                                                       'VALUES ('+IntToStr(measID)+','
                                                                 +#39+Dosimeter.DosType+#39+','
                                                                     +Dosimeter.DosTypeID+','
                                                                     +IntToStr(Dosimeter.ID)+','
                                                                 +#39+Dosimeter.Postfix+#39+','
                                                                      +IntToStr(Dosimeter.KS)+','
                                                                 +#39+Dosimeter.Error+#39+','
                                                                 +#39+Dosimeter.Formula+#39+','
                                                                 +#39+DateTimeToStr(Now)+#39+','
                                                                 +#39+DateTimeToStr(Dosimeter.RegTime)+#39+','
                                                                 +#39+DateTimeToStr(Dosimeter.VerTime)+#39+','
                                                                     +IntToStr(GetDosValidity(Dosimeter.Validity))+','
                                                                     +IntToStr(GetDosStatus(Dosimeter.Status))+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(Nan)+','
                                                                     +FloatToStrRegion(RoundToCN(Dosimeter.K1,-1))+','
                                                                     +FloatToStrRegion(RoundToCN(Dosimeter.K2,-1))+','
                                                                     +FloatToStrRegion(RoundToCN(Dosimeter.K3,-1))+','
                                                                     +FloatToStrRegion(RoundToCN(Dosimeter.K4,-1))+','
                                                                     +FloatToStrRegion(RoundToCN(Dosimeter.K5,-1))+','
                                                                     +FloatToStrRegion(RoundToCN(Dosimeter.Kgn,-2))+','
                                                                     +FloatToStrRegion(RoundTo(Dosimeter.ecc1,-1))+','
                                                                     +FloatToStrRegion(RoundTo(Dosimeter.ecc2,-1))+','
                                                                     +FloatToStrRegion(RoundTo(Dosimeter.ecc3,-1))+','
                                                                     +FloatToStrRegion(RoundTo(Dosimeter.ecc4,-1))+','
                                                                     +IntToStr(Dosimeter.PartID)+','
                                                                 +#39+Dosimeter.PartName+#39+','
                                                                     +IntToStr(Dosimeter.TldID)+','
                                                                     +IntToStr(Dosimeter.SoftwareVer)+','
                                                                 +#39+Dosimeter.TldUser+#39+','
                                                                     +IntToStr(Dosimeter.PersNumber)+','
                                                                 +#39+Dosimeter.Fio+#39+','
                                                                 +#39+Dosimeter.Organization+#39+','
                                                                 +#39+Dosimeter.Department+#39+','
                                                                 +#39+Dosimeter.LastMeasComment+#39+','
                                                                 +#39+DateTimeToStr(Dosimeter.LastMeasTime)+#39+','
                                                                 +#39+Dosimeter.MeasComment+#39
                                                               +');'
                                                               +'COMMIT;');
    TLDDataModule.ADOQuery.ExecSQL;
  except
    on E: exception do
      raise Exception.Create(Format('%s: %s',[rsDBSaveFault,E.Message]));
  end;
// находим индекс новой записи (автоинкрементируемое поле)
  try
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDosMeasID+' FROM tlddosimeterres ORDER BY '+cFieldDosMeasID+' DESC LIMIT 1');
    TLDDataModule.ADOQuery.Active:=True;
    TLDDataModule.ADOQuery.Last; // перемещаемся на последнюю, только что добавленную запись
  except
    on E: exception do
      raise Exception.Create(Format('%s: %s',[rsDBFindNewRecIndex,E.Message]));
  end;

  Dosimeter.MeasurementID:=TLDDataModule.ADOQuery.FieldValues[cFieldDosMeasID];

  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.Clear;
  TLDDataModule.ADOQuery.Close;
end;

procedure TMainForm.SetDBGridData;
begin
  if Dosimeter <> nil then
  begin
    if Dosimeter.MeasurementID>0 then
    begin
      TDataSetDriverEh(TMemTableEh(DBGridEhProcess.DataSource.DataSet).DataDriver).ProviderDataSet.Open;
      DBGridEhProcess.DataSource.DataSet.Refresh;
    end;
  end;
end;

procedure TMainForm.SaveDosimeterData;
begin
  if Dosimeter <> nil then
  begin
    if Dosimeter.MeasurementID>0 then
    begin
      TLDDataModule.ADOQuery.Active:=False;
      TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
      TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosRes+' SET ('+cFieldHp10g+','
                                                                      +cFieldHp10n+','
                                                                      +cFieldHp3+','
                                                                      +cFieldHp007+','
                                                                      +cFieldHstar+','
                                                                      +cFieldH007+','
                                                                      +cFieldD+','
                                                                      +cFieldHp10g_err+','
                                                                      +cFieldHp10n_err+','
                                                                      +cFieldHp3_err+','
                                                                      +cFieldHp007_err+','
                                                                      +cFieldHstar_err+','
                                                                      +cFieldH007_err+','
                                                                      +cFieldD_err+','
                                                                      +cField_k1+','
                                                                      +cField_k2+','
                                                                      +cField_k3+','
                                                                      +cField_k4+','
                                                                      +cField_k5+','
                                                                      +cField_kgn+','
                                                                      +cField_ecc1+','
                                                                      +cField_ecc2+','
                                                                      +cField_ecc3+','
                                                                      +cField_ecc4+','
                                                                      +cFieldFormulaId_Dos+','
                                                                      +cFieldFormulaId_Val_1+','
                                                                      +cFieldFormulaId_Val_2+','
                                                                      +cFieldFormulaId_Val_3+','
                                                                      +cFieldFormulaId_Val_4+','
                                                                      +cFieldFormula_Err_k1_1+','
                                                                      +cFieldFormula_Err_k2_1+','
                                                                      +cFieldFormula_Err_k1_2+','
                                                                      +cFieldFormula_Err_k2_2+','
                                                                      +cFieldFormula_Err_k1_3+','
                                                                      +cFieldFormula_Err_k2_3+','
                                                                      +cFieldFormula_Err_k1_4+','
                                                                      +cFieldFormula_Err_k2_4+','
                                                                      +cFieldMeasVal+','
                                                                      +cFieldError+','
                                                                      +cFieldFormula+','
                                                                      +cFieldTldID+','
                                                                      +cFieldKFilter+','
                                                                      +cFieldKDevice+','
                                                                      +cFieldDosStatus+','
                                                                      +cFieldValidity+','
                                                                      +cFieldMeasComment+','
                                                                      +cFieldVerTime+','
                                                                      +cFieldMeasureTime+','
                                                                      +cFieldSoftwareVer+','
                                                                      +cFieldLastMeasTime+','
                                                                      +cFieldLastMeasComment+''
                                                                   +') '
                                                                +'= ('+FloatToStrRegion(Dosimeter.Dose_Hp_10g)+','
                                                                      +FloatToStrRegion(Dosimeter.Dose_Hp_10n)+','
                                                                      +FloatToStrRegion(Dosimeter.Dose_Hp_3)+','
                                                                      +FloatToStrRegion(Dosimeter.Dose_Hp_007)+','
                                                                      +FloatToStrRegion(Dosimeter.Dose_H_star)+','
                                                                      +FloatToStrRegion(Dosimeter.Dose_H_007)+','
                                                                      +FloatToStrRegion(Dosimeter.Dose_D)+','
                                                                      +FloatToStrRegion(Dosimeter.Err_Hp_10g)+','
                                                                      +FloatToStrRegion(Dosimeter.Err_Hp_10n)+','
                                                                      +FloatToStrRegion(Dosimeter.Err_Hp_3)+','
                                                                      +FloatToStrRegion(Dosimeter.Err_Hp_007)+','
                                                                      +FloatToStrRegion(Dosimeter.Err_H_star)+','
                                                                      +FloatToStrRegion(Dosimeter.Err_H_007)+','
                                                                      +FloatToStrRegion(Dosimeter.Err_D)+','
                                                                      +FloatToStrRegion(Dosimeter.K1)+','
                                                                      +FloatToStrRegion(Dosimeter.K2)+','
                                                                      +FloatToStrRegion(Dosimeter.K3)+','
                                                                      +FloatToStrRegion(Dosimeter.K4)+','
                                                                      +FloatToStrRegion(Dosimeter.K5)+','
                                                                      +FloatToStrRegion(Dosimeter.Kgn)+','
                                                                      +FloatToStrRegion(Dosimeter.Ecc1)+','
                                                                      +FloatToStrRegion(Dosimeter.Ecc2)+','
                                                                      +FloatToStrRegion(Dosimeter.Ecc3)+','
                                                                      +FloatToStrRegion(Dosimeter.Ecc4)+','
                                                                      +IntToStr(Dosimeter.FormulaID)+','
                                                                      +IntToStr(Dosimeter.FormulaID_Val_1)+','
                                                                      +IntToStr(Dosimeter.FormulaID_Val_2)+','
                                                                      +IntToStr(Dosimeter.FormulaID_Val_3)+','
                                                                      +IntToStr(Dosimeter.FormulaID_Val_4)+','
                                                                      +FloatToStrRegion(Dosimeter.Formula_Val_ErrK1_1)+','
                                                                      +FloatToStrRegion(Dosimeter.Formula_Val_ErrK2_1)+','
                                                                      +FloatToStrRegion(Dosimeter.Formula_Val_ErrK1_2)+','
                                                                      +FloatToStrRegion(Dosimeter.Formula_Val_ErrK2_2)+','
                                                                      +FloatToStrRegion(Dosimeter.Formula_Val_ErrK1_3)+','
                                                                      +FloatToStrRegion(Dosimeter.Formula_Val_ErrK2_3)+','
                                                                      +FloatToStrRegion(Dosimeter.Formula_Val_ErrK1_4)+','
                                                                      +FloatToStrRegion(Dosimeter.Formula_Val_ErrK2_4)+','
                                                                      +#39+Dosimeter.MeasValues+#39+','
                                                                      +#39+Dosimeter.Error+#39+','
                                                                      +#39+Dosimeter.Formula+#39+','
                                                                      +IntToStr(DeviceID)+','
                                                                      +FloatToStrRegion(Dosimeter.KFilter)+','
                                                                      +FloatToStrRegion(Dosimeter.KDevice)+','
                                                                      +IntToStr(GetDosStatus(Dosimeter.Status))+','
                                                                      +IntToStr(GetDosValidity(Dosimeter.Validity))+','
                                                                      +#39+Dosimeter.MeasComment+#39','
                                                                      +#39+DateTimeToStr(Dosimeter.VerTime)+#39+','
                                                                      +#39+DateTimeToStr(Dosimeter.MeasTime)+#39+','
                                                                      +IntToStr(SoftwareVer)+','
                                                                      +#39+DateTimeToStr(Dosimeter.LastMeasTime)+#39+','
                                                                      +#39+Dosimeter.LastMeasComment+#39+
                                                                    ') '
                                                                   +'WHERE '+cFieldDosMeasID+' = '+IntToStr(Dosimeter.MeasurementID)+';'
                                    +'UPDATE '+cDBTableDosID+' SET ('+cFieldLastMeasComment+','
                                                                     +cFieldLastMeasResult+','
                                                                     +cFieldLastMeasTime+')'
                                                                 +'='
                                                                 +'('+#39+Dosimeter.LastMeasComment+#39+','
                                                                     +IntToStr(GetDosValidity(Dosimeter.Validity))+','
                                                                     +#39+DateTimeToStr(Dosimeter.MeasTime)+#39+')'
                                                                   +'WHERE '+cFieldDosID+' = '+IntToStr(Dosimeter.ID)+' AND '+cFieldDosPostfix+'='+#39+Dosimeter.Postfix+#39+';'
                                                                   +'COMMIT;');
      TLDDataModule.ADOQuery.ExecSQL;

    end;
  end;
end;

procedure TMainForm.UpdateDosimeterResStatus;
begin
  if Dosimeter <> nil then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosRes+' SET'+'('
                                                                  +cFieldValidity+','
                                                                  +cFieldLastMeasComment+')'
                                                                  +'='+'('
                                                                  +IntToStr(GetDosValidity(Dosimeter.Validity))+','
                                                                  +#39+Dosimeter.LastMeasComment+#39+')'
                                                                  +' WHERE '+cFieldDosMeasID+' = '+IntToStr(Dosimeter.MeasurementID)+';'
//                                  +'UPDATE '+cDBTableDosID+' SET'+'('
//                                                                  +cFieldLastMeasResult+','
//                                                                  +cFieldLastMeasComment+')'
//                                                                  +'='+'('
//                                                                  +IntToStr(GetDosValidity(Dosimeter.Validity))+','
//                                                                  +#39+Dosimeter.LastMeasComment+#39+')'
//                                                                  +' WHERE '+cFieldDosID+' = '+IntToStr(Dosimeter.ID)+' AND '+cFieldDosPostfix+'='+#39+Dosimeter.Postfix+#39+';'
                                                                  );
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

procedure TMainForm.UpdateDosimeterLastMeas;
begin
  if Dosimeter <> nil then
  begin
    if Dosimeter.MeasurementID>0 then
    begin
      if TLDDataModule.ADOQuery.Active then TLDDataModule.ADOQuery.Active:=False;
      TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
      TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET ('+cFieldLastMeasComment+','
                                                                     +cFieldLastMeasResult+')'
                                                                 +'='
                                                                 +'('+#39+Dosimeter.LastMeasComment+#39+','
                                                                     +IntToStr(GetDosValidity(Dosimeter.Validity))+')'
                                                                 +'WHERE '+cFieldDosID+' = '+IntToStr(Dosimeter.ID)+' AND '+cFieldDosPostfix+'='+#39+Dosimeter.Postfix+#39+';'
                                                                 );
      TLDDataModule.ADOQuery.ExecSQL;
      TLDDataModule.ADOQuery.Active:=False;
    end;
  end;
end;

procedure TMainForm.UpdateDosimeterResStatusAndMeasTime;
begin
  if Dosimeter <> nil then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosRes+' SET ('
                                                                  +cFieldValidity+','
                                                                  +cFieldMeasureTime+' '
                                                                 +')'
                                                                 +' = '
                                                                 +'('+IntToStr(GetDosValidity(Dosimeter.Validity))+','
                                                                 +#39+DateTimeToStr(Dosimeter.MeasTime)+#39+' '
                                                                 +')'
                                                                 +' WHERE '+cFieldDosMeasID+' = '+IntToStr(Dosimeter.MeasurementID));
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

procedure TMainForm.SaveMeasComment;
begin
  if Dosimeter <> nil then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosRes+' SET '
                                                                  +cFieldMeasComment
                                                                  +' = '
                                                                  +#39+Dosimeter.MeasComment+#39
                                                                  +' WHERE '+cFieldDosMeasID+' = '+IntToStr(Dosimeter.MeasurementID));
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

var ActiveForm: Boolean = true;  //  флаг для отлеживания первого события OnActive главной формы. По первому событию анализируем список доступных COM-портров и открываем их
procedure TMainForm.FormActivate(Sender: TObject);
var
  i         : integer;
  loggedIn  : boolean;
  dbName    : String;
  ConfigIni: Tinifile;
  DialogType: TDialogType;
  PanelHost: string;
begin
  if ActiveForm then
  begin
    ActiveForm:=false;
    loggedIn:=false;

    ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
    try
      WriteLog(rsEnter);
      WriteModbusLog(rsEnter+' '+DateTimeToStr(Now));

      Left:=ConfigIni.ReadInteger(cSectionSettings, 'X', 0);
      Top:=ConfigIni.ReadInteger(cSectionSettings, 'Y', 0);
      Width:=ConfigIni.ReadInteger(cSectionSettings, 'Width', 1280);
      Height:=ConfigIni.ReadInteger(cSectionSettings, 'Height', 1024);
      FKTime:=ConfigIni.ReadInteger(cSectionSettings, 'KTime', 10);
      FTempDeviation:=ConfigIni.ReadInteger(cSectionSettings, 'TempDeviation', 50);
      FCOMName:=ConfigIni.ReadString(cSectionComPortSettings, 'COMName', 'COM1');
      FBaudRate:=ConfigIni.ReadInteger(cSectionComPortSettings, 'BaudRate', 115200);
      FStopBits:=ConfigIni.ReadInteger(cSectionComPortSettings, 'StopBits', 1);
      FParity:=ConfigIni.ReadInteger(cSectionComPortSettings, 'Parity', 0);
      FByteSize:=ConfigIni.ReadInteger(cSectionComPortSettings, 'ByteSize', 8);

      FConfirmationRequest:=ConfigIni.ReadBool(cSectionSettings, cSettingsConfirmationRequest, true);
      FReportWithDets:=ConfigIni.ReadBool(cSectionSettings, cSettingsReportWithDets, false);
      FShowOriginalKTV:=ConfigIni.ReadBool(cSectionSettings, cSettingsShowOriginalKTV, true);
      FShowGladeKTV:=ConfigIni.ReadBool(cSectionSettings, cSettingsShowGladeKTV, true);
      FUseControlComment:=ConfigIni.ReadBool(cSectionSettings, cSettingsUseControlComment, false);
      FControlComment:=ConfigIni.ReadString(cSectionSettings, cSettingsControlComment, '');
      FAutoReset:=ConfigIni.ReadBool(cSectionSettings, cSettingsAutoReset, false);
      FLastUserWarning:=ConfigIni.ReadString(cSectionSettings, cSettingsLastUserWarning, rsDosMeasForProcessing);
      FUseDevFilterIndBit:=ConfigIni.ReadBool(cSectionSettings, cSettingsDevFilterIndBit, false);
      FDosCntAutoCreatePart:=ConfigIni.ReadInteger(cSectionSettings, cSettingsDosCntAutoCreatePart, 1);
      FSettingsSkipDetector:=ConfigIni.ReadInteger(cSectionSettings, cSettingsSkipDetector, cSkipDetectorAutoDisable);

      JvSpeedBtnStart.Visible:=true; //ConfigIni.ReadBool(cSectionSettings, cQueue, true);

      TestSourceUse:=ConfigIni.ReadBool(cSectionTest, cTestSourceUse, false);
      TestSourceTimeIncrease:=ConfigIni.ReadBool(cSectionTest, cTestSourceTimeIncrease, false);
      TestSourceTimeIncreaseCycle:=ConfigIni.ReadInteger(cSectionTest, cTestSourceTimeIncreaseCycle, 1);
      TestSourceKIncrease:=ConfigIni.ReadFloat(cSectionTest, cTestSourceKIncrease, 2);
      TestSourceDosimeterName:=ConfigIni.ReadString(cSectionTest, cTestSourceDosimeterName, cTestDosName);
      TestSourceTime:=ConfigIni.ReadInteger(cSectionTest,cTestSourceTime,1);
      TestWriteModbusLog:=ConfigIni.ReadBool(cSectionTest, cTestWriteModbusLog, false);

      FMeasColumnMeasID:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasID, true);
      FMeasColumnMeasDateTime:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasDateTime, true);
      FMeasColumnKSI:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasKSI, true);
      FMeasColumnDose:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasDose, true);
      FMeasColumnHp10g:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasHp10g, true);
      FMeasColumnHp10n:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasHp10n, true);
      FMeasColumnHp007:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasHp007, true);
      FMeasColumnHp3:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasHp3, true);
      FMeasColumnHStar:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasHStar, true);
      FMeasColumnH007:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasH007, true);
      FMeasColumnD:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasD, true);
      FMeasColumnHp10g_Err:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasHp10g_Err, true);
      FMeasColumnHp10n_Err:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasHp10n_Err, true);
      FMeasColumnHp007_Err:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasHp007_Err, true);
      FMeasColumnHp3_Err:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasHp3_Err, true);
      FMeasColumnHStar_Err:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasHStar_Err, true);
      FMeasColumnH007_Err:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasH007_Err, true);
      FMeasColumnD_Err:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasD_Err, true);
      FMeasColumnMeasValidity:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasValidity, true);
      FMeasColumnDosType:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasDosType, false);
      FMeasColumnDosReg:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasDosReg, false);
      FMeasColumnDosVer:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasDosVer, false);
      FMeasColumnDosStatus:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasDosStatus, false);
      FMeasColumnOrganization:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasOrganization, false);
      FMeasColumnDepartment:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasDepartment, false);
      FMeasColumnPartID:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasPartID, false);
      FMeasColumnMeasComment:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasComment, false);
      FMeasColumnPersNumber:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasPersNumber, false);
      FMeasColumnFIO:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasFIO, false);
      FMeasColumnTLDUser:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasTLDUser, false);
      FMeasColumnLastMeasTime:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasLastMeasTime, false);
      FMeasColumnLastMeasComment:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasLastMeasComment, false);
      FMeasColumnTldID:=ConfigIni.ReadBool(cSectionGridColumnsMeas, cColumnMeasTldID, false);

      FProcessColumnMeasID:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessID, true);
      FProcessColumnMeasDateTime:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessDateTime, true);
      FProcessColumnKSI:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessKSI, true);
      FProcessColumnDose:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessDose, true);
      FProcessColumnHp10g:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessHp10g, true);
      FProcessColumnHp10n:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessHp10n, true);
      FProcessColumnHp007:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessHp007, true);
      FProcessColumnHp3:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessHp3, true);
      FProcessColumnHStar:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessHStar, true);
      FProcessColumnH007:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessH007, true);
      FProcessColumnD:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessD, true);
      FProcessColumnHp10g_Err:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessHp10g_Err, true);
      FProcessColumnHp10n_Err:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessHp10n_Err, true);
      FProcessColumnHp007_Err:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessHp007_Err, true);
      FProcessColumnHp3_Err:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessHp3_Err, true);
      FProcessColumnHStar_Err:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessHStar_Err, true);
      FProcessColumnH007_Err:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessH007_Err, true);
      FProcessColumnD_Err:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessD_Err, true);
      FProcessColumnMeasValidity:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessValidity, true);
      FProcessColumnDosType:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessDosType, false);
      FProcessColumnDosReg:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessDosReg, false);
      FProcessColumnDosVer:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessDosVer, false);
      FProcessColumnDosStatus:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessDosStatus, false);
      FProcessColumnOrganization:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessOrganization, false);
      FProcessColumnDepartment:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessDepartment, false);
      FProcessColumnPartID:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessPartID, false);
      FProcessColumnMeasComment:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessComment, false);
      FProcessColumnPersNumber:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessPersNumber, false);
      FProcessColumnFIO:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessFIO, false);
      FProcessColumnTLDUser:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessTLDUser, false);
      FProcessColumnLastMeasTime:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessLastMeasTime, false);
      FProcessColumnLastMeasComment:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessLastMeasComment, false);
      FProcessColumnTldID:=ConfigIni.ReadBool(cSectionGridColumnsProcess, cColumnProcessTldID, false);

      FCalibrColumnMeasID:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrID, true);
      FCalibrColumnMeasDateTime:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrDateTime, true);
      FCalibrColumnKSI:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrKSI, true);
      FCalibrColumnDose:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrDose, true);
      FCalibrColumnK1:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrK1, true);
      FCalibrColumnK2:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrK2, true);
      FCalibrColumnK3:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrK3, true);
      FCalibrColumnK4:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrK4, true);
      FCalibrColumnK5:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrK5, true);
      FCalibrColumnKgn:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrKgn, true);
      FCalibrColumnHp10g:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrHp10g, true);
      FCalibrColumnHp10n:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrHp10n, true);
      FCalibrColumnHp007:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrHp007, true);
      FCalibrColumnHp3:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrHp3, true);
      FCalibrColumnHStar:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrHStar, true);
      FCalibrColumnH007:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrH007, true);
      FCalibrColumnD:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrD, true);
      FCalibrColumnHp10g_Err:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrHp10g_Err, true);
      FCalibrColumnHp10n_Err:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrHp10n_Err, true);
      FCalibrColumnHp007_Err:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrHp007_Err, true);
      FCalibrColumnHp3_Err:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrHp3_Err, true);
      FCalibrColumnHStar_Err:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrHStar_Err, true);
      FCalibrColumnH007_Err:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrH007_Err, true);
      FCalibrColumnD_Err:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrD_Err, true);
      FCalibrColumnMeasValidity:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrValidity, true);
      FCalibrColumnDosType:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrDosType, false);
      FCalibrColumnDosReg:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrDosReg, false);
      FCalibrColumnDosVer:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrDosVer, false);
      FCalibrColumnDosStatus:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrDosStatus, false);
      FCalibrColumnOrganization:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrOrganization, false);
      FCalibrColumnDepartment:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrDepartment, false);
      FCalibrColumnPartID:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrPartID, false);
      FCalibrColumnMeasComment:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrComment, false);
      FCalibrColumnPersNumber:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrPersNumber, false);
      FCalibrColumnFIO:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrFIO, false);
      FCalibrColumnTLDUser:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrTLDUser, false);
      FCalibrColumnLastMeasComment:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrLastMeasComment, false);
      FCalibrColumnTldID:=ConfigIni.ReadBool(cSectionGridColumnsCalibr, cColumnCalibrTldID, false);

      FDosColumnDosType:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosType, true);
      FDosColumnDosState:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosStatus, true);
      FDosColumnk1:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosk1, false);
      FDosColumnk2:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosk2, false);
      FDosColumnk3:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosk3, false);
      FDosColumnk4:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosk4, false);
      FDosColumnk5:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosk5, false);
      FDosColumnkgn:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDoskgn, false);
      FDosColumnPartID:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosPartID, false);
      FDosColumnRegTime:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosReg, false);
      FDosColumnVerTime:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosVer, true);
      FDosColumnOrg:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosOrganization, false);
      FDosColumnDep:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosDepartment, false);
      FDosColumnLastMeasTime:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosLastMeasTime, false);
      FDosColumnLastMeasResult:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosLastMeasResult, false);
      FDosColumnLastMeasComment:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosLastMeasComment, false);
      FDosColumnTldID:=ConfigIni.ReadBool(cSectionGridColumnsDos, cColumnDosTldID, false);

      Peltier_TargetTempFromIni := ConfigIni.ReadFloat(cSectionDeviceUnits, cMonitorTargetTemp, Peltier_TargetTempFromIni);
      Old_AirHeat_FromIni := ConfigIni.ReadBool(cSectionDeviceUnits, cOld_AirHeat, Old_AirHeat_FromIni);
      for DialogType:=Low(TDialogType) to High(TDialogType) do
        UI_Delay[DialogType] := ConfigIni.ReadInteger(cSectionSettings, 'DialogType['+GetEnumName(TypeInfo(TDialogType),Ord(DialogType))+']', UI_Delay[DialogType]);

      //    TLDCommand.ReinitializationPort;
      TLDCommand:=TTLD_Auto.Create(FCOMName,FBaudRate,FStopBits,FParity,FByteSize); // конструктор TBus
      TLDCommand.OnReceiveModBusExchange:=@OnReceiveModBusExchange;
      TLDCommand.OnCommandLog:=@OnCommandLog;
      TLDCommand.OnTLDError:=@OnTLDError;
      TLDCommand.OnTLDMeasuring:=@OnTLDDetsMeas;
      TLDCommand.OnReceiveTemp:=@OnReceiveTemp;
      TLDCommand.OnReceiveResults := @OnReceiveResults;
      TLDCommand.OnGetPanelCommand := @OnGetPanelCommand;
      TLDCommand.PMT.TargetTempFromIni := Peltier_TargetTempFromIni;
      TLDCommand.AirHeat.OldVersion := Old_AirHeat_FromIni;
      TLDCommand.OnReceiveDeviceID := @OnReceiveDeviceID;

      TLD_CommandSeries := TTLD_CommandSeries.Create(TLDCommand);
      TLD_CommandSeries.OnMeasureScanDosimeter := @OnMeasureScanDosimeter;
      TLD_CommandSeries.OnChangeConnectionState:=@OnChangeConnectionState;
      TLD_CommandSeries.OnChangeTLDMode:=@OnChangeTLDMode;
      TLD_CommandSeries.OnEndMeasure := @OnEndMeasure;
      TLD_CommandSeries.OnReceiveCommand_CloseStartMFWindow := @OnReceiveCommand_CloseStartMFWindow;
      TLD_CommandSeries.OnReceiveCommand_MeasureStopped := @OnReceiveCommand_MeasureStopped;
      TLD_CommandSeries.OnCheckDarkCurrent := @OnCheckDarkCurrent;
      TLD_CommandSeries.OnCheckKSI := @OnCheckKSI;
      TLD_CommandSeries.OnUIAnswerForFailure := @OnUIAnswer;
      //TLD_CommandSeries.OnUIEndMeasure := @OnUIEndMeasure;

      try
        TLDCommand.Motors.IrradiationEDR := ConfigIni.ReadFloat(cSectionDeviceUnits, cIrradiationEDR, 3);
        if not TLDCommand.Emulator then
        begin
          PanelHost := ConfigIni.ReadString(cSectionDeviceUnits, cUserPanelHost, '192.168.157.17');
          if UpperCase(PanelHost) <> 'NONE' then
          begin
            TLDCommand.ModbusClient.Host:= PanelHost;
            TLDCommand.ModbusClient.UnitID := ConfigIni.ReadInteger(cSectionDeviceUnits, cUserPanelMBAddr, 1);//1;
            TLDCommand.ModbusClient.TimeOut:= ConfigIni.ReadInteger(cSectionDeviceUnits, cUserPanelTimeOut, 2500);//2500;
            TLDCommand.ModbusClient.AutoConnect:=True;
          end
            else ControlW.CheckBox_Panel_DontUse.Checked:=True;
          //ModbusClient.Connect;
        end;
      except
      end;

      LoadColumnsGridMeas;
      LoadColumnsGridDos;

      TabSheetSettings.TabVisible:=false;
      TabSheetMeasProcessing.TabVisible:=false;
      PageControlMain.ActivePage:=TabSheetMeas;

      ppMeasSaveToFileWithiDetDose.Checked:=FReportWithDets;
      ppProcessSaveToFileWithiDetDose.Checked:=FReportWithDets;

      dbName:=TLDDataModule.DBName;

      FSoftwareVer:=StrToInt(FileBuild(ExtractFilePath(Application.ExeName)+ExtractFileName(Application.ExeName)));

      try
        TLDDataModule.ConnectToDB(cPostgreDefaultDB);

        if TLDDataModule.IsDBExist(dbName) then
          TLDDataModule.ConnectToDB(dbName)
        else
        begin
          TLDDataModule.CreateDB(dbName,False);
          TLDDataModule.ConnectToDB(dbName);
        end;

        CheckDBConnection;

        if TLDDataModule.ASIDK_Use then
        begin
          TLDDataModule.ConnectTo_ASIDK_DB(TLDDataModule.ASIDK_DBName);
          Check_ASIDK_DBConnection;
        end;

        loggedIn:=Autentification;
  //**//      CheckFilters;

      except
        on E: EDBConnectionErr do
        begin
          MessageDlg(E.Message, mtError,[mbOK],0);
          OnCommandLog(TimeToStr(Now)+' : -> ',rsDBConnectionError + ' "'+TLDDataModule.DBName+'" '+E.Message,'',cMsgInf,cMsgPriorityInf);
        end;
        on E: EDB_ASIDK_ConnectionErr do
        begin
          MessageDlg(E.Message, mtError,[mbOK],0);
          OnCommandLog(TimeToStr(Now)+' : -> ',rsDB_ASIDKConnectionError+' "'+TLDDataModule.ASIDK_DBName+'" '+E.Message,'',cMsgInf,cMsgPriorityInf);
        end
        else
        begin
          MessageDlg(Format('%s - %s',[rsDBConnectionFault,TLDDataModule.DBName]), mtError,[mbOK],0);
          OnCommandLog(TimeToStr(Now)+' : -> ',rsDBConnectionError + ' "'+TLDDataModule.DBName+'"','',cMsgInf,cMsgPriorityInf);
        end;

      end;

      if loggedIn then
      begin

        CheckFilters;

        if TLDDataModule.IsDBConnected then
        begin
          if IsValidDBVersion then
          begin
            ReadDeivceIdIni;
            UpdateGridPageStart;
            BackUpForm.CircleBackupDB(TLDDataModule.DBName);
          end
          else
          begin
            FConfirmationRequest:=false;
            Close;
          end;
        end;

        SetInterfaceByPermits;
        CBoxSettingsShowOriginalKTV.Checked:=ShowOriginalKTV;
        CBoxSettingsShowGladeKTV.Checked:=ShowGladeKTV;
        CBoxSettingsAutoResetDevice.Checked:=AutoReset;
        CBoxSettingsUseAutoComment.Checked:=UseControlComment;
        MemoSettingsAutoComment.Text:=ControlComment;

        for i := 0 to Length(AW.Users)-1 do
        begin
          if AW.Users[i].Login = AW.CurrentUser.Login then PermitSelectedRowUser := i;
        end;
      end
      else
      begin
        if ActiveForm then
          FormActivate(Self)
        else
          Close;
      end;
    finally
      ConfigIni.Free;
    end;
  end;
end;

function TMainForm.Autentification: boolean;
var
  loggedIn        : boolean;
  parsingResult   : boolean;
//  firstStart      : boolean;
  procedure OpenRestoreWindow;
  begin
    OpenDB.ShowModal;
    if OpenDB.RestoreState>=0 then
      ActiveForm:=true;
    loggedIn:=false;
  end;
  procedure Connect;
  begin
    if parsingResult then
    begin
      if not AW.ExitBtnClick then             // проверяем нажата-ли кнопка "Exit" в окне аутентификации
      begin                                   // если кнопка не нажата, то формируем объекты устройств
        OpenCOMPort;                          // открываем COM-порт
        //SetW.ConnectionState;
      end;

      loggedIn:=not AW.ExitBtnClick;
    end
    else
    begin
      MessageDlg(Format('%s "%s". %s - %s',[rsDBErrorFound,TLDDataModule.DBName,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError,[mbOK],0);
      OpenRestoreWindow;
    end;
  end;
begin
  try
    if CheckDBTables then
    begin
      ParsingCMDParameters;            // осуществляем разбор параметров, с которыми была запущена программа (если таковые имеются)

      FirstStart:=AW.IsFirstStart;

      if not FirstStart then
      begin
        parsingResult:=AW.ParsingUsersListDB;         // вызываем процедуру обработки списка пользователей из базы

        if UseUserNameCMDPar then        // проверяем взведен ли флаг: "Программа запущена с параметрами: Имя пользоватея, пароль" (/user:Operatop /password:****)
        begin                            // если взведен
          if parsingResult then
            AW.OkButton.Click;           // непоказываем пользователю окно аутентификации, а сразу пытаемся логиниться используя считанные параметры
        end
        else                             // если пареметров нет, то
        begin                            // стандартная процедура аутентификации
          if parsingResult then
          begin
            AW.ShowModal;                // показвываем пользователю окно аутентификации для ввода пользователя и пароля
            AW.ExitButton.Visible:=False;
            AW.OkButton.Left:=82;
          end;
        end;

        Connect;

//        if parsingResult then
//        begin
//          if not AW.ExitBtnClick then             // проверяем нажата-ли кнопка "Exit" в окне аутентификации
//          begin                                   // если кнопка не нажата, то формируем объекты устройств
//            OpenCOMPort;                          // открываем COM-порт
//            SetW.ConnectionState;
//          end;
//
//          loggedIn:=not AW.ExitBtnClick;
//        end
//        else
//        begin
//          MessageDlg(Format('%s "%s". %s - %s',['Обнаружено повреждение базы данных',TLDDataModule.DBName,'Подробная информация в файле',AppDir+'\'+cLogFileName]),mtError,[mbOK],0);
//          OpenRestoreWindow;
//        end;
      end
      else
      begin
        FormUserFirstStart.ShowModal;

        if not FormUserFirstStart.ExitBtnClick then
        begin
          AW.OkButton.Click;
          parsingResult:=AW.ParsingUsersListDB;
          Connect;
          FirstStart:=false;
        end;

        loggedIn:=not FormUserFirstStart.ExitBtnClick;

      end;
    end
    else
    begin
      MessageDlg(Format('%s "%s". %s - %s',[rsDBErrorFound,TLDDataModule.DBName,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError,[mbOK],0);
      OpenRestoreWindow;
    end;

  except
    on E: Exception do
    begin
      WriteLog(Format('%s "%s". %s',[rsAuthentificationError,AW.CurrentUser.Login,E.Message]));
      MessageDlg(Format('%s "%s". %s - %s',[rsAuthentificationError,AW.CurrentUser.Login,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError,[mbOK],0);

      OpenRestoreWindow;
    end;
  end;

  Result:=loggedIn;

end;

function TMainForm.CheckDBTables: boolean;
begin
  Result:=TLDDataModule.CheckTableInDB(cDBTableDosID) AND
          TLDDataModule.CheckTableInDB(cDBTableDosType) AND
          TLDDataModule.CheckTableInDB(cDBTableDosPart) AND
          TLDDataModule.CheckTableInDB(cDBTableDetType) AND
          TLDDataModule.CheckTableInDB(cDBTableDosRes) AND
          TLDDataModule.CheckTableInDB(cDBTableDetRes) AND
          TLDDataModule.CheckTableInDB(cDBTableLog) AND
          TLDDataModule.CheckTableInDB(cDBTableUser) AND
          TLDDataModule.CheckTableInDB(cDBTableSettings) AND
          TLDDataModule.CheckTableInDB(cDBTableConfig);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  temp          : word;
  ConfigIni     : TInifile;
  DialogType    : TDialogType;
begin

  if FStart then
  begin
    temp:=QuestionDlg(Format('%s!',[rsMsgWarning]),Format('%s',[rsLogoutDeniedWhenMeas]),mtWarning,[mrOK],'');

    CanClose:=false;
  end
  else
  begin
    ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
    try
      ConfigIni.WriteInteger(cSectionSettings, 'X', MainForm.Left);
      ConfigIni.WriteInteger(cSectionSettings, 'Y', MainForm.Top);
      ConfigIni.WriteInteger(cSectionSettings, 'Width', MainForm.Width);
      ConfigIni.WriteInteger(cSectionSettings, 'Height', MainForm.Height);
      if DeviceID<>cEmulatorID then ConfigIni.WriteInteger(cSectionSettings, cSettingsDeviceID, DeviceID);
      //ConfigIni.WriteBool(cSectionSettings, cQueue, JvSpeedBtnStart.Visible);
      ConfigIni.WriteBool(cSectionSettings, cSettingsShowOriginalKTV, ShowOriginalKTV);
      ConfigIni.WriteBool(cSectionSettings, cSettingsShowGladeKTV, ShowGladeKTV);
      ConfigIni.WriteBool(cSectionSettings, cSettingsUseControlComment, UseControlComment);
      ConfigIni.WriteString(cSectionSettings, cSettingsControlComment, ControlComment);
      ConfigIni.WriteBool(cSectionSettings, cSettingsAutoReset, AutoReset);

      ConfigIni.WriteBool(cSectionTest, cTestSourceUse, TestSourceUse);
      ConfigIni.WriteBool(cSectionTest, cTestSourceTimeIncrease, TestSourceTimeIncrease);
      ConfigIni.WriteBool(cSectionTest, cTestWriteModbusLog, TestWriteModbusLog);
      ConfigIni.WriteInteger(cSectionTest, cTestSourceTime, TestSourceTime);
      ConfigIni.WriteFloat(cSectionTest, cTestSourceKIncrease, TestSourceKIncrease);
      ConfigIni.WriteInteger(cSectionTest, cTestSourceTimeIncreaseCycle, TestSourceTimeIncreaseCycle);
      ConfigIni.WriteString(cSectionTest, cTestSourceDosimeterName, TestSourceDosimeterName);

      //if Assigned(TLDCommand) then ConfigIni.WriteString(cSectionComPortSettings, 'COMName', TLDCommand.COM);

      // Новые параметры записываем тут чтоб не забыть - потом можно будет удалить из кода
      ConfigIni.WriteFloat(cSectionDeviceUnits, cMonitorTargetTemp, Peltier_TargetTempFromIni);
      ConfigIni.WriteBool(cSectionDeviceUnits, cOld_AirHeat, Old_AirHeat_FromIni);
      ConfigIni.WriteFloat(cSectionDeviceUnits, cIrradiationEDR, TLDCommand.Motors.IrradiationEDR);

      for DialogType:=Low(TDialogType) to High(TDialogType) do
        ConfigIni.WriteInteger(cSectionSettings, 'DialogType['+GetEnumName(TypeInfo(TDialogType),Ord(DialogType))+']', UI_Delay[DialogType]);

    finally
      ConfigIni.Free;
    end;

    if FConfirmationRequest AND not AW.ExitBtnClick then
    begin

      temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s. %s',[rsKeyExitPressed,rsPressYesWhenAgry]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

      case temp of
        mrYes:
        begin
          //if Assigned(TLDCommand) then
          //  TLDCommand.NNSource;
          CanClose:=true;
        end;
        mrNo:
        begin
          CanClose:=false;
        end;
      end;
    end
    else
    begin
      //if Assigned(TLDCommand) then
      //  TLDCommand.NNSource;
      CanClose:=true;
    end;
  end;

  if CanClose then // При таком раскладе не сбросится питание на удалёнке. Ну и фиг с ним.
  if Assigned(ControlW) and ControlW.TGButton_Algorithm_RemoteCOMGo.Checked then // Если был захват удалённого управления, то при выходе - освобождаем
  begin
    ControlW.TGButton_Algorithm_RemoteCOMGoChange(Sender);
    ControlW.TGButton_Algorithm_RemoteCOMGo.Checked:=false;
  end;
{
  // подменяем понятия, так как выход отложенный
  if TLD_CommandSeries.AllowExit or TLD_CommandSeries.isEmulator or (not TLDCommand.Motors.Connected)
  then CanClose:=True
  else
    if CanClose then
    begin
      CanClose:=false;
      TLD_CommandSeries.CMD_CommonCall('modeExit',0);
      FormPowerOff:=TFormPowerOff.Create(Nil);
      FormPowerOff.Show;
      FormPowerOff.Free;
    end;
}
end;

procedure TMainForm.FormCreate(Sender: TObject);
const
  cDefaultKSLevel=100;
  cKSDelta=50;
  cKFilter=20;
var
  hMenuHandle:HMENU;
begin
  AppDir:=ExtractFilePath(Application.ExeName);
  DataSetTextExporterEhDosList := TDataSetTextExporterEh.Create(MainForm);
//--делаем не активной кнопку "закрыть" главной формы
{$IFDEF MSWINDOWS}
  TimerOpenFilter.Interval:=1;

  hMenuHandle := GetSystemMenu(Handle, FALSE);
  if (hMenuHandle <> 0) then
    DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);
{$ELSE}
  TimerOpenFilter.Interval:=20;
{$ENDIF}

  Splash:=TSplash.Create;
  Splash.ProgressBar.Minimum:=0;
  Splash.ProgressBar.Maximum:=4;

  //Queue:=false;

  FirstStart:=false;
  FWorkingTime:=-1;
  FTmpState:=cTmpGray;
  FilterMeasDosNumber:='';
  FilterDosDosNumber:='';
  FilterProcessDosNumber:='';
  FilterCalibrDosNumber:='';
  FInformation:=False;

  FCalibrationPressed:=false;

// вкладка "Дозиметры"
  LblMeasDataDosNumberVal.Caption:='';
  LblMeasDataDosKSVal.Caption:='';
  LblMeasDataKDosVal.Caption:='';
  LblMeasDataFormulaDosVal.Caption:='';
  LblMeasDataDosMeasTimeVal.Caption:='';
  LblMeasDataDosVerVal.Caption:='';

  DateTimePickerProcessFrom.Date:=Now;
  DateTimePickerProcessTo.Date:=Now;

  ChangeStringEdit(EditMeasDataComment,'',clWhite);
  ChangeStringEdit(EditMeasDataDosOrg,'',clWhite);
  ChangeStringEdit(EditMeasDataDosDep,'',clWhite);
  ChangeStringEdit(EditMeasDataDosFio,'',clWhite);
  ChangeStringEdit(EditMeasDataDosPersNumber,'',clWhite);
  ChangeStringEdit(EditMeasDataDosIDK,'',clBtnFace);
  //LblMeasDataCommentVal.Caption:='';

  FSoftwareVer:=0;
  FTestSourceTimeCurrentCycle:=1;

  FKSLevel:=cDefaultKSLevel;
  FKSDelta:=cKSDelta;
  FKFilter:=cKFilter;
  FUseKFilter:=False;

  TLDState:=0;
  CntD:=0;
  FDBVersion:=-1;

//  SpeedBtnStart.Hint := rsStartMeasurement;
//  SpeedBtnStop.Hint := rsStopMeasurement;
//  SpeedBtnPause.Hint:=rsRotateTable;
//  SpeedBtnMeasUserWarning.Hint:=rsControlUserWarning;
//  SpeedBtnProcessUserWarning.Hint:=rsControlUserWarning;
//  SpeedBtnMeasExit.Hint:='Выход из программы';
//  SpeedBtnProcessExit.Hint:='Выход из программы';
//  SpeedBtnDosExit.Hint:='Выход из программы';
//  SpeedBtnSettingsExit.Hint:='Выход из программы';
//  SpeedBtnMeasSaveParam.Hint:='Сохранить изменения';
//  SpeedBtnMeasSaveIDK.Hint:='Сохранить изменения';
//  SpeedBtnProcessSaveParam.Hint:='Сохранить изменения';
//  SpeedBtnProcessSaveIDK.Hint:='Сохранить изменения';
//  SpBtnPrev.Hint:='Предыдущие сутки с измерениями';
//  SpBtnNext.Hint:='Следующие сутки с измерениями';
//  SpeedButtonChangeUser.Hint:='Сменить пользователя';

  EditMeasDataD1Dose.Text:='';
  EditMeasDataD1Dose.Color:=clBtnFace;
  EditMeasDataD1Status.Text:='';
  EditMeasDataD1Status.Color:=clBtnFace;
  LblMeasDataCommentD1Value.Caption:='';

  EditMeasDataD2Dose.Text:='';
  EditMeasDataD2Dose.Color:=clBtnFace;
  EditMeasDataD2Status.Text:='';
  EditMeasDataD2Status.Color:=clBtnFace;
  LblMeasDataCommentD2Value.Caption:='';

  EditMeasDataD3Dose.Text:='';
  EditMeasDataD3Dose.Color:=clBtnFace;
  EditMeasDataD3Status.Text:='';
  EditMeasDataD3Status.Color:=clBtnFace;
  LblMeasDataCommentD3Value.Caption:='';

  EditMeasDataD4Dose.Text:='';
  EditMeasDataD4Dose.Color:=clBtnFace;
  EditMeasDataD4Status.Text:='';
  EditMeasDataD4Status.Color:=clBtnFace;
  LblMeasDataCommentD4Value.Caption:='';

  ListDosInf:=TStringList.Create();
  ListMeasInf:=TStringList.Create();

  FFilterPanelHeight:=PanelProcessLeftFilter.Height;
  FFilterDosPanelHeight:=PanelDosLeftFilter.Height;
  FFilterCalibrPanelHeight:=PanelCalibrLeftFilter.Height;

//  DateTimePickerDosFrom.Format:=#32;
//  DateTimePickerDosTo.Format:=#32;

//  DateTimePickerProcessFrom.Format:=#32;
//  DateTimePickerProcessTo.Format:=#32;

  SelectColorPanelFilter(RGBToColor(230,230,230));

  PermitSelectedRowUser:=0;

  PageControlMain.ActivePage:=TabSheetMeas;
  PageControlMeasDosPar.ActivePage:=PGMeasPage_TSMainPar;
  PageControlSettings.ActivePage:=TabSheetDeviceControl;

  TabSheetDosGroupOperations.TabVisible:=false;

  UI_Delay[dInfo]:=300;
  UI_Delay[dFail]:=100500;
  UI_Delay[dReserv]:=15;
  Peltier_TargetTempFromIni:=15;
  Old_AirHeat_FromIni:=false;

  TimerOpenFilter.Enabled:=False;

end;

procedure TMainForm.CBoxDosimeterTestChange(Sender: TObject);
begin
  if CBoxDosimeterTest.Text<>'' then
  begin
    FTestSourceDosimeterName:=CBoxDosimeterTest.Text;
    CheckValidTestDosName;
  end;
end;

procedure TMainForm.CBoxDosimeterTestKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
cVK_Enter = $0D;          //  кнопка Enter
begin
  if (Key = cVK_Enter) then
  begin
    CheckValidTestDosName;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
//const
//  cGap = ' ';
//var
//  ConfigIni: TInifile;
begin
  WriteLog(rsExit);
  WriteModbusLog(rsExit+' '+DateTimeToStr(Now));

  {ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    ConfigIni.WriteInteger(cSectionSettings, 'X', MainForm.Left);
    ConfigIni.WriteInteger(cSectionSettings, 'Y', MainForm.Top);
    ConfigIni.WriteInteger(cSectionSettings, 'Width', MainForm.Width);
    ConfigIni.WriteInteger(cSectionSettings, 'Height', MainForm.Height);
    if DeviceID<>cEmulatorID then ConfigIni.WriteInteger(cSectionSettings, cSettingsDeviceID, DeviceID);
    ConfigIni.WriteBool(cSectionSettings, cQueue, JvSpeedBtnStart.Visible);
    ConfigIni.WriteBool(cSectionSettings, cSettingsShowOriginalKTV, ShowOriginalKTV);
    ConfigIni.WriteBool(cSectionSettings, cSettingsShowGladeKTV, ShowGladeKTV);
    ConfigIni.WriteBool(cSectionSettings, cSettingsUseControlComment, UseControlComment);
    ConfigIni.WriteString(cSectionSettings, cSettingsControlComment, ControlComment);
    ConfigIni.WriteBool(cSectionSettings, cSettingsAutoReset, AutoReset);

    ConfigIni.WriteBool(cSectionTest, cTestSourceUse, TestSourceUse);
    ConfigIni.WriteBool(cSectionTest, cTestSourceTimeIncrease, TestSourceTimeIncrease);
    ConfigIni.WriteBool(cSectionTest, cTestWriteModbusLog, TestWriteModbusLog);
    ConfigIni.WriteInteger(cSectionTest, cTestSourceTime, TestSourceTime);
    ConfigIni.WriteFloat(cSectionTest, cTestSourceKIncrease, TestSourceKIncrease);
    ConfigIni.WriteInteger(cSectionTest, cTestSourceTimeIncreaseCycle, TestSourceTimeIncreaseCycle);
    ConfigIni.WriteString(cSectionTest, cTestSourceDosimeterName, TestSourceDosimeterName);

    if Assigned(TLDCommand) then ConfigIni.WriteString(cSectionComPortSettings, 'COMName', TLDCommand.COM);

  finally
    ConfigIni.Free;
  end;
  }
  ListDosInf.Free;
  ListMeasInf.Free;
  TLD_CommandSeries.Free;
  TLDCommand.Free;
end;

procedure TMainForm.PopupMenuDosGridPopup(Sender: TObject);
begin
  GridBeforePopupMenuShow(DBGridEhDos);
end;

procedure TMainForm.PopupMenuMeasGridPopup(Sender: TObject);
begin
  GridBeforePopupMenuShow(DBGridEhOnlyMeas);
end;

procedure TMainForm.PopupMenuProcessGridPopup(Sender: TObject);
begin
  GridBeforePopupMenuShow(DBGridEhProcess);
end;

procedure TMainForm.PopupSpeedBtnClick(Sender: TObject);
var
  P: TPoint;
  SB: TSpeedButton;
begin
  if Sender = Nil then Exit;
  SB := Sender as TSpeedButton;

  P:=SB.ClientToScreen(Point(0,SB.Height));
  SB.PopupMenu.PopUp(P.X,P.Y);
//  P:=JvSpeedBtnStart.ClientToScreen(Point(0,JvSpeedBtnStart.Height));
//  PopupMenuStart.PopUp(P.X,P.Y);
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const
   cVK_0 = $30;          //  положение КИ
   cVK_1 = $31;          //  положение загрузка Д1
   cVK_2 = $32;          //  положение загрузка Д2
   cVK_3 = $33;          //  положение загрузка Д3
   cVK_4 = $34;          //  положение загрузка Д4
   cVK_5 = $35;          //  положение измерение Д1
   cVK_6 = $36;          //  положение измерение Д2
   cVK_7 = $37;          //  положение измерение Д3
   cVK_8 = $38;          //  положение измерение Д4
   cNumVK_0 = $60;
   cNumVK_1 = $61;
   cNumVK_2 = $62;
   cNumVK_3 = $63;
   cNumVK_4 = $64;
   cNumVK_5 = $65;
   cNumVK_6 = $66;
   cNumVK_7 = $67;
   cNumVK_8 = $68;
   cWave = $C0;
begin
//  if (Key = сVK_0) or (Key = сNumVK_0) then
//  begin
//    TLDCommand.NNSource;
//  end;
//  if (Key = сVK_1) or (Key = сNumVK_1) then
//  begin
//    TLDCommand.NNLoadD1;
//  end;
//  if (Key = сVK_2) or (Key = сNumVK_2) then
//  begin
//    TLDCommand.NNLoadD2;
//  end;
//  if (Key = сVK_3) or (Key = сNumVK_3) then
//  begin
//    TLDCommand.NNLoadD3;
//  end;
//  if (Key = сVK_4) or (Key = сNumVK_4) then
//  begin
//    TLDCommand.NNLoadD4;
//  end;
//  if (Key = сVK_5) or (Key = сNumVK_5) then
//  begin
//    TLDCommand.NNMeasuringD1;
//  end;
//  if (Key = сVK_6) or (Key = сNumVK_6) then
//  begin
//    TLDCommand.NNMeasuringD2;
//  end;
//  if (Key = сVK_7) or (Key = сNumVK_7) then
//  begin
//    TLDCommand.NNMeasuringD3;
//  end;
//  if (Key = сVK_8) or (Key = сNumVK_8) then
//  begin
//    TLDCommand.NNMeasuringD4;
//  end;

  //if (Key = cWave) then
  //  TLDCommand.NNextTablePosition;


end;

procedure TMainForm.ppMeasChangeNumberClick(Sender: TObject);
begin
  ChangeDosNumber;
end;

procedure TMainForm.ppProcessChangeNumberClick(Sender: TObject);
begin
  ChangeDosNumber;
end;

procedure TMainForm.RadioButton_backupChange(Sender: TObject);
begin
  SetSaveDialogDBFilter;
end;

procedure TMainForm.RadioButton_sqlChange(Sender: TObject);
begin
  SetSaveDialogDBFilter;
end;

procedure TMainForm.SpeedBtnPauseClick(Sender: TObject);
begin
  TLDCommand.ChangeData.IsStopped := SpeedBtnPause.Down;
end;

function TMainForm.CheckFilteredDosNumber: boolean;
var
  DosNumber      : String;
begin
  DosNumber:=DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosID).AsString;            // dosimeterid выделенной строки

  if (DosNumber = FilterDosDosNumber) then
    result:=true
  else
    result:=false;
end;

function TMainForm.GetDetCnt(dosType: String): word;
var
  state   : word;
begin
  state:=0;

  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('select dtype1, dtype2, dtype3, dtype4 from tlddosimetertype where '+cFieldDosType+'='+#39+dosType+#39);
  TLDDataModule.ADOQuery.Active:=True;

  if (TLDDataModule.ADOQuery.FieldByName(cFieldDType1).AsInteger<>0) then inc(state);
  if (TLDDataModule.ADOQuery.FieldByName(cFieldDType2).AsInteger<>0) then inc(state);
  if (TLDDataModule.ADOQuery.FieldByName(cFieldDType3).AsInteger<>0) then inc(state);
  if (TLDDataModule.ADOQuery.FieldByName(cFieldDType4).AsInteger<>0) then inc(state);

  result:=state;
end;

function TMainForm.GetDetStateAfterCalc(Value: TOutEnum): TDetectorState;
begin
  case Value of
    outGood:
    begin
      Result:=stDetProcessed;
    end;
    outWarning:
    begin
      Result:=stDetProcessedWarning;
    end;
    outBad:
    begin
      Result:=stDetProcessedError;
    end;
    else
    begin
      Result:=stDetProcessedError;
    end;
  end;
end;

function TMainForm.GetFilterDosPartID(ComboBox: TComboBox): String;
begin
  if ComboBox.Text = '' then
    Result := cFieldPartID+' >= -1'
  else
  begin
    if ComboBox.Name='CBoxDosDosPart' then
      Result := cFieldPartID+' IN '+'('+TLDDataModule.GetAllPartIDByName(ComboBox.Text)+')'
    else
      Result := cFieldPartID+' IN '+'('+IntToStr(TLDDataModule.GetPartIDFromMeas(ComboBox.Text))+')'
  end;
end;

function TMainForm.GetFilterDosStatus(ComboBox: TComboBox): String;
begin
  if ComboBox.Text = '' then
    Result := '('+cFieldDosStatus+' IN (0,1,2)'+' OR '+cFieldDosStatus+' IS NULL)'
  else
    Result := cFieldDosStatus+' IN ('+IntToStr(GetDosStatus(TDosimeterStatus(ComboBox.ItemIndex)))+')';
end;

//function TMainForm.GetFilterMeasTime(DateTime: TJvDatePickerEdit): String;
function TMainForm.GetFilterMeasTime(DateTime: TDateTimePicker): String;
const
  cTimeFrom = '00:00:00';
  cTimeTo = '23:59:59';
begin
  result := '('+cFieldMeasureTime+' BETWEEN '+#39+DateTimeToStr(DateTime.Date)+' '+cTimeFrom+#39+' AND '+#39+DateTimeToStr(DateTime.Date)+' '+cTimeTo+#39+')';
end;

function TMainForm.GetFilterDosTime(DateTimeFrom: TDateTimePicker; DateTimeTo: TDateTimePicker): String;
begin
{
  if (DateTimeFrom.Format = '') AND (DateTimeTo.Format = '') then
    result := ' AND measurmenttime BETWEEN '+#39+DateTimeToStr(DateTimeFrom.DateTime)+#39+' AND '+#39+DateTimeToStr(DateTimeTo.DateTime)+#39
  else if DateTimeFrom.Format = '' then
    result := ' AND measurmenttime > '+#39+DateTimeToStr(DateTimeFrom.DateTime)+#39
  else if DateTimeTo.Format = '' then
    result := ' AND measurmenttime < '+#39+DateTimeToStr(DateTimeTo.DateTime)+#39
  else
    result := '';
}
end;

function TMainForm.GetFilterDosType(ComboBox: TComboBox): String;
begin
  result := '('+cFieldDosType+' LIKE '+#39+ComboBox.Text+'%'+#39+')';
end;

function TMainForm.GetFilterDosValidity(ComboBox: TComboBox): String;
begin
  case AnsiIndexStr(ComboBox.Text,['',rsDosAccepted,rsDosMeasForProcessing,rsDosNotMeasured,rsDosMeasWarning,rsDosMeasErr]) of
    0:
    begin
      result := '('+cFieldValidity+' IN '+'(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26)'+' OR '+cFieldValidity+' IS NULL)';     // отображаем записи с NULL-полями (значит с состоянием "Не измерен")
    end;
    1:
    begin
      result := cFieldValidity+' IN '+'(25)'; // принят
    end;
    2:
    begin
      result := cFieldValidity+' IN '+'(26)'; // не принят
    end;
    3:
    begin
      result := '('+cFieldValidity+' IN '+'(0,1,2,3,4,5,6,7,8,9,10,11,12,13,18,19,20,21)'+' OR '+cFieldValidity+' IS NULL)';   // отображаем записи с NULL-полями (значит с состоянием "Не измерен")
    end;
    4:
    begin
      result := cFieldValidity+' IN '+'(22)'; // измерен с предупреждениями
    end;
    5:
    begin
      result := cFieldValidity+' IN '+'(14,15,16,17,23)'; // измерен с ошибками
    end;
  end;
end;

function TMainForm.GetFilterMeasComment(ComboBox: TComboBox): String;
begin
  if ComboBox.Text = '' then
    result := '('+cFieldMeasComment+' LIKE '+#39+ComboBox.Text+'%'+#39+'OR '+cFieldMeasComment+' IS NULL)'
  else
    result :=cFieldMeasComment+' = '+#39+ComboBox.Text+#39;
end;

function TMainForm.GetFilterDosDepartment(ComboBox: TComboBox): String;
begin
  result := cFieldDepartment+' LIKE '+#39+ComboBox.Text+'%'+#39
end;

function TMainForm.GetFilterMeasDosName: String;
begin
  result:='(CAST (dosimeterid AS TEXT) LIKE '+#39+FilterMeasDosNumber+'%'+#39+' OR CAST (dosimeterid AS TEXT) || postfix LIKE '+#39+FilterMeasDosNumber+'%'+#39+')';
end;

function TMainForm.GetFilterDosDosName: String;
begin
  result:='(CAST (dosimeterid AS TEXT) LIKE '+#39+FilterDosDosNumber+'%'+#39+' OR CAST (dosimeterid AS TEXT) || postfix LIKE '+#39+FilterDosDosNumber+'%'+#39+')';
end;

function TMainForm.GetFilterProcessDosName: String;
begin
  result:='(CAST (dosimeterid AS TEXT) LIKE '+#39+FilterProcessDosNumber+'%'+#39+' OR CAST (dosimeterid AS TEXT) || postfix LIKE '+#39+FilterProcessDosNumber+'%'+#39+')';
end;

function TMainForm.GetFilterDosOrganization(ComboBox: TComboBox): String;
begin
  result := cFieldOrg+' LIKE '+#39+ComboBox.Text+'%'+#39
end;

function TMainForm.GetGridDosNumber: String;
begin
  result:=DBGridEhDos.DataSource.DataSet.FieldByName(cFullDosID).AsString;            // dosimeterid выделенной строки
end;

function TMainForm.GetValForQuery(MeasID: String): boolean;
begin
  IDMeasForQuery:=MeasID;

  if (IDForQuery<>'') and
     (IDMeasForQuery<>'') and
     (DosTypeForQuery<>'') then result:=true
  else
    result:=false;
end;

procedure TMainForm.HideDetectorsPanel(DetCnt: word);
begin
  case DetCnt of
    1:
    begin
      HideD1:=false;
      HideD2:=true;
      HideD3:=true;
      HideD4:=true;
    end;
    2:
    begin
      HideD1:=false;
      HideD2:=false;
      HideD3:=true;
      HideD4:=true;
    end;
    3:
    begin
      HideD1:=false;
      HideD2:=false;
      HideD3:=false;
      HideD4:=true;
    end;
    4:
    begin
      HideD1:=false;
      HideD2:=false;
      HideD3:=false;
      HideD4:=false;
    end;
  end;

  ClearCharts;
  PanelDataResize(Self);

end;

//procedure TMainForm.HideGridPopupMenu(const Value: boolean);
//begin
//  ppProcessGridGap1.Visible:=not Value;
//  ppProcessGridCalibration.Visible:=not Value;
//  ppProcessGridRecalc.Visible:=not Value;
//  ppProcessGridSendToModel.Visible:=not Value;
//  ppProcessGridDel.Visible:=not Value;
//end;

function TMainForm.IsEditCommentChanged(EditComment: TEdit): boolean;
begin
  if Assigned(Dosimeter) then
  begin
    if (EditComment.Text<>Dosimeter.MeasComment) then
      Result:=true
    else
      Result:=false;
  end
  else
    Result:=false;
end;

function TMainForm.IsEditCurrentDBCommentChanged(EditDBComment: TEdit): boolean;
begin
  if EditDBComment.Text<>TLDDatamodule.GetDataBaseComment(cDefaultDB) then
    Result:=true
  else
    Result:=false;
end;

function TMainForm.IsEditReserveDBCommentChanged(EditDBComment: TEdit): boolean;
begin
  if DataSourceDBList.DataSet.RecordCount>0 then
  begin
    if (EditDBComment.Text<>TLDDatamodule.GetDataBaseComment(DataSourceDBList.DataSet.FieldByName(cDBName).AsString)) then
      Result:=true
    else
      Result:=false;
  end
  else
    Result:=false;
end;

function TMainForm.IsEditIDKChanged(EditPersNumberFIO, EditPersNumber, EditOrg, EditDep: TEdit): boolean;
begin
  if Assigned(Dosimeter) then
  begin
    if (EditPersNumberFIO.Text<>Dosimeter.Fio) OR
       (EditPersNumber.Text<>IntToStr(Dosimeter.PersNumber)) AND (Dosimeter.PersNumber>=0) OR
       (EditOrg.Text<>Dosimeter.Organization) OR
       (EditDep.Text<>Dosimeter.Department) then
      Result:=true
    else
      Result:=false;
  end
  else
    Result:=false;
end;

function TMainForm.IsHideD1: boolean;
begin
  Result:=FHideD1;
end;

function TMainForm.IsHideD2: boolean;
begin
  Result:=FHideD2;
end;

function TMainForm.IsHideD3: boolean;
begin
  Result:=FHideD3;
end;

function TMainForm.IsHideD4: boolean;
begin
  Result:=FHideD4;
end;

function TMainForm.IsHidePanels: boolean;
begin
  Result:=not PanelMeasDataDos.Visible;
end;

function TMainForm.IsIdenticalSelectedDosTypes: boolean;
var
  i           : integer;
  dosTypeID   : integer;
  savedTypeID : integer;
  flag        : boolean;
begin
  flag:=false;
  dosTypeID:=0;
  savedTypeID:=0;

  if DBGridEhDos.SelectedRows.Count > 0 then
  begin
    DBGridEhDos.DataSource.DataSet.GotoBookmark(DBGridEhDos.SelectedRows.Items[0]);

    savedTypeID:=DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosTypeID).AsInteger;

    for i := 0 to DBGridEhDos.SelectedRows.Count-1 do
    begin

      DBGridEhDos.DataSource.DataSet.GotoBookmark(DBGridEhDos.SelectedRows.Items[i]);
      dosTypeID:=DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosTypeID).AsInteger;

      if (dosTypeID = savedTypeID) then
      begin
        flag:=true;
      end
      else
      begin
        flag:=false;
        break;
      end;

      savedTypeID:=dosTypeID;

    end;
  end;

  Result:=flag;
end;

function TMainForm.IsLastMeasInDosimeter: boolean;
begin
  if Assigned(Dosimeter) then
  begin
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDosMeasID+' FROM '+cDBTableDosRes
                                                            +' WHERE '+cFieldDosID+' = '+IntToStr(Dosimeter.ID)+' AND '
                                                                      +cFieldDosPostfix+'='+#39+Dosimeter.Postfix+#39+' AND '
                                                                      +cFieldDosMeasID+' > '+IntToStr(Dosimeter.MeasurementID));
    TLDDataModule.ADOQuery.Active:=True;

    if TLDDataModule.ADOQuery.RecordCount > 0 then
      Result:=false
    else
      Result:=true;
  end
  else
    Result:=false;
end;

function TMainForm.IsNotEmptyDet(dosType, detType: String): boolean;
var
  dType: integer;
begin

  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('select * from tlddosimetertype where '+cFieldDosType+'='+#39+dosType+#39);
  TLDDataModule.ADOQuery.Active:=True;

  dType:=TLDDataModule.ADOQuery.FieldByName(detType).AsInteger;

  if (dType<>0) then
    result:=true
  else
    result:=false;

end;

function TMainForm.IsStart: boolean;
begin
  //if FStart then
  //begin
  //  EnabledSpeedBtns(false,true,false);
  //end
  //else
  //begin
  //  EnabledSpeedBtns(true,true,true);
  //end;

  Result:=FStart;
end;

function TMainForm.IsUseFilterDatePicker(DateTimePicker: TDateTimePicker): boolean;
begin
// Добавить чекбокс
{
  if DateTimePicker.Format=' ' then
  begin
    Result:=False;
  end
  else
  begin
    Result:=True;
  end;
}
  Result:=false;
end;

function TMainForm.IsUseFilterCB(ComboBox: TComboBox): boolean;
begin
  if (ComboBox.ItemIndex >= 0) OR (ComboBox.Text <> '') then
    Result:=True
  else
    Result:=False;
end;

function TMainForm.IsUseFilterEdit(Edit: TEdit): boolean;
begin
  if (Edit.Text <> '') then
  begin
    Result:=True;
  end
  else
  begin
    Result:=False;
  end;
end;

function TMainForm.IsUseSQLScript: boolean;
begin
  if (SQLFilterForm.FilterCondition = '') AND (SQLFilterForm.FilterSort = 'ORDER BY measurmenttime DESC') then
  begin
    Result:=false;
  end
  else
  begin
    if SQLFilterForm.CheckScript then
      Result:=true
    else
      Result:=false;
  end;
end;

function TMainForm.IsValidCalibrationList: boolean;
var
  i           : integer;
  measid      : String;
  cntErr      : integer;
  function CheckNanGrid(Field: String; Grid: TDBGridEh): double;
  begin
    if Grid.DataSource.DataSet.FieldByName(Field).AsVariant <> Null then
      Result:=Grid.DataSource.DataSet.FieldByName(Field).AsFloat
    else
      Result:=NAN;
  end;
begin

  cntErr:=0;

  DBGridEhCalcKDos.DataSource.DataSet.First;

  for i := 0 to DBGridEhCalcKDos.DataSource.DataSet.RecordCount-1 do
  begin
    measid:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;

    if not IsValidCalibrMeas(measid) then inc(cntErr);
    DBGridEhCalcKDos.DataSource.DataSet.Next;
  end;

  if cntErr > 0 then
    Result:=false
  else
    Result:=true;

  LabelCalibrMeasListErr.Visible := not Result;
end;

function TMainForm.IsValidCalibrMeas(MeasId: String): boolean;
var
  formulaID   : integer;
  hp_10g      : double;
  hp_10n      : double;
  hp_3        : double;
  hp_007      : double;
  h_star      : double;
  H_007_dir   : double;
  d           : double;
  function CheckNanGrid(Field: String; Grid: TDBGridEh): double;
  begin
    if Grid.DataSource.DataSet.FieldByName(Field).AsVariant <> Null then
      Result:=Grid.DataSource.DataSet.FieldByName(Field).AsFloat
    else
      Result:=NAN;
  end;
begin
  Result:=true;

  //DBGridEhCalcKDos.DataSource.DataSet.Locate(cFieldDosMeasID,MeasId,[]);
  formulaID:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldFormulaId_Dos).AsInteger;

  case cDetMeasValTxt_Index[formulaID] of
    c_none:
    begin

    end;
    cHp_10g_1d,
    cHp_10g_2d,
    cHp_10g_3d,
    cHp_10g_4d:
    begin
      hp_10g:=CheckNanGrid(cFieldHp10g,DBGridEhCalcKDos);
      if hp_10g <= 0 then Result:=false
    end;
    cHp_10g_2d_Hp_10n_2d,
    cHp_10g_2d_Hp_10n_1d,
    cHp_10g_1d_Hp_10n_2d,
    cHp_10g_1d_Hp_10n_1d:
    begin

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
      hp_007:=CheckNanGrid(cFieldHp007,DBGridEhCalcKDos);
      if hp_007 <= 0 then Result:=false
    end;
    cHp_3_1d,
    cHp_3_2d,
    cHp_3_3d,
    cHp_3_4d:
    begin
      hp_3:=CheckNanGrid(cFieldHp3,DBGridEhCalcKDos);
      if hp_3 <= 0 then Result:=false
    end;
    cHp_star_g_1d,
    cHp_star_g_2d,
    cHp_star_g_3d,
    cHp_star_g_4d:
    begin
      h_star:=CheckNanGrid(cFieldHstar,DBGridEhCalcKDos);
      if h_star <= 0 then Result:=false
    end;
    cH_007_dir_g_1d,
    cH_007_dir_g_2d,
    cH_007_dir_g_3d,
    cH_007_dir_g_4d:
    begin
      h_007_dir:=CheckNanGrid(cFieldH007,DBGridEhCalcKDos);
      if h_007_dir <= 0 then Result:=false
    end;
    cD_1d,
    cD_2d,
    cD_3d,
    cD_4d:
    begin
      d:=CheckNanGrid(cFieldD,DBGridEhCalcKDos);
      if d <= 0 then Result:=false
    end;

  end;
end;

function TMainForm.IsValidDBVersion: boolean;
const
  cNoneField = 12;
  cErrorExit = 1000;
var
  dbValidVersion      : boolean;
  dbUpdateNotRequired : boolean;
  temp                : word;
  backupDBName        : String;
  savedDBVersion      : integer;
  cnt                 : integer;
begin
  dbValidVersion:=false;
  dbUpdateNotRequired:=false;
  savedDBVersion:=0;
  cnt:=0;

  try
    FDBVersion:=TLDDataModule.GetDBVersion;

    if (FDBVersion < cDBVersion) then  // если версия БД ниже версии ПО, зпускам обновление
    begin
      WriteLog(Format('%s - %d. %s - %d.',[rsDBCurrentVersion,FDBVersion,rsDBUpgradeNeeded,cDBVersion]));

      temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s - %d. %s - %d. %s',[rsDBCurrentVersion,FDBVersion,rsDBUpgradeNeeded,cDBVersion,rsMsgNeedToUpdateDBOrClose]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

      case temp of
        mrYes:                         // если нажали ок
        begin
          // создаем backup текущей базы перед обновлением
          if BackUpForm.BackupDB(TLDDataModule.DBName) then
          begin
            Splash.ProgressBar.Maximum:=cDBVersion;
            Splash.ProgressBar.Minimum:=TLDDataModule.GetDBVersion;
            Splash.ProgressBar.Position:=Splash.ProgressBar.Minimum;

            while not dbUpdateNotRequired do
            begin
              inc(cnt);
              FDBVersion:=TLDDataModule.GetDBVersion;
              Splash.ProgressBar.Position:=Splash.ProgressBar.Position+1;
              if FDBVersion <> savedDBVersion then
              begin
                if (FDBVersion >= 0) AND (FDBVersion < cDBVersion) then
                begin
                  Splash.Show(false);
                  Splash.SetCaption(Format('%s-%s%d%s',[rsDBUpdate,cSQLScriptName,FDBVersion+1,cExtSQL]));
                  if not TLDDataModule.LoadSQL(FDBVersion+1) then
                  begin
                    dbUpdateNotRequired:=true;
                    Splash.Close;
                  end
                end
                else
                if FDBVersion < 0 then          // -1 - нет поля с версией БД, грузим файл 12 с добавлением поля версии БД
                begin
                  if TLDDataModule.LoadSQL(cNoneField) then
                  begin
                    if TLDDataModule.GetDBVersion < 0 then dbUpdateNotRequired:=true; // если загрузить файл не удалось - выходим
                  end
                  else
                    dbUpdateNotRequired:=true;  // если файл не найден - выходим
                end
                else
                begin
                  dbUpdateNotRequired:=true;    // если версии совпадают, выходим из цикла
                  dbValidVersion:=true;
                  WriteLog(Format('%s.',[rsDBUpgradeSuccess]));
                  MessageDlg(Format('%s.',[rsDBUpgradeSuccess]),mtInformation,[mbOK],0);
                end;

                if cnt > cErrorExit then
                begin
                  dbUpdateNotRequired:=true;  // зацикливание - выходим
                  WriteLog(Format('%s. %s. %s%d',[rsDBUpgradeError,rsCircling,rsCheckUpgrade,FDBVersion+1]));
                end;
              end
              else
              begin
                dbUpdateNotRequired:=true;
                WriteLog(Format('%s. %s. %s%d',[rsDBUpgradeError,rsDBVersionNotChanged,rsCheckUpgrade,FDBVersion+1]));
              end;

              savedDBVersion:=FDBVersion;

            end;
          end
          else  // если создать backup не удалось - выходим
          begin
            WriteLog(Format('%s. %s.',[rsDBCreateReservFailure,rsProgramWillClosed]));
            MessageDlg(Format('%s. %s.',[rsDBCreateReservFailure,rsProgramWillClosed]),mtError,[mbOK],0);
            Result:=false;
            exit;
          end;
        end;
      end;
    end
    else
    if FDBVersion > cDBVersion then    // если версия ПО ниже версии БД, выходим из ПО
    begin
      WriteLog(Format('%s - %d. %s. %s.',[rsDBVersion,FDBVersion,rsDBVersionTooMatch,rsNeedUpdateSsoft,rsProgramWillClosed]));
      MessageDlg(Format('%s - %d. %s. %s.',[rsDBVersion,FDBVersion,rsDBVersionTooMatch,rsNeedUpdateSsoft,rsProgramWillClosed]),mtError,[mbOK],0);
      Result:=false;
      exit;
    end
    else
    begin                              // если версии совпадают
      dbUpdateNotRequired:=true;
      dbValidVersion:=true;
    end;

    if (dbValidVersion AND dbUpdateNotRequired) then
    begin
      Result:=true;
    end
    else
    begin
      Result:=false;
      WriteLog(Format('%s. %s.',[rsDBUpgradeError,rsProgramWillClosed]));
      MessageDlg(Format('%s. %s. %s - %s',[rsDBUpgradeError,rsProgramWillClosed,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError,[mbOK],0);
    end;

  except
    WriteLog(Format('%s. %s.',[rsDBUpgradeError,rsProgramWillClosed]));
    MessageDlg(Format('%s. %s. %s - %s',[rsDBUpgradeError,rsProgramWillClosed,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError,[mbOK],0);
    Result:=false;
    Splash.Close;
  end;

end;

procedure TMainForm.JvDateTimePickerMeasChange(Sender: TObject);
begin
  UpdateAllGridPages;
  ShapeCenter.Visible:=(JvDateTimePickerMeas.Date = Date);
end;

procedure TMainForm.JvSpeedBtnMeasDosStatusClick(Sender: TObject);
begin
  UserWarningComment:=true;
  SetUserWarning(true);
end;

procedure TMainForm.JvSpeedBtnProcessDosStatusClick(Sender: TObject);
begin
  UserWarningComment:=true;
  SetUserWarning(true);
end;

procedure TMainForm.MenuInfAboutClick(Sender: TObject);
begin
  VW.ShowModal;
end;

procedure TMainForm.MenuMeasDBClick(Sender: TObject);
begin
  OpenDB.Show;
end;

procedure TMainForm.DeleteDiscommissionDosimeters;
var
  temp        : word;
  delDosList  : TStringList;
  strDos      : String;
begin
  delDosList:=TStringList.Create;
  delDosList:=TLDDataModule.GetDiscommisionedDosimetersNumbers;

  if delDosList.Count>0 then
  begin

    temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s (%d%s)?',[rsDeleteDosimetersGroup,delDosList.Count,rsNums]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

    case temp of
      mrYes:
      begin
        if not TLDDataModule.DeleteDiscommisionedDosimeters then
          MessageDlg(Format('%s %s. %s - %s',[rsDeleteDosimetersFailure,strDos,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError,[mbOK],0)
        else
          MessageDlg(Format('%s',[rsDeleteDosimetersSuccess]),mtInformation,[mbOK],0);
      end;
    end;

  end
  else
    MessageDlg(Format('%s',[rsNoDosimetersForDel]),mtInformation,[mbOK],0);

  delDosList.Clear;
end;

procedure TMainForm.DeleteMarkedToDelMeas;
var
  temp         : word;
  delMeasList  : TStringList;
  strMeas      : String;
begin
  delMeasList:=TStringList.Create;
  delMeasList:=TLDDataModule.GetMarkedToDelMeas;

  if delMeasList.Count>0 then
  begin

    temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s (%d%s)?',[rsDeleteDosimeters,delMeasList.Count,rsNums]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

    case temp of
      mrYes:
      begin
        if not TLDDataModule.DeleteMarkedToDelMeasures then
          MessageDlg(Format('%s %s. %s - %s',[rsDeleteErrorsFailure,strMeas,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError,[mbOK],0)
        else
          MessageDlg(Format('%s',[rsDeleteMeasures]),mtInformation,[mbOK],0);
      end;
    end;

  end
  else
    MessageDlg(Format('%s',[rsDeletedMeasuresAbsent]),mtInformation,[mbOK],0);

  delMeasList.Clear;
end;

procedure TMainForm.MenuMeasDelDiscomDosClick(Sender: TObject);
begin
  DeleteDiscommissionDosimeters;
  if PageControlMain.ActivePage.PageIndex=cPageDosIndex then UpdateAllGridPages;//PageControlMainChange(Self);
end;

procedure TMainForm.MenuMeasDetTypeConstructorClick(Sender: TObject);
begin
  DetectorConstructorForm.DetTypeName:='';
  DetectorConstructorForm.ShowModal;
end;

procedure TMainForm.MenuMeasDosTypeConstructorClick(Sender: TObject);
begin
  DosimeterTypeConstructorForm.DosTypeName:='';
  DosimeterTypeConstructorForm.ShowModal;
end;

procedure TMainForm.MenuMeasDosConstructorClick(Sender: TObject);
begin
  DosimeterConstructorForm.ShowModal;
end;

procedure TMainForm.MenuMeasGeneneratorClick(Sender: TObject);
begin
  GeneratorForm.Show();
end;

procedure TMainForm.MenuMeasModelClick(Sender: TObject);
begin
  ModelW.Show;
end;

procedure TMainForm.MenuMeasQueueClick(Sender: TObject);
begin
  QueueForm.ShowModal;
end;

procedure TMainForm.MenuMeasReportClick(Sender: TObject);
begin
  RW.BuildReport;
end;

procedure TMainForm.MenuMeasStartClick(Sender: TObject);
begin
  if PageControlMain.ActivePage.PageIndex <> cPageMeasIndex then
    PageControlMain.ActivePageIndex:=cPageMeasIndex;

  StartMeas(cStartSingleMeas);
end;

procedure TMainForm.SetMaximaizeD1Chart(const Value: boolean);
begin
  case PageControlMain.ActivePageIndex of
    cPageMeasIndex:
    begin
      if not FMaximazeD1Chart then
      begin
        FMaximazeD1Chart:=True;

        ChartMeasHorBtnsD1.Visible:=True;
        TLDChartMeasDataD1.Legend.Visible:=True;
//        TLDChartMeasDataD1.Zoom.Allow:=True;
        SpeedBtnMeasSettingsD1.ImageIndex:=9;

        SpeedBtnMeasZoomVertPlusD1.Visible:=True;
        SpeedBtnMeasZoomVertMinusD1.Visible:=True;
        SpeedBtnMeasStepUpD1.Visible:=True;
        SpeedBtnMeasStepDownD1.Visible:=True;

        SpeedBtnMeasZoomVertPlusD1.Top:=SpeedBtnMeasCalcD1.Top+50;
        SpeedBtnMeasZoomVertMinusD1.Top:=SpeedBtnMeasZoomVertPlusD1.Top+SpeedBtnMeasZoomVertPlusD1.Height+6;
        SpeedBtnMeasStepUpD1.Top:=SpeedBtnMeasZoomVertMinusD1.Top+SpeedBtnMeasZoomVertMinusD1.Height+30;
        SpeedBtnMeasStepDownD1.Top:=SpeedBtnMeasStepUpD1.Top+SpeedBtnMeasStepUpD1.Height+6;

        SpeedBtnMeasZoomHorPlusD1.Left:=Round(TLDChartMeasDataD1.Width/5);
        SpeedBtnMeasZoomHorMinusD1.Left:=SpeedBtnMeasZoomHorPlusD1.Left+SpeedBtnMeasZoomHorPlusD1.Height+6;
        SpeedBtnMeasStepLeftD1.Left:=SpeedBtnMeasZoomHorMinusD1.Left+SpeedBtnMeasZoomHorMinusD1.Height+30;
        SpeedBtnMeasStepRightD1.Left:=SpeedBtnMeasStepLeftD1.Left+SpeedBtnMeasStepLeftD1.Height+6;

        PanelMeasDataD1Chart.Top:=0;
        PanelMeasDataD1Chart.Height:=PanelMeasDataDets.Height-2;
        PanelMeasDataD2Chart.Height:=0;
        PanelMeasDataD3Chart.Height:=0;
        PanelMeasDataD4Chart.Height:=0;

        PanelMeasDataD2.Color:=clSilver;
        PanelMeasDataD3.Color:=clSilver;
        PanelMeasDataD4.Color:=clSilver;

        PanelMeasDataD2.BevelOuter:=bvLowered;
        PanelMeasDataD3.BevelOuter:=bvLowered;
        PanelMeasDataD4.BevelOuter:=bvLowered;

        EditMeasDataD2Status.Enabled:=False;
        EditMeasDataD2Dose.Enabled:=False;

        EditMeasDataD3Status.Enabled:=False;
        EditMeasDataD3Dose.Enabled:=False;

        EditMeasDataD4Status.Enabled:=False;
        EditMeasDataD4Dose.Enabled:=False;
      end
      else
      begin
        FMaximazeD1Chart:=False;

        ChartMeasHorBtnsD1.Visible:=False;
        TLDChartMeasDataD1.Legend.Visible:=False;
        SpeedBtnMeasSettingsD1.ImageIndex:=8;

        SpeedBtnMeasZoomVertPlusD1.Visible:=False;
        SpeedBtnMeasZoomVertMinusD1.Visible:=False;
        SpeedBtnMeasStepUpD1.Visible:=False;
        SpeedBtnMeasStepDownD1.Visible:=False;

        DSeriaAutoSize(TLDChartMeasDataD1,SeriesMeasD1KTV);
//        TLDChartMeasDataD1.Zoom.Allow:=False;

        PanelMeasDataD2.Color:=clBtnFace;
        PanelMeasDataD3.Color:=clBtnFace;
        PanelMeasDataD4.Color:=clBtnFace;

        PanelMeasDataD2.BevelOuter:=bvRaised;
        PanelMeasDataD3.BevelOuter:=bvRaised;
        PanelMeasDataD4.BevelOuter:=bvRaised;

        EditMeasDataD2Status.Enabled:=True;
        EditMeasDataD2Dose.Enabled:=True;

        EditMeasDataD3Status.Enabled:=True;
        EditMeasDataD3Dose.Enabled:=True;

        EditMeasDataD4Status.Enabled:=True;
        EditMeasDataD4Dose.Enabled:=True;

        PanelDataResize(Self);
      end;
    end;
    cPageProcessIndex:
    begin
      if not FMaximazeD1Chart then
      begin
        FMaximazeD1Chart:=True;

        ChartProcessHorBtnsD1.Visible:=True;
        TLDChartProcessDataD1.Legend.Visible:=True;
//        TLDChartProcessDataD1.Zoom.Allow:=True;
        SpeedBtnProcessSettingsD1.ImageIndex:=9;

        SpeedBtnProcessZoomVertPlusD1.Visible:=True;
        SpeedBtnProcessZoomVertMinusD1.Visible:=True;
        SpeedBtnProcessStepUpD1.Visible:=True;
        SpeedBtnProcessStepDownD1.Visible:=True;

        SpeedBtnProcessZoomVertPlusD1.Top:=SpeedBtnProcessCalcD1.Top+50;
        SpeedBtnProcessZoomVertMinusD1.Top:=SpeedBtnProcessZoomVertPlusD1.Top+SpeedBtnProcessZoomVertPlusD1.Height+6;
        SpeedBtnProcessStepUpD1.Top:=SpeedBtnProcessZoomVertMinusD1.Top+SpeedBtnProcessZoomVertMinusD1.Height+30;
        SpeedBtnProcessStepDownD1.Top:=SpeedBtnProcessStepUpD1.Top+SpeedBtnProcessStepUpD1.Height+6;

        SpeedBtnProcessZoomHorPlusD1.Left:=Round(TLDChartProcessDataD1.Width/5);
        SpeedBtnProcessZoomHorMinusD1.Left:=SpeedBtnProcessZoomHorPlusD1.Left+SpeedBtnProcessZoomHorPlusD1.Height+6;
        SpeedBtnProcessStepLeftD1.Left:=SpeedBtnProcessZoomHorMinusD1.Left+SpeedBtnProcessZoomHorMinusD1.Height+30;
        SpeedBtnProcessStepRightD1.Left:=SpeedBtnProcessStepLeftD1.Left+SpeedBtnProcessStepLeftD1.Height+6;

        PanelProcessDataD1Chart.Top:=0;
        PanelProcessDataD1Chart.Height:=PanelProcessDataDets.Height-2;
        PanelProcessDataD2Chart.Height:=0;
        PanelProcessDataD3Chart.Height:=0;
        PanelProcessDataD4Chart.Height:=0;

        PanelProcessDataD2.Color:=clSilver;
        PanelProcessDataD3.Color:=clSilver;
        PanelProcessDataD4.Color:=clSilver;

        PanelProcessDataD2.BevelOuter:=bvLowered;
        PanelProcessDataD3.BevelOuter:=bvLowered;
        PanelProcessDataD4.BevelOuter:=bvLowered;

        EditProcessDataD2Status.Enabled:=False;
        EditProcessDataD2Dose.Enabled:=False;

        EditProcessDataD3Status.Enabled:=False;
        EditProcessDataD3Dose.Enabled:=False;

        EditProcessDataD4Status.Enabled:=False;
        EditProcessDataD4Dose.Enabled:=False;
      end
      else
      begin
        FMaximazeD1Chart:=False;

        ChartProcessHorBtnsD1.Visible:=False;
        TLDChartProcessDataD1.Legend.Visible:=False;
        SpeedBtnProcessSettingsD1.ImageIndex:=8;

        SpeedBtnProcessZoomVertPlusD1.Visible:=False;
        SpeedBtnProcessZoomVertMinusD1.Visible:=False;
        SpeedBtnProcessStepUpD1.Visible:=False;
        SpeedBtnProcessStepDownD1.Visible:=False;

        DSeriaAutoSize(TLDChartProcessDataD1,SeriesProcessD1KTV);
//        TLDChartProcessDataD1.Zoom.Allow:=False;

        PanelProcessDataD2.Color:=clBtnFace;
        PanelProcessDataD3.Color:=clBtnFace;
        PanelProcessDataD4.Color:=clBtnFace;

        PanelProcessDataD2.BevelOuter:=bvRaised;
        PanelProcessDataD3.BevelOuter:=bvRaised;
        PanelProcessDataD4.BevelOuter:=bvRaised;

        EditProcessDataD2Status.Enabled:=True;
        EditProcessDataD2Dose.Enabled:=True;

        EditProcessDataD3Status.Enabled:=True;
        EditProcessDataD3Dose.Enabled:=True;

        EditProcessDataD4Status.Enabled:=True;
        EditProcessDataD4Dose.Enabled:=True;

        PanelDataResize(Self);
      end;
    end;
  end;

end;

procedure TMainForm.SetMaximaizeD2Chart(const Value: boolean);
begin
  case PageControlMain.ActivePageIndex of
    cPageMeasIndex:
    begin
      if not FMaximazeD2Chart then
      begin
        FMaximazeD2Chart:=True;

        ChartMeasHorBtnsD2.Visible:=True;
        TLDChartMeasDataD2.Legend.Visible:=True;
//        TLDChartMeasDataD2.Zoom.Allow:=True;
        SpeedBtnMeasSettingsD2.ImageIndex:=9;

        SpeedBtnMeasZoomVertPlusD2.Visible:=True;
        SpeedBtnMeasZoomVertMinusD2.Visible:=True;
        SpeedBtnMeasStepUpD2.Visible:=True;
        SpeedBtnMeasStepDownD2.Visible:=True;

        SpeedBtnMeasZoomVertPlusD2.Top:=SpeedBtnMeasCalcD2.Top+50;
        SpeedBtnMeasZoomVertMinusD2.Top:=SpeedBtnMeasZoomVertPlusD2.Top+SpeedBtnMeasZoomVertPlusD2.Height+6;
        SpeedBtnMeasStepUpD2.Top:=SpeedBtnMeasZoomVertMinusD2.Top+SpeedBtnMeasZoomVertMinusD2.Height+30;
        SpeedBtnMeasStepDownD2.Top:=SpeedBtnMeasStepUpD2.Top+SpeedBtnMeasStepUpD2.Height+6;

        SpeedBtnMeasZoomHorPlusD2.Left:=Round(TLDChartMeasDataD2.Width/5);
        SpeedBtnMeasZoomHorMinusD2.Left:=SpeedBtnMeasZoomHorPlusD2.Left+SpeedBtnMeasZoomHorPlusD2.Height+6;
        SpeedBtnMeasStepLeftD2.Left:=SpeedBtnMeasZoomHorMinusD2.Left+SpeedBtnMeasZoomHorMinusD2.Height+30;
        SpeedBtnMeasStepRightD2.Left:=SpeedBtnMeasStepLeftD2.Left+SpeedBtnMeasStepLeftD2.Height+6;

        PanelMeasDataD2Chart.Top:=0;
        PanelMeasDataD1Chart.Height:=0;
        PanelMeasDataD2Chart.Height:=PanelMeasDataDets.Height-2;
        PanelMeasDataD3Chart.Height:=0;
        PanelMeasDataD4Chart.Height:=0;

        PanelMeasDataD1.Color:=clSilver;
        PanelMeasDataD3.Color:=clSilver;
        PanelMeasDataD4.Color:=clSilver;

        PanelMeasDataD1.BevelOuter:=bvLowered;
        PanelMeasDataD3.BevelOuter:=bvLowered;
        PanelMeasDataD4.BevelOuter:=bvLowered;

        EditMeasDataD1Status.Enabled:=False;
        EditMeasDataD1Dose.Enabled:=False;

        EditMeasDataD3Status.Enabled:=False;
        EditMeasDataD3Dose.Enabled:=False;

        EditMeasDataD4Status.Enabled:=False;
        EditMeasDataD4Dose.Enabled:=False;
      end
      else
      begin
        FMaximazeD2Chart:=False;

        ChartMeasHorBtnsD2.Visible:=False;
        TLDChartMeasDataD2.Legend.Visible:=False;
        SpeedBtnMeasSettingsD2.ImageIndex:=8;

        SpeedBtnMeasZoomVertPlusD2.Visible:=False;
        SpeedBtnMeasZoomVertMinusD2.Visible:=False;
        SpeedBtnMeasStepUpD2.Visible:=False;
        SpeedBtnMeasStepDownD2.Visible:=False;

        DSeriaAutoSize(TLDChartMeasDataD2,SeriesMeasD2KTV);
//        TLDChartMeasDataD2.Zoom.Allow:=False;

        PanelMeasDataD1.Color:=clBtnFace;
        PanelMeasDataD3.Color:=clBtnFace;
        PanelMeasDataD4.Color:=clBtnFace;

        PanelMeasDataD1.BevelOuter:=bvRaised;
        PanelMeasDataD3.BevelOuter:=bvRaised;
        PanelMeasDataD4.BevelOuter:=bvRaised;

        EditMeasDataD1Status.Enabled:=True;
        EditMeasDataD1Dose.Enabled:=True;

        EditMeasDataD3Status.Enabled:=True;
        EditMeasDataD3Dose.Enabled:=True;

        EditMeasDataD4Status.Enabled:=True;
        EditMeasDataD4Dose.Enabled:=True;

        PanelDataResize(Self);
      end;
    end;
    cPageProcessIndex:
    begin
      if not FMaximazeD2Chart then
      begin
        FMaximazeD2Chart:=True;

        ChartProcessHorBtnsD2.Visible:=True;
        TLDChartProcessDataD2.Legend.Visible:=True;
//        TLDChartProcessDataD2.Zoom.Allow:=True;
        SpeedBtnProcessSettingsD2.ImageIndex:=9;

        SpeedBtnProcessZoomVertPlusD2.Visible:=True;
        SpeedBtnProcessZoomVertMinusD2.Visible:=True;
        SpeedBtnProcessStepUpD2.Visible:=True;
        SpeedBtnProcessStepDownD2.Visible:=True;

        SpeedBtnProcessZoomVertPlusD2.Top:=SpeedBtnProcessCalcD2.Top+50;
        SpeedBtnProcessZoomVertMinusD2.Top:=SpeedBtnProcessZoomVertPlusD2.Top+SpeedBtnProcessZoomVertPlusD2.Height+6;
        SpeedBtnProcessStepUpD2.Top:=SpeedBtnProcessZoomVertMinusD2.Top+SpeedBtnProcessZoomVertMinusD2.Height+30;
        SpeedBtnProcessStepDownD2.Top:=SpeedBtnProcessStepUpD2.Top+SpeedBtnProcessStepUpD2.Height+6;

        SpeedBtnProcessZoomHorPlusD2.Left:=Round(TLDChartProcessDataD2.Width/5);
        SpeedBtnProcessZoomHorMinusD2.Left:=SpeedBtnProcessZoomHorPlusD2.Left+SpeedBtnProcessZoomHorPlusD2.Height+6;
        SpeedBtnProcessStepLeftD2.Left:=SpeedBtnProcessZoomHorMinusD2.Left+SpeedBtnProcessZoomHorMinusD2.Height+30;
        SpeedBtnProcessStepRightD2.Left:=SpeedBtnProcessStepLeftD2.Left+SpeedBtnProcessStepLeftD2.Height+6;

        PanelProcessDataD2Chart.Top:=0;
        PanelProcessDataD1Chart.Height:=0;
        PanelProcessDataD2Chart.Height:=PanelProcessDataDets.Height-2;
        PanelProcessDataD3Chart.Height:=0;
        PanelProcessDataD4Chart.Height:=0;

        PanelProcessDataD1.Color:=clSilver;
        PanelProcessDataD3.Color:=clSilver;
        PanelProcessDataD4.Color:=clSilver;

        PanelProcessDataD1.BevelOuter:=bvLowered;
        PanelProcessDataD3.BevelOuter:=bvLowered;
        PanelProcessDataD4.BevelOuter:=bvLowered;

        EditProcessDataD1Status.Enabled:=False;
        EditProcessDataD1Dose.Enabled:=False;

        EditProcessDataD3Status.Enabled:=False;
        EditProcessDataD3Dose.Enabled:=False;

        EditProcessDataD4Status.Enabled:=False;
        EditProcessDataD4Dose.Enabled:=False;
      end
      else
      begin
        FMaximazeD2Chart:=False;

        ChartProcessHorBtnsD2.Visible:=False;
        TLDChartProcessDataD2.Legend.Visible:=False;
        SpeedBtnProcessSettingsD2.ImageIndex:=8;

        SpeedBtnProcessZoomVertPlusD2.Visible:=False;
        SpeedBtnProcessZoomVertMinusD2.Visible:=False;
        SpeedBtnProcessStepUpD2.Visible:=False;
        SpeedBtnProcessStepDownD2.Visible:=False;

        DSeriaAutoSize(TLDChartProcessDataD2,SeriesProcessD2KTV);
//        TLDChartProcessDataD2.Zoom.Allow:=False;

        PanelProcessDataD1.Color:=clBtnFace;
        PanelProcessDataD3.Color:=clBtnFace;
        PanelProcessDataD4.Color:=clBtnFace;

        PanelProcessDataD1.BevelOuter:=bvRaised;
        PanelProcessDataD3.BevelOuter:=bvRaised;
        PanelProcessDataD4.BevelOuter:=bvRaised;

        EditProcessDataD1Status.Enabled:=True;
        EditProcessDataD1Dose.Enabled:=True;

        EditProcessDataD3Status.Enabled:=True;
        EditProcessDataD3Dose.Enabled:=True;

        EditProcessDataD4Status.Enabled:=True;
        EditProcessDataD4Dose.Enabled:=True;

        PanelDataResize(Self);
      end;
    end;
  end;
end;

procedure TMainForm.SetMaximaizeD3Chart(const Value: boolean);
begin
  case PageControlMain.ActivePageIndex of
    cPageMeasIndex:
    begin
      if not FMaximazeD3Chart then
      begin
        FMaximazeD3Chart:=True;

        ChartMeasHorBtnsD3.Visible:=True;
        TLDChartMeasDataD3.Legend.Visible:=True;
//        TLDChartMeasDataD3.Zoom.Allow:=True;
        SpeedBtnMeasSettingsD3.ImageIndex:=9;

        SpeedBtnMeasZoomVertPlusD3.Visible:=True;
        SpeedBtnMeasZoomVertMinusD3.Visible:=True;
        SpeedBtnMeasStepUpD3.Visible:=True;
        SpeedBtnMeasStepDownD3.Visible:=True;

        SpeedBtnMeasZoomVertPlusD3.Top:=SpeedBtnMeasCalcD3.Top+50;
        SpeedBtnMeasZoomVertMinusD3.Top:=SpeedBtnMeasZoomVertPlusD3.Top+SpeedBtnMeasZoomVertPlusD3.Height+6;
        SpeedBtnMeasStepUpD3.Top:=SpeedBtnMeasZoomVertMinusD3.Top+SpeedBtnMeasZoomVertMinusD3.Height+30;
        SpeedBtnMeasStepDownD3.Top:=SpeedBtnMeasStepUpD3.Top+SpeedBtnMeasStepUpD3.Height+6;

        SpeedBtnMeasZoomHorPlusD3.Left:=Round(TLDChartMeasDataD3.Width/5);
        SpeedBtnMeasZoomHorMinusD3.Left:=SpeedBtnMeasZoomHorPlusD3.Left+SpeedBtnMeasZoomHorPlusD3.Height+6;
        SpeedBtnMeasStepLeftD3.Left:=SpeedBtnMeasZoomHorMinusD3.Left+SpeedBtnMeasZoomHorMinusD3.Height+30;
        SpeedBtnMeasStepRightD3.Left:=SpeedBtnMeasStepLeftD3.Left+SpeedBtnMeasStepLeftD3.Height+6;

        PanelMeasDataD3Chart.Top:=0;
        PanelMeasDataD1Chart.Height:=0;
        PanelMeasDataD2Chart.Height:=0;
        PanelMeasDataD3Chart.Height:=PanelMeasDataDets.Height-2;
        PanelMeasDataD4Chart.Height:=0;

        PanelMeasDataD1.Color:=clSilver;
        PanelMeasDataD2.Color:=clSilver;
        PanelMeasDataD4.Color:=clSilver;

        PanelMeasDataD1.BevelOuter:=bvLowered;
        PanelMeasDataD2.BevelOuter:=bvLowered;
        PanelMeasDataD4.BevelOuter:=bvLowered;

        EditMeasDataD1Status.Enabled:=False;
        EditMeasDataD1Dose.Enabled:=False;

        EditMeasDataD2Status.Enabled:=False;
        EditMeasDataD2Dose.Enabled:=False;

        EditMeasDataD4Status.Enabled:=False;
        EditMeasDataD4Dose.Enabled:=False;
      end
      else
      begin
        FMaximazeD3Chart:=False;

        ChartMeasHorBtnsD3.Visible:=False;
        TLDChartMeasDataD3.Legend.Visible:=False;
        SpeedBtnMeasSettingsD3.ImageIndex:=8;

        SpeedBtnMeasZoomVertPlusD3.Visible:=False;
        SpeedBtnMeasZoomVertMinusD3.Visible:=False;
        SpeedBtnMeasStepUpD3.Visible:=False;
        SpeedBtnMeasStepDownD3.Visible:=False;

        DSeriaAutoSize(TLDChartMeasDataD3,SeriesMeasD3KTV);
//        TLDChartMeasDataD3.Zoom.Allow:=False;

        PanelMeasDataD1.Color:=clBtnFace;
        PanelMeasDataD2.Color:=clBtnFace;
        PanelMeasDataD4.Color:=clBtnFace;

        PanelMeasDataD1.BevelOuter:=bvRaised;
        PanelMeasDataD2.BevelOuter:=bvRaised;
        PanelMeasDataD4.BevelOuter:=bvRaised;

        EditMeasDataD1Status.Enabled:=True;
        EditMeasDataD1Dose.Enabled:=True;

        EditMeasDataD2Status.Enabled:=True;
        EditMeasDataD2Dose.Enabled:=True;

        EditMeasDataD4Status.Enabled:=True;
        EditMeasDataD4Dose.Enabled:=True;

        PanelDataResize(Self);
      end;
    end;
    cPageProcessIndex:
    begin
      if not FMaximazeD3Chart then
      begin
        FMaximazeD3Chart:=True;

        ChartProcessHorBtnsD3.Visible:=True;
        TLDChartProcessDataD3.Legend.Visible:=True;
//        TLDChartProcessDataD3.Zoom.Allow:=True;
        SpeedBtnProcessSettingsD3.ImageIndex:=9;

        SpeedBtnProcessZoomVertPlusD3.Visible:=True;
        SpeedBtnProcessZoomVertMinusD3.Visible:=True;
        SpeedBtnProcessStepUpD3.Visible:=True;
        SpeedBtnProcessStepDownD3.Visible:=True;

        SpeedBtnProcessZoomVertPlusD3.Top:=SpeedBtnProcessCalcD3.Top+50;
        SpeedBtnProcessZoomVertMinusD3.Top:=SpeedBtnProcessZoomVertPlusD3.Top+SpeedBtnProcessZoomVertPlusD3.Height+6;
        SpeedBtnProcessStepUpD3.Top:=SpeedBtnProcessZoomVertMinusD3.Top+SpeedBtnProcessZoomVertMinusD3.Height+30;
        SpeedBtnProcessStepDownD3.Top:=SpeedBtnProcessStepUpD3.Top+SpeedBtnProcessStepUpD3.Height+6;

        SpeedBtnProcessZoomHorPlusD3.Left:=Round(TLDChartProcessDataD3.Width/5);
        SpeedBtnProcessZoomHorMinusD3.Left:=SpeedBtnProcessZoomHorPlusD3.Left+SpeedBtnProcessZoomHorPlusD3.Height+6;
        SpeedBtnProcessStepLeftD3.Left:=SpeedBtnProcessZoomHorMinusD3.Left+SpeedBtnProcessZoomHorMinusD3.Height+30;
        SpeedBtnProcessStepRightD3.Left:=SpeedBtnProcessStepLeftD3.Left+SpeedBtnProcessStepLeftD3.Height+6;

        PanelProcessDataD3Chart.Top:=0;
        PanelProcessDataD1Chart.Height:=0;
        PanelProcessDataD2Chart.Height:=0;
        PanelProcessDataD3Chart.Height:=PanelProcessDataDets.Height-2;
        PanelProcessDataD4Chart.Height:=0;

        PanelProcessDataD1.Color:=clSilver;
        PanelProcessDataD2.Color:=clSilver;
        PanelProcessDataD4.Color:=clSilver;

        PanelProcessDataD1.BevelOuter:=bvLowered;
        PanelProcessDataD2.BevelOuter:=bvLowered;
        PanelProcessDataD4.BevelOuter:=bvLowered;

        EditProcessDataD1Status.Enabled:=False;
        EditProcessDataD1Dose.Enabled:=False;

        EditProcessDataD2Status.Enabled:=False;
        EditProcessDataD2Dose.Enabled:=False;

        EditProcessDataD4Status.Enabled:=False;
        EditProcessDataD4Dose.Enabled:=False;
      end
      else
      begin
        FMaximazeD3Chart:=False;

        ChartProcessHorBtnsD3.Visible:=False;
        TLDChartProcessDataD3.Legend.Visible:=False;
        SpeedBtnProcessSettingsD3.ImageIndex:=8;

        SpeedBtnProcessZoomVertPlusD3.Visible:=False;
        SpeedBtnProcessZoomVertMinusD3.Visible:=False;
        SpeedBtnProcessStepUpD3.Visible:=False;
        SpeedBtnProcessStepDownD3.Visible:=False;

        DSeriaAutoSize(TLDChartProcessDataD3,SeriesProcessD3KTV);
//        TLDChartProcessDataD3.Zoom.Allow:=False;

        PanelProcessDataD1.Color:=clBtnFace;
        PanelProcessDataD2.Color:=clBtnFace;
        PanelProcessDataD4.Color:=clBtnFace;

        PanelProcessDataD1.BevelOuter:=bvRaised;
        PanelProcessDataD2.BevelOuter:=bvRaised;
        PanelProcessDataD4.BevelOuter:=bvRaised;

        EditProcessDataD1Status.Enabled:=True;
        EditProcessDataD1Dose.Enabled:=True;

        EditProcessDataD2Status.Enabled:=True;
        EditProcessDataD2Dose.Enabled:=True;

        EditProcessDataD4Status.Enabled:=True;
        EditProcessDataD4Dose.Enabled:=True;

        PanelDataResize(Self);
      end;
    end;
  end;
end;

procedure TMainForm.SetMaximaizeD4Chart(const Value: boolean);
begin
  case PageControlMain.ActivePageIndex of
    cPageMeasIndex:
    begin
      if not FMaximazeD4Chart then
      begin
        FMaximazeD4Chart:=True;

        ChartMeasHorBtnsD4.Visible:=True;
        TLDChartMeasDataD4.Legend.Visible:=True;
//        TLDChartMeasDataD4.Zoom.Allow:=True;
        SpeedBtnMeasSettingsD4.ImageIndex:=9;

        SpeedBtnMeasZoomVertPlusD4.Visible:=True;
        SpeedBtnMeasZoomVertMinusD4.Visible:=True;
        SpeedBtnMeasStepUpD4.Visible:=True;
        SpeedBtnMeasStepDownD4.Visible:=True;

        SpeedBtnMeasZoomVertPlusD4.Top:=SpeedBtnMeasCalcD4.Top+50;
        SpeedBtnMeasZoomVertMinusD4.Top:=SpeedBtnMeasZoomVertPlusD4.Top+SpeedBtnMeasZoomVertPlusD4.Height+6;
        SpeedBtnMeasStepUpD4.Top:=SpeedBtnMeasZoomVertMinusD4.Top+SpeedBtnMeasZoomVertMinusD4.Height+30;
        SpeedBtnMeasStepDownD4.Top:=SpeedBtnMeasStepUpD4.Top+SpeedBtnMeasStepUpD4.Height+6;

        SpeedBtnMeasZoomHorPlusD4.Left:=Round(TLDChartMeasDataD4.Width/5);
        SpeedBtnMeasZoomHorMinusD4.Left:=SpeedBtnMeasZoomHorPlusD4.Left+SpeedBtnMeasZoomHorPlusD4.Height+6;
        SpeedBtnMeasStepLeftD4.Left:=SpeedBtnMeasZoomHorMinusD4.Left+SpeedBtnMeasZoomHorMinusD4.Height+30;
        SpeedBtnMeasStepRightD4.Left:=SpeedBtnMeasStepLeftD4.Left+SpeedBtnMeasStepLeftD4.Height+6;

        PanelMeasDataD4Chart.Top:=0;
        PanelMeasDataD1Chart.Height:=0;
        PanelMeasDataD2Chart.Height:=0;
        PanelMeasDataD3Chart.Height:=0;
        PanelMeasDataD4Chart.Height:=PanelMeasDataDets.Height-2;

        PanelMeasDataD1.Color:=clSilver;
        PanelMeasDataD2.Color:=clSilver;
        PanelMeasDataD3.Color:=clSilver;

        PanelMeasDataD1.BevelOuter:=bvLowered;
        PanelMeasDataD2.BevelOuter:=bvLowered;
        PanelMeasDataD3.BevelOuter:=bvLowered;

        EditMeasDataD1Status.Enabled:=False;
        EditMeasDataD1Dose.Enabled:=False;

        EditMeasDataD2Status.Enabled:=False;
        EditMeasDataD2Dose.Enabled:=False;

        EditMeasDataD3Status.Enabled:=False;
        EditMeasDataD3Dose.Enabled:=False;
      end
      else
      begin
        FMaximazeD4Chart:=False;

        ChartMeasHorBtnsD4.Visible:=False;
        TLDChartMeasDataD4.Legend.Visible:=False;
        SpeedBtnMeasSettingsD4.ImageIndex:=8;

        SpeedBtnMeasZoomVertPlusD4.Visible:=False;
        SpeedBtnMeasZoomVertMinusD4.Visible:=False;
        SpeedBtnMeasStepUpD4.Visible:=False;
        SpeedBtnMeasStepDownD4.Visible:=False;

        DSeriaAutoSize(TLDChartMeasDataD4,SeriesMeasD4KTV);
//        TLDChartMeasDataD4.Zoom.Allow:=False;

        PanelMeasDataD1.Color:=clBtnFace;
        PanelMeasDataD2.Color:=clBtnFace;
        PanelMeasDataD3.Color:=clBtnFace;

        PanelMeasDataD1.BevelOuter:=bvRaised;
        PanelMeasDataD2.BevelOuter:=bvRaised;
        PanelMeasDataD3.BevelOuter:=bvRaised;

        EditMeasDataD1Status.Enabled:=True;
        EditMeasDataD1Dose.Enabled:=True;

        EditMeasDataD2Status.Enabled:=True;
        EditMeasDataD2Dose.Enabled:=True;

        EditMeasDataD3Status.Enabled:=True;
        EditMeasDataD3Dose.Enabled:=True;

        PanelDataResize(Self);
      end;
    end;
    cPageProcessIndex:
    begin
      if not FMaximazeD4Chart then
      begin
        FMaximazeD4Chart:=True;

        ChartProcessHorBtnsD4.Visible:=True;
        TLDChartProcessDataD4.Legend.Visible:=True;
//        TLDChartProcessDataD4.Zoom.Allow:=True;
        SpeedBtnProcessSettingsD4.ImageIndex:=9;

        SpeedBtnProcessZoomVertPlusD4.Visible:=True;
        SpeedBtnProcessZoomVertMinusD4.Visible:=True;
        SpeedBtnProcessStepUpD4.Visible:=True;
        SpeedBtnProcessStepDownD4.Visible:=True;

        SpeedBtnProcessZoomVertPlusD4.Top:=SpeedBtnProcessCalcD4.Top+50;
        SpeedBtnProcessZoomVertMinusD4.Top:=SpeedBtnProcessZoomVertPlusD4.Top+SpeedBtnProcessZoomVertPlusD4.Height+6;
        SpeedBtnProcessStepUpD4.Top:=SpeedBtnProcessZoomVertMinusD4.Top+SpeedBtnProcessZoomVertMinusD4.Height+30;
        SpeedBtnProcessStepDownD4.Top:=SpeedBtnProcessStepUpD4.Top+SpeedBtnProcessStepUpD4.Height+6;

        SpeedBtnProcessZoomHorPlusD4.Left:=Round(TLDChartProcessDataD4.Width/5);
        SpeedBtnProcessZoomHorMinusD4.Left:=SpeedBtnProcessZoomHorPlusD4.Left+SpeedBtnProcessZoomHorPlusD4.Height+6;
        SpeedBtnProcessStepLeftD4.Left:=SpeedBtnProcessZoomHorMinusD4.Left+SpeedBtnProcessZoomHorMinusD4.Height+30;
        SpeedBtnProcessStepRightD4.Left:=SpeedBtnProcessStepLeftD4.Left+SpeedBtnProcessStepLeftD4.Height+6;

        PanelProcessDataD4Chart.Top:=0;
        PanelProcessDataD1Chart.Height:=0;
        PanelProcessDataD2Chart.Height:=0;
        PanelProcessDataD3Chart.Height:=0;
        PanelProcessDataD4Chart.Height:=PanelProcessDataDets.Height-2;

        PanelProcessDataD1.Color:=clSilver;
        PanelProcessDataD2.Color:=clSilver;
        PanelProcessDataD3.Color:=clSilver;

        PanelProcessDataD1.BevelOuter:=bvLowered;
        PanelProcessDataD2.BevelOuter:=bvLowered;
        PanelProcessDataD3.BevelOuter:=bvLowered;

        EditProcessDataD1Status.Enabled:=False;
        EditProcessDataD1Dose.Enabled:=False;

        EditProcessDataD2Status.Enabled:=False;
        EditProcessDataD2Dose.Enabled:=False;

        EditProcessDataD3Status.Enabled:=False;
        EditProcessDataD3Dose.Enabled:=False;
      end
      else
      begin
        FMaximazeD4Chart:=False;

        ChartProcessHorBtnsD4.Visible:=False;
        TLDChartProcessDataD4.Legend.Visible:=False;
        SpeedBtnProcessSettingsD4.ImageIndex:=8;

        SpeedBtnProcessZoomVertPlusD4.Visible:=False;
        SpeedBtnProcessZoomVertMinusD4.Visible:=False;
        SpeedBtnProcessStepUpD4.Visible:=False;
        SpeedBtnProcessStepDownD4.Visible:=False;

        DSeriaAutoSize(TLDChartProcessDataD4,SeriesProcessD4KTV);
//        TLDChartProcessDataD4.Zoom.Allow:=False;

        PanelProcessDataD1.Color:=clBtnFace;
        PanelProcessDataD2.Color:=clBtnFace;
        PanelProcessDataD3.Color:=clBtnFace;

        PanelProcessDataD1.BevelOuter:=bvRaised;
        PanelProcessDataD2.BevelOuter:=bvRaised;
        PanelProcessDataD3.BevelOuter:=bvRaised;

        EditProcessDataD1Status.Enabled:=True;
        EditProcessDataD1Dose.Enabled:=True;

        EditProcessDataD2Status.Enabled:=True;
        EditProcessDataD2Dose.Enabled:=True;

        EditProcessDataD3Status.Enabled:=True;
        EditProcessDataD3Dose.Enabled:=True;

        PanelDataResize(Self);
      end;
    end;
  end;
end;

procedure TMainForm.MemoCmdLogChange(Sender: TObject);
const
  cThousandString = 1000;
begin
//  if MemoCmdLog.Lines.Count > cThousandString then
//    MemoCmdLog.Lines.Clear;
end;

procedure TMainForm.MemoSettingsAutoCommentChange(Sender: TObject);
begin
  ControlComment:=MemoSettingsAutoComment.Text;
end;

procedure TMainForm.MenuSetChangeUserClick(Sender: TObject);
begin
  AW.ShowModal;  // смена пользователя
end;

procedure TMainForm.MenuSetComClick(Sender: TObject);
begin
  SetW.Show;
end;

procedure TMainForm.MenuSetControlClick(Sender: TObject);
begin
  ControlW.Show;
end;

procedure TMainForm.MenuSetEditUsersListClick(Sender: TObject);
begin
//  UMW.ShowModal;  // редактирование списка пользователей
end;

procedure TMainForm.ppMeasGridSendToCalibrationClick(Sender: TObject);
var
  temp: word;
begin
  if DBGridEhOnlyMeas.SelectedRows.Count > 0 then
    if CheckValidMeasToCalibr(DBGridEhOnlyMeas) then
      SendToCalibrW.ShowModal
    else
    begin
      temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s',[rsMsgFoundInvalidMeasToCalibr]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

      case temp of
        mrYes: SendToCalibrW.ShowModal;

      end;
    end
  else
    MessageDlg(rsNotChooseMeasure,mtWarning,[mbOK], 0);
end;

procedure TMainForm.MenuMeasDelMarkedToDelMeasClick(Sender: TObject);
begin
  DeleteMarkedToDelMeas;
  if (PageControlMain.ActivePage.PageIndex=cPageMeasIndex) OR (PageControlMain.ActivePage.PageIndex=cPageProcessIndex) then
    UpdateAllGridPages;
end;

procedure TMainForm.BtnCalcD1Click(Sender: TObject);
begin
  CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[0]));
  CalcForm.Show;
end;

procedure TMainForm.BtnCalcD2Click(Sender: TObject);
begin
  CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[1]));
  CalcForm.Show;
end;

procedure TMainForm.BtnCalcD3Click(Sender: TObject);
begin
  CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[2]));
  CalcForm.Show;
end;

procedure TMainForm.BtnCalcD4Click(Sender: TObject);
begin
  CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[3]));
  CalcForm.Show;
end;

procedure TMainForm.BtnCalibrAcceptClick(Sender: TObject);
begin
  AcceptKDos;
  DropCalibrationParameters;
end;

procedure TMainForm.BtnClearPortClick(Sender: TObject);
begin
  ReinitializeCOMPort;
  //*TLDCommand.OnReinitialize;
  //*SetW.ConnectionState;
  //FreeAndNil(TLDCommand.COMPort);
end;

procedure TMainForm.BtnDecommissionDosClick(Sender: TObject);
begin
  DecommissionDos;
end;

procedure TMainForm.BtnDecommissionDosGroupClick(Sender: TObject);
begin
  DecommissionDos;
end;

procedure TMainForm.BtnDeleteDBClick(Sender: TObject);
var
  i           : integer;
  btnSelected : integer;
  dbName      : String;
  deletedDB   : String;
  msgFlag     : boolean;
begin
  if DBGridEhDB.DataSource.DataSet.RecordCount > 0 then
  begin
    deletedDB:='';
    dbName:='';
    msgFlag:=false;

    if TLDDataModule.IsDBConnected then
    begin

      for i := 0 to DBGridEhDB.SelectedRows.Count-1 do
      begin
        DBGridEhDB.DataSource.DataSet.GotoBookmark(DBGridEhDB.SelectedRows.Items[i]);

        if (DBGridEhDB.SelectedRows.Count>1) AND (DBGridEhDB.SelectedRows.Count<10) then
        begin
          if dbName<>'' then
            dbName:=dbName+','+DBGridEhDB.DataSource.DataSet.FieldByName(cDBName).AsString
          else
            dbName:=DBGridEhDB.DataSource.DataSet.FieldByName(cDBName).AsString;
        end
        else if DBGridEhDB.SelectedRows.Count=1 then
          begin
            dbName:=DBGridEhDB.DataSource.DataSet.FieldByName(cDBName).AsString;
            break;
          end
        else
        begin
          dbName:=format('%d'+rsNums,[DBGridEhDB.SelectedRows.Count]);
          break;
        end
      end;

      btnSelected:=MessageDlg(format(rsDeleteDBAsk,[dbName]),mtWarning, mbOKCancel, 0);
      if BtnSelected = mrOK then
      begin
        for i := 0 to DBGridEhDB.SelectedRows.Count-1 do
        begin
          DBGridEhDB.DataSource.DataSet.GotoBookmark(DBGridEhDB.SelectedRows.Items[i]);
          dbName:=DBGridEhDB.DataSource.DataSet.FieldByName(cDBName).AsString;

          if dbName <> TLDDataModule.DBName then
          begin
            ProgressBarDBStart(ProgressBarDB,format(rsDeleteDB,[DBName]));

            if TLDDataModule.DeleteDataBase(dbName) then
            begin
              OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s - %s',[rsDeletedDB,dbName]),'',cMsgInf,cMsgPriorityInf);

              if deletedDB<>'' then
                deletedDB:=deletedDB+','+dbName
              else
                deletedDB:=dbName;

              msgFlag:=true;

              ProgressBarFinish(ProgressBarDB);
              ProgressBarHide(ProgressBarDB);
            end
            else
            begin
              ProgressBarErr(ProgressBarDB);
              OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s - %s',[rsDBDeleteFailure,dbName]),'',cMsgInf,cMsgPriorityInf);
              MessageDlg(Format('%s - %s',[rsDBDeleteFailure,dbName]),mtError, [mbOK], 0);
            end;
          end
          else
          begin
            MessageDlg(Format('%s - %s',[rsDBDeleteOpenDenied,dbName]),mtError,[mbOK],0);
          end;

        end;

        RefreshDBList;
        if msgFlag then
           MessageDlg(Format(rsDeleteDB,[AnsiLowerCase(rsDoneSucc)]),mtInformation,[mbOK],0);
      end;
    end;
  end;
end;

procedure TMainForm.ProgressBarDBStart(aProgressBar: TProgressBar; aText: String);
begin
  aProgressBar.Visible:=True;
//  aProgressBar.State:=TProgressBarState.pbsNormal;
  aProgressBar.Position:=25;
  aProgressBar.Update;
  sleep(100);
  LabelBDProcess.Visible:=true;
  LabelBDProcess.Caption:=aText;
  Application.ProcessMessages;
end;

procedure TMainForm.ProgressBarErr(aProgressBar: TProgressBar);
begin
//  aProgressBar.State:=TProgressBarState.pbsError;
  Application.ProcessMessages;
end;

procedure TMainForm.ProgressBarFinish(aProgressBar: TProgressBar);
begin
  aProgressBar.Position:=100;
end;

procedure TMainForm.ProgressBarHide(aProgressBar: TProgressBar);
begin
  LabelBDProcess.Visible:=false;
  aProgressBar.Visible:=False;
end;

procedure TMainForm.BtnDosCancelClick(Sender: TObject);
begin
  LoadDosData(TLDDataModule.ADOQuery,Dosimeter);
end;

procedure TMainForm.BtnDosSaveClick(Sender: TObject);
begin
  SaveAdditionalParameters;
end;

procedure TMainForm.BtnExcludeFromPartClick(Sender: TObject);
begin
  ExcludeDosimeterFromPart;
end;

procedure TMainForm.BtnExportClick(Sender: TObject);
var
  PGDumpPath     :  String;
  PGDumpParam    :  String;
  Flag           :  boolean;
  GridLineIndex  :  integer;
  dbName         :  String;
  procedure DBGridSetFocus(aLine: integer);
  begin
    if aLine>0 then
      DBGridEhDB.DataSource.DataSet.RecNo:=aLine;
  end;
begin
  GridLineIndex:=DBGridEhDB.DataSource.DataSet.RecNo;   // запоминаем номер строки в таблице
  Flag:=False;

  if SaveDialogDB.Execute then
  begin
    dbName:=cDefaultDB;

    WriteLog(Format('%s "%s"',[rsDBExport,dbName]));

    PGDumpPath:=TLDDataModule.PGDumpPath;
    if FileExists(PGDumpPath) then
    begin
      // формируем строку для запуска программы pg_dump для импорта БД
      if RadioButton_backup.Checked then
      begin
        PGDumpParam:='--host "'+TLDDataModule.ServerIP+'" '
                    +'--port "'+TLDDataModule.PGPort+'" '
                    +'--username "'+TLDDataModule.PGUid+'" '
                    +'--dbname "'+cPostgreDefaultDB+'://'+TLDDataModule.PGUid+':'+TLDDataModule.PGPass+'@'+TLDDataModule.ServerIP+':'+TLDDataModule.PGPort+'/'+dbName+'" '
                    +'--verbose '
                    +'--format=c '
                    +'--blobs '
                    +'--encoding=UTF8 '
                    +'--file='+Format('"%s"',[SaveDialogDB.FileName]);
      end;

      if RadioButton_sql.Checked then
      begin
        PGDumpParam:='--host "'+TLDDataModule.ServerIP+'" '
                    +'--port "'+TLDDataModule.PGPort+'" '
                    +'--username "'+TLDDataModule.PGUid+'" '
                    +'--dbname "'+cPostgreDefaultDB+'://'+TLDDataModule.PGUid+':'+TLDDataModule.PGPass+'@'+TLDDataModule.ServerIP+':'+TLDDataModule.PGPort+'/'+dbName+'" '
                    +'--format=p '
                    +'--encoding=UTF8 '
                    +'--disable-macs '
                    +'--file='+Format('"%s"',[SaveDialogDB.FileName]);
      end;

      // запускаем скрол бар

      ProgressBarDBStart(ProgressBarDB,rsDBExportTo + dbName);

      // через функцию ExecAndWait запускаем программу "pg_dump.exe" для восстановления таблиц и ожидаем ее завершения
      try
        Flag:=ExecAndWait(PGDumpPath,PGDumpParam,cExport,ExtractFilePath(Application.ExeName)+cDatraBaseLog,SW_SHOWNORMAL);
      except
        on E: Exception do
        begin
          ProgressBarErr(ProgressBarDB);
          DBGridEhDB.SetFocus;
          DBGridSetFocus(TLDDataModule.GetDBGridStringNumber(DBGridEhDB, TLDDataModule.dbName));
          DBGridEhDB.SelectedRows.CurrentRowSelected:=true;
          MessageDlg(E.Message + CRLF + rsDBExportDenied+'!',mtError, [mbOK], 0);
          WriteLog(Format('%s "%s"',[rsDBExportDenied2,dbName]));
          ProgressBarHide(ProgressBarDB);
        end;
      end;

      // останавливаем скролл бар
      ProgressBarFinish(ProgressBarDB);

      if Flag then
      begin
        RefreshDBList;
        //DBGridSetFocus(GridLineIndex);                                // возвращаемся на запомненную строку
        DBGridEhDB.SetFocus;
        DBGridSetFocus(TLDDataModule.GetDBGridStringNumber(DBGridEhDB, TLDDataModule.dbName));
        DBGridEhDB.SelectedRows.CurrentRowSelected:=true;
        MessageDlg(rsExportDone + CRLF + SaveDialogDB.FileName,mtInformation, [mbOK], 0);
        WriteLog(Format('%s "%s" %s "%s"',[rsExportDone2,dbName,rsToFile,SaveDialogDB.FileName]));
      end;

      ProgressBarHide(ProgressBarDB);
    end
    else
    begin
      ProgressBarErr(ProgressBarDB);
      DBGridEhDB.SetFocus;
      DBGridSetFocus(TLDDataModule.GetDBGridStringNumber(DBGridEhDB, TLDDataModule.dbName));
      DBGridEhDB.SelectedRows.CurrentRowSelected:=true;
      //DBGridSetFocus(GridLineIndex);  // возвращаемся на запомненную строку
      MessageDlg(format(rsDBExportDeniedNoFile,[PGDumpPath]),mtError, [mbOK], 0);
      WriteLog(Format('%s "%s".%s "%s"',[rsDBExportDenied2,dbName,rsFileNotFound,PGDumpPath]));
      ProgressBarHide(ProgressBarDB);
    end;
  end;
end;

procedure TMainForm.BtnOpenCalibrClick(Sender: TObject);
begin
  OpenCalibrForm;
end;

function TMainForm.RestoreDBFromBackup(DBName: String): integer;
begin
  if (DBName<>cDefaultDB) AND (DBName<>'') then
  begin
    ProgressBarDBStart(ProgressBarDB,rsDBImport+DBName);

    WriteLog(Format('%s "%s"',[rsDBImportFromReserved,DBName]));

    if TLDDataModule.RestoreDB(DBName,true) then
    begin
      if IsValidDBVersion then
      begin
        ResetDosimeterData;                      // сбрасываем текущие набранные измерения
        UpdateGridPageStart;
        PageControlSettings.ActivePage:=TabSheetDataBase;
        ProgressBarFinish(ProgressBarDB);
        RefreshDBList;
        MessageDlg(Format('%s "%s"',[rsDBImportDone,DBName]),mtInformation, [mbOK], 0);
        WriteLog(Format('%s "%s"',[rsDBImportDone,DBName]));
        ProgressBarHide(ProgressBarDB);
        Result:=0;
      end
      else
      begin
        Result:=-1;
        MainForm.Close;
      end;
    end
    else
    begin
      ProgressBarErr(ProgressBarDB);
      MessageDlg(Format('%s "%s". %s - %s',[rsDBImportFailure+' ',DBName,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError,[mbOK],0);
      WriteLog(Format('%s "%s"',[rsDBImportFailure,DBName]));
      Result:=-1;
    end;
  end
  else
  begin
    MessageDlg(Format('%s "%s". %s',[rsDBWorkChecked,cDefaultDB,rsDBChooseWorkForImport]),mtWarning, [mbOK], 0);
    Result:=1;
  end;
end;

procedure TMainForm.RestoreGridParametersCalibr;
var
  RestoreParams: TColumnEhRestoreParams;
begin
  DBGridEhCalcKDos.RestoreColumnsLayoutIni(extractfilepath(Application.ExeName)+cConfigFile,cSectionGridCalibr,RestoreParams);
end;

procedure TMainForm.SetSaveDialogDBFilter;
begin
  if RadioButton_backup.Checked then
    SaveDialogDB.Filter := rsBackupBackupFiles;

  if RadioButton_sql.Checked then
    SaveDialogDB.Filter := rsBackupSqlFiles;
end;

procedure TMainForm.RestoreGridParametersDos;
var
  RestoreParams: TColumnEhRestoreParams;
begin
  DBGridEhDos.RestoreColumnsLayoutIni(extractfilepath(Application.ExeName)+cConfigFile,cSectionGridDos,RestoreParams);
end;

procedure TMainForm.RestoreGridParametersMeas;
var
  RestoreParams: TColumnEhRestoreParams;
begin
  DBGridEhOnlyMeas.RestoreColumnsLayoutIni(extractfilepath(Application.ExeName)+cConfigFile,cSectionGridMeas,RestoreParams);
end;

procedure TMainForm.RestoreGridParametersProcess;
var
  RestoreParams: TColumnEhRestoreParams;
begin
  DBGridEhProcess.RestoreColumnsLayoutIni(extractfilepath(Application.ExeName)+cConfigFile,cSectionGridProcess,RestoreParams);
end;

procedure TMainForm.BtnResstoreDBClick(Sender: TObject);
begin
  if DBGridEhDB.DataSource.DataSet.RecordCount > 0 then
  begin
    if RestoreDBFromBackup(DBGridEhDB.DataSource.DataSet.FieldByName(cDBName).AsString)=0 then
    begin
      ActiveForm:=true;
      FormActivate(Self);
    end;
  end;
end;

procedure TMainForm.BtnSaveDosAdditionalParametersGroupClick(Sender: TObject);
begin
  SaveAdditionalParameters;
end;

procedure TMainForm.BtnSettingsSaveParametersClick(Sender: TObject);
begin
  KSLevel:=StrToInt(EditSettingsKSNormalValue.Text);
  KSDelta:=StrToInt(EditSettingsKSDeviation.Text);
  KFilter:=StrToFloatRegion(EditSettingsKFilter.Text);

  TLDDataModule.WriteDeviceID(DeviceID,KSLevel,KSDelta,KFilter);
end;

procedure TMainForm.BtnStartCalibrClick(Sender: TObject);
begin
  StartCalibration;
end;

procedure TMainForm.BtnStartTestingClick(Sender: TObject);
begin
  if TLDDataModule.IsDosimeterExist(FTestSourceDosimeterName) then
  begin
    PageControlMain.ActivePage:=TabSheetMeas;
    FStartTestingCommentTime:=Now;
    FTestSourceKIncrease:=StrToFloatRegion(EditTestSourceKIncrease.Text);
    FTestSourceTime:=StrToInt(EditTestSourceTime.Text);
    FTestSourceTimeIncreaseCycle:=StrToInt(EditTestSourceTimeIncreaseCycle.Text);
    FTestSourceDosimeterName:=CBoxDosimeterTest.Text;

    LblTestDosNameErr.Visible:=false;
    OnCommandLog(TimeToStr(Now)+' : -> ', rsLogStartTest,'',cMsgInf,cMsgPriorityInf);
    StartMeas(cTesting);
  end
  else
  begin
    LblTestDosNameErr.Visible:=true;
  end;
end;

procedure TMainForm.ReinintBtnClick(Sender: TObject);
begin
  ReinitializeCOMPort;
end;

procedure TMainForm.CloseBtnClick(Sender: TObject);
begin
  CloseCOMPort;
end;

procedure TMainForm.BtnOpenCalibrGroupClick(Sender: TObject);
begin
  OpenCalibrForm;
end;

procedure TMainForm.ButtonExportConfigClick(Sender: TObject);
var
  fullPath  : String;
begin
  SaveDialogMainForm.DefaultExt:='csv';
  SaveDialogMainForm.Filter:='|'+'*'+cExtCSV;
  SaveDialogMainForm.InitialDir:=extractfilepath(Application.ExeName)+cFolderLibrary+PathDelim;
  SaveDialogMainForm.FileName:=Format('%s_№%s_%s',[rsSoftwareName,IntToStr(DeviceID),'Config']);

  if SaveDialogMainForm.Execute then
  begin
    fullPath:=SaveDialogMainForm.FileName;

    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldTldID+','
                                            +cFieldKSLevel+','
                                            +cFieldKSDelta+','
                                            +cFieldKFilter+''
                                            +' FROM '+cDBTableSettings+' WHERE '+cFieldTldID+' = '+IntToStr(DeviceID));
    TLDDataModule.ADOQuery.Active:=True;

    TLDDataModule.DataSetTextExporterEh.ExportToFile(fullPath);
  end;
end;

procedure TMainForm.ButtonImportConfigClick(Sender: TObject);
var
  path      : String;
//  fullPath  : String;
  tldid     : integer;
  _kslevel   : integer;
  _ksdelta   : integer;
  _kfilter   : double;
//  kdev      : double;
begin
  path:=extractfilepath(Application.ExeName)+cFolderLibrary+PathDelim;

  OpenDialogDeviceSettings.InitialDir:=path;

  if OpenDialogDeviceSettings.Execute then
  begin

    try
      TLDDataModule.MemTableEhTLDSettings.Active:=True;
      TLDDataModule.DataSetTextImporterEh.ImportFromFile(OpenDialogDeviceSettings.FileName);
      tldid:=TLDDataModule.MemTableEhTLDSettings.FieldByName(cFieldTldID).AsInteger;

      if (TLDDataModule.IsDeviceIdExist(tldid)) then
      begin
        _kslevel:=TLDDataModule.MemTableEhTLDSettings.FieldByName(cFieldKSLevel).AsInteger;
        _ksdelta:=TLDDataModule.MemTableEhTLDSettings.FieldByName(cFieldKSDelta).AsInteger;
        _kfilter:=TLDDataModule.MemTableEhTLDSettings.FieldByName(cFieldKFilter).AsFloat;

        if TLDDataModule.UpdateDeviceConfig(tldid,_kslevel,_ksdelta,_kfilter,1) then
        begin
          ReadTLDSettings;
          WriteLog(Format('%s',[rsImportConfigDone]));
          MessageDlg(rsImportConfigDone+'.',mtInformation, [mbOK], 0);
        end
        else
        begin
          WriteLog(Format('%s',[rsErrDBConfigImport]));
          MessageDlg(rsErrDBConfigImport+'.',mtError, [mbOK], 0);
        end;
      end;

    except
      on E: Exception do
      begin
        WriteLog(Format('%s. %s',[rsErrDBConfigImport,E.Message]));
        MessageDlg(E.Message+CRLF+rsErrDBConfigImport+'.',mtError, [mbOK], 0);
      end;
    end;
  end;

end;

procedure TMainForm.BntCleanClick(Sender: TObject);
begin
  DropCalibrationParameters;
end;

procedure TMainForm.ButtonAboutClick(Sender: TObject);
begin
  VW.ShowModal;
end;

procedure TMainForm.ButtonChangeUserClick(Sender: TObject);
begin
  AW.ShowModal;  // смена пользователя
end;

procedure TMainForm.ButtonComPortSettingsClick(Sender: TObject);
begin
  SetW.Show;
end;

procedure TMainForm.ButtonControlDeviceClick(Sender: TObject);
begin
  //TLDCommand.NNReadTablePos;
  ControlW.Show;
end;

procedure TMainForm.ButtonDataBaseClick(Sender: TObject);
begin
  OpenDB.Show;
end;

procedure TMainForm.BtnDeleteDiscommissionDosimetersClick(Sender: TObject);
begin
  DeleteDiscommissionDosimeters;
  UpdateGridDosPage;
end;

procedure TMainForm.BtnDeleteMarkedToDelMeasClick(Sender: TObject);
begin
  DeleteMarkedToDelMeas;
  UpdateGridMeasAndProcessPages;
end;

procedure TMainForm.BtnImportDataBaseClick(Sender: TObject);
begin
  ImportInCurrentDBForm.Show;
end;

procedure TMainForm.ButtonModelClick(Sender: TObject);
begin
  ModelW.Show;
end;

procedure TMainForm.SetTestSource(const Value: boolean);
begin
  FTestSourceUse:=Value;
  CBoxTestSourceUse.Checked:=Value;
end;

procedure TMainForm.SetTestSourceDosimeterName(const Value: String);
begin
  FTestSourceDosimeterName:=Value;
  CBoxDosimeterTest.Text:=Value;
end;

procedure TMainForm.SetTestSourceKIncrease(const Value: double);
begin
  FTestSourceKIncrease:=Value;
  EditTestSourceKIncrease.Text:=FloatToStrRegion(Value);
end;

procedure TMainForm.SetTestSourceTime(const Value: integer);
begin
  FTestSourceTime:=Value;
  EditTestSourceTime.Text:=IntToStr(Value);
end;

procedure TMainForm.SetTestSourceTimeIncrease(const Value: boolean);
begin
  FTestSourceTimeIncrease:=Value;
  CBoxTestSourceTimeIncrease.Checked:=Value;
end;

procedure TMainForm.SetTestSourceTimeIncreaseCycle(const Value: integer);
begin
  FTestSourceTimeIncreaseCycle:=Value;
  EditTestSourceTimeIncreaseCycle.Text:=IntToStr(Value);
end;

procedure TMainForm.SetTestWriteModbusLog(const Value: boolean);
begin
  FTestWriteModbusLog:=Value;
  CBoxTestWriteModbusLog.Checked:=Value;
end;

procedure TMainForm.SetTmpState(aTmpState: integer);
begin
  if (FTmpState <> aTmpState) then
  begin
    FTmpState:=aTmpState;
    case FTmpState of
      cTmpGreen: // температура в норме
      begin
        EditTemp.Color:=clMoneyGreen;
        //ControlW.EditTemp.Color:=clMoneyGreen;
        ImageTemp.Picture.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'term_green.bmp');
      end;
      cTmpRed:   // температура в выше 70
      begin
        EditTemp.Color:=clRed;
        //ControlW.EditTemp.Color:=clRed;
        ImageTemp.Picture.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'term_red.bmp');
      end;
      cTmpGray:  // нет связи
      begin
        EditTemp.Color:=clSilver;
        //ControlW.EditTemp.Color:=clSilver;
        ImageTemp.Picture.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'term_gray.bmp');
      end;
    end;
  end;
end;

procedure TMainForm.SetUseControlComment(const Value: boolean);
begin
  FUseControlComment := Value;
end;

procedure TMainForm.SetUseFilterDate(DataPicker: TDateTimePicker; SpeedBtn: TSpeedButton; aUse: boolean);
begin
  if (aUse) then
  begin
//    DataPicker.Format:='';
    SpeedBtn.Visible:=True;
  end
  else
  begin
//    DataPicker.Format:=#32;   // очищаем DateTimePicker
    SpeedBtn.Visible:=False;
  end;
end;

procedure TMainForm.SetUseKFilter(Value: boolean);
begin
  FUseKFilter:=Value;

  if Dosimeter <> nil then
  begin
    if FUseKFilter then Dosimeter.KFilter := KFilter else Dosimeter.KFilter := cDosNoFilter;
  end;
end;

procedure TMainForm.SetUseSQLScript(aUse: boolean);
begin
  if (aUse) then
  begin
    SpBtnProcessDropSQLScript.Visible:=True;
  end
  else
  begin
    SpBtnProcessDropSQLScript.Visible:=False;
    SQLFilterForm.DropScript;
  end;
end;

procedure TMainForm.SQLScriptChange(aVisible: boolean);
begin
  SpBtnProcessDropSQLScript.Visible:=aVisible;
  if not Visible then SQLFilterForm.DropScript;
  UpdateBtnFilters;
  UpdateAllGridPages;
end;

procedure TMainForm.LoadCalibrK(K1,K2,K3,K4,K5,Kgn: double);
  procedure SetEdit(Edit: TEdit; Value: double; LblDotK, LblK: TLabel; TabSheetK: TTabSheet);
  var
    valStr: String;
  begin
    if Value<=0 then
    begin
      Edit.Visible:=false;
      LblDotK.Visible:=false;
      LblK.Visible:=false;
      Edit.Text:='';
      TabSheetK.TabVisible:=false;
    end
    else
    begin
      valStr:=FloatToStrRegion(RoundToCN(Value,-1));
      Edit.Visible:=true;
      LblDotK.Visible:=true;
      LblK.Visible:=true;
      if valStr<>Edit.Text then
        Edit.Text:=valStr
      else
        if Assigned(Edit.OnChange) then Edit.OnChange(Self);
      TabSheetK.TabVisible:=true;
    end;
  end;
  procedure SetEditGN(Edit: TEdit; Value: double; LblDotK, LblK: TLabel; TabSheetK: TTabSheet);
  var
    valStr: String;
  begin
    if Value<=0 then
    begin
      Edit.Visible:=false;
      LblDotK.Visible:=false;
      LblK.Visible:=false;
      Edit.Text:='';
      TabSheetK.TabVisible:=false;
    end
    else
    begin
      valStr:=FloatToStrRegion(RoundToCN(Value,-2));
      Edit.Visible:=true;
      LblDotK.Visible:=true;
      LblK.Visible:=true;
      if valStr<>Edit.Text then
        Edit.Text:=valStr
      else
        Edit.OnChange(Self);
      TabSheetK.TabVisible:=true;
    end;
  end;
begin
  SetEdit(EditK_1_Calibr,K1,LblDotK1_Calibr,LblK_1_Calibr,TabSheetK1);
  SetEdit(EditK_2_Calibr,K2,LblDotK2_Calibr,LblK_2_Calibr,TabSheetK2);
  SetEdit(EditK_3_Calibr,K3,LblDotK3_Calibr,LblK_3_Calibr,TabSheetK3);
  SetEdit(EditK_4_Calibr,K4,LblDotK4_Calibr,LblK_4_Calibr,TabSheetK4);
  SetEdit(EditK_5_Calibr,K5,LblDotK5_Calibr,LblK_5_Calibr,TabSheetK5);
  SetEditGN(EditK_gn_Calibr,Kgn,LblDotKgn_Calibr,LblK_gn_Calibr,TabSheetKgn);

  TabSheetKS.TabVisible:=true;
end;

function TMainForm.IsCalibrKEditsValid: boolean;
var
  flag: boolean;
begin
  flag:=IsCalibrKValid(EditK_1_Calibr) AND
        IsCalibrKValid(EditK_2_Calibr) AND
        IsCalibrKValid(EditK_3_Calibr) AND
        IsCalibrKValid(EditK_4_Calibr) AND
        IsCalibrKValid(EditK_5_Calibr) AND
        IsCalibrKValid(EditK_gn_Calibr);

  LabelCalibrKErr.Visible:=not flag;
  Result:=flag;
end;

procedure TMainForm.UpdateK;
var
  i,j                 : integer;
  fullDosId           : String;
  dosId               : String;
  measId              : String;
  partName            : String;
  dosCnt              : integer;
  calibrDate          : TDateTime;
  k1,k2,k3,k4,k5,kgn  : double;
  partID              : integer;
  partList            : TStringList;
  dosWithoutPartList  : TStringList;
  dosWithPartList     : TStringList;
  strList             : TStringList;
  temp                : word;
begin
  partID:=0;

  if IsCalibrKEditsValid then
  begin
    dosCnt:=DBGridEhCalcKDos.RowCount;
    calibrDate:=DateTimePickerCalibr.Date;

    k1:=StrToFloatRegionNAN(EditK_1_Calibr.Text);
    k2:=StrToFloatRegionNAN(EditK_2_Calibr.Text);
    k3:=StrToFloatRegionNAN(EditK_3_Calibr.Text);
    k4:=StrToFloatRegionNAN(EditK_4_Calibr.Text);
    k5:=StrToFloatRegionNAN(EditK_5_Calibr.Text);
    kgn:=StrToFloatRegionNAN(EditK_gn_Calibr.Text);

    partList:=TStringList.Create;
    dosWithPartList:=TStringList.Create;
    dosWithoutPartList:=TStringList.Create;

    DBGridEhCalcKDos.DataSource.DataSet.First;
    for i := 0 to DBGridEhCalcKDos.RowCount-1 do
    begin
      fullDosId:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFullDosID).AsString;

      if TLDDataModule.IsDosimeterInPart(fullDosId) then
      begin
        partName:=TLDDataModule.GetPartName(TLDDataModule.GetDosPartID(fullDosId));

        if dosWithPartList.IndexOf(fullDosId)<0 then
          dosWithPartList.Add(fullDosId);

        if partList.IndexOf(partName)<0 then
          partList.Add(partName);
      end
      else
        if dosWithoutPartList.IndexOf(fullDosId)<0 then
          dosWithoutPartList.Add(fullDosId);

      DBGridEhCalcKDos.DataSource.DataSet.Next;
    end;

    if partList.Count>0 then
    begin
      if partList.Count>1 then
        temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s: %s?',[rsMsgCalibrDiffParts,#13#10+partList.GetText]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'')
      else
        temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s: %s?',[rsMsgCalibrAllPart,#13#10+partList.GetText]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

      case temp of
        mrYes:
        begin
          for i := 0 to partList.Count-1 do
          begin
            try
              partID:=TLDDataModule.GetPartID(partList[i],DeviceID);

              TLDDataModule.UpdateKInPart(k1,k2,k3,k4,k5,kgn,partID,calibrDate,cDosCalibrated);

              if TLDDataModule.UpdateKInDosIDByPart(k1,k2,k3,k4,k5,kgn,partID,calibrDate,cDosCalibrated) then
              begin
                strList:=GetDosMeasWithOldKInPart(partID,calibrDate);

                if strList.Count>0 then
                begin
                  temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s (%d%s). %s?',[rsFoundMeasuresAfterCalibration,strList.Count,rsNums,rsRecalcMeasuresAfterCalibration]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');
                  case temp of
                    mrYes:
                    begin
                      for j := 0 to strList.Count-1 do
                      begin
                        dosID:=copy(strList[j],1,pos('[',strList[j])-1);
                        measID:=strList[j];
                        delete(measID, 1, pos('[', measID));
                        delete(measID, pos(']', measID),1);

                        MainForm.RecalcCurrentDosimeterDose(dosID,measID);
                      end;

                      MainForm.UpdateGridMeasAndProcessPages;
                    end;
                  end;
                end;

                strList.Free;

                WriteLog(Format('%s - "%s" k1=%s, k2=%s, k3=%s, k4=%s, k5=%s, kgn=%s',[rsCoeffsChanged,dosWithPartList[i],
                                                                                                                FloatToStrRegion(k1),
                                                                                                                FloatToStrRegion(k2),
                                                                                                                FloatToStrRegion(k3),
                                                                                                                FloatToStrRegion(k4),
                                                                                                                FloatToStrRegion(k5),
                                                                                                                FloatToStrRegion(kgn)
                                                                                                                ]));
              end
              else
              begin
                WriteLog(Format('%s - "%s %s',[rsErrCoeffChanged,dosWithPartList[i]]));
                break;
              end;
            except
              WriteLog(Format('%s - "%s %s',[rsErrCoeffChanged,dosWithPartList[i]]));
            end;
          end;
        end;
        mrNo:
        begin
          for i := 0 to dosWithPartList.Count-1 do
          begin
            try
              TLDDataModule.ExcludeDosimeterFromPart(dosWithPartList[i]);

              if TLDDataModule.UpdatePartInDos(dosWithPartList[i],k1,k2,k3,k4,k5,kgn,0,calibrDate) then
              begin
                WriteLog(Format('%s - "%s" k1=%s, k2=%s, k3=%s, k4=%s, k5=%s, kgn=%s',[rsCoeffsChanged,dosWithPartList[i],
                                                                                                                FloatToStrRegion(k1),
                                                                                                                FloatToStrRegion(k2),
                                                                                                                FloatToStrRegion(k3),
                                                                                                                FloatToStrRegion(k4),
                                                                                                                FloatToStrRegion(k5),
                                                                                                                FloatToStrRegion(kgn)
                                                                                                                ]));
              end
              else
              begin
                WriteLog(Format('%s - "%s %s',[rsErrCoeffChanged,dosWithPartList[i]]));
                break;
              end;
            except
              on E: exception do
              begin
                WriteLog(Format('%s - "%s %s',[rsErrCoeffChanged,dosWithPartList[i]]));
              end;
            end;
          end;
        end;
      end;

    end;

    for i := 0 to dosWithoutPartList.Count-1 do
    begin
      try
        if TLDDataModule.UpdatePartInDos(dosWithoutPartList[i],k1,k2,k3,k4,k5,kgn,0,calibrDate) then
        begin
          WriteLog(Format('%s - "%s" k1=%s, k2=%s, k3=%s, k4=%s, k5=%s, kgn=%s',[rsCoeffsChanged,fullDosId,
                                                                                                          FloatToStrRegion(k1),
                                                                                                          FloatToStrRegion(k2),
                                                                                                          FloatToStrRegion(k3),
                                                                                                          FloatToStrRegion(k4),
                                                                                                          FloatToStrRegion(k5),
                                                                                                          FloatToStrRegion(kgn)
                                                                                                          ]));
        end
        else
        begin
          WriteLog(Format('%s - "%s"',[rsErrCoeffChanged,fullDosId]));
          break;
        end;
      except
        on E: exception do
        begin
          WriteLog(Format('%s - "%s"',[rsErrCoeffChanged,fullDosID]));
        end;
      end;

    end;

    strList:=GetDosMeasWithOldK(dosWithoutPartList);

    if strList.Count>0 then
    begin
      temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s (%d%s). %s?',[rsFoundLateMeasures,strList.Count,rsNums,rsReCalcWNewCoeff]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

      case temp of
        mrYes:
        begin
          Splash.ProgressBar.Minimum:=0;
          Splash.ProgressBar.Maximum:=strList.Count;
          Splash.Show(false);
          Splash.SetCaption(rsRecalculation);

          for i := 0 to strList.Count-1 do
          begin
            dosID:=copy(strList[i],1,pos('[',strList[i])-1);
            measID:=strList[i];
            delete(measID, 1, pos('[', measID));
            delete(measID, pos(']', measID),1);

            MainForm.RecalcCurrentDosimeterDose(dosID,measID);
            MainForm.Splash.ProgressBar.Position:=i;
          end;

          Splash.Close;
          UpdateGridMeasAndProcessPages;
        end;
      end;
    end;

    strList.Free;

    DBGridEhCalcKDos.DataSource.DataSet.First;
    for i := 0 to DBGridEhCalcKDos.DataSource.DataSet.RecordCount-1 do
    begin
      measId:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;

      TLDDataModule.ChangeMeasState(measId,cMeasStCalibrComplete);
      DBGridEhCalcKDos.DataSource.DataSet.Next;
    end;

    partList.Free;
    dosWithPartList.Free;
    dosWithoutPartList.Free;
  end;

end;

procedure TMainForm.AcceptKDos;
begin
  UpdateK;
  LoadFilters;
  UpdateAllGridPages;
  UpdateGridDosPage;
end;

function TMainForm.IsCalibrKValid(Edit: TEdit): boolean;
var
  flag: boolean;
begin
  if Edit.Visible then
  begin
    if IsReal(Edit.Text) then
      flag:=true
    else
      flag:=false;
  end
  else
    flag:=true;

  Result:=flag;
end;

procedure TMainForm.StartCalibration;
var
  i,j         : integer;
  measid      : String;
  fullDosID   : String;
  radType     : String;
  sourceDose  : double;
  formulaID   : integer;
  ksi         : integer;
  k1_avg      : double;
  k2_avg      : double;
  k3_avg      : double;
  k4_avg      : double;
  k5_avg      : double;
  kgn_avg     : double;
  hp_10g6     : double;
  hp_10g7     : double;
  d1          : double;
  d2          : double;
  d3          : double;
  d4          : double;
  ksi_avg     : integer;
  gammaCnt    : integer;
  neutronCnt  : integer;
  gammaFinish : boolean;
  dosimeterCalibration   : TDosimeter;
begin
  if DBGridEhCalcKDos.DataSource.DataSet.RecordCount>0 then
  begin
    MemTableEhCalcKDos.SortByFields(cFieldRadiationType);
    MemTableEhCalcKDos.SortByFields(cFieldCalibrationValue);

    gammaFinish:=false;

    k1_avg:=0;
    k2_avg:=0;
    k3_avg:=0;
    k4_avg:=0;
    k5_avg:=0;
    kgn_avg:=0;
    ksi_avg:=0;

    hp_10g7:=-1;
    hp_10g6:=-1;

    gammaCnt:=0;
    neutronCnt:=0;

    SeriesKS.Clear;
    SeriesKSAvg.Clear;

    SeriesK1.Clear;
    SeriesK1Err.Clear;

    SeriesK2.Clear;
    SeriesK2Err.Clear;

    SeriesKgn.Clear;
    SeriesKgnErr.Clear;

    MemTableEhCalcKDos.First;

    Splash.ProgressBar.Minimum:=0;
    Splash.ProgressBar.Maximum:=DBGridEhCalcKDos.DataSource.DataSet.RecordCount;
    Splash.Show(false);
    Splash.SetCaption(rsProcessing);
    Splash.ProgressBar.Position:=0;

    for i := 0 to DBGridEhCalcKDos.DataSource.DataSet.RecordCount-1 do
    begin
      measid:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;
      //dose:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldHp10g).AsFloat;
      sourceDose:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldCalibrationValue).AsFloat;
      formulaID:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldFormulaId_Dos).AsInteger;
      fullDosID:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFullDosID).AsString;
      ksi:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldKSI).AsInteger;
      radType:=DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldRadiationType).AsString;

      dosimeterCalibration:=TDosimeter.Create(fullDosID,measid);

      LoadDosWithMeasData(TLDDataModule.ADOQuery,dosimeterCalibration,measid);
      LoadDetData(TLDDataModule.ADOQuery,dosimeterCalibration,measid);

      ksi_avg:=ksi_avg+ksi;

      if radType = cRadTypeGamma then
      begin
        if not (dosimeterCalibration.K1.IsNan) then dosimeterCalibration.K1:=1;
        if not (dosimeterCalibration.K2.IsNan) then dosimeterCalibration.K2:=1;
        if not (dosimeterCalibration.K3.IsNan) then dosimeterCalibration.K3:=1;
        if not (dosimeterCalibration.K4.IsNan) then dosimeterCalibration.K4:=1;
        if not (dosimeterCalibration.K5.IsNan) then dosimeterCalibration.K5:=1;
        if not (dosimeterCalibration.Kgn.IsNan) then dosimeterCalibration.Kgn:=1;
        inc(gammaCnt);
      end;

      if radType = cRadTypeNeutron then
      begin
        if (not gammaFinish) then
        begin
          if (gammaCnt>0) then
          begin
            k1_avg:=RoundToCN(k1_avg/gammaCnt,-1);
            k2_avg:=RoundToCN(k2_avg/gammaCnt,-1);
            k3_avg:=RoundToCN(k3_avg/gammaCnt,-1);
            k4_avg:=RoundToCN(k4_avg/gammaCnt,-1);
            k5_avg:=RoundToCN(k5_avg/gammaCnt,-1);
          end;

          SeriesKgnErr.Clear;
          SeriesKgn.Clear;

          kgn_avg:=0;
          gammaFinish:=true;
        end;

        if gammaCnt <> 0 then
        begin
          if not (dosimeterCalibration.K1.IsNan) then dosimeterCalibration.K1:=k1_avg;
          if not (dosimeterCalibration.K2.IsNan) then dosimeterCalibration.K2:=k2_avg;
          if not (dosimeterCalibration.K3.IsNan) then dosimeterCalibration.K3:=k3_avg;
        end;

        if not (dosimeterCalibration.Kgn.IsNan) then dosimeterCalibration.Kgn:=1;
        inc(neutronCnt);
      end;

      dosimeterCalibration.RecalcAllDetectorsDose;
      dosimeterCalibration.CalcDose;

      if SourceDose > 0 then
      case formulaID of
        cHp_10g_1d,
        cHp_10g_2d,
        cHp_10g_3d,
        cHp_10g_4d:
        begin
          dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
          k1_avg:=k1_avg+dosimeterCalibration.K1;
        end;
        cHp_10g_2d_Hp_10n_2d,
        cHp_10g_2d_Hp_10n_1d,
        cHp_10g_1d_Hp_10n_2d,
        cHp_10g_1d_Hp_10n_1d:
        begin
          if Assigned(TDetector(dosimeterCalibration.DetectorsList[0])) then d1:=TDetector(dosimeterCalibration.DetectorsList[0]).Dose else d1:=0;
          if Assigned(TDetector(dosimeterCalibration.DetectorsList[1])) then d2:=TDetector(dosimeterCalibration.DetectorsList[1]).Dose else d2:=0;
          if Assigned(TDetector(dosimeterCalibration.DetectorsList[2])) then d3:=TDetector(dosimeterCalibration.DetectorsList[2]).Dose else d3:=0;
          if Assigned(TDetector(dosimeterCalibration.DetectorsList[3])) then d4:=TDetector(dosimeterCalibration.DetectorsList[3]).Dose else d4:=0;

          case formulaID of
            cHp_10g_2d_Hp_10n_2d:
            begin
              hp_10g7:=RoundToCN((d1+d2)/2,-2);
              hp_10g6:=RoundToCN((d3+d4)/2,-2);
            end;
            cHp_10g_2d_Hp_10n_1d:
            begin
              hp_10g7:=RoundToCN((d1+d2)/2,-2);
              hp_10g6:=RoundToCN(d3,-2);
            end;
            cHp_10g_1d_Hp_10n_2d:
            begin
              hp_10g7:=RoundToCN(d1,-2);
              hp_10g6:=RoundToCN((d2+d3)/2,-2);
            end;
            cHp_10g_1d_Hp_10n_1d:
            begin
              hp_10g7:=RoundToCN(d1,-2);
              hp_10g6:=RoundToCN(d2,-2);
            end;
          end;

          if radType = cRadTypeGamma then
          begin
            dosimeterCalibration.K1:=RoundToCN((hp_10g7/SourceDose),-2);
            dosimeterCalibration.K2:=RoundToCN((hp_10g6/SourceDose),-2);
            k1_avg:=k1_avg+dosimeterCalibration.K1;
            k2_avg:=k2_avg+dosimeterCalibration.K2;
            kgn_avg:=kgn_avg+dosimeterCalibration.Kgn;
          end;

          if radType = cRadTypeNeutron then
          begin
            if (hp_10g6-hp_10g7)>0 then
            begin
              dosimeterCalibration.Kgn:=RoundToCN(SourceDose/(hp_10g6-hp_10g7),-2);
              kgn_avg:=kgn_avg+dosimeterCalibration.Kgn;
            end;
            if gammaCnt=0 then
            begin
              k1_avg:=k1_avg+dosimeterCalibration.K1;
              k2_avg:=k2_avg+dosimeterCalibration.K2;
            end;
          end;
        end;
        cHp_007g_1d,
        cHp_007g_2d,
        cHp_007g_3d,
        cHp_007g_4d:
        begin
          dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_Hp_007/SourceDose),-2);
          k1_avg:=k1_avg+dosimeterCalibration.K1;
        end;
        cHp_3_1d,
        cHp_3_2d,
        cHp_3_3d,
        cHp_3_4d:
        begin
          dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_Hp_3/SourceDose),-2);
          k1_avg:=k1_avg+dosimeterCalibration.K1;
        end;
        cHp_007gb_1d,
        cHp_007gb_2d,
        cHp_007gb_3d,
        cHp_007gb_4d:
        begin
          dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_Hp_007/SourceDose),-2);
          k1_avg:=k1_avg+dosimeterCalibration.K1;
        end;
        cHp_star_g_1d,
        cHp_star_g_2d,
        cHp_star_g_3d,
        cHp_star_g_4d:
        begin
          dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_H_star/SourceDose),-2);
          k1_avg:=k1_avg+dosimeterCalibration.K1;
        end;
        cH_007_dir_g_1d,
        cH_007_dir_g_2d,
        cH_007_dir_g_3d,
        cH_007_dir_g_4d:
        begin
          dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_H_007/SourceDose),-2);
          k1_avg:=k1_avg+dosimeterCalibration.K1;
        end;
        cD_1d,
        cD_2d,
        cD_3d,
        cD_4d:
        begin
          dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_D/SourceDose),-2);
          k1_avg:=k1_avg+dosimeterCalibration.K1;
        end;
        cHp_10g_Hp_10n_Hp_007g_Hp_3:
        begin
          dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
          k1_avg:=k1_avg+dosimeterCalibration.K1;
        end;
        cHp_10g_1d_Hp_007g_1d_Hp_3_1d:
        begin
          if radType = cRadTypeGamma then
          begin
            dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
            dosimeterCalibration.K2:=RoundToCN((dosimeterCalibration.Dose_Hp_007/SourceDose),-2);
            dosimeterCalibration.K3:=RoundToCN((dosimeterCalibration.Dose_Hp_3/SourceDose),-2);
            //dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
            //dosimeterCalibration.K2:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
            //dosimeterCalibration.K3:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
            k1_avg:=k1_avg+dosimeterCalibration.K1;
            k2_avg:=k2_avg+dosimeterCalibration.K2;
            k3_avg:=k3_avg+dosimeterCalibration.K3;
          end;
        end;
        cHp_10g_1d_Hp_007g_1d:
        begin
          if radType = cRadTypeGamma then
          begin
            dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
            dosimeterCalibration.K2:=RoundToCN((dosimeterCalibration.Dose_Hp_007/SourceDose),-2);
            //dosimeterCalibration.K1:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
            //dosimeterCalibration.K2:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
            k1_avg:=k1_avg+dosimeterCalibration.K1;
            k2_avg:=k2_avg+dosimeterCalibration.K2;
          end;
        end;
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          if radType = cRadTypeGamma then
          begin
            dosimeterCalibration.K1:=RoundToCN((TDetector(dosimeterCalibration.DetectorsList[0]).Dose/SourceDose),-2);
            dosimeterCalibration.K2:=RoundToCN((TDetector(dosimeterCalibration.DetectorsList[1]).Dose/SourceDose),-2);
            dosimeterCalibration.K3:=RoundToCN((TDetector(dosimeterCalibration.DetectorsList[2]).Dose/SourceDose),-2);
            dosimeterCalibration.K4:=RoundToCN((TDetector(dosimeterCalibration.DetectorsList[3]).Dose/SourceDose),-2);
            //dosimeterCalibration.K2:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
            //dosimeterCalibration.K3:=RoundToCN((dosimeterCalibration.Dose_Hp_10g/SourceDose),-2);
            k1_avg:=k1_avg+dosimeterCalibration.K1;
            k2_avg:=k2_avg+dosimeterCalibration.K2;
            k3_avg:=k3_avg+dosimeterCalibration.K3;
            k4_avg:=k4_avg+dosimeterCalibration.K4;
          end;
        end;
      end;

      dosimeterCalibration.RecalcAllDetectorsDose;
      dosimeterCalibration.CalcDose;

      MemTableEhCalcKDos.Edit;

      if MemTableEhCalcKDos.FieldByName(cField_k1).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_k1).AsFloat:=RoundToCN(dosimeterCalibration.K1,-1);
      if MemTableEhCalcKDos.FieldByName(cField_k2).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_k2).AsFloat:=RoundToCN(dosimeterCalibration.K2,-1);
      if MemTableEhCalcKDos.FieldByName(cField_k3).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_k3).AsFloat:=RoundToCN(dosimeterCalibration.K3,-1);
      if MemTableEhCalcKDos.FieldByName(cField_k4).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_k4).AsFloat:=RoundToCN(dosimeterCalibration.K4,-1);
      if MemTableEhCalcKDos.FieldByName(cField_k5).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_k5).AsFloat:=RoundToCN(dosimeterCalibration.K5,-1);
      if MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_10g_Percent).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_10g_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_Hp_10g_Percent,-1);
      if MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_10n_Percent).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_10n_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_Hp_10n_Percent,-1);
      if MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_3_Percent).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_3_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_Hp_3_Percent,-1);
      if MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_007_Percent).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_007_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_Hp_007_Percent,-1);
      if MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_H_star_Percent).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_H_star_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_H_star_Percent,-1);
      if MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_H_007_Percent).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_H_007_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_H_007_Percent,-1);
      if MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_D_Percent).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_D_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_D_Percent,-1);
      if MemTableEhCalcKDos.FieldByName(cFieldHp10g).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldHp10g).AsFloat:=dosimeterCalibration.Dose_Hp_10g;
      if MemTableEhCalcKDos.FieldByName(cFieldHp10n).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldHp10n).AsFloat:=dosimeterCalibration.Dose_Hp_10n;
      if MemTableEhCalcKDos.FieldByName(cFieldHp3).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldHp3).AsFloat:=dosimeterCalibration.Dose_Hp_3;
      if MemTableEhCalcKDos.FieldByName(cFieldHp007).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldHp007).AsFloat:=dosimeterCalibration.Dose_Hp_007;
      if MemTableEhCalcKDos.FieldByName(cFieldHstar).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldHstar).AsFloat:=dosimeterCalibration.Dose_H_star;
      if MemTableEhCalcKDos.FieldByName(cFieldH007).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldH007).AsFloat:=dosimeterCalibration.Dose_H_007;
      if MemTableEhCalcKDos.FieldByName(cFieldD).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldD).AsFloat:=dosimeterCalibration.Dose_D;
      if MemTableEhCalcKDos.FieldByName(cFieldDose).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldDose).AsString:=dosimeterCalibration.Doses.GetStringValue;

      MemTableEhCalcKDos.Post;

//      SeriesKS.AddXY(i,ksi);
//      SeriesKS.XLabel[i]:=measid;
      SeriesKS.AddXY(i,ksi,measid);

      if (radType = cRadTypeGamma) AND (gammaCnt > 0) then
      begin
//        SeriesK1Err.AddErrorBar(gammaCnt-1,dosimeterCalibration.K1,dosimeterCalibration.K1Err,FloatToStrRegion(dosimeterCalibration.K1));
//        SeriesK1Err.XLabel[gammaCnt-1]:='';

//        SeriesK1.AddXY(gammaCnt-1,dosimeterCalibration.K1);
//        SeriesK1.XLabel[gammaCnt-1]:=measid;
        SeriesK1.AddXY(gammaCnt-1,dosimeterCalibration.K1,measid);

//        SeriesK2Err.AddErrorBar(gammaCnt-1,dosimeterCalibration.K2,dosimeterCalibration.K2Err,FloatToStrRegion(dosimeterCalibration.K2));
//        SeriesK2Err.XLabel[gammaCnt-1]:='';

//        SeriesK2.AddXY(gammaCnt-1,dosimeterCalibration.K2);
//        SeriesK2.XLabel[gammaCnt-1]:=measid;
        SeriesK2.AddXY(gammaCnt-1,dosimeterCalibration.K2,measid);

//        SeriesKgnErr.AddErrorBar(gammaCnt-1,dosimeterCalibration.Kgn,dosimeterCalibration.KgnErr,FloatToStrRegion(dosimeterCalibration.Kgn));
//        SeriesKgnErr.XLabel[gammaCnt-1]:='';

//        SeriesKgn.AddXY(gammaCnt-1,dosimeterCalibration.Kgn);
//        SeriesKgn.XLabel[gammaCnt-1]:=measid;
        SeriesKgn.AddXY(gammaCnt-1,dosimeterCalibration.Kgn,measid);
      end;

      if (radType = cRadTypeNeutron) AND (neutronCnt > 0) then
      begin
//        SeriesKgnErr.AddErrorBar(neutronCnt-1,dosimeterCalibration.Kgn,dosimeterCalibration.KgnErr,FloatToStrRegion(dosimeterCalibration.Kgn));
//        SeriesKgnErr.XLabel[neutronCnt-1]:='';
//        SeriesKgn.AddXY(neutronCnt-1,dosimeterCalibration.Kgn);
//        SeriesKgn.XLabel[neutronCnt-1]:=measid;
        SeriesKgn.AddXY(neutronCnt-1,dosimeterCalibration.Kgn,measid);
      end;

      if (radType = cRadTypeNeutron) AND (gammaCnt = 0) then
      begin
//        SeriesK1Err.AddErrorBar(neutronCnt-1,dosimeterCalibration.K1,dosimeterCalibration.K1Err,FloatToStrRegion(dosimeterCalibration.K1));
//        SeriesK1Err.XLabel[neutronCnt-1]:='';
        SeriesK1.AddXY(neutronCnt-1,dosimeterCalibration.K1,measid);

//        SeriesK2Err.AddErrorBar(neutronCnt-1,dosimeterCalibration.K2,dosimeterCalibration.K2Err,FloatToStrRegion(dosimeterCalibration.K2));
//        SeriesK2Err.XLabel[neutronCnt-1]:='';
        SeriesK2.AddXY(neutronCnt-1,dosimeterCalibration.K2,measid);

//        SeriesKgnErr.AddErrorBar(neutronCnt-1,dosimeterCalibration.Kgn,dosimeterCalibration.KgnErr,FloatToStrRegion(dosimeterCalibration.Kgn));
//        SeriesKgnErr.XLabel[neutronCnt-1]:='';
        SeriesKgn.AddXY(neutronCnt-1,dosimeterCalibration.Kgn,measid);
      end;

      MemTableEhCalcKDos.Next;

      Splash.ProgressBar.Position:=i;
    end;

    if (neutronCnt = 0) AND (gammaCnt>0) then
    begin
      k1_avg:=RoundToCN(k1_avg/gammaCnt,-1);
      k2_avg:=RoundToCN(k2_avg/gammaCnt,-1);
      k3_avg:=RoundToCN(k3_avg/gammaCnt,-1);
      k4_avg:=RoundToCN(k4_avg/gammaCnt,-1);
      k5_avg:=RoundToCN(k5_avg/gammaCnt,-1);
      kgn_avg:=RoundToCN(kgn_avg/gammaCnt,-2);
    end;

    if (neutronCnt>0) AND (gammaCnt>0) then
    begin
      k1_avg:=RoundToCN(k1_avg,-1);
      k2_avg:=RoundToCN(k2_avg,-1);
      k3_avg:=RoundToCN(k3_avg,-1);
      k4_avg:=RoundToCN(k4_avg,-1);
      k5_avg:=RoundToCN(k5_avg,-1);
      kgn_avg:=RoundToCN(kgn_avg/neutronCnt,-2);
    end;

    if (neutronCnt>0) AND (gammaCnt=0) then
    begin
      k1_avg:=RoundToCN(k1_avg/neutronCnt,-1);
      k2_avg:=RoundToCN(k2_avg/neutronCnt,-1);
      k3_avg:=RoundToCN(k3_avg/neutronCnt,-1);
      k4_avg:=RoundToCN(k4_avg/neutronCnt,-1);
      k5_avg:=RoundToCN(k5_avg/neutronCnt,-1);
      kgn_avg:=RoundToCN(kgn_avg/neutronCnt,-2);
    end;

    ksi_avg:=Round(ksi_avg/DBGridEhCalcKDos.DataSource.DataSet.RecordCount);
    EditKSAvg.Text:=IntToStr(ksi_avg);

//    if SeriesKS.XValues.Count>0 then

    if SeriesKS.Count>0 then
      for j := 0 to SeriesKS.Count-1 do SeriesKSAvg.AddXY(SeriesKS.XValues[j,0],ksi_avg);


    LoadCalibrK(k1_avg,k2_avg,k3_avg,k4_avg,k5_avg,kgn_avg);

    for j := 0 to PanelCalibrChartK.PageCount-1 do
      if PanelCalibrChartK.Pages[j].TabVisible then
      begin
        PanelCalibrChartK.ActivePageIndex:=j;
        break;
      end;

    CalibrationPressed:=IsValidCalibrationList;

    SetFooterCalcKDosGrid(cField_k1,k1_avg);
    SetFooterCalcKDosGrid(cField_k2,k2_avg);
    SetFooterCalcKDosGrid(cField_k3,k3_avg);
    SetFooterCalcKDosGrid(cField_k4,k4_avg);
    SetFooterCalcKDosGrid(cField_k5,k5_avg);
    SetFooterCalcKDosGrid(cField_kgn,kgn_avg);

//    ChartToolBannerK1.Text:=Format('%s %s = %s',['Среднее значение','K1',FloatToStrRegion(k1_avg)]);
//    ChartToolBannerK2.Text:=Format('%s %s = %s',['Среднее значение','K2',FloatToStrRegion(k2_avg)]);
//    ChartToolBannerKgn.Text:=Format('%s %s = %s',['Среднее значение','Kgn',FloatToStrRegion(kgn_avg)]);
//    ChartToolBannerKS.Text:=Format('%s %s = %s',['Среднее значение','КС',FloatToStrRegion(ksi_avg)]);

    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_k1).Index].Footer.Value:=FloatToStrRegion(k1_avg);
    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_k2).Index].Footer.Value:=FloatToStrRegion(k2_avg);
    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_kgn).Index].Footer.Value:=FloatToStrRegion(kgn_avg);

    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cFieldKSI).Index].Footer.Value:=FloatToStrRegion(ksi_avg);

    DBGridEhCalcKDos.SelectedRows.Clear;
    DBGridEhCalcKDos.DataSource.DataSet.First;
    DBGridEhCalcKDos.SelectedRows.CurrentRowSelected:=true;

    Splash.Close;
  end
  else
    DropCalibrationParameters;

end;

procedure TMainForm.StartMeas(const Value: TProcessType);
begin
  if (TLD_CommandSeries.TLD_Mode = modeIdle) or (TLD_CommandSeries.TLD_Mode = modeNothing) then
        TLD_CommandSeries.SetCurrentProcess(cIdle)  // на случай если предыдущий процесс был оборван пользователем или для первичной инициализации
  else
  //if (TLD_CommandSeries.CurrentProcess <> cIdle) then
  begin
    //ShowMessage(Format(rsStopBeforeStart,[TLD_CommandSeries.CurrentProcessName]));
    TimerMessageDlg(rsCommonUITitle,Format(rsStopBeforeStart,[TLD_CommandSeries.CurrentProcessName]),mtInformation,[mbOK],5);
    Exit;
  end;
  TLDCommand.ChangeData.DosimeterFound := dsfNotFound; // Передача весточки в машину состояний

  JvDateTimePickerMeas.Date:=Date;

  if TLDDataModule.IsDBConnected then
  begin
    if not (TLDCommand.StartMeasuringFlag) then  // проверяем не запущено ли измерение
    begin
      if not Start then Start:=True;
      StartMeasureW.StartView:=Value;
    end
    else
      MessageDlg(rsMeasuring,mtWarning, [mbOK], 0);
  end
  else
  begin
    MessageDlg(Format('%s',[rsDBNoConnection]),mtWarning, [mbOK], 0);
    if Start then Start:=False;
    Exit;
  end;

  case Value of
    cStartSingleMeas,
    cStartSeriaMeas,
    cStartCalibration,
    cRegistration:
    begin
      TLD_CommandSeries.SetCurrentProcess(Value);  // Запуск процесса в машине состояний
      //TLD_CommandSeries.DeviceStartMeasures(0);
      StartMeasureW.Show;
    end;

    cBurning:
    begin
      StartBurning :=TStartBurning.Create(Nil);
      TLD_CommandSeries.TimerStop; //  Временная блокировка машины состояний
      try
        if StartBurning.ShowModal=mrOk then
          TLD_CommandSeries.SetCurrentProcess(Value);  // Запуск процесса в машине состояний
      finally
        TLD_CommandSeries.TimerGo; //  Восстановление машины состояний
        StartBurning.Free;
      end;
    end;

    cGrading:
    begin
      StartGrading :=TStartGrading.Create(Nil);
      TLD_CommandSeries.TimerStop; //  Временная блокировка машины состояний
      try
        if StartGrading.ShowModal=mrOk then
          TLD_CommandSeries.SetCurrentProcess(Value);  // Запуск процесса в машине состояний

        //if StartGrading.ShowModal<>mrOk then
        //  TLD_CommandSeries.CMD_CommonGoProcessNumber('',ord(modeIdle)); // включаем отмену по отмене
      finally
        TLD_CommandSeries.TimerGo; //  Восстановление машины состояний
        StartGrading.Free;
      end;
    end;

    cTesting:
    begin
      StartTesting;
    end;

    cIrradiation:
    begin
      StartIrradiation :=TStartIrradiation.Create(Nil);
      TLD_CommandSeries.TimerStop; //  Временная блокировка машины состояний
      try
        if StartIrradiation.ShowModal=mrOk then
          TLD_CommandSeries.SetCurrentProcess(Value);  // Запуск процесса в машине состояний
        //if StartIrradiation.ShowModal<>mrOk then
        //  TLD_CommandSeries.CMD_CommonGoProcessNumber('',ord(modeIdle)); // включаем отмену по отмене
      finally
        TLD_CommandSeries.TimerGo; //  Восстановление машины состояний
        StartIrradiation.Free;
      end;
    end;
  end;
end;

procedure TMainForm.BackMeasure;
var
  prevDosNumber: String;
begin
  if not (TLDCommand.StartMeasuringFlag) then // проверяем не запущено ли измерение
  begin
    case Dosimeter.TablePos of
      cTablePosStart,cTablePosFilter,cTablePosKSI,cTablePosD1:
      begin
        if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыдущей команды
        begin
          prevDosNumber:=StartMeasureW.CBoxDosList.Text;
          StartMeasureW.FirstStep;
          StartMeasureW.CBoxDosList.Text:=prevDosNumber;
          Dosimeter.TablePos:=cTablePosStart;
        end;
      end;
      cTablePosD2:
      begin
        if Dosimeter.DetectorsList[0]<>nil then
        begin
          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыдущей команды
          begin
            OnTLDDetsLoad(true);          // режим загрузки детекторов
            //if not TLDCommand.Emulator then TLDCommand.NNLoadD1;
            StartMeasureW.ChangeControls(cTablePosD1);
            dec(Dosimeter.TablePos);
          end;
        end
        else
        begin
          dec(Dosimeter.TablePos);
          BackMeasure;
        end;
      end;
      cTablePosD3:
      begin
        if Dosimeter.DetectorsList[1]<>nil then
        begin
          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыудущей команды
          begin
            OnTLDDetsLoad(true);          // режим загрузки детекторов
            //if not TLDCommand.Emulator then TLDCommand.NNLoadD2;
            StartMeasureW.ChangeControls(cTablePosD2);
            dec(Dosimeter.TablePos);
          end;
        end
        else
        begin
          dec(Dosimeter.TablePos);
          BackMeasure;
        end;
      end;
      cTablePosD4:
      begin
        if Dosimeter.DetectorsList[2]<>nil then
        begin
          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыудущей команды
          begin
            OnTLDDetsLoad(true);          // режим загрузки детекторов
            //if not TLDCommand.Emulator then TLDCommand.NNLoadD3;
            StartMeasureW.ChangeControls(cTablePosD3);
            dec(Dosimeter.TablePos);
          end;
        end
        else
        begin
          dec(Dosimeter.TablePos);
          BackMeasure;
        end;

      end;
      cTableMeasuring:
      begin

      end;
    end;
  end;
end;

procedure TMainForm.StartMeasure;
begin
  //if (Assigned(TLDCommand.COMPortSyn) AND TLDCommand.COMPortSyn.Connected) OR (TLDCommand.Emulator) then
  begin

    if not (TLDCommand.StartMeasuringFlag) then // проверяем не запущено ли измерение
    begin
      case Dosimeter.TablePos of
        cIrradiationD1:
        if (Dosimeter.DetectorsList[0]<>nil) then
        begin
          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then
          begin
            //TLDCommand.NNLoadD1;
            FStartSourceTestingTime:=Now;
            TimerSourceTest.Enabled:=true;
            inc(Dosimeter.TablePos);
          end;
        end
        else
        begin
          inc(Dosimeter.TablePos);
          StartMeasure;
        end;

        cIrradiationD2:
        if (Dosimeter.DetectorsList[1]<>nil) then
        begin
          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then
          begin
            //TLDCommand.NNLoadD2;
            FStartSourceTestingTime:=Now;
            TimerSourceTest.Enabled:=true;
            inc(Dosimeter.TablePos);
          end;
        end
        else
        begin
          inc(Dosimeter.TablePos);
          StartMeasure;
        end;

        cIrradiationD3:
        if (Dosimeter.DetectorsList[2]<>nil) then
        begin
          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then
          begin
            //TLDCommand.NNLoadD3;
            FStartSourceTestingTime:=Now;
            TimerSourceTest.Enabled:=true;
            inc(Dosimeter.TablePos);
          end;
        end
        else
        begin
          inc(Dosimeter.TablePos);
          StartMeasure;
        end;

        cIrradiationD4:
        if (Dosimeter.DetectorsList[3]<>nil) then
        begin
          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then
          begin
            //TLDCommand.NNLoadD4;
            FStartSourceTestingTime:=Now;
            TimerSourceTest.Enabled:=true;
            Dosimeter.TablePos:=cSource;
          end;
        end
        else
        begin
          inc(Dosimeter.TablePos);
          //TLDCommand.NNMeasuringD1;
          //TimerMeasure.Enabled:=True;
        end;

        cSource:
        if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then
        begin
          inc(Dosimeter.TablePos);
          //TLDCommand.NNMeasuringD1;
          //TimerMeasure.Enabled:=True;
        end;

        cTablePosStart:
        begin
          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предудущей команды
          begin
            if UseKFilter then // провкерка на установленную галочку "Использовать фильтр"
            begin
              OnTLDDetsLoad(true);
              StartMeasureW.ChangeControls(cTablePosFilter);
              inc(Dosimeter.TablePos);
            end
            else
            begin
              inc(Dosimeter.TablePos);                  // если фильтр не используется, то переходим на следующий шаг - считывание КС
              //StartMeasureW.BtnNext.Click;
            end;

          end;
        end;
        cTablePosFilter:
        begin
          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предудущей команды
          begin
            OnTLDDetsLoad(true);          // режим загрузки детекторов

            if StartMeasureW.StartView = cTesting then
            begin
              if FTestSourceUse then
                Dosimeter.TablePos:=cIrradiationD1
              else
                inc(Dosimeter.TablePos);

              TimerTest.Enabled:=true;
            end
            else
              inc(Dosimeter.TablePos);

            StartMeasureW.ChangeControls(cTablePosKSI);

            if not TLDCommand.Emulator then
              //TLDCommand.NNMeasuringKSI
            else
              OnReceiveKS(100);

          end;
        end;
        cTablePosKSI:
        begin
          if (Dosimeter.DetectorsList[0]<>nil) AND (StartMeasureW.StartView <> cTesting) then
          begin
            if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыдущей команды
            begin
              OnTLDDetsLoad(true);          // режим загрузки детекторов

              if not TLDCommand.Emulator then
                //TLDCommand.NNLoadD1;

              StartMeasureW.ChangeControls(cTablePosD1);
              inc(Dosimeter.TablePos);
            end;
          end
          else
          begin
            inc(Dosimeter.TablePos);
            StartMeasure;
          end;
        end;
        cTablePosD1:
        begin
          if (Dosimeter.DetectorsList[1]<>nil) AND (StartMeasureW.StartView <> cTesting)then
          begin
            if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыдущей команды
            begin
              OnTLDDetsLoad(true);          // режим загрузки детекторов
              //if not TLDCommand.Emulator then TLDCommand.NNLoadD2;
              StartMeasureW.ChangeControls(cTablePosD2);
              inc(Dosimeter.TablePos);
            end;
          end
          else
          begin
            inc(Dosimeter.TablePos);
            StartMeasure;
          end;
        end;
        cTablePosD2:
        begin
          if (Dosimeter.DetectorsList[2]<>nil) AND (StartMeasureW.StartView <> cTesting) then
          begin
            if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыдущей команды
            begin
              OnTLDDetsLoad(true);          // режим загрузки детекторов
              //if not TLDCommand.Emulator then TLDCommand.NNLoadD3;
              StartMeasureW.ChangeControls(cTablePosD3);
              inc(Dosimeter.TablePos);
            end;
          end
          else
          begin
            inc(Dosimeter.TablePos);
            StartMeasure;
          end;
        end;
        cTablePosD3:
        begin
          if (Dosimeter.DetectorsList[3]<>nil) AND (StartMeasureW.StartView <> cTesting) then
          begin
            if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыудущей команды
            begin
              OnTLDDetsLoad(true);          // режим загрузки детекторов
              //if not TLDCommand.Emulator then TLDCommand.NNLoadD4;
              StartMeasureW.ChangeControls(cTablePosD4);
              inc(Dosimeter.TablePos);
            end;
          end
          else
          begin
            inc(Dosimeter.TablePos);
            StartMeasure;
          end;
        end;
        cTablePosD4:
        begin
          if (StartMeasureW.StartView <> cTesting) then
          begin
            OnTLDDetsLoad(false);             // режим загрузки детекторов закончен
            if TLDCommand.Emulator then OnTLDDetsMeas(true);
            //TimerMeasure.Enabled:=True;
            Dosimeter.TablePos:=cTablePosStart;

            if StartMeasureW.Showing then StartMeasureW.Close;

            case StartMeasureW.StartView of
              cStartSeriaMeas,cStartCalibration,cIrradiation,cRegistration:      // уточнить - переделать
                StartMeasureW.SetCommentInQueueFile(Dosimeter.FullNumber);
              //cStartCalibration:
                //StartMeasureW.AddDosToCalibrationFile(Dosimeter.FullNumber);
            end;
          end
          else
          begin
            sleep (1000);
            //TimerMeasure.Enabled:=True;
          end;

        end;
        cTableMeasuring:
        begin
  //        StartMeasureW.LblCurrentStep.Visible:=false;
  //        StartMeasureW.JvSpeedBtnSkip.Visible:=false;
  //        StartMeasureW.BtnCancel.Visible:=false;
  //        StartMeasureW.BtnNext.Visible:=false;
  //        Dosimeter.TablePos:=cTablePosStart;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.StartTesting;
var
  i: integer;
begin
  StartMeasureW.StartView:=cTesting;
  TLD_CommandSeries.SetCurrentProcess(cTesting);  //  { #todo -oЧернышев : организовать запуск процедуры тестирования }

  if not TLDDataModule.IsDosimeterExist(FTestSourceDosimeterName) then
  begin
    if not TLDDataModule.IsDosimeterTypeExist(cTestDosTypeName) then
      TLDDataModule.InsertTestDosType(cTestDosTypeName);

    TLDDataModule.InsertTestDos(FTestSourceDosimeterName);
  end;

  if Assigned(Dosimeter) then FreeAndNil(Dosimeter);

  Dosimeter:=TDosimeter.Create(FTestSourceDosimeterName);
  HideDetectorsPanel(MainForm.GetDetCnt(MainForm.Dosimeter.DosType));
  Dosimeter.OnChangeFullNumber(Self);
  Dosimeter.OnChangeValidity(Self);
  Dosimeter.OnChangeDose(Self);
  Dosimeter.OnChangeErr(Self);
  Dosimeter.OnChangeStatus(Self);
  Dosimeter.OnChangeDoseType(Self);
  Dosimeter.OnChangeKS(Self);
  Dosimeter.OnChangeK(Self);
  Dosimeter.OnChangeKFilter(Self);
  Dosimeter.OnChangeKDevice(Self);
  Dosimeter.OnChangeFormula(Self);
  Dosimeter.OnChangeMeasTime(Self);
  Dosimeter.OnChangeVerTime(Self);
  Dosimeter.OnChangePersNumber(Self);
  Dosimeter.OnChangeOrganization(Self);
  Dosimeter.OnChangeDepartment(Self);
  Dosimeter.OnChangeFio(Self);
  Dosimeter.OnShowTempProfileWrite(Self);

  if UseControlComment then
    if FTestSourceUse AND FTestSourceTimeIncrease then
      Dosimeter.MeasComment:=Format('%d',[FTestSourceTime])
      //Dosimeter.MeasComment:=Format('%s %d %s',[ControlComment,FTestSourceTime,'sec'])
    else
      Dosimeter.MeasComment:=Format('%s',[ControlComment])
  else
    Dosimeter.MeasComment:=Format('%s %s',[rsTestStarted,DateTimeToStr(FStartTestingCommentTime)]);

  for i:=0 to Dosimeter.DetectorsList.Count-1 do
    if Assigned(TDetector(Dosimeter.DetectorsList[i])) then TDetector(Dosimeter.DetectorsList[i]).State:=stDetWaitMeas;

  Dosimeter.TablePos:=cTablePosFilter;
  //TLDCommand.NNSource;
  FStartTestingTime:=Now;
  TimerTest.Enabled:=true;

  if not Start then Start:=True;

end;

procedure TMainForm.SaveDetTXTResults(aName: String);
var
  fullPath  : String;
  fileName  : String;
  myFile    : TextFile;
  Temp      : double;
  i         : integer;
begin
  fullPath:=extractfilepath(Application.ExeName)+cFolderMeasurements+PathDelim+'DozaTLD_№'+IntToStr(DeviceID);

  if not DirectoryExists(fullPath) then ForceDirectories(fullPath);

  fileName:=fullPath+PathDelim+aName+cExtTXT;

  AssignFile(myFile, fileName);
  ReWrite(myFile);

  for i := 0 to Length(TLDCommand.ImpulseResult)-1 do
  begin
    Temp := TLDCommand.TempResult[i]/10;  // температура в пирборе хранится десятых градуса, поэтому делим на 10
    WriteLn(myFile,IntToStr(i+1)+' '+IntToStr(TLDCommand.ImpulseResult[i])+' '+FloatToStrRegion(Temp));
  end;

  CloseFile(myFile);
end;

procedure TMainForm.SaveDosTXTResults(aName: String; Path: String);
var
  fileName    : String;
  myFile      : TextFile;
  data        : String;
  i,j         : integer;
  ts          : TStringList;
begin
  if Assigned(Dosimeter) then
  begin
    for i := 0 to Dosimeter.DetectorsList.Count-1 do
    begin
      if Assigned(Dosimeter.DetectorsList[i]) then
      begin

        fileName := Path+PathDelim+aName+'_d'+IntToStr(i+1)+'.txt';
        AssignFile(myFile, fileName);
        ReWrite(myFile);

        data:=TDetector(Dosimeter.DetectorsList[i]).Ktv;

        if data<>'{}' then
        begin
          ts:=TStringList.Create;
          ts.Delimiter:=',';                                        // устанавливаем разделитель
          ts.DelimitedText:=data;
          ts.Text:=StringReplace(ts.Text,'{','',[rfreplaceall]);    // удаляем фигурные скобки
          ts.Text:=StringReplace(ts.Text,'}','',[rfreplaceall]);

          if ts.Count>0 then
          begin
            for j := 0 to ts.Count-1 do
              WriteLn(myFile,IntToStr(i+1)+' '+ts[j]+' ');
          end;

          ts.Free;

        end;

        CloseFile(MyFile);

      end;
    end;
  end;

end;

procedure TMainForm.SaveFilterBoolIni(ParameterName: String; Value: boolean);
var
  ConfigIni: TInifile;
begin
  ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    ConfigIni.WriteBool(cSectionFilter, ParameterName, Value);
  finally
    ConfigIni.Free;
  end;
end;

procedure TMainForm.SaveFilterDateIni(ParameterName: String; Value: String);
const
  cGap = ' ';
var
  ConfigIni: TInifile;
begin
  ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    ConfigIni.WriteString(cSectionFilter, ParameterName, Value);
  finally
    ConfigIni.Free;
  end;
end;

procedure TMainForm.SaveFilterTextIni(Section: String; ParameterName: String;
  Value: String);
var
  ConfigIni: TInifile;
begin
  ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    ConfigIni.WriteString(Section, ParameterName, Value);
  finally
    ConfigIni.Free;
  end;
end;

procedure TMainForm.SaveGridsParametersCalibr;
begin
  DBGridEhCalcKDos.SaveColumnsLayoutIni(extractfilepath(Application.ExeName)+cConfigFile,cSectionGridCalibr,false);
end;

procedure TMainForm.SaveGridsParametersDos;
begin
  DBGridEhDos.SaveColumnsLayoutIni(extractfilepath(Application.ExeName)+cConfigFile,cSectionGridDos,false);
end;

procedure TMainForm.SaveGridsParametersMeas;
begin
  DBGridEhOnlyMeas.SaveColumnsLayoutIni(extractfilepath(Application.ExeName)+cConfigFile,cSectionGridMeas,true);
end;

procedure TMainForm.SaveGridsParametersProcess;
begin
  DBGridEhProcess.SaveColumnsLayoutIni(extractfilepath(Application.ExeName)+cConfigFile,cSectionGridProcess,false);
end;

procedure TMainForm.TimerOpenAddDosParTimer(Sender: TObject);
const
  OffsetX: array[Boolean] of Integer = (-10, 10);
begin
//  JvPanelAdditionDosPar.Height := JvPanelAdditionDosPar.Height + OffsetX[FOpenAddDosParPanel];
//  TimerOpenAddDosPar.Enabled := not ((JvPanelAdditionDosPar.Height >= 84) or (JvPanelAdditionDosPar.Height = 0));
//
//  PanelMeasuringResize(Self);
end;

procedure TMainForm.TimerOpenFilterTimer(Sender: TObject);
const
  OffsetX: array[Boolean] of Integer = (-10, 10);
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      PanelMeasLeftFilter.Height := PanelMeasLeftFilter.Height + OffsetX[FOpenFilterMeasPanel];
      TimerOpenFilter.Enabled := not ((PanelMeasLeftFilter.Height >= FFilterPanelHeight) or (PanelMeasLeftFilter.Height <= 1));
    end;
    cPageProcessIndex:
    begin
      PanelProcessLeftFilter.Height := PanelProcessLeftFilter.Height + OffsetX[FOpenFilterProcessPanel];
      TimerOpenFilter.Enabled := not ((PanelProcessLeftFilter.Height >= FFilterPanelHeight) or (PanelProcessLeftFilter.Height <= 1));
    end;
    cPageDosIndex:
    begin
      PanelDosLeftFilter.Height := PanelDosLeftFilter.Height + OffsetX[FOpenFilterDosPanel];
      TimerOpenFilter.Enabled := not ((PanelDosLeftFilter.Height >= FFilterDosPanelHeight) or (PanelDosLeftFilter.Height <= 1));
    end;
    cPageCalibrationIndex:
    begin
      PanelCalibrLeftFilter.Height := PanelCalibrLeftFilter.Height + OffsetX[FOpenFilterCalibrPanel];
      TimerOpenFilter.Enabled := not ((PanelCalibrLeftFilter.Height >= FFilterCalibrPanelHeight) or (PanelCalibrLeftFilter.Height <= 1));
    end;
  end;
end;

procedure TMainForm.TimerSourceTestTimer(Sender: TObject);
begin
  if SecondsBetween(FStartSourceTestingTime,Now)>FTestSourceTime then
  begin
    if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then
    begin
      TimerSourceTest.Enabled:=false;
      StartMeasure;
    end
  end;
end;

procedure TMainForm.TimerTestTimer(Sender: TObject);
const
  delay = 10;
begin
  if SecondsBetween(FStartTestingTime,Now)<delay then
  begin
    if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then
    begin
      TimerTest.Enabled:=false;
      StartMeasure;
    end
  end
  else
  begin
    TimerTest.Enabled:=false;
    SpeedBtnStopClick(Self);
  end;
end;

procedure TMainForm.TabSheetDeviceControlShow(Sender: TObject);
var
  comList: TStringList;
begin
  if not Assigned(TLDCommand) then Exit;

  ReadTLDSettings;

  comList:=TStringList.Create;
  comList.CommaText:=SetW.GetComPorts;

  ComboBoxPortNumber.Items:=comList;
  ComboBoxPortNumber.Items.Add(cEmulator);

  comList.Free;

//  раскоментировать при работе с живым COM-портом
  ComboBoxPortNumber.ItemIndex := ComboBoxPortNumber.Items.IndexOf(TLDCommand.COM);

  if ComboBoxPortNumber.Text<>cEmulator then
  begin
    //ComboBoxBoudRate.ItemIndex:=ComboBoxBoudRate.Items.IndexOf(IntToStr(TLDCommand.BaudRate));
    //ComboBoxStopBit.ItemIndex:=TLDCommand.StopBits;
    //ComboBoxParity.ItemIndex:=TLDCommand.Parity;
    BtnClearPort.Enabled:=true;
    if TLDCommand.ConnectedPort then
      LblComState.Caption:=rsOpenPort
    else
      LblComState.Caption:=rsCantOpenPort;
  end
  else
  begin
    //ComboBoxBoudRate.ItemIndex:=-1;
    //ComboBoxStopBit.ItemIndex:=-1;
    //ComboBoxParity.ItemIndex:=-1;

    BtnClearPort.Enabled:=false;
    LblComState.Caption:=rsEmulator;
  end;
end;

procedure TMainForm.TabSheetMeasProcessingShow(Sender: TObject);
begin
  PageControlProcessDosPar.ActivePage:=PGProcessPage_TSMainPar;
end;

procedure TMainForm.TabSheetMeasShow(Sender: TObject);
begin
  PageControlMeasDosPar.ActivePage:=PGMeasPage_TSMainPar;
end;

procedure TMainForm.TimerMeasureTimer(Sender: TObject);
//const
//  cBorderChannel = 100;
begin
//  Exit;
//
//  if not (TLDCommand.StartMeasuringFlag) then // ждем пока закончится измерение, если оно уже начато
//  begin
//    if (Dosimeter.MeasurementID = 0) then
//    begin
//      try
//        CreateDosimeterData; // добавление новой (чистой) записи в таблицу результатов измерений
//        UpdateGridMeasPage;
//      except
//        on E: exception do
//        begin
//          SpeedBtnStopClick(Self);
//          MessageDlg(E.Message,mtError, [mbOK], 0);
//        end;
//      end;
//    end;
//
//    if Assigned(Dosimeter) then
//    begin
//
//      if TLDCommand.TLDReset then
//      begin
//        TLDCommand.TLDReset:=false;
//        FWorkingTime:=0;
//        CntD:=0;
//
//        if Dosimeter.CntDetector.ReadedPoints>cBorderChannel then
//        begin
//          CntD:=3;
//          case Dosimeter.DetectorsCnt of
//            cStepDosMeasD1:
//            begin
//              Dosimeter.CntDetector.State:=stDetMeasStopped;
//              DetectorProcessing(EditMeasDataD1Status,StartMeasureW.EditPageMeasStatusD1,GaugeMeasDataD1,StartMeasureW.GaugePageMeasStatusD1,cDetPos1);
//            end;
//            cStepDosMeasD2:
//            begin
//              Dosimeter.CntDetector.State:=stDetMeasStopped;
//              DetectorProcessing(EditMeasDataD2Status,StartMeasureW.EditPageMeasStatusD2,GaugeMeasDataD2,StartMeasureW.GaugePageMeasStatusD2,cDetPos2);
//            end;
//            cStepDosMeasD3:
//            begin
//              Dosimeter.CntDetector.State:=stDetMeasStopped;
//              DetectorProcessing(EditMeasDataD3Status,StartMeasureW.EditPageMeasStatusD3,GaugeMeasDataD3,StartMeasureW.GaugePageMeasStatusD3,cDetPos3);
//            end;
//            cStepDosMeasD4:
//            begin
//              Dosimeter.CntDetector.State:=stDetMeasStopped;
//              DetectorProcessing(EditMeasDataD4Status,StartMeasureW.EditPageMeasStatusD4,GaugeMeasDataD4,StartMeasureW.GaugePageMeasStatusD4,cDetPos4);
//            end;
//            //cStepDosMeasFinished:
//          end;
//        end
//        else
//        begin
//          case Dosimeter.DetectorsCnt of
//            cStepDosMeasD1:
//            begin
//              SeriesMeasD1KTV.Clear;
//              SeriesMeasD1Temp.Clear;
//            end;
//            cStepDosMeasD2:
//            begin
//              SeriesMeasD2KTV.Clear;
//              SeriesMeasD2Temp.Clear;
//            end;
//            cStepDosMeasD3:
//            begin
//              SeriesMeasD3KTV.Clear;
//              SeriesMeasD3Temp.Clear;
//            end;
//            cStepDosMeasD4:
//            begin
//              SeriesMeasD4KTV.Clear;
//              SeriesMeasD4Temp.Clear;
//            end;
//          end;
//        end;
//      end;
//
//      case Dosimeter.DetectorsCnt of
//        cStepDosMeasD1: // измерение детектора 1
//        begin
//          if (Dosimeter.DetectorsList[Dosimeter.DetectorsCnt] <> nil) then // проверяем наличие детектора в данной позиции типа дозиметра
//          begin
//
//            CalcForm.SetDefaultOptions(TDetector(Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]));
//
//            TDetector(Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]).N1:=StrToFloatRegion(OptionsForm.Edit_DefaultN1.Text);
//            TDetector(Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]).N2:=StrToFloatRegion(OptionsForm.Edit_DefaultN2.Text);
//
//            case Dosimeter.CntDetector.State of
//              stDetWaitMeas,stDetMeasInProgress:
//              begin
//                DetectorProcessing(EditMeasDataD1Status,StartMeasureW.EditPageMeasStatusD1,GaugeMeasDataD1,StartMeasureW.GaugePageMeasStatusD1,cDetPos1);
//              end;
//              stDetLost,stDetBroken,stDetSkiped:
//              begin
//                SkipDetector(cDetPos1,Dosimeter.CntDetector.State);
//              end;
//            end;
//
//          end
//          else if not TLDCommand.StartMeasuringFlag then                  // если в типе дозиметра на этой позиции нет детектора
//            inc(Dosimeter.DetectorsCnt);                                  // увеличиваем счетчик детекторов и переходим к следующему
//
//        end;
//        cStepDosMeasD2: // измерение детектора 2
//        begin
//          if (Dosimeter.DetectorsList[Dosimeter.DetectorsCnt] <> nil) then // проверяем наличие детектора в данной позиции типа дозиметра
//          begin
//
//            CalcForm.SetDefaultOptions(TDetector(Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]));
//
//            case Dosimeter.CntDetector.State of
//              stDetWaitMeas,stDetMeasInProgress:
//              begin
//                DetectorProcessing(EditMeasDataD2Status,StartMeasureW.EditPageMeasStatusD2,GaugeMeasDataD2,StartMeasureW.GaugePageMeasStatusD2,cDetPos2);
//              end;
//              stDetLost,stDetBroken,stDetSkiped:
//              begin
//                SkipDetector(cDetPos2,Dosimeter.CntDetector.State);
//              end;
//            end;
//
//          end
//          else if not TLDCommand.StartMeasuringFlag then                  // если в типе дозиметра на этой позиции нет детектора
//            inc(Dosimeter.DetectorsCnt);                                  // увеличиваем счетчик детекторов и переходим к следующему
//
//        end;
//        cStepDosMeasD3: // измерение детектора 3
//        begin
//          if (Dosimeter.DetectorsList[Dosimeter.DetectorsCnt] <> nil) then // проверяем наличие детектора в данной позиции типа дозиметра
//          begin
//
//            CalcForm.SetDefaultOptions(TDetector(Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]));
//
//            case Dosimeter.CntDetector.State of
//              stDetWaitMeas,stDetMeasInProgress:
//              begin
//                DetectorProcessing(EditMeasDataD3Status,StartMeasureW.EditPageMeasStatusD3,GaugeMeasDataD3,StartMeasureW.GaugePageMeasStatusD3,cDetPos3);
//              end;
//              stDetLost,stDetBroken,stDetSkiped:
//              begin
//                SkipDetector(cDetPos3,Dosimeter.CntDetector.State);
//              end;
//            end;
//
//          end
//          else if not TLDCommand.StartMeasuringFlag then                   // если в типе дозиметра на этой позиции нет детектора
//            inc(Dosimeter.DetectorsCnt);                                   // увеличиваем счетчик детекторов и переходим к следующему
//
//        end;
//        cStepDosMeasD4: // измерение детектора 4
//        begin
//          if (Dosimeter.DetectorsList[Dosimeter.DetectorsCnt] <> nil) then // проверяем наличие детектора в данной позиции типа дозиметра
//          begin
//
//            CalcForm.SetDefaultOptions(TDetector(Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]));
//
//            case Dosimeter.CntDetector.State of
//              stDetWaitMeas,stDetMeasInProgress:
//              begin
//                DetectorProcessing(EditMeasDataD4Status,StartMeasureW.EditPageMeasStatusD4,GaugeMeasDataD4,StartMeasureW.GaugePageMeasStatusD4,cDetPos4);
//              end;
//              stDetLost,stDetBroken,stDetSkiped:
//              begin
//                SkipDetector(cDetPos4,Dosimeter.CntDetector.State);
//              end;
//            end;
//
//          end
//          else if not TLDCommand.StartMeasuringFlag then                   // если в типе дозиметра на этой позиции нет детектора
//            inc(Dosimeter.DetectorsCnt);                                   // увеличиваем счетчик детекторов и переходим к следующему
//
//        end;
//        cStepDosMeasFinished: // измерение дозиметра завершено
//        begin
//          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыдущей команды
//          begin
//            Dosimeter.MeasTime:=Now;
//            Dosimeter.Validity:=Dosimeter.GetDosimeterValidity;
////            Dosimeter.Error:=FloatToStrRegion(Dosimeter.CalcErr);
//            Dosimeter.LastMeasComment:='';
//
//            Dosimeter.CalcDose;
//
//            Dosimeter.DetectorsCnt:=0;
//
//            SaveDosimeterData;
//
//            OnCommandLog(TimeToStr(Now)+' : -> ',format(rsMeasurementDone,[Dosimeter.FullNumber]),'',cMsgInf,cMsgPriorityInf);
//
//            TimerMeasure.Enabled:=False;
//            Start:=False;
//
//            if SpeedBtnMeasSaveParam.Enabled then SpeedBtnMeasSaveParam.Click;
//            if SpeedBtnMeasSaveIDK.Enabled then SpeedBtnMeasSaveIDK.Click;
//
//            JvDateTimePickerMeas.Date:=Date;
//            UpdateGridMeasAndProcessPages;                  // вызовы после каждого измерения жрут память
//            UpdateDataDosFilter(FilterDosDosNumber);        // вызовы после каждого измерения жрут память
// {
//            case StartMeasureW.StartView of
//              cStartSingleMeas   : StartMeas(cStartSingleMeas);
//              cStartSeriaMeas    :
//              begin
//                StartMeasureW.SetFinishMeasInQueueFile(Dosimeter.FullNumber);
//                StartMeas(cStartSeriaMeas);
//              end;
//              cStartCalibration :
//              begin
//                case StartMeasureW.CBoxRadType.ItemIndex of
//                  0:  TLDDataModule.SendMeasToCalibr(IntToStr(Dosimeter.MeasurementID),StartMeasureW.CalibrSourceDose,cRadTypeGamma);
//                  1:  TLDDataModule.SendMeasToCalibr(IntToStr(Dosimeter.MeasurementID),StartMeasureW.CalibrSourceDose,cRadTypeNeutron);
//                end;
//
//                //StartMeasureW.SetKDosInCalibrationFile(StartMeasureW.CalcKDos);
//
//                UpdateGridCalibrPage;
//                StartMeasureW.SetFinishMeasInQueueFile(Dosimeter.FullNumber);
//                StartMeas(cStartCalibration);
//              end;
//              cTesting:
//              begin
//                if AutoReset then
//                begin
//                  //TLDCommand.NNRestart;
//                  sleep(5000);
//                end;
//
//                if FTestSourceTimeIncrease then
//                begin
//                  if FTestSourceTimeCurrentCycle>=FTestSourceTimeIncreaseCycle then
//                  begin
//                    FTestSourceTime:=Round(FTestSourceTime*FTestSourceKIncrease);
//                    FTestSourceTimeCurrentCycle:=1;
//                  end
//                  else
//                   inc(FTestSourceTimeCurrentCycle);
//                end;
//
//                StartMeas(cTesting);
//              end;
//            end;
//}
//
//          end;
//        end;
//      end;
//    end;
//  end;
end;

procedure TMainForm.DetectorProcessing(EditStatus,EditStatusMeas: TEdit; Gauge,GaugeMeas: TATGauge; DetPos: integer);
var
  emulatorFullPathFile  : string;
  emulatorFileName      : string;
  emulatorPath          : string;
  measFullPathFile      : string;
  measFileName          : string;
  measPath              : string;
  openFilePath          : string;
  procedure SetDosValidity(aDetPos: integer; aDetValidity: TDetectorState);
  begin
    case GetDetState(aDetValidity) of
      cDetMeasInProgress:
      begin
        case aDetPos of
          cDetPos1:
          begin
            Dosimeter.Validity:=stDosMeasInProgressD1;
          end;
          cDetPos2:
          begin
            Dosimeter.Validity:=stDosMeasInProgressD2;
          end;
          cDetPos3:
          begin
            Dosimeter.Validity:=stDosMeasInProgressD3;
          end;
          cDetPos4:
          begin
            Dosimeter.Validity:=stDosMeasInProgressD4;
          end;
        end;
      end;
      cDetMeasFinished:
      begin
        case aDetPos of
          cDetPos1:
          begin
            Dosimeter.Validity:=stDosMeasFinishedD1;
          end;
          cDetPos2:
          begin
            Dosimeter.Validity:=stDosMeasFinishedD2;
          end;
          cDetPos3:
          begin
            Dosimeter.Validity:=stDosMeasFinishedD3;
          end;
          cDetPos4:
          begin
            Dosimeter.Validity:=stDosMeasFinishedD4;
          end;
        end;
      end;
      cDetMeasStopped:
      begin
        case aDetPos of
          cDetPos1:
          begin
            Dosimeter.Validity:=stDosMeasStoppedD1;
          end;
          cDetPos2:
          begin
            Dosimeter.Validity:=stDosMeasStoppedD2;
          end;
          cDetPos3:
          begin
            Dosimeter.Validity:=stDosMeasStoppedD3;
          end;
          cDetPos4:
          begin
            Dosimeter.Validity:=stDosMeasStoppedD4;
          end;
        end;
      end;
    end;
  end;
begin
  //if (Assigned(TLDCommand.COMPortSyn) AND (TLDCommand.COMPortSyn.Connected)) OR (TLDCommand.Emulator)  then
  begin
    case CntD of
      0: // поворот стола в позицию измерения детектора
      begin
        if (FWorkingTime<=TLDCommand.WorkingTime) then
        begin

          FWorkingTime:=TLDCommand.WorkingTime;

          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыдущей команды
          begin
            case DetPos of
              1:
              begin
                //if not TLDCommand.Emulator then TLDCommand.NNMeasuringD1;
                Dosimeter.Validity:=stDosWaitMeasD1;
              end;
              2:
              begin
                //if not TLDCommand.Emulator then TLDCommand.NNMeasuringD2;
                Dosimeter.Validity:=stDosWaitMeasD2;
              end;
              3:
              begin
                //if not TLDCommand.Emulator then TLDCommand.NNMeasuringD3;
                Dosimeter.Validity:=stDosWaitMeasD3;
              end;
              4:
              begin
                //if not TLDCommand.Emulator then TLDCommand.NNMeasuringD4;
                Dosimeter.Validity:=stDosWaitMeasD4;
              end;
            end;

            inc(CntD);
          end;
        end
        else
        begin
          if not TLDCommand.Emulator then
          begin
            OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s. %s',[rsHardResetFound,'Поворот стола']),'', cMsgInf,cMsgPriorityInf);
            TLDCommand.SavedWorkingTime:=0;
            FWorkingTime:=0;
          end;
        end;
      end;
      1: // запись температурного профиля детектора
      begin
        if (FWorkingTime<=TLDCommand.WorkingTime) then
        begin

          FWorkingTime:=TLDCommand.WorkingTime;

          if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then  // проверка состояния выполнения предыдущей команды
          begin
            //if not TLDCommand.Emulator then TLDCommand.NNWriteTempProfileP1(Dosimeter.CntDetector.TempProfile,Dosimeter.CntDetector.K1Profile,Dosimeter.CntDetector.K2Profile);
            inc(CntD);
          end;
        end
        else
        begin
          if not TLDCommand.Emulator then
          begin
            OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s. %s',[rsHardResetFound,rsSaveTemperatures]),'', cMsgInf,cMsgPriorityInf);
            TLDCommand.SavedWorkingTime:=0;
            FWorkingTime:=0;
            CntD:=0;
          end;
        end;
      end;
      2: // начать измерение детектора
      begin
        if (FWorkingTime<=TLDCommand.WorkingTime) then
        begin

          FWorkingTime:=TLDCommand.WorkingTime;

          if ((TLDCommand.StoveTemp < TLDCommand.cMaxStartMeasureTemp) and (TLDCommand.CmdIsDone)) OR (TLDCommand.Emulator) then  // проверяем теущую температуру печки, еcли меньше 70C и предыдущая команда выполнена - запускаем измерение
          begin
            if not TLDCommand.Emulator then
              //TLDCommand.NNStartMeasuring                              // команда - начать измерение
            else
            begin
              //TLDCommand.NNStartMeasuring;

              //emulatorFileName:=Dosimeter.FullNumber+' '+'Detector'+IntToStr(Dosimeter.DetectorsCnt+1)+cExtTXT;
              emulatorFileName:=DateTimeToStr_Format(Now)+'_'+Dosimeter.FullNumber+'_'+'Detector'+IntToStr(Dosimeter.DetectorsCnt+1)+cExtTXT;
              emulatorPath:=extractfilepath(Application.ExeName)+cFolderEmulator+PathDelim;
              emulatorFullPathFile:=emulatorPath+emulatorFileName;

              if FileExists(emulatorFullPathFile) then
              begin
                if EmulatorLoadResults(emulatorFullPathFile) then EmulatorResults;
              end
              else
              begin
                //TimerMeasure.Enabled:=False;

                //emulatorFileName:=Dosimeter.FullNumber+' '+'Detector'+IntToStr(Dosimeter.DetectorsCnt+1)+cExtTXT;
                //emulatorPath:=extractfilepath(Application.ExeName)+cFolderEmulator+PathDelim;
                //emulatorFullPathFile:=emulatorPath+emulatorFileName;
                measFileName:=DateTimeToStr_Format(Now)+'_'+Dosimeter.FullNumber+'_'+'Detector'+IntToStr(Dosimeter.DetectorsCnt+1)+cExtTXT;
                measPath:=extractfilepath(Application.ExeName)+cFolderMeasurements+'\';
                measFullPathFile:=measPath+measFileName;

                //OpenDialogDeviceSettings.InitialDir:=emulatorPath;
                if OpenDialogDeviceSettings.InitialDir = '' then
                   OpenDialogDeviceSettings.InitialDir:=measPath;

                if OpenDialogDeviceSettings.Execute then
                begin
                  openFilePath:=OpenDialogDeviceSettings.FileName;
                  CopyFile(PChar(openFilePath),PChar(emulatorFullPathFile),false);

                  if EmulatorLoadResults(emulatorFullPathFile) then EmulatorResults;
                end;

                //TimerMeasure.Enabled:=True;
              end;

            end;

            EditStatus.Visible:=False;
            Gauge.Progress:=0;
            Gauge.Visible:=True;

            if StartMeasureW.Showing then
            begin
              EditStatusMeas.Visible:=False;
              GaugeMeas.Progress:=0;
              GaugeMeas.Visible:=True;
            end;

            Dosimeter.CntDetector.State:=stDetMeasInProgress;

            SetDosValidity(DetPos,stDetMeasInProgress);
//            case DetPos of
//              1:
//              begin
//                Dosimeter.Validity:=stDosMeasInProgressD1;
//              end;
//              2:
//              begin
//                Dosimeter.Validity:=stDosMeasInProgressD2;
//              end;
//              3:
//              begin
//                Dosimeter.Validity:=stDosMeasInProgressD3;
//              end;
//              4:
//              begin
//                Dosimeter.Validity:=stDosMeasInProgressD4;
//              end;
//            end;

            inc(CntD);
          end;
        end
        else
        begin
          if not TLDCommand.Emulator then
          begin
            OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s. %s',[rsHardResetFound,rsSmStoveCooling]),'', cMsgInf,cMsgPriorityInf);
            TLDCommand.SavedWorkingTime:=0;
            FWorkingTime:=0;
            CntD:=0;
          end;
        end;
      end;
      3: // сохранить измерение детектора
      begin
        FWorkingTime:=TLDCommand.WorkingTime;

        if (TLDCommand.CmdIsDone) OR (TLDCommand.Emulator) then
        begin
          EditStatus.Visible:=True;
          Gauge.Visible:=False;

          OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsSrcData,rsD,DetPos,rsGot]),'', cMsgInf,cMsgPriorityInf);

          SaveDetTXTResults(Format('%s_%s_%s_%s%d',[DateTimeToStr_Format(Now),'Dosimeter',Dosimeter.FullNumber,'Detector',DetPos]));  // сохранение результатов узмерений детектора в текстовом файле

          InsertDetectorKtvTmp(DetPos);     // запись в БД значений считанных КТВ и температурного профиля

          OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsSrcData,rsD,DetPos,rsSaveToDB]),'', cMsgInf,cMsgPriorityInf);

          if Dosimeter.CntDetector.State<>stDetMeasStopped then
          begin
            SetDosValidity(DetPos,stDetMeasFinished);
            Dosimeter.CntDetector.State:=stDetMeasFinished;

            CalcDetectorDose;                 // запуск расчета

            OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsData,rsD,DetPos,rsCalculated]),'', cMsgInf,cMsgPriorityInf);
            ShowCalcFunctions(DetPos);        // отображение расчетных кривых
            OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsData,rsD,DetPos,rsShowed]),'', cMsgInf,cMsgPriorityInf);
            UpdateDetectorMeasData(DetPos);   // обновление и запись расчетных данных в БД
            OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsData,rsD,DetPos,rsSaveToDB]),'', cMsgInf,cMsgPriorityInf);
          end
          else
          begin
            SetDosValidity(DetPos,stDetMeasStopped);
          end;

          inc(Dosimeter.DetectorsCnt);      // увеличиваем счетчик детекторов
          CntD:=0;                          // сброс счетчика

          // обнуление массивов после окончания измерения
          FillChar(TLDCommand.TempResult, SizeOf(TLDCommand.TempResult), #0);
          FillChar(TLDCommand.ImpulseResult, SizeOf(TLDCommand.ImpulseResult), #0);
        end;
      end;
    end;
  end;
  //else
  //  OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s',[rsLostConnectionWhenMeasure]),'', cMsgInf,cMsgPriorityInf);
end;

procedure TMainForm.DropCalibrationParameters;
var
  i: integer;
begin
  CalibrationPressed:=false;

  DateTimePickerCalibr.Date:=Date;

  if LblDotK1_Calibr.Visible then LblDotK1_Calibr.Visible:=false;
  if LblDotK2_Calibr.Visible then LblDotK2_Calibr.Visible:=false;
  if LblDotK3_Calibr.Visible then LblDotK3_Calibr.Visible:=false;
  if LblDotK4_Calibr.Visible then LblDotK4_Calibr.Visible:=false;
  if LblDotK5_Calibr.Visible then LblDotK5_Calibr.Visible:=false;
  if LblDotKgn_Calibr.Visible then LblDotKgn_Calibr.Visible:=false;

  if LblK_1_Calibr.Visible then LblK_1_Calibr.Visible:=false;
  if LblK_2_Calibr.Visible then LblK_2_Calibr.Visible:=false;
  if LblK_3_Calibr.Visible then LblK_3_Calibr.Visible:=false;
  if LblK_4_Calibr.Visible then LblK_4_Calibr.Visible:=false;
  if LblK_5_Calibr.Visible then LblK_5_Calibr.Visible:=false;
  if LblK_gn_Calibr.Visible then LblK_gn_Calibr.Visible:=false;

  if EditK_1_Calibr.Visible then EditK_1_Calibr.Visible:=false;
  if EditK_2_Calibr.Visible then EditK_2_Calibr.Visible:=false;
  if EditK_3_Calibr.Visible then EditK_3_Calibr.Visible:=false;
  if EditK_4_Calibr.Visible then EditK_4_Calibr.Visible:=false;
  if EditK_5_Calibr.Visible then EditK_5_Calibr.Visible:=false;
  if EditK_gn_Calibr.Visible then EditK_gn_Calibr.Visible:=false;

  EditKSAvg.Text:='';

  UpdateGridCalibrationFilter(FilterCalibrDosNumber);

  for i := 0 to ChartK1Dos.SeriesCount-1 do TlineSeries(ChartK1Dos.Series[i]).Clear;
  for i := 0 to ChartK2Dos.SeriesCount-1 do TlineSeries(ChartK2Dos.Series[i]).Clear;
  for i := 0 to ChartKgnDos.SeriesCount-1 do TlineSeries(ChartKgnDos.Series[i]).Clear;
  for i := 0 to ChartKSDos.SeriesCount-1 do TlineSeries(ChartKSDos.Series[i]).Clear;

//  ChartToolBannerK1.Text:='';
//  ChartToolBannerK2.Text:='';
//  ChartToolBannerKgn.Text:='';
//  ChartToolBannerKS.Text:='';

  for i := 0 to PanelCalibrChartK.PageCount-1 do
    PanelCalibrChartK.Pages[i].TabVisible:=false;

end;

procedure TMainForm.SkipDetector(DetPos: integer; DetState: TDetectorState);
begin
  InsertDetectorStateAndComment(Dosimeter.MeasurementID,
                                Dosimeter.CntDetector.DetType,
                                Dosimeter.CntDetector.DetTypeID,
                                DetPos,
                                DateTimeToStr(Now),
                                DetState,
                                Dosimeter.CntDetector.Comment);
  inc(Dosimeter.DetectorsCnt);
end;

procedure TMainForm.DecommissionDos;
var
  fullDosId   : String;
  temp        : word;
  i           : integer;
begin
  if DBGridEhDos.SelectedRows.Count > 0 then
  begin
    if TLDDataModule.IsDBConnected then
    begin
      if DBGridEhDos.SelectedRows.Count >= 1 then
      begin
        temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s - %s (%d%s)?',[rsDosimetersGroupToOut,fullDosId,DBGridEhDos.SelectedRows.Count,rsNums]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

        case temp of
          mrYes:                                    // если нажали продолжить
          begin                                     // вывод из эксплуатации
            try
              for i := 0 to DBGridEhDos.SelectedRows.Count-1 do
              begin
                DBGridEhDos.DataSource.DataSet.GotoBookmark(DBGridEhDos.SelectedRows.Items[i]);

                fullDosId:=DBGridEhDos.DataSource.DataSet.FieldByName(cFullDosID).AsString;

                if TLDDataModule.IsDosimeterInPart(fullDosId) then
                  TLDDataModule.ExcludeDosimeterFromPart(fullDosId);

                TLDDataModule.ADOQuery.Active:=False;
                TLDDataModule.ADOQuery.SQL.Clear;
                TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cFieldDosStatus+'='
                                                                            +IntToStr(cDosDecommissioned)
                                                                    +' WHERE ((CAST('+cFieldDosID+' AS TEXT) = '+#39+fullDosId+#39+') AND '+cFieldDosPostfix+' = '+#39+'-'+#39+') OR CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' = '+#39+fullDosId+#39);
                TLDDataModule.ADOQuery.ExecSQL;

                WriteLog(Format('%s - %s',[rsDosimeterOut,fullDosId]));
              end;

              UpdateAllGridPages;

            except
              on E: exception do
              begin
                WriteLog(Format('%s - %s. %s',[rsDosimeterOutFailure,fullDosId,E.Message]));
                MessageDlg(Format('%s - %s. %s - %s',[rsDosimeterOutFailure,fullDosId,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError, [mbOK], 0);
              end;
            end;
          end;
        end;

      end;
    end;
  end
  else
    MessageDlg(Format('%s',[rsNotChooseDosimeterOut,fullDosId]),mtWarning,[mbOK], 0);
end;

procedure TMainForm.DefaultChartSize;
begin
  if FMaximazeD1Chart then MaximaizeD1Chart:=not FMaximazeD1Chart;
  if FMaximazeD2Chart then MaximaizeD2Chart:=not FMaximazeD2Chart;
  if FMaximazeD3Chart then MaximaizeD3Chart:=not FMaximazeD3Chart;
  if FMaximazeD4Chart then MaximaizeD4Chart:=not FMaximazeD4Chart;
end;

procedure TMainForm.MarkToDelMeasurement;
var
  measId      : String;
  fullDosId   : String;
  temp        : word;
  i           : integer;
begin
  if DBGridEhProcess.SelectedRows.Count > 0 then
  begin
    if TLDDataModule.IsDBConnected then
    begin
      if DBGridEhProcess.SelectedRows.Count > 1 then
      begin
        temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format(rsDeleteMeasuresGroupAsk,[DBGridEhProcess.SelectedRows.Count]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

        if temp = mrYes then
        begin

          for i := 0 to DBGridEhProcess.SelectedRows.Count-1 do
          begin
            DBGridEhProcess.DataSource.DataSet.GotoBookmark(DBGridEhProcess.SelectedRows.Items[i]);

            fullDosId:=DBGridEhProcess.DataSource.DataSet.FieldByName(cFullDosID).AsString;
            measId:=DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;

            if not TLDDataModule.MarkToDelMeasurment(fullDosId,measId) then
              MessageDlg(Format('%s №%s %s %s. %s - %s',[rsDeleteMeasureFailure,measId,rsOfDosimeter,fullDosId,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError,[mbOK],0);

          end;

          UpdateGridMeasAndProcessPages;
        end;
      end
      else
      begin
        fullDosId:=DBGridEhProcess.DataSource.DataSet.FieldByName(cFullDosID).AsString;
        measId:=DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;

        temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format(rsDeleteMeasureAsk,[measId,fullDosId]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

        case temp of
          mrYes:                   // если нажали продолжить
          begin
            if not TLDDataModule.MarkToDelMeasurment(fullDosId,measId) then
              MessageDlg(Format('%s №%s %s %s. %s - %s',[rsDeleteMeasureFailure,measId,rsOfDosimeter,fullDosId,rsDetailInfoAtFile,AppDir+PathDelim+cLogFileName]),mtError,[mbOK],0);

            UpdateGridMeasAndProcessPages;
          end;
        end;

      end;
    end;
  end
  else
    MessageDlg(rsNotChooseMeasureToDel,mtWarning,[mbOK], 0);
end;

procedure TMainForm.DeleteUserSpeedBtnClick(Sender: TObject);
var
  temp  : word;
begin
  if TLDDataModule.IsDBConnected then
  begin
    temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format(rsDeleteUserAsk,[AW.Users[PermitSelectedRowUser].Login]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

    case temp of
      mrYes:
      begin
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add(Format('DELETE FROM %s WHERE %s = %d',[cDBTableUser,cFieldUserNameID,AW.Users[PermitSelectedRowUser].UserId]));
        TLDDataModule.ADOQuery.ExecSQL;
        TLDDataModule.ADOQuery.Close;

        WriteLog(Format(rsUserDeleted,[AW.Users[PermitSelectedRowUser].Login]));
        AW.ParsingUsersListDB;
        PermitSelectedRowUser:=0;
        RefreshPermit_Page;
      end;
    end;
  end;
end;

procedure TMainForm.TLDChartMeasDataD1Zoom(Sender: TObject);
begin
{
  if TLDChartMeasDataD1.LeftAxis.Minimum < cLeftBottomBorder then       // что-бы не показывать отрицательные значения
    TLDChartMeasDataD1.LeftAxis.Minimum := cLeftBottomBorder;

  if TLDChartMeasDataD1.RightAxis.Minimum < cLeftBottomBorder then      // что бы не показывать отрицательные значения
    TLDChartMeasDataD1.RightAxis.Minimum := cLeftBottomBorder;

  if TLDChartMeasDataD1.BottomAxis.Minimum < cLeftBottomBorder then     // что-бы не показывать отрицательные значения
    TLDChartMeasDataD1.BottomAxis.Minimum := cLeftBottomBorder;

  if TLDChartMeasDataD1.BottomAxis.Maximum > cRightBottomBorder then     // что-бы не показывать отрицательные значения
    TLDChartMeasDataD1.BottomAxis.Maximum := cRightBottomBorder;
}
end;

procedure TMainForm.LoadFilters;
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
//      LoadComboBox(CBoxMeasOrgName,cFieldOrg);
//      LoadComboBox(CBoxMeasDep,cFieldDepartment);
//      LoadComboBox(CBoxMeasDosPart,cFieldPartID);
//      LoadComboBox(CBoxMeasDosType,cFieldDosType);
//      LoadComboBox(CBoxMeasStatus,cFieldDosStatus);
//      LoadComboBox(CBoxMeasResult,cFieldValidity);
//      LoadComboBox(CBoxMeasComment,cFieldMeasComment);
    end;
    cPageDosIndex:
    begin
      LoadComboBox(CBoxDosOrgName,cFieldOrg);
      LoadComboBox(CBoxDosDep,cFieldDepartment);
      LoadComboBox(CBoxDosDosPart,cFieldPartID);
      LoadComboBox(CBoxDosDosType,cFieldDosType);
      LoadComboBox(CBoxDosStatus,cFieldDosStatus);
      LoadComboBox(CBoxDosDeviceID,cFieldTldID);
      LoadComboBox(CBoxDosComment,cFieldLastMeasComment);
    end;
    cPageProcessIndex:
    begin
      LoadComboBox(CBoxProcessOrgName,cFieldOrg);
      LoadComboBox(CBoxProcessDep,cFieldDepartment);
      LoadComboBox(CBoxProcessDosPart,cFieldDosPartName);
      LoadComboBox(CBoxProcessDosType,cFieldDosType);
      LoadComboBox(CBoxProcessStatus,cFieldDosStatus);
      LoadComboBox(CBoxProcessResult,cFieldValidity);
      LoadComboBox(CBoxProcessDeviceID,cFieldTldID);
      LoadComboBox(CBoxProcessComment,cFieldMeasComment);
    end;
  end;
end;

procedure TMainForm.LoadFiltersAll;
begin
  LoadComboBox(CBoxDosOrgName,cFieldOrg);
  LoadComboBox(CBoxDosDep,cFieldDepartment);
  LoadComboBox(CBoxDosDosPart,cFieldPartID);
  LoadComboBox(CBoxDosDosType,cFieldDosType);
  LoadComboBox(CBoxDosStatus,cFieldDosStatus);
  LoadComboBox(CBoxDosDeviceID,cFieldTldID);
  LoadComboBox(CBoxDosComment,cFieldLastMeasComment);
  LoadComboBox(CBoxProcessOrgName,cFieldOrg);
  LoadComboBox(CBoxProcessDep,cFieldDepartment);
  LoadComboBox(CBoxProcessDosPart,cFieldDosPartName{cFieldPartID});
  LoadComboBox(CBoxProcessDosType,cFieldDosType);
  LoadComboBox(CBoxProcessStatus,cFieldDosStatus);
  LoadComboBox(CBoxProcessResult,cFieldValidity);
  LoadComboBox(CBoxProcessDeviceID,cFieldTldID);
  LoadComboBox(CBoxProcessComment,cFieldMeasComment);
end;

procedure TMainForm.UpdateDataDosFilter(Filter: String);
begin
  //if TLDDataModule.IsConnected AND (TLDDataModule.DBName <> cPostgreDefaultDB) then
  if TLDDataModule.IsDBConnected then
  begin
    try
      // дозиметры
      if ADOQueryDosList.Active then ADOQueryDosList.Close;
      ADOQueryDosList.SQL.Clear;
      // запрос обрабатывает два столбца "dosimeterid" и "postfix", если postfix не равен "-" (символу отсутствия постфикса), то склеиваем столбцы "dosimeterid" и "postfix" вместе для вывода,
      // если если postfix равен "-", то выводим только "dosimeterid"
      ADOQueryDosList.SQL.Add('SELECT'+' '
                              +cFieldTldID+','
                              +'CASE '+cFieldDosPostfix+' WHEN '+#39'-'+#39+' THEN CAST('+cFieldDosID+' AS VARCHAR) ELSE CAST (('+cFieldDosID+' || '+cFieldDosPostfix+') AS VARCHAR) END AS '+cFullDosID+','
                              +cFieldDosID+','
                              +cFieldDosPostfix+','
                              +cFieldDosType+','
                              +cFieldDosTypeID+','
                              +'CAST (CASE '+cFieldDosStatus+' WHEN '+IntToStr(cDosCalibrated)+' then '+#39+rsDosCalibrated+#39+' WHEN '+IntToStr(cDosNotCalibrated)+' then '+#39+rsDosNotCalibrated+#39+' ELSE '+#39+rsDosDecommissioned+#39+' END AS VARCHAR) AS '+cFieldStringState+','
                              +cFieldDosStatus+','
                              +'ROUND('+cField_k1+'::numeric,2) as '+cField_k1+','
                              +'ROUND('+cField_k2+'::numeric,2) as '+cField_k2+','
                              +'ROUND('+cField_k3+'::numeric,2) as '+cField_k3+','
                              +'ROUND('+cField_k4+'::numeric,2) as '+cField_k4+','
                              +'ROUND('+cField_k5+'::numeric,2) as '+cField_k5+','
                              +'ROUND('+cField_kgn+'::numeric,2) as '+cField_kgn+','
                              +cFieldPartID+','
                          +'('+'SELECT '+cFieldDosPartName+' FROM '+cDBTableDosPart+' WHERE '+cDBTableDosID+'.'+cFieldPartID+'='+cFieldPartID+')'+','
                              +cFieldRegTime+','
                          +'('+'SELECT CASE '+cFieldVerTime+' WHEN '+#39+cZeroDateTime+#39+'THEN null ELSE '+cFieldVerTime+' END '+')'+','
                              +cFieldOrg+','
                              +cFieldDepartment+','
                              +cFieldLastMeasTime+','
                              +cFieldLastMeasResult+','
                                 +'CAST ('
                                 +' CASE WHEN ('+cFieldLastMeasResult+' <= '+IntToStr(cDosMeasFinishedD4)+') OR ('+cFieldLastMeasResult+' >= '+IntToStr(cDosMeasStoppedD1)+' AND '+cFieldLastMeasResult+' <= '+IntToStr(cDosMeasStoppedD4)+') then '+#39+rsDosNotMeasured+#39
                                    +' WHEN '+cFieldLastMeasResult+' = '+IntToStr(cDosMeasFinished)+' THEN '+#39+rsDosFinished+#39
                                    +' WHEN '+cFieldLastMeasResult+' = '+IntToStr(cDosMeasError)+' THEN '+#39+rsDosMeasErr+#39
                                    +' WHEN '+cFieldLastMeasResult+' = '+IntToStr(cDosMeasWarning)+' THEN '+#39+rsDosMeasWarning+#39
                                    +' WHEN '+cFieldLastMeasResult+' = '+IntToStr(cDosMeasUserWarning)+' THEN '+#39+rsDosMeasForProcessing+#39
                                    +' WHEN '+cFieldLastMeasResult+' = '+IntToStr(cDosMeasAccepted)+' THEN '+#39+rsDosAccepted+#39+' ELSE '+#39+rsDosNotMeasured+#39+' END'
                                    +' AS VARCHAR)'
                                    +' AS '+cFieldStringValidity+','
                              +cFieldLastMeasComment+' '
                              +'FROM '+cDBTableDosID+' WHERE '
                              +'(CAST ('+cFieldDosID+' AS TEXT) LIKE '+#39+Filter+'%'+#39+' OR CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' LIKE '+#39+Filter+'%'+#39+')'
                              +' AND '
                              +GetFilterDosOrganization(CBoxDosOrgName)
                              +' AND '
                              +GetFilterDosDepartment(CBoxDosDep)
                              +' AND '
                              +GetFilterDosType(CBoxDosDosType)
                              +' AND '
                              +GetFilterDosPartID(CBoxDosDosPart)
                              +' AND '
                              +GetFilterDosStatus(CBoxDosStatus)
                              +' AND '
                              +GetFilterDeviceID(CBoxDosDeviceID)
                              //**+GetFilterShowAllDevices(DosShowFromAllDevices)
                              //+'('+cFieldTldID+' = '+IntToStr(DeviceID)+')'
                              +' ORDER BY '+cFullDosID);
      ADOQueryDosList.Open;

      if MemTableEhDosList.Active then MemTableEhDosList.Active:=false;
      MemTableEhDosList.Active:=true;

      ADOQueryDosList.Clear;
      ADOQueryDosList.Close;
    except
      on E: exception do
        MessageDlg(E.Message,mtError, [mbOK], 0);
    end;
  end;
end;

procedure TMainForm.UpdateGridMeasFilter(Filter: String);
var
  measID    : String;
  prevDate  : TDate;
  nextDate  : TDate;
begin
  if TLDDataModule.IsDBConnected then
  begin
    try
      measID:='';
      if ADOQueryMeasList.Active then ADOQueryMeasList.Close;

      // измерения
      ADOQueryMeasList.SQL.Clear;
      // запрос обрабатывает два столбца "dosimeterid" и "postfix", если postfix не равен "-" (символу отсутствия постфикса), то склеиваем столбцы "dosimeterid" и "postfix" вместе для вывода,
      // если если postfix равен "-", то выводим только "dosimeterid"

      ADOQueryMeasList.SQL.Add('SELECT'+' '
                               +cFieldTldID+','
                               +cFieldDosMeasID+','
                               +'CASE '+cFieldDosPostfix+' '
                                 +'WHEN '+#39'-'+#39+' '
                                 +'THEN CAST('+cFieldDosID+' AS VARCHAR)'+' '
                                 +'ELSE CAST (('+cFieldDosID+' || '+cFieldDosPostfix+') AS VARCHAR)'+' '
                               +'END'+' '
                               +'AS '+cFullDosID+','
                               +cFieldDosType+','
                               +cFieldMeasureTime+','
                               +cFieldKSI+','
                               +'CAST('
                               +'CAST('
                                 +'CASE'+' '
                                   +'WHEN ('+cFieldHp10g+' IS NOT NULL)'+' '
                                   +'THEN CAST ('+#39+cHp_10g+'='+#39+'|| ROUND('+cFieldHp10g+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                   +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                 +'END'+' '
                                 +'AS VARCHAR'+' '
                                 +') ||'+#39+''+#39+'||'+' '
                               +'CAST('
                                 +'CASE'+' '
                                   +'WHEN ('+cFieldHp10n+' IS NOT NULL)'+' '
                                   +'THEN CAST ('+#39+cHp_10n+'='+#39+'|| ROUND('+cFieldHp10n+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                   +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                 +'END AS VARCHAR'+' '
                                 +') ||'+#39+''+#39+'||'+' '
                               +'CAST('
                                 +'CASE'+' '
                                   +'WHEN ('+cFieldHp007+' IS NOT NULL)'+' '
                                   +'THEN CAST ('+#39+cHp_007+'='+#39+'|| ROUND('+cFieldHp007+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                   +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                 +'END AS VARCHAR'+' '
                                 +') ||'+#39+''+#39+'||'+' '
                               +'CAST('
                                 +'CASE'+' '
                                   +'WHEN ('+cFieldHp3+' IS NOT NULL)'+' '
                                   +'THEN CAST ('+#39+cHp_3+'='+#39+'|| ROUND('+cFieldHp3+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                   +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                 +'END AS VARCHAR'+' '
                                 +') ||'+#39+''+#39+'||'+' '
                               +'CAST('
                                 +'CASE'+' '
                                   +'WHEN ('+cFieldHstar+' IS NOT NULL)'+' '
                                   +'THEN CAST ('+#39+cH_star+'='+#39+'|| ROUND('+cFieldHstar+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                   +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                 +'END AS VARCHAR'+' '
                                 +') ||'+#39+''+#39+'||'+' '
                               +'CAST('
                                 +'CASE'+' '
                                   +'WHEN ('+cFieldH007+' IS NOT NULL)'+' '
                                   +'THEN CAST ('+#39+cH_007_dir+'='+#39+'|| ROUND('+cFieldH007+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                   +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                 +'END AS VARCHAR'+' '
                                 +') ||'+#39+''+#39+'||'+' '
                               +'CAST('
                                 +'CASE'+' '
                                   +'WHEN ('+cFieldD+' IS NOT NULL)'+' '
                                   +'THEN CAST ('+#39+cD+'='+#39+'|| ROUND('+cFieldD+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                   +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                 +'END AS VARCHAR'
                                 +')'
                               +'AS VARCHAR)'+' '
                               +'AS '+cFieldDose+','
                               +cFieldHp10g+','
                               +cFieldHp10n+','
                               +cFieldHp007+','
                               +cFieldHp3+','
                               +cFieldHstar+','
                               +cFieldH007+','
                               +cFieldD+','
                               +cFieldHp10g_err+','
                               +cFieldHp10n_err+','
                               +cFieldHp007_err+','
                               +cFieldHp3_err+','
                               +cFieldHstar_err+','
                               +cFieldH007_err+','
                               +cFieldD_err+','
//                               +'(SELECT '+cFieldDose+' FROM '+cDBTableDetRes+' '
//                                 +'WHERE ('+cDBTableDetRes+'.'+cFieldDosMeasID+' = '+cDBTableDosRes+'.'+cFieldDosMeasID+' AND '+cDBTableDetRes+'.'+cFieldDetPosition+'='+IntToStr(cDetPos1)+') LIMIT 1)'
//                                 +'AS '+cFieldDetector1+','
//                               +'(SELECT '+cFieldDose+' FROM '+cDBTableDetRes+' '
//                                 +'WHERE ('+cDBTableDetRes+'.'+cFieldDosMeasID+' = '+cDBTableDosRes+'.'+cFieldDosMeasID+' AND '+cDBTableDetRes+'.'+cFieldDetPosition+'='+IntToStr(cDetPos2)+') LIMIT 1)'
//                                 +'AS '+cFieldDetector2+','
//                               +'(SELECT '+cFieldDose+' FROM '+cDBTableDetRes+' '
//                                 +'WHERE ('+cDBTableDetRes+'.'+cFieldDosMeasID+' = '+cDBTableDosRes+'.'+cFieldDosMeasID+' AND '+cDBTableDetRes+'.'+cFieldDetPosition+'='+IntToStr(cDetPos3)+') LIMIT 1)'
//                                 +'AS '+cFieldDetector3+','
//                               +'(SELECT '+cFieldDose+' FROM '+cDBTableDetRes+' '
//                                 +'WHERE ('+cDBTableDetRes+'.'+cFieldDosMeasID+' = '+cDBTableDosRes+'.'+cFieldDosMeasID+' AND '+cDBTableDetRes+'.'+cFieldDetPosition+'='+IntToStr(cDetPos4)+') LIMIT 1)'
//                                 +'AS '+cFieldDetector4+','
                               +cFieldValidity+','
                               +'CAST('
                               +' CASE WHEN ('+cFieldValidity+' <= '+IntToStr(cDosMeasFinishedD4)+') OR ('+cFieldValidity+' >= '+IntToStr(cDosMeasStoppedD1)+' AND '+cFieldValidity+' <= '+IntToStr(cDosMeasStoppedD4)+') then '+#39+rsDosNotMeasured+#39
                                 +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasFinished)+' THEN '+#39+rsDosFinished+#39
                                 +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasError)+' THEN '+#39+rsDosMeasErr+#39
                                 +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasWarning)+' THEN '+#39+rsDosMeasWarning+#39
                                 +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasUserWarning)+' THEN '+#39+rsDosMeasForProcessing+#39
                                 +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasAccepted)+' THEN '+#39+rsDosAccepted+#39+' ELSE '+#39+rsDosNotMeasured+#39+' END'
                                 +' AS VARCHAR)'
                                 +' AS '+cFieldStringValidity+','
                               //+cFieldDosType+','
                               +cFieldRegTime+','
                               //+cFieldVerTime+','
                               +'('+'SELECT CASE '+cFieldVerTime+' WHEN '+#39+cZeroDateTime+#39+'THEN null ELSE '+cFieldVerTime+' END '+')'+','
                               +'('+'SELECT CASE '+cFieldLastMeasTime+' WHEN '+#39+cZeroDateTime+#39+'THEN null ELSE '+cFieldLastMeasTime+' END '+')'+','
                               +cFieldDosStatus+','
                               +cFieldOrg+','
                               +cFieldDepartment+','
                               +cFieldPartID+','
                               +cFieldDosPartName+','
                               +cFieldLastMeasComment+','
                               +cFieldMeasComment+','
                               +cFieldPersNumber+','
                               +cFieldFio+','
                               +cFieldTldUser+','
                               +cFieldToDel+' '
                               +'FROM ' +cDBTableDosRes+ ' WHERE '
                               +GetFilterMeasTime(JvDateTimePickerMeas)
                               +' AND '
                               +GetFilterMeasToDel(false)
                               +' AND '
                               +GetFilterShowAllDevices(true)
                               //+'('+cFieldTldID+' = '+IntToStr(DeviceID)+')'
                               +' ORDER BY '+cFieldMeasureTime+' DESC'
                               );
                               //+';COMMIT;');
      ADOQueryMeasList.Open;

      if MemTableEhMeasList.Active then MemTableEhMeasList.Active:=false;
      MemTableEhMeasList.Active:=true;

      if MemTableEhMeasList.Active then measID:=DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;

      if measID <> '' then DBGridEhOnlyMeas.DataSource.DataSet.Locate(cFieldDosMeasID,measID,[]);

      ADOQueryMeasList.Clear;
      ADOQueryMeasList.Close;

      prevDate:=TLDDataModule.GetPrevMeasDate(JvDateTimePickerMeas.Date);
      nextDate:=TLDDataModule.GetNextMeasDate(JvDateTimePickerMeas.Date);
      ShapeRight.Visible:=((DateOf(nextDate)=Date) AND (nextDate >= JvDateTimePickerMeas.Date));

      SpBtnPrev.Caption:=DateToStrRegion(prevDate);

      if nextDate > JvDateTimePickerMeas.Date then
        SpBtnNext.Caption:=DateToStrRegion(nextDate)
      else
        SpBtnNext.Caption:=cEmptyData;

      if SpBtnPrev.Caption <> cEmptyData then SpBtnPrev.Visible:=true else SpBtnPrev.Visible:=false;
      if SpBtnNext.Caption <> cEmptyData then SpBtnNext.Visible:=true else SpBtnNext.Visible:=false;

    except
      on E: exception do
        MessageDlg(E.Message,mtError, [mbOK], 0);
    end;
  end;
end;

procedure TMainForm.SetFooterCalcKDosGrid(Field: String; K_avg: double);
begin
  if K_avg > 0 then
  begin
    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(Field).Index].Footer.ValueType:=fvtStaticText;
    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(Field).Index].Footer.Font.Size:=12;
    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(Field).Index].Footer.Value:=FloatToStrRegion(K_avg);
  end
  else
    DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(Field).Index].Footer.Value:='';
end;

procedure TMainForm.UpdateGridCalibrationFilter(Filter: String);
var
  i           : integer;
  measID      : String;
//  Group       : TGridDataGroupLevelEh;
//  Footer      : TGridDataGroupFooterEh;
//  FooterNode  : TGroupDataTreeNodeEh;
//  CurrentNode : TGroupDataTreeNodeEh;
//  FooterVal   : Variant;
//  Column      : TColumnEh;
//  st          : String;
//  db          : double;
  k1_avg      : double;
  k2_avg      : double;
  k3_avg      : double;
  k4_avg      : double;
  k5_avg      : double;
  kgn_avg     : double;
  fullDosID   : String;
//  dose        : double;
//  sourceDose  : double;
  formulaID   : integer;
//  measValid   : integer;
  ksi         : integer;
  ksi_avg     : integer;
  dosimeterCalibration   : TDosimeter;
begin
  k1_avg:=0;
  k2_avg:=0;
  k3_avg:=0;
  k4_avg:=0;
  k5_avg:=0;
  kgn_avg:=0;
  ksi_avg:=0;

  if TLDDataModule.IsDBConnected then
  begin
    try
      if ADOQueryCalibrList.Active then ADOQueryCalibrList.Close;
      ADOQueryCalibrList.SQL.Clear;
      // запрос обрабатывает два столбца "dosimeterid" и "postfix", если postfix не равен "-" (символу отсутствия постфикса), то склеиваем столбцы "dosimeterid" и "postfix" вместе для вывода,
      // если если postfix равен "-", то выводим только "dosimeterid"

      ADOQueryCalibrList.SQL.Add('SELECT'+' '
                                  +cFieldTldID+','
                                  +cFieldDosMeasID+','
                                  +'CASE '+cFieldDosPostfix+' WHEN '+#39'-'+#39+' THEN CAST('+cFieldDosID+' AS TEXT) ELSE CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' END AS '+cFullDosID+','
                                  +cFieldDosType+','
                                  +cFieldCalibrationValue+','
                                  +cFieldRadiationType+','
                                  +cField_k1+','
                                  +cField_k2+','
                                  +cField_k3+','
                                  +cField_k4+','
                                  +cField_k5+','
                                  +cField_kgn+','
                                  +cFieldMeasureTime+','
                                  +cFieldKSI+','
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldHp10g+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cHp_10g+'='+#39+'|| ROUND('+cFieldHp10g+'::numeric,3) || '+#39+';'+#39+' AS TEXT)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS TEXT)'+' '
                                    +'END'+' '
                                    +'AS TEXT'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldHp10n+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cHp_10n+'='+#39+'|| ROUND('+cFieldHp10n+'::numeric,3) || '+#39+';'+#39+' AS TEXT)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS TEXT)'+' '
                                    +'END AS TEXT'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldHp007+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cHp_007+'='+#39+'|| ROUND('+cFieldHp007+'::numeric,3) || '+#39+';'+#39+' AS TEXT)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS TEXT)'+' '
                                    +'END AS TEXT'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldHp3+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cHp_3+'='+#39+'|| ROUND('+cFieldHp3+'::numeric,3) || '+#39+';'+#39+' AS TEXT)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS TEXT)'+' '
                                    +'END AS TEXT'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldHstar+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cH_star+'='+#39+'|| ROUND('+cFieldHstar+'::numeric,3) || '+#39+';'+#39+' AS TEXT)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS TEXT)'+' '
                                    +'END AS TEXT'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldH007+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cH_007_dir+'='+#39+'|| ROUND('+cFieldH007+'::numeric,3) || '+#39+';'+#39+' AS TEXT)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS TEXT)'+' '
                                    +'END AS TEXT'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldD+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cD+'='+#39+'|| ROUND('+cFieldD+'::numeric,3) || '+#39+';'+#39+' AS TEXT)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS TEXT)'+' '
                                    +'END AS TEXT'
                                    +')'
                                  +'AS '+cFieldDose+','
                                  +cFieldHp10g+','
                                  +cFieldHp10n+','
                                  +cFieldHp007+','
                                  +cFieldHp3+','
                                  +cFieldHstar+','
                                  +cFieldH007+','
                                  +cFieldD+','
                                  +cFieldHp10g_err+','
                                  +cFieldHp10n_err+','
                                  +cFieldHp007_err+','
                                  +cFieldHp3_err+','
                                  +cFieldHstar_err+','
                                  +cFieldH007_err+','
                                  +cFieldD_err+','
                                  +cFieldFormulaId_Dos+','
                                  +cFieldValidity+','
                                  +' CASE WHEN ('+cFieldValidity+' <= '+IntToStr(cDosMeasFinishedD4)+') OR ('+cFieldValidity+' >= '+IntToStr(cDosMeasStoppedD1)+' AND '+cFieldValidity+' <= '+IntToStr(cDosMeasStoppedD4)+') then '+#39+rsDosNotMeasured+#39
                                    +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasFinished)+' THEN '+#39+rsDosFinished+#39
                                    +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasError)+' THEN '+#39+rsDosMeasErr+#39
                                    +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasWarning)+' THEN '+#39+rsDosMeasWarning+#39
                                    +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasUserWarning)+' THEN '+#39+rsDosMeasForProcessing+#39
                                    +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasAccepted)+' THEN '+#39+rsDosAccepted+#39+' ELSE '+#39+rsDosNotMeasured+#39+' END'
                                    +' AS '+cFieldStringValidity+','
                                  +cFieldRegTime+','
                                  +'('+'SELECT CASE '+cFieldVerTime+' WHEN '+#39+cZeroDateTime+#39+'THEN null ELSE '+cFieldVerTime+' END '+')'+','
                                  +cFieldDosStatus+','
                                  +cFieldOrg+','
                                  +cFieldDepartment+','
                                  +cFieldPartID+','
                                  +cFieldDosPartName+','
                                  +cFieldLastMeasComment+','
                                  +cFieldMeasComment+','
                                  +cFieldPersNumber+','
                                  +cFieldFio+','
                                  +cFieldTldUser+','
                                  +cFieldToDel+' '
                                  +'FROM ' +cDBTableDosRes
                                    + ' WHERE '
                                  +'(CAST ('+cFieldDosID+' AS TEXT) LIKE '+#39+Filter+'%'+#39+' OR CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' LIKE '+#39+Filter+'%'+#39+')'
                                  +' AND '
                                  +cFieldMeasState+' = '+IntToStr(cMeasStCalibr)+' '
                                  +'ORDER BY '+cFieldRadiationType
                                  );
      ADOQueryCalibrList.Open;

      MemTableEhCalcKDos.Active:=false;
      MemTableEhCalcKDos.CreateDataSet;
      MemTableEhCalcKDos.Active:=true;
      MemTableEhCalcKDos.EmptyTable;

      DBGridEhCalcKDos.DataSource.DataSet.First;

      for i := 0 to ADOQueryCalibrList.RecordCount-1 do
      begin
        measid:=ADOQueryCalibrList.FieldByName(cFieldDosMeasID).AsString;
        formulaID:=ADOQueryCalibrList.FieldByName(cFieldFormulaId_Dos).AsInteger;
        fullDosID:=ADOQueryCalibrList.FieldByName(cFullDosID).AsString;
        ksi:=ADOQueryCalibrList.FieldByName(cFieldKSI).AsInteger;
        dosimeterCalibration:=TDosimeter.Create(fullDosID,measid);

        LoadDosWithMeasData(TLDDataModule.ADOQuery,dosimeterCalibration,measid);

        case formulaID of
          cHp_10g_1d,
          cHp_10g_2d,
          cHp_10g_3d,
          cHp_10g_4d,
          cHp_007g_1d,
          cHp_007g_2d,
          cHp_007g_3d,
          cHp_007g_4d,
          cHp_3_1d,
          cHp_3_2d,
          cHp_3_3d,
          cHp_3_4d:
          begin
            k1_avg:=k1_avg+dosimeterCalibration.K1;
          end;
          cHp_10g_2d_Hp_10n_2d,
          cHp_10g_2d_Hp_10n_1d,
          cHp_10g_1d_Hp_10n_2d,
          cHp_10g_1d_Hp_10n_1d:
          begin
            k1_avg:=k1_avg+dosimeterCalibration.K1;
            k2_avg:=k2_avg+dosimeterCalibration.K2;
            kgn_avg:=kgn_avg+dosimeterCalibration.Kgn;
          end;
        end;

        ksi_avg:=ksi_avg+ksi;

        MemTableEhCalcKDos.Append;

        if ADOQueryCalibrList.FieldByName(cFieldTldID).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldTldID).AsString:=ADOQueryCalibrList.FieldByName(cFieldTldID).AsString;
        if ADOQueryCalibrList.FieldByName(cFieldKSI).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldKSI).AsString:=ADOQueryCalibrList.FieldByName(cFieldKSI).AsString;
        if ADOQueryCalibrList.FieldByName(cFieldDosMeasID).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldDosMeasID).AsString:=ADOQueryCalibrList.FieldByName(cFieldDosMeasID).AsString;
        if ADOQueryCalibrList.FindField(cFullDosID).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFullDosID).AsString:=ADOQueryCalibrList.FieldByName(cFullDosID).AsString;
        if ADOQueryCalibrList.FindField(cFieldDosType).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldDosType).AsString:=ADOQueryCalibrList.FieldByName(cFieldDosType).AsString;
        if ADOQueryCalibrList.FindField(cFieldCalibrationValue).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldCalibrationValue).AsString:=ADOQueryCalibrList.FieldByName(cFieldCalibrationValue).AsString;
        if ADOQueryCalibrList.FindField(cFieldRadiationType).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldRadiationType).AsString:=ADOQueryCalibrList.FieldByName(cFieldRadiationType).AsString;
        if ADOQueryCalibrList.FieldByName(cField_k1).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_k1).AsFloat:=RoundToCN(dosimeterCalibration.K1,-1);
        if ADOQueryCalibrList.FieldByName(cField_k2).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_k2).AsFloat:=RoundToCN(dosimeterCalibration.K2,-1);
        if ADOQueryCalibrList.FieldByName(cField_k3).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_k3).AsFloat:=RoundToCN(dosimeterCalibration.K3,-1);
        if ADOQueryCalibrList.FieldByName(cField_k4).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_k4).AsFloat:=RoundToCN(dosimeterCalibration.K4,-1);
        if ADOQueryCalibrList.FieldByName(cField_k5).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_k5).AsFloat:=RoundToCN(dosimeterCalibration.K5,-1);
        if ADOQueryCalibrList.FieldByName(cField_kgn).AsString<>'' then MemTableEhCalcKDos.FieldByName(cField_kgn).AsFloat:=RoundToCN(dosimeterCalibration.Kgn,-2);
        if ADOQueryCalibrList.FieldByName(cFieldHp10g).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldHp10g).AsFloat:=dosimeterCalibration.Dose_Hp_10g;
        if ADOQueryCalibrList.FieldByName(cFieldHp10n).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldHp10n).AsFloat:=dosimeterCalibration.Dose_Hp_10n;
        if ADOQueryCalibrList.FieldByName(cFieldHp3).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldHp3).AsFloat:=dosimeterCalibration.Dose_Hp_3;
        if ADOQueryCalibrList.FieldByName(cFieldHp007).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldHp007).AsFloat:=dosimeterCalibration.Dose_Hp_007;
        if ADOQueryCalibrList.FieldByName(cFieldHstar).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldHstar).AsFloat:=dosimeterCalibration.Dose_H_star;
        if ADOQueryCalibrList.FieldByName(cFieldH007).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldH007).AsFloat:=dosimeterCalibration.Dose_H_007;
        if ADOQueryCalibrList.FieldByName(cFieldD).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldD).AsFloat:=dosimeterCalibration.Dose_D;
        if ADOQueryCalibrList.FieldByName(cFieldFormulaId_Dos).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldFormulaId_Dos).AsString:=ADOQueryCalibrList.FieldByName(cFieldFormulaId_Dos).AsString;
        if ADOQueryCalibrList.FieldByName(cFieldValidity).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldValidity).AsString:=ADOQueryCalibrList.FieldByName(cFieldValidity).AsString;
        if ADOQueryCalibrList.FieldByName(cFieldDose).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldDose).AsString:=dosimeterCalibration.Doses.GetStringValue;
        if ADOQueryCalibrList.FieldByName(cFieldPartID).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldPartID).AsString:=ADOQueryCalibrList.FieldByName(cFieldPartID).AsString;
        if ADOQueryCalibrList.FieldByName(cFieldDosPartName).AsString<>'' then MemTableEhCalcKDos.FieldByName(cFieldDosPartName).AsString:=ADOQueryCalibrList.FieldByName(cFieldDosPartName).AsString;

        MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_10g_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_Hp_10g_Percent,-1);
        MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_10n_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_Hp_10n_Percent,-1);
        MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_3_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_Hp_3_Percent,-1);
        MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_Hp_007_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_Hp_007_Percent,-1);
        MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_H_star_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_H_star_Percent,-1);
        MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_H_007_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_H_007_Percent,-1);
        MemTableEhCalcKDos.FieldByName(cFieldVirt_Err_D_Percent).AsFloat:=RoundToCN(dosimeterCalibration.Err_D_Percent,-1);

        MemTableEhCalcKDos.Post;
        ADOQueryCalibrList.Next;
      end;

      if MemTableEhCalcKDos.RecordCount>0 then
      begin
        k1_avg:=RoundToCN(k1_avg/MemTableEhCalcKDos.RecordCount,-1);
        k2_avg:=RoundToCN(k2_avg/MemTableEhCalcKDos.RecordCount,-1);
        k3_avg:=RoundToCN(k3_avg/MemTableEhCalcKDos.RecordCount,-1);
        k4_avg:=RoundToCN(k4_avg/MemTableEhCalcKDos.RecordCount,-1);
        k5_avg:=RoundToCN(k5_avg/MemTableEhCalcKDos.RecordCount,-1);
        kgn_avg:=RoundToCN(kgn_avg/MemTableEhCalcKDos.RecordCount,-2);
        ksi_avg:=Round(ksi_avg/MemTableEhCalcKDos.RecordCount);
      end;

      SetFooterCalcKDosGrid(cField_k1,k1_avg);
      SetFooterCalcKDosGrid(cField_k2,k2_avg);
      SetFooterCalcKDosGrid(cField_k3,k3_avg);
      SetFooterCalcKDosGrid(cField_k4,k4_avg);
      SetFooterCalcKDosGrid(cField_k5,k5_avg);
      SetFooterCalcKDosGrid(cField_kgn,kgn_avg);
      SetFooterCalcKDosGrid(cFieldKSI,ksi_avg);

      DBGridEhCalcKDos.SelectedRows.Clear;
      DBGridEhCalcKDos.DataSource.DataSet.First;
      DBGridEhCalcKDos.SelectedRows.CurrentRowSelected:=true;

      ResizeMeasPanelLeft(DBGridEhCalcKDos,MemTableEhCalcKDos);

      ADOQueryCalibrList.Close;

//      Group:=DBGridEhCalcKDos.DataGrouping.GroupLevels.Add;
//      Group.Column:=DBGridEhCalcKDos.FieldColumns[cFullDosID];
//
//      DBGridEhCalcKDos.DataGrouping.DefaultStateExpanded:=true;
//      DBGridEhCalcKDos.DataGrouping.Active:=CBoxGroupByDosNumber.Checked;
//
//      DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_k1).Index].Footer.ValueType:=fvtStaticText;
//      DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(cField_k1).Index].Footer.Font.Size:=12;




//      DBGridEhCalibration.DataGrouping.Footers.Add;
//      DBGridEhCalibration.DataGrouping.FootersDefValues.RunTimeCustomizable:=DBGridEhCalibration.DataGrouping.Active;
//      DBGridEhCalibration.DataGrouping.FootersDefValues.ShowFunctionName:=DBGridEhCalibration.DataGrouping.Active;
//      DBGridEhCalibration.DataGrouping.Footers[0].Visible:=DBGridEhCalibration.DataGrouping.Active;
//      DBGridEhCalibration.DataGrouping.Footers[0].ShowFunctionName:=false;
//      DBGridEhCalibration.DataGrouping.Footers[0].Font.Size:=12;
//      DBGridEhCalibration.DataGrouping.Footers[0].Color := clBtnFace;
//      for i := 0 to DBGridEhCalibration.DataGrouping.Footers[0].ColumnItems.Count - 1 do
//      begin
//        Column := DBGridEhCalibration.FindFieldColumn(DBGridEhCalibration.DataGrouping.Footers[0].ColumnItems[I].FieldName);
//        if (Column <> nil) AND (Column.FieldName=cField_k1) then
//        begin
//          DBGridEhCalibration.DataGrouping.Footers[0].ColumnItems[I].ValueType := gfvAvgEh;
//
//          Column := DBGridEhCalibration.FieldColumns[cField_k1];
//          CurrentNode := DBGridEhCalibration.DataGrouping.GroupDataTree.GetFirst;
//        end;
//      end;
//
//      FooterNode := DBGridEhCalibration.DataGrouping.GroupDataTree.Root;
//      FooterNode.ResetFooters;
    except
      on E: exception do
        MessageDlg(E.Message,mtError, [mbOK], 0);
    end;
  end;
end;

procedure TMainForm.UpdateGridProcessFilter(Filter: String);
var
  measID  : String;
begin
  if TLDDataModule.IsDBConnected then
  begin
    try
      measID:='';
      if MemTableEhProcessList.Active then measID:=DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;
      if ADOQueryProcessList.Active then ADOQueryProcessList.Close;

      // измерения
      ADOQueryProcessList.SQL.Clear;
      // запрос обрабатывает два столбца "dosimeterid" и "postfix", если postfix не равен "-" (символу отсутствия постфикса), то склеиваем столбцы "dosimeterid" и "postfix" вместе для вывода,
      // если если postfix равен "-", то выводим только "dosimeterid"

      ADOQueryProcessList.SQL.Add('SELECT'+' '
                                  +cFieldTldID+','
                                  +cFieldDosMeasID+','
                                  +'CASE '+cFieldDosPostfix+' WHEN '+#39'-'+#39+' THEN CAST('+cFieldDosID+' AS VARCHAR) ELSE CAST (('+cFieldDosID+' || '+cFieldDosPostfix+') AS VARCHAR) END AS '+cFullDosID+','
                                  +cFieldDosType+','
                                  +cFieldMeasureTime+','
                                  +cFieldKSI+','
                                  +'CAST('
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldHp10g+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cHp_10g+'='+#39+'|| ROUND('+cFieldHp10g+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                    +'END'+' '
                                    +'AS VARCHAR'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldHp10n+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cHp_10n+'='+#39+'|| ROUND('+cFieldHp10n+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                    +'END AS VARCHAR'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldHp007+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cHp_007+'='+#39+'|| ROUND('+cFieldHp007+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                    +'END AS VARCHAR'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldHp3+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cHp_3+'='+#39+'|| ROUND('+cFieldHp3+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                    +'END AS VARCHAR'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldHstar+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cH_star+'='+#39+'|| ROUND('+cFieldHstar+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                    +'END AS VARCHAR'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldH007+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cH_007_dir+'='+#39+'|| ROUND('+cFieldH007+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                    +'END AS VARCHAR'+' '
                                    +') ||'+#39+''+#39+'||'+' '
                                  +'CAST('
                                    +'CASE'+' '
                                      +'WHEN ('+cFieldD+' IS NOT NULL)'+' '
                                      +'THEN CAST ('+#39+cD+'='+#39+'|| ROUND('+cFieldD+'::numeric,3) || '+#39+';'+#39+' AS VARCHAR)'+' '
                                      +'ELSE CAST ('+#39+''+#39+' AS VARCHAR)'+' '
                                    +'END AS VARCHAR'
                                    +')'
                                   +'AS VARCHAR)'+' '
                                   +'AS '+cFieldDose+','
                                  +cFieldHp10g+','
                                  +cFieldHp10n+','
                                  +cFieldHp007+','
                                  +cFieldHp3+','
                                  +cFieldHstar+','
                                  +cFieldH007+','
                                  +cFieldD+','
                                  +cFieldHp10g_err+','
                                  +cFieldHp10n_err+','
                                  +cFieldHp007_err+','
                                  +cFieldHp3_err+','
                                  +cFieldHstar_err+','
                                  +cFieldH007_err+','
                                  +cFieldD_err+','
//                                  +'(SELECT '+cFieldDose+' FROM '+cDBTableDetRes+' '
//                                    +'WHERE ('+cDBTableDetRes+'.'+cFieldDosMeasID+' = '+cDBTableDosRes+'.'+cFieldDosMeasID+' AND '+cDBTableDetRes+'.'+cFieldDetPosition+'='+IntToStr(cDetPos1)+') LIMIT 1)'
//                                    +'AS '+cFieldDetector1+','
//                                  +'(SELECT '+cFieldDose+' FROM '+cDBTableDetRes+' '
//                                    +'WHERE ('+cDBTableDetRes+'.'+cFieldDosMeasID+' = '+cDBTableDosRes+'.'+cFieldDosMeasID+' AND '+cDBTableDetRes+'.'+cFieldDetPosition+'='+IntToStr(cDetPos2)+') LIMIT 1)'
//                                    +'AS '+cFieldDetector2+','
//                                  +'(SELECT '+cFieldDose+' FROM '+cDBTableDetRes+' '
//                                    +'WHERE ('+cDBTableDetRes+'.'+cFieldDosMeasID+' = '+cDBTableDosRes+'.'+cFieldDosMeasID+' AND '+cDBTableDetRes+'.'+cFieldDetPosition+'='+IntToStr(cDetPos3)+') LIMIT 1)'
//                                    +'AS '+cFieldDetector3+','
//                                  +'(SELECT '+cFieldDose+' FROM '+cDBTableDetRes+' '
//                                    +'WHERE ('+cDBTableDetRes+'.'+cFieldDosMeasID+' = '+cDBTableDosRes+'.'+cFieldDosMeasID+' AND '+cDBTableDetRes+'.'+cFieldDetPosition+'='+IntToStr(cDetPos4)+') LIMIT 1)'
//                                    +'AS '+cFieldDetector4+','
                                  +cFieldValidity+','
                                  +'CAST('
                                  +' CASE WHEN ('+cFieldValidity+' <= '+IntToStr(cDosMeasFinishedD4)+') OR ('+cFieldValidity+' >= '+IntToStr(cDosMeasStoppedD1)+' AND '+cFieldValidity+' <= '+IntToStr(cDosMeasStoppedD4)+') then '+#39+rsDosNotMeasured+#39
                                    +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasFinished)+' THEN '+#39+rsDosFinished+#39
                                    +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasError)+' THEN '+#39+rsDosMeasErr+#39
                                    +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasWarning)+' THEN '+#39+rsDosMeasWarning+#39
                                    +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasUserWarning)+' THEN '+#39+rsDosMeasForProcessing+#39
                                    +' WHEN '+cFieldValidity+' = '+IntToStr(cDosMeasAccepted)+' THEN '+#39+rsDosAccepted+#39+' ELSE '+#39+rsDosNotMeasured+#39+' END'
                                    +' AS VARCHAR)'
                                    +' AS '+cFieldStringValidity+','
                                  //+cFieldDosType+','
                                  +cFieldRegTime+','
                                  //+cFieldVerTime+','
                                  +'('+'SELECT CASE '+cFieldVerTime+' WHEN '+#39+cZeroDateTime+#39+'THEN null ELSE '+cFieldVerTime+' END '+')'+','
                                  +'('+'SELECT CASE '+cFieldLastMeasTime+' WHEN '+#39+cZeroDateTime+#39+'THEN null ELSE '+cFieldLastMeasTime+' END '+')'+','
                                  +cFieldDosStatus+','
                                  +cFieldOrg+','
                                  +cFieldDepartment+','
                                  +cFieldPartID+','
                                  +cFieldDosPartName+','
                                  +cFieldLastMeasComment+','
                                  +cFieldMeasComment+','
                                  +cFieldPersNumber+','
                                  +cFieldFio+','
                                  +cFieldTldUser+','
                                  +cFieldToDel+' '
                                  +'FROM ' +cDBTableDosRes
                                    + ' WHERE '
                                  +'(CAST ('+cFieldDosID+' AS TEXT) LIKE '+#39+Filter+'%'+#39+' OR CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' LIKE '+#39+Filter+'%'+#39+')'
                                  +' AND '
                                  +GetFilterDosStatus(CBoxProcessStatus)
                                  +' AND '
                                  +GetFilterDosType(CBoxProcessDosType)
                                  +' AND '
                                  +GetFilterDosPartID(CBoxProcessDosPart)
                                  +' AND '
                                  +GetFilterDosOrganization(CBoxProcessOrgName)
                                  +' AND '
                                  +GetFilterDosDepartment(CBoxProcessDep)
                                  +' AND '
                                  +GetFilterDosValidity(CBoxProcessResult)
                                  +' AND '
                                  +GetFilterMeasToDel(ShowDelMeas)
                                  +' AND '
                                  +GetFilterMeasComment(CBoxProcessComment)
                                  +GetFilterDosTime(DateTimePickerProcessFrom,DateTimePickerProcessTo)
                                  +' AND '
                                  +GetFilterDeviceID(CBoxProcessDeviceID)
                                  //**//+GetFilterShowAllDevices(ProcessShowFromAllDevices)
                                  //+'('+cFieldTldID+' = '+IntToStr(DeviceID)+')'
                                  +GetFilterSQL
                                    );
      ADOQueryProcessList.Open;

      if MemTableEhProcessList.Active then MemTableEhProcessList.Active:=false;
      MemTableEhProcessList.Active:=true;

//**      CheckDBGridRowCount(DBGridEhProcess);

      if measID <> '' then DBGridEhProcess.DataSource.DataSet.Locate(cFieldDosMeasID,measID,[]);

      ADOQueryProcessList.Close;
    except
      on E: exception do
        MessageDlg(E.Message,mtError, [mbOK], 0);
    end;
  end;
end;

procedure TMainForm.UpdateBtnFilters;
begin

  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
//      if IsUseFilterCB(CBoxMeasOrgName)
//        OR IsUseFilterEdit(EditMeasDosNumber)
//        OR IsUseFilterCB(CBoxMeasDep)
//        OR IsUseFilterCB(CBoxMeasDosPart)
//        OR IsUseFilterCB(CBoxMeasDosType)
//        OR IsUseFilterCB(CBoxMeasStatus)
//        OR IsUseFilterCB(CBoxMeasPersNumber)
//        OR IsUseFilterCB(CBoxMeasResult)
//        OR IsUseFilterCB(CBoxMeasIDK)
//        OR IsUseFilterCB(CBoxMeasComment)
//        OR IsUseFilterDatePicker(DateTimePickerMeasFrom)
//        OR IsUseFilterDatePicker(DateTimePickerMeasTo)
//        OR IsUseSQLScript
//      then
//      begin
//        SpeedBtnMeasDropAllFilter.Visible:=True;
//      end
//      else
//      begin
//        SpeedBtnMeasDropAllFilter.Visible:=False;
//      end;
    end;
    cPageDosIndex:
    begin
      if IsUseFilterCB(CBoxDosOrgName)
        OR IsUseFilterEdit(EditDosDosNumber)
        OR IsUseFilterCB(CBoxDosDep)
        OR IsUseFilterCB(CBoxDosDosPart)
        OR IsUseFilterCB(CBoxDosDosType)
        OR IsUseFilterCB(CBoxDosStatus)
        OR IsUseFilterCB(CBoxDosDeviceID)
        OR IsUseFilterCB(CBoxDosPersNumber)
//        OR IsUseFilterCB(CBoxDosResult)
        OR IsUseFilterCB(CBoxDosIDK)
//        OR IsUseFilterCB(CBoxDosComment)
//        OR IsUseFilterDatePicker(DateTimePickerDosFrom)
//        OR IsUseFilterDatePicker(DateTimePickerDosTo)
        OR IsUseSQLScript
      then
      begin
        SpeedBtnDosDropAllFilter.Visible:=True;
      end
      else
      begin
        SpeedBtnDosDropAllFilter.Visible:=False;
      end;
    end;
    cPageProcessIndex:
    begin
      if IsUseFilterCB(CBoxProcessOrgName)
        OR IsUseFilterEdit(EditProcessDosNumber)
        OR IsUseFilterCB(CBoxProcessDep)
        OR IsUseFilterCB(CBoxProcessDosPart)
        OR IsUseFilterCB(CBoxProcessDosType)
        OR IsUseFilterCB(CBoxProcessStatus)
        OR IsUseFilterCB(CBoxProcessPersNumber)
        OR IsUseFilterCB(CBoxProcessResult)
        OR IsUseFilterCB(CBoxProcessIDK)
        OR IsUseFilterCB(CBoxProcessComment)
        OR IsUseFilterCB(CBoxProcessDeviceID)
        OR IsUseFilterDatePicker(DateTimePickerProcessFrom)
        OR IsUseFilterDatePicker(DateTimePickerProcessTo)
        OR IsUseSQLScript
      then
      begin
        SpeedBtnProcessDropAllFilter.Visible:=True;
      end
      else
      begin
        SpeedBtnProcessDropAllFilter.Visible:=False;
      end;
    end;

  end;

end;

procedure TMainForm.LoadComboBoxValue(ComboBox: TComboBox; Value: String; Btn: TSpeedButton);
begin
  if (ComboBox.Items.IndexOf(Value) >= 0) AND (Value <> '')then
    ComboBox.ItemIndex := ComboBox.Items.IndexOf(Value)
  else
    CheckComboBox(ComboBox,Btn,false);
end;

procedure TMainForm.UpdateMeasComment(EditComment: TEdit; Comment: String);
var
  i           : integer;
  grid        : TDBGridEh;
  measID      : integer;
  temp        : word;
  dosNumbers  : String;
  index       : integer;
  procedure UpdateComment(Comment: String; MeasID: integer);
  begin
    if TLDDataModule.ADOQuery.Active then TLDDataModule.ADOQuery.Close;
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosRes+' SET '
                                                                  +cFieldMeasComment
                                                                  +' = '
                                                                  +#39+Comment+#39
                                                                  +' WHERE '+cFieldDosMeasID+' = '+IntToStr(MeasID));
    TLDDataModule.ADOQuery.ExecSQL;
    if TLDDataModule.ADOQuery.Active then TLDDataModule.ADOQuery.Close;
  end;
  procedure LocalCheckEdit;
  begin
    if EditComment.Text<>'' then Dosimeter.MeasComment:=EditComment.Text else Dosimeter.MeasComment:='';
  end;
begin
  dosNumbers:='';

  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex: grid:=DBGridEhOnlyMeas;
    cPageProcessIndex: grid:=DBGridEhProcess;
    else
      grid:=DBGridEhOnlyMeas;
  end;

  index:=grid.DataSource.DataSet.RecNo;

  if grid.SelectedRows.Count > 0 then
  begin
    if grid.SelectedRows.Count > 1 then
    begin
      for i := 0 to grid.SelectedRows.Count-1 do
      begin
        grid.DataSource.DataSet.GotoBookmark(grid.SelectedRows.Items[i]);
        dosNumbers:=dosNumbers+'"'+grid.DataSource.DataSet.FieldByName(cFullDosID).AsString+'" ';
      end;

      temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s (%d %s)?',[rsSaveChanges4MeasGroup,grid.SelectedRows.Count,rsNums]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');
      case temp of
        mrYes:
        begin
          LocalCheckEdit;

          for i := 0 to grid.SelectedRows.Count-1 do
          begin
            grid.DataSource.DataSet.GotoBookmark(grid.SelectedRows.Items[i]);
            measID:=grid.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsInteger;
            UpdateComment(Comment,measID);
          end;
        end;
      end;
    end
    else
    begin
      LocalCheckEdit;

      for i := 0 to grid.SelectedRows.Count-1 do
      begin
        grid.DataSource.DataSet.GotoBookmark(grid.SelectedRows.Items[i]);
        measID:=grid.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsInteger;
        UpdateComment(Comment,measID);
      end;
    end;
  end
  else
  begin
    LocalCheckEdit;
    UpdateComment(Comment,Dosimeter.MeasurementID);
  end;

  UpdateGridMeasPage;
  UpdateGridProcessPage;

  grid.DataSource.DataSet.RecNo:=index;
  grid.SelectedRows.CurrentRowSelected:=true;

  GetMeasData;
end;

procedure TMainForm.UpdateDosimeterIDKParam(EditFio,EditPersNumber,EditOrg,EditDep: TEdit);
var
  i           : integer;
  grid        : TDBGridEh;
  measID      : integer;
  temp        : word;
  dosNumbers  : String;
  index       : integer;
  procedure UpdateIDKParam(FIO,Org,Dep: String; PersNumber, MeasID: integer);
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosRes+' SET ('
                                                                    +cFieldPersNumber+','
                                                                    +cFieldFio+','
                                                                    +cFieldOrg+','
                                                                    +cFieldDepartment+' '
                                                                 +') '
                                                                 +'= ('
                                                                    +IntToStr(PersNumber)+','
                                                                    +#39+FIO+#39+','
                                                                    +#39+Org+#39+','
                                                                    +#39+Dep+#39+' '
                                                                 +') '
                                                                 +' WHERE '+cFieldDosMeasID+' = '+IntToStr(MeasID));
    TLDDataModule.ADOQuery.ExecSQL;
  end;
  procedure LocalCheckEdit;
  begin
    if EditFio.Text<>'' then Dosimeter.Fio:=EditFio.Text else Dosimeter.Fio:='';
    if EditPersNumber.Text<>'' then Dosimeter.PersNumber:=StrToIntRegion(EditPersNumber.Text) else Dosimeter.PersNumber:=-1;
    if EditOrg.Text<>'' then Dosimeter.Organization:=EditOrg.Text else Dosimeter.Organization:='';
    if EditDep.Text<>'' then Dosimeter.Department:=EditDep.Text else Dosimeter.Department:='';
  end;
begin
  dosNumbers:='';

  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex: grid:=DBGridEhOnlyMeas;
    cPageProcessIndex: grid:=DBGridEhProcess;
    else
      grid:=DBGridEhOnlyMeas;
  end;

  index:=grid.DataSource.DataSet.RecNo;

  if grid.SelectedRows.Count > 0 then
  begin
    if grid.SelectedRows.Count > 1 then
    begin
      for i := 0 to grid.SelectedRows.Count-1 do
      begin
        grid.DataSource.DataSet.GotoBookmark(grid.SelectedRows.Items[i]);
        dosNumbers:=dosNumbers+'"'+grid.DataSource.DataSet.FieldByName(cFullDosID).AsString+'" ';
      end;

      temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s (%d %s)?',[rsSaveChanges4MeasGroup,grid.SelectedRows.Count,rsNums]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');
      case temp of
        mrYes:
        begin
          LocalCheckEdit;

          for i := 0 to grid.SelectedRows.Count-1 do
          begin
            grid.DataSource.DataSet.GotoBookmark(grid.SelectedRows.Items[i]);
            measID:=grid.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsInteger;
            UpdateIDKParam(Dosimeter.Fio,Dosimeter.Organization,Dosimeter.Department,Dosimeter.PersNumber,measID);
          end;
        end;
      end;
    end
    else
    begin
      LocalCheckEdit;

      for i := 0 to grid.SelectedRows.Count-1 do
      begin
        grid.DataSource.DataSet.GotoBookmark(grid.SelectedRows.Items[i]);
        measID:=grid.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsInteger;

        UpdateIDKParam(Dosimeter.Fio,Dosimeter.Organization,Dosimeter.Department,Dosimeter.PersNumber,measID);
      end;
    end;
  end
  else
  begin
    LocalCheckEdit;
    UpdateIDKParam(Dosimeter.Fio,Dosimeter.Organization,Dosimeter.Department,Dosimeter.PersNumber,Dosimeter.MeasurementID);
  end;

  UpdateGridMeasPage;
  UpdateGridProcessPage;


	grid.DataSource.DataSet.RecNo:=index;
	grid.SelectedRows.CurrentRowSelected:=true;

  GetMeasData;
end;

procedure TMainForm.UpdateMemoDosInf(Filter: String);
var
  DosCnt    : String;
  MeasCnt   : String;
begin
  ListDosInf.Clear;
  ListMeasInf.Clear;

  if TLDDataModule.IsDBConnected then
  begin
    // количество дозиметров
    if TLDDataModule.ADOQuery.Active then TLDDataModule.ADOQuery.Close;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('select count (*) from tlddosimeterid where dosimeterid like '+#39+Filter+'%'+#39);
    TLDDataModule.ADOQuery.Open;
    DosCnt:=rsSmDosimeters+': '+TLDDataModule.ADOQuery.FieldByName('count').AsString;
    ListDosInf.Add(DosCnt);
  end;

  // измерения
  if TLDDataModule.ADOQuery.Active then TLDDataModule.ADOQuery.Close;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('select count (*) from tlddosimeterres where dosimeterid like '+#39+Filter+'%'+#39);
  TLDDataModule.ADOQuery.Open;
  MeasCnt:=rsAllMeasures+': '+TLDDataModule.ADOQuery.FieldByName('count').AsString;
  ListMeasInf.Add(MeasCnt);

  TLDDataModule.ADOQuery.Close;
end;

procedure TMainForm.CheckFilters;
begin

//  if IsUseFilterEdit(EditDosDosNumber) then ChangeEdit(EditDosDosNumber,SpBtnDosDropDosNumber,true);
//  if IsUseFilterCB(CBoxDosOrgName) then ChangeComboBox(CBoxDosOrgName,SpBtnDosDropOrgName,True);
//  if IsUseFilterCB(CBoxDosDep) then ChangeComboBox(CBoxDosDep,SpBtnDosDropDep,True);
//  if IsUseFilterCB(CBoxDosDosPart) then ChangeComboBox(CBoxDosDosPart,SpBtnDosDropDosPart,True);
//  if IsUseFilterCB(CBoxDosDosType) then ChangeComboBox(CBoxDosDosType,SpBtnDosDropDosType,True);
//  if IsUseFilterCB(CBoxDosStatus) then ChangeComboBox(CBoxDosStatus,SpBtnDosDropStatus,True);
//  if IsUseFilterCB(CBoxDosPersNumber) then ChangeComboBox(CBoxDosPersNumber,SpBtnDosDropPersNumber,True);
//  if IsUseFilterCB(CBoxDosIDK) then ChangeComboBox(CBoxDosIDK,SpBtnDosDropIDK,True);
//  if IsUseFilterCB(CBoxDosComment) then ChangeComboBox(CBoxDosComment,SpBtnDosDropComment,True);
//  if IsUseFilterDatePicker(DateTimePickerDosFrom) then ChangeDatePicker(DateTimePickerDosFrom,SpBtnDosDropDateFrom,True);
//  if IsUseFilterDatePicker(DateTimePickerDosTo) then ChangeDatePicker(DateTimePickerDosTo,SpBtnDosDropDateTo,True);
//  if IsUseSQLScript then SQLScriptChange(true);
//
//  if IsUseFilterEdit(EditProcessDosNumber) then ChangeEdit(EditProcessDosNumber,SpBtnProcessDropDosNumber,true);
//  if IsUseFilterCB(CBoxProcessOrgName) then ChangeComboBox(CBoxProcessOrgName,SpBtnProcessDropOrgName,True);
//  if IsUseFilterCB(CBoxProcessDep) then ChangeComboBox(CBoxProcessDep,SpBtnProcessDropDep,True);
//  if IsUseFilterCB(CBoxProcessDosPart) then ChangeComboBox(CBoxProcessDosPart,SpBtnProcessDropDosPart,True);
//  if IsUseFilterCB(CBoxProcessDosType) then ChangeComboBox(CBoxProcessDosType,SpBtnProcessDropDosType,True);
//  if IsUseFilterCB(CBoxProcessStatus) then ChangeComboBox(CBoxProcessStatus,SpBtnProcessDropStatus,True);
//  if IsUseFilterCB(CBoxProcessPersNumber) then ChangeComboBox(CBoxProcessPersNumber,SpBtnProcessDropPersNumber,True);
//  if IsUseFilterCB(CBoxProcessIDK) then ChangeComboBox(CBoxProcessIDK,SpBtnProcessDropIDK,True);
//  if IsUseFilterCB(CBoxProcessResult) then ChangeComboBox(CBoxProcessResult,SpBtnProcessDropResult,True);
//  if IsUseFilterCB(CBoxProcessComment) then ChangeComboBox(CBoxProcessComment,SpBtnProcessDropComment,True);
//  if IsUseFilterDatePicker(DateTimePickerProcessFrom) then ChangeDatePicker(DateTimePickerProcessFrom,SpBtnProcessDropDateFrom,True);
//  if IsUseFilterDatePicker(DateTimePickerProcessTo) then ChangeDatePicker(DateTimePickerProcessTo,SpBtnProcessDropDateTo,True);
//      if IsUseSQLScript then SQLScriptChange(true);




  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
//      if IsUseFilterEdit(EditMeasDosNumber) then ChangeEdit(EditMeasDosNumber,SpBtnMeasDropDosNumber,true);
//      if IsUseFilterCB(CBoxMeasOrgName) then ChangeComboBox(CBoxMeasOrgName,SpBtnMeasDropOrgName,True);
//      if IsUseFilterCB(CBoxMeasDep) then ChangeComboBox(CBoxMeasDep,SpBtnMeasDropDep,True);
//      if IsUseFilterCB(CBoxMeasDosPart) then ChangeComboBox(CBoxMeasDosPart,SpBtnMeasDropDosPart,True);
//      if IsUseFilterCB(CBoxMeasDosType) then ChangeComboBox(CBoxMeasDosType,SpBtnMeasDropDosType,True);
//      if IsUseFilterCB(CBoxMeasStatus) then ChangeComboBox(CBoxMeasStatus,SpBtnMeasDropStatus,True);
//      if IsUseFilterCB(CBoxMeasPersNumber) then ChangeComboBox(CBoxMeasPersNumber,SpBtnMeasDropPersNumber,True);
//      if IsUseFilterCB(CBoxMeasIDK) then ChangeComboBox(CBoxMeasIDK,SpBtnMeasDropIDK,True);
//      if IsUseFilterCB(CBoxMeasResult) then ChangeComboBox(CBoxMeasResult,SpBtnMeasDropResult,True);
//      if IsUseFilterCB(CBoxMeasComment) then ChangeComboBox(CBoxMeasComment,SpBtnMeasDropComment,True);
//      if IsUseFilterDatePicker(DateTimePickerMeasFrom) then ChangeDatePicker(DateTimePickerMeasFrom,SpBtnMeasDropDateFrom,True);
//      if IsUseFilterDatePicker(DateTimePickerMeasTo) then ChangeDatePicker(DateTimePickerMeasTo,SpBtnMeasDropDateTo,True);
//      if IsUseSQLScript then SQLScriptChange(true);
    end;
    cPageDosIndex:
    begin
      if IsUseFilterEdit(EditDosDosNumber) then ChangeEdit(EditDosDosNumber,SpBtnDosDropDosNumber,true);
      if IsUseFilterCB(CBoxDosOrgName) then ChangeComboBox(CBoxDosOrgName,SpBtnDosDropOrgName,True);
      if IsUseFilterCB(CBoxDosDep) then ChangeComboBox(CBoxDosDep,SpBtnDosDropDep,True);
      if IsUseFilterCB(CBoxDosDosPart) then ChangeComboBox(CBoxDosDosPart,SpBtnDosDropDosPart,True);
      if IsUseFilterCB(CBoxDosDosType) then ChangeComboBox(CBoxDosDosType,SpBtnDosDropDosType,True);
      if IsUseFilterCB(CBoxDosStatus) then ChangeComboBox(CBoxDosStatus,SpBtnDosDropStatus,True);
      if IsUseFilterCB(CBoxDosPersNumber) then ChangeComboBox(CBoxDosPersNumber,SpBtnDosDropPersNumber,True);
      if IsUseFilterCB(CBoxDosIDK) then ChangeComboBox(CBoxDosIDK,SpBtnDosDropIDK,True);
      if IsUseFilterCB(CBoxDosDeviceID) then ChangeComboBox(CBoxDosDeviceID,SpBtnDosDropDevID,True);
      if IsUseFilterCB(CBoxDosComment) then ChangeComboBox(CBoxDosComment,SpBtnDosDropComment,True);
      if IsUseFilterDatePicker(DateTimePickerDosFrom) then ChangeDatePicker(DateTimePickerDosFrom,SpBtnDosDropDateFrom,True);
      if IsUseFilterDatePicker(DateTimePickerDosTo) then ChangeDatePicker(DateTimePickerDosTo,SpBtnDosDropDateTo,True);
      if IsUseSQLScript then SQLScriptChange(true);
    end;
    cPageProcessIndex:
    begin
      if IsUseFilterEdit(EditProcessDosNumber) then ChangeEdit(EditProcessDosNumber,SpBtnProcessDropDosNumber,true);
      if IsUseFilterCB(CBoxProcessOrgName) then ChangeComboBox(CBoxProcessOrgName,SpBtnProcessDropOrgName,True);
      if IsUseFilterCB(CBoxProcessDep) then ChangeComboBox(CBoxProcessDep,SpBtnProcessDropDep,True);
      if IsUseFilterCB(CBoxProcessDosPart) then ChangeComboBox(CBoxProcessDosPart,SpBtnProcessDropDosPart,True);
      if IsUseFilterCB(CBoxProcessDosType) then ChangeComboBox(CBoxProcessDosType,SpBtnProcessDropDosType,True);
      if IsUseFilterCB(CBoxProcessStatus) then ChangeComboBox(CBoxProcessStatus,SpBtnProcessDropStatus,True);
      if IsUseFilterCB(CBoxProcessPersNumber) then ChangeComboBox(CBoxProcessPersNumber,SpBtnProcessDropPersNumber,True);
      if IsUseFilterCB(CBoxProcessIDK) then ChangeComboBox(CBoxProcessIDK,SpBtnProcessDropIDK,True);
      if IsUseFilterCB(CBoxProcessResult) then ChangeComboBox(CBoxProcessResult,SpBtnProcessDropResult,True);
      if IsUseFilterCB(CBoxProcessComment) then ChangeComboBox(CBoxProcessComment,SpBtnProcessDropComment,True);
      if IsUseFilterCB(CBoxProcessDeviceID) then ChangeComboBox(CBoxProcessDeviceID,SpBtnProcessDropDevID,True);
      if IsUseFilterDatePicker(DateTimePickerProcessFrom) then ChangeDatePicker(DateTimePickerProcessFrom,SpBtnProcessDropDateFrom,True);
      if IsUseFilterDatePicker(DateTimePickerProcessTo) then ChangeDatePicker(DateTimePickerProcessTo,SpBtnProcessDropDateTo,True);
      if IsUseSQLScript then SQLScriptChange(true);
    end;
  end;

end;

procedure TMainForm.CheckFiltersAll;
begin
  if IsUseFilterEdit(EditDosDosNumber) then ChangeEdit(EditDosDosNumber,SpBtnDosDropDosNumber,true);
  if IsUseFilterCB(CBoxDosOrgName) then ChangeComboBox(CBoxDosOrgName,SpBtnDosDropOrgName,True);
  if IsUseFilterCB(CBoxDosDep) then ChangeComboBox(CBoxDosDep,SpBtnDosDropDep,True);
  if IsUseFilterCB(CBoxDosDosPart) then ChangeComboBox(CBoxDosDosPart,SpBtnDosDropDosPart,True);
  if IsUseFilterCB(CBoxDosDosType) then ChangeComboBox(CBoxDosDosType,SpBtnDosDropDosType,True);
  if IsUseFilterCB(CBoxDosStatus) then ChangeComboBox(CBoxDosStatus,SpBtnDosDropStatus,True);
  if IsUseFilterCB(CBoxDosDeviceID) then ChangeComboBox(CBoxDosDeviceID,SpBtnDosDropDevID,True);
  if IsUseFilterCB(CBoxDosPersNumber) then ChangeComboBox(CBoxDosPersNumber,SpBtnDosDropPersNumber,True);
  if IsUseFilterCB(CBoxDosIDK) then ChangeComboBox(CBoxDosIDK,SpBtnDosDropIDK,True);
  if IsUseFilterCB(CBoxDosComment) then ChangeComboBox(CBoxDosComment,SpBtnDosDropComment,True);
  if IsUseFilterDatePicker(DateTimePickerDosFrom) then ChangeDatePicker(DateTimePickerDosFrom,SpBtnDosDropDateFrom,True);
  if IsUseFilterDatePicker(DateTimePickerDosTo) then ChangeDatePicker(DateTimePickerDosTo,SpBtnDosDropDateTo,True);
  if IsUseFilterEdit(EditProcessDosNumber) then ChangeEdit(EditProcessDosNumber,SpBtnProcessDropDosNumber,true);
  if IsUseFilterCB(CBoxProcessOrgName) then ChangeComboBox(CBoxProcessOrgName,SpBtnProcessDropOrgName,True);
  if IsUseFilterCB(CBoxProcessDep) then ChangeComboBox(CBoxProcessDep,SpBtnProcessDropDep,True);
  if IsUseFilterCB(CBoxProcessDosPart) then ChangeComboBox(CBoxProcessDosPart,SpBtnProcessDropDosPart,True);
  if IsUseFilterCB(CBoxProcessDosType) then ChangeComboBox(CBoxProcessDosType,SpBtnProcessDropDosType,True);
  if IsUseFilterCB(CBoxProcessStatus) then ChangeComboBox(CBoxProcessStatus,SpBtnProcessDropStatus,True);
  if IsUseFilterCB(CBoxProcessPersNumber) then ChangeComboBox(CBoxProcessPersNumber,SpBtnProcessDropPersNumber,True);
  if IsUseFilterCB(CBoxProcessIDK) then ChangeComboBox(CBoxProcessIDK,SpBtnProcessDropIDK,True);
  if IsUseFilterCB(CBoxProcessResult) then ChangeComboBox(CBoxProcessResult,SpBtnProcessDropResult,True);
  if IsUseFilterCB(CBoxProcessDeviceID) then ChangeComboBox(CBoxProcessDeviceID,SpBtnProcessDropDevID,True);
  if IsUseFilterCB(CBoxProcessComment) then ChangeComboBox(CBoxProcessComment,SpBtnProcessDropComment,True);
  if IsUseFilterDatePicker(DateTimePickerProcessFrom) then ChangeDatePicker(DateTimePickerProcessFrom,SpBtnProcessDropDateFrom,True);
  if IsUseFilterDatePicker(DateTimePickerProcessTo) then ChangeDatePicker(DateTimePickerProcessTo,SpBtnProcessDropDateTo,True);
  if IsUseSQLScript then SQLScriptChange(true);
end;

procedure TMainForm.UpdateFinishMeasureW;
begin
  FinishMeasureW.MemoCommentD1.Lines.Clear;
  FinishMeasureW.MemoCommentD2.Lines.Clear;
  FinishMeasureW.MemoCommentD3.Lines.Clear;
  FinishMeasureW.MemoCommentD4.Lines.Clear;

  if Assigned(Dosimeter) then
  begin

    if Pos(Dosimeter.DosType,FinishMeasureW.LblDosNumberAndType.Caption) = 0 then
      FinishMeasureW.LblDosNumberAndType.Caption:=Format('%s (%s)',[Dosimeter.FullNumber,Dosimeter.DosType]);

    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        ChangeDosDoseEdit(FinishMeasureW.EditDose,
                          Dosimeter.Validity,
                          EditMeasDataDose.Text);
      end;
      cPageProcessIndex:
      begin
        ChangeDosDoseEdit(FinishMeasureW.EditDose,
                          Dosimeter.Validity,
                          EditProcessDataDose.Text);
      end;
    end;

    ChangeDosValidityEdit(FinishMeasureW.EditDosStatus,Dosimeter.Validity);

    if Dosimeter.PersNumber = -1 then
    begin
      ChangeStringEdit(FinishMeasureW.EditDosPersNumberVal,'',clWhite);
      ChangeStringEdit(FinishMeasureW.EditDosIDKState,rsNotBind,clBtnFace);
    end
    else
    begin
      ChangeStringEdit(FinishMeasureW.EditDosPersNumberVal,IntToStr(Dosimeter.PersNumber),clWhite);
      ChangeStringEdit(FinishMeasureW.EditDosIDKState,rsBind,clBtnFace);
    end;


    FinishMeasureW.EditDosKSVal.Text:=IntToStr(Dosimeter.KS);
    FinishMeasureW.EditKVal.Text:=LblMeasDataKDosVal.Caption;
    FinishMeasureW.EditLFormulaDosVal.Text:=Dosimeter.Formula;
    FinishMeasureW.EditDosMeasTimeVal.Text:=DateTimeToStrRegion(Dosimeter.MeasTime);
    FinishMeasureW.EditDosVerVal.Text:=DateToStrRegion(Dosimeter.VerTime);
    FinishMeasureW.EditDosFIO.Text:=Dosimeter.Fio;
    FinishMeasureW.EditDosOrgVal.Text:=Dosimeter.Organization;
    FinishMeasureW.EditDosDepVal.Text:=Dosimeter.Department;
    FinishMeasureW.EditDosPart.Text:=IntToStr(Dosimeter.PartID);
    FinishMeasureW.EditDosComment.Text:=Dosimeter.MeasComment;


    if Assigned(Dosimeter.DetectorsList[0]) then
    begin
      SetDetEdit(FinishMeasureW.EditDoseD1,FloatToStrRegion(TDetector(Dosimeter.DetectorsList[0]).Dose),TDetector(Dosimeter.DetectorsList[0]).State);
      SetDetEdit(FinishMeasureW.EditErrD1,FloatToStrRegion(TDetector(Dosimeter.DetectorsList[0]).Err),TDetector(Dosimeter.DetectorsList[0]).State);
      SetDetStateEdit(FinishMeasureW.EditStatusD1,TDetector(Dosimeter.DetectorsList[0]).State);
      FinishMeasureW.LblTypeValD1.Caption:=TDetector(Dosimeter.DetectorsList[0]).DetType;
      if TDetector(Dosimeter.DetectorsList[0]).Comment <> '' then FinishMeasureW.MemoCommentD1.Lines.Add(TDetector(Dosimeter.DetectorsList[0]).Comment);

      FinishMeasureW.LblD1.Visible:=True;
      FinishMeasureW.LblDoseD1.Visible:=True;
      FinishMeasureW.LblErrD1.Visible:=True;
      FinishMeasureW.LblStatusD1.Visible:=True;
      FinishMeasureW.LblTypeD1.Visible:=True;
      FinishMeasureW.LblCommentD1.Visible:=True;
      FinishMeasureW.MemoCommentD1.Visible:=True;
      FinishMeasureW.EditDoseD1.Visible:=True;
      FinishMeasureW.EditErrD1.Visible:=True;
      FinishMeasureW.EditStatusD1.Visible:=True;
      FinishMeasureW.LblTypeValD1.Visible:=True;
    end
    else
    begin
      FinishMeasureW.LblD1.Visible:=False;
      FinishMeasureW.LblDoseD1.Visible:=False;
      FinishMeasureW.LblErrD1.Visible:=False;
      FinishMeasureW.LblStatusD1.Visible:=False;
      FinishMeasureW.LblTypeD1.Visible:=False;
      FinishMeasureW.LblCommentD1.Visible:=False;
      FinishMeasureW.MemoCommentD1.Visible:=False;
      FinishMeasureW.EditDoseD1.Visible:=False;
      FinishMeasureW.EditErrD1.Visible:=False;
      FinishMeasureW.EditStatusD1.Visible:=False;
      FinishMeasureW.LblTypeValD1.Visible:=False;
    end;

    if Assigned(Dosimeter.DetectorsList[1]) then
    begin
      SetDetEdit(FinishMeasureW.EditDoseD2,FloatToStrRegion(TDetector(Dosimeter.DetectorsList[1]).Dose),TDetector(Dosimeter.DetectorsList[1]).State);
      SetDetEdit(FinishMeasureW.EditErrD2,FloatToStrRegion(TDetector(Dosimeter.DetectorsList[1]).Err),TDetector(Dosimeter.DetectorsList[1]).State);
      SetDetStateEdit(FinishMeasureW.EditStatusD2,TDetector(Dosimeter.DetectorsList[1]).State);
      FinishMeasureW.LblTypeValD2.Caption:=TDetector(Dosimeter.DetectorsList[1]).DetType;
      if TDetector(Dosimeter.DetectorsList[1]).Comment <> '' then FinishMeasureW.MemoCommentD2.Lines.Add(TDetector(Dosimeter.DetectorsList[1]).Comment);

      FinishMeasureW.LblD2.Visible:=True;
      FinishMeasureW.LblDoseD2.Visible:=True;
      FinishMeasureW.LblErrD2.Visible:=True;
      FinishMeasureW.LblStatusD2.Visible:=True;
      FinishMeasureW.LblTypeD2.Visible:=True;
      FinishMeasureW.LblCommentD2.Visible:=True;
      FinishMeasureW.MemoCommentD2.Visible:=True;
      FinishMeasureW.EditDoseD2.Visible:=True;
      FinishMeasureW.EditErrD2.Visible:=True;
      FinishMeasureW.EditStatusD2.Visible:=True;
      FinishMeasureW.LblTypeValD2.Visible:=True;
    end
    else
    begin
      FinishMeasureW.LblD2.Visible:=False;
      FinishMeasureW.LblDoseD2.Visible:=False;
      FinishMeasureW.LblErrD2.Visible:=False;
      FinishMeasureW.LblStatusD2.Visible:=False;
      FinishMeasureW.LblTypeD2.Visible:=False;
      FinishMeasureW.LblCommentD2.Visible:=False;
      FinishMeasureW.MemoCommentD2.Visible:=False;
      FinishMeasureW.EditDoseD2.Visible:=False;
      FinishMeasureW.EditErrD2.Visible:=False;
      FinishMeasureW.EditStatusD2.Visible:=False;
      FinishMeasureW.LblTypeValD2.Visible:=False;
    end;

    if Assigned(Dosimeter.DetectorsList[2]) then
    begin
      SetDetEdit(FinishMeasureW.EditDoseD3,FloatToStrRegion(TDetector(Dosimeter.DetectorsList[2]).Dose),TDetector(Dosimeter.DetectorsList[2]).State);
      SetDetEdit(FinishMeasureW.EditErrD3,FloatToStrRegion(TDetector(Dosimeter.DetectorsList[2]).Err),TDetector(Dosimeter.DetectorsList[2]).State);
      SetDetStateEdit(FinishMeasureW.EditStatusD3,TDetector(Dosimeter.DetectorsList[2]).State);
      FinishMeasureW.LblTypeValD3.Caption:=TDetector(Dosimeter.DetectorsList[2]).DetType;
      if TDetector(Dosimeter.DetectorsList[2]).Comment <> '' then FinishMeasureW.MemoCommentD3.Lines.Add(TDetector(Dosimeter.DetectorsList[2]).Comment);

      FinishMeasureW.LblD3.Visible:=True;
      FinishMeasureW.LblDoseD3.Visible:=True;
      FinishMeasureW.LblErrD3.Visible:=True;
      FinishMeasureW.LblStatusD3.Visible:=True;
      FinishMeasureW.LblTypeD3.Visible:=True;
      FinishMeasureW.LblCommentD3.Visible:=True;
      FinishMeasureW.MemoCommentD3.Visible:=True;
      FinishMeasureW.EditDoseD3.Visible:=True;
      FinishMeasureW.EditErrD3.Visible:=True;
      FinishMeasureW.EditStatusD3.Visible:=True;
      FinishMeasureW.LblTypeValD3.Visible:=True;
    end
    else
    begin
      FinishMeasureW.LblD3.Visible:=False;
      FinishMeasureW.LblDoseD3.Visible:=False;
      FinishMeasureW.LblErrD3.Visible:=False;
      FinishMeasureW.LblStatusD3.Visible:=False;
      FinishMeasureW.LblTypeD3.Visible:=False;
      FinishMeasureW.LblCommentD3.Visible:=False;
      FinishMeasureW.MemoCommentD3.Visible:=False;
      FinishMeasureW.EditDoseD3.Visible:=False;
      FinishMeasureW.EditErrD3.Visible:=False;
      FinishMeasureW.EditStatusD3.Visible:=False;
      FinishMeasureW.LblTypeValD3.Visible:=False;
    end;

    if Assigned(Dosimeter.DetectorsList[3]) then
    begin
      SetDetEdit(FinishMeasureW.EditDoseD4,FloatToStrRegion(TDetector(Dosimeter.DetectorsList[3]).Dose),TDetector(Dosimeter.DetectorsList[3]).State);
      SetDetEdit(FinishMeasureW.EditErrD4,FloatToStrRegion(TDetector(Dosimeter.DetectorsList[3]).Err),TDetector(Dosimeter.DetectorsList[3]).State);
      SetDetStateEdit(FinishMeasureW.EditStatusD4,TDetector(Dosimeter.DetectorsList[3]).State);
      FinishMeasureW.LblTypeValD4.Caption:=TDetector(Dosimeter.DetectorsList[3]).DetType;
      if TDetector(Dosimeter.DetectorsList[3]).Comment <> '' then FinishMeasureW.MemoCommentD4.Lines.Add(TDetector(Dosimeter.DetectorsList[3]).Comment);

      FinishMeasureW.LblD4.Visible:=True;
      FinishMeasureW.LblDoseD4.Visible:=True;
      FinishMeasureW.LblErrD4.Visible:=True;
      FinishMeasureW.LblStatusD4.Visible:=True;
      FinishMeasureW.LblTypeD4.Visible:=True;
      FinishMeasureW.LblCommentD4.Visible:=True;
      FinishMeasureW.MemoCommentD4.Visible:=True;
      FinishMeasureW.EditDoseD4.Visible:=True;
      FinishMeasureW.EditErrD4.Visible:=True;
      FinishMeasureW.EditStatusD4.Visible:=True;
      FinishMeasureW.LblTypeValD4.Visible:=True;
    end
    else
    begin
      FinishMeasureW.LblD4.Visible:=False;
      FinishMeasureW.LblDoseD4.Visible:=False;
      FinishMeasureW.LblErrD4.Visible:=False;
      FinishMeasureW.LblStatusD4.Visible:=False;
      FinishMeasureW.LblTypeD4.Visible:=False;
      FinishMeasureW.LblCommentD4.Visible:=False;
      FinishMeasureW.MemoCommentD4.Visible:=False;
      FinishMeasureW.EditDoseD4.Visible:=False;
      FinishMeasureW.EditErrD4.Visible:=False;
      FinishMeasureW.EditStatusD4.Visible:=False;
      FinishMeasureW.LblTypeValD4.Visible:=False;
    end;
  end;
end;

procedure TMainForm.ShowFinishMeasureW(NewMeasure: boolean);
begin
  UpdateFinishMeasureW;
  FinishMeasureW.NewMeasure:=NewMeasure;
  if not FinishMeasureW.BtnCancel.Visible then FinishMeasureW.BtnCancel.Visible:=true;
  FinishMeasureW.ShowModal;
end;

procedure TMainForm.ShowDetectorDataGlade(SeriaImpuls,SeriaGalde: TLineSeries);
// функция сглаживания взята из расчетного модуля
var
  i,j       : integer;
  r         : integer;
  n         : integer;
  icL, icR  : integer;
  BuffAvg   : TDarray;
  b: integer;
begin
  icL := 0;

  FillChar(BuffAvg, SizeOf(BuffAvg), #0);

  SeriaGalde.Clear;

  if (SeriaImpuls.Count > 0) then
  for i := 0 to Length(BuffAvg)-1 do
  begin
    b:=SeriaImpuls.Count;

    if (i < SeriaImpuls.Count) then
    begin
      if (SeriaImpuls.YValue[icL] <> SeriaImpuls.YValue[i]) or (i = Length(BuffAvg)-1) then
      begin
        icR := i;
        r := 0;
        for n := icL to icR do
        begin
          r := r + Trunc(SeriaImpuls.YValue[n]); // сумма для среднего
        end;
        for j := icL to icR do
          BuffAvg[j] := r / (icR - icL + 1);
        if (icR <> Length(BuffAvg)-1) and (icR + 1 < SeriaImpuls.Count) and ((SeriaImpuls.YValue[icR] - SeriaImpuls.YValue[icR - 1]) *
          (SeriaImpuls.YValue[icR + 1] - SeriaImpuls.YValue[icR]) > 0) and
          (icR - icL = 1) then
        // монотонные изменения на отрезке в 2 канала
        begin
          BuffAvg[icL] := SeriaImpuls.YValue[icL];
          BuffAvg[icR] := SeriaImpuls.YValue[icR];
        end;
        icL := icR + 1;
        if icL>=SeriaImpuls.Count then icL:=SeriaImpuls.Count-1;
      end;
    end;
  end;

  for i := 0 to Length(BuffAvg)-1 do
    SeriaGalde.AddXY(i,BuffAvg[i]);
end;

procedure TMainForm.ShowMeasGridColumns(Field: String; const Value: boolean);
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      DBGridEhOnlyMeas.Columns[DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(Field).Index].Visible:=Value;
      ResizeMeasPanelLeft(DBGridEhOnlyMeas,MemTableEhMeasList);
    end;
    cPageProcessIndex:
    begin
      DBGridEhProcess.Columns[DBGridEhProcess.DataSource.DataSet.FieldByName(Field).Index].Visible:=Value;
      ResizeMeasPanelLeft(DBGridEhProcess,MemTableEhProcessList);
    end;
    cPageCalibrationIndex:
    begin
      DBGridEhCalcKDos.Columns[DBGridEhCalcKDos.DataSource.DataSet.FieldByName(Field).Index].Visible:=Value;
      //ResizeMeasPanelLeft(DBGridEhCalibration,MemTableEhCalibrList);
      ResizeMeasPanelLeft(DBGridEhCalcKDos,MemTableEhCalcKDos);
    end;
  end;
end;

procedure TMainForm.ChangeDosNumber;
begin
  if Assigned(Dosimeter) then
  begin
    ChangeDosNameInMeasForm.measID:=Dosimeter.MeasurementID;
    ChangeDosNameInMeasForm.EditEnterNewDosNumber.Text:=IntToStr(Dosimeter.ID);
    if Dosimeter.Postfix = '-' then
      ChangeDosNameInMeasForm.EditEnterNewPostfix.Text:=''
    else
      ChangeDosNameInMeasForm.EditEnterNewPostfix.Text:=Dosimeter.Postfix;

    ChangeDosNameInMeasForm.oldDosNumber:=ChangeDosNameInMeasForm.EditEnterNewDosNumber.Text+ChangeDosNameInMeasForm.EditEnterNewPostfix.Text;

    ChangeDosNameInMeasForm.Show;
  end;
end;

procedure TMainForm.ShowStopMeasureW;
begin
//  if Dosimeter <> nil then
//  begin
//    if Dosimeter.MeasurementID>0 then
//    begin
      UpdateFinishMeasureW;
      if FinishMeasureW.BtnCancel.Visible then FinishMeasureW.BtnCancel.Visible:=false;
      FinishMeasureW.ShowModal;
//    end;
//  end;
end;

procedure TMainForm.UpdateAllGridPages;
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      UpdateGridMeasFilter(FilterMeasDosNumber);
      CheckDBGridRowCount(DBGridEhOnlyMeas);
      DBGridEhOnlyMeas.SelectedRows.CurrentRowSelected:=true;

      GetMeasData;

      ResizeMeasPanelLeft(DBGridEhOnlyMeas,MemTableEhMeasList);
    end;
    cPageDosIndex:
    begin
      UpdateDataDosFilter(FilterDosDosNumber);
      CheckDBGridRowCount(DBGridEhDos);
      DBGridEhDos.SelectedRows.CurrentRowSelected:=true;

      GetDosData;

      PageControlDosParamChange(Self);

      ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
    end;
    cPageProcessIndex:
    begin
      UpdateGridProcessFilter(FilterProcessDosNumber);
      CheckDBGridRowCount(DBGridEhProcess);
      DBGridEhProcess.SelectedRows.CurrentRowSelected:=true;

      GetMeasData;

      ResizeMeasPanelLeft(DBGridEhProcess,MemTableEhProcessList);
    end;
    cPageCalibrationIndex:
    begin
      UpdateGridCalibrationFilter(FilterCalibrDosNumber);
      CheckDBGridRowCount(DBGridEhCalcKDos);
      DBGridEhCalcKDos.SelectedRows.CurrentRowSelected:=true;

      GetMeasData;

      ResizeMeasPanelLeft(DBGridEhCalcKDos,MemTableEhCalcKDos);
    end;
    cPageSettingsIndex:
    begin
      RefreshPermit_Page;
      PanelPermitLeftResize(Self);
      PageControlSettings.ActivePage:=TabSheetDeviceControl;
    end;
  end;

  DefaultChartSize;
end;

procedure TMainForm.UpdateGridPageSoft;
begin
  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      JvDateTimePickerMeas.Date:=Date;

      //**DBGridEhOnlyMeas.SelectedRows.CurrentRowSelected:=true;

      DBGridEhOnlyMeas.SelectedRows.Clear;
      if Assigned(Dosimeter) then
        DBGridEhOnlyMeas.DataSource.DataSet.Locate(cFullDosID,Dosimeter.FullNumber,[]);
      DBGridEhOnlyMeas.SelectedRows.CurrentRowSelected:=true;

      GetMeasData;
      CheckDBGridRowCount(DBGridEhOnlyMeas);
      PageControlMeasDosPar.ActivePage:=PGMeasPage_TSMainPar;
      ResizeMeasPanelLeft(DBGridEhOnlyMeas,MemTableEhMeasList);
      RestoreGridParametersMeas;
    end;
    cPageDosIndex:
    begin
      LoadFilters;
      UpdateBtnFilters;
      PageControlDosParam.ActivePageIndex:=cPageDosMainParams;
      CheckDBGridRowCount(DBGridEhDos);

      DBGridEhDos.SelectedRows.Clear;
      if Assigned(Dosimeter) then
        DBGridEhDos.DataSource.DataSet.Locate(cFullDosID,Dosimeter.FullNumber,[]);
      DBGridEhDos.SelectedRows.CurrentRowSelected:=true;

      //**DBGridEhDos.SelectedRows.CurrentRowSelected:=true;
      GetDosData;
      PageControlDosParamChange(Self);
      ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
      RestoreGridParametersDos;
    end;
    cPageProcessIndex:
    begin
      DBGridEhProcess.SelectedRows.Clear;
      if Assigned(Dosimeter) then
        DBGridEhProcess.DataSource.DataSet.Locate(cFullDosID,Dosimeter.FullNumber,[]);
      DBGridEhProcess.SelectedRows.CurrentRowSelected:=true;

      GetMeasData;
      CheckDBGridRowCount(DBGridEhProcess);
      LoadFilters;
      UpdateBtnFilters;

      PageControlProcessDosPar.ActivePage:=PGProcessPage_TSMainPar;
      ResizeMeasPanelLeft(DBGridEhProcess,MemTableEhProcessList);
      RestoreGridParametersProcess;
    end;
    cPageCalibrationIndex:
    begin
      GetMeasData;
      CheckDBGridRowCount(DBGridEhCalcKDos);

      ResizeMeasPanelLeft(DBGridEhCalcKDos,MemTableEhCalcKDos);
      RestoreGridParametersCalibr;

      SetLblCaptionUnicode(LblDotK1_Calibr,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK2_Calibr,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK3_Calibr,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK4_Calibr,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotK5_Calibr,Format('%s',[cuUnicodeSymbol_Dot]));
      SetLblCaptionUnicode(LblDotKgn_Calibr,Format('%s',[cuUnicodeSymbol_Dot]));

      DateTimePickerCalibr.Date:=Date;

      StartCalibration;
    end;
    cPageSettingsIndex:
    begin
      RefreshPermit_Page;
      PanelPermitLeftResize(Self);
      PageControlSettings.ActivePage:=TabSheetDeviceControl;
      PageControlSettingsChange(Self);
    end;
  end;

  DefaultChartSize;
end;

procedure TMainForm.UpdateGridPageStart;
begin
  Splash.ProgressBar.Minimum:=0;
  Splash.ProgressBar.Maximum:=4;
  Splash.ProgressBar.Position:=0;
  Splash.Show(false);
  Splash.SetCaption(rsLoadingFilters);

  LoadFiltersAll;
  ReadFilterIniAll;
  CheckFiltersAll;

  Splash.ProgressBar.Position:=Splash.ProgressBar.Position+1;

// загрузка страницы дозиметров
  Splash.SetCaption(rsLoadingPageDosimeters);
  UpdateDataDosFilter(FilterDosDosNumber);
  CheckDBGridRowCount(DBGridEhDos);
  GetDosData;
  PageControlDosParamChange(Self);
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
  Splash.ProgressBar.Position:=Splash.ProgressBar.Position+1;
// загрузкастраницы калибровки
  Splash.SetCaption(rsLoadingPageMeasuring);
  UpdateGridCalibrationFilter(FilterCalibrDosNumber);
  CheckDBGridRowCount(DBGridEhCalcKDos);
  DBGridEhCalcKDos.SelectedRows.CurrentRowSelected:=true;
//  GetMeasData;
  ResizeMeasPanelLeft(DBGridEhCalcKDos,MemTableEhCalcKDos);
  Splash.ProgressBar.Position:=Splash.ProgressBar.Position+1;
  Splash.Close;
// загрузка страницы обработки
  Splash.SetCaption(rsLoadingPageEdit);
  UpdateGridProcessFilter(FilterProcessDosNumber);
  CheckDBGridRowCount(DBGridEhProcess);
  ResizeMeasPanelLeft(DBGridEhProcess,MemTableEhProcessList);
  Splash.ProgressBar.Position:=Splash.ProgressBar.Position+1;
// загрузка страницы измерений
  Splash.SetCaption(rsLoadingPageMeasuring);
  JvDateTimePickerMeas.Date:=Date;
  UpdateGridMeasFilter(FilterMeasDosNumber);
  CheckDBGridRowCount(DBGridEhOnlyMeas);
  DBGridEhOnlyMeas.SelectedRows.CurrentRowSelected:=true;
  GetMeasData;
  ResizeMeasPanelLeft(DBGridEhOnlyMeas,MemTableEhMeasList);
  Splash.ProgressBar.Position:=Splash.ProgressBar.Position+1;

  DefaultChartSize;
end;

procedure TMainForm.UpdateGridMeasAndProcessPages;
begin
  UpdateGridMeasFilter(FilterMeasDosNumber);
  UpdateGridProcessFilter(FilterProcessDosNumber);
  DataSourceProcessList.DataSet.First;

  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      CheckDBGridRowCount(DBGridEhOnlyMeas);
      RestoreGridParametersMeas;
    end;
    cPageProcessIndex:
    begin
      CheckDBGridRowCount(DBGridEhProcess);
      RestoreGridParametersProcess;
    end;
  end;

  GetMeasData;
  ResizeMeasPanelLeft(DBGridEhOnlyMeas,MemTableEhMeasList);
  ResizeMeasPanelLeft(DBGridEhProcess,MemTableEhProcessList);
  DefaultChartSize;
end;

procedure TMainForm.UpdateGridMeasPage;
begin
  UpdateGridMeasFilter(FilterMeasDosNumber);
  CheckDBGridRowCount(DBGridEhOnlyMeas);
  ResizeMeasPanelLeft(DBGridEhOnlyMeas,MemTableEhMeasList);
  RestoreGridParametersMeas;
end;

procedure TMainForm.UpdateGridProcessPage;
begin
  UpdateGridProcessFilter(FilterProcessDosNumber);
  CheckDBGridRowCount(DBGridEhProcess);
  DataSourceProcessList.DataSet.First;
  ResizeMeasPanelLeft(DBGridEhProcess,MemTableEhProcessList);
  RestoreGridParametersProcess;
end;

procedure TMainForm.UpdateGridCalibrPage;
begin
  UpdateGridCalibrationFilter(FilterCalibrDosNumber);
  CheckDBGridRowCount(DBGridEhCalcKDos);
  DBGridEhCalcKDos.DataSource.DataSet.First;
  ResizeMeasPanelLeft(DBGridEhCalcKDos,MemTableEhCalcKDos);
end;

procedure TMainForm.UpdateGridDosPage;
begin
  UpdateDataDosFilter(FilterDosDosNumber);
  CheckDBGridRowCount(DBGridEhDos);
  DBGridEhDos.SelectedRows.CurrentRowSelected:=true;
  GetDosData;
  PageControlDosParamChange(Self);
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.SpeedBtnMeasZoomHorMinusD1Click(Sender: TObject);
begin
  DChartZoomHorMinus(TLDChartMeasDataD1);
end;

procedure TMainForm.SpeedBtnMeasZoomHorMinusD2Click(Sender: TObject);
begin
  DChartZoomHorMinus(TLDChartMeasDataD2);
end;

procedure TMainForm.SpeedBtnMeasZoomHorMinusD3Click(Sender: TObject);
begin
  DChartZoomHorMinus(TLDChartMeasDataD3);
end;

procedure TMainForm.SpeedBtnMeasZoomHorMinusD4Click(Sender: TObject);
begin
  DChartZoomHorMinus(TLDChartMeasDataD4);
end;

procedure TMainForm.SpeedBtnMeasZoomHorPlusD1Click(Sender: TObject);
begin
  DChartZoomHorPlus(TLDChartMeasDataD1);
end;

procedure TMainForm.SpeedBtnMeasZoomHorPlusD2Click(Sender: TObject);
begin
  DChartZoomHorPlus(TLDChartMeasDataD2);
end;

procedure TMainForm.SpeedBtnMeasZoomHorPlusD3Click(Sender: TObject);
begin
  DChartZoomHorPlus(TLDChartMeasDataD3);
end;

procedure TMainForm.SpeedBtnMeasZoomHorPlusD4Click(Sender: TObject);
begin
  DChartZoomHorPlus(TLDChartMeasDataD4);
end;

procedure TMainForm.SpeedBtnProcessOpenFilterClick(Sender: TObject);
begin
  if PanelProcessLeftFilter.Height > 1 then
  begin
    FOpenFilterProcessPanel:=false;
    TimerOpenFilter.Enabled:=true;
    SpeedBtnProcessOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Down.bmp');
    SaveFilterBoolIni(cFilterProcessEnable,false);
  end
  else
  begin
    FOpenFilterProcessPanel:=true;
    TimerOpenFilter.Enabled:=true;
    SpeedBtnProcessOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Up.bmp');
    SaveFilterBoolIni(cFilterProcessEnable,true);
  end;
end;

procedure TMainForm.SpeedBtnProcessSaveIDKClick(Sender: TObject);
begin
  UpdateDosimeterIDKParam(EditProcessDataDosFio,EditProcessDataDosPersNumber,EditProcessDataDosOrg,EditProcessDataDosDep);
  PageControlProcessDosParChange(Self);
end;

procedure TMainForm.SpeedBtnProcessSaveParamClick(Sender: TObject);
begin
  UpdateMeasComment(EditProcessDataComment,EditProcessDataComment.Text);
  PageControlProcessDosParChange(Self);
end;

procedure TMainForm.SpeedBtnProcessUserWarningClick(Sender: TObject);
begin
  UserWarningComment:=false;
  SetUserWarning(SpeedBtnProcessUserWarning.Down);
end;

procedure TMainForm.SpeedBtnPartInfClick(Sender: TObject);
begin
  DosimeterPartForm.DosPartName:=EditDosPart.Text;
  DosimeterPartForm.Show;
end;

procedure TMainForm.SpeedBtnProcessDataWarningD1Click(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos1-1]) then
  begin
    Dosimeter.DetectorsCnt:=cDetPos1-1;
    CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[cDetPos1-1]));
    CalcForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnProcessDataWarningD2Click(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos2-1]) then
  begin
    Dosimeter.DetectorsCnt:=cDetPos2-1;
    CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[cDetPos2-1]));
    CalcForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnProcessDataWarningD3Click(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos3-1]) then
  begin
    Dosimeter.DetectorsCnt:=cDetPos3-1;
    CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[cDetPos3-1]));
    CalcForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnProcessDataWarningD4Click(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos4-1]) then
  begin
    Dosimeter.DetectorsCnt:=cDetPos4-1;
    CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[cDetPos4-1]));
    CalcForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnProcessDet1InfClick(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos1-1]) then
  begin
    DetectorConstructorForm.DetTypeName:=TDetector(Dosimeter.DetectorsList[cDetPos1-1]).DetType;
    DetectorConstructorForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnProcessDet2InfClick(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos2-1]) then
  begin
    DetectorConstructorForm.DetTypeName:=TDetector(Dosimeter.DetectorsList[cDetPos2-1]).DetType;
    DetectorConstructorForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnProcessDet3InfClick(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos3-1]) then
  begin
    DetectorConstructorForm.DetTypeName:=TDetector(Dosimeter.DetectorsList[cDetPos3-1]).DetType;
    DetectorConstructorForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnProcessDet4InfClick(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos4-1]) then
  begin
    DetectorConstructorForm.DetTypeName:=TDetector(Dosimeter.DetectorsList[cDetPos4-1]).DetType;
    DetectorConstructorForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnProcessDropAllFilterClick(Sender: TObject);
begin
  if IsUseFilterCB(CBoxProcessOrgName) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessOrganization,'');
    CheckComboBox(CBoxProcessOrgName,SpBtnProcessDropOrgName,false);
  end;
  if IsUseFilterCB(CBoxProcessDep) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessDepartment,'');
    CheckComboBox(CBoxProcessDep,SpBtnProcessDropDep,false);
  end;
  if IsUseFilterCB(CBoxProcessDosPart) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessDosPath,'');
    CheckComboBox(CBoxProcessDosPart,SpBtnProcessDropDosPart,false);
  end;
  if IsUseFilterCB(CBoxProcessDosType) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessDosType,'');
    CheckComboBox(CBoxProcessDosType,SpBtnProcessDropDosType,false);
  end;
  if IsUseFilterEdit(EditProcessDosNumber) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessNumber,'');
    CheckEdit(EditProcessDosNumber,SpBtnProcessDropDosNumber,false);
  end;
  if IsUseFilterCB(CBoxProcessStatus) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessDosStatus,'');
    CheckComboBox(CBoxProcessStatus,SpBtnProcessDropStatus,false);
  end;
  if IsUseFilterCB(CBoxProcessPersNumber) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessPersNumber,'');
    CheckComboBox(CBoxProcessPersNumber,SpBtnProcessDropPersNumber,false);
  end;
  if IsUseFilterCB(CBoxProcessIDK) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessIDK,'');
    CheckComboBox(CBoxProcessIDK,SpBtnProcessDropIDK,false);
  end;
  if IsUseFilterCB(CBoxProcessResult) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessResult,'');
    CheckComboBox(CBoxProcessResult,SpBtnProcessDropResult,false);
  end;
  if IsUseFilterCB(CBoxProcessDeviceID) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessDeviceID,'');
    CheckComboBox(CBoxProcessDeviceID,SpBtnProcessDropDevID,false);
  end;
  if IsUseFilterCB(CBoxProcessComment) then
  begin
    SaveFilterTextIni(cSectionFilter,cFilterProcessComment,'');
    CheckComboBox(CBoxProcessComment,SpBtnProcessDropComment,false);
  end;
  if IsUseFilterDatePicker(DateTimePickerProcessFrom) then
  begin
    SaveFilterDateIni(cFilterProcessTimeFrom,'');
    CheckDatePicker(DateTimePickerProcessFrom,SpBtnProcessDropDateFrom,false);
  end;
  if IsUseFilterDatePicker(DateTimePickerProcessTo) then
  begin
    SaveFilterDateIni(cFilterProcessTimeTo,'');
    CheckDatePicker(DateTimePickerProcessTo,SpBtnProcessDropDateTo,false);
  end;
  if IsUseSQLScript then SQLScriptChange(false);

//  SpeedBtnProcessDropAllFilter.Visible:=False;
  TSpeedButton(Sender).Visible:=False;
  LoadFilters;
  UpdateAllGridPages;
end;

procedure TMainForm.SpBtnDosDropDepClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDepartment,'');
  ChangeComboBox(CBoxDosDep,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnDosDropDevIDClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDeviceID,'');
  ChangeComboBox(CBoxDosDeviceID,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnDosDropDosNumberClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDosNumber,'');
  ChangeEdit(EditDosDosNumber,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnDosDropDosPartClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDosPath,'');
  ChangeComboBox(CBoxDosDosPart,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnDosDropDosTypeClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDosType,'');
  ChangeComboBox(CBoxDosDosType,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnDosDropIDKClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterdosIDK,'');
  ChangeComboBox(CBoxdosIDK,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnDosDropOrgNameClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosOrganization,'');
  ChangeComboBox(CBoxDosOrgName,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnDosDropPersNumberClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosPersNumber,'');
  ChangeComboBox(CBoxDosPersNumber,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnDosDropStatusClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterDosDosStatus,'');
  ChangeComboBox(CBoxDosStatus,TSpeedButton(Sender),False);
end;

////PROCESS

procedure TMainForm.SpBtnProcessDropOrgNameClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessOrganization,'');
  ChangeComboBox(CBoxProcessOrgName,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropDepClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessDepartment,'');
  ChangeComboBox(CBoxProcessDep,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropDevIDClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessDeviceID,'');
  ChangeComboBox(CBoxProcessDeviceID,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropDosPartClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessDosPath,'');
  ChangeComboBox(CBoxProcessDosPart,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropDosTypeClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessDosType,'');
  ChangeComboBox(CBoxProcessDosType,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropDosNumberClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessNumber,'');
  ChangeEdit(EditProcessDosNumber,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropStatusClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessDosStatus,'');
  ChangeComboBox(CBoxProcessStatus,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessSQLFilterClick(Sender: TObject);
begin
  SQLFilterForm.Show;
end;

procedure TMainForm.SpBtnProcessDropPersNumberClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessPersNumber,'');
  ChangeComboBox(CBoxProcessPersNumber,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropIDKClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessIDK,'');
  ChangeComboBox(CBoxProcessIDK,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnPrevClick(Sender: TObject);
begin
  PanelMeasLeftFilter.SetFocus;
  JvDateTimePickerMeas.Date:=StrToDateRegion(SpBtnPrev.Caption);
  JvDateTimePickerMeas.OnChange(Self);
end;

procedure TMainForm.SpBtnProcessDropCommentClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessComment,'');
  ChangeComboBox(CBoxProcessComment,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropDateFromClick(Sender: TObject);
begin
  SaveFilterDateIni(cFilterProcessTimeFrom,'');
  ChangeDatePicker(DateTimePickerProcessFrom,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropDateToClick(Sender: TObject);
begin
  SaveFilterDateIni(cFilterProcessTimeTo,'');
  ChangeDatePicker(DateTimePickerProcessTo,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropResultClick(Sender: TObject);
begin
  SaveFilterTextIni(cSectionFilter,cFilterProcessResult,'');
  ChangeComboBox(CBoxProcessResult,TSpeedButton(Sender),False);
end;

procedure TMainForm.SpBtnProcessDropSQLScriptClick(Sender: TObject);
begin
  SQLScriptChange(False)
end;

procedure TMainForm.SpeedBtnMeasSettingsD1Click(Sender: TObject);
begin
  MaximaizeD1Chart:=not FMaximazeD1Chart;
end;

procedure TMainForm.SpeedBtnMeasSettingsD2Click(Sender: TObject);
begin
  MaximaizeD2Chart:=not FMaximazeD2Chart;
end;

procedure TMainForm.SpeedBtnMeasSettingsD3Click(Sender: TObject);
begin
  MaximaizeD3Chart:=not FMaximazeD3Chart;
end;

procedure TMainForm.SpeedBtnMeasSettingsD4Click(Sender: TObject);
begin
  MaximaizeD4Chart:=not FMaximazeD4Chart;
end;

procedure TMainForm.SpeedBtnProcessEditMeasClick(Sender: TObject);
begin
  ShowFinishMeasureW(False);
end;

procedure TMainForm.SpeedBtnProcessExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.SpeedBtnImportDosClick(Sender: TObject);
begin
//  ImportDosimetersW.ShowModal;
end;

procedure TMainForm.SpeedBtnMeasAutoSizeD1Click(Sender: TObject);
begin
//  DChartAutoSize(TLDChartMeasDataD1);
  DSeriaAutoSize(TLDChartMeasDataD1,SeriesMeasD1KTV);
end;

procedure TMainForm.SpeedBtnMeasAutoSizeD2Click(Sender: TObject);
begin
//  DChartAutoSize(TLDChartMeasDataD2);
  DSeriaAutoSize(TLDChartMeasDataD2,SeriesMeasD2KTV);
end;

procedure TMainForm.SpeedBtnMeasAutoSizeD3Click(Sender: TObject);
begin
//  DChartAutoSize(TLDChartMeasDataD3);
  DSeriaAutoSize(TLDChartMeasDataD3,SeriesMeasD3KTV);
end;

procedure TMainForm.SpeedBtnMeasAutoSizeD4Click(Sender: TObject);
begin
//  DChartAutoSize(TLDChartMeasDataD4);
  DSeriaAutoSize(TLDChartMeasDataD4,SeriesMeasD4KTV);
end;

procedure TMainForm.SpeedBtnMeasCalcD1Click(Sender: TObject);
begin
  Dosimeter.DetectorsCnt := 0;
  CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[0]));
  CalcForm.ShowModal;
end;

procedure TMainForm.SpeedBtnMeasCalcD2Click(Sender: TObject);
begin
  Dosimeter.DetectorsCnt := 1;
  CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[1]));
  CalcForm.ShowModal;
end;

procedure TMainForm.SpeedBtnMeasCalcD3Click(Sender: TObject);
begin
  Dosimeter.DetectorsCnt := 2;
  CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[2]));
  CalcForm.ShowModal;
end;

procedure TMainForm.SpeedBtnMeasCalcD4Click(Sender: TObject);
begin
  Dosimeter.DetectorsCnt := 3;
  CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[3]));
  CalcForm.ShowModal;
end;

procedure TMainForm.SpeedBtnMeasDataWarningD1Click(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos1-1]) then
  begin
    Dosimeter.DetectorsCnt:=cDetPos1-1;
    CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[cDetPos1-1]));
    CalcForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnMeasDataWarningD2Click(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos2-1]) then
  begin
    Dosimeter.DetectorsCnt:=cDetPos2-1;
    CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[cDetPos2-1]));
    CalcForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnMeasDataWarningD3Click(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos3-1]) then
  begin
    Dosimeter.DetectorsCnt:=cDetPos3-1;
    CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[cDetPos3-1]));
    CalcForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnMeasDataWarningD4Click(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos4-1]) then
  begin
    Dosimeter.DetectorsCnt:=cDetPos4-1;
    CalcForm.LoadData(TDetector(Dosimeter.DetectorsList[cDetPos4-1]));
    CalcForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnMeasEditMeasClick(Sender: TObject);
begin
  ShowFinishMeasureW(False);
end;

procedure TMainForm.SpeedBtnMeasZoomVertPlusD1Click(Sender: TObject);
begin
  DChartZoomVertPlus(TLDChartMeasDataD1);
end;

procedure TMainForm.SpeedBtnMeasZoomVertPlusD2Click(Sender: TObject);
begin
  DChartZoomVertPlus(TLDChartMeasDataD2);
end;

procedure TMainForm.SpeedBtnMeasZoomVertPlusD3Click(Sender: TObject);
begin
  DChartZoomVertPlus(TLDChartMeasDataD3);
end;

procedure TMainForm.SpeedBtnMeasZoomVertPlusD4Click(Sender: TObject);
begin
  DChartZoomVertPlus(TLDChartMeasDataD4);
end;

procedure TMainForm.SpeedBtnMeasZoomVertMinusD1Click(Sender: TObject);
begin
  DChartZoomVertMinus(TLDChartMeasDataD1);
end;

procedure TMainForm.SpeedBtnMeasZoomVertMinusD2Click(Sender: TObject);
begin
  DChartZoomVertMinus(TLDChartMeasDataD2);
end;

procedure TMainForm.SpeedBtnMeasZoomVertMinusD3Click(Sender: TObject);
begin
  DChartZoomVertMinus(TLDChartMeasDataD3);
end;

procedure TMainForm.SpeedBtnMeasZoomVertMinusD4Click(Sender: TObject);
begin
  DChartZoomVertMinus(TLDChartMeasDataD4);
end;

procedure TMainForm.SpeedBtnMeasStepUpD1Click(Sender: TObject);
begin
  DChartOffsetVertUp(TLDChartMeasDataD1);
end;

procedure TMainForm.SpeedBtnMeasStepUpD2Click(Sender: TObject);
begin
  DChartOffsetVertUp(TLDChartMeasDataD2);
end;

procedure TMainForm.SpeedBtnMeasStepUpD3Click(Sender: TObject);
begin
  DChartOffsetVertUp(TLDChartMeasDataD3);
end;

procedure TMainForm.SpeedBtnMeasStepUpD4Click(Sender: TObject);
begin
  DChartOffsetVertUp(TLDChartMeasDataD4);
end;

procedure TMainForm.SpeedBtnMeasUserWarningClick(Sender: TObject);
begin
  UserWarningComment:=false;
  SetUserWarning(SpeedBtnMeasUserWarning.Down);
end;

procedure TMainForm.SpBtnMeasSQLFilterClick(Sender: TObject);
begin
  SQLFilterForm.Show;
end;

procedure TMainForm.SpBtnNextClick(Sender: TObject);
begin
  PanelMeasLeftFilter.SetFocus;
  if (SpBtnNext.Caption<>cEmptyData) then JvDateTimePickerMeas.Date:=StrToDate(SpBtnNext.Caption);
  JvDateTimePickerMeas.OnChange(Self);
end;

procedure TMainForm.SpeedBtnCalibrationClick(Sender: TObject);
begin
  StartMeas(cStartCalibration);
end;

procedure TMainForm.SpeedBtnCalibrationExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.SpeedBtnCalibrOpenFilterClick(Sender: TObject);
begin
  if PanelCalibrLeftFilter.Height > 1 then
  begin
    FOpenFilterCalibrPanel:=false;
    TimerOpenFilter.Enabled:=true;
    SpeedBtnCalibrOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Down.bmp');
    SaveFilterBoolIni(cFilterCalibrEnable,false);
  end
  else
  begin
    FOpenFilterCalibrPanel:=true;
    TimerOpenFilter.Enabled:=true;
    SpeedBtnCalibrOpenFilter.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+'Up.bmp');
    SaveFilterBoolIni(cFilterCalibrEnable,true);
  end;
end;

procedure TMainForm.SpeedBtnMeasExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.SpeedBtnMeasDet1InfClick(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos1-1]) then
  begin
    DetectorConstructorForm.DetTypeName:=TDetector(Dosimeter.DetectorsList[cDetPos1-1]).DetType;
    DetectorConstructorForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnMeasDet2InfClick(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos2-1]) then
  begin
    DetectorConstructorForm.DetTypeName:=TDetector(Dosimeter.DetectorsList[cDetPos2-1]).DetType;
    DetectorConstructorForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnMeasDet3InfClick(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos3-1]) then
  begin
    DetectorConstructorForm.DetTypeName:=TDetector(Dosimeter.DetectorsList[cDetPos3-1]).DetType;
    DetectorConstructorForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnMeasDet4InfClick(Sender: TObject);
begin
  if Assigned(Dosimeter.DetectorsList[cDetPos4-1]) then
  begin
    DetectorConstructorForm.DetTypeName:=TDetector(Dosimeter.DetectorsList[cDetPos4-1]).DetType;
    DetectorConstructorForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnMeasDosTypeInfClick(Sender: TObject);
begin
  if Assigned(Dosimeter) then
  begin
    DosimeterTypeConstructorForm.DosTypeName:=Dosimeter.DosType;
    DosimeterTypeConstructorForm.ShowModal;
  end;
end;

procedure TMainForm.SpeedBtnDosConstructorClick(Sender: TObject);
begin
  DosimeterTypeConstructorForm.DosTypeName:=EditDosDataDosTypeVal.Text;
  DosimeterTypeConstructorForm.ShowModal;
end;

procedure TMainForm.SpeedExportDosimetersClick(Sender: TObject);
begin
  ExportDosAndSettingsForm.Show;
end;

procedure TMainForm.SpeedBtnDetConstructorClick(Sender: TObject);
begin
  DetectorConstructorForm.DetTypeName:=cDetMat_LiF_Mg_Ti;
  DetectorConstructorForm.ShowModal;
end;

procedure TMainForm.SpeedBtnShowDosRptClick(Sender: TObject);
begin
  OpenDozaReportBuilder(cReport_tld_dosimeter_coef_pdf,DBGridEhDos,orptSaveAndShow,orpsDosList);
end;

procedure TMainForm.SpeedBtnShowMeasRptClick(Sender: TObject);
begin
  OpenDozaReportBuilder(cReport_tld_dosimeter_res_pdf,DBGridEhProcess,orptSaveAndShow,orpsMeasList);
end;

procedure TMainForm.SpeedButtonChangeUserClick(Sender: TObject);
begin
  AW.ShowModal;  // смена пользователя
end;

procedure TMainForm.SplitterVBottomMoved(Sender: TObject);
begin
  PanelMeasDataD1.Width:=PanelMeasDataD3.Width;
end;

procedure TMainForm.SplitterVTopMoved(Sender: TObject);
begin
  PanelMeasDataD3.Width:=PanelMeasDataD1.Width;
end;

procedure TMainForm.sppDosColLastMeasCommentClick(Sender: TObject);
begin
  DosColumnLastMeasComment:=sppDosColLastMeasComment.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldLastMeasComment).Index].Visible:=DosColumnLastMeasComment;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosColLastMeasResultClick(Sender: TObject);
begin
  DosColumnLastMeasResult:=sppDosColLastMeasResult.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldLastMeasResult).Index].Visible:=DosColumnLastMeasResult;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosColLastMeasTimeClick(Sender: TObject);
begin
  DosColumnLastMeasTime:=sppDosColLastMeasTime.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldLastMeasTime).Index].Visible:=DosColumnLastMeasTime;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppCalibrColDClick(Sender: TObject);
begin
  CalibrColumnD:=sppCalibrColD.Checked;
  ShowMeasGridColumns(cFieldD,CalibrColumnD);
end;

procedure TMainForm.sppCalibrColDeviceIDClick(Sender: TObject);
begin
  CalibrColumnTldID:=sppCalibrColDeviceID.Checked;
  ShowMeasGridColumns(cFieldTldID,CalibrColumnTldID);
end;

procedure TMainForm.sppCalibrColDoseClick(Sender: TObject);
begin
  CalibrColumnDose:=sppCalibrColDose.Checked;
  ShowMeasGridColumns(cFieldDose,CalibrColumnDose);
end;

procedure TMainForm.sppCalibrColDosTypeClick(Sender: TObject);
begin
  CalibrColumnDosType:=sppCalibrColDosType.Checked;
  ShowMeasGridColumns(cFieldDosType,CalibrColumnDosType);
end;

procedure TMainForm.sppCalibrColH007Click(Sender: TObject);
begin
  CalibrColumnH007:=sppCalibrColH007.Checked;
  ShowMeasGridColumns(cFieldH007,CalibrColumnH007);
end;

procedure TMainForm.sppCalibrColHp007Click(Sender: TObject);
begin
  CalibrColumnHp007:=sppCalibrColHp007.Checked;
  ShowMeasGridColumns(cFieldHp007,CalibrColumnHp007);
end;

procedure TMainForm.sppCalibrColHp10gClick(Sender: TObject);
begin
  CalibrColumnHp10g:=sppCalibrColHp10g.Checked;
  ShowMeasGridColumns(cFieldHp10g,CalibrColumnHp10g);
end;

procedure TMainForm.sppCalibrColHp10nClick(Sender: TObject);
begin
  CalibrColumnHp10n:=sppCalibrColHp10n.Checked;
  ShowMeasGridColumns(cFieldHp10n,CalibrColumnHp10n);
end;

procedure TMainForm.sppCalibrColHp3Click(Sender: TObject);
begin
  CalibrColumnHp3:=sppCalibrColHp3.Checked;
  ShowMeasGridColumns(cFieldHp3,CalibrColumnHp3);
end;

procedure TMainForm.sppCalibrColHstarClick(Sender: TObject);
begin
  CalibrColumnHstar:=sppCalibrColHstar.Checked;
  ShowMeasGridColumns(cFieldHstar,CalibrColumnHstar);
end;

procedure TMainForm.sppCalibrColK1Click(Sender: TObject);
begin
  CalibrColumnK1:=sppCalibrColK1.Checked;
  ShowMeasGridColumns(cField_k1,CalibrColumnK1);
end;

procedure TMainForm.sppCalibrColK2Click(Sender: TObject);
begin
  CalibrColumnK2:=sppCalibrColK2.Checked;
  ShowMeasGridColumns(cField_k2,CalibrColumnK2);
end;

procedure TMainForm.sppCalibrColK3Click(Sender: TObject);
begin
  CalibrColumnK3:=sppCalibrColK3.Checked;
  ShowMeasGridColumns(cField_k3,CalibrColumnK3);
end;

procedure TMainForm.sppCalibrColK4Click(Sender: TObject);
begin
  CalibrColumnK4:=sppCalibrColK4.Checked;
  ShowMeasGridColumns(cField_k4,CalibrColumnK4);
end;

procedure TMainForm.sppCalibrColK5Click(Sender: TObject);
begin
  CalibrColumnK5:=sppCalibrColK5.Checked;
  ShowMeasGridColumns(cField_k5,CalibrColumnK5);
end;

procedure TMainForm.sppCalibrColKgnClick(Sender: TObject);
begin
  CalibrColumnKgn:=sppCalibrColKgn.Checked;
  ShowMeasGridColumns(cField_kgn,CalibrColumnKgn);
end;

procedure TMainForm.sppCalibrColKSIClick(Sender: TObject);
begin
  CalibrColumnKSI:=sppCalibrColKSI.Checked;
  ShowMeasGridColumns(cFieldKSI,CalibrColumnKSI);
end;

procedure TMainForm.sppCalibrColMeasIDClick(Sender: TObject);
begin
  CalibrColumnMeasID:=sppCalibrColMeasID.Checked;
  ShowMeasGridColumns(cFieldDosMeasID,CalibrColumnMeasID);
end;

procedure TMainForm.sppCalibrColMeasTimeClick(Sender: TObject);
begin
  CalibrColumnMeasDateTime:=sppCalibrColMeasTime.Checked;
  ShowMeasGridColumns(cFieldMeasureTime,CalibrColumnMeasDateTime);
end;

procedure TMainForm.sppCalibrPartNameClick(Sender: TObject);
begin
  CalibrColumnPartID:=sppCalibrPartName.Checked;
  ShowMeasGridColumns(cFieldDosPartName,CalibrColumnPartID);
end;

procedure TMainForm.sppDosColDateRegisterClick(Sender: TObject);
begin
  DosColumnRegTime:=sppDosColDateRegister.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldRegTime).Index].Visible:=DosColumnRegTime;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosColDateVerificationClick(Sender: TObject);
begin
  DosColumnVerTime:=sppDosColDateVerification.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldVerTime).Index].Visible:=DosColumnVerTime;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosColDepClick(Sender: TObject);
begin
  DosColumnDep:=sppDosColDep.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDepartment).Index].Visible:=DosColumnDep;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosColDeviceIDClick(Sender: TObject);
begin
  DosColumnTldID:=sppDosColDeviceID.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible:=DosColumnTldID;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosColDosTypeClick(Sender: TObject);
begin
  DosColumnDosType:=sppDosColDosType.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible:=DosColumnDosType;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosColOrgClick(Sender: TObject);
begin
  DosColumnOrg:=sppDosColOrg.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldOrg).Index].Visible:=DosColumnOrg;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosColPartClick(Sender: TObject);
begin
  DosColumnPartID:=sppDosColPart.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldPartID).Index].Visible:=DosColumnPartID;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosColStatusDosClick(Sender: TObject);
begin
  DosColumnDosState:=sppDosColStatusDos.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cFieldStringState).Index].Visible:=DosColumnDosState;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosCol_k1Click(Sender: TObject);
begin
  DosColumnk1:=sppDosCol_k1.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_k1).Index].Visible:=DosColumnk1;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosCol_k2Click(Sender: TObject);
begin
  DosColumnk2:=sppDosCol_k2.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_k2).Index].Visible:=DosColumnk2;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosCol_k3Click(Sender: TObject);
begin
  DosColumnk3:=sppDosCol_k3.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_k3).Index].Visible:=DosColumnk3;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosCol_k4Click(Sender: TObject);
begin
  DosColumnk4:=sppDosCol_k4.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_k4).Index].Visible:=DosColumnk4;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosCol_k5Click(Sender: TObject);
begin
  DosColumnk5:=sppDosCol_k5.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_k5).Index].Visible:=DosColumnk5;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppDosCol_kgnClick(Sender: TObject);
begin
  DosColumnkgn:=sppDosCol_kgn.Checked;
  DBGridEhDos.Columns[DBGridEhDos.DataSource.DataSet.FieldByName(cField_kgn).Index].Visible:=DosColumnkgn;
  ResizeDosPanelLeft(DBGridEhDos,MemTableEhDosList);
end;

procedure TMainForm.sppMeasColCommentDosClick(Sender: TObject);
begin
  MeasColumnLastMeasComment:=sppMeasColCommentDos.Checked;
  ShowMeasGridColumns(cFieldLastMeasComment,MeasColumnLastMeasComment);
end;

procedure TMainForm.sppMeasColCommentMeasClick(Sender: TObject);
begin
  MeasColumnMeasComment:=sppMeasColCommentMeas.Checked;
  ShowMeasGridColumns(cFieldMeasComment,MeasColumnMeasComment);
end;

procedure TMainForm.sppMeasColDateRegisterClick(Sender: TObject);
begin
  MeasColumnDosReg:=sppMeasColDateRegister.Checked;
  ShowMeasGridColumns(cFieldRegTime,MeasColumnDosReg);
end;

procedure TMainForm.sppMeasColDateVerificationClick(Sender: TObject);
begin
  MeasColumnDosVer:=sppMeasColDateVerification.Checked;
  ShowMeasGridColumns(cFieldVerTime,MeasColumnDosVer);
end;

procedure TMainForm.sppMeasColLastMeasDateClick(Sender: TObject);
begin
  MeasColumnLastMeasTime:=sppMeasColLastMeasDate.Checked;
  ShowMeasGridColumns(cFieldLastMeasTime,MeasColumnLastMeasTime);
end;

procedure TMainForm.sppMeasColDClick(Sender: TObject);
begin
  MeasColumnD:=sppMeasColD.Checked;
  ShowMeasGridColumns(cFieldD,MeasColumnD);
end;

procedure TMainForm.sppMeasColDepClick(Sender: TObject);
begin
  MeasColumnDepartment:=sppMeasColDep.Checked;
  ShowMeasGridColumns(cFieldDepartment,MeasColumnDepartment);
end;

procedure TMainForm.sppMeasColDeviceIDClick(Sender: TObject);
begin
  MeasColumnTldID:=sppMeasColDeviceID.Checked;
  ShowMeasGridColumns(cFieldTldID,MeasColumnTldID);
end;

procedure TMainForm.sppMeasColDeviceUserClick(Sender: TObject);
begin
  MeasColumnTLDUser:=sppMeasColDeviceUser.Checked;
  ShowMeasGridColumns(cFieldTldUser,MeasColumnTLDUser);
end;

procedure TMainForm.sppMeasColDoseClick(Sender: TObject);
begin
  MeasColumnDose:=sppMeasColDose.Checked;
  ShowMeasGridColumns(cFieldDose,MeasColumnDose);
end;

procedure TMainForm.sppMeasColDosTypeClick(Sender: TObject);
begin
  MeasColumnDosType:=sppMeasColDosType.Checked;
  ShowMeasGridColumns(cFieldDosType,MeasColumnDosType);
end;

procedure TMainForm.sppMeasColD_ErrClick(Sender: TObject);
begin
  MeasColumnD_Err:=sppMeasColD_Err.Checked;
  ShowMeasGridColumns(cFieldD_Err,MeasColumnD_Err);
end;

procedure TMainForm.sppMeasColFIOClick(Sender: TObject);
begin
  MeasColumnFIO:=sppMeasColFIO.Checked;
  ShowMeasGridColumns(cFieldFio,MeasColumnFIO);
end;

procedure TMainForm.sppMeasColH007Click(Sender: TObject);
begin
  MeasColumnH007:=sppMeasColH007.Checked;
  ShowMeasGridColumns(cFieldH007,MeasColumnH007);
end;

procedure TMainForm.sppMeasColH007_ErrClick(Sender: TObject);
begin
  MeasColumnH007_Err:=sppMeasColH007_Err.Checked;
  ShowMeasGridColumns(cFieldH007_Err,MeasColumnH007_Err);
end;

procedure TMainForm.sppMeasColHp007Click(Sender: TObject);
begin
  MeasColumnHp007:=sppMeasColHp007.Checked;
  ShowMeasGridColumns(cFieldHp007,MeasColumnHp007);
end;

procedure TMainForm.sppMeasColHp007_ErrClick(Sender: TObject);
begin
  MeasColumnHp007_Err:=sppMeasColHp007_Err.Checked;
  ShowMeasGridColumns(cFieldHp007_Err,MeasColumnHp007_Err);
end;

procedure TMainForm.sppMeasColHp10gClick(Sender: TObject);
begin
  MeasColumnHp10g:=sppMeasColHp10g.Checked;
  ShowMeasGridColumns(cFieldHp10g,MeasColumnHp10g);
end;

procedure TMainForm.sppMeasColHp10g_ErrClick(Sender: TObject);
begin
  MeasColumnHp10g_Err:=sppMeasColHp10g_Err.Checked;
  ShowMeasGridColumns(cFieldHp10g_Err,MeasColumnHp10g_Err);
end;

procedure TMainForm.sppMeasColHp10nClick(Sender: TObject);
begin
  MeasColumnHp10n:=sppMeasColHp10n.Checked;
  ShowMeasGridColumns(cFieldHp10n,MeasColumnHp10n);
end;

procedure TMainForm.sppMeasColHp10n_ErrClick(Sender: TObject);
begin
  MeasColumnHp10n_Err:=sppMeasColHp10n_Err.Checked;
  ShowMeasGridColumns(cFieldHp10n_Err,MeasColumnHp10n_Err);
end;

procedure TMainForm.sppMeasColHp3Click(Sender: TObject);
begin
  MeasColumnHp3:=sppMeasColHp3.Checked;
  ShowMeasGridColumns(cFieldHp3,MeasColumnHp3);
end;

procedure TMainForm.sppMeasColHp3_ErrClick(Sender: TObject);
begin
  MeasColumnHp3_Err:=sppMeasColHp3_Err.Checked;
  ShowMeasGridColumns(cFieldHp3_Err,MeasColumnHp3_Err);
end;

procedure TMainForm.sppMeasColHstarClick(Sender: TObject);
begin
  MeasColumnHstar:=sppMeasColHstar.Checked;
  ShowMeasGridColumns(cFieldHstar,MeasColumnHstar);
end;

procedure TMainForm.sppMeasColHstar_ErrClick(Sender: TObject);
begin
  MeasColumnHstar_Err:=sppMeasColHstar_Err.Checked;
  ShowMeasGridColumns(cFieldHstar_Err,MeasColumnHstar_Err);
end;

procedure TMainForm.sppMeasColKSIClick(Sender: TObject);
begin
  MeasColumnKSI:=sppMeasColKSI.Checked;
  ShowMeasGridColumns(cFieldKSI,MeasColumnKSI);
end;

procedure TMainForm.sppMeasColMeasIDClick(Sender: TObject);
begin
  MeasColumnMeasID:=sppMeasColMeasID.Checked;
  ShowMeasGridColumns(cFieldDosMeasID,MeasColumnMeasID);
end;

procedure TMainForm.sppMeasColMeasTimeClick(Sender: TObject);
begin
  MeasColumnMeasDateTime:=sppMeasColMeasTime.Checked;
  ShowMeasGridColumns(cFieldMeasureTime,MeasColumnMeasDateTime);
end;

procedure TMainForm.sppMeasColOrgClick(Sender: TObject);
begin
  MeasColumnOrganization:=sppMeasColOrg.Checked;
  ShowMeasGridColumns(cFieldOrg,MeasColumnOrganization);
end;

procedure TMainForm.sppMeasColPartClick(Sender: TObject);
begin
  MeasColumnPartID:=sppMeasColPart.Checked;
  ShowMeasGridColumns(cFieldPartID,MeasColumnPartID);
end;

procedure TMainForm.sppMeasColPersNumberClick(Sender: TObject);
begin
  MeasColumnPersNumber:=sppMeasColPersNumber.Checked;
  ShowMeasGridColumns(cFieldPersNumber,MeasColumnPersNumber);
end;

procedure TMainForm.sppMeasColStatusDosClick(Sender: TObject);
begin
  MeasColumnDosStatus:=sppMeasColStatusDos.Checked;
  ShowMeasGridColumns(cFieldDosStatus,MeasColumnDosStatus);
end;

procedure TMainForm.sppMeasColStatusMeasClick(Sender: TObject);
begin
  MeasColumnMeasValidity:=sppMeasColStatusMeas.Checked;
  ShowMeasGridColumns(cFieldStringValidity,MeasColumnMeasValidity);
end;

procedure TMainForm.sppProcessColCommentDosClick(Sender: TObject);
begin
  ProcessColumnLastMeasComment:=sppProcessColCommentDos.Checked;
  ShowMeasGridColumns(cFieldLastMeasComment,ProcessColumnLastMeasComment);
end;

procedure TMainForm.sppProcessColCommentMeasClick(Sender: TObject);
begin
  ProcessColumnMeasComment:=sppProcessColCommentMeas.Checked;
  ShowMeasGridColumns(cFieldMeasComment,ProcessColumnMeasComment);
end;

procedure TMainForm.sppProcessColDateRegisterClick(Sender: TObject);
begin
  ProcessColumnDosReg:=sppProcessColDateRegister.Checked;
  ShowMeasGridColumns(cFieldRegTime,ProcessColumnDosReg);
end;

procedure TMainForm.sppProcessColDateVerificationClick(Sender: TObject);
begin
  ProcessColumnDosVer:=sppProcessColDateVerification.Checked;
  ShowMeasGridColumns(cFieldVerTime,ProcessColumnDosVer);
end;

procedure TMainForm.sppProcessColLastMeasDateClick(Sender: TObject);
begin
  ProcessColumnLastMeasTime:=sppProcessColLastMeasDate.Checked;
  ShowMeasGridColumns(cFieldLastMeasTime,ProcessColumnLastMeasTime);
end;

procedure TMainForm.sppProcessColDClick(Sender: TObject);
begin
  ProcessColumnD:=sppProcessColD.Checked;
  ShowMeasGridColumns(cFieldD,ProcessColumnD);
end;

procedure TMainForm.sppProcessColDepClick(Sender: TObject);
begin
  ProcessColumnDepartment:=sppProcessColDep.Checked;
  ShowMeasGridColumns(cFieldDepartment,ProcessColumnDepartment);
end;

procedure TMainForm.sppProcessColDeviceIDClick(Sender: TObject);
begin
  ProcessColumnTldID:=sppProcessColDeviceID.Checked;
  ShowMeasGridColumns(cFieldTldID,ProcessColumnTldID);
end;

procedure TMainForm.sppProcessColDeviceUserClick(Sender: TObject);
begin
  ProcessColumnTLDUser:=sppProcessColDeviceUser.Checked;
  ShowMeasGridColumns(cFieldTldUser,ProcessColumnTLDUser);
end;

procedure TMainForm.sppProcessColDoseClick(Sender: TObject);
begin
  ProcessColumnDose:=sppProcessColDose.Checked;
  ShowMeasGridColumns(cFieldDose,ProcessColumnDose);
end;

procedure TMainForm.sppProcessColDosTypeClick(Sender: TObject);
begin
  ProcessColumnDosType:=sppProcessColDosType.Checked;
  ShowMeasGridColumns(cFieldDosType,ProcessColumnDosType);
end;

procedure TMainForm.sppProcessColD_ErrClick(Sender: TObject);
begin
  ProcessColumnD_Err:=sppProcessColD_Err.Checked;
  ShowMeasGridColumns(cFieldD_Err,ProcessColumnD_Err);
end;

procedure TMainForm.sppProcessColFIOClick(Sender: TObject);
begin
  ProcessColumnFIO:=sppProcessColFIO.Checked;
  ShowMeasGridColumns(cFieldFio,ProcessColumnFIO);
end;

procedure TMainForm.sppProcessColH007Click(Sender: TObject);
begin
  ProcessColumnH007:=sppProcessColH007.Checked;
  ShowMeasGridColumns(cFieldH007,ProcessColumnH007);
end;

procedure TMainForm.sppProcessColH007_ErrClick(Sender: TObject);
begin
  ProcessColumnH007_Err:=sppProcessColH007_Err.Checked;
  ShowMeasGridColumns(cFieldH007_Err,ProcessColumnH007_Err);
end;

procedure TMainForm.sppProcessColHp007Click(Sender: TObject);
begin
  ProcessColumnHp007:=sppProcessColHp007.Checked;
  ShowMeasGridColumns(cFieldHp007,ProcessColumnHp007);
end;

procedure TMainForm.sppProcessColHp007_ErrClick(Sender: TObject);
begin
  ProcessColumnHp007_Err:=sppProcessColHp007_Err.Checked;
  ShowMeasGridColumns(cFieldHp007_Err,ProcessColumnHp007_Err);
end;

procedure TMainForm.sppProcessColHp10gClick(Sender: TObject);
begin
  ProcessColumnHp10g:=sppProcessColHp10g.Checked;
  ShowMeasGridColumns(cFieldHp10g,ProcessColumnHp10g);
end;

procedure TMainForm.sppProcessColHp10g_ErrClick(Sender: TObject);
begin
  ProcessColumnHp10g_Err:=sppProcessColHp10g_Err.Checked;
  ShowMeasGridColumns(cFieldHp10g_Err,ProcessColumnHp10g_Err);
end;

procedure TMainForm.sppProcessColHp10nClick(Sender: TObject);
begin
  ProcessColumnHp10n:=sppProcessColHp10n.Checked;
  ShowMeasGridColumns(cFieldHp10n,ProcessColumnHp10n);
end;

procedure TMainForm.sppProcessColHp10n_ErrClick(Sender: TObject);
begin
  ProcessColumnHp10n_Err:=sppProcessColHp10n_Err.Checked;
  ShowMeasGridColumns(cFieldHp10n_Err,ProcessColumnHp10n_Err);
end;

procedure TMainForm.sppProcessColHp3Click(Sender: TObject);
begin
  ProcessColumnHp3:=sppProcessColHp3.Checked;
  ShowMeasGridColumns(cFieldHp3,ProcessColumnHp3);
end;

procedure TMainForm.sppProcessColHp3_ErrClick(Sender: TObject);
begin
  ProcessColumnHp3_Err:=sppProcessColHp3_Err.Checked;
  ShowMeasGridColumns(cFieldHp3_Err,ProcessColumnHp3_Err);
end;

procedure TMainForm.sppProcessColHstarClick(Sender: TObject);
begin
  ProcessColumnHstar:=sppProcessColHstar.Checked;
  ShowMeasGridColumns(cFieldHstar,ProcessColumnHstar);
end;

procedure TMainForm.sppProcessColHstar_ErrClick(Sender: TObject);
begin
  ProcessColumnHstar_Err:=sppProcessColHstar_Err.Checked;
  ShowMeasGridColumns(cFieldHstar_Err,ProcessColumnHstar_Err);
end;

procedure TMainForm.sppProcessColKSIClick(Sender: TObject);
begin
  ProcessColumnKSI:=sppProcessColKSI.Checked;
  ShowMeasGridColumns(cFieldKSI,ProcessColumnKSI);
end;

procedure TMainForm.sppProcessColMeasIDClick(Sender: TObject);
begin
  ProcessColumnMeasID:=sppProcessColMeasID.Checked;
  ShowMeasGridColumns(cFieldDosMeasID,ProcessColumnMeasID);
end;

procedure TMainForm.sppProcessColMeasTimeClick(Sender: TObject);
begin
  ProcessColumnMeasDateTime:=sppProcessColMeasTime.Checked;
  ShowMeasGridColumns(cFieldMeasureTime,ProcessColumnMeasDateTime);
end;

procedure TMainForm.sppProcessColOrgClick(Sender: TObject);
begin
  ProcessColumnOrganization:=sppProcessColOrg.Checked;
  ShowMeasGridColumns(cFieldOrg,ProcessColumnOrganization);
end;

procedure TMainForm.sppProcessColPartClick(Sender: TObject);
begin
  ProcessColumnPartID:=sppProcessColPart.Checked;
  ShowMeasGridColumns(cFieldPartID,ProcessColumnPartID);
end;

procedure TMainForm.sppProcessColPersNumberClick(Sender: TObject);
begin
  ProcessColumnPersNumber:=sppProcessColPersNumber.Checked;
  ShowMeasGridColumns(cFieldPersNumber,ProcessColumnPersNumber);
end;

procedure TMainForm.sppProcessColStatusDosClick(Sender: TObject);
begin
  ProcessColumnDosStatus:=sppProcessColStatusDos.Checked;
  ShowMeasGridColumns(cFieldDosStatus,ProcessColumnDosStatus);
end;

procedure TMainForm.sppProcessColStatusMeasClick(Sender: TObject);
begin
  ProcessColumnMeasValidity:=sppProcessColStatusMeas.Checked;
  ShowMeasGridColumns(cFieldStringValidity,ProcessColumnMeasValidity);
end;

procedure TMainForm.SpeedBtnWinCascadeClick(Sender: TObject);
begin
  MainForm.Cascade;
end;

{$IFDEF MSWINDOWS}
procedure TMainForm.WMGotoForeground(var Msg: TMessage);
begin
  //сворачиваем приложение, а потом разворачиваем его
  //при этом окно будет выведено на передний план
  //Application.MessageBox(PChar(Format('%s!',[rsApplicationStartedEarlier])),PChar(Format('%s!',[rsMsgWarning])),MB_OK or MB_SYSTEMMODAL or MB_ICONWARNING); //  выводим сообщение о попытке повторного запуска программы
  QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s!',[rsApplicationStartedEarlier]),mtWarning,[mrOk],'');  //  выводим сообщение о попытке повторного запуска программы
  Application.Minimize;                                                                                                   //  выводим запущенное приложение
  Application.Restore;                                                                                                    //  на передний план вне зависимости
  Application.BringToFront;                                                                                               //  свернуто оно или нет
end;
{$ELSE}
{$ENDIF}

procedure TMainForm.WriteCommandLog(aLog: String);
begin
  if Assigned(ControlW) and Assigned(ControlW.MemoCommandLog) then
  begin
    if not ControlW.PLogPause.Checked then
    begin
      ControlW.MemoCommandLog.Lines.Add(aLog);
      ControlW.MemoCommandLog.OnChange(Self);
    end;

    //Logging(aLog); // для отладки
  end;
end;

procedure TMainForm.WritePacketLog(aLog: String);
begin
  try
    if FTestWriteModbusLog then WriteModbusLog(aLog);
  except
    on E: exception do
      showmessage(E.Message);
  end;
  if Assigned(ControlW) and Assigned(ControlW.MemoLog) then
  begin
    if not ControlW.PLogPause.Checked then
    begin
      ControlW.MemoLog.Lines.Add(aLog);
      ControlW.MemoLog.OnChange(Self);
    end;

    //Logging(aLog); // для отладки
  end;
end;

procedure TMainForm.OnReceiveModBusExchange(Log: String);
begin
  //Exit;

  WritePacketLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : '+Log+':');
end;

procedure TMainForm.OnReceiveResults;
var
  i: integer;
begin
  if not Assigned(Dosimeter) then Exit;

  Dosimeter.DetectorsCnt := TLDCommand.DetNumber;
  if Length(TLDCommand.ImpulseResult)>0 then
  begin
    if (Start) then
    begin

      case Dosimeter.DetectorsCnt of
        0:
          SeriesMeasD1Temp.Clear;
        1:
          SeriesMeasD2Temp.Clear;
        2:
          SeriesMeasD3Temp.Clear;
        3:
          SeriesMeasD4Temp.Clear;
      end;

      for i := 0 to Length(TLDCommand.ImpulseResult)-1 do
      begin
        if Assigned(Dosimeter) and (Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]<>nil) then
        begin
          case Dosimeter.DetectorsCnt of
            0:
            begin
              SeriesMeasD1Temp.AddXY(i,(TLDCommand.TempResult[i]*Dosimeter.CntDetector.K1Profile-Dosimeter.CntDetector.K2Profile*cTempProfileMult)/10);
              Dosimeter.CntDetector.Temp_Buff[i]:=TLDCommand.TempResult[i];
            end;
            1:
            begin
              SeriesMeasD2Temp.AddXY(i,(TLDCommand.TempResult[i]*Dosimeter.CntDetector.K1Profile-Dosimeter.CntDetector.K2Profile*cTempProfileMult)/10);
              Dosimeter.CntDetector.Temp_Buff[i]:=TLDCommand.TempResult[i];
            end;
            2:
            begin
              SeriesMeasD3Temp.AddXY(i,(TLDCommand.TempResult[i]*Dosimeter.CntDetector.K1Profile-Dosimeter.CntDetector.K2Profile*cTempProfileMult)/10);
              Dosimeter.CntDetector.Temp_Buff[i]:=TLDCommand.TempResult[i];
            end;
            3:
            begin
              SeriesMeasD4Temp.AddXY(i,(TLDCommand.TempResult[i]*Dosimeter.CntDetector.K1Profile-Dosimeter.CntDetector.K2Profile*cTempProfileMult)/10);
              Dosimeter.CntDetector.Temp_Buff[i]:=TLDCommand.TempResult[i];
            end;
          end;

        end;
      end;
    end
  end;
  if Length(TLDCommand.ImpulseResult)>0 then
  begin
    if (Start) then
    begin
      case Dosimeter.DetectorsCnt of
        0:
          begin
            if not SeriesMeasD1KTV.active then SeriesMeasD1KTV.active:=true;
            SeriesMeasD1KTV.Clear;
          end;
        1:
          begin
            if not SeriesMeasD2KTV.active then SeriesMeasD2KTV.active:=true;
            SeriesMeasD2KTV.Clear;
          end;
        2:
          begin
            if not SeriesMeasD3KTV.active then SeriesMeasD3KTV.active:=true;
            SeriesMeasD3KTV.Clear;
          end;
        3:
          begin
            if not SeriesMeasD4KTV.active then SeriesMeasD4KTV.active:=true;
            SeriesMeasD4KTV.Clear;
          end;
      end;

      for i := 0 to Length(TLDCommand.ImpulseResult)-1 do
      begin
        if Assigned(Dosimeter) and (Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]<>nil) then
        begin
          case Dosimeter.DetectorsCnt of
            0:
              begin
                //SeriesMeasD1KTV.Clear;
                SeriesMeasD1KTV.AddXY(i,TLDCommand.ImpulseResult[i]);
                Dosimeter.CntDetector.LightSum:={Dosimeter.CntDetector.LightSum+}TLDCommand.ImpulseResult[i];
                Dosimeter.CntDetector.KTV_Buff[i]:=TLDCommand.ImpulseResult[i];
                Dosimeter.CntDetector.ReadedPoints:=i;
                //TLDChartMeasDataD1.Series[0].AddXY(i,TLDCommand.ImpulseResult[i]);
                GaugeMeasDataD1.Progress:=Length(TLDCommand.ImpulseResult);
                if StartMeasureW.Showing then
                  StartMeasureW.GaugePageMeasStatusD1.Progress:=Length(TLDCommand.ImpulseResult);

              end;
            1:
              begin
                //SeriesMeasD2KTV.Clear;
                SeriesMeasD2KTV.AddXY(i,TLDCommand.ImpulseResult[i]);
                Dosimeter.CntDetector.LightSum:={Dosimeter.CntDetector.LightSum+}TLDCommand.ImpulseResult[i];
                Dosimeter.CntDetector.KTV_Buff[i]:=TLDCommand.ImpulseResult[i];
                Dosimeter.CntDetector.ReadedPoints:=i;
                //TLDChartMeasDataD2.Series[0].AddXY(i,TLDCommand.ImpulseResult[i]);
                GaugeMeasDataD2.Progress:=Length(TLDCommand.ImpulseResult);
                if StartMeasureW.Showing then
                  StartMeasureW.GaugePageMeasStatusD2.Progress:=Length(TLDCommand.ImpulseResult);
              end;
            2:
              begin
                //SeriesMeasD3KTV.Clear;
                SeriesMeasD3KTV.AddXY(i,TLDCommand.ImpulseResult[i]);
                Dosimeter.CntDetector.LightSum:={Dosimeter.CntDetector.LightSum+}TLDCommand.ImpulseResult[i];
                Dosimeter.CntDetector.KTV_Buff[i]:=TLDCommand.ImpulseResult[i];
                Dosimeter.CntDetector.ReadedPoints:=i;
                //TLDChartMeasDataD3.Series[0].AddXY(i,TLDCommand.ImpulseResult[i]);
                GaugeMeasDataD3.Progress:=Length(TLDCommand.ImpulseResult);
                if StartMeasureW.Showing then
                  StartMeasureW.GaugePageMeasStatusD3.Progress:=Length(TLDCommand.ImpulseResult);
              end;
            3:
              begin
                //SeriesMeasD4KTV.Clear;
                SeriesMeasD4KTV.AddXY(i,TLDCommand.ImpulseResult[i]);
                Dosimeter.CntDetector.LightSum:={Dosimeter.CntDetector.LightSum+}TLDCommand.ImpulseResult[i];
                Dosimeter.CntDetector.KTV_Buff[i]:=TLDCommand.ImpulseResult[i];
                Dosimeter.CntDetector.ReadedPoints:=i;
                //TLDChartMeasDataD4.Series[0].AddXY(i,TLDCommand.ImpulseResult[i]);
                GaugeMeasDataD4.Progress:=Length(TLDCommand.ImpulseResult);
                if StartMeasureW.Showing then
                  StartMeasureW.GaugePageMeasStatusD4.Progress:=Length(TLDCommand.ImpulseResult);
              end;
          end;
        end;
      end;
    end
    //else if ControlW.Showing then
    //begin
    //  ControlW.SeriesKTV.Clear;
    //  for i := 0 to Length(TLDCommand.ImpulseResult)-1 do
    //    ControlW.SeriesKTV.AddXY(i,TLDCommand.ImpulseResult[i]);
    //
    //  DSeriaAutoSize(ControlW.TLDChart,ControlW.SeriesKTV);
    //
    //  ControlW.SeriesGlade.Clear;
    //  ShowDetectorDataGlade(ControlW.SeriesKTV,ControlW.SeriesGlade);
    //
    //end;
  end;
  //TimerMeasureTimer(Nil);

  if not (TLDCommand.StartMeasuringFlag) then // ждем пока закончится измерение, если оно уже начато
  begin
    if (Dosimeter.MeasurementID = 0) then
    begin
      try
        CreateDosimeterData; // добавление новой (чистой) записи в таблицу результатов измерений
        UpdateGridMeasPage;
      except
        on E: exception do
        begin
          SpeedBtnStopClick(Self);
          MessageDlg(E.Message,mtError, [mbOK], 0);
        end;
      end;
    end;

    if Assigned(Dosimeter) then
    begin
      if (Dosimeter.DetectorsList[Dosimeter.DetectorsCnt] <> nil) // проверяем наличие детектора в данной позиции типа дозиметра
      then CalcForm.SetDefaultOptions(TDetector(Dosimeter.DetectorsList[Dosimeter.DetectorsCnt]))
      else inc(Dosimeter.DetectorsCnt);   // если в типе дозиметра на этой позиции нет детектора
                                          // увеличиваем счетчик детекторов и переходим к следующему
    end;
  end;

end;

procedure TMainForm.OnEndMeasure(aCarretPosition: TCarretePosition; aFinished: boolean);
var
  ii,i,j: integer;
  DetPos: integer;
begin
  if StartMeasureW.Showing then StartMeasureW.Close;

  Dosimeter.Validity := stDosMeasFinishedD1;

  for ii:=1 to 2 do
  begin
    i:=ii; // норм для carDet23
    if (aCarretPosition = carDet14) then
    begin
      if ii=1
        then i:=0
        else i:=3;
    end
      else
        if TLDCommand.ChangeData.DetectorCount=2 then i:=ii-1;

    if Dosimeter.DetectorsList[i]<>nil then
    begin
      DetPos:=i+1;
      TDetector(Dosimeter.DetectorsList[i]).Position:=DetPos;

      Dosimeter.DetectorsCnt := i;

      SaveDetTXTResults(Format('%s_%s_%s_%s%d',[DateTimeToStr_Format(Now),'Dosimeter',Dosimeter.FullNumber,'Detector',DetPos]));  // сохранение результатов узмерений детектора в текстовом файле
      InsertDetectorKtvTmp(DetPos);     // запись в БД значений считанных КТВ и температурного профиля
      OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsSrcData,rsD,DetPos,rsSaveToDB]),'', cMsgInf,cMsgPriorityInf);
      //Dosimeter.Validity := TDosimeterValidity(Ord(stDosMeasFinishedD1)+i);
      Dosimeter.CntDetector.State := stDetMeasFinished;
      SetLength(TLDCommand.ImpulseResult,300);
      if (ii=1)
        then for j:=0 to 299 do TLDCommand.ImpulseResult[j] := TLDCommand.PMT.Buffer_total[j].Channel1
        else for j:=0 to 299 do TLDCommand.ImpulseResult[j] := TLDCommand.PMT.Buffer_total[j].Channel2;

      CalcDetectorDose;                 // запуск расчета
      Dosimeter.Validity := TDosimeterValidity(ord(stDosMeasFinishedD1)+i);

      OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsData,rsD,DetPos,rsCalculated]),'', cMsgInf,cMsgPriorityInf);
      ShowCalcFunctions(DetPos);        // отображение расчетных кривых
      OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsData,rsD,DetPos,rsShowed]),'', cMsgInf,cMsgPriorityInf);
      UpdateDetectorMeasData(DetPos);   // обновление и запись расчетных данных в БД
      OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsData,rsD,DetPos,rsSaveToDB]),'', cMsgInf,cMsgPriorityInf);

      TLDCommand.Panel.Output.Detector_Dose[DetPos]  := TDetector(Dosimeter.DetectorsList[i]).Dose;
    end;
  end;
  //Dosimeter.DetectorsCnt := cStepDosMeasFinished;
  if aFinished then
  begin
    Dosimeter.MeasTime:=Now;
    Dosimeter.Validity:=Dosimeter.GetDosimeterValidity;
    Dosimeter.LastMeasComment:='';
    Dosimeter.CalcDose;
    Dosimeter.DetectorsCnt:=0;
    SaveDosimeterData;
    OnCommandLog(TimeToStr(Now)+' : -> ',format(rsMeasurementDone,[Dosimeter.FullNumber]),'',cMsgInf,cMsgPriorityInf);
    //TimerMeasure.Enabled:=False;
    Start:=False;
    if SpeedBtnMeasSaveParam.Enabled then SpeedBtnMeasSaveParam.Click;
    if SpeedBtnMeasSaveIDK.Enabled then SpeedBtnMeasSaveIDK.Click;
    JvDateTimePickerMeas.Date:=Date;
    UpdateGridMeasAndProcessPages;                  // вызовы после каждого измерения жрут память
    UpdateDataDosFilter(FilterDosDosNumber);        // вызовы после каждого измерения жрут память

    //if TimerMeasure.Enabled then            // останавливаем таймер
    //  TimerMeasure.Enabled := False;
    //
    if TimerTest.Enabled then               // останавливаем таймер
      TimerTest.Enabled := False;

    if TimerSourceTest.Enabled then         // останавливаем таймер
      TimerSourceTest.Enabled := False;

    //if Assigned(TLDCommand.COMPortSyn) then
      //if TLDCommand.COMPortSyn.Connected then
    //TLD_CommandSeries.DeviceStopEmergency;

    // Завершение
    CntD:=0;
    TLDState:=0;
    if Start then
    begin
      Start:=False;

      if TLDCommand.StartMeasuringFlag then
        TLDCommand.StartMeasuringFlag:=false;
    end;

    TLDCommand.Panel.Output.Dosimeter_DoseHp10g := Dosimeter.Dose_Hp_10g;
    TLDCommand.Panel.Output.Dosimeter_DoseHp10n := Dosimeter.Dose_Hp_10n;
    TLDCommand.Panel.Output.Dosimeter_DoseHp007 := Dosimeter.Dose_Hp_007;
    TLDCommand.Panel.Output.Dosimeter_DoseHp3   := Dosimeter.Dose_Hp_3;
  end;
end;

procedure TMainForm.OnReceiveCommand_CloseStartMFWindow;
begin
  if StartMeasureW.Showing then StartMeasureW.Close;
end;

procedure TMainForm.OnReceiveCommand_MeasureStopped;
begin
  SpeedBtnStopClick(Nil);
end;

procedure TMainForm.OnReceiveTemp;
var
  Temp: double;
begin
  Temp := (TLDCommand.AirHeat.Temperature[2]/10 + TLDCommand.AirHeat.Temperature[3]/10)/2; // средняя температура по нашей небольшой больнице
//  Temp := TLDCommand.MonitorBoard.CurrentTemperature/10; // температура ФЭУ
  if Assigned(Dosimeter) and FStart then
  begin
    EditTemp.Text:=FormatFloat('0.0',Temp)+' C';
  end
  else
  begin
    //ControlW.EditTemp.Text:=FormatFloat('0.0',Temp)+' C';
    EditTemp.Text:=FormatFloat('0.0',Temp)+' C';
  end;

  if Temp <= TLDCommand.cMaxStartMeasureTemp then
  begin
    TmpState:=cTmpGreen;
  end
  else
  begin
    TmpState:=cTmpRed;
  end;
end;

procedure TMainForm.OnReceiveWorkingTime(WorkingTime: dword);
begin
  if ControlW.Showing then
  begin
    //ControlW.EditWorkingTime.Text:=FloatToStrRegion(Round(WorkingTime/1000));
  end;
end;

procedure TMainForm.OnReceiveConstructiveVer(Value: integer);
begin
  if ConstructiveVersion<>Value then
    ConstructiveVersion:=Value;
end;

procedure TMainForm.OnReceiveDeviceID(Value: integer);
begin
  if DeviceID<>Value then
  begin
    // записываем ID в БД
    TLDDataModule.WriteDeviceID(Value);

    DeviceID:=Value;


//**    UpdateGridPageStart;
//    // считываем параметры установки
//    TLDDataModule.ReadTLDSettings(Value,FKSLevel,FKSDelta,FKFilter);
//    ControlW.ReadTLDSettings;
  end;
end;

procedure TMainForm.OnReceiveSoftwareVer(Value: String);
begin
  EditSettingsSoftwareVer.Text:=Value;
//
//  if DeviceID <> cEmulatorID then
//    EditSettingsSoftwareVer.Text:=Value
//  else
//    EditSettingsSoftwareVer.Text:='-';
end;

procedure TMainForm.OnChangeDetComment(Sender: TObject);
  procedure ChangeStatusBtn(Sender: TObject; SpeedBtn: TSpeedButton);
  begin
    case TDetector(Sender).State of
      stDetProcessedError,stDetProcessedWarning:
      begin
        SpeedBtn.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+cImgBtnErr);
        //SpeedBtn.Hint:=TDetector(Sender).Comment;
        SpeedBtn.Visible:=true;
      end;
      stDetSkiped,stDetBroken,stDetLost,stDetNotMeasured:
      begin
        SpeedBtn.Visible:=false;
      end
      else
      begin
        SpeedBtn.Glyph.LoadFromFile(extractfilepath(Application.ExeName)+'Images'+PathDelim+'Menu'+PathDelim+cImgBtnSettings);
        SpeedBtn.Visible:=true;
      end;
    end;

    SpeedBtn.Hint:=TDetector(Sender).Comment;
//    SpeedBtn.Visible:=true;

  end;
begin
  case PageControlMain.ActivePageIndex of
    cPageMeasIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          ChangeStatusBtn(Sender,SpeedBtnMeasDataWarningD1);
          SetDetComment(LblMeasDataCommentD1Value,TDetector(Sender).Comment);
        end;
      cDetPos2:
        begin
          ChangeStatusBtn(Sender,SpeedBtnMeasDataWarningD2);
          SetDetComment(LblMeasDataCommentD2Value,TDetector(Sender).Comment);
        end;
      cDetPos3:
        begin
          ChangeStatusBtn(Sender,SpeedBtnMeasDataWarningD3);
          SetDetComment(LblMeasDataCommentD3Value,TDetector(Sender).Comment);
        end;
      cDetPos4:
        begin
          ChangeStatusBtn(Sender,SpeedBtnMeasDataWarningD4);
          SetDetComment(LblMeasDataCommentD4Value,TDetector(Sender).Comment);
        end;
      end;
    end;
    cPageDosIndex:
    begin

    end;
    cPageProcessIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          ChangeStatusBtn(Sender,SpeedBtnProcessDataWarningD1);
          SetDetComment(LblProcessDataCommentD1Value,TDetector(Sender).Comment);
        end;
      cDetPos2:
        begin
          ChangeStatusBtn(Sender,SpeedBtnProcessDataWarningD2);
          SetDetComment(LblProcessDataCommentD2Value,TDetector(Sender).Comment);
        end;
      cDetPos3:
        begin
          ChangeStatusBtn(Sender,SpeedBtnProcessDataWarningD3);
          SetDetComment(LblProcessDataCommentD3Value,TDetector(Sender).Comment);
        end;
      cDetPos4:
        begin
          ChangeStatusBtn(Sender,SpeedBtnProcessDataWarningD4);
          SetDetComment(LblProcessDataCommentD4Value,TDetector(Sender).Comment);
        end;
      end
    end;
  end;
end;

procedure TMainForm.OnChangeDetDose(Sender: TObject);
begin
  case PageControlMain.ActivePageIndex of
    cPageMeasIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          SetDetEdit(EditMeasDataD1Dose,FloatToStrRegion(TDetector(Sender).Dose),FloatToStrRegion(TDetector(Sender).Err),TDetector(Sender).State)
        end;
      cDetPos2:
        begin
          SetDetEdit(EditMeasDataD2Dose,FloatToStrRegion(TDetector(Sender).Dose),FloatToStrRegion(TDetector(Sender).Err),TDetector(Sender).State)
        end;
      cDetPos3:
        begin
          SetDetEdit(EditMeasDataD3Dose,FloatToStrRegion(TDetector(Sender).Dose),FloatToStrRegion(TDetector(Sender).Err),TDetector(Sender).State)
        end;
      cDetPos4:
        begin
          SetDetEdit(EditMeasDataD4Dose,FloatToStrRegion(TDetector(Sender).Dose),FloatToStrRegion(TDetector(Sender).Err),TDetector(Sender).State)
        end;
      end;
    end;
    cPageDosIndex:
    begin

    end;
    cPageProcessIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          SetDetEdit(EditProcessDataD1Dose,FloatToStrRegion(TDetector(Sender).Dose),FloatToStrRegion(TDetector(Sender).Err),TDetector(Sender).State)
        end;
      cDetPos2:
        begin
          SetDetEdit(EditProcessDataD2Dose,FloatToStrRegion(TDetector(Sender).Dose),FloatToStrRegion(TDetector(Sender).Err),TDetector(Sender).State)
        end;
      cDetPos3:
        begin
          SetDetEdit(EditProcessDataD3Dose,FloatToStrRegion(TDetector(Sender).Dose),FloatToStrRegion(TDetector(Sender).Err),TDetector(Sender).State)
        end;
      cDetPos4:
        begin
          SetDetEdit(EditProcessDataD4Dose,FloatToStrRegion(TDetector(Sender).Dose),FloatToStrRegion(TDetector(Sender).Err),TDetector(Sender).State)
        end;
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDetLightSum(Sender: TObject);
begin
  case PageControlMain.ActivePageIndex of
    cPageMeasIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
//          LblMeasDataLightSumD1Value.Caption:=IntToStr(TDetector(Sender).LightSum);
//          SetDetEdit(EditMeasDataD1Dose,TDetector(Sender).Dose,TDetector(Sender).Err,TDetector(Sender).State)
        end;
      cDetPos2:
        begin
//          LblMeasDataLightSumD2Value.Caption:=IntToStr(TDetector(Sender).LightSum);
//          SetDetEdit(EditMeasDataD2Dose,TDetector(Sender).Dose,TDetector(Sender).Err,TDetector(Sender).State)
        end;
      cDetPos3:
        begin
//          LblMeasDataLightSumD3Value.Caption:=IntToStr(TDetector(Sender).LightSum);
//          SetDetEdit(EditMeasDataD3Dose,TDetector(Sender).Dose,TDetector(Sender).Err,TDetector(Sender).State)
        end;
      cDetPos4:
        begin
//          LblMeasDataLightSumD4Value.Caption:=IntToStr(TDetector(Sender).LightSum);
//          SetDetEdit(EditMeasDataD4Dose,TDetector(Sender).Dose,TDetector(Sender).Err,TDetector(Sender).State)
        end;
      end;
    end;
    cPageDosIndex:
    begin

    end;
    cPageProcessIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
//          SetDetEdit(EditProcessDataD1Dose,TDetector(Sender).Dose,TDetector(Sender).Err,TDetector(Sender).State)
        end;
      cDetPos2:
        begin
//          SetDetEdit(EditProcessDataD2Dose,TDetector(Sender).Dose,TDetector(Sender).Err,TDetector(Sender).State)
        end;
      cDetPos3:
        begin
//          SetDetEdit(EditProcessDataD3Dose,TDetector(Sender).Dose,TDetector(Sender).Err,TDetector(Sender).State)
        end;
      cDetPos4:
        begin
//          SetDetEdit(EditProcessDataD4Dose,TDetector(Sender).Dose,TDetector(Sender).Err,TDetector(Sender).State)
        end;
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDetErr(Sender: TObject);
begin
//  case TDetector(Sender).Position of
//  cDetPos1:
//    begin
//      SetDetEdit(EditD1Err,TDetector(Sender).Err,TDetector(Sender).State)
//    end;
//  cDetPos2:
//    begin
//      SetDetEdit(EditD2Err,TDetector(Sender).Err,TDetector(Sender).State)
//    end;
//  cDetPos3:
//    begin
//      SetDetEdit(EditD3Err,TDetector(Sender).Err,TDetector(Sender).State)
//    end;
//  cDetPos4:
//    begin
//      SetDetEdit(EditD4Err,TDetector(Sender).Err,TDetector(Sender).State)
//    end;
//  end;
end;

procedure TMainForm.OnChangeDetState(Sender: TObject);
begin
  case PageControlMain.ActivePageIndex of
    cPageMeasIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          SetDetStateEdit(EditMeasDataD1Status,TDetector(Sender).State);
          if StartMeasureW.Showing then
            SetDetStateEdit(StartMeasureW.EditPageMeasStatusD1,TDetector(Sender).State);
        end;
      cDetPos2:
        begin
          SetDetStateEdit(EditMeasDataD2Status,TDetector(Sender).State);
          if StartMeasureW.Showing then
            SetDetStateEdit(StartMeasureW.EditPageMeasStatusD2,TDetector(Sender).State);
        end;
      cDetPos3:
        begin
          SetDetStateEdit(EditMeasDataD3Status,TDetector(Sender).State);
          if StartMeasureW.Showing then
            SetDetStateEdit(StartMeasureW.EditPageMeasStatusD3,TDetector(Sender).State);
        end;
      cDetPos4:
        begin
          SetDetStateEdit(EditMeasDataD4Status,TDetector(Sender).State);
          if StartMeasureW.Showing then
            SetDetStateEdit(StartMeasureW.EditPageMeasStatusD4,TDetector(Sender).State);
        end;
      end;
    end;
    cPageDosIndex:
    begin

    end;
    cPageProcessIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          SetDetStateEdit(EditProcessDataD1Status,TDetector(Sender).State);
        end;
      cDetPos2:
        begin
          SetDetStateEdit(EditProcessDataD2Status,TDetector(Sender).State);
        end;
      cDetPos3:
        begin
          SetDetStateEdit(EditProcessDataD3Status,TDetector(Sender).State);
        end;
      cDetPos4:
        begin
          SetDetStateEdit(EditProcessDataD4Status,TDetector(Sender).State);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDetType(Sender: TObject);
  procedure ClearEdit (EditMeasVal,EditK,EditMaterial,EditMethod: TEdit;
                       GroupBox: TGroupBox);
  begin
    GroupBox.Visible:=false;
    EditMeasVal.Clear;
    EditK.Clear;
    EditMaterial.Clear;
    EditMethod.Clear;
  end;
  procedure SetEdit(EditMeasVal,EditK,EditMaterial,EditMethod: TEdit;
                    MeasVal,K,Material,Method: String;
                    GroupBox: TGroupBox);
  begin
    EditMeasVal.Text:=MeasVal;
    EditK.Text:=K;
    EditMaterial.Text:=Material;
    EditMethod.Text:=Method;
    GroupBox.Visible:=true;
  end;
begin
  case PageControlMain.ActivePageIndex of
    cPageMeasIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          LblMeasDataNameD1.Caption:=Format('%s (%s)',[rsDetector1,TDetector(Sender).DetType]);
//          LblMeasDataTypeD1Value.Caption:=TDetector(Sender).DetType;
        end;
      cDetPos2:
        begin
          LblMeasDataNameD2.Caption:=Format('%s (%s)',[rsDetector2,TDetector(Sender).DetType]);
//          LblMeasDataTypeD2Value.Caption:=TDetector(Sender).DetType;
        end;
      cDetPos3:
        begin
          LblMeasDataNameD3.Caption:=Format('%s (%s)',[rsDetector3,TDetector(Sender).DetType]);
//          LblMeasDataTypeD3Value.Caption:=TDetector(Sender).DetType;
        end;
      cDetPos4:
        begin
          LblMeasDataNameD4.Caption:=Format('%s (%s)',[rsDetector4,TDetector(Sender).DetType]);
//          LblMeasDataTypeD4Value.Caption:=TDetector(Sender).DetType;
        end;
      end;
    end;
    cPageDosIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          SetEdit(EditMeasValD1,EditKD1,EditD1,EditMethodD1,
                  TDetector(Sender).GetMeasValFromFormula,
                  TDetector(Sender).GetKFromFormula,
                  TDetector(Sender).DetType,
                  TDetector(Sender).Method,
                  GBoxD1);
          ClearEdit(EditMeasValD2,EditKD2,EditD2,EditMethodD2,GBoxD2);
          ClearEdit(EditMeasValD3,EditKD3,EditD3,EditMethodD3,GBoxD3);
          ClearEdit(EditMeasValD4,EditKD4,EditD4,EditMethodD4,GBoxD4);
        end;
      cDetPos2:
        begin
          SetEdit(EditMeasValD2,EditKD2,EditD2,EditMethodD2,
                  TDetector(Sender).GetMeasValFromFormula,
                  TDetector(Sender).GetKFromFormula,
                  TDetector(Sender).DetType,
                  TDetector(Sender).Method,
                  GBoxD2);
          ClearEdit(EditMeasValD3,EditKD3,EditD3,EditMethodD3,GBoxD3);
          ClearEdit(EditMeasValD4,EditKD4,EditD4,EditMethodD4,GBoxD4);
        end;
      cDetPos3:
        begin
          SetEdit(EditMeasValD3,EditKD3,EditD3,EditMethodD3,
                  TDetector(Sender).GetMeasValFromFormula,
                  TDetector(Sender).GetKFromFormula,
                  TDetector(Sender).DetType,
                  TDetector(Sender).Method,
                  GBoxD3);
          ClearEdit(EditMeasValD4,EditKD4,EditD4,EditMethodD4,GBoxD4);
        end;
      cDetPos4:
        begin
          SetEdit(EditMeasValD4,EditKD4,EditD4,EditMethodD4,
                  TDetector(Sender).GetMeasValFromFormula,
                  TDetector(Sender).GetKFromFormula,
                  TDetector(Sender).DetType,
                  TDetector(Sender).Method,
                  GBoxD4);
        end;
      end;
    end;
    cPageProcessIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          LblProcessDataNameD1.Caption:=Format('%s (%s)',[rsDetector1,TDetector(Sender).DetType]);
          //LblProcessDataTypeD1Value.Caption:=TDetector(Sender).DetType;
        end;
      cDetPos2:
        begin
          LblProcessDataNameD2.Caption:=Format('%s (%s)',[rsDetector2,TDetector(Sender).DetType]);
          //LblProcessDataTypeD2Value.Caption:=TDetector(Sender).DetType;
        end;
      cDetPos3:
        begin
          LblProcessDataNameD3.Caption:=Format('%s (%s)',[rsDetector3,TDetector(Sender).DetType]);
          //LblProcessDataTypeD3Value.Caption:=TDetector(Sender).DetType;
        end;
      cDetPos4:
        begin
          LblProcessDataNameD4.Caption:=Format('%s (%s)',[rsDetector4,TDetector(Sender).DetType]);
          //LblProcessDataTypeD4Value.Caption:=TDetector(Sender).DetType;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDetTypeComment(Sender: TObject);
begin
// обработка описания типа детектора
end;

procedure TMainForm.OnChangeLastMeasComment(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin

      end;
      cPageDosIndex:
      begin
//        ChangeStringEdit(EditDosDataCommentVal,Dosimeter.LastMeasComment,clWindow);
      end;
      cPageProcessIndex:
      begin

      end;
    end;
  end;
end;

procedure TMainForm.OnChangeLastMeasResult(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin

      end;
      cPageDosIndex:
      begin
        if (Dosimeter.LastMeasComment<>'') then
          ChangeStringEdit(EditLastMeasResult,Dosimeter.LastMeasComment,RGBToColor(255,204,255))
        else
          ChangeDosValidityEdit(EditLastMeasResult,Dosimeter.LastMeasResult);
      end;
      cPageProcessIndex:
      begin

      end;
    end;
  end;
end;

procedure TMainForm.OnChangeLastMeasTime(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin

      end;
      cPageDosIndex:
      begin
        ChangeDataLabel(LblLastMeasDateVal,Dosimeter.LastMeasTime);
      end;
      cPageProcessIndex:
      begin

      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterDepartment(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        ChangeStringEdit(EditMeasDataDosDep,Dosimeter.Department,clWhite);
      end;
      cPageDosIndex:
      begin
        ChangeStringEdit(EditDosDataDosDepVal,Dosimeter.Department,clWindow);
      end;
      cPageProcessIndex:
      begin
        ChangeStringEdit(EditProcessDataDosDep,Dosimeter.Department,clWhite);
      end;
    end;
  end;
end;

// Переделать!!!!

procedure TMainForm.OnChangeDosimeterDose(Sender: TObject);
var
  i         : integer;
  outString : String;
begin
  if Dosimeter<>nil then
  begin

    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        for i := 0 to Length(Dosimeter.Doses.DoseArray)-1 do
        begin
          if i = Length(Dosimeter.Doses.DoseArray)-1 then
            outString:=outString + Dosimeter.Doses.DoseArray[i].Name+'='+FloatToStrRegion(RoundToCN(Dosimeter.Doses.DoseArray[i].Value,cAfterComma))+' '+rsUntmSv
          else
            outString:=outString + Dosimeter.Doses.DoseArray[i].Name+'='+FloatToStrRegion(RoundToCN(Dosimeter.Doses.DoseArray[i].Value,cAfterComma))+' '+rsUntmSv+'; ';
        end;

        ChangeDosDoseEdit(EditMeasDataDose,
                          Dosimeter.Validity,
                          Format('%s',[outString]));

        EditMeasDataDose.Hint:=outString;
        //**Dosimeter.MeasValues:=outString;
      end;
      cPageDosIndex:
      begin

      end;
      cPageProcessIndex:
      begin
        for i := 0 to Length(Dosimeter.Doses.DoseArray)-1 do
        begin
          if i = Length(Dosimeter.Doses.DoseArray)-1 then
            outString:=outString + Dosimeter.Doses.DoseArray[i].Name+'='+FloatToStrRegion(RoundToCN(Dosimeter.Doses.DoseArray[i].Value,cAfterComma))+' '+rsUntmSv
          else
            outString:=outString + Dosimeter.Doses.DoseArray[i].Name+'='+FloatToStrRegion(RoundToCN(Dosimeter.Doses.DoseArray[i].Value,cAfterComma))+' '+rsUntmSv+'; ';
        end;

        ChangeDosDoseEdit(EditProcessDataDose,
                          Dosimeter.Validity,
                          Format('%s',[outString]));

        EditProcessDataDose.Hint:=outString;
        //**Dosimeter.MeasValues:=outString;
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterDoseType(Sender: TObject);
var
  dosType: String;
begin
  if Dosimeter<>nil then
  begin

    if StartMeasureW.Showing then
    begin
//      case StartMeasureW.StartView of
//        cStartSingle,
//        cStartSeria,
//        cContinueSeria: StartMeasureW.CBoxDosType.ItemIndex:=StartMeasureW.CBoxDosType.Items.IndexOf(Dosimeter.DosType);
//      end;
      StartMeasureW.CBoxDosType.ItemIndex:=StartMeasureW.CBoxDosType.Items.IndexOf(Dosimeter.DosType);
    end;

    dosType:=Format('(%s)',[Dosimeter.DosType]);

    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        if Pos(dosType,LblMeasDataDosNumberVal.Caption) = 0 then
          LblMeasDataDosNumberVal.Caption:=Format('%s %s',[LblMeasDataDosNumberVal.Caption,dosType]);
      end;
      cPageDosIndex:
      begin
        EditDosDataDosTypeVal.Text:=Dosimeter.DosType;
      end;
      cPageProcessIndex:
      begin
        if Pos(dosType,LblProcessDataDosNumberVal.Caption) = 0 then
          LblProcessDataDosNumberVal.Caption:=Format('%s %s',[LblProcessDataDosNumberVal.Caption,dosType]);
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterErr(Sender: TObject);
begin
  case PageControlMain.ActivePageIndex of
    cPageMeasIndex:
    begin

    end;
    cPageDosIndex:
    begin
//      EditDosDataErrVal.Text:=Format('%s %s',[Dosimeter.Error,'%']);
    end;
    cPageProcessIndex:
    begin

    end;
  end;



//  if Dosimeter<>nil then
//  begin
//    case Dosimeter.Validity of
//      stDosMeasFinished:
//      begin
//        FinishMeasureW.EditDosErr.Text:=Format('%s %s',[Dosimeter.Error,rsUntmSv]);
//        FinishMeasureW.EditDosErr.Color:=clBtnFace;
//      end;
//      stDosMeasAccepted:
//      begin
//        FinishMeasureW.EditDosErr.Text:=Format('%s %s',[Dosimeter.Error,rsUntmSv]);
//        FinishMeasureW.EditDosErr.Color:=clBtnFace;
//      end;
//      stDosMeasWarning:
//      begin
//        FinishMeasureW.EditDosErr.Text:=Format('%s %s',[Dosimeter.Error,rsUntmSv]);
//        FinishMeasureW.EditDosErr.Color:=clSkyBlue;
//      end;
//      stDosMeasError:
//      begin
//        FinishMeasureW.EditDosErr.Text:=Format('%s',['-']);
//        FinishMeasureW.EditDosErr.Color:=clYellow;
//      end;
//      else
//      begin
//        FinishMeasureW.EditDosErr.Text:=Format('%s',['']);
//        FinishMeasureW.EditDosErr.Color:=clSilver;
//      end;
//    end;
//  end;
end;

procedure TMainForm.OnChangeDosimeterFIO(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        //**//ChangeStringLabel(LblMeasDataDosFioVal,Dosimeter.Fio);
        ChangeStringEdit(EditMeasDataDosFio,Dosimeter.FIO,clWindow)
        //if StartMeasureW.Showing then StartMeasureW.EditPageIDKFio.Text:=Dosimeter.Fio;
      end;
      cPageDosIndex:
      begin
        ChangeStringEdit(EditDosDataDosFIOVal,Dosimeter.FIO,clWindow);
      end;
      cPageProcessIndex:
      begin
        ChangeStringEdit(EditProcessDataDosFio,Dosimeter.FIO,clWindow);
        //ChangeStringLabel(LblProcessDataDosFioVal,Dosimeter.Fio);
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterFormula(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        LblMeasDataFormulaDosVal.Caption:=Dosimeter.Formula;
      end;
      cPageDosIndex:
      begin
        EditDosDataFormulaDosVal.Text:=Dosimeter.Formula;
        EditDosDataDosVal.Text:=Dosimeter.Formula;
      end;
      cPageProcessIndex:
      begin
        LblProcessDataFormulaDosVal.Caption:=Dosimeter.Formula;
      end;
    end;

//    FinishMeasureW.LblFormulaDosVal.Caption:=Dosimeter.Formula;
  end;
end;

procedure TMainForm.OnChangeDosimeterFormulaID(Sender: TObject);
begin
  // обработка formulaId
end;

procedure TMainForm.OnChangeDosimeterKFilter(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        if Dosimeter.KFilter <> cDosNoFilter then
        begin
          LblMeasDataFilter.Caption:=Format(rsFilterSet,[FloatToStrRegion(Dosimeter.KFilter)]);
          LblMeasDataFilter.Visible:=True;
        end
        else
        begin
          LblMeasDataFilter.Caption:='';
          LblMeasDataFilter.Visible:=False;
        end;
      end;
      cPageDosIndex:
      begin

      end;
      cPageProcessIndex:
      begin
        if Dosimeter.KFilter <> cDosNoFilter then
        begin
          LblProcessDataFilter.Caption:=Format(rsFilterSet,[FloatToStrRegion(Dosimeter.KFilter)]);
          LblProcessDataFilter.Visible:=True;
        end
        else
        begin
          LblProcessDataFilter.Caption:='';
          LblProcessDataFilter.Visible:=False;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterK(Sender: TObject);
var
  i         : integer;
  outString : String;

  procedure SetEdit(Edit: TEdit; Value: String; LblDotK, LblK: TLabel; GBPart: TGroupBox; CalibrBtn: TButton);
  const
    cAdditionHeight=75;
    cAdditionToBtnHeight=78;
  var
    topPanelHeight: integer;
  begin
//    if PanelGBPartTop.Visible then
    topPanelHeight:=PanelGBPartTop.Height;
//    else
//      topPanelHeight:=0;

    if Value=cNull then
    begin
      Edit.Visible:=false;
      LblDotK.Visible:=false;
      LblK.Visible:=false;
      Edit.Text:=Value;
    end
    else
    begin
      Edit.Visible:=true;
      LblDotK.Visible:=true;
      LblK.Visible:=true;
      Edit.Text:=Value;
      GBPart.Height:=Edit.Top+cAdditionHeight+topPanelHeight;
    end;

    CalibrBtn.Top:=GBPart.Height+GBFormulas.Top+GBFormulas.Height+CalibrBtn.Height-cAdditionToBtnHeight;
  end;
begin
  if Dosimeter<>nil then
  begin

    for i := 0 to Length(Dosimeter.Coefficients.CoefficientArray)-1 do
    begin
      //outString:=outString + Dosimeter.Coefficients.CoefficientArray[i].Name+' = '+FloatToStrRegion(RoundToCN(Dosimeter.Coefficients.CoefficientArray[i].Value,-2))+'; ';
      if i = Length(Dosimeter.Coefficients.CoefficientArray)-1 then
        outString:=outString + Dosimeter.Coefficients.CoefficientArray[i].Name+'='+FloatToStrRegion(RoundToCN(Dosimeter.Coefficients.CoefficientArray[i].Value,-2))
      else
        outString:=outString + Dosimeter.Coefficients.CoefficientArray[i].Name+'='+FloatToStrRegion(RoundToCN(Dosimeter.Coefficients.CoefficientArray[i].Value,-2))+'; ';
    end;

    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        LblMeasDataKDosVal.Caption:='';
        LblMeasDataKDosVal.Caption:=outString;
      end;
      cPageDosIndex:
      begin
        SetEdit(EditK_1, FloatToStrRegion(RoundToCN(Dosimeter.K1,-1)),LblDotK1,LblK_1,GBPart,BtnOpenCalibr);
        SetEdit(EditK_gn, FloatToStrRegion(RoundToCN(Dosimeter.Kgn,-2)),LblDotKgn,LblK_gn,GBPart,BtnOpenCalibr);
        SetEdit(EditK_2, FloatToStrRegion(RoundToCN(Dosimeter.K2,-1)),LblDotK2,LblK_2,GBPart,BtnOpenCalibr);
        SetEdit(EditK_3, FloatToStrRegion(RoundToCN(Dosimeter.K3,-1)),LblDotK3,LblK_3,GBPart,BtnOpenCalibr);
        SetEdit(EditK_4, FloatToStrRegion(RoundToCN(Dosimeter.K4,-1)),LblDotK4,LblK_4,GBPart,BtnOpenCalibr);
        SetEdit(EditK_5, FloatToStrRegion(RoundToCN(Dosimeter.K5,-1)),LblDotK5,LblK_5,GBPart,BtnOpenCalibr);
      end;
      cPageProcessIndex:
      begin
        LblProcessDataKDosVal.Caption:='';
        LblProcessDataKDosVal.Caption:=outString;
      end;
    end;

//    FinishMeasureW.LblKVal.Caption:=outString;

  end;
end;

procedure TMainForm.OnChangeDosimeterKDevice(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    Dosimeter.KDevice:=KDevice;
  end;
end;

procedure TMainForm.OnChangeDosimeterKS(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
//    FinishMeasureW.LblDosKSVal.Caption:=IntToStr(Dosimeter.KS);
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        LblMeasDataDosKSVal.Caption:=IntToStr(Dosimeter.KS);
      end;
      cPageDosIndex:
      begin

      end;
      cPageProcessIndex:
      begin
        LblProcessDataDosKSVal.Caption:=IntToStr(Dosimeter.KS);
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterMeasComment(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        //LblMeasDataCommentVal.Caption:=Dosimeter.MeasComment;
        EditMeasDataComment.Text:=Dosimeter.MeasComment;
      end;
      cPageDosIndex:
      begin

      end;
      cPageProcessIndex:
      begin
        //LblProcessDataCommentVal.Caption:=Dosimeter.MeasComment;
        EditProcessDataComment.Text:=Dosimeter.MeasComment;
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterMeasTime(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        ChangeDataLabel(LblMeasDataDosMeasTimeVal,Dosimeter.MeasTime);
      end;
      cPageDosIndex:
      begin

      end;
      cPageProcessIndex:
      begin
        ChangeDataLabel(LblProcessDataDosMeasTimeVal,Dosimeter.MeasTime);
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterMeasValues(Sender: TObject);
const
  cCBoxFormulaHeight1 = 105;
  cCBoxFormulaHeight2 = 190;
  cCBoxFormulaHeight3 = 275;
  cCBoxFormulaHeight4 = 340;
var
  i             : integer;
  procedure ClearEdit(EditMeasVal,EditFormula,EditErrK1,EditErrK2: TEdit;
                      LblDelta,LblHErr,LblPlus,LblPercent: TLabel;
                      ShapeLine: TShape);
  begin
    EditMeasVal.Clear;
    EditFormula.Clear;
    EditErrK1.Clear;
    EditErrK2.Clear;
    EditMeasVal.Visible:=false;
    EditFormula.Visible:=false;
    EditErrK1.Visible:=false;
    EditErrK2.Visible:=false;
    LblDelta.Visible:=false;
    LblPercent.Visible:=false;
    LblHErr.Visible:=false;
    LblPlus.Visible:=false;
    ShapeLine.Visible:=false;
  end;
  procedure SetEdit(EditMeasVal,EditFormula,EditErrK1,EditErrK2: TEdit;
                    MeasVal,Formula,ErrK1,ErrK2: String;
                    LblDelta,LblHErr,LblPlus,LblPercent: TLabel;
                    ShapeLine: TShape);
  begin
    EditMeasVal.Text:=MeasVal;
    LblHErr.Caption:=MeasVal;
    EditFormula.Text:=Formula;
    EditErrK1.Text:=ErrK1;
    EditErrK2.Text:=ErrK2;
    EditMeasVal.Visible:=true;
    EditFormula.Visible:=true;
    EditErrK1.Visible:=true;
    EditErrK2.Visible:=true;
    LblDelta.Visible:=true;
    LblHErr.Visible:=true;
    LblPlus.Visible:=true;
    LblPercent.Visible:=true;
    ShapeLine.Visible:=true;
  end;
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin

      end;
      cPageDosIndex:
      begin

        ClearEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,LblErr1,LblHErr_1,LblPlus_1,LblValPercent_1,ShapeErr_1);
        ClearEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,LblErr2,LblHErr_2,LblPlus_2,LblValPercent_2,ShapeErr_2);
        ClearEdit(EditDosMeasVal_3,EditFormulaVal_3,EditValErrK1_3,EditValErrK2_3,LblErr3,LblHErr_3,LblPlus_3,LblValPercent_3,ShapeErr_3);
        ClearEdit(EditDosMeasVal_4,EditFormulaVal_4,EditValErrK1_4,EditValErrK2_4,LblErr4,LblHErr_4,LblPlus_4,LblValPercent_4,ShapeErr_4);

        for i := 0 to Dosimeter.MeasValList.Count-1 do
        case i of
          0:
          begin
            SetEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                    Dosimeter.MeasValList[i],
                    cArrayFormulasTxt[Dosimeter.FormulaID_Val_1],
                    FloatToStrRegion(Dosimeter.Formula_Val_ErrK1_1),
                    FloatToStrRegion(Dosimeter.Formula_Val_ErrK2_1),
                    LblErr1,
                    LblHErr_1,
                    LblPlus_1,
                    LblValPercent_1,
                    ShapeErr_1);

            GBFormulas.Height:=cCBoxFormulaHeight1;
          end;
          1:
          begin
            SetEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,
                    Dosimeter.MeasValList[i],
                    cArrayFormulasTxt[Dosimeter.FormulaID_Val_2],
                    FloatToStrRegion(Dosimeter.Formula_Val_ErrK1_2),
                    FloatToStrRegion(Dosimeter.Formula_Val_ErrK2_2),
                    LblErr2,
                    LblHErr_2,
                    LblPlus_2,
                    LblValPercent_2,
                    ShapeErr_2);

            GBFormulas.Height:=cCBoxFormulaHeight2;
          end;
          2:
          begin
            SetEdit(EditDosMeasVal_3,EditFormulaVal_3,EditValErrK1_3,EditValErrK2_3,
                    Dosimeter.MeasValList[i],
                    cArrayFormulasTxt[Dosimeter.FormulaID_Val_3],
                    FloatToStrRegion(Dosimeter.Formula_Val_ErrK1_3),
                    FloatToStrRegion(Dosimeter.Formula_Val_ErrK2_3),
                    LblErr3,
                    LblHErr_3,
                    LblPlus_3,
                    LblValPercent_3,
                    ShapeErr_3);

            GBFormulas.Height:=cCBoxFormulaHeight3;
          end;
          3:
          begin
            SetEdit(EditDosMeasVal_4,EditFormulaVal_4,EditValErrK1_4,EditValErrK2_4,
                    Dosimeter.MeasValList[i],
                    cArrayFormulasTxt[Dosimeter.FormulaID_Val_4],
                    FloatToStrRegion(Dosimeter.Formula_Val_ErrK1_4),
                    FloatToStrRegion(Dosimeter.Formula_Val_ErrK2_4),
                    LblErr4,
                    LblHErr_4,
                    LblPlus_4,
                    LblValPercent_4,
                    ShapeErr_4);

            GBFormulas.Height:=cCBoxFormulaHeight4;
          end;
        end;

        GBPart.Top:=GBFormulas.Top+GBFormulas.Height+6;

      end;
      cPageProcessIndex:
      begin

      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterNumber(Sender: TObject);
begin
//  if Dosimeter<>nil then
//  begin
//    case PageControlMain.ActivePageIndex of
//      cPageDosIndex:
//      begin
//        EditDosDataDosNumber.Text:=IntToStr(Dosimeter.ID);
//      end;
//    end;
//  end;
end;

procedure TMainForm.OnChangeDosimeterPostfix(Sender: TObject);
begin
//  if Dosimeter<>nil then
//  begin
//    case PageControlMain.ActivePageIndex of
//      cPageDosIndex:
//      begin
//        EditDosDataDosPostfix.Text:=Dosimeter.Postfix;
//      end;
//    end;
//  end;
end;

procedure TMainForm.OnChangeDosimeterFullNumber(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        LblMeasDataDosNumberVal.Caption:=Dosimeter.FullNumber;
      end;
      cPageDosIndex:
      begin
//*        TabSheetDosParamMain.Caption:=Format(' %s № %s ',['Дозиметр',Dosimeter.FullNumber]);
        TabSheetDosNumber.Caption:=Format(' %s № %s ',[rsDosimeter,Dosimeter.FullNumber]);
      end;
      cPageProcessIndex:
      begin
        LblProcessDataDosNumberVal.Caption:=Dosimeter.FullNumber;
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterOrganization(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        ChangeStringEdit(EditMeasDataDosOrg,Dosimeter.Organization,clWhite);
      end;
      cPageDosIndex:
      begin
        ChangeStringEdit(EditDosDataDosOrgVal,Dosimeter.Organization,clWindow);
      end;
      cPageProcessIndex:
      begin
        ChangeStringEdit(EditProcessDataDosOrg,Dosimeter.Organization,clWhite);
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterPart(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
//        FinishMeasureW.EditDosPart.Text:=IntToStr(Dosimeter.PartID);
      end;
      cPageDosIndex:
      begin

        if Dosimeter.PartID>0 then
//          EditDosPart.Text:=TLDDataModule.GetPartName(Dosimeter.PartID);
        begin
//          PanelGBPartTop.Visible:=true;
          BtnExcludeFromPart.Enabled:=true;
          EditDosPart.Text:=TLDDataModule.GetPartName(Dosimeter.PartID);
        end
        else
        begin
//          PanelGBPartTop.Visible:=false;
          EditDosPart.Text:='-';
          BtnExcludeFromPart.Enabled:=false;
        end;

      end;
      cPageProcessIndex:
      begin

      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterPersNumber(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        if Dosimeter.PersNumber = -1 then
        begin
          ChangeStringEdit(EditMeasDataDosPersNumber,'',clWhite);
          ChangeStringEdit(EditMeasDataDosIDK,rsNotBind,clBtnFace);
        end
        else
        begin
          ChangeStringEdit(EditMeasDataDosPersNumber,IntToStr(Dosimeter.PersNumber),clWhite);
          ChangeStringEdit(EditMeasDataDosIDK,rsBind,clBtnFace);
        end;
      end;
      cPageDosIndex:
      begin
        if Dosimeter.PersNumber = -1 then
        begin
          EditDosDataDosPersNumberVal.Text:=cEmptyData;
          EditDosDataDosIDKVal.Text:=rsNotBind;
        end
        else
        begin
          EditDosDataDosPersNumberVal.Text:=IntToStr(Dosimeter.PersNumber);
          EditDosDataDosIDKVal.Text:=rsBind;
        end;
      end;
      cPageProcessIndex:
      begin
        if Dosimeter.PersNumber = -1 then
        begin
          ChangeStringEdit(EditProcessDataDosPersNumber,'',clWhite);
          ChangeStringEdit(EditProcessDataDosIDK,rsNotBind,clBtnFace);
        end
        else
        begin
          ChangeStringEdit(EditProcessDataDosPersNumber,IntToStr(Dosimeter.PersNumber),clWhite);
          ChangeStringEdit(EditProcessDataDosIDK,rsBind,clBtnFace);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterVerTime(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        ChangeDataLabel(LblMeasDataDosVerVal,Dosimeter.VerTime);
      end;
      cPageDosIndex:
      begin
        ChangeDataLabel(LblDosDataDosVerVal,Dosimeter.VerTime);
      end;
      cPageProcessIndex:
      begin
        ChangeDataLabel(LblProcessDataDosVerVal,Dosimeter.VerTime);
      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterRegTime(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin

      end;
      cPageDosIndex:
      begin
        ChangeDataLabel(LblDosDataDosVal,Dosimeter.RegTime);
      end;
      cPageProcessIndex:
      begin

      end;
    end;
  end;
end;

procedure TMainForm.OnClickDosEdit(Sender: TObject);
begin
  SetDosEditForm.Dosimeter:=Dosimeter;
  SetDosEditForm.OwnerButton:=Sender;
  SetDosEditForm.ShowModal;
end;

procedure TMainForm.OnChangeDosimeterStatus(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin

      end;
      cPageDosIndex:
      begin
        CBDosDataDosStatus.Items.Clear;
        CBDosDataDosStatus.Items.Add(rsDosCalibrated);
        CBDosDataDosStatus.Items.Add(rsDosNotCalibrated);
        CBDosDataDosStatus.Items.Add(rsDosDecommissioned);
        CBDosDataDosStatus.ItemIndex:=CBDosDataDosStatus.Items.IndexOf(Dosimeter.GetStringStatus);

        if Dosimeter.Status=stDosDecommissioned then
          BtnDecommissionDos.Visible:=false
        else
          BtnDecommissionDos.Visible:=true;

      end;
      cPageProcessIndex:
      begin

      end;
    end;
  end;
end;

procedure TMainForm.OnChangeDosimeterValidity(Sender: TObject);
begin
  if Dosimeter<>nil then
  begin
    case PageControlMain.ActivePageIndex of
      cPageMeasIndex:
      begin
        ChangeDosValidityEdit(EditMeasDataDosStatus,Dosimeter.Validity);
      end;
      cPageDosIndex:
      begin

      end;
      cPageProcessIndex:
      begin
        ChangeDosValidityEdit(EditProcessDataDosStatus,Dosimeter.Validity);
      end;
    end;

  end;
end;

procedure TMainForm.OnShowDetData(Sender: TObject);
begin

  CheckVisibleKTV;

  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          ShowDetectorData(SeriesMeasD1Temp,TDetector(Sender).Tmp,TDetector(Sender).K1Profile,TDetector(Sender).K2Profile);
          ShowDetectorData(SeriesMeasD1TempWrite,TDetector(Sender).TmpWrite);
          ShowDetectorData(SeriesMeasD1KTV,TDetector(Sender).Ktv);
          ShowDetectorData(SeriesMeasD1Fon,TDetector(Sender).Fon);
          ShowDetectorData(SeriesMeasD1Gaus,TDetector(Sender).Gaus);
//          ShowDetectorData(ChartToolBorderMeasD1,TDetector(Sender).N1,TDetector(Sender).N2,TDetector(Sender).PeakFound);
          ShowDetectorDataGlade(SeriesMeasD1KTV,SeriesMeasD1Glade);
          DSeriaAutoSize(TLDChartMeasDataD1,SeriesMeasD1KTV);
          if GaugeMeasDataD1.Visible then GaugeMeasDataD1.Visible:=false;
          if not EditMeasDataD1Status.Visible then EditMeasDataD1Status.Visible:=true;
        end;
      cDetPos2:
        begin
          //*ShowDetectorData(SeriesMeasD2Temp,TDetector(Sender).Tmp);
          ShowDetectorData(SeriesMeasD2Temp,TDetector(Sender).Tmp,TDetector(Sender).K1Profile,TDetector(Sender).K2Profile);
          ShowDetectorData(SeriesMeasD2TempWrite,TDetector(Sender).TmpWrite);
          ShowDetectorData(SeriesMeasD2KTV,TDetector(Sender).Ktv);
          ShowDetectorData(SeriesMeasD2Fon,TDetector(Sender).Fon);
          ShowDetectorData(SeriesMeasD2Gaus,TDetector(Sender).Gaus);
//          ShowDetectorData(ChartToolBorderMeasD2,TDetector(Sender).N1,TDetector(Sender).N2,TDetector(Sender).PeakFound);
          ShowDetectorDataGlade(SeriesMeasD2KTV,SeriesMeasD2Glade);
          DSeriaAutoSize(TLDChartMeasDataD2,SeriesMeasD2KTV);
          if GaugeMeasDataD2.Visible then GaugeMeasDataD2.Visible:=false;
          if not EditMeasDataD2Status.Visible then EditMeasDataD2Status.Visible:=true;
        end;
      cDetPos3:
        begin
          //*ShowDetectorData(SeriesMeasD3Temp,TDetector(Sender).Tmp);
          ShowDetectorData(SeriesMeasD3Temp,TDetector(Sender).Tmp,TDetector(Sender).K1Profile,TDetector(Sender).K2Profile);
          ShowDetectorData(SeriesMeasD3TempWrite,TDetector(Sender).TmpWrite);
          ShowDetectorData(SeriesMeasD3KTV,TDetector(Sender).Ktv);
          ShowDetectorData(SeriesMeasD3Fon,TDetector(Sender).Fon);
          ShowDetectorData(SeriesMeasD3Gaus,TDetector(Sender).Gaus);
//          ShowDetectorData(ChartToolBorderMeasD3,TDetector(Sender).N1,TDetector(Sender).N2,TDetector(Sender).PeakFound);
          ShowDetectorDataGlade(SeriesMeasD3KTV,SeriesMeasD3Glade);
          DSeriaAutoSize(TLDChartMeasDataD3,SeriesMeasD3KTV);
          if GaugeMeasDataD3.Visible then GaugeMeasDataD3.Visible:=false;
          if not EditMeasDataD3Status.Visible then EditMeasDataD3Status.Visible:=true;
        end;
      cDetPos4:
        begin
          //*ShowDetectorData(SeriesMeasD4Temp,TDetector(Sender).Tmp);
          ShowDetectorData(SeriesMeasD4Temp,TDetector(Sender).Tmp,TDetector(Sender).K1Profile,TDetector(Sender).K2Profile);
          ShowDetectorData(SeriesMeasD4TempWrite,TDetector(Sender).TmpWrite);
          ShowDetectorData(SeriesMeasD4KTV,TDetector(Sender).Ktv);
          ShowDetectorData(SeriesMeasD4Fon,TDetector(Sender).Fon);
          ShowDetectorData(SeriesMeasD4Gaus,TDetector(Sender).Gaus);
//          ShowDetectorData(ChartToolBorderMeasD4,TDetector(Sender).N1,TDetector(Sender).N2,TDetector(Sender).PeakFound);
          ShowDetectorDataGlade(SeriesMeasD4KTV,SeriesMeasD4Glade);
          DSeriaAutoSize(TLDChartMeasDataD4,SeriesMeasD4KTV);
          if GaugeMeasDataD4.Visible then GaugeMeasDataD4.Visible:=false;
          if not EditMeasDataD4Status.Visible then EditMeasDataD4Status.Visible:=true;
        end;
      end;
    end;
    cPageProcessIndex:
    begin
      case TDetector(Sender).Position of
      cDetPos1:
        begin
          ShowDetectorData(SeriesProcessD1Temp,TDetector(Sender).Tmp);
          ShowDetectorData(SeriesProcessD1TempWrite,TDetector(Sender).TmpWrite);
          ShowDetectorData(SeriesProcessD1KTV,TDetector(Sender).Ktv);
          ShowDetectorData(SeriesProcessD1Fon,TDetector(Sender).Fon);
          ShowDetectorData(SeriesProcessD1Gaus,TDetector(Sender).Gaus);
//          ShowDetectorData(ChartToolBorderProcessD1,TDetector(Sender).N1,TDetector(Sender).N2,TDetector(Sender).PeakFound);
          ShowDetectorDataGlade(SeriesProcessD1KTV,SeriesProcessD1Glade);
          DSeriaAutoSize(TLDChartProcessDataD1,SeriesProcessD1KTV);
          if GaugeProcessDataD1.Visible then GaugeProcessDataD1.Visible:=false;
        end;
      cDetPos2:
        begin
          ShowDetectorData(SeriesProcessD2Temp,TDetector(Sender).Tmp);
          ShowDetectorData(SeriesProcessD2TempWrite,TDetector(Sender).TmpWrite);
          ShowDetectorData(SeriesProcessD2KTV,TDetector(Sender).Ktv);
          ShowDetectorData(SeriesProcessD2Fon,TDetector(Sender).Fon);
          ShowDetectorData(SeriesProcessD2Gaus,TDetector(Sender).Gaus);
//          ShowDetectorData(ChartToolBorderProcessD2,TDetector(Sender).N1,TDetector(Sender).N2,TDetector(Sender).PeakFound);
          ShowDetectorDataGlade(SeriesProcessD2KTV,SeriesProcessD2Glade);
          DSeriaAutoSize(TLDChartProcessDataD2,SeriesProcessD2KTV);
          if GaugeProcessDataD2.Visible then GaugeProcessDataD2.Visible:=false;
        end;
      cDetPos3:
        begin
          ShowDetectorData(SeriesProcessD3Temp,TDetector(Sender).Tmp);
          ShowDetectorData(SeriesProcessD3TempWrite,TDetector(Sender).TmpWrite);
          ShowDetectorData(SeriesProcessD3KTV,TDetector(Sender).Ktv);
          ShowDetectorData(SeriesProcessD3Fon,TDetector(Sender).Fon);
          ShowDetectorData(SeriesProcessD3Gaus,TDetector(Sender).Gaus);
//          ShowDetectorData(ChartToolBorderProcessD3,TDetector(Sender).N1,TDetector(Sender).N2,TDetector(Sender).PeakFound);
          ShowDetectorDataGlade(SeriesProcessD3KTV,SeriesProcessD3Glade);
          DSeriaAutoSize(TLDChartProcessDataD3,SeriesProcessD3KTV);
          if GaugeProcessDataD3.Visible then GaugeProcessDataD3.Visible:=false;
        end;
      cDetPos4:
        begin
          ShowDetectorData(SeriesProcessD4Temp,TDetector(Sender).Tmp);
          ShowDetectorData(SeriesProcessD4TempWrite,TDetector(Sender).TmpWrite);
          ShowDetectorData(SeriesProcessD4KTV,TDetector(Sender).Ktv);
          ShowDetectorData(SeriesProcessD4Fon,TDetector(Sender).Fon);
          ShowDetectorData(SeriesProcessD4Gaus,TDetector(Sender).Gaus);
//          ShowDetectorData(ChartToolBorderProcessD4,TDetector(Sender).N1,TDetector(Sender).N2,TDetector(Sender).PeakFound);
          ShowDetectorDataGlade(SeriesProcessD4KTV,SeriesProcessD4Glade);
          DSeriaAutoSize(TLDChartProcessDataD4,SeriesProcessD4KTV);
          if GaugeProcessDataD4.Visible then GaugeProcessDataD4.Visible:=false;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.OnShowDosEdit(Sender: TObject);
begin
  SetDosEditForm.OwnerButton:=Sender;
  SetDosEditForm.ShowModal;
end;

procedure TMainForm.OnShowDosimeterTempProfileWrite(Sender: TObject);
var
  i       : integer;
  profile : TTempProfile;
begin
  if Dosimeter <> nil then
  begin

    FillChar(profile, SizeOf(profile), #0);


    if Dosimeter.DetectorsList[0]<>nil then
      if TDetector(Dosimeter.DetectorsList[0]).K1Profile>0 then
        for i := 2 to Length(TDetector(Dosimeter.DetectorsList[0]).TempProfile)-1 do
          SeriesMeasD1TempWrite.AddXY(i-2,(TDetector(Dosimeter.DetectorsList[0]).TempProfile[i]{/TDetector(Dosimeter.DetectorsList[0]).K1Profile+TDetector(Dosimeter.DetectorsList[0]).K2Profile*cTempProfileMult})/10)
      else
        for i := 2 to Length(TDetector(Dosimeter.DetectorsList[0]).TempProfile)-1 do
          SeriesMeasD1TempWrite.AddXY(i-2,(TDetector(Dosimeter.DetectorsList[0]).TempProfile[i])/10);

    if Dosimeter.DetectorsList[1]<>nil then
      if TDetector(Dosimeter.DetectorsList[1]).K1Profile>0 then
        for i := 2 to Length(TDetector(Dosimeter.DetectorsList[1]).TempProfile)-1 do
          SeriesMeasD2TempWrite.AddXY(i-2,(TDetector(Dosimeter.DetectorsList[1]).TempProfile[i]{/TDetector(Dosimeter.DetectorsList[1]).K1Profile+TDetector(Dosimeter.DetectorsList[1]).K2Profile*cTempProfileMult})/10)
      else
        for i := 2 to Length(TDetector(Dosimeter.DetectorsList[1]).TempProfile)-1 do
          SeriesMeasD2TempWrite.AddXY(i-2,(TDetector(Dosimeter.DetectorsList[1]).TempProfile[i])/10);

    if Dosimeter.DetectorsList[2]<>nil then
      if TDetector(Dosimeter.DetectorsList[2]).K1Profile>0 then
        for i := 2 to Length(TDetector(Dosimeter.DetectorsList[2]).TempProfile)-1 do
          SeriesMeasD3TempWrite.AddXY(i-2,(TDetector(Dosimeter.DetectorsList[2]).TempProfile[i]{/TDetector(Dosimeter.DetectorsList[2]).K1Profile+TDetector(Dosimeter.DetectorsList[2]).K2Profile*cTempProfileMult})/10)
      else
        for i := 2 to Length(TDetector(Dosimeter.DetectorsList[2]).TempProfile)-1 do
          SeriesMeasD3TempWrite.AddXY(i-2,(TDetector(Dosimeter.DetectorsList[2]).TempProfile[i])/10);

    if Dosimeter.DetectorsList[3]<>nil then
      if TDetector(Dosimeter.DetectorsList[3]).K1Profile>0 then
        for i := 2 to Length(TDetector(Dosimeter.DetectorsList[3]).TempProfile)-1 do
          SeriesMeasD4TempWrite.AddXY(i-2,(TDetector(Dosimeter.DetectorsList[3]).TempProfile[i]{/TDetector(Dosimeter.DetectorsList[3]).K1Profile+TDetector(Dosimeter.DetectorsList[3]).K2Profile*cTempProfileMult})/10)
      else
        for i := 2 to Length(TDetector(Dosimeter.DetectorsList[3]).TempProfile)-1 do
          SeriesMeasD4TempWrite.AddXY(i-2,(TDetector(Dosimeter.DetectorsList[3]).TempProfile[i])/10)
  end;
end;

procedure TMainForm.OnMeasureScanDosimeter;
var
  i,SumDet: integer;
  SDosimeterType       : ansistring;                        // последний считанный штрихкод с номером дозиметра
begin
  TLDCommand.ChangeData.DosimeterFound := dsfNotFound; // Передача весточки в машину состояний

  if not StartMeasureW.Showing then StartMeasureW.Show;
//  if not StartMeasureW.Showing then StartMeasureW.ShowModal(0);
  if not Start then Start:=True;

  StartMeasureW.CBoxDosList.Text := '';
  StartMeasureW.CBoxDosList.Text := TLDCommand.BarCodeString;
  //StartMeasureW.CBoxDosListChange(Nil);

  //StartMeasureW.EditOrg.Text := TLDCommand.BarCodeString;
  MainForm.TLDCommand.ChangeData.DosimeterFound := dsfNotFound; // Передача весточки в машину состояний
  if TLDDataModule.IsDosimeterExist(TLDCommand.BarCodeString) then
  begin
    if Assigned(MainForm.Dosimeter) then FreeAndNil(MainForm.Dosimeter);

    MainForm.Dosimeter:=TDosimeter.Create(TLDCommand.BarCodeString);
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
    MainForm.Dosimeter.Organization:=StartMeasureW.EditOrg.Text;
    MainForm.Dosimeter.Department:=StartMeasureW.EditDep.Text;
    MainForm.Dosimeter.Fio:=StartMeasureW.EditPageIDKFIO.Text;
    MainForm.Dosimeter.PersNumber:=StrToIntRegion(StartMeasureW.EditPageIDKPersNumber.Text);

    MainForm.Dosimeter.OnChangeOrganization(Self);
    MainForm.Dosimeter.OnChangeDepartment(Self);
    MainForm.Dosimeter.OnChangePersNumber(Self);
    MainForm.Dosimeter.OnChangeFio(Self);
    MainForm.Dosimeter.OnChangeMeasComment(Self);
    MainForm.Dosimeter.OnShowTempProfileWrite(Self);

    //StartMeasureW.HideDetectors(MainForm.GetDetCnt(MainForm.Dosimeter.DosType));

    StartMeasureW.EditPageIDKPersNumber.Clear;
    StartMeasureW.EditPageIDKFIO.Clear;

    StartMeasureW.LblEnterDosNumber.Caption:=rsGiveDosimeterNumber;

    StartMeasureW.LoadDosimeterPicture(StrToInt(MainForm.Dosimeter.DosTypeID),cPictureDosNumber);

    if StartMeasureW.CBoxDosType.Enabled then StartMeasureW.CBoxDosType.Enabled:=false;

    if StartMeasureW.EditOrg.GetTextLen=0 then
      StartMeasureW.EditOrg.Text:=MainForm.Dosimeter.Organization;

    if StartMeasureW.EditDep.GetTextLen=0 then
      StartMeasureW.EditDep.Text:=MainForm.Dosimeter.Department;

    StartMeasureW.LblEnterDosNumber.Visible:=false;
    StartMeasureW.LblErr.Visible:=false;
    //BtnNext.Enabled:=true;

    //if Showing then
    //  if MainForm.HidePanels then
    //    MainForm.HidePanels:=false;

    MainForm.TLDCommand.ChangeData.DosimeterFound := dsfFound; // Передача весточки в машину состояний
    SumDet:=0;
    for i:=0 to MainForm.Dosimeter.DetectorsList.Count-1 do
      if MainForm.Dosimeter.DetectorsList.Items[i]<>Nil then
      begin
        SumDet:=SumDet+1;
      end;
    MainForm.TLDCommand.ChangeData.DetectorCount := SumDet;
    MainForm.TLDCommand.Panel.Output.DetectorsCount := SumDet;

    for i:=1 to 18 do
      MainForm.TLDCommand.Panel.Output.DosimeterType[i] := 0;
    SDosimeterType := Utf8ToAnsi(StartMeasureW.CBoxDosType.Text);
    for i:=1 to min(18,length(SDosimeterType)) do
      MainForm.TLDCommand.Panel.Output.DosimeterType[i] := ord(SDosimeterType[i]);


    if MainForm.Dosimeter.DetectorsList[1]<>Nil
      then MainForm.GetTempProfileToUI(carDet23, TDetector(MainForm.Dosimeter.DetectorsList[1]).DetTypeComment) // для позиции 23
      else
        if MainForm.Dosimeter.DetectorsList[2]<>Nil
          then MainForm.GetTempProfileToUI(carDet23, TDetector(MainForm.Dosimeter.DetectorsList[2]).DetTypeComment); // для позиции 23 // запасной

    if MainForm.Dosimeter.DetectorsList[0]<>Nil
      then MainForm.GetTempProfileToUI(carDet14, TDetector(MainForm.Dosimeter.DetectorsList[0]).DetTypeComment) // для позиции 14
      else
        if MainForm.Dosimeter.DetectorsList[3]<>Nil
          then MainForm.GetTempProfileToUI(carDet14, TDetector(MainForm.Dosimeter.DetectorsList[3]).DetTypeComment); // для позиции 14 // запасной


    //MainForm.TLDCommand.ChangeData.TimeToSet := TDetector(MainForm.Dosimeter.DetectorsList[1]).MeasureTime.; // for first detectors (2,3)

    //TDetector(MainForm.Dosimeter.DetectorsList[0]).MeasureTime;
  end;

  //for i:=0 to Dosimeter.DetectorsList.Count-1 do
  //if Dosimeter.DetectorsList[i]<>nil then
  //  TDetector(Dosimeter.DetectorsList[i]).State := stDetWaitMeas;
end;

procedure TMainForm.OnGetPanelCommand(aCmd: word);
var
  AProcess: TProcess;
  St: string;
begin
  St:='UNKNOWN';
  if aCmd=1 then
  begin
    St:='START';
    SpeedBtnStartClick(SpeedBtnStart);  // Start
  end;
  if aCmd=2 then
  begin
    St:='STOP';
    SpeedBtnStopClick(SpeedBtnStop);   // Stop
  end;
  if aCmd=3 then                           // Pause
  begin
    St:='PAUSE';
    SpeedBtnPause.Down:=True;
    SpeedBtnPauseClick(SpeedBtnPause);
  end;
  if aCmd=4 then                           // ShutDown
  try
    St:='SHUTDOWN';
    AProcess := TProcess.Create(nil);
  {$IFDEF MSWINDOWS}
    AProcess.Options := [poWaitOnExit];
    AProcess.CommandLine := 'C:\Windows\System32\shutdown.exe -s -t 0';
  {$ELSE}
    AProcess.Executable := '/bin/sh';
    AProcess.Parameters.Add('-c');
    //AProcess.Parameters.Add('echo password | sudo -S /sbin/shutdown -h now');
    AProcess.Parameters.Add('sudo /sbin/shutdown -h now');
  {$ENDIF}
    AProcess.Execute;
    AProcess.Free;
  except
  end;
  OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',format(rsUserPanelCommand,[St]),'',cMsgRead,cMsgPriorityInf);
  TLDCommand.Panel.Output.Command := aCmd;
end;

function TMainForm.OnUIAnswer(aCaption,aMessage: string; aDialogType: TDialogType; anAccidentNumber: integer): integer;
begin
  case aDialogType of
    dNone: result := 0;
    dInfo: result := TimerMessageDlg(aCaption,aMessage,mtError,[mbAbort,mbRetry],UI_Delay[dInfo]);
    dFail: result := TimerMessageDlg(aCaption,aMessage,mtError,[mbAbort,mbRetry,mbCancel,mbOk,mbIgnore],UI_Delay[dFail]);
    dReserv: result := TimerMessageDlg(aCaption,aMessage,mtError,[mbAbort,mbRetry,mbCancel,mbIgnore],UI_Delay[dReserv]);
  end;
end;

procedure TMainForm.OnPanelDisconnect(aDisconnectType: word);
begin
  TimerMessageDlg('Disconnection','Panel Disconnected - Error code'+IntToStr(aDisconnectType),mtError,[mbOk],15);
  //MessageDlg('Panel Disconnected - Error code'+IntToStr(aDisconnectType),mtError,[mbAbort],0);
end;

var
  savedMsg: String;
procedure TMainForm.OnCommandLog(Time, Msg, Inf: String; MsgType, MsgPriority: integer);
  procedure LocalUpdateMeasComment(Comment: String);
  begin
    if Assigned(Dosimeter) then
    begin
      Dosimeter.MeasComment:=Comment;
      SaveMeasComment;
    end;
  end;
begin
  //Exit;

  WriteCommandLog(Time + Msg);
  if Msg<>savedMsg then WriteLog(Msg);
  case MsgType of
    cMsgEngine:
    begin
      case MsgPriority of
        cMsgPriorityInf:
        begin

        end;
        cMsgPriorityWarning:
        begin

        end;
        cMsgPriorityError:
        begin
          if Start then Start:=false;

          if Assigned(Dosimeter) AND TLDDataModule.IsMeasIDExist(Dosimeter.MeasurementID) then
          begin
            SaveDetTXTResults(Format('%s_%s_%s_%s%d',[DateTimeToStr_Format(Now),'Dosimeter',Dosimeter.FullNumber,'Detector',Dosimeter.DetectorsCnt+1]));  // сохранение результатов измерений детектора в текстовом файле
            Dosimeter.CntDetector.State:=stDetMeasStopped;
            InsertDetectorKtvTmp(Dosimeter.DetectorsCnt+1);     // запись в БД значений считанных КТВ и температурного профиля
            OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsSrcData,rsD,Dosimeter.DetectorsCnt+1,rsSaveToDB]),'', cMsgInf,cMsgPriorityInf);
              // Рекурсия!!!?

            LocalUpdateMeasComment(Msg);
          end;

          SpeedBtnStopClick(Self);

          UpdateGridMeasAndProcessPages;

          WarningErrorW.ChangeLbl(Format('%s',[rsMotorFailure]),Format('%s:',[Msg]),Inf);
          WarningErrorW.Show;
        end;
      end;
    end;
    cMsgStove:
    begin
      case MsgPriority of
        cMsgPriorityInf:
        begin

        end;
        cMsgPriorityWarning:
        begin

        end;
        cMsgPriorityError:
        begin
          if Start then Start:=false;

          if Assigned(Dosimeter) AND TLDDataModule.IsMeasIDExist(Dosimeter.MeasurementID) then
          begin
            SaveDetTXTResults(Format('%s_%s_%s_%s%d',[DateTimeToStr_Format(Now),'Dosimeter',Dosimeter.FullNumber,'Detector',Dosimeter.DetectorsCnt+1]));  // сохранение результатов измерений детектора в текстовом файле
            Dosimeter.CntDetector.State:=stDetMeasStopped;
            InsertDetectorKtvTmp(Dosimeter.DetectorsCnt+1);     // запись в БД значений считанных КТВ и температурного профиля
            OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsSrcData,rsD,Dosimeter.DetectorsCnt+1,rsSaveToDB]),'', cMsgInf,cMsgPriorityInf);

            LocalUpdateMeasComment(Msg);
          end;

          SpeedBtnStopClick(Self);

          UpdateGridMeasAndProcessPages;

          WarningErrorW.ChangeLbl(Format('%s',[rsHeaterFailure]),Format('%s:',[Msg]),Inf);
          WarningErrorW.Show;
        end;
      end;
//      MessageDlg('Состояние печки: '+Msg+'!',mtError, [mbOK], 0);
//      SpeedBtnStopClick(Self);
    end;
    cMsgConnect:
    begin
// здесь можно организовать дополнительную обработку или индикацию потери связи с прибором
// в данном варианте программа сама пытается восстановить связь, сообщая об этом в лог обмена
//      MessageDlg('Состояние связи с прибором: '+Msg+'!',mtError, [mbOK], 0);
//      if TimerMeasure.Enabled then
//      begin
//        TimerMeasure.Enabled:=False;
//      end;
      case MsgPriority of
        cMsgPriorityInf:
        begin

        end;
        cMsgPriorityWarning:
        begin

        end;
        cMsgPriorityError:
        begin
          if Start then Start:=false;

          FWorkingTime:=0;

          if Assigned(Dosimeter) AND TLDDataModule.IsMeasIDExist(Dosimeter.MeasurementID) then
          begin
            SaveDetTXTResults(Format('%s_%s_%s_%s%d',[DateTimeToStr_Format(Now),'Dosimeter',Dosimeter.FullNumber,'Detector',Dosimeter.DetectorsCnt+1]));  // сохранение результатов измерений детектора в текстовом файле
            Dosimeter.CntDetector.State:=stDetMeasStopped;
            InsertDetectorKtvTmp(Dosimeter.DetectorsCnt+1);     // запись в БД значений считанных КТВ и температурного профиля
            OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsSrcData,rsD,Dosimeter.DetectorsCnt+1,rsSaveToDB]),'', cMsgInf,cMsgPriorityInf);

            LocalUpdateMeasComment(Msg);
          end;

          SpeedBtnStopClick(Self);

          UpdateGridMeasAndProcessPages;

          WarningErrorW.ChangeLbl(Format('%s',[rsConnectionFailure]),Format('%s:',[Msg]),Inf);
          WarningErrorW.Show;
        end;
      end;
    end;
    cMsgCommand:
    begin

    end;
    cMsgInf:
    begin

    end;
    cMsgBigDose:
    begin
      case MsgPriority of
        cMsgPriorityInf:
        begin

        end;
        cMsgPriorityWarning:
        begin

        end;
        cMsgPriorityError:
        begin
          if Start then Start:=false;

          FWorkingTime:=0;

          if Assigned(Dosimeter) AND TLDDataModule.IsMeasIDExist(Dosimeter.MeasurementID) then
          begin
            SaveDetTXTResults(Format('%s_%s_%s_%s%d',[DateTimeToStr_Format(Now),'Dosimeter',Dosimeter.FullNumber,'Detector',Dosimeter.DetectorsCnt+1]));  // сохранение результатов измерений детектора в текстовом файле
            Dosimeter.CntDetector.State:=stDetMeasStopped;
            InsertDetectorKtvTmp(Dosimeter.DetectorsCnt+1);     // запись в БД значений считанных КТВ и температурного профиля
            OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsSrcData,rsD,Dosimeter.DetectorsCnt+1,rsSaveToDB]),'', cMsgInf,cMsgPriorityInf);

            LocalUpdateMeasComment(Msg);
          end;

          SpeedBtnStopClick(Self);

          UpdateGridMeasAndProcessPages;

          WarningErrorW.ChangeLbl(Format('%s',[rsBigDose]),Format('%s:',[Msg]),Inf);
          WarningErrorW.Show;
        end;
      end;
    end;
    cMsgCRC:
    begin
      if Start then Start:=false;

      if Assigned(Dosimeter) AND TLDDataModule.IsMeasIDExist(Dosimeter.MeasurementID) then
      begin
        SaveDetTXTResults(Format('%s_%s_%s_%s%d',[DateTimeToStr_Format(Now),'Dosimeter',Dosimeter.FullNumber,'Detector',Dosimeter.DetectorsCnt+1]));  // сохранение результатов измерений детектора в текстовом файле
        Dosimeter.CntDetector.State:=stDetMeasStopped;
        InsertDetectorKtvTmp(Dosimeter.DetectorsCnt+1);     // запись в БД значений считанных КТВ и температурного профиля
        OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %s%d %s',[rsSrcData,rsD,Dosimeter.DetectorsCnt+1,rsSaveToDB]),'', cMsgInf,cMsgPriorityInf);

        LocalUpdateMeasComment(Msg);
      end;

      SpeedBtnStopClick(Self);

      UpdateGridMeasAndProcessPages;

      WarningErrorW.ChangeLbl(Format('%s',[rsCRCError]),Format('%s:',[Msg]),Inf);
      WarningErrorW.Show;
    end;
    cMsgNone:
    begin
      // не обрабатываемые сообщения
    end;

  end;

  savedMsg:=Msg;
end;

procedure TMainForm.OnDBConnection(Connection: boolean);
begin
{
  if not Assigned(MainForm) then Exit;
  if not Assigned(PanelMeasLeftGrid) then Exit;

  if Connection then
    PanelMeasLeftGrid.Caption:=''
  else
    PanelMeasLeftGrid.Caption:=rsDBNoConnection;
}
end;

procedure TMainForm.OnReceiveKS(Value: integer);
begin
  //ControlW.EditKSI.Text:=IntToStr(Value);
  if StartMeasureW.Showing then
  begin
    StartMeasureW.EditKSI.Text:=Format('%d',[Value]);     // вывод значения КСИ в окно загрузки детекторов

//    if IsValueInRange(Value,FKSLevel,FKSDelta) then         // сравнивем значения КСИ с пороговым значением
//      StartMeasureW.BtnNext.Click                           // если значение КСИ в пределах нормы, то сразу же переводим позицию стола нп загрузку Д1
//    else
//      StartMeasureW.LblCurrentStep.Caption:=Format('%s = %d. %s?',[rsSmKSILbl,Value,rsSmContinueMeasuring]);

    case GetKSValueRange(Value,FKSLevel,FKSDelta,KFilter) of
      cKSNormal:
        if UseKFilter then
        begin
          //StartMeasureW.LblCurrentStep.Caption:=Format('%s = %d. %s?',[rsSmKSILbl,Value,rsSmContinueMeasuring]);
          StartMeasureW.LoadFilterPicture(2);
        end;
        //else
          //StartMeasureW.BtnNext.Click;

      cKSNotInRange:
        if UseKFilter then
        begin
          //StartMeasureW.LblCurrentStep.Caption:=Format('%s = %d. %s?',[rsSmKSILbl,Value,rsSmContinueMeasuring]);
          StartMeasureW.LoadFilterPicture(2);
        end;
        //else
          //StartMeasureW.LblCurrentStep.Caption:=Format('%s = %d. %s?',[rsSmKSILbl,Value,rsSmContinueMeasuring]);

      cKSFilterInstalled:
        if UseKFilter then
          //StartMeasureW.BtnNext.Click
        else
        begin
          //StartMeasureW.LblCurrentStep.Caption:=Format('%s = %d. %s?',[rsSmKSILbl,Value,rsSmContinueMeasuring]);
          StartMeasureW.LoadFilterPicture(1);
        end;
    end;

  end;

  if Assigned(Dosimeter) then Dosimeter.KS:=Value;
end;

procedure TMainForm.OnReceiveTempProfile;
var
  i: integer;
begin
  //if ControlW.Showing then
  //begin
  //  if Length(TLDCommand.TempProfile)>0 then
  //  begin
  //    for i := 0 to Length(TLDCommand.TempProfile)-1 do
  //      ControlW.SeriesTmp.AddXY(i,TLDCommand.TempProfile[i]/10);
  //  end;
  //
  //  DSeriaAutoSize(ControlW.TLDChart,ControlW.SeriesKTV);
  //
  //end;
end;

procedure TMainForm.OnReseiveTablePos(Value: integer);
  procedure SetShape(LoadD1,LoadD2,LoadD3,LoadD4,Source,MeasD1,MeasD2,MeasD3,MeasD4: boolean);
  begin
    //ControlW.ShapeLoadD1.Visible:=LoadD1;
    //ControlW.ShapeLoadD2.Visible:=LoadD2;
    //ControlW.ShapeLoadD3.Visible:=LoadD3;
    //ControlW.ShapeLoadD4.Visible:=LoadD4;
    //ControlW.ShapeSource.Visible:=Source;
    //ControlW.ShapeMeasD1.Visible:=MeasD1;
    //ControlW.ShapeMeasD2.Visible:=MeasD2;
    //ControlW.ShapeMeasD3.Visible:=MeasD3;
    //ControlW.ShapeMeasD4.Visible:=MeasD4;
  end;
begin
  if ControlW.Showing then
  begin
    case Value of
      cTablePosLoadD1:
      begin
        //ControlW.LblTablePosVal.Caption:=rsLoadD1;
        SetShape(true,false,false,false,false,false,false,false,false);
      end;
      cTablePosLoadD2:
      begin
        //ControlW.LblTablePosVal.Caption:=rsLoadD2;
        SetShape(false,true,false,false,false,false,false,false,false);
      end;
      cTablePosLoadD3:
      begin
        //ControlW.LblTablePosVal.Caption:=rsLoadD3;
        SetShape(false,false,true,false,false,false,false,false,false);
      end;
      cTablePosLoadD4:
      begin
        //ControlW.LblTablePosVal.Caption:=rsLoadD4;
        SetShape(false,false,false,true,false,false,false,false,false);
      end;
      cTablePosSource:
      begin
        //ControlW.LblTablePosVal.Caption:=rsPlaceControl;
        SetShape(false,false,false,false,true,false,false,false,false);
      end;
      cTablePosMeasD1:
      begin
        //ControlW.LblTablePosVal.Caption:=rsMeasurementD1;
        SetShape(false,false,false,false,false,true,false,false,false);
      end;
      cTablePosMeasD2:
      begin
        //ControlW.LblTablePosVal.Caption:=rsMeasurementD2;
        SetShape(false,false,false,false,false,false,true,false,false);
      end;
      cTablePosMeasD3:
      begin
        //ControlW.LblTablePosVal.Caption:=rsMeasurementD3;
        SetShape(false,false,false,false,false,false,false,true,false);
      end;
      cTablePosMeasD4:
      begin
        //ControlW.LblTablePosVal.Caption:=rsMeasurementD4;
        SetShape(false,false,false,false,false,false,false,false,true);
      end;
      cTablePosNotDefined:
      begin
        //ControlW.LblTablePosVal.Caption:=rsNotDefined;
        SetShape(false,false,false,false,false,false,false,false,false);
      end;
    end;

  end;
end;

procedure TMainForm.OnCheckDarkCurrent(aTestPassed: boolean; aDarkCurrent1,aDarkCurrent2: real);
begin
  StartMeasureW.EditDarkCurrent.Text:=FloatToStrRegion((aDarkCurrent1+aDarkCurrent2)/2);
  StartMeasureW.EditDarkCurrent.Hint:='Dark Current1 = '+FloatToStrRegion(aDarkCurrent1)+CRLF+ 'Dark Current2 = '+FloatToStrRegion(aDarkCurrent2);
  StartMeasureW.ShapeConturDC.Visible := aTestPassed;
end;

procedure TMainForm.OnCheckKSI(aTestPassed: boolean; aKSI1,aKSI2: real);
begin
  StartMeasureW.EditKSI.Text:=FloatToStrRegion((aKSI1+aKSI2)/2);
  StartMeasureW.EditKSI.Hint:='KSI_1='+FloatToStrRegion(aKSI1) + CRLF+ 'KSI_2='+FloatToStrRegion(aKSI2);
  StartMeasureW.ShapeConturKSI.Visible := aTestPassed;
end;

procedure TMainForm.OnChangeConnectionState(anOldConnectionState, aNewConnectionState: TConnectedState);            // изменение состояния связи
begin
  //WriteCommandLog(FormatDateTime('hh:nn:ss.zzz',Now)+' : -> '+Msg+' : '+COMPort);
  //MainForm.OnConnectionState(rsOpenPort,MainForm.TLDCommand.COM);
  //MainForm.OnConnectionState(rsCantOpenPort,MainForm.TLDCommand.COM);
  if aNewConnectionState<>cConnectAll then
  begin
    if not IsBitOn(TLDState,0) then
      TLDState:=SetBit(TLDState,0,true);    //  взводим бит 0 - "Нет связи"
  end
  else
    if IsBitOn(TLDState,0) then TLDState:=SetBit(TLDState,0,false);       //  сбрасывам бит 0 - "Нет связи"

  IsStart;
  CheckState;
end;

procedure TMainForm.OnChangeTLDMode(aTLD_Mode: TTLD_Mode);
const
  MeasureSetModes: set of TTLD_Mode = [modeMotorsToStart,modeCheckAir,modeMeasuring,modeBurning,modeDelay];
begin
//  modeNothing         // Ничего не делать (для прекращения запросов)
//, modeMotorsInit      // Алгоритм первичной инициализации шаговых двигателей
//, modeMotorsToStart   // Шаговые двигатели в начальное положение (окончание типовых алгоритмов с перемещениями)
//, modeInitiation      // Алгоритм первичной инициализации всей установки
//, modeIdle            // Режим ожидания (ожидание команды пользователя для продолжения)
//, modeCheckAir   // Подпрограмма чтения измерения (без перемещений)
//, modeMeasuring       // Алгоритм единичнго измерения кассеты (с перемещениями)
//, modeBurning         // Отжиг
//, modeGrading        // Алгоритм перекидывания кассет из входной кассетницы в выходную (с контролем принадлежности)
//, modePushOut         // Выброса кассеты
//, modeDelay           // Подпрограмма ожидания для остывания
//, modeFailure         // Подпрограмма ожидания для остывания
  if not(aTLD_Mode in MeasureSetModes) then
    if StartMeasureW.Showing then StartMeasureW.Close;
end;

procedure TMainForm.OnTLDError(aOnTLDError: boolean);
begin
  if aOnTLDError then
  begin
    if not IsBitOn(TLDState,1) then TLDState:=SetBit(TLDState,1,true);    //  взводим бит 1 - "Ошибка" (если он не был взведен ранее)
    //TLD_CommandSeries.CMD_CommonGoIdle('',0);

    //OnUIAnswer(aCaption,aMessage: string; aDialogType: TDialogType; anAccidentNumber: integer): integer;
    OnUIAnswer(rsCommonCheckUserAnswer, rsDosMeasErr, dFail, 0); // Диалог на компе

    TLD_CommandSeries.CMD_CommonGoProcessNumber('Error',ord(modeNothing));
  end
  else
  begin
    if IsBitOn(TLDState,1) then TLDState:=SetBit(TLDState,1,false);      //  сбрасывам бит 1 - "Ошибка" (если он не был взведен ранее)
  end;

  if (not TLDCommand.StartMeasuringFlag) and (TLDCommand.StoveTemp > TLDCommand.cMaxStartMeasureTemp) then
    OnTLDStoveCooling(true)       // остывание печки
  else
    OnTLDStoveCooling(false);     // печка остыла

  CheckState;
end;

procedure TMainForm.OnTLDDetsLoad(aTLDDetsLoad: boolean);
begin
  if aTLDDetsLoad then
  begin
    if not IsBitOn(TLDState,2) then TLDState:=SetBit(TLDState,2,true)    //  взводим бит 2 - "Загрузка детекторов" (если он не был взведен ранее)
  end
  else
  begin
    if IsBitOn(TLDState,2) then TLDState:=SetBit(TLDState,2,false);      //  сбрасывам бит 2 - "Загрузка детекторов" (если он не был взведен ранее)
  end;

  CheckState;
end;

procedure TMainForm.OnTLDDetsMeas(aTLDDetsMeas: boolean);
begin
  if aTLDDetsMeas then
  begin
    if not IsBitOn(TLDState,3) then TLDState:=SetBit(TLDState,3,true)    //  взводим бит 3 - "Идет измернеие" (если он не был взведен ранее)
  end
  else
  begin
    if IsBitOn(TLDState,3) then TLDState:=SetBit(TLDState,3,false);      //  сбрасывам бит 3 - "Идет измернеие" (если он не был взведен ранее)
  end;

  CheckState;
end;

procedure TMainForm.OnTLDStoveCooling(aTLDStoveCooling: boolean);
begin
  if aTLDStoveCooling then
  begin
    if not IsBitOn(TLDState,4) then TLDState:=SetBit(TLDState,4,true)    //  взводим бит 4 - "Остывание печки"
  end
  else
  begin
    if IsBitOn(TLDState,4) then TLDState:=SetBit(TLDState,4,false);  //  сбрасывам бит 4 - "Остывание печки"
  end;

//  CheckState;
end;

procedure TMainForm.CheckState;
begin
  if TLDState = 0 then
  begin
    if not Start then
    begin
      if not TLDCommand.Emulator then TLDStateEdit.Text:=rsSmDeviceIsReady else TLDStateEdit.Text:=rsSmDeviceIsReady+' '+'('+rsEmulator+')';
      TLDStateEdit.Color:=clMoneyGreen;
      EnabledSpeedBtns(True,True,True);
    end;
  end;

  if IsBitOn(TLDState,cBitLoadingDet) then
  begin
    if not TLDCommand.Emulator then TLDStateEdit.Text:=rsSmLoadingDetectors else TLDStateEdit.Text:=rsSmLoadingDetectors+' '+'('+rsEmulator+')';
    TLDStateEdit.Color:=clMoneyGreen;
    EnabledSpeedBtns(True,True,True);
  end;

  if IsBitOn(TLDState,cBitStoveHeating) then
  begin
    if not TLDCommand.Emulator then TLDStateEdit.Text:=Format('%s: %s',[rsSmMeasInProcess,AnsiLowerCase(rsSmStoveHeating)]) else TLDStateEdit.Text:=Format('%s: %s (%s)',[rsSmMeasInProcess,AnsiLowerCase(rsSmStoveHeating),rsEmulator]);//'Идет измерение: нагрев';
    TLDStateEdit.Color:=clMoneyGreen;
    EnabledSpeedBtns(True,True,True);
  end;

  if IsBitOn(TLDState,cBitStoveCooling) then
  begin
    if Start then
      TLDStateEdit.Text:=Format('%s: %s',[rsSmMeasInProcess,AnsiLowerCase(rsSmStoveCooling)])//'Идет измерение: остывание печки'
    else
      TLDStateEdit.Text:=rsSmStoveCooling;
    TLDStateEdit.Color:=clMoneyGreen;
    EnabledSpeedBtns(True,True,True);
  end;

  if IsBitOn(TLDState,cBitErr) then
  begin
    TLDStateEdit.Text:=rsSmError;
    TLDStateEdit.Color:=clBlue;
    EnabledSpeedBtns(False,True,False);
  end;

  if IsBitOn(TLDState,cBitNoConnection) then
  begin
    TLDStateEdit.Text:=rsSmNoConnection;
    TLDStateEdit.Color:=clSilver;
    TmpState:=cTmpGray;
    EnabledSpeedBtns(False,True,False);
  end;

end;

procedure TMainForm.OpenBtnClick(Sender: TObject);
begin
  OpenCOMPort;
end;

procedure TMainForm.OpenCalibrForm;
begin
  if IsIdenticalSelectedDosTypes then
    CalibrationForm.ShowModal
  else
    MessageDlg(Format('%s. %s.',[rsDifferentDosimeterTypes,rsDifDosimeterTypesDetail]),mtWarning,[mbOK],0);
end;

procedure TMainForm.OpenCOMPort;
begin
  //if not Assigned(TLDCommand) then
  //try
  //  if Assigned(TLDCOmmand.COMPortSyn) then
  //  begin
  //    if TLDCommand.COMPortSyn.Connected then
  //    begin
  //      OnCommandLog(TimeToStr(Now)+' : -> ',rsPort+' '+TLDCOmmand.COMPortSyn.CP.Device+' '+rsReInited,'',cMsgInf,cMsgPriorityInf);
  //      TLDCommand.AnswerTime:=Now;
  ////      TLDCommand.AnswerLog(True);
  //    end
  //    else
  //      OnCommandLog(TimeToStr(Now)+' : -> ',rsReInitFailure+' '+TLDCOmmand.COMPortSyn.CP.Device,'',cMsgInf,cMsgPriorityInf);
  //  end;
  //
  //except
  //  on Exception do
  //  begin
  //    raise Exception.Create(rsCreateDidntWork);
  //  end;
  //end;
end;

procedure TMainForm.OpenDozaReportBuilder(ReportType: String; DBGrid: TDBGridEh; orpType: TOpenReportType; orpSource: TOpenReportSource);
const
  cMaxRows = 1000;
var
  dozaReportPath        : String;
  dozaReportPathMeasID  : String;
  pathToSave            : String;
  dozaReportParam       : String;
  procedure SaveMeasList;
  var
    i                   : integer;
    ts                  : TStringList;
  begin
    ts:=TStringList.Create;

    Splash.ProgressBar.Minimum:=0;
    Splash.ProgressBar.Maximum:=DBGridEhProcess.SelectedRows.Count;
    Splash.ProgressBar.Position:=0;
    Splash.Show(false);
    Splash.SetCaption('Подготовка к формированию отчета');
    
    for i := 0 to DBGridEhProcess.SelectedRows.Count-1 do
    begin
      DBGridEhProcess.DataSource.DataSet.GotoBookmark(DBGridEhProcess.SelectedRows.Items[i]);

      if DBGridEhProcess.SelectedRows.Count>1 then
      begin
        if i = DBGridEhProcess.SelectedRows.Count-1 then
          ts.Add(DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString+'"')
        else if (i = 0) then
          ts.Add('-i unique_ids "'+DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString+',')
        else
          ts.Add(DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString+',');
        end
      else
        ts.Add('-i unique_ids "'+DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString+'"');

      Splash.ProgressBar.Position:=Splash.ProgressBar.Position+1;
    end;

    Splash.Close;
    
    ts.SaveToFile(ExtractFilePath(Application.ExeName)+cReport+PathDelim+cDozaReportMeasIDFile, TEncoding.UTF8);
    ts.Free;
  end;

  procedure SaveDosList;
  var
    i                   : integer;
    ts                  : TStringList;
  begin
    ts:=TStringList.Create;

    Splash.ProgressBar.Minimum:=0;
    Splash.ProgressBar.Maximum:=DBGridEhDos.SelectedRows.Count;
    Splash.ProgressBar.Position:=0;
    Splash.Show(false);
    Splash.SetCaption('Подготовка к формированию отчета');

    for i := 0 to DBGridEhDos.SelectedRows.Count-1 do
    begin
      DBGridEhDos.DataSource.DataSet.GotoBookmark(DBGridEhDos.SelectedRows.Items[i]);

      if DBGridEhDos.SelectedRows.Count>1 then
      begin
        if i = DBGridEhDos.SelectedRows.Count-1 then
          ts.Add('\"'+DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosID).AsString+'|'+DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosPostfix).AsString+'\"'+'"')
        else if (i = 0) then
          ts.Add('-i unique_ids "'+'\"'+DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosID).AsString+'|'+DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosPostfix).AsString+'\"'+',')
        else
          ts.Add('\"'+DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosID).AsString+'|'+DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosPostfix).AsString+'\"'+',');
        end
      else
        ts.Add('-i unique_ids "'+'\"'+DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosID).AsString+'|'+DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosPostfix).AsString+'\"'+'"');

      Splash.ProgressBar.Position:=Splash.ProgressBar.Position+1;
    end;

    Splash.Close;

    ts.SaveToFile(ExtractFilePath(Application.ExeName)+cReport+PathDelim+cDozaReportMeasIDFile, TEncoding.UTF8);
    ts.Free;
  end;

  function RunDozaReportBuilder(ReportPath,ReportPathMeasID,Param: String): boolean;
  var
    flag  : boolean;
  begin
    Splash.ProgressBar.Minimum:=0;
    Splash.ProgressBar.Maximum:=100;
    Splash.ProgressBar.Position:=50;
    Splash.Show(false);
    Splash.SetCaption(rsRptReportBuildig);

    if FileExists(ReportPath) AND FileExists(ReportPathMeasID) then
    begin
      try        
        flag:=ExecAndWait(ReportPath,Param,cExport,ExtractFilePath(Application.ExeName)+cReport+PathDelim+cLog,SW_SHOWNORMAL);
      except
        on E: Exception do
        begin
          flag:=false;
          MessageDlg(E.Message + CRLF + DozaReportPath+'!',mtError, [mbOK], 0);
          WriteLog(Format('%s "%s"',[rsRptError,ReportPath]));
        end;
      end;

      if not flag then
      begin
        MessageDlg(Format('%s "%s"',[rsRptError,ReportPath]),mtError, [mbOK], 0);
        WriteLog(Format('%s "%s"',[rsRptError,ReportPath]));
      end;

    end
    else
    begin
      flag:=false;
      MessageDlg(Format('%s "%s"',[rsRptError,ReportPath]),mtError, [mbOK], 0);
      WriteLog(Format('%s "%s"',[rsRptError,ReportPath]));
    end;

    Splash.ProgressBar.Position:=100;
    Splash.Close;

    Result:=flag;
  end;
begin
  if (DBGrid.SelectedRows.Count>0) then
  begin
    if (DBGrid.SelectedRows.Count<=cMaxRows) then
    begin
      if not DirectoryExists(ExtractFilePath(Application.ExeName)+cReport,False) then
        ForceDirectories(ExtractFilePath(Application.ExeName)+cReport);

      dozaReportPath:=ExtractFilePath(Application.ExeName)+cDozaReportBuilder+PathDelim+cDozaReportBuilderFileName;
      dozaReportPathMeasID:=ExtractFilePath(Application.ExeName)+cReport+PathDelim+cDozaReportMeasIDFile;

      case orpSource of
        orpsMeasList: SaveMeasList;
        orpsDosList:  SaveDosList;
      end;


      case orpType of
        orptSaveAndShow:
        begin
          pathToSave:=ExtractFilePath(Application.ExeName)+cReport+PathDelim+Format('%s_%s_№%s_%s',[cReport,cDozaTLD,IntToStr(DeviceID),DeleteDividers(DateTimeToStr(Now))])+cExtPDF;
          dozaReportParam:='-u with_cmd_line'+' '
                          +'-r '+ReportType+' '
                          +'-f "'+dozaReportPathMeasID+'"'+' '
                          +'-s unique_ids all'+' '
                          +'-b'+' '
                          +'-d "tld_work" "psql" "'+TLDDataModule.ServerIP+'" '+TLDDataModule.PGPort+' "'+TLDDataModule.DBName+'" "'+TLDDataModule.PGUid+'" "'+TLDDataModule.PGPass+'" false'+' '
                          +'-c'+' '
                          +'-p "'+pathToSave+'"';

          RunDozaReportBuilder(dozaReportPath,dozaReportPathMeasID,dozaReportParam);
        end;
        orptSave:
        begin
          pathToSave:=ExtractFilePath(Application.ExeName)+cReport+PathDelim+Format('%s_%s_№%s_%s',[cReport,cDozaTLD,IntToStr(DeviceID),DeleteDividers(DateTimeToStr(Now))])+cExtPDF;
          dozaReportParam:='-u with_cmd_line'+' '
                          +'-r '+ReportType+' '
                          +'-f "'+dozaReportPathMeasID+'"'+' '
                          +'-s unique_ids all'+' '
                          +'-b'+' '
                          +'-d "tld_work" "psql" "'+TLDDataModule.ServerIP+'" '+TLDDataModule.PGPort+' "'+TLDDataModule.DBName+'" "'+TLDDataModule.PGUid+'" "'+TLDDataModule.PGPass+'" false'+' '
                          +'-c'+' '
                          +'-n'+' '
                          +'-p "'+pathToSave+'"';

          if RunDozaReportBuilder(dozaReportPath,dozaReportPathMeasID,dozaReportParam) then
            MessageDlg(rsRptReportReady+'.'+' '+pathToSave,mtInformation, [mbOK], 0);
        end;
        orptSaveAs:
        begin
          SaveDialogMainForm.DefaultExt:='pdf';
          SaveDialogMainForm.Filter:='|'+'*'+cExtPDF;
          SaveDialogMainForm.InitialDir:=ExtractFilePath(Application.ExeName)+cReport+PathDelim;
          SaveDialogMainForm.FileName:=Format('%s_%s_№%s_%s',[cReport,cDozaTLD,IntToStr(DeviceID),DeleteDividers(DateTimeToStr(Now))]);

          if SaveDialogMainForm.Execute then
          begin
            pathToSave:=SaveDialogMainForm.FileName;
            dozaReportParam:='-u with_cmd_line'+' '
                            +'-r '+ReportType+' '
                            +'-f "'+dozaReportPathMeasID+'"'+' '
                            +'-s unique_ids all'+' '
                            +'-b'+' '
                            +'-d "tld_work" "psql" "'+TLDDataModule.ServerIP+'" '+TLDDataModule.PGPort+' "'+TLDDataModule.DBName+'" "'+TLDDataModule.PGUid+'" "'+TLDDataModule.PGPass+'" false'+' '
                            +'-c'+' '
                            +'-n'+' '
                            +'-p "'+pathToSave+'"';

            if RunDozaReportBuilder(dozaReportPath,dozaReportPathMeasID,dozaReportParam) then
              MessageDlg(rsRptReportReady+'.'+' '+pathToSave,mtInformation, [mbOK], 0);
          end;
        end;
      end;
    end
    else
      MessageDlg(rsRptRecordValuesExceeded+'. '+rsRptMaximumValue+' - '+IntToStr(cMaxRows) +rsNums,mtWarning, [mbOK], 0);
  end
  else
    MessageDlg(rsRptntNoSelectedRecords,mtWarning, [mbOK], 0);
end;

procedure TMainForm.ReadDeivceIdIni;
var
  ConfigIni   : Tinifile;
begin
  ConfigIni:=Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    DeviceID:=ConfigIni.ReadInteger(cSectionSettings, 'DeviceID', -1);
    if  (TLDCommand.Emulator) then DeviceID:=cEmulatorID;
  finally
    ConfigIni.Free;
  end;
end;

procedure TMainForm.ReadFilterIni;
var
  ConfigIni   : Tinifile;
//  strDateFrom : String;
//  strDateTo   : String;
//  varStr      : String;
begin
  ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try

    case PageControlMain.ActivePage.PageIndex of
      cPageMeasIndex:
      begin
//        OpenFilterMeasPanel:=ConfigIni.ReadBool(cSectionFilter, cFilterMeasEnable, false);
//        EditMeasDosNumber.Text:=ConfigIni.ReadString(cSectionFilter, cFilterMeasNumber, '');
//        LoadComboBoxFromIni(CBoxMeasOrgName,ConfigIni.ReadString(cSectionFilter, cFilterMeasOrganization, ''));
//        LoadComboBoxFromIni(CBoxMeasDep,ConfigIni.ReadString(cSectionFilter, cFilterMeasDepartment, ''));
//        LoadComboBoxFromIni(CBoxMeasDosPart,ConfigIni.ReadString(cSectionFilter, cFilterMeasDosPath, ''));
//        LoadComboBoxFromIni(CBoxMeasDosType,ConfigIni.ReadString(cSectionFilter, cFilterMeasDosType, ''));
//        LoadComboBoxFromIni(CBoxMeasStatus,ConfigIni.ReadString(cSectionFilter, cFilterMeasDosStatus, ''));
//        LoadComboBoxFromIni(CBoxMeasPersNumber,ConfigIni.ReadString(cSectionFilter, cFilterMeasPersNumber, ''));
//        LoadComboBoxFromIni(CBoxMeasIDK,ConfigIni.ReadString(cSectionFilter, cFilterMeasIDK, ''));
//        LoadComboBoxFromIni(CBoxMeasResult,ConfigIni.ReadString(cSectionFilter, cFilterMeasResult, ''));
//        LoadComboBoxFromIni(CBoxMeasComment,ConfigIni.ReadString(cSectionFilter, cFilterMeasComment, ''));
//        LoadDateTimeFromIni(ConfigIni.ReadString(cSectionFilter, cFilterMeasTimeFrom, ''),DateTimePickerMeasFrom,SpBtnMeasDropDateFrom);
//        LoadDateTimeFromIni(ConfigIni.ReadString(cSectionFilter, cFilterMeasTimeTo, ''),DateTimePickerMeasTo,SpBtnMeasDropDateTo);
      end;
      cPageDosIndex:
      begin
        OpenFilterDosPanel:=ConfigIni.ReadBool(cSectionFilter, cFilterDosEnable, false);
        LoadComboBoxFromIni(CBoxDosOrgName,ConfigIni.ReadString(cSectionFilter, cFilterDosOrganization, ''));
        LoadComboBoxFromIni(CBoxDosDep,ConfigIni.ReadString(cSectionFilter, cFilterDosDepartment, ''));
        LoadComboBoxFromIni(CBoxDosDosPart,ConfigIni.ReadString(cSectionFilter, cFilterDosDosPath, ''));
        LoadComboBoxFromIni(CBoxDosDosType,ConfigIni.ReadString(cSectionFilter, cFilterDosDosType, ''));
        LoadComboBoxFromIni(CBoxDosStatus,ConfigIni.ReadString(cSectionFilter, cFilterDosDosStatus, ''));
        LoadComboBoxFromIni(CBoxDosDeviceID,ConfigIni.ReadString(cSectionFilter, cFilterDosDeviceID, ''));
        LoadComboBoxFromIni(CBoxDosPersNumber,ConfigIni.ReadString(cSectionFilter, cFilterDosPersNumber, ''));
        LoadComboBoxFromIni(CBoxDosIDK,ConfigIni.ReadString(cSectionFilter, cFilterDosIDK, ''));
        LoadComboBoxFromIni(CBoxDosComment,ConfigIni.ReadString(cSectionFilter, cFilterDosComment, ''));
        LoadDateTimeFromIni(ConfigIni.ReadString(cSectionFilter, cFilterDosTimeFrom, ''),DateTimePickerDosFrom,SpBtnDosDropDateFrom);
        LoadDateTimeFromIni(ConfigIni.ReadString(cSectionFilter, cFilterDosTimeTo, ''),DateTimePickerDosTo,SpBtnDosDropDateTo);
      end;
      cPageProcessIndex:
      begin
        OpenFilterProcessPanel:=ConfigIni.ReadBool(cSectionFilter, cFilterProcessEnable, false);
        LoadComboBoxFromIni(CBoxProcessOrgName,ConfigIni.ReadString(cSectionFilter, cFilterProcessOrganization, ''));
        LoadComboBoxFromIni(CBoxProcessDep,ConfigIni.ReadString(cSectionFilter, cFilterProcessDepartment, ''));
        LoadComboBoxFromIni(CBoxProcessDosPart,ConfigIni.ReadString(cSectionFilter, cFilterProcessDosPath, ''));
        LoadComboBoxFromIni(CBoxProcessDosType,ConfigIni.ReadString(cSectionFilter, cFilterProcessDosType, ''));
        LoadComboBoxFromIni(CBoxProcessStatus,ConfigIni.ReadString(cSectionFilter, cFilterProcessDosStatus, ''));
        LoadComboBoxFromIni(CBoxProcessPersNumber,ConfigIni.ReadString(cSectionFilter, cFilterProcessPersNumber, ''));
        LoadComboBoxFromIni(CBoxProcessIDK,ConfigIni.ReadString(cSectionFilter, cFilterProcessIDK, ''));
        LoadComboBoxFromIni(CBoxProcessResult,ConfigIni.ReadString(cSectionFilter, cFilterProcessResult, ''));
        LoadComboBoxFromIni(CBoxProcessDeviceID,ConfigIni.ReadString(cSectionFilter, cFilterProcessDeviceID, ''));
        LoadComboBoxFromIni(CBoxProcessComment,ConfigIni.ReadString(cSectionFilter, cFilterProcessComment, ''));
        LoadDateTimeFromIni(ConfigIni.ReadString(cSectionFilter, cFilterProcessTimeFrom, ''),DateTimePickerProcessFrom,SpBtnProcessDropDateFrom);
        LoadDateTimeFromIni(ConfigIni.ReadString(cSectionFilter, cFilterProcessTimeTo, ''),DateTimePickerProcessTo,SpBtnProcessDropDateTo);
        LoadCheckBoxFromIni(CheckBoxShowToDel,ConfigIni.ReadBool(cSectionFilter, cFilterProcessShowDelMeas, false));
      end;
      cPageCalibrationIndex:
      begin
        OpenFilterCalibrPanel:=ConfigIni.ReadBool(cSectionFilter, cFilterCalibrEnable, false);
      end;
    end;
  finally
    ConfigIni.Free;
  end;
end;

procedure TMainForm.ReadFilterIniAll;
var
  ConfigIni   : Tinifile;
begin
  ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    OpenFilterDosPanel:=ConfigIni.ReadBool(cSectionFilter, cFilterDosEnable, false);
    LoadComboBoxFromIni(CBoxDosOrgName,ConfigIni.ReadString(cSectionFilter, cFilterDosOrganization, ''));
    LoadComboBoxFromIni(CBoxDosDep,ConfigIni.ReadString(cSectionFilter, cFilterDosDepartment, ''));
    LoadComboBoxFromIni(CBoxDosDosPart,ConfigIni.ReadString(cSectionFilter, cFilterDosDosPath, ''));
    LoadComboBoxFromIni(CBoxDosDosType,ConfigIni.ReadString(cSectionFilter, cFilterDosDosType, ''));
    LoadComboBoxFromIni(CBoxDosDeviceID,ConfigIni.ReadString(cSectionFilter, cFilterDosDeviceID, ''));
    LoadComboBoxFromIni(CBoxDosStatus,ConfigIni.ReadString(cSectionFilter, cFilterDosDosStatus, ''));
    LoadComboBoxFromIni(CBoxDosPersNumber,ConfigIni.ReadString(cSectionFilter, cFilterDosPersNumber, ''));
    LoadComboBoxFromIni(CBoxDosIDK,ConfigIni.ReadString(cSectionFilter, cFilterDosIDK, ''));
    LoadComboBoxFromIni(CBoxDosComment,ConfigIni.ReadString(cSectionFilter, cFilterDosComment, ''));
    LoadDateTimeFromIni(ConfigIni.ReadString(cSectionFilter, cFilterDosTimeFrom, ''),DateTimePickerDosFrom,SpBtnDosDropDateFrom);
    LoadDateTimeFromIni(ConfigIni.ReadString(cSectionFilter, cFilterDosTimeTo, ''),DateTimePickerDosTo,SpBtnDosDropDateTo);

    OpenFilterProcessPanel:=ConfigIni.ReadBool(cSectionFilter, cFilterProcessEnable, false);
    LoadComboBoxFromIni(CBoxProcessOrgName,ConfigIni.ReadString(cSectionFilter, cFilterProcessOrganization, ''));
    LoadComboBoxFromIni(CBoxProcessDep,ConfigIni.ReadString(cSectionFilter, cFilterProcessDepartment, ''));
    LoadComboBoxFromIni(CBoxProcessDosPart,ConfigIni.ReadString(cSectionFilter, cFilterProcessDosPath, ''));
    LoadComboBoxFromIni(CBoxProcessDosType,ConfigIni.ReadString(cSectionFilter, cFilterProcessDosType, ''));
    LoadComboBoxFromIni(CBoxProcessStatus,ConfigIni.ReadString(cSectionFilter, cFilterProcessDosStatus, ''));
    LoadComboBoxFromIni(CBoxProcessPersNumber,ConfigIni.ReadString(cSectionFilter, cFilterProcessPersNumber, ''));
    LoadComboBoxFromIni(CBoxProcessIDK,ConfigIni.ReadString(cSectionFilter, cFilterProcessIDK, ''));
    LoadComboBoxFromIni(CBoxProcessResult,ConfigIni.ReadString(cSectionFilter, cFilterProcessResult, ''));
    LoadComboBoxFromIni(CBoxProcessDeviceID,ConfigIni.ReadString(cSectionFilter, cFilterProcessDeviceID, ''));
    LoadComboBoxFromIni(CBoxProcessComment,ConfigIni.ReadString(cSectionFilter, cFilterProcessComment, ''));
    LoadDateTimeFromIni(ConfigIni.ReadString(cSectionFilter, cFilterProcessTimeFrom, ''),DateTimePickerProcessFrom,SpBtnProcessDropDateFrom);
    LoadDateTimeFromIni(ConfigIni.ReadString(cSectionFilter, cFilterProcessTimeTo, ''),DateTimePickerProcessTo,SpBtnProcessDropDateTo);
//    LoadCheckBoxFromIni(CheckBoxShowToDel,ConfigIni.ReadBool(cSectionFilter, cFilterProcessShowDelMeas, false));

    OpenFilterCalibrPanel:=ConfigIni.ReadBool(cSectionFilter, cFilterCalibrEnable, false);
  finally
    ConfigIni.Free;
  end;

end;

procedure TMainForm.ReadTLDSettings;
var
  _ksLevel   : integer;
  _ksDelta   : integer;
  _kFilter   : double;
  _kDevice   : double;
begin
//  if DeviceID <> -1 then
  begin
    if DeviceID = cEmulatorID then
    begin
      EditSettingsDevID.Text:=cEmulator;
      Caption:=Format('%s %s',[rsSoftwareName,cEmulator]);
    end
    else
    begin
      EditSettingsDevID.Text:=IntToStr(DeviceID);
      Caption:=Format('%s №%s',[rsSoftwareName,IntToStr(DeviceID)]);
    end;

    TLDDataModule.ReadTLDSettings(DeviceID,FKSLevel,FKSDelta,FKFilter,FKDevice);

    EditSettingsKSNormalValue.Text:=IntToStr(FKSLevel);
    EditSettingsKSDeviation.Text:=IntToStr(FKSDelta);
    EditSettingsKFilter.Text:=FloatToStrRegion(FKFilter);
  end;

end;

procedure TMainForm.RecalcCurrentDosimeterDose(DosID,MeasID: String);
begin
//  if (not DosID.IsEmpty) and (not MeasID.IsEmpty) then
  if (DosID<>'') and (MeasID<>'') then
  begin
    if Assigned(Dosimeter) then FreeAndNil(Dosimeter);

    Dosimeter:=TDosimeter.Create(DosID,MeasID);
    Dosimeter.MeasurementID:=StrToInt(MeasID);
    Dosimeter.FullNumber:=DosID;
    LoadDosWithMeasData(TLDDataModule.ADOQuery,Dosimeter,MeasID);
    LoadDetData(TLDDataModule.ADOQuery,Dosimeter,MeasID);

    Dosimeter.ReadKFromDosimeter;
    RecalcDetectorsDose;
    RecalcGroupDosimeterDose;
  end
  else
    if Assigned(Dosimeter) then FreeAndNil(Dosimeter);

end;

procedure TMainForm.RecalcDetectorsDose;
var
  i: integer;
begin
  for i := 1 to MainForm.Dosimeter.DetectorsList.Count do
  begin
    if Assigned(MainForm.Dosimeter.DetectorsList[i-1]) then
    begin
      MainForm.Dosimeter.CalcDetectorDose(i);
      MainForm.UpdateDetectorMeasData(i);
    end;
  end;
end;

procedure TMainForm.UpdateDetectorGausFon(DetPos: integer);
var
  i: integer;
begin
  TDetector(Dosimeter.DetectorsList[DetPos-1]).Fon:='';
  TDetector(Dosimeter.DetectorsList[DetPos-1]).Gaus:='';

  for i := 0 to MaxChannels do
  begin
    if TDetector(Dosimeter.DetectorsList[DetPos-1]).Fon='' then
      TDetector(Dosimeter.DetectorsList[DetPos-1]).Fon:=FloatToStrRegion(CalcForm.BuffBackground[i])
    else
      TDetector(Dosimeter.DetectorsList[DetPos-1]).Fon:=TDetector(Dosimeter.DetectorsList[DetPos-1]).Fon+','+FloatToStrRegion(CalcForm.BuffBackground[i]);

    if TDetector(Dosimeter.DetectorsList[DetPos-1]).Gaus='' then
      TDetector(Dosimeter.DetectorsList[DetPos-1]).Gaus:=FloatToStrRegion(CalcForm.Peak_R1[i]+CalcForm.BuffBackground[i])
    else
      TDetector(Dosimeter.DetectorsList[DetPos-1]).Gaus:=TDetector(Dosimeter.DetectorsList[DetPos-1]).Gaus+','+FloatToStrRegion(CalcForm.Peak_R1[i]+CalcForm.BuffBackground[i]);
  end;

  TDetector(Dosimeter.DetectorsList[DetPos-1]).State:=GetDetStateAfterCalc(CalcForm.OutEnum);

  //TDetector(Dosimeter.DetectorsList[DetPos-1]).S:=CalcForm.CDetector.S;     //**//

  //{TDetector}Dosimeter.DetectorsList[DetPos-1]:=CalcForm.CDetector;

//**  UpdateDetectorMeasData(DetPos);
end;

procedure TMainForm.RecalcDosimeterDose;
var
  index: integer;
begin
  if TLDDataModule.IsDBConnected then
  begin
    if Dosimeter <> nil then
    begin
      index:=Dosimeter.MeasurementID;

      Dosimeter.CalcDose;
      Dosimeter.Validity:=Dosimeter.GetDosimeterValidity;

      SaveDosimeterData;
      UpdateGridMeasAndProcessPages;

      case PageControlMain.ActivePage.PageIndex of
        cPageMeasIndex:
        begin
          DBGridEhOnlyMeas.DataSource.DataSet.Locate(cFieldDosMeasID,index,[]);
          DBGridEhOnlyMeas.SelectedRows.CurrentRowSelected:=true;
        end;
        cPageProcessIndex:
        begin
          DBGridEhProcess.DataSource.DataSet.Locate(cFieldDosMeasID,index,[]);
          DBGridEhProcess.SelectedRows.CurrentRowSelected:=true;
        end;
      end;

      GetMeasData;

      WriteLog(Format('%s "%s"',[rsDosimeterRecalc,Dosimeter.FullNumber]));
    end;
  end;
end;


procedure TMainForm.RecalcGroupDosimeterDose;
begin
  if TLDDataModule.IsDBConnected then
  begin
    if Dosimeter <> nil then
    begin
      Dosimeter.CalcDose;
      Dosimeter.Validity:=Dosimeter.GetDosimeterValidity;

      SaveDosimeterData;

      WriteLog(Format('%s "%s"',[rsDosimeterRecalc,Dosimeter.FullNumber]));
    end;
  end;
end;

procedure TMainForm.RecalcGroupDose;
var
  i         : integer;
  index     : integer;
  dbGrid    : TDBGridEh;
begin

  case PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex: dbGrid:=DBGridEhOnlyMeas;
    cPageProcessIndex: dbGrid:=DBGridEhProcess;
    else
      dbGrid:=DBGridEhOnlyMeas;
  end;

  if dbGrid.SelectedRows.Count > 0 then
  begin
    if TLDDataModule.IsDBConnected then
    begin

      index:=0;
      for i := 0 to dbGrid.SelectedRows.Count-1 do
      begin
        dbGrid.DataSource.DataSet.GotoBookmark(dbGrid.SelectedRows.Items[i]);

        GetMeasData;

        if Assigned(Dosimeter) then
        begin
          index:=Dosimeter.MeasurementID;
          Dosimeter.ReadKFromDosimeter;
          RecalcDetectorsDose;
          RecalcGroupDosimeterDose;
        end;

      end;

      UpdateGridMeasAndProcessPages;

      dbGrid.DataSource.DataSet.Locate(cFieldDosMeasID,index,[]);
      dbGrid.SelectedRows.CurrentRowSelected:=true;

      GetMeasData;
    end;

  end;
end;

procedure TMainForm.ResetDosimeterData;
begin
  FreeAndNil(Dosimeter);
end;


function GetValueFromComment(aValue,aComment: String): real;
var
  St : String;
  i,j: integer;
begin
  try
    result:=0;
    i := pos(aValue,aComment);
    if i>0 then
    begin
      j := pos('|',aComment,i);
      St:=copy(aComment,i+length(aValue),j-i-length(aValue));
      result:=StrToFloat(St);
    end;
  except
    result:=0;
  end;
end;

procedure TMainForm.GetTempProfileToUI(aCarretePosition: TCarretePosition; aComment: string);
var
  time_preheat: real;
  time_meas: real;
  time_burn: real;
  temp_preheat: real;
  temp_meas: real;
  temp_burn: real;
  sumTimes : real;
  //can_preheat: real;
  //can_meas: real;
  //can_burn: real;
begin
  //aComment := CalcForm.CDetector.DetTypeComment;
  with TLDCommand.ChangeData.Detectors[aCarretePosition] do
  begin
    time_preheat := GetValueFromComment('time_preheat=',aComment);
    time_meas := GetValueFromComment('time_meas=',aComment);
    time_burn := GetValueFromComment('time_burn=',aComment);
    temp_preheat := GetValueFromComment('temp_preheat=',aComment);
    temp_meas := GetValueFromComment('temp_meas=',aComment);
    temp_burn := GetValueFromComment('temp_burn=',aComment);
    temp_rate := GetValueFromComment('speed=',aComment);

    sumTimes := time_preheat + time_meas + time_burn;
    //can_preheat := 0;
    //can_meas := 0;
    //can_burn := 0;
    //if sumTimes<>0 then
    //begin
    //  can_preheat := 300 * time_preheat / sumTimes;
    //  can_meas := 300 * time_meas / sumTimes;
    //  can_burn := 300 * time_burn / sumTimes;
    //end;

    //OptionsForm.VLE.Values['time_preheat'] := FloatToStrRegionF(time_preheat,ffGeneral,6,3);
    //OptionsForm.VLE.Values['time_meas'] := FloatToStrRegionF(time_meas,ffGeneral,6,3);
    //OptionsForm.VLE.Values['time_burn'] := FloatToStrRegionF(time_burn,ffGeneral,6,3);
    //OptionsForm.VLE.Values['temp_preheat'] := FloatToStrRegionF(temp_preheat,ffGeneral,6,3);
    //OptionsForm.VLE.Values['temp_meas'] := FloatToStrRegionF(temp_meas,ffGeneral,6,3);
    //OptionsForm.VLE.Values['temp_burn'] := FloatToStrRegionF(temp_burn,ffGeneral,6,3);

    //if sumtimes=0 then Exit;
    //OptionsForm.VLE.Values['chanal_preheat'] := FloatToStrRegionF(can_preheat,ffGeneral,6,3);
    //OptionsForm.VLE.Values['chanal_meas'] := FloatToStrRegionF(can_meas,ffGeneral,6,3);
    //OptionsForm.VLE.Values['chanal_burn'] := FloatToStrRegionF(can_burn,ffGeneral,6,3);
  end;
//    ShowMessage(aComment + #13 + St);
end;

// Тест битовых структур - прикольно
//procedure TMainForm.Edit1DblClick(Sender: TObject);
//const
//  StBit:array [0..1] of string = ('0','1');
//type
//  bit = 0..1;
//  TBitsinAWord = bitpacked array[0..15] of bit;
//
//var
//  Buf,i: integer;
//  R: record
//       case boolean of
//       false:  (A: word);
//       true:   (B: TBitsinAWord);
//     end;
//
//  St: string;
//begin
//  Buf:=StrToInt(Edit1.Text);
//  R.A:=Buf;
//  St:='';
//  for i:=15 downto 0 do St:=St + StBit[R.B[i]];
//  ShowMessage(St);
//end;

end.
