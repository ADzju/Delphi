program Relia_A_2024;


uses
  Forms,
  obrotk2022 in 'obrotk2022.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  LNview2022 in 'LNview2022.pas' {LNview},
  OutG_2022_5 in 'OutG_2022_5.pas' {Form5},
  GlVar_stat2022 in 'GlVar_stat2022.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '������ ���������� �.�. ����� � v6.0 (2024)';
  Application.HelpFile := '';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm5, Form5);
  //Application.CreateForm(TForm3, Form3);
  //Application.CreateForm(TLNview, LNview);
  Application.Run;
end.
