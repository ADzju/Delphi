unit Wywod_TR;

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

Procedure R_r2(Nper:integer);
begin
// Rkin:=Rk;  Rsil:=Rk;
Rkin:=Rk;  Rsil:=Rk;
(*
v1:=3.6*Rk*n_d*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
Rkin:=Rk;  Rsil:=Rk;
if {(V1>2)and }(V1<10) then Rkin:=Rst-(10-V1)*(Rst-Rk)/10 else Rkin:=Rst;
             if V1<10 then Rsil:=Rst-(10-V1)*(Rst-Rk)/10{/0.993}
        else if V1>=10 then Rsil:=Rst;} *)
if {(V1>2)and }(V1<10) then Rkin:=Rst-(10-V1)*(Rst-Rk)/10 else Rkin:=Rst;
             if V1<10 then Rsil:=Rst-(10-V1)*(Rst-Rk)/10{/0.993}
        else if V1>=10 then Rsil:=Rst;
            end;

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
             R_r2(i);
            // if V1>1e-2 then Rad:=Rst else Rad:=Rk;
             nt:=V1/(3.6*Rkin/30*pi/Imost/Ikp[i]);
          if nt<MaxValue(RezTR.nturb) then begin
             M:= Interpol1(nt,RezTR.nturb,RezTR.Mturb);
             Ser[i].Add(M*Imost*Ikp[i]/Rsil/1000*nu[i]*NuMost*NuRom,FloatTostr(V1));
          end;
      end;
       V1:=V1+0.25;
      //  Rad:=Rst;
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
             R_r2(i);
           //  if V1>1e-2 then Rad:=Rst else Rad:=Rk;
             nt:=V1/(3.6*Rkin/30*pi/Imost/Ikp[Nfor+i]);
          if nt<MaxValue(RezTR.nturb) then begin
             M:= Interpol1(nt,RezTR.nturb,RezTR.Mturb);
             Ser[i].Add(M*Imost*Ikp[Nfor+i]/Rsil/1000*nu[i]*NuMost*NuRom,FloatTostr(V1));
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
