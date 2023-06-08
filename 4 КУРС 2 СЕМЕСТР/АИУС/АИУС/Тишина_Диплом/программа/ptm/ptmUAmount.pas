unit ptmUAmount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, TeeFunci, Series, ExtCtrls, TeeProcs, Chart;


type
  TptmAmount = class(TForm)
    StgCount: TChart;
    SeriesActive: TLineSeries;
    SeriesPassive: TLineSeries;
    SeriesTotal: TLineSeries;
    Series1: TLineSeries;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;


implementation

{$R *.dfm}


procedure TptmAmount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


end.
