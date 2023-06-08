program enets;

uses
  Forms,
  UMain in 'UMain.pas' {Main},
  UCore in 'UCore.pas',
  UProp in 'UProp.pas' {Prop},
  About in 'About.pas' {AboutBox},
  UView in 'UView.pas' {View},
  UXq in 'UXq.pas' {ParamXq},
  Unit1 in 'Unit1.pas' {Graf},
  Unit2 in 'Unit2.pas' {Zastavka};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TParamXq, ParamXq);
  Application.CreateForm(TGraf, Graf);
  Application.CreateForm(TZastavka, Zastavka);
  Application.Run;
end.
