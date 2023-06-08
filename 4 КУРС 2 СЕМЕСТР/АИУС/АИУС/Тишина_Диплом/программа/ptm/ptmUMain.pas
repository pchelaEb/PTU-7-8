unit ptmUMain;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  Menus, Grids, Spin, Math, ptmUEngine;


type
  TptmMain = class(TForm)
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
    LabelPorog: TLabel;
    GridPorog: TStringGrid;
    LabelTimeLive: TLabel;
    GridTimeLive: TStringGrid;
    Label1: TLabel;
    EditKol: TEdit;
    Button1: TButton;
    GridKol: TStringGrid;
    Label2: TLabel;
    Label3: TLabel;
    GridPot: TStringGrid;
    GridMetki: TStringGrid;
    Label4: TLabel;
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
    //===========
    procedure OpenModelFile(filename: string);
    procedure Button1Click(Sender: TObject);

  private
    procedure ClearTables;
    function TakeInteger(Grid : TStringGrid; Col, Row : Integer; out Value : Integer) : Boolean;
    function TakeInterval(Grid : TStringGrid; Col, Row : Integer; out Value : TInterval) : Boolean;
    function TakeMetki(Grid : TStringGrid; Col, Row : Integer; out Value : TMetki; out Remake : boolean; out Mines : boolean) : Boolean;
    function TakeSingle(Grid : TstringGrid; Col, Row : Integer; out Value : Single): Boolean;
    function MakeModel(Model : TModel) : Boolean;
    function ApplyPriorities(Model : TModel) : Boolean;
  end;

var
  ptmMain: TptmMain;


implementation

{$R *.dfm}

uses
  ptmUSim, ptmUAbout, ptmUHelp;


procedure TptmMain.ClearTables;
var
  i : Integer;
begin
  GridCapacity.Rows[1].Clear;
  GridDelay.Rows[1].Clear;
  GridActive.Rows[1].Clear;
  GridSleep.Rows[1].Clear;
  GridPriority.Rows[1].Clear;
  GridPorog.Rows[1].Clear;
  GridTimeLive.Rows[1].Clear;
  GridPot.Rows[1].Clear;


  for i := 1 to GridIncident.RowCount do GridIncident.Rows[i].Clear;
  for i := 1 to GridIngibitor.RowCount do GridIngibitor.Rows[i].Clear;
end;


procedure TptmMain.SpinStoragesChange(Sender: TObject);
var
  n, i : Integer;
  s : string;
begin
  n := SpinStorages.Value;

  GridCapacity.ColCount := n;
  GridDelay.ColCount := n;
  GridActive.ColCount := n;
  GridTimeLive.ColCount := n;
  GridIncident.RowCount := n + 1;
  GridIngibitor.RowCount := n + 1;

  for i := 1 to n do begin
    s := 'P' + IntToStr(i);
    GridCapacity.Cells[i - 1, 0] := s;
    GridDelay.Cells[i - 1, 0] := s;
    GridActive.Cells[i - 1, 0] := s;
    GridTimeLive.Cells[i - 1, 0] := s;
    GridIncident.Cells[0, i] := s;
    GridIngibitor.Cells[0, i] := s;
    GridMetki.Cells[0, i] := s;
  end;
end;


procedure TptmMain.SpinBarriersChange(Sender: TObject);
var
  n, i : Integer;
  s : string;
begin
  n := SpinBarriers.Value;
  GridSleep.ColCount := n;
  GridPriority.ColCount := n;
  GridIncident.ColCount := n + 1;
  GridIngibitor.ColCount := n + 1;
  GridPorog.ColCount := n;
  GridPot.ColCount := n;

  for i := 1 to n do begin
    s := 'T' + IntToStr(i);
    GridSleep.Cells[i - 1, 0] := s;
    GridPriority.Cells[i - 1, 0] := s;
    GridIncident.Cells[i, 0] := s;
    GridIngibitor.Cells[i, 0] := s;
    GridPorog.Cells[i-1,0] :=s;
    GridPot.Cells[i - 1, 0] := s;

  end;


end;

procedure TptmMain.FormCreate(Sender: TObject);
begin
  SpinStoragesChange(nil);
  SpinBarriersChange(nil);
end;


