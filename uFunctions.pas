unit uFunctions;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ELSE}
  Process,
  FileInfo,
  {$ENDIF}
  SysUtils, Classes, Forms, Grids, StdCtrls,
  Inifiles,
  Controls,
  Math,
  uConst,
  uDosimeter,
  uLanguages,
  uSeparator,
  uDetector;

  type
    TIntArray = array of integer;

  function StringsIndexof(SL:TStrings;const Item:String):integer; // функция поиска в TStrings с учетом регистра
//  function SetBit(aWord: word; aBit: byte; aState: boolean = true): word;
  function SetBit(aWord: word; aBit: byte; aState: boolean = true): word; overload; // установка бита
  function SetBit64(aWord: int64; aBit: word; aState: boolean = true): int64;
  function IsBitOn(Value: Integer; Bit: Byte): boolean;
  function IsBit64On(Value: Int64; Bit: Byte): boolean;
  function IsValueInRange(Value: double; Normal: double; Percent: integer): boolean;
  function GetKSValueRange(Value: double; Normal: double; Percent: integer; KFilter: double): integer;
  function GetDetState(Value: TDetectorState) : integer;
  function GetDosStatus(Value: TDosimeterStatus) : integer;
  function GetDosValidity(Value: TDosimeterValidity) : integer;
  function GetDosStrValidity(Value: integer): String;
  function GetDosStrStatus(Value: integer): String;
  function GetSymbolFromUnicode(aCode: String) : String;
  function DeleteLastCRLF(Value: String): String;
  function IsReal(Value: String): boolean;
  function IsRealNAN(Value: string): boolean;
  function DeleteDividers(Value: String): String;
  function ExecAndWait(const FileName,
                       Params,
                       LogFileName,
                       LogFilePath: String;
                       const WinState: Word): boolean; export;
  function ExecSh(const FileName,
                       Params,
                       LogFileName,
                       LogFilePath: String;
                       const WinState: Word): boolean; export;


//  function ExecAndWait2(const FileName,
//                       Params: String;
//
//                       const WinState: Word): boolean; export;

  function CalcProfile(temp_deviation: integer; time_preheating, temp_preheating, time_measurment, temp_measurment, time_burn, temp_burn: integer; speed: double): TTempProfile;
  function IntArrayToString(aMS: TIntArray):String;
  function StringToIntArray(aSt:String): TIntArray;
  function FileVersion(FileName: String): String;
  function FileBuild(FileName: String): String;
  function DelBrackets(In_String, B_Open, B_Close: String): String;
  function OnlyIntNumbers(Key: Char): Char;
  function NoSpecialSymbols(Key: Char): Char;
  function NoSpecialSymbolsForPartName(Key: Char): Char;
  function RoundToCN(aValue: double; aDigits: integer): double;

  procedure ParseDosNumber(FullNumber: String; var aNumber: String; var aPostfix: String);
  procedure ClearStringGrid(StringGrid: TStringGrid);
  procedure SetLblCaptionUnicode(Lbl: TLabel; Value: String);
  procedure SetFocusOnNextEditAfterEnter(Key: Word; NextControl: TWinControl);
  procedure SetFocusOnNextEditAfterEnterIfVisible(Key: Word; NextControl, FinishControl: TWinControl);
  procedure SetFocusOnNextEditAfterEnterIfEnabled(Key: Word; NextControl, FinishControl: TWinControl);

implementation

procedure SetLblCaptionUnicode(Lbl: TLabel; Value: String);
begin
  Lbl.Caption:=Value;
end;

procedure SetFocusOnNextEditAfterEnter(Key: Word; NextControl: TWinControl);
begin
  if (Key = cVK_Enter) then NextControl.SetFocus;
end;

procedure SetFocusOnNextEditAfterEnterIfVisible(Key: Word; NextControl,
  FinishControl: TWinControl);
begin
  if (Key = cVK_Enter) then
    if NextControl.Visible then
      NextControl.SetFocus
    else
      FinishControl.SetFocus;
end;

procedure SetFocusOnNextEditAfterEnterIfEnabled(Key: Word; NextControl,
  FinishControl: TWinControl);
begin
  if (Key = cVK_Enter) then
    if NextControl.Enabled then
      NextControl.SetFocus
    else
      FinishControl.SetFocus;
end;

function RoundToCN(aValue: double; aDigits: integer): double;
begin
  if IsNan(aValue)
  then result:=Nan
  else result := RoundTo(aValue,aDigits);
