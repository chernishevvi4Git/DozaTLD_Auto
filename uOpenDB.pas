unit uOpenDB;

interface

uses
 
  LCLType,
  SysUtils, Variants, Classes,System.UITypes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls,
  DBGrids, DB, SQLDB,
  uImportDBForm,
  uConst,
  uEnterDBName,
  uDataModule,
  uLanguages,
  ComCtrls, StdCtrls, Menus, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, GridsEh, DBAxisGridsEh, DBGridsEh;

type
  TOnUpdateOpenGrid = procedure of object;
  TOnCheckDBConnection = procedure of object;

  { TOpenDB }

  TOpenDB = class(TForm)
    PanelDBGrid: TPanel;
    DataSourceOpenDB: TDataSource;
    StatusBar: TStatusBar;
    PanelBtn: TPanel;
    OpenDialog: TOpenDialog;
//    ProgressBar: TProgressBar;
    SaveDialog: TSaveDialog;
    ADOQuery: TSQLQuery;
    BtnRestoreDB: TButton;
    DBGridEhOpenDB: TDBGridEh;
    procedure FormShow(Sender: TObject);
    procedure DBGridOpenDBCellClick(Column: TColumn);
    procedure BtnOpenClick(Sender: TObject);
    procedure BtnCreateClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnExportClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridOpenDBKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridOpenDBDblClick(Sender: TObject);
    procedure DBGridEhOpenDBCellClick(Column: TColumnEh);
    procedure BtnRestoreDBClick(Sender: TObject);
    procedure DBGridEhOpenDBKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridEhOpenDBDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);

  private
    FDBName: String;
    FOnUpdateOpenGrid: TOnUpdateOpenGrid;
    FOnCheckDBConnection: TOnCheckDBConnection;
    function GetValForQuery: boolean;
    procedure DBGridClick;

//    procedure ProgressBarStart(aText: String);
//    procedure ProgressBarStop;
//    procedure ProgressBarError;
    procedure OpenDB;
    procedure CreateDB;

    procedure ExportDB;
    procedure ImportDB;
    procedure SetOnUpdateOpenGrid(aOnUpdateOpenGrid: TOnUpdateOpenGrid);
    procedure SetOnCheckDBConnection(aOnCheckDBConnection: TOnCheckDBConnection);
    { Private declarations }
  public
    RestoreState: integer;

    function GetDBGridStringNumber(aNAme: String): integer;       // функция получения индекса строки
    procedure DeleteDB;
    procedure RefreshDBList;
    procedure DBGridSetFocus(aLine: integer);      // выделяем нужную строку в таблице
    property IsCorrectValForQuery: boolean read GetValForQuery;
    property OnUpdateOpenGrid: TOnUpdateOpenGrid read FOnUpdateOpenGrid write SetOnUpdateOpenGrid;
    property OnCheckDBConnection: TOnCheckDBConnection read FOnCheckDBConnection write SetOnCheckDBConnection;
    { Public declarations }
  end;

const
  CRLF = #13#10;

var
  OpenDB: TOpenDB;

implementation

uses
  uFunctions,
  uMainForm;

{$R *.dfm}

function TOpenDB.GetDBGridStringNumber(aName: String): integer;
var
  i: integer;
  Flag: boolean;
begin
  Flag:=False;
  DBGridEhOpenDB.DataSource.DataSet.First;
  for i := 0 to DBGridEhOpenDB.DataSource.DataSet.RecordCount-1 do
  begin
    if DBGridEhOpenDB.DataSource.DataSet.FieldByName('datname').AsString = aName then
    begin
      Flag:=true;
      break;
    end;
    DBGridEhOpenDB.DataSource.DataSet.Next;
  end;

  if Flag then
    result:=i+1
  else
    result:=-1;
end;

function TOpenDB.GetValForQuery: boolean;
begin
  FDBName:=DBGridEhOpenDB.DataSource.DataSet.FieldByName(cDBName).AsString;            // dosimeterid выделенной строки
  if (FDBName<>'') then
    result:=true
  else
    result:=false;
