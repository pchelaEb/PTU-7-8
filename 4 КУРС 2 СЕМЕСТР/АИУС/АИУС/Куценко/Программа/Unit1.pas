unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids,matrix, ExtCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Label3: TLabel;
    StringGrid1: TStringGrid;
    GroupBox2: TGroupBox;
    StringGrid2: TStringGrid;
    GroupBox4: TGroupBox;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label17: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    StringGrid5: TStringGrid;
    StringGrid6: TStringGrid;
    Button1: TButton;
    StringGrid7: TStringGrid;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Panel1: TPanel;
    Button2: TButton;
    Label41: TLabel;
    Edit3: TEdit;
    UpDown3: TUpDown;
    StringGrid3: TStringGrid;
    Panel2: TPanel;
    Button3: TButton;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    StringGrid4: TStringGrid;
    Label46: TLabel;
    StringGrid8: TStringGrid;
    Label47: TLabel;
    Label49: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    StringGrid9: TStringGrid;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    StringGrid10: TStringGrid;
    Label54: TLabel;
    Label55: TLabel;
    GroupBox5: TGroupBox;
    Label56: TLabel;
    Edit4: TEdit;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  m1,bf,m0:matrixptr;
  x:real;
  rank:byte;
  rows,cols:integer;

implementation


{$R *.dfm}

procedure TForm1.Edit2Change(Sender: TObject);
begin
StringGrid1.RowCount:=StrToInt(Edit2.Text)+1;
StringGrid1.Cells[0,StringGrid1.RowCount]:='T'+IntToStr(StringGrid1.RowCount);
Button2.Enabled:=False;
Button3.Enabled:=False;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
StringGrid1.ColCount:=StrToInt(Edit1.Text)+1;
StringGrid1.Cells[StringGrid1.ColCount,0]:='P'+IntToStr(StringGrid1.ColCount);
StringGrid2.ColCount:=StrToInt(Edit1.Text);
StringGrid2.Cells[StringGrid2.ColCount,0]:='P'+IntToStr(StringGrid2.ColCount+1);
StringGrid9.ColCount:=StrToInt(Edit1.Text);
StringGrid9.Cells[StringGrid9.ColCount,0]:='P'+IntToStr(StringGrid9.ColCount+1);
Button2.Enabled:=False;
Button3.Enabled:=False;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
StringGrid1.Cells[1,0]:='P1';
StringGrid1.Cells[0,1]:='T1';
StringGrid2.Cells[0,0]:='P1';
StringGrid9.Cells[0,0]:='P1';
end;

{������ ����������� ������� ����}
procedure TForm1.Button1Click(Sender: TObject);
var fil:textfile;
      i,j,dif,lng:integer;
     trank:byte;
    a11,a12,a11t,a12t,a12tr,e,mul,tnul,snul,ibf,sinv,tinv,at,tbf:matrixptr;
    s1,yes,no:string;
    det,tmpel:real;
    IsTNull,IsSNull,IsSMinus,IsTPlus,IsY,IsX,IsYMinus,IsXMinus,IsXNull,IsYNull:Boolean;

begin
assignFile(fil,Edit4.Text);

rewrite(fil);
yes:='��';
no:='���';
rows:=StringGrid1.RowCount-1;
cols:=StringGrid1.ColCount-1;
m1:=creatematrix(rows,cols);
try
  writeln(fil,'������� �������������');
  for i:=1 to rows do
  begin
  for j:=1 to cols do
   begin
     lng:=Length(StringGrid1.Cells[j,i])*10;
     if lng>StringGrid1.DefaultColWidth then StringGrid1.DefaultColWidth:=lng;
     SetMatrixElement(m1,i,j,StrToFloat(StringGrid1.Cells[j,i]));
     x:=GetMatrixElement(m1,i,j);
     write(fil,x:7:2);
   end;
    writeLn(fil);
   end;
   writeLn(fil);


