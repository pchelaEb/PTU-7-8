unit ptmUAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TptmAbout = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    CloseAbout: TButton;

    procedure CloseAboutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ptmAbout: TptmAbout;

implementation

{$R *.dfm}



procedure TptmAbout.CloseAboutClick(Sender: TObject);
begin
ptmAbout.Close;
end;

end.
