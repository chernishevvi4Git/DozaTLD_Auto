object OptionsForm: TOptionsForm
  Left = 765
  Height = 481
  Top = 345
  Width = 609
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Настройка алгоритма'
  ClientHeight = 481
  ClientWidth = 609
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  KeyPreview = True
  OnCreate = FormCreate
  Position = poMainFormCenter
  LCLVersion = '3.6.0.0'
  object Label_MethodName: TLabel
    Left = 8
    Height = 13
    Top = 223
    Width = 113
    Caption = 'Наименование метода'
    ParentColor = False
    Visible = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Height = 23
    Top = 458
    Width = 609
    Panels = <>
  end
  object PC: TPageControl
    Left = 211
    Height = 458
    Top = 0
    Width = 398
    ActivePage = TabSheetAsserts
    Align = alRight
    MultiLine = True
    TabIndex = 9
    TabOrder = 1
    Options = [nboMultiLine]
    object TabSheet4: TTabSheet
      Caption = 'Общее'
      ClientHeight = 414
      ClientWidth = 390
      ImageIndex = 3
      object RG_TypeS: TRadioGroup
        Left = 3
        Height = 132
        Top = 17
        Width = 233
        AutoFill = True
        Caption = 'Алгоритм расчёта площади'
        ChildSizing.LeftRightSpacing = 6
        ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
        ChildSizing.EnlargeVertical = crsHomogenousChildResize
        ChildSizing.ShrinkHorizontal = crsScaleChilds
        ChildSizing.ShrinkVertical = crsScaleChilds
        ChildSizing.Layout = cclLeftToRightThenTopToBottom
        ChildSizing.ControlsPerLine = 1
        ClientHeight = 114
        ClientWidth = 229
        ItemIndex = 0
        Items.Strings = (
          'Ассиметричный Гаусс'
          'Правая часть Гаусса'
          'Высота пика'
          'Площадь области'
        )
        OnClick = OptionsChanged
        ParentBackground = False
        TabOrder = 0
      end
      object CB_NoLineCorrection: TCheckBox
        Left = 3
        Height = 17
        Top = 155
        Width = 304
        Caption = 'Корректировать нелинейные распределения площадей'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CB_NoLineCorrectionClick
      end
      object CB_ShowNegativeDose: TCheckBox
        Left = 3
        Height = 17
        Top = 178
        Width = 234
        Caption = 'Показывать отрицательные значения доз'
        TabOrder = 2
        OnClick = CB_ShowNegativeDoseClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Сглаживание'
      ClientHeight = 414
      ClientWidth = 390
      object Label7: TLabel
        Left = 18
        Height = 13
        Top = 187
        Width = 161
        Caption = 'Параметр ширины сглаживания'
        ParentColor = False
      end
      object RG_GladeType: TRadioGroup
        Left = 3
        Height = 158
        Top = 3
        Width = 382
        AutoFill = True
        Caption = 'Сглаживание'
        ChildSizing.LeftRightSpacing = 6
        ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
        ChildSizing.EnlargeVertical = crsHomogenousChildResize
        ChildSizing.ShrinkHorizontal = crsScaleChilds
        ChildSizing.ShrinkVertical = crsScaleChilds
        ChildSizing.Layout = cclLeftToRightThenTopToBottom
        ChildSizing.ControlsPerLine = 2
        ClientHeight = 140
        ClientWidth = 378
        Columns = 2
        ItemIndex = 4
        Items.Strings = (
          'Без сглаживания'
          'По Медведеву'
          'Акцентированное среднее'
          'Среднее арифметическое'
          'Медведев-Чернышев'
          'Статист. среднее'
          'Ступеньки'
          'Медв++ + ст. сред.'
        )
        OnClick = RG_GladeTypeClick
        ParentBackground = False
        TabOrder = 0
      end
      object EditG_Num: TEdit
        Left = 278
        Height = 21
        Top = 184
        Width = 107
        TabOrder = 1
        Text = '5'
        OnChange = OptionsChanged
      end
      object CB_UseSourceFilter: TCheckBox
        Left = 18
        Height = 17
        Top = 225
        Width = 191
        Caption = 'Фильтрация от прострелов в ФЭУ'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = OptionsChanged
      end
      object Edit_FilterMinDiff: TEdit
        Left = 278
        Height = 21
        Top = 223
        Width = 107
        TabOrder = 3
        Text = '2'
        OnChange = OptionsChanged
      end
      object CB_UseLowPassFilter: TCheckBox
        Left = 18
        Height = 17
        Top = 260
        Width = 147
        Caption = 'Нижнечастотный фильтр'
        TabOrder = 4
        OnClick = OptionsChanged
      end
      object Edit_LowPassFilterAlfa: TEdit
        Left = 278
        Height = 21
        Top = 258
        Width = 107
        TabOrder = 5
        Text = '2'
        OnChange = OptionsChanged
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Фон'
      ClientHeight = 414
      ClientWidth = 390
      ImageIndex = 1
      object PageControl1: TPageControl
        Left = 3
        Height = 340
        Top = 71
        Width = 389
        ActivePage = TabSheet9
        TabIndex = 1
        TabOrder = 0
        object TabSheet11: TTabSheet
          Caption = ' Начальная часть '
          ClientHeight = 314
          ClientWidth = 381
          ImageIndex = 2
          object GroupBox2: TGroupBox
            Left = -2
            Height = 190
            Top = 3
            Width = 380
            Caption = 'Расчёт By0'
            ClientHeight = 172
            ClientWidth = 376
            ParentBackground = False
            TabOrder = 0
            object Label8: TLabel
              Left = 12
              Height = 13
              Top = 18
              Width = 244
              Caption = 'Старт участка оценки подложки, номер канала'
              ParentColor = False
            end
            object Label6: TLabel
              Left = 12
              Height = 13
              Top = 38
              Width = 250
              Caption = 'Длина участка оценка подложки, число каналов'
              ParentColor = False
            end
            object EditL_Start: TEdit
              Left = 314
              Height = 21
              Top = 15
              Width = 58
              TabOrder = 0
              Text = '0'
              OnChange = OptionsChanged
            end
            object EditL_Num: TEdit
              Left = 314
              Height = 21
              Top = 35
              Width = 58
              TabOrder = 1
              Text = '23'
              OnChange = OptionsChanged
            end
            object RG_FuncFindBy0: TRadioGroup
              Left = 3
              Height = 64
              Top = 72
              Width = 109
              AutoFill = True
              Caption = 'Поиск By0'
              ChildSizing.LeftRightSpacing = 6
              ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
              ChildSizing.EnlargeVertical = crsHomogenousChildResize
              ChildSizing.ShrinkHorizontal = crsScaleChilds
              ChildSizing.ShrinkVertical = crsScaleChilds
              ChildSizing.Layout = cclLeftToRightThenTopToBottom
              ChildSizing.ControlsPerLine = 1
              ClientHeight = 46
              ClientWidth = 105
              ItemIndex = 0
              Items.Strings = (
                'По среднему'
                'По минимуму'
              )
              OnClick = OptionsChanged
              ParentBackground = False
              ParentBidiMode = False
              TabOrder = 2
            end
            object CB_UseTempProfileInfo: TCheckBox
              Left = 3
              Height = 17
              Top = 154
              Width = 291
              Caption = 'Учитывать точку перегиба температурного профиля'
              Checked = True
              State = cbChecked
              TabOrder = 3
              OnClick = CB_UseTempProfileInfoClick
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = ' Показательная/логистическая функция '
          ClientHeight = 314
          ClientWidth = 381
          object Label28: TLabel
            Left = 0
            Height = 13
            Top = 14
            Width = 270
            Caption = 'Смещение от минимума или перегиба, число каналов'
            ParentColor = False
          end
          object Label29: TLabel
            Left = 0
            Height = 13
            Top = 34
            Width = 232
            Caption = 'Ширина зоны поиска наклона, число каналов'
            ParentColor = False
          end
          object Label34: TLabel
            Left = 0
            Height = 13
            Top = 176
            Width = 113
            Caption = 'Левая граница поиска'
            ParentColor = False
          end
          object Label35: TLabel
            Left = 0
            Height = 13
            Top = 196
            Width = 119
            Caption = 'Правая граница поиска'
            ParentColor = False
          end
          object Edit_FonMinAdd: TEdit
            Left = 290
            Height = 21
            Top = 11
            Width = 58
            TabOrder = 0
            Text = '2'
            OnChange = OptionsChanged
          end
          object Edit_kWidth: TEdit
            Left = 290
            Height = 21
            Top = 31
            Width = 58
            TabOrder = 1
            Text = '10'
            OnChange = OptionsChanged
          end
          object CB_FonAdaptive: TCheckBox
            Left = 0
            Height = 17
            Top = 53
            Width = 236
            Caption = 'Регрессия Bt к 40 при вылетах за пределы'
            Checked = True
            State = cbChecked
            TabOrder = 2
            OnClick = OptionsChanged
          end
          object RG_FonRangeCriteria: TRadioGroup
            Left = -5
            Height = 87
            Top = 83
            Width = 383
            AutoFill = True
            Caption = 'Поиск границ фоновой функции'
            ChildSizing.LeftRightSpacing = 6
            ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
            ChildSizing.EnlargeVertical = crsHomogenousChildResize
            ChildSizing.ShrinkHorizontal = crsScaleChilds
            ChildSizing.ShrinkVertical = crsScaleChilds
            ChildSizing.Layout = cclLeftToRightThenTopToBottom
            ChildSizing.ControlsPerLine = 2
            ClientHeight = 69
            ClientWidth = 379
            Columns = 2
            ItemIndex = 5
            Items.Strings = (
              'Указанные границы'
              'По максимальному наклону'
              'По минимуму'
              'Близость Bt к ожиданию (40)'
              'По хвосту пика или Комбо'
              'Комбинированный'
            )
            OnClick = OptionsChanged
            ParentBackground = False
            TabOrder = 3
          end
          object Edit_BG_Start: TEdit
            Left = 290
            Height = 21
            Top = 176
            Width = 58
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            ParentFont = False
            TabOrder = 4
            Text = '160'
            OnChange = OptionsChanged
          end
          object Edit_BG_End: TEdit
            Left = 290
            Height = 21
            Top = 196
            Width = 58
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            ParentFont = False
            TabOrder = 5
            Text = '299'
            OnChange = OptionsChanged
          end
          object RG_FonFunctionCriteria: TRadioGroup
            Left = -5
            Height = 87
            Top = 220
            Width = 383
            AutoFill = True
            Caption = 'Поиск фоновой функции'
            ChildSizing.LeftRightSpacing = 6
            ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
            ChildSizing.EnlargeVertical = crsHomogenousChildResize
            ChildSizing.ShrinkHorizontal = crsScaleChilds
            ChildSizing.ShrinkVertical = crsScaleChilds
            ChildSizing.Layout = cclLeftToRightThenTopToBottom
            ChildSizing.ControlsPerLine = 1
            ClientHeight = 69
            ClientWidth = 379
            ItemIndex = 0
            Items.Strings = (
              'По найденным границам'
              'По крайним точкам зоны поиска'
              'Bt = ожиданию (40) и правая точка'
            )
            OnClick = OptionsChanged
            ParentBackground = False
            ParentBidiMode = False
            TabOrder = 6
          end
        end
      end
      object RG_BackgroundFunction: TRadioGroup
        Left = 3
        Height = 65
        Top = 0
        Width = 384
        AutoFill = True
        Caption = 'Функция фона'
        ChildSizing.LeftRightSpacing = 6
        ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
        ChildSizing.EnlargeVertical = crsHomogenousChildResize
        ChildSizing.ShrinkHorizontal = crsScaleChilds
        ChildSizing.ShrinkVertical = crsScaleChilds
        ChildSizing.Layout = cclLeftToRightThenTopToBottom
        ChildSizing.ControlsPerLine = 2
        ClientHeight = 47
        ClientWidth = 380
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          ' Показательная функция '
          ' Логистическая функция '
          ' Без фона '
        )
        OnClick = RG_BackgroundFunctionClick
        ParentBackground = False
        ParentBidiMode = False
        TabOrder = 1
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Фит фона'
      ClientHeight = 414
      ClientWidth = 390
      ImageIndex = 4
      object Label55: TLabel
        Left = 3
        Height = 13
        Top = 27
        Width = 182
        Caption = 'При площади зоны поиска не менее'
        ParentColor = False
      end
      object GroupBox1: TGroupBox
        Left = 3
        Height = 128
        Top = 49
        Width = 382
        Caption = 'Значения по фону (до фита), ожидания'
        ClientHeight = 110
        ClientWidth = 378
        Color = clBtnFace
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          Left = 12
          Height = 13
          Top = 41
          Width = 48
          Caption = 'Расчёт Bt'
          ParentColor = False
        end
        object Label3: TLabel
          Left = 12
          Height = 13
          Top = 61
          Width = 56
          Caption = 'Расчёт Bx0'
          ParentColor = False
        end
        object Label2: TLabel
          Left = 12
          Height = 13
          Top = 81
          Width = 56
          Caption = 'Расчёт By0'
          ParentColor = False
        end
        object EditEvalBy0: TEdit
          Left = 165
          Height = 21
          Top = 81
          Width = 69
          TabOrder = 0
          Text = '0.1'
        end
        object EditEvalBt: TEdit
          Left = 165
          Height = 21
          Top = 41
          Width = 69
          TabOrder = 1
          Text = '40'
        end
        object EditEvalBx0: TEdit
          Left = 165
          Height = 21
          Top = 61
          Width = 69
          TabOrder = 2
          Text = '210'
        end
        object CB_AutoCalcFonWaitings: TCheckBox
          Left = 12
          Height = 17
          Top = 18
          Width = 178
          Caption = 'Пересчитывать автоматически'
          TabOrder = 3
          OnClick = OptionsChanged
        end
      end
      object GroupBox7: TGroupBox
        Left = 5
        Height = 156
        Top = 184
        Width = 380
        Caption = 'Градиентный спуск'
        ClientHeight = 138
        ClientWidth = 376
        ParentBackground = False
        TabOrder = 1
        object Label30: TLabel
          Left = 275
          Height = 13
          Top = 59
          Width = 25
          Alignment = taRightJustify
          Caption = 'доля'
          ParentColor = False
        end
        object Label31: TLabel
          Left = 302
          Height = 13
          Top = 13
          Width = 65
          Alignment = taRightJustify
          Caption = 'Базовый шаг'
          ParentColor = False
        end
        object Label33: TLabel
          Left = 12
          Height = 13
          Top = 54
          Width = 47
          Caption = 'максимум'
          ParentColor = False
        end
        object EditFonStep: TEdit
          Left = 307
          Height = 21
          Top = 28
          Width = 60
          TabOrder = 0
          Text = '0.01'
          OnChange = OptionsChanged
        end
        object EditFonPiece: TEdit
          Left = 307
          Height = 21
          Top = 55
          Width = 60
          TabOrder = 1
          Text = '1'
          OnChange = OptionsChanged
        end
        object SE_FonMaxAutoSteps: TSpinEdit
          Left = 66
          Height = 21
          Top = 52
          Width = 84
          OnChange = OptionsChanged
          TabOrder = 2
          Value = 10000
        end
        object CB_FonSuperFit: TCheckBox
          Left = 12
          Height = 17
          Top = 89
          Width = 150
          Caption = 'Пока улучшение не более'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = OptionsChanged
        end
        object CB_FonFitGlade: TCheckBox
          Left = 12
          Height = 17
          Top = 28
          Width = 160
          Caption = 'Фит по сглаженным данным'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = OptionsChanged
        end
        object CB_FonPlusWaitings: TCheckBox
          Left = 11
          Height = 17
          Top = 113
          Width = 265
          Caption = 'Учёт ожиданий (err+=kParam*Abs(Pram-Param0)'
          TabOrder = 5
          OnClick = OptionsChanged
        end
        object Edit_MinErrF: TEdit
          Left = 319
          Height = 21
          Top = 82
          Width = 48
          TabOrder = 6
          Text = '0.1'
          OnChange = OptionsChanged
        end
      end
      object CB_FitFon: TCheckBox
        Left = 2
        Height = 17
        Top = 3
        Width = 188
        Caption = 'использовать фитирование фона'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = OptionsChanged
      end
      object Edit_MinS4FitFon: TEdit
        Left = 251
        Height = 21
        Top = 22
        Width = 60
        TabOrder = 3
        Text = '30'
        OnChange = OptionsChanged
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Пик'
      ClientHeight = 414
      ClientWidth = 390
      ImageIndex = 2
      object GroupBox5: TGroupBox
        Left = 3
        Height = 189
        Top = 3
        Width = 382
        Caption = 'Параметры поиска пика'
        ClientHeight = 171
        ClientWidth = 378
        ParentBackground = False
        TabOrder = 0
        object Label17: TLabel
          Left = 12
          Height = 13
          Top = 19
          Width = 136
          Caption = 'Минимальная ширина пика'
          ParentColor = False
        end
        object Label18: TLabel
          Left = 12
          Height = 13
          Top = 46
          Width = 144
          Caption = 'Минимальная площадь пика'
          ParentColor = False
        end
        object Label26: TLabel
          Left = 12
          Height = 13
          Top = 73
          Width = 160
          Caption = 'Ширина рассчёта производных'
          ParentColor = False
        end
        object Label56: TLabel
          Left = 264
          Height = 13
          Top = 124
          Width = 100
          Caption = 'при площади более'
          ParentColor = False
        end
        object Edit_MinDX: TEdit
          Left = 260
          Height = 21
          Top = 16
          Width = 60
          TabOrder = 0
          Text = '3'
          OnChange = OptionsChanged
        end
        object Edit_MinS: TEdit
          Left = 260
          Height = 21
          Top = 43
          Width = 60
          TabOrder = 1
          Text = '10'
          OnChange = OptionsChanged
        end
        object CB_Adaptive: TCheckBox
          Left = 16
          Height = 17
          Top = 120
          Width = 116
          Caption = 'Адаптивный метод'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = OptionsChanged
        end
        object Edit_DX: TEdit
          Left = 260
          Height = 21
          Top = 70
          Width = 60
          TabOrder = 3
          Text = '10'
          OnChange = OptionsChanged
        end
        object CB_DoPeakAlways: TCheckBox
          Left = 16
          Height = 17
          Top = 143
          Width = 234
          Caption = 'Формировать пик даже в отсутствии пика'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = OptionsChanged
        end
        object Edit_MinSforShowPeak: TEdit
          Left = 304
          Height = 21
          Top = 143
          Width = 60
          TabOrder = 5
          Text = '3'
          OnChange = OptionsChanged
        end
      end
      object GroupBox10: TGroupBox
        Left = 3
        Height = 70
        Top = 200
        Width = 382
        Caption = 'Ожидания в значимой области'
        ClientHeight = 52
        ClientWidth = 378
        ParentBackground = False
        TabOrder = 1
        object Label11: TLabel
          Left = 12
          Height = 13
          Top = 22
          Width = 121
          Caption = 'Ожидаемый центр пика'
          ParentColor = False
        end
        object Edit_WaitingPeakCentre: TEdit
          Left = 215
          Height = 21
          Top = 16
          Width = 60
          TabOrder = 0
          Text = '210'
          OnChange = OptionsChanged
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Фит пика'
      ClientHeight = 414
      ClientWidth = 390
      ImageIndex = 5
      object Label54: TLabel
        Left = 2
        Height = 13
        Top = 27
        Width = 143
        Caption = 'При площади пика не менее'
        ParentColor = False
      end
      object GroupBox4: TGroupBox
        Left = 3
        Height = 120
        Top = 48
        Width = 382
        Caption = 'Параметры Гауссов (до фита), ожидания'
        ClientHeight = 102
        ClientWidth = 378
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object Label20: TLabel
          Left = 139
          Height = 13
          Top = 74
          Width = 20
          Caption = 'GSR'
          ParentColor = False
        end
        object Label21: TLabel
          Left = 134
          Height = 13
          Top = 55
          Width = 27
          Caption = 'DGA2'
          ParentColor = False
        end
        object Label22: TLabel
          Left = 135
          Height = 13
          Top = 35
          Width = 28
          Caption = 'DGM2'
          ParentColor = False
        end
        object Label23: TLabel
          Left = 11
          Height = 13
          Top = 35
          Width = 21
          Caption = 'GM1'
          ParentColor = False
        end
        object Label24: TLabel
          Left = 12
          Height = 13
          Top = 55
          Width = 20
          Caption = 'GA1'
          ParentColor = False
        end
        object Label25: TLabel
          Left = 12
          Height = 13
          Top = 74
          Width = 18
          Caption = 'GSL'
          ParentColor = False
        end
        object Edit_GSR: TEdit
          Left = 165
          Height = 21
          Top = 72
          Width = 69
          TabOrder = 0
          Text = '13'
        end
        object Edit_GSL: TEdit
          Left = 36
          Height = 21
          Top = 72
          Width = 69
          TabOrder = 1
          Text = '17'
        end
        object Edit_DGM2: TEdit
          Left = 165
          Height = 21
          Top = 32
          Width = 69
          TabOrder = 2
          Text = '-30'
        end
        object Edit_DGA2: TEdit
          Left = 165
          Height = 21
          Top = 52
          Width = 69
          TabOrder = 3
          Text = '0.3'
        end
        object Edit_GM1: TEdit
          Left = 36
          Height = 21
          Top = 32
          Width = 69
          TabOrder = 4
          Text = '210'
        end
        object Edit_GA1: TEdit
          Left = 36
          Height = 21
          Top = 52
          Width = 69
          TabOrder = 5
          Text = '5'
        end
        object CB_AutoCalcWaitings: TCheckBox
          Left = 12
          Height = 17
          Top = 8
          Width = 178
          Caption = 'Пересчитывать автоматически'
          Checked = True
          State = cbChecked
          TabOrder = 6
          OnClick = OptionsChanged
        end
        object CB_WaitingsApriory: TCheckBox
          Left = 240
          Height = 17
          Top = 8
          Width = 132
          Caption = 'По априорным данным'
          TabOrder = 7
          OnClick = OptionsChanged
        end
      end
      object GroupBox6: TGroupBox
        Left = 3
        Height = 240
        Top = 176
        Width = 382
        Caption = 'Градиентный спуск'
        ClientHeight = 222
        ClientWidth = 378
        ParentBackground = False
        TabOrder = 1
        object Label15: TLabel
          Left = 265
          Height = 13
          Top = 47
          Width = 25
          Alignment = taRightJustify
          Caption = 'доля'
          ParentColor = False
        end
        object Label12: TLabel
          Left = 296
          Height = 13
          Top = 0
          Width = 65
          Caption = 'Базовый шаг'
          ParentColor = False
        end
        object Label19: TLabel
          Left = 2
          Height = 13
          Top = 46
          Width = 47
          Caption = 'максимум'
          ParentColor = False
        end
        object Label10: TLabel
          Left = 165
          Height = 13
          Top = 176
          Width = 36
          Caption = 'секунд'
          ParentColor = False
        end
        object Label14: TLabel
          Left = 255
          Height = 13
          Top = 82
          Width = 35
          Alignment = taRightJustify
          Caption = 'при S>'
          ParentColor = False
        end
        object Label57: TLabel
          Left = 255
          Height = 13
          Top = 130
          Width = 35
          Alignment = taRightJustify
          Caption = 'при S>'
          ParentColor = False
        end
        object Label58: TLabel
          Left = 255
          Height = 13
          Top = 106
          Width = 35
          Alignment = taRightJustify
          Caption = 'при S<'
          ParentColor = False
        end
        object EditStep: TEdit
          Left = 297
          Height = 21
          Top = 16
          Width = 60
          TabOrder = 0
          Text = '0.01'
          OnChange = OptionsChanged
        end
        object EditPiece: TEdit
          Left = 296
          Height = 21
          Top = 43
          Width = 60
          TabOrder = 1
          Text = '1'
          OnChange = OptionsChanged
        end
        object SE_MaxAutoSteps: TSpinEdit
          Left = 56
          Height = 21
          Top = 44
          Width = 84
          OnChange = OptionsChanged
          TabOrder = 2
          Value = 1000
        end
        object CB_FitChangeRange: TCheckBox
          Left = 2
          Height = 17
          Top = 129
          Width = 194
          Caption = 'Изменять зоны интереса при фите'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = OptionsChanged
        end
        object CB_SuperFit: TCheckBox
          Left = 2
          Height = 17
          Top = 81
          Width = 150
          Caption = 'Пока улучшение не более'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = OptionsChanged
        end
        object CB_FitGlade: TCheckBox
          Left = 2
          Height = 17
          Top = 20
          Width = 160
          Caption = 'Фит по сглаженным данным'
          TabOrder = 5
          OnClick = OptionsChanged
        end
        object CB_PlusWaitings: TCheckBox
          Left = 2
          Height = 17
          Hint = '(err+=kParam*Abs(Pram-Param0)'
          Top = 105
          Width = 97
          Caption = 'Учёт ожиданий'
          Checked = True
          State = cbChecked
          TabOrder = 6
          OnClick = OptionsChanged
        end
        object Edit_MinErr: TEdit
          Left = 165
          Height = 21
          Top = 79
          Width = 47
          TabOrder = 7
          Text = '0.0'
          OnChange = OptionsChanged
        end
        object CB_NoProcessApplication: TCheckBox
          Left = 2
          Height = 17
          Top = 152
          Width = 213
          Caption = 'Не обрабатывать сообщения Windows'
          TabOrder = 8
          OnClick = OptionsChanged
        end
        object CB_StopFitBySomeSec: TCheckBox
          Left = 2
          Height = 17
          Top = 175
          Width = 64
          Caption = 'Не более'
          Checked = True
          State = cbChecked
          TabOrder = 9
          OnClick = OptionsChanged
        end
        object Edit_NumSecondsToStopFit: TEdit
          Left = 88
          Height = 21
          Top = 175
          Width = 60
          TabOrder = 10
          Text = '5'
          OnChange = OptionsChanged
        end
        object Edit_MinS_4SuperFit: TEdit
          Left = 297
          Height = 21
          Top = 79
          Width = 60
          TabOrder = 11
          Text = '150'
          OnChange = OptionsChanged
        end
        object Edit_MinS_4FitChangeRange: TEdit
          Left = 296
          Height = 21
          Top = 127
          Width = 60
          TabOrder = 12
          Text = '50'
          OnChange = OptionsChanged
        end
        object Edit_MaxS_4WaitingsFit: TEdit
          Left = 297
          Height = 21
          Top = 103
          Width = 60
          TabOrder = 13
          Text = '50'
          OnChange = OptionsChanged
        end
        object CB_RefitIfError: TCheckBox
          Left = 2
          Height = 17
          Top = 200
          Width = 206
          Caption = 'Перефитирование при явной ошибке'
          Checked = True
          State = cbChecked
          TabOrder = 14
          OnClick = OptionsChanged
        end
      end
      object CB_FitPeak: TCheckBox
        Left = 2
        Height = 17
        Top = 3
        Width = 186
        Caption = 'использовать фитирование пика'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = OptionsChanged
      end
      object Edit_MinS4Fit: TEdit
        Left = 243
        Height = 21
        Top = 22
        Width = 60
        TabOrder = 3
        Text = '10'
        OnChange = OptionsChanged
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Зона интереса'
      ClientHeight = 414
      ClientWidth = 390
      ImageIndex = 7
      object Label27: TLabel
        Left = 13
        Height = 13
        Top = 6
        Width = 75
        Caption = 'Левая граница'
        ParentColor = False
      end
      object Label32: TLabel
        Left = 13
        Height = 13
        Top = 29
        Width = 81
        Caption = 'Правая граница'
        ParentColor = False
      end
      object GroupBox8: TGroupBox
        Left = -4
        Height = 176
        Top = 48
        Width = 382
        Caption = 'Зона интереса (N1,N2) при найденном пике'
        ClientHeight = 158
        ClientWidth = 378
        ParentBackground = False
        TabOrder = 0
        object Label39: TLabel
          Left = 11
          Height = 13
          Top = 138
          Width = 193
          Caption = 'Критерий правой границы, число GSR'
          ParentColor = False
        end
        object Label40: TLabel
          Left = 12
          Height = 13
          Top = 111
          Width = 185
          Caption = 'Критерий левой границы, число GSL'
          ParentColor = False
        end
        object Edit_InterestCriteriaRight: TEdit
          Left = 283
          Height = 21
          Top = 135
          Width = 77
          TabOrder = 0
          Text = '3.5'
          OnChange = OptionsChanged
        end
        object Edit_InterestCriteriaLeft: TEdit
          Left = 283
          Height = 21
          Top = 108
          Width = 78
          TabOrder = 1
          Text = '3'
          OnChange = OptionsChanged
        end
        object RG_PeakInterestRange: TRadioGroup
          Left = 11
          Height = 91
          Top = 8
          Width = 253
          AutoFill = True
          Caption = 'Присвоить'
          ChildSizing.LeftRightSpacing = 6
          ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
          ChildSizing.EnlargeVertical = crsHomogenousChildResize
          ChildSizing.ShrinkHorizontal = crsScaleChilds
          ChildSizing.ShrinkVertical = crsScaleChilds
          ChildSizing.Layout = cclLeftToRightThenTopToBottom
          ChildSizing.ControlsPerLine = 1
          ClientHeight = 73
          ClientWidth = 249
          ItemIndex = 0
          Items.Strings = (
            'по критериям'
            'максимальная ширина'
            'менять адаптивно при фите'
            'не менять'
          )
          OnClick = OptionsChanged
          ParentBackground = False
          TabOrder = 2
        end
      end
      object GroupBox11: TGroupBox
        Left = -4
        Height = 178
        Top = 231
        Width = 382
        Caption = 'Зона интереса в отсутствии пика или отключенном поиске'
        ClientHeight = 160
        ClientWidth = 378
        ParentBackground = False
        TabOrder = 1
        object Label13: TLabel
          Left = 11
          Height = 13
          Top = 107
          Width = 192
          Caption = 'Максимальная ширина зоны интереса'
          ParentColor = False
        end
        object Label16: TLabel
          Left = 11
          Height = 13
          Top = 134
          Width = 134
          Caption = 'Ширина поиска максимума'
          ParentColor = False
        end
        object Edit_WaitMaxWidth: TEdit
          Left = 282
          Height = 21
          Top = 104
          Width = 78
          TabOrder = 0
          Text = '50'
          OnChange = OptionsChanged
        end
        object RG_InterestRange: TRadioGroup
          Left = 11
          Height = 91
          Top = 8
          Width = 253
          AutoFill = True
          Caption = 'Присвоить'
          ChildSizing.LeftRightSpacing = 6
          ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
          ChildSizing.EnlargeVertical = crsHomogenousChildResize
          ChildSizing.ShrinkHorizontal = crsScaleChilds
          ChildSizing.ShrinkVertical = crsScaleChilds
          ChildSizing.Layout = cclLeftToRightThenTopToBottom
          ChildSizing.ControlsPerLine = 1
          ClientHeight = 73
          ClientWidth = 249
          ItemIndex = 0
          Items.Strings = (
            'по площади максимума'
            'максимальная ширина от максимума'
            'не менять'
          )
          OnClick = OptionsChanged
          ParentBackground = False
          TabOrder = 1
        end
        object Edit_MaxFindRange: TEdit
          Left = 282
          Height = 21
          Top = 131
          Width = 78
          TabOrder = 2
          Text = '40'
          OnChange = OptionsChanged
        end
      end
      object Edit_DefaultN1: TEdit
        Left = 278
        Height = 21
        Top = 3
        Width = 78
        TabOrder = 2
        Text = '160'
        OnChange = OptionsChanged
      end
      object Edit_DefaultN2: TEdit
        Left = 278
        Height = 21
        Top = 26
        Width = 78
        TabOrder = 3
        Text = '299'
        OnChange = OptionsChanged
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Лог'
      ClientHeight = 414
      ClientWidth = 390
      ImageIndex = 6
      OnContextPopup = TabSheet7ContextPopup
      object Label59: TLabel
        Left = 8
        Height = 13
        Top = 176
        Width = 57
        Caption = 'Параметры'
        ParentColor = False
      end
      object GroupBox9: TGroupBox
        Left = 8
        Height = 173
        Top = 3
        Width = 382
        Caption = 'Редактируемый лог событий'
        ClientHeight = 155
        ClientWidth = 378
        ParentBackground = False
        TabOrder = 0
        object ButtonSave: TButton
          Left = 14
          Height = 25
          Top = 23
          Width = 83
          Caption = 'Сохранить'
          TabOrder = 0
          OnClick = ButtonSaveClick
        end
        object BtnCopy2ClipBoard: TButton
          Left = 111
          Height = 25
          Top = 23
          Width = 215
          Caption = 'Копировать в буфер обмена'
          TabOrder = 1
          OnClick = BtnCopy2ClipBoardClick
        end
        object GroupBoxExcel: TGroupBox
          Left = 0
          Height = 154
          Top = 0
          Width = 374
          Caption = 'Экспорт в Excel'
          ClientHeight = 136
          ClientWidth = 370
          ParentBackground = False
          TabOrder = 2
          object Label9: TLabel
            Left = 14
            Height = 13
            Top = 116
            Width = 67
            Caption = 'Комментарий'
            ParentColor = False
          end
          object CB_SaveToExcel: TCheckBox
            Left = 12
            Height = 17
            Top = 22
            Width = 166
            Caption = 'Сохранять измерения в Excel'
            TabOrder = 0
          end
          object RBtnAll: TRadioButton
            Left = 20
            Height = 17
            Top = 61
            Width = 190
            Caption = 'Все измерения на одной странице'
            Checked = True
            TabOrder = 1
            TabStop = True
          end
          object RBtnGroupByDos: TRadioButton
            Left = 20
            Height = 17
            Top = 76
            Width = 162
            Caption = 'Группировка по дозиметрам'
            TabOrder = 2
          end
          object RBtnGroupByComment: TRadioButton
            Left = 20
            Height = 17
            Top = 91
            Width = 174
            Caption = 'Группировка по комментариям'
            TabOrder = 3
          end
          object EditExcelRemark: TEdit
            Left = 88
            Height = 21
            Top = 112
            Width = 276
            TabOrder = 4
            Text = 'Default'
          end
          object CB_SaveCalcImages: TCheckBox
            Left = 12
            Height = 17
            Top = 40
            Width = 269
            Caption = 'Сохранять также скриншоты расчётного модуля'
            Checked = True
            State = cbChecked
            TabOrder = 5
          end
        end
      end
      object CLB_Log: TCheckListBox
        Left = 3
        Height = 60
        Top = 192
        Width = 382
        Columns = 3
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Items.Strings = (
          'Идентификатор'
          'Функция фона'
          'Фит фона'
          'Функция пика'
          'Фит пика'
          'Площади'
          'Каракашу для Ориджина'
          'Разделитель'
        )
        ItemHeight = 17
        ParentFont = False
        TabOrder = 1
        Data = {
          080000000000000000000000
        }
      end
      object REdit: TMemo
        Left = 3
        Height = 158
        Top = 256
        Width = 382
        Font.CharSet = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 2
      end
    end
    object TabSheetWaitings: TTabSheet
      Caption = 'Ожидания'
      ClientHeight = 414
      ClientWidth = 390
      ImageIndex = 8
      object VLE: TValueListEditor
        Left = 0
        Height = 414
        Top = 0
        Width = 390
        Align = alClient
        FixedCols = 0
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        ParentFont = False
        RowCount = 2
        TabOrder = 0
        KeyOptions = [keyEdit, keyAdd, keyUnique]
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goAutoAddRows, goAlwaysShowEditor, goThumbTracking]
        TitleCaptions.Strings = (
          'Параметр'
          'Значение'
        )
        OnStringsChange = OptionsChanged
        ColWidths = (
          230
          139
        )
      end
    end
    object TabSheetAsserts: TTabSheet
      Caption = 'Предупреждения'
      ClientHeight = 414
      ClientWidth = 390
      ImageIndex = 9
      object Label4: TLabel
        Left = 124
        Height = 13
        Top = 41
        Width = 134
        Caption = 'By0 (Общий подъём фона)'
        ParentColor = False
      end
      object Label5: TLabel
        Left = 124
        Height = 13
        Top = 61
        Width = 87
        Caption = 'Bt (Наклон фона)'
        ParentColor = False
      end
      object Label36: TLabel
        Left = 124
        Height = 13
        Top = 81
        Width = 141
        Caption = 'Bx0 (Пересечение фона с 1)'
        ParentColor = False
      end
      object Label37: TLabel
        Left = 16
        Height = 13
        Top = 19
        Width = 38
        Caption = 'ошибка'
        ParentColor = False
      end
      object Label38: TLabel
        Left = 274
        Height = 13
        Top = 19
        Width = 47
        Caption = 'предупр.'
        ParentColor = False
      end
      object Label41: TLabel
        Left = 25
        Height = 13
        Top = 0
        Width = 71
        Caption = 'Минимальное '
        ParentColor = False
      end
      object Label42: TLabel
        Left = 282
        Height = 13
        Top = 0
        Width = 76
        Caption = 'Максимальное '
        ParentColor = False
      end
      object Label43: TLabel
        Left = 72
        Height = 13
        Top = 19
        Width = 47
        Caption = 'предупр.'
        ParentColor = False
      end
      object Label44: TLabel
        Left = 337
        Height = 13
        Top = 19
        Width = 38
        Caption = 'ошибка'
        ParentColor = False
      end
      object Label45: TLabel
        Left = 164
        Height = 13
        Top = 19
        Width = 48
        Caption = 'величина'
        ParentColor = False
      end
      object Label46: TLabel
        Left = 124
        Height = 13
        Top = 100
        Width = 134
        Caption = 'DGM1 (Смещение пика А5)'
        ParentColor = False
      end
      object Label47: TLabel
        Left = 124
        Height = 13
        Top = 121
        Width = 130
        Caption = 'GA1 (Амплитуда пика А5)'
        ParentColor = False
      end
      object Label48: TLabel
        Left = 124
        Height = 13
        Top = 141
        Width = 130
        Caption = 'DGM2 (Отн. см-е пика А4)'
        ParentColor = False
      end
      object Label49: TLabel
        Left = 124
        Height = 13
        Top = 161
        Width = 145
        Caption = 'DGA2 (Отн. высота пика А4)'
        ParentColor = False
      end
      object Label50: TLabel
        Left = 124
        Height = 13
        Top = 180
        Width = 91
        Caption = 'GSL (Левая сигма)'
        ParentColor = False
      end
      object Label51: TLabel
        Left = 124
        Height = 13
        Top = 201
        Width = 99
        Caption = 'GSR (Правая сигма)'
        ParentColor = False
      end
      object Label52: TLabel
        Left = 143
        Height = 13
        Top = 241
        Width = 175
        Alignment = taRightJustify
        Caption = 'Завал фона на правой границе, %'
        ParentColor = False
      end
      object Label53: TLabel
        Left = 160
        Height = 13
        Top = 261
        Width = 158
        Alignment = taRightJustify
        Caption = 'Амплитуда ненайденного пика'
        ParentColor = False
      end
      object Label60: TLabel
        Left = 146
        Height = 13
        Top = 281
        Width = 172
        Alignment = taRightJustify
        Caption = 'Уставка для перехода на фильтр'
        ParentColor = False
      end
      object EC_By0_MinError: TEdit
        Left = 4
        Height = 21
        Top = 38
        Width = 58
        Alignment = taCenter
        TabOrder = 0
        Text = '0.01'
        OnChange = OptionsChanged
      end
      object EC_By0_MinWarning: TEdit
        Left = 61
        Height = 21
        Top = 38
        Width = 58
        Alignment = taCenter
        TabOrder = 1
        Text = '0.02'
        OnChange = OptionsChanged
      end
      object EC_By0_MaxWarning: TEdit
        Left = 270
        Height = 21
        Top = 38
        Width = 58
        Alignment = taCenter
        TabOrder = 2
        Text = '1.7'
        OnChange = OptionsChanged
      end
      object EC_By0_MaxError: TEdit
        Left = 327
        Height = 21
        Top = 38
        Width = 58
        Alignment = taCenter
        TabOrder = 3
        Text = '10'
        OnChange = OptionsChanged
      end
      object EC_Bt_MinError: TEdit
        Left = 4
        Height = 21
        Top = 58
        Width = 58
        Alignment = taCenter
        TabOrder = 4
        Text = '3'
        OnChange = OptionsChanged
      end
      object EC_Bt_MinWarning: TEdit
        Left = 61
        Height = 21
        Top = 58
        Width = 58
        Alignment = taCenter
        TabOrder = 5
        Text = '10'
        OnChange = OptionsChanged
      end
      object EC_Bt_MaxWarning: TEdit
        Left = 270
        Height = 21
        Top = 58
        Width = 58
        Alignment = taCenter
        TabOrder = 6
        Text = '90'
        OnChange = OptionsChanged
      end
      object EC_Bt_MaxError: TEdit
        Left = 327
        Height = 21
        Top = 58
        Width = 58
        Alignment = taCenter
        TabOrder = 7
        Text = '300'
        OnChange = OptionsChanged
      end
      object EC_Bx0_MinError: TEdit
        Left = 4
        Height = 21
        Top = 78
        Width = 58
        Alignment = taCenter
        TabOrder = 8
        Text = '50'
        OnChange = OptionsChanged
      end
      object EC_Bx0_MinWarning: TEdit
        Left = 61
        Height = 21
        Top = 78
        Width = 58
        Alignment = taCenter
        TabOrder = 9
        Text = '130'
        OnChange = OptionsChanged
      end
      object EC_Bx0_MaxWarning: TEdit
        Left = 270
        Height = 21
        Top = 78
        Width = 58
        Alignment = taCenter
        TabOrder = 10
        Text = '350'
        OnChange = OptionsChanged
      end
      object EC_Bx0_MaxError: TEdit
        Left = 327
        Height = 21
        Top = 78
        Width = 58
        Alignment = taCenter
        TabOrder = 11
        Text = '450'
        OnChange = OptionsChanged
      end
      object EC_GM1_MinError: TEdit
        Left = 4
        Height = 21
        Top = 98
        Width = 58
        Alignment = taCenter
        TabOrder = 12
        Text = '-70'
        OnChange = OptionsChanged
      end
      object EC_GM1_MinWarning: TEdit
        Left = 61
        Height = 21
        Top = 98
        Width = 58
        Alignment = taCenter
        TabOrder = 13
        Text = '-40'
        OnChange = OptionsChanged
      end
      object EC_GM1_MaxWarning: TEdit
        Left = 270
        Height = 21
        Top = 98
        Width = 58
        Alignment = taCenter
        TabOrder = 14
        Text = '40'
        OnChange = OptionsChanged
      end
      object EC_GM1_MaxError: TEdit
        Left = 327
        Height = 21
        Top = 98
        Width = 58
        Alignment = taCenter
        TabOrder = 15
        Text = '70'
        OnChange = OptionsChanged
      end
      object EC_GA1_MinError: TEdit
        Left = 4
        Height = 21
        Top = 118
        Width = 58
        Alignment = taCenter
        TabOrder = 16
        Text = '1'
        OnChange = OptionsChanged
      end
      object EC_GA1_MinWarning: TEdit
        Left = 61
        Height = 21
        Top = 118
        Width = 58
        Alignment = taCenter
        TabOrder = 17
        Text = '3'
        OnChange = OptionsChanged
      end
      object EC_GA1_MaxWarning: TEdit
        Left = 270
        Height = 21
        Top = 118
        Width = 58
        Alignment = taCenter
        TabOrder = 18
        Text = '10000'
        OnChange = OptionsChanged
      end
      object EC_GA1_MaxError: TEdit
        Left = 327
        Height = 21
        Top = 118
        Width = 58
        Alignment = taCenter
        TabOrder = 19
        Text = '100000'
        OnChange = OptionsChanged
      end
      object EC_DGM2_MinError: TEdit
        Left = 4
        Height = 21
        Top = 138
        Width = 58
        Alignment = taCenter
        TabOrder = 20
        Text = '-90'
        OnChange = OptionsChanged
      end
      object EC_DGM2_MinWarning: TEdit
        Left = 61
        Height = 21
        Top = 138
        Width = 58
        Alignment = taCenter
        TabOrder = 21
        Text = '-60'
        OnChange = OptionsChanged
      end
      object EC_DGM2_MaxWarning: TEdit
        Left = 270
        Height = 21
        Top = 138
        Width = 58
        Alignment = taCenter
        TabOrder = 22
        Text = '-20'
        OnChange = OptionsChanged
      end
      object EC_DGM2_MaxError: TEdit
        Left = 327
        Height = 21
        Top = 138
        Width = 58
        Alignment = taCenter
        TabOrder = 23
        Text = '-5'
        OnChange = OptionsChanged
      end
      object EC_DGA2_MinError: TEdit
        Left = 4
        Height = 21
        Top = 158
        Width = 58
        Alignment = taCenter
        TabOrder = 24
        Text = '0.01'
        OnChange = OptionsChanged
      end
      object EC_DGA2_MinWarning: TEdit
        Left = 61
        Height = 21
        Top = 158
        Width = 58
        Alignment = taCenter
        TabOrder = 25
        Text = '0.1'
        OnChange = OptionsChanged
      end
      object EC_DGA2_MaxWarning: TEdit
        Left = 270
        Height = 21
        Top = 158
        Width = 58
        Alignment = taCenter
        TabOrder = 26
        Text = '0.5'
        OnChange = OptionsChanged
      end
      object EC_DGA2_MaxError: TEdit
        Left = 327
        Height = 21
        Top = 158
        Width = 58
        Alignment = taCenter
        TabOrder = 27
        Text = '1'
        OnChange = OptionsChanged
      end
      object EC_GSL_MinError: TEdit
        Left = 4
        Height = 21
        Top = 178
        Width = 58
        Alignment = taCenter
        TabOrder = 28
        Text = '3'
        OnChange = OptionsChanged
      end
      object EC_GSL_MinWarning: TEdit
        Left = 61
        Height = 21
        Top = 178
        Width = 58
        Alignment = taCenter
        TabOrder = 29
        Text = '10'
        OnChange = OptionsChanged
      end
      object EC_GSL_MaxWarning: TEdit
        Left = 270
        Height = 21
        Top = 178
        Width = 58
        Alignment = taCenter
        TabOrder = 30
        Text = '35'
        OnChange = OptionsChanged
      end
      object EC_GSL_MaxError: TEdit
        Left = 327
        Height = 21
        Top = 178
        Width = 58
        Alignment = taCenter
        TabOrder = 31
        Text = '75'
        OnChange = OptionsChanged
      end
      object EC_GSR_MinError: TEdit
        Left = 4
        Height = 21
        Top = 198
        Width = 58
        Alignment = taCenter
        TabOrder = 32
        Text = '1'
        OnChange = OptionsChanged
      end
      object EC_GSR_MinWarning: TEdit
        Left = 61
        Height = 21
        Top = 198
        Width = 58
        Alignment = taCenter
        TabOrder = 33
        Text = '5'
        OnChange = OptionsChanged
      end
      object EC_GSR_MaxWarning: TEdit
        Left = 270
        Height = 21
        Top = 198
        Width = 58
        Alignment = taCenter
        TabOrder = 34
        Text = '20'
        OnChange = OptionsChanged
      end
      object EC_GSR_MaxError: TEdit
        Left = 327
        Height = 21
        Top = 198
        Width = 58
        Alignment = taCenter
        TabOrder = 35
        Text = '60'
        OnChange = OptionsChanged
      end
      object ECC_Fon: TEdit
        Left = 327
        Height = 21
        Top = 238
        Width = 58
        TabOrder = 36
        Text = '50'
        OnChange = OptionsChanged
      end
      object ECC_MaxNoPeak: TEdit
        Left = 327
        Height = 21
        Top = 258
        Width = 58
        TabOrder = 37
        Text = '10'
        OnChange = OptionsChanged
      end
      object ECS_Adaptive: TCheckBox
        Left = 67
        Height = 17
        Top = 318
        Width = 123
        Caption = 'Учёт взаимовлияний'
        Checked = True
        State = cbChecked
        TabOrder = 38
        OnClick = OptionsChanged
      end
      object Edit_AlarmLevelForFilter: TEdit
        Left = 327
        Height = 21
        Top = 278
        Width = 58
        TabOrder = 39
        Text = '1000'
        OnChange = OptionsChanged
      end
    end
  end
  object RG_MainAlgorithm: TRadioGroup
    Left = 8
    Height = 161
    Top = 59
    Width = 192
    AutoFill = True
    Caption = 'Метод обработки'
    ChildSizing.LeftRightSpacing = 6
    ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
    ChildSizing.EnlargeVertical = crsHomogenousChildResize
    ChildSizing.ShrinkHorizontal = crsScaleChilds
    ChildSizing.ShrinkVertical = crsScaleChilds
    ChildSizing.Layout = cclLeftToRightThenTopToBottom
    ChildSizing.ControlsPerLine = 1
    ClientHeight = 143
    ClientWidth = 188
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      'Фитирование'
      'Интеграл [10-280]'
      'Интеграл [60-240]'
      'Интеграл на ступеньке'
      'Пользовательский'
    )
    OnClick = RG_MainAlgorithmClick
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
  end
  object Btn_FonFit: TBitBtn
    Left = 67
    Height = 30
    Top = 423
    Width = 78
    Cancel = True
    Caption = 'Закрыть'
    Default = True
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    OnClick = Btn_FonFitClick
    ParentFont = False
    TabOrder = 3
  end
  object Btn_GetDefault: TBitBtn
    Left = 8
    Height = 30
    Top = 288
    Width = 137
    Caption = 'Вернуть к исходному'
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    OnClick = Btn_GetDefaultClick
    ParentFont = False
    TabOrder = 4
  end
  object CB_AutoRecalc: TCheckBox
    Left = 8
    Height = 17
    Top = 324
    Width = 90
    Caption = 'Автопересчёт'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = OptionsChanged
  end
  object CB_ReadCalculated: TCheckBox
    Left = 8
    Height = 17
    Top = 13
    Width = 179
    Caption = 'Загружать ранее рассчитанное'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object CB_ProtectAutoChange: TCheckBox
    Left = 8
    Height = 17
    Top = 36
    Width = 141
    Caption = 'Фиксировать настройки'
    TabOrder = 7
    OnClick = CB_ProtectAutoChangeClick
  end
  object BtnSaveOptions: TButton
    Left = 8
    Height = 25
    Top = 363
    Width = 192
    Caption = 'Сохранить настройки как ...'
    TabOrder = 8
    OnClick = BtnSaveOptionsClick
  end
  object Edit_MethodName: TEdit
    Left = 8
    Height = 21
    Top = 242
    Width = 169
    TabOrder = 9
    Visible = False
    OnChange = OptionsChanged
  end
  object BtnLoadOptions: TButton
    Left = 8
    Height = 25
    Top = 394
    Width = 192
    Caption = 'Загрузить'
    TabOrder = 10
    OnClick = BtnLoadOptionsClick
  end
  object BtnSetMethod: TBitBtn
    Left = 179
    Height = 25
    Hint = 'Алгоритм'
    Top = 240
    Width = 25
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00303333333333
      333337F3333333333333303333333333333337F33FFFFF3FF3FF303300000300
      300337FF77777F77377330000BBB0333333337777F337F33333330330BB00333
      333337F373F773333333303330033333333337F3377333333333303333333333
      333337F33FFFFF3FF3FF303300000300300337FF77777F77377330000BBB0333
      333337777F337F33333330330BB00333333337F373F773333333303330033333
      333337F3377333333333303333333333333337FFFF3FF3FFF333000003003000
      333377777F77377733330BBB0333333333337F337F33333333330BB003333333
      333373F773333333333330033333333333333773333333333333
    }
    NumGlyphs = 2
    OnClick = BtnSetMethodClick
    TabOrder = 11
    Visible = False
  end
  object SaveTextFileDialog: TSaveDialog
    DefaultExt = '.txt'
    FileName = 'LOG'
    InitialDir = '.'
    Left = 985
    Top = 585
  end
  object SaveOptionsDialog: TSaveDialog
    DefaultExt = '.mtd'
    Filter = 'Методы|*.mtd'
    Left = 108
    Top = 330
  end
  object LoadOptionsDialog: TOpenDialog
    DefaultExt = '.mtd'
    Filter = 'Методы|*.mtd'
    Left = 140
    Top = 330
  end
end
