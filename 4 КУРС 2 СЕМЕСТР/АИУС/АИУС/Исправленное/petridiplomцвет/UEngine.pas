unit UEngine;

interface

uses
  SysUtils, Classes, Contnrs, Math;


type
  // forward declarations
  TModel = class;

  // Тип времени
  TMoment = Single;

  // Виды распределений
  TDistribution = (rdSimple, rdNormal);

  // Временной интервал
  TInterval = object
  public
    // Вид распределения
    m_Kind : TDistribution;
    // Математическое ожидание
    m_MX : TMoment;
    // Амплитуда или сигма
    m_AX : TMoment;
    // Признак положительности
    m_Positive : Boolean;
    // Создание нечёткого временного интервала
    procedure Init(Kind : TDistribution; MX, AX : TMoment);
    // Генерирует момент из интервала с учётом закона распределения
    function GenerateMoment : TMoment;
  end;

  // Позиция с потерями
  TStorage = class
  public
    // Модель
    m_Model : TModel;
    // Максимальная ёмкость
    m_Capacity : Integer;
    // Число активных меток
    m_Active : Integer;
    // Число пассивных меток
    m_Passive : Integer;
    // Интервал задержки (0 - особо)
    m_Delay : TInterval;
    // Статистика: число пришедших меток
    m_Total : Integer;
    // Статистика: максимум меток
    m_Maximum : Integer;
    // Статистика: время пустой позиции
    m_TimeEmpty : TMoment;
    // Пуста с момента
    m_EmptySince : TMoment;
    // Создание позиции c заданной ёмкостью и задержкой
    constructor Create(model : TModel; capacity, active : Integer; const delay : TInterval);
    // Максимальное число событий
    function MaxSchedule : Integer;
    // Число возможных отсылаемых меток
    function CanSend : Integer;
    // Отсылка меток
    procedure Send(x : Integer);
    // Число возможных принимаемых меток
    function CanRecieve : Integer;
    // Принятие меток
    procedure Recieve(x : Integer);
    // Активация пассивных меток
    procedure OnActivation(Sender : TObject);
    // Вычислить процент загруженности
    function CalcUsage : Single;

  end;

  // Связь между переходом и позицией
  TLink = record
    // Связываемая позиция
    m_Storage : TStorage;
    // Кратность связи
    m_Weight : Integer;
  end;

  // Переход
  TBarrier = class
  public
    // Модель
    m_Model : TModel;
    // Интервал сна после срабатывания (0 - особо)
    m_Sleep : TInterval;
    // Инциденты и ингибиторы
    m_Input, m_Output, m_Pause : array of TLink;
    // Признак сна
    m_Sleeping : Boolean;
    // Признак затора
    m_Jamming : Boolean;
    // Статистика: число срабатываний перехода
    m_Flips : Integer;
    // Статистика: число несрабатываний перехода из-за потерь
    m_Jams : Integer;
    // Статистика: общее время сна
    m_TotalSleep : TMoment;
    // Создание перехода
    constructor Create(model : TModel; const sleep : TInterval);
    // Максимальное число событий
    function MaxSchedule : Integer;
    // Проверка возможности срабатывания перехода
    function CanTransfer : Boolean;
    // Срабатывание перехода
    procedure Transfer;
    // Восстановление перехода
    procedure OnAwaken(Sender : TObject);
  end;

  // Элемент расписания
  TActivity = record
    m_Time : TMoment;
    m_Handler : TNotifyEvent;
  end;

  // Сеть Петри
  TModel = class
  public
  	//Цвет модели !!!
	Color : String[1];
    // Позиции
    m_Storages : array of TStorage;
    // Переходы
    m_Barriers : array of TBarrier;
    // Перестановка переходов с учётом приоритетов
    m_Shuffle : array of Integer;
    // Текущее время
    m_Time : TMoment;
    // Наличие изменений
    m_Changed : Boolean;
    // Число запланированных событий
    m_Pending : Integer;
    // Сбалансированное двоичное дерево событий
    m_Schedule : array of TActivity;
    // Создание пустой сети Петри
    constructor Create;
    // Разрушение модели
    destructor Destroy; override;
    // Создание пустого расписания
    procedure AllocSchedule;
    // Планирование события
    procedure Schedule(t : TMoment; handler : TNotifyEvent);
    // Итеративное достижение согласованного состояния шага
    procedure Step;
  end;


implementation


{ TInterval }


