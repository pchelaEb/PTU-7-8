unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons,Matr_Op, ExtCtrls;

type
  TForm4 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    StartMatrix: TStringGrid;
    Label3: TLabel;
    Label4: TLabel;
    TransMatrix: TStringGrid;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Edit4: TEdit;
    BitBtn1: TBitBtn;
    SaveDialog1: TSaveDialog;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    BitBtn3: TBitBtn;
    OpenDialog1: TOpenDialog;
    Bevel7: TBevel;
    Bevel8: TBevel;
    BitBtn4: TBitBtn;
    Label7: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Label8: TLabel;
    Button2: TButton;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton6: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation
 Uses Unit5,Unit6,Unit3, Unit9, Unit10;
 type matr=array [1..100,1..100] of integer;
 var i,j,por,inv1,ch,ch2,loop1,sum,loop2,inv3,inv4,rang1,rang2,ValueStr,ValueStol,ValueStr2,ValueStol2,std,n:integer;
    cc,dd:Mp;
    res,res2:matr;
        res1,res3:array[1..100] of integer ;
     {$R *.dfm}
function Check(var x1,x2:Real):Boolean;
begin
Check:=False;
With Form4 do begin
try
 x1:=StrToInt(Edit1.Text);
except
 ShowMessage('�������� �������� ������� ��������');
 Edit1.SetFocus;exit;
end;
try
 x2:=StrToInt(Edit2.Text);
except
 ShowMessage('�������� �������� ������� ��������');
 Edit2.SetFocus;exit;
end;
end;
Check:=True;
end;



procedure TForm4.Button1Click(Sender: TObject);
var i,j:integer;
begin
// �������� ������� ������� � ���������
StartMatrix.Visible:=true;

Edit3.Visible:=true;
if strtoint(edit1.Text)>=50 then begin ShowMessage('���������� ������� �� ������ ��������� 50');exit;end;
if strtoint(edit2.Text)>=50 then  begin ShowMessage('���������� ��������� �� ������ ��������� 50');exit;end;
ShowMessage('������� ���������� �������:��� ���������� ����� ����������� �������� 1,0,-1');
StartMatrix.ColCount:=strtoint(edit1.Text)+1;
StartMatrix.RowCount:=strtoint(edit2.Text)+1;
ValueStr:=startmatrix.RowCount;
ValueStol:=startmatrix.ColCount;
for i:=0 to ValueStr do
for j:=0 to ValueStol do
if (i=0) and (j=0) then startmatrix.Cells[i,j]:=' ' else
if  i=0 then  startmatrix.Cells[i,j]:='t'+inttostr(j) else
if j=0 then startmatrix.Cells[i,j]:='p'+inttostr(i) else
startmatrix.Cells[i,j]:='0';
end;

procedure TForm4.Button2Click(Sender: TObject);
var FName1:string;
lol,mol:integer;
f:textfile;
begin
SaveDialog1.Title:='�������� ����� ��� �������';
SaveDialog1.FileName:='�����1';
if SaveDialog1.Execute then begin
 FName1:=SaveDialog1.FileName;
  Case SaveDialog1.FilterIndex of
  1:FName1:=ChangeFileExt(FName1,'.txt');
  2:FName1:=ChangeFileExt(FName1,'.doc');
  end;  end;
 SaveDialog1.Filter:='.txt';
 assignFile(f,FName1);
rewrite(f);
writeln(f,'�������������� ������ ��� �-���� �����:');
for i:=1 to startmatrix.RowCount-1 do
write(f,inttostr(res3[i]),' ');
writeln(f,'');
lol:=0;
for i:=1 to startmatrix.RowCount-1 do
if res3[i]<>0 then writeln(f,'������� t',inttostr(i),' �����') else begin writeln(f,'������� t',inttostr(i),' �������');lol:=lol+1;end;
writeln(f,'');
if lol>0 then writeln(f,'����� ������� � ������������ ������� �� ��� �������� �����') else
 writeln(f,'����� ������� � ������������ �������  ��� �������� �����');
