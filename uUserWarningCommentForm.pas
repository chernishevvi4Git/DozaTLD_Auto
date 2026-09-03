unit uUserWarningCommentForm;

interface

uses
 
  LCLType,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Menus;

type
  TUserWarningCommentForm = class(TForm)
    PanelBackground: TPanel;
    PanelBottom: TPanel;
    BtnSave: TButton;
    EditUserMsg: TEdit;
    BtnClose: TButton;
    LblUserComment: TLabel;
    BtnDrop: TButton;
    procedure FormShow(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure EditUserMsgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnDropClick(Sender: TObject);
  private
    { Private declarations }
  public
    SaveBtnPressed  : boolean;
    DefaultMsg      : String;
    { Public declarations }
  end;

var
  UserWarningCommentForm: TUserWarningCommentForm;

implementation
uses
 uMainForm;
{$R *.dfm}

procedure TUserWarningCommentForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TUserWarningCommentForm.BtnDropClick(Sender: TObject);
begin
  MainForm.UserWarningComment:=false;
  MainForm.SetUserWarning(false);
  Close;
end;

procedure TUserWarningCommentForm.BtnSaveClick(Sender: TObject);
begin
  SaveBtnPressed:=true;
  Close;
end;

procedure TUserWarningCommentForm.EditUserMsgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  begin
    SaveBtnPressed:=true;
    Close;
  end;
end;

procedure TUserWarningCommentForm.FormShow(Sender: TObject);
begin
  SaveBtnPressed:=False;
  BtnSave.SetFocus;
  EditUserMsg.Text:=DefaultMsg;

  if MainForm.SpeedBtnMeasUserWarning.Down OR MainForm.SpeedBtnProcessUserWarning.Down then
    BtnDrop.Enabled:=true
  else
    BtnDrop.Enabled:=false;
end;

end.
