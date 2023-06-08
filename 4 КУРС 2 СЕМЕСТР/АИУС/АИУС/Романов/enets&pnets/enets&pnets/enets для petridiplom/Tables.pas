unit Tables;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, UCore, UMain, ExtCtrls;

type
  TForm1 = class(TForm)
    GridCapacity: TStringGrid;
    GridActive: TStringGrid;
    GridSleep: TStringGrid;
    GridIncident: TStringGrid;
    GridDelay: TStringGrid;
    GridPriority: TStringGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label1: TLabel;
    Bevel1: TBevel;
    procedure GetTables;
    procedure GetNames;
    procedure SaveTables(var Writer: TextFile);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ns, nb : Integer;

implementation

{$R *.dfm}

procedure TForm1.GetTables;
var
   node : TNode;
   link : TLink;
   i,j : Integer;
   b,s : Integer;
   b1,s1 : Integer;
   k : Integer;
begin
   b := 0; b1 := 0;
   s := 0; s1 := 0;
   for i := 0 to Main.m_net.m_Nodes.Count - 1 do begin
      node := TNode(Main.m_net.m_Nodes.Items[i]);
      if node is TBarrier then b := b + 1
      else if node is TSlot then s := s + 1;
   end;
   GridCapacity.ColCount := s;
   GridDelay.ColCount := s;
   GridActive.ColCount := s;
   GridSleep.ColCount := b;
   GridPriority.ColCount := b;
   ns := s; nb := b;
   if b > 0 then GridIncident.ColCount := b + 1
   else GridIncident.ColCount := b + 2;
   if s > 0 then GridIncident.RowCount := s + 1
   else GridIncident.RowCount := s + 2;
   b := 0;
   s := 0;
   if Main.m_net.m_Nodes.Count = 0 then Exit;
   if TNode(Main.m_net.m_Nodes.Items[0]) is TSlot then Inc(s1)
   else if TNode(Main.m_net.m_Nodes.Items[0]) is TBarrier then Inc(b1);
   for i := 0 to Main.m_net.m_Nodes.Count - 1 do begin
      node := TNode(Main.m_net.m_Nodes.Items[i]);
      if node is TBarrier then begin
         GridSleep.Cells[b,0] := node.m_Name;
         GridSleep.Cells[b,1] := IntToStr(TBarrier(node).m_MX) + '#' + IntToStr(TBarrier(node).m_DX);
         GridPriority.Cells[b,0] := node.m_Name;
         GridPriority.Cells[b,1] := IntToStr(TBarrier(node).m_Priority);
         Inc(b);
         GridIncident.Cells[b,0] := node.m_Name;
         for j := 0 to Main.m_net.m_Links.Count - 1 do begin
            link := TLink(Main.m_net.m_Links.Items[j]);
            if link.m_A = node then begin
               if link.m_B is TSlot then begin
                  k := Main.m_net.m_Nodes.IndexOf(link.m_B);
                  while k <> 0 do begin
                     if TNode(Main.m_net.m_Nodes.Items[k]) is TSlot then Inc(s1);
                     Dec(k);
                  end;
                  GridIncident.Cells[b,s1] := '+' + IntToStr(link.m_Capacity);
                  if TNode(Main.m_net.m_Nodes.Items[0]) is TSlot then s1 := 1
                  else s1 := 0;
               end;
            end;
         end;
      end
      else if node is TSlot then begin
         GridCapacity.Cells[s,0] := node.m_Name;
         GridCapacity.Cells[s,1] := IntToStr(TSlot(node).m_Capacity);
         GridDelay.Cells[s,0] := node.m_Name;
         GridDelay.Cells[s,1] := IntToStr(TSlot(node).m_MX) + '#' + IntToStr(TSlot(node).m_DX);
         GridActive.Cells[s,0] := node.m_Name;
         GridActive.Cells[s,1] := IntToStr(TSlot(node).m_Initial);
         Inc(s);
         GridIncident.Cells[0,s] := node.m_Name;
         for j := 0 to Main.m_net.m_Links.Count - 1 do begin
            link := TLink(Main.m_net.m_Links.Items[j]);
            if link.m_A = node then begin
               if link.m_B is TBarrier then begin
                  k := Main.m_net.m_Nodes.IndexOf(link.m_B);
                  while k <> 0 do begin
                     if TNode(Main.m_net.m_Nodes.Items[k]) is TBarrier then Inc(b1);
                     Dec(k);
                  end;
                  GridIncident.Cells[b1,s] := '-' + IntToStr(link.m_Capacity);
                  if TNode(Main.m_net.m_Nodes.Items[0]) is TBarrier then b1 := 1
                  else b1 := 0;
               end;
            end;
         end;
      end;
   end;
end;

procedure TForm1.GetNames;
var
   node : TNode;
   b,s : Integer;
   i : Integer;
begin
   b := 0; s := 0;
   for i := 0 to Main.m_net.m_Nodes.Count - 1 do begin
      node := TNode(Main.m_net.m_Nodes.Items[i]);
      if node is TBarrier then begin
         Inc(b);
         node.m_Name := 'T' + IntToStr(b);
      end
      else if node is TSlot then begin
         Inc(s);
         node.m_Name := 'P' + IntToStr(s);
      end;
   end;
   Main.m_Net.Paint;
end;

procedure TForm1.SaveTables(var Writer: TextFile);
var
  i, j : Integer;
begin
   GetTables;
   WriteLn(Writer, ns, ' ', nb);
   for i := 1 to ns do begin
      WriteLn(Writer, GridCapacity.Cells[i - 1, 1]);
      WriteLn(Writer, GridDelay.Cells[i - 1, 1]);
      WriteLn(Writer, GridActive.Cells[i - 1, 1]);
   end;
   for i := 1 to nb do begin
      WriteLn(Writer, GridSleep.Cells[i - 1, 1]);
      WriteLn(Writer, GridPriority.Cells[i - 1, 1]);
   end;
   for i := 1 to ns do
      for j := 1 to nb do begin
         WriteLn(Writer, GridIncident.Cells[j, i]);
         WriteLn(Writer, '');
      end;
   WriteLn(Writer, '<EOF>');
end;

end.
