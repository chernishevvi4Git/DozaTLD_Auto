unit SlavaStringLib;

interface
uses Classes, SysUtils;


//  resourcestring
//    errStringFail='StringLib: Ошибка строковых преобразований';

  type
    EStringFailure = class(Exception);
    TDevString = string[20];

  // Инициализация форматов строчного представления чисел и времени (запускается в самом начале автоматически)
  procedure MySetFormat;


// Параметры
  // Выбор наименования параметра при разделении строки символом '='
  function GetParamName(aSt: AnsiString):AnsiString;

  // Выбор значения при разделении строки символом '='
  function GetMeaning(aSt: AnsiString):AnsiString;

  // Выбор подстрок разделённых пробелами (начиная с первой) (пустая строка в случае ошибки)
  function ParseSpace(aSt: AnsiString; aNum: integer): AnsiString;

  // Выбор подстрок разделённых произвольным разделителем (начиная с первой) (пустая строка в случае ошибки)
  function ParseByDelimiter(aSt: AnsiString; aDelimiter: AnsiString; aNum: integer): AnsiString;

  // Перевод строки в число, -1 в случае неудачи
  function ParamToInt(aSt: AnsiString): integer;

  // Перевод строки вида "FuncName(0:'arg1',1:'arg2'...)" в значения Strings, false в случае неудачи
  //*function FuncArgumensToStrings(aSt: AnsiString; var aSts: TStringList): boolean;



// Работа с XML
  // GetXMLBody - выкусывание содержимого строки aSrc между тегами aParam (пустая строка в случае неудачи)
  //*function GetXMLBody(aSrc,aParam: String): String;

  // GetXMLBodyItem - выкусывание содержимого строки aSrc между тегами aParam под номером aItem (пустая строка в случае неудачи)
  //*function GetXMLBodyItem(aSrc,aParam: String; aItem: integer): String;

  // GetXMLBodyCount - подсчёт числа включений в строке aSrc элементов обрамлённых тегами aParam
  //*function GetXMLBodyCount(aSrc,aParam: String): integer;

  // GetXMLItemByIndex - возвращает XML-элемент верхнего уровня по индексу, если индекс за пределами - возвращает пустую строку
  // индекс начинается с 1 ?
  //*function GetXMLBodyByIndex(aSrc: String; aItem: integer): String;

  // GetXMLItemNameByIndex - возвращает XML-элемент верхнего уровня по индексу, если индекс за пределами - возвращает пустую строку
  // индекс начинается с 1 ?
  //*function GetXMLNameByIndex(aSrc: String; aItem: integer): String;

  // ChangeXMLBody - изменение содержимого строки aSrc между тегами aParam на aMean (добавляются теги с содержимым, если не было)
  //*function ChangeXMLBody(aSrc,aParam,aMean: String): String;

  // ChangeXMLTEG - изменение наименований параметров (тэгов)
  //*function ChangeXMLTEG(aSrc,aParam,aNewParam: String): String;

{
  // GetXMLTEGProperty - получение значения свойства ближайшего тега в строке aSrc
  function GetXMLTEGProperty(aSrc,aTEG,aProperty: AnsiString): AnsiString;

  // GetXMLTEGPropertyItem - получение значения свойства тега в строке aSrc под номером Item
  function GetXMLTEGPropertyItem(aSrc,aTEG,aProperty: AnsiString; aItem:integer): AnsiString;

  // GetXMLTEGPropertyWithPropertyAs - получение значения свойства ближайшего тега в строке aSrc при известном свойстве
  function GetXMLTEGPropertyWithPropertyAs(aSrc,aTEG,aKnownProperty,aKnownValue,aProperty: AnsiString): AnsiString;
}


// UDP
  // Конвертирование времени в строку, принятую в протоколе обмена по UDP
  //                                 DD.MM.YYYY hh.mm.ss
  function TimeToProtoTime(aTime: TDateTime):AnsiString;

  // Конвертирование строки, принятой в протоколе обмена по UDP во время
  //                                 DD.MM.YYYY hh.mm.ss
  function ProtoTimeToTime(aProtoTime: AnsiString):TDateTime;

  // Текущее время в строке, принятой в протоколе обмена по UDP
  //                                 DD.MM.YYYY hh.mm.ss
  function GetProtocolNowTime: TDevString;

  // Конвертирование времени в строку, принятую в протоколе обмена по RS232
  //                                 DD/MM/YYYY hh.mm.ss
  function TimeToParamProtocolTime(aTime: TDateTime):AnsiString;

