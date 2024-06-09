unit GST_dinam;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,System.Math;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

type
  Gmotors=record
  q,w_max,wrads,Dmot,Vmot,KPDo,KPDm,M:real;
     end;
  Nasoses=record
  q,w_max,wrads,Dnas,Vnas,KPDo,KPDm,M:real;
     end;
  Dizel=record
  Comm        : ansistring;
  n,M        : array[0..14]of double;
     end;
  Dinam=record
    t,S,a,V,N,Epolez,Esumm: double;
  end;

const
MMZ245c2c: Dizel=(Comm:'ММЗ 245.2S2 90кВт 2200мин-1';
  n:(1200,	1300,	1400,	1500,	1600,	1700,	1800, 1900,	2000,	2100,	2200, 2250,0,0,0);
  M:(  445,	475,	490,	502,	502,	495,	485,	470,	450,	420,	395,	  0, 0,0,0));
MMZ245_16c: Dizel=(Comm:'ММЗ245.16с 90кВт 1800мин-1';
  n:(1000,	1100, 1200,	1300,	1400,	1500,	1600,	1700,	1800, 1850,	0,0,0,0,0);    // 1800 мин-1
  M:( 400,	480,	560,	615,	630,	600,	570,	532,	505,	   0,	0,0,0,0,0));   // 90 кВт

Deutz4ZF: Dizel=(Comm:'Deutz BF 4M1013EC 103,9kw 2200мин-1'; //++++
  n:(1000,1200,1400,1600,1800,1900,2000,2100,2200,2332,0,0,0,0,0);
  M:( 467, 548, 577, 556, 524, 505, 488, 467, 451, 0,  0,  0,0,0,0));
Deutz6: Dizel=(Comm:'Deutz BF6M2012C Tier 2 158 л.с. 2200мин-1';
  n:(1000,	1200,	1300,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2100,	2300,0,0,0);
  M:( 550,	590,	610,	625,	630,	625,	610,	590,	570,	545,	535,	0,   0,0,0));
Cummins6B59: Dizel=(Comm:'Cummins 6B5.9 FR90870 Tier 2 173 л.с. 2200 мин-1';
  n:(800,	1000,	1300,	1500,	1600,	1800,	2000,	2200,	2400,0,0,0,0,0,0);//
  M:(514,	542,	786,	740,	721,	668,	629,	560,	0,0,0,0,0,0,0));  //
Perkins1106D: Dizel=(Comm:'Perkins 1106D-E66TA Tier 2 185 л.с. 2200 мин-1';
  n:(800,	1000,	1200,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2200,	2400,0,0,0);
  M:(500,	740,	800,	802,	800,	788,	767,	740,	707,	670,	591,	0,   0,0,0));   // 185 л.с./2200
Yamz236M2: Dizel=(Comm:'ЯМЗ 236М2 180 л.с. 2100 мин-1';
  n:(1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2150,2200,2340);
  M:(610, 630, 645, 660, 667, 659, 651, 642, 632, 622, 612, 602, 550, 300,  10));
Mmz260_2: Dizel=(Comm:'ММЗ 260.2 95,6 kWt 2100 мин-1';
  n:(1100,1200, 1400, 1500, 1600, 1800, 1900, 2000, 2100,2275,0,0,0,0,0);
  M:(445,  465,	 500,	 498,  495,  488,	 475,	 455,	 435,	0, 0,0,0,0,0));
Mmz260_1s2: Dizel=(Comm:'ММЗ 260.1s2 158 л.с. 2100 мин-1';
  n:(1000,1100,1200, 1400,1500,1600,1700,1800,1900,2000,2100,2275,0,0,0);
  M:(590, 605,	615,	622, 618, 610, 600,	586,	570,	550,	518, 0,0,0,0));
Mmz260_9: Dizel=(Comm:'ММЗ 260.9 180 л.с. 2100 мин-1';
  n:(1000,1100,1200,1400,1500,1600,1700,1800,1900,2000,2100,2250,0,0,0);
  M:(650, 660,	670,	685,	690,	685,	670,	652,	634,	618,	600,	0,0,0,0));
Mmz260_7: Dizel=(Comm:'ММЗ 260.7 180 кВт 2100 мин-1';
  n:(1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2150,0,0);
  M:(700,  775,	835, 880,	925, 960,	960, 945,	915, 890,	862, 835,0,0,0));
