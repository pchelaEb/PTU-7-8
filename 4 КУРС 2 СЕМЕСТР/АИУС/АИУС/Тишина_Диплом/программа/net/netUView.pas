unit netUView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls, ImgList;


type
  TnetView = class(TForm)
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


procedure TnetView.FormCreate(Sender: TObject);
var
  Indent : Integer;
begin
  Indent := 48;
  SendMessage(Memo.Handle, EM_SETTABSTOPS, 1, Lparam(@Indent));
  SendMessage(Memo.Handle, EM_SETMARGINS, EC_LEFTMARGIN, 8);
end;


procedure TnetView.ButtonSaveClick(Sender: TObject);
begin
  if not SaveDialog.Execute then Exit;
  Memo.Lines.SaveToFile(SaveDialog.FileName);
end;


procedure TnetView.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;


end.
