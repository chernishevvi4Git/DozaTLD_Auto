unit SlavaTools;

interface

procedure slt_Delay(aWaitingTime: integer); // безусловная задержка потока на aWaitingTime мс
procedure Logging(aSt: string);

function CheckBit(aNumber: cardinal; aNumBit:byte): boolean; // проверка бита в байте, слове или двойном слове начиная с 0-го

function slt_GetFileSize(FileName: String): Integer;

function slt_GetFileDateTime(FileName: string): TDateTime;


var
  AppDir: string = 'C:\';
  AppFullPath: string = 'C:\App.exe';



implementation
Uses SysUtils, SlavaStringLib, Classes;

procedure slt_Delay(aWaitingTime: integer); // безусловная задержка потока на aWaitingTime мс
var
  StartTime: TDateTime;
begin
  StartTime:=Now;
  while (Now-StartTime)<aWaitingTime/24/60/60/1000 do ;
end;

var
  LogFilename: string = 'Application.log';
procedure Logging(aSt: string);
var
  F: Text;
begin
  try
    aSt:=GetProtocolNowTime+' '+aSt;
    AssignFile(F,LogFileName);
    try
      reset(F);
    except
      rewrite(F);
    end;
    try
      closeFile(F);
    except
    end;
    Append(F);
    try
      Writeln(F,aSt);
      Flush(F);
    finally
      CloseFile(F);
    end;
  except
  end;
end;

function CheckBit(aNumber: cardinal; aNumBit:byte): boolean;
var
  i: integer;
begin
  for i:=1 to aNumBit do
    aNumber:=aNumber div 2;
  result:=(aNumber mod 2)=1;
end;

// Если файл не существует, то вместо размера файла функция верн?т -1
function slt_GetFileSize(FileName: String): Integer;
var
  FS: TFileStream;
begin
  result := -1;
  try
    FS := TFileStream.Create(Filename, fmOpenRead);
    Result := FS.Size;
    FS.Free;
  except
  end;
end;

function slt_GetFileDateTime(FileName: string): TDateTime;
var
  intFileAge: LongInt;
begin
  intFileAge := FileAge(FileName);
  if intFileAge = -1 then
    Result := 0
  else
    Result := FileDateToDateTime(intFileAge)
end;


initialization
  AppFullPath:=ExpandFileName(Paramstr(0));
  AppDir:=ExtractFilePath(ExpandFileName(Paramstr(0)));
  if AppDir[length(AppDir)]<>PathDelim then AppDir:=AppDir+PathDelim;
  //if length(AppDir)<2 then AppDir:='.\';

  LogFileName:=ChangeFileExt(AppFullPath,'.log');
end.
