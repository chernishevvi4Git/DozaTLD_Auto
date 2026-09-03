unit uReportForm;

interface

uses
//  Messages, uLog,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DB, SQLDB, Buttons, StdCtrls, ComCtrls,
  uLanguages,
  uSeparator,
//  uDataModule,
  DateTimePicker;
// IBX.IBCustomDataSet, IBX.IBQuery, Data.Win.ADODB, frxClass, frxDBSet, frxExportRTF, frxExportPDF, frxExportCSV,frxExportBaseDialog,

type

  { TRW }

  TRW = class(TForm)
//    ReportfrxReport: TfrxReport;
    ReportDataSource: TDataSource;
//    ReportfrxDBDataset: TfrxDBDataset;
    ReportLabel: TLabel;
    DatePickerFrom: TDateTimePicker;
    TimePickerFrom: TDateTimePicker;
    DatePickerTo: TDateTimePicker;
    TimePickerTo: TDateTimePicker;
    DateFromGroupBox: TGroupBox;
    DateByGroupBox: TGroupBox;
    IntervalComboBox: TComboBox;
    IntervalGroupBox: TGroupBox;
    SpeedButtonBuildRpt: TSpeedButton;
//    frxPDFExport1: TfrxPDFExport;
//    frxCSVExport1: TfrxCSVExport;
//    frxRTFExport1: TfrxRTFExport;
    ADOQueryReport: TSQLQuery;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonBuildRptClick(Sender: TObject);
    procedure IntervalComboBoxChange(Sender: TObject);
    procedure ReportfrxReportPreview(Sender: TObject);
  private
    ReportInterval: String;
    { Private declarations }
  public
    procedure BuildReport;
    { Public declarations }
  end;

var
  RW: TRW;
implementation
uses
  uConst,
  uMainForm;

{$R *.dfm}

procedure TRW.BuildReport;
{
var
  lblReport,
  lblTimePeriod,
  lblPeriodFrom,
  lblPeriodTo,
  titleMeasTime,
  titleDosimeterID,
  titleDoseTitle,
  titleStatus,
  lblMeasStatus,
  lblMeasComment,
  lblOrgVal,
  lblDepVal,
  lblPartVal,
  lblTypeVal,
  lblStatusVal,
  lblPersNumberVal,
  lblIDKVal,
  lblPeriodFromVal,
  lblPeriodToVal,
  lblSummary,
  lblDate           : TfrMemoView;
}
begin
{
  try

    lblReport := TfrxMemoView(ReportfrxReport.FindObject('TitleMemo'));
    if lblReport <> nil then
      lblReport.Memo.Text := AnsiUpperCase(rsRptTitle);

    lblTimePeriod := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterMeasTime'));
    if lblTimePeriod <> nil then
      lblTimePeriod.Memo.Text := rsFltMeasTime;

    lblPeriodFrom := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterMeasTimeFrom'));
    if lblPeriodFrom <> nil then
      lblPeriodFrom.Memo.Text := Format('%s:',[rsFltMeasTimeFrom]);

    lblPeriodTo := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterMeasTimeTo'));
    if lblPeriodTo <> nil then
      lblPeriodTo.Memo.Text := Format('%s:',[rsFltMeasTimeTo]);

    lblMeasStatus := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterMeasStatus'));
    if lblMeasStatus <> nil then
      lblMeasStatus.Memo.Text := Format('%s - %s',[rsFltMeasStatus, MainForm.CBoxProcessResult.Text]);

    lblMeasComment := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterMeasComment'));
    if lblMeasComment <> nil then
      lblMeasComment.Memo.Text := Format('%s - %s',[rsFltMeasComment, MainForm.CBoxProcessComment.Text]);

    lblOrgVal := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterOrg'));
    if lblOrgVal <> nil then
      lblOrgVal.Memo.Text := Format('%s - %s',[rsFltOrg,MainForm.CBoxProcessOrgName.Text]);

    lblDepVal := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterDep'));
    if lblDepVal <> nil then
      lblDepVal.Memo.Text := Format('%s - %s',[rsFltDep,MainForm.CBoxProcessDep.Text]);

    lblPartVal := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterPart'));
    if lblPartVal <> nil then
      lblPartVal.Memo.Text := Format('%s - %s',[rsFltPart,MainForm.CBoxProcessDosPart.Text]);

    lblTypeVal := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterType'));
    if lblTypeVal <> nil then
      lblTypeVal.Memo.Text := Format('%s - %s',[rsFltDosType,MainForm.CBoxProcessDosType.Text]);

    lblStatusVal := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterStatus'));
    if lblStatusVal <> nil then
      lblStatusVal.Memo.Text := Format('%s - %s',[rsFltDosStatus,MainForm.CBoxProcessStatus.Text]);

    lblTypeVal := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterDevID'));
    if lblTypeVal <> nil then
      lblTypeVal.Memo.Text := Format('%s - %s',['Номер установки',MainForm.CBoxProcessDeviceID.Text]);

    lblPersNumberVal := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterPersNumber'));
    if lblPersNumberVal <> nil then
      lblPersNumberVal.Memo.Text := Format('%s - %s',[rsFltPersNumber,MainForm.CBoxProcessPersNumber.Text]);

    lblIDKVal := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterIDK'));
    if lblIDKVal <> nil then
      lblIDKVal.Memo.Text := Format('%s - %s',[rsFltIDK,MainForm.CBoxProcessIDK.Text]);

    lblPeriodFromVal := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterMeasTimeFromVal'));
    if lblPeriodFromVal <> nil then
      if MainForm.SpBtnProcessDropDateFrom.Visible then
        lblPeriodFromVal.Memo.Text := Format('%s',[DateTimeToStr(MainForm.DateTimePickerProcessFrom.DateTime)])
      else
        lblPeriodFromVal.Memo.Text := '';

    lblPeriodToVal := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoFilterMeasTimeToVal'));
    if lblPeriodToVal <> nil then
      if MainForm.SpBtnProcessDropDateTo.Visible then
        lblPeriodToVal.Memo.Text := Format('%s',[DateTimeToStr(MainForm.DateTimePickerProcessTo.DateTime)])
      else
        lblPeriodToVal.Memo.Text := '';

    titleMeasTime := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoMeasTime'));
    if titleMeasTime <> nil then
      titleMeasTime.Memo.Text := rsTitleMeasTime;

    titleDosimeterID := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoDosID'));
    if titleDosimeterID <> nil then
      titleDosimeterID.Memo.Text := rsNumber;

    titleDosimeterID := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoDosType'));
    if titleDosimeterID <> nil then
      titleDosimeterID.Memo.Text := rsType;

    titleDoseTitle := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoDose'));
    if titleDoseTitle <> nil then
      titleDoseTitle.Memo.Text := Format('%s, %s',[rsDosDose,rsUntmSv]);

    titleStatus := TfrxMemoView(ReportfrxReport.FindObject('TitleMemoStatus'));
    if titleStatus <> nil then
      titleStatus.Memo.Text := rsDosMeasStatus;

    lblDate := TfrxMemoView(ReportfrxReport.FindObject('DateLabelMemo'));
    if lblDate <> nil then
      lblDate.Memo.Text := rsDateLabelMemo;

    lblSummary := TfrxMemoView(ReportfrxReport.FindObject('SummaryMemo'));
    if lblSummary <> nil then
      lblSummary.Memo.Text := Format(' %s - %d',[rsAllMeasures,MainForm.MemTableEhMeasList.RecordCount]);

    ReportfrxReport.ShowReport(True);

  except
    on E : Exception do
    begin
      WriteLog(rsRptError);
      WriteLog(E.Message);
    end
  end;
}
end;

