program enets;

uses
  Forms,
  UMain in 'UMain.pas' {Main},
  UCore in 'UCore.pas',
  UProp in 'UProp.pas' {Prop},
  About in 'About.pas' {AboutBox},
  Tables in 'Tables.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
