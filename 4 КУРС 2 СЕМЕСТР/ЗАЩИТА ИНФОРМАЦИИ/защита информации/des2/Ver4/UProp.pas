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
    EditState_blue: TLabeledEdit;
    CheckListBox1: TCheckListBox;
    Label1: TLabel;
    WeightOfLink: TLabeledEdit;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    procedure ButtonOkClick(Sender: TObject);
    procedure Prov;
    procedure Clear;

   public
      k:string;
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
    EditCapacity.Text := TSlot(m_node).m_Capacity;
    Label2.Visible:=true;
    EditState_red.Visible:=true;
    EditState_green.Visible:=true;
    EditState_blue.Visible:=true;
    EditState_red.Text := IntToStr(TSlot(m_node).m_Initial_red);
    EditState_green.Text := IntToStr(TSlot(m_node).m_Initial_green);
    EditState_blue.Text := IntToStr(TSlot(m_node).m_Initial_blue);
    EditMX.Visible := true;
    EditMX.Text := IntToStr(TSlot(m_node).m_MX);
    EditDX.Visible:= true;
    EditDX.Text := IntToStr(TSlot(m_node).m_DX);
  end else if m_node is TBarrier then begin
    EditName.Visible:=true;
    EditPriority.Visible:=true;
    Label1.Visible:=true;
    ChecklistBox1.Visible:=true;
    if TBarrier(m_node).m_Red=1 then CheckListBox1.Checked[0]:=true else CheckListBox1.Checked[0]:=false;
    if TBarrier(m_node).m_green=1 then CheckListBox1.Checked[1]:=true else CheckListBox1.Checked[1]:=false;
    if TBarrier(m_node).m_blue=1 then CheckListBox1.Checked[2]:=true else CheckListBox1.Checked[2]:=false;
    EditMX.Visible := true;
    EditMX.Text := IntToStr(TBarrier(m_node).m_MX);
    EditDX.Visible := true;
    EditDX.Text := IntToStr(TBarrier(m_node).m_DX);
    EditPriority.Enabled := true;
    EditPriority.Text := IntToStr(TBarrier(m_node).m_Priority);
  end else if m_node is TGenerator then begin
    EditMX.Visible := true;
    EditMX.Text := IntToStr(TGenerator(m_node).m_MX);
    EditDX.Visible:= true;
    EditDX.Text := IntToStr(TGenerator(m_node).m_DX);
    EditName.Visible:=true;
  end else if m_node is TLink then begin
    CheckBox1.Visible:=true;
    WeightOfLink.Visible:=true;
    WeightOfLink.Text:=TLink(m_node).WeightOfLink;
    if TLink(m_node).Ingibit=1 then CheckBox1.Checked:=true else CheckBox1.Checked:=false;
  end else if m_node is TQueue then begin
    EditName.Visible:=true;
    EditCapacity.Visible := true;
    EditCapacity.Text := TQueue(m_node).m_Capacity;
    Label2.Visible:=true;
    EditState_red.Visible:=true;
    EditState_green.Visible:=true;
    EditState_blue.Visible:=true;
    EditState_red.Text := IntToStr(TSlot(m_node).m_Initial_red);
    EditState_green.Text := IntToStr(TSlot(m_node).m_Initial_green);
    EditState_blue.Text := IntToStr(TSlot(m_node).m_Initial_blue);
  end else if m_node is TShaman then begin
    EditName.Visible:=true;
    Label2.Visible:=true;
    EditState_red.Visible:=true;
    EditState_green.Visible:=true;
    EditState_blue.Visible:=true;
    EditState_red.Text := IntToStr(TShaman(m_node).m_Initial_red);
    EditState_green.Text := IntToStr(TShaman(m_node).m_Initial_green);
    EditState_blue.Text := IntToStr(TShaman(m_node).m_Initial_blue);
  end else if m_node is TMurder then begin
   EditName.Visible:=true;
  end;
end;

