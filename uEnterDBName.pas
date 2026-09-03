unit uEnterDBName;

interface

uses
  Messages, SysUtils, Variants,System.UITypes, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;

type
  TEnterDBName = class(TForm)
    DBNameEdit: TEdit;
    ErrorLabel: TLabel;
    OkButton: TButton;
    CancelButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure DBNameEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure DBNameEditKeyPress(Sender: TObject; var Key: Char);
  private
    FName: String;
    function CheckName(aName: String): integer;
    procedure SetDBName(aName: String);
    { Private declarations }
  public
    OkBtn     :  boolean;
    property Name: String read FName write SetDBName;
    { Public declarations }
  end;

var
  EnterDBName: TEnterDBName;

implementation
uses uLanguages;
{$R *.dfm}

function DelDimention(Const Source: String): String;
var
  StrValue: String;
  GapPos: integer;
begin
  StrValue:=Source;
  GapPos:=LastDelimiter(' ', StrValue);
  SetLength(StrValue,GapPos-1);
  Result:=StrValue;
end;

function GetDimention(Const Source: String): String;
var
  StrValue: String;
  GapPos: integer;
begin
  StrValue:=Source;
  GapPos:=LastDelimiter(' ', StrValue);
  Delete(StrValue,1,GapPos);
  Result:=StrValue;
end;

procedure TEnterDBName.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

function TEnterDBName.CheckName(aName: String): integer;
var
  n: integer;
begin
  if aName='' then    // пустая строка
    result:=1
  else if TryStrToInt(aName[1],n) then
    result:=2         // первый символ - цифра
  else
    result:=0;
end;

procedure TEnterDBName.DBNameEditChange(Sender: TObject);
begin
  try
    Name:=DBNameEdit.Text;
  except
    MessageDlg(rsEnterCorrectValue,mtWarning,[mbOK], 0);
  end;
end;

procedure TEnterDBName.DBNameEditKeyPress(Sender: TObject; var Key: Char);
begin
//  if not (Key in ['0'..'9', 'А'..'Я', 'а'..'я', 'A'..'Z', 'a'..'z', #8, #95]) then
  if not (Key in ['0'..'9', 'A'..'Z', 'a'..'z', #8, #95]) then
  begin
    ErrorLabel.Caption:=rsIllegalChar + ' - "' + Key + '"';
    ErrorLabel.Visible:=True;
    Key:=#0;     // ограничение на ввод имеи БД - только латиница
  end
  else
    ErrorLabel.Visible:=False;
end;

procedure TEnterDBName.FormCreate(Sender: TObject);
begin
  Caption:='Введите имя';
end;

procedure TEnterDBName.OkButtonClick(Sender: TObject);
begin
  case CheckName(Name) of
    1:
    begin
      ErrorLabel.Caption:=rsInputName + '!';
      ErrorLabel.Visible:=True;
    end;
    2:
    begin
      ErrorLabel.Caption:=rsErrNameCiphFirst + '!';
      ErrorLabel.Visible:=True;
    end;
  end;

  if CheckName(Name)=0 then
  begin
    ErrorLabel.Visible:=False;
    OkBtn:=true;
    Close;
  end;
end;

procedure TEnterDBName.SetDBName(aName: String);
begin
  FName:=aName;
end;

end.
