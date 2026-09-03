object AddInQueueW: TAddInQueueW
  Left = 422
  Height = 156
  Top = 182
  Width = 469
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 156
  ClientWidth = 469
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnClose = FormClose
  OnShow = FormShow
  Position = poOwnerFormCenter
  LCLVersion = '2.2.6.0'
  object PanelQueue: TPanel
    Left = 0
    Height = 95
    Top = 0
    Width = 469
    Align = alClient
    ClientHeight = 95
    ClientWidth = 469
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 0
    object Lbl: TLabel
      Left = 16
      Height = 25
      Top = 24
      Width = 131
      Caption = 'Дозиметр №:'
      ParentColor = False
    end
    object LblErr: TLabel
      Left = 160
      Height = 19
      Top = 55
      Width = 42
      Caption = 'LblErr'
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      ParentColor = False
      ParentFont = False
    end
    object CBoxAddQueue: TComboBoxEx
      Left = 160
      Height = 24
      Top = 15
      Width = 286
      AutoCompleteOptions = [acoAutoSuggest]
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      ItemHeight = 16
      ItemsEx = <>
      ParentFont = False
      TabOrder = 0
    end
  end
  object PanelQueueBottom: TPanel
    Left = 0
    Height = 61
    Top = 95
    Width = 469
    Align = alBottom
    ClientHeight = 61
    ClientWidth = 469
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 1
    object BtnAdd: TButton
      Left = 304
      Height = 43
      Top = 10
      Width = 142
      Caption = 'Добавить'
      OnClick = BtnAddClick
      TabOrder = 0
    end
    object BtnExit: TButton
      Left = 11
      Height = 43
      Top = 10
      Width = 142
      Caption = 'Закрыть'
      OnClick = BtnExitClick
      TabOrder = 1
    end
  end
  object ADOQueryQueueCB: TSQLQuery
    FieldDefs = <>
    Params = <>
    Macros = <>
    Left = 229
    Top = 68
  end
end
