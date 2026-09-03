unit uSeparator;

interface
uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Math;

  function StrToFloatRegion(const Value: String): double;
  function StrToFloatRegionNAN(const Value: String): double;
  function FloatToStrRegion(const Value: double): String;
  function SingleToStrRegion(const Value: single): String;
  function StrToDateTimeRegion(const Value: String): TDateTime;
  function StrToDateRegion(const Value: String): TDate;
  function DateTimeToStrRegion(const Value: TDateTime): String;
  function DateTimeToStr_Format(const Value: TDateTime): String;
  function DateToStrRegion(const Value: TDateTime): String;
  function TimeToStrRegion(const Value: TDateTime): String;
  function BoolToStrRegion(const Value: boolean): String;
  function StrToIntRegion(const Value: String): integer;
  function FloatToStrRegionF(const Value: double; aFormat: TFloatFormat; aPresission,aDigits: integer): String; overload;

implementation
uses
  uConst;
var
  MySettings: TFormatSettings;

function StrToIntRegion(const Value: String): integer;
var
  n: integer;
begin
  if TryStrToInt(Value,n) then
    Result:=n
  else
    Result:=-1;
end;

function StrToFloatRegion(const Value: String): double;
var
  St: String;
begin
  if (Value<>'') AND (Value<>'null') then
  begin
    St:=StringReplace(Value,',',MySettings.DecimalSeparator,[]);
    Result:=StrToFloat(st, MySettings);
  end
  else
    Result:=-1;
end;

function StrToFloatRegionNAN(const Value: String): double;
var
  St: String;
begin
  if (Value<>'') AND (Value<>'null') then
  begin
    St:=StringReplace(Value,',',MySettings.DecimalSeparator,[]);
    Result:=StrToFloat(st, MySettings);
  end
  else
    Result:=NAN;
end;

function FloatToStrRegion(const Value: double): String;
begin
  if IsNan(Value) then
    Result:=cNull
  else
    Result:=FloatToStr(Value, MySettings)
end;

function SingleToStrRegion(const Value: single): String;
begin
  if IsNan(Value) then
    Result:=cNull
  else
    Result:=FloatToStr(Value, MySettings)
end;

function FloatToStrRegionF(const Value: double; aFormat: TFloatFormat; aPresission,aDigits: integer): String; overload;
begin
  Result:=FloatToStrF(Value, aFormat, aPresission, aDigits, MySettings)
end;

function StrToDateTimeRegion(const Value: String): TDateTime;
begin
  if Value <> cEmptyData then
    Result:=StrToDateTime(Value,MySettings)
  else
    Result:=StrToDate(cZeroDate,MySettings);
end;

function StrToDateRegion(const Value: String): TDate;
begin
  if Value <> cEmptyData then
    Result:=StrToDate(Value,MySettings)
  else
    Result:=StrToDate(cZeroDate,MySettings);
end;

function DateTimeToStrRegion(const Value: TDateTime): String;
var
  t: String;
begin
  DateTimeToString(t,'dd.mm.yyyy H:mm:ss',Value);
  result := t;
end;

function DateTimeToStr_Format(const Value: TDateTime): String;
begin
  DateTimeToString(Result,'yyyy_MM_dd_H_mm',Value);
end;

function DateToStrRegion(const Value: TDateTime): String;
var
  t: String;
begin
  if (DateTimeToStr(VALUE) <> cZeroDate) then
  begin
    DateTimeToString(t,'dd.mm.yyyy',Value);
    result := t;
  end
  else
    Result:=cEmptyData;
end;

function TimeToStrRegion(const Value: TDateTime): String;
var
  t: String;
begin
  DateTimeToString(t,'H:mm:ss',Value);
  result := t;
end;

function BoolToStrRegion(const Value: boolean): String;
begin
  if Value then Result:='true' else Result:='false';
end;

Initialization

  //MySettings:=TFormatSettings.Create(LOCALE_USER_DEFAULT);
  MySettings.DecimalSeparator := '.';
  MySettings.DateSeparator := '.';
  MySettings.TimeSeparator := ':';
  MySettings.ShortDateFormat := 'dd.mm.yyyy';
  MySettings.ShortTimeFormat := 'H:mm:ss';

end.
