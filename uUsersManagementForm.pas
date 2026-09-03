unit uUsersManagementForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit, Vcl.Buttons, JvExGrids, JvStringGrid, Vcl.StdCtrls, IniFiles,
  uAddUserForm,
  uLogPassForm,
  uChangePassForm,
  uConst,
  uFunctions,
  uMessageForm,
  uUsersManagement,
  uLanguages, Vcl.CheckLst, Vcl.ComCtrls, Vcl.ExtCtrls, JvExExtCtrls,
  JvExtComponent, JvPanel;

type
  TUMW = class(TForm)
    StatusBar: TStatusBar;
    Panel2: TPanel;
    SG_Users: TStringGrid;
    Panel3: TPanel;
    AddSpeedButton: TSpeedButton;
    DelSpeedButton: TSpeedButton;
    EditSpeedButton: TSpeedButton;
    Panel5: TPanel;
    Panel4: TPanel;
    LabelPermitHelp: TLabel;
    CLB_Permits: TCheckListBox;
    Panel1: TPanel;
    Label_Permits: TLabel;
    Panel6: TPanel;
    Label_SetAsTemplate: TLabel;
    CB_SetAsTemlate: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddSpeedButtonClick(Sender: TObject);
    procedure DelSpeedButtonClick(Sender: TObject);
    procedure EditSpeedButtonClick(Sender: TObject);
    procedure CLB_PermitsClick(Sender: TObject);
    procedure CLB_PermitsClickCheck(Sender: TObject);
    procedure SG_UsersSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CB_SetAsTemlateChange(Sender: TObject);
    procedure CB_SetAsTemlateDropDown(Sender: TObject);
  private
    FPermitMask: int64;
    procedure SetPermitMask(Value: int64);
    procedure RefreshCLB_Permit;
    { Private declarations }
  public
    { Public declarations }
    SelectRowUser: integer;
    procedure RefreshUMW;
    property PermitMask: int64 read FPermitMask write SetPermitMask;
    procedure WritePermitToUser(aPermit:int64; aUser:string);
    procedure AcceptMyNewMask(Sender: TObject);
  end;

const
  cRaw = 1; // фокус на строке
  cCol = 1;

{
  crMySelfAdministrator      = 0;
  crCalc_EditCoeffs_Change   = 1;
  crCalc_EditRange_Change    = 2;
  crCalc_Algorithm_Show      = 3;
  crCalc_Measure_Update      = 4;
  crCalc_VisualChangers_View = 5;
  crCalc_VisualChangers_Annotation = 6;
  crCalc_VisualChangers_Use  = 7;
  crCalc_VisualRange_View    = 8;
  crCalc_VisualRange_Use     = 9;
  crCalc_Menu_View           = 10;
  crCalc_PanelCoeffs_View    = 11;
//  crCalc_BtnMinimizePanelCoeffs_View = 12;
  crCalc_cbWOFon_View        = 13;
  crCalc_StatusBar_View      = 14;
  crCalc_S_View              = 15;
  crCalc_Err_View            = 16;

  crsetCalc = [1..16]; // множество констант, использующихся для определения прав в расчётном модуле
}
//  cPermitsCount = 37;
//  cPermitsCount = 64;
//  cPermitTexts : array [0..cPermitsCount-1] of string = (
//    'Право доступа - Редактирование собственных настроек',
//    'Рассчёт - изменение чисел параметров',
//    'Рассчёт - изменение чисел зоны интереса',
//    'Рассчёт - открыть настройки алгоритма',
//    'Рассчёт - сохранение изменений',
//    'Рассчёт - график (линии параметров)',
//    'Рассчёт - график (значения)',
//    'Рассчёт - график (изменение параметров)',
//    'Рассчёт - график (зона интереса)',
//    'Рассчёт - график (изменение зоны интереса)',
//    'Рассчёт - показывать меню',
//    'Рассчёт - показывать панель коэффициентов',
//    'Рассчёт - reserved',
//    'Рассчёт - показывать чекбокс "без фона"',
//    'Рассчёт - показывать статусбар',
//    'Рассчёт - показывать найденную площадь',
//    'Рассчёт - показывать оценку ошибки',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    'end'
//  );

