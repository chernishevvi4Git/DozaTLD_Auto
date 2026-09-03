unit uFinishMF;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls;
// Vcl.Imaging.pngimage,

type
  TFinishMeasureW = class(TForm)
    PanelClient: TPanel;
    LblDosType: TLabel;
    PanelBottom: TPanel;
    BtnAccept: TButton;
    BtnCancel: TButton;
    PanelTop: TPanel;
    PageControlDosResults: TPageControl;
    TabSheetMeas: TTabSheet;
    PanelPageMeas: TPanel;
    LblDosDose: TLabel;
    LblKS: TLabel;
    LblComment: TLabel;
    LblDosDepartment: TLabel;
    LblDosMeasTime: TLabel;
    LblDosOrg: TLabel;
    LblDosPersNumber: TLabel;
    LblFormula: TLabel;
    LblKDos: TLabel;
    LblVerificationDate: TLabel;
    EditDose: TEdit;
    TabSheetDetectors: TTabSheet;
    PanelDetectors: TPanel;
    PanelD1: TPanel;
    LblDoseD1: TLabel;
    LblErrD1: TLabel;
    LblStatusD1: TLabel;
    LblTypeD1: TLabel;
    LblTypeValD1: TLabel;
    LblCommentD1: TLabel;
    LblD1: TLabel;
    EditDoseD1: TEdit;
    EditErrD1: TEdit;
    EditStatusD1: TEdit;
    MemoCommentD1: TMemo;
    PanelD2: TPanel;
    LblDoseD2: TLabel;
    LblErrD2: TLabel;
    LblStatusD2: TLabel;
    LblTypeD2: TLabel;
    LblTypeValD2: TLabel;
    LblCommentD2: TLabel;
    LblD2: TLabel;
    EditDoseD2: TEdit;
    EditErrD2: TEdit;
    EditStatusD2: TEdit;
    MemoCommentD2: TMemo;
    PanelD3: TPanel;
    LblDoseD3: TLabel;
    LblErrD3: TLabel;
    LblStatusD3: TLabel;
    LblTypeD3: TLabel;
    LblTypeValD3: TLabel;
    LblCommentD3: TLabel;
    LblD3: TLabel;
    EditDoseD3: TEdit;
    EditErrD3: TEdit;
    EditStatusD3: TEdit;
    MemoCommentD3: TMemo;
    PanelD4: TPanel;
    LblDoseD4: TLabel;
    LblErrD4: TLabel;
    LblStatusD4: TLabel;
    LblTypeD4: TLabel;
    LblTypeValD4: TLabel;
    LblCommentD4: TLabel;
    LblD4: TLabel;
    EditDoseD4: TEdit;
    EditErrD4: TEdit;
    EditStatusD4: TEdit;
    MemoCommentD4: TMemo;
    LabelStatus: TLabel;
    EditDosStatus: TEdit;
    LblDosNumberAndType: TLabel;
    LblPart: TLabel;
    EditDosPersNumberVal: TEdit;
    EditDosOrgVal: TEdit;
    EditDosDepVal: TEdit;
    TabSheetDos: TTabSheet;
    TabSheetIDK: TTabSheet;
    PanelPageDos: TPanel;
    PanelPageIDK: TPanel;
    LblDosFIO: TLabel;
    LblDosIDKState: TLabel;
    EditDosFIO: TEdit;
    EditDosIDKState: TEdit;
    EditDosKSVal: TEdit;
    EditDosMeasTimeVal: TEdit;
    EditDosComment: TEdit;
    EditKVal: TEdit;
    EditLFormulaDosVal: TEdit;
    EditDosPart: TEdit;
    EditDosVerVal: TEdit;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnAcceptClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var anAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MemoCommentKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure EditEnable(Sender: TObject);
    procedure EditDisable(Sender: TObject);
  private
    { Private declarations }
  public
    NewMeasure: boolean;

    procedure AcceptDosimeterData(Accept: boolean);
    { Public declarations }
  end;

