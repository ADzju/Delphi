unit Out_Graph2015;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls, Grids,obrotk2022,
  Vcl.Buttons,Printers,System.Math, VclTee.TeeGDIPlus,ExpNew, Exp1, Expand_Dia1;

Const  ColorArray:array [0..22] of TColor = (clBlack,clRed,clYellow,clOlive,clWebCornFlowerBlue,clWebLightGoldenrodYellow,clWebLightSeaGreen,clWebHotPink,
clWebPaleTurquoise,clWebMistyRose,clLime,clBlue,clFuchsia,clAqua,clMoneyGreen,clWebOrange,clWebMagenta,clPurple,clGreen,clMaroon,clGray,clNone,clBlack);
//8

var T_prirab,tfin: double;

type
  TForm2 = class(TForm)
    Prodolgenie: TButton;
    Label10: TLabel;
    Result_Grid: TStringGrid;
    Button1: TButton;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Chart1: TChart;         // левый нижний
    Series1: TLineSeries;   //% выбывших из наблюдения ниж лев
    Series2: TLineSeries;   // нецензурированный модельный массив по Пирсону}
    Series3: TLineSeries;   // итоговый модельный массив по Пирсону}
    Series4: TLineSeries;   // итоговый модельный массив по Смирнову}
    Series5: TLineSeries;   // генетическая модель без учета цензурирования
    Series6: TLineSeries;   // итоговый генетич. модельный массив}

    Chart2: TChart;          // левый верх
    Series7: TLineSeries;    //% выбывших из наблюдения рис 2
    Series8: TLineSeries;    // накопл. модельный массив по Пирсону без цензурирования}
    Series9: TLineSeries;    // накопленные отказы по Пирсону
    Series10: TLineSeries;   //  {Ch2 накопленные отказы по Смирнову}
    Series11: TLineSeries;   // {Ch2 накопленные генетич. отказы без цензурирования}
    Series12: TLineSeries;   // {Ch2 накопленные генетические отказы}
    Chart3: TChart;          // левый нижний
    Series13: TLineSeries;
    Series15: TAreaSeries;
    Series14: TBarSeries;
    Series16: TBarSeries;
    Series17: TLineSeries;    // сумма отказов приведеннных рис 2
    Button2: TButton;
    Series18: TLineSeries;    // LN
    Series19: TLineSeries;    // LN

    procedure ProdolgenieClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private

  public


  end;

//procedure Diagrams;
procedure Diagrams(HistD:Hist40);

var
  Form2: TForm2;

implementation
//uses Stat2018;//,obrotk2022;

{$R *.dfm}
var Num_Col,N_ser:integer;
   // T_prirab: double;

Procedure CntrText(i:integer; Text: String);
 var WCells: Integer;
 Stroka:string;
     begin
 WCells:=Form2.Result_Grid.ColWidths[Num_Col]-7; //7 - корректировка
 Stroka:=Text;
 with Form2.Result_Grid, Form2.Result_Grid.Canvas do begin
 Stroka:=' '+Stroka;
     while TextWidth(Stroka)<WCells do Stroka:=Stroka+' ';
            // Stroka:=' '+Stroka;
  //  Form2.Result_Grid.Cells[N_Row,i]:=Stroka;
    Form2.Result_Grid.Cells[Num_Col,i]:=Stroka;
 end;
       end;

Procedure Potok08;// поток отказов после T_prirab до среднего времени гарантии
var i :integer;
    x2:double;
begin
  x2:=0;
  //T_prirab:=200;
 // T_prirab:=StrToFloat(Form1.LabeledEdit3.Text);
  for i:=0 to high(MasProbl) do
     if (MasProbl[i].time>T_prirab) and (MasProbl[i].time<=1000) then
if (MasProbl[i].time>T_prirab) and (MasProbl[i].time<=1000) then
     x2:=x2+1/(1-CDF_Gauss(Sred,SKO,MasProbl[i].time));
    Pot08:=1000*x2/(1000-T_prirab)/Izd_Prived;//(Kol_Izd_All)*KolOtk/Kol_izw;
end;

procedure Diagrams(HistD:array [0..40] of Hist_Rec);