end;

procedure TOpenDB.ImportDB;
var
  PGRestorePath  :  String;
  PGRestoreParam :  String;
  Flag           :  boolean;
  GridLineIndex  :  integer;
begin
  GridLineIndex:=DBGridEhOpenDB.DataSource.DataSet.RecNo;   // запоминаем номер строки в таблице
  Flag:=False;

  if OpenDialog.Execute then
  begin
    PGRestorePath:=TLDDataModule.PGRestorePath;;
    if FileExists(PGRestorePath) then
    begin
      // формируем строку для запуска программы pg_restore для импорта БД
      PGRestoreParam:='--host "'+TLDDataModule.ServerIP+'" '
                     +'--port "'+TLDDataModule.PGPort+'" '
                     +'--username "'+TLDDataModule.PGUid+'" '
                     +'--create '
                     +'--no-password '
                     +'--dbname "'+cPostgreDefaultDB+'://'+TLDDataModule.PGUid+':'+TLDDataModule.PGPass+'@'+TLDDataModule.ServerIP+':'+TLDDataModule.PGPort+'/'+FDBName+'" '
                     +'"'+OpenDialog.FileName+'"';

      // запускаем скрол бар
//      ProgressBarStart('Импорт БД - '+FDBName);

      // через функцию ExecAndWait запускаем программу "pg_restore.exe" для восстановления таблиц и ожидаем ее завершения
      try
//        Flag:=ExecAndWait(PGRestorePath,PGRestoreParam,SW_SHOWNORMAL);
// добавлено - не проверено
        Flag:=ExecAndWait(PGRestorePath,PGRestoreParam,'log',PGRestorePath,SW_SHOWNORMAL);
      except
        on E: Exception do
        begin
//          ProgressBarError;
          DBGridSetFocus(GridLineIndex);  // возвращаемся на запомненную строку
          MessageDlg(E.Message+CRLF+rsErrDBImport+'.',mtError, [mbOK], 0);
        end;
      end;

      // останавливаем скролл бар
 //     ProgressBarStop;

      if Flag then
      begin
        RefreshDBList;
        DBGridSetFocus(GridLineIndex);  // возвращаемся на запомненную строку
        MessageDlg(rsImportDone+'.',mtInformation, [mbOK], 0);
      end;

  //    ProgressBar.Visible:=False;
  //    OnUpdateOpenGrid; // обновление данных в отдельном окне измерений (окно устароело и не используется)
    end
    else
    begin
//      ProgressBarError;
      DBGridSetFocus(GridLineIndex);  // возвращаемся на запомненную строку
      MessageDlg(rsFileNotFound2+' - '+PGRestorePath+CRLF+rsErrDBImport+'!',mtError, [mbOK], 0);
    end;
  end;

end;

procedure TOpenDB.OpenDB;
var
  GridLineIndex: integer;
begin
  // запускаем скрол бар
  GridLineIndex:=DBGridEhOpenDB.DataSource.DataSet.RecNo;     // запоминаем позицию строки
//  ProgressBarStart('Открытие БД - '+FDBName);
  TLDDataModule.ConnectToDB(FDBName);
  // останавливаем скролл бар
//  ProgressBarStop;
//  ProgressBar.Visible:=False;
  OnCheckDBConnection;
//  OnUpdateOpenGrid;         // вызываем событие обновления окна результатов измерений - устарело, не используется
  RefreshDBList;
  DBGridSetFocus(GridLineIndex);                            // возвращаемся на запомненную строку
//  MainForm.LoadFilters;
end;

//procedure TOpenDB.ProgressBarError;
//begin
////  ProgressBar.State:=pbsError;
//  Application.ProcessMessages;
//end;

//procedure TOpenDB.ProgressBarStart(aText: String);
//begin
////  ProgressBar.Visible:=True;
////  ProgressBar.State:=pbsNormal;
////  ProgressBar.Position:=25;
////  ProgressBar.Update;
//  sleep(100);
//  StatusBar.Panels[0].Text:=aText;
//  Application.ProcessMessages;
//end;

