unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls;

type
  TForm8 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    StartMatrix: TStringGrid;
    TransMatrix: TStringGrid;
    Edit3: TEdit;
    Edit4: TEdit;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Memo1: TMemo;
    Memo2: TMemo;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton6: TSpeedButton;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation
Uses Unit5,Unit6,Unit3, Unit10, Unit9;
 type matr=array [1..100,1..100] of integer;
 var i,j,por,inv1,ch1,ch11,loop1,ch2,ch22,loop2,inv3,inv4,ValueStr,ValueStol,ValueStr2,ValueStol2:integer;
{$R *.dfm}

procedure TForm8.Button1Click(Sender: TObject);
var i,j:integer;
begin
// �������� ������� ������� � ���������
StartMatrix.Visible:=true;

Edit3.Visible:=true;
StartMatrix.ColCount:=strtoint(edit1.Text)+1;
StartMatrix.RowCount:=strtoint(edit2.Text)+1;
if strtoint(edit1.Text)>=50 then begin ShowMessage('���������� ������� �� ������ ��������� 50');exit;end;
if strtoint(edit2.Text)>=50 then  begin ShowMessage('���������� ��������� �� ������ ��������� 50');exit;end;
ShowMessage('������� ���������� �������:��� ������������ ����� ����������� ���������� �������� �������� �� ������� + ��� -');
ValueStr:=startmatrix.RowCount;
ValueStol:=startmatrix.ColCount;
for i:=0 to ValueStr do
for j:=0 to ValueStol do
if (i=0) and (j=0) then startmatrix.Cells[i,j]:=' ' else
if  i=0 then  startmatrix.Cells[i,j]:='t'+inttostr(j) else
if j=0 then startmatrix.Cells[i,j]:='p'+inttostr(i) else
startmatrix.Cells[i,j]:='0';
end;

procedure TForm8.BitBtn4Click(Sender: TObject);
 var b,z,i,j,m,n,std,nenol,gg,minst,minstr,minstr1,minstr2,stol0,nn,nnn,nol,stnenol,k,h,hh,p,l,t,r,medin,edin,x,y:integer;
 var a,c:array[1..10,1..10] of string;
var vsp3,vsp4,vsp44:array[1..10,1..10] of string;
var vsp5,d,inv:array[1..10,1..10] of string;
var vsp1,vsp2:array[1..10,1..10] of string;
         str,str1,Cqj,Cpj:string;
var s,s1,s2,s3,s4,ss1,ss2,s5,s6,ss,FName:string;
var f:textfile;
ks,kk,dlin1,dlin2,hui,huii,flag,k1,ii,k2,k3,k4,hs,h1,kkk,k10,k11,kkkk,i1,inv3,rang1,rang2,j1:integer;
label 10,100,50;
  label 1,2,11,5;
begin
// �������� ����� ����������

SaveDialog1.Title:='�������� ����� ������������� ';
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


//���������������� ������� �

TransMatrix.Visible:=true;

Edit4.Visible:=true;

transMatrix.ColCount:=strtoint(edit2.Text)+1;
transmatrix.RowCount:=strtoint(edit1.Text)+1;
ValueStr:=startmatrix.RowCount;
ValueStol:=startmatrix.ColCount;
for i1:=0 to ValueStr do
for j1:=0 to ValueStol do
if (i1=0) and (j1=0) then startmatrix.Cells[i1,j1]:=' ' else
if  i1=0 then  transmatrix.Cells[i1,j1]:='p'+inttostr(j1) else
if j1=0 then transmatrix.Cells[i1,j1]:='t'+inttostr(i1) else
transmatrix.Cells[i1,j1]:=startmatrix.Cells[j1,i1];

//���������� ��������� ������� ��� ������� �
 n:=transmatrix.ColCount-1;
m:=transmatrix.RowCount-1;

//������ ��������� ������� �������������

for i:=1 to n do
  for j:=1 to m do
   a[i,j]:=TransMatrix.Cells[i,j];
   writeln(f,'�������� ������� �������������');
      for i:=1 to n do
 begin
 for j:=1 to m do
 begin
  write(f,a[i,j],'      ');
     end;
   writeln(f,'');
  end;

   std:=n;
   //������ ��������� ��������� ������� �����������
   for x:=1 to n do
            for y:=1 to std do
              if x=y then d[x,y]:='+1' else d[x,y]:='0';

            z:=n;
//������� ���� �� ������� ������� �
for b:=1 to z do
  begin
