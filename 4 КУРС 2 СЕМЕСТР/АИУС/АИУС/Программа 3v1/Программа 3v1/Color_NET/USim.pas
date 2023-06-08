unit USim;

interface

uses
	SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
	Grids, Menus, Math, UEngine, CheckLst;

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
    ColorList: TCheckListBox;
    Label4: TLabel;
	procedure ButtonStepClick(Sender: TObject);
	procedure FormCreate(Sender: TObject);
	procedure MenuAmountClick(Sender: TObject);
	procedure ButtonReportClick(Sender: TObject);
    procedure ColorListClickCheck(Sender: TObject);
public
	Model : Array [1..9] of TModel;

	//Хранение статистики:
	//	Измерения:
	//		1) цвет модели
	//		2) номер перехода/точки
	//		3) время модели
	//		3) активные/пассивные фишки
    //	Данные:
	//		первые 5 строк - статистика по точкам,
	//		следующие 3 - статистика по переходам,
	//		хвост - сотояние моделей во времени.

	DataArray : array [1..9, 1..9, 1..10000, 1..2] of string[8];

	constructor Born(AOwner : TComponent; AModel : Array of TModel);
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


Constructor TSim.Born(AOwner : TComponent; AModel : Array of TModel);
Var
    I : Integer;
begin
	For i := 0 to High(AModel) Do //1, а не 0 !!!
	Begin
		Model[i+1] := AModel[i];
		If Model[i+1] <> Nil Then
		Begin
			Model[i+1].AllocSchedule;
		End;
	end;
	inherited Create(AOwner);
	LogState(1);
	LogStatistics;
end;


procedure TSim.FormCreate(Sender: TObject);
var
	n, i : Integer;
	s : string;
begin
	ColorList.Items.BeginUpdate;
	For i := 1 to High(Model) Do
	Begin
		If Model[i] <> Nil Then
		Begin
			ColorList.Items.Append(Model[i].Color);
			ColorList.Checked[ColorList.Items.IndexOf(Model[i].Color)] := True;
		End;
    End;
	ColorList.Items.EndUpdate;

	n := Length(Model[1].m_Storages);
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

	n := Length(Model[1].m_Barriers);
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
	n, i, j : Integer;
	Storage : TStorage;
	SB, SE : Array [1..9] of String;
begin
	n := 1;
	For j:=1 To High(Model) Do
	If Model[j] <> Nil Then
	Begin
		n := Length(Model[j].m_Storages);
		GridState.Cells[0, row] := MomentToStr(Model[j].m_Time);
		for i := 1 to n do begin
			Storage := Model[j].m_Storages[i - 1];

			// Сохраняем статистику по всем цветам !!!
			DataArray[j, i, Row + 8, 1] := IntToStr(Storage.m_Active);
			DataArray[j, i, Row + 8, 2] := IntToStr(Storage.m_Passive);

			//Sirin: Смотрим где флажки :)
            If (ColorList.Items.IndexOf(Model[j].Color) >= 0) or
			(Model[j].m_Time = 0) Then //Sirin: Упс, форма не отрисована !!!
            //Sirin: Если в опциях компилятора стоит обработка boolean полностью - выпадет с ошибкой
            If (Model[j].m_Time = 0) Or (ColorList.Checked[ColorList.Items.IndexOf(Model[j].Color)]) Then
			Begin
				SB[i] := SB[i] + IntToStr(Storage.m_Active) + Model[j].Color;
				SE[i] := SE[i] + IntToStr(Storage.m_Passive) + Model[j].Color;
			End;
		end;
	end;

	For i:=1 to n Do
	Begin
		GridState.Cells[i, row] := SB[i] + ':' + SE[i];
	End;
End;


procedure TSim.LogStatistics; //Вывод статистики по точкам и переходам
var
	n, i, j : Integer;
	Storage : TStorage;
	Barrier : TBarrier;