procedure TInterval.Init(Kind: TDistribution; MX, AX: TMoment);
begin
  m_Kind := Kind;
  m_MX := MX;
  m_AX := AX;
  case m_Kind of
    rdSimple : m_Positive := Abs(m_AX) + m_MX > 0;
    rdNormal : m_Positive := True;
  end;
end;


function TInterval.GenerateMoment: TMoment;
const
  N = 100;
var
  i : Integer;
begin
  if m_AX = 0 then begin
    Result := m_MX;
  end else begin
    case m_Kind of
      rdSimple : begin
        Result := (Random(N + N + 1) - N) * (1 / N) * m_AX + m_MX;
      end;
      rdNormal : begin
        Result := 0;
        for i := 1 to 12 do begin
          Result := Result + Random(N + 1);
        end;
        Result := (Result * (1 / N) - 6) * m_AX + m_MX;
      end;
    end;
  end;
end;


{ TStorage }


constructor TStorage.Create(model : TModel; capacity, active : Integer; const delay : TInterval);
begin
  m_Model := model;
  m_Capacity := capacity;
  m_Active := active;
  m_Passive := 0;
  m_Delay := delay;
  m_Total := active;
  m_Maximum := active;
  if active = 0 then m_EmptySince := 0 else m_EmptySince := -1;
end;


function TStorage.MaxSchedule: Integer;
begin
  if m_Delay.m_Positive then begin
    Result := m_Capacity;
  end else begin
    Result := 0;
  end;
end;


function TStorage.CanSend: Integer;
begin
  Result := m_Active;
end;


procedure TStorage.Send(x: Integer);
begin
  x := Min(x, CanSend);
  if x <= 0 then Exit;

  Dec(m_Active, x);
  if m_Active + m_Passive = 0 then m_EmptySince := m_Model.m_Time;
  m_Model.m_Changed := true;
end;


function TStorage.CanRecieve: Integer;
begin
  Result := m_Capacity - m_Active - m_Passive;
end;


procedure TStorage.Recieve(x : Integer);
var
  d : TMoment;
begin
  x := Min(x, CanRecieve);
  if x <= 0 then Exit;

  if m_Delay.m_Positive then begin
    repeat
      d := m_Delay.GenerateMoment();
      if d > 0 then begin
        Inc(m_Passive);
        m_Model.Schedule(m_Model.m_Time + d, OnActivation);
      end else begin
        Inc(m_Active);
      end;
      Inc(m_Total);
      Dec(x);
    until x = 0;
  end else begin
    Inc(m_Active, x);
    Inc(m_Total, x);
  end;
  m_Maximum := Max(m_Maximum, m_Active + m_Passive);

if m_EmptySince >= 0 then begin
    m_TimeEmpty := m_TimeEmpty + (m_Model.m_Time - m_EmptySince);
    m_EmptySince := -1;
  end;

  m_Model.m_Changed := true;
end;


procedure TStorage.OnActivation(Sender : TObject);
begin
  Inc(m_Active);
  Dec(m_Passive);
  m_Model.m_Changed := true;
end;


function TStorage.CalcUsage: Single;
var
  t : TMoment;
begin
  t := m_Model.m_Time;
  if t = 0 then begin
    if m_EmptySince < 0 then Result := 1 else Result := 0;
  end else begin
    if m_EmptySince < 0 then begin
      // Сейчас загружены
      Result := 1 - m_TimeEmpty / t;
    end else begin
      // Свободны начиная с
      Result := (m_EmptySince - m_TimeEmpty) / t;
    end;
  end;
end;


{ TBarrier }


constructor TBarrier.Create(model : TModel; const sleep : TInterval);
begin
  m_Model := model;
  m_Sleep := sleep;
  m_Sleeping := false;
  m_Jamming := false;
  m_Flips := 0;
  m_Jams := 0;
  m_TotalSleep := 0;
end;


function TBarrier.MaxSchedule: Integer;
begin
  Result := 1;
end;


function TBarrier.CanTransfer: Boolean;
var
  i : Integer;
