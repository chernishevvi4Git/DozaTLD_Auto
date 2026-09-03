unit uSQLFilterForm;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  IniFiles, ComCtrls;

type

  TSQLFilterForm = class(TForm)
    PanelClient: TPanel;
    MemoCondition: TMemo;
    MemoSort: TMemo;
    GroupBoxCondition: TGroupBox;
    GroupBoxSort: TGroupBox;
    BtnCheck: TButton;
    PanelBottom: TPanel;
    BtnDrop: TButton;
    LblErr: TLabel;
    BtnApply: TButton;
    BtnAND: TButton;
    BtnOR: TButton;
    BtnGrater: TButton;
    BtnLess: TButton;
    BtnEqual: TButton;
    BtnNotEqual: TButton;
    BtnMeasurmentid: TButton;
    BtnDosimeterid: TButton;
    BtnPostfix: TButton;
    BtnDosimetertype: TButton;
    BtnDose: TButton;
    BtnErr: TButton;
    BtnKSI: TButton;
    BtnMeasurmenttime: TButton;
    BtnRegtime: TButton;
    BtnVertime: TButton;
    BtnValidity: TButton;
    BtnStatus: TButton;
    BtnPartID: TButton;
    BtnTLDID: TButton;
    BtnOrganization: TButton;
    BtnDepartment: TButton;
    BtnDoscomment: TButton;
    BtnMeascomment: TButton;
    procedure BtnDropClick(Sender: TObject);
    procedure BtnCheckClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoConditionChange(Sender: TObject);
    procedure MemoSortChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnANDClick(Sender: TObject);
    procedure BtnORClick(Sender: TObject);
    procedure BtnGraterClick(Sender: TObject);
    procedure BtnLessClick(Sender: TObject);
    procedure BtnEqualClick(Sender: TObject);
    procedure BtnNotEqualClick(Sender: TObject);
    procedure BtnMeasurmentidClick(Sender: TObject);
    procedure BtnDosimeteridClick(Sender: TObject);
    procedure BtnPostfixClick(Sender: TObject);
    procedure BtnDosimetertypeClick(Sender: TObject);
    procedure BtnDoseClick(Sender: TObject);
    procedure BtnErrClick(Sender: TObject);
    procedure BtnKSIClick(Sender: TObject);
    procedure BtnMeasurmenttimeClick(Sender: TObject);
    procedure BtnRegtimeClick(Sender: TObject);
    procedure BtnVertimeClick(Sender: TObject);
    procedure BtnValidityClick(Sender: TObject);
    procedure BtnStatusClick(Sender: TObject);
    procedure BtnPartIDClick(Sender: TObject);
    procedure BtnTLDIDClick(Sender: TObject);
    procedure BtnOrganizationClick(Sender: TObject);
    procedure BtnDepartmentClick(Sender: TObject);
    procedure BtnDoscommentClick(Sender: TObject);
    procedure BtnMeascommentClick(Sender: TObject);
  private
    FFilterCondition: String;
    FFilterSort: String;
    procedure SetFilterCondition(Value: String);
    procedure SetFilterSort(Value: String);
    procedure SaveFiltersToIni;
    { Private declarations }
  public
    ResultSQLString: String;
    property FilterCondition: String read FFilterCondition write SetFilterCondition;
    property FilterSort: String read FFilterSort write SetFilterSort;

    function CheckScript: boolean;

    procedure DropScript;
    { Public declarations }
  end;

const
  cOperatorsArray: array [0..5] of String = ('CREATE','UPDATE','DELETE','DROP','SHOW','INSERT');

var
  SQLFilterForm: TSQLFilterForm;

implementation
uses
  uConst,
  uMainForm,
  uDataModule,
  uLanguages;
{$R *.dfm}

procedure TSQLFilterForm.BtnCheckClick(Sender: TObject);
begin
  CheckScript;
end;

procedure TSQLFilterForm.BtnDropClick(Sender: TObject);
begin
  LblErr.Caption:='';
  DropScript;
  if MainForm.CheckSQLScript then MainForm.CheckSQLScript:=true else MainForm.CheckSQLScript:=false;
  MainForm.UpdateBtnFilters;
  MainForm.UpdateAllGridPages;
end;

procedure TSQLFilterForm.BtnEqualClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cEqual);
end;

