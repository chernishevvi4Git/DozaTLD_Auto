unit uDosimeterConstructorForm;

interface

uses
  SysUtils, Variants, Messages,
//  System.UITypes, StrUtils, DynVarsEh, MemTableEh,
  Classes, Graphics, Math, DBGridEhImpExp,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, DB, DBCtrlsEh, Buttons, ComCtrls, Grids, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, EhLibLCL, GridsEh, DBAxisGridsEh, DBGridsEh, MemTableDataEh, DataSetImpExpEh;

// Data.Win.ADODB, Vcl.Mask, JvExStdCtrls, JvCombobox,

type
  TEditDosMode = (addGroup,addFromFile);

    TNewDosimeter = record              //  добавлене нового дозиметра
    DosId           : String;
    FullDosID       : String;
    Postfix         : String;
    DosTypeId       : integer;
    DosType         : String;
    Status          : integer;
    K1              : double;
    K2              : double;
    K3              : double;
    K4              : double;
    K5              : double;
    Kgn             : double;
    Tldid           : integer;
    Partid          : integer;
    PartName        : String;
    Regtime         : TDateTime;
    Vertime         : TDateTime;
    Organization    : String;
    Department      : String;
    DosComment      : String;
    MeasVal         : String;
    DetTypeD1       : integer;
    DetTypeD2       : integer;
    DetTypeD3       : integer;
    DetTypeD4       : integer;
    Usekh10         : boolean;
    Usekh10g        : boolean;
    Usekh10n        : boolean;
    Usekhgn         : boolean;
    Usekh3          : boolean;
    Usekh007        : boolean;
    Usekhr1         : boolean;
    Usekhr2         : boolean;
    Formula         : String;
    Error           : String;
  end;

  { TDosimeterConstructorForm }

  TDosimeterConstructorForm = class(TForm)
    PanelDosTitle: TPanel;
    PanelLeft: TPanel;
    EditDosNumberFrom: TEdit;
    EditDosCount: TEdit;
    LabelDosCnt: TLabel;
    LabelPostfix: TLabel;
    EditDosPostfix: TEdit;
    EditDosOrg: TEdit;
    EditDosDep: TEdit;
    ComboBoxDosType: TComboBox;
    LabelDosType: TLabel;
    LabelOrg: TLabel;
    LabelDep: TLabel;
    LabelDosNumberFrom: TLabel;
    BtnNext: TButton;
    EditDosK_1: TEdit;
    LblK_1: TLabel;
    BtnCancel: TButton;
    LblDosTypeExist: TLabel;
    PanelBottom: TPanel;
    EditDosK_gn: TEdit;
    LblK_gn: TLabel;
    EditDosK_2: TEdit;
    LblK_2: TLabel;
    EditDosK_3: TEdit;
    LblK_3: TLabel;
    EditDosK_4: TEdit;
    LblK_4: TLabel;
    EditDosK_5: TEdit;
    LblK_5: TLabel;
    SpeedBtnDosInf: TSpeedButton;
    PageControlParameters: TPageControl;
    TabSheetMainParam: TTabSheet;
    TabSheetAdditionalParam: TTabSheet;
    PanelPageMainParam: TPanel;
    PanelPageAdditionalParam: TPanel;
    LblDotKgn: TLabel;
    LblDotK5: TLabel;
    LblDotK4: TLabel;
    LblDotK3: TLabel;
    LblDotK2: TLabel;
    LblDotK1: TLabel;
    GroupBoxK: TGroupBox;
    EditPartName: TEdit;
    LblDosPartName: TLabel;
    RadioBtnCreatePart: TRadioButton;
    RadioBtnNotCreatePart: TRadioButton;
    ShapeErr: TShape;
    SpeedBtnPartInf: TSpeedButton;
    PanelDosNumberParameters: TPanel;
    LabelTitle: TLabel;
    OpenDialogList: TOpenDialog;
    ShapeErrK1: TShape;
    ShapeErrK2: TShape;
    ShapeErrK3: TShape;
    ShapeErrK4: TShape;
    ShapeErrK5: TShape;
    ShapeErrKgn: TShape;
    procedure ComboBoxDosTypeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditDosCountKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditDosK_1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure EditDosK_2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure EditDosK_3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure EditDosK_4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure EditDosK_5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure EditDosNumberFromKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditDosPostfixKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditPartNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RadioBtnNumberClick(Sender: TObject);
    procedure RadioBtnRangeClick(Sender: TObject);
    procedure ComboBoxDosTypeChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure SpeedBtnDosInfClick(Sender: TObject);
    procedure SpeedBtnPartInfClick(Sender: TObject);
    procedure RadioBtnCreatePartClick(Sender: TObject);
    procedure RadioBtnNotCreatePartClick(Sender: TObject);
    procedure RadioBtnFromFileClick(Sender: TObject);
    procedure EditDosNumberFromChange(Sender: TObject);
    procedure EditDosCountChange(Sender: TObject);
    procedure DBGridEhDosIDKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure EditKeyPressOnlyIntNumbers(Sender: TObject; var Key: Char);
    procedure EditDosK_1Change(Sender: TObject);
    procedure EditDosK_2Change(Sender: TObject);
    procedure EditDosK_3Change(Sender: TObject);
    procedure EditDosK_4Change(Sender: TObject);
    procedure EditDosK_5Change(Sender: TObject);
    procedure EditDosK_gnChange(Sender: TObject);
    procedure EditDosPostfixKeyPress(Sender: TObject; var Key: Char);
  private
    FCreatePart             : boolean;
    FEditDosMode            : TEditDosMode;

    FFileDosIDLoaded        : boolean;
    FFileDosTypeLoaded      : boolean;
    FFileDetTypeLoaded      : boolean;
    FFileDevSettingsLoaded  : boolean;

    function GetEditDosMode: TEditDosMode;
    function IsDosExist(DosName, Postfix: String): boolean;
    function IsValidDosimeterNumber: boolean;
    function IsValidDosimeterType: boolean;
    function IsValidDosimeterK: boolean;
    procedure SetEditDosMode(aEditDosMode: TEditDosMode);
    procedure CheckEditDosMode;
    procedure DBGridDosTypeRefresh;
    procedure AddNewDosimeterInLibrary;
    procedure ChangeDosType;
    procedure LoadParameters;
    procedure EditChangeK(Edit: TEdit; Shape: TShape);
    procedure MakePart(DosCnt: integer);
    { Private declarations }
  public
    NewDosimeter           : TNewDosimeter;      // новый дозиметр
    RangeFrom              : integer;
    RangeTo                : integer;
    RangeCount             : integer;
    property EditDosMode: TEditDosMode read FEditDosMode write SetEditDosMode;
    { Public declarations }
  end;

