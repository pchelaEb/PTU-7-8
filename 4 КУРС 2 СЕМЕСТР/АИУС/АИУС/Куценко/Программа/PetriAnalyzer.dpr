program PetriAnalyzer;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Matrix in 'MATRIX.PAS';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
