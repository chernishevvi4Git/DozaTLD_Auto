unit uVersion;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ELSE}
  FileInfo,
  {$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, RxVersInfo,
  ULanguages;
// Vcl.Imaging.pngimage,

type

  { TVW }

  TVW = class(TForm)
    ImageLogo1: TImage;
    InformationMemo: TMemo;
    VersionLabel: TLabel;
    ImageLogo: TImage;
    SoftwareNameLabel: TLabel;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
    procedure ImageLogo1Click(Sender: TObject);
    procedure MemoEnable(Sender: TObject);
    procedure MemoDisable(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VW: TVW;

implementation

{$R *.dfm}

{function FileVersion(AFileName:String): String;
var
  szName: array[0..255] of Char;
  P: Pointer;
  Value: Pointer;
  Len: UINT;
  GetTranslationString:String;
  FFileName: PChar;
  FValid:boolean;
  FSize: DWORD;
  FHandle: DWORD;
  FBuffer: PChar;
begin
  Result := '';
  try
    FFileName := StrPCopy(StrAlloc(Length(AFileName) + 1), AFileName);
    try
      FSize := GetFileVersionInfoSize(FFileName, FHandle);
      if FSize > 0 then begin
        GetMem(FBuffer, FSize);
        try
          FValid := GetFileVersionInfo(FFileName, FHandle, FSize, FBuffer);
          if FValid then begin
            VerQueryValue(FBuffer, '\VarFileInfo\Translation', p, Len);
            GetTranslationString := IntToHex(MakeLong(HiWord(Longint(P^)), LoWord(Longint(P^))), 8);
            StrPCopy(szName, '\StringFileInfo\' + GetTranslationString + '\FileVersion');
            if VerQueryValue(FBuffer, szName, Value, Len) then
              Result := StrPas(PChar(Value));
          end;
        finally
          FreeMem(FBuffer, FSize);
        end;
      end;
    finally
      StrDispose(FFileName);
    end;
  except
  end;
end;   }

function GetVersionInfo(fullpath: String; var Major,Minor,Release,Build: String): boolean;
{$IFDEF MSWINDOWS}
var
  VerInfoSize: Cardinal;
  VerValueSize: Cardinal;
  Dummy: Cardinal;
  PVerInfo: Pointer;
  PVerValue: PVSFixedFileInfo;
begin
  Result := false;

  VerInfoSize := GetFileVersionInfoSize(PChar(fullpath), Dummy);
  if VerInfoSize > 0 then
  begin
    GetMem(PVerInfo, VerInfoSize);
    try
      if GetFileVersionInfo(PChar(fullpath), 0, VerInfoSize, PVerInfo) then
      begin
        if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
        begin
          Major   := IntToStr(HiWord(PVerValue^.dwFileVersionMS));
          Minor   := IntToStr(LoWord(PVerValue^.dwFileVersionMS));
          Release := IntToStr(HiWord(PVerValue^.dwFileVersionLS));
          Build   := IntToStr(LoWord(PVerValue^.dwFileVersionLS));
        end;

        Result := true;
      end;

    finally
      FreeMem(PVerInfo, VerInfoSize);
    end;
  end;
{$ELSE}
var
  i: Integer;
  Version: TVersionInfo;
  MyVersion: String;
  PV: TProgramVersion;
begin
  result := false;

  Version:=TVersionInfo.Create;
  Version.Load(HINSTANCE);

  MyVersion:=Format('%d.%d.%d.%d', [Version.FixedInfo.FileVersion[0],
                                    Version.FixedInfo.FileVersion[1],
                                    Version.FixedInfo.FileVersion[2],
                                    Version.FixedInfo.FileVersion[3]]);

  if TryStrToProgramVersion(MyVersion, PV) then
  begin
    Major   := IntToStr(PV.Major);
    Minor   := IntToStr(PV.Minor);
    Release := IntToStr(PV.Revision);
    Build   := IntToStr(PV.Build);
    result := true;
  end;

  Version.Free;
{$ENDIF}
end;

procedure TVW.FormCreate(Sender: TObject);
var
  StMajor,StMinor,StRelease,StBuild: String;
begin
  GetVersionInfo(ExtractFilePath(Application.ExeName)+ExtractFileName(Application.ExeName),StMajor,StMinor,StRelease,StBuild);
  VersionLabel.Caption:=rsVersion+': '+StMajor+'.'+StMinor+'.'+StRelease+'.'+StBuild;
  InformationMemo.Clear;
  InformationMemo.Lines.Add(rsInformation);
end;

procedure TVW.ImageLogo1Click(Sender: TObject);
begin

end;

procedure TVW.MemoDisable(Sender: TObject);
begin
  TMemo(Sender).Enabled:=false;
end;

procedure TVW.MemoEnable(Sender: TObject);
begin
  TMemo(Sender).Enabled:=true;
end;

end.