Mmz2621s2: Dizel=(Comm:'ММЗ 262.1S2 280 л.с. 2100 мин-1';
  n:(1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2150,0,0);
  M:(910,  960,1010,1060,1120,1170,1160,1135,1080,1035, 985, 937, 0,0,0));
Iveco182: Dizel=(Comm:'F4HE0684E*D1 Tier 2 182 л.с. 2200 мин-1';
  n:(800,	1000,	1200,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2200,	2400,0,0,0);
  M:(550,	650,	750,	800,	790,	780,	770,	750,	730,	680,	580,	0,   0,0,0));
Iveco152: Dizel=(Comm:'F4GE0684Q*D6 152 HP 2200 мин-1';
  n:(1000,	1200,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2100,	2200,	2400,0,0,0);
  M:(590,	  585,	582,	578,	575,	572,	570,	550,	535,	508,	485,	0,   0,0,0));
YAMZ5344: Dizel=(Comm:'ЯМЗ 5344 100 kWt 2300 мин-1';
  n:(900, 1000,	1100,	1200,	1300,	1400,	1500,	1600,	1700,	1800,	2000,2100,2200,2300,2310); //
  M:(375,	390,	410,	420,	420,	420,	420,	420,	420,	420, 	420, 415, 410, 405,0));
YAMZ65652: Dizel=(Comm:'ЯМЗ 65652 270 л.с. 2100 мин-1';
  n:(900, 1000,	1100,	1200,	1300,	1400,	1500,	1600,	1700,	1800,	1900,	2000,2100,2200,0); //
  M:(1050,	1100,	1130,	1130,	1130,	1130,	1130,	1115,	1070,	1025,	980,	940, 910, 0, 0));
YAMZ6566: Dizel=(Comm:'ЯМЗ 6566 270 л.с. 1900 мин-1';
  n:(900, 1000,	1100,	1200,	1300,	1400,	1500,	1600,	1700,	1800,	1900,	2000,0,0,0);
  M:(1050,	1100,	1150,	1150,	1150,	1150,	1150,	1120,	1070,	1035,	1010,	0, 0,0,0));
YAMZ760110: Dizel=(Comm:'ЯМЗ 7601 300 л.с. 1900 мин-1';
  n:(1000, 1100,1200,1400, 1500,	1600, 1700,	1800,	1900,	2135,	0,	0,	0,0,0);
  M:(1130, 1250,1280,1250,	1220,	1200,	1180, 1140,	1110,	  0,	0, 0,   0,0,0));
CummC260: Dizel=(Comm:'Cummins 6CTAА8.3-C260 265 л.с. 2200 мин-1';
  n:(1000, 1200, 1400,	1500,	1900,	2100,	2200,	2380,	0, 0,	0, 0,0,0,0);
  M:(  971, 1077, 1100,	1076,	 937,	 887,	 843,    0,	0, 0,	0, 0,0,0,0));

var
  GMotor :  Gmotors;
  Nasos  :  Nasoses;
  Diz    :  Dizel;
  Din    :  Dinam;
  i,k: integer;
  Ky1,Ky2,Cy1,Cy2,Tem,KPDm,W_max,M1,KPDgm,dP,e,Pk,t,s,Md_net,Md_brt,n_d,Mdr,Mlost: double;
  Itr,KPDtr: array[1..10] of double;
  Rk,V: array[1..2] of double;

Function Interpol1(x:double;XMas,YMas:array of double):double;
var i,j: byte;
    k,b : double;
begin
 if x<=XMas[0] then begin Result:=YMas[0]; exit; end;

 begin
 i:=0;
 while XMas[i]<x do inc(i);
 if x>=MaxValue(XMas) then begin Result:=YMas[i]; exit; end;
   k:=(Ymas[i]-Ymas[i-1])/(Xmas[i]-Xmas[i-1]);
  Result:=Ymas[i-1]+k*(x-Xmas[i-1]);
     end;
       end;

Procedure Sil_Block_Din(Pk:double);
var hs,YL:double; Md_v:boolean; k:integer;
label m;
begin
  Mdr:=90; Mlost:=0;
  hs:=5; Md_v:=true; k:=0;    //  n_d:=0.99*MaxValue(Diz.n);
