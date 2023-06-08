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
    Label1: TLabel;
    C1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
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
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
  private
    // Сеть
    m_Net : TNet;
    // Начало дуги
    m_SourceNode : TNode;
  end;


var
  Main: TMain;


implementation

{$R *.dfm}

uses
 About, Math, UProp, UView;


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
  m_Net := TNet.Create(PaintBox.Canvas, ScrollBox);
end;


procedure TMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(m_Net);
end;


procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('Вы действительно хотите выйти из программы?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;


procedure TMain.MenuNewClick(Sender: TObject);
begin
  if MessageDlg('Очистить сеть?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
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
  entity : TEntity;
  link : TLink;
  i : Integer;
begin
  if ButtonSelect.Down then begin
    // Режим выбора
    entity := m_Net.HitTest(X, Y);
    m_Net.Select(entity);
    if (Button = mbRight) and (entity is TNode) then begin
      ShowProp(TNode(entity));
    end;
  end else if Button = mbRight then begin
    // Отмена
    m_Net.Select(nil);
    ButtonSelect.Down := true;
  end else if Button = mbLeft then begin
    // Сотворение
    if ButtonBarrier.Down then m_Net.Select(TBarrier.Create(m_Net, X, Y, 1, 0));
    if ButtonSlot.Down then m_Net.Select(TSlot.Create(m_Net, X, Y, 0));
    if ButtonQueue.Down then m_Net.Select(TQueue.Create(m_Net, X, Y, 10, 0));
    if ButtonGen.Down then m_Net.Select(TGenerator.Create(m_Net, X, Y, 100, 0));
    if ButtonMurder.Down then m_Net.Select(TMurder.Create(m_Net, X, Y));
    if ButtonShaman.Down then m_Net.Select(TShaman.Create(m_Net, X, Y, 0));

    // Связывание
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


procedure TMain.PaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  // Перемещение
  if (ssLeft in Shift) and ButtonSelect.Down and (m_Net.m_Selected is TNode) then begin
    TNode(m_Net.m_Selected).ChangePos(X, Y);
  end;
end;


procedure TMain.ButtonGoClick(Sender: TObject);
var
  GPSS : TGPSS;
  View : TView;
begin
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
 // вывести справочную информацию
  Winhelp(Handle,'help.hlp',HELP_FINDER,0);
end;

procedure TMain.N12Click(Sender: TObject);
begin
 aboutbox.Show;
end;

end.
