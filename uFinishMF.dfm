object FinishMeasureW: TFinishMeasureW
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1048#1079#1084#1077#1088#1077#1085#1080#1077' '#1079#1072#1074#1077#1088#1096#1077#1085#1086
  ClientHeight = 573
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelClient: TPanel
    Left = 0
    Top = 52
    Width = 536
    Height = 461
    Align = alClient
    TabOrder = 0
    object PageControlDosResults: TPageControl
      Left = 1
      Top = 1
      Width = 537
      Height = 460
      ActivePage = TabSheetMeas
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object TabSheetMeas: TTabSheet
        Caption = ' '#1048#1079#1084#1077#1088#1077#1085#1080#1077' '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object PanelPageMeas: TPanel
          Left = 0
          Top = 0
          Width = 529
          Height = 416
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object LblDosDose: TLabel
            Left = 17
            Top = 12
            Width = 61
            Height = 29
            Caption = #1044#1086#1079#1072':'
          end
          object LblKS: TLabel
            Left = 17
            Top = 168
            Width = 286
            Height = 29
            Caption = #1050#1086#1085#1090#1088#1086#1083#1100#1085#1072#1103' '#1089#1074#1077#1090#1086#1089#1091#1084#1084#1072':'
          end
          object LblComment: TLabel
            Left = 17
            Top = 324
            Width = 157
            Height = 29
            Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
          end
          object LblDosMeasTime: TLabel
            Left = 17
            Top = 246
            Width = 204
            Height = 29
            Caption = #1042#1088#1077#1084#1103' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
          end
          object LabelStatus: TLabel
            Left = 17
            Top = 90
            Width = 80
            Height = 29
            Caption = #1057#1090#1072#1090#1091#1089':'
          end
          object EditDose: TEdit
            Left = 17
            Top = 47
            Width = 496
            Height = 37
            TabStop = False
            Alignment = taCenter
            Color = clMoneyGreen
            ReadOnly = True
            TabOrder = 0
            OnEnter = EditDisable
            OnExit = EditEnable
          end
          object EditDosStatus: TEdit
            Left = 17
            Top = 125
            Width = 496
            Height = 37
            TabStop = False
            Alignment = taCenter
            Color = clMoneyGreen
            ReadOnly = True
            TabOrder = 1
            OnEnter = EditDisable
            OnExit = EditEnable
          end
          object EditDosKSVal: TEdit
            Left = 17
            Top = 203
            Width = 286
            Height = 37
            TabStop = False
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 2
            OnEnter = EditDisable
            OnExit = EditEnable
          end
          object EditDosMeasTimeVal: TEdit
            Left = 17
            Top = 281
            Width = 496
            Height = 37
            TabStop = False
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 3
            OnEnter = EditDisable
            OnExit = EditEnable
          end
          object EditDosComment: TEdit
            Left = 17
            Top = 359
            Width = 496
            Height = 37
            MaxLength = 60
            TabOrder = 4
          end
        end
      end
      object TabSheetDos: TTabSheet
        Caption = ' '#1044#1086#1079#1080#1084#1077#1090#1088' '
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object PanelPageDos: TPanel
          Left = 0
          Top = 0
          Width = 529
          Height = 416
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object LblKDos: TLabel
            Left = 17
            Top = 12
            Width = 155
            Height = 29
            Caption = #1050' -'#1076#1086#1079#1080#1084#1077#1090#1088#1072':'
          end
          object LblVerificationDate: TLabel
            Left = 17
            Top = 246
            Width = 161
            Height = 29
            Caption = #1044#1072#1090#1072' '#1087#1086#1074#1077#1088#1082#1080':'
          end
          object LblFormula: TLabel
            Left = 17
            Top = 90
            Width = 105
            Height = 29
            Caption = #1060#1086#1088#1084#1091#1083#1072':'
          end
          object LblPart: TLabel
            Left = 17
            Top = 168
            Width = 88
            Height = 29
            Caption = #1055#1072#1088#1090#1080#1103':'
          end
          object EditKVal: TEdit
            Left = 17
            Top = 47
            Width = 496
            Height = 37
            TabStop = False
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 0
            OnEnter = EditDisable
            OnExit = EditEnable
          end
          object EditLFormulaDosVal: TEdit
            Left = 17
            Top = 125
            Width = 496
            Height = 37
            TabStop = False
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 1
            OnEnter = EditDisable
            OnExit = EditEnable
          end
          object EditDosPart: TEdit
            Left = 17
            Top = 203
            Width = 286
            Height = 37
            TabStop = False
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 2
            OnEnter = EditDisable
            OnExit = EditEnable
          end
          object EditDosVerVal: TEdit
            Left = 17
            Top = 281
            Width = 496
            Height = 37
            TabStop = False
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 3
            OnEnter = EditDisable
            OnExit = EditEnable
          end
        end
      end
      object TabSheetDetectors: TTabSheet
        Caption = ' '#1044#1077#1090#1077#1082#1090#1086#1088#1099' '
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object PanelDetectors: TPanel
          Left = 0
          Top = 0
          Width = 529
          Height = 416
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object PanelD1: TPanel
            Left = 1
            Top = 1
            Width = 264
            Height = 209
            BevelInner = bvLowered
            TabOrder = 0
            object LblDoseD1: TLabel
              Left = 12
              Top = 33
              Width = 28
              Height = 14
              Caption = #1044#1086#1079#1072':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblErrD1: TLabel
              Left = 12
              Top = 55
              Width = 70
              Height = 14
              Caption = #1055#1086#1075#1088#1077#1096#1085#1086#1089#1090#1100':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblStatusD1: TLabel
              Left = 12
              Top = 77
              Width = 40
              Height = 14
              Caption = #1057#1090#1072#1090#1091#1089':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblTypeD1: TLabel
              Left = 12
              Top = 99
              Width = 77
              Height = 14
              Caption = #1058#1080#1087' '#1076#1077#1090#1077#1082#1090#1086#1088#1072':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblTypeValD1: TLabel
              Left = 110
              Top = 99
              Width = 22
              Height = 13
              Caption = 'Text'
            end
            object LblCommentD1: TLabel
              Left = 12
              Top = 119
              Width = 74
              Height = 14
              Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblD1: TLabel
              Left = 12
              Top = 6
              Width = 97
              Height = 23
              Caption = #1044#1077#1090#1077#1082#1090#1086#1088' 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object EditDoseD1: TEdit
              Left = 110
              Top = 30
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 1
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditErrD1: TEdit
              Left = 110
              Top = 52
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 2
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditStatusD1: TEdit
              Left = 110
              Top = 74
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object MemoCommentD1: TMemo
              Left = 8
              Top = 139
              Width = 249
              Height = 64
              MaxLength = 60
              TabOrder = 0
              OnKeyUp = MemoCommentKeyUp
            end
          end
          object PanelD2: TPanel
            Left = 265
            Top = 1
            Width = 264
            Height = 209
            BevelInner = bvLowered
            TabOrder = 1
            object LblDoseD2: TLabel
              Left = 12
              Top = 33
              Width = 28
              Height = 14
              Caption = #1044#1086#1079#1072':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblErrD2: TLabel
              Left = 12
              Top = 55
              Width = 70
              Height = 14
              Caption = #1055#1086#1075#1088#1077#1096#1085#1086#1089#1090#1100':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblStatusD2: TLabel
              Left = 12
              Top = 77
              Width = 40
              Height = 14
              Caption = #1057#1090#1072#1090#1091#1089':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblTypeD2: TLabel
              Left = 12
              Top = 99
              Width = 77
              Height = 14
              Caption = #1058#1080#1087' '#1076#1077#1090#1077#1082#1090#1086#1088#1072':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblTypeValD2: TLabel
              Left = 110
              Top = 99
              Width = 22
              Height = 13
              Caption = 'Text'
            end
            object LblCommentD2: TLabel
              Left = 12
              Top = 119
              Width = 74
              Height = 14
              Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblD2: TLabel
              Left = 12
              Top = 6
              Width = 97
              Height = 23
              Caption = #1044#1077#1090#1077#1082#1090#1086#1088' 2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object EditDoseD2: TEdit
              Left = 110
              Top = 30
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 1
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditErrD2: TEdit
              Left = 110
              Top = 52
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 2
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditStatusD2: TEdit
              Left = 110
              Top = 74
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object MemoCommentD2: TMemo
              Left = 8
              Top = 139
              Width = 249
              Height = 64
              MaxLength = 60
              TabOrder = 0
              OnKeyUp = MemoCommentKeyUp
            end
          end
          object PanelD3: TPanel
            Left = 1
            Top = 210
            Width = 264
            Height = 209
            BevelInner = bvLowered
            TabOrder = 2
            object LblDoseD3: TLabel
              Left = 12
              Top = 33
              Width = 28
              Height = 14
              Caption = #1044#1086#1079#1072':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblErrD3: TLabel
              Left = 12
              Top = 55
              Width = 70
              Height = 14
              Caption = #1055#1086#1075#1088#1077#1096#1085#1086#1089#1090#1100':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblStatusD3: TLabel
              Left = 12
              Top = 77
              Width = 40
              Height = 14
              Caption = #1057#1090#1072#1090#1091#1089':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblTypeD3: TLabel
              Left = 12
              Top = 99
              Width = 77
              Height = 14
              Caption = #1058#1080#1087' '#1076#1077#1090#1077#1082#1090#1086#1088#1072':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblTypeValD3: TLabel
              Left = 110
              Top = 99
              Width = 22
              Height = 13
              Caption = 'Text'
            end
            object LblCommentD3: TLabel
              Left = 12
              Top = 119
              Width = 74
              Height = 14
              Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblD3: TLabel
              Left = 13
              Top = 6
              Width = 97
              Height = 23
              Caption = #1044#1077#1090#1077#1082#1090#1086#1088' 3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object EditDoseD3: TEdit
              Left = 110
              Top = 30
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 1
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditErrD3: TEdit
              Left = 110
              Top = 52
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 2
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditStatusD3: TEdit
              Left = 110
              Top = 74
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object MemoCommentD3: TMemo
              Left = 8
              Top = 139
              Width = 249
              Height = 64
              MaxLength = 60
              TabOrder = 0
              OnKeyUp = MemoCommentKeyUp
            end
          end
          object PanelD4: TPanel
            Left = 265
            Top = 210
            Width = 264
            Height = 209
            BevelInner = bvLowered
            TabOrder = 3
            object LblDoseD4: TLabel
              Left = 12
              Top = 33
              Width = 28
              Height = 14
              Caption = #1044#1086#1079#1072':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblErrD4: TLabel
              Left = 12
              Top = 55
              Width = 70
              Height = 14
              Caption = #1055#1086#1075#1088#1077#1096#1085#1086#1089#1090#1100':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblStatusD4: TLabel
              Left = 12
              Top = 77
              Width = 40
              Height = 14
              Caption = #1057#1090#1072#1090#1091#1089':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblTypeD4: TLabel
              Left = 12
              Top = 99
              Width = 77
              Height = 14
              Caption = #1058#1080#1087' '#1076#1077#1090#1077#1082#1090#1086#1088#1072':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblTypeValD4: TLabel
              Left = 110
              Top = 99
              Width = 22
              Height = 13
              Caption = 'Text'
            end
            object LblCommentD4: TLabel
              Left = 12
              Top = 119
              Width = 74
              Height = 14
              Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object LblD4: TLabel
              Left = 12
              Top = 6
              Width = 97
              Height = 23
              Caption = #1044#1077#1090#1077#1082#1090#1086#1088' 4'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object EditDoseD4: TEdit
              Left = 110
              Top = 30
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 1
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditErrD4: TEdit
              Left = 110
              Top = 52
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 2
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditStatusD4: TEdit
              Left = 110
              Top = 74
              Width = 147
              Height = 21
              TabStop = False
              Alignment = taCenter
              Color = clMoneyGreen
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object MemoCommentD4: TMemo
              Left = 8
              Top = 139
              Width = 249
              Height = 64
              MaxLength = 60
              TabOrder = 0
              OnKeyUp = MemoCommentKeyUp
            end
          end
        end
      end
      object TabSheetIDK: TTabSheet
        Caption = ' '#1048#1044#1050
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object PanelPageIDK: TPanel
          Left = 0
          Top = 0
          Width = 529
          Height = 416
          Align = alClient
          ParentBackground = False
          TabOrder = 0
          object LblDosPersNumber: TLabel
            Left = 17
            Top = 91
            Width = 207
            Height = 29
            Caption = #1058#1072#1073#1077#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088':'
          end
          object LblDosOrg: TLabel
            Left = 17
            Top = 247
            Width = 154
            Height = 29
            Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103':'
          end
          object LblDosDepartment: TLabel
            Left = 17
            Top = 325
            Width = 180
            Height = 29
            Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
          end
          object LblDosFIO: TLabel
            Left = 17
            Top = 12
            Width = 59
            Height = 29
            Caption = #1060#1048#1054':'
          end
          object LblDosIDKState: TLabel
            Left = 17
            Top = 169
            Width = 134
            Height = 29
            Caption = #1057#1090#1072#1090#1091#1089' '#1048#1044#1050':'
          end
          object EditDosDepVal: TEdit
            Left = 17
            Top = 360
            Width = 496
            Height = 37
            MaxLength = 18
            TabOrder = 3
          end
          object EditDosOrgVal: TEdit
            Left = 17
            Top = 282
            Width = 496
            Height = 37
            MaxLength = 18
            TabOrder = 2
          end
          object EditDosPersNumberVal: TEdit
            Left = 17
            Top = 126
            Width = 496
            Height = 37
            TabOrder = 1
          end
          object EditDosFIO: TEdit
            Left = 17
            Top = 47
            Width = 496
            Height = 37
            MaxLength = 42
            TabOrder = 0
          end
          object EditDosIDKState: TEdit
            Left = 17
            Top = 204
            Width = 496
            Height = 37
            TabStop = False
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 4
            OnEnter = EditDisable
            OnExit = EditEnable
          end
        end
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 513
    Width = 536
    Height = 60
    Align = alBottom
    TabOrder = 1
    object BtnAccept: TButton
      Left = 376
      Top = 13
      Width = 150
      Height = 39
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnAcceptClick
    end
    object BtnCancel: TButton
      Left = 8
      Top = 13
      Width = 146
      Height = 39
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BtnCancelClick
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 52
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object LblDosType: TLabel
      Left = 14
      Top = 9
      Width = 129
      Height = 33
      Caption = #1044#1086#1079#1080#1084#1077#1090#1088':'
    end
    object LblDosNumberAndType: TLabel
      Left = 149
      Top = 9
      Width = 79
      Height = 33
      Caption = #1053#1086#1084#1077#1088
    end
  end
end
