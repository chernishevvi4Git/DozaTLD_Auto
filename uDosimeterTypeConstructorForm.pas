unit uDosimeterTypeConstructorForm;

interface

uses
  Messages, SysUtils, TypInfo, Variants, Classes, Graphics,System.UITypes,
  Controls, Forms, Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, StdCtrls, GridsEh, DBAxisGridsEh, DBGridsEh, ExtCtrls,
  MemTableDataEh, DB, SQLDB, DataDriverEh, MemTableEh, Buttons, Menus,
  uUsersManagement, uDataModule, uLogPassForm;
// Data.Win.ADODB, AnsiStrings, EhLibVCL, JvMenus,

type

  TIndexOf = set of byte;

//  TDosTypes = (cDosTypeTLD3Name,
//               cDosTypeDTL02Name,
//               cDosTypeDTU01Name,
//               cDosTypeDTU02Name,
//               cDosTypeDVNGMName,
//               cDosTypeEYEDName,
//               cDosTypeFingerRingGName,
//               cDosTypeFingerRingBGName,
//               cDosTypeCoupleDTU1Name
//               );

  { TDosimeterTypeConstructorForm }

  TDosimeterTypeConstructorForm = class(TForm)
    BtnSaveChanges: TButton;
    PanelGrid: TPanel;
    PanelTopGrid: TPanel;
    LblDosType: TLabel;
    DBGridEhDosType: TDBGridEh;
    DataSourceDosType: TDataSource;
    MemTableEhDosType: TMemTableEh;
    DataSetDriverEhDosType: TDataSetDriverEh;
    ADOQueryDosType: TSQLQuery;
    PanelRight: TPanel;
    LblErr: TLabel;
    LblFormula: TLabel;
    ComboBoxD4: TComboBox;
    ComboBoxD3: TComboBox;
    ComboBoxD2: TComboBox;
    ComboBoxD1: TComboBox;
    MemoD1: TMemo;
    MemoD2: TMemo;
    MemoD3: TMemo;
    MemoD4: TMemo;
    PanelDosTypeOptions: TPanel;
    LblNewDosType: TLabel;
    EditDosType: TEdit;
    PanelBottomGrid: TPanel;
    SpeedBtnAddDosType: TSpeedButton;
    SpeedBtnDelDosPart: TSpeedButton;
    PanelDosTypeBottom: TPanel;
    GBoxD1: TGroupBox;
    GBoxD2: TGroupBox;
    GBoxD3: TGroupBox;
    GBoxD4: TGroupBox;
    LblMeasValD1: TLabel;
    LblMaterialD1: TLabel;
    LblMaterialParamD1: TLabel;
    LblMeasValD2: TLabel;
    LblMeasValD3: TLabel;
    LblMeasValD4: TLabel;
    LblMaterialD2: TLabel;
    LblMaterialD3: TLabel;
    LblMaterialD4: TLabel;
    LblMaterialParamD2: TLabel;
    LblMaterialParamD3: TLabel;
    LblMaterialParamD4: TLabel;
    EditDosMeasVal_1: TEdit;
    EditDosMeasVal_2: TEdit;
    EditDosMeasVal_3: TEdit;
    EditDosMeasVal_4: TEdit;
    LblKD1: TLabel;
    LblKD2: TLabel;
    LblKD3: TLabel;
    LblKD4: TLabel;
    LblMeasDosValue: TLabel;
    CBoxMeasValue: TComboBox;
    EditMeasValD1: TEdit;
    EditMeasValD2: TEdit;
    EditMeasValD3: TEdit;
    EditMeasValD4: TEdit;
    EditKD1: TEdit;
    EditKD2: TEdit;
    EditKD3: TEdit;
    EditKD4: TEdit;
    EditFormulaVal_1: TEdit;
    EditFormulaVal_2: TEdit;
    EditFormulaVal_3: TEdit;
    EditFormulaVal_4: TEdit;
    CBoxDetsCnt: TComboBox;
    LblDetsCount: TLabel;
    LblMethodD1: TLabel;
    EditMethodD1: TEdit;
    EditMethodD2: TEdit;
    LblMethodD2: TLabel;
    EditMethodD3: TEdit;
    LblMethodD3: TLabel;
    EditMethodD4: TEdit;
    LblMethodD4: TLabel;
    SpeedBtnD1Inf: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    BtnClose: TButton;
    EditValErrK1_4: TEdit;
    ShapeErr_4: TShape;
    LblHErr_4: TLabel;
    LblPlus_4: TLabel;
    EditValErrK2_4: TEdit;
    LblValPercent_4: TLabel;
    LblValPercent_3: TLabel;
    EditValErrK2_3: TEdit;
    LblPlus_3: TLabel;
    LblHErr_3: TLabel;
    ShapeErr_3: TShape;
    EditValErrK1_3: TEdit;
    LblValPercent_2: TLabel;
    EditValErrK2_2: TEdit;
    LblPlus_2: TLabel;
    LblHErr_2: TLabel;
    ShapeErr_2: TShape;
    EditValErrK1_2: TEdit;
    LblValPercent_1: TLabel;
    EditValErrK2_1: TEdit;
    LblPlus_1: TLabel;
    LblHErr_1: TLabel;
    ShapeErr_1: TShape;
    EditValErrK1_1: TEdit;
    LblErr1: TLabel;
    LblErr2: TLabel;
    LblErr3: TLabel;
    LblErr4: TLabel;
    procedure BtnSaveChangesClick(Sender: TObject);
    procedure DBGridEhDosTypeCellClick(Column: TColumnEh);
    procedure DBGridEhDosTypeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedBtnSaveChangesClick(Sender: TObject);
    procedure SpeedBtnAddDosTypeClick(Sender: TObject);
    procedure SpeedBtnDelDosPartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditEnable(Sender: TObject);
    procedure EditDisable(Sender: TObject);
    procedure MemoEnable(Sender: TObject);
    procedure MemoDisable(Sender: TObject);
    procedure ComboBoxKD1DropDown(Sender: TObject);
    procedure ComboBoxKD2DropDown(Sender: TObject);
    procedure ComboBoxKD3DropDown(Sender: TObject);
    procedure ComboBoxD1Change(Sender: TObject);
    procedure ComboBoxD2Change(Sender: TObject);
    procedure ComboBoxD3Change(Sender: TObject);
    procedure ComboBoxD4Change(Sender: TObject);
    procedure CBoxMeasValueChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBoxDetsCntChange(Sender: TObject);
    procedure SpeedBtnD1InfClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private


    DosMeasValues     : String;
    DetectorsCnt      : integer;
    Formula_id_dos    : integer;

    FormulaIdVal_1    : integer;
    FormulaIdVal_2    : integer;
    FormulaIdVal_3    : integer;
    FormulaIdVal_4    : integer;
    FEditAvailable    : boolean;

    function GetProfileString(InputString: String): String;
    function GetDosTypeDefaultName: String;
    procedure DeleteDosType(aDosTypeName: String);
    procedure CBoxDetChange(aCBox: TComboBox; aMemo: TMemo; EditMethod: TEdit);
    procedure ChangeDosTypeParameters(CBox: TCombobox);
    procedure SetEditAvailable(const Value: boolean);
    procedure CheckEnableControls;
    procedure UnlockControls(Value: boolean);
    { Private declarations }
  public
    DosTypeID      : String;
    DosTypeName    : String;

    procedure UpdateDosType;
    procedure RefreshDosTypeList;
    procedure LoadDosTypeParameters;
    property EditAvailable: boolean read FEditAvailable write SetEditAvailable;
    { Public declarations }
  end;

