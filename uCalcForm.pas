unit uCalcForm;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows, ComObj,
  {$ELSE}
  {$ENDIF}
  LCLType, LCLIntf,
  fpspreadsheet, fpsTypes, xlsbiff8, fpsutils,
  Messages, SysUtils, Variants,
  Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls,
  TaSeries, ExtCtrls,
  Inifiles,
  Math,
  uDosimeter,
  uDetector,
  uSeparator,
  uOpenDB,
  uConst, ComCtrls, DB, Grids, DBGrids,
  Menus, Buttons, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, GridsEh, DBAxisGridsEh,
  DBGridsEh,
  ImgList, DBCtrlsEh,
  uUsersManagement,
  taGraph, TAStyles, TATransformations, TATools, TASources, TACustomSource,
//  lconvencoding,
  TALegendPanel, Types, TALegend, TAChartLiveView;
const
  cKTVNumber = 0;

  MaxChannels = 299;

  clogDetectorID = 0;
  clogFon = 1;
  clogFitFon = 2;
  clogPik = 3;
  clogFitPik = 4;
  clogSquares = 5;
  clogToKarakash = 6;
  clogCRLF = 7;

  CRLF = #13#10;

  cDefBN2_width = 8;

  clEditSelect = clSkyBlue;

var
  bCalcForm_SavePosition: boolean = false;
  bCalcForm_ParametersPanel: boolean = false;
  bCalcForm_VisualChangers_View: boolean = false;
  bCalcForm_VisualChangers_Annotation: boolean = false;
  bCalcForm_VisualRange_View: boolean = true;
  bCalcForm_VisualRange_Use: boolean = true;
  bCalcForm_EditRange_Change: boolean = true;
  bCalcForm_cbWOFon_View: boolean = true;
  bCalcForm_Dose_View: boolean = true;
  bCalcForm_Err_View: boolean = false;
  bCalcForm_Menu_View: boolean = false;
  bCalcForm_VisualChangers_Use: boolean = false;
  bCalcForm_EditChart: boolean = false;
  bCalcForm_ExitNotifyIfManualChange: boolean = true;
  bCalcForm_ShowNegativeDose: boolean = false;
  bCalcForm_EditByScroll: boolean = false;

type
  TDarray = array [0 .. MaxChannels] of double ;
  TParamArray = array [1 .. 6] of double; // GM1,GA1.DGM2,DGA2,GSL,GSR
  TOutEnum = (outBad, outWarning, outGood);
  BGFuncType = (bgfExp, bgfStep, bgfNone);

  TPeakInfo = record
    Centre: integer;
    LeftSigma, RightSigma: integer;
    LeftEdge, RightEdge: integer;
  end;

  TTypeExcelOut = (eoAll, eoByDosimeter, eoByComment);
  TCalcOptions = (ccFromDB,ccAuto,ccManual);
  TChartFunction = (cfNone, cfBackGround, cfPeak);
  TMainAlgorithm = (alFitting,alArea10_280,alArea60_240,alStep,alUser);
  TFPCalcType = (fpAuto,fpManual); // Find Peak type
  TSDefOptions = (sdefDefinitely,sdefIfNeed);

  { TCalcForm }

  TCalcForm = class(TForm)
    Btn_FitFon: TButton;
    Btn_FitPeak: TButton;
    CAT_Auto1: TChartAxisTransformations;
    CAT_Auto1AutoScaleAxisTransform1: TAutoScaleAxisTransform;
    CAT_Auto1AutoScaleAxisTransform2: TAutoScaleAxisTransform;
    CAT_Auto2: TChartAxisTransformations;
    CB_FitBG_Auto: TCheckBox;
    CB_FitPeak_Auto: TCheckBox;
    CB_WOFon: TCheckBox;
    ChartLiveView1: TChartLiveView;
    ChartToolset1: TChartToolset;
    ChartToolset1LegendClickTool1: TLegendClickTool;
    ChartToolset1UserDefinedTool1: TUserDefinedTool;
    EditBdy: TEdit;
    EditBt: TEdit;
    EditBx0: TEdit;
    EditBxy0: TEdit;
    EditBy0: TEdit;
    Edit_BN1: TEdit;
    Edit_BN1_width: TEdit;
    Edit_BN2: TEdit;
    Edit_BN2_width: TEdit;
    Edit_DGA2: TEdit;
    Edit_DGM2: TEdit;
    Edit_GA1: TEdit;
    Edit_GM1: TEdit;
    Edit_GSL: TEdit;
    Edit_GSR: TEdit;
    Edit_N1: TEdit;
    Edit_N2: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelK: TLabel;
    Label_S1: TLabel;
    Label_ViewOptions: TLabel;
    LblM: TLabel;
    LblSig: TLabel;
    NRecalculate: TMenuItem;
    MenuOptions: TPopupMenu;
    N_Delimiter: TMenuItem;
    N_Delimiter2: TMenuItem;
    N_Delimiter3: TMenuItem;
    NOptDefault: TMenuItem;
    NOptHideZones: TMenuItem;
    NOptSaveOptions: TMenuItem;
    NOptShowChartEdit: TMenuItem;
    NOptShowMenu: TMenuItem;
    NOptShowNegativeDoses: TMenuItem;
    NOptShowPanel: TMenuItem;
    NOptUnSaveNotifyOff: TMenuItem;
    PanelChart: TPanel;
    ChartCalc: TChart;
    PC_ChartFunction: TPageControl;
    SB_EditChart: TSpeedButton;
    SB_UserOptions: TSpeedButton;
    Separator1: TMenuItem;
//    SeriesSRC: TPointSeries;
    SeriesSRC: TLineSeries;
    SeriesGlade: TLineSeries;
    SeriesFon: TAreaSeries;
    SeriesFuncPik1: TLineSeries;
    SeriesFuncPik2: TLineSeries;
    SeriesInterestRegion: TAreaSeries;
    SeriesSumPeaks: TLineSeries;
    SeriesTempProfil: TLineSeries;
    MainMenu: TMainMenu;
    MainMenuFile: TMenuItem;
    MainMenuExit: TMenuItem;
    PopupMenu_ChooseSeries: TPopupMenu;
    NChoose1: TMenuItem;
    NChoose2: TMenuItem;
    NChoose3: TMenuItem;
    NChoose4: TMenuItem;
    NMakeAll: TMenuItem;
    NSpace: TMenuItem;
    NMakeAllGroupByDos: TMenuItem;
    NMakeAllGroupByComment: TMenuItem;
    ImageList1: TImageList;
    PanelInChart: TPanel;
    Edit_S: TEdit;
    Edit_Err: TEdit;
    Label_Err: TLabel;
    Label_S: TLabel;
    Btn_Save: TBitBtn;
    Btn_GetDefault: TBitBtn;
    BtnOptions: TBitBtn;
    Btn_FullAuto: TButton;
//    ChartEditor1: TChartEditor;
//    ImportChart1: TImportChart;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    CalcTimer: TTimer;
//    ChartTool_Peak5_X: TColorLineTool;
//    ChartTool_Peak5_Y: TColorLineTool;
//    ChartTool_Peak4_X: TColorLineTool;
//    ChartTool_Peak4_Y: TColorLineTool;
//    ChartTool_Annotation: TAnnotationTool;

    Label16: TLabel;
    NMakeFindOptimization: TMenuItem;
    N2: TMenuItem;
    Btn_ClearWarning: TButton;
    SB_UserWarning: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet_Peak: TTabSheet;
    procedure ChartCalcAfterDrawBackWall(ASender: TChart; ACanvas: TCanvas;
      const ARect: TRect);
    procedure ChartCalcMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ChartCalcMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ChartToolset1LegendClickTool1Click(ASender: TChartTool;
      ALegend: TChartLegend);
    procedure ChartToolset1UserDefinedTool1AfterMouseDown(ATool: TChartTool;
      APoint: TPoint);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MainMenuExitClick(Sender: TObject);
    procedure FileOpenBDClick(Sender: TObject);
    procedure CB_WOFonClick(Sender: TObject);
    procedure Btn_FitClick(Sender: TObject);
    procedure NChoose1Click(Sender: TObject);
    procedure NChoose2Click(Sender: TObject);
    procedure NChoose3Click(Sender: TObject);
    procedure NChoose4Click(Sender: TObject);
    procedure NMakeAllClick(Sender: TObject);
    procedure Btn_FonFitClick(Sender: TObject);
    procedure NMakeAllGroupByDosClick(Sender: TObject);
    procedure NMakeAllGroupByCommentClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure Edit_N1Change(Sender: TObject);
    procedure Edit_N2Change(Sender: TObject);
    procedure Btn_GetDefaultClick(Sender: TObject);
    procedure Edit_GM1Change(Sender: TObject);
    procedure Edit_GA1Change(Sender: TObject);
    procedure ChangeOptions(Sender: TObject);
    procedure Edit_DGM2Change(Sender: TObject);
    procedure Edit_DGA2Change(Sender: TObject);
    procedure Edit_Enter(Sender: TObject);
    procedure Edit_Exit(Sender: TObject);
    procedure BtnOptionsClick(Sender: TObject);
    procedure Btn_FullAutoClick(Sender: TObject);
    procedure NOptDefaultClick(Sender: TObject);
    procedure NOptHideZonesClick(Sender: TObject);
    procedure NOptSaveOptionsClick(Sender: TObject);
    procedure NOptShowChartEditClick(Sender: TObject);
    procedure NOptShowMenuClick(Sender: TObject);
    procedure NOptShowNegativeDosesClick(Sender: TObject);
    procedure NOptShowPanelClick(Sender: TObject);
    procedure NOptUnSaveNotifyOffClick(Sender: TObject);
    procedure NRecalculateClick(Sender: TObject);
    procedure SB_EditChartClick(Sender: TObject);
    procedure SB_SaveChartClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CalcTimerTimer(Sender: TObject);
    procedure ChartCalcResize(Sender: TObject);
    procedure ChartCalcAfterDraw(Sender: TObject);
    procedure ChartCalcMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
//    procedure ChartTool_BN1_EndDragLine(Sender: TColorLineTool);
//    procedure ChartTool_N1EndDragLine(Sender: TColorLineTool);
//    procedure ChartTool_N2EndDragLine(Sender: TColorLineTool);
//    procedure ChartTool_Region_BN2Dragging(Sender: TObject);
//    procedure ChartTool_Region_BN2Resized(Sender: TObject);
    procedure ChartCalcMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit_BN1Change(Sender: TObject);
    procedure Edit_BN1_widthChange(Sender: TObject);
    procedure Edit_BN2Change(Sender: TObject);
    procedure Edit_BN2_widthChange(Sender: TObject);
    procedure PC_ChartFunctionChange(Sender: TObject);
//    procedure ChartTool_N1DragLine(Sender: TColorLineTool);
//    procedure ChartTool_N2DragLine(Sender: TColorLineTool);
//    procedure ChartTool_BN1_DragLine(Sender: TColorLineTool);
//    procedure ChartTool_Peak4_XDragLine(Sender: TColorLineTool);
//    procedure ChartTool_Peak4_XEndDragLine(Sender: TColorLineTool);
//    procedure ChartTool_Peak4_YDragLine(Sender: TColorLineTool);
//    procedure ChartTool_Peak4_YEndDragLine(Sender: TColorLineTool);
//    procedure ChartTool_Peak5_XDragLine(Sender: TColorLineTool);
//    procedure ChartTool_Peak5_XEndDragLine(Sender: TColorLineTool);
//    procedure ChartTool_Peak5_YDragLine(Sender: TColorLineTool);
//    procedure ChartTool_Peak5_YEndDragLine(Sender: TColorLineTool);
//    procedure ChartTool_Region_BN2Resizing(Sender: TObject);
    procedure Btn_FitFonClick(Sender: TObject);
    procedure Btn_FitPeakClick(Sender: TObject);
    procedure NMakeFindOptimizationClick(Sender: TObject);
    procedure Btn_ClearWarningClick(Sender: TObject);
    procedure SB_UserOptionsClick(Sender: TObject);
    procedure SB_UserWarningClick(Sender: TObject);
    procedure N_UseCurrentCalibrationClick(Sender: TObject);
//    procedure ChartTool_Region_BN1Dragging(Sender: TObject);
//    procedure ChartTool_Region_BN1Resized(Sender: TObject);
//    procedure ChartTool_Region_BN1Resizing(Sender: TObject);
    procedure FormClose(Sender: TObject; var anAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ChartCalcZoom(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure Edit_MouseEnter(Sender: TObject);

  private
    ChartTool_N1_Value: double;
    ChartTool_N2_Value: double;
    ChartTool_N_Pen_Width : integer;
    ChartTool_N_Active: boolean;
    ChartTool_N_AllowDrag: boolean;
    ChartTool_BN1_Value: double;
    ChartTool_BN1_Width: double;
    ChartTool_BN2_Value: double;
    ChartTool_BN2_Width: double;
    ChartTool_BN1_Pen_Width: integer;
    ChartTool_BN2_Pen_Width: integer;

    MouseEdit : TEdit;
//    MouseEditActive: boolean;

    FChartFunction : TChartFunction;
    FCalcType : TCalcOptions;
    FCDetector     : TDetector;
    BGFunc : BGFuncType;
    FChartTitle: string;
    FChartSubTitle: string;
    FChartFooter: string;
    FChartSubFooter: string;

    bCrossBT40: boolean; // признак перехода через BT = 40 в разных местах при поиске функции фона по BT=40
    BG_Start: integer;  // Номер канала, с которого мы пренебрегаем пиком и ищем только фоновую функцию
    BG_End: integer;    // Номер канала, до которого мы пренебрегаем возможным вторым перегибом и ищем фоновую функцию
    DX: integer;   // ширина зоны статистического накопления для оценки изменения величины (параметр задаётся снаружи из Options) - 10
    {$IFDEF MSWINDOWS}
    MyExcel: OleVariant; // Для вывода расчётов в Excel
    {$ELSE}
    {$ENDIF}

    minErr, minErrF: double; // минимальные коэффициенты ошибок для пика и фона (для фитирования)
    GradientStep, GradientPiece: double; // настроечные переменные для фитирования
    GradientRecursionStop, FonGradientRecursionStop : boolean;
    Bt40 : Double;
    FP_TooLitleLevel : Double;

    BuffAvg: TDarray; // Сглаженный массив
    BuffAvgWOB: TDarray; // Сглаженный массив минус фон
    BuffWideAvgWOB: TDarray;  // Сглаженный массив минус фон + сглаживание усреднением каналов с шириной DX
    BuffDiff: TDarray; // первая производная (для поиска пиков)
    BuffDiff2: TDarray; // вторая производная (для поиска пиков)

    FoundPeak: TPeakInfo; // параметры найденного пика
    iWaitingPeakCentre: integer; // ожидаемый канал центра пика или зоны значимой части
    WaitMaxWidth: integer; // ожидаемая ширина зоны значимой части
    kwidth: integer;

    IsAdaptive: boolean; // FindPeak parameters
    MinS : double;
    MinDX : double;
    MinS_4Fit : double;
    MinS_4FitFon : double;
    MinS_4SuperFit : double;
    MinS_4FitChangeRange : double;
    MaxS_4WaitingsFit : double;
    SFonInterest : double;
    DoFitWithWaitings : boolean;

    procedure NOpt_CorrectDelimiters;

    procedure RecalcBackgroundByManual;
    procedure RecalcPeakByManual;

    procedure LoadOptions;    // Загрузка численных значений опций алгоритма

    function GradientDownStep(var v: TParamArray; DoLog: boolean): double;  // шаг по градиентному спуску и возвращаем разницу
    function CheckExcelRun: boolean;
    procedure SaveCalcImage(aSubDir,aName:String);

    procedure QueryAndShowDetData(DosId: String; DetId: String;   ColumnName: String; Seria: integer; MeasId: String);

    procedure OutDetail(aOutEnum: TOutEnum; aOutString: String);  // если признак обработки сохранился или ухудшился - добавляем сопроводительный комментарий
    function FuncBackground(aBGFuncType:BGFuncType; i, aBx0, aBt, aBy0, aBxy0, aBdy : double): double;  // Функция фона (показательная)
    function FuncBase(i: double; av: TParamArray): double;     // Основная функция описания пика (в настоящее время =DGauss)
    function FuncDGauss(i: double; v: TParamArray): double;    // Полная функция описания пиков А4. А5
    function FuncDGaussR1(i: double; v: TParamArray): double;  // Функция описания пика А5
    function FuncDGaussR2(i: double; v: TParamArray): double;  // Функция описания пика А4
    function GradientFonDownStep(var aBx0, aBt, aBy0, aBxy0, aBdy: double): double; // шаг по градиентному спуску
    function Hi2_Fon(aBx0, aBt, aBy0, aBxy0, aBdy: double): double;      // хи Квадрат - стат. оценка результата подбора фона
    function Hi2_Func(av: TParamArray): double;          // хи Квадрат - стат. оценка результата подбора функции

    procedure SourceFilter(aDetector : TDetector);
    procedure AssignCurrentGlade; // считаем сглаживание по текущим настройкам и вносим в массив данных информацию по рассчитанному сглаживанию
    procedure AssignCurrentFon(aBt, aBx0, aBy0, aBxy0, aBdy: double); // вносим в массивы данных информацию по рассчитанной функции фона
    procedure AssignCurrentPeak(aGM1,aDGM2,aGA1,aDGA2,aGSL,aGSR: double); // вносим в массивы данных информацию по рассчитанной функции пика

    procedure CheckFon(aBx0, aBt, aBy0: double); // проверка фоновой функции на различные критерии
    procedure CheckPeakDGauss(aWaitingGM1,aGM1,aDGM2,aGA1,aDGA2,aGSL,aGSR : double); // проверка пиковой функции на различные критерии
    procedure CheckAll(aiWaitingPeakCentre: integer; aDetector : TDetector); // проверка пиковой функции на различные критерии

    function FindPeak(fpCalcType:TFPCalcType): TPeakInfo; // Centre and params as result

    function GetVLE_Float(aParamName: String; aDefault: double): double; // Механизм изменения внутренних переменных алгоритма снаружи
    function GetVLE_Int(aParamName: String; aDefault: integer): integer; // Механизм изменения внутренних переменных алгоритма снаружи
    procedure SetVLE_Float(aParamName: String; aValue: double); // Механизм изменения внутренних переменных алгоритма снаружи

    procedure GradiendDown;        // step Фитирование пика
    procedure FonGradientDown;     // step Фитирование фона
    procedure GradientDownAuto;    // Фитирование пика
    procedure GradientFonDownAuto; // Фитирование фона

    function FindFonExp_Bt(R_Start, R_End, akwidth: integer; abCrossBT40: boolean): double;    // поиск параметра Bt фоновой функции
    function FindFonExp_Bx0(aBy0,aBt: Double; R_Start, R_End, akwidth: integer): double;   // поиск параметра Bx0 фоновой функции
    function FindFonExp_By0(aDetector: TDetector; aBuffAvg: TDarray; L_Start,L_Num: integer): double;                    // поиск параметра By0 фоновой функции по начальному участку КТВ

    function FindFonExpRangeBySlantMaximum(RangeLeft, RangeRight, akwidth: integer;  var R_Start, R_End: integer): boolean; // Поиск функции фона по максимальному наклону
    function FindFonExpRangeByMinimum(RangeLeft, RangeRight, akwidth: integer; var R_Start, R_End: integer): boolean;       // Поиск функции фона по провалу за пиком без определения пика
    function FindFonExpRangeByBTEqual40(RangeLeft, RangeRight, akwidth: integer; var R_Start, R_End: integer): boolean;     // Поиск функции фона по волшебной близости Bt к 40
    function FindFonExpRangeByPeak(RangeLeft, RangeRight, akwidth: integer; var R_Start, R_End: integer; alterAlgorithm: integer): boolean; // Поиск функции фона по провалу за пиком с нахождением пика
    function FindFonExpRangeCombo(RangeLeft, RangeRight, akwidth: integer; var R_Start, R_End: integer): boolean;

    function FindFonExpByRange(aBG_Start, aBG_End, akwidth: integer; var aBt, aBx0: Double): boolean;
    function FindFonExpBetweenPoints(x1,y1, x2,y2, aBy0: Double; var aBt, aBx0: Double): boolean;
    function FindFonExpBt40andRightRange( x, y, aBy0: Double; var aBt: Double; var aBx0: Double ): boolean;


    function FindFonStep_Bdy(aBdy0 : Double; R_Start, R_End: integer): double;    // поиск параметра Bt фоновой функции Step


    procedure GetWOCalc;  // Основной расчёт - только расчёт (без фитирования)
    procedure CalcAuto;   // Основной расчёт - автоматический расчёт
    procedure CalcSquare; // Расчёт S без пика (над фоном)
    procedure CalcShow;   // отображение результатов по расчётам
    procedure CalcOut;    // вывод результатов расчётов

    procedure FoundPeakCorrection;  // Уточнение центроиды, полуширин и высоты
    procedure BigPeakCorrection;  // Коррекция сверхбольших значений (Гиперлинейность)
    procedure PeakSimulationIfNeed; // формирование пика в случае когда он не найден, но очень хочется

    procedure UpdateEdits(Detector: TDetector);

    procedure SetCalcType(const Value: TCalcOptions);

    procedure SetChartFunction(const Value: TChartFunction);

    procedure SetChartTitle(const Value: string);
    procedure SetChartSubTitle(const Value: string);
    procedure SetChartFooter(const Value: string);
    procedure SetChartSubFooter(const Value: string);

    procedure ShowLinesWhenDrag(X, Y: Integer; reCalc: boolean);

  public
    DisableCalcControls: boolean;
    BuffBackground: TDarray;  // Фон
    BuffDGauss: TDarray;      // Двойной гаусс описывающий наш сложный пик (A4+A5)

    MainAlgorithm : TMainAlgorithm;

    Peak_R1: TDarray; // массив формы пика А5
    Peak_R2: TDarray; // массив формы пика А4

    OutEnum: TOutEnum;        // Выходное значение оценки успешности результата расчётов из расчётного модуля

    property CalcType : TCalcOptions read FCalcType write SetCalcType;

    property CDetector: TDetector read FCDetector write FCDetector;

    property ChartFunction : TChartFunction read FChartFunction write SetChartFunction;

    property ChartTitle: string read FChartTitle write SetChartTitle;
    property ChartSubTitle: string read FChartSubTitle write SetChartSubTitle;
    property ChartFooter: string read FChartFooter write SetChartFooter;
    property ChartSubFooter: string read FChartSubFooter write SetChartSubFooter;


    procedure CalcRefresh;    // Вызов расчёта и отображения

    procedure CalcDetector(aDetector: TDetector);
    procedure __ShowDetector(aDetector: TDetector);
    procedure LoadData(aDetector: TDetector);

    procedure SaveToExcel(aTypeExcelOut: TTypeExcelOut); // Сохранение рассчётных значений в Excel

    procedure ShowDataInChart(DosId, MeasId, DetId, MeasTime: String);

    procedure SetInterfaceByPermits;

    procedure LoadOptionsFromFile(aFileName: String);

    procedure SetDefaultOptions(aDetector: TDetector; aOptions: TSDefOptions = sdefDefinitely);

    { Public declarations }
  end;

var
  CalcForm: TCalcForm;

  bOptionsChanged: boolean = false;


implementation
uses
  UOptions,
  SlavaTools,
  uMainForm,
  uFunctions,
  uLanguages,
  uLog,
  System.UITypes,
  uLogPassForm,
  DateUtils;
{$R *.dfm}


var
  LFileName: String;
  tmLOF : boolean = False; // ппризнак загрузки опций
procedure TCalcForm.LoadOptionsFromFile(aFileName: String);
begin
  LFileName:=aFileName;

  tmLOF := True;
  CalcTimer.Enabled := True;
end;

procedure lowPassFilter(cutoff: Double);
var
  i: Integer;
  output: TDarray;
  alpha, y: Double;
begin
  if cutoff=0 then Exit;
  alpha := 1 / (2 * Pi * cutoff);
  output[0] := CalcForm.BuffAVG[0];
  for i := 1 to 299 do
  begin
    y := alpha * CalcForm.BuffAVG[i] + (1 - alpha) * output[i-1];
    output[i] := y;
  end;
  CalcForm.BuffAVG := output;
end;

procedure LoadFromFile(RootObject: TComponent; const FileName: TFileName);
var
  FileStream: TFileStream;
  MemStream: TMemoryStream;
begin
  FileStream := TFileStream.Create(FileName, 0);
  MemStream := TMemoryStream.Create;
  try
    ObjectTextToBinary(FileStream, MemStream);
    MemStream.Position := 0;
    MemStream.ReadComponent(RootObject);
  finally
    MemStream.Free;
    FileStream.Free;
  end;
end;

var
  tmAnnotation: integer = 0;  // время высвечивания аннотации в 100мс интервалах
  tmMouseScroll: integer = 0;  // время высвечивания Увшеа, меняемого по скрулу в 100мс интервалах
  bStartMouseScroll: boolean = false;
  tmRecalcManual: integer = 0;  // время до пересчёта пика при изменении фона в 100мс интервалах
procedure TCalcForm.CalcTimerTimer(Sender: TObject);
var
  bOptionsShow : boolean;
  OldN1,OldN2: real;
begin
  if tmLOF then
  begin
    OptionsForm.DisableOptionsControls := True;
    tmLOF := False;
    bOptionsShow := OptionsForm.Showing;
    OptionsForm.Close;
    OptionsForm.Free;
    OptionsForm := TOptionsForm.CreateNew(Nil,0);
    LoadFromFile(OptionsForm, LFileName);
    OptionsForm.DisableOptionsControls := True;
    OptionsForm.Edit_MethodName.Text := ExtractFileName(ChangeFileExt(LFileName,''));
    OptionsForm.Label_MethodName.Visible := True;
    OptionsForm.Edit_MethodName.Visible := True;
    OptionsForm.RG_MainAlgorithm.ItemIndex := cUserMethodNum;
    if bOptionsShow then OptionsForm.Show;
    OptionsForm.DisableOptionsControls := False;
  end;
  if tmAnnotation>0 then
  begin
    tmAnnotation:=tmAnnotation-1;
//    if tmAnnotation<=0 then
//      ChartTool_Annotation.Visible:=False;
  end;
  if tmMouseScroll>0 then
  begin
    tmMouseScroll:=tmMouseScroll-1;
    MouseEdit.Color := clEditSelect;

    if tmMouseScroll<=0 then
    begin
      MouseEdit.Color:=clWindow;
      bStartMouseScroll := false;
    end;
  end;

  if tmRecalcManual>0 then
  begin
    DisableCalcControls := True;
    try
      OldN1 := ChartTool_N1_Value;
      OldN2 := ChartTool_N2_Value;
      tmRecalcManual:=tmRecalcManual-1;
      if tmRecalcManual=0 then
      begin
        DoFitWithWaitings := OptionsForm.CB_PlusWaitings.Checked and (CDetector.S < MaxS_4WaitingsFit);

 //        if ChartFunction=cfBackGround then
        if CB_FitBG_Auto.Checked then
          if CDetector.FonFound then
            if SFonInterest >= MinS_4FitFon then
              if OptionsForm.CB_FitFon.Checked then
                FonGradientDown; // Фитирование фона

//        if ChartFunction<>cfBackGround then
        if CB_FitPeak_Auto.Checked then
          if CDetector.PeakFound then
            if CDetector.S >= MinS_4Fit then // CalcAuto содержит CalcSquare - счмитает площадь
              if OptionsForm.CB_FitPeak.Checked then
                GradiendDown; // Фитирование пика

        AssignCurrentPeak(CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR);
        PeakSimulationIfNeed;
        CalcShow;   // отображение результатов по расчётам
        CDetector.N1 := OldN1;
        CDetector.N2 := OldN2;
        CalcOut;    // вывод результатов расчётов (в том числе в Excel)
      end;
    finally
      DisableCalcControls := False;
    end;
  end;
  CalcTimer.Enabled := tmLOF or (tmAnnotation>0) or (tmMouseScroll>0) or (tmRecalcManual>0);
end;

procedure TCalcForm.ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
var
  fl,k: Double;
  State : TKeyboardState;
begin
  {$IFDEF MSWINDOWS}
  if Msg.message = WM_MOUSEWHEEL then
  try
    if not bStartMouseScroll then
    begin
      bStartMouseScroll := true;
      Exit;
    end;

    fl := StrToFloatRegion(MouseEdit.Text);

    If (Msg.wParam and $10000000)<>0 then
      k  := 0.1
    else
      k  := -0.1;

    GetKeyboardState(State);
    if ((State[vk_Shift] and 128) <> 0) then k:=k/10;

    if fl=0 then fl := 1;

    fl  := fl + k*fl;
    MouseEdit.Text  := FloatToStrRegionF(fl,ffGeneral,6,3);

    if MouseEdit.Color = clEditSelect
    then MouseEdit.Color := clWindow
    else MouseEdit.Color := clEditSelect;

    tmMouseScroll := 10;

    CalcTimer.Enabled:=True;
  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['ApplicationEventsMessage (Mouse Wheel)',E.Message]));
  end;
  {$ELSE}
  {$ENDIF}
end;

procedure TCalcForm.AssignCurrentFon(aBt, aBx0, aBy0, aBxy0, aBdy: double);
var
  i, j: integer;
begin
  if (DX<0) or (DX>MaxChannels) then Exit;

  // Фон и сглаженные исходные точки минус фон
  for i := 0 to MaxChannels do
  begin
    BuffBackground[i] := FuncBackground(BGFunc, i, aBx0, aBt, aBy0, aBxy0, aBdy);
    BuffAvgWOB[i] := BuffAvg[i] - BuffBackground[i];
  end;

  // Фон и сглаженные исходные точки минус фон + усреднение по 2*DX соседним точкам
  FillChar(BuffWideAvgWOB, SizeOf(BuffWideAvgWOB), 0);
  for i := DX to MaxChannels - DX do
  begin
    for j := i - DX to i + DX do
    // первая производная как разность площади справа и площади слева (площади для увеличения статистики)
      BuffWideAvgWOB[i] := BuffWideAvgWOB[i] + BuffAvgWOB[j];
    BuffWideAvgWOB[i] := BuffWideAvgWOB[i] / (2 * DX + 1);
  end;
  for i := 0 to DX - 1 do // добиваем краешки неравновесной разностью
  begin
    BuffWideAvgWOB[i] := BuffAvgWOB[i]; // средняя точка на начальном участке
    BuffWideAvgWOB[MaxChannels - i] := BuffAvgWOB[MaxChannels - i];
    // средняя точка на конечном участке
    for j := 1 to i do
    begin
      BuffWideAvgWOB[i] := BuffWideAvgWOB[i] + BuffAvgWOB[i + j] + BuffAvgWOB
        [i - j]; // + левый и правый край в начале
      BuffWideAvgWOB[MaxChannels - i] := BuffWideAvgWOB[MaxChannels - i] +
        BuffAvgWOB[MaxChannels - i + j] + BuffAvgWOB[MaxChannels - i - j];
      // + левый и правый край в конце
    end;
    BuffWideAvgWOB[i] := BuffWideAvgWOB[i] / (2 * i + 1);
    BuffWideAvgWOB[MaxChannels - i] := BuffWideAvgWOB[MaxChannels - i] / (2 * i + 1);
  end;
end;

procedure TCalcForm.AssignCurrentGlade;
var
  i, j, r: integer;
  Sum: double;
  n: integer;
  G_Num: integer;
  // Параметр сглаживания - число соседних канало, используемых для сглаживания
  icL, icR: integer;
  Buf1,alpha,cutoff: Double;
  buffAVG2: TDArray;
  bLowPass: boolean;
begin
  G_Num := StrToInt(OptionsForm.EditG_Num.Text);
  case OptionsForm.RG_GladeType.ItemIndex of
    0: // Без сглаживания
      begin
        for i := 0 to MaxChannels do
          BuffAvg[i] := CDetector.BuffPulses[i];
      end;

    1: // По Медведеву-Агриненко-Каракашу (частотное преобразование)
      begin
        icL := 0;
        for i := 0 to MaxChannels do
          if (CDetector.BuffPulses[icL] <> CDetector.BuffPulses[i]) or (i = MaxChannels) then
          begin
            icR := i;
            r := 0;
            for n := icL to icR do
              r := r + CDetector.BuffPulses[n]; // сумма для среднего
            for j := icL to icR do
              BuffAvg[j] := r / (icR - icL + 1);
            icL := icR + 1;
          end;
      end;

    2:
      begin
        if G_Num<0 then Exit;
        for i := 0 to MaxChannels do
        begin
          Sum := 0;
          n := 0;
          for j := 0 to G_Num do
          begin
            if (i + j <= MaxChannels) then
            begin
              Sum := Sum + CDetector.BuffPulses[i + j];
              n := n + 1;
            end;
            if (i - j >= 0) then
            begin
              Sum := Sum + CDetector.BuffPulses[i - j];
              n := n + 1;
            end;
          end;
          if n=0
            then BuffAvg[i]:=CDetector.BuffPulses[i]
            else BuffAvg[i] := Sum / n;
        end;
      end;
    3: // Среднее арифметическое
      begin
        if G_Num<0 then Exit;
        for i := 0 to MaxChannels do
        begin
          Sum := 0;
          n := 0;
          for j := -G_Num to G_Num do
            if (i + j >= 0) and (i + j <= MaxChannels) then
            begin
              Sum := Sum + CDetector.BuffPulses[i + j];
              n := n + 1;
            end;
          if n=0
            then BuffAvg[i]:=CDetector.BuffPulses[i]
            else BuffAvg[i] := Sum / n;
        end;
      end;


    4: // По Медведеву-Агриненко-Каракашу-Чернышеву
      begin
        icL := 0;
        for i := 0 to MaxChannels do
          if (CDetector.BuffPulses[icL] <> CDetector.BuffPulses[i]) or (i = MaxChannels) then
          begin // при любом изменении величины останавливаем накопление отрезка
            icR := i; // правый край отрезка - первое изменённое значение
            r := 0;
            for n := icL to icR do
              r := r + CDetector.BuffPulses[n]; // сумма значений отрезка для подсчёта среднего
            for j := icL to icR do
              BuffAvg[j] := r / (icR - icL + 1); // присваиваем среднее всем значениям отрезка
            if (icR<MaxChannels) and (icR>0) and ((CDetector.BuffPulses[icR] - CDetector.BuffPulses[icR - 1]) *
              (CDetector.BuffPulses[icR + 1] - CDetector.BuffPulses[icR]) > 0) and
              (icR - icL = 1) then // для быстрых изменений нужно поступать иначе
            // монотонные изменения на отрезке в 2 канала
            begin
              BuffAvg[icL] := CDetector.BuffPulses[icL];
              BuffAvg[icR] := CDetector.BuffPulses[icR];
            end;
            icL := icR + 1; // следующая левая граница отрезка начинается справа от правой границы текущего отрезка
            if icL>MaxChannels then icL:=MaxChannels;
          end;
