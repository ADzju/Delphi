program AlsZF_GMP;

uses
  Vcl.Forms,
  TR_forma in 'TR_forma.pas' {Form2},
  Wywod_TR in 'Wywod_TR.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '“€говый расчет окт€брь 2016';
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