//  cLabelPermitHelp : array [0..cPermitsCount-1] of string = (
//    'Управление правами и настройками отображения различных модулей программы',
//    'Редактирование параметров рассчётных функций в рассчётном модуле для поиска наиболее подходящего аналитического описания',
//    'Изменение границ области интереса для ручной корректировки положения пика',
//    'Настройка параметров автоматического алгоритма обработки КТВ с поиском пика',
//    'Запись изменённого вручную результата расчёта в базу данных',
//    'Отображение вспомогательных линий на графике с визуализацией рассчётных коэффициентов на графике КТВ',
//    'Отображение численных значений рассчётных коэффициентов на графике КТВ (на вспомогательных линиях)',
//    'Изменение рассчётных коэффициентов на графике КТВ с помощью мыши перемещением вспомогательных линий и колёсиком мыши',
//    'Отображение зоны интереса в виде белого прямоугольника на графике КТВ',
//    'Изменение зоны интереса в виде белого прямоугольника на графике КТВ перемещением его границ',
//    'Показывать главное меню окна',
//    'Показывать панель с численными значениями рассчётных коэффициентов и параметров (в нижней области окна)',
//    'зарезервировано',
//    'Показывать настройку "без фона", позволяющую отображать график КТВ с вычетом рассчитанной кривой фона',
//    'Показывать статусбар с информацией о признаках работы алгоритма по поиску фона и пика',
//    'Показывать значение найденной площади пика (даже если пик не найден)',
//    'Показывать оценку ошибки найденной площади пика',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    '',
//    'end'
//  );

  cpTemplateCount = 3;
  cpTemplateTexts : array [0..cpTemplateCount-1] of string = (
    'Дозиметрист',
    'Инженер-Дозиметрист',
    'Администратор'
  );

  cpTemplatePermits : array [0..cpTemplateCount-1] of int64 = (
    $00000001,
    $000000FF,
    $FFFFFFFF
  );


var
  UMW: TUMW;

implementation

{$R *.dfm}

uses
  uLog,
  uDataModule;

procedure TUMW.AddSpeedButtonClick(Sender: TObject);
begin
  CB_SetAsTemlate.Font.Color:=clWindowText;
  AddUW.PermitComboBox.Items.SetStrings(CB_SetAsTemlate.Items);
  if AddUW.ShowModal=mrOK then
    RefreshUMW;
end;

procedure TUMW.AcceptMyNewMask(Sender: TObject);
begin
  WritePermitToUser(AW.CurrentUser.Permit,AW.CurrentUser.Login);
end;

procedure TUMW.CB_SetAsTemlateChange(Sender: TObject);
begin
  if CB_SetAsTemlate.ItemIndex<>-1 then
  begin
    PermitMask:=cpTemplatePermits[CB_SetAsTemlate.ItemIndex];
    RefreshCLB_Permit;
    WritePermitToUser(PermitMask, AW.Users[SelectRowUser].Login);
  end;
end;

procedure TUMW.CB_SetAsTemlateDropDown(Sender: TObject);
begin
  CB_SetAsTemlate.Font.Color:=clWindowText;
  CB_SetAsTemlate.Color:=clWindow;
end;

procedure TUMW.CLB_PermitsClick(Sender: TObject);
var
  i  : word;
begin
  for i:=0 to cPermitsCount-1 do
    if CLB_Permits.Selected[i] then
      LabelPermitHelp.Caption := cLabelPermitHelp[i];
end;

procedure TUMW.CLB_PermitsClickCheck(Sender: TObject);
var
  i  : word;
  newPermitMask : int64;
begin
  CB_SetAsTemlate.Font.Color :=clWindowText;
  CB_SetAsTemlate.ItemIndex := -1;
  newPermitMask:=0;
  for i:=0 to cPermitsCount-1 do
    NewPermitMask:=SetBit64(NewPermitMask,i,CLB_Permits.Checked[i]);
  PermitMask:=NewPermitMask;
  WritePermitToUser(PermitMask, AW.Users[SelectRowUser].Login);
end;

procedure TUMW.DelSpeedButtonClick(Sender: TObject);
var
  temp  : word;
