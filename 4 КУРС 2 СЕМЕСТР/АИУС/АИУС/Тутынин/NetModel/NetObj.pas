unit NetObj;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, Properties;

  const nClasses = 10;
  const maxQue   = 500;

  type
    // Класс пакета
    TNetTrafic=class
    public
      source_pos :integer;       // Источник пакета
      dist_pos   :integer;       // Получатель пакета
      s_cur_owner_type :string;  // Текущее положение пакета
      i_cur_owner_pos  :integer;
      i_set_prior   :integer;    // Установленный приоритет
      i_canal_width :real;       // Процент полосы пропускания
      i_event_time :int64;       // Время события пакета
      c_status:char;             // Статус
      i_connection:integer;      // Подключение
      i_array_pos:integer;       // Позиция в массиве пакетов
      s_operation:string;        // Тип операции с пакетом
      i_ID:longint;              // Идентификатор пакета
      // Параметры пакета
      i_speed:integer;           // Скорость передачи пакета
      i_jit  :integer;           // Синхронность передачи
      i_err  :integer;           // Допустимость ошибок
      i_ans  :integer;           // Пакет ответа
      
      // Другие параметры пакета
      function iTestConnection():int64;
      function iToWorkStation():int64;
      function iDestroy():int64;
      function iGenerateTrafic():int64;
      function iToSwitch():int64;
      function iFromQueue():int64;
    end;

  type
    TNetObject=class
    private
        ID:TLabel;
        pic:TImage;
        menu:TPopupMenu;
        con_x:integer;
        con_y:integer;
        type_name:string;
        device_ID:integer;
        array_pos:integer;
    public
        max_connects:integer;
        cur_connects:integer;
        connections:string;
        status:char;
        procedure Remove(Sender: TObject);
        procedure Settings(Sender: TObject);
        procedure init(Owner:TWinControl; d_i:integer; i:integer; name:string);
        procedure DropEnd(Sender, Target: TObject; X, Y: Integer);
        procedure ReDraw;
        procedure Click(Sender: TObject);
        procedure MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
        function Connect_Object(new_connect:boolean):boolean;
        procedure Add_Connect(i:integer);
        function ToString():string;
        function GetArrayPos():integer;
        function getDeviceID():integer;
        function getX(mode:integer):integer;
        function getY(mode:integer):integer;
    end;

  type
    TSwitch=class(TNetObject)
      public
        i_receive_time:integer;
        i_work_start:integer;  // Время получения пакета
        i_work_end:integer;    // Время отправки пакета
        b_isbusy_receive:boolean; // Устройство занято на получение в буфер
        b_isbusy_send   :boolean; // Устройство занято на отправку пакета
        next_queue :integer;   // Отправляемый пакет из очереди
        next_packet:integer;
        count_get: array [0..nClasses] of integer;
        count_drop: array [0..nClasses] of integer;
        queue_pcks: array [0..nClasses,0..maxQue] of integer;
        max_queue :integer;
        procedure init(Owner:TWinControl; d_i:integer; i:integer); overload;
        function FromString(Owner:TWinControl; str:string; arr_pos:integer; curr_ID:integer):integer;
    end;

  type
    TWorkStation=class(TNetObject)
      public
        i_new_time:longint;
        i_receive_time:longint;
        i_work_start:integer;  // Время обработки события базовое
        i_work_end:integer;    // Время обработки события конечное
        b_isbusy_receive:boolean; // Устройство занято
        b_isbusy_generate:boolean;
        count_get: array [0..nClasses] of integer;
        count_send: array [0..nClasses] of integer;
        count_drop: array [0..nClasses] of integer;
        i_speed:integer;
        i_jit:integer;
        i_error:integer;
        i_answer:boolean;
        procedure init(Owner:TWinControl; d_i:integer; i:integer); overload;
        function FromString(Owner:TWinControl; str:string; arr_pos:integer; curr_ID:integer):integer;
        function SetPacket(i_event_time:int64):integer;
        function SetWorkEnd():integer;
    end;

  type
    TConnection=class
      private
        x1,y1:integer;
        x2,y2:integer;
      public
        // Математическое описание канала
        t_start:integer; // Времена срабатывания перехода
        t_end  :integer;
        count_pass: array [0..nClasses] of integer; // Счетчики пакетов
        count_drop: array [0..nClasses] of integer;
        pri_in_use: array [0..nClasses] of integer; // Счетчики использования канала по приоритетам
        canal_width: real; // Полоса пропускания

        type_name1,type_name2:string;
        device_ID1,device_ID2:integer;
        array_pos1,array_pos2:integer;
        type_name:string;
        device_ID:integer;
        array_pos:integer;
        status:char;
        procedure init(Place:TCanvas;
                       x1_,y1_,x2_,y2_:integer;type_name1_,type_name2_:string;
                       device_ID1_,device_ID2_:integer; array_pos1_,array_pos2_:integer;
                       d_i:integer; i:integer);
        procedure Draw(Place:TCanvas; Mode:boolean);
        function ToString():string;
        function SetArrayPos(a_pos:integer; number:integer):integer;
        function FromString(Place:TCanvas; str:string; arr_pos:integer; curr_ID:integer):integer;
        function getID():integer;
    end;

var buffer:TBitmap;
path_not_found:boolean;
all:string;
implementation

