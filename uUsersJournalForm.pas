unit uUsersJournalForm;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ELSE}
  {$ENDIF}
  LCLType,
  Grids, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DB, DBGrids,
  StdCtrls, ComCtrls, Buttons, ExtCtrls,
  uLanguages,
  uSeparator, DateTimePicker;

type
  TUJW = class(TForm)
    UsersJournalDBGrid: TDBGrid;
//    UsersJournalIBTable: TIBTable;
    UsersJournalDataSource: TDataSource;
    TimeFilterPanel: TPanel;
    AutoSrollSpeedButton: TSpeedButton;
    DateTimePickerMin: TDateTimePicker;
    TimePickerMin: TDateTimePicker;
    UJWIntervalComboBox: TComboBox;
    TimePickerMax: TDateTimePicker;
    DateTimePickerMax: TDateTimePicker;
    DateFromLabel: TLabel;
    DateToLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure UsersJournalDataSourceDataChange(Sender: TObject; Field: TField);
    procedure UJWIntervalComboBoxChange(Sender: TObject);
    procedure DateTimePickerMinChange(Sender: TObject);
    procedure TimePickerMinChange(Sender: TObject);
    procedure TimePickerMaxChange(Sender: TObject);
    procedure DateTimePickerMaxChange(Sender: TObject);
    procedure AutoSrollSpeedButtonClick(Sender: TObject);
  private
//    JournalInterval: String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UJW: TUJW;

implementation
uses
  uMainForm;
{$R *.dfm}

procedure TUJW.AutoSrollSpeedButtonClick(Sender: TObject);
begin
  if AutoSrollSpeedButton.Down then
  begin
    DateTimePickerMin.Enabled:=False;
    TimePickerMin.Enabled:=False;
    DateTimePickerMax.Enabled:=False;
    TimePickerMax.Enabled:=False;
    DateFromLabel.Enabled:=False;
    DateToLabel.Enabled:=False;
    UJWIntervalComboBox.Enabled := True;
    UJWIntervalComboBox.OnChange(Self);
  end
  else
  begin
    DateTimePickerMin.Enabled:=True;
    TimePickerMin.Enabled:=True;
    DateTimePickerMax.Enabled:=True;
    TimePickerMax.Enabled:=True;
    DateFromLabel.Enabled:=True;
    DateToLabel.Enabled:=True;
    UJWIntervalComboBox.Enabled := False;
  end;

end;

procedure TUJW.DateTimePickerMaxChange(Sender: TObject);
begin
  UJWIntervalComboBox.OnChange(Self);
end;

procedure TUJW.DateTimePickerMinChange(Sender: TObject);
begin
  UJWIntervalComboBox.OnChange(Self);
end;

procedure TUJW.FormCreate(Sender: TObject);
begin
  UJWIntervalComboBox.Items[0]:=rsComboBox10Minutes;
  UJWIntervalComboBox.Items[1]:=rsComboBox1Hour;
  UJWIntervalComboBox.Items[2]:=rsComboBox8Hour;
  UJWIntervalComboBox.Items[3]:=rsComboBox1Day;
  UJWIntervalComboBox.Items[4]:=rsComboBox1Week;
  UJWIntervalComboBox.Items[5]:=rsComboBox1Month;
  UJWIntervalComboBox.ItemIndex := 1;

  DateFromLabel.Left:=DateTimePickerMin.Left-DateFromLabel.Width-5;    // что-бы строчки распологались вплотную, независимо от выбранного языка
  DateToLabel.Left:=DateTimePickerMax.Left-DateToLabel.Width-5;        // что-бы строчки распологались вплотную, независимо от выбранного языка
end;

procedure TUJW.TimePickerMaxChange(Sender: TObject);
begin
  UJWIntervalComboBox.OnChange(Self);
end;

procedure TUJW.TimePickerMinChange(Sender: TObject);
begin
  UJWIntervalComboBox.OnChange(Self);
end;

procedure TUJW.UsersJournalDataSourceDataChange(Sender: TObject; Field: TField);
begin
  {$IFDEF MSWINDOWS}
  ShowScrollBar(UsersJournalDBGrid.Handle, SB_VERT, True);
  {$ELSE}
  {$ENDIF}
end;

procedure TUJW.UJWIntervalComboBoxChange(Sender: TObject);
begin
end;

end.
