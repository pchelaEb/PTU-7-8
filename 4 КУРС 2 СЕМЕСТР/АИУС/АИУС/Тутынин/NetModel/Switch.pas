unit NetObj;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus;

  type
    TNetObject=class
    private
        ID:TLabel;
        pic:TImage;
        menu:TPopupMenu;
        con_x:integer;
        con_y:integer;
    public
        status:char;
        procedure Remove(Sender: TObject);
        procedure init(Owner:TWinControl);
        procedure DropEnd(Sender, Target: TObject; X, Y: Integer);
        //procedure EnableMove(Sender: TObject);
    end;

  type
    TSwitch=class(TNetObject)
      public
        procedure init(Owner:TWinControl; i:integer); overload;
    end;

  type
    TWorkSation=class(TNetObject)
      public
        procedure init(Owner:TWinControl; i:integer); overload;
    end;

implementation

  procedure TNetObject.init(Owner:TWinControl);
  begin
    pic:=TImage.Create(Owner);
    pic.Parent:=Owner;
    pic.DragKind:=dkDock;
    pic.OnEndDock:=DropEnd;
    ID:=TLabel.Create(Owner);
    ID.Parent:=Owner;
    pic.DragMode:=dmAutomatic;
    menu:=TPopupMenu.Create(pic);
    {menu.Items.Add(TMenuItem.Create(menu));
    menu.Items[0].OnClick:=EnableMove;
    menu.Items[0].Caption:='Переместить';
    menu.Items.Add(TMenuItem.Create(menu));
    menu.Items[1].Caption:='-';}
    menu.Items.Add(TMenuItem.Create(menu));
    menu.Items[0].Caption:='Удалить';
    menu.Items[0].OnClick:=Remove;
    pic.PopupMenu:=menu;
    status:='g';
  end;

  procedure TSwitch.init(Owner:TWinControl; i:integer);
  begin
    init(Owner);
    pic.Picture.LoadFromFile('Switch.bmp');
    pic.Transparent:=true;
    pic.Width:=64;
    pic.Height:=12;
    pic.Left:=(Mouse.CursorPos.X-pic.Parent.Left-30);//div 48 *48;
    pic.Top:=(Mouse.CursorPos.Y-pic.Parent.Top-40);//div 48 *48;
    ID.Caption:='Switch '+intToStr(i);
    ID.Left:=pic.Left;
    ID.Top:=pic.Top+pic.Height;//-ID.Height;
    ID.Transparent:=true;
  end;

  procedure TWorkStation.init(Owner:TWinControl; i:integer);
  begin
    init(Owner);
    pic.Picture.LoadFromFile('PC.bmp');
    pic.Transparent:=true;
    pic.Width:=48;
    pic.Height:=48;
    pic.Left:=(Mouse.CursorPos.X-pic.Parent.Left-20); //div 48 *48;
    pic.Top:=(Mouse.CursorPos.Y-pic.Parent.Top-60); //div 48 *48;
    ID.Caption:='PC '+IntToStr(i);
    ID.Left:=pic.Left;
    ID.Top:=pic.Top+pic.Height;//-ID.Height;
    ID.Transparent:=true;
   end;
  {procedure TNetObject.EnableMove(Sender: TObject);
  begin
    pic.DragMode:=dmAutomatic;
  end;   }


  procedure TNetObject.Remove(Sender: TObject);
  begin
   menu.Destroy;
   pic.Destroy;
   ID.Destroy;
   status:='b';
  end;

  procedure TNetObject.DropEnd(Sender, Target: TObject; X, Y: Integer);
  begin
    ID.Left:=pic.Left;
    ID.Top:=pic.Top+pic.Height;
    //pic.DragMode:=dmManual;
  end;
  
end.
 