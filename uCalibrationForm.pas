unit uCalibrationForm;

interface

uses
 
//  Messages,
  SysUtils, Variants, Classes,
// System.UITypes,
  Graphics, Math,
  Controls, Forms, Dialogs, StdCtrls, DBGridsEh, Buttons, ExtCtrls, ComCtrls, DateTimePicker;

type
  TMeasurment = record
    ID      : integer;
    DosName : String;
  end;

  TCalibrationForm = class(TForm)
    PanelK: TPanel;
    LblDosPartName: TLabel;
    LblK_1: TLabel;
    LblK_2: TLabel;
    LblK_3: TLabel;
    LblK_4: TLabel;
    LblK_5: TLabel;
    LblK_gn: TLabel;
    PanelMainTop: TPanel;
    LblPartTopK: TLabel;
    PanelMainBottom: TPanel;
    SpeedBtnSaveChanges: TSpeedButton;
    BtnClose: TButton;
    EditK_1: TEdit;
    EditK_2: TEdit;
    EditK_3: TEdit;
    EditK_4: TEdit;
    EditK_5: TEdit;
    EditK_gn: TEdit;
    SpeedBtnPartInf: TSpeedButton;
    EditPartName: TEdit;
    PanelClientK: TPanel;
    LblCalibrDate: TLabel;
    DateTimePickerCalibr: TDateTimePicker;
    LblDotKgn: TLabel;
    LblDotK5: TLabel;
    LblDotK4: TLabel;
    LblDotK3: TLabel;
    LblDotK2: TLabel;
    LblDotK1: TLabel;
    PanelClientTop: TPanel;
    PanelClient: TPanel;
    GBoxK: TGroupBox;
    LblDosDataDosType: TLabel;
    EditDosDataDosTypeVal: TEdit;
    ShapeErr: TShape;
    RadioBtnCreatePart: TRadioButton;
    RadioBtnNotCreatePart: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure SpeedBtnPartInfClick(Sender: TObject);
    procedure SpeedBtnSaveChangesClick(Sender: TObject);
    procedure EditEnable(Sender: TObject);
    procedure EditDisable(Sender: TObject);
    procedure EditPartNameChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioBtnCreatePartClick(Sender: TObject);
    procedure RadioBtnNotCreatePartClick(Sender: TObject);
  private
    { Private declarations }
    FCreatePart: boolean;

    procedure LoadK;
  public
    { Public declarations }
    function UpdateParameters: boolean;
    function GetDosMeasWithOldK: TStringList;
    procedure LoadParameters;
  end;

var
  CalibrationForm: TCalibrationForm;

implementation

{$R *.dfm}

uses
  uConst,
  uSeparator,
  uFunctions,
  uDataModule,
  uDosimeterPartForm,
  uLog,
  uLanguages,
  uMainForm;

procedure TCalibrationForm.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCalibrationForm.Button1Click(Sender: TObject);
var
  i         : integer;
  strList   : TStringList;
  dosID     : String;
  measID    : String;
begin
  strList:=GetDosMeasWithOldK;

  for i := 0 to strList.Count-1 do
  begin
    dosID:=copy(strList[i],1,pos('[',strList[i])-1);
    measID:=strList[i];
    delete(measID, 1, pos('[', measID));
    delete(measID, pos(']', measID),1);

    MainForm.RecalcCurrentDosimeterDose(dosID,measID);
  end;

  MainForm.UpdateGridMeasAndProcessPages;

  strList.Free;
end;

function TCalibrationForm.GetDosMeasWithOldK: TStringLIst;
var
  i,j        : integer;
  fullDosId  : String;
  strList    : TStringList;
  dosID      : String;
  measID     : String;
