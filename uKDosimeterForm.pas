unit uKDosimeterForm;

interface

uses
//  Messages, Grids,
  SysUtils, Variants, Math, Classes,System.UITypes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ValEdit;

type
  TKDosimeterForm = class(TForm)
    LblDose: TLabel;
    EditSourceDose: TEdit;
    BtnCalc: TButton;
    VLEDosimeters: TValueListEditor;
    BtnAccept: TButton;
    BtnCancel: TButton;
    procedure BtnCalcClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAcceptClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
    FSourceDose: double;
    procedure SetSourceDose(Value: double);
    procedure CalcKDosimeter;
  public
    property SourceDose: double read FSourceDose write SetSourceDose;
    { Public declarations }
  end;

var
  KDosimeterForm: TKDosimeterForm;

implementation
uses
  uDataModule,
  uMainForm,
  uConst,
  uSeparator,
  uCalibrationForm,
  uFunctions,
  uLanguages;
{$R *.dfm}

{ TKDosimeterForm }

procedure TKDosimeterForm.BtnCalcClick(Sender: TObject);
begin
// нужен новый RecalcGroupDose
//  MainForm.RecalcGroupDose;
//  CalcKDosimeter;
end;

procedure TKDosimeterForm.BtnCancelClick(Sender: TObject);
begin
  SourceDose:=1;

end;

procedure TKDosimeterForm.BtnAcceptClick(Sender: TObject);
begin
// нужен новый RecalcGroupDose

//  AcceptKDosimeter;
//
//  MainForm.RecalcGroupDose;
//  MainForm.UpdateDataOnlyMeasFilter(MainForm.FilterDosNumber);
//  MainForm.DBGridEhOnlyMeasCellClick(MainForm.DBGridEhOnlyMeas.Columns[0]);
//
//  Close;
end;

procedure TKDosimeterForm.CalcKDosimeter;
var
  i           : integer;
  fullDosId   : String;
  dose        : double;
  kDos        : double;
begin
  if MainForm.DBGridEhOnlyMeas.SelectedRows.Count > 0 then
  begin
    if TLDDataModule.IsDBConnected then
    begin
      //FRowIndex:=MainForm.DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFullDosID).AsString;

      if IsReal(EditSourceDose.Text) then
      begin
        SourceDose:=StrToFloatRegion(EditSourceDose.Text);

        VLEDosimeters.Strings.Clear;

        for i := 0 to MainForm.DBGridEhOnlyMeas.SelectedRows.Count-1 do
        begin
          MainForm.DBGridEhOnlyMeas.DataSource.DataSet.GotoBookmark(MainForm.DBGridEhOnlyMeas.SelectedRows.Items[i]);

          fullDosId:=MainForm.DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFullDosID).AsString;

          dose:=MainForm.DBGridEhOnlyMeas.DataSource.DataSet.FieldByName(cFieldDose).AsFloat;

          kDos:=RoundToCN((dose/SourceDose),cAfterComma);

          VLEDosimeters.InsertRow(fullDosId,FloatToStrRegion(KDos),true);

        end;
      end
      else
      begin
        MessageDlg(rsDoseIncorrect,mtError, [mbOK], 0);
      end;
    end;

  end;
end;


procedure TKDosimeterForm.FormCreate(Sender: TObject);
begin
  SourceDose:=1;
end;

procedure TKDosimeterForm.FormShow(Sender: TObject);
begin
  SourceDose:=1;
end;

procedure TKDosimeterForm.SetSourceDose(Value: double);
begin
  if Value<>0 then
  begin
    FSourceDose:=Value;
    EditSourceDose.Text:=FloatToStrRegion(FSourceDose);
  end
  else
  begin
    FSourceDose:=1;
    EditSourceDose.Text:='1';
  end;
end;

end.
