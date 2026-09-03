unit uImportDosimeters;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Math,
// System.UITypes,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
//  DynVarsEh,
  MemTableDataEh, DB, DataSetImpExpEh, MemTableEh,
  Dialogs, GridsEh, DBAxisGridsEh, DBGridsEh, StdCtrls, Controls, Grids, ComCtrls, ExtCtrls, Graphics,
  Forms, PivotGridsEh, Menus, LR_E_TXT, LR_DBSet,
  uDosimeterConstructorForm;
// EhLibVCL,

type
  TLogState = (lgSuccess,lgInformation,lgWarning,lgError);

  { TImportDosimetersW }

  TImportDosimetersW = class(TForm)
    MemTableEhDetTypek1profile: TStringField;
    MemTableEhDetTypek2profile: TStringField;
    MemTableEhDevSettingskdev: TStringField;
    MemTableEhMeasDetk1profile: TStringField;
    MemTableEhMeasDetk2profile: TStringField;
    OpenDialogList: TOpenDialog;
    BtnClose: TButton;
    PanelGrid: TPanel;
    DataSourceDosID: TDataSource;
    MemTableEhDosID: TMemTableEh;
    MemTableEhDosIDdosimeterid: TStringField;
    MemTableEhDosIDpostfix: TStringField;
    MemTableEhDosIDdosimetertype: TStringField;
    MemTableEhDosIDk1: TStringField;
    MemTableEhDosIDk2: TStringField;
    MemTableEhDosIDk3: TStringField;
    MemTableEhDosIDk4: TStringField;
    MemTableEhDosIDk5: TStringField;
    MemTableEhDosIDkgn: TStringField;
    MemTableEhDosIDpartname: TStringField;
    MemTableEhDosIDorganization: TStringField;
    MemTableEhDosIDdepartment: TStringField;
    DataSetTextImporterEhDosID: TDataSetTextImporterEh;
    DBGridEhDosID: TDBGridEh;
    PanelOpenDosID: TPanel;
    EditLoadListDosID: TEdit;
    BtnOpenDosID: TButton;
    BtnImport: TButton;
    PanelBottom: TPanel;
    PageControlFiles: TPageControl;
    TabSheetDosList: TTabSheet;
    TabSheetDosTypeList: TTabSheet;
    TabSheetDetTypeList: TTabSheet;
    DBGridEhDosType: TDBGridEh;
    PanelOpenDosType: TPanel;
    DBGridEhDetType: TDBGridEh;
    PanelOpenDetType: TPanel;
    DataSourceDosType: TDataSource;
    MemTableEhDosType: TMemTableEh;
    DataSetTextImporterEhDosType: TDataSetTextImporterEh;
    MemTableEhDetType: TMemTableEh;
    DataSetTextImporterEhDetType: TDataSetTextImporterEh;
    DataSourceDetType: TDataSource;
    MemTableEhDetTypekname: TStringField;
    MemTableEhDetTypemeasval: TStringField;
    MemTableEhDetTypemethod: TStringField;
    MemTableEhDetTypedettypecomment: TStringField;
    MemTableEhDetTypetempprofile: TStringField;
    MemTableEhDetTypedetectortype: TStringField;
    MemTableEhDosTypeformula_err_k2_4: TStringField;
    MemTableEhDosTypeformula_err_k1_4: TStringField;
    MemTableEhDosTypeformula_err_k2_3: TStringField;
    MemTableEhDosTypeformula_err_k1_3: TStringField;
    MemTableEhDosTypeformula_err_k2_2: TStringField;
    MemTableEhDosTypeformula_err_k1_2: TStringField;
    MemTableEhDosTypeformula_err_k2_1: TStringField;
    MemTableEhDosTypeformula_err_k1_1: TStringField;
    MemTableEhDosTypeformula_id_val_4: TStringField;
    MemTableEhDosTypeformula_id_val_3: TStringField;
    MemTableEhDosTypeformula_id_val_2: TStringField;
    MemTableEhDosTypeformula_id_val_1: TStringField;
    MemTableEhDosTypeformula_id_dos: TStringField;
    MemTableEhDosTypeerror: TStringField;
    MemTableEhDosTypeformula: TStringField;
    MemTableEhDosTypedtype4: TStringField;
    MemTableEhDosTypedtype3: TStringField;
    MemTableEhDosTypedtype2: TStringField;
    MemTableEhDosTypedtype1: TStringField;
    MemTableEhDosTypemeasuredvalue: TStringField;
    MemTableEhDosTypedosimetertype: TStringField;
    LblFileLoadedDosID: TLabel;
    TabSheetDevSettings: TTabSheet;
    PanelOpenDevSettings: TPanel;
    DBGridEhDevSettings: TDBGridEh;
    MemTableEhDevSettings: TMemTableEh;
    MemTableEhDevSettingskfilter: TStringField;
    MemTableEhDevSettingsksdelta: TStringField;
    MemTableEhDevSettingskslevel: TStringField;
    MemTableEhDevSettingstldid: TStringField;
    DataSourceDevSettings: TDataSource;
    DataSetTextImporterEhDevSettings: TDataSetTextImporterEh;
    TabSheetMeas: TTabSheet;
    DBGridEhMeas: TDBGridEh;
    PanelOpenMeas: TPanel;
    DataSourceMeas: TDataSource;
    MemTableEhMeas: TMemTableEh;
    DataSetTextImporterEhMeas: TDataSetTextImporterEh;
    MemTableEhMeaskdev: TStringField;
    MemTableEhMeaspartname: TStringField;
    MemTableEhMeasformula_err_k2_4: TStringField;
    MemTableEhMeasformula_err_k1_4: TStringField;
    MemTableEhMeasformula_err_k2_3: TStringField;
    MemTableEhMeasformula_err_k1_3: TStringField;
    MemTableEhMeasto_del: TStringField;
    MemTableEhMeasd_err: TStringField;
    MemTableEhMeash007_err: TStringField;
    MemTableEhMeashstar_err: TStringField;
    MemTableEhMeashp007_err: TStringField;
    MemTableEhMeashp3_err: TStringField;
    MemTableEhMeashp10n_err: TStringField;
    MemTableEhMeashp10g_err: TStringField;
    MemTableEhMeasformula_err_k2_2: TStringField;
    MemTableEhMeasformula_err_k1_2: TStringField;
    MemTableEhMeasformula_err_k2_1: TStringField;
    MemTableEhMeasformula_err_k1_1: TStringField;
    MemTableEhMeasformula_id_val_4: TStringField;
    MemTableEhMeasformula_id_val_3: TStringField;
    MemTableEhMeasformula_id_val_2: TStringField;
    MemTableEhMeasformula_id_val_1: TStringField;
    MemTableEhMeasformula_id_dos: TStringField;
    MemTableEhMeasd: TStringField;
    MemTableEhMeash007: TStringField;
    MemTableEhMeashstar: TStringField;
    MemTableEhMeashp007: TStringField;
    MemTableEhMeashp3: TStringField;
    MemTableEhMeashp10n: TStringField;
    MemTableEhMeashp10g: TStringField;
    MemTableEhMeasmeasuredvalue: TStringField;
    MemTableEhMeaskfilter: TStringField;
    MemTableEhMeasmeascomment: TStringField;
    MemTableEhMeaslastmeascomment: TStringField;
    MemTableEhMeasdepartment: TStringField;
    MemTableEhMeasorganization: TStringField;
    MemTableEhMeasfio: TStringField;
    MemTableEhMeaspersonalnumber: TStringField;
    MemTableEhMeastlduser: TStringField;
    MemTableEhMeassoftwarever: TStringField;
    MemTableEhMeastldid: TStringField;
    MemTableEhMeaspartid: TStringField;
    MemTableEhMeaskgn: TStringField;
    MemTableEhMeask5: TStringField;
    MemTableEhMeask4: TStringField;
    MemTableEhMeask3: TStringField;
    MemTableEhMeask2: TStringField;
    MemTableEhMeask1: TStringField;
    MemTableEhMeasstatus: TStringField;
    MemTableEhMeasvalidity: TStringField;
    MemTableEhMeasvertime: TStringField;
    MemTableEhMeasregtime: TStringField;
    MemTableEhMeasmeasurmenttime: TStringField;
    MemTableEhMeasksi: TStringField;
    MemTableEhMeasformula: TStringField;
    MemTableEhMeasdosimetertypeid: TStringField;
    MemTableEhMeasdosimetertype: TStringField;
    MemTableEhMeaspostfix: TStringField;
    MemTableEhMeasdosimeterid: TStringField;
    MemTableEhMeasmeasurmentid: TStringField;
    DataSourceMeasDet: TDataSource;
    MemTableEhMeasDet: TMemTableEh;
    DataSetTextImporterEhMeasDet: TDataSetTextImporterEh;
    DBGridEhMeasDet: TDBGridEh;
    MemTableEhMeasDetmeasurmentid: TStringField;
    MemTableEhMeasDetdetectortype: TStringField;
    MemTableEhMeasDetdose: TStringField;
    MemTableEhMeasDeterr: TStringField;
    MemTableEhMeasDetposition: TStringField;
    MemTableEhMeasDetktv: TStringField;
    MemTableEhMeasDettempprofile: TStringField;
    MemTableEhMeasDetcalcfon: TStringField;
    MemTableEhMeasDetcalcgaus: TStringField;
    MemTableEhMeasDetcoefficient: TStringField;
    MemTableEhMeasDetmeasurmenttime: TStringField;
    MemTableEhMeasDetautoprocessing: TStringField;
    MemTableEhMeasDetstatus: TStringField;
    MemTableEhMeasDetcomment: TStringField;
    MemTableEhMeasDetbt: TStringField;
    MemTableEhMeasDetbx0: TStringField;
    MemTableEhMeasDetby0: TStringField;
    MemTableEhMeasDetgm1: TStringField;
    MemTableEhMeasDetga1: TStringField;
    MemTableEhMeasDetgsl: TStringField;
    MemTableEhMeasDetdgm2: TStringField;
    MemTableEhMeasDetdga2: TStringField;
    MemTableEhMeasDetgsr: TStringField;
    MemTableEhMeasDetn1: TStringField;
    MemTableEhMeasDetn2: TStringField;
    MemTableEhMeasDets: TStringField;
    MemTableEhMeasDetpeakfound: TStringField;
    MemTableEhMeasDetfonfound: TStringField;
    MemTableEhMeasDettempprofilewrite: TStringField;
    MemTableEhMeasDetmethod: TStringField;
    MemTableEhMeasDetdettypecomment: TStringField;
    MemTableEhMeasDetdetectortypeid: TStringField;
    MemTableEhMeasDetmeasval: TStringField;
    MemTableEhMeasDetkname: TStringField;
    MemTableEhMeasDetbn1_width: TStringField;
    MemTableEhMeasDetbn2: TStringField;
    MemTableEhMeasDetbn2_width: TStringField;
    MemTableEhMeasDetbn1: TStringField;
    MemTableEhMeasDetbxy0: TStringField;
    MemTableEhMeasDetbdy: TStringField;
    MemTableEhDetTypedetectortypeid: TStringField;
    procedure DBGridEhDosIDActiveGroupingStructChanged(Sender: TCustomDBGridEh);
    procedure FormShow(Sender: TObject);
    procedure LogClearClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure DBGridEhDosIDKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOpenDosIDClick(Sender: TObject);
  private

    FFileDosIDLoaded          : boolean;
    FFileDosTypeLoaded        : boolean;
    FFileDetTypeLoaded        : boolean;
    FFileDevSettingsLoaded    : boolean;
    FFileDosMeasLoaded        : boolean;
    FFileDetMeasLoaded        : boolean;

    FLoadFromFile       : boolean;


    procedure ImportValues(Table,FieldsString, ValuesString: String);
    procedure ImportDetValues(Table,FieldsString, ValuesString: String);
    procedure ImportDosimeterIDFromDBGrid;
    procedure ImportDosimeterTypeFromDBGrid;
    procedure ImportDetectorTypeFromDBGrid;
    procedure ImportDevSettingsFromDBGrid;
    procedure ImportMeasFromDBGrid;
    procedure UpdateDosIDValues(FieldsString, ValuesString, DosID, Postfix: String);
    procedure UpdateDosTypeValues(FieldsString, ValuesString, DosTypeID: String);
    procedure UpdateDetTypeValues(FieldsString, ValuesString, DetTypeID: String);
    procedure UpdateDevSettings(FieldsString, ValuesString, DevID: String);
    procedure AddToLog(Log: String; State: TLogState);
    procedure SetFileDosIDLoaded(const Value: boolean);
    procedure SetFileDosTypeLoaded(const Value: boolean);
    procedure SetFileDetTypeLoaded(const Value: boolean);
    procedure SetFileDevSettingsLoaded(const Value: boolean);
    procedure SetFileDosMeasLoaded(const Value: boolean);
    procedure SetFileDetMeasLoaded(const Value: boolean);
    procedure SetLoadFromFile(const Value: boolean);
    procedure LoadDBGrids;
    procedure LoadSQL;
    procedure ResizeGridColumn;

    { Private declarations }
  public
    ImportFromFile: boolean;
    InsertCnt   : integer;
    UpdateCnt   : integer;
    ErrCnt      : integer;
    function CreateBackupTable(TableName: String): boolean;
    function IsTableExists(TableName: String): boolean;
    function DropTable(TableName: String): boolean;
    function RenameTable(TableNameOld,TableNameNew: String): boolean;
    function IsDBConnected: boolean;
    procedure LoadGrid(Grid: TStringGrid; FileName: String; Separator: char);
    procedure LoadDBGridFromEdit;

    property FileDosIDLoaded: boolean read FFileDosIDLoaded write SetFileDosIDLoaded;
    property FileDosTypeLoaded: boolean read FFileDosTypeLoaded write SetFileDosTypeLoaded;
    property FileDetTypeLoaded: boolean read FFileDetTypeLoaded write SetFileDetTypeLoaded;
    property FileDevSettingsLoaded: boolean read FFileDevSettingsLoaded write SetFileDevSettingsLoaded;
    property FileDosMeasLoaded: boolean read FFileDosMeasLoaded write SetFileDosMeasLoaded;
    property FileDetMeasLoaded: boolean read FFileDetMeasLoaded write SetFileDetMeasLoaded;
    property LoadFromFile: boolean read FLoadFromFile write SetLoadFromFile;

    { Public declarations }
  end;