begin
  Result := TStringList.Create;

  MainForm.Splash.ProgressBar.Minimum:=0;
  MainForm.Splash.ProgressBar.Maximum:=MainForm.DBGridEhDos.SelectedRows.Count;
  MainForm.Splash.Show(false);
  MainForm.Splash.SetCaption(rsProcessing);

  for i := 0 to MainForm.DBGridEhDos.SelectedRows.Count-1 do
  begin
    MainForm.DBGridEhDos.DataSource.DataSet.GotoBookmark(MainForm.DBGridEhDos.SelectedRows.Items[i]);
    fullDosId:=MainForm.DBGridEhDos.DataSource.DataSet.FieldByName(cFullDosID).AsString;

    strList:=TLDDataModule.GetMeasFromDate(DateTimePickerCalibr.Date);
    if Assigned(strList) then
    begin
      for j := 0 to strList.Count-1 do
      begin
        dosID:=copy(strList[j],1,pos('[',strList[j])-1);
        measID:=strList[j];
        delete(measID, 1, pos('[', measID));
        delete(measID, pos(']', measID),1);

        if (dosID = fullDosId) then
        begin
          Result.Add(strList[j]);
        end;

        MainForm.Splash.ProgressBar.Position:=i;
      end;
    end;
  end;

  MainForm.Splash.Close;
end;

procedure TCalibrationForm.EditDisable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=false;
end;

procedure TCalibrationForm.EditEnable(Sender: TObject);
begin
  TEdit(Sender).Enabled:=true;
end;

procedure TCalibrationForm.EditPartNameChange(Sender: TObject);
begin
  ShapeErr.Visible:=false;
end;

procedure TCalibrationForm.FormShow(Sender: TObject);
begin
  LoadParameters;
end;

procedure TCalibrationForm.LoadK;
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
begin                                       // MainForm.Dosimeter.K2:=1; MainForm.Dosimeter.K3:=1;
  SetEdit(EditK_1, FloatToStrRegion(RoundToCN(MainForm.Dosimeter.K1,-0)),LblDotK1,LblK_1);
  SetEdit(EditK_gn, FloatToStrRegion(RoundToCN(MainForm.Dosimeter.Kgn,-2)),LblDotKgn,LblK_gn);
  SetEdit(EditK_2, FloatToStrRegion(RoundToCN(MainForm.Dosimeter.K2,-0)),LblDotK2,LblK_2);
  SetEdit(EditK_3, FloatToStrRegion(RoundToCN(MainForm.Dosimeter.K3,-0)),LblDotK3,LblK_3);
  SetEdit(EditK_4, FloatToStrRegion(RoundToCN(MainForm.Dosimeter.K4,-0)),LblDotK4,LblK_4);
  SetEdit(EditK_5, FloatToStrRegion(RoundToCN(MainForm.Dosimeter.K5,-0)),LblDotK5,LblK_5);
end;

procedure TCalibrationForm.RadioBtnCreatePartClick(Sender: TObject);
begin
  if RadioBtnCreatePart.Checked then
  begin
    EditPartName.Enabled:=True;
    EditPartName.Text:=TLDDataModule.GetDefaultPartName;
    FCreatePart:=true;
  end;
end;

procedure TCalibrationForm.RadioBtnNotCreatePartClick(Sender: TObject);
begin
  if RadioBtnNotCreatePart.Checked then
  begin
    EditPartName.Enabled:=False;
    EditPartName.Text:='-';
    FCreatePart:=false;
  end;
end;

procedure TCalibrationForm.SpeedBtnPartInfClick(Sender: TObject);
begin
  DosimeterPartForm.Show;
end;

procedure TCalibrationForm.SpeedBtnSaveChangesClick(Sender: TObject);
var
  fullNumber: String;
  i         : integer;
  strList   : TStringList;
  dosID     : String;
  measID    : String;
  temp      : word;
