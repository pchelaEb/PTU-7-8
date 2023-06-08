unit Uravn;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Spin, Menus, Math, ComCtrls;

const
  cmx=-1;
  cmneg=-2;
  cmadd=-3;
  cmsub=-4;
  cmmult=-5;
  cmdiv=-6;
  cmsin=-7;
  cmcos=-8;
  cmtg=-9;
  cmctg=-10;
  cmasin=-11;
  cmacos=-12;
  cmatg=-13;
  cmactg=-14;
  cmlg=-15;
  cmpower=-16;
  cmln=-17;
  cmkor=-18;
  cmstop=-20;
  stroka='0123456789';
type
  arr=array[0..30] of real;
  CStr60=string[60];
  CStr80=string[80];
  CStr10=string[10];
  CStr1=string[1];
  CStr2=string[2];
  CStr3=string[3];

//  arr=array[1..30] of real;
  //CStr20=string[20];
  TFormUravnenie = class(TForm)
    Metka1: TLabel;
    Metka2: TLabel;
    Metka3: TLabel;
    EditUravn: TEdit;
    OkButton: TButton;
    Button1: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    StatusBar3: TStatusBar;
    procedure OkButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Close(Sender: TObject; var Action: TCloseAction);
  public
    function  calculate (xx: Extended): real;
  private
    function   Digit(chh: char): boolean;
    procedure  main;
    procedure  Equation(Eqq: arr);
    procedure  Error ( mes: CStr60);
    procedure  Nextch;
    procedure  Resettext;
    procedure  Realnumber(var num : real);
    procedure  Gen (xx: real);
    procedure  Givestfunc (var f: integer);
    procedure  stFunc;
    procedure  Factory (Eqq: arr;mes: CStr60);
    function  GiveOp: char;
    procedure  Addent (Eqq: Arr);
    procedure  analis (Eqq: Arr);
    function  power (xx: real; k: integer): real;

  end;

var
  FormUravnenie: TFormUravnenie;
  s: CStr80;
  ch,Op: char;
  x1, fl: real;
  num: real;
  Errpos, t11, cn: integer;
  Pc: integer;
  Eq: arr;

implementation

{$R *.dfm}
uses ClassModule;

function TFormUravnenie.Digit(chh: char):boolean;
var j: integer;
begin
 for j:=1 to 10 do
  if (chh=stroka[j]) then
  begin
   result:=true;
   Exit;
  end;
 result:=false;
end;

procedure TFormUravnenie.Error(mes: CStr60);
begin
 if (Errpos=0) then
  begin
   t11:=t11+2;
   Beep;
   Showmessage(mes);
   Errpos:=t11;
   //ch:='';
  end;
  FormUravnenie.EditUravn.Clear;
  main;
end;

procedure TFormUravnenie.Nextch;
begin
 if(Errpos<>0) then
  ch:=chr(0)
 else
  begin
   repeat
    begin
     t11:=t11+1;
     if (t11<=Length(s)) then
      ch:=s[t11]
     else begin
      ch:=chr(0);
      break;
     end;
    end;
   until (ch<>' ');
  end;
end;

procedure  TFormUravnenie.Resettext;
begin
 s:=FormUravnenie.EditUravn.Text;
 TrimRight(s);
 //ShowMessage(s);
 t11:=0;
 Nextch;
end;

procedure  TFormUravnenie.Realnumber(var num : real);
var
 n: real;
 prr: boolean;
 k, t: integer;
begin
 prr:= Digit(ch);
 if (prr=false) then begin
  Error ('Ожидается цифра.');
  Exit;
 end
 else
  begin
  num:=StrToFloat(ch);
  Nextch;
  end;
  prr:= Digit(ch);
  while (prr=true) do
  begin
   num:=10*num+StrToFloat(ch);
   Nextch;
   prr:= Digit(ch);
  end;
  if (ch='.') then
  begin
   Nextch;
   prr:= Digit(ch);
   if (prr=false) then begin
    Error ('Ожидается цифра.');
    Exit;
   end 
   else
   begin
    num:=num+StrToFloat(ch)/10.0;
    Nextch;
   end;
   prr:= Digit(ch);
   k:=1;
   n:=0;
   while(prr=true) do
   begin
    k:=k+1;
    n:=StrToFloat(ch);
    for t:=1 to (k-1) do
     n:=n/10.0;
    num:=num+n;
    Nextch;
    prr:= Digit(ch);
   end;
  end;
