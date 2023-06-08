object GeneralForm4: TGeneralForm4
  Left = 648
  Top = 119
  Width = 233
  Height = 224
  Caption = #1058#1080#1087' '#1084#1086#1076#1077#1083#1080
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 148
    Height = 16
    Caption = #1058#1080#1087' '#1084#1086#1076#1077#1083#1080#1088#1091#1077#1084#1086#1081' '#1089#1077#1090#1080':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = cl3DLight
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 152
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 144
    Top = 152
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 32
    Width = 209
    Height = 105
    Font.Charset = DEFAULT_CHARSET
    Font.Color = cl3DLight
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Items.Strings = (
      #1062#1074#1077#1090#1085#1099#1077' '#1089#1077#1090#1080' '#1055#1077#1090#1088#1080
      #1045' - '#1057#1077#1090#1080' GPSS')
    ParentFont = False
    TabOrder = 0
  end
end
