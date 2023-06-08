unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls,Unit2,Unit4, jpeg;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N3: TMenuItem;
    Image1: TImage;
    procedure N6Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
 Uses Unit5, Unit10;
{$R *.dfm}

procedure TForm1.N6Click(Sender: TObject);
begin
form1.Close;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
aboutbox.Show;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
form1.Close;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
 form5.Show;
 form5.Edit1.Text:='Model1';
end;

procedure TForm1.N3Click(Sender: TObject);
begin
form1.Close;
end;

procedure TForm1.N8Click(Sender: TObject);

begin

form10.show;

end;

end.
