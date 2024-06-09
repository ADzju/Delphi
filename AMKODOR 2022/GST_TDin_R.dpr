program GST_TDin_R;

uses
  Vcl.Forms,
  GST_dinam in 'GST_dinam.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
