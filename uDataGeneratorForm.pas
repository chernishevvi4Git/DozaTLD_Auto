unit uDataGeneratorForm;

interface

uses
//  Messages,
  SysUtils, Variants,
// System.UITypes,
  Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, uDosimeter, uDetector, ComCtrls, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls,
//  DynVarsEh,
  DB, odbcconn, SQLDB, GridsEh,
  DBAxisGridsEh, DBGridsEh, uDataModule;
  // Data.Win.ADODB, Data.Win.ADODB, Data.Win.ADODB,

type

  { TGeneratorForm }

  TGeneratorForm = class(TForm)
    BtnDataGenerator: TButton;
    EditMeasCnt: TEdit;
    LblMeasCnt: TLabel;
    LblTitle: TLabel;
    ProgressBarGenegator: TProgressBar;
    DBGridEhOpenBDGen: TDBGridEh;
    ADOQueryGen: TSQLQuery;
    DataSourceGen: TDataSource;
    ADOConnectionGen: TODBCConnection;
    ADOQueryOpenBDName: TSQLQuery;
    DataSourceOpenBDName: TDataSource;
    DBGridEhDetResGen: TDBGridEh;
    BtnOpen: TButton;
    BtnGen: TButton;
    MemoComment: TMemo;
    procedure BtnDataGeneratorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditMeasCntChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEhOpenBDGenCellClick(Column: TColumnEh);
    procedure DBGridEhOpenBDGenDblClick(Sender: TObject);
    procedure BtnOpenClick(Sender: TObject);
    procedure BtnGenClick(Sender: TObject);
  private
    { Private declarations }
    FDBName       : String;
    MeasCnt       : integer;
    Dosimeter     : TDosimeter;

    function GetDBConnection: boolean;
    function GetValForQuery: boolean;
    procedure DBGridClick;
    procedure RefreshDBList;
    procedure RefreshDBMeasureList;
    procedure SetDBName(aDBName: String);
    procedure ConnectToDB(aDBName: String);
    procedure CreateDosimeter(FullName: String);
    procedure CreateDosimeterRandomData(aDosId: integer; aPostfix: String; aKS: integer);  // добавление новой (чистой) записи в таблицу результатов измерений (при старте измерений после считывания КСИ)
    procedure OpenDB;
    procedure DBGridSetFocus(aLine: integer);

    procedure SaveDetectorRandomData(aMeasurmentID    : integer;
                                     aDetectorType    : String;
                                     aDose            : String;
                                     aPosition        : integer;
                                     aMeasurmentTime  : String;
                                     aProcessingCurve : String;
                                     aAutoProcessing  : boolean;
                                     aValidity        : integer
                                     );  // запись в БД результатов измерений детекторов

    procedure SaveDetectorTransformData(aDosimeterID     : integer;
                                        aMeasurmentID    : integer;
                                        aDetectorType    : String;
                                        aDose            : String;
                                        aPosition        : integer;
                                        aMeasurmentTime  : String;
                                        aProcessingCurve : String;
                                        aAutoProcessing  : boolean;
                                        aValidity        : integer;
                                        aComment         : String
                                        );

    procedure SaveDosimeterRandomData(aMeasID         : integer;
                                      aType           : String;
                                      aDose           : String;
                                      aError          : String;
                                      aFormula        : String;
                                      aMeasTime       : TDateTime;
                                      aRegTime        : TDateTime;
                                      aVerTime        : TDateTime;
                                      aValidity       : integer;
                                      aStatus         : integer;
                                      aKh10           : double;
                                      aKh10g          : double;
                                      aKh10n          : double;
                                      aKhgn           : double;
                                      aKh3            : double;
                                      aKh007          : double;
//                                      aKhr1           : double;
//                                      aKhr2           : double;
                                      aPartID         : integer;
                                      aTldID          : integer;
                                      aSoftVer        : integer;
                                      aTldUser        : String;
                                      aPersNumber     : integer;
                                      aFio            : String;
                                      aOrg            : String;
                                      aDepartment     : String;
                                      aDosComment     : String;
                                      aMeasComment    : String
                                      );        // запись в БД результатов измерений дозиметров
  public
    property DBName: String read FDBName write SetDBName;
    property IsConnected: boolean read GetDBConnection;

    property IsCorrectValForQuery: boolean read GetValForQuery;
    { Public declarations }
  end;

