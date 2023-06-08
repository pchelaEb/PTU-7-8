object FormUravnenie: TFormUravnenie
  Left = 249
  Top = 192
  BorderStyle = bsSingle
  Caption = #1059#1088#1072#1074#1085#1077#1085#1080#1077' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1103' '#1089#1086#1089#1090#1086#1103#1085#1080#1103' '#1085#1077#1081#1088#1086#1087#1086#1079#1080#1094#1080#1080
  ClientHeight = 186
  ClientWidth = 441
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = Close
  PixelsPerInch = 96
  TextHeight = 13
  object Metka1: TLabel
    Left = 16
    Top = 8
    Width = 249
    Height = 13
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1091#1088#1072#1074#1085#1077#1085#1080#1077' '#1074' '#1089#1090#1088#1086#1082#1091
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1091#1088#1072#1074#1085#1077#1085#1080#1077' '#1074#1080#1076#1072' '#1091'('#1093'), '#1075#1076#1077' '#1093' - '#1087#1077#1088#1077#1084#1077#1085#1085#1072#1103','
  end
  object Metka2: TLabel
    Left = 16
    Top = 24
    Width = 364
    Height = 13
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1091#1088#1072#1074#1085#1077#1085#1080#1077' '#1074' '#1089#1090#1088#1086#1082#1091
    Caption = ' '#1076#1083#1103' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1103' '#1074#1088#1077#1084#1077#1085#1085#1099#1093' '#1089#1086#1089#1090#1072#1074#1083#1103#1102#1097#1080#1093' '#1074' '#1082#1072#1078#1076#1099#1081' '#1084#1086#1084#1077#1085#1090' '#1074#1088#1077#1084#1077#1085#1080
  end
  object Metka3: TLabel
    Left = 16
    Top = 40
    Width = 89
    Height = 13
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1091#1088#1072#1074#1085#1077#1085#1080#1077' '#1074' '#1089#1090#1088#1086#1082#1091
    Caption = #1074' '#1085#1077#1081#1088#1086#1087#1086#1079#1080#1094#1080#1103#1093':'
  end
  object Label1: TLabel
    Left = 280
    Top = 144
    Width = 55
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object EditUravn: TEdit
    Left = 24
    Top = 64
    Width = 369
    Height = 21
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1091#1088#1072#1074#1085#1077#1085#1080#1077' '#1074' '#1089#1090#1088#1086#1082#1091
    MaxLength = 80
    TabOrder = 0
  end
  object OkButton: TButton
    Left = 136
    Top = 96
    Width = 75
    Height = 25
    Hint = #1053#1072#1078#1084#1080#1090#1077' '#1085#1072' '#1082#1085#1086#1087#1082#1091' '#1087#1086#1089#1083#1077' '#1074#1074#1086#1076#1072' '#1091#1088#1072#1074#1085#1077#1085#1080#1103
    Caption = #1043#1086#1090#1086#1074#1086
    TabOrder = 1
    OnClick = OkButtonClick
  end
  object Button1: TButton
    Left = 176
    Top = 136
    Width = 75
    Height = 25
    Caption = #1057#1095#1080#1090#1072#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 344
    Top = 136
    Width = 89
    Height = 21
    TabOrder = 3
  end
  object SpinEdit1: TSpinEdit
    Left = 32
    Top = 136
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object StatusBar3: TStatusBar
    Left = 0
    Top = 167
    Width = 441
    Height = 19
    Hint = #1055#1086#1084#1086#1097#1100
    AutoHint = True
    Panels = <>
    SimplePanel = True
    SimpleText = #1055#1086#1084#1086#1097#1100
  end
end
