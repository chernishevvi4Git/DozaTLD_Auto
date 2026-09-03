object SendToCalibrW: TSendToCalibrW
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1085#1072' '#1082#1072#1083#1080#1073#1088#1086#1074#1082#1091
  ClientHeight = 248
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 194
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LblDose: TLabel
      Left = 24
      Top = 80
      Width = 210
      Height = 25
      Caption = #1044#1086#1079#1072' '#1086#1073#1083#1091#1095#1077#1085#1080#1103', '#1084#1047#1074':'
    end
    object LblTitle: TLabel
      Left = 48
      Top = 16
      Width = 346
      Height = 29
      Alignment = taCenter
      Caption = #1059#1082#1072#1078#1080#1090#1077' '#1076#1086#1079#1091' '#1080' '#1090#1080#1087' '#1080#1079#1083#1091#1095#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblRadiationType: TLabel
      Left = 24
      Top = 136
      Width = 151
      Height = 25
      Caption = #1058#1080#1087' '#1080#1079#1083#1091#1095#1077#1085#1080#1103':'
    end
    object LabelDoseErr: TLabel
      Left = 106
      Top = 170
      Width = 239
      Height = 19
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1091#1082#1072#1079#1072#1085#1086' '#1085#1077' '#1082#1086#1088#1088#1077#1082#1090#1085#1086'!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object EditDose: TEdit
      Left = 258
      Top = 77
      Width = 127
      Height = 33
      TabOrder = 0
      OnChange = EditDoseChange
      OnKeyUp = EditDoseKeyUp
    end
    object CBoxRadiationType: TComboBox
      Left = 258
      Top = 133
      Width = 127
      Height = 33
      Style = csDropDownList
      TabOrder = 1
      OnKeyUp = CBoxRadiationTypeKeyUp
    end
  end
  object PanelButtom: TPanel
    Left = 0
    Top = 194
    Width = 447
    Height = 54
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object BtnClose: TButton
      Left = 7
      Top = 6
      Width = 140
      Height = 44
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = BtnCloseClick
    end
    object BtnOk: TButton
      Left = 299
      Top = 6
      Width = 140
      Height = 44
      Caption = #1054#1050
      Enabled = False
      TabOrder = 1
      OnClick = BtnOkClick
    end
  end
end
