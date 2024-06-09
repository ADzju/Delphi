unit Out_Graph_2_2015;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCLTee.Series, VCLTee.TeEngine,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart,Printers,System.Math, Vcl.StdCtrls,
  Vcl.Grids, VclTee.TeeGDIPlus;

  Const
ColorArray:array [1..20] of TColor = (clRed,clOlive,clYellow,clGreen,clMaroon,clNavy,clPurple,clTeal,clGray,
  clSilver,clLime,clBlue,clFuchsia,clAqua,clMoneyGreen,clSkyBlue,clCream,clMedGray,clNone,clBlack);

  Procedure Histogram_Exp;

  type
  TForm3 = class(TForm)
    Chart3: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TBarSeries;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Label10: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Prodolgenie: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ProdolgenieClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

// procedure Histogram_Exp(HistEx: Hist40);
var
  Form3: TForm3;
  Zenz:real;

implementation
 uses GLVar_stat2022,OutG_2022_5, obrotk2022;
 {$R *.dfm}


Procedure Histogram_Exp;
 label Vis;
var i,i2,j,x1,x2,N_ser:integer;
   flag90,flag80,flag20,flag10,flag50:boolean;
    Nakopl,sumI,K_Interval,Expl_sum,Sum_Expl,Sum_Proiz,Sum_Pokup,Sum_Konstr,Sum_UnKnow,tprev,t50,tz50: double;
    RR:string;
 begin
 with Form3 do begin
 // HistEx
      for i:=0  to Mx_prich do  NoNul_PrichRow[i]:=false;
      for j:=0  to 30 do for i:=0  to Mx_prich do
                    NoNul_PrichRow[i]:=NoNul_PrichRow[i] and (Hist_Stol[j].Npr[i]>0);

        flag90:=true; flag50:=true;
       x1:=0;  x2:=0;  Nakopl:=0; //MaxValue(MReal_Hist[0]);
    Setlength(F_OutGar, 30);
       t50:=0; tz50:=0;  SumI:=0;
    Label10.Caption:=Comment;
 (* Chart1BarSeries1.Marks.Style := smsLabel;
    Chart1BarSeries1.ShowInLegend := true;  LSeries.AddBar(0, '', clBlue);   *)
   Series1.Clear;  Series2.Clear;  Series3.Clear;
   N_ser:=Chart3.SeriesCount;
      for i:=Chart3.SeriesCount-1 downto 4 do Chart3.Series[i].Free;
  for I := 0{1} to Mx_prich do
    if NoNul_PrichRow[i] then begin
     Chart3.AddSeries(TBarSeries.Create(Chart3));
     Chart3.Series[Chart3.SeriesCount - 1].Clear;
     Chart3.Series[Chart3.SeriesCount - 1].Marks.Visible := False;
 //  Chart3.Series[Chart3.SeriesCount - 1].Color := 260+i;
     Chart3.Series[Chart3.SeriesCount - 1].Transparency := 30;
     Chart3.series[Chart3.SeriesCount - 1].Title:=Vidy_Otkazov[i].Nazv_Prich;
 //    N_ser:=Chart3.SeriesCount;      // ��������� ����� 8!!!
    end;
         tprev:=0;
       for i:=0 to High(MasProbl) do begin
       sumI:=SumI+1/(1-CDF_Gauss(SRED,SKO,MasProbl[i].time));
       // MGenet.F_norm[i]:=CDF_Gauss(Mu,Sig,(x1+x2)/2);   // ���������� ������ �� ���������� (��������������)
      if (t50=0) and ((I+1)/Izd_Prived>=0.5) then
        t50:=MasProbl[i].time-(MasProbl[i].time-tprev)*(Frac((I+1)-0.5*Izd_Prived));
      if (tz50=0) and (SumI/Izd_Prived>=0.5) then
       tz50:=MasProbl[i].time-(MasProbl[i].time-tprev)*Frac(SumI-0.5*Izd_Prived);
               tprev:=MasProbl[i].time;
             end;  // for i...
        Label2.Caption:='- ��� ����� ��������������:'+Format('%7.1f',[t50])+' �';
        Label3.Caption:='- � ������ ��������������:  '+Format('%7.2f',[tz50])+' �';
        Label5.Caption:='������� ����� ��������������: '+Format('%7.1f',[SRED])+' �';
        Label6.Caption:='��� ������� ��������������:    '+Format('%7.1f',[SKO]) +' �';
        Label7.Caption:='���-�� �������������� �������:'+FloatToStr(Kol_Izd_All)+' ��.';
        Label8.Caption:='����� ���-�� ������� �������: '+IntToStr(KolOtk) +' ��.';

                for i:=0 to 30 do
        begin  //1111
        x2:=round(Hist_Stol[i].time);
        Nakopl:=Nakopl+Hist_Stol[i].Sum;
        F_OutGar[i]:=CDF_Gauss(SRED,SKO,x2);            //���������� ���� �������� �� ��������
        K_Interval:=100/(x2-x1);                      // � 100% �� 100 �����
    Series1.Add( Nakopl*100/Izd_Prived,FloatToStr(x2)); // % ����������� ����. �� ������������ �-��
    Series2.Add( Nakopl/(1-F_OutGar[i])*100/Izd_Prived,FloatToStr(x2)); // % ����������� ����. �� ������������ �-��
    Series3.Add(F_OutGar[i]*100,FloatToStr(x2));        //% �������� �� ����������
       N_ser:=4;
         for i2 := 0 to Mx_prich+1 do  // ������ ����� �������
         if NoNul_PrichRow[i2] then begin
          Chart3.series[N_ser].Add(Hist_Stol[i].Npr[i2]*K_Interval/Izd_Prived,FloatToStr(x2));
            inc(N_ser);
        end;
         x1:=x2;   // if Nakopl/(1-F_OutGar[i])/Izd_Prived>1 then goto Vis; - ��� ����������� �������
        end;
    end;
    Vis: Form3.Visible:=True;
  end;

  procedure TForm3.Button1Click(Sender: TObject);
begin
   Printer.PrinterIndex:=0;
   Printer.Orientation:=poLandscape;//poPortrait
   Form3.PrintScale:=poPrintToFit;//poProportional;//
 PrinterSetupDialog1.Execute;
 Form3.Print;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Form3.Destroy;
end;

procedure TForm3.ProdolgenieClick(Sender: TObject);
begin
   Form3.Destroy;
   Form1.Visible:=true;
end;

end.

{ Procedure CntrText(R,i:integer; Text: String);
 var WCells: Integer;
 Stroka:string;
     begin
 WCells:=Form3.StringGrid1.ColWidths[R]-7; //7 - �������������
 Stroka:=Text;
 with Form3.StringGrid1, Form3.StringGrid1.Canvas do
     while TextWidth(Stroka)<WCells do Stroka:=' '+Stroka+' ';
             Stroka:=' '+Stroka;
    Form3.StringGrid1.Cells[R,i]:=Stroka;
       end; }

