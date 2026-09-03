unit uMessageForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DB, StdCtrls, ExtCtrls,
  ULanguages, USeparator,
  uLog;

// IBX.IBCustomDataSet, IBX.IBTable, IBX.IBQuery, IBX.IBScript, Vcl.Imaging.pngimage, IBX.IBDatabase,

type
  TMSGWindow = class(TForm)
//    MSGIBTable: TIBTable;
    Alarms1Label: TLabel;
    Alarms2Label: TLabel;
    ServiceLabel: TLabel;
    RepairLabel: TLabel;
    NoConnectionLabel: TLabel;
    RectangleShape: TShape;
//    UserMSGIBTable: TIBTable;
//    MSGIBQuery: TIBQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Alarms1LabelClick(Sender: TObject);
    procedure Alarms2LabelClick(Sender: TObject);
    procedure ServiceLabelClick(Sender: TObject);
    procedure RepairLabelClick(Sender: TObject);
    procedure NoConnectionLabelClick(Sender: TObject);
    procedure RectangleShapeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    MSGPriority,                      // переменная отвечающая за приоритет цвета в информационном окне
    CountAlarm1,                   // количество превышений уставки 1
    CountAlarm2,                   // количество превышений уставки 2
    CountService,                  // количество устройств требующих обслуживания
    CountRepair,                   // количество устройств требующих ремонта
    CountNoConnection: Integer;        // количество устройств с которыми нет связи
    procedure WriteMSG(ParamID: Double;DeviceID,Priority: Integer; MSG: String; Active: Boolean);     // процедура записи сообщений в БД
    procedure WriteUserMSG(UserMSG: String; Priority: Integer);                      // процедура записи действий оператора в БД
    { Public declarations }
  end;

const
  // константы приоритета сообщений
  cprAlarm2 = 1;         //  приоритет превышения аврийной уставки
  cprAlarm1 = 2;         //  приоритет превышения предупредительной уставки
  cprNoConnection = 3;   //  приоритет отсутствия связи
  cprRepair = 4;         //  приоритет ремонта
  cprService = 5;        //  приоритет обслуживания
  cprUserPriority = 1;   //  приоритеты для сообщений в журнал действий оператора (задел на будущее, пока приоритет у всех 1)

var
  MSGWindow: TMSGWindow;
  MgClr:  integer;
implementation
uses
  uMainForm,
//  uJournalForm,
  uUsersJournalForm;
//  uDataModuleForm;
{$R *.dfm}

procedure TMSGWindow.Alarms1LabelClick(Sender: TObject);
begin
  MSGWindow.FormClick(Self);
end;

procedure TMSGWindow.Alarms2LabelClick(Sender: TObject);
begin
  MSGWindow.FormClick(Self);
end;

procedure TMSGWindow.FormActivate(Sender: TObject);
begin
  // выбор цвета сообщений исходя из приоритета
  {if (MgClr <> 0) and (MgClr <= MSGPriority) then
  begin
    case MgClr of
    1:
      begin
        Color := RGB(255, 127, 127);       // превышена уставка 2
      end;
    2:
      begin
        Color := RGB(255, 255, 127);       // превышена уставка 1
      end;
    3:
      begin
        Color := RGB(127, 127, 127);       // нет связи
      end;
    4:
      begin
        Color := RGB(127, 127, 255);       // неисправность
      end;
    5:
      begin
        Color := RGB(127, 127, 255);       // требуется ремонт
      end;
    end;
  end
  else
  begin
    MgClr:=MSGPriority;
    case MgClr of
    1:
      begin
        Color := RGB(255, 127, 127);       // превышена уставка 2
      end;
    2:
      begin
        Color := RGB(255, 255, 127);       // превышена уставка 1
      end;
    3:
      begin
        Color := RGB(127, 127, 127);       // нет связи
      end;
    4:
      begin
        Color := RGB(127, 127, 255);       // неисправность
      end;
    5:
      begin
        Color := RGB(127, 127, 255);       // требуется ремонт
      end;
    end;
  end;

  if CountAlarm1 > 0 then                  // если количество больше 0, то выводим Label c числом
  begin
    Alarms1Label.Visible := True;
    Alarms1Label.Caption := rsAlarm1Acivated+' - '+IntToStr(CountAlarm1)+' ';
  end;
  if CountAlarm2 > 0 then
  begin
    Alarms2Label.Visible := True;
    Alarms2Label.Caption := rsAlarm2Acivated+' - '+IntToStr(CountAlarm2)+' ';
  end;
  if CountService > 0 then
  begin
    ServiceLabel.Visible := True;
    ServiceLabel.Caption := rsServiceIsRequired+' -'+IntToStr(CountService)+' ';
  end;
  if CountRepair > 0 then
  begin
    RepairLabel.Visible := True;
    RepairLabel.Caption := rsRepairIsRequired+' - '+IntToStr(CountRepair)+' ';
  end;
  if CountNoConnection > 0 then
  begin
    NoConnectionLabel.Visible := True;
    NoConnectionLabel.Caption := rsNoConnection+' - '+IntToStr(CountNoConnection)+' ';
  end;  }
end;

procedure TMSGWindow.FormClick(Sender: TObject);
begin
 { if DataModule1.IBdatabase.Connected then
  begin
    JW.Show;                               // показываем журнал при клике на области уведомления
    try
      if not JW.JournalIBTable.Active then//******
        JW.JournalIBTable.Active:=True;
      JW.JournalIBTable.Last;                // переходим на последнюю запись в журнале

    except

    end;

    Close;                                 // закрываем область уведомления после открытия журнала
    MgClr:=0;
    MSGPriority:=0;
    CountAlarm1:=0;
    CountAlarm2:=0;
    CountService:=0;
    CountRepair:=0;
    CountNoConnection:=0;
    Alarms1Label.Visible:=False;
    Alarms2Label.Visible:=False;
    ServiceLabel.Visible:=False;
    RepairLabel.Visible:=False;
    NoConnectionLabel.Visible:=False;
  end
  else
    MessageDlg(rsNoConnectionWithDB,mtWarning,[mbOK], 0); }
