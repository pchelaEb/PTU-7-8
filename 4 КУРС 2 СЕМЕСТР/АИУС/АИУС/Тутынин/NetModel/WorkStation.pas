unit WorkStation;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

  type
    TWorkStation=class(TObject)
      private
        ID: TLabel;
        pic:TImage;
      public
        procedure init(Owner:TWinControl; i:integer);
        procedure DropEnd(Sender, Target: TObject; X, Y: Integer);
    end;
implementation

  procedure TWorkStation.init(Owner:TWinControl; i:integer);
  begin
    pic:=TImage.Create(Owner);
    pic.Parent:=Owner;
    pic.Picture.LoadFromFile('PC.bmp');
    pic.Transparent:=true;
    pic.Width:=48;
    pic.Height:=48;
    pic.Left:=(Mouse.CursorPos.X-pic.Parent.Left-20); //div 48 *48;
    pic.Top:=(Mouse.CursorPos.Y-pic.Parent.Top-60); //div 48 *48;
    pic.DragKind:=dkDock;
    pic.DragMode:=dmAutomatic;
    pic.OnEndDock:=DropEnd;
    ID:=TLabel.Create(Owner);
    ID.Parent:=Owner;
    ID.Caption:='PC '+IntToStr(i);
    //ID.Width:=48;
    ID.Left:=pic.Left;
    ID.Top:=pic.Top+pic.Height;//-ID.Height;
    ID.Transparent:=true;

  end;
  
  procedure TWorkStation.DropEnd(Sender, Target: TObject; X, Y: Integer);
  begin
    ID.Left:=pic.Left;
    ID.Top:=pic.Top+pic.Height;
  end;
end.
