unit uLogPassForm;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, DB,
//  IniFiles,
  uLanguages,
//  uMessageForm,
  uConst,
  uLog, ExtCtrls;

//System.UITypes, System.Hash,

type
  TUser = record                        //  записи пользователей
    UserId                : integer;    //  id пользователя
    Login                 : String;     //  логин
    Password              : String;     //  пароль
    Permit                : int64;      //  права доступа
  end;

  TAW = class(TForm)
    PasswordEdit: TEdit;
    LoginComboBox: TComboBox;
    OkButton: TButton;
    ExitButton: TButton;
    LoginLabel: TLabel;
    PasswordLabel: TLabel;
    PanelBackground: TPanel;
    PanelBottom: TPanel;
    procedure OkButtonClick(Sender: TObject);
    procedure LoginComboBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure EditUsersButtonClick(Sender: TObject);
  private
    { Private declarations }
//    FCurrentUser: TUser;                              //  текущий пользователь
  public
    { Public declarations }
    Users: array of TUser;                            //  массив записей пользователей
    CurrentUser: TUser;  // свойство текущего пользователя
//    ArrayOfPermit: array [0..2] of String;             //  массив прав доступа
    ExitBtnClick: Boolean;                             //  флаг нажатия кнопки выход
//    function md5(s:String):String;                     //  шифрование md5
    function IsHaveIRight(numOfBit: byte): boolean;
    procedure SetMyRight(numOfBit: byte; aRight: boolean);
    function ParsingUsersListDB: boolean;
    function IsFirstStart: boolean;
  end;

var
  AW: TAW;
  bNoLogin : boolean = True; // признак отссутствия авторизации в программе

implementation
uses
  uMainForm,
  uDataModule,
  uUserFirstStartForm,
  MD5,
//  IdGlobal,
//  IdHash,
//  IdHashCRC,
//  idHash, IdHashMessageDigest, IdGlobal,

//  IdHashMessageDigest,
  uFunctions;

{$R *.dfm}

procedure TAW.EditUsersButtonClick(Sender: TObject);
begin
//  UMW.ShowModal;
end;

procedure TAW.ExitButtonClick(Sender: TObject);
begin
  if bNoLogin then
  begin
    ExitBtnClick:=True;
    MainForm.Close;
  end
    else Close;
end;

procedure TAW.FormCreate(Sender: TObject);
begin
  LoginComboBox.ItemIndex:=-1;
  PasswordEdit.Text:='';
  PasswordEdit.PasswordChar:='*';
  ExitBtnClick:=False;
end;

function TAW.IsHaveIRight(numOfBit: byte): boolean;
begin
  result := IsBit64On(CurrentUser.Permit,numOfBit);
end;

procedure TAW.SetMyRight(numOfBit: byte; aRight: boolean);
begin
  CurrentUser.Permit := SetBit64(Int64(CurrentUser.Permit),numOfBit,aRight);
end;

procedure TAW.LoginComboBoxChange(Sender: TObject);
begin
  PasswordEdit.Text:='';
end;

//function TAW.md5(s:String):String;         // функция подсчета md5
//begin
//  Result := '';
//  with TIdHashMessageDigest5.Create do
//  try
//    Result := AnsiLowerCase(HashStringAsHex(s));
//  finally
//    Free;
//  end;
//end;

function CalculateModBusCRC(aData: String):word;
var
  crc: word;
  sh,i: integer;
  aBytes: integer;
begin
  aBytes:=length(aData);
  crc := $FFFF;
  for i:=1 to aBytes do
  begin
    crc := crc xor ord(aData[i]);
    sh:=0;
    while sh<>8 do
      if (crc and 1)<>0
      then
      begin
        crc:=(crc shr 1) xor $A001;
        sh:=sh+1;
      end
    else
    begin
      crc:=crc shr 1;
      sh:=sh+1;
    end;
  end;
  result:=crc;
end;

procedure TAW.OkButtonClick(Sender: TObject);
var
  i               : integer;
  Login           : String;       // переменная: логин
  Password        : String;       // переменная: пароль
  PassForCompare  : String;       // переменная: подтвержденный пароль
  Connected       : boolean;      // флаг: залогинились/не залогинились
  yyyy,mm,dd      : word;
  yyyymmdd        : String;
  DT              : TDateTime;
  G               : integer;
  CRC16           : word;
  S1,S2           : String;
  CCCC,FFFF       : String;
  cUser           : integer;
  NN              : String;
