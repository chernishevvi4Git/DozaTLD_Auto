object TLDDataModule: TTLDDataModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  OldCreateOrder = False
  Height = 402
  HorizontalOffset = 802
  VerticalOffset = 164
  Width = 632
  object MemTableEhTLDSettings: TMemTableEh
    Params = <>
    Left = 416
    Top = 224
    object MemTableEhTLDSettingstldid: TStringField
      FieldKind = fkData
      FieldName = 'tldid'
      Index = 0
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhTLDSettingskslevel: TStringField
      FieldKind = fkData
      FieldName = 'kslevel'
      Index = 1
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhTLDSettingsksdelta: TStringField
      FieldKind = fkData
      FieldName = 'ksdelta'
      Index = 2
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhTLDSettingskfilter: TStringField
      FieldKind = fkData
      FieldName = 'kfilter'
      Index = 3
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhTLDSettingskdev: TStringField
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
        object tldid: TMTStringDataFieldEh
          FieldName = 'tldid'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object kslevel: TMTStringDataFieldEh
          FieldName = 'kslevel'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object ksdelta: TMTStringDataFieldEh
          FieldName = 'ksdelta'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object kfilter: TMTStringDataFieldEh
          FieldName = 'kfilter'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object kdev: TMTStringDataFieldEh
          FieldName = 'kdev'
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
        Name = 'kname'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'measval'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'method'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'dettypecomment'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'tempprofile'
        DataType = ftString
        Size = 1500
      end    
      item
        Name = 'detectortype'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'detectortypeid'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    DataDriver = DataSetDriverEh1
    Options = [mtoTextFieldsCaseInsensitive]
    StoreDefs = True
    Left = 413
    Top = 143
    object MemTableEhDetTypedetectortype: TStringField
      FieldKind = fkData
      FieldName = 'detectortype'
      Index = 0
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDetTypetempprofile: TStringField
      DisplayWidth = 20
      FieldKind = fkData
      FieldName = 'tempprofile'
      Index = 1
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 1500
    end
    object MemTableEhDetTypedettypecomment: TStringField
      DisplayWidth = 20
      FieldKind = fkData
      FieldName = 'dettypecomment'
      Index = 2
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
      Index = 3
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      Size = 100
    end
    object MemTableEhDetTypemeasval: TStringField
      FieldKind = fkData
      FieldName = 'measval'
      Index = 4
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhDetTypekname: TStringField
      FieldKind = fkData
      FieldName = 'kname'
      Index = 5
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
  end
  object DataSetDriverEh1: TDataSetDriverEh
    ProviderDataSet = ADOQueryExportDet
    Left = 528
    Top = 143
  end
  object ADOQuery: TSQLQuery
    PacketRecords = 2147483647
    MaxIndexesCount = 4
    FieldDefs = <    
      item
        Name = 'username'
        DataType = ftMemo
        Precision = -1
      end    
      item
        Name = 'usernameid'
        DataType = ftSmallint
        Precision = -1
      end    
      item
        Name = 'userpermission'
        DataType = ftLargeint
        Precision = -1
      end    
      item
        Name = 'userpassword'
        DataType = ftMemo
        Precision = -1
      end>
    Database = ODBCConnection
    Transaction = dbSQLTransaction
    SQL.Strings = (
      'SELECT username, usernameid, userpermission, userpassword FROM tlduser ORDER BY usernameid'
      ''
    )
    RefreshSQL.Strings = (
      ''
    )
    Params = <>
    ParamCheck = False
    Macros = <>
    Left = 56
    Top = 16
  end
  object ADOQueryASIDK: TSQLQuery
    PacketRecords = 2147483647
    MaxIndexesCount = 4
    FieldDefs = <    
      item
        Name = 'measurmentid'
        DataType = ftInteger
        Precision = -1
      end    
      item
        Name = 'detectortype'
        DataType = ftMemo
        Precision = -1
      end    
      item
        Name = 'detectortypeid'
        DataType = ftSmallint
        Precision = -1
      end    
      item
        Name = 'dose'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'err'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'position'
        DataType = ftSmallint
        Precision = -1
      end    
      item
        Name = 'ktv'
        DataType = ftUnknown
        Precision = -1
      end    
      item
        Name = 'tempprofile'
        DataType = ftUnknown
        Precision = -1
      end    
      item
        Name = 'tempprofilewrite'
        DataType = ftUnknown
        Precision = -1
      end    
      item
        Name = 'calcfon'
        DataType = ftUnknown
        Precision = -1
      end    
      item
        Name = 'calcgaus'
        DataType = ftUnknown
        Precision = -1
      end    
      item
        Name = 'coefficient'
        DataType = ftMemo
        Precision = -1
      end    
      item
        Name = 'measurmenttime'
        DataType = ftDateTime
        Precision = -1
      end    
      item
        Name = 'autoprocessing'
        DataType = ftBoolean
        Precision = -1
      end    
      item
        Name = 'status'
        DataType = ftSmallint
        Precision = -1
      end    
      item
        Name = 'bt'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'bx0'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'by0'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'gm1'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'ga1'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'gsl'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'dgm2'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'dga2'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'gsr'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'n1'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'n2'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 's'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'bn1_width'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'bn2'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'bn2_width'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'peakfound'
        DataType = ftBoolean
        Precision = -1
      end    
      item
        Name = 'fonfound'
        DataType = ftBoolean
        Precision = -1
      end    
      item
        Name = 'method'
        DataType = ftMemo
        Precision = -1
      end    
      item
        Name = 'comment'
        DataType = ftMemo
        Precision = -1
      end    
      item
        Name = 'dettypecomment'
        DataType = ftMemo
        Precision = -1
      end    
      item
        Name = 'measval'
        DataType = ftMemo
        Precision = -1
      end    
      item
        Name = 'kname'
        DataType = ftMemo
        Precision = -1
      end    
      item
        Name = 'bn1'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'bxy0'
        DataType = ftFloat
        Precision = -1
      end    
      item
        Name = 'bdy'
        DataType = ftFloat
        Precision = -1
      end>
    Database = ADOConnectionASIDK
    Transaction = dbSQLTransactionASIDK
    SQL.Strings = (
      'select * from tlddetectorres'
      ''
    )
    Params = <>
    Macros = <>
    Left = 56
    Top = 224
  end
  object ADOQueryExportDet: TSQLQuery
    PacketRecords = 2147483647
    FieldDefs = <>
    Database = ODBCConnection
    Transaction = dbSQLTransaction
    Params = <>
    ParamCheck = False
    Macros = <>
    Left = 528
    Top = 16
  end
  object dbSQLTransaction: TSQLTransaction
    Active = False
    Action = caCommitRetaining
    Database = ODBCConnection
    Left = 264
    Top = 64
  end
  object ADOConnectionASIDK: TSQLConnector
    Connected = False
    LoginPrompt = False
    DatabaseName = 'work'
    KeepConnection = False
    Password = '2236'
    Transaction = dbSQLTransactionASIDK
    UserName = 'postgres'
    HostName = 'localhost'
    ConnectorType = 'PostgreSQL'
    Left = 56
    Top = 176
  end
  object dbSQLTransactionASIDK: TSQLTransaction
    Active = False
    Action = caCommitRetaining
    Database = ADOConnectionASIDK
    Left = 192
    Top = 224
  end
  object ODBCConnection: TPQConnection
    Connected = False
    LoginPrompt = False
    KeepConnection = False
    Transaction = dbSQLTransaction
    Left = 264
    Top = 16
  end
end
