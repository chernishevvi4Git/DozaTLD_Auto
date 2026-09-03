object ModelW: TModelW
  Left = 131
  Height = 960
  Top = 137
  Width = 1045
  Caption = 'ModelW'
  ClientHeight = 960
  ClientWidth = 1045
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Menu = MainMenuModel
  OnShow = FormShow
  Position = poMainFormCenter
  LCLVersion = '2.2.6.0'
  object PanelCharts: TPanel
    Left = 0
    Height = 940
    Top = 0
    Width = 936
    Align = alClient
    BevelOuter = bvNone
    ClientHeight = 940
    ClientWidth = 936
    TabOrder = 0
    object SplitterBottom: TSplitter
      Cursor = crVSplit
      Left = 0
      Height = 3
      Top = 619
      Width = 936
      Align = alBottom
      ResizeAnchor = akBottom
    end
    object SplitterTop: TSplitter
      Cursor = crVSplit
      Left = 0
      Height = 3
      Top = 318
      Width = 936
      Align = alTop
      ResizeAnchor = akTop
    end
    object PanelFon: TPanel
      Left = 0
      Height = 298
      Top = 321
      Width = 936
      Align = alClient
      ClientHeight = 298
      ClientWidth = 936
      TabOrder = 0
      object PanelTopFon: TPanel
        Left = 1
        Height = 49
        Top = 1
        Width = 934
        Align = alTop
        ClientHeight = 49
        ClientWidth = 934
        TabOrder = 0
        object LblFon: TLabel
          Left = 11
          Height = 13
          Top = 2
          Width = 24
          Caption = 'Фон:'
          ParentColor = False
        end
        object EditChartFon: TEdit
          Left = 11
          Height = 24
          Top = 19
          Width = 886
          Anchors = [akTop, akLeft, akRight]
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object BtnOpenFon: TButton
          Left = 902
          Height = 25
          Top = 18
          Width = 25
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = BtnOpenFonClick
          TabOrder = 1
        end
      end
      object PanelChartFon: TPanel
        Left = 1
        Height = 247
        Top = 50
        Width = 934
        Align = alClient
        ClientHeight = 247
        ClientWidth = 934
        TabOrder = 1
        object ChartFon: TChart
          Left = 1
          Height = 235
          Top = 1
          Width = 782
          AxisList = <          
            item
              Grid.Color = 11119017
              Marks.LabelBrush.Style = bsClear
              Minors = <>
              Title.LabelFont.Orientation = 900
              Title.Caption = 'I(t)'
              Title.LabelBrush.Style = bsClear
            end          
            item
              Grid.Color = 11119017
              Alignment = calBottom
              Marks.LabelBrush.Style = bsClear
              Minors = <>
              Title.LabelBrush.Style = bsClear
            end>
          Foot.Font.Color = clBlue
          Foot.Font.Name = 'Verdana'
          Legend.Font.Name = 'Verdana'
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Tahoma'
          Title.Text.Strings = (
            ''
          )
          Align = alClient
          Color = 15790320
          object SeriesKTVFon: TLineSeries
            Title = 'ktv'
            LinePen.Color = clRed
            LinePen.Width = 2
            Pointer.HorizSize = 6
            Pointer.Style = psCircle
            Pointer.VertSize = 6
            Pointer.Visible = True
            ShowPoints = True
          end
          object SeriesLineFon: TLineSeries
            Title = 'Line'
            LinePen.Width = 2
          end
          object SeriesAreaFon: TAreaSeries
            Transparency = 40
            Title = 'Area'
            AreaBrush.Color = 11711154
          end
        end
        object PanelConfigFon: TPanel
          Left = 783
          Height = 235
          Top = 1
          Width = 150
          Align = alRight
          ClientHeight = 235
          ClientWidth = 150
          TabOrder = 1
          object LblSFon: TLabel
            Left = 6
            Height = 13
            Top = 75
            Width = 51
            Caption = 'Площадь:'
            ParentColor = False
          end
          object GroupBoxChangeFon: TGroupBox
            Left = 6
            Height = 68
            Top = 5
            Width = 131
            Caption = 'Изменить форму:'
            ClientHeight = 50
            ClientWidth = 127
            TabOrder = 0
            object LabelKFon: TLabel
              Left = 6
              Height = 13
              Top = 23
              Width = 10
              Caption = 'K:'
              ParentColor = False
            end
            object EditKFon: TEdit
              Left = 19
              Height = 21
              Top = 20
              Width = 46
              TabOrder = 0
            end
            object BtnPlusFon: TButton
              Left = 71
              Height = 25
              Top = 18
              Width = 25
              Caption = '+'
              OnClick = BtnPlusFonClick
              TabOrder = 1
            end
            object BtnMinusFon: TButton
              Left = 102
              Height = 25
              Top = 18
              Width = 25
              Caption = '-'
              OnClick = BtnMinusFonClick
              TabOrder = 2
            end
            object CBZeroFon: TCheckBox
              Left = 16
              Height = 19
              Top = 47
              Width = 61
              Caption = 'От нуля'
              Checked = True
              State = cbChecked
              TabOrder = 3
            end
          end
          object BtnResetFon: TButton
            Left = 6
            Height = 25
            Top = 121
            Width = 112
            Caption = 'Сбросить'
            OnClick = BtnResetFonClick
            TabOrder = 1
          end
          object EditSFon: TEdit
            Left = 6
            Height = 21
            Top = 94
            Width = 112
            ReadOnly = True
            TabOrder = 2
          end
          object BtnSaveToFileFon: TButton
            Left = 6
            Height = 25
            Top = 152
            Width = 112
            Caption = 'Сохранить в файл'
            OnClick = BtnSaveToFileFonClick
            TabOrder = 3
          end
          object BtnSaveCalcFon: TButton
            Left = 6
            Height = 25
            Top = 183
            Width = 112
            Caption = 'Сохр. calcFon'
            OnClick = BtnSaveCalcFonClick
            TabOrder = 4
          end
          object BtnDigitFon: TButton
            Left = 6
            Height = 25
            Top = 214
            Width = 112
            Caption = 'DigizeFon'
            OnClick = BtnDigitFonClick
            TabOrder = 5
          end
        end
        object StringGridFon: TStringGrid
          Left = 1
          Height = 10
          Top = 236
          Width = 932
          Align = alBottom
          ColCount = 1
          FixedCols = 0
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          RowCount = 1
          TabOrder = 2
          Visible = False
          OnDrawCell = StringGridPeakDrawCell
          ColWidths = (
            87
          )
        end
      end
    end
    object PanelFonPeak: TPanel
      Left = 0
      Height = 318
      Top = 622
      Width = 936
      Align = alBottom
      ClientHeight = 318
      ClientWidth = 936
      TabOrder = 1
      object PanelChartFonPeak: TPanel
        Left = 1
        Height = 267
        Top = 50
        Width = 934
        Align = alClient
        ClientHeight = 267
        ClientWidth = 934
        TabOrder = 0
        object ChartFonPeak: TChart
          Left = 1
          Height = 255
          Top = 1
          Width = 782
          AxisList = <          
            item
              Grid.Color = 11119017
              Marks.LabelBrush.Style = bsClear
              Minors = <>
              Title.LabelFont.Orientation = 900
              Title.Caption = 'I(t)'
              Title.LabelBrush.Style = bsClear
            end          
            item
              Grid.Color = 11119017
              Alignment = calBottom
              Marks.LabelBrush.Style = bsClear
              Minors = <>
              Title.LabelBrush.Style = bsClear
            end>
          Foot.Font.Color = clBlue
          Foot.Font.Name = 'Verdana'
          Legend.Font.Name = 'Verdana'
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Tahoma'
          Title.Text.Strings = (
            ''
          )
          Align = alClient
          Color = 15790320
          object SeriesKTVFonPeak: TLineSeries
            Title = 'ktv'
            LinePen.Color = clRed
            LinePen.Width = 2
            Pointer.HorizSize = 6
            Pointer.Style = psCircle
            Pointer.VertSize = 6
            Pointer.Visible = True
            ShowPoints = True
          end
          object SeriesLineFonPeak: TLineSeries
            Title = 'Line'
            LinePen.Width = 2
          end
          object SeriesAreaFonPeak: TAreaSeries
            Transparency = 40
            Title = 'Area'
            AreaBrush.Color = 11711154
          end
        end
        object PanelConfigFonPeak: TPanel
          Left = 783
          Height = 255
          Top = 1
          Width = 150
          Align = alRight
          ClientHeight = 255
          ClientWidth = 150
          TabOrder = 1
          object LblSFonPeak: TLabel
            Left = 6
            Height = 13
            Top = 75
            Width = 51
            Caption = 'Площадь:'
            ParentColor = False
          end
          object GroupBoxChangeFonPeak: TGroupBox
            Left = 6
            Height = 68
            Top = 5
            Width = 131
            Caption = 'Изменить форму:'
            ClientHeight = 50
            ClientWidth = 127
            TabOrder = 0
            object LabelKFonPeak: TLabel
              Left = 6
              Height = 13
              Top = 23
              Width = 10
              Caption = 'K:'
              ParentColor = False
            end
            object EditKFonPeak: TEdit
              Left = 19
              Height = 21
              Top = 20
              Width = 46
              TabOrder = 0
            end
            object BtnPlusFonPeak: TButton
              Left = 71
              Height = 25
              Top = 18
              Width = 25
              Caption = '+'
              OnClick = BtnPlusFonPeakClick
              TabOrder = 1
            end
            object BtnMinusFonPeak: TButton
              Left = 103
              Height = 25
              Top = 18
              Width = 25
              Caption = '-'
              OnClick = BtnMinusFonPeakClick
              TabOrder = 2
            end
            object CBZeroFonPeak: TCheckBox
              Left = 16
              Height = 19
              Top = 47
              Width = 61
              Caption = 'От нуля'
              Checked = True
              State = cbChecked
              TabOrder = 3
            end
          end
          object BtnResetFonPeak: TButton
            Left = 6
            Height = 25
            Top = 121
            Width = 112
            Caption = 'Сбросить'
            OnClick = BtnResetFonPeakClick
            TabOrder = 1
          end
          object EditSFonPeak: TEdit
            Left = 6
            Height = 21
            Top = 94
            Width = 112
            ReadOnly = True
            TabOrder = 2
          end
          object BtnSaveToFileFonPeak: TButton
            Left = 6
            Height = 25
            Top = 152
            Width = 112
            Caption = 'Сохранить в файл'
            OnClick = BtnSaveToFileFonPeakClick
            TabOrder = 3
          end
        end
        object StringGridFonPeak: TStringGrid
          Left = 1
          Height = 10
          Top = 256
          Width = 932
          Align = alBottom
          ColCount = 1
          FixedCols = 0
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          RowCount = 1
          TabOrder = 2
          Visible = False
          OnDrawCell = StringGridPeakDrawCell
          ColWidths = (
            87
          )
        end
      end
      object PanelTopFonPeak: TPanel
        Left = 1
        Height = 49
        Top = 1
        Width = 934
        Align = alTop
        ClientHeight = 49
        ClientWidth = 934
        TabOrder = 1
        object LblFonPeak: TLabel
          Left = 11
          Height = 13
          Top = 2
          Width = 57
          Caption = 'Фон + Пик:'
          ParentColor = False
        end
        object EditChartFonPeak: TEdit
          Left = 11
          Height = 24
          Top = 19
          Width = 886
          Anchors = [akTop, akLeft, akRight]
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object BtnOpenFonPeak: TButton
          Left = 902
          Height = 25
          Top = 18
          Width = 25
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = BtnOpenFonPeakClick
          TabOrder = 1
        end
      end
    end
    object PanelPeak: TPanel
      Left = 0
      Height = 318
      Top = 0
      Width = 936
      Align = alTop
      ClientHeight = 318
      ClientWidth = 936
      TabOrder = 2
      object PanelTopPeak: TPanel
        Left = 1
        Height = 49
        Top = 1
        Width = 934
        Align = alTop
        ClientHeight = 49
        ClientWidth = 934
        TabOrder = 0
        object LblPeak: TLabel
          Left = 11
          Height = 13
          Top = 3
          Width = 23
          Caption = 'Пик:'
          ParentColor = False
        end
        object EditChartPeak: TEdit
          Left = 11
          Height = 24
          Top = 19
          Width = 886
          Anchors = [akTop, akLeft, akRight]
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object BtnOpenPeak: TButton
          Left = 902
          Height = 25
          Top = 18
          Width = 25
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = BtnOpenPeakClick
          TabOrder = 1
        end
      end
      object PanelChartPeak: TPanel
        Left = 1
        Height = 267
        Top = 50
        Width = 934
        Align = alClient
        ClientHeight = 267
        ClientWidth = 934
        TabOrder = 1
        object StringGridPeak: TStringGrid
          Left = 1
          Height = 10
          Top = 256
          Width = 932
          Align = alBottom
          ColCount = 1
          FixedCols = 0
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          RowCount = 1
          TabOrder = 0
          Visible = False
          OnDrawCell = StringGridPeakDrawCell
          ColWidths = (
            87
          )
        end
        object ChartPeak: TChart
          Left = 1
          Height = 255
          Top = 1
          Width = 782
          AxisList = <          
            item
              Grid.Color = 11119017
              Marks.LabelBrush.Style = bsClear
              Minors = <>
              Title.LabelFont.Orientation = 900
              Title.Caption = 'I(t)'
              Title.LabelBrush.Style = bsClear
            end          
            item
              Grid.Color = 11119017
              Alignment = calBottom
              Marks.LabelBrush.Style = bsClear
              Minors = <>
              Title.LabelBrush.Style = bsClear
            end>
          Foot.Font.Color = clBlue
          Foot.Font.Name = 'Verdana'
          Legend.Font.Name = 'Verdana'
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'Tahoma'
          Title.Text.Strings = (
            ''
          )
          Align = alClient
          Color = 15790320
          object SeriesKTVPeak: TLineSeries
            Title = 'ktv'
            LinePen.Color = clRed
            LinePen.Width = 2
            Pointer.HorizSize = 6
            Pointer.Style = psCircle
            Pointer.VertSize = 6
            Pointer.Visible = True
            ShowPoints = True
          end
          object SeriesLinePeak: TLineSeries
            Title = 'Line'
            LinePen.Width = 2
          end
          object SeriesAreaPeak: TAreaSeries
            Transparency = 40
            Title = 'Area'
            AreaBrush.Color = 11711154
          end
        end
        object PanelConfigPeak: TPanel
          Left = 783
          Height = 255
          Top = 1
          Width = 150
          Align = alRight
          ClientHeight = 255
          ClientWidth = 150
          Constraints.MinHeight = 250
          TabOrder = 2
          object LblSPeak: TLabel
            Left = 6
            Height = 13
            Top = 143
            Width = 51
            Caption = 'Площадь:'
            ParentColor = False
          end
          object GroupBoxChangePeak: TGroupBox
            Left = 6
            Height = 68
            Top = 5
            Width = 131
            Caption = 'Увеличить/Уменьшить:'
            ClientHeight = 50
            ClientWidth = 127
            TabOrder = 0
            object LabelKPeak: TLabel
              Left = 6
              Height = 13
              Top = 23
              Width = 10
              Caption = 'K:'
              ParentColor = False
            end
            object EditKPeak: TEdit
              Left = 19
              Height = 21
              Top = 20
              Width = 46
              TabOrder = 0
            end
            object BtnPlusPeak: TButton
              Left = 71
              Height = 25
              Top = 18
              Width = 25
              Caption = '+'
              OnClick = BtnPlusPeakClick
              TabOrder = 1
            end
            object BtnMinusPeak: TButton
              Left = 102
              Height = 25
              Top = 18
              Width = 25
              Caption = '-'
              OnClick = BtnMinusPeakClick
              TabOrder = 2
            end
            object CBZeroPeak: TCheckBox
              Left = 16
              Height = 19
              Top = 47
              Width = 61
              Caption = 'От нуля'
              Checked = True
              State = cbChecked
              TabOrder = 3
            end
          end
          object BtnResetPeak: TButton
            Left = 6
            Height = 25
            Top = 189
            Width = 112
            Caption = 'Сбросить'
            OnClick = BtnResetPeakClick
            TabOrder = 1
          end
          object EditSPeak: TEdit
            Left = 6
            Height = 21
            Top = 162
            Width = 112
            ReadOnly = True
            TabOrder = 2
          end
          object BtnSaveToFilePeak: TButton
            Left = 6
            Height = 25
            Top = 220
            Width = 112
            Caption = 'Сохранить в файл'
            OnClick = BtnSaveToFilePeakClick
            TabOrder = 3
          end
          object GroupBoxStretchPeak: TGroupBox
            Left = 6
            Height = 70
            Top = 75
            Width = 129
            Caption = 'Растянуть/Сжать:'
            ClientHeight = 52
            ClientWidth = 125
            TabOrder = 4
            object Label1: TLabel
              Left = 6
              Height = 13
              Top = 23
              Width = 10
              Caption = 'K:'
              ParentColor = False
            end
            object EditStretchPeak: TEdit
              Left = 19
              Height = 21
              Top = 20
              Width = 46
              NumbersOnly = True
              TabOrder = 0
            end
            object CBSaveS: TCheckBox
              Left = 16
              Height = 19
              Top = 47
              Width = 98
              Caption = 'Сохр. площадь'
              TabOrder = 1
            end
            object Button2: TButton
              Left = 71
              Height = 25
              Top = 18
              Width = 25
              Caption = '+'
              OnClick = Button2Click
              TabOrder = 2
            end
            object Button3: TButton
              Left = 102
              Height = 25
              Top = 18
              Width = 25
              Caption = '-'
              OnClick = Button3Click
              TabOrder = 3
            end
          end
        end
      end
    end
  end
  object PanelRight: TPanel
    Left = 936
    Height = 940
    Top = 0
    Width = 109
    Align = alRight
    ClientHeight = 940
    ClientWidth = 109
    TabOrder = 1
    object LblDosPeak: TLabel
      Left = 10
      Height = 13
      Top = 5
      Width = 53
      Caption = 'Дозиметр:'
      ParentColor = False
    end
    object BtnImport: TButton
      Left = 10
      Height = 25
      Top = 78
      Width = 89
      Caption = 'Импортировать'
      OnClick = BtnImportClick
      TabOrder = 0
    end
    object CBoxDos: TComboBox
      Left = 10
      Height = 21
      Top = 24
      Width = 89
      ItemHeight = 13
      TabOrder = 1
    end
    object EditMeasComment: TEdit
      Left = 10
      Height = 21
      Top = 51
      Width = 89
      TabOrder = 2
    end
    object GroupBox1: TGroupBox
      Left = 6
      Height = 297
      Top = 144
      Width = 99
      Caption = 'Auto'
      ClientHeight = 279
      ClientWidth = 95
      TabOrder = 3
      object Label2: TLabel
        Left = 18
        Height = 13
        Top = 28
        Width = 33
        Caption = 'min (x)'
        ParentColor = False
      end
      object Label3: TLabel
        Left = 18
        Height = 13
        Top = 77
        Width = 37
        Caption = 'max (x)'
        ParentColor = False
      end
      object Label4: TLabel
        Left = 15
        Height = 13
        Top = 133
        Width = 62
        Caption = 'K= A (Ax+B)'
        ParentColor = False
      end
      object Label5: TLabel
        Left = 15
        Height = 13
        Top = 189
        Width = 61
        Caption = 'K= B (Ax+B)'
        ParentColor = False
      end
      object AutoSE_Min: TSpinEdit
        Left = 13
        Height = 21
        Top = 47
        Width = 83
        TabOrder = 0
        Value = 1
      end
      object AutoSE_Max: TSpinEdit
        Left = 13
        Height = 21
        Top = 96
        Width = 83
        TabOrder = 1
        Value = 10
      end
      object AutoSE_A: TSpinEdit
        Left = 13
        Height = 21
        Top = 152
        Width = 83
        TabOrder = 2
        Value = 1
      end
      object AutoSE_B: TSpinEdit
        Left = 13
        Height = 21
        Top = 208
        Width = 83
        TabOrder = 3
      end
    end
    object AutoCB_UseAuto: TCheckBox
      Left = 24
      Height = 19
      Top = 418
      Width = 64
      Caption = 'Use Auto'
      TabOrder = 4
    end
    object BtnLoadFromFile: TButton
      Left = 16
      Height = 25
      Top = 633
      Width = 75
      Caption = 'Загрузить'
      OnClick = BtnLoadFromFileClick
      TabOrder = 5
    end
  end
  object OpenDialogChart: TOpenDialog
    Left = 961
    Top = 570
  end
  object MainMenuModel: TMainMenu
    Left = 962
    Top = 419
    object MainMenuFile: TMenuItem
      Caption = 'Файл'
      object MenuFileDefaultSize: TMenuItem
        Caption = 'Расположить окна по умолчанию'
        OnClick = MenuFileDefaultSizeClick
      end
    end
  end
  object SaveTextFileChart: TSaveDialog
    DefaultExt = '.txt'
    Left = 960
    Top = 520
  end
  object OpenDialogTxt: TOpenDialog
    Left = 968
    Top = 672
  end
  object ADOQueryModel: TSQLQuery
    FieldDefs = <>
    Params = <>
    Macros = <>
    Left = 40
    Top = 6
  end
end
