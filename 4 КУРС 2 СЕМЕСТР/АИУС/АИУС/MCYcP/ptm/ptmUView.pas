unit ptmUView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList;

type
  TptmView = class(TForm)
    ButtonSave: TButton;
    ImageList: TImageList;
    SaveDialog: TSaveDialog;
    Memo: TMemo;
    procedure ButtonSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ptmView: TptmView;

implementation

{$R *.dfm}

procedure TptmView.ButtonSaveClick(Sender: TObject);
begin
if not SaveDialog.Execute then Exit;
  Memo.Lines.SaveToFile(SaveDialog.FileName);

end;


end.



