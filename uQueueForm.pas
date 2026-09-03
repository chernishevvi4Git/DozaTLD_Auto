unit uQueueForm;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
//  DynVarsEh,
  MemTableDataEh, DB, SQLDB, MemTableEh, GridsEh, DBAxisGridsEh,
  DBGridsEh, Buttons;
// , Data.Win.ADODB, EhLibVCL, uDataModule

type

  { TQueueForm }

  TQueueForm = class(TForm)
    PanelClient: TPanel;
    PanelTop: TPanel;
    PanelRight: TPanel;
    LblTitle: TLabel;
    DBGridEhQueue: TDBGridEh;
    DataSourceQueue: TDataSource;
    MemTableEhQueue: TMemTableEh;
    MemTableEhQueuefulldosid: TStringField;
    MemTableEhQueueprocessed: TBooleanField;
    MemTableEhQueuedosimetertype: TStringField;
    SpeedBtnAdd: TSpeedButton;
    SpeedBtnUp: TSpeedButton;
    SpeedBtnDown: TSpeedButton;
    SpeedBtnDel: TSpeedButton;
    SpeedBtnLoadFromGrid: TSpeedButton;
    PanelBottom: TPanel;
    BtnSaveQueue: TButton;
    BtnClose: TButton;
    SpeedBtnLoadFromFile: TSpeedButton;
    SpeedBtnSaveToFile: TSpeedButton;
    ADOQueryQueue: TSQLQuery;
    procedure FormShow(Sender: TObject);
    procedure SpeedBtnDelClick(Sender: TObject);
    procedure SpeedBtnDownClick(Sender: TObject);
    procedure SpeedBtnUpClick(Sender: TObject);
    procedure SpeedBtnAddClick(Sender: TObject);
    procedure SpeedBtnLoadFromGridClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure SpeedBtnLoadFromFileClick(Sender: TObject);
    procedure SpeedBtnSaveToFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ResizePanelLeft(DBGrid: TDbGridEh; MemTable: TMemTableEh);
    procedure LoadFromFile(MemTable: TMemTableEh; DBGridEh: TDBGridEh; FileName: String; Separator: char);
    procedure SaveToFile;

    { Private declarations }
  public
    procedure SaveToFileMeasureDos(Value: String);
    procedure LoadQueueFromMainGrid;
    procedure LoadQueueFromFile(MemTable: TMemTableEh; DBGridEh: TDBGridEh);
    { Public declarations }
  end;


var
  QueueForm: TQueueForm;

implementation
uses
  uMainForm,
  uLanguages,
  uConst,
  uAddDosInQueue,
  uStartMF;
{$R *.dfm}

{ TQueueForm }

procedure TQueueForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TQueueForm.FormCreate(Sender: TObject);
begin
  Caption:=rsQueueMeasures
end;

procedure TQueueForm.FormShow(Sender: TObject);
begin
  LoadQueueFromFile(MemTableEhQueue,DBGridEhQueue);
end;

procedure TQueueForm.LoadQueueFromFile(MemTable: TMemTableEh; DBGridEh: TDBGridEh);
var
  fullPath  : String;
begin
  fullPath:=extractfilepath(Application.ExeName)+cQueue+PathDelim+cQueue+cExtTXT;

  if FileExists(fullPath) then
  begin
    LoadFromFile(MemTable,DBGridEh,fullPath,';')
  end;
end;

procedure TQueueForm.LoadFromFile(MemTable: TMemTableEh; DBGridEh: TDBGridEh; FileName: String; Separator: char);
const
  cDosNumber  = 1;
  cDosType    = 2;
  cDosComment = 3;
var
  f       : TextFile;
  s1, s2  : String;
  j    : integer;
