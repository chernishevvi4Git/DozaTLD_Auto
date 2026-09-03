unit uExportDosAndSettingsForm;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Math, DBGridsEh,System.UITypes,
  uLanguages,
  uFunctions,
  uDataModule,
  SQLDB,
  uConst;
// Data.Win.ADODB,

type
  TExportDosAndSettingsForm = class(TForm)
    PanelBackground: TPanel;
    CBExportDosTypes: TCheckBox;
    CBExportDetTypes: TCheckBox;
    CBExportSettings: TCheckBox;
    LblTitle: TLabel;
    BtnOk: TButton;
    BtnCancel: TButton;
    PanelTop: TPanel;
    CBExportMeasurments: TCheckBox;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ExportDosAndSettings;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExportDosAndSettingsForm: TExportDosAndSettingsForm;

implementation

uses
  uSeparator,
  uMainForm;

{$R *.dfm}

procedure TExportDosAndSettingsForm.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TExportDosAndSettingsForm.BtnOkClick(Sender: TObject);
begin
  ExportDosAndSettings;
end;

procedure TExportDosAndSettingsForm.ExportDosAndSettings;
var
  measID        :  String;
  dosPath       : String;
  settingsPath  : String;
  measDosPath   : String;
  measDetPath   : String;
  dosTypePath   : String;
  detTypePath   : String;
  ts            : TStringList;
  tsDet         : TStringList;
  line          : String;
  lineDet       : String;
  i,j           : integer;
  btn_cancel    : boolean;
  function CheckNan(Field: String; ADOQuery: TSQLQuery): double;
  begin
    if ADOQuery.FieldByName(Field).AsVariant <> Null then
      Result:=ADOQuery.FieldByName(Field).AsFloat
    else
      Result:=NAN;
  end;
  function CheckNanGrid(Field: String; Grid: TDBGridEh): double;
  begin
    if Grid.DataSource.DataSet.FieldByName(Field).AsVariant <> Null then
      Result:=Grid.DataSource.DataSet.FieldByName(Field).AsFloat
    else
      Result:=NAN;
  end;
  function CheckGRLF(Field: String; ADOQuery: TSQLQuery): String;
  begin
    Result:=StringReplace(ADOQuery.FieldByName(Field).AsString,cCRLF,'',[rfreplaceall]);
  end;
