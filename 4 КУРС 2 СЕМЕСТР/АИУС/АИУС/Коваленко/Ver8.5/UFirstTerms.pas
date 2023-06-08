unit UFirstTerms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ClassModule, Spin, ExtCtrls, Grids, Buttons, UCore,
  UKnowledge, Unit1, UData;

type
  TFirstTerms = class(TForm)
    GridData: TStringGrid;
    GridImit: TStringGrid;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Shag: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    GridPosition: TStringGrid;
    GridPerexod: TStringGrid;
    ModelButton: TBitBtn;
    Timelife: TSpinEdit;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ModelButtonClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Model: TModel;
  	DataArray: array [ 1..1000, 1..10000, 1..2] of string[8];
    //procedure LogState(row: Integer);
    //procedure LogStatistics;
    constructor Born(AOwner: TComponent; AModel:  TModel);

  end;

type
Packet = record
    num, prioritet, pause, jitter, losts: Integer
  end;

var
  FirstTerms: TFirstTerms;

implementation

{$R *.dfm}
uses
   UMain, Math;

Constructor TFirstTerms.Born(AOwner : TComponent; AModel :  TModel);
begin
		Model:= AModel;
  inherited Create(AOwner);
 	//LogState(1);
 	//LogStatistics;

end;


procedure TFirstTerms.FormCreate(Sender: TObject);
var
	i, n: Integer;
	s: string;
begin
  //n := Length(Model.mPosition);
	//GridImit.ColCount := n + 1;
	//GridPosition.ColCount := n + 1;
  n := total_s;
  GridImit.ColCount := n + 1;
  GridPosition.ColCount := n + 1;

	GridData.Cells[0, 0] := '№ пакета';
  GridData.Cells[1, 0] := 'Приоритет';
  GridData.Cells[2, 0] := 'Задержка, мс';
  GridData.Cells[3, 0] := 'Джиттер, мс';
  GridData.Cells[4, 0] := 'Потери, %';

	GridPosition.Cells[0, 1] := 'Положит';
	GridPosition.Cells[0, 2] := 'Отрицат.';
	GridPosition.Cells[0, 3] := 'Макс.';
	GridPosition.Cells[0, 4] := 'Всего было меток ';

  for i := 1 to 99 do begin
   	GridPosition.Cells[i, 1] := '';
    GridPosition.Cells[i, 2] := '';
    GridPosition.Cells[i, 3] := '';
    GridPosition.Cells[i, 4] := '';
  end;

end;


{*
procedure TFirstTerms.LogStatistics; //Вывод статистики по точкам и переходам
var
	n, i, j : Integer;
	Posizia : TPosizia;
	Perexod : TPerexod;
begin

		n := Length(Model.mPosition);
		GridPosition.Cells[0, 0] := 'Время: '+IntToStr(Shag.Value);
		for i := 1 to n do
		begin
			Posizia := Model.mPosition[i - 1];
       	GridPosition.Cells[i, 1] := '';
			 	GridPosition.Cells[i, 2] := '';
				GridPosition.Cells[i, 3] := '';
				GridPosition.Cells[i, 4] := '';

       	GridPosition.Cells[i, 1] := IntToStr(Posizia.pPositive);
				GridPosition.Cells[i, 2] := IntToStr(Posizia.pNegative);
		 	  GridPosition.Cells[i, 3] := IntToStr(Posizia.pMaximum);
			 	GridPosition.Cells[i, 4] := IntToStr(Posizia.pTotal);

       end;
    end;
*}

procedure TFirstTerms.ModelButtonClick(Sender: TObject);
var
   i, j, k, metki_plus, sum,//sum0, sum1, sum2,
   num_kriterii, batch, prev, step1: Integer;
   res, razn: Integer;
 //LookupRes: Variant;

begin

  for i := 1 to 100 do
  begin
  GridData.Cells[0, i] := IntToStr(i); // № пакета
  GridData.Cells[1, i] := IntToStr(RandomRange(1, 5)); // приоритет
  GridData.Cells[2, i] := IntToStr(RandomRange(80, 120)); // задержка
  GridData.Cells[3, i] := IntToStr(RandomRange(120, 170)); // джиттер
  GridData.Cells[4, i] := IntToStr(RandomRange(0, 7)); // потери
  end;
  
  batch := Shag.Value;
  num_kriterii := ComboBox1.ItemIndex;   // номер критерия 0..2

  Q:= Timelife.Value;
  FormMain.Timelife.Value := Q;
  prev := GridImit.RowCount;
  GridImit.RowCount := prev + batch;

  if num_kriterii = 0 then       // задержка
  begin
  i := 1;
  //sum0 := 0;
  sum := 0; res := 0;
  for i := 1 to 100 do
  begin
   if StrToInt(GridData.Cells[2, i]) <= 100 then
   sum := sum + 1;
  end;
   razn := sum-(100-sum);
   res := razn;   //в процентах
  Showmessage('По критерию "задержка" успешно прошло пакетов: '+IntToStr(sum)+';'+chr(013)+'Суммарный потенциал равен '+IntToStr(res));
  end;

  if num_kriterii = 1 then       // джиттер
  begin
  i := 1;
  sum := 0; res := 0;
  for i := 1 to 100 do
  begin
   if StrToInt(GridData.Cells[3, i]) <= 150 then
   sum := sum + 1;
  end;
   razn := sum-(100-sum);
   res := razn;
  //Showmessage('По критерию "джиттер" успешно прошло пакетов: '+IntToStr(sum)+';'+chr(013)+'Суммарный потенциал равен '+IntToStr(res));
    Showmessage('По критерию "джиттер" успешно прошло пакетов: '+IntToStr(sum)+';'+chr(013)+'Суммарный потенциал равен '+IntToStr(res)+chr(013)+'Альтернатива: Деление пакетов');

  end;


  if num_kriterii = 2 then       // потери
  begin
  i := 1;
  sum := 0; res := 0;
  for i := 1 to 100 do
  begin
   if StrToInt(GridData.Cells[4, i]) = 0 then
   sum := sum + 1;
   //Edit3.Text := IntToStr(sum);
  end;

  razn := sum-(100-sum);
  //res := (razn/100)*100%;
  res := razn;
  Showmessage('По критерию "потери" успешно прошло пакетов: '+IntToStr(sum)+';'+chr(013)+'Суммарный потенциал равен '+IntToStr(res));
  //Showmessage('Системе неизвестно, как действовать в данной ситуации.'+chr(013)+'Запросить помощь эксперта?');

  end;

// по значению sum смотрим, имеется ли уже такая ситуация в базе фактов

//DataModule1.TFacts.Append;
//DataModule1.TFacts.Fields[2].AsString:=Edit1.Text;
//DataModule1.TFacts.Post;

{*
  for i := 1 to DataModule1.TFacts.RecordCount do
  begin
    if total_sum = DataModule1.TFactssum_func.Value then
    ShowMessage('Такая ситуация уже встречалась');
  end;

*}

 for step1 := 1 to batch do
	begin
   //Model.Step;
   if Tupik=true then Halt;
   //LogState(prev - 1 + step1);
   //Model.Udalenie;
	 GridImit.Row := GridImit.RowCount - 1;
	end;
	//LogStatistics;

  end;

end.
