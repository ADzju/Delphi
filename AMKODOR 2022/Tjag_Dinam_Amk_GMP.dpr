program Tjag_Dinam_Amk_GMP;

uses
  Vcl.Forms,
  TDinR_forma in 'TDinR_forma.pas' {Form2},
  Wywod_TDinR in 'Wywod_TDinR.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ׂÿדמגûי נאסקוע';
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