procedure TptmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('�� ������������� ������ ����� �� ���������?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;


procedure TptmMain.MenuNewClick(Sender: TObject);
begin
  if MessageDlg('�������� ����?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    ClearTables;
    SpinStorages.Value := 1;
    SpinBarriers.Value := 1;
  end;
end;

procedure TptmMain.OpenModelFile(filename: string);
var
  Reader : TextFile;
  ns, nb, nm, i, j, y : Integer;
  s : string;
begin
  AssignFile(Reader, filename);
  //ShowMessage(filename);
  Reset(Reader);
  try
    ReadLn(Reader, ns, nb, nm);
    SpinStorages.Value := ns;
    SpinBarriers.Value := nb;
    GridMetki.RowCount := ns + 1;

    for i := 1 to ns do begin
      ReadLn(Reader, s);  GridCapacity.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridDelay.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridActive.Cells[i - 1, 1] := s;
      j := StrToInt(s);
      if GridMetki.ColCount <= j then
       GridMetki.ColCount:=j+1;
      ReadLn(Reader, s);  GridTimeLive.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  j:=0;
      while s<>'' do begin    
       inc(j);
       GridMetki.Cells[j,i]:=copy(s,1,pos(';',s)-1);
       delete(s,1,pos(';',s));
      end;
      ReadLn(Reader, s);
      if s<>'0' then
       GridMetki.Cells[0,i]:=GridMetki.Cells[0,i]+'(���)';
    end;

    for i := 1 to nb do begin
      ReadLn(Reader, s);  GridSleep.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridPriority.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridPorog.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridPot.Cells[i - 1, 1] := s;
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
procedure TptmMain.MenuOpenClick(Sender: TObject);

begin
  if OpenDialog.Execute then
  //AssignFile(Reader, OpenDialog.FileName);
  OpenModelFile(OpenDialog.FileName);
end;


procedure TptmMain.MenuSaveClick(Sender: TObject);
var
  Writer : TextFile;
  ns, nb, nm, i, j, y : Integer;
begin
  SaveDialog.FileName := OpenDialog.FileName;
  if not SaveDialog.Execute then Exit;

  AssignFile(Writer, SaveDialog.FileName);
  Rewrite(Writer);
  try
    ns := SpinStorages.Value;
    nb := SpinBarriers.Value;
    WriteLn(Writer, ns, ' ', nb);

    for i := 1 to ns do begin
      WriteLn(Writer, GridCapacity.Cells[i - 1, 1]);
      WriteLn(Writer, GridDelay.Cells[i - 1, 1]);
      WriteLn(Writer, GridActive.Cells[i - 1, 1]);
      WriteLn(Writer, GridTimeLive.Cells[i - 1, 1]);
    end;

    for i := 1 to nb do begin
      WriteLn(Writer, GridSleep.Cells[i - 1, 1]);
      WriteLn(Writer, GridPriority.Cells[i - 1, 1]);
      WriteLn(Writer, GridPorog.Cells[i - 1, 1]);
      WriteLn(Writer, GridPot.Cells[i - 1, 1]);
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


procedure TptmMain.MenuQuitClick(Sender: TObject);
begin
  Close;
end;


function TptmMain.TakeInteger(Grid: TStringGrid; Col, Row: Integer; out Value: Integer): Boolean;
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

function TptmMain.TakeSingle(Grid : TStringGrid; Col, Row: Integer; out Value : Single) : Boolean;
var
  e : Integer;
  s : string;
begin
  s := Grid.Cells[Col, Row];
  if s = '' then s := '0';
  Value := StrToFloat(s);
  //Val(s, Value, e);
  Result := (e = 0);
  if not Result then begin
    Grid.Col := Col;
    Grid.Row := Row;
    ActiveControl := Grid;
   // ShowMessage(s);
  end;
end;


function TptmMain.TakeInterval(Grid: TStringGrid; Col, Row: Integer; out Value: TInterval): Boolean;
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

function TptmMain.TakeMetki(Grid : TStringGrid; Col, Row : Integer; out Value : TMetki; out Remake : Boolean; out Mines : boolean) : Boolean;
var i:word;
begin
 Setlength(Value,0);
 i := Col;
 Remake:=pos('(���)',Grid.Cells[0,Row])>0;
 while (i<Grid.ColCount) and (Grid.Cells[i,Row]<>'')do begin
  Setlength(Value,i);
  Value[i-1]:=StrToFloat(Grid.Cells[i,Row]);
  if StrToFloat(Grid.Cells[i,Row])<0 then Mines := true else
  Mines:=false;
  inc(i);
 end;
 Result := true;
end;

function TptmMain.MakeModel(Model: TModel): Boolean;
var
  ns, nb, nm, i, j, y : Integer;
  capacity, active, timelive, ko : Integer;
  delay, sleep : TInterval;
  Metki : TMetki;
  Remake : boolean;
  Mines : boolean;
  ins, outs, dir : Integer;
  Barrier : TBarrier;
begin
  Result := false;

  ns := SpinStorages.Value;
  nb := SpinBarriers.Value;

  SetLength(Model.m_Storages, ns);
  SetLength(Model.m_Barriers, nb);
  SetLength(Model.m_Shuffle, nb);

  for i := 1 to ns do begin
    if TakeInteger(GridCapacity, i - 1, 1, capacity) and
       TakeInterval(GridDelay, i - 1, 1, delay) and
       TakeInteger(GridActive, i - 1, 1, active) and
       TakeInteger(GridTimeLive, i - 1, 1, timelive) and
       TakeMetki(GridMetki, 1, i , Metki, Remake, Mines)
    then else Exit;

    Model.m_Storages[i - 1] := TStorage.Create(Model, capacity, active, timelive, delay, Metki, Remake, Mines);
  end;

  for i := 1 to nb do begin
    if not TakeInterval(GridSleep, i - 1, 1, sleep) then Exit;

    Barrier := TBarrier.Create(Model, sleep);
    Model.m_Barriers[i - 1] := Barrier;
    TakeInteger(GridPorog, i-1,1,Model.m_Barriers[i - 1].m_Porog);//��������
    TakeSingle(GridPot, i-1,1,Model.m_Barriers[i - 1].m_Pot);
    ins := 0;
    outs := 0;
    for j := 1 to ns do begin
      if not TakeInteger(GridIncident, i, j, dir) then Exit;
      if dir < 0 then Inc(ins);
      if dir > 0 then Inc(outs);
    end;
    SetLength(Barrier.m_Input, ins);
    SetLength(Barrier.m_Output, outs);

    ins := 0;
    outs := 0;
    for j := 1 to ns do begin
      if not TakeInteger(GridIncident, i, j, dir) then Exit;
      if dir < 0 then begin
        with Barrier.m_Input[ins] do begin
          m_Storage := Model.m_Storages[j - 1];
          m_Weight := -dir;
        end;
        Inc(ins);
      end;
      if dir > 0 then begin
        with Barrier.m_Output[outs] do begin
          m_Storage := Model.m_Storages[j - 1];
          m_Weight := +dir;
        end;
        Inc(outs);
      end;
    end;

    ins := 0;
    for j := 1 to ns do begin
      if not TakeInteger(GridIngibitor, i, j, dir) then Exit;
      if dir <> 0 then Inc(ins);
    end;
    SetLength(Barrier.m_Pause, ins);

    ins := 0;
    for j := 1 to ns do begin
      if not TakeInteger(GridIngibitor, i, j, dir) then Exit;
      if dir <> 0 then begin
        with Barrier.m_Pause[ins] do begin
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


function TptmMain.ApplyPriorities(Model: TModel): Boolean;
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
    // ����� ���������
    m := P[w];
    for i := w + 1 to High(P) do m := Max(m, P[i]);
    // ���������
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


procedure TptmMain.MenuModelClick(Sender: TObject);
var
  Model : TModel;
  Sim : TptmSim;
begin
  Model := TModel.Create;
  try
    if MakeModel(Model) and ApplyPriorities(Model) then begin
      Sim := TptmSim.Born(Self, Model);
      try
        Sim.ShowModal;
      finally
        FreeAndNil(Sim);
      end;
    end;
  finally
    FreeAndNil(Model);
  end;
end;


procedure TptmMain.N3Click(Sender: TObject);
begin
ptmAbout.show;
end;

procedure TptmMain.N2Click(Sender: TObject);
begin
ptmHelp.show;
end;

procedure TptmMain.Button1Click(Sender: TObject);
var
i, n, m, k,j, kmax : Integer;
s : string;
kof : string;
begin
kmax :=0;
 n := SpinBarriers.Value;
  for i := 1 to n + 1 do begin
   if  GridPorog.Cells[i - 1, 1] <> '1' then
   EditKol.Text := GridPorog.Cells[i - 1, 1];
   end;

   m := SpinStorages.Value;

   for i := 1 to m do begin
   k := StrToInt(GridTimeLive.Cells[i - 1, 1]);
    if k > kmax then
   kmax := k;
   end;

   GridKol.ColCount := kmax + 1;
   GridKol.RowCount := m + 1;

   for i := 1 to kmax + 1 do begin
   s := 'K' + IntToStr(i);
    GridKol.Cells[i, 0] := s;
    end;

  for i:=1 to m + 1 do begin
    s := 'P' + IntToStr(i);
    GridKol.Cells[0, i] := s;
    end;

    for i := 1 to m + 1 do begin
   GridKol.Cells[1, i] := FloatToStr(1);
   end;

  for j := 1 to m do begin
   k := StrToInt(GridTimeLive.Cells[j - 1, 1]);
    for i := 1 to k do begin
    kof := FloatToStr((k-i)/k);
   if (k-i)/k <= 0 then GridKol.Cells[i+1, j]:='0'
   else
    GridKol.Cells[i+1, j] := kof;
  end;
    end;
     end;





end.
