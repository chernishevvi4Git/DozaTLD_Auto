unit
  uDetector;

interface

uses
  Classes,
  SysUtils,
  StdCtrls,
  uConst,
  uLanguages;


const
  cMaxChannels = 299;

type
  TTempProfile = array [0..301] of integer;
  TDetectorState = (stDetNotMeasured,
                    stDetWaitLoad,
                    stDetWaitMeas,
                    stDetMeasInProgress,
                    stDetMeasFinished,
                    stDetMeasError,
                    stDetLost,
                    stDetBroken,
                    stDetSkiped,
                    stDetMeasStopped,
                    stDetProcessedError,
                    stDetProcessedWarning,
                    stDetProcessed,
                    stDetAcceptedError,
                    stDetAcceptedWarning,
                    stDetAccepted);

  TOnChangeDetState = procedure(Sender: TObject) of object;
  TOnChangeDetDose = procedure(Sender: TObject) of object;
  TOnChangeDetLightSum = procedure(Sender: TObject) of object;
  TOnChangeDetErr = procedure(Sender: TObject) of object;
  TOnChangeDetComment = procedure(Sender: TObject) of object;
  TOnChangeDetTypeComment = procedure(Sender: TObject) of object;
  TOnChangeDetType = procedure(Sender: TObject) of object;
  TOnShowData = procedure(Sender: TObject) of object;
  TOnDetectorProcerssing = procedure (Sender: TObject) of object;

  TDetector = class(TComponent)
    private
      SaveDBParameters        : String;

      FType                   : String;                               // назвение детектора
      FTypeID                 : integer;                              // ID-типа детектора
      FMeasValue              : String;                               // измеряемая величина
      FKName                  : String;                               // название коэффициента
      FMethod                 : String;                               // метод обработки
      FKtv                    : String;
      FTmp                    : String;
      FTmpWrite               : String;
      FFon                    : String;
      FGaus                   : String;
      FDose                   : double;
      FErr                    : double;
      //FLightSum               : integer;
      FLightSum               : int64;
      FComment                : String;
      FDetTypeComment         : String;
      FBt                     : double;
      FBx0                    : double;
      FBy0                    : double;
      FBxy0                   : double;
      FBdy                    : double;
      FGm1                    : double;
      FGa1                    : double;
      FGsl                    : double;
      FDgm2                   : double;
      FDga2                   : double;
      FGsr                    : double;
      FN1                     : double;
      FN2                     : double;
      FBN1                    : double;
      FBN1_width              : double;
      FBN2                    : double;
      FBN2_width              : double;
      FSA4                    : double;
      FSA5                    : double;
      FS                      : double;
      FK1Profile              : double;
      FK2Profile              : double;
      FPeakFound              : boolean;
      FFonFound               : boolean;
      FAutoProcessing         : boolean;
      FState                  : TDetectorState;
      FOnChangeState          : TOnChangeDetState;
      FOnChangeDose           : TOnChangeDetDose;
      FOnChangeLightSum       : TOnChangeDetLightSum;
      FOnChangeErr            : TOnChangeDetErr;
      FOnChangeComment        : TOnChangeDetComment;
      FOnChangeDetTypeComment : TOnChangeDetTypeComment;
      FOnChangeType           : TOnChangeDetType;
      FOnShowData             : TOnShowData;
      FOnDetectorProcerssing  : TOnDetectorProcerssing;
      procedure SetType(const Value: String);
      procedure SetTypeID(const Value: integer);
      procedure SetMeasValue(const Value: String);
      procedure SetKName(const Value: String);
      procedure SetKtv(const Value: String);
      procedure SetTmp(const Value: String);
      procedure SetTmpWrite(const Value: String);
      procedure SetFon(const Value: String);
      procedure SetGaus(const Value: String);
      procedure SetDose(const Value: double);
      //procedure SetLightSum(const Value: integer);
      procedure SetLightSum(const Value: int64);
      procedure SetErr(const Value: double);
      procedure SetComment(const Value: String);
      procedure SetMethod(const Value: String);
      procedure SetDetTypeComment(const Value: String);

      procedure SetBt(const Value: double);
      procedure SetBx0(const Value: double);
      procedure SetBy0(const Value: double);
      procedure SetBxy0(const Value: double);
      procedure SetBdy(const Value: double);
      procedure SetGm1(const Value: double);
      procedure SetGa1(const Value: double);
      procedure SetGsl(const Value: double);
      procedure SetDgm2(const Value: double);
      procedure SetDga2(const Value: double);
      procedure SetGsr(const Value: double);
      procedure SetN1(const Value: double);
      procedure SetN2(const Value: double);
      procedure SetSA4(const Value: double);
      procedure SetSA5(const Value: double);
      procedure SetS(const Value: double);
      procedure SetK1Profile(const Value: double);
      procedure SetK2Profile(const Value: double);
      procedure SetPeakFound(const Value: boolean);
      procedure SetFonFound(const Value: boolean);
      procedure SetAutoProcessing(const Value: boolean);
      procedure SetState(const Value: TDetectorState);
      procedure SetOnChangeState(Sender: TOnChangeDetState);
      procedure SetOnChangeDose(Sender: TOnChangeDetDose);
      procedure SetOnChangeLightSum(Sender: TOnChangeDetLightSum);
      procedure SetOnChangeErr(Sender: TOnChangeDetErr);
      procedure SetOnChangeComment(Sender: TOnChangeDetComment);
      procedure SetOnChangeDetTypeComment(Sender: TOnChangeDetTypeComment);
      procedure SetOnChangeType(Sender: TOnChangeDetType);
      procedure SetOnShowData(Sender: TOnShowData);
      procedure SetOnDetectorProcerssing(Sender: TOnDetectorProcerssing);

    protected

    public
      Position          : integer;                                //  позиция детектора в дозиметре
      Use               : boolean;                                //  использовать при измерениях
      TempProfile       : TTempProfile;                           //  профиль нагрева считанный из таблицы типов детекторов
      //BuffPulses        : array [0 .. cMaxChannels] of integer;   //  массив исходных импульсов
      BuffPulses        : array [0 .. cMaxChannels] of int64;     //  массив исходных импульсов
      MeasureTime       : TDateTime;                              //  время измерения
      IsReadFromDB      : boolean;                                //  признак считан ли результат из БД или только что рассчитан
      Parent            : TComponent;
      KTV_Buff          : array [0..cMaxChannels] of int64;
      Temp_Buff         : array [0..cMaxChannels] of integer;
      ReadedPoints      : integer;
      constructor Create(DetType: String; DetTypeID: integer; aPosition: integer; AOwner: TComponent); reintroduce;
      destructor Destroy; override;