var
  DosimeterConstructorForm: TDosimeterConstructorForm;

implementation

uses
  uLog,
  uConst,
  uDataModule,
  uMainForm,
  uSeparator,
  uFunctions,
  uDosimeterTypeConstructorForm,
  uImportDosimeters,
  uDosimeterPartForm,
  uLanguages;

{$R *.dfm}

{ TDosimeterConstructorForm }

procedure TDosimeterConstructorForm.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TDosimeterConstructorForm.BtnNextClick(Sender: TObject);
begin
  ImportDosimetersW.LoadFromFile:=False;
  ImportDosimetersW.ShowModal;
end;

procedure TDosimeterConstructorForm.Button1Click(Sender: TObject);
begin
  ImportDosimetersW.ImportFromFile:=false;
  ImportDosimetersW.ShowModal;
end;

function TDosimeterConstructorForm.IsValidDosimeterK: boolean;
begin
  try
    if EditDosK_1.Visible then StrToFloatRegion(EditDosK_1.Text);
    if EditDosK_2.Visible then StrToFloatRegion(EditDosK_2.Text);
    if EditDosK_3.Visible then StrToFloatRegion(EditDosK_3.Text);
    if EditDosK_4.Visible then StrToFloatRegion(EditDosK_4.Text);
    if EditDosK_5.Visible then StrToFloatRegion(EditDosK_5.Text);
    if EditDosK_gn.Visible then StrToFloatRegion(EditDosK_gn.Text);
    Result:=true;
  except
    MessageDlg(rsInputCorrectKoeff,mtError,[mbOK], 0);
    Result:=false;
  end;
end;

function TDosimeterConstructorForm.IsValidDosimeterNumber: boolean;
begin
  if (EditDosNumberFrom.Text<>'') AND (EditDosCount.Text<>'') then
    Result:=true
  else
  begin
    Result:=false;
    MessageDlg(rsInputCorrectNewDosimeterNumbers,mtError,[mbOK], 0);
  end;
end;

function TDosimeterConstructorForm.IsValidDosimeterType: boolean;
begin
  if ComboBoxDosType.Items[ComboBoxDosType.ItemIndex]<>'' then
  begin
    Result:=true;
    LblDosTypeExist.Caption:='';
    LblDosTypeExist.Visible:=false;
  end
  else
  begin
    Result:=false;
    LblDosTypeExist.Caption:=Format('%s!',[rsDosimeterTypeRequired]);
    LblDosTypeExist.Visible:=true;
  end;
end;

procedure TDosimeterConstructorForm.AddNewDosimeterInLibrary;
var
  i       : integer;
  temp    : word;
  flag    : boolean;
  d_cnt   : integer;
  d_name  : String;
begin
  flag:=false;

  if EditDosPostfix.Text <> '' then
    NewDosimeter.Postfix:=EditDosPostfix.Text
  else
    NewDosimeter.Postfix:= '-';

  NewDosimeter.Organization:=EditDosOrg.Text;
  NewDosimeter.Department:=EditDosDep.Text;
  NewDosimeter.DosTypeId:=TLDDataModule.GetDosTypeID(ComboBoxDosType.Items[ComboBoxDosType.ItemIndex]);
  NewDosimeter.DosType:=ComboBoxDosType.Items[ComboBoxDosType.ItemIndex];
  NewDosimeter.Tldid:=MainForm.DeviceID;
