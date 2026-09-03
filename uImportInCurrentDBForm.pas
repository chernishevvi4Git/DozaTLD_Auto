unit uImportInCurrentDBForm;

interface

uses

  LCLType,
  SysUtils,System.UITypes, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TImportInCurrentDBForm = class(TForm)
    OpenDialogBackupFile: TOpenDialog;
    BtnClose: TButton;
    BtnOk: TButton;
    ProgressBar: TProgressBar;
    SpeedBtnOpenFile: TSpeedButton;
    EditImportPath: TEdit;
    LblProgressBar: TLabel;
    LblBackupFileNameErr: TLabel;
    PanelClient: TPanel;
    PanelBottom: TPanel;
    GroupBoxImport: TGroupBox;
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedBtnOpenFileClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    FDBName: String;
    FDBExt: String;
    FBackupFileName: String;
    function CheckName(Value: String): integer;
    function Import(Value: String): boolean;
    procedure SetDBName(Value: String);
    procedure ProgressBarStart(Value: String);
    procedure ProgressBarStop;
    procedure ProgressBarError;
    { Private declarations }
  public
    { Public declarations }
    property DBName: String read FDBName write SetDBName;
  end;

const
  cErrEmpty   = 1;
  cErrNumber  = 2;
  cOk         = 0;

var
  ImportInCurrentDBForm: TImportInCurrentDBForm;

implementation
uses
  uConst,
  uLog,
  uMainForm,
  uFunctions,
  uDataModule,
  uLanguages;
{$R *.dfm}

{ TImportInCurrentDBForm }

procedure TImportInCurrentDBForm.Button3Click(Sender: TObject);
const
  cErrorExit = 1000;
var
  dbExist: boolean;
  cnt: integer;
  backupName: String;
begin
  dbExist:=true;
  cnt:=1;

  while dbExist do
  begin
    if TLDDataModule.IsDBExist(Format('%s_%d',[cDefaultDB,cnt])) then
    begin
      dbExist:=true;
      inc(cnt);
      if cnt>cErrorExit then dbExist:=false;
    end
    else
    begin
      dbExist:=false;
      backupName:=Format('%s_%d',[cDefaultDB,cnt]);
    end;
  end;

  TLDDataModule.ConnectToDefaultDB;

  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add(Format('ALTER DATABASE "%s" RENAME TO "%s";',[cDefaultDB,backupName]));
  TLDDataModule.ADOQuery.ExecSQL;
end;

function TImportInCurrentDBForm.CheckName(Value: String): integer;
var
  n: integer;
begin
  if Value='' then
    result:=cErrEmpty   // пустая строка
  else if TryStrToInt(Value[1],n) then
    result:=cErrNumber  // первый символ - цифра
  else
    result:=cOk;
end;

procedure TImportInCurrentDBForm.FormCreate(Sender: TObject);
begin
  Caption:=rsImportDB2;
  FBackupFileName:='';
end;

procedure TImportInCurrentDBForm.FormShow(Sender: TObject);
begin
  ProgressBar.Visible:=False;
  LblBackupFileNameErr.Visible:=False;
  LblProgressBar.Visible:=False;
  FBackupFileName:='';
  DBName:='';
  EditImportPath.Text:='';
  BtnOk.Enabled:=True;
end;
{
function TImportInCurrentDBForm.Import(Value: String): boolean;
var
  PGRestorePath  :  String;
  PGRestoreParam :  String;
  Flag           :  boolean;
begin
  Flag:=False;

  PGRestorePath:=TLDDataModule.PGRestorePath;;
  if FileExists(PGRestorePath) then
  begin
    TLDDataModule.Reconnect(cPostgreDefaultDB);

    PGRestoreParam:='-d '+cPostgreDefaultDB+'://'+cPostgreDefaultDB+':'+TLDDataModule.PGPass+'@'+TLDDataModule.ServerIP+':'+TLDDataModule.PGPort+'/'+cPostgreDefaultDB+' '
                   +'-c ' // очистка существующей БД
                   +'--create ' //
                   +'-v "'+FBackupFileName+'"';

    // запускаем скрол бар
    ProgressBarStart(rsImportDB+' - '+FBackupFileName);

    // через функцию ExecAndWait запускаем программу "pg_restore.exe" для восстановления таблиц и ожидаем ее завершения
    try
      Flag:=ExecAndWait(PGRestorePath,PGRestoreParam,cImport,ExtractFilePath(Application.ExeName)+cDatraBaseLog,SW_SHOWNORMAL);
    except
      on E: Exception do
      begin
        Flag:=false;
        ProgressBarError;
        MessageDlg(E.Message+cCRLF+rsErrDBImport3+'.',mtError, [mbOK], 0);
      end;
    end;

    // останавливаем скролл бар
    ProgressBarStop;

  end
  else
  begin
    ProgressBarError;
    MessageDlg(rsFileNotFound2+' - '+PGRestorePath+cCRLF+rsErrDBImport3+'!',mtError, [mbOK], 0);
    WriteLog(Format('%s "%s".%s "%s"',[rsErrDBImport2,dbName,rsFileNotFound,PGRestorePath]));
  end;

  if Flag then
  begin
    MessageDlg(rsImportDone+'.',mtInformation, [mbOK], 0);
    WriteLog(Format('%s "%s"',[rsDBImportDone2,FBackupFileName]));
  end;

  Result:=Flag;
end;
}


