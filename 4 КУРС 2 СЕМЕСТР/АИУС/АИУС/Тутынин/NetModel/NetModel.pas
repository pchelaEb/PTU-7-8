unit NetModel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NetObj, StdCtrls, Menus, ExtCtrls, ComCtrls, ToolWin, ImgList,
  jpeg, DateUtils, ShellAPI;

type
  TfMain = class(TForm)
    pic: TLabel;
    MyToolBar: TToolBar;
    tbSelect: TToolButton;
    tbPC: TToolButton;
    tbSwitch: TToolButton;
    tbConnection: TToolButton;
    MyMenu: TMainMenu;
    N1: TMenuItem;
    ToolsImages: TImageList;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    OpenModel: TOpenDialog;
    SaveModel: TSaveDialog;
    N7: TMenuItem;
    ToolButton1: TToolButton;
    StartSim: TToolButton;
    myStatusBar: TStatusBar;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    ProgressBar2: TProgressBar;
    ProgressBar3: TProgressBar;
    ProgressBar4: TProgressBar;
    L4: TLabel;
    Label2: TLabel;
    L3: TLabel;
    Label3: TLabel;
    L2: TLabel;
    Label4: TLabel;
    L1: TLabel;
    Label5: TLabel;
    SwitchList: TComboBox;
    NextStep: TButton;
    Nextauto: TButton;
    procedure OnFormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StartSimClick(Sender: TObject);
    procedure NextStepClick(Sender: TObject);
    procedure SwitchListChange(Sender: TObject);
    procedure NextautoClick(Sender: TObject);
   { procedure Button1Click(Sender: TObject);}

  private
    { Private declarations }
  public
    { Public declarations clBtnFace}
  end;

type
  TConElem=record
    ready:boolean;
    x,y:integer;
    type_name:string;
    device_ID:integer;
    array_pos:integer;
  end;

const nPC=20;
const nS=5;
const nC=100;
const nP=1000;

const productName='NetModel';

function showInfo(messageCode:integer; extraParams:string):integer;
function saveModelToFile(fileName:string; mode:integer):integer;
function loadModelFromFile(fileName:string; mode:integer):integer;
function FormClean():integer;

var
  fMain: TfMain;
  DrawPlace:TCanvas;
  ex_X,ex_Y:integer;
  s_a:array [1..nS] of TSwitch;
  s_i:integer;
  w_a:array [1..nPC] of TWorkStation;
  w_i:integer;
  c_a:array [1..nC] of TConnection;
  c_i:integer;
  // Переменные для пакетов
  p_a:array [1..nP] of TNetTrafic;
  p_i:int64;
  first_elem:TConElem;
  second_elem:TConElem;
  scr:TRect;
  need_save:boolean;
  need_rePaint:boolean;
  workDirectory:string;
  lastPaint:TDateTime;
  // Моделирование
  max_sim_time:int64;
  cur_sim_time:int64;
  cur_events:string;
  // Real-time log
  RTLog:text;
  wait :boolean;

implementation

{$R *.dfm}