rank:=GetMatrixRank(m1);
writeln(fil,'���� � = ',rank);
if rank<>cols then Label10.Caption:=no;
Str(rank,s1);
Label6.Caption:=s1;
{------- ��������� ������� ������������� �� ��� ����� A11 � A12 ------ }
dif:=cols-rank;
if dif>0 then
 begin
  a11:=creatematrix(rank,dif);
  for i:=1 to rank do
  for j:=1 to dif do
  setmatrixelement(a11,i,j,GetMatrixElement(m1,i,j));
  a12:=creatematrix(rank,rank);
  for i:=1 to rank do
  for j:=1 to rank do
  setmatrixelement(a12,i,j,GetMatrixElement(m1,i,dif+j));

 end;





 {-------------------------------------------------------}
 {-------������������� ������� A11 � A12------------}
 a11t:=TransponeMatrix(a11);
 a12t:=TransponeMatrix(a12);
 a12tr:=ReverseMatrix(a12t);
 if a12tr<>nil then begin

 {-------������� ��������� ������� ������� m-r-------}
  e:=CreateSquareMatrix(dif);
  for i:=1 to dif do setmatrixelement(e,i,i,1);
  mul:=MultipleMatrixOnMatrix(a11t,a12tr);
  mul:=MultipleMatrixOnNumber(mul,-1);
  {------������� ������� Bf---------------------------}
  bf:=creatematrix(dif,dif+rank);
  for i:=1 to dif do
  for j:=1 to dif do
  setmatrixelement(bf,i,j,GetMatrixElement(e,i,j));
  for i:=1 to dif do
  for j:=1 to rank do
  setmatrixelement(bf,i,dif+j,GetMatrixElement(mul,i,j));
{-----------------------}
  writeln(fil);
  writeln(fil,'������� Bf');
{-----------------------}
  if StringGrid5.RowCount<dif then StringGrid5.RowCount:=dif;
  if (StringGrid5.ColCount<(rank+dif)) then StringGrid5.ColCount:=dif;

  for i:=1 to dif do
  begin
  for j:=1 to rank+dif do

  begin
  s1:=FloatToStr(GetMatrixElement(bf,i,j));
  lng:=Length(s1)*10;
  if lng>StringGrid5.DefaultColWidth then StringGrid5.DefaultColWidth:=lng;
  stringgrid5.Cells[j-1,i-1]:=s1;
  write(fil,GetMatrixElement(bf,i,j):7:2);
  end;
  writeln(fil);
  end;



{-----------------------------------------}
 {-----�������� S-��������� �� ������� Bf-----}
SInv:=CreateMatrix(rank+dif,1);
for i:=1 to rank+dif do
begin
tmpel:=0;
for j:=1 to dif do
tmpel:=tmpel+GetMatrixElement(bf,j,i);
SetMatrixElement(SInv,i,1,tmpel);
end;
 ibf:=GetInvariantMatrix(bf);
if (StringGrid6.RowCount<(rank+dif)) then StringGrid6.RowCount:=dif+rank;
  writeln(fil);
  writeln(fil,'������� Y');
  for j:=1 to rank+dif do
  begin
  s1:=FloatToStr(GetMatrixElement(SInv,j,1));
  lng:=Length(s1)*10;
     if lng>StringGrid6.DefaultColWidth then StringGrid6.DefaultColWidth:=lng;
  stringgrid6.Cells[0,j-1]:=s1;
  writeln(fil,GetMatrixElement(SInv,j,1):7:2);
  end;

