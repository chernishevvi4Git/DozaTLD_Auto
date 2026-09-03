unit uImportDBForm;

interface

uses
//  Messages,System.UITypes,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TImportDBForm = class(TForm)
    EditDBName: TEdit;
    LblBDNameErr: TLabel;
    BtnCancel: TButton;
    BtnOk: TButton;
    LblNewBaseName: TLabel;
    LblImportFile: TLabel;
    EditImportPath: TEdit;
    SpeedBtnOpenFile: TSpeedButton;
    ProgressBar: TProgressBar;
    LblProgressBar: TLabel;
    OpenDialogBackupFile: TOpenDialog;
    LblBackupFileName: TLabel;
    procedure BtnCancelClick(Sender: TObject);
    procedure EditDBNameChange(Sender: TObject);
    procedure EditDBNameKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedBtnOpenFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    FDBName: String;
    FBackupFileName: String;
    function CheckName(aName: String): integer;
    procedure SetDBName(aName: String);
    procedure ProgressBarStart(aText: String);
    procedure ProgressBarStop;
    procedure ProgressBarError;
    { Private declarations }
  public
    OkBtn     :  boolean;
    function Import(DBName: String): boolean;
    property Name: String read FDBName write SetDBName;
    { Public declarations  }
  end;

const
  cErrEmpty   = 1;
  cErrNumber  = 2;
  cOk         = 0;

var
  ImportDBForm: TImportDBForm;

implementation
uses
  uConst,
  uMainForm,
  uFunctions,
  uOpenDB,
  uDataModule,
  uLanguages;
{$R *.dfm}

{ TImportDBForm }

procedure TImportDBForm.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TImportDBForm.BtnOkClick(Sender: TObject);
var
  validDBName  : boolean;
begin
  validDBName:=false;

  case CheckName(Name) of
    cOk:
    begin
      LblBDNameErr.Caption:='';
      LblBDNameErr.Visible:=False;
      validDBName:=true;
    end;
    cErrEmpty:
    begin
      LblBDNameErr.Caption:=rsInputName+'!';
      LblBDNameErr.Visible:=True;
    end;
    cErrNumber:
    begin
      LblBDNameErr.Caption:=rsErrNameCiphFirst+'!';
      LblBDNameErr.Visible:=True;
    end;
  end;

  if validDBName then
  begin
    if FileExists(FBackupFileName) then
    begin
      ProgressBarStart(rsCreateDB + ' - ' + Name);
      if not TLDDataModule.IsDBExist(Name) then
      begin
        TLDDataModule.CreateDB(Name,true);
        if TLDDataModule.IsDBExist(Name) then
        begin
          OpenDB.RefreshDBList;
          OpenDB.DBGridSetFocus(OpenDB.GetDBGridStringNumber(Name));
          ProgressBarStop;

          if Import(Name) then
          begin
            TLDDataModule.ConnectToDB(Name);

            if MainForm.IsValidDBVersion then
            begin
              OpenDB.OnCheckDBConnection;
              OpenDB.RefreshDBList;
              OpenDB.DBGridSetFocus(OpenDB.GetDBGridStringNumber(Name));
              MainForm.LoadFilters;
              Close;
            end
            else
            begin
              MainForm.Close;
            end;

          end
          else
          begin
            ProgressBarError;
            LblBDNameErr.Caption := rsErrDBImport3;
            LblBDNameErr.Visible := True;
          end;
        end
        else
        begin
          MessageDlg(format(rsErrDBCreated,[Name]),mtError, [mbOK], 0);
        end;
      end
      else
      begin
        ProgressBarError;
        LblBDNameErr.Caption:=rsDBAlreadyExists;
        LblBDNameErr.Visible:=True;
      end;
    end
    else
    begin
      LblBackupFileName.Caption:=rsFileNotFound;
      LblBackupFileName.Visible:=True;
    end;
  end;

end;

function TImportDBForm.CheckName(aName: String): integer;
var
  n: integer;
begin
  if aName='' then
    result:=cErrEmpty   // пустая строка
  else if TryStrToInt(aName[1],n) then
    result:=cErrNumber  // первый символ - цифра
  else
    result:=cOk;