begin

  AssignFile(f, FileName);
  Reset(f);

  MemTable.Open;
  MemTable.EmptyTable;

  while not eof(f) do
  begin
    readln(f,s1);

    j:=0;

    MemTable.Append;

    while pos(separator, s1)<>0 do
    begin
      s2 := copy(s1,1,pos(Separator, s1)-1);
      j := j + 1;
      delete (s1, 1, pos(Separator, S1));

      case j of
        cDosNumber:
        begin
          MemTable.FieldByName(cFullDosID).AsString:=s2;
        end;
        cDosType:
        begin
          MemTable.FieldByName(cFieldDosType).AsString:=s2;
        end;
        cDosComment:
        begin
          MemTable.FieldByName(cProcessed).AsBoolean:=StrToBool(s2);
        end;
      end;

    end;

    if pos (Separator, s1)=0 then
    begin
      MemTable.FieldByName(cProcessed).AsBoolean:=StrToBool(s2);
    end;

    MemTable.Post;

  end;

  ResizePanelLeft(DBGridEhQueue,MemTableEhQueue);

  CloseFile(f);
end;

procedure TQueueForm.ResizePanelLeft(DBGrid: TDbGridEh; MemTable: TMemTableEh);
const
  cAddFieldSize = 25;
var
  i                  : integer;
  indicatorColWidth  : integer;
  columnsWidth       : integer;
  columnName         : String;
begin
  columnsWidth:=0;

  if MemTable.Active then
  begin

    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Title.Caption:=Format(' %s',[rsDosimeter]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Title.Caption:=Format(' %s',[rsDosimeterType]);
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cProcessed).Index].Title.Caption:=' ';
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Footer.ValueType:=fvtStaticText;
    DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Footer.Value:=Format(' - %s',[rsAllCount]);

    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFullDosID).Index].Width:=cColumnWidth_4;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cFieldDosType).Index].Width:=cColumnWidth_4;
    if DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cProcessed).Index].Visible then DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(cProcessed).Index].Width:=cColumnWidth_3;

    if DBGrid.RowCount > 15 then
      indicatorColWidth:=DBGrid.CalcIndicatorColWidth+cAddFieldSize
    else
      indicatorColWidth:=DBGrid.CalcIndicatorColWidth;

    for i := 0 to DBGrid.Columns.Count-1 do
    begin
      if (DBGrid.Columns[i].Visible) then
      begin
        columnsWidth:=columnsWidth+DBGrid.Columns[i].Width;
        columnName:=DBGrid.Columns[i].FieldName;
      end;
    end;

    columnsWidth:=columnsWidth-DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(columnName).Index].Width+indicatorColWidth;

    //if (DBGrid.Width-columnsWidth)>cColumnWidth_1 then
      DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(columnName).Index].Width:=DBGrid.Width-columnsWidth;
    //else
    //  DBGrid.Columns[DBGrid.DataSource.DataSet.FieldByName(columnName).Index].Width:=cColumnWidth_3;
  end;

end;

procedure TQueueForm.LoadQueueFromMainGrid;
var
  i: integer;
begin
  ADOQueryQueue.Active:=False;
  ADOQueryQueue.SQL.Clear;

  ADOQueryQueue.SQL.Add('SELECT CASE postfix WHEN '+#39'-'+#39+' THEN CAST(dosimeterid AS TEXT) ELSE CAST (dosimeterid AS TEXT) || postfix END AS fulldosid, '
                             +cFieldDosType+','
                             +cFieldRegTime+','
                             +'CASE status WHEN '+IntToStr(cDosCalibrated)+' then '+#39+rsDosCalibrated+#39+' WHEN '+IntToStr(cDosNotCalibrated)+' then '+#39+rsDosNotCalibrated+#39+' ELSE '+#39+rsDosDecommissioned+#39+' END AS '+cFieldStringState+','
                             +cFieldDosStatus+','
                             +cFieldOrg+','
                             +cFieldDepartment+','
                             +cFieldPartID+' '
                             +'FROM tlddosimeterid WHERE '
                             +'(CAST (dosimeterid AS TEXT) LIKE '+#39+MainForm.Filter+'%'+#39+' OR CAST (dosimeterid AS TEXT) || postfix LIKE '+#39+MainForm.Filter+'%'+#39+')'
                             +' AND '
                             +MainForm.GetFilterDosOrganization(MainForm.CBoxProcessOrgName)
                             +' AND '
                             +MainForm.GetFilterDosDepartment(MainForm.CBoxProcessDep)
                             +' AND '
                             +MainForm.GetFilterDosType(MainForm.CBoxProcessDosType)
                             +' AND '
                             +MainForm.GetFilterDosPartID(MainForm.CBoxProcessDosPart)
                             +' AND '
                             +MainForm.GetFilterDosStatus(MainForm.CBoxProcessStatus)
                             +' ORDER BY dosimeterid');
  ADOQueryQueue.Active:=True;

  MemTableEhQueue.Open;
  MemTableEhQueue.EmptyTable;

  for i := 1 to ADOQueryQueue.RecordCount do
  begin
    MemTableEhQueue.Append;
    MemTableEhQueue.FieldByName(cFullDosID).AsString:=ADOQueryQueue.FieldValues[cFullDosID];
    MemTableEhQueue.FieldByName(cFieldDosType).AsString:=ADOQueryQueue.FieldValues[cFieldDosType];
    MemTableEhQueue.FieldByName(cProcessed).AsBoolean:=false;
    MemTableEhQueue.Post;

    if i <> ADOQueryQueue.RecordCount then ADOQueryQueue.Next;
  end;

  MemTableEhQueue.First;

  ResizePanelLeft(DBGridEhQueue,MemTableEhQueue);
