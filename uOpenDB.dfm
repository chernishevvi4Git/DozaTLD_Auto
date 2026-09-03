object OpenDB: TOpenDB
  Left = 493
  Height = 464
  Top = 153
  Width = 423
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'База данных'
  ClientHeight = 464
  ClientWidth = 423
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poMainFormCenter
  LCLVersion = '3.6.0.0'
  object PanelDBGrid: TPanel
    Left = 0
    Height = 377
    Top = 0
    Width = 423
    Align = alClient
    ClientHeight = 377
    ClientWidth = 423
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object DBGridEhOpenDB: TDBGridEh
      Left = 1
      Height = 375
      Top = 1
      Width = 421
      Align = alClient
      ColumnDefValues.Title.TitleButton = True
      DataSource = DataSourceOpenDB
      DynProps = <>
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      FooterParams.Font.Color = clBlack
      FooterParams.Font.Height = -13
      FooterParams.Font.Name = 'Tahoma'
      FooterParams.HorzLines = True
      FooterParams.ParentFont = False
      FooterParams.RowHeight = 4
      FooterParams.RowLines = 1
      FooterParams.VertLines = False
      IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
      IndicatorTitle.UseGlobalMenu = False
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentFont = False
      ReadOnly = True
      SortLocal = True
      STFilter.Local = True
      TabOrder = 0
      OnCellClick = DBGridEhOpenDBCellClick
      OnDrawColumnCell = DBGridEhOpenDBDrawColumnCell
      OnKeyUp = DBGridEhOpenDBKeyUp
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Height = 23
    Top = 441
    Width = 423
    Panels = <    
      item
        Width = 190
      end>
  end
  object PanelBtn: TPanel
    Left = 0
    Height = 64
    Top = 377
    Width = 423
    Align = alBottom
    ClientHeight = 64
    ClientWidth = 423
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object BtnRestoreDB: TButton
      Left = 16
      Height = 33
      Top = 16
      Width = 393
      Caption = 'Восстановить БД из резервной копии'
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      ParentFont = False
      TabOrder = 0
      OnClick = BtnRestoreDBClick
    end
  end
  object DataSourceOpenDB: TDataSource
    DataSet = ADOQuery
    Left = 33
    Top = 104
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '.backup'
    Left = 88
    Top = 48
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.backup'
    Left = 32
    Top = 48
  end
  object ADOQuery: TSQLQuery
    FieldDefs = <>
    Params = <>
    Macros = <>
    Left = 112
    Top = 104
  end
end
