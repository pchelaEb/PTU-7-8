unit UAmount;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, TeEngine, TeeFunci, Series, ExtCtrls, TeeProcs, Chart, StdCtrls;


type
	TAmount = class(TForm)
	StgCount: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Series7: TLineSeries;
    Series8: TLineSeries;
    Series9: TLineSeries;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;

	procedure FormClose(Sender: TObject; var Action: TCloseAction);
end;


implementation

{$R *.dfm}


procedure TAmount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


end.