begin
  if SG_Users.Cells[cCol,SelectRowUser]=AW.CurrentUser.Login then
    MessageDlg(rsCantDelCurrentUser+'!',mtWarning,[mbOK], 0)
  else
  begin
    if TLDDataModule.IsDBConnected then
    begin

      temp:=MessageBox(handle, PChar(Format('Удалить пользователя %s?',[AW.Users[SelectRowUser].Login])), PChar(Format('%s!',[rsMsgWarning])),MB_YESNO+MB_ICONWARNING);

      case temp of
        idYes:
        begin
          TLDDataModule.ADOQuery.SQL.Clear;
          TLDDataModule.ADOQuery.SQL.Add(Format('DELETE FROM %s WHERE %s = %d',[cDBTableUser,cFieldUserNameID,AW.Users[SelectRowUser].UserId]));
          TLDDataModule.ADOQuery.ExecSQL;
          TLDDataModule.ADOQuery.Close;

          WriteLog(Format('Удален пользователь %s',[AW.Users[SelectRowUser].Login]));
          AW.ParsingUsersListDB;
          RefreshUMW;
        end;
      end;
    end;
  end;
end;

procedure TUMW.FormActivate(Sender: TObject);
begin
  RefreshUMW;
end;

procedure TUMW.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Caption:=rsUserManagnent;
  AddSpeedButton.Caption:=rsAdd;
  DelSpeedButton.Caption:=rsDel;
  EditSpeedButton.Caption:=rsChangePass;
  SG_Users.Cells[0,0] := rsUser;
  FPermitMask:=0;
  for i := 0 to cPermitsCount-1 do
    CLB_Permits.Items.Add(cPermitTexts[i]);

  for i := 0 to cpTemplateCount-1 do
    CB_SetAsTemlate.Items.Add(cpTemplateTexts[i]);
  Label_SetAsTemplate.Caption := rsLabelSetAsTemplate;
  Label_Permits.Caption := rsLabelPermits;
  SelectRowUser := 0;
end;

procedure TUMW.RefreshCLB_Permit;
var
  i: integer;
begin
  for i := 0 to CLB_Permits.Count-1 do
    CLB_Permits.Checked[i] := IsBit64On(PermitMask,i);
end;

procedure TUMW.RefreshUMW;
var
  i: integer;
  B: boolean;
begin
  SelectRowUser := 0;
  SG_Users.RowCount := Length(AW.Users)+1;
  for i := 0 to Length(AW.Users)-1 do
  begin
    SG_Users.Cells[0,i+1] := AW.Users[i].Login;
    if AW.Users[i].Login = AW.CurrentUser.Login then SelectRowUser := i;
  end;
  SG_Users.Selection := TGridRect(Rect(0,SelectRowUser,0,SelectRowUser));
  SG_UsersSelectCell(Nil,0,SelectRowUser,B);
end;

procedure TUMW.SetPermitMask(Value: int64);
begin
  if Value<>FPermitMask then
  begin
    FPermitMask:=Value;
  end;
  StatusBar.Panels[0].Text := IntToHex(FPermitMask);
end;

procedure TUMW.SG_UsersSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  i: integer;
begin
  if ARow=0 then Exit;
  if SelectRowUser<>ARow-1 then CB_SetAsTemlate.ItemIndex := -1;
  SelectRowUser:=ARow-1;
  PermitMask:=AW.Users[SelectRowUser].Permit;
  RefreshCLB_Permit;
  CB_SetAsTemlate.Font.Color :=clWindowText;
  for i:=0 to cpTemplateCount-1 do
    if cpTemplatePermits[i] = PermitMask then
    begin
      CB_SetAsTemlate.Font.Color :=clGray;
      CB_SetAsTemlate.ItemIndex := i;
    end;
end;

procedure TUMW.EditSpeedButtonClick(Sender: TObject);
begin
  UChangePassW.LoginEdit.Text:=AW.Users[SelectRowUser].Login;
  UChangePassW.ShowModal;
end;

procedure TUMW.WritePermitToUser(aPermit: int64; aUser: string);
var
  i: integer;
begin
  for i:=Low(AW.Users) to High(AW.Users) do
    if aUser = AW.Users[i].Login then
      AW.Users[i].Permit := aPermit;
  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add(Format('UPDATE %s SET %s = %d WHERE %s = '+#39+'%s'+#39,[cDBTableUser,cFieldUserPermission,aPermit,cFieldUserName,aUser]));
    TLDDataModule.ADOQuery.ExecSQL;
    TLDDataModule.ADOQuery.Close;

    WriteLog(Format('Права доступа пользователя %s обновлены (%x)',[aUser,aPermit]));
//    AW.ParsingUsersListDB;
  end;
end;

end.