end;

procedure TImportDBForm.EditDBNameChange(Sender: TObject);
begin
  try
    Name:=EditDBName.Text;
  except
    MessageDlg(rsEnterCorrectValue,mtWarning,[mbOK], 0);
  end;
end;

procedure TImportDBForm.EditDBNameKeyPress(Sender: TObject; var Key: Char);
begin
//  if not (Key in ['0'..'9', 'А'..'Я', 'а'..'я', 'A'..'Z', 'a'..'z', #8, #95]) then
  if not (Key in ['0'..'9', 'A'..'Z', 'a'..'z', #8, #95]) then
  begin
    LblBDNameErr.Caption:=rsIllegalChar+' - "'+Key+'"';
    LblBDNameErr.Visible:=True;
    Key:=#0;     // ограничение на ввод имеи БД - только латиница
  end
  else
    LblBDNameErr.Visible:=False;
end;

procedure TImportDBForm.FormCreate(Sender: TObject);
begin
  Caption:=rsImportDB;
  FBackupFileName:='';
end;

procedure TImportDBForm.FormShow(Sender: TObject);
begin
  ProgressBar.Visible:=False;
  LblBackupFileName.Visible:=False;
  LblProgressBar.Visible:=False;
  FBackupFileName:='';
  EditDBName.Text:='';
  EditImportPath.Text:='';
end;

function TImportDBForm.Import(DBName: String): boolean;
var
  PGRestorePath  :  String;
  PGRestoreParam :  String;
  Flag           :  boolean;
begin
  Flag:=False;

  PGRestorePath:=TLDDataModule.PGRestorePath;;
  if FileExists(PGRestorePath) then
  begin
    PGRestoreParam:='-d '+cPostgreDefaultDB+'://'+cPostgreDefaultDB+':'+TLDDataModule.PGPass+'@'+TLDDataModule.ServerIP+':'+TLDDataModule.PGPort+'/'+DBName+' '
                   +'-v "'+FBackupFileName+'"';

    // запускаем скрол бар
    ProgressBarStart(rsImportDB+' - '+DBName);

    // через функцию ExecAndWait запускаем программу "pg_restore.exe" для восстановления таблиц и ожидаем ее завершения
    try
//**//      Flag:=ExecAndWait(PGRestorePath,PGRestoreParam,SW_SHOWNORMAL);
    except
      on E: Exception do
      begin
        Flag:=false;
        ProgressBarError;
        MessageDlg(E.Message+CRLF+rsErrDBImport3+'.',mtError, [mbOK], 0);
      end;
    end;

    // останавливаем скролл бар
    ProgressBarStop;

  end
  else
  begin
    ProgressBarError;
    MessageDlg(rsFileNotFound+' - '+PGRestorePath+CRLF+rsErrDBImport3+'!',mtError, [mbOK], 0);
  end;

  if Flag then
  begin
    MessageDlg(rsImportDone+'.',mtInformation, [mbOK], 0);
  end;

  Result:=Flag;

end;

procedure TImportDBForm.ProgressBarError;
begin
//  ProgressBar.State:=pbsError;
  Application.ProcessMessages;
end;

procedure TImportDBForm.ProgressBarStart(aText: String);
begin
  ProgressBar.Visible:=True;
//  ProgressBar.State:=pbsNormal;
  ProgressBar.Position:=25;
  ProgressBar.Update;
  sleep(100);
  LblProgressBar.Visible:=True;
  LblProgressBar.Caption:=aText;
  Application.ProcessMessages;
end;

procedure TImportDBForm.ProgressBarStop;
begin
  ProgressBar.Position:=100;
end;

procedure TImportDBForm.SetDBName(aName: String);
begin
  FDBName:=aName;
end;

procedure TImportDBForm.SpeedBtnOpenFileClick(Sender: TObject);
begin
  if OpenDialogBackupFile.Execute then
  begin
    FBackupFileName:=OpenDialogBackupFile.FileName;
    EditImportPath.Text:=FBackupFileName;
    LblBackupFileName.Visible:=false;
  end;
end;

end.
