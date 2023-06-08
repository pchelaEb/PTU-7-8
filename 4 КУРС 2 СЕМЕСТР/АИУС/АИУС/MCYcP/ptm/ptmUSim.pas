unit ptmUSim;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  Grids, Menus, Math, ptmUEngine;


type
  TptmSim = class(TForm)
    PanelTop: TPanel;
    GridState: TStringGrid;
    Button100: TButton;
    Button10: TButton;
    Button1: TButton;
    PanelBottom: TPanel;
    GridBarriers: TStringGrid;
    GridStorages: TStringGrid;
    PopupAmount: TPopupMenu;
    MenuAmount: TMenuItem;
    ButtonReport: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure ButtonStepClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuAmountClick(Sender: TObject);
    procedure ButtonReportClick(Sender: TObject);
  public
    Model : TModel;
    constructor Born(AOwner : TComponent; AModel : TModel);
    procedure LogState(row : Integer);
    procedure LogStatistics;
  end;


implementation

{$R *.dfm}

uses
  ptmUAmount, ptmUView;


function MomentToStr(Value : TMoment) : string;
begin
  Result := FloatToStrF(Value, ffGeneral, 5, 3);
end;


constructor TptmSim.Born(AOwner : TComponent; AModel : TModel);
begin
  Model := AModel;
  Model.AllocSchedule;
  inherited Create(AOwner);
  LogState(1);
  LogStatistics;
end;


procedure TptmSim.FormCreate(Sender: TObject);
var
  n, i : Integer;
  s : string;
begin
  n := Length(Model.m_Storages);
  GridState.ColCount := 2*n + 1;
  GridStorages.ColCount := n + 1;
  GridState.Cells[0, 0] := 'Время';
  GridStorages.Cells[0, 1] := 'Акт.';
  GridStorages.Cells[0, 2] := 'Пас.';
  GridStorages.Cells[0, 3] := 'Макс.';
  GridStorages.Cells[0, 4] := 'Всего';
  GridStorages.Cells[0, 5] := 'Загр.';
  GridStorages.Cells[0, 6] := 'Знач. ' + #181 ;                //****************************

  for i := 1 to n do begin
    s := 'P' + IntToStr(i);
    GridState.Cells[2*i-1, 0] := s;
    GridStorages.Cells[i, 0] := s;
    s := #181 + IntToStr(i);
    GridState.Cells[2*i, 0] := s;
  end;

  n := Length(Model.m_Barriers);
  GridBarriers.ColCount := n + 1;
  GridBarriers.Cells[0, 1] := 'Срабат.';
  GridBarriers.Cells[0, 2] := 'Запрет.';
  GridBarriers.Cells[0, 3] := 'Сон';
  GridBarriers.Cells[0, 4] := 'Знач.лямбда';             //***************************

  for i := 1 to n do begin
    s := 'T' + IntToStr(i);
    GridBarriers.Cells[i, 0] := s;
  end;
end;


procedure TptmSim.LogState(row : Integer);
var
  n, i : Integer;
  Storage : TStorage;
begin
  n := Length(Model.m_Storages);
  GridState.Cells[0, row] := MomentToStr(Model.m_Time);
  for i := 1 to n do begin
    Storage := Model.m_Storages[i - 1];
    GridState.Cells[2*i-1, row] :=
      IntToStr(Storage.m_Active) + ':' + IntToStr(Storage.m_Passive);

    GridState.Cells[2*i, row] := FloatToStrF(Storage.m_mju, ffFixed, 5, 5);        //********************************

  end;
end;


procedure TptmSim.LogStatistics;
var
  n, i : Integer;
  Storage : TStorage;
  Barrier : TBarrier;
begin
  n := Length(Model.m_Storages);
  GridStorages.Cells[0, 0] := MomentToStr(Model.m_Time);
  for i := 1 to n do begin
    Storage := Model.m_Storages[i - 1];
    GridStorages.Cells[i, 1] := IntToStr(Storage.m_Active);
    GridStorages.Cells[i, 2] := IntToStr(Storage.m_Passive);
    GridStorages.Cells[i, 3] := IntToStr(Storage.m_Maximum);
    GridStorages.Cells[i, 4] := IntToStr(Storage.m_Total);
    GridStorages.Cells[i, 5] := FloatToStrF(Storage.CalcUsage, ffFixed, 1, 3);
    GridStorages.Cells[i, 6] := FloatToStrF(Storage.m_mju, ffFixed, 5, 5);            //***********************************

  end;
  n := Length(Model.m_Barriers);
  GridBarriers.Cells[0, 0] := MomentToStr(Model.m_Time);
  for i := 1 to n do begin
    Barrier := Model.m_Barriers[i - 1];
    GridBarriers.Cells[i, 1] := IntToStr(Barrier.m_Flips);
    GridBarriers.Cells[i, 2] := IntToStr(Barrier.m_Jams);
    GridBarriers.Cells[i, 3] := MomentToStr(Barrier.m_TotalSleep);
    GridBarriers.Cells[i, 4] := FloatToStrF(Barrier.m_Lamda, ffFixed, 5, 5);     //*********************************
  end;