// дополнительная коррекция начального участка (важно - так как он используется для поиска y0)
// когда серия 0 и редкие 1 на начальном участке становится важна фаза, если её не учитывать - будем иметь разброс от правильного минимального значения до 1
// попробуем заменить первый начальный участок (например 01) = 0.5 на второй (например 000000001) = 0.1

        icL := 0;
        if BuffAvg[0] <= 1 then
        for i := 1 to MaxChannels do
        begin
          if (BuffAvg[i] > 1) then break;
          if BuffAvg[i] <> BuffAvg[0] then
          begin
            iCL := i;
            break;
          end;
        end;
        for i := 0 to iCL-1 do
          BuffAvg[i] := BuffAvg[iCL];
      end;

    5: // Статистическое среднее
      for i := 0 to MaxChannels do
      begin
        r := 20;
        Sum := CDetector.BuffPulses[i];
        n := 1;
        for j := 1 to r do
        begin
          if i - j >= 0 then
            Sum := Sum + CDetector.BuffPulses[i - j]
          else
            Sum := Sum + CDetector.BuffPulses[i];
          if i + j <= MaxChannels then
            Sum := Sum + CDetector.BuffPulses[i + j]
          else
            Sum := Sum + CDetector.BuffPulses[i];
          n := n + 2;
          if Sum > G_Num then
            break;
        end;
        BuffAvg[i] := Sum / n;
      end;

    6: // Ступеньки
      begin
        if G_Num<=0 then Exit;
        for i := 0 to MaxChannels div G_Num do
        begin
          Sum := 0;
          for j := 0 to G_Num-1 do
            Sum := Sum + CDetector.BuffPulses[i*G_Num + j];
          for j := 0 to G_Num-1 do
            BuffAvg[i*G_Num + j] := Sum/G_Num;
        end;
      end;

    7: // По Медведеву-Агриненко-Каракашу-Чернышеву ++ + статистическое среднее
      begin
        icL := 0;
        for i := 0 to MaxChannels do
          if (CDetector.BuffPulses[icL] <> CDetector.BuffPulses[i]) or (i = MaxChannels) then
          begin
            icR := i;
            r := 0;
            for n := icL to icR do
              r := r + CDetector.BuffPulses[n]; // сумма для среднего
            for j := icL to icR do
              BuffAvgWOB[j] := r / (icR - icL + 1);
            if ((CDetector.BuffPulses[icR] - CDetector.BuffPulses[icR - 1]) *
              (CDetector.BuffPulses[icR + 1] - CDetector.BuffPulses[icR]) > 0) and
              (icR - icL = 1) then
            // монотонные изменения на отрезке в 2 канала
            begin
              BuffAvgWOB[icL] := CDetector.BuffPulses[icL];
              BuffAvgWOB[icR] := CDetector.BuffPulses[icR];
            end;
            icL := icR + 1;
            if icL>MaxChannels then icL:=MaxChannels;
          end;

        for i := 0 to MaxChannels do
        begin
          r := 20;
          Sum := BuffAvgWOB[i];
          n := 1;
          for j := 1 to r do
          begin
            if i - j >= 0 then
              Sum := Sum + BuffAvgWOB[i - j]
            else
              Sum := Sum + BuffAvgWOB[i];
            if i + j <= MaxChannels then
              Sum := Sum + BuffAvgWOB[i + j]
            else
              Sum := Sum + BuffAvgWOB[i];
            n := n + 2;
            if Sum > G_Num then
              break;
          end;
          BuffAvg[i] := Sum / n;
        end;
      end;
  end;

  bLowPass := OptionsForm.CB_UseLowPassFilter.Checked;
  if bLowPass then
  begin
    cutoff := StrToInt(OptionsForm.Edit_LowPassFilterAlfa.Text);
    if (cutoff=0) then Exit;
    for i := 0 to MaxChannels do
      BuffAvg2[i] := BuffAvg[i];
    alpha := 1 / (2 * Pi * cutoff);
    for i := 1 to MaxChannels do
      BuffAvg[i] := alpha * BuffAvg2[i] + (1 - alpha) * BuffAvg[i-1];
  end;
end;

procedure TCalcForm.AssignCurrentPeak(aGM1, aDGM2, aGA1, aDGA2, aGSL, aGSR: double);
var
  vg: TParamArray;
  i: integer;
begin
  vg[1] := aGM1;
  vg[2] := aDGM2;
  vg[3] := aGA1;
  vg[4] := aDGA2;
  vg[5] := aGSL;
  vg[6] := aGSR;

  for i := 0 to MaxChannels do // выводим в TChart
  try
    Peak_R1[i] := FuncDGaussR1(i, vg);
    Peak_R2[i] := FuncDGaussR2(i, vg);
    BuffDGauss[i] := Peak_R1[i] + Peak_R2[i];
  except
    Peak_R1[i] := 0;
    Peak_R2[i] := 0;
    BuffDGauss[i] := 0;
  end;

  // Разные алгоритмы подсчёта площади (0 - 4 полугаусса, 1 - правый полугаусс, 2 - амплитуда, 3 - площадь над фоном)
  case OptionsForm.RG_TypeS.ItemIndex of
    0:
      CDetector.SA5 := SQRT(2 * Pi) * CDetector.GA1 * (CDetector.GSL + CDetector.GSR) / 2;
    1:
      CDetector.SA5 := SQRT(2 * Pi) * CDetector.GA1 * (CDetector.GSR * 1.36);
      // 1.25 компенсация более широкого GSL
    2:
      CDetector.SA5 := SQRT(2 * Pi) * CDetector.GA1 * 14; // Волюнтаризм
    3:
      CDetector.SA5 := CDetector.S  //как-будто пик не найден
  end;

  // S -  без пика - площадь оценена ранее
  CDetector.S := CDetector.SA5;
  vg[1] := CDetector.GM1;
  vg[2] := CDetector.DGM2;
  vg[3] := CDetector.GA1;
  vg[4] := CDetector.DGA2;
  vg[5] := CDetector.GSL;
  vg[6] := CDetector.GSR;

  CDetector.Err := Hi2_Func(vg);
end;

procedure TCalcForm.Btn_ClearWarningClick(Sender: TObject);
begin
  OutEnum := outGood;
  ChartSubFooter:='';
  Btn_ClearWarning.Visible := False;
  CDetector.Comment := '';
  Btn_Save.Enabled := True;
  SB_UserWarning.Visible := True;
end;

procedure TCalcForm.SB_UserOptionsClick(Sender: TObject);
begin
  MenuOptions.Popup(CalcForm.left + PanelChart.left + PanelInChart.Left + SB_UserOptions.Left ,CalcForm.Top + PanelChart.Top + PanelInChart.Top + SB_UserOptions.Top);
end;

procedure TCalcForm.Btn_FitClick(Sender: TObject);
begin
  GradiendDown;
  ChangeOptions(Sender);
end;

procedure TCalcForm.Btn_FitFonClick(Sender: TObject);
begin
  DisableCalcControls := True;
  BG_Start := StrToIntRegion(Edit_BN2.Text);// Round(ChartTool_Region_BN2.StartValue);
  BG_End := StrToIntRegion(Edit_BN2.Text) + StrToIntRegion(Edit_BN2_width.Text);// Round(ChartTool_Region_BN2.EndValue);
  if BG_Start>MaxChannels then BG_Start:=MaxChannels;
  if BG_End>MaxChannels then BG_End:=MaxChannels;
  FonGradientDown; // Фитирование фона

  Btn_FitPeakClick(Sender);

  CalcShow;
  CalcOut;
  DisableCalcControls := False;
end;

procedure TCalcForm.Btn_FitPeakClick(Sender: TObject);
begin
  DisableCalcControls := True;

  CDetector.N1 := StrToInt(Edit_N1.Text); //  CDetector.N1 := ChartTool_N1.Value;
  CDetector.N2 := StrToInt(Edit_N2.Text); //  CDetector.N2 := ChartTool_N2.Value;

  DoFitWithWaitings := OptionsForm.CB_PlusWaitings.Checked and (CDetector.S < MaxS_4WaitingsFit);

  GradiendDown; // Фитирование пика
  AssignCurrentPeak(CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR);
  CalcShow;
  CalcOut;
  DisableCalcControls := False;
end;

procedure TCalcForm.Btn_FonFitClick(Sender: TObject);
begin
  FonGradientDown;
  ChangeOptions(Sender);
end;

procedure TCalcForm.Btn_GetDefaultClick(Sender: TObject);
var
  dcnt : integer;
begin
  dcnt := MainForm.Dosimeter.DetectorsCnt;
  SetDefaultOptions(CDetector);
  if OptionsForm.Showing then OptionsForm.Close;

  CalcType := ccFromDB;

  MainForm.GetMeasData;
  LoadData(TDetector(MainForm.Dosimeter.DetectorsList[CDetector.Position-1]));
  MainForm.Dosimeter.DetectorsCnt := dcnt;

  CalcForm.CalcType := ccFromDB;

//  ChartCalc.UndoZoom;
end;

procedure TCalcForm.BigPeakCorrection;
begin
  CDetector.S := CDetector.S;
  //  CDetector.S := 10499.79*(SQRT(1+0.000195*CDetector.S/CDetector.K*FilterKoeff)-1));
end;

procedure TCalcForm.BtnOptionsClick(Sender: TObject);
begin
  OptionsForm.Show;
end;

procedure TCalcForm.Btn_SaveClick(Sender: TObject);
begin
  if not PanelChart.Visible then Exit;

  if OptionsForm.CB_SaveToExcel.Checked then
  try
    if OptionsForm.RBtnAll.Checked then
      SaveToExcel(eoAll);
    if OptionsForm.RBtnGroupByDos.Checked then
      SaveToExcel(eoByDosimeter);
    if OptionsForm.RBtnGroupByComment.Checked then
      SaveToExcel(eoByComment);
  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['Btn_SaveClick (Save to Excel)',E.Message]));
  end;

  CDetector.AutoProcessing := (CalcForm.CalcType <> ccManual) and not bOptionsChanged;

  MainForm.UpdateDetectorGausFon(CDetector.Position); //**

  MainForm.RecalcDetectorsDose;
  MainForm.RecalcDosimeterDose;

  CalcForm.CalcType := ccFromDB;
  CalcOut;

  LoadData(TDetector(MainForm.Dosimeter.DetectorsList[CDetector.Position-1]));
end;

procedure TCalcForm.SaveCalcImage(aSubDir,aName: String);
var
//  JpegIm: TJpegImage;
  bm: TBitMap;
  Dir: String;
begin
  Dir := extractfilepath(Application.ExeName) + 'ScreenShots'+PathDelim + aSubDir + PathDelim;
  ForceDirectories(Dir);
  bm := TBitMap.Create;
  bm.Width := CalcForm.Width + 16; // запас (компенсация странного глюка)
  bm.Height := CalcForm.Height + 59; // запас (компенсация странного глюка)
//  bm.Width := CalcForm.ClientWidth;
//  bm.Height := CalcForm.ClientHeight;
  CalcForm.PaintTo(bm.Canvas, 0, 0);
//  BitBlt(bm.Canvas.Handle, 0, 0, bm.Width, bm.Height, GetDC(CalcForm.Handle), 0, 0, SRCCOPY);
//  JpegIm := TJpegImage.Create;
//  JpegIm.Assign(bm);
//  JpegIm.CompressionQuality := 20;
//  JpegIm.Compress;
//  JpegIm.SaveToFile(Dir + aName + '.jpg');

  bm.SaveToFile(Dir + aName +  '.png');

  bm.Destroy;
//  JpegIm.Destroy;
end;

var
  StartDrag: boolean = false;
  DragType: (dragNone,dragN1,dragN2,dragBN1_L,dragBN2_L,dragBN1,dragBN2,dragBN1_R,dragBN2_R) = dragN1;
procedure TCalcForm.ChartCalcMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ix,diy,iy: double;
  CF : TChartFunction;

begin
  try
    begin
      ix := ChartCalc.XImageToGraph(X);
      //      if (Round(ix)<0) or (Round(ix)>MaxChannels) then Exit;
      if (ix<0) then ix:=0;
      if ix>MaxChannels then ix:=MaxChannels;

      diy := ChartCalc.YImageToGraph(Y); // 0 - 1 от шкалы (ибо используются трансформации шкал)
      iy := ChartCalc.LeftAxis.GetTransform.GraphToAxis(diy); // вычисление из 0 - 1 адекватного значения по левой шкале

      CF := cfNone;
      if (iy <= SeriesFon.YValue[round(ix)])
         or ((ix>=CDetector.BN1) and (ix<=CDetector.BN1 + CDetector.BN1_width))
         or ((ix>=CDetector.BN2) and (ix<=CDetector.BN2 + CDetector.BN2_width))
      then CF := cfBackGround
      else
        if (iy <= SeriesGlade.YValue[round(ix)]+1)
           and (ix>=StrToInt(Edit_N1.Text))
           and (ix<=StrToInt(Edit_N2.Text))
        then CF := cfPeak;
      ChartFunction := CF;
    end;
  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['ChartCalcMouseDown',E.Message]));
  end;

  ChartCalcMouseMove(Sender, [], X,Y);
  StartDrag:= true;
end;

var
  IHaveRightToChangeByScroll: boolean = false;
procedure TCalcForm.ChartCalcMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  XN1, XN2: integer;
begin
  if StartDrag then ShowLinesWhenDrag(X, Y, false);

  if StartDrag then Exit;
  if not ChartTool_N_Active then Exit;

  DragType:=dragNone;

  XN1:=ChartCalc.XGraphToImage(ChartTool_N1_Value);
  if Abs(XN1-X)<3 then
  begin
    DragType:=DragN1;
    ChartCalc.Cursor:=crHSplit;
  end;

  XN2:=ChartCalc.XGraphToImage(ChartTool_N2_Value);
  if Abs(XN2-X)<3 then
  begin
    DragType:=DragN2;
    ChartCalc.Cursor:=crHSplit;
  end;

  XN1:=ChartCalc.XGraphToImage(ChartTool_BN1_Value);
  XN2:=ChartCalc.XGraphToImage(ChartTool_BN1_Value + ChartTool_BN1_Width);
  if (X>XN1-3) and // область BN1
     (X<XN2+3) then
  begin
    if X<=XN1 then
    begin
      DragType:=DragBN1_L;
      ChartCalc.Cursor:=crSizeE;
    end
      else
        if X>=XN2 then
        begin
          DragType:=DragBN1_R;
          ChartCalc.Cursor:=crSizeW;
        end
          else
          begin
            DragType:=DragBN1;
            ChartCalc.Cursor:=crDrag; //crHSplit
          end;
  end;

  XN1:=ChartCalc.XGraphToImage(ChartTool_BN2_Value);
  XN2:=ChartCalc.XGraphToImage(ChartTool_BN2_Value + ChartTool_BN2_Width);
  if (X>XN1-3) and // область BN2
     (X<XN2+3) then
  begin
    if X<=XN1 then
    begin
      DragType:=DragBN2_L;
      ChartCalc.Cursor:=crSizeE;
    end
      else
        if X>=XN2 then
        begin
          DragType:=DragBN2_R;
          ChartCalc.Cursor:=crSizeW;
        end
          else
          begin
            DragType:=DragBN2;
            ChartCalc.Cursor:=crDrag; //crHSplit
          end;
  end;

  if DragType=dragNone then ChartCalc.Cursor := crDefault;

end;

procedure TCalcForm.ShowLinesWhenDrag( X, Y: Integer; reCalc: boolean);
var
  XN:  integer;
  Buf: real;
begin
  try
    XN:=Round(ChartCalc.XImageToGraph(X));
    if (XN<0) then XN:=0;
    if (XN>MaxChannels) then XN:=MaxChannels;
    if not reCalc and not Assigned(CDetector) then Exit; // перестраховка

    case DragType of
    DragN1:
      begin
        if reCalc
        then Edit_N1.Text:=IntToStr(XN) // с пересчётом
        else CDetector.N1 := XN;  // без пересчёта
      end;
    DragN2:
      begin
        if reCalc
        then Edit_N2.Text:=IntToStr(XN) // с пересчётом
        else CDetector.N2 := XN;  // без пересчёта
      end;
    DragBN1_L:
      begin
        Buf:=ChartTool_BN1_Width + ChartTool_BN1_Value - XN;
        if Buf>=1 then
        begin
          if reCalc then
          begin
            Edit_BN1_width.Text:=IntToStr(Round(Buf));
            Edit_BN1.Text:=IntToStr(XN);
          end
          else  // без пересчёта
          begin
            CDetector.BN1_width := Round(Buf);
            CDetector.BN1 := XN;
          end;
        end;
      end;
    DragBN2_L:
      begin
        Buf:=ChartTool_BN2_Width + ChartTool_BN2_Value - XN;
        if Buf>=1 then
        begin
          if reCalc then
          begin
            Edit_BN2_width.Text:=IntToStr(Round(Buf));
            Edit_BN2.Text:=IntToStr(XN);
          end
          else  // без пересчёта
          begin
            CDetector.BN2_width := Round(Buf);
            CDetector.BN2 := XN;
          end;
        end;
      end;
    DragBN1:
      begin
        if reCalc
        then Edit_BN1.Text:=IntToStr(Round(XN - ChartTool_BN1_Width/2))
        else CDetector.BN1 := Round(XN - ChartTool_BN1_Width/2);  // без пересчёта
      end;
    DragBN2:
      begin
        if reCalc
        then Edit_BN2.Text:=IntToStr(Round(XN - ChartTool_BN2_Width/2))
        else CDetector.BN2 := Round(XN - ChartTool_BN2_Width/2);  // без пересчёта
      end;
    DragBN1_R:
      begin
        Buf := XN-ChartTool_BN1_Value;
        if Buf>1 then
          if reCalc
          then Edit_BN1_width.Text:=IntToStr(Round(Buf))
          else CDetector.BN1_width := Round(Buf);  // без пересчёта
      end;
    DragBN2_R:
      begin
        Buf := XN-ChartTool_BN2_Value;
        if Buf>1 then
          if reCalc
          then Edit_BN2_width.Text:=IntToStr(Round(Buf))
          else CDetector.BN2_width := Round(Buf);  // без пересчёта
      end;
    end;

    if not reCalc and (DragType<>DragNone) then ChartCalc.Refresh; // обновление картинки

  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['ShowLinesWhenDrag',E.Message]));
  end;
end;

procedure TCalcForm.ChartCalcMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if StartDrag then
  begin
    ChartCalc.Cursor:=crDefault;
    StartDrag:=false;
    ShowLinesWhenDrag(X, Y, true);
  end;
end;