writeln(f,'');
writeln(f,'�������������� ������ ��� �-���� �����:');
for i:=1 to transmatrix.RowCount-1 do
write(f,inttostr(res1[i]),' ');
writeln(f,'');
mol:=0;
for i:=1 to transmatrix.RowCount-1 do
if res1[i]<>0 then writeln(f,'������� p',inttostr(i),' ���������') else begin writeln(f,'������� p',inttostr(i),' �����������');mol:=mol+1;end;
writeln(f,'');

if mol>0 then writeln(f,'����� ������� � ������������ ������� �� ��� ������� ���������') else
writeln(f,'����� ������� � ������������ �������  ��� ������� ���������');


   if (inv3=0) and (inv4=0)  then  writeln(f,'������������ ������ �������� �������������� � �� ����������.�.� ��� P � � ����,�� ���������������� �������� ����������� ������������ ������');
   closefile(f);
   form9.show;
   form9.Memo1.Lines.LoadFromFile(FName1);
 end;



procedure TForm4.BitBtn1Click(Sender: TObject);
begin
form4.Close;
end;

procedure TForm4.Button5Click(Sender: TObject);
var f:textfile;
FName:string;
 begin
 SaveDialog1.Title:='���������� ����������� ������������� ';
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
writeln(f,'���������� ������� ���� p �����');
writeln(f,edit1.text);
writeln(f,'���������� ��������� ���� t �����');
writeln(f,edit2.text);
writeln(f,'������� ������� � �������� ����� ���:');
for i:=0 to ValueStr do
 begin
 for j:=0 to ValueStol do
 begin
  write(f,startmatrix.cells[i,j],'      ');
     end;
   writeln(f,'');
  end;
writeln(f,'���� ������� ������� � �������� �����:');
writeln(f,edit3.text);
writeln(f,'����������������� ������� ������� � �������� ����� ���:');
for i:=0 to ValueStr do
 begin
 for j:=0 to ValueStol do
 begin
  write(f,TransMatrix.cells[i,j],'       ');
   end;
   writeln(f,'');
  end;
writeln(f,'���� ����������������� ������� ������� � �������� �����:');
writeln(f,edit4.text);
if inv3>0 then
writeln(f,'������������ ���� �������� ���������� � ����� '+inttostr(inv3)+' �- ����(�)')
else writeln(f,'������������ ���� �������� ������������ � �-���� �� �����');
 if inv4>0 then
writeln(f,'������������ ���� �������� ������������ � ����� '+inttostr(inv4)+' �- ����(�)')
else writeln(f,'������������ ���� �������� �������������� � �-���� �� �����');
closefile(f);
 end;
end;

procedure TForm4.BitBtn3Click(Sender: TObject);
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

procedure TForm4.BitBtn4Click(Sender: TObject);
type matr=array [1..100,1..100] of integer;
  var f:textfile;
   i,j,std,chedin,chmedin,i1,j1,b,z,m,n,nenol,gg,minst,minstr,minstr1,minstr2,stol0,nn,nol,stnenol,k,Cpj,Cqj,h,hh,p,l,t,r,rang1,nnn,rang2,medin,edin,x,y:integer;
        a,c,vsp1,vsp2,vsp3,vsp4,vsp34,vsp54,vsp5,d,inv:matr;
  FName:string;
  label 1,2,met,met2;
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
for i:=0 to ValueStr do
for j:=0 to ValueStol do
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
   a[i,j]:=strtoint(TransMatrix.Cells[i,j]);
   writeln(f,'�������� ������� �������������');
      for i:=1 to n do
 begin
 for j:=1 to m do
 begin
  write(f,inttostr(a[i,j]),'      ');
     end;
   writeln(f,'');
  end;

   std:=n;
   //������ ��������� ��������� ������� �����������
   for x:=1 to n do
            for y:=1 to std do
              if x=y then d[x,y]:=1 else d[x,y]:=0;

            z:=n;