//  // проверка на int
//  if StrToIntRegion(EditDosPart.Text) > 0 then
//    NewDosimeter.Partid:=StrToIntRegion(EditDosPart.Text)
//  else
//  NewDosimeter.Partid:=TLDDataModule.GetPartID(EditPartName.Text);

  if EditDosK_1.Visible then NewDosimeter.K1:=StrToFloatRegion(EditDosK_1.Text)
    else NewDosimeter.K1:=NAN;
  if EditDosK_2.Visible then NewDosimeter.K2:=StrToFloatRegion(EditDosK_2.Text)
    else NewDosimeter.K2:=NAN;
  if EditDosK_3.Visible then NewDosimeter.K3:=StrToFloatRegion(EditDosK_3.Text)
    else NewDosimeter.K3:=NAN;
  if EditDosK_4.Visible then NewDosimeter.K4:=StrToFloatRegion(EditDosK_4.Text)
    else NewDosimeter.K4:=NAN;
  if EditDosK_5.Visible then NewDosimeter.K5:=StrToFloatRegion(EditDosK_5.Text)
    else NewDosimeter.K5:=NAN;
  if EditDosK_gn.Visible then NewDosimeter.Kgn:=StrToFloatRegion(EditDosK_gn.Text)
    else NewDosimeter.Kgn:=NAN;

  if (NewDosimeter.K1<0) AND (not (NewDosimeter.K1.IsNan)) OR
     (NewDosimeter.K2<0) AND (not (NewDosimeter.K2.IsNan)) OR
     (NewDosimeter.K3<0) AND (not (NewDosimeter.K3.IsNan)) OR
     (NewDosimeter.K4<0) AND (not (NewDosimeter.K4.IsNan)) OR
     (NewDosimeter.K5<0) AND (not (NewDosimeter.K5.IsNan)) OR
     (NewDosimeter.Kgn<0) AND (not (NewDosimeter.Kgn.IsNan)) then
  begin
    NewDosimeter.Status:=cDosNotCalibrated;
  end
  else
  begin
    NewDosimeter.Status:=cDosCalibrated;
    NewDosimeter.Vertime:=Now;
  end;

  if FCreatePart then
  begin
    NewDosimeter.PartName:=EditPartName.Text;

    if (Trim(NewDosimeter.PartName)<>'') AND (Trim(NewDosimeter.PartName)<>'-') then
    begin
      if ShapeErr.Visible then ShapeErr.Visible:=false;

      if not TLDDataModule.IsDosimeterPartExist(NewDosimeter.PartName,MainForm.DeviceID) then
      begin
        if ShapeErr.Visible then ShapeErr.Visible:=false;

        try
          if TLDDataModule.AddNewDosPart(NewDosimeter.PartName,
                                               NewDosimeter.K1,
                                               NewDosimeter.K2,
                                               NewDosimeter.K3,
                                               NewDosimeter.K4,
                                               NewDosimeter.K5,
                                              NewDosimeter.Kgn,
                                                    RangeCount,
                                          NewDosimeter.DosType,
                                          NewDosimeter.Vertime) then
          begin
            flag:=true;
            WriteLog(Format(rsNewPartyAdded,[NewDosimeter.PartName]));
          end
          else
          begin
            flag:=false;
            WriteLog(Format(rsErrNewPartyAdded,[NewDosimeter.PartName]));
          end;
        except
          on E: Exception do
          begin
            flag:=false;
            WriteLog(Format(rsErrNewPartyAdded,[NewDosimeter.PartName]) + '. ' + E.Message);
          end;
        end;

        NewDosimeter.Partid:=TLDDataModule.GetPartID(NewDosimeter.PartName,MainForm.DeviceID);

      end
      else
      begin
        ShapeErr.Visible:=true;

        d_name:=TLDDataModule.GetDosTypeInPart(TLDDataModule.GetPartID(NewDosimeter.PartName,MainForm.DeviceID));
        d_cnt:=TLDDataModule.GetDosCntInPart(TLDDataModule.GetPartID(NewDosimeter.PartName,MainForm.DeviceID));

        temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('"%s" (%d "%s") - %s. %s?',[NewDosimeter.PartName,d_cnt,d_name,rsPartyExists,rsPartyReform]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');
        case temp of
          mrYes:
          begin
            try
              TLDDataModule.DeleteDosimeterPart(NewDosimeter.PartName,MainForm.DeviceID);

              if TLDDataModule.AddNewDosPart(NewDosimeter.PartName,
                                                   NewDosimeter.K1,
                                                   NewDosimeter.K2,
                                                   NewDosimeter.K3,
                                                   NewDosimeter.K4,
                                                   NewDosimeter.K5,
                                                  NewDosimeter.Kgn,
                                                        RangeCount,
                                              NewDosimeter.DosType,
                                              NewDosimeter.Vertime) then
              begin
                flag:=true;

                d_name:=TLDDataModule.GetDosTypeInPart(TLDDataModule.GetPartID(NewDosimeter.PartName,MainForm.DeviceID));
                d_cnt:=TLDDataModule.GetDosCntInPart(TLDDataModule.GetPartID(NewDosimeter.PartName,MainForm.DeviceID));

                MessageDlg(Format(rsNewPartyAdded,[NewDosimeter.PartName]) + Format(' (%d - "%s")',[d_cnt,d_name]),mtInformation,[mbOK],0);

                WriteLog(Format(rsNewPartyAdded,[NewDosimeter.PartName]));
              end
              else
              begin
                flag:=false;
                WriteLog(Format(rsErrNewPartyAdded,[NewDosimeter.PartName]));
              end;
            except
              on E: Exception do
              begin
                WriteLog(Format(rsErrNewPartyAdded,[NewDosimeter.PartName]) + '. ' + E.Message);
              end;
            end;

            NewDosimeter.Partid:=TLDDataModule.GetPartID(NewDosimeter.PartName,MainForm.DeviceID);
            if ShapeErr.Visible then ShapeErr.Visible:=false;
          end;
          mrNo:
          begin
            flag:=false;
            NewDosimeter.Partid:=0;
            if ShapeErr.Visible then ShapeErr.Visible:=false;
          end
          else
          begin
            flag:=false;
            NewDosimeter.Partid:=0;
            if ShapeErr.Visible then ShapeErr.Visible:=false;
          end;
        end;
      end;
    end
    else if (Trim(NewDosimeter.PartName)='-') then
    begin
      NewDosimeter.Partid:=0;
      flag:=true;
      if ShapeErr.Visible then ShapeErr.Visible:=false;
    end
    else
    begin
      ShapeErr.Visible:=true;
      MessageDlg(rsNeedPartyName,mtError,[mbOK],0);
      NewDosimeter.Partid:=0;
    end;
  end
  else
  begin
    NewDosimeter.Partid:=0;
    flag:=true;
  end;

  if flag then
  begin
    for i := RangeFrom to RangeTo do
    begin
      try
        NewDosimeter.DosId:=IntToStr(i);

        if NewDosimeter.Postfix = '-' then
          NewDosimeter.FullDosID:=NewDosimeter.DosId
        else
          NewDosimeter.FullDosID:=NewDosimeter.DosId+NewDosimeter.Postfix;

        if TLDDataModule.IsDosimeterExist(NewDosimeter.FullDosID) then
        begin
          if TLDDataModule.UpdateDosimeterInLibrary(IntToStr(i),
                                                    NewDosimeter.Postfix,
                                                    IntToStr(NewDosimeter.DosTypeId),
                                                    NewDosimeter.DosType,
                                                    IntToStr(NewDosimeter.Status),
                                                    FloatToStrRegion(NewDosimeter.K1),
                                                    FloatToStrRegion(NewDosimeter.K2),
                                                    FloatToStrRegion(NewDosimeter.K3),
                                                    FloatToStrRegion(NewDosimeter.K4),
                                                    FloatToStrRegion(NewDosimeter.K5),
                                                    FloatToStrRegion(NewDosimeter.Kgn),
                                                    IntToStr(NewDosimeter.Tldid),
                                                    IntToStr(NewDosimeter.Partid),
                                                    DateTimeToStr(Now),
                                                    DateToStr(NewDosimeter.Vertime),
                                                    NewDosimeter.Organization,
                                                    NewDosimeter.Department
                                                    ) then
            WriteLog(Format('%s - %s',[rsDosimeterUpdated,NewDosimeter.FullDosID]))
          else
            WriteLog(Format('%s - %s',[rsErrDosimeterUpdated,NewDosimeter.FullDosID]))
        end
        else
        begin
          if TLDDataModule.InsertDosimeterInLibrary(IntToStr(i),
                                                    NewDosimeter.Postfix,
                                                    IntToStr(NewDosimeter.DosTypeId),
                                                    NewDosimeter.DosType,
                                                    IntToStr(NewDosimeter.Status),
                                                    FloatToStrRegion(NewDosimeter.K1),
                                                    FloatToStrRegion(NewDosimeter.K2),
                                                    FloatToStrRegion(NewDosimeter.K3),
                                                    FloatToStrRegion(NewDosimeter.K4),
                                                    FloatToStrRegion(NewDosimeter.K5),
                                                    FloatToStrRegion(NewDosimeter.Kgn),
                                                    IntToStr(NewDosimeter.Tldid),
                                                    IntToStr(NewDosimeter.Partid),
                                                    DateTimeToStr(Now),
                                                    DateToStr(NewDosimeter.Vertime),
                                                    NewDosimeter.Organization,
                                                    NewDosimeter.Department
                                                    ) then
            WriteLog(Format('%s - %s',[rsDosimeterAdded,NewDosimeter.FullDosID]))
          else
            WriteLog(Format('%s - %s',[rsErrDosimeterAdded,NewDosimeter.FullDosID]));
        end;
      except
        on E: exception do
        begin
          WriteLog(Format('%s - %s. %s',[rsErrDosimeterAddOrUpdated,IntToStr(i)+NewDosimeter.Postfix,E.Message]));
          MessageDlg(Format('%s - %s. %s - %s',[rsErrDosimeterAddOrUpdated,IntToStr(i)+NewDosimeter.Postfix,rsDetailInfoAtFile,Application.ExeName+PathDelim+cLogFileName]),mtError, [mbOK], 0);
        end;
      end;
    end;
  end;


  MainForm.LoadFilters;
end;

procedure TDosimeterConstructorForm.ComboBoxDosTypeChange(Sender: TObject);
begin
  ChangeDosType;
end;

function TDosimeterConstructorForm.IsDosExist(DosName, Postfix: String): boolean;
var
  localPostfix: String;
begin
  if (Postfix = '') OR (Postfix = cEmptyData) then
    localPostfix:=cEmptyData
  else
    localPostfix:=Postfix;

  if DosName <> '' then
  begin
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDosID+' FROM tlddosimeterid WHERE '+cFieldDosID+' = '+DosName+' AND '+cFieldDosPostfix+'='+#39+localPostfix+#39);
    TLDDataModule.ADOQuery.Active:=True;

    if TLDDataModule.ADOQuery.RecordCount>0 then
      Result:=true
    else
      Result:=false;
  end
  else
    Result:=false;

end;

procedure TDosimeterConstructorForm.ChangeDosType;
var
  formulaindex: integer;
  procedure SetEdit(Edit: TEdit; Value: String; LblDotK, LblK: TLabel);
  begin
    if Value=cNull then
    begin
      Edit.Visible:=false;
      LblDotK.Visible:=false;
      LblK.Visible:=false;
      Edit.Text:=Value;
    end
    else
    begin
      Edit.Visible:=true;
      LblDotK.Visible:=true;
      LblK.Visible:=true;
      if Edit.Text <> Value then Edit.Text:=Value;
    end;
  end;
begin
//  try

  formulaindex:=TLDDataModule.GetDosTypeFormulaID(ComboBoxDosType.Text);

  LblK_1.Visible:=false;
  LblK_2.Visible:=false;
  LblK_3.Visible:=false;
  LblK_4.Visible:=false;
  LblK_5.Visible:=false;
  LblK_gn.Visible:=false;

  LblDotK1.Visible:=false;
  LblDotK2.Visible:=false;
  LblDotK3.Visible:=false;
  LblDotK4.Visible:=false;
  LblDotK5.Visible:=false;
  LblDotKgn.Visible:=false;

  EditDosK_1.Visible:=false;
  EditDosK_2.Visible:=false;
  EditDosK_3.Visible:=false;
  EditDosK_4.Visible:=false;
  EditDosK_5.Visible:=false;
  EditDosK_gn.Visible:=false;

  if LblDosTypeExist.Visible then LblDosTypeExist.Visible:=false;

//  EditDosK_1.Text:='';
//  EditDosK_2.Text:='';
//  EditDosK_3.Text:='';
//  EditDosK_4.Text:='';
//  EditDosK_5.Text:='';
//  EditDosK_gn.Text:='';

// formulaIndex:=3;

   if formulaIndex>=0 then
     case cDetMeasValTxt_Index[formulaIndex] of
      c_not_found:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      c_none:
      begin

      end;
      cHp_10g_1d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_10g_2d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_10g_3d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_10g_4d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_10g_2d_Hp_10n_2d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
        SetEdit(EditDosK_2,'-1',LblDotK2,LblK_2);
        SetEdit(EditDosK_gn,'-1',LblDotKgn,LblK_gn);
      end;
      cHp_10g_2d_Hp_10n_1d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
        SetEdit(EditDosK_2,'-1',LblDotK2,LblK_2);
        SetEdit(EditDosK_gn,'-1',LblDotKgn,LblK_gn);
      end;
      cHp_10g_1d_Hp_10n_2d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
        SetEdit(EditDosK_2,'-1',LblDotK2,LblK_2);
        SetEdit(EditDosK_gn,'-1',LblDotKgn,LblK_gn);
      end;
      cHp_10g_1d_Hp_10n_1d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
        SetEdit(EditDosK_2,'-1',LblDotK2,LblK_2);
        SetEdit(EditDosK_gn,'-1',LblDotKgn,LblK_gn);
      end;
      cHp_007g_1d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_007g_2d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_007g_3d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_007g_4d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_007gb_1d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_007gb_2d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_007gb_3d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_007gb_4d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_3_1d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_3_2d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_3_3d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_3_4d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_star_g_1d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_star_g_2d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_star_g_3d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_star_g_4d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cH_007_dir_g_1d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cH_007_dir_g_2d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cH_007_dir_g_3d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cH_007_dir_g_4d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cD_1d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cD_2d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cD_3d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cD_4d:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
      cHp_10g_Hp_10n_Hp_007g_Hp_3:
      begin
        SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
        SetEdit(EditDosK_2,'-1',LblDotK2,LblK_2);
        SetEdit(EditDosK_3,'-1',LblDotK2,LblK_3);
        SetEdit(EditDosK_4,'-1',LblDotK2,LblK_4);
        SetEdit(EditDosK_gn,'0',LblDotKgn,LblK_gn);
      end;
      else
      begin
        //SetEdit(EditDosK_1,'-1',LblDotK1,LblK_1);
      end;
    end;

  {except
        on E: exception do
           ShowMessage(E.Message);
  end;}

end;

procedure TDosimeterConstructorForm.CheckEditDosMode;
begin

end;

procedure TDosimeterConstructorForm.DBGridDosTypeRefresh;
var
  i: integer;
begin
// обновление Chekbox-а типов дозимтров
  if TLDDataModule.IsDBConnected then
  begin
    try
      TLDDataModule.ADOQuery.Active:=False;
      TLDDataModule.ADOQuery.SQL.Clear;
      TLDDataModule.ADOQuery.SQL.Add('SELECT '+cFieldDosType+' FROM '+cDBTableDosType+' WHERE '+cFieldDosTypeID+'> 0 '+'ORDER BY '+cFieldDosTypeID);
      TLDDataModule.ADOQuery.Active:=True;

      ComboBoxDosType.Items.Clear;

      for i := 1 to TLDDataModule.ADOQuery.RecordCount do
      begin
        ComboBoxDosType.Items.Add(TLDDataModule.ADOQuery.FieldValues[cFieldDosType]);
        if i <> TLDDataModule.ADOQuery.RecordCount then TLDDataModule.ADOQuery.Next;
      end;

    except
      on E: exception do
      begin
        MessageDlg(rsErrBuildDosimeterList,mtError, mbOKCancel, 0);
        WriteLog(rsErrBuildDosimeterList+'. '+E.Message);
      end;
    end;
  end;
end;

procedure TDosimeterConstructorForm.DBGridEhDosIDKeyPress(Sender: TObject; var Key: Char);
begin
  if (Sender as TDbGridEh).SelectedField.FieldName = 'fulldosid' then
  case Key of
    '0'..'9' :
      Key:=Key;
    else
      Key:=#0;
  end;
end;

procedure TDosimeterConstructorForm.EditDosNumberFromChange(Sender: TObject);
begin
  if TEdit(Sender).Text<>'' then
  begin
    try
      RangeFrom:=StrToInt(TEdit(Sender).Text);
      if RangeCount>=1 then
        RangeTo:=RangeFrom+RangeCount-1
      else
        RangeTo:=RangeFrom+RangeCount;
    except
      TEdit(Sender).Text:='';
    end;
  end
end;

procedure TDosimeterConstructorForm.EditDosPostfixKeyPress(Sender: TObject; var Key: Char);
begin
  Key:=NoSpecialSymbols(Key);
end;

procedure TDosimeterConstructorForm.EditChangeK(Edit: TEdit; Shape: TShape);
begin
  if IsReal(Edit.Text) then
    Shape.Visible:=false
  else
    Shape.Visible:=true;
end;

procedure TDosimeterConstructorForm.MakePart(DosCnt: integer);
begin
  if RangeCount>=DosCnt then
    RadioBtnCreatePart.Checked:=true
  else
    RadioBtnNotCreatePart.Checked:=true;
end;

procedure TDosimeterConstructorForm.EditDosCountChange(Sender: TObject);
begin
  if TEdit(Sender).Text<>'' then
  begin
    RangeCount:=StrToInt(TEdit(Sender).Text);
    if RangeCount>=1 then
      RangeTo:=RangeFrom+RangeCount-1
    else
      RangeTo:=RangeFrom+RangeCount;

    MakePart(MainForm.DosCntAutoCreatePart);

  end;
end;

procedure TDosimeterConstructorForm.EditDosK_1Change(Sender: TObject);
begin
  EditChangeK(EditDosK_1,ShapeErrK1);
end;

procedure TDosimeterConstructorForm.EditDosK_2Change(Sender: TObject);
begin
  EditChangeK(EditDosK_2,ShapeErrK2);
end;

procedure TDosimeterConstructorForm.EditDosK_3Change(Sender: TObject);
begin
  EditChangeK(EditDosK_3,ShapeErrK3);
end;

procedure TDosimeterConstructorForm.EditDosK_4Change(Sender: TObject);
begin
  EditChangeK(EditDosK_4,ShapeErrK4);
end;

procedure TDosimeterConstructorForm.EditDosK_5Change(Sender: TObject);
begin
  EditChangeK(EditDosK_5,ShapeErrK5);
end;

procedure TDosimeterConstructorForm.EditDosK_gnChange(Sender: TObject);
begin
  EditChangeK(EditDosK_gn,ShapeErrKgn);
end;

procedure TDosimeterConstructorForm.EditKeyPressOnlyIntNumbers(Sender: TObject; var Key: Char);
begin
  Key:=OnlyIntNumbers(Key);
end;

procedure TDosimeterConstructorForm.FormShow(Sender: TObject);
begin
  ShapeErr.Visible:=false;
  LoadParameters;
end;

procedure TDosimeterConstructorForm.EditDosNumberFromKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,EditDosCount);
end;

