unit uDataModule;

interface

uses
  SysUtils, DB, Classes, Math, Forms, Dialogs, Variants, Inifiles,
  DataSetImpExpEh, MemTableEh, DataDriverEh, DBGridsEh, sqldb, SQLDBLib,
  PQConnection, odbcconn;

type
  EDBConnectionErr = class(Exception);
  EDB_ASIDK_ConnectionErr = class(Exception);

  TOnDBConnection = procedure(Connection: boolean) of object;
  TOn_ASIDK_DBConnection = procedure(Connection: boolean) of object;

  // Может быть использовать ZeoosLib для соединения ADOConnection
  // подмены:

//  TADOConnection = TODBCConnection;
//  TSQLQuery = TSQLQuery;

  { TTLDDataModule }

  TTLDDataModule = class(TDataModule)
    dbSQLTransactionASIDK: TSQLTransaction;
    dbSQLTransaction: TSQLTransaction;
    ADOQuery: TSQLQuery;
    ADOQueryASIDK: TSQLQuery;
    DataSetTextExporterEh: TDataSetTextExporterEh;
    DataSetTextImporterEh: TDataSetTextImporterEh;
    MemTableEhTLDSettings: TMemTableEh;
    MemTableEhTLDSettingstldid: TStringField;
    MemTableEhTLDSettingskslevel: TStringField;
    MemTableEhTLDSettingsksdelta: TStringField;
    MemTableEhTLDSettingskfilter: TStringField;
    MemTableEhTLDSettingskdev: TStringField;
    MemTableEhDetType: TMemTableEh;
    MemTableEhDetTypedetectortype: TStringField;
    MemTableEhDetTypetempprofile: TStringField;
    MemTableEhDetTypedettypecomment: TStringField;
    MemTableEhDetTypemethod: TStringField;
    MemTableEhDetTypemeasval: TStringField;
    MemTableEhDetTypekname: TStringField;
    DataSetDriverEh1: TDataSetDriverEh;
    ADOQueryExportDet: TSQLQuery;
    ADOConnectionASIDK: TSQLConnector;
    ODBCConnection: TPQConnection;
//    ADOQuery: TSQLQuery;
    TSQLQuery: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FODBCDriver            : String;                   // строка подключения к ODBC драйверу
    FPGPass                : String;
    FPGPort                : String;
    FPGUid                 : String;
    FServerIP              : String;
    FDBName                : String;

    F_ASIDK_ODBCDriver     : String;
    F_ASIDK_PGPass         : String;
    F_ASIDK_PGPort         : String;
    F_ASIDK_PGUid          : String;
    F_ASIDK_ServerIP       : String;
    F_ASIDK_DBName         : String;

    FOnDBConnection         : TOnDBConnection;
    FOn_ASIDK_DBConnection  : TOn_ASIDK_DBConnection;

    function GetDBConnection: boolean;
    function Get_ASIDK_DBConnection: boolean;
    function GetNotDefaultDBConnection: boolean;
    procedure SetODBCDriver(Value: String);
    procedure SetPGPass(Value: String);
    procedure SetPGPort(Value: String);
    procedure SetPGUid(Value: String);
    procedure SetServerIP(Value: String);
    procedure SetDBName(Value: String);

    procedure Set_ASIDK_ODBCDriver(Value: String);
    procedure Set_ASIDK_PGPass(Value: String);
    procedure Set_ASIDK_PGPort(Value: String);
    procedure Set_ASIDK_PGUid(Value: String);
    procedure Set_ASIDK_ServerIP(Value: String);
    procedure Set_ASIDK_DBName(Value: String);

    procedure ReadConfigIni;
    procedure SetOnDBConnection(Sender: TOnDBConnection);
    procedure SetOn_ASIDK_DBConnection(Sender: TOn_ASIDK_DBConnection);
    { Private declarations }
  public
    PGRestorePath   : String;  // путь к утилите импорта БД - pg_restore.exe
    PGDumpPath      : String;  // путь к утилите экспорта БД - pg_dump.exe

    ASIDK_Use       : boolean;

    function CheckTableInDB(aTableName: String): boolean;
    function IsDBExist(aDBName: String): boolean;
    function IsMeasIDExist(MeasID: integer): boolean;
    function GetNewMeasID: integer;
    function IsDeviceIdExist(Value: integer): boolean;
    function IsDosimeterExist(Value: String): boolean;
    function IsDosimeterTypeExist(Value: String): boolean;
    function IsDosimeterPartExist(Part: String; TLDid: integer): boolean;
    function IsDosimeterInPart(Value: String): boolean;
    function IsDosimeterTypeUsed(Value: String): boolean;
    function IsDosimeterPartUsed(Value: String): boolean;
    function IsDetectorTypeExist(Value: String): boolean;
    function IsDetectorTypeUsed(Value: String): boolean;
    function AddNewDosPart(PartName: String; K1,K2,K3,K4,K5,Kgn: double; DosCnt: integer; DosType: String; CalibrDate: TDateTime): boolean;
    function ChangeDosNumberInMeasResult(MeasID: integer; DosName, Postfix: string): boolean;
    function UpdatePartInDos(DosName: String; K1,K2,K3,K4,K5,Kgn: double; PartID: integer; CalibrDate: TDateTime): boolean;
    function UpdateKInDosIDByPart(K1,K2,K3,K4,K5,Kgn: double; PartID: integer; CalibrDate: TDateTime; CalibrState: integer): boolean;
    function UpdateKInPart(K1,K2,K3,K4,K5,Kgn: double; PartID: integer; CalibrDate: TDateTime; CalibrState: integer): boolean;
    function UpdateDosimeterInLibrary(DosID,Postfix,DosTypeID,DosType,Status,K1,K2,K3,K4,K5,Kgn,DeviceID,PartID,RegTime,VerTime,Org,Dep: String): boolean;
    function UpdateAdditionalParametersInDos(DosID,Organization,Department: String): boolean;
    function UpdateDeviceConfig(TLDID,KSLevel,KSDelta: integer;KFilter,KDev: double): boolean;
    function UpdateDBComment(DBName: String; Comment: String): boolean;
    function InsertDosimeterInLibrary(DosID,Postfix,DosTypeID,DosType,Status,K1,K2,K3,K4,K5,Kgn,DeviceID,PartID,RegTime,VerTime,Org,Dep: String): boolean;
    function GetSQLQueryCreateTLDDosimeterID(TableName: String): String;
    function GetDBVersion: integer;
    function GetDetTypeID(DetType: String): integer;
    function GetDosTypeID(DosType: String): integer;
    function GetDosType(DosTypeID: integer): String;
    function GetDetType(DetTypeID: integer): String;
    function GetDosTypeFormulaID(DosType: String): integer;
    function GetDetDose(MeasID: String; DetPos: integer): String;
    function GetPartName(PartID: integer): String;
    function GetPartID(PartName: String; DeviceID: integer): integer;
    function GetPartIDFromMeas(PartName: String): integer;
    function GetAllPartIDByName(PartName: String): String;
    function GetDosPartID(DosName: String): integer;
    function GetDosCntInPart(PartID: integer): integer;
    function GetDosTypeInPart(PartID: integer): String;
    function GetDataBaseComment(DataBaseName: String): String;
    function ExcludeDosimeterFromPart(DosName: String): boolean;
    function GetDefaultPartName: String;
    function LoadSQL(DBVersion: integer): boolean;
    function GetSQLSingleCol(DeviceID: integer): String;
    function GetSQLManyCol: String;
    function ConnectToDefaultDB: boolean;
    function RenameDB(OldName: String; NewName: String): boolean;  // не работает
    function CopyDB(aCurrentDBName: String; aCopyDBName: String): boolean;
    function GetPrevMeasDate(Date: TDate): TDate;
    function GetNextMeasDate(Date: TDate): TDate;
    function MarkToDelMeasurment(DosNumber,MeasID: String): boolean;
    function DeleteDosimeterType(DosType: String): boolean;
    function DeleteDosimeterPart(DosPart: String; DeviceID: integer): boolean;
    function DeleteDetectorType(DetType: String): boolean;
    function DeleteDiscommisionedDosimeters: boolean;
    function DeleteMarkedToDelMeasures: boolean;
    function GetDiscommisionedDosimetersNumbers: TStringList;
    function GetMarkedToDelMeas: TStringList;
    function GetMeasFromDate(DateFrom: TDateTime): TStringList;
    function GetDosListInPart(PartID: integer): TStringList;
    function InsertNewDetType(DetType: String): boolean;
    function InsertNewDosType(DosType: String): boolean;
    function InsertNewDosPart(DosPart: String): boolean;
    function InsertTestDosType(DosType: String): boolean;
    function InsertTestDos(aName: String): boolean;
    function GetDBGridStringNumber(DBGridEh: TDBGridEh; aName: String): integer;
    function DeleteDataBase(aDBName: String): boolean;
    function RestoreDB(aBackupDBName: String; CreateBackup: boolean): boolean;
    function CreateBackupDB(aBackupDBName: String): String;
    function GetBackupDBName: String;

    procedure SetDosCntInPart(PartID,Cnt: integer);
    procedure CreateDB(aDBName: String; ClearBD: boolean);  // процедура создания БД, параметр - aCreateTables означает создавать или нет таблицы БД
    procedure CreateDBTables;                                     // процедура создания таблиц БД
    procedure ConnectToDB(aDBName: String);                       // процедура подключения к БД
    procedure ConnectTo_ASIDK_DB(aDBName: String);                // подключение к БД АСИДК
    procedure Reconnect(aDBName: String);
    procedure WriteDeviceID(ID: integer); overload;
    procedure WriteDeviceID(ID: integer; KSLevel: integer; KSDelta: integer; KFilter: double); overload;
    procedure ReadTLDSettings(ID: integer; var aKSLevel: integer;
                                           var aKSDelta: integer;
                                           var aKFilter: double;
                                           var aKDevice: double);

    procedure GetKFromPart(PartName: String; var aK1: double;
                                             var aK2: double;
                                             var aK3: double;
                                             var aK4: double;
                                             var aK5: double;
                                             var aKgn: double);

    procedure SendMeasToCalibr(MeasID: String; CalibrDose: double; RadiationType: String);
    procedure ChangeMeasState(MeasID: String; State: integer);

//    procedure UpdateK1InMeas(MeasID: String; K1: double);

    property ODBCDriver: String read FODBCDriver write SetODBCDriver;
    property PGPass: String read FPGPAss write SetPGPass;
    property PGPort: String read FPGPort write SetPGPort;
    property PGUid: String read FPGUid write SetPGUid;
    property ServerIP: String read FServerIP write SetServerIP;
    property DBName: String read FDBName write SetDBName;

    property ASIDK_ODBCDriver: String read F_ASIDK_ODBCDriver write Set_ASIDK_ODBCDriver;
    property ASIDK_PGPAss: String read F_ASIDK_PGPAss write Set_ASIDK_PGPass;
    property ASIDK_PGPort: String read F_ASIDK_PGPort write Set_ASIDK_PGPort;
    property ASIDK_PGUid: String read F_ASIDK_PGUid write Set_ASIDK_PGUid;
    property ASIDK_ServerIP: String read F_ASIDK_ServerIP write Set_ASIDK_ServerIP;
    property ASIDK_DBName: String read F_ASIDK_DBName write Set_ASIDK_DBName;

    property IsConnected: boolean read GetDBConnection;             // проверка на подключение к БД в том числеи дефолтной
    property IsDBConnected: boolean read GetNotDefaultDBConnection; // проверка на подключение к БД исключая дефолтную postgres

    property Is_ASIDK_Connected: boolean read Get_ASIDK_DBConnection;

    property OnDBConnection              : TOnDBConnection read FOnDBConnection write SetOnDBConnection;
    property On_ASIDK_DBConnection       : TOn_ASIDK_DBConnection read FOn_ASIDK_DBConnection write SetOn_ASIDK_DBConnection;

    { Public declarations }
  end;

var
  TLDDataModule: TTLDDataModule;

implementation
uses
  uMainForm,
  uSeparator,
  uLanguages,
  uTLDCommand,
  uLog,
  uFunctions,
  uBackupForm,
  uOpenDB,
  uDosimeterTypeConstructorForm,
  uDetectorConstructorForm,
  uDosimeterPartForm,
  uReportForm,
  uQueueForm,
  uStartMF,
  uConst;
{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TTLDDataModule }

procedure TTLDDataModule.ConnectToDB(aDBName: String);
begin
// если подключение к БД уже есть отключаемся
  if ODBCConnection.Connected then
    ODBCConnection.Connected:=false;

//  подключаемся к базе данных
{
  ODBCConnection.ConnectionString:=ODBCDriver+';'+
                                  cPostgreServer+'='+ServerIP+';'+
                                  cPostgrePort+'='+PGPort+';'+
                                  cPostgreDB+'='+aDBName+';'+
                                  cPostgreUid+'='+PGUid+';'+
                                  cPostgrePWD+'='+PGPass+';';
}
//  ODBCConnection.Params.Clear;
{
  ODBCConnection.Params.Add(ODBCDriver+';'+
                                  cPostgreServer+'='+ServerIP+';'+
                                  cPostgrePort+'='+PGPort+';'+
                                  cPostgreDB+'='+aDBName+';'+
                                  cPostgreUid+'='+PGUid+';'+
                                  cPostgrePWD+'='+PGPass+';');
 }
{
  ODBCConnection.Params.Add('Login Prompt=False');
  ODBCConnection.Params.Add('Data Source='+ServerIP);
  ODBCConnection.Params.Add('User ID='+PGUid);
  ODBCConnection.Params.Add('Password='+PGPass);
  ODBCConnection.Params.Add('Database='+aDBName);
  ODBCConnection.Params.Add('Schema=public');
  ODBCConnection.LoginPrompt:=false;     //  не будем лишний раз запрашивать учётные данные
}
  ODBCConnection.LoginPrompt:=false;     //  не будем лишний раз запрашивать учётные данные
  //ODBCConnection.ConnectorType := 'PostgreSQL';
  ODBCConnection.DatabaseName:=aDBName;
  ODBCConnection.HostName:=ServerIP;
  ODBCConnection.Password:=PGPass;
  ODBCConnection.Transaction:=dbSQLTransaction;
  ODBCConnection.UserName:=PGUid;

  try
    ODBCConnection.Connected:=true;      //  соединяемся с сервером
  except
    on E: exception do
    begin
      raise EDBConnectionErr.Create(Format('%s. %s - %s',[E.Message,rsDBConnectionFault,aDBName]));
    end;
  end;

  if IsConnected then DBName:=aDBName;
end;

procedure TTLDDataModule.CreateDB(aDBName: String; ClearBD: boolean);
var
  ActiveDB: String;
begin
  ActiveDB:=DBName; // запоминаем имя текущей БД

  if not ODBCConnection.Connected then
  begin
    ODBCConnection.LoginPrompt:=false;     //  не будем лишний раз запрашивать учётные данные
    ODBCConnection.DatabaseName:=aDBName;
    ODBCConnection.HostName:=ServerIP;
    ODBCConnection.Password:=PGPass;
    ODBCConnection.Transaction:=dbSQLTransaction;
    ODBCConnection.UserName:=PGUid;

    //  не будем лишний раз запрашивать учётные данные
    ODBCConnection.LoginPrompt:=false;
    //  соединимся с сервером
    ODBCConnection.Connected:=true;
  end;
//  ODBCConnection.CreateDB;

//  создаем свою базу данных
  ADOQuery.Active:=False;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('COMMIT');
  ADOQuery.ExecSQL;

  ADOQuery.Active:=False;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('CREATE DATABASE '+aDBName+' WITH TEMPLATE template0;');
  ADOQuery.ExecSQL;
//  подключаемся к созданной базе данных
  ConnectToDB(aDBName);
//  создаем таблицы
  if not ClearBD then CreateDBTables;
// возвращаем соединение с текущей базой
  ConnectToDB(ActiveDB);

end;

procedure TTLDDataModule.CreateDBTables;
const
  cZero = '0';
