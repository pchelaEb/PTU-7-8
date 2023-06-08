unit UMain;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  Menus, Grids, Spin, Math, UEngine;


type
	TMain = class(TForm)
		LabelStorages: TLabel;
		SpinStorages: TSpinEdit;
		LabelBarriers: TLabel;
		SpinBarriers: TSpinEdit;
		LabelCapacity: TLabel;
		GridCapacity: TStringGrid;
		LabelDelay: TLabel;
		GridDelay: TStringGrid;
		LabelActive: TLabel;
		GridActive: TStringGrid;
		LabelSleep: TLabel;
		GridSleep: TStringGrid;
		LabelPriority: TLabel;
		GridPriority: TStringGrid;
		LabelIncident: TLabel;
		GridIncident: TStringGrid;
		LabelIngibitor: TLabel;
		GridIngibitor: TStringGrid;
		MainMenu: TMainMenu;
		MenuFile: TMenuItem;
		MenuNew: TMenuItem;
		MenuOpen: TMenuItem;
		MenuSave: TMenuItem;
		MenuHR1: TMenuItem;
		MenuQuit: TMenuItem;
		MenuModel: TMenuItem;
		OpenDialog: TOpenDialog;
		SaveDialog: TSaveDialog;
		MenuDistribution: TMenuItem;
		MenuSimple: TMenuItem;
		MenuNormal: TMenuItem;
		N1: TMenuItem;
		N2: TMenuItem;
		N3: TMenuItem;
		ColorEdit: TSpinEdit;
		Label1: TLabel;
		procedure SpinStoragesChange(Sender: TObject);
		procedure SpinBarriersChange(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
		procedure MenuNewClick(Sender: TObject);
		procedure MenuOpenClick(Sender: TObject);
		procedure MenuSaveClick(Sender: TObject);
		procedure MenuQuitClick(Sender: TObject);
		procedure MenuModelClick(Sender: TObject);
		procedure N3Click(Sender: TObject);
		procedure N2Click(Sender: TObject);
	private
		procedure ClearTables;
		function TakeInteger(Grid : TStringGrid; Col, Row : Integer; out Value : Integer) : Boolean;
		function TakeIntegerC(Grid : TStringGrid; Color : String  ; Col, Row : Integer; out Value : Integer) : Boolean;
		function TakeInterval(Grid : TStringGrid; Col, Row : Integer; out Value : TInterval) : Boolean;
		function MakeModel(Model : TModel; TType : String) : Boolean;
		function ApplyPriorities(Model : TModel) : Boolean;
	end;

var
  Main: TMain;


implementation

{$R *.dfm}

uses
  USim, UAbout, UHelp;


procedure TMain.ClearTables;
var
  i : Integer;
begin
  GridCapacity.Rows[1].Clear;
  GridDelay.Rows[1].Clear;
  GridActive.Rows[1].Clear;
  GridSleep.Rows[1].Clear;
  GridPriority.Rows[1].Clear;
  for i := 1 to GridIncident.RowCount do GridIncident.Rows[i].Clear;
  for i := 1 to GridIngibitor.RowCount do GridIngibitor.Rows[i].Clear;
end;


procedure TMain.SpinStoragesChange(Sender: TObject);
var
  n, i : Integer;
  s : string;
begin
  n := SpinStorages.Value;

  GridCapacity.ColCount := n;
  GridDelay.ColCount := n;
  GridActive.ColCount := n;
  GridIncident.RowCount := n + 1;
  GridIngibitor.RowCount := n + 1;

  for i := 1 to n do begin
    s := 'P' + IntToStr(i);
    GridCapacity.Cells[i - 1, 0] := s;
    GridDelay.Cells[i - 1, 0] := s;
    GridActive.Cells[i - 1, 0] := s;
    GridIncident.Cells[0, i] := s;
    GridIngibitor.Cells[0, i] := s;
  end;
end;


procedure TMain.SpinBarriersChange(Sender: TObject);
var
  n, i : Integer;
  s : string;
begin
  n := SpinBarriers.Value;

  GridSleep.ColCount := n;
  GridPriority.ColCount := n;
  GridIncident.ColCount := n + 1;
  GridIngibitor.ColCount := n + 1;

  for i := 1 to n do begin
    s := 'T' + IntToStr(i);
    GridSleep.Cells[i - 1, 0] := s;
    GridPriority.Cells[i - 1, 0] := s;
    GridIncident.Cells[i, 0] := s;
    GridIngibitor.Cells[i, 0] := s;
  end;
end;


procedure TMain.FormCreate(Sender: TObject);
begin
  SpinStoragesChange(nil);
  SpinBarriersChange(nil);
end;


procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('Вы действительно хотите выйти из программы?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;


procedure TMain.MenuNewClick(Sender: TObject);
begin
  if MessageDlg('Очистить сеть?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    ClearTables;
    SpinStorages.Value := 1;
    SpinBarriers.Value := 1;
    ColorEdit.Value := 1;
  end;
end;


procedure TMain.MenuOpenClick(Sender: TObject);
var
  Reader : TextFile;
  ns, nb, nc, i, j : Integer;
  s : string;
begin
  if not OpenDialog.Execute then Exit;

  AssignFile(Reader, OpenDialog.FileName);
  Reset(Reader);
  try
    ReadLn(Reader, ns, nb, nc);
    SpinStorages.Value := ns;
    SpinBarriers.Value := nb;
    ColorEdit.Value := nc;

    for i := 1 to ns do begin
      ReadLn(Reader, s);  GridCapacity.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridDelay.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridActive.Cells[i - 1, 1] := s;
    end;

    for i := 1 to nb do begin
      ReadLn(Reader, s);  GridSleep.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridPriority.Cells[i - 1, 1] := s;
    end;

    for i := 1 to ns do begin
      for j := 1 to nb do begin
        ReadLn(Reader, s);  GridIncident.Cells[j, i] := s;
        ReadLn(Reader, s);  GridIngibitor.Cells[j, i] := s;
      end;
    end;
  finally
    CloseFile(Reader);
  end;
end;


procedure TMain.MenuSaveClick(Sender: TObject);
var
  Writer : TextFile;
  ns, nb, i, j : Integer;
begin
  SaveDialog.FileName := OpenDialog.FileName;
  if not SaveDialog.Execute then Exit;

  AssignFile(Writer, SaveDialog.FileName);
  Rewrite(Writer);
  try
    ns := SpinStorages.Value;
    nb := SpinBarriers.Value;
    WriteLn(Writer, ns, ' ', nb, ' ', ColorEdit.Value);

    for i := 1 to ns do begin
      WriteLn(Writer, GridCapacity.Cells[i - 1, 1]);
      WriteLn(Writer, GridDelay.Cells[i - 1, 1]);
      WriteLn(Writer, GridActive.Cells[i - 1, 1]);
    end;

    for i := 1 to nb do begin
      WriteLn(Writer, GridSleep.Cells[i - 1, 1]);
      WriteLn(Writer, GridPriority.Cells[i - 1, 1]);
    end;

    for i := 1 to ns do begin
      for j := 1 to nb do begin
        WriteLn(Writer, GridIncident.Cells[j, i]);
        WriteLn(Writer, GridIngibitor.Cells[j, i]);
      end;
    end;

    WriteLn(Writer, '<EOF>');
  finally
    CloseFile(Writer);
  end;
end;


procedure TMain.MenuQuitClick(Sender: TObject);
begin
  Close;
end;


function TMain.TakeInteger(Grid: TStringGrid; Col, Row: Integer; out Value: Integer): Boolean;
var
  e : Integer;
  s : string;
begin
  s := Grid.Cells[Col, Row];
  if s = '' then s := '0';
  Val(s, Value, e);
  Result := (e = 0);
  if not Result then begin
    Grid.Col := Col;
    Grid.Row := Row;
    ActiveControl := Grid;
  end;
end;

function TMain.TakeIntegerC(Grid: TStringGrid; Color : String; Col, Row: Integer; out Value: Integer): Boolean;
var
  e : Integer;
  s : string;
  i : Integer;
begin
  s := Grid.Cells[Col, Row];
  if s = '' then s := '0';

    e := 0;
    Value := 0;
    For i := 1 to Length(S) Do
        If S[i] = Color[1] Then
        Begin
            e := 1;
            Val(s[i-1], Value, e);
            If i > 2 then
            Begin
                If S[i-2] = '-' Then Value := 0 - Value;
            End;
        End;

    Result := (e = 0);
    if not Result then
    begin
        Grid.Col := Col;
        Grid.Row := Row;
        ActiveControl := Grid;
    end;
end;



function TMain.TakeInterval(Grid: TStringGrid; Col, Row: Integer; out Value: TInterval): Boolean;
var
  p, emx, eax : Integer;
  mx, ax : TMoment;
  s, smx, sax : string;
begin
  s := Grid.Cells[Col, Row];
  p := Pos('#', s);
  if p > 0 then begin
    smx := Copy(s, 1, p - 1);
    sax := Copy(s, p + 1, Length(s) - p);
  end else begin
    smx := s;
    sax := '';
  end;
  if smx = '' then smx := '0';
  if sax = '' then sax := '0';
  Val(smx, mx, emx);
  Val(sax, ax, eax);
  Result := (emx = 0) and (eax = 0);
  if Result then begin
    if MenuSimple.Checked then Value.Init(rdSimple, MX, AX);
    if MenuNormal.Checked then Value.Init(rdNormal, MX, AX);
  end else begin
    Grid.Col := Col;
    Grid.Row := Row;
    ActiveControl := Grid;
  end;
end;


function TMain.MakeModel(Model: TModel; TType : String): Boolean;
var
    ns, nb, i, j : Integer;
    capacity, active : Integer;
    delay, sleep : TInterval;
    ins, outs, dir : Integer;
    Barrier : TBarrier;
begin
	Result := false;
	ns := SpinStorages.Value;
	nb := SpinBarriers.Value;

	SetLength(Model.m_Storages, ns);
	SetLength(Model.m_Barriers, nb);
	SetLength(Model.m_Shuffle, nb);

    Model.Color := TType[1];

	for i := 1 to ns do
	begin
		if TakeIntegerC(GridCapacity, TType, i - 1, 1, capacity) and
		TakeInterval(GridDelay, i - 1, 1, delay) and
		TakeIntegerC(GridActive, TType, i - 1, 1, active)
		then else Exit;
		Model.m_Storages[i - 1] := TStorage.Create(Model, capacity, active, delay);
	end;

	for i := 1 to nb do
    begin
		if not TakeInterval(GridSleep, i - 1, 1, sleep) then Exit;
		Barrier := TBarrier.Create(Model, sleep);
		Model.m_Barriers[i - 1] := Barrier;

		ins := 0;
		outs := 0;
		for j := 1 to ns do
        begin
			if not TakeIntegerC(GridIncident, TType, i, j, dir) then Exit;
			if dir < 0 then Inc(ins);
			if dir > 0 then Inc(outs);
		end;
		SetLength(Barrier.m_Input, ins);
		SetLength(Barrier.m_Output, outs);

		ins := 0;
		outs := 0;
		for j := 1 to ns do
        begin
			if not TakeIntegerC(GridIncident, TType, i, j, dir) then Exit;
			if dir < 0 then
            begin
				with Barrier.m_Input[ins] do
				begin
					m_Storage := Model.m_Storages[j - 1];
					m_Weight := -dir;
				end;
				Inc(ins);
			end;
			if dir > 0 then
			begin
				with Barrier.m_Output[outs] do
				begin
					m_Storage := Model.m_Storages[j - 1];
					m_Weight := +dir;
				end;
				Inc(outs);
			end;
		end;

		ins := 0;
		for j := 1 to ns do
		begin //Ингибиторные дуги (раскрасить ?)
			if not TakeIntegerC(GridIngibitor, TType, i, j, dir) then Exit;
			if dir <> 0 then Inc(ins);
		end;
		SetLength(Barrier.m_Pause, ins);

		ins := 0;
		for j := 1 to ns do
		begin //Ингибиторные дуги (раскрасить ?)
			if not TakeIntegerC(GridIngibitor, TType, i, j, dir) then Exit;
			if dir <> 0 then
	        begin
				with Barrier.m_Pause[ins] do
				begin
					m_Storage := Model.m_Storages[j - 1];
					m_Weight := Abs(dir);
				end;
				Inc(ins);
			end;
		end;
	end;

	for i := 0 to nb - 1 do Model.m_Shuffle[i] := i;
	Result := true;
end;


function TMain.ApplyPriorities(Model: TModel): Boolean;
var
	i, w, m, t : Integer;
	P : array of Integer;
begin
  Result := false;

  SetLength(P, Length(Model.m_Shuffle));
  for i := 0 to High(P) do begin
    if not TakeInteger(GridPriority, i, 1, P[i]) then Exit;
  end;

  w := 0;
  while w < High(P) do begin
    // Поиск максимума
    m := P[w];
    for i := w + 1 to High(P) do m := Max(m, P[i]);
    // Перекачка
    for i := w to High(P) do if P[i] = m then begin
                       t := Model.m_Shuffle[w];
      Model.m_Shuffle[w] := Model.m_Shuffle[i];
      Model.m_Shuffle[i] := t;

      P[i] := P[w];
      Inc(w);
    end;
  end;

  Result := true;
end;


procedure TMain.MenuModelClick(Sender: TObject);
var
  Model : TModel;
  Models : array [1..9] of TModel;
  Sim : TSim;
  Ind : integer;
  CharSet : Array [1..9] of String[1];
begin

    CharSet[1] := 'a';
    CharSet[2] := 'b';
    CharSet[3] := 'c';
    CharSet[4] := 'd';
    CharSet[5] := 'e';
    CharSet[6] := 'f';
    CharSet[7] := 'g';
    CharSet[8] := 'h';
    CharSet[9] := 'i';

    For Ind := 1 To 9 Do
    Begin
        Models[ind] := Nil;
    End;


    For Ind := 1 To ColorEdit.Value Do
    Begin
        Models[ind] := TModel.Create;
        if MakeModel(Models[ind], CharSet[Ind]) and ApplyPriorities(Models[ind]) then;
    End;

    Sim := TSim.Born(Self, Models);

    try
        Sim.ShowModal;
    finally
        FreeAndNil(Sim);
    end;
end;


procedure TMain.N3Click(Sender: TObject);
begin
About.show;
end;

procedure TMain.N2Click(Sender: TObject);
begin
Help.show;
end;

end.
