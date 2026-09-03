object DosimeterConstructorForm: TDosimeterConstructorForm
  Left = 0
  Height = 761
  Top = 0
  Width = 479
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'DosimeterConstructorForm'
  ClientHeight = 761
  ClientWidth = 479
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnShow = FormShow
  Position = poMainFormCenter
  object PanelLeft: TPanel
    Left = 0
    Height = 651
    Top = 56
    Width = 479
    Align = alClient
    ClientHeight = 651
    ClientWidth = 479
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 0
    object PanelDosNumberParameters: TPanel
      Left = 1
      Height = 649
      Top = 1
      Width = 477
      Align = alClient
      ClientHeight = 649
      ClientWidth = 477
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      ParentFont = False
      TabOrder = 0
      object LabelDosType: TLabel
        Left = 50
        Height = 25
        Top = 97
        Width = 43
        Caption = 'Тип:'
        ParentColor = False
      end
      object LblDosTypeExist: TLabel
        Left = 195
        Height = 19
        Top = 125
        Width = 185
        Caption = 'Не указан тип дозиметра'
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object SpeedBtnDosInf: TSpeedButton
        Left = 411
        Height = 34
        Top = 94
        Width = 34
        Caption = 'i'
        OnClick = SpeedBtnDosInfClick
      end
      object LabelDosCnt: TLabel
        Left = 50
        Height = 25
        Top = 58
        Width = 119
        Caption = 'Количество:'
        ParentColor = False
      end
      object LabelDosNumberFrom: TLabel
        Left = 50
        Height = 25
        Top = 19
        Width = 68
        Caption = 'Номер:'
        ParentColor = False
      end
      object LabelPostfix: TLabel
        Left = 50
        Height = 25
        Top = 154
        Width = 100
        Caption = 'Постфикс:'
        ParentColor = False
      end
      object ComboBoxDosType: TComboBox
        Left = 195
        Height = 33
        Top = 94
        Width = 210
        ItemHeight = 25
        OnChange = ComboBoxDosTypeChange
        OnKeyUp = ComboBoxDosTypeKeyUp
        Style = csDropDownList
        TabOrder = 2
      end
      object EditDosNumberFrom: TEdit
        Left = 195
        Height = 33
        Top = 16
        Width = 210
        OnChange = EditDosNumberFromChange
        OnKeyPress = EditKeyPressOnlyIntNumbers
        OnKeyUp = EditDosNumberFromKeyUp
        TabOrder = 0
      end
      object EditDosCount: TEdit
        Left = 195
        Height = 33
        Top = 55
        Width = 210
        OnChange = EditDosCountChange
        OnKeyPress = EditKeyPressOnlyIntNumbers
        OnKeyUp = EditDosCountKeyUp
        TabOrder = 1
        Text = '1'
      end
      object EditDosPostfix: TEdit
        Left = 195
        Height = 33
        Top = 153
        Width = 118
        MaxLength = 10
        OnKeyPress = EditDosPostfixKeyPress
        OnKeyUp = EditDosPostfixKeyUp
        TabOrder = 3
      end
      object PageControlParameters: TPageControl
        Left = 1
        Height = 444
        Top = 203
        Width = 493
        ActivePage = TabSheetMainParam
        TabIndex = 0
        TabOrder = 4
        object TabSheetMainParam: TTabSheet
          Caption = ' Осн. параметры '
          ClientHeight = 406
          ClientWidth = 485
          object PanelPageMainParam: TPanel
            Left = 0
            Height = 406
            Top = 0
            Width = 485
            Align = alClient
            ClientHeight = 406
            ClientWidth = 485
            ParentBackground = False
            TabOrder = 0
            object GroupBoxK: TGroupBox
              Left = 11
              Height = 385
              Top = 4
              Width = 431
              Caption = 'K-дозиметра'
              ClientHeight = 355
              ClientWidth = 427
              TabOrder = 0
              object LblDotK1: TLabel
                Left = 40
                Height = 25
                Top = 185
                Width = 12
                Caption = 'd'
                ParentColor = False
              end
              object LblDotK2: TLabel
                Left = 40
                Height = 25
                Top = 224
                Width = 12
                Caption = 'd'
                ParentColor = False
              end
              object LblDotK3: TLabel
                Left = 40
                Height = 25
                Top = 263
                Width = 12
                Caption = 'd'
                ParentColor = False
              end
              object LblDotK4: TLabel
                Left = 40
                Height = 25
                Top = 302
                Width = 12
                Caption = 'd'
                ParentColor = False
              end
              object LblDotK5: TLabel
                Left = 38
                Height = 25
                Top = 341
                Width = 12
                Caption = 'd'
                ParentColor = False
              end
              object LblDotKgn: TLabel
                Left = 237
                Height = 25
                Top = 185
                Width = 12
                Caption = 'd'
                ParentColor = False
              end
              object LblK_1: TLabel
                Left = 58
                Height = 25
                Top = 185
                Width = 30
                Caption = 'K1:'
                ParentColor = False
              end
              object LblK_2: TLabel
                Left = 58
                Height = 25
                Top = 224
                Width = 30
                Caption = 'K2:'
                ParentColor = False
              end
              object LblK_3: TLabel
                Left = 58
                Height = 25
                Top = 263
                Width = 30
                Caption = 'K3:'
                ParentColor = False
              end
              object LblK_4: TLabel
                Left = 58
                Height = 25
                Top = 302
                Width = 30
                Caption = 'K4:'
                ParentColor = False
              end
              object LblK_5: TLabel
                Left = 58
                Height = 25
                Top = 341
                Width = 30
                Caption = 'K5:'
                ParentColor = False
              end
              object LblK_gn: TLabel
                Left = 255
                Height = 25
                Top = 185
                Width = 43
                Caption = 'Kgn:'
                ParentColor = False
              end
              object LblDosPartName: TLabel
                Left = 95
                Height = 25
                Top = 63
                Width = 175
                Caption = 'Название партии:'
                ParentColor = False
              end
              object ShapeErr: TShape
                Left = 92
                Height = 39
                Top = 91
                Width = 293
                Brush.Style = bsClear
                Pen.Color = clRed
                Visible = False
              end
              object SpeedBtnPartInf: TSpeedButton
                Left = 388
                Height = 33
                Top = 94
                Width = 33
                Caption = 'i'
                OnClick = SpeedBtnPartInfClick
              end
              object ShapeErrK1: TShape
                Left = 92
                Height = 38
                Top = 179
                Width = 126
                Brush.Style = bsClear
                Pen.Color = clRed
                Visible = False
              end
              object ShapeErrK2: TShape
                Left = 92
                Height = 38
                Top = 218
                Width = 126
                Brush.Style = bsClear
                Pen.Color = clRed
                Visible = False
              end
              object ShapeErrK3: TShape
                Left = 92
                Height = 38
                Top = 257
                Width = 126
                Brush.Style = bsClear
                Pen.Color = clRed
                Visible = False
              end
              object ShapeErrK4: TShape
                Left = 92
                Height = 38
                Top = 296
                Width = 126
                Brush.Style = bsClear
                Pen.Color = clRed
                Visible = False
              end
              object ShapeErrK5: TShape
                Left = 92
                Height = 38
                Top = 335
                Width = 126
                Brush.Style = bsClear
                Pen.Color = clRed
                Visible = False
              end
              object ShapeErrKgn: TShape
                Left = 302
                Height = 38
                Top = 179
                Width = 126
                Brush.Style = bsClear
                Pen.Color = clRed
                Visible = False
              end
              object EditDosK_1: TEdit
                Left = 94
                Height = 33
                Top = 182
                Width = 122
                OnChange = EditDosK_1Change
                OnKeyUp = EditDosK_1KeyUp
                TabOrder = 3
                Text = '-1'
              end
              object EditDosK_2: TEdit
                Left = 94
                Height = 33
                Top = 221
                Width = 122
                OnChange = EditDosK_2Change
                OnKeyUp = EditDosK_2KeyUp
                TabOrder = 4
                Text = '-1'
              end
              object EditDosK_3: TEdit
                Left = 94
                Height = 33
                Top = 260
                Width = 122
                OnChange = EditDosK_3Change
                OnKeyUp = EditDosK_3KeyUp
                TabOrder = 5
                Text = '-1'
              end
              object EditDosK_4: TEdit
                Left = 94
                Height = 33
                Top = 299
                Width = 122
                OnChange = EditDosK_4Change
                OnKeyUp = EditDosK_4KeyUp
                TabOrder = 6
                Text = '-1'
              end
              object EditDosK_5: TEdit
                Left = 94
                Height = 33
                Top = 338
                Width = 122
                OnChange = EditDosK_5Change
                OnKeyUp = EditDosK_5KeyUp
                TabOrder = 7
                Text = '-1'
              end
              object EditDosK_gn: TEdit
                Left = 304
                Height = 33
                Top = 182
                Width = 122
                OnChange = EditDosK_gnChange
                TabOrder = 8
                Text = '-1'
              end
              object EditPartName: TEdit
                Left = 95
                Height = 33
                Top = 94
                Width = 287
                MaxLength = 18
                OnKeyUp = EditPartNameKeyUp
                TabOrder = 1
              end
              object RadioBtnCreatePart: TRadioButton
                Left = 24
                Height = 29
                Top = 33
                Width = 243
                Caption = 'Сформировать партию'
                OnClick = RadioBtnCreatePartClick
                TabOrder = 0
              end
              object RadioBtnNotCreatePart: TRadioButton
                Left = 24
                Height = 29
                Top = 136
                Width = 262
                Caption = 'Не формировать партию'
                Checked = True
                OnClick = RadioBtnNotCreatePartClick
                TabOrder = 2
                TabStop = True
              end
            end
          end
        end
        object TabSheetAdditionalParam: TTabSheet
          Caption = ' Доп. параметры '
          ClientHeight = 406
          ClientWidth = 485
          ImageIndex = 1
          object PanelPageAdditionalParam: TPanel
            Left = 0
            Height = 406
            Top = 0
            Width = 485
            Align = alClient
            ClientHeight = 406
            ClientWidth = 485
            ParentBackground = False
            TabOrder = 0
            object LabelOrg: TLabel
              Left = 15
              Height = 25
              Top = 18
              Width = 134
              Caption = 'Организация:'
              ParentColor = False
            end
            object LabelDep: TLabel
              Left = 15
              Height = 25
              Top = 98
              Width = 158
              Caption = 'Подразделение:'
              ParentColor = False
            end
            object EditDosOrg: TEdit
              Left = 15
              Height = 33
              Top = 49
              Width = 449
              MaxLength = 18
              TabOrder = 0
            end
            object EditDosDep: TEdit
              Left = 15
              Height = 33
              Top = 129
              Width = 449
              MaxLength = 18
              TabOrder = 1
            end
          end
        end
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Height = 54
    Top = 707
    Width = 479
    Align = alBottom
    ClientHeight = 54
    ClientWidth = 479
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 1
    object BtnNext: TButton
      Left = 269
      Height = 44
      Top = 6
      Width = 203
      Anchors = [akTop, akRight]
      Caption = 'Далее'
      OnClick = BtnNextClick
      TabOrder = 0
    end
    object BtnCancel: TButton
      Left = 5
      Height = 44
      Top = 6
      Width = 180
      Cancel = True
      Caption = 'Закрыть'
      OnClick = BtnCancelClick
      TabOrder = 1
    end
  end
  object PanelDosTitle: TPanel
    Left = 0
    Height = 56
    Top = 0
    Width = 479
    Align = alTop
    ClientHeight = 56
    ClientWidth = 479
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    ParentFont = False
    TabOrder = 2
    object LabelTitle: TLabel
      Left = 1
      Height = 54
      Top = 1
      Width = 477
      Align = alClient
      Alignment = taCenter
      Caption = 'Добавление дозиметров'
      Layout = tlCenter
      ParentColor = False
    end
  end
  object OpenDialogList: TOpenDialog
    Left = 424
    Top = 680
  end
end
