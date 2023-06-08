unit General4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TGeneralForm4 = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    RadioGroup1: TRadioGroup;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GeneralForm4: TGeneralForm4;

implementation

{$R *.dfm}

procedure TGeneralForm4.BitBtn2Click(Sender: TObject);
begin
GeneralForm4.Close;
end;

procedure TGeneralForm4.BitBtn1Click(Sender: TObject);
begin
if RadioGroup1.ItemIndex=0 then begin
WinExec(PChar('Color_NET/PetriM.exe'), SW_ShowNormal);
Generalform4.Close;
end;
if RadioGroup1.ItemIndex=1 then begin
WinExec(PChar('GPSS_NET/Enets.exe'), SW_ShowNormal);
Generalform4.Close;
end;



end;

end.
