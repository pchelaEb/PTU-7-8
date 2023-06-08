unit UData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls,  Spin, Menus, Math, ClassModule, ExtCtrls,
  ComCtrls, UCore;
const
  stroka1='0123456789<>=ab+-';
type
  TFormMain = class(TForm)
    KolPos: TSpinEdit;
    KolPer: TSpinEdit;
    LabelPos: TLabel;
    LabelPer: TLabel;
    GridInzid: TStringGrid;
    LabelInzid: TLabel;
    LabelMark: TLabel;
    GridMark: TStringGrid;
    LabelTime: TLabel;
    LabelUsl: TLabel;
    GridUsl: TStringGrid;
    Timelife: TSpinEdit;
    LabelPrior: TLabel;
    GridPrior: TStringGrid;
    MainMenu1: TMainMenu;
    OpenMenu: TMenuItem;
    CreateMenu: TMenuItem;
    SaveMenu: TMenuItem;
    QuitMenu: TMenuItem;
    SpravkaMenu: TMenuItem;
    HelpMenu: TMenuItem;
    AboutMenu: TMenuItem;
    FileMenu: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    GridMaxVolume: TStringGrid;
    Label1: TLabel;
    ModelMenu: TMenuItem;
    ButtonUravn: TButton;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    GridIngib: TStringGrid;
 
    procedure KolPosChange(Sender: TObject);
    procedure KolPerChange(Sender: TObject);
    procedure TimelifeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PanelHint(Sender: TObject);
  	procedure FormMainCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure QuitMenuClick(Sender: TObject);
    procedure CreateMenuClick(Sender: TObject);
    procedure OpenMenuClick(Sender: TObject);
    procedure SaveMenuClick(Sender: TObject);
    procedure ModelMenuClick(Sender: TObject);
    //procedure AboutMenuClick(Sender: TObject);
    //procedure HelpMenuClick(Sender: TObject);
    procedure ButtonUravnClick(Sender: TObject);
 private
  	//procedure ClearTables;
    function TakeInteger(Grid: TStringGrid; Col, Row: Integer; out Value1, Value2: Integer): Boolean;
    function TakeIntegerC(Grid: TStringGrid;  Color:string; Col, Row: Integer;  out Value1, Value2: Integer;var y1,y2: Integer): Boolean;
    function MakeModel(Model: TModel): Boolean;
    function ApplyPriorities(Model: TModel): Boolean;

  end;
type TMassive=array of array of Real;
     
var
  FormMain: TFormMain;
  Q : Integer;
  x, w : Integer;
  K1, K2 : TMassive;
  Tupik : boolean;
  M : array of Integer;


implementation

{$R *.dfm}

uses
 //Simulation,Helps,Abouts, Uravn;
 UFirstTerms, Uravn;

procedure TFormMain.FormCreate(Sender: TObject);
var j: Integer;
begin
  for  j:=0 to Length(Uravn.Eq) do
  Uravn.Eq[j]:=0;
  KolPosChange(nil);
  KolPerChange(nil);
  TimelifeChange(nil);
  Application.OnHint:=PanelHint;
//   StatusBar1.Panels[0].Text:='Помощь';
end;

procedure TFormMain.PanelHint(Sender: TObject);
begin
 StatusBar1.Panels[0].Text:=Application.Hint;
end;

{*
procedure TFormMain.ClearTables;
var
  o, j : Integer;
begin
 for  j:=0 to Length(Uravn.Eq) do
  Uravn.Eq[j]:=0;
  GridUsl.Rows[1].Clear;
  GridMark.Rows[1].Clear;
  GridPrior.Rows[1].Clear;
  GridMaxVolume.Rows[1].Clear;
  for o := 1 to GridInzid.RowCount do GridInzid.Rows[o].Clear;
  for o := 1 to GridIngib.RowCount do GridIngib.Rows[o].Clear;
end;
*}