uses NetModel;

  // Путь между коммутаторами
  function FindPathBetweenComs(starting:integer; ending:integer; path:string):string;
  var buf_cons:string;
      sw_cons:string;
      buf:string;
      i,j,z,k:integer;
  begin
     if starting=ending then
     begin
       path_not_found:=false;
       FindPathBetweenComs:='';
     end
     else
     begin
       buf_cons:=NetModel.s_a[starting].connections;
       sw_cons:='';
       j:=1;
       for i:=1 to length(buf_cons) do
       begin
         if buf_cons[i]='_' then
         begin
          z:=StrToInt(copy(buf_cons,j,i-j));
          if pos(IntToStr(z)+'_',path)=0 then
          begin
            //Переход от z к позиции в массиве подключений
            k:=1;
            while (k<=NetModel.nC) and (NetModel.c_a[k].getID<>z) do k:=k+1;
            //z:=k;
            if (NetModel.c_a[k].type_name1='Switch') and (NetModel.c_a[k].type_name2='Switch')
            then sw_cons:=sw_cons+IntToStr(z)+'_';

          end;
          j:=i+1;
         end;
      end;
      i:=1;
      j:=1;
      while (i<=length(sw_cons)) and (path_not_found) do
      begin
        if sw_cons[i]='_' then
         begin
          buf:='';
          z:=StrToInt(copy(sw_cons,j,i-j));
          k:=1;
          while (k<=NetModel.nC) and (NetModel.c_a[k].getID<>z) do k:=k+1;
            //z:=k;
          if (NetModel.c_a[k].array_pos1<>starting)
          then buf:=IntToStr(z)+'_'+FindPathBetweenComs(NetModel.c_a[k].array_pos1,ending,path+IntToStr(z)+'_')
          else buf:=IntToStr(z)+'_'+FindPathBetweenComs(NetModel.c_a[k].array_pos2,ending,path+IntToStr(z)+'_');
          j:=i+1;
          end;
          i:=i+1;
      end;
      if not path_not_found then all:=IntToStr(k)+'_'+all;

      FindPathBetweenComs:=all;

     end;
  end;

  // Обработка пакета коммутатором - старая версия
  {function TNetTrafic.iToSwitch():int64;
  var
      buf_switch_cons:string;
      i,j:integer;
  begin
    if not NetModel.s_a[i_cur_owner_pos].b_isbusy_receive then
    begin
       NetModel.s_a[i_cur_owner_pos].b_isbusy_receive:=true;
       NetModel.s_a[i_cur_owner_pos].count_get[i_set_prior]:=NetModel.s_a[i_cur_owner_pos].count_get[i_set_prior]+1;
       // Поиск маршрута
       buf_switch_cons:=NetModel.w_a[dist_pos].connections;
       i:=StrToInt(copy(buf_switch_cons,1,length(buf_switch_cons)-1));
       j:=1;
       while (j<=NetModel.nC) and (NetModel.c_a[j].getID<>i) do j:=j+1;
       i:=j;
       if ((NetModel.c_a[i].type_name1='Switch') and (NetModel.c_a[i].array_pos1=i_cur_owner_pos)) or
          ((NetModel.c_a[i].type_name2='Switch') and (NetModel.c_a[i].array_pos2=i_cur_owner_pos))
       then
       begin
         s_operation:='ToCanal';
         i_connection:=i;
         writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' передан коммутатором '+IntToStr(NetModel.s_a[i_cur_owner_pos].device_ID)+' в канал '+IntToStr(NetModel.c_a[i].device_ID));
         randomize;
         NetModel.s_a[i_cur_owner_pos].i_receive_time:=i_event_time+random(NetModel.s_a[i_cur_owner_pos].i_work_end)+1;
         i_event_time:=NetModel.s_a[i_cur_owner_pos].i_receive_time;
         iToSwitch:=i_event_time;
       end
       else
       begin
         path_not_found:=true;
         all:='';
         if (NetModel.c_a[i].type_name1='Switch') and (NetModel.c_a[i].type_name2='PC') then
         begin
           buf_switch_cons:=FindPathBetweenComs(i_cur_owner_pos,NetModel.c_a[i].array_pos1,'');
         end
         else
         begin
           buf_switch_cons:=FindPathBetweenComs(i_cur_owner_pos,NetModel.c_a[i].array_pos2,'');
         end;
         if buf_switch_cons='' then
         begin
           // Убить пакет
           writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' уничтожен коммутатором '+IntToStr(NetModel.s_a[i_cur_owner_pos].device_ID));
           NetModel.s_a[i_cur_owner_pos].count_drop[i_set_prior]:=NetModel.s_a[i_cur_owner_pos].count_drop[i_set_prior]+1;
           c_status:='b';
           iToSwitch:=-1;
         end
         else
         begin
            s_operation:='ToCanal';
            i_connection:=StrToInt(copy(buf_switch_cons,1,pos('_',buf_switch_cons)-1));
            randomize;
            NetModel.s_a[i_cur_owner_pos].i_receive_time:=i_event_time+random(NetModel.s_a[i_cur_owner_pos].i_work_end)+1;
            i_event_time:=NetModel.s_a[i_cur_owner_pos].i_receive_time;
            iToSwitch:=i_event_time;
         end;
       end;
    end
    else c_status:='b';
  end;    }

  // Получение пакета коммутатором
  function TNetTrafic.iToSwitch():int64;
  var
      buf_switch_cons:string;
      i,j:integer;
      prior:integer;
  begin
    prior:=i_speed+i_jit+i_err;
    case prior of
         0..7:i_set_prior:=4;
        8..14:i_set_prior:=3;
       15..21:i_set_prior:=2;
       22..30:i_set_prior:=1;
       else i_set_prior:=1;
    end;
    if (not NetModel.s_a[i_cur_owner_pos].b_isbusy_receive) and (NetModel.s_a[i_cur_owner_pos].queue_pcks[i_set_prior,0]<NetModel.s_a[i_cur_owner_pos].max_queue) then
    begin
       //NetModel.s_a[i_cur_owner_pos].b_isbusy_receive:=true;
         inc(NetModel.s_a[i_cur_owner_pos].queue_pcks[i_set_prior,0]);
         NetModel.s_a[i_cur_owner_pos].queue_pcks[i_set_prior,NetModel.s_a[i_cur_owner_pos].queue_pcks[i_set_prior,0]]:=i_array_pos;
         if i_set_prior>NetModel.s_a[i_cur_owner_pos].next_queue then
         begin
            NetModel.s_a[i_cur_owner_pos].next_queue:=i_set_prior;
            NetModel.s_a[i_cur_owner_pos].next_packet:=i_array_pos;
         end;
         NetModel.s_a[i_cur_owner_pos].count_get[i_set_prior]:=NetModel.s_a[i_cur_owner_pos].count_get[i_set_prior]+1;
         i_event_time:=random(NetModel.s_a[i_cur_owner_pos].i_work_start div 4)+NetModel.s_a[i_cur_owner_pos].i_work_start-random(NetModel.s_a[i_cur_owner_pos].i_work_start div 4)+i_event_time;
         s_operation:='FromQueue';
         iToSwitch:=i_event_time
       end

    else
    begin
      NetModel.s_a[i_cur_owner_pos].count_drop[i_set_prior]:=NetModel.s_a[i_cur_owner_pos].count_drop[i_set_prior]+1;
      c_status:='b';
      writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' уничтожен коммутатором '+IntToStr(NetModel.s_a[i_cur_owner_pos].device_ID));
      iToSwitch:=-1;
    end;

  end; 

  // Отправка пакета из очереди
  function TNetTrafic.iFromQueue():int64;
  var
    buf_switch_cons:string;
    i,j:integer;
  begin
     if (NetModel.s_a[i_cur_owner_pos].queue_pcks[i_set_prior,NetModel.s_a[i_cur_owner_pos].queue_pcks[i_set_prior,0]]=i_array_pos) then
       NetModel.s_a[i_cur_owner_pos].b_isbusy_receive:=false;

       randomize;
       i_event_time:=random(NetModel.s_a[i_cur_owner_pos].i_work_end div 4)+NetModel.s_a[i_cur_owner_pos].i_work_end-random(NetModel.s_a[i_cur_owner_pos].i_work_end div 4)+i_event_time;

     if (i_set_prior = NetModel.s_a[i_cur_owner_pos].next_queue) and (i_array_pos =  NetModel.s_a[i_cur_owner_pos].next_packet) then
     begin
       randomize;
       i_event_time:=random(NetModel.s_a[i_cur_owner_pos].i_work_end div 4)+NetModel.s_a[i_cur_owner_pos].i_work_end-random(NetModel.s_a[i_cur_owner_pos].i_work_end div 4)+i_event_time;
       if NetModel.s_a[i_cur_owner_pos].b_isbusy_send then exit;
       NetModel.s_a[i_cur_owner_pos].b_isbusy_send:= true;
       // Поиск пути
       buf_switch_cons:=NetModel.w_a[dist_pos].connections;
       i:=StrToInt(copy(buf_switch_cons,1,length(buf_switch_cons)-1));
       j:=1;
       while (j<=NetModel.nC) and (NetModel.c_a[j].getID<>i) do j:=j+1;
       i:=j;
       if ((NetModel.c_a[i].type_name1='Switch') and (NetModel.c_a[i].array_pos1=i_cur_owner_pos)) or
          ((NetModel.c_a[i].type_name2='Switch') and (NetModel.c_a[i].array_pos2=i_cur_owner_pos))
       then
       begin
         s_operation:='ToCanal';
         i_connection:=i;
         writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' передан коммутатором '+IntToStr(NetModel.s_a[i_cur_owner_pos].device_ID)+' в канал '+IntToStr(NetModel.c_a[i].device_ID));
         NetModel.s_a[i_cur_owner_pos].i_receive_time:=i_event_time+random(NetModel.s_a[i_cur_owner_pos].i_work_end)+1;
         i_event_time:=NetModel.s_a[i_cur_owner_pos].i_receive_time;
       end
       else
       begin
         path_not_found:=true;
         all:='';
         if (NetModel.c_a[i].type_name1='Switch') and (NetModel.c_a[i].type_name2='PC') then
         begin
           buf_switch_cons:=FindPathBetweenComs(i_cur_owner_pos,NetModel.c_a[i].array_pos1,'');
         end
         else
         begin
           buf_switch_cons:=FindPathBetweenComs(i_cur_owner_pos,NetModel.c_a[i].array_pos2,'');
         end;
         if buf_switch_cons='' then
         begin
           // Убить пакет
           writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' уничтожен коммутатором '+IntToStr(NetModel.s_a[i_cur_owner_pos].device_ID));
           NetModel.s_a[i_cur_owner_pos].count_drop[i_set_prior]:=NetModel.s_a[i_cur_owner_pos].count_drop[i_set_prior]+1;
           c_status:='b';
           NetModel.s_a[i_cur_owner_pos].b_isbusy_send:= true;
           iFromQueue:=-1;
         end
         else
         begin
            s_operation:='ToCanal';
            i_connection:=StrToInt(copy(buf_switch_cons,1,pos('_',buf_switch_cons)-1));
            randomize;
            i_event_time:=NetModel.s_a[i_cur_owner_pos].i_receive_time;
            iFromQueue:=i_event_time;
         end;
       end;
       // Поиск следующего пакета для отправки
       dec(NetModel.s_a[i_cur_owner_pos].queue_pcks[i_set_prior,0]);
       i:=NetModel.s_a[i_cur_owner_pos].next_queue;
       while (NetModel.s_a[i_cur_owner_pos].queue_pcks[i,0]=0)and (i>=1) do dec(i);
       if i<>0 then
       begin
         if i=s_a[i_cur_owner_pos].next_queue then
            for j:= 1 to NetModel.s_a[i_cur_owner_pos].queue_pcks[i,0] do
               NetModel.s_a[i_cur_owner_pos].queue_pcks[i,j]:=NetModel.s_a[i_cur_owner_pos].queue_pcks[i,j+1];
         NetModel.s_a[i_cur_owner_pos].next_queue:=i;
         NetModel.s_a[i_cur_owner_pos].next_packet:=NetModel.s_a[i_cur_owner_pos].queue_pcks[i,1];
       end
       else NetModel.s_a[i_cur_owner_pos].next_queue:=0;
       iFromQueue:=i_event_time;
     end
     else begin iFromQueue:=-1;end;
  end;

  // Генерация пакета
  function TNettrafic.iGenerateTrafic():int64;
  var z,k:integer;
      i,j:integer;
  begin
   if not NetModel.w_a[i_cur_owner_pos].b_isbusy_generate then
   begin
    //writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' сгенерирован рабочей станцией '+IntToStr(NetModel.w_a[i_cur_owner_pos].device_ID));
    NetModel.w_a[i_cur_owner_pos].b_isbusy_generate:=true;
    //i_array_pos:=arr_pos;
    c_status:='g';
    source_pos:=NetModel.w_a[i_cur_owner_pos].array_pos;
    // Пункт назначения
    repeat
       repeat
         i:=random(NetModel.nPC-1)+1;
       until i<>i_cur_owner_pos;
    until (NetModel.w_a[i].status='g');

    dist_pos:=NetModel.w_a[i].array_pos;// Задать пункт назначения и другие параметры пакета
    i_cur_owner_pos:=NetModel.w_a[i_cur_owner_pos].array_pos;
    s_cur_owner_type:=NetModel.w_a[i_cur_owner_pos].type_name;
    //NetModel.w_a[owner].i_new_time:=timing+NetModel.w_a[owner].i_work_end;
    writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' сгенерирован рабочей станцией '+IntToStr(NetModel.w_a[i_cur_owner_pos].device_ID));
    writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' передан рабочей станцией '+IntToStr(NetModel.w_a[i_cur_owner_pos].device_ID)+' в канал ');
    NetModel.w_a[i_cur_owner_pos].count_send[0]:=NetModel.w_a[i_cur_owner_pos].count_send[0]+1;
    randomize;
    i_event_time:=random(NetModel.w_a[i_cur_owner_pos].i_work_end div 4)+NetModel.w_a[i_cur_owner_pos].i_work_end-random(NetModel.w_a[i_cur_owner_pos].i_work_end div 4)+i_event_time;

          z:=StrToInt(copy(NetModel.w_a[i_cur_owner_pos].connections,1,length(NetModel.w_a[i_cur_owner_pos].connections)-1));
          //Переход от z к позиции в массиве подключений
          k:=1;
          while (k<=NetModel.nC) and (NetModel.c_a[k].getID<>z) do k:=k+1;

    i_connection:=k;
    s_operation:='ToCanal';
    iGenerateTrafic:=i_event_time;
    //writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' сгенерирован рабочей станцией '+IntToStr(NetModel.w_a[i_cur_owner_pos].device_ID));
    //writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' передан рабочей станцией '+IntToStr(NetModel.w_a[i_cur_owner_pos].device_ID)+' в канал '+IntToStr(NetModel.c_a[k].device_ID));
   end
   else
   begin
    c_status:='b';
    iGenerateTrafic:=-1;
    //writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' уничтожен рабочей станцией '+IntToStr(NetModel.s_a[i_cur_owner_pos].device_ID));
   end;
   {
   j:=1;
   while (j<=NetModel.nP) and (NetModel.p_a[j].c_status='g') do j:=j+1;
   if j<=nP then
   begin
      NetModel.p_a[j].c_status:='g';
      NetModel.p_a[j].s_cur_owner_type:='PC';
      NetModel.p_a[j].i_cur_owner_pos:=NetModel.w_a[i_cur_owner_pos].array_pos;
      randomize;
      NetModel.p_a[j].i_event_time:=i_event_time+random(NetModel.w_a[i_cur_owner_pos].i_new_time)+1;
      NetModel.p_a[j].s_operation:='New';
   end;
   }
   NetModel.w_a[i_cur_owner_pos].SetPacket(i_event_time);
  end;

  //Убийство пакета
  function TNetTrafic.iDestroy():int64;
  begin
    NetModel.w_a[i_cur_owner_pos].b_isbusy_receive:=false;
    c_status:='b';
    iDestroy:=-1;
  end;

  // Обработка пакета рабочей станцией
  function TNetTrafic.iToWorkStation():int64;
  begin
     NetModel.c_a[i_connection].pri_in_use[i_set_prior]:=NetModel.c_a[i_connection].pri_in_use[i_set_prior]-1;
     if NetModel.c_a[i_connection].pri_in_use[i_set_prior]<=0 then
     begin
       NetModel.c_a[i_connection].pri_in_use[i_set_prior]:=0;
       NetModel.c_a[i_connection].canal_width:=NetModel.c_a[i_connection].canal_width+i_canal_width;
     end;
     if NetModel.w_a[i_cur_owner_pos].b_isbusy_receive then
     begin
       // Станция занята - пакет убит
       c_status:='b';
       writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' уничтожен рабочей станцией '+IntToStr(NetModel.w_a[i_cur_owner_pos].device_ID));
       NetModel.w_a[i_cur_owner_pos].count_drop[i_set_prior]:=NetModel.w_a[i_cur_owner_pos].count_drop[i_set_prior]+1;
       iToWorkStation:=-1;
     end
     else
     begin
        // Иначе пакет тоже будет убить, но через время =)
        //c_status:='b';
        NetModel.w_a[i_cur_owner_pos].b_isbusy_receive:=true;
        randomize;
        i_event_time:=random(NetModel.w_a[i_cur_owner_pos].i_work_end div 4)+NetModel.w_a[i_cur_owner_pos].i_work_end-random(NetModel.w_a[i_cur_owner_pos].i_work_end div 4)+i_event_time;
        NetModel.w_a[i_cur_owner_pos].count_get[i_set_prior]:=NetModel.w_a[i_cur_owner_pos].count_get[i_set_prior]+1;
        //s_operation:='Kill';
        //i_event_time:=NetModel.w_a[i_cur_owner_pos].i_receive_time;
        writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' обработан рабочей станцией '+IntToStr(NetModel.w_a[i_cur_owner_pos].device_ID));
        iToWorkStation:=NetModel.w_a[i_cur_owner_pos].i_receive_time;
        if (NetModel.w_a[i_cur_owner_pos].i_answer) and (i_ans=0) then
        begin
           source_pos:=source_pos+dist_pos;
           dist_pos:=source_pos - dist_pos;
           source_pos:=source_pos - dist_pos;
           inc(i_ans);
           s_operation:='ToCanal';
           i_event_time:=i_event_time+random(NetModel.w_a[i_cur_owner_pos].i_work_end div 8)+NetModel.w_a[i_cur_owner_pos].i_work_end div 2-random(NetModel.w_a[i_cur_owner_pos].i_work_end div 8);
        end
        else s_operation:='Kill';
     end;
  end;

  // Передача пакета по каналу связи
  function TNetTrafic.iTestConnection():int64;
  begin
    // Освобождаем устройство
    if (s_cur_owner_type='PC') and (i_ans=0) then NetModel.w_a[i_cur_owner_pos].b_isbusy_generate:=false
    else if (s_cur_owner_type='PC') and (i_ans=1) then NetModel.w_a[i_cur_owner_pos].b_isbusy_receive:=false
         else NetModel.s_a[i_cur_owner_pos].b_isbusy_send:=false;
     {if (s_cur_owner_type='PC')  then begin NetModel.w_a[i_cur_owner_pos].b_isbusy_generate:=false; NetModel.w_a[i_cur_owner_pos].b_isbusy_receive:=false; end
         else NetModel.s_a[i_cur_owner_pos].b_isbusy_send:=false; }
    // Смена owner'а
    if (s_cur_owner_type=NetModel.c_a[i_connection].type_name1) and (i_cur_owner_pos=NetModel.c_a[i_connection].device_ID1) then
    begin
      s_cur_owner_type:=NetModel.c_a[i_connection].type_name2;
      i_cur_owner_pos:=NetModel.c_a[i_connection].array_pos2;
    end
    else
    begin
      s_cur_owner_type:=NetModel.c_a[i_connection].type_name1;
      i_cur_owner_pos:=NetModel.c_a[i_connection].array_pos1;
    end;
    if (NetModel.c_a[i_connection].pri_in_use[i_set_prior]>0) then
    begin
      // Такой трафик уже передается
      NetModel.c_a[i_connection].count_pass[i_set_prior]:=NetModel.c_a[i_connection].count_pass[i_set_prior]+1;
      randomize;
      i_event_time:=i_event_time+NetModel.c_a[i_connection].t_end+random(NetModel.c_a[i_connection].t_end div 8)-random(NetModel.c_a[i_connection].t_end div 8); // Вставить функцию времени
      writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' прошел по каналу '+IntToStr(i_connection));
    end
    else
    begin
      // Такого трафика еще нет
      if (NetModel.c_a[i_connection].canal_width-i_canal_width>0) then
      begin
        // Толщина канала позволяет принять такой пакет
        NetModel.c_a[i_connection].canal_width:=NetModel.c_a[i_connection].canal_width-i_canal_width;
        NetModel.c_a[i_connection].pri_in_use[i_set_prior]:=NetModel.c_a[i_connection].pri_in_use[i_set_prior]+1;
        NetModel.c_a[i_connection].count_pass[i_set_prior]:=NetModel.c_a[i_connection].count_pass[i_set_prior]+1;
        randomize;
        i_event_time:=i_event_time+NetModel.c_a[i_connection].t_end+random(NetModel.c_a[i_connection].t_end div 8)-random(NetModel.c_a[i_connection].t_end div 8);
        writeln(NetModel.RTLog,IntToStr(i_event_time)+' Пакет '+IntToStr(i_ID)+' прошел по каналу '+IntToStr(i_connection));
      end
      else
      begin
        // Толщина канала не позволяет принять такой пакет
        // Пока убьем пакет
        c_status:='b';
        NetModel.c_a[i_connection].count_drop[i_set_prior]:=NetModel.c_a[i_connection].count_drop[i_set_prior]+1;
        i_event_time:=-1;
      end;
    end;
    s_operation:='ToOwner';
    iTestConnection:=i_event_time;
  end;

  procedure TNetObject.Add_Connect(i:integer);
  begin
    connections:=connections+IntToStr(i)+'_';
  end;

  function TNetObject.Connect_Object(new_connect:boolean):boolean;
  begin
     if(new_connect) then
     begin
        if cur_connects<max_connects then
        begin
          cur_connects:=cur_connects+1;
          Connect_Object:=true;
        end
        else Connect_Object:=false;
     end
     else
     begin
       if cur_connects>0 then cur_connects:=cur_connects-1;
       Connect_Object:=false;
     end;
  end;

  procedure TNetObject.MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  begin
    if NetModel.fMain.tbSelect.Down then
    begin
      pic.DragMode:=dmAutomatic;
      pic.DragKind:=dkDock;
    end
    else
    begin
      pic.DragMode:=dmManual;
      pic.DragKind:=dkDrag;
    end;
  end;

  procedure TNetObject.Click(Sender: TObject);
  begin
    if NetModel.fMain.tbConnection.Down then
    begin
      if (NetModel.first_elem.ready=false) and Connect_Object(true) then
      begin
        NetModel.first_elem.x:=pic.Left+pic.Width div 2;
        NetModel.first_elem.y:=pic.Top+pic.Height div 2;
        NetModel.first_elem.type_name:=type_name;
        NetModel.first_elem.device_ID:=device_ID;
        NetModel.first_elem.array_pos:=array_pos;
        NetModel.first_elem.ready:=true;
        buffer:=TBitmap.Create;
        buffer.Height:=NetModel.fMain.Height;
        buffer.Width:=NetModel.fMain.Width;
        scr.Left:=0;
        scr.Top:=0;
        scr.Bottom:=buffer.Height;
        scr.Right:=buffer.Width;
        buffer.Canvas.CopyMode:=cmSrcCopy;
        buffer.Canvas.CopyRect(NetModel.scr,NetModel.fMain.Canvas,NetModel.scr);
        NetModel.ex_X:=Mouse.CursorPos.X;
        NetModel.ex_Y:=Mouse.CursorPos.Y;
      end
      else if (NetModel.second_elem.ready=false)  then
           begin
              if ((first_elem.type_name=type_name) and (first_elem.device_ID=device_ID))
              then
              begin
                first_elem.ready:=false;
                Connect_Object(false);
                pic.Hide;
                pic.Show;
                ID.Hide;
                ID.Show;
              end
              else
                if ((first_elem.type_name='PC') and (type_name='PC')) then
                begin end
                else
                  if Connect_Object(true) then
                  begin
                    NetModel.second_elem.x:=pic.Left+pic.Width div 2;
                    NetModel.second_elem.y:=pic.Top+pic.Height div 2;
                    NetModel.second_elem.type_name:=type_name;
                    NetModel.second_elem.device_ID:=device_ID;
                    NetModel.second_elem.array_pos:=array_pos;
                    NetModel.second_elem.ready:=true;
                    NetModel.fMain.OnFormClick(nil);
                  end
                  else begin end;
              end
           else begin end;
      end;
  end;

