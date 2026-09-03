object ImportDBForm: TImportDBForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Import'
  ClientHeight = 252
  ClientWidth = 259
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LblBDNameErr: TLabel
    Left = 8
    Top = 48
    Width = 67
    Height = 13
    Caption = 'LblBDNameErr'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object LblNewBaseName: TLabel
    Left = 8
    Top = 8
    Width = 202
    Height = 13
    Caption = #1059#1082#1072#1078#1080#1090#1077' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1085#1086#1074#1086#1081' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093':'
  end
  object LblImportFile: TLabel
    Left = 8
    Top = 88
    Width = 161
    Height = 13
    Caption = #1059#1082#1072#1078#1080#1090#1077' '#1080#1084#1087#1086#1088#1090#1080#1088#1091#1077#1084#1099#1081' '#1092#1072#1081#1083':'
  end
  object SpeedBtnOpenFile: TSpeedButton
    Left = 223
    Top = 105
    Width = 25
    Height = 25
    Caption = '...'
    OnClick = SpeedBtnOpenFileClick
  end
  object LblProgressBar: TLabel
    Left = 8
    Top = 174
    Width = 71
    Height = 13
    Caption = 'LblProgressBar'
  end
  object LblBackupFileName: TLabel
    Left = 8
    Top = 128
    Width = 90
    Height = 13
    Caption = 'LblBackupFileName'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object EditDBName: TEdit
    Left = 8
    Top = 27
    Width = 209
    Height = 21
    CharCase = ecLowerCase
    TabOrder = 0
    OnChange = EditDBNameChange
    OnKeyPress = EditDBNameKeyPress
  end
  object BtnCancel: TButton
    Left = 182
    Top = 216
    Width = 66
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = BtnCancelClick
  end
  object BtnOk: TButton
    Left = 8
    Top = 216
    Width = 66
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = BtnOkClick
  end
  object EditImportPath: TEdit
    Left = 8
    Top = 107
    Width = 209
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 193
    Width = 240
    Height = 17
    TabOrder = 4
  end
  object OpenDialogBackupFile: TOpenDialog
    Left = 216
    Top = 56
  end
end
