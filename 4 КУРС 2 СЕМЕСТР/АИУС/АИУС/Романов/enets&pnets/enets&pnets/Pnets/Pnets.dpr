program enets;

uses
  Forms,
  UMain in 'UMain.pas' {Main},
  UCore in 'UCore.pas',
  UProp in 'UProp.pas' {Prop},
  About in 'About.pas' {AboutBox},
  UView in 'UView.pas' {View},
  Tables in 'Tables.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
