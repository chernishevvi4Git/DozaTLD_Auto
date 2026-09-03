program TLD_Auto;

{$MODE OBJFPC}{$H+}
//{$MODE Delphi}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, runtimetypeinfocontrols,
  {$IFDEF MSWINDOWS}
  Windows,
  {$ELSE}
  {$ENDIF}
  { you can add units after this }
  LCLIntf, LCLType, LMessages,
  uMainForm in 'uMainForm.pas' {MainForm},
  uMyComPort in 'uMyComPort.pas',
  uLanguages in 'uLanguages.pas',
  uSeparator in 'uSeparator.pas',
  uVersion in 'uVersion.pas' {VW},
  uSetConnection in 'uSetConnection.pas' {SetW},
  uTLDCommand in 'uTLDCommand.pas',
  uControl in 'uControl.pas' {ControlW},
  uDosimeter in 'uDosimeter.pas',
  uDetector in 'uDetector.pas',
  uStartMF in 'uStartMF.pas' {StartMeasureW},
  uLog in 'uLog.pas',
  uDataModule in 'uDataModule.pas' {TLDDataModule: TDataModule},
  uConst in 'uConst.pas',
  uOpenDB in 'uOpenDB.pas' {OpenDB},
  uEnterDBName in 'uEnterDBName.pas' {EnterDBName},
  uAddUserForm in 'uAddUserForm.pas' {AddUW},
  uChangePassForm in 'uChangePassForm.pas' {UChangePassW},
  uUsersJournalForm in 'uUsersJournalForm.pas' {UJW},
  uLogPassForm in 'uLogPassForm.pas' {AW},
//  uMessageForm in 'uMessageForm.pas' {MSGWindow},
  uFunctions in 'uFunctions.pas',
  uCalcForm in 'uCalcForm.pas' {CalcForm},
  UOptions in 'UOptions.pas' {OptionsForm},
  uDataGeneratorForm in 'uDataGeneratorForm.pas' {GeneratorForm},
  uFinishMF in 'uFinishMF.pas' {FinishMeasureW},
  uImportDosimeters in 'uImportDosimeters.pas' {ImportDosimetersW},
  uImportProcess in 'uImportProcess.pas' {ImportProcessW},
  uModel in 'uModel.pas' {ModelW},
  uBackupForm in 'uBackupForm.pas' {BackupForm},
  uCalibrationForm in 'uCalibrationForm.pas' {CalibrationForm},
  uKDosimeterForm in 'uKDosimeterForm.pas' {KDosimeterForm},
  uImportDBForm in 'uImportDBForm.pas' {ImportDBForm},
  uDetectorConstructorForm in 'uDetectorConstructorForm.pas' {DetectorConstructorForm},
  uReportForm in 'uReportForm.pas' {RW},
  uDosimeterConstructorForm in 'uDosimeterConstructorForm.pas' {DosimeterConstructorForm},
  uSplashScreen in 'uSplashScreen.pas',
  uImportInCurrentDBForm in 'uImportInCurrentDBForm.pas' {ImportInCurrentDBForm},
  uSQLFilterForm in 'uSQLFilterForm.pas' {SQLFilterForm},
  uAddDosInQueue in 'uAddDosInQueue.pas' {AddInQueueW},
  uQueueForm in 'uQueueForm.pas' {QueueForm},
  uDosEditForm in 'uDosEditForm.pas' {SetDosEditForm},
  uDosimeterTypeConstructorForm in 'uDosimeterTypeConstructorForm.pas' {DosimeterTypeConstructorForm},
  uImportMeasForm in 'uImportMeasForm.pas' {ImportMeasForm},
  uUsersManagement in 'uUsersManagement.pas',
  uEnterNewDosTypeForm in 'uEnterNewDosTypeForm.pas' {EnterNewDosTypeForm},
  uEnterNewDetTypeForm in 'uEnterNewDetTypeForm.pas' {EnterNewDetTypeForm},
  uAddDosInCalibr in 'uAddDosInCalibr.pas' {AddInCalibrW},
  uDosimeterPartForm in 'uDosimeterPartForm.pas' {DosimeterPartForm},
  uEnterNewDosPartForm in 'uEnterNewDosPartForm.pas' {EnterNewDosPartForm},
  uWarningComment in 'uWarningComment.pas' {WarningCommentForm},
  uUserWarningCommentForm in 'uUserWarningCommentForm.pas' {UserWarningCommentForm},
  uWarningErrorForm in 'uWarningErrorForm.pas' {WarningErrorW},
  uUserFirstStartForm in 'uUserFirstStartForm.pas' {FormUserFirstStart},
  uExportDosAndSettingsForm in 'uExportDosAndSettingsForm.pas' {ExportDosAndSettingsForm},
  uSendToCalibrForm in 'uSendToCalibrForm.pas' {SendToCalibrW},
  uchangedosnameinmeas in 'uchangedosnameinmeas.pas' {ChangeDosNameInMeasForm};


{$R *.res}
const
  cTMainForm = 'TMainForm';

  {$DEFINE HASAMIGA}

  {$IFDEF MSWINDOWS}
  const
   PathDelim = '\';
  {$ELSE}
  const
   PathDelim = '/';
  {$ENDIF}