var
  DosimeterTypeConstructorForm: TDosimeterTypeConstructorForm;

implementation
uses
  StrUtils,
  uConst,
  uSeparator,
  uDetectorConstructorForm,
  uEnterNewDosTypeForm,
  uLanguages,
  uFunctions;
{$R *.dfm}

function TDosimeterTypeConstructorForm.GetDosTypeDefaultName: String;
const
  cNewDosTypeName = 'New';
var
  cnt           : integer;
  cntRec        : integer;
  dosTypeNumber : String;
begin
  cnt := 1;
  cntRec := 1;

  while cntRec <> 0 do
  begin
    dosTypeNumber:=Format('%s_%d',[cNewDosTypeName,cnt]);

    ADOQueryDosType.Active:=False;
    ADOQueryDosType.SQL.Clear;
    ADOQueryDosType.SQL.Add('SELECT '+cFieldDosType+' FROM '+cDBTableDosType+' WHERE '+cFieldDosType+' = '+#39+dosTypeNumber+#39);
    ADOQueryDosType.Active:=True;

    if ADOQueryDosType.RecordCount <> 0 then inc(cnt);

    cntRec:=ADOQueryDosType.RecordCount;

    Result:=dosTypeNumber;
  end;
end;

function TDosimeterTypeConstructorForm.GetProfileString(InputString: String): String;
var
  i               : integer;
  ts              : TStringList;
  strVal          : String;
  strParam        : String;
  outStr          : String;
begin
  outStr:='';

//  if not InputString.IsEmpty then
  if InputString<>'' then
  begin
    ts:=TStringList.Create;
    ts.Delimiter:=';';                                        // устанавливаем разделитель
    ts.DelimitedText:=InputString;

    if ts.Count>0 then
    begin
      // начинаем с 2 т.к. первые два значения в массиве термопрофиля - длительность нагрева и допустимое отклонение при нагреве
      for i := 0 to ts.Count-1 do
      begin
        strVal:=ts[i];
        strParam:=ts[i];
        Delete(strVal,1,Pos('=',strVal));
        Delete(strParam,Pos('=',strParam),Length(strParam)-Pos('=',strParam)+1);

        if i = ts.Count-2 then
        begin
          if strVal<>'' then outStr:=outStr+strParam+':'+strVal
        end
        else
        begin
          if strVal<>'' then outStr:=outStr+strParam+':'+strVal+cCRLF;
        end;

      end;
    end;

    Result:=outStr;

    ts.free;
  end
  else
    Result:=outStr;
end;

procedure TDosimeterTypeConstructorForm.LoadDosTypeParameters;
var
  i              : integer;
  idD1           : String;
  idD2           : String;
  idD3           : String;
  idD4           : String;  // id детектора
  procedure SetComboBoxes(aIdD: String; aCBoxD: TComboBox);
  var
    typeD          : String;
    i: integer;
  begin
    ADOQueryDosType.Active:=False;
    ADOQueryDosType.SQL.Clear;
    ADOQueryDosType.SQL.Add('SELECT '+cFieldDetType+','
                                     +cFieldDetMeasVal+','
                                     +cFieldDetKName+' '
                                     +'FROM '+cDBTableDetType+' WHERE '+cFieldDetTypeID+' ='+#39+aIdD+#39);
    ADOQueryDosType.Active:=True;

    typeD:=ADOQueryDosType.FieldByName(cFieldDetType).AsString;

    for i:=0 to aCBoxD.Items.Count-1 do
    begin
      if (typeD = aCBoxD.Items[i]) then
      begin
        aCBoxD.ItemIndex:=i;
        break;
      end;
    end;
  end;

begin
// заполняем комбобоксы наборами доступных детекторов

  if DBGridEhDosType.DataSource.DataSet.Active then
  begin

    DosTypeName:=DBGridEhDosType.DataSource.DataSet.FieldByName(cFieldDosType).AsString;

    ADOQueryDosType.Active:=False;
    ADOQueryDosType.SQL.Clear;
    ADOQueryDosType.SQL.Add('SELECT '+cFieldDosTypeID+', '+cFieldDosType+' FROM '+cDBTableDosType+' WHERE '+cFieldDosType+'='+#39+DosTypeName+#39);
    ADOQueryDosType.Active:=True;

    DosTypeID:=ADOQueryDosType.FieldByName(cFieldDosTypeID).AsString;
    EditDosType.Text:=ADOQueryDosType.FieldByName(cFieldDosType).AsString;

    ADOQueryDosType.Active:=False;
    ADOQueryDosType.SQL.Clear;
    ADOQueryDosType.SQL.Add('SELECT '
                                     +cFieldDetType+','
                                     +cFieldMethod+' '
                             +'FROM '
                                     +cDBTableDetType+' '
                            +'WHERE '
                                     +cFieldDetType+'<>'+#39+cDetMat_None+#39+' '
                            +'ORDER BY '
                                     +cFieldDetTypeID);
    ADOQueryDosType.Active:=True;
  // заполненеи комбобоксов типов детекторов
    ComboBoxD1.Items.Clear;
    ComboBoxD2.Items.Clear;
    ComboBoxD3.Items.Clear;
    ComboBoxD4.Items.Clear;

    for i := 1 to ADOQueryDosType.RecordCount do
    begin
      if ADOQueryDosType.FieldValues[cFieldMethod]<>cMethod_None then ComboBoxD1.Items.Add(ADOQueryDosType.FieldValues[cFieldDetType]);
      if ADOQueryDosType.FieldValues[cFieldMethod]<>cMethod_None then ComboBoxD2.Items.Add(ADOQueryDosType.FieldValues[cFieldDetType]);
      if ADOQueryDosType.FieldValues[cFieldMethod]<>cMethod_None then ComboBoxD3.Items.Add(ADOQueryDosType.FieldValues[cFieldDetType]);
      if ADOQueryDosType.FieldValues[cFieldMethod]<>cMethod_None then ComboBoxD4.Items.Add(ADOQueryDosType.FieldValues[cFieldDetType]);
      if i <> ADOQueryDosType.RecordCount then
         ADOQueryDosType.Next;
    end;

    ADOQueryDosType.Active:=False;
    ADOQueryDosType.SQL.Clear;
    ADOQueryDosType.SQL.Add('SELECT '+cFieldDType1+','
                                     +cFieldDType2+','
                                     +cFieldDType3+','
                                     +cFieldDType4+','
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
                                     +'FROM '+cDBTableDosType+' WHERE '+cFieldDosType+'='+#39+EditDosType.Text+#39);
    ADOQueryDosType.Active:=True;

    idD1:=ADOQueryDosType.FieldByName(cFieldDType1).AsString;
    idD2:=ADOQueryDosType.FieldByName(cFieldDType2).AsString;
    idD3:=ADOQueryDosType.FieldByName(cFieldDType3).AsString;
    idD4:=ADOQueryDosType.FieldByName(cFieldDType4).AsString;

    EditValErrK1_1.Text:=ADOQueryDosType.FieldByName(cFieldFormula_Err_k1_1).AsString;
    EditValErrK2_1.Text:=ADOQueryDosType.FieldByName(cFieldFormula_Err_k2_1).AsString;
    EditValErrK1_2.Text:=ADOQueryDosType.FieldByName(cFieldFormula_Err_k1_2).AsString;
    EditValErrK2_2.Text:=ADOQueryDosType.FieldByName(cFieldFormula_Err_k2_2).AsString;
    EditValErrK1_3.Text:=ADOQueryDosType.FieldByName(cFieldFormula_Err_k1_3).AsString;
    EditValErrK2_3.Text:=ADOQueryDosType.FieldByName(cFieldFormula_Err_k2_3).AsString;
    EditValErrK1_4.Text:=ADOQueryDosType.FieldByName(cFieldFormula_Err_k1_4).AsString;
    EditValErrK2_4.Text:=ADOQueryDosType.FieldByName(cFieldFormula_Err_k2_4).AsString;

    DetectorsCnt:=0;

    if StrToIntRegion(idD1) > 0 then inc(DetectorsCnt);
    if StrToIntRegion(idD2) > 0 then inc(DetectorsCnt);
    if StrToIntRegion(idD3) > 0 then inc(DetectorsCnt);
    if StrToIntRegion(idD4) > 0 then inc(DetectorsCnt);

    CBoxDetsCnt.ItemIndex:=CBoxDetsCnt.Items.IndexOf(IntToStr(DetectorsCnt));

    // заполнение комбобокса фолрмулы дозиметра
    CBoxMeasValue.Items.Clear;

    case DetectorsCnt of
      cDetPos1:
      begin
        for i := Low(cDetMeasValTxt_1d) to High(cDetMeasValTxt_1d) do
          if cDetMeasValTxt_1d[i] <> c_none then CBoxMeasValue.Items.Add(cDetMeasValTxt_AllVal[cDetMeasValTxt_1d[i]]);
      end;
      cDetPos2:
      begin
        for i := Low(cDetMeasValTxt_2d) to High(cDetMeasValTxt_2d) do
          if cDetMeasValTxt_2d[i] <> c_none then CBoxMeasValue.Items.Add(cDetMeasValTxt_AllVal[cDetMeasValTxt_2d[i]]);
      end;
      cDetPos3:
      begin
        for i := Low(cDetMeasValTxt_3d) to High(cDetMeasValTxt_3d) do
          if cDetMeasValTxt_3d[i] <> c_none then CBoxMeasValue.Items.Add(cDetMeasValTxt_AllVal[cDetMeasValTxt_3d[i]]);
      end;
      cDetPos4:
      begin
        for i := Low(cDetMeasValTxt_4d) to High(cDetMeasValTxt_4d) do
          if cDetMeasValTxt_4d[i] <> c_none then CBoxMeasValue.Items.Add(cDetMeasValTxt_AllVal[cDetMeasValTxt_4d[i]]);
      end;
    end;

    CBoxMeasValue.ItemIndex:=CBoxMeasValue.Items.IndexOf(cDetMeasValTxt_AllVal[ADOQueryDosType.FieldByName(cFieldFormulaId_Dos).AsInteger]);
    CBoxMeasValueChange(Self);

    SetComboBoxes(idD1,ComboBoxD1);
    SetComboBoxes(idD2,ComboBoxD2);
    SetComboBoxes(idD3,ComboBoxD3);
    SetComboBoxes(idD4,ComboBoxD4);

    ComboBoxD1.OnChange(Self);
    ComboBoxD2.OnChange(Self);
    ComboBoxD3.OnChange(Self);
    ComboBoxD4.OnChange(Self);

    CheckEnableControls;

  end;
end;

procedure TDosimeterTypeConstructorForm.UnlockControls(Value: boolean);
begin
  if AW.IsHaveIRight(crMain_DosimeterType) then
  begin
    CBoxDetsCnt.Enabled:=Value;
    CBoxMeasValue.Enabled:=Value;
    ComboBoxD1.Enabled:=Value;
    ComboBoxD2.Enabled:=Value;
    ComboBoxD3.Enabled:=Value;
    ComboBoxD4.Enabled:=Value;
    EditValErrK1_1.Enabled:=Value;
    EditValErrK2_1.Enabled:=Value;
    EditValErrK1_2.Enabled:=Value;
    EditValErrK2_2.Enabled:=Value;
    EditValErrK1_3.Enabled:=Value;
    EditValErrK2_3.Enabled:=Value;
    EditValErrK1_4.Enabled:=Value;
    EditValErrK2_4.Enabled:=Value;
    SpeedBtnDelDosPart.Enabled:=Value;
    BtnSaveChanges.Enabled:=Value;
  end;
end;

procedure TDosimeterTypeConstructorForm.CheckEnableControls;
begin
  case IndexStr(AnsiString(DosTypeName), cDosTypes) of
    0..Length(cDosTypes):
      UnlockControls(false);
    else
      UnlockControls(true);
  end;
end;

procedure TDosimeterTypeConstructorForm.MemoDisable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=false;
end;

procedure TDosimeterTypeConstructorForm.MemoEnable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=true;
end;

procedure TDosimeterTypeConstructorForm.CBoxDetsCntChange(Sender: TObject);
var
  i: integer;
begin
  DetectorsCnt:=StrToIntRegion(CBoxDetsCnt.Text);

  CBoxMeasValue.Items.Clear;

  case DetectorsCnt of
    cDetPos1:
    begin
      for i := Low(cDetMeasValTxt_1d) to High(cDetMeasValTxt_1d) do
        if cDetMeasValTxt_1d[i] <> c_none then  CBoxMeasValue.Items.Add(cDetMeasValTxt_AllVal[cDetMeasValTxt_1d[i]]);
    end;
    cDetPos2:
    begin
      for i := Low(cDetMeasValTxt_2d) to High(cDetMeasValTxt_2d) do
        if cDetMeasValTxt_2d[i] <> c_none then CBoxMeasValue.Items.Add(cDetMeasValTxt_AllVal[cDetMeasValTxt_2d[i]]);
    end;
    cDetPos3:
    begin
      for i := Low(cDetMeasValTxt_3d) to High(cDetMeasValTxt_3d) do
        if cDetMeasValTxt_3d[i] <> c_none then CBoxMeasValue.Items.Add(cDetMeasValTxt_AllVal[cDetMeasValTxt_3d[i]]);
    end;
    cDetPos4:
    begin
      for i := Low(cDetMeasValTxt_4d) to High(cDetMeasValTxt_4d) do
        if cDetMeasValTxt_4d[i] <> c_none then CBoxMeasValue.Items.Add(cDetMeasValTxt_AllVal[cDetMeasValTxt_4d[i]]);
    end;
  end;

  CBoxMeasValue.ItemIndex:=0;

  CBoxMeasValueChange(Self);
end;

procedure TDosimeterTypeConstructorForm.CBoxMeasValueChange(Sender: TObject);
begin
  ChangeDosTypeParameters(CBoxMeasValue);
end;

procedure TDosimeterTypeConstructorForm.ChangeDosTypeParameters(CBox: TCombobox);
  var
    i             : integer;
    formulaIndex  : integer;
//  procedure ClearEdits(EditValDet,EditKD,EditValDos: TEdit);
//  begin
//    EditValDet.Clear;
//    EditKD.Clear;
//    EditValDos.Clear;
//  end;
  procedure ClearEdit(EditMeasVal,EditFormula,EditErrK1,EditErrK2: TEdit;
                      LblDelta,LblHErr,LblPlus,LblPercent: TLabel;
                      ShapeLine: TShape);
  begin
//    EditMeasVal.Clear;
//    EditFormula.Clear;
//    EditErrK1.Clear;
//    EditErrK2.Clear;
    EditMeasVal.Visible:=false;
    EditFormula.Visible:=false;
    EditErrK1.Visible:=false;
    EditErrK2.Visible:=false;
    LblDelta.Visible:=false;
    LblPercent.Visible:=false;
    LblHErr.Visible:=false;
    LblPlus.Visible:=false;
    ShapeLine.Visible:=false;
  end;
  procedure SetEdits(EditValD,EditKD: TEdit; CBoxMath: TComboBox; Value,K: String);
  begin
    EditValD.Text:=Value;
    EditKD.Text:=K;
    if CBoxMath.ItemIndex<0 then
    begin
      CBoxMath.ItemIndex:=0;
      CBoxMath.OnChange(Self);
    end;
  end;
  procedure SetFormulaEdits(EditVal,EditFormula,EditErr: TEdit; LblPercent: TLabel; Value,Formula: String);
  begin
    EditVal.Visible:=true;
    EditFormula.Visible:=true;
    EditErr.Visible:=true;
    LblPercent.Visible:=true;
    EditVal.Text:=Value;
    EditFormula.Text:=Formula;
  end;

  procedure SetFormulaEdit (EditMeasVal,EditFormula,EditErrK1,EditErrK2: TEdit;
                     MeasVal,Formula: String;
                     LblDelta,LblHErr,LblPlus,LblPercent: TLabel;
                     ShapeLine: TShape);
  begin
    EditMeasVal.Text:=MeasVal;
    LblHErr.Caption:=MeasVal;
    EditFormula.Text:=Formula;
//    LblDelta.Caption:=Format('%s = ',[cuUnicodeSymbol_Delta]);
    LblDelta.Caption:=Format('%s = ',[cuUnicodeSymbol_Delta]);
//    EditErrK1.Text:=ErrK1;
//    EditErrK2.Text:=ErrK2;
    EditMeasVal.Visible:=true;
    EditFormula.Visible:=true;
    EditErrK1.Visible:=true;
    EditErrK2.Visible:=true;
    LblDelta.Visible:=true;
    LblHErr.Visible:=true;
    LblPlus.Visible:=true;
    LblPercent.Visible:=true;
    ShapeLine.Visible:=true;
  end;

begin

  ClearEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,LblErr1,LblHErr_1,LblPlus_1,LblValPercent_1,ShapeErr_1);
  ClearEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,LblErr2,LblHErr_2,LblPlus_2,LblValPercent_2,ShapeErr_2);
  ClearEdit(EditDosMeasVal_3,EditFormulaVal_3,EditValErrK1_3,EditValErrK2_3,LblErr3,LblHErr_3,LblPlus_3,LblValPercent_3,ShapeErr_3);
  ClearEdit(EditDosMeasVal_4,EditFormulaVal_4,EditValErrK1_4,EditValErrK2_4,LblErr4,LblHErr_4,LblPlus_4,LblValPercent_4,ShapeErr_4);


//  ClearEdits(EditMeasValD1,EditKD1,EditDosMeasVal_1);
//  ClearEdits(EditMeasValD2,EditKD2,EditDosMeasVal_2);
//  ClearEdits(EditMeasValD3,EditKD3,EditDosMeasVal_3);
//  ClearEdits(EditMeasValD4,EditKD4,EditDosMeasVal_4);

  GBoxD1.Visible:=true;
  GBoxD2.Visible:=true;
  GBoxD3.Visible:=true;
  GBoxD4.Visible:=true;

//  EditDosMeasVal_1.Visible:=false;
//  EditDosMeasVal_2.Visible:=false;
//  EditDosMeasVal_3.Visible:=false;
//  EditDosMeasVal_4.Visible:=false;
//
//  EditFormulaVal_1.Visible:=false;
//  EditFormulaVal_2.Visible:=false;
//  EditFormulaVal_3.Visible:=false;
//  EditFormulaVal_4.Visible:=false;
//
//  EditValErrK1_1.Visible:=false;
//  EditValErrK2_1.Visible:=false;
//  EditValErrK1_2.Visible:=false;
//  EditValErrK2_2.Visible:=false;
//  EditValErrK1_3.Visible:=false;
//  EditValErrK2_3.Visible:=false;
//  EditValErrK1_4.Visible:=false;
//  EditValErrK2_4.Visible:=false;
//
//  LblValPercent_1.Visible:=false;
//  LblValPercent_2.Visible:=false;
//  LblValPercent_3.Visible:=false;
//  LblValPercent_4.Visible:=false;

  formulaIndex:=0;

  for i := Low(cDetMeasValTxt_AllVal) to High(cDetMeasValTxt_AllVal) do
  begin
    if cDetMeasValTxt_AllVal[i]=CBox.Text then
    begin
      formulaIndex:=i;
      break;
    end;
  end;

  Formula_id_dos:=formulaIndex;

  FormulaIdVal_1:=0;
  FormulaIdVal_2:=0;
  FormulaIdVal_3:=0;
  FormulaIdVal_4:=0;

  case cDetMeasValTxt_Index[formulaIndex] of
    c_none:
    begin
      GBoxD1.Visible:=false;
      GBoxD2.Visible:=false;
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
    end;
    cHp_10g_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD2.Visible:=false;
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);

      FormulaIdVal_1:=cMeanD1_K1;
    end;
    cHp_10g_2d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1D2_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2_K1;
    end;
    cHp_10g_3d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD4.Visible:=false;
//      SetFormulaEdits(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,LblValPercent_1,cHp_10g,cArrayFormulasTxt[сMeanD1D2D3_K1]);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1D2D3_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3_K1;
    end;
    cHp_10g_4d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD4,EditKD4,ComboBoxD4,Format('%s: %s',[cDet4,cuUnicodeSymbol_Gamma]),cK1);
