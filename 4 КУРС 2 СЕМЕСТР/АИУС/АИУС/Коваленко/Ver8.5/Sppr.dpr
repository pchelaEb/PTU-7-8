program Sppr;

uses
  Forms,
  UMain in 'UMain.pas' {Main},
  UCore in 'UCore.pas',
  UProp in 'UProp.pas' {Prop},
  About in 'About.pas' {AboutBox},
  Tables in 'Tables.pas' {Form1},
  Unit1 in 'Unit1.pas' {DataModule1: TDataModule},
  UFirstTerms in 'UFirstTerms.pas' {FirstTerms},
  UKnowledge in 'UKnowledge.pas' {Knowledge},
  ClassModule in 'ClassModule.pas',
  Uravn in 'Uravn.pas' {FormUravnenie},
  UData in 'UData.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFirstTerms, FirstTerms);
  Application.CreateForm(TKnowledge, Knowledge);
  Application.CreateForm(TFormUravnenie, FormUravnenie);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
