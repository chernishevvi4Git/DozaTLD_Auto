unit uEnterNewDosPartForm;

interface

uses
//  Messages,
  SysUtils, Variants, Classes, Graphics,System.UITypes,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  uFunctions;

type

  { TEnterNewDosPartForm }

  TEnterNewDosPartForm = class(TForm)
    PanelBackGround: TPanel;
    LblEnterDosPartName: TLabel;
    LblDosPartAlreadyExist: TLabel;
    EditDosPartName: TEdit;
    BtnOk: TButton;
    BtnCancel: TButton;
    procedure BtnCancelClick(Sender: TObject);
    procedure EditDosPartNameKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EnterNewDosPartForm: TEnterNewDosPartForm;

implementation
uses
  uConst,
  uDosimeterPartForm,
  uMainForm,
  uLanguages,
  uDataModule;
{$R *.dfm}

procedure TEnterNewDosPartForm.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TEnterNewDosPartForm.EditDosPartNameKeyPress(Sender: TObject; var Key: char);
begin
  Key:=NoSpecialSymbolsForPartName(Key);
end;

procedure TEnterNewDosPartForm.BtnOkClick(Sender: TObject);
var
  newDosPart: String;
begin
  newDosPart:=EditDosPartName.Text;

  if Trim(newDosPart)<>'' then
  begin
    if not TLDDataModule.IsDosimeterPartExist(newDosPart,MainForm.DeviceID) then
    begin
      if TLDDataModule.InsertNewDosPart(newDosPart) then
      begin
        if LblDosPartAlreadyExist.Visible then LblDosPartAlreadyExist.Visible:=false;

        DosimeterPartForm.RefreshDosPartList;
        DosimeterPartForm.LoadPartParameters;

//        MainForm.LoadDosPartCB(MainForm.ADOQueryDosList,MainForm.CBDosPart);
        MainForm.GetDosData;
        Close;
      end
      else
        MessageDlg(Format('%s "%s". %s - %s',['Не удалось добавить новую партию',newDosPart,'Подробная информация в файле',Application.ExeName+PathDelim+cLogFileName]),mtError,[mbOK],0);
    end
    else
    begin
      LblDosPartAlreadyExist.Caption:='Название партии уже существует';
      if not LblDosPartAlreadyExist.Visible then LblDosPartAlreadyExist.Visible:=true;
    end;
  end
  else
  begin
    LblDosPartAlreadyExist.Caption:='Укажите название партии';
    if not LblDosPartAlreadyExist.Visible then LblDosPartAlreadyExist.Visible:=true;
  end;

end;

procedure TEnterNewDosPartForm.FormShow(Sender: TObject);
begin
  EditDosPartName.Clear;
  if LblDosPartAlreadyExist.Visible then  LblDosPartAlreadyExist.Visible:=false;
end;

end.