end;

procedure  TFormUravnenie.Gen (xx: real);
begin
//Showmessage(FloattoStr(xx));
 Eq[Pc]:=xx;
 Pc:=Pc+1;
end;

procedure TFormUravnenie.Givestfunc (var f: integer);
var s1,s2,s3,s4,s5: string;
//var    s2:PChar;
  c,d,r : integer;
begin
 d:=0;
 r:=0;
 Setlength(s1,3);Setlength(s2,1);Setlength(s3,2);Setlength(s4,3);Setlength(s5,3);
 //s1:='';s2:='';s3:='';s4:='';s5:='';
 s2[1]:=ch;
 strCopy(PChar(s1),PChar(s2));
 Nextch;
 s2[1]:=ch;
 strCat(PChar(s1),PChar(s2));
 s3[1]:='t';
 s3[2]:='g';
 c:=strComp(PChar(s1),PChar(s3));
 if (c=0) then
 begin
  f:=cmtg; d:=1; r:=1;Exit;
 end;
 s3[1]:='l';
 c:=strComp(PChar(s1),PChar(s3));
 if (c=0) then
 begin
  f:=cmlg; d:=1; r:=1;Exit;
 end;
 s3[2]:='n';
 c:=strComp(PChar(s1),PChar(s3));
 if (c=0) then
 begin
  f:=cmln; d:=1; r:=1;Exit;
 end;
 if(r=0) then
 begin
  Nextch;
  s2[1]:=ch;
  strCat(PChar(s1),PChar(s2));
  s4[1]:='s';s4[2]:='i';s4[3]:='n';
  c:=strComp(PChar(s1),PChar(s4));
  if (c=0) then
  begin
  f:=cmsin; d:=1;Exit;
  end;
  s4[1]:='c';s4[2]:='o';s4[3]:='s';
  c:=strComp(PChar(s1),PChar(s4));

  if (c=0) then
  begin
  f:=cmcos; d:=1;Exit;
  end;
  s4[1]:='c';s4[2]:='t';s4[3]:='g';
  c:=strComp(PChar(s1),PChar(s4));
  if (c=0) then
  begin
  f:=cmctg; d:=1;Exit;
  end;
  s4[1]:='a';s4[2]:='r';s4[3]:='c';
  c:=strComp(PChar(s1),PChar(s4));
  if (c=0) then
  begin
   Nextch;  s2:='';
   s2[1]:=ch;s5:='';
   strCopy(PChar(s5),PChar(s2));
   Nextch;
   s2[1]:=ch;
   strCat(PChar(s5),PChar(s2));
   s3[1]:='t';s3[2]:='g';
   c:=strComp(PChar(s5),PChar(s3));
   if (c=0) then
   begin
    f:=cmatg; d:=1;Exit;
   end
   else if (c<>0) then
   begin
    Nextch;s2:='';s2[1]:=ch;
    strCat(PChar(s5),PChar(s2));
    s4[1]:='s';s4[2]:='i';s4[3]:='n';
    c:=strComp(PChar(s5),PChar(s4));
    if (c=0) then
    begin
     f:=cmasin; d:=1;Exit;
    end;
    s4[1]:='c';s4[2]:='o';s4[3]:='s';
    c:=strComp(PChar(s5),PChar(s4));
    if (c=0) then
    begin
     f:=cmacos; d:=1;Exit;
    end;
    s4[1]:='c';s4[2]:='t';s4[3]:='g';
    c:=strComp(PChar(s5),PChar(s4));
    if (c=0) then
    begin
     f:=cmactg; d:=1;Exit;
    end;
   end
   else begin
    Error('Ожидается функция.');
    Exit;
   end;
  end;
 end;
