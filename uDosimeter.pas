unit uDosimeter;

interface

uses
  SysUtils,
  Variants,
  Forms,
  Math,
  Classes,
  uDetector,
  Dialogs,
  SQLDB,
  uDataModule,
  uConst,
  uSeparator,
  uLanguages;

// Data.Win.ADODB,

type

  TCoefficient  = record
    Name                  : String;
    Value                 : double;
  end;

  TDose  = record
    Name                  : String;
    Value                 : double;
  end;

  TDosimeterValidity = (stDosNotMeasured,
                        stDosWaitLoad,
                        stDosWaitMeasD1,
                        stDosWaitMeasD2,
                        stDosWaitMeasD3,
                        stDosWaitMeasD4,
                        stDosMeasInProgressD1,
                        stDosMeasInProgressD2,
                        stDosMeasInProgressD3,
                        stDosMeasInProgressD4,
                        stDosMeasFinishedD1,
                        stDosMeasFinishedD2,
                        stDosMeasFinishedD3,
                        stDosMeasFinishedD4,
                        stDosMeasErrorD1,
                        stDosMeasErrorD2,
                        stDosMeasErrorD3,
                        stDosMeasErrorD4,
                        stDosMeasStoppedD1,
                        stDosMeasStoppedD2,
                        stDosMeasStoppedD3,
                        stDosMeasStoppedD4,
                        stDosMeasWarning,
                        stDosMeasError,
                        stDosMeasFinished,
                        stDosMeasAccepted,
                        stDosMeasUserWarning);

  TDosimeterStatus =  (stDosCalibrated,
                       stDosNotCalibrated,
                       stDosDecommissioned);

  TOnChangeFullNumber = procedure(Sender: TObject) of object;
  TOnChangePostfix = procedure(Sender: TObject) of object;
  TOnChangeNumber = procedure(Sender: TObject) of object;
  TOnChangeDose = procedure(Sender: TObject) of object;
  TOnChangeDoseType = procedure(Sender: TObject) of object;
  TOnChangeMeasValues = procedure(Sender: TObject) of object;
  TOnChangeErr = procedure(Sender: TObject) of object;
  TOnChangeMeasTime = procedure(Sender: TObject) of object;
  TOnChangeVerTime = procedure(Sender: TObject) of object;
  TOnChangeRegTime = procedure(Sender: TObject) of object;
  TOnChangeStatus = procedure(Sender: TObject) of object;
  TOnChangeValidity = procedure(Sender: TObject) of object;
  TOnChangeKS = procedure(Sender: TObject) of object;
  TOnChangeK = procedure(Sender: TObject) of object;
  TOnChangeKFilter = procedure(Sender: TObject) of object;
  TOnChangeKDevice = procedure(Sender: TObject) of object;
  TOnChangeFormulaID = procedure(Sender: TObject) of object;
  TOnChangeFormula = procedure(Sender: TObject) of object;
  TOnChangePersNumber = procedure(Sender: TObject) of object;
  TOnChangeOrganization = procedure(Sender: TObject) of object;
  TOnChangeDosPart = procedure(Sender: TObject) of object;
  TOnChangeDepartment = procedure(Sender: TObject) of object;
  TOnChangeFIO = procedure(Sender: TObject) of object;
  TOnChangeMeasComment = procedure(Sender: TObject) of object;
  TOnShowTempProfileWrite = procedure(Sender: TObject) of object;
  TOnChangeLastMeasComment = procedure(Sender: TObject) of object;
  TOnChangeLastMeasResult = procedure(Sender: TObject) of object;
  TOnChangeLastMeasTime = procedure(Sender: TObject) of object;

  Detectors = TDetector;

  TCoefficients = class(TComponent)
    public
      CoefficientArray  : array of TCoefficient;
      procedure Add(aName: String; Value: double);
      procedure Drop;
      function IsExistValue(Value: String): boolean;
  end;

  TDoses = class(TComponent)
    public
      DoseArray  : array of TDose;
      procedure Add(aName: String; Value: double);
      procedure Update(aName: String; Value: double);
      procedure Drop;
      function IsExistValue(Value: String): boolean;
      function GetStringValue: String;
  end;

  TDosimeter = class(TComponent)
    private
      FMeasurementID          : integer;
      FID                     : integer;
      FPostfix                : String;
      FFullNumber             : String;
      FDosTypeID              : String;
      FDosType                : String;
      FMeasValues             : String;               // Измеряемые величины

      FDose_Hp_10g            : double;
      FDose_Hp_10n            : double;
      FDose_Hp_3              : double;
      FDose_Hp_007            : double;
      FDose_H_star            : double;
      FDose_H_007             : double;
      FDose_D                 : double;
      FErr_Hp_10g             : double;
      FErr_Hp_10n             : double;
      FErr_Hp_3               : double;
      FErr_Hp_007             : double;
      FErr_H_star             : double;
      FErr_H_007              : double;
      FErr_D                  : double;
      FError                  : String;
      FFormula                : String;
      FFormulaID              : integer;
      FFormulaID_Val_1        : integer;
      FFormulaID_Val_2        : integer;
      FFormulaID_Val_3        : integer;
      FFormulaID_Val_4        : integer;
      FFormula_Val_ErrK1_1    : double;
      FFormula_Val_ErrK1_2    : double;
      FFormula_Val_ErrK1_3    : double;
      FFormula_Val_ErrK1_4    : double;
      FFormula_Val_ErrK2_1    : double;
      FFormula_Val_ErrK2_2    : double;
      FFormula_Val_ErrK2_3    : double;
      FFormula_Val_ErrK2_4    : double;
      FValidity               : TDosimeterValidity;
      FStatus                 : TDosimeterStatus;
      FKS                     : integer;
      FK1                     : double;
      FK2                     : double;
      FK3                     : double;
      FK4                     : double;
      FK5                     : double;
      FKgn                    : double;
      FEcc1                   : double;
      FEcc2                   : double;
      FEcc3                   : double;
      FEcc4                   : double;
      FK1Err                  : double;
      FK2Err                  : double;
      FK3Err                  : double;
      FK4Err                  : double;
      FK5Err                  : double;
      FKgnErr                 : double;
      FKFilter                : double;
      FKDevice                : double;
      FTldID                  : integer;
      FPartID                 : integer;
      FPartName               : String;
      FMeasTime               : TDateTime;
      FRegTime                : TDateTime;
      FVerTime                : TDateTime;
      FSoftwareVer            : integer;
      FTldUser                : String;
      FPersNumber             : integer;
      FFio                    : String;
      FOrganization           : String;
      FDepartment             : String;
      FMeasComment            : String;
      FLastMeasComment        : String;
      FLastMeasResult         : TDosimeterValidity;
      FLastMeasTime           : TDateTime;

      FMeasValList            : TStringList;
      FOnChangeNumber         : TOnChangeNumber;
      FOnChangePostfix        : TOnChangePostfix;
      FOnChangeFullNumber     : TOnChangeFullNumber;
      FOnChangeDose           : TOnChangeDose;
      FOnChangeDoseType       : TOnChangeDoseType;
      FOnChangeMeasValues     : TOnChangeMeasValues;
      FOnChangeErr            : TOnChangeErr;
      FOnChangeMeasTime       : TOnChangeMeasTime;
      FOnChangeVerTime        : TOnChangeVerTime;
      FOnChangeRegTime        : TOnChangeRegTime;
      FOnChangeStatus         : TOnChangeStatus;
      FOnChangeValidity       : TOnChangeValidity;
      FOnChangeKS             : TOnChangeKS;
      FOnChangeK              : TOnChangeK;
      FOnChangeKFilter        : TOnChangeKFilter;
      FOnChangeKDevice        : TOnChangeKDevice;
      FOnChangeFormulaID      : TOnChangeFormulaID;
      FOnChangeFormula        : TOnChangeFormula;
      FOnChangePersNumber     : TOnChangePersNumber;
      FOnChangeOrganization   : TOnChangeOrganization;
      FOnChangeDepartment     : TOnChangeDepartment;
      FOnChangeDosPart        : TOnChangeDosPart;
      FOnChangeMeasComment    : TOnChangeMeasComment;
      FOnChangeFIO            : TOnChangeFIO;
      FOnShowTempProfileWrite : TOnShowTempProfileWrite;
      FOnChangeLastMeasComment: TOnChangeLastMeasComment;
      FOnChangeLastMeasResult : TOnChangeLastMeasResult;
      FOnChangeLastMeasTime   : TOnChangeLastMeasTime;

      procedure SetNumber(const Value: integer);
      procedure SetPostfix(const Value: String);
      procedure SetFullNumber(const Value: String);
      procedure SetMeasID(aMeasID: integer);
      procedure SetDose_Hp_10g(Value: double);
      procedure SetDose_Hp_10n(Value: double);
      procedure SetDose_Hp_3(Value: double);
      procedure SetDose_Hp_007(Value: double);
      procedure SetDose_H_star(Value: double);
      procedure SetDose_H_007(Value: double);
      procedure SetDose_D(Value: double);
      procedure SetErr_D(const Value: double);
      procedure SetErr_H_007(const Value: double);
      procedure SetErr_H_star(const Value: double);
      procedure SetErr_Hp_007(const Value: double);
      procedure SetErr_Hp_10g(const Value: double);
      procedure SetErr_Hp_10n(const Value: double);
      procedure SetErr_Hp_3(const Value: double);
      procedure SetDosType(aDosType: String);
      procedure SetMeasValues(Value: String);
      procedure SetError(aError: String);
      procedure SetFormula(aFormula: String);
      procedure SetFormulaID(aFormulaID: integer);
      procedure SetFormulaID_Val_1(aFormulaID_Val_1: integer);
      procedure SetFormulaID_Val_2(aFormulaID_Val_2: integer);
      procedure SetFormulaID_Val_3(aFormulaID_Val_3: integer);
      procedure SetFormulaID_Val_4(aFormulaID_Val_4: integer);
      procedure SetFormula_Val_ErrK1_1(const Value: double);
      procedure SetFormula_Val_ErrK1_2(const Value: double);
      procedure SetFormula_Val_ErrK1_3(const Value: double);
      procedure SetFormula_Val_ErrK1_4(const Value: double);
      procedure SetFormula_Val_ErrK2_1(const Value: double);
      procedure SetFormula_Val_ErrK2_2(const Value: double);
      procedure SetFormula_Val_ErrK2_3(const Value: double);
      procedure SetFormula_Val_ErrK2_4(const Value: double);
      procedure SetValidity(aValidity: TDosimeterValidity);
      procedure SetStatus(aStatus: TDosimeterStatus);
      procedure SetK1(Value: double);
      procedure SetK2(Value: double);
      procedure SetK3(Value: double);
      procedure SetK4(Value: double);
      procedure SetK5(Value: double);
      procedure SetKgn(Value: double);
      procedure SetEcc1(Value: double);
      procedure SetEcc2(Value: double);
      procedure SetEcc3(Value: double);
      procedure SetEcc4(Value: double);
      procedure SetK1Err(Value: double);
      procedure SetK2Err(Value: double);
      procedure SetK3Err(Value: double);
      procedure SetK4Err(Value: double);
      procedure SetK5Err(Value: double);
      procedure SetKgnErr(Value: double);
      procedure SetKFilter(Value: double);
      procedure SetKDevice(Value: double);
      procedure SetKS(Value: integer);
      procedure SetMeasTime(aMeasTime: TDateTime);
      procedure SetVerTime(aVerTime: TDateTime);
      procedure SetRegTime(aRegTime: TDateTime);
      procedure SetSoftwareVer(aSoftwareVer: integer);
      procedure SetTldUser(aTldUser: String);
      procedure SetPersNumber(aPersNumber: integer);
      procedure SetFio(aFio: String);
      procedure SetOrganization(aOrganization: String);
      procedure SetDepartment(aDepartment: String);
      procedure SetDetTemProfile(aDetector: TDetector; aTempProfile: String);
      procedure SetDosPart(Value: integer);
      procedure SetDosPartName(const Value: String);
      procedure SetMeasComment(Value: String);
      procedure SetLastMeasComment(Value: String);
      procedure SetLastMeasResult(Value: TDosimeterValidity);
      procedure SetLastMeasTime(Value: TDateTime);

      procedure SetOnChangeNumber(Sender: TOnChangeNumber);
      procedure SetOnChangePostfix(Sender: TOnChangePostfix);
      procedure SetOnChangeFullNumber(Sender: TOnChangeFullNumber);
      procedure SetOnChangeDose(Sender: TOnChangeDose);
      procedure SetOnChangeErr(Sender: TOnChangeErr);
      procedure SetOnChangeDoseType(Sender: TOnChangeDoseType);
      procedure SetOnChangeMeasValues(Sender: TOnChangeMeasValues);
      procedure SetOnChangeMeasTime(Sender: TOnChangeMeasTime);
      procedure SetOnChangeVerTime(Sender: TOnChangeVerTime);
      procedure SetOnChangeRegTime(Sender: TOnChangeRegTime);
      procedure SetOnChangeStatus(Sender: TOnChangeStatus);
      procedure SetOnChangeValidity(Sender: TOnChangeValidity);
      procedure SetOnChangeKS(Sender: TOnChangeKS);
      procedure SetOnChangeK(Sender: TOnChangeK);
      procedure SetOnChangeKFilter(Sender: TOnChangeKFilter);
      procedure SetOnChangeKDevice(Sender: TOnChangeKDevice);
      procedure SetOnChangeFormulaID(Sender: TOnChangeFormulaID);
      procedure SetOnChangeFormula(Sender: TOnChangeFormula);
      procedure SetOnChangePersNumber(Sender: TOnChangePersNumber);
      procedure SetOnChangeOrganization(Sender: TOnChangeOrganization);
      procedure SetOnChangeDepartment(Sender: TOnChangeDepartment);
      procedure SetOnChangeDosPart(Sender: TOnChangeDosPart);
      procedure SetOnChangeFIO(Sender: TOnChangeFIO);
      procedure SetOnChangeMeasComment(Sender: TOnChangeMeasComment);
      procedure SetOnChangeLastMeasComment(Sender: TOnChangeLastMeasComment);
      procedure SetOnChangeLastMeasResult(Sender: TOnChangeLastMeasResult);
      procedure SetOnChangeLastMeasTime(Sender: TOnChangeLastMeasTime);

      procedure SetOnShowTempProfileWrite(Sender: TOnShowTempProfileWrite);

      function GetMeasValList: TStringList;
      function ReadCntDetector: TDetector;
      function GetDoseErr(Dose,Err_k1,Err_k2: double): double;
      function GetDoseErrPercent(Dose,Err_k1,Err_k2: double): double;
      function GetKErr(K,Percent: double): double;
    protected

    public
      DetectorsList      : TList;                       // список детекторов
      DetectorsCnt       : integer;                     // счетчик детекторов
      TablePos           : integer;                     // счетчик команд для отслеживания текущего состояния столика на этапе загрузки детекторов
      Coefficients       : TCoefficients;               // array of TCoefficient;
      Doses              : TDoses;                      // array of TDoses;

      Err_Hp_10g_Percent : double;
      Err_Hp_10n_Percent : double;
      Err_Hp_3_Percent   : double;
      Err_Hp_007_Percent : double;
      Err_H_star_Percent : double;
      Err_H_007_Percent  : double;
      Err_D_Percent      : double;

      constructor Create(aFullNumber: String); reintroduce; overload;
      constructor Create(aFullNumber: String; aMeasId: String); reintroduce; overload;

      destructor Destroy; override;

      property CntDetector            : TDetector read ReadCntDetector;

      property MeasurementID          : integer read FMeasurementID write SetMeasID;
      property ID                     : integer read FID write SetNumber;
      property Postfix                : String read FPostfix write SetPostfix;
      property FullNumber             : String read FFullNumber write SetFullNumber;
      property DosTypeID              : String read FDosTypeID;
      property DosType                : String read FDosType write SetDosType;
      property MeasValues             : String read FMeasValues write SetMeasValues;
      property Dose_Hp_10g            : double read FDose_Hp_10g write SetDose_Hp_10g;
      property Dose_Hp_10n            : double read FDose_Hp_10n write SetDose_Hp_10n;
      property Dose_Hp_3              : double read FDose_Hp_3 write SetDose_Hp_3;
      property Dose_Hp_007            : double read FDose_Hp_007 write SetDose_Hp_007;
      property Dose_H_star            : double read FDose_H_star write SetDose_H_star;
      property Dose_H_007             : double read FDose_H_007 write SetDose_H_007;
      property Dose_D                 : double read FDose_D write SetDose_D;
      property Err_Hp_10g             : double read FErr_Hp_10g write SetErr_Hp_10g;
      property Err_Hp_10n             : double read FErr_Hp_10n write SetErr_Hp_10n;
      property Err_Hp_3               : double read FErr_Hp_3 write SetErr_Hp_3;
      property Err_Hp_007             : double read FErr_Hp_007 write SetErr_Hp_007;
      property Err_H_star             : double read FErr_H_star write SetErr_H_star;
      property Err_H_007              : double read FErr_H_007 write SetErr_H_007;
      property Err_D                  : double read FErr_D write SetErr_D;
      property Formula                : String read FFormula write SetFormula;
      property FormulaID              : integer read FFormulaID write SetFormulaID;
      property FormulaID_Val_1        : integer read FFormulaID_Val_1 write SetFormulaID_Val_1;
      property FormulaID_Val_2        : integer read FFormulaID_Val_2 write SetFormulaID_Val_2;
      property FormulaID_Val_3        : integer read FFormulaID_Val_3 write SetFormulaID_Val_3;
      property FormulaID_Val_4        : integer read FFormulaID_Val_4 write SetFormulaID_Val_4;
      property Formula_Val_ErrK1_1    : double read FFormula_Val_ErrK1_1 write SetFormula_Val_ErrK1_1;
      property Formula_Val_ErrK2_1    : double read FFormula_Val_ErrK2_1 write SetFormula_Val_ErrK2_1;
      property Formula_Val_ErrK1_2    : double read FFormula_Val_ErrK1_2 write SetFormula_Val_ErrK1_2;
      property Formula_Val_ErrK2_2    : double read FFormula_Val_ErrK2_2 write SetFormula_Val_ErrK2_2;
      property Formula_Val_ErrK1_3    : double read FFormula_Val_ErrK1_3 write SetFormula_Val_ErrK1_3;
      property Formula_Val_ErrK2_3    : double read FFormula_Val_ErrK2_3 write SetFormula_Val_ErrK2_3;
      property Formula_Val_Errk1_4    : double read FFormula_Val_ErrK1_4 write SetFormula_Val_ErrK1_4;
      property Formula_Val_Errk2_4    : double read FFormula_Val_ErrK2_4 write SetFormula_Val_ErrK2_4;
      property Error                  : String read FError write SetError;
      property Validity               : TDosimeterValidity read FValidity write SetValidity;
      property Status                 : TDosimeterStatus read FStatus write SetStatus;
      property KS                     : integer read FKS write SetKS;
      property K1                     : double read FK1 write SetK1;
      property K2                     : double read FK2 write SetK2;
      property K3                     : double read FK3 write SetK3;
      property K4                     : double read FK4 write SetK4;
      property K5                     : double read FK5 write SetK5;
      property Kgn                    : double read FKgn write SetKgn;
      property Ecc1                   : double read FEcc1 write SetEcc1;
      property Ecc2                   : double read FEcc2 write SetEcc2;
      property Ecc3                   : double read FEcc3 write SetEcc3;
      property Ecc4                   : double read FEcc4 write SetEcc4;
      property K1Err                  : double read FK1Err write SetK1Err;
      property K2Err                  : double read FK2Err write SetK2Err;
      property K3Err                  : double read FK3Err write SetK3Err;
      property K4Err                  : double read FK4Err write SetK4Err;
      property K5Err                  : double read FK5Err write SetK5Err;
      property KgnErr                 : double read FKgnErr write SetKgnErr;
      property KFilter                : double read FKFilter write SetKFilter;
      property KDevice                : double read FKDevice write SetKDevice;
      property TldId                  : integer read FTldID;
      property PartID                 : integer read FPartID write SetDosPart;
      property PartName               : String read FPartName write SetDosPartName;
      property MeasTime               : TDateTime read FMeasTime write SetMeasTime;
      property RegTime                : TDateTime read FRegTime write SetRegTime;
      property VerTime                : TDateTime read FVerTime write SetVerTime;
      property SoftwareVer            : integer read FSoftwareVer write SetSoftwareVer;
      property TldUser                : String read FTldUser write SetTldUser;
      property PersNumber             : integer read FPersNumber write SetPersNumber;
      property Fio                    : String read FFio write SetFio;
      property Organization           : String read FOrganization write SetOrganization;
      property Department             : String read FDepartment write SetDepartment;
      property MeasComment            : String read FMeasComment write SetMeasComment;
      property MeasValList            : TStringList read GetMeasValList write FMeasValList;

      property LastMeasComment        : String read FLastMeasComment write SetLastMeasComment;
      property LastMeasResult         : TDosimeterValidity read FLastMeasResult write SetLastMeasResult;
      property LastMeasTime           : TDateTime read FLastMeasTime write SetLastMeasTime;

      property OnChangeNumber         : TOnChangeNumber read FOnChangeNumber write SetOnChangeNumber;
      property OnChangePostfix        : TOnChangePostfix read FOnChangePostfix write SetOnChangePostfix;
      property OnChangeFullNumber     : TOnChangeFullNumber read FOnChangeFullNumber write SetOnChangeFullNumber;
      property OnChangeDose           : TOnChangeDose read FOnChangeDose write SetOnChangeDose;
      property OnChangeDoseType       : TOnChangeDoseType read FOnChangeDoseType write SetOnChangeDoseType;
      property OnChangeMeasValues     : TOnChangeMeasValues read FOnChangeMeasValues write SetOnChangeMeasValues;
      property OnChangeErr            : TOnChangeErr read FOnChangeErr write SetOnChangeErr;
      property OnChangeMeasTime       : TOnChangeMeasTime read FOnChangeMeasTime write SetOnChangeMeasTime;
      property OnChangeVerTime        : TOnChangeVerTime read FOnChangeVerTime write SetOnChangeVerTime;
      property OnChangeRegTime        : TOnChangeRegTime read FOnChangeRegTime write SetOnChangeRegTime;
      property OnChangeStatus         : TOnChangeStatus read FOnChangeStatus write SetOnChangeStatus;
      property OnChangeValidity       : TOnChangeValidity read FOnChangeValidity write SetOnChangeValidity;
      property OnChangeKS             : TOnChangeKS read FOnChangeKS write SetOnChangeKS;
      property OnChangeK              : TOnChangeK read FOnChangeK write SetOnChangeK;
      property OnChangeKFilter        : TOnChangeKFilter read FOnChangeKFilter write SetOnChangeKFilter;
      property OnChangeKDevice        : TOnChangeKDevice read FOnChangeKDevice write SetOnChangeKDevice;
      property OnChangeFormulaID      : TOnChangeFormulaID read FOnChangeFormulaID write SetOnChangeFormulaID;
      property OnChangeFormula        : TOnChangeFormula read FOnChangeFormula write SetOnChangeFormula;
      property OnChangePersNumber     : TOnChangePersNumber read FOnChangePersNumber write SetOnChangePersNumber;
      property OnChangeOrganization   : TOnChangeOrganization read FOnChangeOrganization write SetOnChangeOrganization;
      property OnChangeDepartment     : TOnChangeDepartment read FOnChangeDepartment write SetOnChangeDepartment;
      property OnChangeDosPart        : TOnChangeDosPart read FOnChangeDosPart write SetOnChangeDosPart;
      property OnChangeFIO            : TOnChangeFIO read FOnChangeFIO write SetOnChangeFIO;
      property OnChangeMeasComment    : TOnChangeMeasComment read FOnChangeMeasComment write SetOnChangeMeasComment;

      property OnChangeLastMeasComment: TOnChangeLastMeasComment read FOnChangeLastMeasComment write SetOnChangeLastMeasComment;
      property OnChangeLastMeasResult : TOnChangeLastMeasResult read FOnChangeLastMeasResult write SetOnChangeLastMeasResult;
      property OnChangeLastMeasTime   : TOnChangeLastMeasTime read FOnChangeLastMeasTime write SetOnChangeLastMeasTime;

      property OnShowTempProfileWrite : TOnShowTempProfileWrite read FOnShowTempProfileWrite write SetOnShowTempProfileWrite;

      function OldCalcDose                                      : double;
      function CalcErr                                          : double;
      function CalcKDos(CalcDose: double; SourceDose: double)   : double;
      function GetDosimeterValidity                             : TDosimeterValidity;
      function GetStringStatus                                  : String;
      function GetIntValidity                                   : integer;
      function CalcDose_Hp_10g(Mask: byte)                      : double;
      function CalcDose_Hp_10n(Mask: byte)                      : double;
      function CalcDose_Hp_007(Mask: byte)                      : double;
      function CalcDose_Hp_3(Mask: byte)                        : double;
      function CalcDose_H_star(Mask: byte)                      : double;
      function CalcDose_H_007(Mask: byte)                       : double;
      function CalcDose_D(Mask: byte)                           : double;
      function CheckNan(ADOQuery: TSQLQuery; Field: String)     : double;
      procedure ReadKFromMeas;
      procedure ReadKFromDosimeter;
      procedure ProcessDetDose(Mask: byte; detPos: byte; var out_dose: double; var out_detCnt: byte);
      procedure SetDetsState(State : TDetectorState);
      procedure SkipDetecrorInFormula(det: String);
      procedure CalcDose;
      procedure CalcDetectorDose(DetPos: integer);
      procedure RecalcAllDetectorsDose;
      procedure UpdateNumber(Value: String);
      procedure UpdatePostfix(Value: String);
      procedure UpdateVerDate(Value: TDate);
      procedure UpdateK(Value: String);
      procedure UpdatePart(Value: String);
      procedure UpdateOrganization(Value: String);
      procedure UpdateDepartment(Value: String);
      procedure UpdateComment(Value: String);
  end;

