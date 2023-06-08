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
    ButtonOk: TButton;
    ButtonCancel: TButton;
    EditUsl1: TLabeledEdit;
    EditUsl2: TLabeledEdit;
    EditP1: TLabeledEdit;
    EditP2: TLabeledEdit;
    EditP3: TLabeledEdit;
    EditUsl3: TLabeledEdit;
    BoxUsl1: TComboBox;
    BoxUsl2: TComboBox;
    BoxUsl3: TComboBox;
    EditP4: TLabeledEdit;
    EditP5: TLabeledEdit;
    Label1: TLabel;
    BoxUsl7: TComboBox;
    Label2: TLabel;
    BoxUsl8: TComboBox;
    procedure ButtonOkClick(Sender: TObject);
    procedure EditStateKeyPress(Sender: TObject; var Key: Char);

  public
    m_node : TNode;
    procedure RegetFields;
  end;


procedure ShowProp(node : TNode);


implementation

uses About;

{$R *.dfm}


procedure TProp.RegetFields;
begin

  EditName.Text := m_node.m_Name;
  EditUsl1.Enabled := false;
  EditUsl2.Enabled := false;
  EditUsl3.Enabled := false;
  EditP1.Enabled :=false;
  EditP2.Enabled :=false;
  EditP3.Enabled :=false;
  EditP4.Enabled :=false;
  EditP5.Enabled :=false;
  BoxUsl1.Enabled := false;
  BoxUsl2.Enabled := false;
  BoxUsl3.Enabled := false;
  Label1.Enabled := false;
  BoxUsl7.Enabled := false;
  Label2.Visible := false;
  BoxUsl8.Visible := false;
  if m_node is TBarrier then begin
    EditMX.Enabled := true;
    EditMX.Text := IntToStr(TBarrier(m_node).m_MX);
    EditDX.Enabled := true;
    EditDX.Text := IntToStr(TBarrier(m_node).m_DX);
  end else if m_node is TGenerator then begin
    EditMX.Enabled := true;
    EditMX.Text := IntToStr(TGenerator(m_node).m_MX);
    EditDX.Enabled := true;
    EditDX.Text := IntToStr(TGenerator(m_node).m_DX);
    EditP1.Text := IntToStr(TGenerator(m_node).m_P1);
    EditP2.Text := IntToStr(TGenerator(m_node).m_P2);
    EditP3.Text := IntToStr(TGenerator(m_node).m_P3);
    EditP4.Text := IntToStr(TGenerator(m_node).m_P4);
    EditP5.Text := IntToStr(TGenerator(m_node).m_P5);
    EditP1.Enabled :=true;
    EditP2.Enabled :=true;
    EditP3.Enabled :=true;
    EditP4.Enabled :=true;
    EditP5.Enabled :=true;
    Label1.Enabled := true;
    BoxUsl7.Enabled := true;
    BoxUsl7.ItemIndex :=TGenerator(m_node).m_ZUsl7;
    end else begin
    EditMX.Enabled := false;
    EditMX.Text := '';
    EditDX.Enabled := false;
    EditDX.Text := '';
  end;

  if m_node is TSlot then begin
    EditCapacity.Enabled := false;
    EditCapacity.Text := '1';
    EditMX.Enabled := true;
    EditMX.Text := IntToStr(TSlot(m_node).m_MX);
    EditDX.Enabled := true;
    EditDX.Text := IntToStr(TSlot(m_node).m_DX);
    if TSlot(m_node).m_Initial > 0 then begin
     EditP1.Text := IntToStr(TSlot(m_node).m_P1);
     EditP2.Text := IntToStr(TSlot(m_node).m_P2);
     EditP3.Text := IntToStr(TSlot(m_node).m_P3);
     EditP4.Text := IntToStr(TSlot(m_node).m_P4);
     EditP5.Text := IntToStr(TSlot(m_node).m_P5);
                                        end;

  end else if m_node is TQueue then begin
    Label1.Visible := false;
    BoxUsl7.Visible := false;
    Label2.Visible := true;
    BoxUsl8.Visible := true;
    BoxUsl8.ItemIndex :=TQueue(m_node).m_ZUsl8;
    EditCapacity.Enabled := true;
    EditCapacity.Text := IntToStr(TQueue(m_node).m_Capacity);
  end else begin
    EditCapacity.Enabled := false;
    EditCapacity.Text := '';
  end;

  if m_node is TSlot then begin
    EditState.Enabled := true;
    EditState.Text := IntToStr(TSlot(m_node).m_Initial);
    EditP1.Text := IntToStr(TSlot(m_node).m_P1);
    EditP2.Text := IntToStr(TSlot(m_node).m_P2);
    EditP3.Text := IntToStr(TSlot(m_node).m_P3);
    EditP4.Text := IntToStr(TSlot(m_node).m_P4);
    EditP5.Text := IntToStr(TSlot(m_node).m_P5);
    //if (TSlot(m_node).m_Initial<>0)
    // then  ButtonActions.Enabled:=True;
    m_node.Invalidate;
    TSlot(m_node).m_Initial := StrToInt(EditState.Text);
    m_node.Invalidate;
    //if (TSlot(m_node).m_Initial > 0 ) then begin
    EditP1.Enabled :=true;
    EditP2.Enabled :=true;
    EditP3.Enabled :=true;
    EditP4.Enabled :=true;
    EditP5.Enabled :=true;
    //end;

  end else if m_node is TQueue then begin
    EditState.Enabled := true;
    EditState.Text := IntToStr(TQueue(m_node).m_Initial);
  end else if m_node is TShaman then begin
    EditState.Enabled := true;
    EditState.Text := IntToStr(TShaman(m_node).m_State);
    EditUsl1.Enabled := true;
    EditUsl1.Text := '';
    EditUsl1.Text := TShaman(m_node).m_Usl1;
    EditUsl2.Enabled := true;
    EditUsl2.Text := '';
    EditUsl2.Text := TShaman(m_node).m_Usl2;
    EditUsl3.Enabled := true;
    EditUsl3.Text := '';
    EditUsl3.Text := TShaman(m_node).m_Usl3;
    BoxUsl1.Enabled :=true;
    BoxUsl1.ItemIndex :=TShaman(m_node).m_ZUsl1;
    BoxUsl2.Enabled :=true;
    BoxUsl2.ItemIndex :=TShaman(m_node).m_ZUsl2;
    BoxUsl3.Enabled :=true;
    BoxUsl3.ItemIndex :=TShaman(m_node).m_ZUsl3;
  end else begin
    EditState.Enabled := false;
    EditUsl1.Enabled := false;
    EditUsl2.Enabled := false;
    EditUsl3.Enabled := false;
    EditState.Text := '';
    EditUsl2.Text := '';
    EditUsl1.Text := '';
    EditUsl3.Text := '';
  end;
