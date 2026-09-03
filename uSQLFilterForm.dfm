object SQLFilterForm: TSQLFilterForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SQLFilterForm'
  ClientHeight = 371
  ClientWidth = 970
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelClient: TPanel
    Left = 0
    Top = 0
    Width = 970
    Height = 270
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object GroupBoxCondition: TGroupBox
      Left = 17
      Top = 13
      Width = 456
      Height = 132
      Caption = #1059#1089#1083#1086#1074#1080#1077' - WHERE'
      TabOrder = 0
      object MemoCondition: TMemo
        Left = 16
        Top = 24
        Width = 425
        Height = 95
        TabOrder = 0
        OnChange = MemoConditionChange
      end
    end
    object GroupBoxSort: TGroupBox
      Left = 17
      Top = 151
      Width = 456
      Height = 98
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
      TabOrder = 1
      object MemoSort: TMemo
        Left = 16
        Top = 32
        Width = 425
        Height = 53
        TabOrder = 0
        OnChange = MemoSortChange
      end
    end
    object BtnAND: TButton
      Left = 488
      Top = 21
      Width = 57
      Height = 33
      Caption = 'AND'
      TabOrder = 2
      OnClick = BtnANDClick
    end
    object BtnOR: TButton
      Left = 488
      Top = 60
      Width = 57
      Height = 33
      Caption = 'OR'
      TabOrder = 3
      OnClick = BtnORClick
    end
    object BtnGrater: TButton
      Left = 488
      Top = 99
      Width = 57
      Height = 33
      Caption = '>'
      TabOrder = 4
      OnClick = BtnGraterClick
    end
    object BtnLess: TButton
      Left = 488
      Top = 138
      Width = 57
      Height = 33
      Caption = '<'
      TabOrder = 5
      OnClick = BtnLessClick
    end
    object BtnEqual: TButton
      Left = 488
      Top = 177
      Width = 57
      Height = 33
      Caption = '='
      TabOrder = 6
      OnClick = BtnEqualClick
    end
    object BtnNotEqual: TButton
      Left = 488
      Top = 216
      Width = 57
      Height = 33
      Caption = '<>'
      TabOrder = 7
      OnClick = BtnNotEqualClick
    end
    object BtnMeasurmentid: TButton
      Left = 551
      Top = 60
      Width = 130
      Height = 33
      Caption = 'measurmentid'
      TabOrder = 8
      OnClick = BtnMeasurmentidClick
    end
    object BtnDosimeterid: TButton
      Left = 551
      Top = 99
      Width = 130
      Height = 33
      Caption = 'dosimeterid'
      TabOrder = 9
      OnClick = BtnDosimeteridClick
    end
    object BtnPostfix: TButton
      Left = 551
      Top = 138
      Width = 130
      Height = 33
      Caption = 'postfix'
      TabOrder = 10
      OnClick = BtnPostfixClick
    end
    object BtnDosimetertype: TButton
      Left = 551
      Top = 177
      Width = 130
      Height = 33
      Caption = 'dosimetertype'
      TabOrder = 11
      OnClick = BtnDosimetertypeClick
    end
    object BtnDose: TButton
      Left = 551
      Top = 21
      Width = 130
      Height = 33
      Caption = 'dose'
      TabOrder = 12
      OnClick = BtnDoseClick
    end
    object BtnErr: TButton
      Left = 551
      Top = 216
      Width = 130
      Height = 33
      Caption = 'error'
      TabOrder = 13
      OnClick = BtnErrClick
    end
    object BtnKSI: TButton
      Left = 687
      Top = 21
      Width = 130
      Height = 33
      Caption = 'ksi'
      TabOrder = 14
      OnClick = BtnKSIClick
    end
    object BtnMeasurmenttime: TButton
      Left = 687
      Top = 60
      Width = 130
      Height = 33
      Caption = 'measurmenttime'
      TabOrder = 15
      OnClick = BtnMeasurmenttimeClick
    end
    object BtnRegtime: TButton
      Left = 687
      Top = 99
      Width = 130
      Height = 33
      Caption = 'regtime'
      TabOrder = 16
      OnClick = BtnRegtimeClick
    end
    object BtnVertime: TButton
      Left = 687
      Top = 138
      Width = 130
      Height = 33
      Caption = 'vertime'
      TabOrder = 17
      OnClick = BtnVertimeClick
    end
    object BtnValidity: TButton
      Left = 687
      Top = 177
      Width = 130
      Height = 33
      Caption = 'validity'
      TabOrder = 18
      OnClick = BtnValidityClick
    end
    object BtnStatus: TButton
      Left = 687
      Top = 216
      Width = 130
      Height = 33
      Caption = 'status'
      TabOrder = 19
      OnClick = BtnStatusClick
    end
    object BtnPartID: TButton
      Left = 823
      Top = 21
      Width = 130
      Height = 33
      Caption = 'partid'
      TabOrder = 20
      OnClick = BtnPartIDClick
    end
    object BtnTLDID: TButton
      Left = 823
      Top = 60
      Width = 130
      Height = 33
      Caption = 'tldid'
      TabOrder = 21
      OnClick = BtnTLDIDClick
    end
    object BtnOrganization: TButton
      Left = 823
      Top = 99
      Width = 130
      Height = 33
      Caption = 'organization'
      TabOrder = 22
      OnClick = BtnOrganizationClick
    end
    object BtnDepartment: TButton
      Left = 823
      Top = 138
      Width = 130
      Height = 33
      Caption = 'department'
      TabOrder = 23
      OnClick = BtnDepartmentClick
    end
    object BtnDoscomment: TButton
      Left = 823
      Top = 177
      Width = 130
      Height = 33
      Caption = 'doscomment'
      TabOrder = 24
      OnClick = BtnDoscommentClick
    end
    object BtnMeascomment: TButton
      Left = 823
      Top = 216
      Width = 130
      Height = 33
      Caption = 'meascomment'
      TabOrder = 25
      OnClick = BtnMeascommentClick
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 270
    Width = 970
    Height = 101
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object LblErr: TLabel
      Left = 8
      Top = 6
      Width = 42
      Height = 19
      Caption = 'LblErr'
    end
    object BtnCheck: TButton
      Left = 17
      Top = 46
      Width = 129
      Height = 41
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
      TabOrder = 0
      OnClick = BtnCheckClick
    end
    object BtnDrop: TButton
      Left = 168
      Top = 46
      Width = 129
      Height = 41
      Caption = #1057#1073#1088#1086#1089#1080#1090#1100
      TabOrder = 1
      OnClick = BtnDropClick
    end
    object BtnApply: TButton
      Left = 824
      Top = 46
      Width = 129
      Height = 41
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = BtnApplyClick
    end
  end
end