var
  GeneratorForm: TGeneratorForm;

implementation

{$R *.dfm}

uses
  uMainForm,
  uFunctions,
  uSeparator,
  uConst;

function TGeneratorForm.GetValForQuery: boolean;
begin
  FDBName:=DBGridEhOpenBDGen.DataSource.DataSet.FieldByName(cDBName).AsString;            // dosimeterid выделенной строки
  if (FDBName<>'') then
    result:=true
  else
    result:=false;
end;

procedure TGeneratorForm.OpenDB;
var
  GridLineIndex: integer;
begin
  GridLineIndex:=DBGridEhOpenBDGen.DataSource.DataSet.RecNo;
  ConnectToDB(DBName);
  DBGridSetFocus(GridLineIndex);
end;

procedure TGeneratorForm.BtnDataGeneratorClick(Sender: TObject);
var
  i,j,k       : integer;
  RandomCnt   : integer;
  FullDosName : String;
begin
  ProgressBarGenegator.Min:=0;
  ProgressBarGenegator.Max:=MainForm.DBGridEhDos.DataSource.DataSet.RecordCount-1;;
  ProgressBarGenegator.Visible:=true;

  BtnDataGenerator.Enabled:=false;

  try

    for i := 0 to MainForm.ADOQueryDosList.RecordCount-1 do
    begin
      ProgressBarGenegator.Position:=i;

      FullDosName := MainForm.DBGridEhDos.DataSource.DataSet.Fields[0].AsString;

      //RandomCnt:=Random(MeasCnt);
      //RandomCnt:=200;

      RandomCnt:=MeasCnt;

      for k := 0 to RandomCnt-1 do
      begin

        CreateDosimeter(FullDosName);
        if Assigned(Dosimeter) then
        begin
          Dosimeter.KS:=Random(100);
          CreateDosimeterRandomData(Dosimeter.ID,Dosimeter.Postfix,Dosimeter.KS);

          for j := 0 to Dosimeter.DetectorsList.Count-1 do
          begin
            if (Dosimeter.DetectorsList[j]<>nil) then
            begin
              SaveDetectorRandomData(Dosimeter.MeasurementID,TDetector(Dosimeter.DetectorsList[j]).DetType,'101',j+1,DateTimeToStr(Now),'',true,0); // сохранение результатов узмерений детектора 1
            end;

          end;

          Dosimeter.MeasTime:=Now;
          //Dosimeter.Dose:=IntToStr(Random(100))+'мЗв';
          Dosimeter.Dose_Hp_10g:=Random(100);
          Dosimeter.Error:='0.1 мЗв';
          //Dosimeter.TldId:=MainForm.DeviceID;
          Dosimeter.Status:=TDosimeterStatus(Random(4));
          Dosimeter.Validity:=TDosimeterValidity(Random(26));

          SaveDosimeterRandomData(Dosimeter.MeasurementID,
                                  Dosimeter.DosType,
                                  FloatToStrRegion(Dosimeter.Dose_Hp_10g),
                                  Dosimeter.Error,
                                  Dosimeter.Formula,
                                  Dosimeter.MeasTime,
                                  Dosimeter.RegTime,
                                  Dosimeter.VerTime,
                                  GetDosValidity(Dosimeter.Validity),
                                  GetDosStatus(Dosimeter.Status),
                                  Dosimeter.K1,
                                  Dosimeter.K2,
                                  Dosimeter.K3,
                                  Dosimeter.K4,
                                  Dosimeter.K5,
                                  Dosimeter.Kgn,
//                                  Dosimeter.Khr1,
//                                  Dosimeter.Khr2,
                                  Dosimeter.PartID,
                                  MainForm.DeviceID,
                                  Dosimeter.SoftwareVer,
                                  Dosimeter.TldUser,
                                  Dosimeter.PersNumber,
                                  Dosimeter.Fio,
                                  Dosimeter.Organization,
                                  Dosimeter.Department,
                                  Dosimeter.LastMeasComment,
                                  Dosimeter.MeasComment
                                  );

        end;

      end;

      MainForm.DBGridEhDos.DataSource.DataSet.Next;

    end;

  except
    on E: exception do
      MessageDlg(E.Message,mtError, [mbOK], 0);
  end;

  MainForm.DBGridEhDos.DataSource.DataSet.First;

  ProgressBarGenegator.Visible:=false;
  BtnDataGenerator.Enabled:=true;
