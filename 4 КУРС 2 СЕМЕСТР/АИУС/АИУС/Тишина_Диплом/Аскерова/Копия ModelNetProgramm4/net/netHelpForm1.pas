unit netHelpForm1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TnetForm2 = class(TForm)
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  netForm2: TnetForm2;

implementation

{$R *.dfm}

procedure TnetForm2.BitBtn1Click(Sender: TObject);
begin
netForm2.Close;
end;

end.
