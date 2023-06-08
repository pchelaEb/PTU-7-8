unit netUProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, netUCore, StdCtrls, ExtCtrls, Grids, Spin, ComCtrls;


type
  TnetProp = class(TForm)
    EditName: TLabeledEdit;
    EditMX: TLabeledEdit;
    EditDX: TLabeledEdit;
    EditCapacity: TLabeledEdit;
    EditState: TLabeledEdit;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    EditPriority: TLabeledEdit;
    EditPorog: TLabeledEdit;
    EditTimeLive: TLabeledEdit;
    Label1: TLabel;
    EditPot: TLabeledEdit;
    Label2: TLabel;
    GridMetka: TStringGrid;
    Remake: TCheckBox;
    Mines: TCheckBox;
    procedure ButtonOkClick(Sender: TObject);
    procedure EditStateChange(Sender: TObject);
  public
    m_node : TNode;
    procedure RegetFields;
  end;


procedure ShowProp(node : TNode);


implementation

{$R *.dfm}


procedure TnetProp.RegetFields;
var i, m : Integer;
begin
  EditName.Text := m_node.m_Name;

  if m_node is TSlot then begin
    EditMX.Enabled := true;
    EditMX.Text := IntToStr(TSlot(m_node).m_MX);
    EditDX.Enabled := true;
    EditDX.Text := IntToStr(TSlot(m_node).m_DX);
  end else if m_node is TBarrier then begin
    EditMX.Enabled := true;
    EditMX.Text := IntToStr(TBarrier(m_node).m_MX);
    EditDX.Enabled := true;
    EditDX.Text := IntToStr(TBarrier(m_node).m_DX);
  end else if m_node is TGenerator then begin
    EditMX.Enabled := true;
    EditMX.Text := IntToStr(TGenerator(m_node).m_MX);
    EditDX.Enabled := true;
    EditDX.Text := IntToStr(TGenerator(m_node).m_DX);
  end else begin
    EditMX.Enabled := false;
    EditMX.Text := '';
    EditDX.Enabled := false;
    EditDX.Text := '';
  end;

  if m_node is TSlot then begin
    EditCapacity.Enabled := true;
    EditCapacity.Text := IntToStr(TSlot(m_node).m_Capacity);
  end else if m_node is TQueue then begin
    EditCapacity.Enabled := true;
    EditCapacity.Text := IntToStr(TQueue(m_node).m_Capacity);
  end else begin
    EditCapacity.Enabled := false;
    EditCapacity.Text := '';
  end;

  if m_node is TSlot then begin
    EditState.Enabled := true;
    EditState.Text := IntToStr(TSlot(m_node).m_Initial);

    GridMetka.ColCount:=TSlot(m_node).m_Initial;
    for i:=0 to TSlot(m_node).m_Initial-1 do
     GridMetka.Cells[i,0]:=FloatToStr(TSlot(m_node).m_Metki[i]);


  end else if m_node is TQueue then begin
    EditState.Enabled := true;
    EditState.Text := IntToStr(TQueue(m_node).m_Initial);
  end else if m_node is TShaman then begin
    EditState.Enabled := true;
    EditState.Text := IntToStr(TShaman(m_node).m_State);
  end else begin
    EditState.Enabled := false;
    EditState.Text := '';
  end;

  if m_node is TBarrier then begin
    EditPriority.Enabled := true;
    EditPriority.Text := IntToStr(TBarrier(m_node).m_Priority);
    EditPorog.Enabled := true;
    EditPorog.Text := IntToStr(TBarrier(m_node).m_Porog);
    EditPot.Enabled := true;
    EditPot.Text := FloatToStr (TBarrier(m_node).m_Pot);
    //ButtonActions.Enabled := true;

  end else begin
    EditPriority.Enabled := false;
    EditPriority.Text := '';
    EditPorog.Enabled := false;
    EditPorog.Text := '';
    EditPot.Enabled := false;
    EditPot.Text := '';
  end;

  if m_node is TSlot then begin
   EditTimeLive.Enabled := true;
   EditTimeLive.Text := IntToStr(TSlot(m_node).m_TimeLive);
   Remake.Enabled := true;
   Remake.Checked := TSlot(m_node).m_Remake;
   Mines.Checked := true;
   Mines.Checked := TSlot(m_node).m_Mines;
  end else begin
   EditTimeLive.Enabled := false;
   EditTimeLive.Text := '';
   Remake.Enabled := false;
   Remake.Checked := false;
   Mines.Checked := false;
   Mines.Enabled := false;
  end;