procedure TDosimeterConstructorForm.EditDosPostfixKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = cVK_Enter) then BtnNext.SetFocus;
end;

procedure TDosimeterConstructorForm.EditPartNameKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnterIfVisible(Key,EditDosK_1,BtnNext);
end;

procedure TDosimeterConstructorForm.EditDosCountKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  MakePart(MainForm.DosCntAutoCreatePart);
  SetFocusOnNextEditAfterEnter(Key,ComboBoxDosType);
end;

procedure TDosimeterConstructorForm.EditDosK_1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnterIfVisible(Key,EditDosK_2,BtnNext);
end;

procedure TDosimeterConstructorForm.EditDosK_2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnterIfVisible(Key,EditDosK_gn,BtnNext);
end;

procedure TDosimeterConstructorForm.EditDosK_3KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnterIfVisible(Key,EditDosK_4,BtnNext);
end;

procedure TDosimeterConstructorForm.EditDosK_4KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnterIfVisible(Key,EditDosK_5,BtnNext);
end;

procedure TDosimeterConstructorForm.EditDosK_5KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  SetFocusOnNextEditAfterEnter(Key,BtnNext);
end;

procedure TDosimeterConstructorForm.ComboBoxDosTypeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if RadioBtnCreatePart.Checked then
    SetFocusOnNextEditAfterEnter(Key,EditPartName)
  else
    SetFocusOnNextEditAfterEnterIfVisible(Key,EditDosK_1,BtnNext);