//  подготовка к сериализации в СУБД (перспектива удобства работы с разными типами дозиметров и детекторов)
      procedure Serialize;  // Записать в строку SaveDBParameters все паблишед свойства детектора (а потом его потомков)
      procedure Deerialize; // Считать из строки SaveDBParameters все паблишед свойства детектора (а потом его потомков)

      function GetMeasValFromFormula: String;
      function GetKFromFormula: String;

      property OnChangeState            : TOnChangeDetState read FOnChangeState write SetOnChangeState;
      property OnChangeDose             : TOnChangeDetDose read FOnChangeDose write SetOnChangeDose;
      property OnChangeLightSum         : TOnChangeDetLightSum read FOnChangeLightSum write SetOnChangeLightSum;
      property OnChangeErr              : TOnChangeDetErr read FOnChangeErr write SetOnChangeErr;
      property OnChangeComment          : TOnChangeDetComment read FOnChangeComment write SetOnChangeComment;
      property OnChangeDetTypeComment   : TOnChangeDetTypeComment read FOnChangeDetTypeComment write SetOnChangeDetTypeComment;
      property OnChangeType             : TOnChangeDetType read FOnChangeType write SetOnChangeType;
      property OnShowData               : TOnShowData read FOnShowData write SetOnShowData;
      property OnDetectorProcerssing    : TOnDetectorProcerssing read FOnDetectorProcerssing write SetOnDetectorProcerssing;

  published
      property DetType                  : String read FType write SetType;
      property DetTypeID                : integer read FTypeID write SetTypeID;
      property MeasValue                : String read FMeasValue write SetMeasValue;
      property KName                    : String read FKName write SetKName;
      property Ktv                      : String read FKtv write SetKtv;
      property Tmp                      : String read FTmp write SetTmp;
      property TmpWrite                 : String read FTmpWrite write SetTmpWrite;
      property Fon                      : String read FFon write SetFon;
      property Gaus                     : String read FGaus write SetGaus;
      property Dose                     : double read FDose write SetDose;
      property Err                      : double read FErr write SetErr;
      //property LightSum                 : integer read FLightSum write SetLightSum;
      property LightSum                 : int64 read FLightSum write SetLightSum;
      property State                    : TDetectorState read FState write SetState;
      property Method                   : String read FMethod write SetMethod;
      property Comment                  : String read FComment write SetComment;
      property DetTypeComment           : String read FDetTypeComment write SetDetTypeComment;
      property Bt                       : double read FBt write SetBt;
      property Bx0                      : double read FBx0 write SetBx0;
      property By0                      : double read FBy0 write SetBy0;
      property Bxy0                     : double read FBxy0 write SetBxy0;
      property Bdy                      : double read FBdy write SetBdy;
      property Gm1                      : double read FGm1 write SetGm1;
      property Ga1                      : double read FGa1 write SetGa1;
      property Gsl                      : double read FGsl write SetGsl;
      property Dgm2                     : double read FDgm2 write SetDgm2;
      property Dga2                     : double read FDga2 write SetDga2;
      property Gsr                      : double read FGsr write SetGsr;
      property N1                       : double read FN1 write SetN1;
      property N2                       : double read FN2 write SetN2;
      property BN1                      : double read FBN1 write FBN1;
      property BN1_width                : double read FBN1_width write FBN1_width;
      property BN2                      : double read FBN2 write FBN2;
      property BN2_width                : double read FBN2_width write FBN2_width;
      property SA4                      : double read FSA4 write SetSA4;
      property SA5                      : double read FSA5 write SetSA5;
      property S                        : double read FS write SetS;
      property K1Profile                : double read FK1Profile write SetK1Profile;
      property K2Profile                : double read FK2Profile write SetK2Profile;
      property PeakFound                : boolean read FPeakFound write SetPeakFound;
      property FonFound                 : boolean read FFonFound write SetFonFound;
      property AutoProcessing           : boolean read FAutoProcessing write SetAutoProcessing;
  end;