function TImportInCurrentDBForm.Import(Value: String): boolean;
var
  programRestorePath  :  string;
  programRestoreParam :  string;
  scripFileString     :  string;
  execFileName        :  string;
  flag                :  boolean;
  OutString           :  string;
  T                   :  TextFile;
begin
  flag:=False;

  if FDBExt = cPGExt then
  begin
    programRestorePath:=TLDDataModule.PGRestorePath;
    programRestoreParam:='-d '+cPostgreDefaultDB+'://'+cPostgreDefaultDB+':'+TLDDataModule.PGPass+'@'+TLDDataModule.ServerIP+':'+TLDDataModule.PGPort+'/'+cPostgreDefaultDB+' '
                   +'-c ' // очистка существующей БД
                   +'--create ' //
                   +'-v "'+FBackupFileName+'"';
    {$IFDEF MSWINDOWS}
    {$ELSE}
    execFileName:=ExtractFilePath(Application.ExeName)+ChangeFileExt(ExtractFileName(Application.ExeName),'')+'_run_command.sh';
    AssignFile(T, execFileName);
    Rewrite(T);
    Writeln(T,programRestorePath+' '+programRestoreParam);
    CloseFile(T);
    programRestorePath:=execFileName;
    programRestoreParam:=FBackupFileName;
    {$ENDIF}
  end
  else if FDBExt = cExtSQL then
  begin
    {$IFDEF MSWINDOWS}
    programRestorePath:=ExtractFilePath(Application.ExeName)+ChangeFileExt(ExtractFileName(Application.ExeName),'')+'_run_command.bat';
    programRestoreParam:='';
    scripFileString := 'chcp 65001'+#13#10
                      +'set PG_HOST='+TLDDataModule.ServerIP+#13#10
                      +'set PG_PORT='+TLDDataModule.PGPort+#13#10
                      +'set PG_USER='+TLDDataModule.PGUid+#13#10
                      +'set PGPASSWORD='+TLDDataModule.PGPass+#13#10
                      +'set DB_NAME='+cDefaultDB+#13#10
                      +'psql -h %PG_HOST% -p %PG_PORT% -U %PG_USER% -c "DROP DATABASE %DB_NAME%;"'+#13#10
                      +'psql -h %PG_HOST% -p %PG_PORT% -U %PG_USER% -c "CREATE DATABASE %DB_NAME%;"'+#13#10
                      +'psql -h %PG_HOST% -p %PG_PORT% -U %PG_USER% -d %DB_NAME% -f ';

    AssignFile(T, programRestorePath);
    Rewrite(T);
    Writeln(T,scripFileString+' '+'"'+FBackupFileName+'"');
    CloseFile(T);
    {$ELSE}
    programRestorePath:=ExtractFilePath(Application.ExeName)+ChangeFileExt(ExtractFileName(Application.ExeName),'')+'_run_command.sh';
    programRestoreParam:='';

    scripFileString := 'psql -h '+TLDDataModule.ServerIP+' -p '+TLDDataModule.PGPort+' -U '+TLDDataModule.PGUid+' -c "DROP DATABASE '+cDefaultDB+';"'+#13#10
                       +'psql -h '+TLDDataModule.ServerIP+' -p '+TLDDataModule.PGPort+' -U '+TLDDataModule.PGUid+' -c "CREATE DATABASE '+cDefaultDB+';"'+#13#10
                       +'psql -h '+TLDDataModule.ServerIP+' -p '+TLDDataModule.PGPort+' -U '+TLDDataModule.PGUid+' -d '+cDefaultDB+' -f ';

    AssignFile(T, programRestorePath);
    Rewrite(T);
    Writeln(T,scripFileString+' '+'"'+FBackupFileName+'"');
    CloseFile(T);
    {$ENDIF}
  end
  else
  begin
    Result:=false;
    ProgressBarError;
    MessageDlg(rsErrDBImport3+'.',mtError, [mbOK], 0);
    exit;
  end;

  if FileExists(programRestorePath) then
  begin
    ProgressBarStart(rsImportDB+' - '+FBackupFileName);

    // через функцию ExecAndWait запускаем программу "pg_restore.exe" для восстановления таблиц и ожидаем ее завершения или .bat/.sh если грузим .sql
    try
      TLDDataModule.Reconnect(cPostgreDefaultDB);
      {$IFDEF MSWINDOWS}
      Flag:=ExecAndWait(programRestorePath,programRestoreParam,cImport,ExtractFilePath(Application.ExeName)+cDatraBaseLog,SW_SHOWNORMAL);
      {$ELSE}
      Flag:=ExecSh(programRestorePath,programRestoreParam,cImport,ExtractFilePath(Application.ExeName)+cDatraBaseLog,SW_SHOWNORMAL);
      {$ENDIF}
    except
      on E: Exception do
      begin
        Flag:=false;
        ProgressBarError;
        MessageDlg(E.Message+cCRLF+rsErrDBImport3+'.',mtError, [mbOK], 0);
      end;
    end;

    // останавливаем скролл бар
    ProgressBarStop;

  end
  else
  begin
    ProgressBarError;
    MessageDlg(rsFileNotFound2+' - '+programRestorePath+cCRLF+rsErrDBImport3+'!',mtError, [mbOK], 0);
    WriteLog(Format('%s "%s".%s "%s"',[rsErrDBImport2,dbName,rsFileNotFound,programRestorePath]));
  end;

  if Flag then
  begin
    MessageDlg(rsImportDone+'.',mtInformation, [mbOK], 0);
    WriteLog(Format('%s "%s"',[rsDBImportDone2,FBackupFileName]));
  end;

  Result:=Flag;