//      SetFormulaEdits(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,LblValPercent_1,cHp_10g,cArrayFormulasTxt[сMeanD1D2D3D4_K1]);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1D2D3D4_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3D4_K1;
    end;
    cHp_10g_2d_Hp_10n_2d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s+%s',[cDet3,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]),cK2);
      SetEdits(EditMeasValD4,EditKD4,ComboBoxD4,Format('%s: %s+%s',[cDet4,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]),cK2);
//      SetFormulaEdits(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,LblValPercent_1,cHp_10g,cArrayFormulasTxt[сMeanD1D2_K1]);
//      SetFormulaEdits(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,LblValPercent_2,cHp_10n,cArrayFormulasTxt[сMeanD3D4_K2_D1D2_K1_Kgn]);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1D2_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      SetFormulaEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,
                     cHp_10n,cArrayFormulasTxt[cMeanD3D4_K2_D1D2_K1_Kgn],
                     LblErr2,
                     LblHErr_2,
                     LblPlus_2,
                     LblValPercent_2,
                     ShapeErr_2);
      FormulaIdVal_1:=cMeanD1D2_K1;
      FormulaIdVal_2:=cMeanD3D4_K2_D1D2_K1_Kgn;
    end;
    cHp_10g_2d_Hp_10n_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s+%s',[cDet3,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]),cK2);
      GBoxD4.Visible:=false;
