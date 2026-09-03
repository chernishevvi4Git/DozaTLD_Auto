unit uStartIrradiation;

//{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls;

type

  { TStartIrradiation }

  TStartIrradiation = class(TForm)
    BtnStart: TButton;
    EditDose: TEdit;
    LblCalibrDose: TLabel;
    LblTopCaption: TLabel;
    LIrradiationEDR: TLabel;
    ShapeConturDose: TShape;
    StatusBar: TStatusBar;
    procedure BtnStartClick(Sender: TObject);
    procedure EditDoseChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

  public

  end;

var
  StartIrradiation: TStartIrradiation;

implementation
uses uMainForm,uTLDCommand,ULanguages;
{$R *.lfm}

{ TStartIrradiation }

procedure TStartIrradiation.EditDoseChange(Sender: TObject);
var
  Dose: real;
begin
  try
    Dose:=StrToFloat(EditDose.Text);
    MainForm.TLDCommand.Motors.IrradiationTime := Dose/MainForm.TLDCommand.Motors.IrradiationEDR;
    StatusBar.Panels[1].Text:=Format(rsIrradiationTime,[MainForm.TLDCommand.Motors.IrradiationTime]);
    ShapeConturDose.Visible:=false;
  except
    ShapeConturDose.Visible:=true;
  end;
end;

procedure TStartIrradiation.BtnStartClick(Sender: TObject);
begin

end;

procedure TStartIrradiation.FormActivate(Sender: TObject);
begin
  LIrradiationEDR.Caption:=Format(rsIrradiationEDR,[MainForm.TLDCommand.Motors.IrradiationEDR]);
end;

end.