if (d=0) then begin
 Error('Ожидается функция.');
 Exit;
end; 
 Nextch;
end;

procedure  TFormUravnenie.stFunc;
var f: integer;
begin
 if ((ch='E')or(ch='e')) then
 begin
  Gen(Exp(1));
  Nextch;
 end
 else
 begin
  Givestfunc(f);
 // Showmessage(Floattostr(f));
  Nextch;
  if (f=cmsin) then
  begin
   if (ch='(') then
   begin
    Nextch;
    Equation(Eq);
    if (ch=')') then
     Nextch
    else begin
     Error('Ожидается символ ")", sin(..)');
     Exit;
    end;
    Gen(cmsin);
   end
   else begin
    Error('Ожидается символ "(", sin(..)');
    Exit;
   end;
  end
  else if (f=cmcos) then
  begin
   if (ch='(') then
   begin
    Nextch;
    Equation(Eq);
    if (ch=')') then
     Nextch
    else begin
     Error('Ожидается символ ")", cos(..)');
     Exit;
    end;
    Gen(cmcos);
   end
   else begin
    Error('Ожидается символ "(", cos(..)');
    Exit;
   end;
  end
  else if (f=cmtg) then
  begin
   if (ch='(') then
   begin
    Nextch;
    Equation(Eq);
    if (ch=')') then
     Nextch
    else begin
     Error('Ожидается символ ")", tg(..)');
     Exit;
    end;
    Gen(cmtg);
   end
   else begin
    Error('Ожидается символ "(", tg(..)');
    Exit;
   end;
  end
  else if (f=cmctg) then
  begin
   if (ch='(') then
   begin
    Nextch;
    Equation(Eq);
    if (ch=')') then
     Nextch
    else begin
     Error('Ожидается символ ")", ctg(..)');
     Exit;
    end;
    Gen(cmctg);
   end
   else begin
    Error('Ожидается символ "(", ctg(..)');
    Exit;
   end;
  end
  else if (f=cmlg) then
  begin
   if (ch='(') then
   begin
    Nextch;
    Equation(Eq);
    if (ch=')') then
     Nextch
    else begin
     Error('Ожидается символ ")", lg(..)');
     Exit;
    end;
    Gen(cmlg);
   end
   else begin
    Error('Ожидается символ "(", lg(..)');
    Exit;
   end;
  end
  else if (f=cmln) then
  begin
   if (ch='(') then
   begin
    Nextch;
    Equation(Eq);
    if (ch=')') then
     Nextch
    else begin
     Error('Ожидается символ ")", ln(..)');
     Exit;
    end;
    Gen(cmln);
   end
   else begin
    Error('Ожидается символ "(", ln(..)');
    Exit;
   end;
  end
  else if (f=cmasin) then
  begin
   if (ch='(') then
   begin
    Nextch;
    Equation(Eq);
    if (ch=')') then
     Nextch
    else begin
     Error('Ожидается символ ")", arcsin(..)');
     Exit;
    end;
    Gen(cmasin);
   end
   else begin
    Error('Ожидается символ "(", arcsin(..)');
    Exit;
   end;
  end
  else if (f=cmacos) then
  begin
   if (ch='(') then
   begin
    Nextch;
    Equation(Eq);
    if (ch=')') then
     Nextch
    else begin
     Error('Ожидается символ ")", arccos(..)');
     Exit;
    end;
    Gen(cmacos);
   end
   else begin
    Error('Ожидается символ "(", arccos(..)');
    Exit;
   end;
  end
  else if (f=cmatg) then
  begin
   if (ch='(') then
   begin
    Nextch;
    Equation(Eq);
    if (ch=')') then
     Nextch
    else begin
     Error('Ожидается символ ")", arctg(..)');
     Exit;
    end;
    Gen(cmatg);
   end
   else begin
    Error('Ожидается символ "(", arctg(..)');
    Exit;
   end;
  end
  else if (f=cmactg) then
  begin
   if (ch='(') then
   begin
    Nextch;
    Equation(Eq);
    if (ch=')') then
     Nextch
    else begin
     Error('Ожидается символ ")", arcctg(..)');
     Exit;
    end;
    Gen(cmactg);
   end
   else begin
    Error('Ожидается символ "(", arcctg(..)');
    Exit;
   end;
  end;
 end;
