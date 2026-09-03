unit UOptions;

interface

uses
//  Messages,
  SysUtils, Variants,
  Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls,
  Buttons, Spin,
//  ExtDlgs, Grids,
  ValEdit,
  CheckLst, uCalcForm, Types;

type
  TCriteriaValues = (cvBy0,cvBt,cvBx0,cvGM1,cvDGM2,cvGA1,cvDGA2,cvGSL,cvGSR);
  TCriteriaValuesPlus = (cvFon,cvMaxNoPeak,cvS);
  TCriteria = array[TCriteriaValues] of real;
  TCriteriaPlus = array[TCriteriaValuesPlus] of real;

  { TOptionsForm }

  TOptionsForm = class(TForm)
    CB_WaitingsApriory: TCheckBox;
    CB_RefitIfError: TCheckBox;
    StatusBar1: TStatusBar;
//    SaveTextFileDialog: TSaveTextFileDialog;
    SaveTextFileDialog: TSaveDialog;
    PC: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    RG_GladeType: TRadioGroup;
    Label7: TLabel;
    EditG_Num: TEdit;
    GroupBox5: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label26: TLabel;
    Edit_MinDX: TEdit;
    Edit_MinS: TEdit;
    CB_Adaptive: TCheckBox;
    Edit_DX: TEdit;
    RG_TypeS: TRadioGroup;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    EditEvalBy0: TEdit;
    EditEvalBt: TEdit;
    EditEvalBx0: TEdit;
    CB_AutoCalcFonWaitings: TCheckBox;
    GroupBox7: TGroupBox;
    Label30: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    EditFonStep: TEdit;
    EditFonPiece: TEdit;
    SE_FonMaxAutoSteps: TSpinEdit;
    CB_FonSuperFit: TCheckBox;
    CB_FonFitGlade: TCheckBox;
    CB_FonPlusWaitings: TCheckBox;
    Edit_MinErrF: TEdit;
    GroupBox4: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Edit_GSR: TEdit;
    Edit_GSL: TEdit;
    Edit_DGM2: TEdit;
    Edit_DGA2: TEdit;
    Edit_GM1: TEdit;
    Edit_GA1: TEdit;
    CB_AutoCalcWaitings: TCheckBox;
    GroupBox6: TGroupBox;
    Label15: TLabel;
    Label12: TLabel;
    Label19: TLabel;
    Label10: TLabel;
    EditStep: TEdit;
    EditPiece: TEdit;
    SE_MaxAutoSteps: TSpinEdit;
    CB_FitChangeRange: TCheckBox;
    CB_SuperFit: TCheckBox;
    CB_FitGlade: TCheckBox;
    CB_PlusWaitings: TCheckBox;
    Edit_MinErr: TEdit;
    CB_NoProcessApplication: TCheckBox;
    CB_StopFitBySomeSec: TCheckBox;
    Edit_NumSecondsToStopFit: TEdit;
    TabSheet7: TTabSheet;
    GroupBox9: TGroupBox;
    ButtonSave: TButton;
    BtnCopy2ClipBoard: TButton;
    GroupBoxExcel: TGroupBox;
    Label9: TLabel;
    CB_SaveToExcel: TCheckBox;
    RBtnAll: TRadioButton;
    RBtnGroupByDos: TRadioButton;
    RBtnGroupByComment: TRadioButton;
    EditExcelRemark: TEdit;
    CLB_Log: TCheckListBox;
    CB_FitFon: TCheckBox;
    CB_FitPeak: TCheckBox;
    SaveOptionsDialog: TSaveDialog;
    LoadOptionsDialog: TOpenDialog;
    GroupBox10: TGroupBox;
    Label11: TLabel;
    Edit_WaitingPeakCentre: TEdit;
    TabSheet8: TTabSheet;
    GroupBox8: TGroupBox;
    Label39: TLabel;
    Label40: TLabel;
    Edit_InterestCriteriaRight: TEdit;
    Edit_InterestCriteriaLeft: TEdit;
    RG_PeakInterestRange: TRadioGroup;
    GroupBox11: TGroupBox;
    Label13: TLabel;
    Edit_WaitMaxWidth: TEdit;
    RG_InterestRange: TRadioGroup;
    Label16: TLabel;
    Edit_MaxFindRange: TEdit;
    Label27: TLabel;
    Edit_DefaultN1: TEdit;
    Edit_DefaultN2: TEdit;
    Label32: TLabel;
    TabSheetWaitings: TTabSheet;
    VLE: TValueListEditor;
    TabSheetAsserts: TTabSheet;
