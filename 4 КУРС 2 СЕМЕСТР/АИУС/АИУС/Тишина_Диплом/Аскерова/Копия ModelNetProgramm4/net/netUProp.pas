unit netUProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, netUCore, StdCtrls, ExtCtrls;


type
  TnetProp = class(TForm)
    EditName: TLabeledEdit;
    EditMX: TLabeledEdit;
    EditDX: TLabeledEdit;
    EditCapacity: TLabeledEdit;
    EditState: TLabeledEdit;
    ButtonActions: TButton;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    EditPriority: TLabeledEdit;
    EditLamda: TLabeledEdit;
    EditFunc: TLabeledEdit;
    procedure ButtonOkClick(Sender: TObject);
  public
    m_node : TNode;
    procedure RegetFields;
  end;


procedure ShowProp(node : TNode);


implementation

{$R *.dfm}


procedure TnetProp.RegetFields;
begin
  EditName.Text := m_node.m_Name;

  if m_node is TSlot then begin
    EditMX.Enabled := true;
    EditMX.Text := IntToStr(TSlot(m_node).m_MX);
    EditDX.Enabled := true;
    EditDX.Text := IntToStr(TSlot(m_node).m_DX);
  end else if m_node is TBarrier then begin
    EditLamda.Enabled := true;                               //*******************************************
    EditLamda.Text := FloatToStr(TBarrier(m_node).m_Lamda);
    EditFunc.Enabled  := true;
    EditFunc.Text := FloatToStr(TBarrier(m_node).m_Func);

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
  end else begin
    EditPriority.Enabled := false;
    EditPriority.Text := '';
  end;
end;


procedure TnetProp.ButtonOkClick(Sender: TObject);
begin
  m_node.Invalidate;
  m_node.m_Name := EditName.Text;
  m_node.Invalidate;

  if m_node is TSlot then begin
    TSlot(m_node).m_MX := StrToInt(EditMX.Text);
    TSlot(m_node).m_DX := StrToInt(EditDX.Text);
  end else if m_node is TBarrier then begin
    TBarrier(m_node).m_Lamda := StrToFloat(EditLamda.Text);     //************
    TBarrier(m_node).m_Func := StrToFloat(EditFunc.Text);
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
  end else if m_node is TQueue then begin
    TQueue(m_node).m_Initial := StrToInt(EditState.Text);
  end else if m_node is TShaman then begin
    TShaman(m_node).m_State := StrToInt(EditState.Text);
  end;

  if m_node is TBarrier then begin
    TBarrier(m_node).m_Priority := StrToInt(EditPriority.Text);
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


end.