end;

procedure TDosimeterConstructorForm.LoadParameters;
  procedure SetLblCaptionUnicode(Lbl: TLabel; Value: String);
  begin
    Lbl.Caption:=Value;
  end;
begin
  SetLblCaptionUnicode(LblDotK1,Format('%s',[cuUnicodeSymbol_Dot]));
  SetLblCaptionUnicode(LblDotK2,Format('%s',[cuUnicodeSymbol_Dot]));
  SetLblCaptionUnicode(LblDotK3,Format('%s',[cuUnicodeSymbol_Dot]));
  SetLblCaptionUnicode(LblDotK4,Format('%s',[cuUnicodeSymbol_Dot]));
  SetLblCaptionUnicode(LblDotK5,Format('%s',[cuUnicodeSymbol_Dot]));
  SetLblCaptionUnicode(LblDotKgn,Format('%s',[cuUnicodeSymbol_Dot]));

  GetEditDosMode;

  RangeFrom:=0;
  RangeCount:=1;
  RangeTo:=0;

  if EditDosNumberFrom.Enabled then EditDosNumberFrom.Text:='';
  if EditDosCount.Enabled then EditDosCount.Text:='1';

  EditDosPostfix.Text:='';
  ComboBoxDosType.ItemIndex:=-1;
  ComboBoxDosTypeChange(Self);

  EditDosOrg.Text:='';
  EditDosDep.Text:='';

  if RadioBtnCreatePart.Checked then
    RadioBtnCreatePartClick(self)
  else
    RadioBtnNotCreatePartClick(self);

  DBGridDosTypeRefresh;