var
  ImportDosimetersW: TImportDosimetersW;

implementation

uses
  uConst,
  uLog,
  uDataModule,
  uMainForm,
  uFunctions,
  uImportProcess,
  uSeparator,
  uLanguages;
{$R *.dfm}

procedure TImportDosimetersW.ResizeGridColumn;
const
  cAddFieldSize = 10;
var
  i: integer;
  indicatorColWidth  : integer;
  columnsWidth       : integer;
  columnName         : String;
begin
  columnsWidth:=0;

  indicatorColWidth:=DBGridEhDosID.CalcIndicatorColWidth+{cAddFieldSize+}DBGridEhDosID.VertScrollBar.Width+DBGridEhDosID.FieldCount+1;

  for i := 0 to DBGridEhDosID.Columns.Count-1 do
  begin
    DBGridEhDosID.Columns[i].Title.Font.Size:=cGridFontSize;
    DBGridEhDosID.Columns[i].Alignment:=taLeftJustify;

    if (DBGridEhDosID.Columns[i].Visible) then
    begin
      columnsWidth:=columnsWidth+DBGridEhDosID.Columns[i].Width;
      columnName:=DBGridEhDosID.Columns[i].FieldName;
    end;
  end;

  columnsWidth:=columnsWidth-DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(columnName).Index].Width+indicatorColWidth;

  if (DBGridEhDosID.Width-columnsWidth)>cColumnWidth_1 then
    DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(columnName).Index].Width:=DBGridEhDosID.Width-columnsWidth
  else
    DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(columnName).Index].Width:=cColumnWidth_3;
end;

procedure TImportDosimetersW.LoadDBGridFromEdit;
var
  i       : integer;
  cnt     : integer;
  postfix : String;
  procedure CheckVisibleFieldEdit(Edit: TEdit;FieldName,Title: String; ColWidth: integer);
  begin
    if (Edit.Visible) AND (Edit.Text<>'') AND (Edit.Enabled) then
    begin
      DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(FieldName).Index].Visible:=true;
      DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(FieldName).Index].Title.Caption:=Title;
      DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(FieldName).Index].Width:=ColWidth;
    end
    else
      DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(FieldName).Index].Visible:=false;
  end;
  procedure CheckVisibleFieldCBox(CBox: TComboBox;FieldName,Title: String; ColWidth: integer);
  begin
    if (CBox.ItemIndex>=0) then
    begin
      DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(FieldName).Index].Visible:=true;
      DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(FieldName).Index].Title.Caption:=Title;
      DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(FieldName).Index].Width:=ColWidth;
    end
    else
      DBGridEhDosID.Columns[DBGridEhDosID.DataSource.DataSet.FieldByName(FieldName).Index].Visible:=false;
  end;
  procedure CheckNullField(Edit: TEdit; FieldName: String);
  begin
    if Edit.Visible then
    begin
      DBGridEhDosID.DataSource.DataSet.FieldByName(FieldName).AsString:=Edit.Text;
    end
    else
    begin
      DBGridEhDosID.DataSource.DataSet.FieldByName(FieldName).IsNull;
    end;
  end;
begin
  case DosimeterConstructorForm.EditDosMode of
//    addSingle:
//    begin
//
//    end;
    addGroup:
    begin
      if DosimeterConstructorForm.EditDosNumberFrom.Text <> '' then
      begin
        DosimeterConstructorForm.RangeFrom:=StrToInt(DosimeterConstructorForm.EditDosNumberFrom.Text);
        DosimeterConstructorForm.RangeCount:=StrToInt(DosimeterConstructorForm.EditDosCount.Text);
        DosimeterConstructorForm.RangeTo:=DosimeterConstructorForm.RangeFrom+DosimeterConstructorForm.RangeCount;
      end
      else
      begin
        DosimeterConstructorForm.RangeFrom:=0;
        DosimeterConstructorForm.RangeCount:=0;
        DosimeterConstructorForm.RangeTo:=0;
      end;

      if DosimeterConstructorForm.RangeTo>=DosimeterConstructorForm.RangeFrom then
      begin
        MainForm.Splash.ProgressBar.Minimum:=0;
        MainForm.Splash.ProgressBar.Maximum:=DosimeterConstructorForm.RangeCount;
        MainForm.Splash.ProgressBar.Position:=0;
        MainForm.Splash.Show(false);
        MainForm.Splash.SetCaption(rsImpDosListBuilding);

        //**DosimeterConstructorForm.ProgressBarLoadDosList.Min:=0;
        //**DosimeterConstructorForm.ProgressBarLoadDosList.Max:=DosimeterConstructorForm.RangeCount;
        //**DosimeterConstructorForm.ProgressBarLoadDosList.Visible:=true;

        MemTableEhDosID.Open;
        MemTableEhDosID.EmptyTable;

        if DosimeterConstructorForm.EditDosPostfix.Text = '' then
          postfix:='-'
        else
          postfix:=DosimeterConstructorForm.EditDosPostfix.Text;

        ResizeGridColumn;

        cnt:=0;
        for i := DosimeterConstructorForm.RangeFrom to DosimeterConstructorForm.RangeTo-1 do
        begin
          inc(cnt);

          MemTableEhDosID.Append;

          with DBGridEhDosID.DataSource.DataSet do
          begin
            if DBGridEhDosID.Columns[FieldByName(cFieldDosID).Index].Visible then FieldByName(cFieldDosID).AsString:=IntToStr(i);
            if DBGridEhDosID.Columns[FieldByName(cFieldDosPostfix).Index].Visible then FieldByName(cFieldDosPostfix).AsString:=postfix;
            if DBGridEhDosID.Columns[FieldByName(cFieldDosType).Index].Visible then FieldByName(cFieldDosType).AsString:=DosimeterConstructorForm.ComboBoxDosType.Items[DosimeterConstructorForm.ComboBoxDosType.ItemIndex];
            if DBGridEhDosID.Columns[FieldByName(cField_k1).Index].Visible then CheckNullField(DosimeterConstructorForm.EditDosK_1,cField_k1);
            if DBGridEhDosID.Columns[FieldByName(cField_k2).Index].Visible then CheckNullField(DosimeterConstructorForm.EditDosK_2,cField_k2);
            if DBGridEhDosID.Columns[FieldByName(cField_k3).Index].Visible then CheckNullField(DosimeterConstructorForm.EditDosK_3,cField_k3);
            if DBGridEhDosID.Columns[FieldByName(cField_k4).Index].Visible then CheckNullField(DosimeterConstructorForm.EditDosK_4,cField_k4);
            if DBGridEhDosID.Columns[FieldByName(cField_k5).Index].Visible then CheckNullField(DosimeterConstructorForm.EditDosK_5,cField_k5);
            if DBGridEhDosID.Columns[FieldByName(cField_kgn).Index].Visible then CheckNullField(DosimeterConstructorForm.EditDosK_gn,cField_kgn);
            if DBGridEhDosID.Columns[FieldByName(cFieldDosPartName).Index].Visible then FieldByName(cFieldDosPartName).AsString:=DosimeterConstructorForm.EditPartName.Text;
            if DBGridEhDosID.Columns[FieldByName(cFieldOrg).Index].Visible then FieldByName(cFieldOrg).AsString:=DosimeterConstructorForm.EditDosOrg.Text;
            if DBGridEhDosID.Columns[FieldByName(cFieldDepartment).Index].Visible then FieldByName(cFieldDepartment).AsString:=DosimeterConstructorForm.EditDosDep.Text;
          end;

          MainForm.Splash.ProgressBar.Position:=cnt;
          //**DosimeterConstructorForm.ProgressBarLoadDosList.Position:=cnt;
        end;

        if MemTableEhDosID.RecordCount>0 then//  DataSource.DataSet.RecordCount>0 then
          MemTableEhDosID.Post;

        MainForm.Splash.Close;
        //**DosimeterConstructorForm.ProgressBarLoadDosList.Position:=0;
        //**DosimeterConstructorForm.ProgressBarLoadDosList.Visible:=false;
      end;

    end;
    addFromFile:
    begin
      MemTableEhDosID.Open;
      MemTableEhDosID.EmptyTable;

      for i := 0 to DBGridEhDosID.Columns.Count-1 do
      begin
        DBGridEhDosID.Columns[i].Visible:=true;
      end;
      //DBGridEhDosID.DataSource.DataSet.ClearFields;
    end;
  end;
end;

