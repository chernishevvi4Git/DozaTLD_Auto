unit uDosimeterPartForm;

interface

uses
 
//  Messages,
  SysUtils, Variants, Classes, Graphics,System.UITypes, Math,
  Controls, Forms, Dialogs, ExtCtrls, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls,
//  DynVarsEh,
  GridsEh, DBAxisGridsEh, DBGridsEh, StdCtrls,
  MemTableDataEh, DB, SQLDB, MemTableEh, DataDriverEh, Buttons, ComCtrls,
  uDataModule, DateTimePicker;
// Data.Win.ADODB, EhLibVCL,

type

  { TDosimeterPartForm }

  TDosimeterPartForm = class(TForm)
    PanelGrid: TPanel;
    PanelTopGrid: TPanel;
    PanelBottomGrid: TPanel;
    DBGridEhDosPart: TDBGridEh;
    LblPartGrid: TLabel;
    PanelK: TPanel;
    PanelTopK: TPanel;
    LblPartTopK: TLabel;
    PanelBottomK: TPanel;
    ADOQueryDosPart: TSQLQuery;
    DataSetDriverEhDosPart: TDataSetDriverEh;
    MemTableEhDosPart: TMemTableEh;
    DataSourceDosPart: TDataSource;
    EditK_1: TEdit;
    EditK_2: TEdit;
    EditK_3: TEdit;
    EditK_4: TEdit;
    EditK_5: TEdit;
    EditK_gn: TEdit;
    LblDosPartName: TLabel;
    EditDosPartName: TEdit;
    LblK_1: TLabel;
    LblK_2: TLabel;
    LblK_3: TLabel;
    LblK_4: TLabel;
    LblK_5: TLabel;
    LblK_gn: TLabel;
    SpeedBtnDelDosPart: TSpeedButton;
    SpeedBtnSaveChanges: TSpeedButton;
    BtnClose: TButton;
    LblDotKgn: TLabel;
    LblDotK5: TLabel;
    LblDotK4: TLabel;
    LblDotK3: TLabel;
    LblDotK2: TLabel;
    LblDotK1: TLabel;
    EditPartDosType: TEdit;
    LblPartDosType: TLabel;
    DateTimePickerPartCalibr: TDateTimePicker;
    LblPartCalibrDate: TLabel;
    LblPartComment: TLabel;
    MemoPartComment: TMemo;
    LblPartDosCnt: TLabel;
    EditPartDosCnt: TEdit;
    CheckBoxShowAllDev: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure EditEnable(Sender: TObject);
    procedure EditDisable(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure SpeedBtnAddDosPartClick(Sender: TObject);
    procedure SpeedBtnSaveChangesClick(Sender: TObject);
    procedure DBGridEhDosPartCellClick(Column: TColumnEh);
    procedure SpeedBtnDelDosPartClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBoxShowAllDevClick(Sender: TObject);
  private
    procedure UpdateDosPart;
    function DeleteDosPart(DosPartName: String; DeviceID: integer): boolean;
    { Private declarations }
  public
    DosPartName : String;
    DosPartID   : integer;
    DeviceID    : integer;

    function GetDosMeasWithOldKInPart: TStringList;

    procedure RefreshDosPartList;
    procedure LoadPartParameters;
    { Public declarations }
  end;

var
  DosimeterPartForm: TDosimeterPartForm;

implementation

uses
  uConst,
  uSeparator,
  uLanguages,
  uMainForm,
  uEnterNewDosPartForm,
  uFunctions;

{$R *.dfm}

procedure TDosimeterPartForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TDosimeterPartForm.Button1Click(Sender: TObject);
begin
  GetDosMeasWithOldKInPart;
end;

procedure TDosimeterPartForm.CheckBoxShowAllDevClick(Sender: TObject);
begin
  RefreshDosPartList;
  LoadPartParameters;
end;

procedure TDosimeterPartForm.DBGridEhDosPartCellClick(Column: TColumnEh);
begin
  LoadPartParameters;
end;

function TDosimeterPartForm.DeleteDosPart(DosPartName: String; DeviceID: integer): boolean;
var
  strList : TStringList;
  temp    : word;
  procedure DeletePart;
  var
    i: integer;
  begin
    for i := 0 to strList.Count-1 do
      TLDDataModule.ExcludeDosimeterFromPart(strList[i]);

    if TLDDataModule.DeleteDosimeterPart(DosPartName,DeviceID) then
    begin
      DosPartName:='';
      DosPartID:=0;
      RefreshDosPartList;
      LoadPartParameters;
    end
    else
      MessageDlg(Format('%s "%s". %s - %s',[rsErrDeleteParty,DosPartName,rsDetailInfoAtFile,Application.ExeName+PathDelim+cLogFileName]),mtError,[mbOK],0);
  end;
begin
  Result:=false;
  strList:=TStringList.Create;
  strList:=TLDDataModule.GetDosListInPart(TLDDataModule.GetPartID(DosPartName,DeviceID));

  if not TLDDataModule.IsDosimeterPartUsed(IntToStr(TLDDataModule.GetPartID(DosPartName,DeviceID))) then
  begin
    DeletePart;
    Result:=true;
  end
  else
  begin
    temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format(rsDeletePartDosimetersExist,[DosPartName,IntToStr(strList.Count)]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');
    case temp of
      mrYes:
      begin
        DeletePart;
        Result:=true;
      end;
      mrNo:
        Result:=false;
    end;

  end;

  strList.Free;

end;

procedure TDosimeterPartForm.EditDisable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=false;
end;

procedure TDosimeterPartForm.EditEnable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=true;
end;

procedure TDosimeterPartForm.FormShow(Sender: TObject);
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

  RefreshDosPartList;
  LoadPartParameters;
end;

procedure TDosimeterPartForm.LoadPartParameters;
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
      Edit.Text:=Value;
    end;
  end;
  function CheckNan(Field: String): String;
  begin
    if ADOQueryDosPart.FieldByName(Field).AsVariant <> Null then
      Result:=FloatToStrRegion(RoundToCN(ADOQueryDosPart.FieldByName(Field).AsFloat,-1))
    else
      Result:=cNull;
  end;
begin
  DosPartName:=DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldDosPartName).AsString;
  DosPartID:=DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldPartID).AsInteger;
  DeviceID:=DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldTldID).AsInteger;

  ADOQueryDosPart.Active:=False;
  ADOQueryDosPart.SQL.Clear;
  ADOQueryDosPart.SQL.Add('SELECT '+cK1+','
                                   +cK2+','
                                   +cK3+','
                                   +cK4+','
                                   +cK5+','
                                   +cKgn+','
                                   +cFieldDosType+','
                                   +cFieldDosPartCnt+','
                                   +cFieldDosPartComment+','
                                   +cFieldVerTime+' '
                                   +'FROM '+cDBTableDosPart+' WHERE '+cFieldPartID+'='+IntToStr(DosPartID));
  ADOQueryDosPart.Active:=True;

  EditDosPartName.Text:=DosPartName;

  SetEdit(EditK_1,CheckNan(cK1),LblDotK1,LblK_1);
  SetEdit(EditK_gn,CheckNan(cKgn),LblDotKgn,LblK_gn);
  SetEdit(EditK_2,CheckNan(cK2),LblDotK2,LblK_2);
  SetEdit(EditK_3,CheckNan(cK3),LblDotK3,LblK_3);
  SetEdit(EditK_4,CheckNan(cK4),LblDotK4,LblK_4);
  SetEdit(EditK_5,CheckNan(cK5),LblDotK5,LblK_5);

  EditPartDosType.Text:=ADOQueryDosPart.FieldByName(cFieldDosType).AsString;
  EditPartDosCnt.Text:=IntToStr(ADOQueryDosPart.FieldByName(cFieldDosPartCnt).AsInteger);
  DateTimePickerPartCalibr.Date:=ADOQueryDosPart.FieldByName(cFieldVerTime).AsDateTime;
  MemoPartComment.Text:=ADOQueryDosPart.FieldByName(cFieldDosPartComment).AsString;

  ADOQueryDosPart.Active:=False;