gg:=100; stol0:=0;k:=0;t:=1;r:=1;h:=1;hh:=1;p:=1;
                 for j:=1 to m do

                    begin
                   			   nol:=0;
                 					 for i:=1 to n do
                  					 begin
                  						  if a[i,j]='0' then
                                 nol:=nol+1;

                             end;

                          if nol=n then inc(k) else
                               for i:=1 to n do
                                c[i,t]:=a[i,j];
                              if nol<>n then inc(t);

                   end;


                 r:=m-k;
                  minst:=0;
               for t:=1 to r do
                begin
                  nenol:=0;
                 for i:=1 to n do begin
                   if c[i,t]<>'0' then begin nenol:=nenol+1;end;
                   end;
                   if nenol>0 then
                     if gg>nenol then begin
                     gg:=nenol;
                     minst:=t;
                     end;
                  end;
                  if minst=0 then goto 1;


                             edin:=0;medin:=0;
                  for i:=1 to n do
                   begin
	str:=c[i,minst];
                   if str[1]='+' then edin:=edin+1;
                   if str[1]='-' then medin:=medin+1;
                   end;

                    if (edin>0) and (medin=0) then begin
                      for i:=1 to n do
                        for t:=1 to r do
		begin
		str:=c[i,t];
                         if (t=minst) and (str[1]='+') then minstr:=i;end;

                              for t:=1 to r do
                           begin
                            for i:=1 to n do
                            begin
                            if t<>minst then
                              vsp1[i,p]:=c[i,t];

                             end;
                            if t<>minst then inc(p);
                         end;
                          for i:=1 to n do
                           begin
                            for p:=1 to r-1 do begin
                             if i<>minstr then
                              vsp2[h,p]:=vsp1[i,p];end;

                              if i<>minstr then inc(h);
                             end;

                                for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr then
                              vsp4[hh,y]:=d[x,y];end;

                              if x<>minstr then inc(hh);
                             end;
                    end;


                    if (edin=0) and (medin>0) then begin
                      for i:=1 to n do
                        for t:=1 to r do
		begin
		str:=c[i,t];
                         if (t=minst) and (str[1]='-') then minstr:=i;end;

                              for t:=1 to r do
                           begin
                            for i:=1 to n do
                            begin
                            if t<>minst then
                              vsp1[i,p]:=c[i,t];

                             end;
                            if t<>minst then inc(p);
                         end;
                          for i:=1 to n do
                           begin
                            for p:=1 to r-1 do begin
                             if i<>minstr then
                              vsp2[h,p]:=vsp1[i,p];end;

                              if i<>minstr then inc(h);
                             end;

                             for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr then
                              vsp4[hh,y]:=d[x,y];end;

                              if x<>minstr then inc(hh);
                             end;
                    end;


                    if (edin>0) and (medin>0) then begin
                                    for i:=1 to n do
                        for t:=1 to r do
		begin
		str:=c[i,t];
                         if (t=minst) and (str[1]='-') then begin minstr1:=i;Cqj:=c[i,t];end;end;
                         for i:=1 to n do
                        for t:=1 to r do
		begin
		str:=c[i,t];
                         if (t=minst) and (str[1]='+') then begin minstr2:=i;Cpj:=c[i,t];end;end;
                               for i:=1 to n do
                        for t:=1 to r do begin
                                                           str:=c[minstr2,t];str1:=c[minstr1,t];
                         if i<>minstr1 then vsp3[i,t]:=c[i,t] else
                         begin

                          vsp3[i,t]:='-1'+'*'+Cqj+'*1'+c[minstr2,t]+';'+'+1'+'*'+Cpj+'*1'+c[minstr1,t];
