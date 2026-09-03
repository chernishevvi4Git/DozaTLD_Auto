object UMW: TUMW
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#1084#1080
  ClientHeight = 582
  ClientWidth = 727
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 25
  object StatusBar: TStatusBar
    Left = 0
    Top = 563
    Width = 727
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Bevel = pbRaised
        Width = 120
      end
      item
        Width = 50
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 563
    Align = alLeft
    TabOrder = 1
    object SG_Users: TStringGrid
      Left = 1
      Top = 1
      Width = 263
      Height = 431
      Align = alClient
      ColCount = 1
      DefaultColWidth = 154
      DrawingStyle = gdsGradient
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      GradientEndColor = cl3DLight
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnSelectCell = SG_UsersSelectCell
      ColWidths = (
        254)
    end
    object Panel3: TPanel
      Left = 1
      Top = 432
      Width = 263
      Height = 130
      Align = alBottom
      TabOrder = 1
      object AddSpeedButton: TSpeedButton
        Left = 8
        Top = 6
        Width = 240
        Height = 34
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        OnClick = AddSpeedButtonClick
      end
      object DelSpeedButton: TSpeedButton
        Left = 8
        Top = 46
        Width = 240
        Height = 34
        Caption = #1059#1076#1072#1083#1080#1090#1100
        OnClick = DelSpeedButtonClick
      end
      object EditSpeedButton: TSpeedButton
        Left = 8
        Top = 86
        Width = 240
        Height = 34
        Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
        OnClick = EditSpeedButtonClick
      end
    end
  end
  object Panel5: TPanel
    Left = 265
    Top = 0
    Width = 462
    Height = 563
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 474
      Width = 460
      Height = 88
      Align = alBottom
      TabOrder = 0
      object LabelPermitHelp: TLabel
        Left = 1
        Top = 1
        Width = 458
        Height = 86
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 
          #1042#1099#1076#1077#1083#1080#1090#1077' '#1089#1090#1088#1086#1082#1091' '#1089' '#1087#1088#1072#1074#1072#1084#1080' '#1076#1083#1103' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1073#1086#1083#1077#1077' '#1087#1086#1076#1088#1086#1073#1085#1086#1081' '#1087#1086#1076#1089#1082#1072#1079#1082 +
          #1080' '#1087#1086' '#1077#1075#1086' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1102
        EllipsisPosition = epWordEllipsis
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitTop = 19
        ExplicitWidth = 450
        ExplicitHeight = 81
      end
    end
    object CLB_Permits: TCheckListBox
      Left = 1
      Top = 73
      Width = 460
      Height = 401
      OnClickCheck = CLB_PermitsClickCheck
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 23
      ParentFont = False
      Style = lbOwnerDrawFixed
      TabOrder = 1
      OnClick = CLB_PermitsClick
    end
    object Panel1: TPanel
      Left = 1
      Top = 41
      Width = 460
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Label_Permits: TLabel
        Left = 0
        Top = 0
        Width = 460
        Height = 32
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = #1055#1088#1072#1074#1072' '#1080' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
        ExplicitLeft = 4
        ExplicitTop = -4
        ExplicitWidth = 458
        ExplicitHeight = 30
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 460
      Height = 40
      Align = alTop
      Color = clWindow
      ParentBackground = False
      TabOrder = 3
      object Label_SetAsTemplate: TLabel
        Left = 5
        Top = 7
        Width = 208
        Height = 32
        AutoSize = False
        Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1096#1072#1073#1083#1086#1085
      end
      object CB_SetAsTemlate: TComboBox
        Left = 208
        Top = 4
        Width = 249
        Height = 33
        TabOrder = 0
        OnChange = CB_SetAsTemlateChange
        OnDropDown = CB_SetAsTemlateDropDown
      end
    end
  end
end
