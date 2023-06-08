object Knowledge: TKnowledge
  Left = 604
  Top = 241
  Width = 461
  Height = 661
  Caption = #1041#1072#1079#1072' '#1079#1085#1072#1085#1080#1081
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
    Left = 24
    Top = 16
    Width = 85
    Height = 16
    Caption = #1041#1072#1079#1072' '#1092#1072#1082#1090#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 400
    Width = 93
    Height = 16
    Caption = #1041#1072#1079#1072' '#1088#1077#1096#1077#1085#1080#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 224
    Width = 84
    Height = 16
    Caption = #1041#1072#1079#1072' '#1087#1088#1072#1074#1080#1083
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DBFacts: TDBGrid
    Left = 16
    Top = 40
    Width = 353
    Height = 153
    Align = alCustom
    Constraints.MaxWidth = 355
    DataSource = DataModule1.DFacts
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'cod_fact'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sum_func'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cod_alter'
        Visible = True
      end>
  end
  object DBAlternatives: TDBGrid
    Left = 16
    Top = 424
    Width = 415
    Height = 129
    Constraints.MaxWidth = 415
    DataSource = DataModule1.DAlternatives
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'cod_alter'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'alternative'
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 184
    Top = 584
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = Button1Click
  end
  object DBRules: TDBGrid
    Left = 16
    Top = 248
    Width = 420
    Height = 121
    Align = alCustom
    Constraints.MaxWidth = 420
    DataSource = DataModule1.DRules
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'cod_rule'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'rule'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cod_alter'
        Visible = True
      end>
  end
end
