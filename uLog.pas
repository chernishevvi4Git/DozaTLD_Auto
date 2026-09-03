unit uLog;

interface

uses
  SysUtils,
  Forms;

  procedure WriteLog(Msg: String);
  procedure WriteModbusLog(Msg: String);
  procedure WriteProfilerLog(Discription,Value: String);
implementation
uses
  uConst;
procedure WriteLog(Msg: String);
var
  Log: TextFile;
  LogFilePath: String;
begin
  LogFilePath := extractfilepath(Application.ExeName) + cLogFileName;
  AssignFile(Log, LogFilePath);
  try
    if not FileExists(LogFilePath) then
      Rewrite(Log)
    else
      Append(Log);
    Writeln(Log, DateTimeToStr(Now),' -> ',Msg);
  finally
    CloseFile(Log);
  end;
end;

procedure WriteModbusLog(Msg: String);
var
  Log: TextFile;
  LogFilePath: String;
begin
  LogFilePath := extractfilepath(Application.ExeName) + cLogFileModbusName;
  AssignFile(Log, LogFilePath);
  try
    if not FileExists(LogFilePath) then
      Rewrite(Log)
    else
      Append(Log);
    Writeln(Log,Msg);
  finally
    CloseFile(Log);
  end;
end;

procedure WriteProfilerLog(Discription,Value: String);
var
  Log: TextFile;
  LogFilePath: String;
begin
  LogFilePath := extractfilepath(Application.ExeName) + cLogFileProfilerName;
  AssignFile(Log, LogFilePath);
  try
    if not FileExists(LogFilePath) then
      Rewrite(Log)
    else
      Append(Log);
    Writeln(Log, Discription,' -> ',Value);
  finally
    CloseFile(Log);
  end;
end;

end.
