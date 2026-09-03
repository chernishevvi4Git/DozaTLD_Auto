object GeneratorForm: TGeneratorForm
  Left = 721
  Height = 478
  Top = 320
  Width = 553
  BorderStyle = bsDialog
  Caption = 'GeneratorForm'
  ClientHeight = 478
  ClientWidth = 553
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  OnShow = FormShow
  LCLVersion = '2.2.4.0'
  object LblMeasCnt: TLabel
    Left = 152
    Height = 13
    Top = 53
    Width = 186
    Caption = 'Количество измерений в дозиметре:'
    ParentColor = False
  end
  object LblTitle: TLabel
    Left = 0
    Height = 32
    Top = 0
    Width = 553
    Align = alTop
    Alignment = taCenter
    Caption = 'Генератор измерений'
    Font.Color = clWindowText
    Font.Height = 32
    Font.Name = 'Tahoma'
    ParentColor = False
    ParentFont = False
  end
  object BtnDataGenerator: TButton
    Left = 152
    Height = 41
    Top = 94
    Width = 249
    Caption = 'Сгенерировать архив измерений'
    OnClick = BtnDataGeneratorClick
    TabOrder = 0
  end
  object EditMeasCnt: TEdit
    Left = 352
    Height = 21
    Top = 50
    Width = 49
    NumbersOnly = True
    OnChange = EditMeasCntChange
    TabOrder = 1
  end
  object ProgressBarGenegator: TProgressBar
    Left = 8
    Height = 17
    Top = 141
    Width = 537
    TabOrder = 2
    Visible = False
  end
  object DBGridEhOpenBDGen: TDBGridEh
    Left = 8
    Height = 300
    Top = 164
    Width = 169
    DataSource = DataSourceOpenBDName
    DynProps = <>
    TabOrder = 3
    OnCellClick = DBGridEhOpenBDGenCellClick
    OnDblClick = DBGridEhOpenBDGenDblClick
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBGridEhDetResGen: TDBGridEh
    Left = 245
    Height = 300
    Top = 164
    Width = 300
    DataSource = DataSourceGen
    DynProps = <>
    TabOrder = 4
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object BtnOpen: TButton
    Left = 183
    Height = 49
    Top = 272
    Width = 56
    Caption = 'Open'
    OnClick = BtnOpenClick
    TabOrder = 5
  end
  object BtnGen: TButton
    Left = 416
    Height = 41
    Top = 94
    Width = 129
    Caption = 'Конвертировать'
    OnClick = BtnGenClick
    TabOrder = 6
  end
  object MemoComment: TMemo
    Left = 416
    Height = 50
    Top = 38
    Width = 129
    TabOrder = 7
  end
  object DataSourceGen: TDataSource
    Left = 456
    Top = 360
  end
  object DataSourceOpenBDName: TDataSource
    Left = 136
    Top = 296
  end
  object ADOConnectionGen: TODBCConnection
    Connected = False
    LoginPrompt = False
    KeepConnection = False
    Left = 60
    Top = 55
  end
  object ADOQueryGen: TSQLQuery
    FieldDefs = <>
    Params = <>
    Macros = <>
    Left = 35
    Top = 129
  end
  object ADOQueryOpenBDName: TSQLQuery
    FieldDefs = <>
    Params = <>
    Macros = <>
    Left = 89
    Top = 130
  end
end