end;

procedure ClearStringGrid(StringGrid: TStringGrid);
var
  i: integer;
begin
  with StringGrid do
  begin
//    for i:=2 to ColCount-1 do Cols[i].Clear;
//    ColCount:=2;
    for i:=1 to RowCount-1 do Rows[i].Clear;
    RowCount:=1;
    ColCount:=2;
  end;
end;

procedure ParseDosNumber(FullNumber: String; var aNumber: String; var aPostfix: String);
var
  i       : integer;
  n       : integer;
  number  : String;
  postfix : String;
begin
  n:=0;
  number:=FullNumber;
  postfix:=cEmptyData;

  for i := Low(FullNumber) to High(FullNumber) do
  begin
    if not TryStrToInt(FullNumber[i],n) then
    begin
      number:=copy(FullNumber,Low(FullNumber),i-1);
      if Length(FullNumber)-i > 0 then
        postfix:=copy(FullNumber,i)
      else
        postfix:=cEmptyData;
      break
    end;

  end;
  aNumber:=number;
  aPostfix:=postfix;
end;

function OnlyIntNumbers(Key: Char): Char;
begin
  case Key of
    '0'..'9':
      Result:=Key;
    #8:
      Result:=Key;
    else
      Result:=#0;
  end;
end;

function NoSpecialSymbols(Key: Char): Char;
begin
  case Key of
  ',','.','{','}','[',']','(',')','/','\','"','''',':',';','|':
    Result:=#0;
  else
    Result:=Key;
  end;
end;