procedure TImportDosimetersW.AddToLog(Log: String; State: TLogState);
begin

  case State of
    lgSuccess:
    begin
      ImportProcessW.MemoLog.Lines.Add(Format('%s! %s'+#10+#13,[rsImpAddedRecord,Log]));
      inc(InsertCnt);
    end;
    lgWarning:
    begin
      ImportProcessW.MemoLog.Lines.Add(Format('%s! %s'+#10+#13,[rsImpUpdatedRecord,Log]));
      inc(UpdateCnt);
    end;
    lgError:
    begin
      ImportProcessW.MemoLog.Lines.Add(Format('%s! %s'+#10+#13,[rsSmError,Log]));
      inc(ErrCnt);
    end;
    lgInformation:
    begin
      ImportProcessW.MemoLog.Lines.Add(Format('%s! %s'+#10+#13,[rsImpInformation,Log]));
    end;
  end;

  WriteLog(Log);
end;

procedure TImportDosimetersW.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TImportDosimetersW.BtnOpenDosIDClick(Sender: TObject);
const
  c_start_progressbar = 0;
  c_middle_progressbar = 50;
  c_finish_progressbar = 100;
var
  fileName  : String;
  fullPath  : String;
  i         : integer;
  f             : TextFile;
  s             : String;
  strListFile         : TStringList;
  strDelimeted        : TStringList;
  // заголовки списока дозиметров
  index_dosimeterid              : integer;
  index_postfix                  : integer;
  index_dosimetertype            : integer;
  index_k1                       : integer;
  index_k2                       : integer;
  index_k3                       : integer;
  index_k4                       : integer;
  index_k5                       : integer;
  index_kgn                      : integer;
  index_partname                 : integer;
  index_organization             : integer;
  index_department               : integer;
  // заголовки списока типов дозиметров
  index_measuredvalue            : integer;
  index_dtype1                   : integer;
  index_dtype2                   : integer;
  index_dtype3                   : integer;
  index_dtype4                   : integer;
  index_formula                  : integer;
  index_error                    : integer;
  index_formula_id_dos           : integer;
  index_formula_id_val_1         : integer;
  index_formula_id_val_2         : integer;
  index_formula_id_val_3         : integer;
  index_formula_id_val_4         : integer;
  index_formula_err_k1_1         : integer;
  index_formula_err_k2_1         : integer;
  index_formula_err_k1_2         : integer;
  index_formula_err_k2_2         : integer;
  index_formula_err_k1_3         : integer;
  index_formula_err_k2_3         : integer;
  index_formula_err_k1_4         : integer;
  index_formula_err_k2_4         : integer;
// заголовки списока типов детекторов
  index_detectortypeid           : integer;
  index_detectortype             : integer;
  index_tempprofile              : integer;
  index_dettypecomment           : integer;
  index_method                   : integer;
  index_measval                  : integer;
  index_kname                    : integer;
  index_k1profile                : integer;
  index_k2profile                : integer;
// заголовки списока настроек
  index_tldid                    : integer;
  index_kslevel                  : integer;
  index_ksdelta                  : integer;
  index_kfilter                  : integer;
  index_kdev                     : integer;
// заголовок списка измерений дозиметров
  u: integer;
  s1,s2: string;
  {index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_
  index_}

begin
  if OpenDialogList.Execute then
  begin
    // список дозиметров

    EditLoadListDosID.Text:=OpenDialogList.FileName;
    fileName:=OpenDialogList.FileName;

    MainForm.Splash.ProgressBar.Minimum:=c_start_progressbar;
    MainForm.Splash.ProgressBar.Maximum:=c_finish_progressbar;

    if FileExists(fileName) then
    begin
      MainForm.Splash.ProgressBar.Position:=c_start_progressbar;
      MainForm.Splash.Show(false);
      MainForm.Splash.SetCaption(rsImpDosListBuilding);

      MemTableEhDosID.Open;
      MemTableEhDosID.EmptyTable;

      MainForm.Splash.ProgressBar.Position:=c_middle_progressbar;

      strListFile:=TStringList.Create;
      strDelimeted:=TStringList.Create;
      strDelimeted.StrictDelimiter:=true;
      strDelimeted.Delimiter:=';';

      AssignFile(f,OpenDialogList.FileName);
      Reset(f);
      while not EOF(f) do
      begin
        readln(f,s);
        strListFile.Add(s);
      end;
      CloseFile(f);

      strDelimeted.DelimitedText:=strListFile.Strings[0];

      index_dosimeterid:=strDelimeted.IndexOf(cFieldDosID);
      index_postfix:=strDelimeted.IndexOf(cFieldDosPostfix);
      index_dosimetertype:=strDelimeted.IndexOf(cFieldDosType);
      index_k1:=strDelimeted.IndexOf(cField_k1);
      index_k2:=strDelimeted.IndexOf(cField_k2);
      index_k3:=strDelimeted.IndexOf(cField_k3);
      index_k4:=strDelimeted.IndexOf(cField_k4);
      index_k5:=strDelimeted.IndexOf(cField_k5);
      index_kgn:=strDelimeted.IndexOf(cField_kgn);
      index_partname:=strDelimeted.IndexOf(cFieldDosPartName);
      index_organization:=strDelimeted.IndexOf(cFieldOrg);
      index_department:=strDelimeted.IndexOf(cFieldDepartment);

      try
        for i:=1 to strListFile.Count-1 do  // начинаем с первого т.к. нулевая строка - заголовки столбцов
        begin
          strDelimeted.Clear;
          strDelimeted.DelimitedText:=strListFile[i];
          MemTableEhDosID.Append;
          with DBGridEhDosID.DataSource.DataSet do
          begin
            if DBGridEhDosID.Columns[FieldByName(cFieldDosID).Index].Visible then FieldByName(cFieldDosID).AsString:=strDelimeted.Strings[index_dosimeterid];
            if DBGridEhDosID.Columns[FieldByName(cFieldDosPostfix).Index].Visible then FieldByName(cFieldDosPostfix).AsString:=strDelimeted.Strings[index_postfix];
            if DBGridEhDosID.Columns[FieldByName(cFieldDosType).Index].Visible then FieldByName(cFieldDosType).AsString:=strDelimeted.Strings[index_dosimetertype];
            if DBGridEhDosID.Columns[FieldByName(cField_k1).Index].Visible then FieldByName(cField_k1).AsString:=strDelimeted.Strings[index_k1];
            if DBGridEhDosID.Columns[FieldByName(cField_k2).Index].Visible then FieldByName(cField_k2).AsString:=strDelimeted.Strings[index_k2];
            if DBGridEhDosID.Columns[FieldByName(cField_k3).Index].Visible then FieldByName(cField_k3).AsString:=strDelimeted.Strings[index_k3];
            if DBGridEhDosID.Columns[FieldByName(cField_k4).Index].Visible then FieldByName(cField_k4).AsString:=strDelimeted.Strings[index_k4];
            if DBGridEhDosID.Columns[FieldByName(cField_k5).Index].Visible then FieldByName(cField_k5).AsString:=strDelimeted.Strings[index_k5];
            if DBGridEhDosID.Columns[FieldByName(cField_kgn).Index].Visible then FieldByName(cField_kgn).AsString:=strDelimeted.Strings[index_kgn];
            if DBGridEhDosID.Columns[FieldByName(cFieldDosPartName).Index].Visible then FieldByName(cFieldDosPartName).AsString:=strDelimeted.Strings[index_partname];
            if DBGridEhDosID.Columns[FieldByName(cFieldOrg).Index].Visible then FieldByName(cFieldOrg).AsString:=strDelimeted.Strings[index_organization];
            if DBGridEhDosID.Columns[FieldByName(cFieldDepartment).Index].Visible then FieldByName(cFieldDepartment).AsString:=strDelimeted.Strings[index_department];
          end;
        end;

        MemTableEhDosID.Post;

        strListFile.Free;
        strDelimeted.Free;

        FileDosIDLoaded:=true;

        MainForm.Splash.ProgressBar.Position:=c_finish_progressbar;
        MainForm.Splash.Close;
      except
        strListFile.Free;
        strDelimeted.Free;

        FileDosIDLoaded:=false;

        MainForm.Splash.ProgressBar.Position:=c_finish_progressbar;
        MainForm.Splash.Close;
        MessageDlg(Format('%s - %s',[rsErrImportFile,fileName]),mtError, [mbOK], 0);
        exit;
      end;

    end
    else
    begin
      FileDosIDLoaded:=false;
    end;

    // список типов дозиметров
    fullPath:=OpenDialogList.FileName;
    delete(fullPath,pos(cExtCSV,fullPath),Length(cExtCSV));
    fileName:=fullPath+cExtDOST;

    if FileExists(fileName) then
    begin
      MainForm.Splash.ProgressBar.Position:=c_start_progressbar;
      MainForm.Splash.Show(false);
      MainForm.Splash.SetCaption(rsImpDosTypeListBuilding);

      MemTableEhDosType.Open;
      MemTableEhDosType.EmptyTable;

      MainForm.Splash.ProgressBar.Position:=c_middle_progressbar;

      strListFile:=TStringList.Create;
      strDelimeted:=TStringList.Create;
      strDelimeted.StrictDelimiter:=true;
      strDelimeted.Delimiter:=';';


      AssignFile(f,fileName);
      Reset(f);
      while not EOF(f) do
      begin
        readln(f,s);
        strListFile.Add(s);
      end;
      CloseFile(f);

      strDelimeted.DelimitedText:=strListFile.Strings[0];

      index_dosimetertype:=strDelimeted.IndexOf(cFieldDosType);
      index_measuredvalue:=strDelimeted.IndexOf(cFieldMeasVal);
      index_dtype1:=strDelimeted.IndexOf(cFieldDType1);
      index_dtype2:=strDelimeted.IndexOf(cFieldDType2);
      index_dtype3:=strDelimeted.IndexOf(cFieldDType3);
      index_dtype4:=strDelimeted.IndexOf(cFieldDType4);
      index_formula:=strDelimeted.IndexOf(cFieldFormula);
      index_error:=strDelimeted.IndexOf(cFieldError);
      index_formula_id_dos:=strDelimeted.IndexOf(cFieldFormulaId_Dos);
      index_formula_id_val_1:=strDelimeted.IndexOf(cFieldFormulaId_Val_1);
      index_formula_id_val_2:=strDelimeted.IndexOf(cFieldFormulaId_Val_2);
      index_formula_id_val_3:=strDelimeted.IndexOf(cFieldFormulaId_Val_3);
      index_formula_id_val_4:=strDelimeted.IndexOf(cFieldFormulaId_Val_4);
      index_formula_err_k1_1:=strDelimeted.IndexOf(cFieldFormula_Err_k1_1);
      index_formula_err_k2_1:=strDelimeted.IndexOf(cFieldFormula_Err_k2_1);
      index_formula_err_k1_2:=strDelimeted.IndexOf(cFieldFormula_Err_k1_2);
      index_formula_err_k2_2:=strDelimeted.IndexOf(cFieldFormula_Err_k2_2);
      index_formula_err_k1_3:=strDelimeted.IndexOf(cFieldFormula_Err_k1_3);
      index_formula_err_k2_3:=strDelimeted.IndexOf(cFieldFormula_Err_k2_3);
      index_formula_err_k1_4:=strDelimeted.IndexOf(cFieldFormula_Err_k1_4);
      index_formula_err_k2_4:=strDelimeted.IndexOf(cFieldFormula_Err_k2_4);

      try
        for i:=1 to strListFile.Count-1 do  // начинаем с первого т.к. нулевая строка - заголовки столбцов
        begin
          strDelimeted.Clear;
          strDelimeted.DelimitedText:=strListFile[i];
          MemTableEhDosType.Append;
          with DBGridEhDosType.DataSource.DataSet do
          begin
            if DBGridEhDosType.Columns[FieldByName(cFieldDosType).Index].Visible then FieldByName(cFieldDosType).AsString:=strDelimeted.Strings[index_dosimetertype];
            if DBGridEhDosType.Columns[FieldByName(cFieldMeasVal).Index].Visible then FieldByName(cFieldMeasVal).AsString:=strDelimeted.Strings[index_measuredvalue];
            if DBGridEhDosType.Columns[FieldByName(cFieldDType1).Index].Visible then FieldByName(cFieldDType1).AsString:=strDelimeted.Strings[index_dtype1];
            if DBGridEhDosType.Columns[FieldByName(cFieldDType2).Index].Visible then FieldByName(cFieldDType2).AsString:=strDelimeted.Strings[index_dtype2];
            if DBGridEhDosType.Columns[FieldByName(cFieldDType3).Index].Visible then FieldByName(cFieldDType3).AsString:=strDelimeted.Strings[index_dtype3];
            if DBGridEhDosType.Columns[FieldByName(cFieldDType4).Index].Visible then FieldByName(cFieldDType4).AsString:=strDelimeted.Strings[index_dtype4];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormula).Index].Visible then FieldByName(cFieldFormula).AsString:=strDelimeted.Strings[index_formula];
            if DBGridEhDosType.Columns[FieldByName(cFieldError).Index].Visible then FieldByName(cFieldError).AsString:=strDelimeted.Strings[index_error];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormulaId_Dos).Index].Visible then FieldByName(cFieldFormulaId_Dos).AsString:=strDelimeted.Strings[index_formula_id_dos];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormulaId_Val_1).Index].Visible then FieldByName(cFieldFormulaId_Val_1).AsString:=strDelimeted.Strings[index_formula_id_val_1];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormulaId_Val_2).Index].Visible then FieldByName(cFieldFormulaId_Val_2).AsString:=strDelimeted.Strings[index_formula_id_val_2];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormulaId_Val_3).Index].Visible then FieldByName(cFieldFormulaId_Val_3).AsString:=strDelimeted.Strings[index_formula_id_val_3];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormulaId_Val_4).Index].Visible then FieldByName(cFieldFormulaId_Val_4).AsString:=strDelimeted.Strings[index_formula_id_val_4];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormula_Err_k1_1).Index].Visible then FieldByName(cFieldFormula_Err_k1_1).AsString:=strDelimeted.Strings[index_formula_err_k1_1];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormula_Err_k2_1).Index].Visible then FieldByName(cFieldFormula_Err_k2_1).AsString:=strDelimeted.Strings[index_formula_err_k2_1];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormula_Err_k1_2).Index].Visible then FieldByName(cFieldFormula_Err_k1_2).AsString:=strDelimeted.Strings[index_formula_err_k1_2];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormula_Err_k2_2).Index].Visible then FieldByName(cFieldFormula_Err_k2_2).AsString:=strDelimeted.Strings[index_formula_err_k2_2];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormula_Err_k1_3).Index].Visible then FieldByName(cFieldFormula_Err_k1_3).AsString:=strDelimeted.Strings[index_formula_err_k1_3];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormula_Err_k2_3).Index].Visible then FieldByName(cFieldFormula_Err_k2_3).AsString:=strDelimeted.Strings[index_formula_err_k2_3];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormula_Err_k1_4).Index].Visible then FieldByName(cFieldFormula_Err_k1_4).AsString:=strDelimeted.Strings[index_formula_err_k1_4];
            if DBGridEhDosType.Columns[FieldByName(cFieldFormula_Err_k2_4).Index].Visible then FieldByName(cFieldFormula_Err_k2_4).AsString:=strDelimeted.Strings[index_formula_err_k2_4];
          end;
        end;

        MemTableEhDosType.Post;

        strListFile.Free;
        strDelimeted.Free;

        TabSheetDosTypeList.TabVisible:=true;
        FileDosTypeLoaded:=true;

        MainForm.Splash.ProgressBar.Position:=c_finish_progressbar;
        MainForm.Splash.Close;

      except
        strListFile.Free;
        strDelimeted.Free;

        FileDosTypeLoaded:=false;

        MainForm.Splash.ProgressBar.Position:=c_finish_progressbar;
        MainForm.Splash.Close;
        MessageDlg(Format('%s - %s',[rsErrImportFile,fileName]),mtError, [mbOK], 0);
        exit;
      end;
    end
    else
    begin
      TabSheetDosTypeList.TabVisible:=false;
      FileDosTypeLoaded:=false;
    end;

    // список типов детекторов
    fileName:=fullPath+cExtDETT;

    if FileExists(fileName) then
    begin
      MainForm.Splash.ProgressBar.Position:=c_start_progressbar;
      MainForm.Splash.Show(false);
      MainForm.Splash.SetCaption(rsImpDetTypeListBuilding);

      MemTableEhDetType.Open;
      MemTableEhDetType.EmptyTable;

      MainForm.Splash.ProgressBar.Position:=c_middle_progressbar;

      strListFile:=TStringList.Create;
      strDelimeted:=TStringList.Create;
      strDelimeted.StrictDelimiter:=true;
      strDelimeted.Delimiter:=';';

      AssignFile(f,fileName);
      Reset(f);
      while not EOF(f) do
      begin
        readln(f,s);
        strListFile.Add(s);
      end;
      CloseFile(f);

      strDelimeted.DelimitedText:=strListFile.Strings[0];

      index_detectortypeid:=strDelimeted.IndexOf(cFieldDetTypeID);
      index_detectortype:=strDelimeted.IndexOf(cFieldDetType);
      index_tempprofile:=strDelimeted.IndexOf(cFieldTempProfile);
      index_dettypecomment:=strDelimeted.IndexOf(cFieldDetTypeComment);
      index_method:=strDelimeted.IndexOf(cFieldMethod);
      index_measval:=strDelimeted.IndexOf(cFieldDetMeasVal);
      index_kname:=strDelimeted.IndexOf(cFieldDetKName);
      index_k1profile:=strDelimeted.IndexOf(cFieldK1Profile);
      index_k2profile:=strDelimeted.IndexOf(cFieldK2Profile);

      try
        for i:=1 to strListFile.Count-1 do  // начинаем с первого т.к. нулевая строка - заголовки столбцов
        begin
          strDelimeted.Clear;
          strDelimeted.DelimitedText:=strListFile[i];
          MemTableEhDetType.Append;
          with DBGridEhDetType.DataSource.DataSet do
          begin
            if DBGridEhDetType.Columns[FieldByName(cFieldDetTypeID).Index].Visible then FieldByName(cFieldDetTypeID).AsString:=strDelimeted.Strings[index_detectortypeid];
            if DBGridEhDetType.Columns[FieldByName(cFieldDetType).Index].Visible then FieldByName(cFieldDetType).AsString:=strDelimeted.Strings[index_detectortype];
            if DBGridEhDetType.Columns[FieldByName(cFieldTempProfile).Index].Visible then FieldByName(cFieldTempProfile).AsString:=strDelimeted.Strings[index_tempprofile];
            if DBGridEhDetType.Columns[FieldByName(cFieldDetTypeComment).Index].Visible then FieldByName(cFieldDetTypeComment).AsString:=strDelimeted.Strings[index_dettypecomment];
            if DBGridEhDetType.Columns[FieldByName(cFieldMethod).Index].Visible then FieldByName(cFieldMethod).AsString:=strDelimeted.Strings[index_method];
            if DBGridEhDetType.Columns[FieldByName(cFieldDetMeasVal).Index].Visible then FieldByName(cFieldDetMeasVal).AsString:=strDelimeted.Strings[index_measval];
            if DBGridEhDetType.Columns[FieldByName(cFieldDetKName).Index].Visible then FieldByName(cFieldDetKName).AsString:=strDelimeted.Strings[index_kname];
            if DBGridEhDetType.Columns[FieldByName(cFieldK1Profile).Index].Visible then FieldByName(cFieldK1Profile).AsString:=strDelimeted.Strings[index_k1profile];
            if DBGridEhDetType.Columns[FieldByName(cFieldK2Profile).Index].Visible then FieldByName(cFieldK2Profile).AsString:=strDelimeted.Strings[index_k2profile];
          end;
        end;

        MemTableEhDetType.Post;

        strListFile.Free;
        strDelimeted.Free;

        TabSheetDetTypeList.TabVisible:=true;
        FileDetTypeLoaded:=true;

        MainForm.Splash.ProgressBar.Position:=c_finish_progressbar;
        MainForm.Splash.Close;
      except
        strListFile.Free;
        strDelimeted.Free;

        FileDetTypeLoaded:=false;

        MainForm.Splash.ProgressBar.Position:=c_finish_progressbar;
        MainForm.Splash.Close;
        MessageDlg(Format('%s - %s',[rsErrImportFile,fileName]),mtError, [mbOK], 0);
        exit;
      end;
    end
    else
    begin
      TabSheetDetTypeList.TabVisible:=false;
      FileDetTypeLoaded:=false;
    end;

    // настройки
    fileName:=fullPath+cExtCFGT;

    if FileExists(fileName) then
    begin
      MainForm.Splash.ProgressBar.Position:=c_start_progressbar;
      MainForm.Splash.Show(false);
      MainForm.Splash.SetCaption(rsImpSettingsListBuilding);

      MemTableEhDevSettings.Open;
      MemTableEhDevSettings.EmptyTable;

      MainForm.Splash.ProgressBar.Position:=c_middle_progressbar;

      strListFile:=TStringList.Create;
      strDelimeted:=TStringList.Create;
      strDelimeted.StrictDelimiter:=true;
      strDelimeted.Delimiter:=';';

      AssignFile(f,fileName);
      Reset(f);
      while not EOF(f) do
      begin
        readln(f,s);
        strListFile.Add(s);
      end;
      CloseFile(f);

      strDelimeted.DelimitedText:=strListFile.Strings[0];

      index_tldid:=strDelimeted.IndexOf(cFieldTldID);
      index_kslevel:=strDelimeted.IndexOf(cFieldKSLevel);
      index_ksdelta:=strDelimeted.IndexOf(cFieldKSDelta);
      index_kfilter:=strDelimeted.IndexOf(cFieldKFilter);
      index_kdev:=strDelimeted.IndexOf(cFieldKDevice);
      try
        for i:=1 to strListFile.Count-1 do  // начинаем с первого т.к. нулевая строка - заголовки столбцов
        begin
          strDelimeted.Clear;
          strDelimeted.DelimitedText:=strListFile[i];
          MemTableEhDevSettings.Append;
          with DBGridEhDevSettings.DataSource.DataSet do
          begin
            if DBGridEhDevSettings.Columns[FieldByName(cFieldTldID).Index].Visible then FieldByName(cFieldTldID).AsString:=strDelimeted.Strings[index_tldid];
            if DBGridEhDevSettings.Columns[FieldByName(cFieldKSLevel).Index].Visible then FieldByName(cFieldKSLevel).AsString:=strDelimeted.Strings[index_kslevel];
            if DBGridEhDevSettings.Columns[FieldByName(cFieldKSDelta).Index].Visible then FieldByName(cFieldKSDelta).AsString:=strDelimeted.Strings[index_ksdelta];
            if DBGridEhDevSettings.Columns[FieldByName(cFieldKFilter).Index].Visible then FieldByName(cFieldKFilter).AsString:=strDelimeted.Strings[index_kfilter];
            if index_kdev>=0 then // проверка на существование поля kdev для совместимости со старыми версиями файла импорта
            begin
              if DBGridEhDevSettings.Columns[FieldByName(cFieldKDevice).Index].Visible then FieldByName(cFieldKDevice).AsString:=strDelimeted.Strings[index_kdev]
            end
            else
              DBGridEhDevSettings.Columns[FieldByName(cFieldKDevice).Index].Visible:=false;
          end;
        end;

        MemTableEhDevSettings.Post;

        strListFile.Free;
        strDelimeted.Free;

        TabSheetDevSettings.TabVisible:=true;
        FileDevSettingsLoaded:=true;

        MainForm.Splash.ProgressBar.Position:=c_finish_progressbar;
        MainForm.Splash.Close;
      except
        strListFile.Free;
        strDelimeted.Free;

        FileDevSettingsLoaded:=false;

        MainForm.Splash.ProgressBar.Position:=c_finish_progressbar;
        MainForm.Splash.Close;
        MessageDlg(Format('%s - %s',[rsErrImportFile,fileName]),mtError, [mbOK], 0);
        exit;
      end;
    end
    else
    begin
      TabSheetDevSettings.TabVisible:=false;
      FileDevSettingsLoaded:=false;
    end;

    // разобраться с импортом/экспортом измерений из файла

    {fileName:=fullPath+cExtMDOS;

    if FileExists(fileName) then
    begin
      MainForm.Splash.ProgressBar.Position:=c_start_progressbar;
      MainForm.Splash.Show(false);
      MainForm.Splash.SetCaption(rsImpMeasListBuilding);

      MemTableEhMeas.Open;
      MemTableEhMeas.EmptyTable;

      MainForm.Splash.ProgressBar.Position:=c_middle_progressbar;

      strListFile:=TStringList.Create;
      strDelimeted:=TStringList.Create;
      strDelimeted.Delimiter:=';';

      AssignFile(f,fileName);
      Reset(f);
      while not EOF(f) do
      begin
        readln(f,s);
        strListFile.Add(s);
      end;
      CloseFile(f);

      strDelimeted.DelimitedText:=strListFile.Strings[0];

      index_tldid:=strDelimeted.IndexOf();
      index_kslevel:=strDelimeted.IndexOf();
      index_ksdelta:=strDelimeted.IndexOf();
      index_kfilter:=strDelimeted.IndexOf();

      for i:=1 to strListFile.Count-1 do  // начинаем с первого т.к. нулевая строка - заголовки столбцов
      begin
        strDelimeted.Clear;
        strDelimeted.DelimitedText:=strListFile[i];
        MemTableEhMeas.Append;
        with DBGridEhMeas.DataSource.DataSet do
        begin
          if DBGridEhMeas.Columns[FieldByName().Index].Visible then FieldByName().AsString:=strDelimeted.Strings[];
          if DBGridEhMeas.Columns[FieldByName().Index].Visible then FieldByName().AsString:=strDelimeted.Strings[];
          if DBGridEhMeas.Columns[FieldByName().Index].Visible then FieldByName().AsString:=strDelimeted.Strings[];
          if DBGridEhMeas.Columns[FieldByName().Index].Visible then FieldByName().AsString:=strDelimeted.Strings[];
        end;
      end;

      if MemTableEhMeas.RecordCount>0 then
          MemTableEhMeas.Post;

      strListFile.Free;
      strDelimeted.Free;

      TabSheetMeas.TabVisible:=true;
      FileDosMeasLoaded:=true;

      fileName:=fullPath+cExtMDET;

      if FileExists(fileName) then
      begin
        MemTableEhMeasDet.Open;
        MemTableEhMeasDet.EmptyTable;

        MainForm.Splash.ProgressBar.Position:=75;

        if DBGridEhMeasDet.DataSource.DataSet.Filtered then DBGridEhMeasDet.DataSource.DataSet.Filtered:=false;
        DataSetTextImporterEhMeasDet.ImportFromFile(fileName);
        FileDetMeasLoaded:=true;
      end
      else
        FileDetMeasLoaded:=false;

      MainForm.Splash.ProgressBar.Position:=c_finish_progressbar;
      MainForm.Splash.Close;
    end
    else
    begin
      TabSheetMeas.TabVisible:=false;
    end;}
  end;
