unit uModel;

interface

uses
//  Messages,
  SysUtils,System.UITypes, Variants, Classes, Graphics, Math,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, taGraph, Grids,
  DB, SQLDB, uDataModule, Menus,
//  ExtDlgs,
  taSeries, taCustomSeries,
  Spin;
// VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.TeeTools,VCLTee.TeeScrollPagerTool, Data.Win.ADODB,

type

  { TModelW }

  TModelW = class(TForm)
    PanelChartPeak: TPanel;
    PanelTopPeak: TPanel;
    EditChartPeak: TEdit;
    BtnOpenPeak: TButton;
    OpenDialogChart: TOpenDialog;
    StringGridPeak: TStringGrid;
    BtnPlusPeak: TButton;
    EditKPeak: TEdit;
    BtnMinusPeak: TButton;
    ChartPeak: TChart;
    LabelIPeak: TLabel;
    SeriesKTVPeak: TLineSeries;
    SeriesLinePeak: TLineSeries;
//    ChartToolCursorLeftPeak: TCursorTool;
//    ChartToolCursorRightPeak: TCursorTool;
    PanelConfigPeak: TPanel;
    LabelKPeak: TLabel;
    GroupBoxChangePeak: TGroupBox;
    BtnResetPeak: TButton;
    LblSPeak: TLabel;
    EditSPeak: TEdit;
    SeriesAreaPeak: TAreaSeries;
    CBoxDos: TComboBox;
    LblDosPeak: TLabel;
    ADOQueryModel: TSQLQuery;
    BtnImport: TButton;
    CBZeroPeak: TCheckBox;
    PanelPeak: TPanel;
    LblPeak: TLabel;
    PanelFon: TPanel;
    SplitterTop: TSplitter;
    SplitterBottom: TSplitter;
    PanelFonPeak: TPanel;
    PanelTopFon: TPanel;
    LblFon: TLabel;
    EditChartFon: TEdit;
    BtnOpenFon: TButton;
    ChartFon: TChart;
    LabelIFon: TLabel;
    SeriesKTVFon: TLineSeries;
    SeriesLineFon: TLineSeries;
    SeriesAreaFon: TAreaSeries;
//    ChartToolCursorLeftFon: TCursorTool;
//    ChartToolCursorRightFon: TCursorTool;
    PanelConfigFon: TPanel;
    LblSFon: TLabel;
    GroupBoxChangeFon: TGroupBox;
    LabelKFon: TLabel;
    EditKFon: TEdit;
    BtnPlusFon: TButton;
    BtnMinusFon: TButton;
    CBZeroFon: TCheckBox;
    BtnResetFon: TButton;
    EditSFon: TEdit;
    StringGridFon: TStringGrid;
    PanelChartFon: TPanel;
    PanelChartFonPeak: TPanel;
    ChartFonPeak: TChart;
    LabelIFonPeak: TLabel;
    SeriesKTVFonPeak: TLineSeries;
    SeriesLineFonPeak: TLineSeries;
    SeriesAreaFonPeak: TAreaSeries;
//    ChartToolCursorLeftFonPeak: TCursorTool;
//    ChartToolCursorRightFonPeak: TCursorTool;
    PanelConfigFonPeak: TPanel;
    LblSFonPeak: TLabel;
    GroupBoxChangeFonPeak: TGroupBox;
    LabelKFonPeak: TLabel;
    EditKFonPeak: TEdit;
    BtnPlusFonPeak: TButton;
    BtnMinusFonPeak: TButton;
    CBZeroFonPeak: TCheckBox;
    BtnResetFonPeak: TButton;
    EditSFonPeak: TEdit;
    StringGridFonPeak: TStringGrid;
    PanelTopFonPeak: TPanel;
    LblFonPeak: TLabel;
    EditChartFonPeak: TEdit;
    BtnOpenFonPeak: TButton;
    MainMenuModel: TMainMenu;
    MainMenuFile: TMenuItem;
    MenuFileDefaultSize: TMenuItem;
    PanelCharts: TPanel;
    PanelRight: TPanel;
    BtnSaveToFilePeak: TButton;
    SaveTextFileChart: TSaveDialog;
    BtnSaveToFileFon: TButton;
    BtnSaveToFileFonPeak: TButton;
    BtnSaveCalcFon: TButton;
    GroupBoxStretchPeak: TGroupBox;
    Label1: TLabel;
    EditStretchPeak: TEdit;
    CBSaveS: TCheckBox;
    Button2: TButton;
    Button3: TButton;
    BtnDigitFon: TButton;
    EditMeasComment: TEdit;
    GroupBox1: TGroupBox;
    AutoSE_Min: TSpinEdit;
    AutoSE_Max: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    AutoCB_UseAuto: TCheckBox;
    AutoSE_A: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    AutoSE_B: TSpinEdit;
    BtnLoadFromFile: TButton;
    OpenDialogTxt: TOpenDialog;
    procedure BtnOpenPeakClick(Sender: TObject);
    procedure StringGridPeakDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure BtnPlusPeakClick(Sender: TObject);
    procedure BtnMinusPeakClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
//    procedure ChartToolCursorLeftPeakSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
//    procedure ChartToolCursorRightPeakSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
    procedure BtnResetPeakClick(Sender: TObject);
    procedure BtnOpenFonClick(Sender: TObject);
//    procedure ChartToolCursorLeftFonSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
//    procedure ChartToolCursorRightFonSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
    procedure BtnResetFonClick(Sender: TObject);
    procedure BtnPlusFonClick(Sender: TObject);
    procedure BtnMinusFonClick(Sender: TObject);
    procedure BtnOpenFonPeakClick(Sender: TObject);
//    procedure ChartToolCursorLeftFonPeakSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
//    procedure ChartToolCursorRightFonPeakSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
    procedure BtnPlusFonPeakClick(Sender: TObject);
    procedure BtnMinusFonPeakClick(Sender: TObject);
    procedure BtnResetFonPeakClick(Sender: TObject);
    procedure BtnSaveCalcFonClick(Sender: TObject);
    procedure MenuFileDefaultSizeClick(Sender: TObject);
    procedure BtnSaveToFilePeakClick(Sender: TObject);
    procedure BtnSaveToFileFonClick(Sender: TObject);
    procedure BtnSaveToFileFonPeakClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BtnDigitFonClick(Sender: TObject);
    procedure BtnLoadFromFileClick(Sender: TObject);
  private
    FSPeak            : double;
    FSFon             : double;
    FSFonPeak         : double;
    procedure LoadFiles;
    procedure LoadPeak;
    procedure LoadFon;
    procedure LoadFonPeak;
    procedure LoadGrid(Grid: TStringGrid;FileName: String; Separator: String);
    procedure LoadChart(Seria: TLineSeries; FileName: String);