end
else
begin
ShowMessage('������������ ������� A12 ����� 0');
writeln(fil,'������������ ������� A12 ����� 0');
end;
{------������������� ������� �-----------}
at:=TransponeMatrix(m1);
trank:=GetMatrixRank(at);
{------- ��������� ����������������� ������� ������������� �� ��� ����� AT11 � AT12 ------ }
dif:=rows-trank;
if dif>0 then
 begin
  a11:=creatematrix(trank,dif);
  for i:=1 to trank do
  for j:=1 to dif do
  setmatrixelement(a11,i,j,GetMatrixElement(at,i,j));
  a12:=creatematrix(trank,trank);
  for i:=1 to trank do
  for j:=1 to trank do
  setmatrixelement(a12,i,j,GetMatrixElement(at,i,dif+j));
 end;


 a11t:=TransponeMatrix(a11);
 a12t:=TransponeMatrix(a12);
 a12tr:=ReverseMatrix(a12t);
 if a12tr<>nil then begin

 {-------������� ��������� ������� ������� n-r-------}
  e:=CreateSquareMatrix(dif);
  for i:=1 to dif do setmatrixelement(e,i,i,1);
  mul:=MultipleMatrixOnMatrix(a11t,a12tr);
  mul:=MultipleMatrixOnNumber(mul,-1);
  {------������� ������� TBf---------------------------}
  tbf:=creatematrix(dif,dif+trank);
  for i:=1 to dif do
  for j:=1 to dif do
  setmatrixelement(tbf,i,j,GetMatrixElement(e,i,j));
  for i:=1 to dif do
  for j:=1 to trank do
  setmatrixelement(tbf,i,dif+j,GetMatrixElement(mul,i,j));
{-----------------------}

{-----------------------}




{-----------------------------------------}
 {-----�������� T-��������� �� ������� TBf-----}
TInv:=CreateMatrix(trank+dif,1);
for i:=1 to trank+dif do
begin
tmpel:=0;
for j:=1 to dif do
tmpel:=tmpel+GetMatrixElement(tbf,j,i);
SetMatrixElement(TInv,i,1,tmpel);
end;
  writeln(fil);
  writeln(fil,'������� �');
  if (StringGrid7.RowCount<(trank+dif)) then StringGrid7.RowCount:=dif+trank;
  for j:=1 to trank+dif do
  begin
  s1:=FloatToStr(GetMatrixElement(TInv,j,1));
  lng:=Length(s1)*10;
     if lng>StringGrid7.DefaultColWidth then StringGrid7.DefaultColWidth:=lng;
  stringgrid7.Cells[0,j-1]:=s1;
  writeln(fil,GetMatrixElement(TInv,j,1):7:2);
  end;

end
else
begin
ShowMessage('������������ ������� A12 ����� 0');
writeln(fil,'������������ ������� A12 ����� 0');
end;
{-----------��������� ��������-----------------}
 IsYMinus:=False; IsXMinus:=False;
 IsXNull:=True; IsYNull:=True;
 for i:=1 to cols do
 if GetMatrixElement(SInv,i,1)<0 then IsYMinus:=True;
 for i:=1 to cols do
 if GetMatrixElement(SInv,i,1)<>0 then IsYNull:=False;
 for i:=1 to rows do
 if GetMatrixElement(TInv,i,1)<0 then IsXMinus:=True;
 for i:=1 to rows do
 if GetMatrixElement(TInv,i,1)<>0 then IsXNull:=False;
  IsX:=not(IsXMinus) and not(IsXNull);
  IsY:=not(IsYMinus) and not(IsYNull);
  If IsY then Label42.Caption:='�� (������� Y)'
  else Label42.Caption:=no;
  If IsX then Label43.Caption:='�� (������� X)'
  else Label43.Caption:=no;



 snul:=MultipleMatrixOnMatrix(m1,SInv);
 IsSNull:=True;ISSMinus:=False;
 for i:=1 to rows do
 If GetMatrixElement(snul,i,1)<>0 then
 begin
 IsSNull:=False;
 if GetMatrixElement(snul,i,1)<0 then IsSMinus:=True;
 end;
 tnul:=MultipleMatrixOnMatrix(at,TInv);
 IsTNull:=True;
 IsTPlus:=False;
 for i:=1 to cols do
 If GetMatrixElement(tnul,i,1)<>0 then
 begin
 IsTNull:=False;
 if GetMatrixElement(tnul,i,1)<0 then IsTPlus:=True;
 end;
 If ((IsSMinus) and (IsY)) then
 begin
   Label13.Caption:=yes;
   if IsSNull then Label14.Caption:=yes
   else Label14.Caption:=no;
 end
 else
 begin
  if ((IsSNull) and (IsY)) then
                begin
                      Label13.Caption:=yes;
                      Label14.Caption:=yes;
                end
  else
  begin
  Label13.Caption:=no;
  Label14.Caption:=no;
  end;
 end;


  If ((IsTPlus) and (IsX)) then
 begin
   Label15.Caption:=yes;
    if IsTNull then Label16.Caption:=yes
     else Label16.Caption:=no;
 end
 else
 begin
   if ((IsTNull) and (IsX)) then
   begin
   Label16.Caption:=yes;
   Label15.Caption:=yes;
   end
   else
   begin
   Label16.Caption:=no;
   Label15.Caption:=no;
   end;
 end;