end;

procedure TImportDosimetersW.BtnImportClick(Sender: TObject);
var
  backupFile: String;
  u: integer;
begin
  u:=DBGridEhDosID.RowCount;

  if (FileDosIDLoaded OR not LoadFromFile) then
  begin
    ImportProcessW.MemoLog.Lines.Clear;

    backupFile:=TLDDataModule.CreateBackupDB(TLDDataModule.GetBackupDBName);

    LoadSQL;

    if FFileDevSettingsLoaded then
      if IsTableExists(cDBTableSettings) then
        ImportDevSettingsFromDBGrid;

    if FFileDetTypeLoaded then
      if IsTableExists(cDBTableDetType) then
        ImportDetectorTypeFromDBGrid;

    if FFileDosTypeLoaded then
      if IsTableExists(cDBTableDosType) then
        ImportDosimeterTypeFromDBGrid;

    if (FFileDosIDLoaded) OR (DBGridEhDosID.RowCount>1) then
      if IsTableExists(cDBTableDosID) then
        ImportDosimeterIDFromDBGrid;

    if (FFileDosMeasLoaded) AND (FFileDetMeasLoaded) then
      if IsTableExists(cDBTableDosRes) AND IsTableExists(cDBTableDetRes) then
        ImportMeasFromDBGrid;

    if backupFile<>'' then
    begin
      ImportProcessW.backupBDName:=backupFile;
      ImportProcessW.ShowModal;
    end;
  end;
end;

procedure TImportDosimetersW.FormShow(Sender: TObject);
begin
  FFileDosIDLoaded:=false;
  FFileDosTypeLoaded:=false;
  FFileDetTypeLoaded:=false;
  FFileDevSettingsLoaded:=false;
  FFileDosMeasLoaded:=false;
  FFileDetMeasLoaded:=false;

  InsertCnt:=0;
  UpdateCnt:=0;
  ErrCnt:=0;

  ImportProcessW.MemoLog.Lines.Clear;

  EditLoadListDosID.Text:='';

  PageControlFiles.ActivePage:=TabSheetDosList;

  TabSheetDosTypeList.TabVisible:=false;
  TabSheetDetTypeList.TabVisible:=false;
  TabSheetDevSettings.TabVisible:=false;
  TabSheetMeas.TabVisible:=false;

  if not LoadFromFile then
    LoadDBGridFromEdit
  else
  begin
    MemTableEhDosID.EmptyTable;
  end;
end;

procedure TImportDosimetersW.DBGridEhDosIDActiveGroupingStructChanged(
  Sender: TCustomDBGridEh);
begin

end;

procedure TImportDosimetersW.ImportDetectorTypeFromDBGrid;
var
  i                 : integer;
  detType           : String;
  strFields         : String;
  strValues         : String;
  detTypeID         : integer;