//    procedure CalcPlus(SeriaLine,SeriaKTV: TLineSeries; CursorLeft,CursorRight: TCursorTool; CheckBox: TCheckBox;k: double);
//    procedure CalcMinus(SeriaLine,SeriaKTV: TLineSeries; CursorLeft,CursorRight: TCursorTool; CheckBox: TCheckBox;k: double);
//    procedure CalcLine(SeriaLine,SeriaKTV: TLineSeries; SeriesArea: TAreaSeries; CursorLeft,CursorRight: TCursorTool);
//    procedure SetSnap(Cursor: TCursorTool; x,y: double);
    procedure LoadDos;
    procedure StretchPeak;
    procedure ShrinkPeak;
    procedure SaveDetectorData;
    procedure SetSPeak(Value: double);
    procedure SetSFon(const Value: double);
    procedure SetSFonPeak(const Value: double);
    procedure DrawFonPeak;
//    procedure SaveToFile(Seria: TLineSeries);

    function CalcMax(Seria: TChartSeries): double;
    function GetSnapY(Seria: TChartSeries; x: integer): double;
//    function CalcSFullPeak(SeriaLine,SeriaKTV: TLineSeries; SeriesArea: TAreaSeries; CursorLeft,CursorRight: TCursorTool): double;
    //function CalcSTopPeak(SeriaLine,SeriaKTV: TLineSeries; SeriesArea: TAreaSeries; CursorLeft,CursorRight: TCursorTool): double;
    //function CalcSPeak(SeriaLine,SeriaKTV: TLineSeries; SeriesArea: TAreaSeries; CursorLeft,CursorRight: TCursorTool): double;
    { Private declarations }
  public
    procedure SaveToFile(Seria: TLineSeries);
    property SPeak: double read FSPeak write SetSPeak;
    property SFon: double read FSFon write SetSFon;
    property SFonPeak: double read FSFonPeak write SetSFonPeak;
    { Public declarations }
  end;

const
  cDefaultK = 2;
  cDefaultLeft = 0;
  cDefaultRight = 299;
  cDefaultStretchCh = 10;
var
  ModelW: TModelW;

implementation

uses
  uConst,
  uMainForm,
  uDosimeter,
  uDetector,
  uFunctions,
  uLanguages,
  uCalcForm,
  uSeparator;

{$R *.dfm}

procedure TModelW.BtnOpenFonClick(Sender: TObject);
begin
  if OpenDialogChart.Execute then
  begin
    EditChartFon.Text:=OpenDialogChart.FileName;

    LoadChart(SeriesKTVFon,OpenDialogChart.FileName);

//    SetSnap(ChartToolCursorLeftFon,cDefaultLeft,GetSnapY(SeriesKTVFon,cDefaultLeft));
//    SetSnap(ChartToolCursorRightFon,cDefaultRight,GetSnapY(SeriesKTVFon,cDefaultRight));
//    CalcLine(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
//    SFon:=CalcSFullPeak(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);

    DrawFonPeak;
  end;
end;

procedure TModelW.BtnOpenFonPeakClick(Sender: TObject);
begin
  if OpenDialogChart.Execute then
  begin
    EditChartFonPeak.Text:=OpenDialogChart.FileName;

    LoadChart(SeriesKTVFonPeak,OpenDialogChart.FileName);

//    SetSnap(ChartToolCursorLeftFonPeak,cDefaultLeft,GetSnapY(SeriesKTVFonPeak,cDefaultLeft));
//    SetSnap(ChartToolCursorRightFonPeak,cDefaultRight,GetSnapY(SeriesKTVFonPeak,cDefaultRight));
//    CalcLine(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
//    SFonPeak:=CalcSFullPeak(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);

    DrawFonPeak;
  end;
end;

procedure TModelW.BtnOpenPeakClick(Sender: TObject);
begin
  if OpenDialogChart.Execute then
  begin
    EditChartPeak.Text:=OpenDialogChart.FileName;

    LoadChart(SeriesKTVPeak,OpenDialogChart.FileName);

//    SetSnap(ChartToolCursorLeftPeak,cDefaultLeft,GetSnapY(SeriesKTVPeak,cDefaultLeft));        // отключить если мешает
//    SetSnap(ChartToolCursorRightPeak,cDefaultRight,GetSnapY(SeriesKTVPeak,cDefaultRight));     //
//    CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
//    SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);

    DrawFonPeak;
  end;
end;

procedure TModelW.BtnMinusFonClick(Sender: TObject);
var
  i: integer;
  K: integer;
  St: String;
begin
{
  if AutoCB_UseAuto.Checked then
  begin
    St := EditKFon.Text;
    for i := AutoSE_min.Value to AutoSE_max.Value do
    begin
      BtnResetPeakClick(Nil);

      K := i*AutoSE_A.Value + AutoSE_B.Value;
      EditKFon.Text := IntToStr(K);
      EditMeasComment.Text := EditKPeak.Text;

      if ChartToolCursorLeftFon.XValue<ChartToolCursorRightFon.XValue then
      begin
        CalcMinus(SeriesLineFon,SeriesKTVFon,ChartToolCursorLeftFon,ChartToolCursorRightFon,CBZeroFon,StrToFloatRegion(EditKFon.Text));
        DrawFonPeak;

        SetSnap(ChartToolCursorLeftFon,ChartToolCursorLeftFon.XValue,GetSnapY(SeriesKTVFon,Round(ChartToolCursorLeftFon.XValue)));
        SetSnap(ChartToolCursorRightFon,ChartToolCursorRightFon.XValue,GetSnapY(SeriesKTVFon,Round(ChartToolCursorRightFon.XValue)));
        CalcLine(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
        SFon:=CalcSFullPeak(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
      end;
      BtnImportClick(Nil);
    end;
    EditKFon.Text := St;
  end
  else
  if ChartToolCursorLeftFon.XValue<ChartToolCursorRightFon.XValue then
  begin
    CalcMinus(SeriesLineFon,SeriesKTVFon,ChartToolCursorLeftFon,ChartToolCursorRightFon,CBZeroFon,StrToFloatRegion(EditKFon.Text));
    DrawFonPeak;

    SetSnap(ChartToolCursorLeftFon,ChartToolCursorLeftFon.XValue,GetSnapY(SeriesKTVFon,Round(ChartToolCursorLeftFon.XValue)));
    SetSnap(ChartToolCursorRightFon,ChartToolCursorRightFon.XValue,GetSnapY(SeriesKTVFon,Round(ChartToolCursorRightFon.XValue)));
    CalcLine(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
    SFon:=CalcSFullPeak(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
  end;
}
end;

procedure TModelW.BtnMinusFonPeakClick(Sender: TObject);
var
  i: integer;
  K: integer;
  St: String;
begin
{
  if AutoCB_UseAuto.Checked then
  begin
    St := EditKFonPeak.Text;
    for i := AutoSE_min.Value to AutoSE_max.Value do
    begin
      BtnResetPeakClick(Nil);

      K := i*AutoSE_A.Value + AutoSE_B.Value;
      EditKFonPeak.Text := IntToStr(K);
      EditMeasComment.Text := EditKPeak.Text;


      if ChartToolCursorLeftFonPeak.XValue<ChartToolCursorRightFonPeak.XValue then
      begin
        CalcMinus(SeriesLineFonPeak,SeriesKTVFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak,CBZeroFonPeak,StrToFloatRegion(EditKFonPeak.Text));

        SetSnap(ChartToolCursorLeftFonPeak,ChartToolCursorLeftFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorLeftFonPeak.XValue)));
        SetSnap(ChartToolCursorRightFonPeak,ChartToolCursorRightFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorRightFonPeak.XValue)));
        CalcLine(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
        SFonPeak:=CalcSFullPeak(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
      end;

      BtnImportClick(Nil);
    end;
    EditKFonPeak.Text := St;
  end
    else
  if ChartToolCursorLeftFonPeak.XValue<ChartToolCursorRightFonPeak.XValue then
  begin
    CalcMinus(SeriesLineFonPeak,SeriesKTVFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak,CBZeroFonPeak,StrToFloatRegion(EditKFonPeak.Text));

    SetSnap(ChartToolCursorLeftFonPeak,ChartToolCursorLeftFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorLeftFonPeak.XValue)));
    SetSnap(ChartToolCursorRightFonPeak,ChartToolCursorRightFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorRightFonPeak.XValue)));
    CalcLine(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
    SFonPeak:=CalcSFullPeak(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
  end;
}
end;

procedure TModelW.BtnMinusPeakClick(Sender: TObject);
var
  i: integer;
  K: integer;
  St: String;
begin
{
  if AutoCB_UseAuto.Checked then
  begin
    St := EditKPeak.Text;
    for i := AutoSE_min.Value to AutoSE_max.Value do
    begin
      BtnResetPeakClick(Nil);

      K := i*AutoSE_A.Value + AutoSE_B.Value;
      EditKPeak.Text := IntToStr(K);
      EditMeasComment.Text := EditKPeak.Text;


      if ChartToolCursorLeftPeak.XValue<ChartToolCursorRightPeak.XValue then
      begin
        CalcMinus(SeriesLinePeak,SeriesKTVPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak,CBZeroPeak,StrToFloatRegion(EditKPeak.Text));
        DrawFonPeak;

        SetSnap(ChartToolCursorLeftPeak,ChartToolCursorLeftPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorLeftPeak.XValue)));
        SetSnap(ChartToolCursorRightPeak,ChartToolCursorRightPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorRightPeak.XValue)));
        CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
        SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
      end;

      BtnImportClick(Nil);
    end;
    EditKPeak.Text := St;
  end
    else
  if ChartToolCursorLeftPeak.XValue<ChartToolCursorRightPeak.XValue then
  begin
    CalcMinus(SeriesLinePeak,SeriesKTVPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak,CBZeroPeak,StrToFloatRegion(EditKPeak.Text));
    DrawFonPeak;

    SetSnap(ChartToolCursorLeftPeak,ChartToolCursorLeftPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorLeftPeak.XValue)));
    SetSnap(ChartToolCursorRightPeak,ChartToolCursorRightPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorRightPeak.XValue)));
    CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
    SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
  end;
}
end;