begin
  Connected:=False;               // по умолчанию мы не залогинены
  ExitBtnClick:=False;

  if not MainForm.FirstStart then        // если не первый запуск программы
  begin
    if MainForm.UseUserNameCMDPar then   // проверяем флаг "Программа запущена с параметрами: Имя пользоватея, пароль"
    begin                                // если true
      Login:=MainForm.CMDParUserName;    // подставляем параметр :user
      Password:=MainForm.CMDParPass;     // подставляем параметр :password
    end
    else                                 // если false
    begin                                // подставляем то, что введено пользователем в соответствующие поля
      Login:=LoginComboBox.Text;         //
      Password:=PasswordEdit.Text;       //
    end;
  end
  else
  begin
    Login:=FormUserFirstStart.Login;
    Password:=FormUserFirstStart.Pass;
  end;


  for i := 0 to Length(Users)-1 do
  begin
    if Login=Users[i].Login then
    begin
      PassForCompare:=UpperCase(MD5Print(MD5String(Password)));
      if PassForCompare=UpperCase(Users[i].Password) then                     // сравниваем
      begin                                                        // если пароль совпал
        Connected:=True;                                           // выставляем флаг: залогинились
        CurrentUser:=Users[i];                                     // запоминаем логин
        MainForm.StatusBarUser:=Users[i].Login;                    // пишем логин в строке состояния в нижнем правом углу основного окна
        WriteLog(Format(rsEnterUser,[Users[i].Login]));               // запись имени пользоветеля в лог
        LoginComboBox.ItemIndex:=-1;                                                  // комбобокс с логинами делаем "пустым"
        PasswordEdit.Text:='';                                                        // поле для ввода пароля очищаем, чтобы при перезапуске окна "Сменить пользователя" поля были пустые

        if MainForm.UseUserNameCMDPar then                                            // проверяем был ли, взведен флаг "Программа запущена с параметрами: Имя пользоватея, пароль"
          MainForm.UseUserNameCMDPar:=False;                                          // сбрасываем его, чтобы при перезапуске окна "Сменить пользователя", эти параметры автоматически не подставлялись

        if (AW.Users[MainForm.PermitSelectedRowUser].Login=AW.CurrentUser.Login) then
          MainForm.CB_SetAsTemlate.Enabled:=false
        else
          MainForm.CB_SetAsTemlate.Enabled:=true;


        MainForm.SetInterfaceByPermits;

        AW.Close;                                                                     // закрываем окно аутентификации
        bNoLogin := false;
      end;
    end;
  end;

// Проверка на пароль предприятия
  if not Connected and (length(Password)=13) then
  begin
    if (Password[1]='M') or (Password[1]='Y') or (Password[1]='D') then
    if (Password[11]='A') then // тип ТЛД
    begin
      DecodeDate(Date, yyyy, mm, dd);
      G := ord(Password[2])-64;
      if (Password[1]='M') then
      begin
        if dd<G then
        begin
          mm := mm - 1;
          if mm<1 then
          begin
            yyyy := yyyy - 1;
            mm := 12;
          end;
        end;
      end;

      if (Password[1]='Y') then
        if mm<G then yyyy := yyyy - 1;

      DT := EncodeDate(yyyy,mm,dd);
      yyyymmdd := FormatDateTime('yyyymmdd' ,DT);

      if (Password[1]='Y') then
      begin
        yyyymmdd[5] :='*';
        yyyymmdd[6] :='*';
        yyyymmdd[7] :='*';
        yyyymmdd[8] :='*';
      end;

      if (Password[1]='M') then
      begin
        yyyymmdd[7] :='*';
        yyyymmdd[8] :='*';
      end;

      S1 := Password[1] + Password[2] + yyyymmdd + Password[11] + Password[12] + Password[13];
      S2 := Password[2] + yyyymmdd + Password[11] + Password[12] + Password[13];

      CRC16 := CalculateModBusCRC(S1) xor (ord('D')*256+ord('o'));
      CCCC := IntToHex(CRC16,4);
      FFFF := Password[3] + Password[4] + Password[5] + Password[6];
      if CCCC=FFFF then
      begin
        CRC16 := CalculateModBusCRC(S2) xor (ord('z')*256+ord('a'));
        FFFF := Password[7] + Password[8] + Password[9] + Password[10];
        CCCC := IntToHex(CRC16,4);

        NN := IntToStr(MainForm.DeviceID mod 100);
        if length(NN)<2 then NN:='0'+NN;

        if Password[12]='*' then
          if Password[13]='*' then
            NN:='**';

        if FFFF=CCCC then
        begin
          if NN=(Password[12]+Password[13]) then
          begin
            SetLength(Users,length(Users)+1);  // новый пользователь
            cUser := length(Users)-1;          // его индекс
            Users[cUser].UserId := cUser;      //  id пользователя
            Users[cUser].Login := 'DOZA';      //  логин
            Users[cUser].Password := Password; //  пароль
