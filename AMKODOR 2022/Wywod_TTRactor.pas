unit Wywod_TTRactor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series,  System.Math,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Chart1: TChart;
    Series1: TFastLineSeries;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog1: TPrintDialog;
    PageSetupDialog1: TPageSetupDialog;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
Procedure OutTr_F;
Procedure OutTr_R;
var
  Form1: TForm1;

implementation

{$R *.dfm}
uses TR_forma;
var
i: integer;


Procedure OutTR_F;
var Ser:array [0..50] of TLineSeries;
    M,nt: double;
begin
   with Form1 do begin
     Chart1.SeriesList.Clear;
     ColorPalettes.ApplyPalette(Chart1, 6{7} );
 for I := 1 to Nfor+3 do begin
 Ser[i]:=TLineSeries.Create(Chart1);
 Chart1.AddSeries(Ser[i]);
   Ser[i].Title:='Передача '+IntToStr(i);
   Ser[i].LinePen.Width := 3;
  end;
   Ser[Nfor+1].LinePen.Width := 1;
   Ser[Nfor+1].Title:='Сопротивление при f=0.02';
   Ser[Nfor+2].LinePen.Width := 1;
   Ser[Nfor+2].Title:='Сопротивление при f=0.03';
   Ser[Nfor+3].LinePen.Width := 1;
   Ser[Nfor+3].Title:='Сопротивление при f=0.05';

        V1:=0;
  repeat
    Ser[Nfor+1].Add(Ga*9.81e-3*0.02,FloatTostr(V1));
    Ser[Nfor+2].Add(Ga*9.81e-3*0.03,FloatTostr(V1));
    Ser[Nfor+3].Add(Ga*9.81e-3*0.05,FloatTostr(V1));
    for I := 1 to Nfor do begin
             nt:=V1/(3.6*Dsh[1]/2/30*pi/Imost/Ikp[i]);
          if nt<MaxValue(RezTR.nturb) then begin
             M:= Interpol2(nt,RezTR.nturb,RezTR.Mturb);
             Ser[i].Add(2*M*Imost*Ikp[i]/Dsh[1]/1000*nu[i]*NuMost*NuRom,FloatTostr(V1));
          end;
      end;
       V1:=V1+0.25;
      until ((i<>Nfor) and (nt>MaxValue(RezTR.nturb)));
      Chart1.Title.Text.Clear;
      Chart1.Title.Text.Add('Результат тягового расчета: '+Form2.Edit1.Text);
 Form1.Visible:=True;
  // Chart1.Visible:=true;
   end;
  end;

Procedure OutTR_R;
var Ser:array [0..50] of TLineSeries;
    M,nt: double;
begin
   with Form1 do begin
     Chart1.SeriesList.Clear;
     ColorPalettes.ApplyPalette(Chart1, 6{7} );
 for I := 1 to Nrev+3 do begin
 Ser[i]:=TLineSeries.Create(Chart1);
 Chart1.AddSeries(Ser[i]);
   Ser[i].Title:='Передача ЗХ'+IntToStr(i);
   Ser[i].LinePen.Width := 3;
  end;
   Ser[Nrev+1].LinePen.Width := 1;
   Ser[Nrev+1].Title:='Сопротивление при f=0.02';
   Ser[Nrev+2].LinePen.Width := 1;
   Ser[Nrev+2].Title:='Сопротивление при f=0.03';
   Ser[Nrev+3].LinePen.Width := 1;
   Ser[Nrev+3].Title:='Сопротивление при f=0.05';

        V1:=0;
  repeat
    Ser[Nrev+1].Add(Ga*9.81e-3*0.02,FloatTostr(V1));
    Ser[Nrev+2].Add(Ga*9.81e-3*0.03,FloatTostr(V1));
    Ser[Nrev+3].Add(Ga*9.81e-3*0.05,FloatTostr(V1));
    for I := 1 to Nrev do begin
             nt:=V1/(3.6*Dsh[1]/2/30*pi/Imost/Ikp[Nfor+i]);
          if nt<MaxValue(RezTR.nturb) then begin
             M:= Interpol2(nt,RezTR.nturb,RezTR.Mturb);
             Ser[i].Add(2*M*Imost*Ikp[Nfor+i]/Dsh[1]/1000*nu[i]*NuMost*NuRom,FloatTostr(V1));
          end;
      end;
       V1:=V1+0.25;
      until ((i<>Nrev) and (nt>MaxValue(RezTR.nturb)));
      Chart1.Title.Text.Clear;
      Chart1.Title.Text.Add('Результат тягового расчета: '+Form2.Edit1.Text);
 Form1.Visible:=True;
  // Chart1.Visible:=true;
   end;
  end;

//end;
procedure TForm1.Button1Click(Sender: TObject);
begin
     // Form2.Printer..PrinterIndex:=0;
     // PrinterSetup.Orientation:=poLandscape;//poPortrait
   Form1.PrintScale:=poPrintToFit;//poProportional;//
    PrinterSetupDialog1.Execute;
    Form1.Print;
end;

end.