//procedure TOpenDB.ProgressBarStop;
//begin
////  ProgressBar.Position:=100;
//end;

procedure TOpenDB.RefreshDBList;
var
  indicatorColWidth: integer;

begin
  if not TLDDataModule.IsConnected then
  begin
    TLDDataModule.ConnectToDB(cPostgreDefaultDB);
  end;

  // получаем список доступных баз данных, с нумерацией по порядку, за исключением предустановленных баз (postgres, template1, template0)
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('select datname '
                        +'from pg_database where '
                        +'(datname <> '+#39+'User'+#39+') AND '
                        +'(datname <> '+#39+'postgres'+#39+') AND '
                        +'(datname <> '+#39+'template1'+#39+') AND '
                        +'(datname <> '+#39+'template0'+#39+') ORDER BY datname');
  ADOQuery.Open;

  indicatorColWidth:=DBGridEhOpenDB.CalcIndicatorColWidth+DBGridEhOpenDB.VertScrollBar.Width+23;

  DBGridEhOpenDB.Columns[DBGridEhOpenDB.DataSource.DataSet.FieldByName('datname').Index].Width:=DBGridEhOpenDB.Width-indicatorColWidth;
  DBGridEhOpenDB.Columns[DBGridEhOpenDB.DataSource.DataSet.FieldByName('datname').Index].Title.caption:=' '+'Название базы данных';
  DBGridEhOpenDB.DataSource.DataSet.Last;
  DBGridEhOpenDB.SetFocus;
  DBGridEhOpenDBCellClick(DBGridEhOpenDB.Columns[DBGridEhOpenDB.DataSource.DataSet.FieldByName('datname').Index]);

//  DBGridSetFocus(GetDBGridStringNumber(TLDDataModule.DBName));  // устанавливаем фокус на открытую БД

//  ADOQuery.Close;
end;

procedure TOpenDB.SetOnCheckDBConnection(aOnCheckDBConnection: TOnCheckDBConnection);
begin
  FOnCheckDBConnection:=aOnCheckDBConnection;
end;

procedure TOpenDB.SetOnUpdateOpenGrid(aOnUpdateOpenGrid: TOnUpdateOpenGrid);
begin
  FOnUpdateOpenGrid:=aOnUpdateOpenGrid;
end;

procedure TOpenDB.BtnCreateClick(Sender: TObject);
begin
  CreateDB;
end;

procedure TOpenDB.BtnDelClick(Sender: TObject);
begin
  DeleteDB;
end;

procedure TOpenDB.BtnExportClick(Sender: TObject);
begin
  ExportDB;
end;

procedure TOpenDB.BtnImportClick(Sender: TObject);
begin
  ImportDBForm.ShowModal;
end;

procedure TOpenDB.BtnOpenClick(Sender: TObject);
begin
  OpenDB;

  if MainForm.IsValidDBVersion then
  begin
    MainForm.ResetDosimeterData;
    MainForm.PageControlMain.ActivePageIndex:=cPageMeasIndex;
    MainForm.UpdateGridPageStart;
//    MainForm.PageControlGrid.OnChange(Self);
//    MainForm.PageControlMain.OnChange(Self);
    Close;
  end
  else
  begin
    MainForm.Close;
  end;

end;

procedure TOpenDB.BtnRestoreDBClick(Sender: TObject);
begin
  RestoreState:=MainForm.RestoreDBFromBackup(DBGridEhOpenDB.DataSource.DataSet.FieldByName(cDBName).AsString);
  case RestoreState of
   -1: Close;
    0: Close;
  end;
end;

procedure TOpenDB.CreateDB;
var
  DBName   : String;
begin
  EnterDBName:=TEnterDBName.Create(Self);
  EnterDBName.ShowModal;
  DBName:=EnterDBName.Name;

  if EnterDBName.OkBtn then
  begin
    // запуcкаем скрол бар
//    ProgressBarStart('Создание БД - '+DBName);
    if not TLDDataModule.IsDBExist(DBName) then
    begin
      TLDDataModule.CreateDB(DBName,false);
      RefreshDBList;
      // останавливаем скролл бар
//      ProgressBarStop;

      if TLDDataModule.IsDBExist(DBName) then           // проверяем удалось ли создать БД
      begin                                             // если успешно
        DBGridSetFocus(GetDBGridStringNumber(DBName));  // устанавливаем фокус на созданную БД
        OpenDB;                                         // открываем созданную БД
        MainForm.ResetDosimeterData;                      // сбрасываем текущие набранные измерения
        MainForm.PageControlMain.ActivePageIndex:=cPageMeasIndex;
        MainForm.UpdateGridPageStart;
//        Close;                                          // закрываем окно
        ShowMessage(format(rsDBCreated,[DBName]));
      end
      else
      begin                                             // если создать БД не удалось
        DBGridEhOpenDB.DataSource.DataSet.First;          // переводим курсор на первую запись
        DBGridSetFocus(DBGridEhOpenDB.DataSource.DataSet.RecNo);  // делаем "клик" по этой записи
        ShowMessage(format(rsErrDBCreated,[DBName]));
      end;
    end
    else
    begin
//      ProgressBarError;
      ShowMessage(rsErrDBExists);
    end;

//    ProgressBar.Visible:=False;
  end;

  EnterDBName.Free;

end;

procedure TOpenDB.DBGridClick;
begin
  if IsCorrectValForQuery then
    StatusBar.Panels[0].Text:=rsDataBase + ' - '+FDBName;
end;

procedure TOpenDB.DBGridEhOpenDBCellClick(Column: TColumnEh);
begin
  DBGridClick;
end;

procedure TOpenDB.DBGridEhOpenDBDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  if TDBGridEh(Sender).SelectedRows.CurrentRowSelected=true then
  begin
    TDBGridEh(Sender).Canvas.Pen.Color:=clBlack;
    TDBGridEh(Sender).Canvas.Pen.Width:=cPenStrikeoutWidth;
    TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top);
    TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top);
    TDBGridEh(Sender).Canvas.MoveTo(Rect.Left, Rect.Top + Rect.Height-1);
    TDBGridEh(Sender).Canvas.LineTo(Rect.Right, Rect.Top + Rect.Height-1);
  end;
