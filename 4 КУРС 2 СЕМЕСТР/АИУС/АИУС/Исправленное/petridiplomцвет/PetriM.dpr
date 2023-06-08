program PetriM;

uses
  Forms,
  UMain in 'UMain.pas' {Main},
  UEngine in 'UEngine.pas',
  USim in 'USim.pas' {Sim},
  UAmount in 'UAmount.pas' {Amount},
  UView in 'UView.pas' {View},
  UAbout in 'UAbout.pas' {About},
  UHelp in 'UHelp.pas' {Help};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PetriM';
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TView, View);
  Application.CreateForm(TAbout, About);
  Application.CreateForm(THelp, Help);
  Application.Run;
end.
