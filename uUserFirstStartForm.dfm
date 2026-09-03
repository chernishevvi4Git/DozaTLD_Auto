object FormUserFirstStart: TFormUserFirstStart
  Left = 0
  Height = 393
  Top = 0
  Width = 377
  BorderIcons = []
  Caption = 'Первый запуск'
  ClientHeight = 393
  ClientWidth = 377
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnActivate = FormActivate
  OnCreate = FormCreate
  Position = poMainFormCenter
  LCLVersion = '2.2.6.0'
  object PanelBackground: TPanel
    Left = 0
    Height = 283
    Top = 47
    Width = 377
    Align = alClient
    ClientHeight = 283
    ClientWidth = 377
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 0
    object LblLogin: TLabel
      Left = 24
      Height = 25
      Top = 19
      Width = 296
      Caption = 'Введите имя администратора:'
      ParentColor = False
    end
    object LblPass: TLabel
      Left = 24
      Height = 25
      Top = 104
      Width = 163
      Caption = 'Введите пароль:'
      ParentColor = False
    end
    object LblConfirmPass: TLabel
      Left = 24
      Height = 25
      Top = 189
      Width = 209
      Caption = 'Подтвердите пароль:'
      ParentColor = False
    end
    object LblErrConfirmPass: TLabel
      Left = 24
      Height = 13
      Top = 254
      Width = 116
      Caption = 'Пароли не совпадают!'
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object LblErrPass: TLabel
      Left = 24
      Height = 13
      Top = 170
      Width = 116
      Caption = 'Пароли не совпадают!'
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object LblErrLogin: TLabel
      Left = 24
      Height = 13
      Top = 85
      Width = 85
      Caption = 'Введните логин!'
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object EditLogin: TEdit
      Left = 24
      Height = 33
      Top = 50
      Width = 329
      TabOrder = 0
    end
    object EditPass: TEdit
      Left = 24
      Height = 33
      Top = 135
      Width = 329
      TabOrder = 1
    end
    object EditConfirmPass: TEdit
      Left = 24
      Height = 33
      Top = 220
      Width = 329
      TabOrder = 2
    end
  end
  object PanelTop: TPanel
    Left = 0
    Height = 47
    Top = 0
    Width = 377
    Align = alTop
    ClientHeight = 47
    ClientWidth = 377
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 1
    object LabelTop: TLabel
      Left = 1
      Height = 45
      Top = 1
      Width = 375
      Align = alClient
      Alignment = taCenter
      Caption = 'Первый запуск программы'
      Layout = tlCenter
      ParentBidiMode = False
      ParentColor = False
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Height = 63
    Top = 330
    Width = 377
    Align = alBottom
    ClientHeight = 63
    ClientWidth = 377
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 2
    object BtnCancel: TButton
      Left = 8
      Height = 51
      Top = 6
      Width = 125
      Cancel = True
      Caption = 'Выход'
      ModalResult = 2
      OnClick = BtnCancelClick
      TabOrder = 0
    end
    object BtnOk: TButton
      Left = 244
      Height = 51
      Top = 6
      Width = 125
      Caption = 'OK'
      OnClick = BtnOkClick
      TabOrder = 1
    end
  end
end
