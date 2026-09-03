unit uAddDosInCalibr;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, DB, SQLDB,
  uStartMF;
// , Data.Win.ADODB, uDataModule
type

  { TAddInCalibrW }

  TAddInCalibrW = class(TForm)
    PanelCalibr: TPanel;
    LblDosType: TLabel;
    CBoxDosType: TComboBox;
    LblNumber: TLabel;
    EditDosNumber: TEdit;
    LblDosErr: TLabel;
    PanelCalibrBottom: TPanel;
    ButtonAdd: TButton;
    ButtonClose: TButton;
    ADOQueryCalibrMW: TSQLQuery;
    LblTypeErr: TLabel;
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure CBoxDosTypeChange(Sender: TObject);
    procedure EditDosNumberChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var anAction: TCloseAction);
  private
    function IsInGrid(Value: String): boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddInCalibrW: TAddInCalibrW;

implementation

uses
  uConst;

{$R *.dfm}

function TAddInCalibrW.IsInGrid(Value: String): boolean;
begin
  Result:=StartMeasureW.MemTableEhCalibr.Locate(cFullDosID,Value,[loCaseInsensitive]);
end;

procedure TAddInCalibrW.ButtonAddClick(Sender: TObject);
begin
  if CBoxDosType.ItemIndex >= 0 then
  begin
    LblTypeErr.Visible:=false;

    if EditDosNumber.Text<>'' then
    begin
      LblDosErr.Visible:=false;

      if not IsInGrid(EditDosNumber.Text) then
      begin
        LblDosErr.Visible:=false;

        if StartMeasureW.Showing then
        begin
          StartMeasureW.MemTableEhCalibr.Append;
          StartMeasureW.MemTableEhCalibr.FieldByName(cFullDosID).AsString:=EditDosNumber.Text;
          StartMeasureW.MemTableEhCalibr.FieldByName(cFieldDosType).AsString:=CBoxDosType.Text;
          StartMeasureW.MemTableEhCalibr.FieldByName(cSourceDose).AsString:='-1';
          StartMeasureW.MemTableEhCalibr.FieldByName(cKDos).AsString:='1';
          StartMeasureW.MemTableEhCalibr.FieldByName(cProcessed).AsBoolean:=false;
          StartMeasureW.MemTableEhCalibr.Post;
          StartMeasureW.GetAverageKDos;
        end;

      end
      else
      begin
        LblDosErr.Visible:=true;
        LblDosErr.Caption:=Format('%s',['Дозиметр уже есть в списке']);
      end;
    end
    else
    begin
      LblDosErr.Visible:=true;
      LblDosErr.Caption:=Format('%s',['Номер дозиметра не указан']);
    end;
  end
  else
  begin
    LblTypeErr.Visible:=true;
    LblTypeErr.Caption:=Format('%s',['Укажите тип дозиметра']);
  end;
end;

procedure TAddInCalibrW.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TAddInCalibrW.CBoxDosTypeChange(Sender: TObject);
begin
  if CBoxDosType.ItemIndex >= 0 then LblTypeErr.Visible:=false;
end;

procedure TAddInCalibrW.EditDosNumberChange(Sender: TObject);
begin
  if not IsInGrid(EditDosNumber.Text) then
    LblDosErr.Visible:=false
  else
  begin
    LblDosErr.Visible:=true;
    LblDosErr.Caption:=Format('%s',['Дозиметр уже есть в списке']);
  end;
end;

procedure TAddInCalibrW.FormClose(Sender: TObject; var anAction: TCloseAction);
begin
  StartMeasureW.SaveToCalibrationFile;
end;

procedure TAddInCalibrW.FormShow(Sender: TObject);
var
  i: integer;
begin
  CBoxDosType.ItemIndex:=-1;
  CBoxDosType.Clear;

  ADOQueryCalibrMW.Active:=false;
  ADOQueryCalibrMW.SQL.Clear;

  ADOQueryCalibrMW.SQL.Add('SELECT '+cFieldDosType+' FROM '+cDBTableDosType+' WHERE '+cFieldDosTypeID+'> 0 '+'ORDER BY '+cFieldDosTypeID);
  ADOQueryCalibrMW.Active:=True;

  for i := 1 to ADOQueryCalibrMW.RecordCount do
  begin
    CBoxDosType.Items.Add(ADOQueryCalibrMW.FieldValues[cFieldDosType]);
    if i <> ADOQueryCalibrMW.RecordCount then ADOQueryCalibrMW.Next;
  end;

end;

end.