end;

procedure TQueueForm.SaveToFile;
var
  i         : integer;
  strList   : TStringList;
  fullPath  : String;
begin
  fullPath:=extractfilepath(Application.ExeName)+cQueue+PathDelim+cQueue+cExtTXT;

  strList := TStringList.Create;
  MemTableEhQueue.First;

  for i:=0 to MemTableEhQueue.RecordCount-1 do
  begin
    strList.Add(MemTableEhQueue.FieldByName(cFullDosID).AsString+';'+MemTableEhQueue.FieldByName(cFieldDosType).AsString+';'+MemTableEhQueue.FieldByName(cProcessed).AsString+';'+'Comment');
    MemTableEhQueue.Next;
  end;

  strList.SaveToFile(fullPath);
  strList.Free;
end;

procedure TQueueForm.SaveToFileMeasureDos(Value: String);
var
  i             : integer;
  strList       : TStringList;
  fullPath      : String;
  dosProcessed  : String;
begin
  fullPath:=extractfilepath(Application.ExeName)+cQueue+PathDelim+cQueue+cExtTXT;

  strList:=TStringList.Create;
  StartMeasureW.MemTableEhQueue.First;

  for i:=0 to StartMeasureW.MemTableEhQueue.RecordCount-1 do
  begin
    dosProcessed:=StartMeasureW.MemTableEhQueue.FieldByName(cProcessed).AsString;

    if StartMeasureW.MemTableEhQueue.FieldByName(cFullDosID).AsString = Value then
      dosProcessed:='True';

    strList.Add(StartMeasureW.MemTableEhQueue.FieldByName(cFullDosID).AsString+';'+StartMeasureW.MemTableEhQueue.FieldByName(cFieldDosType).AsString+';'+dosProcessed+';'+StartMeasureW.MemTableEhQueue.FieldByName(cComment).AsString);
    StartMeasureW.MemTableEhQueue.Next;
  end;

  strList.SaveToFile(fullPath);
  strList.Free;
end;

procedure TQueueForm.SpeedBtnAddClick(Sender: TObject);
begin
  AddInQueueW.Showmodal;
end;

procedure TQueueForm.SpeedBtnDelClick(Sender: TObject);
begin
  MemTableEhQueue.Delete;
end;

procedure TQueueForm.SpeedBtnDownClick(Sender: TObject);
begin
  MemTableEhQueue.Next;
end;

procedure TQueueForm.SpeedBtnUpClick(Sender: TObject);
begin
  MemTableEhQueue.Prior;
end;

procedure TQueueForm.SpeedBtnLoadFromFileClick(Sender: TObject);
begin
  LoadQueueFromFile(MemTableEhQueue,DBGridEhQueue);
end;

procedure TQueueForm.SpeedBtnLoadFromGridClick(Sender: TObject);
begin
  LoadQueueFromMainGrid;
end;

procedure TQueueForm.SpeedBtnSaveToFileClick(Sender: TObject);
begin
  SaveToFile;
end;

end.
