unit uChangeDosNameInMeas;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  uDataModule,
  uConst,
  uTLDCommand,
  uFunctions;

type

  { TChangeDosNameInMeasForm }

  TChangeDosNameInMeasForm = class(TForm)
    BtnCancel: TButton;
    BtnSave: TButton;
    EditEnterNewDosNumber: TEdit;
    EditEnterNewPostfix: TEdit;
    LblDosNameErr: TLabel;
    LabelTitle: TLabel;
    LblEnterNewDosName: TLabel;
    LabelEditEnterNewPostfix: TLabel;
    PanelBottom: TPanel;
    PanelDosTitle: TPanel;
    PanelBackGround: TPanel;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure EditEnterNewDosNumberChange(Sender: TObject);
    procedure EditEnterNewDosNumberKeyPress(Sender: TObject; var Key: char);
    procedure EditEnterNewPostfixChange(Sender: TObject);
    procedure EditEnterNewPostfixKeyPress(Sender: TObject; var Key: char);
  private

  public
    measID       : integer;
    oldDosNumber : string;
  end;

var
  ChangeDosNameInMeasForm: TChangeDosNameInMeasForm;

implementation
uses
  uMainForm;

{$R *.lfm}

{ TChangeDosNameInMeasForm }

procedure TChangeDosNameInMeasForm.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TChangeDosNameInMeasForm.BtnSaveClick(Sender: TObject);
var
  index      : integer;
  number     : string;
  postfix    : string;
  fullNumber : string;
begin
  case MainForm.PageControlMain.ActivePage.PageIndex of
    cPageMeasIndex:
    begin
      index:=MainForm.DBGridEhOnlyMeas.DataSource.DataSet.RecNo;
    end;
    cPageProcessIndex:
    begin
      index:=MainForm.DBGridEhProcess.DataSource.DataSet.RecNo;
    end;
  end;

  number:=EditEnterNewDosNumber.Text;

  if (EditEnterNewPostfix.Text = '') then
    postfix:='-'
  else
    postfix:=EditEnterNewPostfix.Text;

  fullNumber:=number+EditEnterNewPostfix.Text;

  if TLDDataModule.IsDosimeterExist(fullNumber) then
  begin
    if TLDDataModule.ChangeDosNumberInMeasResult(measID,number,postfix) then
    begin
      LblDosNameErr.Visible:=false;
      MainForm.UpdateGridMeasAndProcessPages;

      case MainForm.PageControlMain.ActivePage.PageIndex of
        cPageMeasIndex:
        begin
          MainForm.DBGridEhOnlyMeas.DataSource.DataSet.RecNo:=index;
          MainForm.DBGridEhOnlyMeas.SelectedRows.CurrentRowSelected:=true;
        end;
        cPageProcessIndex:
        begin
          MainForm.DBGridEhProcess.DataSource.DataSet.RecNo:=index;
          MainForm.DBGridEhProcess.SelectedRows.CurrentRowSelected:=true;
        end;
      end;

      Close;
      MainForm.OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %d. %s',['Измерение №',measID,'Номер дозиметра изменен c "'+oldDosNumber+'" на "'+fullNumber+'"']),'',cMsgNone,cMsgPriorityInf);
      MessageDlg(Format('%s %d. %s',['Измерение №',measID,'Номер дозиметра изменен']),mtInformation,[mbOK],0);
    end
    else
    begin
      Close;
      MainForm.OnCommandLog(TimeToStr(Now)+' : -> ',Format('%s %d. %s',['Измерение №',measID,'Ошибка изменения номера дозиметра c "'+oldDosNumber+'" на "'+fullNumber+'"']),'',cMsgNone,cMsgPriorityInf);
      MessageDlg(Format('%s %d. %s',['Измерение №',measID,'Ошибка изменения номера дозиметра']),mtError,[mbOK],0);
    end;
  end
  else
  begin
    LblDosNameErr.Visible:=true;
  end;
end;

procedure TChangeDosNameInMeasForm.EditEnterNewDosNumberChange(Sender: TObject);
begin
  LblDosNameErr.Visible:=false;
end;

procedure TChangeDosNameInMeasForm.EditEnterNewDosNumberKeyPress(
  Sender: TObject; var Key: char);
begin
  Key:=OnlyIntNumbers(Key);
end;

procedure TChangeDosNameInMeasForm.EditEnterNewPostfixChange(Sender: TObject);
begin
  LblDosNameErr.Visible:=false;
end;

procedure TChangeDosNameInMeasForm.EditEnterNewPostfixKeyPress(Sender: TObject;
  var Key: char);
begin
  Key:=NoSpecialSymbols(Key);
end;

end.

