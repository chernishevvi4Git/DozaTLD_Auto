object ImportMeasForm: TImportMeasForm
  Left = 0
  Height = 540
  Top = 0
  Width = 859
  Caption = 'ImportMeasForm'
  ClientHeight = 540
  ClientWidth = 859
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnShow = FormShow
  LCLVersion = '2.2.6.0'
  object PanelStringGrid: TPanel
    Left = 0
    Height = 480
    Top = 0
    Width = 859
    Align = alClient
    ClientHeight = 480
    ClientWidth = 859
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 0
    object GaugeMeasImp: TATGauge
      Left = 1
      Height = 39
      Top = 440
      Width = 857
      Align = alBottom
      Color = clBtnFace
      DoubleBuffered = True
      ParentColor = False
      MaxValue = 300
    end
    object StringGridMeas: TStringGrid
      Left = 1
      Height = 439
      Top = 1
      Width = 857
      Align = alClient
      ColCount = 1
      DefaultColWidth = 150
      FixedCols = 0
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      RowCount = 2
      TabOrder = 0
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Height = 60
    Top = 480
    Width = 859
    Align = alBottom
    ClientHeight = 60
    ClientWidth = 859
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 1
    object LblImport: TLabel
      Left = 376
      Height = 25
      Top = 16
      Width = 91
      Caption = 'LblImport'
      ParentColor = False
      Visible = False
    end
    object BtnImport: TButton
      Left = 664
      Height = 43
      Top = 6
      Width = 185
      Caption = 'Импортировать'
      OnClick = BtnImportClick
      TabOrder = 0
    end
    object BtnCancel: TButton
      Left = 8
      Height = 43
      Top = 6
      Width = 185
      Cancel = True
      Caption = 'Закрыть'
      OnClick = BtnCancelClick
      TabOrder = 1
    end
  end
end
