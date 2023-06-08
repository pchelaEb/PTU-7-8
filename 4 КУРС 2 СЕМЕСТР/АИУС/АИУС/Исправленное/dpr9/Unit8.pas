unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls, jpeg;

type

  TForm8 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel5: TBevel;
    Bevel8: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    StartMatrix: TStringGrid;
    //TransMatrix: TStringGrid;
    Edit3: TEdit;
    Edit4: TEdit;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Memo1: TMemo;
    Memo2: TMemo;
    SaveDialog1: TSaveDialog;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    Label4: TLabel;
    Memo3: TMemo;
    Label9: TLabel;
    Label10: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form8: TForm8;

  f:textfile;
  n,m:integer;
implementation
Uses Unit5,Unit6,Unit3, Unit10, Unit9;
  type
  rezultat=array[1..50,1..50] of string ;
 //matr=array [1..100,1..100] of integer;
 var inv3,inv4,por,inv1,ch1,ch11,loop1,ch2,ch22,loop2,ValueStr,ValueStol,ValueStr2,ValueStol2,rn1,rn2:integer;
 res1,res3:rezultat;
 {$R *.dfm}

procedure TForm8.Button1Click(Sender: TObject);
var i,j:integer;
begin
// создание матрицы позиций и переходов
StartMatrix.Visible:=true;

Edit3.Visible:=true;
StartMatrix.ColCount:=strtoint(edit1.Text)+1;
StartMatrix.RowCount:=strtoint(edit2.Text)+1;
if strtoint(edit1.Text)>=50 then begin ShowMessage('Количество позиций не должно превышать 50');exit;end;
if strtoint(edit2.Text)>=50 then  begin ShowMessage('Количество переходов не должно превышать 50');exit;end;
ShowMessage('Правило заполнения матрицы:для раскаршенных сетей справделивы символьные значения значения со знаками + или -');
ValueStr:=startmatrix.ColCount;
ValueStol:=startmatrix.RowCount;
for i:=0 to ValueStr do
for j:=0 to ValueStol do
if (i=0) and (j=0) then startmatrix.Cells[i,j]:=' ' else
if  i=0 then  startmatrix.Cells[i,j]:='t'+inttostr(j) else
if j=0 then startmatrix.Cells[i,j]:='p'+inttostr(i) else
startmatrix.Cells[i,j]:='0';
//edit5.Text:=inttostr(ValueStol);
BitBtn4.Enabled:=true;
Button2.Enabled:=true;
end;

procedure TForm8.BitBtn4Click(Sender: TObject);
type
VArray=array[1..50,0..50] of string;
var i1,j1,rang1,rang2:integer;
a,transA:VArray;
FName,glob:string;

//Процедура вывода матрицы в файл
procedure anal(var f_l:textfile);
var lol,mol,i_p,j_p,s_p:integer;
m_p:array [1..50]of integer;
        begin
                rewrite(f_l);
writeln(f_l,'Результирующий вектор для Т-опор равен:');
for j_p:=1 to rn2 do
        begin
                for i_p:=1 to startmatrix.RowCount-1 do
                write(f_l,res3[j_p,i_p],' ');
                writeln(f_l,'');
                lol:=0;
                for i_p:=1 to startmatrix.RowCount-1 do
                if res3[j_p,i_p]<>'0' then
                        begin
                                writeln(f_l,'Переход t',inttostr(i_p),' живой');m_p[i_p]:=1;
                        end
                        else begin writeln(f_l,'Переход t',inttostr(i_p),' неживой');lol:=lol+1;end;
                writeln(f_l,'');
                if lol>0 then writeln(f,'--> В данном направлении не все переходы живые') else
                writeln(f_l,'--> В данном направлении  все переходы живые'); //моделируемом объекте
                writeln(f_l,'');
        end;
s_p:=0;
for i_p:=1 to startmatrix.RowCount-1 do
                s_p:=s_p+m_p[i_p];
                if s_p=startmatrix.RowCount-1 then writeln(f,'===>>В моделируемом объекте все переходы живые <<===') else
                writeln(f_l,'===>>В моделируемом объекте не все переходы живые <<===');
                writeln(f_l,'');
for i_p:=1 to startmatrix.RowCount-1 do
m_p[i_p]:=0;
writeln(f_l,'Результирующий вектор для Р-опор равен:');
for j_p:=1 to rn1 do
        begin
                for i_p:=1 to strtoint(edit1.Text) do     //transmatrix.RowCount:=strtoint(edit1.Text)+1;
                write(f_l,res1[j_p,i_p],' ');
                writeln(f_l,'');
                mol:=0;
                for i_p:=1 to strtoint(edit1.Text) do
                if res1[j_p,i_p]<>'0' then
                        begin
                                writeln(f_l,'Позиция p',inttostr(i_p),' достижима');m_p[i_p]:=1;
                        end
                        else begin writeln(f_l,'Позиция p',inttostr(i_p),' недостижима');mol:=mol+1;end;
                writeln(f_l,'');
                if mol>0 then writeln(f_l,'--> В данном направлении не все позиции достижимы') else
                writeln(f_l,'--> В данном направлении все позиции достижимы');
                writeln(f_l,'');
        end;
s_p:=0;
for i_p:=1 to strtoint(edit1.Text) do
                s_p:=s_p+m_p[i_p];
                if s_p=strtoint(edit1.Text) then writeln(f,'===>> В моделируемом объекте все позиции достижимы <<===') else
                writeln(f_l,'===>> В моделируемом объекте не все позиции достижимы <<===');
                writeln(f_l,'');