implementation
uses
  uFunctions,
  uMainForm;

{ TDosimeter }

//const
//  cBit_0 = 0;
//  cBit_1 = 1;
//  cBit_2 = 2;
//  cBit_3 = 3;

function TDosimeter.CheckNan(ADOQuery: TSQLQuery; Field: String): double;
begin
  if ADOQuery.FieldByName(Field).AsVariant <> Null then
    Result:=ADOQuery.FieldByName(Field).AsFloat
  else
    Result:=NAN;
end;

constructor TDosimeter.Create(aFullNumber: String);
var
  Detector1,
  Detector2,
  Detector3,
  Detector4       : Detectors;
  idD1,
  idD2,
  idD3,
  idD4            : integer;  // id детектора
begin
  inherited Create(nil);

  FDose_Hp_10g:=NAN;
  FDose_Hp_10n:=NAN;
  FDose_Hp_3:=NAN;
  FDose_Hp_007:=NAN;
  FDose_H_star:=NAN;
  FDose_H_007:=NAN;
  FDose_D:=NAN;

  FErr_Hp_10g:=NAN;
  FErr_Hp_10n:=NAN;
  FErr_Hp_3:=NAN;
  FErr_Hp_007:=NAN;
  FErr_H_star:=NAN;
  FErr_H_007:=NAN;
  FErr_D:=NAN;

  FK1:=NAN;
  FK2:=NAN;
  FK3:=NAN;
  FK4:=NAN;
  FK5:=NAN;
  FKgn:=NAN;

