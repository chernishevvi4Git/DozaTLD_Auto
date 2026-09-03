unit uPowerOff;

//{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus;

type

  { TFormPowerOff }

  TFormPowerOff = class(TForm)
    N_Exit: TMenuItem;
    Panel1: TPanel;
    PMenuExit: TPopupMenu;
    procedure N_ExitClick(Sender: TObject);
  private

  public

  end;

var
  FormPowerOff: TFormPowerOff;

implementation
uses uMainForm, uTLDCommandSeries;
{$R *.lfm}

{ TFormPowerOff }

procedure TFormPowerOff.N_ExitClick(Sender: TObject);
begin
  MainForm.TLD_CommandSeries.AllowExit:=True;
  Halt(0);
end;

end.

