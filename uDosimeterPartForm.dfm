object DosimeterPartForm: TDosimeterPartForm
  Left = 347
  Height = 706
  Top = 171
  Width = 870
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'DosimeterPartForm'
  ClientHeight = 706
  ClientWidth = 870
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnShow = FormShow
  Position = poMainFormCenter
  LCLVersion = '2.2.6.0'
  object PanelGrid: TPanel
    Left = 0
    Height = 706
    Top = 0
    Width = 355
    Align = alLeft
    ClientHeight = 706
    ClientWidth = 355
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 0
    object PanelTopGrid: TPanel
      Left = 1
      Height = 50
      Top = 1
      Width = 353
      Align = alTop
      ClientHeight = 50
      ClientWidth = 353
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      ParentFont = False
      TabOrder = 0
      object LblPartGrid: TLabel
        Left = 1
        Height = 48
        Top = 1
        Width = 351
        Align = alClient
        Alignment = taCenter
        Caption = 'Партии'
        Layout = tlCenter
        ParentColor = False
      end
    end
    object PanelBottomGrid: TPanel
      Left = 1
      Height = 91
      Top = 614
      Width = 353
      Align = alBottom
      ClientHeight = 91
      ClientWidth = 353
      TabOrder = 1
      object SpeedBtnDelDosPart: TSpeedButton
        Left = 6
        Height = 44
        Top = 41
        Width = 120
        Caption = 'Удалить'
        OnClick = SpeedBtnDelDosPartClick
      end
      object CheckBoxShowAllDev: TCheckBox
        Left = 6
        Height = 29
        Top = 6
        Width = 251
        Caption = 'Показать все установки'
        Checked = True
        OnClick = CheckBoxShowAllDevClick
        State = cbChecked
        TabOrder = 0
      end
    end
    object DBGridEhDosPart: TDBGridEh
      Left = 1
      Height = 563
      Top = 51
      Width = 353
      Align = alClient
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSourceDosPart
      DynProps = <>
      FooterRowCount = 1
      FooterParams.VertLines = False
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ReadOnly = True
      SortLocal = True
      STFilter.Local = True
      TabOrder = 2
      OnCellClick = DBGridEhDosPartCellClick
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object PanelK: TPanel
    Left = 355
    Height = 706
    Top = 0
    Width = 515
    Align = alClient
    ClientHeight = 706
    ClientWidth = 515
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 1
    object LblDosPartName: TLabel
      Left = 19
      Height = 25
      Top = 69
      Width = 175
      Caption = 'Название партии:'
      ParentColor = False
    end
    object LblK_1: TLabel
      Left = 55
      Height = 25
      Top = 118
      Width = 30
      Caption = 'K1:'
      ParentColor = False
    end
    object LblK_2: TLabel
      Left = 55
      Height = 25
      Top = 168
      Width = 30
      Caption = 'K2:'
      ParentColor = False
    end
    object LblK_3: TLabel
      Left = 55
      Height = 25
      Top = 218
      Width = 30
      Caption = 'K3:'
      ParentColor = False
    end
    object LblK_4: TLabel
      Left = 55
      Height = 25
      Top = 268
      Width = 30
      Caption = 'K4:'
      ParentColor = False
    end
    object LblK_5: TLabel
      Left = 55
      Height = 25
      Top = 318
      Width = 30
      Caption = 'K5:'
      ParentColor = False
    end
    object LblK_gn: TLabel
      Left = 250
      Height = 25
      Top = 118
      Width = 43
      Caption = 'Kgn:'
      ParentColor = False
    end
    object LblDotKgn: TLabel
      Left = 232
      Height = 25
      Top = 118
      Width = 12
      Caption = 'd'
      ParentColor = False
    end
    object LblDotK5: TLabel
      Left = 37
      Height = 25
      Top = 318
      Width = 12
      Caption = 'd'
      ParentColor = False
    end
    object LblDotK4: TLabel
      Left = 37
      Height = 25
      Top = 268
      Width = 12
      Caption = 'd'
      ParentColor = False
    end
    object LblDotK3: TLabel
      Left = 37
      Height = 25
      Top = 218
      Width = 12
      Caption = 'd'
      ParentColor = False
    end
    object LblDotK2: TLabel
      Left = 37
      Height = 25
      Top = 168
      Width = 12
      Caption = 'd'
      ParentColor = False
    end
    object LblDotK1: TLabel
      Left = 37
      Height = 25
      Top = 118
      Width = 12
      Caption = 'd'
      ParentColor = False
    end
    object LblPartDosType: TLabel
      Left = 19
      Height = 25
      Top = 375
      Width = 163
      Caption = 'Тип дозиметров:'
      ParentColor = False
    end
    object LblPartCalibrDate: TLabel
      Left = 19
      Height = 25
      Top = 471
      Width = 249
      Caption = 'Дата последней поверки:'
      ParentColor = False
    end
    object LblPartComment: TLabel
      Left = 19
      Height = 25
      Top = 515
      Width = 230
      Caption = 'Комментарий к партии:'
      ParentColor = False
    end
    object LblPartDosCnt: TLabel
      Left = 19
      Height = 25
      Top = 423
      Width = 216
      Caption = 'Дозиметров в партии:'
      ParentColor = False
    end
    object PanelTopK: TPanel
      Left = 1
      Height = 50
      Top = 1
      Width = 513
      Align = alTop
      ClientHeight = 50
      ClientWidth = 513
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      ParentFont = False
      TabOrder = 0
      object LblPartTopK: TLabel
        Left = 1
        Height = 48
        Top = 1
        Width = 511
        Align = alClient
        Alignment = taCenter
        Caption = 'Коэффициенты'
        Layout = tlCenter
        ParentColor = False
      end
    end
    object PanelBottomK: TPanel
      Left = 1
      Height = 54
      Top = 651
      Width = 513
      Align = alBottom
      ClientHeight = 54
      ClientWidth = 513
      TabOrder = 1
      object SpeedBtnSaveChanges: TSpeedButton
        Left = 216
        Height = 44
        Top = 6
        Width = 293
        Anchors = [akTop, akRight]
        Caption = 'Сохранить изменения'
        OnClick = SpeedBtnSaveChangesClick
      end
      object BtnClose: TButton
        Left = 5
        Height = 44
        Top = 6
        Width = 116
        Cancel = True
        Caption = 'Закрыть'
        OnClick = BtnCloseClick
        TabOrder = 0
      end
    end
    object EditK_1: TEdit
      Left = 91
      Height = 33
      Top = 115
      Width = 122
      TabOrder = 2
    end
    object EditK_2: TEdit
      Left = 91
      Height = 33
      Top = 165
      Width = 122
      TabOrder = 3
    end
    object EditK_3: TEdit
      Left = 91
      Height = 33
      Top = 215
      Width = 122
      TabOrder = 4
    end
    object EditK_4: TEdit
      Left = 91
      Height = 33
      Top = 265
      Width = 122
      TabOrder = 5
    end
    object EditK_5: TEdit
      Left = 91
      Height = 33
      Top = 315
      Width = 122
      TabOrder = 6
    end
    object EditK_gn: TEdit
      Left = 299
      Height = 33
      Top = 115
      Width = 122
      TabOrder = 7
    end
    object EditDosPartName: TEdit
      Left = 212
      Height = 33
      Top = 66
      Width = 209
      Alignment = taCenter
      Color = clBtnFace
      OnEnter = EditDisable
      OnExit = EditEnable
      ReadOnly = True
      TabOrder = 8
    end
    object EditPartDosType: TEdit
      Left = 295
      Height = 33
      Top = 372
      Width = 209
      Alignment = taCenter
      Color = clBtnFace
      OnEnter = EditDisable
      OnExit = EditEnable
      ReadOnly = True
      TabOrder = 9
    end
    object DateTimePickerPartCalibr: TDateTimePicker
      Left = 295
      Height = 33
      Top = 467
      Width = 125
      CenturyFrom = 1941
      MaxDate = 2958465
      MinDate = -53780
      TabOrder = 10
      TrailingSeparator = False
      TextForNullDate = 'NULL'
      LeadingZeros = True
      Kind = dtkDate
      TimeFormat = tf24
      TimeDisplay = tdHMS
      DateMode = dmComboBox
      Date = 44838
      Time = 0.542109675923712
      UseDefaultSeparators = True
      HideDateTimeParts = []
      MonthNames = 'Long'
    end
    object MemoPartComment: TMemo
      Left = 19
      Height = 87
      Top = 546
      Width = 485
      MaxLength = 42
      TabOrder = 11
    end
    object EditPartDosCnt: TEdit
      Left = 379
      Height = 33
      Top = 420
      Width = 125
      Alignment = taCenter
      Color = clBtnFace
      OnEnter = EditDisable
      OnExit = EditEnable
      ReadOnly = True
      TabOrder = 12
    end
  end
  object DataSetDriverEhDosPart: TDataSetDriverEh
    ProviderDataSet = ADOQueryDosPart
    Left = 232
    Top = 152
  end
  object MemTableEhDosPart: TMemTableEh
    Filtered = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = DataSetDriverEhDosPart
    Left = 232
    Top = 104
  end
  object DataSourceDosPart: TDataSource
    DataSet = MemTableEhDosPart
    Left = 232
    Top = 56
  end
  object ADOQueryDosPart: TSQLQuery
    PacketRecords = 2147483647
    FieldDefs = <>
    Database = TLDDataModule.ODBCConnection
    Transaction = TLDDataModule.dbSQLTransaction
    Params = <>
    Macros = <>
    Left = 64
    Top = 56
  end
end
