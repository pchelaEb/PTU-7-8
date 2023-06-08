unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TForm6 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PrintDialog1: TPrintDialog;
    FontDialog1: TFontDialog;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation
Uses Printers;

{$R *.dfm}

procedure TForm6.BitBtn2Click(Sender: TObject);
begin
form6.Close;
end;

procedure TForm6.BitBtn1Click(Sender: TObject);
begin
form6.Close;
end;

procedure TForm6.BitBtn3Click(Sender: TObject);
 var y,dy,x,k:integer;
   s:string;

begin
    if Memo1.Lines.Count=0 then exit;
    Screen.Cursor:=crHourGlass;
    with Printer do
     Begin
      BeginDoc;
      with Canvas do
      Begin
      Font:=Memo1.Font;
      dy:=TextHeight('1');
      y:=3*dy;
      x:=PageWidth div 15;
         for k:=0  to Memo1.Lines.Count-1 do
           begin
           TextOut(x,y,Memo1.Lines[k]);
           inc(y,dy);
            if PageHeight-y<2*dy then
             begin
               NewPage;
               S:='- '+inttostr(PageNumber)+' -';
               TextOut((PageWidth-TextWidth(s)) div 2,dy,s);
               MoveTo(x,3*dy div 2);
               LineTo(PageWidth-x,9*dy div 4);
               y:=3*dy
              end;
             end;
         end;
         EndDoc;
        end;
        Screen.Cursor:= crDefault;
    end;



end.
