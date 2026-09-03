object UserWarningCommentForm: TUserWarningCommentForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 143
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBackground: TPanel
    Left = 0
    Top = 0
    Width = 630
    Height = 89
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 488
    object LblUserComment: TLabel
      Left = 7
      Top = 11
      Width = 575
      Height = 25
      Caption = #1042#1074#1086#1076' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1103' '#1082' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1086#1084#1091' '#1087#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1102':'
    end
    object EditUserMsg: TEdit
      Left = 7
      Top = 42
      Width = 614
      Height = 33
      TabOrder = 0
      OnKeyUp = EditUserMsgKeyUp
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 89
    Width = 630
    Height = 54
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 488
    object BtnSave: TButton
      Left = 481
      Top = 6
      Width = 140
      Height = 44
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 1
      OnClick = BtnSaveClick
    end
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
    object BtnDrop: TButton
      Left = 248
      Top = 6
      Width = 140
      Height = 44
      Caption = #1057#1073#1088#1086#1089#1090#1080#1090#1100
      TabOrder = 2
      OnClick = BtnDropClick
    end
  end
end
