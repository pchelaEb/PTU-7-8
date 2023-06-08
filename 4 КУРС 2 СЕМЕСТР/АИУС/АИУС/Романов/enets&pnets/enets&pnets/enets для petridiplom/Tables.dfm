object Form1: TForm1
  Left = 271
  Top = 236
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'Tables'
  ClientHeight = 425
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 16
    Top = 216
    Width = 323
    Height = 16
    Caption = #1042#1077#1082#1090#1086#1088' '#1074#1088#1077#1084#1077#1085#1085#1099#1093' '#1079#1072#1076#1077#1088#1078#1077#1082' '#1084#1072#1088#1082#1077#1088#1072' '#1074' '#1087#1086#1079#1080#1094#1080#1103#1093
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 320
    Width = 373
    Height = 16
    Caption = #1042#1077#1082#1090#1086#1088' '#1074#1088#1077#1084#1077#1085#1085#1099#1093' '#1079#1072#1076#1077#1088#1078#1077#1082' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103' '#1087#1077#1088#1077#1093#1086#1076#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 416
    Top = 8
    Width = 170
    Height = 16
    Caption = #1052#1072#1090#1088#1080#1094#1072' '#1080#1085#1094#1080#1085#1076#1077#1085#1090#1085#1086#1089#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 16
    Top = 112
    Width = 262
    Height = 16
    Caption = #1042#1077#1082#1090#1086#1088' '#1085#1072#1095#1072#1083#1100#1085#1086#1081' '#1084#1072#1088#1082#1080#1088#1086#1074#1082#1080' '#1087#1086#1079#1080#1094#1080#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 416
    Top = 320
    Width = 209
    Height = 16
    Caption = #1042#1077#1082#1090#1086#1088' '#1087#1088#1080#1086#1088#1080#1090#1077#1090#1086#1074' '#1087#1077#1088#1077#1093#1086#1076#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 8
    Top = 112
    Width = 393
    Height = 97
    Style = bsRaised
  end
  object Bevel3: TBevel
    Left = 8
    Top = 216
    Width = 393
    Height = 97
    Style = bsRaised
  end
  object Bevel4: TBevel
    Left = 8
    Top = 320
    Width = 393
    Height = 97
    Style = bsRaised
  end
  object Bevel5: TBevel
    Left = 408
    Top = 8
    Width = 393
    Height = 305
    Style = bsRaised
  end
  object Bevel6: TBevel
    Left = 408
    Top = 320
    Width = 393
    Height = 97
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 268
    Height = 16
    Caption = #1042#1077#1082#1090#1086#1088' '#1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1099#1093' '#1077#1084#1082#1086#1089#1090#1077#1081' '#1087#1086#1079#1080#1094#1080#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 393
    Height = 97
    Style = bsRaised
  end
  object GridCapacity: TStringGrid
    Left = 16
    Top = 24
    Width = 377
    Height = 70
    ColCount = 1
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssHorizontal
    TabOrder = 0
  end
  object GridActive: TStringGrid
    Left = 16
    Top = 128
    Width = 377
    Height = 70
    ColCount = 1
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssHorizontal
    TabOrder = 1
  end
  object GridSleep: TStringGrid
    Left = 16
    Top = 336
    Width = 377
    Height = 70
    ColCount = 1
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssHorizontal
    TabOrder = 2
  end
  object GridIncident: TStringGrid
    Left = 416
    Top = 24
    Width = 377
    Height = 278
    ColCount = 2
    RowCount = 2
    TabOrder = 3
  end
  object GridDelay: TStringGrid
    Left = 16
    Top = 232
    Width = 377
    Height = 70
    ColCount = 1
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssHorizontal
    TabOrder = 4
  end
  object GridPriority: TStringGrid
    Left = 416
    Top = 336
    Width = 377
    Height = 70
    ColCount = 1
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssHorizontal
    TabOrder = 5
  end
end