{
procedure LockControl(c: TWinControl; bLock: Boolean);
begin
  if (c = nil) or (c.Handle = 0) then Exit;
  if bLock then
    SendMessage(c.Handle, WM_SETREDRAW, 0, 0)
  else
  begin
    SendMessage(c.Handle, WM_SETREDRAW, 1, 0);
    RedrawWindow(c.Handle, nil, 0,
      RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
  end;
end;
}
var
  IHaveRightToChangeSigmas: boolean = false;
procedure TCalcForm.ChartCalcMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  __DX,DY: double;
  XOfs, YOfs: integer;
  MyWheelDelta: real;
  OtstupY: real;
begin
{
  if not IHaveRightToChangeSigmas then Exit;

  XOfs := CalcForm.Left + ChartCalc.Left;
  YOfs := CalcForm.Top + ChartCalc.Top;

  _DX := SeriesSRC.XScreenToValue(MousePos.X - XOfs);
  DY := ChartCalc.Height - (MousePos.Y - YOfs);
  OtstupY := ChartCalc.Height / 4;

// изменение колесом фона
  if ChartFunction = cfBackGround then
  begin

    if DY <= OtstupY then
      if _DX <= ChartTool_Region_BN1.StartValue then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := EditBxy0;
        Exit;
      end;

    if DY <= OtstupY then
      if _DX >= ChartTool_Region_BN1.StartValue then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := EditBx0;
        Exit;
      end;

    if DY >= OtstupY then
      if _DX <= ChartTool_Region_BN1.StartValue then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := EditBy0;
        Exit;
      end;

    if DY >= OtstupY then
      if _DX >= ChartTool_Region_BN2.StartValue then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := EditBdy;
        Exit;
      end;

    if DY > OtstupY then
      if _DX >= ChartTool_Region_BN1.StartValue then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := EditBt;
        Exit;
      end;
  end;

// изменение колесом пика
  if ChartFunction = cfPeak then
  begin
  // GA1
    if (MousePos.Y - YOfs) <= OtstupY then // сверху
      if _DX >= ChartTool_Peak4_X.Value then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := Edit_GA1;
        Exit;
      end;

  // DGA2
    if (MousePos.Y - YOfs) <= OtstupY then // сверху
      if _DX <= ChartTool_Peak4_X.Value then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := Edit_DGA2;
        Exit;
      end;

  // GM1
    if DY <= OtstupY then
      if _DX >= ChartTool_Peak4_X.Value then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := Edit_GM1;
        Exit;
      end;

  // DGM2
    if DY <= OtstupY then
      if _DX <= ChartTool_Peak4_X.Value then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := Edit_DGM2;
        Exit;
      end;

  // GSL
//    if DY >= OtstupY then
      if _DX <= ChartTool_Peak4_X.Value then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := Edit_GSL;
        Exit;
      end;
  // GSR
//    if DY >= OtstupY then
      if _DX >= ChartTool_Peak4_X.Value then
      begin
        if tmMouseScroll<=0 then
          MouseEdit := Edit_GSR;
        Exit;
      end;

  // GA1
  // GSL
//    if DY >= OtstupY then
  end;

// изменение колесом границ
  if ChartFunction = cfNone then
  begin
  // N_Delimiter
    if _DX <= (ChartTool_N1.Value + ChartTool_N2.Value)/2 then
    begin
      if tmMouseScroll<=0 then
        MouseEdit := Edit_N1;
      Exit;
    end;
// N2
    if _DX >= (ChartTool_N1.Value + ChartTool_N2.Value)/2 then
    begin
      if tmMouseScroll<=0 then
        MouseEdit := Edit_N2;
      Exit;
    end;
  end;
}
end;

procedure TCalcForm.CheckAll(aiWaitingPeakCentre: integer; aDetector: TDetector);
begin
  OutEnum := outGood;
  CDetector.Comment := '';

  CheckFon(CDetector.Bx0,CDetector.Bt,CDetector.By0);
  CDetector.FonFound := OutEnum <> outBad;

  if CDetector.PeakFound then CheckPeakDGauss(aiWaitingPeakCentre,CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR);
end;

procedure TCalcForm.FormDestroy(Sender: TObject);
var
  ConfigIni: TInifile;
begin
  ConfigIni := TInifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  // создаем ini файл и пишем туда информацию
  ConfigIni.WriteInteger('CalcForm', 'X', CalcForm.Left);
  ConfigIni.WriteInteger('CalcForm', 'Y', CalcForm.Top);
  ConfigIni.WriteInteger('CalcForm', 'Width', CalcForm.Width);
  ConfigIni.WriteInteger('CalcForm', 'Height', CalcForm.Height);
  ConfigIni.WriteBool('CalcForm', 'SavePosition', bCalcForm_SavePosition);

  ConfigIni.Free;
end;

procedure TCalcForm.ChartToolset1LegendClickTool1Click(ASender: TChartTool;
  ALegend: TChartLegend);
begin
//  ShowMessage('Legend');
  PopupMenu_ChooseSeries.PopUp;
end;

procedure TCalcForm.ChartToolset1UserDefinedTool1AfterMouseDown(
  ATool: TChartTool; APoint: TPoint);
var
  ix,iy: double;
  CF : TChartFunction;
begin
{
  try
    begin
      ix := ChartCalc.XImageToGraph(Apoint.X);
      iy := ChartCalc.YImageToGraph(Apoint.Y);
      CF := cfNone;
      if (ix>=0) and (ix<=MaxChannels) then
      begin
        if (iy <= SeriesFon.YValue[round(ix)]) or (Abs(ix-StrToInt(Edit_BN1.Text))<5) or ((ix>=StrToInt(Edit_BN2.Text)) and (ix<=StrToInt(Edit_BN2.Text)+StrToInt(Edit_BN2_width.Text)))
        then CF := cfBackGround
        else
          if (iy <= SeriesGlade.YValue[round(iy)]) and (ix>=StrToInt(Edit_N1.Text)) and (ix<=StrToInt(Edit_N2.Text)) then CF := cfPeak;
      end;
      ChartFunction := CF;
    end;
  except
  end;
}
end;

procedure TCalcForm.SetInterfaceByPermits;
var
  bRight   : boolean;
  i        : integer;
begin
  try
  // Открыть окно настройки автоматического алгоритма и разрешить внутренние настройки
    //bRight := AW.IsHaveIRight(crCalc_Algorithm_Edit);
    BtnOptions.Visible := AW.IsHaveIRight(crCalc_Algorithm_Edit);//bRight;
    SB_UserOptions.Visible := AW.IsHaveIRight(crCalc_Ranges_Edit);//bRight;

  // Ручное редактирование коэффициентов Bt,Bx0,By0,GA1,GM1.... в полях ввода
    PC_ChartFunction.Visible      :=  bCalcForm_ParametersPanel;

  // Ручное редактирование зоны интереса CDetector.N1,CDetector.N2 в полях ввода
    bCalcForm_EditRange_Change := bCalcForm_EditRange_Change and AW.IsHaveIRight(crCalc_Ranges_Edit); // если нет прав, то нет ...
//    ChartTool_N1.Active := bCalcForm_EditRange_Change;
//    ChartTool_N2.Active := bCalcForm_EditRange_Change;
    ChartTool_N_Active  := bCalcForm_EditRange_Change;
    Edit_N1.Enabled     :=  bCalcForm_EditRange_Change;
    Edit_N2.Enabled     :=  bCalcForm_EditRange_Change;


//    ChartTool_N1.Active := bCalcForm_VisualRange_View;
//    ChartTool_N2.Active := bCalcForm_VisualRange_View;

    CB_WOFon.Visible := bCalcForm_cbWOFon_View;

    Edit_S.Visible := bCalcForm_Dose_View;
    Label_S.Visible := bCalcForm_Dose_View;

    Edit_Err.Visible := bCalcForm_Err_View;
    Label_Err.Visible := bCalcForm_Err_View;

    if bCalcForm_Menu_View
      then CalcForm.Menu := MainMenu
      else CalcForm.Menu := Nil;

    IHaveRightToChangeByScroll := bCalcForm_VisualChangers_Use; // MouseWheel может быть тоже использован только при наличии прав

//    ChartTool_N1.AllowDrag := bCalcForm_VisualRange_Use;
//    ChartTool_N2.AllowDrag := bCalcForm_VisualRange_Use;
    ChartTool_N_AllowDrag := bCalcForm_VisualRange_Use;
//    ChartTool_Region_BN1.AllowDrag := bCalcForm_VisualRange_Use;
//    ChartTool_Region_BN2.AllowDrag := bCalcForm_VisualRange_Use;
//    ChartTool_Region_BN1.StartLine.AllowDrag := bCalcForm_VisualRange_Use;
//    ChartTool_Region_BN2.StartLine.AllowDrag := bCalcForm_VisualRange_Use;
//    ChartTool_Region_BN1.EndLine.AllowDrag := bCalcForm_VisualRange_Use;
//    ChartTool_Region_BN2.EndLine.AllowDrag := bCalcForm_VisualRange_Use;

// Только для суперадминов
    NOptShowMenu.Visible:= AW.IsHaveIRight(crALL_DOZA_MANUFACTURER);
    bCalcForm_EditChart := bCalcForm_EditChart and NOptShowMenu.Visible;
    SB_EditChart.Visible:= bCalcForm_EditChart;
    ChartCalc.AllowZoom := bCalcForm_EditChart;

    NOptShowChartEdit.Visible:= AW.IsHaveIRight(crALL_DOZA_MANUFACTURER);
    bCalcForm_Menu_View := bCalcForm_Menu_View and NOptShowChartEdit.Visible;

    NOptShowNegativeDoses.Visible:= AW.IsHaveIRight(crALL_DOZA_MANUFACTURER);
    bCalcForm_ShowNegativeDose := bCalcForm_ShowNegativeDose and NOptShowNegativeDoses.Visible;

    NOptUnSaveNotifyOff.Visible:= AW.IsHaveIRight(crALL_DOZA_MANUFACTURER);
    bCalcForm_ExitNotifyIfManualChange := bCalcForm_ExitNotifyIfManualChange or not NOptUnSaveNotifyOff.Visible;

    NOptDefault.Visible := bCalcForm_SavePosition or  // видимо, если не дефолтные значения
                           bCalcForm_ParametersPanel or
                       not bCalcForm_EditRange_Change or
                           bCalcForm_VisualChangers_View or
                           bCalcForm_VisualChangers_Annotation or
                       not bCalcForm_VisualRange_View or
                       not bCalcForm_VisualRange_Use or
                       not bCalcForm_cbWOFon_View or
                       not bCalcForm_Dose_View or
                           bCalcForm_Err_View or
                           bCalcForm_Menu_View or
                           bCalcForm_VisualChangers_Use or
                           bCalcForm_EditChart or
                       not bCalcForm_ExitNotifyIfManualChange or
                           bCalcForm_ShowNegativeDose or
                           bCalcForm_EditByScroll;

    Label_ViewOptions.Visible := SB_EditChart.Visible or SB_UserOptions.Visible;

  finally
  end;

  ChartFunction := cfNone;
  NOpt_CorrectDelimiters;
//  ChartCalc.UndoZoom;
end;

{
procedure TCalcForm.SetInterfaceByPermits;
var
  bRight   : boolean;
  ConfigIni :Tinifile;
begin
  ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
  // Ручное редактирование коэффициентов Bt,Bx0,By0,GA1,GM1.... в полях ввода
    PC_ChartFunction.Visible      :=  bCalcForm_ParametersPanel;

  // Ручное редактирование зоны интереса CDetector.N1,CDetector.N2 в полях ввода
    bCalcForm_EditRange_Change := ConfigIni.ReadBool('CalcForm', 'EditRange_Change', bCalcForm_EditRange_Change);
      ChartTool_N_Active := bCalcForm_EditRange_Change;
      Edit_N1.Enabled     :=  bCalcForm_EditRange_Change;
      Edit_N2.Enabled     :=  bCalcForm_EditRange_Change;

    bCalcForm_VisualChangers_View := ConfigIni.ReadBool('CalcForm', 'VisualChangers_View', bCalcForm_VisualChangers_View);
//      ChartTool_Peak5_X.Active := bCalcForm_VisualChangers_View;
//      ChartTool_Peak5_Y.Active := bCalcForm_VisualChangers_View;
//      ChartTool_Peak4_X.Active := bCalcForm_VisualChangers_View;
//      ChartTool_Peak4_Y.Active := bCalcForm_VisualChangers_View;

    bCalcForm_VisualChangers_Annotation := ConfigIni.ReadBool('CalcForm', 'VisualChangers_Annotation', bCalcForm_VisualChangers_Annotation);
//      ChartTool_Peak5_X.AnnotationValue := bCalcForm_VisualChangers_Annotation;
//      ChartTool_Peak5_Y.AnnotationValue := bCalcForm_VisualChangers_Annotation;
//      ChartTool_Peak4_X.AnnotationValue := bCalcForm_VisualChangers_Annotation;
//      ChartTool_Peak4_Y.AnnotationValue := bCalcForm_VisualChangers_Annotation;

    bCalcForm_VisualRange_View := ConfigIni.ReadBool('CalcForm', 'VisualRange_View', bCalcForm_VisualRange_View);
      ChartTool_N_Active := bCalcForm_VisualRange_View;

    bCalcForm_cbWOFon_View := ConfigIni.ReadBool('CalcForm', 'cbWOFon_View', bCalcForm_cbWOFon_View);
      CB_WOFon.Visible := bCalcForm_cbWOFon_View;

    bCalcForm_S_View := ConfigIni.ReadBool('CalcForm', 'S_View', bCalcForm_S_View);
      Edit_S.Visible := bCalcForm_S_View;
      Label_S.Visible := bCalcForm_S_View;

    bCalcForm_Err_View := ConfigIni.ReadBool('CalcForm', 'Err_View', bCalcForm_Err_View);
      Edit_Err.Visible := bCalcForm_Err_View;
      Label_Err.Visible := bCalcForm_Err_View;

    bCalcForm_Menu_View := ConfigIni.ReadBool('CalcForm', 'Menu_View', bCalcForm_Menu_View);
      if bCalcForm_Menu_View
        then CalcForm.Menu := MainMenu
        else CalcForm.Menu := Nil;

    bCalcForm_VisualChangers_Use := ConfigIni.ReadBool('CalcForm', 'VisualChangers_Use', bCalcForm_VisualChangers_Use);
//      ChartTool_Peak5_X.AllowDrag := bCalcForm_VisualChangers_Use;
//      ChartTool_Peak5_Y.AllowDrag := bCalcForm_VisualChangers_Use;
//      ChartTool_Peak4_X.AllowDrag := bCalcForm_VisualChangers_Use;
//      ChartTool_Peak4_Y.AllowDrag := bCalcForm_VisualChangers_Use;
      IHaveRightToChangeSigmas := bCalcForm_VisualChangers_Use; // MouseWheel может быть тоже использован только при наличии прав

    bCalcForm_VisualRange_Use := ConfigIni.ReadBool('CalcForm', 'VisualRange_Use', bCalcForm_VisualRange_Use);
      ChartTool_N_AllowDrag := bCalcForm_VisualRange_Use;

//    bCalcForm_EditChart := ConfigIni.ReadBool('CalcForm', 'EditChart', bCalcForm_EditChart);
//      SB_EditChart.Visible := bCalcForm_EditChart and AW.IsHaveIRight(crALL_DOZA_MANUFACTURER);

//    Label_ViewOptions.Visible := SB_EditChart.Visible or SB_UserOptions.Visible;

  finally
  end;

// Открыть окно настройки автоматического алгоритма
  bRight := AW.IsHaveIRight(crCalc_Algorithm_Edit);
    BtnOptions.Visible := bRight;

// Запись в базу данных
  bRight := AW.IsHaveIRight(crCalc_Measure_Edit);
    Btn_Save.Visible := bRight;
  ChartFunction := cfNone;
//  ChartCalc.UndoZoom;
end;
}

procedure TCalcForm.SetVLE_Float(aParamName: String; aValue: double);
var
  St: String;
begin
  OptionsForm.DisableOptionsControls := True;
  St := FloatToStr(aValue);
  OptionsForm.VLE.Values[aParamName] := St;
  OptionsForm.DisableOptionsControls := False;
end;

procedure TCalcForm.CB_WOFonClick(Sender: TObject);
begin
  ChangeOptions(Sender);
end;

procedure TCalcForm.CheckFon(aBx0, aBt, aBy0: double);
var
  kBx0_Min: real;
  addErrBx0,addErrBt,addErrBy0 : real;
begin
  if OptionsForm.RG_BackgroundFunction.itemIndex = 2 then Exit; // Для пустой фоновой функции не делаем проверок

  addErrBx0 := 0;
  addErrBt  := 0;
  addErrBy0 := 0;
  if OptionsForm.ECS_Adaptive.Checked then // подготовка коэффициентов адаптивности (для учёта взаимовлияний)
  begin
    if pos('TEST',UpperCase(CDetector.DetType))>0 then // измерения при тестировании - переотожжённые детекторы
    begin
      addErrBx0 := 800;
      addErrBt  := 1000;
      addErrBy0 := 0;
    end;
    if (CDetector.S>1000) then
    begin
      kBx0_Min := log10(CDetector.S)-2;  // подъём фона раньше при больших пиках (эмпирика и волюнтаризм)
      addErrBx0 := 100 * kBx0_Min;
      addErrBy0 := 30*kBx0_Min;
    end;
    if OptionsForm.RG_MainAlgorithm.itemIndex = 1 then // подготовка коэффициентов адаптивности (для учёта взаимовлияний)
    begin // 10-280
      addErrBy0 := max(addErrBy0 , OCW_Min[cvBy0] + 0.1);   // там норма By0=0 - это пресечёт возникновение ошибки
      addErrBy0 := max(addErrBy0 , OCE_Min[cvBy0] + 0.1);   // там норма By0=0 - это пресечёт возникновение ошибки
      if (CDetector.S>700) then addErrBx0 := 1001;   // при больших пиках края загибаются в противоположную сторону, по алгоритму это Bx=1000 - отключаем контроль
    end;
    if OptionsForm.RG_MainAlgorithm.itemIndex = 2 then // подготовка коэффициентов адаптивности (для учёта взаимовлияний)
      addErrBy0 := CDetector.S / 300;
  end;

  // warning
  if (aBt <= OCW_Min[cvBt] - addErrBt) or (aBt >= OCW_Max[cvBt] + addErrBt) then
    OutDetail(outWarning, rsCheckFonSlant);
  if (aBx0 <= OCW_Min[cvBx0] - addErrBx0) or (aBx0 >= OCW_Max[cvBx0] + addErrBx0) then
    OutDetail(outWarning, rsCheckFonCentre);
  if (aBy0 <= OCW_Min[cvBy0] - addErrBy0) or (aBy0 >= OCW_Max[cvBy0] + addErrBy0) then
    OutDetail(outWarning, rsCheckFonBegin);

  // Bad
  if (aBt <= 0) then
    OutDetail(outBad, rsFonBtNegative);
  if (aBt <= OCE_Min[cvBt] - addErrBt) then
    OutDetail(outBad, rsFonBtTooLow);
  if (aBt >= OCE_Max[cvBt] + addErrBt) then
    OutDetail(outBad, rsFonBtTooHigh);
  if (aBx0 <= OCE_Min[cvBx0] - addErrBx0) then
    OutDetail(outBad, rsFonBx0TooLow);
  if (aBx0 >= OCE_Max[cvBx0] + addErrBx0) then
    OutDetail(outBad, rsFonBx0TooHigh);
  if (aBy0 <= OCE_Min[cvBy0] - addErrBy0) then
    OutDetail(outBad, rsFonBy0TooLow);
  if (aBy0 >= OCE_Max[cvBy0] + addErrBy0) then
    OutDetail(outBad, rsFonBy0TooHigh);
end;

procedure TCalcForm.CheckPeakDGauss(aWaitingGM1,aGM1,aDGM2,aGA1,aDGA2,aGSL,aGSR : double);
begin
  if (aGM1-aWaitingGM1 >= OCW_max[cvGM1]) then OutDetail(outWarning, rsCheckPeak5CentreRight);
  if (aGM1-aWaitingGM1 <= OCW_min[cvGM1]) then OutDetail(outWarning, rsCheckPeak5CentreLeft);
  if (aGM1-aWaitingGM1 >= OCE_max[cvGM1]) then OutDetail(outBad, rsCheckPeak5CentreRight);
  if (aGM1-aWaitingGM1 <= OCE_min[cvGM1]) then OutDetail(outBad, rsCheckPeak5CentreLeft);

  if (aDGM2 >= OCW_max[cvDGM2]) then OutDetail(outWarning, rsCheckPeak4CentreRight);
  if (aDGM2 <= OCW_min[cvDGM2]) then OutDetail(outWarning, rsCheckPeak4CentreLeft);
  if (aDGM2 >= OCE_max[cvDGM2]) then OutDetail(outBad, rsCheckPeak4CentreRight);
  if (aDGM2 <= OCE_min[cvDGM2]) then OutDetail(outBad, rsCheckPeak4CentreLeft);

  if (aGA1 >= OCW_max[cvGA1]) then OutDetail(outWarning, rsCheckPeakGA1max);
  if (aGA1 <= OCW_min[cvGA1]) then OutDetail(outGood, rsCheckPeakGA1min);
  if (aGA1 >= OCE_max[cvGA1]) then OutDetail(outBad, rsCheckPeakGA1max);
  if (aGA1 <= OCE_min[cvGA1]) then OutDetail(outGood, rsCheckPeakGA1min);

  if (aDGA2 >= OCW_max[cvDGA2]) then OutDetail(outWarning, rsCheckPeakDGA2);
  if (aDGA2 <= OCW_min[cvDGA2]) then OutDetail(outWarning, rsCheckPeakDGA2);
  if (aDGA2 >= OCE_max[cvDGA2]) then OutDetail(outBad, rsCheckPeakDGA2);
  if (aDGA2 <= OCE_min[cvDGA2]) then OutDetail(outBad, rsCheckPeakDGA2);

  if (aGSL >= OCW_max[cvGSL]) then OutDetail(outWarning, rsCheckPeakGSL);
  if (aGSL <= OCW_min[cvGSL]) then OutDetail(outWarning, rsCheckPeakGSL);
  if (aGSL >= OCE_max[cvGSL]) then OutDetail(outBad, rsCheckPeakGSL);
  if (aGSL <= OCE_min[cvGSL]) then OutDetail(outBad, rsCheckPeakGSL);

  if (aGSR >= OCW_max[cvGSR]) then OutDetail(outWarning, rsCheckPeakGSR);
  if (aGSR <= OCW_min[cvGSR]) then OutDetail(outWarning, rsCheckPeakGSR);
  if (aGSR >= OCE_max[cvGSR]) then OutDetail(outBad, rsCheckPeakGSR);
  if (aGSR <= OCE_min[cvGSR]) then OutDetail(outBad, rsCheckPeakGSR);
end;

function TCalcForm.Hi2_Fon(aBx0, aBt, aBy0, aBxy0, aBdy: double): double;
var
  i: integer;
  CurF: double;
  Err_F: double;
  kBy0, kBt, kBx0: double;
begin
  Result := 0;
  for i := BG_Start to BG_End do
  try
    CurF := FuncBackground(BGFunc, i, aBx0, aBt, aBy0, aBxy0, aBdy);
    if OptionsForm.CB_FonFitGlade.Checked then
      Err_F := SQR(CurF - BuffAvg[i])
    else
      Err_F := SQR(CurF - CDetector.BuffPulses[i]);
    Result := Result + Err_F;
  except
    Result := 1E12;
  end;

  if (BG_End - BG_Start + 1)>0 then
    Result := Result / (BG_End - BG_Start + 1);

  if OptionsForm.CB_FonPlusWaitings.Checked then
  begin
    kBy0 := GetVLE_Float('kBy0', 0.1);
    kBt := GetVLE_Float('kBt', 0.1);
    kBx0 := GetVLE_Float('kBx0', 0.1);
    Result := Result + kBy0 *
      Abs(aBy0 - StrToFloatRegion(OptionsForm.EditEvalBy0.Text));
    Result := Result + kBt *
      Abs(aBt - StrToFloatRegion(OptionsForm.EditEvalBt.Text));
    Result := Result + kBx0 *
      Abs(aBx0 - StrToFloatRegion(OptionsForm.EditEvalBx0.Text));
  end;
end;

function TCalcForm.Hi2_Func(av: TParamArray): double;
var
  i: integer;
  CurF: double;
  Err_F: double;
  savedGM1, savedDGM2, savedGA1, savedDGA2, savedGSL, savedGSR, savedN1, savedN2: double;
  kGM1, kDGM2, kGA1, kDGA2, kGSL, kGSR, kN: double;
  ErrWithWaitings: double;
  kErr: double;
  CalcModeHi2: integer;
begin
  Result := 0;
  for i := round(CDetector.N1) to round(CDetector.N2) do
  try
    CurF := FuncBase(i, av);
    if OptionsForm.CB_FitGlade.Checked then
      Err_F := SQR(CurF + BuffBackground[i] - BuffAvg[i])
    else
      Err_F := SQR(CurF + BuffBackground[i] - CDetector.BuffPulses[i]);
    Result := Result + Err_F;
  except
    Result := 1E12;
  end;

  if (CDetector.N2 - CDetector.N1 + 1)>0 then
    Result := Result / (CDetector.N2 - CDetector.N1 + 1);

  if OutEnum=outBad then DoFitWithWaitings:=True; // Механизм повторного фитирования при ошибках должен учитывать ожидания  .. BAD может быть только при повторном запросе на фитирование

  if DoFitWithWaitings then
  begin
    CalcModeHi2 := GetVLE_Int('CalcModeHi2', 1);
    kGM1 := GetVLE_Float('kGM1', 0.0);
    kDGM2 := GetVLE_Float('kDGM2', 0.1);
    kGA1 := GetVLE_Float('kGA1', 0.0);
    kDGA2 := GetVLE_Float('kDGA2', 0.1);
    kGSL := GetVLE_Float('kGSL', 0.05);
    kGSR := GetVLE_Float('kGSR', 0.01);
    kN := GetVLE_Float('kN', 0.1);
    if CalcModeHi2=1 then
    begin
    end;
    if CalcModeHi2=2 then
    begin
      kGM1 := GetVLE_Float('kGM1', 0.0);
      kDGM2 := GetVLE_Float('kDGM2', 0.1);
      kGA1 := GetVLE_Float('kGA1', 0.0);
      kDGA2 := GetVLE_Float('kDGA2', 0.1);
      kGSL := 0;
      kGSR := 0;
      kN := 0;
    end;

    ErrWithWaitings :=0;

    if OutEnum=outBad then  // Механизм повторного фитирования при ошибках должен учитывать ожидания, корректируем эти ожидания  .. BAD может быть только при повторном запросе на фитирование
    begin
//      kDGA2 := GetVLE_Float('kDGA2IfErr', 0.5);
    end;

    savedGM1   := StrToFloatRegion(OptionsForm.Edit_GM1.Text);
    savedDGM2  := StrToFloatRegion(OptionsForm.Edit_DGM2.Text);
    savedGA1   := StrToFloatRegion(OptionsForm.Edit_GA1.Text);
    savedDGA2  := StrToFloatRegion(OptionsForm.Edit_DGA2.Text);
    savedGSL   := StrToFloatRegion(OptionsForm.Edit_GSL.Text);
    savedGSR   := StrToFloatRegion(OptionsForm.Edit_GSR.Text);
    savedN1    := GetVLE_Float('SRC_N1', CDetector.N1);
    savedN2    := GetVLE_Float('SRC_N2', CDetector.N2);
    kErr       := GetVLE_Float('kErr', 0.1);

    ErrWithWaitings := ErrWithWaitings + kGM1  * Abs(av[1] - savedGM1);
    ErrWithWaitings := ErrWithWaitings + kDGM2 * Abs(av[2] - savedDGM2);
    ErrWithWaitings := ErrWithWaitings + kGA1  * Abs(av[3] - savedGA1);
    ErrWithWaitings := ErrWithWaitings + kDGA2 * Abs(av[4] - savedDGA2);
    ErrWithWaitings := ErrWithWaitings + kGSL  * Abs(av[5] - savedGSL);
    ErrWithWaitings := ErrWithWaitings + kGSR  * Abs(av[6] - savedGSR);

    ErrWithWaitings := ErrWithWaitings + kN    * Abs(CDetector.N1 - savedN1);
    ErrWithWaitings := ErrWithWaitings + kN    * Abs(CDetector.N2 - savedN2);

    ErrWithWaitings := kErr * ErrWithWaitings * SQRT(2*Pi) * savedGA1 * (savedGSL + savedGSR) / 2; // kErr (из опций) * относительное смещение * площадь пика

    Result := Result + ErrWithWaitings;

  end;
end;

procedure StringToData(aString: String; var aData: TDArray);
var
  i      : integer;
  ts     : TStringList;
begin
  if aString<>'{}' then
  begin
    ts:=TStringList.Create;
    ts.Delimiter:=',';                                        // устанавливаем разделитель
    ts.DelimitedText:=aString;
    ts.Text:=StringReplace(ts.Text,'{','',[rfreplaceall]);    // удаляем фигурные скобки
    ts.Text:=StringReplace(ts.Text,'}','',[rfreplaceall]);

    if ts.Count>0 then
    begin
      for i := 0 to ts.Count-1 do aData[i]:=StrToFloatRegion(ts[i]);
    end;

    ts.Free;
  end;
end;


procedure TCalcForm.UpdateEdits(Detector: TDetector);
begin
  DisableCalcControls := True;
  if Assigned(Detector) then
  begin
    StringToData(Detector.Fon,BuffBackground);

    EditBt.Text:=FloatToStrRegionF(Detector.Bt,ffGeneral,6,3);
    EditBx0.Text:=FloatToStrRegionF(Detector.Bx0,ffGeneral,6,3);
    EditBy0.Text:=FloatToStrRegionF(Detector.By0,ffGeneral,6,3);
    EditBxy0.Text:=FloatToStrRegionF(Detector.Bxy0,ffGeneral,6,3);
    EditBdy.Text:=FloatToStrRegionF(Detector.Bdy,ffGeneral,6,3);
    Edit_GSL.Text:=FloatToStrRegionF(Detector.Gsl,ffGeneral,6,3);
    Edit_GSR.Text:=FloatToStrRegionF(Detector.Gsr,ffGeneral,6,3);
    Edit_GM1.Text:=FloatToStrRegionF(Detector.Gm1,ffGeneral,6,3);
    Edit_GA1.Text:=FloatToStrRegionF(Detector.Ga1,ffGeneral,6,3);
    Edit_DGM2.Text:=FloatToStrRegionF(Detector.Dgm2,ffGeneral,6,3);
    Edit_DGA2.Text:=FloatToStrRegionF(Detector.Dga2,ffGeneral,6,3);
    Edit_N1.Text:=FloatToStrRegionF(Detector.N1,ffGeneral,3,1);
    Edit_N2.Text:=FloatToStrRegionF(Detector.N2,ffGeneral,3,1);
    Edit_BN1.Text:=FloatToStrRegionF(Detector.BN1,ffGeneral,3,1);
    Edit_BN1_width.Text:=FloatToStrRegionF(Detector.BN1_width,ffGeneral,3,1);
    Edit_BN2.Text:=FloatToStrRegionF(Detector.BN2,ffGeneral,3,1);
    Edit_BN2_width.Text:=FloatToStrRegionF(Detector.BN2_width,ffGeneral,3,1);
    Edit_S.Text := FloatToStrRegionF(Detector.Dose, ffFixed, 8, 2);
    Edit_S.Hint := rsSuquare+'='+FloatToStrRegionF(Detector.S, ffFixed, 8, 2) + '  χ2 =' + FloatToStrRegionF(Detector.Err, ffFixed, 8, 2); // ±
    Edit_Err.Text := FloatToStrRegionF(Detector.Err, ffFixed, 8, 2);

    case Detector.State of
      stDetProcessed:        OutEnum := outGood;
      stDetProcessedWarning: OutEnum := outWarning;
      stDetProcessedError:   OutEnum := outBad;
      else OutEnum := outBad;
    end;
  end;
  DisableCalcControls := False;
end;

procedure TCalcForm.LoadData(aDetector: TDetector);
begin
  CDetector:=aDetector;

  if OptionsForm.CB_ReadCalculated.Checked then
  begin
    UpdateEdits(CDetector);
    CalcType := ccFromDB;


    case CDetector.State of
      stDetProcessed:           OutEnum := outGood;
      stDetProcessedWarning:    OutEnum := outWarning;
      stDetProcessedError:      OutEnum := outBad;
        else                    OutEnum := outGood;
    end;
  end
    else
      CalcType := ccAuto;

  ShowDataInChart(TDosimeter(CDetector.Parent).FullNumber,
                  IntToStr(TDosimeter(CDetector.Parent).MeasurementID),
                  IntToStr(CDetector.Position),
                  DateTimeToStr(CDetector.MeasureTime));
  SetInterfaceByPermits;
end;

function TCalcForm.FuncBase(i: double; av: TParamArray): double;
begin
  Result := FuncDGauss(i, av);
end;

function TCalcForm.FuncDGauss(i: double; v: TParamArray): double;
begin
  Result := FuncDGaussR1(i, v) + FuncDGaussR2(i, v);
end;

function TCalcForm.FuncDGaussR1(i: double; v: TParamArray): double;  // Пик А5
begin
  if v[5]*v[6]=0
  then result:=0
  else
    if i <= v[1] then
      Result := v[3] * Exp(-(i - v[1]) * (i - v[1]) / (2 * v[5] * v[5]))
    else
      Result := v[3] * Exp(-(i - v[1]) * (i - v[1]) / (2 * v[6] * v[6]));
end;

function TCalcForm.FuncDGaussR2(i: double; v: TParamArray): double;  // Пик А4
begin
  if v[5]*v[6]=0
  then result:=0
  else
    if i <= v[1] + v[2] then
      Result := v[3] * v[4] * Exp(-(i - v[1] - v[2]) * (i - v[1] - v[2]) /
        (2 * v[5] * v[5]))
    else
      Result := v[3] * v[4] * Exp(-(i - v[1] - v[2]) * (i - v[1] - v[2]) /
        (2 * v[6] * v[6]));
end;

procedure TCalcForm.FileOpenBDClick(Sender: TObject);
begin
  OpenDB.Show;
end;

function TCalcForm.FindFonExp_Bt(R_Start, R_End, akwidth: integer; abCrossBT40: boolean): double;
var
  kL, Sum: double;
  j: integer;
begin
  // Поиск Bt по отношению к производной
  Result := 0.1;
  if (R_End - R_Start)<=0 then Exit;
  try
    // первая производная как разность площади справа и площади слева (площади для увеличения статистики)
    kL := 0;
    for j := 0 to akwidth - 1 do
      kL := kL + (BuffAvg[R_End - j] - BuffAvg[R_Start - j]) / (R_End - R_Start);
    kL := kL / akwidth; // наклон линии по линейной апроксимации (значение производной)

    // значение величины считается для середины как общее среднее среди попавших значений
    Sum := 0;
    for j := 0 to akwidth - 1 do
    // сумма средних значений между крайними
      Sum := Sum + (BuffAvg[R_End - j] + BuffAvg[R_Start - j]) / 2;
    Sum := Sum / akwidth; // общее среднее

    if kL <> 0 then
    begin
      Result := (Sum - CDetector.By0) / kL;
    end;
  except
    Result := 0.1;
  end;
  if abCrossBT40 then
    Result := Bt40; // если по алгоритму поиска по близости к Bt = 40 были и меньшие и большие значения
end;

function TCalcForm.FindFonExp_Bx0(aBy0, aBt: Double; R_Start, R_End, akwidth: integer): double;
var
  Sum, Buf, LnParam: double;
  n, i: integer;
begin
//  SetExceptionMask(GetExceptionMask - [exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
  Result := 1000;
  try
    Sum := 0;
    n := 0;
    for i := R_Start to R_End do
      try
        LnParam := BuffAvg[i] - aBy0;
        Buf:=0;
        if LnParam>1e-10 then
          Buf := i - aBt * Ln(LnParam);
        // Если будет ошибка при расчёте логарифма - она не учтётся в среднем из-за прерывания по Exception
        // наклон линии по линейной апроксимации (значение производной)
        n := n + 1;
        Sum := Sum + Buf;
      except
        On E:EMathError do Buf:=0;
      end;
    if n <> 0 then
    begin
      Result := Sum / n;
    end;
  except
    Result := 1000;
  end;
//  SetExceptionMask(GetExceptionMask + [exInvalidOp, exDenormalized, exZeroDivide, exOverflow, exUnderflow, exPrecision]);
end;

function TCalcForm.FindFonExp_By0(aDetector: TDetector; aBuffAvg: TDarray; L_Start,L_Num: integer): double;
var
  i,iBegin,iEnd: integer;
  Sum: double;
  iMinY0: integer;
begin
  Result := 0;
  iBegin := max(0,L_Start);
  iEnd := max(0,L_Start + L_Num-1);
  if OptionsForm.RG_FuncFindBy0.ItemIndex = 0 then
  begin
    Sum := 0;
    for i := iBegin to iEnd do
      Sum := Sum + aBuffAvg[i];
    if L_Num<>0 then
      Result := Sum / L_Num;
  end
    else
  begin
    Result := aBuffAvg[iBegin];
    for i := iBegin to iEnd do
      if aBuffAvg[i] < Result then
        Result := aBuffAvg[i];
  end;


//  Некоторые коррекции для Фитирования
//  if (OptionsForm.CalcMainMethod(aDetector.Method) = alFitting) then
  if (OptionsForm.RG_MainAlgorithm.ItemIndex = 0) then // Фитирование
  begin
    if (Result = 0) then
    begin
      for i := 0 to 200 do
        if aBuffAvg[i]>0 then
        begin
          Result := 1/i;
          break;
        end;
    end;

    // локальный минимум не должен быть больше by0
    iMiny0 := 120;
    for i := 120 to 290 do // поиск локального минимума в зоне пиков и за ними
      if (aBuffAvg[i] < aBuffAvg[iMiny0]) and (aBuffAvg[i] > OCW_Min[cvBy0] + 0.0001) then
        iMiny0 := i;
    if aBuffAvg[iMiny0] - 0.0001 < Result then  // какой-то подъём должен быть всегда, пусть и совсем небольшой
      Result := aBuffAvg[iMiny0] - 0.0001;
  end;
end;

function TCalcForm.FindFonStep_Bdy(aBdy0 : Double; R_Start, R_End: integer): double;
var
  i: integer;
  Buf: double;
begin
  result:=0;
  if (R_End - R_Start + 1)=0 then Exit;
  Buf := 0;
  for i := R_Start to R_End do
    Buf := Buf + BuffAVG[i];
  result := Buf / (R_End - R_Start + 1) - aBdy0;
end;

function TCalcForm.FindFonExpRangeByBTEqual40(RangeLeft, RangeRight, akwidth: integer;
  var R_Start, R_End: integer): boolean;
var
  i, n: integer;
  Buf: double;
  bLow, bHi: boolean;
  // для признака перехода через bt=40 (если были и меньше и больше - используем ровно 40)
begin
  Result := false;
  bLow := false;
  bHi := false;
  n := akwidth;
  CDetector.Bt := 200;

  for i := RangeRight downto RangeLeft do
  begin
    if (BuffAvg[i + n] - BuffAvg[i] < 0) and (i < iWaitingPeakCentre+30)
      then break; // Сброс на правом склоне пика А5 (если обратный наклон и скоро пик по ожиданию)
    if (BuffAvg[i + n] - BuffAvg[i] < -n / 3) and (i < 289) and (BuffAvg[i + n] < 5)
      then break; // Сброс на правом склоне пика А5 (если сильный обратный наклон и ??)

    Buf := FindFonExp_Bt(R_Start, R_End, akwidth, false);
    if Buf < BT40 then
      bLow := True;
    if Buf > BT40 then
      bHi := True;
    if Abs(Buf - BT40) < Abs(CDetector.Bt - BT40) then
    begin
      R_Start := i;
      R_End := i + n;
      CDetector.Bt := Buf;
      Result := True;
    end;
  end;

  bCrossBT40 := bLow and bHi;
end;

function TCalcForm.FindFonExpRangeBySlantMaximum(RangeLeft, RangeRight, akwidth: integer;
  var R_Start, R_End: integer): boolean;
var
  i, r, n: integer;
  Buf: double;
begin
  Result := false;
  if RangeRight > MaxChannels then
    RangeRight := MaxChannels;
  if RangeLeft > MaxChannels then
    Left := MaxChannels;
  if RangeRight < 0 then
    RangeRight := 0;
  if RangeLeft < 0 then
    Left := 0;

  r := RangeRight;
  n := akwidth;
  CDetector.Bt := 1000; // начальный максимум для замены по условию
  for i := RangeRight downto RangeLeft do
  begin
    Buf := FindFonExp_Bt(i - n, i, akwidth, bCrossBT40);
    if (Buf < CDetector.Bt) and (Buf > 0) and (i > iWaitingPeakCentre+30) then
    begin
      CDetector.Bt := Buf;
      r := i;
      Result := True; // возможно добавить критерии
    end;
  end;
  R_End := r;
  R_Start := r - n;
end;

function TCalcForm.FindFonExpRangeByMinimum(RangeLeft, RangeRight, akwidth: integer;
  var R_Start, R_End: integer): boolean;
var
  i: integer;
  n: integer;
begin
  n := R_Start;
  for i := RangeLeft to RangeRight do
  begin
    if (BuffAvg[i] < BuffAvg[n]) then
      n := i;
  end;
  R_Start := n + StrToInt(OptionsForm.Edit_FonMinAdd.Text);
  R_End := R_Start + akwidth;
  Result := True;
  if R_End > MaxChannels then
  begin
    R_Start := MaxChannels - akwidth;
    R_End := MaxChannels;
    Result := false;
  end;
end;

function TCalcForm.FindFonExpRangeByPeak(RangeLeft, RangeRight, akwidth: integer;
  var R_Start, R_End: integer; alterAlgorithm: integer): boolean;
var
  i: integer;
  GoodPeak: boolean;
  Sum1,Sum2 : real;
begin
  FoundPeak := FindPeak(fpAuto);
  Sum1:=0; // сумма всех импульсов между сигм
  GoodPeak := False;
  if CDetector.PeakFound then
  begin
    for i := FoundPeak.Centre to FoundPeak.RightSigma do
      Sum1 := Sum1 + BuffAVG[i];
    Sum2 := BuffAVG[FoundPeak.RightSigma]*(FoundPeak.RightSigma - FoundPeak.Centre +1); // площадь подложки
    GoodPeak := (Sum1-Sum2>50) and (BuffAVG[FoundPeak.Centre]-BuffAVG[FoundPeak.RightSigma]>4) and (BuffAVG[FoundPeak.RightSigma]-BuffAVG[FoundPeak.RightEdge]>4); // достаточность и скат формы справа
  end;

  // Уточнение фона по найденному пику и заново поиск пика по уточнённому фону (One additional iteration)
  if GoodPeak then
  begin
    for i := FoundPeak.RightEdge to MaxChannels do
      if BuffDiff[i] <= 0
      // then R_Start := i + (akwidth div 2)
      then
        R_Start := i + akwidth
      else
        break; // пока первая производная меньше 0, идёт уменьшение
    R_End := R_Start + akwidth;
  end
  else
    case alterAlgorithm of
      0: // nothing (фиксированные границы из интерфейса)
        begin
          CDetector.Bt := FindFonExp_Bt(R_Start, R_End, akwidth, bCrossBT40);
          // Поиск Bt по отношению к производной
          CDetector.Bx0 := FindFonExp_Bx0(CDetector.By0, CDetector.Bt, R_Start, R_End, akwidth);
          // Поиск Bx0 по точкам линии фона (на предпоследних x)
        end;
      1: // По максимальному наклону
        FindFonExpRangeBySlantMaximum(RangeLeft, RangeRight, akwidth, R_Start, R_End);
      2: // По минимуму
        FindFonExpRangeByMinimum(RangeLeft, RangeRight, akwidth, R_Start, R_End);
      3: // 40
        FindFonExpRangeByBTEqual40(RangeLeft, RangeRight, akwidth, R_Start, R_End);
      4: // По хвосту пика
        FindFonExpRangeByPeak(RangeLeft, RangeRight, akwidth, R_Start, R_End, 5);
      5: // Комбо
        FindFonExpRangeCombo(RangeLeft, RangeRight, akwidth, R_Start, R_End);
    end; // окончание выбора способа поиска фоновой функции

  Result := True;
end;

function TCalcForm.FindFonExpByRange(aBG_Start, aBG_End, akwidth: integer; var aBt, aBx0: Double): boolean;
begin
  result:=True;
  if aBG_End < MaxChannels then // фон с запасом лежит после пика - норма
  begin
    aBt := FindFonExp_Bt(aBG_Start, aBG_End, akwidth, bCrossBT40);
    aBx0 := FindFonExp_Bx0(CDetector.By0, aBt, aBG_Start, aBG_End, akwidth);
  end
    else
  if aBG_Start < MaxChannels - 1 then // фон почти упирается в край - так себе случай
  begin
    aBG_End := MaxChannels;
    aBt := FindFonExp_Bt(aBG_Start, aBG_End, (aBG_End - aBG_Start) div 2 + 1, bCrossBT40);
    if (aBt < 20) or (aBt > 200) then
    // если из-за короткого хвоста большая ошибка оценки Bt, заменяем дефолтным значением
    begin
      aBt := Bt40;
    end;
    aBx0 := FindFonExp_Bx0(CDetector.By0, aBt, aBG_Start, aBG_End, (aBG_End - aBG_Start) div 2 + 1);
//    OutDetail(outWarning, rsFonAfterPeakTooRight);
  end
    else // фон вообще не проявился, пик скатывается за край - плохо
  begin
    aBG_Start := MaxChannels - 2;
    aBG_End := MaxChannels;
    aBt := Bt40;
    aBx0 := FindFonExp_Bx0(CDetector.By0, aBt, aBG_Start, aBG_End, 1);
//    OutDetail(outBad, rsFonAfterPeakAbsent);
  end;

  // коррекция неправильного наклона
  if OptionsForm.CB_FonAdaptive.Checked then
  if (aBt <= OCW_Min[cvBt]) or (aBt >= OCW_Max[cvBt]) then
  begin
    FindFonExpBt40andRightRange(CDetector.BN2, BuffAVG[round(CDetector.BN2)], CDetector.By0, aBt,aBx0);
  end;
end;

function TCalcForm.FindFonExpBetweenPoints(x1,y1, x2,y2, aBy0: Double; var aBt, aBx0: Double): boolean;
  var
    fx1,fx2,kw: integer;
    Dz1,Dz2: double;
begin
  result := False;
  aBx0 := 200;
  aBt := Bt40;
  try
  // приращения и допущения против переполнений и делений на ноль
    if abs(y2-y1)<0.001 then y2:=y1+0.001;
    if y2-0.001<=aBy0 then aBy0 :=y2-0.001;
    if y1-0.001<=aBy0 then aBy0 :=y1-0.001;

    Dz1:=(ln(y2-aBy0)-ln(y1-aBy0));
    if Abs(Dz1)<0.00001 then Exit;
    Dz2:=ln(y1-aBy0);
    if Abs(Dz2)<0.001 then Exit;

    aBx0 := (x1*ln(y2-aBy0)-x2*ln(y1-aBy0))/Dz1;
    aBt  := (x1-aBx0)/Dz2;
    result := True;
  except
    kw := 10;
    fx1 := round(x2);
    fx2 := fx1 + kw;
    try
      FindFonExpByRange(fx1, fx2, kw, aBt, aBx0);
    except
      on E: Exception do
        WriteLog(Format(rsCalcFormError,['FindFonExpBetweenPoints (RezervedCalc)',E.Message]));
    end;
  end;
end;

function TCalcForm.FindFonExpBt40andRightRange( x, y, aBy0: Double; var aBt: Double; var aBx0: Double ): boolean;
begin
  try
    aBt  := Bt40;
    // приращения и допущения против переполнений и делений на ноль
    if y-0.001<=aBy0 then aBy0 :=y-0.001;
    aBx0 := (x-aBt*ln(y-aBy0));
    result := True;
  except
    aBx0 := 1000;
    aBt := 0.1;
    result := False;
  end;
end;

function TCalcForm.FindFonExpRangeCombo(RangeLeft, RangeRight, akwidth: integer;
  var R_Start, R_End: integer): boolean;
var
  i,j: integer;
  iOtstup: integer;
  iMin, iMinBPeak, iMaxR, iMaxG : integer;
  iMaxBetweemMinimums : integer;
  bNoPeak : boolean;
  iMinR_Start: integer;
begin
  iOtstup := StrToInt(OptionsForm.Edit_FonMinAdd.Text);
  iMinR_Start := iWaitingPeakCentre + round(OCW_max[cvGM1]) + iOtstup;

  // поиск глобального максимума (iMaxG)
  RangeLeft := min(RangeLeft,MaxChannels);
  RangeRight := min(RangeRight,MaxChannels);

  iMaxG := RangeRight;
  for i := RangeRight downto RangeLeft do
  begin
    if BuffAvg[i] > BuffAvg[iMaxG] then
      iMaxG := i;
  end;

  // поиск самого правого локального максимума (загиб шестого пика) (iMaxR)
  iMaxR := RangeRight;
  for i := RangeRight downto RangeLeft do
  begin
    if (BuffAvg[i] - BuffAvg[i - akwidth] > 1/akwidth) then // Сброс при правильном положительном наклоне (с учётом случайных значений на уровне 0)
      if (BuffAvg[i] - BuffAvg[i - akwidth div 2] > 1/2/akwidth) then // доп. контроль - серединка должна тоже соответствовать (не реагировать на острый пик)
        break;
    if BuffAvg[i] > BuffAvg[iMaxR] then
      iMaxR := i;
  end;
  if RangeRight-iMaxR>20 then // никакого загиба шестого пика нет
    iMaxR := RangeRight;

  // поиск самого правого локального минимума слева от локального максимума
  iMin := iMaxR - akwidth; //отступ против дребезга (волюнтаризм)
  for i := iMaxR - akwidth downto RangeLeft do
  begin
//    if (BuffAvg[i + akwidth] - BuffAvg[i] < 0)
    if (BuffAvg[i + akwidth] - BuffAvg[i] < -1/akwidth) then // Сброс при правильном отрицательном наклоне (с учётом случайных значений на уровне 0)
//      if (BuffAvg[i + akwidth] - BuffAvg[i] < -1/akwidth) then // доп. контроль - серединка должна тоже соответствовать (не реагировать на острый пик)
        break;
    if BuffAvg[i] < BuffAvg[iMin] then
      iMin := i;
  end;

  // поиск дополнительного максимума между найденным минимумумом (предположительно впадиной после пика и началом)
  iMaxBetweemMinimums := iMin;
  for i := iMin downto RangeLeft do
  begin
    if BuffAvg[i] > BuffAvg[iMaxBetweemMinimums] then
      iMaxBetweemMinimums := i;
  end;

  // Критерий отсутствия пика
  bNoPeak := (iMin - RangeLeft) < 10; // минимум с левого края (с учетом дребезга)
  bNoPeak := bNoPeak or (BuffAVG[iMaxR] - BuffAVG[iMin] < FP_TooLitleLevel); // или максимум от минимума почти не отличается по величине
  bNoPeak := bNoPeak or (BuffAVG[iMaxBetweemMinimums] - BuffAVG[iMin] < FP_TooLitleLevel); // или максимум от минимума почти не отличается по величине

  bNoPeak := bNoPeak and (Abs(iMaxG - iMaxR) < 10) and (iMaxG <= iMaxR); // и правый максимум и общий максимум один и тотже (с учетом дребезга)
  bNoPeak := bNoPeak and (RangeRight - iMaxG < 10); // и общий максимум справа (с учетом дребезга)

  // в случае отсутствия пика (минимум слева, максимум один и справа)
  if bNoPeak then // когда пика нет
  begin // берём правую границу за основу
    R_End := min(RangeRight,iMaxG);
    R_End := min(R_End,iMaxR);
    R_End := R_End - 1;
    R_Start := R_End - akwidth;
    if iMin + iOtstup <= R_End - akwidth then
      R_Start := iMin + iOtstup;
    if iMin <= iMinR_Start then
      R_Start := iMinR_Start;
    Result := false;
    Exit;
  end;

// Если при этом есть заметный пик, то смотрим где он кончается (ищем яму минимума справа от пика)
  iMinBPeak := iMaxR;
  for i := iMaxG + akwidth to RangeRight do
  begin
    if (BuffAvg[i] - BuffAvg[i - akwidth] > 1/akwidth)
      then break; // Сброс при неправильном наклоне
    if BuffAvg[i] < BuffAvg[iMin] then
      iMinBPeak := i;
  end;
  if (Abs(iMin - iMinBPeak) <= akwidth) then // когда минимумы рядом
  begin
    if (Abs(BuffAvg[iMin] - BuffAvg[iMinBPeak]) < 2)
    then // если разница амплитуд невелика
      iMin := max(iMin,iMinBPeak); // считаем их одним, выбирая правый
      iMinBPeak := iMin; // считаем их одним, выбирая правый
  end;

//  if iMin <= iMinR_Start then
  if iMinBPeak <= iMinR_Start then
    R_Start := iMinR_Start;

// Определяемся с отрезком для расчёта фона
  if ((iMaxR-iMinBPeak)>40) and (iMin-R_Start<5) then // если длинный пологий подъём и пика точно нет (локальный минимум что должен быть за пиком находится рядом с первым каналом диапазона поиска), то берём фон с отступом от максимума справа
  begin
    R_End := iMaxR - 10; // возможно стоит параметризовать
    R_Start := R_End - akwidth;
    if iMin + iOtstup <= R_End - akwidth then
      R_Start := iMinBPeak + iOtstup;
//      R_Start := iMin + iOtstup;
  end
    else // если же обозначился пик, то берём фон с отступом от минимума
  begin
    R_Start := iMin + iOtstup;
    R_End := R_Start + akwidth;
    // если нет явного загиба - пробуем расширить зону фона
    if iMaxR - iOtstup >= R_Start + akwidth then
    begin
      R_End := iMaxR - iOtstup;
      // однако нало проверить нет ли в этой зоне обратного перегиба по второй производной (расчитываем что она была посчитана ранее при поиске пика)
      // CopyPast из поиска пиков
      // Первая производная
      FillChar(BuffDiff, SizeOf(BuffDiff), 0);
      for i := DX to MaxChannels - DX do
        BuffDiff[i] := BuffWideAvgWOB[i + DX] - BuffWideAvgWOB[i - DX];
      for i := 0 to DX - 1 do
      begin
        for j := 1 to i do // добиваем краешки неравновесной разностью
        begin
          BuffDiff[i] := BuffWideAvgWOB[i + j] - BuffWideAvgWOB[i - j];
          BuffDiff[MaxChannels - i] := BuffWideAvgWOB[MaxChannels - i + j] -
            BuffWideAvgWOB[MaxChannels - i - j];
        end;
      end;
      // Вторая производная
      FillChar(BuffDiff2, SizeOf(BuffDiff2), 0);
      for i := DX to MaxChannels - DX do
      // вторая производная как разность площади справа и площади слева первой производной (площади для увеличения статистики)
      begin
        for j := 1 to DX do
          BuffDiff2[i] := BuffDiff2[i] + BuffDiff[i + j] - BuffDiff[i - j];
      end;
      for i := 0 to DX - 1 do // добиваем краешки неравновесной разностью
      begin
        for j := 1 to i do
        begin
          BuffDiff2[i] := BuffDiff2[i] + BuffDiff[i + j] - BuffDiff[i - j];
          BuffDiff2[MaxChannels - i] := BuffDiff2[MaxChannels - i] +
            BuffDiff[MaxChannels - i + j] - BuffDiff[MaxChannels - i - j];
        end;
      end;

      for i := R_Start + akwidth to R_End do
      begin
        if BuffDiff2[i]<=0 then
        begin
          R_End := i;
          break;
        end;
      end;
    end;
  end;
  Result := True;
end;

function TCalcForm.FindPeak(fpCalcType:TFPCalcType): TPeakInfo;
var
  i, j, icL, icR: integer;
  min1, max1, max2: integer;
  // параметры второй производной, связанные с найденным пиком (min1- центр)
  Sum: double;
  iLocalMin: integer;
  iAVGMax: integer;
  maybeBigPeak: boolean;
  IsPeakFound: boolean;
  imaxInWait: integer;
begin
  imaxInWait := min(DX,round(iWaitingPeakCentre + OCW_min[cvGM1]));
  for i := min(DX,round(iWaitingPeakCentre + OCW_min[cvGM1])) to max(MaxChannels - DX,round(iWaitingPeakCentre + OCW_max[cvGM1])) do
    if BuffWideAvgWOB[i] > BuffWideAvgWOB[imaxInWait] then
      imaxInWait := i;

    //  if CB_UseForFindPeak.Checked then
  if fpCalcType=fpManual then
  begin
    iWaitingPeakCentre := round(CDetector.N1 + CDetector.N2) div 2;
  end;

  // Первая производная
  FillChar(BuffDiff, SizeOf(BuffDiff), 0);
  for i := DX to MaxChannels - DX do
    BuffDiff[i] := BuffWideAvgWOB[i + DX] - BuffWideAvgWOB[i - DX];
  for i := 0 to DX - 1 do
  begin
    for j := 1 to i do // добиваем краешки неравновесной разностью
    begin
      BuffDiff[i] := BuffWideAvgWOB[i + j] - BuffWideAvgWOB[i - j];
      BuffDiff[MaxChannels - i] := BuffWideAvgWOB[MaxChannels - i + j] -
        BuffWideAvgWOB[MaxChannels - i - j];
    end;
  end;

  // Вторая производная
  FillChar(BuffDiff2, SizeOf(BuffDiff2), 0);
  for i := DX to MaxChannels - DX do
  // вторая производная как разность площади справа и площади слева первой производной (площади для увеличения статистики)
  begin
    for j := 1 to DX do
      BuffDiff2[i] := BuffDiff2[i] + BuffDiff[i + j] - BuffDiff[i - j];
  end;
  for i := 0 to DX - 1 do // добиваем краешки неравновесной разностью
  begin
    for j := 1 to i do
    begin
      BuffDiff2[i] := BuffDiff2[i] + BuffDiff[i + j] - BuffDiff[i - j];
      BuffDiff2[MaxChannels - i] := BuffDiff2[MaxChannels - i] +
        BuffDiff[MaxChannels - i + j] - BuffDiff[MaxChannels - i - j];
    end;
  end;

  // Критерии и параметры пика
  min1 := 299;
  max1 := 299;
  max2 := 0;
  icL := 0;
  icR := 0;
  BuffDiff2[0] := 0;
  IsPeakFound := false;
  Result.Centre := 0;
  iLocalMin := MaxChannels - DX; // для оценки ямы после пика

  iAVGMax := 0;
  for j := MaxChannels downto 0 do
    if BuffAvg[j] > BuffAvg[iAVGMax] then
      iAVGMax := j;

  // ищем пик по критериям
  for i := MaxChannels - DX downto DX do // ищем первый пик справа по критериям
  begin
    if BuffWideAvgWOB[i] < BuffWideAvgWOB[iLocalMin] then
      iLocalMin := i;
    if fpCalcType=fpManual then // При указанных вручную границах оные в приоритете
    begin
      if (i<CDetector.N1) and (i+1>=CDetector.N1) then
      begin
        if BuffDiff2[i+1] > 0 then
          BuffDiff2[i]:=-1;
      end;
    end;

    if BuffDiff2[i] <= 0 then
    begin
      if (BuffDiff2[i + 1] > 0) then // пересечение из плюса в минус - возможно закончился второй бугор пика - запускаем критерии
      begin
        Sum := 0;

        for j := max1 to max2 do
          Sum := Sum + BuffAvgWOB[j];

        maybeBigPeak := i < iLocalMin - 10; // после пика есть локальный минимум

        // Критерий пика по второй производной
        IsPeakFound := True;
        if IsAdaptive then
        begin // критерии адаптивные надо прорабатывать по новой
          // Дополнительные критерии

            // Если найденный центр пика за пределами критериев ошибки
            if (not maybeBigPeak) and ((min1 >= iWaitingPeakCentre + OCE_max[cvGM1]) or (min1 <= iWaitingPeakCentre + OCE_min[cvGM1])) then
              IsPeakFound := false;

            // Если найденный центр пика правее зоны ожидания, а в зоне ожидания есть максимум выше
            if (min1 > iWaitingPeakCentre + OCW_max[cvGM1] - 10) then
              if (BuffAvg[imaxInWait] > BuffAvg[min1]) then
                if Abs(imaxInWait - min1) > 10 then // на случай если пик рядом с краем доверительной зоны
                  IsPeakFound := false;

          // локальный максимум заметно не совпадает с максимумом найденного пика   // нужен ли такой критерий?
            if iAVGMax < MaxChannels - 10 then // локальный максимум не скраю
              if (BuffAvg[iAVGMax] > 10) then // максимум не среди случайной малой статистики
                if (BuffAvg[min1] > 10) then // текущий максимум не среди случаной малой статистики
                  if Abs(min1 - iAVGMax) > 10 then
                    IsPeakFound := false;

          // Если найденный центр пика зона поиска фона
            if (min1 >= CDetector.BN2) then
              IsPeakFound := false;
        end;
        IsPeakFound := IsPeakFound and (Sum > MinS);
        IsPeakFound := IsPeakFound and (max2 - min1 >= MinDX);
        IsPeakFound := IsPeakFound and (icR - icL >= MinDX);
        IsPeakFound := IsPeakFound and (icR - min1 >= MinDX);
        if fpCalcType=fpManual
        then IsPeakFound := IsPeakFound and not(((min1>CDetector.N2) or (min1<CDetector.N1)))
        else IsPeakFound := IsPeakFound and (min1 > iWaitingPeakCentre-70); // центр пика

        if IsPeakFound then
        begin
          break;
        end;

        min1 := 0;
        icR := i;
      end;

      if BuffDiff2[i] < BuffDiff2[min1] then // минимум
      begin
        min1 := i;
      end;
    end
    else // BuffDiff2[i]>0
    begin
      if (BuffDiff2[i + 1] <= 0) then // пересечение из минуса в плюс
      begin
        max2 := max1;
        max1 := 0;
        icL := i;
      end;

      if BuffDiff2[i] > BuffDiff2[max1] then // максимум
      begin
        max1 := i;
      end;
    end
  end;

  // уточнение центра пика по работе с формой верхушки
  if IsPeakFound then
  begin
    if fpCalcType<>fpManual then
    case OptionsForm.RG_PeakInterestRange.ItemIndex of
    0:
      begin
        CDetector.N1 := max1;
        CDetector.N2 := max2;
      end;
    1:
      begin
        CDetector.N1 := icL;
        CDetector.N2 := icR;
      end;
    2, // не менять без фита
    3: // не менять
      else ; // не менять
    end;

    Result.Centre := min1;
    Result.LeftSigma := icL;
    Result.RightSigma := icR;
    Result.LeftEdge := max1;
    Result.RightEdge := max2;
  end;
  CDetector.PeakFound := IsPeakFound;
end;

var
  EndFit: TDateTime;
  LastProcessMessages: TDateTime;

procedure TCalcForm.FonGradientDown;
begin
  MainForm.Splash.ProgressBar.Minimum:=0;
  MainForm.Splash.ProgressBar.Maximum:=100;
  MainForm.Splash.ProgressBar.Position:=0;
  MainForm.Splash.Show(false);
  MainForm.Splash.SetCaption(rsFitFonTiltle);

  EndFit := Now + StrToInt(OptionsForm.Edit_NumSecondsToStopFit.Text)/24/60/60; // время остановки
  if not OptionsForm.CB_StopFitBySomeSec.Checked then EndFit := EndFit + 1/24; // заведомо дофига если нет ограничений по времени
  LastProcessMessages := Now;
  repeat
    if (SecondsBetween(Now, LastProcessMessages) > 2) and
      not OptionsForm.CB_NoProcessApplication.Checked then
    begin
      LastProcessMessages := Now;
      Application.ProcessMessages;
    end;
    MainForm.Splash.ProgressBar.Position:=(MainForm.Splash.ProgressBar.Position+1) mod MainForm.Splash.ProgressBar.Maximum;
    CalcForm.GradientFonDownAuto;
  until not OptionsForm.CB_FonSuperFit.Checked or FonGradientRecursionStop or (Now>EndFit);

  CalcForm.AssignCurrentFon(CDetector.Bt, CDetector.Bx0, CDetector.By0, CDetector.Bxy0, CDetector.Bdy);
  MainForm.Splash.Close;
end;

procedure TCalcForm.FormClose(Sender: TObject; var anAction: TCloseAction);
begin
  if OptionsForm.Showing then OptionsForm.Close;
end;

procedure TCalcForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  mRes : integer;
begin
  if bCalcForm_ExitNotifyIfManualChange and AW.IsHaveIRight(crCalc_Ranges_Edit) and (bOptionsChanged or (CalcType = ccManual)) then
  begin
//    mRes := MessageDlg(rsExitNotifyIfManualChange,mtWarning,mbYesNoCancel,0,mbNo,[rsYes,rsNo,rsCancel]);
    mRes := MessageDlg('',rsExitNotifyIfManualChange,mtConfirmation,[mbYes,mbNo,mbCancel],0);
    case mRes of
      mrYes: begin Btn_Save.Click; CanClose := True; Close; end;
      mrNo: begin Btn_GetDefault.Click; CanClose := True; Close; end;
      mrCancel: CanClose := False;
    end;
  end;
end;

procedure TCalcForm.FormCreate(Sender: TObject);
begin
  CDetector := Nil;
  DisableCalcControls := false;

  OutEnum := outBad;

  iWaitingPeakCentre := 210;
  WaitMaxWidth := 50;
  GradientStep := 0.01;
  GradientPiece := 1;
  Bt40 := 40;
  FP_TooLitleLevel := 0.2;
  SFonInterest:=0;
  BGFunc := bgfNone;

  Edit_S.Text := '';
  Edit_S.Hint := '';
  Edit_Err.Text := '';

  CalcType := ccAuto;
  ChartFunction := cfNone;
  MainAlgorithm := alFitting;
  MouseEdit := Edit_N1;

  FChartTitle:='';
  FChartSubTitle:='';
  FChartFooter:='';
  FChartSubFooter:='';

  ChartTool_N1_Value:=0;
  ChartTool_N2_Value:=0;
  ChartTool_N_Pen_Width :=1;
  ChartTool_N_Active:=false;
  ChartTool_N_AllowDrag:=false;
  ChartTool_BN1_Value:=0;
  ChartTool_BN1_Width:=1;
  ChartTool_BN2_Value:=0;
  ChartTool_BN2_Width:=1;
  ChartTool_BN1_Pen_Width:=1;
  ChartTool_BN2_Pen_Width:=1;

  SeriesSRC.active := false;
  SeriesGlade.active := true;
  SeriesSumPeaks.active := true;
  SeriesFon.active := true;
  SeriesFuncPik1.active := false;
  SeriesFuncPik2.active := false;
  SeriesInterestRegion.active := true;
  SeriesTempProfil.active := true;
  ChartCalc.AxisList[2].Visible:=true;
end;

function TCalcForm.FuncBackground(aBGFuncType:BGFuncType; i, aBx0, aBt, aBy0, aBxy0, aBdy : double): double;
var
  t: Double;
  t2: Double;
begin
  result:=0;
  case aBGFuncType of
    bgfExp:
      begin
        if (aBt>0.001) then
        begin
          t:=(i - aBx0) / aBt;
          if t>40 then t:=40;

          t2 := (aBxy0 - aBx0) / aBt;
          if t2>40 then t2:=40;

          Result := Exp(t) - Exp(t2) + aBy0;
        end
        else
          Result := 0;
      end;

    bgfStep:
      begin
        if (aBt>0.001) then
        begin
          t:= -1*(i - aBx0) / aBt;
          if t>40 then t:=40;
          Result := aBdy/(1 + exp(t)) + aBy0;
        end
        else
          Result := 0;
      end;
    bgfNone:
      begin
        Result := 0;
      end;
      else Result := 0;
  end;
end;

function TCalcForm.GetVLE_Float(aParamName: String; aDefault: double): double;
var
  St: String;
begin
  St := OptionsForm.VLE.Values[aParamName];
  if St = '' then
    Result := aDefault
  else
    Result := StrToFloatRegion(St);
end;

function TCalcForm.GetVLE_Int(aParamName: String; aDefault: integer): integer;
var
  St: String;
begin
  St := OptionsForm.VLE.Values[aParamName];
  if St = '' then
    Result := aDefault
  else
    Result := StrToInt(St);
end;

procedure TCalcForm.MainMenuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCalcForm.NChoose1Click(Sender: TObject);
begin
  SeriesSRC.active := true;
  SeriesGlade.active := true;
  SeriesSumPeaks.active := false;
  SeriesFon.active := false;
  SeriesFuncPik1.active := false;
  SeriesFuncPik2.active := false;
  SeriesInterestRegion.active := false;
  SeriesTempProfil.active := false;
  ChartCalc.AxisList[2].Visible:=false;
end;

procedure TCalcForm.NChoose2Click(Sender: TObject);
begin
  SeriesSRC.active := false;
  SeriesGlade.active := true;
  SeriesSumPeaks.active := false;
  SeriesFon.active := true;
  SeriesFuncPik1.active := false;
  SeriesFuncPik2.active := false;
  SeriesInterestRegion.active := false;
  SeriesTempProfil.active := false;
  ChartCalc.AxisList[2].Visible:=false;
end;

procedure TCalcForm.NChoose3Click(Sender: TObject);
begin
  SeriesSRC.active := false;
  SeriesGlade.active := true;
  SeriesSumPeaks.active := true;
  SeriesFon.active := true;
  SeriesFuncPik1.active := false;
  SeriesFuncPik2.active := false;
  SeriesInterestRegion.active := true;
  SeriesTempProfil.active := true;
  ChartCalc.AxisList[2].Visible:=true;
end;

procedure TCalcForm.NChoose4Click(Sender: TObject);
begin
  SeriesSRC.active := true;
  SeriesGlade.active := true;
  SeriesSumPeaks.active := true;
  SeriesFon.active := true;
  SeriesFuncPik1.active := true;
  SeriesFuncPik2.active := true;
  SeriesInterestRegion.active := true;
  SeriesTempProfil.active := true;
  ChartCalc.AxisList[2].Visible:=true;
end;

procedure TCalcForm.SB_UserWarningClick(Sender: TObject);
begin
  OutEnum := outBad;
  CDetector.Comment := rsBrookenMeasure;
  ChartSubFooter:='';
  ChartSubFooter:=CDetector.Comment;
  Btn_ClearWarning.Visible := True;
  Btn_Save.Enabled := True;
  SB_UserWarning.Visible := False;
  SB_UserWarning.Down:=false;
end;

procedure TCalcForm.ShowDataInChart(DosId, MeasId, DetId, MeasTime: String);
begin
  if (DetId <> '') AND (MeasId <> '') then
  begin
    if OptionsForm.CLB_Log.Checked[clogCRLF] then
      OptionsForm.REdit.Lines.Add(#13);

    if OptionsForm.CLB_Log.Checked[clogDetectorID] then
      OptionsForm.REdit.Lines.Add(rsDosimeter + ' ' + DosId + ', ' + rsDetector + ' ' + DetId +
        ', ' + rsTime + ' ' + MeasTime);
    QueryAndShowDetData(DosId, DetId, cFieldKTV, 0, MeasId);
  end;
end;

procedure TCalcForm.QueryAndShowDetData(DosId: String; DetId: String; ColumnName: String; Seria: integer; MeasId: String);
const
  B = 0.0000000011;
var
  i: integer;
  ts: TStringList;
begin
  if Assigned(CDetector) then
  begin

    ts := TStringList.Create;
    ts.Delimiter := ','; // устанавливаем разделитель
    ts.DelimitedText := CDetector.Ktv;;
    // записываем массив в строку
    ts.Text := StringReplace(ts.Text, '{', '', [rfreplaceall]);
    // удаляем фигурные скобки
    ts.Text := StringReplace(ts.Text, '}', '', [rfreplaceall]); //

//    ChartCalc.Title.Text.Text := Format('%s - %s; %s - %s (%s)',
//      [rsDosimeter, DosId, rsDetector, DetId, CDetector.DetType]);
//    ChartTitle := Format('%s - %s', [rsDosimeter, DosId]);
    ChartTitle := Format('%s - %s; %s - %s (%s)', [rsDosimeter, DosId, rsDetector, DetId, CDetector.DetType]);
    ChartSubTitle := Format('%s - %s (%s)', [rsDetector, DetId, CDetector.DetType]);

    if ts.Count = 1 then
      ts.Delete(0); // исключение для отсутствующих измерений

    FillChar(CDetector.BuffPulses, SizeOf(CDetector.BuffPulses), 0);

    for i := 0 to ts.Count - 1 do // выводим в TChart
    begin
      CDetector.BuffPulses[i] := StrToInt(ts[i]);
    end;

    PanelChart.Visible := length(CDetector.KTV)>3;

    CalcRefresh;

    ts.Free;
  end;
end;
{
procedure TCalcForm.ChartTool_N1DragLine(Sender: TColorLineTool);
begin
  ChartFunction := cfNone;
end;

procedure TCalcForm.ChartTool_N1EndDragLine(Sender: TColorLineTool);
var
  tmp_r : Double;
  St : String;
begin
  if ChartTool_N1.Value>ChartTool_N2.Value then // если линии поменялись местами
  begin
    tmp_r:=ChartTool_N1.Value;
    ChartTool_N1.Value:=ChartTool_N2.Value;
    ChartTool_N2.Value:=tmp_r;
    if ChartTool_N2.Visible and ChartTool_N2.Active and (St<>Edit_N2.Text) and (tmp_r<>-1) then
    begin
      St := FloatToStrRegionF(tmp_r,ffGeneral,3,1);
      Edit_N2.Text:= St;
    end;
  end;

  tmp_r:=ChartTool_N1.Value; // левая граница зоны интереса
  if ChartTool_N1.Visible and ChartTool_N1.Active and (St<>Edit_N1.Text) and (tmp_r<>-1) then
  begin
    St := FloatToStrRegionF(tmp_r,ffGeneral,3,1);
    Edit_N1.Text:= St;
  end;
  ChartFunction := cfNone;
end;

procedure TCalcForm.ChartTool_N2DragLine(Sender: TColorLineTool);
begin
  ChartFunction := cfNone;
end;

procedure TCalcForm.ChartTool_N2EndDragLine(Sender: TColorLineTool);
var
  tmp_r : Double;
  St : String;
begin
  if ChartTool_N1.Value>ChartTool_N2.Value then // если линии поменялись местами
  begin
    tmp_r:=ChartTool_N1.Value;
    ChartTool_N1.Value:=ChartTool_N2.Value;
    ChartTool_N2.Value:=tmp_r;
    if ChartTool_N1.Visible and ChartTool_N1.Active and (St<>Edit_N1.Text) and (tmp_r<>-1) then
    begin
      Edit_N1.Text:= St;
    end;
  end;

  tmp_r:=ChartTool_N2.Value;  // правая граница зоны интереса
  St := FloatToStrRegionF(tmp_r,ffGeneral,3,1);
  if ChartTool_N2.Visible and ChartTool_N2.Active and (St<>Edit_N2.Text) and (tmp_r<>-1) then
  begin
    Edit_N2.Text:= St;
  end;
  ChartFunction := cfNone;
end;

procedure TCalcForm.ChartTool_Peak4_XDragLine(Sender: TColorLineTool);
begin
  ChartFunction := cfPeak;
end;

procedure TCalcForm.ChartTool_Peak4_XEndDragLine(Sender: TColorLineTool);
var
  tmp_r : Double;
  St : String;
begin
  tmp_r:=ChartTool_Peak4_X.Value; // второй пик (А4) DGM2
  St := FloatToStrRegionF(tmp_r - StrToFloatRegion(Edit_GM1.Text),ffGeneral,6,3);
  if ChartTool_Peak4_X.Visible and ChartTool_Peak4_X.Active and (St<>Edit_DGM2.Text) and (tmp_r<>-1) and (tmp_r<>-2) then
  begin
    Edit_DGM2.Text:= St;
  end;

  ChartFunction := cfPeak;
end;

procedure TCalcForm.ChartTool_Peak4_YDragLine(Sender: TColorLineTool);
begin
  ChartFunction := cfPeak;
end;

procedure TCalcForm.ChartTool_Peak4_YEndDragLine(Sender: TColorLineTool);
var
  tmp_r : Double;
  St : String;
begin
  tmp_r:=ChartTool_Peak4_Y.Value - BuffBackground[Round(StrToFloatRegion(Edit_GM1.Text)+StrToFloatRegion(Edit_DGM2.Text))]; // второй пик (А4) высота DGA2
  St := FloatToStrRegionF(tmp_r / StrToFloatRegion(Edit_GA1.Text),ffGeneral,6,3);
  if ChartTool_Peak4_Y.Visible and ChartTool_Peak4_Y.Active and (St<>Edit_DGA2.Text) and (ChartTool_Peak4_Y.Value<>-1) then
  begin
    Edit_DGA2.Text:= St;
  end;
  ChartFunction := cfPeak;
end;

procedure TCalcForm.ChartTool_Peak5_XDragLine(Sender: TColorLineTool);
begin
  ChartFunction := cfPeak;
end;

procedure TCalcForm.ChartTool_Peak5_XEndDragLine(Sender: TColorLineTool);
var
  tmp_r : Double;
  St : String;
begin
  tmp_r:=ChartTool_Peak5_X.Value; // GM1
  St := FloatToStrRegionF(tmp_r,ffGeneral,6,3);
  if ChartTool_Peak5_X.Visible and ChartTool_Peak5_X.Active and (St<>Edit_GM1.Text) and (tmp_r<>-1) then
  begin
    Edit_GM1.Text:= St;
  end;
  ChartTool_Peak4_XEndDragLine(Sender);
  ChartFunction := cfPeak;
end;

procedure TCalcForm.ChartTool_Peak5_YDragLine(Sender: TColorLineTool);
begin
  ChartFunction := cfPeak;
end;

procedure TCalcForm.ChartTool_Peak5_YEndDragLine(Sender: TColorLineTool);
var
  tmp_r : Double;
  St : String;
begin
  tmp_r:=ChartTool_Peak5_Y.Value - BuffBackground[Round(StrToFloatRegion(Edit_GM1.Text))]; // высота GA1
  St := FloatToStrRegionF(tmp_r,ffGeneral,6,3);
  if ChartTool_Peak5_Y.Visible and ChartTool_Peak5_Y.Active and (St<>Edit_GA1.Text) and (ChartTool_Peak5_Y.Value<>-1) then
  begin
    Edit_GA1.Text:= St;
  end;
  ChartTool_Peak4_YEndDragLine(Sender);
  ChartFunction := cfPeak;
end;

procedure TCalcForm.ChartTool_BN1_DragLine(Sender: TColorLineTool);
begin
  Edit_BN1.Text := FloatToStrRegionF(ChartTool_Region_BN1.StartValue,ffGeneral,6,3);
  ChartFunction := cfBackGround;
end;

procedure TCalcForm.ChartTool_BN1_EndDragLine(Sender: TColorLineTool);
begin
  Edit_BN1.Text := FloatToStrRegionF(ChartTool_Region_BN1.StartValue,ffGeneral,6,3);
  ChartFunction := cfBackGround;
  if not DisableCalcControls then
    RecalcPeakByManual;
end;

procedure TCalcForm.ChartTool_Region_BN1Dragging(Sender: TObject);
var
  St : String;
begin
  St := FloatToStrRegionF(ChartTool_Region_BN1.StartValue,ffGeneral,6,3);
  if Edit_BN1.Text<>St then Edit_BN1.Text := St;

  ChartTool_BN1_Annotation.Value := (ChartTool_Region_BN1.StartValue + ChartTool_Region_BN1.EndValue)/2;
  ChartFunction := cfBackGround;
end;

procedure TCalcForm.ChartTool_Region_BN1Resized(Sender: TObject);
begin
  ChartTool_Region_BN1Resizing(Sender);
end;

procedure TCalcForm.ChartTool_Region_BN1Resizing(Sender: TObject);
var
  tmp_r : Double;
  St : String;
begin
  if ChartTool_Region_BN1.StartValue>ChartTool_Region_BN1.EndValue then // если линии поменялись местами
  begin
    tmp_r := ChartTool_Region_BN1.StartValue;
    ChartTool_Region_BN1.StartValue := ChartTool_Region_BN1.EndValue;
    ChartTool_Region_BN1.EndValue := tmp_r + 1;
  end;
  St := FloatToStrRegionF(ChartTool_Region_BN1.StartValue,ffGeneral,6,3);
  if Edit_BN1.Text<>St then Edit_BN1.Text := St;
  St := FloatToStrRegionF(ChartTool_Region_BN1.EndValue - ChartTool_Region_BN1.StartValue,ffGeneral,6,3);
  if Edit_BN1_width.Text<>St then Edit_BN1_width.Text := St;

  ChartTool_BN1_Annotation.Value := (ChartTool_Region_BN1.StartValue +ChartTool_Region_BN1.EndValue)/2;
  ChartFunction := cfBackGround;
end;

procedure TCalcForm.ChartTool_Region_BN2Dragging(Sender: TObject);
var
  St : String;
begin
  St := FloatToStrRegionF(ChartTool_Region_BN2.StartValue,ffGeneral,6,3);
  if Edit_BN2.Text<>St then Edit_BN2.Text := St;

  ChartTool_BN2_Annotation.Value := (ChartTool_Region_BN2.StartValue + ChartTool_Region_BN2.EndValue)/2;
  ChartFunction := cfBackGround;
end;

procedure TCalcForm.ChartTool_Region_BN2Resized(Sender: TObject);
begin
  ChartTool_Region_BN2Resizing(Sender);
end;

procedure TCalcForm.ChartTool_Region_BN2Resizing(Sender: TObject);
var
  tmp_r : Double;
  St : String;
begin
  if ChartTool_Region_BN2.StartValue>ChartTool_Region_BN2.EndValue then // если линии поменялись местами
  begin
    tmp_r := ChartTool_Region_BN2.StartValue;
    ChartTool_Region_BN2.StartValue := ChartTool_Region_BN2.EndValue;
    ChartTool_Region_BN2.EndValue := tmp_r + 1;
  end;
  St := FloatToStrRegionF(ChartTool_Region_BN2.StartValue,ffGeneral,6,3);
  if Edit_BN2.Text<>St then Edit_BN2.Text := St;
  St := FloatToStrRegionF(ChartTool_Region_BN2.EndValue - ChartTool_Region_BN2.StartValue,ffGeneral,6,3);
  if Edit_BN2_width.Text<>St then Edit_BN2_width.Text := St;

  ChartTool_BN2_Annotation.Value := (ChartTool_Region_BN2.StartValue +ChartTool_Region_BN2.EndValue)/2;
  ChartFunction := cfBackGround;
end;
}

procedure TCalcForm.Edit_GM1Change(Sender: TObject);
begin
  try
//    ChartTool_Peak5_X.Value:=StrToFloatRegion(Edit_GM1.Text);
//    ChartTool_Peak5_Y.Value:=StrToFloatRegion(Edit_GA1.Text) + BuffBackground[Round(StrToFloatRegion(Edit_GM1.Text))];
//    ChartTool_Peak4_X.Value:=StrToFloatRegion(Edit_GM1.Text) + StrToFloatRegion(Edit_DGM2.Text);
//    ChartTool_Peak4_Y.Value:=StrToFloatRegion(Edit_GA1.Text) * StrToFloatRegion(Edit_DGA2.Text) + BuffBackground[Round(StrToFloatRegion(Edit_GM1.Text)+StrToFloatRegion(Edit_DGM2.Text))];
  finally
  end;
  ChangeOptions(Sender);
end;

procedure TCalcForm.Edit_MouseEnter(Sender: TObject);
begin
  if tmMouseScroll<=0 then
    MouseEdit := TEdit(Sender);
end;

procedure TCalcForm.NOpt_CorrectDelimiters;
begin
  N_Delimiter.Visible := NOptDefault.Visible or NOptSaveOptions.Visible;
  N_Delimiter2.Visible := NOptUnSaveNotifyOff.Visible or NOptShowNegativeDoses.Visible;
  N_Delimiter3.Visible := NOptShowMenu.Visible or NOptShowChartEdit.Visible;
end;

procedure TCalcForm.Edit_DGM2Change(Sender: TObject);
begin
  try
//    ChartTool_Peak4_X.Value:=StrToFloatRegion(Edit_GM1.Text) + StrToFloatRegion(Edit_DGM2.Text);
//    ChartTool_Peak4_Y.Value:=StrToFloatRegion(Edit_GA1.Text) * StrToFloatRegion(Edit_DGA2.Text) + BuffBackground[Round(StrToFloatRegion(Edit_GM1.Text)+StrToFloatRegion(Edit_DGM2.Text))];
  finally
  end;
  ChangeOptions(Sender);
end;

procedure TCalcForm.Edit_GA1Change(Sender: TObject);
begin
  try
//    ChartTool_Peak5_Y.Value:=StrToFloatRegion(Edit_GA1.Text) + BuffBackground[Round(StrToFloatRegion(Edit_GM1.Text))];
//    ChartTool_Peak4_Y.Value:=StrToFloatRegion(Edit_GA1.Text) * StrToFloatRegion(Edit_DGA2.Text) + BuffBackground[Round(StrToFloatRegion(Edit_GM1.Text)+StrToFloatRegion(Edit_DGM2.Text))];
  finally
  end;
  ChangeOptions(Sender);
end;

procedure TCalcForm.Edit_DGA2Change(Sender: TObject);
begin
  try
//    ChartTool_Peak4_Y.Value:=StrToFloatRegion(Edit_GA1.Text) * StrToFloatRegion(Edit_DGA2.Text) + BuffBackground[Round(StrToFloatRegion(Edit_GM1.Text)+StrToFloatRegion(Edit_DGM2.Text))];
  finally
  end;
  ChangeOptions(Sender);
end;

procedure TCalcForm.Edit_N1Change(Sender: TObject);
begin
  try
    ChartTool_N1_Value := StrToFloatRegion(Edit_N1.Text);
    CDetector.N1 := ChartTool_N1_Value;
  finally
  end;
  if not DisableCalcControls then
    RecalcPeakByManual;
  ChangeOptions(Sender);
end;

procedure TCalcForm.Edit_N2Change(Sender: TObject);
begin
  try
    ChartTool_N2_Value := StrToFloatRegion(Edit_N2.Text);
    CDetector.N2 := ChartTool_N2_Value;
  finally
  end;
  if not DisableCalcControls then
    RecalcPeakByManual;
  ChangeOptions(Sender);
end;

procedure TCalcForm.Edit_BN1Change(Sender: TObject);
begin
  try
    CDetector.BN1 := StrToFloatRegion(Edit_BN1.Text);
    if CDetector.BN1>MaxChannels then CDetector.BN1:=MaxChannels;
    if CDetector.BN1<0 then CDetector.BN1:=0;
    ChartTool_BN1_Value := CDetector.BN1;
    ChartTool_BN1_Width := CDetector.BN1_Width;
//    ChartTool_BN1_Annotation.Value := (ChartTool_Region_BN1.StartValue + ChartTool_Region_BN1.EndValue)/2;

    if not DisableCalcControls then
    begin
      CDetector.By0 := FindFonExp_By0(CDetector,BuffAVG,round(CDetector.BN1),round(CDetector.BN1_width));
      EditBy0.Text := FloatToStrRegionF(CDetector.By0,ffGeneral,6,3);
      RecalcBackgroundByManual;
      RecalcPeakByManual;
    end;
    ChangeOptions(Sender);
  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['Edit_BN1Change',E.Message]));
  end;