begin
	For J := 1 To High(Model) Do
    If Model[J] <> Nil Then
    Begin
		n := Length(Model[j].m_Storages);
		//Sirin: Таймер по первой модели !!! По другому не сделать :(
		GridStorages.Cells[0, 0] := MomentToStr(Model[1].m_Time);
		for i := 1 to n do
		begin
			Storage := Model[1].m_Storages[i - 1];

			DataArray[j, i, 1, 1] :=  IntToStr(Storage.m_Active);
			DataArray[j, i, 2, 1] := IntToStr(Storage.m_Passive);
			DataArray[j, i, 3, 1] := IntToStr(Storage.m_Maximum);
			DataArray[j, i, 4, 1] := IntToStr(Storage.m_Total);
			DataArray[j, i, 5, 1] := FloatToStrF(Storage.CalcUsage, ffFixed, 1, 3);

            If Model[j].Color = 'a' Then
			Begin //Обнуление статистики точек
				GridStorages.Cells[i, 1] := '';
				GridStorages.Cells[i, 2] := '';
				GridStorages.Cells[i, 3] := '';
				GridStorages.Cells[i, 4] := '';
				GridStorages.Cells[i, 5] := '';
			End;
            If (Model[j].m_Time = 0) Or (ColorList.Checked[ColorList.Items.IndexOf(Model[j].Color)]) Then
			Begin //Заполняем статистику точек по отмеченным моделям
				GridStorages.Cells[i, 1] := GridStorages.Cells[i, 1] + IntToStr(Storage.m_Active) + Model[j].Color;
				GridStorages.Cells[i, 2] := GridStorages.Cells[i, 2] + IntToStr(Storage.m_Passive) + Model[j].Color;
				GridStorages.Cells[i, 3] := GridStorages.Cells[i, 3] + IntToStr(Storage.m_Maximum) + Model[j].Color;
				GridStorages.Cells[i, 4] := GridStorages.Cells[i, 4] + IntToStr(Storage.m_Total) + Model[j].Color;
				GridStorages.Cells[i, 5] := GridStorages.Cells[i, 5] + FloatToStrF(Storage.CalcUsage, ffFixed, 1, 3) + Model[j].Color;
			End;
		end;

        //Sirin: А со статитикой переходов - жопа полная :(
        //Проблема в том, что нельзя проверить, что именно эти счетчики считают в разрезе моделей
		n := Length(Model[1].m_Barriers);
		GridBarriers.Cells[0, 0] := MomentToStr(Model[1].m_Time);
		for i := 1 to n do
        begin
			Barrier := Model[j].m_Barriers[i - 1];

			DataArray[j, i, 6, 1] := IntToStr(Barrier.m_Flips);
			DataArray[j, i, 7, 1] := IntToStr(Barrier.m_Jams);
			DataArray[j, i, 8, 1] := MomentToStr(Barrier.m_TotalSleep);

			If Model[j].Color = 'a' Then
			Begin // Обнуляем ячейки
				GridBarriers.Cells[i, 1] := '';
				GridBarriers.Cells[i, 2] := '';
				GridBarriers.Cells[i, 3] := '';
			End;
			If Barrier <> Nil Then
			Begin
	            If (Model[j].m_Time = 0) Or (ColorList.Checked[ColorList.Items.IndexOf(Model[j].Color)]) Then
				Begin // Заполняем ячейки
					GridBarriers.Cells[i, 1] := GridBarriers.Cells[i, 1] + IntToStr(Barrier.m_Flips) + Model[j].Color;
					GridBarriers.Cells[i, 2] := GridBarriers.Cells[i, 2] + IntToStr(Barrier.m_Jams) + Model[j].Color;
					GridBarriers.Cells[i, 3] := GridBarriers.Cells[i, 3] + MomentToStr(Barrier.m_TotalSleep) + Model[j].Color;
				End;
			end;
		end;
	end;

end;


procedure TSim.ButtonStepClick(Sender: TObject);
var
	batch, prev, step, i : Integer;
begin
	//Есть косяк в первом шаге - сбой счетчика.

	batch := (Sender As TComponent).Tag;
	prev := GridState.RowCount;

	GridState.RowCount := prev + batch;

	For step := 1 To batch Do
	Begin
		For i := 1 to High(Model) Do
		If Model[i] <> Nil Then
		Begin
			Model[i].Step;
            //Sirin: Счетчик глючит на первом шаге. Прничина неизвестна.
            //If Model[i].M_Time = 0 Then	Model[i].M_Time := 1;
		End;
		LogState(prev - 1 + step);
		GridState.Row := GridState.RowCount - 1;
	End;
	LogStatistics;
End;


procedure TSim.MenuAmountClick(Sender: TObject);
var
	c, i, j, n, p, active, passive : Integer;
	t : TMoment;
	s : string;
	Amount : TAmount;
    M : TModel;