begin
  // создаем таблицы в новой БД

  if ODBCConnection.Connected then
  begin
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('CREATE TABLE '+cDBTableDosID+' ('
                            +cFieldDosID+'              integer NOT NULL'+','
                            +cFieldDosPostfix+'         VARCHAR(20) NOT NULL'+','
                            +cFieldDosTypeID+'          smallint'+','
                            +cFieldDosType+'            VARCHAR(40)'+','
                            +cFieldDosStatus+'          smallint DEFAULT 1'+','
                            +cField_k1+'                real'+','
                            +cField_k2+'                real'+','
                            +cField_k3+'                real'+','
                            +cField_k4+'                real'+','
                            +cField_k5+'                real'+','
                            +cField_kgn+'               real'+','
                            +cField_ecc1+'              real DEFAULT 1'+','
                            +cField_ecc2+'              real DEFAULT 1'+','
                            +cField_ecc3+'              real DEFAULT 1'+','
                            +cField_ecc4+'              real DEFAULT 1'+','
                            +cFieldTldID+'              smallint DEFAULT 0 NOT NULL'+','
                            +cFieldPartID+'             integer DEFAULT 0'+','
                            +cFieldRegTime+'            timestamp'+','
                            +cFieldVerTime+'            timestamp DEFAULT '+#39+'1899-12-30 00:00:00'+#39+','
                            +cFieldOrg+'                VARCHAR(40) DEFAULT '+#39+''+#39+','
                            +cFieldDepartment+'         VARCHAR(40) DEFAULT '+#39+''+#39+','
                            +cFieldLastMeasComment+'    VARCHAR(120) DEFAULT '+#39+''+#39+','
                            +cFieldLastMeasTime+'       timestamp'+','
                            +cFieldLastMeasResult+'     smallint DEFAULT 0'+','
                            +'PRIMARY KEY ('+cFieldDosID+','+cFieldDosPostfix+')'
                            +');'
                        +'CREATE TABLE '+cDBTableDosPart+' ('
                            +cFieldPartID+'             integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY'+','  // автоинкрементируемое ключевой поле
                            +cFieldDosPartName+'        VARCHAR(50)'+','
                            +cField_k1+'                real'+','
                            +cField_k2+'                real'+','
                            +cField_k3+'                real'+','
                            +cField_k4+'                real'+','
                            +cField_k5+'                real'+','
                            +cField_kgn+'               real'+','
                            +cFieldDosType+'            VARCHAR(40)'+','
                            +cFieldVerTime+'            timestamp'+','
                            +cFieldDosPartComment+'     VARCHAR(100)'+','
                            +cFieldDosPartCnt+'         integer'+','
                            +cFieldTldID+'              smallint DEFAULT 0 NOT NULL'
                            +');'
                        +'CREATE TABLE '+cDBTableDosType+' ('
                            +cFieldDosTypeID+'          smallint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY'+','  // автоинкрементируемое ключевой поле
                            +cFieldDosType+'            VARCHAR(40)'+','
                            +cFieldMeasVal+'            VARCHAR(80) DEFAULT '+#39+''+#39+','
                            +cFieldDType1+'             smallint DEFAULT 0'+','
                            +cFieldDType2+'             smallint DEFAULT 0'+','
                            +cFieldDType3+'             smallint DEFAULT 0'+','
                            +cFieldDType4+'             smallint DEFAULT 0'+','
                            +cFieldFormula+'            VARCHAR(200) DEFAULT '+#39+''+#39+','
                            +cFieldError+'              VARCHAR(4) DEFAULT '+#39+''+#39+','
                            +cFieldFormulaId_Dos+'      smallint DEFAULT 0'+','
                            +cFieldFormulaId_Val_1+'    smallint DEFAULT 0'+','
                            +cFieldFormulaId_Val_2+'    smallint DEFAULT 0'+','
                            +cFieldFormulaId_Val_3+'    smallint DEFAULT 0'+','
                            +cFieldFormulaId_Val_4+'    smallint DEFAULT 0'+','
                            +cFieldFormula_Err_k1_1+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k2_1+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k1_2+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k2_2+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k1_3+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k2_3+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k1_4+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k2_4+'   real DEFAULT 0'
                            +');'
                        +'CREATE TABLE '+cDBTableDetType+' ('
                            +cFieldDetTypeID+'          integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY'+','  // автоинкрементируемое ключевой поле
                            +cFieldDetType+'            VARCHAR(40) DEFAULT '+#39+''+#39+','
                            +cFieldTempProfile+'        VARCHAR(5000) DEFAULT '+#39+''+#39+','
                            +cFieldDetTypeComment+'     VARCHAR(240) DEFAULT '+#39+''+#39+','
                            +cFieldMethod+'             VARCHAR(40) DEFAULT '+#39+''+#39+','
                            +cFieldDetMeasVal+'         VARCHAR(20) DEFAULT '+#39+''+#39+','
                            +cFieldK1Profile+'          double precision DEFAULT 1'+','
                            +cFieldK2Profile+'          double precision DEFAULT 0'+','
                            +cFieldDetKName+'           VARCHAR(4) DEFAULT '+#39+''+#39
                            +');'
                        +'CREATE TABLE '+cDBTableDosRes+' ('
                            +cFieldDosMeasID+'          integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY'+','  // автоинкрементируемое ключевой поле
                            +cFieldDosID+'              integer NOT NULL'+','
                            +cFieldDosPostfix+'         VARCHAR(20) NOT NULL'+','
                            +cFieldDosType+'            VARCHAR(40)'+','
                            +cFieldDosTypeID+'          smallint'+','
                            +cFieldMeasVal+'            VARCHAR(80) DEFAULT '+#39+''+#39+','
                            +cFieldDose+'               double precision'+','
                            +cFieldError+'              VARCHAR(40)'+','
                            +cFieldFormula+'            VARCHAR(200)'+','
                            +cFieldKSI+'                integer'+','
                            +cFieldMeasureTime+'        timestamp'+','
                            +cFieldRegTime+'            timestamp'+','
                            +cFieldVerTime+'            timestamp'+','
                            +cFieldLastMeasTime+'       timestamp'+','
                            +cFieldValidity+'           smallint'+','
                            +cFieldDosStatus+'          smallint'+','
                            +cField_k1+'                real'+','
                            +cField_k2+'                real'+','
                            +cField_k3+'                real'+','
                            +cField_k4+'                real'+','
                            +cField_k5+'                real'+','
                            +cField_kgn+'               real'+','
                            +cField_ecc1+'              real DEFAULT 1'+','
                            +cField_ecc2+'              real DEFAULT 1'+','
                            +cField_ecc3+'              real DEFAULT 1'+','
                            +cField_ecc4+'              real DEFAULT 1'+','
                            +cFieldHp10g+'              double precision DEFAULT 0'+','
                            +cFieldHp10n+'              double precision DEFAULT 0'+','
                            +cFieldHp3+'                double precision DEFAULT 0'+','
                            +cFieldHp007+'              double precision DEFAULT 0'+','
                            +cFieldHstar+'              double precision DEFAULT 0'+','
                            +cFieldH007+'               double precision DEFAULT 0'+','
                            +cFieldD+'                  double precision DEFAULT 0'+','
                            +cFieldHp10g_err+'          double precision DEFAULT 0'+','
                            +cFieldHp10n_err+'          double precision DEFAULT 0'+','
                            +cFieldHp3_err+'            double precision DEFAULT 0'+','
                            +cFieldHp007_err+'          double precision DEFAULT 0'+','
                            +cFieldHstar_err+'          double precision DEFAULT 0'+','
                            +cFieldH007_err+'           double precision DEFAULT 0'+','
                            +cFieldD_err+'              double precision DEFAULT 0'+','
                            +cFieldFormulaId_Dos+'      smallint DEFAULT 0'+','
                            +cFieldFormulaId_Val_1+'    smallint DEFAULT 0'+','
                            +cFieldFormulaId_Val_2+'    smallint DEFAULT 0'+','
                            +cFieldFormulaId_Val_3+'    smallint DEFAULT 0'+','
                            +cFieldFormulaId_Val_4+'    smallint DEFAULT 0'+','
                            +cFieldFormula_Err_k1_1+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k2_1+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k1_2+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k2_2+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k1_3+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k2_3+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k1_4+'   real DEFAULT 0'+','
                            +cFieldFormula_Err_k2_4+'   real DEFAULT 0'+','
                            +cFieldKFilter+'            real DEFAULT 1'+','
                            +cFieldKDevice+'            real DEFAULT 1'+','
                            +cFieldPartID+'             integer'+','
                            +cFieldDosPartName+'        VARCHAR(50) DEFAULT '+#39+'-'+#39+','
                            +cFieldTldID+'              smallint NOT NULL'+','
                            +cFieldSoftwareVer+'        smallint'+','
                            +cDBTableUser+'             VARCHAR(50)'+','
                            +cFieldPersNumber+'         integer'+','
                            +cFieldFio+'                VARCHAR(100)'+','
                            +cFieldOrg+'                VARCHAR(40)'+','
                            +cFieldDepartment+'         VARCHAR(40)'+','
                            +cFieldLastMeasComment+'    VARCHAR(120)'+','
                            +cFieldMeasComment+'        VARCHAR(120)'+','
                            +cFieldMeasState+'          smallint DEFAULT 0'+','
                            +cFieldRadiationType+'      VARCHAR(20)'+','
                            +cFieldCalibrationValue+'   double precision'+','
                            +cFieldToDel+'              boolean DEFAULT false'
                            +');'
                        +'CREATE TABLE '+cDBTableDetRes+' ('
                            +cFieldDosMeasID+'          integer NOT NULL'+','
                            +cFieldDetType+'            VARCHAR(40)'+','
                            +cFieldDetTypeID+'          smallint'+','
                            +cFieldDose+'               double precision DEFAULT 0'+','
                            +cFieldDetErr+'             double precision DEFAULT 0'+','
                            +cFieldDetPosition+'        smallint'+','
                            +cFieldKTV+'                VARCHAR(5000)'+','
                            +cFieldTempProfile+'        VARCHAR(5000)'+','
                            +cFieldTempProfileWrite+'   VARCHAR(5000)'+','
                            +cFieldCalcFon+'            VARCHAR(10000)'+','
                            +cFieldCalcGaus+'           VARCHAR(10000)'+','
                            +cFieldCoefficient+'        VARCHAR(20)'+','
                            +cFieldMeasureTime+'        timestamp'+','
                            +cFieldAutoProc+'           boolean'+','
                            +cFieldDetStatus+'          smallint'+','
                            +cFieldBt+'                 double precision DEFAULT 0'+','
                            +cFieldBx0+'                double precision DEFAULT 0'+','
                            +cFieldBy0+'                double precision DEFAULT 0'+','
                            +cFieldBxy0+'               double precision DEFAULT 0'+','
                            +cFieldBdy+'                double precision DEFAULT 0'+','
                            +cFieldGm1+'                double precision DEFAULT 0'+','
                            +cFieldGa1+'                double precision DEFAULT 0'+','
                            +cFieldGsl+'                double precision DEFAULT 0'+','
                            +cFieldDgm2+'               double precision DEFAULT 0'+','
                            +cFieldDga2+'               double precision DEFAULT 0'+','
                            +cFieldGsr+'                double precision DEFAULT 0'+','
                            +cFieldN1+'                 double precision DEFAULT 0'+','
                            +cFieldN2+'                 double precision DEFAULT 0'+','
                            +cFieldS+'                  double precision DEFAULT 0'+','
                            +cFieldBn1+'                double precision DEFAULT 0'+','
                            +cFieldBn1Width+'           double precision DEFAULT 0'+','
                            +cFieldBn2+'                double precision DEFAULT 0'+','
                            +cFieldBn2Width+'           double precision DEFAULT 0'+','
                            +cFieldK1Profile+'          double precision DEFAULT 1'+','
                            +cFieldK2Profile+'          double precision DEFAULT 0'+','
                            +cFieldPeakFound+'          boolean DEFAULT false'+','
                            +cFieldFonFound+'           boolean DEFAULT false'+','
                            +cFieldMethod+'             VARCHAR(40)'+','
                            +cFieldDetComment+'         VARCHAR(500)'+','
                            +cFieldDetTypeComment+'     VARCHAR(240)'+','
                            +cFieldDetMeasVal+'         VARCHAR(20)'+','
                            +cFieldDetKName+'           VARCHAR(4)'
                            +');'
                        +'CREATE TABLE '+cDBTableUser+' ('
                            +cFieldUserNameID+'         smallint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY'+','  // автоинкрементируемое ключевой поле
                            +cFieldUserName+'           VARCHAR(50)'+','
                            +cFieldUserPermission+'     bigint'+','
                            +cFieldUserPassword+'       VARCHAR(32)'+','
                            +cFieldUserSettings+'       VARCHAR(50)'
                            +');'
                        +'CREATE TABLE '+cDBTableLog+' ('
                            +cFieldTldID+'              smallint NOT NULL'+','
                            +cDBTableUser+'             VARCHAR(50)'+','
                            +cFieldLogMsgTime+'         timestamp'+','
                            +cFieldLogMsg+'             VARCHAR(100)'+','
                            +'PRIMARY KEY ('+cFieldTldID+')'
                            +');'
                        +'CREATE TABLE '+cDBTableSettings+' ('
                            +cFieldTldID+'              smallint NOT NULL'+','
                            +cFieldKSLevel+'            smallint DEFAULT 100'+','
                            +cFieldKSDelta+'            smallint DEFAULT 20'+','
                            +cFieldKFilter+'            real DEFAULT 20'+','
                            +cFieldKDevice+'            real DEFAULT 1'+','
                            +'PRIMARY KEY ('+cFieldTldID+')'
                            +');'

                        +'CREATE TABLE '+cDBTableConfig+' ('
                            +cFieldDBVersion+'          smallint'
                            +');'

                        +'INSERT INTO '+cDBTableUser+' ('+cFieldUserName+','+cFieldUserPermission+','+cFieldUserPassword+') VALUES ('+#39+cSuperUser+#39+','+IntToStr(cSuperUserPermit)+','+#39+'0bdba9c0e665c4918da65abb5abc4083'+#39+');'
                        //+'INSERT INTO '+cDBTableUser+' ('+cFieldUserName+','+cFieldUserPermission+','+cFieldUserPassword+') VALUES ('+#39+'User'+#39+',131073,'+#39+'d41d8cd98f00b204e9800998ecf8427e'+#39+');'
                        //+'INSERT INTO '+cDBTableUser+' ('+cFieldUserName+','+cFieldUserPermission+','+cFieldUserPassword+') VALUES ('+#39+'PowerUser'+#39+',5439743,'+#39+'6804c9bca0a615bdb9374d00a9fcba59'+#39+');'
                        //+'INSERT INTO '+cDBTableUser+' ('+cFieldUserName+','+cFieldUserPermission+','+cFieldUserPassword+') VALUES ('+#39+'Administrator'+#39+',4294967295,'+#39+'0bdba9c0e665c4918da65abb5abc4083'+#39+');'

                        +'INSERT INTO '+cDBTableConfig+' ('+cFieldDBVersion+') VALUES ('+IntToStr(cDBVersion)+');'

                        +'INSERT INTO '+cDBTableDosPart+' ('+cFieldPartID+','+cFieldDosPartName+','+cField_k1+','+cField_k2+','+cField_k3+','+cField_k4+','+cField_k5+','+cField_kgn+','+cFieldTldID+') VALUES (0,'+#39+'-'+#39+',0,0,0,0,0,0,-1);'

                        +'ALTER TABLE '+cDBTableDosID+' ADD FOREIGN KEY ('+cFieldDosTypeID+') REFERENCES '+cDBTableDosType+' ('+cFieldDosTypeID+') ON DELETE CASCADE;'    // [ON DELETE CASCADE] - для удаления записей связанных внешним ключом
                        +'ALTER TABLE '+cDBTableDosID+' ADD FOREIGN KEY ('+cFieldPartID+') REFERENCES '+cDBTableDosPart+' ('+cFieldPartID+') ON DELETE SET DEFAULT;'

                        +'ALTER TABLE '+cDBTableDosType+' ADD FOREIGN KEY ('+cFieldDType1+') REFERENCES '+cDBTableDetType+' ('+cFieldDetTypeID+') ON DELETE CASCADE;'
                        +'ALTER TABLE '+cDBTableDosType+' ADD FOREIGN KEY ('+cFieldDType2+') REFERENCES '+cDBTableDetType+' ('+cFieldDetTypeID+') ON DELETE CASCADE;'
                        +'ALTER TABLE '+cDBTableDosType+' ADD FOREIGN KEY ('+cFieldDType3+') REFERENCES '+cDBTableDetType+' ('+cFieldDetTypeID+') ON DELETE CASCADE;'
                        +'ALTER TABLE '+cDBTableDosType+' ADD FOREIGN KEY ('+cFieldDType4+') REFERENCES '+cDBTableDetType+' ('+cFieldDetTypeID+') ON DELETE CASCADE;'

                        +'ALTER TABLE '+cDBTableDetRes+' ADD FOREIGN KEY ('+cFieldDosMeasID+') REFERENCES '+cDBTableDosRes+' ('+cFieldDosMeasID+') ON DELETE CASCADE;'
                        +'ALTER TABLE '+cDBTableDosRes+' ADD FOREIGN KEY ('+cFieldTldID+') REFERENCES '+cDBTableSettings+' ('+cFieldTldID+') ON DELETE RESTRICT;'
                        //+'ALTER TABLE '+cDBTableDosID+' ADD FOREIGN KEY ('+cFieldPartID+') REFERENCES '+cDBTableDosPart+' ('+cFieldPartID+') ON DELETE SET DEFAULT;'
                        +'COMMIT;'
                        );     //#39 - символ - ' //
    ADOQuery.ExecSQL;

    // создание дефолтного идентификатора считывателя

    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableSettings+'('+cFieldTldID+') '+'VALUES(-1)');
    ADOQuery.ExecSQL;

    // создание идентификатора считывателя для режима эмуляции

    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableSettings+'('+cFieldTldID+') '+'VALUES(-100)');
    ADOQuery.ExecSQL;

    // создание типов детекторов

    // пустой
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetType+'('+cFieldDetTypeID+','
                                                       +cFieldDetType+')'+' '
                                             +'VALUES('+cZero+','
                                                       +#39+cDetMat_None+#39
                                                   +')');
    ADOQuery.ExecSQL;

    // LiF:Mg,Ti
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetType+'('+cFieldDetType+','
                                                       +cFieldTempProfile+','
                                                       +cFieldDetTypeComment+','
                                                       +cFieldMethod+','
                                                       +cFieldDetMeasVal+','
                                                       +cFieldDetKName+')'+' '
                                             +'VALUES('+#39+cDetMat_LiF_Mg_Ti+#39+','
                                                       +#39+'{'+cProfile_15_160_28_356_7_LiF+'}'+#39+','
                                                       +#39+cTimePreheat+'='+cTimePreheatVal_LiF+'|'
                                                           +cTempPreheat+'='+cTempPreheatVal_LiF+'|'
                                                           +cTimeMeas+'='+cTimeMeasVal_LiF+'|'
                                                           +cTempMeas+'='+cTempMeasVal_LiF+'|'
                                                           +cTimeBurn+'='+cTimeBurnVal_LiF+'|'
                                                           +cTempBurn+'='+cTempBurnVal_LiF+'|'
                                                           +cSpeedHeating+'='+cSpeedHeatingVal_LiF+'|'+#39+','
                                                       +#39+cMethod_Fitting+#39+','
                                                       +#39+cHp_10g+#39+','
                                                       +#39+cK1+#39
                                                    +')');
    ADOQuery.ExecSQL;

    // LiF:Mg,Cu,P
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetType+'('+cFieldDetType+','
                                                       +cFieldTempProfile+','
                                                       +cFieldDetTypeComment+','
                                                       +cFieldMethod+','
                                                       +cFieldDetMeasVal+','
                                                       +cFieldDetKName+')'+' '
                                             +'VALUES('+#39+cDetMat_LiF_Cu_P+#39+','
                                                       +#39+'{'+cProfile_30_140_100_240_20_240_1_Cu+'}'+#39+','
                                                       +#39+cTimePreheat+'='+cTimePreheatVal_Cu+'|'
                                                           +cTempPreheat+'='+cTempPreheatVal_Cu+'|'
                                                           +cTimeMeas+'='+cTimeMeasVal_Cu+'|'
                                                           +cTempMeas+'='+cTempMeasVal_Cu+'|'
                                                           +cTimeBurn+'='+cTimeBurnVal_Cu+'|'
                                                           +cTempBurn+'='+cTempBurnVal_Cu+'|'
                                                           +cSpeedHeating+'='+cSpeedHeatingVal_Cu+'|'+#39+','
                                                       +#39+cMethod_Area_60_240+#39+','
                                                       +#39+cHp_3+#39+','
                                                       +#39+cK1+#39
                                                   +')');
    ADOQuery.ExecSQL;

    // Al2O3
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetType+'('+cFieldDetType+','
                                                       +cFieldTempProfile+','
                                                       +cFieldDetTypeComment+','
                                                       +cFieldMethod+','
                                                       +cFieldDetMeasVal+','
                                                       +cFieldDetKName+')'+' '
                                             +'VALUES('+#39+cDetMat_Al2O3+#39+','
                                                       +#39+'{'+cProfile_4_120_22_328_5_328_31_Al+'}'+#39+','
                                                       +#39+cTimePreheat+'='+cTimePreheatVal_Al+'|'
                                                           +cTempPreheat+'='+cTempPreheatVal_Al+'|'
                                                           +cTimeMeas+'='+cTimeMeasVal_Al+'|'
                                                           +cTempMeas+'='+cTempMeasVal_Al+'|'
                                                           +cTimeBurn+'='+cTimeBurnVal_Al+'|'
                                                           +cTempBurn+'='+cTempBurnVal_Al+'|'
                                                           +cSpeedHeating+'='+cSpeedHeatingVal_Al+'|'+#39+','
                                                       +#39+cMethod_Area_10_280+#39+','
                                                       +#39+cHp_10g+#39+','
                                                       +#39+cK1+#39
                                                   +')');
    ADOQuery.ExecSQL;

    // 6LiF:Mg,Ti
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetType+'('+cFieldDetType+','
                                                       +cFieldTempProfile+','
                                                       +cFieldDetTypeComment+','
                                                       +cFieldMethod+','
                                                       +cFieldDetMeasVal+','
                                                       +cFieldDetKName+')'+' '
                                         +'VALUES('+#39+cDetMat_6LiF_Mg_Ti+#39+','
                                                   +#39+'{'+cProfile_15_160_28_356_7_LiF+'}'+#39+','
                                                   +#39+cTimePreheat+'='+cTimePreheatVal_LiF+'|'
                                                       +cTempPreheat+'='+cTempPreheatVal_LiF+'|'
                                                       +cTimeMeas+'='+cTimeMeasVal_LiF+'|'
                                                       +cTempMeas+'='+cTempMeasVal_LiF+'|'
                                                       +cTimeBurn+'='+cTimeBurnVal_LiF+'|'
                                                       +cTempBurn+'='+cTempBurnVal_LiF+'|'
                                                       +cSpeedHeating+'='+cSpeedHeatingVal_LiF+'|'+#39+','
                                                   +#39+cMethod_Fitting+#39+','
                                                   +#39+cHp_10g+#39+','
                                                   +#39+cK1+#39
                                               +')');
    ADOQuery.ExecSQL;

    // 7LiF:Mg,Ti
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetType+'('+cFieldDetType+','
                                                       +cFieldTempProfile+','
                                                       +cFieldDetTypeComment+','
                                                       +cFieldMethod+','
                                                       +cFieldDetMeasVal+','
                                                       +cFieldDetKName+')'+' '
                                         +'VALUES('+#39+cDetMat_7LiF_Mg_Ti+#39+','
                                                   +#39+'{'+cProfile_15_160_28_356_7_LiF+'}'+#39+','
                                                   +#39+cTimePreheat+'='+cTimePreheatVal_LiF+'|'
                                                       +cTempPreheat+'='+cTempPreheatVal_LiF+'|'
                                                       +cTimeMeas+'='+cTimeMeasVal_LiF+'|'
                                                       +cTempMeas+'='+cTempMeasVal_LiF+'|'
                                                       +cTimeBurn+'='+cTimeBurnVal_LiF+'|'
                                                       +cTempBurn+'='+cTempBurnVal_LiF+'|'
                                                       +cSpeedHeating+'='+cSpeedHeatingVal_LiF+'|'+#39+','
                                                   +#39+cMethod_Fitting+#39+','
                                                   +#39+cHp_10n+#39+','
                                                   +#39+cK1+#39
                                               +')');
    ADOQuery.ExecSQL;

    // TEST
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetType+'('+cFieldDetType+','
                                                       +cFieldTempProfile+','
                                                       +cFieldDetTypeComment+','
                                                       +cFieldMethod+','
                                                       +cFieldDetMeasVal+','
                                                       +cFieldDetKName+')'+' '
                                         +'VALUES('+#39+cDetMat_TEST+#39+','
                                                   +#39+'{'+cProfile_30_140_100_240_20_240_1_TEST+'}'+#39+','
                                                   +#39+cTimePreheat+'='+cTimePreheatVal_TEST+'|'
                                                       +cTempPreheat+'='+cTempPreheatVal_TEST+'|'
                                                       +cTimeMeas+'='+cTimeMeasVal_TEST+'|'
                                                       +cTempMeas+'='+cTempMeasVal_TEST+'|'
                                                       +cTimeBurn+'='+cTimeBurnVal_TEST+'|'
                                                       +cTempBurn+'='+cTempBurnVal_TEST+'|'
                                                       +cSpeedHeating+'='+cSpeedHeatingVal_TEST+'|'+#39+','
                                                  +#39+cMethod_Fitting+#39+','
                                                  +#39+cHp_10g+#39+','
                                                  +#39+cK1+#39
                                                +')');

    ADOQuery.ExecSQL;

    // LiF:Mg,Cu,P thin ЗАКОММЕНТИРОВАН, ВОЗМОЖНО ВРЕМЕННО
