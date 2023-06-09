unit demo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, WizardNN;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NeuralNetwork : TWizardNeuralNetwork;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  NeuralNetwork := TWizardNeuralNetwork.Create; // ������� ���������
  NeuralNetwork.LoadFromWizardFile(ExtractFilePath(paramstr(0))+'sum.nnw'); // ������ ��������� �� �� �����
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with NeuralNetwork do
  begin
    InputValues['s1'] := StrToFloat(Edit1.Text); // ������������� ����� ��
    InputValues['s2'] := StrToFloat(Edit2.Text); // 
    Compute;				         // ������������ � ������������� ��
    Label1.Caption := FloatToStr(OutputValues['res']); // ������� ��������� ��������
  end;
end;

end.