procedure TModelW.BtnPlusPeakClick(Sender: TObject);
var
  i: integer;
  K: integer;
  St: String;
begin
{
  if AutoCB_UseAuto.Checked then
  begin
    St := EditKPeak.Text;
    for i := AutoSE_min.Value to AutoSE_max.Value do
    begin
      BtnResetPeakClick(Nil);

      K := i*AutoSE_A.Value + AutoSE_B.Value;
      EditKPeak.Text := IntToStr(K);
      EditMeasComment.Text := EditKPeak.Text;


      if ChartToolCursorLeftPeak.XValue<ChartToolCursorRightPeak.XValue then
      begin
        CalcPlus(SeriesLinePeak,SeriesKTVPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak,CBZeroPeak,StrToFloatRegion(EditKPeak.Text));
        DrawFonPeak;

        SetSnap(ChartToolCursorLeftPeak,ChartToolCursorLeftPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorLeftPeak.XValue)));
        SetSnap(ChartToolCursorRightPeak,ChartToolCursorRightPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorRightPeak.XValue)));
        CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
        SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
      end;


      BtnImportClick(Nil);
    end;
    EditKPeak.Text := St;
  end
    else
  if ChartToolCursorLeftPeak.XValue<ChartToolCursorRightPeak.XValue then
  begin
    CalcPlus(SeriesLinePeak,SeriesKTVPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak,CBZeroPeak,StrToFloatRegion(EditKPeak.Text));
    DrawFonPeak;

    SetSnap(ChartToolCursorLeftPeak,ChartToolCursorLeftPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorLeftPeak.XValue)));
    SetSnap(ChartToolCursorRightPeak,ChartToolCursorRightPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorRightPeak.XValue)));
    CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
    SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
  end;
}
end;

procedure TModelW.BtnPlusFonClick(Sender: TObject);
var
  i: integer;
  K: integer;
  St: String;