var i,i2,j,t1,t2,Ns1,Ns2,Ns3,Nnew:integer;
    Tst: integer;
    Nakopl,K_Interval,Expl_sum,SumNundCol: double;
    MPir: Mod_Weib;
    f: TextFile;
    Text_Name,x2str: AnsiString;
    KolmStr: string;

Procedure BlockOut(Model:Mod_Weib;st:string;Wi:integer);
var tt:real;
begin
     if Model.Executed=false then exit;
     with Form2.Result_Grid do
     with Model do begin
     ColWidths[Num_Col]:=wi;
     Cells[Num_Col,0]:=st;
     tt:=Kolmogor(K_Powtor,A,B,Sred,SKO,KolmCrt,KolmStr);
     CntrText(1,Format('%6.3f / %7.2f',[A,B]));
     CntrText(2,Format('%6.4f',[K_powtor]));
     tt:=weibinv(A,B,0.5/K_powtor);
     CntrText(3,FloatToStr(Round(weibinv(A,B,0.5/K_powtor)))+' ч.');
  //   tt:=weibinv(0.15,0.24,0.9);
     CntrText(4,FloatToStr(Round(weibinv(A,B,0.2/K_powtor)))+' ч., '+FloatToStr(Round(weibinv(A,B,0.1/K_powtor)))+' ч.');
     CntrText(5,FloatToStr(Round(Kol_Nakopl))+' /'+FloatToStr(Round(Kol_Nakopl/Popravka_Unknow)));
     CntrText(6,Format('%5.2f / %5.2f',[1.96*SKO_out,SKO_Out]));
     CntrText(7,Format('%4.1f',[Sred])+' ч');
     CntrText(8,Format('%4.1f',[SKO]) +' ч');
     CntrText(9,Format('%6.3f',[KolmCrt]) + KolmStr);
     CntrText(10,Format('%6.4f/ %6.4f',[LamStart,Lam1000]));
     CntrText(11,Format('%6.2f',[Model.K_powtor*weibCDF2(A,B,0,2000{tGar})]));
      inc(Num_Col);// смещение столбца для вывода
         end;
end;

Procedure DiaBarCol(ChartOne: TChart; i,Transpar:integer; St: string ); // в пределах набора отказов
  begin
    with ChartOne do begin
     AddSeries(TBarSeries.Create(ChartOne));  // !!!!!!!!!
     Series[SeriesCount - 1].Clear;
     Series[SeriesCount - 1].Marks.Visible := false;
     Series[SeriesCount - 1].Transparency := Transpar; //20;
     Series[SeriesCount - 1].Title:=St;
     Series[SeriesCount - 1].Color:=ColorArray[i];  // важно!
      end;
    end;