end;

function TDosimeterConstructorForm.GetEditDosMode: TEditDosMode;
begin
  case FEditDosMode of
//    addSingle:
//    begin
////      LabelNumber.Enabled:=true;
////      EditDosNumber.Enabled:=true;
//
//      LabelDosNumberFrom.Enabled:=false;
//      LabelDosCnt.Enabled:=false;
//      EditDosCount.Enabled:=false;
//      EditDosNumberFrom.Enabled:=false;
//      EditDosCount.Enabled:=false;
//      EditDosNumberFrom.Text:='';
//      EditDosCount.Text:='1';
//
//      LabelPostfix.Enabled:=true;
//      LabelDosType.Enabled:=true;
//      EditDosPostfix.Enabled:=true;
//      EditDosPostfix.Text:='';
//      ComboBoxDosType.Enabled:=true;
//      SpeedBtnDosInf.Enabled:=true;
//
//      EditLoadListDosID.Enabled:=false;
//      BtnOpenDosID.Enabled:=false;
//    end;
    addGroup:
    begin
      LabelDosNumberFrom.Enabled:=true;
      LabelDosCnt.Enabled:=true;
      EditDosCount.Enabled:=true;
      EditDosNumberFrom.Enabled:=true;
      EditDosCount.Text:='1';

      LabelPostfix.Enabled:=true;
      LabelDosType.Enabled:=true;
      EditDosPostfix.Enabled:=true;
      EditDosPostfix.Text:='';
      ComboBoxDosType.Enabled:=true;
