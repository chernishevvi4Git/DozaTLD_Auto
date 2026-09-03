object StartMeasureW: TStartMeasureW
  Left = 1225
  Height = 710
  Top = 49
  Width = 469
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Измерение'
  ClientHeight = 710
  ClientWidth = 469
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poMainFormCenter
  LCLVersion = '3.6.0.0'
  object PanelMain: TPanel
    Left = 0
    Height = 710
    Top = 0
    Width = 469
    Align = alClient
    ClientHeight = 710
    ClientWidth = 469
    ParentBackground = False
    TabOrder = 0
    object PanelDosName: TPanel
      Left = 1
      Height = 272
      Top = 41
      Width = 467
      Align = alTop
      ClientHeight = 272
      ClientWidth = 467
      ParentBackground = False
      TabOrder = 0
      object LblDosTypeVal: TLabel
        Left = 23
        Height = 25
        Top = 21
        Width = 43
        Caption = 'Тип:'
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object LblErr: TLabel
        Left = 1
        Height = 18
        Top = 253
        Width = 465
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        Caption = 'Дозиметра с таким номером нет в списке!'
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
        Visible = False
        WordWrap = True
      end
      object LblNumber: TLabel
        Left = 23
        Height = 25
        Top = 68
        Width = 131
        Caption = 'Дозиметр №:'
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object LblKSI: TLabel
        Left = 23
        Height = 19
        Top = 108
        Width = 190
        Caption = 'Контрольная светосумма:'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object LblOrg: TLabel
        Left = 23
        Height = 19
        Top = 198
        Width = 101
        Caption = 'Организация:'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object LblDep: TLabel
        Left = 23
        Height = 19
        Top = 228
        Width = 119
        Caption = 'Подразделение:'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object LblFilter: TLabel
        Left = 23
        Height = 19
        Top = 168
        Width = 61
        Caption = 'Фильтр:'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object ShapeContur: TShape
        Left = 238
        Height = 31
        Top = 163
        Width = 214
        Brush.Color = clRed
        Visible = False
      end
      object CBoxDosType: TComboBox
        Left = 166
        Height = 41
        Top = 12
        Width = 286
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        ItemHeight = 33
        ParentFont = False
        Style = csDropDownList
        TabOrder = 0
        OnChange = CBoxDosTypeChange
        OnKeyUp = CBoxDosTypeKeyUp
      end
      object EditKSI: TEdit
        Left = 240
        Height = 27
        Top = 105
        Width = 210
        Color = clBtnFace
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 1
        OnEnter = EditDisable
        OnExit = EditEnable
      end
      object EditOrg: TEdit
        Left = 240
        Height = 27
        Top = 195
        Width = 210
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        MaxLength = 18
        ParentFont = False
        TabOrder = 2
        OnChange = EditOrgChange
      end
      object EditDep: TEdit
        Left = 240
        Height = 27
        Top = 225
        Width = 210
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        MaxLength = 18
        ParentFont = False
        TabOrder = 3
        OnChange = EditDepChange
      end
      object CBoxFiilter: TComboBox
        Left = 240
        Height = 27
        Top = 165
        Width = 210
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ItemHeight = 19
        ItemIndex = 0
        Items.Strings = (
          'Фильтр не установлен'
          'Фильтр установлен'
        )
        ParentFont = False
        Style = csDropDownList
        TabOrder = 4
        Text = 'Фильтр не установлен'
        OnChange = CBoxFiilterChange
      end
      object CBoxDosList: TComboBox
        Left = 166
        Height = 41
        Top = 56
        Width = 286
        AutoCompleteText = [cbactEndOfLineComplete, cbactSearchCaseSensitive, cbactSearchAscending]
        AutoDropDown = True
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        ItemHeight = 33
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        OnChange = CBoxDosListChange
        OnKeyUp = CBoxDosListKeyUp
        OnSelect = CBoxDosListSelect
      end
      object LblKSI1: TLabel
        Left = 23
        Height = 19
        Top = 137
        Width = 108
        Caption = 'Темновой ток:'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object EditDarkCurrent: TEdit
        Left = 240
        Height = 27
        Top = 134
        Width = 210
        Color = clBtnFace
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 6
        OnEnter = EditDisable
        OnExit = EditEnable
      end
      object ShapeConturDC: TShape
        Left = 238
        Height = 31
        Top = 132
        Width = 214
        Brush.Color = clRed
        Visible = False
      end
      object ShapeConturKSI: TShape
        Left = 238
        Height = 31
        Top = 103
        Width = 214
        Brush.Color = clRed
        Visible = False
      end
    end
    object PanelTop: TPanel
      Left = 1
      Height = 40
      Top = 1
      Width = 467
      Align = alTop
      ClientHeight = 40
      ClientWidth = 467
      ParentBackground = False
      TabOrder = 1
      object LblTopCaption: TLabel
        Left = 1
        Height = 38
        Top = 1
        Width = 465
        Align = alClient
        Alignment = taCenter
        Caption = 'Измерение'
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Layout = tlCenter
        ParentColor = False
        ParentFont = False
      end
    end
    object PanelMiddle: TPanel
      Left = 1
      Height = 396
      Top = 313
      Width = 467
      Align = alClient
      ClientHeight = 396
      ClientWidth = 467
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      object PageControlStart: TPageControl
        Left = 3
        Height = 394
        Top = 1
        Width = 463
        ActivePage = TabSheetStartLoad
        Align = alRight
        TabIndex = 0
        TabOrder = 0
        OnChange = PageControlStartChange
        object TabSheetStartLoad: TTabSheet
          Caption = ' Загрузка дозиметра'
          ClientHeight = 356
          ClientWidth = 455
          object PanelInformation: TPanel
            Left = 0
            Height = 279
            Top = 0
            Width = 455
            Align = alClient
            ClientHeight = 279
            ClientWidth = 455
            ParentBackground = False
            TabOrder = 0
            object PanelImage: TPanel
              Left = 5
              Height = 221
              Top = 23
              Width = 442
              BevelOuter = bvNone
              ClientHeight = 221
              ClientWidth = 442
              Color = clBtnHighlight
              ParentBackground = False
              ParentColor = False
              TabOrder = 0
              object ImageStart: TImage
                Left = 0
                Height = 221
                Top = 0
                Width = 442
                Align = alClient
                Center = True
                Stretch = True
              end
              object LblEnterDosNumber: TLabel
                Left = 0
                Height = 221
                Top = 0
                Width = 442
                Align = alClient
                Alignment = taCenter
                Caption = 'Контроль номера дозиметра'
                Font.Color = clWindowText
                Font.Height = -27
                Font.Name = 'Tahoma'
                Layout = tlCenter
                ParentColor = False
                ParentFont = False
              end
              object LblAttention: TLabel
                Left = 182
                Height = 29
                Top = 173
                Width = 132
                Caption = 'ВНИМАНИЕ!'
                Font.Color = clWindowText
                Font.Height = -24
                Font.Name = 'Tahoma'
                ParentColor = False
                ParentFont = False
                Visible = False
              end
              object ImageWarning: TImage
                Left = 104
                Height = 71
                Top = 146
                Width = 72
                Center = True
                Enabled = False
                Visible = False
              end
            end
          end
          object PanelBottom: TPanel
            Left = 0
            Height = 77
            Top = 279
            Width = 455
            Align = alBottom
            ClientHeight = 77
            ClientWidth = 455
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            object ButtonClose: TButton
              Left = 152
              Height = 52
              Top = 16
              Width = 147
              Cancel = True
              Caption = 'Закрыть'
              TabOrder = 0
              OnClick = ButtonCloseClick
            end
          end
        end
        object TabSheetStartMeas: TTabSheet
          Caption = ' Измерение '
          ClientHeight = 356
          ClientWidth = 455
          ImageIndex = 3
          object PanelPageMeas: TPanel
            Left = 0
            Height = 356
            Top = 0
            Width = 455
            Align = alClient
            ClientHeight = 356
            ClientWidth = 455
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            object GaugePageMeasStatusD1: TATGauge
              Left = 138
              Height = 31
              Top = 8
              Width = 304
              Color = clBtnFace
              DoubleBuffered = True
              ParentColor = False
              MaxValue = 300
            end
            object LblPageMeasD1: TLabel
              Left = 17
              Height = 23
              Top = 11
              Width = 97
              Caption = 'Детектор 1'
              ParentColor = False
            end
            object GaugePageMeasStatusD2: TATGauge
              Left = 138
              Height = 31
              Top = 45
              Width = 304
              Color = clBtnFace
              DoubleBuffered = True
              ParentColor = False
              MaxValue = 300
            end
            object GaugePageMeasStatusD3: TATGauge
              Left = 138
              Height = 31
              Top = 82
              Width = 304
              Color = clBtnFace
              DoubleBuffered = True
              ParentColor = False
              MaxValue = 300
            end
            object GaugePageMeasStatusD4: TATGauge
              Left = 138
              Height = 31
              Top = 119
              Width = 304
              Color = clBtnFace
              DoubleBuffered = True
              ParentColor = False
              MaxValue = 300
            end
            object LblPageMeasD2: TLabel
              Left = 17
              Height = 23
              Top = 48
              Width = 97
              Caption = 'Детектор 2'
              ParentColor = False
            end
            object LblPageMeasD3: TLabel
              Left = 17
              Height = 23
              Top = 85
              Width = 97
              Caption = 'Детектор 3'
              ParentColor = False
            end
            object LblPageMeasD4: TLabel
              Left = 17
              Height = 23
              Top = 122
              Width = 97
              Caption = 'Детектор 4'
              ParentColor = False
            end
            object LblPageMeasComment: TLabel
              Left = 17
              Height = 19
              Top = 159
              Width = 204
              Caption = 'Комментарий к измерению:'
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              ParentColor = False
              ParentFont = False
            end
            object EditPageMeasStatusD1: TEdit
              Left = 138
              Height = 31
              Top = 8
              Width = 304
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 0
              Text = 'Измерен успешно'
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditPageMeasStatusD2: TEdit
              Left = 138
              Height = 31
              Top = 45
              Width = 304
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 1
              Text = 'Измерен успешно'
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditPageMeasStatusD3: TEdit
              Left = 138
              Height = 31
              Top = 82
              Width = 304
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 2
              Text = 'Измерен успешно'
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object EditPageMeasStatusD4: TEdit
              Left = 138
              Height = 31
              Top = 119
              Width = 304
              Alignment = taCenter
              Color = clMoneyGreen
              ReadOnly = True
              TabOrder = 3
              Text = 'Измерен успешно'
              OnEnter = EditDisable
              OnExit = EditEnable
            end
            object MemoPageMeasComment: TMemo
              Left = 17
              Height = 77
              Top = 184
              Width = 425
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              ParentFont = False
              TabOrder = 4
              OnChange = MemoPageMeasCommentChange
            end
          end
        end
        object TabSheetStartQueue: TTabSheet
          Caption = ' Очередь '
          ClientHeight = 356
          ClientWidth = 455
          ImageIndex = 2
          object PanelQueue: TPanel
            Left = 0
            Height = 356
            Top = 0
            Width = 455
            Align = alClient
            ClientHeight = 356
            ClientWidth = 455
            ParentBackground = False
            TabOrder = 0
            object PanelQueueRight: TPanel
              Left = 400
              Height = 302
              Top = 1
              Width = 54
              Align = alRight
              ClientHeight = 302
              ClientWidth = 54
              ParentBackground = False
              TabOrder = 0
              object SpeedBtnQueueAdd: TSpeedButton
                Left = 3
                Height = 36
                Top = 6
                Width = 45
                Anchors = [akTop, akRight]
                Font.Color = clWindowText
                Font.Height = -27
                Font.Name = 'Tahoma'
                Glyph.Data = {
                  36080000424D3608000000000000360400002800000020000000200000000100
                  08000000000000040000C40E0000C40E00000001000000000000000000000000
                  80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
                  A6000020400000206000002080000020A0000020C0000020E000004000000040
                  20000040400000406000004080000040A0000040C0000040E000006000000060
                  20000060400000606000006080000060A0000060C0000060E000008000000080
                  20000080400000806000008080000080A0000080C0000080E00000A0000000A0
                  200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
                  200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
                  200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
                  20004000400040006000400080004000A0004000C0004000E000402000004020
                  20004020400040206000402080004020A0004020C0004020E000404000004040
                  20004040400040406000404080004040A0004040C0004040E000406000004060
                  20004060400040606000406080004060A0004060C0004060E000408000004080
                  20004080400040806000408080004080A0004080C0004080E00040A0000040A0
                  200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
                  200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
                  200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
                  20008000400080006000800080008000A0008000C0008000E000802000008020
                  20008020400080206000802080008020A0008020C0008020E000804000008040
                  20008040400080406000804080008040A0008040C0008040E000806000008060
                  20008060400080606000806080008060A0008060C0008060E000808000008080
                  20008080400080806000808080008080A0008080C0008080E00080A0000080A0
                  200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
                  200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
                  200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
                  2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
                  2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
                  2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
                  2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
                  2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
                  2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
                  2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFF6080808080808F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFF66C2222222222226CF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF08227EBEBEBEBE7E2208FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF08227E7D7D7D7D7E2208FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF08227E7E7E7E7E7E2208FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF08227E7E7E7E7E7E2208FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  F60808080807237E7E7E7E7E7E230708080808F6FFFFFFFFFFFFFFFFFFFFFFF6
                  6C2323232323237E7E7E7E7E7E2323232323236CF6FFFFFFFFFFFFFFFFFFFF08
                  23BEBFBFBFBFBE7E7E7E7E7E7EBEBFBFBFBFBE2308FFFFFFFFFFFFFFFFFFFF08
                  2B7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E2B08FFFFFFFFFFFFFFFFFFFF08
                  2B7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E2B08FFFFFFFFFFFFFFFFFFFF08
                  2BBE7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7EBE2B08FFFFFFFFFFFFFFFFFFFF08
                  2BBF7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7EBF2B08FFFFFFFFFFFFFFFFFFFF08
                  2CBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF2C08FFFFFFFFFFFFFFFFFFFFF6
                  752C2C2C2C2C2CBFBFBFBFBFBF2C2C2C2C2C2C75F6FFFFFFFFFFFFFFFFFFFFFF
                  F608080808072CBFBFBFBFBFBF2C0708080808F6FFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF082CBFBFBFBFBFBF2C08FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF0834BFBFBFBFBFBF3408FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF0834BFBFBFBFBFBF3408FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF0834BFBFBFBFBFBF3408FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFF67534343434343475F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFF6080808080808F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                }
                OnClick = SpeedBtnQueueAddClick
                ParentFont = False
              end
              object SpeedBtnQueueDel: TSpeedButton
                Left = 3
                Height = 36
                Top = 135
                Width = 45
                Anchors = [akTop, akRight]
                Glyph.Data = {
                  FE0A0000424DFE0A00000000000036000000280000001E0000001E0000000100
                  180000000000C80A0000C40E0000C40E00000000000000000000B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B3B5B7B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B3B5B7B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6A9AABA51
                  51C8999ABDB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B69B9DBD4F50C7A7A8BAB8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6A7A9BA5454C97575E75454
                  CB999ABEB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6999ABE5555CA7575E75353C9A7A9BAB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  0000B8B9B6B8B9B6B8B9B6B8B9B6A9AABA5454C97C7CEB8F8FF78686F25454CB
                  999ABDB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9DBD5454
                  CB8585F18F8FF77D7DEC5353C9A7A8BAB8B9B6B8B9B6B8B9B6B8B9B60000B8B9
                  B6B8B9B6B8B9B6B3B5B74F50C77575E78F8FF78F8FF78F8FF78686F25454CB99
                  9ABEB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6999ABE5454CB8686F28F8FF7
                  8F8FF78F8FF77575E74F50C7B3B5B7B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6
                  B8B9B6B8B9B69B9CBD5454CB8585F18F8FF78F8FF78F8FF78686F25454CB999A
                  BDB8B9B6B8B9B6B8B9B6B8B9B69B9DBD5454CB8585F18F8FF78F8FF78F8FF786
                  86F25656CC989ABDB8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B69B9CBD5454CB8585F18F8FF78F8FF78F8FF78686F25454CB999ABD
                  B8B9B6B8B9B69B9DBD5454CB8585F18F8FF78F8FF78F8FF78686F25656CC989A
                  BDB8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B69B9CBD5454CB8585F18F8FF78F8FF78F8FF78686F25454CB999ABD9B
                  9DBD5454CB8585F18F8FF78F8FF78F8FF78686F25656CC989ABDB8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6999ABE5454CB8686F28F8FF78F8FF78F8FF78686F25454CB5454CB8686
                  F28F8FF78F8FF78F8FF78686F25454CB999ABEB8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6999ABE5555CA8686F28F8FF78F8FF78F8FF78686F28686F28F8FF78F8FF7
                  8F8FF78686F25454CB999ABEB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B69B9CBD5454CB8585F18F8FF78F8FF78F8FF78F8FF78F8FF78F8FF78686F256
                  56CC989ABDB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  0000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  9B9CBD5454CB8585F18F8FF78F8FF78F8FF78F8FF78686F25656CC989ABDB8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9DBD54
                  54CB8585F18F8FF78F8FF78F8FF78F8FF78686F25454CB999ABDB8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9DBD5454CB8585F18F8F
                  F78F8FF78F8FF78F8FF78F8FF78F8FF78686F25454CB999ABDB8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6999ABE5555CA8686F28F8FF78F8FF78F8FF7
                  8686F28686F28F8FF78F8FF78F8FF78686F25454CB999ABEB8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6999ABE5454CB8686F28F8FF78F8FF78F8FF78686F25454CB54
                  54CB8686F28F8FF78F8FF78F8FF78686F25454CB999ABEB8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  9B9DBD5454CB8585F18F8FF78F8FF78F8FF78686F25656CC989ABD9B9CBD5454
                  CB8585F18F8FF78F8FF78F8FF78686F25454CB999ABDB8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9DBD5454CB85
                  85F18F8FF78F8FF78F8FF78686F25656CC989ABDB8B9B6B8B9B69B9CBD5454CB
                  8585F18F8FF78F8FF78F8FF78686F25454CB999ABDB8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B69B9DBD5454CB8585F18F8FF78F8F
                  F78F8FF78686F25656CC989ABDB8B9B6B8B9B6B8B9B6B8B9B69B9CBD5454CB85
                  85F18F8FF78F8FF78F8FF78686F25454CB999ABDB8B9B6B8B9B6B8B9B6B8B9B6
                  0000B8B9B6B8B9B6B8B9B6B3B4B74F50C77575E78F8FF78F8FF78F8FF78686F2
                  5454CB999ABEB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6999ABE5454CB8686
                  F28F8FF78F8FF78F8FF77575E74F50C7B3B4B7B8B9B6B8B9B6B8B9B60000B8B9
                  B6B8B9B6B8B9B6B8B9B6A8AABA5454C97D7DEB8F8FF78686F25656CC9899BDB8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9CBD5454CB8585F1
                  8F8FF77D7DEC5353C9A7A8BAB8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6A7A9BA5454C97575E75454CB999ABEB8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6999ABE5555CA7575E753
                  53C9A7A9BAB8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6A8AABA5151C69899BDB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9CBE4F50C7A7A8BAB8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B3B4B7B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B3B4B7B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  0000
                }
                OnClick = SpeedBtnQueueDelClick
              end
              object SpeedBtnQueueDown: TSpeedButton
                Left = 3
                Height = 36
                Top = 93
                Width = 45
                Anchors = [akTop, akRight]
                Glyph.Data = {
                  5A0B0000424D5A0B000000000000360000002800000029000000170000000100
                  180000000000240B000000000000000000000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
                  0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
                  00000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000
                  000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFF00000000000000000000000000000000000000000000000000000000
                  0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF0000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF00000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000000000000000000000000000000000000000FF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                }
                OnClick = SpeedBtnQueueDownClick
              end
              object SpeedBtnQueueUp: TSpeedButton
                Left = 3
                Height = 39
                Top = 48
                Width = 45
                Anchors = [akTop, akRight]
                Glyph.Data = {
                  5A0B0000424D5A0B000000000000360000002800000029000000170000000100
                  180000000000240B000000000000000000000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF0000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000FFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000000000000000000000000000FFFFFFFFFFFFFF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000FFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000
                  00000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000
                  000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000
                  0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFF000000000000000000000000000000FFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                }
                OnClick = SpeedBtnQueueUpClick
              end
            end
            object PaneQueuelGrid: TPanel
              Left = 1
              Height = 302
              Top = 1
              Width = 399
              Align = alClient
              ClientHeight = 302
              ClientWidth = 399
              ParentBackground = False
              TabOrder = 1
              object DBGridEhQueue: TDBGridEh
                Left = 1
                Height = 230
                Top = 1
                Width = 397
                Align = alClient
                DataSource = DataSourceQueue
                DynProps = <>
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                FooterParams.Font.Color = clBlack
                FooterParams.Font.Height = -19
                FooterParams.Font.Name = 'Tahoma'
                FooterParams.HorzLines = True
                FooterParams.ParentFont = False
                FooterParams.RowHeight = 4
                FooterParams.RowLines = 1
                FooterParams.VertLines = False
                IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
                IndicatorTitle.UseGlobalMenu = False
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghRecordMoving, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                ParentFont = False
                ReadOnly = True
                SortLocal = True
                TabOrder = 0
                OnCellClick = DBGridEhQueueCellClick
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
              object Panel1: TPanel
                Left = 1
                Height = 70
                Top = 231
                Width = 397
                Align = alBottom
                BevelOuter = bvNone
                ClientHeight = 70
                ClientWidth = 397
                ParentBackground = False
                TabOrder = 1
                object LblPageQueueComment: TLabel
                  Left = 9
                  Height = 19
                  Top = 9
                  Width = 105
                  Caption = 'Комментарий:'
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  ParentColor = False
                  ParentFont = False
                end
                object EditPageQueueComment: TEdit
                  Left = 120
                  Height = 27
                  Top = 6
                  Width = 272
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  ParentFont = False
                  TabOrder = 0
                  OnChange = EditPageQueueCommentChange
                end
                object BtnPageQueueFinish: TButton
                  Left = 120
                  Height = 27
                  Top = 38
                  Width = 272
                  Caption = 'Завершить серию измерений'
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  ParentFont = False
                  TabOrder = 1
                  OnClick = BtnPageQueueFinishClick
                end
              end
            end
            object PanelQueueBottom: TPanel
              Left = 1
              Height = 52
              Top = 303
              Width = 453
              Align = alBottom
              ClientHeight = 52
              ClientWidth = 453
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = 'Tahoma'
              ParentBackground = False
              ParentFont = False
              TabOrder = 2
              object BtnQueuePageClose: TButton
                Left = 4
                Height = 39
                Top = 6
                Width = 114
                Caption = 'Закрыть'
                Font.Color = clWindowText
                Font.Height = -21
                Font.Name = 'Tahoma'
                ParentFont = False
                TabOrder = 0
                OnClick = BtnQueuePageCloseClick
              end
            end
          end
        end
        object TabSheetStartCalibr: TTabSheet
          Caption = ' Калибровка '
          ClientHeight = 356
          ClientWidth = 455
          ImageIndex = 4
          object Panel2: TPanel
            Left = 0
            Height = 356
            Top = 0
            Width = 455
            Align = alClient
            Caption = 'Panel2'
            ClientHeight = 356
            ClientWidth = 455
            ParentBackground = False
            TabOrder = 0
            object PanelCalibrBottom: TPanel
              Left = 1
              Height = 52
              Top = 303
              Width = 453
              Align = alBottom
              ClientHeight = 52
              ClientWidth = 453
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = 'Tahoma'
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
              object BtnCalibrPageClose: TButton
                Left = 4
                Height = 39
                Top = 6
                Width = 114
                Caption = 'Закрыть'
                Font.Color = clWindowText
                Font.Height = -21
                Font.Name = 'Tahoma'
                ParentFont = False
                TabOrder = 0
                OnClick = BtnCalibrPageCloseClick
              end
            end
            object PanelCalibrlGrid: TPanel
              Left = 1
              Height = 302
              Top = 1
              Width = 399
              Align = alClient
              ClientHeight = 302
              ClientWidth = 399
              ParentBackground = False
              TabOrder = 1
              object DBGridEhCalibr: TDBGridEh
                Left = 1
                Height = 159
                Top = 72
                Width = 397
                Align = alBottom
                DataSource = DataSourceCalibr
                DynProps = <>
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                FooterParams.Font.Color = clBlack
                FooterParams.Font.Height = -19
                FooterParams.Font.Name = 'Tahoma'
                FooterParams.HorzLines = True
                FooterParams.ParentFont = False
                FooterParams.RowHeight = 4
                FooterParams.RowLines = 1
                FooterParams.VertLines = False
                IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
                IndicatorTitle.UseGlobalMenu = False
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghRecordMoving, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                ParentFont = False
                ReadOnly = True
                SortLocal = True
                TabOrder = 0
                OnCellClick = DBGridEhCalibrCellClick
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
              object PanelBottomGrid: TPanel
                Left = 1
                Height = 70
                Top = 231
                Width = 397
                Align = alBottom
                BevelOuter = bvNone
                ClientHeight = 70
                ClientWidth = 397
                ParentBackground = False
                TabOrder = 1
                object LblPageCalibrKDos: TLabel
                  Left = 9
                  Height = 19
                  Top = 9
                  Width = 275
                  Caption = 'Рассчитанное значение K-дозиметра:'
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  ParentColor = False
                  ParentFont = False
                end
                object EditPageCalibrKDos: TEdit
                  Left = 290
                  Height = 27
                  Top = 5
                  Width = 102
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 0
                end
                object BtnPageCalibrFinish: TButton
                  Left = 120
                  Height = 27
                  Top = 38
                  Width = 272
                  Caption = 'Завершить калибровку'
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  ParentFont = False
                  TabOrder = 1
                  OnClick = BtnPageCalibrFinishClick
                end
              end
              object LblCalibrDose: TLabel
                Left = 8
                Height = 19
                Top = 9
                Width = 161
                Caption = 'Доза облучения, мЗв:'
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                ParentColor = False
                ParentFont = False
              end
              object EditCalibrDose: TEdit
                Left = 174
                Height = 27
                Top = 6
                Width = 210
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                ParentFont = False
                TabOrder = 2
              end
              object LblCalibrRadType: TLabel
                Left = 8
                Height = 19
                Top = 48
                Width = 115
                Caption = 'Тип излучения:'
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                ParentColor = False
                ParentFont = False
              end
              object CBoxRadType: TComboBox
                Left = 174
                Height = 27
                Top = 40
                Width = 210
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                ItemHeight = 19
                ParentFont = False
                Style = csDropDownList
                TabOrder = 3
                OnChange = CBoxRadTypeChange
              end
            end
            object PanelCalibrRight: TPanel
              Left = 400
              Height = 302
              Top = 1
              Width = 54
              Align = alRight
              ClientHeight = 302
              ClientWidth = 54
              ParentBackground = False
              TabOrder = 2
              object SpeedButtonCalibrAdd: TSpeedButton
                Left = 3
                Height = 36
                Top = 6
                Width = 45
                Anchors = [akTop, akRight]
                Glyph.Data = {
                  36080000424D3608000000000000360400002800000020000000200000000100
                  08000000000000040000C40E0000C40E00000001000000000000000000000000
                  80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
                  A6000020400000206000002080000020A0000020C0000020E000004000000040
                  20000040400000406000004080000040A0000040C0000040E000006000000060
                  20000060400000606000006080000060A0000060C0000060E000008000000080
                  20000080400000806000008080000080A0000080C0000080E00000A0000000A0
                  200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
                  200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
                  200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
                  20004000400040006000400080004000A0004000C0004000E000402000004020
                  20004020400040206000402080004020A0004020C0004020E000404000004040
                  20004040400040406000404080004040A0004040C0004040E000406000004060
                  20004060400040606000406080004060A0004060C0004060E000408000004080
                  20004080400040806000408080004080A0004080C0004080E00040A0000040A0
                  200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
                  200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
                  200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
                  20008000400080006000800080008000A0008000C0008000E000802000008020
                  20008020400080206000802080008020A0008020C0008020E000804000008040
                  20008040400080406000804080008040A0008040C0008040E000806000008060
                  20008060400080606000806080008060A0008060C0008060E000808000008080
                  20008080400080806000808080008080A0008080C0008080E00080A0000080A0
                  200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
                  200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
                  200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
                  2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
                  2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
                  2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
                  2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
                  2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
                  2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
                  2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFF6080808080808F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFF66C2222222222226CF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF08227EBEBEBEBE7E2208FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF08227E7D7D7D7D7E2208FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF08227E7E7E7E7E7E2208FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF08227E7E7E7E7E7E2208FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  F60808080807237E7E7E7E7E7E230708080808F6FFFFFFFFFFFFFFFFFFFFFFF6
                  6C2323232323237E7E7E7E7E7E2323232323236CF6FFFFFFFFFFFFFFFFFFFF08
                  23BEBFBFBFBFBE7E7E7E7E7E7EBEBFBFBFBFBE2308FFFFFFFFFFFFFFFFFFFF08
                  2B7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E2B08FFFFFFFFFFFFFFFFFFFF08
                  2B7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E2B08FFFFFFFFFFFFFFFFFFFF08
                  2BBE7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7EBE2B08FFFFFFFFFFFFFFFFFFFF08
                  2BBF7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7EBF2B08FFFFFFFFFFFFFFFFFFFF08
                  2CBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF2C08FFFFFFFFFFFFFFFFFFFFF6
                  752C2C2C2C2C2CBFBFBFBFBFBF2C2C2C2C2C2C75F6FFFFFFFFFFFFFFFFFFFFFF
                  F608080808072CBFBFBFBFBFBF2C0708080808F6FFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF082CBFBFBFBFBFBF2C08FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF0834BFBFBFBFBFBF3408FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF0834BFBFBFBFBFBF3408FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF0834BFBFBFBFBFBF3408FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFF67534343434343475F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFF6080808080808F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                }
                OnClick = SpeedButtonCalibrAddClick
              end
              object SpeedButtonCalibrDel: TSpeedButton
                Left = 3
                Height = 36
                Top = 135
                Width = 45
                Anchors = [akTop, akRight]
                Glyph.Data = {
                  FE0A0000424DFE0A00000000000036000000280000001E0000001E0000000100
                  180000000000C80A0000C40E0000C40E00000000000000000000B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B3B5B7B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B3B5B7B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6A9AABA51
                  51C8999ABDB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B69B9DBD4F50C7A7A8BAB8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6A7A9BA5454C97575E75454
                  CB999ABEB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6999ABE5555CA7575E75353C9A7A9BAB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  0000B8B9B6B8B9B6B8B9B6B8B9B6A9AABA5454C97C7CEB8F8FF78686F25454CB
                  999ABDB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9DBD5454
                  CB8585F18F8FF77D7DEC5353C9A7A8BAB8B9B6B8B9B6B8B9B6B8B9B60000B8B9
                  B6B8B9B6B8B9B6B3B5B74F50C77575E78F8FF78F8FF78F8FF78686F25454CB99
                  9ABEB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6999ABE5454CB8686F28F8FF7
                  8F8FF78F8FF77575E74F50C7B3B5B7B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6
                  B8B9B6B8B9B69B9CBD5454CB8585F18F8FF78F8FF78F8FF78686F25454CB999A
                  BDB8B9B6B8B9B6B8B9B6B8B9B69B9DBD5454CB8585F18F8FF78F8FF78F8FF786
                  86F25656CC989ABDB8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B69B9CBD5454CB8585F18F8FF78F8FF78F8FF78686F25454CB999ABD
                  B8B9B6B8B9B69B9DBD5454CB8585F18F8FF78F8FF78F8FF78686F25656CC989A
                  BDB8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B69B9CBD5454CB8585F18F8FF78F8FF78F8FF78686F25454CB999ABD9B
                  9DBD5454CB8585F18F8FF78F8FF78F8FF78686F25656CC989ABDB8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6999ABE5454CB8686F28F8FF78F8FF78F8FF78686F25454CB5454CB8686
                  F28F8FF78F8FF78F8FF78686F25454CB999ABEB8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6999ABE5555CA8686F28F8FF78F8FF78F8FF78686F28686F28F8FF78F8FF7
                  8F8FF78686F25454CB999ABEB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B69B9CBD5454CB8585F18F8FF78F8FF78F8FF78F8FF78F8FF78F8FF78686F256
                  56CC989ABDB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  0000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  9B9CBD5454CB8585F18F8FF78F8FF78F8FF78F8FF78686F25656CC989ABDB8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9DBD54
                  54CB8585F18F8FF78F8FF78F8FF78F8FF78686F25454CB999ABDB8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9DBD5454CB8585F18F8F
                  F78F8FF78F8FF78F8FF78F8FF78F8FF78686F25454CB999ABDB8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6999ABE5555CA8686F28F8FF78F8FF78F8FF7
                  8686F28686F28F8FF78F8FF78F8FF78686F25454CB999ABEB8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6999ABE5454CB8686F28F8FF78F8FF78F8FF78686F25454CB54
                  54CB8686F28F8FF78F8FF78F8FF78686F25454CB999ABEB8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  9B9DBD5454CB8585F18F8FF78F8FF78F8FF78686F25656CC989ABD9B9CBD5454
                  CB8585F18F8FF78F8FF78F8FF78686F25454CB999ABDB8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9DBD5454CB85
                  85F18F8FF78F8FF78F8FF78686F25656CC989ABDB8B9B6B8B9B69B9CBD5454CB
                  8585F18F8FF78F8FF78F8FF78686F25454CB999ABDB8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B69B9DBD5454CB8585F18F8FF78F8F
                  F78F8FF78686F25656CC989ABDB8B9B6B8B9B6B8B9B6B8B9B69B9CBD5454CB85
                  85F18F8FF78F8FF78F8FF78686F25454CB999ABDB8B9B6B8B9B6B8B9B6B8B9B6
                  0000B8B9B6B8B9B6B8B9B6B3B4B74F50C77575E78F8FF78F8FF78F8FF78686F2
                  5454CB999ABEB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6999ABE5454CB8686
                  F28F8FF78F8FF78F8FF77575E74F50C7B3B4B7B8B9B6B8B9B6B8B9B60000B8B9
                  B6B8B9B6B8B9B6B8B9B6A8AABA5454C97D7DEB8F8FF78686F25656CC9899BDB8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9CBD5454CB8585F1
                  8F8FF77D7DEC5353C9A7A8BAB8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6A7A9BA5454C97575E75454CB999ABEB8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6999ABE5555CA7575E753
                  53C9A7A9BAB8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6A8AABA5151C69899BDB8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B69B9CBE4F50C7A7A8BAB8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B3B4B7B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B3B4B7B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B60000B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9
                  B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8
                  B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6B8B9B6
                  0000
                }
                OnClick = SpeedButtonCalibrDelClick
              end
              object SpeedButtonCalibrDown: TSpeedButton
                Left = 3
                Height = 36
                Top = 93
                Width = 45
                Anchors = [akTop, akRight]
                Glyph.Data = {
                  5A0B0000424D5A0B000000000000360000002800000029000000170000000100
                  180000000000240B000000000000000000000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
                  0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
                  00000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000
                  000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFF00000000000000000000000000000000000000000000000000000000
                  0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF0000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF00000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000000000000000000000000000000000000000FF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                }
                OnClick = SpeedButtonCalibrDownClick
              end
              object SpeedButtonCalibrUp: TSpeedButton
                Left = 3
                Height = 39
                Top = 48
                Width = 45
                Anchors = [akTop, akRight]
                Glyph.Data = {
                  5A0B0000424D5A0B000000000000360000002800000029000000170000000100
                  180000000000240B000000000000000000000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF0000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000FFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000000000000000000000000000FFFFFFFFFFFFFF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000FFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000
                  00000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000
                  000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000
                  0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFF000000000000000000000000000000FFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
                }
                OnClick = SpeedButtonCalibrUpClick
              end
            end
          end
        end
        object TabSheetStartIDK: TTabSheet
          Caption = 'Доп. параметры'
          ClientHeight = 356
          ClientWidth = 455
          ImageIndex = 1
          object PanelPageIDK: TPanel
            Left = 0
            Height = 356
            Top = 0
            Width = 455
            Align = alClient
            ClientHeight = 356
            ClientWidth = 455
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            object LblPageFIO: TLabel
              Left = 12
              Height = 23
              Top = 86
              Width = 47
              Caption = 'ФИО:'
              ParentColor = False
            end
            object LblPageIDKPersNumber: TLabel
              Left = 12
              Height = 23
              Top = 20
              Width = 164
              Caption = 'Табельный номер:'
              ParentColor = False
            end
            object EditPageIDKPersNumber: TEdit
              Left = 12
              Height = 31
              Top = 49
              Width = 424
              NumbersOnly = True
              TabOrder = 0
              OnChange = EditPageIDKPersNumberChange
            end
            object EditPageIDKFIO: TEdit
              Left = 12
              Height = 31
              Top = 115
              Width = 424
              MaxLength = 42
              TabOrder = 1
              OnChange = EditPageIDKFIOChange
            end
          end
        end
      end
    end
  end
  object PopupMenuSkip: TPopupMenu
    Left = 352
    Top = 624
    object pmLost: TMenuItem
      Caption = 'Утерян'
    end
    object pmBroken: TMenuItem
      Caption = 'Сломан'
    end
    object pmAnother: TMenuItem
      Caption = 'Другое'
    end
  end
  object DataSourceQueue: TDataSource
    DataSet = MemTableEhQueue
    Left = 406
    Top = 48
  end
  object MemTableEhQueue: TMemTableEh
    Filtered = True
    FetchAllOnOpen = True
    Params = <>
    Left = 406
    Top = 96
    object MemTableEhQueuefulldoseid: TStringField
      FieldKind = fkData
      FieldName = 'fulldoseid'
      Index = 0
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhQueuedosimetertype: TStringField
      FieldKind = fkData
      FieldName = 'dosimetertype'
      Index = 1
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object MemTableEhQueueprocessed: TBooleanField
      FieldKind = fkData
      FieldName = 'processed'
      Index = 2
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      DisplayValues = 'True;False'
    end
    object MemTableEhQueuecomment: TStringField
      FieldKind = fkData
      FieldName = 'comment'
      Index = 3
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
  end
  object MemTableEhCalibr: TMemTableEh
    FieldDefs = <    
      item
        Name = 'sourcedose'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'processed'
        DataType = ftBoolean
      end    
      item
        Name = 'kdos'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'dosimetertype'
        DataType = ftString
        Size = 20
      end    
      item
        Name = 'fulldosid'
        DataType = ftString
        Size = 20
      end>
    Filtered = True
    FetchAllOnOpen = True
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 318
    Top = 96
    object StringField1: TStringField
      DisplayWidth = 9
      FieldKind = fkData
      FieldName = 'fulldosid'
      Index = 0
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object StringField2: TStringField
      DisplayWidth = 7
      FieldKind = fkData
      FieldName = 'dosimetertype'
      Index = 1
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object StringField4: TStringField
      FieldKind = fkData
      FieldName = 'kdos'
      Index = 2
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
    object BooleanField1: TBooleanField
      DisplayWidth = 2
      FieldKind = fkData
      FieldName = 'processed'
      Index = 3
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
      DisplayValues = 'True;False'
    end
    object StringField5: TStringField
      FieldKind = fkData
      FieldName = 'sourcedose'
      Index = 4
      LookupCache = False
      ProviderFlags = [pfInUpdate, pfInWhere]
      ReadOnly = False
      Required = False
    end
  end
  object DataSourceCalibr: TDataSource
    DataSet = MemTableEhCalibr
    Left = 318
    Top = 48
  end
  object ADOQueryStartMW: TSQLQuery
    PacketRecords = 2147483647
    FieldDefs = <>
    Database = TLDDataModule.ODBCConnection
    Transaction = TLDDataModule.dbSQLTransaction
    Params = <>
    Macros = <>
    Left = 100
    Top = 60
  end
end