procedure TSQLFilterForm.BtnErrClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldError);
end;

procedure TSQLFilterForm.BtnGraterClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cGreater);
end;

procedure TSQLFilterForm.BtnKSIClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldKSI);
end;

procedure TSQLFilterForm.BtnLessClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cLess);
end;

procedure TSQLFilterForm.BtnNotEqualClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cNotEqual);
end;

procedure TSQLFilterForm.BtnORClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cOR);
end;

procedure TSQLFilterForm.BtnOrganizationClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldOrg);
end;

procedure TSQLFilterForm.BtnPartIDClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldPartID);
end;

procedure TSQLFilterForm.BtnPostfixClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldDosPostfix);
end;

procedure TSQLFilterForm.BtnRegtimeClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldRegTime);
end;

procedure TSQLFilterForm.BtnStatusClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldDosStatus);
end;

procedure TSQLFilterForm.BtnTLDIDClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldTldID);
end;

procedure TSQLFilterForm.BtnValidityClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldValidity);
end;

procedure TSQLFilterForm.BtnVertimeClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldVerTime);
end;

procedure TSQLFilterForm.BtnMeascommentClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldMeasComment);
end;

procedure TSQLFilterForm.BtnMeasurmentidClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldDosMeasID);
end;

procedure TSQLFilterForm.BtnMeasurmenttimeClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldMeasureTime);
end;

procedure TSQLFilterForm.BtnDepartmentClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldDepartment);
end;

procedure TSQLFilterForm.BtnDoscommentClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldLastMeasComment);
end;

procedure TSQLFilterForm.BtnDoseClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldDose);
end;

procedure TSQLFilterForm.BtnDosimeteridClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldDosID);
end;

procedure TSQLFilterForm.BtnDosimetertypeClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cFieldDosType);
end;

procedure TSQLFilterForm.BtnANDClick(Sender: TObject);
begin
  MemoCondition.SetFocus;
//  MemoCondition.SetSelTextBuf(cAND);
end;

procedure TSQLFilterForm.BtnApplyClick(Sender: TObject);
begin
  if CheckScript then
  begin
    SaveFiltersToIni;
    if MainForm.CheckSQLScript then MainForm.CheckSQLScript:=true else MainForm.CheckSQLScript:=false;
    MainForm.UpdateBtnFilters;
    MainForm.UpdateAllGridPages;
  end;
end;

function TSQLFilterForm.CheckScript: boolean;
var
  res             : boolean;
  i               : integer;
  errFlag         : boolean;
  localStringCond : String;
  localStringSort : String;
begin
  res:=false;
  errFlag:=false;

  try
    if TLDDataModule.IsDBConnected then
    begin
      TLDDataModule.ADOQuery.SQL.Clear;

      localStringCond:=UpperCase(FilterCondition);
      localStringSort:=UpperCase(FilterSort);

      // проверка на не допустимые операторы
      for i := Low(cOperatorsArray) to High(cOperatorsArray) do
      begin

        if Pos(cOperatorsArray[i],localStringCond)>0 then
        begin
          errFlag:=true;
          break;
        end;

        if Pos(cOperatorsArray[i],localStringSort)>0 then
        begin
          errFlag:=true;
          break;
        end;
      end;

      if not errFlag then
      begin
        if (FFilterCondition<>'') AND (FFilterSort<>'') then
        begin
          TLDDataModule.ADOQuery.SQL.Add('SELECT * FROM tlddosimeterres WHERE ('+FFilterCondition+')'+FFilterSort);
          ResultSQLString:=Format(' AND (%s) %s',[SQLFilterForm.FilterCondition,SQLFilterForm.FilterSort]);
        end
        else if (FFilterCondition='') then
        begin
          TLDDataModule.ADOQuery.SQL.Add('SELECT * FROM tlddosimeterres '+FFilterSort);
          ResultSQLString:=Format(' %s',[SQLFilterForm.FilterSort]);
        end
        else
        begin
          TLDDataModule.ADOQuery.SQL.Add('SELECT * FROM tlddosimeterres WHERE ('+FFilterCondition+')');
          ResultSQLString:=Format(' AND (%s)',[SQLFilterForm.FilterCondition]);
        end;

        TLDDataModule.ADOQuery.Open;
        TLDDataModule.ADOQuery.Close;

        res:=true;
      end
      else
        res:=false;
    end;
  except
    res:=false;
  end;

  if res then
  begin
    LblErr.Font.Color:=clGreen;
    LblErr.Caption:=Format('%s!',[rsDoneSucc]);
  end
  else
  begin
    LblErr.Font.Color:=clRed;
    LblErr.Caption:=Format('%s!',[rsErrDid]);
  end;

  Result:=res;