//      SpeedBtnDosInf.Enabled:=true;

//      EditLoadListDosID.Enabled:=false;
//      EditLoadListDosID.Text:='';
//      BtnOpenDosID.Enabled:=false;

      PageControlParameters.Enabled:=true;
      TabSheetMainParam.Enabled:=true;
      GroupBoxK.Enabled:=true;

      RadioBtnCreatePart.Enabled:=true;
      LblDosPartName.Enabled:=true;
      EditPartName.Enabled:=true;
      SpeedBtnPartInf.Enabled:=true;
      ShapeErr.Enabled:=true;
      RadioBtnNotCreatePart.Enabled:=true;
      LblDotK1.Enabled:=true;
      LblDotK2.Enabled:=true;
      LblDotK3.Enabled:=true;
      LblDotK4.Enabled:=true;
      LblDotK5.Enabled:=true;
      LblDotKgn.Enabled:=true;
      LblK_1.Enabled:=true;
      LblK_2.Enabled:=true;
      LblK_3.Enabled:=true;
      LblK_4.Enabled:=true;
      LblK_5.Enabled:=true;
      LblK_gn.Enabled:=true;
      EditDosK_1.Enabled:=true;
      EditDosK_2.Enabled:=true;
      EditDosK_3.Enabled:=true;
      EditDosK_4.Enabled:=true;
      EditDosK_5.Enabled:=true;
      EditDosK_gn.Enabled:=true;

      LabelOrg.Enabled:=true;
      LabelDep.Enabled:=true;
      EditDosOrg.Enabled:=true;
      EditDosDep.Enabled:=true;
    end;
    addFromFile:
    begin
      LabelDosNumberFrom.Enabled:=false;
      LabelDosCnt.Enabled:=false;
      EditDosCount.Enabled:=false;
      EditDosNumberFrom.Enabled:=false;
      EditDosCount.Enabled:=false;
      EditDosNumberFrom.Text:='';
      EditDosCount.Text:='';

      LabelPostfix.Enabled:=false;
      LabelDosType.Enabled:=false;
      EditDosPostfix.Enabled:=false;
      EditDosPostfix.Text:='';
      ComboBoxDosType.Enabled:=false;
      ComboBoxDosType.ItemIndex:=-1;