if (inv3=0) and (inv4=0)  then  writeln(f,'Моделируемый объект является неинвариантным и не устойчивым.Т.к нет P и Т опор,то охарактеризовать свойства статической корректности нельзя');
closefile(f);
end;
procedure Vyvod_matr(nw,mw,pw:integer;var xx:VArray;gl:string);
var gera,kw,iw,ti,tj,more:integer;
space:string;
begin

      for ti:=1 to nw do
 begin
 for tj:=1 to mw do
        begin   more:=length(xx[1,tj]);
                for kw:=1 to pw do
                  begin
                    if length(xx[kw,tj])>more then more:=length(xx[kw,tj]);
                  end;
                space:='';
                gera:=round(1.35*(more-length(xx[ti,tj])));
                for iw:=0 to gera do
                   begin
                     insert(' ',space,1);
                   end;
                write(f,xx[ti,tj]+space,'    ');
        end;
   writeln(f,'');
   end;
   writeln(f,gl);
end;

procedure Raschet(var rn_p,inv_p,ch_p,loop_p,n_p,m_p:integer;a_p:Varray;var res_p:rezultat{;FName_p:string});
var z,std,nenol,gg,b,i,j,x,y,k,h,hh,p,l,t,r,medin,edin,no_2,krug,nach_str:integer;
var minst,minstr,minstr1,minstr2,stol0,nnn,nol,stnenol:integer;
ks,kk,dlin1,dlin2,hui,huii,flag,k1,ii,k2,k3,k4,hs,h1,kkk,k10,k11,kkkk,i1,j1:integer;
    s,s1,s2,s3,s4,ss1,ss2,s5,s6,ss,str,str1,Cqj,Cpj:string;
    c,vsp3,vsp4,vsp44,vsp5,d,inv,vsp1,vsp2:VArray;
    plus_a:array[1..50]of integer;
    PJ:array[1..50]of string;