//    ADOQuery.SQL.Clear;
//    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetType+'('+cFieldDetType+','
//                                                       +cFieldTempProfile+','
//                                                       +cFieldDetTypeComment+','
//                                                       +cFieldMethod+','
//                                                       +cFieldDetMeasVal+','
//                                                       +cFieldDetKName+')'+' '
//                                         +'VALUES('+#39+cDetMat_LiF_Mg_Cu_P_thin+#39+','
//                                                   +#39+'{'+cProfile_30_140_100_240_20_240_1_Cu+'}'+#39+','
//                                                   +#39+cTimePreheat+'='+cTimePreheatVal_Cu+';'
//                                                       +cTempPreheat+'='+cTempPreheatVal_Cu+';'
//                                                       +cTimeMeas+'='+cTimeMeasVal_Cu+';'
//                                                       +cTempMeas+'='+cTempMeasVal_Cu+';'
//                                                       +cTimeBurn+'='+cTimeBurnVal_Cu+';'
//                                                       +cTempBurn+'='+cTempBurnVal_Cu+';'
//                                                       +cSpeedHeating+'='+cSpeedHeatingVal_Cu+';'+#39+','
//                                                  +#39+cMethodsArray[cMethodArea_60_240]+#39+','
//                                                  +#39+cHp_007+#39+','
//                                                  +#39+cK1+#39
//                                                +')');
//    ADOQuery.ExecSQL;

    // создание типов дозиметров

    // новый
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosTypeID+','
                                                       +cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+'0'+','
                                                    +#39+cDosTypeNew+#39+','
                                                    +#39+cDosTypeNone+#39+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +#39+cDosTypeNone+#39+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'+','
                                                    +'0'
                                                    +')');
    ADOQuery.ExecSQL;

    // ТЛД-3 LiF:Mg,Ti
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeTLD3Name+#39+','
                                                    +#39+cHp_10g+#39+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +#39+cArrayFormulasTxt[cMeanD1D2D3_K1]+#39+','
                                                    +'15'+','
                                                    +IntToStr(cHp_10g_3d)+','
                                                    +IntToStr(cMeanD1D2D3_K1)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(15)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // ДТЛ-02
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeDTL02Name+#39+','
                                                    +#39+cHp_10g+#39+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +#39+cArrayFormulasTxt[cMeanD1D2D3_K1]+#39+','
                                                    +'15'+','
                                                    +IntToStr(cHp_10g_3d)+','
                                                    +IntToStr(cMeanD1D2D3_K1)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(15)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // ДТЛ-02 (2 дет)
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeDTL022DetName+#39+','
                                                    +#39+cHp_10g+#39+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +#39+cArrayFormulasTxt[cMeanD1D2_K1]+#39+','
                                                    +'15'+','
                                                    +IntToStr(cHp_10g_2d)+','
                                                    +IntToStr(cMeanD1D2_K1)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(15)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // DTU-01
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeDTU01Name+#39+','
                                                    +#39+cHp_10g+#39+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +#39+cArrayFormulasTxt[cMeanD1D2_K1]+#39+','
                                                    +'15'+','
                                                    +IntToStr(cHp_10g_2d)+','
                                                    +IntToStr(cMeanD1D2_K1)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(15)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // DTU-02
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeDTU02Name+#39+','
                                                    +#39+cHp_10g+#39+','
                                                    +IntToStr(cDetType_Al2O3)+','
                                                    +IntToStr(cDetType_Al2O3)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +#39+cArrayFormulasTxt[cMeanD1D2_K1]+#39+','
                                                    +'15'+','
                                                    +IntToStr(cHp_10g_2d)+','
                                                    +IntToStr(cMeanD1D2_K1)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(15)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // ДВНГ-М
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeDVNGMName+#39+','
                                                    +#39+cHp_10g+','+cHp_10n+#39+','
                                                    +IntToStr(cDetType_7LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_7LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_6LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_6LiF_Mg_Ti)+','
                                                    +#39+cArrayFormulasTxt[cMeanD3D4_K2_D1D2_K1_Kgn]+#39+','
                                                    +'25'+','
                                                    +IntToStr(cHp_10g_2d_Hp_10n_2d)+','
                                                    +IntToStr(cMeanD1D2_K1)+','
                                                    +IntToStr(cMeanD3D4_K2_D1D2_K1_Kgn)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(25)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(25)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // EYE-D
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeEYEDName+#39+','
                                                    +#39+cHp_3+#39+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +#39+cArrayFormulasTxt[cMeanD1_K1]+#39+','
                                                    +'15'+','
                                                    +IntToStr(cHp_3_1d)+','
                                                    +IntToStr(cMeanD1_K1)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(15)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // Finger Ring G
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeFingerRingGName+#39+','
                                                    +#39+cHp_007+#39+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +#39+cArrayFormulasTxt[cMeanD1_K1]+#39+','
                                                    +'15'+','
                                                    +IntToStr(cHp_007g_1d)+','
                                                    +IntToStr(cMeanD1_K1)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(15)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // Finger Ring BG
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeFingerRingBGName+#39+','
                                                    +#39+cHp_007+#39+','
                                                    +IntToStr(cDetType_LiF_Cu_P)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +IntToStr(cDetType_None)+','
                                                    +#39+cArrayFormulasTxt[cMeanD1_K1]+#39+','
                                                    +'15'+','
                                                    +IntToStr(cHp_007gb_1d)+','
                                                    +IntToStr(cMeanD1_K1)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(15)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // пара DTU-1
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeCoupleDTU1Name+#39+','
                                                    +#39+cH_007_dir+#39+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +IntToStr(cDetType_LiF_Mg_Ti)+','
                                                    +#39+cArrayFormulasTxt[cMeanD1D2D3D4_K1]+#39+','
                                                    +'15'+','
                                                    +IntToStr(cHp_10g_4d)+','
                                                    +IntToStr(cMeanD1D2D3D4_K1)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(15)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // TEST
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                       +cFieldMeasVal+','
                                                       +cFieldDType1+','
                                                       +cFieldDType2+','
                                                       +cFieldDType3+','
                                                       +cFieldDType4+','
                                                       +cFieldFormula+','
                                                       +cFieldError+','
                                                       +cFieldFormulaId_Dos+','
                                                       +cFieldFormulaId_Val_1+','
                                                       +cFieldFormulaId_Val_2+','
                                                       +cFieldFormulaId_Val_3+','
                                                       +cFieldFormulaId_Val_4+','
                                                       +cFieldFormula_Err_k1_1+','
                                                       +cFieldFormula_Err_k2_1+','
                                                       +cFieldFormula_Err_k1_2+','
                                                       +cFieldFormula_Err_k2_2+','
                                                       +cFieldFormula_Err_k1_3+','
                                                       +cFieldFormula_Err_k2_3+','
                                                       +cFieldFormula_Err_k1_4+','
                                                       +cFieldFormula_Err_k2_4
                                                    +')'
                                          +'VALUES('+#39+cDosTypeTEST+#39+','
                                                    +#39+cHp_10g+#39+','
                                                    +IntToStr(cDetType_TEST)+','
                                                    +IntToStr(cDetType_TEST)+','
                                                    +IntToStr(cDetType_TEST)+','
                                                    +IntToStr(cDetType_TEST)+','
                                                    +#39+cArrayFormulasTxt[cMeanD1D2D3D4_K1]+#39+','
                                                    +'15'+','
                                                    +IntToStr(cHp_10g_4d)+','
                                                    +IntToStr(cMeanD1D2D3D4_K1)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(c_NoFormula)+','
                                                    +IntToStr(1)+','
                                                    +IntToStr(15)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)+','
                                                    +IntToStr(0)
                                                    +')');
    ADOQuery.ExecSQL;

    // Дозиметр 1_TEST
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosID+'('+cFieldDosID+','
                                                     +cFieldDosPostfix+','
                                                     +cFieldDosTypeID+','
                                                     +cFieldDosType+','
                                                     +cFieldDosStatus+','
                                                     +cField_k1+','
                                                     +cFieldPartID+','
                                                     +cFieldRegTime+','
                                                     +cFieldVerTime+')'
                                       +'VALUES('+#39+'1'+#39+','
                                                 +#39+'_TEST'+#39+','
                                                 +#39+'11'+#39+','
                                                 +#39+cDosTypeTEST+#39+','
                                                 +#39+'0'+#39+','
                                                     +IntToStr(1)+','
                                                     +IntToStr(0)+','
                                                 +#39+DateTimeToStr(Now)+#39+','
                                                 +#39+DateTimeToStr(Now)+#39
                                                 +')'
                                                 );
    ADOQuery.ExecSQL;

  end;

end;

procedure TTLDDataModule.DataModuleCreate(Sender: TObject);
begin
  ReadConfigIni;
  Self.OnDBConnection:=@MainForm.OnDBConnection;