begin
{
  if AutoCB_UseAuto.Checked then
  begin
    St := EditKFon.Text;
    for i := AutoSE_min.Value to AutoSE_max.Value do
    begin
      BtnResetPeakClick(Nil);

      K := i*AutoSE_A.Value + AutoSE_B.Value;
      EditKFon.Text := IntToStr(K);
      EditMeasComment.Text := EditKPeak.Text;


      if ChartToolCursorLeftFon.XValue<ChartToolCursorRightFon.XValue then
      begin
        CalcPlus(SeriesLineFon,SeriesKTVFon,ChartToolCursorLeftFon,ChartToolCursorRightFon,CBZeroFon,StrToFloatRegion(EditKFon.Text));
        DrawFonPeak;

        SetSnap(ChartToolCursorLeftFon,ChartToolCursorLeftFon.XValue,GetSnapY(SeriesKTVFon,Round(ChartToolCursorLeftFon.XValue)));
        SetSnap(ChartToolCursorRightFon,ChartToolCursorRightFon.XValue,GetSnapY(SeriesKTVFon,Round(ChartToolCursorRightFon.XValue)));
        CalcLine(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
        SFon:=CalcSFullPeak(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
      end;

      BtnImportClick(Nil);
    end;
    EditKFon.Text := St;
  end
    else
  if ChartToolCursorLeftFon.XValue<ChartToolCursorRightFon.XValue then
  begin
    CalcPlus(SeriesLineFon,SeriesKTVFon,ChartToolCursorLeftFon,ChartToolCursorRightFon,CBZeroFon,StrToFloatRegion(EditKFon.Text));
    DrawFonPeak;

    SetSnap(ChartToolCursorLeftFon,ChartToolCursorLeftFon.XValue,GetSnapY(SeriesKTVFon,Round(ChartToolCursorLeftFon.XValue)));
    SetSnap(ChartToolCursorRightFon,ChartToolCursorRightFon.XValue,GetSnapY(SeriesKTVFon,Round(ChartToolCursorRightFon.XValue)));
    CalcLine(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
    SFon:=CalcSFullPeak(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
  end;
}
end;

procedure TModelW.BtnPlusFonPeakClick(Sender: TObject);
var
  i: integer;
  K: integer;
  St: String;
begin
{
  if AutoCB_UseAuto.Checked then
  begin
    St := EditKFonPeak.Text;
    for i := AutoSE_min.Value to AutoSE_max.Value do
    begin
      BtnResetPeakClick(Nil);

      K := i*AutoSE_A.Value + AutoSE_B.Value;
      EditKFonPeak.Text := IntToStr(K);
      EditMeasComment.Text := EditKPeak.Text;


      if ChartToolCursorLeftFonPeak.XValue<ChartToolCursorRightFonPeak.XValue then
      begin
        CalcPlus(SeriesLineFonPeak,SeriesKTVFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak,CBZeroFonPeak,StrToFloatRegion(EditKFonPeak.Text));

        //CalcPlus(SeriesLineFonPeak,SeriesKTVFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak,CBZeroFonPeak,StrToFloatRegion(EditKFonPeak.Text));


        SetSnap(ChartToolCursorLeftFonPeak,ChartToolCursorLeftFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorLeftFonPeak.XValue)));
        SetSnap(ChartToolCursorRightFonPeak,ChartToolCursorRightFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorRightFonPeak.XValue)));
        CalcLine(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
        SFonPeak:=CalcSFullPeak(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
      end;

      BtnImportClick(Nil);
    end;
    EditKFonPeak.Text := St;
  end
    else
  if ChartToolCursorLeftFonPeak.XValue<ChartToolCursorRightFonPeak.XValue then
  begin
    CalcPlus(SeriesLineFonPeak,SeriesKTVFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak,CBZeroFonPeak,StrToFloatRegion(EditKFonPeak.Text));

    //CalcPlus(SeriesLineFonPeak,SeriesKTVFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak,CBZeroFonPeak,StrToFloatRegion(EditKFonPeak.Text));


    SetSnap(ChartToolCursorLeftFonPeak,ChartToolCursorLeftFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorLeftFonPeak.XValue)));
    SetSnap(ChartToolCursorRightFonPeak,ChartToolCursorRightFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorRightFonPeak.XValue)));
    CalcLine(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
    SFonPeak:=CalcSFullPeak(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
  end;
}
end;

procedure TModelW.BtnResetFonClick(Sender: TObject);
begin
  LoadFon;

//  SetSnap(ChartToolCursorLeftFon,ChartToolCursorLeftFon.XValue,GetSnapY(SeriesKTVFon,Round(ChartToolCursorLeftFon.XValue)));
//  SetSnap(ChartToolCursorRightFon,ChartToolCursorRightFon.XValue,GetSnapY(SeriesKTVFon,Round(ChartToolCursorRightFon.XValue)));
//  CalcLine(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
//  SFon:=CalcSFullPeak(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);

  DrawFonPeak;
end;

procedure TModelW.BtnResetFonPeakClick(Sender: TObject);
begin
  LoadFonPeak;

//  SetSnap(ChartToolCursorLeftFonPeak,ChartToolCursorLeftFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorLeftFonPeak.XValue)));
//  SetSnap(ChartToolCursorRightFonPeak,ChartToolCursorRightFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorRightFonPeak.XValue)));
//  CalcLine(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
//  SFonPeak:=CalcSFullPeak(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);

  DrawFonPeak;
end;

procedure TModelW.BtnResetPeakClick(Sender: TObject);
begin
  LoadPeak;

//  SetSnap(ChartToolCursorLeftPeak,ChartToolCursorLeftPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorLeftPeak.XValue)));
//  SetSnap(ChartToolCursorRightPeak,ChartToolCursorRightPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorRightPeak.XValue)));
//  CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
//  SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);

  DrawFonPeak;
end;

function TModelW.GetSnapY(Seria: TChartSeries; x: integer): double;
var
  i: integer;
  y: double;
begin
  y:=-1;

  for i := 0 to Seria.Count-1 do
  begin
    if Seria.XValue[i] = x then
    begin
      y := Seria.YValue[i];
    end;
  end;

  result := y;
end;

procedure TModelW.SetSPeak(Value: double);
begin
  FSPeak := Value;
  EditSPeak.Text:=FloatToStrRegion(RoundToCN(Value,-2));
end;

procedure TModelW.ShrinkPeak;
var
  i          : integer;
  chLeft,
  chRight,
  chCnt,
  chInterval,
  deletedCh  : integer;
  strList    : TStringList;
  index      : integer;
  divLeftCh  : integer;
  divRightCh : integer;
begin
{
  deletedCh:=StrToInt(EditStretchPeak.Text);

  chLeft:=Round(ChartToolCursorLeftPeak.XValue)-1;
  chRight:=Round(ChartToolCursorRightPeak.XValue)-1;

  chCnt:=chRight-chLeft;

  chInterval:=Round(chCnt/deletedCh);

  strList := TStringList.Create;
  for i := 0 to SeriesKTVPeak.Count-1 do
  begin

    index:=strList.Count-1;
    if (index>=chLeft+chInterval) AND (index<=chRight) then
    begin
      //avg:=(SeriesKTVPeak.YValue[i]+SeriesKTVPeak.YValue[i+1])/2;
      //strList.Add(FloatToStrRegion(SeriesKTVPeak.YValue[i])+'_null');
      //strList.Add(FloatToStrRegion(avg)+'_avg');
      if (chLeft+chInterval)<=chRight then
        chLeft:=chLeft+chInterval;
    end
    else
      strList.Add(FloatToStrRegion(SeriesKTVPeak.YValue[i]));
  end;

  divRightCh:=deletedCh div 2;
  divLeftCh:=deletedCh - divRightCh;

  for i := 0 to divLeftCh-1 do strList.Insert(i,'0');
  for i := 0 to divRightCh-1 do strList.Insert(strList.Count-1,'0');
//
  while (strList.Count<300) do strList.Add('0');

  for i := 0 to ChartPeak.SeriesList.Count-1 do
  begin
    ChartPeak.Series[i].Clear;
  end;

  for i := 0 to strList.Count-1 do
  begin
    SeriesKTVPeak.AddXY(i,StrToFloatRegion(strList[i]));
  end;
}
end;

procedure TModelW.StretchPeak;
var
  i          : integer;
  chLeft,
  chRight,
  chCnt,
  chInterval,
  addedCh    : integer;
  strList    : TStringList;
  index      : integer;
  avg        : double;
  divLeftCh  : integer;
  divRightCh : integer;
begin
{
  addedCh:=StrToInt(EditStretchPeak.Text);

  chLeft:=Round(ChartToolCursorLeftPeak.XValue)-1;
  chRight:=Round(ChartToolCursorRightPeak.XValue)-1;

  chCnt:=chRight-chLeft;

  chInterval:=Round(chCnt/addedCh);

  strList := TStringList.Create;
  for i := 0 to SeriesKTVPeak.Count-1 do
  begin
    strList.Add(FloatToStrRegion(SeriesKTVPeak.YValue[i]));
    index:=strList.Count-1;
    if (index>=chLeft+chInterval) AND (index<=chRight) then
    begin
      avg:=(SeriesKTVPeak.YValue[i]+SeriesKTVPeak.YValue[i+1])/2;
      strList.Add(FloatToStrRegion(avg));
      //strList.Add(FloatToStrRegion(avg)+'_avg');
      if (chLeft+chInterval)<chRight then
        chLeft:=chLeft+chInterval;
    end;
  end;

  divRightCh:=addedCh div 2;
  divLeftCh:=addedCh - divRightCh;

  for i := 0 to divLeftCh-1 do strList.Delete(i);
  for i := 0 to divRightCh-1 do strList.Delete(strList.Count-1);

  while (strList.Count<300) do strList.Add('0');

  for i := 0 to ChartPeak.SeriesList.Count-1 do
  begin
    ChartPeak.Series[i].Clear;
  end;

  for i := 0 to strList.Count-1 do
  begin
    SeriesKTVPeak.AddXY(i,StrToFloatRegion(strList[i]));
  end;
}
end;

procedure TModelW.SetSFon(const Value: double);
begin
  FSFon := Value;
  EditSFon.Text:=FloatToStrRegion(RoundToCN(Value,-2));
end;

procedure TModelW.SetSFonPeak(const Value: double);
begin
  FSFonPeak:= Value;
  EditSFonPeak.Text:=FloatToStrRegion(RoundToCN(Value,-2));
end;

{
procedure TModelW.SetSnap(Cursor: TCursorTool; x,y: double);
begin
  Cursor.XValue:=x;
  Cursor.YValue:=y;
  Cursor.Snap:=true;
end;
}
{
procedure TModelW.CalcLine(SeriaLine,SeriaKTV: TLineSeries; SeriesArea: TAreaSeries; CursorLeft,CursorRight: TCursorTool);
const
  cMaxY = 299;
var
  x1,x2 : double;
  y1,y2 : double;
  y     : double;
  k,b   : double;
  i     : integer;
  max   : double;
begin
  k:=0;
  b:=0;

  x1:=CursorLeft.XValue;
  y1:=CursorLeft.YValue;

  x2:=CursorRight.XValue;
  y2:=CursorRight.YValue;

  max:=CalcMax(SeriaKTV);

  if (x2-x1)<>0 then
  begin
    k:=(y2-y1)/(x2-x1);
    b:=y1-(x1*((y2-y1)/(x2-x1)));
  end;

  SeriaLine.Clear;

  for i := 0 to cMaxY do
  begin
    y:=k*i+b;

    if (y>=0) AND (y<max) then
      SeriaLine.AddXY(i,y)
    else
      SeriaLine.AddNullXY(i,y)
  end;

//  SFull:=CalcSPeak(SeriaLine,SeriaKTV,SeriesArea,CursorLeft,CursorRight);

end;
}
function TModelW.CalcMax(Seria: TChartSeries): double;
var
  i       : integer;
  max     : double;
  value   : double;
begin
  max:=0;
  value:=0;

  for i:=0  to Seria.Count-1 do
  begin
    value:=Seria.YValue[i];

    if value > max then max := value;
  end;
  result:=max;
end;

{
procedure TModelW.CalcMinus(SeriaLine,SeriaKTV: TLineSeries; CursorLeft,CursorRight: TCursorTool; CheckBox: TCheckBox;k: double);
const
  cCompare = 0.5;
var
  i               : integer;
  valY            : double;
  valX            : double;
  borderTop       : double;
  borderLeft      : double;
  borderRight     : double;
  p               : double; // перенос
//  fractionalPart  : double; // дробная часть
  quotient        : double; // частное
begin
  borderLeft:=CursorLeft.XValue;
  borderRight:=CursorRight.XValue;

  p:=0;

  for i := 0 to SeriaKTV.YValues.Count-1 do
  begin
    if CheckBox.Checked then
      borderTop:=0
    else
      borderTop:=SeriaLine.YValue[i];

    valY:=SeriaKTV.YValue[i];
    valX:=SeriaKTV.XValue[i];

    if (valY >= borderTop) AND (valX >= borderLeft) AND (valX <= borderRight) then
    begin
      quotient:=(valY/k)+p;

      p:=quotient - Round(quotient);
      valY:=Round(quotient);

      SeriaKTV.YValue[i]:=valY;
    end;
  end;

end;
}
{
procedure TModelW.CalcPlus(SeriaLine,SeriaKTV: TLineSeries; CursorLeft,CursorRight: TCursorTool; CheckBox: TCheckBox;k: double);
var
  i           : integer;
  valY        : double;
  valX        : double;
  borderTop   : double;
  borderLeft  : double;
  borderRight : double;
begin
  borderLeft:=CursorLeft.XValue;
  borderRight:=CursorRight.XValue;

  for i := 0 to SeriaKTV.YValues.Count-1 do
  begin
    if CheckBox.Checked then
      borderTop:=0
    else
      borderTop:=SeriaLine.YValue[i];

    valY:=SeriaKTV.YValue[i];
    valX:=SeriaKTV.XValue[i];

    if (valY >= borderTop) AND (valX >= borderLeft) AND (valX <= borderRight) then
    begin
      SeriaKTV.YValue[i]:=borderTop + (valY-borderTop)*k;
    end;
  end;

end;
}
{
function TModelW.CalcSFullPeak(SeriaLine,SeriaKTV: TLineSeries; SeriesArea: TAreaSeries; CursorLeft,CursorRight: TCursorTool): double;
var
  i     : integer;
  sPeak : double;
begin
  sPeak:=0;

  SeriesArea.Clear;

  for i := 0 to SeriaKTV.XValues.Count-1 do
  begin
    if (i>=CursorLeft.XValue) AND (i<=CursorRight.XValue) then
    begin
      //if (SeriaKTV.YValue[i]>SeriaLine.YValue[i]) then


      //sPeak:=sPeak+SeriaKTV.YValue[i]-SeriaLine.YValue[i];
      sPeak:=sPeak+SeriaKTV.YValue[i];
      SeriesArea.AddXY(i,SeriaKTV.YValue[i]);
    end
    else
    begin
      SeriesArea.AddNullXY(i,SeriaKTV.YValue[i]);
    end;
  end;

  Result:=sPeak;
end;
}
//function TModelW.CalcSTopPeak(SeriaLine, SeriaKTV: TLineSeries; SeriesArea: TAreaSeries; CursorLeft, CursorRight: TCursorTool): double;
//var
//  i     : integer;
//  sPeak : double;
//begin
//  sPeak:=0;
//
//  SeriesArea.Clear;
//
//  for i := 0 to SeriaKTV.XValues.Count-1 do
//  begin
//    if (i>=CursorLeft.XValue) AND (i<=CursorRight.XValue) then
//    begin
//      if (SeriaKTV.YValue[i]>SeriaLine.YValue[i]) then sPeak:=sPeak+SeriaKTV.YValue[i]-SeriaLine.YValue[i];
//
//      SeriesArea.AddXY(i,SeriaKTV.YValue[i]);
//    end
//    else
//    begin
//      SeriesArea.AddNullXY(i,SeriaKTV.YValue[i]);
//    end;
//  end;
//
//  Result:=sPeak;
//end;

procedure TModelW.BtnImportClick(Sender: TObject);
begin
  if TLDDataModule.IsDBConnected then
  begin
    if CBoxDos.ItemIndex >= 0 then
    begin
      if Assigned(MainForm.Dosimeter) then FreeAndNil(MainForm.Dosimeter);

      MainForm.Dosimeter:=TDosimeter.Create(CBoxDos.Items[CBoxDos.ItemIndex]);
      MainForm.HideDetectorsPanel(MainForm.GetDetCnt(MainForm.Dosimeter.DosType));
      MainForm.Dosimeter.OnChangeFullNumber(Self);
      MainForm.Dosimeter.OnChangeDose(Self);
      MainForm.Dosimeter.OnChangeErr(Self);
      MainForm.Dosimeter.OnChangeMeasTime(Self);
      MainForm.Dosimeter.OnChangeStatus(Self);
      MainForm.Dosimeter.OnChangeKS(Self);
      MainForm.Dosimeter.OnChangeMeasComment(Self);

      if (MainForm.Dosimeter.MeasurementID = 0) then
      try
        MainForm.CreateDosimeterData; // добавление новой (чистой) записи в таблицу результатов измерений
      except
        on E: exception do
          MessageDlg(E.Message,mtError, [mbOK], 0);
      end;

      try
        TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).State:=stDetMeasFinished;
        SaveDetectorData;
        MainForm.Dosimeter.MeasTime:=Now;
        MainForm.Dosimeter.Dose_Hp_10g:=0;
        MainForm.Dosimeter.Error:=cEmptyData;
        MainForm.Dosimeter.Validity:=stDosMeasAccepted;
        MainForm.Dosimeter.MeasComment:=EditMeasComment.Text;
        MainForm.SaveDosimeterData;
        MainForm.UpdateDosimeterResStatusAndMeasTime;
        MainForm.UpdateAllGridPages;
      except
        on E: exception do
        begin
          MessageDlg(Format('%s - %s',[rsErrSave,E.Message]),mtError,[mbOK],0);
        end;
      end;
    end;
  end;