//  FKDevice:=1;

  FKDevice:=MainForm.KDevice;

  Self.OnChangeNumber:=@MainForm.OnChangeDosimeterNumber;
  Self.OnChangePostfix:=@MainForm.OnChangeDosimeterPostfix;
  Self.OnChangeFullNumber:=@MainForm.OnChangeDosimeterFullNumber;
  Self.OnChangeDose:=@MainForm.OnChangeDosimeterDose;
  Self.OnChangeDoseType:=@MainForm.OnChangeDosimeterDoseType;
  Self.OnChangeMeasValues:=@MainForm.OnChangeDosimeterMeasValues;
  Self.OnChangeErr:=@MainForm.OnChangeDosimeterErr;
  Self.OnChangeMeasTime:=@MainForm.OnChangeDosimeterMeasTime;
  Self.OnChangeVerTime:=@MainForm.OnChangeDosimeterVerTime;
  Self.OnChangeRegTime:=@MainForm.OnChangeDosimeterRegTime;
  Self.OnChangeStatus:=@MainForm.OnChangeDosimeterStatus;
  Self.OnChangeValidity:=@MainForm.OnChangeDosimeterValidity;
  Self.OnChangeKS:=@MainForm.OnChangeDosimeterKS;
  Self.OnChangeK:=@MainForm.OnChangeDosimeterK;
  Self.OnChangeKFilter:=@MainForm.OnChangeDosimeterKFilter;
  Self.OnChangeKDevice:=@MainForm.OnChangeDosimeterKDevice;
  Self.OnChangeFormulaID:=@MainForm.OnChangeDosimeterFormulaID;
  Self.OnChangeFormula:=@MainForm.OnChangeDosimeterFormula;
  Self.OnChangePersNumber:=@MainForm.OnChangeDosimeterPersNumber;
  Self.OnChangeOrganization:=@MainForm.OnChangeDosimeterOrganization;
  Self.OnChangeDepartment:=@MainForm.OnChangeDosimeterDepartment;
  Self.OnChangeDosPart:=@MainForm.OnChangeDosimeterPart;
  Self.OnChangeFIO:=@MainForm.OnChangeDosimeterFIO;
  Self.OnChangeMeasComment:=@MainForm.OnChangeDosimeterMeasComment;
  Self.OnChangeLastMeasComment:=@MainForm.OnChangeLastMeasComment;
  Self.OnChangeLastMeasResult:=@MainForm.OnChangeLastMeasResult;
  Self.OnChangeLastMeasTime:=@MainForm.OnChangeLastMeasTime;
  Self.OnShowTempProfileWrite:=@MainForm.OnShowDosimeterTempProfileWrite;

  FFullNumber:=aFullNumber;
  FMeasurementID:=0;

  FPersNumber:=-1;

  Status:=stDosCalibrated;
  Validity:=stDosNotMeasured;

  DetectorsCnt:=0;
  TablePos:=0;

  DetectorsList:=TList.Create();

  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;

  TLDDataModule.ADOQuery.SQL.Add('SELECT * FROM '+cDBTableDosID+' '
                                         +'WHERE (CAST ('+cFieldDosID+' AS TEXT) = '+#39+FFullNumber+#39+' AND '+cFieldDosPostfix+' = '+#39+'-'+#39+') OR '
                                         +'CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' = '+#39+FFullNumber+#39);

  TLDDataModule.ADOQuery.Active:=True;

  FID:=TLDDataModule.ADOQuery.FieldValues[cFieldDosID];
  FPostfix:=TLDDataModule.ADOQuery.FieldValues[cFieldDosPostfix];
  FDosType:=TLDDataModule.ADOQuery.FieldValues[cFieldDosType];
  FDosTypeID:=TLDDataModule.ADOQuery.FieldValues[cFieldDosTypeID];

  Self.Coefficients:=TCoefficients.Create(Self);
  Self.Doses:=TDoses.Create(Self);

  if MainForm.UseKFilter then FKFilter:=MainForm.KFilter else FKFilter:=cDosNoFilter;

  ecc1:=CheckNan(TLDDataModule.ADOQuery,cField_ecc1);
  ecc2:=CheckNan(TLDDataModule.ADOQuery,cField_ecc2);
  ecc3:=CheckNan(TLDDataModule.ADOQuery,cField_ecc3);
  ecc4:=CheckNan(TLDDataModule.ADOQuery,cField_ecc4);

  FTldID:=MainForm.DeviceID;
  FPartID:=TLDDataModule.ADOQuery.FieldValues[cFieldPartID];
  FStatus:=TLDDataModule.ADOQuery.FieldValues[cFieldDosStatus];
  FRegTime:=TLDDataModule.ADOQuery.FieldValues[cFieldRegTime];
  FVerTime:=TLDDataModule.ADOQuery.FieldValues[cFieldVerTime];
  FOrganization:=TLDDataModule.ADOQuery.FieldValues[cFieldOrg];
  FDepartment:=TLDDataModule.ADOQuery.FieldValues[cFieldDepartment];
  FLastMeasComment:=TLDDataModule.ADOQuery.FieldValues[cFieldLastMeasComment];
  FLastMeasTime:=TLDDataModule.ADOQuery.FieldByName(cFieldLastMeasTime).AsDateTime;

  if FPartID>0 then
  begin
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('SELECT '+cField_k1+','
                                            +cField_k2+','
                                            +cField_k3+','
                                            +cField_k4+','
                                            +cField_k5+','
                                            +cField_kgn+' '
                                    +'FROM '+cDBTableDosPart+' '
                                   +'WHERE '+cFieldPartID+' = '+#39+IntToStr(FPartID)+#39);
    TLDDataModule.ADOQuery.Active:=True;
    K1:=CheckNan(TLDDataModule.ADOQuery,cField_k1);
    K2:=CheckNan(TLDDataModule.ADOQuery,cField_k2);
    K3:=CheckNan(TLDDataModule.ADOQuery,cField_k3);
    K4:=CheckNan(TLDDataModule.ADOQuery,cField_k4);
    K5:=CheckNan(TLDDataModule.ADOQuery,cField_k5);
    Kgn:=CheckNan(TLDDataModule.ADOQuery,cField_kgn);
  end
  else
  begin
    K1:=CheckNan(TLDDataModule.ADOQuery,cField_k1);
    K2:=CheckNan(TLDDataModule.ADOQuery,cField_k2);
    K3:=CheckNan(TLDDataModule.ADOQuery,cField_k3);
    K4:=CheckNan(TLDDataModule.ADOQuery,cField_k4);
    K5:=CheckNan(TLDDataModule.ADOQuery,cField_k5);
    Kgn:=CheckNan(TLDDataModule.ADOQuery,cField_kgn);
  end;

  FPartName:=TLDDataModule.GetPartName(FPartID);

  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;

  TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDType1+','
                                          +cFieldDType2+','
                                          +cFieldDType3+','
                                          +cFieldDType4+','
                                          +cFieldMeasVal+','
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
                                          +cFieldFormula_Err_k2_4+' '
                                  +'FROM '+cDBTableDosType+' '
                                 +'WHERE '+cFieldDosTypeID+' = '+#39+FDosTypeID+#39);

  TLDDataModule.ADOQuery.Active:=True;

  FMeasValues           := TLDDataModule.ADOQuery.FieldValues[cFieldMeasVal];
  FFormula              := cDetMeasValTxt_AllVal[TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Dos).AsInteger];
  FFormulaID            := TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Dos).AsInteger;
  FFormulaID_Val_1      := TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_1).AsInteger;
  FFormulaID_Val_2      := TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_2).AsInteger;
  FFormulaID_Val_3      := TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_3).AsInteger;
  FFormulaID_Val_4      := TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_4).AsInteger;
  FFormula_Val_ErrK1_1  := TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k1_1).AsFloat;
  FFormula_Val_ErrK2_1  := TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k2_1).AsFloat;
  FFormula_Val_ErrK1_2  := TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k1_2).AsFloat;
  FFormula_Val_ErrK2_2  := TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k2_2).AsFloat;
  FFormula_Val_ErrK1_3  := TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k1_3).AsFloat;
  FFormula_Val_ErrK2_3  := TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k2_3).AsFloat;
  FFormula_Val_ErrK1_4  := TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k1_4).AsFloat;
  FFormula_Val_ErrK2_4  := TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k2_4).AsFloat;

  idD1:=TLDDataModule.ADOQuery.FieldValues[cFieldDType1];
  idD2:=TLDDataModule.ADOQuery.FieldValues[cFieldDType2];
  idD3:=TLDDataModule.ADOQuery.FieldValues[cFieldDType3];
  idD4:=TLDDataModule.ADOQuery.FieldValues[cFieldDType4];

// создание детектора 1
  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDetType+','
                                          +cFieldTempProfile+','
                                          +cFieldDetMeasVal+','
                                          +cFieldDetKName+','
                                          +cFieldMethod+','
                                          +cFieldK1Profile+','
                                          +cFieldK2Profile+','
                                          +cFieldDetTypeComment+' '
                                  +'FROM '+cDBTableDetType+' '
                                 +'WHERE '+cFieldDetTypeID+' = '+IntToStr(idD1));
  TLDDataModule.ADOQuery.Active:=True;

  if not (TLDDataModule.ADOQuery.FieldValues[cFieldDetType] = cNone) then
  begin
    Detector1:=TDetector.Create(TLDDataModule.ADOQuery.FieldValues[cFieldDetType],idD1,cDetPos1,Self);
    Detector1.Use:=True;
    Detector1.MeasValue:=TLDDataModule.ADOQuery.FieldValues[cFieldDetMeasVal];
    Detector1.KName:=TLDDataModule.ADOQuery.FieldValues[cFieldDetKName];
    Detector1.Method:=TLDDataModule.ADOQuery.FieldValues[cFieldMethod];
    Detector1.DetTypeComment:=TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeComment).AsString;
    Detector1.TmpWrite:=TLDDataModule.ADOQuery.FieldByName(cFieldTempProfile).AsString;
    SetDetTemProfile(Detector1,TLDDataModule.ADOQuery.FieldByName(cFieldTempProfile).AsString);
    Detector1.DetType:=TLDDataModule.ADOQuery.FieldValues[cFieldDetType];
    Detector1.K1Profile:=TLDDataModule.ADOQuery.FieldByName(cFieldK1Profile).AsFloat;
    Detector1.K2Profile:=TLDDataModule.ADOQuery.FieldByName(cFieldK2Profile).AsFloat;
    DetectorsList.Add(Detector1);
  end
  else
    DetectorsList.Add(nil);

// создание детектора 2
  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDetType+','
                                          +cFieldTempProfile+','
                                          +cFieldDetMeasVal+','
                                          +cFieldDetKName+','
                                          +cFieldMethod+','
                                          +cFieldK1Profile+','
                                          +cFieldK2Profile+','
                                          +cFieldDetTypeComment+' '
                                  +'FROM '+cDBTableDetType+' '
                                 +'WHERE '+cFieldDetTypeID+' = '+IntToStr(idD2));
  TLDDataModule.ADOQuery.Active:=True;

  if not (TLDDataModule.ADOQuery.FieldValues[cFieldDetType] = cNone) then
  begin
    Detector2:=TDetector.Create(TLDDataModule.ADOQuery.FieldValues[cFieldDetType],idD2,cDetPos2,Self);
    Detector2.Use:=True;
    Detector2.MeasValue:=TLDDataModule.ADOQuery.FieldValues[cFieldDetMeasVal];
    Detector2.KName:=TLDDataModule.ADOQuery.FieldValues[cFieldDetKName];
    Detector2.Method:=TLDDataModule.ADOQuery.FieldValues[cFieldMethod];
    Detector2.DetTypeComment:=TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeComment).AsString;
    Detector2.TmpWrite:=TLDDataModule.ADOQuery.FieldByName(cFieldTempProfile).AsString;
    SetDetTemProfile(Detector2,TLDDataModule.ADOQuery.FieldByName(cFieldTempProfile).AsString);
    Detector2.DetType:=TLDDataModule.ADOQuery.FieldValues[cFieldDetType];
    Detector2.K1Profile:=TLDDataModule.ADOQuery.FieldByName(cFieldK1Profile).AsFloat;
    Detector2.K2Profile:=TLDDataModule.ADOQuery.FieldByName(cFieldK2Profile).AsFloat;
    DetectorsList.Add(Detector2);
  end
  else
    DetectorsList.Add(nil);

// создание детектора 3
  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDetType+','
                                          +cFieldTempProfile+','
                                          +cFieldDetMeasVal+','
                                          +cFieldDetKName+','
                                          +cFieldMethod+','
                                          +cFieldK1Profile+','
                                          +cFieldK2Profile+','
                                          +cFieldDetTypeComment+' '
                                  +'FROM '+cDBTableDetType+' '
                                 +'WHERE '+cFieldDetTypeID+' = '+IntToStr(idD3));
  TLDDataModule.ADOQuery.Active:=True;

  if not (TLDDataModule.ADOQuery.FieldValues[cFieldDetType] = cNone) then
  begin
    Detector3:=TDetector.Create(TLDDataModule.ADOQuery.FieldValues[cFieldDetType],idD3,cDetPos3,Self);
    Detector3.Use:=True;
    Detector3.MeasValue:=TLDDataModule.ADOQuery.FieldValues[cFieldDetMeasVal];
    Detector3.KName:=TLDDataModule.ADOQuery.FieldValues[cFieldDetKName];
    Detector3.Method:=TLDDataModule.ADOQuery.FieldValues[cFieldMethod];
    Detector3.DetTypeComment:=TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeComment).AsString;
    Detector3.TmpWrite:=TLDDataModule.ADOQuery.FieldByName(cFieldTempProfile).AsString;
    SetDetTemProfile(Detector3,TLDDataModule.ADOQuery.FieldByName(cFieldTempProfile).AsString);
    Detector3.DetType:=TLDDataModule.ADOQuery.FieldValues[cFieldDetType];
    Detector3.K1Profile:=TLDDataModule.ADOQuery.FieldByName(cFieldK1Profile).AsFloat;
    Detector3.K2Profile:=TLDDataModule.ADOQuery.FieldByName(cFieldK2Profile).AsFloat;
    DetectorsList.Add(Detector3);
  end
  else
    DetectorsList.Add(nil);

// создание детектора 4
  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDetType+','
                                          +cFieldTempProfile+','
                                          +cFieldDetMeasVal+','
                                          +cFieldDetKName+','
                                          +cFieldMethod+','
                                          +cFieldK1Profile+','
                                          +cFieldK2Profile+','
                                          +cFieldDetTypeComment+' '
                                  +'FROM '+cDBTableDetType+' '
                                 +'WHERE '+cFieldDetTypeID+' = '+IntToStr(idD4));
  TLDDataModule.ADOQuery.Active:=True;

  if not (TLDDataModule.ADOQuery.FieldValues[cFieldDetType] = cNone) then
  begin
    Detector4:=TDetector.Create(TLDDataModule.ADOQuery.FieldValues[cFieldDetType],idD4,cDetPos4,Self);
    Detector4.Use:=True;
    Detector4.MeasValue:=TLDDataModule.ADOQuery.FieldValues[cFieldDetMeasVal];
    Detector4.KName:=TLDDataModule.ADOQuery.FieldValues[cFieldDetKName];
    Detector4.Method:=TLDDataModule.ADOQuery.FieldValues[cFieldMethod];
    Detector4.DetTypeComment:=TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeComment).AsString;
    Detector4.TmpWrite:=TLDDataModule.ADOQuery.FieldByName(cFieldTempProfile).AsString;
    SetDetTemProfile(Detector4,TLDDataModule.ADOQuery.FieldByName(cFieldTempProfile).AsString);
    Detector4.DetType:=TLDDataModule.ADOQuery.FieldValues[cFieldDetType];
    Detector4.K1Profile:=TLDDataModule.ADOQuery.FieldByName(cFieldK1Profile).AsFloat;
    Detector4.K2Profile:=TLDDataModule.ADOQuery.FieldByName(cFieldK2Profile).AsFloat;
    DetectorsList.Add(Detector4);
  end
  else
    DetectorsList.Add(nil);

  MeasValList;

end;

constructor TDosimeter.Create(aFullNumber: String; aMeasId: String);
var
  Detector1,
  Detector2,
  Detector3,
  Detector4       : Detectors;
  function CheckDoubleNan(Field: String): double;
  begin
    if TLDDataModule.ADOQuery.FieldByName(Field).AsVariant <> Null then
      Result:=TLDDataModule.ADOQuery.FieldByName(Field).AsFloat
    else
      Result:=NAN;
  end;
  function CheckStringNan(Field: String): String;
  begin
    if TLDDataModule.ADOQuery.FieldByName(Field).AsVariant <> Null then
      Result:=TLDDataModule.ADOQuery.FieldByName(Field).AsString
    else
      Result:='';
  end;
