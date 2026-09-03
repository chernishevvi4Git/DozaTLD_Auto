unit uTimerMessages;

interface

uses
 Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls, ExtCtrls;

type

  { TTimerMessage }

  TTimerMessage = class
  private
    FSeconds: Cardinal;
    timer : TTimer;
    Form  : TForm;
    procedure GoTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var anAction: TCloseAction);

  public
    constructor Create(aCaption: String; aTextMessage: String; aMsgType:TMsgDlgType; aButtons: TMsgDlgButtons; aTimeLimit: Cardinal) ;
end;

function TimerMessageDlg(aCaption: String; aTextMessage: String; aMsgType: TMsgDlgType; aButtons: TMsgDlgButtons; aTimeLimit: Cardinal): integer;

var
  CloseAllTimerMessages: boolean = false; // если на панели будет выбран ответ, то с неё придёт уведомление в виде трушного значения этой переменной
  CountActiveTimerMessages: integer = 0;

implementation
Uses uMainForm, uLanguages, uTLDCommand;

constructor TTimerMessage.Create(aCaption: String; aTextMessage: String; aMsgType: TMsgDlgType; aButtons: TMsgDlgButtons; aTimeLimit: Cardinal);
begin
  Form:=CreateMessageDialog(aTextMEssage,aMsgType, aButtons);
  inc(CountActiveTimerMessages);
  Form.Caption:=aCaption;
  Timer:= TTimer.Create(Form);
  Timer.Interval:=1000;
  Timer.OnTimer:=@Self.GoTimer;
  FSeconds:=aTimeLimit;
  Form.OnClose:= @FormClose;
  Timer.Enabled:=true;
end;

procedure TTimerMessage.GoTimer(Sender: TObject);
begin
  if Self.Form.Showing then
   begin
     dec(FSeconds);
    if (FSeconds = 0)then
    begin
     CloseAllTimerMessages := True;
     //MainForm.OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserAutoAnswered,'',cMsgRead,cMsgPriorityInf);
     //Form.ModalResult:=mrAbort; // по времени - вываливаемся в ожидание
     //Form.Close;
   end;
    if CloseAllTimerMessages then
    begin
     MainForm.OnCommandLog(FormatDateTime('hh:mm:ss.zzz',Now)+' : -> ',rsCommonUserPanelAnswered,'',cMsgRead,cMsgPriorityInf);
     if MainForm.TLDCommand.Panel.Input.DialogResult<>0 then Form.ModalResult:=MainForm.TLDCommand.Panel.Input.DialogResult;
     Form.Close;
   end;

  end;
end;

procedure TTimerMessage.FormClose(Sender: TObject; var anAction: TCloseAction);
begin
  dec(CountActiveTimerMessages);
  MainForm.TLDCommand.Panel.Output.ProcessStatus:=MainForm.TLDCommand.Panel.Output.ProcessStatus.ClearBit(procstateInfoMessage);// and $FFF9;  // сбрасываем биты 1 и 2 - Сбрасываем окно вопроса на панели
  MainForm.TLDCommand.Panel.Output.ProcessStatus:=MainForm.TLDCommand.Panel.Output.ProcessStatus.ClearBit(procstateFailMessage);// and $FFF9;
  //MainForm.TLDCommand.Panel.Output.AccidentNumber:=0;
  if CountActiveTimerMessages=0 then CloseAllTimerMessages:=false;
  if CountActiveTimerMessages<0 then CountActiveTimerMessages:=0; // на всякий случай
end;

function TimerMessageDlg(aCaption: String; aTextMessage: String; aMsgType: TMsgDlgType; aButtons: TMsgDlgButtons; aTimeLimit:Cardinal):integer;
var
  Mess: TTimerMessage;
begin
  Mess:=TTimerMessage.create(aCaption,aTextMessage,aMsgType,aButtons,aTimeLimit);
  result:=Mess.Form.ShowModal;
end;

end.

