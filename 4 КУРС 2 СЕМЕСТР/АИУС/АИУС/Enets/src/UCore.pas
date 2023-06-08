unit UCore;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Contnrs, Math;


type
  // forward declarations
  TNet = class;

  // Элемент сети
  TEntity = class
  public
    // Родительская сеть
    m_Net : TNet;
    // Прорисовка
    procedure Paint; virtual; abstract;
    // Необходимость перерисовки
    procedure Invalidate; virtual; abstract;
    // Проверка попадания указателя мыши
    function HitTest(x, y : Integer) : Boolean; virtual; abstract;
    // Запись элемента
    procedure Save(var TextWriter : TextFile); virtual; abstract;
  end;

  // Вершина графа
  TNode = class(TEntity)
  public
    // Координаты центра
    m_Pos : TPoint;
    // Имя
    m_Name : string;
    // Прорисовка
    procedure Paint; override;
    // Необходимость перерисовки
    procedure Invalidate; override;
    // Запись устройства
    procedure Save(var TextWriter : TextFile); override;
    // Необходимость перерисовки со связями
    procedure InvalidateWithLinks;
    // Перемещение с перерисовкой
    procedure ChangePos(x, y : Integer);
    // Возможность вывода
    function CanAddOutput : Boolean; virtual; abstract;
    // Возможность ввода
    function CanAddInput : Boolean; virtual; abstract;
  end;

  // Дуга
  TLink = class(TEntity)
  public
    // Связь A->B
    m_A, m_B : TNode;
    // Создание дуги
    constructor Create(net : TNet; A, B : TNode);
    // Прорисовка
    procedure Paint; override;
    // Необходимость перерисовки
    procedure Invalidate; override;
    // Проверка попадания указателя мыши
    function HitTest(x, y : Integer) : Boolean; override;
    // Запись дуги
    procedure Save(var TextWriter : TextFile); override;
    // Чтение дуги
    constructor Load(net : TNet; var TextReader : TextFile);
  end;

  // Переход
  TBarrier = class(TNode)
  public
    // Математическое ожидание
    m_MX : Integer;
    // Дисперсия
    m_DX : Integer;
    // Создание перехода
    constructor Create(net : TNet; X, Y, MX, DX : Integer);
    // Прорисовка
    procedure Paint; override;
    // Необходимость перерисовки
    procedure Invalidate; override;
    // Проверка попадания указателя мыши
    function HitTest(x, y : Integer) : Boolean; override;
    // Запись перехода
    procedure Save(var TextWriter : TextFile); override;
    // Чтение перехода
    constructor Load(net : TNet; var TextReader : TextFile);
    // Возможность вывода
    function CanAddOutput : Boolean; override;
    // Возможность ввода
    function CanAddInput : Boolean; override;
  end;

  // Устройство
  TDevice = class(TNode)
  public
    // Необходимость перерисовки
    procedure Invalidate; override;
    // Возможность вывода
    function CanAddOutput : Boolean; override;
    // Возможность ввода
    function CanAddInput : Boolean; override;
  end;

  // Позиция
  TSlot = class(TDevice)
  public
    // Занятость позиции
    m_Initial : Integer;
    // Создание позиции
    constructor Create(net : TNet; X, Y, initial : Integer);
    // Прорисовка
    procedure Paint; override;
    // Проверка попадания указателя мыши
    function HitTest(x, y : Integer) : Boolean; override;
    // Запись позиции
    procedure Save(var TextWriter : TextFile); override;
    // Чтение позиции
    constructor Load(net : TNet; var TextReader : TextFile);
  end;

  // Очередь
  TQueue = class(TDevice)
  public
    // Вместимость очереди
    m_Capacity : Integer;
    // Занятость очереди
    m_Initial : Integer;
    // Создание очереди
    constructor Create(net : TNet; X, Y, capacity, initial : Integer);
    // Прорисовка
    procedure Paint; override;
    // Проверка попадания указателя мыши
    function HitTest(x, y : Integer) : Boolean; override;
    // Запись очереди
    procedure Save(var TextWriter : TextFile); override;
    // Чтение очереди
    constructor Load(net : TNet; var TextReader : TextFile);
  end;

  // Генератор
  TGenerator = class(TDevice)
  public
    // Математическое ожидание
    m_MX : Integer;
    // Дисперсия
    m_DX : Integer;
    // Создание генератора
    constructor Create(net : TNet; X, Y, MX, DX : Integer);
    // Прорисовка
    procedure Paint; override;
    // Проверка попадания указателя мыши
    function HitTest(x, y : Integer) : Boolean; override;
    // Запись генератора
    procedure Save(var TextWriter : TextFile); override;
    // Чтение генератора
    constructor Load(net : TNet; var TextReader : TextFile);
    // Возможность ввода
    function CanAddInput : Boolean; override;
  end;

  // Абсорбция
  TMurder = class(TDevice)
  public
    // Создание абсорбции
    constructor Create(net : TNet; X, Y : Integer);
    // Прорисовка
    procedure Paint; override;
    // Проверка попадания указателя мыши
    function HitTest(x, y : Integer) : Boolean; override;
    // Чтение абсорбции
    constructor Load(net : TNet; var TextReader : TextFile);
    // Возможность вывода
    function CanAddOutput : Boolean; override;
  end;

  // Разрешающая позиция
  TShaman = class(TDevice)
  public
    // Состояние
    m_State : Integer;
    // Создание разрешения
    constructor Create(net : TNet; X, Y, state : Integer);
    // Прорисовка
    procedure Paint; override;
    // Проверка попадания указателя мыши
    function HitTest(x, y : Integer) : Boolean; override;
    // Запись разрешения
    procedure Save(var TextWriter : TextFile); override;
    // Чтение разрешения
    constructor Load(net : TNet; var TextReader : TextFile);
    // Возможность ввода
    function CanAddInput : Boolean; override;
  end;

  // Программа для GPSS
  TGPSS = class
  public
    // Строки программы
    m_Lines : TStringList;
    // Создание пустой программы
    constructor Create;
    // Разрушение программы
    destructor Destroy; override;
    // Добавление комментария
    procedure AddComment(const s : string);
    // Добавление строки программы
    procedure AddLine(const metka, cmd, params : string);
    // Имя блока
    function NameOf(node : TNode) : string;
    // Имя устройства
    function Device(node : TNode) : string;
    // Имя метки
    function Metka(node : TNode) : string;
  end;

  // E-сеть
  TNet = class
  public
    // Полотно
    m_Canvas : TCanvas;
    // Область прокрутки
    m_Box : TScrollBox;
    // Вершины
    m_Nodes : TObjectList;
    // Дуги
    m_Links : TObjectList;
    // Выбранный элемент
    m_Selected : TEntity;
    // Создание пустой сети
    constructor Create(canvas : TCanvas; box : TScrollBox);
    // Разрушение сети
    destructor Destroy; override;
    // Очистка сети
    procedure Clear;
    // Выбор устройства
    procedure Select(entity : TEntity);
    // Прорисовка
    procedure Paint;
    // Необходимость перерисовки
    procedure Invalidate(x, y, w, h : Integer);
    // Проверка попадания указателя мыши
    function HitTest(x, y : Integer) : TEntity;
    // Запись сети
    procedure Save(var TextWriter : TextFile);
    // Чтение сети
    procedure Load(var TextReader : TextFile);
    // Поиск шамана
    function GPSS_ShamanFor(node : TNode) : TShaman;
    // Генерация программы
    procedure Translate(GPSS : TGPSS);
  end;


