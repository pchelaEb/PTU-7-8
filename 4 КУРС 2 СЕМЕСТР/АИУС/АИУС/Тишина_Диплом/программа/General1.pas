unit General1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, jpeg, ComCtrls;

type
  TGeneralForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    StatusBar1: TStatusBar;
    Button4: TButton;
    Button1: TButton;
    Button2: TButton;
    procedure N1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GeneralForm1: TGeneralForm1;

implementation

uses  General2, General3, General4, netUMain, ptmUMain, Unit1;

{$R *.dfm}

procedure TGeneralForm1.N1Click(Sender: TObject);
begin
GeneralForm2.Show;
end;

procedure TGeneralForm1.Button3Click(Sender: TObject);
begin
Form1.Show();
end;

procedure TGeneralForm1.N2Click(Sender: TObject);
begin
GeneralForm3.Show;
end;

procedure TGeneralForm1.Button4Click(Sender: TObject);
begin
 ptmMain.Show();
end;

procedure TGeneralForm1.Button1Click(Sender: TObject);
begin
netMain.Show();
end;

procedure TGeneralForm1.Button2Click(Sender: TObject);
begin
GeneralForm1.Close;
end;

end.
