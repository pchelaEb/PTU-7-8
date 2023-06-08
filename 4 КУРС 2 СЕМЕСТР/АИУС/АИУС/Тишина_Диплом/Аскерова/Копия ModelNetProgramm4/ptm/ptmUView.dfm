object ptmView: TptmView
  Left = 324
  Top = 109
  Width = 586
  Height = 454
  Caption = #1055#1088#1086#1090#1086#1082#1086#1083
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 0
    Top = 40
    Width = 577
    Height = 385
    Lines.Strings = (
      'Memo')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object ButtonSave: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object ImageList: TImageList
    Left = 56
    Top = 56
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'gps'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083' (*.txt)|*.txt'
    Left = 104
    Top = 56
  end
end
