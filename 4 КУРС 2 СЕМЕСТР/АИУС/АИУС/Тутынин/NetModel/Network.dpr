program Network;

uses
  Forms,
  NetModel in 'NetModel.pas' {fMain},
  NetObj in 'NetObj.pas',
  Properties in 'Properties.pas' {Settings_Form};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TSettings_Form, Settings_Form);
  Application.Run;

end.
