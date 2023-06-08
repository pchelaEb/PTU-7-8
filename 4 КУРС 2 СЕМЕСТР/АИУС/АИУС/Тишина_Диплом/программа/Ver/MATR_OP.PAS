(********************************************************************
 **  Модуль работы с матрицами.                                    **
 **  (c) S&s aKa Ilya Pinaeff (syn@crhefr.hptula.mednet.com)       **
 **      DeN Tatyanin (2:5036/10.19@Fidonet aKa 345:8188/3@RANet)  **
 ********************************************************************)

{$N+}
unit Matr_Op;

interface

type
  Rl=^extended;
  TArray=array[0..3000] of extended;
  Arl=^TArray;
  Mp=^Matr;
  Matr=object
    m,n:byte;
    ar:Arl;
    st:boolean;
    constructor Init(a,b:byte);
    destructor Done;
    procedure SwapL(l1,l2:byte);
    function e(l,j:byte):Rl;
    function Det:extended;
    function I:Mp;
    function NUL:Mp;
    function Chis:Mp;
    function T:Mp;
    function Rg:byte;
    function tr:extended;
  end;

function MMul(A,B:Mp):Mp;
function AddM(A,B:Mp):Mp;
function SubM(A,B:Mp):Mp;
function MulD(A:Mp;b:extended):Mp;
function AddD(A:Mp;b:extended):Mp;
function RExpand(A,B:Mp):Mp;
function DExpand(A,B:Mp):Mp;
function Inv(A:Mp):Mp;
function AA(A:Mp;k0,k1:byte):Mp;
function Psev(A:Mp):Mp;
function G_(A:Mp):Mp;
function Grevil(A:Mp):Mp;
function Tenz(A,B:Mp):Mp;
function Vec(A:Mp):Mp;
function VMatr(A:Mp;k:byte):Mp;
procedure SetM(var A:Mp;B:Mp);
function Compare(A,B:Mp):Boolean;
procedure Print(A:Mp);

implementation

{------- Конструктор матрицы NxM -------}

constructor Matr.Init(a,b:byte);
begin
  GetMem(ar,a*b*SizeOf(extended));
  st:=FALSE;
  n:=a;
  m:=b
end;

{------- Деструктор матрицы NxM -------}

destructor Matr.Done;
begin
  FreeMem(ar,m*n*SizeOf(extended))
end;

{-------------- Статические методы (функции с одним аргументом) -----------}

function Matr.e(l,j:byte):Rl;    {------- Элемент матрицы }
begin
  e:=@ar^[(l-1)*m+j-1]
end;

function Matr.Det:extended;          {------- Вычисление определителя }
label 1;
var
  l,j,k:byte;
  sk,det0:extended;
  tmp:Mp;
  Sgn:boolean;

begin
  new(tmp,Init(n,n));
  Move(ar^,tmp^.ar^,n*n*SizeOf(extended));
  det0:=e(1,1)^;
  Sgn:=false;
  with tmp^ do
    for k:=2 to n do begin
      for j:=k to n do begin
        l:=k-1;
        while ((Abs(e(l,k-1)^)<1e-6) and (l<=n)) do inc(l);
        if l>(k-1) then
          if l>=n then begin
            SwapL(l,k-1);
            Sgn:=NOT Sgn
          end
          else begin
            det0:=0;
            goto 1
          end;
              sk:=e(j,k-1)^/e(k-1,k-1)^;
              for l:=k to n do e(j,l)^:=e(j,l)^-e(k-1,l)^*sk;
      end;
      det0:=det0*e(k,k)^
    end;

1:Dispose(tmp,Done);
  if Sgn then det0:=-det0;
  Det:=det0
end;

function Matr.I:Mp;              {------- Единичная матрица }
var
  tmp:Mp;
  l,j:byte;

begin
  new(tmp,Init(n,n));
  for l:=1 to n do
    for j:=1 to n do begin
      if l<>j then tmp^.e(l,j)^:=0
      else tmp^.e(l,j)^:=1
    end;
  tmp^.st:=TRUE;
  I:=tmp
