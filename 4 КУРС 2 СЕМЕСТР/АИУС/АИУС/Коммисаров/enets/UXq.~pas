unit UXq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TParamXq = class(TForm)
    EditKPoz: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    UpDown1: TUpDown;
    Label2: TLabel;
    NazMEd: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure EditKPozKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ParamXq: TParamXq;

implementation

uses UMain, About, UCore, UProp, UView;

{$R *.dfm}

procedure TParamXq.BitBtn1Click(Sender: TObject);
begin

if (ParamXq.EditKPoz.Text<>'') then Close()
else ShowMessage('¬ведите кол-во позиций');
if (ParamXq.NazMEd.Text='') then
else ParamXq.NazMEd.Text:=ParamXq.NazMEd.Text+'_';
end;

procedure TParamXq.EditKPozKeyPress(Sender: TObject; var Key: Char);
begin
if (Key<'0') or (Key>'9') then Key:=#0;
end;

procedure TParamXq.FormShow(Sender: TObject);
begin
ParamXq.EditKPoz.Text:='1';
ParamXq.NazMEd.Text:='';
end;

procedure TParamXq.BitBtn2Click(Sender: TObject);
begin
main.ButtonYc.Down:=False;
main.ButtonXq.Down:=False;

Close();
end;

end.