const
  cVK_Enter = $0D;          //  кнопка Enter
  cVK_Esc = $1B;
var
  FinishMeasureW: TFinishMeasureW;

implementation

{$R *.dfm}

uses
  uConst,
  uMainForm,
  uDetector,
  uFunctions,
  uDataModule,
  uStartMF,
  uSeparator,
  uDosimeter;

procedure TFinishMeasureW.BtnCancelClick(Sender: TObject);
begin
//  AcceptDosimeterData(False);
  Close;
end;

procedure TFinishMeasureW.EditEnable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=true;
end;

procedure TFinishMeasureW.EditDisable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=false;
end;

procedure TFinishMeasureW.AcceptDosimeterData(Accept: boolean);
var
  //comment       : String;
  fullDosNumber : String;
  measurementID : integer;

  procedure UpdateDetComment(DetPos: integer; Comment: String);
  begin
    if MainForm.Dosimeter.DetectorsList[DetPos] <> nil then
    begin
      if TDetector(MainForm.Dosimeter.DetectorsList[DetPos]).Comment <> Comment then
      begin
        TDetector(MainForm.Dosimeter.DetectorsList[DetPos]).Comment:=Comment;
        MainForm.UpdateDetectorComment(MainForm.Dosimeter.MeasurementID,TDetector(MainForm.Dosimeter.DetectorsList[DetPos]).Position,Comment);
      end;
    end;
  end;

  procedure SetDetState;
  var
    i: integer;
  begin
    for i := 0 to MainForm.Dosimeter.DetectorsList.Count-1 do
    begin
      if MainForm.Dosimeter.DetectorsList[i] <> nil then
      begin
        case TDetector(MainForm.Dosimeter.DetectorsList[i]).State of
          stDetLost:
          begin
            MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetLost);
          end;
          stDetBroken:
          begin
            MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetBroken);
          end;
          stDetSkiped:
          begin
            MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetSkiped);
          end;
          stDetAccepted:
          begin
            //MainForm.UpdateDetectorData(MainForm.Dosimeter.MeasurementID,i+1,stDetAcceptedWarning);
          end;
          stDetProcessedError:
          begin
            //MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetAcceptedError);
            MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetProcessedError);
          end;
          stDetProcessedWarning:
          begin
            //MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetAcceptedWarning);
            MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetProcessedWarning);
          end;
          stDetProcessed:
          begin
            //MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetAccepted);
            MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetProcessed);
          end;
          stDetMeasStopped:
          begin
            MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetMeasStopped);
          end;
          stDetWaitMeas:
          begin
            MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetNotMeasured);
          end
          else
          begin
            MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,i+1,stDetAcceptedWarning);
          end;
        end;
      end;
    end;
  end;

  procedure SetDosVilidity;
  begin
    case MainForm.Dosimeter.Validity of
      stDosNotMeasured,
      stDosWaitLoad,
      stDosWaitMeasD1,
      stDosWaitMeasD2,
      stDosWaitMeasD3,
      stDosWaitMeasD4,
      stDosMeasInProgressD1,
      stDosMeasInProgressD2,
      stDosMeasInProgressD3,
      stDosMeasInProgressD4,
      stDosMeasStoppedD1,
      stDosMeasStoppedD2,
      stDosMeasStoppedD3,
      stDosMeasStoppedD4:
      begin
        MainForm.Dosimeter.Validity:=stDosNotMeasured;
      end;
      stDosMeasErrorD1,
      stDosMeasErrorD2,
      stDosMeasErrorD3,
      stDosMeasErrorD4,
      stDosMeasError:
      begin
        MainForm.Dosimeter.Validity:=stDosMeasError;
      end;
      stDosMeasFinished,
      stDosMeasAccepted,
      stDosMeasWarning:
      begin
        MainForm.Dosimeter.Validity:=stDosMeasAccepted;
      end;
      else
        MainForm.Dosimeter.Validity:=stDosMeasError;
    end;
  end;