implementation
uses
  uMainForm,
  uDosimeter,
  uFunctions;
{ TDetecror }

constructor TDetector.Create(DetType: String; DetTypeID: integer; aPosition: integer; AOwner: TComponent);
begin
  inherited Create(nil);
  //Self.FType:=DetType;
  Self.Parent:=AOwner.Create(Self);
  Self.FTypeID:=DetTypeID;
  Self.FLightSum:=0;
  Self.ReadedPoints:=0;
  FillChar(Self.KTV_Buff, SizeOf(Self.KTV_Buff), 0);
  FillChar(Self.Temp_Buff, SizeOf(Self.Temp_Buff), 0);
  Self.Position:=aPosition;
  Self.OnChangeDose:=@MainForm.OnChangeDetDose;
  Self.OnChangeErr:=@MainForm.OnChangeDetDose;//MainForm.OnChangeDetErr;
  Self.OnChangeLightSum:=@MainForm.OnChangeDetLightSum;
  Self.OnChangeState:=@MainForm.OnChangeDetState;
  Self.OnChangeComment:=@MainForm.OnChangeDetComment;
  Self.OnChangeDetTypeComment:=@MainForm.OnChangeDetTypeComment;
  Self.OnShowData:=@MainForm.OnShowDetData;
  Self.OnChangeType:=@MainForm.OnChangeDetType;
//  Self.DetType:=DetType;
  Self.State:=stDetNotMeasured;
  Self.AutoProcessing:=true;
  Self.IsReadFromDB:=false;
  Self.Comment:='';

end;

destructor TDetector.Destroy;
begin
  inherited;
