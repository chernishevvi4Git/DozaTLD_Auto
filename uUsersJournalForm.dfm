object UJW: TUJW
  Left = 0
  Height = 536
  Top = 0
  Width = 680
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Журнал действий оператора'
  ClientHeight = 536
  ClientWidth = 680
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  LCLVersion = '2.2.4.0'
  Scaled = False
  object UsersJournalDBGrid: TDBGrid
    Left = 0
    Height = 495
    Top = 0
    Width = 681
    Color = clWindow
    Columns = <    
      item
        Title.Caption = 'MESSAGE'
        Width = 410
        FieldName = 'MESSAGE'
      end    
      item
        Title.Caption = 'TIMEBEGIN'
        Width = 238
        FieldName = 'TIMEBEGIN'
      end>
    ReadOnly = True
    TabOrder = 0
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
  end
  object TimeFilterPanel: TPanel
    Left = 0
    Height = 41
    Top = 495
    Width = 681
    ClientHeight = 41
    ClientWidth = 681
    TabOrder = 1
    object AutoSrollSpeedButton: TSpeedButton
      Left = 9
      Height = 27
      Hint = 'Автопрокрутка'
      Top = 9
      Width = 100
      AllowAllUp = True
      Caption = 'Автопрокрутка'
      Down = True
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Times New Roman'
      GroupIndex = 1
      OnClick = AutoSrollSpeedButtonClick
      ShowHint = True
      ParentFont = False
      ParentShowHint = False
    end
    object DateFromLabel: TLabel
      Left = 210
      Height = 16
      Top = 14
      Width = 61
      Caption = 'Date from:'
      Enabled = False
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Times New Roman'
      ParentColor = False
      ParentFont = False
    end
    object DateToLabel: TLabel
      Left = 455
      Height = 16
      Top = 14
      Width = 44
      Caption = 'Date to:'
      Enabled = False
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Times New Roman'
      ParentColor = False
      ParentFont = False
    end
    object DateTimePickerMin: TDateTimePicker
      Left = 277
      Height = 21
      Top = 10
      Width = 81
      CenturyFrom = 1941
      MaxDate = 2958465
      MinDate = -53780
      TabOrder = 0
      Enabled = False
      Color = clBtnFace
      TrailingSeparator = False
      TextForNullDate = 'NULL'
      LeadingZeros = True
      ShowHint = True
      ParentShowHint = False
      Kind = dtkDate
      TimeFormat = tf24
      TimeDisplay = tdHMS
      DateMode = dmComboBox
      Date = 41345
      UseDefaultSeparators = True
      HideDateTimeParts = []
      ParentBiDiMode = False
      MonthNames = 'Long'
      OnChange = DateTimePickerMinChange
    end
    object TimePickerMin: TDateTimePicker
      Left = 380
      Height = 21
      Top = 10
      Width = 67
      CenturyFrom = 1941
      MaxDate = 2958465
      MinDate = -53780
      TabOrder = 1
      Enabled = False
      TrailingSeparator = False
      TextForNullDate = 'NULL'
      LeadingZeros = True
      Kind = dtkTime
      TimeFormat = tf24
      TimeDisplay = tdHMS
      DateMode = dmComboBox
      Date = 41347
      UseDefaultSeparators = True
      HideDateTimeParts = []
      MonthNames = 'Long'
      OnChange = TimePickerMinChange
    end
    object UJWIntervalComboBox: TComboBox
      Left = 116
      Height = 25
      Hint = 'Интервал времени'
      Top = 10
      Width = 81
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Times New Roman'
      ItemHeight = 17
      ItemIndex = 1
      Items.Strings = (
        '10 minutes'
        '1 hour'
        '8 hours'
        '1 day'
        '1 week'
        '1 month'
      )
      OnChange = UJWIntervalComboBoxChange
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Style = csDropDownList
      TabOrder = 2
      Text = '1 hour'
    end
    object TimePickerMax: TDateTimePicker
      Left = 608
      Height = 21
      Top = 10
      Width = 67
      CenturyFrom = 1941
      MaxDate = 2958465
      MinDate = -53780
      TabOrder = 3
      Enabled = False
      TrailingSeparator = False
      TextForNullDate = 'NULL'
      LeadingZeros = True
      Kind = dtkTime
      TimeFormat = tf24
      TimeDisplay = tdHMS
      DateMode = dmComboBox
      Date = 41347
      Time = 0.99998842592322
      UseDefaultSeparators = True
      HideDateTimeParts = []
      MonthNames = 'Long'
      OnChange = TimePickerMaxChange
    end
    object DateTimePickerMax: TDateTimePicker
      Left = 504
      Height = 21
      Top = 10
      Width = 81
      CenturyFrom = 1941
      MaxDate = 2958465
      MinDate = -53780
      TabOrder = 4
      Enabled = False
      TrailingSeparator = False
      TextForNullDate = 'NULL'
      LeadingZeros = True
      ShowHint = True
      ParentShowHint = False
      Kind = dtkDate
      TimeFormat = tf24
      TimeDisplay = tdHMS
      DateMode = dmComboBox
      Date = 41345
      Time = 0.99998842592322
      UseDefaultSeparators = True
      HideDateTimeParts = []
      MonthNames = 'Long'
      OnChange = DateTimePickerMaxChange
    end
  end
  object UsersJournalDataSource: TDataSource
    OnDataChange = UsersJournalDataSourceDataChange
    Left = 376
    Top = 8
  end
end
