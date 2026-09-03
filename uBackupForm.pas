unit uBackupForm;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ELSE}
  {$ENDIF}
  Messages, SysUtils,System.UITypes, Variants, Classes, DateUtils ,Graphics,
  Controls, Forms, Dialogs, Inifiles,LCLType;

type
  TBackupForm = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FODBCDriver       : String;     // строка подключения к ODBC драйверу
    FServerIP         : String;
    FPGPass           : String;
    FPGPort           : String;
    FPGUid            : String;
    FPGRestorePath    : String;     // путь к утилите импорта БД - pg_restore.exe
    FPGDumpPath       : String;     // путь к утилите экспорта БД - pg_dump.exe
    FPGBackupPath     : String;     // путь к папке с бекапами
    FPGBackupDays     : integer;    // промежуток между бекапами в днях
    FPGTime           : TDateTime;  // время последнего запуска ПО
    procedure ReadConfigIni;
    procedure WriteBackupTime;
  public
    { Public declarations }
    procedure CircleBackupDB(DBName: String);
    function BackupDB(DBName: String): boolean;
  end;

var
  BackupForm: TBackupForm;

implementation
{$R *.dfm}
uses
  uLog,
  uLanguages,
  uFunctions,
  uConst;
{ TBackupForm }
{
function ExecAndWait(const FileName,
                     Params: String;
                     const WinState: Word): boolean; export;
var
  StartInfo : TStartupInfo;
  ProcInfo  : TProcessInformation;
  CmdLine   : String;
begin
  CmdLine := '"' + Filename + '" ' + Params;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  with StartInfo do
  begin
    cb := SizeOf(StartInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
  end;
  Result := Win32Check(CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,
                          CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                          PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo));

  if Result then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
end;

function Exec(const FileName,
                     Params: String;
                     const WinState: Word): boolean; export;
var
  StartInfo : TStartupInfo;
  ProcInfo  : TProcessInformation;
  CmdLine   : String;
begin
  CmdLine := '"' + Filename + '" ' + Params;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  with StartInfo do
  begin
    cb := SizeOf(StartInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WinState;
  end;
  Result := Win32Check(CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,
                          CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                          PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo));
end;
}

function TBackupForm.BackupDB(DBName: String): boolean;
var
  pgDumpParam       : String;
  pgBackupFileName  : String;
  backupDBName      : String;
  success           : boolean;
begin

  success:=false;

  backupDBName:=DBName+DeleteDividers(DateTimeToStr(Now));

  pgBackupFileName:=Format('%s%s%s',[FPGBackupPath,backupDBName,cPGExt]);

  if ForceDirectories(FPGBackupPath) then
  begin
    if FileExists(FPGDumpPath) then
    begin
      // формируем строку для запуска программы pg_dump для импорта БД
      pgDumpParam:='--host '+FServerIP+' '
                  +'--port '+FPGPort+' '
                  +'--username "'+FPGUid+'" '
                  +'--dbname "'+cPostgreDefaultDB+'://'+FPGUid+':'+FPGPass+'@'+FServerIP+':'+FPGPort+'/'+DBName+'" '
                  +'--verbose '
                  +'--format=c '
                  +'--blobs '
                  +'--file='+Format('"%s"',[PGBackupFileName]);
      try
//        if not FileExists(pgBackupFileName) then success:=Exec(FPGDumpPath,PGDumpParam,{SW_SHOWNORMAL}SW_HIDE);
        if not FileExists(pgBackupFileName) then
        begin
          success:=ExecAndWait(FPGDumpPath,PGDumpParam,cExport,ExtractFilePath(Application.ExeName)+cDatraBaseLog,SW_SHOWNORMAL);
          //**//ExecuteProcess(FPGDumpPath,PGDumpParam,[]);
          //**//success:=True;
        end;
      except
        on E: Exception do
        begin
          WriteLog(Format('%s%s%s - %s',[E.Message,cCRLF,rsBkErr,DBName]));
          success:=false;
        end;
      end;
    end;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsBkErr,DBName]));
    MessageDlg(Format('%s - %s',[rsBkErr,DBName]),mtWarning, [mbOK], 0);
    success:=false;
  end;

  if success then
    WriteLog(Format('%s - %s',['Создана резервная копия базы данных',pgBackupFileName]))
  else
    WriteLog(Format('%s',['Ошибка создания резервной копии базы данных']));

  Result:=success;

end;

procedure TBackupForm.CircleBackupDB(DBName: String);
var
  success           : boolean;
  pgDumpParam       : String;
  pgBackupFileName  : String;
  pgBk0FileName     : String;
