unit uAddDosInQueue;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ComCtrls, DB, SQLDB,
  uQueueForm, ComboEx,
//  uDatamodule,
  uStartMF, ExtCtrls;
// , Data.Win.ADODB

type

  { TAddInQueueW }

  TAddInQueueW = class(TForm)
    BtnAdd: TButton;
    BtnExit: TButton;
    CBoxAddQueue: TComboBoxEx;
    Lbl: TLabel;
    ADOQueryQueueCB: TSQLQuery;
    LblErr: TLabel;
    PanelQueue: TPanel;
    PanelQueueBottom: TPanel;
    procedure FormShow(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var anAction: TCloseAction);
  private
    function IsInQueue(Value: String): boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddInQueueW: TAddInQueueW;

implementation
uses
  uMainForm,
  uConst,
  uLanguages;
{$R *.dfm}

procedure TAddInQueueW.BtnAddClick(Sender: TObject);
begin
  if CBoxAddQueue.ItemIndex >= 0 then
  begin
    if not IsInQueue(CBoxAddQueue.Text) then
    begin
      ADOQueryQueueCB.Active:=False;
      ADOQueryQueueCB.SQL.Clear;
      ADOQueryQueueCB.SQL.Add('SELECT '+cFieldDosType+' FROM tlddosimeterid WHERE (CAST (dosimeterid AS TEXT) = '+#39+CBoxAddQueue.Text+#39+' AND postfix = '+#39+'-'+#39+') OR CAST (dosimeterid AS TEXT) || postfix = '+#39+CBoxAddQueue.Text+#39);
      ADOQueryQueueCB.Active:=True;

      if QueueForm.Showing then
      begin
        QueueForm.MemTableEhQueue.Append;
        QueueForm.MemTableEhQueue.FieldByName(cFullDosID).AsString:=CBoxAddQueue.Text;
        QueueForm.MemTableEhQueue.FieldByName(cFieldDosType).AsString:=ADOQueryQueueCB.FieldValues[cFieldDosType];
        QueueForm.MemTableEhQueue.FieldByName(cProcessed).AsBoolean:=false;
        QueueForm.MemTableEhQueue.Post;
      end;

      if StartMeasureW.Showing then
      begin
        StartMeasureW.CBoxDosList.Items.Add(CBoxAddQueue.Text);

        StartMeasureW.MemTableEhQueue.Append;
        StartMeasureW.MemTableEhQueue.FieldByName(cFullDosID).AsString:=CBoxAddQueue.Text;
        StartMeasureW.MemTableEhQueue.FieldByName(cFieldDosType).AsString:=ADOQueryQueueCB.FieldValues[cFieldDosType];
        StartMeasureW.MemTableEhQueue.FieldByName(cProcessed).AsBoolean:=false;
        StartMeasureW.MemTableEhQueue.Post;
      end;

      LblErr.Caption:='';
    end
    else
      LblErr.Caption:=rsDosimeterAlreadyExists;
  end
  else
    LblErr.Caption:=rsErrAddDosNum;

end;

procedure TAddInQueueW.BtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TAddInQueueW.FormClose(Sender: TObject; var anAction: TCloseAction);
begin
  StartMeasureW.SaveToQueueFile;
end;

procedure TAddInQueueW.FormShow(Sender: TObject);
var
  i: integer;
begin
  LblErr.Caption:='';

  ADOQueryQueueCB.Active:=False;
  ADOQueryQueueCB.SQL.Clear;
  ADOQueryQueueCB.SQL.Add('SELECT CASE '+cFieldDosPostfix+' WHEN '+#39'-'+#39+' THEN CAST('+cFieldDosID+' AS TEXT) ELSE CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' END AS '+cFullDosID+
                                                          ' FROM '+cDBTableDosID+
                                                          ' WHERE ('+cFieldDosStatus+'<>'+IntToStr(cDosDecommissioned)+')'+
                                                          ' AND ('+cFieldTldID+'='+IntToStr(MainForm.DeviceID)+')');
  ADOQueryQueueCB.Active:=True;

  CBoxAddQueue.ItemIndex:=-1;
  CBoxAddQueue.Items.Clear;
  CBoxAddQueue.Text:='';
  for i := 1 to ADOQueryQueueCB.RecordCount do
  begin
    CBoxAddQueue.Items.Add(ADOQueryQueueCB.FieldValues[cFullDosID]);

    if i <> ADOQueryQueueCB.RecordCount then ADOQueryQueueCB.Next;
  end;

end;

function TAddInQueueW.IsInQueue(Value: String): boolean;
begin
  Result:=StartMeasureW.MemTableEhQueue.Locate(cFullDosID,Value,[loPartialKey]);
end;

end.