end;

procedure TSQLFilterForm.DropScript;
begin
  FilterCondition:='';
  FilterSort:='ORDER BY measurmenttime DESC';
end;

procedure TSQLFilterForm.FormCreate(Sender: TObject);
var
  ConfigIni   : TInifile;
begin
  Caption:=rsFilter;

  ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile);
  try
    FilterCondition:=ConfigIni.ReadString('Filter', 'FCondition', '');
    FilterSort:=ConfigIni.ReadString('Filter', 'FSort', '');
  finally
    ConfigIni.Free;
  end;
end;

procedure TSQLFilterForm.FormDestroy(Sender: TObject);
var
  ConfigIni: TInifile;
begin
  ConfigIni := Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile); // создаем ini файл и пишем туда информацию

  try
    ConfigIni.WriteString('Filter', 'FCondition', SQLFilterForm.FilterCondition);
    ConfigIni.WriteString('Filter', 'FSort', SQLFilterForm.FilterSort);
  finally
    ConfigIni.Free;
  end;

//  if MainForm.CheckSQLScript then
//  begin
//    try
//      if CheckScript then
//      begin
//        ConfigIni.WriteString('Filter', 'FCondition', SQLFilterForm.FilterCondition);
//        ConfigIni.WriteString('Filter', 'FSort', SQLFilterForm.FilterSort);
//      end
//      else
//      begin
//        DropScript;
//        ConfigIni.WriteString('Filter', 'FCondition', SQLFilterForm.FilterCondition);
//        ConfigIni.WriteString('Filter', 'FSort', SQLFilterForm.FilterSort);
//      end;
//    finally
//      ConfigIni.Free;
//    end;
//  end;

end;

procedure TSQLFilterForm.FormShow(Sender: TObject);
begin
  LblErr.Caption:='';
end;

procedure TSQLFilterForm.MemoConditionChange(Sender: TObject);
const
  cScroll = 4;
begin
  FFilterCondition:=StringReplace(MemoCondition.Text,cCRLF,'',[rfreplaceall]);
  if MemoCondition.Lines.Count >= cScroll then
    MemoCondition.ScrollBars:=ssVertical
  else
    MemoCondition.ScrollBars:=ssNone;
end;

procedure TSQLFilterForm.MemoSortChange(Sender: TObject);
const
  cScroll = 2;
begin
  FFilterSort:=StringReplace(MemoSort.Text,cCRLF,'',[rfreplaceall]);
  if MemoSort.Lines.Count >= cScroll then
    MemoSort.ScrollBars:=ssVertical
  else
    MemoSort.ScrollBars:=ssNone;
end;

procedure TSQLFilterForm.SaveFiltersToIni;
var
  ConfigIni: TInifile;
begin
  ConfigIni:=Tinifile.Create(extractfilepath(Application.ExeName) + cConfigFile); // создаем ini файл и пишем туда информацию
  try
    ConfigIni.WriteString('Filter', 'FCondition', StringReplace(FilterCondition,cCRLF,'',[rfreplaceall]));
    ConfigIni.WriteString('Filter', 'FSort', StringReplace(FilterSort,cCRLF,'',[rfreplaceall]));
  finally
    ConfigIni.Free;
  end;

end;

procedure TSQLFilterForm.SetFilterCondition(Value: String);
begin
  FFilterCondition:=Value;
  MemoCondition.Lines.Clear;
  if FFilterCondition<>'' then MemoCondition.Lines.Add(FFilterCondition);
end;

procedure TSQLFilterForm.SetFilterSort(Value: String);
begin
  FFilterSort:=Value;
  MemoSort.Lines.Clear;
  if FFilterSort<>'' then MemoSort.Lines.Add(FFilterSort);
end;

end.
