object LW: TLW
  Left = 0
  Height = 201
  Top = 0
  Width = 601
  Caption = 'Лог обмена'
  ClientHeight = 201
  ClientWidth = 601
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnResize = FormResize
  Scaled = False
  object MemoLog: TMemo
    Left = 1
    Height = 199
    Top = 1
    Width = 600
    OnChange = MemoLogChange
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
end
