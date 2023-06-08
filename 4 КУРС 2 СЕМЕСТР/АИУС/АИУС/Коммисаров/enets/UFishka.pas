unit UFishka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UCore,UMain, About, UProp, UView, UXq, Buttons;

type
  TFishka = class(TForm)
    EP1: TEdit;
    LP1: TLabel;
    EP2: TEdit;
    LP2: TLabel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    m_node : TNode;
    { Public declarations }
  end;

var
  Fishka: TFishka;
  Prop : TProp;

implementation

//uses ;

{$R *.dfm}

procedure TFishka.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TFishka.FormShow(Sender: TObject);
begin
//m_node.Invalidate;
//Fishka.EP1.Text:= Prop.EditName.Text;
// m_node.m_Name;
end;

end.