// RS232
  // Конвертирование строки, принятой в протоколе обмена по RS232, во время
  //                                 DD/MM/YYYY hh.mm.ss
  function ParamProtocolTimeToTime(aProtoTime: AnsiString):TDateTime;



//Общие
  // Добавление к строке слева и справа заданного числа указанных символов, если строка меньше
  function AddLeft(aSt: AnsiString; num: integer; const Ch:char=' '):AnsiString;
  function AddRight(aSt: AnsiString; num: integer; const Ch:char=' '):AnsiString;

  // DateToName - возвращает дату в виде строки вида "2008-01-21"
  function DateToName(aDate: TDateTime; const aDelimiter:char='-'):AnsiString;

  // Преобразование строки в число (в независимости от разделителя)
  function SL_StrToFloat(aSt:AnsiString): Extended;

  // Преобразование строки в hex-строку
  function StringToHexString(aSt:AnsiString): AnsiString;

  // Преобразование hex-строки в число
  function HexToInt(aSt:AnsiString): int64;

  // Получение читаемой строки из бинарной (замена всех символов <#32)
  function GetReadedString(aSt:AnsiString): AnsiString;

  // Получение строки формата YYYYMMDD (Например '20130507') по дате
  function GetDateString(aDate: TDateTime): AnsiString;


// WideStrings
  function WideStringToString(s: WideString): AnsiString;


// общее форматирование по шаблону с возможностью замены \n на CRLF
function FormatMe(const S: AnsiString; const Args: array of const): AnsiString;



  var
    SysDecimalSeparator: char;
    SysFormatSettings,
    FormatSettings: TFormatSettings; // my populate

implementation
uses {RegExpr, }StrUtils, DateUtils;

  function GetParamName(aSt: AnsiString):AnsiString;
    var
      i: integer;
  begin
    result:='';
    i:=pos('=',aSt);
    if i>1 then begin
      result:=copy(aSt,1,i-1);
    end;
  end;


  function GetMeaning(aSt: AnsiString):AnsiString;
    var
      i: integer;
  begin
    result:='';
    i:=pos('=',aSt);
    if i<>0 then begin
      result:=copy(aSt,i+1,length(aSt)-i);
    end;
  end;


  function ParseSpace(aSt: AnsiString; aNum: integer): AnsiString;
    var
      i,j1,j2,m : integer;
      St: AnsiString;
  begin
    result:='';
    St:=aSt; j1:=0; j2:=0; m:=1;
    if length(aSt)=0 then Exit;
    for i:=1 to aNum do begin
      m:=i;
      j1:=j2;
      j2:=pos(' ',St);
      if j2=0 then begin
        j2:=length(St)+1;
        break;
      end;
      while (j2<length(aSt)) and (St[j2+1]=' ') do begin
        j2:=j2+1;
      end;
      St[j2]:='*';
    end;
    if m=aNum
      then result:=trim(copy(St,j1+1,j2-j1-1))
      else result:='';
  end;

  function ParseByDelimiter(aSt: AnsiString; aDelimiter: AnsiString; aNum: integer): AnsiString;
    var
      i,iPos: integer;
      St: AnsiString;
  begin
    result:='';
    St:=aSt;
    if length(St)=0 then Exit;
    for i:=1 to aNum do begin
      iPos:=pos(aDelimiter,St); // вхождение Delim
      if iPos<>0 then
        result:=copy(St,1,iPos-1)
      else begin
        if i=aNum
          then result:=St
          else result:='';
        break;
      end;
      St:=copy(St,iPos+length(aDelimiter),MaxInt);
    end;
{
    iPos:=posEx(aDelimiter,St,aNum+1); // вхождение Delim
    if iPos=0 then exit;
    i:=posEx(aDelimiter,St,aNum+2);
    if i=0 then i:=Length(aSt)+1;
    result:=copy(aSt,iPos+length(aDelimiter),i-iPos+1-length(aDelimiter));
}
  end;

  function ParamToInt(aSt: AnsiString): integer;
  begin
    try
      result:=StrToInt(aSt);
    except
      result:=-1;
    end;
  end;

  {//*
  function FuncArgumensToStrings(aSt: AnsiString; var aSts: TStringList): boolean;
    const
      ArgTemplate = '(\d)\:+\''(.+?)\''[\,\)\ ]';
  begin
    Result := false;
    aSts.Clear;
    with TRegExpr.Create do try
       Expression := ArgTemplate;
       if Exec (aSt) then
       REPEAT
         aSts.Values[Match[1]]:=Match[2];
         result:=true;
       UNTIL not ExecNext;
    finally Free;
   end;
  end;

  function GetXMLBody(aSrc,aParam: String): String;
  begin
    result := '';
    with TRegExpr.Create do try
      Expression := '<'+aParam+'>+(.+?)</'+aParam+'>';
       if Exec (aSrc) then
