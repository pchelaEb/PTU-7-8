unit USim;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  Grids, Menus, Math, UEngine;


type
  TSim = class(TForm)
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
  UAmount, UView;


function MomentToStr(Value : TMoment) : string;
begin
  Result := FloatToStrF(Value, ffGeneral, 5, 3);
end;


constructor TSim.Born(AOwner : TComponent; AModel : TModel);
begin
  Model := AModel;
  Model.AllocSchedule;
  inherited Create(AOwner);
  LogState(1);
  LogStatistics;
end;


procedure TSim.FormCreate(Sender: TObject);
var
  n, i : Integer;
  s : string;
begin
  n := Length(Model.m_Storages);
  GridState.ColCount := n + 1;
  GridStorages.ColCount := n + 1;
  GridState.Cells[0, 0] := 'Время';
  GridStorages.Cells[0, 1] := 'Акт.';
  GridStorages.Cells[0, 2] := 'Пас.';
  GridStorages.Cells[0, 3] := 'Макс.';
  GridStorages.Cells[0, 4] := 'Всего';
  GridStorages.Cells[0, 5] := 'Загр.';
  for i := 1 to n do begin
    s := 'P' + IntToStr(i);
    GridState.Cells[i, 0] := s;
    GridStorages.Cells[i, 0] := s;
  end;

  n := Length(Model.m_Barriers);
  GridBarriers.ColCount := n + 1;
  GridBarriers.Cells[0, 1] := 'Срабат.';
  GridBarriers.Cells[0, 2] := 'Запрет.';
  GridBarriers.Cells[0, 3] := 'Сон';
  for i := 1 to n do begin
    s := 'T' + IntToStr(i);
    GridBarriers.Cells[i, 0] := s;
  end;
end;


procedure TSim.LogState(row : Integer);
var
  n, i : Integer;
  Storage : TStorage;
begin
  n := Length(Model.m_Storages);
  GridState.Cells[0, row] := MomentToStr(Model.m_Time);
  for i := 1 to n do begin
    Storage := Model.m_Storages[i - 1];
    GridState.Cells[i, row] :=
      IntToStr(Storage.m_Active) + ':' + IntToStr(Storage.m_Passive);
  end;
end;


procedure TSim.LogStatistics;
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
  end;
  n := Length(Model.m_Barriers);
  GridBarriers.Cells[0, 0] := MomentToStr(Model.m_Time);
  for i := 1 to n do begin
    Barrier := Model.m_Barriers[i - 1];
    GridBarriers.Cells[i, 1] := IntToStr(Barrier.m_Flips);
    GridBarriers.Cells[i, 2] := IntToStr(Barrier.m_Jams);
    GridBarriers.Cells[i, 3] := MomentToStr(Barrier.m_TotalSleep);
  end;
end;


procedure TSim.ButtonStepClick(Sender: TObject);
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


procedure TSim.MenuAmountClick(Sender: TObject);
var
  c, i, p, active, passive : Integer;
  t : TMoment;
  s : string;
  Amount : TAmount;
begin
  c := GridState.Col;
  if not InRange(c, 1, GridState.ColCount - 1) then Exit;

  Amount := TAmount.Create(Self);
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
  Amount.Show;
end;



procedure TSim.ButtonReportClick(Sender: TObject);
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
  View : TView;
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

    View := TView.Create(Self);
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
