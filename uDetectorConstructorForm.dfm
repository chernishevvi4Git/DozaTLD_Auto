object DetectorConstructorForm: TDetectorConstructorForm
  Left = 579
  Height = 800
  Top = 63
  Width = 1150
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Редактирование материалов детекторов'
  ClientHeight = 800
  ClientWidth = 1150
  Color = clBtnFace
  Constraints.MinHeight = 800
  Constraints.MinWidth = 1150
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poMainFormCenter
  LCLVersion = '3.6.0.0'
  object PanelGrid: TPanel
    Left = 0
    Height = 800
    Top = 0
    Width = 403
    Align = alClient
    ClientHeight = 800
    ClientWidth = 403
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    OnResize = PanelGridResize
    object DBGridEhDetType: TDBGridEh
      Left = 1
      Height = 694
      Top = 51
      Width = 401
      TabStop = False
      Align = alClient
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSourceDetType
      DynProps = <>
      FooterParams.VertLines = False
      IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ReadOnly = True
      SortLocal = True
      STFilter.Local = True
      TabOrder = 0
      OnCellClick = DBGridEhDetTypeCellClick
      OnKeyUp = DBGridEhDetTypeKeyUp
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object PanelTopGrid: TPanel
      Left = 1
      Height = 50
      Top = 1
      Width = 401
      Align = alTop
      ClientHeight = 50
      ClientWidth = 401
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object LblDetType: TLabel
        Left = 1
        Height = 48
        Top = 1
        Width = 399
        Align = alClient
        Alignment = taCenter
        Caption = 'Типы детекторов'
        Layout = tlCenter
        ParentColor = False
      end
    end
    object PanelBottomGrid: TPanel
      Left = 1
      Height = 54
      Top = 745
      Width = 401
      Align = alBottom
      ClientHeight = 54
      ClientWidth = 401
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      object SpeedBtnAddDetType: TSpeedButton
        Left = 276
        Height = 44
        Top = 6
        Width = 120
        Anchors = [akTop, akRight]
        Caption = 'Добавить'
        OnClick = SpeedBtnAddDetTypeClick
      end
      object SpeedBtnDelDetType: TSpeedButton
        Left = 8
        Height = 44
        Top = 6
        Width = 120
        Caption = 'Удалить'
        OnClick = SpeedBtnDelDetTypeClick
      end
    end
  end
  object PanelChart: TPanel
    Left = 403
    Height = 800
    Top = 0
    Width = 747
    Align = alRight
    ClientHeight = 800
    ClientWidth = 747
    ParentBackground = False
    TabOrder = 1
    object PanelButtom: TPanel
      Left = 1
      Height = 449
      Top = 296
      Width = 745
      Align = alBottom
      ClientHeight = 449
      ClientWidth = 745
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object LblDetName: TLabel
        Left = 19
        Height = 25
        Top = 15
        Width = 209
        Caption = 'Название материала:'
        ParentColor = False
      end
      object EditDetName: TEdit
        Left = 234
        Height = 33
        Top = 12
        Width = 265
        Alignment = taCenter
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
        OnEnter = EditDisable
        OnExit = EditEnable
      end
      object GroupBoxProfileParam: TGroupBox
        Left = 19
        Height = 382
        Top = 51
        Width = 710
        Caption = 'Параметры профиля'
        ClientHeight = 352
        ClientWidth = 706
        ParentBackground = False
        TabOrder = 1
        object LblSpeed: TLabel
          Left = 13
          Height = 25
          Top = 112
          Width = 244
          Caption = 'Скорость нагрева, С/сек:'
          ParentColor = False
        end
        object LblTemp: TLabel
          Left = 13
          Height = 25
          Top = 73
          Width = 158
          Caption = 'Температура, C:'
          ParentColor = False
        end
        object LblTime: TLabel
          Left = 13
          Height = 25
          Top = 34
          Width = 111
          Caption = 'Время, сек:'
          ParentColor = False
        end
        object LblFullMeasureTime: TLabel
          Left = 13
          Height = 25
          Top = 177
          Width = 222
          Caption = 'Время измерения, сек:'
          ParentColor = False
        end
        object LblMethod: TLabel
          Left = 13
          Height = 25
          Top = 220
          Width = 175
          Caption = 'Метод обработки:'
          ParentColor = False
        end
        object LblProfileErr: TLabel
          Left = 272
          Height = 19
          Top = 150
          Width = 87
          Caption = 'LblProfileErr'
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblMethodErr: TLabel
          Left = 282
          Height = 19
          Top = 247
          Width = 87
          Caption = 'LblProfileErr'
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LabelUserMethod: TLabel
          Left = 437
          Height = 25
          Top = 182
          Width = 250
          Caption = 'Пользовательский метод:'
          ParentColor = False
        end
        object GroupBoxBurn: TGroupBox
          Left = 558
          Height = 152
          Top = 0
          Width = 137
          Caption = 'Дожиг'
          ClientHeight = 122
          ClientWidth = 133
          ParentBackground = False
          TabOrder = 2
          object EditBurnTime: TEdit
            Left = 10
            Height = 33
            Top = 5
            Width = 117
            Alignment = taCenter
            NumbersOnly = True
            ParentBidiMode = False
            TabOrder = 0
            OnChange = EditBurnTimeChange
            OnKeyUp = EditBurnTimeKeyUp
          end
          object EditBurnTemp: TEdit
            Left = 10
            Height = 33
            Top = 44
            Width = 117
            Alignment = taCenter
            NumbersOnly = True
            TabOrder = 1
            OnChange = EditBurnTempChange
            OnKeyUp = EditBurnTempKeyUp
          end
          object EditBurnSpeed: TEdit
            Left = 10
            Height = 33
            Top = 83
            Width = 117
            Alignment = taCenter
            Color = clBtnFace
            NumbersOnly = True
            ReadOnly = True
            TabStop = False
            TabOrder = 2
            OnEnter = EditDisable
            OnExit = EditEnable
          end
        end
        object GroupBoxMeasuring: TGroupBox
          Left = 415
          Height = 152
          Top = 0
          Width = 137
          Caption = 'Измерение'
          ClientHeight = 122
          ClientWidth = 133
          ParentBackground = False
          TabOrder = 1
          object EditMeasuringTemp: TEdit
            Left = 10
            Height = 33
            Top = 44
            Width = 117
            Alignment = taCenter
            NumbersOnly = True
            TabOrder = 1
            OnChange = EditMeasuringTempChange
            OnKeyUp = EditMeasuringTempKeyUp
          end
          object EditMeasuringTime: TEdit
            Left = 10
            Height = 33
            Top = 5
            Width = 117
            Alignment = taCenter
            NumbersOnly = True
            TabOrder = 0
            OnChange = EditMeasuringTimeChange
            OnKeyUp = EditMeasuringTimeKeyUp
          end
          object EditMeasuringSpeed: TEdit
            Left = 10
            Height = 33
            Top = 83
            Width = 117
            Alignment = taCenter
            TabOrder = 2
            OnChange = EditMeasuringSpeedChange
            OnKeyUp = EditMeasuringSpeedKeyUp
          end
        end
        object GroupBoxPreHeating: TGroupBox
          Left = 272
          Height = 152
          Top = 0
          Width = 137
          Caption = 'Преднагрев'
          ClientHeight = 122
          ClientWidth = 133
          ParentBackground = False
          TabOrder = 0
          object EditPreHeatTime: TEdit
            Left = 10
            Height = 33
            Top = 5
            Width = 117
            Alignment = taCenter
            NumbersOnly = True
            ParentBidiMode = False
            TabOrder = 0
            OnChange = EditPreHeatTimeChange
            OnKeyUp = EditPreHeatTimeKeyUp
          end
          object EditPreHeatTemp: TEdit
            Left = 10
            Height = 33
            Top = 44
            Width = 117
            Alignment = taCenter
            NumbersOnly = True
            TabOrder = 1
            OnChange = EditPreHeatTempChange
            OnKeyUp = EditPreHeatTempKeyUp
          end
          object EditPreHeatSpeed: TEdit
            Left = 10
            Height = 33
            Top = 83
            Width = 117
            Alignment = taCenter
            Color = clBtnFace
            NumbersOnly = True
            ReadOnly = True
            TabStop = False
            TabOrder = 2
            OnEnter = EditDisable
            OnExit = EditEnable
          end
        end
        object EditFullTime: TEdit
          Left = 282
          Height = 33
          Top = 174
          Width = 70
          Alignment = taCenter
          Color = clBtnFace
          NumbersOnly = True
          ReadOnly = True
          TabStop = False
          TabOrder = 3
          OnEnter = EditDisable
          OnExit = EditEnable
        end
        object CBoxMethod: TComboBox
          Left = 282
          Height = 34
          Hint = 'Hint'
          Top = 213
          Width = 149
          ItemHeight = 28
          ParentShowHint = False
          ShowHint = True
          Style = csOwnerDrawFixed
          TabOrder = 4
          OnChange = CBoxMethodChange
          OnKeyUp = CBoxMethodKeyUp
        end
        object ComboBoxUserMethod: TComboBox
          Left = 437
          Height = 34
          Hint = 'Hint'
          Top = 213
          Width = 260
          ItemHeight = 28
          ParentShowHint = False
          ShowHint = True
          Style = csOwnerDrawFixed
          TabOrder = 5
          OnChange = ComboBoxUserMethodChange
          OnKeyUp = ComboBoxUserMethodKeyUp
        end
        object LabelK1Profile: TLabel
          Left = 13
          Height = 25
          Top = 275
          Width = 124
          Caption = 'K1-профиля:'
          ParentColor = False
        end
        object LabelK2Profile: TLabel
          Left = 13
          Height = 25
          Top = 315
          Width = 124
          Caption = 'K2-профиля:'
          ParentColor = False
        end
        object LblK1Profile: TLabel
          Left = 282
          Height = 19
          Top = 281
          Width = 84
          Caption = 'LblK1Profile'
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object LblK2Profile: TLabel
          Left = 282
          Height = 19
          Top = 321
          Width = 84
          Caption = 'LblK1Profile'
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Tahoma'
          ParentColor = False
          ParentFont = False
        end
        object EditK1Profile: TEdit
          Left = 176
          Height = 33
          Top = 272
          Width = 96
          TabOrder = 6
          OnChange = EditK1ProfileChange
          OnKeyUp = EditK1ProfileKeyUp
        end
        object EditK2Profile: TEdit
          Left = 177
          Height = 33
          Top = 315
          Width = 96
          TabOrder = 7
          OnChange = EditK2ProfileChange
          OnKeyUp = EditK2ProfileKeyUp
        end
      end
    end
    object PanelTop: TPanel
      Left = 1
      Height = 50
      Top = 1
      Width = 745
      Align = alTop
      ClientHeight = 50
      ClientWidth = 745
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object LblProfile: TLabel
        Left = 1
        Height = 48
        Top = 1
        Width = 743
        Align = alClient
        Alignment = taCenter
        Caption = 'Профиль нагрева'
        Layout = tlCenter
        ParentColor = False
      end
    end
    object PanelCenter: TPanel
      Left = 1
      Height = 245
      Top = 51
      Width = 745
      Align = alClient
      ClientHeight = 245
      ClientWidth = 745
      ParentBackground = False
      TabOrder = 2
      object ChartTempProfile: TChart
        Left = 1
        Height = 243
        Top = 1
        Width = 743
        AxisList = <        
          item
            Grid.Color = 11119017
            TickLength = 6
            Marks.LabelBrush.Style = bsClear
            Minors = <>
            Title.LabelFont.Orientation = 900
            Title.Caption = 'T(C)'
            Title.LabelBrush.Style = bsClear
          end        
          item
            Grid.Color = 11119017
            TickLength = 6
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
        object SeriesTempProfile: TLineSeries
          Title = 'TempProfile'
          LinePen.Color = 8421631
          LinePen.Width = 5
          Pointer.Style = psCircle
        end
      end
    end
    object PanelDosTypeBottom: TPanel
      Left = 1
      Height = 54
      Top = 745
      Width = 745
      Align = alBottom
      ClientHeight = 54
      ClientWidth = 745
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      object BtnClose: TButton
        Left = 5
        Height = 44
        Top = 6
        Width = 116
        Caption = 'Закрыть'
        TabOrder = 0
        OnClick = BtnCloseClick
      end
      object BtnSaveChanges: TButton
        Left = 492
        Height = 44
        Top = 6
        Width = 247
        Caption = 'Сохранить изменения'
        TabOrder = 1
        OnClick = BtnSaveChangesClick
      end
    end
  end
  object DataSourceDetType: TDataSource
    DataSet = MemTableEhDetType
    Left = 232
    Top = 56
  end
  object MemTableEhDetType: TMemTableEh
    Filtered = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = DataSetDriverEhDetType
    Left = 232
    Top = 104
  end
  object DataSetDriverEhDetType: TDataSetDriverEh
    ProviderDataSet = ADOQueryDetType
    Left = 232
    Top = 152
  end
  object ADOQueryDetType: TSQLQuery
    FieldDefs = <>
    Database = TLDDataModule.ODBCConnection
    Transaction = TLDDataModule.dbSQLTransaction
    Params = <>
    Macros = <>
    Left = 368
    Top = 64
  end
  object ADOQueryTempProfile: TSQLQuery
    FieldDefs = <>
    Database = TLDDataModule.ODBCConnection
    Transaction = TLDDataModule.dbSQLTransaction
    Params = <>
    Macros = <>
    Left = 368
    Top = 112
  end
end