begin
  strFields:='';
  strValues:='';
  detTypeID:=-1;

  with DBGridEhDetType.DataSource.DataSet do
  begin
    First;

    strFields:=cFieldDetTypeID+','+
               cFieldDetType+','+
               cFieldTempProfile+','+
               cFieldDetTypeComment+','+
               cFieldMethod+','+
               cFieldDetMeasVal+','+
               cFieldK1Profile+','+
               cFieldK2Profile+','+
               cFieldDetKName;

    MainForm.Splash.ProgressBar.Minimum:=0;
    MainForm.Splash.ProgressBar.Maximum:=DBGridEhDetType.RowCount-2;
    MainForm.Splash.ProgressBar.Position:=0;
    MainForm.Splash.Show(false);
    MainForm.Splash.SetCaption(rsImpDetType);

    for i := 0 to DBGridEhDetType.RowCount-2 do
    begin
      try
        detType:=FieldByName(cFieldDetType).AsString;
        detTypeID:=TLDDataModule.GetDetTypeID(detType);

        strValues:=#39+FieldByName(cFieldDetTypeID).AsString+#39+','+
                   #39+FieldByName(cFieldDetType).AsString+#39+','+
                   #39+FieldByName(cFieldTempProfile).AsString+#39+','+
                   #39+FieldByName(cFieldDetTypeComment).AsString+#39+','+
                   #39+FieldByName(cFieldMethod).AsString+#39+','+
                   #39+FieldByName(cFieldDetMeasVal).AsString+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldK1Profile).AsString),ffGeneral,6,2)+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldK2Profile).AsString),ffGeneral,6,2)+#39+','+
                   #39+FieldByName(cFieldDetKName).AsString+#39;

        if TLDDatamodule.IsDetectorTypeExist(detType) then
        begin
          UpdateDetTypeValues(strFields,strValues,IntToStr(detTypeID));
        end
        else
        begin
          ImportValues(cDBTableDetType,strFields,strValues);
        end;

        MainForm.Splash.ProgressBar.Position:=MainForm.Splash.ProgressBar.Position+1;

        Next;
      except
        on E: exception do
        begin
          WriteLog(Format('%s - "%s". %s',[rsErrAddOrRefrDetType,detType,E.Message]));
          //MessageDlg(Format('%s - "%s". %s - %s',[rsErrAddOrRefrDetType,detType,rsDetailInfoAtFile,Application.ExeName+'\'+cLogFileName]),mtError, [mbOK], 0);
          Next;
        end;
      end;
    end;

    MainForm.Splash.Close;
  end;
end;

procedure TImportDosimetersW.ImportMeasFromDBGrid;
var
  strFieldsDos : String;
  strValuesDos : String;
  strFieldsDet : String;
  strValuesDet : String;
  measID       : String;
  savedMeasID  : String;
  i,j          : integer;
  ktv                : string;
  tempProfile        : string;
  tempProfileWrite   : string;
  fon                : string;
  gaus               : string;
  autoproc           : string;

  function CheckStrNAN(Field: String; Grid: TDBGridEh): String;
  begin
    if Grid.DataSource.DataSet.FieldByName(Field).AsString <> 'NAN' then
      Result:=#39+FloatToStrRegionF(StrToFloatRegion(Grid.DataSource.DataSet.FieldByName(Field).AsString),ffGeneral,6,2)+#39
    else
      Result:='null';
  end;

  function CheckEmptyBool(Field: string; Grid: TDBGridEh): string;
  begin
    if Grid.DataSource.DataSet.FieldByName(Field).AsString <> '' then
      Result:=Grid.DataSource.DataSet.FieldByName(Field).AsString
    else
      Result:='0';
  end;

  function CheckEmptyArray300(Field: string; Grid: TDBGridEh): string;
  begin
    if Grid.DataSource.DataSet.FieldByName(Field).AsString <> '' then
      Result:=Grid.DataSource.DataSet.FieldByName(Field).AsString
    else
      Result:='{'+cProfile_Res_none+'}';
  end;

  function CheckEmptyArray302(Field: string; Grid: TDBGridEh): string;
  begin
    if Grid.DataSource.DataSet.FieldByName(Field).AsString <> '' then
      Result:=Grid.DataSource.DataSet.FieldByName(Field).AsString
    else
      Result:='{'+cProfile_none+'}';
  end;

begin
  strFieldsDos:='';
  strValuesDos:='';
  strFieldsDet:='';
  strValuesDet:='';
  ktv:='';
  tempProfile:='';
  tempProfileWrite:='';
  fon:='';
  gaus:='';
  autoproc:='';

  with DBGridEhMeas.DataSource.DataSet do
  begin
    First;

    strFieldsDos:=cFieldDosMeasID+','+
                  cFieldDosID+','+
                  cFieldDosPostfix+','+
                  cFieldDosType+','+
                  cFieldDosTypeID+','+
                  cFieldFormula+','+
                  cFieldKSI+','+
                  cFieldMeasureTime+','+
                  cFieldRegTime+','+
                  cFieldVerTime+','+
                  cFieldValidity+','+
                  cFieldDosStatus+','+
                  cField_k1+','+
                  cField_k2+','+
                  cField_k3+','+
                  cField_k4+','+
                  cField_k5+','+
                  cField_kgn+','+
                  cFieldPartID+','+
                  cFieldTldID+','+
                  cFieldSoftwareVer+','+
                  cFieldTldUser+','+
                  cFieldPersNumber+','+
                  cFieldFio+','+
                  cFieldOrg+','+
                  cFieldDepartment+','+
                  cFieldLastMeasComment+','+
                  cFieldMeasComment+','+
                  cFieldKFilter+','+
                  cFieldMeasVal+','+
                  cFieldHp10g+','+
                  cFieldHp10n+','+
                  cFieldHp3+','+
                  cFieldHp007+','+
                  cFieldHstar+','+
                  cFieldH007+','+
                  cFieldD+','+
                  cFieldFormulaId_Dos+','+
                  cFieldFormulaId_Val_1+','+
                  cFieldFormulaId_Val_2+','+
                  cFieldFormulaId_Val_3+','+
                  cFieldFormulaId_Val_4+','+
                  cFieldFormula_Err_k1_1+','+
                  cFieldFormula_Err_k2_1+','+
                  cFieldFormula_Err_k1_2+','+
                  cFieldFormula_Err_k2_2+','+
                  cFieldFormula_Err_k1_3+','+
                  cFieldFormula_Err_k2_3+','+
                  cFieldFormula_Err_k1_4+','+
                  cFieldFormula_Err_k2_4+','+
                  cFieldHp10g_err+','+
                  cFieldHp10n_err+','+
                  cFieldHp3_err+','+
                  cFieldHp007_err+','+
                  cFieldHstar_err+','+
                  cFieldH007_err+','+
                  cFieldD_err+','+
                  cFieldToDel+','+
                  cFieldDosPartName+','+
                  cFieldKDevice;

    strFieldsDet:=cFieldDosMeasID+','+
                  cFieldDetType+','+
                  cFieldDetTypeID+','+
                  cFieldDose+','+
                  cFieldDetErr+','+
                  cFieldDetPosition+','+
                  cFieldKTV+','+
                  cFieldTempProfile+','+
                  cFieldTempProfileWrite+','+
                  cFieldCalcFon+','+
                  cFieldCalcGaus+','+
                  cFieldCoefficient+','+
                  cFieldMeasureTime+','+
                  cFieldAutoProc+','+
                  cFieldDetStatus+','+
                  cFieldDetComment+','+
                  cFieldBt+','+
                  cFieldBx0+','+
                  cFieldBy0+','+
                  cFieldBxy0+','+
                  cFieldBdy+','+
                  cFieldGm1+','+
                  cFieldGa1+','+
                  cFieldGsl+','+
                  cFieldDgm2+','+
                  cFieldDga2+','+
                  cFieldGsr+','+
                  cFieldN1+','+
                  cFieldN2+','+
                  cFieldS+','+
                  cFieldPeakFound+','+
                  cFieldFonFound+','+
                  cFieldMethod+','+
                  cFieldDetTypeComment+','+
                  cFieldDetMeasVal+','+
                  cFieldDetKName+','+
                  cFieldBn1+','+
                  cFieldBn1Width+','+
                  cFieldBn2+','+
                  cFieldBn2Width+','+
                  cFieldK1Profile+','+
                  cFieldK2Profile;

    MainForm.Splash.ProgressBar.Minimum:=0;
    MainForm.Splash.ProgressBar.Maximum:=DBGridEhMeas.RowCount-2;
    MainForm.Splash.ProgressBar.Position:=0;
    MainForm.Splash.Show(false);
    MainForm.Splash.SetCaption(rsImpMeas);

    for i := 0 to DBGridEhMeas.RowCount-2 do
    begin
      try
        measID:=FieldByName(cFieldDosMeasID).AsString;
        savedMeasID:=measID;

        if TLDDataModule.IsMeasIDExist(StrToInt(measID)) then
        begin
          measID:=IntToStr(TLDDataModule.GetNewMeasID);
        end;

        if StrToInt(measID)>0 then
        begin
          strValuesDos:=#39+measID+#39+','+
                        #39+FieldByName(cFieldDosID).AsString+#39+','+
                        #39+FieldByName(cFieldDosPostfix).AsString+#39+','+
                        #39+FieldByName(cFieldDosType).AsString+#39+','+
                        #39+FieldByName(cFieldDosTypeID).AsString+#39+','+
                        #39+FieldByName(cFieldFormula).AsString+#39+','+
                        #39+FieldByName(cFieldKSI).AsString+#39+','+
                        #39+FieldByName(cFieldMeasureTime).AsString+#39+','+
                        #39+FieldByName(cFieldRegTime).AsString+#39+','+
                        #39+FieldByName(cFieldVerTime).AsString+#39+','+
                        #39+FieldByName(cFieldValidity).AsString+#39+','+
                        #39+FieldByName(cFieldDosStatus).AsString+#39+','+
                        CheckStrNAN(cField_k1,DBGridEhMeas)+','+
                        CheckStrNAN(cField_k2,DBGridEhMeas)+','+
                        CheckStrNAN(cField_k3,DBGridEhMeas)+','+
                        CheckStrNAN(cField_k4,DBGridEhMeas)+','+
                        CheckStrNAN(cField_k5,DBGridEhMeas)+','+
                        CheckStrNAN(cField_kgn,DBGridEhMeas)+','+
                        #39+FieldByName(cFieldPartID).AsString+#39+','+
                        #39+FieldByName(cFieldTldID).AsString+#39+','+
                        #39+FieldByName(cFieldSoftwareVer).AsString+#39+','+
                        #39+FieldByName(cFieldTldUser).AsString+#39+','+
                        #39+FieldByName(cFieldPersNumber).AsString+#39+','+
                        #39+FieldByName(cFieldFio).AsString+#39+','+
                        #39+FieldByName(cFieldOrg).AsString+#39+','+
                        #39+FieldByName(cFieldDepartment).AsString+#39+','+
                        #39+FieldByName(cFieldLastMeasComment).AsString+#39+','+
                        #39+FieldByName(cFieldMeasComment).AsString+#39+','+
                        CheckStrNAN(cFieldKFilter,DBGridEhMeas)+','+
                        #39+FieldByName(cFieldMeasVal).AsString+#39+','+
                        CheckStrNAN(cFieldHp10g,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldHp10n,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldHp3,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldHp007,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldHstar,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldH007,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldD,DBGridEhMeas)+','+
                        #39+FieldByName(cFieldFormulaId_Dos).AsString+#39+','+
                        #39+FieldByName(cFieldFormulaId_Val_1).AsString+#39+','+
                        #39+FieldByName(cFieldFormulaId_Val_2).AsString+#39+','+
                        #39+FieldByName(cFieldFormulaId_Val_3).AsString+#39+','+
                        #39+FieldByName(cFieldFormulaId_Val_4).AsString+#39+','+
                        CheckStrNAN(cFieldFormula_Err_k1_1,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldFormula_Err_k2_1,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldFormula_Err_k1_2,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldFormula_Err_k2_2,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldFormula_Err_k1_3,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldFormula_Err_k2_3,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldFormula_Err_k1_4,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldFormula_Err_k2_4,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldHp10g_err,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldHp10n_err,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldHp3_err,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldHp007_err,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldHstar_err,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldH007_err,DBGridEhMeas)+','+
                        CheckStrNAN(cFieldD_err,DBGridEhMeas)+','+
                        #39+FieldByName(cFieldToDel).AsString+#39+','+
                        #39+FieldByName(cFieldDosPartName).AsString+#39+','+
                        #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldKDevice).AsString),ffGeneral,6,2)+#39;

          ImportValues(cDBTableDosRes,strFieldsDos,strValuesDos);

          DBGridEhMeasDet.DataSource.DataSet.Filter:=cFieldDosMeasID+'='+savedMeasID;
          DBGridEhMeasDet.DataSource.DataSet.Filtered:=true;

          with DBGridEhMeasDet.DataSource.DataSet do
          begin
            First;

            for j := 0 to DBGridEhMeasDet.RowCount-2 do
            begin
              ktv:=CheckEmptyArray300(cFieldKTV,DBGridEhMeasDet);
              tempProfile:=CheckEmptyArray300(cFieldTempProfile,DBGridEhMeasDet);
              tempProfileWrite:=CheckEmptyArray302(cFieldTempProfileWrite,DBGridEhMeasDet);
              fon:=CheckEmptyArray300(cFieldCalcFon,DBGridEhMeasDet);
              gaus:=CheckEmptyArray300(cFieldCalcGaus,DBGridEhMeasDet);
              autoproc:=CheckEmptyBool(cFieldAutoProc,DBGridEhMeasDet);

              strValuesDet:=#39+measID+#39+','+
                            #39+FieldByName(cFieldDetType).AsString+#39+','+
                            #39+FieldByName(cFieldDetTypeID).AsString+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldDose).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldDetErr).AsString),ffGeneral,6,2)+#39+','+
                            #39+FieldByName(cFieldDetPosition).AsString+#39+','+

                            #39+ktv+#39+','+
                            #39+tempProfile+#39+','+
                            #39+tempProfileWrite+#39+','+
                            #39+fon+#39+','+
                            #39+gaus+#39+','+