begin
  inherited Create(nil);

  //FKDevice:=1;

  FKDevice:=MainForm.KDevice;

  Self.OnChangeNumber:=@MainForm.OnChangeDosimeterNumber;
  Self.OnChangePostfix:=@MainForm.OnChangeDosimeterPostfix;
  Self.OnChangeFullNumber:=@MainForm.OnChangeDosimeterFullNumber;
  Self.OnChangeDose:=@MainForm.OnChangeDosimeterDose;
  Self.OnChangeDoseType:=@MainForm.OnChangeDosimeterDoseType;
  Self.OnChangeMeasValues:=@MainForm.OnChangeDosimeterMeasValues;
  Self.OnChangeErr:=@MainForm.OnChangeDosimeterErr;
  Self.OnChangeMeasTime:=@MainForm.OnChangeDosimeterMeasTime;
  Self.OnChangeVerTime:=@MainForm.OnChangeDosimeterVerTime;
  Self.OnChangeRegTime:=@MainForm.OnChangeDosimeterRegTime;
  Self.OnChangeStatus:=@MainForm.OnChangeDosimeterStatus;
  Self.OnChangeValidity:=@MainForm.OnChangeDosimeterValidity;
  Self.OnChangeKS:=@MainForm.OnChangeDosimeterKS;
  Self.OnChangeK:=@MainForm.OnChangeDosimeterK;
  Self.OnChangeKFilter:=@MainForm.OnChangeDosimeterKFilter;
  Self.OnChangeKDevice:=@MainForm.OnChangeDosimeterKDevice;
  Self.OnChangeFormulaID:=@MainForm.OnChangeDosimeterFormulaID;
  Self.OnChangeFormula:=@MainForm.OnChangeDosimeterFormula;
  Self.OnChangePersNumber:=@MainForm.OnChangeDosimeterPersNumber;
  Self.OnChangeOrganization:=@MainForm.OnChangeDosimeterOrganization;
  Self.OnChangeDepartment:=@MainForm.OnChangeDosimeterDepartment;
  Self.OnChangeDosPart:=@MainForm.OnChangeDosimeterPart;
  Self.OnChangeFIO:=@MainForm.OnChangeDosimeterFIO;
  Self.OnChangeMeasComment:=@MainForm.OnChangeDosimeterMeasComment;
  Self.OnChangeLastMeasComment:=@MainForm.OnChangeLastMeasComment;
  Self.OnChangeLastMeasResult:=@MainForm.OnChangeLastMeasResult;
  Self.OnChangeLastMeasTime:=@MainForm.OnChangeLastMeasTime;
  Self.OnShowTempProfileWrite:=@MainForm.OnShowDosimeterTempProfileWrite;

  Err_Hp_10g_Percent := NAN;
  Err_Hp_10n_Percent := NAN;
  Err_Hp_3_Percent   := NAN;
  Err_Hp_007_Percent := NAN;
  Err_H_star_Percent := NAN;
  Err_H_007_Percent  := NAN;
  Err_D_Percent      := NAN;

  FFullNumber:=aFullNumber;
  FMeasurementID:=0;

  Status:=stDosCalibrated;
  Validity:=stDosNotMeasured;

  DetectorsCnt:=0;
  TablePos:=0;

  DetectorsList:=TList.Create();

  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;

  TLDDataModule.ADOQuery.SQL.Add('SELECT * FROM '+cDBTableDosRes+' '
                                         +'WHERE ((CAST ('+cFieldDosID+' AS TEXT) = '+#39+FFullNumber+#39+' AND '+cFieldDosPostfix+' = '+#39+'-'+#39+') OR '
                                         +'CAST ('+cFieldDosID+' AS TEXT) || '+cFieldDosPostfix+' = '+#39+FFullNumber+#39+') AND '
                                         +cFieldDosMeasID+' = '+aMeasId);

  TLDDataModule.ADOQuery.Active:=True;

  FID:=TLDDataModule.ADOQuery.FieldValues[cFieldDosID];
  FPostfix:=TLDDataModule.ADOQuery.FieldValues[cFieldDosPostfix];
  FDosType:=TLDDataModule.ADOQuery.FieldValues[cFieldDosType];
  FDosTypeID:=TLDDataModule.ADOQuery.FieldValues[cFieldDosTypeID];

  Self.Coefficients:=TCoefficients.Create(Self);
  Self.Doses:=TDoses.Create(Self);

  if MainForm.UseKFilter then FKFilter:=MainForm.KFilter else FKFilter:=cDosNoFilter;

  ecc1:=CheckNan(TLDDataModule.ADOQuery,cField_ecc1);
  ecc2:=CheckNan(TLDDataModule.ADOQuery,cField_ecc2);
  ecc3:=CheckNan(TLDDataModule.ADOQuery,cField_ecc3);
  ecc4:=CheckNan(TLDDataModule.ADOQuery,cField_ecc4);

  FTldID:=MainForm.DeviceID;
  FMeasValues:=TLDDataModule.ADOQuery.FieldValues[cFieldMeasVal];
  FPartID:=TLDDataModule.ADOQuery.FieldValues[cFieldPartID];
  FPartName:=TLDDataModule.ADOQuery.FieldValues[cFieldDosPartName];
  FStatus:=TLDDataModule.ADOQuery.FieldValues[cFieldDosStatus];
  FRegTime:=TLDDataModule.ADOQuery.FieldValues[cFieldRegTime];
  FVerTime:=TLDDataModule.ADOQuery.FieldValues[cFieldVerTime];
  FOrganization:=CheckStringNan(cFieldOrg);
  FDepartment:=CheckStringNan(cFieldDepartment);
  FFio:=CheckStringNan(cFieldFio);
  FLastMeasComment:=CheckStringNan(cFieldLastMeasComment);
  FLastMeasTime:=TLDDataModule.ADOQuery.FieldByName(cFieldLastMeasTime).AsDateTime;

  K1:=CheckDoubleNan(cField_k1);
  K2:=CheckDoubleNan(cField_k2);
  K3:=CheckDoubleNan(cField_k3);
  K4:=CheckDoubleNan(cField_k4);
  K5:=CheckDoubleNan(cField_k5);
  Kgn:=CheckDoubleNan(cField_kgn);

  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;

  // создание детектора 1
  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDetTypeID+','
                                          +cFieldDetMeasVal+','
                                          +cFieldDetKName+','
                                          +cFieldDetType+','
                                          +cFieldMethod+','
                                          +cFieldK1Profile+','
                                          +cFieldK2Profile+','
                                          +cFieldDetTypeComment+' '
                                  +'FROM '+cDBTableDetRes+' '
                                 +'WHERE '+cFieldDetPosition+' = '+IntToStr(cDetPos1)+' '
                                   +'AND '+cFieldDosMeasID+' = '+aMeasId);
  TLDDataModule.ADOQuery.Active:=True;

  if (not VarIsNull(TLDDataModule.ADOQuery.FieldValues[cFieldDetType])) AND (not VarIsNull(TLDDataModule.ADOQuery.FieldValues[cFieldDetTypeID])) then
  begin
    Detector1:=TDetector.Create(TLDDataModule.ADOQuery.FieldValues[cFieldDetType],TLDDataModule.ADOQuery.FieldValues[cFieldDetTypeID],cDetPos1,Self);
    Detector1.Use:=True;
    Detector1.MeasValue:=CheckStringNan(cFieldDetMeasVal);//TLDDataModule.ADOQuery.FieldValues[cFieldDetMeasVal];
    Detector1.KName:=CheckStringNan(cFieldDetKName);//TLDDataModule.ADOQuery.FieldValues[cFieldDetKName];
    Detector1.Method:=CheckStringNan(cFieldMethod);//TLDDataModule.ADOQuery.FieldValues[cFieldMethod];
    Detector1.DetTypeComment:=CheckStringNan(cFieldDetTypeComment);//TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeComment).AsString;
    Detector1.DetType:=CheckStringNan(cFieldDetType);//TLDDataModule.ADOQuery.FieldValues[cFieldDetType];
    Detector1.K1Profile:=CheckDoubleNan(cFieldK1Profile);
    Detector1.K2Profile:=CheckDoubleNan(cFieldK2Profile);
    DetectorsList.Add(Detector1);
  end
  else
    DetectorsList.Add(nil);

  // создание детектора 2
  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDetTypeID+','
                                          +cFieldDetMeasVal+','
                                          +cFieldDetKName+','
                                          +cFieldDetType+','
                                          +cFieldMethod+','
                                          +cFieldK1Profile+','
                                          +cFieldK2Profile+','
                                          +cFieldDetTypeComment+' '
                                  +'FROM '+cDBTableDetRes+' '
                                 +'WHERE '+cFieldDetPosition+' = '+IntToStr(cDetPos2)+' '
                                   +'AND '+cFieldDosMeasID+' = '+aMeasId);
  TLDDataModule.ADOQuery.Active:=True;

  if (not VarIsNull(TLDDataModule.ADOQuery.FieldValues[cFieldDetType])) AND (not VarIsNull(TLDDataModule.ADOQuery.FieldValues[cFieldDetTypeID])) then
  begin
    Detector2:=TDetector.Create(TLDDataModule.ADOQuery.FieldValues[cFieldDetType],TLDDataModule.ADOQuery.FieldValues[cFieldDetTypeID],cDetPos2,Self);
    Detector2.Use:=True;
    Detector2.MeasValue:=CheckStringNan(cFieldDetMeasVal);//TLDDataModule.ADOQuery.FieldValues[cFieldDetMeasVal];
    Detector2.KName:=CheckStringNan(cFieldDetKName);//TLDDataModule.ADOQuery.FieldValues[cFieldDetKName];
    Detector2.Method:=CheckStringNan(cFieldMethod);//TLDDataModule.ADOQuery.FieldValues[cFieldMethod];
    Detector2.DetTypeComment:=CheckStringNan(cFieldDetTypeComment);//TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeComment).AsString;
    Detector2.DetType:=CheckStringNan(cFieldDetType);//TLDDataModule.ADOQuery.FieldValues[cFieldDetType];
    Detector2.K1Profile:=CheckDoubleNan(cFieldK1Profile);
    Detector2.K2Profile:=CheckDoubleNan(cFieldK2Profile);
    DetectorsList.Add(Detector2);
  end
  else
    DetectorsList.Add(nil);

  // создание детектора 3
  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDetTypeID+','
                                          +cFieldDetMeasVal+','
                                          +cFieldDetKName+','
                                          +cFieldDetType+','
                                          +cFieldMethod+','
                                          +cFieldK1Profile+','
                                          +cFieldK2Profile+','
                                          +cFieldDetTypeComment+' '
                                  +'FROM '+cDBTableDetRes+' '
                                 +'WHERE '+cFieldDetPosition+' = '+IntToStr(cDetPos3)+' '
                                   +'AND '+cFieldDosMeasID+' = '+aMeasId);
  TLDDataModule.ADOQuery.Active:=True;

  if (not VarIsNull(TLDDataModule.ADOQuery.FieldValues[cFieldDetType])) AND (not VarIsNull(TLDDataModule.ADOQuery.FieldValues[cFieldDetTypeID])) then
  begin
    Detector3:=TDetector.Create(TLDDataModule.ADOQuery.FieldValues[cFieldDetType],TLDDataModule.ADOQuery.FieldValues[cFieldDetTypeID],cDetPos3,Self);
    Detector3.Use:=True;
    Detector3.MeasValue:=CheckStringNan(cFieldDetMeasVal);//TLDDataModule.ADOQuery.FieldValues[cFieldDetMeasVal];
    Detector3.KName:=CheckStringNan(cFieldDetKName);//TLDDataModule.ADOQuery.FieldValues[cFieldDetKName];
    Detector3.Method:=CheckStringNan(cFieldMethod);//TLDDataModule.ADOQuery.FieldValues[cFieldMethod];
    Detector3.DetTypeComment:=CheckStringNan(cFieldDetTypeComment);//TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeComment).AsString;
    Detector3.DetType:=CheckStringNan(cFieldDetType);//TLDDataModule.ADOQuery.FieldValues[cFieldDetType];
    Detector3.K1Profile:=CheckDoubleNan(cFieldK1Profile);
    Detector3.K2Profile:=CheckDoubleNan(cFieldK2Profile);
    DetectorsList.Add(Detector3);
  end
  else
    DetectorsList.Add(nil);

  // создание детектора 4
  TLDDataModule.ADOQuery.Active:=False;
  TLDDataModule.ADOQuery.SQL.Clear;
  TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDetTypeID+','
                                          +cFieldDetMeasVal+','
                                          +cFieldDetKName+','
                                          +cFieldDetType+','
                                          +cFieldMethod+','
                                          +cFieldK1Profile+','
                                          +cFieldK2Profile+','
                                          +cFieldDetTypeComment+' '
                                  +'FROM '+cDBTableDetRes+' '
                                 +'WHERE '+cFieldDetPosition+' = '+IntToStr(cDetPos4)+' '
                                   +'AND '+cFieldDosMeasID+' = '+aMeasId);
  TLDDataModule.ADOQuery.Active:=True;

  if (not VarIsNull(TLDDataModule.ADOQuery.FieldValues[cFieldDetType])) AND (not VarIsNull(TLDDataModule.ADOQuery.FieldValues[cFieldDetTypeID])) then
  begin
    Detector4:=TDetector.Create(TLDDataModule.ADOQuery.FieldValues[cFieldDetType],TLDDataModule.ADOQuery.FieldValues[cFieldDetTypeID],cDetPos4,Self);
    Detector4.Use:=True;
    Detector4.MeasValue:=CheckStringNan(cFieldDetMeasVal);//TLDDataModule.ADOQuery.FieldValues[cFieldDetMeasVal];
    Detector4.KName:=CheckStringNan(cFieldDetKName);//TLDDataModule.ADOQuery.FieldValues[cFieldDetKName];
    Detector4.Method:=CheckStringNan(cFieldMethod);//TLDDataModule.ADOQuery.FieldValues[cFieldMethod];
    Detector4.DetTypeComment:=CheckStringNan(cFieldDetTypeComment);//TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeComment).AsString;
    Detector4.DetType:=CheckStringNan(cFieldDetType);//TLDDataModule.ADOQuery.FieldValues[cFieldDetType];
    Detector4.K1Profile:=CheckDoubleNan(cFieldK1Profile);
    Detector4.K2Profile:=CheckDoubleNan(cFieldK2Profile);
    DetectorsList.Add(Detector4);
  end
  else
    DetectorsList.Add(nil);

  MeasValList;
end;

procedure TDosimeter.CalcDetectorDose(DetPos: integer);
var
  S: double;