end;

procedure TCalcForm.Edit_BN1_widthChange(Sender: TObject);
begin
  try
    CDetector.BN1_width := StrToFloatRegion(Edit_BN1_width.Text);
    ChartTool_BN1_width := CDetector.BN1_width;
    if not DisableCalcControls then
    begin
      CDetector.By0 := FindFonExp_By0(CDetector,BuffAVG,round(CDetector.BN1),round(CDetector.BN1_width));
      EditBy0.Text := FloatToStrRegionF(CDetector.By0,ffGeneral,6,3);
      RecalcBackgroundByManual;
      RecalcPeakByManual;
    end;
    ChangeOptions(Sender);
  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['Edit_BN1_widthChange',E.Message]));
  end;
end;

procedure TCalcForm.Edit_BN2Change(Sender: TObject);
begin
  try
    CDetector.BN2 := StrToFloatRegion(Edit_BN2.Text);
    ChartTool_BN2_Value := CDetector.BN2;
    ChartTool_BN2_width := CDetector.BN2_Width;
//    ChartTool_BN2_Annotation.Value := (ChartTool_Region_BN2.StartValue + ChartTool_Region_BN2.EndValue)/2;
    if not DisableCalcControls then
    begin
      RecalcBackgroundByManual;
      RecalcPeakByManual;
    end;
    ChangeOptions(Sender);
  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['Edit_BN2Change',E.Message]));
  end;
