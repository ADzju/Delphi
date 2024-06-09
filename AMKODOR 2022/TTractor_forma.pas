unit TTractor_forma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VclTee.TeeGDIPlus, System.Math,ComObj,
  Vcl.Grids, Vcl.ValEdit, {frxClass, frxChart,} VCLTee.TeEngine, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series, Vcl.Buttons,Wywod_Tr;

type
  TForm2 = class(TForm)
    GrafikBtn: TButton;
    Memo1: TMemo;
    GMPWybor: TRadioGroup;
    OpenDannFile: TButton;
    FilePath: TEdit;
    OpenDialog1: TOpenDialog;
    Chart1: TChart;
    Igt_Shag: TButton;
    DiselWybor: TRadioGroup;
    PrintDialog1: TPrintDialog;
    PrintForm: TButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PageSetupDialog1: TPageSetupDialog;
    Pk_Shag: TButton;
    V_Pk_Grafik: TButton;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    Button1: TButton;
    procedure GrafikBtnClick(Sender: TObject);
    procedure OpenDannFileClick(Sender: TObject);
    procedure Igt_ShagClick(Sender: TObject);
    procedure PrintFormClick(Sender: TObject);
    procedure Pk_ShagClick(Sender: TObject);
    procedure V_Pk_GrafikClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 type
GTmas=array[0..34]of double;
MasDV=array[1..2,0..14]of double;
RezultTR= Record
  Num:integer;
  nturb,Mturb:GTMas;
  end;

var
Form2: TForm2;
  Komment,KomGT,KomDiz:Ansistring;
  Nper,fe,n,i,j,ps,bs,N_Igt,N_Md,Nfor,Nrev: integer;
  RezTR      : RezultTR;
  Igt,Kgt,YL : GTmas;
  Md         : MasDV;
  Dsh,Pk,Mk  : array[1..2] of real;
  Ikp,Nu     : array[1..15]of double;
Ga,Imost,Irom,Mlost,MdR,NuMost,NuRom,Dr,n1,I_gt,Ktr,M1,Mdv,Mnasos,Mtur,Ndv,KM_GT,K_Nas_Dv,Mr,V1  : extended;

Function Interpol1(x:double;XMas,YMas:array of double):double;
Function Interpol2(x:double;XMas,YMas:array of double):double;
Procedure GTD_DWS(i_gt:double);

implementation

{$R *.dfm}

var
// for Hook-Jeews
z,h,k,fi,fb: extended;
x,y,p,b : array[1..10] of extended;
x_start:array[1..2]of extended =(0.85,2000);
kk:integer;
xx:array[1..12] of extended;
Fun: extended;