implementation


{ TNode }


procedure TNode.Paint;
var
  e : TSize;
begin
  if m_Name = '' then Exit;
  with m_Net.m_Canvas do begin
    Brush.Style := bsClear;
    e := TextExtent(m_Name);
    TextOut(m_Pos.X - (e.cx shr 1), m_Pos.Y - 15 - e.cy, m_Name);
  end;
end;


procedure TNode.Invalidate;
var
  e : TSize;
begin
  if m_Name = '' then Exit;
  with m_Net.m_Canvas do begin
    e := TextExtent(m_Name);
  end;
  m_Net.Invalidate(m_Pos.X - (e.cx shr 1), m_Pos.Y - 15 - e.cy, e.cx, e.cy);
end;


procedure TNode.Save(var TextWriter: TextFile);
begin
  WriteLn(TextWriter, m_Pos.X, ' ', m_Pos.Y);
  WriteLn(TextWriter, m_Name);
end;


procedure TNode.InvalidateWithLinks;
var
  i : Integer;
  link : TLink;
begin
  Invalidate;
  with m_Net.m_Links do begin
    for i := 0 to Count - 1 do begin
      link := TLink(Items[i]);
      if (link.m_A = Self) or (link.m_B = Self) then link.Invalidate;
    end;
  end;
end;


procedure TNode.ChangePos(x, y: Integer);
begin
  x := EnsureRange(x, 10, m_Net.m_Box.HorzScrollBar.Range - 10);
  y := EnsureRange(y, 10, m_Net.m_Box.VertScrollBar.Range - 10);
  if (m_Pos.X <> x) or (m_Pos.Y <> y) then begin
    InvalidateWithLinks;
    m_Pos.X := x;
    m_Pos.Y := y;
    InvalidateWithLinks;
  end;
