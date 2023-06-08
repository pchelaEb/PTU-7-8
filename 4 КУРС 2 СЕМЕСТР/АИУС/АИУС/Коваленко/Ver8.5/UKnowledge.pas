unit UKnowledge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids;

type
  TKnowledge = class(TForm)
    DBFacts: TDBGrid;
    DBRules: TDBGrid;
    DBAlternatives: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Knowledge: TKnowledge;

implementation

{$R *.dfm}

procedure TKnowledge.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
