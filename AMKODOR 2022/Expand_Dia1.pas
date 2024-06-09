unit Expand_Dia1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine, Printers,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series, Vcl.StdCtrls;

Const
ColorArray:array [1..20] of TColor = (clRed,clOlive,clYellow,clGreen,clMaroon,clNavy,clPurple,clTeal,clGray,
  clSilver,clLime,clBlue,clFuchsia,clAqua,clMoneyGreen,clSkyBlue,clCream,clMedGray,clNone,clBlack);

  Mx_prich=12;

Procedure ExpandDia_1;
type
  TExpandForm = class(TForm)
    Chart1: TChart;
    Button2: TButton;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series6: TLineSeries;
    Series5: TLineSeries;
    Series14: TBarSeries;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog1: TPrintDialog;
    PageSetupDialog1: TPageSetupDialog;
    Label1: TLabel;
    Series7: TLineSeries;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  ExpandForm: TExpandForm;

//Const Mx_prich=18;
implementation

uses Out_Graph2015,obrotk2015,stat2015;
{$R *.dfm}

Procedure ExpandDia_1;

var i,i2,j,x1,x2,Ns1,Ns2,Ns3,Nnew,N_ser:integer;
    Nakopl,K_Interval,Expl_sum,SumNundCol,tprev,SumI,t50,tz50: double;
    MPir: Mod_Weib;
    Text_Name,x2str: AnsiString;
    KolmStr: string;

Procedure DiaBarCol(ChartOne: TChart; i,Transpar:integer; St: string );
  begin
    with ChartOne do begin
     AddSeries(TBarSeries.Create(ChartOne));
     Series[SeriesCount - 1].Clear;
     Series[SeriesCount - 1].Marks.Visible := false;
     Series[SeriesCount - 1].Transparency := Transpar; //20;
     Series[SeriesCount - 1].Title:=St;
     if i<10 then Series[SeriesCount - 1].Color:=ChartOne.ColorPalette[i]  // �����!
     else Series[SeriesCount - 1].Color:=ColorArray[i];

      end;
    end;

                                        Begin
     Expandform.Enabled;
     x1:=0;  x2:=0; SumNund:=0; SumNundCol:=0;  Expl_sum:=0;
     Setlength(F_OutGar, 1+high(Hist_Arr));
     for i:=0  to Mx_prich do begin Sum_PrichRow[i]:=0; Sum_PrichCol[i]:=0;
                                         end;
     for j:=0  to high(Hist_Arr) do begin
               SumNund:=SumNund+Hist_Arr[j].Nund;
      for i:=0  to Mx_prich do Sum_PrichRow[i]:=Sum_PrichRow[i]+Hist_Arr[j].Npr[i];
                         end;
       with ExpandForm do begin
  for i:=Chart1.SeriesCount-1 downto 8{Ns1} do Chart1.Series[i].Free;//�������� ������� ������ ����� �����
    if MPirsN.Executed then begin MPirsN.Unsens:=0; MPirsN.Kol_Nakopl:=0; end;
    if MPirsS.Executed then begin MPirsS.Unsens:=0; MPirsS.Kol_Nakopl:=0; end;
        MGenet.Unsens:=0; MPir.Unsens:=0;  MSmirn.Unsens:=0;
        MPir.Kol_Nakopl:=0;
        MSmirn.Kol_Nakopl:=0;
        MGenet.Kol_Nakopl:=0;
      Screen.Cursor:=crHourGlass;
    Series1.Clear;  Series2.Clear;  Series3.Clear; Series4.Clear; Series5.Clear;
    Series6.Clear; Series7.Clear;   Series14.Clear;
     Ns1:=Chart1.SeriesCount;  // =7 (�2661 2661_01 2013)
        Nnew:=0;  Nakopl:=0;
      ColorPalettes.ApplyPalette( Chart1, 5{ 5 4}{7} );
       Chart1.Legend.Symbol.Continuous:=True;

      for I := 1 to Mx_prich do  // 18
           if Sum_PrichRow[i]>0 then
          begin   // �.�. �������-������� � ������� ����
          DiaBarCol(Chart1, i, 0,  Vidy_Otkazov[i].Nazv_Prich +', ����� '+ intToStr(Round(Vidy_Otkazov[i].Dolya))
          +' ('+ Format('%3.1f', [100*Vidy_Otkazov[i].Dolya/Kol_Izw])+'%)'+' �������'); //);  //������ ����� ����� ��������
             inc(Nnew);  // =5 (�2661 2661_01 2013)
                  end;
      if SumNund>0 then
                  begin
         DiaBarCol(Chart1, i, 0, '�� �����.');  //������ ����� �����
                end;
     for i:=0 to high(Hist_Arr) do begin  //i111 ���� ���� ���������
        x2:=round(Hist_Arr[i].time);
        K_Interval:=100/(x2-x1);           // ��������, �������� ���� ��������� � 100 �����
    F_OutGar[i]:=CDF_Gauss(SRED,SKO,x2);   // ���������� ���� �������� �� ��������
    Expl_sum:=Expl_sum+Hist_Arr[i].Sum;    // ����� ��������� ������� � ������������
        N_ser:=0;
        for i2 := 1 to Mx_prich do  // 18 ������ ����� �������
    if Sum_PrichRow[i2]>0 then
         begin
         x2Str:=FloatToStr(x2);
         Sum_PrichCol[i2]:=Sum_PrichCol[i2]+Hist_Arr[i].Npr[i2];
    Chart1.series[Ns1+N_ser].Add(Hist_Arr[i].Npr[i2]*K_Interval/Izd_Prived,x2str,ColorArray[i2]{Palette[i2]});  // ++++++
