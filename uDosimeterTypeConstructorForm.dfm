object DosimeterTypeConstructorForm: TDosimeterTypeConstructorForm
  Left = 383
  Height = 895
  Top = 44
  Width = 1310
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Редактирование типов дозиметров'
  ClientHeight = 895
  ClientWidth = 1310
  Color = clBtnFace
  Constraints.MinHeight = 820
  Constraints.MinWidth = 1250
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poMainFormCenter
  LCLVersion = '2.2.6.0'
  object PanelGrid: TPanel
    Left = 0
    Height = 895
    Top = 0
    Width = 255
    Align = alLeft
    Anchors = [akTop, akLeft, akRight, akBottom]
    ClientHeight = 895
    ClientWidth = 255
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object PanelTopGrid: TPanel
      Left = 1
      Height = 50
      Top = 1
      Width = 253
      Align = alTop
      ClientHeight = 50
      ClientWidth = 253
      ParentBackground = False
      TabOrder = 0
      object LblDosType: TLabel
        Left = 1
        Height = 48
        Top = 1
        Width = 251
        Align = alClient
        Alignment = taCenter
        Caption = ' Типы дозиметров'
        Layout = tlCenter
        ParentColor = False
      end
    end
    object DBGridEhDosType: TDBGridEh
      Left = 1
      Height = 789
      Top = 51
      Width = 253
      TabStop = False
      Align = alClient
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSourceDosType
      DynProps = <>
      EvenRowColor = clWindow
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      FooterParams.VertLines = False
      IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
      IndicatorParams.Color = clBtnFace
      OddRowColor = clWindow
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentFont = False
      ReadOnly = True
      SortLocal = True
      STFilter.Local = True
      TabOrder = 1
      OnCellClick = DBGridEhDosTypeCellClick
      OnKeyUp = DBGridEhDosTypeKeyUp
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object PanelBottomGrid: TPanel
      Left = 1
      Height = 54
      Top = 840
      Width = 253
      Align = alBottom
      ClientHeight = 54
      ClientWidth = 253
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      object SpeedBtnAddDosType: TSpeedButton
        Left = 128
        Height = 44
        Top = 6
        Width = 120
        Anchors = [akTop, akRight]
        Caption = 'Добавить'
        OnClick = SpeedBtnAddDosTypeClick
      end
      object SpeedBtnDelDosPart: TSpeedButton
        Left = 5
        Height = 44
        Top = 6
        Width = 120
        Caption = 'Удалить'
        OnClick = SpeedBtnDelDosPartClick
      end
    end
  end
  object PanelRight: TPanel
    Left = 255
    Height = 895
    Top = 0
    Width = 1055
    Align = alClient
    ClientHeight = 895
    ClientWidth = 1055
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object PanelDosTypeOptions: TPanel
      Left = 1
      Height = 839
      Top = 1
      Width = 1053
      Align = alClient
      ClientHeight = 839
      ClientWidth = 1053
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object LblErr: TLabel
        Left = 597
        Height = 22
        Top = 602
        Width = 232
        Caption = 'Основная погрешность:'
        ParentColor = False
      end
      object LblFormula: TLabel
        Left = 20
        Height = 22
        Top = 597
        Width = 230
        Caption = 'Формула расчета дозы:'
        ParentColor = False
      end
      object LblNewDosType: TLabel
        Left = 19
        Height = 22
        Top = 15
        Width = 152
        Caption = 'Тип дозиметра:'
        ParentColor = False
      end
      object LblMeasDosValue: TLabel
        Left = 496
        Height = 22
        Top = 15
        Width = 223
        Caption = 'Измеряемая величина:'
        ParentColor = False
      end
      object LblDetsCount: TLabel
        Left = 275
        Height = 22
        Top = 15
        Width = 188
        Caption = 'Кол-во детекторов:'
        ParentColor = False
      end
      object ShapeErr_4: TShape
        Left = 687
        Height = 2
        Top = 901
        Width = 67
        Brush.Color = clBlack
      end
      object LblHErr_4: TLabel
        Left = 679
        Height = 25
        Top = 909
        Width = 80
        Alignment = taCenter
        AutoSize = False
        Caption = 'H'
        ParentColor = False
      end
      object LblPlus_4: TLabel
        Left = 760
        Height = 22
        Top = 888
        Width = 15
        Caption = '+'
        ParentColor = False
      end
      object LblValPercent_4: TLabel
        Left = 842
        Height = 22
        Top = 888
        Width = 21
        Caption = '%'
        ParentColor = False
      end
      object LblValPercent_3: TLabel
        Left = 842
        Height = 22
        Top = 812
        Width = 21
        Caption = '%'
        ParentColor = False
      end
      object LblPlus_3: TLabel
        Left = 760
        Height = 22
        Top = 811
        Width = 15
        Caption = '+'
        ParentColor = False
      end
      object LblHErr_3: TLabel
        Left = 679
        Height = 25
        Top = 831
        Width = 80
        Alignment = taCenter
        AutoSize = False
        Caption = 'H'
        ParentColor = False
      end
      object ShapeErr_3: TShape
        Left = 687
        Height = 2
        Top = 823
        Width = 67
        Brush.Color = clBlack
      end
      object LblValPercent_2: TLabel
        Left = 842
        Height = 22
        Top = 731
        Width = 21
        Caption = '%'
        ParentColor = False
      end
      object LblPlus_2: TLabel
        Left = 760
        Height = 22
        Top = 732
        Width = 15
        Caption = '+'
        ParentColor = False
      end
      object LblHErr_2: TLabel
        Left = 679
        Height = 25
        Top = 753
        Width = 80
        Alignment = taCenter
        AutoSize = False
        Caption = 'H'
        ParentColor = False
      end
      object ShapeErr_2: TShape
        Left = 687
        Height = 2
        Top = 745
        Width = 67
        Brush.Color = clBlack
      end
      object LblValPercent_1: TLabel
        Left = 842
        Height = 22
        Top = 654
        Width = 21
        Caption = '%'
        ParentColor = False
      end
      object LblPlus_1: TLabel
        Left = 760
        Height = 22
        Top = 654
        Width = 15
        Caption = '+'
        ParentColor = False
      end
      object LblHErr_1: TLabel
        Left = 679
        Height = 25
        Top = 675
        Width = 80
        Alignment = taCenter
        AutoSize = False
        Caption = 'H'
        ParentColor = False
      end
      object ShapeErr_1: TShape
        Left = 687
        Height = 2
        Top = 667
        Width = 67
        Brush.Color = clBlack
      end
      object LblErr1: TLabel
        Left = 647
        Height = 22
        Top = 654
        Width = 15
        Caption = '='
        ParentColor = False
      end
      object LblErr2: TLabel
        Left = 647
        Height = 22
        Top = 731
        Width = 15
        Caption = '='
        ParentColor = False
      end
      object LblErr3: TLabel
        Left = 647
        Height = 22
        Top = 812
        Width = 15
        Caption = '='
        ParentColor = False
      end
      object LblErr4: TLabel
        Left = 647
        Height = 22
        Top = 888
        Width = 15
        Caption = '='
        ParentColor = False
      end
      object EditDosType: TEdit
        Left = 19
        Height = 34
        Top = 46
        Width = 206
        Alignment = taCenter
        Color = clBtnFace
        OnEnter = EditDisable
        OnExit = EditEnable
        TabStop = False
        TabOrder = 0
      end
      object GBoxD1: TGroupBox
        Left = 19
        Height = 517
        Top = 84
        Width = 250
        Caption = 'Детектор1'
        ClientHeight = 494
        ClientWidth = 248
        ParentBackground = False
        TabOrder = 3
        object LblMeasValD1: TLabel
          Left = 16
          Height = 17
          Top = 35
          Width = 175
          Caption = 'Измеряемое излучение:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMaterialD1: TLabel
          Left = 16
          Height = 17
          Top = 163
          Width = 154
          Caption = 'Материал детектора:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMaterialParamD1: TLabel
          Left = 16
          Height = 17
          Top = 292
          Width = 135
          Caption = 'Профиль нагрева:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblKD1: TLabel
          Left = 16
          Height = 17
          Top = 99
          Width = 150
          Caption = 'К-чувствительности:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMethodD1: TLabel
          Left = 16
          Height = 17
          Top = 228
          Width = 133
          Caption = 'Метод обработки:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object SpeedBtnD1Inf: TSpeedButton
          Left = 202
          Height = 34
          Top = 188
          Width = 34
          Caption = 'i'
          OnClick = SpeedBtnD1InfClick
        end
        object ComboBoxD1: TComboBox
          Left = 16
          Height = 38
          Hint = 'Hint'
          Top = 188
          Width = 180
          ItemHeight = 28
          OnChange = ComboBoxD1Change
          ParentShowHint = False
          ShowHint = True
          Style = csOwnerDrawFixed
          TabOrder = 0
        end
        object MemoD1: TMemo
          Left = 16
          Height = 163
          Top = 317
          Width = 220
          Color = clBtnFace
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          OnEnter = MemoDisable
          OnExit = MemoEnable
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          TabStop = False
        end
        object EditMeasValD1: TEdit
          Left = 16
          Height = 34
          Top = 60
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 2
        end
        object EditKD1: TEdit
          Left = 16
          Height = 34
          Top = 124
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 3
        end
        object EditMethodD1: TEdit
          Left = 16
          Height = 34
          Top = 253
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 4
        end
      end
      object GBoxD2: TGroupBox
        Left = 275
        Height = 517
        Top = 84
        Width = 250
        Caption = 'Детектор2'
        ClientHeight = 494
        ClientWidth = 248
        ParentBackground = False
        TabOrder = 4
        object LblMeasValD2: TLabel
          Left = 16
          Height = 17
          Top = 35
          Width = 175
          Caption = 'Измеряемое излучение:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMaterialD2: TLabel
          Left = 16
          Height = 17
          Top = 163
          Width = 154
          Caption = 'Материал детектора:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMaterialParamD2: TLabel
          Left = 16
          Height = 17
          Top = 292
          Width = 135
          Caption = 'Профиль нагрева:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblKD2: TLabel
          Left = 16
          Height = 17
          Top = 99
          Width = 150
          Caption = 'К-чувствительности:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMethodD2: TLabel
          Left = 16
          Height = 17
          Top = 228
          Width = 133
          Caption = 'Метод обработки:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object SpeedButton1: TSpeedButton
          Left = 202
          Height = 34
          Top = 188
          Width = 34
          Caption = 'i'
          OnClick = SpeedButton1Click
        end
        object ComboBoxD2: TComboBox
          Left = 16
          Height = 38
          Top = 188
          Width = 180
          ItemHeight = 28
          OnChange = ComboBoxD2Change
          Style = csOwnerDrawFixed
          TabOrder = 0
        end
        object MemoD2: TMemo
          Left = 16
          Height = 163
          Top = 317
          Width = 220
          Color = clBtnFace
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          OnEnter = MemoDisable
          OnExit = MemoEnable
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          TabStop = False
        end
        object EditMeasValD2: TEdit
          Left = 16
          Height = 34
          Top = 60
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 2
        end
        object EditKD2: TEdit
          Left = 16
          Height = 34
          Top = 124
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 3
        end
        object EditMethodD2: TEdit
          Left = 16
          Height = 34
          Top = 253
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 4
        end
      end
      object GBoxD3: TGroupBox
        Left = 531
        Height = 517
        Top = 84
        Width = 250
        Caption = 'Детектор3'
        ClientHeight = 494
        ClientWidth = 248
        ParentBackground = False
        TabOrder = 5
        object LblMeasValD3: TLabel
          Left = 16
          Height = 17
          Top = 35
          Width = 175
          Caption = 'Измеряемое излучение:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMaterialD3: TLabel
          Left = 16
          Height = 17
          Top = 163
          Width = 154
          Caption = 'Материал детектора:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMaterialParamD3: TLabel
          Left = 16
          Height = 17
          Top = 292
          Width = 135
          Caption = 'Профиль нагрева:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblKD3: TLabel
          Left = 16
          Height = 17
          Top = 99
          Width = 150
          Caption = 'К-чувствительности:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMethodD3: TLabel
          Left = 16
          Height = 17
          Top = 228
          Width = 133
          Caption = 'Метод обработки:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object SpeedButton2: TSpeedButton
          Left = 202
          Height = 34
          Top = 188
          Width = 34
          Caption = 'i'
          OnClick = SpeedButton2Click
        end
        object ComboBoxD3: TComboBox
          Left = 16
          Height = 38
          Top = 188
          Width = 180
          ItemHeight = 28
          OnChange = ComboBoxD3Change
          Style = csOwnerDrawFixed
          TabOrder = 0
        end
        object MemoD3: TMemo
          Left = 16
          Height = 163
          Top = 317
          Width = 220
          Color = clBtnFace
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          OnEnter = MemoDisable
          OnExit = MemoEnable
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          TabStop = False
        end
        object EditMeasValD3: TEdit
          Left = 16
          Height = 34
          Top = 60
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 2
        end
        object EditKD3: TEdit
          Left = 16
          Height = 34
          Top = 124
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 3
        end
        object EditMethodD3: TEdit
          Left = 16
          Height = 34
          Top = 253
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 4
        end
      end
      object GBoxD4: TGroupBox
        Left = 787
        Height = 517
        Top = 84
        Width = 250
        Caption = 'Детектор4'
        ClientHeight = 494
        ClientWidth = 248
        ParentBackground = False
        TabOrder = 6
        object LblMeasValD4: TLabel
          Left = 16
          Height = 17
          Top = 35
          Width = 175
          Caption = 'Измеряемое излучение:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMaterialD4: TLabel
          Left = 16
          Height = 17
          Top = 163
          Width = 154
          Caption = 'Материал детектора:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMaterialParamD4: TLabel
          Left = 16
          Height = 17
          Top = 292
          Width = 135
          Caption = 'Профиль нагрева:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblKD4: TLabel
          Left = 16
          Height = 17
          Top = 99
          Width = 150
          Caption = 'К-чувствительности:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMethodD4: TLabel
          Left = 16
          Height = 17
          Top = 228
          Width = 133
          Caption = 'Метод обработки:'
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object SpeedButton3: TSpeedButton
          Left = 202
          Height = 34
          Top = 188
          Width = 34
          Caption = 'i'
          OnClick = SpeedButton3Click
        end
        object ComboBoxD4: TComboBox
          Left = 16
          Height = 38
          Top = 188
          Width = 180
          ItemHeight = 28
          OnChange = ComboBoxD4Change
          Style = csOwnerDrawFixed
          TabOrder = 0
        end
        object MemoD4: TMemo
          Left = 16
          Height = 163
          Top = 317
          Width = 220
          Color = clBtnFace
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          OnEnter = MemoDisable
          OnExit = MemoEnable
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          TabStop = False
        end
        object EditMeasValD4: TEdit
          Left = 16
          Height = 34
          Top = 60
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 2
        end
        object EditKD4: TEdit
          Left = 16
          Height = 34
          Top = 124
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 3
        end
        object EditMethodD4: TEdit
          Left = 16
          Height = 34
          Top = 253
          Width = 220
          Alignment = taCenter
          Color = clBtnFace
          OnEnter = EditDisable
          OnExit = EditEnable
          ReadOnly = True
          TabStop = False
          TabOrder = 4
        end
      end
      object EditDosMeasVal_1: TEdit
        Left = 19
        Height = 34
        Top = 651
        Width = 135
        Alignment = taCenter
        Color = clBtnFace
        OnEnter = EditDisable
        OnExit = EditEnable
        ReadOnly = True
        TabStop = False
        TabOrder = 7
      end
      object EditDosMeasVal_2: TEdit
        Left = 19
        Height = 34
        Top = 728
        Width = 135
        Alignment = taCenter
        Color = clBtnFace
        OnEnter = EditDisable
        OnExit = EditEnable
        ReadOnly = True
        TabStop = False
        TabOrder = 8
      end
      object EditDosMeasVal_3: TEdit
        Left = 19
        Height = 34
        Top = 808
        Width = 135
        Alignment = taCenter
        Color = clBtnFace
        OnEnter = EditDisable
        OnExit = EditEnable
        ReadOnly = True
        TabStop = False
        TabOrder = 9
      end
      object EditDosMeasVal_4: TEdit
        Left = 19
        Height = 34
        Top = 885
        Width = 135
        Alignment = taCenter
        Color = clBtnFace
        OnEnter = EditDisable
        OnExit = EditEnable
        ReadOnly = True
        TabStop = False
        TabOrder = 10
      end
      object CBoxMeasValue: TComboBox
        Left = 496
        Height = 38
        Hint = 'Hint'
        Top = 46
        Width = 541
        ItemHeight = 28
        OnChange = CBoxMeasValueChange
        ParentShowHint = False
        ShowHint = True
        Style = csOwnerDrawFixed
        TabOrder = 2
      end
      object EditFormulaVal_1: TEdit
        Left = 160
        Height = 34
        Top = 651
        Width = 481
        Alignment = taCenter
        Color = clBtnFace
        OnEnter = EditDisable
        OnExit = EditEnable
        ReadOnly = True
        TabStop = False
        TabOrder = 11
      end
      object EditFormulaVal_2: TEdit
        Left = 160
        Height = 34
        Top = 728
        Width = 481
        Alignment = taCenter
        Color = clBtnFace
        OnEnter = EditDisable
        OnExit = EditEnable
        ReadOnly = True
        TabStop = False
        TabOrder = 12
      end
      object EditFormulaVal_3: TEdit
        Left = 160
        Height = 34
        Top = 808
        Width = 481
        Alignment = taCenter
        Color = clBtnFace
        OnEnter = EditDisable
        OnExit = EditEnable
        ReadOnly = True
        TabStop = False
        TabOrder = 13
      end
      object EditFormulaVal_4: TEdit
        Left = 160
        Height = 34
        Top = 885
        Width = 481
        Alignment = taCenter
        Color = clBtnFace
        OnEnter = EditDisable
        OnExit = EditEnable
        ReadOnly = True
        TabStop = False
        TabOrder = 14
      end
      object CBoxDetsCnt: TComboBox
        Left = 275
        Height = 38
        Hint = 'Hint'
        Top = 46
        Width = 54
        ItemHeight = 28
        OnChange = CBoxDetsCntChange
        ParentShowHint = False
        ShowHint = True
        Style = csOwnerDrawFixed
        TabOrder = 1
      end
      object EditValErrK1_4: TEdit
        Left = 693
        Height = 34
        Top = 862
        Width = 55
        Alignment = taCenter
        TabOrder = 21
      end
      object EditValErrK2_4: TEdit
        Left = 781
        Height = 34
        Top = 885
        Width = 55
        Alignment = taCenter
        TabOrder = 22
      end
      object EditValErrK2_3: TEdit
        Left = 781
        Height = 34
        Top = 808
        Width = 55
        Alignment = taCenter
        TabOrder = 20
      end
      object EditValErrK1_3: TEdit
        Left = 693
        Height = 34
        Top = 784
        Width = 55
        Alignment = taCenter
        TabOrder = 19
      end
      object EditValErrK2_2: TEdit
        Left = 781
        Height = 34
        Top = 728
        Width = 55
        Alignment = taCenter
        TabOrder = 18
      end
      object EditValErrK1_2: TEdit
        Left = 693
        Height = 34
        Top = 706
        Width = 55
        Alignment = taCenter
        TabOrder = 17
      end
      object EditValErrK2_1: TEdit
        Left = 781
        Height = 34
        Top = 651
        Width = 55
        Alignment = taCenter
        TabOrder = 16
      end
      object EditValErrK1_1: TEdit
        Left = 693
        Height = 34
        Top = 628
        Width = 55
        Alignment = taCenter
        TabOrder = 15
      end
    end
    object PanelDosTypeBottom: TPanel
      Left = 1
      Height = 54
      Top = 840
      Width = 1053
      Align = alBottom
      ClientHeight = 54
      ClientWidth = 1053
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object BtnClose: TButton
        Left = 5
        Height = 44
        Top = 6
        Width = 116
        Caption = 'Закрыть'
        OnClick = BtnCloseClick
        TabOrder = 0
      end
      object BtnSaveChanges: TButton
        Left = 754
        Height = 44
        Top = 6
        Width = 293
        Caption = 'Сохранить изменения'
        OnClick = BtnSaveChangesClick
        TabOrder = 1
      end
    end
  end
  object DataSourceDosType: TDataSource
    DataSet = MemTableEhDosType
    Left = 232
    Top = 56
  end
  object MemTableEhDosType: TMemTableEh
    Filtered = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = DataSetDriverEhDosType
    Left = 232
    Top = 104
  end
  object DataSetDriverEhDosType: TDataSetDriverEh
    ProviderDataSet = ADOQueryDosType
    Left = 232
    Top = 152
  end
  object ADOQueryDosType: TSQLQuery
    PacketRecords = 2147483647
    FieldDefs = <>
    Filtered = True
    Database = TLDDataModule.ODBCConnection
    Transaction = TLDDataModule.dbSQLTransaction
    Params = <>
    Macros = <>
    Left = 65
    Top = 62
  end
end
