object Fishka: TFishka
  Left = 304
  Top = 188
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1092#1080#1096#1082#1080
  ClientHeight = 56
  ClientWidth = 220
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LP1: TLabel
    Left = 56
    Top = 32
    Width = 59
    Height = 13
    Caption = #1055#1086#1083#1091#1095#1072#1090#1077#1083#1100
  end
  object LP2: TLabel
    Left = 56
    Top = 8
    Width = 66
    Height = 13
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1077#1083#1100
  end
  object EP1: TEdit
    Left = 8
    Top = 8
    Width = 41
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object EP2: TEdit
    Left = 8
    Top = 32
    Width = 41
    Height = 21
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 144
    Top = 16
    Width = 57
    Height = 25
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkOK
  end
end
