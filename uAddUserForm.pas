unit uAddUserForm;

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics,System.UITypes,
  Controls, Forms, Dialogs, StdCtrls, Inifiles,
  uLogPassForm,
  uConst,
  uUsersManagement,
  MD5,
//  idHash, IdHashMessageDigest, IdGlobal,
  uLanguages, ExtCtrls;
//  Hash,

type
  TAddUW = class(TForm)
    LoginEdit: TEdit;
    PasswordEdit: TEdit;
    ConfirmPasswordEdit: TEdit;
    OKButton: TButton;
    LoginLabel: TLabel;
    PermitLabel: TLabel;
    PassordLabel: TLabel;
    ConfirmPassLabel: TLabel;
    ErrLoginLabel: TLabel;
    ErrPassLabel: TLabel;
    ErrConfirmPassLabel: TLabel;
    PermitComboBox: TComboBox;
    CancelButton: TButton;
    PanelBottom: TPanel;
    PanelTop: TPanel;
    LabelTitle: TLabel;
    PanelBackground: TPanel;
    procedure OKButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LoginEditKeyUpEditEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddUW: TAddUW;

implementation
uses
  uLog,
  uDataModule;
{$R *.dfm}

procedure TAddUW.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TAddUW.FormCreate(Sender: TObject);
begin
  PermitLabel.Caption:=rsAccessRightsTemplate+':';
  LoginEdit.Text:='';
  PasswordEdit.Text:='';
  ConfirmPasswordEdit.Text:='';
  PasswordEdit.PasswordChar:='*';
  ConfirmPasswordEdit.PasswordChar:='*';
end;

procedure TAddUW.FormShow(Sender: TObject);
begin
  LoginEdit.Clear;
  PasswordEdit.Clear;
  ConfirmPasswordEdit.Clear;
  ErrLoginLabel.Visible:=false;
  ErrPassLabel.Visible:=false;
  ErrConfirmPassLabel.Visible:=false;
end;

procedure TAddUW.LoginEditKeyUpEditEnter(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  cVK_Enter = $0D;          //  кнопка Enter
begin
  if (Key = cVK_Enter) then
    OKButton.Click;
end;

procedure TAddUW.OKButtonClick(Sender: TObject);
var
  Login,
  Pass,
  ConfirmPass,
  EncodePass      : String;
  i               : integer;
  Permit          : int64;
  ReadyToAddUser  : boolean;
//  hashMD5         : THashMD5;
//  hashMD5         : TIdHashMessageDigest5;
begin
  Login:=LoginEdit.Text;
  Permit :=0;
  if PermitComboBox.ItemIndex<>-1 then
    Permit:=cpTemplatePermits[PermitComboBox.ItemIndex];

  Pass:=PasswordEdit.Text;
  ConfirmPass:=ConfirmPasswordEdit.Text;

  if Login='' then
  begin
    ErrLoginLabel.Visible:=true;
    ReadyToAddUser:=False;
  end
  else
  begin
    ErrLoginLabel.Visible:=false;
    ReadyToAddUser:=True;

    for i := 0 to Length(AW.Users)-1 do
    begin
      if Login = AW.Users[i].Login then
      begin
        LoginEdit.Text:='';
        ReadyToAddUser:=False;
        MessageDlg(Format('%s!',[rsUserAlreadyExist]),mtWarning,[mbOK], 0)
      end;
    end;
  end;

  if ReadyToAddUser then
  begin
    if Pass <> ConfirmPass then
    begin
      ErrPassLabel.Visible:=true;
      ErrConfirmPassLabel.Visible:=true;
      PasswordEdit.Text:='';
      ConfirmPasswordEdit.Text:='';
      ModalResult:=mrNone;
    end
    else                                                                                    // успешное добавление пользователя
    begin
      ErrPassLabel.Visible:=false;
      ErrConfirmPassLabel.Visible:=false;

      EncodePass:=UpperCase(MD5Print(MD5String(Pass))); // тупая попытка на шару

      if TLDDataModule.IsDBConnected then
      begin
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add(Format('INSERT INTO %s (%s,%s,%s) VALUES ('+#39+'%s'+#39+',%d,'+#39+'%s'+#39+')',[cDBTableUser,cFieldUserName,cFieldUserPermission,cFieldUserPassword,Login,Permit,EncodePass]));
        TLDDataModule.ADOQuery.ExecSQL;
        TLDDataModule.ADOQuery.Close;

        WriteLog(Format(rsAddedUser,[Login]));
        AW.ParsingUsersListDB;
      end;

    end;
  end
  else
    ModalResult:=mrNone;

end;

end.
