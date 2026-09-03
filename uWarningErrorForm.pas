unit uWarningErrorForm;

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls;
// Vcl.Imaging.pngimage

type
  TWarningErrorW = class(TForm)
    PanelBackground: TPanel;
    LblTitle: TLabel;
    PanelBottom: TPanel;
    BtnOk: TButton;
    MemoMsg: TMemo;
    PanelLbl: TPanel;
    LblMsg: TLabel;
    Image1: TImage;
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ChangeLbl(Title,Err,Memo: String);
    { Public declarations }
  end;

var
  WarningErrorW: TWarningErrorW;

implementation

{$R *.dfm}

{ TWarningErrorW }

procedure TWarningErrorW.BtnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TWarningErrorW.ChangeLbl(Title,Err,Memo: String);
begin
  MemoMsg.Clear;
  LblTitle.Caption:=Title;
  LblMsg.Caption:=Err;
  MemoMsg.Text:=Memo;
end;

end.
