unit Unit1;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataModule1 = class(TDataModule)
    TAlternatives: TADOTable;
    DFacts: TDataSource;
    DAlternatives: TDataSource;
    ADOConnection1: TADOConnection;
    TRules: TADOTable;
    DRules: TDataSource;
    TFactscod_fact: TAutoIncField;
    TFactssum_func: TIntegerField;
    TFactscod_alter: TIntegerField;
    TRulescod_rule: TAutoIncField;
    TRulesrule: TWideStringField;
    TRulescod_alter: TIntegerField;
    TAlternativescod_alter: TAutoIncField;
    TAlternativesalternative: TWideStringField;
    TFacts: TADOTable;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}


end.