//                            #39+FieldByName(cFieldKTV).AsString+#39+','+
//                            #39+FieldByName(cFieldTempProfile).AsString+#39+','+
//                            #39+FieldByName(cFieldTempProfileWrite).AsString+#39+','+
//                            #39+FieldByName(cFieldCalcFon).AsString+#39+','+
//                            #39+FieldByName(cFieldCalcGaus).AsString+#39+','+
                            #39+FieldByName(cFieldCoefficient).AsString+#39+','+
                            #39+FieldByName(cFieldMeasureTime).AsString+#39+','+

                            #39+autoproc+#39+','+

//                            #39+FieldByName(cFieldAutoProc).AsString+#39+','+
                            #39+FieldByName(cFieldDetStatus).AsString+#39+','+
                            #39+FieldByName(cFieldDetComment).AsString+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldBt).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldBx0).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldBy0).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldBxy0).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldBdy).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldGm1).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldGa1).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldGsl).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldDgm2).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldDga2).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldGsr).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldN1).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldN2).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldS).AsString),ffGeneral,6,2)+#39+','+
                            #39+FieldByName(cFieldPeakFound).AsString+#39+','+
                            #39+FieldByName(cFieldFonFound).AsString+#39+','+
                            #39+FieldByName(cFieldMethod).AsString+#39+','+
                            #39+FieldByName(cFieldDetTypeComment).AsString+#39+','+
                            #39+FieldByName(cFieldDetMeasVal).AsString+#39+','+
                            #39+FieldByName(cFieldDetKName).AsString+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldBn1).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldBn1Width).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldBn2).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldBn2Width).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldK1Profile).AsString),ffGeneral,6,2)+#39+','+
                            #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldK2Profile).AsString),ffGeneral,6,2)+#39;
              ImportValues(cDBTableDetRes,strFieldsDet,strValuesDet);
              Next;
            end;
          end;
        end
        else
        begin
          WriteLog(Format('%s - "%s"',[rsErrAddMeas,savedMeasID]));
        end;

        MainForm.Splash.ProgressBar.Position:=MainForm.Splash.ProgressBar.Position+1;

        Next;
      except
        on E: exception do
        begin
          WriteLog(Format('%s - "%s". %s',[rsErrAddMeas,savedMeasID,E.Message]));
          Next;
        end;
      end;
    end;
  end;

  MainForm.Splash.Close;

end;

procedure TImportDosimetersW.ImportDevSettingsFromDBGrid;
var
  strFields : String;
  strValues : String;
  i         : integer;
  tldid     : integer;
begin
  tldid:=-1;
  strFields:='';
  strValues:='';

  with DBGridEhDevSettings.DataSource.DataSet do
  begin
    First;

    strFields:=cFieldTldID+','+
               cFieldKSLevel+','+
               cFieldKSDelta+','+
               cFieldKFilter+','+
               cFieldKDevice;

    MainForm.Splash.ProgressBar.Minimum:=0;
    MainForm.Splash.ProgressBar.Maximum:=DBGridEhDevSettings.RowCount-2;
    MainForm.Splash.ProgressBar.Position:=0;
    MainForm.Splash.Show(false);
    MainForm.Splash.SetCaption(rsImpSettings);

    for i := 0 to DBGridEhDevSettings.RowCount-2 do
    begin
      try
        tldid:=FieldByName(cFieldTldID).AsInteger;

        strValues:=#39+FieldByName(cFieldTldID).AsString+#39+','+
                   #39+FieldByName(cFieldKSLevel).AsString+#39+','+
                   #39+FieldByName(cFieldKSDelta).AsString+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldKFilter).AsString),ffGeneral,6,2)+#39;

        // проверка на наличие поля kdev для совместимости со старыми файлами, где kdev отсутствует
        if FieldByName(cFieldKDevice).AsString.IsEmpty then
          System.Delete(strFields,pos(','+cFieldKDevice, strFields),Length(','+cFieldKDevice)) // удаляем из заголовка поле kdev, если его нет
        else
          strValues:=strValues+','+#39+FieldByName(cFieldKDevice).AsString+#39;                // если поле kdev есть, добавляем его содержимое

        if (TLDDataModule.IsDeviceIdExist(tldid)) then
        begin
          UpdateDevSettings(strFields,strValues,IntToStr(tldid));
        end
        else
        begin
          ImportValues(cDBTableSettings,strFields,strValues);
        end;

        MainForm.Splash.ProgressBar.Position:=MainForm.Splash.ProgressBar.Position+1;

        Next;
      except
        on E: exception do
        begin
          WriteLog(Format('%s - "%s". %s',[rsErrAddOrRefrSettings,IntToStr(tldid),E.Message]));
          Next;
        end;
      end;
    end;

    MainForm.Splash.Close;
  end;
end;

procedure TImportDosimetersW.ImportDosimeterTypeFromDBGrid;
var
  i                 : integer;
  dosType           : String;
  dosTypeID         : integer;
  strFields         : String;
  strValues         : String;
  detTypeIDd1       : integer;
  detTypeIDd2       : integer;
  detTypeIDd3       : integer;
  detTypeIDd4       : integer;
begin
  strFields:='';
  strValues:='';
  detTypeIDd1:=0;
  detTypeIDd2:=0;
  detTypeIDd3:=0;
  detTypeIDd4:=0;

  with DBGridEhDosType.DataSource.DataSet do
  begin
    First;

    strFields:=cFieldDosType+','+
               cFieldMeasVal+','+
               cFieldDType1+','+
               cFieldDType2+','+
               cFieldDType3+','+
               cFieldDType4+','+
               cFieldFormula+','+
               cFieldError+','+
               cFieldFormulaId_Dos+','+
               cFieldFormulaId_Val_1+','+
               cFieldFormulaId_Val_2+','+
               cFieldFormulaId_Val_3+','+
               cFieldFormulaId_Val_4+','+
               cFieldFormula_Err_k1_1+','+
               cFieldFormula_Err_k2_1+','+
               cFieldFormula_Err_k1_2+','+
               cFieldFormula_Err_k2_2+','+
               cFieldFormula_Err_k1_3+','+
               cFieldFormula_Err_k2_3+','+
               cFieldFormula_Err_k1_4+','+
               cFieldFormula_Err_k2_4;

    MainForm.Splash.ProgressBar.Minimum:=0;
    MainForm.Splash.ProgressBar.Maximum:=DBGridEhDosType.RowCount-2;
    MainForm.Splash.ProgressBar.Position:=0;
    MainForm.Splash.Show(false);
    MainForm.Splash.SetCaption('Импорт типов дозиметров');

    for i := 0 to DBGridEhDosType.RowCount-2 do
    begin
      try
        dosType:=FieldByName(cFieldDosType).AsString;
        dosTypeID:=TLDDataModule.GetDosTypeID(dosType);

        //detTypeIDd1:=TLDDataModule.GetDetTypeID(FieldByName(cFieldDType1).AsString);
        //detTypeIDd2:=TLDDataModule.GetDetTypeID(FieldByName(cFieldDType2).AsString);
        //detTypeIDd3:=TLDDataModule.GetDetTypeID(FieldByName(cFieldDType3).AsString);
        //detTypeIDd4:=TLDDataModule.GetDetTypeID(FieldByName(cFieldDType4).AsString);

        detTypeIDd1:=StrToInt(FieldByName(cFieldDType1).AsString);
        detTypeIDd2:=StrToInt(FieldByName(cFieldDType2).AsString);
        detTypeIDd3:=StrToInt(FieldByName(cFieldDType3).AsString);
        detTypeIDd4:=StrToInt(FieldByName(cFieldDType4).AsString);

        if detTypeIDd1<0 then detTypeIDd1:=0;
        if detTypeIDd2<0 then detTypeIDd2:=0;
        if detTypeIDd3<0 then detTypeIDd3:=0;
        if detTypeIDd4<0 then detTypeIDd4:=0;

        strValues:=#39+dosType+#39+','+
                   #39+FieldByName(cFieldMeasVal).AsString+#39+','+
                       IntToStr(detTypeIDd1)+','+
                       IntToStr(detTypeIDd2)+','+
                       IntToStr(detTypeIDd3)+','+
                       IntToStr(detTypeIDd4)+','+
                   #39+FieldByName(cFieldFormula).AsString+#39+','+
                   #39+FieldByName(cFieldError).AsString+#39+','+
                   #39+FieldByName(cFieldFormulaId_Dos).AsString+#39+','+
                   #39+FieldByName(cFieldFormulaId_Val_1).AsString+#39+','+
                   #39+FieldByName(cFieldFormulaId_Val_2).AsString+#39+','+
                   #39+FieldByName(cFieldFormulaId_Val_3).AsString+#39+','+
                   #39+FieldByName(cFieldFormulaId_Val_4).AsString+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldFormula_Err_k1_1).AsString),ffGeneral,6,2)+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldFormula_Err_k2_1).AsString),ffGeneral,6,2)+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldFormula_Err_k1_2).AsString),ffGeneral,6,2)+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldFormula_Err_k2_2).AsString),ffGeneral,6,2)+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldFormula_Err_k1_3).AsString),ffGeneral,6,2)+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldFormula_Err_k2_3).AsString),ffGeneral,6,2)+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldFormula_Err_k1_4).AsString),ffGeneral,6,2)+#39+','+
                   #39+FloatToStrRegionF(StrToFloatRegion(FieldByName(cFieldFormula_Err_k2_4).AsString),ffGeneral,6,2)+#39;

        if TLDDatamodule.IsDosimeterTypeExist(dosType) then
        begin
          UpdateDosTypeValues(strFields,strValues,IntToStr(dosTypeID));
        end
        else
        begin
          ImportValues(cDBTableDosType,strFields,strValues);
        end;

        MainForm.Splash.ProgressBar.Position:=MainForm.Splash.ProgressBar.Position+1;

        Next;
      except
        on E: exception do
        begin
          WriteLog(Format('%s - "%s". %s',[rsErrAddOrRefrDosType,dosType,E.Message]));
          //MessageDlg(Format('%s - "%s". %s - %s',[rsErrAddOrRefrDosType,dosType,rsDetailInfoAtFile,Application.ExeName+'\'+cLogFileName]),mtError, [mbOK], 0);
          Next;
        end;
      end;
    end;

    MainForm.Splash.Close;

  end;
end;

procedure TImportDosimetersW.ImportDosimeterIDFromDBGrid;
var
  i                    : integer;
  dosInPartCnt         : integer;
  dosInPartType        : String;
  k1,k2,k3,k4,k5,kgn   : double;
  flag                 : boolean;
begin

  with DBGridEhDosID.DataSource.DataSet do
  begin
    First;