//  Self.On_ASIDK_DBConnection:=@MainForm.On_ASIDK_DBConnection;
end;

procedure TTLDDataModule.DataModuleDestroy(Sender: TObject);
var
  ConfigIni: TInifile;
begin
  ConfigIni := TInifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    ConfigIni.WriteString(cSectionDBSettings, cPGDBName,DBName);
    ConfigIni.WriteBool(cSectionDB_ASIDK_Settings, cASIDK_Use,ASIDK_Use);
  finally
    ConfigIni.Free;
  end;
end;

function TTLDDataModule.DeleteDiscommisionedDosimeters: boolean;
var
  delDosList    : TStringList;
  strDos        : String;
  i             : integer;
begin
  if IsDBConnected then
  begin
    if BackUpForm.BackupDB(TLDDataModule.DBName) then
    begin
      delDosList:=TStringList.Create;

      try
        delDosList:=TLDDataModule.GetDiscommisionedDosimetersNumbers;

        if delDosList.Count>0 then
        begin
          for i := 0 to delDosList.Count-1 do
          begin
            if strDos='' then
              strDos:=Format('"%s"',[delDosList[i]])
            else
              strDos:=strDos+Format(',"%s"',[delDosList[i]])
          end;

          ADOQuery.Close;
          ADOQuery.SQL.Clear;
          ADOQuery.SQL.Add('DELETE FROM '+cDBTableDosID+' WHERE'+' '
                                                        +cFieldDosStatus+'='+IntToStr(cDosDecommissioned)
                                                        +'; COMMIT;');
          ADOQuery.ExecSQL;
          WriteLog(Format('%s - %s',[rsDosimetersDeleted,strDos]));
          Result:=true;
        end
        else
        begin
          WriteLog(Format('%s',[rsNoDeletedDosimeters]));
          Result:=false;
        end;

        delDosList.Clear;
      except
        on E: Exception do
        begin
          WriteLog(Format('%s - %s. %s',[rsErrDeleteDosimeters,strDos,E.Message]));
          delDosList.Clear;
          Result:=false;
        end;
      end;
    end
    else
    begin
      WriteLog(rsErrCreateDBReserved);
      Result:=false;
    end;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.DeleteDosimeterPart(DosPart: String; DeviceID: integer): boolean;
begin
  if IsDBConnected then
  begin
    if BackUpForm.BackupDB(TLDDataModule.DBName) then
    begin
      try
        ADOQuery.SQL.Clear;
        ADOQuery.SQL.Add('DELETE FROM '+cDBTableDosPart+' WHERE'+' '
                                                       +cFieldDosPartName+' = '+#39+DosPart+#39
                                                       +' AND '
                                                       +cFieldTldID+' = '+IntToStr(DeviceID)
                                                       );
        ADOQuery.ExecSQL;
        ADOQuery.Close;

        WriteLog(Format('%s "%s"',[rsPartyDeleted,DosPart]));
        Result:=true;
      except
        on E: Exception do
        begin
          WriteLog(Format('%s "%s". %s',[rsErrPartyDeleted,DosPart,E.Message]));
          Result:=false;
        end;
      end;
    end
    else
    begin
      WriteLog(rsErrCreateDBReserved);
      Result:=false;
    end;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.DeleteDosimeterType(DosType: String): boolean;
begin
  if IsDBConnected then
  begin
    if BackUpForm.BackupDB(TLDDataModule.DBName) then
    begin
      try
        ADOQuery.SQL.Clear;
        ADOQuery.SQL.Add('DELETE FROM '+cDBTableDosType+' WHERE'+' '
                                                       +cFieldDosType+' = '+#39+DosType+#39
                                                       );
        ADOQuery.ExecSQL;
        ADOQuery.Close;

        WriteLog(Format('%s "%s"',[rsDosTypeDeleted,DosType]));
        Result:=true;
      except
        on E: Exception do
        begin
          WriteLog(Format('%s "%s". %s',[rsErrDosTypeDeleted,DosType,E.Message]));
          Result:=false;
        end;
      end;
    end
    else
    begin
      WriteLog(rsErrCreateDBReserved);
      Result:=false;
    end;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.DeleteDataBase(aDBName: String): boolean;
begin
  try
  // закрываем текущие сессии
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT pg_terminate_backend(pg_stat_activity.pid) '
                          +'FROM pg_stat_activity '
                          +'WHERE pg_stat_activity.datname = '+#39+aDBName+#39+' AND pid <> pg_backend_pid();COMMIT;');
    ADOQuery.ExecSQL;

  // удаляем базу
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('DROP DATABASE '+aDBName);
    ADOQuery.ExecSQL;

    Result:=true;
  except
    on E: Exception do
    begin
      showmessage(E.Message);
      Result:=false;
    end;
  end;
end;

function TTLDDataModule.DeleteDetectorType(DetType: String): boolean;
begin
  if IsDBConnected then
  begin
    if BackUpForm.BackupDB(TLDDataModule.DBName) then
    begin
      try
        ADOQuery.SQL.Clear;
        ADOQuery.SQL.Add('DELETE FROM '+cDBTableDetType+' WHERE'+' '
                                                       +cFieldDetType+' = '+#39+DetType+#39
                                                       );
        ADOQuery.ExecSQL;
        ADOQuery.Close;

        WriteLog(Format('%s "%s"',[rsDetTypeDeleted,DetType]));
        Result:=true;
      except
        on E: Exception do
        begin
          WriteLog(Format('%s "%s". %s',[rsErrDetTypeDeleted,DetType,E.Message]));
          Result:=false;
        end;
      end;
    end
    else
    begin
      WriteLog(Format('%s',[rsErrCreateDBReserved]));
      Result:=false;
    end;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.DeleteMarkedToDelMeasures: boolean;
var
  delMeasList  : TStringList;
  strMeas      : String;
  i            : integer;
begin
  if IsDBConnected then
  begin
    if BackUpForm.BackupDB(TLDDataModule.DBName) then
    begin
      delMeasList:=TStringList.Create;

      try
        delMeasList:=GetMarkedToDelMeas;

        if delMeasList.Count>0 then
        begin
          for i := 0 to delMeasList.Count-1 do
          begin
            if strMeas='' then
              strMeas:=Format('"%s"',[delMeasList[i]])
            else
              strMeas:=strMeas+Format(',"%s"',[delMeasList[i]])
          end;

          ADOQuery.Close;
          ADOQuery.SQL.Clear; // очистить текст sql
          ADOQuery.SQL.Add('DELETE FROM '+cDBTableDosRes+' WHERE '+cFieldToDel+'='+'true'+'; COMMIT;');
          ADOQuery.ExecSQL;

          WriteLog(Format('%s - %s',[rsMeasuresDeleted,strMeas]));
          Result:=true;
        end
        else
        begin
          WriteLog(Format('%s',[rsMeasures4DelAbcent]));
          Result:=false;
        end;

        delMeasList.Clear;
      except
        on E: Exception do
        begin
          WriteLog(Format('%s - %s. %s',[rsMeasures4DelNotDeleted,strMeas,E.Message]));
          delMeasList.Clear;
          Result:=false;
        end;
      end;
    end
    else
    begin
      WriteLog(Format('%s',[rsErrCreateDBReserved]));
      Result:=false;
    end;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.ExcludeDosimeterFromPart(DosName: String): boolean;
var
  flag    : boolean;
  partID  : integer;
  dosCnt  : integer;
begin
  flag:=false;

  if IsDBConnected then
  begin
    try
      partID:=GetDosPartID(DosName);

      if partID>0 then
      begin
        ADOQuery.Close;
        ADOQuery.Active:=False;
        ADOQuery.SQL.Clear;
        ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cFieldPartID+' = 0 '
                                                 +'WHERE (CAST (dosimeterid AS TEXT) LIKE '+#39+DosName+#39+' OR CAST (dosimeterid AS TEXT) || postfix LIKE '+#39+DosName+#39+')');
        ADOQuery.ExecSQL;


        dosCnt:=GetDosCntInPart(partID);

        if dosCnt>0 then dec(dosCnt);

        SetDosCntInPart(partID,dosCnt);

        flag:=true;

      end;
    except
      on E: exception do
      begin
        flag:=false;
        WriteLog(Format('%s - %s',[rsErrDosimeterExcludeParty,DosName]));
      end;
    end;
  end
  else
    flag:=false;

  Result:=flag;
end;

function TTLDDataModule.MarkToDelMeasurment(DosNumber, MeasID: String): boolean;
begin
  if IsDBConnected then
  begin
    try
//      ADOQuery.SQL.Clear; // очистить текст sql
//      ADOQuery.SQL.Add('DELETE FROM tlddosimeterres WHERE '+cFieldDosMeasID+' = '+MeasID);
//      ADOQuery.ExecSQL;

      ADOQuery.SQL.Clear; // очистить текст sql
      ADOQuery.SQL.Add('UPDATE '+cDBTableDosRes+' SET '+cFieldToDel+'='+'true'+' WHERE '+cFieldDosMeasID+' = '+measId+'; COMMIT;');
      ADOQuery.ExecSQL;



      WriteLog(Format('%s №%s %s %s',[rsMeasChecked4Del,MeasID,rsOfDosimeter,DosNumber]));
      Result:=true;
    except
      on E: Exception do
      begin
        WriteLog(Format('%s №%s %s %s. %s',[rsErrMeasChecked4Del,MeasID,rsOfDosimeter,DosNumber,E.Message]));
        Result:=false;
      end;
    end;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.ConnectToDefaultDB: boolean;
begin
  try
    ODBCConnection.Connected:=false;
    if not ODBCConnection.Connected then
    begin
      //  подключаемся к базе "postgres" созданной по умолчанию, для того что-ы иметь возможность создать свою
{
поправить потом
      ODBCConnection.ConnectionString:=ODBCDriver+';'+
                                      cPostgreServer+'='+ServerIP+';'+
                                      cPostgrePort+'='+PGPort+';'+
                                      cPostgreDB+'='+cPostgreDefaultDB+';'+
                                      cPostgreUid+'='+PGUid+';'+
                                      cPostgrePWD+'='+PGPass+';';
}
      ODBCConnection.LoginPrompt:=false;     //  не будем лишний раз запрашивать учётные данные
      //ODBCConnection.ConnectorType := 'PostgreSQL';
      ODBCConnection.DatabaseName:=cPostgreDefaultDB;
      ODBCConnection.HostName:=ServerIP;
      ODBCConnection.Password:=PGPass;
      ODBCConnection.Transaction := dbSQLTransaction;
      ODBCConnection.UserName:=PGUid;

      //  не будем лишний раз запрашивать учётные данные
      ODBCConnection.LoginPrompt:=false;
      //  соединимся с сервером
      ODBCConnection.Connected:=true;
    end;
  finally
    Result:=ODBCConnection.Connected;
  end;
end;

procedure TTLDDataModule.ConnectTo_ASIDK_DB(aDBName: String);
begin
  // если подключение к БД уже есть отключаемся
  if ADOConnectionASIDK.Connected then
    ADOConnectionASIDK.Connected:=false;

//  подключаемся к базе данных
{
поправить потом
  ADOConnectionASIDK.ConnectionString:=ASIDK_ODBCDriver+';'+
                                       cPostgreServer+'='+ASIDK_ServerIP+';'+
                                       cPostgrePort+'='+ASIDK_PGPort+';'+
                                       cPostgreDB+'='+aDBName+';'+
                                       cPostgreUid+'='+ASIDK_PGUid+';'+
                                       cPostgrePWD+'='+ASIDK_PGPass+';';
}
  ADOConnectionASIDK.LoginPrompt:=false;     //  не будем лишний раз запрашивать учётные данные
  ADOConnectionASIDK.ConnectorType := 'PostgreSQL';
  ADOConnectionASIDK.DatabaseName:=aDBName;
  ADOConnectionASIDK.HostName:=ASIDK_ServerIP;
  ADOConnectionASIDK.Password:=ASIDK_PGPass;
  ADOConnectionASIDK.Transaction := dbSQLTransaction;
  ADOConnectionASIDK.UserName:=ASIDK_PGUid;

  ADOConnectionASIDK.LoginPrompt:=false;     //  не будем лишний раз запрашивать учётные данные

  try
    ADOConnectionASIDK.Connected:=true;      //  соединяемся с сервером
  except
    on E: exception do
    begin
      raise EDB_ASIDK_ConnectionErr.Create(Format('%s. %s - %s',[E.Message,rsDBConnectionFault_ASIDK,aDBName]));
    end;
  end;

  if IsConnected then ASIDK_DBName:=aDBName;
end;

function TTLDDataModule.InsertNewDetType(DetType: String): boolean;
begin
  if IsDBConnected then
  begin
    try
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('INSERT INTO '+cDBTableDetType+'('
                                                       +cFieldDetType+','
                                                       +cFieldTempProfile+','
                                                       +cFieldDetTypeComment+','
                                                       +cFieldMethod+','
                                                       +cFieldDetMeasVal+','
                                                       +cFieldDetKName
                                                     +')'+' '
                                             +'VALUES('+#39+DetType+#39+','
                                                       +#39+'{'+cProfile_none+'}'+#39+','
                                                       +#39+cEmpty+#39+','
                                                       +#39+cMethod_None+#39+','
                                                       +#39+cEmptyData+#39+','
                                                       +#39+cK1+#39
                                                    +')');


      ADOQuery.ExecSQL;
      WriteLog(Format(rsNewDetTypeAdded,[DetType]));
      Result:=true;
    except
      on E: Exception do
      begin
        WriteLog(Format(rsErrNewDetTypeAdded,[DetType,E.Message]));
        Result:=false;
      end;
    end;
  end
  else
    Result:=false;
end;

function TTLDDataModule.InsertNewDosPart(DosPart: String): boolean;
begin
  if IsDBConnected then
  begin
    try
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosPart+'('+cFieldDosPartName+','
                                                         +cField_k1+','
                                                         +cField_k2+','
                                                         +cField_k3+','
                                                         +cField_k4+','
                                                         +cField_k5+','
                                                         +cField_kgn+','
                                                         +cFieldTldID+''
                                                         +')'
                                                         +'VALUES('+#39+DosPart+#39+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +IntToStr(MainForm.DeviceID)+''
                                                         +')');
      ADOQuery.ExecSQL;
      WriteLog(Format(rsNewPartyAdded,[DosPart]));
      Result:=true;
    except
      on E: Exception do
      begin
        WriteLog(Format(rsErrNewPartyAdded2,[DosPart,E.Message]));
        Result:=false;
      end;
    end;
  end
  else
    Result:=false;
end;

function TTLDDataModule.InsertNewDosType(DosType: String): boolean;
begin
  if IsDBConnected then
  begin
    try
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                         +cFieldMeasVal+','
                                                         +cFieldDType1+','
                                                         +cFieldDType2+','
                                                         +cFieldDType3+','
                                                         +cFieldDType4+','
                                                         +cFieldFormula+','
                                                         +cFieldError+','
                                                         +cFieldFormulaId_Dos+','
                                                         +cFieldFormulaId_Val_1+','
                                                         +cFieldFormulaId_Val_2+','
                                                         +cFieldFormulaId_Val_3+','
                                                         +cFieldFormulaId_Val_4+','
                                                         +cFieldFormula_Err_k1_1+','
                                                         +cFieldFormula_Err_k2_1+','
                                                         +cFieldFormula_Err_k1_2+','
                                                         +cFieldFormula_Err_k2_2+','
                                                         +cFieldFormula_Err_k1_3+','
                                                         +cFieldFormula_Err_k2_3+','
                                                         +cFieldFormula_Err_k1_4+','
                                                         +cFieldFormula_Err_k2_4
                                                         +')'
                                                         +'VALUES('+#39+DosType+#39+','
                                                         +#39+cEmptyData+#39+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +#39+cEmptyData+#39+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+' '
                                                         +')');
      ADOQuery.ExecSQL;
      WriteLog(Format(rsNewDosTypeAdded,[DosType]));
      Result:=true;
    except
      on E: Exception do
      begin
        WriteLog(Format(rsErrNewDosTypeAdded,[DosType,E.Message]));
        Result:=false;
      end;
    end;
  end
  else
    Result:=false;
end;

function TTLDDataModule.InsertTestDos(aName: String): boolean;
var
  dosNumber  : String;
  dosPostfix : String;
  dosTypeID  : integer;
  dosType    : String;
