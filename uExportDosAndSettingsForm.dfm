object ExportDosAndSettingsForm: TExportDosAndSettingsForm
  Left = 0
  Height = 277
  Top = 0
  Width = 605
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Экспорт дозиметров'
  ClientHeight = 277
  ClientWidth = 605
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Tahoma'
  OnShow = FormShow
  Position = poMainFormCenter
  object PanelBackground: TPanel
    Left = 0
    Height = 277
    Top = 0
    Width = 605
    Align = alClient
    ClientHeight = 277
    ClientWidth = 605
    TabOrder = 0
    object CBExportDosTypes: TCheckBox
      Left = 24
      Height = 29
      Top = 130
      Width = 191
      Caption = 'Типы дозиметров'
      TabOrder = 0
    end
    object CBExportDetTypes: TCheckBox
      Left = 24
      Height = 29
      Top = 170
      Width = 187
      Caption = 'Типы детекторов'
      TabOrder = 1
    end
    object CBExportSettings: TCheckBox
      Left = 24
      Height = 29
      Top = 50
      Width = 226
      Caption = 'Настройки установки'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object BtnOk: TButton
      Left = 460
      Height = 43
      Top = 220
      Width = 125
      Anchors = [akLeft, akBottom]
      Caption = 'Экспорт'
      OnClick = BtnOkClick
      TabOrder = 3
    end
    object BtnCancel: TButton
      Left = 24
      Height = 43
      Top = 220
      Width = 125
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = 'Закрыть'
      OnClick = BtnCancelClick
      TabOrder = 4
    end
    object PanelTop: TPanel
      Left = 1
      Height = 45
      Top = 1
      Width = 603
      Align = alTop
      BevelOuter = bvNone
      ClientHeight = 45
      ClientWidth = 603
      TabOrder = 5
      object LblTitle: TLabel
        Left = 0
        Height = 45
        Top = 0
        Width = 603
        Align = alClient
        Alignment = taCenter
        Caption = 'Экспортировать вместе со списком дозитеров:'
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Tahoma'
        Layout = tlCenter
        ParentColor = False
        ParentFont = False
      end
    end
    object CBExportMeasurments: TCheckBox
      Left = 24
      Height = 29
      Top = 90
      Width = 126
      Caption = 'Измерения'
      TabOrder = 6
    end
  end
end
