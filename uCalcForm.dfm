object CalcForm: TCalcForm
  Left = 1283
  Height = 714
  Top = 325
  Width = 1020
  Caption = 'Расчётный модуль'
  ClientHeight = 714
  ClientWidth = 1020
  Color = clBtnFace
  Constraints.MinHeight = 714
  Constraints.MinWidth = 1000
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  KeyPreview = True
  Menu = MainMenu
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  Position = poMainFormCenter
  LCLVersion = '3.6.0.0'
  object Label16: TLabel
    Left = 268
    Height = 81
    Top = 211
    Width = 462
    Caption = 'Нет измерения'
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Tahoma'
    ParentColor = False
    ParentFont = False
  end
  object PanelChart: TPanel
    Left = 0
    Height = 714
    Top = 0
    Width = 1020
    Align = alClient
    Caption = 'Нет измерения'
    ClientHeight = 714
    ClientWidth = 1020
    ParentBackground = False
    TabOrder = 0
    object ChartCalc: TChart
      Left = 1
      Height = 712
      Top = 1
      Width = 1018
      AxisList = <      
        item
          Marks.LabelBrush.Style = bsClear
          Minors = <>
          Title.LabelFont.Orientation = 900
          Title.Visible = True
          Title.Caption = 'I(t)'
          Title.LabelBrush.Style = bsClear
          Transformations = CAT_Auto1
        end      
        item
          Grid.Color = 11119017
          Alignment = calBottom
          Marks.LabelBrush.Style = bsClear
          Minors = <>
          Title.LabelBrush.Style = bsClear
        end      
        item
          Grid.Visible = False
          Alignment = calRight
          Marks.LabelFont.Color = clMaroon
          Marks.LabelBrush.Style = bsClear
          Minors = <>
          Title.Alignment = taCenter
          Title.Attachment = maCenter
          Title.LabelFont.Color = clMaroon
          Title.LabelFont.Orientation = 900
          Title.Visible = True
          Title.Caption = 't (℃)'
          Title.LabelBrush.Style = bsClear
          Transformations = CAT_Auto2
        end>
      Foot.Alignment = taLeftJustify
      Foot.Font.Color = 4194432
      Foot.Font.Height = -16
      Foot.Font.Name = 'Verdana'
      Foot.TextFormat = tfHTML
      Foot.Visible = True
      Foot.Wordwrap = True
      Legend.BackgroundBrush.Color = 16646143
      Legend.FixedItemWidth = 215
      Legend.Font.Height = -13
      Legend.Font.Name = 'Verdana'
      Legend.Frame.Color = clHighlight
      Legend.GroupFont.Style = [fsItalic]
      Legend.GroupTitles.Strings = (
        'Исходные данные'
        'Фон'
        'Пик'
        'Расчёт'
        'Температура'
      )
      Legend.Visible = True
      Title.Font.Color = clBlack
      Title.Font.Height = -16
      Title.Font.Name = 'Tahoma'
      Title.Text.Strings = (
        '<font size = "6" color = #fa8e47>MAIN TITLE</font>'
        '<font size = "4" color = #010101>SECOND TITLE</font>'
        ''
        ''
      )
      Title.TextFormat = tfHTML
      Title.Visible = True
      Toolset = ChartToolset1
      OnAfterDraw = ChartCalcAfterDraw
      OnAfterDrawBackWall = ChartCalcAfterDrawBackWall
      Align = alClient
      Color = clWhite
      PopupMenu = PopupMenu_ChooseSeries
      OnMouseDown = ChartCalcMouseDown
      OnMouseMove = ChartCalcMouseMove
      OnMouseUp = ChartCalcMouseUp
      OnResize = ChartCalcResize
      object SeriesFon: TAreaSeries
        Legend.GroupIndex = 1
        Title = 'Функция фона'
        AxisIndexX = 1
        AxisIndexY = 0
        AreaBrush.Color = 10010796
        AreaContourPen.Color = clGreen
        AreaLinesPen.Style = psClear
      end
      object SeriesInterestRegion: TAreaSeries
        Legend.GroupIndex = 3
        Title = 'Область рассчёта'
        AxisIndexX = 1
        AxisIndexY = 0
        AreaBrush.Color = 3114489
        AreaLinesPen.Style = psClear
      end
      object SeriesSRC: TLineSeries
        Legend.GroupIndex = 0
        Title = 'Точки КТВ'
        AxisIndexX = 1
        AxisIndexY = 0
        LinePen.Color = 8388672
        LineType = ltNone
        Pointer.HorizSize = 3
        Pointer.Style = psCircle
        Pointer.VertSize = 3
        Pointer.Visible = True
        ShowPoints = True
      end
      object SeriesGlade: TLineSeries
        Legend.GroupIndex = 0
        Title = 'Сглаженная КТВ'
        AxisIndexX = 1
        AxisIndexY = 0
        LinePen.Color = clBlue
        Pointer.Pen.Style = psDot
      end
      object SeriesFuncPik2: TLineSeries
        Legend.GroupIndex = 2
        Title = 'Пик 4'
        AxisIndexX = 1
        AxisIndexY = 0
        LinePen.Color = 16711808
      end
      object SeriesFuncPik1: TLineSeries
        Legend.GroupIndex = 2
        Title = 'Пик 5'
        AxisIndexX = 1
        AxisIndexY = 0
        LinePen.Color = 16711808
      end
      object SeriesSumPeaks: TLineSeries
        Legend.GroupIndex = 2
        Title = 'Сумма пиков'
        AxisIndexX = 1
        AxisIndexY = 0
        LinePen.Color = 8404992
        Pointer.Brush.Color = clBlack
        Pointer.Style = psHexagon
      end
      object SeriesTempProfil: TLineSeries
        Legend.GroupIndex = 4
        Title = 'Профиль температур'
        AxisIndexX = 1
        AxisIndexY = 2
        LinePen.Color = clSkyBlue
        LinePen.Width = 4
        Pointer.Pen.Width = 4
      end
    end
    object Btn_ClearWarning: TButton
      Left = 856
      Height = 30
      Top = 680
      Width = 159
      Anchors = [akRight, akBottom]
      Caption = 'Сбросить предупреждение'
      TabOrder = 2
      OnClick = Btn_ClearWarningClick
    end
    object PanelInChart: TPanel
      Left = 788
      Height = 344
      Top = 336
      Width = 216
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      BevelWidth = 2
      ClientHeight = 344
      ClientWidth = 216
      Color = clWhite
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      object Label_Err: TLabel
        Left = 3
        Height = 13
        Top = 104
        Width = 36
        Caption = 'χ²  (%)'
        ParentColor = False
      end
      object Label_S: TLabel
        Left = 0
        Height = 13
        Top = 78
        Width = 25
        Caption = 'Доза'
        ParentColor = False
      end
      object SB_UserWarning: TSpeedButton
        Left = 160
        Height = 30
        Top = 257
        Width = 30
        AllowAllUp = True
        Flat = True
        Glyph.Data = {
          76060000424D7606000000000000360400002800000018000000180000000100
          0800000000004002000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A6000020400000206000002080000020A0000020C0000020E000004000000040
          20000040400000406000004080000040A0000040C0000040E000006000000060
          20000060400000606000006080000060A0000060C0000060E000008000000080
          20000080400000806000008080000080A0000080C0000080E00000A0000000A0
          200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
          200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
          200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
          20004000400040006000400080004000A0004000C0004000E000402000004020
          20004020400040206000402080004020A0004020C0004020E000404000004040
          20004040400040406000404080004040A0004040C0004040E000406000004060
          20004060400040606000406080004060A0004060C0004060E000408000004080
          20004080400040806000408080004080A0004080C0004080E00040A0000040A0
          200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
          200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
          200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
          20008000400080006000800080008000A0008000C0008000E000802000008020
          20008020400080206000802080008020A0008020C0008020E000804000008040
          20008040400080406000804080008040A0008040C0008040E000806000008060
          20008060400080606000806080008060A0008060C0008060E000808000008080
          20008080400080806000808080008080A0008080C0008080E00080A0000080A0
          200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
          200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
          200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
          2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
          2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
          2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
          2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
          2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
          2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
          2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          00000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF0000FF0E0EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E0E
          FF0000FF0E0E0EFFFFFFFFFFFFFFFFFFFFFFFFFFFF0E0E0EFF0000FFFF0E0E0E
          FFFFFFFFFFFFFFFFFFFFFFFF0E0E0EFFFF0000FFFFFF0E0E0EFFFFFFFFFFFFFF
          FFFFFF0E0E0EFFFFFF0000FFFFFFFF0E0E0EFFFFFFFFFFFFFFFF0E0E0EFFFFFF
          FF0000FFFFFFFFFF0E0E0EFFFFFFFFFFFF0E0E0EFFFFFFFFFF0000FFFFFFFFFF
          FF0E0E0EFFFFFFFF0E0E0EFFFFFFFFFFFF0000FFFFFFFFFFFFFF0E0E0EFFFF0E
          0E0EFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFF0E0E0E0E0E0EFFFFFFFFFFFFFF
          FF0000FFFFFFFFFFFFFFFFFF0E0E0E0EFFFFFFFFFFFFFFFFFF0000FFFFFFFFFF
          FFFFFFFF0E0E0E0EFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFF0E0E0E0E0E
          0EFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF0E0E0EFFFF0E0E0EFFFFFFFFFFFF
          FF0000FFFFFFFFFFFF0E0E0EFFFFFFFF0E0E0EFFFFFFFFFFFF0000FFFFFFFFFF
          0E0E0EFFFFFFFFFFFF0E0E0EFFFFFFFFFF0000FFFFFFFF0E0E0EFFFFFFFFFFFF
          FFFF0E0E0EFFFFFFFF0000FFFFFF0E0E0EFFFFFFFFFFFFFFFFFFFF0E0E0EFFFF
          FF0000FFFF0E0E0EFFFFFFFFFFFFFFFFFFFFFFFF0E0E0EFFFF0000FF0E0E0EFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF0E0E0EFF0000FF0E0EFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF0E0EFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00000000000000000000000000000000000000000000000000
        }
        GroupIndex = 1
        Transparent = False
        OnClick = SB_UserWarningClick
        ShowHint = True
        ParentShowHint = False
      end
      object Edit_S: TEdit
        Left = 55
        Height = 23
        Top = 72
        Width = 104
        Alignment = taCenter
        BorderStyle = bsNone
        Color = clMoneyGreen
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Tahoma'
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 2
        Text = '10'
        OnEnter = Edit_Enter
        OnExit = Edit_Exit
      end
      object Edit_Err: TEdit
        Left = 55
        Height = 19
        Top = 102
        Width = 104
        Alignment = taCenter
        BorderStyle = bsNone
        Color = clMoneyGreen
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = '10'
        OnEnter = Edit_Enter
        OnExit = Edit_Exit
      end
      object Btn_Save: TBitBtn
        Left = 0
        Height = 30
        Top = 257
        Width = 159
        Caption = 'Сохранить'
        Enabled = False
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        OnClick = Btn_SaveClick
        ParentFont = False
        TabOrder = 4
      end
      object Btn_GetDefault: TBitBtn
        Left = 0
        Height = 30
        Hint = 'Перечитать из базы данных последний сохраненный расчет'
        Top = 0
        Width = 159
        Caption = 'Откат к сохраненному'
        Enabled = False
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        OnClick = Btn_GetDefaultClick
        ParentFont = False
        TabOrder = 0
      end
      object BtnOptions: TBitBtn
        Left = 161
        Height = 30
        Hint = 'Алгоритм'
        Top = 32
        Width = 33
        Glyph.Data = {
          42080000424D4208000000000000420000002800000020000000200000000100
          1000030000000008000000000000000000000000000000000000007C0000E003
          00001F000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7F8C3110428C31FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FCE39
          6B2DFF7FFF7FFF7FCE394C4ACE39FF7FFF7FFF7FCE398C318C31FF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F524ACE39
          6B2D6B2DFF7FFF7F4C66257F4C66FF7FFF7FCE39524ACE396B2D6B2DFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F524AE73D
          6B2D8C316B2DCE394C66257F4C666B2D6B2DCE39744EE73DE73D6B2DFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FC514C514C514C514C5142C67257F
          4566E73D8C31CE39254B257F4C666B2D8C314C4A45662567257F4C4AFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F396710421042104210422C67257F
          257F257F257F257F257F257F257F257F257F257F257F2567FF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F5A6B10428C316B2D6B2D4C66
          257F257F257F327F327F327F327F297F257F257F25678C316B2D6B2DFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F5A6B8C318C316B2D8C314C4A
          257F257F297F2C674C4AE03D8531297F257F257F25678C316B2D6B2D6B2DFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F5A6B297F4C66454A454A4566
          257F297FF27F297F2C67454AE03DE73D297F257F257F257F257F257F2567FF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F5A6B5A6B327F257F257F257F
          257F297FF27F297F2C67454AE03D85314566257F257FE73D4C664C66FF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F8C317B6FBC735A6BE73D454A
          257F257FF27F297F2C67454AE03D8531257F257F8531C514FF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F8C31D5569B6FF75E454A2567
          257F257FF27F297F2C67454AE03D8531257F257F454A8531C514FF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F8C31D556FF7F9B6F327F257F
          297F3267F27F297F2C67454AE03D8531297F2567257F257FE73DFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F8C31D556FF7FFF7F7B6F327F
          F75E5A6BF27F297F2C67454AE03D85316B2D4C66327F2567FF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F8C318C318C318C318C31F75E
          5A6B5A6BF27F327FF27F2C67454AE73D6B2DC514FF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F5A6B5A6B5A6B5A6B5A6B5A6B
          5A6B5A6B3967F27FEF7FF27F2C674C4A6B2DC514FF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F5A6B5A6B5A6B5A6B5A6B5A6B
          5A6B5A6B39675A6B2C4B2C4B2C4B5A6B6B2DC514FF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F8C317B6F9B6F7B6F7B6F9B6F
          5A6B5A6B3967396739673967396739676B2DC514FF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F8C31D556F75E744EFF7F9B6F
          5A6B5A6BD556D556D556D556D55639676B2DC514FF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F8C31D556744EFF7F524A9B6F
          5A6B5A6B3967396739673967396739676B2DC514FF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F8C31D5565A6B5A6B5A6B9B6F
          5A6B5A6BD556D556D556D556D55639676B2DC514FF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F8C318C318C318C318C311042
          5A6B5A6B3967396739673967396739676B2DC514FF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F5A6B5A6B5A6B5A6B5A6B5A6B
          5A6B5A6B5A6B5A6B5A6B5A6B5A6B5A6B6B2DC514FF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F9B6F9B6F9B6F9B6F9B6F9B6F9B6F
          9B6F9B6F9B6F9B6F9B6F9B6F9B6F9B6F7B6F6B2DFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
          FF7FFF7FFF7F
        }
        OnClick = BtnOptionsClick
        TabOrder = 5
      end
      object Btn_FullAuto: TButton
        Left = 0
        Height = 30
        Hint = 'Выполнить расчет с установленными по умолчанию параметрами обработки'
        Top = 32
        Width = 159
        Caption = 'Расчет по умолчанию'
        TabOrder = 1
        OnClick = Btn_FullAutoClick
      end
      object SB_UserOptions: TSpeedButton
        Left = 0
        Height = 31
        Top = 311
        Width = 33
        Glyph.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C0060000232E0000232E00000000000000000001FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEC9CACAC7CBCCFCFCFCFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFF2F2F2C6C6C6DADADAFEFEFEFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8D8D8657B81598B9AA6B8BD
          F8F8F8FFFFFFFFFFFFFFFFFFFFFFFFE7E7E78F8F8F6E6D6E949190E6E6E6FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB4B9BB5B
          8E9D60A3B750869692A5ABFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA9A9A9A747374
          9B9999B6B5B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFF1F2F284A9B475B1C361A3B7446672F5F6F7FFFFFFFFFFFFFFFFFFDC
          DCDC8383829F9E9FA5A3A372706FFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFEFEFE9EA7A986AEBA86BCCD4D7885CEDBDFFFFF
          FFFFFFFFFCFCFC999999818081C7C6C6ABA9A9878584FEFEFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEBEC9CC7EA4B0B2D1DA
          80A3AEA3BBC2FFFFFFFFFFFFFBFBFBA1A0A0929293D2D1D0A4A2A2BDBBBBFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9
          E9E967848DC7DADFB0C6CD7A9CA6FFFFFFFFFFFFCACACA8E8D8CA7A6A7D6D5D4
          92908FE9E9E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFEDEDED7EA5B1A0B7BFB2CCD36B939DF0F2F3FFFFFFE3E3E386
          8585C1BFBFD0CFCE989594FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5DDDF6F90999AC0CA7399A4D4E0
          E3FAFAFAC9C9C9717070BFBDBCBCBAB9C0BFBEFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D6D6516870
          70A9BB7AA5B27A939B989B9C908F8F7C7A7AADABA99A9796E3E3E2FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2
          F2F2949A9C4E7C8B558FA05E97A83C5E686F76789796958683839D9B99848181
          E6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFF4F4F486A0A85A93A34777873D677442575E8788878A898993
          9190868483868381B8B6B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F78C999D5C92A2324A528D9699B2B1
          B0B3B1B0B5B3B3A2A1A0858280918F8DD4D3D2FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEB5B6B77B9AA3426B77
          A5ABADBDBBB9B6B3B1C1BFBECDCBCACFCECCBCB9B8ABA8A6A3A0A0FBFBFBFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F26A
          81884C8190677B82CCCAC8B1AEACB0ADABBBB9B7C6C4C3D1D0CFC8C6C4B5B3B1
          A7A5A3CDCDCDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFDFDFDF537A85497C8BA1A7A9BFBDBBB6B4B2AEABA9B5B2B0C0BEBDCC
          CAC9D0CFCDBFBDBBB2B0AEA9A8A7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFDFDFDF6393A24E8596B7BABBC4C2C0BBB9B7B2AF
          ADAEABA9B9B7B5C5C4C2D0CFCEC9C8C6B7B4B2A19E9EFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F08DAAB262A3B5B3BABC
          C9C7C5C0BEBCAAA8A6B7B7B7A6ADAFBAB8B6CBC9C8D1D0CEC2C0BEACABAAFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEAC
          B1B492CADB9EB7BFD3D2D0C5C3C1A8A7A77F7F81575C5FA5A7A7C4C2C1D0CECD
          C5C3C2D3D2D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFEFEFEF8B8B8D939293BDD2D994C7D6DDE4E6CECCCAACABAA5D5E5E4D4F509C
          9B9ABEBCBACAC9C8C1C0BEFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFEBEBEB747475D3D2D3FFFFFFF8F9F9C5E0E787ACB79EA3A49E9D
          9B9B99986A6A6BAAA8A7B6B3B1C7C5C4F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF8E8E8F929192FFFFFFFFFFFFFFFFFFFFFFFF
          ECF1F3B0C4CA6D777B5C5C5DA7A7A7CECDCCEEEDEDFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF929293434344A0A0A1CA
          CACACCCCCCB8B8B99E9E9F838284959596DADADBFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7
          F7A6A6A76A696B69686A89898ABEBEBFE3E3E3EAEAEAFEFEFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        }
        OnClick = SB_UserOptionsClick
        ShowHint = True
        ParentShowHint = False
        PopupMenu = MenuOptions
      end
      object SB_EditChart: TSpeedButton
        Left = 38
        Height = 31
        Hint = 'Редактировать форму графика'
        Top = 311
        Width = 33
        Glyph.Data = {
          AA040000424DAA040000000000006A0200002800000018000000180000000100
          08000000000040020000120B0000120B00008D0000008D00000000000000FFFF
          FF0055515A00FF00FF006B3A3600936A5300A2551C00CB650000AE641800D872
          0000D36D0000CF711000D57F2200E27D0000AF8B6100E9840000DFA55600CDA8
          760093550000FB950200FFA51700A86A0000FFB93F00BB7D0000FCC76100C08C
          1300FADE9500023E020005920A000CA6130009730F000A5511001BB3280022B2
          3300138B260033CC4D001C9C37002489380022A541002BBB550033CC660031C7
          61003FD8720046DF79004EE781005AF38D0062FB95000C423F0002FDFF002AFF
          FF004AFEFE006FFFFF0095FEFF0099FFFF0086B3B30000F2FF0082EBF30073DC
          E80000DFFF0058D3E50065DCED005FBCCD0000D3FF0059BED20060C6D90000CB
          FE003CC0DF0000BFF20000B6E9001EADD60030B5D70000ABDE0000A1D4000099
          CC000EA0CF00377487000095C8000093C600008EC100008BBE00268CB2000082
          B4000077AA000044660053AFFF004A95D9004397FF003E84DA0078ACF8003583
          FF00316FD9002C75FF006E9FFF001F60FF006593FF005E88EC001856FF001C51
          D9005E8AFF002F5AD6005680FC00063DFF000F3CD9004D73FF000033FF000030
          F900042CD900002AED000026D8000023D2003859FF003A5BF6000025E2000022
          DC00001ED5000020CB000F30F6002E4EFF003252FF000019CB000016B9000523
          FF000E2CFF002542FF000019FB000015C2000013BE000013B2000B26FE00162E
          FC000014F000000FC500000DB3000115FD000619E700091375000010E900000E
          D2000007A70000006700FFFFFF00030303878787030303030303030303030303
          030303030303038B877456578787870303030303030303030303030303038B5F
          757A5956545455871B1B1B03030303030303030303038B5C75805B5956545787
          2C2D2E1E040404030303030303038B5C75795D5B595657872B2C2D1E19161A04
          0453530303038B5C7579605D5B595A872A2B2C1E1714161A0431325353538B5C
          757C65605D5B6387282A2B1E151314180430313233538B5C757C6865605D6187
          29282A1E150D13140437303132538B5C757C6968656061872729281E12090F13
          043A373031538B5C757C6B69686566872627291E1207090F043E3A3730538B5C
          757C716B69686A872426271E080B070A04413E3A37538B5C758272706B696C87
          2224261E0E100C060243413E3A538B5C75827772706B6D871C22241E0E11054B
          474443413E538B5C75827E7772707387201D1C1E2F363D504847444341538B5C
          7588847E77727D8723211E03533540504948474443538B5C75888A847E777887
          251F0303533540504C49484744538B5C76818689837E7F8B0303030353354050
          4F4C494847538B5862676E7B7A85838B0303030353354050514F4C4948538787
          87585E646F878B03030303035335405052514F4C495303030387878787030303
          03030303533540505252514F4C53030303030303030303030303030353354042
          454A4D4E4E5303030303030303030303030303035334383C3B42464551530303
          030303030303030303030303035353533F393B53530303030303030303030303
          0303030303030303535353030303
        }
        OnClick = SB_EditChartClick
        ShowHint = True
        ParentShowHint = False
      end
      object Label_ViewOptions: TLabel
        Left = 0
        Height = 13
        Top = 292
        Width = 82
        Caption = 'Настройки вида'
      end
      object PC_ChartFunction: TPageControl
        Left = 0
        Height = 121
        Top = 132
        Width = 209
        ActivePage = TabSheet3
        TabIndex = 0
        TabOrder = 6
        OnChange = PC_ChartFunctionChange
        object TabSheet3: TTabSheet
          Caption = 'Зоны'
          ClientHeight = 95
          ClientWidth = 201
          ImageIndex = 2
          object Label12: TLabel
            Left = 9
            Height = 13
            Top = 59
            Width = 13
            Caption = 'N2'
          end
          object Label7: TLabel
            Left = 9
            Height = 13
            Top = 32
            Width = 13
            Caption = 'N1'
          end
          object Label10: TLabel
            Left = 6
            Height = 13
            Top = 10
            Width = 90
            Caption = 'Зона поиска пика'
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsItalic]
            ParentFont = False
          end
          object Label8: TLabel
            Left = 101
            Height = 13
            Top = 15
            Width = 19
            Caption = 'BN1'
          end
          object Label11: TLabel
            Left = 101
            Height = 13
            Top = 35
            Width = 35
            Caption = 'BN1_W'
          end
          object Label9: TLabel
            Left = 104
            Height = 13
            Top = 55
            Width = 19
            Caption = 'BN2'
          end
          object Label15: TLabel
            Left = 102
            Height = 13
            Top = 74
            Width = 35
            Caption = 'BN2_W'
          end
          object Label17: TLabel
            Left = 103
            Height = 13
            Top = -2
            Width = 94
            Caption = 'Зоны поиска фона'
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsItalic]
            ParentFont = False
          end
          object Edit_N1: TEdit
            Left = 28
            Height = 21
            Top = 29
            Width = 60
            Enabled = False
            TabOrder = 0
            Text = '150'
            OnChange = Edit_N1Change
            OnMouseEnter = Edit_MouseEnter
          end
          object Edit_N2: TEdit
            Left = 28
            Height = 21
            Top = 56
            Width = 60
            Enabled = False
            TabOrder = 1
            Text = '180'
            OnChange = Edit_N2Change
            OnMouseEnter = Edit_MouseEnter
          end
          object Edit_BN1: TEdit
            Left = 146
            Height = 21
            Top = 12
            Width = 52
            TabOrder = 2
            Text = '150'
            OnChange = Edit_BN1Change
          end
          object Edit_BN1_width: TEdit
            Left = 146
            Height = 21
            Top = 32
            Width = 52
            TabOrder = 3
            Text = '150'
            OnChange = Edit_BN1_widthChange
          end
          object Edit_BN2: TEdit
            Left = 146
            Height = 21
            Top = 52
            Width = 52
            TabOrder = 4
            Text = '180'
            OnChange = Edit_BN2Change
          end
          object Edit_BN2_width: TEdit
            Left = 146
            Height = 21
            Top = 72
            Width = 52
            TabOrder = 5
            Text = '180'
            OnChange = Edit_BN2_widthChange
          end
        end
        object TabSheet1: TTabSheet
          Caption = 'Фон'
          ClientHeight = 95
          ClientWidth = 201
          object LabelK: TLabel
            Left = 8
            Height = 13
            Top = 54
            Width = 18
            Alignment = taRightJustify
            Caption = 'By0'
          end
          object LblM: TLabel
            Left = 8
            Height = 13
            Top = 34
            Width = 18
            Alignment = taRightJustify
            Caption = 'Bx0'
          end
          object LblSig: TLabel
            Left = 16
            Height = 13
            Top = 14
            Width = 10
            Alignment = taRightJustify
            Caption = 'Bt'
          end
          object Label13: TLabel
            Left = 106
            Height = 13
            Top = 14
            Width = 24
            Alignment = taRightJustify
            Caption = 'Bxy0'
          end
          object Label14: TLabel
            Left = 112
            Height = 13
            Top = 34
            Width = 18
            Alignment = taRightJustify
            Caption = 'Bdy'
          end
          object EditBt: TEdit
            Left = 30
            Height = 21
            Top = 11
            Width = 60
            TabOrder = 0
            Text = '0'
            OnChange = ChangeOptions
            OnMouseEnter = Edit_MouseEnter
          end
          object EditBx0: TEdit
            Left = 30
            Height = 21
            Top = 31
            Width = 60
            TabOrder = 1
            Text = '0'
            OnChange = ChangeOptions
            OnMouseEnter = Edit_MouseEnter
          end
          object EditBy0: TEdit
            Left = 30
            Height = 21
            Top = 51
            Width = 60
            TabOrder = 2
            Text = '0'
            OnChange = ChangeOptions
            OnMouseEnter = Edit_MouseEnter
          end
          object Btn_FitFon: TButton
            Left = 134
            Height = 19
            Top = 74
            Width = 60
            Caption = 'Фит фона'
            TabOrder = 3
            OnClick = Btn_FitFonClick
          end
          object EditBxy0: TEdit
            Left = 134
            Height = 21
            Top = 11
            Width = 60
            TabOrder = 4
            Text = '0'
            OnChange = ChangeOptions
            OnMouseEnter = Edit_MouseEnter
          end
          object EditBdy: TEdit
            Left = 134
            Height = 21
            Top = 31
            Width = 60
            TabOrder = 5
            Text = '0'
            OnChange = ChangeOptions
            OnMouseEnter = Edit_MouseEnter
          end
          object CB_FitBG_Auto: TCheckBox
            Left = 89
            Height = 17
            Top = 75
            Width = 43
            Alignment = taLeftJustify
            Caption = 'Авто'
            TabOrder = 6
          end
        end
        object TabSheet_Peak: TTabSheet
          Caption = 'Пик'
          ClientHeight = 95
          ClientWidth = 201
          ImageIndex = 1
          object Label6: TLabel
            Left = 112
            Height = 13
            Top = 53
            Width = 20
            Alignment = taRightJustify
            Caption = 'GSR'
          end
          object Label3: TLabel
            Left = 10
            Height = 13
            Top = 53
            Width = 18
            Alignment = taRightJustify
            Caption = 'GSL'
          end
          object Label5: TLabel
            Left = 105
            Height = 13
            Top = 34
            Width = 27
            Alignment = taRightJustify
            Caption = 'DGA2'
          end
          object Label2: TLabel
            Left = 8
            Height = 13
            Top = 34
            Width = 20
            Alignment = taRightJustify
            Caption = 'GA1'
          end
          object Label4: TLabel
            Left = 104
            Height = 13
            Top = 14
            Width = 28
            Alignment = taRightJustify
            Caption = 'DGM2'
          end
          object Label1: TLabel
            Left = 7
            Height = 13
            Top = 14
            Width = 21
            Alignment = taRightJustify
            Caption = 'GM1'
          end
          object Edit_GM1: TEdit
            Left = 30
            Height = 21
            Top = 11
            Width = 60
            TabOrder = 0
            Text = '23'
            OnChange = Edit_GM1Change
            OnMouseEnter = Edit_MouseEnter
          end
          object Edit_GSR: TEdit
            Left = 134
            Height = 21
            Top = 51
            Width = 60
            TabOrder = 6
            Text = '289'
            OnChange = ChangeOptions
            OnMouseEnter = Edit_MouseEnter
          end
          object Edit_GSL: TEdit
            Left = 30
            Height = 21
            Top = 51
            Width = 60
            TabOrder = 2
            Text = '289'
            OnChange = ChangeOptions
            OnMouseEnter = Edit_MouseEnter
          end
          object Edit_DGA2: TEdit
            Left = 134
            Height = 21
            Top = 31
            Width = 60
            TabOrder = 5
            Text = '10'
            OnChange = Edit_DGA2Change
            OnMouseEnter = Edit_MouseEnter
          end
          object Edit_GA1: TEdit
            Left = 30
            Height = 21
            Top = 31
            Width = 60
            TabOrder = 1
            Text = '279'
            OnChange = Edit_GA1Change
            OnMouseEnter = Edit_MouseEnter
          end
          object Edit_DGM2: TEdit
            Left = 134
            Height = 21
            Top = 11
            Width = 60
            TabOrder = 4
            Text = '10'
            OnChange = Edit_DGM2Change
            OnMouseEnter = Edit_MouseEnter
          end
          object CB_WOFon: TCheckBox
            Left = 12
            Height = 17
            Top = 75
            Width = 64
            Caption = 'Без фона'
            Color = clWhite
            ParentColor = False
            TabOrder = 3
            OnClick = CB_WOFonClick
          end
          object Btn_FitPeak: TButton
            Left = 134
            Height = 19
            Top = 74
            Width = 60
            Caption = 'Фит пика'
            TabOrder = 7
            OnClick = Btn_FitPeakClick
          end
          object CB_FitPeak_Auto: TCheckBox
            Left = 85
            Height = 17
            Top = 75
            Width = 43
            Alignment = taLeftJustify
            Caption = 'Авто'
            Checked = True
            State = cbChecked
            TabOrder = 8
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Фон (упр.)'
          ImageIndex = 3
          TabVisible = False
        end
      end
      object Label_S1: TLabel
        Left = 161
        Height = 13
        Top = 78
        Width = 18
        Caption = 'мЗв'
        ParentColor = False
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 440
    Top = 13
    object MainMenuFile: TMenuItem
      Caption = 'Файл'
      object NMakeFindOptimization: TMenuItem
        Caption = 'Обработать все измерения с поиском оптимизации'
        Visible = False
        OnClick = NMakeFindOptimizationClick
      end
      object N2: TMenuItem
        Caption = '-'
        Visible = False
      end
      object NMakeAll: TMenuItem
        Caption = 'Обработать все измерения'
        Default = True
        OnClick = NMakeAllClick
      end
      object NMakeAllGroupByDos: TMenuItem
        Caption = 'Обработать все измерения по дозиметрам'
        Visible = False
        OnClick = NMakeAllGroupByDosClick
      end
      object NMakeAllGroupByComment: TMenuItem
        Caption = 'Обработать все измерения по комментариям'
        Visible = False
        OnClick = NMakeAllGroupByCommentClick
      end
      object NSpace: TMenuItem
        Caption = '-'
      end
      object NRecalculate: TMenuItem
        AutoCheck = True
        Caption = 'Принудительно пересчитывать заново'
        GroupIndex = 1
        ShowAlwaysCheckable = True
        OnClick = NRecalculateClick
      end
      object Separator1: TMenuItem
        Caption = '-'
      end
      object MainMenuExit: TMenuItem
        Caption = 'Выход'
        OnClick = MainMenuExitClick
      end
    end
  end
  object PopupMenu_ChooseSeries: TPopupMenu
    Left = 920
    Top = 80
    object NChoose3: TMenuItem
      Caption = 'Выбор графиков для анализа сглаживания'
      OnClick = NChoose1Click
    end
    object NChoose1: TMenuItem
      Caption = 'Выбор графиков для анализа фоновой функции'
      OnClick = NChoose2Click
    end
    object NChoose2: TMenuItem
      Caption = 'Выбор графиков для анализа основной функции'
      OnClick = NChoose3Click
    end
    object NChoose4: TMenuItem
      Caption = 'Выбор всех графиков'
      OnClick = NChoose4Click
    end
  end
  object ImageList1: TImageList
    Height = 32
    Width = 32
    Left = 288
    Top = 264
    Bitmap = {
      4C7A0400000020000000200000000F0600000000000078DAED9ACB6E1C451486
      27B127512C1C3116CA136009C908DE81C46332376001388004E2018882C04211
      6F90F00ED80E8BDC6C8B4708CB7813B3CE7861896CBC72BCB0C797C37C3D3E43
      75A7BBBA7BBADADD1253526BECBED4A93A75FA9CFFFFAB45C64DDBE9E9A9F77B
      727222474747DE2FE7F81DE5D067B52FD386CD765E2D6E0C7A7DBBBB2D3FDEF9
      4916EA8DECC74243967EFE45767676ACF33B3E3EF6C6F5F2655766DF7D4F6A6F
      BFE33DDF6CB4A5D13F9A298FC1331DA9D76FCAD5E919999BFBC01B83AE4DB0B1
      46B4DB3FDC9199996BB2B5F5B733BF6F6E6ECAF4744DEEDEFDD5672BE87BE67F
      FDA37969B53E19DE178C29FCD4EBF512C720F7D36E5CAF7BFEC0869E0B8B3FEE
      6BB73FF33D1B162FA60FC3AEEB39FAE0DEFAFC4DCF7E540CE839ECB75A9F0EDF
      1DF3BDE0EF6EB72BCF9EFDE58B19DB18F4B9F91B1F0FED27997F709CF89C76EF
      DE6F52A954E4C1EA1FC335B28D41FB889B7F9C7D9DCBDEDE9EDCBAF54D7F0C13
      B2BAF26038B6A831B8B26FFE7F7070208B8B5FCBC50B9764F9F755EB185CCEDF
      8C83C3C3C3C1182A5559595EF5AD451EF68331CDDF9E1FBEFCCA5B8BE5B33104
      63CBA5FDA01FB4B67CF7EDF752AD5E91470F1F79D7CDFC92977DF5C1FEFEBE7C
      F1F9A24C4D5D958D8D3F73B56FDAA6F12E349B6D99B878499E3C7E9AABFF83B6
      9977ABD991EAE41579FA646D107FBD7CE34FFF7FFD7AAF6FBB2D97AB53C379E7
      FDFE69BCEDEEEEF6F3734726272ECBDADAFAB9E51FCDBFF7FBF9F7426552D6D7
      37626DA7B19FB4FEFCF3EA95BC78B1957BFD29A2FE26C51F61E7E3F1C782157F
      0CF1D7ED3EFEAAB9C55FCF9FF7F1D75B76FCE5C39FB30EF1E73CF8B326EFCF7D
      68C59F3EFCBDED187F2FC5E3EF32F08F22F9D7B88DDB98FF0FAE932BE0ECE40E
      1739885C86A6609B9FFA0CDB7075383BDC9D1C3A7AFE6D7BF6C9E5680AE4F6B8
      FA438D80ABC3D95D356A199A02DA425CFD61BE6000B3762739C04161F7AB2D6A
      3AB55D63326AEDB566C5E18F308C69C31F601A9D57587F6A0BFB60A520FE0AEB
      DB5C4B3401B401737E661F603AB59F64FE71F332790E5A009A00DA808955CD3E
      E2E69FC4BE695B6DA001C03FD104E043419FB9B21F661BEE8F06000F870BDB38
      8B0BFBA6CFE1FC707F6CA30504D73D0FFF6BACC1F5F139DC9F799B7118C57FB2
      DA576D038E0FD787F39B383CAE5F57F6E1F8707D383F1CD836F7BCFC0FE785F3
      C3FD8979F35A5EFE1FC65F6F107F707EB83F1A007E881A439EEF1F7E4003400B
      4013C8F3FD8B1A031A005A009A00DA4090DFB8B41F3506B4003481FB19F26FD6
      FA83268036E0AAFE14517FFFC31F0BA9F107F9210BFEF0E1AF3E5787B33BC55F
      B56B9EB660DB7F51FC095787B3AB66E2047FCEDAF1E71BF87BC931FEDEDE1EF3
      FF31FF1FB714FC5FF3599A3C68EA9E41BD3469ECBB8CD534FD9AF9873C4CEE73
      71D0579CFE68DA26FF5203A843E460EA31BF690E7D869A079FD7FDFFA831684D
      20EF92FBB5FE446180247E573B6809E819682AB6FA4323E72BFE217646893D33
      06B5D6A0A5D0771C5E1868DE9D44F93A69DC29AEA1EF38FCC73DD4CE2CBE0F5B
      83C6592D8EC35FAAF9DBFCA463621D752D83FB7E6FE2BAECF683B8536DDAF6A1
      5CD9F7E91E671C082E081FB57D07E1C27E14F78187C28575EF3D6C2F30ABFD30
      DB703FF8271C181E8E16B012310657F337E70DEF84FBC23BF13B3A045A887E8B
      61AE850BFB9A43E07A03BED9F178B7CECFFC1E44BF49D167B2DAD7F3703C8F67
      9ECDDBE427E6F720AC857E9B633E3F8A7D7DB7E176F04B38AEF26C13C39BDF83
      0CBECDA90CBF51D2751BC5BEDA8057C26DE1D7419D21B8CEAC0B3A245AA89FD7
      667FFFA23084EDBA8BF8537DDB568F82EFA9F96C5AFB45D41F7FFD6DE7507FDB
      89EBAFDE17C5E9D3E00F7D87CC7E6DF80BAE0A5FD6FD7F17F88BBEE893BEE3F0
      173C19AE8E5E8066816E8276C36F9A439FA10FF67ED87F4AB20746432740AB40
      2F01BF6639E8837D27FA4CCAFF6DDFB48C1A8751FA7C946615E4FF9AEB921E41
      FE6FD3D2C66DDC8A8EBF32BC7F45E69FA2F36F59EA4F51F5B74CF8A36CFCFFBC
      F16759F077D1FCA368FE5534FF2C03FF2E5A7F288BFE5294FE5406FDAD0CFAE3
      79EAAFC5F3FF02F5F782F61FCAB2FF52D4FE53D1FB6F65D87F2C72FFF5FFDAFE
      057A75F075
    }
  end
  object SaveDialog1: TSaveDialog
    Left = 833
    Top = 17
  end
  object OpenDialog1: TOpenDialog
    Left = 881
    Top = 17
  end
  object CalcTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = CalcTimerTimer
    Left = 937
    Top = 17
  end
  object CAT_Auto1: TChartAxisTransformations
    Left = 208
    Top = 88
    object CAT_Auto1AutoScaleAxisTransform1: TAutoScaleAxisTransform
    end
  end
  object ChartToolset1: TChartToolset
    Left = 264
    Top = 56
    object ChartToolset1LegendClickTool1: TLegendClickTool
      Shift = [ssLeft]
      OnClick = ChartToolset1LegendClickTool1Click
    end
    object ChartToolset1UserDefinedTool1: TUserDefinedTool
      Shift = [ssLeft]
      OnAfterMouseDown = ChartToolset1UserDefinedTool1AfterMouseDown
    end
  end
  object CAT_Auto2: TChartAxisTransformations
    Left = 240
    Top = 88
    object CAT_Auto1AutoScaleAxisTransform2: TAutoScaleAxisTransform
    end
  end
  object MenuOptions: TPopupMenu
    Left = 560
    Top = 16
    object NOptHideZones: TMenuItem
      AutoCheck = True
      Caption = 'Запретить изменение зон интереса'
      OnClick = NOptHideZonesClick
    end
    object NOptShowPanel: TMenuItem
      AutoCheck = True
      Caption = 'Разрешить ручное изменение параметров'
      OnClick = NOptShowPanelClick
    end
    object N_Delimiter3: TMenuItem
      Caption = '-'
    end
    object NOptShowMenu: TMenuItem
      AutoCheck = True
      Caption = 'Отобразить оконное меню'
      OnClick = NOptShowMenuClick
    end
    object NOptShowChartEdit: TMenuItem
      AutoCheck = True
      Caption = 'Разрешить редактирование внутренних настроек графика'
      OnClick = NOptShowChartEditClick
    end
    object N_Delimiter2: TMenuItem
      Caption = '-'
    end
    object NOptUnSaveNotifyOff: TMenuItem
      AutoCheck = True
      Caption = 'Отключить подтверждение при выходе без сохранения'
      OnClick = NOptUnSaveNotifyOffClick
    end
    object NOptShowNegativeDoses: TMenuItem
      AutoCheck = True
      Caption = 'Показать отрицательные значения расчитанных доз'
      OnClick = NOptShowNegativeDosesClick
    end
    object N_Delimiter: TMenuItem
      Caption = '-'
      Visible = False
    end
    object NOptSaveOptions: TMenuItem
      Caption = 'Сохранить текущие настройки '
      Visible = False
      OnClick = NOptSaveOptionsClick
    end
    object NOptDefault: TMenuItem
      Caption = 'Восстановить типовые настройки'
      Visible = False
      OnClick = NOptDefaultClick
    end
  end
  object ChartLiveView1: TChartLiveView
    Active = True
    Chart = ChartCalc
    Left = 946
    Top = 479
  end
end
