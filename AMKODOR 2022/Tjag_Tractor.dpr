program Tjag_Tractor;

uses
  Vcl.Forms,
  TTractor_forma in 'TTractor_forma.pas' {Form2},
  Wywod_TTRactor in 'Wywod_TTRactor.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
