unit uSendToCalibrForm;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics, DBGridsEh,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TSendToCalibrW = class(TForm)
    PanelMain: TPanel;
    LblDose: TLabel;
    LblTitle: TLabel;
    EditDose: TEdit;
    LblRadiationType: TLabel;
    CBoxRadiationType: TComboBox;
    PanelButtom: TPanel;
    BtnClose: TButton;
    BtnOk: TButton;
    LabelDoseErr: TLabel;
    procedure EditDoseChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure EditDoseKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CBoxRadiationTypeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FCalibrSourceDose: double;
    function IsDoseCorrect: boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SendToCalibrW: TSendToCalibrW;

implementation

uses
  uSeparator,
  uLanguages,
  uFunctions,
  uMainForm,
  uConst,
  uDataModule;
{$R *.dfm}

procedure TSendToCalibrW.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

function TSendToCalibrW.IsDoseCorrect: boolean;
var
  flag: boolean;
begin
  if IsReal(EditDose.Text) then
  begin
    FCalibrSourceDose:=StrToFloatRegion(EditDose.Text);
    if FCalibrSourceDose>0 then
    begin
      LabelDoseErr.Visible:=false;
      BtnOk.Enabled:=true;
      flag:=true;
    end
    else
    begin
      BtnOk.Enabled:=false;
      flag:=false;
    end;
  end
  else
  begin
    FCalibrSourceDose:=-1;
    LabelDoseErr.Caption:=rsIncorrectValue;
    LabelDoseErr.Visible:=true;
    BtnOk.Enabled:=false;
    flag:=false;
  end;

  Result:=flag;
end;

procedure TSendToCalibrW.BtnOkClick(Sender: TObject);
var
  i           :  integer;
  measId      :  String;
  radType     :  String;
  calibrDose  :  double;
  dbGrid      :  TDBGridEh;
begin
  if IsDoseCorrect then
  begin
    case MainForm.PageControlMain.ActivePage.PageIndex of
      cPageMeasIndex:     DBGrid:=MainForm.DBGridEhOnlyMeas;
      cPageProcessIndex:  DBGrid:=MainForm.DBGridEhProcess;
      else
        DBGrid:=MainForm.DBGridEhProcess;
    end;

    case CBoxRadiationType.ItemIndex of
      0:  radType:=cRadTypeGamma;
      1:  radType:=cRadTypeNeutron;
    end;

    calibrDose:=StrToFloatRegion(EditDose.Text);

    for i := 0 to DBGrid.SelectedRows.Count-1 do
    begin
      DBGrid.DataSource.DataSet.GotoBookmark(DBGrid.SelectedRows.Items[i]);
      measId:=DBGrid.DataSource.DataSet.FieldByName(cFieldDosMeasID).AsString;

      TLDDataModule.SendMeasToCalibr(measId,calibrDose,radType)
    end;

    MainForm.UpdateGridCalibrPage;
    MainForm.UpdateGridPageSoft;
    Close;
  end;
end;

procedure TSendToCalibrW.CBoxRadiationTypeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  cVK_Enter = $0D;          //  кнопка Enter
begin
  if (Key = cVK_Enter) then BtnOk.SetFocus;
end;

procedure TSendToCalibrW.EditDoseChange(Sender: TObject);
begin
  IsDoseCorrect;
end;

procedure TSendToCalibrW.EditDoseKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  cVK_Enter = $0D;          //  кнопка Enter
begin
  if (Key = cVK_Enter) then CBoxRadiationType.SetFocus;
end;

procedure TSendToCalibrW.FormCreate(Sender: TObject);
begin
  CBoxRadiationType.Items.Add(rsRadTypeGamma);
  CBoxRadiationType.Items.Add(rsRadTypeNeutron);
  CBoxRadiationType.ItemIndex:=0;
end;

procedure TSendToCalibrW.FormShow(Sender: TObject);
begin
  EditDose.Text:='';
  CBoxRadiationType.ItemIndex:=0;
  EditDose.SetFocus;
end;

end.