begin
  case DetPos of
    cDetPos1:
    begin
      if Ecc1 <> 0 then
        S:=TDetector(DetectorsList[DetPos-1]).S/Ecc1
      else
        S:=TDetector(DetectorsList[DetPos-1]).S;

      case FormulaID of
        cHp_10g_1d,
        cHp_10g_2d,
        cHp_10g_3d,
        cHp_10g_4d,
        cHp_10g_2d_Hp_10n_2d,
        cHp_10g_2d_Hp_10n_1d,
        cHp_10g_1d_Hp_10n_2d,
        cHp_10g_1d_Hp_10n_1d,
        cHp_007g_1d,
        cHp_007g_2d,
        cHp_007g_3d,
        cHp_007g_4d,
        cHp_007gb_1d,
        cHp_007gb_2d,
        cHp_007gb_3d,
        cHp_007gb_4d,
        cHp_3_1d,
        cHp_3_2d,
        cHp_3_3d,
        cHp_3_4d,
        cHp_star_g_1d,
        cHp_star_g_2d,
        cHp_star_g_3d,
        cHp_star_g_4d,
        cH_007_dir_g_1d,
        cH_007_dir_g_2d,
        cH_007_dir_g_3d,
        cH_007_dir_g_4d,
        cHp_10g_Hp_10n_Hp_007g_Hp_3,
        cD_1d,
        cD_2d,
        cD_3d,
        cD_4d,
        cHp_10g_1d_Hp_007g_1d_Hp_3_1d,
        cHp_10g_1d_Hp_007g_1d,
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          if (DetectorsList[DetPos-1])<>nil then
            if K1 <> 0 then
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=RoundToCN(((S/K1)/KFilter)*KDevice,cAfterComma);
              TDetector(DetectorsList[DetPos-1]).Err:=RoundToCN(TDetector(DetectorsList[DetPos-1]).Err,cAfterComma);
            end
            else
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=cInvalidDoseValue;
              TDetector(DetectorsList[DetPos-1]).Err:=cInvalidDoseValue;
            end;
        end;
      end;
    end;
    cDetPos2:
    begin
      if Ecc2 <> 0 then
        S:=TDetector(DetectorsList[DetPos-1]).S/Ecc2
      else
        S:=TDetector(DetectorsList[DetPos-1]).S;

      case FormulaID of
        cHp_10g_2d,
        cHp_10g_3d,
        cHp_10g_4d,
        cHp_10g_2d_Hp_10n_2d,
        cHp_10g_2d_Hp_10n_1d,
        cHp_007g_2d,
        cHp_007g_3d,
        cHp_007g_4d,
        cHp_007gb_2d,
        cHp_007gb_3d,
        cHp_007gb_4d,
        cHp_3_2d,
        cHp_3_3d,
        cHp_3_4d,
        cHp_star_g_2d,
        cHp_star_g_3d,
        cHp_star_g_4d,
        cH_007_dir_g_2d,
        cH_007_dir_g_3d,
        cH_007_dir_g_4d,
        cD_2d,
        cD_3d,
        cD_4d:
        begin
          if (DetectorsList[DetPos-1])<>nil then
            if K1 <> 0 then
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=RoundToCN(((S/K1)/KFilter)*KDevice,cAfterComma);
              TDetector(DetectorsList[DetPos-1]).Err:=RoundToCN(TDetector(DetectorsList[DetPos-1]).Err,cAfterComma);
            end
            else
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=cInvalidDoseValue;
              TDetector(DetectorsList[DetPos-1]).Err:=cInvalidDoseValue;
            end;
        end;
        cHp_10g_1d_Hp_10n_2d,
        cHp_10g_1d_Hp_10n_1d,
        cHp_10g_Hp_10n_Hp_007g_Hp_3,
        cHp_10g_1d_Hp_007g_1d_Hp_3_1d,
        cHp_10g_1d_Hp_007g_1d,
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          if (DetectorsList[DetPos-1])<>nil then
            if K2 <> 0 then
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=RoundToCN(((S/K2)/KFilter)*KDevice,cAfterComma);
              TDetector(DetectorsList[DetPos-1]).Err:=RoundToCN(TDetector(DetectorsList[DetPos-1]).Err,cAfterComma);
            end
            else
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=cInvalidDoseValue;
              TDetector(DetectorsList[DetPos-1]).Err:=cInvalidDoseValue;
            end;
        end;
      end;
    end;
    cDetPos3:
    begin
      if Ecc3 <> 0 then
        S:=TDetector(DetectorsList[DetPos-1]).S/Ecc3
      else
        S:=TDetector(DetectorsList[DetPos-1]).S;

      case FormulaID of
        cHp_10g_3d,
        cHp_10g_4d,
        cHp_007g_3d,
        cHp_007g_4d,
        cHp_007gb_3d,
        cHp_007gb_4d,
        cHp_3_3d,
        cHp_3_4d,
        cHp_star_g_3d,
        cHp_star_g_4d,
        cH_007_dir_g_3d,
        cH_007_dir_g_4d,
        cD_3d,
        cD_4d:
        begin
          if (DetectorsList[DetPos-1])<>nil then
            if K1 <> 0 then
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=RoundToCN(((S/K1)/KFilter)*KDevice,cAfterComma);
              TDetector(DetectorsList[DetPos-1]).Err:=RoundToCN(TDetector(DetectorsList[DetPos-1]).Err,cAfterComma);
            end
            else
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=cInvalidDoseValue;
              TDetector(DetectorsList[DetPos-1]).Err:=cInvalidDoseValue;
            end;
        end;
        cHp_10g_2d_Hp_10n_2d,
        cHp_10g_2d_Hp_10n_1d,
        cHp_10g_1d_Hp_10n_2d:
        begin
          if (DetectorsList[DetPos-1])<>nil then
            if K2 <> 0 then
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=RoundToCN(((S/K2)/KFilter)*KDevice,cAfterComma);
              TDetector(DetectorsList[DetPos-1]).Err:=RoundToCN(TDetector(DetectorsList[DetPos-1]).Err,cAfterComma);
            end
            else
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=cInvalidDoseValue;
              TDetector(DetectorsList[DetPos-1]).Err:=cInvalidDoseValue;
            end;
        end;
        cHp_10g_Hp_10n_Hp_007g_Hp_3,
        cHp_10g_1d_Hp_007g_1d_Hp_3_1d,
        cHp_10g_1d_Hp_007g_1d,
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          if (DetectorsList[DetPos-1])<>nil then
            if K3 <> 0 then
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=RoundToCN(((S/K3)/KFilter)*KDevice,cAfterComma);
              TDetector(DetectorsList[DetPos-1]).Err:=RoundToCN(TDetector(DetectorsList[DetPos-1]).Err,cAfterComma);
            end
            else
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=cInvalidDoseValue;
              TDetector(DetectorsList[DetPos-1]).Err:=cInvalidDoseValue;
            end;
        end;
      end;
    end;
    cDetPos4:
    begin
      if Ecc4 <> 0 then
        S:=TDetector(DetectorsList[DetPos-1]).S/Ecc4
      else
        S:=TDetector(DetectorsList[DetPos-1]).S;

      case FormulaID of
        cHp_10g_4d,
        cHp_007g_4d,
        cHp_007gb_4d,
        cHp_3_4d,
        cHp_star_g_4d,
        cH_007_dir_g_4d,
        cD_4d:
        begin
          if (DetectorsList[DetPos-1])<>nil then
            if K1 <> 0 then
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=RoundToCN(((S/K1)/KFilter)*KDevice,cAfterComma);
              TDetector(DetectorsList[DetPos-1]).Err:=RoundToCN(TDetector(DetectorsList[DetPos-1]).Err,cAfterComma);
            end
            else
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=cInvalidDoseValue;
              TDetector(DetectorsList[DetPos-1]).Err:=cInvalidDoseValue;
            end;
        end;
        cHp_10g_2d_Hp_10n_2d:
        begin
          if (DetectorsList[DetPos-1])<>nil then
            if K2 <> 0 then
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=RoundToCN(((S/K2)/KFilter)*KDevice,cAfterComma);
              TDetector(DetectorsList[DetPos-1]).Err:=RoundToCN(TDetector(DetectorsList[DetPos-1]).Err,cAfterComma);
            end
            else
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=cInvalidDoseValue;
              TDetector(DetectorsList[DetPos-1]).Err:=cInvalidDoseValue;
            end;
        end;
        cHp_10g_Hp_10n_Hp_007g_Hp_3,
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          if (DetectorsList[DetPos-1])<>nil then
            if K4 <> 0 then
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=RoundToCN(((S/K4)/KFilter)*KDevice,cAfterComma);
              TDetector(DetectorsList[DetPos-1]).Err:=RoundToCN(TDetector(DetectorsList[DetPos-1]).Err,cAfterComma);
            end
            else
            begin
              TDetector(DetectorsList[DetPos-1]).Dose:=cInvalidDoseValue;
              TDetector(DetectorsList[DetPos-1]).Err:=cInvalidDoseValue;
            end;
        end;
      end;
    end;
  end;
end;

function TDosimeter.OldCalcDose: double;
const
  cDet  ='d';
  cComma =',';
var
  i       : integer;
  detCnt  : integer;
  sumDose : double;
  _formula : String;
begin
  sumDose:=0;
  detCnt:=0;

  _formula:=Self.Formula;

  for i := 0 to DetectorsList.Count-1 do
  begin
    if (DetectorsList[i]<>nil) then
    begin
      case TDetector(DetectorsList[i]).State of
        stDetMeasFinished,stDetProcessedWarning,stDetProcessed:
        begin
          inc(detCnt);
          sumDose:=sumDose+TDetector(DetectorsList[i]).Dose;
        end
        else
        begin
          SkipDetecrorInFormula('d'+IntToStr(TDetector(DetectorsList[i]).Position));
        end;
      end;
    end;
  end;

  if detCnt>0 then Result:=RoundToCN((sumDose/detCnt){*Kh10},cAfterComma) else Result:=0;

end;

procedure TDosimeter.ProcessDetDose(Mask: byte; detPos: byte; var out_dose: double; var out_detCnt: byte);
begin
  if IsBitOn(Mask,detPos) then
  begin
    if (DetectorsList[detPos]<>nil) then
    begin
      case TDetector(DetectorsList[detPos]).State of
        stDetMeasFinished,stDetProcessedWarning,stDetProcessed:
        begin
          inc(out_detCnt);
          out_dose:=out_dose+TDetector(DetectorsList[detPos]).Dose;
        end;
      end;
    end;
  end;
end;

function TDosimeter.CalcDose_Hp_10g(Mask: byte): double;
var
  detCnt  : byte;
  sumDose : double;
  i       : integer;
begin
  sumDose:=0;
  detCnt:=0;

  for i := 0 to 3 do
    ProcessDetDose(Mask,i,sumDose,detCnt);

  if detCnt>0 then Result:=RoundToCN((sumDose/detCnt),cAfterComma) else Result:=0;
end;

function TDosimeter.CalcDose_Hp_10n(Mask: byte): double;
var
  detCnt              : byte;
  sumDose             : double;
  neutronAndGammaDose : double;
  i                   : integer;
begin
  sumDose:=0;
  detCnt:=0;

  for i := 0 to 3 do
    ProcessDetDose(Mask,i,sumDose,detCnt);

  if detCnt>0 then
  begin
    neutronAndGammaDose:=RoundToCN((sumDose/detCnt),cAfterComma);

    if (neutronAndGammaDose>Dose_Hp_10g) AND (Kgn<>0) then
      Result:=RoundToCN((neutronAndGammaDose-Dose_Hp_10g)*Kgn,cAfterComma)
    else
      Result:=0;
  end
  else
    Result:=0;
end;

function TDosimeter.CalcDose_Hp_007(Mask: byte): double;
var
  detCnt  : byte;
  sumDose : double;
  i       : integer;
begin
  sumDose:=0;
  detCnt:=0;

  for i := 0 to 3 do
    ProcessDetDose(Mask,i,sumDose,detCnt);

  if detCnt>0 then Result:=RoundToCN((sumDose/detCnt),cAfterComma) else Result:=0;
end;

function TDosimeter.CalcDose_Hp_3(Mask: byte): double;
var
  detCnt  : byte;
  sumDose : double;
  i       : integer;
begin
  sumDose:=0;
  detCnt:=0;

  for i := 0 to 3 do
    ProcessDetDose(Mask,i,sumDose,detCnt);

  if detCnt>0 then Result:=RoundToCN((sumDose/detCnt),cAfterComma) else Result:=0;
end;

function TDosimeter.CalcDose_H_star(Mask: byte): double;
var
  detCnt  : byte;
  sumDose : double;
  i       : integer;
begin
  sumDose:=0;
  detCnt:=0;

  for i := 0 to 3 do
    ProcessDetDose(Mask,i,sumDose,detCnt);

  if detCnt>0 then Result:=RoundToCN((sumDose/detCnt),cAfterComma) else Result:=0;
end;

function TDosimeter.CalcDose_H_007(Mask: byte): double;
var
  detCnt  : byte;
  sumDose : double;
  i       : integer;
begin
  sumDose:=0;
  detCnt:=0;

  for i := 0 to 3 do
    ProcessDetDose(Mask,i,sumDose,detCnt);

  if detCnt>0 then Result:=RoundToCN((sumDose/detCnt),cAfterComma) else Result:=0;
end;

function TDosimeter.CalcDose_D(Mask: byte): double;
var
  detCnt  : byte;
  sumDose : double;
  i       : integer;
begin
  sumDose:=0;
  detCnt:=0;

  for i := 0 to 3 do
    ProcessDetDose(Mask,i,sumDose,detCnt);

  if detCnt>0 then Result:=RoundToCN((sumDose/detCnt),cAfterComma) else Result:=0;
end;

