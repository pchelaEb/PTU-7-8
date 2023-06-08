unit UProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCore, StdCtrls, ExtCtrls;


type
  TProp = class(TForm)
    EditName: TLabeledEdit;
    EditMX: TLabeledEdit;
    EditDX: TLabeledEdit;
    EditCapacity: TLabeledEdit;
    EditState: TLabeledEdit;
    ButtonActions: TButton;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    EditPriority: TLabeledEdit;
    procedure ButtonOkClick(Sender: TObject);
  public
    m_node : TNode;
    m_link : TLink;
    procedure RegetFields;
  end;


procedure ShowProp(node : TNode; link : TLink);


implementation

{$R *.dfm}


procedure TProp.RegetFields;
begin
  if m_node <> nil then begin
    EditName.Enabled := true;
    EditName.Text := m_node.m_Name
  end else begin
    EditName.Enabled := false;
    EditName.Text := '';
  end;

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

  if m_link is TLink then begin
    EditCapacity.Enabled := true;
    EditCapacity.EditLabel.Caption := 'Вес дуги';
    EditCapacity.Text := IntToStr(TLink(m_link).m_Capacity);
  end else if m_node is TSlot then begin
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


procedure TProp.ButtonOkClick(Sender: TObject);
begin
  if m_node <> nil then begin
    m_node.Invalidate;
    m_node.m_Name := EditName.Text;
    m_node.Invalidate;
  end else
    m_link.Invalidate;

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

  if m_link is TLink then begin
    if StrToInt(EditCapacity.Text) >= 0 then
      TLink(m_link).m_Capacity := StrToInt(EditCapacity.Text)
    else begin
      EditCapacity.SetFocus;
      Exit;
    end;
  end else if m_node is TSlot then begin
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


procedure ShowProp(node : TNode; link : TLink);
var
  Box : TScrollBox;
  Prop : TProp;
  Point : TPoint;
begin
  if node <> nil then
    Box := node.m_Net.m_Box
  else
    Box := link.m_Net.m_Box;
  Prop := TProp.Create(Box);
  try
    if node <> nil then begin
      Point.X := node.m_Pos.X - Box.HorzScrollBar.Position;
      Point.Y := node.m_Pos.Y - Box.VertScrollBar.Position;
    end else begin
      Point.X := (link.m_A.m_Pos.X + link.m_B.m_Pos.X) shr 1 - Box.HorzScrollBar.Position;
      Point.Y := (link.m_A.m_Pos.Y + link.m_B.m_Pos.Y) shr 1 - Box.VertScrollBar.Position; 
    end;
    Point := Box.ClientToScreen(Point);
    Prop.Left := Point.X + 16;
    Prop.Top := Point.Y + 16;
    if node <> nil then
      Prop.m_node := node
    else
      Prop.m_link := link;
    Prop.RegetFields;
    Prop.ShowModal;
  finally
    FreeAndNil(Prop);
  end;
end;


end.