end;

procedure  TFormUravnenie.Equation (Eqq: Arr);
var Opp:char;
begin
 if ((ch='+')or (ch='-')) then
 begin
  Opp:=ch;
  Nextch;
  Addent(Eq);
  if (Opp='-') then
   Gen(cmneg);
 end
 else
  Addent(Eq);
  while ((ch='+') or (ch='-')) do
  begin
   Opp:=ch;
   Nextch;
   Addent(Eq);
   if (Opp='+') then
   Gen(cmadd)
   else if (Opp='-') then
   Gen(cmsub);
  end;
end;

procedure TFormUravnenie.Factory (Eqq: Arr; mes: CStr60);
var nn:integer;
var prr: boolean;
var ss: CStr80;
begin
 nn:=0;
 ss:='Ожидается';
 prr:=Digit(ch);
 if(prr=true) then
 begin
  Realnumber(num);
  Gen(num);
  nn:=1;
 end
 else if ((ch='x') or (ch='X')) then
 begin
  Nextch;
  Gen(cmx);
  nn:=1;
 end
 else if (ch='(') then
 begin
  Nextch;
  Equation(Eq);
  if (ch=')') then
  Nextch
  else begin
   Error('Ожидается символ ")"');
   Exit;
  end;
  nn:=1;
 end
 else if ((ch='s') or (ch='s') or (ch='c') or (ch='t') or (ch='e') or (ch='E') or (ch='l')or (ch='a')) then
 begin
 stFunc;  nn:=1;
 end;
 if ((nn=0) and (CompareStr(mes,'степень')=0)) then
 begin
  CompareStr(ss,mes);
  Error(ss);
  Exit;
 end;
 if (ch='^') then
 begin
  Nextch;
  nn:=0; mes:='';
  Factory(Eq,'степень');
  Gen(cmpower);
 end;
end;

function  TFormUravnenie.GiveOp: char;
var prr: boolean;
begin
 prr:=Digit(ch);
 if(ch='/') then
 begin
  result:='/';
  Nextch;
 end
 else if ((ch='*') or (prr=true) or (ch='x') or (ch='X') or (ch='(') or (ch='s') or (ch='c') or (ch='t') or (ch='a') or (ch='e') or (ch='E') or (ch='l')) then
 begin
  result:='*';
  Nextch;
 end
 else if (ch='^') then
 begin
  result:='^';
  Nextch;
 end
 else result:='.';
end;

procedure  TFormUravnenie.Addent (Eqq: Arr);
var Opp:char;
begin
 Factory(Eq,'factory');
 Op:=Giveop;
 if ((Op='*') or (Op='/')) then
 begin
  while ((Op='*') or (Op='/') or (Op='^')) do
  begin
   Nextch;
   Opp:=Op;
   Factory(Eq,'factory');
   if (Opp='*') then
   Gen(cmmult)
   else if (Opp='/') then
   Gen(cmdiv)
   else if (Opp='^') then
   Gen(cmpower);
   Op:=Giveop;
  end;
 end;
end;

procedure  TFormUravnenie.analis (Eqq: Arr);
begin
 Errpos:=0;
 Resettext();
 Pc:=0;
 if (s='') then
 begin
  Error('Ожидается уравнение!');
  Exit;
 end;
 Equation(Eq);
 Gen(cmstop);
end;