procedure TProp.Prov;
const a='a';b='b';c='c';
var
red, green, blue, st1, st2:integer;
stroka1, stroka2, stroka3:string;
begin
red:=0;
green:=0;
blue:=0;
st1:=0;
st2:=0;
if LastDelimiter(a, EditCapacity.Text)<>0 then
begin
stroka1:=Copy(EditCapacity.Text,1,Length(EditCapacity.Text));
Delete(stroka1,LastDelimiter(a,stroka1),Length(stroka1));
st1:=Length(stroka1)+1;
red:=strtoint(stroka1);
end else
stroka1:='';
if LastDelimiter(b, EditCapacity.Text)<>0 then
begin
stroka2:=Copy(EditCapacity.Text,1,Length(EditCapacity.Text));
Delete(stroka2,1,st1);
Delete(stroka2,LastDelimiter(b,stroka2),Length(stroka2));
st2:=Length(stroka2)+1;
green:=strtoint(stroka2);
end else
stroka2:='';
if LastDelimiter(c, EditCapacity.Text)<>0 then
begin
stroka3:=Copy(EditCapacity.Text,1,Length(EditCapacity.Text));
Delete(stroka3,1,st1+st2);
Delete(stroka3,LastDelimiter(c,stroka3),Length(stroka3));
blue:=strtoint(stroka3);
end;
if ((red<strtoint(EditState_red.Text))or(green<strtoint(EditState_green.Text))or(blue<strtoint(EditState_blue.Text)))
then begin
k:='0';
showmessage('Начальная маркировка больше максимальной ёмкости');
end;
end;

procedure TProp.ButtonOkClick(Sender: TObject);
begin
  k:='1';
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
    TSlot(m_node).m_Capacity := EditCapacity.Text;
  end else if m_node is TQueue then begin
    TQueue(m_node).m_Capacity :=EditCapacity.Text;
  end;

  if m_node is TSlot then begin
    Prov;
    TSlot(m_node).m_Initial_red := StrToInt(EditState_red.Text);
    TSlot(m_node).m_Initial_green := StrToInt(EditState_green.Text);
    TSlot(m_node).m_Initial_blue := StrToInt(EditState_blue.Text);
  end else if m_node is TQueue then begin
    Prov;
    TQueue(m_node).m_Initial_red := StrToInt(EditState_red.Text);
    TQueue(m_node).m_Initial_green := StrToInt(EditState_green.Text);
    TQueue(m_node).m_Initial_blue := StrToInt(EditState_blue.Text);
  end else if m_node is TShaman then begin
    TShaman(m_node).m_Initial_red := StrToInt(EditState_red.Text);
    TShaman(m_node).m_Initial_green := StrToInt(EditState_green.Text);
    TShaman(m_node).m_Initial_blue := StrToInt(EditState_blue.Text);
 end;

  if m_node is TBarrier then begin
    TBarrier(m_node).m_Priority := StrToInt(EditPriority.Text);
    if CheckListBox1.Checked[0]=true then TBarrier(m_node).m_Red:=1 else TBarrier(m_node).m_Red:=0;
    if CheckListBox1.Checked[1]=true then TBarrier(m_node).m_Green:=1 else TBarrier(m_node).m_green:=0;
    if CheckListBox1.Checked[2]=true then TBarrier(m_node).m_Blue:=1 else TBarrier(m_node).m_blue:=0;
  end;

  if m_node is TLink then begin
    TLink(m_node).WeightOfLink:=WeightOfLink.Text;
    if CheckBox1.Checked=true then
    begin
    TLink(m_node).Ingibit:=1
    end else TLink(m_node).Ingibit:=0;

  end;
  if k='1' then
  ModalResult := mrOk else
  ModalResult := mrNone;


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
Label2.Visible:=false;
WeightOfLink.Visible:=false;
EditState_red.Visible:=false;
EditState_green.Visible:=false;
EditState_blue.Visible:=false;
ButtonActions.Visible:=false;
end;




end.
