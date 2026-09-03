object CalibrationForm: TCalibrationForm
  Left = 0
  Height = 697
  Top = 0
  Width = 522
  BorderStyle = bsDialog
  Caption = 'CalibrationForm'
  ClientHeight = 697
  ClientWidth = 522
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnShow = FormShow
  Position = poMainFormCenter
  LCLVersion = '3.6.0.0'
  object PanelK: TPanel
    Left = 0
    Height = 697
    Top = 0
    Width = 522
    Align = alClient
    ClientHeight = 697
    ClientWidth = 522
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object PanelMainTop: TPanel
      Left = 1
      Height = 45
      Top = 1
      Width = 520
      Align = alTop
      ClientHeight = 45
      ClientWidth = 520
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object LblPartTopK: TLabel
        Left = 1
        Height = 43
        Top = 1
        Width = 518
        Align = alClient
        Alignment = taCenter
        Caption = 'Коэффициенты'
        Layout = tlCenter
        ParentColor = False
      end
    end
    object PanelMainBottom: TPanel
      Left = 1
      Height = 55
      Top = 641
      Width = 520
      Align = alBottom
      ClientHeight = 55
      ClientWidth = 520
      ParentBackground = False
      TabOrder = 1
      object SpeedBtnSaveChanges: TSpeedButton
        Left = 234
        Height = 44
        Top = 6
        Width = 280
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
        TabOrder = 0
        OnClick = BtnCloseClick
      end
    end
    object PanelClient: TPanel
      Left = 1
      Height = 595
      Top = 46
      Width = 520
      Align = alClient
      ClientHeight = 595
      ClientWidth = 520
      ParentBackground = False
      TabOrder = 2
      object LblCalibrDate: TLabel
        Left = 20
        Height = 25
        Top = 551
        Width = 258
        Caption = 'Пересчитать измерения с:'
        ParentColor = False
      end
      object LblDosDataDosType: TLabel
        Left = 22
        Height = 25
        Top = 15
        Width = 152
        Caption = 'Тип дозиметра:'
        ParentColor = False
      end
      object GBoxK: TGroupBox
        Left = 22
        Height = 461
        Top = 68
        Width = 475
        Caption = 'К-дозиметра'
        ClientHeight = 431
        ClientWidth = 471
        ParentBackground = False
        TabOrder = 0
        object PanelClientTop: TPanel
          Left = 0
          Height = 176
          Top = 0
          Width = 471
          Align = alTop
          BevelOuter = bvNone
          ClientHeight = 176
          ClientWidth = 471
          ParentBackground = False
          TabOrder = 0
          object LblDosPartName: TLabel
            Left = 92
            Height = 25
            Top = 46
            Width = 175
            Caption = 'Название партии:'
            ParentColor = False
          end
          object SpeedBtnPartInf: TSpeedButton
            Left = 388
            Height = 33
            Top = 77
            Width = 33
            Caption = 'i'
            OnClick = SpeedBtnPartInfClick
          end
          object ShapeErr: TShape
            Left = 89
            Height = 39
            Top = 74
            Width = 293
            Brush.Style = bsClear
            Pen.Color = clRed
            Visible = False
          end
          object EditPartName: TEdit
            Left = 92
            Height = 33
            Top = 77
            Width = 287
            MaxLength = 18
            TabOrder = 0
            OnChange = EditPartNameChange
          end
          object RadioBtnCreatePart: TRadioButton
            Left = 24
            Height = 29
            Top = 16
            Width = 241
            Caption = 'Сформировать партию'
            Checked = True
            TabOrder = 1
            TabStop = True
            OnClick = RadioBtnCreatePartClick
          end
          object RadioBtnNotCreatePart: TRadioButton
            Left = 24
            Height = 29
            Top = 128
            Width = 260
            Caption = 'Не формировать партию'
            TabOrder = 2
            OnClick = RadioBtnNotCreatePartClick
          end
        end
        object PanelClientK: TPanel
          Left = 0
          Height = 255
          Top = 176
          Width = 471
          Align = alClient
          BevelOuter = bvNone
          ClientHeight = 255
          ClientWidth = 471
          ParentBackground = False
          TabOrder = 1
          object LblK_1: TLabel
            Left = 56
            Height = 25
            Top = 9
            Width = 30
            Caption = 'K1:'
            ParentColor = False
          end
          object LblK_2: TLabel
            Left = 56
            Height = 25
            Top = 59
            Width = 30
            Caption = 'K2:'
            ParentColor = False
          end
          object LblK_3: TLabel
            Left = 57
            Height = 25
            Top = 109
            Width = 30
            Caption = 'K3:'
            ParentColor = False
          end
          object LblK_4: TLabel
            Left = 56
            Height = 25
            Top = 159
            Width = 30
            Caption = 'K4:'
            ParentColor = False
          end
          object LblK_5: TLabel
            Left = 56
            Height = 25
            Top = 209
            Width = 30
            Caption = 'K5:'
            ParentColor = False
          end
          object LblK_gn: TLabel
            Left = 250
            Height = 25
            Top = 9
            Width = 43
            Caption = 'Kgn:'
            ParentColor = False
          end
          object LblDotKgn: TLabel
            Left = 232
            Height = 25
            Top = 9
            Width = 12
            Caption = 'd'
            ParentColor = False
          end
          object LblDotK5: TLabel
            Left = 38
            Height = 25
            Top = 209
            Width = 12
            Caption = 'd'
            ParentColor = False
          end
          object LblDotK4: TLabel
            Left = 38
            Height = 25
            Top = 159
            Width = 12
            Caption = 'd'
            ParentColor = False
          end
          object LblDotK3: TLabel
            Left = 39
            Height = 25
            Top = 109
            Width = 12
            Caption = 'd'
            ParentColor = False
          end
          object LblDotK2: TLabel
            Left = 38
            Height = 25
            Top = 59
            Width = 12
            Caption = 'd'
            ParentColor = False
          end
          object LblDotK1: TLabel
            Left = 38
            Height = 25
            Top = 9
            Width = 12
            Caption = 'd'
            ParentColor = False
          end
          object EditK_1: TEdit
            Left = 92
            Height = 33
            Top = 6
            Width = 122
            TabOrder = 0
          end
          object EditK_2: TEdit
            Left = 92
            Height = 33
            Top = 56
            Width = 122
            TabOrder = 1
          end
          object EditK_3: TEdit
            Left = 92
            Height = 33
            Top = 106
            Width = 122
            TabOrder = 2
          end
          object EditK_4: TEdit
            Left = 92
            Height = 33
            Top = 156
            Width = 122
            TabOrder = 3
          end
          object EditK_5: TEdit
            Left = 92
            Height = 33
            Top = 206
            Width = 122
            TabOrder = 4
          end
          object EditK_gn: TEdit
            Left = 299
            Height = 33
            Top = 6
            Width = 122
            TabOrder = 5
          end
        end
      end
      object DateTimePickerCalibr: TDateTimePicker
        Left = 302
        Height = 33
        Top = 547
        Width = 125
        CenturyFrom = 1941
        MaxDate = 2958465
        MinDate = -53780
        TabOrder = 1
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
      object EditDosDataDosTypeVal: TEdit
        Left = 215
        Height = 33
        Top = 12
        Width = 230
        Alignment = taCenter
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
        OnEnter = EditDisable
        OnExit = EditEnable
      end
    end
  end
end
