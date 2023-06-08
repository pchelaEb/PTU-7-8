unit General2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TGeneralForm2 = class(TForm)
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GeneralForm2: TGeneralForm2;

implementation

{$R *.dfm}

procedure TGeneralForm2.BitBtn1Click(Sender: TObject);
begin
GeneralForm2.Close;
end;

procedure TGeneralForm2.Memo1Change(Sender: TObject);
begin
memo1.Lines.LoadFromFile('help.txt');
end;

end.
 