end;


procedure TnetProp.ButtonOkClick(Sender: TObject);
var i:word;
begin
  m_node.Invalidate;
  m_node.m_Name := EditName.Text;
  m_node.Invalidate;

  if m_node is TSlot then begin
    TSlot(m_node).m_MX := StrToInt(EditMX.Text);
    TSlot(m_node).m_DX := StrToInt(EditDX.Text);
  end else if m_node is TBarrier then begin
    TBarrier(m_node).m_MX := StrToInt(EditMX.Text);
    TBarrier(m_node).m_DX := StrToInt(EditDX.Text);
  end else if m_node is TGenerator then begin
    TGenerator(m_node).m_MX := StrToInt(EditMX.Text);
    TGenerator(m_node).m_DX := StrToInt(EditDX.Text);
  end;

  if m_node is TSlot then begin
    TSlot(m_node).m_Capacity := StrToInt(EditCapacity.Text);
  end else if m_node is TQueue then begin
    TQueue(m_node).m_Capacity := StrToInt(EditCapacity.Text);
  end;

  if m_node is TSlot then begin
    TSlot(m_node).m_Initial := StrToInt(EditState.Text);
    SetLength(TSlot(m_node).m_Metki,TSlot(m_node).m_Initial);

    if TSlot(m_node).m_Initial>0 then begin
    for i:=0 to TSlot(m_node).m_Initial-1 do
     TSlot(m_node).m_Metki[i]:=StrToFloat(GridMetka.Cells[i,0]);
    end;
    TSlot(m_node).m_Remake := Remake.Checked;
    TSlot(m_node).m_Mines := Mines.Checked;
  end else if m_node is TQueue then begin
    TQueue(m_node).m_Initial := StrToInt(EditState.Text);
  end else if m_node is TShaman then begin
    TShaman(m_node).m_State := StrToInt(EditState.Text);
  end;

  if m_node is TBarrier then begin
    TBarrier(m_node).m_Priority := StrToInt(EditPriority.Text);
    TBarrier(m_node).m_Porog := StrToInt(EditPorog.Text);
    TBarrier(m_node).m_Pot := StrToFloat(EditPot.Text);
  end;

  if m_node is TSlot then begin
    TSlot(m_node).m_TimeLive := StrToInt(EditTimeLive.Text);
  end;

  ModalResult := mrOk;
end;


procedure ShowProp(node : TNode);
var
  Box : TScrollBox;
  Prop : TnetProp;
  Point : TPoint;
begin
  Box := node.m_Net.m_Box;
  Prop := TnetProp.Create(Box);
  try
    Point.X := node.m_Pos.X - Box.HorzScrollBar.Position;
    Point.Y := node.m_Pos.Y - Box.VertScrollBar.Position;
    Point := Box.ClientToScreen(Point);
    Prop.Left := Point.X + 16;
    Prop.Top := Point.Y + 16;
    Prop.m_node := node;
    Prop.RegetFields;
    Prop.ShowModal;
  finally
    FreeAndNil(Prop);
  end;
end;



procedure TnetProp.EditStateChange(Sender: TObject);
const m=1000000;
var i:word;
begin
 TSlot(m_node).m_Initial := StrToInt(EditState.Text);
 GridMetka.ColCount := TSlot(m_node).m_Initial;
 randomize;
 if TSlot(m_node).m_Initial>0 then
  for i:=0 to TSlot(m_node).m_Initial-1 do
   if GridMetka.Cells[i,0]='' then begin
     if Mines.Checked then GridMetka.Cells[i,0]:=FloatToStr((random(m-1)+1)/-m)
     else  GridMetka.Cells[i,0]:=FloatToStr((random(m-1)+1)/m);
end;
     end;
end.