//*    ProgressBarLoadDosList.Min:=0;
//*    ProgressBarLoadDosList.Max:=DBGridEhDosID.RowCount-2;
//*    ProgressBarLoadDosList.Visible:=true;

    MainForm.Splash.ProgressBar.Minimum:=0;
    MainForm.Splash.ProgressBar.Maximum:=DBGridEhDosID.RowCount-2;
    MainForm.Splash.ProgressBar.Position:=0;
    MainForm.Splash.Show(false);
    MainForm.Splash.SetCaption(rsImpDos);

    DosimeterConstructorForm.NewDosimeter.Tldid:=MainForm.DeviceID;

    for i := 0 to DBGridEhDosID.RowCount-2 do
    begin
      try

        DosimeterConstructorForm.NewDosimeter.DosId:=FieldByName(cFieldDosID).AsString;
        if (Trim(FieldByName(cFieldDosPostfix).AsString) = '-') OR (Trim(FieldByName(cFieldDosPostfix).AsString) = '') then
        begin
          DosimeterConstructorForm.NewDosimeter.Postfix:='-';
          DosimeterConstructorForm.NewDosimeter.FullDosID:=DosimeterConstructorForm.NewDosimeter.DosId;
        end
        else
        begin
          DosimeterConstructorForm.NewDosimeter.Postfix:=FieldByName(cFieldDosPostfix).AsString;
          DosimeterConstructorForm.NewDosimeter.FullDosID:=DosimeterConstructorForm.NewDosimeter.DosId+DosimeterConstructorForm.NewDosimeter.Postfix;
        end;

        DosimeterConstructorForm.NewDosimeter.DosType:=FieldByName(cFieldDosType).AsString;
        DosimeterConstructorForm.NewDosimeter.DosTypeID:=TLDDataModule.GetDosTypeID(DosimeterConstructorForm.NewDosimeter.DosType);

        if DosimeterConstructorForm.NewDosimeter.DosTypeID > 0 then
        begin
          if (not FieldByName(cField_k1).IsNull) AND (FieldByName(cField_k1).AsString <> 'NAN') then DosimeterConstructorForm.NewDosimeter.K1:=RoundToCN(StrToFloatRegion(FieldByName(cField_k1).AsString),-2) else DosimeterConstructorForm.NewDosimeter.K1:=NaN;
          if (not FieldByName(cField_k2).IsNull) AND (FieldByName(cField_k2).AsString <> 'NAN') then DosimeterConstructorForm.NewDosimeter.K2:=RoundToCN(StrToFloatRegion(FieldByName(cField_k2).AsString),-2) else DosimeterConstructorForm.NewDosimeter.K2:=NaN;
          if (not FieldByName(cField_k3).IsNull) AND (FieldByName(cField_k3).AsString <> 'NAN') then DosimeterConstructorForm.NewDosimeter.K3:=RoundToCN(StrToFloatRegion(FieldByName(cField_k3).AsString),-2) else DosimeterConstructorForm.NewDosimeter.K3:=NaN;
          if (not FieldByName(cField_k4).IsNull) AND (FieldByName(cField_k4).AsString <> 'NAN') then DosimeterConstructorForm.NewDosimeter.K4:=RoundToCN(StrToFloatRegion(FieldByName(cField_k4).AsString),-2) else DosimeterConstructorForm.NewDosimeter.K4:=NaN;
          if (not FieldByName(cField_k5).IsNull) AND (FieldByName(cField_k5).AsString <> 'NAN') then DosimeterConstructorForm.NewDosimeter.K5:=RoundToCN(StrToFloatRegion(FieldByName(cField_k5).AsString),-2) else DosimeterConstructorForm.NewDosimeter.K5:=NaN;
          if (not FieldByName(cField_kgn).IsNull) AND (FieldByName(cField_kgn).AsString <> 'NAN') then DosimeterConstructorForm.NewDosimeter.Kgn:=RoundToCN(StrToFloatRegion(FieldByName(cField_kgn).AsString),-2) else DosimeterConstructorForm.NewDosimeter.Kgn:=NaN;

          DosimeterConstructorForm.NewDosimeter.Organization:=FieldByName(cFieldOrg).AsString;
          DosimeterConstructorForm.NewDosimeter.Department:=FieldByName(cFieldDepartment).AsString;

          if (not (DosimeterConstructorForm.NewDosimeter.K1.IsNan)) AND (DosimeterConstructorForm.NewDosimeter.K1<0) OR
             (not (DosimeterConstructorForm.NewDosimeter.K2.IsNan)) AND (DosimeterConstructorForm.NewDosimeter.K2<0) OR
             (not (DosimeterConstructorForm.NewDosimeter.K3.IsNan)) AND (DosimeterConstructorForm.NewDosimeter.K3<0) OR
             (not (DosimeterConstructorForm.NewDosimeter.K4.IsNan)) AND (DosimeterConstructorForm.NewDosimeter.K4<0) OR
             (not (DosimeterConstructorForm.NewDosimeter.K5.IsNan)) AND (DosimeterConstructorForm.NewDosimeter.K5<0) OR
             (not (DosimeterConstructorForm.NewDosimeter.Kgn.IsNan)) AND (DosimeterConstructorForm.NewDosimeter.Kgn<0) then
          begin
            DosimeterConstructorForm.NewDosimeter.Status:=cDosNotCalibrated;
          end
          else
          begin
            DosimeterConstructorForm.NewDosimeter.Status:=cDosCalibrated;
            DosimeterConstructorForm.NewDosimeter.Vertime:=Now;
          end;

          DosimeterConstructorForm.NewDosimeter.PartName:=FieldByName(cFieldDosPartName).AsString;

          if (Trim(DosimeterConstructorForm.NewDosimeter.PartName) <> '-') AND (Trim(DosimeterConstructorForm.NewDosimeter.PartName) <> '') then
          begin
            if TLDDataModule.IsDosimeterPartExist(DosimeterConstructorForm.NewDosimeter.PartName,MainForm.DeviceID) then   // проверка на партию
            begin
              DosimeterConstructorForm.NewDosimeter.Partid:=TLDDataModule.GetPartID(DosimeterConstructorForm.NewDosimeter.PartName,MainForm.DeviceID);
              dosInPartType:=TLDDataModule.GetDosTypeInPart(DosimeterConstructorForm.NewDosimeter.Partid);

              if (DosimeterConstructorForm.NewDosimeter.DosType=dosInPartType) then                      // проверка на тип
              begin
                TLDDataModule.GetKFromPart(DosimeterConstructorForm.NewDosimeter.PartName,
                                           k1,
                                           k2,
                                           k3,
                                           k4,
                                           k5,
                                           kgn);
                flag:=false;

                if not (DosimeterConstructorForm.NewDosimeter.K1.IsNan) then
                  if (DosimeterConstructorForm.NewDosimeter.K1=k1) then flag:=true else flag:=false;

                if not (DosimeterConstructorForm.NewDosimeter.K2.IsNan) then
                  if (DosimeterConstructorForm.NewDosimeter.K2=k2) then flag:=true else flag:=false;

                if not (DosimeterConstructorForm.NewDosimeter.K3.IsNan) then
                  if (DosimeterConstructorForm.NewDosimeter.K3=k3) then flag:=true else flag:=false;

                if not (DosimeterConstructorForm.NewDosimeter.K4.IsNan) then
                  if (DosimeterConstructorForm.NewDosimeter.K4=k4) then flag:=true else flag:=false;

                if not (DosimeterConstructorForm.NewDosimeter.K5.IsNan) then
                  if (DosimeterConstructorForm.NewDosimeter.K5=k5) then flag:=true else flag:=false;

                if not (DosimeterConstructorForm.NewDosimeter.Kgn.IsNan) then
                  if (DosimeterConstructorForm.NewDosimeter.Kgn=kgn) then flag:=true else flag:=false;

                if flag then
                begin
                  dosInPartCnt:=TLDDataModule.GetDosCntInPart(DosimeterConstructorForm.NewDosimeter.Partid);
                  inc(dosInPartCnt);
                  TLDDataModule.SetDosCntInPart(DosimeterConstructorForm.NewDosimeter.Partid,dosInPartCnt);
                end
                else
                begin
                  MessageDlg(Format('%s. ',[rsErrDifferentKInPart])+Format(rsErrDosWillNotBeAdded,[DosimeterConstructorForm.NewDosimeter.FullDosID,DosimeterConstructorForm.NewDosimeter.PartName]),mtError, [mbOK], 0);
                  WriteLog(Format('%s. ',[rsErrDifferentKInPart])+Format(rsErrDosWillNotBeAdded,[DosimeterConstructorForm.NewDosimeter.FullDosID,DosimeterConstructorForm.NewDosimeter.PartName]));
                  DosimeterConstructorForm.NewDosimeter.Partid:=0;
                end;
              end
              else
              begin
                MessageDlg(Format('%s. ',[rsErrDifferentTypeInPart])+Format(rsErrDosWillNotBeAdded,[DosimeterConstructorForm.NewDosimeter.FullDosID,DosimeterConstructorForm.NewDosimeter.PartName]),mtError, [mbOK], 0);
                WriteLog(Format('%s. ',[rsErrDifferentTypeInPart])+Format(rsErrDosWillNotBeAdded,[DosimeterConstructorForm.NewDosimeter.FullDosID,DosimeterConstructorForm.NewDosimeter.PartName]));
                DosimeterConstructorForm.NewDosimeter.Partid:=0;
              end;
            end
            else
            begin
              // формировать новую партию
              DosimeterConstructorForm.NewDosimeter.Partid:=0;
              if TLDDataModule.AddNewDosPart(DosimeterConstructorForm.NewDosimeter.PartName,
                                                   DosimeterConstructorForm.NewDosimeter.K1,
                                                   DosimeterConstructorForm.NewDosimeter.K2,
                                                   DosimeterConstructorForm.NewDosimeter.K3,
                                                   DosimeterConstructorForm.NewDosimeter.K4,
                                                   DosimeterConstructorForm.NewDosimeter.K5,
                                                  DosimeterConstructorForm.NewDosimeter.Kgn,
                                                                                          1,
                                              DosimeterConstructorForm.NewDosimeter.DosType,
                                              DosimeterConstructorForm.NewDosimeter.Vertime) then
              begin
                DosimeterConstructorForm.NewDosimeter.Partid:=TLDDataModule.GetPartID(DosimeterConstructorForm.NewDosimeter.PartName,MainForm.DeviceID);
                WriteLog(Format(rsNewPartyAdded,[DosimeterConstructorForm.NewDosimeter.PartName]));
              end;
            end;

          end
          else
            DosimeterConstructorForm.NewDosimeter.Partid:=0;

          if TLDDataModule.IsDosimeterExist(DosimeterConstructorForm.NewDosimeter.FullDosID) then
          begin
            if TLDDataModule.UpdateDosimeterInLibrary(DosimeterConstructorForm.NewDosimeter.DosId,
                                                      DosimeterConstructorForm.NewDosimeter.Postfix,
                                                      IntToStr(DosimeterConstructorForm.NewDosimeter.DosTypeId),
                                                      DosimeterConstructorForm.NewDosimeter.DosType,
                                                      IntToStr(DosimeterConstructorForm.NewDosimeter.Status),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.K1),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.K2),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.K3),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.K4),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.K5),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.Kgn),
                                                      IntToStr(DosimeterConstructorForm.NewDosimeter.Tldid),
                                                      IntToStr(DosimeterConstructorForm.NewDosimeter.Partid),
                                                      DateTimeToStr(Now),
                                                      DateTimeToStr(DosimeterConstructorForm.NewDosimeter.Vertime),
                                                      DosimeterConstructorForm.NewDosimeter.Organization,
                                                      DosimeterConstructorForm.NewDosimeter.Department
                                                      ) then
            begin
              WriteLog(Format('%s - "%s"',[rsDosimeterRefreshed,DosimeterConstructorForm.NewDosimeter.FullDosID]));
              AddToLog(Format('%s - "%s"',[rsImpUpdateDos,DosimeterConstructorForm.NewDosimeter.FullDosID]),lgWarning);
            end
            else
              WriteLog(Format('%s - "%s"',[rsErrDosimeterRefreshed,DosimeterConstructorForm.NewDosimeter.FullDosID]))
          end
          else
          begin
            if TLDDataModule.InsertDosimeterInLibrary(DosimeterConstructorForm.NewDosimeter.DosId,
                                                      DosimeterConstructorForm.NewDosimeter.Postfix,
                                                      IntToStr(DosimeterConstructorForm.NewDosimeter.DosTypeId),
                                                      DosimeterConstructorForm.NewDosimeter.DosType,
                                                      IntToStr(DosimeterConstructorForm.NewDosimeter.Status),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.K1),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.K2),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.K3),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.K4),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.K5),
                                                      FloatToStrRegion(DosimeterConstructorForm.NewDosimeter.Kgn),
                                                      IntToStr(DosimeterConstructorForm.NewDosimeter.Tldid),
                                                      IntToStr(DosimeterConstructorForm.NewDosimeter.Partid),
                                                      DateTimeToStr(Now),
                                                      DateTimeToStr(DosimeterConstructorForm.NewDosimeter.Vertime),
                                                      DosimeterConstructorForm.NewDosimeter.Organization,
                                                      DosimeterConstructorForm.NewDosimeter.Department
                                                      ) then
            begin
              WriteLog(Format('%s - "%s"',[rsDosimeterAdded,DosimeterConstructorForm.NewDosimeter.FullDosID]));
              AddToLog(Format('%s - "%s"',[rsImpAddRecordSuccess,DosimeterConstructorForm.NewDosimeter.FullDosID]),lgSuccess);
            end
            else
              WriteLog(Format('%s - "%s"',[rsErrDosimeterAdded,DosimeterConstructorForm.NewDosimeter.FullDosID]));
          end;

          MainForm.Splash.ProgressBar.Position:=MainForm.Splash.ProgressBar.Position+1;

          Next;
        end
        else
        begin
          MessageDlg(Format('%s - "%s". %s - "%s"',[rsErrAddOrRefrDos,DosimeterConstructorForm.NewDosimeter.FullDosID,rsErrDosType,DosimeterConstructorForm.NewDosimeter.DosType]),mtError, [mbOK], 0);
          WriteLog(Format('%s - "%s". %s - "%s"',[rsErrAddOrRefrDos,DosimeterConstructorForm.NewDosimeter.FullDosID,rsErrDosType,DosimeterConstructorForm.NewDosimeter.DosType]));
          Next;
        end;
      except
        on E: exception do
        begin
          WriteLog(Format('%s - "%s". %s',[rsErrAddOrRefrDos,DosimeterConstructorForm.NewDosimeter.FullDosID,E.Message]));
          MessageDlg(Format('%s - "%s". %s - %s',[rsErrAddOrRefrDos,DosimeterConstructorForm.NewDosimeter.FullDosID,rsDetailInfoAtFile,Application.ExeName+PathDelim+cLogFileName]),mtError, [mbOK], 0);
        end;
      end;
    end;

    MainForm.Splash.Close;

    //**ProgressBarLoadDosList.Position:=0;
    //**ProgressBarLoadDosList.Visible:=false;

  end;
end;

procedure TImportDosimetersW.ImportValues(Table,FieldsString, ValuesString: String);
var
  s: String;
begin
  if IsDBConnected then
  try
//    s:=TLDDataModule.ADOQuery.Connection.ConnectionString;
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('INSERT INTO '+Table+' ('+FieldsString+')'+'VALUES('+ValuesString+')');
    TLDDataModule.ADOQuery.ExecSQL;
    AddToLog(Format('%s - %s.',[rsImpAddRecordSuccess,ValuesString]),lgSuccess);
  except
    on E: exception do
    begin
      AddToLog(Format('%s - %s.%s',[rsImpAddRecordErr,ValuesString,E.Message]),lgError);
    end;
  end;
end;

procedure TImportDosimetersW.ImportDetValues(Table, FieldsString, ValuesString: String);
var
  s: String;
begin
  if IsDBConnected then
  try