//������� ���� �� ������� ������� �
for b:=1 to z do
  begin
//�� ������� ������� ����� ��������� ��������
               gg:=100; stol0:=0;k:=0;t:=1;r:=1;h:=1;hh:=1;p:=1;
//��������1: ����� ������� �������� � ������� �(���� ���� ����������)
                 for j:=1 to m do
                    begin
                     nol:=0;
               	       for i:=1 to n do
                           begin
                           if a[i,j]=0 then
                                 nol:=nol+1;
                           end;
              //���� ������� ������� ����, �� ���������� �� � ������� ������� �
                               if nol=n then inc(k) else
                               for i:=1 to n do
                                c[i,t]:=a[i,j];
                              if nol<>n then inc(t);

                     end;
                  r:=m-k;
                  minst:=0;
                  
  //������� ����������� ������� � ���������� ������� �
               for t:=1 to r do
                begin
                  nenol:=0;
                 for i:=1 to n do begin
                   if c[i,t]<>0 then begin nenol:=nenol+1;
                                     end;
                                   end;
                   if nenol>0 then
                     if gg>nenol then begin
                     gg:=nenol;
                     minst:=t;
                                      end;
                  end;
  //���� ������������ ������ ��� �� ������� �� �����
                  if minst=0 then goto 1;
  //���� � ���� ����������� ������� ���������� ������������� � �������.���������
                               edin:=0;medin:=0;
                  for i:=1 to n do
                   begin
                    if c[i,minst]>0 then edin:=edin+1;
                    if c[i,minst]<0 then medin:=medin+1;
                   end;
 //������ ��������� ������ 1: P<>1 Q=0
   //��������� �� ���.�������, �.� ������� ������� minst � ������ � �����.��������� �� ������� �
  if (edin>0) and (medin=0) then begin
  //���� ���-�� 1� � ����������� ������� =1
             if edin=1 then begin
             //������� ������ � �������.���������,���������� �� �����
                      for i:=1 to n do
                       for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) then minstr:=i;
           //������� ��������������� ������� vsp1,���������� �� � ������������ minst
    	 for t:=1 to r do
                           begin
                            for i:=1 to n do
                            begin
                            if t<>minst then
                              vsp1[i,p]:=c[i,t];

                             end;
                            if t<>minst then inc(p);
                         end;
                     //������� ��������������� ������� vsp2,���������� �� � ������������� ������ minstr
                          for i:=1 to n do
                           begin
                            for p:=1 to r-1 do begin
                             if i<>minstr then
                              vsp2[h,p]:=vsp1[i,p];end;

                              if i<>minstr then inc(h);
                             end;
                     //�������� ������� ����������� ������ ���.�������
//������� ��������������� ������� vsp4,���������� �� D ������������� minst
                                for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr then
                              vsp4[hh,y]:=d[x,y];end;

                              if x<>minstr then inc(hh);
                             end;
	end else
          //���� ���-�� 1� � ���. ������� >1
         begin
		for i:=1 to n do
                       	for t:=1 to r do
                        	 if (t=minst) and (c[i,t]>0) then minstr:=i;
		 for i:=1 to n do
                         		  begin
                          	  for p:=1 to r do begin
                             if i<>minstr then
                              vsp2[h,p]:=c[i,p];end;

                              if i<>minstr then inc(h);
                             end;

                                for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr then
                              vsp4[hh,y]:=d[x,y];end;

                              if x<>minstr then inc(hh);
                             end;
                             //���������� ����� ���-�� 1� ���� ����� 1
		goto met;
		end;

                    end;
        //�������� ������� ������ ��������

//������ ������ P=0 Q<>0
//���������� �������,������ ����� ���������� ������������ ������ � �����.���������

                    if (edin=0) and (medin>0) then begin
             if medin=1 then begin
                      for i:=1 to n do
                       for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) then minstr:=i;

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
	end else begin
		for i:=1 to n do
                       	for t:=1 to r do
                        	 if (t=minst) and (c[i,t]<0) then minstr:=i;
		 for i:=1 to n do
                         		  begin
                          	  for p:=1 to r do begin
                             if i<>minstr then
                              vsp2[h,p]:=c[i,p];end;

                              if i<>minstr then inc(h);
                             end;

                                for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr then
                              vsp4[hh,y]:=d[x,y];end;

                              if x<>minstr then inc(hh);
                             end;
		goto met;
		end;

                    end;

   //������ ������ P<>0 Q<>0
//����� ����������,�.� ���������� ����� � �������,������ � �����. � �����. ���������
//������ � �����.�� �������������, � �����. ��������� ��������������� �� �������
                    if (edin>0) and (medin>0) then begin
		if (edin=1) and (medin=1) then begin
                                    for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) then begin minstr1:=i;Cqj:=c[i,t];end;
                         for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) then begin minstr2:=i;Cpj:=c[i,t];end;
                               for i:=1 to n do
                        for t:=1 to r do
                         if i<>minstr1 then vsp3[i,t]:=c[i,t] else 
vsp3[i,t]:=(-1)*Cqj*c[minstr2,t]+Cpj*c[minstr1,t];

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
                         if x<>minstr1 then vsp5[x,y]:=d[x,y] else 
vsp5[x,y]:=(-1)*Cqj*d[minstr2,y]+Cpj*d[minstr1,y];

                         

                          for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr2 then
                              vsp4[hh,y]:=vsp5[x,y];end;

                              if x<>minstr2 then inc(hh);
                             end;
	end;


if (edin=1) and (medin>1) then begin
                                    for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) then begin minstr1:=i;Cqj:=c[i,t];end;
                         for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) then begin minstr2:=i;Cpj:=c[i,t];end;
                               for i:=1 to n do
                        for t:=1 to r do
                         if i<>minstr1 then vsp34[i,t]:=c[i,t] else 
vsp34[i,t]:=(-1)*Cqj*c[minstr2,t]+Cpj*c[minstr1,t];
  for x:=1 to n do
                        for y:=1 to std do
                         if x<>minstr1 then vsp54[x,y]:=d[x,y] else 
vsp54[x,y]:=(-1)*Cqj*d[minstr2,y]+Cpj*d[minstr1,y];
                        chmedin:=medin;
                        for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) and(chmedin=medin) then begin minstr1:=i;Cqj:=c[i,t];dec(chmedin);end;
                         for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) then begin minstr2:=i;Cpj:=c[i,t];end;
                               for i:=1 to n do
                        for t:=1 to r do
                         if i<>minstr1 then vsp3[i,t]:=vsp34[i,t] else 
vsp3[i,t]:=(-1)*Cqj*vsp34[minstr2,t]+Cpj*vsp34[minstr1,t];
  for x:=1 to n do
                        for y:=1 to std do
                         if x<>minstr1 then vsp5[x,y]:=vsp54[x,y] else 
vsp5[x,y]:=(-1)*Cqj*vsp54[minstr2,y]+Cpj*vsp54[minstr1,y];



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
                           begin
                            for y:=1 to std do begin
                             if x<>minstr2 then
                              vsp4[hh,y]:=vsp5[x,y];end;

                              if x<>minstr2 then inc(hh);
                             end;
	end;

if (edin>1) and (medin=1) then begin
                                    for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) then begin minstr1:=i;Cqj:=c[i,t];end;
                         for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) then begin minstr2:=i;Cpj:=c[i,t];end;
                               for i:=1 to n do
                        for t:=1 to r do
                         if i<>minstr2 then vsp34[i,t]:=c[i,t] else
vsp34[i,t]:=(-1)*Cqj*c[minstr2,t]+Cpj*c[minstr1,t];
                         for x:=1 to n do
                        for y:=1 to std do
                         if x<>minstr2 then vsp54[x,y]:=d[x,y] else 
