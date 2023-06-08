object Knowledge: TKnowledge
  Left = 188
  Top = 368
  Width = 553
  Height = 537
  Caption = #1041#1072#1079#1072' '#1079#1085#1072#1085#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 65
    Height = 13
    Caption = #1041#1072#1079#1072' '#1092#1072#1082#1090#1086#1074
  end
  object Label2: TLabel
    Left = 24
    Top = 288
    Width = 72
    Height = 13
    Caption = #1041#1072#1079#1072' '#1088#1077#1096#1077#1085#1080#1081
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 32
    Width = 489
    Height = 217
    DataSource = DataModule1.DFacts
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 16
    Top = 312
    Width = 409
    Height = 121
    DataSource = DataModule1.DAlternatives
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 232
    Top = 456
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button1Click
  end
end