//      SetFormulaEdits(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,LblValPercent_1,cHp_10g,cArrayFormulasTxt[сMeanD1D2_K1]);
//      SetFormulaEdits(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,LblValPercent_2,cHp_10n,cArrayFormulasTxt[сMeanD3_K2_D1D2_K1_Kgn]);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1D2_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      SetFormulaEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,
                     cHp_10n,cArrayFormulasTxt[cMeanD3_K2_D1D2_K1_Kgn],
                     LblErr2,
                     LblHErr_2,
                     LblPlus_2,
                     LblValPercent_2,
                     ShapeErr_2);
      FormulaIdVal_1:=cMeanD1D2_K1;
      FormulaIdVal_2:=cMeanD3_K2_D1D2_K1_Kgn;
    end;
    cHp_10g_1d_Hp_10n_2d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]),cK2);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s+%s',[cDet3,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]),cK2);
      GBoxD4.Visible:=false;
//      SetFormulaEdits(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,LblValPercent_1,cHp_10g,cArrayFormulasTxt[сMeanD1_K1]);
//      SetFormulaEdits(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,LblValPercent_2,cHp_10n,cArrayFormulasTxt[сMeanD2D3_K2_D1_K1_Kgn]);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      SetFormulaEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,
                     cHp_10n,cArrayFormulasTxt[cMeanD2D3_K2_D1_K1_Kgn],
                     LblErr2,
                     LblHErr_2,
                     LblPlus_2,
                     LblValPercent_2,
                     ShapeErr_2);
      FormulaIdVal_1:=cMeanD1_K1;
      FormulaIdVal_2:=cMeanD2D3_K2_D1_K1_Kgn;
    end;
    cHp_10g_1d_Hp_10n_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]),cK2);
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      SetFormulaEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,
                     cHp_10n,cArrayFormulasTxt[cMeanD2_K2_D1_K1_Kgn],
                     LblErr2,
                     LblHErr_2,
                     LblPlus_2,
                     LblValPercent_2,
                     ShapeErr_2);
      FormulaIdVal_1:=cMeanD1_K1;
      FormulaIdVal_2:=cMeanD2_K2_D1_K1_Kgn;
    end;
    cHp_007g_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD2.Visible:=false;
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_007,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1_K1;
    end;
    cHp_007g_2d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_007,cArrayFormulasTxt[cMeanD1D2_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2_K1;
    end;
    cHp_007g_3d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_007,cArrayFormulasTxt[cMeanD1D2D3_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3_K1;
    end;
    cHp_007g_4d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD4,EditKD4,ComboBoxD4,Format('%s: %s',[cDet4,cuUnicodeSymbol_Gamma]),cK1);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_007,cArrayFormulasTxt[cMeanD1D2D3D4_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3D4_K1;
    end;
    cHp_007gb_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s+%s',[cDet1,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      GBoxD2.Visible:=false;
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_007,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1_K1;
    end;
    cHp_007gb_2d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s+%s',[cDet1,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_007,cArrayFormulasTxt[cMeanD1D2_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2_K1;
    end;
    cHp_007gb_3d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s+%s',[cDet1,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s+%s',[cDet3,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_007,cArrayFormulasTxt[cMeanD1D2D3_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3_K1;
    end;
    cHp_007gb_4d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s+%s',[cDet1,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s+%s',[cDet3,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD4,EditKD4,ComboBoxD4,Format('%s: %s+%s',[cDet4,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_007,cArrayFormulasTxt[cMeanD1D2D3D4_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3D4_K1;
    end;
    cHp_3_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s+%s',[cDet1,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      GBoxD2.Visible:=false;
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_3,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1_K1;
    end;
    cHp_3_2d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s+%s',[cDet1,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD1,Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_3,cArrayFormulasTxt[cMeanD1D2_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2_K1;
    end;
    cHp_3_3d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s+%s',[cDet1,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s+%s',[cDet3,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_3,cArrayFormulasTxt[cMeanD1D2D3_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3_K1;
    end;
    cHp_3_4d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s+%s',[cDet1,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s+%s',[cDet3,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetEdits(EditMeasValD4,EditKD4,ComboBoxD4,Format('%s: %s+%s',[cDet4,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Beta]),cK1);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_3,cArrayFormulasTxt[cMeanD1D2D3D4_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3D4_K1;
    end;
    cHp_star_g_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD2.Visible:=false;
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cH_star,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1_K1;
    end;
    cHp_star_g_2d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cH_star,cArrayFormulasTxt[cMeanD1D2_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2_K1;
    end;
    cHp_star_g_3d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cH_star,cArrayFormulasTxt[cMeanD1D2D3_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3_K1;
    end;
    cHp_star_g_4d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD4,EditKD4,ComboBoxD4,Format('%s: %s',[cDet4,cuUnicodeSymbol_Gamma]),cK1);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cH_star,cArrayFormulasTxt[cMeanD1D2D3D4_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3D4_K1;
    end;
    cH_007_dir_g_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD2.Visible:=false;
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cH_007_dir,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1_K1;
    end;
    cH_007_dir_g_2d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cH_007_dir,cArrayFormulasTxt[cMeanD1D2_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2_K1;
    end;
    cH_007_dir_g_3d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK1);
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cH_007_dir,cArrayFormulasTxt[cMeanD1D2D3_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3_K1;
    end;
    cH_007_dir_g_4d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD4,EditKD4,ComboBoxD4,Format('%s: %s',[cDet4,cuUnicodeSymbol_Gamma]),cK1);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cH_007_dir,cArrayFormulasTxt[cMeanD1D2D3D4_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3D4_K1;
    end;
    cD_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,cD,cK1);
      GBoxD2.Visible:=false;
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cD,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1_K1;
    end;
    cD_2d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,cD,cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,cD,cK1);
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cD,cArrayFormulasTxt[cMeanD1D2_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2_K1;
    end;
    cD_3d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,cD,cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,cD,cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,cD,cK1);
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cD,cArrayFormulasTxt[cMeanD1D2D3_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3_K1;
    end;
    cD_4d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,cD,cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,cD,cK1);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,cD,cK1);
      SetEdits(EditMeasValD4,EditKD4,ComboBoxD4,cD,cK1);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cD,cArrayFormulasTxt[cMeanD1D2D3D4_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      FormulaIdVal_1:=cMeanD1D2D3D4_K1;
    end;
    cHp_10g_Hp_10n_Hp_007g_Hp_3:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s+%s',[cDet2,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]),cK2);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK3);
      SetEdits(EditMeasValD4,EditKD4,ComboBoxD4,Format('%s: %s+%s',[cDet4,cuUnicodeSymbol_Gamma,cuUnicodeSymbol_Neutron]),cK4);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      SetFormulaEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,
                     cHp_10n,cArrayFormulasTxt[cMeanD2_K2_D1_K1_Kgn],
                     LblErr2,
                     LblHErr_2,
                     LblPlus_2,
                     LblValPercent_2,
                     ShapeErr_2);
      SetFormulaEdit(EditDosMeasVal_3,EditFormulaVal_3,EditValErrK1_3,EditValErrK2_3,
                     cHp_007,cArrayFormulasTxt[cMeanD3_K3],
                     LblErr3,
                     LblHErr_3,
                     LblPlus_3,
                     LblValPercent_3,
                     ShapeErr_3);
      SetFormulaEdit(EditDosMeasVal_4,EditFormulaVal_4,EditValErrK1_4,EditValErrK2_4,
                     cHp_3,cArrayFormulasTxt[cMeanD4_K4],
                     LblErr4,
                     LblHErr_4,
                     LblPlus_4,
                     LblValPercent_4,
                     ShapeErr_4);
      FormulaIdVal_1:=cMeanD1_K1;
      FormulaIdVal_2:=cMeanD2_K2_D1_K1_Kgn;
      FormulaIdVal_3:=cMeanD3_K3;
      FormulaIdVal_4:=cMeanD4_K4;
    end;
    cHp_10g_1d_Hp_007g_1d_Hp_3_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK2);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK3);
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      SetFormulaEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,
                     cHp_007,cArrayFormulasTxt[cMeanD2_K2],
                     LblErr2,
                     LblHErr_2,
                     LblPlus_2,
                     LblValPercent_2,
                     ShapeErr_2);
      SetFormulaEdit(EditDosMeasVal_3,EditFormulaVal_3,EditValErrK1_3,EditValErrK2_3,
                     cHp_3,cArrayFormulasTxt[cMeanD3_K3],
                     LblErr3,
                     LblHErr_3,
                     LblPlus_3,
                     LblValPercent_3,
                     ShapeErr_3);
      FormulaIdVal_1:=cMeanD1_K1;
      FormulaIdVal_2:=cMeanD2_K2;
      FormulaIdVal_3:=cMeanD3_K3;
    end;
    cHp_10g_1d_Hp_007g_1d:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK2);
      GBoxD3.Visible:=false;
      GBoxD4.Visible:=false;
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      SetFormulaEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,
                     cHp_007,cArrayFormulasTxt[cMeanD2_K2],
                     LblErr2,
                     LblHErr_2,
                     LblPlus_2,
                     LblValPercent_2,
                     ShapeErr_2);
      FormulaIdVal_1:=cMeanD1_K1;
      FormulaIdVal_2:=cMeanD2_K2;
    end;
    cHp_10g_2d_Hp_10n_2d_f6776:
    begin
      SetEdits(EditMeasValD1,EditKD1,ComboBoxD1,Format('%s: %s',[cDet1,cuUnicodeSymbol_Gamma]),cK1);
      SetEdits(EditMeasValD2,EditKD2,ComboBoxD2,Format('%s: %s',[cDet2,cuUnicodeSymbol_Gamma]),cK2);
      SetEdits(EditMeasValD3,EditKD3,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK3);
      SetEdits(EditMeasValD3,EditKD4,ComboBoxD3,Format('%s: %s',[cDet3,cuUnicodeSymbol_Gamma]),cK4);
      SetFormulaEdit(EditDosMeasVal_1,EditFormulaVal_1,EditValErrK1_1,EditValErrK2_1,
                     cHp_10g,cArrayFormulasTxt[cMeanD1_K1],
                     LblErr1,
                     LblHErr_1,
                     LblPlus_1,
                     LblValPercent_1,
                     ShapeErr_1);
      SetFormulaEdit(EditDosMeasVal_2,EditFormulaVal_2,EditValErrK1_2,EditValErrK2_2,
                     cHp_10g,cArrayFormulasTxt[cMeanD2_K2],
                     LblErr2,
                     LblHErr_2,
                     LblPlus_2,
                     LblValPercent_2,
                     ShapeErr_2);
      SetFormulaEdit(EditDosMeasVal_3,EditFormulaVal_3,EditValErrK1_3,EditValErrK2_3,
                     cHp_10n,cArrayFormulasTxt[cMeanD3_K3],
                     LblErr3,
                     LblHErr_3,
                     LblPlus_3,
                     LblValPercent_3,
                     ShapeErr_3);
      SetFormulaEdit(EditDosMeasVal_4,EditFormulaVal_4,EditValErrK1_4,EditValErrK2_4,
                     cHp_10n,cArrayFormulasTxt[cMeanD4_K4],
                     LblErr4,
                     LblHErr_4,
                     LblPlus_4,
                     LblValPercent_4,
                     ShapeErr_4);
      FormulaIdVal_1:=cMeanD1_K1;
      FormulaIdVal_2:=cMeanD2_K2;
      FormulaIdVal_3:=cMeanD3_K3;
      FormulaIdVal_4:=cMeanD4_K4;
    end;
  end;

  // измеряемые величины
  DosMeasValues:='';

  if EditDosMeasVal_1.Visible then
    DosMeasValues:=EditDosMeasVal_1.Text;
  if EditDosMeasVal_2.Visible then
    if Pos(EditDosMeasVal_2.Text,DosMeasValues)=0 then DosMeasValues:=DosMeasValues+','+EditDosMeasVal_2.Text;
  if EditDosMeasVal_3.Visible then
    if Pos(EditDosMeasVal_3.Text,DosMeasValues)=0 then DosMeasValues:=DosMeasValues+','+EditDosMeasVal_3.Text;
  if EditDosMeasVal_4.Visible then
    if Pos(EditDosMeasVal_4.Text,DosMeasValues)=0 then DosMeasValues:=DosMeasValues+','+EditDosMeasVal_4.Text;

//  DosMeasValues:='';
//  if GBoxD1.Visible then
//    DosMeasValues:=EditMeasValD1.Text;
//  if GBoxD2.Visible then
//    if Pos(EditMeasValD2.Text,DosMeasValues)=0 then DosMeasValues:=DosMeasValues+','+EditMeasValD2.Text;
//  if GBoxD3.Visible then
//    if Pos(EditMeasValD3.Text,DosMeasValues)=0 then DosMeasValues:=DosMeasValues+','+EditMeasValD3.Text;
//  if GBoxD4.Visible then
//    if Pos(EditMeasValD4.Text,DosMeasValues)=0 then DosMeasValues:=DosMeasValues+','+EditMeasValD4.Text;
end;

procedure TDosimeterTypeConstructorForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TDosimeterTypeConstructorForm.CBoxDetChange(aCBox: TComboBox; aMemo: TMemo; EditMethod: TEdit);
var
  str: string;
begin

  // убрать?
  {ADOQueryDosType.Active:=False;
  ADOQueryDosType.SQL.Clear;
  ADOQueryDosType.SQL.Add('SELECT '+cFieldDetType+' FROM '+cDBTableDetType);
  ADOQueryDosType.Active:=True;}

  if aCBox.Text<>cNo_Val then
  begin
    ADOQueryDosType.Active:=False;
    ADOQueryDosType.SQL.Clear;
    // запрос только двух полей
    ADOQueryDosType.SQL.Add('SELECT '+cFieldMethod+', '+cFieldDetTypeComment+' FROM '+cDBTableDetType+' WHERE '+cFieldDetType+'='+#39+aCBox.Text+#39);
    ADOQueryDosType.Active:=True;

    EditMethod.Text:=ADOQueryDosType.FieldByName(cFieldMethod).AsString;

    aMemo.Clear;
    str:=GetProfileString(ADOQueryDosType.FieldByName(cFieldDetTypeComment).AsString);
    aMemo.Lines.Add(GetProfileString(ADOQueryDosType.FieldByName(cFieldDetTypeComment).AsString));
  end
  else
  begin
    aMemo.Clear;
  end;
end;

procedure TDosimeterTypeConstructorForm.ComboBoxD1Change(Sender: TObject);
begin
  CBoxDetChange(ComboBoxD1,MemoD1,EditMethodD1);
end;

procedure TDosimeterTypeConstructorForm.ComboBoxD2Change(Sender: TObject);
begin
  CBoxDetChange(ComboBoxD2,MemoD2,EditMethodD2);
end;

procedure TDosimeterTypeConstructorForm.ComboBoxD3Change(Sender: TObject);
begin
  CBoxDetChange(ComboBoxD3,MemoD3,EditMethodD3);
end;

procedure TDosimeterTypeConstructorForm.ComboBoxD4Change(Sender: TObject);
begin
  CBoxDetChange(ComboBoxD4,MemoD4,EditMethodD4);
end;

procedure TDosimeterTypeConstructorForm.ComboBoxKD1DropDown(Sender: TObject);
begin
  if TCombobox(Sender).Items.IndexOf(cNo_Val)>=0 then
  begin
    TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cNo_Val));
    TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cK2));
    TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cK3));
    TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cK4));
  end;