end;

function Matr.NUL:Mp;              {------- Нулевая матрица }
var
  tmp:Mp;
  l,j:byte;

begin
  new(tmp,Init(n,m));
  for l:=1 to n do
    for j:=1 to m do tmp^.e(l,j)^:=0;
  tmp^.st:=TRUE;
  NUL:=tmp
end;

function Matr.Chis:Mp;              {------- Нулевая матрица }
var
  tmp:Mp;
  l,j:byte;

begin
  new(tmp,Init(n,m));
  for l:=1 to n do
    for j:=1 to m do tmp^.e(l,j)^:=2;
  tmp^.st:=TRUE;
  Chis:=tmp
end;


function Matr.T:Mp;              {------- Транспонирование }
var
  tmp:Mp;
  l,j:byte;

begin
  new(tmp,Init(m,n));
  for l:=1 to m do
    for j:=1 to n do tmp^.e(l,j)^:=e(j,l)^;
  tmp^.m:=n;
  tmp^.n:=m;
  tmp^.st:=TRUE;
  T:=tmp
end;

function Matr.Rg:byte;           {------- Вычисление ранга матрицы }
var
  l,j,k,min,rang:integer;
  sz:extended;
  tmp:Mp;
begin
  min:=m;

  new(tmp,Init(n,m));
  Move(ar^,tmp^.ar^,n*m*SizeOf(extended));

  if n<m then begin
    min:=n;
    SetM(tmp,tmp^.T)
  end;

  with tmp^ do begin
    for k:=1 to min do
      for l:=1 to n do
        if l<>k then begin
          if e(k,k)^=0 then continue else sz:=e(l,k)^/e(k,k)^;
          for j:=1 to m do e(l,j)^:=e(l,j)^-sz*e(k,j)^
        end;
    rang:=0;
    for l:=1 to min do if e(l,l)^<>0 then inc(rang);
  end;
  if rang=0 then rang:=1;
  Dispose(tmp,Done);
  Rg:=rang
end;

function Matr.tr:extended;           {------- Нахождение следа матрицы }
var
  l:byte;
  ttr:extended;

begin
  ttr:=0.;
  for l:=1 to n do ttr:=ttr+e(l,l)^;
  tr:=ttr
end;

procedure Matr.SwapL(l1,l2:byte);{------- Поменять местами строки l1 и l2 }
var
  l:byte;
  tmp:extended;

begin
  for l:=1 to m do begin
    tmp:=e(l1,l)^;
    e(l1,l)^:=e(l2,l)^;
    e(l2,l)^:=tmp
  end
end;

{-------------- Внешние процедуры и функции (не методы матрицы) -----------}

procedure SetM(var A:Mp;B:Mp);   {------- Присваивание }
begin
  if A<>NIL then Dispose(A,Done);
  if B^.st then A:=B
  else begin
    new(A,Init(B^.n,B^.m));
    Move(B^.ar^,A^.ar^,A^.n*A^.m*SizeOf(extended))
  end;
  A^.st:=FALSE
end;

function MMul(A,B:Mp):Mp;       {------- Умножение матриц }
var
  i,j,k:byte;
  tmp:Mp;
begin
  new(tmp,Init(A^.n,B^.m));
  for i:=1 to A^.n do
    for j:=1 to B^.m do begin
      tmp^.e(i,j)^:=0.;
      for k:=1 to B^.n do tmp^.e(i,j)^:=tmp^.e(i,j)^+A^.e(i,k)^*B^.e(k,j)^
    end;
  if A^.st then Dispose(A,Done);
  if B^.st then Dispose(B,Done);
  tmp^.st:=TRUE;
  MMul:=tmp
end;

function AddM(A,B:Mp):Mp;       {------- Сложение матриц }
var
  l,j:byte;
  tmp:Mp;

