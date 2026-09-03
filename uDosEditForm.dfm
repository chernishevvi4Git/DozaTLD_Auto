object SetDosEditForm: TSetDosEditForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 191
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBackground: TPanel
    Left = 0
    Top = 0
    Width = 594
    Height = 191
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LblValue: TLabel
      Left = 24
      Top = 17
      Width = 116
      Height = 33
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077
    end
    object EditValue: TEdit
      Left = 24
      Top = 88
      Width = 545
      Height = 41
      TabOrder = 0
    end
    object BtnCancel: TButton
      Left = 24
      Top = 120
      Width = 161
      Height = 49
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = BtnCancelClick
    end
    object BtnAccept: TButton
      Left = 408
      Top = 120
      Width = 161
      Height = 49
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 2
    end
    object ComboBoxValue: TComboBox
      Left = 32
      Top = 41
      Width = 545
      Height = 41
      TabOrder = 3
    end
    object DateTimePickerValue: TDateTimePicker
      Left = 32
      Top = 120
      Width = 545
      Height = 41
      Date = 44635.000000000000000000
      Time = 0.738711030091508300
      TabOrder = 4
      OnChange = DateTimePickerValueChange
    end
  end
end
