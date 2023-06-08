unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, Series, ComCtrls, ToolWin,
  ImgList;

type
  TGraf = class(TForm)
    Chart1: TChart;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ImageList1: TImageList;
    PrintDialog1: TPrintDialog;
    Series1: TBarSeries;
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Graf: TGraf;

implementation

{$R *.dfm}

procedure TGraf.ToolButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TGraf.ToolButton1Click(Sender: TObject);
begin
  if not PrintDialog1.Execute then Exit;
  Chart1.Print;
end;

end.