//      SpeedBtnDosInf.Enabled:=false;

//      EditLoadListDosID.Enabled:=true;
//      EditLoadListDosID.Text:='';
//      BtnOpenDosID.Enabled:=true;

//      PageControlParameters.ActivePage:=TabSheetMainParam;
      PageControlParameters.Enabled:=false;
      TabSheetMainParam.Enabled:=false;
      GroupBoxK.Enabled:=false;

      RadioBtnCreatePart.Enabled:=false;
      LblDosPartName.Enabled:=false;
      EditPartName.Enabled:=false;
      SpeedBtnPartInf.Enabled:=false;
      ShapeErr.Enabled:=false;
      RadioBtnNotCreatePart.Enabled:=false;
      LblDotK1.Enabled:=false;
      LblDotK2.Enabled:=false;
      LblDotK3.Enabled:=false;
      LblDotK4.Enabled:=false;
      LblDotK5.Enabled:=false;
      LblDotKgn.Enabled:=false;
      LblK_1.Enabled:=false;
      LblK_2.Enabled:=false;
      LblK_3.Enabled:=false;
      LblK_4.Enabled:=false;
      LblK_5.Enabled:=false;
      LblK_gn.Enabled:=false;
      EditDosK_1.Enabled:=false;
      EditDosK_2.Enabled:=false;
      EditDosK_3.Enabled:=false;
      EditDosK_4.Enabled:=false;
      EditDosK_5.Enabled:=false;
      EditDosK_gn.Enabled:=false;

      LabelOrg.Enabled:=false;
      LabelDep.Enabled:=false;
      EditDosOrg.Enabled:=false;
      EditDosDep.Enabled:=false;

    end;
  end;

  ChangeDosType;

  result := FEditDosMode;
end;



procedure TDosimeterConstructorForm.RadioBtnFromFileClick(Sender: TObject);
begin
  CheckEditDosMode;
end;

procedure TDosimeterConstructorForm.RadioBtnNotCreatePartClick(Sender: TObject);
begin
  if RadioBtnNotCreatePart.Checked then
  begin
    EditPartName.Enabled:=False;
    EditPartName.Text:='-';
    FCreatePart:=false;
  end;
end;

procedure TDosimeterConstructorForm.RadioBtnCreatePartClick(Sender: TObject);
begin
  if RadioBtnCreatePart.Checked then
  begin
    EditPartName.Enabled:=True;
    EditPartName.Text:=TLDDataModule.GetDefaultPartName;
    FCreatePart:=true;
  end;
end;

procedure TDosimeterConstructorForm.RadioBtnNumberClick(Sender: TObject);
begin
  CheckEditDosMode;
end;

procedure TDosimeterConstructorForm.RadioBtnRangeClick(Sender: TObject);
begin
  CheckEditDosMode;
end;

procedure TDosimeterConstructorForm.SetEditDosMode(aEditDosMode: TEditDosMode);
begin
  FEditDosMode:=aEditDosMode;
  GetEditDosMode;
end;

procedure TDosimeterConstructorForm.SpeedBtnDosInfClick(Sender: TObject);
var
  k: integer;

begin
  k:=ComboBoxDosType.ItemIndex;

  //if ComboBoxDosType.Items[ComboBoxDosType.ItemIndex]<>'' then
  if ComboBoxDosType.ItemIndex>=0 then
    DosimeterTypeConstructorForm.DosTypeName:=ComboBoxDosType.Items[ComboBoxDosType.ItemIndex]
  else
    DosimeterTypeConstructorForm.DosTypeName:=ComboBoxDosType.Items[0];

  DosimeterTypeConstructorForm.ShowModal;
end;

procedure TDosimeterConstructorForm.SpeedBtnPartInfClick(Sender: TObject);
begin
  DosimeterPartForm.Show;
end;

end.