s:=vsp3[i,t];
s2:=s;
  ks:=length(s);

    for ii:=0 to ks do
      begin


      if s[ii]=';' then hs:=ii;

      end;
     delete(s,hs,ks-hs+1);

             k1:=length(s);


              if (s[5]='0') or (s[4]='0') then  begin delete(s,1,k1+1); s1:=s;
               end;
              if (s[4]='+') then delete(s,2,3);
              if (s[4]='-') then begin delete(s,1,4);insert('+',s,1);end;
              k2:=length(s);
              for ii:=0 to k2 do
               if s[ii]='*' then h1:=ii;

               s4:=s;s5:=s;kkk:=length(s4);kkkk:=length(s5);
               if s4[1]='-' then begin delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);end;
               if s4[1]<>'-' then begin delete(s4,h1,kkk-h1+1);s6:=s4;end;
               delete(s5,1,h1+2);
               if (s[1]='-') and (s[h1+2]='+') then begin delete(s,h1,3);s1:=s;k3:=length(s1);end;
               if (s[1]='-') and (s[h1+2]='-') then begin delete(s,h1,3);s1:=s;delete(s1,1,1);
               insert('+',s1,1);k3:=length(s1); end;
               if (s[1]<>'-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
               if (s[1]='-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
               if (s[1]<>'-') and (s[h1+2]='-') then begin delete(s,h1,3);s1:=s;delete(s1,1,1);
               insert('-',s1,1);k3:=length(s1); end;
               if (s[1]<>'-') and (s[h1+2]='+') then begin delete(s,h1,3);s1:=s;k3:=length(s1);end;

               kk:=length(s1);kkk:=length(s6);kkkk:=length(s5);


               if (s1[1]='-') and (s6=s5) then s1:='-'+s6;
               if (s1[1]='+') and (s6=s5) then s1:=s6;
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

               if (s2[1]='-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;
               if (s2[1]='-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='+';k4:=length(s3); end;
               if (s2[1]<>'-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
               if (s2[1]='-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
               if (s2[1]<>'-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='-';k4:=length(s3); end;
               if (s2[1]<>'-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;

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
                if ss1=ss2 then begin
         if (s1[1]='-') and (s3[1]='+') then ss:='0';
         if (s1[1]='+') and (s3[1]='-') then ss:='0';
         if (s1[1]='-') and (s3[1]='-') then ss:='-2'+ss1;
         if (s1[1]='+') and (s3[1]='+') then ss:='2'+ss1;

          end else begin
              if (k3<>0) and (k4=0) then begin
                if s1[1]='+' then ss:='+'+ss1;
                if s1[1]='-' then ss:='-'+ss1;
                 end;
                   if (k3=0) and (k4<>0) then
	 begin
                if s3[1]='+' then ss:='+'+ss2;
                if s3[1]='-' then ss:='-'+ss2;
                 end;

                   if (k3=0) and (k4=0) then ss:='0';

               if (k3<>0) and (k4<>0) then begin
                  if (s1[1]='+') and (s3[1]='+') then begin
                   ss:='+('+ss1+'+'+ss2+')';
                   end;
if (s1[1]='0') and (s3[1]='0') then begin
                   ss:='0';
                   end;
if (s1[1]='0') and (s3[1]='+') then begin
                   ss:='+'+ss2;
                   end;
if (s1[1]='0') and (s3[1]='-') then begin
                   ss:='-'+ss2;
                   end;
if (s1[1]='+') and (s3[1]='0') then begin
                   ss:='+'+ss1;
                   end;
if (s1[1]='-') and (s3[1]='0') then begin
                   ss:='-'+ss1;
                   end;
                  if (s1[1]='+') and (s3[1]='-') then begin
	delete(s1,1,1);
                   ss:=s1+s3;insert('+(',ss,1);k11:=length(ss);insert(')',ss,k11+1);
                   end;
                  if (s1[1]='-') and (s3[1]='-') then begin ss:='-('+ss1+'+'+ss2+')';end;
                  if (s1[1]='-') and (s3[1]='+') then begin ss:='-('+ss1+'-'+ss2+')';end;
                  end;

                end;


vsp3[i,t]:=ss;

                         end;

                         end;


                           for t:=1 to r do
                           begin
                            for i:=1 to n do
                            begin
                            if t<>minst then
                              vsp1[i,p]:=vsp3[i,t];

                             end;
                            if t<>minst then inc(p);
                         end;
                          for i:=1 to n do
                           begin
                            for p:=1 to r-1 do begin
                             if i<>minstr2 then
                              vsp2[h,p]:=vsp1[i,p];end;

                              if i<>minstr2 then inc(h);
                             end;



                       for x:=1 to n do
                        for y:=1 to std do
                        begin
                         if x<>minstr1 then vsp5[x,y]:=d[x,y] else begin
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


              if (s[5]='0') or (s[4]='0') then  begin delete(s,1,k1+1); s1:=s;
               end;
              if (s[4]='+') then delete(s,2,3);
              if (s[4]='-') then begin delete(s,1,4);insert('+',s,1);end;
              k2:=length(s);
              for ii:=0 to k2 do
               if s[ii]='*' then h1:=ii;

               s4:=s;s5:=s;kkk:=length(s4);kkkk:=length(s5);
               if s4[1]='-' then begin delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);end;
               if s4[1]<>'-' then begin delete(s4,h1,kkk-h1+1);s6:=s4;end;
               delete(s5,1,h1+2);
if s[h1+3]<>'1' then begin
               if (s[1]='-') and (s[h1+2]='+') then begin delete(s,h1,3);s1:=s;k3:=length(s1);end;
               if (s[1]='-') and (s[h1+2]='-') then begin delete(s,h1,3);s1:=s;delete(s1,1,1);
               insert('+',s1,1);k3:=length(s1); end;
               if (s[1]<>'-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
               if (s[1]='-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
               if (s[1]<>'-') and (s[h1+2]='-') then begin delete(s,h1,3);s1:=s;delete(s1,1,1);
               insert('-',s1,1);k3:=length(s1); end;
               if (s[1]<>'-') and (s[h1+2]='+') then begin delete(s,h1,3);s1:=s;k3:=length(s1);end;
end else begin
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
               if (s1[1]='+') and (s6=s5) then s1:=s6;
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
if s2[h1+3]<>'1' then begin
               if (s2[1]='-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;
               if (s2[1]='-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='+';k4:=length(s3); end;
               if (s2[1]<>'-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
               if (s2[1]='-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
               if (s2[1]<>'-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='-';k4:=length(s3); end;
               if (s2[1]<>'-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;
end else begin
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
                if ss1=ss2 then begin
         if (s1[1]='-') and (s3[1]='+') then ss:='0';
         if (s1[1]='+') and (s3[1]='-') then ss:='0';
         if (s1[1]='-') and (s3[1]='-') then ss:='-2'+ss1;
         if (s1[1]='+') and (s3[1]='+') then ss:='2'+ss1;

          end else begin
              if (k3<>0) and (k4=0) then begin
                if s1[1]='+' then ss:='+'+ss1;
                if s1[1]='-' then ss:='-'+ss1;
                 end;
                   if (k3=0) and (k4<>0) then
	 begin
                if s3[1]='+' then ss:='+'+ss2;
                if s3[1]='-' then ss:='-'+ss2;
                 end;

                   if (k3=0) and (k4=0) then ss:='0';

               if (k3<>0) and (k4<>0) then begin
                  if (s1[1]='+') and (s3[1]='+') then begin
                   ss:='+('+ss1+'+'+ss2+')';
                   end;
if (s1[1]='0') and (s3[1]='0') then begin
                   ss:='0';
                   end;
if (s1[1]='0') and (s3[1]='+') then begin
                   ss:='+'+ss2;
                   end;
if (s1[1]='0') and (s3[1]='-') then begin
                   ss:='-'+ss2;
                   end;
if (s1[1]='+') and (s3[1]='0') then begin
                   ss:='+'+ss1;
                   end;
if (s1[1]='-') and (s3[1]='0') then begin
                   ss:='-'+ss1;
                   end;
                  if (s1[1]='+') and (s3[1]='-') then begin
	delete(s1,1,1);
                   ss:=s1+s3;insert('+(',ss,1);k11:=length(ss);insert(')',ss,k11+1);
                   end;
                  if (s1[1]='-') and (s3[1]='-') then begin ss:='-('+ss1+'+'+ss2+')';end;
                  if (s1[1]='-') and (s3[1]='+') then begin ss:='-('+ss1+'-'+ss2+')';end;
                  end;

                end;
vsp5[x,y]:=ss;

end;
end;

                          for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr2 then
                              vsp4[hh,y]:=vsp5[x,y];end;

                              if x<>minstr2 then inc(hh);
                             end;
                  end;//�������� 3 ������ ���������
 writeln(f,'������ � ',b);
writeln(f,'matrica c');
   for h:=1 to n-1 do
   begin
       for p:=1 to r-1 do
           begin
           write(f,vsp2[h,p],'         ');
          end;
         writeln(f,'');

     end;
                    nn:=n-1;
                  writeln(f,'matrica d');
                    for hh:=1 to n-1 do
                    begin
                      for y:=1 to std do
                        begin
                        write(f,vsp4[hh,y],'        ');end;
                        writeln(f,'');
                        end;
                        loop2:=0;ch22:=0;
      for y:=1 to std do begin
      ch2:=0;
     for hh:=1 to n do begin
     if (vsp4[hh,y]<>'0') and (vsp4[hh,y]<>'+0') then ch2:=ch2+1;end;
     if  ch2>0 then inc(ch22);inc(loop2);
     end;

        1:
        n:=n-1;
        m:=m-k-1;
  for h:=1 to n do
for p:=1 to m do
    a[h,p]:=vsp2[h,p];

    for hh:=1 to n do
     for y:=1 to std do
      d[hh,y]:=vsp4[hh,y];

        end;

     writeln(f,'���������� ����������� ����� '+inttostr(nn));
     rang2:=startmatrix.RowCount-1-nn;
     inv4:=nn;
     // edit3.Text:=inttostr(rang2);
        closefile(f);
Memo1.Lines.LoadFromFile(FName);
   end;
   // ���������� ����������� ��� ����������������� �������
rewrite(f);
 n:=startmatrix.ColCount-1;
m:=startmatrix.RowCount-1;

//������ ��������� ������� �������������

for i:=1 to n do
  for j:=1 to m do
   a[i,j]:=startMatrix.Cells[i,j];
   writeln(f,'�������� ������� �������������');
      for i:=1 to n do
 begin
 for j:=1 to m do
 begin
  write(f,a[i,j],'      ');
     end;
   writeln(f,'');
  end;

   std:=n;
  //������ ��������� ��������� ������� �����������
   for x:=1 to n do
            for y:=1 to std do
              if x=y then d[x,y]:='+1' else d[x,y]:='0';

            z:=n;
//������� ���� �� ������� ������� �
for b:=1 to z do
  begin
gg:=100; stol0:=0;k:=0;t:=1;r:=1;h:=1;hh:=1;p:=1;
                 for j:=1 to m do

                    begin
                   			   nol:=0;
                 					 for i:=1 to n do
                  					 begin
                  						  if a[i,j]='0' then
                                 nol:=nol+1;

                             end;

                          if nol=n then inc(k) else
                               for i:=1 to n do
                                c[i,t]:=a[i,j];
                              if nol<>n then inc(t);

                   end;


                 r:=m-k;
                  minst:=0;
               for t:=1 to r do
                begin
                  nenol:=0;
                 for i:=1 to n do begin
                   if c[i,t]<>'0' then begin nenol:=nenol+1;end;
                   end;
                   if nenol>0 then
                     if gg>nenol then begin
                     gg:=nenol;
                     minst:=t;
                     end;
                  end;
                  if minst=0 then goto 2;


                             edin:=0;medin:=0;
                  for i:=1 to n do
                   begin
	str:=c[i,minst];
                   if str[1]='+' then edin:=edin+1;
                   if str[1]='-' then medin:=medin+1;
                   end;

                    if (edin>0) and (medin=0) then begin
                      for i:=1 to n do
                        for t:=1 to r do
		begin
		str:=c[i,t];
                         if (t=minst) and (str[1]='+') then minstr:=i;end;

                              for t:=1 to r do
                           begin
                            for i:=1 to n do
                            begin
                            if t<>minst then
                              vsp1[i,p]:=c[i,t];

                             end;
                            if t<>minst then inc(p);
                         end;
                          for i:=1 to n do
                           begin
                            for p:=1 to r-1 do begin
                             if i<>minstr then
                              vsp2[h,p]:=vsp1[i,p];end;

                              if i<>minstr then inc(h);
                             end;

                                for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr then
                              vsp4[hh,y]:=d[x,y];end;

                              if x<>minstr then inc(hh);
                             end;
                    end;


                    if (edin=0) and (medin>0) then begin
                      for i:=1 to n do
                        for t:=1 to r do
		begin
		str:=c[i,t];
                         if (t=minst) and (str[1]='-') then minstr:=i;end;

                              for t:=1 to r do
                           begin
                            for i:=1 to n do
                            begin
                            if t<>minst then
                              vsp1[i,p]:=c[i,t];

                             end;
                            if t<>minst then inc(p);
                         end;
                          for i:=1 to n do
                           begin
                            for p:=1 to r-1 do begin
                             if i<>minstr then
                              vsp2[h,p]:=vsp1[i,p];end;

                              if i<>minstr then inc(h);
                             end;

                             for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr then
                              vsp4[hh,y]:=d[x,y];end;

                              if x<>minstr then inc(hh);
                             end;
                    end;


                    if (edin>0) and (medin>0) then begin
                                    for i:=1 to n do
                        for t:=1 to r do
		begin
		str:=c[i,t];
                         if (t=minst) and (str[1]='-') then begin minstr1:=i;Cqj:=c[i,t];end;end;
                         for i:=1 to n do
                        for t:=1 to r do
		begin
		str:=c[i,t];
                         if (t=minst) and (str[1]='+') then begin minstr2:=i;Cpj:=c[i,t];end;end;
                               for i:=1 to n do
                        for t:=1 to r do begin
                                                           str:=c[minstr2,t];str1:=c[minstr1,t];
                         if i<>minstr1 then vsp3[i,t]:=c[i,t] else
                         begin

                          vsp3[i,t]:='-1'+'*'+Cqj+'*1'+c[minstr2,t]+';'+'+1'+'*'+Cpj+'*1'+c[minstr1,t];
s:=vsp3[i,t];
s2:=s;
  ks:=length(s);

    for ii:=0 to ks do
      begin


      if s[ii]=';' then hs:=ii;

      end;
     delete(s,hs,ks-hs+1);

             k1:=length(s);


              if (s[5]='0') or (s[4]='0') then  begin delete(s,1,k1+1); s1:=s;
               end;
              if (s[4]='+') then delete(s,2,3);
              if (s[4]='-') then begin delete(s,1,4);insert('+',s,1);end;
              k2:=length(s);
              for ii:=0 to k2 do
               if s[ii]='*' then h1:=ii;

               s4:=s;s5:=s;kkk:=length(s4);kkkk:=length(s5);
               if s4[1]='-' then begin delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);end;
               if s4[1]<>'-' then begin delete(s4,h1,kkk-h1+1);s6:=s4;end;
               delete(s5,1,h1+2);
               if (s[1]='-') and (s[h1+2]='+') then begin delete(s,h1,3);s1:=s;k3:=length(s1);end;
               if (s[1]='-') and (s[h1+2]='-') then begin delete(s,h1,3);s1:=s;delete(s1,1,1);
               insert('+',s1,1);k3:=length(s1); end;
               if (s[1]<>'-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
               if (s[1]='-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
               if (s[1]<>'-') and (s[h1+2]='-') then begin delete(s,h1,3);s1:=s;delete(s1,1,1);
               insert('-',s1,1);k3:=length(s1); end;
               if (s[1]<>'-') and (s[h1+2]='+') then begin delete(s,h1,3);s1:=s;k3:=length(s1);end;

               kk:=length(s1);kkk:=length(s6);kkkk:=length(s5);


               if (s1[1]='-') and (s6=s5) then s1:='-'+s6;
               if (s1[1]='+') and (s6=s5) then s1:=s6;
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

               if (s2[1]='-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;
               if (s2[1]='-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='+';k4:=length(s3); end;
               if (s2[1]<>'-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
               if (s2[1]='-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
               if (s2[1]<>'-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='-';k4:=length(s3); end;
               if (s2[1]<>'-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;

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
                if ss1=ss2 then begin
         if (s1[1]='-') and (s3[1]='+') then ss:='0';
         if (s1[1]='+') and (s3[1]='-') then ss:='0';
         if (s1[1]='-') and (s3[1]='-') then ss:='-2'+ss1;
         if (s1[1]='+') and (s3[1]='+') then ss:='2'+ss1;

          end else begin
              if (k3<>0) and (k4=0) then begin
                if s1[1]='+' then ss:='+'+ss1;
                if s1[1]='-' then ss:='-'+ss1;
                 end;
                   if (k3=0) and (k4<>0) then
	 begin
                if s3[1]='+' then ss:='+'+ss2;
                if s3[1]='-' then ss:='-'+ss2;
                 end;

                   if (k3=0) and (k4=0) then ss:='0';

               if (k3<>0) and (k4<>0) then begin
                  if (s1[1]='+') and (s3[1]='+') then begin
                   ss:='+('+ss1+'+'+ss2+')';
                   end;
if (s1[1]='0') and (s3[1]='0') then begin
                   ss:='0';
                   end;
if (s1[1]='0') and (s3[1]='+') then begin
                   ss:='+'+ss2;
                   end;
if (s1[1]='0') and (s3[1]='-') then begin
                   ss:='-'+ss2;
                   end;
if (s1[1]='+') and (s3[1]='0') then begin
                   ss:='+'+ss1;
                   end;
if (s1[1]='-') and (s3[1]='0') then begin
                   ss:='-'+ss1;
                   end;
                  if (s1[1]='+') and (s3[1]='-') then begin
	delete(s1,1,1);
                   ss:=s1+s3;insert('+(',ss,1);k11:=length(ss);insert(')',ss,k11+1);
                   end;
                  if (s1[1]='-') and (s3[1]='-') then begin ss:='-('+ss1+'+'+ss2+')';end;
                  if (s1[1]='-') and (s3[1]='+') then begin ss:='-('+ss1+'-'+ss2+')';end;
                  end;

                end;


vsp3[i,t]:=ss;

                         end;

                         end;


                           for t:=1 to r do
                           begin
                            for i:=1 to n do
                            begin
                            if t<>minst then
                              vsp1[i,p]:=vsp3[i,t];

                             end;
                            if t<>minst then inc(p);
                         end;
                          for i:=1 to n do
                           begin
                            for p:=1 to r-1 do begin
                             if i<>minstr2 then
                              vsp2[h,p]:=vsp1[i,p];end;

                              if i<>minstr2 then inc(h);
                             end;



                       for x:=1 to n do
                        for y:=1 to std do
                        begin
                         if x<>minstr1 then vsp5[x,y]:=d[x,y] else begin
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


              if (s[5]='0') or (s[4]='0') then  begin delete(s,1,k1+1); s1:=s;
               end;
              if (s[4]='+') then delete(s,2,3);
              if (s[4]='-') then begin delete(s,1,4);insert('+',s,1);end;
              k2:=length(s);
              for ii:=0 to k2 do
               if s[ii]='*' then h1:=ii;

               s4:=s;s5:=s;kkk:=length(s4);kkkk:=length(s5);
               if s4[1]='-' then begin delete(s4,h1,kkk-h1+1);s6:=s4;delete(s6,1,1);end;
               if s4[1]<>'-' then begin delete(s4,h1,kkk-h1+1);s6:=s4;end;
               delete(s5,1,h1+2);
if s[h1+3]<>'1' then begin
               if (s[1]='-') and (s[h1+2]='+') then begin delete(s,h1,3);s1:=s;k3:=length(s1);end;
               if (s[1]='-') and (s[h1+2]='-') then begin delete(s,h1,3);s1:=s;delete(s1,1,1);
               insert('+',s1,1);k3:=length(s1); end;
               if (s[1]<>'-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
               if (s[1]='-') and (s[h1+2]='0') then begin delete(s,1,k2-1);s1:=s;k3:=0;end;
               if (s[1]<>'-') and (s[h1+2]='-') then begin delete(s,h1,3);s1:=s;delete(s1,1,1);
               insert('-',s1,1);k3:=length(s1); end;
               if (s[1]<>'-') and (s[h1+2]='+') then begin delete(s,h1,3);s1:=s;k3:=length(s1);end;
end else begin
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
               if (s1[1]='+') and (s6=s5) then s1:=s6;
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
if s2[h1+3]<>'1' then begin
               if (s2[1]='-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;
               if (s2[1]='-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='+';k4:=length(s3); end;
               if (s2[1]<>'-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
               if (s2[1]='-') and (s2[h1+2]='0') then begin delete(s2,1,k4-1);s3:=s2;k4:=0;end;
               if (s2[1]<>'-') and (s2[h1+2]='-') then begin delete(s2,h1,3);s3:=s2;s3[1]:='-';k4:=length(s3); end;
               if (s2[1]<>'-') and (s2[h1+2]='+') then begin delete(s2,h1,3);s3:=s2;k4:=length(s3);end;
end else begin
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
                if ss1=ss2 then begin
         if (s1[1]='-') and (s3[1]='+') then ss:='0';
         if (s1[1]='+') and (s3[1]='-') then ss:='0';
         if (s1[1]='-') and (s3[1]='-') then ss:='-2'+ss1;
         if (s1[1]='+') and (s3[1]='+') then ss:='2'+ss1;

          end else begin
              if (k3<>0) and (k4=0) then begin
                if s1[1]='+' then ss:='+'+ss1;
                if s1[1]='-' then ss:='-'+ss1;
                 end;
                   if (k3=0) and (k4<>0) then
	 begin
                if s3[1]='+' then ss:='+'+ss2;
                if s3[1]='-' then ss:='-'+ss2;
                 end;

                   if (k3=0) and (k4=0) then ss:='0';

               if (k3<>0) and (k4<>0) then begin
                  if (s1[1]='+') and (s3[1]='+') then begin
                   ss:='+('+ss1+'+'+ss2+')';
                   end;
if (s1[1]='0') and (s3[1]='0') then begin
                   ss:='0';
                   end;
if (s1[1]='0') and (s3[1]='+') then begin
                   ss:='+'+ss2;
                   end;
if (s1[1]='0') and (s3[1]='-') then begin
                   ss:='-'+ss2;
                   end;
if (s1[1]='+') and (s3[1]='0') then begin
                   ss:='+'+ss1;
                   end;
if (s1[1]='-') and (s3[1]='0') then begin
                   ss:='-'+ss1;
                   end;
                  if (s1[1]='+') and (s3[1]='-') then begin
	delete(s1,1,1);
                   ss:=s1+s3;insert('+(',ss,1);k11:=length(ss);insert(')',ss,k11+1);
                   end;
                  if (s1[1]='-') and (s3[1]='-') then begin ss:='-('+ss1+'+'+ss2+')';end;
                  if (s1[1]='-') and (s3[1]='+') then begin ss:='-('+ss1+'-'+ss2+')';end;
                  end;

                end;
vsp5[x,y]:=ss;

end;
end;

                          for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr2 then
                              vsp4[hh,y]:=vsp5[x,y];end;

                              if x<>minstr2 then inc(hh);
                             end;
                  end;//�������� 3 ������ ���������
 writeln(f,'������ � ',b);
writeln(f,'matrica c');
   for h:=1 to n-1 do
   begin
       for p:=1 to r-1 do
           begin
           write(f,vsp2[h,p],'         ');
          end;
         writeln(f,'');

     end;
                    nnn:=n-1;
                  writeln(f,'matrica d');
                    for hh:=1 to n-1 do
                    begin
                      for y:=1 to std do
                        begin
                        write(f,vsp4[hh,y],'        ');end;
                        writeln(f,'');
                        end;

                loop1:=0;ch11:=0;
      for y:=1 to std do begin
      ch1:=0;
     for hh:=1 to n do begin
     if (vsp4[hh,y]<>'0') and (vsp4[hh,y]<>'+0') then ch1:=ch1+1;end;
     if  ch1>0 then inc(ch11);inc(loop1);
         end;

            2:
        n:=n-1;
        m:=m-k-1;
  for h:=1 to n do
for p:=1 to m do
    a[h,p]:=vsp2[h,p];

    for hh:=1 to n do
     for y:=1 to std do
      d[hh,y]:=vsp4[hh,y];

        end;

     writeln(f,'���������� ����������� ����� '+inttostr(nnn));
     rang1:=transmatrix.RowCount-1-nnn;
inv3:=nnn;
if rang2<=rang1 then rang1:=rang2;
if rang2>rang1 then rang2:=rang1;
edit4.Text:=inttostr(rang1);
edit3.Text:=inttostr(rang2);
        closefile(f);
Memo2.Lines.LoadFromFile(FName);
 if (inv3>0) and (inv4>0) then begin
         if (ch11=loop1) and (ch22=loop2) then ShowMessage('������������ ������ �������� ����������: 1.��� ������� ���������; 2.��� �������� �����');
    if (ch11<>loop1) and (ch22=loop2) then  ShowMessage('������������ ������ �������� ����������: 1. ��� ������� ���������; 2. �� ��� ��������  �����');
    if (ch11=loop1) and (ch22<>loop2) then  ShowMessage('������������ ������ �������� ����������: 1. �� ��� ������� ���������; 2. ��� �������� �����');
     if (ch11<>loop1) and (ch22<>loop2) then ShowMessage('������������ ������ �������� ����������: 1. �� ��� ������� ���������; 2.�� ��� �������� �����');
    end;
  if (inv3=0) and (inv4>0) and (ch11=loop1) then  ShowMessage('������������ ������ �������� ������������, �� �� ����������.� ������ ���� ��� ������� ���������');
  if (inv3=0) and (inv4>0) and (ch11<>loop1) then  ShowMessage('������������ ������ �������� �� ������������, �� ����������.� ������ ���� �� ��� �������� �����');
   if (inv3>0) and (inv4=0) and (ch22=loop2) then  ShowMessage('������������ ������ �������� ��������������, �� ����������.� ������ ����  ��� �������� �����');
    if (inv3>0) and (inv4=0) and (ch22<>loop2) then  ShowMessage('������������ ������ �������� ������������, �� �� ����������.� ������ ���� �� ��� ������� ���������');
   if (inv3=0) and (inv4=0)  then  ShowMessage('������������ ������ �������� �������������� � �� ����������.�.� ��� P � � ����,�� ���������������� �������� ����������� ������������ ������');
   end;
 


procedure TForm8.BitBtn1Click(Sender: TObject);
begin
form8.Close;
end;

procedure TForm8.BitBtn3Click(Sender: TObject);

var FName:string;
begin
OpenDialog1.Title:= '�������� ������������� �����';

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
TransMatrix.RowCount:=1;
TransMatrix.ColCount:=1;
Memo1.Lines.Text:='';
Memo2.Lines.Text:='';
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
var FName,s:string;
i,j,m,n,k:integer;
f:textfile;
begin
OpenDialog1.Title:= '�������� ������������� �����';

if OpenDialog1.Execute and FileExists(OpenDialog1.FileName) then
 begin
 FName:=OpenDialog1.FileName;
 Case OpenDialog1.FilterIndex of
  1:FName:=ChangeFileExt(FName,'.txt');
  2:FName:=ChangeFileExt(FName,'.doc');
  end;
  end;
  assignfile(f,FName);
reset(f);
 m:=startmatrix.ColCount;
 n:=startmatrix.RowCount;
      i:=0;j:=0;k:=0;
 while not eof(f) do begin

readln(f,s);

  startmatrix.Cells[i,j]:=s;

  //inc(k);
  inc(i);
  if i=m then begin inc(j);i:=0;end;
 
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
TransMatrix.RowCount:=1;
TransMatrix.ColCount:=1;
Memo1.Lines.Text:='';
Memo2.Lines.Text:='';
end;

end.