begin
  try
    btn_cancel:=false;

    MainForm.DBGridEhDos.DataSource.DataSet.First;
    MainForm.GridDropAll(MainForm.DBGridEhDos);

    MainForm.SaveDialogMainForm.DefaultExt:='csv';
    MainForm.SaveDialogMainForm.Filter:='|'+'*'+cExtCSV;
    MainForm.SaveDialogMainForm.InitialDir:=extractfilepath(Application.ExeName)+cFolderLibrary+PathDelim;
    MainForm.SaveDialogMainForm.FileName:=Format('%s_№%s_%s',[rsSoftwareName,IntToStr(MainForm.DeviceID),DeleteDividers(DateTimeToStr(Now))]);

    ts:=TStringList.Create;
    line:=cFieldDosID+';'+
          cFieldDosPostfix+';'+
          cFieldDosType+';'+
          cField_k1+';'+
          cField_k2+';'+
          cField_k3+';'+
          cField_k4+';'+
          cField_k5+';'+
          cField_kgn+';'+
          cFieldDosPartName+';'+
          cFieldOrg+';'+
          cFieldDepartment+';';

    ts.Add(line);

    for i := 0 to MainForm.DBGridEhDos.DataSource.DataSet.RecordCount-1 do
    begin
      line:=MainForm.DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosID).AsString+';'+
            MainForm.DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosPostfix).AsString+';'+
            MainForm.DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosType).AsString+';'+
            FloatToStrRegionF(CheckNanGrid(cField_k1,MainForm.DBGridEhDos),ffGeneral,6,2)+';'+
            FloatToStrRegionF(CheckNanGrid(cField_k2,MainForm.DBGridEhDos),ffGeneral,6,2)+';'+
            FloatToStrRegionF(CheckNanGrid(cField_k3,MainForm.DBGridEhDos),ffGeneral,6,2)+';'+
            FloatToStrRegionF(CheckNanGrid(cField_k4,MainForm.DBGridEhDos),ffGeneral,6,2)+';'+
            FloatToStrRegionF(CheckNanGrid(cField_k5,MainForm.DBGridEhDos),ffGeneral,6,2)+';'+
            FloatToStrRegionF(CheckNanGrid(cField_kgn,MainForm.DBGridEhDos),ffGeneral,6,2)+';'+
            MainForm.DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosPartName).AsString+';'+
            MainForm.DBGridEhDos.DataSource.DataSet.FieldByName(cFieldOrg).AsString+';'+
            MainForm.DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDepartment).AsString+';';

      ts.Add(line);
      MainForm.DBGridEhDos.DataSource.DataSet.Next;
    end;

    if MainForm.SaveDialogMainForm.Execute then
    begin
      dosPath:=MainForm.SaveDialogMainForm.FileName;
      ts.SaveToFile(dosPath,TEncoding.UTF8);

      delete(dosPath,pos(cExtCSV,dosPath),Length(cExtCSV));

      if CBExportSettings.Checked then
      begin
        settingsPath:=dosPath+cExtCFGT;

        TLDDataModule.ADOQuery.Active:=False;
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldTldID+','
                                                +cFieldKSLevel+','
                                                +cFieldKSDelta+','
                                                +cFieldKFilter+','
                                                +cFieldKDevice+''
                                                +' FROM '+cDBTableSettings+' WHERE '+cFieldTldID+' = '+IntToStr(MainForm.DeviceID));
        TLDDataModule.ADOQuery.Active:=True;

        ts.Clear;
        line:=cFieldTldID+';'+
              cFieldKSLevel+';'+
              cFieldKSDelta+';'+
              cFieldKFilter+';'+
              cFieldKDevice+';';

        ts.Add(line);

        for i := 0 to TLDDataModule.ADOQuery.RecordCount-1 do
        begin
          line:=TLDDataModule.ADOQuery.FieldByName(cFieldTldID).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldKSLevel).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldKSDelta).AsString+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldKFilter).AsFloat,ffGeneral,6,2)+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldKDevice).AsString+';';

          ts.Add(line);
          TLDDataModule.ADOQuery.Next;
        end;

        ts.SaveToFile(settingsPath,TEncoding.UTF8);
      end;

      if CBExportMeasurments.Checked then
      begin
        // измерения по дозиметрам
        measDosPath:=dosPath+cExtMDOS;

        TLDDataModule.ADOQuery.Active:=False;
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add('SELECT * FROM '+cDBTableDosRes+' WHERE '+cFieldTldID+' = '+IntToStr(MainForm.DeviceID)+' ORDER BY '+cFieldDosMeasID);
        TLDDataModule.ADOQuery.Active:=True;

        ts.Clear;
        line:=cFieldDosMeasID+';'+
              cFieldDosID+';'+
              cFieldDosPostfix+';'+
              cFieldDosType+';'+
              cFieldDosTypeID+';'+
              cFieldFormula+';'+
              cFieldKSI+';'+
              cFieldMeasureTime+';'+
              cFieldRegTime+';'+
              cFieldVerTime+';'+
              cFieldValidity+';'+
              cFieldDosStatus+';'+
              cField_k1+';'+
              cField_k2+';'+
              cField_k3+';'+
              cField_k4+';'+
              cField_k5+';'+
              cField_kgn+';'+
              cFieldPartID+';'+
              cFieldTldID+';'+
              cFieldSoftwareVer+';'+
              cFieldTldUser+';'+
              cFieldPersNumber+';'+
              cFieldFio+';'+
              cFieldOrg+';'+
              cFieldDepartment+';'+
              cFieldLastMeasComment+';'+
              cFieldMeasComment+';'+
              cFieldKFilter+';'+
              cFieldMeasVal+';'+
              cFieldHp10g+';'+
              cFieldHp10n+';'+
              cFieldHp3+';'+
              cFieldHp007+';'+
              cFieldHstar+';'+
              cFieldH007+';'+
              cFieldD+';'+
              cFieldFormulaId_Dos+';'+
              cFieldFormulaId_Val_1+';'+
              cFieldFormulaId_Val_2+';'+
              cFieldFormulaId_Val_3+';'+
              cFieldFormulaId_Val_4+';'+
              cFieldFormula_Err_k1_1+';'+
              cFieldFormula_Err_k2_1+';'+
              cFieldFormula_Err_k1_2+';'+
              cFieldFormula_Err_k2_2+';'+
              cFieldFormula_Err_k1_3+';'+
              cFieldFormula_Err_k2_3+';'+
              cFieldFormula_Err_k1_4+';'+
              cFieldFormula_Err_k2_4+';'+
              cFieldHp10g_err+';'+
              cFieldHp10n_err+';'+
              cFieldHp3_err+';'+
              cFieldHp007_err+';'+
              cFieldHstar_err+';'+
              cFieldH007_err+';'+
              cFieldD_err+';'+
              cFieldToDel+';'+
              cFieldDosPartName+';'+
              cFieldKDevice+';';

        ts.Add(line);

        // измерения по детекторам
        measDetPath:=dosPath+cExtMDET;

        tsDet:=TStringList.Create;
        tsDet.Clear;

        lineDet:=cFieldDosMeasID+';'+
                 cFieldDetType+';'+
                 cFieldDetTypeID+';'+
                 cFieldDose+';'+
                 cFieldDetErr+';'+
                 cFieldDetPosition+';'+
                 cFieldKTV+';'+
                 cFieldTempProfile+';'+
                 cFieldCalcFon+';'+
                 cFieldCalcGaus+';'+
                 cFieldCoefficient+';'+
                 cFieldMeasureTime+';'+
                 cFieldAutoProc+';'+
                 cFieldDetStatus+';'+
                 cFieldDetComment+';'+
                 cFieldBt+';'+
                 cFieldBx0+';'+
                 cFieldBy0+';'+
                 cFieldBxy0+';'+
                 cFieldBdy+';'+
                 cFieldGm1+';'+
                 cFieldGa1+';'+
                 cFieldGsl+';'+
                 cFieldDgm2+';'+
                 cFieldDga2+';'+
                 cFieldGsr+';'+
                 cFieldN1+';'+
                 cFieldN2+';'+
                 cFieldS+';'+
                 cFieldPeakFound+';'+
                 cFieldFonFound+';'+
                 cFieldTempProfileWrite+';'+
                 cFieldMethod+';'+
                 cFieldDetTypeComment+';'+
                 cFieldDetMeasVal+';'+
                 cFieldDetKName+';'+
                 cFieldBn1+';'+
                 cFieldBn1Width+';'+
                 cFieldBn2+';'+
                 cFieldBn2Width+';'+
                 cFieldK1Profile+';'+
                 cFieldK2Profile+';';

        tsDet.Add(lineDet);

        for i := 0 to TLDDataModule.ADOQuery.RecordCount-1 do
        begin

          line:=TLDDataModule.ADOQuery.FieldByName(cFieldDosMeasID).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDosID).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDosPostfix).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDosType).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDosTypeID).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormula).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldKSI).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldMeasureTime).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldRegTime).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldVerTime).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldValidity).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDosStatus).AsString+';'+
                FloatToStrRegionF(CheckNan(cField_k1,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cField_k2,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cField_k3,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cField_k4,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cField_k5,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cField_kgn,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldPartID).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldTldID).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldSoftwareVer).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldTldUser).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldPersNumber).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFio).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldOrg).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDepartment).AsString+';'+
                CheckGRLF(cFieldLastMeasComment,TLDDataModule.ADOQuery)+';'+
                CheckGRLF(cFieldMeasComment,TLDDataModule.ADOQuery)+';'+
                FloatToStrRegionF(CheckNan(cFieldKFilter,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldMeasVal).AsString+';'+
                FloatToStrRegionF(CheckNan(cFieldHp10g,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldHp10n,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldHp3,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldHp007,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldHstar,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldH007,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldD,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Dos).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_1).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_2).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_3).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_4).AsString+';'+
                FloatToStrRegionF(CheckNan(cFieldFormula_Err_k1_1,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldFormula_Err_k2_1,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldFormula_Err_k1_2,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldFormula_Err_k2_2,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldFormula_Err_k1_3,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldFormula_Err_k2_3,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldFormula_Err_k1_4,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldFormula_Err_k2_4,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldHp10g_err,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldHp10n_err,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldHp3_err,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldHp007_err,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldHstar_err,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldH007_err,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                FloatToStrRegionF(CheckNan(cFieldD_err,TLDDataModule.ADOQuery),ffGeneral,6,2)+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldToDel).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDosPartName).AsString+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldKDevice).AsFloat,ffGeneral,6,2)+';';

          ts.Add(line);

          measID:=TLDDataModule.ADOQuery.FieldByName(cFieldDosMeasID).AsString;