end;

procedure TModelW.BtnSaveCalcFonClick(Sender: TObject);
begin
  SaveToFile(TLineSeries(CalcForm.SeriesFon));
end;

procedure TModelW.BtnLoadFromFileClick(Sender: TObject);
const
  cExt='.txt';
var
  f           : TextFile;
  fileName    : String;
  s, s2       : String;
  detName     : String;
  detNameTxt  : String;
  comment     : String;
begin
  if OpenDialogTxt.Execute then
  begin

    fileName:=OpenDialogTxt.FileName;

    if FileExists(fileName) then
    begin
      AssignFile(f, FileName);
      Reset(f);

      while not eof(f) do
      begin
        readln(f,s);
        //
        s2:=copy(s,1,pos(';', s)-1);
        detName:=s2;
        delete(s, 1, pos(';', s));
        //
        s2:=copy(s,1,pos(';', s)-1);
        detNameTxt:=s2+cExt;
        delete(s, 1, pos(';', s));
        //
        comment:=s;


        LoadChart(SeriesKTVPeak,ExtractFilePath(fileName)+detNameTxt);
        EditChartPeak.Text:=ExtractFilePath(fileName)+detNameTxt;
//        SetSnap(ChartToolCursorLeftPeak,cDefaultLeft,GetSnapY(SeriesKTVPeak,cDefaultLeft));        // отключить если мешает
//        SetSnap(ChartToolCursorRightPeak,cDefaultRight,GetSnapY(SeriesKTVPeak,cDefaultRight));     //
//        CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
//        SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);

        DrawFonPeak;

        CBoxDos.ItemIndex := CBoxDos.Items.IndexOf(detName);

        EditMeasComment.Text:=comment;

        BtnImportClick(Self);

      end;

      CloseFile(f);
    end;
  end;
