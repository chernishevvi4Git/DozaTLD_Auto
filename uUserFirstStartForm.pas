unit uUserFirstStartForm;

interface

uses
//  Messages,
  SysUtils,System.UITypes, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
//  idHash, IdHashMessageDigest, IdGlobal,
  MD5,
  uLogPassForm,
  uLanguages,
  uConst;
//  System.Hash,

type
  TFormUserFirstStart = class(TForm)
    PanelBackground: TPanel;
    LabelTop: TLabel;
    LblLogin: TLabel;
    EditLogin: TEdit;
    LblPass: TLabel;
    LblConfirmPass: TLabel;
    EditPass: TEdit;
    EditConfirmPass: TEdit;
    PanelTop: TPanel;
    PanelBottom: TPanel;
    BtnCancel: TButton;
    BtnOk: TButton;
    LblErrConfirmPass: TLabel;
    LblErrPass: TLabel;
    LblErrLogin: TLabel;
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    Login         : String;
    Pass          : String;
    ExitBtnClick  : boolean;
    { Public declarations }
  end;

var
  FormUserFirstStart: TFormUserFirstStart;

implementation
uses
  uLog,
  uMainForm,
  uDataModule;
{$R *.dfm}

procedure TFormUserFirstStart.BtnCancelClick(Sender: TObject);
begin
  ExitBtnClick:=true;
  MainForm.Close;
end;

procedure TFormUserFirstStart.BtnOkClick(Sender: TObject);
var
  confirmPass     : String;
  encodePass      : String;
  readyToAddUser  : boolean;
begin
  ExitBtnClick:=false;
  Login:=EditLogin.Text;
  Pass:=EditPass.Text;
  confirmPass:=EditConfirmPass.Text;

  if Login='' then
  begin
    LblErrLogin.Visible:=true;
    readyToAddUser:=false;
  end
  else
  begin
    LblErrLogin.Visible:=false;
    readyToAddUser:=true;

    if Login=cSuperUser then
    begin
      EditLogin.Text:='';
      readyToAddUser:=false;
      MessageDlg(Format('%s!',[rsUserNameIsNotValid]),mtWarning,[mbOK], 0)
    end;
  end;

  if readyToAddUser then
  begin
    if Pass <> confirmPass then
    begin
      LblErrPass.Visible:=true;
      LblErrConfirmPass.Visible:=true;
      EditPass.Text:='';
      EditConfirmPass.Text:='';
      ModalResult:=mrNone;
    end
    else                                                                                    // успешное добавление пользователя
    begin
      LblErrPass.Visible:=false;
      LblErrConfirmPass.Visible:=false;
       EncodePass:=UpperCase(MD5Print(MD5String(Pass)));

      if TLDDataModule.IsDBConnected then
      begin
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add('INSERT INTO '+cDBTableUser+' ('+cFieldUserName+','
                                                                       +cFieldUserPermission+','
                                                                       +cFieldUserPassword+')'
                                                           +' VALUES ('+#39+Login+#39+','
                                                                       +IntToStr(cFullPermit)+','
                                                                       +#39+EncodePass+#39+')');
        TLDDataModule.ADOQuery.ExecSQL;
        TLDDataModule.ADOQuery.SQLTransaction.Commit;
        TLDDataModule.ADOQuery.Close;

        WriteLog(Format(rsAddedUser,[Login]));
        AW.ParsingUsersListDB;
        Close;
      end;

    end;
  end;
end;

procedure TFormUserFirstStart.FormActivate(Sender: TObject);
begin
  EditLogin.SetFocus;
end;

procedure TFormUserFirstStart.FormCreate(Sender: TObject);
begin
  EditLogin.Text:='';
  EditPass.PasswordChar:='*';
  EditConfirmPass.PasswordChar:='*';
  ExitBtnClick:=False;
end;

end.