procedure TDosimeter.CalcDose;
begin
  case FormulaID of
    cHp_10g_1d:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0001);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
    end;
    cHp_10g_2d:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0011);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
    end;
    cHp_10g_3d:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0111);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
    end;
    cHp_10g_4d:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_1111);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
    end;
    cHp_10g_2d_Hp_10n_2d:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0011);
      Dose_Hp_10n:=CalcDose_Hp_10n(cDetMask_1100);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10n:=GetDoseErr(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10n_Percent:=GetDoseErrPercent(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
      K2Err:=GetKErr(K2,Err_Hp_10g_Percent);
      KgnErr:=GetKErr(Kgn,Err_Hp_10n_Percent);
    end;
    cHp_10g_2d_Hp_10n_1d:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0011);
      Dose_Hp_10n:=CalcDose_Hp_10n(cDetMask_0100);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10n:=GetDoseErr(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10n_Percent:=GetDoseErrPercent(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
      K2Err:=GetKErr(K2,Err_Hp_10g_Percent);
      KgnErr:=GetKErr(Kgn,Err_Hp_10n_Percent);
    end;
    cHp_10g_1d_Hp_10n_2d:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0001);
      Dose_Hp_10n:=CalcDose_Hp_10n(cDetMask_0110);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10n:=GetDoseErr(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10n_Percent:=GetDoseErrPercent(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
      K2Err:=GetKErr(K2,Err_Hp_10g_Percent);
      KgnErr:=GetKErr(Kgn,Err_Hp_10n_Percent);
    end;
    cHp_10g_1d_Hp_10n_1d:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0001);
      Dose_Hp_10n:=CalcDose_Hp_10n(cDetMask_0010);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10n:=GetDoseErr(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10n_Percent:=GetDoseErrPercent(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
      K2Err:=GetKErr(K2,Err_Hp_10g_Percent);
      KgnErr:=GetKErr(Kgn,Err_Hp_10n_Percent);
    end;
    cHp_007g_1d,cHp_007gb_1d:
    begin
      Dose_Hp_007:=CalcDose_Hp_007(cDetMask_0001);
      Err_Hp_007:=GetDoseErr(Dose_Hp_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_007_Percent:=GetDoseErrPercent(Dose_Hp_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_007_Percent);
    end;
    cHp_007g_2d,cHp_007gb_2d:
    begin
      Dose_Hp_007:=CalcDose_Hp_007(cDetMask_0011);
      Err_Hp_007:=GetDoseErr(Dose_Hp_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_007_Percent:=GetDoseErrPercent(Dose_Hp_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_007_Percent);
    end;
    cHp_007g_3d,cHp_007gb_3d:
    begin
      Dose_Hp_007:=CalcDose_Hp_007(cDetMask_0111);
      Err_Hp_007:=GetDoseErr(Dose_Hp_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_007_Percent:=GetDoseErrPercent(Dose_Hp_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_007_Percent);
    end;
    cHp_007g_4d,cHp_007gb_4d:
    begin
      Dose_Hp_007:=CalcDose_Hp_007(cDetMask_1111);
      Err_Hp_007:=GetDoseErr(Dose_Hp_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_007_Percent:=GetDoseErrPercent(Dose_Hp_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_007_Percent);
    end;
    cHp_3_1d:
    begin
      Dose_Hp_3:=CalcDose_Hp_3(cDetMask_0001);
      Err_Hp_3:=GetDoseErr(Dose_Hp_3,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_3_Percent:=GetDoseErrPercent(Dose_Hp_3,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_3_Percent);
    end;
    cHp_3_2d:
    begin
      Dose_Hp_3:=CalcDose_Hp_3(cDetMask_0011);
      Err_Hp_3:=GetDoseErr(Dose_Hp_3,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_3_Percent:=GetDoseErrPercent(Dose_Hp_3,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_3_Percent);
    end;
    cHp_3_3d:
    begin
      Dose_Hp_3:=CalcDose_Hp_3(cDetMask_0111);
      Err_Hp_3:=GetDoseErr(Dose_Hp_3,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_3_Percent:=GetDoseErrPercent(Dose_Hp_3,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_3_Percent);
    end;
    cHp_3_4d:
    begin
      Dose_Hp_3:=CalcDose_Hp_3(cDetMask_1111);
      Err_Hp_3:=GetDoseErr(Dose_Hp_3,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_3_Percent:=GetDoseErrPercent(Dose_Hp_3,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_Hp_3_Percent);
    end;
    cHp_star_g_1d:
    begin
      Dose_H_star:=CalcDose_H_star(cDetMask_0001);
      Err_H_star:=GetDoseErr(Dose_H_star,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_H_star_Percent:=GetDoseErrPercent(Dose_H_star,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_H_star_Percent);
    end;
    cHp_star_g_2d:
    begin
      Dose_H_star:=CalcDose_H_star(cDetMask_0011);
      Err_H_star:=GetDoseErr(Dose_H_star,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_H_star_Percent:=GetDoseErrPercent(Dose_H_star,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_H_star_Percent);
    end;
    cHp_star_g_3d:
    begin
      Dose_H_star:=CalcDose_H_star(cDetMask_0111);
      Err_H_star:=GetDoseErr(Dose_H_star,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_H_star_Percent:=GetDoseErrPercent(Dose_H_star,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_H_star_Percent);
    end;
    cHp_star_g_4d:
    begin
      Dose_H_star:=CalcDose_H_star(cDetMask_1111);
      Err_H_star:=GetDoseErr(Dose_H_star,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_H_star_Percent:=GetDoseErrPercent(Dose_H_star,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_H_star_Percent);
    end;
    cH_007_dir_g_1d:
    begin
      Dose_H_007:=CalcDose_H_007(cDetMask_0001);
      Err_H_007:=GetDoseErr(Dose_H_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_H_007_Percent:=GetDoseErrPercent(Dose_H_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_H_007_Percent);
    end;
    cH_007_dir_g_2d:
    begin
      Dose_H_007:=CalcDose_H_007(cDetMask_0011);
      Err_H_007:=GetDoseErr(Dose_H_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_H_007_Percent:=GetDoseErrPercent(Dose_H_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_H_007_Percent);
    end;
    cH_007_dir_g_3d:
    begin
      Dose_H_007:=CalcDose_H_007(cDetMask_0111);
      Err_H_007:=GetDoseErr(Dose_H_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_H_007_Percent:=GetDoseErrPercent(Dose_H_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_H_007_Percent);
    end;
    cH_007_dir_g_4d:
    begin
      Dose_H_007:=CalcDose_H_007(cDetMask_1111);
      Err_H_007:=GetDoseErr(Dose_H_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_H_007_Percent:=GetDoseErrPercent(Dose_H_007,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_H_007_Percent);
    end;
    cD_1d:
    begin
      Dose_D:=CalcDose_D(cDetMask_0001);
      Err_D:=GetDoseErr(Dose_D,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_D_Percent:=GetDoseErrPercent(Dose_D,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_D_Percent);
    end;
    cD_2d:
    begin
      Dose_D:=CalcDose_D(cDetMask_0011);
      Err_D:=GetDoseErr(Dose_D,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_D_Percent:=GetDoseErrPercent(Dose_D,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_D_Percent);
    end;
    cD_3d:
    begin
      Dose_D:=CalcDose_D(cDetMask_0111);
      Err_D:=GetDoseErr(Dose_D,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_D_Percent:=GetDoseErrPercent(Dose_D,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_D_Percent);
    end;
    cD_4d:
    begin
      Dose_D:=CalcDose_D(cDetMask_1111);
      Err_D:=GetDoseErr(Dose_D,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_D_Percent:=GetDoseErrPercent(Dose_D,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      K1Err:=GetKErr(K1,Err_D_Percent);
    end;
    cHp_10g_Hp_10n_Hp_007g_Hp_3:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0001);
      Dose_Hp_10n:=CalcDose_Hp_10n(cDetMask_0010);
      Dose_Hp_007:=CalcDose_Hp_007(cDetMask_0100);
      Dose_Hp_3:=CalcDose_Hp_3(cDetMask_1000);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10n:=GetDoseErr(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      Err_Hp_007:=GetDoseErr(Dose_Hp_007,Formula_Val_ErrK1_3,Formula_Val_ErrK2_3);
      Err_Hp_3:=GetDoseErr(Dose_Hp_3,Formula_Val_ErrK1_4,Formula_Val_ErrK2_4);
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_10n_Percent:=GetDoseErrPercent(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      Err_Hp_007_Percent:=GetDoseErrPercent(Dose_Hp_007,Formula_Val_ErrK1_3,Formula_Val_ErrK2_3);
      Err_Hp_3_Percent:=GetDoseErrPercent(Dose_Hp_3,Formula_Val_ErrK1_4,Formula_Val_ErrK2_4);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
      K2Err:=GetKErr(K2,Err_Hp_10g_Percent);
      KgnErr:=GetKErr(Kgn,Err_Hp_10n_Percent);
      K3Err:=GetKErr(K3,Err_Hp_007_Percent);
      K4Err:=GetKErr(K4,Err_Hp_3_Percent);
    end;
    cHp_10g_1d_Hp_007g_1d_Hp_3_1d:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0001);
      Dose_Hp_007:=CalcDose_Hp_007(cDetMask_0010);
      Dose_Hp_3:=CalcDose_Hp_3(cDetMask_0100);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_007:=GetDoseErr(Dose_Hp_007,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      Err_Hp_3:=GetDoseErr(Dose_Hp_3,Formula_Val_ErrK1_3,Formula_Val_ErrK2_3);
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
      Err_Hp_007_Percent:=GetDoseErrPercent(Dose_Hp_007,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      Err_Hp_3_Percent:=GetDoseErrPercent(Dose_Hp_3,Formula_Val_ErrK1_3,Formula_Val_ErrK2_3);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
      K2Err:=GetKErr(K2,Err_Hp_007_Percent);
      K3Err:=GetKErr(K3,Err_Hp_3_Percent);
    end;
    cHp_10g_1d_Hp_007g_1d:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0001);
      Dose_Hp_007:=CalcDose_Hp_007(cDetMask_0010);
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);                   // Не понял всей логики - надо будет потом уточнить
      Err_Hp_007:=GetDoseErr(Dose_Hp_007,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);                   // Не понял всей логики - надо будет потом уточнить
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);    // Не понял всей логики - надо будет потом уточнить
      Err_Hp_007_Percent:=GetDoseErrPercent(Dose_Hp_007,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);    // Не понял всей логики - надо будет потом уточнить
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
      K2Err:=GetKErr(K2,Err_Hp_007_Percent);
    end;
    cHp_10g_2d_Hp_10n_2d_f6776:
    begin
      Dose_Hp_10g:=CalcDose_Hp_10g(cDetMask_0011);
      Dose_Hp_10n:=CalcDose_Hp_10n(cDetMask_1100);                                                   // Не понял всей логики - надо будет потом уточнить
      Err_Hp_10g:=GetDoseErr(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);                   // Не понял всей логики - надо будет потом уточнить
      Err_Hp_10n:=GetDoseErr(Dose_Hp_10n,Formula_Val_ErrK1_3,Formula_Val_ErrK2_3);                   // Не понял всей логики - надо будет потом уточнить
      Err_Hp_10g_Percent:=GetDoseErrPercent(Dose_Hp_10g,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);    // Не понял всей логики - надо будет потом уточнить
      Err_Hp_10n_Percent:=GetDoseErrPercent(Dose_Hp_10n,Formula_Val_ErrK1_2,Formula_Val_ErrK2_2);
      Err_Hp_3_Percent:=GetDoseErrPercent(Dose_Hp_3,Formula_Val_ErrK1_3,Formula_Val_ErrK2_3);
      K1Err:=GetKErr(K1,Err_Hp_10g_Percent);
      K2Err:=GetKErr(K2,Err_Hp_10g_Percent);
      K3Err:=GetKErr(K3,Err_Hp_10n_Percent);
      K4Err:=GetKErr(K4,Err_Hp_10n_Percent);
    end;

  end;
end;

function TDosimeter.CalcErr: double;
var
  i       : integer;
  detCnt  : integer;
  sumErr  : double;
begin
  sumErr:=0;
  detCnt:=0;

  for i := 0 to DetectorsList.Count-1 do
  begin
    if (DetectorsList[i]<>nil) then
    begin
      case TDetector(DetectorsList[i]).State of
        stDetMeasFinished,stDetProcessedWarning,stDetProcessed:
        begin
          inc(detCnt);
          sumErr:=sumErr+TDetector(DetectorsList[i]).Err;
        end
      end;
    end;
  end;

  if detCnt>0 then Result:=RoundToCN((sumErr/detCnt),cAfterComma) else Result:=0;
end;

function TDosimeter.CalcKDos(CalcDose: double; SourceDose: double): double;
begin
  if CalcDose <> 0 then
    Result:=RoundToCN((SourceDose/CalcDose),cAfterComma)
  else
    Result:=-1;
end;

procedure TDosimeter.SkipDetecrorInFormula(det: String);
const
  cComma =',';
var
  _formula : String;
begin
  _formula:=Self.Formula;

  if Pos(det+cComma,_formula) > 0 then
    delete(_formula,Pos(det+cComma,_formula),length(det+cComma))
  else if Pos(cComma+det,_formula) > 0 then
    delete(_formula,Pos(cComma+det,_formula),length(det+cComma))
  else if Pos(det,_formula) > 0 then
    _formula:=cEmptyData;

  Self.Formula:=_formula;
end;

procedure TDosimeter.UpdateOrganization(Value: String);
begin
  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cFieldOrg+' = '+#39+Value+#39+' WHERE '+cFieldDosID+' = '+IntToStr(ID)+' AND '+cFieldDosPostfix+'='+#39+Postfix+#39);
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

procedure TDosimeter.UpdateDepartment(Value: String);
begin
  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cFieldDepartment+' = '+#39+Value+#39+' WHERE '+cFieldDosID+' = '+IntToStr(ID)+' AND '+cFieldDosPostfix+'='+#39+Postfix+#39);
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

procedure TDosimeter.UpdateComment(Value: String);
begin
  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cFieldLastMeasComment+' = '+#39+Value+#39+' WHERE '+cFieldDosID+' = '+IntToStr(ID)+' AND '+cFieldDosPostfix+'='+#39+Postfix+#39);
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

procedure TDosimeter.UpdatePart(Value: String);
var
  val: integer;
begin
  val:=StrToIntRegion(Value);

  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cFieldPartID+' = '+IntToStr(val)+' WHERE '+cFieldDosID+' = '+IntToStr(ID)+' AND '+cFieldDosPostfix+'='+#39+Postfix+#39);
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

procedure TDosimeter.UpdateNumber(Value: String);
var
  val: integer;
begin
  val:=StrToIntRegion(Value);

  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cFieldDosID+' = '+IntToStr(val)+' WHERE '+cFieldDosID+' = '+IntToStr(ID)+' AND '+cFieldDosPostfix+'='+#39+Postfix+#39);
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

procedure TDosimeter.UpdatePostfix(Value: String);
begin
  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cFieldDosPostfix+' = '+#39+Value+#39+' WHERE '+cFieldDosID+' = '+IntToStr(ID)+' AND '+cFieldDosPostfix+'='+#39+Postfix+#39);
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

procedure TDosimeter.UpdateK(Value: String);
var
  val: double;
begin
  val:=StrToFloatRegion(Value);

  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cField_k1+' = '+FloatToStrRegion(val)+' WHERE '+cFieldDosID+' = '+IntToStr(ID)+' AND '+cFieldDosPostfix+'='+#39+Postfix+#39);
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

procedure TDosimeter.UpdateVerDate(Value: TDate);
begin
  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cFieldVerTime+' = '+#39+DateToStr(Value)+#39+' WHERE '+cFieldDosID+' = '+IntToStr(ID)+' AND '+cFieldDosPostfix+'='+#39+Postfix+#39);
    TLDDataModule.ADOQuery.ExecSQL;
  end;
end;

procedure TDosimeter.ReadKFromMeas;
begin
  if TLDDataModule.IsDBConnected then
  begin
      TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
      TLDDataModule.ADOQuery.SQL.Add('SELECT '+cField_k1+','
                                              +cField_k2+','
                                              +cField_k3+','
                                              +cField_k4+','
                                              +cField_k5+','
                                              +cField_kgn+' '
                                              +'FROM '+cDBTableDosRes+' WHERE '+cFieldDosMeasID+' = '+IntToStr(MeasurementID));
      TLDDataModule.ADOQuery.Active:=true;

      K1:=CheckNan(TLDDataModule.ADOQuery,cField_k1);
      K2:=CheckNan(TLDDataModule.ADOQuery,cField_k2);
      K3:=CheckNan(TLDDataModule.ADOQuery,cField_k3);
      K4:=CheckNan(TLDDataModule.ADOQuery,cField_k4);
      K5:=CheckNan(TLDDataModule.ADOQuery,cField_k5);
      Kgn:=CheckNan(TLDDataModule.ADOQuery,cField_kgn);

//      K1:=TLDDataModule.ADOQuery.FieldByName(cField_k1).AsInteger;
//      K2:=TLDDataModule.ADOQuery.FieldByName(cField_k2).AsInteger;
//      K3:=TLDDataModule.ADOQuery.FieldByName(cField_k3).AsInteger;
//      K4:=TLDDataModule.ADOQuery.FieldByName(cField_k4).AsInteger;
//      K5:=TLDDataModule.ADOQuery.FieldByName(cField_k5).AsInteger;
//      Kgn:=TLDDataModule.ADOQuery.FieldByName(cField_kgn).AsInteger;
  end;
end;

procedure TDosimeter.RecalcAllDetectorsDose;
var
  i: integer;
begin
  for i := 0 to DetectorsList.Count-1 do
  begin
    if Assigned(DetectorsList[i]) then
      CalcDetectorDose(i+1);
  end;
end;

procedure TDosimeter.ReadKFromDosimeter;
begin
  if TLDDataModule.IsDBConnected then
  begin
    TLDDataModule.ADOQuery.SQL.Clear; // очистить текст sql
    TLDDataModule.ADOQuery.SQL.Add('SELECT '+cField_k1+','
                                            +cField_k2+','
                                            +cField_k3+','
                                            +cField_k4+','
                                            +cField_k5+','
                                            +cField_kgn+' '
                                            +'FROM '+cDBTableDosID+' WHERE '+cFieldDosID+' = '+IntToStr(ID)+' AND '+cFieldDosPostfix+'='+#39+Postfix+#39);
    TLDDataModule.ADOQuery.Active:=true;

//      K1:=TLDDataModule.ADOQuery.FieldByName(cField_k1).AsFloat;
//      K2:=TLDDataModule.ADOQuery.FieldByName(cField_k2).AsFloat;
//      K3:=TLDDataModule.ADOQuery.FieldByName(cField_k3).AsFloat;
//      K4:=TLDDataModule.ADOQuery.FieldByName(cField_k4).AsFloat;
//      K5:=TLDDataModule.ADOQuery.FieldByName(cField_k5).AsFloat;
//      Kgn:=TLDDataModule.ADOQuery.FieldByName(cField_kgn).AsFloat;

    K1:=CheckNan(TLDDataModule.ADOQuery,cField_k1);
    K2:=CheckNan(TLDDataModule.ADOQuery,cField_k2);
    K3:=CheckNan(TLDDataModule.ADOQuery,cField_k3);
    K4:=CheckNan(TLDDataModule.ADOQuery,cField_k4);
    K5:=CheckNan(TLDDataModule.ADOQuery,cField_k5);
    Kgn:=CheckNan(TLDDataModule.ADOQuery,cField_kgn);
  end;
end;

procedure TDosimeter.SetDepartment(aDepartment: String);
begin
  FDepartment:=aDepartment;
  OnChangeDepartment(Self);
end;

procedure TDosimeter.SetDetsState(State: TDetectorState);
var
  i : integer;
begin
  for i := 0 to DetectorsList.Count-1 do
  begin
    if DetectorsList[i] <> nil then TDetector(DetectorsList[i]).State := State;
  end;
end;

procedure TDosimeter.SetDetTemProfile(aDetector: TDetector; aTempProfile: String);
var
  i                 : integer;
  tempProfileList   : TStringList;
begin
  tempProfileList:=TStringList.Create;
  tempProfileList.Delimiter:=',';               // устанавливаем разделитель
  tempProfileList.DelimitedText:=aTempProfile;  // записываем массив в строку
  tempProfileList.Text:=StringReplace(tempProfileList.Text,'{','',[rfreplaceall]);       // удаляем фигурные скобки
  tempProfileList.Text:=StringReplace(tempProfileList.Text,'}','',[rfreplaceall]);       //

  if tempProfileList.Count>0 then
  begin
    for i := 0 to tempProfileList.Count-1 do                                  // выводим в TChart
    begin
      aDetector.TempProfile[i]:=StrToInt(tempProfileList[i]);
    end;
  end;

  tempProfileList.Free;
end;

procedure TDosimeter.SetLastMeasComment(Value: String);
begin
  FLastMeasComment:=Value;
  OnChangeLastMeasComment(Self);
end;

procedure TDosimeter.SetLastMeasResult(Value: TDosimeterValidity);
begin
  FLastMeasResult:=Value;
  OnChangeLastMeasResult(Self);
end;

procedure TDosimeter.SetLastMeasTime(Value: TDateTime);
begin
  FLastMeasTime:=Value;
  OnChangeLastMeasTime(Self);
end;

procedure TDosimeter.SetDose_Hp_10g(Value: double);
begin
  FDose_Hp_10g:=Value;
//  FErr_Hp_10g:=GetDoseErr(Value,Formula_Val_ErrK1_1,Formula_Val_ErrK2_1);
  if Assigned(Doses) AND not IsNan(Value) AND (not Doses.IsExistValue(cHp_10g)) then
  begin
    Doses.Add(cHp_10g,Value);
//    OnChangeDose(Self);
  end
  else
  if Doses.IsExistValue(cHp_10g) then
    Doses.Update(cHp_10g,Value);

  OnChangeDose(Self);
end;

procedure TDosimeter.SetDose_Hp_10n(Value: double);
begin
  FDose_Hp_10n:=Value;
  if Assigned(Doses) AND not IsNan(Value) AND (not Doses.IsExistValue(cHp_10n)) then
  begin
    Doses.Add(cHp_10n,Value);
//    OnChangeDose(Self);
  end
  else
  if Doses.IsExistValue(cHp_10n) then
    Doses.Update(cHp_10n,Value);

  OnChangeDose(Self);
end;

procedure TDosimeter.SetDose_Hp_3(Value: double);
begin
  FDose_Hp_3:=Value;
  if Assigned(Doses) AND not IsNan(Value) AND (not Doses.IsExistValue(cHp_3)) then
  begin
    Doses.Add(cHp_3,Value);
//    OnChangeDose(Self);
  end
  else
  if Doses.IsExistValue(cHp_3) then
    Doses.Update(cHp_3,Value);

  OnChangeDose(Self);
end;

procedure TDosimeter.SetDose_Hp_007(Value: double);
begin
  FDose_Hp_007:=Value;
  if Assigned(Doses) AND not IsNan(Value) AND (not Doses.IsExistValue(cHp_007)) then
  begin
    Doses.Add(cHp_007,Value);
//    OnChangeDose(Self);
  end
  else
  if Doses.IsExistValue(cHp_007) then
    Doses.Update(cHp_007,Value);

  OnChangeDose(Self);
end;

procedure TDosimeter.SetDose_H_star(Value: double);
begin
  FDose_H_star:=Value;
  if Assigned(Doses) AND not IsNan(Value) AND (not Doses.IsExistValue(cH_star)) then
  begin
    Doses.Add(cH_star,Value);
//    OnChangeDose(Self);
  end
  else
  if Doses.IsExistValue(cH_star) then
    Doses.Update(cH_star,Value);

  OnChangeDose(Self);
end;

procedure TDosimeter.SetDose_H_007(Value: double);
begin
  FDose_H_007:=Value;
  if Assigned(Doses) AND not IsNan(Value) AND (not Doses.IsExistValue(cH_007_dir)) then
  begin
    Doses.Add(cH_007_dir,Value);
//    OnChangeDose(Self);
  end
  else
  if Doses.IsExistValue(cH_007_dir) then
    Doses.Update(cH_007_dir,Value);

  OnChangeDose(Self);
end;

procedure TDosimeter.SetDose_D(Value: double);
begin
  FDose_D:=Value;
  if Assigned(Doses) AND not IsNan(Value) AND (not Doses.IsExistValue(cD)) then
  begin
    Doses.Add(cD,Value);
//    OnChangeDose(Self);
  end
  else
  if Doses.IsExistValue(cD) then
    Doses.Update(cD,Value);

  OnChangeDose(Self);
end;

procedure TDosimeter.SetDosPart(Value: integer);
begin
  FPartID:=Value;
  OnChangeDosPart(Self);
end;

procedure TDosimeter.SetDosPartName(const Value: String);
begin
  FPartName := Value;
end;

procedure TDosimeter.SetDosType(aDosType: String);
begin
  FDosType:=aDosType;
  OnChangeDoseType(Self);
end;

procedure TDosimeter.SetError(aError: String);
begin
  FError:=aError;
  OnChangeErr(Self);
end;

procedure TDosimeter.SetErr_D(const Value: double);
begin
  FErr_D:=Value;
end;
procedure TDosimeter.SetErr_Hp_007(const Value: double);
begin
  FErr_Hp_007:=Value;
end;

procedure TDosimeter.SetErr_Hp_10g(const Value: double);
begin
  FErr_Hp_10g:=Value;
end;

procedure TDosimeter.SetErr_Hp_10n(const Value: double);
begin
  FErr_Hp_10n:=Value;
end;

procedure TDosimeter.SetErr_Hp_3(const Value: double);
begin
  FErr_Hp_3:=Value;
end;

procedure TDosimeter.SetErr_H_007(const Value: double);
begin
  FErr_H_007:=Value;
end;

procedure TDosimeter.SetErr_H_star(const Value: double);
begin
  FErr_H_star:=Value;
end;

procedure TDosimeter.SetFio(aFio: String);
begin
  FFio:=aFio;
  OnChangeFIO(Self);
end;

procedure TDosimeter.SetFormula(aFormula: String);
begin
  FFormula:=aFormula;
  OnChangeFormula(Self);
end;

procedure TDosimeter.SetFormulaID(aFormulaID: integer);
begin
  FFormulaID:=aFormulaID;
  OnChangeFormulaID(Self);
end;

procedure TDosimeter.SetFormulaID_Val_1(aFormulaID_Val_1: integer);
begin
  FFormulaID_Val_1:=aFormulaID_Val_1;
end;

procedure TDosimeter.SetFormulaID_Val_2(aFormulaID_Val_2: integer);
begin
  FFormulaID_Val_2:=aFormulaID_Val_2;
end;

procedure TDosimeter.SetFormulaID_Val_3(aFormulaID_Val_3: integer);
begin
  FFormulaID_Val_3:=aFormulaID_Val_3;
end;

procedure TDosimeter.SetFormulaID_Val_4(aFormulaID_Val_4: integer);
begin
  FFormulaID_Val_4:=aFormulaID_Val_4;
end;

procedure TDosimeter.SetFormula_Val_ErrK1_1(const Value: double);
begin
  FFormula_Val_ErrK1_1:=Value;
end;

procedure TDosimeter.SetFormula_Val_ErrK1_2(const Value: double);
begin
  FFormula_Val_ErrK1_2:=Value;
end;

procedure TDosimeter.SetFormula_Val_ErrK1_3(const Value: double);
begin
  FFormula_Val_ErrK1_3:=Value;
end;

procedure TDosimeter.SetFormula_Val_ErrK1_4(const Value: double);
begin
  FFormula_Val_ErrK1_4:=Value;
end;

procedure TDosimeter.SetFormula_Val_ErrK2_1(const Value: double);
begin
  FFormula_Val_ErrK2_1 := Value;
end;

procedure TDosimeter.SetFormula_Val_ErrK2_2(const Value: double);
begin
  FFormula_Val_ErrK2_2 := Value;
end;

procedure TDosimeter.SetFormula_Val_ErrK2_3(const Value: double);
begin
  FFormula_Val_ErrK2_3 := Value;
end;

procedure TDosimeter.SetFormula_Val_ErrK2_4(const Value: double);
begin
  FFormula_Val_ErrK2_4 := Value;
end;

procedure TDosimeter.SetNumber(const Value: integer);
begin
  FID:=Value;
  OnChangeNumber(Self);
end;

procedure TDosimeter.SetPostfix(const Value: String);
begin
  FPostfix:=Value;
  OnChangePostfix(Self);
end;

procedure TDosimeter.SetFullNumber(const Value: String);
begin
  FFullNumber:=Value;
  OnChangeFullNumber(Self);
end;

procedure TDosimeter.SetK1(Value: double);
begin
  FK1:=Value;

  if Assigned(Coefficients) AND (not IsNan(Value)) AND (not Coefficients.IsExistValue(cField_k1)) then
  begin
    Coefficients.Add(cField_k1,Value);
    OnChangeK(Self);
  end;
end;

procedure TDosimeter.SetK1Err(Value: double);
begin
  FK1Err:=Value;
end;

procedure TDosimeter.SetK2(Value: double);
begin
  FK2:=Value;

  if Assigned(Coefficients) AND (not IsNan(Value)) AND (not Coefficients.IsExistValue(cField_k2)) then
  begin
    Coefficients.Add(cField_k2,Value);
    OnChangeK(Self);
  end;
end;

procedure TDosimeter.SetK2Err(Value: double);
begin
  FK2Err:=Value;
end;

procedure TDosimeter.SetK3(Value: double);
begin
  FK3:=Value;

  if Assigned(Coefficients) AND (not IsNan(Value)) AND (not Coefficients.IsExistValue(cField_k3)) then
  begin
    Coefficients.Add(cField_k3,Value);
    OnChangeK(Self);
  end;
end;

procedure TDosimeter.SetK3Err(Value: double);
begin
  FK3Err:=Value;
end;

procedure TDosimeter.SetK4(Value: double);
begin
  FK4:=Value;

  if Assigned(Coefficients) AND (not IsNan(Value)) AND (not Coefficients.IsExistValue(cField_k4)) then
  begin
    Coefficients.Add(cField_k4,Value);
    OnChangeK(Self);
  end;
end;

procedure TDosimeter.SetK4Err(Value: double);
begin
  FK4Err:=Value;
end;

procedure TDosimeter.SetK5(Value: double);
begin
  FK5:=Value;

  if Assigned(Coefficients) AND (not IsNan(Value)) AND (not Coefficients.IsExistValue(cField_k5)) then
  begin
    Coefficients.Add(cField_k5,Value);
    OnChangeK(Self);
  end;
end;

procedure TDosimeter.SetK5Err(Value: double);
begin
  FK5Err:=Value;
end;

procedure TDosimeter.SetKDevice(Value: double);
begin
  FKDevice:=Value;
  //OnChangeKDevice(Self);
end;

procedure TDosimeter.SetKgn(Value: double);
begin
  FKgn:=Value;

  if Assigned(Coefficients) AND (not IsNan(Value)) AND (not Coefficients.IsExistValue(cField_kgn)) then
  begin
    Coefficients.Add(cField_kgn,Value);
    OnChangeK(Self);
  end;
end;

procedure TDosimeter.SetKgnErr(Value: double);
begin
  FKgnErr:=Value;
end;

procedure TDosimeter.SetKFilter(Value: double);
begin
  FKFilter:=Value;
  OnChangeKFilter(Self);
end;

procedure TDosimeter.SetKS(Value: integer);
begin
  FKS:=Value;
  OnChangeKS(Self);
end;

procedure TDosimeter.SetMeasComment(Value: String);
begin
  FMeasComment:=Value;
  OnChangeMeasComment(Self);
end;

procedure TDosimeter.SetMeasID(aMeasID: integer);
begin
  FMeasurementID:=aMeasID;
end;

procedure TDosimeter.SetMeasTime(aMeasTime: TDateTime);
begin
  FMeasTime:=aMeasTime;
  OnChangeMeasTime(Self);
end;

procedure TDosimeter.SetMeasValues(Value: String);
begin
  FMeasValues:=Value;
  OnChangeMeasValues(Self);
end;

procedure TDosimeter.SetOnChangeLastMeasComment(Sender: TOnChangeLastMeasComment);
begin
  FOnChangeLastMeasComment:=Sender;
  OnChangeLastMeasComment(Self);
end;

procedure TDosimeter.SetOnChangeLastMeasResult(Sender: TOnChangeLastMeasResult);
begin
  FOnChangeLastMeasResult:=Sender;
  OnChangeLastMeasResult(Self);
end;

procedure TDosimeter.SetOnChangeLastMeasTime(Sender: TOnChangeLastMeasTime);
begin
  FOnChangeLastMeasTime:=Sender;
  OnChangeLastMeasTime(Self);
end;

procedure TDosimeter.SetOnChangeDoseType(Sender: TOnChangeDoseType);
begin
  FOnChangeDoseType:=Sender;
end;

procedure TDosimeter.SetOnChangeDosPart(Sender: TOnChangeDosPart);
begin
  FOnChangeDosPart:=Sender;
end;

procedure TDosimeter.SetOnChangeDepartment(Sender: TOnChangeDepartment);
begin
  FOnChangeDepartment:=Sender;
end;

procedure TDosimeter.SetOnChangeDose(Sender: TOnChangeDose);
begin
  FOnChangeDose:=Sender;
end;

procedure TDosimeter.SetOnChangeErr(Sender: TOnChangeErr);
begin
  FOnChangeErr:=Sender;
end;

procedure TDosimeter.SetOnChangeFIO(Sender: TOnChangeFIO);
begin
  FOnChangeFIO:=Sender;
end;

procedure TDosimeter.SetOnChangeFormula(Sender: TOnChangeFormula);
begin
  FOnChangeFormula:=Sender;
  OnChangeFormula(Self);
end;

procedure TDosimeter.SetOnChangeFormulaID(Sender: TOnChangeFormulaID);
begin
  FOnChangeFormulaID:=Sender;
  OnChangeFormulaID(Self);
end;

procedure TDosimeter.SetOnChangeKFilter(Sender: TOnChangeKFilter);
begin
  FOnChangeKFilter:=Sender;
end;

procedure TDosimeter.SetOnChangeK(Sender: TOnChangeK);
begin
  FOnChangeK:=Sender;
end;

procedure TDosimeter.SetOnChangeKDevice(Sender: TOnChangeKDevice);
begin
  FOnChangeKDevice:=Sender;
end;

procedure TDosimeter.SetOnChangeKS(Sender: TOnChangeKS);
begin
  FOnChangeKS:=Sender;
end;

procedure TDosimeter.SetOnChangeMeasComment(Sender: TOnChangeMeasComment);
begin
  FOnChangeMeasComment:=Sender;
end;

procedure TDosimeter.SetOnChangeMeasTime(Sender: TOnChangeMeasTime);
begin
  FOnChangeMeasTime:=Sender;
end;

procedure TDosimeter.SetOnChangeMeasValues(Sender: TOnChangeMeasValues);
begin
  FOnChangeMeasValues:=Sender;
end;

procedure TDosimeter.SetOnChangeNumber(Sender: TOnChangeNumber);
begin
  FOnChangeNumber:=Sender;
end;

procedure TDosimeter.SetOnChangePostfix(Sender: TOnChangePostfix);
begin
  FOnChangePostfix:=Sender;
end;

procedure TDosimeter.SetOnChangeRegTime(Sender: TOnChangeRegTime);
begin
  FOnChangeRegTime:=Sender;
end;

procedure TDosimeter.SetOnChangeFullNumber(Sender: TOnChangeFullNumber);
begin
  FOnChangeFullNumber:=Sender;
end;

procedure TDosimeter.SetOnChangeOrganization(Sender: TOnChangeOrganization);
begin
  FOnChangeOrganization:=Sender;
end;

procedure TDosimeter.SetOnChangePersNumber(Sender: TOnChangePersNumber);
begin
  FOnChangePersNumber:=Sender;
end;

procedure TDosimeter.SetOnChangeStatus(Sender: TOnChangeStatus);
begin
  FOnChangeStatus:=Sender;
end;

procedure TDosimeter.SetOnChangeValidity(Sender: TOnChangeValidity);
begin
  FOnChangeValidity:=Sender;
end;

procedure TDosimeter.SetOnChangeVerTime(Sender: TOnChangeVerTime);
begin
  FOnChangeVerTime:=Sender;
end;

procedure TDosimeter.SetOnShowTempProfileWrite(Sender: TOnShowTempProfileWrite);
begin
  FOnShowTempProfileWrite:=Sender;
end;

procedure TDosimeter.SetOrganization(aOrganization: String);
begin
  FOrganization:=aOrganization;
  OnChangeOrganization(Self);
end;

procedure TDosimeter.SetPersNumber(aPersNumber: integer);
begin
  FPersNumber:=aPersNumber;
  OnChangePersNumber(Self);
end;

procedure TDosimeter.SetSoftwareVer(aSoftwareVer: integer);
begin
  FSoftwareVer:=aSoftwareVer;
end;

procedure TDosimeter.SetStatus(aStatus: TDosimeterStatus);
begin
  FStatus:=aStatus;
  OnChangeStatus(Self);
end;

procedure TDosimeter.SetTldUser(aTldUser: String);
begin
  FTldUser:=aTldUser;
end;

procedure TDosimeter.SetValidity(aValidity: TDosimeterValidity);
begin
  FValidity:=aValidity;
  OnChangeValidity(Self);
end;

procedure TDosimeter.SetVerTime(aVerTime: TDateTime);
begin
  FVerTime:=aVerTime;
  OnChangeVerTime(Self);
end;

procedure TDosimeter.SetRegTime(aRegTime: TDateTime);
begin
  FRegTime:=aRegTime;
  OnChangeRegTime(Self);
end;

procedure TDosimeter.SetEcc1(Value: double);
begin
  FEcc1:=Value;
end;

procedure TDosimeter.SetEcc2(Value: double);
begin
  FEcc2:=Value;
end;

procedure TDosimeter.SetEcc3(Value: double);
begin
  FEcc3:=Value;
end;

procedure TDosimeter.SetEcc4(Value: double);
begin
  FEcc4:=Value;
end;

destructor TDosimeter.Destroy;
begin
  DetectorsList.Free;
  inherited;
end;

function TDosimeter.GetDoseErr(Dose,Err_k1,Err_k2: double): double;
const
  c100 = 100;
var
  errPercent: double;
begin
  if (not Dose.IsNan) AND (Dose<>0) then
    errPercent:=Err_k1/Dose+Err_k2
  else
    errPercent:=0;

  Result:=RoundToCN((Dose*(errPercent/c100)),cAfterComma);
end;

function TDosimeter.GetDoseErrPercent(Dose, Err_k1, Err_k2: double): double;
var
  errPercent: double;
begin
  if (not Dose.IsNan) AND (Dose<>0) then
    errPercent:=RoundToCN((Err_k1/Dose+Err_k2),1)
  else
    errPercent:=0;

  Result:=errPercent;
end;

function TDosimeter.GetKErr(K,Percent: double): double;
const
  c100 = 100;
begin
  Result:=RoundToCN((K*Percent)/c100,cAfterComma);
end;

function TDosimeter.GetDosimeterValidity: TDosimeterValidity;
var
  i                       : integer;
  cntDetProcessed         : integer;
  cntDetProcessedWarning  : integer;
  cntDetProcessedError    : integer;
  cntDetSkiped            : integer;
  cntDetNotMeasured       : integer;
  cntDet                  : integer;
begin

  cntDetProcessed:=0;
  cntDetProcessedWarning:=0;
  cntDetProcessedError:=0;
  cntDetSkiped:=0;
  cntDetNotMeasured:=0;
  cntDet:=0;

  Result:=stDosNotMeasured;

  for i := 0 to DetectorsList.Count-1 do
  begin
    if DetectorsList[i] <> nil then
    begin
      case TDetector(DetectorsList[i]).State of
        stDetProcessed:
        begin
          inc(cntDetProcessed);
        end;
        stDetProcessedError:
        begin
          inc(cntDetProcessedError);
        end;
        stDetProcessedWarning:
        begin
          inc(cntDetProcessedWarning);
        end;
        stDetLost,stDetBroken,stDetSkiped:
        begin
          inc(cntDetSkiped);
        end;
        stDetNotMeasured,stDetWaitLoad,stDetWaitMeas,stDetMeasInProgress,stDetMeasStopped:
        begin
          inc(cntDetNotMeasured);
        end;

      end;

      inc(cntDet);

    end;
  end;

  // переделать в битовое поле

  //if (cntDetProcessedError > 0) AND (cntDetProcessed = 0) then
  if cntDetProcessedError > 0 then
  begin
    Result:=stDosMeasError;
    exit;
  end;

  if cntDetProcessed = cntDet then
  begin
    Result:=stDosMeasFinished;
    exit;
  end;

  if (cntDetProcessedWarning > 0) OR (cntDetSkiped > 0) OR (cntDetProcessed > 0) then
  begin
    Result:=stDosMeasWarning;
    exit;
  end;

  if cntDetNotMeasured > 0 then
  begin
    Result:=stDosNotMeasured;
    exit;
  end;

end;

function TDosimeter.GetMeasValList: TStringList;
var
  i      : integer;
  ts     : TStringList;
begin
  Result:=TStringList.Create;

  if MeasValues <> '' then
  begin
    ts:=TStringList.Create;
    ts.Delimiter:=',';
    ts.DelimitedText:=MeasValues;

    if ts.Count>0 then
    begin
      for i := 0 to ts.Count-1 do                             // выводим в TChart
      begin
        Result.Add(ts[i]);
      end;
    end;

    ts.Free;
  end;

// из таблицы детекторов - пока не актуально
//  for i := 0 to DetectorsList.Count-1 do
//  begin
//    if Assigned(DetectorsList[i]) then
//    begin
//      if Result.IndexOf(TDetector(DetectorsList[i]).MeasValue) = -1 then
//        Result.Add(TDetector(DetectorsList[i]).MeasValue);
//    end;
//  end;








//var
//  i      : integer;
//  ts     : TStringList;
//begin
//  if aData<>'{}' then
//  begin
//    ts:=TStringList.Create;
//    ts.Delimiter:=',';                                        // устанавливаем разделитель
//    ts.DelimitedText:=aData;
//    ts.Text:=StringReplace(ts.Text,'{','',[rfreplaceall]);    // удаляем фигурные скобки
//    ts.Text:=StringReplace(ts.Text,'}','',[rfreplaceall]);
//
//    aChart.Series[aSeriea].Clear; // очищаем чарт
//    aChart.Title.Text.Text := 'Дозиметр - '+aDosimeterID;
//
//    if ts.Count>0 then
//    begin
//      for i := 0 to ts.Count-1 do                             // выводим в TChart
//      begin
//        aChart.Series[aSeriea].AddXY(i,StrToFloatRegion(ts[i]));
//      end;
//    end;
//
//    ts.Free;
//
//  end;



end;

function TDosimeter.GetStringStatus: String;
begin
  case FStatus of
    stDosCalibrated:
    begin
      result:=rsDosCalibrated;
    end;
    stDosNotCalibrated:
    begin
      result:=rsDosNotCalibrated;
    end;
    stDosDecommissioned:
    begin
      result:=rsDosDecommissioned;
    end;
  end;
end;

function TDosimeter.GetIntValidity: integer;
begin
  case Validity of
    stDosNotMeasured: Result:=cDosNotMeasured;
    stDosWaitLoad: Result:=cDosWaitLoad;
    stDosWaitMeasD1: Result:=cDosWaitMeasD1;
    stDosWaitMeasD2: Result:=cDosWaitMeasD2;
    stDosWaitMeasD3: Result:=cDosWaitMeasD3;
    stDosWaitMeasD4: Result:=cDosWaitMeasD4;
    stDosMeasInProgressD1: Result:=cDosMeasInProgressD1;
    stDosMeasInProgressD2: Result:=cDosMeasInProgressD2;
    stDosMeasInProgressD3: Result:=cDosMeasInProgressD3;
    stDosMeasInProgressD4: Result:=cDosMeasInProgressD4;
    stDosMeasFinishedD1: Result:=cDosMeasFinishedD1;
    stDosMeasFinishedD2: Result:=cDosMeasFinishedD2;
    stDosMeasFinishedD3: Result:=cDosMeasFinishedD3;
    stDosMeasFinishedD4: Result:=cDosMeasFinishedD4;
    stDosMeasErrorD1: Result:=cDosMeasErrorD1;
    stDosMeasErrorD2: Result:=cDosMeasErrorD2;
    stDosMeasErrorD3: Result:=cDosMeasErrorD3;
    stDosMeasErrorD4: Result:=cDosMeasErrorD4;
    stDosMeasStoppedD1: Result:=cDosMeasStoppedD1;
    stDosMeasStoppedD2: Result:=cDosMeasStoppedD2;
    stDosMeasStoppedD3: Result:=cDosMeasStoppedD3;
    stDosMeasStoppedD4: Result:=cDosMeasStoppedD4;
    stDosMeasWarning: Result:=cDosMeasWarning;
    stDosMeasError: Result:=cDosMeasError;
    stDosMeasFinished: Result:=cDosMeasFinished;
    stDosMeasAccepted: Result:=cDosMeasAccepted;
    stDosMeasUserWarning: Result:=cDosMeasUserWarning
    else
      Result:=cDosNotMeasured;
  end;
end;

function TDosimeter.ReadCntDetector: TDetector;
begin
  result := TDetector(DetectorsList[DetectorsCnt]);
end;

{ TCoefficients }

procedure TCoefficients.Add(aName: String; Value: double);
var
  kh    : TCoefficient;
  index : integer;
begin
  kh.Name:=aName;
  kh.Value:=Value;

  index:=Length(CoefficientArray);
  SetLength(CoefficientArray,index+1);
  CoefficientArray[index]:=kh;
end;

procedure TCoefficients.Drop;
begin
  SetLength(CoefficientArray,0);
end;

function TCoefficients.IsExistValue(Value: String): boolean;
var
  i       : integer;
  isExist : boolean;
begin
  isExist:=false;

  for i := 0 to Length(CoefficientArray)-1 do
  begin
    if CoefficientArray[i].Name = Value then
    begin
      isExist:=true;
      break;
    end;
  end;

  Result:=isExist;
end;

{ TDoses }

procedure TDoses.Add(aName: String; Value: double);
var
  dose  : TDose;
  index : integer;
begin
  dose.Name:=aName;
  dose.Value:=Value;

  index:=Length(DoseArray);
  SetLength(DoseArray,index+1);
  DoseArray[index]:=dose;
end;

procedure TDoses.Update(aName: String; Value: double);
var
  i       : integer;
begin
  for i := 0 to Length(DoseArray)-1 do
  begin
    if DoseArray[i].Name=aName then
      DoseArray[i].Value:=Value;
  end;
end;

procedure TDoses.Drop;
begin
  SetLength(DoseArray,0);
end;

function TDoses.GetStringValue: String;
var
  i           : integer;
  outString   : String;
begin
  outString:='';

  for i := 0 to Length(DoseArray)-1 do
  begin
    if i = Length(DoseArray)-1 then
      outString:=outString + DoseArray[i].Name+'='+FloatToStrRegion(RoundToCN(DoseArray[i].Value,cAfterComma)){+' '+rsUntmSv}
    else
      outString:=outString + DoseArray[i].Name+'='+FloatToStrRegion(RoundToCN(DoseArray[i].Value,cAfterComma)){+' '+rsUntmSv}+'; ';
  end;

  Result:=outString;
end;

function TDoses.IsExistValue(Value: String): boolean;
var
  i       : integer;
  isExist : boolean;
begin
  isExist:=false;

  for i := 0 to Length(DoseArray)-1 do
  begin
    if DoseArray[i].Name = Value then
    begin
      isExist:=true;
      break;
    end;
  end;

  Result:=isExist;
end;

end.