function  TFormUravnenie.power (xx: real; k: integer): real;
begin
 if(xx=0) then
  result:=0;
 if(k=1) then
  result:=xx;
 if(k=0) then
  result:=1;
 if (k>0) then
  result:=xx*power(xx,k-1);
 if (k<0) then
  result:=xx*power(xx,k+1)/xx;
end;

function  TFormUravnenie.calculate (xx: Extended): real;
var M:Arr;
    sp,cm: integer;
    cmd: real;
begin
 Pc:=0;
 sp:=-1;
 cmd:=Eq[Pc];
 if (cmd<>cmstop) then
 begin
  while(cmd<>cmstop) do
  begin
   Pc:=Pc+1;
   if (cmd>=0) then
   begin
    sp:=sp+1;
    M[sp]:=cmd;
   end;
   if (cmd<0) then
   begin
    cm:=trunc(cmd);
    if(cm=cmx) then
    begin
     sp:=sp+1;
     M[sp]:=xx;
    end
    else if (cm=cmneg) then
     M[sp]:=-M[sp]
    else if (cm=cmadd) then
    begin
     M[sp-1]:=M[sp-1]+M[sp];
     sp:=sp-1;
    end
    else if (cm=cmsub) then
    begin
     M[sp-1]:=M[sp-1]-M[sp];
     sp:=sp-1;
    end
    else if (cm=cmmult) then
    begin
     M[sp-1]:=M[sp-1]*M[sp];
     sp:=sp-1;
    end
    else if (cm=cmdiv) then
    begin
     M[sp-1]:=M[sp-1]/M[sp];
     sp:=sp-1;
    end
    else if (cm=cmsin) then
     M[sp]:=sin(M[sp])
    else if (cm=cmcos) then
     M[sp]:=cos(M[sp])
    else if (cm=cmtg) then
     M[sp]:=sin(M[sp])/cos(M[sp])
    else if (cm=cmctg) then
     M[sp]:=cos(M[sp])/sin(M[sp])
    else if (cm=cmasin) then
     M[sp]:=arcsin(M[sp])
    else if (cm=cmacos) then
     M[sp]:=arccos(M[sp])
    else if (cm=cmatg) then
     M[sp]:=arctan(M[sp])
    else if (cm=cmactg) then
     M[sp]:=Pi-arctan(M[sp])
    else if (cm=cmlg) then
     M[sp]:=log10(M[sp])
    else if (cm=cmln) then
     M[sp]:=ln(M[sp])
    else if (cm=cmpower) then
     begin
     if (M[sp]=0.5) then
      M[sp-1]:=sqrt(M[sp-1])
     else
      M[sp-1]:=power(M[sp-1],trunc(M[sp]));
     sp:=sp-1;
     end;
   end;
   cmd:=Eq[Pc];
  end;
 end;
 result:=M[sp];
end;

procedure TFormUravnenie.main;
var j: integer;
   
begin
 for  j:=0 to Length(Eq) do
 Eq[j]:=0;
 s:='';
 num:=0;
 Pc:=0;
 Op:='*';
end;

procedure TFormUravnenie.OkButtonClick(Sender: TObject);
var j, kk:integer;
begin
 main;
 kk:=0;
 analis(Eq);
for j:=0 to Length(Eq) do
if Eq[j]=-1 then kk:=1;
if kk=0 then begin
ShowMessage('Введите уравнение вида у(х). Ваше уравнение не содержит переменную х');
main;
FormUravnenie.EditUravn.Clear;
Exit;
end;
end;

procedure TFormUravnenie.Button1Click(Sender: TObject);
var v: string;
begin
 v:=IntToStr(FormUravnenie.SpinEdit1.Value);
 FormUravnenie.Edit2.Text:=InttoStr(round(calculate(StrtoFloat(v))));
end;

procedure TFormUravnenie.Close(Sender: TObject; var Action: TCloseAction);
begin
 //main;
 FormUravnenie.EditUravn.Clear;
 FormUravnenie.SpinEdit1.Clear;
 FormUravnenie.Edit2.Clear;
end;

end.