Button2.Enabled:=True;



except
  on EConvertError do ShowMessage('����������� ������ ������� �������������');
end;

writeln(fil);
writeln(fil,Label7.Caption+'     '+Label13.Caption);
writeln(fil,Label8.Caption+'     '+Label14.Caption);
writeln(fil,Label11.Caption+'     '+Label15.Caption);
writeln(fil,Label12.Caption+'     '+Label16.Caption);
writeln(fil,Label5.Caption+'     '+Label10.Caption);
writeln(fil,Label36.Caption+'     '+Label42.Caption);
writeln(fil,Label37.Caption+'     '+Label43.Caption);

closeFile(fil);
end;

{ ����� ������ �� ������ 1}
procedure TForm1.Button2Click(Sender: TObject);
var i,j,k,jj:byte;
    m1,at,mk,vk,dtk,xk,uk,tmpmk:MatrixPtr;
    canGo,getOut,Error:boolean;
    x,y:real;
    s,s2,tstr:string;
    lng:integer;
    

begin
rows:=StringGrid1.RowCount-1;
cols:=StringGrid1.ColCount-1;
m1:=creatematrix(rows,cols);
m0:=creatematrix(cols,1);
vk:=creatematrix(cols,1);
mk:=creatematrix(cols,1);
tmpmk:=creatematrix(cols,1);
xk:=creatematrix(rows,1);
try
for i:=1 to rows do
for j:=1 to cols do
begin
lng:=Length(StringGrid1.Cells[j,i])*10;
if lng>StringGrid1.DefaultColWidth then StringGrid1.DefaultColWidth:=lng;
SetMatrixElement(m1,i,j,StrToFloat(StringGrid1.Cells[j,i]));
end;
for i:=1 to cols do
begin
lng:=Length(StringGrid2.Cells[i-1,1])*10;
if lng>StringGrid2.DefaultColWidth then StringGrid2.DefaultColWidth:=lng;
SetMatrixElement(m0,i,1,StrToFloat(StringGrid2.Cells[i-1,1]));
end;
 at:=TransponeMatrix(m1);

{---------������ ����-----------------}
mk:=clonematrix(m0);
k:=0;
GetOut:=False;
while (not GetOut) and (k<StrToInt(Edit3.Text)) do
begin
inc(k);

CanGo:=True; j:=0;
repeat
   inc(j);
   i:=0;
   CanGo:=True;
   while (canGo) and (i<=cols)  do
   begin
     inc(i);
     x:=GetMatrixElement(mk,i,1);
     y:=GetMatrixElement(m1,j,i);
     if (y<0) and (x-abs(y)<0) then canGo:=False;
   end;

until (canGo) or (j>rows);
if canGo then
begin
uk:=CreateMatrix(rows,1);
SetMatrixElement(uk,j,1,1);
tmpmk:=MultipleMatrixOnMatrix(at,uk);
mk:=AddMatrixOnMatrix(mk,tmpmk);
xk:=AddMatrixOnMatrix(xk,uk);

end
else GetOut:=True;