procedure TFormMain.FormMainCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('Вы действительно хотите выйти из программы?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;


procedure TFormMain.KolPosChange(Sender: TObject);
var
  n, i : Integer;
  s : string;
begin
  n := KolPos.Value;
  GridMark.ColCount := n;
  GridInzid.RowCount := n + 1;
  GridIngib.RowCount := n + 1;
  GridMaxVolume.ColCount:= n;
  GridUsl.ColCount:= n;
  for i := 1 to n do begin
    s := 'P' + IntToStr(i);
    GridMark.Cells[i - 1, 0] := s;
    GridInzid.Cells[0, i] := s;
    GridIngib.Cells[0, i] := s;
    GridMaxVolume.Cells[i - 1, 0] := s;
    GridUsl.Cells[i - 1, 0] := s;
    end;
end;

procedure TFormMain.KolPerChange(Sender: TObject);
var
  n, i : Integer;
  s : string;
begin
  n := KolPer.Value;

  GridPrior.ColCount := n;
  GridInzid.ColCount := n + 1;
  GridIngib.ColCount := n + 1;
  for i := 1 to n do begin
    s := 'T' + IntToStr(i);
    GridPrior.Cells[i - 1, 0] := s;
    GridInzid.Cells[i, 0] := s;
    GridIngib.Cells[i, 0] := s;
  end;
end;

procedure TFormMain.TimelifeChange(Sender: TObject);
begin
 Q:= Timelife.Value;
end;



procedure TFormMain.QuitMenuClick(Sender: TObject);
begin
Close;
end;

procedure TFormMain.CreateMenuClick(Sender: TObject);
begin
  if MessageDlg('Очистить сеть?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    //ClearTables;
    KolPos.Value := 1;
    KolPer.Value := 1;
    Timelife.Value := 1;
  end;
end;


procedure TFormMain.OpenMenuClick(Sender: TObject);
var
  Reader : TextFile;
  npos, nper, ntime, i, j : Integer;
  s : string;
begin
  //for  j:=0 to Length(Uravn.Eq) do
  //Uravn.Eq[j]:=0;
  if not OpenDialog1.Execute then Exit;
  AssignFile(Reader, OpenDialog1.FileName);
  Reset(Reader);
  try
    ReadLn(Reader, npos, nper, ntime);
    KolPos.Value := npos;
    KolPer.Value := nper;
    Timelife.Value := ntime;

    for i := 1 to npos do begin
      ReadLn(Reader, s);  GridMark.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridUsl.Cells[i - 1, 1] := s;
      ReadLn(Reader, s);  GridMaxVolume.Cells[i - 1, 1] := s;
    end;

    for i := 1 to nper do begin
      ReadLn(Reader, s);  GridPrior.Cells[i - 1, 1] := s;
    end;

    for i := 1 to npos do begin
      for j := 1 to nper do begin
        ReadLn(Reader, s);  GridInzid.Cells[j, i] := s;
      end;
    end;
  finally
    CloseFile(Reader);
  end;
end;


procedure TFormMain.SaveMenuClick(Sender: TObject);
var
  Writer : TextFile;
  npos, nper, i, j : Integer;
begin
  SaveDialog1.FileName := OpenDialog1.FileName;
  if not SaveDialog1.Execute then Exit;
  AssignFile(Writer, SaveDialog1.FileName);
  Rewrite(Writer);
  try
    npos := KolPos.Value;
    nper := KolPer.Value;
    WriteLn(Writer, npos, ' ', nper, ' ', Timelife.Value);

    for i := 1 to npos do begin
      WriteLn(Writer, GridMark.Cells[i - 1, 1]);
      WriteLn(Writer, GridUsl.Cells[i - 1, 1]);
      WriteLn(Writer, GridMaxVolume.Cells[i - 1, 1]);
    end;

    for i := 1 to nper do begin
      WriteLn(Writer, GridPrior.Cells[i - 1, 1]);
    end;

    for i := 1 to npos do begin
      for j := 1 to nper do begin
        WriteLn(Writer, GridInzid.Cells[j, i]);
        WriteLn(Writer, GridIngib.Cells[j, i]);
      end;
    end;

    WriteLn(Writer, '<EOF>');
  finally
    CloseFile(Writer);
  end;
end;


function TFormMain.TakeInteger(Grid: TStringGrid; Col, Row: Integer; out Value1, Value2: Integer): Boolean;
var
  e, i : Integer;
  s : string;
begin
 // Result := false;
  s := Grid.Cells[Col, Row];
  e:=0;
  if s = '' then   s := '0';
  Val(s, Value1, e);
  Value2 := 0;

    For i := 1 to Length(S) do begin
        If ((s[i] = '1') and (i>=2) and (s[i-1]='-') and  ((s[i+1]='+')or (s[i+1]=''))) then
        Begin
         Value2:=1; Value1:=0; Result:=  (e = 0); Exit;
        end;
    end;
  Result :=  (e = 0);
  if not Result then begin
    Grid.Col := Col;
    Grid.Row := Row;
    ActiveControl := Grid;
  end;
end;

function TFormMain.TakeIntegerC(Grid: TStringGrid;  Color:string; Col, Row: Integer;  out Value1, Value2: Integer;var y1,y2: Integer): Boolean;
var
  e,zz, zz1 : Integer;
  s,ss,s11 : string;
  i, j : Integer;
begin
 // Result:=false;
  y1:=0;y2:=0; zz:=0;
  s := Grid.Cells[Col, Row]; zz1:=0;
  for i:=1 to  Length(s) do begin
  if ((s[i]='a') or (s[i]='b')) then zz:=1;
  if ((s[i]='.') or ((Grid=GridIngib) and ((s[i]='+') or (s[i]='-')))) then begin
   ShowMessage('Дробные значения количества меток не допускается');
   Grid.Col := Col;
   Grid.Row := Row;
   ActiveControl := Grid;
   result:=false;
   Exit;
  end; zz1:=0;
  for j:=1 to Length(stroka1) do
  if (s[i]=stroka1[j]) then  zz1:=1;
   if ((zz1=0)) then begin
   ShowMessage('Недопустимый символ');
   Grid.Col := Col;
   Grid.Row := Row;
   ActiveControl := Grid;
   result:=false;
   Exit;
  end;
  end;
  if ((zz=0) and (s<>'') and (s<>'-1')) then begin
   ShowMessage('Не указан цвет меток!');
   Grid.Col := Col;
   Grid.Row := Row;
   ActiveControl := Grid;
   result:=false;
   Exit;
  end;

  if s = '' then s := '0';
  e := 0;
    Value1 := 0; Value2 := 0;  
  For i:=1 to Length(s) do begin
    If s[i] = Color[1] Then
        Begin
         zz:=0;
         for j:=1 to Length(stroka1) do
          if (s[i-1]=stroka1[j]) then  zz:=1;
           if zz=0 then begin
            ShowMessage('Введите количество положительных меток в матрице перед обозначением - "а"');
            Grid.Col := Col;
            Grid.Row := Row;
            ActiveControl := Grid;
            result:=false;
            Exit;
           end;
           e := 1; ss:='';
           if i >= 2 then
            Begin
      //      if (Grid=GridIngib) then begin
            if ((((Grid=GridInzid) or (Grid=GridMark)) and (Pos('+',s)=0) and  (Pos('-',s)=0)) or ((Grid=GridIngib)and (Pos('<',s)=0) and (Pos('>',s)=0) and (Pos('=',s)=0))) then begin
             if  (Grid=GridIngib) then//and((s[i-2]='b') and ((s[i-1]<>'=') or (s[i-1]<>'<') or (s[i-1]<>'>'))) or ((s[i-3]='b') and ((((s[i-1]<>'=') or (s[i-1]<>'<') or (s[i-1]<>'>')) and ((s[i-2]<>'=') or (s[i-2]<>'>')or (s[i-2]<>'<')))))) then
              begin
              y1:=1;
              //ShowMessage('Уточните знак управления ингибиторной дугой положительными метками цвета "а"');
             // Grid.Col := Col;
              //Grid.Row := Row;
              //ActiveControl := Grid;
              //result:=false;
             // Exit;
              end;
             //if (s[i-2]='a') or (s[i-2]='b') then
             if ((i=2) or ((i>2) and (s[i-2]='b'))) then begin
              Val(s[i-1], Value1, e);
             // y1:=1;
             end
             else begin

             if  ((i=3) or((i>3) and ((s[i-1]<>'b') or (s[i-2]<>'b')))) then  begin
              s11:=Copy(s,i-2,2);
              Val(s11, Value1, e);
            //  y1:=1;
              end
            //  else if (i>3) then
          //    begin
              //if ((s[i-1]<>'a')or (s[i-1]<>'b') or (s[i-2]<>'a')or (s[i-2]<>'b') or (s[i-3]<>'a')or (s[i-3]<>'b')) then
              //begin
            //   ShowMessage('Весовой коэффициент дуги не может быть трехзначным!');
              // Grid.Col := Col;
               //Grid.Row := Row;
              // ActiveControl := Grid;
              // result:=false;
              // Exit;
             // end;
            //  end;
            end;
            end else begin
            if (((s[i-2]='+') or (s[i-3]='+')) or ((s[i-2]='-') or (s[i-3]='-')) or ((s[i-2]='<') or (s[i-3]='<')) or ((s[i-2]='>') or (s[i-3]='>'))or ((s[i-2]='=') or (s[i-3]='='))) then  begin
             if  ((s[i-2]='+') or (s[i-2]='-') or (s[i-2]='<') or (s[i-2]='>') or (s[i-2]='=')) then begin
              Val(s[i-1], Value1, e);
              if ((s[i-2]='>') and (s[i-3]<>'<')) then y1:=1;
              if ((s[i-2]='<')) then y1:=2;
              if ((s[i-2]='>') and (s[i-3]='<')) then y1:=4;
              if ((s[i-2]='=') and (s[i-3]<>'>') and (s[i-3]<>'<')) then y1:=3;
              if ((s[i-2]='=') and (s[i-3]='>')) then y1:=5;
              if ((s[i-2]='=') and (s[i-3]='<')) then y1:=6;
             end;
             if ((s[i-3]='+') or (s[i-3]='-') or ((s[i-3]='<') and ((s[i-2]<>'=') or (s[i-2]<>'>'))) or ((s[i-3]='>') and (s[i-2]<>'='))) then begin
              s11:=Copy(s,i-2,2);
              Val(s11, Value1, e);
              if ((s[i-3]='>') and (s[i-4]<>'<')) then y1:=1;
              if ((s[i-3]='<')) then y1:=2;
              if ((s[i-3]='>') and (s[i-4]='<')) then y1:=4;
              if ((s[i-3]='=') and (s[i-4]<>'>') and (s[i-4]<>'<')) then y1:=3;
              if ((s[i-3]='=') and (s[i-4]='>')) then y1:=5;
              if ((s[i-3]='=') and (s[i-4]='<')) then y1:=6;
             end;
            end;
              If ((S[i-2] = '-') or (S[i-3] = '-'))  Then
              Value1 := 0 - Value1;
           end;
           end;
            //else
            // if (i=2) then begin
            // ss:=copy (s, i-1,1);
            //  Val(ss, Value1, e);
            // end;
          // end;
         end;
        If s[i] = Color[2] Then
        Begin
         zz:=0;
         for j:=1 to Length(stroka1) do
          if (s[i-1]=stroka1[j]) then  zz:=1;
           if zz=0 then begin
            ShowMessage('Введите количество отрицательных меток в матрице перед обозначением - "b"');
            Grid.Col := Col;
            Grid.Row := Row;
            ActiveControl := Grid;
            result:=false;
            Exit;
           end;

            e := 1; ss:='';
           if i >= 2 then
            Begin
       //     if (Grid=GridIngib) then begin
            if ((((Grid=GridInzid) or (Grid=GridMark)) and (Pos('+',s)=0) and  (Pos('-',s)=0)) or ((Grid=GridIngib) and (Pos('<',s)=0) and (Pos('>',s)=0) and (Pos('=',s)=0))) then begin
               if  (Grid=GridIngib) then //and((s[i-2]='a') and ((s[i-1]<>'=') or (s[i-1]<>'<') or (s[i-1]<>'>'))) or ((s[i-3]='a') and ((((s[i-1]<>'=') or (s[i-1]<>'<') or (s[i-1]<>'>')) and ((s[i-2]<>'=') or (s[i-2]<>'>')or (s[i-2]<>'<')))))) then
              begin
              y2:=1;
              //ShowMessage('Уточните знак управления ингибиторной дугой отрицательными метками цвета "b"');
              //Grid.Col := Col;
              //Grid.Row := Row;
              //ActiveControl := Grid;
              //result:=false;
              //Exit;
              end;
             //if (s[i-2]='a') or (s[i-2]='b') then
             if ((i=2) or ((i>2) and (s[i-2]='a'))) then begin
              Val(s[i-1], Value2, e);
             // y2:=1;
             end
             else begin

             if  ((i=3) or((i>3) and ((s[i-1]<>'a') or (s[i-2]<>'a')))) then  begin
              s11:=Copy(s,i-2,2);
              Val(s11, Value2, e);
         //     y2:=1;
              end
            //  else begin
               //  if (((s[i-1]<>'a')or (s[i-1]<>'b')) or ((s[i-2]<>'a')or (s[i-2]<>'b')) or ((s[i-3]<>'a')or (s[i-3]<>'b'))) then
             // begin
            //   ShowMessage('Весовой коэффициент дуги не может быть трехзначным!');
             //  Grid.Col := Col;
             //  Grid.Row := Row;
             //  ActiveControl := Grid;
             //  result:=false;
             //  Exit;
            //  end;
         //     end;
          //   end;
             end;
            end else begin
            if (((s[i-2]='+') or (s[i-3]='+')) or ((s[i-2]='-') or (s[i-3]='-')) or ((s[i-2]='<') or (s[i-3]='<')) or ((s[i-2]='>') or (s[i-3]='>'))or ((s[i-2]='=') or (s[i-3]='='))) then  begin
             if  ((s[i-2]='+') or (s[i-2]='-') or (s[i-2]='<') or (s[i-2]='>') or (s[i-2]='=')) then begin
              Val(s[i-1], Value2, e);
              if ((s[i-2]='>') and (s[i-3]<>'<')) then y2:=1;
              if ((s[i-2]='<')) then y2:=2;
              if ((s[i-2]='>') and (s[i-3]='<')) then y2:=4;
              if ((s[i-2]='=') and (s[i-3]<>'>') and (s[i-3]<>'<')) then y2:=3;
              if ((s[i-2]='=') and (s[i-3]='>')) then y2:=5;
              if ((s[i-2]='=') and (s[i-3]='<')) then y2:=6;
             end;
             if ((s[i-3]='+') or (s[i-3]='-') or ((s[i-3]='<') and ((s[i-2]<>'=') or (s[i-2]<>'>'))) or ((s[i-3]='>') and (s[i-2]<>'='))) then begin
              s11:=Copy(s,i-2,2);
              Val(s11, Value2, e);
              if ((s[i-3]='>') and (s[i-4]<>'<')) then y2:=1;
              if ((s[i-3]='<')) then y2:=2;
              if ((s[i-3]='>') and (s[i-4]='<')) then y2:=4;
              if ((s[i-3]='=') and (s[i-4]<>'>') and (s[i-4]<>'<')) then y2:=3;
              if ((s[i-3]='=') and (s[i-4]='>')) then y2:=5;
              if ((s[i-3]='=') and (s[i-4]='<')) then y2:=6;
            end;
            end;
             If ((S[i-2] = '-') or (S[i-3] = '-'))  Then
              Value2 := 0 - Value2;
            end;
            end;
            //else
            // if (i=2) then begin
            // ss:=copy (s, i-1,1);
            //  Val(ss, Value1, e);
            // end;
          // end;
         end;
      end;
    Result := (e=0);
    if not Result then
    begin
    ShowMessage('Укажите цвет (а - положительные, b - отрицательные) меток');
        Grid.Col := Col;
        Grid.Row := Row;
        ActiveControl := Grid;
    end;
end;

function TFormMain.MakeModel(Model: TModel): Boolean;
var
    npos, nper, i, j, t1, r, h, flag, g, a: Integer;
    volum, beginmark1, beginmark2, NeuronDig : Integer;
    ins, outs, ing, dir1, dir2 : Integer;
    Perexod : TPerexod;
    colors:string;
    //Для обозначения в ингибиторах знака <>,>,<,=,>=,<=
    y1,y2: Integer;
begin
  y1:=0; y2:=0;
	Result := false;
	npos := KolPos.Value;
	nper := KolPer.Value;
  flag:=0;
	SetLength(Model.mPosition, npos);
	SetLength(Model.mPerexod, nper);
	SetLength(Model.mPriorPerex, nper);
  colors:='ab';
	for i := 1 to npos do
	begin
    flag:=0;
		if ((TakeInteger(GridMaxVolume,  i - 1, 1, volum, t1)) and  (TakeIntegerC(GridMark, colors, i - 1, 1, beginmark1, beginmark2,y1,y2))) then begin
    for r:= 1 to nper do
     if (TakeInteger(GridInzid,  r, i, t1, flag) and (flag=1)) then begin
       if (TakeInteger(GridUsl,  i - 1, 1, NeuronDig , t1) and (NeuronDig<>0) ) then
       break
       else begin
        ShowMessage ('Поставьте значение числового параметра для срабатывания нейронного перехода');
        GridUsl.Col := i-1;
        GridUsl.Row := 1;
        ActiveControl := GridUsl;
        Exit;
       end;
       end;
    end
    else
     begin
        ShowMessage ('заполните корректно поля максимальной емкости и начальной маркировки для всех позиций');
        Exit;
    end;
		Model.mPosition[i - 1] := TPosizia.Create(Model, beginmark1, beginmark2, flag, NeuronDig, volum);
 	end;
  x:=0;w:=0;
  SetLength (K1,x,w);
  SetLength (K2,x,w);
  for i:=0 to high (Model.mPosition) do with (Model.mPosition[i]) do begin
   if (pFlag=1) then begin
   if x=0 then  begin
    pNPnumber:=x;
    SetLength(K1,x+1,w);
    SetLength(K2,x+1,w);
    Inc(x);
    end
   else begin
    SetLength(K1,x+1,w);
    SetLength(K2,x+1,w);
    pNPnumber:=x;
    Inc(x);
   end;
    end;
   //   z:=IntToStr(x);   
   end;
   a:=0; SetLength(M,1);
	for i:=1 to nper do
    begin
		Perexod := TPerexod.Create(Model);
		Model.mPerexod[i - 1] := Perexod;
    ins := 0;
    outs := 0; ing:=0; g:=0;
		for j:=1 to npos do
      begin
			if not TakeIntegerC(GridInzid, colors, i, j, dir1, dir2,y1,y2) then Exit;
      if not TakeIntegerC(GridIngib, colors, i, j, dir1, dir2,y1,y2) then Exit;
      if  TakeIntegerC(GridInzid, colors, i, j, dir1, dir2,y1,y2) then begin
        if ((dir1 < 0) or (dir2<0) or ((dir1 < 0) and (dir2<0)))  then begin
        if (g=1) then begin
         ShowMessage('Переход, связанный с нейронной позицией, может иметь только одну входную дугу только от нейронной позиции');
         Exit;
        end;
        if ((dir1 < 0) and (dir2<0))then
        ins:=ins+2
        else Inc(ins);
       end;
			 if ((dir1 > 0) or (dir2 > 0) or ((dir1 > 0) and (dir2 > 0))) then begin
        if ((dir1 > 0) and (dir2>0))then
        outs:=outs+2
        else Inc(outs);
       end;
       if ((TakeInteger(GridInzid,  i, j, t1, flag)) and (flag=1) and (dir1=0) and (dir2=0)) then begin
        g:=1;   ins:=1; Perexod.pPok:=1;
        if a=0 then begin
        M[a]:=i-1;  Inc(a);
        end
        else  begin
        SetLength(M,a+1);
        M[a]:=i-1;
        Inc(a);
        end;
       end;
      end;
      if  TakeIntegerC(GridIngib, colors, i, j, dir1, dir2,y1,y2) then 
       begin
        if ((dir1<>0) or (dir2<>0) or (((dir1<>0)) and ((dir1<>0)))) then
        Inc(ing);
       end;
		end;
    SetLength(Perexod.pInDugi, ins);
		SetLength(Perexod.pOutDugi, outs);
   	SetLength(Perexod.pIngib, ing);
    ins := 0;
		outs := 0; ing:=0;
		for j:=1 to npos do
    begin
			if not TakeIntegerC(GridInzid, colors, i, j, dir1, dir2,y1,y2) then Exit;
    	if not TakeIntegerC(GridIngib, colors, i, j, dir1, dir2,y1,y2) then Exit;
      if  TakeIntegerC(GridInzid, colors, i, j, dir1, dir2,y1,y2) then begin
			if ((dir1 < 0) or (dir2<0) or ((dir1 < 0) and (dir2 < 0))) then
        begin
 				if ((dir1 < 0) and (dir2 < 0)) then begin
         with Perexod.pInDugi[ins] do
				 begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 := Abs(dir1);
          dWes2 := 0;
          dZnak1:=0;
          dZnak2:=0;
        end;
			 	Inc(ins);
        with Perexod.pInDugi[ins] do
				 begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 := 0;
          dWes2 := Abs(dir2);
          dZnak1:=0;
          dZnak2:=0;
   		   end;
			 	Inc(ins);
       end
       else begin
        if (dir1 < 0) then begin
         with Perexod.pInDugi[ins] do
				 begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 := Abs(dir1);
          dWes2 := 0;
          dZnak1:=0;
          dZnak2:=0;
         end;
        Inc(ins);
        end;
        if (dir2 < 0) then begin
         with Perexod.pInDugi[ins] do
				 begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 := 0;
          dWes2 := Abs(dir2);
          dZnak1:=0;
          dZnak2:=0;
         end;
        Inc(ins);
        end;
       end;
			end;

			if ((dir1 > 0) or (dir2>0) or ((dir1 > 0) and (dir2 > 0))) then
			begin
       if ((dir1 > 0) and (dir2 > 0)) then begin
				with Perexod.pOutDugi[outs] do
				begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 := dir1;
          dWes2 := 0;
          dZnak1:=0;
          dZnak2:=0;
        end;
				Inc(outs);
        with Perexod.pOutDugi[outs] do
				begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 := 0;
          dWes2 := dir2;
          dZnak1:=0;
          dZnak2:=0;
        end;
				Inc(outs);
       end
       else begin
       if (dir1 > 0) then begin
        with Perexod.pOutDugi[outs] do
				begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 := dir1;
          dWes2 := 0;
          dZnak1:=0;
          dZnak2:=0;
       end;
				Inc(outs);
       end;
       if (dir2 > 0) then begin
        with Perexod.pOutDugi[outs] do
				begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 := 0;
          dWes2 := dir2;
          dZnak1:=0;
          dZnak2:=0;
       end;
				Inc(outs);
       end;
       end;
     	end;
      if (TakeInteger(GridInzid,  i, j, t1, flag) and (flag=1) and (dir1=0) and (dir2=0)) then
      begin
				with Perexod.pInDugi[ins] do
				begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 := 0;
          dWes2 := 0;
          dZnak1:=0;
          dZnak2:=0;
      	end;
				Inc(ins);
 			end;
     end;
     if  TakeIntegerC(GridIngib, colors, i, j, dir1, dir2,y1,y2) then begin
      if ((y1<>0) or (y2<>0) or((y1<>0) and (y2<>0))) then begin
       if ((y1<>0) and (y2=0)) then
       begin
         with Perexod.pIngib[ing] do
				 begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 := Abs(dir1);
          dWes2 := 0;
          dZnak2:=0;
          if(y1=1) then   dZnak1:=1;
          if(y1=2) then   dZnak1:=2;
          if(y1=3) then   dZnak1:=3;
          if(y1=4) then   dZnak1:=4;
          if(y1=5) then   dZnak1:=5;
          if(y1=6) then   dZnak1:=6;
         end;
         Inc(ing);
       end;
       if ((y1=0) and (y2<>0)) then
       begin
         with Perexod.pIngib[ing] do
				 begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 :=0;
          dWes2 := Abs(dir2);
          dZnak1:=0;
          if(y2=1) then   dZnak2:=1;
          if(y2=2) then   dZnak2:=2;
          if(y2=3) then   dZnak2:=3;
          if(y2=4) then   dZnak2:=4;
          if(y2=5) then   dZnak2:=5;
          if(y2=6) then   dZnak2:=6;
         end;
         Inc(ing);
       end;
       if ((y1<>0) and (y2<>0)) then
       begin
         with Perexod.pIngib[ing] do
				 begin
					dPosizia := Model.mPosition[j - 1];
					dWes1 :=Abs(dir1);
          dWes2 := Abs(dir2);
          if(y1=1) then   dZnak1:=1;
          if(y1=2) then   dZnak1:=2;
          if(y1=3) then   dZnak1:=3;
          if(y1=4) then   dZnak1:=4;
          if(y1=5) then   dZnak1:=5;
          if(y1=6) then   dZnak1:=6;
          if(y2=1) then   dZnak2:=1;
          if(y2=2) then   dZnak2:=2;
          if(y2=3) then   dZnak2:=3;
          if(y2=4) then   dZnak2:=4;
          if(y2=5) then   dZnak2:=5;
          if(y2=6) then   dZnak2:=6;
         end;
         Inc(ing);
       end;
      end;
     end;

  end;
 end;
  for h:=0 to (nper-1) do Model.mPriorPerex[h] := h;
	Result := true;
end;


function TFormMain.ApplyPriorities(Model: TModel): Boolean;
var
	i, u, m, k, t, tt : Integer;
	P : array of Integer;
begin
  Result := false;  k:=0;
  SetLength(Model.mPriorPerex, KolPer.Value);
  SetLength(P, Length(Model.mPriorPerex));
  for i:=0 to high(Model.mPerexod) do with Model.mPerexod[i] do
   if TakeInteger(GridPrior, i, 1, k,tt) then
    pPrior:=k;
  for i := 0 to High(P) do begin
    if not TakeInteger(GridPrior, i, 1, P[i],tt) then Exit;
  end;

  u := 0;
  while u < High(P) do begin
    // Поиск максимума
    m := P[u];
    for i := u + 1 to High(P) do m := Max(m, P[i]);
    // Перекачка
    for i := u to High(P) do
      if P[i] = m then begin
      t := Model.mPriorPerex[u];
      Model.mPriorPerex[u] := Model.mPriorPerex[i];
      Model.mPriorPerex[i] := t;
      P[i] := P[u];
      Inc(u);
    end;
  end;
  Result := true;
end;

procedure TFormMain.ModelMenuClick(Sender: TObject);
var
 // Model : TModel;
  MM:TModel;
 FirstTerms : TFirstTerms;
begin
    MM := TModel.Create;
    if (MakeModel(MM) and ApplyPriorities(MM))  then begin
      FirstTerms := TFirstTerms.Born(Self, MM);
       try
        FirstTerms.ShowModal;
       finally
        FreeAndNil(FirstTerms);
       end;
      end
    else
    ShowMessage ('Модель не создана из-за ошибок при заполнении полей формы!'+chr(013)+'Исправьте ошибки и нажмите на Моделирование снова!');
end;

{*
procedure TFormMain.AboutMenuClick(Sender: TObject);
begin
 About.show;
end;

procedure TFormMain.HelpMenuClick(Sender: TObject);
begin
Help.show;
end;
*}
procedure TFormMain.ButtonUravnClick(Sender: TObject);
begin
FormUravnenie.Show;
end;

end.