//    Chart2.series[Ns2+N_ser].Add(Sum_PrichCol[i2]/Izd_Prived*KolOtk/Kol_izw,x2str,Chart1.ColorPalette[i2]);
  if SumNund>0 then                              // ������ ��� ��������
           SumNundCol:=SumNundCol+Hist_Arr[i].Nund;
         series14.Add(Hist_Arr[i].Nund*K_Interval/Izd_Prived,x2str);
        inc(N_ser);
        end;

      if MPirsN.Executed then begin   //222
    MPirsN.Unsens:=MPirsN.Unsens+MPirsN.F_Weib[i];                    // ����������� ��� ����� ��������������
    MPirsN.Kol_Nakopl:=MPirsN.Kol_Nakopl+MPirsN.Kol_F_Priv[i];        // ����������� ��������� ������
      end;
      if MPirsS.Executed then begin   //222
    MPirsS.Unsens:=MPirsS.Unsens+MPirsS.F_Weib[i];                    // ����������� ��� ����� ��������������
    MPirsS.Kol_Nakopl:=MPirsS.Kol_Nakopl+MPirsS.Kol_F_Priv[i];        // �����������
            end;
      if MPirsN.Executed then Mpir:=MPirsN else Mpir:=MPirsS;
      if MPir.Executed then begin
    Chart1.series[1].Title:='������ �� ������� � ������ ��������������';
    Chart1.series[2].Title:='������ �� �������';
    Series2.Add(MPir.F_Weib[i]     *K_Interval*MPir.K_powtor,x2str);{Ch1 Line ����������������� ��������� ������ �� �������}
    Series3.Add(MPir.Kol_F_priv[i] *K_Interval/Izd_Prived,x2str); {Ch1 Line �������� ��������� ������ �� �������}
             end;                       ///222
      if MGenet.Executed then begin   //333
    Chart1.series[4].Title:='������ ������������ � ������ ��������������';
    Chart1.series[6].Title:='������ "������������"';
    MGenet.Unsens:=MGenet.Unsens+MGenet.F_Weib[i];
    MGenet.Kol_Nakopl:=MGenet.Kol_Nakopl+MGenet.Kol_F_Priv[i];
    Series5.Add(MGenet.F_Weib[i]    *MGenet.K_powtor*K_Interval,x2str); {Ch1 ������������ ������ ��� ����� ��������������}
    Series6.Add(MGenet.Kol_F_priv[i]/Izd_Prived     *K_Interval,x2str); {Ch1 �������� �������. ��������� ������}

      end;                      //333
      if MSmirn.Executed then begin  //444
    MSmirn.Kol_Nakopl:=MSmirn.Kol_Nakopl+MSmirn.Kol_F_Priv[i];
    Series4.Add(MSmirn.Kol_F_Priv[i]{*100}*K_Interval/Izd_Prived,x2str); {Ch1 �������� ��������� ������ �� ��������}
            end;                      //444
    Series1.Add (F_OutGar[i]*100,x2str);                                 //% �������� �� ���������� ��� 1
    Nakopl:=Nakopl+Hist_Arr[i].Sum;
    if Nakopl/Izd_Prived<=1 then
    Series7.Add(Nakopl/Izd_Prived*100,x2str);                            //% �������� �� ���������� ��� 2
                        x1:=x2;
                               end;   // i1111
    for I := 1 to Mx_prich do if Sum_PrichCol[i]>0 then  // 18
    Chart1.series[7].Title:='���������� �������, % �� �����';
    tprev:=0;  t50:=0; tz50:=0;
       for i:=0 to High(MasProbl) do begin
       sumI:=SumI+1/(1-CDF_Gauss(SRED,SKO,MasProbl[i].time));
      if (t50=0) and ((I+1)/Izd_Prived>=0.5) then
        t50:=MasProbl[i].time-(MasProbl[i].time-tprev)*(Frac((I+1)-0.5*Izd_Prived));
      if (tz50=0) and ((SumI)/Izd_Prived>=0.5) then
       tz50:=MasProbl[i].time-(MasProbl[i].time-tprev)*Frac(SumI-0.5*Izd_Prived);
               tprev:=MasProbl[i].time;
             end;  // ������ t50 �� ����������� �������� �������
        if t50=0 then Label2.Caption:='- ������ ������������ ��� ������'
        else begin
        Label2.Caption:='- ��� ����� ��������������: '+Format('%7.1f',[t50])+' �';
        Label3.Caption:='- � ������ ��������������: '+Format('%7.2f',[tz50])+' �';
                   end;
    ExpandForm.Label1.Caption:=Comment+' ('+FloatToStr(Kol_Izd_All)+' ��.,'+IntToStr(Kolotk) +' �������)';
    ExpandForm.Visible:=True;
      Screen.Cursor:=crDefault;
  end;
end;


procedure TExpandForm.Button2Click(Sender: TObject);
begin
    Printer.PrinterIndex:=0;
    Printer.Orientation:=poLandscape;//poPortrait
 ExpandForm.PrintScale:=poPrintToFit;//poProportional;//
 PrinterSetupDialog1.Execute;
 ExpandForm.Print;
   end;
   end.


 //  Form2.PrintDialog1.Execute;
//  Printdialog1.Create(Form2);
//  PrinterSetupDialog1.Execute;
//  PrintDialog1.Execute;