end;
vk:=MultipleMatrixOnMatrix(at,xk);
dtk:=SubMatrixOnMatrix(SubMAtrixOnMatrix(mk,m0),vk);
if StringGrid3.ColCount<cols then StringGrid3.ColCount:=cols;
if StringGrid4.ColCount<cols then StringGrid4.ColCount:=cols;
if StringGrid8.ColCount<cols then StringGrid8.ColCount:=cols;
for jj:=1 to cols do
begin
s2:=FloatToStr(GetMatrixElement(vk,jj,1));
lng:=Length(s2)*10;
if lng>StringGrid3.DefaultColWidth then StringGrid3.DefaultColWidth:=lng;
stringgrid3.Cells[jj-1,0]:=s2;
s2:=FloatToStr(GetMatrixElement(mk,jj,1));
lng:=Length(s2)*10;
if lng>StringGrid4.DefaultColWidth then StringGrid4.DefaultColWidth:=lng;
stringgrid4.Cells[jj-1,0]:=s2;
s2:=FloatToStr(GetMatrixElement(dtk,jj,1));
lng:=Length(s2)*10;
if lng>StringGrid8.DefaultColWidth then StringGrid8.DefaultColWidth:=lng;
stringgrid8.Cells[jj-1,0]:=s2;
 end;
 Error:=False; s:='';
 for jj:=1 to cols do
begin
x:=GetMatrixElement(dtk,jj,1);
tstr:='P'+IntToStr(jj)+' ';
if ((x<>0) and (Pos(tstr,s)<=0)) then s:=s+tstr;

end;
  if s='' then Label48.Caption:='���'
  else Label48.Caption:=s;
except
  on EConvertError do ShowMessage('����������� ������ ���� �� ������');



end;
   Button3.Enabled:=True;
end;

{����� ������ �� ������ 2}
procedure TForm1.Button3Click(Sender: TObject);
 var i,dif,j,k:byte;
      mg,tmp,sk:MatrixPtr;
      s1,s2:string;
      x,y:real;
      Error:Boolean;
      lng:integer;
begin
  mg:=creatematrix(cols,1);
 try
   for i:=1 to cols do
   begin
     lng:=Length(StringGrid9.Cells[j,i])*10;
     if lng>StringGrid9.DefaultColWidth then StringGrid9.DefaultColWidth:=lng;
SetMatrixElement(mg,i,1,StrToFloat(StringGrid9.Cells[i-1,1]));
   end;
   dif:=cols-rank;

   tmp:=SubMatrixOnMatrix(mg,m0);
   sk:=MultipleMatrixOnMatrix(bf,tmp);
   if (StringGrid10.RowCount<(cols-rank)) then StringGrid10.RowCount:=cols-rank;
   for i:=1 to cols-rank do
  begin
  s2:=FloatToStr(GetMatrixElement(sk,i,1));
  lng:=Length(s2)*10;
  if lng>StringGrid10.DefaultColWidth then StringGrid10.DefaultColWidth:=lng;
  stringgrid10.Cells[0,i-1]:=s2;
  end;
  s1:='';
  for i:=1 to cols-rank do
  begin
      x:=GetMatrixElement(sk,i,1);
      if x<>0 then
                  for j:=1 to cols do
                  begin
                    y:=GetMatrixElement(bf,i,j);
                    if y<>0 then
                    begin
                    Error:=True;
                      for k:=1 to cols-rank do
                      if k<>i then
                      begin
                        if ((GetMatrixElement(sk,k,1)=0) and (GetMatrixElement(bf,k,j)<>0)) then Error:=False;

                      end;
                    end;
                    if ((Error) and (Pos('P'+IntToStr(j)+'  ',s1)<=0))then s1:=s1+'P'+IntToStr(j)+'  ';

                  end;

  end;
 If s1='' then Label55.Caption:='���' else Label55.Caption:=s1;
 except
  on EConvertError do ShowMessage('����������� ����� ���� �� ��������');
end;
 end;

procedure TForm1.Button4Click(Sender: TObject);
begin
SaveDialog1.Execute();
Edit4.Text:=SaveDialog1.FileName;
end;

end.