end;

procedure TOpenDB.DBGridEhOpenDBKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = VK_UP) OR
     (Key = VK_DOWN) OR
     (Key = VK_END) OR
     (Key = VK_HOME) OR
     (Key = VK_PRIOR) OR
     (Key = VK_NEXT)) then
  begin
    if NOT (ssShift in Shift) then
    begin
      TDBGridEh(Sender).SelectedRows.Clear;
      TDBGridEh(Sender).SelectedRows.CurrentRowSelected:=true;
      DBGridClick;
    end;
  end;
end;

procedure TOpenDB.DBGridOpenDBCellClick(Column: TColumn);
begin
  DBGridClick;
end;

procedure TOpenDB.DBGridOpenDBDblClick(Sender: TObject);
begin
  OpenDB;
  MainForm.ResetDosimeterData;
  Close;
end;

procedure TOpenDB.DBGridOpenDBKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  DBGridClick;
end;

procedure TOpenDB.DBGridSetFocus(aLine: integer);
begin
  if aLine>0 then
  begin
    DBGridEhOpenDB.DataSource.DataSet.RecNo:=aLine;
    DBGridClick;
  end;
end;

procedure TOpenDB.DeleteDB;
var
  DBName      : String;
  BtnSelected : Integer;
begin
  DBName:=FDBName;

  BtnSelected:=MessageDlg(format(rsDeleteDBAsk,[DBName]),mtWarning, mbOKCancel, 0);
  if BtnSelected = mrOK then
  begin
  // запуcкаем скрол бар