end;


procedure TGeneratorForm.CreateDosimeter(FullName: String);
begin
  if Assigned(Dosimeter) then
    begin
      FreeAndNil(Dosimeter);
      Dosimeter:=TDosimeter.Create(FullName);
    end
    else
    begin
      Dosimeter:=TDosimeter.Create(FullName);
    end;
end;

procedure TGeneratorForm.CreateDosimeterRandomData(aDosId: integer; aPostfix: String; aKS: integer);
begin
// добавляем новую (чистую) запись в результатах измерений
  try
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('INSERT INTO tlddosimeterres('+cFieldDosID+','
                                                                 +cFieldDosPostfix+','
                                                                 +cFieldTldID+','
                                                                 +cFieldKSI+
                                                               ') '+
                                                        'VALUES('+IntToStr(aDosId)+','
                                                             +#39+aPostfix+#39+','
                                                                 +'33'+','
                                                                 +IntToStr(aKS)+
                                                               ')');
    TLDDataModule.ADOQuery.ExecSQL;
  except
    on E: exception do
      MessageDlg(E.Message,mtError, [mbOK], 0);
  end;
// находим индекс новой записи (автоинкрементируемое поле)
  try
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDosMeasID+' FROM tlddosimeterres');
    TLDDataModule.ADOQuery.Active:=True;
    TLDDataModule.ADOQuery.Last; // перемещаемся на последнюю, только что добавленную запись
  except
    on E: exception do
      MessageDlg(E.Message,mtError, [mbOK], 0);
  end;

  Dosimeter.MeasurementID:=TLDDataModule.ADOQuery.FieldValues[cFieldDosMeasID];
end;

procedure TGeneratorForm.DBGridClick;
begin
  IsCorrectValForQuery
end;

procedure TGeneratorForm.DBGridEhOpenBDGenCellClick(Column: TColumnEh);
begin
  DBGridClick;
end;

procedure TGeneratorForm.DBGridEhOpenBDGenDblClick(Sender: TObject);
begin
  OpenDB;
end;

procedure TGeneratorForm.DBGridSetFocus(aLine: integer);
begin
  if aLine>0 then
  begin
    DBGridEhOpenBDGen.DataSource.DataSet.RecNo:=aLine;
    DBGridClick;
  end;
end;

procedure TGeneratorForm.EditMeasCntChange(Sender: TObject);
begin
  MeasCnt:=StrToInt(EditMeasCnt.Text);
end;

procedure TGeneratorForm.FormCreate(Sender: TObject);
begin
  MeasCnt := 1;
  EditMeasCnt.Text := IntToStr(MeasCnt);
end;

procedure TGeneratorForm.FormShow(Sender: TObject);
begin
  RefreshDBList;
end;

function TGeneratorForm.GetDBConnection: boolean;
begin
  result:=ADOConnectionGen.Connected;
end;