end;

procedure TImportInCurrentDBForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TImportInCurrentDBForm.BtnOkClick(Sender: TObject);
const
  cErrorExit        = 10000;
var
  validDBName       : boolean;
  dbExist           : boolean;
  cnt               : integer;
  strCnt            : String;
  backupName        : String;
  currentDBComment  : String;
begin
  BtnOk.Enabled:=false;

  if TLDDataModule.IsDBConnected then
  begin

    validDBName:=false;

    ProgressBarStart(rsImportDB+' - '+DBName);

    case CheckName(DBName) of
      cOk:
      begin
        LblBackupFileNameErr.Caption:='';
        LblBackupFileNameErr.Visible:=False;
        validDBName:=true;
      end;
      cErrEmpty:
      begin
        LblBackupFileNameErr.Caption:=rsInputName+'!';
        LblBackupFileNameErr.Visible:=True;
      end;
      cErrNumber:
      begin
        LblBackupFileNameErr.Caption:=rsErrNameCiphFirst+'!';
        LblBackupFileNameErr.Visible:=True;
      end;
    end;

    if validDBName then
    begin
      WriteLog(Format('%s "%s"',[rsDBFileImportDone,FBackupFileName]));

      dbExist:=true;
      cnt:=1;

      while dbExist do
      begin
        if cnt < 10 then
          strCnt:=Format('0%d',[cnt])
        else
         strCnt:=Format('%d',[cnt]);

        if TLDDataModule.IsDBExist(Format('%s_%s_%s',[cDefaultDB,cBackup,strCnt])) then
        begin
          dbExist:=true;
          inc(cnt);
          if cnt>cErrorExit then dbExist:=false;
        end
        else
        begin
          dbExist:=false;
          if cnt < 10 then
            strCnt:=Format('0%d',[cnt])
          else
           strCnt:=Format('%d',[cnt]);

          backupName:=Format('%s_%s_%s',[cDefaultDB,cBackup,strCnt]);
        end;
      end;

      if cnt<cErrorExit then
      begin

        currentDBComment:=TLDDatamodule.GetDataBaseComment(cDefaultDB);

        if TLDDataModule.CopyDB(cDefaultDB,backupName) then
        begin

          if currentDBComment<>'' then
            TLDDataModule.UpdateDBComment(backupName,currentDBComment)
          else
            TLDDataModule.UpdateDBComment(backupName,DateTimeToStr(Now)+' backup');

          if FileExists(FBackupFileName) then
          begin
            if TLDDataModule.IsDBExist(cDefaultDB) then
            begin
              ProgressBarStop;

              if Import(cDefaultDB) then
              begin
                TLDDataModule.UpdateDBComment(cDefaultDB,DBName);
                TLDDataModule.ConnectToDB(cDefaultDB);

                if MainForm.IsValidDBVersion then
                begin
                  MainForm.ResetDosimeterData;                      // сбрасываем текущие набранные измерения
