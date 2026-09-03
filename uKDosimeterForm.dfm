object KDosimeterForm: TKDosimeterForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1072#1089#1095#1077#1090' '#1050'-'#1076#1086#1079#1080#1084#1077#1090#1088#1072
  ClientHeight = 410
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LblDose: TLabel
    Left = 24
    Top = 18
    Width = 50
    Height = 13
    Caption = #1044#1086#1079#1072', '#1084#1047#1074
  end
  object EditSourceDose: TEdit
    Left = 24
    Top = 37
    Width = 81
    Height = 21
    TabOrder = 0
  end
  object BtnCalc: TButton
    Left = 24
    Top = 78
    Width = 145
    Height = 41
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100' '#1050'-'#1076#1086#1079#1080#1084#1077#1090#1088#1072
    TabOrder = 1
    OnClick = BtnCalcClick
  end
  object VLEDosimeters: TValueListEditor
    Left = 192
    Top = 17
    Width = 233
    Height = 383
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
    TabOrder = 2
    TitleCaptions.Strings = (
      #1044#1086#1079#1080#1084#1077#1090#1088
      #1050'-'#1076#1086#1079#1080#1084#1077#1090#1088#1072)
    ColWidths = (
      102
      125)
  end
  object BtnAccept: TButton
    Left = 24
    Top = 360
    Width = 145
    Height = 41
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 3
    OnClick = BtnAcceptClick
  end
  object BtnCancel: TButton
    Left = 24
    Top = 141
    Width = 145
    Height = 42
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1088#1072#1089#1095#1077#1090
    TabOrder = 4
    OnClick = BtnCancelClick
  end
end