label 1,2;
begin
        writeln(f,'Исходная матрица инцедентности');
        Vyvod_matr(n_p,m_p,n_p,a_p,'*');
        std:=n_p;
        //Задаем единичную начальную матрицу инвариантов
        for x:=1 to n_p do
        for y:=1 to std do
        if x=y then d[x,y]:='+1' else d[x,y]:='0';
        z:=n_p;
        //Создаем цикл по строкам матрицы А
        for b:=1 to z do
                begin
                        gg:=100; stol0:=0;k:=0;t:=1;r:=1;h:=1;hh:=1;p:=1;
                        for j:=1 to m_p do
                                begin
                                        nol:=0;
                                        for i:=1 to n_p do
                                                begin
                                                        if a_p[i,j]='0' then
                                                        nol:=nol+1;
                                                end;
                                        if nol=n_p then inc(k) else
                                        for i:=1 to n_p do
                                        c[i,t]:=a_p[i,j];
                                        if nol<>n_p then inc(t);
                                end;
                        r:=m_p-k;
                        minst:=0;minstr:=0;minstr1:=0;
                        if n_p<2 then goto 1;
                        for t:=1 to r do  //Ищем столбец с большим количеством "0"
                                begin
                                        nenol:=0;
                                        for i:=1 to n_p do
                                                begin
                                                        if c[i,t]<>'0' then begin nenol:=nenol+1;end;
                                                end;
                                        if nenol>0 then
                                        if gg>nenol then
                                                begin
                                                        gg:=nenol;//Кол-во не "0" в столбце
                                                        minst:=t; //Номер столбца с меньшим кол-вом не "0"
                                                end;
                                end;
                        if minst=0 then goto 2;//При отсутствии столбца с меньшим не "0"-переход на метку 2
                        edin:=0;medin:=0;
                        for i:=1 to n_p do
                                begin
                                        str:=c[i,minst];//Число из мин. столбца
                                        if str[1]='+' then edin:=edin+1;// Кол-во полжительных выражений в строке
                                        if str[1]='-' then medin:=medin+1;// Кол-во отрицательных выражений в строке
                                end;
                        if (edin>0) and (medin=0) then //Если в столбце полько положительные числа
                                begin
                                        for i:=1 to n_p do
                                        for t:=1 to r do
                                                begin
                                                        str:=c[i,t];
                                                        if (t=minst) and (str[1]='+') then minstr:=i;
                                                end; //Находим номер строки с "+"( последняя с "+")
                                        for t:=1 to r do
                                                begin
                                                        for i:=1 to n_p do
                                                                begin
                                                                        if t<>minst then
                                                                        vsp1[i,p]:=c[i,t];//Матрица без найденого столбца
                                                                end;
                                                        if t<>minst then inc(p);
                                                end;
                                        for i:=1 to n_p do
                                                begin
                                                        for p:=1 to r-1 do
                                                                begin
                                                                        if i<>minstr then
                                                                        vsp2[h,p]:=vsp1[i,p]//Матрица без найденой строки;
                                                                end;
                                                        if i<>minstr then inc(h);
                                                end;
                                        for x:=1 to n_p do
                                                begin
                                                        for y:=1 to std do
                                                                begin
                                                                        if x<>minstr then
                                                                        vsp4[hh,y]:=d[x,y];//В матрице d удаляем соответствующую строку
                                                                end;
                                                        if x<>minstr then inc(hh);
                                                end;
                                end;
                        if (edin=0) and (medin>0) then  //Если в столбце полько отрицательные числа
                                begin
                                        for i:=1 to n_p do
                                        for t:=1 to r do
                                                begin
                                                        str:=c[i,t];
                                                        if (t=minst) and (str[1]='-') then minstr:=i;
                                                end;   //Находим номер строки с "-"( последняя с "-")
                                        for t:=1 to r do
                                                begin
                                                        for i:=1 to n_p do
                                                                begin
                                                                        if t<>minst then
                                                                        vsp1[i,p]:=c[i,t];
                                                                end;
                                                        if t<>minst then inc(p);
                                                end;
                                        for i:=1 to n_p do
                                                begin
                                                        for p:=1 to r-1 do
                                                                begin
                                                                        if i<>minstr then
                                                                        vsp2[h,p]:=vsp1[i,p];
                                                                end;
                                                        if i<>minstr then inc(h);
                                                end;
                                        for x:=1 to n_p do
                                                begin
                                                        for y:=1 to std do
                                                                begin
                                                                        if x<>minstr then
                                                                        vsp4[hh,y]:=d[x,y];//В матрице d удаляем соответствующую строку
                                                                end;
                                                        if x<>minstr then inc(hh);
                                                end;
                                end;
                        for i:=1 to no_2 do
                                begin
                                        plus_a[no_2]:=0;PJ[no_2]:='';
                                end;
                        if (edin>0) and (medin>0) then //Если в столбце и отрицательные и положит. числа
                                begin   no_2:=0;
                                        for i:=1 to n_p do
                                        for t:=1 to r do
		                                begin
		                                        str:=c[i,t];
                                                        if (t=minst) and (str[1]='-') then
                                                                begin
                                                                        minstr1:=i;Cqj:=c[i,t];//Строка с "-", число
                                                                end;
                                                end;
                                        for i:=1 to n_p do
                                        for t:=1 to r do
		                                begin
		                                        str:=c[i,t];
                                                        if (t=minst) and (str[1]='+') then
                                                                begin
                                                                        no_2:=no_2+1;
                                                                        plus_a[no_2]:=i;PJ[no_2]:=str;
                                                                        //minstr2:=plus_a[1];Cpj:=PJ[1];//Строка с "+", число
                                                                end;
                                                end;
                                        nach_str:=1;
                                for krug:=1 to no_2 do
                                    begin   minstr2:=plus_a[krug];Cpj:=PJ[krug];
                                        for i:=nach_str to n_p do
                                        for t:=1 to r do
                                                begin
                                                        str:=c[minstr2,t];str1:=c[minstr1,t];nach_str:=plus_a[krug]+1;
                                                        if (i<>minstr2) and (krug=1) then vsp3[i,t]:=c[i,t] else
                                                                begin
                                                                        glob:='';
                                                                        vsp3[i,t]:='-1'+'*'+Cqj+'*1'+c[minstr2,t]+';'+'+1'+'*'+Cpj+'*1'+c[minstr1,t];
                                                                        s:=vsp3[i,t];s2:=s;
                                                                        ks:=length(s);
                                                                        for ii:=0 to ks do
                                                                                begin
                                                                                        if s[ii]=';' then hs:=ii;
                                                                                end;
                                                                        delete(s,hs,ks-hs+1);//Оставляем 1 часть строки
                                                                        k1:=length(s);
                                                                        if (s[5]='0') or (s[4]='0') then //Исследуем число "Cqj"
                                                                                begin
                                                                                        delete(s,1,k1+1);//Если число "0", то и все произведение="0"
                                                                                        s1:=s;
                                                                                end;
                                                                        if (s[4]='+') then delete(s,2,3); //убираем + и оставляем - перед числом
                                                                        if (s[4]='-') then
                                                                                begin
                                                                                        delete(s,1,4);insert('+',s,1);//убираем все до числа и ставим +
                                                                                end;
                                                                        k2:=length(s);
                                                                        for ii:=0 to k2 do
                                                                        if s[ii]='*' then h1:=ii;//Позиция знака '*'
                                                                        s4:=s;s5:=s;kkk:=length(s4);kkkk:=length(s5);
                                                                        if s4[1]='-' then
                                                                                begin
                                                                                        delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);
                                                                                end;
                                                                        if s4[1]<>'-' then
                                                                                begin
                                                                                        delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);//*************Я сдесь поменял**************
                                                                                end;
                                                                        delete(s5,1,h1+2);
                                                                        if (s[1]='-') and (s[h1+2]='+') then begin delete(s,h1,3);s1:=s;k3:=length(s1);end;
                                                                        if (s[1]='-') and (s[h1+2]='-') then begin delete(s,h1,3);s1:=s;delete(s1,1,1);
                                                                        insert('+',s1,1);k3:=length(s1);
                                                                        end;
                                                                        if (s[1]<>'-') and (s[h1+2]='0') then
                                                                        begin
                                                                                delete(s,1,k2-1);s1:=s;k3:=0;// Можно объединить
                                                                        end;
                                                                        if (s[1]='-') and (s[h1+2]='0') then
                                                                        begin
                                                                                delete(s,1,k2-1);s1:=s;k3:=0;// Можно объединить
                                                                        end;
                                                                        if (s[1]<>'-') and (s[h1+2]='-') then
                                                                        begin
                                                                                delete(s,h1,3);s1:=s;delete(s1,1,1);
                                                                                insert('-',s1,1);k3:=length(s1);
                                                                        end;
                                                                        if (s[1]<>'-') and (s[h1+2]='+') then
                                                                        begin
                                                                                delete(s,h1,3);s1:=s;k3:=length(s1);
                                                                        end;                  //  S1 ,что получилось: +/-CqjC[minstr2,t] или 0
                                                                        kk:=length(s1);kkk:=length(s6);kkkk:=length(s5);
                                                                        if (s1[1]='-') and (s6=s5) then s1:='-'+s6;
                                                                        if (s1[1]='+') and (s6=s5) then s1:='+'+s6;
	                                                                if (s1[1]='0') and (s6=s5) then s1:='0';
                                                                        ks:=length(s2);
                                                                        for ii:=0 to ks do
                                                                        begin
                                                                              if s2[ii]=';' then hs:=ii;
                                                                        end;
                                                                        delete(s2,1,hs);
                                                                        k3:=length(s2);
                                                                        if (s2[5]='0') or (s2[4]='0') then
                                                                        begin
                                                                                delete(s2,1,k3+1);s3:=s2;
                                                                        end;
                                                                        if (s2[4]='+') then delete(s2,1,3);
                                                                        if (s2[4]='-') then delete(s2,1,3);
                                                                        k4:=length(s2);
                                                                        for ii:=0 to k4 do
                                                                        if s2[ii]='*' then h1:=ii;
                                                                        s4:=s2;s5:=s2;kkk:=length(s4);kkkk:=length(s5);
                                                                        if s4[1]='-' then
                                                                        begin
                                                                                delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);
                                                                        end;
                                                                        if s4[1]<>'-' then
                                                                        begin
                                                                                delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);
                                                                        end;
                                                                        delete(s5,1,h1+2);
                                                                        if (s2[1]='-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;
                                                                        if (s2[1]='-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='+';k4:=length(s3); end;
                                                                        if (s2[1]<>'-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
                                                                        if (s2[1]='-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
                                                                        if (s2[1]<>'-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='-';k4:=length(s3); end;
                                                                        if (s2[1]<>'-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;
                                                                        //  S2 ,что получилось: +/-CpjC[minstr1,t] или 0
                                                                        kk:=length(s3);kkk:=length(s6);kkkk:=length(s5);
                                                                        if (s3[1]='-') and (s6=s5) then s3:='-'+s6;
                                                                        if (s3[1]='+') and (s6=s5) then s3:='+'+s6;
                                                                        if (s3[1]='0') and (s6=s5) then s3:='0';

                                                                        if s1[1]='-' then begin ss1:=s1;delete(ss1,1,1);end;
                                                                        if s1[1]='+' then begin ss1:=s1;delete(ss1,1,1);end;
                                                                        if s1[1]='0' then ss1:=s1;
                                                                        if s3[1]='-' then begin ss2:=s3;delete(ss2,1,1);end;
                                                                        if s3[1]='+' then begin ss2:=s3;delete(ss2,1,1);end;
                                                                        if s3[1]='0' then ss2:=s3;
                                                                        if ss1=ss2 then ss1:=ss2;
                                                                        if (s1[1]='0') and (s3[1]='0') then ss:='0';
                                                                        if ss1=ss2 then
                                                                                begin   //Сложение если есть, что-то одинаковое
                                                                                        if (s1[1]='-') and (s3[1]='+') then ss:='0';
                                                                                        if (s1[1]='+') and (s3[1]='-') then ss:='0';
                                                                                        if (s1[1]='-') and (s3[1]='-') then ss:='-2'+ss1;
                                                                                        if (s1[1]='+') and (s3[1]='+') then ss:='2'+ss1;
                                                                                end else
                                                                                begin
                                                                                        if (k3<>0) and (k4=0) then
                                                                                                begin
                                                                                                        if s1[1]='+' then ss:='+'+ss1;
                                                                                                        if s1[1]='-' then ss:='-'+ss1;
                                                                                                end;
                                                                                        if (k3=0) and (k4<>0) then
	                                                                                        begin
                                                                                                        if s3[1]='+' then ss:='+'+ss2;
                                                                                                        if s3[1]='-' then ss:='-'+ss2;
                                                                                                end;
                                                                                        if (k3=0) and (k4=0) then ss:='0';
                                                                                        if (k3<>0) and (k4<>0) then
                                                                                                begin
                                                                                                        if (s1[1]='+') and (s3[1]='+') then
                                                                                                                begin
                                                                                                                        ss:='+('+ss1+'+'+ss2+')';
                                                                                                                end;
                                                                                                        if (s1[1]='0') and (s3[1]='0') then
                                                                                                                begin
                                                                                                                        ss:='0';
                                                                                                                end;
                                                                                                        if (s1[1]='0') and (s3[1]='+') then
                                                                                                                begin
                                                                                                                        ss:='+'+ss2;
                                                                                                                end;
                                                                                                        if (s1[1]='0') and (s3[1]='-') then
                                                                                                                begin
                                                                                                                        ss:='-'+ss2;
                                                                                                                end;
                                                                                                        if (s1[1]='+') and (s3[1]='0') then
                                                                                                                begin
                                                                                                                        ss:='+'+ss1;
                                                                                                                end;
                                                                                                        if (s1[1]='-') and (s3[1]='0') then
                                                                                                                begin
                                                                                                                        ss:='-'+ss1;
                                                                                                                end;
                                                                                                        if (s1[1]='+') and (s3[1]='-') then
                                                                                                                begin
	                                                                                                                delete(s1,1,1);
                                                                                                                        ss:=s1+s3;insert('+(',ss,1);k11:=length(ss);insert(')',ss,k11+1);
                                                                                                                end;
                                                                                                        if (s1[1]='-') and (s3[1]='-') then
                                                                                                                begin
                                                                                                                        ss:='-('+ss1+'+'+ss2+')';
                                                                                                                end;
                                                                                                        if (s1[1]='-') and (s3[1]='+') then
                                                                                                                begin
                                                                                                                        ss:='-('+ss1+'-'+ss2+')';
                                                                                                                end;
                                                                                                end;
                                                                                end;
                                                                        vsp3[i,t]:=ss;
                                                                end;
                                                end;end;
                                        for t:=1 to r do
                                                begin
                                                        for i:=1 to n_p do
                                                                begin
                                                                        if t<>minst then
                                                                        vsp1[i,p]:=vsp3[i,t];
                                                                end;
                                                        if t<>minst then inc(p);
                                                end;
                                        for i:=1 to n_p do
                                                begin
                                                        for p:=1 to r-1 do
                                                                begin
                                                                        if i<>minstr1 then
                                                                        vsp2[h,p]:=vsp1[i,p];
                                                                end;
                                                        if i<>minstr1 then inc(h);
                                       end;
                                              //end;
                                    nach_str:=1;

                                    for krug:=1 to no_2 do
                                                begin minstr2:=plus_a[krug];Cpj:=PJ[krug];glob:='';
                                        for x:=nach_str to n_p do
                                        for y:=1 to std do
                                                begin   str:=c[minstr2,t];str1:=c[minstr1,t];nach_str:=plus_a[krug]+1;
                                                        if (x<>minstr2) and (krug=1) then vsp5[x,y]:=d[x,y] else
                                                                begin
                                                                        vsp5[x,y]:='-1'+'*'+Cqj+'*1'+d[minstr2,y]+';'+'+1'+'*'+Cpj+'*1'+d[minstr1,y];
                                                                        s:=vsp5[x,y];
                                                                        s2:=s;
                                                                        ks:=length(s);
                                                                                for ii:=0 to ks do
                                                                                        begin
                                                                                                if s[ii]=';' then hs:=ii;
                                                                                        end;
                                                                        delete(s,hs,ks-hs+1);
                                                                        k1:=length(s);
                                                                        if (s[5]='0') or (s[4]='0') then
                                                                                begin
                                                                                        delete(s,1,k1+1); s1:=s;
                                                                                end;
                                                                        if (s[4]='+') then delete(s,2,3);
                                                                        if (s[4]='-') then
                                                                                begin
                                                                                        delete(s,1,4);insert('+',s,1);
                                                                                end;
                                                                        k2:=length(s);
                                                                        for ii:=0 to k2 do
                                                                        if s[ii]='*' then h1:=ii;
                                                                        s4:=s;s5:=s;kkk:=length(s4);kkkk:=length(s5);
                                                                        if s4[1]='-' then
                                                                                begin
                                                                                        delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);
                                                                                end;
                                                                        if s4[1]<>'-' then
                                                                                begin
                                                                                        delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);
                                                                                end;
                                                                        delete(s5,1,h1+2);
                                                                        if s[h1+3]<>'1' then
                                                                                begin
                                                                                        if (s[1]='-') and (s[h1+2]='+') then
                                                                                                begin
                                                                                                        delete(s,h1,3);s1:=s;k3:=length(s1);
                                                                                                end;
                                                                                        if (s[1]='-') and (s[h1+2]='-') then
                                                                                                begin
                                                                                                        delete(s,h1,3);s1:=s;delete(s1,1,1);
                                                                                                        insert('+',s1,1);k3:=length(s1);
                                                                                                end;
                                                                                        if (s[1]<>'-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
                                                                                        if (s[1]='-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
                                                                                        if (s[1]<>'-') and (s[h1+2]='-') then
                                                                                                begin
                                                                                                        delete(s,h1,3);s1:=s;delete(s1,1,1);
                                                                                                        insert('-',s1,1);k3:=length(s1);
                                                                                                end;
                                                                                        if (s[1]<>'-') and (s[h1+2]='+') then begin delete(s,h1,3);s1:=s;k3:=length(s1);end;
                                                                                end else
                                                                                begin
                                                                                        if (s[1]='-') and (s[h1+2]='+') then begin delete(s,h1,4);s1:=s;k3:=length(s1);end;
                                                                                        if (s[1]='-') and (s[h1+2]='-') then begin delete(s,h1,4);s1:=s;delete(s1,1,1);
                                                                                        insert('+',s1,1);k3:=length(s1); end;
                                                                                        if (s[1]<>'-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
                                                                                        if (s[1]='-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
                                                                                        if (s[1]<>'-') and (s[h1+2]='-') then begin delete(s,h1,4);s1:=s;delete(s1,1,1);
                                                                                        insert('-',s1,1);k3:=length(s1); end;
                                                                                        if (s[1]<>'-') and (s[h1+2]='+') then begin delete(s,h1,4);s1:=s;k3:=length(s1);end;
                                                                                end;
                                                                        kk:=length(s1);kkk:=length(s6);kkkk:=length(s5);
                                                                        if (s1[1]='-') and (s6=s5) then s1:='-'+s6;
                                                                        if (s1[1]='+') and (s6=s5) then s1:='+'+s6;
                                                                        if (s1[1]='0') and (s6=s5) then s1:='0';
                                                                        ks:=length(s2);
                                                                        for ii:=0 to ks do
                                                                                begin
                                                                                        if s2[ii]=';' then hs:=ii;
                                                                                end;
                                                                        delete(s2,1,hs);
                                                                        k3:=length(s2);
                                                                        if (s2[5]='0') or (s2[4]='0') then  begin delete(s2,1,k3+1);s3:=s2; end;
                                                                        if (s2[4]='+') then delete(s2,1,3);
                                                                        if (s2[4]='-') then delete(s2,1,3);
                                                                        k4:=length(s2);
                                                                        for ii:=0 to k4 do
                                                                        if s2[ii]='*' then h1:=ii;
                                                                        s4:=s2;s5:=s2;kkk:=length(s4);kkkk:=length(s5);
                                                                        if s4[1]='-' then begin delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);end;
                                                                        if s4[1]<>'-' then begin delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);end;
                                                                        delete(s5,1,h1+2);
                                                                        if s2[h1+3]<>'1' then
                                                                                begin
                                                                                        if (s2[1]='-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;
                                                                                        if (s2[1]='-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='+';k4:=length(s3); end;
                                                                                        if (s2[1]<>'-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
                                                                                        if (s2[1]='-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
                                                                                        if (s2[1]<>'-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='-';k4:=length(s3); end;
                                                                                        if (s2[1]<>'-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;
                                                                                end else
                                                                                begin
                                                                                        if (s2[1]='-') and (s2[h1+2]='+') then begin delete(s2,h1,4);s3:=s2;k4:=length(s3);end;
                                                                                        if (s2[1]='-') and (s2[h1+2]='-') then begin delete(s2,h1,4);s3:=s2;s3[1]:='+';k4:=length(s3); end;
                                                                                        if (s2[1]<>'-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
                                                                                        if (s2[1]='-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
                                                                                        if (s2[1]<>'-') and (s2[h1+2]='-') then begin delete(s2,h1,4);s3:=s2;s3[1]:='-';k4:=length(s3); end;
                                                                                        if (s2[1]<>'-') and (s2[h1+2]='+') then begin delete(s2,h1,4);s3:=s2;k4:=length(s3);end;
                                                                                end;
                                                                        kk:=length(s3);kkk:=length(s6);kkkk:=length(s5);
                                                                        if (s3[1]='-') and (s6=s5) then s3:='-'+s6;
                                                                        if (s3[1]='+') and (s6=s5) then s3:='+'+s6;
                                                                        if (s3[1]='0') and (s6=s5) then s3:='0';
                                                                        if s1[1]='-' then begin ss1:=s1;delete(ss1,1,1);end;
                                                                        if s1[1]='+' then begin ss1:=s1;delete(ss1,1,1);end;
                                                                        if s1[1]='0' then ss1:=s1;
                                                                        if s3[1]='-' then begin ss2:=s3;delete(ss2,1,1);end;
                                                                        if s3[1]='+' then begin ss2:=s3;delete(ss2,1,1);end;
                                                                        if s3[1]='0' then ss2:=s3;
                                                                        dlin1:=length(ss1);dlin2:=length(ss2);flag:=0;
                                                                        for hui:=0 to dlin1 do
                                                                                begin
                                                                                        for huii:=0 to dlin2 do
                                                                                        if ss2[huii]=ss1[hui] then inc(flag);
                                                                                end;
                                                                        if dlin1=flag-1 then ss1:=ss2;
                                                                        if (s1[1]='0') and (s3[1]='0') then ss:='0';
                                                                        if ss1=ss2 then
                                                                                begin
                                                                                        if (s1[1]='-') and (s3[1]='+') then ss:='0';
                                                                                        if (s1[1]='+') and (s3[1]='-') then ss:='0';
                                                                                        if (s1[1]='-') and (s3[1]='-') then ss:='-2'+ss1;
                                                                                        if (s1[1]='+') and (s3[1]='+') then ss:='2'+ss1;
                                                                                end else
                                                                                begin
                                                                                        if (k3<>0) and (k4=0) then
                                                                                                begin
                                                                                                        if s1[1]='+' then ss:='+'+ss1;
                                                                                                        if s1[1]='-' then ss:='-'+ss1;
                                                                                                end;
                                                                                        if (k3=0) and (k4<>0) then
                                                                                                begin
                                                                                                        if s3[1]='+' then ss:='+'+ss2;
                                                                                                        if s3[1]='-' then ss:='-'+ss2;
                                                                                                end;
                                                                                        if (k3=0) and (k4=0) then ss:='0';
                                                                                        if (k3<>0) and (k4<>0) then
                                                                                                begin
                                                                                                        if (s1[1]='+') and (s3[1]='+') then begin ss:='+('+ss1+'+'+ss2+')';end;
                                                                                                        if (s1[1]='0') and (s3[1]='0') then begin ss:='0';end;
                                                                                                        if (s1[1]='0') and (s3[1]='+') then begin ss:='+'+ss2;end;
                                                                                                        if (s1[1]='0') and (s3[1]='-') then begin ss:='-'+ss2;end;
                                                                                                        if (s1[1]='+') and (s3[1]='0') then begin ss:='+'+ss1;end;
                                                                                                        if (s1[1]='-') and (s3[1]='0') then begin ss:='-'+ss1;end;
                                                                                                        if (s1[1]='+') and (s3[1]='-') then
                                                                                                                begin
                                                                                                                        delete(s1,1,1);
                                                                                                                        ss:=s1+s3;insert('+(',ss,1);k11:=length(ss);insert(')',ss,k11+1);
                                                                                                                end;
                                                                                                        if (s1[1]='-') and (s3[1]='-') then begin ss:='-('+ss1+'+'+ss2+')';end;
                                                                                                        if (s1[1]='-') and (s3[1]='+') then begin ss:='-('+ss1+'-'+ss2+')';end;
                                                                                                end;
                                                                                end;
                                                                        vsp5[x,y]:=ss;
                                                                end;
                                                end;end;
                                        for x:=1 to n_p do
                                                begin
                                                        for y:=1 to std do
                                                                begin
                                                                        if x<>minstr1 then
                                                                        vsp4[hh,y]:=vsp5[x,y];
                                                                end;
                                                        if x<>minstr1 then inc(hh);
                                                end;
                                end;//проверка 3 случая закончена

                        writeln(f,'Проход № ',b);
                        writeln(f,'matrica c');
                        Vyvod_matr(n_p-1,r-1,n_p-1,vsp2,glob);
                        nnn:=n_p-1;
                        writeln(f,'matrica d');
                        for hh:=1 to n_p-1 do
                                //begin
                                        for y:=1 to std do
                                                begin
                                                        res_p[hh,y]:=res_p[hh,y];
                                                end;
                        rn_p:=0;
                        for hh:=1 to n_p-1 do
                                begin
                                rn_p:=rn_p+1;
                                        for y:=1 to std do
                                                begin
                                                        res_p[hh,y]:=vsp4[hh,y];

                                                end;
                                end;
                        Vyvod_matr(n_p-1,std,n_p-1,vsp4,'');
                        loop_p:=0;ch_p:=0;
                        for y:=1 to std do
                                begin
                                        ch1:=0;
                                        for hh:=1 to n_p do
                                                begin
                                                        if (vsp4[hh,y]<>'0') and (vsp4[hh,y]<>'+0') then ch1:=ch1+1;
                                                end;
                                        if  ch1>0 then inc(ch_p);inc(loop_p);
                                end;

                        2:
                        n_p:=n_p-1;
                        m_p:=m_p-k-1;
                        for h:=1 to n_p do
                        for p:=1 to m_p do
                        a_p[h,p]:=vsp2[h,p];

                        for hh:=1 to n_p do
                        for y:=1 to std do
                        d[hh,y]:=vsp4[hh,y];
                end;
        1:
        writeln(f,'Количество инвариантов равно '+inttostr(nnn));
        inv_p:=nnn;

//      edit5.Text:=inttostr(more);
        closefile(f);
//        Memo2.Lines.LoadFromFile(FName);
end;
{******************************************************************************************************************}

begin
// Создание файла отчетности

SaveDialog1.Title:='Создание файла моделирования ';
SaveDialog1.FileName:=form5.Edit1.Text ;
if SaveDialog1.Execute then begin
 FName:=SaveDialog1.FileName;
  Case SaveDialog1.FilterIndex of
  1:FName:=ChangeFileExt(FName,'.txt');
  2:FName:=ChangeFileExt(FName,'.doc');
  end;
 SaveDialog1.Filter:='.txt';
 assignFile(f,FName);
rewrite(f);
//транспонирование матрицы А
Edit4.Visible:=true;

ValueStr:=startmatrix.ColCount;
ValueStol:=startmatrix.RowCount;

for i1:=1 to ValueStol do
for j1:=1 to ValueStr do
transA[i1,j1]:=startmatrix.Cells[j1,i1];

//Реализация алгоритма Фаркаса для матрицы А
n:=strtoint(edit2.Text);
m:=strtoint(edit1.Text);

//Задаем начальную матрицу инцедентности
for i1:=1 to n do
  for j1:=1 to m do
   begin
   if (transA[i1,j1][1]<>'-') and (transA[i1,j1][1]<>'+') and (transA[i1,j1]<>'0') then
   insert('+',transA[i1,j1],1);
   a[i1,j1]:=transA[i1,j1];
   end;
Raschet(rn2,inv4,ch22,loop2,n,m,a,res3);
rang2:=startmatrix.RowCount-1-inv4;
edit3.Text:=inttostr(rang2);
Memo1.Lines.LoadFromFile(FName);
   end;
   // Нахождение инвариантов для транспонированной матрицы
rewrite(f);
n:=startmatrix.ColCount-1;
m:=startmatrix.RowCount-1;
//Задаем начальную матрицу инцедентности
for i1:=1 to n do
  for j1:=1 to m do
   a[i1,j1]:=transA[j1,i1];
Raschet(rn1,inv3,ch11,loop1,n,m,a,res1);
rang1:=startmatrix.ColCount-1-inv3;
if rang2<=rang1 then rang1:=rang2;
if rang2>rang1 then rang2:=rang1;
edit4.Text:=inttostr(rang1);
edit3.Text:=inttostr(rang2);
Memo2.Lines.LoadFromFile(FName);
anal(f);
Memo3.Lines.LoadFromFile(FName);
 if (inv3>0) and (inv4>0) then
        begin
                if (ch11=loop1) and (ch22=loop2) then ShowMessage('Моделируемый объект обладает свойствами: 1.Все позиции достижимы; 2.Все переходы живые');
                if (ch11<>loop1) and (ch22=loop2) then  ShowMessage('Моделируемый объект обладает свойствами: 1. Все позиции достижимы; 2. Не все переходы  живые');
                if (ch11=loop1) and (ch22<>loop2) then  ShowMessage('Моделируемый объект обладает свойствами: 1. Не все позиции достижимы; 2. Все переходы живые');
                if (ch11<>loop1) and (ch22<>loop2) then ShowMessage('Моделируемый объект обладает свойствами: 1. Не все позиции достижимы; 2.Не все переходы живые');
        end;
                if (inv3=0) and (inv4>0) and (ch11=loop1) then  ShowMessage('Моделируемый объект является инвариантным, но не устойчивым.В данной сети все позиции достижимы');
                if (inv3=0) and (inv4>0) and (ch11<>loop1) then  ShowMessage('Моделируемый объект является не инвариантным, но устойчивым.В данной сети не все переходы живые');
                if (inv3>0) and (inv4=0) and (ch22=loop2) then  ShowMessage('Моделируемый объект является неинвариантным, но устойчивым.В данной сети  все переходы живые');
                if (inv3>0) and (inv4=0) and (ch22<>loop2) then  ShowMessage('Моделируемый объект является инвариантным, но не устойчивым.В данной сети не все позиции достижимы');
                if (inv3=0) and (inv4=0)  then  ShowMessage('Моделируемый объект является неинвариантным и не устойчивым.Т.к нет P и Т опор,то охарактеризовать свойства статической корректности нельзя');
end;
 


procedure TForm8.BitBtn1Click(Sender: TObject);
begin
form8.Close;
end;

procedure TForm8.BitBtn3Click(Sender: TObject);

var FName:string;
begin
OpenDialog1.Title:= 'Открытие моделируемого файла';

if OpenDialog1.Execute and FileExists(OpenDialog1.FileName) then
 begin
 FName:=OpenDialog1.FileName;
 Case OpenDialog1.FilterIndex of
  1:FName:=ChangeFileExt(FName,'.txt');
  2:FName:=ChangeFileExt(FName,'.doc');
  end;
  form6.Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
  end;
  Form6.Show;
end;

procedure TForm8.BitBtn6Click(Sender: TObject);
begin
form10.show;
end;

procedure TForm8.BitBtn7Click(Sender: TObject);
begin
close;
end;

procedure TForm8.BitBtn2Click(Sender: TObject);
begin
edit1.text:='';
edit2.text:='';
edit3.text:='';
edit4.text:='';
StartMatrix.RowCount:=1;
StartMatrix.ColCount:=1;
Memo1.Lines.Text:='';
Memo2.Lines.Text:='';
Memo3.Lines.Text:='';
end;

procedure TForm8.SpeedButton6Click(Sender: TObject);
begin
close;
end;

procedure TForm8.SpeedButton3Click(Sender: TObject);
begin
form10.show;
end;

procedure TForm8.SpeedButton1Click(Sender: TObject);
var FName,s,s_tmp,s_tmp1:string;
i,j,m,n,k,jw,iw,jw_p,r_w,s_w:integer;
f:textfile;
a_tmp,st_matr:array[0..50,0..50] of string;
begin
        OpenDialog1.Title:= 'Открытие моделируемого файла';
        if OpenDialog1.Execute and FileExists(OpenDialog1.FileName) then
                begin
                        FName:=OpenDialog1.FileName;
                        Case OpenDialog1.FilterIndex of
                        1:FName:=ChangeFileExt(FName,'.txt');
                        2:FName:=ChangeFileExt(FName,'.doc');
                end;
        assignfile(f,FName);
        reset(f);
        i:=0;j:=0;k:=0;
        iw:=0;r_w:=0;s_w:=0;
        while not eof(f) do
                begin
                       iw:=iw+1;
                       readln(f,s);jw:=1;
                       jw_p:=0;
                             While s<>'' do
                              begin
                                //s_tmp:=s;startmatrix.RowCount:=startmatrix.RowCount+1;
                                if s[jw_p]=' ' then
                                        begin
                                                s_tmp:=s;
                                                //startmatrix.ColCount:=startmatrix.ColCount+1;
                                                delete(s_tmp,jw_p,(length(s_tmp)-jw_p+1));
                                                st_matr[jw,iw]:=s_tmp;
                                                //startmatrix.Cells[jw,iw]:=s_tmp;
                                                delete(s,1,jw_p);
                                                s_tmp:=s;
                                                jw_p:=0;
                                                jw:=jw+1;
                                        end
                                        else
                                                jw_p:=jw_p+1;
                                        end;
                                end;
                        Edit1.Text:=inttostr(jw-1);
                        Edit2.Text:=inttostr(iw);
                        Button1Click(Form8);
                        For iw:=1 to strtoint(Edit2.Text) do
                        For jw:=1 to strtoint(Edit1.Text) do
                        startmatrix.Cells[jw,iw]:=st_matr[jw,iw];
                end;
        closefile(f);
end;


procedure TForm8.SpeedButton2Click(Sender: TObject);
begin
edit1.text:='';
edit2.text:='';
edit3.text:='';
edit4.text:='';
StartMatrix.RowCount:=1;
StartMatrix.ColCount:=1;
Memo1.Lines.Text:='';
Memo2.Lines.Text:='';
end;

procedure TForm8.Button2Click(Sender: TObject);
var FName1:string;
f:textfile;

procedure anal(var f_l:textfile);
var lol,mol,i_p,j_p,s_p:integer;
m_p:array [1..50]of integer;
        begin
                rewrite(f_l);
writeln(f_l,'Результирующий вектор для Т-опор равен:');
for j_p:=1 to rn2 do
        begin
                for i_p:=1 to startmatrix.RowCount-1 do
                write(f_l,res3[j_p,i_p],' ');
                writeln(f_l,'');
                lol:=0;
                for i_p:=1 to startmatrix.RowCount-1 do
                if res3[j_p,i_p]<>'0' then
                        begin
                                writeln(f_l,'Переход t',inttostr(i_p),' живой');m_p[i_p]:=1;
                        end
                        else begin writeln(f_l,'Переход t',inttostr(i_p),' неживой');lol:=lol+1;end;
                writeln(f_l,'');
                if lol>0 then writeln(f,'--> В данном направлении не все переходы живые') else
                writeln(f_l,'--> В данном направлении  все переходы живые'); //моделируемом объекте
                writeln(f_l,'');
        end;
s_p:=0;
for i_p:=1 to startmatrix.RowCount-1 do
                s_p:=s_p+m_p[i_p];
                if s_p=startmatrix.RowCount-1 then writeln(f,'===>>В моделируемом объекте все переходы живые <<===') else
                writeln(f_l,'===>>В моделируемом объекте не все переходы живые <<===');
                writeln(f_l,'');
for i_p:=1 to startmatrix.RowCount-1 do
m_p[i_p]:=0;
writeln(f_l,'Результирующий вектор для Р-опор равен:');
for j_p:=1 to rn1 do
        begin
                for i_p:=1 to strtoint(edit1.Text) do     //transmatrix.RowCount:=strtoint(edit1.Text)+1;
                write(f_l,res1[j_p,i_p],' ');
                writeln(f_l,'');
                mol:=0;
                for i_p:=1 to strtoint(edit1.Text) do
                if res1[j_p,i_p]<>'0' then
                        begin
                                writeln(f_l,'Позиция p',inttostr(i_p),' достижима');m_p[i_p]:=1;
                        end
                        else begin writeln(f_l,'Позиция p',inttostr(i_p),' недостижима');mol:=mol+1;end;
                writeln(f_l,'');
                if mol>0 then writeln(f_l,'--> В данном направлении не все позиции достижимы') else
                writeln(f_l,'--> В данном направлении все позиции достижимы');
                writeln(f_l,'');
        end;
s_p:=0;
for i_p:=1 to strtoint(edit1.Text) do
                s_p:=s_p+m_p[i_p];
                if s_p=strtoint(edit1.Text) then writeln(f,'===>> В моделируемом объекте все позиции достижимы <<===') else
                writeln(f_l,'===>> В моделируемом объекте не все позиции достижимы <<===');
                writeln(f_l,'');
if (inv3=0) and (inv4=0)  then  writeln(f,'Моделируемый объект является неинвариантным и не устойчивым.Т.к нет P и Т опор,то охарактеризовать свойства статической корректности нельзя');
closefile(f);
end;

begin
SaveDialog1.Title:='Создание файла для анализа';
SaveDialog1.FileName:='Отчет1';
if SaveDialog1.Execute then begin
 FName1:=SaveDialog1.FileName;
  Case SaveDialog1.FilterIndex of
  1:FName1:=ChangeFileExt(FName1,'.txt');
  2:FName1:=ChangeFileExt(FName1,'.doc');
  end;  end;
 SaveDialog1.Filter:='.txt';
 assignFile(f,FName1);
anal(f);
   form9.show;
   form9.Memo1.Lines.LoadFromFile(FName1);
end;

procedure TForm8.SpeedButton5Click(Sender: TObject);
var FName1,s_tmp:string;
iw,jw:integer;
f:textfile;
        begin
                SaveDialog1.Title:='Создание файла для анализа';
                SaveDialog1.FileName:='Отчет1';
                if SaveDialog1.Execute then
                        begin
                                FName1:=SaveDialog1.FileName;
                                Case SaveDialog1.FilterIndex of
                                        1:FName1:=ChangeFileExt(FName1,'.txt');
                                        2:FName1:=ChangeFileExt(FName1,'.doc');
                                end;
                        end;
                SaveDialog1.Filter:='.txt';
                assignFile(f,FName1);
                rewrite(f);
                for iw:=1 to strtoint(edit2.Text) do
                        begin
                                for jw:=1 to strtoint(edit1.Text) do
                                        begin
                                               write(f,startmatrix.Cells[jw,iw],' ');
                                        end;
                                writeln(f,'');
                        end;
                closefile(f);
        end;

procedure TForm8.FormCreate(Sender: TObject);
begin
Memo3.Lines.Text:='';
//BitBtn4.Enabled:=false;
//ADOTable1.Active:=true;
end;

end.