end;

procedure TCalcForm.Edit_BN2_widthChange(Sender: TObject);
begin
  try
    CDetector.BN2_width := StrToFloatRegion(Edit_BN2_width.Text);
    ChartTool_BN2_width := CDetector.BN2_width;

    if not DisableCalcControls then
    begin
      RecalcBackgroundByManual;
      RecalcPeakByManual;
    end;
    ChangeOptions(Sender);
  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['Edit_BN2_widthChange',E.Message]));
  end;
end;

procedure TCalcForm.RecalcBackgroundByManual;
var
  calcBt, calcBx0: double;
begin
  if not DisableCalcControls then
  try
    OutEnum := outGood;
    if BGFunc=bgfExp then
    begin
      FindFonExpByRange(round(CDetector.BN2), round(CDetector.BN2 + CDetector.BN2_width), kwidth, calcBt,calcBx0);
      CDetector.Bt  := calcBt;
      EditBt.Text:= FloatToStrRegionF(CDetector.Bt,ffGeneral,6,3);
      CDetector.Bx0 := calcBx0;
      EditBx0.Text:= FloatToStrRegionF(CDetector.Bx0,ffGeneral,6,3);
    end
      else
    if BGFunc=bgfStep then
    begin
      CDetector.Bx0 := (CDetector.BN1 + CDetector.BN1_width + CDetector.BN2)/2;
      EditBx0.Text:= FloatToStrRegionF(CDetector.Bx0,ffGeneral,6,3);
      CDetector.Bdy := FindFonStep_Bdy(CDetector.By0, round(CDetector.BN2),round(CDetector.BN2 + CDetector.BN2_width));
      EditBdy.Text:= FloatToStrRegionF(CDetector.Bdy,ffGeneral,6,3);
    end
  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['RecalcBackgroundByManual',E.Message]));
  end;
end;

procedure TCalcForm.RecalcPeakByManual;
var
  OldN1,OldN2: real;
begin
  DisableCalcControls := True;
  try
    OldN1 := CDetector.N1;//    OldN1 := ChartTool_N1.Value;
    OldN2 := CDetector.N2;//    OldN2 := ChartTool_N2.Value;
    CDetector.PeakFound := False;
    if OptionsForm.RG_TypeS.ItemIndex<>clcSquare then
    begin
      FoundPeak := FindPeak(fpManual);

      if CDetector.PeakFound then
      begin
        FoundPeakCorrection;
        tmRecalcManual := 4;
        CalcTimer.Enabled:=True;
        AssignCurrentPeak(CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR);
      end
      else CalcSquare;

      // выгородка для случаев когда пика нет, но очень хочется
      PeakSimulationIfNeed;
      CalcShow;   // отображение результатов по расчётам
      CDetector.N1 := OldN1;
      CDetector.N2 := OldN2;
      CalcOut;    // вывод результатов расчётов (в том числе в Excel)
    end
      else CalcSquare; // для OptionsForm.RG_TypeS.ItemIndex = clcSquare (Method = Area)
  finally
    DisableCalcControls := False;
  end;
end;

function TCalcForm.GradientDownStep(var v: TParamArray; DoLog: boolean): double;
// шаг по градиентному спуску и возвращаем разницу
var
  i, j: integer;
  srcv, vb, dv, gradient: TParamArray;
  Mv, Yv, Yz: double;
  SumErr: double;
  bDoStep1,bDoStep2,bDoSteps : boolean;
  Exceed: boolean;
begin
  Yv := Hi2_Func(v);
  SumErr := 0;
  for i := 1 to 6 do
  begin
    srcv[i] := v[i];
    for j := 1 to 6 do
      vb[j] := v[j];
    vb[i] := vb[i] + GradientStep;
    dv[i] := Hi2_Func(vb);
    SumErr := SumErr + Abs(Yv - dv[i]);
  end;
  Mv := max(0.0000001, SumErr * GradientPiece);
  bDoSteps := not OptionsForm.CB_WaitingsApriory.Checked;
  for i := 1 to 6 do
  begin
    gradient[i] := GradientStep * (Yv - dv[i]) / Mv;
// предотвращение перехода в ошибку при фите
    if bDoSteps then
    begin
      if i=1 // для GM1 OCE - смещение
      then
        begin
          bDoStep1 := (v[i]-iWaitingPeakCentre > OCE_min[TCriteriaValues(i+3-1)]) and (v[i]-iWaitingPeakCentre < OCE_max[TCriteriaValues(i+3-1)]); // проверка на выход за пределы до
          bDoStep2 := (v[i]-iWaitingPeakCentre + gradient[i] > OCE_min[TCriteriaValues(i+3-1)]) and (v[i]-iWaitingPeakCentre + gradient[i] < OCE_max[TCriteriaValues(i+3-1)]); // проверка на выход за пределы после
        end
      else
        begin
          bDoStep1 := (v[i] > OCE_min[TCriteriaValues(i+3-1)]) and (v[i] < OCE_max[TCriteriaValues(i+3-1)]); // проверка на выход за пределы до
          bDoStep2 := (v[i] + gradient[i] > OCE_min[TCriteriaValues(i+3-1)]) and (v[i] + gradient[i] < OCE_max[TCriteriaValues(i+3-1)]); // проверка на выход за пределы после
        end;
    end;
    if bDoSteps or (not bDoStep1 or bDoStep2) then // проверка на выход за пределы
    begin
// работа с предупреждениями
      if OptionsForm.CB_WaitingsApriory.Checked
      then
        begin
          if i=1  // для GM1 OCE - смещение
          then Exceed:=(v[i]-iWaitingPeakCentre >= OCW_min[TCriteriaValues(i+3-1)]) and (v[i]-iWaitingPeakCentre <= OCW_max[TCriteriaValues(i+3-1)])
          else  Exceed:=(v[i] >= OCW_min[TCriteriaValues(i+3-1)]) and (v[i] <= OCW_max[TCriteriaValues(i+3-1)]);

          if Exceed then // проверка на невыход за пределы
          begin
            v[i] := v[i] + gradient[i];
          end
            else
          begin
            // для выхода DGA2 за пределы при больших DGM2, пробуем придвинуть пики
            if (i=4) and (-v[2]>v[5]+v[6]) then
              v[2]:=v[2]+1;
              //v[1] = CDetector.GM1;
              //v[2] = CDetector.DGM2;
              //v[3] = CDetector.GA1;
              //v[4] = CDetector.DGA2;
              //v[5] = CDetector.GSL;
              //v[6] = CDetector.GSR;

          end
        end
      else
        v[i] := v[i] + gradient[i];
    end;

  end;
  Yz := Hi2_Func(v);
  if OptionsForm.CLB_Log.Checked[clogFitPik] then
    if DoLog then
      OptionsForm.REdit.Lines.Add(' gradient step[' +
        FloatToStrRegion(gradient[1]) + ', ' + FloatToStrRegion(gradient[2]) +
        ', ' + FloatToStrRegion(gradient[3]) + ', ' +
        FloatToStrRegion(gradient[4]) + ', ' + FloatToStrRegion(gradient[5]) +
        ', ' + FloatToStrRegion(gradient[6]) + ']   Mv=' +
        FloatToStrRegion(Mv));

  Result := Yz;
end;

procedure TCalcForm.GradientFonDownAuto;
var
  i, j, iMinF, MaxAutoSteps: integer;
  v, vsrc, vmin: TParamArray;
  SrcF, MinF, CurF: double;
begin
  MaxAutoSteps := OptionsForm.SE_FonMaxAutoSteps.value;
  v[1] := CDetector.Bx0;
  v[2] := CDetector.Bt;
  v[3] := CDetector.By0;
  v[4] := CDetector.Bxy0;
  v[5] := CDetector.Bdy;

  SrcF := Hi2_Fon(v[1], v[2], v[3], v[4], v[5]);
  iMinF := 1;
  MinF := SrcF;

  vsrc := v;
  vmin := v;

  for i := 2 to MaxAutoSteps do
  begin
    CurF := GradientFonDownStep(v[1], v[2], v[3], v[4], v[5]);
    if CurF < MinF then
    begin
      for j := 1 to 2 do
        vmin[j] := v[j];
      for j := 4 to 5 do
        vmin[j] := v[j];
      iMinF := i;
      MinF := CurF;
    end;
  end;

  v[1] := vmin[1];
  v[2] := vmin[2];
//  v[3] := vmin[3]; //  not used
//  v[4] := vmin[4];
  v[5] := vmin[5];

  if (iMinF >= MaxAutoSteps * 0.1) and (Abs(SrcF - MinF) > minErrF)
  then FonGradientRecursionStop := False
  else FonGradientRecursionStop := True;

  if OptionsForm.CLB_Log.Checked[clogFitFon] then
    OptionsForm.REdit.Lines.Add
      ('Gradient background descent, the best result ' + IntToStr(iMinF) +
      ' the error is reduced from ' + FloatToStrRegion(SrcF) + '  to ' +
      FloatToStrRegion(MinF));

  CDetector.Bx0 := v[1];
  CDetector.Bt  := v[2];
  CDetector.By0 := v[3];
  CDetector.Bxy0 := v[4];
  CDetector.Bdy := v[5];
end;

function TCalcForm.GradientFonDownStep(var aBx0, aBt, aBy0, aBxy0, aBdy: double): double;
var
  dv, gradient: TParamArray;
  Mv, Yv, Yz: double;
  SumErr: double;
begin
  Yv := Hi2_Fon(aBx0, aBt, aBy0, aBxy0, aBdy);

  dv[1] := Hi2_Fon(aBx0 + GradientStep, aBt, aBy0, aBxy0, aBdy);
  dv[2] := Hi2_Fon(aBx0, aBt + GradientStep, aBy0, aBxy0, aBdy);
  dv[5] := Hi2_Fon(aBx0, aBt, aBy0, aBxy0, aBdy + GradientStep);

  SumErr := Abs(Yv - dv[1]) + Abs(Yv - dv[2]) + Abs(Yv - dv[5]);

  Mv := max(0.0000001, SumErr * GradientPiece);
  gradient[1] := GradientStep * (Yv - dv[1]) / Mv;
  gradient[2] := GradientStep * (Yv - dv[2]) / Mv;
  gradient[5] := GradientStep * (Yv - dv[5]) / Mv;

  aBx0 := aBx0 + gradient[1];
  aBt := aBt + gradient[2];
  aBdy := aBdy + gradient[5];

  Yz := Hi2_Fon(aBx0, aBt, aBy0, aBxy0, aBdy);

  Result := Yz;
end;

procedure TCalcForm.GradiendDown;
begin
  MainForm.Splash.ProgressBar.Minimum:=0;
  MainForm.Splash.ProgressBar.Maximum:=100;
  MainForm.Splash.ProgressBar.Position:=0;
  MainForm.Splash.Show(false);
  MainForm.Splash.SetCaption(rsFitPeakTiltle);

  LastProcessMessages := Now;
  EndFit := Now + StrToInt(OptionsForm.Edit_NumSecondsToStopFit.Text)/24/60/60; // время остановки
  if not OptionsForm.CB_StopFitBySomeSec.Checked then EndFit := EndFit + 1/24; // заведомо дофига если нет ограничений по времени
  repeat
    if (SecondsBetween(Now, LastProcessMessages) > 2) and
      not OptionsForm.CB_NoProcessApplication.Checked then
    begin
      LastProcessMessages := Now;
      CalcForm.CalcShow; // промежуточная прорисовка
      Application.ProcessMessages;
    end;

//    CalcForm.minErr := StrToFloatRegion(OptionsForm.Edit_MinErr.Text) *              //***-раскоментировал
//      StrToFloatRegion(CalcForm.Edit_Err.Text);                                      //***-раскоментировал
//    CalcForm.GradientStep := StrToFloatRegion(OptionsForm.EditStep.Text);            //***-раскоментировал
//    CalcForm.GradientPiece := StrToFloatRegion(OptionsForm.EditPiece.Text);          //***-раскоментировал

    MainForm.Splash.ProgressBar.Position:=(MainForm.Splash.ProgressBar.Position+1) mod MainForm.Splash.ProgressBar.Maximum;
    CalcForm.GradientDownAuto;
  until not OptionsForm.CB_SuperFit.Checked or GradientRecursionStop or (Now>EndFit) or (CDetector.S < MinS_4SuperFit);
//  CalcForm.StatusBar.Panels[4].Text := 'П.Фит OK';
  MainForm.Splash.Close;

  //if OptionsForm.CB_NoProcessApplication.Checked then //финализация
  //  begin
  //    LastProcessMessages := Now;
  //    CalcForm.CalcShow; // промежуточная прорисовка
  //    Application.ProcessMessages;
  //  end;
end;

procedure TCalcForm.GradientDownAuto;
var
  i, iMinF, MaxAutoSteps: integer;
  v, vsrc, vmin: TParamArray;
  SrcF, MinF, CurF, Buf: double;
  SaveN1, SaveN2, SaveN: double;
  OffsetH2: double;
begin
  MaxAutoSteps := OptionsForm.SE_MaxAutoSteps.value;

  v[1] := CDetector.GM1;
  v[2] := CDetector.DGM2;
  v[3] := CDetector.GA1;
  v[4] := CDetector.DGA2;
  v[5] := CDetector.GSL;
  v[6] := CDetector.GSR;

  SrcF := Hi2_Func(v);
  iMinF := 1;
  MinF := SrcF;
  vsrc := v;
  vmin := v;

  for i := 2 to MaxAutoSteps do
  begin
    CurF := GradientDownStep(v, false);
    if (CurF < MinF) then
    begin
      vmin := v;
      iMinF := i;
      MinF := CurF;
    end;
  end;

  v := vmin;

  if (iMinF >= MaxAutoSteps * 0.1) and (Abs(SrcF - MinF) > minErr) then
    GradientRecursionStop := False
  else
    GradientRecursionStop := True;

  if OptionsForm.CLB_Log.Checked[clogFitPik] then
    OptionsForm.REdit.Lines.Add
      ('Gradient peak descent, the best result ' + IntToStr(iMinF) +
      ' the error is reduced from ' + FloatToStrRegion(SrcF) + '  to ' +
      FloatToStrRegion(MinF) + '  values: ' + FloatToStrRegion(v[1]) + ', '
      + FloatToStrRegion(v[2]) + ', ' + FloatToStrRegion(v[3]) + ', ' +
      FloatToStrRegion(v[4]) + ', ' + FloatToStrRegion(v[5]) + ', ' +
      FloatToStrRegion(v[6]));

  CDetector.GM1  := v[1];
  CDetector.DGM2 := v[2];
  CDetector.GA1  := v[3];
  CDetector.DGA2 := v[4];
  CDetector.GSL  := v[5];
  CDetector.GSR  := v[6];

  if OptionsForm.CB_FitChangeRange.Checked and (CDetector.S>MinS_4FitChangeRange) then
  begin
    SaveN1 := CDetector.N1;
    SaveN2 := CDetector.N2;

    case OptionsForm.RG_PeakInterestRange.itemIndex of
    0:
      begin
        Buf := StrToFloatRegion(OptionsForm.Edit_InterestCriteriaLeft.Text);
        CDetector.N1 := round(CDetector.GM1 - CDetector.GSL * Buf);
        Buf := StrToFloatRegion(OptionsForm.Edit_InterestCriteriaRight.Text);
        CDetector.N2 := round(CDetector.GM1 + CDetector.GSR * Buf);

        CurF := GradientDownStep(v, false);
        if CurF > MinF then
        begin
          CDetector.N1 := SaveN1;
          CDetector.N2 := SaveN2;
        end;
     end;
    1:
      begin
        CDetector.N1 := round(CDetector.GM1 - WaitMaxWidth);
        CDetector.N2 := round(CDetector.GM1 + WaitMaxWidth);

        CurF := GradientDownStep(v, false);
        if CurF > MinF then
        begin
          CDetector.N1 := SaveN1;
          CDetector.N2 := SaveN2;
        end;
      end;
    2:
    begin
      if (CDetector.DGM2>-30) // чтобы не провоцировать растягивание CDtetector.DGM2 с растягиванием зоны
        and (CDetector.GM1>iWaitingPeakCentre+OCW_min[cvGM1]) // чтобы не провоцировать смещение CDtetector.GM1 с растягиванием зоны
        and (CDetector.GM1+CDetector.DGM2-2*CDetector.GSL>CDetector.N1) // чтобы не уйти из зоны пиков случайно
      then
        begin
          SaveN:=CDetector.N1;
          CDetector.N1 := SaveN1-1;
          OffsetH2 := Hi2_Func(v);
          if OffsetH2>MinF
            then CDetector.N1 := SaveN
            else MinF:=OffsetH2;
         end;

      if (CDetector.DGM2<-10) // чтобы не провоцировать сжатие CDtetector.DGM2 со сжатием зоны
        and (CDetector.GM1<iWaitingPeakCentre+OCW_max[cvGM1]) // чтобы не провоцировать смещение CDtetector.GM1 со сжатием зоны
        and (CDetector.GM1+CDetector.DGM2>CDetector.N1) // чтобы не уйти из зоны пиков случайно
      then
        begin
          SaveN:=CDetector.N1;
          CDetector.N1 := SaveN1+1;
          OffsetH2 := Hi2_Func(v);
          if (OffsetH2>=MinF)
            then CDetector.N1 := SaveN
            else MinF:=OffsetH2;
         end;

      if (CDetector.DGM2<-10) // чтобы не провоцировать сжатие CDtetector.DGM2 со сжатием зоны
        and (CDetector.GM1<iWaitingPeakCentre+OCW_max[cvGM1]) // чтобы не провоцировать смещение CDtetector.GM1 со сжатием зоны
        and (CDetector.GM1+CDetector.GSR<CDetector.N2) // чтобы не уйти из зоны пиков случайно
      then
        begin
          SaveN:=CDetector.N2;
          CDetector.N2 := SaveN2-1;
          OffsetH2 := Hi2_Func(v);
          if OffsetH2>=MinF
            then CDetector.N2 := SaveN
            else MinF:=OffsetH2;
        end;

      if (CDetector.DGM2>-30) // чтобы не провоцировать растягивание CDtetector.DGM2 с растягиванием зоны
        and (CDetector.GM1<iWaitingPeakCentre+OCW_max[cvGM1]) // чтобы не провоцировать смещение CDtetector.GM1 с растягиванием зоны
        and (CDetector.GM1+2*CDetector.GSR<CDetector.N2) // чтобы не уйти из зоны пиков случайно
        and (CDetector.N2<CDetector.BN2) // чтобы не уйти в зону фона случайно
      then
        begin
          SaveN:=CDetector.N2;
          CDetector.N2 := SaveN2+1;
          OffsetH2 := Hi2_Func(v);
          if (OffsetH2>=CurF)
            then CDetector.N2 := SaveN
            else MinF:=OffsetH2;
        end;
//      CDetector.N1 := SaveN1;
//      CDetector.N2 := SaveN2;
    end;
    3: ; // ничего не меняем
      else // ничего не меняем
    end;
    // коррекция на случай ухода границ за пределы разумного
    if CDetector.N1 > 295 then CDetector.N1 := 295;
    if CDetector.N2 > 295 then CDetector.N2 := 295;
    if CDetector.N1 < 5 then CDetector.N1 := 5;
    if CDetector.N2 < 5 then CDetector.N2 := 5;
{
    CurF := GradientDownStep(v, false);
    if CurF > MinF then
    begin
      CDetector.N1 := SaveN1;
      CDetector.N2 := SaveN2;
    end;
}
    CalcForm.Edit_N1.Text := FloatToStrRegionF(CDetector.N1,ffGeneral,3,1);
    CalcForm.Edit_N2.Text := FloatToStrRegionF(CDetector.N2,ffGeneral,3,1);
  end;
end;

// Excel section
var
  {$IFDEF MSWINDOWS}
  WorkBook: OleVariant;
  {$ELSE}
  WorkBook: TsWorkBook;
  {$ENDIF}
  rowExcel: integer = 1;
  errExcel: integer = 0;
  oldRowDBID: String = 'NO';

function TCalcForm.CheckExcelRun: boolean;
begin
  {$IFDEF MSWINDOWS}
  try
    MyExcel := GetActiveOleObject(cExcelApp);
    Result := True;
  except
    Result := false;
  end;
  {$ELSE}
  Result := false;
  {$ENDIF}
end;

{$IFDEF MSWINDOWS}
procedure MakeHeader(aMyExcel: Variant);
begin
  aMyExcel.Cells[1, 1].value := 'Calc Time';
  aMyExcel.Columns[1].ColumnWidth := 20;

  aMyExcel.Cells[1, 2].value := 'Dosimeter';
  aMyExcel.Columns[2].ColumnWidth := 10;

  aMyExcel.Cells[1, 3].value := 'Measurement ID';
  aMyExcel.Columns[3].ColumnWidth := 15;

  aMyExcel.Cells[1, 4].value := 'Detector';
  aMyExcel.Columns[4].ColumnWidth := 10;

  aMyExcel.Cells[1, 5].value := 'Measurement time';
  aMyExcel.Columns[5].ColumnWidth := 20;

  aMyExcel.Cells[1, 6].value := 'Dose from DB, mZv';
  aMyExcel.Columns[6].ColumnWidth := 20;

  aMyExcel.Cells[1, 7].value := 'Measurement status';
  aMyExcel.Columns[7].ColumnWidth := 20;

  aMyExcel.Cells[1, 8].value := 'K of dosimeter';
  aMyExcel.Columns[8].ColumnWidth := 15;

  aMyExcel.Cells[1, 9].value := 'Error';
  aMyExcel.Cells[1, 10].value := 'CDetector.N1';
  aMyExcel.Cells[1, 11].value := 'CDetector.N2';

  aMyExcel.Cells[1, 13].value := 'Bt';
  aMyExcel.Cells[1, 14].value := 'Bx0';
  aMyExcel.Cells[1, 15].value := 'By0';

  aMyExcel.Cells[1, 17].value := 'GM1';
  aMyExcel.Cells[1, 18].value := 'DGM2';
  aMyExcel.Cells[1, 19].value := 'GA1';
  aMyExcel.Cells[1, 20].value := 'DGA2';
  aMyExcel.Cells[1, 21].value := 'GSL';
  aMyExcel.Cells[1, 22].value := 'GSR';

  aMyExcel.Cells[1, 24].value := '-Reserved-';
  aMyExcel.Cells[1, 25].value := 'SA5';
  aMyExcel.Cells[1, 26].value := 'Dose';

  aMyExcel.Cells[1, 28].value := 'Status (text)';
  aMyExcel.Columns[28].ColumnWidth := 30;

  aMyExcel.Cells[1, 29].value := 'Out enum';
  aMyExcel.Cells[1, 30].value := 'Out comment';
  aMyExcel.Columns[30].ColumnWidth := 60;

  aMyExcel.Cells[1, 31].value := 'MeasComment';
  aMyExcel.Columns[31].ColumnWidth := 15;

  aMyExcel.Cells[1, 32].value := 'Excel errors';
  aMyExcel.Columns[32].ColumnWidth := 15;

  aMyExcel.Cells[2, 1].value := OptionsForm.EditExcelRemark.Text;
//  aMyExcel.Cells[2, 1].value := OptionsForm.EditExcelRemark.Text;
end;
{$ELSE}
procedure MakeHeader(aMyExcel: TsWorkSheet);
begin
  aMyExcel.WriteCellValueAsString(1,1,'Calc Time');
  aMyExcel.WriteColWidth(1,20);

  aMyExcel.WriteCellValueAsString(1,2,'Dosimeter');
  aMyExcel.WriteColWidth(2,10);

  aMyExcel.WriteCellValueAsString(1,3,'Measurement ID');
  aMyExcel.WriteColWidth(3,15);

  aMyExcel.WriteCellValueAsString(1,4,'Detector');
  aMyExcel.WriteColWidth(4,10);

  aMyExcel.WriteCellValueAsString(1,5,'Measurement time');
  aMyExcel.WriteColWidth(5,20);

  aMyExcel.WriteCellValueAsString(1,6,'Dose from DB, mZv');
  aMyExcel.WriteColWidth(6,20);

  aMyExcel.WriteCellValueAsString(1,7,'Measurement status');
  aMyExcel.WriteColWidth(7,20);

  aMyExcel.WriteCellValueAsString(1,8,'K of dosimeter');
  aMyExcel.WriteColWidth(8,15);

  aMyExcel.WriteCellValueAsString(1,9,'Error');
  aMyExcel.WriteCellValueAsString(1,10,'CDetector.N1');
  aMyExcel.WriteCellValueAsString(1,11,'CDetector.N2');

  aMyExcel.WriteCellValueAsString(1,13,'Bt');
  aMyExcel.WriteCellValueAsString(1,14,'Bx0');
  aMyExcel.WriteCellValueAsString(1,15,'By0');

  aMyExcel.WriteCellValueAsString(1,17,'GM1');
  aMyExcel.WriteCellValueAsString(1,18,'DGM2');
  aMyExcel.WriteCellValueAsString(1,19,'GA1');
  aMyExcel.WriteCellValueAsString(1,20,'DGA21');
  aMyExcel.WriteCellValueAsString(1,21,'GSL');
  aMyExcel.WriteCellValueAsString(1,22,'GSR');

  aMyExcel.WriteCellValueAsString(1,24,'-Reserved-');
  aMyExcel.WriteCellValueAsString(1,25,'SA5');
  aMyExcel.WriteCellValueAsString(1,26,'Dose');

  aMyExcel.WriteCellValueAsString(1,28,'Status (text)');
  aMyExcel.WriteColWidth(28,30);

  aMyExcel.WriteCellValueAsString(1,29,'Out enum');
  aMyExcel.WriteCellValueAsString(1,30,'Out comment');
  aMyExcel.WriteColWidth(30,60);

  aMyExcel.WriteCellValueAsString(1,31,'MeasComment');
  aMyExcel.WriteColWidth(31,15);

  aMyExcel.WriteCellValueAsString(1,32,'Excel errors');
  aMyExcel.WriteColWidth(32,15);

  aMyExcel.WriteCellValueAsString(2,1,OptionsForm.EditExcelRemark.Text);
