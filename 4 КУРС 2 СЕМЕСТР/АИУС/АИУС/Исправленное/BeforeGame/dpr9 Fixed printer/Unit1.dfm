object Form1: TForm1
  Left = 331
  Top = 204
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1042#1077#1088#1080#1092#1080#1082#1072#1094#1080#1103' '#1084#1086#1076#1077#1083#1077#1081' '#1085#1072' '#1073#1072#1079#1077' '#1089#1077#1090#1077#1081' '#1055#1077#1090#1088#1080
  ClientHeight = 444
  ClientWidth = 593
  Color = clInactiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 64
    Width = 569
    Height = 41
    Align = alCustom
    Alignment = taCenter
    Caption = #1042#1077#1088#1080#1092#1080#1082#1072#1094#1080#1103' '#1084#1086#1076#1077#1083#1077#1081' '#1085#1072' '#1073#1072#1079#1077' '#1089#1077#1090#1077#1081' '#1055#1077#1090#1088#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Garamond'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 288
    Top = 296
    Width = 270
    Height = 24
    Caption = #1042#1086#1083#1086#1075#1086#1076#1089#1082#1080#1081' '#1043#1086#1089#1091#1076#1072#1088#1089#1090#1074#1077#1085#1085#1099#1081
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Garamond'
    Font.Style = []
    ParentFont = False
    Transparent = False
  end
  object Label3: TLabel
    Left = 288
    Top = 320
    Width = 231
    Height = 24
    Caption = #1058#1077#1093#1085#1080#1095#1077#1089#1082#1080#1081' '#1059#1085#1080#1074#1077#1088#1089#1080#1090#1077#1090
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Garamond'
    Font.Style = []
    ParentFont = False
    Transparent = False
  end
  object Label4: TLabel
    Left = 376
    Top = 368
    Width = 57
    Height = 24
    Caption = '2004 '#1075'.'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Garamond'
    Font.Style = []
    ParentFont = False
    Transparent = False
  end
  object MainMenu1: TMainMenu
    Left = 16
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1053#1072#1095#1072#1090#1100' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077
        OnClick = N2Click
      end
      object N7: TMenuItem
        Caption = '-'
        OnClick = N7Click
      end
      object N3: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N3Click
      end
    end
    object N8: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      OnClick = N8Click
    end
    object N9: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnClick = N9Click
    end
  end
end
