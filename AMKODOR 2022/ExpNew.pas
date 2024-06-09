unit ExpNew;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine, Printers,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series, Vcl.StdCtrls;

Procedure ExpanD;
type
  TExpForm = class(TForm)
    PrintDialog1: TPrintDialog;
    PageSetupDialog1: TPageSetupDialog;
    Button2: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series6: TLineSeries;
    Series5: TLineSeries;
    Series14: TBarSeries;
    Series7: TLineSeries;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExpForme: TExpForm;

implementation
//uses Out_Graph2015,obrotk2022,stat2018;

{$R *.dfm}
Procedure ExpanD;

var i,i2,j,x1,x2,Ns1,Ns2,Ns3,Nnew,N_ser:integer;
    Nakopl,K_Interval,Expl_sum,SumNundCol,tprev,SumI,t50,tz50: double;
 //   MPir: Mod_Weib;
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
   //  Series[SeriesCount - 1].Color:=ColorArray[i];

      end;
    end;

  Begin
  (*   Expforme.Enabled;
     x1:=0;  x2:=0; SumNund:=0; SumNundCol:=0;  Expl_sum:=0;
     Setlength(F_OutGar, 1+high(Hist_Arr));
     for i:=0  to Mx_prich do begin Sum_PrichRow[i]:=false; Sum_PrichCol[i]:=0;
                                         end;
     for j:=0  to high(Hist_Arr) do begin
               SumNund:=SumNund+Hist_Arr[j].Nund;
      for i:=0  to Mx_prich do Sum_PrichRow[i]:=Sum_PrichRow[i]+Hist_Arr[j].Npr[i];
                         end;
       with ExpForme do begin
  for i:=Chart1.SeriesCount-1 downto 8{Ns1} do Chart1.Series[i].Free;//очистить столбцы нижней левой диагр
    if MPirsN.Executed then begin MPirsN.Unsens:=0; MPirsN.Kol_Nakopl:=0; end;
    if MPirsS.Executed then begin MPirsS.Unsens:=0; MPirsS.Kol_Nakopl:=0; end;
        MGenet.Unsens:=0; MPir.Unsens:=0;  MSmirn.Unsens:=0;
        MPir.Kol_Nakopl:=0;
        MSmirn.Kol_Nakopl:=0;
        MGenet.Kol_Nakopl:=0;
      Screen.Cursor:=crHourGlass;
    Series1.Clear;  Series2.Clear;  Series3.Clear; Series4.Clear; Series5.Clear;
    Series6.Clear; Series7.Clear;   Series14.Clear;
     Ns1:=Chart1.SeriesCount;  // =7 (А2661 2661_01 2013)
        Nnew:=0;  Nakopl:=0;
      ColorPalettes.ApplyPalette( Chart1, 5{ 5 4}{7} );
       Chart1.Legend.Symbol.Continuous:=True;

      for I := 1 to Mx_prich do  // 18
           if Sum_PrichRow[i]>0 then
          begin   // т.е. события-причины в столбце есть
          if Vidy_Otkazov[i].Dolya>0 then
         // Izd_Prived
//DiaBarCol(Chart1, i, 0,  Vidy_Otkazov[i].Nazv_Prich +', всего '+ intToStr(Round(Vidy_Otkazov[i].Dolya))
  //        +' ('+ Format('%3.1f', [100*Vidy_Otkazov[i].Dolya/Kol_Izw])+'%)'+' случаев'); //);  //нижняя левая диагр основная
      DiaBarCol(Chart1, i, 0,  Vidy_Otkazov[i].Nazv_Prich + ' '+intToStr(Round(Vidy_Otkazov[i].Dolya))
          +' раз ('+ Format('%3.1f', [100*Vidy_Otkazov[i].Dolya/Izd_Prived])+'%'+' на 1 машину)'); //);  //нижняя левая диагр основная
             inc(Nnew);  // =5 (А2661 2661_01 2013)
                  end;
      if SumNund>0 then
                  begin
         DiaBarCol(Chart1, i, 0, 'Не идент.');  //нижняя левая диагр
                end;
     for i:=0 to high(Hist_Arr) do begin  //i111 цикл всей диаграммы
        x2:=round(Hist_Arr[i].time);
        K_Interval:=100/(x2-x1);           // величина, обратная весу интервала в 100 часах
    F_OutGar[i]:=CDF_Gauss(SRED,SKO,x2);   // накопление доли выбывших из гарантии
    Expl_sum:=Expl_sum+Hist_Arr[i].Sum;    // сумма известных отказов в эксплуатации
        N_ser:=0;
        for i2 := 1 to Mx_prich do  // 18 номера видов отказов
    if Sum_PrichRow[i2]>0 then
         begin
         x2Str:=FloatToStr(x2);
         Sum_PrichCol[i2]:=Sum_PrichCol[i2]+Hist_Arr[i].Npr[i2];
    Chart1.series[Ns1+N_ser].Add(Hist_Arr[i].Npr[i2]*K_Interval/Izd_Prived,x2str,ColorArray[i2]);  // ++++++
//    Chart2.series[Ns2+N_ser].Add(Sum_PrichCol[i2]/Izd_Prived*KolOtk/Kol_izw,x2str,Chart1.ColorPalette[i2]);
  if SumNund>0 then                              // отказы без названия
           SumNundCol:=SumNundCol+Hist_Arr[i].Nund;
         series14.Add(Hist_Arr[i].Nund*K_Interval/Izd_Prived,x2str);
        inc(N_ser);
        end;

      if MPirsN.Executed then begin                           // 1
    MPirsN.Unsens:=MPirsN.Unsens+MPirsN.F_Weib[i];                    // накопленные без учета цензурирования
    MPirsN.Kol_Nakopl:=MPirsN.Kol_Nakopl+MPirsN.Kol_F_Priv[i];        // накопленные известные отказы
      end;
      if MPirsS.Executed then begin                           // 2
    MPirsS.Unsens:=MPirsS.Unsens+MPirsS.F_Weib[i];                    // накопленные без учета цензурирования
    MPirsS.Kol_Nakopl:=MPirsS.Kol_Nakopl+MPirsS.Kol_F_Priv[i];        // накопленные
            end;
      if MPirsN.Executed then Mpir:=MPirsN else Mpir:=MPirsS; // 3
      if MPir.Executed then begin                             //
    Chart1.series[1].Title:='Модель по Пирсону с учетом цензурирования';
    Chart1.series[2].Title:='Модель по Пирсону';
    Series2.Add(MPir.F_Weib[i]     *K_Interval*MPir.K_powtor,x2str);{Ch1 Line нецензурированный модельный массив по Пирсону}
    Series3.Add(MPir.Kol_F_priv[i] *K_Interval/Izd_Prived,x2str); {Ch1 Line итоговый модельный массив по Пирсону}
             end;
      if MGenet.Executed then begin                           // 4
    Chart1.series[4].Title:='Модель генетическая с учетом цензурирования';
    Chart1.series[6].Title:='Модель "генетическая"';
    MGenet.Unsens:=MGenet.Unsens+MGenet.F_Weib[i];
    MGenet.Kol_Nakopl:=MGenet.Kol_Nakopl+MGenet.Kol_F_Priv[i];
    Series5.Add(MGenet.F_Weib[i]    *MGenet.K_powtor*K_Interval,x2str); {Ch1 генетическая модель без учета цензурирования}
    Series6.Add(MGenet.Kol_F_priv[i]/Izd_Prived     *K_Interval,x2str); {Ch1 итоговый генетич. модельный массив}

      end;                      //333
      if MSmirn.Executed then begin  //444                    // 5
    MSmirn.Kol_Nakopl:=MSmirn.Kol_Nakopl+MSmirn.Kol_F_Priv[i];
    Series4.Add(MSmirn.Kol_F_Priv[i]{*100}*K_Interval/Izd_Prived,x2str); {Ch1 итоговый модельный массив по Смирнову}
            end;                      //444
    Series1.Add (F_OutGar[i]*100,x2str);                                 //% выбывших из наблюдения рис 1
    Nakopl:=Nakopl+Hist_Arr[i].Sum;
    if Nakopl/Izd_Prived<=1 then
    Series7.Add(Nakopl/Izd_Prived*100,x2str);                            //% выбывших из наблюдения рис 2
                        x1:=x2;
                               end;   // i1111
    for I := 1 to Mx_prich do if Sum_PrichCol[i]>0 then  // 18
    Chart1.series[7].Title:='Накопление отказов, % от машин';
    tprev:=0;  t50:=0; tz50:=0;
       for i:=0 to High(MasProbl) do begin
       sumI:=SumI+1/(1-CDF_Gauss(SRED,SKO,MasProbl[i].time));
      if (t50=0) and ((I+1)/Izd_Prived>=0.5) then
        t50:=MasProbl[i].time-(MasProbl[i].time-tprev)*(Frac((I+1)-0.5*Izd_Prived));
      if (tz50=0) and ((SumI)/Izd_Prived>=0.5) then
       tz50:=MasProbl[i].time-(MasProbl[i].time-tprev)*Frac(SumI-0.5*Izd_Prived);
               tprev:=MasProbl[i].time;
             end;  // расчет t50 по фактическим временам отказов
        if t50=0 then Label2.Caption:='- данных недостаточно для оценки средней наработки на отказ'
        else begin
        Label2.Caption:='Накопление числа отказов, равного 0,5 численности парка- без учета цензурирования: '+Format('%7.1f',[t50])+' мч  ';
        Label3.Caption:='что эквивалентно средней наработке между отказами MTBF - с учетом цензурирования: '+Format('%7.1f',[tz50])+' мч  ';
        Label4.Caption:='Черная штрих-пунктирная линия - накопление числа отказов, % численности парка';
        Label5.Caption:='Интенсивность отказов от 200 часов до среднего окончания гарантии '+Format('%6.4f',[Pot08])+'/издел. на 1000 ч.';
                   end;
   Label1.Caption:=Comment+' ('+FloatToStr(Kol_Izd_All)+' шт.,'+IntToStr(Kolotk) +' отказов)';
    Visible:=True;
      Screen.Cursor:=crDefault;
  end;         *)
end;

procedure TExpForm.Button2Click(Sender: TObject);
begin
  Printer.PrinterIndex:=0;
 Printer.Orientation:=poLandscape;//poPortrait
 PrintScale:=poPrintToFit;//poProportional;//
 PrinterSetupDialog1.Execute;
 Print;
end;

end.
