unit uLogWindow;

interface

uses
// Messages,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls,
  ULanguages;

type
  TLW = class(TForm)
    MemoLog: TMemo;
    procedure FormResize(Sender: TObject);
    procedure MemoLogChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LW: TLW;

implementation
uses
  uMainForm;
{$R *.dfm}

procedure TLW.FormResize(Sender: TObject);
begin
  MemoLog.Height:=LW.Height-40;          // изменяем размеры мемо в соответствии с окном
  MemoLog.Width:=LW.Width-18;            // чтобы помещался скрол
end;

procedure TLW.MemoLogChange(Sender: TObject);
const
  cThousandString = 1000;
begin
  if MemoLog.Lines.Count > cThousandString then
    MemoLog.Lines.Clear;
end;

end.