//  Mnasos:=9.807e-5*Ro*YL*Sqr(n_d/Irom/30*Pi)*Power(GT.Dr,5);
//       if (Pk<Mtur*Imost*Ikp[Nper]/Rk*nu[Nper]*NuMost) and (n_d<MaxValue(Diz.n)) then begin
  repeat
 // if (Pk>Mtur*Imost*Ikp[Nper]/Rk*nu[Nper]*NuMost) and Md_v
//  then begin hs:=-hs/2.5; Md_v:=false; end;
//  if (Pk<Mtur*Imost*Ikp[Nper]/Rk*nu[Nper]*NuMost) and not Md_v
//     then begin hs:=-hs/2.5; Md_v:=true; end;
        n_d:=n_d-hs;
//   Mnasos:=9.807e-5*Ro*YL*Sqr(n_d/Irom/30*Pi)*Power(GT.Dr,5);
     until abs(hs)<1e-5;  // подобран режим для заданного Pk
  Md_brt:=Interpol1(n_d,Diz.n,Diz.M);
  Md_net:=Md_brt*MdR/100-Mlost;
//  if Md_net>Mnasos/Irom/NuRom then Md_net:=Mnasos/Irom/NuRom;
   // Dinam=Record  V,S,t,N,A: double;
     Din.N:=(Md_net*100/MdR+Mlost)*n_d*Pi/30*1e-3;
  begin
//    Md_brt:=Mnasos/Irom/NuRom/Mdr*100+Mlost;
  end;
//    Ndv_net:=Md_net/9.807*n_d/716.2;
         end;


procedure TForm2.FormCreate(Sender: TObject);
begin
//**************** Исходные данные по машине *****************
M1:=15000;//+4700*9.81;
itr[1]:=1;
KPDgm:=0.93;
    KPDtr[1]:=0.98;
   dP:=20;  e:=1;  Nasos.Wrads:=1800*1.75*Pi/30;

Rk[1]:=0.67;          // м статический радиус по ГОСТ 7463-80

(*
 with Nasos[1] do begin  // Linde HPV-135
  q:=70e-6;             // производительность м3/оборот
  w_max:=2700*Pi/30;     //
  Dnas:=Power(q,1/3);    // м "характерный размер гидромашины"
  Vnas:=W_max*Dnas;      // м/с "характерная скорость гидромашины"
 end; *)

 with Nasos do begin
  q:=78e-6;             // производительность м3/оборот
  w_max:=2500*Pi/30;     //
  Dnas:=Power(q,1/3);    // м "характерный размер гидромашины"
  Vnas:=W_max*Dnas;      // м/с "характерная скорость гидромашины"
 end;

 with GMotor do begin   //
  q:=160e-6;             // производительность гидромотора м3/оборот
  w_max:=2000*Pi/30;     //
  Dmot:=Power(q,1/3);    // м "характерный размер гидромашины"
  Vmot:=W_max*Dmot;      // м/с "характерная скорость гидромашины"
 end;

 Ky1:=0.156*1e-3;           // - для гидронасоса (коэффициенты модели К.И. Городецкого)
 Cy1:=3.67;                 //        -//-
 Ky2:=0.146*1e-3;           // - для гидромотора
 Cy2:=4.1;                  //        -//-
// Ky2:=0.18852*1e-3;         // - для гидромотора  ГМ-90 после оптимизации
// Cy2:=3.10225;              //        -//-
 Tem:=70;                   // оС температура рабочей жидкости


end;


Function Mexkpd1(w:real):real;
 begin
   KPDm:=1-(0.035+0.05*Abs(Abs(w/Nasos.W_max)-0.5));
   Result:=KPDm;
 end;

Function Mexkpd2(w:extended):real;
 begin
   KPDm:=1-(0.035+0.035*Abs(Abs(w/GMotor.W_max)-0.45));
   Result:=KPDm;
 end;

//procedure KPD_m(t,dP,e:extended{;var Nas:Nasoses;var Mot:GMotors});   // расчет КПД mex
//const
//kzh=
//var