end;
function TDetector.GetKFromFormula: String;
begin
  case Position of
    cDetPos1:
    begin
      case cDetMeasValTxt_Index[TDosimeter(Parent).FormulaID] of
        c_none:
        begin
          Result:=cEmptyData;
        end;
        cHp_10g_1d,
        cHp_10g_2d,
        cHp_10g_3d,
        cHp_10g_4d,
        cHp_10g_2d_Hp_10n_2d,
        cHp_10g_2d_Hp_10n_1d,
        cHp_10g_1d_Hp_10n_2d,
        cHp_10g_1d_Hp_10n_1d,
        cHp_10g_Hp_10n_Hp_007g_Hp_3,
        cHp_10g_1d_Hp_007g_1d_Hp_3_1d,
        cHp_10g_1d_Hp_007g_1d,
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          Result:=cK1;
        end;
        cHp_007g_1d,
        cHp_007g_2d,
        cHp_007g_3d,
        cHp_007g_4d:
        begin
          Result:=cK1
        end;
        cHp_007gb_1d,
        cHp_007gb_2d,
        cHp_007gb_3d,
        cHp_007gb_4d:
        begin
          Result:=cK1
        end;
        cHp_3_1d,
        cHp_3_2d,
        cHp_3_3d,
        cHp_3_4d:
        begin
          Result:=cK1;
        end;
        cHp_star_g_1d,
        cHp_star_g_2d,
        cHp_star_g_3d,
        cHp_star_g_4d:
        begin
          Result:=cK1;
        end;
        cH_007_dir_g_1d,
        cH_007_dir_g_2d,
        cH_007_dir_g_3d,
        cH_007_dir_g_4d:
        begin
          Result:=cK1;
        end;
        cD_1d,
        cD_2d,
        cD_3d,
        cD_4d:
        begin
          Result:=cK1;
        end
        else
          Result:=cK1;
      end;
    end;
    cDetPos2:
    begin
      case cDetMeasValTxt_Index[TDosimeter(Parent).FormulaID] of
        c_none:
        begin
          Result:=cEmptyData;
        end;
        cHp_10g_2d,
        cHp_10g_3d,
        cHp_10g_4d,
        cHp_10g_2d_Hp_10n_2d,
        cHp_10g_2d_Hp_10n_1d:
        begin
          Result:=cK1;
        end;
        cHp_10g_1d_Hp_10n_2d,
        cHp_10g_1d_Hp_10n_1d,
        cHp_10g_Hp_10n_Hp_007g_Hp_3,
        cHp_10g_1d_Hp_007g_1d_Hp_3_1d,
        cHp_10g_1d_Hp_007g_1d,
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          Result:=cK2;
        end;
        cHp_007g_2d,
        cHp_007g_3d,
        cHp_007g_4d:
        begin
          Result:=cK1
        end;
        cHp_007gb_2d,
        cHp_007gb_3d,
        cHp_007gb_4d:
        begin
          Result:=cK1
        end;
        cHp_3_2d,
        cHp_3_3d,
        cHp_3_4d:
        begin
          Result:=cK1;
        end;
        cHp_star_g_2d,
        cHp_star_g_3d,
        cHp_star_g_4d:
        begin
          Result:=cK1;
        end;
        cH_007_dir_g_2d,
        cH_007_dir_g_3d,
        cH_007_dir_g_4d:
        begin
          Result:=cK1;
        end;
        cD_2d,
        cD_3d,
        cD_4d:
        begin
          Result:=cK1;
        end
        else
          Result:=cEmptyData;
      end;
    end;
    cDetPos3:
    begin
      case cDetMeasValTxt_Index[TDosimeter(Parent).FormulaID] of
        c_none:
        begin
          Result:=cEmptyData;
        end;
        cHp_10g_3d,
        cHp_10g_4d:
        begin
          Result:=cK1;
        end;
        cHp_10g_2d_Hp_10n_2d,
        cHp_10g_1d_Hp_10n_2d,
        cHp_10g_2d_Hp_10n_1d:
        begin
          Result:=cK2;
        end;
        cHp_10g_Hp_10n_Hp_007g_Hp_3,
        cHp_10g_1d_Hp_007g_1d_Hp_3_1d,
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          Result:=cK3;
        end;
        cHp_007g_3d,
        cHp_007g_4d:
        begin
          Result:=cK1
        end;
        cHp_007gb_3d,
        cHp_007gb_4d:
        begin
          Result:=cK1
        end;
        cHp_3_3d,
        cHp_3_4d:
        begin
          Result:=cK1;
        end;
        cHp_star_g_3d,
        cHp_star_g_4d:
        begin
          Result:=cK1;
        end;
        cH_007_dir_g_3d,
        cH_007_dir_g_4d:
        begin
          Result:=cK1;
        end;
        cD_3d,
        cD_4d:
        begin
          Result:=cK1;
        end
        else
          Result:=cEmptyData;
      end;
    end;
    cDetPos4:
    begin
       case cDetMeasValTxt_Index[TDosimeter(Parent).FormulaID] of
        c_none:
        begin
          Result:=cEmptyData;
        end;
        cHp_10g_4d:
        begin
          Result:=cK1;
        end;
        cHp_10g_2d_Hp_10n_2d:
        begin
          Result:=cK2;
        end;
        cHp_10g_Hp_10n_Hp_007g_Hp_3:
        begin
          Result:=cK4;
        end;
        cHp_007g_4d:
        begin
          Result:=cK1
        end;
        cHp_007gb_4d:
        begin
          Result:=cK1
        end;
        cHp_3_4d:
        begin
          Result:=cK1;
        end;
        cHp_star_g_4d:
        begin
          Result:=cK1;
        end;
        cH_007_dir_g_4d:
        begin
          Result:=cK1;
        end;
        cD_4d:
        begin
          Result:=cK1;
        end;
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          Result:=cK4;
        end
        else
          Result:=cEmptyData;
      end;
    end;
  end;
