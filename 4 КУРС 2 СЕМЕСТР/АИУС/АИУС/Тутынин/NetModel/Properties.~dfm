object Settings_Form: TSettings_Form
  Left = 413
  Top = 170
  Width = 375
  Height = 410
  AlphaBlend = True
  BorderIcons = [biSystemMenu]
  Caption = 'Settings_Form'
  Color = clBtnFace
  TransparentColorValue = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object TabSettings: TTabControl
    Left = 0
    Top = 0
    Width = 367
    Height = 383
    Align = alClient
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 0
    Tabs.Strings = (
      #1057#1077#1090#1077#1074#1099#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      #1056#1072#1073#1086#1095#1072#1103' '#1089#1090#1072#1085#1094#1080#1103
      #1050#1086#1084#1084#1091#1090#1072#1090#1086#1088)
    TabIndex = 0
    OnChange = TabSettingsChange
    object Common: TPanel
      Left = -8
      Top = 19
      Width = 369
      Height = 352
      Align = alCustom
      BevelOuter = bvNone
      TabOrder = 0
      OnClick = CommonClick
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 25
        Height = 13
        Caption = #1048#1084#1103':'
      end
      object Label3: TLabel
        Left = 8
        Top = 40
        Width = 114
        Height = 13
        Caption = #1057#1077#1090#1077#1074#1099#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      end
      object connects: TStringGrid
        Left = 8
        Top = 64
        Width = 345
        Height = 249
        ColCount = 2
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 2
        TabOrder = 0
        ColWidths = (
          171
          157)
      end
      object Del_Connect: TButton
        Left = 8
        Top = 320
        Width = 345
        Height = 25
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
        TabOrder = 1
        OnClick = Del_ConnectClick
      end
    end
    object WS_Settings: TPanel
      Left = 4
      Top = 27
      Width = 359
      Height = 352
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object TraficSpeed: TRadioGroup
        Left = 8
        Top = 8
        Width = 345
        Height = 105
        Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1087#1077#1088#1077#1076#1072#1095#1080
        Items.Strings = (
          #1053#1080#1079#1082#1072#1103
          #1057#1088#1077#1076#1085#1103#1103
          #1042#1099#1089#1086#1082#1072#1103)
        TabOrder = 0
      end
      object TraficSync: TRadioGroup
        Left = 8
        Top = 120
        Width = 345
        Height = 89
        Caption = #1063#1091#1074#1089#1090#1074#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1082' '#1079#1072#1076#1077#1088#1078#1082#1072#1084
        Items.Strings = (
          #1040#1089#1080#1085#1093#1088#1086#1085#1085#1072#1103' '#1087#1077#1088#1077#1076#1072#1095#1072
          #1057#1080#1085#1093#1088#1086#1085#1085#1072#1103' '#1087#1077#1088#1077#1076#1072#1095#1072)
        TabOrder = 1
      end
      object TraficErrors: TRadioGroup
        Left = 8
        Top = 216
        Width = 345
        Height = 89
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1096#1080#1073#1086#1082
        Items.Strings = (
          #1054#1096#1080#1073#1082#1080' '#1085#1077' '#1076#1086#1087#1091#1089#1090#1080#1084#1099
          #1054#1096#1080#1073#1082#1080' '#1076#1086#1087#1091#1089#1090#1080#1084#1099)
        TabOrder = 2
      end
      object NeedAnswer: TCheckBox
        Left = 8
        Top = 312
        Width = 137
        Height = 17
        Caption = #1054#1090#1087#1088#1072#1074#1083#1103#1090#1100' '#1086#1090#1074#1077#1090
        TabOrder = 3
      end
    end
    object S_settings: TPanel
      Left = -8
      Top = 32
      Width = 369
      Height = 353
      BevelOuter = bvNone
      TabOrder = 2
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 208
        Height = 13
        Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1081
      end
      object Label4: TLabel
        Left = 8
        Top = 56
        Width = 142
        Height = 13
        Caption = #1048#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1081
      end
      object Label5: TLabel
        Left = 8
        Top = 216
        Width = 77
        Height = 13
        Caption = #1044#1083#1080#1085#1072' '#1086#1095#1077#1088#1077#1076#1080
      end
      object max_cons: TEdit
        Left = 8
        Top = 24
        Width = 209
        Height = 21
        BevelOuter = bvRaised
        ReadOnly = True
        TabOrder = 0
        Text = '0'
      end
      object inUse_cons: TEdit
        Left = 8
        Top = 72
        Width = 209
        Height = 21
        ReadOnly = True
        TabOrder = 1
        Text = 'inUse_cons'
      end
      object UpDownCons: TUpDown
        Left = 217
        Top = 24
        Width = 15
        Height = 21
        Associate = max_cons
        TabOrder = 2
      end
      object Queue: TRadioGroup
        Left = 8
        Top = 104
        Width = 361
        Height = 105
        Caption = #1040#1083#1075#1086#1088#1080#1090#1084' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1103' '#1086#1095#1077#1088#1077#1076#1077#1081
        Enabled = False
        ItemIndex = 0
        Items.Strings = (
          #1055#1088#1080#1086#1088#1080#1090#1077#1090#1085#1086#1077' '#1087#1086#1076#1072#1074#1083#1103#1102#1097#1077#1077' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077)
        TabOrder = 3
      end
      object QueLen: TEdit
        Left = 8
        Top = 232
        Width = 209
        Height = 21
        ReadOnly = True
        TabOrder = 4
        Text = '1'
      end
      object UpDownQueue: TUpDown
        Left = 217
        Top = 232
        Width = 15
        Height = 21
        Associate = QueLen
        Min = 1
        Position = 1
        TabOrder = 5
      end
    end
  end
end