end;

procedure TModelW.Button2Click(Sender: TObject);
var
  i: integer;
  K: integer;
  St: String;
begin
  if AutoCB_UseAuto.Checked then
  begin
    St := EditStretchPeak.Text;
    for i := AutoSE_min.Value to AutoSE_max.Value do
    begin
      K := 2;//i*AutoSE_A.Value + AutoSE_B.Value;
      EditStretchPeak.Text := IntToStr(K);
      EditMeasComment.Text := IntToStr(i);

      StretchPeak;

//      SetSnap(ChartToolCursorLeftPeak,ChartToolCursorLeftPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorLeftPeak.XValue)));
//      SetSnap(ChartToolCursorRightPeak,ChartToolCursorRightPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorRightPeak.XValue)));
//      CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);

//      SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);

      DrawFonPeak;

      BtnImportClick(Nil);
    end;
    EditStretchPeak.Text := St;
  end
    else
  begin
    StretchPeak;

//    SetSnap(ChartToolCursorLeftPeak,ChartToolCursorLeftPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorLeftPeak.XValue)));
//    SetSnap(ChartToolCursorRightPeak,ChartToolCursorRightPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorRightPeak.XValue)));
//    CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);

//    SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);

    DrawFonPeak;
  end;
end;

procedure TModelW.Button3Click(Sender: TObject);
var
  i: integer;
  K: integer;
  St: String;
begin
  if AutoCB_UseAuto.Checked then
  begin
    St := EditStretchPeak.Text;
    for i := AutoSE_min.Value to AutoSE_max.Value do
    begin
//      BtnResetPeakClick(Nil);

      K := 2;//K := i*AutoSE_A.Value + AutoSE_B.Value;
      EditStretchPeak.Text := IntToStr(K);
      EditMeasComment.Text := IntToStr(i);


      ShrinkPeak;

//      SetSnap(ChartToolCursorLeftPeak,ChartToolCursorLeftPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorLeftPeak.XValue)));
//      SetSnap(ChartToolCursorRightPeak,ChartToolCursorRightPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorRightPeak.XValue)));
//      CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
//      SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);

      DrawFonPeak;

      BtnImportClick(Nil);
    end;
    EditStretchPeak.Text := St;
  end
    else
  begin
    ShrinkPeak;

//    SetSnap(ChartToolCursorLeftPeak,ChartToolCursorLeftPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorLeftPeak.XValue)));
//    SetSnap(ChartToolCursorRightPeak,ChartToolCursorRightPeak.XValue,GetSnapY(SeriesKTVPeak,Round(ChartToolCursorRightPeak.XValue)));
//    CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
//    SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);

    DrawFonPeak;
  end;
end;

procedure TModelW.BtnDigitFonClick(Sender: TObject);
var
  i     : integer;
  valX  : double;
  valY  : double;
//  quotient: double;
//  p: double;
//  fractionalPart: double;
begin
  for i := 0 to SeriesKTVFon.Count-1 do
  begin
//    if CheckBox.Checked then
//      borderTop:=0
//    else
//      borderTop:=SeriaLine.YValue[i];

    valY:=SeriesKTVFon.YValue[i];
    valX:=SeriesKTVFon.XValue[i];

    if (valY >= 0) AND (valX >= 0) AND (valX <= 299) then
    begin
      //quotient:=(valY+p);
      //p:=0;
      //fractionalPart:=Frac(quotient);
      valY:=Round(valY);

      SeriesKTVFon.YValue[i]:=valY;

      //if fractionalPart > 0.5 then
      //  p:=p-(1-fractionalPart)
      //else
      //  p:=p+fractionalPart;

    end;
  end;