Procedure DiaBarNo(ChartBar: TChart; Transpar:integer; St: string );  // в пределах набора отказов
  begin
   with ChartBar do begin
     AddSeries(TBarSeries.Create(ChartBar)); // !!!!!!!!!
     Series[SeriesCount - 1].Clear;
     Series[SeriesCount - 1].Marks.Visible := false;
     Series[SeriesCount - 1].Transparency := Transpar;
     series[SeriesCount - 1].Title:=St;
     Series[SeriesCount - 1].Color:=ColorArray[i];  // важно!
   end;
  end;

          Begin
       Potok08;
       with Form2 do begin
   //  form2.Enabled;  // !!!
   Visible:=true;
       t1:=0;  t2:=0; SumNund:=0; SumNundCol:=0;
       Setlength(F_OutGar, 1+high(Hist_Stol));
               for i:=0  to high(Hist_Stol) do begin
               Sum_PrichRow[i]:=false; Sum_PrichCol[i]:=0;
                               end; // для каждого

       for j:=0  to high(Hist_Arr) do
       for i:=0  to NPrich+1 do
       if (Hist_Arr[j].Npr[i]>0) then Sum_PrichRow[j]:= true; // есть ли отказы по столбцам

     // for i:=0  to NPrich+1 do Sum_PrichRow[i]:=Sum_PrichRow[i]+Hist_Arr[j].Npr[i]; // отказы по столбцам
      //    if MpirsS.Executed then Mpir:=MpirsS else Mpir:=MpirsN;  //?????
       for i:=Chart1.SeriesCount-1 downto 8{Ns1} do Chart1.Series[i].Free;//очистить столбцы нижней левой диагр
       for i:=Chart2.SeriesCount-1 downto 8{Ns2} do Chart2.Series[i].Free;//очистить столбцы верхней левой диагр
       for i:=Chart3.SeriesCount-1 downto 3{Ns3} do Chart3.Series[i].Free;//очистить нижнюю правую диаграмму} *)

    Expl_sum:=0;
    if MPirsN.Executed then begin
        MPirsN.Unsens:=0;       MPirsN.Kol_Nakopl:=0; end;
    if MPirsS.Executed then begin
        MPirsS.Unsens:=0;       MPirsS.Kol_Nakopl:=0;
            end;
        MGenet.Unsens:=0;       MGenet.Kol_Nakopl:=0;
        MPir.Unsens:=0;         MPir.Kol_Nakopl:=0;
        MSmirn.Unsens:=0;       MSmirn.Kol_Nakopl:=0;
      Screen.Cursor:=crHourGlass;
    Series1.Clear;  Series2.Clear;  Series3.Clear; Series4.Clear; Series5.Clear;
    Series6.Clear;  Series7.Clear;  Series8.Clear; Series9.Clear; Series10.Clear;
    Series11.Clear; Series12.Clear; Series13.Clear; Series15.Clear;  Series14.Clear;
    Series15.Clear; Series16.Clear; Series17.Clear; Series18.Clear; Series19.Clear;

     Ns1:=Chart1.SeriesCount;  // =7 (А2661 2661_01 2013)
     Ns2:=Chart2.SeriesCount;  // =7 (А2661 2661_01 2013)
     Ns3:=Chart3.SeriesCount;  // =1 (А2661 2661_01 2013)
        Nnew:=0;
       ColorPalettes.ApplyPalette( Chart1, 5{ 5 4}{7} );
       ColorPalettes.ApplyPalette( Chart2, 5 );
       ColorPalettes.ApplyPalette( Chart3, 5 );
       Chart1.Legend.Symbol.Continuous:=True;
       Chart3.legend.Symbol.Continuous:=True;

     for j := 1 to Nprich+1 do                              // названия отказов в легенде
        if Vidy_Otkazov[j].Dolya>0 then begin
     DiaBarCol(Chart1, j, 0,  Vidy_Otkazov[j].Nazv_Prich + ' '+intToStr(Round(Vidy_Otkazov[j].Dolya))
          +' раз ('+ Format('%3.1f', [100*Vidy_Otkazov[j].Dolya/Izd_Prived])+'%'+' на 1 машину)');
     DiaBarNo(Chart2,30,  Vidy_Otkazov[j].Nazv_Prich);  //нижняя левая диагр с ценз
              end;

      for I := 0 to 30 do //High(Hist_Arr) do  // 123
     //   if Sum_PrichRow[i] then        //+Hist_Arr[i].Nund
          begin
       //   Chart2.Series[Chart2.SeriesCount - 1].Color:=ColorArray[i];
       //   Chart3.Series[Chart3.SeriesCount - 1].Color:=ColorArray[i];
       //   if Vidy_Otkazov[i].Dolya>0 then // т.е. события-причины в столбце есть

      for j := 1 to Nprich+1 do begin
                          (*
     DiaBarCol(Chart1, j, 0,  Vidy_Otkazov[j].Nazv_Prich + ' '+intToStr(Round(Vidy_Otkazov[j].Dolya))
          +' раз ('+ Format('%3.1f', [100*Vidy_Otkazov[j].Dolya/Izd_Prived])+'%'+' на 1 машину)');
     DiaBarNo(Chart2,30,  Vidy_Otkazov[j].Nazv_Prich);  //нижняя левая диагр с ценз       *)
                        // end;
          if Vidy_Otkazov[j].Dolya>0 then
                begin
          DiaBarNo(Chart3, 0,  Vidy_Otkazov[j].Nazv_Prich);
          DiaBarNo(Chart3, 60, Vidy_Otkazov[j].Nazv_Prich+' с учетом цензурирования');
                end;
            //  end;
      Chart3.Series[Chart3.SeriesCount -1].Color:=ColorArray[j{i}]; // важно ******************!
             inc(Nnew);  // =5 (А2661 2661_01 2013)
                  // end;/// 123
         Chart3.Series[Chart3.SeriesCount - 1].Color:=Chart3.Series[Chart3.SeriesCount - 2].Color; // важно !
      // Chart3.Series[Chart3.SeriesCount - 1].Color:=Chart3.Series[Chart3.SeriesCount - 2].Color;
                end; //
               end;

     for i:=0 to high(Hist_Arr) do begin  //i111 цикл всей диаграммы
        t2:=round(Hist_Arr[i].time);
        K_Interval:=100/(t2-t1);           // величина, обратная весу интервала в 100 часах
    F_OutGar[i]:=CDF_Gauss(SRED,SKO,t2);   // доля выбывших из гарантии
    Expl_sum:=Expl_sum+Hist_Arr[i].Sum;    // сумма известных отказов в эксплуатации
    N_ser:=0;
        end;


        for i2 := 0 to High(Hist_Arr) do  // номера видов отказов    *****************************************
    if Sum_PrichRow[i2] and (Hist_Arr[i2].Nund>0) then
                begin
         x2Str:=FloatToStr(t2);
         Sum_PrichCol[i2]:=Sum_PrichCol[i2]+Hist_Arr[i].Npr[i2];
    // Chart1.Series[0].Color := clBlue;
 Chart1.series[Ns1+N_ser].Add(Hist_Arr[i].Npr[i2]*K_Interval/Izd_Prived,x2str,ColorArray[i2]);  // левый низ
 Chart2.series[Ns2+N_ser].Add(Sum_PrichCol[i2]/Izd_Prived{*KolOtk/Kol_izw},x2str,ColorArray[i2]); //левый верх
// Chart2.series[Ns2+N_ser].Add(Hist_Arr[i].Nund/Izd_Prived*KolOtk/Kol_izw,x2str,ColorArray[i2]); //левый верх


        if (F_OutGar[i]<0.9) // and ((MReal_Hist[1,i]/(1-F_OutGar[i])<1.25*MaxValue(MReal_Hist[1])))
     then begin
  Chart3.series[Ns3+2*N_ser].Color:=ColorArray[i2];
  Chart3.series[Ns3+2*N_ser+1].Color:=ColorArray[i2];
  Chart3.series[Ns3+2*N_ser].Add(  Hist_Arr[i].Npr[i2]*K_Interval/Izd_Prived,x2str);  //правая нижняя диаграмма
  Chart3.series[Ns3+2*N_ser+1].Add(Hist_Arr[i].Npr[i2]*K_Interval/Izd_Prived/(1-F_OutGar[i]),x2str);

       end;
             inc(N_ser);
                end;
    Series17.Add(100*Expl_sum/Izd_Prived,x2str);        // сумма отказов приведеннных рис 2
      if MPirsN.Executed then begin
    MPirsN.Unsens:=MPirsN.Unsens+MPirsN.F_Weib[i];                    // накопленные без учета цензурирования
    MPirsN.Kol_Nakopl:=MPirsN.Kol_Nakopl+MPirsN.Kol_F_Priv[i];        // накопленные известные отказы
      end;
      if MPirsS.Executed then begin
    MPirsS.Unsens:=MPirsS.Unsens+MPirsS.F_Weib[i];                    // накопленные без учета цензурирования
    MPirsS.Kol_Nakopl:=MPirsS.Kol_Nakopl+MPirsS.Kol_F_Priv[i];        // накопленные
            end;
      if MPirsN.Executed then Mpir:=MPirsN else if MPirsS.Executed then Mpir:=MPirsS; //
      if MPir.Executed then begin
    Chart1.series[1].Title:='Модель по Пирсону с учетом цензурирования';
    Chart1.series[2].Title:='Модель по Пирсону';
    Series2.Add(MPir.F_Weib[i]     *K_Interval*MPir.K_powtor,x2str);{Ch1 Line нецензурированный модельный массив по Пирсону}
    Series3.Add(MPir.Kol_F_priv[i] *K_Interval/Izd_Prived,x2str); {Ch1 Line итоговый модельный массив по Пирсону}
    Series8.Add(MPir.Unsens        * MPir.K_powtor, x2str);       {Ch2 накопл. модельный массив по Пирсону без цензурирования}
    Series9.Add(MPir.Kol_Nakopl/Izd_Prived, x2str);               {Ch2 накопленные отказы по Пирсону}
             end;
      if MGenet.Executed then begin
    MGenet.Unsens:=MGenet.Unsens+MGenet.F_Weib[i];
    MGenet.Kol_Nakopl:=MGenet.Kol_Nakopl+MGenet.Kol_F_Priv[i];
    Series5.Add(MGenet.F_Weib[i]    *MGenet.K_powtor*K_Interval,x2str); {Ch1 генетическая модель без учета цензурирования}
    Series6.Add(MGenet.Kol_F_priv[i]/Izd_Prived     *K_Interval,x2str); {Ch1 итоговый генетич. модельный массив}
    Series11.Add(MGenet.Unsens      *MGenet.K_powtor,           x2str); {Ch2 накопленные генетич. отказы без цензурирования}
    Series12.Add(MGenet.Kol_Nakopl  /Izd_Prived,x2str);                 {Ch2 накопленные генетические отказы}
          end;
      if MSmirn.Executed then begin
    MSmirn.Kol_Nakopl:=MSmirn.Kol_Nakopl+MSmirn.Kol_F_Priv[i];
    Series4.Add(MSmirn.Kol_F_Priv[i]*K_Interval/Izd_Prived,x2str); {Ch1 итоговый модельный массив по Смирнову}
    Series10.Add(MSmirn.Kol_Nakopl/Izd_Prived,x2str);              {Ch2 накопленные отказы по Смирнову}
            end;
    Series1.Add(F_OutGar[i]*100,x2str);                             //% выбывших из наблюдения ниж лев
    Series7.Add(F_OutGar[i]*100,x2str);                             //% выбывших из наблюдения рис 2
    Series15.Add(Expl_sum/Izd_Prived,x2str);                        //% накопленных факт. от приведенного к-ва
                        t1:=t2;
          // end;

 Form2.Label10.Caption:=Comment+' ('+FloatToStr(Kol_Izd_All)+' шт.)';  Perv:=false;
     Num_Col:=1;
        with Form2.Result_Grid do begin //заполнение таблицы результатов
    for i:=1 to 4 do for j:=0 to 13 do Cells[i,j]:='';
     ColWidths[0]:=200;
     BlockOut(MPirsN,'Пирсона/Ньютона'   ,128);
     BlockOut(MPirsS,'Пирсона/спир.спуск',128);
     BlockOut(MSmirn,'Смирнова '         ,128);
     BlockOut(MGenet,'Генетическая'      ,128);
     ColWidths[1]:=145;
     ColWidths[Num_Col]:=142;
 Cells[0,0] :='Результаты для методов:'; Cells[Num_Col,0]:='Данные эксплуатации';
 Cells[0,1] :='Распр. Вейбулла(A,B как в Excel)';      //
 Cells[0,2] :='Масштабный коэффициент';
 Cells[0,3] :='MTBF(ср.наработка между отк.)';   CntrText(3,floattostr(Round(T50Expl))+' (набл.)/'+FloatToStr(Round(T50zen))+' (ценз.)');
 Cells[0,4] :='80%,90% наработка между отк.';   CntrText(4,FloatToStr(Round(T80Expl))+' ч., '+FloatToStr(Round(T90Expl))+' ч.(ценз.)');
 Cells[0,5] :='Число известных/всех отказов'; CntrText(5,FloatToStr(Round(Kol_Izw))+' /'+FloatToStr(Round(Kol_Izw/Popravka_Unknow)));
 Cells[0,6] :='Доверит.95% инт-л/СКО модели';
 Cells[0,7] :='Средний фактич. срок гарантии';
 Cells[0,8] :='СКО фактич-го срока гарантии';
 Cells[0,9] :='Критерий Колмогорова для t>0';
 if MasProbl[High(MasProbl)].time<1000 then tfin:=MasProbl[High(MasProbl)].time else tfin:=1000;
 Cells[0,10]:='Интенс-ть отк./1000 ч ('+FloatToStr(T_prirab)+','+FloatToStr(Tfin)+' ч)'; //
 CntrText(10,Format('%5.3f',[Pot08])+' (до 1000 ч.)');
 Cells[0,11]:='Отказов/изд. за 2000 ч';  CntrText(11,Format('%4.2f',[Otk_Izd]));
        end;
       Tst:=-1;
   With Form2 do begin
    for j:=0 to high(MasProbl) do
            if (masProbl[j].time>0) then begin
  Series18.AddXY(ln(1e-5+MasProbl[j].time),ln(j+1),'',clGreen);
            if (Tst=-1) then Tst:=j;
        end;
           end;
           j:=High(MasProbl);
// Label1.Caption:='A= '+ Format('%6.4f',[A_Ln]);
// Label2.Caption:='B= ' + Format('%6.4f',[B_Ln]);
 Series19.AddXY(ln(1e-5+MasProbl[Tst].time),A_ln*ln(1e-5+MasProbl[Tst].time)  + B_ln,'',clRed);
 Series19.AddXY(ln(1e-5+MasProbl[j].time),A_ln*ln(1e-5+MasProbl[j].time)  + B_ln,'',clRed);
   end;
    Form2.Visible:=True;
      Screen.Cursor:=crDefault;
  end;

procedure TForm2.Button1Click(Sender: TObject);
begin
    Printer.PrinterIndex:=0;
    Printer.Orientation:=poLandscape;//poPortrait
//  Form2.PrintDialog1.Execute;
//  Printdialog1.Create(Form2);
//  PrinterSetupDialog1.Execute;
//  PrintDialog1.Execute;
 Form2.PrintScale:=poPrintToFit;//poProportional;//
 PrinterSetupDialog1.Execute;
 Form2.Print;
end;

Procedure DiaBarCol(ChartOne: TChart; i,Transpar:integer; St: string );
  begin
    with ChartOne do begin
     AddSeries(TBarSeries.Create(ChartOne));
     Series[SeriesCount - 1].Clear;
     Series[SeriesCount - 1].Marks.Visible := false;
     Series[SeriesCount - 1].Transparency := Transpar; //20;
     Series[SeriesCount - 1].Title:=St;
     Series[SeriesCount - 1].Color:=ColorArray[i];

      end;
    end;


procedure TForm2.Button2Click(Sender: TObject);   //  Expand левое нижнее окно увеличенное
var i,i2,j,t1,t2,Ns1,Ns2,Ns3,Nnew,N_ser:integer;
    Nakopl,K_Interval,Expl_sum,SumNundCol,tprev,SumI,t50,tz50: double;
    MPir: Mod_Weib;
    Text_Name,x2str: AnsiString;
    KolmStr: string;
begin
   Application.CreateForm(TForm4, Form4);
   Form4.Visible:=true;
   with Form4 do begin
    for i:=Chart1.SeriesCount-1 downto 10 do Chart1.Series[i].Free;//очистить диаграмму} *)
     t1:=0;  t2:=0; //SumNund:=0; SumNundCol:=0;
     Expl_sum:=0;
     Setlength(F_OutGar, 1+high(Hist_Arr));

    if MPirsN.Executed then begin MPirsN.Unsens:=0; MPirsN.Kol_Nakopl:=0; end;
    if MPirsS.Executed then begin MPirsS.Unsens:=0; MPirsS.Kol_Nakopl:=0; end;
        MGenet.Unsens:=0; MPir.Unsens:=0;  MSmirn.Unsens:=0;
        MPir.Kol_Nakopl:=0;
        MSmirn.Kol_Nakopl:=0;
        MGenet.Kol_Nakopl:=0;
      Screen.Cursor:=crHourGlass;
    Series1.Clear;  Series2.Clear;  Series3.Clear; Series4.Clear; Series5.Clear;
    Series6.Clear; Series7.Clear; Series8.Clear; Series14.Clear;  Series17.Clear;
     Ns1:=Chart1.SeriesCount;  // =7 (А2661 2661_01 2013)
        Nnew:=0;  Nakopl:=0;
      ColorPalettes.ApplyPalette( Chart1, 5{ 5 4}{7} );
       Chart1.Legend.Symbol.Continuous:=True;

      for I := 0 to NPrich+1 do  //
     // for I := 0 to high(Hist_Arr) do

           if Sum_PrichRow[i] then
          begin   // т.е. события-причины в столбце есть
          if Vidy_Otkazov[i].Dolya>0 then
  //        +' ('+ Format('%3.1f', [100*Vidy_Otkazov[i].Dolya/Kol_Izw])+'%)'+' случаев'); //);  //нижняя левая диагр основная
      DiaBarCol(Chart1, i, 0,  Vidy_Otkazov[i].Nazv_Prich + ' '+intToStr(Round(Vidy_Otkazov[i].Dolya))
          +' раз ('+ Format('%3.1f', [100*Vidy_Otkazov[i].Dolya/Izd_Prived])+'%'+' на 1 машину)'); //);  //нижняя левая диагр основная
             inc(Nnew);  // =5 (А2661 2661_01 2013)
                  end;
     // if SumNund>0 then
     //             begin
     //    DiaBarCol(Chart1, i, 0, 'Не идент.');  //нижняя левая диагр
      //          end;
     for i:=0 to high(Hist_Arr) do begin  //i111 цикл всей диаграммы
        t2:=round(Hist_Arr[i].time);
        K_Interval:=100/(t2-t1);           // величина, обратная весу интервала в 100 часах
    F_OutGar[i]:=CDF_Gauss(SRED,SKO,t2);   // накопление доли выбывших из гарантии
    Expl_sum:=Expl_sum+Hist_Arr[i].Sum;    // сумма известных отказов в эксплуатации
        N_ser:=0;
        for i2 := 0 to Mx_prich do  // 18 номера видов отказов
    if Sum_PrichRow[i2] then
         begin
         x2Str:=FloatToStr(t2);
         Sum_PrichCol[i2]:=Sum_PrichCol[i2]+Hist_Arr[i].Npr[i2];
    Chart1.series[Ns1+N_ser].Add(Hist_Arr[i].Npr[i2]*K_Interval/Izd_Prived,x2str,ColorArray[i2]);  // ++++++
//  Chart2.series[Ns2+N_ser].Add(Sum_PrichCol[i2]/Izd_Prived*KolOtk/Kol_izw,x2str,Chart1.ColorPalette[i2]);
  if SumNund>0 then                              // отказы без названия
           SumNundCol:=SumNundCol+Hist_Arr[i].Nund;
      //   series14.Add(Hist_Arr[i].Nund*K_Interval/Izd_Prived,x2str);
        inc(N_ser);
        end;
  (*
    if MPirsN.Executed then Mpir:=MPirsN else if MPirsS.Executed then Mpir:=MPirsS; //
      if MPir.Executed then begin
    Chart1.series[1].Title:='Модель по Пирсону с учетом цензурирования';
    Chart1.series[2].Title:='Модель по Пирсону';
    Series2.Add(MPir.F_Weib[i]     *K_Interval*MPir.K_powtor,x2str);{Ch1 Line нецензурированный модельный массив по Пирсону}
    Series3.Add(MPir.Kol_F_priv[i] *K_Interval/Izd_Prived,x2str); {Ch1 Line итоговый модельный массив по Пирсону}
    Series8.Add(MPir.Unsens        * MPir.K_powtor, x2str);       {Ch2 накопл. модельный массив по Пирсону без цензурирования}
    Series9.Add(MPir.Kol_Nakopl/Izd_Prived, x2str);               {Ch2 накопленные отказы по Пирсону}

   *)
      if MPirsN.Executed then begin                           // 1
    MPirsN.Unsens:=MPirsN.Unsens+MPirsN.F_Weib[i];                    // накопленные без учета цензурирования
    MPirsN.Kol_Nakopl:=MPirsN.Kol_Nakopl+MPirsN.Kol_F_Priv[i];        // накопленные известные отказы
      end;
      if MPirsS.Executed then begin                           // 2
    MPirsS.Unsens:=MPirsS.Unsens+MPirsS.F_Weib[i];                    // накопленные без учета цензурирования
    MPirsS.Kol_Nakopl:=MPirsS.Kol_Nakopl+MPirsS.Kol_F_Priv[i];        // накопленные
            end;
      if MPirsN.Executed then Mpir:=MPirsN else if MPirsS.Executed then Mpir:=MPirsS; // 3
      if MPir.Executed then begin                             //
    Chart1.series[1].Title:='Модель по Пирсону с учетом цензурирования';
    Chart1.series[2].Title:='Модель по Пирсону';
    Series8.Add(100*MPir.Unsens* MPir.K_powtor, x2str);      {Ch2 накопл. модельный массив по Пирсону без цензурирования}
    Series7.Add(100*MPir.Kol_Nakopl/Izd_Prived, x2str);
    Series2.Add(MPir.F_Weib[i]     *K_Interval*MPir.K_powtor,x2str);{Ch1 Line нецензурированный модельный массив по Пирсону}
    Series3.Add(MPir.Kol_F_priv[i] *K_Interval/Izd_Prived,x2str); {Ch1 Line итоговый модельный массив по Пирсону}
             end;
      if MGenet.Executed then begin                           // 4
    Chart1.series[4].Title:='Модель генетическая с учетом цензурирования';
    Chart1.series[6].Title:='Модель "генетическая"';
    MGenet.Unsens:=MGenet.Unsens+MGenet.F_Weib[i];
    MGenet.Kol_Nakopl:=MGenet.Kol_Nakopl+MGenet.Kol_F_Priv[i];
    Series5.Add(MGenet.F_Weib[i] *MGenet.K_powtor*K_Interval,x2str); {Ch1 генетическая модель без учета цензурирования}
    Series6.Add(MGenet.Kol_F_priv[i]/Izd_Prived  *K_Interval,x2str); {Ch1 итоговый генетич. модельный массив}

      end;                      //333
      if MSmirn.Executed then begin  //444                    // 5
    MSmirn.Kol_Nakopl:=MSmirn.Kol_Nakopl+MSmirn.Kol_F_Priv[i];
    Series4.Add(MSmirn.Kol_F_Priv[i]{*100}*K_Interval/Izd_Prived,x2str); {Ch1 итоговый модельный массив по Смирнову}
            end;                      //444
    Series1.Add (F_OutGar[i]*100,x2str);                                 //% выбывших из наблюдения рис 1
    Nakopl:=Nakopl+Hist_Arr[i].Sum;
  //  if Nakopl/Izd_Prived<=1 then
    Series17.Add(100*Nakopl/Izd_Prived,x2str);                            //% выбывших из наблюдения рис 2
                        t1:=t2;
                               end;   // i1111
    for I := 0 to Mx_prich do if Sum_PrichCol[i]>0 then  // 18
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
   //     if t50=0 then Label2.Caption:='- данных недостаточно для оценки средней наработки на отказ'
   //     else begin
    //    Label2.Caption:='Накопление числа отказов, равного 0,5 численности парка- без учета цензурирования: '+Format('%7.1f',[t50])+' мч  ';
    //    Label3.Caption:='что эквивалентно средней наработке между отказами MTBF - с учетом цензурирования: '+Format('%7.1f',[tz50])+' мч  ';
    //    Label4.Caption:='Черная штрих-пунктирная линия - накопление числа отказов, % численности парка';
    //    Label5.Caption:='Интенсивность отказов от 200 часов до среднего окончания гарантии '+Format('%6.4f',[Pot08])+'/издел. на 1000 ч.';
     //              end;
   Label1.Caption:=Comment+' ('+FloatToStr(Kol_Izd_All)+' шт.,'+IntToStr(Kolotk) +' отказов)';
    Visible:=True;
      Screen.Cursor:=crDefault;
  end;
      //  end;
end;
procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   //  Form2.Destroy;
end;


procedure TForm2.ProdolgenieClick(Sender: TObject);
begin
Form2.Close;
//Form1.Update;
//Form1.Visible:=True;
end;
         end.
