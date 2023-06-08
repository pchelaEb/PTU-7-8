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
    LabelLamda: TLabel;
    GridLamda: TStringGrid;
    LabelFunc: TLabel;
    GridFunc: TStringGrid;
    GridRefunc: TStringGrid;
    FuncList: TComboBox;
    GridRefuncClone: TStringGrid;
    Label1: TLabel;
    procedure SpinStoragesChange(Sender: TObject);
    procedure SpinBarriersChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
//    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MenuNewClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuSaveClick(Sender: TObject);
    procedure MenuQuitClick(Sender: TObject);
    procedure MenuModelClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    //===========
    procedure OpenModelFile(filename: string);
    procedure FuncListChange(Sender: TObject);
    procedure GridRefuncSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridRefuncClick(Sender: TObject);
  private
    procedure ClearTables;
    function TakeInteger(Grid : TStringGrid; Col, Row : Integer; out Value : Integer) : Boolean;

    function TakeReal(Grid : TStringGrid; Col, Row : Integer; out Value : Real) : Boolean;          //***********************

    function TakeInterval(Grid : TStringGrid; Col, Row : Integer; out Value : TInterval) : Boolean;
    function MakeModel(Model : TModel) : Boolean;
    function ApplyPriorities(Model : TModel) : Boolean;
  end;

var
  ptmMain: TptmMain;
  ThisCol, ThisRow : Integer;


implementation

{$R *.dfm}

uses
  ptmUSim, ptmUAbout, ptmUHelp;


procedure TptmMain.ClearTables;
var
  i : Integer;
begin

  GridLamda.Rows[1].Clear;    //****************************************
  GridFunc.Rows[1].Clear;
  GridRefunc.Rows[1].Clear;
  GridRefuncClone.Rows[1].Clear;


  GridCapacity.Rows[1].Clear;
  GridDelay.Rows[1].Clear;
  GridActive.Rows[1].Clear;
  GridSleep.Rows[1].Clear;
  GridPriority.Rows[1].Clear;
  for i := 1 to GridIncident.RowCount do GridIncident.Rows[i].Clear;
  for i := 1 to GridIngibitor.RowCount do GridIngibitor.Rows[i].Clear;
end;


procedure TptmMain.SpinStoragesChange(Sender: TObject);
var
  n, i : Integer;
  s : string;     mju : real;
begin                                                    //***********************************
  n := SpinStorages.Value;     //      for i := 0 to n do begin mju :=0; end;


  GridCapacity.ColCount := n;
  GridDelay.ColCount := n;
  GridActive.ColCount := n;
  GridIncident.RowCount := n + 1;
  GridIngibitor.RowCount := n + 1;
  GridRefunc.ColCount := n;
  GridRefuncClone.ColCount := n;

  for i := 1 to n do begin
    s := 'P' + IntToStr(i);
    GridCapacity.Cells[i - 1, 0] := s;
    GridDelay.Cells[i - 1, 0] := s;
    GridActive.Cells[i - 1, 0] := s;
    GridIncident.Cells[0, i] := s;
    GridIngibitor.Cells[0, i] := s;
    GridRefunc.Cells[i - 1, 0] := s;

        //******************************************
   
  end;
end;


procedure TptmMain.SpinBarriersChange(Sender: TObject);
var
  n, i : Integer;
  s : string;
begin
  n := SpinBarriers.Value;

  GridLamda.ColCount := n;  //*************************************************
  GridFunc.ColCount := n;
  GridSleep.ColCount := n;
  GridPriority.ColCount := n;
  GridIncident.ColCount := n + 1;
  GridIngibitor.ColCount := n + 1;

  for i := 1 to n do begin
    s := 'T' + IntToStr(i);

  //  s1 := 'T' + FloatToStr(i);
    Gridlamda.Cells[i - 1, 0] := s;    //***************************
    GridFunc.Cells[i - 1, 0] := s;
    GridSleep.Cells[i - 1, 0] := s;
    GridPriority.Cells[i - 1, 0] := s;
    GridIncident.Cells[i, 0] := s;
    GridIngibitor.Cells[i, 0] := s;
  end;