end;


{ TLink }


constructor TLink.Create(net: TNet; A, B: TNode);
begin
  m_Net := net;
  m_A := A;
  m_B := B;
  m_Net.m_Links.Add(Self);
end;


procedure TLink.Paint;
var
  AX, AY, BX, BY, MX, MY, CX, CY, DX, DY : Integer;
  Lab, cosw, sinw : Real;
begin
  AX := TDevice(m_A).m_Pos.X;
  AY := TDevice(m_A).m_Pos.Y;
  BX := TDevice(m_B).m_Pos.X;
  BY := TDevice(m_B).m_Pos.Y;
  MX := (AX + BX) shr 1;
  MY := (AY + BY) shr 1;

  Lab := Sqrt(Max(1, Sqr(BX - AX) + Sqr(BY - AY)));
  cosw := (BX - AX) / Lab;
  sinw := (BY - AY) / Lab;

  CX := MX + Round(-10 * cosw - 5 * sinw);
  CY := MY + Round(-10 * sinw + 5 * cosw);
  DX := MX + Round(-10 * cosw + 5 * sinw);
  DY := MY + Round(-10 * sinw - 5 * cosw);

  with m_Net.m_Canvas do begin
    MoveTo(AX, AY);  LineTo(BX, BY);
    MoveTo(MX, MY);  LineTo(CX, CY);
    MoveTo(MX, MY);  LineTo(DX, DY);
  end;
end;


procedure TLink.Invalidate;
var
  AX, AY, BX, BY, t : Integer;
begin
  AX := TDevice(m_A).m_Pos.X;
  AY := TDevice(m_A).m_Pos.Y;
  BX := TDevice(m_B).m_Pos.X;
  BY := TDevice(m_B).m_Pos.Y;
  if AX > BX then begin t := AX; AX := BX; BX := t; end;
  if AY > BY then begin t := AY; AY := BY; BY := t; end;
  m_Net.Invalidate(AX - 10, AY - 10, BX - AX + 20, BY - AY + 20);
end;


function TLink.HitTest(x, y: Integer): Boolean;
var
  AX, AY, BX, BY, VX, VY : Integer;
begin
  AX := TDevice(m_A).m_Pos.X;
  AY := TDevice(m_A).m_Pos.Y;
  BX := TDevice(m_B).m_Pos.X;
  BY := TDevice(m_B).m_Pos.Y;
  VX := BX - AX;
  VY := BY - AY;
  Result :=
    ((x - AX) * VX >= (AY - y) * VY) and
    ((x - BX) * VX <= (BY - y) * VY) and
    (Abs((x - AX) * VY + (AY - y) * VX) <= Sqrt(Sqr(VX) + Sqr(VY)) * 5);
end;


procedure TLink.Save(var TextWriter: TextFile);
var
  na, nb : Integer;
begin
  na := m_Net.m_Nodes.IndexOf(m_A);
  nb := m_Net.m_Nodes.IndexOf(m_B);
  WriteLn(TextWriter, na, ' ', nb);
end;


constructor TLink.Load(net: TNet; var TextReader: TextFile);
var
  na, nb : Integer;
begin
  m_Net := net;
  ReadLn(TextReader, na, nb);
  m_A := TNode(m_Net.m_Nodes.Items[na]);
  m_B := TNode(m_Net.m_Nodes.Items[nb]);
  m_Net.m_Links.Add(Self);
end;


{ TBarrier }


constructor TBarrier.Create(net : TNet; X, Y, MX, DX : Integer);
begin
  m_Net := net;
  m_Pos.X := X;
  m_Pos.Y := Y;
  m_MX := MX;
  m_DX := DX;
  m_Net.m_Nodes.Add(Self);
end;


procedure TBarrier.Paint;
begin
  inherited;
  with m_Net.m_Canvas do begin
    Brush.Style := bsSolid;
    Brush.Color := Pen.Color;
    Rectangle(m_Pos.X - 2, m_Pos.Y - 10, m_Pos.X + 2, m_Pos.Y + 10);
  end;
end;


procedure TBarrier.Invalidate;
begin
  inherited;
  m_Net.Invalidate(m_Pos.X - 2, m_Pos.Y - 10, 4, 20);
end;


function TBarrier.HitTest(x, y: Integer): Boolean;
begin
  Result := (Abs(x - m_Pos.X) <= 5) and (Abs(y - m_Pos.Y) <= 10);
end;


procedure TBarrier.Save(var TextWriter: TextFile);
begin
  inherited;
  WriteLn(TextWriter, m_MX, ' ', m_DX);
end;