begin
  fullNumber:=MainForm.Dosimeter.FullNumber;

  if UpdateParameters then
  begin
    strList:=GetDosMeasWithOldK;

    if strList.Count>0 then
    begin

      temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('%s (%d%s). %s?',[rsFoundLateMeasures,strList.Count,rsNums,rsReCalcWNewCoeff]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');
      case temp of
        mrYes:
        begin
          MainForm.Splash.ProgressBar.Minimum:=0;
          MainForm.Splash.ProgressBar.Maximum:=strList.Count;
          MainForm.Splash.Show(false);
          MainForm.Splash.SetCaption(rsRecalculation);

          for i := 0 to strList.Count-1 do
          begin
            dosID:=copy(strList[i],1,pos('[',strList[i])-1);
            measID:=strList[i];
            delete(measID, 1, pos('[', measID));
            delete(measID, pos(']', measID),1);

            MainForm.RecalcCurrentDosimeterDose(dosID,measID);
            MainForm.Splash.ProgressBar.Position:=i;
          end;

          MainForm.Splash.Close;
          MainForm.UpdateGridMeasAndProcessPages;
        end;
      end;

    end;

    strList.Free;

    MainForm.LoadFilters;
    MainForm.UpdateAllGridPages;

    MainForm.DBGridEhDos.SelectedRows.Clear;
    MainForm.DBGridEhDos.DataSource.DataSet.Locate(cFullDosID,fullNumber,[]);
    MainForm.DBGridEhDos.SelectedRows.CurrentRowSelected:=true;

    MainForm.GetDosData;
    Close;
  end;
end;

function TCalibrationForm.UpdateParameters: boolean;
var
  i                   : integer;
  fullDosId           : String;
  partName            : String;
  dosType             : String;
  dosCnt              : integer;
  calibrDate          : TDateTime;
  k1,k2,k3,k4,k5,kgn  : double;
  flag                : boolean;
  partID              : integer;
  temp                : word;
  d_cnt               : integer;
  d_name              : String;
begin
  partName:=EditPartName.Text;
  dosType:=EditDosDataDosTypeVal.Text;
  dosCnt:=MainForm.DBGridEhDos.SelectedRows.Count;
  calibrDate:=DateTimePickerCalibr.Date;
  flag:=false;

  k1:=StrToFloatRegionNAN(EditK_1.Text);
  k2:=StrToFloatRegionNAN(EditK_2.Text);
  k3:=StrToFloatRegionNAN(EditK_3.Text);
  k4:=StrToFloatRegionNAN(EditK_4.Text);
  k5:=StrToFloatRegionNAN(EditK_5.Text);
  kgn:=StrToFloatRegionNAN(EditK_gn.Text);

  if MainForm.DBGridEhDos.SelectedRows.Count > 0 then
  begin
    if TLDDataModule.IsDBConnected then
    begin
      if FCreatePart then
      begin
        if (Trim(partName)<>'') AND (Trim(partName)<>'-') then
        begin
          if ShapeErr.Visible then ShapeErr.Visible:=false;

          if not TLDDataModule.IsDosimeterPartExist(partName,MainForm.DeviceID) then
          begin
            if ShapeErr.Visible then ShapeErr.Visible:=false;

            try
              if TLDDataModule.AddNewDosPart(partName,k1,k2,k3,k4,k5,kgn,dosCnt,dosType,calibrDate) then
              begin
                flag:=true;
                WriteLog(Format(rsNewPartyAdded,[partName]));
              end
              else
              begin
                flag:=false;
                WriteLog(Format(rsErrNewPartyAdded,[partName]));
              end;
            except
              on E: Exception do
              begin
                flag:=false;
                WriteLog(Format(rsErrNewPartyAdded,[partName])+'. '+E.Message);
              end;
            end;

            partID:=TLDDataModule.GetPartID(partName,MainForm.DeviceID);

          end
          else
          begin
            ShapeErr.Visible:=true;

            d_name:=TLDDataModule.GetDosTypeInPart(TLDDataModule.GetPartID(partName,MainForm.DeviceID));
            d_cnt:=TLDDataModule.GetDosCntInPart(TLDDataModule.GetPartID(partName,MainForm.DeviceID));

            temp:=QuestionDlg(Format('%s!',[rsMsgWarning]), Format('"%s" (%d "%s") - %s. %s?',[partName,d_cnt,d_name,rsPartyExists,rsPartyReform]),mtWarning,[mrYes,rsYes,mrNo,rsNo],'');
            case temp of
              mrYes:
              begin
                try
                  if ShapeErr.Visible then ShapeErr.Visible:=false;

                  TLDDataModule.DeleteDosimeterPart(partName,MainForm.DeviceID);

                  if TLDDataModule.AddNewDosPart(partName,k1,k2,k3,k4,k5,kgn,dosCnt,dosType,calibrDate) then
                  begin
                    flag:=true;

                    d_name:=TLDDataModule.GetDosTypeInPart(TLDDataModule.GetPartID(partName,MainForm.DeviceID));
                    d_cnt:=TLDDataModule.GetDosCntInPart(TLDDataModule.GetPartID(partName,MainForm.DeviceID));

                    MessageDlg(Format('%s "%s" (%d "%s")',[rsNewPartyAdded2,partName,d_cnt,d_name]),mtInformation,[mbOK],0);

                    WriteLog(Format(rsNewPartyAdded,[partName]));
                  end
                  else
                  begin
                    flag:=false;
                    WriteLog(Format(rsErrNewPartyAdded,[partName]));
                  end;
                except
                  on E: Exception do
                  begin
                    WriteLog(Format(rsErrNewPartyAdded,[partName]) + '. '+E.Message);
                  end;
                end;

                partID:=TLDDataModule.GetPartID(partName,MainForm.DeviceID);

              end;
              mrNo:
              begin
                flag:=false;
                partID:=0;
              end
              else
              begin
                flag:=false;
                partID:=0;
              end;
            end;
          end;
        end
        else if (Trim(partName)='-') then
        begin
          partID:=0;
          flag:=true;
        end
        else
        begin
          ShapeErr.Visible:=true;
          MessageDlg(Format('%s',[rsNeedPartyName]),mtError,[mbOK],0);
          partID:=0;
        end;
      end
      else
      begin
        partID:=0;
        flag:=true;
      end;

      if flag then
      begin
        for i := 0 to MainForm.DBGridEhDos.SelectedRows.Count-1 do
        begin
          MainForm.DBGridEhDos.DataSource.DataSet.GotoBookmark(MainForm.DBGridEhDos.SelectedRows.Items[i]);
          fullDosId:=MainForm.DBGridEhDos.DataSource.DataSet.FieldByName(cFullDosID).AsString;

          try
            TLDDataModule.ExcludeDosimeterFromPart(fullDosId);

            if TLDDataModule.UpdatePartInDos(fullDosId,k1,k2,k3,k4,k5,kgn,partID,calibrDate) then
            begin
              flag:=true;
              WriteLog(Format('%s - "%s %s" k1=%s, k2=%s, k3=%s, k4=%s, k5=%s, kgn=%s',[rsCoeffsChanged,fullDosId,dosType,
                                                                                                                          FloatToStrRegion(k1),
                                                                                                                          FloatToStrRegion(k2),
                                                                                                                          FloatToStrRegion(k3),
                                                                                                                          FloatToStrRegion(k4),
                                                                                                                          FloatToStrRegion(k5),
                                                                                                                          FloatToStrRegion(kgn)
                                                                                                                          ]));
            end
            else
            begin
              flag:=false;
              WriteLog(Format('%s - "%s %s',[rsErrCoeffChanged,fullDosId,dosType]));
            end;
          except
            on E: exception do
            begin
              flag:=false;
              WriteLog(Format('%s - "%s %s',[rsErrCoeffChanged,fullDosId,dosType]));
            end;
          end;
        end;
      end;
    end;
  end;

  Result:=flag;

end;

procedure TCalibrationForm.LoadParameters;
var
  dosType   : String;
  procedure SetLblCaptionUnicode(Lbl: TLabel; Value: String);
  begin
    Lbl.Caption:=Value;
  end;
begin
  DateTimePickerCalibr.Date:=Date;

  if ShapeErr.Visible then ShapeErr.Visible:=false;

  SetLblCaptionUnicode(LblDotK1,Format('%s',[cuUnicodeSymbol_Dot]));
  SetLblCaptionUnicode(LblDotK2,Format('%s',[cuUnicodeSymbol_Dot]));
  SetLblCaptionUnicode(LblDotK3,Format('%s',[cuUnicodeSymbol_Dot]));
  SetLblCaptionUnicode(LblDotK4,Format('%s',[cuUnicodeSymbol_Dot]));
  SetLblCaptionUnicode(LblDotK5,Format('%s',[cuUnicodeSymbol_Dot]));
  SetLblCaptionUnicode(LblDotKgn,Format('%s',[cuUnicodeSymbol_Dot]));

  dosType:=MainForm.DBGridEhDos.DataSource.DataSet.FieldByName(cFieldDosType).AsString;
  LoadK;
  EditDosDataDosTypeVal.Text:=dosType;

  if MainForm.DBGridEhDos.SelectedRows.Count>=MainForm.DosCntAutoCreatePart then
  begin
    RadioBtnCreatePart.Checked:=true;
    RadioBtnCreatePartClick(self);
  end
  else
  begin
    RadioBtnNotCreatePart.Checked:=true;
    RadioBtnNotCreatePartClick(self);
  end;

end;

end.
