object ParamXq: TParamXq
  Left = 214
  Top = 19
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1072#1082#1088#1086'-'#1087#1077#1088#1077#1093#1086#1076#1072
  ClientHeight = 101
  ClientWidth = 239
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 148
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1079#1080#1094#1080#1081
  end
  object Label2: TLabel
    Left = 8
    Top = 42
    Width = 150
    Height = 13
    Caption = #1047#1072#1076#1072#1081#1090#1077' '#1080#1084#1103' '#1084#1072#1082#1088#1086'-'#1087#1077#1088#1077#1093#1086#1076#1072
  end
  object EditKPoz: TEdit
    Left = 168
    Top = 12
    Width = 49
    Height = 21
    MaxLength = 1
    ReadOnly = True
    TabOrder = 0
    Text = '1'
    OnKeyPress = EditKPozKeyPress
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 72
    Width = 75
    Height = 25
    Caption = '&Ok'
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkAll
  end
  object BitBtn2: TBitBtn
    Left = 144
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object UpDown1: TUpDown
    Left = 217
    Top = 12
    Width = 17
    Height = 21
    Associate = EditKPoz
    Min = 1
    Max = 10
    Position = 1
    TabOrder = 3
    Wrap = True
  end
  object NazMEd: TEdit
    Left = 168
    Top = 38
    Width = 65
    Height = 21
    MaxLength = 1
    TabOrder = 4
  end
end
