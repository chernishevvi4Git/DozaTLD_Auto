object AddUW: TAddUW
  Left = 0
  Height = 476
  Top = 0
  Width = 338
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Добавление пользователя'
  ClientHeight = 476
  ClientWidth = 338
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poScreenCenter
  Scaled = False
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
      ModalResult = 1
      OnClick = OKButtonClick
      TabOrder = 1
    end
  end
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
    object ConfirmPassLabel: TLabel
      Left = 8
      Height = 25
      Top = 269
      Width = 209
      Caption = 'Подтвердите пароль:'
      ParentColor = False
    end
    object ErrConfirmPassLabel: TLabel
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
    object ErrLoginLabel: TLabel
      Left = 8
      Height = 13
      Top = 84
      Width = 85
      Caption = 'Введните логин!'
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      ParentColor = False
      ParentFont = False
    end
    object ErrPassLabel: TLabel
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
    object LoginLabel: TLabel
      Left = 8
      Height = 25
      Top = 14
      Width = 270
      Caption = 'Введите имя пользователя:'
      ParentColor = False
    end
    object PassordLabel: TLabel
      Left = 8
      Height = 25
      Top = 184
      Width = 163
      Caption = 'Введите пароль:'
      ParentColor = False
    end
    object PermitLabel: TLabel
      Left = 8
      Height = 25
      Top = 99
      Width = 221
      Caption = 'Шаблон прав доступа:'
      ParentColor = False
    end
    object ConfirmPasswordEdit: TEdit
      Left = 8
      Height = 33
      Top = 300
      Width = 321
      OnKeyUp = LoginEditKeyUpEditEnter
      TabOrder = 3
    end
    object LoginEdit: TEdit
      Left = 8
      Height = 33
      Top = 45
      Width = 321
      MaxLength = 25
      OnKeyUp = LoginEditKeyUpEditEnter
      TabOrder = 0
    end
    object PasswordEdit: TEdit
      Left = 8
      Height = 33
      Top = 215
      Width = 321
      OnKeyUp = LoginEditKeyUpEditEnter
      TabOrder = 2
    end
    object PermitComboBox: TComboBox
      Left = 8
      Height = 33
      Top = 130
      Width = 321
      ItemHeight = 25
      OnKeyUp = LoginEditKeyUpEditEnter
      Style = csDropDownList
      TabOrder = 1
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
    TabStop = True
    object LabelTitle: TLabel
      Left = 1
      Height = 45
      Top = 1
      Width = 336
      Align = alClient
      Alignment = taCenter
      Caption = 'Новый пользователь'
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Layout = tlCenter
      ParentColor = False
      ParentFont = False
    end
  end
end
