object AW: TAW
  Left = 0
  Height = 246
  Top = 0
  Width = 297
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Аутентификация пользователя'
  ClientHeight = 246
  ClientWidth = 297
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  Position = poScreenCenter
  LCLVersion = '2.2.6.0'
  Scaled = False
  object PanelBackground: TPanel
    Left = 0
    Height = 188
    Top = 0
    Width = 297
    Align = alClient
    ClientHeight = 188
    ClientWidth = 297
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 0
    TabStop = True
    object LoginLabel: TLabel
      Left = 8
      Height = 25
      Top = 16
      Width = 185
      Caption = 'Имя пользователя:'
      ParentColor = False
    end
    object PasswordLabel: TLabel
      Left = 8
      Height = 25
      Top = 97
      Width = 78
      Caption = 'Пароль:'
      ParentColor = False
    end
    object LoginComboBox: TComboBox
      Left = 8
      Height = 33
      Top = 47
      Width = 278
      ItemHeight = 25
      OnChange = LoginComboBoxChange
      TabOrder = 0
    end
    object PasswordEdit: TEdit
      Left = 8
      Height = 33
      Top = 128
      Width = 278
      TabOrder = 1
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Height = 58
    Top = 188
    Width = 297
    Align = alBottom
    ClientHeight = 58
    ClientWidth = 297
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 1
    TabStop = True
    object ExitButton: TButton
      Left = 8
      Height = 43
      Top = 6
      Width = 120
      Cancel = True
      Caption = 'Выход'
      OnClick = ExitButtonClick
      TabOrder = 0
    end
    object OkButton: TButton
      Left = 166
      Height = 43
      Top = 6
      Width = 120
      Caption = 'OK'
      Default = True
      OnClick = OkButtonClick
      TabOrder = 1
    end
  end
end