end;

procedure TModelW.SaveDetectorData;
var
  i: integer;
begin
  for i := 0 to SeriesLinePeak.Count-1 do
  begin
    if TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).Ktv='' then
      TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).Ktv:=FloatToStrRegion(Round(SeriesKTVFonPeak.YValue[i]))
    else
      TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).Ktv:=TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).Ktv+','+FloatToStrRegion(Round(SeriesKTVFonPeak.YValue[i]));
  end;

  TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
  TLDDataModule.ADOQuery.SQL.Add('INSERT INTO tlddetectorres('+cFieldDosMeasID+','
                                                              +cFieldDetType+','
                                                              +cFieldDose+','
                                                              +cFieldDetPosition+','
                                                              +cFieldKTV+','
                                                              +cFieldTempProfile+','
                                                              +cFieldCalcFon+','
                                                              +cFieldCalcGaus+','
                                                              +cFieldCoefficient+','
                                                              +cFieldMeasureTime+','
                                                              +cFieldAutoProc+','
                                                              +cFieldDetStatus+
                                                            ') '+
                                                     'VALUES('+IntToStr(MainForm.Dosimeter.MeasurementID)+','
                                                          +#39+TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).DetType+#39+','
                                                              +'0'+','
                                                              +IntToStr(cDetPos1)+','
                                                     +#39+#123+TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).Ktv+#125+#39+','
                                                     +#39+#123+TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).Tmp+#125+#39+','
                                                     +#39+#123+TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).Fon+#125+#39+','
                                                     +#39+#123+TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).Gaus+#125+#39+','
                                                          +#39+'-'+#39+','
                                                          +#39+DateTimeToStr(Now)+#39+','
                                                          //+#39+aProcessingCurve+#39+','
                                                          +#39+'true'+#39+','
                                                              +IntToStr(GetDetState(TDetector(MainForm.Dosimeter.DetectorsList[MainForm.Dosimeter.DetectorsCnt]).State))+
                                                            ')');
  TLDDataModule.ADOQuery.ExecSQL;

end;

procedure TModelW.BtnSaveToFileFonClick(Sender: TObject);
begin
  SaveToFile(SeriesKTVFon);
end;

procedure TModelW.BtnSaveToFileFonPeakClick(Sender: TObject);
begin
  SaveToFile(SeriesKTVFonPeak);
end;

procedure TModelW.BtnSaveToFilePeakClick(Sender: TObject);
begin
  SaveToFile(SeriesKTVPeak);
end;

procedure TModelW.SaveToFile(Seria: TLineSeries);
  function GetStrList(Seria: TLineSeries): TStringList;
  var
    i         : integer;
    strList   : TStringList;
  begin
    strList := TStringList.Create;
    for i := 0 to Seria.Count-1 do
    begin
      strList.Add(IntToStr(i+1)+' '+FloatToStrRegion(Seria.YValue[i])+' ');
      result := strList;
    end;

    result := strList;
  end;
begin
  if SaveTextFileChart.Execute then
  begin
    if FileExists(SaveTextFileChart.FileName) then
    begin
      if MessageDlg(Format('%s?',[rsMsgFileAlreadyExists]),mtConfirmation,[mbYes,mbNo], 0) = mrYes then
         GetStrList(Seria).SaveToFile(SaveTextFileChart.FileName)
      else
        SaveToFile(Seria);
    end
    else
      GetStrList(Seria).SaveToFile(SaveTextFileChart.FileName);
  end;
end;