end;

function TDetector.GetMeasValFromFormula: String;
begin
  case Position of
    cDetPos1:
    begin
      case cDetMeasValTxt_Index[TDosimeter(Parent).FormulaID] of
        c_none:
        begin
          Result:=cEmptyData;
        end;
        cHp_10g_1d,
        cHp_10g_2d,
        cHp_10g_3d,
        cHp_10g_4d,
        cHp_10g_2d_Hp_10n_2d,
        cHp_10g_2d_Hp_10n_1d,
        cHp_10g_1d_Hp_10n_2d,
        cHp_10g_1d_Hp_10n_1d,
        cHp_10g_Hp_10n_Hp_007g_Hp_3,
        cHp_10g_1d_Hp_007g_1d_Hp_3_1d,
        cHp_10g_1d_Hp_007g_1d,
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          Result:=Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]);
        end;
        cHp_007g_1d,
        cHp_007g_2d,
        cHp_007g_3d,
        cHp_007g_4d:
        begin
          Result:=Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]);
        end;
        cHp_007gb_1d,
        cHp_007gb_2d,
        cHp_007gb_3d,
        cHp_007gb_4d:
        begin
          Result:=Format('%s: %s+%s',[cDet1,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]);
        end;
        cHp_3_1d,
        cHp_3_2d,
        cHp_3_3d,
        cHp_3_4d:
        begin
          Result:=Format('%s: %s+%s',[cDet1,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]);
        end;
        cHp_star_g_1d,
        cHp_star_g_2d,
        cHp_star_g_3d,
        cHp_star_g_4d:
        begin
          Result:=Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]);
        end;
        cH_007_dir_g_1d,
        cH_007_dir_g_2d,
        cH_007_dir_g_3d,
        cH_007_dir_g_4d:
        begin
          Result:=Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]);
        end;
        cD_1d,
        cD_2d,
        cD_3d,
        cD_4d:
        begin
          Result:=cD;
        end
        else
          Result:=cEmptyData;
      end;
    end;
    cDetPos2:
    begin
      case cDetMeasValTxt_Index[TDosimeter(Parent).FormulaID] of
        c_none:
        begin
          Result:=cEmptyData;
        end;
        cHp_10g_2d,
        cHp_10g_3d,
        cHp_10g_4d,
        cHp_10g_2d_Hp_10n_2d,
        cHp_10g_2d_Hp_10n_1d:
        begin
          Result:=Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]);
        end;
        cHp_10g_1d_Hp_10n_2d,
        cHp_10g_1d_Hp_10n_1d,
        cHp_10g_Hp_10n_Hp_007g_Hp_3:
        begin
          Result:=Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]);
        end;
        cHp_007g_2d,
        cHp_007g_3d,
        cHp_007g_4d:
        begin
          Result:=Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]);
        end;
        cHp_007gb_2d,
        cHp_007gb_3d,
        cHp_007gb_4d,
        cHp_10g_1d_Hp_007g_1d_Hp_3_1d:
        begin
          Result:=Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]);
        end;
        cHp_3_2d,
        cHp_3_3d,
        cHp_3_4d:
        begin
          Result:=Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]);
        end;
        cHp_star_g_2d,
        cHp_star_g_3d,
        cHp_star_g_4d:
        begin
          Result:=Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]);
        end;
        cH_007_dir_g_2d,
        cH_007_dir_g_3d,
        cH_007_dir_g_4d:
        begin
          Result:=Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]);
        end;
        cD_2d,
        cD_3d,
        cD_4d:
        begin
          Result:=cD;
        end
        else
          Result:=cEmptyData;
      end;
    end;
    cDetPos3:
    begin
      case cDetMeasValTxt_Index[TDosimeter(Parent).FormulaID] of
        c_none:
        begin
          Result:=cEmptyData;
        end;
        cHp_10g_3d,
        cHp_10g_4d:
        begin
          Result:=Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]);
        end;
        cHp_10g_2d_Hp_10n_2d,
        cHp_10g_1d_Hp_10n_2d,
        cHp_10g_2d_Hp_10n_1d:
        begin
          Result:=Format('%s: %s+%s',[cDet3,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]);
        end;
        cHp_007g_3d,
        cHp_007g_4d,
        cHp_10g_Hp_10n_Hp_007g_Hp_3:
        begin
          Result:=Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]);
        end;
        cHp_007gb_3d,
        cHp_007gb_4d:
        begin
          Result:=Format('%s: %s+%s',[cDet3,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]);
        end;
        cHp_3_3d,
        cHp_3_4d,
        cHp_10g_1d_Hp_007g_1d_Hp_3_1d:
        begin
          Result:=Format('%s: %s+%s',[cDet3,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]);
        end;
        cHp_star_g_3d,
        cHp_star_g_4d:
        begin
          Result:=Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]);
        end;
        cH_007_dir_g_3d,
        cH_007_dir_g_4d:
        begin
          Result:=Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]);
        end;
        cD_3d,
        cD_4d:
        begin
          Result:=cD;
        end
        else
          Result:=cEmptyData;
      end;
    end;
    cDetPos4:
    begin
       case cDetMeasValTxt_Index[TDosimeter(Parent).FormulaID] of
        c_none:
        begin
          Result:=cEmptyData;
        end;
        cHp_10g_4d:
        begin
          Result:=Format('%s: %s',[cDet4,cuUnicodeSymbol_Gamma]);
        end;
        cHp_10g_2d_Hp_10n_2d:
        begin
          Result:=Format('%s: %s+%s',[cDet4,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]);
        end;
        cHp_007g_4d:
        begin
          Result:=Format('%s: %s',[cDet4,cuUnicodeSymbol_Gamma]);
        end;
        cHp_007gb_4d:
        begin
          Result:=Format('%s: %s+%s',[cDet4,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]);
        end;
        cHp_10g_Hp_10n_Hp_007g_Hp_3,
        cHp_3_4d:
        begin
          Result:=Format('%s: %s+%s',[cDet4,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]);
        end;
        cHp_star_g_4d:
        begin
          Result:=Format('%s: %s',[cDet4,cuUnicodeSymbol_Gamma]);
        end;
        cH_007_dir_g_4d:
        begin
          Result:=Format('%s: %s',[cDet4,cuUnicodeSymbol_Gamma]);
        end;
        cD_4d:
        begin
          Result:=cD;
        end;
        cHp_10g_2d_Hp_10n_2d_f6776:
        begin
          Result:=Format('%s: %s+%s',[cDet4,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]);     // ХЗ
        end
        else
          Result:=cEmptyData;
      end;
    end;
  end;