end;

procedure TMSGWindow.FormCreate(Sender: TObject);
begin
  {if DataModule1.IBdatabase.Connected then
  begin
    MSGIBTable.Active := True;
    MSGPriority:=0;
    CountAlarm1:=0;
    CountAlarm2:=0;
    CountService:=0;
    CountRepair:=0;
    CountNoConnection:=0;
    RectangleShape.SendToBack;
    DoubleBuffered := True;  // при старте программы сначала появлялся пустой прямоугольник окна, а потом уже надпись на нем
                             // с помощью этого свойства удалось избежать такого поведения
  end; }
end;

procedure TMSGWindow.FormDestroy(Sender: TObject);
begin
  WriteUserMSG(rsExit, cprUserPriority);
end;

procedure TMSGWindow.FormShow(Sender: TObject);
begin
//  Left := MainForm.GetDesktopRect.Width-Width;      // координаты правого нижнего угла
//  Top := MainForm.GetDesktopRect.Height-Height;     // всплывающего окна, относительно рабочего стола
end;

procedure TMSGWindow.NoConnectionLabelClick(Sender: TObject);
begin
  MSGWindow.FormClick(Self);
end;

procedure TMSGWindow.RepairLabelClick(Sender: TObject);
begin
  MSGWindow.FormClick(Self);
end;

procedure TMSGWindow.ServiceLabelClick(Sender: TObject);
begin
  MSGWindow.FormClick(Self);
end;

procedure TMSGWindow.RectangleShapeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MSGWindow.FormClick(Self);
end;

procedure TMSGWindow.WriteMSG(ParamID: Double; DeviceID,Priority: Integer; MSG: String; Active: Boolean);
begin
{  if MainForm.ServerMode then
  begin
    if Active then                                                                    // если сообщение активно
    begin
      if DataModule1.IBdatabase.Connected then
      try
        if not MSGIBTable.Active then;
          MSGIBTable.Active:=True;

        MSGIBTable.Append;                                                              // пишем в БД полученные значения
        MSGIBTable.FieldByName('PARAMID').AsBCD:=ParamID;                               // индекс измеренного параметра
        MSGIBTable.FieldByName('DEVICEID').AsInteger:=DeviceID;
        MSGIBTable.FieldByName('TIMEBEGIN').AsDateTime:=Now;                            // текущее время
        MSGIBTable.FieldByName('PRIORITY').AsInteger:=Priority;                         // приоритет сообщения
        MSGIBTable.FieldByName('MESSAGE').AsString:=MSG;                                // измеренное значение
        MSGIBTable.Post;
        DataModule1.IBTransaction.CommitRetaining;
        if JW.Showing then
          JW.JWIntervalComboBox.OnChange(Self);
      except
        on E : Exception do
        begin
          MSGIBTable.Active:=False;
          WriteLog('Can not write message in database');
          WriteLog(E.Message);   // Неудалось загрузить фонофый рисунок
        end;
      end;
    end
    else                                                                              // если сообщение закончилось,
    begin
      if DataModule1.IBdatabase.Connected then
      try
        MSGIBQuery.SQL.Clear;                                                         // то испотльзуя хранимую процедуру, пишем в БД время конца сообщения
        MSGIBQuery.SQL.Add('execute procedure EVENTENDTIME('+FloatToStrRegion(ParamID)+','+#39+MSG+#39','+#39+DateTimeToStrRegion(Now)+#39+')');
        MSGIBQuery.Open;
        DataModule1.IBTransaction.CommitRetaining;
        if JW.Showing then
          JW.JWIntervalComboBox.OnChange(Self);
      except
      on E : Exception do
        begin
          WriteLog('Can not write end of message in database');
          WriteLog(E.Message);
        end;
      end;
//**      MainForm.IBTransaction.CommitRetaining;
//**      JW.JWIntervalComboBox.OnChange(Self);
    end;
  end
  else
    JW.JWIntervalComboBox.OnChange(Self); // обновляем журнал }
end;

procedure TMSGWindow.WriteUserMSG(UserMSG: String; Priority: Integer);
begin
 { if MainForm.ServerMode then
  begin
    if DataModule1.IBdatabase.Connected then
    try
      if not USERMSGIBTable.Active then;
        USERMSGIBTable.Active:=True;

      USERMSGIBTable.Append;                                                              // пишем в БД полученные значения
      USERMSGIBTable.FieldByName('MESSAGE').AsString:=UserMSG;                            // измеренное значение
      USERMSGIBTable.FieldByName('TIMEBEGIN').AsDateTime:=Now;                            // текущее время
      USERMSGIBTable.FieldByName('PRIORITY').AsInteger:=Priority;                         // приоритет сообщения
      USERMSGIBTable.Post;
      DataModule1.IBTransaction.CommitRetaining;
      if Assigned(UJW.UJWIntervalComboBox) then
        UJW.UJWIntervalComboBox.OnChange(Self);
    except
      on E : Exception do
      begin
        WriteLog('Cant write message in database');
        WriteLog(E.Message);   // Неудалось загрузить фонофый рисунок
      end;
    end;
  end
  else
    begin
    if Assigned(UJW.UJWIntervalComboBox) then
      UJW.UJWIntervalComboBox.OnChange(Self); // обновляем журнал
    end; }
end;

end.