//    ProgressBarStart('Удаление БД - '+DBName);
    try
  // закрываем текущие сессии
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('SELECT pg_terminate_backend(pg_stat_activity.pid) '
                            +'FROM pg_stat_activity '
                            +'WHERE pg_stat_activity.datname = '+#39+DBName+#39+' AND pid <> pg_backend_pid();COMMIT;');
      ADOQuery.ExecSQL;

  // удаляем базу
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('DROP DATABASE '+DBName);
      ADOQuery.ExecSQL;
    except
      on E: Exception do
        showmessage(E.Message);

    end;

  // останавливаем скролл бар
  //  ProgressBarStop;

    RefreshDBList;

  // проверяем удалось ли удалить базу
    if not TLDDataModule.IsDBExist(DBName) then
      ShowMessage(rsDataBase + ' '+DBName+' - ' + rsDeleteDone)
    else
      ShowMessage(rsErrDeleteDB + ' - '+DBName);

//    ProgressBar.Visible:=False;

  end;

end;

procedure TOpenDB.ExportDB;
var
  PGDumpPath     :  String;
  PGDumpParam    :  String;
  Flag           :  boolean;
  GridLineIndex  :  integer;
begin
  GridLineIndex:=DBGridEhOpenDB.DataSource.DataSet.RecNo;   // запоминаем номер строки в таблице
  Flag:=False;

  if SaveDialog.Execute then
  begin
    PGDumpPath:=TLDDataModule.PGDumpPath;
    if FileExists(PGDumpPath) then
    begin
      // формируем строку для запуска программы pg_dump для импорта БД
      PGDumpParam:='--host "'+TLDDataModule.ServerIP+'" '
                  +'--port "'+TLDDataModule.PGPort+'" '
                  +'--username "'+TLDDataModule.PGUid+'" '
                  +'--dbname "'+cPostgreDefaultDB+'://'+TLDDataModule.PGUid+':'+TLDDataModule.PGPass+'@'+TLDDataModule.ServerIP+':'+TLDDataModule.PGPort+'/'+FDBName+'" '
                  +'--verbose '
                  +'--format=c '
                  +'--blobs '
                  +'--encoding=UTF8 '
                  +'--file='+Format('"%s"',[SaveDialog.FileName]);

      // запучкаем скрол бар
      //ProgressBarStart('Экспорт в БД - '+FDBName);

      // через функцию ExecAndWait запускаем программу "pg_dump.exe" для восстановления таблиц и ожидаем ее завершения
      try
        Flag:=ExecAndWait(PGDumpPath,PGDumpParam,cExport,ExtractFilePath(Application.ExeName)+cDatraBaseLog,SW_SHOWNORMAL);
      except
        on E: Exception do
        begin
        //  ProgressBarError;
          DBGridSetFocus(GridLineIndex);  // возвращаемся на запомненную строку
          MessageDlg(E.Message+CRLF + rsExportImpossible+'!',mtError, [mbOK], 0);
        end;
      end;

      // останавливаем скролл бар
      //ProgressBarStop;

      if Flag then
      begin
        RefreshDBList;
        DBGridSetFocus(GridLineIndex);                                // возвращаемся на запомненную строку
        MessageDlg(rsExportDone+CRLF+SaveDialog.FileName,mtInformation, [mbOK], 0);
      end;

//      ProgressBar.Visible:=False;
    end
    else
    begin
      //ProgressBarError;
      DBGridSetFocus(GridLineIndex);  // возвращаемся на запомненную строку
      MessageDlg(rsFileNotFound2 + ' - '+PGDumpPath + CRLF + rsExportImpossible + '!',mtError, [mbOK], 0);
    end;
  end;

end;

procedure TOpenDB.FormCreate(Sender: TObject);
begin
  OnCheckDBConnection:=@MainForm.CheckDBConnection;
end;

procedure TOpenDB.FormShow(Sender: TObject);
begin
  RestoreState:=-1;
  RefreshDBList;                                                // обновляем список БД
//  DBGridSetFocus(GetDBGridStringNumber(TLDDataModule.DBName));  // устанавливаем фокус на открытую БД
end;

end.
