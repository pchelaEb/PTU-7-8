object Form1: TForm1
  Left = 19
  Top = 122
  Width = 809
  Height = 578
  Caption = #1040#1085#1072#1083#1080#1079' '#1057#1077#1090#1077#1081' '#1055#1077#1090#1088#1080
  Color = clInfoBk
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Lucida Console'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 11
  object GroupBox1: TGroupBox
    Left = 3
    Top = 0
    Width = 266
    Height = 233
    Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1057#1077#1090#1080
    Color = clInfoBk
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 31
      Width = 83
      Height = 14
      Caption = #1063#1080#1089#1083#1086' '#1087#1086#1079#1080#1094#1080#1081' '#1056
    end
    object Label2: TLabel
      Left = 8
      Top = 63
      Width = 97
      Height = 14
      Caption = #1063#1080#1089#1083#1086' '#1087#1077#1088#1077#1093#1086#1076#1086#1074' '#1058
    end
    object Label3: TLabel
      Left = 35
      Top = 92
      Width = 136
      Height = 14
      Caption = #1052#1072#1090#1088#1080#1094#1072' '#1080#1085#1094#1080#1076#1077#1085#1090#1085#1086#1089#1090#1080' A'
    end
    object Edit1: TEdit
      Left = 136
      Top = 29
      Width = 73
      Height = 22
      ReadOnly = True
      TabOrder = 0
      Text = '1'
      OnChange = Edit1Change
    end
    object UpDown1: TUpDown
      Left = 209
      Top = 29
      Width = 17
      Height = 22
      Associate = Edit1
      Min = 1
      Max = 50
      Position = 1
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 136
      Top = 60
      Width = 73
      Height = 22
      ReadOnly = True
      TabOrder = 2
      Text = '1'
      OnChange = Edit2Change
    end
    object UpDown2: TUpDown
      Left = 209
      Top = 60
      Width = 17
      Height = 22
      Associate = Edit2
      Min = 1
      Max = 50
      Position = 1
      TabOrder = 3
    end
    object StringGrid1: TStringGrid
      Left = 16
      Top = 109
      Width = 229
      Height = 108
      ColCount = 2
      Ctl3D = False
      DefaultColWidth = 30
      DefaultRowHeight = 20
      FixedColor = clInactiveCaptionText
      RowCount = 2
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 4
    Top = 236
    Width = 264
    Height = 85
    Caption = #1042#1077#1082#1090#1086#1088' '#1085#1072#1095#1072#1083#1100#1085#1086#1081' '#1084#1072#1088#1082#1080#1088#1086#1074#1082#1080' M0'
    Color = clInfoBk
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object StringGrid2: TStringGrid
      Left = 17
      Top = 13
      Width = 224
      Height = 68
      ColCount = 1
      Ctl3D = False
      DefaultColWidth = 30
      DefaultRowHeight = 20
      FixedColor = clInactiveCaptionText
      FixedCols = 0
      RowCount = 2
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox4: TGroupBox
    Left = 4
    Top = 320
    Width = 785
    Height = 217
    Caption = #1054#1073#1085#1072#1088#1091#1078#1077#1085#1080#1077' '#1080' '#1080#1079#1086#1083#1103#1094#1080#1103' '#1086#1096#1080#1073#1086#1082
    Color = clInfoBk
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    object Panel1: TPanel
      Left = 16
      Top = 16
      Width = 377
      Height = 193
      BevelOuter = bvNone
      BorderWidth = 1
      BorderStyle = bsSingle
      Color = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object Label41: TLabel
        Left = 10
        Top = 5
        Width = 70
        Height = 14
        Caption = #1063#1080#1089#1083#1086' '#1096#1072#1075#1086#1074': '
        Color = clInfoBk
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label44: TLabel
        Left = 208
        Top = 8
        Width = 127
        Height = 22
        Caption = 'dTk=Mk-M0-Vk'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label45: TLabel
        Left = 10
        Top = 21
        Width = 60
        Height = 14
        Caption = #1052#1072#1090#1088#1080#1094#1072' Vk'
        Color = clInfoBk
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label46: TLabel
        Left = 10
        Top = 74
        Width = 60
        Height = 14
        Caption = #1052#1072#1090#1088#1080#1094#1072' Mk'
        Color = clInfoBk
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label47: TLabel
        Left = 10
        Top = 130
        Width = 64
        Height = 14
        Caption = #1052#1072#1090#1088#1080#1094#1072' dTk'
        Color = clInfoBk
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label49: TLabel
        Left = 216
        Top = 56
        Width = 122
        Height = 16
        Caption = #1054#1096#1080#1073#1082#1080' '#1074' '#1087#1086#1079#1080#1094#1080#1103#1093':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label48: TLabel
        Left = 272
        Top = 75
        Width = 4
        Height = 18
        Alignment = taCenter
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Button2: TButton
        Left = 216
        Top = 119
        Width = 137
        Height = 33
        Caption = #1052#1077#1090#1086#1076' 1'
        TabOrder = 0
        OnClick = Button2Click
      end
      object Edit3: TEdit
        Left = 94
        Top = 3
        Width = 81
        Height = 20
        TabOrder = 1
        Text = '1'
      end
      object UpDown3: TUpDown
        Left = 175
        Top = 3
        Width = 16
        Height = 20
        Associate = Edit3
        Min = 1
        Position = 1
        TabOrder = 2
      end
      object StringGrid3: TStringGrid
        Left = 8
        Top = 34
        Width = 157
        Height = 41
        Ctl3D = False
        DefaultColWidth = 30
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
      end
      object StringGrid4: TStringGrid
        Left = 8
        Top = 88
        Width = 157
        Height = 41
        Ctl3D = False
        DefaultColWidth = 30
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 4
      end
      object StringGrid8: TStringGrid
        Left = 8
        Top = 144
        Width = 157
        Height = 41
        Ctl3D = False
        DefaultColWidth = 30
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 5
      end
    end
    object Panel2: TPanel
      Left = 392
      Top = 16
      Width = 385
      Height = 193
      BorderStyle = bsSingle
      Color = clInfoBk
      Ctl3D = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      object Label50: TLabel
        Left = 10
        Top = 10
        Width = 112
        Height = 13
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1085#1077#1095#1085#1091#1102
        Color = clInfoBk
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label51: TLabel
        Left = 44
        Top = 24
        Width = 67
        Height = 14
        Caption = ' '#1084#1072#1088#1082#1080#1088#1086#1074#1082#1091':'
      end
      object Label52: TLabel
        Left = 23
        Top = 76
        Width = 131
        Height = 22
        Caption = 'dSk=Bf(Mk-M0)'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label53: TLabel
        Left = 234
        Top = 73
        Width = 140
        Height = 16
        AutoSize = False
        Caption = #1054#1096#1080#1073#1082#1080' '#1074' '#1087#1086#1079#1080#1094#1080#1103#1093':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label54: TLabel
        Left = 26
        Top = 98
        Width = 67
        Height = 13
        Caption = #1042#1077#1082#1090#1086#1088' dSk'
        Color = clInfoBk
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label55: TLabel
        Left = 249
        Top = 93
        Width = 4
        Height = 16
        Alignment = taCenter
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Button3: TButton
        Left = 256
        Top = 120
        Width = 111
        Height = 33
        Caption = #1052#1077#1090#1086#1076' 2'
        TabOrder = 0
        OnClick = Button3Click
      end
      object StringGrid9: TStringGrid
        Left = 145
        Top = 5
        Width = 224
        Height = 68
        ColCount = 1
        Ctl3D = False
        DefaultColWidth = 30
        DefaultRowHeight = 20
        FixedColor = clInactiveCaptionText
        FixedCols = 0
        RowCount = 2
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
      end
      object StringGrid10: TStringGrid
        Left = 128
        Top = 96
        Width = 57
        Height = 89
        ColCount = 1
        Ctl3D = False
        DefaultColWidth = 30
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        ParentCtl3D = False
        TabOrder = 2
      end
    end
  end
  object GroupBox3: TGroupBox
    Left = 279
    Top = 40
    Width = 509
    Height = 281
    Caption = #1040#1085#1072#1083#1080#1079' '#1089#1090#1088#1091#1082#1090#1091#1088#1085#1099#1093' '#1089#1074#1086#1081#1089#1090#1074' '#1089#1077#1090#1080
    Color = clInfoBk
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    object Label5: TLabel
      Left = 7
      Top = 226
      Width = 220
      Height = 14
      Caption = '5. '#1059#1087#1088#1072#1074#1083#1103#1077#1084#1086#1089#1090#1100' (rank A='#1095#1080#1089#1083#1091' '#1087#1086#1079#1080#1094#1080#1081') '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 10
      Top = 26
      Width = 58
      Height = 14
      Caption = #1052#1072#1090#1088#1080#1094#1072' Bf'
      Color = clInfoBk
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label10: TLabel
      Left = 424
      Top = 224
      Width = 3
      Height = 14
      Color = clInfoBk
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label17: TLabel
      Left = 204
      Top = 25
      Width = 55
      Height = 14
      Caption = #1052#1072#1090#1088#1080#1094#1072' Y'
      Color = clInfoBk
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 284
      Top = 26
      Width = 54
      Height = 14
      Caption = #1052#1072#1090#1088#1080#1094#1072' X'
      Color = clInfoBk
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel
      Left = 7
      Top = 162
      Width = 302
      Height = 14
      Caption = '1. '#1057#1090#1088#1091#1082#1090#1091#1088#1085#1072#1103' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1085#1086#1089#1090#1100' ( '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090' y>0, Ay<=0) '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 7
      Top = 178
      Width = 244
      Height = 14
      Caption = '2. '#1050#1086#1085#1089#1077#1088#1074#1072#1090#1080#1074#1085#1086#1089#1090#1100' ( '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090' y>0, Ay=0) '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 7
      Top = 194
      Width = 236
      Height = 14
      Caption = '3. '#1055#1086#1074#1090#1086#1088#1103#1077#1084#1086#1089#1090#1100' ( '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090' x>0, A x>=0) '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 7
      Top = 210
      Width = 258
      Height = 14
      Caption = '4. '#1055#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086#1089#1090#1100' ( '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090' x>0, A x=0) '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 431
      Top = 123
      Width = 3
      Height = 14
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 426
      Top = 163
      Width = 3
      Height = 14
      Color = clInfoBk
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label14: TLabel
      Left = 426
      Top = 180
      Width = 3
      Height = 14
      Color = clInfoBk
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label15: TLabel
      Left = 427
      Top = 195
      Width = 3
      Height = 14
      Color = clInfoBk
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label16: TLabel
      Left = 427
      Top = 211
      Width = 3
      Height = 14
      Color = clInfoBk
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label18: TLabel
      Left = 365
      Top = 72
      Width = 31
      Height = 24
      Caption = #1040'= '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 394
      Top = 33
      Width = 18
      Height = 72
      Caption = '['
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -64
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 466
      Top = 34
      Width = 18
      Height = 72
      Caption = ']'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -64
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 415
      Top = 46
      Width = 8
      Height = 14
      Caption = #1040
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 426
      Top = 54
      Width = 12
      Height = 14
      Caption = '11'
    end
    object Label23: TLabel
      Left = 444
      Top = 46
      Width = 8
      Height = 14
      Caption = #1040
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 455
      Top = 54
      Width = 12
      Height = 14
      Caption = '12'
    end
    object Label25: TLabel
      Left = 415
      Top = 86
      Width = 8
      Height = 14
      Caption = #1040
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 426
      Top = 94
      Width = 12
      Height = 14
      Caption = '21'
    end
    object Label27: TLabel
      Left = 445
      Top = 86
      Width = 8
      Height = 14
      Caption = #1040
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label28: TLabel
      Left = 456
      Top = 94
      Width = 12
      Height = 14
      Caption = '22'
    end
    object Label29: TLabel
      Left = 16
      Top = 139
      Width = 130
      Height = 22
      Caption = 'Bf = [I] - A  (A  )'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label30: TLabel
      Left = 100
      Top = 150
      Width = 12
      Height = 14
      Caption = '11'
    end
    object Label31: TLabel
      Left = 128
      Top = 150
      Width = 12
      Height = 14
      Caption = '12'
    end
    object Label32: TLabel
      Left = 102
      Top = 136
      Width = 6
      Height = 14
      Caption = 'T'
    end
    object Label33: TLabel
      Left = 129
      Top = 136
      Width = 6
      Height = 14
      Caption = 'T'
    end
    object Label34: TLabel
      Left = 144
      Top = 134
      Width = 10
      Height = 14
      Caption = '-1'
    end
    object Label35: TLabel
      Left = 367
      Top = 122
      Width = 47
      Height = 14
      Caption = 'rank A =  '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label36: TLabel
      Left = 9
      Top = 243
      Width = 121
      Height = 14
      Caption = '6. S-'#1080#1085#1074#1072#1088#1080#1072#1085#1090' (Ay = 0)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label37: TLabel
      Left = 9
      Top = 259
      Width = 123
      Height = 14
      Caption = '7. T-'#1080#1085#1074#1072#1088#1080#1072#1085#1090' (A x = 0)'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label38: TLabel
      Left = 230
      Top = 191
      Width = 6
      Height = 14
      Caption = 'T'
    end
    object Label39: TLabel
      Left = 266
      Top = 208
      Width = 6
      Height = 14
      Caption = 'T'
    end
    object Label40: TLabel
      Left = 113
      Top = 255
      Width = 6
      Height = 14
      Caption = 'T'
    end
    object Label42: TLabel
      Left = 221
      Top = 244
      Width = 3
      Height = 14
      Color = clInfoBk
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label43: TLabel
      Left = 221
      Top = 260
      Width = 3
      Height = 14
      Color = clInfoBk
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object StringGrid5: TStringGrid
      Left = 12
      Top = 43
      Width = 181
      Height = 86
      Ctl3D = False
      DefaultColWidth = 30
      DefaultRowHeight = 20
      FixedCols = 0
      RowCount = 3
      FixedRows = 0
      ParentCtl3D = False
      TabOrder = 0
    end
    object StringGrid6: TStringGrid
      Left = 208
      Top = 40
      Width = 57
      Height = 107
      ColCount = 1
      Ctl3D = False
      DefaultColWidth = 30
      DefaultRowHeight = 20
      FixedCols = 0
      FixedRows = 0
      ParentCtl3D = False
      TabOrder = 1
    end
    object Button1: TButton
      Left = 360
      Top = 248
      Width = 137
      Height = 27
      Caption = #1040#1085#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1089#1077#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button1Click
    end
    object StringGrid7: TStringGrid
      Left = 291
      Top = 41
      Width = 54
      Height = 107
      ColCount = 1
      Ctl3D = False
      DefaultColWidth = 30
      DefaultRowHeight = 20
      FixedCols = 0
      FixedRows = 0
      ParentCtl3D = False
      TabOrder = 3
    end
  end
  object GroupBox5: TGroupBox
    Left = 279
    Top = 0
    Width = 508
    Height = 41
    Caption = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074' '#1072#1085#1072#1083#1080#1079#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label56: TLabel
      Left = 16
      Top = 16
      Width = 64
      Height = 14
      Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072': '
    end
    object Edit4: TEdit
      Left = 104
      Top = 13
      Width = 361
      Height = 22
      TabOrder = 0
      Text = 'results.txt'
    end
    object Button4: TButton
      Left = 470
      Top = 14
      Width = 25
      Height = 19
      Caption = '...'
      TabOrder = 1
      OnClick = Button4Click
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 647
    Top = 64
  end
end