vsp54[x,y]:=(-1)*Cqj*d[minstr2,y]+Cpj*d[minstr1,y];

                        for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) then begin minstr1:=i;Cqj:=c[i,t];end;
                         chedin:=edin;
                         for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) and (chedin=edin) then begin minstr2:=i;Cpj:=c[i,t];dec(chedin);end;
                               for i:=1 to n do
                        for t:=1 to r do
                         if i<>minstr2 then vsp3[i,t]:=vsp34[i,t] else
vsp3[i,t]:=(-1)*Cqj*vsp34[minstr2,t]+Cpj*vsp34[minstr1,t];
                        for x:=1 to n do
                        for y:=1 to std do
                         if x<>minstr2 then vsp5[x,y]:=vsp54[x,y] else 
vsp5[x,y]:=(-1)*Cqj*vsp54[minstr2,y]+Cpj*vsp54[minstr1,y];



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
                             if i<>minstr1 then
                              vsp2[h,p]:=vsp1[i,p];end;

                              if i<>minstr1 then inc(h);
                             end;

                                             

                          for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr1 then
                              vsp4[hh,y]:=vsp5[x,y];end;

                              if x<>minstr1 then inc(hh);
                             end;
	end;


                    end;
 writeln(f,'�������� � ',b);
writeln(f,'���������� ������� C');
   for h:=1 to n-1 do
   begin
       for p:=1 to r-1 do
           begin
           write(f,inttostr(vsp2[h,p]),'         ');
          end;
         writeln(f,'');

     end;
                    nn:=n-1;
                  writeln(f,'���������� ������� D');
                    for hh:=1 to n-1 do
                    begin
                      for y:=1 to std do
                        begin
                        write(f,inttostr(vsp4[hh,y]),'        ');end;
                        writeln(f,'');
                        end;
                         for y:=1 to std do
   begin
   sum:=0;
  for hh:=1 to n-1 do begin
  sum:=sum+vsp4[hh,y];end;
  res3[y]:=sum;
  end;

        1:
        m:=m-k-1;
       met:
        n:=n-1;

  for h:=1 to n do
for p:=1 to m do
    a[h,p]:=vsp2[h,p];

    for hh:=1 to n do
     for y:=1 to std do
      d[hh,y]:=vsp4[hh,y];

        end;
        ch2:=0;loop2:=0;
   for i:=1 to std do begin inc(loop2);
    if res3[y]>0 then ch2:=ch2+1; end;
     writeln(f,'���������� ����������� ����� '+inttostr(nn));
     rang2:=startmatrix.RowCount-1-nn;
     inv4:=nn;
      //edit3.Text:=inttostr(rang2);
        closefile(f);
Memo1.Lines.LoadFromFile(FName);



// ���������� ����������� ��� ����������������� �������
rewrite(f);
 n:=startmatrix.ColCount-1;
m:=startmatrix.RowCount-1;

//������ ��������� ������� �������������

for i:=1 to n do
  for j:=1 to m do
   a[i,j]:=strtoint(StartMatrix.Cells[i,j]);
   writeln(f,'�������� ������� �������������');
      for i:=1 to n do
 begin
 for j:=1 to m do
 begin
  write(f,inttostr(a[i,j]),'      ');
     end;
   writeln(f,'');
  end;

   std:=n;
   //������ ��������� ��������� ������� �����������
   for x:=1 to n do
            for y:=1 to std do
              if x=y then d[x,y]:=1 else d[x,y]:=0;

            z:=n;
//������� ���� �� ������� ������� �
for b:=1 to z do
  begin
//�� ������� ������� ����� ��������� ��������
               gg:=100; stol0:=0;k:=0;t:=1;r:=1;h:=1;hh:=1;p:=1;