begin
	c := GridState.Col;
	if not InRange(c, 1, GridState.ColCount - 1) then Exit;

	n := 0;
	M := Nil;

	Amount := TAmount.Create(Self);
	Amount.Caption := 'Загруженность ' + GridState.Cells[c, 0];
   	For j := 1 To High(Model) Do
	If Model[j] <> Nil Then
	If (ColorList.Checked[ColorList.Items.IndexOf(Model[j].Color)]) Then
	Begin
		for i := 1 to GridState.RowCount - 1 do
		begin
			If M <> Model[j] Then
			Begin
				N := n + 1;
                m := Model[j];
			End;
			t := StrToFloat(GridState.Cells[0, i]);
			active := StrToInt(DataArray[j, c, i + 8, 1]);
			passive := StrToInt(DataArray[j, c, i + 8, 2]);
        	If n = 1 Then
            Begin
				Amount.Series1.AddXY(t, active + passive + 0.02);
				Amount.Series2.AddXY(t, passive + 0.02);
				Amount.Series3.AddXY(t, active + 0.02);
				Amount.Label1.Caption := 'Цвет ' + Model[j].Color;
            End;
        	If n = 2 Then
            Begin
				Amount.Series4.AddXY(t, active + passive - 0.02);
				Amount.Series5.AddXY(t, passive - 0.02);
				Amount.Series6.AddXY(t, active - 0.02);
				Amount.Label2.Caption := 'Цвет ' + Model[j].Color;
            End;
          If n = 3 Then
            Begin
				Amount.Series7.AddXY(t, active + passive - 0.02);
				Amount.Series8.AddXY(t, passive - 0.02);
				Amount.Series9.AddXY(t, active - 0.02);
				Amount.Label9.Caption := 'Цвет ' + Model[j].Color;
            End;
        End;
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
		for r := 0 to Grid.RowCount - 1 do
		begin
			for c := 0 to Grid.ColCount - 1 do
			begin
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


procedure TSim.ColorListClickCheck(Sender: TObject);
Var
	i, j, n, m, NumberOfModels, NumberOfSteps, NumberOfStorages : integer;
begin
	NumberOfModels := 0;
	For j := 1 To High(Model) Do
	If Model[j] <> Nil Then NumberOfModels := NumberOfModels + 1;
	NumberOfSteps := Trunc(Model[1].M_Time) + 2;
	NumberOfStorages := Trunc(Length(Model[1].m_Storages));

	For j := 1 To High(Model) Do

	If Model[j] <> Nil Then
	Begin
		n := Length(Model[j].m_Storages);
		For i := 1 To n Do
		Begin
        	If J = 1 Then
			Begin
				For m := 1 To 5 Do
				Begin
					GridStorages.Cells[i, m] := '';
				End;
				For m := 1 To 3 Do
				Begin
					GridBarriers.Cells[i, m] := '';
				End;
			End;

			If (Model[j].m_Time = 0) Or (ColorList.Checked[ColorList.Items.IndexOf(Model[j].Color)]) Then
			Begin //Заполняем статистику точек по отмеченным моделям
			For m := 1 To 5 Do
				Begin
					GridStorages.Cells[i, m] := GridStorages.Cells[i, m] + DataArray[j, i, m, 1] + Model[j].Color;
				End;
				For m := 1 To 3 Do
				Begin
					GridBarriers.Cells[i, m] := GridBarriers.Cells[i, m] + DataArray[j, i, m + 5, 1] + Model[j].Color;
                End;
            End;
		End;
	End;

	// Вывод статистики фишек.
	For i := 1 To NumberOfSteps Do // Строки
	Begin
 		For m := 1 To NumberOfStorages Do GridState.Cells[m, i] := '';
		For n := 1 To 2 Do // Активные/пассивные
		For m := 1 To NumberOfStorages Do // Точки
		Begin
			For j := 1 To NumberOfModels Do // Модели
			Begin
				If (ColorList.Checked[ColorList.Items.IndexOf(Model[j].Color)]) Then
				GridState.Cells[m, i] := GridState.Cells[m, i] + DataArray[j, m, i + 8, n] + Model[j].Color;
			End;
			If n = 1 Then GridState.Cells[m, i] := GridState.Cells[m, i] + ':';
		End;
	End;
end;

end. //Это конец