end;
{$ENDIF}

procedure TCalcForm.SaveToExcel(aTypeExcelOut: TTypeExcelOut);
type
//  CyrString = AnsiString;
  CyrString = RAWByteString;
var
  i, j: Longint;
  StDosNum, StDetNum, StTime, StMeasID, StBaseDose: CyrString;
  StMeasStatus: CyrString;
  exSh: Variant;
  NoEntry: boolean;
  StSheetNumber: CyrString;
  StImageName: CyrString;
  Worksheet,Worksheet2 : TsWorkSheet;

begin

  // вывод в Excel
  try
    {$IFDEF MSWINDOWS}
    if not CheckExcelRun then
    begin
      MyExcel := CreateOleObject('Excel.Application');
      MyExcel.visible := True;
      WorkBook := MyExcel.WorkBooks.Add;
      SetForegroundWindow(Handle);
    end
    else
      WorkBook := MyExcel.ActiveWorkBook;
    {$ELSE}
    Workbook := TsWorkbook.Create;
//      Worksheet := Workbook.AddWorksheet('My_Table');
    Worksheet := Workbook.AddWorksheet('New WS');
    //  MyWorksheet.WriteNumber(0, 0, 1.0);  // "A1" has row=0 and col=0
    {$ENDIF}

    StSheetNumber := '';
    case aTypeExcelOut of
      eoAll:
        StSheetNumber := OptionsForm.EditExcelRemark.Text;
      eoByComment:
        begin
          StSheetNumber := MainForm.EditMeasDataComment.Text;
          while length(StSheetNumber) < 5 do
            StSheetNumber := '0' + StSheetNumber;
        end;
      eoByDosimeter:
        StSheetNumber := MainForm.DBGridEhProcess.DataSource.DataSet.Fields
          [0].AsString;
    end;
    if StSheetNumber = '' then
      StSheetNumber := 'No Name';

    NoEntry := True;
    if rowExcel = 1 then
    begin
      {$IFDEF MSWINDOWS}
      exSh := MyExcel.ActiveWorkBook.ActiveSheet;
      exSh.name := StSheetNumber;
      MakeHeader(MyExcel);
      {$ELSE}
      WorkSheet2 := WorkBook.ActiveWorksheet;
      WorkSheet2.name := StSheetNumber;
      MakeHeader(Worksheet);
      {$ENDIF}
      rowExcel := 2;
    end;

    {$IFDEF MSWINDOWS}
    for j := 1 to WorkBook.Worksheets.Count do
    begin
      if (WorkBook.Worksheets[j].name = StSheetNumber) then
      begin
        NoEntry := false;
        WorkBook.Worksheets[j].Select;
        if (MyExcel.Cells[1, 35].value <> 0) then
          rowExcel := MyExcel.Cells[1, 35].value
        else
          rowExcel := 2;
        break;
      end;
    end;
    {$ELSE}
    for j := 1 to WorkBook.GetVisibleWorksheetCount do
    begin
      if (WorkBook.GetWorksheetByIndex(j).name = StSheetNumber) then
      begin
        NoEntry := false;
        WorkBook.ActiveWorksheet:=WorkBook.GetWorksheetByIndex(j);
        if (WorkBook.ActiveWorksheet.ReadAsNumber(1,35) <> 0) then
          rowExcel := Round(WorkBook.ActiveWorksheet.ReadAsNumber(1,35))
        else
          rowExcel := 2;
        break;
      end;
    end;
    {$ENDIF}

    if NoEntry then
    begin
    {$IFDEF MSWINDOWS}
      exSh := WorkBook.Worksheets.Add(After := WorkBook.Worksheets
        [WorkBook.Worksheets.Count]);
      exSh.Select;
      exSh.name := StSheetNumber;
      MakeHeader(MyExcel);
      rowExcel := 2;
    {$ELSE}
    WorkSheet2 := WorkBook.AddWorksheet(StSheetNumber);
    WorkBook.ActiveWorksheet:=WorkSheet2;
    MakeHeader(WorkSheet2);
    rowExcel := 2;
    {$ENDIF}
    end;

  except
    errExcel := errExcel + 1;
  end;

  StDosNum := MainForm.DBGridEhProcess.DataSource.DataSet.FieldByName(cFullDosID).AsString;
  StMeasID := MainForm.DataSourceProcessList.DataSet.FieldByName(cFieldDosMeasID).AsString;
  if pos('Cu',CDetector.DetType)=0
  then StBaseDose := MainForm.DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldHp10g).AsString
  else StBaseDose := MainForm.DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldHp007).AsString;
  StDetNum := IntToStr(MainForm.Dosimeter.DetectorsCnt);

  StTime := MainForm.DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldMeasureTime).AsString;
  StMeasStatus := MainForm.DBGridEhProcess.DataSource.DataSet.FieldByName(cFieldStringValidity).AsString;
  if (oldRowDBID = StMeasID + StDetNum) then
    rowExcel := rowExcel - 1;
  // выводим промежуточные результаты в ту же строку пока расчёт не окончен
  oldRowDBID := StMeasID + StDetNum;

  try
    i := rowExcel;
    {$IFDEF MSWINDOWS}
    MyExcel.Cells[i + 2, 1].value := DateTimeToStr(Now);              //A
    MyExcel.Cells[i + 2, 2].value := StDosNum;                        //B
    MyExcel.Cells[i + 2, 3].value := StMeasID;                        //C
    MyExcel.Cells[i + 2, 4].value := StDetNum;                        //D
    MyExcel.Cells[i + 2, 5].value := StTime;                          //E
    MyExcel.Cells[i + 2, 6].value := StrToFloatRegion(StBaseDose);    //F

    MyExcel.Cells[i + 2, 7].value := StMeasStatus;                    //G
    MyExcel.Cells[i + 2, 8].value := MainForm.LblProcessDataKDosVal.Caption; //H

    MyExcel.Cells[i + 2, 9].value := Edit_Err.Text;                   //I
    MyExcel.Cells[i + 2, 10].value := Edit_N1.Text;                   //J
    MyExcel.Cells[i + 2, 11].value := Edit_N2.Text;                   //K

    MyExcel.Cells[i + 2, 13].value := EditBt.Text;                    //M
    MyExcel.Cells[i + 2, 14].value := EditBx0.Text;                   //N
    MyExcel.Cells[i + 2, 15].value := EditBy0.Text;                   //O

    MyExcel.Cells[i + 2, 17].value := Edit_GM1.Text;                  //Q
    MyExcel.Cells[i + 2, 18].value := Edit_DGM2.Text;                 //R
    MyExcel.Cells[i + 2, 19].value := Edit_GA1.Text;                  //S
    MyExcel.Cells[i + 2, 20].value := Edit_DGA2.Text;                 //T
    MyExcel.Cells[i + 2, 21].value := Edit_GSL.Text;                  //U
    MyExcel.Cells[i + 2, 22].value := Edit_GSR.Text;                  //V

    MyExcel.Cells[i + 2, 25].value := FloatToStrRegionF(CDetector.S, ffFixed, 8, 2);   //Y
    MyExcel.Cells[i + 2, 26].value := FloatToStrRegionF(CDetector.Dose, ffFixed, 8, 2); //Z   Edit_S.Text;

    MyExcel.Cells[i + 2, 28].value := ord(CDetector.State);           //AB
    MyExcel.Cells[i + 2, 29].value := ORD(OutEnum);                   //AC
    MyExcel.Cells[i + 2, 30].value := CDetector.Comment;              //AD
    MyExcel.Cells[i + 2, 31].value := MainForm.Dosimeter.MeasComment; //AE
    MyExcel.Cells[i + 2, 32].value := IntToStr(errExcel);             //AF

    MyExcel.Cells[2, 2].formula := '=AVERAGE(Z4:Z'+intToStr(i+2)+')';
    MyExcel.Cells[3, 2].formula := '=StDev(Z4:Z'  +intToStr(i+2)+')';

    rowExcel := rowExcel + 1;
    MyExcel.Cells[1, 35].value := IntToStr(rowExcel);
    {$ELSE}
    WorkBook.ActiveWorksheet.WriteText(i + 2, 1,DateTimeToStr(Now));
    WorkBook.ActiveWorksheet.WriteText(i + 2, 2,StDosNum);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 3,StMeasID);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 4,StDetNum);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 5, StTime);
    WorkBook.ActiveWorksheet.WriteNumber(i + 2, 6, StrToFloatRegion(StBaseDose));

    WorkBook.ActiveWorksheet.WriteText(i + 2, 7, StMeasStatus);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 8, MainForm.LblProcessDataKDosVal.Caption);

    WorkBook.ActiveWorksheet.WriteText(i + 2, 9, Edit_Err.Text);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 10, Edit_N1.Text);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 11, Edit_N2.Text);

    WorkBook.ActiveWorksheet.WriteText(i + 2, 13, EditBt.Text);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 14, EditBx0.Text);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 15, EditBy0.Text);

    WorkBook.ActiveWorksheet.WriteText(i + 2, 17, Edit_GM1.Text);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 18, Edit_DGM2.Text);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 19, Edit_GA1.Text);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 20, Edit_DGA2.Text);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 21, Edit_GSL.Text);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 22, Edit_GSR.Text);

    WorkBook.ActiveWorksheet.WriteText(i + 2, 26, Edit_S.Text);

    WorkBook.ActiveWorksheet.WriteNumber(i + 2, 28, ord(CDetector.State));
    WorkBook.ActiveWorksheet.WriteNumber(i + 2, 29, ORD(OutEnum));
    WorkBook.ActiveWorksheet.WriteText(i + 2, 30, CDetector.Comment);
    WorkBook.ActiveWorksheet.WriteText(i + 2, 31, MainForm.Dosimeter.MeasComment); //MainForm.EditMeasDataComment.Text;
    WorkBook.ActiveWorksheet.WriteText(i + 2, 32, IntToStr(errExcel));

    WorkBook.ActiveWorksheet.WriteFormula(2, 2,'=AVERAGE(Z4:Z'+intToStr(i+2)+')');
    WorkBook.ActiveWorksheet.WriteFormula(3, 2,'=StDev(Z4:Z'  +intToStr(i+2)+')');

    rowExcel := rowExcel + 1;
    WorkBook.ActiveWorksheet.WriteText(1, 35,IntToStr(rowExcel));
    {$ENDIF}
  except // Если Excel отсутствует записываем в файл
    errExcel := errExcel + 1;
    Logging(DateTimeToStr(Now) + ';' + StDosNum + ';' + StMeasID + ';' +
      StDetNum + ';' + StTime + ';' + StBaseDose + ';' + StMeasStatus + ';' +
      MainForm.LblProcessDataKDosVal.Caption + ';' + Edit_Err.Text + ';' + Edit_N1.Text +
      ';' + Edit_N2.Text + ';' + ';' + EditBt.Text + ';' + EditBx0.Text + ';' +
      EditBy0.Text + ';' + ';' + Edit_GM1.Text + ';' + Edit_DGM2.Text + ';' +
      Edit_GA1.Text + ';' + Edit_DGA2.Text + ';' + Edit_GSL.Text + ';' +
      Edit_GSR.Text + ';' + ';' + //Edit_SA4.Text + ';' + Edit_SA5.Text + ';' +
      Edit_S.Text + ';' + IntToStr(ord(CDetector.State)) +
      ';' + IntToStr(ord(OutEnum)) + ';' + CDetector.Comment + ';' + ';' +
      MainForm.LblProcessDataDosNumberVal.Caption);
  end;
  if OptionsForm.CB_SaveCalcImages.Checked then
  begin
    StImageName := IntToStr(rowExcel+1);
    while length(StImageName)<3 do StImageName := '0' + StImageName;
    StImageName := StImageName + '_N' + StMeasID + '_D' + StDetNum;
    SaveCalcImage(StSheetNumber,StImageName);
  end;
end;

procedure TCalcForm.NMakeFindOptimizationClick(Sender: TObject);  // Optimization Test
var
  i,iop,iop2: integer;
begin
  // Получение абревиатуры настроек
  OptionsForm.CB_AutoRecalc.Checked := False;
  OptionsForm.OptionsChanged(Nil);
  bOptionsChanged := False;

  OptionsForm.CB_ReadCalculated.Checked := not NRecalculate.Checked;

  rowExcel := 1;
  errExcel := 0;

  for iop2:=0 to 7 do
  begin
    iop := iop2;
    if iop2=4 then iop:=7;
    if iop2=7 then iop:=4; // Standart - Last

    MainForm.DBGridEhProcess.DataSource.DataSet.First;
    OptionsForm.RBtnGroupByComment.Checked := True;
    OptionsForm.CB_SaveToExcel.Checked := True;

    OptionsForm.RG_GladeType.ItemIndex := iop;

    while not MainForm.DBGridEhProcess.DataSource.DataSet.Eof do
    begin
      MainForm.GetMeasData;
      if Assigned(MainForm.Dosimeter) then
      i := 1; // Only one detector
      begin
        if TDetector(MainForm.Dosimeter.DetectorsList[i]) <> nil then
        try
          MainForm.Dosimeter.DetectorsCnt := i;
          CalcForm.LoadData(tdETECTOR(MainForm.Dosimeter.DetectorsList[i]));

          MainForm.EditMeasDataComment.Text := OptionsForm.RG_GladeType.Items[iop];

          Btn_SaveClick(Nil);
        except
          on E:Exception do
          begin
            Logging('DBGridROW:'+IntToStr(MainForm.DBGridEhProcess.Row) + ' '+rsFailureDetectorLoad +' '+ intToStr(MainForm.Dosimeter.ID)+' ' + rsDetector + intToStr(i)+' ('+E.Message+')');
          end;
        end;
      end;
      MainForm.DBGridEhProcess.DataSource.DataSet.Next;
    end;
    OptionsForm.CB_SaveToExcel.Checked := false;
  end;
  OptionsForm.CB_ReadCalculated.Checked := True;
end;

procedure TCalcForm.N_UseCurrentCalibrationClick(Sender: TObject);
begin
  ChangeOptions(Nil);
end;

procedure TCalcForm.NRecalculateClick(Sender: TObject);
begin

end;

procedure TCalcForm.NMakeAllClick(Sender: TObject);
var
  i: integer;
begin
  OptionsForm.DisableOptionsControls:=true;
  rowExcel := 1;
  errExcel := 0;
//  OptionsForm.EditExcelRemark.Text := 'Export';
  MainForm.DBGridEhProcess.DataSource.DataSet.First;
  OptionsForm.RBtnAll.Checked := True;
  OptionsForm.CB_SaveToExcel.Checked := True;
  OptionsForm.CB_ReadCalculated.Checked := not NRecalculate.Checked;
  OptionsForm.CB_NoProcessApplication.Checked := NRecalculate.Checked;

  while not MainForm.DBGridEhProcess.DataSource.DataSet.Eof do
  begin
    MainForm.GetMeasData;
    if Assigned(MainForm.Dosimeter) then
    for i := 0 to 3 do
    begin
      if TDetector(MainForm.Dosimeter.DetectorsList[i]) <> nil then
      try
        MainForm.Dosimeter.DetectorsCnt := i;
        CalcForm.LoadData(tdETECTOR(MainForm.Dosimeter.DetectorsList[i]));
        Btn_SaveClick(Nil);
      except
        on E:Exception do
        begin
          Logging('DBGridROW:'+IntToStr(MainForm.DBGridEhProcess.Row)+' '+rsFailureDetectorLoad+' '+intToStr(MainForm.Dosimeter.ID)+' Detector'+intToStr(i)+' ('+E.Message+')');
        end;
      end;
    end;
    MainForm.DBGridEhProcess.DataSource.DataSet.Next;

  end;
  OptionsForm.CB_SaveToExcel.Checked := false;
  OptionsForm.CB_NoProcessApplication.Checked := false;
  OptionsForm.RBtnAll.Checked := false;
  OptionsForm.CB_SaveToExcel.Checked := false;
  OptionsForm.DisableOptionsControls:=false;
end;

procedure TCalcForm.NMakeAllGroupByDosClick(Sender: TObject);
//var
//  i: integer;
begin
{
  OptionsForm.CB_ReadCalculated.Checked := False;
  rowExcel := 1;
  errExcel := 0;
  MainForm.DBGridEhProcess.DataSource.DataSet.First;
  OptionsForm.RBtnGroupByDos.Checked := True;
  OptionsForm.CB_SaveToExcel.Checked := True;

  while not MainForm.DBGridEhProcess.DataSource.DataSet.Eof do
  begin
    MainForm.GetMeasData;
    if Assigned(MainForm.Dosimeter) then
    for i := 0 to 3 do
    begin
      if TDetector(MainForm.Dosimeter.DetectorsList[i]) <> nil then
      try
        MainForm.Dosimeter.DetectorsCnt := i;
        CalcForm.LoadData(tdETECTOR(MainForm.Dosimeter.DetectorsList[i]));
        Btn_SaveClick(Nil);
      except
        on E:Exception do
        begin
          Logging('DBGridROW:'+IntToStr(MainForm.DBGridEhProcess.Row)+' '+rsFailureDetectorLoad+' '+intToStr(MainForm.Dosimeter.ID)+' '+rsDetector+intToStr(i)+' ('+E.Message+')');
        end;
      end;
    end;
    MainForm.DBGridEhProcess.DataSource.DataSet.Next;
  end;
  OptionsForm.CB_SaveToExcel.Checked := false;
}
end;

procedure TCalcForm.NMakeAllGroupByCommentClick(Sender: TObject);
//var
//  i: integer;
begin
{
  OptionsForm.CB_ReadCalculated.Checked := False;
  rowExcel := 1;
  errExcel := 0;
  MainForm.DBGridEhProcess.DataSource.DataSet.First;
  OptionsForm.RBtnGroupByComment.Checked := True;
  OptionsForm.CB_SaveToExcel.Checked := True;

  while not MainForm.DBGridEhProcess.DataSource.DataSet.Eof do
  begin
    MainForm.GetMeasData;
    if Assigned(MainForm.Dosimeter) then
    for i := 0 to 3 do
    begin
      if MainForm.Dosimeter.DetectorsList[i] <> nil then
      try
        MainForm.Dosimeter.DetectorsCnt := i;
        CalcForm.LoadData(tdETECTOR(MainForm.Dosimeter.DetectorsList[i]));
        Btn_SaveClick(Nil);
      except
        on E:Exception do
        begin
          Logging('DBGridROW:'+IntToStr(MainForm.DBGridEhProcess.Row)+' '+rsFailureDetectorLoad+' '+intToStr(MainForm.Dosimeter.ID)+' Detector'+intToStr(i)+' ('+E.Message+')');
        end;
      end;
    end;
    MainForm.DBGridEhProcess.DataSource.DataSet.Next;
  end;
  OptionsForm.CB_SaveToExcel.Checked := false;
}
end;

procedure TCalcForm.OutDetail(aOutEnum: TOutEnum; aOutString: String);
begin
  if ord(aOutEnum) < ord(OutEnum) then
  begin
    OutEnum := aOutEnum;
    CDetector.Comment := aOutString;
  end;
end;

procedure TCalcForm.PC_ChartFunctionChange(Sender: TObject);
begin
  ChartFunction := TChartFunction(PC_ChartFunction.ActivePageIndex);
end;

var
  iMaxInCalcSquare : integer = 210; // пересчитается при CalcSquare
procedure TCalcForm.PeakSimulationIfNeed;
begin
  if not CDetector.PeakFound and OptionsForm.CB_DoPeakAlways.Checked and (OptionsForm.RG_TypeS.ItemIndex<>clcSquare) then
  begin
    CalcSquare; // Считаем площадь для прикидки пика

    if CDetector.GSL + CDetector.GSR=0 then Exit;

    CDetector.GM1 := iMaxInCalcSquare;
//2    GetVLE_Float('DGM2 (GM1), A',16.76762);
//3    GetVLE_Float('DGM2 (GM1), B',0.07084);
//4    GetVLE_Float('GSL (GM1), A',10.15911);
//5    GetVLE_Float('GSL (GM1), B',0.02355);
//6    GetVLE_Float('GSR (GSL), A',0);
//7    GetVLE_Float('GSR (GSL), B',0.61);
//8    GetVLE_Float('DGA2',0.3);

    CDetector.DGM2 := -GetVLE_Float('DGM2 (GM1), A',16.76762) - GetVLE_Float('DGM2 (GM1), B',0.07084) * CDetector.GM1;
    CDetector.GSL := GetVLE_Float('GSL (GM1), A',10.15911) + GetVLE_Float('GSL (GM1), B',0.02355) * CDetector.GM1;
    CDetector.GSR := GetVLE_Float('GSR (GSL), A',0) + GetVLE_Float('GSR (GSL), B',0.61) * CDetector.GSL;
    CDetector.GA1 := 2 * CDetector.S / SQRT(2 * Pi) / (CDetector.GSL + CDetector.GSR);
    CDetector.DGA2 := GetVLE_Float('DGA2',0.3);

//    CDetector.DGM2 := -StrToFloatRegion(OptionsForm.VLE.Cells[1, 2]) - StrToFloatRegion(OptionsForm.VLE.Cells[1, 3]) * CDetector.GM1;
//    CDetector.GSL := StrToFloatRegion(OptionsForm.VLE.Cells[1, 4]) + StrToFloatRegion(OptionsForm.VLE.Cells[1, 5]) * CDetector.GM1;
//    CDetector.GSR := StrToFloatRegion(OptionsForm.VLE.Cells[1, 6]) + StrToFloatRegion(OptionsForm.VLE.Cells[1, 7]) * CDetector.GSL;
//    CDetector.GA1 := 2 * CDetector.S / SQRT(2 * Pi) / (CDetector.GSL + CDetector.GSR);
//    CDetector.DGA2 := StrToFloatRegion(OptionsForm.VLE.Cells[1, 8]);

    CDetector.S := SQRT(2 * Pi) * CDetector.GA1 * (CDetector.GSL + CDetector.GSR) / 2;

    AssignCurrentPeak(CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR);
  end;
end;

function GetTempPreHeatFromComment(aComment: String): double;
begin
  result := CalcForm.GetVLE_Float('chanal_preheat',0);
end;

procedure TCalcForm.CalcDetector(aDetector: TDetector);
begin
  CDetector := aDetector;
  CalcType := ccAuto;

  if not Assigned(CDetector) then Exit;
  if not Assigned(OptionsForm) then Exit;

  OptionsForm.DisableOptionsControls := true;
  DisableCalcControls := true; // признак по которому будут запрещен пересчёт при изменениях в Edit-ах коэффициентов
  try
// по типовым значениям понимаем прочитан результат из БД или нет

    SetDefaultOptions(CDetector);

    CalcAuto;

    if OptionsForm.CB_AutoCalcWaitings.Checked then // Параметры ожиданий для фита
    begin
      OptionsForm.Edit_GA1.Text  := FloatToStrRegionF(CDetector.GA1,ffGeneral,6,3);
      OptionsForm.Edit_DGA2.Text := FloatToStrRegionF(CDetector.DGA2,ffGeneral,6,3);
      OptionsForm.Edit_GSL.Text  := FloatToStrRegionF(CDetector.GSL,ffGeneral,6,3);
      OptionsForm.Edit_GSR.Text  := FloatToStrRegionF(CDetector.GSR,ffGeneral,6,3);
      OptionsForm.Edit_GM1.Text  := FloatToStrRegionF(CDetector.GM1,ffGeneral,6,3);
      OptionsForm.Edit_DGM2.Text := FloatToStrRegionF(CDetector.DGM2,ffGeneral,6,3);
    end;
    if OptionsForm.CB_AutoCalcFonWaitings.Checked then // Параметры ожиданий для фита
    begin
      OptionsForm.EditEvalBt.Text  := FloatToStrRegionF(CDetector.Bt,ffGeneral,6,3);
      OptionsForm.EditEvalBx0.Text := FloatToStrRegionF(CDetector.Bx0,ffGeneral,6,3);
      OptionsForm.EditEvalBy0.Text := FloatToStrRegionF(CDetector.By0,ffGeneral,6,3);
    end;

    // сохранение первично найденных границ интереса для того чтобы не слишком далеко уходить при фите
    SetVLE_Float('SRC_N1', CDetector.N1);
    SetVLE_Float('SRC_N2', CDetector.N2);

    DoFitWithWaitings := False;
    if CDetector.PeakFound
      then AssignCurrentPeak(CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR)
      else CalcSquare;

    // оценим сложным образом минимально допустимую ошибку фита
    minErr := StrToFloatRegion(OptionsForm.Edit_MinErr.Text) * CDetector.Err;
    minErrF := StrToFloatRegion(OptionsForm.Edit_MinErrF.Text) * CDetector.Err;

    // установим признак необходимости добавки отличий в хи-квадрат чтоб фитировать с учётом ожиданий
    DoFitWithWaitings := OptionsForm.CB_PlusWaitings.Checked and (CDetector.S < MaxS_4WaitingsFit);

    if CDetector.FonFound then
      if SFonInterest >= MinS_4FitFon then
        if OptionsForm.CB_FitFon.Checked then
          FonGradientDown; // Фитирование фона

    if CDetector.PeakFound then
      if CDetector.S >= MinS_4Fit then
        if OptionsForm.CB_FitPeak.Checked then
        begin
          GradiendDown; // Фитирование пика
          if (CDetector.DGA2<0) and (CDetector.DGA2>-0.05) then CDetector.DGA2:=0.000001; // коррекция нефизики при небольших отрицательных смещениях при фитировании

          if OptionsForm.CB_RefitIfError.Checked then
          begin
            OutEnum := outGood;
            CDetector.Comment := '';
            CheckPeakDGauss(iWaitingPeakCentre,CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR);
            if OutEnum=outBad then
            begin
{
              CDetector.GM1 := StrToFloatRegion(OptionsForm.Edit_GM1.Text);
              CDetector.DGM2 := -GetVLE_Float('DGM2 (GM1), A',16.76762) - GetVLE_Float('DGM2 (GM1), B',0.07084) * CDetector.GM1;
              CDetector.GSL := GetVLE_Float('GSL (GM1), A',10.15911) + GetVLE_Float('GSL (GM1), B',0.02355) * CDetector.GM1;
              CDetector.GSR := GetVLE_Float('GSR (GSL), A',0) + GetVLE_Float('GSR (GSL), B',0.61) * CDetector.GSL;
              CDetector.GA1 := 2 * CDetector.S / SQRT(2 * Pi) / (CDetector.GSL + CDetector.GSR);
              CDetector.DGA2 := GetVLE_Float('DGA2',0.3);
              CDetector.S := SQRT(2 * Pi) * CDetector.GA1 * (CDetector.GSL + CDetector.GSR) / 2;
}
              GradiendDown; // Фитирование пика
            end;
          end;
        end;

    PeakSimulationIfNeed;

    CheckAll(iWaitingPeakCentre,CDetector);

    if CDetector.PeakFound or OptionsForm.CB_DoPeakAlways.Checked and (OptionsForm.RG_TypeS.ItemIndex<>clcSquare)
      then AssignCurrentPeak(CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR)
      else
        if CalcType<>ccFromDB then CalcSquare; // Считаем площадь если она не прочитана из базы данных

    //CalcShow;
    //CalcOut;
    //if not CDetector.IsReadFromDB then    // в следующий раз прочтётся нормально
    //  Btn_SaveClick(Nil);


  except
    on E: Exception do
    begin
      Logging('CalcForm[2]: '+E.Message);
      OutDetail(outBad,E.Message);
    end;
  end;

  DisableCalcControls := false;
  OptionsForm.DisableOptionsControls := false;
end;

procedure TCalcForm.CalcRefresh;
begin
  if not Assigned(CDetector) then Exit;
  if not Assigned(OptionsForm) then Exit;
  if CalcType<>ccManual then LoadOptions;

  DisableCalcControls := true; // признак по которому будут запрещен пересчёт при изменениях в Edit-ах коэффициентов
  try
    SetDefaultOptions(CDetector,sdefIfNeed);


  // по типовым значениям понимаем прочитан результат из БД или нет
    if ((CalcType=ccAuto) or not CDetector.IsReadFromDB) then
    begin
      CalcAuto;

      if OptionsForm.CB_AutoCalcWaitings.Checked then // Параметры ожиданий для фита
      begin
        OptionsForm.Edit_GA1.Text  := FloatToStrRegionF(CDetector.GA1,ffGeneral,6,3);
        OptionsForm.Edit_DGA2.Text := FloatToStrRegionF(CDetector.DGA2,ffGeneral,6,3);
        OptionsForm.Edit_GSL.Text  := FloatToStrRegionF(CDetector.GSL,ffGeneral,6,3);
        OptionsForm.Edit_GSR.Text  := FloatToStrRegionF(CDetector.GSR,ffGeneral,6,3);
        OptionsForm.Edit_GM1.Text  := FloatToStrRegionF(CDetector.GM1,ffGeneral,6,3);
        OptionsForm.Edit_DGM2.Text := FloatToStrRegionF(CDetector.DGM2,ffGeneral,6,3);
      end;
      if OptionsForm.CB_AutoCalcFonWaitings.Checked then // Параметры ожиданий для фита
      begin
        OptionsForm.EditEvalBt.Text  := FloatToStrRegionF(CDetector.Bt,ffGeneral,6,3);
        OptionsForm.EditEvalBx0.Text := FloatToStrRegionF(CDetector.Bx0,ffGeneral,6,3);
        OptionsForm.EditEvalBy0.Text := FloatToStrRegionF(CDetector.By0,ffGeneral,6,3);
      end;

      // сохранение первично найденных границ интереса для того чтобы не слишком далеко уходить при фите
      SetVLE_Float('SRC_N1', CDetector.N1);
      SetVLE_Float('SRC_N2', CDetector.N2);

      DoFitWithWaitings := False;
      if CDetector.PeakFound
        then AssignCurrentPeak(CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR)
        else CalcSquare;

      // оценим сложным образом минимально допустимую ошибку фита
      minErr := StrToFloatRegion(OptionsForm.Edit_MinErr.Text) * CDetector.Err;
      minErrF := StrToFloatRegion(OptionsForm.Edit_MinErrF.Text) * CDetector.Err;

      // установим признак необходимости добавки отличий в хи-квадрат чтоб фитировать с учётом ожиданий
      DoFitWithWaitings := OptionsForm.CB_PlusWaitings.Checked and (CDetector.S < MaxS_4WaitingsFit);

      if CDetector.FonFound then
        if SFonInterest >= MinS_4FitFon then
          if OptionsForm.CB_FitFon.Checked then
            FonGradientDown; // Фитирование фона

      if CDetector.PeakFound then
        if CDetector.S >= MinS_4Fit then // CalcAuto содержит CalcSquare - счмитает площадь
          if OptionsForm.CB_FitPeak.Checked then
          begin
            GradiendDown; // Фитирование пика

            if (CDetector.DGA2<0) and (CDetector.DGA2>-0.05) then CDetector.DGA2:=0.000001; // коррекция нефизики при небольших отрицательных смещениях при фитировании

            if OptionsForm.CB_RefitIfError.Checked then
            begin
              OutEnum := outGood;
              CDetector.Comment := '';
              CheckPeakDGauss(iWaitingPeakCentre,CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR);

              if (OutEnum <> outGood) and (CDetector.DGM2 + CDetector.GSL + CDetector.GSR < 0) and (CDetector.GM1 + CDetector.DGM2 + CDetector.GSR - CDetector.N1<0) then // случай, когда пик 4 после фитирования слишком уполз влево
              begin
//                OutEnum:=outBad;
              end;

              if OutEnum=outBad then
              begin
                GradiendDown; // переФитирование пика
              end;
            end;
          end;

      PeakSimulationIfNeed;
    end
      else
        GetWOCalc;

    if CalcType<>ccFromDB then CheckAll(iWaitingPeakCentre,CDetector);

    if CDetector.PeakFound or OptionsForm.CB_DoPeakAlways.Checked and (OptionsForm.RG_TypeS.ItemIndex<>clcSquare)
      then AssignCurrentPeak(CDetector.GM1,CDetector.DGM2,CDetector.GA1,CDetector.DGA2,CDetector.GSL,CDetector.GSR)
      else
        if CalcType<>ccFromDB then CalcSquare; // Считаем площадь если она не прочитана из базы данных

    if CalcType=ccFromDB then CDetector.Err := StrToFloatRegion(Edit_Err.Text);

    CalcShow;
    CalcOut;

    if not CDetector.IsReadFromDB then    // в следующий раз прочтётся нормально
      Btn_SaveClick(Nil);
  except
    on E: Exception do
    begin
      Logging('CalcForm[1]: '+E.Message);
      OutDetail(outBad,E.Message);
    end;
  end;

  DisableCalcControls := false;
  OptionsForm.DisableOptionsControls := false;