//       REPEAT
         result:=Match[1];
//       UNTIL not ExecNext;
    finally Free;
    end;
  end;

  function GetXMLBodyItem(aSrc,aParam: String; aItem: integer): String;
    var
      i: integer;
  begin
    result := '';
    with TRegExpr.Create do try
      Expression := '<'+aParam+'>+(.+?)</'+aParam+'>';
       if Exec (aSrc) then
       begin
         for i:=1 to aItem-1 do
           if not ExecNext then begin
//             break;
             result:='';
             Exit;
           end;
         result:=Match[1];
       end;
    finally Free;
    end;
  end;

  function GetXMLBodyCount(aSrc,aParam: String): integer;
    var
      i: integer;
  begin
    i:=0;
    with TRegExpr.Create do try
      Expression := '<'+aParam+'>+(.+?)</'+aParam+'>';
      if Exec (aSrc) then
      repeat
        i:=i+1;
      until not ExecNext;
      result:=i;
    finally Free;
    end;
  end;

  function GetXMLBodyByIndex(aSrc: String; aItem: integer): String;
    var
      i: integer;
  begin
    result := '';
    with TRegExpr.Create do try
      Expression :='<([^>]*?)>(.*?)</\1>';
       if Exec (aSrc) then
       begin
         for i:=1 to aItem-1 do
           if not ExecNext then
           begin
             result:='';
             Exit;
           end;
         result:=Match[2];
       end;
    finally Free;
    end;
  end;

  function GetXMLNameByIndex(aSrc: String; aItem: integer): String;
    var
      i: integer;
  begin
    result := '';
    with TRegExpr.Create do try
      Expression :='<([^>]*?)>(.*?)</\1>';
       if Exec (aSrc) then
       begin
         for i:=1 to aItem-1 do
           if not ExecNext then
           begin
             result:='';
             Exit;
           end;
         result:=Match[1];
       end;
    finally Free;
    end;
  end;

  function ChangeXMLBody(aSrc,aParam,aMean: String): String;
  begin
    result:=aSrc;
    with TRegExpr.Create do try
      result:=ReplaceRegExpr('<'+aParam+'>+(.+?)</'+aParam+'>',aSrc,'<'+aParam+'>'+aMean+'</'+aParam+'>');
      if result=aSrc then
      begin
        if GetXMLBodyCount(aSrc,aParam)=0 then
          result:=aSrc+'<'+aParam+'>'+aMean+'</'+aParam+'>';
      end;
    finally Free;
    end;
  end;

  function ChangeXMLTEG(aSrc,aParam,aNewParam: String): String;
  begin
    result:=aSrc;
    with TRegExpr.Create do try
      result:=ReplaceRegExpr('<'+aParam+'>+(.+?)</'+aParam+'>',aSrc,'<'+aNewParam+'>'+aParam+'</'+aNewParam+'>');
    finally Free;
    end;
  end;

 //*}

