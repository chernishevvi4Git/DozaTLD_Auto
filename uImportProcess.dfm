object ImportProcessW: TImportProcessW
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1080#1084#1087#1086#1088#1090#1072
  ClientHeight = 300
  ClientWidth = 527
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMemoLog: TPanel
    Left = 0
    Top = 0
    Width = 527
    Height = 233
    Align = alClient
    TabOrder = 0
    object PageControlImportResults: TPageControl
      Left = 1
      Top = 1
      Width = 525
      Height = 208
      ActivePage = TabSheetResult
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object TabSheetResult: TTabSheet
        Caption = ' '#1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '
        DesignSize = (
          517
          168)
        object LblImport: TLabel
          Left = 0
          Top = 0
          Width = 517
          Height = 33
          Align = alTop
          Alignment = taCenter
          Caption = #1054#1087#1077#1088#1072#1094#1080#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 265
        end
        object LblUpdetedRecords: TLabel
          Left = 3
          Top = 101
          Width = 511
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = '  '#1054#1073#1085#1086#1074#1083#1077#1085#1086' '#1079#1072#1087#1080#1089#1077#1081' - '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object LblAddedRecords: TLabel
          Left = 3
          Top = 70
          Width = 511
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = '  '#1044#1086#1073#1072#1074#1083#1077#1085#1086' '#1079#1072#1087#1080#1089#1077#1081' - '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object LblErr: TLabel
          Left = 3
          Top = 132
          Width = 511
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = '  '#1047#1072#1092#1080#1082#1089#1080#1088#1086#1074#1085#1086' '#1086#1096#1080#1073#1086#1082' - '
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
      end
      object TabSheetLog: TTabSheet
        Caption = ' '#1051#1086#1075' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '
        ImageIndex = 1
        object MemoLog: TMemo
          Left = 0
          Top = 0
          Width = 517
          Height = 168
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          PopupMenu = PopupMenuLog
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object ProgressBarAccept: TProgressBar
      Left = 1
      Top = 209
      Width = 525
      Height = 23
      Align = alBottom
      TabOrder = 1
      Visible = False
    end
  end
  object PanelButtons: TPanel
    Left = 0
    Top = 233
    Width = 527
    Height = 67
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      527
      67)
    object BtnAccept: TButton
      Left = 312
      Top = 6
      Width = 210
      Height = 51
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1080#1085#1103#1090#1100
      TabOrder = 0
      OnClick = BtnAcceptClick
    end
    object BtnCancel: TButton
      Left = 5
      Top = 6
      Width = 201
      Height = 51
      Caption = #1054#1090#1082#1083#1086#1085#1080#1090#1100
      TabOrder = 1
      OnClick = BtnCancelClick
    end
  end
  object PopupMenuLog: TPopupMenu
    Left = 316
    Top = 48
    object LogClear: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnClick = LogClearClick
    end
    object SaveLogAs: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
      OnClick = SaveLogAsClick
    end
  end
  object SaveTextFileDialogLog: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text file|*.txt'
    Left = 317
    Top = 97
  end
end
