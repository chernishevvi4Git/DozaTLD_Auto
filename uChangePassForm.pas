unit uChangePassForm;

interface

uses
  Messages, SysUtils, Variants, Inifiles, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls,
  uLogPassForm,
  uConst,
//  idHash, IdHashMessageDigest, IdGlobal,
  MD5,
  uLanguages, ExtCtrls;
// Hash,

type
  TUChangePassW = class(TForm)
    ConfirmNewPassEdit: TEdit;
    CancelButton: TButton;
    OKButton: TButton;
    ConfirmNewPassErrLabel: TLabel;
    ConfirmNewPassLabel: TLabel;
    NewPassErrLabel: TLabel;
    NewPassEdit: TEdit;
    NewPassLabel: TLabel;
    LoginEdit: TEdit;
    LoginLabel: TLabel;
    OldPassLabel: TLabel;
    OldPassEdit: TEdit;
    OldPassErrLabel: TLabel;
    PanelBackground: TPanel;
    PanelTop: TPanel;
    LabelTitle: TLabel;
    PanelBottom: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var anAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure LoginEditKeyUpEditEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FLogin      : String;
    FUserIndex  : integer;
    procedure SetLogin(Value: String);
    procedure SetUserIndex(const Value: integer);
  public
    function GetUserID(Login: String): integer;
    property Login: String read FLogin write SetLogin;
    property UserIndex: integer read FUserIndex write SetUserIndex;
    { Public declarations }
  end;

var
  UChangePassW: TUChangePassW;

implementation
uses
  uLog,
  uDataModule;

{$R *.dfm}

function TUChangePassW.GetUserID(Login: String): integer;
var
  i: integer;
begin
  Result:=-1;

  for i := Low(AW.Users) to High(AW.Users) do
  begin
    if AW.Users[i].Login = Login then
      Result:=i
    else
      Result:=-1;
  end;
end;

procedure TUChangePassW.LoginEditKeyUpEditEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  cVK_Enter = $0D;          //  кнопка Enter
begin
  if (Key = cVK_Enter) then
    OKButton.Click;
end;

procedure TUChangePassW.SetLogin(Value: String);
begin
  FLogin:=Value;
  LoginEdit.Text:=FLogin;
end;

procedure TUChangePassW.SetUserIndex(const Value: integer);
begin
  FUserIndex:=Value;
end;

procedure TUChangePassW.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TUChangePassW.FormClose(Sender: TObject; var anAction: TCloseAction);
begin
  OldPassEdit.Text:='';
  NewPassEdit.Text:='';
  ConfirmNewPassEdit.Text:='';
end;

procedure TUChangePassW.FormCreate(Sender: TObject);
begin
  OldPassEdit.PasswordChar:='*';
  NewPassEdit.PasswordChar:='*';
  ConfirmNewPassEdit.PasswordChar:='*';
end;

procedure TUChangePassW.FormShow(Sender: TObject);
begin
  OldPassErrLabel.Visible:=false;
  NewPassErrLabel.Visible:=false;
  ConfirmNewPassErrLabel.Visible:=false;
end;

procedure TUChangePassW.OKButtonClick(Sender: TObject);
var
  oldPass           : String;
  encodeOldPass     : String;
  encodeNewPass     : String;
  newPass           : String;
  confirmNewPass    : String;
  readyToChangePass : boolean;
  temp              : word;
begin
  oldPass:=OldPassEdit.Text;
  newPass:=NewPassEdit.Text;
  confirmNewPass:=ConfirmNewPassEdit.Text;

  encodeOldPass:=UpperCase(MD5Print(MD5String(oldPass)));

  if EncodeOldPass<>AW.Users[FUserIndex].Password then
  begin
    ReadyToChangePass:=False;
    OldPassErrLabel.Visible:=true;
    OldPassEdit.Text:='';
  end
  else
  begin
    OldPassErrLabel.Visible:=false;

    if NewPass<>ConfirmNewPass then
    begin
      ReadyToChangePass:=False;
      NewPassErrLabel.Visible:=true;
      ConfirmNewPassErrLabel.Visible:=true;
      NewPassEdit.Text:='';
      ConfirmNewPassEdit.Text:='';
      ModalResult:=mrNone;
    end
    else
    begin
      ReadyToChangePass:=True;
      NewPassErrLabel.Visible:=false;
      ConfirmNewPassErrLabel.Visible:=false;
    end;
  end;

  if readyToChangePass then
  begin
    encodeNewPass:=UpperCase(MD5Print(MD5String(newPass)));

    if TLDDataModule.IsDBConnected then
    begin

      temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format(rsChangeUserPasswordQuery,[AW.Users[FUserIndex].Login]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

      case temp of
        mrYes:
        begin
          TLDDataModule.ADOQuery.SQL.Clear;
          TLDDataModule.ADOQuery.SQL.Add(Format('UPDATE %s SET %s = '+#39+'%s'+#39+' WHERE %s=%d',[cDBTableUser,cFieldUserPassword,encodeNewPass,cFieldUserNameID,AW.Users[FUserIndex].UserId]));
          TLDDataModule.ADOQuery.ExecSQL;
          TLDDataModule.ADOQuery.Close;

          WriteLog(Format(rsChangeUserPassword,[AW.Users[FUserIndex].Login]));
          AW.ParsingUsersListDB;

        end;
      end;
    end;
    Close;
  end
  else
    ModalResult:=mrNone;
end;

end.