end;

procedure TDosimeterTypeConstructorForm.ComboBoxKD2DropDown(Sender: TObject);
begin
  if TCombobox(Sender).Items.IndexOf(cNo_Val)>=0 then
  begin
    TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cNo_Val));
    TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cK3));
    TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cK4));
  end;
end;

procedure TDosimeterTypeConstructorForm.ComboBoxKD3DropDown(Sender: TObject);
begin
  if TCombobox(Sender).Items.IndexOf(cNo_Val)>=0 then
  begin
    if TCombobox(Sender).Items.IndexOf(cK1)>0 then
    begin
      TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cNo_Val));
      TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cK3));
      TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cK4));
    end;
    if TCombobox(Sender).Items.IndexOf(cK2)>0 then
    begin
      TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cNo_Val));
      TCombobox(Sender).Items.Delete(TCombobox(Sender).Items.IndexOf(cK4));
    end;
  end;
end;

procedure TDosimeterTypeConstructorForm.DBGridEhDosTypeCellClick(Column: TColumnEh);
begin
  LoadDosTypeParameters;
end;

procedure TDosimeterTypeConstructorForm.BtnSaveChangesClick(Sender: TObject);
begin
  UpdateDosType;
end;

procedure TDosimeterTypeConstructorForm.DBGridEhDosTypeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  LoadDosTypeParameters;
end;

