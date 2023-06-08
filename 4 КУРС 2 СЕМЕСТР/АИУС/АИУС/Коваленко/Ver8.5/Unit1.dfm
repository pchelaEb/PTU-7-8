object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 207
  Top = 141
  Height = 247
  Width = 339
  object TFacts: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    IndexFieldNames = 'cod_alter'
    MasterFields = 'cod_alter'
    MasterSource = DAlternatives
    TableName = 'Facts'
    Left = 32
    Top = 24
    object TFactscod_fact: TAutoIncField
      Alignment = taLeftJustify
      DisplayLabel = #1050#1086#1076' '#1092#1072#1082#1090#1072
      DisplayWidth = 10
      FieldName = 'cod_fact'
      ReadOnly = True
    end
    object TFactssum_func: TIntegerField
      DisplayLabel = #1057#1091#1084#1084#1072#1088#1085#1099#1081' '#1087#1086#1090#1077#1085#1094#1080#1072#1083' '#1084#1077#1090#1086#1082
      DisplayWidth = 26
      FieldName = 'sum_func'
    end
    object TFactscod_alter: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1088#1077#1096#1077#1085#1080#1103
      DisplayWidth = 15
      FieldName = 'cod_alter'
    end
  end
  object TAlternatives: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'Alternatives'
    Left = 32
    Top = 152
    object TAlternativescod_alter: TAutoIncField
      Alignment = taLeftJustify
      DisplayLabel = #1050#1086#1076' '#1088#1077#1096#1077#1085#1080#1103
      FieldName = 'cod_alter'
      ReadOnly = True
    end
    object TAlternativesalternative: TWideStringField
      DisplayLabel = #1056#1077#1096#1077#1085#1080#1077
      FieldName = 'alternative'
      Size = 50
    end
  end
  object DFacts: TDataSource
    DataSet = TFacts
    Left = 144
    Top = 24
  end
  object DAlternatives: TDataSource
    DataSet = TAlternatives
    Left = 144
    Top = 152
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=admin;Data Source=C:\Do' +
      'cuments and Settings\epo2002_kto\'#1056#1072#1073#1086#1095#1080#1081' '#1089#1090#1086#1083'\Ver8.5\KnowBase.md' +
      'b;Mode=Share Deny None;Extended Properties="";Persist Security I' +
      'nfo=False;Jet OLEDB:System database="";Jet OLEDB:Registry Path="' +
      '";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet OLE' +
      'DB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;J' +
      'et OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Passw' +
      'ord="";Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt ' +
      'Database=False;Jet OLEDB:Don'#39't Copy Locale on Compact=False;Jet ' +
      'OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False'
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 256
    Top = 24
  end
  object TRules: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'Rules'
    Left = 32
    Top = 88
    object TRulescod_rule: TAutoIncField
      Alignment = taLeftJustify
      DisplayLabel = #1050#1086#1076' '#1087#1088#1072#1074#1080#1083#1072
      FieldName = 'cod_rule'
      ReadOnly = True
    end
    object TRulesrule: TWideStringField
      DisplayLabel = #1055#1088#1072#1074#1080#1083#1086
      DisplayWidth = 40
      FieldName = 'rule'
      Size = 50
    end
    object TRulescod_alter: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1088#1077#1096#1077#1085#1080#1103
      FieldName = 'cod_alter'
    end
  end
  object DRules: TDataSource
    DataSet = TRules
    Left = 144
    Top = 88
  end
end