constructor TBarrier.Load(net: TNet; var TextReader: TextFile);
begin
  m_Net := net;
  ReadLn(TextReader, m_Pos.X, m_Pos.Y);
  ReadLn(TextReader, m_Name);
  ReadLn(TextReader, m_MX, m_DX);
  m_Net.m_Nodes.Add(Self);
end;


function TBarrier.CanAddOutput: Boolean;
begin
  Result := true;
end;


function TBarrier.CanAddInput: Boolean;
begin
  Result := true;
end;


{ TDevice }


procedure TDevice.Invalidate;
begin
  inherited;
  m_Net.Invalidate(m_Pos.X - 10, m_Pos.Y - 10, 20, 20);
end;


function TDevice.CanAddOutput: Boolean;
var
  i : Integer;
begin
  with m_Net.m_Links do begin
    for i := 0 to Count - 1 do begin
      if TLink(Items[i]).m_A = Self then begin
        Result := false;
        Exit;
      end;
    end;
  end;
  Result := true;
end;


function TDevice.CanAddInput: Boolean;
var
  i : Integer;
begin
  with m_Net.m_Links do begin
    for i := 0 to Count - 1 do begin
      if TLink(Items[i]).m_B = Self then begin
        Result := false;
        Exit;
      end;
    end;
  end;
  Result := true;
end;


{ TSlot }


constructor TSlot.Create(net : TNet; X, Y, initial : Integer);
begin
  m_Net := net;
  m_Pos.X := X;
  m_Pos.Y := Y;
  m_Initial := initial;
  m_Net.m_Nodes.Add(Self);
end;


procedure TSlot.Paint;
begin
  inherited;
  with m_Net.m_Canvas do begin
    Brush.Style := bsSolid;
    Brush.Color := clCream;
    Ellipse(m_Pos.X - 10, m_Pos.Y - 10, m_Pos.X + 10, m_Pos.Y + 10);
    if m_Initial <> 0 then begin
      Brush.Style := bsClear;
      Rectangle(m_Pos.X - 2, m_Pos.Y - 2, m_Pos.X + 2, m_Pos.Y + 2);
    end;
  end;
end;


function TSlot.HitTest(x, y: Integer): Boolean;
begin
  Result := Sqr(x - m_Pos.X) + Sqr(y - m_Pos.Y) <= 100;
end;


procedure TSlot.Save(var TextWriter: TextFile);
begin
  inherited;
  WriteLn(TextWriter, m_Initial);
end;


constructor TSlot.Load(net : TNet; var TextReader : TextFile);
begin
  m_Net := net;
  ReadLn(TextReader, m_Pos.X, m_Pos.Y);
  ReadLn(TextReader, m_Name);
  ReadLn(TextReader, m_Initial);
  m_Net.m_Nodes.Add(Self);
end;


{ TQueue }


constructor TQueue.Create(net : TNet; X, Y, capacity, initial : Integer);
begin
  m_Net := net;
  m_Pos.X := X;
  m_Pos.Y := Y;
  m_Capacity := capacity;
  m_Initial := initial;
  m_Net.m_Nodes.Add(Self);
end;


procedure TQueue.Paint;
begin
  inherited;
  with m_Net.m_Canvas do begin
    Brush.Style := bsSolid;
    Brush.Color := clSkyBlue;
    Ellipse(m_Pos.X - 10, m_Pos.Y - 10, m_Pos.X + 10, m_Pos.Y + 10);
    Brush.Style := bsClear;
    TextOut(m_Pos.X - 4, m_Pos.Y - 7, 'Q');
  end;
end;


function TQueue.HitTest(x, y: Integer): Boolean;
begin
  Result := Sqr(x - m_Pos.X) + Sqr(y - m_Pos.Y) <= 100;
end;


procedure TQueue.Save(var TextWriter: TextFile);
begin
  inherited;
  WriteLn(TextWriter, m_Capacity, ' ', m_Initial);
end;


constructor TQueue.Load(net: TNet; var TextReader: TextFile);
begin
  m_Net := net;
  ReadLn(TextReader, m_Pos.X, m_Pos.Y);
  ReadLn(TextReader, m_Name);
  ReadLn(TextReader, m_Capacity, m_Initial);
  m_Net.m_Nodes.Add(Self);
end;


{ TGenerator }


constructor TGenerator.Create(net : TNet; X, Y, MX, DX : Integer);
begin
  m_Net := net;
  m_Pos.X := X;
  m_Pos.Y := Y;
  m_MX := MX;
  m_DX := DX;
  m_Net.m_Nodes.Add(Self);
end;