end;

//
//function TDetector.CalcKDos(SourceDose: double): double;
//begin
//  if Dose_g_hp10 <> 0 then
//    Kh10:=RoundToCN((SourceDose/Dose_g_hp10),cAfterComma);
//end;

//procedure TDetector.SetBitDetMeasFinished(Value: boolean);
//begin
//  if Value then
//    State:=SetBit(State,cDetBitMeasFinished,true)
//  else
//    State:=SetBit(State,cDetBitMeasFinished,false);
//end;
//
//procedure TDetector.SetBitDetLoaded(Value: boolean);
//begin
//  if Value then
//    State:=SetBit(State,cDetBitLoaded,true)
//  else
//    State:=SetBit(State,cDetBitLoaded,false);
//end;
//
//procedure TDetector.SetBitDetMeasError(Value: boolean);
//begin
//  if Value then
//    State:=SetBit(State,cDetBitMeasError,true)
//  else
//    State:=SetBit(State,cDetBitMeasError,false);
//end;
//
//procedure TDetector.SetBitDetLost(Value: boolean);
//begin
//  if Value then
//    State:=SetBit(State,cDetBitLost,true)
//  else
//    State:=SetBit(State,cDetBitLost,false);
//end;
//
//procedure TDetector.SetBitDetBroken(Value: boolean);
//begin
//  if Value then
//    State:=SetBit(State,cDetBitBroken,true)
//  else
//    State:=SetBit(State,cDetBitBroken,false);
//end;