end;


procedure TptmSim.ButtonStepClick(Sender: TObject);
var
  batch, prev, step : Integer;
begin
  batch := (Sender as TComponent).Tag;
  prev := GridState.RowCount;
  GridState.RowCount := prev + batch;
  for step := 1 to batch do begin
    Model.Step;
    LogState(prev - 1 + step);
  end;
  GridState.Row := GridState.RowCount - 1;
  LogStatistics;
end;


procedure TptmSim.MenuAmountClick(Sender: TObject);
var
  c, i, p, active, passive : Integer;    znach : real;
  t : TMoment;
  s : string;
  Amount : TptmAmount;
begin
  c := GridState.Col;
  if not InRange(c, 1, GridState.ColCount - 1) then Exit;

if c mod 2 = 1 then begin                     //****************************************
  Amount := TptmAmount.Create(Self);
  Amount.Caption := 'Загруженность ' + GridState.Cells[c, 0];
  for i := 1 to GridState.RowCount - 1 do begin
    t := StrToFloat(GridState.Cells[0, i]);
    s := GridState.Cells[c, i];
    p := Pos(':', s);
    active := StrToInt(Copy(s, 1, p - 1));
    passive := StrToInt(Copy(s, p + 1, Length(s) - p));
    Amount.SeriesActive.AddXY(t, active);
    Amount.SeriesPassive.AddXY(t, passive);
    Amount.SeriesTotal.AddXY(t, active + passive);
  end;
end;

if c mod 2 = 0 then begin                     //****************************************
  Amount := TptmAmount.Create(Self);
  Amount.Caption := 'Значение функции принадлежности ' + GridState.Cells[c, 0];
  for i := 1 to GridState.RowCount - 1 do begin
    t := StrToFloat(GridState.Cells[0, i]);
    s := GridState.Cells[c, i];
  //  p := Pos(':', s);
 //   active := StrToInt(Copy(s, 1, p - 1));
 //   passive := StrToInt(Copy(s, p + 1, Length(s) - p));
 //   Amount.SeriesActive.AddXY(t, active);
    znach := StrToFloat(s);
    Amount.SeriesPassive.AddXY(t, znach);
 //   Amount.SeriesTotal.AddXY(t, active + passive);
  end;
end;

  Amount.Show;
end;



procedure TptmSim.ButtonReportClick(Sender: TObject);
var
  Stream : TMemoryStream;

  procedure Log(const s : string);
  begin
    if Length(s) > 0 then Stream.WriteBuffer(s[1], Length(s));
  end;

  procedure LogGrid(Grid : TStringGrid);
  var
    r, c : Integer;
  begin
    for r := 0 to Grid.RowCount - 1 do begin
      for c := 0 to Grid.ColCount - 1 do begin
        if c > 0 then Log(#9);
        Log(Grid.Cells[c, r]+'');
      end;
      Log(#13#10);
    end;
  end;

var
  View : TptmView;
begin
  Stream := TMemoryStream.Create;
  Stream.SetSize(32768);
  try
    Log('Движение меток в сети:');
    Log(#13#10#13#10);
    LogGrid(GridState);
    Log(#13#10#13#10);
    Log('Статистика по позициям:');
    Log(#13#10#13#10);
    LogGrid(GridStorages);
    Log(#13#10#13#10);
    Log('Статистика по переходам:');
    Log(#13#10#13#10);
    LogGrid(GridBarriers);

    Stream.Size := Stream.Position;
    Stream.Position := 0;

    View := TptmView.Create(Self);
    try
      View.Memo.Lines.LoadFromStream(Stream);
      View.ShowModal;
    finally
      FreeAndNil(View);
    end;
  finally
    FreeAndNil(Stream);
  end;
end;



end.
