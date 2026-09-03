unit uStarBurning;

//{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  RichMemo, DBGridsEh;

type

  { TStarBurning }

  TStarBurning = class(TForm)
    BtnStart: TButton;
    LblTopCaption: TLabel;
    RichMemo: TRichMemo;
    StatusBar: TStatusBar;
  private

  public

  end;

var
  StarBurning: TStarBurning;

implementation

{$R *.lfm}

end.

