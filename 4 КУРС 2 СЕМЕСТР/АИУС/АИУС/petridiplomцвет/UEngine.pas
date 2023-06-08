unit UEngine;

interface

uses
  SysUtils, Classes, Contnrs, Math;


type
  // forward declarations
  TModel = class;

  // ��� �������
  TMoment = Single;

  // ���� �������������
  TDistribution = (rdSimple, rdNormal);

  // ��������� ��������
  TInterval = object
  public
    // ��� �������������
    m_Kind : TDistribution;
    // �������������� ��������
    m_MX : TMoment;
    // ��������� ��� �����
    m_AX : TMoment;
    // ������� ���������������
    m_Positive : Boolean;
    // �������� ��������� ���������� ���������
    procedure Init(Kind : TDistribution; MX, AX : TMoment);
    // ���������� ������ �� ��������� � ������ ������ �������������
    function GenerateMoment : TMoment;
  end;

  // ������� � ��������
  TStorage = class
  public
    // ������
    m_Model : TModel;
    // ������������ �������
    m_Capacity : Integer;
    // ����� �������� �����
    m_Active : Integer;
    // ����� ��������� �����
    m_Passive : Integer;
    // �������� �������� (0 - �����)
    m_Delay : TInterval;
    // ����������: ����� ��������� �����
    m_Total : Integer;
    // ����������: �������� �����
    m_Maximum : Integer;
    // ����������: ����� ������ �������
    m_TimeEmpty : TMoment;
    // ����� � �������
    m_EmptySince : TMoment;
    // �������� ������� c �������� �������� � ���������
    constructor Create(model : TModel; capacity, active : Integer; const delay : TInterval);
    // ������������ ����� �������
    function MaxSchedule : Integer;
    // ����� ��������� ���������� �����
    function CanSend : Integer;
    // ������� �����
    procedure Send(x : Integer);
    // ����� ��������� ����������� �����
    function CanRecieve : Integer;
    // �������� �����
    procedure Recieve(x : Integer);
    // ��������� ��������� �����
    procedure OnActivation(Sender : TObject);
    // ��������� ������� �������������
    function CalcUsage : Single;

  end;

  // ����� ����� ��������� � ��������
  TLink = record
    // ����������� �������
    m_Storage : TStorage;
    // ��������� �����
    m_Weight : Integer;
  end;

  // �������
  TBarrier = class
  public
    // ������
    m_Model : TModel;
    // �������� ��� ����� ������������ (0 - �����)
    m_Sleep : TInterval;
    // ��������� � ����������
    m_Input, m_Output, m_Pause : array of TLink;
    // ������� ���
    m_Sleeping : Boolean;
    // ������� ������
    m_Jamming : Boolean;
    // ����������: ����� ������������ ��������
    m_Flips : Integer;
    // ����������: ����� �������������� �������� ��-�� ������
    m_Jams : Integer;
    // ����������: ����� ����� ���
    m_TotalSleep : TMoment;
    // �������� ��������
    constructor Create(model : TModel; const sleep : TInterval);
    // ������������ ����� �������
    function MaxSchedule : Integer;
    // �������� ����������� ������������ ��������
    function CanTransfer : Boolean;
    // ������������ ��������
    procedure Transfer;
    // �������������� ��������
    procedure OnAwaken(Sender : TObject);
  end;

  // ������� ����������
  TActivity = record
    m_Time : TMoment;
    m_Handler : TNotifyEvent;
  end;

  // ���� �����
  TModel = class
  public
  	//���� ������ !!!
	Color : String[1];
    // �������
    m_Storages : array of TStorage;
    // ��������
    m_Barriers : array of TBarrier;
    // ������������ ��������� � ������ �����������
    m_Shuffle : array of Integer;
    // ������� �����
    m_Time : TMoment;
    // ������� ���������
    m_Changed : Boolean;
    // ����� ��������������� �������
    m_Pending : Integer;
    // ���������������� �������� ������ �������
    m_Schedule : array of TActivity;
    // �������� ������ ���� �����
    constructor Create;
    // ���������� ������
    destructor Destroy; override;
    // �������� ������� ����������
    procedure AllocSchedule;
    // ������������ �������
    procedure Schedule(t : TMoment; handler : TNotifyEvent);
    // ����������� ���������� �������������� ��������� ����
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
      // ������ ���������
      Result := 1 - m_TimeEmpty / t;
    end else begin
      // �������� ������� �
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

	// ������� ������ ��������
	if m_Sleeping or (Length(m_Input) = 0) or (Length(m_Output) = 0) then Exit;

	// ��� ����� ������ ����� ������������ �������
	for i := 0 to High(m_Input) do with m_Input[i] do begin
		if m_Storage.CanSend < m_Weight then Exit;
	end;

	// ���������� ���� ����� ����� ������.
	// ������� ������ ������ -  ��������� ������ � ������� ����� ������ !!!
	for i := 0 to High(m_Pause) do with m_Pause[i] do begin
		if m_Storage.CanSend < m_Weight then Exit;
		//if m_Storage.CanSend >= m_Weight then Exit;
	end;

	// ��� ������ ������ ���� �������� �������
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

	// �������
	for i := 0 to High(m_Input) do with m_Input[i] do begin
		m_Storage.Send(m_Weight);
	end;

	// ����������
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

	// ������������� ���������� ��������������� �����
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
	// ���������� � �����
	Inc(m_Pending);
	with m_Schedule[m_Pending] do
    begin
		m_Time := t;
		m_Handler := handler;
	end;

	// ����������� �� ������
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
	// ���� ��������� ����������, �������������� �����
	while not m_Changed do begin
		if m_Pending <= 0 then Break;
		m_Time := m_Schedule[1].m_Time;
		while (m_Pending > 0) and (m_Schedule[1].m_Time <= m_Time) do
        begin
			Handler := m_Schedule[1].m_Handler;

			// �������� �� ������
			m_Schedule[1] := m_Schedule[m_Pending];
			Dec(m_Pending);

			// ����������� �� ������
			i := 1;
			repeat
				j := i shl 1;
				if j > m_Pending then Break;
				// ������� ����� ��� �����
				if (j < m_Pending) and (m_Schedule[j + 1].m_Time < m_Schedule[j].m_Time) then Inc(j);

				if m_Schedule[i].m_Time <= m_Schedule[j].m_Time then Break;

				m_Schedule[0] := m_Schedule[i];
				m_Schedule[i] := m_Schedule[j];
				m_Schedule[j] := m_Schedule[0];

				i := j;
			until FALSE;

			// ����� �����������
			Handler(Self);
		end;
	end;

	// ���������� ����������� ���������
	repeat
		m_Changed := false;
		for i := 0 to High(m_Barriers) do with m_Barriers[m_Shuffle[i]] do
		begin
			while CanTransfer do Transfer;
		end;
	until not m_Changed;
end;

end.