procedure TfMain.OnFormClick(Sender: TObject);
var i:integer;
begin
  i:=1;
  if fMain.tbPC.Down
  then
  begin
    first_elem.ready:=false;
    second_elem.ready:=false;
    while (i<=nPC) and (w_a[i].status<>'') do
    begin
      if w_a[i].status='b' then break;
      inc(i);
    end;
    if i>nPC then
    begin
      ShowInfo(3,'');
      exit;
    end;
    w_a[i].init(fMain,w_i,i);
    inc(w_i);
    need_save:=true;
  end;
  if fMain.tbSwitch.Down then
  begin
    first_elem.ready:=false;
    second_elem.ready:=false;
    while (i<=nS) and (s_a[i].status<>'') do
    begin
      if s_a[i].status='b' then break;
      inc(i);
    end;
    if i>nS then
    begin
      ShowInfo(3,'');
      exit;
    end;
    s_a[i].init(fMain,s_i,i);
    fMain.SwitchList.AddItem('Switch '+IntToStr(s_i),nil);
    inc(s_i);
    need_save:=true;
  end;
  if fMain.tbConnection.Down and first_elem.ready and second_elem.ready then
  begin
    while (i<=nC) and (c_a[i].status<>'') do
    begin
      if c_a[i].status='b' then break;
      inc(i);
    end;
    if i>nC then
    begin
      ShowInfo(3,'');
      exit;
    end;
    fMain.Canvas.MoveTo(first_elem.x,first_elem.y);
    fMain.Canvas.Pen.Color:=clWhite;
    fMain.Canvas.LineTo(ex_X,ex_Y);
    c_a[i].init(DrawPlace,
    first_elem.x,first_elem.y,second_elem.x,second_elem.y,
    first_elem.type_name,second_elem.type_name,
    first_elem.device_ID,second_elem.device_ID,
    first_elem.array_pos,second_elem.array_pos,c_i,i);
    inc(c_i);
    first_elem.ready:=false;
    second_elem.ready:=false;
    fMain.Canvas.CopyMode:=cmSrcAnd;
    fMain.Canvas.CopyRect(scr,NetObj.buffer.Canvas,scr);
    need_rePaint:=true;
    need_save:=true;
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var i:integer;
begin
    pic.DragKind:=dkDock;
    pic.DragMode:=dmAutomatic;
    pic.ManualFloat(Rect(Left+pic.Left,
                          Top+pic.Top,
                          Left+pic.Left+pic.Width,
                          Top+pic.Top+pic.Height));
    pic.ManualDock(fMain,nil,alLeft);
    for i:=1 to nS do s_a[i]:=TSwitch.Create;
    for i:=1 to nPC do w_a[i]:=TWorkStation.Create;
    for i:=1 to nC do c_a[i]:=TConnection.Create;
    for i:=1 to nP do p_a[i]:=TNetTrafic.Create;
    s_i:=1;
    w_i:=1;
    c_i:=1;
    p_i:=1;
    first_elem.ready:=false;
    second_elem.ready:=false;
    DrawPlace:=fMain.Canvas;
    fMain.DoubleBuffered:=true;
    scr.Left:=0;
    scr.Top:=0;
    scr.Bottom:=fMain.Height;
    scr.Right:=fMain.Width;
    need_save:=false;
    SaveModel.FileName:='';
    workDirectory:=GetCurrentDir;
    need_rePaint:=false;
    OpenModel.InitialDir:=workDirectory;
    SaveModel.InitialDir:=workDirectory;
    lastPaint:=Time;
end;

procedure TfMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if fMain.tbConnection.Down and first_elem.ready then
  begin
    fMain.Canvas.MoveTo(first_elem.x,first_elem.y);
    fMain.Canvas.Pen.Color:=clWhite;
    fMain.Canvas.LineTo(ex_X,ex_Y);
    fMain.Canvas.MoveTo(first_elem.x,first_elem.y);
    fMain.Canvas.Pen.Color:=clBlack;
    fMain.Canvas.LineTo(X,Y);
    ex_X:=X;
    ex_Y:=Y;
    fMain.Canvas.CopyMode:=cmSrcAnd;
    fMain.Canvas.CopyRect(scr,NetObj.buffer.Canvas,scr);
  end;
end;

//Москва, апрель 2007//

//--Создать новую модель--//
procedure TfMain.N2Click(Sender: TObject);
begin
  if need_save then
    begin
      case ShowInfo(0,'') of
        2:exit; //Cancel - выход из обработчика
        6: N4Click(nil);//Yes - Открыть диалог сохранения
        7:; //No - ничего не делать
        else begin end;
      end;
      need_save:=false;
    end;
    SaveModel.FileName:='';
    FormClean();
end;