//--Получить ID подключения--//
function TConnection.getID():integer;
begin
  getID:=device_ID;
end;

//--Восстановление сетевого подключения из строки--//
function TConnection.FromString(Place:TCanvas; str:string; arr_pos:integer; curr_ID:integer):integer;
var i,j:integer;
    t_name, t_n1, t_n2:string;
    d_ID, d_ID1, d_ID2:integer;
    a_pos1, a_pos2:integer;
    x1, y1, x2, y2:integer;
begin
  j:=1;
  i:=pos(' ',str);
  t_name:=copy(str,j,i-j);
  str[i]:='\';
  j:=i+1;
  i:=pos(' ',str);
  d_ID:=StrToInt(copy(str,j,i-j));
  str[i]:='\';
  j:=i+1;
  i:=pos(' ',str);
  t_n1:=copy(str,j,i-j);
  str[i]:='\';
  j:=i+1;
  i:=pos(' ',str);
  d_ID1:=StrToInt(copy(str,j,i-j));
  str[i]:='\';
  j:=i+1;
  i:=pos(' ',str);
  t_n2:=copy(str,j,i-j);
  str[i]:='\';
  j:=i+1;
  i:=length(str);
  d_ID2:=StrToInt(copy(str,j,i-j+1));
  if t_n1='PC' then
  begin
    i:=1;
    while (NetModel.w_a[i].status='g') and(NetModel.w_a[i].getDeviceID<>d_ID1) do i:=i+1;
    a_pos1:=i;
    x1:=NetModel.w_a[i].getX(1);
    y1:=NetModel.w_a[i].getY(1);
    NetModel.w_a[i].cur_connects:=NetModel.w_a[i].cur_connects+1;
  end
  else
  begin
    i:=1;
    while (NetModel.s_a[i].status='g') and(NetModel.s_a[i].getDeviceID<>d_ID1) do i:=i+1;
    a_pos1:=i;
    x1:=NetModel.s_a[i].getX(1);
    y1:=NetModel.s_a[i].getY(1);
    NetModel.s_a[i].cur_connects:=NetModel.s_a[i].cur_connects+1;
  end;
  if t_n2='PC' then
  begin
    i:=1;
    while (NetModel.w_a[i].status='g') and(NetModel.w_a[i].getDeviceID<>d_ID2) do i:=i+1;
    a_pos2:=i;
    x2:=NetModel.w_a[i].getX(1);
    y2:=NetModel.w_a[i].getY(1);
    NetModel.w_a[i].cur_connects:=NetModel.w_a[i].cur_connects+1;
  end
  else
  begin
    i:=1;
    while (NetModel.s_a[i].status='g') and(NetModel.s_a[i].getDeviceID<>d_ID2) do i:=i+1;
    a_pos2:=i;
    x2:=NetModel.s_a[i].getX(1);
    y2:=NetModel.s_a[i].getY(1);
    NetModel.s_a[i].cur_connects:=NetModel.s_a[i].cur_connects+1;    
  end;
  init(Place,x1,y1,x2,y2,t_n1,t_n2,d_ID1,d_ID2,a_pos1,a_pos2,d_ID,arr_pos);
  if curr_ID < d_ID+1 then FromString:=d_ID+1
  else Fromstring:=curr_ID;