{
  function GetXMLTEGProperty(aSrc,aTEG,aProperty: AnsiString): AnsiString;
  begin
    result := '';
    with TRegExpr.Create do try
      Expression := '<'+aTEG+' '+aProperty+'="+(.+?)"';
       if Exec (aSrc) then
         result:=Match[1];
    finally Free;
    end;
  end;

  function GetXMLTEGPropertyItem(aSrc,aTEG,aProperty: AnsiString; aItem:integer): AnsiString;
    var
      i: integer;
  begin
    result := '';
    with TRegExpr.Create do try
      Expression := '<'+aTEG+' '+aProperty+'="+(.+?)"';
       if Exec (aSrc) then
       begin
         for i:=1 to aItem-1 do
           if not ExecNext then break;
         result:=Match[1];
       end;
    finally Free;
    end;
  end;

  function GetXMLTEGPropertyWithPropertyAs(aSrc,aTEG,aKnownProperty,aKnownValue,aProperty: AnsiString): AnsiString;
  begin
    result := '';
    with TRegExpr.Create do try
      Expression := '<'+aTEG+' '+aKnownProperty+'="'+aKnownValue+'*?'+'="+(.+?)"';
      Expression := '<'+aTEG+' '+aProperty+'="+(.+?)"';
       if Exec (aSrc) then
         result:=Match[1];
    finally Free;
    end;
  end;
}


function ProtoTimeToTime(aProtoTime: AnsiString):TDateTime;
 var
   yy,mm,dd,h,m,s: word;
begin
  result:=0;
  if Length(aProtoTime)<19 then Exit;
  yy:=strToInt(aProtoTime[1]+aProtoTime[2]+aProtoTime[3]+aProtoTime[4]);
  mm:=strToInt(aProtoTime[6]+aProtoTime[7]);
  dd:=strToInt(aProtoTime[9]+aProtoTime[10]);
  h:=strToInt(aProtoTime[12]+aProtoTime[13]);
  m:=strToInt(aProtoTime[15]+aProtoTime[16]);
  s:=strToInt(aProtoTime[18]+aProtoTime[19]);
  result:=EncodeDateTime(yy,mm,dd,h,m,s,0);
//  result:=StrToDateTime(aProtoTime,FormatSettings);
end;

function TwoDigit(w: word): AnsiString;
begin
  result:=IntToStr(w);
  if length(result)<2 then result:='0'+result;
end;

function TimeToProtoTime(aTime: TDateTime):AnsiString;
 var
   yy,mm,dd,h,m,s,ss: word;
begin
  DecodeDateTime(aTime,yy,mm,dd,h,m,s,ss);
  result:=IntToStr(yy)+'.'+TwoDigit(mm)+'.'+TwoDigit(dd)+' '+TwoDigit(h)+'.'+TwoDigit(m)+'.'+TwoDigit(s);
end;

function TimeToParamProtocolTime(aTime: TDateTime):AnsiString;
  //                                 DD/MM/YYYY hh.mm.ss
 var
   yy,mm,dd,h,m,s,ss: word;
begin
  DecodeDateTime(aTime,yy,mm,dd,h,m,s,ss);
//  result:=IntToStr(dd)+'/'+TwoDigit(mm)+'/'+TwoDigit(yy)+' '+TwoDigit(h)+'.'+TwoDigit(m)+'.'+TwoDigit(s);
  result:=TwoDigit(dd)+'/'+TwoDigit(mm)+'/'+TwoDigit(yy)+' '+TwoDigit(h)+'.'+TwoDigit(m)+'.'+TwoDigit(s); // TwoDigit(dd) - для DZA2DAF оказалось необходимо
end;

function ParamProtocolTimeToTime(aProtoTime: AnsiString):TDateTime;
  //                                 DD/MM/YYYY hh.mm.ss
 var
   yy,mm,dd,h,m,s: word;
begin
  result:=0;
  if Length(aProtoTime)<19 then Exit;
  dd:=strToInt(aProtoTime[1]+aProtoTime[2]);
  mm:=strToInt(aProtoTime[4]+aProtoTime[5]);
  yy:=strToInt(aProtoTime[7]+aProtoTime[8]+aProtoTime[9]+aProtoTime[10]);
  h:=strToInt(aProtoTime[12]+aProtoTime[13]);
  m:=strToInt(aProtoTime[15]+aProtoTime[16]);
  s:=strToInt(aProtoTime[18]+aProtoTime[19]);
  result:=EncodeDateTime(yy,mm,dd,h,m,s,0);
end;

function GetProtocolNowTime: TDevString;
begin
  result:=TimeToProtoTime(Now);
end;

