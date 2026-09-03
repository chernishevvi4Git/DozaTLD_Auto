object ImportDosimetersW: TImportDosimetersW
  Left = 1
  Height = 680
  Top = 1
  Width = 1163
  Caption = 'Импорт дозиметров'
  ClientHeight = 680
  ClientWidth = 1163
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 520
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnShow = FormShow
  Position = poMainFormCenter
  object PanelGrid: TPanel
    Left = 0
    Height = 680
    Top = 0
    Width = 1163
    Align = alClient
    ClientHeight = 680
    ClientWidth = 1163
    TabOrder = 0
    object PanelBottom: TPanel
      Left = 1
      Height = 63
      Top = 616
      Width = 1161
      Align = alBottom
      ClientHeight = 63
      ClientWidth = 1161
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      ParentFont = False
      TabOrder = 0
      object BtnImport: TButton
        Left = 956
        Height = 51
        Top = 6
        Width = 201
        Anchors = [akTop, akRight]
        Caption = 'Добавить'
        OnClick = BtnImportClick
        TabOrder = 0
      end
      object BtnClose: TButton
        Left = 5
        Height = 51
        Top = 6
        Width = 201
        Cancel = True
        Caption = 'Закрыть'
        OnClick = BtnCloseClick
        TabOrder = 1
      end
    end
    object PageControlFiles: TPageControl
      Left = 1
      Height = 615
      Top = 1
      Width = 1161
      ActivePage = TabSheetDosList
      Align = alClient
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      ParentFont = False
      TabIndex = 0
      TabOrder = 1
      object TabSheetDosList: TTabSheet
        Caption = ' Список дозиметров '
        ClientHeight = 577
        ClientWidth = 1153
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        ParentFont = False
        object DBGridEhDosID: TDBGridEh
          Left = 0
          Height = 505
          Top = 72
          Width = 1153
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataSource = DataSourceDosID
          DynProps = <>
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          FooterParams.HorzLines = True
          FooterParams.RowHeight = 4
          FooterParams.RowLines = 1
          FooterParams.VertLines = False
          IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
          IndicatorTitle.ShowDropDownSign = True
          IndicatorTitle.TitleButton = True
          IndicatorTitle.UseGlobalMenu = False
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ParentFont = False
          RowDetailPanel.Width = 800
          RowDetailPanel.Height = 259
          SearchPanel.FilterEnabled = False
          SortLocal = True
          STFilter.InstantApply = True
          STFilter.Local = True
          TabOrder = 0
          TitleParams.VertLines = True
          OnActiveGroupingStructChanged = DBGridEhDosIDActiveGroupingStructChanged
          OnKeyPress = DBGridEhDosIDKeyPress
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
        object PanelOpenDosID: TPanel
          Left = 0
          Height = 72
          Top = 0
          Width = 1153
          Align = alTop
          ClientHeight = 72
          ClientWidth = 1153
          ParentBackground = False
          TabOrder = 1
          object LblFileLoadedDosID: TLabel
            Left = 5
            Height = 23
            Top = 4
            Width = 162
            Caption = 'Файл дозиметров:'
            ParentColor = False
          end
          object EditLoadListDosID: TEdit
            Left = 5
            Height = 33
            Top = 33
            Width = 1101
            Anchors = [akTop, akLeft, akRight]
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object BtnOpenDosID: TButton
            Left = 1112
            Height = 34
            Top = 32
            Width = 34
            Anchors = [akTop, akRight]
            Caption = '...'
            OnClick = BtnOpenDosIDClick
            TabOrder = 1
          end
        end
      end
      object TabSheetDosTypeList: TTabSheet
        Caption = ' Список типов дозиметров '
        ClientHeight = 577
        ClientWidth = 1153
        ImageIndex = 1
        object DBGridEhDosType: TDBGridEh
          Left = 0
          Height = 505
          Top = 72
          Width = 1153
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataSource = DataSourceDosType
          DynProps = <>
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          FooterParams.HorzLines = True
          FooterParams.RowHeight = 4
          FooterParams.RowLines = 1
          FooterParams.VertLines = False
          IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
          IndicatorTitle.ShowDropDownSign = True
          IndicatorTitle.TitleButton = True
          IndicatorTitle.UseGlobalMenu = False
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ParentFont = False
          RowDetailPanel.Width = 800
          RowDetailPanel.Height = 259
          SearchPanel.FilterEnabled = False
          SortLocal = True
          STFilter.InstantApply = True
          STFilter.Local = True
          TabOrder = 0
          TitleParams.VertLines = True
          OnKeyPress = DBGridEhDosIDKeyPress
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
        object PanelOpenDosType: TPanel
          Left = 0
          Height = 72
          Top = 0
          Width = 1153
          Align = alTop
          ParentBackground = False
          TabOrder = 1
        end
      end
      object TabSheetDetTypeList: TTabSheet
        Caption = ' Список типов детекторов '
        ClientHeight = 577
        ClientWidth = 1153
        ImageIndex = 2
        object DBGridEhDetType: TDBGridEh
          Left = 0
          Height = 505
          Top = 72
          Width = 1153
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataSource = DataSourceDetType
          DynProps = <>
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          FooterParams.HorzLines = True
          FooterParams.RowHeight = 4
          FooterParams.RowLines = 1
          FooterParams.VertLines = False
          IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
          IndicatorTitle.ShowDropDownSign = True
          IndicatorTitle.TitleButton = True
          IndicatorTitle.UseGlobalMenu = False
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ParentFont = False
          RowDetailPanel.Width = 800
          RowDetailPanel.Height = 259
          SearchPanel.FilterEnabled = False
          SortLocal = True
          STFilter.InstantApply = True
          STFilter.Local = True
          TabOrder = 0
          TitleParams.VertLines = True
          OnKeyPress = DBGridEhDosIDKeyPress
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
        object PanelOpenDetType: TPanel
          Left = 0
          Height = 72
          Top = 0
          Width = 1153
          Align = alTop
          ParentBackground = False
          TabOrder = 1
        end
      end
      object TabSheetDevSettings: TTabSheet
        Caption = ' Настройки установки '
        ClientHeight = 577
        ClientWidth = 1153
        ImageIndex = 3
        object PanelOpenDevSettings: TPanel
          Left = 0
          Height = 72
          Top = 0
          Width = 1153
          Align = alTop
          ParentBackground = False
          TabOrder = 0
        end
        object DBGridEhDevSettings: TDBGridEh
          Left = 0
          Height = 505
          Top = 72
          Width = 1153
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataSource = DataSourceDevSettings
          DynProps = <>
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          FooterParams.HorzLines = True
          FooterParams.RowHeight = 4
          FooterParams.RowLines = 1
          FooterParams.VertLines = False
          IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
          IndicatorTitle.ShowDropDownSign = True
          IndicatorTitle.TitleButton = True
          IndicatorTitle.UseGlobalMenu = False
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ParentFont = False
          RowDetailPanel.Width = 800
          RowDetailPanel.Height = 259
          SearchPanel.FilterEnabled = False
          SortLocal = True
          STFilter.InstantApply = True
          STFilter.Local = True
          TabOrder = 1
          TitleParams.VertLines = True
          OnKeyPress = DBGridEhDosIDKeyPress
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
      object TabSheetMeas: TTabSheet
        Caption = ' Измерения '
        ClientHeight = 577
        ClientWidth = 1153
        ImageIndex = 4
        object DBGridEhMeas: TDBGridEh
          Left = 0
          Height = 258
          Top = 72
          Width = 1153
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataSource = DataSourceMeas
          DynProps = <>
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          FooterParams.HorzLines = True
          FooterParams.RowHeight = 4
          FooterParams.RowLines = 1
          FooterParams.VertLines = False
          IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
          IndicatorTitle.ShowDropDownSign = True
          IndicatorTitle.TitleButton = True
          IndicatorTitle.UseGlobalMenu = False
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ParentFont = False
          RowDetailPanel.Width = 800
          RowDetailPanel.Height = 259
          SearchPanel.FilterEnabled = False
          SortLocal = True
          STFilter.InstantApply = True
          STFilter.Local = True
          TabOrder = 0
          TitleParams.VertLines = True
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
        object PanelOpenMeas: TPanel
          Left = 0
          Height = 72
          Top = 0
          Width = 1153
          Align = alTop
          ParentBackground = False
          TabOrder = 1
        end
        object DBGridEhMeasDet: TDBGridEh
          Left = 0
          Height = 247
          Top = 330
          Width = 1153
          Align = alBottom
          ColumnDefValues.Title.TitleButton = True
          DataSource = DataSourceMeasDet
          DynProps = <>
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          FooterParams.HorzLines = True
          FooterParams.RowHeight = 4
          FooterParams.RowLines = 1
          FooterParams.VertLines = False
          IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
          IndicatorTitle.ShowDropDownSign = True
          IndicatorTitle.TitleButton = True
          IndicatorTitle.UseGlobalMenu = False
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ParentFont = False
          RowDetailPanel.Width = 800
          RowDetailPanel.Height = 259
          SearchPanel.FilterEnabled = False
          SortLocal = True
          STFilter.InstantApply = True
          STFilter.Local = True
          TabOrder = 2
          TitleParams.VertLines = True
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
    end
  end
  object OpenDialogList: TOpenDialog
    DefaultExt = '.csv'
    Filter = 'csv|*.csv'
    Left = 872
    Top = 40
  end
  object DataSourceDosID: TDataSource
    DataSet = MemTableEhDosID
    Left = 73
    Top = 345
  end
  object MemTableEhDosID: TMemTableEh
    Params = <>
    Options = [mtoTextFieldsCaseInsensitive]
    Left = 73
    Top = 401
    object MemTableEhDosIDdosimeterid: TStringField
      FieldKind = fkData
      FieldName = 'dosimeterid'
      Index = 0
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDpostfix: TStringField
      FieldKind = fkData
      FieldName = 'postfix'
      Index = 1
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDdosimetertype: TStringField
      FieldKind = fkData
      FieldName = 'dosimetertype'
      Index = 2
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDk1: TStringField
      FieldKind = fkData
      FieldName = 'k1'
      Index = 3
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDk2: TStringField
      FieldKind = fkData
      FieldName = 'k2'
      Index = 4
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDk3: TStringField
      FieldKind = fkData
      FieldName = 'k3'
      Index = 5
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDk4: TStringField
      FieldKind = fkData
      FieldName = 'k4'
      Index = 6
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDk5: TStringField
      FieldKind = fkData
      FieldName = 'k5'
      Index = 7
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDkgn: TStringField
      FieldKind = fkData
      FieldName = 'kgn'
      Index = 8
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDpartname: TStringField
      FieldKind = fkData
      FieldName = 'partname'
      Index = 9
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDorganization: TStringField
      FieldKind = fkData
      FieldName = 'organization'
      Index = 10
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosIDdepartment: TStringField
      FieldKind = fkData
      FieldName = 'department'
      Index = 11
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object department: TMTStringDataFieldEh
          FieldName = 'department'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 18
        end
        object organization: TMTStringDataFieldEh
          FieldName = 'organization'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 18
        end
        object partname: TMTStringDataFieldEh
          FieldName = 'partname'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 18
        end
        object kgn: TMTStringDataFieldEh
          FieldName = 'kgn'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k5: TMTStringDataFieldEh
          FieldName = 'k5'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k4: TMTStringDataFieldEh
          FieldName = 'k4'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k3: TMTStringDataFieldEh
          FieldName = 'k3'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k2: TMTStringDataFieldEh
          FieldName = 'k2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k1: TMTStringDataFieldEh
          FieldName = 'k1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dosimetertype: TMTStringDataFieldEh
          FieldName = 'dosimetertype'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object postfix: TMTStringDataFieldEh
          FieldName = 'postfix'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 10
        end
        object dosimeterid: TMTStringDataFieldEh
          FieldName = 'dosimeterid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object DataSourceDosType: TDataSource
    DataSet = MemTableEhDosType
    Left = 231
    Top = 345
  end
  object MemTableEhDosType: TMemTableEh
    FieldDefs = <    
      item
        Name = 'formula_err_k2_4'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_err_k1_4'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_err_k2_3'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_err_k1_3'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_err_k2_2'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_err_k1_2'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_err_k2_1'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_err_k1_1'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_id_val_4'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_id_val_3'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_id_val_2'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_id_val_1'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula_id_dos'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'error'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'formula'
        DataType = ftString
        Precision = -1
        Size = 100
      end    
      item
        Name = 'dtype4'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'dtype3'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'dtype2'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'dtype1'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'measuredvalue'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'dosimetertype'
        DataType = ftString
        Precision = -1
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    Options = [mtoTextFieldsCaseInsensitive]
    StoreDefs = True
    Left = 230
    Top = 401
    object MemTableEhDosTypedosimetertype: TStringField
      FieldKind = fkData
      FieldName = 'dosimetertype'
      Index = 0
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypemeasuredvalue: TStringField
      FieldKind = fkData
      FieldName = 'measuredvalue'
      Index = 1
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypedtype1: TStringField
      FieldKind = fkData
      FieldName = 'dtype1'
      Index = 2
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypedtype2: TStringField
      FieldKind = fkData
      FieldName = 'dtype2'
      Index = 3
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypedtype3: TStringField
      FieldKind = fkData
      FieldName = 'dtype3'
      Index = 4
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypedtype4: TStringField
      FieldKind = fkData
      FieldName = 'dtype4'
      Index = 5
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula: TStringField
      FieldKind = fkData
      FieldName = 'formula'
      Index = 6
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 100
    end
    object MemTableEhDosTypeerror: TStringField
      FieldKind = fkData
      FieldName = 'error'
      Index = 7
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_id_dos: TStringField
      FieldKind = fkData
      FieldName = 'formula_id_dos'
      Index = 8
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_id_val_1: TStringField
      FieldKind = fkData
      FieldName = 'formula_id_val_1'
      Index = 9
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_id_val_2: TStringField
      FieldKind = fkData
      FieldName = 'formula_id_val_2'
      Index = 10
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_id_val_3: TStringField
      FieldKind = fkData
      FieldName = 'formula_id_val_3'
      Index = 11
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_id_val_4: TStringField
      FieldKind = fkData
      FieldName = 'formula_id_val_4'
      Index = 12
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_err_k1_1: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k1_1'
      Index = 13
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_err_k2_1: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k2_1'
      Index = 14
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_err_k1_2: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k1_2'
      Index = 15
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_err_k2_2: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k2_2'
      Index = 16
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_err_k1_3: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k1_3'
      Index = 17
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_err_k2_3: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k2_3'
      Index = 18
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_err_k1_4: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k1_4'
      Index = 19
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDosTypeformula_err_k2_4: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k2_4'
      Index = 20
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object formula_err_k2_4: TMTStringDataFieldEh
          FieldName = 'formula_err_k2_4'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k1_4: TMTStringDataFieldEh
          FieldName = 'formula_err_k1_4'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k2_3: TMTStringDataFieldEh
          FieldName = 'formula_err_k2_3'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k1_3: TMTStringDataFieldEh
          FieldName = 'formula_err_k1_3'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k2_2: TMTStringDataFieldEh
          FieldName = 'formula_err_k2_2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k1_2: TMTStringDataFieldEh
          FieldName = 'formula_err_k1_2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k2_1: TMTStringDataFieldEh
          FieldName = 'formula_err_k2_1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k1_1: TMTStringDataFieldEh
          FieldName = 'formula_err_k1_1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_id_val_4: TMTStringDataFieldEh
          FieldName = 'formula_id_val_4'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_id_val_3: TMTStringDataFieldEh
          FieldName = 'formula_id_val_3'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_id_val_2: TMTStringDataFieldEh
          FieldName = 'formula_id_val_2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_id_val_1: TMTStringDataFieldEh
          FieldName = 'formula_id_val_1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_id_dos: TMTStringDataFieldEh
          FieldName = 'formula_id_dos'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object error: TMTStringDataFieldEh
          FieldName = 'error'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula: TMTStringDataFieldEh
          FieldName = 'formula'
          StringDataType = fdtStringEh
          DisplayWidth = 100
        end
        object dtype4: TMTStringDataFieldEh
          FieldName = 'dtype4'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dtype3: TMTStringDataFieldEh
          FieldName = 'dtype3'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dtype2: TMTStringDataFieldEh
          FieldName = 'dtype2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dtype1: TMTStringDataFieldEh
          FieldName = 'dtype1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object measuredvalue: TMTStringDataFieldEh
          FieldName = 'measuredvalue'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dosimetertype: TMTStringDataFieldEh
          FieldName = 'dosimetertype'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object MemTableEhDetType: TMemTableEh
    FieldDefs = <    
      item
        Name = 'k2profile'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'k1profile'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'kname'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'measval'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'method'
        DataType = ftString
        Precision = -1
        Size = 100
      end    
      item
        Name = 'dettypecomment'
        DataType = ftString
        Precision = -1
        Size = 200
      end    
      item
        Name = 'tempprofile'
        DataType = ftString
        Precision = -1
        Size = 3000
      end    
      item
        Name = 'detectortype'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'detectortypeid'
        DataType = ftString
        Precision = -1
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    Options = [mtoTextFieldsCaseInsensitive]
    StoreDefs = True
    Left = 390
    Top = 401
    object MemTableEhDetTypedetectortypeid: TStringField
      FieldKind = fkData
      FieldName = 'detectortypeid'
      Index = 0
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDetTypedetectortype: TStringField
      FieldKind = fkData
      FieldName = 'detectortype'
      Index = 1
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDetTypetempprofile: TStringField
      DisplayWidth = 20
      FieldKind = fkData
      FieldName = 'tempprofile'
      Index = 2
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 3000
    end
    object MemTableEhDetTypedettypecomment: TStringField
      DisplayWidth = 20
      FieldKind = fkData
      FieldName = 'dettypecomment'
      Index = 3
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 200
    end
    object MemTableEhDetTypemethod: TStringField
      DisplayWidth = 20
      FieldKind = fkData
      FieldName = 'method'
      Index = 4
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 100
    end
    object MemTableEhDetTypemeasval: TStringField
      FieldKind = fkData
      FieldName = 'measval'
      Index = 5
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDetTypekname: TStringField
      FieldKind = fkData
      FieldName = 'kname'
      Index = 6
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDetTypek2profile: TStringField
      FieldKind = fkData
      FieldName = 'k2profile'
      Index = 7
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDetTypek1profile: TStringField
      FieldKind = fkData
      FieldName = 'k1profile'
      Index = 8
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object k2profile: TMTStringDataFieldEh
          FieldName = 'k2profile'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k1profile: TMTStringDataFieldEh
          FieldName = 'k1profile'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object kname: TMTStringDataFieldEh
          FieldName = 'kname'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object measval: TMTStringDataFieldEh
          FieldName = 'measval'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object method: TMTStringDataFieldEh
          FieldName = 'method'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 100
        end
        object dettypecomment: TMTStringDataFieldEh
          FieldName = 'dettypecomment'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 200
        end
        object tempprofile: TMTStringDataFieldEh
          FieldName = 'tempprofile'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 3000
        end
        object detectortype: TMTStringDataFieldEh
          FieldName = 'detectortype'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object detectortypeid: TMTStringDataFieldEh
          FieldName = 'detectortypeid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object DataSourceDetType: TDataSource
    DataSet = MemTableEhDetType
    Left = 391
    Top = 345
  end
  object MemTableEhDevSettings: TMemTableEh
    FieldDefs = <    
      item
        Name = 'kdev'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'kfilter'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'ksdelta'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'kslevel'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'tldid'
        DataType = ftString
        Precision = -1
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    Options = [mtoTextFieldsCaseInsensitive]
    StoreDefs = True
    Left = 559
    Top = 396
    object MemTableEhDevSettingstldid: TStringField
      FieldKind = fkData
      FieldName = 'tldid'
      Index = 0
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDevSettingskslevel: TStringField
      FieldKind = fkData
      FieldName = 'kslevel'
      Index = 1
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDevSettingsksdelta: TStringField
      FieldKind = fkData
      FieldName = 'ksdelta'
      Index = 2
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDevSettingskfilter: TStringField
      FieldKind = fkData
      FieldName = 'kfilter'
      Index = 3
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDevSettingskdev: TStringField
      FieldKind = fkData
      FieldName = 'kdev'
      Index = 4
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object kdev: TMTStringDataFieldEh
          FieldName = 'kdev'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object kfilter: TMTStringDataFieldEh
          FieldName = 'kfilter'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object ksdelta: TMTStringDataFieldEh
          FieldName = 'ksdelta'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object kslevel: TMTStringDataFieldEh
          FieldName = 'kslevel'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object tldid: TMTStringDataFieldEh
          FieldName = 'tldid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object DataSourceDevSettings: TDataSource
    DataSet = MemTableEhDevSettings
    Left = 558
    Top = 336
  end
  object DataSourceMeas: TDataSource
    DataSet = MemTableEhMeas
    Left = 718
    Top = 336
  end
  object MemTableEhMeas: TMemTableEh
    FieldDefs = <    
      item
        Name = 'kdev'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'partname'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_err_k2_4'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_err_k1_4'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_err_k2_3'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_err_k1_3'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'to_del'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'd_err'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'h007_err'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'hstar_err'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'hp007_err'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'hp3_err'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'hp10n_err'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'hp10g_err'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_err_k2_2'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_err_k1_2'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_err_k2_1'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_err_k1_1'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_id_val_4'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_id_val_3'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_id_val_2'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_id_val_1'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula_id_dos'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'd'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'h007'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'hstar'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'hp007'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'hp3'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'hp10n'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'hp10g'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'measuredvalue'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'kfilter'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'meascomment'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'lastmeascomment'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'department'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'organization'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'fio'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'personalnumber'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'tlduser'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'softwarever'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'tldid'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'partid'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'kgn'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'k5'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'k4'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'k3'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'k2'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'k1'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'status'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'validity'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'vertime'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'regtime'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'measurmenttime'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'ksi'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'formula'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'dosimetertypeid'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'dosimetertype'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'postfix'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'dosimeterid'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'measurmentid'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    Options = [mtoTextFieldsCaseInsensitive]
    StoreDefs = True
    Left = 719
    Top = 396
    object MemTableEhMeasmeasurmentid: TStringField
      FieldKind = fkData
      FieldName = 'measurmentid'
      Index = 0
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasdosimeterid: TStringField
      FieldKind = fkData
      FieldName = 'dosimeterid'
      Index = 1
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeaspostfix: TStringField
      FieldKind = fkData
      FieldName = 'postfix'
      Index = 2
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasdosimetertype: TStringField
      FieldKind = fkData
      FieldName = 'dosimetertype'
      Index = 3
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasdosimetertypeid: TStringField
      FieldKind = fkData
      FieldName = 'dosimetertypeid'
      Index = 4
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasmeasurmenttime: TStringField
      FieldKind = fkData
      FieldName = 'measurmenttime'
      Index = 5
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula: TStringField
      FieldKind = fkData
      FieldName = 'formula'
      Index = 6
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 100
    end
    object MemTableEhMeasksi: TStringField
      FieldKind = fkData
      FieldName = 'ksi'
      Index = 7
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasregtime: TStringField
      FieldKind = fkData
      FieldName = 'regtime'
      Index = 8
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasvertime: TStringField
      FieldKind = fkData
      FieldName = 'vertime'
      Index = 9
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasvalidity: TStringField
      FieldKind = fkData
      FieldName = 'validity'
      Index = 10
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasstatus: TStringField
      FieldKind = fkData
      FieldName = 'status'
      Index = 11
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeask1: TStringField
      FieldKind = fkData
      FieldName = 'k1'
      Index = 12
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeask2: TStringField
      FieldKind = fkData
      FieldName = 'k2'
      Index = 13
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeask3: TStringField
      FieldKind = fkData
      FieldName = 'k3'
      Index = 14
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeask4: TStringField
      FieldKind = fkData
      FieldName = 'k4'
      Index = 15
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeask5: TStringField
      FieldKind = fkData
      FieldName = 'k5'
      Index = 16
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeaskgn: TStringField
      FieldKind = fkData
      FieldName = 'kgn'
      Index = 17
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeaspartid: TStringField
      FieldKind = fkData
      FieldName = 'partid'
      Index = 18
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeastldid: TStringField
      FieldKind = fkData
      FieldName = 'tldid'
      Index = 19
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeassoftwarever: TStringField
      FieldKind = fkData
      FieldName = 'softwarever'
      Index = 20
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeastlduser: TStringField
      FieldKind = fkData
      FieldName = 'tlduser'
      Index = 21
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeaspersonalnumber: TStringField
      FieldKind = fkData
      FieldName = 'personalnumber'
      Index = 22
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasfio: TStringField
      FieldKind = fkData
      FieldName = 'fio'
      Index = 23
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasorganization: TStringField
      FieldKind = fkData
      FieldName = 'organization'
      Index = 24
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasdepartment: TStringField
      FieldKind = fkData
      FieldName = 'department'
      Index = 25
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeaslastmeascomment: TStringField
      FieldKind = fkData
      FieldName = 'lastmeascomment'
      Index = 26
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasmeascomment: TStringField
      FieldKind = fkData
      FieldName = 'meascomment'
      Index = 27
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeaskfilter: TStringField
      FieldKind = fkData
      FieldName = 'kfilter'
      Index = 28
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasmeasuredvalue: TStringField
      FieldKind = fkData
      FieldName = 'measuredvalue'
      Index = 29
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeashp10g: TStringField
      FieldKind = fkData
      FieldName = 'hp10g'
      Index = 30
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeashp10n: TStringField
      FieldKind = fkData
      FieldName = 'hp10n'
      Index = 31
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeashp3: TStringField
      FieldKind = fkData
      FieldName = 'hp3'
      Index = 32
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeashp007: TStringField
      FieldKind = fkData
      FieldName = 'hp007'
      Index = 33
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeash007: TStringField
      FieldKind = fkData
      FieldName = 'h007'
      Index = 34
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeashstar: TStringField
      FieldKind = fkData
      FieldName = 'hstar'
      Index = 35
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasd: TStringField
      FieldKind = fkData
      FieldName = 'd'
      Index = 36
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeashp10g_err: TStringField
      FieldKind = fkData
      FieldName = 'hp10g_err'
      Index = 37
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeashp10n_err: TStringField
      FieldKind = fkData
      FieldName = 'hp10n_err'
      Index = 38
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeashp3_err: TStringField
      FieldKind = fkData
      FieldName = 'hp3_err'
      Index = 39
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeashp007_err: TStringField
      FieldKind = fkData
      FieldName = 'hp007_err'
      Index = 40
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeash007_err: TStringField
      FieldKind = fkData
      FieldName = 'h007_err'
      Index = 41
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeashstar_err: TStringField
      FieldKind = fkData
      FieldName = 'hstar_err'
      Index = 42
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasd_err: TStringField
      FieldKind = fkData
      FieldName = 'd_err'
      Index = 43
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_id_dos: TStringField
      FieldKind = fkData
      FieldName = 'formula_id_dos'
      Index = 44
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_id_val_1: TStringField
      FieldKind = fkData
      FieldName = 'formula_id_val_1'
      Index = 45
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_id_val_2: TStringField
      FieldKind = fkData
      FieldName = 'formula_id_val_2'
      Index = 46
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_id_val_3: TStringField
      FieldKind = fkData
      FieldName = 'formula_id_val_3'
      Index = 47
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_id_val_4: TStringField
      FieldKind = fkData
      FieldName = 'formula_id_val_4'
      Index = 48
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_err_k1_1: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k1_1'
      Index = 49
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_err_k2_1: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k2_1'
      Index = 50
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_err_k1_2: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k1_2'
      Index = 51
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_err_k2_2: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k2_2'
      Index = 52
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_err_k1_3: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k1_3'
      Index = 53
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_err_k2_3: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k2_3'
      Index = 54
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_err_k1_4: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k1_4'
      Index = 55
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasformula_err_k2_4: TStringField
      FieldKind = fkData
      FieldName = 'formula_err_k2_4'
      Index = 56
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeaspartname: TStringField
      FieldKind = fkData
      FieldName = 'partname'
      Index = 57
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeaskdev: TStringField
      FieldKind = fkData
      FieldName = 'kdev'
      Index = 58
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasto_del: TStringField
      FieldKind = fkData
      FieldName = 'to_del'
      Index = 59
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object kdev: TMTStringDataFieldEh
          FieldName = 'kdev'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object partname: TMTStringDataFieldEh
          FieldName = 'partname'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k2_4: TMTStringDataFieldEh
          FieldName = 'formula_err_k2_4'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k1_4: TMTStringDataFieldEh
          FieldName = 'formula_err_k1_4'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k2_3: TMTStringDataFieldEh
          FieldName = 'formula_err_k2_3'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k1_3: TMTStringDataFieldEh
          FieldName = 'formula_err_k1_3'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object to_del: TMTStringDataFieldEh
          FieldName = 'to_del'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object d_err: TMTStringDataFieldEh
          FieldName = 'd_err'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object h007_err: TMTStringDataFieldEh
          FieldName = 'h007_err'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hstar_err: TMTStringDataFieldEh
          FieldName = 'hstar_err'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hp007_err: TMTStringDataFieldEh
          FieldName = 'hp007_err'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hp3_err: TMTStringDataFieldEh
          FieldName = 'hp3_err'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hp10n_err: TMTStringDataFieldEh
          FieldName = 'hp10n_err'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hp10g_err: TMTStringDataFieldEh
          FieldName = 'hp10g_err'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k2_2: TMTStringDataFieldEh
          FieldName = 'formula_err_k2_2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k1_2: TMTStringDataFieldEh
          FieldName = 'formula_err_k1_2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k2_1: TMTStringDataFieldEh
          FieldName = 'formula_err_k2_1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_err_k1_1: TMTStringDataFieldEh
          FieldName = 'formula_err_k1_1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_id_val_4: TMTStringDataFieldEh
          FieldName = 'formula_id_val_4'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_id_val_3: TMTStringDataFieldEh
          FieldName = 'formula_id_val_3'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_id_val_2: TMTStringDataFieldEh
          FieldName = 'formula_id_val_2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_id_val_1: TMTStringDataFieldEh
          FieldName = 'formula_id_val_1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula_id_dos: TMTStringDataFieldEh
          FieldName = 'formula_id_dos'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object d: TMTStringDataFieldEh
          FieldName = 'd'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object h007: TMTStringDataFieldEh
          FieldName = 'h007'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hstar: TMTStringDataFieldEh
          FieldName = 'hstar'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hp007: TMTStringDataFieldEh
          FieldName = 'hp007'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hp3: TMTStringDataFieldEh
          FieldName = 'hp3'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hp10n: TMTStringDataFieldEh
          FieldName = 'hp10n'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object hp10g: TMTStringDataFieldEh
          FieldName = 'hp10g'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object measuredvalue: TMTStringDataFieldEh
          FieldName = 'measuredvalue'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object kfilter: TMTStringDataFieldEh
          FieldName = 'kfilter'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object meascomment: TMTStringDataFieldEh
          FieldName = 'meascomment'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object lastmeascomment: TMTStringDataFieldEh
          FieldName = 'lastmeascomment'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object department: TMTStringDataFieldEh
          FieldName = 'department'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object organization: TMTStringDataFieldEh
          FieldName = 'organization'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object fio: TMTStringDataFieldEh
          FieldName = 'fio'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object personalnumber: TMTStringDataFieldEh
          FieldName = 'personalnumber'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object tlduser: TMTStringDataFieldEh
          FieldName = 'tlduser'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object softwarever: TMTStringDataFieldEh
          FieldName = 'softwarever'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object tldid: TMTStringDataFieldEh
          FieldName = 'tldid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object partid: TMTStringDataFieldEh
          FieldName = 'partid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object kgn: TMTStringDataFieldEh
          FieldName = 'kgn'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k5: TMTStringDataFieldEh
          FieldName = 'k5'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k4: TMTStringDataFieldEh
          FieldName = 'k4'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k3: TMTStringDataFieldEh
          FieldName = 'k3'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k2: TMTStringDataFieldEh
          FieldName = 'k2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object k1: TMTStringDataFieldEh
          FieldName = 'k1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object status: TMTStringDataFieldEh
          FieldName = 'status'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object validity: TMTStringDataFieldEh
          FieldName = 'validity'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object vertime: TMTStringDataFieldEh
          FieldName = 'vertime'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object regtime: TMTStringDataFieldEh
          FieldName = 'regtime'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object measurmenttime: TMTStringDataFieldEh
          FieldName = 'measurmenttime'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object ksi: TMTStringDataFieldEh
          FieldName = 'ksi'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object formula: TMTStringDataFieldEh
          FieldName = 'formula'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 100
        end
        object dosimetertypeid: TMTStringDataFieldEh
          FieldName = 'dosimetertypeid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dosimetertype: TMTStringDataFieldEh
          FieldName = 'dosimetertype'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object postfix: TMTStringDataFieldEh
          FieldName = 'postfix'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dosimeterid: TMTStringDataFieldEh
          FieldName = 'dosimeterid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object measurmentid: TMTStringDataFieldEh
          FieldName = 'measurmentid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object DataSourceMeasDet: TDataSource
    DataSet = MemTableEhMeasDet
    Left = 876
    Top = 336
  end
  object MemTableEhMeasDet: TMemTableEh
    FieldDefs = <    
      item
        Name = 'k2profile'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'k1profile'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'measurmentid'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'detectortype'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'dose'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'err'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'position'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'ktv'
        DataType = ftString
        Precision = -1
        Size = 3000
      end    
      item
        Name = 'tempprofile'
        DataType = ftString
        Precision = -1
        Size = 3000
      end    
      item
        Name = 'calcfon'
        DataType = ftString
        Precision = -1
        Size = 10000
      end    
      item
        Name = 'calcgaus'
        DataType = ftString
        Precision = -1
        Size = 10000
      end    
      item
        Name = 'coefficient'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'measurmenttime'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'autoprocessing'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'status'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'comment'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'bt'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'bx0'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'by0'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'gm1'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'ga1'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'gsl'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'dgm2'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'dga2'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'gsr'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'n1'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'n2'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 's'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'peakfound'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'fonfound'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'tempprofilewrite'
        DataType = ftString
        Precision = -1
        Size = 3000
      end    
      item
        Name = 'method'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'dettypecomment'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'detectortypeid'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'measval'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'kname'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'bn1_width'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'bn2'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'bn2_width'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'bn1'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'bxy0'
        DataType = ftString
        Precision = -1
        Size = 20
      end    
      item
        Name = 'bdy'
        DataType = ftString
        Precision = -1
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    Options = [mtoTextFieldsCaseInsensitive]
    StoreDefs = True
    Left = 877
    Top = 396
    object MemTableEhMeasDetmeasurmentid: TStringField
      FieldKind = fkData
      FieldName = 'measurmentid'
      Index = 0
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetdetectortype: TStringField
      FieldKind = fkData
      FieldName = 'detectortype'
      Index = 1
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetdetectortypeid: TStringField
      FieldKind = fkData
      FieldName = 'detectortypeid'
      Index = 2
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetdose: TStringField
      FieldKind = fkData
      FieldName = 'dose'
      Index = 3
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDeterr: TStringField
      FieldKind = fkData
      FieldName = 'err'
      Index = 4
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetposition: TStringField
      FieldKind = fkData
      FieldName = 'position'
      Index = 5
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetktv: TStringField
      FieldKind = fkData
      FieldName = 'ktv'
      Index = 6
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 3000
    end
    object MemTableEhMeasDettempprofile: TStringField
      FieldKind = fkData
      FieldName = 'tempprofile'
      Index = 7
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 3000
    end
    object MemTableEhMeasDettempprofilewrite: TStringField
      FieldKind = fkData
      FieldName = 'tempprofilewrite'
      Index = 8
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 3000
    end
    object MemTableEhMeasDetcalcfon: TStringField
      FieldKind = fkData
      FieldName = 'calcfon'
      Index = 9
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 10000
    end
    object MemTableEhMeasDetcalcgaus: TStringField
      FieldKind = fkData
      FieldName = 'calcgaus'
      Index = 10
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 10000
    end
    object MemTableEhMeasDetcoefficient: TStringField
      FieldKind = fkData
      FieldName = 'coefficient'
      Index = 11
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetmeasurmenttime: TStringField
      FieldKind = fkData
      FieldName = 'measurmenttime'
      Index = 12
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetautoprocessing: TStringField
      FieldKind = fkData
      FieldName = 'autoprocessing'
      Index = 13
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetstatus: TStringField
      FieldKind = fkData
      FieldName = 'status'
      Index = 14
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetcomment: TStringField
      FieldKind = fkData
      FieldName = 'comment'
      Index = 15
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetbt: TStringField
      FieldKind = fkData
      FieldName = 'bt'
      Index = 16
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetbx0: TStringField
      FieldKind = fkData
      FieldName = 'bx0'
      Index = 17
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetby0: TStringField
      FieldKind = fkData
      FieldName = 'by0'
      Index = 18
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetgm1: TStringField
      FieldKind = fkData
      FieldName = 'gm1'
      Index = 19
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetga1: TStringField
      FieldKind = fkData
      FieldName = 'ga1'
      Index = 20
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetgsl: TStringField
      FieldKind = fkData
      FieldName = 'gsl'
      Index = 21
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetdgm2: TStringField
      FieldKind = fkData
      FieldName = 'dgm2'
      Index = 22
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetdga2: TStringField
      FieldKind = fkData
      FieldName = 'dga2'
      Index = 23
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetgsr: TStringField
      FieldKind = fkData
      FieldName = 'gsr'
      Index = 24
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetn1: TStringField
      FieldKind = fkData
      FieldName = 'n1'
      Index = 25
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetn2: TStringField
      FieldKind = fkData
      FieldName = 'n2'
      Index = 26
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDets: TStringField
      FieldKind = fkData
      FieldName = 's'
      Index = 27
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetpeakfound: TStringField
      FieldKind = fkData
      FieldName = 'peakfound'
      Index = 28
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetfonfound: TStringField
      FieldKind = fkData
      FieldName = 'fonfound'
      Index = 29
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetmethod: TStringField
      FieldKind = fkData
      FieldName = 'method'
      Index = 30
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetdettypecomment: TStringField
      FieldKind = fkData
      FieldName = 'dettypecomment'
      Index = 31
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetmeasval: TStringField
      FieldKind = fkData
      FieldName = 'measval'
      Index = 32
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetkname: TStringField
      FieldKind = fkData
      FieldName = 'kname'
      Index = 33
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetbn1_width: TStringField
      FieldKind = fkData
      FieldName = 'bn1_width'
      Index = 34
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetbn2: TStringField
      FieldKind = fkData
      FieldName = 'bn2'
      Index = 35
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetbn2_width: TStringField
      FieldKind = fkData
      FieldName = 'bn2_width'
      Index = 36
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetbn1: TStringField
      FieldKind = fkData
      FieldName = 'bn1'
      Index = 37
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetbxy0: TStringField
      FieldKind = fkData
      FieldName = 'bxy0'
      Index = 38
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetbdy: TStringField
      FieldKind = fkData
      FieldName = 'bdy'
      Index = 39
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetk2profile: TStringField
      FieldKind = fkData
      FieldName = 'k2profile'
      Index = 40
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhMeasDetk1profile: TStringField
      FieldKind = fkData
      FieldName = 'k1profile'
      Index = 41
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object measurmentid: TMTStringDataFieldEh
          FieldName = 'measurmentid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object detectortype: TMTStringDataFieldEh
          FieldName = 'detectortype'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dose: TMTStringDataFieldEh
          FieldName = 'dose'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object err: TMTStringDataFieldEh
          FieldName = 'err'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object position: TMTStringDataFieldEh
          FieldName = 'position'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object ktv: TMTStringDataFieldEh
          FieldName = 'ktv'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 3000
        end
        object tempprofile: TMTStringDataFieldEh
          FieldName = 'tempprofile'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 3000
        end
        object calcfon: TMTStringDataFieldEh
          FieldName = 'calcfon'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 10000
        end
        object calcgaus: TMTStringDataFieldEh
          FieldName = 'calcgaus'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 10000
        end
        object coefficient: TMTStringDataFieldEh
          FieldName = 'coefficient'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object measurmenttime: TMTStringDataFieldEh
          FieldName = 'measurmenttime'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object autoprocessing: TMTStringDataFieldEh
          FieldName = 'autoprocessing'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object status: TMTStringDataFieldEh
          FieldName = 'status'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object comment: TMTStringDataFieldEh
          FieldName = 'comment'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object bt: TMTStringDataFieldEh
          FieldName = 'bt'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object bx0: TMTStringDataFieldEh
          FieldName = 'bx0'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object by0: TMTStringDataFieldEh
          FieldName = 'by0'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object gm1: TMTStringDataFieldEh
          FieldName = 'gm1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object ga1: TMTStringDataFieldEh
          FieldName = 'ga1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object gsl: TMTStringDataFieldEh
          FieldName = 'gsl'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dgm2: TMTStringDataFieldEh
          FieldName = 'dgm2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dga2: TMTStringDataFieldEh
          FieldName = 'dga2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object gsr: TMTStringDataFieldEh
          FieldName = 'gsr'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object n1: TMTStringDataFieldEh
          FieldName = 'n1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object n2: TMTStringDataFieldEh
          FieldName = 'n2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object s: TMTStringDataFieldEh
          FieldName = 's'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object peakfound: TMTStringDataFieldEh
          FieldName = 'peakfound'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object fonfound: TMTStringDataFieldEh
          FieldName = 'fonfound'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object tempprofilewrite: TMTStringDataFieldEh
          FieldName = 'tempprofilewrite'
          StringDataType = fdtStringEh
          DisplayWidth = 20
          Size = 3000
        end
        object method: TMTStringDataFieldEh
          FieldName = 'method'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object dettypecomment: TMTStringDataFieldEh
          FieldName = 'dettypecomment'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object detectortypeid: TMTStringDataFieldEh
          FieldName = 'detectortypeid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object measval: TMTStringDataFieldEh
          FieldName = 'measval'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object kname: TMTStringDataFieldEh
          FieldName = 'kname'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object bn1_width: TMTStringDataFieldEh
          FieldName = 'bn1_width'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object bn2: TMTStringDataFieldEh
          FieldName = 'bn2'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object bn2_width: TMTStringDataFieldEh
          FieldName = 'bn2_width'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object bn1: TMTStringDataFieldEh
          FieldName = 'bn1'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object bxy0: TMTStringDataFieldEh
          FieldName = 'bxy0'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object bdy: TMTStringDataFieldEh
          FieldName = 'bdy'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
end
