unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,Unit4, ExtCtrls;

type
  TForm5 = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    RadioGroup1: TRadioGroup;
    Bevel1: TBevel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit7, Unit8;
  var FName:string;
{$R *.dfm}

procedure TForm5.BitBtn1Click(Sender: TObject);
begin
FName:=edit1.Text;
if edit1.Text='' then begin
ShowMessage('ֲגוהטעו טלÿ פאיכא ');
edit1.SetFocus;exit;
end;
if RadioGroup1.ItemIndex=0 then begin
form4.Show;
form5.Close;
end;
if RadioGroup1.ItemIndex=1 then begin
form7.Show;
form5.Close;
end;
if RadioGroup1.ItemIndex=2 then begin
form8.Show;
form5.Close;
end;
end;

procedure TForm5.BitBtn2Click(Sender: TObject);
begin
close;
end;

end.