end;

procedure TDosimeterPartForm.RefreshDosPartList;
const
  cAddFieldSize = 7;
var
  i                  : integer;
  indicatorColWidth  : integer;
  columnsWidth       : integer;
  columnName         : String;
begin
  columnsWidth:=0;

  if TLDDataModule.IsDBConnected then
  begin
    ADOQueryDosPart.SQL.Clear;

    if CheckBoxShowAllDev.Checked then
      ADOQueryDosPart.SQL.Add('SELECT '+cFieldPartID+','+cFieldDosPartName+','+cFieldTldID+' FROM '+cDBTableDosPart+' WHERE '+'('+cFieldPartID+'> 0'+')'+' ORDER BY '+cFieldPartID)
    else
      ADOQueryDosPart.SQL.Add('SELECT '+cFieldPartID+','+cFieldDosPartName+','+cFieldTldID+' FROM '+cDBTableDosPart+' WHERE '+'('+cFieldPartID+'> 0'+')'+'AND '+'('+cFieldTldID+' = '+IntToStr(MainForm.DeviceID)+')'+' ORDER BY '+cFieldPartID);

    ADOQueryDosPart.Active:=true;

    ADOQueryDosPart.Open;

    if MemTableEhDosPart.Active then MemTableEhDosPart.Active:=false;

    MemTableEhDosPart.Active:=true;

    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldPartID).Index].Visible:=false;
    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Visible:=true;
    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldTldID).Index].Visible:=true;

    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldPartID).Index].Alignment:=taLeftJustify;
    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldPartID).Index].Title.Caption:=Format(' %s',['ID']);
    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Title.Caption:=Format(' %s',[rsPartyName]);
    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldTldID).Index].Title.Caption:=Format(' %s',[rsSmTldID]);

    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldPartID).Index].Width:=cColumnWidth_2;
    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Width:=cColumnWidth_5;
    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldTldID).Index].Width:=cColumnWidth_2;

    //DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldPartID).Index].Footer.ValueType := fvtStaticText;
    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Footer.ValueType := fvtStaticText;
    //DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldPartID).Index].Footer.Value:=Format('%s',[rsParties]);
    DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(cFieldDosPartName).Index].Footer.Value:=Format('%s - %d',[rsParties,ADOQueryDosPart.RecordCount]);

    DBGridEhDosPart.DataSource.DataSet.Locate(cFieldDosPartName,DosPartName,[]);

    for i := 0 to DBGridEhDosPart.Columns.Count-1 do
    begin
      if (DBGridEhDosPart.Columns[i].Visible) then
      begin
        columnsWidth:=columnsWidth+DBGridEhDosPart.Columns[i].Width;
        columnName:=DBGridEhDosPart.Columns[i].FieldName;
      end;
    end;

    indicatorColWidth:=DBGridEhDosPart.CalcIndicatorColWidth+cAddFieldSize+DBGridEhDosPart.VertScrollBar.Width;
    columnsWidth:=columnsWidth-DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(columnName).Index].Width+indicatorColWidth;

    if (DBGridEhDosPart.Width-columnsWidth)>cColumnWidth_1 then
      DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(columnName).Index].Width:=DBGridEhDosPart.Width-columnsWidth
    else
      DBGridEhDosPart.Columns[DBGridEhDosPart.DataSource.DataSet.FieldByName(columnName).Index].Width:=cColumnWidth_3;

    ADOQueryDosPart.Close;

  end;
