object GeneralForm1: TGeneralForm1
  Left = 702
  Top = 226
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 
    #1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1077#1090#1077#1074#1099#1093' '#1091#1089#1090#1088#1086#1081#1089#1090#1074' '#1085#1072' '#1073#1072#1079#1077' '#1085#1077#1095#1077#1090#1082#1086#1075#1086' '#1072#1087#1087#1072#1088#1072#1090#1072' '#1089#1077#1090#1077#1081 +
    ' '#1055#1077#1090#1088#1080
  ClientHeight = 99
  ClientWidth = 600
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 80
    Width = 600
    Height = 19
    Panels = <>
  end
  object Button4: TButton
    Left = 80
    Top = 24
    Width = 169
    Height = 25
    Caption = #1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1077#1090#1080
    DragCursor = crHandPoint
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsUnderline]
    ParentFont = False
    TabOrder = 1
    OnClick = Button4Click
  end
  object Button1: TButton
    Left = 347
    Top = 26
    Width = 169
    Height = 25
    Caption = #1043#1088#1072#1092#1080#1095#1077#1089#1082#1080#1081' '#1088#1077#1076#1072#1082#1090#1086#1088
    DragCursor = crHandPoint
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsUnderline]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    object N1: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnClick = N2Click
    end
  end
  object XPManifest1: TXPManifest
    Top = 32
  end
end
