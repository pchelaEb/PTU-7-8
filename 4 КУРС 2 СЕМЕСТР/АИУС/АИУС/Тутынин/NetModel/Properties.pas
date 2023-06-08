unit Properties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Grids;

type
  TSettings_Form = class(TForm)
    TabSettings: TTabControl;
    Common: TPanel;
    Label1: TLabel;
    connects: TStringGrid;
    Label3: TLabel;
    Del_Connect: TButton;
    WS_Settings: TPanel;
    TraficSpeed: TRadioGroup;
    TraficErrors: TRadioGroup;
    TraficSync: TRadioGroup;
    NeedAnswer: TCheckBox;
    S_settings: TPanel;
    Label2: TLabel;
    max_cons: TEdit;
    Label4: TLabel;
    inUse_cons: TEdit;
    UpDownCons: TUpDown;
    Queue: TRadioGroup;
    Label5: TLabel;
    QueLen: TEdit;
    UpDownQueue: TUpDown;
    procedure CommonClick(Sender: TObject);
    procedure Del_ConnectClick(Sender: TObject);
    procedure TabSettingsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Settings_Form: TSettings_Form;

implementation

{$R *.dfm}

uses NetObj, NetModel;

procedure TSettings_Form.CommonClick(Sender: TObject);
begin
  if Settings_Form.AlphaBlendValue>50 then
    Settings_Form.AlphaBlendValue:=Settings_Form.AlphaBlendValue div 2
  else Settings_Form.AlphaBlendValue:=255;
end;

procedure TSettings_Form.Del_ConnectClick(Sender: TObject);
var z,i,k:integer;
begin
  if connects.Cells[0,connects.Row]<>''
  then
  begin
    z:=StrToInt(connects.Cells[0,connects.Row]);
    k:=1;
    while (k<=NetModel.nC) and (NetModel.c_a[k].getID<>z) do k:=k+1;
    z:=k;
    if NetModel.c_a[z].type_name1='PC' then begin
      delete(NetModel.w_a[NetModel.c_a[z].array_pos1].connections,pos(IntToStr(z)+'_',NetModel.w_a[NetModel.c_a[z].array_pos1].connections),length(IntToStr(z)+'_'));
      NetModel.w_a[NetModel.c_a[z].array_pos1].Connect_Object(false); end
    else begin
      delete(NetModel.s_a[NetModel.c_a[z].array_pos1].connections,pos(IntToStr(z)+'_',NetModel.s_a[NetModel.c_a[z].array_pos1].connections),length(IntToStr(z)+'_'));
      NetModel.s_a[NetModel.c_a[z].array_pos1].Connect_Object(false); end;
    if NetModel.c_a[z].type_name2='PC' then begin
      delete(NetModel.w_a[NetModel.c_a[z].array_pos2].connections,pos(IntToStr(z)+'_',NetModel.w_a[NetModel.c_a[z].array_pos2].connections),length(IntToStr(z)+'_'));
      NetModel.w_a[NetModel.c_a[z].array_pos2].Connect_Object(false); end
    else begin
      delete(NetModel.s_a[NetModel.c_a[z].array_pos2].connections,pos(IntToStr(z)+'_',NetModel.s_a[NetModel.c_a[z].array_pos2].connections),length(IntToStr(z)+'_'));
      NetModel.s_a[NetModel.c_a[z].array_pos2].Connect_Object(false); end;
    NetModel.c_a[z].status:='b';
    NetModel.c_a[z].Draw(NetModel.fMain.Canvas,false);
    for i:=connects.Row to connects.RowCount do
    begin
      Properties.Settings_Form.connects.Cells[0,i]:=Properties.Settings_Form.connects.Cells[0,i+1];
      Properties.Settings_Form.connects.Cells[1,i]:=Properties.Settings_Form.connects.Cells[1,i+1];
    end;
    Properties.Settings_Form.connects.RowCount:=Properties.Settings_Form.connects.RowCount-1;
    NetModel.need_save:=true;
    if pos('Switch',Label1.Caption)<>0 then inUse_cons.Text:=IntToStr(StrToInt(inUse_cons.Text)-1);
  end;
end;

// Смена вкладок
procedure TSettings_Form.TabSettingsChange(Sender: TObject);
begin
  if TabSettings.TabIndex=0 then
  begin
    Common.Visible:=true;
    WS_Settings.Visible:=false;
    s_Settings.Visible:=false;
  end;
  if (TabSettings.TabIndex=1) then
  begin
    if pos('PC',Label1.Caption)<>0 then
    begin
      Common.Visible:=false;
      WS_Settings.Visible:=true;
      S_Settings.Visible:=false;
    end
    else
    begin
      TabSettings.TabIndex:=2;
      TabSettingsChange(nil);
    end;
  end;
  if (TabSettings.TabIndex=2) then
  begin
    if pos('Switch',Label1.Caption)<>0 then
    begin
      Common.Visible:=false;
      WS_Settings.Visible:=false;
      S_Settings.Visible:=true;
    end
    else
    begin
      TabSettings.TabIndex:=1;
      TabSettingsChange(nil);
    end;
  end;
end;

procedure TSettings_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
var j,i:integer;
begin
   j:=length(Label1.Caption);
   while Label1.Caption[j]<>' ' do j:=j-1;
   i:=StrToInt(copy(Label1.Caption,j+1,length(Label1.Caption)-j));
   if pos('PC',Label1.Caption)<>0 then
   begin
     j:=1;
     while (j<=NetModel.nPC) and (NetModel.w_a[j].getDeviceID<>i) do j:=j+1;
     i:=j;
     NetModel.w_a[i].i_speed:=TraficSpeed.ItemIndex;
     NetModel.w_a[i].i_jit:=TraficSync.ItemIndex;
     NetModel.w_a[i].i_error:=TraficErrors.ItemIndex;
     NetModel.w_a[i].i_answer:=NeedAnswer.Checked;
   end;
   if pos('Switch',Label1.Caption)<>0 then
   begin
     j:=1;
     while (j<=NetModel.nS) and (NetModel.s_a[j].getDeviceID<>i) do j:=j+1;
     i:=j;
     if UpDownCons.Position<StrToInt(inUse_cons.Text) then
     begin
       NetModel.ShowInfo(4,'');
       Action:=caNone;
     end
     else
     begin
       NetModel.s_a[i].max_connects:=UpDownCons.Position;
       NetModel.s_a[i].cur_connects:=StrToInt(inUse_cons.Text);
       NetModel.s_a[i].max_queue:=StrToInt(QueLen.Text);
     end;
   end;
end;

end.
