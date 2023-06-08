unit UView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls, ImgList;


type
  TView = class(TForm)
    ToolBar: TToolBar;
    ButtonSave: TToolButton;
    ButtonClose: TToolButton;
    Memo: TRichEdit;
    ImageList: TImageList;
    SaveDialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
  end;


implementation

{$R *.dfm}


procedure TView.FormCreate(Sender: TObject);
var
  Indent : Integer;
begin
  Indent := 48;
  SendMessage(Memo.Handle, EM_SETTABSTOPS, 1, Lparam(@Indent));
  SendMessage(Memo.Handle, EM_SETMARGINS, EC_LEFTMARGIN, 8);
end;


procedure TView.ButtonSaveClick(Sender: TObject);
begin
  if not SaveDialog.Execute then Exit;
  Memo.Lines.SaveToFile(SaveDialog.FileName);
end;


procedure TView.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;


end.
