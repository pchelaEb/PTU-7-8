program DemoRSA;

uses
  Forms,
  Windows,
  Umain_demo in 'Umain_demo.pas' {Fdemorsa},
  U__math in 'U__math.pas',
  Ursa in 'Ursa.pas',
  Umath in 'Umath.pas';

{$R *.res}

begin
CreateFileMapping(HWND($FFFFFFFF), nil, PAGE_READWRITE, 0, 1024, 'DemoRSA');
if GetLastError <> ERROR_ALREADY_EXISTS then  begin
  Application.Initialize;
  Application.CreateForm(TFdemorsa, Fdemorsa);
  Application.Run
   end  else
   begin
    Application.MessageBox('Программа уже выполняется!', 'Внимание');
    halt;
   end;
end.