//��������1: ����� ������� �������� � ������� �(���� ���� ����������)
                 for j:=1 to m do
                    begin
                     nol:=0;
               	       for i:=1 to n do
                           begin
                           if a[i,j]=0 then
                                 nol:=nol+1;
                           end;
              //���� ������� ������� ����, �� ���������� �� � ������� ������� �
                               if nol=n then inc(k) else
                               for i:=1 to n do
                                c[i,t]:=a[i,j];
                              if nol<>n then inc(t);

                     end;
                  r:=m-k;
                  minst:=0;
  //������� ����������� ������� � ���������� ������� �
               for t:=1 to r do
                begin
                  nenol:=0;
                 for i:=1 to n do begin
                   if c[i,t]<>0 then begin nenol:=nenol+1;
                                     end;
                                   end;
                   if nenol>0 then
                     if gg>nenol then begin
                     gg:=nenol;
                     minst:=t;
                                      end;
                  end;
  //���� ������������ ������ ��� �� ������� �� �����
                  if minst=0 then goto 2;
  //���� � ���� ����������� ������� ���������� ������������� � �������.���������
                               edin:=0;medin:=0;
                  for i:=1 to n do
                   begin
                    if c[i,minst]>0 then edin:=edin+1;
                    if c[i,minst]<0 then medin:=medin+1;
                   end;
    //������ ��������� ������ 1: P<>1 Q=0
   //��������� �� ���.�������, �.� ������� ������� minst � ������ � �����.��������� �� ������� �
  if (edin>0) and (medin=0) then begin
  //���� ���-�� 1� � ����������� ������� =1
             if edin=1 then begin
             //������� ������ � �������.���������,���������� �� �����
                      for i:=1 to n do
                       for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) then minstr:=i;
           //������� ��������������� ������� vsp1,���������� �� � ������������ minst
    	 for t:=1 to r do
                           begin
                            for i:=1 to n do
                            begin
                            if t<>minst then
                              vsp1[i,p]:=c[i,t];

                             end;
                            if t<>minst then inc(p);
                         end;
                     //������� ��������������� ������� vsp2,���������� �� � ������������� ������ minstr
                          for i:=1 to n do
                           begin
                            for p:=1 to r-1 do begin
                             if i<>minstr then
                              vsp2[h,p]:=vsp1[i,p];end;

                              if i<>minstr then inc(h);
                             end;
                     //�������� ������� ����������� ������ ���.�������
//������� ��������������� ������� vsp4,���������� �� D ������������� minst
                                for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr then
                              vsp4[hh,y]:=d[x,y];end;

                              if x<>minstr then inc(hh);
                             end;
	end else
          //���� ���-�� 1� � ���. ������� >1
         begin
		for i:=1 to n do
                       	for t:=1 to r do
                        	 if (t=minst) and (c[i,t]>0) then minstr:=i;
		 for i:=1 to n do
                         		  begin
                          	  for p:=1 to r do begin
                             if i<>minstr then
                              vsp2[h,p]:=c[i,p];end;

                              if i<>minstr then inc(h);
                             end;

                                for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr then
                              vsp4[hh,y]:=d[x,y];end;

                              if x<>minstr then inc(hh);
                             end;
                             //���������� ����� ���-�� 1� ���� ����� 1
		goto met2;
		end;

                    end;
        //�������� ������� ������ ��������

//������ ������ P=0 Q<>0
//���������� �������,������ ����� ���������� ������������ ������ � �����.���������

                    if (edin=0) and (medin>0) then begin
             if medin=1 then begin
                      for i:=1 to n do
                       for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) then minstr:=i;

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
	end else begin
		for i:=1 to n do
                       	for t:=1 to r do
                        	 if (t=minst) and (c[i,t]<0) then minstr:=i;
		 for i:=1 to n do
                         		  begin
                          	  for p:=1 to r do begin
                             if i<>minstr then
                              vsp2[h,p]:=c[i,p];end;

                              if i<>minstr then inc(h);
                             end;

                                for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr then
                              vsp4[hh,y]:=d[x,y];end;

                              if x<>minstr then inc(hh);
                             end;
		goto met2;
		end;

                    end; //�������� ������� ������ ���������

   //������ ������ P<>0 Q<>0