var
  k         : integer;
  wnd       : HWND;
  UseMultipleLaunch : boolean;
  MutexName         : PChar;
begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;

  Application.Initialize;

  if (pos('/MULTIPLE_LAUNCH',AppParamString)>0) then
    UseMultipleLaunch := true // признак использования нескольких экземпляров программы на одном ПК
  else
    UseMultipleLaunch := false;

  if not UseMultipleLaunch then
  begin
    MutexName:='{6FBFFF22-6D4C-4246-B08A-94CF23D4433A}';
    {$IFDEF MSWINDOWS}
    CreateMutex(nil,false,MutexName);        // создание мьютекса для отслеживания повторного запуска приложения
    k := GetLastError();
    if (k=ERROR_ALREADY_EXISTS)or(k=ERROR_ACCESS_DENIED) then               // если приложение уже запущено
    begin
      // в Lazarus не работает. Под linux все рано нужно будет искать другое решение
      wnd := FindWindow(cTMainForm,nil);                                    // ищем окно (главную форму) по названию класса окна
      if wnd<>0 then
        SendMessage(wnd,WM_GOTOFOREGROUND,0,0);                             // при этом первая копия будет выведена на передний план
      Application.Terminate;
      Exit;
    end;
    {$ELSE}
    {$ENDIF}
  end;
  Application.Name := 'TLD_Auto';
//  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TTLDDataModule, TLDDataModule);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TVW, VW);
  Application.CreateForm(TSetW, SetW);
  Application.CreateForm(TControlW, ControlW);
  Application.CreateForm(TStartMeasureW, StartMeasureW);
//  Application.CreateForm(TTLDDataModule, TLDDataModule);
  Application.CreateForm(TOpenDB, OpenDB);
  Application.CreateForm(TEnterDBName, EnterDBName);
  Application.CreateForm(TAddUW, AddUW);
  Application.CreateForm(TUChangePassW, UChangePassW);
  Application.CreateForm(TUJW, UJW);
  Application.CreateForm(TAW, AW);
//  Application.CreateForm(TMSGWindow, MSGWindow);
  Application.CreateForm(TCalcForm, CalcForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.CreateForm(TGeneratorForm, GeneratorForm);
  Application.CreateForm(TFinishMeasureW, FinishMeasureW);
  Application.CreateForm(TImportDosimetersW, ImportDosimetersW);
  Application.CreateForm(TImportProcessW, ImportProcessW);
  Application.CreateForm(TModelW, ModelW);
  Application.CreateForm(TBackupForm, BackupForm);
  Application.CreateForm(TCalibrationForm, CalibrationForm);
  Application.CreateForm(TKDosimeterForm, KDosimeterForm);
  Application.CreateForm(TImportDBForm, ImportDBForm);
  Application.CreateForm(TDetectorConstructorForm, DetectorConstructorForm);
  Application.CreateForm(TRW, RW);
  Application.CreateForm(TDosimeterConstructorForm, DosimeterConstructorForm);
  Application.CreateForm(TImportInCurrentDBForm, ImportInCurrentDBForm);
  Application.CreateForm(TSQLFilterForm, SQLFilterForm);
  Application.CreateForm(TAddInQueueW, AddInQueueW);
  Application.CreateForm(TQueueForm, QueueForm);
  Application.CreateForm(TSetDosEditForm, SetDosEditForm);
  Application.CreateForm(TDosimeterTypeConstructorForm, DosimeterTypeConstructorForm);
  Application.CreateForm(TImportMeasForm, ImportMeasForm);
  Application.CreateForm(TEnterNewDosTypeForm, EnterNewDosTypeForm);
  Application.CreateForm(TEnterNewDetTypeForm, EnterNewDetTypeForm);
  Application.CreateForm(TAddInCalibrW, AddInCalibrW);
  Application.CreateForm(TDosimeterPartForm, DosimeterPartForm);
  Application.CreateForm(TEnterNewDosPartForm, EnterNewDosPartForm);
  Application.CreateForm(TWarningCommentForm, WarningCommentForm);
  Application.CreateForm(TUserWarningCommentForm, UserWarningCommentForm);
  Application.CreateForm(TWarningErrorW, WarningErrorW);
  Application.CreateForm(TFormUserFirstStart, FormUserFirstStart);
  Application.CreateForm(TExportDosAndSettingsForm, ExportDosAndSettingsForm);
  Application.CreateForm(TSendToCalibrW, SendToCalibrW);
  Application.CreateForm(TChangeDosNameInMeasForm, ChangeDosNameInMeasForm);

  AllActiveFormsTranslate;
  if UseLanguageFile then // перезаливка изображений английскими версиями
  try
    MainForm.ImageMeasLogo.Picture.LoadFromFile('Language'+PathDelim+'Images'+PathDelim+'Logo.png');
    MainForm.ImageProcessLogo.Picture.LoadFromFile('Language'+PathDelim+'Images'+PathDelim+'Logo.png');
  except
  end;

  Application.Run;
end.