begin
  new(tmp,Init(A^.n,B^.m));
  with tmp^ do
    for l:=1 to A^.n do
      for j:=1 to A^.m do e(l,j)^:=A^.e(l,j)^+B^.e(l,j)^;
  if A^.st then Dispose(A,Done);
  if B^.st then Dispose(B,Done);
  tmp^.st:=TRUE;
  AddM:=tmp
end;

function SubM(A,B:Mp):Mp;       {------- Вычитание матриц }
var
  l,j:byte;
  tmp:Mp;

begin
  new(tmp,Init(A^.n,B^.m));
  with tmp^ do
    for l:=1 to A^.n do
      for j:=1 to A^.m do e(l,j)^:=A^.e(l,j)^-B^.e(l,j)^;
  if A^.st then Dispose(A,Done);
  if B^.st then Dispose(B,Done);
  tmp^.st:=TRUE;
  SubM:=tmp
end;

function Tenz(A,B:Mp):Mp;            {------- Тензорное произведение }
var
  tmp,tmp1:Mp;
  l,j:byte;
begin
  new(tmp1,Init(0,0));
  for j:=1 to A^.m do begin
    new(tmp,Init(0,0));
    for l:=1 to A^.n do
      SetM(tmp,DExpand(tmp,MulD(B,A^.e(l,j)^)));
    SetM(tmp1,RExpand(tmp1,tmp));
    Dispose(tmp,Done)
  end;
  if A^.st then Dispose(A,Done);
  if B^.st then Dispose(B,Done);
  tmp1^.st:=TRUE;
  Tenz:=tmp1
end;

function MulD(A:Mp;b:extended):Mp;   {------- Умножение на число }
var
  l,j:byte;
  tmp:Mp;
begin
  new(tmp,Init(A^.n,A^.m));
  with tmp^ do for l:=1 to n do for j:=1 to m do e(l,j)^:=b*A^.e(l,j)^;
  if A^.st then Dispose(A,Done);
  tmp^.st:=TRUE;
  MulD:=tmp
end;

function AddD(A:Mp;b:extended):Mp;   {------- Прибавление числа }
var
  l,j:byte;
  tmp:Mp;
begin
  new(tmp,Init(A^.n,A^.m));
  with tmp^ do for l:=1 to n do for j:=1 to m do e(l,j)^:=b+A^.e(l,j)^;
  if A^.st then Dispose(A,Done);
  tmp^.st:=TRUE;
  AddD:=tmp
end;

function RExpand(A,B:Mp):Mp;     {------- Объединение двух матриц             }
var                              { (добавление к матрице A cправа матрицы B)  }
  l,j:byte;
  tmp:Mp;

begin
  new(tmp,Init(B^.n,A^.m+B^.m));
  for l:=1 to B^.n do begin
    for j:=1 to A^.m do tmp^.e(l,j)^:=A^.e(l,j)^;
    for j:=1 to B^.m do tmp^.e(l,A^.m+j)^:=B^.e(l,j)^
  end;
  if A^.st then Dispose(A,Done);
  if B^.st then Dispose(B,Done);
  tmp^.st:=TRUE;
  RExpand:=tmp
end;

function DExpand(A,B:Mp):Mp;     {------- Объединение двух матриц             }
var                              { (добавление к матрице A cнизу матрицы B)   }
  l,j:byte;
  tmp:Mp;

begin
  new(tmp,Init(A^.n+B^.n,B^.m));
  for l:=1 to B^.m do begin
    for j:=1 to A^.n do tmp^.e(j,l)^:=A^.e(j,l)^;
    for j:=1 to B^.n do tmp^.e(A^.n+j,l)^:=B^.e(j,l)^
  end;
  if A^.st then Dispose(A,Done);
  if B^.st then Dispose(B,Done);
  tmp^.st:=TRUE;
  DExpand:=tmp
end;

function MSub(A:Mp;j0,j1,l0,l1:byte):Mp;
var
  tmp:Mp;
  l,j,k:byte;
  sz,sk:extended;