procedure TRW.FormCreate(Sender: TObject);
begin
{
  ReportfrxReport.EngineOptions.ConvertNulls:=False;                // ЗАПРЕЩЕНИЕ ПРЕОБРАЗОВАНИЯ NULL В НУЛИ ОТЧЕТЕ!!!
  IntervalComboBox.Items[0]:=rsComboBox1Hour;
  IntervalComboBox.Items[1]:=rsComboBox1Day;
  IntervalComboBox.ItemIndex:=0;
  IntervalComboBoxChange(Self);                                     // что-бы при старте инициализировалась переменная Reportinterval
  DatePickerFrom.Date:=Now;                                       // устанавливаем первоначальные значения интервалов
  TimePickerFrom.Time:=StrToTime('00:00:00');                     // с 00:00 часов текущего дня
  DatePickerTo.Date:=Now+StrToDateTimeRegion('31.12.1899 00:00:00');
  TimePickerTo.Time:=StrToTime('00:00:00');                       //
}
end;


procedure TRW.IntervalComboBoxChange(Sender: TObject);
begin
  case IntervalComboBox.ItemIndex of
    0: ReportInterval:='30.12.1899 01:00:00';       // 1 час
    1: ReportInterval:='31.12.1899 00:00:00';       // 1 день
  end;
end;

procedure TRW.ReportfrxReportPreview(Sender: TObject);
begin
////Parse parameter
// String parameter = (String)Report.GetParameterValue("Parameter");
// String[] arr = parameter.Split(',');
//
// //Number of text obj that is header
// int step = 10;
//
// foreach (String item in arr)
// {
// ReportPage newPage = new ReportPage();
// newPage.AssignAll(Page1);
// Report.Pages.Add(newPage);
// newPage.CreateUniqueName();
// foreach (object obj in newPage.AllObjects)
// {
// if (obj is Base)
// {
// (obj as Base).CreateUniqueName();
// }
// }
// TextObject txt = Report.FindObject("Text"+ step.ToString()) as TextObject;
// switch (item)
// {
// case "1":
// txt.Text = "Header 1";
// break;
// case "2":
// txt.Text = "Header 2";
// break;
// case "3":
// txt.Text = "Header 3";
// break;
// }
// step = step + 9;
// }
// Report.Pages.Remove(Page1);
end;

procedure TRW.SpeedButtonBuildRptClick(Sender: TObject);
begin
  BuildReport;
end;

end.