end;

//--Сохранение сетевого подключения в строку--//
  function TConnection.ToString():string;
  begin
    ToString:=type_name+' '+IntToStr(device_ID)+' '+type_name1+' '+IntToStr(device_ID1)+' '+type_name2+' '+IntToStr(device_ID2);
  end;

  procedure TConnection.Draw(Place:TCanvas; Mode:boolean);
  begin
    Place.Pen.Width:=1;
    if Mode then Place.Pen.Color:=clblack
    else Place.Pen.Color:=clwhite;
    Place.MoveTo(x1,y1);
    Place.LineTo(x2,y2);
      if type_name1='PC' then NetModel.w_a[array_pos1].ReDraw
      else NetModel.s_a[array_pos1].ReDraw;
      if type_name2='PC' then NetModel.w_a[array_pos2].ReDraw
      else NetModel.s_a[array_pos2].ReDraw;
    if Mode then status:='g';
  end;

  procedure TConnection.init(Place:TCanvas;
                  x1_,y1_,x2_,y2_:integer;type_name1_,type_name2_:string;
                 device_ID1_,device_ID2_:integer; array_pos1_,array_pos2_:integer;
                 d_i:integer; i:integer);
  begin
    x1:=x1_; y1:=y1_; x2:=x2_; y2:=y2_;
    type_name1:=type_name1_; type_name2:=type_name2_;
    device_ID1:=device_ID1_; device_ID2:=device_ID2_;
    array_pos1:=array_pos1_; array_pos2:=array_pos2_;
    status:='g';
    type_name:='Connection';
    device_ID:=d_i;
    array_pos:=i;
    if type_name1='PC' then NetModel.w_a[array_pos1].Add_Connect(d_i)
    else NetModel.s_a[array_pos1].Add_Connect(d_i);
    if type_name2='PC' then NetModel.w_a[array_pos2].Add_Connect(d_i)
    else NetModel.s_a[array_pos2].Add_Connect(d_i);
    Draw(Place,true);
    canal_width:=1;
    t_end:=50;
  end;

  procedure TNetObject.init(Owner:TWinControl; d_i:integer; i:integer; name:string);
  begin
    pic:=TImage.Create(Owner);
    pic.Parent:=Owner;
    pic.Picture.LoadFromFile(NetModel.workDirectory+'\'+name+'.bmp');
    pic.Transparent:=true;
    pic.DragKind:=dkDrag;
    pic.DragMode:=dmManual;
    pic.OnEndDock:=DropEnd;
    pic.OnClick:=Click;
    pic.OnMouseMove:=MouseMove;
    type_name:=name;
    device_ID:=d_i;
    array_pos:=i;
    ID:=TLabel.Create(Owner);
    ID.Parent:=Owner;
    ID.Caption:=type_name+' '+IntToStr(device_ID);
    ID.Transparent:=true;
    menu:=TPopupMenu.Create(pic);
    menu.Items.Add(TMenuItem.Create(menu));
    menu.Items[0].Caption:='Удалить';
    menu.Items[0].OnClick:=Remove;
    menu.Items.Add(TMenuItem.Create(menu));
    menu.Items[1].Caption:='-';
    menu.Items.Add(TMenuItem.Create(menu));
    menu.Items[2].Caption:='Свойства';
    menu.Items[2].OnClick:=Settings;
    pic.PopupMenu:=menu;
    status:='g';
    cur_connects:=0;
    connections:='';
  end;

  procedure TSwitch.init(Owner:TWinControl; d_i:integer; i:integer);
  begin
    init(Owner,d_i,i,'Switch');
    pic.Width:=64;
    pic.Height:=12;
    pic.Left:=(Mouse.CursorPos.X-pic.Parent.Left-30);//div 48 *48;
    pic.Top:=(Mouse.CursorPos.Y-pic.Parent.Top-40);//div 48 *48;
    ID.Left:=pic.Left;
    ID.Top:=pic.Top+pic.Height;//-ID.Height;
    con_x:=pic.Left+pic.Width div 2;
    con_y:=pic.Top+pic.Height div 2;
    max_connects:=16;
    max_queue:=50;
    // Параметры...
    i_work_end:=5;
    i_work_start:=5;
    b_isbusy_receive:=false;
  end;

  procedure TWorkStation.init(Owner:TWinControl; d_i:integer; i:integer);
  begin
    init(Owner,d_i,i,'PC');
    pic.Width:=47;
    pic.Height:=42;
    pic.Left:=(Mouse.CursorPos.X-pic.Parent.Left-20);
    pic.Top:=(Mouse.CursorPos.Y-pic.Parent.Top-60);
    ID.Left:=pic.Left;
    ID.Top:=pic.Top+pic.Height;
    con_x:=pic.Left+pic.Width div 2;
    con_y:=pic.Top+pic.Height div 2;
    max_connects:=1;
    // Параметры
    i_work_end:=40;
    i_receive_time:=25;
    //i_new_time:=850;
    i_work_start:=80;
    b_isbusy_receive:=false;
    b_isbusy_generate:=false;
    // Устанавливаем параметры генерации пакетов при запуске
    randomize;
    i_speed:=random(3);
    randomize;
    i_jit:=random(2);
    randomize;
    i_error:=random(2);
    i_answer:=true;
    { Генерация пакетов сделана отдельно
    j:=1;
    while (j<=NetModel.nP) and (NetModel.p_a[j].c_status='g') do j:=j+1;
    if j<nP then
    begin
      NetModel.p_a[j].c_status:='g';
      NetModel.p_a[j].s_cur_owner_type:='PC';
      NetModel.p_a[j].i_cur_owner_pos:=array_pos;
      randomize;
      NetModel.p_a[j].i_event_time:=random(i_new_time)+1;
      NetModel.p_a[j].s_operation:='New';
    end;
    }
   end;

  // Установка конечного времени генерации пакета в зависимости от типа трафика
  function TWorkStation.SetWorkEnd():integer;
  begin
    i_new_time:=i_work_start;
    if i_speed = 2 then i_new_time:=i_new_time - i_work_start div 6;
    if i_speed = 0 then i_new_time:=i_new_time - i_work_start div 9;
    if i_jit = 1 then i_new_time:=i_new_time - i_work_start div 6;
    if i_error = 0 then i_new_time:=i_new_time - i_work_start div 6;
    SetWorkEnd:=0;
  end;


  // Установка параметров пакета
  function TWorkstation.SetPacket(i_event_time:int64):integer;
  var j:integer;
  begin
    j:=1;
    while (j<=NetModel.nP) and (NetModel.p_a[j].c_status='g') do j:=j+1;
    if j<nP then
    begin
      NetModel.p_a[j].c_status:='g';
      NetModel.p_a[j].s_cur_owner_type:='PC';
      NetModel.p_a[j].i_cur_owner_pos:=array_pos;
      NetModel.p_a[j].i_array_pos:=j;
      randomize;
      NetModel.p_a[j].i_event_time:=i_event_time+random(i_new_time div 4)+i_new_time-random(i_new_time div 4);
      NetModel.p_a[j].s_operation:='New';
      NetModel.p_a[j].i_ID:=NetModel.p_i;
      NetModel.p_a[j].i_ans:=0;
      // Устанавливаем параметры для пакета
      randomize;
      case i_speed of
      2: NetModel.p_a[j].i_speed:=0+random(4-0+1);
      1: NetModel.p_a[j].i_speed:=3+random(8-3+1);
      0: NetModel.p_a[j].i_speed:=7+random(10-7+1);
      else NetModel.p_a[j].i_speed:=10;
      end;
      randomize;
      case i_jit of
      1: NetModel.p_a[j].i_jit:=0+random(5-0+1);
      0: NetModel.p_a[j].i_jit:=3+random(10-3+1);
      else NetModel.p_a[j].i_jit:=10;
      end;
      randomize;
      case i_error of
      0: NetModel.p_a[j].i_err:=0+random(4-0+1);
      1: NetModel.p_a[j].i_err:=2+random(10-2+1);
      else NetModel.p_a[j].i_err:=10;
      end;
      NetModel.p_i:=NetModel.p_i+1;
    end;
  end;

  procedure TNetObject.Settings(Sender: TObject);
  var i,j,z,t,k:integer;
  begin
    Properties.Settings_Form.TabSettings.TabIndex:=0;
    Properties.Settings_Form.TabSettingsChange(nil);
    Properties.Settings_Form.Caption:='Свойства '+ID.Caption;
    Properties.Settings_Form.Label1.Caption:='Имя: '+ID.Caption;
    Properties.Settings_Form.connects.Cells[0,0]:='Номер подключения';
    Properties.Settings_Form.connects.Cells[1,0]:='Объект сети';
    j:=1;
    t:=1;
    Properties.Settings_Form.connects.RowCount:=2;
    for i:=1 to length(connections) do
    begin
       if connections[i]='_' then
       begin
          z:=StrToInt(copy(connections,j,i-j));
          Properties.Settings_Form.connects.Cells[0,t]:=IntToStr(z);
          //Переход от z к позиции в массиве подключений
          k:=1;
          while (k<=NetModel.nC) and (NetModel.c_a[k].getID<>z) do k:=k+1;
          z:=k;
          if (NetModel.c_a[z].type_name1=type_name) and (NetModel.c_a[z].device_ID1=device_ID)
            then Properties.Settings_Form.connects.Cells[1,t]:=NetModel.c_a[z].type_name2+' '+IntToStr(NetModel.c_a[z].device_ID2)
            else Properties.Settings_Form.connects.Cells[1,t]:=NetModel.c_a[z].type_name1+' '+IntToStr(NetModel.c_a[z].device_ID1);
          t:=t+1;
          j:=i+1;
          Properties.Settings_Form.connects.RowCount:=Properties.Settings_Form.connects.RowCount+1;
          Properties.Settings_Form.connects.Cells[0,t]:='';
          Properties.Settings_Form.connects.Cells[1,t]:='';
       end;
    end;
    if type_name='PC' then
    begin
     i:=1;
     while (i<=NetModel.nPC) and (NetModel.w_a[i].getDeviceID<>device_ID) do i:=i+1;
     Properties.Settings_Form.TraficSpeed.ItemIndex:=NetModel.w_a[i].i_speed;
     Properties.Settings_Form.TraficSync.ItemIndex:=NetModel.w_a[i].i_jit;
     Properties.Settings_Form.TraficErrors.ItemIndex:=NetModel.w_a[i].i_error;
     Properties.Settings_Form.NeedAnswer.Checked:=NetModel.w_a[i].i_answer;
    end
    else
    begin
    i:=1;
     while (i<=NetModel.nS) and (NetModel.s_a[i].getDeviceID<>device_ID) do i:=i+1;
     Properties.Settings_Form.UpDownCons.Position:=NetModel.s_a[i].max_connects;
     Properties.Settings_Form.inUse_cons.Text:=IntToStr(NetModel.s_a[i].cur_connects);
     Properties.Settings_Form.UpDownQueue.Position:=NetModel.s_a[i].max_queue;
     Properties.Settings_Form.UpDownQueue.Max:=maxQue;
    end;
    Properties.Settings_Form.ShowModal;
  end;

  procedure TNetObject.Remove(Sender: TObject);
  var i,c,k,z:integer;
      buf:string;
  begin
   if type_name = 'Switch' then
   begin
     NetModel.fMain.SwitchList.Items.Delete(NetModel.fMain.SwitchList.Items.IndexOf(ID.Caption));
     NetModel.fMain.SwitchList.ItemIndex:=-1;
   end;
   while connections<>'' do
   begin
     i:=pos('_',connections);
     c:=StrToInt(copy(connections,1,i-1));
     k:=1;
     while (k<=NetModel.nC) and (NetModel.c_a[k].getID<>c) do k:=k+1;
     z:=k;
     Application.ProcessMessages;
     NetModel.c_a[z].Draw(NetModel.fMain.Canvas,false);
     connections:=copy(connections,i+1,length(connections)-i);
     if (NetModel.c_a[z].type_name1=type_name) and (NetModel.c_a[z].device_ID1=device_ID)
     then
     begin
       if(NetModel.c_a[z].type_name2='PC') then
       begin
         NetModel.w_a[NetModel.c_a[z].array_pos2].Connect_Object(false);
         buf:=NetModel.w_a[NetModel.c_a[z].array_pos2].connections;
         buf:=copy(buf,1,pos(IntToStr(c)+'_',buf)-1)+
         copy(buf,pos(IntToStr(c)+'_',buf)+length(IntToStr(c)+'_'),length(buf)-pos(IntToStr(c)+'_',buf)+length(IntToStr(c)+'_')+1);
         NetModel.w_a[NetModel.c_a[z].array_pos2].connections:=buf;
       end
       else
       begin
         NetModel.s_a[NetModel.c_a[z].array_pos2].Connect_Object(false);
         buf:=NetModel.s_a[NetModel.c_a[z].array_pos2].connections;
         buf:=copy(buf,1,pos(IntToStr(c)+'_',buf)-1)+
         copy(buf,pos(IntToStr(c)+'_',buf)+length(IntToStr(c)+'_'),length(buf)-pos(IntToStr(c)+'_',buf)+length(IntToStr(c)+'_')+1);
         NetModel.s_a[NetModel.c_a[z].array_pos2].connections:=buf;
       end;
     end
     else
     begin
       if(NetModel.c_a[z].type_name1='PC') then
       begin
         NetModel.w_a[NetModel.c_a[z].array_pos1].Connect_Object(false);
         buf:=NetModel.w_a[NetModel.c_a[z].array_pos1].connections;
         buf:=copy(buf,1,pos(IntToStr(c)+'_',buf)-1)+
         copy(buf,pos(IntToStr(c)+'_',buf)+length(IntToStr(c)+'_'),length(buf)-pos(IntToStr(c)+'_',buf)+length(IntToStr(c)+'_')+1);
         NetModel.w_a[NetModel.c_a[z].array_pos1].connections:=buf;
       end
       else
       begin
         NetModel.s_a[NetModel.c_a[z].array_pos1].Connect_Object(false);
         buf:=NetModel.s_a[NetModel.c_a[z].array_pos1].connections;
         buf:=copy(buf,1,pos(IntToStr(c)+'_',buf)-1)+
         copy(buf,pos(IntToStr(c)+'_',buf)+length(IntToStr(c)+'_'),length(buf)-pos(IntToStr(c)+'_',buf)+length(IntToStr(c)+'_')+1);
         NetModel.s_a[NetModel.c_a[z].array_pos1].connections:=buf;
       end;
     end;
     NetModel.c_a[z].status:='b';
   end;
   menu.Destroy;
   pic.Destroy;
   ID.Destroy;
   status:='b';
   NetModel.need_save:=true;
  end;

  procedure TNetObject.DropEnd(Sender, Target: TObject; X, Y: Integer);
  var i:integer;
  begin
    ID.Left:=pic.Left;
    ID.Top:=pic.Top+pic.Height;
    Application.ProcessMessages;
    pic.Hide;
        for i:=1 to NetModel.nC do
        begin
          if NetModel.c_a[i].status='g' then
          begin
            NetModel.c_a[i].Draw(NetModel.DrawPlace,false);
            if (NetModel.c_a[i].type_name1=type_name) and (NetModel.c_a[i].device_ID1=device_ID) then
            begin
              NetModel.c_a[i].x1:=pic.Left+pic.Width div 2;
              NetModel.c_a[i].y1:=pic.Top+pic.Height div 2;
            end
            else if (NetModel.c_a[i].type_name2=type_name) and (NetModel.c_a[i].device_ID2=device_ID)then
                 begin
                   NetModel.c_a[i].x2:=pic.Left+pic.Width div 2;
                   NetModel.c_a[i].y2:=pic.Top+pic.Height div 2;
                 end
                 else begin end;
            NetModel.c_a[i].Draw(NetModel.DrawPlace,true);
          end;
        end;
      pic.Show;
    end;

    procedure TNetObject.ReDraw;
    begin
      pic.Hide;
      pic.Show;
      pic.BringToFront;
      ID.Hide;
      ID.Show;
      ID.SendToBack;
    end;

//Москва, апрель 2007
//--Сохранение сетевого объекта в строку--//
function TNetObject.ToString():string;
begin
  ToString:=type_name+' '+IntToStr(device_ID)+' '+IntToStr(pic.Left)+' '+
            IntToStr(pic.Top)+' '+IntToStr(max_connects)+' '+connections;
end;

//--Восстановление рабочей станции из строки--//
function TWorkStation.FromString(Owner:TWinControl; str:string; arr_pos:integer; curr_ID:integer):integer;
var t_name, cons:string;
    d_ID, X, Y, max_con:integer;
    i,j:integer;
begin
    j:=1;
    i:=pos(' ',str);
    t_name:=copy(str,j,i-j);
    str[i]:='\';
    j:=i+1;
    i:=pos(' ',str);
    d_ID:=StrToInt(copy(str,j,i-j));
    str[i]:='\';
    j:=i+1;
    i:=pos(' ',str);
    X:=StrToInt(copy(str,j,i-j));
    str[i]:='\';
    j:=i+1;
    i:=pos(' ',str);
    Y:=StrToInt(copy(str,j,i-j));
    str[i]:='\';
    j:=i+1;
    i:=pos(' ',str);
    if i=0 then
    begin
      cons:='';
      i:=length(str);
      max_con:=StrToInt(copy(str,j,i-j+1));
    end
    else
    begin
      max_con:=StrToInt(copy(str,j,i-j));
      str[i]:='\';
      j:=i+1;
      i:=length(str);
      cons:=copy(str,j,i-j+1);
    end;
    init(fMain,d_ID,arr_pos);
    pic.Left:=X;
    pic.Top:=Y;
    max_connects:=max_con;
    ID.Left:=pic.Left;
    ID.Top:=pic.Top+pic.Height;
    if curr_ID < d_ID+1 then FromString:=d_ID+1
    else Fromstring:=curr_ID;

end;

//--Восстановление коммутатора из строки--//
function TSwitch.FromString(Owner:TWinControl; str:string; arr_pos:integer; curr_ID:integer):integer;
var t_name, cons:string;
    d_ID, X, Y, max_con:integer;
    i,j:integer;
begin
    j:=1;
    i:=pos(' ',str);
    t_name:=copy(str,j,i-j);
    str[i]:='\';
    j:=i+1;
    i:=pos(' ',str);
    d_ID:=StrToInt(copy(str,j,i-j));
    str[i]:='\';
    j:=i+1;
    i:=pos(' ',str);
    X:=StrToInt(copy(str,j,i-j));
    str[i]:='\';
    j:=i+1;
    i:=pos(' ',str);
    Y:=StrToInt(copy(str,j,i-j));
    str[i]:='\';
    j:=i+1;
    i:=pos(' ',str);
    if i=0 then
    begin
      cons:='';
      i:=length(str);
      max_con:=StrToInt(copy(str,j,i-j+1));
    end
    else
    begin
      max_con:=StrToInt(copy(str,j,i-j));
      str[i]:='\';
      j:=i+1;
      i:=length(str);
      cons:=copy(str,j,i-j+1);
    end;
    init(fMain,d_ID,arr_pos);
    pic.Left:=X;
    pic.Top:=Y;
    max_connects:=max_con;
    //connections:=cons;
    ID.Left:=pic.Left;
    ID.Top:=pic.Top+pic.Height;
  if curr_ID < d_ID+1 then FromString:=d_ID+1
  else Fromstring:=curr_ID;
end;

//--Установить позицию в массиве для подключения--//
function TConnection.SetArrayPos(a_pos:integer; number:integer):integer;
begin
  case number of
    1:array_pos1:=a_pos;
    2:array_pos2:=a_pos;
    else begin end;
  end;
  SetArrayPos:=0;
end;

//--Получить позицию в массиве--//
function TNetObject.GetArrayPos():integer;
begin
  GetArrayPos:=array_pos;
end;

//--Получить ID устройства--//
function TNetObject.getDeviceID():integer;
begin
  getDeviceID:=device_ID;
end;

//--Получить координаты--//
function TNetObject.getX(mode:integer):integer;
begin
  case mode of
    0: getX:=pic.Left;
    1: getX:=pic.Left + pic.Width div 2;
    else begin getX:=0; end;
  end;
end;

function TNetObject.getY(mode:integer):integer;
begin
  case mode of
    0: getY:=pic.Top;
    1: getY:=pic.Top + pic.Height div 2;
    else begin getY:=0; end;
  end;
end;

end.
