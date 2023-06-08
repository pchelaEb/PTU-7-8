object Form6: TForm6
  Left = 148
  Top = 68
  Width = 625
  Height = 467
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = -8
    Width = 617
    Height = 377
    Lines.Strings = (
      '')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 376
    Width = 617
    Height = 57
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 96
      Top = 16
      Width = 75
      Height = 25
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 280
      Top = 16
      Width = 75
      Height = 25
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkClose
    end
    object BitBtn3: TBitBtn
      Left = 480
      Top = 16
      Width = 75
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100'   '
      TabOrder = 2
      OnClick = BitBtn3Click
      Kind = bkIgnore
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 8
    Top = 8
  end
  object PrintDialog1: TPrintDialog
    Left = 56
    Top = 8
  end
end