// Добавление к строке слева заданного числа указанных символов, если строка меньше
function AddLeft(aSt: AnsiString; num: integer; const Ch:char=' '):AnsiString;
begin
  result:=aSt;
  while length(result)<num do
    result:=Ch+result;
end;

// Добавление к строке справа заданного числа указанных символов, если строка меньше
function AddRight(aSt: AnsiString; num: integer; const Ch:char=' '):AnsiString;
begin
  result:=aSt;
  while length(result)<num do
    result:=result+Ch;
end;


procedure MySetFormat;
begin
  FormatSettings.DecimalSeparator:='.';
//  GetLocaleFormatSettings(0,FormatSettings);
  SysFormatSettings:=FormatSettings;
  FormatSettings.DecimalSeparator:='.';
  FormatSettings.TimeSeparator:='.';
  FormatSettings.DateSeparator:='/';
  FormatSettings.ShortDateFormat:='dd.MM.yyyy';
  FormatSettings.ShortTimeFormat:='hh.mm.ss';
  FormatSettings.LongDateFormat:='dd.MM.yyyy hh.mm.ss';
// DD/MM/YYYY hh.mm.ss для ProtoTime
end;

function DateToName(aDate: TDateTime; const aDelimiter:char='-'):AnsiString;
 var
   yy,mm,dd,h,m,s,ss: word;
begin
  DecodeDateTime(aDate,yy,mm,dd,h,m,s,ss);
  result:=IntToStr(yy)+'-'+TwoDigit(mm)+'-'+TwoDigit(dd);
end;

function SL_StrToFloat(aSt:AnsiString): Extended;
begin
  try
    result:=StrToFloat(aSt);
  except
    aSt:=StringReplace(aSt,'.',',',[rfReplaceAll]);
    try
      result:=StrToFloat(aSt);
    except
      aSt:=StringReplace(aSt,',','.',[rfReplaceAll]);
      try
        result:=StrToFloat(aSt);
      except
        Raise EMathError.Create('Некорректное представление числового значения');
      end;
    end;
  end;
end;

// Преобразование строки в hex-строку
function StringToHexString(aSt:AnsiString): AnsiString;
var
  i: integer;
begin
  result:='';
  for i:=1 to length(aSt) do
  begin
    result:=result+IntToHex(ord(aSt[i]),2)+' ';// пришедшая строка в hex
  end;
  result:=trim(result);
end;

function HexToInt(aSt:AnsiString): int64;
const
  HST='0123456789ABCDEF';
var
  i,buf: integer;
begin
  result:=0;
  for i:=1 to length(aSt) do
  begin
    buf:=pos(aSt[i],HST);
    if buf>0 then result:=result*16 + buf-1;
  end;
end;

function GetReadedString(aSt:AnsiString): AnsiString;
var
  i: integer;
begin
  result:='';
  for i:=1 to Length(aSt) do
    if ord(aSt[i])>31
      then result:=result + aSt[i]
      else result:=result + '.';
end;

function GetDateString(aDate: TDateTime): AnsiString;
  //                                 DD/MM/YYYY hh.mm.ss
 var
   yy,mm,dd,h,m,s,ss: word;
begin
  DecodeDateTime(aDate,yy,mm,dd,h,m,s,ss);
  result:=TwoDigit(yy)+TwoDigit(mm)+TwoDigit(dd);
end;



function WideStringToString(s: WideString): AnsiString;
type
  TWideRec = record
  case integer of
    0: ( wch: WideChar);
    1: ( ch: AnsiChar;
      code: byte;
        );
  end;
var
  ch: TWideRec;
  a: array [0..1] of byte absolute ch;
  i: integer;
begin
  setlength(result,length(s));
  for i:=1 to length(s) do
  begin
    ch.wch:=s[i];
    if ch.code = 0
    then result[i]:=ch.ch
    else result[i]:=AnsiChar(ord(ch.ch)+176);
  end;
end;


// общее форматирование по шаблону с возможностью замены \n на CRLF
function FormatMe(const S: AnsiString; const Args: array of const): AnsiString;
const
  CRLF = #13#10;
begin
  result:=StringReplace(Format(S,Args),'\n',CRLF,[rfReplaceAll]);
//  result:=FormatMe(S,Args);
end;


initialization
  SysDecimalSeparator:=FormatSettings.DecimalSeparator;
  MySetFormat;
end.