begin
  //comment:=DeleteLastCRLF(MemoComment.Text);
  if MainForm.Dosimeter <> nil then
  begin
    // обновление комментариев
    UpdateDetComment(0,DeleteLastCRLF(MemoCommentD1.Text));
    UpdateDetComment(1,DeleteLastCRLF(MemoCommentD2.Text));
    UpdateDetComment(2,DeleteLastCRLF(MemoCommentD3.Text));
    UpdateDetComment(3,DeleteLastCRLF(MemoCommentD4.Text));

    if Accept then
    begin
      SetDosVilidity;
      SetDetState;
    end
    else
      MainForm.Dosimeter.Validity:=stDosMeasWarning;

    fullDosNumber:=MainForm.Dosimeter.FullNumber;
    measurementID:=MainForm.Dosimeter.MeasurementID;

    if Accept then
    begin
      MainForm.Dosimeter.PersNumber:=StrToIntRegion(EditDosPersNumberVal.Text);
      MainForm.Dosimeter.Fio:=EditDosFIO.Text;
      MainForm.Dosimeter.Organization:=EditDosOrgVal.Text;
      MainForm.Dosimeter.Department:=EditDosDepVal.Text;
      MainForm.Dosimeter.MeasComment:=EditDosComment.Text;
      if DateTimeToStr(MainForm.Dosimeter.MeasTime) = cZeroDate then MainForm.Dosimeter.MeasTime:=Now;
      MainForm.SaveMeasComment;
      MainForm.UpdateDosimeterIDKParam(EditDosFIO,EditDosPersNumberVal,EditDosOrgVal,EditDosDepVal);
    end;

    MainForm.UpdateGridMeasAndProcessPages;

  end;
end;

procedure TFinishMeasureW.BtnAcceptClick(Sender: TObject);
begin
  AcceptDosimeterData(True);
  Close;
end;

procedure TFinishMeasureW.FormClose(Sender: TObject; var anAction: TCloseAction);
begin
  MainForm.Start:=false;
  MainForm.JvDateTimePickerMeas.Date:=Date;
//
//  if MainForm.GaugeMeasDataD1.Visible then MainForm.GaugeMeasDataD1.Visible:=false;
//  if MainForm.GaugeMeasDataD2.Visible then MainForm.GaugeMeasDataD2.Visible:=false;
//  if MainForm.GaugeMeasDataD3.Visible then MainForm.GaugeMeasDataD3.Visible:=false;
//  if MainForm.GaugeMeasDataD4.Visible then MainForm.GaugeMeasDataD4.Visible:=false;
//
//  if not MainForm.EditMeasDataD1Status.Visible then MainForm.EditMeasDataD1Status.Visible:=true;
//  if not MainForm.EditMeasDataD2Status.Visible then MainForm.EditMeasDataD2Status.Visible:=true;
//  if not MainForm.EditMeasDataD3Status.Visible then MainForm.EditMeasDataD3Status.Visible:=true;
//  if not MainForm.EditMeasDataD4Status.Visible then MainForm.EditMeasDataD4Status.Visible:=true;
//
//  MainForm.UpdateGridMeasAndProcessPages;
end;

procedure TFinishMeasureW.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
// не работают на все форме
  if Key = cVK_Enter then BtnAcceptClick(Self);
  if Key = cVK_Esc then BtnCancelClick(Self);
end;

procedure TFinishMeasureW.FormShow(Sender: TObject);
begin
//  MemoComment.Clear;
  PageControlDosResults.ActivePageIndex:=0;
  if BtnAccept.Enabled then BtnAccept.SetFocus;
end;

procedure TFinishMeasureW.MemoCommentKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //if Key = сVK_Enter then BtnNextClick(Self);
  if Key = cVK_Esc then BtnCancelClick(Self);
end;

end.
