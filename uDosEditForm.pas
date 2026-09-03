unit uDosEditForm;

interface

uses
  Messages, SysUtils, Variants, Classes, Math, Graphics, DateTimePicker,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons,StrUtils, uDosimeter, ComCtrls;

type
  TSetDosEditForm = class(TForm)
    PanelBackground: TPanel;
    EditValue: TEdit;
    LblValue: TLabel;
    BtnCancel: TButton;
    BtnAccept: TButton;
    ComboBoxValue: TComboBox;
    DateTimePickerValue: TDateTimePicker;
    procedure BtnCancelClick(Sender: TObject);
    procedure DateTimePickerValueChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ShowControls(Value: integer);
  public
    Dosimeter: TDosimeter;
    OwnerButton: TObject;
    Value: String;
    { Public declarations }
  end;

const
 cCtrlEdit = 0;
 cCtrlComboBox = 1;
 cCtrlDatePicker = 2;
var
  SetDosEditForm: TSetDosEditForm;

implementation
uses
  uConst,
  uLanguages,
  uSeparator,
//  uFunctions,
//  uDataModule,
  uMainForm;
{$R *.dfm}

procedure TSetDosEditForm.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TSetDosEditForm.Button1Click(Sender: TObject);
begin
  MainForm.DBGridEhDos.DataSource.DataSet.Locate(cFullDosID,Dosimeter.FullNumber,[]);
end;

procedure TSetDosEditForm.DateTimePickerValueChange(Sender: TObject);
begin
//  DateTimePickerValue.Format:='';
end;

procedure TSetDosEditForm.ShowControls(Value: integer);
begin
  case Value of
    cCtrlEdit:
    begin
      if not EditValue.Visible then EditValue.Visible:=true;
      if DateTimePickerValue.Visible then DateTimePickerValue.Visible:=false;
      if ComboBoxValue.Visible then ComboBoxValue.Visible:=false;
    end;
    cCtrlComboBox:
    begin
      if EditValue.Visible then EditValue.Visible:=false;
      if DateTimePickerValue.Visible then DateTimePickerValue.Visible:=false;
      if not ComboBoxValue.Visible then ComboBoxValue.Visible:=true;
    end;
    cCtrlDatePicker:
    begin
      if EditValue.Visible then EditValue.Visible:=false;
      if ComboBoxValue.Visible then ComboBoxValue.Visible:=false;
      if not DateTimePickerValue.Visible then DateTimePickerValue.Visible:=true;
    end;
  end;
end;

end.