end;

procedure TCalcForm.CalcAuto;
var
  i, r: integer;
  Buf: double;
  RangeLeft, RangeRight: integer;
  calcBt,calcBx0: double;
  Amax,Sum,SumMax : double;
  TestS : double;
begin
  try
    // ---------------
    // Инициализация параметров алгоритма
    // ---------------
    Edit_Err.Text := '';
    CDetector.Comment:='';

    GradientRecursionStop    := False;
    FonGradientRecursionStop := False;

    CDetector.S := 0;
    CDetector.Err := 0;
    CDetector.SA5 := 0;

    RangeLeft := BG_Start;
    RangeRight := BG_End;

    bCrossBT40 := false;

    case OptionsForm.RG_BackgroundFunction.ItemIndex of
      0: BGFunc := bgfExp;
      1: BGFunc := bgfStep;
      2: BGFunc := bgfNone;
      else BGFunc := bgfNone;
    end;
    CDetector.Bxy0 := 0;
    if OptionsForm.CB_UseTempProfileInfo.Checked then
      CDetector.Bxy0 := GetTempPreHeatFromComment(CDetector.DetTypeComment)/2;


    // ---------------
    // Фильтрация
    // ---------------
    if OptionsForm.CB_UseSourceFilter.Checked then SourceFilter(CDetector);

    // ---------------
    // Сглаживание
    // ---------------
    AssignCurrentGlade;

    OutEnum := outGood;
    CDetector.Comment := '';

    // ---------------
    // Фоновая функция
    // ---------------
    // определение By0, Bt и Bx0

    // Инициализация
    AssignCurrentFon(1, 1000000, 0, 0, 0);

    // Поиск By0 (при дальнейшем разборе может быть пересчитано иначе в другом месте)
    CDetector.BN1 := StrToFloatRegion(OptionsForm.EditL_Start.Text);
    CDetector.BN1_width := StrToFloatRegion(OptionsForm.EditL_Num.Text);
    CDetector.By0 := FindFonExp_By0(CDetector,BuffAVG,round(CDetector.BN1),round(CDetector.BN1_Width)); // для MaterialType = 2 BN1 = 5
    CDetector.Bxy0 := CDetector.BN1 + CDetector.BN1_Width/2;

    case BGFunc of // Выбор функции, опичывающей фон
    bgfExp: // Classic function
      begin
        // поиск выраженных границ фоновой функции в правой области
        // 5 для MaterialType = 0, 0 для MaterialType = 1,2
        case OptionsForm.RG_FonRangeCriteria.ItemIndex of
          0: // nothing (фиксированные границы из интерфейса)
            begin
              // Bt:=FindFonExp_Bt(R_Start,R_End,kwidth);  // Поиск Bt по отношению к производной
              // Bx0:=FindFonExp_Bx0(R_Start,R_End,kwidth); // Поиск Bx0 по точкам линии фона (на предпоследних x)
            end;
          1: // По максимальному наклону
            begin
              FindFonExpRangeBySlantMaximum(RangeLeft, RangeRight, kwidth, BG_Start, BG_End);
            end;
          2: // По минимуму
            begin
              FindFonExpRangeByMinimum(RangeLeft, RangeRight, kwidth, BG_Start, BG_End);
            end;
          3: // 40
            begin
              FindFonExpRangeByBTEqual40(RangeLeft, RangeRight, kwidth, BG_Start, BG_End);
            end;
          4: // По хвосту пика
            begin
              FindFonExpRangeByPeak(RangeLeft, RangeRight, kwidth, BG_Start, BG_End, 5);
            end;
          5: // Комбо
            begin // до ума уже почти доведён
              FindFonExpRangeCombo(RangeLeft, RangeRight, kwidth, BG_Start, BG_End);
            end;
        end; // окончание выбора способа поиска фоновой функции
        if BG_Start>MaxChannels then BG_Start:=MaxChannels;
        if BG_End>MaxChannels then BG_End:=MaxChannels;

        case OptionsForm.RG_FonFunctionCriteria.ItemIndex of
          0: // найденные ранее границы // активен в методе Fitting
            begin
              CDetector.BN2 := BG_Start;
              CDetector.BN2_width := BG_End - BG_Start;
              FindFonExpByRange(round(CDetector.BN2), round(CDetector.BN2 + CDetector.BN2_width), kwidth, calcBt, calcBx0);
              CDetector.Bt  := calcBt;
              CDetector.Bx0 := calcBx0;
            end;
          1: // По границам зоны интереса // альтернативный способ нахождения коэффициентов фоновой функции
            begin // активен в методе Area 10-280
              CDetector.BN1 := BG_Start; //?
              CDetector.BN1_width := 0;
              CDetector.BN2 := BG_End;
              CDetector.BN2_width := cDefBN2_width;
              CDetector.By0 := 0;
              FindFonExpBetweenPoints(CDetector.BN1, BuffAVG[round(CDetector.BN1)], CDetector.BN2, BuffAVG[round(CDetector.BN2)], CDetector.By0, calcBt,calcBx0);
              CDetector.Bt  := calcBt;
              CDetector.Bx0 := calcBx0;
            end;
          2: // Bt == 40
            begin // активен в методе Area 60-240
              CDetector.BN2 := BG_Start;
              CDetector.BN2_width := cDefBN2_width;
    //          FindFonExpBt40andRightRange(CDetector.N2, BuffAVG[round(CDetector.N2)], CDetector.By0, calcBt,calcBx0);
              FindFonExpBt40andRightRange(CDetector.BN2, BuffAVG[round(CDetector.BN2)], CDetector.By0, calcBt,calcBx0);
              CDetector.Bt  := calcBt;
              CDetector.Bx0 := calcBx0;
            end;
        end;

        CDetector.FonFound := OutEnum <> outBad;
        // коррекция значений безотносительно статуса измерения
        if CDetector.Bt < 0 then // кажется уже не актуально
        begin
          CDetector.Bt := 0.1;
          CDetector.Bx0 := 1000;
        end;
        if CDetector.Bt = 0.1 then
        // чтобы получилась почти горизонтальная линия с началом близким к By0
        begin
          CDetector.Bx0 := 1000;
          CDetector.FonFound := False;
        end;
      end;

    bgfStep: // Logistic function (step)
      begin
        CDetector.Bx0 := StrToInt(OptionsForm.Edit_WaitingPeakCentre.Text);
        CDetector.Bt := Bt40;
        CDetector.Bdy := FindFonStep_Bdy(CDetector.By0, BG_Start, BG_End);
        CDetector.FonFound := True;
      end;

    else // Mone
      begin

      end;
    end; // case of BGFunc

    SFonInterest:=0;
    for i := min(BG_Start,MaxChannels) to min(BG_End,MaxChannels) do
      SFonInterest := SFonInterest + CDetector.BuffPulses[i];

    if CDetector.FonFound
    then AssignCurrentFon(CDetector.Bt, CDetector.Bx0, CDetector.By0, CDetector.Bxy0, CDetector.Bdy)
    else AssignCurrentFon(0.1, 1000, 0, 0, 0);
    // вносим в массивы данных информацию по рассчитанной функции фона






    // ---------------
    // Поиск пика
    // ---------------
    CDetector.PeakFound := False;
    if OptionsForm.RG_TypeS.ItemIndex<>clcSquare then
      FoundPeak := FindPeak(fpAuto);

    // Функция ДаблГаусс
    if CDetector.PeakFound then
    begin
      FoundPeakCorrection;
//      if fmax2 - fmax1 > 30 then
//        CDetector.GA1 := CDetector.GA1*(fmax2 - fmax1)/25; // Волюнтаризм
//        CDetector.GA1 := Amax*(1+(fmax2 - fmax1)/300); // Волюнтаризм

//      StatusBar.Panels[3].Text := 'Пик ОК';
      if OptionsForm.CLB_Log.Checked[clogPik] then
        OptionsForm.REdit.Lines.Add('Peak found, centre ' +
          IntToStr(FoundPeak.Centre) + ' LeftG=' +
          IntToStr(FoundPeak.LeftEdge) + ' RightG=' +
          IntToStr(FoundPeak.RightEdge) + ' Left2G=' +
          IntToStr(FoundPeak.LeftSigma) + ' Right2G=' +
          IntToStr(FoundPeak.RightSigma));
//      StatusBar.Panels[5].Text := IntToStr(FoundPeak.RightSigma - FoundPeak.LeftSigma);

      TestS:=0;
      for i:=FoundPeak.LeftSigma to FoundPeak.RightSigma do
        TestS := TestS + BuffAvgWOB[i];
      if OptionsForm.CB_FitChangeRange.Checked and (TestS>MinS_4FitChangeRange) then
      begin
        Buf := StrToFloatRegion(OptionsForm.Edit_InterestCriteriaLeft.Text);
        CDetector.N1 := FoundPeak.Centre - CDetector.GSL * Buf;
        Buf := StrToFloatRegion(OptionsForm.Edit_InterestCriteriaRight.Text);
        CDetector.N2 := FoundPeak.Centre + CDetector.GSR * Buf;

        Edit_N1.Text := FloatToStrRegionF(CDetector.N1,ffGeneral,3,1);
        Edit_N2.Text := FloatToStrRegionF(CDetector.N2,ffGeneral,3,1);
      end;

      CheckPeakDGauss(iWaitingPeakCentre,CDetector.Gm1,CDetector.DGm2,CDetector.Ga1,CDetector.DGa2,CDetector.GSL,CDetector.GSR);
    end; // Peak found

    CalcSquare;

    BigPeakCorrection;

  except
    CDetector.FonFound := false;
    CDetector.PeakFound := false;
    // сформировать другие признаки
  end;
end;

procedure TCalcForm.__ShowDetector(aDetector: TDetector);
begin //2del
end;

procedure TCalcForm.SB_SaveChartClick(Sender: TObject);
begin
{
  SaveDialog1.Filter:= 'Teefiles|*.tee';
  if SaveDialog1.Execute then
    SaveChartToFile(ChartCalc,SaveDialog1.FileName);
}
end;

procedure TCalcForm.CalcSquare;
var
  SF, SF_Max: real;
  i: integer;
  max1: integer;
  icL, icR: integer;
  MaxFindRange: integer;
  iLeft,iRight : integer;
  iCenter: integer;
begin
  // Если пика нет, но возможно доза есть
  if not CDetector.PeakFound or (OptionsForm.RG_TypeS.ItemIndex = clcSquare) then
  begin
    MaxFindRange := StrToInt(OptionsForm.Edit_MaxFindRange.Text);

    for i := 0 to MaxChannels do // вывод пиков в TChart блокируем
    begin
      Peak_R1[i] := 0;
      Peak_R2[i] := 0;
      BuffDGauss[i] := 0;
    end;

    max1 := iWaitingPeakCentre; // индекс максимума исходных данных
    iLeft := iWaitingPeakCentre - MaxFindRange;
    iRight := iWaitingPeakCentre + MaxFindRange;
    if OptionsForm.CB_Adaptive.Checked then
      iRight := min(iRight,round(CDetector.BN2));

    for i := iLeft to iRight do
    begin
      if BuffAvgWOB[i] >= BuffAvgWOB[max1] then
        max1 := i;
    end;
    icL := max1;
    icR := max1;

    // Поиск границ, характерных для больших пиков
    for i := max1 - 1 downto iLeft do // первичная левая граница
    begin
      if BuffAvgWOB[i] < 0.05 * BuffAvgWOB[max1] then
      // may be WideAVG needed
      begin
        icL := i + 1;
        break;
      end;
    end;
    for i := max1 + 1 to iRight do // первичная правая граница
    begin
      if BuffAvgWOB[i] < 0.05 * BuffAvgWOB[max1] then
      // may be WideAVG needed
      begin
        icR := i - 1;
        break;
      end;
    end;
    iCenter := (iLeft + iRight) div 2; // заменяем центр на средневзвешенный

    // Контроль на слишком узкий диапазон (характерно для очень малых пиков)
    if (icR - icL) < WaitMaxWidth div 2 then // Волюнтаризм
    begin // Попробуем расширить, найдя максимум площади справа и слева
      SF := 0;
      SF_Max := 0;
      for i := icR to MaxChannels do // сдвиг правой границы
      begin
        SF := SF + BuffAvgWOB[i]; // площадь справа от найденной границы
        if SF > SF_Max + BuffAvgWOB[max1] then
        // *1.05 - для ограничения захвата дребезга
        begin
          icR := i;
          SF_Max := SF;
        end;
        if i - WaitMaxWidth >= max1 then
          break; // если локальный максимум начинает выходить за диапазон ожидания, значит это уже ошибка фона, а не пик
        if i - WaitMaxWidth >= iWaitingPeakCentre then
          break; // если локальный максимум начинает выходить за диапазон ожидания, значит это уже ошибка
      end;
      SF := 0;
      SF_Max := 0;
      for i := icL downto 0 do // сдвиг левой границы
      begin
        SF := SF + BuffAvgWOB[i]; // площадь справа от найденной границы
        if SF > SF_Max + BuffAvgWOB[max1] then
        // *1.05 - для ограничения захвата дребезга
        begin
          icL := i;
          SF_Max := SF;
        end;
        if i <= max1 - WaitMaxWidth then
          break; // если локальный максимум начинает выходить за диапазон ожидания, значит это уже не пик
        if i <= iWaitingPeakCentre - WaitMaxWidth then
          break; // если локальный максимум начинает выходить за диапазон ожидания, значит это уже ошибка
      end;
      iCenter := (iLeft + iRight) div 2; // заменяем центр на средневзвешенный
    end;
    if (icR - icL) < WaitMaxWidth div 2 then // Если попрежнему ширина зоны меньше допустимой, значит забиваем на пложади добавляем ширину в сторону центра ожидаемого пика
    begin
      if (icR + icL) div 2 > iWaitingPeakCentre
      then icL := icR - WaitMaxWidth div 2
      else icR := icL + WaitMaxWidth div 2;

    end;

    // Контроль на слишком широкий диапазон
    if (icR - icL) > WaitMaxWidth then
    begin
      if iCR > iCenter + WaitMaxWidth div 2 then icR := iCenter + WaitMaxWidth div 2; // Волюнтаризм
      icL := iCR - WaitMaxWidth; // Волюнтаризм
    end;
    if icL < iWaitingPeakCentre - WaitMaxWidth div 2 then icL := iWaitingPeakCentre - WaitMaxWidth div 2;

    if CalcType = ccAuto then
    case OptionsForm.RG_InterestRange.ItemIndex of
    0:
      begin
        CDetector.N1 := icL;
        CDetector.N2 := icR;
      end;
    1:
      begin
        CDetector.N1 := max1 - WaitMaxWidth / 2;
        CDetector.N2 := max1 + WaitMaxWidth / 2;
      end;
    2:
      begin
        CDetector.N1 := StrToInt(OptionsForm.Edit_DefaultN1.Text);
        CDetector.N2 := StrToInt(OptionsForm.Edit_DefaultN2.Text);
      end;
    end;

    // Вычисление площади
    CDetector.S := 0; // подсчёт интеграла
    for i := round(CDetector.N1) to round(CDetector.N2) do
    begin
      CDetector.S := CDetector.S + BuffAvgWOB[i]; // may be WideAVG needed
    end;
    if CDetector.S < 0 then
    begin
      if not bCalcForm_ShowNegativeDose then CDetector.S := 0;
      OutDetail(outWarning, rsDozaNotFound);
      // не малая статистика на фоне, а неправильно определённый пик
    end;

    if OptionsForm.RG_MainAlgorithm.ItemIndex=0 then // для фитирования
    begin
      if (BuffAvg[max1] >= BuffAvg[MaxChannels - 1]) and (BuffAvg[max1] >= OCC[cvMaxNoPeak])
        then OutDetail(outWarning, rsPeakNotFound);
    // не малая статистика на фоне, а неправильно определённый пик

      i := StrToInt(OptionsForm.Edit_BG_End.Text);
      if (Abs(BuffAvg[i]-1)<0.00001) or (Abs((BuffBackground[i] - BuffAvg[i]) / (BuffAvg[i] + 1)) >= OCC[cvFon]/100)
        then OutDetail(outWarning, rsCheckFonRight);
      // фон завалился вниз. Фон ли? - Проверьте положение фоновой функции
    end;

    // вывод значений в Peak_R1 для сохранения в БД
    for i := 0 to MaxChannels do
    if (i >= CDetector.N1) and (i <= CDetector.N2)
//    then Peak_R1[i] := CDetector.BuffPulses[i] - BuffBackGround[i]
    then Peak_R1[i] := BuffAvg[i] - BuffBackGround[i]
    else Peak_R1[i] := 0;

    CDetector.S := CDetector.S*1.078; // Волюнтаризм
    if OptionsForm.CB_NoLineCorrection.Checked then
    case OptionsForm.RG_MainAlgorithm.ItemIndex of
      0: // Фитирование
      begin
      end;
      1: // 10-280
      begin
      end;
      2: // 60-240
      begin
        CDetector.S := CDetector.S - CDetector.S/SQRT(SQRT(max(1,CDetector.S))); // Волюнтаризм
      end;
    end;
    CDetector.Err := Hi2_Fon(CDetector.Bx0, CDetector.Bt, CDetector.By0, CDetector.Bxy0, CDetector.Bdy) + SQRT(Abs(CDetector.S));

    // расчёт центра для симуляции пика - потом всю симуляцию воткнуть сюда
    if (max1 > CDetector.N1) and (max1 < CDetector.N2)
    then iMaxInCalcSquare := max1
    else iMaxInCalcSquare := round(CDetector.N1/3 + CDetector.N2*2/3); // лёгкое смещение вправо (волюнтаризм)
  end;
end;

procedure TCalcForm.GetWOCalc;
begin
  try
    CDetector.Bt := StrToFloatRegion(EditBt.Text);
    CDetector.Bx0 := StrToFloatRegion(EditBx0.Text);
    CDetector.By0 := StrToFloatRegion(EditBy0.Text);
    CDetector.Bxy0 := StrToFloatRegion(EditBxy0.Text);
    CDetector.Bdy := StrToFloatRegion(EditBdy.Text);
    CDetector.GA1 := StrToFloatRegion(Edit_GA1.Text);
    CDetector.DGA2 := StrToFloatRegion(Edit_DGA2.Text);
    CDetector.GSL := StrToFloatRegion(Edit_GSL.Text);
    CDetector.GSR := StrToFloatRegion(Edit_GSR.Text);
    CDetector.GM1 := StrToFloatRegion(Edit_GM1.Text);
    CDetector.DGM2 := StrToFloatRegion(Edit_DGM2.Text);
    CDetector.N1 := StrToFloatRegion(Edit_N1.Text);
    CDetector.N2 := StrToFloatRegion(Edit_N2.Text);
    CDetector.BN1 := StrToFloatRegion(Edit_BN1.Text);
    CDetector.BN1_width := StrToFloatRegion(Edit_BN1_width.Text);
    CDetector.BN2 := StrToFloatRegion(Edit_BN2.Text);
    CDetector.BN2_width := StrToFloatRegion(Edit_BN2_width.Text);

    AssignCurrentGlade;
    AssignCurrentFon(CDetector.Bt, CDetector.Bx0, CDetector.By0, CDetector.Bxy0, CDetector.Bdy);

  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['GetWOCalc (read params from fields)',E.Message]));
  end;
end;

procedure TCalcForm.CalcOut;
begin
  Edit_GA1.Text  := FloatToStrRegionF(CDetector.GA1,ffGeneral,6,3);
  Edit_DGA2.Text := FloatToStrRegionF(CDetector.DGA2,ffGeneral,6,3);
  Edit_GSL.Text  := FloatToStrRegionF(CDetector.GSL,ffGeneral,6,3);
  Edit_GSR.Text  := FloatToStrRegionF(CDetector.GSR,ffGeneral,6,3);
  Edit_GM1.Text  := FloatToStrRegionF(CDetector.GM1,ffGeneral,6,3);
  Edit_DGM2.Text := FloatToStrRegionF(CDetector.DGM2,ffGeneral,6,3);
  MainForm.Dosimeter.CalcDetectorDose(CDetector.Position);
  Edit_S.Text := FloatToStrRegionF(CDetector.Dose, ffFixed, 8, 3);
  case CalcType of
    ccFromDB: Edit_S.Color := clSilver;// clLtGray;
    ccAuto: Edit_S.Color := clMoneyGreen;
    ccManual: Edit_S.Color := clYellow;
  end;
//  Edit_Err.Text := FloatToStrRegionF(CDetector.Err, ffFixed, 8, 2);
  if Abs(CDetector.S)>0.2  // Edit_Err.Text := FloatToStrRegionF(CDetector.Err/CDetector.S*CDetector.Dose, ffFixed, 8, 3); // переводим ошибку из площади в дозу
  then Edit_Err.Text := FloatToStrRegionF(CDetector.Err/CDetector.S*100, ffFixed, 8, 2) // переводим ошибку из площади в проценты
  else Edit_Err.Text := '0';
  Edit_S.Hint := rsSuquare+'='+FloatToStrRegionF(CDetector.S, ffFixed, 8, 2) + '  χ2 =' + Edit_Err.Text; // ±

  Edit_Err.Color := Edit_S.Color;

  Edit_N1.Text := FloatToStrRegionF(CDetector.N1,ffGeneral,3,1);
  Edit_N2.Text := FloatToStrRegionF(CDetector.N2,ffGeneral,3,1);

  Edit_BN1.Text := FloatToStrRegionF(CDetector.BN1,ffGeneral,3,1);
  Edit_BN1_width.Text := FloatToStrRegionF(CDetector.BN1_width,ffGeneral,3,1);
  Edit_BN2.Text := FloatToStrRegionF(CDetector.BN2,ffGeneral,3,1);
  Edit_BN2_width.Text := FloatToStrRegionF(CDetector.BN2_width,ffGeneral,3,1);

  // вывод результатов по фону
  EditBy0.Text := FloatToStrRegionF(CDetector.By0,ffGeneral,6,3);
  EditBt.Text := FloatToStrRegionF(CDetector.Bt,ffGeneral,6,3);
  EditBx0.Text := FloatToStrRegionF(CDetector.Bx0,ffGeneral,6,3);
  EditBxy0.Text := FloatToStrRegionF(CDetector.Bxy0,ffGeneral,6,3);
  EditBdy.Text := FloatToStrRegionF(CDetector.Bdy,ffGeneral,6,3);
  if OptionsForm.CLB_Log.Checked[clogFon] then
    OptionsForm.REdit.Lines.Add('Background found at range   from ' +
      IntToStr(BG_Start) + ' to ' + IntToStr(BG_End) + '  Bx0=' +
      FloatToStrRegion(CDetector.Bx0) + '  By0=' + FloatToStrRegion(CDetector.By0) + '  Bt='
      + FloatToStrRegion(CDetector.Bt));
end;


procedure TCalcForm.FoundPeakCorrection;
var
  i, r: integer;
  Buf: double;
//  RangeLeft, RangeRight: integer;
//  calcBt,calcBx0: double;
  Amax,Sum,SumMax : double;
begin
  CDetector.GM1 := FoundPeak.Centre + StrToFloatRegion(OptionsForm.VLE.Cells[1, 1]);
  CDetector.DGM2 := -GetVLE_Float('DGM2 (GM1), A',16.76762) - GetVLE_Float('DGM2 (GM1), B',0.07084) * CDetector.GM1;
  CDetector.GA1 := BuffAvg[FoundPeak.Centre] - BuffBackground[FoundPeak.Centre];
  CDetector.GSL := GetVLE_Float('GSL (GM1), A',10.15911) + GetVLE_Float('GSL (GM1), B',0.02355) * CDetector.GM1;
  // GSL := 10.15911+0.02355*GM1; //GSL := Abs(min1 - icL)-1.5;
  CDetector.GSR := GetVLE_Float('GSR (GSL), A',0) + GetVLE_Float('GSR (GSL), B',0.61) * CDetector.GSL;
  // GSR := Abs(icR - min1)-2; //GSR := GSL/1.64;
  CDetector.DGA2 := GetVLE_Float('DGA2',0.3);


  // DGA2 := 0.3;
  // Коррекция GSR, DGM2 и GSL
  // для больших пиков можно поточнее определить GSR, а по ней скорректировать некоторые остальные параметры
//  if CDetector.GA1 > 20 then
  if CDetector.GA1 >= 6 then
  begin
    Buf := CDetector.GA1 / 2; // полувысота
    // Определяем GSR по правой половине ПШПВ
    for i := FoundPeak.Centre + 1 to MaxChannels do
    // цикл от середины пика до края массива
      if (BuffAvgWOB[i - 1] > Buf) and (BuffAvgWOB[i] <= Buf) then
      begin
        r := i - FoundPeak.Centre;
        Buf := (r - 0.5) / (2.35482 / 2); // Вычисляем новый GSR
        if Abs(CDetector.GSR)>0.000001 then CDetector.Dgm2:=CDetector.Dgm2*Buf/CDetector.GSR; // пропорциональное ужимание расстояния между пиками при ужимании пика
        CDetector.GSR := Buf;
        CDetector.GSL := 1.3 * CDetector.GSR; // чистый волюнтаризм
        break;
      end;
    // Определяем DGA2 по левой половине ПШПВ
    Buf := CDetector.GA1 / 2; // полувысота
    for i := FoundPeak.Centre - 1 downto 0 do
    // цикл от середины пика до начала массива
      if (BuffAvgWOB[i + 1] > Buf) and (BuffAvgWOB[i] <= Buf) then
      begin
        r := FoundPeak.Centre - i; // левое плечо ПШПВ состоит из GSL и кусочка пика 4 с неизвестной высотой (в большинстве случаев на полувысоте не должно быть пика 4)
        Buf := (r - 0.5) / (2.35482 / 2); // Вычисляем новый левую часть ПШПВ в предположении что пика 4 нет (GSL в чистом виде)
        // ПШПВ = 2.35482*Sigma для Гаусса
//        if Abs(CDetector.GSR)>0.000001 then CDetector.Dgm2:=CDetector.Dgm2*Buf/CDetector.GSR; // пропорциональное ужимание расстояния между пиками при ужимании пика
        if Buf<1.1 * CDetector.GSL then // если полученная ширина меньше некоторой валюнтаристской оценки,
        CDetector.GSL := Buf; // то принимаем GSL от полученных расчётов
        break;
      end;
  end;

  // Коррекция центра пика по интегральному среднему между сигм со смещением вправо
  Sum:=0;
  for i := FoundPeak.LeftSigma to FoundPeak.RightSigma do
  begin
    Sum := Sum + BuffAvgWOB[i];
  end;
  SumMax := Sum * 2/3; // Интегральная середина
  Sum:=0;
  for i := FoundPeak.LeftSigma to FoundPeak.RightSigma do
  begin
    Sum := Sum + BuffAvgWOB[i];
    if Sum>SumMax then
    begin
      CDetector.GM1 := i;
      break;
    end;
  end;

  // коррекция высоты - максимум
  Amax := BuffAvgWOB[FoundPeak.Centre];
  for i := FoundPeak.LeftSigma to FoundPeak.RightSigma do
    if BuffAvgWOB[i] > Amax then
      Amax := BuffAvgWOB[i];
  CDetector.GA1 := Amax; // максимальная амплитуда
end;

procedure TCalcForm.CalcShow;
var
  WOFon: double;
  i: integer;
  St,St2 : String;
  bEnoughS: boolean;
  bShowPeak: boolean;
  bFitting: boolean;
begin
  try
    bFitting := (pos('Fit',CDetector.Method)>0);
    bEnoughS  := CDetector.S > StrToInt(OptionsForm.Edit_MinSforShowPeak.Text);
    bShowPeak := bFitting and bEnoughS and (CDetector.PeakFound or OptionsForm.CB_DoPeakAlways.Checked);
    SeriesFuncPik1.Active := SeriesFuncPik1.Active and bShowPeak;
    SeriesFuncPik2.Active := SeriesFuncPik2.Active and bShowPeak;
    SeriesSumPeaks.Active := bShowPeak;
    SeriesFon.Legend.Visible := CDetector.FonFound;
    SeriesFuncPik1.Legend.Visible := bShowPeak;
    SeriesFuncPik2.Legend.Visible := bShowPeak;
    SeriesSumPeaks.Legend.Visible := bShowPeak;

//    ChartTool_Peak5_X.Visible := bShowPeak;
//    ChartTool_Peak5_Y.Visible := bShowPeak;
//    ChartTool_Peak4_X.Visible := bShowPeak;
//    ChartTool_Peak4_Y.Visible := bShowPeak;

    SeriesSRC.Clear;
    SeriesGlade.Clear;
    SeriesSumPeaks.Clear;
    SeriesFon.Clear;
    SeriesFuncPik1.Clear;
    SeriesFuncPik2.Clear;
    SeriesInterestRegion.Clear;
    SeriesTempProfil.Clear;
    WOFon := 0;

    for i := 0 to MaxChannels do // выводим в TChart
    begin
      if CB_WOFon.Checked then
        WOFon := BuffBackground[i];

      SeriesSRC.AddXY(i, CDetector.BuffPulses[i] - WOFon);

      SeriesGlade.AddXY(i, BuffAvg[i] - WOFon);
      SeriesFon.AddXY(i, BuffBackground[i] - WOFon);

      if not (CDetector.PeakFound or OptionsForm.CB_DoPeakAlways.Checked) then
      begin
        if (i >= CDetector.N1) and (i <= CDetector.N2) then
          SeriesInterestRegion.AddXY(i, BuffAvg[i] - WOFon);
      end;

      SeriesFuncPik1.AddXY(i, Peak_R1[i] + BuffBackground[i] - WOFon);
      SeriesFuncPik2.AddXY(i, Peak_R2[i] + BuffBackground[i] - WOFon);
      SeriesSumPeaks.AddXY(i, BuffDGauss[i] + BuffBackground[i] - WOFon);

      if (CDetector.PeakFound or OptionsForm.CB_DoPeakAlways.Checked) and (OptionsForm.RG_TypeS.ItemIndex<>clcSquare)
        then SeriesInterestRegion.AddXY(i, Peak_R1[i] + BuffBackground[i] - WOFon)
        else
          if (i >= CDetector.N1) and (i <= CDetector.N2)
            then SeriesInterestRegion.AddXY(i, BuffAvg[i] - WOFon);
    end;
    MainForm.ShowDetectorData(SeriesTempProfil, CDetector.Tmp);