procedure TDosimeterTypeConstructorForm.RefreshDosTypeList;
begin
  if TLDDataModule.IsDBConnected then
  begin
    ADOQueryDosType.SQL.Clear;
    ADOQueryDosType.SQL.Add('SELECT '+cFieldDosTypeID+','+cFieldDosType+' FROM '+cDBTableDosType+' WHERE '+cFieldDosTypeID+'>0 ORDER BY '+cFieldDosTypeID);
    ADOQueryDosType.Active:=true;

    ADOQueryDosType.Open;

    if MemTableEhDosType.Active then MemTableEhDosType.Active:=false;

    MemTableEhDosType.Active:=true;

    DBGridEhDosType.Columns[DBGridEhDosType.DataSource.DataSet.FieldByName(cFieldDosTypeID).Index].Visible:=false;
    DBGridEhDosType.Columns[DBGridEhDosType.DataSource.DataSet.FieldByName(cFieldDosType).Index].Width:=PanelGrid.Width-DBGridEhDosType.CalcIndicatorColWidth-8;
    DBGridEhDosType.Columns[DBGridEhDosType.DataSource.DataSet.FieldByName(cFieldDosType).Index].Title.Caption:=rsTypeName;
    DBGridEhDosType.DataSource.DataSet.Locate(cFieldDosType,DosTypeName,[]);

    ADOQueryDosType.Close;

