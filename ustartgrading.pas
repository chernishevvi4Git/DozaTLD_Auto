unit uStartGrading;

//{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  RichMemo, DBGridsEh;

type

  { TStartGrading }

  TStartGrading = class(TForm)
    BtnStart: TButton;
    LblTopCaption: TLabel;
    RichMemo: TRichMemo;
    StatusBar: TStatusBar;
  private

  public

  end;

var
  StartGrading: TStartGrading;

implementation

{$R *.lfm}

end.