{
procedure TModelW.ChartToolCursorLeftFonPeakSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
begin
  if ChartToolCursorLeftFonPeak.XValue<ChartToolCursorRightFonPeak.XValue then
  begin
    CalcLine(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
    SFonPeak:=CalcSFullPeak(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
  end;
end;

procedure TModelW.ChartToolCursorLeftFonSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
begin
  if ChartToolCursorLeftFon.XValue<ChartToolCursorRightFon.XValue then
  begin
    CalcLine(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
    SFon:=CalcSFullPeak(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
  end;
end;

procedure TModelW.ChartToolCursorRightFonPeakSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
begin
  if ChartToolCursorRightFonPeak.XValue>ChartToolCursorLeftFonPeak.XValue then
  begin
    CalcLine(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
    SFonPeak:=CalcSFullPeak(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
  end;
end;

procedure TModelW.ChartToolCursorRightFonSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
begin
  if ChartToolCursorRightFon.XValue>ChartToolCursorLeftFon.XValue then
  begin
    CalcLine(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
    SFon:=CalcSFullPeak(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
  end;
end;

procedure TModelW.ChartToolCursorLeftPeakSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
begin
  if ChartToolCursorLeftPeak.XValue<ChartToolCursorRightPeak.XValue then
  begin
    CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
    SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
  end;
end;

procedure TModelW.ChartToolCursorRightPeakSnapChange(Sender: TCursorTool; x, y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
begin
  if ChartToolCursorRightPeak.XValue>ChartToolCursorLeftPeak.XValue then
  begin
    CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
    SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
  end;
end;
}

procedure TModelW.DrawFonPeak;
var
  i: integer;
begin
  SeriesKTVFonPeak.Clear;

  for i := 0 to 299 do
  begin
    SeriesKTVFonPeak.AddXY(i,SeriesKTVFon.YValue[i]+SeriesKTVPeak.YValue[i]);
  end;

//  SetSnap(ChartToolCursorLeftFonPeak,ChartToolCursorLeftFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorLeftFonPeak.XValue)));
//  SetSnap(ChartToolCursorRightFonPeak,ChartToolCursorRightFonPeak.XValue,GetSnapY(SeriesKTVFonPeak,Round(ChartToolCursorRightFonPeak.XValue)));
//  CalcLine(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
//  SFonPeak:=CalcSFullPeak(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);

end;

procedure TModelW.FormShow(Sender: TObject);
begin
  EditKPeak.Text:=FloatToStrRegion(cDefaultK);
  EditKFon.Text:=FloatToStrRegion(cDefaultK);
  EditKFonPeak.Text:=FloatToStrRegion(cDefaultK);
  EditStretchPeak.Text:=FloatToStrRegion(cDefaultStretchCh);

  LoadFiles;

  // пик
//  SetSnap(ChartToolCursorLeftPeak,cDefaultLeft,GetSnapY(SeriesKTVPeak,cDefaultLeft));
//  SetSnap(ChartToolCursorRightPeak,cDefaultRight,GetSnapY(SeriesKTVPeak,cDefaultRight));
//  CalcLine(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
//  SPeak:=CalcSFullPeak(SeriesLinePeak,SeriesKTVPeak,SeriesAreaPeak,ChartToolCursorLeftPeak,ChartToolCursorRightPeak);
  // фон
//  SetSnap(ChartToolCursorLeftFon,cDefaultLeft,GetSnapY(SeriesKTVFon,cDefaultLeft));
//  SetSnap(ChartToolCursorRightFon,cDefaultRight,GetSnapY(SeriesKTVFon,cDefaultRight));
//  CalcLine(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
//  SFon:=CalcSFullPeak(SeriesLineFon,SeriesKTVFon,SeriesAreaFon,ChartToolCursorLeftFon,ChartToolCursorRightFon);
  // фон + пик
//  SetSnap(ChartToolCursorLeftFonPeak,cDefaultLeft,GetSnapY(SeriesKTVFonPeak,cDefaultLeft));
//  SetSnap(ChartToolCursorRightFonPeak,cDefaultRight,GetSnapY(SeriesKTVFonPeak,cDefaultRight));
//  CalcLine(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);
//  SFonPeak:=CalcSFullPeak(SeriesLineFonPeak,SeriesKTVFonPeak,SeriesAreaFonPeak,ChartToolCursorLeftFonPeak,ChartToolCursorRightFonPeak);

  DrawFonPeak;

  LoadDos;
end;

procedure TModelW.LoadChart(Seria: TLineSeries; FileName: String);
var
  f       : TextFile;
  s, s2   : String;
  ktv     : integer;
  cnt     : integer;
begin

  if FileExists(FileName) then
  begin
    cnt:=0;
    Seria.Clear;

    AssignFile(f, FileName);
    Reset(f);

    while not eof(f) do
    begin
      readln(f,s);
      // канал
      s2:=copy(s,1,pos(' ', s)-1);

      delete(s, 1, pos(' ', s));
      // ктв
      s2:=copy(s,1,pos(' ', s)-1);
      ktv:=StrToInt(s2);
      delete(s, 1, pos(' ', s));
      // температура
      //tmp:=Round(StrToFloatRegion(s)*10);

      Seria.AddXY(cnt,ktv);

      inc(cnt);

    end;

    CloseFile(f);
  end;

end;

procedure TModelW.LoadDos;
var
  i : integer;
begin
  if TLDDataModule.IsDBConnected then
  begin
    CBoxDos.ItemIndex:=-1;

    ADOQueryModel.Active:=False;
    ADOQueryModel.SQL.Clear;
    ADOQueryModel.SQL.Add('SELECT CASE postfix WHEN '+#39'-'+#39+' THEN CAST(dosimeterid AS TEXT) ELSE CAST (dosimeterid AS TEXT) || postfix END AS fulldosid FROM tlddosimeterid');
    ADOQueryModel.Active:=True;

    CBoxDos.Items.Clear;
    for i := 1 to ADOQueryModel.RecordCount do
    begin
      CBoxDos.Items.Add(ADOQueryModel.FieldValues[cFullDosID]);
      if i <> ADOQueryModel.RecordCount then ADOQueryModel.Next;
    end;
  end;
end;

procedure TModelW.LoadFiles;
begin
  // загрузка пика
  LoadPeak;
  // загрузка фона
  LoadFon;
  // загрузка фона
  LoadFonPeak;
end;

procedure TModelW.LoadPeak;
const
  cModel              = 'Model'+PathDelim;
  cFilePeak           = 'Peak.txt';
var
  path      : String;
  fullPath  : String;
begin
  // загрузка пика
  path:=extractfilepath(Application.ExeName)+cModel;
  //fullPath:=extractfilepath(Application.ExeName)+cModel+cFilePeak;
  if EditChartPeak.Text = '' then fullPath:=extractfilepath(Application.ExeName)+cModel+cFilePeak
    else fullPath:=EditChartPeak.Text;
  OpenDialogChart.InitialDir:=path;
  EditChartPeak.Text:=fullPath;

  LoadChart(SeriesKTVPeak,fullPath);

end;

procedure TModelW.MenuFileDefaultSizeClick(Sender: TObject);
const
  cDefaultHeight = 318;
begin
  PanelPeak.Height:=cDefaultHeight;
  PanelFon.Height:=cDefaultHeight;
  PanelFonPeak.Height:=cDefaultHeight;
end;

procedure TModelW.LoadFon;
const
  cModel              = 'Model\';
  cFileFon            = 'Fon.txt';
var
  path      : String;
  fullPath  : String;
begin
  // загрузка фона
  path:=extractfilepath(Application.ExeName)+cModel;
  //fullPath:=extractfilepath(Application.ExeName)+cModel+cFileFon;
  if EditChartFon.Text = '' then fullPath:=extractfilepath(Application.ExeName)+cModel+cFileFon
    else fullPath:=EditChartFon.Text;
  OpenDialogChart.InitialDir:=path;
  EditChartFon.Text:=fullPath;

  LoadChart(SeriesKTVFon,fullPath);
end;

procedure TModelW.LoadFonPeak;
const
  cModel              = 'Model'+PathDelim;
  cFileFonPeak        = 'FonPeak.txt';
var
  path      : String;
  fullPath  : String;
begin
  // загрузка фон + пик
  path:=extractfilepath(Application.ExeName)+cModel;
//  fullPath:=extractfilepath(Application.ExeName)+cModel+cFileFonPeak;
  if EditChartFonPeak.Text = '' then fullPath:=extractfilepath(Application.ExeName)+cModel+cFileFonPeak
    else fullPath:=EditChartFonPeak.Text;
  OpenDialogChart.InitialDir:=path;
  EditChartFonPeak.Text:=fullPath;

  LoadChart(SeriesKTVFonPeak,fullPath);
end;

procedure TModelW.LoadGrid(Grid: TStringGrid;FileName: String; Separator: String);
var
  f       : TextFile;
  s1, s2  : String;
  i, j    : integer;
begin
  i:=0;

  AssignFile(f, FileName);
  Reset(f);
  while not eof(f) do
  begin
    readln(f,s1);

    i:=i+1;
    j:=0;

    while pos(Separator, s1)<>0 do
    begin
      s2 := copy(s1,1,pos(Separator, s1)-1);
      j := j + 1;
      delete (s1, 1, pos(Separator, s1));
      Grid.Cells[j-1, i-1] := s2;
    end;

    if pos(Separator, s1)=0 then
    begin
      j := j + 1;
      Grid.Cells[j-1, i-1] := s1;
    end;

    Grid.ColCount := j;
    Grid.RowCount := i;

  end;

  CloseFile(f);
end;

procedure TModelW.StringGridPeakDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  cAddition = 4;
var
  i,
  j,
  temp,
  max   : integer;
  value : String;
  str   : String;
begin
  for i := 0 to StringGridPeak.colcount - 1 do
  begin
    max := 0;

    for j := 0 to StringGridPeak.rowcount - 1 do
    begin
      // проверка на пустую строку
      value:=StringGridPeak.Cells[i,1];
      value:=StringReplace(value, '"', '', [rfReplaceAll]);
      value:=StringReplace(value, #39, '', [rfReplaceAll]);
      value:=StringReplace(value, '-', '', [rfReplaceAll]);
      str:=str+value;

      // для расчета автоширины столбцов
      temp := StringGridPeak.Canvas.textWidth(StringGridPeak.cells[i, j]);

      if temp > max then max := temp;
    end;

    StringGridPeak.colWidths[i] := max + StringGridPeak.gridLineWidth + cAddition;
  end;
end;

end.