//    PanelGrid.OnResize(Self);
  end;
end;

procedure TDosimeterTypeConstructorForm.SetEditAvailable(const Value: boolean);
begin
//  FEditAvailable:=Value;
//
//  CBoxDetsCnt.Enabled:=Value;
//  CBoxMeasValue.Enabled:=Value;
//  ComboBoxD1.Enabled:=Value;
//  ComboBoxD2.Enabled:=Value;
//  ComboBoxD3.Enabled:=Value;
//  ComboBoxD4.Enabled:=Value;
//  EditValErrK1_1.Enabled:=Value;
//  EditValErrK2_1.Enabled:=Value;
//  EditValErrK1_2.Enabled:=Value;
//  EditValErrK2_2.Enabled:=Value;
//  EditValErrK1_3.Enabled:=Value;
//  EditValErrK2_3.Enabled:=Value;
//  EditValErrK1_4.Enabled:=Value;
//  EditValErrK2_4.Enabled:=Value;
//  SpeedBtnDelDosPart.Enabled:=Value;
//  SpeedBtnAddDosType.Enabled:=Value;
//  SpeedBtnSaveChanges.Enabled:=Value;
//  DBGridEhDosType.Enabled:=Value;

//  if Value then
//    SpeedBtnEditAvailable.Caption:='Заблокировать'
//  else
//    SpeedBtnEditAvailable.Caption:='Разблокировать';

  CheckEnableControls;
end;

procedure TDosimeterTypeConstructorForm.SpeedBtnAddDosTypeClick(Sender: TObject);
begin
  EnterNewDosTypeForm.ShowModal;
end;

procedure TDosimeterTypeConstructorForm.SpeedBtnD1InfClick(Sender: TObject);
begin
  DetectorConstructorForm.DetTypeName:=ComboBoxD1.Text;
  DetectorConstructorForm.ShowModal;
end;

procedure TDosimeterTypeConstructorForm.SpeedBtnDelDosPartClick(Sender: TObject);
var
  temp  : word;