function NoSpecialSymbolsForPartName(Key: Char): Char;
begin
  case Key of
  ',','.','{','}','[',']','(',')','"','''',':',';','|':
    Result:=#0;
  else
    Result:=Key;
  end;
end;

function StringsIndexof(SL:TStrings;const Item:String):integer;
begin
  for Result := 0 to SL.Count-1 do
    if SL[Result]=Item then Exit;
  Result := -1;
end;

function FileVersion(FileName: String): String;
{$IFDEF MSWINDOWS}
var
  Buf: Pointer;
  BufSize, Len, dwHandle: Cardinal;
  VerInfo: PVSFixedFileInfo;
begin
  Result := '';
  BufSize := GetFileVersionInfoSize(PChar(FileName), dwHandle);
  if BufSize <> 0 then
  begin
    GetMem(Buf, BufSize);
    try
      GetFileVersionInfo(PChar(FileName), dwHandle, BufSize, Buf);
      VerQueryValue(Buf, '\', Pointer(VerInfo), Len);
      with VerInfo^ do
        Result := Format('%d.%d.%d.%d', [
        dwFileVersionMS shr 16,
        dwFileVersionMS and $FFFF,
        dwFileVersionLS shr 16,
        dwFileVersionLS and $FFFF]);
    finally
      FreeMem(Buf, BufSize);
    end;
  end;
{$ELSE}
var
  i: Integer;
  Version: TFileVersionInfo;
  MyFile, MyVersion: String;
  CatName: string;
begin
  Version:=TFileVersionInfo.create(Nil);
  Version.fileName:=FileName;
  Version.ReadFileInfo;
  with Version do
  begin
    for i:=0 to VersionStrings.Count-1 do
    begin
      CatName := VersionStrings.ExtractName(VersionStrings.Strings[i]);
      if CatName='FileVersion' then
      begin
        result := VersionStrings[i];
      end;
    end;
  end;
  Version.Free;

{$ENDIF}
end;

function FileBuild(FileName: String): String;
{$IFDEF MSWINDOWS}
var
  Buf: Pointer;
  BufSize, Len, dwHandle: Cardinal;
  VerInfo: PVSFixedFileInfo;
begin
  Result := '';
  BufSize := GetFileVersionInfoSize(PChar(FileName), dwHandle);
  if BufSize <> 0 then
  begin
    GetMem(Buf, BufSize);
    try
      GetFileVersionInfo(PChar(FileName), dwHandle, BufSize, Buf);
      VerQueryValue(Buf, '\', Pointer(VerInfo), Len);
      with VerInfo^ do
        Result := Format('%d', [dwFileVersionLS and $FFFF]);
    finally
      FreeMem(Buf, BufSize);
    end;
  end;
{$ELSE}
var
  i,j: Integer;
  Version: TFileVersionInfo;
  MyFile, MyVersion: String;
  CatName, Param: string;
  PV: TProgramVersion;
begin
  Version:=TFileVersionInfo.create(Nil);
  Version.fileName:=FileName;
  Version.ReadFileInfo;
  result:='';
  with Version do
  begin
    for i:=0 to VersionStrings.Count-1 do
    begin
      CatName := VersionStrings.ExtractName(VersionStrings.Strings[i]);
      if CatName='FileVersion' then
      begin
        Param := VersionStrings[i];
        j:=pos('.',Param);
        if j>0 then Param[j]:=' ';
        j:=pos('.',Param);
        if j>0 then Param[j]:=' ';
        j:=pos('.',Param);
        Param:=copy(Param,j+1,length(Param)-j);
        result:=Param;
//        if TryStrToProgramVersion(Param, PV) then
//          result:=IntToStr(PV.Build);
      end;
    end;
  end;
  Version.Free;

{
var
    i: Integer;
    Version: TFileVersionInfo;
    MyFile, MyVersion: String;
    CatName: string;
    Major,Minor,Release,Build: String;
  begin
    result:='';
    if GetVersionInfo(FileName, Major,Minor,Release,Build) then
    begin
      result:=Build;
    end;


    Version:=TFileVersionInfo.create(Nil);
    Version.fileName:=FileName;
    Version.ReadFileInfo;
    With Version do begin
      For i:=0 to VersionStrings.Count-1 do begin
        CatName := VersionStrings.ExtractName(VersionStrings.Strings[i]);
        if CatName='FileVersion' then
        begin
          result := VersionStrings[i];
        end;
      end;
    end;
    Version.Free;
 }
{$ENDIF}
end;

function CalcProfile(temp_deviation: integer; time_preheating, temp_preheating, time_measurment, temp_measurment, time_burn, temp_burn: integer; speed: double): TTempProfile;
const
  cMaxSpeed           = 40;                    //  максимальная скорость нагрева
//  cMesurmentsSpeed    = 5;                     //  скорость нагрева при измерении детекторов
  cStartTemp          = 0;                     //  начальная температура печки
  cChannels           = 300;                   //  количество каналов
//  cDeviation          = 50;                    //  допустимое отклонение при нагреве
  cTen                = 10;                    //  коэффициент для домножения (профиль выражен в десятых градуса)
  cTimeAdd            = 10;                    //  добавка для перехода в десятые секунды, введена, чтобы в будущем уйти от десятых долей
var
  i                   : integer;
  allTime             : integer;                 //  время измерения
  channelLength       : double;                  //  длительность канала
  preheatingChannels  : integer;                 //  количество каналов на преднагрев
  measurmentsChannels : integer;                 //  количество каналов на измерение
  burningChannels     : integer;                 //  количество каналов на дожиг
  maxSpeedChannel     : double;                  //  максимальная скорость нагрева
  SpeedChannel        : double;                  //  задаваемая скорость нагрева
  Profile             : TTempProfile;            //  массив температурного профиля (с длительностью нагрева и отклонением)
  FloatProfile        : array [0..299] of double;
begin
  allTime:=0;
  channelLength:=0;
  preheatingChannels:=0;
  measurmentsChannels:=0;
  burningChannels:=0;
  maxSpeedChannel:=0;
  SpeedChannel:=0;

  if time_preheating < 0 then time_preheating:=0;
  if temp_preheating < 0 then temp_preheating:=0;
  if time_measurment < 0 then time_measurment:=0;
  if temp_measurment < 0 then temp_measurment:=0;
  if time_burn < 0 then time_burn:=0;
  if temp_burn < 0 then temp_burn:=0;
  if speed < 0 then speed:=0;

  FillChar(profile, SizeOf(result), 0);
  allTime:=time_preheating+time_measurment+time_burn;            // общее время измерения
  if allTime>0 then
  begin
    channelLength:=(allTime/cChannels);                          // считаем длительность канала

    preheatingChannels:=round((time_preheating)/channelLength);  // считаем количество каналов на преднагрев

    if (preheatingChannels>=300) then preheatingChannels:=299;

    maxSpeedChannel:=((cMaxSpeed*channelLength)*cTimeAdd);           // считаем максимальную скорость нагрева, градусы на канал

    temp_preheating:=temp_preheating*cTen;  // выражаем в десятых градуса температуру преднагрева
    temp_measurment:=temp_measurment*cTen;  // выражаем в десятых градуса температуру измерения
    temp_burn:=temp_burn*cTen;              // выражаем в десятых градуса температуру дожига

    FillChar(FloatProfile, SizeOf(FloatProfile), 0);
    FloatProfile[0]:=cStartTemp*cTen;                   // первый элемент массива - начальная температура

    for i := 1 to preheatingChannels do                 // считаем профиль преднагрева
    begin
      if (FloatProfile[i-1]+maxSpeedChannel) < temp_preheating then    // до заданной температуры преднагрева (temp_heating), греем с максимальной скоростью
        FloatProfile[i]:=FloatProfile[i-1]+maxSpeedChannel
      else                                                             // если нагрели до температуры преднагрева - пишем температуру преднагрева (temp_heating) в течении оставшегося времени преднагрева (полка_преднагрева)
        FloatProfile[i]:=temp_preheating;
    end;

    burningChannels:=round((time_burn)/channelLength);            //  считаем каналы на дожиг
    measurmentsChannels:=cChannels-burningChannels;               //  считаем каналы на измерение
    speedChannel:=((Speed*channelLength)*cTimeAdd);                  //  считаем задаваемую скорость (speed) нагрева градусы на канал

    for i := preheatingChannels+1 to measurmentsChannels-1 do     // считаем профиль измерения
    begin
      if (FloatProfile[i-1]+speedChannel) < temp_measurment then  // до заданной температуры измерения (temp_measurment), греем с заданной скоростью
        FloatProfile[i]:=FloatProfile[i-1]+speedChannel
      else                                                        // если нагрели до температуры измерения - пишем температуру измерения (temp_measurment) в течении оставшегося времени измерения (полка_измерения)
        FloatProfile[i]:=temp_measurment;
    end;

    if measurmentsChannels > 0 then
    begin
      for i := measurmentsChannels to High(FloatProfile) do         // считаем профиль дожига
      begin
        if (FloatProfile[i-1]+maxSpeedChannel) < temp_burn then     // до заданной температуры дожига (temp_burn), греем с максимальной скоростью
          FloatProfile[i]:=FloatProfile[i-1]+maxSpeedChannel
        else                                                        // если нагрели до температуры дожига - пишем температуру дожигап (temp_burn) в течении оставшегося времени дожига (полка_дожига)
          FloatProfile[i]:=temp_burn;
      end;
    end;

    Profile[0]:=allTime*cTimeAdd;           // первый байт профиля - время измерения
    Profile[1]:=temp_deviation*cTen;            // второй байт профиля - отклонение при нагреве

    for i := 2 to High(Profile) do          // начиная с третьего байта записываем округленный до десятых градусов профиль
      Profile[i]:=Round(FloatProfile[i-2]);

  end;

  result := Profile;

end;

function GetSymbolFromUnicode(aCode: String) : String;
const
  cLength = 4;
var
  i,IntVal: integer;
begin
  for i := 1 to Length(aCode) Div cLength do
  begin
    IntVal := StrToInt('$'+(aCode[1]+aCode[2]+aCode[3]+aCode[4]));
    Delete(aCode, 1, cLength);
    Result:=Result+chr(IntVal);
  end;
end;


function DeleteDividers(Value: String): String;
var
  backupDBName: String;
begin
  try
    backupDBName:=StringReplace(Value, ' ', '', [rfReplaceAll]);
    backupDBName:=StringReplace(backupDBName, ':', '', [rfReplaceAll]);
    backupDBName:=StringReplace(backupDBName, '.', '', [rfReplaceAll]);
    Result:=backupDBName;
  except
    Result:='none';
  end;
end;

function IsReal(Value: String): boolean;
begin
  try
    StrToFloatRegion(Value);
    Result:=true;
  except
    Result:=false;
  end;
end;

function IsRealNAN(Value: string): boolean;
begin
  try
    if StrToFloatRegionNAN(Value).IsNan then
      Result:=false
    else
      Result:=true;
  except
    Result:=false;
  end;
end;

function DeleteLastCRLF(Value: String): String;
const
  cCR = #13;
  cLF = #10;
var
  index : integer;
begin
  index:=Length(Value);
  if index > 0 then
    if (Value[index] = cCR) OR (Value[index] = cLF) then Delete(Value,index,1);

  index:=Length(Value);
  if index > 0 then
    if (Value[index] = cCR) OR (Value[index] = cLF) then Delete(Value,index,1);

  Result:=Value;
end;

function SetBit(aWord: word; aBit: byte; aState: boolean = true): word; overload; // установка бита
begin
  if aState then
    Result:=aWord or (1 shl aBit)
  else
    Result:=aWord and (not (1 shl aBit));
end;

function SetBit64(aWord: int64; aBit: word; aState: boolean = true): int64;
const
  cBit: int64 = 1;
begin
  if aState then
    Result:=aWord or (cBit shl aBit)
  else
    Result:=aWord and (not (cBit shl aBit));
end;

function IsBitOn(Value: Integer; Bit: Byte): Boolean;                    // проверка установлен ли бит
begin
  Result:=(Value and (1 shl Bit)) <> 0;
end;

function IsBit64On(Value: Int64; Bit: Byte): Boolean;                    // проверка установлен ли бит
const
  cBit: int64 = 1;
begin
  Result:=(Value and (cBit shl Bit)) <> 0;
end;

function IsValueInRange(Value: double; Normal: double; Percent: integer): boolean;
const
  c100 = 100;
var
  calcPersent : double;
  levelMax    : double;
  levelMin    : double;
begin
  calcPersent:=(Normal*Percent)/c100;

  levelMin:=Normal-calcPersent;
  levelMax:=Normal+calcPersent;

  if (Value>=levelMin) and (Value<=levelMax) then
    result:=true
  else
    result:=false;

end;

function GetKSValueRange(Value: double; Normal: double; Percent: integer; KFilter: double): integer;
const
  c100            = 100;
  cFilteredPers   = 5;
var
  calcValuePersent    : double;
  calcFilterPersent   : double;
  levelValueMax       : double;
  levelValueMin       : double;
  levelFilterMax      : double;
  levelFilterMin      : double;
  filteredValue       : double;
begin
  filteredValue:=Value;

  calcValuePersent:=(Normal*Percent)/c100;

  levelValueMin:=Normal-calcValuePersent;
  levelValueMax:=Normal+calcValuePersent;

  if KFilter <> 0 then
    filteredValue:=Round(Normal/KFilter);

  calcFilterPersent:=(filteredValue*cFilteredPers)/c100;

  levelFilterMin:=filteredValue-calcFilterPersent;
  levelFilterMax:=filteredValue+calcFilterPersent;

  if (Value<levelValueMin) then
  begin
    if (Value>=levelFilterMin) and (Value<=levelFilterMax) then
      Result:=cKSFilterInstalled
    else
      Result:=cKSNotInRange;

  end
  else if (Value>levelValueMax) then
    Result:=cKSNotInRange
  else
    Result:=cKSNormal;

end;

function GetDetState(Value: TDetectorState) : integer;
begin
  case Value of
    stDetNotMeasured      :  result:=cDetNotMeasured;
    stDetWaitLoad         :  result:=cDetWaitLoad;
    stDetWaitMeas         :  result:=cDetWaitMeas;
    stDetMeasInProgress   :  result:=cDetMeasInProgress;
    stDetMeasFinished     :  result:=cDetMeasFinished;
    stDetMeasError        :  result:=cDetMeasError;
    stDetLost             :  result:=cDetLost;
    stDetBroken           :  result:=cDetBroken;
    stDetSkiped           :  result:=cDetSkiped;
    stDetMeasStopped      :  result:=cDetMeasStopped;
    stDetProcessedError   :  result:=cDetProcessedError;
    stDetProcessedWarning :  result:=cDetProcessedWarning;
    stDetProcessed        :  result:=cDetProcessed;
    stDetAcceptedError    :  result:=cDetProcessedError;
    stDetAcceptedWarning  :  result:=cDetProcessedWarning;
//    stDetAcceptedError    :  result:=cDetAcceptedError;
//    stDetAcceptedWarning  :  result:=cDetAcceptedWarning;
    stDetAccepted         :  result:=cDetAccepted;
    else                     result:=cDetNotMeasured;
  end;
end;

function GetDosStatus(Value: TDosimeterStatus) : integer;
begin
  case Value of
    stDosCalibrated       :  result:=cDosCalibrated;
    stDosNotCalibrated    :  result:=cDosNotCalibrated;
    stDosDecommissioned   :  result:=cDosDecommissioned;
    else                     result:=cDosUnknown; //cDosСalibrated;
  end;
end;

function GetDosValidity(Value: TDosimeterValidity) : integer;
begin
  case Value of
    stDosNotMeasured      :  result:=cDosNotMeasured;
    stDosWaitLoad         :  result:=cDosWaitLoad;
    stDosWaitMeasD1       :  result:=cDosWaitMeasD1;
    stDosWaitMeasD2       :  result:=cDosWaitMeasD2;
    stDosWaitMeasD3       :  result:=cDosWaitMeasD3;
    stDosWaitMeasD4       :  result:=cDosWaitMeasD4;
    stDosMeasInProgressD1 :  result:=cDosMeasInProgressD1;
    stDosMeasInProgressD2 :  result:=cDosMeasInProgressD2;
    stDosMeasInProgressD3 :  result:=cDosMeasInProgressD3;
    stDosMeasInProgressD4 :  result:=cDosMeasInProgressD4;
    stDosMeasFinishedD1   :  result:=cDosMeasFinishedD1;
    stDosMeasFinishedD2   :  result:=cDosMeasFinishedD2;
    stDosMeasFinishedD3   :  result:=cDosMeasFinishedD3;
    stDosMeasFinishedD4   :  result:=cDosMeasFinishedD4;
    stDosMeasErrorD1      :  result:=cDosMeasErrorD1;
    stDosMeasErrorD2      :  result:=cDosMeasErrorD2;
    stDosMeasErrorD3      :  result:=cDosMeasErrorD3;
    stDosMeasErrorD4      :  result:=cDosMeasErrorD4;
    stDosMeasStoppedD1    :  result:=cDosMeasStoppedD1;
    stDosMeasStoppedD2    :  result:=cDosMeasStoppedD2;
    stDosMeasStoppedD3    :  result:=cDosMeasStoppedD3;
    stDosMeasStoppedD4    :  result:=cDosMeasStoppedD4;
    stDosMeasWarning      :  result:=cDosMeasWarning;
    stDosMeasError        :  result:=cDosMeasError;
    stDosMeasFinished     :  result:=cDosMeasFinished;
    stDosMeasAccepted     :  result:=cDosMeasAccepted;
    stDosMeasUserWarning  :  result:=cDosMeasUserWarning;
    else                     result:=cDosNotMeasured;
  end;
end;

function GetDosStrValidity(Value: integer): String;
begin
  case Value of
    cDosMeasFinished      :  result:=rsDosMeasForProcessing;
    cDosMeasError         :  result:=rsDosMeasErr;
    cDosMeasWarning       :  result:=rsDosMeasWarning;
    cDosMeasAccepted      :  result:=rsDosAccepted;
    else                     result:=rsDosNotMeasured;
  end;
end;

function GetDosStrStatus(Value: integer): String;
begin
  case Value of
    cDosCalibrated       :  result:=rsDosCalibrated;
    cDosNotCalibrated    :  result:=rsDosNotCalibrated;
    cDosDecommissioned   :  result:=rsDosDecommissioned;
    else                    result:=rsDosUnknown;
  end;
end;

function ExecAndWait(const FileName,
                     Params,
                     LogFileName,
                     LogFilePath: String;
                     const WinState: Word): boolean; export;
{$IFDEF MSWINDOWS}
var
  StartInfo       : TStartupInfo;
  ProcInfo        : TProcessInformation;
  SecAtrtrs       : TSecurityAttributes;
  hOut            : THandle;
  hErr            : THandle;
  CmdLine         : String;
  logFileNameOut  : String;
  logFileNameErr  : String;
begin
  { Помещаем имя файла между кавычками, с соблюдением всех пробелов в именах Win9x }
  CmdLine := '"' + Filename + '" ' + Params;

  logFileNameOut:=ChangeFileExt(ExtractFileName(Params),'')+'_'+LogFileName+'_stdout.log';
  logFileNameErr:=ChangeFileExt(ExtractFileName(Params),'')+'_'+LogFileName+'_stderr.log';

  if not DirectoryExists(LogFilePath,False) then
    ForceDirectories(LogFilePath);

  with SecAtrtrs do
  begin
    nLength := SizeOf(TSecurityAttributes);
    lpSecurityDescriptor := nil;
    bInheritHandle := true; // ВОТ ОНО !!! Наша рукоятка будет НАСЛЕДУЕМОЙ
   end;

  if not DirectoryExists(LogFilePath,False) then
    ForceDirectories(LogFilePath);

  // Создаем файл в который и будем переназначать StdOut
  // Например, с такими настройками, вы можете их изменить под свои нужды
  hOut := CreateFile(PChar(LogFilePath+'\'+logFileNameOut), GENERIC_WRITE, 0, @SecAtrtrs, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if (hOut = INVALID_HANDLE_VALUE) then RaiseLastWin32Error;

  hErr := CreateFile(PChar(LogFilePath+'\'+logFileNameErr), GENERIC_WRITE, 0, @SecAtrtrs, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if (hErr = INVALID_HANDLE_VALUE) then RaiseLastWin32Error;

  GetStartupInfo(StartInfo);
  with StartInfo do
  begin
    wShowWindow := SW_HIDE{WinState}; // не показывать окно
    dwFlags := dwFlags or STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
    hStdOutput := hOut; // присваиваем рукоятку на свой файл
    hStdError := hErr;
  end;

  Result := Win32Check(CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, TRUE,
                          CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                          PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo));
  { Ожидаем завершения приложения }
  if Result then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);

    { Free the Handles }
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);

    CloseHandle(hOut);
    CloseHandle(hErr);
  end;
  {$ELSE}
  var
    ExecFileName  : String;
    logFileNameOut  : String;
    OutString: string;
    T: TextFile;
    flag: boolean;
  begin
    flag:=false;

    logFileNameOut:=ChangeFileExt(ExtractFileName(Params),'')+'_'+LogFileName+'_stdout.log';
    ExecFileName:=ChangeFileExt(ExtractFileName(Application.ExeName),'')+'_run_command.sh';

    if not DirectoryExists(LogFilePath,False) then
      ForceDirectories(LogFilePath);

    AssignFile(T, ExecFileName);
    Rewrite(T);
    Writeln(T,FileName+' '+Params);
    CloseFile(T);
  //  FileSetAttr(ExecFileName,777);
  //  RunCommand('bash '+ExecFileName, [Params], OutString, [], TShowWindowOptions(WinState));
    flag:=RunCommand('bash '+ExecFileName, OutString);

    AssignFile(T, LogFilePath+PathDelim+logFileNameOut);
    Rewrite(T);
    Writeln(T,OutString);

    CloseFile(T);

    Result:=flag;
  {$ENDIF}
end;

function ExecSh(const FileName,
                     Params,
                     LogFileName,
                     LogFilePath: String;
                     const WinState: Word): boolean; export;
var
  ExecFileName  : String;
  logFileNameOut  : String;
  OutString: string;
  T: TextFile;
  flag: boolean;
begin
  flag:=false;

  logFileNameOut:=ChangeFileExt(ExtractFileName(Params),'')+'_'+LogFileName+'_stdout.log';

  if not DirectoryExists(LogFilePath,False) then
    ForceDirectories(LogFilePath);

  {$IFDEF MSWINDOWS}
  {$ELSE}
  flag:=RunCommand('bash '+FileName, OutString);
  {$ENDIF}
  AssignFile(T, LogFilePath+PathDelim+logFileNameOut);
  Rewrite(T);
  Writeln(T,OutString);

  CloseFile(T);

  Result:=flag;
end;

function IntArrayToString(aMS: TIntArray):String;
var
  i: integer;
  St : String;
begin
  if length(aMS)=0 then
  begin
    result :='';
    Exit;
  end;

  St := IntToStr(aMS[0]);
  for i := Low(aMS)+1 to High(aMS) do // выводим в TChart
    St := St + ',' + IntToStr(aMS[i]);
  result := St;
end;

function StringToIntArray(aSt:String): TIntArray;
var
  ts: TStringList;
  i: integer;
begin
    ts := TStringList.Create;
    ts.Delimiter := ','; // устанавливаем разделитель
    ts.DelimitedText := aSt;
    // записываем массив в строку
    ts.Text := StringReplace(ts.Text, '{', '', [rfreplaceall]);
    // удаляем фигурные скобки
    ts.Text := StringReplace(ts.Text, '}', '', [rfreplaceall]); //

    if ts.Count = 1 then
      ts.Delete(0); // исключение для отсутствующих измерений

    SetLength(result,ts.Count);

    for i := 0 to ts.Count - 1 do // выводим в TChart
    begin
      result[i] := StrToInt(ts[i]);
    end;

    ts.Free;
end;

function DelBrackets(In_String, B_Open, B_Close: String): String;
var
  st  : String;
begin
  st:=StringReplace(In_String,B_Open,'',[rfreplaceall]);
  Result:=StringReplace(st,B_Close,'',[rfreplaceall]);
end;

end.
