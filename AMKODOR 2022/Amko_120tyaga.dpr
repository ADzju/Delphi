program Amko_120tyaga;

uses
  Vcl.Forms,
  tyaga120_6x3 in 'tyaga120_6x3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
