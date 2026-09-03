object ControlW: TControlW
  Left = 2738
  Height = 768
  Top = 164
  Width = 1170
  BorderStyle = bsDialog
  Caption = 'Управление установкой'
  ClientHeight = 768
  ClientWidth = 1170
  Color = clBtnFace
  Constraints.MinHeight = 768
  Constraints.MinWidth = 1170
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Tahoma'
  KeyPreview = True
  OnActivate = FormActivate
  OnDeactivate = FormDeactivate
  OnDestroy = FormDestroy
  Position = poMainFormCenter
  LCLVersion = '3.6.0.0'
  object PageControl1: TPageControl
    Left = 8
    Height = 586
    Top = 8
    Width = 1154
    ActivePage = TabSheet1
    Style = tsFlatButtons
    TabIndex = 0
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'ШД '
      ClientHeight = 545
      ClientWidth = 1146
      object LblDevNumber2: TLabel
        Left = 568
        Height = 25
        Top = 8
        Width = 71
        Caption = 'Статус:'
        ParentColor = False
      end
      object Edit_Motors_CommonStatus: TEdit
        Left = 648
        Height = 33
        Top = 8
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 0
      end
      object Edit_Motors_ProtocolVersion: TEdit
        Left = 432
        Height = 33
        Top = 8
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 1
      end
      object LblDevNumber1: TLabel
        Left = 328
        Height = 25
        Top = 8
        Width = 98
        Caption = 'Протокол:'
        ParentColor = False
      end
      object Button_Motors_ReadBase: TButton
        Left = 8
        Height = 33
        Top = 8
        Width = 101
        Caption = 'Чтение'
        TabOrder = 2
        OnClick = Button_Motors_ReadBaseClick
      end
      object ValueListEditor_Motors_Statuses: TValueListEditor
        Left = 648
        Height = 264
        Top = 56
        Width = 224
        DefaultColWidth = 50
        FixedCols = 0
        RowCount = 2
        TabOrder = 3
        TitleCaptions.Strings = (
          'ШД'
          'Стат-Сооб'
        )
        ColWidths = (
          50
          170
        )
      end
      object LblDevNumber3: TLabel
        Left = 776
        Height = 25
        Top = 368
        Width = 68
        Caption = 'Входы:'
        ParentColor = False
      end
      object Edit_Motors_Inputs: TEdit
        Left = 880
        Height = 33
        Top = 368
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 4
      end
      object Edit_Motors_Outputs: TEdit
        Left = 880
        Height = 33
        Top = 408
        Width = 120
        NumbersOnly = True
        TabOrder = 5
      end
      object Button_Motors_WriteDigitalOutput: TButton
        Left = 1012
        Height = 33
        Top = 408
        Width = 132
        Caption = 'Установить'
        TabOrder = 6
        OnClick = Button_Motors_WriteDigitalOutputClick
      end
      object LblDevNumber4: TLabel
        Left = 776
        Height = 25
        Top = 408
        Width = 83
        Caption = 'Выходы:'
        ParentColor = False
      end
      object CheckBox_Motors_OP0: TCheckBox
        Left = 11
        Height = 29
        Top = 141
        Width = 487
        Caption = 'OP0 (Начальное положение каретки перед PS1)'
        Enabled = False
        TabOrder = 7
      end
      object CheckBox_Motors_PS1: TCheckBox
        Left = 11
        Height = 29
        Top = 40
        Width = 263
        Caption = 'PS1 (левая точка тракта)'
        Enabled = False
        TabOrder = 8
      end
      object CheckBox_Motors_PS2: TCheckBox
        Left = 11
        Height = 29
        Top = 64
        Width = 275
        Caption = 'PS2 (правая точка тракта)'
        Enabled = False
        TabOrder = 9
      end
      object CheckBox_Motors_OP1: TCheckBox
        Left = 11
        Height = 29
        Top = 166
        Width = 273
        Caption = 'OP1 (Кассетница А внизу)'
        Enabled = False
        TabOrder = 10
      end
      object CheckBox_Motors_OP2: TCheckBox
        Left = 11
        Height = 29
        Top = 192
        Width = 272
        Caption = 'OP2 (Кассетница Б внизу)'
        Enabled = False
        TabOrder = 11
      end
      object CheckBox_Motors_PS3: TCheckBox
        Left = 11
        Height = 29
        Top = 90
        Width = 312
        Caption = 'PS3 (кассетница А в наличии)'
        Enabled = False
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 12
      end
      object CheckBox_Motors_OP3: TCheckBox
        Left = 11
        Height = 29
        Top = 218
        Width = 418
        Caption = 'OP3 (Толкатель - внутреннее состояние)'
        Enabled = False
        TabOrder = 13
      end
      object CheckBox_Motors_PS4: TCheckBox
        Left = 11
        Height = 29
        Top = 115
        Width = 311
        Caption = 'PS4 (кассетница Б в наличии)'
        Enabled = False
        TabOrder = 14
      end
      object CheckBox_Motors_OP4: TCheckBox
        Left = 11
        Height = 29
        Top = 243
        Width = 371
        Caption = 'OP4 (Заслонка облучателя закрыта)'
        Enabled = False
        TabOrder = 15
      end
      object CheckBox_Motors_OP5: TCheckBox
        Left = 11
        Height = 29
        Top = 269
        Width = 371
        Caption = 'OP5 (Заслонка облучателя открыта)'
        Enabled = False
        TabOrder = 16
      end
      object Button_Motors_PowerLine1Off: TButton
        Left = 344
        Height = 33
        Top = 333
        Width = 132
        Caption = 'Выключить'
        TabOrder = 17
        OnClick = Button_Motors_PowerLine1OffClick
      end
      object Button_Motors_PowerLine1On: TButton
        Left = 208
        Height = 33
        Top = 333
        Width = 132
        Caption = 'Включить'
        TabOrder = 18
        OnClick = Button_Motors_PowerLine1OnClick
      end
      object CheckBox_Motors_PowerLine1: TCheckBox
        Left = 11
        Height = 29
        Top = 333
        Width = 185
        Caption = 'Питание линии 1'
        Enabled = False
        TabOrder = 19
      end
      object CheckBox_Motors_PowerLine2: TCheckBox
        Left = 11
        Height = 29
        Top = 370
        Width = 185
        Caption = 'Питание линии 2'
        Enabled = False
        TabOrder = 20
      end
      object Button_Motors_PowerLine2On: TButton
        Left = 208
        Height = 33
        Top = 370
        Width = 132
        Caption = 'Включить'
        TabOrder = 21
        OnClick = Button_Motors_PowerLine2OnClick
      end
      object Button_Motors_PowerLine2Off: TButton
        Left = 344
        Height = 33
        Top = 370
        Width = 132
        Caption = 'Выключить'
        TabOrder = 22
        OnClick = Button_Motors_PowerLine2OffClick
      end
      object LblMeas1: TLabel
        Left = 8
        Height = 25
        Top = 440
        Width = 65
        Caption = 'ШД №'
        ParentColor = False
      end
      object LblMeas2: TLabel
        Left = 118
        Height = 25
        Top = 440
        Width = 55
        Caption = 'Точка'
        ParentColor = False
      end
      object SE_MotorNumber: TSpinEdit
        Left = 9
        Height = 33
        Top = 470
        Width = 102
        MaxValue = 6
        MinValue = 1
        OnChange = SE_MotorNumberChange
        TabOrder = 23
        Value = 1
      end
      object SE_MotorPoint: TSpinEdit
        Left = 118
        Height = 33
        Top = 470
        Width = 102
        MaxValue = 8
        MinValue = 1
        OnChange = SE_MotorPointChange
        TabOrder = 24
        Value = 1
      end
      object Button_Motors_GoTo: TButton
        Left = 230
        Height = 33
        Top = 470
        Width = 100
        Caption = 'Go'
        TabOrder = 25
        OnClick = Button_Motors_GoToClick
      end
      object Button_Motors_Stop: TButton
        Left = 342
        Height = 33
        Top = 470
        Width = 100
        Caption = 'Stop'
        TabOrder = 26
        OnClick = Button_Motors_StopClick
      end
      object Button_Motors_Init: TButton
        Left = 456
        Height = 33
        Top = 470
        Width = 100
        Caption = 'Init (253)'
        TabOrder = 27
        OnClick = Button_Motors_InitClick
      end
      object ProgressBar_Motors_Go: TProgressBar
        Left = 0
        Height = 20
        Top = 525
        Width = 1146
        Align = alBottom
        TabOrder = 28
      end
      object Label_Motors_Info: TLabel
        Left = 120
        Height = 23
        Top = 504
        Width = 269
        Caption = 'Тракт M0:  Стартовая позиция'
        Enabled = False
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object Button_Motors_Init251: TButton
        Left = 568
        Height = 33
        Top = 470
        Width = 100
        Caption = 'Init (251)'
        TabOrder = 29
        OnClick = Button_Motors_Init251Click
      end
      object Button_Motors_Init252: TButton
        Left = 680
        Height = 33
        Top = 470
        Width = 100
        Caption = 'Init (252)'
        TabOrder = 30
        OnClick = Button_Motors_Init252Click
      end
      object CheckBox_Motors_PS5: TCheckBox
        Left = 11
        Height = 29
        Top = 294
        Width = 382
        Caption = 'PS5 (Фильтродержатель установлен)'
        Enabled = False
        TabOrder = 31
      end
      object ValueListEditor_Motors_Commands: TValueListEditor
        Left = 880
        Height = 264
        Top = 56
        Width = 192
        DefaultColWidth = 80
        FixedCols = 0
        RowCount = 2
        TabOrder = 32
        TitleCaptions.Strings = (
          'ШД'
          'Команда'
        )
        ColWidths = (
          80
          108
        )
      end
      object Button_Motors_ReadParams1: TButton
        Left = 970
        Height = 33
        Top = 8
        Width = 174
        Caption = 'Чтение команд'
        TabOrder = 33
        OnClick = Button_Motors_ReadParams1Click
      end
      object Button_Motors_PowerLine3Off: TButton
        Left = 344
        Height = 33
        Top = 406
        Width = 132
        Caption = 'Выключить'
        TabOrder = 34
        OnClick = Button_Motors_PowerLine3OffClick
      end
      object Button_Motors_PowerLine3On: TButton
        Left = 208
        Height = 33
        Top = 406
        Width = 132
        Caption = 'Включить'
        TabOrder = 35
        OnClick = Button_Motors_PowerLine3OnClick
      end
      object CheckBox_Motors_PowerLine3: TCheckBox
        Left = 11
        Height = 29
        Top = 406
        Width = 185
        Caption = 'Питание линии 3'
        Enabled = False
        TabOrder = 36
      end
      object CheckBox_Motors_IgnoreErrors: TCheckBox
        Left = 815
        Height = 29
        Top = 472
        Width = 234
        Caption = 'Игнорировать ошибки'
        TabOrder = 37
        OnChange = CheckBox_Motors_IgnoreErrorsChange
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Настройка ШД'
      ClientHeight = 545
      ClientWidth = 1146
      object Button_Motors_ReadParams2: TButton
        Left = 8
        Height = 33
        Top = 8
        Width = 216
        Caption = 'Чтение настроек'
        TabOrder = 7
        OnClick = Button_Motors_ReadParams2Click
      end
      object Tabcontrol_Motors_Options: TTabControl
        Left = 451
        Height = 496
        Top = 56
        Width = 400
        OnChange = Tabcontrol_Motors_OptionsChange
        TabIndex = 0
        Tabs.Strings = (
          'ШД1'
          'ШД2'
          'ШД3'
          'ШД4'
          'ШД5'
          'ШД6'
        )
        TabOrder = 8
        object ValueListEditor_Motors_Options: TValueListEditor
          Left = 8
          Height = 368
          Top = 120
          Width = 296
          DefaultColWidth = 100
          FixedCols = 0
          RowCount = 2
          TabOrder = 1
          KeyOptions = [keyEdit, keyAdd]
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goAutoAddRows, goAlwaysShowEditor, goThumbTracking]
          TitleCaptions.Strings = (
            'Параметр'
            'Значение'
          )
          ColWidths = (
            100
            175
          )
        end
        object LblDevNumber45: TLabel
          Left = 8
          Height = 25
          Top = 40
          Width = 190
          Caption = 'Число шагов (макс)'
          ParentColor = False
        end
        object Edit_Motors_Results: TEdit
          Left = 205
          Height = 33
          Top = 40
          Width = 96
          NumbersOnly = True
          TabOrder = 2
        end
        object LblDevNumber46: TLabel
          Left = 8
          Height = 25
          Top = 80
          Width = 184
          Caption = 'Число переменных'
          ParentColor = False
        end
        object Edit_Motors_NumVars: TEdit
          Left = 205
          Height = 33
          Top = 80
          Width = 96
          NumbersOnly = True
          TabOrder = 3
        end
      end
      object Button_Motors_WriteParams4One: TButton
        Left = 875
        Height = 496
        Top = 56
        Width = 101
        Caption = 'Запись'
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 9
        OnClick = Button_Motors_WriteParams4OneClick
      end
      object Button_Motors_WriteParams2EEPROM: TButton
        Left = 928
        Height = 33
        Top = 8
        Width = 216
        Caption = 'Запись в EEPROM'
        TabOrder = 10
        Visible = False
        OnClick = Button_Motors_WriteParams2EEPROMClick
      end
      object LblDevNumber51: TLabel
        Left = 8
        Height = 25
        Top = 376
        Width = 140
        Caption = 'Корр. среднее'
        ParentColor = False
      end
      object Edit_Motors_StatKorrAvg: TEdit
        Left = 200
        Height = 33
        Top = 377
        Width = 104
        NumbersOnly = True
        TabOrder = 6
      end
      object LblDevNumber52: TLabel
        Left = 8
        Height = 25
        Top = 328
        Width = 111
        Caption = 'Корр. макс.'
        ParentColor = False
      end
      object Edit_Motors_StatKorrMax: TEdit
        Left = 200
        Height = 33
        Top = 328
        Width = 104
        NumbersOnly = True
        TabOrder = 5
      end
      object LblDevNumber53: TLabel
        Left = 8
        Height = 25
        Top = 280
        Width = 104
        Caption = 'Корр. мин.'
        ParentColor = False
      end
      object Edit_Motors_StatKorrMin: TEdit
        Left = 200
        Height = 33
        Top = 280
        Width = 104
        NumbersOnly = True
        TabOrder = 4
      end
      object LblDevNumber54: TLabel
        Left = 8
        Height = 25
        Top = 232
        Width = 173
        Caption = 'Из них с ошибкой'
        ParentColor = False
      end
      object Edit_Motors_StatErr: TEdit
        Left = 200
        Height = 33
        Top = 232
        Width = 104
        NumbersOnly = True
        TabOrder = 3
      end
      object LblDevNumber55: TLabel
        Left = 8
        Height = 25
        Top = 184
        Width = 189
        Caption = 'Из них, в исходную'
        ParentColor = False
      end
      object Edit_Motors_StatTo1: TEdit
        Left = 200
        Height = 33
        Top = 184
        Width = 104
        NumbersOnly = True
        TabOrder = 2
      end
      object LblDevNumber56: TLabel
        Left = 8
        Height = 25
        Top = 135
        Width = 162
        Caption = 'Число движений'
        ParentColor = False
      end
      object Edit_Motors_StatMoves: TEdit
        Left = 200
        Height = 33
        Top = 135
        Width = 104
        NumbersOnly = True
        TabOrder = 1
      end
      object Button_Motors_WriteStat: TButton
        Left = 328
        Height = 320
        Top = 88
        Width = 101
        Caption = 'Запись'
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 11
        OnClick = Button_Motors_WriteStatClick
      end
      object LblDevNumber57: TLabel
        Left = 8
        Height = 25
        Top = 88
        Width = 165
        Caption = 'Номер установки'
        ParentColor = False
      end
      object Edit_Motors_DeviceNumber: TEdit
        Left = 200
        Height = 33
        Top = 88
        Width = 104
        NumbersOnly = True
        TabOrder = 0
      end
      object LblDevNumber59: TLabel
        Left = 8
        Height = 25
        Top = 424
        Width = 165
        Caption = 'Счётчик EEPROM'
        ParentColor = False
      end
      object Edit_Motors_EEPROMCounter: TEdit
        Left = 200
        Height = 33
        Top = 425
        Width = 104
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 12
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Нагреватель'
      ClientHeight = 545
      ClientWidth = 1146
      object Button_AirHeat_ReadAll: TButton
        Left = 11
        Height = 33
        Top = 8
        Width = 101
        Caption = 'Чтение'
        TabOrder = 0
        OnClick = Button_AirHeat_ReadAllClick
      end
      object LblDevNumber5: TLabel
        Left = 11
        Height = 25
        Top = 56
        Width = 101
        Caption = 'Давление:'
        Enabled = False
        ParentColor = False
      end
      object Edit_AirHeat_Pressure: TEdit
        Left = 128
        Height = 33
        Top = 56
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 1
      end
      object LblDevNumber6: TLabel
        Left = 11
        Height = 25
        Top = 96
        Width = 186
        Caption = 'Температура 1, °C:'
        ParentColor = False
      end
      object Edit_AirHeat_Temperature1: TEdit
        Left = 208
        Height = 33
        Top = 96
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 2
      end
      object LblDevNumber7: TLabel
        Left = 11
        Height = 25
        Top = 136
        Width = 186
        Caption = 'Температура 2, °C:'
        ParentColor = False
      end
      object Edit_AirHeat_Temperature2: TEdit
        Left = 208
        Height = 33
        Top = 136
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 3
      end
      object LblDevNumber8: TLabel
        Left = 11
        Height = 25
        Top = 176
        Width = 186
        Caption = 'Температура 3, °C:'
        ParentColor = False
      end
      object Edit_AirHeat_Temperature3: TEdit
        Left = 208
        Height = 33
        Top = 176
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 4
      end
      object LblDevNumber9: TLabel
        Left = 11
        Height = 25
        Top = 216
        Width = 186
        Caption = 'Температура 4, °C:'
        ParentColor = False
      end
      object Edit_AirHeat_Temperature4: TEdit
        Left = 208
        Height = 33
        Top = 216
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 5
      end
      object LblDevNumber10: TLabel
        Left = 396
        Height = 25
        Top = 96
        Width = 146
        Caption = 'Поток 1, см3/с:'
        ParentColor = False
      end
      object Edit_AirHeat_Flow1: TEdit
        Left = 552
        Height = 33
        Top = 96
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 6
      end
      object LblDevNumber11: TLabel
        Left = 396
        Height = 25
        Top = 136
        Width = 146
        Caption = 'Поток 2, см3/с:'
        ParentColor = False
      end
      object Edit_AirHeat_Flow2: TEdit
        Left = 552
        Height = 33
        Top = 136
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 7
      end
      object LblDevNumber12: TLabel
        Left = 396
        Height = 25
        Top = 176
        Width = 146
        Caption = 'Поток 3, см3/с:'
        ParentColor = False
      end
      object Edit_AirHeat_Flow3: TEdit
        Left = 552
        Height = 33
        Top = 176
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 8
      end
      object LblDevNumber13: TLabel
        Left = 396
        Height = 25
        Top = 216
        Width = 146
        Caption = 'Поток 4, см3/с:'
        ParentColor = False
      end
      object Edit_AirHeat_Flow4: TEdit
        Left = 552
        Height = 33
        Top = 216
        Width = 120
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 9
      end
      object LblDevAirStatus: TLabel
        Left = 11
        Height = 25
        Top = 280
        Width = 64
        Caption = 'Статус'
        ParentColor = False
      end
      object Edit_AirHeat_Status: TEdit
        Left = 208
        Height = 33
        Top = 280
        Width = 120
        NumbersOnly = True
        TabOrder = 10
      end
      object LblDevAirMode: TLabel
        Left = 11
        Height = 25
        Top = 320
        Width = 63
        Caption = 'Режим'
        ParentColor = False
      end
      object Edit_AirHeat_Mode: TEdit
        Left = 208
        Height = 33
        Top = 320
        Width = 120
        NumbersOnly = True
        TabOrder = 11
      end
      object LblDevNumber16: TLabel
        Left = 142
        Height = 25
        Top = 384
        Width = 161
        Caption = 'Температура, °C'
        ParentColor = False
      end
      object Edit_AirHeat_PreHeatTemp: TEdit
        Left = 142
        Height = 33
        Top = 424
        Width = 120
        NumbersOnly = True
        TabOrder = 12
      end
      object Edit_AirHeat_HeatTemp: TEdit
        Left = 142
        Height = 33
        Top = 464
        Width = 120
        NumbersOnly = True
        TabOrder = 13
      end
      object Edit_AirHeat_HeatRate: TEdit
        Left = 339
        Height = 33
        Top = 464
        Width = 120
        NumbersOnly = True
        TabOrder = 14
      end
      object Edit_AirHeat_HeatTime: TEdit
        Left = 547
        Height = 33
        Top = 464
        Width = 120
        NumbersOnly = True
        TabOrder = 15
      end
      object Edit_AirHeat_PreHeatRate: TEdit
        Left = 339
        Height = 33
        Top = 424
        Width = 120
        NumbersOnly = True
        TabOrder = 16
      end
      object Edit_AirHeat_PreHeatTime: TEdit
        Left = 547
        Height = 33
        Top = 424
        Width = 120
        NumbersOnly = True
        TabOrder = 17
      end
      object LblDevNumber17: TLabel
        Left = 339
        Height = 25
        Top = 384
        Width = 142
        Caption = 'Скорость, °C/с'
        ParentColor = False
      end
      object LblDevNumber18: TLabel
        Left = 11
        Height = 25
        Top = 424
        Width = 115
        Caption = 'Преднагрев'
        ParentColor = False
      end
      object LblDevNumber19: TLabel
        Left = 11
        Height = 25
        Top = 464
        Width = 68
        Caption = 'Нагрев'
        ParentColor = False
      end
      object LblDevNumber20: TLabel
        Left = 547
        Height = 25
        Top = 384
        Width = 83
        Caption = 'Время, с'
        ParentColor = False
      end
      object Button_AirHeat_WriteProfile: TButton
        Left = 696
        Height = 73
        Top = 424
        Width = 101
        Caption = 'Запись'
        TabOrder = 18
        OnClick = Button_AirHeat_WriteProfileClick
      end
      object Button_AirHeat_WriteStatus: TButton
        Left = 360
        Height = 73
        Top = 280
        Width = 101
        Caption = 'Запись'
        TabOrder = 19
        OnClick = Button_AirHeat_WriteStatusClick
      end
      object Button_AirHeat_ReadAll1: TButton
        Left = 488
        Height = 33
        Top = 280
        Width = 101
        Caption = 'Старт'
        TabOrder = 20
        OnClick = Button_AirHeat_ReadAll1Click
      end
      object Button_AirHeat_ReadAll2: TButton
        Left = 488
        Height = 33
        Top = 320
        Width = 101
        Caption = 'Стоп'
        TabOrder = 21
        OnClick = Button_AirHeat_ReadAll2Click
      end
      object CheckBox_AirHeat_OldVersion: TCheckBox
        Left = 872
        Height = 29
        Top = 504
        Width = 227
        Caption = 'Старая версия платы'
        Checked = True
        State = cbChecked
        TabOrder = 22
        OnChange = CheckBox_AirHeat_OldVersionChange
      end
      object LblDevAirError: TLabel
        Left = 752
        Height = 25
        Top = 96
        Width = 116
        Caption = 'Код ошибки'
        ParentColor = False
      end
      object Edit_AirHeat_ErrorCode: TEdit
        Left = 949
        Height = 33
        Top = 96
        Width = 120
        NumbersOnly = True
        TabOrder = 23
      end
      object CheckGroup_AirHeat_Position: TCheckGroup
        Left = 752
        Height = 177
        Top = 136
        Width = 314
        AutoFill = True
        Caption = 'Выбор позиций нагрева'
        ChildSizing.LeftRightSpacing = 6
        ChildSizing.TopBottomSpacing = 6
        ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
        ChildSizing.EnlargeVertical = crsHomogenousChildResize
        ChildSizing.ShrinkHorizontal = crsScaleChilds
        ChildSizing.ShrinkVertical = crsScaleChilds
        ChildSizing.Layout = cclLeftToRightThenTopToBottom
        ChildSizing.ControlsPerLine = 1
        ClientHeight = 147
        ClientWidth = 310
        Enabled = False
        Items.Strings = (
          'Канал 1'
          'Канал 2'
          'Канал 3'
          'Канал 4'
        )
        ParentBackground = False
        TabOrder = 24
        Data = {
          0400000002020202
        }
      end
    end
    object TabSheet3: TTabSheet
      Caption = '[x]Монитор '
      ClientHeight = 545
      ClientWidth = 1146
      TabVisible = False
      object Button_Monitor_ReadAll: TButton
        Left = 10
        Height = 33
        Top = 8
        Width = 101
        Caption = 'Чтение'
        TabOrder = 0
        OnClick = Button_Monitor_ReadAllClick
      end
      object LblDevNumber21: TLabel
        Left = 10
        Height = 25
        Top = 96
        Width = 302
        Caption = 'Текущая температура PMT, °C:'
        ParentColor = False
      end
      object Edit_Monitor_CurrentTemperature: TEdit
        Left = 336
        Height = 33
        Top = 96
        Width = 176
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 1
      end
      object LblDevNumber22: TLabel
        Left = 10
        Height = 25
        Top = 136
        Width = 301
        Caption = 'Целевая температура PMT, °C:'
        ParentColor = False
      end
      object Edit_Monitor_TargetTemperature: TEdit
        Left = 336
        Height = 33
        Top = 136
        Width = 176
        NumbersOnly = True
        TabOrder = 2
      end
      object LblDevNumber23: TLabel
        Left = 10
        Height = 25
        Top = 176
        Width = 248
        Caption = 'Интенсивность RLC 1, %:'
        ParentColor = False
      end
      object Edit_Monitor_RLCIntencity1: TEdit
        Left = 336
        Height = 33
        Top = 176
        Width = 176
        NumbersOnly = True
        TabOrder = 3
      end
      object LblDevNumber24: TLabel
        Left = 10
        Height = 25
        Top = 216
        Width = 248
        Caption = 'Интенсивность RLC 2, %:'
        ParentColor = False
      end
      object Edit_Monitor_RLCIntencity2: TEdit
        Left = 336
        Height = 33
        Top = 216
        Width = 176
        NumbersOnly = True
        TabOrder = 4
      end
      object LblDevNumber25: TLabel
        Left = 10
        Height = 25
        Top = 256
        Width = 248
        Caption = 'Интенсивность RLC 3, %:'
        ParentColor = False
      end
      object Edit_Monitor_RLCIntencity3: TEdit
        Left = 336
        Height = 33
        Top = 256
        Width = 176
        NumbersOnly = True
        TabOrder = 5
      end
      object LblDevNumber26: TLabel
        Left = 7
        Height = 25
        Top = 296
        Width = 248
        Caption = 'Интенсивность RLC 4, %:'
        ParentColor = False
      end
      object Edit_Monitor_RLCIntencity4: TEdit
        Left = 336
        Height = 33
        Top = 296
        Width = 176
        NumbersOnly = True
        TabOrder = 6
      end
      object Button_Monitor_WriteAll: TButton
        Left = 544
        Height = 233
        Top = 96
        Width = 101
        Caption = 'Запись'
        TabOrder = 7
        OnClick = Button_Monitor_WriteAllClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = '[x]ФЭУ '
      ClientHeight = 545
      ClientWidth = 1146
      TabVisible = False
      object Button_PMT_ReadAll: TButton
        Left = 10
        Height = 33
        Top = 8
        Width = 101
        Caption = 'Чтение'
        TabOrder = 0
        OnClick = Button_PMT_ReadAllClick
      end
      object LblDevNumber27: TLabel
        Left = 8
        Height = 25
        Top = 48
        Width = 173
        Caption = 'Counter triggering'
        ParentColor = False
      end
      object Edit_PMTBoard_CounterTriggering: TEdit
        Left = 333
        Height = 33
        Top = 48
        Width = 152
        NumbersOnly = True
        TabOrder = 1
      end
      object LblDevNumber28: TLabel
        Left = 8
        Height = 25
        Top = 88
        Width = 288
        Caption = 'Channel 1 HV Fine Adjustment'
        ParentColor = False
      end
      object Edit_PMTBoard_HVFineAdjustment1: TEdit
        Left = 333
        Height = 33
        Top = 88
        Width = 152
        NumbersOnly = True
        TabOrder = 2
      end
      object LblDevNumber29: TLabel
        Left = 8
        Height = 25
        Top = 128
        Width = 288
        Caption = 'Channel 2 HV Fine Adjustment'
        ParentColor = False
      end
      object Edit_PMTBoard_HVFineAdjustment2: TEdit
        Left = 333
        Height = 33
        Top = 128
        Width = 152
        NumbersOnly = True
        TabOrder = 3
      end
      object Edit_PMTBoard_PreheatTime: TEdit
        Left = 333
        Height = 33
        Top = 168
        Width = 152
        NumbersOnly = True
        TabOrder = 4
      end
      object LblDevNumber30: TLabel
        Left = 8
        Height = 25
        Top = 168
        Width = 125
        Caption = 'Preheat Time'
        ParentColor = False
      end
      object LblDevNumber31: TLabel
        Left = 8
        Height = 25
        Top = 208
        Width = 131
        Caption = 'Measure Time'
        ParentColor = False
      end
      object Edit_PMTBoard_MeasureTime: TEdit
        Left = 333
        Height = 33
        Top = 208
        Width = 152
        NumbersOnly = True
        TabOrder = 5
      end
      object LblDevNumber32: TLabel
        Left = 8
        Height = 25
        Top = 272
        Width = 274
        Caption = 'Channel 1,2 Real-Time Count'
        ParentColor = False
      end
      object Edit_PMTBoard_RealTimeCount1: TEdit
        Left = 333
        Height = 33
        Top = 272
        Width = 227
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 6
      end
      object Edit_PMTBoard_RealTimeCount2: TEdit
        Left = 581
        Height = 33
        Top = 272
        Width = 227
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 7
      end
      object LblDevNumber34: TLabel
        Left = 8
        Height = 25
        Top = 312
        Width = 254
        Caption = 'Channel 1,2 PreHeat Count'
        ParentColor = False
      end
      object Edit_PMTBoard_PreHeatCount1: TEdit
        Left = 333
        Height = 33
        Top = 312
        Width = 227
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 8
      end
      object Edit_PMTBoard_PreHeatCount2: TEdit
        Left = 581
        Height = 33
        Top = 312
        Width = 227
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 9
      end
      object LblDevNumber36: TLabel
        Left = 8
        Height = 25
        Top = 352
        Width = 258
        Caption = 'Channel 1,2 Measure Count'
        ParentColor = False
      end
      object Edit_PMTBoard_MeasureCount1: TEdit
        Left = 333
        Height = 33
        Top = 352
        Width = 227
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 10
      end
      object Edit_PMTBoard_MeasureCount2: TEdit
        Left = 581
        Height = 33
        Top = 352
        Width = 227
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 11
      end
      object LblDevNumber38: TLabel
        Left = 8
        Height = 25
        Top = 392
        Width = 71
        Caption = 'UID 1,2'
        ParentColor = False
      end
      object Edit_PMTBoard_UID1: TEdit
        Left = 333
        Height = 33
        Top = 392
        Width = 152
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 12
      end
      object Edit_PMTBoard_UID2: TEdit
        Left = 504
        Height = 33
        Top = 392
        Width = 152
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 13
      end
      object LblDevNumber39: TLabel
        Left = 8
        Height = 25
        Top = 432
        Width = 273
        Caption = 'Channel 1,2 HV Initial Values'
        ParentColor = False
      end
      object Edit_PMTBoard_HVInitialValue1: TEdit
        Left = 333
        Height = 33
        Top = 432
        Width = 152
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 14
      end
      object Edit_PMTBoard_HVInitialValue2: TEdit
        Left = 504
        Height = 33
        Top = 432
        Width = 152
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 15
      end
      object LblDevNumber40: TLabel
        Left = 8
        Height = 25
        Top = 472
        Width = 37
        Caption = 'CPS'
        ParentColor = False
      end
      object Edit_PMTBoard_CPS: TEdit
        Left = 333
        Height = 33
        Top = 472
        Width = 152
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 16
      end
      object LblDevNumber41: TLabel
        Left = 8
        Height = 25
        Top = 512
        Width = 142
        Caption = 'Device Address'
        ParentColor = False
      end
      object Edit_PMTBoard_DeviceAddress: TEdit
        Left = 333
        Height = 33
        Top = 512
        Width = 152
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 17
      end
      object Button_PMT_WriteAll: TButton
        Left = 512
        Height = 193
        Top = 48
        Width = 120
        Caption = 'Запись'
        TabOrder = 18
        OnClick = Button_PMT_WriteAllClick
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'ФЭУ'
      ClientHeight = 545
      ClientWidth = 1146
      object ChartControl: TChart
        Left = 0
        Height = 263
        Top = 282
        Width = 1146
        AxisList = <        
          item
            Marks.LabelBrush.Style = bsClear
            Minors = <>
            Title.LabelFont.Orientation = 900
            Title.Visible = True
            Title.Caption = 'I(t)'
            Title.LabelBrush.Style = bsClear
          end        
          item
            Grid.Color = 11119017
            Alignment = calBottom
            Marks.LabelBrush.Style = bsClear
            Minors = <>
            Title.LabelBrush.Style = bsClear
          end        
          item
            Grid.Visible = False
            Alignment = calRight
            Marks.LabelFont.Color = clMaroon
            Marks.LabelBrush.Style = bsClear
            Minors = <>
            Title.Alignment = taCenter
            Title.Attachment = maCenter
            Title.LabelFont.Color = clMaroon
            Title.LabelFont.Orientation = 900
            Title.Visible = True
            Title.Caption = 't (℃)'
            Title.LabelBrush.Style = bsClear
          end>
        Foot.Alignment = taLeftJustify
        Foot.Font.Color = 4194432
        Foot.Font.Height = -16
        Foot.Font.Name = 'Verdana'
        Foot.TextFormat = tfHTML
        Foot.Visible = True
        Foot.Wordwrap = True
        Legend.BackgroundBrush.Color = 16646143
        Legend.FixedItemWidth = 215
        Legend.Font.Height = -13
        Legend.Font.Name = 'Verdana'
        Legend.Frame.Color = clHighlight
        Legend.GroupFont.Style = [fsItalic]
        Legend.GroupTitles.Strings = (
          'Исходные данные'
          'Фон'
          'Пик'
          'Расчёт'
          'Температура'
        )
        Title.Font.Color = clBlack
        Title.Font.Height = -16
        Title.Font.Name = 'Tahoma'
        Title.Text.Strings = (
          '<font size = "6" color = #fa8e47>MAIN TITLE</font>'
          '<font size = "4" color = #010101>SECOND TITLE</font>'
          ''
          ''
        )
        Title.TextFormat = tfHTML
        Align = alClient
        Color = clWhite
        object CSeriesInterestRegion: TAreaSeries
          Legend.GroupIndex = 3
          Title = 'Область рассчёта'
          AxisIndexX = 1
          AxisIndexY = 0
          AreaBrush.Color = clMoneyGreen
          AreaLinesPen.Style = psClear
        end
        object CSeriesSRC1: TLineSeries
          Title = 'Точки КТВ канал1'
          LinePen.Color = clNavy
        end
        object CSeriesSRC2: TLineSeries
          Title = 'Точки КТВ канал2'
          LinePen.Color = clMaroon
        end
        object CSeriesGlade1: TLineSeries
          Legend.GroupIndex = 0
          Title = 'Сглаженная КТВ канал 1'
          AxisIndexX = 1
          AxisIndexY = 0
          LinePen.Color = clBlue
          Pointer.Pen.Style = psDot
        end
        object CSeriesGlade2: TLineSeries
          Title = 'Сглаженная КТВ канал 2'
          LinePen.Color = clRed
        end
        object CSeriesTempProfil: TLineSeries
          Legend.GroupIndex = 4
          Title = 'Профиль температур'
          AxisIndexX = 1
          AxisIndexY = 2
          LinePen.Color = clSkyBlue
          LinePen.Width = 4
          Pointer.Pen.Width = 4
        end
      end
      object Panel1: TPanel
        Left = 0
        Height = 282
        Top = 0
        Width = 1146
        Align = alTop
        ClientHeight = 282
        ClientWidth = 1146
        ParentBackground = False
        TabOrder = 1
        object Button_PMTNew_ReadBase: TButton
          Left = 8
          Height = 33
          Top = 8
          Width = 101
          Caption = 'Чтение'
          TabOrder = 0
          OnClick = Button_PMTNew_ReadBaseClick
        end
        object Button_PMTNew_Start: TButton
          Left = 680
          Height = 33
          Top = 208
          Width = 133
          Caption = 'Старт КТВ'
          TabOrder = 1
          OnClick = Button_PMTNew_StartClick
        end
        object LblDevNumber33: TLabel
          Left = 8
          Height = 25
          Top = 49
          Width = 265
          Caption = 'Мгновенное значение КТВ:'
          ParentColor = False
        end
        object Edit_PMTNew_CP1: TEdit
          Left = 328
          Height = 33
          Top = 48
          Width = 120
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 2
        end
        object LblDevNumber35: TLabel
          Left = 352
          Height = 25
          Top = 16
          Width = 74
          Caption = 'канал 1'
          ParentColor = False
        end
        object Edit_PMTNew_CP2: TEdit
          Left = 448
          Height = 33
          Top = 48
          Width = 120
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 3
        end
        object LblDevNumber37: TLabel
          Left = 8
          Height = 25
          Top = 80
          Width = 267
          Caption = 'Номер последнего отсчёта:'
          ParentColor = False
        end
        object Edit_PMTNew_LastNumber1: TEdit
          Left = 328
          Height = 33
          Top = 80
          Width = 120
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 4
        end
        object Edit_PMTNew_LastNumber2: TEdit
          Left = 448
          Height = 33
          Top = 80
          Width = 120
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 5
        end
        object LblDevNumber43: TLabel
          Left = 8
          Height = 25
          Top = 208
          Width = 277
          Caption = 'Длительность измерения, с:'
          ParentColor = False
        end
        object Edit_PMTNew_MeasureTime: TEdit
          Left = 328
          Height = 33
          Top = 208
          Width = 120
          NumbersOnly = True
          TabOrder = 6
        end
        object Button_PMTNew_SetTime: TButton
          Left = 448
          Height = 33
          Top = 208
          Width = 221
          Caption = 'Задать (Старт КТВ)'
          TabOrder = 7
          OnClick = Button_PMTNew_SetTimeClick
        end
        object Button_PMTNew_RereadKTV: TButton
          Left = 876
          Height = 33
          Top = 208
          Width = 268
          Caption = 'Перечитать КТВ'
          TabOrder = 8
          OnClick = Button_PMTNew_RereadKTVClick
        end
        object RadioButton_PMTNew_Car23: TRadioButton
          Left = 968
          Height = 29
          Top = 248
          Width = 157
          Caption = 'Детекторы 2,3'
          Checked = True
          TabOrder = 10
          TabStop = True
        end
        object RadioButton_PMTNew_Car14: TRadioButton
          Left = 792
          Height = 29
          Top = 248
          Width = 157
          Alignment = taLeftJustify
          Caption = 'Детекторы 1,4'
          TabOrder = 9
        end
        object LblDevNumber61: TLabel
          Left = 8
          Height = 25
          Top = 112
          Width = 302
          Caption = 'Текущая температура PMT, °C:'
          ParentColor = False
        end
        object Edit_PMTNew_CurrentTemp_Ch1: TEdit
          Left = 328
          Height = 33
          Top = 112
          Width = 120
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 11
        end
        object Button_Monitor_WriteAll1: TButton
          Left = 448
          Height = 32
          Top = 240
          Width = 221
          Caption = 'Задать'
          TabOrder = 12
          OnClick = Button_Monitor_WriteAll1Click
        end
        object LblDevNumber62: TLabel
          Left = 8
          Height = 25
          Top = 241
          Width = 301
          Caption = 'Целевая температура PMT, °C:'
          ParentColor = False
        end
        object Edit_PMTNew_TargetTemperature: TEdit
          Left = 328
          Height = 33
          Top = 240
          Width = 120
          NumbersOnly = True
          TabOrder = 13
        end
        object LblDevNumber65: TLabel
          Left = 8
          Height = 25
          Top = 176
          Width = 294
          Caption = 'Контроль тока от светодиода:'
          ParentColor = False
        end
        object Edit_PMTNew_DarkCurrent1: TEdit
          Left = 328
          Height = 33
          Top = 144
          Width = 120
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 14
        end
        object Edit_PMTNew_DarkCurrent2: TEdit
          Left = 448
          Height = 33
          Top = 144
          Width = 120
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 15
        end
        object CheckBox_PMTNew_Led1: TCheckBox
          Left = 680
          Height = 29
          Top = 0
          Width = 139
          Caption = 'Светодиод 1'
          Enabled = False
          TabOrder = 16
        end
        object Button_PMTNew_Led1On: TButton
          Left = 876
          Height = 33
          Top = 0
          Width = 132
          Caption = 'Включить'
          TabOrder = 17
          OnClick = Button_PMTNew_Led1OnClick
        end
        object Button_PMTNew_Led1Off: TButton
          Left = 1012
          Height = 33
          Top = 0
          Width = 132
          Caption = 'Выключить'
          TabOrder = 18
          OnClick = Button_PMTNew_Led1OffClick
        end
        object CheckBox_PMTNew_Led2: TCheckBox
          Left = 680
          Height = 29
          Top = 32
          Width = 139
          Caption = 'Светодиод 2'
          Enabled = False
          TabOrder = 19
        end
        object Button_PMTNew_Led2On: TButton
          Left = 876
          Height = 33
          Top = 32
          Width = 132
          Caption = 'Включить'
          TabOrder = 20
          OnClick = Button_PMTNew_Led2OnClick
        end
        object Button_PMTNew_Led2Off: TButton
          Left = 1012
          Height = 33
          Top = 32
          Width = 132
          Caption = 'Выключить'
          TabOrder = 21
          OnClick = Button_PMTNew_Led2OffClick
        end
        object LblDevNumber66: TLabel
          Left = 8
          Height = 25
          Top = 144
          Width = 254
          Caption = 'Контроль темнового тока:'
          ParentColor = False
        end
        object Button_PMTNew_DarkCurrentStart: TButton
          Left = 568
          Height = 33
          Top = 144
          Width = 101
          Caption = 'Запуск'
          TabOrder = 22
          OnClick = Button_PMTNew_DarkCurrentStartClick
        end
        object Edit_PMTNew_LedCurrent1: TEdit
          Left = 328
          Height = 33
          Top = 176
          Width = 120
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 23
        end
        object Edit_PMTNew_LedCurrent2: TEdit
          Left = 448
          Height = 33
          Top = 176
          Width = 120
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 24
        end
        object Button_PMTNew_DarkCurrentStart1: TButton
          Left = 568
          Height = 33
          Top = 176
          Width = 101
          Caption = 'Запуск'
          TabOrder = 25
          OnClick = Button_PMTNew_DarkCurrentStart1Click
        end
        object Edit_PMTNew_CurrentTemp_Ch2: TEdit
          Left = 448
          Height = 33
          Top = 112
          Width = 120
          Enabled = False
          NumbersOnly = True
          ReadOnly = True
          TabOrder = 26
        end
        object CheckBox_PMTNew_Peltier: TCheckBox
          Left = 680
          Height = 29
          Top = 64
          Width = 187
          Caption = 'Элемент Пельтье'
          Enabled = False
          TabOrder = 27
        end
        object Button_PMTNew_PeltierOn: TButton
          Left = 876
          Height = 33
          Top = 64
          Width = 132
          Caption = 'Включить'
          TabOrder = 28
          OnClick = Button_PMTNew_PeltierOnClick
        end
        object Button_PMTNew_PeltierOff: TButton
          Left = 1012
          Height = 33
          Top = 64
          Width = 132
          Caption = 'Выключить'
          TabOrder = 29
          OnClick = Button_PMTNew_PeltierOffClick
        end
        object LblDevNumber63: TLabel
          Left = 472
          Height = 25
          Top = 16
          Width = 74
          Caption = 'канал 2'
          ParentColor = False
        end
        object CheckBox_PMTNew_Measuring: TCheckBox
          Left = 680
          Height = 29
          Top = 96
          Width = 176
          Caption = 'Идёт измерение'
          Enabled = False
          TabOrder = 30
        end
        object Edit_PMTNew_ControlTime: TEdit
          Left = 888
          Height = 33
          Top = 160
          Width = 120
          NumbersOnly = True
          TabOrder = 31
        end
        object LblDevNumber67: TLabel
          Left = 680
          Height = 25
          Top = 160
          Width = 192
          Caption = 'Время контроля, мс'
          ParentColor = False
        end
        object Button_PMTNew_SetCTime: TButton
          Left = 1016
          Height = 32
          Top = 160
          Width = 129
          Caption = 'Задать'
          TabOrder = 32
          OnClick = Button_PMTNew_SetCTimeClick
        end
        object Edit_PMTNew_DevNumber: TEdit
          Left = 888
          Height = 33
          Top = 128
          Width = 120
          NumbersOnly = True
          TabOrder = 33
        end
        object Button_PMTNew_SetDevNumber: TButton
          Left = 1016
          Height = 32
          Top = 128
          Width = 129
          Caption = 'Задать'
          TabOrder = 34
          OnClick = Button_PMTNew_SetDevNumberClick
        end
        object LblDevNumber68: TLabel
          Left = 928
          Height = 25
          Top = 100
          Width = 165
          Caption = 'Номер установки'
          ParentColor = False
        end
        object Button_PMTNew_GetDevNumber: TButton
          Left = 752
          Height = 32
          Top = 129
          Width = 129
          Caption = 'Прочесть'
          TabOrder = 35
          OnClick = Button_PMTNew_GetDevNumberClick
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = ' Сканер '
      ClientHeight = 545
      ClientWidth = 1146
      object Button_ScanBoard_ReadAll: TButton
        Left = 10
        Height = 33
        Top = 8
        Width = 101
        Caption = 'Чтение'
        TabOrder = 0
        OnClick = Button_ScanBoard_ReadAllClick
      end
      object Edit_ScanBoard_BarCodeLength: TEdit
        Left = 8
        Height = 33
        Top = 112
        Width = 80
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 1
      end
      object CheckBox_ScanBoard_Recognised: TCheckBox
        Left = 8
        Height = 29
        Top = 48
        Width = 201
        Caption = 'Штрихкод опознан'
        Enabled = False
        TabOrder = 2
      end
      object CheckBox_ScanBoard_MainChannelStatus: TCheckBox
        Left = 8
        Height = 29
        Top = 76
        Width = 298
        Caption = 'Состояние основного канала'
        Enabled = False
        TabOrder = 3
      end
      object ValueListEditor_ScanBoard_BarCode: TValueListEditor
        Left = 8
        Height = 392
        Top = 152
        Width = 344
        DefaultColWidth = 160
        FixedCols = 0
        RowCount = 2
        TabOrder = 4
        TitleCaptions.Strings = (
          'Байт'
          'Значение'
        )
        ColWidths = (
          160
          163
        )
      end
      object Edit_ScanBoard_BarCode: TEdit
        Left = 104
        Height = 33
        Top = 112
        Width = 248
        Enabled = False
        ReadOnly = True
        TabOrder = 5
      end
      object CheckBox_Scaner_Disable: TCheckBox
        Left = 384
        Height = 29
        Top = 8
        Width = 578
        Caption = 'Превентивно использовать следующий номер дозиметра'
        TabOrder = 6
        OnChange = CheckBox_Scaner_DisableChange
      end
      object Edit_ScanBoard_BarCodeManual: TEdit
        Left = 384
        Height = 33
        Top = 40
        Width = 176
        Enabled = False
        TabOrder = 7
        OnChange = Edit_ScanBoard_BarCodeManualChange
      end
      object CheckBox_Scaner_DisableOnlyOne: TCheckBox
        Left = 576
        Height = 29
        Top = 40
        Width = 179
        Caption = 'Только один раз'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 8
        OnChange = CheckBox_Scaner_DisableChange
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Панель'
      ClientHeight = 545
      ClientWidth = 1146
      object Button_Panel_ReadAll: TButton
        Left = 10
        Height = 33
        Top = 8
        Width = 101
        Caption = 'Чтение'
        TabOrder = 0
        OnClick = Button_Panel_ReadAllClick
      end
      object Button_Panel_Save: TButton
        Left = 384
        Height = 496
        Top = 48
        Width = 101
        Caption = 'Запись'
        TabOrder = 1
        OnClick = Button_Panel_SaveClick
      end
      object ValueListEditor_UserPanel_Data: TValueListEditor
        Left = 8
        Height = 496
        Top = 48
        Width = 344
        DefaultColWidth = 160
        FixedCols = 0
        RowCount = 2
        TabOrder = 2
        TitleFont.Color = clWindowText
        TitleFont.Height = -21
        TitleFont.Name = 'Tahoma'
        TitleCaptions.Strings = (
          'Слово'
          'Значение'
        )
        ColWidths = (
          160
          163
        )
      end
      object LblDevNumber47: TLabel
        Left = 368
        Height = 25
        Top = 8
        Width = 145
        Caption = 'Базовый адрес'
        ParentColor = False
      end
      object Edit_Panel_BaseAdr: TEdit
        Left = 528
        Height = 33
        Top = 8
        Width = 120
        NumbersOnly = True
        TabOrder = 3
        Text = '0'
      end
      object LblDevNumber48: TLabel
        Left = 688
        Height = 25
        Top = 8
        Width = 61
        Caption = 'Длина'
        ParentColor = False
      end
      object Edit_Panel_Length: TEdit
        Left = 848
        Height = 33
        Top = 8
        Width = 120
        NumbersOnly = True
        TabOrder = 4
        Text = '125'
      end
      object CheckBox_Panel_DontUse: TCheckBox
        Left = 122
        Height = 29
        Top = 8
        Width = 182
        Caption = 'Не использовать'
        TabOrder = 5
        OnChange = CheckBox_Panel_DontUseChange
      end
    end
    object TabSheet6: TTabSheet
      Caption = ' Алгоритмы '
      ClientHeight = 545
      ClientWidth = 1146
      object ComboBox_Algorithm_Choose: TComboBox
        Left = 10
        Height = 33
        Top = 48
        Width = 598
        Enabled = False
        ItemHeight = 25
        ItemIndex = 0
        Items.Strings = (
          'Ничего (Nothing)'
          'Инициализация ШД (MotorsInit)'
          'ШД в начальное состояние (MotorsToStart)'
          'Общая инициализация (Initiation)'
          'Ожидание (Idle)'
          'Чтение из ФЭУ (GetMeasure)'
          'Измерение (Measuring)'
          'Отжиг (Burning)'
          'Смена кассет (Swapping)'
          'Выталкивание (PushOut)'
          'Задержка по времени (Delay)'
          'Обработка ошибки (FailBitCar)'
          'Облучение дозиметров (Irradiation)'
          'Калибровка облучателя (CalybrIrrad)'
          'Калибровка дозиметров (CalybrDosimeters)'
        )
        TabOrder = 0
        Text = 'Ничего (Nothing)'
        OnChange = ComboBox_Algorithm_ChooseChange
      end
      object Button_Algorithm_InitMotors: TButton
        Left = 10
        Height = 33
        Top = 144
        Width = 344
        Caption = 'Инициализация MotorsBoard'
        TabOrder = 1
        OnClick = Button_Algorithm_InitMotorsClick
      end
      object Button_Algorithm_Swapping: TButton
        Left = 8
        Height = 33
        Top = 184
        Width = 344
        Caption = 'Перекинуть кассеты'
        TabOrder = 2
        OnClick = Button_Algorithm_SwappingClick
      end
      object CheckBox_Algorithm_UseChooseCB: TCheckBox
        Left = 392
        Height = 29
        Top = 168
        Width = 497
        Caption = 'Ручной выбор алгоритма (по команде NNChoose)'
        TabOrder = 3
        OnChange = CheckBox_Algorithm_UseChooseCBChange
      end
      object Button_Algorithm_ReadAll: TButton
        Left = 10
        Height = 33
        Top = 8
        Width = 101
        Caption = 'Чтение'
        TabOrder = 4
        OnClick = Button_Algorithm_ReadAllClick
      end
      object LblDevNumber44: TLabel
        Left = 10
        Height = 25
        Top = 90
        Width = 211
        Caption = 'Номер текущего шага'
        ParentColor = False
      end
      object Edit_Algorithm_CurrentCmdID: TEdit
        Left = 256
        Height = 33
        Top = 88
        Width = 106
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 5
      end
      object GroupBox1: TGroupBox
        Left = 10
        Height = 258
        Top = 272
        Width = 368
        Caption = 'Контроль связи'
        ClientHeight = 228
        ClientWidth = 364
        ParentBackground = False
        TabOrder = 6
        object CheckBox_Algorithm_ConnectionMotors: TCheckBox
          Left = 16
          Height = 29
          Top = 0
          Width = 52
          Caption = 'ШД'
          Enabled = False
          TabOrder = 0
        end
        object CheckBox_Algorithm_ConnectionAirHeat: TCheckBox
          Left = 16
          Height = 29
          Top = 32
          Width = 141
          Caption = 'Нагреватель'
          Enabled = False
          TabOrder = 1
        end
        object CheckBox_Algorithm_ConnectionMonitor: TCheckBox
          Left = 16
          Height = 29
          Top = 64
          Width = 102
          Caption = 'Монитор'
          Enabled = False
          TabOrder = 2
        end
        object CheckBox_Algorithm_ConnectionPMT: TCheckBox
          Left = 16
          Height = 29
          Top = 96
          Width = 59
          Caption = 'ФЭУ'
          Enabled = False
          TabOrder = 3
        end
        object CheckBox_Algorithm_ConnectionPMTNew: TCheckBox
          Left = 16
          Height = 29
          Top = 128
          Width = 107
          Caption = 'ФЭУ New'
          Enabled = False
          TabOrder = 4
        end
        object CheckBox_Algorithm_ConnectionScaner: TCheckBox
          Left = 16
          Height = 29
          Top = 160
          Width = 87
          Caption = 'Сканер'
          Enabled = False
          TabOrder = 5
        end
        object CheckBox_Algorithm_ConnectionPanel: TCheckBox
          Left = 16
          Height = 29
          Top = 192
          Width = 89
          Caption = 'Панель'
          Enabled = False
          TabOrder = 6
        end
      end
      object SpeedBtnStop: TSpeedButton
        Left = 896
        Height = 44
        Hint = 'Остановить выполнение алгоритмов'
        Top = 40
        Width = 44
        Glyph.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000064000000640000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00000000010000000200000003000000040000000500000005000000050000
          00050000000400000003000000030000000100000001FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000020000
          0004000000070000000C00000010000000120000001100000011000000120000
          001200000012000000100000000D000000090000000500000002FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000003000000080000
          0010000000170000001B00000021000000300B0B0B402525254B2727274E1915
          154704040438000000260000001B00000017000000120000000A000000040000
          0001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000001000000050000000D000000170000
          001E0808083C4D4B4B76949494B1CACAC8D9E4E4E3F0F7F7F7F8F5F5F5F9E0E0
          E0F6CBCAC9E59F9F9DC5636363921E1E1E530000002400000017000000100000
          000700000003FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000002000000060000000F00000017050505336666
          628CC8C7C6E2F3F2F1FFFAF9F8FFF9F9F8FFFBFBFBFFFFFFFFFFFCFCFCFFF1F0
          F0FFE7E6E5FFE1E0DFFFDDDBDAFFC5C3C2F8848281B7242424550000001C0000
          00140000000A00000003FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF000000000100000005000000100000001829292957B2B2B1D3EDEC
          EAFFE9E8E7FFE7E7E6FFECEBEAFFF0F0EFFFF5F5F4FFFCFCFCFFF9F9F9FFEBEB
          EAFFDFDEDDFFD5D4D3FFCECCCBFFC9C7C6FFCCCAC8FFB9B8B6F75A5A58950000
          0029000000140000000A00000003FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00000000040000000D0000001646464670D2D1CEF4E4E3E1FFDDDD
          DBFFE1E0DFFFE3E2E1FFE7E6E5FFECEBEAFFF2F2F1FFFCFCFAFFF8F8F8FFE6E5
          E5FFD9D8D7FFD0CECDFFC8C7C5FFC3C1C0FFBFBDBBFFBDBBB9FFC4C2C0FF7F7F
          7EBE00000032000000110000000800000002FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00000000020000000A000000114444446CD8D7D4FCDBDAD9FFD8D7D6FFDBDA
          D8FFDBDBD9FFDEDEDCFFE3E2E1FFE9E8E7FFF1F0EFFFFBFAFAFFF7F7F7FFE2E1
          E1FFD3D2D1FFC8C6C5FFC1C0BEFFBDBBBAFFBBB9B7FFB9B7B5FFB6B4B2FFC2BF
          BDFF858483C80000002A0000000D0000000500000001FFFFFF00FFFFFF000000
          0001000000060000000C2525254BCECDCCF3D9D8D6FFD4D3D2FFD6D5D3FFD7D6
          D4FFD9D8D6FFDCDBD9FFE0E0DEFFE7E6E5FFEEEEEDFFFAF9F9FFF6F6F6FFE1E0
          DFFFD0CFCDFFC4C3C1FFBDBCBAFFB9B7B5FFB7B5B3FFB6B4B2FFB5B3B1FFB5B3
          B1FFC2C0BEFF737371AF000000140000000900000002FFFFFF00FFFFFF000000
          00020000000A0000001FAAA9A7D0DEDDDAFFD3D2D0FFD3D2D0FFD3D2D0FFD5D4
          D2FFD7D6D4FFDAD9D7FFDFDEDCFFE4E4E2FFEDEDECFFFAFAF9FFF7F7F7FFDEDD
          DCFFCCCAC9FFC0BFBDFFBAB7B6FFB6B4B2FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFB6B4B2FFBFBDBBFF423F3F700000000600000005FFFFFF00000000010000
          00040000000759595978E1E0DEFFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD4D3
          D2FFDCDBDBFFDFDEDDFFE2E1E0FFE6E6E5FFECECECFFF5F5F4FFF3F3F3FFE3E2
          E1FFD6D5D4FFCFCECDFFCBCAC9FFC9C8C7FFC1BFBEFFB4B2B0FFB5B3B1FFB5B3
          B1FFB5B3B1FFBBB9B6FFA1A19FE6060606250000000500000002000000010000
          00050000001BB7B6B4DADAD9D7FFD3D2D0FFD3D2D0FFD3D2D0FFD6D5D3FFC4C3
          C1FF5E5D5FFF605F61FF6C6B6CFF767475FF7E7C7CFF807E7EFF7C7A7AFF7573
          74FF6C6A6BFF626163FF59585AFF4A484CFF737172FFBAB8B6FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFC1BFBDFF5050507F0000000200000003000000020000
          00013E3E3B56DDDCDAFFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD7D6D4FFBFBE
          BDFF3E3C3FFF3F3D3FFF4B494BFF545253FF5B585AFF5D5A5BFF5A5859FF5351
          52FF4A4849FF403D40FF353437FF242326FF5C5B5CFFBCBAB7FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFBBB9B7FF959493D50000001400000003000000030000
          00027B7B7997E0DFDDFFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD7D6D4FFC0BF
          BEFF3D3C3EFF3C3A3DFF464446FF4C4B4DFF514F51FF535152FF514F50FF4B4A
          4CFF454345FF3D3B3EFF353437FF262428FF5E5C5EFFBCBAB8FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFB6B4B2FFB5B3B0FD201C1C3FFFFFFF00000000030000
          000EAAAAA6C9DBDAD8FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD7D6D4FFBFBE
          BDFF373639FF343236FF3D3B3EFF424042FF454345FF464446FF444345FF413F
          42FF3B3A3DFF353437FF2F2E31FF212023FF5B5A5BFFBCBAB8FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFB5B3B1FFC0BEBBFF4848466DFFFFFF00000000020000
          001DBFBEBCE2D7D6D4FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD7D6D4FFBFBE
          BCFF323034FF2D2B2FFF343236FF373639FF3A383BFF3B393CFF3A383BFF3735
          38FF333235FF2F2D30FF29282CFF1C1B20FF59585AFFBCBAB8FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFB5B3B1FFBFBDBBFF67636392FFFFFF00000000010606
          0626C5C4C2F0D6D5D3FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD8D7D4FFBEBD
          BCFF2C2B2FFF262528FF2C2B2EFF2F2D31FF302F33FF313033FF302F32FF2E2D
          30FF2B2A2DFF28272BFF242327FF19181DFF595759FFBCBAB8FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFB5B3B1FFBEBCBAFF7D7B7AA9FFFFFF00FFFFFF002828
          2833D2D0CEF9D4D4D2FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD8D7D4FFBEBD
          BCFF29282CFF201F23FF252428FF27262AFF29272BFF29282BFF28272BFF2726
          2AFF252428FF232125FF212024FF18171BFF595759FFBCBAB8FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFB5B3B1FFBEBCB9FF7F7E7CB2FFFFFF00FFFFFF002727
          2734D3D2D0FAD4D4D2FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD8D7D4FFBEBD
          BCFF28272BFF1D1C20FF212024FF222125FF222125FF232226FF222125FF2221
          25FF212024FF201F23FF201F23FF18171BFF595759FFBCBAB8FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFB5B3B1FFBEBCB9FF7D7C7AA2FFFFFF00FFFFFF001010
          101FC6C5C3F1D6D5D3FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD8D7D4FFBEBD
          BCFF28272BFF1D1C20FF201F23FF201F23FF201F23FF201F23FF201F23FF201F
          23FF201F23FF201F23FF201F23FF18171BFF595759FFBCBAB8FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFB5B3B1FFC0BEBCFF605E5C84FFFFFF00FFFFFF000000
          0006ABAAAACFDAD9D7FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD8D7D4FFBEBD
          BCFF28272BFF1D1C20FF201F23FF201F23FF201F23FF201F23FF201F23FF201F
          23FF201F23FF201F23FF201F23FF18171BFF595759FFBCBAB8FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFB5B3B1FFBFBDBBFF423F3F54FFFFFF00FFFFFF00FFFF
          FF007A787690DFDDDBFFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD8D7D4FFBEBD
          BCFF28272BFF1D1C20FF201F23FF201F23FF201F23FF201F23FF201F23FF201F
          23FF201F23FF201F23FF201F23FF18171BFF595759FFBCBAB8FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFB7B5B3FFAEACAAF11111111EFFFFFF00FFFFFF00FFFF
          FF002B2B2B3BD3D1CFFED5D4D2FFD3D2D0FFD3D2D0FFD3D2D0FFD8D7D4FFBDBC
          BBFF201F23FF141318FF17161BFF17161AFF17161AFF161519FF161519FF1716
          1BFF18171BFF19181CFF19181CFF111014FF555355FFBCBAB8FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFBDBBB9FF858382B0FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00000000029D9C9ABFDCDBD9FFD3D2D0FFD3D2D0FFD3D2D0FFD7D6D3FFC3C2
          C1FF555456FF4D4C4EFF504F51FF525153FF545356FF58575AFF575659FF504F
          52FF4B4A4DFF48474AFF474648FF413F42FF716F70FFBAB8B6FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFBFBCBAFF39393947FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF003838383FD6D4D2FDD5D4D2FFD3D2D0FFD3D2D0FFD3D2D0FFD5D4
          D2FFDBDAD9FFDEDEDCFFE3E2E0FFE9E9E7FFF2F1F0FFFFFFFFFFFDFDFCFFE2E1
          E0FFD0CECCFFC5C3C1FFBFBDBBFFBCBAB8FFB9B7B4FFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFBEBCBAFF939290B700000001FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF008785838FDFDEDCFFD3D2D0FFD4D3D1FFD4D3D1FFD5D4
          D3FFD7D6D5FFDBDAD8FFDFDFDDFFE5E5E3FFEEEDEDFFFAF9F9FFF7F6F6FFDFDE
          DDFFCECDCCFFC3C1C0FFBCBAB9FFB8B6B4FFB6B4B2FFB5B3B1FFB5B3B1FFB5B3
          B1FFB7B5B3FFBEBBBAF125252529FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000009AEAEADBEE0DFDDFFD4D3D2FFD7D6D5FFD8D7
          D5FFD9D8D7FFDDDCDAFFE1E1DFFFE8E7E6FFEFEFEEFFFAF9F9FFF6F6F6FFE1E1
          E0FFD1D0CEFFC6C4C3FFBFBDBBFFBAB9B7FFB8B6B4FFB7B5B3FFB5B3B1FFB5B2
          B0FFCDCBC9FF5555555AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF000D0D0D13BDBBBAC2E3E2E1FFD8D8D6FFDCDC
          DAFFDEDDDCFFE0DFDEFFE4E3E2FFEAE9E8FFF1F0EFFFFBFBFAFFF7F7F7FFE3E2
          E2FFD5D4D3FFCBC9C7FFC4C2C0FFC0BEBCFFBCBBB9FFB8B6B4FFB9B7B5FFD3D2
          D0FF7270706FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000EA8A8A8A6EEEDECFFE1E0
          DFFFE1E0DFFFE6E5E4FFE9E8E7FFEDEDECFFF3F3F2FFFCFCFBFFF9F9F9FFE8E7
          E7FFDBDBDAFFD2D1CFFFCBC9C8FFC4C2C1FFBDBBB9FFCAC8C7FFD2D2D2EE615E
          5E59FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00716E6E61E2E2
          E1DDF6F6F4FFEDEDEBFFECEBEAFFF1F0EFFFF6F6F5FFFDFDFDFFFAFAFAFFECEC
          EBFFE0DFDEFFD4D3D2FFD0CECCFFD6D5D3FFE3E2E1FFB5B4B4B231313129FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF001E1E
          1E118080806DD6D6D6CAF8F8F8FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFA
          FAFFF6F6F5FFF3F3F2FFE3E3E1EDB7B4B4AA53505046FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00000000013939392C7376735F99999988B9B9B99DB9B9B9A1B6B6
          B6978888887B6363634D1D1D1D1AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        }
        OnClick = SpeedBtnStopClick
        ShowHint = True
        ParentShowHint = False
      end
      object Edit_Algorithm_Address: TEdit
        Left = 762
        Height = 33
        Top = 304
        Width = 120
        NumbersOnly = True
        TabOrder = 7
        Text = '0'
      end
      object Edit_Algorithm_Value: TEdit
        Left = 760
        Height = 33
        Top = 344
        Width = 120
        NumbersOnly = True
        TabOrder = 8
        Text = '125'
        OnChange = Edit_Algorithm_ValueChange
      end
      object Button_Algorithm_Read: TButton
        Left = 1029
        Height = 33
        Top = 304
        Width = 101
        Caption = 'Чтение'
        TabOrder = 9
        OnClick = Button_Algorithm_ReadClick
      end
      object Button_Algorithm_Write: TButton
        Left = 1029
        Height = 33
        Top = 344
        Width = 101
        Caption = 'Запись'
        TabOrder = 10
        OnClick = Button_Algorithm_WriteClick
      end
      object ComboBox_Algorithm_Parameter: TComboBox
        Left = 762
        Height = 33
        Top = 264
        Width = 192
        ItemHeight = 25
        ItemIndex = 0
        Items.Strings = (
          'MotorsBoard'
          'AirHeatBoard'
          'PMTNew'
          'Scaner'
          'Panel'
        )
        TabOrder = 11
        Text = 'MotorsBoard'
        OnChange = ComboBox_Algorithm_ChooseChange
      end
      object LblDevNumber49: TLabel
        Left = 650
        Height = 25
        Top = 304
        Width = 58
        Caption = 'Адрес'
        ParentColor = False
      end
      object LblDevNumber50: TLabel
        Left = 650
        Height = 25
        Top = 344
        Width = 91
        Caption = 'Значение'
        ParentColor = False
      end
      object Button_Algorithm_PushOut: TButton
        Left = 40
        Height = 33
        Top = 224
        Width = 344
        Caption = 'Выкинуть кассету в корзину'
        TabOrder = 12
        OnClick = Button_Algorithm_PushOutClick
      end
      object Edit_Algorithm_EventNumber: TEdit
        Left = 762
        Height = 33
        Top = 448
        Width = 120
        NumbersOnly = True
        TabOrder = 13
        Text = '0'
      end
      object LblDevNumber58: TLabel
        Left = 609
        Height = 25
        Top = 448
        Width = 132
        Caption = 'Тест событий'
        ParentColor = False
      end
      object Button_Algorithm_TestEvent: TButton
        Left = 898
        Height = 33
        Top = 448
        Width = 101
        Caption = 'Тест'
        TabOrder = 14
        OnClick = Button_Algorithm_TestEventClick
      end
      object LblDevNumber60: TLabel
        Left = 554
        Height = 25
        Top = 493
        Width = 183
        Caption = 'Сетевой COM-порт'
        ParentColor = False
      end
      object Edit_Algorithm_RemoteCOM_IP: TEdit
        Left = 762
        Height = 33
        Top = 486
        Width = 237
        TabOrder = 15
      end
      object Edit_Algorithm_CurrentCmdString: TEdit
        AnchorSideLeft.Control = Edit_Algorithm_CurrentCmdID
        AnchorSideLeft.Side = asrBottom
        Left = 370
        Height = 33
        Top = 88
        Width = 762
        BorderSpacing.Around = 8
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 16
        Visible = False
      end
      object TGButton_Algorithm_RemoteCOMGo: TToggleBox
        Left = 1013
        Height = 33
        Top = 486
        Width = 117
        Caption = 'Захватить'
        TabOrder = 17
        OnChange = TGButton_Algorithm_RemoteCOMGoChange
      end
      object CheckBox_Algorithm_IsEmulator: TCheckBox
        Left = 944
        Height = 29
        Top = 8
        Width = 180
        Caption = 'Режим эмуляции'
        TabOrder = 18
        OnChange = CheckBox_Algorithm_IsEmulatorChange
      end
      object ComboBox_Algorithm_VarType: TComboBox
        Left = 888
        Height = 33
        Top = 304
        Width = 120
        ItemHeight = 25
        ItemIndex = 0
        Items.Strings = (
          'Byte'
          'Word'
          'WordT'
        )
        TabOrder = 19
        Text = 'Byte'
        OnChange = Edit_Algorithm_ValueChange
      end
      object Edit_Algorithm_HexValue: TEdit
        Left = 888
        Height = 33
        Top = 344
        Width = 120
        Enabled = False
        NumbersOnly = True
        TabOrder = 20
        Text = '125'
      end
      object Button_Algorithm_WriteFile: TButton
        Left = 960
        Height = 33
        Top = 264
        Width = 170
        Caption = 'Запись в файл'
        TabOrder = 21
        OnClick = Button_Algorithm_WriteFileClick
      end
      object BtnGoIdle: TSpeedButton
        Left = 944
        Height = 44
        Top = 40
        Width = 44
        Glyph.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000064000000640000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000010000000100000001000000010000
          000100000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          0001000000020000000400000005000000060000000700000007000000070000
          000700000006000000040000000200000001FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001000000040000
          00070000000C0000001100000013000000130000001200000013000000130000
          001200000013000000110000000D000000080000000400000001FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001000000060000000E0000
          00170000001B0000002A1212124437373761565656766B6B6B825E5E5E7C3C3C
          3C6A1D1D1D4E000000300000001C000000160000001000000008000000030000
          0001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00000000010000000300000009000000140000001C0808
          083E5B5B5986AFAEACCAE0DFDFF1FBFBFBFFFFFFFFFFFFFFFFFFFDFDFDFFEFEE
          EDFFD6D5D3F9ADABABDA6B67679D191919500000001F000000140000000C0000
          000400000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00000000030000000B000000130000002655555583C6C5
          C5E8F2F2F1FFF4F3F2FFF3F2F1FFF5F5F4FFFAFAFAFFFDFDFDFFF2F2F1FFE6E5
          E5FFDDDCDBFFD8D7D6FFD6D5D3FFBDBCBBF76F6E6EA90C0C0C3D000000150000
          000E0000000400000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00000000030000000A000000120D0D0D39989895BFE9E8E6FFE6E5
          E4FFE4E3E2FFE8E7E6FFECECEAFFF1F1F0FFF8F8F8FFFDFDFDFFF0F0EFFFE2E1
          E0FFD6D6D4FFCECDCBFFC7C6C4FFC4C2C0FFC9C7C5FFA5A4A1E62E2E2E630000
          00160000000E0000000500000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF0000000001000000080000000F1414143DB5B4B2D8E5E4E2FFDBDAD8FFDEDD
          DBFFE0DFDDFFE2E2E0FFE7E6E5FFEEEDECFFF6F6F5FFFCFBFCFFECECEBFFDBDA
          D9FFCFCECDFFC7C5C4FFC2C0BEFFBEBCBBFFBAB8B7FFBEBCBAFFB6B4B2FA3D3A
          3A75000000140000000B00000002FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00000000040000000D0505052EAEADACD2E0DFDDFFD6D5D3FFD8D7D5FFD8D8
          D6FFDBDAD8FFE2E1E0FFEBEAE9FFEBEAE9FFF5F5F4FFFCFBFBFFEAE9E9FFD7D6
          D5FFCAC8C7FFC1BFBEFFBCBAB9FFBAB8B6FFB8B6B4FFB6B4B2FFB9B7B5FFB7B5
          B3FC353535680000000C0000000700000001FFFFFF00FFFFFF00FFFFFF000000
          000200000009000000168A8989ADE1E0DEFFD3D2D0FFD5D4D2FFD4D3D2FFD6D5
          D3FFDBDAD9FFCAC9C8FFC4C3C3FFF7F6F5FFF4F4F3FFFBFBFBFFE9E8E7FFD4D3
          D1FFC6C5C3FFBEBCBBFFB9B7B5FFB7B5B3FFB6B4B2FFB5B3B1FFB5B3B1FFBBB9
          B7FFA9A7A5EC1515153C0000000600000003FFFFFF00FFFFFF00FFFFFF000000
          00040000000744414161DEDDDAFFD4D3D1FFD3D2D0FFD3D2D0FFD3D2D0FFD5D4
          D2FFDDDCDAFFB6B5B4FF27262AFF9F9FA0FFFEFDFDFFFFFFFFFFE6E5E4FFD0CE
          CDFFC2C1BFFFBBB9B7FFB7B5B3FFB6B4B1FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFC0BEBCFF7E7D7BB50000000F0000000500000001FFFFFF00000000010000
          000500000016ABAAA7CADCDBD9FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFDBDAD8FFB9B8B7FF1E1D21FF201F23FF858486FFF6F6F6FFEBEAE9FFCBC9
          C8FFBFBDBBFFB8B6B4FFB6B4B2FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFB6B4B2FFBCBAB8FF303030540000000100000002FFFFFF00000000020000
          00013B3B3B51DCDBD9FFD4D3D1FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB7B6B6FF232226FF262529FF343235FF6F6E70FFD4D3D3FFD3D2
          D0FFB9B7B5FFB6B4B2FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFBFBDBBFF7C7B79B00000000700000003FFFFFF00000000030000
          000382828198DFDEDCFFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB6B5B4FF232226FF212024FF353437FF403E40FF5B595BFFB2B0
          B0FFCDCBC9FFB5B3B0FFB4B2B0FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFB8B6B4FFABA9A7EE0C0C0C2800000001FFFFFF00000000030000
          0011B0B0ADCFDAD9D7FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB6B5B4FF232226FF1E1D21FF272629FF363538FF3E3C3EFF4240
          42FF878788FFC9C8C7FFBBB9B7FFB3B1AFFFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFBDBBB9FF3C3C3955FFFFFF0000000001000000020707
          0724C4C3C1ECD7D6D4FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB6B5B4FF232226FF1E1D21FF201F23FF242327FF2C2B2EFF2F2D
          31FF242326FF525053FFBAB9B9FFC4C2C0FFB3B1AFFFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFC0BEBCFF5654547FFFFFFF0000000001FFFFFF002D2D
          2D33D3D2D0F7D4D3D1FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB6B5B4FF232226FF1E1D21FF201F23FF1F1E22FF1F1E22FF201F
          23FF201F23FF161519FF2C2B30FF9C9C9DFFC9C7C5FFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFBFBCBAFF71707096FFFFFF0000000001FFFFFF004B4B
          4B4EDCDBD9FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB6B5B4FF232226FF1E1D21FF201F23FF201F23FF201F23FF201F
          23FF201F23FF201F23FF1B1A1EFF141418FF767577FFBBB9B6FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFBEBCBAFF7D7B7AA5FFFFFF0000000001FFFFFF003131
          3148D9D7D5FFD4D3D1FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB6B5B4FF232226FF1E1D21FF201F23FF201F23FF201F23FF201F
          23FF201F23FF201F23FF16151AFF343336FF8E8C8CFFB8B6B4FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFBEBCBAFF7B79789DFFFFFF00FFFFFF00FFFFFF002626
          2635D3D2D0FDD4D3D1FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB6B5B4FF232226FF1E1D21FF201F23FF201F23FF201F23FF201F
          23FF1E1D21FF17161BFF535253FFAEACAAFFBDBBB9FFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFC0BEBCFF5E5C5C82FFFFFF00FFFFFF00FFFFFF000000
          0015BFBEBCE6D7D6D4FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB6B5B4FF232226FF1E1D21FF201F23FF201F23FF201F23FF1918
          1DFF201F23FF737272FFBBB9B7FFB9B7B5FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFB5B3B1FFBFBDBBFF42424254FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00939290B0DDDCDAFFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB6B5B4FF232226FF1E1D21FF201F23FF1F1E22FF151418FF3433
          37FF969494FFBFBDBAFFB6B4B2FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFB7B5B3FFB2B0AEF11E1E1E22FFFFFF00FFFFFF00FFFFFF00FFFF
          FF004E4B4B5EDCDBD9FFD4D3D1FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFD9D8D6FFB7B6B5FF232226FF1E1D21FF1D1C20FF141317FF5B5A5CFFBCBB
          B9FFC3C1BFFFB6B4B2FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFBCBAB8FF8E8B8AB3FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000000000EB4B1B0DAD9D8D6FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD3D2
          D0FFDADAD8FFB9B8B7FF242327FF161519FF1E1D21FF959597FFEAE9E8FFD1CF
          CEFFBEBCBAFFB8B6B4FFB6B4B2FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFB5B3B1FFBFBDBAFF3E3E3A4EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF005A585865DFDDDBFFD3D2D0FFD3D2D0FFD3D2D0FFD3D2D0FFD5D4
          D1FFDDDCDAFFBBBAB9FF17161BFF343336FFBEBEBEFFFFFFFFFFE8E7E7FFCFCE
          CCFFC2C0BFFFBAB9B7FFB7B5B3FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3B1FFB5B3
          B1FFBDBBB9FF979693BBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF0000000001A09F9FB3DEDDDBFFD3D2D0FFD4D3D1FFD4D3D2FFD6D5
          D3FFDEDEDBFFB9B8B7FF5C5A5DFFD7D7D6FFFFFEFEFFFBFBFBFFE8E7E7FFD4D2
          D1FFC6C4C3FFBEBCBAFFB9B7B5FFB6B4B2FFB6B4B2FFB5B3B1FFB5B3B1FFB6B4
          B2FFBEBDBBF329292931FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF001212121BC4C1C0D9DDDCDAFFD6D5D3FFD8D7D5FFD8D7
          D6FFDBDBD9FFD9D8D7FFE5E4E3FFF1F1EFFFF4F4F3FFFBFBFBFFEAE9E9FFD7D6
          D4FFC9C8C6FFC0BFBDFFBCBAB8FFB9B7B5FFB8B6B4FFB6B4B2FFB4B2B0FFCDCB
          C9FF62606062FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF002424242ACBCAC8DBE3E2E0FFDAD9D7FFDDDC
          DBFFDFDEDCFFE3E2E1FFE8E7E6FFEDEDECFFF6F6F5FFFCFBFBFFECEBEAFFDAD9
          D8FFCECDCBFFC6C5C3FFC1BFBDFFBEBCBAFFB9B7B5FFB9B7B5FFD4D2D1FF7373
          716EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF001B1B1B1CBDBCBCBCEEEEECFFE2E1
          DFFFE3E2E1FFE7E6E6FFEBEBEAFFF0F0F0FFF8F7F7FFFDFDFDFFF0EFEFFFE1E0
          DFFFD6D5D4FFCDCCCBFFC6C4C3FFBEBDBBFFCCCAC9FFD4D2D1EF5E5E5E59FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000047F7F7F6CE6E5
          E4E7F8F8F7FFF1F1F0FFEFEEEEFFF3F3F3FFFAFAFAFFFDFDFDFFF1F1F1FFE4E3
          E3FFD9D8D7FFD4D3D2FFDCDBD9FFE3E3E1FDACACACAD2A2A2A24FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
          0E127F7F7F6ACCCCCCC3F6F6F6F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFC
          FCFFF2F1F1FEDCDBDBDFA2A1A19848484835FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00000000012424241C585858457C7C7C627B7B7B727B7B7B6B7572
          725539393E310000000AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
        }
        ImageIndex = 5
        OnClick = BtnGoIdleClick
      end
    end
  end
  object GroupBoxLog: TGroupBox
    Left = 16
    Height = 160
    Top = 600
    Width = 1138
    Anchors = [akTop, akLeft, akRight, akBottom]
    Caption = 'Лог обмена'
    ClientHeight = 130
    ClientWidth = 1134
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object MemoCommandLog: TMemo
      Left = 631
      Height = 130
      Top = 0
      Width = 503
      Align = alClient
      Anchors = [akTop, akRight, akBottom]
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      ParentFont = False
      PopupMenu = PopupMenuLog
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = MemoCommandLogChange
    end
    object MemoLog: TMemo
      Left = 0
      Height = 130
      Top = 0
      Width = 626
      Align = alLeft
      Anchors = [akTop, akLeft, akRight, akBottom]
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      ParentFont = False
      PopupMenu = PopupMenuLog
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      OnChange = MemoLogChange
    end
    object Splitter1: TSplitter
      Left = 626
      Height = 130
      Top = 0
      Width = 5
    end
  end
  object PopupMenuLog: TPopupMenu
    Left = 1080
    Top = 32
    object PLogClear: TMenuItem
      Caption = 'Очистить'
      OnClick = PLogClearClick
    end
    object Separator1: TMenuItem
      Caption = '-'
    end
    object PLogPause: TMenuItem
      AutoCheck = True
      Caption = 'Приостановить'
      OnClick = PLogPauseClick
    end
    object PLogSaveToFile: TMenuItem
      Caption = 'Сохранить в файл'
      OnClick = PLogSaveToFileClick
    end
  end
  object LogSaveDialog: TSaveDialog
    FileName = 'ManualSave'
    InitialDir = '.'
    Left = 504
    Top = 624
  end
end
