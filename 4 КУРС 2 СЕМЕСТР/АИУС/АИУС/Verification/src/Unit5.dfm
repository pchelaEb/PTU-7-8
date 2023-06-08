object Form5: TForm5
  Left = 313
  Top = 153
  Width = 321
  Height = 273
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1087#1088#1086#1077#1082#1090#1072
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
    Left = 32
    Top = 8
    Width = 186
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1080#1084#1103' '#1084#1086#1076#1077#1083#1080#1088#1091#1077#1084#1086#1075#1086' '#1092#1072#1081#1083#1072':'
  end
  object Label2: TLabel
    Left = 32
    Top = 72
    Width = 126
    Height = 13
    Caption = #1058#1080#1087' '#1084#1086#1076#1077#1083#1080#1088#1091#1077#1084#1086#1081' '#1089#1077#1090#1080':'
  end
  object Bevel1: TBevel
    Left = 32
    Top = 24
    Width = 249
    Height = 41
  end
  object Edit1: TEdit
    Left = 40
    Top = 32
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 32
    Top = 208
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 208
    Top = 208
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 32
    Top = 88
    Width = 249
    Height = 113
    TabOrder = 3
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 0
      Width = 233
      Height = 105
      Items.Strings = (
        #1054#1088#1076#1080#1085#1072#1088#1085#1072#1103
        #1054#1073#1086#1073#1097#1077#1085#1085#1072#1103'('#1095#1080#1089#1083#1086#1074#1072#1103')'
        #1056#1072#1089#1082#1088#1072#1096#1077#1085#1085#1072#1103)
      TabOrder = 0
    end
  end
end