//                  MainForm.PageControlMain.ActivePageIndex:=cPageMeasIndex;
                  MainForm.UpdateGridPageStart;
                  MainForm.PageControlSettings.ActivePage:=MainForm.TabSheetDataBase;
                  Close;
                end
                else
                begin
                  MainForm.Close;
                end;
              end
              else
              begin
                TLDDataModule.ConnectToDB(cDefaultDB);
                ProgressBarError;
                LblBackupFileNameErr.Caption:=rsErrDBImport3;
                LblBackupFileNameErr.Visible:=True;
                WriteLog(Format('%s "%s"',[rsErrDBFileImport,FBackupFileName]));
                BtnOk.Enabled:=true;
              end;
            end
            else
            begin
              WriteLog(Format(rsErrDBCreated,[DBName]));
              MessageDlg(Format(rsErrDBCreated,[DBName]),mtError, [mbOK], 0);
              BtnOk.Enabled:=true;
            end;
          end
          else
          begin
            LblBackupFileNameErr.Caption:=rsFileNotFound2;
            LblBackupFileNameErr.Visible:=True;
            WriteLog(Format('%s "%s".%s',[rsErrDBFileImport,FBackupFileName,rsFileNotFound2]));
            BtnOk.Enabled:=true;
          end;

          MainForm.RefreshDBList;
          MainForm.CheckDBCommentEdit;
        end
        else
        begin
          ProgressBarError;
          LblBackupFileNameErr.Caption:=rsErrDBImport3;
          LblBackupFileNameErr.Visible:=True;
          WriteLog(Format('%s "%s"',[rsErrDBFileImport,FBackupFileName]));
          BtnOk.Enabled:=true;
        end;
      end
      else
      begin
        ProgressBarError;
        LblBackupFileNameErr.Caption:=rsError+'. '+rsErrCreateDBReserved;
        WriteLog(Format('%s "%s".%s',[rsErrDBFileImport,FBackupFileName,rsBkErr]));
        LblBackupFileNameErr.Visible:=True;
        BtnOk.Enabled:=true;
      end;
    end
    else
    begin
      LblBackupFileNameErr.Caption:=rsErrDBName;
      LblBackupFileNameErr.Visible:=True;
      WriteLog(Format('%s "%s".%s',[rsErrDBFileImport,FBackupFileName,rsErrDBName2]));
      BtnOk.Enabled:=true;
    end;
  end
  else
  begin
    ProgressBarError;
    LblBackupFileNameErr.Caption:=Format('%s - %s',[rsErrDBConnection,cDefaultDB]);
    LblBackupFileNameErr.Visible:=True;
    BtnOk.Enabled:=true;
  end;
end;

procedure TImportInCurrentDBForm.ProgressBarError;
begin
//  ProgressBar.State:=pbsError;
  Application.ProcessMessages;
end;

procedure TImportInCurrentDBForm.ProgressBarStart(Value: String);
begin
  ProgressBar.Visible:=True;
//  ProgressBar.State:=pbsNormal;
  ProgressBar.Position:=25;
  ProgressBar.Update;
  sleep(100);
  LblProgressBar.Visible:=True;
  LblProgressBar.Caption:=Value;
  Application.ProcessMessages;
end;

procedure TImportInCurrentDBForm.ProgressBarStop;
begin
  ProgressBar.Position:=100;
end;

procedure TImportInCurrentDBForm.SetDBName(Value: String);
begin
  FDBName:=Value;
end;

procedure TImportInCurrentDBForm.SpeedBtnOpenFileClick(Sender: TObject);
begin
  if OpenDialogBackupFile.Execute then
  begin
    FBackupFileName:=OpenDialogBackupFile.FileName;
    FDBExt:=ExtractFileExt(FBackupFileName);
    DBName:=StringReplace(ExtractFileName(FBackupFileName),FDBExt,'',[]);
    EditImportPath.Text:=FBackupFileName;
    LblBackupFileNameErr.Visible:=false;
    LblProgressBar.Visible:=false;
  end;
end;

end.