begin
  if IsDBConnected then
  begin
    try
      ParseDosNumber(aName,dosNumber,dosPostfix);
      dosTypeID:=GetDosTypeID(cTestDosTypeName);
      dosType:=GetDosType(dosTypeID);

      ADOQuery.SQL.Clear; // очистить текст sql
      ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosID+'('+cFieldDosID+','
                                                       +cFieldDosPostfix+','
                                                       +cFieldDosTypeID+','
                                                       +cFieldDosType+','
                                                       +cFieldDosStatus+','
                                                       +cField_k1+','
                                                       +cField_k2+','
                                                       +cField_k3+','
                                                       +cField_k4+','
                                                       +cField_k5+','
                                                       +cField_kgn+','
                                                       +cFieldTldID+','
                                                       +cFieldPartID+','
                                                       +cFieldRegTime+','
                                                      // +cFieldVerTime+','
                                                       +cFieldOrg+','
                                                       +cFieldDepartment+','
                                                       +cFieldLastMeasComment+')'
                                         +'VALUES('+#39+dosNumber+#39+','
                                                   +#39+dosPostfix+#39+','
                                                   +#39+IntToStr(dosTypeID)+#39+','
                                                   +#39+dosType+#39+','
                                                   +#39+IntToStr(cDosCalibrated)+#39+','
                                                       +FloatToStrRegion(1)+','
                                                       +FloatToStrRegion(0)+','
                                                       +FloatToStrRegion(0)+','
                                                       +FloatToStrRegion(0)+','
                                                       +FloatToStrRegion(0)+','
                                                       +FloatToStrRegion(0)+','
                                                       +IntToStr(MainForm.DeviceID)+','
                                                       +IntToStr(0)+','
                                                   +#39+DateTimeToStr(Now)+#39+','
                                                  // +#39+DateTimeToStr(FNewDosimeter.Vertime)+#39+','
                                                   +#39+cEmptyData+#39+','
                                                   +#39+cEmptyData+#39+','
                                                   +#39+rsDosimeter4Testing+#39
                                                   +')');

      ADOQuery.ExecSQL;
      WriteLog(rsDosimeterAdded + ' "' + aName + '"');
      Result:=true;
    except
      on E: Exception do
      begin
        Showmessage(rsErrDosimeterAdded +' "'+aName+'". '+E.Message);
        WriteLog(rsErrDosimeterAdded +' "'+aName+'". '+E.Message);
        Result:=false;
      end;
    end;
  end
  else
    Result:=false;
end;

function TTLDDataModule.InsertTestDosType(DosType: String): boolean;
begin
  if IsDBConnected then
  begin
    try
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosType+'('+cFieldDosType+','
                                                         +cFieldMeasVal+','
                                                         +cFieldDType1+','
                                                         +cFieldDType2+','
                                                         +cFieldDType3+','
                                                         +cFieldDType4+','
                                                         +cFieldFormula+','
                                                         +cFieldError+','
                                                         +cFieldFormulaId_Dos+','
                                                         +cFieldFormulaId_Val_1+','
                                                         +cFieldFormulaId_Val_2+','
                                                         +cFieldFormulaId_Val_3+','
                                                         +cFieldFormulaId_Val_4+','
                                                         +cFieldFormula_Err_k1_1+','
                                                         +cFieldFormula_Err_k2_1+','
                                                         +cFieldFormula_Err_k1_2+','
                                                         +cFieldFormula_Err_k2_2+','
                                                         +cFieldFormula_Err_k1_3+','
                                                         +cFieldFormula_Err_k2_3+','
                                                         +cFieldFormula_Err_k1_4+','
                                                         +cFieldFormula_Err_k2_4
                                                         +')'
                                                         +'VALUES('+#39+DosType+#39+','
                                                         +#39+cHp_10g+#39+','
                                                         +IntToStr(1)+','
                                                         +IntToStr(1)+','
                                                         +IntToStr(1)+','
                                                         +IntToStr(1)+','
                                                         +#39+cEmptyData+#39+','
                                                         +'0'+','
                                                         +IntToStr(cHp_10g_4d)+','
                                                         +IntToStr(cMeanD1D2D3D4_K1)+','
                                                         +IntToStr(c_NoFormula)+','
                                                         +IntToStr(c_NoFormula)+','
                                                         +IntToStr(c_NoFormula)+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+','
                                                         +'0'+' '
                                                         +')');
      ADOQuery.ExecSQL;
      WriteLog(Format(rsNewDosTypeAdded,[DosType]));
      Result:=true;
    except
      on E: Exception do
      begin
        WriteLog(Format(rsErrNewDosTypeAdded,[DosType,E.Message]));
        Result:=false;
      end;
    end;
  end
  else
    Result:=false;
end;

function TTLDDataModule.CheckTableInDB(aTableName: String): boolean;
var
  flag  : boolean;
begin
  if IsDBConnected then
  begin
    try
      if ADOQuery.Active then ADOQuery.Close;
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('SELECT EXISTS (SELECT * FROM pg_tables WHERE tablename = '+#39+aTableName+#39+');');
      ADOQuery.Open;

      flag:=StrToBool(ADOQuery.FieldByName('exists').AsString);

      if not flag then
        WriteLog(Format('%s - "%s"',[rsNoTable,aTableName]));

      Result:=flag;

    except
      on E: Exception do
      begin
        WriteLog(Format('%s - "%s"',[rsErrCheckTable,aTableName]));
        Result:=false;
      end;
    end;
  end
  else
    Result:=false;

  ADOQuery.Close;
end;

function TTLDDataModule.IsDBExist(aDBName: String): boolean;
var
  i        : integer;
  IsExist  : boolean;
  str      : string;
  b        : integer;
begin
  if ADOQuery.Active then ADOQuery.Close;
  //ADOQuery.Active:=True;

  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('select datname from pg_database order by datname');
  ADOQuery.Active:=True;
  //ADOQuery.Open;


  IsExist:=false;

  b:=ADOQuery.RecordCount;

  for i := 0 to ADOQuery.RecordCount-1 do
  begin

    str:=ADOQuery.FieldByName('datname').Value;

    if ADOQuery.FieldByName('datname').Value = aDBName then
    begin
      IsExist:=true;
      break;
    end
    else
      IsExist:=false;

    ADOQuery.Next;
  end;

  result:=IsExist;

  ADOQuery.Active:=False;
  ADOQuery.Close;
end;

function TTLDDataModule.IsDeviceIdExist(Value: integer): boolean;
const
  cCount = 'count';
var
  idCnt: integer;
begin
  if IsDBConnected then
  begin
    if ADOQuery.Active then ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add(Format('SELECT %s (*) FROM %s WHERE %s = %s',[cCount,cDBTableSettings,cFieldTldID,IntToStr(Value)]));
    ADOQuery.Open;
    idCnt:=ADOQuery.FieldByName(cCount).AsInteger;

    if idCnt>0 then
      Result:=true
    else
      Result:=false;
  end
  else
    Result:=false;

  ADOQuery.Close;
end;

function TTLDDataModule.IsDosimeterExist(Value: String): boolean;
var
  idCnt: integer;
begin
  if IsDBConnected then
  begin
    // проверяем наличие дозиметра в БД
    if ADOQuery.Active then ADOQuery.Close;
    ADOQuery.SQL.Clear;

    ADOQuery.SQL.Add('SELECT count(*) '
                    +'FROM ( '
                    +'SELECT '
                      +'CASE '+cFieldDosPostfix+' '
                      +'WHEN '+#39+'-'+#39+' THEN CAST('+cFieldDosID+' AS TEXT) '
                      +'ELSE CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' END '
                      +'AS '+cFullDosID+' '
                      +'FROM '+cDBTableDosID+') AS calctable '
                    +'WHERE '+cFullDosID+' = '+#39+Value+#39
                    );

    ADOQuery.Open;
    idCnt:=ADOQuery.FieldByName(cCount).AsInteger;
    ADOQuery.Close;

    if (idCnt > 0) then
      Result:=true
    else
      Result:=false;
  end
  else
    Result:=false;
end;

function TTLDDataModule.IsDosimeterInPart(Value: String): boolean;
begin
  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '
                             +cFieldPartID+' '
                      +'FROM '
                             +cDBTableDosID+' '
                      +'WHERE (CAST (dosimeterid AS TEXT) LIKE '+#39+Value+#39+' OR CAST (dosimeterid AS TEXT) || postfix LIKE '+#39+Value+#39+')'+' '
                             +'AND '+cFieldPartID+'>0'

                      );
    ADOQuery.Active:=True;

    if ADOQuery.RecordCount > 0 then
      Result:=true
    else
      Result:=false;

    ADOQuery.Close;
  end
  else
    Result:=false;
end;

function TTLDDataModule.AddNewDosPart(PartName: String; K1, K2, K3, K4, K5, Kgn: double; DosCnt: integer; DosType: String; CalibrDate: TDateTime): boolean;
begin
  if ODBCConnection.Connected then
  begin
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosPart+'('+cFieldDosPartName+','
                                                       +cField_k1+','
                                                       +cField_k2+','
                                                       +cField_k3+','
                                                       +cField_k4+','
                                                       +cField_k5+','
                                                       +cField_kgn+','
                                                       +cFieldDosPartCnt+','
                                                       +cFieldDosType+','
                                                       +cFieldVerTime+','
                                                       +cFieldTldID+')'
                                         +'VALUES('+#39+PartName+#39+','
                                                       +FloatToStrRegion(K1)+','
                                                       +FloatToStrRegion(K2)+','
                                                       +FloatToStrRegion(K3)+','
                                                       +FloatToStrRegion(K4)+','
                                                       +FloatToStrRegion(K5)+','
                                                       +FloatToStrRegion(Kgn)+','
                                                       +IntToStr(DosCnt)+','
                                                   +#39+DosType+#39+','
                                                   +#39+DateToStr(CalibrDate)+#39+','
                                                       +IntToStr(MainForm.DeviceID)+')');
    ADOQuery.ExecSQL;
    Result:=true;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.ChangeDosNumberInMeasResult(MeasID: integer; DosName,
  Postfix: string): boolean;
begin
  if MeasID>0 then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosRes+' SET ('+cFieldDosID+','
                                                                    +cFieldDosPostfix+''
                                                                   +') '
                                                                   +'= ('+DosName+','
                                                                   +#39+Postfix+#39+')'+' '
                                                          +'WHERE '+cFieldDosMeasID+' = '+IntToStr(MeasID)+';');
    TLDDataModule.ADOQuery.ExecSQL;
    Result:=true;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrChangeDosNumberInMeas,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.UpdateAdditionalParametersInDos(DosID, Organization, Department: String): boolean;
begin
  if ODBCConnection.Connected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('UPDATE '+cDBTableDosID
                              +' SET ('
                                      +cFieldOrg+','
                                      +cFieldDepartment
                                    +')'
                                    +'='
                                    +'('
                                      +#39+Organization+#39+','
                                      +#39+Department+#39
                                    +')'
                                    +' WHERE ((CAST('+cFieldDosID+' AS TEXT) = '+#39+DosID+#39+') AND '+cFieldDosPostfix+' = '+#39+'-'+#39+') OR CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' = '+#39+DosID+#39);
    ADOQuery.ExecSQL;
    Result:=true;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.UpdateDBComment(DBName: String; Comment: String): boolean;
begin
  if ODBCConnection.Connected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;

    ADOQuery.SQL.Add('COMMENT ON DATABASE '+DBName+' IS '+#39+Comment+#39);

//    ADOQuery.SQL.Add('UPDATE '+cDBTableSettings+' SET ('
//                                                   +cFieldKSLevel+','
//                                                   +cFieldKSDelta+','
//                                                   +cFieldKFilter+','
//                                                   +cFieldKDevice+')'
//                                               +'=('
//                                                   +IntToStr(KSLevel)+','
//                                                   +IntToStr(KSDelta)+','
//                                                   +FloatToStrRegion(KFilter)+','
//                                                   +FloatToStrRegion(KFilter)+')'
//                                               +'WHERE '+cFieldTldID+'='+IntToStr(TLDID)
//                                               );
    ADOQuery.ExecSQL;
    Result:=true;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.UpdateDeviceConfig(TLDID,KSLevel,KSDelta: integer; KFilter,KDev: double): boolean;
begin
  if ODBCConnection.Connected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('UPDATE '+cDBTableSettings+' SET ('
                                                   +cFieldKSLevel+','
                                                   +cFieldKSDelta+','
                                                   +cFieldKFilter+','
                                                   +cFieldKDevice+')'
                                               +'=('
                                                   +IntToStr(KSLevel)+','
                                                   +IntToStr(KSDelta)+','
                                                   +FloatToStrRegion(KFilter)+','
                                                   +FloatToStrRegion(KFilter)+')'
                                               +'WHERE '+cFieldTldID+'='+IntToStr(TLDID)
                                               );
    ADOQuery.ExecSQL;
    Result:=true;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.UpdateDosimeterInLibrary(DosID, Postfix, DosTypeID, DosType, Status, K1, K2, K3, K4, K5, Kgn, DeviceID, PartID, RegTime, VerTime, Org, Dep: String): boolean;
begin
  if ODBCConnection.Connected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET ('
                                                   +cFieldDosTypeID+','
                                                   +cFieldDosType+','
                                                   +cFieldDosStatus+','
                                                   +cField_k1+','
                                                   +cField_k2+','
                                                   +cField_k3+','
                                                   +cField_k4+','
                                                   +cField_k5+','
                                                   +cField_kgn+','
                                                   +cFieldTldID+','
                                                   +cFieldPartID+','
                                                   +cFieldRegTime+','
                                                   +cFieldVerTime+','
                                                   +cFieldOrg+','
                                                   +cFieldDepartment+')'
                                               +'=('
                                                   +#39+DosTypeID+#39+','
                                                   +#39+DosType+#39+','
                                                   +#39+Status+#39+','
                                                   +K1+','
                                                   +K2+','
                                                   +K3+','
                                                   +K4+','
                                                   +K5+','
                                                   +Kgn+','
                                                   +DeviceID+','
                                                   +PartID+','
                                                   +#39+RegTime+#39+','
                                                   +#39+VerTime+#39+','
                                                   +#39+Org+#39+','
                                                   +#39+Dep+#39
                                               +')'+'WHERE '+cFieldDosID+'='+#39+DosID+#39+' AND ' +cFieldDosPostfix+'='+#39+Postfix+#39
                                               );
    ADOQuery.ExecSQL;
    Result:=true;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.InsertDosimeterInLibrary(DosID, Postfix, DosTypeID, DosType, Status, K1, K2, K3, K4, K5, Kgn, DeviceID, PartID, RegTime, VerTime, Org, Dep: String): boolean;
begin
  if ODBCConnection.Connected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('INSERT INTO '+cDBTableDosID+'('+cFieldDosID+','
                                                     +cFieldDosPostfix+','
                                                     +cFieldDosTypeID+','
                                                     +cFieldDosType+','
                                                     +cFieldDosStatus+','
                                                     +cField_k1+','
                                                     +cField_k2+','
                                                     +cField_k3+','
                                                     +cField_k4+','
                                                     +cField_k5+','
                                                     +cField_kgn+','
                                                     +cFieldTldID+','
                                                     +cFieldPartID+','
                                                     +cFieldRegTime+','
                                                     +cFieldVerTime+','
                                                     +cFieldOrg+','
                                                     +cFieldDepartment+')'
                                       +'VALUES('+#39+DosID+#39+','
                                                 +#39+Postfix+#39+','
                                                 +#39+DosTypeID+#39+','
                                                 +#39+DosType+#39+','
                                                 +#39+Status+#39+','
                                                     +K1+','
                                                     +K2+','
                                                     +K3+','
                                                     +K4+','
                                                     +K5+','
                                                     +Kgn+','
                                                     +DeviceID+','
                                                     +PartID+','
                                                 +#39+RegTime+#39+','
                                                 +#39+VerTime+#39+','
                                                 +#39+Org+#39+','
                                                 +#39+Dep+#39
                                                 +')'
                                                 );
    ADOQuery.ExecSQL;
    Result:=true;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.UpdatePartInDos(DosName: String; K1,K2,K3,K4,K5,Kgn: double; PartID: integer; CalibrDate: TDateTime): boolean;
begin
  if ODBCConnection.Connected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET ('+cField_k1+','
                                                     +cField_k2+','
                                                     +cField_k3+','
                                                     +cField_k4+','
                                                     +cField_k5+','
                                                     +cField_kgn+','
                                                     +cFieldDosStatus+','
                                                     +cFieldPartID+','
                                                     +cFieldVerTime+')'
                                                 +'='
                                                 +'('+FloatToStrRegion(K1)+','
                                                     +FloatToStrRegion(K2)+','
                                                     +FloatToStrRegion(K3)+','
                                                     +FloatToStrRegion(K4)+','
                                                     +FloatToStrRegion(K5)+','
                                                     +FloatToStrRegion(Kgn)+','
                                                     +IntToStr(cDosCalibrated)+','
                                                     +IntToStr(PartID)+','
                                                 +#39+DateToStr(CalibrDate)+#39+')'
                                    +' WHERE ((CAST('+cFieldDosID+' AS TEXT) = '+#39+DosName+#39+') AND '+cFieldDosPostfix+' = '+#39+'-'+#39+') OR CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' = '+#39+DosName+#39);
    ADOQuery.ExecSQL;
    Result:=true;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.UpdateKInDosIDByPart(K1,K2,K3,K4,K5,Kgn: double; PartID: integer; CalibrDate: TDateTime; CalibrState: integer): boolean;
begin
  if ODBCConnection.Connected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET ('+cField_k1+','
                                                     +cField_k2+','
                                                     +cField_k3+','
                                                     +cField_k4+','
                                                     +cField_k5+','
                                                     +cField_kgn+','
                                                     +cFieldDosStatus+','
                                                     +cFieldVerTime+')'
                                                 +'='
                                                 +'('+FloatToStrRegion(K1)+','
                                                     +FloatToStrRegion(K2)+','
                                                     +FloatToStrRegion(K3)+','
                                                     +FloatToStrRegion(K4)+','
                                                     +FloatToStrRegion(K5)+','
                                                     +FloatToStrRegion(Kgn)+','
                                                     +IntToStr(CalibrState)+','
                                                 +#39+DateToStr(CalibrDate)+#39+')'
                                           +' WHERE '+cFieldPartID+'='+IntToStr(PartID));
    ADOQuery.ExecSQL;
    Result:=true;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.UpdateKInPart(K1, K2, K3, K4, K5, Kgn: double; PartID: integer; CalibrDate: TDateTime; CalibrState: integer): boolean;
begin
  if ODBCConnection.Connected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('UPDATE '+cDBTableDosPart+' SET '+cField_k1+              '='   +FloatToStrRegion(k1)+','
                                                      +cField_k2+              '='   +FloatToStrRegion(k2)+','
                                                      +cField_k3+              '='   +FloatToStrRegion(k3)+','
                                                      +cField_k4+              '='   +FloatToStrRegion(k4)+','
                                                      +cField_k5+              '='   +FloatToStrRegion(k5)+','
                                                      +cField_kgn+             '='   +FloatToStrRegion(kgn)+','
                                                      +cFieldVerTime+          '='   +#39+DateToStr(CalibrDate)+#39+''
                                            +' WHERE '+cFieldPartID+           '='   +IntToStr(PartID));
    ADOQuery.ExecSQL;
    Result:=true;
  end
  else
  begin
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));
    Result:=false;
  end;
end;

function TTLDDataModule.IsDosimeterPartExist(Part: String; TLDid: integer): boolean;
begin
  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '
                             +cFieldDosPartName+' '
                      +'FROM '
                             +cDBTableDosPart+' '
                     +'WHERE '
                             +cFieldDosPartName+' = '+#39+Part+#39
                      +'AND '
                             +cFieldTldID+' = '+IntToStr(TLDid)
                             );
    ADOQuery.Active:=True;

    if ADOQuery.RecordCount > 0 then
      Result:=true
    else
      Result:=false;

    ADOQuery.Close;
  end
  else
    Result:=false;