//    s:=TLDDataModule.ADOQueryExportDet.Connection.ConnectionString;
    TLDDataModule.ADOQueryExportDet.Active:=False;
    TLDDataModule.ADOQueryExportDet.SQL.Clear;
    TLDDataModule.ADOQueryExportDet.SQL.Add('INSERT INTO '+Table+' ('+FieldsString+')'+'VALUES('+ValuesString+')');
    TLDDataModule.ADOQueryExportDet.ExecSQL;
    AddToLog(Format('%s - %s.',[rsImpAddRecordSuccess,ValuesString]),lgSuccess);
  except
    on E: exception do
    begin
      AddToLog(Format('%s - %s.%s',[rsImpAddRecordErr,ValuesString,E.Message]),lgError);
    end;
  end;
end;

procedure TImportDosimetersW.UpdateDosTypeValues(FieldsString, ValuesString, DosTypeID: String);
begin
  if IsDBConnected then
  try
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosType+' SET ('+FieldsString+')'+'=('+ValuesString+') WHERE '+cFieldDosTypeID+' = '+DosTypeID);
    TLDDataModule.ADOQuery.ExecSQL;
    AddToLog(Format('%s - %s %s.',[rsImpUpdateDosTypeSuccess,DosTypeID,ValuesString]),lgWarning);
  except
    on E: exception do
    begin
      AddToLog(Format('%s - %s.%s',[rsImpUpdateDosTypeErr,DosTypeID,E.Message]),lgError);
    end;
  end;
end;

procedure TImportDosimetersW.UpdateDetTypeValues(FieldsString, ValuesString, DetTypeID: String);
begin
  if IsDBConnected then
  try
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDetType+' SET ('+FieldsString+')'+'=('+ValuesString+') WHERE '+cFieldDetTypeID+' = '+DetTypeID);
    TLDDataModule.ADOQuery.ExecSQL;
    AddToLog(Format('%s - %s %s.',[rsImpUpdateDetTypeSuccess,DetTypeID,ValuesString]),lgWarning);
  except
    on E: exception do
    begin
      AddToLog(Format('%s - %s.%s',[rsImpUpdateDetTypeErr,DetTypeID,E.Message]),lgError);
    end;
  end;
end;

procedure TImportDosimetersW.UpdateDevSettings(FieldsString, ValuesString, DevID: String);
begin
  if IsDBConnected then
  try
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableSettings+' SET ('+FieldsString+')'+'=('+ValuesString+') WHERE '+cFieldTldID+' = '+DevID);
    TLDDataModule.ADOQuery.ExecSQL;
    AddToLog(Format('%s - %s %s.',['Выполнено обновление настроек установки',DevID,ValuesString]),lgWarning);
  except
    on E: exception do
    begin
      AddToLog(Format('%s - %s.%s',['Ошибка обновления настроек установки',DevID,E.Message]),lgError);
    end;
  end;
end;

procedure TImportDosimetersW.UpdateDosIDValues(FieldsString, ValuesString, DosID, Postfix: String);
begin
  if IsDBConnected then
  try
    TLDDataModule.ADOQuery.Active:=False;
    TLDDataModule.ADOQuery.SQL.Clear;
    TLDDataModule.ADOQuery.SQL.Add('UPDATE '+cDBTableDosID+' SET ('+FieldsString+')'+'=('+ValuesString+') WHERE '+cFieldDosID+' = '+DosID+' AND '+cFieldDosPostfix+'='+#39+Postfix+#39);
    TLDDataModule.ADOQuery.ExecSQL;
    AddToLog(Format('%s - %s %s.',[rsImpUpdateDos,DosID+Postfix,ValuesString]),lgWarning);
  except
    on E: exception do
    begin
      AddToLog(Format('%s - %s.%s',[rsImpUpdateDosErr,DosID+Postfix,E.Message]),lgError);
    end;
  end;
end;

function TImportDosimetersW.CreateBackupTable(TableName: String): boolean;
var
  isCreated : boolean;
begin
  isCreated:=false;

  if IsDBConnected then
  begin
    if not IsTableExists(TableName+cDBTableBackUp) then
    begin
      try
        TLDDataModule.ADOQuery.Active:=False;
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add('CREATE TABLE '+TableName+cDBTableBackUp+' ( like '+TableName+' including all);'
                                            +'INSERT INTO '+TableName+cDBTableBackUp+' select * from '+TableName);
        TLDDataModule.ADOQuery.ExecSQL;
        isCreated:=IsTableExists(TableName+cDBTableBackUp);
      except
        on E: exception do
        begin
          AddToLog(Format('%s - %s.%s',[rsImpBackupTableErr,TableName,E.Message]),lgError);
        end;
      end;
    end
    else
      isCreated:=false;
  end;

  Result:=isCreated;
end;

procedure TImportDosimetersW.DBGridEhDosIDKeyPress(Sender: TObject; var Key: Char);
begin
  if (Sender as TDbGridEh).SelectedField.FieldName = cFieldDosID then
  case Key of
    '0'..'9' :
      Key:=Key;
    #8:           // backspace
      Key:=Key;
    else
      Key:=#0;
  end;
  if ((Sender as TDbGridEh).SelectedField.FieldName = cField_k1) OR
     ((Sender as TDbGridEh).SelectedField.FieldName = cField_k2) OR
     ((Sender as TDbGridEh).SelectedField.FieldName = cField_k3) OR
     ((Sender as TDbGridEh).SelectedField.FieldName = cField_k4) OR
     ((Sender as TDbGridEh).SelectedField.FieldName = cField_k5) OR
     ((Sender as TDbGridEh).SelectedField.FieldName = cField_kgn)
  then
  begin
    case Key of
      '0'..'9':
        Key:=Key;
      ',','.':
        Key:=Key;
      #8:           // backspace
        Key:=Key;
      else
        Key:=#0;
    end;
  end;

  if (Sender as TDbGridEh).SelectedField.FieldName = cFieldDosPostfix then
  case Key of
    ',','.','{','}','[',']','(',')','/','\','"','''',':',';','|':
      Key:=#0
    else
      Key:=Key;
  end;

end;

function TImportDosimetersW.DropTable(TableName: String): boolean;
var
  isDroped : boolean;
begin
  isDroped:=false;

  if IsDBConnected then
  begin
    if IsTableExists(TableName) then
    begin
      try
        TLDDataModule.ADOQuery.Active:=False;
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add('DROP TABLE IF EXISTS '+TableName+' CASCADE');
        TLDDataModule.ADOQuery.ExecSQL;

        if not IsTableExists(TableName) then
          isDroped:=true
        else
          isDroped:=false;
      except
        on E: exception do
        begin
          AddToLog(Format('%s - %s.%s',[rsImpDropTableErr,TableName,E.Message]),lgError);
        end;
      end;
    end
    else
      isDroped:=true;
  end;

  Result:=isDroped;
end;

function TImportDosimetersW.IsDBConnected: boolean;
begin
  //if TLDDataModule.IsConnected and (TLDDataModule.DBName <> 'postgres') then
  if TLDDataModule.IsDBConnected then
  begin
    result:=true;
  end
  else
  begin
    result:=false;
    AddToLog(rsDBNoConnection,lgError);
  end;
end;

function TImportDosimetersW.IsTableExists(TableName: String): boolean;
const
  cResField = 'res';
var
  isExist : boolean;
begin
  isExist:=false;

  if IsDBConnected then
  begin
    try
      TLDDataModule.ADOQuery.Active:=False;
      TLDDataModule.ADOQuery.SQL.Clear;
      TLDDataModule.ADOQuery.SQL.Add('SELECT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name =' +#39+TableName+#39+') AS '+cResField);
      TLDDataModule.ADOQuery.Open;

      isExist:=TLDDataModule.ADOQuery.FieldByName(cResField).Value;

      TLDDataModule.ADOQuery.Close;
    except
      on E: exception do
      begin
        AddToLog(Format('%s - %s.%s',[rsImpTableExistErr,TableName,E.Message]),lgError);
      end;
    end;
  end;

  Result:=isExist;
end;

procedure TImportDosimetersW.LoadDBGrids;
var
  path      : String;
  fullPath  : String;
begin
  path:=extractfilepath(Application.ExeName)+cFolderLibrary+PathDelim;

  OpenDialogList.InitialDir:=path;

  fullPath:=extractfilepath(Application.ExeName)+cFolderLibrary+PathDelim+cFileNameDosimeterTypes;
  if FileExists(fullPath) then
  begin
    MemTableEhDosType.Open;
    MemTableEhDosType.EmptyTable;
    DataSetTextImporterEhDosType.ImportFromFile(fullPath);
    TabSheetDosTypeList.TabVisible:=true;
    FileDosTypeLoaded:=true;
  end
  else
  begin
    TabSheetDosTypeList.TabVisible:=false;
    FileDosTypeLoaded:=false;
  end;

  fullPath:=extractfilepath(Application.ExeName)+cFolderLibrary+PathDelim+cFileNameDetectorTypes;
  if FileExists(fullPath) then
  begin
    MemTableEhDetType.Open;
    MemTableEhDetType.EmptyTable;
    DataSetTextImporterEhDetType.ImportFromFile(fullPath);
    TabSheetDetTypeList.TabVisible:=true;
    FileDetTypeLoaded:=true;
  end
  else
  begin
    TabSheetDetTypeList.TabVisible:=false;
    FileDetTypeLoaded:=false;
  end;
end;

procedure TImportDosimetersW.LoadGrid(Grid: TStringGrid; FileName: String; Separator: char);
var
  f       : TextFile;
  s1, s2  : String;
  i, j    : integer;
begin
  i:=0;

  AssignFile(f, FileName);
  Reset(f);
  while not eof(f) do
  begin
    readln(f,s1);

    i:=i+1;
    j:=0;

    while pos(separator, s1)<>0 do
    begin
      s2 := copy(s1,1,pos(Separator, s1)-1);
      j := j + 1;
      delete (s1, 1, pos(Separator, S1));
      Grid.Cells[j-1, i-1] := s2;
    end;

    if pos (Separator, s1)=0 then
    begin
      j := j + 1;
      Grid.Cells[j-1, i-1] := s1;
    end;

    Grid.ColCount := j;
    Grid.RowCount := i;

  end;

  CloseFile(f);
end;

procedure TImportDosimetersW.LoadSQL;
const
  cSQL = 'SQL.txt';
var
  f           : TextFile;
  SQLString   : String;
  strLine     : String;
  fullPath    : String;
begin
  strLine:='';
  SQLString:='';
  fullPath:=extractfilepath(Application.ExeName)+cFolderLibrary+PathDelim+cSQL;

  if FileExists(fullPath) then
  begin
    AssignFile(f, fullPath);
    Reset(f);
    while not eof(f) do
    begin
      readln(f,strLine);
      SQLString:=SQLString+strLine+cCRLF;
    end;

    CloseFile(f);

    if IsDBConnected then
    begin
      try
        TLDDataModule.ADOQuery.Active:=False;
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add(SQLString);
        TLDDataModule.ADOQuery.ExecSQL;
        AddToLog(Format('%s - %s',[rsImpSQLScriptSuccess,SQLString]),lgInformation);
      except
        on E: exception do
        begin
          AddToLog(Format('%s. %s',[rsImpSQLScriptErr,E.Message]),lgError);
        end;
      end;
    end;
  end;

end;

procedure TImportDosimetersW.LogClearClick(Sender: TObject);
begin
  ImportProcessW.MemoLog.Lines.Clear;
end;

function TImportDosimetersW.RenameTable(TableNameOld,TableNameNew: String): boolean;
var
  isRenamed : boolean;
begin
  isRenamed:=false;

  if IsDBConnected then
  begin
    if IsTableExists(TableNameOld) then
    begin
      try
        TLDDataModule.ADOQuery.Active:=False;
        TLDDataModule.ADOQuery.SQL.Clear;
        TLDDataModule.ADOQuery.SQL.Add('ALTER TABLE '+TableNameOld+' RENAME TO '+TableNameNew);
        TLDDataModule.ADOQuery.ExecSQL;

        if not IsTableExists(TableNameNew) then
          isRenamed:=true
        else
          isRenamed:=false;
      except
        on E: exception do
        begin
          AddToLog(Format('%s - %s.%s',[rsImpRanameTableErr,TableNameOld,E.Message]),lgError);
        end;
      end;
    end
    else
      isRenamed:=true;
  end;

  Result:=isRenamed;
end;

procedure TImportDosimetersW.SetFileDetMeasLoaded(const Value: boolean);
begin
  FFileDetMeasLoaded := Value;
end;

procedure TImportDosimetersW.SetFileDetTypeLoaded(const Value: boolean);
begin
  FFileDetTypeLoaded:=Value;
end;

procedure TImportDosimetersW.SetFileDevSettingsLoaded(const Value: boolean);
begin
  FFileDevSettingsLoaded:=Value;
end;

procedure TImportDosimetersW.SetFileDosIDLoaded(const Value: boolean);
begin
  FFileDosIDLoaded:=Value;
end;

procedure TImportDosimetersW.SetFileDosMeasLoaded(const Value: boolean);
begin
  FFileDosMeasLoaded:=Value;
end;

procedure TImportDosimetersW.SetFileDosTypeLoaded(const Value: boolean);
begin
  FFileDosTypeLoaded:=Value;
end;

procedure TImportDosimetersW.SetLoadFromFile(const Value: boolean);
begin
  FLoadFromFile:=Value;
  LblFileLoadedDosID.Visible:=Value;
  EditLoadListDosID.Visible:=Value;
  BtnOpenDosID.Visible:=Value;
end;

end.
