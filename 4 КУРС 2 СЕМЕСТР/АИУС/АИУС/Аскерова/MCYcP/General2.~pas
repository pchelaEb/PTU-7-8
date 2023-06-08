unit General2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TGeneralForm2 = class(TForm)
    Memo1: TMemo;
//    procedure BitBtn1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
//    procedure InsertFileInMemo(Memp: TMemo; FileName: string; ReplaceSel: Boolean);
//    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GeneralForm2: TGeneralForm2;

implementation

{$R *.dfm}

//procedure TGeneralForm2.BitBtn1Click(Sender: TObject);
//begin
//GeneralForm2.Close;
//end;

procedure TGeneralForm2.Memo1Change(Sender: TObject);
begin
memo1.Lines.LoadFromFile('helper.txt');
end;

//procedure TGeneralForm2.InsertFileInMemo(Memp: TMemo; FileName: string; ReplaceSel: Boolean);
//var
//  Stream: TMemoryStream;
//  NullTerminator: Char;
//begin
//  Stream:=TMemoryStream.Create;
//  try
//    Stream.LoadFromFile('1.txt');
//    Stream.Seek(0,2);
//    NullTerminator:=#0;
//    Stream.Write(NullTerminator,1);
//    if not ReplaceSel then Memo1.SelLength:=0;
//    SendMessage(Memo1.Handle, EM_ReplaceSel, 0, LongInt(Stream.Memory));
//  finally
//    Stream.Free;
//  end;
//  end;

end.
