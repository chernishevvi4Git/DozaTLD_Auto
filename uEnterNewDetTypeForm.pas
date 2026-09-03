unit uEnterNewDetTypeForm;

interface

uses
//  Messages,System.UITypes,
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  uFunctions;

type

  { TEnterNewDetTypeForm }

  TEnterNewDetTypeForm = class(TForm)
    PanelBackGround: TPanel;
    LblEnterDetTypeName: TLabel;
    LblDetTypeAlreadyExist: TLabel;
    EditDetTypeName: TEdit;
    BtnOk: TButton;
    BtnCancel: TButton;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure EditDetTypeNameKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EnterNewDetTypeForm: TEnterNewDetTypeForm;

implementation
uses
  uConst,
  uDetectorConstructorForm,
  uLanguages,
  uDataModule;

{$R *.dfm}

procedure TEnterNewDetTypeForm.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TEnterNewDetTypeForm.EditDetTypeNameKeyPress(Sender: TObject; var Key: char);
begin
  Key:=NoSpecialSymbols(Key);
end;

procedure TEnterNewDetTypeForm.BtnOkClick(Sender: TObject);
var
  newDetType: String;
begin
  newDetType:=EditDetTypeName.Text;

  if Trim(newDetType)<>'' then
  begin
    if not TLDDataModule.IsDetectorTypeExist(newDetType) then
    begin
      if TLDDataModule.InsertNewDetType(newDetType) then
      begin
        if LblDetTypeAlreadyExist.Visible then LblDetTypeAlreadyExist.Visible:=false;

        DetectorConstructorForm.EditPreHeatTime.Clear;
        DetectorConstructorForm.EditPreHeatTemp.Clear;
        DetectorConstructorForm.EditMeasuringTime.Clear;
        DetectorConstructorForm.EditMeasuringTemp.Clear;
        DetectorConstructorForm.EditBurnTime.Clear;
        DetectorConstructorForm.EditBurnTemp.Clear;
        DetectorConstructorForm.EditMeasuringSpeed.Clear;
        DetectorConstructorForm.RefreshDetTypeList;
        DetectorConstructorForm.DBGridEhDetType.DataSource.DataSet.Last;
        DetectorConstructorForm.LoadTempProfile;
        Close;
      end
      else
        MessageDlg(Format('%s "%s". %s - %s',['Не удалось добавить новый тип детектора',newDetType,'Подробная информация в файле',Application.ExeName+PathDelim+cLogFileName]),mtError,[mbOK],0);
    end
    else
    begin
      LblDetTypeAlreadyExist.Caption:='Название типа уже существует';
      if not LblDetTypeAlreadyExist.Visible then LblDetTypeAlreadyExist.Visible:=true;
    end;
  end
  else
  begin
    LblDetTypeAlreadyExist.Caption:='Укажите название типа';
    if not LblDetTypeAlreadyExist.Visible then LblDetTypeAlreadyExist.Visible:=true;
  end;
end;

procedure TEnterNewDetTypeForm.FormShow(Sender: TObject);
begin
  EditDetTypeName.Clear;
end;

end.
