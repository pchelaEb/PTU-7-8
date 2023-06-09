unit netUTables;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, netUCore, Menus, ExtCtrls, Buttons, Spin, Math, ptmUEngine;

type
  TnetForm1 = class(TForm)
    GridCapacity: TStringGrid;
    GridActive: TStringGrid;
    GridSleep: TStringGrid;
    GridIncident: TStringGrid;
    GridDelay: TStringGrid;
    GridPriority: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SaveDialog1: TSaveDialog;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N2: TMenuItem;
    Label7: TLabel;
    Label8: TLabel;
    SpinStorages: TSpinEdit;
    SpinBarriers: TSpinEdit;
    OpenDialog1: TOpenDialog;
    N6: TMenuItem;
    GridIngibitor: TStringGrid;
    ColorEdit: TSpinEdit;
    Button1: TButton;
    Button2: TButton;
    LabelPorog: TLabel;
    GridPorog: TStringGrid;
    Label9: TLabel;
    GridTimeLive: TStringGrid;
    Label10: TLabel;
    Label11: TLabel;
    EditKol: TEdit;
    Button3: TButton;
    GridKol: TStringGrid;
    Label12: TLabel;
    GridPot: TStringGrid;
    GridMetki: TStringGrid;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure SpinBarriersChange(Sender: TObject);
    procedure SpinStoragesChange(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure ClearTables(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  netForm1: TnetForm1;
  f:textfile;
  n,m:integer;

implementation

uses netHelpForm1, ptmUMain, Unit5, Unit7, Unit8, Unit4;

{$R *.dfm}

procedure TnetForm1.ClearTables;
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
  GridKol.Rows[1].Clear;
  for i := 1 to GridIncident.RowCount do GridIncident.Rows[i].Clear;
end;

procedure TnetForm1.SpinStoragesChange(Sender: TObject);
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
  GridTimeLive.ColCount := n;

  for i := 1 to n do begin
    s := 'P' + IntToStr(i);
    GridCapacity.Cells[i - 1, 0] := s;
    GridDelay.Cells[i - 1, 0] := s;
    GridActive.Cells[i - 1, 0] := s;
    GridIncident.Cells[0, i] := s;
    GridIngibitor.Cells[0, i] := s;
    GridTimeLive.Cells[i - 1, 0] := s;
  end;
end;


procedure TnetForm1.SpinBarriersChange(Sender: TObject);
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
    GridPorog.Cells[i-1,0] := s;
    GridPot.Cells[i - 1, 0] := s;
  end;

end;

procedure TnetForm1.FormCreate(Sender: TObject);
begin
  SpinStoragesChange(nil);
   SpinBarriersChange(nil);
   EditKol.Text := '1';
end;

//������ �����
procedure TnetForm1.N4Click(Sender: TObject);
begin
netForm1.Close;
end;

//������ ��������� ������� ��� ����� �����������
procedure TnetForm1.N3Click(Sender: TObject);
var FName1,s,value:string;
iw,jw:integer;
SL:TStringList;
begin
  SaveDialog1.Title:='�������� ����� ��� �������';
  SaveDialog1.FileName:='�����1';
  if SaveDialog1.Execute then
  begin
    FName1:=SaveDialog1.FileName;
    Case SaveDialog1.FilterIndex of
    1:FName1:=ChangeFileExt(FName1,'.txt');
    end;
  end;
  SaveDialog1.Filter:='.txt';
  SL := TStringList.Create;
  for iw:=1 to GridIncident.ColCount - 1 do
  begin
    s := '';
    for jw:=1 to GridIncident.RowCount - 1 do
    begin
      value := trim(GridIncident.Cells[iw,jw]);
      if value = '' then value := '0';
      s := TrimLeft(s + ' ') + value;
    end;
    SL.Add(s);
  end;
  SL.SaveToFile(FName1);
  SL.Destroy;
end;

procedure TnetForm1.N2Click(Sender: TObject);
var
  Writer : TextFile;
  ns, nb, i, j : Integer;
begin
  SaveDialog1.FileName := OpenDialog1.FileName;
  if not SaveDialog1.Execute then Exit;

  AssignFile(Writer, SaveDialog1.FileName);
  Rewrite(Writer);
  try
    ns := SpinStorages.Value;
    nb := SpinBarriers.Value;
    WriteLn(Writer, ns, ' ', nb, ' ', ColorEdit.Value);

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

//procedure TnetForm1.MenuQuitClick(Sender: TObject);
//begin
  //Close;
//end;

procedure TnetForm1.N6Click(Sender: TObject);
begin
netForm2.show;
end;

// ������� � �������������
procedure TnetForm1.Button1Click(Sender: TObject);
var
  Writer : TextFile;
  ns, nb, i, j : Integer;
  filename, s: string;
begin
  SaveDialog1.FileName := OpenDialog1.FileName;

  if not SaveDialog1.Execute then Exit;

  AssignFile(Writer, SaveDialog1.FileName);
  filename := SaveDialog1.FileName;
  Rewrite(Writer);
  try
    ns := SpinStorages.Value;
    nb := SpinBarriers.Value;
    WriteLn(Writer, ns, ' ', nb, ' ', ColorEdit.Value);

    for i := 1 to ns do begin
      WriteLn(Writer, GridCapacity.Cells[i - 1, 1]);
      WriteLn(Writer, GridDelay.Cells[i - 1, 1]);
      WriteLn(Writer, GridActive.Cells[i - 1, 1]);
      WriteLn(Writer, GridTimeLive.Cells[i - 1, 1]);
      s := '';
      j := 1;
      while (j <= GridMetki.ColCount)and(GridMetki.Cells[j,i]<>'') do begin
        s:=s+GridMetki.Cells[j,i]+';';
        j:=j+1;
      end;  
      WriteLn(Writer, s);
      if pos('(���)',GridMetki.Cells[0,i])>0 then
       WriteLn(Writer, 'remake')
      else
       WriteLn(Writer, '0');
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
 // CloseFile(Writer);

//WinExec(PChar('ModelNetProgramm3v1\Odnomer_NET\PetriM.exe'), SW_ShowNormal);

ptmMain.OpenModelFile(filename);

Close();
ptmMain.Show();



end;
// ������� � �����������
procedure TnetForm1.Button2Click(Sender: TObject);
var FName1,s,value:string;
iw,jw:integer;
SL:TStringList;
//Rows:integer;
//Cols:integer;
begin
  //GetTables;
  // Rows := GridIncident.RowCount -1;
  // Cols := GridIncident.ColCount - 1;
   Form8.Edit1.Text := IntToStr(SpinStorages.Value);
   Form8.Edit2.Text := IntToStr(SpinBarriers.Value);
   Form7.Edit1.Text := IntToStr(SpinStorages.Value);
   Form7.Edit2.Text := IntToStr(SpinBarriers.Value);
   Form4.Edit1.Text := IntToStr(SpinStorages.Value);
   Form4.Edit2.Text := IntToStr(SpinBarriers.Value);


  SaveDialog1.Title:='�������� ����� ��� �������';
  SaveDialog1.FileName:='�����1';
  if SaveDialog1.Execute then
  begin
    FName1:=SaveDialog1.FileName;
    Case SaveDialog1.FilterIndex of
    1:FName1:=ChangeFileExt(FName1,'.txt');
    end;
  end;
  SaveDialog1.Filter:='.txt';
  SL := TStringList.Create;
  for iw:=1 to GridIncident.ColCount - 1 do
  begin
    s := '';
    for jw:=1 to GridIncident.RowCount - 1 do
    begin
      value := trim(GridIncident.Cells[iw,jw]);
      if value = '' then value := '0';
      s := TrimLeft(s + ' ') + value;
    end;
    SL.Add(s);
  end;
  SL.SaveToFile(FName1);
  SL.Destroy;
 Close();
 Form5.Show();
end;

procedure TnetForm1.Button3Click(Sender: TObject);
var
i, n, m, k, kmax, j : Integer;
s : string;
kof : string;
begin
kmax :=0;
 n := SpinBarriers.Value;
  for i := 1 to n + 1 do begin
   if  GridPorog.Cells[i-1, 1] <> '1' then
   EditKol.Text := GridPorog.Cells[i - 1, 1];
   end;

    m := SpinStorages.Value;

   for i := 1 to m do begin
   //if GridTimeLive.Cells[i - 1, 1] <> '1' then
   k := StrToInt(GridTimeLive.Cells[i - 1, 1]);
   if k > kmax then
   kmax := k;
    end;
   //ShowMessage(IntToStr(kmax));


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