//    REdit: TRichEdit;
    REdit: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    EC_By0_MinError: TEdit;
    EC_By0_MinWarning: TEdit;
    EC_By0_MaxWarning: TEdit;
    EC_By0_MaxError: TEdit;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    EC_Bt_MinError: TEdit;
    EC_Bt_MinWarning: TEdit;
    EC_Bt_MaxWarning: TEdit;
    EC_Bt_MaxError: TEdit;
    EC_Bx0_MinError: TEdit;
    EC_Bx0_MinWarning: TEdit;
    EC_Bx0_MaxWarning: TEdit;
    EC_Bx0_MaxError: TEdit;
    EC_GM1_MinError: TEdit;
    EC_GM1_MinWarning: TEdit;
    EC_GM1_MaxWarning: TEdit;
    EC_GM1_MaxError: TEdit;
    Label46: TLabel;
    EC_GA1_MinError: TEdit;
    EC_GA1_MinWarning: TEdit;
    Label47: TLabel;
    EC_GA1_MaxWarning: TEdit;
    EC_GA1_MaxError: TEdit;
    EC_DGM2_MinError: TEdit;
    EC_DGM2_MinWarning: TEdit;
    Label48: TLabel;
    EC_DGM2_MaxWarning: TEdit;
    EC_DGM2_MaxError: TEdit;
    EC_DGA2_MinError: TEdit;
    EC_DGA2_MinWarning: TEdit;
    Label49: TLabel;
    EC_DGA2_MaxWarning: TEdit;
    EC_DGA2_MaxError: TEdit;
    EC_GSL_MinError: TEdit;
    EC_GSL_MinWarning: TEdit;
    Label50: TLabel;
    EC_GSL_MaxWarning: TEdit;
    EC_GSL_MaxError: TEdit;
    EC_GSR_MinError: TEdit;
    EC_GSR_MinWarning: TEdit;
    Label51: TLabel;
    EC_GSR_MaxWarning: TEdit;
    EC_GSR_MaxError: TEdit;
    Label52: TLabel;
    ECC_Fon: TEdit;
    Label53: TLabel;
    ECC_MaxNoPeak: TEdit;
    Label54: TLabel;
    Edit_MinS4Fit: TEdit;
    CB_DoPeakAlways: TCheckBox;
    CB_UseSourceFilter: TCheckBox;
    Label55: TLabel;
    Edit_MinS4FitFon: TEdit;
    ECS_Adaptive: TCheckBox;
    Label56: TLabel;
    Edit_MinSforShowPeak: TEdit;
    Label14: TLabel;
    Edit_MinS_4SuperFit: TEdit;
    Label57: TLabel;
    Edit_MinS_4FitChangeRange: TEdit;
    Label58: TLabel;
    Edit_MaxS_4WaitingsFit: TEdit;
    Edit_FilterMinDiff: TEdit;
    Label59: TLabel;
    CB_SaveCalcImages: TCheckBox;
    CB_NoLineCorrection: TCheckBox;
    Label60: TLabel;
    Edit_AlarmLevelForFilter: TEdit;
    CB_ShowNegativeDose: TCheckBox;
    PageControl1: TPageControl;
    TabSheet9: TTabSheet;
    TabSheet11: TTabSheet;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label6: TLabel;
    EditL_Start: TEdit;
    EditL_Num: TEdit;
    RG_FuncFindBy0: TRadioGroup;
    CB_UseTempProfileInfo: TCheckBox;
    Label28: TLabel;
    Label29: TLabel;
    Edit_FonMinAdd: TEdit;
    Edit_kWidth: TEdit;
    CB_FonAdaptive: TCheckBox;
    RG_FonRangeCriteria: TRadioGroup;
    Label34: TLabel;
    Label35: TLabel;
    Edit_BG_Start: TEdit;
    Edit_BG_End: TEdit;
    RG_FonFunctionCriteria: TRadioGroup;
    RG_BackgroundFunction: TRadioGroup;
    RG_MainAlgorithm: TRadioGroup;
    Btn_FonFit: TBitBtn;
    Btn_GetDefault: TBitBtn;
    CB_AutoRecalc: TCheckBox;
    CB_ReadCalculated: TCheckBox;
    CB_ProtectAutoChange: TCheckBox;
    BtnSaveOptions: TButton;
    Edit_MethodName: TEdit;
    CB_UseLowPassFilter: TCheckBox;
    Edit_LowPassFilterAlfa: TEdit;
    Label_MethodName: TLabel;
    BtnLoadOptions: TButton;
    BtnSetMethod: TBitBtn;
    procedure OptionsChanged(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure BtnCopy2ClipBoardClick(Sender: TObject);
    procedure Btn_FonFitClick(Sender: TObject);
    procedure Btn_GetDefaultClick(Sender: TObject);
    procedure BtnSaveOptionsClick(Sender: TObject);
    procedure RG_MainAlgorithmClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RG_GladeTypeClick(Sender: TObject);
    procedure CB_ProtectAutoChangeClick(Sender: TObject);
    procedure CB_ShowNegativeDoseClick(Sender: TObject);
    procedure CB_UseTempProfileInfoClick(Sender: TObject);
    procedure CB_NoLineCorrectionClick(Sender: TObject);
    procedure BtnLoadOptionsClick(Sender: TObject);
    procedure BtnSetMethodClick(Sender: TObject);
    procedure RG_BackgroundFunctionClick(Sender: TObject);
    procedure TabSheet7ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    DisableOptionsControls : boolean;
//    procedure CalcMainMethod(aMethod: String; var MainAlgorithm : TMainAlgorithm);// Вычисление ItemIndex RG_MainAlgorithm по строке из БД
    function CalcMainMethod(aMethod: String) : TMainAlgorithm; // Вычисление ItemIndex RG_MainAlgorithm по строке из БД
    procedure SetDefaultOptionsByMaterial(aMaterialNumber : TMainAlgorithm);
    { Public declarations }
  end;

var
  OptionsForm: TOptionsForm;

  OCW_min, OCE_min, OCW_max, OCE_max : TCriteria;
  OCC : TCriteriaPlus;

const
  CRLF = #13#10;

  SectOpt = 'Options';
  DirPathMethod = 'Options'+PathDelim+'Method'+PathDelim;
  LastFixMethod = 'Options'+PathDelim+'Method'+PathDelim+'LastFix.mtd';

  // номер пользовательского метода (в RG_MainAlgorithm)
  cUserMethodNum = 4;

  // константы по типам рассчёта площади
  clcDBLGauss  = 0;
  clcRGauss    = 1;
  clcAmplitude = 2;
  clcSquare    = 3;

// константы номеров функций поиска границ фона
  fbrFixed = 0;
  fbrMaxSlant = 1;
  fbrCombo = 5;
  //..

// константы номеров функций поиска фона
  fbByFoundRange      = 0;
  fbFindBetweenPoints = 1;
  fbBt40andN2         = 2;


implementation

uses uSeparator, ClipBRD, DateUtils, SlavaTools, Rtti, TypInfo, IniFiles;
{$R *.dfm}

procedure TOptionsForm.BtnCopy2ClipBoardClick(Sender: TObject);
var
  St: String;
begin
  St := CalcForm.EditBy0.Text + CRLF + FloatToStrRegion
    (1 / exp(StrToFloatRegion(CalcForm.EditBx0.Text) /
    StrToFloatRegion(CalcForm.EditBt.Text))) + CRLF + CalcForm.EditBt.Text +
    CRLF + CRLF + CalcForm.Edit_N1.Text + CRLF + CalcForm.Edit_N2.Text + CRLF +
    '0' + CRLF + CalcForm.Edit_DGA2.Text + CRLF + CalcForm.Edit_GA1.Text + CRLF
    + CalcForm.Edit_DGM2.Text + CRLF + CalcForm.Edit_GM1.Text + CRLF +
    CalcForm.Edit_GSL.Text + CRLF + CalcForm.Edit_GSR.Text + CRLF;
  // ClipBoard.AsText:=St;
  ClipBoard.AsText := StringReplace(St, '.', ',', [rfReplaceAll]);
end;

procedure TOptionsForm.Btn_FonFitClick(Sender: TObject);
begin
  Close;
end;

procedure TOptionsForm.Btn_GetDefaultClick(Sender: TObject);
begin
  CalcForm.MainAlgorithm := CalcMainMethod(CalcForm.CDetector.Method);
  SetDefaultOptionsByMaterial(CalcForm.MainAlgorithm);
//  CalcForm.CalcType := ccAuto;
  CalcForm.CalcRefresh;
//  bOptionsChanged := False;
end;

procedure GoValues(Preambula: String; Ini: TIniFile; Item: TComponent; Write: boolean);
var
  c : TRttiContext;
  t : TRttiType;
  p : TRttiProperty;
//  v : TValue;
//  m : TRttiMethod;
  s : String;
  PropObject: TObject;
//  PropInfo: PPropInfo;
  i : integer;
  St: String;
  Sts: TStrings;
begin
  c := TRttiContext.Create;
  t := c.GetType(Item.ClassType);
  for p in t.GetProperties do
  try
    if p.PropertyType.TypeKind = tkUString then
    begin
      s := p.GetValue(Item).ToString;
      if s<>'' then
        if Write then Ini.WriteString(SectOpt,Preambula + '.' + p.Name,s)
        else
          begin
            s := Ini.ReadString(SectOpt,Preambula + '.' + p.Name,s);
            p.SetValue(Item,s);
          end;
    end;

    if (p.Name = 'Items') or (p.Name = 'Strings') or (p.Name = 'Lines') or (p.Name = 'TitleCaptions') then
    if p.PropertyType.TypeKind = tkClass then
    begin
      PropObject := GetObjectProp(Item, p.Name);
      if Assigned(PropObject)then
      begin
        if (PropObject is TStrings) then
        begin
          St :=(PropObject as TStrings).Text;
//          if IsRussian(St) then
          begin
            if length(St)<200 then
            begin
              s := St;
              if s<>'' then
                if Write then Ini.WriteString(SectOpt,Preambula + '.' + Item.Name,s)
                else
                  begin
                    s := Ini.ReadString(SectOpt,Preambula + '.' + Item.Name,s);
                    (PropObject as TStrings).Text := s;
                  end;
            end
              else
            begin
              Sts := TStringList.Create;
              try
                for i := 0 to (PropObject as TStrings).Count-1 do
                begin
                  St :=(PropObject as TStrings).Strings[i];
                  s := St;
                  if Write then Ini.WriteString(SectOpt,Preambula + '.' + Item.Name+'.String'+IntToStr(i),s)
                  else
                    begin
                      s := Ini.ReadString(SectOpt,Preambula + '.' + Item.Name+'.String'+IntToStr(i),s);
                      Sts.Append(s);
                    end;
                end;
                if not Write then
                begin
                  (PropObject as TStrings).Clear;
                  (PropObject as TStrings).AddStrings(Sts);
                end;
              finally
                Sts.Free;
              end
            end
          end;
        end;
      end
    end;

  except
  end;
end;

procedure GoComponent(Preambula: String; Ini: TIniFile; Item: TComponent; Write: boolean);
var
  i, iC: Integer;
  LangPrefix, s: String;
begin
  if Item = Nil then Exit;
  if pos('SaveTextFileDialog',Item.Name )>0 then Exit; // выгородка из-за вн. ошибки в Delphi-проекте

  try
    with Item do
    begin
      if Preambula=''
      then LangPrefix := Item.Name
      else LangPrefix := Preambula + '.' + Item.Name;

      if Item is TEdit then
        if Write
          then Ini.WriteString(SectOpt,Preambula + '.' + Item.Name, (Item as TEdit).Text)
          else (Item as TEdit).Text := Ini.ReadString(SectOpt,Preambula + '.' + Item.Name,(Item as TEdit).Text);

      if Item is TSpinEdit then
        if Write
          then Ini.WriteString(SectOpt,Preambula + '.' + Item.Name, (Item as TSpinEdit).Text)
          else (Item as TSpinEdit).Text := Ini.ReadString(SectOpt,Preambula + '.' + Item.Name,(Item as TSpinEdit).Text);

      if Item is TRadiogroup then
        if Write
          then Ini.WriteInteger(SectOpt,Preambula + '.' + Item.Name, (Item as TRadiogroup).itemindex)
          else (Item as TRadiogroup).itemindex := Ini.ReadInteger(SectOpt,Preambula + '.' + Item.Name,(Item as TRadiogroup).itemindex);

      if Item is TCheckBox then
        if Write
          then Ini.WriteBool(SectOpt,Preambula + '.' + Item.Name, (Item as TCheckBox).Checked)
          else (Item as TCheckBox).Checked := Ini.ReadBool(SectOpt,Preambula + '.' + Item.Name,(Item as TCheckBox).Checked);

      if Item is TComboBox then
        if Write
          then Ini.WriteInteger(SectOpt,Preambula + '.' + Item.Name, (Item as TComboBox).ItemIndex)
          else (Item as TComboBox).ItemIndex := Ini.ReadInteger(SectOpt,Preambula + '.' + Item.Name,(Item as TComboBox).ItemIndex);

      if Item is TValueListEditor then
        if Write
          then
            begin
              iC := (Item as TValueListEditor).RowCount-1;
              Ini.WriteInteger(SectOpt,Preambula + '.' + Item.Name + '.Rows', iC);
              //for i:= 0 to iC-1 do
              for i:= 1 to iC do
              begin
                Ini.WriteString(SectOpt,Preambula + '.' + Item.Name + '.key_'+intToStr(i), (Item as TValueListEditor).Keys[i]);
                Ini.WriteString(SectOpt,Preambula + '.' + Item.Name + '.val_'+(Item as TValueListEditor).Keys[i], (Item as TValueListEditor).Values[(Item as TValueListEditor).Keys[i]]);
              end;
            end
          else
            begin
  //            (Item as TValueListEditor).RowCount := Ini.ReadInteger(SectOpt,Preambula + '.' + Item.Name + '.Rows',(Item as TValueListEditor).ItemIndex);
              (Item as TValueListEditor).Clear;
              iC := Ini.ReadInteger(SectOpt,Preambula + '.' + Item.Name + '.Rows', (Item as TValueListEditor).RowCount);
              //for i:= 0 to iC-1 do
              for i:= 1 to iC do
              begin
                s := Ini.ReadString(SectOpt,Preambula + '.' + Item.Name + '.key_'+intToStr(i), (Item as TValueListEditor).Keys[i]);
                //(Item as TValueListEditor).Values[s] := Ini.ReadString(SectOpt,Preambula + '.' + Item.Name + '.val_'+intToStr(i), (Item as TValueListEditor).Values[(Item as TValueListEditor).Keys[i]]);
                (Item as TValueListEditor).Values[s] := Ini.ReadString(SectOpt,Preambula + '.' + Item.Name + '.val_'+s, (Item as TValueListEditor).Values[s]);
              end;
            end;

  //    GoValues(LangPrefix,Ini,aComponent,Write);
      for i:=0 to Item.ComponentCount-1 do
        if Components[i] is TComponent then
          GoComponent(LangPrefix, Ini, Components[i], Write);
    end;

  except
  end;
end;

procedure SaveToFile(const FileName: TFileName);
var
  SIni: TIniFile;
begin
  SIni := TIniFile.Create(FileName);
  try
    GoComponent('', SIni, OptionsForm, True);

  finally
    SIni.Free;
  end;
end;

procedure LoadFromFile(const FileName: TFileName);
var
  SIni: TIniFile;
begin
  SIni := TIniFile.Create(FileName);
  //SIni := TIniFile.Create('/home/ks/work/Lazarus/Projects/DozaTLD_Auto/Options/Method/TestAuto.mtd');
  try
    GoComponent('', SIni, OptionsForm, False);

    OptionsForm.Edit_MethodName.Text := ExtractFileName(ChangeFileExt(FileName,''));
    OptionsForm.Label_MethodName.Visible := True;
    OptionsForm.Edit_MethodName.Visible := True;
    OptionsForm.RG_MainAlgorithm.ItemIndex := cUserMethodNum;

  finally
    SIni.Free;
  end;
end;

procedure SaveDFMToFile(RootObject: TComponent; const FileName: TFileName);
var
  FileStream: TFileStream;
  MemStream: TMemoryStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  MemStream := TMemoryStream.Create;
  try
    MemStream.WriteComponent(RootObject);
    MemStream.Position := 0;
    ObjectBinaryToText(MemStream, FileStream);
  finally
    MemStream.Free;
    FileStream.Free;
  end;
end;

procedure TOptionsForm.BtnSaveOptionsClick(Sender: TObject);
begin
//  SaveOptionsDialog.FileName := 'user_' + Edit_MethodName.Text;
  SaveOptionsDialog.FileName := Edit_MethodName.Text;
  if not DirectoryExists(AppDir+DirPathMethod,False)
    then ForceDirectories(AppDir+DirPathMethod);
  SaveOptionsDialog.InitialDir := AppDir+DirPathMethod;
  if SaveOptionsDialog.Execute then
  begin
    DisableOptionsControls := True;
    OptionsForm.Edit_MethodName.Text := ExtractFileName(ChangeFileExt(SaveOptionsDialog.FileName,''));
    SaveToFile(SaveOptionsDialog.FileName);  //AppDir+'OptionsForm.tx'
    DisableOptionsControls := False;
  end;
end;

procedure TOptionsForm.BtnSetMethodClick(Sender: TObject);
begin
  DisableOptionsControls := True;
  if LoadOptionsDialog.Execute then
    LoadFromFile(LoadOptionsDialog.FileName);
  DisableOptionsControls := False;
end;

procedure TOptionsForm.BtnLoadOptionsClick(Sender: TObject);
begin
  DisableOptionsControls := True;
  LoadOptionsDialog.InitialDir := AppDir+DirPathMethod;
  if LoadOptionsDialog.Execute then
    LoadFromFile(LoadOptionsDialog.FileName);
  DisableOptionsControls := False;
end;

procedure TOptionsForm.ButtonSaveClick(Sender: TObject);
begin
  if SaveTextFileDialog.Execute then
    REdit.Lines.SaveToFile(SaveTextFileDialog.FileName);
end;

//procedure TOptionsForm.CalcMainMethod(aMethod: String; var MainAlgorithm : TMainAlgorithm);
function TOptionsForm.CalcMainMethod(aMethod: String) : TMainAlgorithm; // Вычисление ItemIndex RG_MainAlgorithm по строке из БД
begin
  if (pos('Area[10-280]',aMethod)>0) or (pos('Area [10-280]',aMethod)>0) or (pos('Интеграл[10-280]',aMethod)>0)
//  then begin OptionsForm.RG_MainAlgorithm.ItemIndex := 1; result := alArea10_280; end
  then result := alArea10_280
  else
    if (pos('Area[60-240]',aMethod)=1) or (pos('Интеграл [135-280]',aMethod)=1)
    then result := alArea60_240
    else
      if (pos('Step',aMethod)=1)
      then result := alStep
      else
        if pos('Fitting',aMethod)=1
        then result := alFitting
        else
          if pos('User_',aMethod)=1
          then
            begin
              Edit_MethodName.Text := trim(copy(aMethod,6,300));
              result := alUser;
            end
          else result := alFitting;
end;

procedure TOptionsForm.CB_ProtectAutoChangeClick(Sender: TObject);
begin
  DisableOptionsControls := True;
{
  if CB_ProtectAutoChange.Checked
    then RG_MainAlgorithm.ItemIndex := cUserMethodNum  // Пользовательский
    else RG_MainAlgorithm.ItemIndex := 0; // Другой
  RG_MainAlgorithm.Enabled := not CB_ProtectAutoChange.Checked;
  Label_MethodName.Visible := CB_ProtectAutoChange.Checked;
  Edit_MethodName.Visible := CB_ProtectAutoChange.Checked;
}
  SaveToFile(AppDir+LastFixMethod);
  DisableOptionsControls := False;
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
  DisableOptionsControls := False;
  CB_ShowNegativeDose.Checked := bCalcForm_ShowNegativeDose;
end;

procedure TOptionsForm.OptionsChanged(Sender: TObject);
var
  St: String;
begin
//  TabSheetWaitings.TabVisible := CB_PlusWaitings.Checked or CB_FonPlusWaitings.Checked;
//  if CalcForm.DisableCalcControls and not bOptionsChanged then Exit;
//  if not CalcForm.DisableCalcControls then CalcForm.Btn_FullAuto.Enabled := True;
  if DisableOptionsControls then Exit;

  if CB_ProtectAutoChange.Checked then
  begin
    DisableOptionsControls := True;
    LoadFromFile(AppDir+LastFixMethod);
    DisableOptionsControls := False;
    Exit;
  end;

  CalcForm.CalcType := ccAuto;

  St := 'G' + IntToStr(RG_GladeType.ItemIndex) +
        '_S' + IntToStr(RG_TypeS.ItemIndex + 1) +
        '_B' + IntToStr(RG_FonRangeCriteria.ItemIndex) + IntToStr(RG_FonFunctionCriteria.ItemIndex) + 'S' + EditL_Start.Text + 'L' + EditL_Num.Text + 'A' + Edit_FonMinAdd.Text + 'K' + Edit_kWidth.Text;
  if CB_FitFon.Checked then
  begin
    St := St + '_FB' + Edit_MinS4FitFon.Text;
    if CB_FonFitGlade.Checked then
      St := St + 'G';
    if CB_FonSuperFit.Checked then
      St := St + 'S' + Edit_MinErrF.Text;
    if CB_FonPlusWaitings.Checked then
      St := St + 'W';
  end;
  if CB_FitPeak.Checked then
  begin
    St := St + '_FP' + Edit_MinS4Fit.Text;
    if CB_FitGlade.Checked then
      St := St + 'G';
    if CB_SuperFit.Checked then
      St := St + 'S' + Edit_MinS_4SuperFit.Text +'(' + Edit_MinErrF.Text+')';
    if CB_FitChangeRange.Checked then
      St := St + 'C' + Edit_MinS_4FitChangeRange.Text;
    if CB_PlusWaitings.Checked then
      St := St + 'W';

  end;
  EditExcelRemark.Text := St;

  if RG_FonRangeCriteria.ItemIndex = 0 then
  begin
    Edit_BG_Start.Font.Color := clBlack;
    Edit_BG_End.Font.Color := clBlack;
  end
  else
  begin
    Edit_BG_Start.Font.Color := clGreen;
    Edit_BG_End.Font.Color := clGreen;
  end;

//  CalcForm.LoadOptions;

  bOptionsChanged := True;

//  if CB_AutoRecalc.Checked and not CalcForm.DisableCalcControls then CalcForm.Btn_FullAutoClick(Sender);
  if CB_AutoRecalc.Checked and not CalcForm.DisableCalcControls then CalcForm.CalcRefresh;

end;

procedure TOptionsForm.RG_BackgroundFunctionClick(Sender: TObject);
begin
  OptionsChanged(Sender);
end;

procedure TOptionsForm.TabSheet7ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TOptionsForm.RG_GladeTypeClick(Sender: TObject);
begin
  EditG_Num.Enabled := (RG_GladeType.ItemIndex<>1) or (RG_GladeType.ItemIndex<>4);
  OptionsChanged(Sender);
end;

procedure TOptionsForm.RG_MainAlgorithmClick(Sender: TObject);
begin
  if DisableOptionsControls then Exit;
  SetDefaultOptionsByMaterial(TMainAlgorithm(RG_MainAlgorithm.ItemIndex));
  CalcForm.CalcType := ccAuto;
  if RG_MainAlgorithm.ItemIndex = cUserMethodNum then // Пользовательский тип обработки
//    if LoadOptionsDialog.Execute then
  begin
    DisableOptionsControls := True;
    Edit_MethodName.Text := 'LastFix';
    if FileExists(AppDir + LastFixMethod)
    then LoadFromFile(AppDir + LastFixMethod)
    else SaveToFile(AppDir + LastFixMethod);

    Edit_MethodName.Visible := True;
    Label_MethodName.Visible := True;
    BtnSetMethod.Visible := True;
    DisableOptionsControls := False;
  end
    else
  begin
    Edit_MethodName.Visible := False;
    Label_MethodName.Visible := False;
    BtnSetMethod.Visible := False;
  end;

  if RG_MainAlgorithm.ItemIndex <> cUserMethodNum then // Пользовательский тип обработки
    OptionsChanged(Sender);
end;

function GetValueFromComment(aValue,aComment: String): real;
var
  St : String;
  i,j: integer;
begin
  try
    result:=0;
    i := pos(aValue,aComment);
    if i>0 then
    begin
      j := pos('|',aComment,i);
      St:=copy(aComment,i+length(aValue),j-i-length(aValue));
      result:=StrToFloat(St);
    end;
  except
    result:=-1;
  end;
end;

procedure GetTempProfileToVLE;
var
  time_preheat: real;
  time_meas: real;
  time_burn: real;
  temp_preheat: real;
  temp_meas: real;
  temp_burn: real;
  sumTimes : real;
  can_preheat: real;
  can_meas: real;
  can_burn: real;
  aComment : String;
begin
  if (CalcForm.CDetector<>nil) then
  begin
    aComment := CalcForm.CDetector.DetTypeComment;
    time_preheat := GetValueFromComment('time_preheat=',aComment);
    time_meas := GetValueFromComment('time_meas=',aComment);
    time_burn := GetValueFromComment('time_burn=',aComment);
    temp_preheat := GetValueFromComment('temp_preheat=',aComment);
    temp_meas := GetValueFromComment('temp_meas=',aComment);
    temp_burn := GetValueFromComment('temp_burn=',aComment);
    OptionsForm.VLE.Values['time_preheat'] := FloatToStrRegionF(time_preheat,ffGeneral,6,3);
    OptionsForm.VLE.Values['time_meas'] := FloatToStrRegionF(time_meas,ffGeneral,6,3);
    OptionsForm.VLE.Values['time_burn'] := FloatToStrRegionF(time_burn,ffGeneral,6,3);
    OptionsForm.VLE.Values['temp_preheat'] := FloatToStrRegionF(temp_preheat,ffGeneral,6,3);
    OptionsForm.VLE.Values['temp_meas'] := FloatToStrRegionF(temp_meas,ffGeneral,6,3);
    OptionsForm.VLE.Values['temp_burn'] := FloatToStrRegionF(temp_burn,ffGeneral,6,3);

    sumTimes := time_preheat + time_meas + time_burn;
    if sumtimes=0 then Exit;
    can_preheat := 300 * time_preheat / sumTimes;
    can_meas := 300 * time_meas / sumTimes;
    can_burn := 300 * time_burn / sumTimes;
    OptionsForm.VLE.Values['chanal_preheat'] := FloatToStrRegionF(can_preheat,ffGeneral,6,3);
    OptionsForm.VLE.Values['chanal_meas'] := FloatToStrRegionF(can_meas,ffGeneral,6,3);
    OptionsForm.VLE.Values['chanal_burn'] := FloatToStrRegionF(can_burn,ffGeneral,6,3);
  end;

//    ShowMessage(aComment + #13 + St);
end;

procedure TOptionsForm.SetDefaultOptionsByMaterial(aMaterialNumber: TMainAlgorithm);
var
  St, DirStr: string;
//  OldDisableCalcControls: boolean;
begin
//  OldDisableCalcControls := CalcForm.DisableCalcControls;
//  CalcForm.DisableCalcControls := True;
//    CB_ReadCalculated.Checked := True;
  if CB_ProtectAutoChange.checked then Exit;

  DisableOptionsControls := True;
  try
    PC.ActivePage := TabSheet4;
    // Общие
    RG_MainAlgorithm.ItemIndex := ord(aMaterialNumber);
    RG_TypeS.ItemIndex := 0;
    Edit_MethodName.Visible := False;

    // Ожидания
    VLE.Strings.Clear;
    VLE.Strings.Add('DGM1 (max)=0');
    VLE.Strings.Add('DGM2 (GM1), A=16.76762');
    VLE.Strings.Add('DGM2 (GM1), B=0.07084');
    VLE.Strings.Add('GSL (GM1), A=10.15911');
    VLE.Strings.Add('GSL (GM1), B=0.02355');
    VLE.Strings.Add('GSR (GSL), A=0');
    VLE.Strings.Add('GSR (GSL), B=0.61');
    VLE.Strings.Add('DGA2=0.3');
    VLE.Strings.Add('kGA1=0.0');
//    VLE.Strings.Add('kDGA2=0.1');
    VLE.Strings.Add('kDGA2=0.1');
    VLE.Strings.Add('kGM1=0.0');
//    VLE.Strings.Add('kDGM2=0.1');
    VLE.Strings.Add('kDGM2=0.1');
//    VLE.Strings.Add('kGSL=0.1');
//    VLE.Strings.Add('kGSR=0.1');
    VLE.Strings.Add('kGSL=0.05');
    VLE.Strings.Add('kGSR=0.01');
    VLE.Strings.Add('kBy0=0.1');
    VLE.Strings.Add('kBt=1');
    VLE.Strings.Add('kBx0=0.1');
    VLE.Strings.Add('kN=0.1');
    VLE.Strings.Add('kErr=0.1');
    VLE.Strings.Add('kDGA2IfErr=0.5');
    VLE.Strings.Add('CalcModeHi2=1');
    GetTempProfileToVLE;

    // Сглаживание
    RG_GladeType.ItemIndex := 4;
    EditG_Num.Text := '5';
    Edit_FilterMinDiff.Text := '2';
//    CB_UseSourceFilter.Checked := True;

    // Поиск фона
    Edit_kWidth.Text := '10';
    EditL_Start.Text := '0';
    EditL_Num.Text := '24';
    Edit_FonMinAdd.Text := '2';
    RG_FonRangeCriteria.ItemIndex := fbrCombo;
    Edit_BG_Start.Text := '160';
    Edit_BG_End.Text := '299';
    EditEvalBy0.Text := '0.1';
    EditEvalBt.Text := '40';
    EditEvalBx0.Text := '210';
    CB_AutoCalcFonWaitings.Checked := False;
    RG_FonFunctionCriteria.ItemIndex := 0;
    CB_FonAdaptive.Checked := True;
    RG_FuncFindBy0.ItemIndex := 0;

    // Фон - Фит
    EditFonStep.Text := '0.01';
    EditFonPiece.Text := '1';
//    SE_FonMaxAutoSteps.Value := 1000;
    SE_FonMaxAutoSteps.Value := 10000;
    CB_FonSuperFit.Checked := True;
    CB_FonFitGlade.Checked := True;
    CB_FonPlusWaitings.Checked := False;
    Edit_MinErrF.Text := '0.1';
    CB_FitFon.Checked := True;
    Edit_MinS4FitFon.Text := '30';
    CB_UseTempProfileInfo.Checked := True;

    // Поиск пика
    RG_BackgroundFunction.ItemIndex := 0;
    Edit_MinDX.Text := '3';
    Edit_MinS.Text := '10';
    CB_Adaptive.Checked := True;
    Edit_DX.Text := '10';
    Edit_WaitingPeakCentre.Text := '210';
    Edit_GSR.Text := '13';
    Edit_GSL.Text := '17';
    Edit_DGM2.Text := '10';
    Edit_DGA2.Text := '10';
    Edit_GM1.Text := '23';
    Edit_GA1.Text := '279';
    Edit_MinSforShowPeak.Text := '3';

    // Пик - Фит
    CB_AutoCalcWaitings.Checked := True;
    CB_WaitingsApriory.Checked:=False;
    EditStep.Text := '0.01';
    EditPiece.Text := '1';
    SE_MaxAutoSteps.Value := 1000;
    CB_FitChangeRange.Checked := True;
    CB_SuperFit.Checked := True;
    CB_FitGlade.Checked := False;
    CB_PlusWaitings.Checked := True;
    Edit_MinErr.Text := '0.0';
    CB_NoProcessApplication.Checked := False;
    CB_StopFitBySomeSec.Checked := True;
    Edit_NumSecondsToStopFit.Text := '5';
    CB_FitPeak.Checked := True;
    Edit_MinS4Fit.Text := '10';
    Edit_MinS_4SuperFit.Text := '150';
    Edit_MinS_4FitChangeRange.Text := '50';
//    Edit_MaxS_4WaitingsFit.Text := '50';
    Edit_MaxS_4WaitingsFit.Text := '50';
    CB_RefitIfError.Checked := True;

    // Зона интереса
    Edit_InterestCriteriaRight.Text := '3.5';
    Edit_InterestCriteriaLeft.Text := '3.0';
//    Edit_InterestCriteriaLeft.Text := '4.0';
    Edit_DefaultN1.Text := '160';
    Edit_DefaultN2.Text := '299';
    RG_InterestRange.ItemIndex := 0;
//    RG_PeakInterestRange.ItemIndex := 0;
    RG_PeakInterestRange.ItemIndex := 2;
    Edit_WaitMaxWidth.Text:='50';
    Edit_MaxFindRange.Text:='40';

    // Лог
    RBtnAll.Checked := True;
    EditExcelRemark.Text := 'Default';
//    CLB_Log.Checked[0] := False;
//    CLB_Log.Checked[1] := False;
//    CLB_Log.Checked[2] := False;
//    CLB_Log.Checked[3] := False;
//    CLB_Log.Checked[4] := False;
//    CLB_Log.Checked[5] := False;
//    CLB_Log.Checked[6] := False;
//    CLB_Log.Checked[7] := False;
    REdit.Text := '';

    // Предупреждения
    EC_By0_MinError.Text :='0.01';
    EC_By0_MinWarning.Text :='0.02';
    EC_By0_MaxWarning.Text :='1.7';
    EC_By0_MaxError.Text :='10';

    EC_Bt_MinError.Text :='3';
    EC_Bt_MinWarning.Text :='10';
    EC_Bt_MaxWarning.Text :='90';
    EC_Bt_MaxError.Text :='300';

    EC_Bx0_MinError.Text :='50';
    EC_Bx0_MinWarning.Text :='130';
    EC_Bx0_MaxWarning.Text :='350';
    EC_Bx0_MaxError.Text :='450';

    EC_GM1_MinError.Text :='-70';
    EC_GM1_MinWarning.Text :='-40';
    EC_GM1_MaxWarning.Text :='40';
    EC_GM1_MaxError.Text :='70';

    EC_GA1_MinError.Text :='1';
    EC_GA1_MinWarning.Text :='3';
    EC_GA1_MaxWarning.Text :='10000';
    EC_GA1_MaxError.Text :='100000';

    EC_DGM2_MinError.Text :='-90';
    EC_DGM2_MinWarning.Text :='-60';
    EC_DGM2_MaxWarning.Text :='-20';
    EC_DGM2_MaxError.Text :='-5';

    EC_DGA2_MinError.Text :='0.0';
    EC_DGA2_MinWarning.Text :='0.04';
    EC_DGA2_MaxWarning.Text :='0.5';
    EC_DGA2_MaxError.Text :='1';

    EC_GSL_MinError.Text :='3';
    EC_GSL_MinWarning.Text :='10';
    EC_GSL_MaxWarning.Text :='35';
    EC_GSL_MaxError.Text :='75';

    EC_GSR_MinError.Text :='1';
    EC_GSR_MinWarning.Text :='5';
    EC_GSR_MaxWarning.Text :='20';
    EC_GSR_MaxError.Text :='60';

    ECC_Fon.Text :='50';
    ECC_MaxNoPeak.Text :='10';
    ECS_Adaptive.Checked := True;
    Edit_AlarmLevelForFilter.Text := '1000';

    Edit_MethodName.Visible := False;
    Label_MethodName.Visible := False;
    BtnSetMethod.Visible := False;

    case aMaterialNumber of
      alFitting:
         begin // Fitting
           VLE.Strings.Add('Bt=40');
  //         Edit_RangeLeft.Text := '230';
  //         Edit_RangeRight.Text := '250';
         end;
      alArea10_280:
         begin // Area 10-280 (Al2O3)
           VLE.Strings.Add('Bt=20');
           RG_FonRangeCriteria.ItemIndex := fbrFixed;
//           RG_FonFunctionCriteria.ItemIndex := fbFindBetweenPoints;
           RG_FonFunctionCriteria.ItemIndex := fbBt40andN2;
           Edit_BG_Start.Text := '231';
//           Edit_BG_Start.Text := '10';
           Edit_BG_End.Text := '240';
           Edit_WaitingPeakCentre.Text := '145';
           Edit_WaitMaxWidth.Text:='270';
           RG_FuncFindBy0.ItemIndex := 1;
//           EditL_Start.Text := '0';
//           EditL_Num.Text := '5';
           EditL_Start.Text := '40';
           EditL_Num.Text := '20';
           CB_FitFon.Checked := false;
           CB_FitPeak.Checked := false;
           RG_TypeS.ItemIndex := clcSquare;
           RG_InterestRange.ItemIndex := 2;
//           Edit_DefaultN1.Text := '40';
           Edit_DefaultN1.Text := '60';
           Edit_DefaultN2.Text := '230';
         end;
      alArea60_240:
         begin // Area 60-240 Cu (Finger Ring)
           VLE.Strings.Add('Bt=40');
           RG_FonRangeCriteria.ItemIndex := fbrFixed;
           RG_FonFunctionCriteria.ItemIndex := fbBt40andN2;
//           Edit_BG_Start.Text := '260';
//           Edit_BG_End.Text := '265';
           Edit_BG_Start.Text := '252';
           Edit_BG_End.Text := '260';
           Edit_WaitingPeakCentre.Text := '150';
           Edit_WaitMaxWidth.Text:='180';
           RG_FuncFindBy0.ItemIndex := 0;
           EditL_Start.Text := '40';
           EditL_Num.Text := '20';
           CB_FitFon.Checked := false;
           CB_FitPeak.Checked := false;
           RG_TypeS.ItemIndex := clcSquare;
           RG_InterestRange.ItemIndex := 2;
           Edit_DefaultN1.Text := '60';
           Edit_DefaultN2.Text := '251';
         end;
      alStep:
         begin // (Finger Ring Old Alternative method)
           VLE.Strings.Add('Bt=15');
           RG_FuncFindBy0.ItemIndex := 1;
           RG_BackgroundFunction.ItemIndex := 1;
           Edit_BG_Start.Text := '242';
           Edit_BG_End.Text := '260';
           Edit_WaitingPeakCentre.Text := '170';
           Edit_WaitMaxWidth.Text:='180';
           RG_FuncFindBy0.ItemIndex := 0;
           EditL_Start.Text := '113';
           EditL_Num.Text := '20';
           CB_FitFon.Checked := false;
           CB_FitPeak.Checked := false;
           RG_TypeS.ItemIndex := clcSquare;
           RG_InterestRange.ItemIndex := 2;
           Edit_DefaultN1.Text := '134';
           Edit_DefaultN2.Text := '230';
         end;
      alUser:
         begin // (User method)
//           LoadFromFile(AppDir+DirPathMethod+Edit_MethodName.Text+'.mtd');
           St := Edit_MethodName.Text;
           DirStr:=AppDir + DirPathMethod + St + '.mtd';
           LoadFromFile(DirStr);
           Edit_MethodName.Visible := True;
           Label_MethodName.Visible := True;
           BtnSetMethod.Visible := True;
         end;
    end;
  //  CalcForm.DisableCalcControls := OldDisableCalcControls;
    bOptionsChanged := False;
  finally
    DisableOptionsControls := False;
  end;
end;

procedure TOptionsForm.CB_ShowNegativeDoseClick(Sender: TObject);
begin
  bCalcForm_ShowNegativeDose := CB_ShowNegativeDose.Checked;
end;

procedure TOptionsForm.CB_NoLineCorrectionClick(Sender: TObject);
begin
  OptionsChanged(Nil);
end;

procedure TOptionsForm.CB_UseTempProfileInfoClick(Sender: TObject);
begin
  OptionsChanged(Nil);
end;

end.