procedure TGenerator.Paint;
begin
  inherited;
  with m_Net.m_Canvas do begin
    Brush.Style := bsSolid;
    Brush.Color := clLtGray;
    Rectangle(m_Pos.X - 10, m_Pos.Y - 10, m_Pos.X + 10, m_Pos.Y + 10);
    Brush.Style := bsClear;
    TextOut(m_Pos.X - 4, m_Pos.Y - 7, 'G');
  end;
end;


function TGenerator.HitTest(x, y: Integer): Boolean;
begin
  Result := (Abs(x - m_Pos.X) <= 10) and (Abs(y - m_Pos.Y) <= 10);
end;


procedure TGenerator.Save(var TextWriter: TextFile);
begin
  inherited;
  WriteLn(TextWriter, m_MX, ' ', m_DX);
end;


constructor TGenerator.Load(net: TNet; var TextReader: TextFile);
begin
  m_Net := net;
  ReadLn(TextReader, m_Pos.X, m_Pos.Y);
  ReadLn(TextReader, m_Name);
  ReadLn(TextReader, m_MX, m_DX);
  m_Net.m_Nodes.Add(Self);
end;


function TGenerator.CanAddInput: Boolean;
begin
  Result := false;
end;


{ TMurder }


constructor TMurder.Create(net : TNet; X, Y : Integer);
begin
  m_Net := net;
  m_Pos.X := X;
  m_Pos.Y := Y;
  m_Net.m_Nodes.Add(Self);
end;


procedure TMurder.Paint;
begin
  inherited;
  with m_Net.m_Canvas do begin
    Brush.Style := bsSolid;
    Brush.Color := clLtGray;
    Rectangle(m_Pos.X - 10, m_Pos.Y - 10, m_Pos.X + 10, m_Pos.Y + 10);
    Brush.Style := bsClear;
    TextOut(m_Pos.X - 4, m_Pos.Y - 7, 'A');
  end;
end;


function TMurder.HitTest(x, y: Integer): Boolean;
begin
  Result := (Abs(x - m_Pos.X) <= 10) and (Abs(y - m_Pos.Y) <= 10);
end;


constructor TMurder.Load(net: TNet; var TextReader: TextFile);
begin
  m_Net := net;
  ReadLn(TextReader, m_Pos.X, m_Pos.Y);
  ReadLn(TextReader, m_Name);
  m_Net.m_Nodes.Add(Self);
end;


function TMurder.CanAddOutput: Boolean;
begin
  Result := false;
end;


{ TShaman }


constructor TShaman.Create(net : TNet; X, Y, state : Integer);
begin
  m_Net := net;
  m_Pos.X := X;
  m_Pos.Y := Y;
  m_State := state;
  m_Net.m_Nodes.Add(Self);
end;


procedure TShaman.Paint;
begin
  inherited;
  with m_Net.m_Canvas do begin
    Brush.Style := bsSolid;
    Brush.Color := clLime;
    Rectangle(m_Pos.X - 10, m_Pos.Y - 10, m_Pos.X + 10, m_Pos.Y + 10);
    Brush.Style := bsClear;
    TextOut(m_Pos.X - 4, m_Pos.Y - 7, 'R');
  end;
end;


function TShaman.HitTest(x, y: Integer): Boolean;
begin
  Result := (Abs(x - m_Pos.X) <= 10) and (Abs(y - m_Pos.Y) <= 10);
end;


procedure TShaman.Save(var TextWriter: TextFile);
begin
  inherited;
  WriteLn(TextWriter, m_State);
end;


constructor TShaman.Load(net: TNet; var TextReader: TextFile);
begin
  m_Net := net;
  ReadLn(TextReader, m_Pos.X, m_Pos.Y);
  ReadLn(TextReader, m_Name);
  ReadLn(TextReader, m_State);
  m_Net.m_Nodes.Add(Self);
end;


function TShaman.CanAddInput: Boolean;
begin
  Result := false;
end;


{ TGPSS }


constructor TGPSS.Create;
begin
  m_Lines := TStringList.Create;
  m_Lines.Sorted := false;
  m_Lines.Duplicates := dupAccept;
  m_Lines.Capacity := 10000;
end;


destructor TGPSS.Destroy;
begin
  FreeAndNil(m_Lines);
  inherited;
end;


procedure TGPSS.AddComment(const s: string);
begin
  m_Lines.Add(IntToStr(m_Lines.Count + 1) + ' * ' + s);
end;