end;


procedure TptmMain.FormCreate(Sender: TObject);
begin

   LabelLamda.Caption := 'Вектор пороговых значений ' + 'лямбда' + ' ';
   LabelFunc.Caption := 'Вектор начальных значений f(t)';// + #181 + ' ';
   Label1.Caption := 'Вектор функций принадлежности ' + #181 + ' (Pi, P(i-1), f(t)) ';

  SpinStoragesChange(nil);
  SpinBarriersChange(nil);

  FuncList.Visible := false;

  FuncList.Width  := GridRefunc.ColWidths[0];
  FuncList.Height := GridRefunc.RowHeights[0];

  FuncList.Items.Add( #181 + 'i = ( min (' + #181 + 'i, max(' + #181 + '(i-1), f(t) ) ) )' );
  FuncList.Items.Add(#181 + 'i = ( max (' + #181 + 'i, min(' + #181 + '(i-1), f(t) ) ) )');
 {   FuncList.Items.Add('функция 3');
  FuncList.Items.Add('функция 4');
    FuncList.Items.Add('функция 5');
  FuncList.Items.Add('функция 6'); }
end;


{procedure TptmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('Вы действительно хотите выйти из программы?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;
 }

procedure TptmMain.MenuNewClick(Sender: TObject);
begin
  if MessageDlg('Очистить сеть?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    ClearTables;
    SpinStorages.Value := 1;
    SpinBarriers.Value := 1;
  end;
end;

procedure TptmMain.OpenModelFile(filename: string);
var
  Reader : TextFile;
  ns, nb, i, j, i2: Integer;
  s : string;
begin
  AssignFile(Reader, filename);
  //ShowMessage(filename);
  Reset(Reader);
  try
    ReadLn(Reader, ns, nb);
    SpinStorages.Value := ns;
    SpinBarriers.Value := nb;

    for i := 1 to ns do begin
      ReadLn(Reader, s);  GridCapacity.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridDelay.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridActive.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridRefunc.Cells[i - 1, 1] := s;

      for i2:=0 to FuncList.Items.Count do
      begin
          if (FuncList.Items.Strings[i2] = s) then
          begin
              GridRefuncClone.Cells[i - 1, 1] := IntToStr(i2);
              break;
          end;
      end;

    end;

    for i := 1 to nb do begin
      ReadLn(Reader, s);  GridLamda.Cells[i - 1, 1] := s;   //*************************
      ReadLn(Reader, s);  GridFunc.Cells[i - 1, 1] := s;
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

procedure TptmMain.MenuOpenClick(Sender: TObject);
var mju : real;                                    //*********************************
begin
  if OpenDialog.Execute then       //   mju :=0; mju := Random;
//  m_Model.m_Storages.m_mju := mju;
  //AssignFile(Reader, OpenDialog.FileName);
  OpenModelFile(OpenDialog.FileName);
end;


procedure TptmMain.MenuSaveClick(Sender: TObject);
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
    WriteLn(Writer, ns, ' ', nb);

    for i := 1 to ns do begin
      WriteLn(Writer, GridCapacity.Cells[i - 1, 1]);
      WriteLn(Writer, GridDelay.Cells[i - 1, 1]);
      WriteLn(Writer, GridActive.Cells[i - 1, 1]);
      WriteLn(Writer, GridRefunc.Cells[i - 1, 1]);

    end;

    for i := 1 to nb do begin
      WriteLn(Writer, GridLamda.Cells[i - 1, 1]);        //****************************
      WriteLn(Writer, GridFunc.Cells[i - 1, 1]);
      WriteLn(Writer, GridSleep.Cells[i - 1, 1]);
      WriteLn(Writer, GridPriority.Cells[i - 1, 1]);
            
      

    end;

    for i := 1 to ns do begin
      for j := 1 to nb do begin
        WriteLn(Writer, GridIncident.Cells[j, i]);
        WriteLn(Writer, GridIngibitor.Cells[j, i]);
      end;
    end;

    WriteLn(Writer, '');
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
                                                                 //***********************************
function TptmMain.TakeReal(Grid: TStringGrid; Col, Row: Integer; out Value: Real): Boolean;
var
  e : Real;
  s : string;
begin
  s := Grid.Cells[Col, Row];
  if s = '' then s := '0';
 // Val(s, Value, e);
  try
    Value  := StrToFloat(s);
    Result := true;
  except
    ShowMessage('Ошибка: Неверно введено число!');
    Result := false;
  end;
  if not Result then begin
    Grid.Col := Col;
    Grid.Row := Row;
    ActiveControl := Grid;
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


function TptmMain.MakeModel(Model: TModel): Boolean;
var
  ns, nb, i, j : Integer;
  capacity, active : Integer;

  lamda : real;  //******************************
  func : real;             mju : real;

  delay, sleep : TInterval;
  ins, outs, dir, number_func : Integer;
  Barrier : TBarrier;
begin
  Result := false;                   //******************

  ns := SpinStorages.Value;
  nb := SpinBarriers.Value;

  SetLength(Model.m_Storages, ns);
  SetLength(Model.m_Barriers, nb);
  SetLength(Model.m_Shuffle, nb);

  for i := 1 to ns do begin
    if TakeInteger(GridCapacity, i - 1, 1, capacity) and
       TakeInterval(GridDelay, i - 1, 1, delay) and
       TakeInteger(GridActive, i - 1, 1, active)  and
       (TakeInteger(GridRefuncClone, i -1, 1, number_func))
    then else Exit;

    Model.m_Storages[i - 1] := TStorage.Create(Model, capacity, active, number_func, mju, delay);
  end;

  for i := 1 to nb do begin                                                               //*******************
    if ((TakeReal(GridLamda, i -1, 1, lamda)) and
            (TakeReal(GridFunc, i -1, 1, func))    and
        (not TakeInterval(GridSleep, i - 1, 1, sleep))
       )
    then Exit;

    Barrier := TBarrier.Create(Model, sleep, lamda, func);
    Model.m_Barriers[i - 1] := Barrier;

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

  Result := true;             // showmessage(FloatToStr(func));           //********************
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


procedure TptmMain.MenuModelClick(Sender: TObject);
var
  Model : TModel;    i : integer;
  Sim : TptmSim;
begin

  Model := TModel.Create;

  try
    if MakeModel(Model) and ApplyPriorities(Model) then begin
      Sim := TptmSim.Born(Self, Model);

       {  Randomize;
         with Model do begin                      //*****************************************
           for i := 0 to High(m_Storages) do with m_Storages[i] do begin
                m_mju := Random;
             //  showmessage (FloatToStr (m_mju));
                end; end;        }

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

procedure TptmMain.FuncListChange(Sender: TObject);
begin
    GridRefunc.Cells[ThisCol, ThisRow] := FuncList.Text;
    GridRefuncClone.Cells[ThisCol, ThisRow] := IntToStr(FuncList.ItemIndex);
    
    FuncList.Visible := false;
end;

procedure TptmMain.GridRefuncSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var i, kol_steps : Integer;

begin

     ThisCol := ACol;
     ThisRow := ARow;

     FuncList.Left := GridRefunc.Left + GridRefunc.CellRect(ACol, ARow).Left;

     FuncList.Top  := GridRefunc.Top +  ARow*GridRefunc.RowHeights[ARow] + 5;

     FuncList.Visible := True;
     FuncList.SetFocus;

     
end;

procedure TptmMain.GridRefuncClick(Sender: TObject);
begin
   { if (GridRefunc.ColCount = 1) then
    begin
       FuncList.Left := GridRefunc.Left + 5;
       FuncList.Top  := GridRefunc.Top +  GridRefunc.RowHeights[1] + 5;

       FuncList.Visible := True;
       FuncList.SetFocus;

       ThisCol := 0;
       ThisRow := 1;
    end;
   }
end;


end.