//procedure TDetector.SetBitDetSkiped(Value: boolean);
//begin
//  if Value then
//    State:=SetBit(State,cDetBitSkiped,true)
//  else
//    State:=SetBit(State,cDetBitSkiped,false);
//end;
//
//procedure TDetector.SetBitDetMeasStopped(Value: boolean);
//begin
//  if Value then
//    State:=SetBit(State,cDetBitMeasStopped,true)
//  else
//    State:=SetBit(State,cDetBitMeasStopped,false);
//end;
//
//procedure TDetector.SetBitDetProcessedError(Value: boolean);
//begin
//  if Value then
//    State:=SetBit(State,cDetBitProcessedError,true)
//  else
//    State:=SetBit(State,cDetBitProcessedError,false);
//end;
//
//procedure TDetector.SetBitDetAccepted(Value: boolean);
//begin
//  if Value then
//    State:=SetBit(State,cDetBitAccepted,true)
//  else
//    State:=SetBit(State,cDetBitAccepted,false);
//end;

procedure TDetector.SetFon(const Value: String);
begin
  FFon:=DelBrackets(Value,'{','}');
end;

procedure TDetector.SetFonFound(const Value: boolean);
begin
  FFonFound:=Value;
end;

procedure TDetector.SetGa1(const Value: double);
begin
  FGa1:=Value;
end;

procedure TDetector.SetGaus(const Value: String);
begin
  FGaus:=DelBrackets(Value,'{','}');
end;

procedure TDetector.SetGm1(const Value: double);
begin
  FGm1:=Value;
end;

procedure TDetector.SetGsl(const Value: double);
begin
  FGsl:=Value;
end;

procedure TDetector.SetGsr(const Value: double);
begin
  FGsr:=Value;
end;

procedure TDetector.SetK1Profile(const Value: double);
begin
  FK1Profile:=Value;
end;

procedure TDetector.SetK2Profile(const Value: double);
begin
  FK2Profile:=Value;
end;

procedure TDetector.SetKName(const Value: String);
begin
  FKName:=Value;
end;

procedure TDetector.SetMeasValue(const Value: String);
begin
  FMeasValue:=Value
end;

procedure TDetector.SetKtv(const Value: String);
begin
  FKtv:=DelBrackets(Value,'{','}');
end;

procedure TDetector.SetLightSum(const Value: int64);
//  procedure TDetector.SetLightSum(const Value: integer);
begin
  FLightSum:=Value;
  OnChangeLightSum(Self);
end;

procedure TDetector.SetMethod(const Value: String);
begin
  FMethod:=Value;
end;

procedure TDetector.SetN1(const Value: double);
begin
  FN1:=Value;
end;

procedure TDetector.SetN2(const Value: double);
begin
  FN2:=Value;
end;

procedure TDetector.SetOnChangeState(Sender: TOnChangeDetState);
begin
  FOnChangeState:=Sender;
end;

procedure TDetector.SetOnDetectorProcerssing(Sender: TOnDetectorProcerssing);
begin
  FOnDetectorProcerssing:=Sender;
end;

procedure TDetector.SetOnChangeComment(Sender: TOnChangeDetComment);
begin
  FOnChangeComment:=Sender;
end;

procedure TDetector.SetOnChangeType(Sender: TOnChangeDetType);
begin
  FOnChangeType:=Sender;
