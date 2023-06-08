object Main: TMain
  Left = 210
  Top = 125
  Width = 800
  Height = 573
  Caption = #1057#1077#1090#1100' '#1055#1077#1090#1088#1080
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelStorages: TLabel
    Left = 8
    Top = 8
    Width = 80
    Height = 13
    Caption = #1063#1080#1089#1083#1086' '#1087#1086#1079#1080#1094#1080#1081':'
  end
  object LabelBarriers: TLabel
    Left = 172
    Top = 8
    Width = 91
    Height = 13
    Caption = #1063#1080#1089#1083#1086' '#1087#1077#1088#1077#1093#1086#1076#1086#1074':'
  end
  object LabelCapacity: TLabel
    Left = 8
    Top = 36
    Width = 213
    Height = 13
    Caption = #1042#1077#1082#1090#1086#1088' '#1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1099#1093' '#1077#1084#1082#1086#1089#1090#1077#1081' '#1087#1086#1079#1080#1094#1080#1081
  end
  object LabelDelay: TLabel
    Left = 8
    Top = 132
    Width = 255
    Height = 13
    Caption = #1042#1077#1082#1090#1086#1088' '#1074#1088#1077#1084#1077#1085#1085#1099#1093' '#1079#1072#1076#1077#1088#1078#1077#1082' '#1084#1072#1088#1082#1077#1088#1072' '#1074' '#1087#1086#1079#1080#1094#1080#1103#1093
  end
  object LabelActive: TLabel
    Left = 8
    Top = 228
    Width = 202
    Height = 13
    Caption = #1042#1077#1082#1090#1086#1088' '#1085#1072#1095#1072#1083#1100#1085#1086#1081' '#1084#1072#1088#1082#1080#1088#1086#1074#1082#1080' '#1087#1086#1079#1080#1094#1080#1081
  end
  object LabelSleep: TLabel
    Left = 8
    Top = 324
    Width = 291
    Height = 13
    Caption = #1042#1077#1082#1090#1086#1088' '#1074#1088#1077#1084#1077#1085#1085#1099#1093' '#1079#1072#1076#1077#1088#1078#1077#1082' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103' '#1087#1077#1088#1077#1093#1086#1076#1086#1074
  end
  object LabelPriority: TLabel
    Left = 8
    Top = 420
    Width = 159
    Height = 13
    Caption = #1042#1077#1082#1090#1086#1088' '#1087#1088#1080#1086#1088#1080#1090#1077#1090#1086#1074' '#1087#1077#1088#1077#1093#1086#1076#1086#1074
  end
  object LabelIncident: TLabel
    Left = 400
    Top = 34
    Width = 123
    Height = 13
    Caption = #1052#1072#1090#1088#1080#1094#1072' '#1080#1085#1094#1080#1076#1077#1085#1090#1085#1086#1089#1090#1080
  end
  object LabelIngibitor: TLabel
    Left = 400
    Top = 288
    Width = 137
    Height = 13
    Caption = #1052#1072#1090#1088#1080#1094#1072' '#1080#1085#1075#1080#1073#1080#1090#1086#1088#1085#1099#1093' '#1076#1091#1075
  end
  object Label1: TLabel
    Left = 396
    Top = 8
    Width = 73
    Height = 13
    Caption = #1063#1080#1089#1083#1086' '#1094#1074#1077#1090#1086#1074':'
  end
  object SpinStorages: TSpinEdit
    Left = 92
    Top = 4
    Width = 61
    Height = 22
    MaxLength = 4
    MaxValue = 50
    MinValue = 1
    TabOrder = 0
    Value = 1
    OnChange = SpinStoragesChange
  end
  object SpinBarriers: TSpinEdit
    Left = 268
    Top = 4
    Width = 61
    Height = 22
    MaxLength = 4
    MaxValue = 50
    MinValue = 1
    TabOrder = 1
    Value = 1
    OnChange = SpinBarriersChange
  end
  object GridCapacity: TStringGrid
    Left = 8
    Top = 52
    Width = 369
    Height = 69
    ColCount = 50
    DefaultColWidth = 48
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor, goThumbTracking]
    ScrollBars = ssHorizontal
    TabOrder = 2
  end
  object GridDelay: TStringGrid
    Left = 8
    Top = 148
    Width = 369
    Height = 69
    ColCount = 50
    DefaultColWidth = 48
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor, goThumbTracking]
    ScrollBars = ssHorizontal
    TabOrder = 3
  end
  object GridActive: TStringGrid
    Left = 8
    Top = 244
    Width = 369
    Height = 69
    ColCount = 50
    DefaultColWidth = 48
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor, goThumbTracking]
    ScrollBars = ssHorizontal
    TabOrder = 4
  end
  object GridSleep: TStringGrid
    Left = 8
    Top = 340
    Width = 369
    Height = 69
    ColCount = 50
    DefaultColWidth = 48
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor, goThumbTracking]
    ScrollBars = ssHorizontal
    TabOrder = 5
  end
  object GridPriority: TStringGrid
    Left = 8
    Top = 436
    Width = 369
    Height = 69
    ColCount = 50
    DefaultColWidth = 24
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor, goThumbTracking]
    ScrollBars = ssHorizontal
    TabOrder = 6
  end
  object GridIncident: TStringGrid
    Left = 400
    Top = 50
    Width = 369
    Height = 227
    ColCount = 51
    DefaultColWidth = 48
    DefaultRowHeight = 20
    RowCount = 51
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor, goThumbTracking]
    TabOrder = 7
  end
  object GridIngibitor: TStringGrid
    Left = 400
    Top = 304
    Width = 369
    Height = 201
    ColCount = 51
    DefaultColWidth = 48
    DefaultRowHeight = 20
    RowCount = 51
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor, goThumbTracking]
    TabOrder = 8
  end
  object ColorEdit: TSpinEdit
    Left = 476
    Top = 4
    Width = 61
    Height = 22
    MaxLength = 4
    MaxValue = 50
    MinValue = 1
    TabOrder = 9
    Value = 1
    OnChange = SpinBarriersChange
  end
  object MainMenu: TMainMenu
    Left = 336
    object MenuFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object MenuNew: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100
        OnClick = MenuNewClick
      end
      object MenuOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        OnClick = MenuOpenClick
      end
      object MenuSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        OnClick = MenuSaveClick
      end
      object MenuHR1: TMenuItem
        Caption = '-'
      end
      object MenuQuit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = MenuQuitClick
      end
    end
    object MenuDistribution: TMenuItem
      Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077
      object MenuSimple: TMenuItem
        AutoCheck = True
        Caption = #1056#1072#1074#1085#1086#1084#1077#1088#1085#1086#1077
        Checked = True
        GroupIndex = 1
        RadioItem = True
      end
      object MenuNormal: TMenuItem
        AutoCheck = True
        Caption = #1053#1086#1088#1084#1072#1083#1100#1085#1086#1077
        GroupIndex = 1
        RadioItem = True
      end
    end
    object MenuModel: TMenuItem
      Caption = #1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1077
      OnClick = MenuModelClick
    end
    object N1: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N2: TMenuItem
        Caption = #1055#1086#1084#1086#1097#1100
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = N3Click
      end
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'(*.txt)|*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
    Left = 344
    Top = 8
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'(*.txt)|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing, ofDontAddToRecent]
    Left = 356
    Top = 16
  end
end