end;


procedure TProp.ButtonOkClick(Sender: TObject);
begin
  m_node.Invalidate;
  m_node.m_Name := EditName.Text;
  m_node.Invalidate;

  if m_node is TBarrier then begin
    TBarrier(m_node).m_MX := StrToInt(EditMX.Text);
    TBarrier(m_node).m_DX := StrToInt(EditDX.Text);
  end else if m_node is TGenerator then begin
    TGenerator(m_node).m_MX := StrToInt(EditMX.Text);
    TGenerator(m_node).m_DX := StrToInt(EditDX.Text);
    TGenerator(m_node).m_P1 := StrToInt(EditP1.Text);
    TGenerator(m_node).m_P2 := StrToInt(EditP2.Text);
    TGenerator(m_node).m_P3 := StrToInt(EditP3.Text);
    TGenerator(m_node).m_P4 := StrToInt(EditP4.Text);
    TGenerator(m_node).m_P5 := StrToInt(EditP5.Text);
    TGenerator(m_node).m_ZUsl7 := BoxUsl7.ItemIndex;
  end;

  if m_node is TQueue then begin
    TQueue(m_node).m_ZUsl8 := BoxUsl8.ItemIndex;
    TQueue(m_node).m_Capacity := StrToInt(EditCapacity.Text);
  end;

  if m_node is TSlot then begin
    TSlot(m_node).m_Initial := StrToInt(EditState.Text);
    TSlot(m_node).m_MX := StrToInt(EditMX.Text);
    TSlot(m_node).m_DX := StrToInt(EditDX.Text);
    if TSlot(m_node).m_Initial > 0 then begin
    TSlot(m_node).m_P1 := StrToInt(EditP1.Text);
    TSlot(m_node).m_P2 := StrToInt(EditP2.Text);
    TSlot(m_node).m_P3 := StrToInt(EditP3.Text);
    TSlot(m_node).m_P4 := StrToInt(EditP4.Text);
    TSlot(m_node).m_P5 := StrToInt(EditP5.Text);
                                        end;
  end else if m_node is TQueue then begin
    TQueue(m_node).m_Initial := StrToInt(EditState.Text);
  end else if m_node is TShaman then begin
    TShaman(m_node).m_State := StrToInt(EditState.Text);
    TShaman(m_node).m_ZUsl1 := BoxUsl1.ItemIndex;
    TShaman(m_node).m_ZUsl2 := BoxUsl2.ItemIndex;
    TShaman(m_node).m_ZUsl3 := BoxUsl3.ItemIndex;
    TShaman(m_node).m_Usl1 := EditUsl1.Text;
    TShaman(m_node).m_Usl2 := EditUsl2.Text;
    TShaman(m_node).m_Usl3 := EditUsl3.Text;
  end;

  ModalResult := mrOk;
end;


procedure ShowProp(node : TNode);
var
  Box : TScrollBox;
  Prop : TProp;
  Point : TPoint;
begin
  Box := node.m_Net.m_Box;
  Prop := TProp.Create(Box);
  try
    Point.X := node.m_Pos.X - Box.HorzScrollBar.Position;
    Point.Y := node.m_Pos.Y - Box.VertScrollBar.Position;
    Point := Box.ClientToScreen(Point);
    Prop.Left := Point.X + 16;
    Prop.Top := Point.Y + 16;
    Prop.m_node := node;
    if (node is TSlot) then begin
    //Prop.Height:= 250;
    //Prop.Width:=250;
    end;
    Prop.RegetFields;
    Prop.ShowModal;
  finally
    FreeAndNil(Prop);
  end;
end;




procedure TProp.EditStateKeyPress(Sender: TObject; var Key: Char);
begin
if (Key<'0') or (Key>'9') then Key:=#0;
end;

end.
