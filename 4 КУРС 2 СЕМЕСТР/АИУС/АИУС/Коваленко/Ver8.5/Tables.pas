unit Tables;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, UCore, Menus;

type
  TForm1 = class(TForm)
    GridCapacity: TStringGrid;
    GridActive: TStringGrid;
    GridSleep: TStringGrid;
    GridIncident: TStringGrid;
    GridDelay: TStringGrid;
    GridPriority: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GridIngibit: TStringGrid;
    Label7: TLabel;
   
      
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses UMain;

{$R *.dfm}





end.