procedure KPD_o(t,dP,e:extended{;var Nas:Nasoses;var Mot:GMotors});   // расчет объемных КПД
 var Mu,wm:extended;
 begin
 Mu:=0.041208284*exp(-0.03312*(t-40))*1e2; //Н*с/м2 динамическая вязкость МГЕ-46В при темп-ре t
  with Nasos do KPDo:=1-Ky1/Mu*dP/Dnas/Vnas/e*(Cy1+W_max/Abs(Wrads));
       wm:=e*Nasos.Wrads*Nasos.q*Nasos.KPDo/GMotor.q;
  with GMotor do KPDo:=1/(1+Ky2*dP/Mu/Dmot/Vmot{/e2}*(Cy2+W_max/Abs(wm)));
   //    wm:=wm*GMotor.KPD;
 // with GMotor do KPD:=1/(1+Ky2*dP/Mu/Dmot/Vmot{/e2}*(Cy2+W_max/Abs(wm)));
       GMotor.Wrads:=wm*GMotor.KPDo;
               end;

procedure KPD_o11(t,w,dP,e:extended);   // расчет объемного КПД гидронасоса
 var Mu,Nob1:extended;
begin
 Mu:=0.041208284*exp(-0.03312*(t-40))*1e2; //Н*с/м2 **** динамическая вязкость МГЕ-46В при температуре t
// KPDo1:=1-Ky1/Mu*dP/Dnas/Vnas/e*(Cy1+Wnas_max/Abs(w));
// KPDo2:=1/(1+Ky2*dP/Mu/Dmot/Vmot*(Cy2+Wmot_max/Abs(w)));
 //Nob1:=Ky1*dP/(Mu*Dnas*Dnas*w)*(1+w/Wnas_max);

end;


procedure TForm2.Button1Click(Sender: TObject);
begin
itr[1]:=8;
Din.a:=2;
Diz:=Mmz260_9;
//for I := 1 to 34 do

Nasos.Wrads:=Diz.n[0]*Pi/30;
Nasos.Wrads:=2000*Pi/30;
t:=92;
e:=31/78;//0.251;
//e:=1;
Pk:=Din.a*(M1+4700);
//Nasos.wrads:=1;
dP:=2*Pi*Pk*Rk[1]/itr[1]/Mexkpd1(Nasos.wrads)/KPDtr[1]/Gmotor.q*1e-6;
dP:=42; //MPa
KPD_o(t,dP,e);
//Motor.wrads:=
V[1]:=3.6*GMotor.wrads*Rk[1]/Itr[1];
Nasos.M:=e*1e6*dp*Nasos.q/2/Pi;
GMotor.M:=1e6*dp*GMotor.q/2/Pi;
end;
end.

(*
with GMotor do begin  // Poclain MS-18 2099/1050 cm3
  q:={1050e-6;//}2099e-6;            // производительность гидромотора м3/оборот
  w_max:=125*Pi/30;      // max continuos speed               100/125 min-1
  Dmot:=Power(q,1/3);    // м "характерный размер гидромашины"
  Vmot:=W_max*Dmot;      // м/с "характерная скорость гидромашины"
 end; *)
 (*
 with GMotor[2] do begin // MS-35
  q:={1500e-6;//}4000e-6;             // производительность м3/оборот    4198/2099
  w_max:=110*Pi/30;      //                                   110
  Dmot:=Power(q,1/3);    // м "характерный размер гидромашины"
  Vmot:=W_max*Dmot;      // м/с "характерная скорость гидромашины"
 end;
 (*
 with GMotor[1] do begin   //
  q:=111e-6;             // производительность гидромотора м3/оборот
  w_max:=2500*Pi/30;     //
  Dmot:=Power(q,1/3);    // м "характерный размер гидромашины"
  Vmot:=W_max*Dmot;      // м/с "характерная скорость гидромашины"
 end;

 with GMotor[2] do begin
  q:=111e-6;             // производительность м3/оборот
  w_max:=2500*Pi/30;     //
  Dmot:=Power(q,1/3);    // м "характерный размер гидромашины"
  Vmot:=W_max*Dmot;      // м/с "характерная скорость гидромашины"
 end;

 with Nasos[1] do begin
  q:=111e-6;             // производительность м3/оборот
  w_max:=2500*Pi/30;     //
  Dnas:=Power(q,1/3);    // м "характерный размер гидромашины"
  Vnas:=W_max*Dnas;      // м/с "характерная скорость гидромашины"
 end;

 with Nasos[2] do begin
  q:=111e-6;             // производительность м3/оборот
  w_max:=2500*Pi/30;     //
  Dnas:=Power(q,1/3);    // м "характерный размер гидромашины"
  Vnas:=W_max*Dnas;      // м/с "характерная скорость гидромашины"
 end;  *)
  //Wmot_max:=210*Pi/30;     // 730 см3