end;

procedure TDosimeterPartForm.SpeedBtnAddDosPartClick(Sender: TObject);
begin
//  EnterNewDosPartForm.ShowModal;
end;

procedure TDosimeterPartForm.SpeedBtnDelDosPartClick(Sender: TObject);
var
  temp        : word;
  fullNumber  : String;
begin
  temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format(rsDeleteParty,[DosPartName]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');

  case temp of
    mrYes:                   // если нажали продолжить
    begin
      if Assigned(MainForm.Dosimeter) then
      begin
        fullNumber:=MainForm.Dosimeter.FullNumber;

        if DeleteDosPart(DosPartName,DeviceID) then
        begin
          MainForm.LoadFilters;
          MainForm.UpdateAllGridPages;
          MainForm.DBGridEhDos.SelectedRows.Clear;
          MainForm.DBGridEhDos.DataSource.DataSet.Locate(cFullDosID,fullNumber,[]);
          MainForm.DBGridEhDos.SelectedRows.CurrentRowSelected:=true;
          MainForm.GetDosData;
        end;
      end;
    end;
  end;
end;

procedure TDosimeterPartForm.SpeedBtnSaveChangesClick(Sender: TObject);
var
  index     : integer;
  strList   : TStringList;
  temp      : word;
  i         : integer;
  dosID     : String;
  measID    : String;
begin
  index:=MainForm.DBGridEhDos.DataSource.DataSet.RecNo;

  UpdateDosPart;

  strList:=GetDosMeasWithOldKInPart;

  if strList.Count>0 then
  begin

    temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s (%d%s). %s?',[rsFoundMeasuresAfterCalibration,strList.Count,rsNums,rsRecalcMeasuresAfterCalibration]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');
    case temp of
      mrYes:
      begin
        for i := 0 to strList.Count-1 do
        begin
          dosID:=copy(strList[i],1,pos('[',strList[i])-1);
          measID:=strList[i];
          delete(measID, 1, pos('[', measID));
          delete(measID, pos(']', measID),1);

          MainForm.RecalcCurrentDosimeterDose(dosID,measID);
        end;

        MainForm.UpdateGridMeasAndProcessPages;
      end;
    end;

  end;

  strList.Free;

  MainForm.UpdateAllGridPages;
  MainForm.DBGridEhDos.DataSource.DataSet.RecNo:=index;
  MainForm.GetDosData;