//����� ����������,�.� ���������� ����� � �������,������ � �����. � �����. ���������
//������ � �����.�� �������������, � �����. ��������� ��������������� �� �������
                    if (edin>0) and (medin>0) then begin
		if (edin=1) and (medin=1) then begin
                                    for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) then begin minstr1:=i;Cqj:=c[i,t];end;
                         for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) then begin minstr2:=i;Cpj:=c[i,t];end;
                               for i:=1 to n do
                        for t:=1 to r do
                         if i<>minstr1 then vsp3[i,t]:=c[i,t] else 
vsp3[i,t]:=(-1)*Cqj*c[minstr2,t]+Cpj*c[minstr1,t];

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
                         if x<>minstr1 then vsp5[x,y]:=d[x,y] else 
vsp5[x,y]:=(-1)*Cqj*d[minstr2,y]+Cpj*d[minstr1,y];

                         

                          for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr2 then
                              vsp4[hh,y]:=vsp5[x,y];end;

                              if x<>minstr2 then inc(hh);
                             end;
	end;


if (edin=1) and (medin>1) then begin
                                    for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) then begin minstr1:=i;Cqj:=c[i,t];end;
                         for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) then begin minstr2:=i;Cpj:=c[i,t];end;
                               for i:=1 to n do
                        for t:=1 to r do
                         if i<>minstr1 then vsp34[i,t]:=c[i,t] else 
vsp34[i,t]:=(-1)*Cqj*c[minstr2,t]+Cpj*c[minstr1,t];
  for x:=1 to n do
                        for y:=1 to std do
                         if x<>minstr1 then vsp54[x,y]:=d[x,y] else 
vsp54[x,y]:=(-1)*Cqj*d[minstr2,y]+Cpj*d[minstr1,y];
                        chmedin:=medin;
                        for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) and(chmedin=medin) then begin minstr1:=i;Cqj:=c[i,t];dec(chmedin);end;
                         for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) then begin minstr2:=i;Cpj:=c[i,t];end;
                               for i:=1 to n do
                        for t:=1 to r do
                         if i<>minstr1 then vsp3[i,t]:=vsp34[i,t] else 
vsp3[i,t]:=(-1)*Cqj*vsp34[minstr2,t]+Cpj*vsp34[minstr1,t];
  for x:=1 to n do
                        for y:=1 to std do
                         if x<>minstr1 then vsp5[x,y]:=vsp54[x,y] else 
vsp5[x,y]:=(-1)*Cqj*vsp54[minstr2,y]+Cpj*vsp54[minstr1,y];



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
                           begin
                            for y:=1 to std do begin
                             if x<>minstr2 then
                              vsp4[hh,y]:=vsp5[x,y];end;

                              if x<>minstr2 then inc(hh);
                             end;
	end;

if (edin>1) and (medin=1) then begin
                                    for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) then begin minstr1:=i;Cqj:=c[i,t];end;
                         for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) then begin minstr2:=i;Cpj:=c[i,t];end;
                               for i:=1 to n do
                        for t:=1 to r do
                         if i<>minstr2 then vsp34[i,t]:=c[i,t] else
vsp34[i,t]:=(-1)*Cqj*c[minstr2,t]+Cpj*c[minstr1,t];
                         for x:=1 to n do
                        for y:=1 to std do
                         if x<>minstr2 then vsp54[x,y]:=d[x,y] else 
vsp54[x,y]:=(-1)*Cqj*d[minstr2,y]+Cpj*d[minstr1,y];

                        for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]<0) then begin minstr1:=i;Cqj:=c[i,t];end;
                         chedin:=edin;
                         for i:=1 to n do
                        for t:=1 to r do
                         if (t=minst) and (c[i,t]>0) and (chedin=edin) then begin minstr2:=i;Cpj:=c[i,t];dec(chedin);end;
                               for i:=1 to n do
                        for t:=1 to r do
                         if i<>minstr2 then vsp3[i,t]:=vsp34[i,t] else
