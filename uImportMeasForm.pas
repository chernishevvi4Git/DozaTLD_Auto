unit uImportMeasForm;

interface

uses
  Messages, FileCtrl,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, Grids, StdCtrls, ComCtrls, ATGauge;
//System.UITypes, Vcl.Samples.Gauges
type
  TImportMeasForm = class(TForm)
    PanelStringGrid: TPanel;
    PanelBottom: TPanel;
    BtnImport: TButton;
    BtnCancel: TButton;
    StringGridMeas: TStringGrid;
    LblImport: TLabel;
    GaugeMeasImp: TATGauge;
    procedure BtnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
  private
    procedure LoadFiles;
    procedure ImportMeas;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cTxt          = '.txt';
  cImportFolder = 'Emulator'+PathDelim+'LoadMeas'+PathDelim;
  cSeparator    = ' ';

var
  ImportMeasForm: TImportMeasForm;

implementation
uses
  uSeparator,
  uDetector,
  uDosimeter,
  uMainForm;
{$R *.dfm}

procedure TImportMeasForm.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TImportMeasForm.BtnImportClick(Sender: TObject);
begin
  ImportMeas;
  Close;
end;

procedure TImportMeasForm.FormShow(Sender: TObject);
begin
  LoadFiles;
  GaugeMeasImp.Progress:=0;
  GaugeMeasImp.Visible:=false;
end;

procedure TImportMeasForm.ImportMeas;
var
  i,j         : integer;
  dosName     : String;
  dosID       : String;
  dosIDPrev   : String;
  FileName    : String;
  f           : TextFile;
  s,s2        : String;
  ktv         : double;
  tmp         : double;
begin
  dosName:='';
  dosIDPrev:='';

  GaugeMeasImp.MinValue:=0;
  GaugeMeasImp.MaxValue:=StringGridMeas.RowCount-1;
  GaugeMeasImp.Visible:=true;

  for i := 1 to StringGridMeas.RowCount-1 do
  begin
    dosName:=StringGridMeas.Cells[0,i];
    dosID:=StringGridMeas.Cells[2,i];

    if dosID<>dosIDPrev then
    begin

      if Assigned(MainForm.Dosimeter) then FreeAndNil(MainForm.Dosimeter);

      MainForm.Dosimeter:=TDosimeter.Create(dosName);

      MainForm.Dosimeter.LastMeasComment:='ImportID_'+dosID;
      MainForm.Dosimeter.MeasComment:='ImportID_'+dosID;
      MainForm.Dosimeter.MeasTime:=Now;

      if (MainForm.Dosimeter.MeasurementID = 0) then
      try
        MainForm.CreateDosimeterData;
      except
        on E: exception do
          MessageDlg(E.Message,mtError, [mbOK], 0);
      end;

      for j := 0 to MainForm.Dosimeter.DetectorsList.Count-1 do
      begin
        if MainForm.Dosimeter.DetectorsList[j]<>nil then
        begin
          FileName:=extractfilepath(Application.ExeName)+cImportFolder+dosName+cSeparator+'Detector'+IntToStr(j+1)+cSeparator+dosID+cTxt;

          if FileExists(FileName) then
          begin
            AssignFile(f, FileName);
            Reset(f);

            MainForm.Dosimeter.DetectorsCnt:=j;

            while not eof(f) do
            begin
              readln(f,s);
              // канал
              s2:=copy(s,1,pos(' ', s)-1);
              delete(s, 1, pos(' ', s));
              // ктв
              s2:=copy(s,1,pos(' ', s)-1);

              ktv:=Round(StrToFloatRegion(s2));
              delete(s, 1, pos(' ', s));
              // температура
              tmp:=Round(StrToFloatRegion(s));

              if TDetector(MainForm.Dosimeter.DetectorsList[j]).tmp = '' then
                TDetector(MainForm.Dosimeter.DetectorsList[j]).tmp:=FloatToStrRegion(tmp)
              else
                TDetector(MainForm.Dosimeter.DetectorsList[j]).tmp:=TDetector(MainForm.Dosimeter.DetectorsList[j]).tmp+','+FloatToStrRegion(tmp);

              if TDetector(MainForm.Dosimeter.DetectorsList[j]).ktv = '' then
                TDetector(MainForm.Dosimeter.DetectorsList[j]).ktv:=FloatToStrRegion(ktv)
              else
                TDetector(MainForm.Dosimeter.DetectorsList[j]).ktv:=TDetector(MainForm.Dosimeter.DetectorsList[j]).ktv+','+FloatToStrRegion(ktv);

            end;

            CloseFile(f);

            MainForm.InsertDetectorKtvTmp(j+1);
            MainForm.SaveDosimeterData;
          end;
        end;
      end;

      dosIDPrev:=dosID;
      GaugeMeasImp.Progress:=i;
    end;
  end;

end;

procedure TImportMeasForm.LoadFiles;
var
  path  : String;
  sr    : TSearchRec;
  i,j   : integer;
  s1,s2 : String;
//  str   : String;
begin
  i:=1;

  StringGridMeas.Cells[0, 0]:='Номер';
  StringGridMeas.Cells[1, 0]:='Детектор';
  StringGridMeas.Cells[2, 0]:='ID измерения';

  path:=extractfilepath(Application.ExeName)+cImportFolder;
//  FileListBoxMeas.Directory:=path;

  if FindFirst(path+'*'+cTxt,faAnyFile,SR) = 0 then
  repeat
    s1:=sr.Name;
    i:=i+1;
    j:=0;

    while pos(cSeparator,s1)<>0 do
    begin
      s2:=copy(s1,1,pos(cSeparator,s1)-1);
      j:=j+1;
      delete(s1, 1, pos(cSeparator, s1));
      StringGridMeas.Cells[j-1, i-1]:=s2;
    end;

    if pos (cSeparator, s1)=0 then
    begin
      j := j + 1;
      delete(s1, pos(cTxt, s1), pos(cTxt, s1));
      StringGridMeas.Cells[j-1, i-1] := s1;
    end;

    StringGridMeas.ColCount := j;
    StringGridMeas.RowCount := i;

  until FindNext(sr)<>0;

  FindClose(sr);
end;

end.