begin
  temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format(rsDeleteType,[DosTypeName]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

  case temp of
    mrYes:                   // если нажали продолжить
    begin
      DeleteDosType(DosTypeName);
    end;
  end;
end;

procedure TDosimeterTypeConstructorForm.SpeedBtnSaveChangesClick(Sender: TObject);
begin
  UpdateDosType;
end;

procedure TDosimeterTypeConstructorForm.SpeedButton1Click(Sender: TObject);
begin
  DetectorConstructorForm.DetTypeName:=ComboBoxD2.Text;
  DetectorConstructorForm.ShowModal;
end;

procedure TDosimeterTypeConstructorForm.SpeedButton2Click(Sender: TObject);
begin
  DetectorConstructorForm.DetTypeName:=ComboBoxD3.Text;
  DetectorConstructorForm.ShowModal;
end;

procedure TDosimeterTypeConstructorForm.SpeedButton3Click(Sender: TObject);
begin
  DetectorConstructorForm.DetTypeName:=ComboBoxD4.Text;
  DetectorConstructorForm.ShowModal;
end;

procedure TDosimeterTypeConstructorForm.UpdateDosType;
var
  errValK1_1: double;
  errValK2_1: double;
  errValK1_2: double;
  errValK2_2: double;
  errValK1_3: double;
  errValK2_3: double;
  errValK1_4: double;
  errValK2_4: double;
  type_d1:  integer;
  type_d2:  integer;
  type_d3:  integer;
  type_d4:  integer;
  function GetErr(Flag: boolean; Err: String): double;
  begin
    if Flag then
      Result:=StrToFloatRegion(Err)
    else
      Result:=0;
  end;
begin
  if TLDDataModule.IsDBConnected then
  begin

    errValK1_1:=GetErr(EditFormulaVal_1.Visible,EditValErrK1_1.Text);
    errValK2_1:=GetErr(EditFormulaVal_1.Visible,EditValErrK2_1.Text);
    errValK1_2:=GetErr(EditFormulaVal_2.Visible,EditValErrK1_2.Text);
    errValK2_2:=GetErr(EditFormulaVal_2.Visible,EditValErrK2_2.Text);
    errValK1_3:=GetErr(EditFormulaVal_3.Visible,EditValErrK1_3.Text);
    errValK2_3:=GetErr(EditFormulaVal_3.Visible,EditValErrK2_3.Text);
    errValK1_4:=GetErr(EditFormulaVal_4.Visible,EditValErrK1_4.Text);
    errValK2_4:=GetErr(EditFormulaVal_4.Visible,EditValErrK2_4.Text);

    if GBoxD1.Visible then type_d1:=TLDDataModule.GetDetTypeID(ComboBoxD1.Text) else type_d1:=0;
    if GBoxD2.Visible then type_d2:=TLDDataModule.GetDetTypeID(ComboBoxD2.Text) else type_d2:=0;
    if GBoxD3.Visible then type_d3:=TLDDataModule.GetDetTypeID(ComboBoxD3.Text) else type_d3:=0;
    if GBoxD4.Visible then type_d4:=TLDDataModule.GetDetTypeID(ComboBoxD4.Text) else type_d4:=0;

    ADOQueryDosType.Active:=False;
    ADOQueryDosType.SQL.Clear;
    ADOQueryDosType.SQL.Add('SELECT '+cFieldDosType+' FROM '+cDBTableDosType+' WHERE '+cFieldDosType+' = '+#39+EditDosType.Text+#39);
    ADOQueryDosType.Active:=True;

    if ((DosTypeName = EditDosType.Text) OR (ADOQueryDosType.RecordCount = 0)) then
    begin
      // update таблицы типов дозиметров
      ADOQueryDosType.Active:=False;
      ADOQueryDosType.SQL.Clear;
      ADOQueryDosType.SQL.Add('UPDATE '+cDBTableDosType+' SET '+cFieldDosType+            '='   +#39+EditDosType.Text+#39+','
                                                               +cFieldMeasVal+            '='   +#39+DosMeasValues+#39+','
                                                               +cFieldDType1+             '='   +#39+IntToStr(type_d1)+#39+','
                                                               +cFieldDType2+             '='   +#39+IntToStr(type_d2)+#39+','
                                                               +cFieldDType3+             '='   +#39+IntToStr(type_d3)+#39+','
                                                               +cFieldDType4+             '='   +#39+IntToStr(type_d4)+#39+','
                                                               +cFieldFormulaId_Dos+      '='   +#39+IntToStr(Formula_id_dos)+#39+','
                                                               +cFieldFormulaId_Val_1+    '='   +#39+IntToStr(FormulaIdVal_1)+#39+','
                                                               +cFieldFormulaId_Val_2+    '='   +#39+IntToStr(FormulaIdVal_2)+#39+','
                                                               +cFieldFormulaId_Val_3+    '='   +#39+IntToStr(FormulaIdVal_3)+#39+','
                                                               +cFieldFormulaId_Val_4+    '='   +#39+IntToStr(FormulaIdVal_4)+#39+','
                                                               +cFieldFormula_Err_k1_1+   '='   +#39+FloatToStrRegion(errValK1_1)+#39+','
                                                               +cFieldFormula_Err_k2_1+   '='   +#39+FloatToStrRegion(errValK2_1)+#39+','
                                                               +cFieldFormula_Err_k1_2+   '='   +#39+FloatToStrRegion(errValK1_2)+#39+','
                                                               +cFieldFormula_Err_k2_2+   '='   +#39+FloatToStrRegion(errValK2_2)+#39+','
                                                               +cFieldFormula_Err_k1_3+   '='   +#39+FloatToStrRegion(errValK1_3)+#39+','
                                                               +cFieldFormula_Err_k2_3+   '='   +#39+FloatToStrRegion(errValK2_3)+#39+','
                                                               +cFieldFormula_Err_k1_4+   '='   +#39+FloatToStrRegion(errValK1_4)+#39+','
                                                               +cFieldFormula_Err_k2_4+   '='   +#39+FloatToStrRegion(errValK2_4)+#39+' '
                                                     +' WHERE '+cFieldDosTypeID+          '='   +#39+DosTypeID+#39);
      ADOQueryDosType.ExecSQL;

      // update таблицы библиотеки дозиметров
      ADOQueryDosType.SQL.Clear;
      ADOQueryDosType.SQL.Add('UPDATE '+cDBTableDosID+' SET '+cFieldDosType+      '='   +#39+EditDosType.Text+#39
                                                   +' WHERE '+cFieldDosTypeID+    '='   +#39+DosTypeID+#39);
      ADOQueryDosType.ExecSQL;

      RefreshDosTypeList;
      DBGridEhDosType.DataSource.DataSet.Locate(cFieldDosType,EditDosType.Text,[]);
      LoadDosTypeParameters;
    end;
  end;
end;

procedure TDosimeterTypeConstructorForm.DeleteDosType(aDosTypeName: String);
begin
  if not TLDDataModule.IsDosimeterTypeUsed(aDosTypeName) then
  begin
    if TLDDataModule.DeleteDosimeterType(aDosTypeName) then
    begin
      DosTypeName:='';
      RefreshDosTypeList;
      LoadDosTypeParameters;
    end
    else
      MessageDlg(Format('%s "%s". %s - %s',[rsErrDeleteDosimeterType,aDosTypeName,rsDetailInfoAtFile,Application.ExeName+PathDelim+cLogFileName]),mtError,[mbOK],0);
  end
  else
    MessageDlg(Format('%s "%s" %s! %s.',[rsDeleteType,aDosTypeName,rsDenied,rsNewDosimeterTypeRegistered]),mtError, [mbOK], 0);
end;

procedure TDosimeterTypeConstructorForm.EditDisable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=false;
end;

procedure TDosimeterTypeConstructorForm.EditEnable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=true;
end;

procedure TDosimeterTypeConstructorForm.FormCreate(Sender: TObject);
begin
  DetectorsCnt:=0;
  CBoxDetsCnt.Items.Add(IntToStr(cDetPos1));
  CBoxDetsCnt.Items.Add(IntToStr(cDetPos2));
  CBoxDetsCnt.Items.Add(IntToStr(cDetPos3));
  CBoxDetsCnt.Items.Add(IntToStr(cDetPos4));

  EditValErrK1_1.Text:='0';
  EditValErrK2_1.Text:='0';
  EditValErrK1_2.Text:='0';
  EditValErrK2_2.Text:='0';
  EditValErrK1_3.Text:='0';
  EditValErrK2_3.Text:='0';
  EditValErrK1_4.Text:='0';
  EditValErrK2_4.Text:='0';
end;

procedure TDosimeterTypeConstructorForm.FormShow(Sender: TObject);
begin
  EditAvailable:=false;
  RefreshDosTypeList;
  LoadDosTypeParameters;
end;

end.