begin
	Result := false;

	// Переход должен работать
	if m_Sleeping or (Length(m_Input) = 0) or (Length(m_Output) = 0) then Exit;

	// Все входы должны иметь кандидатский минимум
	for i := 0 to High(m_Input) do with m_Input[i] do begin
		if m_Storage.CanSend < m_Weight then Exit;
	end;

	// Ингибиторы тоже имеют право голоса.
	// Вписать другие модели -  ингибитор только в разрезе одной модели !!!
	for i := 0 to High(m_Pause) do with m_Pause[i] do begin
		if m_Storage.CanSend < m_Weight then Exit;
		//if m_Storage.CanSend >= m_Weight then Exit;
	end;

	// Все выходы должны быть способны принять
	for i := 0 to High(m_Output) do with m_Output[i] do
	begin
		if m_Storage.CanRecieve < m_Weight then
		begin
			if not m_Jamming then
			begin
				m_Jamming := true;
				Inc(m_Jams);
			end;
			Exit;
		end;
	end;

	Result := true;
end;


procedure TBarrier.Transfer;
var
	i : Integer;
	d : TMoment;
begin
	m_Jamming := false;
	Inc(m_Flips);

	// Изъятие
	for i := 0 to High(m_Input) do with m_Input[i] do begin
		m_Storage.Send(m_Weight);
	end;

	// Пополнение
	for i := 0 to High(m_Output) do with m_Output[i] do begin
		m_Storage.Recieve(m_Weight);
	end;

	d := m_Sleep.GenerateMoment();
	if d > 0 then begin
		m_Sleeping := true;
		m_TotalSleep := m_TotalSleep + d;
		m_Model.Schedule(m_Model.m_Time + d, OnAwaken);
	end;
end;


procedure TBarrier.OnAwaken(Sender: TObject);
begin
	m_Sleeping := false;
	if CanTransfer then m_Model.m_Changed := true;
end;


{ TModel }


constructor TModel.Create;
begin
	m_Time := 0;
	m_Changed := true;

	// Инициализация генератора псевдослучайных чисел
	RandSeed := 666;
end;


destructor TModel.Destroy;
var
	i : Integer;
begin
	for i := 0 to High(m_Storages) do FreeAndNil(m_Storages[i]);
	for i := 0 to High(m_Barriers) do FreeAndNil(m_Barriers[i]);
	inherited;
end;


procedure TModel.AllocSchedule;
var
	c, i : Integer;
begin
	c := 1;
	for i := 0 to High(m_Storages) do Inc(c, m_Storages[i].MaxSchedule);
	for i := 0 to High(m_Barriers) do Inc(c, m_Barriers[i].MaxSchedule);
	SetLength(m_Schedule, c);
end;


procedure TModel.Schedule(t: TMoment; handler: TNotifyEvent);
var
	i, j : Integer;
begin
	// Добавление в конец
	Inc(m_Pending);
	with m_Schedule[m_Pending] do
    begin
		m_Time := t;
		m_Handler := handler;
	end;

	// Продвижение по дереву
	j := m_Pending;
	repeat
		i := j shr 1;
		if i < 1 then Break;
		if m_Schedule[i].m_Time <= m_Schedule[j].m_Time then Break;
		m_Schedule[0] := m_Schedule[i];
		m_Schedule[i] := m_Schedule[j];
		m_Schedule[j] := m_Schedule[0];
		j := i;
	until FALSE;
end;


procedure TModel.Step;
var
	i, j : Integer;
	Handler: TNotifyEvent;
begin
	// Если состояние устойчивое, придерживаемся плана
	while not m_Changed do begin
		if m_Pending <= 0 then Break;
		m_Time := m_Schedule[1].m_Time;
		while (m_Pending > 0) and (m_Schedule[1].m_Time <= m_Time) do
        begin
			Handler := m_Schedule[1].m_Handler;

			// Удаление из начала
			m_Schedule[1] := m_Schedule[m_Pending];
			Dec(m_Pending);

			// Продвижение по дереву
			i := 1;
			repeat
				j := i shl 1;
				if j > m_Pending then Break;
				// Младший вовсе был дурак
				if (j < m_Pending) and (m_Schedule[j + 1].m_Time < m_Schedule[j].m_Time) then Inc(j);

				if m_Schedule[i].m_Time <= m_Schedule[j].m_Time then Break;

				m_Schedule[0] := m_Schedule[i];
				m_Schedule[i] := m_Schedule[j];
				m_Schedule[j] := m_Schedule[0];

				i := j;
			until FALSE;

			// Вызов обработчика
			Handler(Self);
		end;
	end;

	// Достижение устойчивого состояния
	repeat
		m_Changed := false;
		for i := 0 to High(m_Barriers) do with m_Barriers[m_Shuffle[i]] do
		begin
			while CanTransfer do Transfer;
		end;
	until not m_Changed;
end;

end.