end;

function TTLDDataModule.IsDosimeterPartUsed(Value: String): boolean;
begin
  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '
                             +cFieldPartID+' '
                      +'FROM '
                             +cDBTableDosID+' '
                     +'WHERE '
                             +cFieldPartID+' = '+#39+Value+#39);
    ADOQuery.Active:=True;

    if ADOQuery.RecordCount > 0 then
      Result:=true
    else
      Result:=false;

    ADOQuery.Close;
  end
  else
    Result:=false;
end;

function TTLDDataModule.IsDosimeterTypeExist(Value: String): boolean;
begin
  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '
                             +cFieldDosType+' '
                      +'FROM '
                             +cDBTableDosType+' '
                     +'WHERE '
                             +cFieldDosType+' = '+#39+Value+#39);
    ADOQuery.Active:=True;

    if ADOQuery.RecordCount > 0 then
      Result:=true
    else
      Result:=false;

    ADOQuery.Close;
  end
  else
    Result:=false;
end;

function TTLDDataModule.IsDosimeterTypeUsed(Value: String): boolean;
begin
  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '
                             +cFieldDosType+' '
                      +'FROM '
                             +cDBTableDosID+' '
                     +'WHERE '
                             +cFieldDosType+' = '+#39+Value+#39);
    ADOQuery.Active:=True;

    if ADOQuery.RecordCount > 0 then
      Result:=true
    else
      Result:=false;

    ADOQuery.Close;
  end
  else
    Result:=false;
end;

function TTLDDataModule.IsDetectorTypeExist(Value: String): boolean;
begin
  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '
                             +cFieldDetType+' '
                      +'FROM '
                             +cDBTableDetType+' '
                     +'WHERE '
                             +cFieldDetType+' = '+#39+Value+#39);
    ADOQuery.Active:=True;

    if ADOQuery.RecordCount > 0 then
      Result:=true
    else
      Result:=false;

    ADOQuery.Close;
  end
  else
    Result:=false;
end;

function TTLDDataModule.IsDetectorTypeUsed(Value: String): boolean;
var
  detTypeID: integer;
begin
  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '
                             +cFieldDetTypeID+' '
                      +'FROM '
                             +cDBTableDetType+' '
                     +'WHERE '
                             +cFieldDetType+' = '+#39+Value+#39);
    ADOQuery.Active:=True;

    detTypeID:=ADOQuery.FieldByName(cFieldDetTypeID).AsInteger;

    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '
                             +cFieldDType1+','
                             +cFieldDType2+','
                             +cFieldDType3+','
                             +cFieldDType4+' '
                      +'FROM '
                             +cDBTableDosType+' '
                     +'WHERE '
                             +cFieldDType1+' = '+IntToStr(detTypeID)+' '
                        +'OR '
                             +cFieldDType2+' = '+IntToStr(detTypeID)+' '
                        +'OR '
                             +cFieldDType3+' = '+IntToStr(detTypeID)+' '
                        +'OR '
                             +cFieldDType4+' = '+IntToStr(detTypeID)+' '
                             );
    ADOQuery.Active:=True;

    if ADOQuery.RecordCount > 0 then
      Result:=true
    else
      Result:=false;

    ADOQuery.Close;
  end
  else
    Result:=false;
end;

function TTLDDataModule.IsMeasIDExist(MeasID: integer): boolean;
const
  cCount = 'count';
var
  idCnt: integer;
begin
  if IsDBConnected then
  begin
    // проверяем наличие ID установки в БД
    if ADOQuery.Active then ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add(Format('select %s (*) from %s where %s = %s',[cCount,cDBTableDosRes,cFieldDosMeasID,IntToStr(MeasID)]));
    ADOQuery.Open;
    idCnt:=ADOQuery.FieldByName(cCount).AsInteger;

    if (idCnt > 0) then Result:=True else Result:=False;

    ADOQuery.Close;
  end
  else
    Result:=False;
end;

function TTLDDataModule.GetNewMeasID: integer;
var
  uniqueID  : integer;
  cnt       : integer;
  quit      : boolean;
begin
  uniqueID:=-1;
  quit:=false;
  cnt:=0;

  if IsDBConnected then
  begin
    if ADOQuery.Active then ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT MAX ('+cFieldDosMeasID+') FROM '+cDBTableDosRes);
    ADOQuery.Open;
    uniqueID:=ADOQuery.FieldByName('MAX').AsInteger+1;

    while not quit do
    begin
      if not IsMeasIDExist(uniqueID) then
        quit:=true
      else
      begin
        inc(uniqueID);
        inc(cnt);
      end;

      if (cnt=1000) then
      begin
        quit:=true;
        uniqueID:=-1;
      end;
    end;

    ADOQuery.Close;
  end;

  Result:=uniqueID;
end;

function TTLDDataModule.GetAllPartIDByName(PartName: String): String;
var
  strID: String;
begin
  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT ARRAY (SELECT '+cFieldPartID+' FROM '+cDBTableDosPart+' WHERE '
                                                                             +cFieldDosPartName+' = '+#39+PartName+#39
                                 +') AS '+cFieldPartID
                                                                             );
    ADOQuery.Active:=True;

    if ADOQuery.FieldValues[cFieldPartID] <> null then
      strID:=ADOQuery.FieldValues[cFieldPartID]
    else
      strID:='0';

    strID := StringReplace(strID, '{', '', [rfreplaceall]);
    strID := StringReplace(strID, '}', '', [rfreplaceall]);
  except
    on E: exception do
    begin
      strID:='0';
      WriteLog(Format(rsErrFindParty,[cFieldPartID]));
    end;
  end;

  Result:=strID;
end;

function TTLDDataModule.GetBackupDBName: String;
const
  cErrorExit = 10000;
var
  dbExist     : boolean;
  cnt         : integer;
  strCnt      : String;
  backupName  : String;
begin
  Result:='';
  dbExist:=true;
  cnt:=1;

  while dbExist do
  begin
    if cnt < 10 then
      strCnt:=Format('0%d',[cnt])
    else
     strCnt:=Format('%d',[cnt]);

    if TLDDataModule.IsDBExist(Format('%s_%s_%s',[cDefaultDB,cBackup,strCnt])) then
    begin
      dbExist:=true;
      inc(cnt);
      if cnt>cErrorExit then dbExist:=false;
    end
    else
    begin
      dbExist:=false;
      if cnt < 10 then
        strCnt:=Format('0%d',[cnt])
      else
       strCnt:=Format('%d',[cnt]);

      backupName:=Format('%s_%s_%s',[cDefaultDB,cBackup,strCnt]);
    end;
  end;

  Result:=backupName;
end;

function TTLDDataModule.GetDBConnection: boolean;
begin
  result:=ODBCConnection.Connected;

  OnDBConnection(result);
end;

function TTLDDataModule.Get_ASIDK_DBConnection: boolean;
begin
  result:=ADOConnectionASIDK.Connected;

  On_ASIDK_DBConnection(result);
end;

function TTLDDataModule.GetDBVersion: integer;
const
  cNoVersion = 13;
begin
  if IsDBConnected then
  begin
    try
      if ADOQuery.Active then ADOQuery.Close;
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add(Format('SELECT %s FROM %s',[cFieldDBVersion,cDBTableConfig]));
      ADOQuery.Open;

      Result:=ADOQuery.FieldByName(cFieldDBVersion).AsInteger;
    except
      Result:=cNoVersion;
    end;
  end
  else
    Result:=cNoVersion;

  ADOQuery.Close;
end;

function TTLDDataModule.GetDefaultPartName: String;
var
  partName      : String;
  cnt           : integer;
  cntRec        : integer;
begin
  cnt    := 1;
  cntRec := 1;

  try
    while cntRec <> 0 do
    begin
      partName:=Format('%s\%s_%d',[IntToStr(MainForm.DeviceID),rsFltPart,cnt]);

      ADOQuery.Active:=False;
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('SELECT '+cFieldDosPartName+' FROM '+cDBTableDosPart
                                                           +' WHERE '+cFieldDosPartName+' = '+#39+partName+#39
                                                           +' AND '+cFieldTldID+' = '+IntToStr(MainForm.DeviceID));
      ADOQuery.Active:=True;

      if ADOQuery.RecordCount <> 0 then inc(cnt);

      cntRec:=ADOQuery.RecordCount;
    end;
  except
    on E: exception do
    begin
      partName:='';
      WriteLog(rsErrFormPartyName);
    end;
  end;

  Result:=partName;
end;

function TTLDDataModule.GetDetDose(MeasID: String; DetPos: integer): String;
var
  dose: String;
begin
  dose:='';

  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldDose+' FROM '+cDBTableDetRes
                                         +' WHERE '+cFieldDosMeasID+' = '+MeasID+' AND '+cFieldDetPosition+' = '+IntToStr(DetPos));
    ADOQuery.Active:=True;

    if ADOQuery.FieldByName(cFieldDose).AsVariant <> Null then
      dose:=FloatToStr{Region}(ADOQuery.FieldByName(cFieldDose).AsFloat)
    else
      dose:='';

  except
    on E: exception do
    begin
      dose:='';
      WriteLog(Format(rsErrGetDetDose,[dose]));
    end;
  end;

  Result:=dose;
end;

function TTLDDataModule.GetDetTypeID(DetType: String): integer;
var
  typeDetID: integer;
begin
  typeDetID:=-1;

  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('select '+cFieldDetTypeID+' from '+cDBTableDetType+' where '+cFieldDetType+' = '+#39+DetType+#39);
    ADOQuery.Active:=True;

    if ADOQuery.FieldValues[cFieldDetTypeID] <> null then
    begin
      if not TryStrToInt(ADOQuery.FieldValues[cFieldDetTypeID],typeDetID) then typeDetID := -1;
    end
    else
      typeDetID := -1;

  except
    on E: exception do
    begin
      typeDetID:=-1;
      WriteLog(Format(rsErrFindDetType,[DetType]));
    end;
  end;

  Result:=typeDetID;
end;

function TTLDDataModule.GetDiscommisionedDosimetersNumbers: TStringList;
var
  i: integer;
begin
  Result:=TStringList.Create;

  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT CASE postfix WHEN '+#39'-'+#39+' THEN CAST(dosimeterid AS TEXT) ELSE CAST (dosimeterid AS TEXT) || postfix END AS fulldosid'+' '
                                                     +'FROM'+' '+cDBTableDosID+' '
                                                     +'WHERE'+' '+cFieldDosStatus+'='+IntToStr(cDosDecommissioned)
                                                     );
    ADOQuery.Active:=True;

    for i:=0 to ADOQuery.RecordCount-1 do
    begin
      Result.Add(ADOQuery.FieldValues[cFullDosID]);
      if i <> ADOQuery.RecordCount-1 then ADOQuery.Next;
    end;

  end
  else
    Result.Free;
end;

function TTLDDataModule.GetMarkedToDelMeas: TStringList;
var
  i: integer;
begin
  Result:=TStringList.Create;

  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldDosMeasID+','+'CASE postfix WHEN '+#39'-'+#39+' THEN CAST(dosimeterid AS TEXT) ELSE CAST (dosimeterid AS TEXT) || postfix END AS fulldosid'+' '
                                                     +'FROM'+' '+cDBTableDosRes+' '
                                                     +'WHERE'+' '+cFieldToDel+'='+'true'+' '
                                                     +'ORDER BY '+cFieldDosMeasID
                                                     );
    ADOQuery.Active:=True;

    for i:=0 to ADOQuery.RecordCount-1 do
    begin
      Result.Add(Format('%s %s %s %s',[rsMeasurement,ADOQuery.FieldValues[cFieldDosMeasID],rsOfDosimeter,ADOQuery.FieldValues[cFullDosID]]));
      if i <> ADOQuery.RecordCount-1 then ADOQuery.Next;
    end;

  end
  else
    Result.Free;
end;

function TTLDDataModule.GetMeasFromDate(DateFrom: TDateTime): TStringList;
var
  i: integer;
begin
  Result:=TStringList.Create;

  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldDosMeasID+','+'CASE '+cFieldDosPostfix+' WHEN '+#39'-'+#39+' THEN CAST('+cFieldDosID+' AS TEXT) ELSE CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' END AS '+cFullDosID+' '
                                              +'FROM'+' '+cDBTableDosRes+' '
                                              +'WHERE'+' ('+cFieldMeasureTime+'>'+#39+DateTimeToStr(DateFrom)+#39+') AND ('+cFieldToDel+'=false)'
                                              +'ORDER BY '+cFieldDosMeasID+' DESC'
                                              );
    ADOQuery.Active:=True;

    for i:=0 to ADOQuery.RecordCount-1 do
    begin
      Result.Add(Format('%s[%s]',[ADOQuery.FieldValues[cFullDosID],ADOQuery.FieldValues[cFieldDosMeasID]]));
      if i <> ADOQuery.RecordCount-1 then ADOQuery.Next;
    end;

  end
  else
    Result.Free;
end;

function TTLDDataModule.GetDosListInPart(PartID: integer): TStringList;
var
  i: integer;
begin
  Result:=TStringList.Create;

  if IsDBConnected then
  begin
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+'CASE '+cFieldDosPostfix+' WHEN '+#39'-'+#39+' THEN CAST('+cFieldDosID+' AS TEXT) ELSE CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' END AS '+cFullDosID+' '
                                              +'FROM'+' '+cDBTableDosID+' '
                                              +'WHERE'+' '+cFieldPartID+'='+IntToStr(PartID)+' '
                                              +'ORDER BY '+cFullDosID+' DESC'
                                              );
    ADOQuery.Active:=True;

    for i:=0 to ADOQuery.RecordCount-1 do
    begin
      Result.Add(Format('%s',[ADOQuery.FieldValues[cFullDosID]]));
      if i <> ADOQuery.RecordCount-1 then ADOQuery.Next;
    end;

  end
  else
    Result.Free;

end;

function TTLDDataModule.GetPartID(PartName: String; DeviceID: integer): integer;
var
  partID: integer;
begin
  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldPartID+' FROM '+cDBTableDosPart+' WHERE '
                                                                             +cFieldDosPartName+' = '+#39+PartName+#39
                                                                             +' AND '
                                                                             +cFieldTldID+' = '+IntToStr(DeviceID)
                                                                             );
    ADOQuery.Active:=True;

    if ADOQuery.FieldValues[cFieldPartID] <> null then
      partID:=ADOQuery.FieldValues[cFieldPartID]
    else
      partID:=0;

  except
    on E: exception do
    begin
      partID:=0;
      WriteLog(Format(rsErrFindParty,[cFieldPartID]));
    end;
  end;

  Result:=partID;
end;