//    ChartCalc.Axes.Left.AutomaticMaximum := False;
//    ChartCalc.Axes.Left.Maximum := SeriesSRC.MaxYValue*1.15;
    MainForm.DSeriaAutoSize(ChartCalc,SeriesSRC); // AutoSize refresh

    St := OptionsForm.RG_MainAlgorithm.Items[OptionsForm.RG_MainAlgorithm.ItemIndex];
    if bOptionsChanged then St := rsUserOptions;
    case CalcType of
      ccAuto:  St := St + ' ' + rsAutoCalc;
      ccManual:  St := St + ' ' + rsManualChanges;
      ccFromDB:
        if CDetector.AutoProcessing
        then St := CDetector.Method + ' ' + rsAutoCalcFromDB;
        else St := CDetector.Method + ' ' + rsManualChangesFromDB;
    end;
{
    ChartTool_Annotation.Text := St;
    ChartTool_Annotation.Callout.XPosition := ChartCalc.BottomAxis.CalcSizeValue(CDetector.N1);
    ChartTool_Annotation.Callout.YPosition := ChartCalc.Height div 2;
    ChartTool_Annotation.Visible := False;

    ChartTool_N1.Annotation.Text := FloatToStrRegionF(CDetector.N1,ffGeneral,3,1);
    ChartTool_N2.Annotation.Text := FloatToStrRegionF(CDetector.N2,ffGeneral,3,1);
    ChartTool_BN1_Annotation.Annotation.Text := FloatToStrRegionF(CDetector.BN1,ffGeneral,3,1)+#13#10+FloatToStrRegionF(CDetector.BN1_width,ffGeneral,3,1);
    ChartTool_BN2_Annotation.Annotation.Text := FloatToStrRegionF(CDetector.BN2,ffGeneral,3,1)+#13#10+FloatToStrRegionF(CDetector.BN2_width,ffGeneral,3,1);
    ChartTool_Peak4_X.Annotation.Text := FloatToStrRegionF(CDetector.gm1,ffGeneral,6,3);
    ChartTool_Peak4_Y.Annotation.Text := FloatToStrRegionF(CDetector.ga1,ffGeneral,6,3);
    ChartTool_Peak5_X.Annotation.Text := FloatToStrRegionF(CDetector.Dgm2,ffGeneral,6,3);
    ChartTool_Peak5_Y.Annotation.Text := FloatToStrRegionF(CDetector.Dga2,ffGeneral,6,3);
}

    ChartFooter:='';
    if not CDetector.FonFound then
      ChartFooter:=rsBackgroundFailure;
    if bFitting and not CDetector.PeakFound then
    begin
      if OptionsForm.CB_DoPeakAlways.Checked and bEnoughS
      then ChartFooter:=rsPeakSimulated
      else ChartFooter:=rsPeakNotFound;
    end;

    if OutEnum=outGood then
    begin
      ChartSubFooter :='';
      Btn_ClearWarning.Visible := False;
      SB_UserWarning.Visible := True;
    end
      else
    begin
      St2:=CDetector.Comment;
      St2:= StringReplace(St2,#10,'',[rfReplaceAll]); // подавление лишних символов переноса
      if OutEnum=outWarning then ChartSubFooter:=rsWarning+': '+ St2;
      if OutEnum=outBad then ChartSubFooter:=rsError+': '+ St2;
      Btn_ClearWarning.Visible := True;
      SB_UserWarning.Visible := False;
    end;

    ChartSubTitle:=St;
    TabSheet_Peak.TabVisible := bFitting;

  except
    on E: exception do
    begin
      Logging('Internal mistake [01]: ' + E.Message);
      OutDetail(outBAD,'Internal mistake [01]: ' + E.Message);
    end;
  end;
end;

procedure TCalcForm.ChangeOptions(Sender: TObject);
begin // Если менялись настройки алгоритма, то алгоритм мог быть изменен,
  if not DisableCalcControls then // Если изменения произошли не из-за работы автоматического расчёта
  begin
    CalcType := ccManual;
    CalcRefresh;
    CalcForm.CalcType := ccManual;
    if not bOptionsChanged and Assigned(CDetector) then
      CDetector.AutoProcessing := False;
  end;
end;

var
  bReDrawAferResize: boolean = false;
procedure TCalcForm.ChartCalcAfterDraw(Sender: TObject);
begin
  if bReDrawAferResize or (Sender=Nil) then
  begin
//    PanelInChart.Left := ChartCalc.Legend.Left;
    bReDrawAferResize := False;
  end;
end;

procedure TCalcForm.ChartCalcAfterDrawBackWall(ASender: TChart;
  ACanvas: TCanvas; const ARect: TRect);
var
  X,X2: integer;
begin
  if ChartTool_N_Active then
  begin
    if not Assigned(CDetector) then Exit;

    // BN1,BN2
    ChartTool_BN1_Value:=0;
    ChartTool_BN1_Width:=1;
    ChartTool_BN2_Value:=0;
    ChartTool_BN2_Width:=1;
    ChartTool_BN1_Pen_Width:=1;
    ChartTool_BN2_Pen_Width:=1;

    ChartTool_BN1_Value:=CDetector.BN1;
    ChartTool_BN2_Value:=CDetector.BN2;
    ChartTool_BN1_Width:=CDetector.BN1_width;
    ChartTool_BN2_Width:=CDetector.BN2_width;

    ChartCalc.Canvas.Brush.Color:=clGreen;
    ChartCalc.Canvas.Brush.Style:=bsBDiagonal;
    ChartCalc.Canvas.Pen.Color:=clGreen;

    ChartCalc.Canvas.Pen.Width:=ChartTool_BN1_Pen_Width;
    X:=ChartCalc.XGraphToImage(ChartTool_BN1_Value);
    X2:=ChartCalc.XGraphToImage(ChartTool_BN1_Value + ChartTool_BN1_Width);
    ChartCalc.Canvas.FillRect(X,ChartCalc.ClipRect.Top,X2,ChartCalc.ClipRect.Bottom);
    ChartCalc.Canvas.Rectangle(X,ChartCalc.ClipRect.Top,X2,ChartCalc.ClipRect.Bottom);

    ChartCalc.Canvas.Pen.Width:=ChartTool_BN2_Pen_Width;
    X:=ChartCalc.XGraphToImage(ChartTool_BN2_Value);
    X2:=ChartCalc.XGraphToImage(ChartTool_BN2_Value + ChartTool_BN2_Width);
    ChartCalc.Canvas.FillRect(X,ChartCalc.ClipRect.Top,X2,ChartCalc.ClipRect.Bottom);
    ChartCalc.Canvas.Rectangle(X,ChartCalc.ClipRect.Top,X2,ChartCalc.ClipRect.Bottom);

    // N_Delimiter,N2
    ChartTool_N1_Value:=CDetector.N1;
    ChartTool_N2_Value:=CDetector.N2;
    ChartCalc.Canvas.Pen.Width:=ChartTool_N_Pen_Width;
    ChartCalc.Canvas.Pen.Color:=clRed;
    if ChartTool_N1_Value>0 then
    begin
      X:=ChartCalc.XGraphToImage(ChartTool_N1_Value);
      ChartCalc.Canvas.Line(X,ChartCalc.ClipRect.Top,X,ChartCalc.ClipRect.Bottom);
    end;
    if ChartTool_N2_Value>0 then
    begin
      X:=ChartCalc.XGraphToImage(ChartTool_N2_Value);
      ChartCalc.Canvas.Line(X,ChartCalc.ClipRect.Top,X,ChartCalc.ClipRect.Bottom);
    end;

  end;
end;

procedure TCalcForm.ChartCalcResize(Sender: TObject);
begin
  bReDrawAferResize := True;
//  ChartCalc.BufferedDisplay:=True;
end;

procedure TCalcForm.ChartCalcZoom(Sender: TObject);
begin
//  if ChartCalc.LeftAxis.Minimum<0 then ChartCalc.LeftAxis.Minimum:=0;
end;

procedure TCalcForm.Edit_Enter(Sender: TObject);
begin
  (Sender As TEdit).Enabled := False;
end;

procedure TCalcForm.Edit_Exit(Sender: TObject);
begin
  (Sender As TEdit).Enabled := True;
end;

procedure TCalcForm.Btn_FullAutoClick(Sender: TObject);
begin
  DisableCalcControls := True;

  CalcType:=ccAuto;
  CalcRefresh;

  if not bOptionsChanged and Assigned(CDetector) then
    CDetector.AutoProcessing := True;

  SetInterfaceByPermits;
  DisableCalcControls := False;
//  ChartCalc.UndoZoom;
end;

procedure TCalcForm.NOptHideZonesClick(Sender: TObject);
begin
  bCalcForm_VisualRange_View :=  not NOptHideZones.Checked;
  bCalcForm_VisualRange_Use := bCalcForm_VisualRange_View;
  bCalcForm_EditRange_Change := bCalcForm_VisualRange_View;
  SetInterfaceByPermits;

//  NOptDenyChangeZones.Enabled := not bCalcForm_VisualRange_View;
//  SetInterfaceByPermits;
  NOpt_CorrectDelimiters;
end;

procedure TCalcForm.NOptSaveOptionsClick(Sender: TObject);
var
  ConfigIni: TInifile;
begin
  ConfigIni := TInifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  // создаем ini файл и пишем туда информацию
  ConfigIni.WriteBool('CalcForm', 'ParametersPanel', bCalcForm_ParametersPanel);
  ConfigIni.WriteBool('CalcForm', 'EditRange_Change', bCalcForm_EditRange_Change);
  ConfigIni.WriteBool('CalcForm', 'VisualChangers_View', bCalcForm_VisualChangers_View);
  ConfigIni.WriteBool('CalcForm', 'VisualChangers_Annotation', bCalcForm_VisualChangers_Annotation);
  ConfigIni.WriteBool('CalcForm', 'VisualRange_View', bCalcForm_VisualRange_View);
  ConfigIni.WriteBool('CalcForm', 'cbWOFon_View', bCalcForm_cbWOFon_View);
  ConfigIni.WriteBool('CalcForm', 'Dose_View', bCalcForm_Dose_View);
  ConfigIni.WriteBool('CalcForm', 'Err_View', bCalcForm_Err_View);
  ConfigIni.WriteBool('CalcForm', 'Menu_View', bCalcForm_Menu_View);
  ConfigIni.WriteBool('CalcForm', 'VisualChangers_Use', bCalcForm_VisualChangers_Use);
  ConfigIni.WriteBool('CalcForm', 'VisualRange_Use', bCalcForm_VisualRange_Use);
  ConfigIni.WriteBool('CalcForm', 'EditChart', bCalcForm_EditChart);
  ConfigIni.WriteBool('CalcForm', 'ExitNotifyIfManualChange', bCalcForm_ExitNotifyIfManualChange);
  ConfigIni.WriteBool('CalcForm', 'CalcForm_ShowNegativeDose', bCalcForm_ShowNegativeDose);
  ConfigIni.WriteBool('CalcForm', 'CalcForm_EditByScroll', bCalcForm_EditByScroll);
  ConfigIni.Free;
  NOptSaveOptions.Visible := false;
  NOpt_CorrectDelimiters;
end;

procedure TCalcForm.NOptShowChartEditClick(Sender: TObject);
begin
  bCalcForm_EditChart := NOptShowChartEdit.Checked;
  SetInterfaceByPermits;
  NOptSaveOptions.Visible := true;
  NOpt_CorrectDelimiters;
end;

procedure TCalcForm.NOptShowMenuClick(Sender: TObject);
begin
  bCalcForm_Menu_View := NOptShowMenu.Checked;
  SetInterfaceByPermits;
  NOptSaveOptions.Visible := true;
  NOpt_CorrectDelimiters;
end;

procedure TCalcForm.NOptShowNegativeDosesClick(Sender: TObject);
begin
  bCalcForm_ShowNegativeDose := NOptShowNegativeDoses.Checked;
  SetInterfaceByPermits;
  NOptSaveOptions.Visible := true;
  NOpt_CorrectDelimiters;
end;

procedure TCalcForm.NOptShowPanelClick(Sender: TObject);
begin
  bCalcForm_ParametersPanel := NOptShowPanel.Checked;
  bCalcForm_VisualChangers_View := NOptShowPanel.Checked;
  bCalcForm_VisualChangers_Use := NOptShowPanel.Checked;
  bCalcForm_EditByScroll := NOptShowPanel.Checked;
  bCalcForm_Err_View := NOptShowPanel.Checked;
  SetInterfaceByPermits;
  NOptSaveOptions.Visible := true;
  NOpt_CorrectDelimiters;
end;

procedure TCalcForm.NOptUnSaveNotifyOffClick(Sender: TObject);
begin
  bCalcForm_ExitNotifyIfManualChange := not NOptUnSaveNotifyOff.Checked;
  SetInterfaceByPermits;
  NOptSaveOptions.Visible := true;
  NOpt_CorrectDelimiters;
end;

procedure TCalcForm.SB_EditChartClick(Sender: TObject);
begin
//  ChartLiveView1.ed
end;

procedure TCalcForm.LoadOptions;
begin
  BG_Start := StrToInt(OptionsForm.Edit_BG_Start.Text);
  BG_End := StrToInt(OptionsForm.Edit_BG_End.Text);
  DX := StrToInt(OptionsForm.Edit_DX.Text);
  kwidth := StrToInt(OptionsForm.Edit_kWidth.Text);
  iWaitingPeakCentre := StrToIntRegion(OptionsForm.Edit_WaitingPeakCentre.Text);
  WaitMaxWidth := StrToIntRegion(OptionsForm.Edit_WaitMaxWidth.Text);
  MinS := StrToFloatRegion(OptionsForm.Edit_MinS.Text);
  MinDX := StrToFloatRegion(OptionsForm.Edit_MinDX.Text);
  IsAdaptive := OptionsForm.CB_Adaptive.Checked;
  MinS_4Fit := StrToFloatRegion(OptionsForm.Edit_MinS4Fit.Text);
  MinS_4FitFon   := StrToFloatRegion(OptionsForm.Edit_MinS4FitFon.Text);
  MinS_4SuperFit := StrToFloatRegion(OptionsForm.Edit_MinS_4SuperFit.Text);
  MinS_4FitChangeRange := StrToFloatRegion(OptionsForm.Edit_MinS_4FitChangeRange.Text);
  MaxS_4WaitingsFit := StrToFloatRegion(OptionsForm.Edit_MaxS_4WaitingsFit.Text);

  CalcForm.minErrF := StrToFloatRegion(OptionsForm.Edit_MinErrF.Text);
  CalcForm.GradientStep := StrToFloatRegion(OptionsForm.EditFonStep.Text);
  CalcForm.GradientPiece := StrToFloatRegion(OptionsForm.EditFonPiece.Text);
  CalcForm.BT40 := GetVLE_Float('Bt', 40); // Ожидаемое значение Bt
  CalcForm.FP_TooLitleLevel := GetVLE_Float('FP_TooLitleLevel', 0.2); // игнорируемый уровень колебаний сглаженной функции при поиске фона

  case OptionsForm.RG_BackgroundFunction.ItemIndex of
    0: BGFunc := bgfExp;
    1: BGFunc := bgfStep;
    2: BGFunc := bgfNone;
    else BGFunc := bgfNone;
  end;

  OCW_min[cvBy0] := StrToFloatRegion(OptionsForm.EC_By0_MinWarning.Text);
  OCW_max[cvBy0] := StrToFloatRegion(OptionsForm.EC_By0_MaxWarning.Text);
  OCE_min[cvBy0] := StrToFloatRegion(OptionsForm.EC_By0_MinError.Text);
  OCE_max[cvBy0] := StrToFloatRegion(OptionsForm.EC_By0_MaxError.Text);
  OCW_min[cvBt] := StrToFloatRegion(OptionsForm.EC_Bt_MinWarning.Text);
  OCW_max[cvBt] := StrToFloatRegion(OptionsForm.EC_Bt_MaxWarning.Text);
  OCE_min[cvBt] := StrToFloatRegion(OptionsForm.EC_Bt_MinError.Text);
  OCE_max[cvBt] := StrToFloatRegion(OptionsForm.EC_Bt_MaxError.Text);
  OCW_min[cvBx0] := StrToFloatRegion(OptionsForm.EC_Bx0_MinWarning.Text);
  OCW_max[cvBx0] := StrToFloatRegion(OptionsForm.EC_Bx0_MaxWarning.Text);
  OCE_min[cvBx0] := StrToFloatRegion(OptionsForm.EC_Bx0_MinError.Text);
  OCE_max[cvBx0] := StrToFloatRegion(OptionsForm.EC_Bx0_MaxError.Text);
  OCW_min[cvGM1] := StrToFloatRegion(OptionsForm.EC_GM1_MinWarning.Text);
  OCW_max[cvGM1] := StrToFloatRegion(OptionsForm.EC_GM1_MaxWarning.Text);
  OCE_min[cvGM1] := StrToFloatRegion(OptionsForm.EC_GM1_MinError.Text);
  OCE_max[cvGM1] := StrToFloatRegion(OptionsForm.EC_GM1_MaxError.Text);
  OCW_min[cvGA1] := StrToFloatRegion(OptionsForm.EC_GA1_MinWarning.Text);
  OCW_max[cvGA1] := StrToFloatRegion(OptionsForm.EC_GA1_MaxWarning.Text);
  OCE_min[cvGA1] := StrToFloatRegion(OptionsForm.EC_GA1_MinError.Text);
  OCE_max[cvGA1] := StrToFloatRegion(OptionsForm.EC_GA1_MaxError.Text);
  OCW_min[cvDGM2] := StrToFloatRegion(OptionsForm.EC_DGM2_MinWarning.Text);
  OCW_max[cvDGM2] := StrToFloatRegion(OptionsForm.EC_DGM2_MaxWarning.Text);
  OCE_min[cvDGM2] := StrToFloatRegion(OptionsForm.EC_DGM2_MinError.Text);
  OCE_max[cvDGM2] := StrToFloatRegion(OptionsForm.EC_DGM2_MaxError.Text);
  OCW_min[cvDGA2] := StrToFloatRegion(OptionsForm.EC_DGA2_MinWarning.Text);
  OCW_max[cvDGA2] := StrToFloatRegion(OptionsForm.EC_DGA2_MaxWarning.Text);
  OCE_min[cvDGA2] := StrToFloatRegion(OptionsForm.EC_DGA2_MinError.Text);
  OCE_max[cvDGA2] := StrToFloatRegion(OptionsForm.EC_DGA2_MaxError.Text);
  OCW_min[cvGSL] := StrToFloatRegion(OptionsForm.EC_GSL_MinWarning.Text);
  OCW_max[cvGSL] := StrToFloatRegion(OptionsForm.EC_GSL_MaxWarning.Text);
  OCE_min[cvGSL] := StrToFloatRegion(OptionsForm.EC_GSL_MinError.Text);
  OCE_max[cvGSL] := StrToFloatRegion(OptionsForm.EC_GSL_MaxError.Text);
  OCW_min[cvGSR] := StrToFloatRegion(OptionsForm.EC_GSR_MinWarning.Text);
  OCW_max[cvGSR] := StrToFloatRegion(OptionsForm.EC_GSR_MaxWarning.Text);
  OCE_min[cvGSR] := StrToFloatRegion(OptionsForm.EC_GSR_MinError.Text);
  OCE_max[cvGSR] := StrToFloatRegion(OptionsForm.EC_GSR_MaxError.Text);
  OCC[cvFon] := StrToFloatRegion(OptionsForm.ECC_Fon.Text);
  OCC[cvMaxNoPeak] := StrToFloatRegion(OptionsForm.ECC_MaxNoPeak.Text);
end;

procedure TCalcForm.SetCalcType(const Value: TCalcOptions);
begin
  FCalcType := Value;
  case FCalcType of
    ccFromDB:
      begin
        Btn_GetDefault.Enabled := False;
        Btn_FullAuto.Enabled := True;
        Btn_Save.Enabled := False;
      end;
    ccAuto:
      begin
        Btn_GetDefault.Enabled := True;
        Btn_FullAuto.Enabled := False;
        Btn_Save.Enabled := True;
      end;
    ccManual:
      begin
        Btn_GetDefault.Enabled := True;
        Btn_FullAuto.Enabled := True;
        Btn_Save.Enabled := True;
      end;
  end;
end;

var
  OneStart: boolean = True;
procedure TCalcForm.FormActivate(Sender: TObject);
var
  ConfigIni: TInifile;
begin
//  ChartCalc.BufferedDisplay:=True;
  if OneStart then
  begin
//    LoadOptions;
    ConfigIni := TInifile.Create(extractfilepath(Application.ExeName) + cConfigFile);

  // создаем ini файл и пишем туда информацию
    bCalcForm_SavePosition := ConfigIni.ReadBool('CalcForm', 'SavePosition', False);
    if bCalcForm_SavePosition then
    begin
      CalcForm.Left := ConfigIni.ReadInteger('CalcForm', 'X', CalcForm.Left);
      CalcForm.Top := ConfigIni.ReadInteger('CalcForm', 'Y', CalcForm.Top);
      CalcForm.Width := ConfigIni.ReadInteger('CalcForm', 'Width', CalcForm.Width);
      CalcForm.Height := ConfigIni.ReadInteger('CalcForm', 'Height', CalcForm.Height);
    end;

    // Ручное редактирование коэффициентов Bt,Bx0,By0,GA1,GM1.... в полях ввода
      bCalcForm_ParametersPanel := ConfigIni.ReadBool('CalcForm', 'ParametersPanel', bCalcForm_ParametersPanel);
    // Показать линии рассчётных параметров
      bCalcForm_VisualChangers_View := ConfigIni.ReadBool('CalcForm', 'VisualChangers_View', bCalcForm_VisualChangers_View);
    // Показать значения у линий рассчётных параметров
      bCalcForm_VisualChangers_Annotation := ConfigIni.ReadBool('CalcForm', 'VisualChangers_Annotation', bCalcForm_VisualChangers_Annotation);
    // Показывать зону интереса (CDetector.N1,CDetector.N2)
      bCalcForm_VisualRange_View := ConfigIni.ReadBool('CalcForm', 'VisualRange_View', bCalcForm_VisualRange_View);
    // Показывать чекбокс отображения графиков без фона
      bCalcForm_cbWOFon_View := ConfigIni.ReadBool('CalcForm', 'cbWOFon_View', bCalcForm_cbWOFon_View);
    // Показывать найденную площадь
      bCalcForm_Dose_View := ConfigIni.ReadBool('CalcForm', 'Dose_View', bCalcForm_Dose_View);
    // Показывать оценку погрешности
      bCalcForm_Err_View := ConfigIni.ReadBool('CalcForm', 'Err_View', bCalcForm_Err_View);
    // Разрешить главное меню
      bCalcForm_Menu_View := ConfigIni.ReadBool('CalcForm', 'Menu_View', bCalcForm_Menu_View);
    // Разрешить изменения рассчётных параметров перемещением линий
      bCalcForm_VisualChangers_Use := ConfigIni.ReadBool('CalcForm', 'VisualChangers_Use', bCalcForm_VisualChangers_Use);
    // Разрешить изменения зоны интереса (CDetector.N1,CDetector.N2) перемещением линий
      bCalcForm_VisualRange_Use := ConfigIni.ReadBool('CalcForm', 'VisualRange_Use', bCalcForm_VisualRange_Use);
      bCalcForm_EditChart := ConfigIni.ReadBool('CalcForm', 'EditChart', bCalcForm_EditChart);

      bCalcForm_ExitNotifyIfManualChange := ConfigIni.ReadBool('CalcForm', 'ExitNotifyIfManualChange', bCalcForm_ExitNotifyIfManualChange);
      bCalcForm_ShowNegativeDose := ConfigIni.ReadBool('CalcForm', 'CalcForm_ShowNegativeDose', bCalcForm_ShowNegativeDose);
      bCalcForm_EditByScroll := ConfigIni.ReadBool('CalcForm', 'CalcForm_EditByScroll', bCalcForm_EditByScroll);


      NOptHideZones.Checked :=  not bCalcForm_VisualRange_View;
  //    NOptDenyChangeZones.Enabled := not bCalcForm_VisualRange_View;
  //    NOptDenyChangeZones.Checked :=  not bCalcForm_VisualRange_Use;
  //    NOptEditCalcLines.Checked := bCalcForm_VisualChangers_Use;
      NOptShowChartEdit.Checked := bCalcForm_EditChart;
      NOptShowMenu.Checked := bCalcForm_Menu_View;
      NOptShowNegativeDoses.Checked := bCalcForm_ShowNegativeDose;
      NOptShowPanel.Checked := bCalcForm_ParametersPanel;
  //    NOptShowXi2.Checked := bCalcForm_Err_View;
      NOptUnSaveNotifyOff.Checked := not bCalcForm_ExitNotifyIfManualChange;

//      ChartCalc.Legend.Title.Text.Clear;
//      ChartCalc.Legend.Title.Text.Add(rsChartCalcTitle);

      ConfigIni.Free;
      OneStart := False;

      SetInterfaceByPermits;
  end;
end;

procedure TCalcForm.SetChartFunction(const Value: TChartFunction);
begin
  if FChartFunction<>Value then
  begin
    FChartFunction := Value;
    if not TabSheet_Peak.TabVisible and (Value = cfPeak) then FChartFunction := cfNone;

    PC_ChartFunction.ActivePageIndex := Ord(FChartFunction);

    case FChartFunction of
    cfNone:
      begin
        SeriesFon.AreaContourPen.Width := 1;
        SeriesSumPeaks.LinePen.Width := 1;
        SeriesGlade.LinePen.Width := 1;
        SeriesTempProfil.LinePen.Width := 4;
//        ChartCalc.RightAxis.LabelsFormat.Transparency := 0;

        ChartTool_N_Pen_Width := 3;
        ChartTool_BN1_Pen_Width := 2;
        ChartTool_BN2_Pen_Width := 1;
{
        ChartTool_Peak5_X.Pen.Width := 1;
        ChartTool_Peak5_Y.Pen.Width := 1;
        ChartTool_Peak4_X.Pen.Width := 1;
        ChartTool_Peak4_Y.Pen.Width := 1;
        ChartTool_BN1_Annotation.Visible := False;
        ChartTool_BN2_Annotation.Visible := False;
        ChartTool_N1.Annotation.Visible := True;
        ChartTool_N2.Annotation.Visible := True;
        ChartTool_Peak5_X.Annotation.Visible := False;
        ChartTool_Peak5_Y.Annotation.Visible := False;
        ChartTool_Peak4_X.Annotation.Visible := False;
        ChartTool_Peak4_Y.Annotation.Visible := False;
        ChartTool_Annotation.Text := rsCommonView;
}
        MouseEdit.Color := clWindow;
        MouseEdit := Edit_N1;
      end;
    cfBackGround:
      begin
        SeriesFon.AreaContourPen.Width := 4;
        SeriesSumPeaks.LinePen.Width := 1;
        SeriesGlade.LinePen.Width := 1;
        SeriesTempProfil.LinePen.Width := 1;

        ChartTool_N_Pen_Width := 1;
        ChartTool_BN1_Pen_Width := 6;
        ChartTool_BN2_Pen_Width := 5;
//        ChartCalc.RightAxis.LabelsFormat.Transparency := 70;
{
        ChartTool_Peak5_X.Pen.Width := 1;
        ChartTool_Peak5_Y.Pen.Width := 1;
        ChartTool_Peak4_X.Pen.Width := 1;
        ChartTool_Peak4_Y.Pen.Width := 1;
        ChartTool_BN1_Annotation.Visible := True;
        ChartTool_BN2_Annotation.Visible := True;
        ChartTool_N1.Annotation.Visible := False;
        ChartTool_N2.Annotation.Visible := False;
        ChartTool_Peak5_X.Annotation.Visible := False;
        ChartTool_Peak5_Y.Annotation.Visible := False;
        ChartTool_Peak4_X.Annotation.Visible := False;
        ChartTool_Peak4_Y.Annotation.Visible := False;
        ChartTool_Annotation.Text := rsBackgroundView;
}
        MouseEdit.Color := clWindow;
        MouseEdit := EditBy0;
      end;
    cfPeak:
      begin
        SeriesFon.AreaContourPen.Width := 1;
        if CDetector.PeakFound or OptionsForm.CB_DoPeakAlways.Checked
          then begin SeriesSumPeaks.LinePen.Width := 4; SeriesGlade.LinePen.Width := 1; end
          else begin SeriesSumPeaks.LinePen.Width := 1; SeriesGlade.LinePen.Width := 4; end;
        SeriesTempProfil.LinePen.Width := 1;
        ChartTool_N_Pen_Width := 3;
        ChartTool_BN1_Pen_Width := 2;
        ChartTool_BN2_Pen_Width := 1;
//        ChartCalc.RightAxis.LabelsFormat.Transparency := 70;
{
        ChartTool_Peak5_X.Pen.Width := 3;
        ChartTool_Peak5_Y.Pen.Width := 3;
        ChartTool_Peak4_X.Pen.Width := 3;
        ChartTool_Peak4_Y.Pen.Width := 3;
        ChartTool_BN1_Annotation.Visible := False;
        ChartTool_BN2_Annotation.Visible := False;
        ChartTool_N1.Annotation.Visible := False;
        ChartTool_N2.Annotation.Visible := False;
        ChartTool_Peak5_X.Annotation.Visible := True;
        ChartTool_Peak5_Y.Annotation.Visible := True;
        ChartTool_Peak4_X.Annotation.Visible := True;
        ChartTool_Peak4_Y.Annotation.Visible := True;
        ChartTool_Annotation.Text := rsPeakView;
 }
        MouseEdit.Color := clWindow;
        MouseEdit := Edit_GM1;
      end;
    end;
//    ChartTool_Annotation.Visible := True;
    tmAnnotation := 25;
    CalcTimer.Enabled:=True;
  end;
end;

procedure TCalcForm.SetChartTitle(const Value: string);
begin
  if FChartTitle<>Value then
  begin
    FChartTitle := Value;
    ChartCalc.Title.Text.Clear;
    ChartCalc.Title.Text.Add(
    '<font size = "5" color = #000000>' +
        FChartTitle +
    '</font>');
    ChartCalc.Title.Text.Add(
    '<font size = "5" color = #0000ff>' +
        FChartSubTitle +
    '</font>');
  end;
end;

procedure TCalcForm.SetChartSubTitle(const Value: string);
begin
  if FChartSubTitle<>Value then
  begin
    FChartSubTitle := Value;
    ChartCalc.Title.Text.Clear;
    ChartCalc.Title.Text.Add(
    '<font size = "5" color = #000000>' +
        FChartTitle +
    '</font>');
    ChartCalc.Title.Text.Add(
    '<font size = "5" color = #0000ff>' +
        FChartSubTitle +
    '</font>');
  end;
end;

procedure TCalcForm.SetChartFooter(const Value: string);
begin
  if FChartFooter<>Value then
  begin
    FChartFooter := Value;
    ChartCalc.Foot.Text.Clear;
    ChartCalc.Foot.Text.AddDelimitedtext('<font color = #800040>' +
      StringReplace(FChartFooter,#13,'</font>'+#13+'<font color = #800040>',[rfReplaceAll]) + // ХИТРЫЙ ХОД для многострочных текстов
      '</font>',
      #13,true);
//    ChartCalc.Foot.Text.AddDelimitedtext(FChartFooter,#13,true);
    ChartCalc.Foot.Text.AddDelimitedtext('<font color = #ff0000>' +
      StringReplace(FChartSubFooter,#13,'</font>'+#13+'<font color = #ff0000>',[rfReplaceAll]) + // ХИТРЫЙ ХОД для многострочных текстов
      '</font>',
      #13,true);
//    ChartCalc.Foot.Text.Add('<font color = #800040>' + FChartFooter + '</font>');
//    ChartCalc.Foot.Text.Add('<font color = #ff0000>' + FChartSubFooter + '</font>');
  end;
end;

procedure TCalcForm.SetChartSubFooter(const Value: string);
begin
  if FChartSubFooter<>Value then
  begin
    FChartSubFooter := Value;
    ChartCalc.Foot.Text.Clear;
    ChartCalc.Foot.Text.AddDelimitedtext('<font color = #800040>' +
      StringReplace(FChartFooter,#13,'</font>'+#13+'<font color = #800040>',[rfReplaceAll]) + // ХИТРЫЙ ХОД для многострочных текстов
      '</font>',
      #13,true);
//    ChartCalc.Foot.Text.AddDelimitedtext(FChartFooter,#13,true);
    ChartCalc.Foot.Text.AddDelimitedtext('<font color = #ff0000>' +
      StringReplace(FChartSubFooter,#13,'</font>'+#13+'<font color = #ff0000>',[rfReplaceAll]) + // ХИТРЫЙ ХОД для многострочных текстов
      '</font>',
      #13,true);
//    ChartCalc.Foot.Text.Add('<font color = #800040>' + FChartFooter + '</font>');
//    ChartCalc.Foot.Text.Add('<font color = #ff0000>' + FChartSubFooter + '</font>');
  end;
end;

procedure TCalcForm.SourceFilter(aDetector: TDetector);
var
  i: integer;
  FilterMinDiff : integer;
begin
  FilterMinDiff := StrToInt(OptionsForm.Edit_FilterMinDiff.Text);
  for i := 1 to cMaxChannels-1 do
    if  (aDetector.BuffPulses[i]-FilterMinDiff >= aDetector.BuffPulses[i-1]+SQRT(aDetector.BuffPulses[i-1]))
    and (aDetector.BuffPulses[i]-FilterMinDiff >= aDetector.BuffPulses[i+1]+SQRT(aDetector.BuffPulses[i+1])) then // если значение больше чем оба соседа более чем на 1
      aDetector.BuffPulses[i] := (aDetector.BuffPulses[i-1] + aDetector.BuffPulses[i+1]) div 2 + 1;
end;

procedure TCalcForm.SetDefaultOptions(aDetector: TDetector; aOptions: TSDefOptions = sdefDefinitely);
var
  OldDisableControls1, OldDisableControls2: boolean;
begin
  OldDisableControls1:=DisableCalcControls;
  DisableCalcControls := true; // признак по которому будут запрещен пересчёт при изменениях в Edit-ах коэффициентов

  if (aOptions = sdefDefinitely) or not bOptionsChanged then
  try
    try
      OldDisableControls2:=OptionsForm.DisableOptionsControls;
      OptionsForm.DisableOptionsControls := true;


      if aDetector.DetType = 'Cu_step_140' then aDetector.Method := 'Step';


      MainAlgorithm := OptionsForm.CalcMainMethod(aDetector.Method);
      OptionsForm.SetDefaultOptionsByMaterial(MainAlgorithm);
    finally
      OptionsForm.DisableOptionsControls := OldDisableControls2; // восстанавливаем в любом случае, даже при исключении - раньше при сбое флаг мог остаться выставленным в true навсегда
    end;
  except
    on E: Exception do
      WriteLog(Format(rsCalcFormError,['SetDefaultOptions',E.Message]));
  end;

  LoadOptions;
  DisableCalcControls := OldDisableControls1;
end;


procedure TCalcForm.NOptDefaultClick(Sender: TObject);
begin
  bCalcForm_SavePosition:= false;
  bCalcForm_ParametersPanel:= false;
  bCalcForm_EditRange_Change:= true;
  bCalcForm_VisualChangers_View:= false;
  bCalcForm_VisualChangers_Annotation:= false;
  bCalcForm_VisualRange_View:= true;
  bCalcForm_VisualRange_Use:= true;
  bCalcForm_cbWOFon_View:= true;
  bCalcForm_Dose_View:= true;
  bCalcForm_Err_View:= false;
  bCalcForm_Menu_View:= false;
  bCalcForm_VisualChangers_Use:= false;
  bCalcForm_EditChart:= false;
  bCalcForm_ExitNotifyIfManualChange:= true;
  bCalcForm_ShowNegativeDose:= false;
  bCalcForm_EditByScroll:= false;
  NOptSaveOptionsClick(Sender);
  OneStart := True;
  FormActivate(Sender);
  NOptSaveOptions.Visible := false;
  NOpt_CorrectDelimiters;
end;

end.
