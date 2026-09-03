object EnterNewDetTypeForm: TEnterNewDetTypeForm
  Left = 0
  Height = 177
  Top = 0
  Width = 401
  BorderStyle = bsDialog
  Caption = 'EnterNewDetTypeForm'
  ClientHeight = 177
  ClientWidth = 401
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Tahoma'
  OnShow = FormShow
  Position = poMainFormCenter
  object PanelBackGround: TPanel
    Left = 0
    Height = 177
    Top = 0
    Width = 401
    Align = alClient
    ClientHeight = 177
    ClientWidth = 401
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 0
    object LblEnterDetTypeName: TLabel
      Left = 16
      Height = 25
      Top = 16
      Width = 342
      Caption = 'Укажите название типа детектора:'
      ParentColor = False
    end
    object LblDetTypeAlreadyExist: TLabel
      Left = 19
      Height = 19
      Top = 78
      Width = 228
      Caption = 'Название типа уже существует'
      Color = clBtnFace
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      ParentColor = False
      ParentFont = False
      Transparent = False
      Visible = False
    end
    object EditDetTypeName: TEdit
      Left = 16
      Height = 33
      Top = 47
      Width = 369
      MaxLength = 20
      OnKeyPress = EditDetTypeNameKeyPress
      TabOrder = 0
    end
    object BtnOk: TButton
      Left = 260
      Height = 43
      Top = 120
      Width = 125
      Caption = 'Добавить'
      OnClick = BtnOkClick
      TabOrder = 1
    end
    object BtnCancel: TButton
      Left = 16
      Height = 43
      Top = 120
      Width = 125
      Caption = 'Отмена'
      OnClick = BtnCancelClick
      TabOrder = 2
    end
  end
end