function TTLDDataModule.GetPartIDFromMeas(PartName: String): integer;
var
  partID: integer;
begin
  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldPartID+' FROM '+cDBTableDosRes+' WHERE '+cFieldDosPartName+' = '+#39+PartName+#39);
    ADOQuery.Active:=True;

    if ADOQuery.FieldValues[cFieldPartID] <> null then
      partID:=ADOQuery.FieldValues[cFieldPartID]
    else
      partID:=0;

  except
    on E: exception do
    begin
      partID:=0;
      WriteLog(Format(rsErrFindParty,[cFieldPartID]));
    end;
  end;

  Result:=partID;

end;

function TTLDDataModule.GetPartName(PartID: integer): String;
const
  cNotFound='Not found';
var
  partName : String;
begin
  partName:=cNotFound;

  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldDosPartName+' FROM '+cDBTableDosPart+' WHERE '+cFieldPartID+' = '+IntToStr(PartID));
    ADOQuery.Active:=True;

    if ADOQuery.FieldValues[cFieldDosPartName] <> null then
      partName:=ADOQuery.FieldValues[cFieldDosPartName]
    else
      partName:=cNotFound;

    ADOQuery.Active:=False;
  except
    on E: exception do
    begin
      partName:=cNotFound;
      ADOQuery.Active:=False;
      WriteLog(Format(rsErrFindParty+'[',[PartID])+']');
    end;
  end;

  Result:=partName;
end;

function TTLDDataModule.GetDosCntInPart(PartID: integer): integer;
var
  cnt: integer;
begin
  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldDosPartCnt+' FROM '+cDBTableDosPart+' WHERE '+cFieldPartID+' = '+IntToStr(PartID));
    ADOQuery.Active:=True;

    cnt:=ADOQuery.FieldByName(cFieldDosPartCnt).AsInteger;

  except
    on E: exception do
    begin
      cnt:=0;
      WriteLog(Format('%s - %s',[rsErrCalcDosimetersAtParty,cFieldPartID]));
    end;
  end;

  Result:=cnt;
end;

function TTLDDataModule.GetDosTypeInPart(PartID: integer): String;
var
  dosType: String;
begin
  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldDosType+' FROM '+cDBTableDosPart+' WHERE '+cFieldPartID+' = '+IntToStr(PartID));
    ADOQuery.Active:=True;

    dosType:=ADOQuery.FieldByName(cFieldDosType).AsString;

  except
    on E: exception do
    begin
      dosType:='-';
      WriteLog(Format('%s - %s',[rsErrDefDosTypeAtParty,cFieldPartID]));
    end;
  end;

  Result:=dosType;
end;

function TTLDDataModule.GetDataBaseComment(DataBaseName: String): String;
var
  comment: String;
begin
  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldDBDescription+' FROM '+'pg_shdescription'
                              +' JOIN pg_database ON objoid = pg_database.oid'
                              +' WHERE '+'datname'+' = '+#39+DataBaseName+#39);
    ADOQuery.Active:=True;

    comment:=ADOQuery.FieldByName(cFieldDBDescription).AsString;
    ADOQuery.Active:=False;
  except
    on E: exception do
    begin
      comment:='';
      WriteLog(Format('%s - %s',[rsErrFindDBComment,DataBaseName]));
    end;
  end;

  Result:=comment;
end;

procedure TTLDDataModule.GetKFromPart(PartName: String; var aK1: double;
  var aK2: double; var aK3: double; var aK4: double; var aK5: double;
  var aKgn: double);
  function CheckNan(Field: String; ADOQuery: TSQLQuery): double;
  begin
    if ADOQuery.FieldByName(Field).AsVariant <> Null then
      Result:=ADOQuery.FieldByName(Field).AsFloat
    else
      Result:=NAN;
  end;
begin
  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cField_k1+','
                              +cField_k2+','
                              +cField_k3+','
                              +cField_k4+','
                              +cField_k5+','
                              +cField_kgn+' '
                     +' FROM '+cDBTableDosPart
                     +' WHERE '+cFieldDosPartName+' = '+#39+PartName+#39
                     +' AND '+cFieldTldID+' = '+IntToStr(MainForm.DeviceID));
    ADOQuery.Active:=True;

    aK1:=RoundToCN(CheckNan(cField_k1, ADOQuery),-2);
    aK2:=RoundToCN(CheckNan(cField_k2, ADOQuery),-2);
    aK3:=RoundToCN(CheckNan(cField_k3, ADOQuery),-2);
    aK4:=RoundToCN(CheckNan(cField_k4, ADOQuery),-2);
    aK5:=RoundToCN(CheckNan(cField_k5, ADOQuery),-2);
    aKgn:=RoundToCN(CheckNan(cField_kgn, ADOQuery),-2);
  except
    on E: exception do
    begin
//      partID:=0;
//      WriteLog(Format(rsErrFindParty,[cFieldPartID]));
    end;
  end;

end;

function TTLDDataModule.GetDosPartID(DosName: String): integer;
var
  partID: integer;
begin
  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldPartID+' FROM '+cDBTableDosID
                                          +' WHERE ((CAST('+cFieldDosID+' AS TEXT) = '+#39+DosName+#39+') AND '+cFieldDosPostfix+' = '+#39+'-'+#39+') OR CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' = '+#39+DosName+#39);
                                          // +' WHERE (CAST (dosimeterid AS TEXT) LIKE '+#39+DosName+#39+' OR CAST (dosimeterid AS TEXT) || postfix LIKE '+#39+DosName+#39+')');
    ADOQuery.Active:=True;

    if ADOQuery.FieldValues[cFieldPartID] <> null then
      partID:=ADOQuery.FieldValues[cFieldPartID]
    else
      partID:=0;

  except
    on E: exception do
    begin
      partID:=0;
      WriteLog(Format(rsErrFindParty,[cFieldPartID]));
    end;
  end;

  Result:=partID;
end;

function TTLDDataModule.GetDosType(DosTypeID: integer): String;
const
  cNotFound='Not found';
var
  typeDos : String;
begin
  typeDos:=cNotFound;

  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldDosType+' FROM '+cDBTableDosType+' WHERE '+cFieldDosTypeID+' = '+IntToStr(DosTypeID));
    ADOQuery.Active:=True;

    if ADOQuery.FieldValues[cFieldDosType] <> null then
      typeDos:=ADOQuery.FieldValues[cFieldDosType]
    else
      typeDos:=cNotFound;

  except
    on E: exception do
    begin
      typeDos:=cNotFound;
      WriteLog(Format(rsErrFindDosType,[DosTypeID]));
    end;
  end;

  Result:=typeDos;

end;

function TTLDDataModule.GetDetType(DetTypeID: integer): String;
const
  cNotFound='Not found';
var
  typeDet : String;
begin
  typeDet:=cNotFound;

  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('SELECT '+cFieldDetType+' FROM '+cDBTableDetType+' WHERE '+cFieldDetTypeID+' = '+IntToStr(DetTypeID));
    ADOQuery.Active:=True;

    if ADOQuery.FieldValues[cFieldDetType] <> null then
      typeDet:=ADOQuery.FieldValues[cFieldDetType]
    else
      typeDet:=cNotFound;

  except
    on E: exception do
    begin
      typeDet:=cNotFound;
      WriteLog(Format(rsErrFindDosType,[DetTypeID]));
    end;
  end;

  Result:=typeDet;
end;

function TTLDDataModule.GetDosTypeFormulaID(DosType: String): integer;
var
  formulaId: integer;
  str      : string;
begin
  formulaId:=c_not_found;
  if IsDBConnected then
  begin
    try
      ADOQuery.Active:=False;
      ADOQuery.SQL.Clear;

      str:='SELECT '+cFieldFormulaId_Dos+' FROM '+cDBTableDosType+' WHERE '+cFieldDosType+' = '+#39+DosType+#39;

      ADOQuery.SQL.Add('SELECT '+cFieldFormulaId_Dos+' FROM '+cDBTableDosType+' WHERE '+cFieldDosType+' = '+#39+DosType+#39);
      ADOQuery.Active:=True;

      //if ADOQuery.FieldValues[cFieldFormulaId_Dos] <> null then
      if ADOQuery.RecordCount>0 then
      begin
        if not TryStrToInt(ADOQuery.FieldValues[cFieldFormulaId_Dos],formulaId) then formulaId := c_not_found;
      end
      else
        formulaId := c_not_found;

      ADOQuery.Close;

    except
      on E: exception do
      begin
        formulaId:=c_not_found;
        WriteLog(Format('%s - %s',[rsErrFindFormulaID,DosType]));
      end;
    end;
  end
  else
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));

  Result:=formulaId;
end;

function TTLDDataModule.GetDosTypeID(DosType: String): integer;
var
  typeDosID: integer;
