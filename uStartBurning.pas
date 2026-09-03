unit uStartBurning;

//{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  RichMemo, DBGridsEh;

type

  { TStartBurning }

  TStartBurning = class(TForm)
    BtnStart: TButton;
    LblTopCaption: TLabel;
    RichMemo: TRichMemo;
    StatusBar: TStatusBar;
  private

  public

  end;

var
  StartBurning: TStartBurning;

implementation

{$R *.lfm}

end.