vsp3[i,t]:=(-1)*Cqj*vsp34[minstr2,t]+Cpj*vsp34[minstr1,t];
                        for x:=1 to n do
                        for y:=1 to std do
                         if x<>minstr2 then vsp5[x,y]:=vsp54[x,y] else 
vsp5[x,y]:=(-1)*Cqj*vsp54[minstr2,y]+Cpj*vsp54[minstr1,y];



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
                             if i<>minstr1 then
                              vsp2[h,p]:=vsp1[i,p];end;

                              if i<>minstr1 then inc(h);
                             end;

                                             

                          for x:=1 to n do
                           begin
                            for y:=1 to std do begin
                             if x<>minstr1 then
                              vsp4[hh,y]:=vsp5[x,y];end;

                              if x<>minstr1 then inc(hh);
                             end;
	end;


                    end;
 writeln(f,'�������� � ',b);
writeln(f,'���������� ������� C');
   for h:=1 to n-1 do
   begin
       for p:=1 to r-1 do
           begin
           write(f,inttostr(vsp2[h,p]),'         ');
          end;
         writeln(f,'');

     end;
                   nnn:=n-1;
                  writeln(f,'���������� ������� D');
                    for hh:=1 to n-1 do
                    begin
                      for y:=1 to std do
                        begin
                        write(f,inttostr(vsp4[hh,y]),'        ');end;
                        writeln(f,'');
                        end;
                        for y:=1 to std do
   begin
   sum:=0;
  for hh:=1 to n-1 do begin
  sum:=sum+vsp4[hh,y];end;
  res1[y]:=sum;
  end;

        2: m:=m-k-1;
       met2: n:=n-1;

  for h:=1 to n do
for p:=1 to m do
    a[h,p]:=vsp2[h,p];

    for hh:=1 to n do
     for y:=1 to std do
      d[hh,y]:=vsp4[hh,y];

        end;
       ch:=0;loop1:=0;
   for i:=1 to std do begin
   inc(loop1);
    if res1[i]>0 then ch:=ch+1; end;
       writeln(f,'���������� ����������� ����� '+inttostr(nnn));
        closefile(f);
Memo2.Lines.LoadFromFile(FName);
rang1:=transmatrix.RowCount-1-nnn;
inv3:=nnn;
if rang2<=rang1 then rang1:=rang2;
if rang2>rang1 then rang2:=rang1;
edit4.Text:=inttostr(rang1);
edit3.Text:=inttostr(rang2);
end;

end;

procedure TForm4.BitBtn7Click(Sender: TObject);
begin
form4.Close;
end;

procedure TForm4.BitBtn2Click(Sender: TObject);
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

procedure TForm4.BitBtn6Click(Sender: TObject);
begin
form10.show;
end;

procedure TForm4.SpeedButton2Click(Sender: TObject);
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

procedure TForm4.SpeedButton3Click(Sender: TObject);
begin
form10.show;
end;

procedure TForm4.SpeedButton6Click(Sender: TObject);
begin
close;
end;

procedure TForm4.SpeedButton1Click(Sender: TObject);
var FName,s,s_tmp,s_tmp1:string;
i,j,m,n,k,jw,iw,jw_p,r_w,s_w:integer;
f:textfile;
a_tmp,st_matr:array[0..50,0..50] of string;
begin
        OpenDialog1.Title:= '�������� ������������� �����';
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
                        Button1Click(Form4);
                        For iw:=1 to strtoint(Edit2.Text) do
                        For jw:=1 to strtoint(Edit1.Text) do
                        startmatrix.Cells[jw,iw]:=st_matr[jw,iw];
                end;
closefile(f);
end;

procedure TForm4.FormShow(Sender: TObject);
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
//Memo3.Lines.Text:='';
end;

end.