end;

procedure TDetector.SetOnChangeDetTypeComment(Sender: TOnChangeDetTypeComment);
begin
  FOnChangeDetTypeComment:=Sender;
end;

procedure TDetector.SetOnChangeDose(Sender: TOnChangeDetDose);
begin
  FOnChangeDose:=Sender;
end;

procedure TDetector.SetOnChangeErr(Sender: TOnChangeDetErr);
begin
  FOnChangeErr:=Sender;
end;

procedure TDetector.SetOnChangeLightSum(Sender: TOnChangeDetLightSum);
begin
  FOnChangeLightSum:=Sender;
end;

procedure TDetector.SetOnShowData(Sender: TOnShowData);
begin
  FOnShowData:=Sender;
end;

procedure TDetector.SetPeakFound(const Value: boolean);
begin
  FPeakFound:=Value;
end;

procedure TDetector.SetAutoProcessing(const Value: boolean);
begin
  FAutoProcessing:=Value;
end;

procedure TDetector.SetBdy(const Value: double);
begin
  FBdy:=Value;
end;

procedure TDetector.SetBt(const Value: double);
begin
  if abs(Value)>0.1
  then FBt:=Value
  else FBt:=0.1;
end;

procedure TDetector.SetBx0(const Value: double);
begin
  FBx0:=Value;
end;

procedure TDetector.SetBxy0(const Value: double);
begin
  FBxy0:=Value;
end;

procedure TDetector.SetBy0(const Value: double);
begin
  FBy0:=Value;
end;

procedure TDetector.SetComment(const Value: String);
begin
  FComment:=Value;
  OnChangeComment(Self);
end;

procedure TDetector.SetDetTypeComment(const Value: String);
begin
  FDetTypeComment:=Value;
  OnChangeDetTypeComment(Self);
end;

procedure TDetector.SetDga2(const Value: double);
begin
  FDga2:=Value;
end;

procedure TDetector.SetDgm2(const Value: double);
begin
  FDgm2:=Value;
end;

procedure TDetector.SetDose(const Value: double);
begin
  FDose:=Value;
  OnChangeDose(Self);
end;

procedure TDetector.SetErr(const Value: double);
begin
  FErr:=Value;
  OnChangeErr(Self);
end;

procedure TDetector.SetS(const Value: double);
begin
  FS:=Value;
end;

procedure TDetector.SetSA4(const Value: double);
begin
  FSA4:=Value;
end;

procedure TDetector.SetSA5(const Value: double);
begin
  FSA5:=Value;
end;

procedure TDetector.SetState(const Value: TDetectorState);
begin
  FState:=Value;
  OnChangeDose(Self);
  OnChangeState(Self);
  OnChangeErr(Self);
  OnChangeComment(Self);
end;

procedure TDetector.SetTmp(const Value: String);
begin
  FTmp:=DelBrackets(Value,'{','}');
end;

procedure TDetector.SetTmpWrite(const Value: String);
begin
  FTmpWrite:=DelBrackets(Value,'{','}');
end;

procedure TDetector.SetType(const Value: String);
begin
  FType:=Value;
  OnChangeType(Self);
end;

procedure TDetector.SetTypeID(const Value: integer);
begin
  FTypeID:=Value
end;

procedure TDetector.Serialize;
var
  MemStream: TMemoryStream;
  StStream: TStringStream;
begin
// Запись published свойств
  StStream  := TStringStream.Create;
  MemStream := TMemoryStream.Create;
  try
    MemStream.WriteComponent(Self);
    MemStream.Position := 0;
    ObjectBinaryToText(MemStream, StStream);
    SaveDBParameters := StStream.DataString;
  finally
    MemStream.Free;
    StStream.Free;
  end;
end;

procedure TDetector.Deerialize;
var
  MemStream: TMemoryStream;
  StStream: TStringStream;
begin
// Чтение published свойств
  StStream  := TStringStream.Create;
  MemStream := TMemoryStream.Create;
  try
    StStream.WriteString(SaveDBParameters);
    ObjectTextToBinary(StStream, MemStream);
    MemStream.Position := 0;
    MemStream.ReadComponent(Self);
  finally
    MemStream.Free;
    StStream.Free;
  end;
end;

end.