procedure TGeneratorForm.RefreshDBList;
begin
  if not IsConnected then
  begin
    ConnectToDB(cPostgreDefaultDB);
  end;

  // получаем список доступных баз данных, с нумерацией по порядку, за исключением предустановленных баз (postgres, template1, template0)
  ADOQueryOpenBDName.SQL.Clear;
  ADOQueryOpenBDName.SQL.Add('select row_number() OVER(), datname '
                        +'from pg_database where '
                        +'(datname <> '+#39+'postgres'+#39+') AND '
                        +'(datname <> '+#39+'template1'+#39+') AND '
                        +'(datname <> '+#39+'template0'+#39+')');
  ADOQueryOpenBDName.Open;

  DBGridEhOpenBDGen.Columns[0].Width:=25;
  DBGridEhOpenBDGen.Columns[0].Title.caption:='   '+'№';
  DBGridEhOpenBDGen.Columns[1].Width:=100;
  DBGridEhOpenBDGen.Columns[1].Title.caption:=' '+'Имя файла';

  ADOQueryOpenBDName.Close;
end;

procedure TGeneratorForm.RefreshDBMeasureList;
begin
  //if IsConnected then
  if TLDDataModule.IsDBConnected then
  begin
    try
      if ADOQueryGen.Active then ADOQueryGen.Close;
      ADOQueryGen.SQL.Clear;
      ADOQueryGen.SQL.Add('select * from tlddetectorres');
      ADOQueryGen.Open;

      DBGridEhDetResGen.SetFocus;

      ADOQueryGen.Close;
    except
      on E: exception do
        MessageDlg(E.Message,mtError, [mbOK], 0);
    end;
  end;
end;

procedure TGeneratorForm.SaveDetectorRandomData(aMeasurmentID    : integer;
                                                aDetectorType    : String;
                                                aDose            : String;
                                                aPosition        : integer;
                                                aMeasurmentTime  : String;
                                                aProcessingCurve : String;
                                                aAutoProcessing  : boolean;
                                                aValidity        : integer
                                                );
var
  i: integer;
  ktv: String;
  tmp: String;
  calcFon   : String;
  calcGaus  : String;
  autoStr   : String;
begin

  ktv:='';

  tmp:='19.6,19.6,19.6,19.6,20.4,23.8,28.6,32.5,36.3,40.1,'+
       '44.2,48.5,53.6,57.2,61.3,65,68.9,72.8,76.7,82.1,'+
       '86.1,89.9,94,97.9,101.6,106.1,110.6,114.7,118.7,122.5,124,'+
       '124.3,124,123.8,123.5,123.2,123.5,123.2,123.5,123.2,124.3,'+
       '125.3,126.4,126.5,127.4,128.5,129.2,130.3,130.5,131.5,132.4,'+
       '133.4,134.5,135.4,135.5,136.2,137.3,138.2,139.3,140.2,140.3,'+
       '141.2,142.3,143.3,144.2,145.3,145.4,146.2,147.2,148.1,149.1,'+
       '150.1,150.2,151.1,152.3,153.2,154.3,154.4,155,156.1,157.2,'+
       '158.3,159.1,159.2,160,161.2,162,163,164.2,164.5,165.1,166.1,'+
       '167,168,169,169.3,170,171.2,172.3,173.2,173.3,173.9,'+
       '175,176.1,177.1,178.1,178.1,179,179.9,181.1,182,183,'+
       '183.2,184,185,185.9,186.8,188,188.2,188.9,189.8,'+
       '190.7,192.1,192.1,193,194,194.9,195.7,197,196.9,'+
       '197.8,198.8,199.9,200.7,202,202,202.9,203.9,204.8,'+
       '205.7,206.9,206.9,208,208.8,209.9,210.7,212,212,212.9,'+
       '214,214.9,215.8,215.8,216.8,217.9,218.8,219.7,220.9,221,'+
       '221.7,222.7,223.9,224.8,225.5,226,226.7,227.8,228.8,229.9,'+
       '230.8,230.8,231.5,232.7,233.8,234.8,235,235.7,236.8,237.8,'+
       '238.7,239.5,239.8,240.7,241.9,242.8,243.5,244.7,244.7,245.8,'+
       '246.7,247.7,248.6,249.7,249.7,250.7,251.8,252.7,253.6,253.7,'+
       '254.5,255.7,256.6,257.6,258.5,258.8,259.4,260.6,261.7,262.7,'+
       '263.5,263.6,264.5,265.6,266.5,267.4,268.4,268.7,269.5,270.5,'+
       '271.6,272.6,273.5,273.7,274.4,275.5,276.5,277.6,277.7,278.5,'+
       '279.5,280.4,281.5,282.5,282.5,283.4,284.5,285.5,286.6,287.5,'+
       '287.5,288.4,289.4,290.5,291.5,292.4,292.6,293.3,294.3,295.4,'+
       '296.5,296.3,297.2,300.3,305,309.5,314,317.8,321.5,325.7,329.6,'+
       '330.7,330.3,330.2,330.2,330.2,330.2,330.2,330.2,330.2,330.2,'+
       '330.2,330.2,330.2,330.2,330.2,330.2,330.2,330.2,330.2,330.2,'+
       '330.1,330.2,330.2,330.2,330.2,330.2,330.1,330.2,330.2,330.2,'+
       '330.2,330.2,330.1,330.2,330.2,330.1,330.2,330.2,329.6,328.7';

  for i := 0 to 299 do
  begin
    if (ktv = '') then ktv := IntToStr(Random(100)) else ktv := ktv+','+IntToStr(Random(100));
    if (calcFon = '') then calcFon := IntToStr(Random(100)) else calcFon := calcFon+','+IntToStr(Random(100));
    if (calcGaus = '') then calcGaus := IntToStr(Random(100)) else calcGaus := calcGaus+','+IntToStr(Random(100));
  end;

  if not aAutoProcessing then autoStr := 'false' else autoStr := 'true';

  TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
  TLDDataModule.ADOQuery.SQL.Add('INSERT INTO tlddetectorres('+cFieldDosMeasID+','
                                                              +cFieldDetType+','
                                                              +cFieldDose+','
                                                              +cFieldDetPosition+','
                                                              +cFieldKTV+','
                                                              +cFieldTempProfile+','
                                                              +cFieldCalcFon+','
                                                              +cFieldCalcGaus+','
                                                              +cFieldMeasureTime+','
                                                              +cFieldAutoProc+','
                                                              +cFieldDetStatus+
                                                            ') '+
                                                     'VALUES('+IntToStr(aMeasurmentID)+','
                                                          +#39+aDetectorType+#39+','
                                                              +aDose+','
                                                              +IntToStr(aPosition)+','
                                                     +#39+#123+ktv+#125+#39+','
                                                     +#39+#123+tmp+#125+#39+','
                                                     +#39+#123+calcFon+#125+#39+','
                                                     +#39+#123+calcGaus+#125+#39+','
                                                          +#39+aMeasurmentTime+#39+','
                                                          //+#39+aProcessingCurve+#39+','
                                                          +#39+autoStr+#39+','
                                                              +IntToStr(aValidity)+
                                                            ')');
  TLDDataModule.ADOQuery.ExecSQL;
end;

procedure TGeneratorForm.SaveDetectorTransformData(aDosimeterID, aMeasurmentID: integer; aDetectorType, aDose: String; aPosition: integer; aMeasurmentTime, aProcessingCurve: String; aAutoProcessing: boolean; aValidity: integer; aComment : String);
var
  ktv       : widestring;
  tmp       : widestring;
  StrDosID  : String;
  autoStr   : String;
begin

  StrDosID:=IntToStr(Dosimeter.ID);
  if Dosimeter.ID < 10 then StrDosID:='0'+StrDosID;

  if ADOQueryGen.Active then ADOQueryGen.Close;
  ADOQueryGen.SQL.Clear;
  ADOQueryGen.SQL.Add('select ktv[0:300], tempprofile[0:300] from tlddetectorres WHERE (dosimeterid = '+#39+StrDosID+#39+' AND detectorid = '+#39+IntToStr(aPosition)+#39+')');
  ADOQueryGen.Open;

  ktv:=ADOQueryGen.FieldByName(cFieldKTV).AsString;
  ktv:=StringReplace(ktv,'{','',[rfReplaceAll]);
  ktv:=StringReplace(ktv,'}','',[rfReplaceAll]);

  tmp:=ADOQueryGen.FieldByName(cFieldTempProfile).AsString;
  tmp:=StringReplace(tmp,'{','',[rfReplaceAll]);
  tmp:=StringReplace(tmp,'}','',[rfReplaceAll]);

  if not aAutoProcessing then autoStr := 'false' else autoStr := 'true';

  TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
  TLDDataModule.ADOQuery.SQL.Add('INSERT INTO tlddetectorres('+cFieldDosMeasID+','
                                                              +cFieldDetType+','
                                                              +cFieldDose+','
                                                              +cFieldDetPosition+','
                                                              +cFieldKTV+','
                                                              +cFieldTempProfile+','
                                                              +cFieldMeasureTime+','
                                                              //+cFieldProcCurve+','
                                                              +cFieldAutoProc+','
                                                              +cFieldDetStatus+','
                                                              +cFieldDetComment+
                                                            ') '+
                                                     'VALUES('+IntToStr(aMeasurmentID)+','
                                                          +#39+aDetectorType+#39+','
                                                          +#39+aDose+#39+','
                                                              +IntToStr(aPosition)+','
                                                     +#39+#123+ktv+#125+#39+','
                                                     +#39+#123+tmp+#125+#39+','
                                                          +#39+aMeasurmentTime+#39+','
                                                          //+#39+aProcessingCurve+#39+','
                                                          +#39+autoStr+#39+','
                                                              +IntToStr(aValidity)+','
                                                          +#39+aComment+#39+
                                                            ')');
  TLDDataModule.ADOQuery.ExecSQL;

  ADOQueryGen.Close;
end;

procedure TGeneratorForm.SaveDosimeterRandomData(aMeasID         : integer;
                                                 aType           : String;
                                                 aDose           : String;
                                                 aError          : String;
                                                 aFormula        : String;
                                                 aMeasTime       : TDateTime;
                                                 aRegTime        : TDateTime;
                                                 aVerTime        : TDateTime;
                                                 aValidity       : integer;
                                                 aStatus         : integer;
                                                 aKh10           : double;
                                                 aKh10g          : double;
                                                 aKh10n          : double;
                                                 aKhgn           : double;
                                                 aKh3            : double;
                                                 aKh007          : double;
//                                                 aKhr1           : double;
//                                                 aKhr2           : double;
                                                 aPartID         : integer;
                                                 aTldID          : integer;
                                                 aSoftVer        : integer;
                                                 aTldUser        : String;
                                                 aPersNumber     : integer;
                                                 aFio            : String;
                                                 aOrg            : String;
                                                 aDepartment     : String;
                                                 aDosComment     : String;
                                                 aMeasComment    : String);
begin
  TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
  TLDDataModule.ADOQuery.SQL.Add('UPDATE tlddosimeterres SET ('+cFieldDosType+','
                                                               +cFieldDose+','
                                                               +cFieldError+','
                                                               +cFieldFormula+','
                                                               +cFieldMeasureTime+','
                                                               +cFieldRegTime+','
                                                               +cFieldVerTime+','
                                                               +cFieldValidity+','
                                                               +cFieldDosStatus+','
                                                               +cField_k1+','
                                                               +cField_k2+','
                                                               +cField_k3+','
                                                               +cField_k4+','
                                                               +cField_k5+','
                                                               +cField_kgn+','
                                                               +cFieldPartID+','
                                                               +cFieldTldID+','
                                                               +cFieldSoftwareVer+','
                                                               +cFieldTldUser+','
                                                               +cFieldPersNumber+','
                                                               +cFieldFio+','
                                                               +cFieldOrg+','
                                                               +cFieldDepartment+','
                                                               +cFieldLastMeasComment+','
                                                               +cFieldMeasComment+
                                                             ') '+
                                                          '= ('+#39+aType+#39+','
                                                               +#39+aDose+#39+','
                                                               +#39+aError+#39+','
                                                               +#39+aFormula+#39+','
                                                               +#39+DateTimeToStr(aMeasTime)+#39+','
                                                               +#39+DateTimeToStr(aRegTime)+#39+','
                                                               +#39+DateTimeToStr(aVerTime)+#39+','
                                                                   +IntToStr(aValidity)+','
                                                                   +IntToStr(aStatus)+','
                                                                   +FloatToStrRegion(aKh10)+','
                                                                   +FloatToStrRegion(aKh10g)+','
                                                                   +FloatToStrRegion(aKh10n)+','
                                                                   +FloatToStrRegion(aKhgn)+','
                                                                   +FloatToStrRegion(aKh3)+','
                                                                   +FloatToStrRegion(aKh007)+','
//                                                                   +FloatToStrRegion(aKhr1)+','
//                                                                   +FloatToStrRegion(aKhr2)+','
                                                                   +IntToStr(aPartID)+','
                                                                   +IntToStr(aTldID)+','
                                                                   +IntToStr(aSoftVer)+','
                                                               +#39+aTldUser+#39+','
                                                                   +IntToStr(aPersNumber)+','
                                                               +#39+aFio+#39+','
                                                               +#39+aOrg+#39+','
                                                               +#39+aDepartment+#39+','
                                                               +#39+aDosComment+#39+','
                                                               +#39+aMeasComment+#39+
                                                             ') '+
                                                             ' WHERE '+cFieldDosMeasID+' = '+IntToStr(aMeasID));
  TLDDataModule.ADOQuery.ExecSQL;
end;

procedure TGeneratorForm.BtnGenClick(Sender: TObject);
var
  i,j,k       : integer;
  RandomCnt   : integer;
  FullDosName : String;
begin


  try
    MainForm.DBGridEhDos.DataSource.DataSet.First;
    for i := 0 to MainForm.DBGridEhDos.DataSource.DataSet.RecordCount-1 do
    begin
      ProgressBarGenegator.Position:=i;

      FullDosName := MainForm.DBGridEhDos.DataSource.DataSet.Fields[0].AsString;

      RandomCnt:=1;

      for k := 0 to RandomCnt-1 do
      begin

        CreateDosimeter(FullDosName);
        if Assigned(Dosimeter) then
        begin
          //Dosimeter.KS:=Random(100);
          CreateDosimeterRandomData(Dosimeter.ID,Dosimeter.Postfix,Dosimeter.KS);

          for j := 0 to Dosimeter.DetectorsList.Count-1 do
          begin
            if (Dosimeter.DetectorsList[j]<>nil) then
            begin

              SaveDetectorTransformData(Dosimeter.ID,Dosimeter.MeasurementID,TDetector(Dosimeter.DetectorsList[j]).DetType,'0',j+1,DateTimeToStr(Now),'',false,0,''); // сохранение результатов узмерений детектора 1

            end;

          end;

          Dosimeter.MeasTime:=Now;
          //Dosimeter.Dose:=IntToStr(Random(100))+'мЗв';
          //Dosimeter.Error:='0.1 мЗв';

          Dosimeter.MeasComment:=MemoComment.Lines.Text;

          SaveDosimeterRandomData(Dosimeter.MeasurementID,
                                  Dosimeter.DosType,
                                  FloatToStrRegion(Dosimeter.Dose_Hp_10g),
                                  Dosimeter.Error,
                                  Dosimeter.Formula,
                                  Dosimeter.MeasTime,
                                  Dosimeter.RegTime,
                                  Dosimeter.VerTime,
                                  GetDosValidity(Dosimeter.Validity),
                                  GetDosStatus(Dosimeter.Status),
                                  Dosimeter.K1,
                                  Dosimeter.K2,
                                  Dosimeter.K3,
                                  Dosimeter.K4,
                                  Dosimeter.K5,
                                  Dosimeter.Kgn,
                                  Dosimeter.PartID,
                                  Dosimeter.TldID,
                                  Dosimeter.SoftwareVer,
                                  Dosimeter.TldUser,
                                  Dosimeter.PersNumber,
                                  Dosimeter.Fio,
                                  Dosimeter.Organization,
                                  Dosimeter.Department,
                                  Dosimeter.LastMeasComment,
                                  Dosimeter.MeasComment
                                  );

        end;

      end;

      MainForm.DBGridEhDos.DataSource.DataSet.Next;

    end;

  except
    on E: exception do
      MessageDlg(E.Message,mtError, [mbOK], 0);
  end;
end;

procedure TGeneratorForm.BtnOpenClick(Sender: TObject);
begin
  OpenDB;
  RefreshDBMeasureList;
end;

procedure TGeneratorForm.ConnectToDB(aDBName: String);
begin
// если подключение к БД уже есть отключаемся
  if ADOConnectionGen.Connected then
    ADOConnectionGen.Connected:=false;

//  подключаемся к базе данных
{
  ADOConnectionGen.ConnectionString:=TLDDataModule.ODBCDriver+';'+
                                                cPostgreServer+'='+TLDDataModule.ServerIP+';'+
                                                cPostgrePort+'='+TLDDataModule.PGPort+';'+
                                                cPostgreDB+'='+aDBName+';'+
                                                cPostgreUid+'='+TLDDataModule.PGUid+';'+
                                                cPostgrePWD+'='+TLDDataModule.PGPass+';';
}
  ADOConnectionGen.LoginPrompt := false;   //  не будем лишний раз запрашивать учётные данные
  ADOConnectionGen.Connected := true;      //  соединяемся с сервером


  RefreshDBList;

  if IsConnected then
    DBName:=aDBName;

end;

procedure TGeneratorForm.SetDBName(aDBName: String);
begin
  FDBName:=aDBName;
end;

end.