//            Users[cUser].Permit := int64(MaxInt)*(MaxInt+Int64(1))+MaxInt;
            Users[cUser].Permit := cSuperUserPermit;     //  права доступа
            Connected:=True;                                           // выставляем флаг: залогинились
            CurrentUser:=Users[cUser];                                     // запоминаем логин
            MainForm.StatusBarUser:=Users[cUser].Login;                    // пишем логин в строке состояния в нижнем правом углу основного окна
            WriteLog(Format(rsEnterUser,[Users[cUser].Login]));               // запись имени пользоветеля в лог
            LoginComboBox.ItemIndex:=-1;                                                  // комбобокс с логинами делаем "пустым"
            PasswordEdit.Text:='';                                                        // поле для ввода пароля очищаем, чтобы при перезапуске окна "Сменить пользователя" поля были пустые

            if MainForm.UseUserNameCMDPar then                                            // проверяем был ли, взведен флаг "Программа запущена с параметрами: Имя пользоватея, пароль"
              MainForm.UseUserNameCMDPar:=False;                                          // сбрасываем его, чтобы при перезапуске окна "Сменить пользователя", эти параметры автоматически не подставлялись

            if (AW.Users[MainForm.PermitSelectedRowUser].Login=AW.CurrentUser.Login) then
              MainForm.CB_SetAsTemlate.Enabled:=false
            else
              MainForm.CB_SetAsTemlate.Enabled:=true;

            MainForm.SetInterfaceByPermits;

            AW.Close;                                                                     // закрываем окно аутентификации
            bNoLogin := false;
          end;
        end;
      end;
    end;
  end;

  if not Connected then                                           // если пароль не совпал, то
  begin
    MessageDlg(rsIncorrectLoginPass+'!',mtWarning,[mbOK], 0);     // выводим предупреждающее сообщение
    PasswordEdit.Text:='';

    if MainForm.UseUserNameCMDPar then                                                // проверяем был ли, взведен флаг "Программа запущена с параметрами: Имя пользоватея, пароль"
      MainForm.UseUserNameCMDPar:=False;                                              // сбрасываем его, чтобы при перезапуске окна "Сменить пользователя", эти параметры автоматически не подставлялись

    if not Showing then                                                               // проверяем открыто ли окно "Сменить пользователя"
    begin                                                                             // это нужно для того, что бы при неверном пользователе/пароле полученном из параметров(Имя пользоватея, пароль)
      ParsingUsersListDB;                                                             // заново открыть окно аутентификации
      ShowModal;                                                                      // и предложить залогиниться снова
      ExitButton.Visible:=False;
      OkButton.Left:=82;
    end;

  end;
end;

function TAW.ParsingUsersListDB: boolean;
var
  i           : integer;
  cnt         : integer;
  j: integer;
begin
  Result:=false;

  LoginComboBox.Items.Clear;

  if TLDDataModule.IsDBConnected then
  begin
    if TLDDataModule.ADOQuery.Active then TLDDataModule.ADOQuery.Close;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add(Format('SELECT COUNT(*) FROM %s',[cDBTableUser]));
    TLDDataModule.ADOQuery.Open;

    cnt:=TLDDataModule.ADOQuery.FieldByName(cCount).AsInteger;
    SetLength(Users,cnt);

    TLDDataModule.ADOQuery.Close;


    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add(Format('SELECT %s, %s, %s, %s FROM %s ORDER BY usernameid',[cFieldUserName,cFieldUserNameID,cFieldUserPermission,cFieldUserPassword,cDBTableUser]));
    //    SELECT username, usernameid, userpermission, userpassword FROM tlduser ORDER BY usernameid
    TLDDataModule.ADOQuery.Open;

    TLDDataModule.ADOQuery.First;

    if cnt > 0 then
    begin
      for i := 0 to cnt-1 do
      begin
        Users[i].Login:=TLDDataModule.ADOQuery.FieldByName(cFieldUserName).AsString;
        if Users[i].Login <> cSuperUser then LoginComboBox.Items.Add(Users[i].Login);
        Users[i].UserId:=TLDDataModule.ADOQuery.FieldByName(cFieldUserNameID).AsInteger;
        Users[i].Password:=TLDDataModule.ADOQuery.FieldByName(cFieldUserPassword).AsString;
        Users[i].Permit:=TLDDataModule.ADOQuery.FieldByName(cFieldUserPermission).AsLargeInt;

        TLDDataModule.ADOQuery.Next;
      end;
      Result:=true;
      TLDDataModule.ADOQuery.Close;
    end
    else
    begin
      WriteLog(Format('%s - "%s"',[rsErrUserListEmpty,cDBTableUser]));
      Result:=false;
    end;
  end
  else
    Result:=false;
end;

function TAW.IsFirstStart: boolean;
var
  cnt         : integer;
begin
  if TLDDataModule.IsDBConnected then
  begin
    if TLDDataModule.ADOQuery.Active then TLDDataModule.ADOQuery.Close;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('SELECT COUNT(*) FROM '+cDBTableUser+' WHERE '+cFieldUserName+'<>'+#39+cSuperUser+#39);
    TLDDataModule.ADOQuery.Open;

    cnt:=TLDDataModule.ADOQuery.FieldByName(cCount).AsInteger;

    if cnt > 0 then
      Result:=false
    else
      Result:=true;

    TLDDataModule.ADOQuery.Close;
  end
  else
    Result:=false;
end;

end.
