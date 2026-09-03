object UChangePassW: TUChangePassW
  Left = 0
  Height = 476
  Top = 0
  Width = 338
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Смена пароля'
  ClientHeight = 476
  ClientWidth = 338
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poScreenCenter
  LCLVersion = '2.2.6.0'
  Scaled = False
  object PanelBackground: TPanel
    Left = 0
    Height = 366
    Top = 47
    Width = 338
    Align = alClient
    ClientHeight = 366
    ClientWidth = 338
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 0
    object ConfirmNewPassErrLabel: TLabel
      Left = 8
      Height = 13
      Top = 339
      Width = 116
      Caption = 'Пароли не совпадают!'
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      ParentColor = False
      ParentFont = False
    end
    object ConfirmNewPassLabel: TLabel
      Left = 8
      Height = 25
      Top = 269
      Width = 277
      Caption = 'Подтвердите новый пароль:'
      ParentColor = False
    end
    object LoginLabel: TLabel
      Left = 8
      Height = 25
      Top = 14
      Width = 185
      Caption = 'Имя пользователя:'
      ParentColor = False
    end
    object NewPassErrLabel: TLabel
      Left = 8
      Height = 13
      Top = 254
      Width = 116
      Caption = 'Пароли не совпадают!'
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      ParentColor = False
      ParentFont = False
    end
    object NewPassLabel: TLabel
      Left = 8
      Height = 25
      Top = 184
      Width = 231
      Caption = 'Введите новый пароль:'
      ParentColor = False
    end
    object OldPassErrLabel: TLabel
      Left = 8
      Height = 13
      Top = 169
      Width = 126
      Caption = 'Пароль введен неверно!'
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      ParentColor = False
      ParentFont = False
    end
    object OldPassLabel: TLabel
      Left = 8
      Height = 25
      Top = 99
      Width = 240
      Caption = 'Введите старый пароль:'
      ParentColor = False
    end
    object ConfirmNewPassEdit: TEdit
      Left = 8
      Height = 33
      Top = 300
      Width = 321
      OnKeyUp = LoginEditKeyUpEditEnter
      TabOrder = 2
    end
    object LoginEdit: TEdit
      Left = 8
      Height = 33
      Top = 45
      Width = 321
      Enabled = False
      TabOrder = 3
    end
    object NewPassEdit: TEdit
      Left = 8
      Height = 33
      Top = 215
      Width = 321
      OnKeyUp = LoginEditKeyUpEditEnter
      TabOrder = 1
    end
    object OldPassEdit: TEdit
      Left = 8
      Height = 33
      Top = 130
      Width = 321
      OnKeyUp = LoginEditKeyUpEditEnter
      TabOrder = 0
    end
  end
  object PanelTop: TPanel
    Left = 0
    Height = 47
    Top = 0
    Width = 338
    Align = alTop
    ClientHeight = 47
    ClientWidth = 338
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 2
    object LabelTitle: TLabel
      Left = 4
      Height = 39
      Top = 4
      Width = 330
      Align = alClient
      Alignment = taCenter
      Caption = 'Смена пароля'
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Layout = tlCenter
      ParentColor = False
      ParentFont = False
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Height = 63
    Top = 413
    Width = 338
    Align = alBottom
    ClientHeight = 63
    ClientWidth = 338
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 1
    object CancelButton: TButton
      Left = 8
      Height = 51
      Top = 6
      Width = 125
      Cancel = True
      Caption = 'Отмена'
      ModalResult = 2
      OnClick = CancelButtonClick
      TabOrder = 0
    end
    object OKButton: TButton
      Left = 204
      Height = 51
      Top = 6
      Width = 125
      Caption = 'OK'
      OnClick = OKButtonClick
      TabOrder = 1
    end
  end
end