//          s:=TLDDataModule.ADOQueryExportDet.Connection.ConnectionString;
          TLDDataModule.ADOQueryExportDet.Active:=False;
          TLDDataModule.ADOQueryExportDet.SQL.Clear;
          TLDDataModule.ADOQueryExportDet.SQL.Add('SELECT '+cFieldDosMeasID+','
                                                           +cFieldDetType+','
                                                           +cFieldDetTypeID+','
                                                           +cFieldDose+','
                                                           +cFieldDetErr+','
                                                           +cFieldDetPosition+','
                                                           +cFieldKTV+','
                                                           +cFieldTempProfile+','
                                                           +cFieldTempProfileWrite+','
                                                           +cFieldCalcFon+','
                                                           +cFieldCalcGaus+','
                                                           +cFieldCoefficient+','
                                                           +cFieldMeasureTime+','
                                                           +cFieldAutoProc+','
                                                           +cFieldDetStatus+','
                                                           +cFieldDetComment+','
                                                           +cFieldBt+','
                                                           +cFieldBx0+','
                                                           +cFieldBy0+','
                                                           +cFieldBxy0+','
                                                           +cFieldBdy+','
                                                           +cFieldGm1+','
                                                           +cFieldGa1+','
                                                           +cFieldGsl+','
                                                           +cFieldDgm2+','
                                                           +cFieldDga2+','
                                                           +cFieldGsr+','
                                                           +cFieldN1+','
                                                           +cFieldN2+','
                                                           +cFieldS+','
                                                           +cFieldPeakFound+','
                                                           +cFieldFonFound+','
                                                           +cFieldMethod+','
                                                           +cFieldDetTypeComment+','
                                                           +cFieldDetMeasVal+','
                                                           +cFieldDetKName+','
                                                           +cFieldBn1+','
                                                           +cFieldBn1Width+','
                                                           +cFieldBn2+','
                                                           +cFieldBn2Width+','
                                                           +cFieldK1Profile+','
                                                           +cFieldK2Profile+' '
                                                           +'FROM '+cDBTableDetRes+' WHERE '+cFieldDosMeasID+' = '+measID+' ORDER BY '+cFieldDosMeasID);
          TLDDataModule.ADOQueryExportDet.Active:=True;

          for j := 0 to TLDDataModule.ADOQueryExportDet.RecordCount-1 do
          begin
            lineDet:=TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDosMeasID).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDetType).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDetTypeID).AsString+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDose).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDetErr).AsFloat,ffGeneral,6,2)+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDetPosition).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldKTV).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldTempProfile).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldCalcFon).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldCalcGaus).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldCoefficient).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldMeasureTime).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldAutoProc).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDetStatus).AsString+';'+
                     CheckGRLF(cFieldDetComment,TLDDataModule.ADOQueryExportDet)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldBt).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldBx0).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldBy0).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldBxy0).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldBdy).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldGm1).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldGa1).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldGsl).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDgm2).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDga2).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldGsr).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldN1).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldN2).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldS).AsFloat,ffGeneral,6,2)+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldPeakFound).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldFonFound).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldTempProfileWrite).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldMethod).AsString+';'+
                     CheckGRLF(cFieldDetTypeComment,TLDDataModule.ADOQueryExportDet)+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDetMeasVal).AsString+';'+
                     TLDDataModule.ADOQueryExportDet.FieldByName(cFieldDetKName).AsString+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldBn1).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldBn1Width).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldBn2).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldBn2Width).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldK1Profile).AsFloat,ffGeneral,6,2)+';'+
                     FloatToStrRegionF(TLDDataModule.ADOQueryExportDet.FieldByName(cFieldK2Profile).AsFloat,ffGeneral,6,2)+';';

            tsDet.Add(lineDet);

            TLDDataModule.ADOQueryExportDet.Next;
          end;

          TLDDataModule.ADOQuery.Next;
        end;

        ts.SaveToFile(measDosPath,TEncoding.UTF8);
        tsDet.SaveToFile(measDetPath,TEncoding.UTF8);
        tsDet.Free;
      end;

      if CBExportDosTypes.Checked then
      begin
        dosTypePath:=dosPath+cExtDOST;

        TLDDataModule.ADOQuery.Active:=False;
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add('SELECT * FROM '+cDBTableDosType+ ' WHERE '+cFieldDosTypeID+'> 0'+' ORDER BY '+cFieldDosTypeID);
        TLDDataModule.ADOQuery.Active:=True;

        ts.Clear;
        line:=cFieldDosTypeID+';'+
              cFieldDosType+';'+
              cFieldMeasVal+';'+
              cFieldDType1+';'+
              cFieldDType2+';'+
              cFieldDType3+';'+
              cFieldDType4+';'+
              cFieldFormula+';'+
              cFieldError+';'+
              cFieldFormulaId_Dos+';'+
              cFieldFormulaId_Val_1+';'+
              cFieldFormulaId_Val_2+';'+
              cFieldFormulaId_Val_3+';'+
              cFieldFormulaId_Val_4+';'+
              cFieldFormula_Err_k1_1+';'+
              cFieldFormula_Err_k2_1+';'+
              cFieldFormula_Err_k1_2+';'+
              cFieldFormula_Err_k2_2+';'+
              cFieldFormula_Err_k1_3+';'+
              cFieldFormula_Err_k2_3+';'+
              cFieldFormula_Err_k1_4+';'+
              cFieldFormula_Err_k2_4+';';

        ts.Add(line);

        for i := 0 to TLDDataModule.ADOQuery.RecordCount-1 do
        begin
          line:=TLDDataModule.ADOQuery.FieldByName(cFieldDosTypeID).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDosType).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldMeasVal).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDType1).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDType2).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDType3).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDType4).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormula).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldError).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Dos).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_1).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_2).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_3).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldFormulaId_Val_4).AsString+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k1_1).AsFloat,ffGeneral,6,2)+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k2_1).AsFloat,ffGeneral,6,2)+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k1_2).AsFloat,ffGeneral,6,2)+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k2_2).AsFloat,ffGeneral,6,2)+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k1_3).AsFloat,ffGeneral,6,2)+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k2_3).AsFloat,ffGeneral,6,2)+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k1_4).AsFloat,ffGeneral,6,2)+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldFormula_Err_k2_4).AsFloat,ffGeneral,6,2)+';';

          ts.Add(line);
          TLDDataModule.ADOQuery.Next;
        end;

        ts.SaveToFile(dosTypePath,TEncoding.UTF8);

      end;

      if CBExportDetTypes.Checked then
      begin
        detTypePath:=dosPath+cExtDETT;

        TLDDataModule.ADOQuery.Active:=False;
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDetTypeID+','
                                                +cFieldDetType+','
                                                +cFieldTempProfile+','
                                                +cFieldDetTypeComment+','
                                                +cFieldMethod+','
                                                +cFieldDetMeasVal+','
                                                +cFieldDetKName+','
                                                +cFieldK1Profile+','
                                                +cFieldK2Profile+' '
                                                +'FROM '+cDBTableDetType+ ' WHERE '+cFieldDetTypeID+'> 0'+' ORDER BY '+cFieldDetTypeID);

        TLDDataModule.ADOQuery.Active:=True;

        ts.Clear;
        line:=cFieldDetTypeID+';'+
              cFieldDetType+';'+
              cFieldTempProfile+';'+
              cFieldDetTypeComment+';'+
              cFieldMethod+';'+
              cFieldDetMeasVal+';'+
              cFieldDetKName+';'+
              cFieldK1Profile+';'+
              cFieldK2Profile+';';

        ts.Add(line);

        for i := 0 to TLDDataModule.ADOQuery.RecordCount-1 do
        begin
          line:=TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeID).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDetType).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldTempProfile).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDetTypeComment).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldMethod).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDetMeasVal).AsString+';'+
                TLDDataModule.ADOQuery.FieldByName(cFieldDetKName).AsString+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldK1Profile).AsFloat,ffGeneral,6,2)+';'+
                FloatToStrRegionF(TLDDataModule.ADOQuery.FieldByName(cFieldK2Profile).AsFloat,ffGeneral,6,2)+';';

          ts.Add(line);
          TLDDataModule.ADOQuery.Next;
        end;

        ts.SaveToFile(detTypePath,TEncoding.UTF8);

      end;

    end
    else
      btn_cancel:=true;

    ts.Free;
    if not btn_cancel then MessageDlg(Format('%s',[rsExportDone]),mtInformation,[mbOK],0);

  except
    on E: exception do
    begin
      MessageDlg(Format('%s - %s',[rsErrExportDos,E.Message]),mtError,[mbOK],0);
    end;
  end;

  Close;

end;

procedure TExportDosAndSettingsForm.FormShow(Sender: TObject);
begin
  CBExportSettings.Checked:=true;
  CBExportMeasurments.Checked:=false;
  CBExportDosTypes.Checked:=false;
  CBExportDetTypes.Checked:=false;
end;

end.
