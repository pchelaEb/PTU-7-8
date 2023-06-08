unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ToolWin, ComCtrls, ImgList, UCore, StdCtrls;


type
  TMain = class(TForm)
    ScrollBox: TScrollBox;
    PaintBox: TPaintBox;
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    MenuNew: TMenuItem;
    MenuOpen: TMenuItem;
    MenuSave: TMenuItem;
    MenuHR1: TMenuItem;
    MenuQuit: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ToolBar: TToolBar;
    ImageList: TImageList;
    ButtonSelect: TToolButton;
    ButtonSlot: TToolButton;
    ButtonBarrier: TToolButton;
    ButtonLink: TToolButton;
    ButtonGen: TToolButton;
    ButtonShaman: TToolButton;
    ButtonMurder: TToolButton;
    ButtonQueue: TToolButton;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    C1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    ShablonlButton: TToolButton;
    Separator: TToolButton;
    PopupMenu1: TPopupMenu;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N2PTP: TMenuItem;
    N2TPT: TMenuItem;
    N16: TMenuItem;
    procedure PaintBoxPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MenuNewClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuSaveClick(Sender: TObject);
    procedure MenuQuitClick(Sender: TObject);
    procedure ButtonLinkClick(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GetTables;
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N2PTPClick(Sender: TObject);
    procedure N2TPTClick(Sender: TObject);
    procedure N16Click(Sender: TObject);

  

  private
    // ����
    m_Net : TNet;
    // ������ ����
    m_SourceNode : TNode;
  end;


var
  Main: TMain;
  ns, nb : Integer;
  shablon:string;

implementation

{$R *.dfm}

uses
 About, Math, UProp, UView, Tables;


procedure TMain.PaintBoxPaint(Sender: TObject);
begin
  m_Net.Paint;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  m_Net := TNet.Create(PaintBox.Canvas, ScrollBox);
end;


procedure TMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(m_Net);
end;


procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('�� ������������� ������ ����� �� ���������?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;


procedure TMain.MenuNewClick(Sender: TObject);
begin
  if MessageDlg('�������� ����?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    ButtonSelect.Down := true;
    m_Net.Clear;
  end;
end;


procedure TMain.MenuOpenClick(Sender: TObject);
var
  Reader : TextFile;
begin
  if not OpenDialog.Execute then Exit;

  AssignFile(Reader, OpenDialog.FileName);
  Reset(Reader);
  try
    ButtonSelect.Down := true;
    m_Net.Clear;
    m_Net.Load(Reader);
  finally
    CloseFile(Reader);
  end;
end;


procedure TMain.MenuSaveClick(Sender: TObject);
const d:string=')';
var
  Writer : TextFile;
  i, j : Integer;
begin
  SaveDialog.FileName := OpenDialog.FileName;
  if not SaveDialog.Execute then Exit;

  AssignFile(Writer, SaveDialog.FileName);
  Rewrite(Writer);
  try
    if SaveDialog.FilterIndex = 1 then begin
      ButtonSelect.Down := true;
      m_Net.Save(Writer);
    end else begin
      GetTables;
      WriteLn(Writer, ns, ' ', nb, ' 3');
      for i := 1 to ns do begin
        WriteLn(Writer, Form1.GridCapacity.Cells[i - 1, 1]);
        WriteLn(Writer, Form1.GridDelay.Cells[i - 1, 1]);
        WriteLn(Writer, Form1.GridActive.Cells[i - 1, 1]);
      end;
      for i := 1 to nb do begin
        WriteLn(Writer, Form1.GridSleep.Cells[i - 1, 1]);
        WriteLn(Writer, Form1.GridPriority.Cells[i, 1]);
      end;
      for i := 1 to ns do
        for j := 1 to nb do begin
          WriteLn(Writer, Copy(Form1.GridIncident.Cells[j, i],5,LastDelimiter(d,Form1.GridIncident.Cells[j, i])-5));
          WriteLn(Writer, Copy(Form1.GridIngibit.Cells[j, i],5,LastDelimiter(d,Form1.GridIngibit.Cells[j, i])-5));
        end;
      WriteLn(Writer, '<EOF>');
    end
  finally
    CloseFile(Writer);
  end;
end;


procedure TMain.MenuQuitClick(Sender: TObject);
begin
  Close;
end;


procedure TMain.ButtonLinkClick(Sender: TObject);
begin
  m_Net.Select(nil);
  m_SourceNode := nil;
end;


procedure TMain.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  p: integer;
  entity : TEntity;
  link : TLink;
  i : Integer;
  m_Slot1,m_Slot2,m_Slot3,m_Slot4,m_Slot5,m_Barrier1: TNode;
 label A;
begin
p:=0;
 if shablon='2P_T_P' then
    begin
    p:=p+1;
    m_Net.Select(TSlot.Create(m_Net, X, Y, 1, 0, '1', 0,0,0));
    m_Slot1:=TNode(m_Net.HitTest(X, Y));
    m_Net.Select(TSlot.Create(m_Net, X, Y+60, 1, 0, '1', 0,0,0));
    m_Slot2:=TNode(m_Net.HitTest(X, Y+60));
    m_Net.Select(TSlot.Create(m_Net, X+120, Y+30, 1, 0, '1', 0,0,0));
    m_Slot3:=TNode(m_Net.HitTest(X+120, Y+30));
    m_Net.Select(TBarrier.Create(m_Net, X+60, Y+30, 1, 0, 1));
    m_Barrier1:=TNode(m_Net.HitTest(X+60, Y+30));
    m_Net.Select(TLink.Create(m_Net,m_Slot1 , m_Barrier1, 0));
    m_Net.Select(TLink.Create(m_Net,m_Slot2 , m_Barrier1, 0));
    m_Net.Select(TLink.Create(m_Net, m_Barrier1 , m_Slot3, 0));
    shablon:='';
    end;
 if shablon='P_T_2P' then
    begin
    p:=p+1;
    m_Net.Select(TSlot.Create(m_Net, X, Y, 1, 0, '1', 0,0,0));
    m_Slot1:=TNode(m_Net.HitTest(X, Y));
    m_Net.Select(TSlot.Create(m_Net, X+120, Y-30, 1, 0, '1', 0,0,0));
    m_Slot2:=TNode(m_Net.HitTest(X+120, Y-30));
    m_Net.Select(TSlot.Create(m_Net, X+120, Y+30, 1, 0, '1', 0,0,0));
    m_Slot3:=TNode(m_Net.HitTest(X+120, Y+30));
    m_Net.Select(TBarrier.Create(m_Net, X+60, Y, 1, 0, 1));
    m_Barrier1:=TNode(m_Net.HitTest(X+60, Y));
    m_Net.Select(TLink.Create(m_Net, m_Slot1 , m_Barrier1, 0));
    m_Net.Select(TLink.Create(m_Net,m_Barrier1 , m_Slot2, 0));
    m_Net.Select(TLink.Create(m_Net,m_Barrier1 , m_Slot3, 0));
    shablon:='';
    end;
 if shablon='P_T_P' then
    begin
    p:=p+1;
    m_Net.Select(TSlot.Create(m_Net, X, Y, 1, 0, '1', 0,0,0));
    m_Slot1:=TNode(m_Net.HitTest(X, Y));
    m_Net.Select(TSlot.Create(m_Net, X+120, Y, 1, 0, '1', 0,0,0));
    m_Slot2:=TNode(m_Net.HitTest(X+120, Y));
    m_Net.Select(TBarrier.Create(m_Net, X+60, Y, 1, 0, 1));
    m_Barrier1:=TNode(m_Net.HitTest(X+60, Y));
    m_Net.Select(TLink.Create( m_Net,m_Slot1 ,m_Barrier1, 0));
    m_Net.Select(TLink.Create(m_Net,m_Barrier1 , m_Slot2, 0));
    shablon:='';
    end;
 if shablon='3P_T_2P' then
    begin
    p:=p+1;
    m_Net.Select(TSlot.Create(m_Net, X, Y, 1, 0, '1', 0,0,0));
    m_Slot1:=TNode(m_Net.HitTest(X, Y));
    m_Net.Select(TSlot.Create(m_Net, X, Y+40, 1, 0, '1', 0,0,0));
    m_Slot2:=TNode(m_Net.HitTest(X, Y+40));
    m_Net.Select(TSlot.Create(m_Net, X, Y+80, 1, 0, '1', 0,0,0));
    m_Slot3:=TNode(m_Net.HitTest(X, Y+80));
    m_Net.Select(TSlot.Create(m_Net, X+120, Y+20, 1, 0, '1', 0,0,0));
    m_Slot4:=TNode(m_Net.HitTest(X+120, Y+20));
    m_Net.Select(TSlot.Create(m_Net, X+120, Y+60, 1, 0, '1', 0,0,0));
    m_Slot5:=TNode(m_Net.HitTest(X+120, Y+60));
    m_Net.Select(TBarrier.Create(m_Net, X+60, Y+40, 1, 0, 1));
    m_Barrier1:=TNode(m_Net.HitTest(X+60, Y+40));
    m_Net.Select(TLink.Create(m_Net,m_Slot1 , m_Barrier1, 0));
    m_Net.Select(TLink.Create(m_Net,m_Slot2 , m_Barrier1, 0));
    m_Net.Select(TLink.Create(m_Net,m_Slot3 , m_Barrier1, 0));
    m_Net.Select(TLink.Create(m_Net,m_Barrier1 , m_Slot4, 0));
    m_Net.Select(TLink.Create(m_Net,m_Barrier1 , m_Slot5, 0));
    shablon:='';
    end;
 if shablon='2P_T_2P' then
    begin
    p:=p+1;
    m_Net.Select(TSlot.Create(m_Net, X, Y, 1, 0, '1', 0,0,0));
    m_Slot1:=TNode(m_Net.HitTest(X, Y));
    m_Net.Select(TSlot.Create(m_Net, X, Y+60, 1, 0, '1', 0,0,0));
    m_Slot2:=TNode(m_Net.HitTest(X, Y+60));
    m_Net.Select(TSlot.Create(m_Net, X+120, Y, 1, 0, '1', 0,0,0));
    m_Slot3:=TNode(m_Net.HitTest(X+120, Y));
    m_Net.Select(TSlot.Create(m_Net, X+120, Y+60, 1, 0, '1', 0,0,0));
    m_Slot4:=TNode(m_Net.HitTest(X+120, Y+60));
    m_Net.Select(TBarrier.Create(m_Net, X+60, Y+30,  1, 0, 1));
    m_Barrier1:=TNode(m_Net.HitTest(X+60, Y+30));
    m_Net.Select(TLink.Create(m_Net,m_Slot1 , m_Barrier1, 0));
    m_Net.Select(TLink.Create(m_Net,m_Slot2 , m_Barrier1, 0));
    m_Net.Select(TLink.Create(m_Net,m_Barrier1 , m_Slot3, 0));
    m_Net.Select(TLink.Create(m_Net,m_Barrier1 , m_Slot4, 0));
    shablon:='';
    end;
 if p>0 then goto A;
 if ButtonSelect.Down then begin
    // ����� ������
    entity := m_Net.HitTest(X, Y);
    m_Net.Select(entity);
    if (Button = mbRight) and ((entity is TNode)or(entity is TEntity)) then begin
      ShowProp(TNode(entity));
    end;
  end else if Button = mbRight then begin
    // ������
    m_Net.Select(nil);
    ButtonSelect.Down := true;
  end else if Button = mbLeft then begin
    // ����������
    if ButtonBarrier.Down then m_Net.Select(TBarrier.Create(m_Net, X, Y, 1, 0, 1));
    if ButtonSlot.Down then m_Net.Select(TSlot.Create(m_Net, X, Y, 1, 0, '1', 0,0,0));
    if ButtonQueue.Down then m_Net.Select(TQueue.Create(m_Net, X, Y, '10', 0,0,0));
    if ButtonGen.Down then m_Net.Select(TGenerator.Create(m_Net, X, Y, 100, 0));
    if ButtonMurder.Down then m_Net.Select(TMurder.Create(m_Net, X, Y));
    if ButtonShaman.Down then m_Net.Select(TShaman.Create(m_Net, X, Y, 0,0,0));

    // ����������
    if ButtonLink.Down then begin
      entity := m_Net.HitTest(X, Y);
      if (entity = m_SourceNode) or not(entity is TNode) then Exit;
      if m_SourceNode = nil then begin
      //  if not TNode(entity).CanAddOutput then Exit;
        m_SourceNode := TNode(entity);
        m_Net.Select(entity);
      end else begin
       // if not TNode(entity).CanAddInput then Exit;
        if ((m_SourceNode is TBarrier) and (entity is TDevice)) or
           ((m_SourceNode is TDevice) and (entity is TBarrier))
        then else Exit;
        with m_Net.m_Links do begin
          for i := 0 to Count - 1 do begin
            link := TLink(Items[i]);
            if ((link.m_A = m_SourceNode) and (link.m_B = entity)) or
               ((link.m_B = m_SourceNode) and (link.m_A = entity))
            then Exit;
          end;
        end;
        m_Net.Select(TLink.Create(m_Net, m_SourceNode, TNode(entity), 0));
        m_SourceNode := nil;
      end;
    end;
  end;
A: end;


procedure TMain.PaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  // �����������
  if (ssLeft in Shift) and ButtonSelect.Down and (m_Net.m_Selected is TNode) then begin
    TNode(m_Net.m_Selected).ChangePos(X, Y);
  end;
end;





procedure TMain.N3Click(Sender: TObject);
begin
 Buttonslot.Down:= true;
end;

procedure TMain.N4Click(Sender: TObject);
begin
 ButtonBarrier.Down:=true;
end;

procedure TMain.N5Click(Sender: TObject);
begin
 Buttongen.Down:=true;
end;

procedure TMain.N6Click(Sender: TObject);
begin
 ButtonShaman.Down:=true;
end;

procedure TMain.N7Click(Sender: TObject);
begin
ButtonMurder.Down:=true;
end;

procedure TMain.N8Click(Sender: TObject);
begin
ButtonQueue.Down:=true;
end;

procedure TMain.N9Click(Sender: TObject);
begin
 ButtonLink.Down:=true;
end;

procedure TMain.N10Click(Sender: TObject);
begin
 // ������� ���������� ����������
   Winhelp(Handle,'help.hlp',HELP_FINDER,0);

end;

procedure TMain.N12Click(Sender: TObject);
begin
 aboutbox.Show;
end;

procedure TMain.GetTables;
var
   node : TNode;
   link : TLink;
   i,j : Integer;
   b,s : Integer;
   b1,s1 : Integer;
   k : Integer;
   metki: string;
begin
   b := 0; b1 := 0;
   s := 0; s1 := 0;
   for i := 0 to m_net.m_Nodes.Count - 1 do begin
      node := TNode(m_net.m_Nodes.Items[i]);
      if node is TBarrier then b := b + 1
      else if node is TSlot then s := s + 1;
   end;
   Form1.GridCapacity.ColCount := s;
   Form1.GridDelay.ColCount := s;
   Form1.GridActive.ColCount := s+1;
   Form1.GridSleep.ColCount := b;
   Form1.GridPriority.ColCount := b+1;
   ns := s; nb := b;
   if b > 0 then
   begin
   Form1.GridIngibit.ColCount := b + 1;
   Form1.GridIncident.ColCount := b + 1;
   end  else
   begin
   Form1.GridIngibit.ColCount := b + 2;
   Form1.GridIncident.ColCount := b + 2;
   end;
   if s > 0 then
   begin
   Form1.GridIngibit.RowCount := s + 1;
   Form1.GridIncident.RowCount := s + 1;
   end else
   begin
   Form1.GridIngibit.RowCount := s + 2;
   Form1.GridIncident.RowCount := s + 2;
   end;
   b := 0;
   s := 0;
   if m_net.m_Nodes.Count = 0 then Exit;
   if TNode(m_net.m_Nodes.Items[0]) is TSlot then Inc(s1)
   else if TNode(m_net.m_Nodes.Items[0]) is TBarrier then Inc(b1);
   for i := 0 to m_net.m_Nodes.Count - 1 do begin
   metki:='';
      node := TNode(m_net.m_Nodes.Items[i]);
      if node is TBarrier then begin
         Form1.GridSleep.Cells[b,0] := node.m_Name;
         Form1.GridSleep.Cells[b,1] := IntToStr(TBarrier(node).m_MX) + '#' + IntToStr(TBarrier(node).m_DX);
         Form1.GridPriority.Cells[b+1,0] := node.m_Name;
         Form1.GridPriority.Cells[b+1,1] := IntToStr(TBarrier(node).m_Priority);
         Form1.GridPriority.Cells[0,1] := '���������';
         Form1.GridPriority.Cells[0,2] := '���� �����';
         if TBarrier(node).m_Red=1 then
         metki :='a ';
         if TBarrier(node).m_Green=1 then
         metki :=metki+'b ';
         if TBarrier(node).m_Blue=1 then
         metki :=metki+'� ';
         Form1.GridPriority.Cells[b+1,2]:=metki;
         Inc(b);
         Form1.GridIncident.Cells[b,0] := node.m_Name;
         Form1.GridIngibit.Cells[b,0] := node.m_Name;
         for j := 0 to m_net.m_Links.Count - 1 do begin
            link := TLink(m_net.m_Links.Items[j]);
            if link.m_A = node then begin
               if link.m_B is TSlot then begin
                  k := m_net.m_Nodes.IndexOf(link.m_B);
                  while k <> 0 do begin
                     if TNode(m_net.m_Nodes.Items[k]) is TSlot then Inc(s1);
                     Dec(k);
                  end;
                  if link.Ingibit=0 then
                   begin
                   Form1.GridIngibit.Cells[b,s1] :='';
                   Form1.GridIncident.Cells[b,s1] :='+1 ('+link.WeightOfLink+')';
                   end else
                   begin
                   Form1.GridIncident.Cells[b,s1] :='';
                   Form1.GridIngibit.Cells[b,s1] :='+1 ('+link.WeightOfLink+')';
                   end;
                  if TNode(m_net.m_Nodes.Items[0]) is TSlot then s1 := 1
                  else s1 := 0;
               end;
            end;
         end;
      end
      else if node is TSlot then begin
         Form1.GridCapacity.Cells[s,0] := node.m_Name;
         Form1.GridCapacity.Cells[s,1] :=TSlot(node).m_Capacity;
         Form1.GridDelay.Cells[s,0] := node.m_Name;
         Form1.GridDelay.Cells[s,1] := IntToStr(TSlot(node).m_MX) + '#' + IntToStr(TSlot(node).m_DX);
         Form1.GridActive.Cells[s,0] := node.m_Name;
         Form1.GridActive.Cells[s,1] :=IntToStr(TSlot(node).m_Initial_red)+'a'+IntToStr(TSlot(node).m_Initial_green)+'b'+IntToStr(TSlot(node).m_Initial_blue)+'c';
         Inc(s);
         Form1.GridIncident.Cells[0,s] := node.m_Name;
         Form1.GridIngibit.Cells[0,s] := node.m_Name;
         for j := 0 to m_net.m_Links.Count - 1 do begin
            link := TLink(m_net.m_Links.Items[j]);
            if link.m_A = node then begin
               if link.m_B is TBarrier then begin
                  k := m_net.m_Nodes.IndexOf(link.m_B);
                  while k <> 0 do begin
                     if TNode(m_net.m_Nodes.Items[k]) is TBarrier then Inc(b1);
                     Dec(k);
                  end;
                  if link.Ingibit=0 then
                   begin
                   Form1.GridIngibit.Cells[b1,s] :='';
                   Form1.GridIncident.Cells[b1,s] :='-1 ('+link.WeightOfLink+')';
                   end else
                   begin
                   Form1.GridIncident.Cells[b1,s] :='';
                   Form1.GridIngibit.Cells[b1,s] :='-1 ('+link.WeightOfLink+')';
                   end;
                   if TNode(m_net.m_Nodes.Items[0]) is TBarrier then b1 := 1
                  else b1 := 0;
               end;
            end;
         end;
      end;
   end;
end;


procedure TMain.Button1Click(Sender: TObject);
begin
   GetTables;
   Form1.ShowModal;
end;

procedure TMain.Button2Click(Sender: TObject);
var
   node : TNode;
   b,s,l : Integer;
   i : Integer;
begin
   b := 0; s := 0; l :=0;
   for i := 0 to m_net.m_Nodes.Count - 1 do begin
      node := TNode(m_net.m_Nodes.Items[i]);
      if node is TBarrier then begin
         Inc(b);
         node.m_Name := 'T' + IntToStr(b);
      end
      else if node is TSlot then begin
         Inc(s);
         node.m_Name := 'P' + IntToStr(s);
      end;
      end;
   m_Net.Paint;
end;





procedure TMain.N13Click(Sender: TObject);
begin
shablon:='2P_T_P';
end;

procedure TMain.N14Click(Sender: TObject);
begin
shablon:='P_T_2P';
end;

procedure TMain.N15Click(Sender: TObject);
begin
shablon:='P_T_P';
end;

procedure TMain.N2PTPClick(Sender: TObject);
begin
shablon:='3P_T_2P';
end;

procedure TMain.N2TPTClick(Sender: TObject);
begin
shablon:='2P_T_2P';
end;

procedure TMain.N16Click(Sender: TObject);
var
  link : TLink;
  node : TNode;
  i : Integer;
begin
 if m_Net.m_Selected is TLink then begin
    link := TLink(m_Net.m_Selected);
    m_Net.Select(nil);
    m_Net.m_Links.Remove(link);
   end;
 if m_Net.m_Selected is TNode then begin
    node := TNode(m_Net.m_Selected);
    m_Net.Select(nil);
        with m_Net.m_Links do begin
          for i := Count - 1 downto 0 do begin
            link := TLink(Items[i]);
            if (link.m_A = node) or (link.m_B = node) then begin
              link.Invalidate;
              Remove(link);
            end;
          end;
        end;
        if m_SourceNode = node then m_SourceNode := nil;
        m_Net.m_Nodes.Remove(node);
      end;
end;

end.
