unit uImportProcess;

interface

uses
//  ExtDlgs
  Messages, SysUtils,System.UITypes, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  uImportDosimeters, Menus;

type
  TImportProcessW = class(TForm)
    PanelMemoLog: TPanel;
    PanelButtons: TPanel;
    MemoLog: TMemo;
    BtnCancel: TButton;
    BtnAccept: TButton;
    PopupMenuLog: TPopupMenu;
    LogClear: TMenuItem;
    PageControlImportResults: TPageControl;
    TabSheetResult: TTabSheet;
    TabSheetLog: TTabSheet;
    LblImport: TLabel;
    LblUpdetedRecords: TLabel;
    LblAddedRecords: TLabel;
    LblErr: TLabel;
    SaveTextFileDialogLog: TSaveDialog;
    SaveLogAs: TMenuItem;
    ProgressBarAccept: TProgressBar;
    procedure BtnAcceptClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var anAction: TCloseAction);
    procedure LogClearClick(Sender: TObject);
    procedure SaveLogAsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FAccepted : boolean;
    procedure SaveLog;
    { Private declarations }
  public
    backupBDName: String;
    { Public declarations }
  end;

var
  ImportProcessW: TImportProcessW;

implementation
uses
  uMainForm,
  uLanguages,
  uDosimeterConstructorForm,
  uDataModule,
  uConst;

{$R *.dfm}

procedure TImportProcessW.BtnAcceptClick(Sender: TObject);
begin
  FAccepted:=true;
  Close;
end;

procedure TImportProcessW.BtnCancelClick(Sender: TObject);
begin
  FAccepted:=false;
  Close;
end;

procedure TImportProcessW.FormClose(Sender: TObject; var anAction: TCloseAction);
begin
  if FAccepted then
  begin
    MainForm.PageControlMain.ActivePageIndex:=cPageMeasIndex;
    MainForm.UpdateGridPageStart;
    MainForm.PageControlMain.ActivePageIndex:=cPageDosIndex;

    MainForm.ReadTLDSettings;

    DosimeterConstructorForm.Close;
  end
  else
  begin
    MainForm.Splash.ProgressBar.Minimum:=0;
    MainForm.Splash.ProgressBar.Maximum:=100;
    MainForm.Splash.ProgressBar.Position:=25;
    MainForm.Splash.Show(false);
    MainForm.Splash.SetCaption('Отмена импорта');

    TLDDataModule.RestoreDB(backupBDName,false);

    MainForm.Splash.ProgressBar.Position:=50;

    TLDDataModule.DeleteDataBase(backupBDName);

    MainForm.Splash.ProgressBar.Position:=100;
    MainForm.Splash.Close;

  end;

  ImportDosimetersW.Close;
end;

procedure TImportProcessW.FormCreate(Sender: TObject);
begin
  backupBDName:='';
end;

procedure TImportProcessW.FormShow(Sender: TObject);
begin
  ProgressBarAccept.Visible:=false;

  FAccepted:=false;

  PageControlImportResults.TabIndex:=0;

  MemoLog.Lines.Add(#10+#13);
  MemoLog.Lines.Add('***********************************'+#10+#13+#10+#13);

  if (ImportDosimetersW.ErrCnt > 0) then
  begin
    BtnCancel.SetFocus;
    LblErr.Color:=clRed;
  end
  else
    LblErr.Color:=clWhite;

  if (ImportDosimetersW.UpdateCnt > 0) then
  begin
    BtnCancel.SetFocus;
    LblUpdetedRecords.Color:=clYellow;
  end
  else
    LblUpdetedRecords.Color:=clWhite;


  if (ImportDosimetersW.UpdateCnt = 0) AND (ImportDosimetersW.ErrCnt > 0) then
  begin
    BtnAccept.SetFocus;
  end;

  MemoLog.Lines.Add(Format(' %s - %d',[rsImpAddedRecords,ImportDosimetersW.InsertCnt]));
  MemoLog.Lines.Add(Format(' %s - %d',[rsImpUpdatedRecords,ImportDosimetersW.UpdateCnt]));
  MemoLog.Lines.Add(Format(' %s - %d',[rsImpFindedErrors,ImportDosimetersW.ErrCnt]));

  LblAddedRecords.Caption:=Format(' %s - %d',[rsImpAddedRecords,ImportDosimetersW.InsertCnt]);
  LblUpdetedRecords.Caption:=Format(' %s - %d',[rsImpUpdatedRecords,ImportDosimetersW.UpdateCnt]);
  LblErr.Caption:=Format(' %s - %d',[rsImpFindedErrors,ImportDosimetersW.ErrCnt]);

  MemoLog.SelStart:=Length(MemoLog.Lines.text);
//  MemoLog.Perform(EM_LINESCROLL,0,MemoLog.Lines.count); // в Lazarus вроде как все равно не работает ни в виндах, ни в Linux
end;

procedure TImportProcessW.SaveLog;
begin
  if SaveTextFileDialogLog.Execute then
  begin
    if FileExists(SaveTextFileDialogLog.FileName) then
    begin
      if MessageDlg(Format('%s?',[rsMsgFileAlreadyExists]),mtConfirmation,[mbYes,mbNo], 0) = mrYes then
      begin
        MemoLog.Lines.SaveToFile(SaveTextFileDialogLog.FileName);
      end
      else
        SaveLog;

    end
    else
    begin
      MemoLog.Lines.SaveToFile(SaveTextFileDialogLog.FileName);
    end;

  end;
end;

procedure TImportProcessW.SaveLogAsClick(Sender: TObject);
begin
  SaveLog;
end;

procedure TImportProcessW.LogClearClick(Sender: TObject);
begin
  MemoLog.Clear;
end;

end.
