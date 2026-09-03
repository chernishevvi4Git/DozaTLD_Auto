unit uWarningComment;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics, DBGridsEh,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Menus;

type
  TWarningCommentForm = class(TForm)
    PanelBackground: TPanel;
    MemoMsg: TMemo;
    PanelBottom: TPanel;
    BtnClose: TButton;
    BtnDropWarning: TButton;
    PopupMenuMemo: TPopupMenu;
    procedure MemoEnable(Sender: TObject);
    procedure MemoDisable(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnDropWarningClick(Sender: TObject);
  private
    { Private declarations }
  public
    DetPos: integer;
    { Public declarations }
  end;

var
  WarningCommentForm: TWarningCommentForm;

implementation
uses
  uDetector,
  uConst,
  uLog,
  uMainForm;
{$R *.dfm}

{ TWarningCommentForm }

procedure TWarningCommentForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TWarningCommentForm.BtnDropWarningClick(Sender: TObject);
var
  index : integer;
  grid  : TDBGridEh;
begin
  if Assigned(MainForm.Dosimeter) then
  begin
    if Assigned(MainForm.Dosimeter.DetectorsList[DetPos-1]) then
    begin
      case MainForm.PageControlMain.ActivePage.PageIndex of
        cPageMeasIndex: grid:=MainForm.DBGridEhOnlyMeas;
        cPageProcessIndex: grid:=MainForm.DBGridEhProcess;
        else
          grid:=MainForm.DBGridEhOnlyMeas;
      end;

      TDetector(MainForm.Dosimeter.DetectorsList[DetPos-1]).State:=stDetProcessed;
      TDetector(MainForm.Dosimeter.DetectorsList[DetPos-1]).Comment:='';

      MainForm.UpdateDetectorState(MainForm.Dosimeter.MeasurementID,DetPos,stDetProcessed);
      MainForm.UpdateDetectorComment(MainForm.Dosimeter.MeasurementID,DetPos,'');
      index:=grid.DataSource.DataSet.RecNo;

      MainForm.Dosimeter.Validity:=MainForm.Dosimeter.GetDosimeterValidity;

      MainForm.UpdateDosimeterResStatus;

      if MainForm.IsLastMeasInDosimeter then MainForm.UpdateDosimeterLastMeas;

//      MainForm.UpdateDosimeterResStatus;
      MainForm.UpdateGridMeasAndProcessPages;

      MainForm.DBGridEhDos.DataSource.DataSet.Active:=false;
      MainForm.DBGridEhDos.DataSource.DataSet.Active:=true;

      grid.DataSource.DataSet.RecNo:=index;
      MainForm.GetMeasData;

      WriteLog(Format('%s: %s №%d %s "%s"',['Сброс состояния','Детектор',DetPos,'Дозиметр',MainForm.Dosimeter.FullNumber]));

    end;
  end;

  Close;
end;

procedure TWarningCommentForm.MemoDisable(Sender: TObject);
begin
  TMemo(Sender).Enabled:=false;
end;

procedure TWarningCommentForm.MemoEnable(Sender: TObject);
begin
  TMemo(Sender).Enabled:=true;
end;

end.
