unit uSplashScreen;

interface

uses
     ComCtrls, StdCtrls, LCLType,
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ExtCtrls, JvSpecialProgress;
// PNGImage, JvSpecialProgress, JvLabel,
type
  TSplashForm = TForm;

  TSplash = class
  private
    FImage: TImage;
    SplashForm: TSplashForm;
    procedure SetImage(value: TImage);
  public
    TopLabel: TLabel;
    ProgressBar: TJvSpecialProgress;
    constructor Create; overload;
    constructor Create(Image: TImage); overload;
    destructor Destroy; override;
    procedure Show(StayOnTop: Boolean);
    procedure SetCaption(Value: String);
    procedure Close;
    property Image: TImage read FImage write SetImage;
  end;

implementation

procedure CreatePremultipliedBitmap(DstBitMap: TBitmap; SrcPngImage: TImage);
type
  TRGBTripleArray = ARRAY[Word] of TRGBTriple;
  pRGBTripleArray = ^TRGBTripleArray;
  TRGBAArray = array[Word] of TRGBQuad;
  PRGBAArray = ^TRGBAArray;
var
  x, y: Integer;
  TripleAlpha: Double;
  pColor: pRGBTripleArray;
//  pAlpha: Vcl.Imaging.pngimage.pByteArray;
  pBmp: pRGBAArray;
begin
{
  DstBitMap.Height := SrcPngImage.Height;
  DstBitMap.Width := SrcPngImage.Width;
  DstBitMap.PixelFormat := pf32bit;
  for y := 0 to SrcPngImage.Height - 1 do
  begin
    pAlpha := SrcPngImage.AlphaScanline[y];
    pColor := SrcPngImage.Scanline[y];
    pBmp := DstBitMap.ScanLine[y];
    for x := 0 to SrcPngImage.Width - 1 do
      begin
        pBmp[x].rgbReserved := pAlpha[x];
        // преобразуем в нужный формат //
        TripleAlpha := pBmp[x].rgbReserved / 255;
        pBmp[x].rgbBlue := byte(trunc(pColor[x].rgbtBlue * TripleAlpha));
        pBmp[x].rgbGreen := byte(trunc(pColor[x].rgbtGreen * TripleAlpha));
        pBmp[x].rgbRed := byte(trunc(pColor[x].rgbtRed * TripleAlpha));
      end;
  end;
}
end;

constructor TSplash.Create;
begin
  SplashForm := TSplashForm.Create(nil);
  SplashForm.DoubleBuffered:=true;
  SplashForm.Width:=500;
  SplashForm.Height:=55;

  TopLabel:=TLabel.Create(nil);
  TopLabel.Parent:=SplashForm;
  TopLabel.Top:=10;
  TopLabel.Width:=500;
  TopLabel.Align:=alTop;
  TopLabel.Alignment:=taCenter;
  TopLabel.Font.Size:=21;
  TopLabel.Caption:='';

  ProgressBar:=TJvSpecialProgress.Create(nil);
  ProgressBar.Parent:=SplashForm;
  ProgressBar.Left:=0;
  ProgressBar.Top:=35;
  ProgressBar.Height:=20;
  ProgressBar.Width:=500;

  SplashForm.Color:=clWhite;
//  SplashForm.TransparentColor:=true;
//  SplashForm.Color:=clSilver;
//  SplashForm.TransparentColorValue:=clSilver;

end;

constructor TSplash.Create(Image: TImage);
begin
  SplashForm := TSplashForm.Create(nil);
  FImage := TImage.Create(Nil);
  FImage.Assign(Image);
end;

destructor TSplash.Destroy;
begin
  SplashForm.Free;
  FImage.Free
end;

procedure TSplash.SetCaption(Value: String);
begin
  TopLabel.Caption:=Value;
  TopLabel.Refresh;
end;

procedure TSplash.SetImage(value: TImage);
begin
  FImage.Assign(value);
end;

procedure TSplash.Show(StayOnTop: Boolean);
begin
  // устанавливаем нужные параметры
  with SplashForm do
  begin
    BorderStyle := bsNone;
    Position := poScreenCenter;
    if StayOnTop then formstyle := fsStayOnTop;
  end;

  SplashForm.Show;
end;

procedure TSplash.Close;
begin
  SplashForm.Close;
end;

end.