begin
  typeDosID:=-1;

  if IsDBConnected then
  begin
    try
      ADOQuery.Active:=False;
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('SELECT '+cFieldDosTypeID+' FROM '+cDBTableDosType+' WHERE '+cFieldDosType+' = '+#39+DosType+#39);
      ADOQuery.Active:=True;

      if ADOQuery.FieldValues[cFieldDosTypeID] <> null then
      begin
        if not TryStrToInt(ADOQuery.FieldValues[cFieldDosTypeID],typeDosID) then typeDosID := -1;
      end
      else
        typeDosID := -1;

    except
      on E: exception do
      begin
        typeDosID:=-1;
        WriteLog(Format('%s - %s',[rsErrFindIDDosType,DosType]));
      end;
    end;
  end
  else
    WriteLog(Format('%s - %s',[rsErrDBConnection,DBName]));

  Result:=typeDosID;
end;

function TTLDDataModule.LoadSQL(DBVersion: integer): boolean;
const
  cDatabase = 'DataBase';
var
  f           : TextFile;
  s           : String;
  SQLString   : String;
  fullPath    : String;
begin

  fullPath:=extractfilepath(Application.ExeName)+cDatabase+PathDelim+cSQLScriptName+IntToStr(DBVersion)+cExtSQL;

  if FileExists(fullPath) then
  begin
    AssignFile(f, fullPath);
    Reset(f);
    while not eof(f) do
    begin
      readln(f,s);
      SQLString:=SQLString+cCRLF+s;
    end;

    CloseFile(f);

    if IsDBConnected then
    begin
      try
        ADOQuery.Active:=False;
        ADOQuery.SQL.Clear;
        ADOQuery.SQL.Add(SQLString+'COMMIT;');
        ADOQuery.ExecSQL;
        WriteLog(Format('%s %s %s',[rsDBbyFileRefresh,fullPath,SQLString]));
      except
        on E: exception do
        begin
          Result:=false;
          WriteLog(Format('%s %s %s %s',[rsErrDBbyFileRefresh,fullPath,SQLString,E.Message]));
          exit;
        end;
      end;

      Result:=true;
    end
    else
    begin
      Result:=false;
      WriteLog(Format('%s - %s',[rsErrDBRefresh,rsDBNoConnection]));
    end;
  end
  else
  begin
    Result:=false;
    WriteLog(Format('%s - %s %s',[rsErrDBRefresh,rsRefreshFileNotFound,fullPath]));
  end;

end;

function TTLDDataModule.GetNotDefaultDBConnection: boolean;
begin
  result:=false;
  if (ODBCConnection.Connected) then
    if (DBName <> cPostgreDefaultDB) then
      result:=true;

  OnDBConnection(result);
end;

function TTLDDataModule.GetPrevMeasDate(Date: TDate): TDate;
var
  ReadDate : TDateTime;
begin
  if MainForm.ADOQueryMeasList.Active then MainForm.ADOQueryMeasList.Close;
  MainForm.ADOQueryMeasList.Close;
  MainForm.ADOQueryMeasList.SQL.Clear;

  MainForm.ADOQueryMeasList.SQL.Add('SELECT '+cFieldMeasureTime+' FROM '+cDBTableDosRes                        // это преобразование зависимо от региональных настроек!  --> проверить устойчивость или переделать
                                                                        +' WHERE '+cFieldMeasureTime+' < '+#39+DateTimeToStr(Date)+#39+' AND '+cFieldToDel+'<>'+BoolToStrRegion(True)+' AND '+cFieldTldID+'='+IntToStr(MainForm.DeviceID)
                                                                        +' ORDER BY '+cFieldMeasureTime+' DESC LIMIT 1');
  MainForm.ADOQueryMeasList.Open;
//  MainForm.ADOQueryMeasList.First;
  ReadDate:=MainForm.ADOQueryMeasList.FieldByName(cFieldMeasureTime).AsDateTime;
  MainForm.ADOQueryMeasList.Clear;
  MainForm.ADOQueryMeasList.Close;
  result:=ReadDate;
end;

function TTLDDataModule.GetNextMeasDate(Date: TDate): TDate;
var
  ReadDate: TDateTime;
begin
  if MainForm.ADOQueryMeasList.Active then MainForm.ADOQueryMeasList.Close;
  MainForm.ADOQueryMeasList.SQL.Clear;
  MainForm.ADOQueryMeasList.SQL.Add('SELECT '+cFieldMeasureTime+' FROM '+cDBTableDosRes
                                                                        +' WHERE '+cFieldMeasureTime+' > '+#39+DateTimeToStr(Date)+' '+'23:59:59'+#39+' AND '+cFieldToDel+'<>'+BoolToStrRegion(True)+' AND '+cFieldTldID+'='+IntToStr(MainForm.DeviceID)
                                                                        +' ORDER BY '+cFieldMeasureTime+' LIMIT 1');
  MainForm.ADOQueryMeasList.Open;
  ReadDate:=MainForm.ADOQueryMeasList.FieldByName(cFieldMeasureTime).AsDateTime;

  if ReadDate <> StrToDate(cZeroDate) then
  begin
    result:=ReadDate
  end
  else
  begin
    if DateToStrRegion(Date) = DateToStrRegion(Now) then
      result:=StrToDate(cZeroDate)
    else
      result:=TDate(Now);
  end;

  MainForm.ADOQueryMeasList.Close;

end;

function TTLDDataModule.GetSQLQueryCreateTLDDosimeterID(TableName: String): String;
begin
  Result:='CREATE TABLE '+TableName+' ('
                            +'dosimeterid       integer  NOT NULL,'
                            +'postfix           text     NOT NULL,'
                            +'dosimetertypeid   smallint,'
                            +'dosimetertype     text,'
                            +'status            smallint DEFAULT 1,'
                            +'kh10              real DEFAULT 0,'
                            +'kh10g             real DEFAULT 0,'
                            +'kh10n             real DEFAULT 0,'
                            +'khgn              real DEFAULT 0,'
                            +'kh3               real DEFAULT 0,'
                            +'kh007             real DEFAULT 0,'
                            +'tldid             smallint DEFAULT 0,'
                            +'partid            integer DEFAULT 0,'
                            +'regtime           timestamp,'
                            +'vertime           timestamp DEFAULT '+#39+'1899-12-30 00:00:00'+#39+','
                            +'organization      text DEFAULT '+#39+''+#39+','
                            +'department        text DEFAULT '+#39+''+#39+','
                            +'doscomment        text DEFAULT '+#39+''+#39+','
                            +'PRIMARY KEY (dosimeterid,postfix)'
                            +') AS SELECT * FROM tlddosimeterid;'
  +'ALTER TABLE tlddosimeterid ADD FOREIGN KEY (dosimetertypeid) REFERENCES tlddosimetertype (dosimetertypeid) ON DELETE CASCADE;'
  +'COMMIT;';
end;

function TTLDDataModule.GetSQLSingleCol(DeviceID: integer): String;
begin
  if DeviceID<>cEmulatorID then
  begin
    Result:='SELECT CASE '+cFieldDosPostfix+' '
                          +'WHEN '+#39'-'+#39+' THEN CAST('+cFieldDosID+' AS TEXT) ELSE CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' END AS '+cFullDosID+' '
                          +'FROM '+cDBTableDosID+' '
                          +'WHERE ('+cFieldDosStatus+'<>'+IntToStr(cDosDecommissioned)+')'+' '
                          +'AND ('+cFieldTldID+'='+IntToStr(DeviceID)+')'+' '
                          +'OR ('+cFieldDosID+'='+'1'+')'+' '
                          +'ORDER BY '+cFieldDosID;
  end
  else
  begin
    Result:='SELECT CASE '+cFieldDosPostfix+' '
                          +'WHEN '+#39'-'+#39+' THEN CAST('+cFieldDosID+' AS TEXT) ELSE CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' END AS '+cFullDosID+' '
                          +'FROM '+cDBTableDosID+' '
                          +'WHERE ('+cFieldDosStatus+'<>'+IntToStr(cDosDecommissioned)+')'+' '
                          +'ORDER BY '+cFieldDosID;
  end;
end;

function TTLDDataModule.GetSQLManyCol: String;
begin
  Result:='SELECT CASE '+cFieldDosPostfix+' '
                        +'WHEN '+#39'-'+#39+' THEN CAST('+cFieldDosID+' AS TEXT) ELSE CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' END AS '+cFullDosID+','
                        +cFieldDosType+','
                        +cFieldRegTime+','
                        +'CASE '+cFieldDosStatus+' WHEN '+IntToStr(cDosCalibrated)+' THEN '+#39+rsDosCalibrated+#39+' WHEN '+IntToStr(cDosNotCalibrated)+' THEN '+#39+rsDosNotCalibrated+#39+' ELSE '+#39+rsDosDecommissioned+#39+' END AS '+cFieldStringState+','
                        +cFieldDosStatus+','
                        +cFieldOrg+','
                        +cFieldDepartment+','
                        +cFieldPartID+' '
                        +'FROM '+cDBTableDosID+' '
                        +'WHERE ('+cFieldDosStatus+'<>'+IntToStr(cDosDecommissioned)+')'+' '
                        +'AND ('+cFieldTldID+'='+IntToStr(MainForm.DeviceID)+')'+' '
                        +'ORDER BY '+cFieldDosID;
end;

procedure TTLDDataModule.ReadConfigIni;
var
  ConfigIni: TInifile;
begin
  ConfigIni := TInifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    ODBCDriver:=ConfigIni.ReadString(cSectionDBSettings, cODBCDriver, 'Driver={PostgreSQL ANSI}');
//    PGPass:=ConfigIni.ReadString(cSectionDBSettings, cPGPass, '2236');
    PGPass:=ConfigIni.ReadString(cSectionDBSettings, cPGPass, 'doza8485');
    PGPort:=ConfigIni.ReadString(cSectionDBSettings, cPGPort, '5432');
    PGUid:=ConfigIni.ReadString(cSectionDBSettings, cPGUid, 'postgres');
    ServerIP:=ConfigIni.ReadString(cSectionDBSettings, cServerIP, 'localhost');
    DBName:=ConfigIni.ReadString(cSectionDBSettings, cPGDBName, cDefaultDB);
    PGRestorePath:=ConfigIni.ReadString(cSectionDBSettings, cPGRestorePath, '');
    PGDumpPath:=ConfigIni.ReadString(cSectionDBSettings, cPGDumpPath, '');

    ASIDK_Use:=ConfigIni.ReadBool(cSectionDB_ASIDK_Settings,cASIDK_Use,False);
    ASIDK_ODBCDriver:=ConfigIni.ReadString(cSectionDB_ASIDK_Settings,cASIDK_ODBCDriver,'');
    ASIDK_PGPass:=ConfigIni.ReadString(cSectionDB_ASIDK_Settings,cASIDK_PGPass,'');
    ASIDK_PGPort:=ConfigIni.ReadString(cSectionDB_ASIDK_Settings,cASIDK_PGPort,'');
    ASIDK_PGUid:=ConfigIni.ReadString(cSectionDB_ASIDK_Settings,cASIDK_PGUid,'');
    ASIDK_ServerIP:=ConfigIni.ReadString(cSectionDB_ASIDK_Settings,cASIDK_ServerIP,'');
    ASIDK_DBName:=ConfigIni.ReadString(cSectionDB_ASIDK_Settings,cASIDK_DBName,'');
  finally
    ConfigIni.Free;
  end;
end;

procedure TTLDDataModule.SendMeasToCalibr(MeasID: String; CalibrDose: double; RadiationType: String);
begin
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('UPDATE '+cDBTableDosRes+' SET ('
                                               +cFieldMeasState+','
                                               +cFieldCalibrationValue+','
                                               +cFieldRadiationType+')'
                                           +'=('
                                           +#39+IntToStr(cMeasStCalibr)+#39+','
                                               +FloatToStrRegion(CalibrDose)+','
                                           +#39+RadiationType+#39+')'
                                           +'WHERE '+cFieldDosMeasID+'='+MeasID
                                           );
  ADOQuery.ExecSQL;
end;

procedure TTLDDataModule.ChangeMeasState(MeasID: String; State: integer);
begin
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('UPDATE '+cDBTableDosRes+' SET '+cFieldMeasState+' = '+#39+IntToStr(State)+#39+' '
                                           +'WHERE '+cFieldDosMeasID+'='+MeasID
                                           );
  ADOQuery.ExecSQL;
end;

procedure TTLDDataModule.SetDBName(Value: String);
begin
  FDBName:=Value;
end;

procedure TTLDDataModule.SetDosCntInPart(PartID, Cnt: integer);
begin
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('UPDATE '+cDBTableDosPart+' SET '+cFieldDosPartCnt+'='+IntToStr(Cnt)+' '
                                             +'WHERE '+cFieldPartID+'='+IntToStr(PartID));
  ADOQuery.ExecSQL;
end;

procedure TTLDDataModule.SetODBCDriver(Value: String);
begin
  FODBCDriver:=Value;
end;

procedure TTLDDataModule.SetOnDBConnection(Sender: TOnDBConnection);
begin
  FOnDBConnection:=Sender;
end;

procedure TTLDDataModule.SetOn_ASIDK_DBConnection(Sender: TOn_ASIDK_DBConnection);
begin
  FOn_ASIDK_DBConnection:=Sender;
end;

procedure TTLDDataModule.SetPGPass(Value: String);
begin
  FPGPass:=Value;
end;

procedure TTLDDataModule.SetPGPort(Value: String);
begin
  FPGPort:=Value;
end;

procedure TTLDDataModule.SetPGUid(Value: String);
begin
  FPGUid:=Value;
end;

procedure TTLDDataModule.SetServerIP(Value: String);
begin
  FServerIP:=Value
end;

procedure TTLDDataModule.Set_ASIDK_DBName(Value: String);
begin
  F_ASIDK_DBName:=Value;
end;

procedure TTLDDataModule.Set_ASIDK_ODBCDriver(Value: String);
begin
  F_ASIDK_ODBCDriver:=Value;
end;

procedure TTLDDataModule.Set_ASIDK_PGPass(Value: String);
begin
  F_ASIDK_PGPass:=Value;
end;

procedure TTLDDataModule.Set_ASIDK_PGPort(Value: String);
begin
  F_ASIDK_PGPort:=Value;
end;

procedure TTLDDataModule.Set_ASIDK_PGUid(Value: String);
begin
  F_ASIDK_PGUid:=Value;
end;

procedure TTLDDataModule.Set_ASIDK_ServerIP(Value: String);
begin
  F_ASIDK_ServerIP:=Value;
end;

procedure TTLDDataModule.ReadTLDSettings(ID: integer; var aKSLevel: integer;
                                         var aKSDelta: integer;
                                         var aKFilter: double;
                                         var aKDevice: double);
begin
  if IsDBConnected then
  begin
    if ADOQuery.Active then ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add(Format('SELECT %s, %s, %s, %s FROM %s WHERE %s = %s',[cFieldKSLevel, cFieldKSDelta, cFieldKFilter,cFieldKDevice,cDBTableSettings,cFieldTldID,IntToStr(ID)]));
    ADOQuery.Open;

    aKSLevel:=ADOQuery.FieldByName(cFieldKSLevel).AsInteger;
    aKSDelta:=ADOQuery.FieldByName(cFieldKSDelta).AsInteger;
    aKFilter:=RoundToCN(ADOQuery.FieldByName(cFieldKFilter).AsFloat,-2);
    aKDevice:=ADOQuery.FieldByName(cFieldKDevice).AsFloat;

    ADOQuery.Close;
  end;
end;

procedure TTLDDataModule.Reconnect(aDBName: String);
begin

  // если подключение к БД уже есть отключаемся
  if ODBCConnection.Connected then
    ODBCConnection.Connected:=false;

  // закрываем соединение уничтожая ODBCConnection
  ODBCConnection.Close;
  ODBCConnection.Destroy;

  // создаем заново ODBCConnection
  ODBCConnection:=TPQConnection.Create(self);

//  подключаемся к базе данных
//  ODBCConnection.ConnectionString:=ODBCDriver+';'+
//                                  cPostgreServer+'='+ServerIP+';'+
//                                  cPostgrePort+'='+PGPort+';'+
//                                  cPostgreDB+'='+aDBName+';'+
//                                  cPostgreUid+'='+PGUid+';'+
//                                  cPostgrePWD+'='+PGPass+';';
//
  ODBCConnection.LoginPrompt:=false;     //  не будем лишний раз запрашивать учётные данные
//  ODBCConnection.ConnectorType := 'PostgreSQL';
  ODBCConnection.DatabaseName:=aDBName;
  ODBCConnection.HostName:=ServerIP;
  ODBCConnection.Password:=PGPass;
  ODBCConnection.Transaction := dbSQLTransaction;
  ODBCConnection.UserName:=PGUid;

  // восстанавливаем Connection для ADOQuery
  ADOQuery.DataBase:=ODBCConnection;
  ADOQueryExportDet.DataBase:=ODBCConnection;
  OpenDB.ADOQuery.DataBase:=ODBCConnection;
  DosimeterTypeConstructorForm.ADOQueryDosType.DataBase:=ODBCConnection;
  DetectorConstructorForm.ADOQueryDetType.DataBase:=ODBCConnection;
  DetectorConstructorForm.ADOQueryTempProfile.DataBase:=ODBCConnection;
  DosimeterPartForm.ADOQueryDosPart.DataBase:=ODBCConnection;
  RW.ADOQueryReport.DataBase:=ODBCConnection;
  StartMeasureW.ADOQueryStartMW.DataBase:=ODBCConnection;
  QueueForm.ADOQueryQueue.DataBase:=ODBCConnection;

  MainForm.ADOQueryMeasList.DataBase:=ODBCConnection;
  MainForm.ADOQueryDosList.DataBase:=ODBCConnection;
  MainForm.ADOQueryProcessList.DataBase:=ODBCConnection;
  MainForm.ADOQueryDBList.DataBase:=ODBCConnection;
  MainForm.ADOQueryCalibrList.DataBase:=ODBCConnection;

{
  ADOQuery.Connection:=ODBCConnection;
  ADOQueryExportDet.Connection:=ODBCConnection;
  OpenDB.ADOQuery.Connection:=ODBCConnection;
  DosimeterTypeConstructorForm.ADOQueryDosType.Connection:=ODBCConnection;
  DetectorConstructorForm.ADOQueryDetType.Connection:=ODBCConnection;
  DosimeterPartForm.ADOQueryDosPart.Connection:=ODBCConnection;
  RW.ADOQueryReport.Connection:=ODBCConnection;
  StartMeasureW.ADOQueryStartMW.Connection:=ODBCConnection;
  QueueForm.ADOQueryQueue.Connection:=ODBCConnection;

  MainForm.ADOQueryMeasList.Connection:=ODBCConnection;
  MainForm.ADOQueryDosList.Connection:=ODBCConnection;
  MainForm.ADOQueryProcessList.Connection:=ODBCConnection;
  MainForm.ADOQueryDBList.Connection:=ODBCConnection;
  MainForm.ADOQueryCalibrList.Connection:=ODBCConnection;
  }
  try
    ODBCConnection.Connected:=true;      //  соединяемся с сервером
  except
    on E: exception do
    begin
      raise EDBConnectionErr.Create(Format('%s. %s - %s',[E.Message,rsDBConnectionFault,aDBName]));
    end;
  end;

  if IsConnected then DBName:=aDBName;

end;

function TTLDDataModule.CopyDB(aCurrentDBName: String; aCopyDBName: String): boolean;
begin
  try
    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('COMMIT');
    ADOQuery.ExecSQL;

    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add(Format('CREATE DATABASE %s WITH TEMPLATE %s;',[aCopyDBName,aCurrentDBName]));
    ADOQuery.ExecSQL;

    if IsDBExist(aCopyDBName) then
    begin
      WriteLog(Format(rsDBCopyDone,[aCurrentDBName,aCopyDBName]));
      Result:=true;
    end
    else
    begin
      WriteLog(Format(rsErrDBCopy,[aCurrentDBName,aCopyDBName]));
      Result:=false;
    end;

   except
    on E: exception do
    begin
      WriteLog(Format(rsErrDBCopy,[aCurrentDBName,aCopyDBName]));
      Result:=false;
    end;
  end;
end;

function TTLDDataModule.RenameDB(OldName: String; NewName: String): boolean;
begin
  try
    Reconnect(cPostgreDefaultDB);

    ADOQuery.Active:=False;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add(Format('ALTER DATABASE "%s" RENAME TO "%s"; COMMIT;',[OldName,NewName]));
    ADOQuery.ExecSQL;

    //ADOQuery.Transaction.;

    if IsDBExist(NewName) then
      Result:=true
    else
      Result:=false;

    ADOQuery.Close;
    WriteLog(Format(rsDBRenameDone,[OldName,NewName]));
  except
    on E: exception do
    begin
      WriteLog(Format(rsDBRenameDone,[OldName,NewName]));
      Result:=false;
    end;

  end;
end;

function TTLDDataModule.RestoreDB(aBackupDBName: String; CreateBackup: boolean): boolean;
var
  backupDBName      : String;
  currentDBComment  : String;
  restoreDBComment  : String;
begin
  if CreateBackup then
  begin
    backupDBName:=GetBackupDBName;

    currentDBComment:=TLDDatamodule.GetDataBaseComment(cDefaultDB);
    restoreDBComment:=TLDDatamodule.GetDataBaseComment(aBackupDBName);

    if backupDBName<>'' then
    begin
      if RenameDB(cDefaultDB,backupDBName) then
      begin
        if CopyDB(aBackupDBName,cDefaultDB) then
        begin
          if currentDBComment<>'' then
            TLDDataModule.UpdateDBComment(backupDBName,currentDBComment)
          else
            TLDDataModule.UpdateDBComment(backupDBName,DateTimeToStr(Now)+' backup');

          TLDDataModule.UpdateDBComment(cDefaultDB,restoreDBComment);

          ConnectToDB(cDefaultDB);
          Result:=true;
        end
        else
          Result:=false;
      end
      else
        Result:=false;
    end
    else
      Result:=false;
  end
  else
  begin
    Reconnect(cPostgreDefaultDB);
    DeleteDataBase(cDefaultDB);
    if CopyDB(aBackupDBName,cDefaultDB) then
    begin
      ConnectToDB(cDefaultDB);
      Result:=true;
    end
    else
      Result:=false;
  end;
end;

function TTLDDataModule.CreateBackupDB(aBackupDBName: String): String;
var
  dbComment: String;
begin
  if aBackupDBName<>'' then
  begin
    dbComment:=GetDataBaseComment(cDefaultDB);
    if RenameDB(cDefaultDB,aBackupDBName) then
    begin
      if CopyDB(aBackupDBName,cDefaultDB) then
      begin
        UpdateDBComment(aBackupDBName,dbComment+' before import');
        UpdateDBComment(cDefaultDB,dbComment);
        ConnectToDB(cDefaultDB);
        Result:=aBackupDBName;
      end
      else
        Result:='';
    end
    else
      Result:='';
  end
  else
    Result:='';
end;

function TTLDDataModule.GetDBGridStringNumber(DBGridEh: TDBGridEh; aName: String): integer;
var
  i: integer;
  Flag: boolean;
begin
  Flag:=False;
  DBGridEh.DataSource.DataSet.First;
  for i := 0 to DBGridEh.DataSource.DataSet.RecordCount-1 do
  begin
    if DBGridEh.DataSource.DataSet.FieldByName('datname').AsString = aName then
    begin
      Flag:=true;
      break;
    end;
    DBGridEh.DataSource.DataSet.Next;
  end;

  if Flag then
    result:=i+1
  else
    result:=-1;
end;

procedure TTLDDataModule.WriteDeviceID(ID: integer);
const
  cCount = 'count';
var
  idCnt: integer;
begin
  if IsDBConnected then
  begin
    // проверяем наличие ID установки в БД
    if ADOQuery.Active then ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add(Format('select %s (*) from %s where %s = %s',[cCount,cDBTableSettings,cFieldTldID,IntToStr(ID)]));
    ADOQuery.Open;
    idCnt:=ADOQuery.FieldByName(cCount).AsInteger;

    // добавляем индекс установки
    if (idCnt = 0) then
    begin
      if ADOQuery.Active then ADOQuery.Close;
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add(Format('INSERT INTO %s (%s) VALUES (%s)',[cDBTableSettings,cFieldTldID,IntToStr(ID)]));
      ADOQuery.ExecSQL;
    end;

    if ADOQuery.Active then ADOQuery.Close;
  end;
end;

procedure TTLDDataModule.WriteDeviceID(ID: integer; KSLevel: integer; KSDelta: integer; KFilter: double);
begin
  if IsDBConnected then
  begin
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add(Format('UPDATE %s SET (%s,%s,%s) = (%s,%s,%s) WHERE %s = %s',[cDBTableSettings,
                                                                                      cFieldKSLevel,
                                                                                      cFieldKSDelta,
                                                                                      cFieldKFilter,
                                                                                  IntToStr(KSLevel),
                                                                                  IntToStr(KSDelta),
                                                                          FloatToStrRegion(KFilter),
                                                                                        cFieldTldID,
                                                                                        IntToStr(ID)]));
    ADOQuery.ExecSQL;
  end;
end;

end.