//--Очистка формы--//
function FormClean():integer;
var i:integer;
begin
  for i:=1 to nS do
  begin
    if s_a[i].status='g' then s_a[i].Remove(nil);
    s_a[i]:=TSwitch.Create;
  end;
  for i:=1 to nPC do
  begin
    if w_a[i].status='g' then w_a[i].Remove(nil);
    w_a[i]:=TWorkStation.Create;
  end;
  for i:=1 to nC do c_a[i]:=TConnection.Create;
  s_i:=1;
  w_i:=1;
  c_i:=1;
  first_elem.ready:=false;
  second_elem.ready:=false;
  fMain.SwitchList.Clear;
  FormClean:=0;
end;

//--Открыть сохраненную модель--//
procedure TfMain.N3Click(Sender: TObject);
begin
   if need_save then N2Click(nil);
   if OpenModel.Execute then
   begin
     if OpenModel.FileName<>'' then
     begin
       FormClean();
       loadModelFromFile(OpenModel.FileName,0);
       SaveModel.FileName:=OpenModel.FileName;
     end
     else ShowInfo(1,'');
   end
   else begin {ShowInfo(1,'');} end;
  fMain.FormPaint(nil);
end;

//--Сохранение модели в файл--//
procedure TfMain.N4Click(Sender: TObject);
begin
  if SaveModel.FileName<>'' then
  begin
    saveModelToFile(SaveModel.FileName,0);
  end
  else
  begin
     if SaveModel.Execute then
     begin
       if saveModel.FileName<>'' then
       begin
         saveModelToFile(SaveModel.FileName,0);
       end
       else ShowInfo(2,'');
     end
     else begin {ShowInfo(2,'');} end;
  end;
  fMain.FormPaint(nil);
end;

//--Сохранение модели сети под другим именем--//
procedure TfMain.N7Click(Sender: TObject);
begin
  if SaveModel.Execute then
  begin
    if saveModel.FileName<>'' then
    begin
      saveModelToFile(SaveModel.FileName,0);
    end
    else ShowInfo(2,'');
  end
  else begin {ShowInfo(2,'');} end;
  fMain.FormPaint(nil);
end;

