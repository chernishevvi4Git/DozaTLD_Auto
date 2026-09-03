unit uEnterNewDosTypeForm;

interface

uses
  Messages, SysUtils,System.UITypes, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
  uFunctions;

type

  { TEnterNewDosTypeForm }

  TEnterNewDosTypeForm = class(TForm)
    PanelBackGround: TPanel;
    LblEnterDosTypeName: TLabel;
    EditDosTypeName: TEdit;
    LblDosTypeAlreadyExist: TLabel;
    BtnOk: TButton;
    BtnCancel: TButton;
    procedure BtnCancelClick(Sender: TObject);
    procedure EditDosTypeNameKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EnterNewDosTypeForm: TEnterNewDosTypeForm;

implementation
uses
  uConst,
  uDosimeterTypeConstructorForm,
  uLanguages,
  uDataModule;

{$R *.dfm}

procedure TEnterNewDosTypeForm.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TEnterNewDosTypeForm.EditDosTypeNameKeyPress(Sender: TObject; var Key: char);
begin
  Key:=NoSpecialSymbols(Key);
end;

procedure TEnterNewDosTypeForm.BtnOkClick(Sender: TObject);
var
  newDosType: String;
begin
  newDosType:=EditDosTypeName.Text;

  if Trim(newDosType)<>'' then
  begin
    if not TLDDataModule.IsDosimeterTypeExist(newDosType) then
    begin
      if TLDDataModule.InsertNewDosType(newDosType) then
      begin
        if LblDosTypeAlreadyExist.Visible then LblDosTypeAlreadyExist.Visible:=false;

        DosimeterTypeConstructorForm.RefreshDosTypeList;
        DosimeterTypeConstructorForm.DBGridEhDosType.DataSource.DataSet.Last;
        DosimeterTypeConstructorForm.LoadDosTypeParameters;
        DosimeterTypeConstructorForm.CBoxDetsCnt.ItemIndex:=DosimeterTypeConstructorForm.CBoxDetsCnt.Items.IndexOf(IntToStr(cDetPos4));
        DosimeterTypeConstructorForm.CBoxDetsCnt.OnChange(Self);
        DosimeterTypeConstructorForm.UpdateDosType;
        Close;
      end
      else
        MessageDlg(Format('%s "%s". %s - %s',['Не удалось добавить новый тип дозиметра',newDosType,'Подробная информация в файле',Application.ExeName+PathDelim+cLogFileName]),mtError,[mbOK],0);
    end
    else
    begin
      LblDosTypeAlreadyExist.Caption:='Название типа уже существует';
      if not LblDosTypeAlreadyExist.Visible then LblDosTypeAlreadyExist.Visible:=true;
    end;
  end
  else
  begin
    LblDosTypeAlreadyExist.Caption:='Укажите название типа';
    if not LblDosTypeAlreadyExist.Visible then LblDosTypeAlreadyExist.Visible:=true;
  end;
end;

procedure TEnterNewDosTypeForm.FormShow(Sender: TObject);
begin
  EditDosTypeName.Clear;
  if LblDosTypeAlreadyExist.Visible then  LblDosTypeAlreadyExist.Visible:=false;
end;

end.