begin
  l0:=l0-1;
  j0:=j0-1;
  new(tmp,Init(l1-l0,j1-j0));
  with tmp^ do begin
    for l:=1 to n do
      for j:=1 to m do e(l,j)^:=A^.e(l+l0,j+j0)^;
    st:=TRUE
  end;
  if A^.st then Dispose(A,Done);
  MSub:=tmp;
end;

function Inv(A:Mp):Mp;           {------- Обращение матрицы }
var
  tmp:Mp;
  l,j,k:byte;
  sz,sk:extended;

begin
  new(tmp,Init(A^.n,A^.m));
  tmp:=RExpand(A,A^.I);
  with tmp^ do
    for k:=1 to n do begin
      sk:=1/e(k,k)^;
      for l:=1 to n do
        if l<>k then begin
          sz:=sk*e(l,k)^;
          for j:=1 to m do e(l,j)^:=e(l,j)^-sz*e(k,j)^
        end;
      for j:=1 to m do e(k,j)^:=sk*e(k,j)^
    end;
  tmp:=MSub(tmp,A^.m+1,tmp^.m,1,tmp^.n);
  if A^.st then Dispose(A,Done);
  Inv:=tmp
end;

function Psev(A:Mp):Mp;   {----- Псевдообращение методом Фадеева}
var
  B,F,F1,T,C:Mp;
  fi,fi1,k:extended;

begin
  B:=NIL;
  F:=NIL;
  F1:=NIL;
  T:=NIL;
  C:=NIL;

  SetM(B,MMul(A^.T,A));
  SetM(F1,A^.I);
  fi1:=B^.tr;
  k:=2;
  repeat
    SetM(F,F1);
    fi:=fi1;
    SetM(F1,SubM(MulD(A^.I,fi),MMul(B,F)));

    SetM(T,MMul(B,F1));

    fi1:=T^.tr/k;

    k:=k+1;
  until Abs(fi1)<0.001;

  SetM(C,MulD(MMul(F,A^.T),1/fi));

  dispose(B,Done);
  dispose(F,Done);
  dispose(F1,Done);
  dispose(T,Done);

  if A^.st then Dispose(A,Done);
  C^.st:=TRUE;
  Psev:=C
end;

function AA(A:Mp;k0,k1:byte):Mp;   { Выделение из матрицы столбцов }
var                                { с k0 по k1 }
  tmp:Mp;
  l,j:byte;

begin
  new(tmp,Init(A^.n,k1-k0+1));
  with tmp^ do
    for l:=1 to A^.n do
      for j:=k0 to k1 do e(l,j-k0+1)^:=A^.e(l,j)^;

  if A^.st then dispose(A,Done);
  tmp^.st:=TRUE;
  AA:=tmp
end;

function Grevil(A:Mp):Mp;    { Псевдообращение методом Гревиля }
var
  Ap,At,F,C,AM:Mp;
  i,k:byte;
  alf:extended;

begin
  C:=NIL;
  At:=NIL;
  Ap:=NIL;
  F:=NIL;
  AM:=NIL;

  { Шаг 1 }
  SetM(At,AA(A,1,1));
  if Compare(At,At^.NUL) then SetM(Ap,At^.NUL^.T)
  else SetM(Ap, MulD(At^.T,1/MMul(At^.T,At)^.e(1,1)^) );

  for k:=2 to A^.m do begin

    SetM(C, MMul(AA(A,1,k-1),Ap) );
    SetM(C, MMul(SubM(C^.I,C), AA(A,k,k)) );

    if NOT Compare(C,C^.NUL) then SetM(F,MulD(C^.T,1/MMul(C^.T,C)^.e(1,1)^))
    else begin

      SetM(At,MMul(Ap,AA(A,k,k)));
      alf:=1+MMul(At^.T,At)^.e(1,1)^;

      SetM(F,MulD(MMul(MMul(AA(A,k,k)^.T,Ap^.T),Ap),1/alf))
    end;

    SetM(AM,MMul(AA(A,k,k),F));
    SetM(Ap,Dexpand(MMul(Ap,SubM(AM^.I,AM)),F));
  end;
  Ap^.st:=TRUE;

  if A^.st then Dispose(A,Done);
  Dispose(At,Done);
  if A^.m>1 then begin
    Dispose(F,Done);
    Dispose(C,Done);
    Dispose(AM,Done)
  end;

  Grevil:=Ap