Const
Nkoord=2;
Igt0:GTmas = (0,     0.1,  0.2,  0.3,  0.4,  0.5,  0.6,  0.7,  0.8,  0.9,  0.95,  0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
Igt305:GTmas=(0,     0.1,  0.2,  0.3,  0.4,  0.5,  0.6,  0.7,  0.8,  0.9,  0.95,  0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
Kgt305:GTMas=(3.0,  2.7,  2.4,   2.1,  1.82, 1.60, 1.4,  1.20, 1.03, 1.0,  1.0,   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
YL305:GTMas= (17.19, 18,  18.5, 18.6, 18.9,  18.7, 18.1, 17.0, 15.1, 12.0, 9.20,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
Igt3208:GTMas=(0,0.0611,0.10289375,0.153321875,0.20375,0.25570625,0.307153125,0.357071875,0.4075,0.4625125,0.51039375,0.53484375,0.56235,0.5868,0.61226875,0.637228,0.66473,0.688,0.71567,0.7401,0.7666,0.79,0.817547,0.84047,0.86696,0.89446,0.9189,0.94234375,0.9678125,0,0,0,0,0,0);
Kgt3208:GTMas=(2.767,2.517,2.432,2.313,2.19,2.09,1.99,1.90,1.791,1.71,1.5925,1.525,1.4755,1.41,1.3755,1.3348,1.29,1.242,1.176,1.14,1.095,1.065,1.025925,1.0234,0.96728,0.9068,0.94233,0.95036,1,0,0,0,0,0,0);
YL3208:GTMas=(29.083,29.083,29.32,29.439,29.439,29.439,29.32,29.32,29.083,28.4895,28.133406,28.1334,27.896,27.54,27.1,26.472,25.878,24.928,24.097,22.554,21.367,20.18,18.4,16.0,14.24476,12.464,8.90298,6.5289,4.748,0,0,0,0,0,0);
IgtDana330:GTMas=(0, 0.1,	0.200,0.300,	0.400,	0.500,	0.600,	0.700,	0.800,	0.900,	0.950,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
KgtDana330:GTMas=(2.13,	2.048,	1.965,	1.865,	1.734, 1.585,	1.43,	1.28,	1.119,	0.9,	0.711,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
YLDana330:GTMas=(41.605,42.008,42.334,42.334,41.842,40.102,37.490,34.385,30.237,21.546,7.993,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
Igt3504:GTMas=(0,0.04228,0.100856,0.15332, 0.196109, 0.2501031,0.304606,0.35656,0.406481,0.4569094,	0.5094,	0.5322969,	0.5583,	0.5883281, 0.611,	0.63774,	0.661169,	0.687147,	0.716181,	0.736556,	0.7641,	0.78851,0.8144906,	0.840978,0.865428,0.8909,	0.9184,	0.938778,0.9719,0.99328,0,0,0,0,0);
Kgt3504:GTMas=(2.56667,2.428411, 2.290158, 2.191404, 2.104976,2.00273,	1.900477,	1.82541,1.737147,1.6427,1.53409,1.4943,	1.44963,1.39877,1.35372, 1.303588,
	1.255864,1.217704, 1.157,	1.105534,1.0531, 1.02671,1.00069,	0.97124,	0.97361,	0.9858,	0.9942,	0.99327,	0.99434,	0.9942,0,0,0,0,0);
YL3504:GTMas=(26.9223,26.922,26.92,27.074,27.3,27.3, 27.3, 27.15,26.92,26.77,26.543,26.316,26.164,25.7847,25.406,25.026, 24.4955,24.04,	23.13,22.52,21.61,20.628,19.49,	17.973,
	16.305,	14.788,12.892,10.9964,	6.825,4.171,0,0,0,0,0);
Igt3507:GTMas=(0,	0.0442,0.0879,0.1317,0.175,0.2183,0.2638,0.3049,0.3483,0.3938,0.4379,0.4603,0.4848,0.504,0.5272,0.5478,0.5688,0.5906,0.6125,0.6357,0.6567,0.6786,0.7009,0.7210,0.7451,0.7656,
                0.7893,0.8089,0.8308,0.8544,0.8754,0.8947,0.9179,0.9411,0.9853);
Kgt3507:GTMas=(2.7246,2.4762,2.3271,2.2692,2.1988,2.1305,2.0074,1.9350,1.8320,1.7506,1.6687,1.6279,1.5789,1.5546,1.5046,1.4712,1.4372,1.3981,1.3538,1.3125,1.2744,1.2238,1.1826,1.1322,
               1.0827,1.039,1.0119,0.9977,0.9844,0.9935,0.9857,0.9812,0.977,0.9681,0.9726);
YL3507:GTMas=(26.1639,26.1639,26.1639,26.1639,26.1639,26.2398,26.3914,26.3156,26.3156,26.2398,26.1639,26.0881,25.9364,25.7847,25.6331,25.4055,25.1022,24.8747,24.6472,24.2680,23.8888,23.2821,
              22.9029,22.2962,21.6137,20.8553,20.0211,19.111,18.0493,16.6842,15.1675,13.8024,11.7548,9.1763,3.5644);
Igt35010:GTMas=(0,0.05,0.1,0.15,0.21,0.26,0.31,0.36,0.41,0.46,0.51,0.54,0.56,0.59,0.61,0.64,0.67,0.69,0.71,0.74,0.77,0.79,0.82,0.84,0.87,0.89,0.92,0.94,0.97,0,0,0,0,0,0);
Kgt35010:GTmas=(2.859,2.652,2.518,2.388,2.263,2.129,2.009,1.889,1.801,1.684,1.577,1.517,1.471,1.409,1.367,1.317,1.261,1.225,1.178,1.107,1.061,1.023,1.008,1.01,1.006,1.002,1.013,1.02,1.024,0,0,0,0,0,0);
YL35010:GTmas=(22.22,22.37,22.75,22.98,23.13,23.28,23.28,23.28,23.13,22.9,22.52,22.3,21.99,21.77,21.61,21.23,20.86,20.48,19.87,18.96,18.2,17.06,15.93,15.17,13.65,12.13,10.62,8.72,5.69,0,0,0,0,0,0);
IgtPO350_212:GTMas=(0,    0.1,  0.2, 0.3,  0.4,  0.5, 0.6,  0.7,  0.8,  0.9,  0.95,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
KgtPO350_212:GTmas=(2.635,2.44,2.235,  2,  1.81,1.62, 1.42, 1.25, 1.08, 0.98, 0.96,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
YLPO350_212:GTmas=(28.35,29.1, 29.9,29.8, 29.7, 28.6, 27.56,25.2,22.72, 14.95,8.74,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
Igt3704:GTMas=(0,0.04375,0.0875,0.13125,0.175,0.21875,0.2625,0.30625,0.35,0.39375,0.4375,0.459375,0.48125,0.503125,0.525,0.546875,0.56875,0.590625,0.6125,0.634375,
              0.65625,0.678125,0.7,0.721875,0.74375,0.765625,0.7875,0.809375,0.83125,0.853125,0.875,0.896875,0.91875,0.940625,0.9625);
Kgt3704:GTMas=(3.3229,3.006543,2.79097,2.6774,2.517,2.3629,2.239,2.11,1.99,1.8745,1.768,1.7046,1.663,1.6048,1.5617,1.518,1.4746,1.435,1.396,1.361,1.32,1.2786,1.241,1.207,1.168,1.115,1.065,1.038,0.98,0.971,0.9553,0.95847,0.9643,0.9694,0.961);
YL3704:GTMas=(15.22162831,15.04930799,15.62370906,15.79602938,16.08322992,16.37043045,16.54275077,16.7725112,16.94483152,17.00227163,17.00227163,17.05971173,16.94483152,16.94483152,16.88739141,16.8299513,16.7725112,16.65763098,16.60019088,16.54275077,16.31299034,16.19811013,16.02578981,15.79602938,15.62370906,15.33650853,14.81954757,13.78562564,12.92402404,11.94754222,11.02850051,9.879698377,8.041614958,5.629130471,3.159205876);
IgtZF:GTMas=(0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.85,0.9,0.95,0.965,0.977,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
KgtZF:GTMas=(1.874,1.824,1.764,1.687,1.583,1.479,1.349,1.222,1.090,1.021,0.94,0.86,0.841,0.827,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
YLZF:GTmas=(43.62,45.1,46.35,47.4,48.24,46.77,43.1,38.91,33.87,31.04,23.91,15.84,14.37,13.21,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
IgtLG340_266:GTMas=(    0, 0.1,	0.2,	0.3,	0.4,	0.5,	0.6,	0.7,	0.8,	0.9,	0.95,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
KgtLG340_266:GTMas=(2.66, 2.39, 2.14,	1.91,	1.73,	1.52,	1.35,	1.19,	1.03,	1.01,	0.98,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
YLLG340_266:GTMas =(27.17,27.70,27.91,27.79,27.19,26.25,25.42,24.48,22.3,12.42,6.72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
IgtW340_2813:GTMas=(    0, 0.1,	  0.2,	 0.3,	  0.4,  	0.5,	0.6,	0.7,  0.8,  0.85, 	0.9,  0.95,  0.97,0.977,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
KgtW340_2813:GTMas=(2.813, 2.552, 2.317, 2.047,	1.797, 1.57, 1.362,1.158,0.974,	0.904, 0.819,0.692, 0.603,0.573,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
YLW340_2813:GTMas =(27.83, 28.73, 28.95,29.18, 29.62, 29.62, 28.50,25.58,20.20, 16.83, 13.24,9.426,7.855,7.182,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
IgtW340_2352:GTMas=(    0, 0.1,	  0.2,	 0.3,	  0.4,  	0.5,	0.6,	 0.7,  0.8,  0.9, 	0.95,  0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
KgtW340_2352:GTMas=(2.352, 2.172, 2.015, 1.849,	1.687, 1.503, 1.341,1.186,1.029, 0.995, 0.995, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
YLW340_2352:GTMas =(40.845, 41.52,41.97,42.42, 41.97, 41.29, 39.50, 36.13,31.20, 19.53, 12.12, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

IgtW340_154:GTMas=(    0, 0.1,	  0.2,	 0.3,	  0.4,  	0.5,	0.6,	 0.7,   0.8,   0.9, 	0.95,   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
KgtW340_154:GTMas=(1.540, 1.504,	1.464, 1.405,1.359,	1.302, 1.235, 1.156,  1.069, 0.995,  0.995, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
YLW340_154:GTMas =(64.634,64.859,64.859,65.083,63.063,59.472,54.535,45.782,35.235,21.096,12.343,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

IgtDana380_309:GTMas=(0,    0.10,	 0.20,	0.30,	 0.40,	0.50,	  0.60,	 0.70,	 0.80,	0.88,	0.917, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
KgtDana380_309:GTMas=(3.09, 2.896, 2.615, 2.27,	 1.93,	1.654,  1.427, 1.229,   1.008,0.788,0.663, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
YLDana380_309:GTMas=(15.660,16.479,17.327,18.204,18.926, 19.306,19.306,19.002, 17.721,9.510,5.238, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

MMZ245c2c   : MasDV =((1200,	1300,	1400,	1500,	1600,	1700,	1800, 1900,	2000,	2100,	2200, 2250,0,0,0), //
                     (  445,	475,	490,	502,	502,	495,	485,	470,	450,	420,	395,	  0, 0,0,0));   //
MMZ245_16c  : MasDV =((1000,	1100, 1200,	1300,	1400,	1500,	1600,	1700,	1800, 1850,	0,0,0,0,0),    // 1800 мин-1
                     (  400,	480,	560,	615,	630,	600,	570,	532,	505,	   0,	0,0,0,0,0));   // 90 кВт

MdDeutz4ZF: MasDV =((1000,1200,1400,1600,1800,1900,2000,2100,2200,2332,2340,0,0,0,0), // Deutz BF 4M1013EC
                     (467, 548, 577, 556, 524, 505, 488, 470, 451, 5,0,0,0,0,0));     // 103,9 kw/2200
MDeutz6   : MasDV =((1000,	1200,	1300,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2100,	2300,0,0,0), // Deutz BF6M2012C Tier 2
                     (550,	590,	610,	625,	630,	625,	610,	590,	570,	545,	535,	0,   0,0,0));   // 158 л.с.
MCummins  : MasDV =((800,	1000,	1300,	1500,	1600,	1800,	2000,	2200,	2400,0,0,0,0,0,0),// Cummins 6B5.9 FR90870 Tier 2
                    (514,	542,	786,	740,	721,	668,	629,	560,	0,0,0,0,0,0,0));  // 173 л.с. 2200 мин-1
MPerkins  : MasDV =((800,	1000,	1200,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2200,	2400,0,0,0), //Perkins 1106D-E66TA Tier 2
                    (500,	740,	800,	802,	800,	788,	767,	740,	707,	670,	591,	0,   0,0,0));   // 185 л.с./2200
MdYamz   : MasDV =((1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2150,2200,2340),
                    (610, 630, 645, 660, 667, 659, 651, 642, 632, 622, 612, 602, 550, 300,  10));
Mmz260_1 : MasDV = ((1000,1100,1200,1400,1500,1600,1700,1800,1900,2000,2100,2275,0,0,0),
                    (590, 605,	615,	622, 618, 610, 600,	586,	570,	550,	518, 0,0,0,0));
Mmz260_9 : MasDV = ((1000,1100,1200,1400,1500,1600,1700,1800,1900,2000,2100,2250,0,0,0),
                    (650, 660,	670,	685,	690,	685,	670,	652,	634,	618,	600,	0,0,0,0));
MIveco182  : MasDV = (( 800,	1000,	1200,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2200,	2400,0,0,0), // Engine: F4HE0684E*D1 Tier 2
                       (550,	650,	750,	800,	790,	780,	770,	750,	730,	680,	580,	0,   0,0,0));  // 134 kW/182 HP @ 2200 rpm
MIveco152  : MasDV = ((1000,	1200,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2100,	2200,	2400,0,0,0), // Engine Model: F4GE0684Q*D6 152 HP @ 2200 rpm
                       (590,	585,	582,	578,	575,	572,	570,	550,	535,	508,	485,	0,   0,0,0));
MYAMZ65652 : MasDV = ((900, 1000,	1100,	1200,	1300,	1400,	1500,	1600,	1700,	1800,	1900,	2000,2100,2200,0), // Engine Model: F4GE0684Q*D6 152 HP @ 2200 rpm
                     (1050,	1100,	1130,	1130,	1130,	1130,	1130,	1115,	1070,	1025,	980,	940, 910,0,0));
MYAMZ6566  : MasDV = ((900, 1000,	1100,	1200,	1300,	1400,	1500,	1600,	1700,	1800,	1900,	2000,0,0,0), // Engine Model: F4GE0684Q*D6 152 HP @ 2200 rpm
                     (1050,	1100,	1150,	1150,	1150,	1150,	1150,	1120,	1070,	1035,	1010,	0, 0,0,0));
MYAMZ760110: MasDV = ((1150, 1300, 1500,	1700,	1800,	1900,	2135,	0,	0,	0,	0, 0,0,0,0), // Engine Model: ЯМЗ 7601.10 3000 HP @ 1900 rpm
                     ( 1321, 1314, 1283,	1223,	1179,	1137,	  0,  0,	0,	0,	0, 0,   0,0,0));
MCummC260  : MasDV = ((1000, 1200, 1400,	1500,	1900,	2100,	2200,	2380,	0, 0,	0, 0,0,0,0), // Engine Model: Cummins 6CTAА8.3-С260 @ 2200 rpm
                     (  971, 1077, 1100,	1076,	 937,	 887,	 843,    0,	0, 0,	0, 0,0,0,0));


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

Function Interpol2(x:double;XMas,YMas:array of double):double;
var i,j: byte;
    a,b,c : double;
begin
 if x<=XMas[0] then begin Result:=YMas[0]; exit; end;
   i:=0;
 while XMas[i]<x do inc(i);
 if x>MaxValue(XMas) then begin Result:=YMas[i]; exit; end;
  a:=((Ymas[i+1]-Ymas[i-1])*(Xmas[i]-Xmas[i-1])-(Ymas[i]-Ymas[i-1])*(Xmas[i+1]-Xmas[i-1]))
     /((Sqr(Xmas[i+1])-Sqr(Xmas[i-1]))*(Xmas[i]-Xmas[i-1])-(Sqr(Xmas[i])-Sqr(Xmas[i-1]))*(Xmas[i+1]-Xmas[i-1]));
     b:=(Ymas[i]-Ymas[i-1]-a*(Sqr(Xmas[i])-Sqr(Xmas[i-1])))/(Xmas[i]-Xmas[i-1]);
     c:=Ymas[i-1]-(a*Sqr(Xmas[i-1])+b*Xmas[i-1]);
     Result:=a*x*x+b*x+c;
         end;

Procedure Dann;
begin
    with Form2 do begin
  //   Mlost:=65;
 case GMPWybor.ItemIndex of
     0: begin Dr:=0.32; Igt:=Igt3208;       Kgt:=Kgt3208;       YL:=YL3208;       KomGT:='ГТ 320';      end;
     1: begin Dr:=0.33; Igt:=IgtDana330;    Kgt:=KgtDana330;    YL:=YLDana330;    KomGT:='ГТ Dana 320'; end;
     2: begin Dr:=0.35; Igt:=Igt3504;       Kgt:=Kgt3504;       YL:=YL3504;       end;
     3: begin Dr:=0.35; Igt:=Igt3507;       Kgt:=Kgt3507;       YL:=YL3507;       end;
     4: begin Dr:=0.35; Igt:=Igt35010;      Kgt:=Kgt35010;      YL:=YL35010;      end;
     5: begin Dr:=0.35; Igt:=IgtPO350_212;  Kgt:=KgtPO350_212;  YL:=YLPO350_212;  KomGT:='РО 350/2.635';   end;
     6: begin Dr:=0.37; Igt:=Igt3704;       Kgt:=Kgt3704;       YL:=YL3704;       KomGT:='ГТ 370/3.32 v4'; end;
     7: begin Dr:=0.3;  Igt:=IgtZF;         Kgt:=KgtZF;         YL:=YLZF;         end;
     8: begin Dr:=0.34; Igt:=IgtLG340_266;  Kgt:=KgtLG340_266;  YL:=YLLG340_266;  KomGT:='Львов 340/2.66';end;
     9: begin Dr:=0.305;Igt:=Igt305;        Kgt:=Kgt305;        YL:=YL305;        KomGT:='ГТ 305/3.0';        end;
    10: begin Dr:=0.34; Igt:=IgtW340_2813;  Kgt:=KgtW340_2813;  YL:=YLW340_2813;  KomGT:='FS 340/2.813';    end;
    11: begin Dr:=0.34; Igt:=IgtW340_2352;  Kgt:=KgtW340_2352;  YL:=YLW340_2352;  KomGT:='FS 340/2.2352';   end;
    12: begin Dr:=0.34; Igt:=IgtW340_154;   Kgt:=KgtW340_154;   YL:=YLW340_154;   KomGT:='FS 340/1.540';    end;
    13: begin Dr:=0.38; Igt:=IgtDana380_309;Kgt:=KgtDana380_309;YL:=YLDana380_309;KomGT:='Dana 15.7(380/3.09)';end
                end;
 case DiselWybor.ItemIndex of
     0: begin Md:=MdYamz;     KomDiz:='ЯМЗ 236'; end;
     1: begin Md:=Mmz260_1;   KomDiz:='ММЗ 260.1'; end;
     2: begin Md:=Mmz260_9;   KomDiz:='ММЗ 260.9'; end;
     3: begin Md:=MdDeutz4ZF; KomDiz:='Deutz BF 4M1013EC 104 kW' end;
     4: Md:=MDeutz6;
     5: Md:=MIveco152;
     6: Md:=MIveco182;
     7: begin Md:=MCummins;  KomDiz:='Cummins 6B5.9 FR90870 173 л.с.';     end;
     8: begin Md:=MPerkins;  KomDiz:='Perkins 1106D-E66TA Tier2 185 л.с.'; end;
     9: Md:=MMZ245c2c;
     10: Md:=MMZ245_16c;
     11: begin Md:=MYAMZ65652; KomDiz:='ЯМЗ 65652 270 л.с. 2100 мин-1'; end;
     12: begin Md:=MYAMZ6566;  KomDiz:='ЯМЗ 6566 270 л.с. 1900 мин-1'; end;
     13: begin Md:=MYAMZ760110;KomDiz:='ЯМЗ 7601 300 л.с. 1900 мин-1'; end;
     14: begin Md:=MCummC260; KomDiz:='Cummins C260'; end
         end;

      Form2.Edit1.Text:=Komment+' '+KomGT+' '+KomDiz;
           for I := 1 to Nfor do begin
         Ikp[i]:=StrToFloat(StringGrid1.Cells[1,i]);
         nu[i] :=StrToFloat(StringGrid1.Cells[2,i]);
           end;
            for I := 1 to Nrev do begin
         Ikp[i+Nfor]:=StrToFloat(StringGrid1.Cells[1,i+Nfor]);
          nu[i+Nfor]:=StrToFloat(StringGrid1.Cells[2,i+Nfor]);
             end;
         Imost :=StrToFloat(StringGrid1.Cells[1,Nfor+Nrev+1]);
         NuMost:=StrToFloat(StringGrid1.Cells[2,Nfor+Nrev+1]);
         IRom  :=StrToFloat(StringGrid1.Cells[1,Nfor+Nrev+2]);
         NuRom :=StrToFloat(StringGrid1.Cells[2,Nfor+Nrev+2]);
         Dsh[1]:=2*StrToFloat(StringGrid1.Cells[1,Nfor+Nrev+3]);
         Ga    :=StrToFloat(StringGrid1.Cells[1,Nfor+Nrev+4]);
         MdR   :=StrToFloat(StringGrid1.Cells[1,Nfor+Nrev+5]);
         Mlost :=StrToFloat(StringGrid1.Cells[2,Nfor+Nrev+5]);
         if (Mlost=0) and (Mdr=0) then Mdr:=90;
       if Mlost<>0 then Mdr:=100;
//         Nper:=StrToInt(StringGrid1.Cells[1,Nfor+Nrev+5]);
              end;
     N_Igt:=0; N_Md:=0;
  repeat
   inc(N_Igt);
     until igt[N_Igt]=MaxValue(Igt);
  repeat
   inc(N_Md);
     until Md[1,N_Md]=MaxValue(Md[1]);
          end;


Procedure GTD_DWS(i_gt:double);
var   i:byte;  K:real;
const Ro=1000;
  begin
  k:=Interpol1(i_gt,Igt,YL);
  Mnasos:=9.81e-7*Interpol2(i_gt,Igt,YL)*Ro*Sqr(n1/Irom)*Power(Dr,5);
  Ktr:=Interpol2(i_gt,Igt,Kgt);
  Mtur:=Ktr*Mnasos;
  Mdv:=Interpol1(n1,Md[1],Md[2]);
  //M1:=Mnasos;
   // M2:=Mtur;
            end;


Procedure Sil_Block;
var hs:double; Md_v:boolean;
label m;
begin
  hs:=2; Md_v:=false;
  n1:=MaxValue(Md[1]);
  repeat
  GTD_DWS(i_gt);
   if (Mnasos/Irom/NuRom>Mdv*MdR/100-Mlost) and (Md_v)
      then begin hs:=-hs/2.5; Md_v:=false; end;
   if (Mnasos/Irom/NuRom<Mdv*MdR/100-Mlost) and (not Md_v)
      then begin hs:=-hs/2.5; Md_v:=true; end;
      n1:=n1-hs;
  until abs(hs)<1e-7;
         end;

Procedure Grafik;
label Me;
var Ser:array [0..50] of TLineSeries;
q: boolean;
begin
    with Form2 do begin
  Chart1.SeriesList.Clear;
         ColorPalettes.ApplyPalette(Chart1, 7 );
  for I := 0 to N_Igt+2 do begin Ser[i]:=TLineSeries.Create(Chart1);
                                 Chart1.AddSeries(Ser[i]);
                                 if i>1 then Ser[i].Title:='igt='+FloatToStr(igt[i-2]);
                                end;
  Ser[0].Title:='Mdv';       Ser[1].Title:='Mdv расчетный';
  Ser[0].LinePen.Width := 3; Ser[1].LinePen.Width := 3;
  j:=0; n1:=Md[1,0]-100;
  q:=false;
  repeat
         n1:=n1+100;
       if n1>=MaxValue(Md[1]) then begin n1:=MaxValue(Md[1]);  q:=true; end;
      Mdv:=Interpol1(n1,Md[1],Md[2]);
      Form2.Chart1.Series[0].Add(Mdv,FloatTostr(n1));
      Form2.Chart1.Series[1].Add(Mdv*Mdr/100-Mlost,FloatTostr(n1));
     for I := 2 to N_Igt+2 do begin
     i_gt:=igt[i-2]; GTD_DWS(i_gt);
  Form2.Chart1.Series[i].Add(Mnasos/Irom/NuRom,FloatTostr(n1));// момент насоса приведен к валу ДВС
        end;
        until q;
    end;
end;

procedure TForm2.GrafikBtnClick(Sender: TObject);
begin
 Dann;
  Grafik;
  for i:=0 to N_igt do begin
      i_gt:=igt[i];
        Sil_Block;
   Form2.Memo1.Lines.Add(Format('Igt=%6.3f    n ДВС =%4.0f   Mdv=%5.1f  Mnasos=%5.1f  Mtur=%5.1f  КПД ГМП=%4.2f %%',
                                [I_gt, n1, Mdv, Mnasos, Mtur, Mtur*i_gt/Mnasos*100]));
        end;
           end;

procedure TForm2.OpenDannFileClick(Sender: TObject);
var
s1,s2:double;
FName,St,Prich:AnsiString;
DataFile:TextFile;
Komm_Str:TList;
i,j,k:integer;

 begin
  OpenDialog1.Filter :='Данные для тягового расчета|*.tgr|';
  OpenDialog1.Execute;
  FName:=OpenDialog1.FileName;
  FilePath.Text :=FName;
 AssignFile(DataFile,FName);
   {$I-}
   Reset(DataFile);
   {$I+}
  if IOResult=0 then //Файл существует
             with Form2 do begin
                 try
       readln(DataFile,Nfor,Nrev);
        StringGrid1.RowCount:=Nfor+Nrev+6;
       readln(DataFile,MdR,Mlost);
   StringGrid1.Cells[0,0]:='Параметры';
 StringGrid1.Cells[2,0]:='КПД';
// StringGrid1.Cells[0,Nfor+Nrev+4]:='Передача ТР';
// StringGrid1.Cells[0,Nfor+Nrev+5]:='Рк расч.,кН';
        for I := 1 to Nfor do begin
    readln(DataFile,S1,s2);
  StringGrid1.Cells[0,i]:='Передача '+IntTostr(i);
  StringGrid1.Cells[1,i]:=FloatToStr(s1);
  StringGrid1.Cells[2,i]:=FloatToStr(s2);
      end;
  for I := 1 to Nrev do begin
    readln(DataFile,S1,s2);
  StringGrid1.Cells[0,Nfor+i]:='Передача ЗХ'+IntTostr(i);
  StringGrid1.Cells[1,Nfor+i]:=FloatToStr(s1);
  StringGrid1.Cells[2,Nfor+i]:=FloatToStr(s2);
    end;
//  Datalist.Refresh;
  readln(DataFile,S1,s2);
  i:=Nfor+Nrev+1;
  StringGrid1.Cells[0,i]:='Мост ведущий';
  StringGrid1.Cells[1,i]:=FloatToStr(s1);
  StringGrid1.Cells[2,i]:=FloatToStr(s2);
   inc(i);
   readln(DataFile,S1,s2);
  StringGrid1.Cells[0,i]:='Редуктор (РОМ)';
  StringGrid1.Cells[1,i]:=FloatToStr(s1);
  StringGrid1.Cells[2,i]:=FloatToStr(s2);
   inc(i);
    readln(DataFile,S1);
  StringGrid1.Cells[0,i]:='Радиус колеса,м';
  StringGrid1.Cells[1,i]:=FloatToStr(s1);
    inc(i);
    readln(DataFile,Ga);
  StringGrid1.Cells[0,i]:='Масса при движении, кг';
  StringGrid1.Cells[1,i]:=FloatToStr(Ga);
    inc(i);
 StringGrid1.Cells[0,i]:='Загрузка ДВС% или момент потерь Нм';
 StringGrid1.Cells[1,i]:=FloatToStr(Mdr);
 StringGrid1.Cells[2,i]:=FloatToStr(Mlost);
    readln(DataFile,Komment);
    Form2.Edit1.Text:=Komment;
      CloseFile(DataFile);
       //  end
    finally
       end;
       end
     else  //Файл не существует
    begin
         ShowMessage('Указанный файл не существует');
           Exit;
         end; // Free();
 end;


procedure TForm2.V_Pk_GrafikClick(Sender: TObject);

begin
with RezTR do begin
for I := 0 to 34 do begin RezTR.Mturb[i]:=0; RezTR.nturb[i]:=0; end;
for I := 0 to 34 do begin
 I_gt:=Igt[i];
 Sil_Block;
 Num:=i;
 RezTR.nturb[i]:=n1*I_gt/Irom;
 RezTR.Mturb[i]:=Mtur;
 if I_gt=MaxValue(Igt) then
 begin OutTR_F; exit;
 end;
end;
    end;
   end;

procedure TForm2.Button1Click(Sender: TObject);
begin
with RezTR do begin
for I := 0 to 34 do begin RezTR.Mturb[i]:=0; RezTR.nturb[i]:=0; end;
for I := 0 to 34 do begin
 I_gt:=Igt[i];
 Sil_Block;
 Num:=i;
 RezTR.nturb[i]:=n1*I_gt/Irom;
 RezTR.Mturb[i]:=Mtur;
 if I_gt=MaxValue(Igt) then
 begin OutTR_R; exit;
 end;
end;
    end;
   end;


procedure TForm2.Igt_ShagClick(Sender: TObject);   // расчет с шагом по I_gt
Var
i,j,k: integer; Pt:real;
ExcelApp: Variant;
ExcelDoc: Variant;
ExcelSht: Variant;
//Chart: OLEVariant;
//ChartCount: integer;
DataRange: OLEVariant;
Cellname:string;
Tim: TDateTime;
begin
Dann;
tim:=Now;
 try
ExcelApp := CreateOleObject('Excel.Application');   // Создаем сервер автоматизации
ExcelApp.Application.EnableEvents := false;
ExcelApp.Visible := False;                          // Временно скрываем Excel
ExcelDoc := ExcelApp.Workbooks.Add{('GMP120_6x3_'+Form3.Edit3.Text)};                 // Добавляем документ на основе шаблона
ExcelSht := ExcelDoc.WorkSheets.Add;                // Добавляем страницу в документ
//ExcelSht.ChartObjects.Add(50, 150, 200, 200);     // Добавляем диаграмму на активный лист
 ExcelSht.Range['A1','N1'].Font.Bold:= True;       // атрибут полужирности - OK!
 ExcelSht.Range['A1']:='n мотора';
 ExcelSht.Range['B1']:='Мощность ДВС л.с.';
 ExcelSht.Range['C1']:='Момент ДВС Н*м';
 ExcelSht.Range['D1']:='Момент насоса Н*м Igt=0';
 ExcelSht.Range['E1']:='Момент насоса Н*м Igt=0.1';
 ExcelSht.Range['F1']:='Момент насоса Н*м Igt=0.2';
 ExcelSht.Range['G1']:='Момент насоса Н*м Igt=0.3';
 ExcelSht.Range['H1']:='Момент насоса Н*м Igt=0.4';
 ExcelSht.Range['I1']:='Момент насоса Н*м Igt=0.5';
 ExcelSht.Range['J1']:='Момент насоса Н*м Igt=0.6';
 ExcelSht.Range['K1']:='Момент насоса Н*м Igt=0.7';
 ExcelSht.Range['L1']:='Момент насоса Н*м Igt=0.8';
 ExcelSht.Range['M1']:='Момент насоса Н*м Igt=0.9';
 ExcelSht.Range['N1']:='Момент насоса Н*м Igt=0.95';
     j:=2;
      for j:=2 to N_Md+2 do begin// repeat
   n1:=Md[1,j-2];
    GTD_DWS(0);
  ExcelSht.Range['A' + IntToStr(j)] :=n1;
  ExcelSht.Range['B' + IntToStr(j)] :=Mdv*n1/9.81/716.2;
  ExcelSht.Range['C' + IntToStr(j)] :=Mdv;
  ExcelSht.Range['D' + IntToStr(j)] :=Mnasos; GTD_DWS(0.1);
  ExcelSht.Range['E' + IntToStr(j)] :=Mnasos; GTD_DWS(0.2);
  ExcelSht.Range['F' + IntToStr(j)] :=Mnasos; GTD_DWS(0.3);
  ExcelSht.Range['G' + IntToStr(j)] :=Mnasos; GTD_DWS(0.4);
  ExcelSht.Range['H' + IntToStr(j)] :=Mnasos; GTD_DWS(0.5);
  ExcelSht.Range['I' + IntToStr(j)] :=Mnasos; GTD_DWS(0.6);
  ExcelSht.Range['J' + IntToStr(j)] :=Mnasos; GTD_DWS(0.7);
  ExcelSht.Range['K' + IntToStr(j)] :=Mnasos; GTD_DWS(0.8);
  ExcelSht.Range['L' + IntToStr(j)] :=Mnasos; GTD_DWS(0.9);
  ExcelSht.Range['M' + IntToStr(j)] :=Mnasos; GTD_DWS(0.95);
  ExcelSht.Range['N' + IntToStr(j)] :=Mnasos;
  end;
  ExcelSht.Range['A' + IntToStr(j)] :=' Iмоста';
  ExcelSht.Range['B' + IntToStr(j)] :=' КПД моста';
  ExcelSht.Range['C' + IntToStr(j)] :=' Irom';
  ExcelSht.Range['D' + IntToStr(j)] :=' Rk';
       inc(j);
  ExcelSht.Range['A' + IntToStr(j)] :=Imost;
  ExcelSht.Range['B' + IntToStr(j)] :=Numost;
  ExcelSht.Range['C' + IntToStr(j)] :=Irom;
  ExcelSht.Range['D' + IntToStr(j)] :=Dsh[1]/2;
       inc(j);
  ExcelSht.Range['B' + IntToStr(j)] :=' Pk, kH';
  ExcelSht.Range['C' + IntToStr(j)] :=' Iгт';
  ExcelSht.Range['A' + IntToStr(j)] :=' V км/ч';
  ExcelSht.Range['D' + IntToStr(j)] :=' n двс';
  ExcelSht.Range['E' + IntToStr(j)] :=' Mнасоса';
  ExcelSht.Range['F' + IntToStr(j)] :=' M мотора';
  ExcelSht.Range['G' + IntToStr(j)] :=' n турбины';
  ExcelSht.Range['H' + IntToStr(j)] :=' М турбины';
  ExcelSht.Range['I' + IntToStr(j)] :=' Ngt kw.';
  ExcelSht.Range['J' + IntToStr(j)] :=' КПД ГМП';
  for k := 1 to Nfor+Nrev do begin
    Nper:=k;
     j:=j+2;
    ExcelSht.Range['A' + IntToStr(j)] :='Передача '+IntTostr(k); ExcelSht.Range['B' + IntToStr(j)] :=Ikp[k]; ExcelSht.Range['C' + IntToStr(j)] :=nu[k];
     for I := 0 to N_Igt do begin
         i_gt:=igt[i];
         Sil_Block;
        v1:=3.6*Dsh[1]/2*n1*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
        Ndv:=Mnasos*n1/Irom/9.81/716.2/Nurom;
        Pk[1]:=Mtur*Imost*Ikp[Nper]/Dsh[1]*2e-3*nu[Nper]*NuMost; //=======================================
            inc(j);
  ExcelSht.Range['B' + IntToStr(j)] :=Pk[1];
  ExcelSht.Range['C' + IntToStr(j)] :=i_gt;
  ExcelSht.Range['A' + IntToStr(j)] :=V1;
  ExcelSht.Range['D' + IntToStr(j)] :=n1;
  ExcelSht.Range['E' + IntToStr(j)] :=Mnasos;
  ExcelSht.Range['F' + IntToStr(j)] :=Mdv;
  ExcelSht.Range['G' + IntToStr(j)] :=n1*i_gt/Irom;
  ExcelSht.Range['H' + IntToStr(j)] :=Mtur;
  ExcelSht.Range['I' + IntToStr(j)] :=Mtur*n1/Irom*I_gt/1000*3.1415/30;
  ExcelSht.Range['J' + IntToStr(j)] :=Mtur*i_gt/Mnasos*100;
                  end;
                       end;
   Form2.Memo1.Lines.Add('Расчет выполнен '+DateToStr(Now)+' за '+TimeToStr(Now-Tim)+'ч/мин/с');
      finally
  if not VarIsEmpty(ExcelApp) then ExcelApp.Visible := True;
          ExcelApp := UnAssigned;
    end;
      end;
procedure TForm2.PrintFormClick(Sender: TObject);
begin
  // Form2.Printer..PrinterIndex:=0;
  // Printer.Orientation:=poLandscape;//poPortrait
   Form2.PrintScale:=poPrintToFit;//poProportional;//
    PrinterSetupDialog1.Execute;
    Form2.Print;
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
 StringGrid1.ColCount:=3;
 StringGrid1.ColWidths[0]:=210;
 StringGrid1.ColWidths[1]:=50;
 StringGrid1.ColWidths[2]:=50;
 StringGrid1.Width:=316;
 StringGrid1.Cells[0,0]:='Параметры';
 StringGrid1.Cells[2,0]:='КПД';
    end;

procedure HookJi(Pras:double);
 label 0,1,2,3,4,5,6,7;
  procedure calculate; // Процедура,вычисляющая функцию
 var
  i,k: integer;
 begin
  Z:=0;
   i_gt:=x[1];
   n1  :=x[2];
   Mk[1]:=Pras*Dsh[1]/2;
   Mr:=Mk[1]/Imost/Ikp[Nper]/nu[Nper]/NuMost;
      GTD_DWS(i_gt);
    v1:=3.6*Dsh[1]/2*n1/Irom*i_gt/30*pi/Imost/Ikp[Nper];  // км/ч  +++
    z:=1e3*Sqr(Mtur-Mr)+2e4/V1;
    if (Mdv*MdR/100-Mlost)<=Mnasos/Irom/NuRom then z:=z+1e4*Sqr(Mnasos/Irom/NuRom-Mdv{*Kimd});
            inc(fe);
         end;

begin
     n:=2;        // число переменных
     x[1]:=0.8;
     x[2]:=0.9*MaxValue(Md[1]);  // начальные точки x1,...xN'
     h:=0.001;    // длина шага
 k:=h;
  fe:=0;
     for i:=1 to n do begin
      y[i]:=x[i];
      p[i]:=x[i];
      b[i]:=x[i];
          end;
 calculate;
    fi:=z;
with Form2 do begin  // Memo1.Lines.Add('Начальное значение функции'+Format(' %5.3f ',[z]));
   ps:=0;
   bs:=1;
// Исследование вокруг базисной точки
  j:=1;
   fb:=fi;
0: x[j]:=y[j]+k;
   calculate;
   if z<fi then goto 1;
      x[j]:=y[j]-k;
      calculate;
   if z<fi then goto 1;
      x[j]:=y[j];
      goto 2;
1: y[j]:=x[j];
2: calculate;
      fi:=z;
                //    Memo1.Lines.Add('Пробный шаг ' +Format(' %9.6f ',[z]));
 //  for i:=1 to n do Memo1.Lines.Add(Format(' %5.3f ',[x[i]]));
   if j=n then goto 3;
      j:=j+1;
      goto 0;
3: if fi<fb-1e-1 then goto 6; //После метки 3,если функция не уменьшилась, произвести поиск по образцу
   if (ps=1) and (bs=0) then goto 4;
// если исследование производилось вокруг точки шаблона PT, и уменьшение не достигнуто, изменить базисную точку в операторе 4: иначе уменьшить длину шага в операторе 5
      goto 5;
4: for i:=1 to n do
      begin
      p[i]:=b[i];
      y[i]:=b[i];
      x[i]:=b[i];
        end;
    calculate;
      bs:=1;
      ps:=0;
      fi:=z;
      fb:=z;
//                  Memo1.Lines.Add('Замена базисной точки. F='+Format(' %5.3f ',[z]));
//  for i:=1 to n do Memo1.Lines.Add(Format('xi= %5.3f ',[x[i]]));
//(следует за последним комментарием) и провести исследование вокруг новой базисной точки
      j:=1; goto 0;
5: k:=k/4;
//                  Memo1.Lines.Add('Уменьшить длину шага');
   if k<1e-12 then goto 7; //Если поиск не закончен, произвести новое исследование вокруг новой базисной точки
      j:=1; goto 0;
(*** Поиск по образцу ***)
6: for i:=1 to n do
      begin
     p[i]:=2*y[i]-b[i];
     b[i]:=y[i];
     x[i]:=p[i];
     y[i]:=x[i];
      end;
   calculate;
     fb:=fi;
     ps:=1;
     bs:=0;
     fi:=z;
//                   Memo1.Lines.Add('Поиск по образцу '+Format(' %5.3f ',[z]));
//  for i:=1 to n do Memo1.Lines.Add(Format(' %5.3f ',[x[i]]));
// После этого произвести исследование вокруг последней точки образца
     j:=1; goto 0;
7:            (*      Memo1.Lines.Add('Минимум найден');
    for i:=1 to n do Memo1.Lines.Add('x(' + IntToStr(i)+ ')=' +Format(' %5.3f ',[p[i]]));
                     Memo1.Lines.Add('Минимум функции равен'+Format(' %5.3f ',[fb]));
                     Memo1.Lines.Add('Количество вычислений функции равно '+IntToStr(fe));    *)
                    i_gt:=p[1]; n1:=p[2];
                    GTD_DWS(i_gt);
        v1:=3.6*Dsh[1]/2*n1*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
        Ndv:=Mnasos*n1/Irom/9.81/716.2;
        Pk[1]:=Mtur*Imost*Ikp[Nper]/Dsh[1]*2e-3*nu[Nper]*NuRom*NuMost;
Form2.Memo1.Lines.Add('Передача '+IntToStr(Nper)+Format('. Itr=%7.3f    Pk= %7.1f kH    Скорость (без буксования) =%7.3f км/ч', [Imost*Ikp[Nper],Pk[1],V1]));
  // Form3.Memo1.Lines.Add(Format('Шаг параметров = %10.8e', [H_s[1]]));
   Form2.Memo1.Lines.Add(Format('I gt=%7.3f    n ДВС (n1) =%6.1f   Mdv=%6.2f  Mnasos=%6.2f  Mtur=%6.2f', [I_gt, n1, Mdv, Mnasos, Mtur]));
   Form2.Memo1.Lines.Add(Format('К-т использ.Mгмп =%5.3f,   К-т трансф-и=%6.4f    К-т использ.Мдвс =%5.3f,    Nдвс =%5.1f л.с.', [KM_GT,Ktr,K_Nas_dv, Ndv]));
   Form2.Memo1.Lines.Add(Format('КПД ГМП=%5.2f %%', [Mtur*i_gt/Mnasos*100]));
                        exit;
              end;
           end;


procedure TForm2.Pk_ShagClick(Sender: TObject);
  Var
i,j: integer; Pt:real;
ExcelApp: Variant;
ExcelDoc: Variant;
ExcelSht: Variant;
Cellname:string;
Tim: TDateTime;
begin
Dann;
tim:=Now;
 try
ExcelApp := CreateOleObject('Excel.Application');   // Создаем сервер автоматизации
ExcelApp.Application.EnableEvents := false;
ExcelApp.Visible := False;                          // Временно скрываем Excel
ExcelDoc := ExcelApp.Workbooks.Add{('GMP120_6x3_'+Form3.Edit3.Text)};                 // Добавляем документ на основе шаблона
ExcelSht := ExcelDoc.WorkSheets.Add;                // Добавляем страницу в документ
 ExcelSht.Range['A1','N1'].Font.Bold:= True;       // атрибут полужирности - OK!
 ExcelSht.Range['A1']:='n мотора';
 ExcelSht.Range['B1']:='Мощность ДВС л.с.';
 ExcelSht.Range['C1']:='Момент ДВС Н*м';
 ExcelSht.Range['D1']:='Момент насоса Н*м Igt=0';
 ExcelSht.Range['E1']:='Момент насоса Н*м Igt=0.1';
 ExcelSht.Range['F1']:='Момент насоса Н*м Igt=0.2';
 ExcelSht.Range['G1']:='Момент насоса Н*м Igt=0.3';
 ExcelSht.Range['H1']:='Момент насоса Н*м Igt=0.4';
 ExcelSht.Range['I1']:='Момент насоса Н*м Igt=0.5';
 ExcelSht.Range['J1']:='Момент насоса Н*м Igt=0.6';
 ExcelSht.Range['K1']:='Момент насоса Н*м Igt=0.7';
 ExcelSht.Range['L1']:='Момент насоса Н*м Igt=0.8';
 ExcelSht.Range['M1']:='Момент насоса Н*м Igt=0.9';
 ExcelSht.Range['N1']:='Момент насоса Н*м Igt=0.95';
     j:=1;
       repeat
       inc(j);
   n1:=Md[1,j-2];
    GTD_DWS(0);
  ExcelSht.Range['A' + IntToStr(j)] :=n1;
  ExcelSht.Range['B' + IntToStr(j)] :=Mdv*n1/9.81/716.2;
  ExcelSht.Range['C' + IntToStr(j)] :=Mdv;
  ExcelSht.Range['D' + IntToStr(j)] :=Mnasos; GTD_DWS(0.1);
  ExcelSht.Range['E' + IntToStr(j)] :=Mnasos; GTD_DWS(0.2);
  ExcelSht.Range['F' + IntToStr(j)] :=Mnasos; GTD_DWS(0.3);
  ExcelSht.Range['G' + IntToStr(j)] :=Mnasos; GTD_DWS(0.4);
  ExcelSht.Range['H' + IntToStr(j)] :=Mnasos; GTD_DWS(0.5);
  ExcelSht.Range['I' + IntToStr(j)] :=Mnasos; GTD_DWS(0.6);
  ExcelSht.Range['J' + IntToStr(j)] :=Mnasos; GTD_DWS(0.7);
  ExcelSht.Range['K' + IntToStr(j)] :=Mnasos; GTD_DWS(0.8);
  ExcelSht.Range['L' + IntToStr(j)] :=Mnasos; GTD_DWS(0.9);
  ExcelSht.Range['M' + IntToStr(j)] :=Mnasos; GTD_DWS(0.95);
  ExcelSht.Range['N' + IntToStr(j)] :=Mnasos;
       until n1=MaxValue(Md[1]);
       inc(j);
  ExcelSht.Range['A' + IntToStr(j)] :=' Iмоста';
  ExcelSht.Range['B' + IntToStr(j)] :=' КПД моста';
  ExcelSht.Range['C' + IntToStr(j)] :=' Irom';
  ExcelSht.Range['D' + IntToStr(j)] :=' Rk';
       inc(j);
  ExcelSht.Range['A' + IntToStr(j)] :=Imost;
  ExcelSht.Range['B' + IntToStr(j)] :=Numost;
  ExcelSht.Range['C' + IntToStr(j)] :=Irom;
  ExcelSht.Range['D' + IntToStr(j)] :=Dsh[1]/2;
       inc(j);      inc(j);
  ExcelSht.Range['A' + IntToStr(j)] :=' Pk, kH';
  ExcelSht.Range['B' + IntToStr(j)] :=' Iгт';
  ExcelSht.Range['C' + IntToStr(j)] :=' V км/ч';
  ExcelSht.Range['D' + IntToStr(j)] :=' n двс';
  ExcelSht.Range['E' + IntToStr(j)] :=' Mнасоса';
  ExcelSht.Range['F' + IntToStr(j)] :=' n турбины';
  ExcelSht.Range['G' + IntToStr(j)] :=' М турбины';
  ExcelSht.Range['H' + IntToStr(j)] :=' Nдвс л.с.';
  ExcelSht.Range['I' + IntToStr(j)] :=' КПД ГМП';
  for i := 1 to Nfor+Nrev do begin
    Nper:=i;
     j:=j+2;
    ExcelSht.Range['A' + IntToStr(j)] :='Передача '+IntTostr(i);
    ExcelSht.Range['B' + IntToStr(j)] :=Ikp[i];
    ExcelSht.Range['C' + IntToStr(j)] :=Nu[i];
          n1:=Md[1,N_md-1];
          i_gt:=0;
          Sil_Block;
          GTD_DWS(i_gt);
        v1:=3.6*Dsh[1]/2*n1*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
        Ndv:=Mnasos*n1/Irom/9.81/716.2;
        Pk[1]:=Mtur*Imost*Ikp[Nper]/Dsh[1]*2e-3*nu[Nper]*NuMost;
            inc(j);     if Mnasos=0 then Mnasos:=1e-5;
  ExcelSht.Range['A' + IntToStr(j)] :=Pk[1];
  ExcelSht.Range['B' + IntToStr(j)] :=i_gt;
  ExcelSht.Range['C' + IntToStr(j)] :=V1;
  ExcelSht.Range['D' + IntToStr(j)] :=n1;
  ExcelSht.Range['E' + IntToStr(j)] :=Mnasos;
  ExcelSht.Range['F' + IntToStr(j)] :=n1*i_gt;
  ExcelSht.Range['G' + IntToStr(j)] :=Mtur;
  ExcelSht.Range['H' + IntToStr(j)] :=Ndv;
  ExcelSht.Range['I' + IntToStr(j)] :=Mtur*i_gt/Mnasos*100;
     Pt:=100000-i*10000;

        if i>Nfor then Pt:=60000-(i-6)*10000;
              repeat
               HookJi(Pt);
               if Pk[1]>1 then begin
                  inc(j);
  ExcelSht.Range['A' + IntToStr(j)] :=Pk[1];
  ExcelSht.Range['B' + IntToStr(j)] :=i_gt;
  ExcelSht.Range['C' + IntToStr(j)] :=V1;
  ExcelSht.Range['D' + IntToStr(j)] :=n1;
  ExcelSht.Range['E' + IntToStr(j)] :=Mnasos;
  ExcelSht.Range['F' + IntToStr(j)] :=n1*i_gt;
  ExcelSht.Range['G' + IntToStr(j)] :=Mtur;
  ExcelSht.Range['H' + IntToStr(j)] :=Ndv;
  ExcelSht.Range['I' + IntToStr(j)] :=Mtur*i_gt/Mnasos*100;
                  end;
         Pt:=Pt-2500;
      until (Pt<1) ;
   end;
   Form2.Memo1.Lines.Add('Расчет выполнен '+DateToStr(Now)+' за '+TimeToStr(Now-Tim)+'ч/мин/с');
      finally
  if not VarIsEmpty(ExcelApp) then ExcelApp.Visible := True;
          ExcelApp := UnAssigned;
    end;
      end;
end.
(*
function ZelKS(Pras:double):boolean;
 var
  i,k: integer;
begin
  Z:=0;
   i_gt:=xx[1];
   n1  :=xx[2];
   Mk[1]:=Pras*Dsh[1]/2;
   Mr:=Mk[1]/Imost/Ikp[Nper]/nu[Nper]/NuRom/NuMost;
      GTD_DWS(i_gt);
    v1:=3.6*Dsh[1]/2*n1*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
    z:=1e3*Sqr(Mtur-Mr)+3e4/V1;
    if Mdv*Mdr/100-Mlost<=Mnasos then z:=z+1e4*Sqr(Mnasos-Mdv{*Kimd});
            inc(fe);
           Fun:=z;
           Result:=true;
                end;

procedure KoordSp_Ord(Pras:double);
label k1;
const Dshag=3;  // 3
var
b,c,h,e,ee:extended;  // шаг и точность одинаковы для всех переменных
i:integer;
begin
   h:=0.02; e:=1e-7;   kk:=0;
      ee:=h;
    for i:=1 to Nkoord do xx[i]:=x_start[i];
    repeat
  k1:    for i:=1 to Nkoord do begin
            b:=1e99;
     repeat
     repeat
     xx[i]:=xx[i]+h; if not ZelKS(Pras) then exit;
       c:=b;
        b:=Fun;   inc(kk);
        until Fun>c;
        h:=-h/Dshag;
         until abs(h)<Abs(ee/Dshag);
          h:=ee;
           end; // to Nkoord
        ee:=ee/Sqr(Dshag);   h:=ee;
         until e/Sqr(Dshag)>ee;// then goto k1;
       Form2.Memo1.Lines.add('x='+Format(' %9.7f %9.7f %9.3f',[xx[1],xx[2],Fun]));
           end;

procedure KoordSp_Spir(Pras:double);
var
b,c,h,e:extended;  // шаг и точность одинаковы для всех переменных
i:integer;
begin
   h:=0.05; e:=1e-6;
   kk:=0;
    for i:=1 to Nkoord do xx[i]:=x_start[i];
//  k1:
   repeat
   for i:=1 to Nkoord do begin
            b:=1e99;
        repeat
   xx[i]:=xx[i]+h; if not ZelKS(Pras) then exit;
      c:=b;
      b:=Fun;  inc(kk);
        until Fun>c;
        end; // i
     h:=-h/5;
         until abs(h)<Abs(e/5);
        Form2.Memo1.Lines.add('x='+Format(' %9.7f %9.7f %9.3f',[xx[1],xx[2],Fun]));
           end;
  *)