//--Процедура выдачи сообщений--//
function ShowInfo(messageCode:integer; extraParams:string):integer;
begin
  case messageCode of
    0: ShowInfo:=MessageBox(0,'Модель сети была изменена.'+#13#10+'Сохранить изменения?',productName,MB_YESNOCANCEL);
    1: ShowInfo:=MessageBox(0,'Ошибка загрузки модели',productName,MB_OK);
    2: ShowInfo:=MessageBox(0,'Ошибка сохранения модели',productName,MB_OK);
    3: ShowInfo:=MessageBox(0,'Невозможно добавить новый элемент',productName,MB_OK);
    4: ShowInfo:=MessageBox(0, 'Недопустимое значение максимального числа родключений',productName,MB_OK);
    else begin ShowInfo:=-1; end;
  end;
  fMain.FormPaint(nil);
end;

//--Запись в файл
function saveModelToFile(fileName:string; mode:integer):integer;
var f,buf:Text;
    i:integer;
begin
  assign(buf,fileName);
  {$I-}
  reset(buf);
  if IOResult=0 then
  begin
    close(buf);
    rename(buf,fileName+'.tmp');
  end;
  {$I+}
  assign(buf,fileName+'.tmp');
  assign(f,fileName);
  rewrite(f);
  writeln(f,'[PC Section]');
  for i:=1 to nPC do
    if w_a[i].status='g' then writeln(f,w_a[i].Tostring());
  writeln(f);
  writeln(f,'[Switch Section]');
  for i:=1 to nS do
    if s_a[i].status='g' then writeln(f,s_a[i].ToString());
  writeln(f);
  writeln(f,'[Connection Section]');
  for i:=1 to nC do
    if c_a[i].status='g' then writeln(f,c_a[i].ToString());
  writeln(f);
  close(f);
   {$I-}
   erase(buf);
   {$I+}
   fmain.FormPaint(nil);
   saveModelToFile:=0;
end;

//--Закрыть приложение--//
procedure TfMain.N6Click(Sender: TObject);
begin
  Application.Terminate;
end;

//--Загрузка модели из файла--//
function loadModelFromFile(fileName:string; mode:integer):integer;
var f:Text;
    i:integer;
    i_pc, i_sw, i_cn:integer;
    buf:string;
begin
  assign(f,fileName);
  reset(f);
  i:=0;
  i_pc:=1;
  i_sw:=1;
  i_cn:=1;
  while not eof(f) do
  begin
     readln(f,buf);
     if (i>0) and (buf<> '')then
     begin
       case i of
         1:begin
             w_i:=w_a[i_pc].FromString(fMain, buf,i_pc, w_i);
             inc(i_pc);
           end;
         2:begin
             s_i:=s_a[i_sw].FromString(fMain,buf,i_sw, s_i);
             inc(i_sw);
           end;
         3:begin
             c_i:=c_a[i_cn].FromString(fMain.Canvas,buf,i_cn, c_i);
             inc(i_cn);
           end;
         else begin end;
       end;
     end
     else if buf='' then i:=0
          else begin  end;
     if buf = '[PC Section]' then i:=1;
     if buf = '[Switch Section]' then i:=2;
     if buf = '[Connection Section]' then i:=3;
  end;
  fMain.FormPaint(nil);
  for i:=1 to nS do
    if s_a[i].status='g' then fMain.SwitchList.AddItem('Switch '+IntToStr(s_a[i].getDeviceID()),nil);
  loadModelFromFile:=0;
end;

//--Перерисовка соединений--//
procedure TfMain.FormPaint(Sender: TObject);
var i:integer;
begin

   if MilliSecondsBetween(lastPaint,Time)>1000 then
   begin
     for i:=1 to nC do
     begin
       if c_a[i].status='g' then c_a[i].Draw(fMain.Canvas,true);
       MyToolBar.BringToFront;
     end;
     lastPaint:=Time;
   end;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
begin
  i:=0;
  IntToStr(i);
end;

procedure TfMain.StartSimClick(Sender: TObject);
var i,j,z,t:integer;
    min_next:int64;
    fname:string;
    fname2:string;
begin
  StartSim.Down:=true;
  max_sim_time:=20000;
  cur_sim_time:=0;
  p_i:=1;
  //Моделирование
  fMain.NextStep.Enabled:=not fMain.NextStep.Enabled;
  myStatusBar.SimpleText:='Моделирование сети...';

  fname:=DateToStr(Date)+' '+TimeToStr(Time);
  for i:=1 to length(fname) do
    if (fname[i]='.')or(fname[i]=':') then fname[i]:='-';
  fname2:=workDirectory+'\Report '+fname+'.log';
  fname:=workDirectory+'\'+fname+'.log';
  assignfile(RTLog,fname);
  Rewrite(RTLog);
  
  for i:=1 to nPC do
    if w_a[i].status='g' then
    begin
      if w_a[i].connections='' then
      begin
         w_a[i].status:='b';
         w_a[i].Remove(nil);
      end
      else
      begin
        w_a[i].SetWorkEnd;
        w_a[i].SetPacket(0);
        w_a[i].b_isbusy_receive:=false;
        w_a[i].b_isbusy_generate:=false;
        for j:=0 to NetObj.nClasses do
        begin
          NetModel.w_a[i].count_get[j]:=0;
          NetModel.w_a[i].count_send[j]:=0;
          NetModel.w_a[i].count_drop[j]:=0;
        end;
      end;
    end;
  for i:=1 to nS do
    if s_a[i].status='g' then
    begin
      if s_a[i].connections='' then
      begin
        s_a[i].status:='b';
        s_a[i].Remove(nil);
      end
      else
      begin
        s_a[i].b_isbusy_receive:=false;
        s_a[i].b_isbusy_send:=false;
        s_a[i].next_queue:=0;
        s_a[i].next_packet:=0;
        for j:=0 to NetObj.nClasses do
        begin
          NetModel.s_a[i].count_get[j]:=0;
          NetModel.s_a[i].count_drop[j]:=0;
          netModel.s_a[i].queue_pcks[j,0]:=0;
        end;
      end;
    end;
    for i:=1 to nC do
      if c_a[i].status='g' then
      begin
       c_a[i].canal_width:=1;
       for j:=0 to NetObj.nClasses do
      begin
        NetModel.c_a[i].count_pass[j]:=0;
        NetModel.c_a[i].count_drop[j]:=0;
      end;
    end;


  while cur_sim_time<=max_sim_time do
  begin
     Application.ProcessMessages;
     j:=1;
     for i:=1 to length(cur_events) do
     begin
       if cur_events[i]='_' then
       begin
          z:=StrToInt(copy(cur_events,j,i-j));
          if (p_a[z].s_operation='New') then p_a[z].iGenerateTrafic()
          else if (p_a[z].s_operation='ToCanal') then p_a[z].iTestConnection()
               else  if (p_a[z].s_operation='ToOwner') and (p_a[z].s_cur_owner_type='Switch') then
               begin
                  t:=p_a[z].iToSwitch();
                      wait:=true;
                      SwitchListChange(nil);
                      //ShowMessage(IntToStr(cur_sim_time));
                      while (wait)  and (fmain.SwitchList.ItemIndex<>-1) and (t>0) do Application.ProcessMessages;
               end
                     else if (p_a[z].s_operation='ToOwner') and (p_a[z].s_cur_owner_type='PC') then p_a[z].iToWorkStation()
                          else if (p_a[z].s_operation='Kill') then p_a[z].iDestroy()
                               else if (p_a[z].s_operation='FromQueue') then
                               begin
                                  t:=p_a[z].iFromQueue();
                                  wait:=true;
                                  SwitchListChange(nil);
                                  while (wait)  and (fmain.SwitchList.ItemIndex<>-1)and (t>0) do Application.ProcessMessages;
                               end
                                    else begin end;
          j:=i+1;
       end;
    end;
    cur_events:='';
    min_next:=-1;
    for i:=1 to nP do
    begin
      if (p_a[i].c_status='g') and (p_a[i].i_event_time=min_next) then cur_events:=cur_events+IntToStr(i)+'_';
      if (p_a[i].c_status='g') and ((p_a[i].i_event_time<min_next) or (min_next=-1)) then
      begin
         cur_events:=IntToStr(i)+'_';
         min_next:=p_a[i].i_event_time;
      end;
    end;
    if cur_events='' then begin Showmessage('True'); cur_sim_time:=max_sim_time+1; end
    else cur_sim_time:=min_next;

    Application.ProcessMessages;
    myStatusBar.SimpleText:='Моделирование сети...'+IntToStr(Round(cur_sim_time/max_sim_time*100))+'%';
  end;
  //ShowMessage(IntToStr(p_i));
  closefile(RTLog);
  ShellExecute(fMain.Handle,PChar('open'), PChar('notepad.exe'), PChar(fname), PChar('C:\Windows'),SW_ShowNormal);
  assignFile(RTLog,fname2);
  rewrite(RTLog);
  for i:=1 to nPC do
    if w_a[i].status='g' then
    begin
      writeln(RTLog,'PC '+IntToStr(w_a[i].getDeviceID()));
      writeln(RTLog, 'Сгенерировано пакетов '+IntToStr(w_a[i].count_send[0]));
      writeln(RTLog, 'Получено пакетов приоритета 1 '+IntToStr(w_a[i].count_get[1]));
      writeln(RTLog, 'Получено пакетов приоритета 2 '+IntToStr(w_a[i].count_get[2]));
      writeln(RTLog, 'Получено пакетов приоритета 3 '+IntToStr(w_a[i].count_get[3]));
      writeln(RTLog, 'Получено пакетов приоритета 4 '+IntToStr(w_a[i].count_get[4]));
      writeln(RTLog);
    end;

  for i:=1 to nS do
    if s_a[i].status='g' then
    begin
      writeln(RTLog,'Switch '+IntToStr(s_a[i].getDeviceID()));
      writeln(RTLog, 'Обработано пакетов приоритета 1 '+IntToStr(s_a[i].count_get[1]));
      writeln(RTLog, 'Обработано пакетов приоритета 2 '+IntToStr(s_a[i].count_get[2]));
      writeln(RTLog, 'Обработано пакетов приоритета 3 '+IntToStr(s_a[i].count_get[3]));
      writeln(RTLog, 'Обработано пакетов приоритета 4 '+IntToStr(s_a[i].count_get[4]));
      writeln(RTLog);
    end;

  closefile(RTLog);
  ShellExecute(fMain.Handle,PChar('open'), PChar('notepad.exe'), PChar(fname2), PChar('C:\Windows'),SW_ShowNormal);

  for i:=1 to nP do p_a[i].c_status:='b';
  myStatusbar.SimpleText:='Формирование отчета';
  // Создание отчета
  myStatusBar.SimpleText:='Отчет подготовлен';
  StartSim.Down:=false;
  fMain.NextStep.Enabled:=not fMain.NextStep.Enabled;
  //Showmessage('Моделирование окончено');
end;

// Линия задержки
procedure TfMain.NextStepClick(Sender: TObject);
begin
  wait:=false;
  //showmessage(IntTostr(cur_sim_time));
end;

// Смена коммутатора
procedure TfMain.SwitchListChange(Sender: TObject);
var i,j:integer;
begin
  if (fMain.NextStep.Enabled) and (fMain.SwitchList.ItemIndex<>-1) then
  begin
     // Поиск элемента
     i:=1;
     while (i<=nS) and (fMain.SwitchList.Items[fMain.SwitchList.ItemIndex]<>'Switch '+IntToStr(s_a[i].getDeviceID())) do inc (i);
     fMain.ProgressBar1.Max:=s_a[i].max_queue;
     fMain.ProgressBar2.Max:=s_a[i].max_queue;
     fMain.ProgressBar3.Max:=s_a[i].max_queue;
     fMain.ProgressBar4.Max:=s_a[i].max_queue;
     fMain.ProgressBar4.Position:=s_a[i].queue_pcks[4,0];
     fMain.ProgressBar3.Position:=s_a[i].queue_pcks[3,0];
     fMain.ProgressBar2.Position:=s_a[i].queue_pcks[2,0];
     fMain.ProgressBar1.Position:=s_a[i].queue_pcks[1,0];
     L4.Caption:='';
     for j:=1 to s_a[i].queue_pcks[4,0] do
        L4.Caption:=L4.Caption+IntToStr(p_a[s_a[i].queue_pcks[4,j]].i_ID)+' ';
     L3.Caption:='';
     for j:=1 to s_a[i].queue_pcks[3,0] do
        L3.Caption:=L3.Caption+IntToStr(p_a[s_a[i].queue_pcks[3,j]].i_ID)+' ';
     L2.Caption:='';
     for j:=1 to s_a[i].queue_pcks[2,0] do
        L2.Caption:=L2.Caption+IntToStr(p_a[s_a[i].queue_pcks[2,j]].i_ID)+' ';
     L1.Caption:='';
     for j:=1 to s_a[i].queue_pcks[1,0] do
        L1.Caption:=L1.Caption+IntToStr(p_a[s_a[i].queue_pcks[1,j]].i_ID)+' ';

  end;
end;

procedure TfMain.NextautoClick(Sender: TObject);
begin
  fMain.SwitchList.ItemIndex:=-1;
end;

end.