procedure TGPSS.AddLine(const metka, cmd, params: string);
begin
  m_Lines.Add(IntToStr(m_Lines.Count + 1) + ' ' + metka + #9 + cmd + #9 + params);
end;


function TGPSS.NameOf(node: TNode): string;
begin
  if node.m_Name <> '' then begin
    Result := node.m_Name;
  end else begin
    Result := IntToStr(node.m_Net.m_Nodes.IndexOf(node) + 1);
  end;
end;


function TGPSS.Device(node: TNode): string;
begin
  Result := '_' + NameOf(node);
end;


function TGPSS.Metka(node: TNode): string;
begin
  Result := '_' + NameOf(node) + '_';
end;


{ TNet }


constructor TNet.Create(canvas : TCanvas; box : TScrollBox);
begin
  m_Canvas := canvas;
  m_Box := box;
  m_Nodes := TObjectList.Create(true);
  m_Nodes.Capacity := 256;
  m_Links := TObjectList.Create(true);
  m_Links.Capacity := 256;
end;


destructor TNet.Destroy;
begin
  FreeAndNil(m_Links);
  FreeAndNil(m_Nodes);
  inherited;
end;


procedure TNet.Clear;
begin
  m_Selected := nil;
  m_Links.Clear;
  m_Nodes.Clear;
  m_Box.Invalidate;
end;


procedure TNet.Select(entity : TEntity);
begin
  // Отменяем существующий выбор
  if m_Selected <> nil then begin
    m_Selected.Invalidate;
    m_Selected := nil;
  end;

  // Выбираем устройство
  if entity <> nil then begin
    m_Selected := entity;
    m_Selected.Invalidate;
  end;
end;


procedure TNet.Paint;
var
  i : Integer;
  entity : TEntity;
begin
  for i := 0 to m_Links.Count - 1 do begin
    entity := TEntity(m_Links.Items[i]);
    if entity = m_Selected then begin
      m_Canvas.Pen.Color := clRed;
    end else begin
      m_Canvas.Pen.Color := clBlack;
    end;
    entity.Paint;
  end;

  for i := 0 to m_Nodes.Count - 1 do begin
    entity := TEntity(m_Nodes.Items[i]);
    if entity = m_Selected then begin
      m_Canvas.Pen.Color := clRed;
      m_Canvas.Font.Color := clRed;
    end else begin
      m_Canvas.Pen.Color := clBlack;
      m_Canvas.Font.Color := clBlack;
    end;
    entity.Paint;
  end;
end;


procedure TNet.Invalidate(x, y, w, h : Integer);
var
  r : TRect;
begin
  Dec(x, m_Box.HorzScrollBar.Position);
  r.Left := x;
  r.Right := x + w;
  Dec(y, m_Box.VertScrollBar.Position);
  r.Top := y;
  r.Bottom := y + h;
  InvalidateRect(m_Box.Handle, @r, true);
end;


function TNet.HitTest(x, y : Integer) : TEntity;
var
  i : Integer;
begin
  for i := m_Nodes.Count - 1 downto 0 do begin
    Result := TEntity(m_Nodes.Items[i]);
    if Result.HitTest(x, y) then Exit;
  end;

  for i := m_Links.Count - 1 downto 0 do begin
    Result := TEntity(m_Links.Items[i]);
    if Result.HitTest(x, y) then Exit;
  end;

  Result := nil;
end;


procedure TNet.Save(var TextWriter: TextFile);
var
  i : Integer;
  node : TNode;
  link : TLink;
begin
  for i := 0 to m_Nodes.Count - 1 do begin
    node := TNode(m_Nodes.Items[i]);
    if node is TBarrier then WriteLn(TextWriter, 'Переход') else
    if node is TSlot then WriteLn(TextWriter, 'Позиция') else
    if node is TQueue then WriteLn(TextWriter, 'Очередь') else
    if node is TGenerator then WriteLn(TextWriter, 'Генератор') else
    if node is TMurder then WriteLn(TextWriter, 'Абсорбция') else
    if node is TShaman then WriteLn(TextWriter, 'Разрешение') else
    raise Exception.Create('Неизвестное устройство');
    node.Save(TextWriter);
  end;

  for i := 0 to m_Links.Count - 1 do begin
    link := TLink(m_Links.Items[i]);
    WriteLn(TextWriter, 'Дуга');
    link.Save(TextWriter);
  end;
end;


procedure TNet.Load(var TextReader: TextFile);
var
  kind : string;
begin
  while not SeekEof(TextReader) do begin
    ReadLn(TextReader, kind);
    if kind = 'Дуга' then TLink.Load(Self, TextReader) else
    if kind = 'Переход' then TBarrier.Load(Self, TextReader) else
    if kind = 'Позиция' then TSlot.Load(Self, TextReader) else
    if kind = 'Очередь' then TQueue.Load(Self, TextReader) else
    if kind = 'Генератор' then TGenerator.Load(Self, TextReader) else
    if kind = 'Абсорбция' then TMurder.Load(Self, TextReader) else
    if kind = 'Разрешение' then TShaman.Load(Self, TextReader) else
    raise Exception.Create('Неизвестный элемент');
  end;
end;


function TNet.GPSS_ShamanFor(node : TNode) : TShaman;
var
  i : Integer;
  link : TLink;
begin
  for i := 0 to m_Links.Count - 1 do begin
    link := TLink(m_Links.Items[i]);
    if (link.m_B = node) and (link.m_A is TShaman) then begin
      Result := TShaman(link.m_A);
      Exit;
    end;
  end;
  Result := nil;
end;


procedure TNet.Translate(GPSS : TGPSS);
var
  i, j, n : Integer;
  node : TNode;
  link : TLink;
  prev, next : TBarrier;
  shaman, moniker : TShaman;
  main : Boolean;
begin
  GPSS.AddComment('This program was generated by "enets.exe"');
  GPSS.AddComment('');

  // Для очередей объявляем памяти
  for i := 0 to m_Nodes.Count - 1 do begin
    node := TNode(m_Nodes.Items[i]);
    if node is TQueue then begin
      GPSS.AddLine(GPSS.Device(node), 'STORAGE', IntToStr(TQueue(node).m_Capacity));
    end;
  end;

  // Для переходов с шаманом объявляем семафоры
  for i := 0 to m_Nodes.Count - 1 do begin
    node := TNode(m_Nodes.Items[i]);
    if node is TBarrier then begin
      shaman := GPSS_ShamanFor(node);
      if shaman <> nil then begin
        // Подсчитываем выходную ёмкость
        n := 0;
        for j := 0 to m_Links.Count - 1 do begin
          link := TLink(m_Links.Items[j]);
          if link.m_A = node then begin
            if link.m_B is TSlot then Inc(n);
            if link.m_B is TQueue then Inc(n, TQueue(link.m_B).m_Capacity);
          end;
        end;
        GPSS.AddLine(GPSS.Device(shaman), 'STORAGE', IntToStr(n));
      end;
    end;
  end;

  // Блок инициализации
  GPSS.AddLine('','GENERATE',',,,1');
  for i := 0 to m_Nodes.Count - 1 do begin
    node := TNode(m_Nodes.Items[i]);
    n := 0;
    if node is TSlot then n := Integer(TSlot(node).m_Initial <> 0);
    if node is TQueue then n := TQueue(node).m_Initial;
    if n > 0 then begin
      // Поиск шамана предыдущего перехода
      moniker := nil;
      for j := 0 to m_Links.Count - 1 do begin
        link := TLink(m_Links.Items[j]);
        if link.m_B = node then begin
          moniker := GPSS_ShamanFor(link.m_A);
          Break;
        end;
      end;
      if moniker = nil then begin
        GPSS.AddLine('','SPLIT', IntToStr(n) + ',' + GPSS.Metka(node));
      end;
    end;
  end;
  GPSS.AddLine('','TERMINATE','');

  // Тело сети
  for i := 0 to m_Nodes.Count - 1 do begin
    node := TNode(m_Nodes.Items[i]);
    if node is TBarrier then Continue;
    if node is TMurder then Continue;
    if node is TShaman then Continue;

    // Поиск переходов
    prev := nil;
    for j := 0 to m_Links.Count - 1 do begin
      link := TLink(m_Links.Items[j]);
      if link.m_B = node then begin
        prev := (link.m_A as TBarrier);
        Break;
      end;
    end;
    next := nil;
    for j := 0 to m_Links.Count - 1 do begin
      link := TLink(m_Links.Items[j]);
      if link.m_A = node then begin
        next := (link.m_B as TBarrier);
        Break;
      end;
    end;

    // Только один главный вход
    main := true;
    for j := 0 to m_Links.Count - 1 do begin
      link := TLink(m_Links.Items[j]);
      if (link.m_B = next) and
         ((link.m_A is TSlot) or
          (link.m_A is TQueue) or
          (link.m_A is TGenerator))
      then begin
        main := (link.m_A = node);
        Break;
      end;
    end;

    // Занятие устройства
    if node is TSlot then begin
      GPSS.AddComment('Pozicia ' + GPSS.NameOf(node));
      GPSS.AddLine(GPSS.Metka(node), 'SEIZE', GPSS.Device(node));
    end;
    if node is TQueue then begin
      GPSS.AddComment('Ochered ' + GPSS.NameOf(node));
      GPSS.AddLine(GPSS.Metka(node), 'ENTER', GPSS.Device(node));
      GPSS.AddLine('','SEIZE', GPSS.Device(node));
    end;
    if node is TGenerator then begin
      GPSS.AddComment('Generator ' + GPSS.NameOf(node));
      GPSS.AddLine('','GENERATE',
        IntToStr(TGenerator(node).m_MX) + ',' + IntToStr(TGenerator(node).m_DX) + ',1');
      GPSS.AddLine('','SEIZE', GPSS.Device(node));
    end;

    // Висячее устройство
    if next = nil then begin
      GPSS.AddLine('','TERMINATE','');
      Continue;
    end;

    // Условие срабатывания перехода
    shaman := GPSS_ShamanFor(next);
    if shaman = nil then begin
      GPSS.AddLine('','GATE NU', GPSS.Device(next));
      if not main then begin
        GPSS.AddLine('','GATE U', GPSS.Device(next));
      end else begin
        for j := 0 to m_Links.Count - 1 do begin
          link := TLink(m_Links.Items[j]);
          if (link.m_B = next) and (link.m_A <> node) then begin
            if (link.m_A is TSlot) or
               (link.m_A is TQueue) or
               (link.m_A is TGenerator)
            then begin
              GPSS.AddLine('','GATE U', GPSS.Device(link.m_A));
            end;
          end;
        end;
        for j := 0 to m_Links.Count - 1 do begin
          link := TLink(m_Links.Items[j]);
          if link.m_A = next then begin
            if link.m_B is TSlot then begin
              GPSS.AddLine('','GATE NU', GPSS.Device(link.m_B));
            end;
            if link.m_B is TQueue then begin
              GPSS.AddLine('','GATE SNF', GPSS.Device(link.m_B));
            end;
          end;
        end;
        GPSS.AddLine('','SEIZE', GPSS.Device(next));
      end;
    end else begin
      GPSS.AddLine('','ENTER', GPSS.Device(shaman));
      GPSS.AddLine('','SEIZE', GPSS.Device(next));
    end;

    // Освобождение устройства
    GPSS.AddLine('','RELEASE', GPSS.Device(node));
    if node is TQueue then GPSS.AddLine('','LEAVE', GPSS.Device(node));
    if prev <> nil then begin
      moniker := GPSS_ShamanFor(prev);
      if moniker <> nil then begin
        GPSS.AddLine('','LEAVE', GPSS.Device(moniker));
      end;
    end;

    if shaman = nil then begin
      // Размножение только по главному входу
      if not main then begin
        GPSS.AddLine('','TERMINATE','');
        Continue;
      end;
    end;

    // Переход работает
    if next.m_DX > 0 then begin
      GPSS.AddLine('','ADVANCE', IntToStr(next.m_MX) + ',' + IntToStr(next.m_DX));
    end else begin
      GPSS.AddLine('','ADVANCE', IntToStr(next.m_MX));
    end;
    GPSS.AddLine('','RELEASE', GPSS.Device(next));

    if shaman = nil then begin
      // Размножение
      for j := 0 to m_Links.Count - 1 do begin
        link := TLink(m_Links.Items[j]);
        if (link.m_A = next) and not(link.m_B is TMurder) then begin
          GPSS.AddLine('','SPLIT', '1,' + GPSS.Metka(link.m_B));
        end;
      end;
      GPSS.AddLine('','TERMINATE','');
    end else begin
      // Поиск свободной позиции
      for j := 0 to m_Links.Count - 1 do begin
        link := TLink(m_Links.Items[j]);
        if (link.m_A = next) and (link.m_B is TSlot) then begin
          GPSS.AddLine('','TEST E',
            'F$' + GPSS.Device(link.m_B) + ',1,' + GPSS.Metka(link.m_B));
        end;
      end;
      // Поиск пустой очереди
      for j := 0 to m_Links.Count - 1 do begin
        link := TLink(m_Links.Items[j]);
        if (link.m_A = next) and (link.m_B is TQueue) then begin
          GPSS.AddLine('','TEST E',
            'SE$' + GPSS.Device(link.m_B) + ',0,' + GPSS.Metka(link.m_B));
        end;
      end;
      // Поиск незаполненной очереди
      for j := 0 to m_Links.Count - 1 do begin
        link := TLink(m_Links.Items[j]);
        if (link.m_A = next) and (link.m_B is TQueue) then begin
          GPSS.AddLine('','TEST E',
            'SF$' + GPSS.Device(link.m_B) + ',1,' + GPSS.Metka(link.m_B));
        end;
      end;
      GPSS.AddLine('','TERMINATE','');
    end;
  end;

  // Пуск
  GPSS.AddComment('');
  GPSS.AddLine('','GENERATE','1000');
  GPSS.AddLine('','TERMINATE','1');
  GPSS.AddLine('','START','1');
end;


end.