begin
  success:=false;

  pgBackupFileName:=Format('%s%s%s',[FPGBackupPath,DBName,cPGExt]);

  // если прошло больше указанного интервала времени или нет файла бэкапа, то создаем его
  if ForceDirectories(FPGBackupPath) then
  begin
    if (DaysBetween(Now, FPGTime) >= FPGBackupDays) OR not FileExists(pgBackupFileName) then
    begin
      if FileExists(FPGDumpPath) then
      begin
        // формируем строку для запуска программы pg_dump для импорта БД
        pgDumpParam:='--host '+FServerIP+' '
                    +'--port '+FPGPort+' '
                    +'--username "'+FPGUid+'" '
                    +'--dbname "'+cPostgreDefaultDB+'://'+FPGUid+':'+FPGPass+'@'+FServerIP+':'+FPGPort+'/'+DBName+'" '
                    +'--verbose '
                    +'--format=c '
                    +'--blobs '
                    +'--file='+Format('"%s"',[PGBackupFileName]);
        try
          pgBk0FileName:=Format('%s%s%s',[FPGBackupPath,DBName,cPGExt0]);
          // если сущкствует старый второй бэкап .bk0 - удаляем его
          if FileExists(pgBk0FileName) AND FileExists(pgBackupFileName) then DeleteFile(pgBk0FileName);
          // переименовываем текущий бэкап
          if FileExists(pgBackupFileName) then RenameFile(pgBackupFileName,pgBk0FileName);
          // создаем новый бэкап
//          if not FileExists(pgBackupFileName) then success:=Exec(FPGDumpPath,PGDumpParam,{SW_SHOWNORMAL}SW_HIDE);
          if not FileExists(pgBackupFileName) then
          begin
            success:=ExecAndWait(FPGDumpPath,PGDumpParam,cExport,ExtractFilePath(Application.ExeName)+cDatraBaseLog,SW_SHOWNORMAL);
            //**//ExecuteProcess(FPGDumpPath,PGDumpParam,[]);


            //success := true;
          end;

          if success then
          begin
            WriteBackupTime;
            WriteLog(Format('%s - %s',[rsBkSuccess,DBName]));
          end
          else
          begin
            WriteLog(Format('%s - %s',[rsBkErr,DBName]));
            MessageDlg(Format('%s - %s',[rsBkErr,DBName]),mtWarning, [mbOK], 0);
          end;
        except
          on E: Exception do
          begin
            WriteLog(Format('%s%s%s - %s',[E.Message,cCRLF,rsBkErr,DBName]));
          end;
        end;

      end
      else
      begin
        WriteLog(Format('%s - %s. %s: %s',[rsBkErr,DBName,'Не найден файл',FPGDumpPath]));
        MessageDlg(Format('%s - %s. %s: %s',[rsBkErr,DBName,'Не найден файл',FPGDumpPath]),mtWarning, [mbOK], 0);
      end;
    end;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsBkErr,DBName]));
//    MessageDlg(Format('%s - %s',[rsBkErr,DBName]),mtWarning, [mbOK], 0);
  end;

end;

procedure TBackupForm.FormCreate(Sender: TObject);
begin
  ReadConfigIni;
end;

procedure TBackupForm.ReadConfigIni;
var
  ConfigIni: TInifile;
begin
  ConfigIni := TInifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    FODBCDriver:=ConfigIni.ReadString(cSectionDBSettings, cODBCDriver, 'Driver={PostgreSQL ANSI}');
//    FPGPass:=ConfigIni.ReadString(cSectionDBSettings, cPGPass, '2236');
    FPGPass:=ConfigIni.ReadString(cSectionDBSettings, cPGPass, 'doza8485');
    FPGPort:=ConfigIni.ReadString(cSectionDBSettings, cPGPort, '5432');
    FPGUid:=ConfigIni.ReadString(cSectionDBSettings, cPGUid, 'postgres');
    FServerIP:=ConfigIni.ReadString(cSectionDBSettings, cServerIP, 'localhost');
    FPGRestorePath:=ConfigIni.ReadString(cSectionDBSettings, cPGRestorePath, '');
    FPGDumpPath:=ConfigIni.ReadString(cSectionDBSettings, cPGDumpPath, '');
    FPGBackupPath:=ConfigIni.ReadString(cSectionDBSettings, cPGBackupPath, '');
    FPGBackupDays:=ConfigIni.ReadInteger(cSectionDBSettings, cPGBackupDays, 1);
    FPGTime:=ConfigIni.ReadDateTime(cSectionDBSettings, cPGTime,StrToDateTime(cZeroDate));
  finally
    ConfigIni.Free;
  end;
end;

procedure TBackupForm.WriteBackupTime;
var
  ConfigIni: TInifile;
begin
  ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile); // создаем ini файл и пишем туда информацию
  try
    ConfigIni.WriteDateTime(cSectionDBSettings, cPGTime, Now);
  finally
    ConfigIni.Free;
  end;
end;

end.
