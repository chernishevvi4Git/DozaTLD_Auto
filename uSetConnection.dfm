object SetW: TSetW
  Left = 968
  Height = 318
  Top = 228
  Width = 302
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Настройки'
  ClientHeight = 318
  ClientWidth = 302
  Color = clBtnFace
  DesignTimePPI = 120
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  FormStyle = fsStayOnTop
  OnShow = FormShow
  LCLVersion = '3.6.0.0'
  object GBCOMPort: TGroupBox
    Left = 10
    Height = 271
    Top = 10
    Width = 281
    Caption = 'Настройки COM-порта'
    ClientHeight = 249
    ClientWidth = 277
    ParentBackground = False
    TabOrder = 0
    object LabelPort: TLabel
      Left = 30
      Height = 17
      Top = 44
      Width = 33
      Caption = 'Порт'
      ParentColor = False
    end
    object LabelBaudRate: TLabel
      Left = 30
      Height = 17
      Top = 125
      Width = 62
      Caption = 'Скорость'
      ParentColor = False
    end
    object LabelStopBit: TLabel
      Left = 30
      Height = 17
      Top = 178
      Width = 62
      Caption = 'Стоп-бит'
      ParentColor = False
    end
    object LabelParity: TLabel
      Left = 30
      Height = 17
      Top = 228
      Width = 89
      Caption = 'Бит паритета'
      ParentColor = False
    end
    object CBComPort: TComboBox
      Left = 124
      Height = 25
      Top = 40
      Width = 121
      ItemHeight = 17
      TabOrder = 0
      OnChange = CBComPortChange
      OnKeyPress = CBComPortKeyPress
    end
    object CBBaudRate_: TComboBox
      Left = 124
      Height = 25
      Top = 121
      Width = 121
      Enabled = False
      ItemHeight = 17
      Items.Strings = (
        '600'
        '1200'
        '1800'
        '2400'
        '4800'
        '7200'
        '9600'
        '14400'
        '19200'
        '38400'
        '57600'
        '115200'
      )
      TabOrder = 1
    end
    object CBoxStopBit: TComboBox
      Left = 124
      Height = 25
      Top = 174
      Width = 121
      Enabled = False
      ItemHeight = 17
      Items.Strings = (
        '1'
        '1.5'
        '2'
      )
      TabOrder = 2
      OnKeyPress = CBComPortKeyPress
    end
    object CBParity: TComboBox
      Left = 124
      Height = 25
      Top = 224
      Width = 121
      Enabled = False
      ItemHeight = 17
      Items.Strings = (
        'none'
        'Even'
        'Odd'
        'Mark'
        'Space'
      )
      TabOrder = 3
      OnKeyPress = CBComPortKeyPress
    end
    object BtnClose: TButton
      Left = 124
      Height = 31
      Top = 72
      Width = 121
      Caption = 'Закрыть порт'
      TabOrder = 4
      OnClick = BtnCloseClick
    end
  end
  object PanelPortState: TPanel
    Left = 0
    Height = 25
    Top = 292
    Width = 301
    Anchors = [akLeft, akBottom]
    BevelInner = bvLowered
    ParentBackground = False
    TabOrder = 1
  end
end
