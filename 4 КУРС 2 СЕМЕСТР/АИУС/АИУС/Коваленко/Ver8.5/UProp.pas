unit UProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCore, StdCtrls, ExtCtrls, CheckLst;


type
  TProp = class(TForm)
    EditName: TLabeledEdit;
    EditMX: TLabeledEdit;
    EditDX: TLabeledEdit;
    EditCapacity: TLabeledEdit;
    EditState_red: TLabeledEdit;
    ButtonActions: TButton;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    EditPriority: TLabeledEdit;
    EditState_green: TLabeledEdit;
    CheckListBox1: TCheckListBox;
    Label1: TLabel;
    WeightOfLink: TLabeledEdit;
    CheckBox1: TCheckBox;
    procedure ButtonOkClick(Sender: TObject);
    procedure Prov(Sender: TObject);
    procedure Clear;
    
   public
    m_node : TNode;
    procedure RegetFields;
  end;



procedure ShowProp(node : TNode);


implementation

{$R *.dfm}


procedure TProp.RegetFields;
begin
  EditName.Text := m_node.m_Name;
  clear;
  if m_node is TSlot then begin
    EditName.Visible:=true;
    EditCapacity.Visible:=true;
    EditCapacity.Text := IntToStr(TSlot(m_node).m_Capacity);
    EditState_red.Visible:=true;
    EditState_green.Visible:=true;
    //EditState_blue.Visible:=true;
    EditState_red.Text := IntToStr(TSlot(m_node).m_Initial_red);
    EditState_green.Text := IntToStr(TSlot(m_node).m_Initial_green);
    //EditState_blue.Text := IntToStr(TSlot(m_node).m_Initial_blue);
    EditMX.Visible := true;
    EditMX.Text := IntToStr(TSlot(m_node).m_MX);
    EditDX.Visible:= true;
    EditDX.Text := IntToStr(TSlot(m_node).m_DX);
  end else if m_node is TBarrier then begin
    EditName.Visible:=true;
    EditPriority.Visible:=true;
    Label1.Visible:=true;
    ChecklistBox1.Visible:=true;
    EditMX.Visible := true;
    EditMX.Text := IntToStr(TBarrier(m_node).m_MX);
    EditDX.Visible := true;
    EditDX.Text := IntToStr(TBarrier(m_node).m_DX);
  end else if m_node is TLink then begin
    CheckBox1.Visible:=true;
    WeightOfLink.Visible:=true;

  end else if m_node is TBarrier then begin
    EditPriority.Enabled := true;
    EditPriority.Text := IntToStr(TBarrier(m_node).m_Priority);
  end;
end;


procedure TProp.ButtonOkClick(Sender: TObject);
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
  end;

  if m_node is TSlot then begin
    TSlot(m_node).m_Capacity := StrToInt(EditCapacity.Text);
  end;

  if m_node is TSlot then begin
    TSlot(m_node).m_Initial_red := StrToInt(EditState_red.Text);
    TSlot(m_node).m_Initial_green := StrToInt(EditState_green.Text);
    //TSlot(m_node).m_Initial_blue := StrToInt(EditState_blue.Text);
  end;

  if m_node is TBarrier then begin
    TBarrier(m_node).m_Priority := StrToInt(EditPriority.Text);
    TBarrier(m_node).m_Rred:=CheckListBox1.Checked[0];
    TBarrier(m_node).m_Ggreen:=CheckListBox1.Checked[1];
    //TBarrier(m_node).m_Blue:=CheckListBox1.Checked[2];
  end;

  if m_node is TLink then begin
    TLink(m_node).WeightOfLink:=WeightOfLink.Text;
    TLink(m_node).Ingibit:=CheckBox1.Checked;
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
    Prop.RegetFields;
    Prop.ShowModal;
  finally
    FreeAndNil(Prop);
  end;
end;

procedure TProp.Prov(Sender: TObject);
begin
//if StrToInt(EditCapacity.Text)<StrToInt(EditState_blue.Text)+StrToInt(EditState_red.Text)+StrToInt(EditState_green.Text) then
if StrToInt(EditCapacity.Text)<StrToInt(EditState_red.Text)+StrToInt(EditState_green.Text) then
showmessage('������������ ������� ������� ������ ���������� ������������� � ��� �����!!!');
end;

procedure TProp.Clear;
begin
EditName.Visible:=false;
EditMX.Visible:=false;
EditDX.Visible:=false;
EditCapacity.Visible:=false;
EditPriority.Visible:=false;
CheckBox1.Visible:=false;
CheckListBox1.Visible:=false;
Label1.Visible:=false;
WeightOfLink.Visible:=false;
EditState_red.Visible:=false;
EditState_green.Visible:=false;
//EditState_blue.Visible:=false;
ButtonActions.Visible:=false;
end;


end.