end;

function Compare(A,B:Mp):Boolean;   {----- Cравнение матриц }
var i,j:integer;
begin
  Compare:=TRUE;
  for i:=1 to A^.n do
    for j:=1 to A^.m do
      if Abs(B^.e(i,j)^-A^.e(i,j)^)>0.1 then Compare:=FALSE
end;

function Vec(A:Mp):Mp;              {---- Превращение матрицы в вектор }
var
  tmp:Mp;
  l,j:byte;
begin
  new(tmp,Init(A^.n*A^.m,1));
  for j:=1 to A^.m do
    for l:=1 to A^.n do
      tmp^.e((j-1)*A^.n+l,1)^:=A^.e(l,j)^;
  if A^.st then Dispose(A,Done);
  tmp^.st:=TRUE;
  Vec:=tmp
end;

function G_(A:Mp):Mp;               {---- Матрица G- }

function A_(A:Mp):Mp;
Label Q;
var
  tmp:Mp;
  l:byte;
begin
  tmp:=NIL;
  SetM(tmp,AA(A,1,1));
  with tmp^ do begin
    for l:=1 to n do
      if e(l,1)^<>0 then begin
        e(l,1)^:=1/e(l,1)^;
        goto Q
      end;
Q:  for l:=l+1 to n do e(l,1)^:=0
  end;

  if A^.st then Dispose(A,Done);

  SetM(tmp,tmp^.T);
  tmp^.st:=TRUE;
  A_:=tmp
end;

function Ed(j:byte):Mp;
var
  tmp:Mp;
  l:byte;

begin
  new(tmp,Init(1,j));
  for l:=1 to j do tmp^.e(1,l)^:=1;

  tmp^.st:=TRUE;
  Ed:=tmp
end;

var
  Ap,At,F,C,AM:Mp;
  l,k:byte;
  alf:extended;

begin
  C:=NIL;
  Ap:=NIL;
  At:=NIL;
  F:=NIL;
  AM:=NIL;

  { Шаг 1 }

  SetM(Ap,A_(AA(A,1,1)));
  writeln('Ap1!');
  Print(Ap);

  for k:=2 to A^.m do begin
    SetM(At, MMul(AA(A,1,k-1),Ap) );
    SetM(C, SubM(AA(A,k,k),MMul(At,AA(A,k,k))));

    if Compare(C,C^.NUL) then SetM(F,Ed(C^.n))
    else SetM(F,SubM(A_(C),MMul(A_(C),At)));

    SetM(Ap,Dexpand(SubM(Ap,MMul(MMul(Ap,AA(A,k,k)),F)),F));
  end;

  Ap^.st:=TRUE;

  if A^.st then Dispose(A,Done);

  if A^.m>1 then begin
    Dispose(F,Done);
    Dispose(C,Done);
    Dispose(At,Done)
  end;
  G_:=Ap
end;

function VMatr(A:Mp;k:byte):Mp;      {---- Превращение вектора в матрицу }
                 { k - число строк }
var
  tmp:Mp;
  l,j,h:byte;
begin
  new(tmp,Init(k,A^.n div k));
  h:=1;
   for j:=1 to k do
    for l:=1 to A^.n div k do begin
      tmp^.e(l,j)^:=A^.e(h,1)^;
      inc(h)
    end;
  if A^.st then Dispose(A,Done);
  tmp^.st:=TRUE;
  VMatr:=tmp
end;

procedure Print(A:Mp);
var
  l,j:integer;
begin
with A^ do begin
  for l:=1 to n do begin
    for j:=1 to m do write(e(l,j)^:8:2,' ');
    writeln
  end;
end;
end;
end.