end;

function TDosimeterPartForm.GetDosMeasWithOldKInPart: TStringList;
var
  i,j                 : integer;
  strListDosInPart    : TStringList;
  strListMeasFromDate : TStringList;
  dosID               : String;
  measID              : String;
begin
  Result := TStringList.Create;

  strListMeasFromDate:=TLDDataModule.GetMeasFromDate(DateTimePickerPartCalibr.Date);
  strListDosInPart:=TLDDataModule.GetDosListInPart(DosPartID);

  if Assigned(strListDosInPart) then
  begin
    for i := 0 to strListDosInPart.Count-1 do
    begin

      if Assigned(strListMeasFromDate) then
      begin
        for j := 0 to strListMeasFromDate.Count-1 do
        begin
          dosID:=copy(strListMeasFromDate[j],1,pos('[',strListMeasFromDate[j])-1);
          measID:=strListMeasFromDate[j];
          delete(measID, 1, pos('[', measID));
          delete(measID, pos(']', measID),1);

          if (strListDosInPart[i] = dosID) then
          begin
            Result.Add(strListMeasFromDate[j]);
          end;
        end;
      end;
    end;
  end;

  strListMeasFromDate.Free;
  strListDosInPart.Free;

end;

procedure TDosimeterPartForm.UpdateDosPart;
var
  k1,k2,k3,k4,k5,kgn  : double;
  partID              : integer;
begin
  if TLDDataModule.IsDBConnected then
  begin
    if (DosPartName = EditDosPartName.Text) then
    begin
      k1:=StrToFloatRegionNAN(EditK_1.Text);
      k2:=StrToFloatRegionNAN(EditK_2.Text);
      k3:=StrToFloatRegionNAN(EditK_3.Text);
      k4:=StrToFloatRegionNAN(EditK_4.Text);
      k5:=StrToFloatRegionNAN(EditK_5.Text);
      kgn:=StrToFloatRegionNAN(EditK_gn.Text);

      ADOQueryDosPart.Active:=False;
      ADOQueryDosPart.SQL.Clear;
      ADOQueryDosPart.SQL.Add('UPDATE '+cDBTableDosPart+' SET '+cField_k1+              '='   +FloatToStrRegion(k1)+','
                                                               +cField_k2+              '='   +FloatToStrRegion(k2)+','
                                                               +cField_k3+              '='   +FloatToStrRegion(k3)+','
                                                               +cField_k4+              '='   +FloatToStrRegion(k4)+','
                                                               +cField_k5+              '='   +FloatToStrRegion(k5)+','
                                                               +cField_kgn+             '='   +FloatToStrRegion(kgn)+','
                                                               +cFieldDosPartComment+   '='   +#39+MemoPartComment.Text+#39+','
                                                               +cFieldVerTime+          '='   +#39+DateToStr(DateTimePickerPartCalibr.Date)+#39+''
                                                     +' WHERE '+cFieldDosPartName+      '='   +#39+DosPartName+#39
                                                     +' AND '
                                                     +cFieldTldID+' = '+IntToStr(MainForm.DeviceID));
      ADOQueryDosPart.ExecSQL;

      RefreshDosPartList;

      partID:=TLDDataModule.GetPartID(DosPartName,MainForm.DeviceID);

      DBGridEhDosPart.DataSource.DataSet.Locate(cFieldPartID,partID,[]);

      LoadPartParameters;

      TLDDataModule.UpdateKInDosIDByPart(k1,k2,k3,k4,k5,kgn,DosPartID,DateTimePickerPartCalibr.Date,cDosCalibrated);
    end;
  end;
end;

end.
