object ImportInCurrentDBForm: TImportInCurrentDBForm
  Left = 1
  Height = 295
  Top = 1
  Width = 619
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ImportInCurrentDBForm'
  ClientHeight = 295
  ClientWidth = 619
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poMainFormCenter
  object PanelClient: TPanel
    Left = 0
    Height = 240
    Top = 0
    Width = 619
    Align = alClient
    ClientHeight = 240
    ClientWidth = 619
    TabOrder = 0
    object LblProgressBar: TLabel
      Left = 8
      Height = 63
      Top = 130
      Width = 601
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'LblProgressBar'
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object ProgressBar: TProgressBar
      Left = 8
      Height = 31
      Top = 196
      Width = 601
      Anchors = [akLeft, akBottom]
      TabOrder = 1
    end
    object GroupBoxImport: TGroupBox
      Left = 8
      Height = 122
      Top = 7
      Width = 601
      Caption = 'Укажите импортируемый файл:'
      ClientHeight = 94
      ClientWidth = 597
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      ParentFont = False
      TabOrder = 0
      object SpeedBtnOpenFile: TSpeedButton
        Left = 553
        Height = 32
        Top = 8
        Width = 32
        Caption = '...'
        OnClick = SpeedBtnOpenFileClick
      end
      object LblBackupFileNameErr: TLabel
        Left = 16
        Height = 19
        Top = 40
        Width = 157
        Caption = 'LblBackupFileNameErr'
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object EditImportPath: TEdit
        Left = 16
        Height = 31
        Top = 8
        Width = 531
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Height = 55
    Top = 240
    Width = 619
    Align = alBottom
    ClientHeight = 55
    ClientWidth = 619
    TabOrder = 1
    object BtnClose: TButton
      Left = 8
      Height = 41
      Top = 6
      Width = 140
      Caption = 'Закрыть'
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      OnClick = BtnCloseClick
      ParentFont = False
      TabOrder = 1
    end
    object BtnOk: TButton
      Left = 469
      Height = 41
      Top = 6
      Width = 140
      Caption = 'OK'
      Default = True
      Enabled = False
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      OnClick = BtnOkClick
      ParentFont = False
      TabOrder = 0
    end
  end
  object OpenDialogBackupFile: TOpenDialog
    Left = 560
    Top = 88
  end
end
