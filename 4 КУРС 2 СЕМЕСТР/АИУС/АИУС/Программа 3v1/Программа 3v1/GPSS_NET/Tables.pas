unit Tables;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, UCore, Menus, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    GridCapacity: TStringGrid;
    GridActive: TStringGrid;
    GridSleep: TStringGrid;
    GridIncident: TStringGrid;
    GridDelay: TStringGrid;
    GridPriority: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SaveDialog1: TSaveDialog;
    MainMenu1: TMainMenu;
    Edit1: TEdit;
    Edit2: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    OpenDialog1: TOpenDialog;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  f:textfile;
  n,m:integer;

implementation
type
  rezultat=array[1..50,1..50] of string ;
 //matr=array [1..100,1..100] of integer;
 var inv3,inv4,por,inv1,ch1,ch11,loop1,ch2,ch22,loop2,ValueStr,ValueStol,ValueStr2,ValueStol2,rn1,rn2:integer;
 res1,res3:rezultat;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var i,j:integer;
begin
// создание матрицы позиций и переходов
GridIncident.Visible:=true;
GridIncident.ColCount:=strtoint(edit1.Text)+1;
GridIncident.RowCount:=strtoint(edit2.Text)+1;
if strtoint(edit1.Text)>=50 then begin ShowMessage('Количество позиций не должно превышать 50');exit;end;
if strtoint(edit2.Text)>=50 then  begin ShowMessage('Количество переходов не должно превышать 50');exit;end;
ValueStr:=GridIncident.ColCount;
ValueStol:=GridIncident.RowCount;
for i:=0 to ValueStr do
for j:=0 to ValueStol do
if (i=0) and (j=0) then GridIncident.Cells[i,j]:=' ' else
if  i=0 then  GridIncident.Cells[i,j]:='t'+inttostr(j) else
if j=0 then GridIncident.Cells[i,j]:='p'+inttostr(i) else
GridIncident.Cells[i,j]:='0';
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
type
VArray=array[1..50,0..50] of string;
var i1,j1,rang1,rang2:integer;
a,transA:VArray;
FName,glob:string;

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

begin
// Создание файла отчетности

SaveDialog1.Title:='Создание файла моделирования ';
if SaveDialog1.Execute then begin
 FName:=SaveDialog1.FileName;
  Case SaveDialog1.FilterIndex of
  1:FName:=ChangeFileExt(FName,'.txt');
  end;
 SaveDialog1.Filter:='.txt';
 assignFile(f,FName);
rewrite(f);
//транспонирование матрицы А

ValueStr:=GridIncident.ColCount;
ValueStol:=GridIncident.RowCount;

for i1:=1 to ValueStol do
for j1:=1 to ValueStr do
transA[i1,j1]:=GridIncident.Cells[j1,i1];

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
rang2:=GridIncident.RowCount-1-inv4;
   end;

//Задаем начальную матрицу инцедентности
for i1:=1 to n do
  for j1:=1 to m do
   a[i1,j1]:=transA[j1,i1];                                                        
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var FName:string;
begin
OpenDialog1.Title:= 'Открытие моделируемого файла';

if OpenDialog1.Execute and FileExists(OpenDialog1.FileName) then
 begin
 FName:=OpenDialog1.FileName;
 Case OpenDialog1.FilterIndex of
  1:FName:=ChangeFileExt(FName,'.txt');
  end;
  end;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
Form1.Close;
end;

procedure TForm1.N2Click(Sender: TObject);
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
                                  if s[jw_p]=' ' then
                                        begin
                                                s_tmp:=s;
                                                delete(s_tmp,jw_p,(length(s_tmp)-jw_p+1));
                                                st_matr[jw,iw]:=s_tmp;
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
                        Button1Click(Form1);
                        For iw:=1 to strtoint(Edit2.Text) do
                        For jw:=1 to strtoint(Edit1.Text) do
                        GridIncident.Cells[jw,iw]:=st_matr[jw,iw];
                end;
        closefile(f);
end;

procedure TForm1.N3Click(Sender: TObject);
var FName1,s,value:string;
iw,jw:integer;
SL:TStringList;
begin
  SaveDialog1.Title:='Создание файла для анализа';
  SaveDialog1.FileName:='Отчет1';
  if SaveDialog1.Execute then
  begin
    FName1:=SaveDialog1.FileName;
    Case SaveDialog1.FilterIndex of
    1:FName1:=ChangeFileExt(FName1,'.txt');
    end;
  end;
  SaveDialog1.Filter:='.txt';
  SL := TStringList.Create;
  for iw:=1 to GridIncident.ColCount - 1 do
  begin
    s := '';
    for jw:=1 to GridIncident.RowCount - 1 do
    begin
      value := trim(GridIncident.Cells[iw,jw]);
      if value = '' then value := '0';
      s := TrimLeft(s + ' ') + value;
    end;
    SL.Add(s);
  end;
  SL.SaveToFile(FName1);
  SL.Destroy;
end;



end.
