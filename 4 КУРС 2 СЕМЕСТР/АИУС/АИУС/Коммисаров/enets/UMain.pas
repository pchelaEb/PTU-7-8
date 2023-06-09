unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ToolWin, ComCtrls, ImgList, UCore, StdCtrls,
  ActnList, StdActns, ActnMan, ActnCtrls, IniFiles, XPStyleActnCtrls;

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
    ButtonGo: TToolButton;
    ButtonVR1: TToolButton;
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
    ButtonYc: TToolButton;
    N14: TMenuItem;
    ButtonXq: TToolButton;
    N15: TMenuItem;
    MenuSaveAs: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    PanelInstrument: TMenuItem;
    DownPanel: TMenuItem;
    Element: TMenuItem;
    ToolBar1: TToolBar;
    StatusBar: TStatusBar;
    Panel1: TPanel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    Label2: TLabel;
    CBFon: TColorBox;
    Label3: TLabel;
    ColorBox1: TColorBox;
    Label4: TLabel;
    CBStr: TColorBox;
    StrSost: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    PrintDialog1: TPrintDialog;
    N20: TMenuItem;
    MenuClear: TMenuItem;
    N22: TMenuItem;
    MenuDelete: TMenuItem;
    MenuPrint: TMenuItem;
    N24: TMenuItem;
    GPSS1: TMenuItem;
    N26: TMenuItem;
    ToolButton11: TToolButton;
    N28: TMenuItem;
    MenuName: TMenuItem;
    Panel2: TPanel;
    Label5: TLabel;
    Bevel1: TBevel;
    ToolButton12: TToolButton;
    Timer: TTimer;
    N13: TMenuItem;
    N16: TMenuItem;
    N21: TMenuItem;
    N23: TMenuItem;
    N25: TMenuItem;
    N27: TMenuItem;
    N29: TMenuItem;
    ToolBar2: TToolBar;
    Shablon: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ToolButton10: TToolButton;
    procedure PaintBoxPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    procedure ButtonGoClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure ButtonYcClick(Sender: TObject);
    procedure ButtonXqClick(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure CBFonChange(Sender: TObject);
    procedure PanelInstrumentClick(Sender: TObject);
    procedure DownPanelClick(Sender: TObject);
    procedure ElementClick(Sender: TObject);
    procedure StrSostClick(Sender: TObject);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure MenuSaveAsClick(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure MenuPrintClick(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure MenuClearClick(Sender: TObject);
    procedure GPSS1Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure MenuDeleteClick(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure MenuNameClick(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure ShablonClick(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ButtonMVOClick(Sender: TObject);
  private
    // ����
    m_Net : TNet;
    // ������ ����
    m_SourceNode : TNode;
  end;


var
  Main: TMain;
  
implementation

{$R *.dfm}

uses
 About, Math, UProp, UView, UXq, Unit1, Unit2;


procedure TMain.PaintBoxPaint(Sender: TObject);
begin
  m_Net.Paint;
end;


procedure TMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  link : TLink;
  node : TNode;
  i : Integer;
begin
  if m_Net.m_Selected is TLink then begin
    link := TLink(m_Net.m_Selected);
    case Key of
      VK_DELETE : begin
        Key := 0;
        m_Net.Select(nil);
        m_Net.m_Links.Remove(link);
      end;
    end;
  end else if m_Net.m_Selected is TNode then begin
    node := TNode(m_Net.m_Selected);
    case Key of
      VK_DELETE : begin
        Key := 0;
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
      VK_RETURN : begin
        Key := 0;
        ShowProp(node);
      end;
      VK_LEFT : begin
        Key := 0;
        if ssCtrl in Shift then begin
          node.ChangePos(node.m_Pos.X - 128, node.m_Pos.Y);
        end else begin
          node.ChangePos(node.m_Pos.X - 16, node.m_Pos.Y);
        end;
      end;
      VK_RIGHT : begin
        Key := 0;
        if ssCtrl in Shift then begin
          node.ChangePos(node.m_Pos.X + 128, node.m_Pos.Y);
        end else begin
          node.ChangePos(node.m_Pos.X + 16, node.m_Pos.Y);
        end;
      end;
      VK_UP : begin
        Key := 0;
        if ssCtrl in Shift then begin
          node.ChangePos(node.m_Pos.X, node.m_Pos.Y - 64);
        end else begin
          node.ChangePos(node.m_Pos.X, node.m_Pos.Y - 16);
        end;
      end;
      VK_DOWN : begin
        Key := 0;
        if ssCtrl in Shift then begin
          node.ChangePos(node.m_Pos.X, node.m_Pos.Y + 64);
        end else begin
          node.ChangePos(node.m_Pos.X, node.m_Pos.Y + 16);
        end;
      end;
    end;
  end;
end;


procedure TMain.FormCreate(Sender: TObject);
begin

//���� ��� ��������� ��� ����� � ��������� ������ ���������
ScrollBox.Visible := false;
PaintBox.Visible := false;

m_Net := TNet.Create(PaintBox.Canvas, ScrollBox);

StatusBar.Panels[0].Text := ' ����� '+' : '+ TimeToStr(Time );
StatusBar.Panels[1].Text := ' ���� '+' : '+ DateToStr(Date);
StatusBar.Panels[3].Text := ' ������ 5.0 ';
StatusBar.Panels[4].Text := ' ���� � ���-�� �� �������, �������� ������ � ���� ������� ';

ToolButton10.Visible := false;
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(m_Net);
end;


procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if Application.MessageBox(PChar('�� ������������� ������ �����?'),
   '���������� ������',MB_YESNO+MB_ICONQUESTION)= idYes then begin
   Exit;
   end;
end;

//�������
procedure TMain.MenuNewClick(Sender: TObject);
begin
   if Application.MessageBox(PChar('������� ������?'),
   '��������',MB_YESNO+MB_ICONQUESTION)= idYes then begin
      m_Net.Clear;
      Main.Label5.Caption:='�������� ����� ������ :';

      ScrollBox.Visible := true;
      PaintBox.Visible := true;
   end
   else
   begin
      ScrollBox.Visible := false;
      PaintBox.Visible := false;
   end;
end;

//�������
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
    Main.Label5.Caption:='����������� ����������� ������ : ('+ OpenDialog.FileName+')';
  finally
    CloseFile(Reader);
  end;
end;

//���������
procedure TMain.MenuSaveClick(Sender: TObject);
var
  Writer : TextFile;
begin
  if (SaveDialog.FileName='')
  then begin
  SaveDialog.FileName := OpenDialog.FileName;
  if not SaveDialog.Execute then Exit;
  Main.Label5.Caption:='����������� ����������� ������ : ('+ SaveDialog.FileName+')';
  end

  else begin

  AssignFile(Writer, SaveDialog.FileName);
  Rewrite(Writer);
  try
    ButtonSelect.Down := true;
    m_Net.Save(Writer);
  finally
    CloseFile(Writer);
    Main.Label5.Caption:='����������� ����������� ������ : ('+ SaveDialog.FileName+')';
  end;
  end;
end;

//�����
procedure TMain.MenuQuitClick(Sender: TObject);
begin
   if Application.MessageBox(PChar('������� ������?'),
      '��������',MB_YESNO+MB_ICONQUESTION)= idYes then begin
      ScrollBox.Visible := false;
      PaintBox.Visible := false;
   end;
end;


procedure TMain.ButtonLinkClick(Sender: TObject);
begin
  m_Net.Select(nil);
  m_SourceNode := nil;
end;


procedure TMain.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  type

  a_TEntity=array of TEntity  ;
  p_a_TEntity=^a_TEntity;
var
  entity : TEntity;
  buff : TEntity;
  m_node : TEntity;
  link : TLink;
  i,j,k : Integer;
  a_entity :p_a_TEntity;
begin
  if ButtonSelect.Down then begin
    // ����� ������
    entity := m_Net.HitTest(X, Y);
    m_Net.Select(entity);
    if (Button = mbRight) and (entity is TNode) then begin
      ShowProp(TNode(entity));
    end;
  end else if Button = mbRight then begin
    // ������
    m_Net.Select(nil);
    ButtonSelect.Down := true;
  end else if Button = mbLeft then begin
    // ���������� ���������
    if ButtonBarrier.Down then
       m_Net.Select(TBarrier.Create(m_Net, X, Y, 1, 0));
    if ButtonSlot.Down then
       m_Net.Select(TSlot.Create(m_Net, X, Y, 0, 5, 1,0,0,0,0,0));
    if ButtonQueue.Down then m_Net.Select(TQueue.Create(m_Net, X, Y, 10, 0, 0));
    if ButtonGen.Down then m_Net.Select(TGenerator.Create(m_Net, X, Y, 100, 0,1,1,1,1,1,0));
    if ButtonMurder.Down then m_Net.Select(TMurder.Create(m_Net, X, Y));
    if ButtonShaman.Down then m_Net.Select(TShaman.Create(m_Net, X, Y, 0,1,1,1,'', '',''));
    if ButtonYc.Down then begin
       j:= StrToInt(ParamXq.EditKPoz.Text);
       m_Net.Select(TBarrier.Create(m_Net, X, Y, 1, 0));
       m_node:=m_Net.m_Selected;
       buff:=m_Net.m_Selected;
       m_Net.Select(TShaman.Create(m_Net, X-70, Y-j*20, 0,1,1,1, '', '',''));
       m_Net.Select(TLink.Create(m_Net,TNode(m_Net.m_Selected),TNode(buff)));
       m_Net.Select(TSlot.Create(m_Net, X+55, Y, 0, 5, 1,0,0,0,0,0));
       m_node:=m_Net.m_Selected;
       m_Net.m_Selected.Invalidate;
       m_node.Invalidate;
       m_Net.Select(TLink.Create(m_Net,TNode(buff), TNode(m_Net.m_Selected)));
       Y:=Y-j*20+40;
       X:=X-70;
       for k:=1 to j do begin
         m_Net.Select(TSlot.Create(m_Net, X, Y, 0, 5, 1,0,0,0,0,0));
         m_node:=m_Net.m_Selected;
         m_Net.m_Selected.Invalidate;
         m_node.Invalidate;
         m_Net.Select(TLink.Create(m_Net,TNode(m_Net.m_Selected),TNode(buff)));
         Y:=Y+40;
       end;
       ButtonYc.Down:=False;

       end;

    if ButtonXq.Down then begin
    j:= StrToInt(ParamXq.EditKPoz.Text);
    m_Net.Select(TBarrier.Create(m_Net, X+50, Y, 1, 0));
    m_node:=m_Net.m_Selected;
    m_node.Invalidate;
    buff:=m_Net.m_Selected;
    m_Net.Select(TShaman.Create(m_Net, X, Y-20, 0,1,1,1, '', '',''));
    m_Net.Select(TLink.Create(m_Net, TNode(m_Net.m_Selected),TNode(buff)));
    m_Net.Select(TSlot.Create(m_Net, X, Y+20, 0, 5, 1,0,0,0,0,0));
    m_node:=m_Net.m_Selected;
    m_Net.m_Selected.Invalidate;
    m_node.Invalidate;
    m_Net.Select(TLink.Create(m_Net,TNode(m_Net.m_Selected), TNode(buff)));
    Y:=Y-j*20+20;
    X:=X+5;
    for k:=1 to j do begin
         m_Net.Select(TSlot.Create(m_Net, X+110, Y, 0, 5, 1,0,0,0,0,0));
         m_node:=m_Net.m_Selected;
         m_node.Invalidate;
         m_Net.Select(TLink.Create(m_Net,TNode(buff),TNode(m_Net.m_Selected)));
         Y:=Y+40;
    end;
       ButtonXq.Down:=False;
    end;

    // ����������
    if ButtonLink.Down then begin
      entity := m_Net.HitTest(X, Y);
      if (entity = m_SourceNode) or not(entity is TNode) then Exit;
      if m_SourceNode = nil then begin
        if not TNode(entity).CanAddOutput then Exit;
        m_SourceNode := TNode(entity);
        m_Net.Select(entity);
      end else begin
        if not TNode(entity).CanAddInput then Exit;
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
        m_Net.Select(TLink.Create(m_Net, m_SourceNode, TNode(entity)));
        m_SourceNode := nil;
      end;
    end;
  end;
end;

//����������� ���������
procedure TMain.PaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) and ButtonSelect.Down and (m_Net.m_Selected is TNode) then begin
    TNode(m_Net.m_Selected).ChangePos(X, Y);
  end;
end;

//������ GPSS
procedure TMain.ButtonGoClick(Sender: TObject);
var
  GPSS : TGPSS;
  View : TView;
begin
main.StatusBar.Panels[4].TexT := '��������� ������ GPSS';
  GPSS := TGPSS.Create;
  try
    m_Net.Translate(GPSS);
    View := TView.Create(Self);
    try
      View.Memo.Lines.Assign(GPSS.m_Lines);
      View.ShowModal;
    finally
      FreeAndNil(View);
    end;
  finally
    FreeAndNil(GPSS);
  end;
  StatusBar.Panels[4].Text := ' ���� � ���-�� �� �������, �������� ������ � ���� ������� ';

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

procedure TMain.N12Click(Sender: TObject);
begin
 aboutbox.Show;
end;

procedure TMain.N14Click(Sender: TObject);
begin
ParamXq.Show;
ButtonYc.Down:=True;
end;

procedure TMain.ButtonYcClick(Sender: TObject);
begin
ParamXq.Show;
end;

procedure TMain.ButtonXqClick(Sender: TObject);
begin
ParamXq.Show;
end;

procedure TMain.N15Click(Sender: TObject);
begin
ParamXq.Show;
ButtonXq.Down:=True;
end;

procedure TMain.ToolButton5Click(Sender: TObject);
begin
   if Application.MessageBox(PChar('������� ������?'),
      '��������',MB_YESNO+MB_ICONQUESTION)= idYes then begin
      ScrollBox.Visible := false;
      PaintBox.Visible := false;
      Main.Label5.Caption:='�������� ����� ������ :';
   end;
end;

procedure TMain.CBFonChange(Sender: TObject);
begin
    Main.ScrollBox.Color:=CBFon.Selected;
end;

procedure TMain.PanelInstrumentClick(Sender: TObject);
begin
if  Main.PanelInstrument.Checked=true then
  begin
   Main.PanelInstrument.Checked:=false;
   ToolBar1.Visible:=false;
  end
 else
  begin
   Main.PanelInstrument.Checked:=true;
   ToolBar1.Visible:=true;
  end;
end;

procedure TMain.DownPanelClick(Sender: TObject);
begin
    if  Main.DownPanel.Checked=true then
  begin
   Main.DownPanel.Checked:=false;
   Panel1.Visible:=false;
  end
 else
  begin
   Main.DownPanel.Checked:=true;
   Panel1.Visible:=true;
  end;
end;

procedure TMain.ElementClick(Sender: TObject);
begin
if  Main.Element.Checked=true then
  begin
   Main.Element.Checked:=false;
   ToolBar.Visible:=false;
  end
 else
  begin
   Main.Element.Checked:=true;
   ToolBar.Visible:=true;
  end;
end;

procedure TMain.StrSostClick(Sender: TObject);
begin
 if  Main.StrSost.Checked=true then
  begin
   Main.StrSost.Checked:=false;
   StatusBar.Visible:=false;
  end
 else
  begin
   Main.StrSost.Checked:=true;
   StatusBar.Visible:=true;
  end;
end;

procedure TMain.ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
   //Main.ScrollBox.ScrollBy(scrg-(Main.ScrollBar1.Position),0);
   //scrg:=Main.ScrollBar1.Position ;
   //Main.StrelkaOut();
end;

procedure TMain.ToolButton1Click(Sender: TObject);
begin
   if Application.MessageBox(PChar('������� ������?'),
   '��������',MB_YESNO+MB_ICONQUESTION)= idYes then begin
      m_Net.Clear;
      Main.Label5.Caption:='�������� ����� ������ :';

      ScrollBox.Visible := true;
      PaintBox.Visible := true;
   end
   else
   begin
      ScrollBox.Visible := false;
      PaintBox.Visible := false;
   end;
end;

procedure TMain.ToolButton2Click(Sender: TObject);
var
  Reader : TextFile;
begin
  if not OpenDialog.Execute then Exit;
  AssignFile(Reader, OpenDialog.FileName);
  Reset(Reader);
  try
    ScrollBox.Visible := true;
    PaintBox.Visible := true;
    ButtonSelect.Down := true;
    m_Net.Clear;
    m_Net.Load(Reader);
    Main.Label5.Caption:='����������� ����������� ������ : ('+ OpenDialog.FileName+')';
  finally
    CloseFile(Reader);
end;

end;

procedure TMain.MenuSaveAsClick(Sender: TObject);
var
  Writer : TextFile;
begin
  SaveDialog.FileName := OpenDialog.FileName;
  if not SaveDialog.Execute then Exit;

  AssignFile(Writer, SaveDialog.FileName);
  Rewrite(Writer);
  try
    ButtonSelect.Down := true;
    m_Net.Save(Writer);
  finally
    CloseFile(Writer);
    Main.Label5.Caption:='����������� ����������� ������ : ('+ SaveDialog.FileName+')';
  end;
end;

procedure TMain.ToolButton4Click(Sender: TObject);
var
  Writer : TextFile;
begin
  SaveDialog.FileName := OpenDialog.FileName;
  if not SaveDialog.Execute then Exit;

  AssignFile(Writer, SaveDialog.FileName);
  Rewrite(Writer);
  try
    ButtonSelect.Down := true;
    m_Net.Save(Writer);
  finally
    CloseFile(Writer);
    Main.Label5.Caption:='����������� ����������� ������ : ('+ SaveDialog.FileName+')';
  end;
end;

procedure TMain.MenuPrintClick(Sender: TObject);
begin
  if not PrintDialog1.Execute then Exit;
  Print;
end;

procedure TMain.ToolButton6Click(Sender: TObject);
begin
   if Application.MessageBox(PChar('�������� �����?'),
      '��������',MB_YESNO+MB_ICONQUESTION)= idYes then begin
        m_Net.Clear;
        Main.Label5.Caption:='�������� ����� ������ :';
   end;
end;

procedure TMain.ToolButton3Click(Sender: TObject);
var
  Writer : TextFile;
begin
  if (SaveDialog.FileName='')
  then begin
  SaveDialog.FileName := OpenDialog.FileName;
  if not SaveDialog.Execute then Exit;
  Main.Label5.Caption:='����������� ����������� ������ : ('+ SaveDialog.FileName+')';
  end

  else begin

  AssignFile(Writer, SaveDialog.FileName);
  Rewrite(Writer);
  try
    ButtonSelect.Down := true;
    m_Net.Save(Writer);
  finally
    CloseFile(Writer);
    Main.Label5.Caption:='����������� ����������� ������ : ('+ SaveDialog.FileName+')';
  end;
  end;
end;

procedure TMain.ToolButton9Click(Sender: TObject);
begin
  if not PrintDialog1.Execute then Exit;
  Print;
end;

procedure TMain.ToolButton10Click(Sender: TObject);
begin
 main.StatusBar.Panels[4].Text := '���������� �������';
 Graf.ShowModal;
 StatusBar.Panels[4].Text := ' ���� � ���-�� �� �������, �������� ������ � ���� ������� ';
end;

procedure TMain.ToolButton8Click(Sender: TObject);
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

procedure TMain.MenuClearClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('�������� �����?'),
   '��������',MB_YESNO+MB_ICONQUESTION)= idYes then begin
    m_Net.Clear;
    Main.Label5.Caption:='�������� ����� ������ :';
end;
end;
procedure TMain.GPSS1Click(Sender: TObject);
var
  GPSS : TGPSS;
  View : TView;
begin
main.StatusBar.Panels[4].TexT := '��������� ������ GPSS';
  GPSS := TGPSS.Create;
  try
    m_Net.Translate(GPSS);
    View := TView.Create(Self);
    try
      View.Memo.Lines.Assign(GPSS.m_Lines);
      View.ShowModal;
    finally
      FreeAndNil(View);
    end;
  finally
    FreeAndNil(GPSS);
  end;
  StatusBar.Panels[4].Text := ' ���� � ���-�� �� �������, �������� ������ � ���� ������� ';

end;

procedure TMain.N27Click(Sender: TObject);
var
  Reader : TextFile;
  WorkDirectory : string;
begin
  WorkDirectory:=GetCurrentDir;
  AssignFile(Reader, WorkDirectory + '\�������\�����.grf');
  Reset(Reader);
  try
    ButtonSelect.Down := true;
    m_Net.Clear;
    ScrollBox.Visible := true;
    PaintBox.Visible := true;
    m_Net.Load(Reader);
    Main.Label5.Caption:='����������� ����������� ������ : (������ ������������� ������������ � ���������� ������)';
  finally
    CloseFile(Reader);
  end;
end;

procedure TMain.MenuDeleteClick(Sender: TObject);
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

procedure TMain.ToolButton11Click(Sender: TObject);
var
   node : TNode;
   b,s,l,g,r,m,q : Integer;
   i : Integer;
begin
   b := 0; s := 0; l :=0; g :=0; r :=0; m :=0; q :=0;
   for i := 0 to m_net.m_Nodes.Count - 1 do begin
      node := TNode(m_net.m_Nodes.Items[i]);
      if node is TBarrier then begin
         Inc(b);
         node.m_Name := 'T' + IntToStr(b);
      end
      else if node is TSlot then begin
         Inc(s);
         node.m_Name := 'P' + IntToStr(s);
      end
      else if node is TGenerator then begin
         Inc(g);
         Node.m_Name := 'G' + IntToStr(g);
      end
      else if node is TShaman then begin
         Inc(r);
         Node.m_Name := 'R' + IntToStr(r);
      end
      else if node is TMurder then begin
         Inc(m);
         Node.m_Name := 'A' + IntToStr(m);
      end
      else if node is TQueue then begin
         Inc(q);
         Node.m_Name := 'Q' + IntToStr(q);
      end;
      end;
   m_Net.Paint;
end;

procedure TMain.MenuNameClick(Sender: TObject);
var
   node : TNode;
   b,s,l,g,r,m,q : Integer;
   i : Integer;
begin
   b := 0; s := 0; l :=0; g :=0; r :=0; m :=0; q :=0;
   for i := 0 to m_net.m_Nodes.Count - 1 do begin
      node := TNode(m_net.m_Nodes.Items[i]);
      if node is TBarrier then begin
         Inc(b);
         node.m_Name := 'T' + IntToStr(b);
      end
      else if node is TSlot then begin
         Inc(s);
         node.m_Name := 'P' + IntToStr(s);
      end
      else if node is TGenerator then begin
         Inc(g);
         Node.m_Name := 'G' + IntToStr(g);
      end
      else if node is TShaman then begin
         Inc(r);
         Node.m_Name := 'R' + IntToStr(r);
      end
      else if node is TMurder then begin
         Inc(m);
         Node.m_Name := 'A' + IntToStr(m);
      end
      else if node is TQueue then begin
         Inc(q);
         Node.m_Name := 'Q' + IntToStr(q);
      end;
      end;
   m_Net.Paint;
end;

// �������� �� ������
procedure TMain.ToolButton12Click(Sender: TObject);
var
  node : TNode;
  link : TLink;
   i, j : integer;
begin
if Application.MessageBox(PChar('�������� ���� �� ������ ���������� �������������!'),
   '�������� �� ������',MB_OK+MB_ICONQUESTION)= idYes then begin
    Exit;
    end;
end;

procedure TMain.FormShow(Sender: TObject);
begin
 Zastavka.ShowModal;
end;

procedure TMain.N13Click(Sender: TObject);
begin
  Winhelp(Handle,'help.hlp',HELP_FINDER,0);
end;

procedure TMain.N16Click(Sender: TObject);
begin
  Application.HelpFile:=ExtractFilePath(Application.ExeName)+'������ ��� ������\help.hlp';
  Application.HelpCommand(HELP_FINDER,0);
end;

procedure TMain.ShablonClick(Sender: TObject);
begin
if  Main.Shablon.Checked=true then
  begin
   Main.Shablon.Checked:=false;
   ToolBar2.Visible:=false;
  end
 else
  begin
   Main.Shablon.Checked:=true;
   ToolBar2.Visible:=true;
  end;
end;


procedure TMain.N23Click(Sender: TObject);
var
  Reader : TextFile;
  WorkDirectory : string;
begin
  WorkDirectory:=GetCurrentDir;
  AssignFile(Reader, WorkDirectory + '\�������\���.grf');
  Reset(Reader);
  try
    ButtonSelect.Down := true;
    m_Net.Clear;
    ScrollBox.Visible := true;
    PaintBox.Visible := true;
    Main.Label5.Caption:='����������� ����������� ������ : (������ ����������� ������������)';
    m_Net.Load(Reader);
  finally
    CloseFile(Reader);
  end;
end;

procedure TMain.N29Click(Sender: TObject);
var
  Reader : TextFile;
  WorkDirectory : string;
begin
  WorkDirectory:=GetCurrentDir;
  AssignFile(Reader, WorkDirectory + '\�������\������.grf');
  Reset(Reader);
  try
    ButtonSelect.Down := true;
    m_Net.Clear;
    ScrollBox.Visible := true;
    PaintBox.Visible := true;
    m_Net.Load(Reader);
    Main.Label5.Caption:='����������� ����������� ������ : (������ ������������� ������������ �� ���������� ����� �������)';
  finally
    CloseFile(Reader);
  end;
end;
procedure TMain.N25Click(Sender: TObject);
var
  Reader : TextFile;
  WorkDirectory : string;
begin
  WorkDirectory:=GetCurrentDir;
  AssignFile(Reader, WorkDirectory + '\�������\�����.grf');
  Reset(Reader);
  try
    ButtonSelect.Down := true;
    m_Net.Clear;
    ScrollBox.Visible := true;
    PaintBox.Visible := true;
    m_Net.Load(Reader);
    Main.Label5.Caption:='����������� ����������� ������ : (������ ����������� ������������ � ���������� ������)';
  finally
    CloseFile(Reader);
  end;
end;

procedure TMain.Button1Click(Sender: TObject);
var
  Reader : TextFile;
  WorkDirectory : string;
begin
  WorkDirectory:=GetCurrentDir;
  AssignFile(Reader, WorkDirectory + '\�������\���.grf');
  Reset(Reader);
  try
    ButtonSelect.Down := true;
    m_Net.Clear;
    ScrollBox.Visible := true;
    PaintBox.Visible := true;
    Main.Label5.Caption:='����������� ����������� ������ : (������ ����������� ������������)';
    m_Net.Load(Reader);
  finally
    CloseFile(Reader);
  end;
end;

procedure TMain.Button2Click(Sender: TObject);
var
  Reader : TextFile;
  WorkDirectory : string;
begin
  WorkDirectory:=GetCurrentDir;
  AssignFile(Reader, WorkDirectory + '\�������\�����.grf');
  Reset(Reader);
  try
    ButtonSelect.Down := true;
    m_Net.Clear;
    ScrollBox.Visible := true;
    PaintBox.Visible := true;
    m_Net.Load(Reader);
    Main.Label5.Caption:='����������� ����������� ������ : (������ ����������� ������������ � ���������� ������)';
  finally
    CloseFile(Reader);
  end;
end;


procedure TMain.Button3Click(Sender: TObject);
var
  Reader : TextFile;
  WorkDirectory : string;
begin
  WorkDirectory:=GetCurrentDir;
  AssignFile(Reader, WorkDirectory + '\�������\�����.grf');
  Reset(Reader);
  try
    ButtonSelect.Down := true;
    m_Net.Clear;
    ScrollBox.Visible := true;
    PaintBox.Visible := true;
    m_Net.Load(Reader);
    Main.Label5.Caption:='����������� ����������� ������ : (������ ������������� ������������ � ���������� ������)';
  finally
    CloseFile(Reader);
  end;
end;

procedure TMain.Button4Click(Sender: TObject);
var
  Reader : TextFile;
  WorkDirectory : string;
begin
  WorkDirectory:=GetCurrentDir;
  AssignFile(Reader, WorkDirectory + '\�������\������.grf');
  Reset(Reader);
  try
    ButtonSelect.Down := true;
    m_Net.Clear;
    ScrollBox.Visible := true;
    PaintBox.Visible := true;
    m_Net.Load(Reader);
    Main.Label5.Caption:='����������� ����������� ������ : (������ ������������� ������������ �� ���������� ����� �������)';
  finally
    CloseFile(Reader);
  end;
end;

procedure TMain.ButtonMVOClick(Sender: TObject);
var
  Reader : TextFile;
  WorkDirectory : string;
begin
  WorkDirectory:=GetCurrentDir;
  AssignFile(Reader, WorkDirectory + '\�������\���.grf');
  Reset(Reader);
  try
    ButtonSelect.Down := true;
    m_Net.Clear;
    ScrollBox.Visible := true;
    PaintBox.Visible := true;
    Main.Label5.Caption:='����������� ����������� ������ : (������ ����������� ������������)';
    m_Net.Load(Reader);
  finally
    CloseFile(Reader);
  end;
end;

end.
