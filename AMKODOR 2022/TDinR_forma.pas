unit TDinR_forma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VclTee.TeeGDIPlus, System.Math,ComObj,
  Vcl.Grids, Vcl.ValEdit, {frxClass, frxChart,} VCLTee.TeEngine, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series, Vcl.Buttons,Wywod_TDinR;

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
    StringGrid1: TStringGrid;
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Label1: TLabel;
    Button2: TButton;
    T_Dinam: TButton;
    Usk_strt: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    I_end: TEdit;
    Label4: TLabel;
    I_Start: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Usk_p1: TEdit;
    Usk_p2: TEdit;
    Usk_p3: TEdit;
    TD_out: TEdit;
    Button3: TButton;
    procedure GrafikBtnClick(Sender: TObject);
    procedure OpenDannFileClick(Sender: TObject);
    procedure Igt_ShagClick(Sender: TObject);
    procedure PrintFormClick(Sender: TObject);
    procedure Pk_ShagClick(Sender: TObject);
    procedure V_Pk_GrafikClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure T_DinamClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 type
GTmas=array[0..34]of double;
//MasDV=array[1..2,0..14]of double;

RezultTR= Record
  Num:integer;
  nturb,Mturb:GTMas;
  end;

GTR=record
CommGTR        : ansistring;
Dr             : double;
IGTR,KGTR,YLGTR: GTmas;
end;

Dinam=Record
V,S,t,N,a,Epolez,Esumm: double;
end;

Dizel=record
Comm           : ansistring;
n,M            : array[0..14]of double;
end;

var
Form2: TForm2;
  Komment:Ansistring;
  Nper,fe,n,i,j,j0,ps,bs,N_Igt,N_Md,Nfor,Nrev: integer;
  RezTR      : RezultTR;
  GT : GTR;
  Diz: Dizel;
  Pk,Mk      : array[1..2] of real;
  Ikp,Nu,f   : array[1..15]of double;
Ga,Imost,Irom,Mlost,MdR,NuMost,NuRom,n_d,I_gt,Ktr,M1,V1,Bux,Rk,Rst,Rsil,Rkin,
Md_brt,Mnasos,Mtur,Ndv_net,Md_net,KM_GT,K_Nas_Dv,Mr   : double;

Function Interpol1(x:double;XMas,YMas:array of double):double;
Function Interpol2(x:double;XMas,YMas:array of double):double;
Procedure GTD_DWS(i_gt:double);
Procedure R_r(Nper:integer);

implementation

{$R *.dfm}

var
// for Hook-Jeews
Din: Dinam;
z,h,k,fi,fb: extended;
x,y,p,b : array[1..10] of extended;
x_start:array[1..2]of extended =(0.85,2000);
kk:integer;
xx:array[1..12] of extended;
Fun: extended;

ExcelApp: Variant;
ExcelDoc: Variant;
ExcelSht: Variant;
DataRange: OLEVariant;

Const
Nkoord=2;
FikrPr=0.75{67};
Delta_lim=0.5;
Kbux=0.25;
Ro=1000;

W300: GTR=(CommGTR:'W300 1.874/104(Брянск)';  Dr:0.3;   //+++
  IGTR :(0,      0.1,   0.2,  0.3,   0.4,   0.5,   0.6,  0.7,  0.8,  0.85,0.9, 0.951,0.965,0.977,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR :(1.874,  1.824,1.764, 1.687,1.583,  1.479, 1.349,1.222,1.090,1.021,0.94,0.86,0.841,0.827,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(39.795,41.135,42.283,43.239,44.005,42.665,39.317,35.491,30.899,28.316,21.811,14.445,13.106,12.053,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
GT280: GTR=(CommGTR:'ГТ 280 3.0/44';     Dr:0.28;  //
  IGTR:(0,      0.1,    0.2,   0.3,   0.4,   0.5,   0.6,  0.7,   0.8,   0.9,   0.95,  0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KGTR:( 3.0,   2.3,    2.1,   1.8,   1.5,   1.30,  1.1,  1.0,   1.0,   1.0,   1.0,   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(25.86, 27.89,  28.36, 28.7, 28.24, 26.55, 23.88, 21.91, 19.52, 16.68, 12.5,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
  GT305: GTR=(CommGTR:'ГТ P-O-305 3.0/48.8';     Dr:0.305;  //+++
  IGTR:(0,     0.1,  0.2,  0.3,   0.4,  0.5,  0.6,  0.7,  0.8,  0.9,  0.95,  0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KGTR:( 3.0,  2.7,  2.4,   2.1,  1.82, 1.60, 1.4,  1.20, 1.03, 1.0,  1.0,   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(17.19, 18,  18.5, 18.6, 18.9,  18.7, 18.1, 17.0, 15.1, 12.0, 9.20,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
GT3208: GTR=(CommGTR:'ГТ 320 2.767/105';  Dr:0.32;   //+++
  IGTR:(0,     0.1028, 0.20375, 0.307,   0.4075, 0.510,  0.612,  0.7157, 0.79, 0.840,  0.867,  0.894,0.919,0.94234,0.9678,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KGTR:(2.767, 2.432,  2.19,    1.99,    1.791,  1.5925, 1.3755, 1.176,  1.065,1.0234, 0.96728,0.9068,0.94233,0.95036,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(29.083,29.32, 29.439,  29.32,   29.083, 28.1334, 27.1,  24.097, 20.18, 16.0,  14.245, 12.464,8.903,6.529,4.748,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
Dana330: GTR=(CommGTR:'Dana 330 2.13/175';  Dr:0.33;
  IGTR:(0, 0.1,	0.200,0.300,	0.400,	0.500,	0.600,	0.700,	0.800,	0.900,	0.9501,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KGTR:(2.13,	2.048,	1.965,	1.865,	1.734, 1.585,	1.43,	1.28,	1.119,	0.9,	0.711,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(41.605,42.008,42.334,42.334,41.842,40.102,37.490,34.385,30.237,21.546,7.993,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
Lv340266: GTR=(CommGTR:'Львов ЛГ340 2.66/133';  Dr:0.34;  //?? карпыза
  IGTR:(    0, 0.1,	0.2,	0.3,	0.4,	0.5,	0.6,	0.7,	0.8,	0.9,	0.9501,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR:(2.66, 2.39, 2.14,	1.91,	1.73,	1.52,	1.35,	1.19,	1.03,	1.01,	0.98,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(27.17,27.70,27.91,27.79,27.19,26.25,25.42,24.48,22.3,12.42,6.72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
TGD340264: GTR=(CommGTR:'ТГД340 2.64/130';  Dr:0.34; //+++
  IGTR :(   0, 0.1,	 0.2,	0.3,	0.4, 0.5,	  0.6,	0.7,	0.8,	0.9, 0.9501,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR :(2.64,2.36, 2.10,1.87, 1.62, 1.44, 1.28, 1.15, 1.01, 0.96, 0.76,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(26.6,27.1, 27.5,27.5, 27.1, 26.6, 25.6, 24.7, 21.8, 13.3, 5.7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
GT3504: GTR=(CommGTR:'ГТ 350 2.567/152';  Dr:0.35;
  IGTR:(0,    0.0423, 0.101, 0.153, 0.1961, 0.2501, 0.3046, 0.357,0.4065,0.457,	0.5094,	0.5323,	0.558,	0.5883, 0.611,	0.638,	0.661,	0.687,	0.716,	0.7366,	0.764,	0.789,0.8145,	0.841,0.8654,0.891,	0.918,	0.9388,0.97,0.993,0,0,0,0,0);
  KgtR:(2.567,2.4284, 2.290, 2.191, 2.105,  2.003,	1.900,	1.825,1.737, 1.643, 1.534,  1.494,	1.45,   1.3988,1.3537, 1.3036,
	1.256,1.218, 1.157,	1.105534,1.0531, 1.0267,1.001,	0.971,	0.9736,	0.9858,	0.994,	0.993,	0.994,	0.9942,0,0,0,0,0);
  YLGTR:(26.9223,26.922,26.92,27.074,27.3,27.3, 27.3, 27.15,26.92,26.77,26.543,26.316,26.164,25.7847,25.406,25.026, 24.4955,24.04,	23.13,22.52,21.61,20.628,19.49,	17.973,
	16.305,	14.788,12.892,10.9964,	6.825,4.171,0,0,0,0,0));
GT3507: GTR=(CommGTR:'ГТ 350 2.725/148';  Dr:0.35;
  IGTR:(0,	0.0442,0.0879,0.1317,0.175,0.2183,0.2638,0.3049,0.3483,0.3938,0.4379,0.4603,0.4848,0.504,0.5272,0.5478,0.5688,0.5906,0.6125,0.6357,0.6567,0.6786,0.7009,0.7210,0.7451,0.7656,
                0.7893,0.8089,0.8308,0.8544,0.8754,0.8947,0.9179,0.9411,0.9853);
  KgtR:(2.7246,2.4762,2.3271,2.2692,2.1988,2.1305,2.0074,1.9350,1.8320,1.7506,1.6687,1.6279,1.5789,1.5546,1.5046,1.4712,1.4372,1.3981,1.3538,1.3125,1.2744,1.2238,1.1826,1.1322,
               1.0827,1.039,1.0119,0.9977,0.9844,0.9935,0.9857,0.9812,0.977,0.9681,0.9726);
  YLGTR:(26.1639,26.1639,26.1639,26.1639,26.1639,26.2398,26.3914,26.3156,26.3156,26.2398,26.1639,26.0881,25.9364,25.7847,25.6331,25.4055,25.1022,24.8747,24.6472,24.2680,23.8888,23.2821,
              22.9029,22.2962,21.6137,20.8553,20.0211,19.111,18.0493,16.6842,15.1675,13.8024,11.7548,9.1763,3.5644));
GT3502512: GTR=(CommGTR:'ГТ 350 2.512/139';  Dr:0.35;
  IGTR :(0.000,	0.099,	0.202,	0.303,	0.408,	0.509,	0.613,	0.712,	0.816,	0.839,	0.864,	0.893,	0.919,	0.940,	0.966,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR :(2.512,	2.224,	2.056,	1.914,	1.769,	1.548,	1.381,	1.193,	1.049,	1.001,	1.011,	1.099,	1.012,	1.015,	0.950,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(24.561,25.253,25.253, 24.907, 24.561, 24.215,	22.970,	20.756,	17.296,	16.259,	14.667,	12.107,	11.208,	9.340,	6.227,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
GT35010: GTR=(CommGTR:'ГТ 350 2.859/126';  Dr:0.35;  // +++
  IGTR:(0,0.05,0.1,0.15,0.21,0.26,0.31,0.36,0.41,0.46,0.51,0.54,0.56,0.59,0.61,0.64,0.67,0.69,0.71,0.74,0.77,0.79,0.82,0.84,0.87,0.89,0.92,0.94,0.97,0,0,0,0,0,0);
  KgtR :(2.859,2.652,2.518,2.388,2.263,2.129,2.009,1.889,1.801,1.684,1.577,1.517,1.471,1.409,1.367,1.317,1.261,1.225,1.178,1.107,1.061,1.023,1.008,1.01,1.006,1.002,1.013,1.02,1.024,0,0,0,0,0,0);
  YLGTR:(22.22,22.37,22.75,22.98,23.13,23.28,23.28,23.28,23.13,22.9,22.52,22.3,21.99,21.77,21.61,21.23,20.86,20.48,19.87,18.96,18.2,17.06,15.93,15.17,13.65,12.13,10.62,8.72,5.69,0,0,0,0,0,0));
GTPO350212: GTR=(CommGTR:'P-O-350 2.1.2 2.635/146';  Dr:0.35; // ++++
  IGTR :(0.000,	0.200,	0.400,	0.600,	0.800,	0.845,	0.900,	0.950,	0.975,	0.990,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR :(2.635,	2.235,	1.810,	1.420,	1.080,	1.000,	0.980,	0.960,	0.890,	0.710,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(25.849,27.265,	27.088,	25.141,	20.715,	18.944,	13.633,	7.967,	4.072,	1.593,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
L37023: GTR=(CommGTR:'Л370 2.30/301';  Dr:0.37;
  IGTR:(0,    0.1,  0.2,  0.3,  0.4,  0.5,  0.6,  0.7,  0.8,  0.9,  0.9501,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR:(2.300,2.160,2.020,1.872,1.712,1.568,1.411,1.266,1.118,0.951,0.838,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(40.333,39.15,37.845,36.54,34.8,32.408,29.363,26.1,22.62,16.808,8.291,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
GT3704: GTR=(CommGTR:'ГТ 370 3.323/114';  Dr:0.37;
  IGTR:(0,0.04375,0.0875,0.13125,0.175,0.21875,0.2625,0.30625,0.35,0.39375,0.4375,0.459375,0.48125,0.503125,0.525,0.546875,0.56875,0.590625,0.6125,0.634375,
              0.65625,0.678125,0.7,0.721875,0.74375,0.765625,0.7875,0.809375,0.83125,0.853125,0.875,0.896875,0.91875,0.940625,0.9625);
  KgtR:(3.3229,3.006543,2.79097,2.6774,2.517,2.3629,2.239,2.11,1.99,1.8745,1.768,1.7046,1.663,1.6048,1.5617,1.518,1.4746,1.435,1.396,1.361,1.32,1.2786,1.241,1.207,1.168,1.115,1.065,1.038,0.98,0.971,0.9553,0.95847,0.9643,0.9694,0.961);
  YLGTR:(15.22162831,15.04930799,15.62370906,15.79602938,16.08322992,16.37043045,16.54275077,16.7725112,16.94483152,17.00227163,17.00227163,17.05971173,16.94483152,
         16.94483,16.887,16.83,16.7725,16.6576,16.60,16.543,16.313,16.198,16.026,15.796,15.6237,15.3365,14.8195,13.786,12.924,11.948,11.029,9.88,8.0416,5.6291,3.159));
W340281: GTR=(CommGTR:'W340, 2.813/124';  Dr:0.34;  // +++
  IGTR :(    0,  0.1,	  0.2,	 0.3,	  0.4,  0.5,	 0.6,	 0.7,  0.8,   0.85, 	0.9,  0.95,  0.97, 0.977,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR :(2.813, 2.552, 2.317, 2.047, 1.797, 1.57, 1.362,1.158,0.974,	0.904, 0.819, 0.692, 0.603,0.573,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(25.377,26.195,26.40,26.605,27.014,27.014,25.991,23.33,18.419,15.349,12.074,8.595, 7.163,6.549, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
W340235: GTR=(CommGTR:'W340, 2.352/200';  Dr:0.34;     // +++
  IGTR:(    0, 0.1,	  0.2,	 0.3,	  0.4,  	0.5,	0.6,	 0.7,  0.8,  0.9, 	0.9501,  0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR:(2.352, 2.172, 2.015, 1.849,	1.687, 1.503, 1.341,1.186,1.029, 0.995, 0.995, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(40.845, 41.52,41.97,42.42, 41.97, 41.29, 39.50, 36.13,31.20, 19.53, 12.12, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
W340239: GTR=(CommGTR:'W340, 2.390/168';  Dr:0.34;    // +++
  IGTR :(   0,  0.1,	  0.2,	 0.3,	  0.4,  	0.5,	0.6,  	 0.7,  0.8,   0.85, 	0.9,  0.92,  0.94,  0.9501,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR :( 2.39, 2.224, 2.053, 1.875,	1.724, 1.55,	1.373,	1.212, 1.038,	0.94,	0.866,	0.832, 0.798,	0.78,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(34.381,35.200,36.018,36.223,35.609,34.995,33.358,30.902, 26.605,22.716, 17.191,15.553,13.916,13.098, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
W340154: GTR=(CommGTR:'W340, 1.540/288';  Dr:0.34;    // +++
  IGTR:(0,	     0.1,	 0.2,	   0.3,	  0.4,	  0.5,	0.6,	 0.7,	  0.8,	 0.85,	0.9,	  0.95,	0.97,	0.978, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR:(1.54,	 1.504,	 1.464,	1.405,	1.359, 1.302,	1.235, 1.156,	1.069,1.015,	0.995,	0.995,0.995,0.995,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(58.939,59.144,59.144,59.349,57.507,54.232,49.730,41.749,	32.13, 26.195,19.237,11.256,7.163,5.526,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
Dana380309: GTR=(CommGTR:'Dana 380 3.09/133';  Dr:0.38;
  IGTR:(0,    0.10,	 0.20,	0.30,	 0.40,	0.50,	  0.60,	 0.70,	 0.80,	0.88,	0.917, 0.951,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  KgtR:(3.09, 2.896, 2.615, 2.27,	 1.93,	1.654,  1.427, 1.229,   1.008,0.788,0.663, 0.55,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(15.660,16.479,17.327,18.204,18.926, 19.306,19.306,19.002, 17.721,9.510,5.238, 2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
W37021: GTR=(CommGTR:'W370 2.104/240';  Dr:0.37;  // ***
  IGTR :(0,	    0.1,	   0.2,	  0.3,	  0.4,	  0.5,	 0.6,	   0.7,	   0.8,	 0.85,	0.9,	 0.92,	 0.938, 0.974, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);//A371 ZF W370 , 2.104/240
  KgtR :(2.104,	1.989,	1.866,	1.742,	1.61,	 1.47,	1.324,	1.174,  1.03,	 0.995, 0.995, 0.995,  0.995, 0.425, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(32.182,32.852,33.389, 33.254,	32.852,31.914,30.036,	26.550,	22.393,18.370,12.470,10.593, 9.118, 3.889, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));
GT350_550: GTR=(CommGTR:'ГТ350 2.86/123';  Dr:0.35;  // ***
  IGTR :(0,	    0.1,	  0.21,	  0.31,   0.41,	 0.51,	0.61,	 0.69,   0.79,	 0.84,	0.89,	 0.92,	 0.94,  0.95,  0.975,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);//A371 ZF W370 , 2.104/240
  KgtR :(2.86,	2.52,	 2.30,   2.02,	 1.80,	 1.58,	1.37,	 1.23,   1.02,	 1.01,  1.01,  1.01,   1.02,  1.0,   0.57,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
  YLGTR:(21.79, 22.31, 22.68,  22.83,	 22.68,  22.09, 21.20, 20.08, 16.73,  14.87, 11.90, 10.41,   8.55,  5.58,  5.21,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));

  //************************************************* Motors *****************************************************

MMZ245c2c: Dizel=(Comm:'ММЗ 245.2S2 90кВт 2200мин-1';
  n:(1200,	1300,	1400,	1500,	1600,	1700,	1800, 1900,	2000,	2100,	2200, 2250,0,0,0);
  M:(  445,	475,	490,	502,	502,	495,	485,	470,	450,	420,	395,	  0, 0,0,0));
MMZ245_16c: Dizel=(Comm:'ММЗ245.16с 90кВт 1800мин-1';
  n:(1000,	1100, 1200,	1300,	1400,	1500,	1600,	1700,	1800, 1850,	0,0,0,0,0);    // 1800 мин-1
  M:( 400,	480,	560,	615,	630,	600,	570,	532,	505,	   0,	0,0,0,0,0));   // 90 кВт
MMZ245c2: Dizel=(Comm:'ММЗ 245.S2 80кВт 2200мин-1';
  n:(1000, 1100, 1200,	1300,	1400,	1500,	1600,	1700,	1800, 1900,	2000,	2100,	2200, 2250,0);
  M:( 300,	316,	330,	341,	344,	347,	 347,	346,	345,	340,	330,	  320, 310, 0,0));
Mmz260_2: Dizel=(Comm:'ММЗ 260.2 95,6 kWt 2100 мин-1';
  n:(1100,1200, 1400, 1500, 1600, 1800, 1900, 2000, 2100,2200,2275,0,0,0,0);
  M:(445,  475,	 500,	 498,  495,  488,	 478,	 470, 455, 435,	0, 0,0,0,0));
Mmz260_1s2: Dizel=(Comm:'ММЗ 260.1s2 158 л.с. 2100 мин-1';
  n:(1000,1100,1200, 1400,1500,1600,1700,1800,1900,2000,2100,2275,0,0,0);
  M:(590, 605,	615,	622, 618, 610, 600,	586,	570,	550,	518, 0,0,0,0));
Mmz260_9: Dizel=(Comm:'ММЗ 260.9 180 л.с. 2100 мин-1';
  n:(1000,1100,1200,1400,1500,1600,1700,1800,1900,2000,2100,2250,0,0,0);
  M:(650, 660,	670,	685,	690,	685,	670,	652,	634,	618,	600,	0,0,0,0));
Mmz260_9S2: Dizel=(Comm:'ММЗ 260.9S2 180 л.с. 2100 мин-1';
  n:(1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2250,0,0);
  M:(680, 700, 725, 755, 775, 780,	770, 740, 710, 670,	635, 600, 10,0,0));
Mmz260_7: Dizel=(Comm:'ММЗ 260.7 180 кВт 2100 мин-1';
  n:(1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2150,0,0);
  M:(700,  775,	835, 880,	925, 960,	960, 945,	915, 890,	862, 835,0,0,0));
Mmz2621s2: Dizel=(Comm:'ММЗ 262.1S2 280 л.с. 2100 мин-1';
  n:(1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2150,0,0);
  M:(910,  960,1010,1060,1120,1170,1160,1135,1080,1035, 985, 937, 0,0,0));
Deutz4ZF: Dizel=(Comm:'Deutz BF 4M1013EC 103,9kw 2200мин-1'; //++++
  n:(1000,1200,1400,1600,1800,1900,2000,2100,2200,2332,0,0,0,0,0);
  M:( 467, 548, 577, 556, 524, 505, 488, 467, 451, 0,  0,  0,0,0,0));
Deutz6: Dizel=(Comm:'Deutz BF6M2012C Tier 2 158 л.с. 2200мин-1';
  n:(1000,	1200,	1300,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2100,	2300,0,0,0);
  M:( 550,	590,	610,	625,	630,	625,	610,	590,	570,	545,	535,	0,   0,0,0));
CumminsQSB45C11030: Dizel=(Comm:'Cummins QSB4.5-C110-30 112 л.с. 82 kW 2200 мин-1';
  n:(800,	900, 1000,	1200,	1400,	1500,	1600,	1800,	2000,	2200, 2220,2250,0,0,0);//
  M:(434,	442,	449,	465,	480,	488,	472,	441,	409,    357, 150,  0,0,0,0));  //

Cummins6B59: Dizel=(Comm:'Cummins 6B5.9 FR90870 Tier 2 173 л.с. 2200 мин-1';
  n:(800,	1000,	1300,	1500,	1600,	1800,	2000,	2200,	2400,0,0,0,0,0,0);//
  M:(514,	542,	786,	740,	721,	668,	629,	560,	0,0,0,0,0,0,0));  //
CumminsQSB67: Dizel=(Comm:'Cummins QSB 6.7 FR94284-EN02 179 л.с. 129 kW 2200 мин-1';
  n:(800,	1000,	1200,	1400,	1500,	1600,	1800,	2000,	2100,2200,0,0,0,0,0);//
  M:(678,	785,	793,	798,	800,	764,	696,	628,	594, 560,0,0,0,0,0));  //

CummC260: Dizel=(Comm:'Cummins 6CTAА8.3-C260 265 л.с. 2200 мин-1';
  n:(1000, 1200, 1400,	1500,	1900,	2100,	2200,	2380,	0, 0,	0, 0,0,0,0);
  M:(  971, 1077, 1100,	1076,	 937,	 887,	 843,    0,	0, 0,	0, 0,0,0,0));
CummQSM11: Dizel=(Comm:'Cummins QSM11 360 л.с. 267 kW 2100 мин-1';
  n:(  800, 1000, 1100,	1300,	1400,	1500,	1700,	1800,	2000, 2100,	2120, 0,0,0,0);
  M:( 1437, 1679, 1830,	1830,	1830,	1803,	1654, 1566,	1342, 1220,	0, 0,0,0,0));
  Perkins1106D: Dizel=(Comm:'Perkins 1106D-E66TA Tier 2 185 л.с. 2200 мин-1';
  n:(800,	1000,	1200,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2200,	2400,0,0,0);
  M:(500,	740,	800,	802,	800,	788,	767,	740,	707,	670,	591,	0,   0,0,0));   // 185 л.с./2200
Yamz236M2: Dizel=(Comm:'ЯМЗ 236М2 180 л.с. 2100 мин-1';
  n:(1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2150,2200,2340);
  M:(610, 630, 645, 660, 667, 659, 651, 642, 632, 622, 612, 602, 550, 300,  10));
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
Iveco182: Dizel=(Comm:'F4HE0684E*D1 Tier 2 182 л.с. 2200 мин-1';
  n:(800,	1000,	1200,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2200,	2400,0,0,0);
  M:(550,	650,	750,	800,	790,	780,	770,	750,	730,	680,	580,	0,   0,0,0));
Iveco152: Dizel=(Comm:'F4GE0684Q*D6 152 HP 2200 мин-1';
  n:(1000,	1200,	1400,	1500,	1600,	1700,	1800,	1900,	2000,	2100,	2200,	2400,0,0,0);
  M:(590,	  585,	582,	578,	575,	572,	570,	550,	535,	508,	485,	0,   0,0,0));
WP6G175E331: Dizel=(Comm:'WP6G175E331 129 kW 175HP 2200 мин-1';
  n:(800,	900,	1000,	1100,	1200,	1300,	1400,	1500,	1600,	1700,	1800,1900, 2000, 2100, 2200);
  M:(681,	708,	727,	745,	749,	751,	751,	751,	751,	721,	681,	642,  616,  589, 563));
WP6G180E331: Dizel=(Comm:'WP6G180E331 133 kW 180HP 2000 мин-1';
  n:(800,	900,	1000,	1100,	1200,	1300,	1400,	1500,	1600,	1700,	1800,1900, 2000, 0, 0);
  M:(621,	679,	734,	809,	844,	859,	859,	843,	788,	743,	702,	663,  634, 0, 0));

  xlDiagonalDown = 5;
  xlDiagonalUp = 6;
  xlEdgeBottom = 9;
  xlEdgeLeft = 7;
  xlEdgeRight = 10;
  xlEdgeTop = 8;
  xlInsideHorizontal = 12;
  xlInsideVertical = 11;
  xlDouble= -4119;
  xlThick= 4;
  // Format Cells
  xlBottom = -4107;
  xlLeft = -4131;
  xlRight = -4152;
  xlTop = -4160;
  // Text Alignment
  xlHAlignCenter = -4108;
  xlVAlignCenter = -4108;
  clxLightCyan = $FFFFCC;
  clxLightGreen = $CCFFCC;
  clxLightYellow = $99FFFF;
  clxLightBrown = $99CCFF;
  clxLightViolet = $FFCCCC;

// ГОСТ 30745-2001 (ИСО 789-9-90) Тракторы сельскохозяйственные. Определение тяговых показателей

Function Interpol1(x:double;XMas,YMas: array of double):double;
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

Function Interpol2(x:double;XMas,YMas: array of double):double;
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
 case GMPWybor.ItemIndex of
      0: GT:= W300;
      1: GT:= GT280;
      2: GT:= GT305;
      3: GT:= GT3208;
      4: GT:= Dana330;
      5: GT:= Lv340266;
      6: GT:= TGD340264;
      7: GT:= GT3504;
      8: GT:= GT3507;
      9: GT:= GT3502512;
     10: GT:= GT35010;
     11: GT:= GT350_550;
     12: GT:= GTPO350212;
     13: GT:= GT3704;
     14: GT:= L37023;
     15: GT:= W340281;
     16: GT:= W340235;
     17: GT:= W340239;
     18: GT:= W340154;
     19: GT:= W37021;
     20: GT:= Dana380309;
                end;

case DiselWybor.ItemIndex of
      0: Diz:=MMZ245c2c;    // ММЗ 245.2S2 2200 мин-1';
      1: Diz:=MMZ245_16c;   // ММЗ 245.16S2 1800 мин-1';
      2: Diz:=MMZ245c2;     // ммЗ 245с2 89кВт  2200 мин-1';
      3: Diz:=Mmz260_2;     // ММЗ 260.2 130 л.с.';
      4: Diz:=Mmz260_1s2;   // ММЗ 260.1s2 158 л.с.';
      5: Diz:=Mmz260_9;     // ММЗ 260.9 180 л.с.';
      6: Diz:=Mmz260_9S2;   //ММЗ 260.9S2 180 л.с. 2100 мин-1';
      7: Diz:=Mmz260_7;     // ММЗ 260.7 180 кВт';
      8: Diz:=Mmz2621s2;    // ММЗ 262.1S2 280 л.с.';
      9: Diz:=Deutz4ZF;     // Deutz BF 4M1013EC 104 kW';
      10: Diz:=Deutz6;       // Deutz BF6M2012C Tier 2 158 л.с.';
     11: Diz:=CumminsQSB45C11030;
     12: Diz:=Cummins6B59;  // Cummins 6B5.9 FR90870 173 л.с.'
     13: Diz:=CumminsQSB67;// Cummins QSB 6.7 FR94284-EN02 179 л.с. 129 kW 2200 мин-1'
     14: Diz:=CummC260;     // Cummins C260'
     15: Diz:=CummQSM11;    // Cummins QSM11 360 л.с. 267 kW 2100 мин-1';
     16: Diz:=Perkins1106D; // Perkins 1106D-E66TA Tier2 185 л.с.';
     17: Diz:=Yamz236M2;    // ЯМЗ 236M2 180 л.с. 2100 мин-1';
     18: Diz:=YAMZ5344;     // ЯМЗ 5344 136 л.с. 2300 мин-1';
     19: Diz:=YAMZ65652;    // ЯМЗ 65652 270 л.с. 2100 мин-1';
     20: Diz:=YAMZ6566;     // ЯМЗ 6566 270 л.с. 1900 мин-1';
     21: Diz:=YAMZ760110;   // ЯМЗ 7601 300 л.с. 1900 мин-1';
     22: Diz:=Iveco152;     // Iveco F4GE0684Q*D6 152 HP @ 2200 rpm';
     23: Diz:=Iveco182;     // Iveco F4HE0684E*D1 Tier 2 182 л.с. 2200 мин-1'
     24: Diz:=WP6G175E331;
     25: Diz:=WP6G180E331;
       end;

      Form2.Edit1.Text:=Komment+' '+GT.CommGTR+' '+Diz.Comm;
           for I := 1 to Nfor+Nrev do begin
         Ikp[i]:=StrToFloat(StringGrid1.Cells[1,i]);
         nu[i] :=StrToFloat(StringGrid1.Cells[2,i]);
          f[i] :=StrToFloat(StringGrid1.Cells[3,i]);
           end;
         Imost :=StrToFloat(StringGrid1.Cells[1,Nfor+Nrev+1]);
         NuMost:=StrToFloat(StringGrid1.Cells[2,Nfor+Nrev+1]);
         IRom  :=StrToFloat(StringGrid1.Cells[1,Nfor+Nrev+2]);
         NuRom :=StrToFloat(StringGrid1.Cells[2,Nfor+Nrev+2]);
         Rk    :=StrToFloat(StringGrid1.Cells[1,Nfor+Nrev+3]);
         Rst   :=StrToFloat(StringGrid1.Cells[2,Nfor+Nrev+3]);
         Ga    :=StrToFloat(StringGrid1.Cells[1,Nfor+Nrev+4]);
         MdR   :=StrToFloat(StringGrid1.Cells[1,Nfor+Nrev+5]);
         Mlost :=StrToFloat(StringGrid1.Cells[2,Nfor+Nrev+5]);
         if (Mlost=0) and (Mdr=0) then Mdr:=90;
       if Mlost<>0 then Mdr:=100;
              end;
     N_Igt:=0; N_Md:=0;
  repeat
   inc(N_Igt);
     until GT.IGTR[N_Igt]=MaxValue(GT.IGTR);
  repeat
   inc(N_Md);
     until Diz.n[N_Md]=MaxValue(Diz.n);
          end;

Procedure GTD_DWS(i_gt:double);
var   i:byte;  K:real;
  begin
 // k:=Interpol1(i_gt,GT.IGTR,GT.YLGTR);
  Mnasos:=9.807e-5*Ro*Interpol1(i_gt,GT.IGTR,GT.YLGTR)*Sqr(n_d/Irom/30*Pi)*Power(GT.Dr,5);
  Ktr:=Interpol1(i_gt,GT.IGTR,GT.KGTR);
  Mtur:=Ktr*Mnasos;
  Md_brt:=Interpol1(n_d,Diz.n,Diz.M);
  Md_net:=Md_brt*MdR/100-Mlost;
            end;

Procedure Sil_Block;  // подбор оборотов ДВС для привода турбины при i_gt
var hs,YL:double; Md_v:boolean; k:integer;
label m;
begin
  hs:=5; Md_v:=false; k:=0;
  n_d:=0.99*MaxValue(Diz.n);
  YL:=Interpol1(i_gt,GT.IGTR,GT.YLGTR);
  Ktr:=Interpol1(i_gt,GT.IGTR,GT.KGTR);
  repeat
 // GTD_DWS(i_gt);
 inc(k);
  Mnasos:=9.807e-5*Ro*YL*Sqr(n_d/Irom/30*Pi)*Power(GT.Dr,5);
  Md_brt:=Interpol1(n_d,Diz.n,Diz.M);
  Md_net:=Md_brt*MdR/100-Mlost;
   if (Mnasos/Irom/NuRom>Md_net) and (Md_v)
      then begin hs:=-hs/2.5; Md_v:=false; end;
   if (Mnasos/Irom/NuRom<Md_net) and (not Md_v)
      then begin hs:=-hs/2.5; Md_v:=true; end;
      n_d:=n_d-hs;
  until abs(hs)<1e-7;
    Mtur:=Ktr*Mnasos;
    Md_net:=Md_brt*MdR/100-Mlost;  // Момент от дизеля с учетом потерь на вспомогательные нуждф
  //  Ndv_net:=Mnasos*n_d/Irom/9.807/716.2;
    Ndv_net:=Md_net/9.807*n_d/716.2;
         end;

Procedure Sil_Block_Din(Pk:double; var Pkrez:double);
var hs,YL:double; Md_v:boolean; k:integer;
label m;
begin
  hs:=5; Md_v:=true; k:=0;    //  n_d:=0.99*MaxValue(Diz.n);
  YL:=Interpol1(i_gt,GT.IGTR,GT.YLGTR);
  Ktr:=Interpol1(i_gt,GT.IGTR,GT.KGTR);
  Mnasos:=9.807e-5*Ro*YL*Sqr(n_d/Irom/30*Pi)*Power(GT.Dr,5);
  Mtur:=Ktr*Mnasos;

       if {(Pk<Mtur*Imost*Ikp[Nper]/Rk*nu[Nper]*NuMost) and }(n_d<MaxValue(Diz.n)) then begin
  repeat
  Md_brt:=Interpol1(n_d,Diz.n,Diz.M);
  Md_net:=Md_brt*MdR/100-Mlost;
  Mnasos:=9.807e-5*Ro*YL*Sqr(n_d/Irom/30*Pi)*Power(GT.Dr,5);
  if (Pk>Mtur*Imost*Ikp[Nper]/Rk*nu[Nper]*NuMost) {and (Mnasos/Irom/NuRom<Md_net)} and Md_v
  then begin hs:=-hs/2.5; Md_v:=false; end;
  if (Pk<Mtur*Imost*Ikp[Nper]/Rk*nu[Nper]*NuMost) and not Md_v
     then begin hs:=-hs/2.5; Md_v:=true; end;
        n_d:=n_d-hs;
   Mnasos:=9.807e-5*Ro*YL*Sqr(n_d/Irom/30*Pi)*Power(GT.Dr,5);
   Mtur:=Ktr*Mnasos;
  until ((abs(hs)<1e-5) or (n_d>=MaxValue(Diz.n)))  // подобран режим для заданного Pk
        end;
  if (Pk>1e-4+Mtur*Imost*Ikp[Nper]/Rk*nu[Nper]*NuMost) and (n_d>=MaxValue(Diz.n))
     then Pkrez:=Mtur*Imost*Ikp[Nper]/Rk*nu[Nper]*NuMost
          else Pkrez:=Pk;
  Md_brt:=Interpol1(n_d,Diz.n,Diz.M);
  Md_net:=Md_brt*MdR/100-Mlost;
  if Md_net>Mnasos/Irom/NuRom then Md_net:=Mnasos/Irom/NuRom; // момент от ДВС для ГМП
   // Dinam=Record  V,S,t,N,A: double;
     Din.N:=(Md_net*100/MdR+Mlost)*n_d*Pi/30*1e-3;// kW мощность, потребляемая ГМП с учетом потерь
  begin
    Md_brt:=Mnasos/Irom/NuRom/Mdr*100+Mlost;
  end;
    Ndv_net:=Md_net/9.807*n_d/716.2; // мощность потребляемая л.с.
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
                                 if i>1 then Ser[i].Title:='igt='+FloatToStr(GT.IGTR[i-2]);
                                end;
  Ser[0].Title:='Md_brt';       Ser[1].Title:='Md_brt расчетный';
  Ser[0].LinePen.Width := 3; Ser[1].LinePen.Width := 3;
  j:=0; n_d:=Diz.n[0]-100;
  q:=false;
  repeat
         n_d:=n_d+100;
       if n_d>=MaxValue(Diz.n) then begin n_d:=MaxValue(Diz.n);  q:=true; end;
      Md_brt:=Interpol1(n_d,Diz.n,Diz.M);
      Form2.Chart1.Series[0].Add(Md_brt,FloatTostr(n_d));
      Form2.Chart1.Series[1].Add(Md_brt*Mdr/100-Mlost,FloatTostr(n_d));
     for I := 2 to N_Igt+2 do begin
     i_gt:=GT.IGTR[i-2]; GTD_DWS(i_gt);
  Form2.Chart1.Series[i].Add(Mnasos/Irom/NuRom,FloatTostr(n_d));// момент насоса приведен к валу ДВС
        end;
        until q;
    end;
end;

procedure TForm2.GrafikBtnClick(Sender: TObject);
begin
 Dann;
  Grafik;
  Form2.Memo1.Lines.Add('Совместная работа ДВС и гидротрансформатора');
  for i:=0 to N_igt do begin
      i_gt:=GT.IGTR[i];
        Sil_Block;
   Form2.Memo1.Lines.Add(Format('igt:%4.2f  nДВС:%4.0f   Md_brt:%5.1f  Mnas:%5.1f  Nnasos kW/л.с.=%6.1f/%6.1f Mtur:%5.1f  η_ГМП:%5.1f %%',
                                [I_gt, n_d, Md_brt, Mnasos, Mnasos*n_d/9550,Mnasos*n_d/9550*1.36, Mtur, Mtur*i_gt/Mnasos*100]));
        end;
           end;

procedure TForm2.OpenDannFileClick(Sender: TObject);
var
s1,s2:double;
FName,St,Prich:AnsiString;
DataFile:TextFile;
Komm_Str:TList;
i,j,k,i1,i2:integer;

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
        for I := 1 to Nfor do begin
    readln(DataFile,S1,s2,f[i]);
  StringGrid1.Cells[0,i]:='Передача '+IntTostr(i);
  StringGrid1.Cells[1,i]:=FloatToStr(s1);
  StringGrid1.Cells[2,i]:=FloatToStr(s2);
  StringGrid1.Cells[3,i]:=FloatToStr(f[i]);
      end;
  for I := 1 to Nrev do begin
    readln(DataFile,S1,s2,f[Nfor+i]);
  StringGrid1.Cells[0,Nfor+i]:='Передача ЗХ'+IntTostr(i);
  StringGrid1.Cells[1,Nfor+i]:=FloatToStr(s1);
  StringGrid1.Cells[2,Nfor+i]:=FloatToStr(s2);
  StringGrid1.Cells[3,Nfor+i]:=FloatToStr(f[Nfor+i]);
    end;
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
    readln(DataFile,S1,S2);
  StringGrid1.Cells[0,i]:='Rк,Rст колеса ,м';
  StringGrid1.Cells[1,i]:=FloatToStr(s1);
  StringGrid1.Cells[2,i]:=FloatToStr(s2);
    inc(i);
    readln(DataFile,Ga);
  StringGrid1.Cells[0,i]:='Масса эксплуатационная,кг';
  StringGrid1.Cells[1,i]:=FloatToStr(Ga);
    inc(i);
 StringGrid1.Cells[0,i]:='Загрузка ДВС% или момент потерь Нм';
 StringGrid1.Cells[1,i]:=FloatToStr(Mdr);
 StringGrid1.Cells[2,i]:=FloatToStr(Mlost);
    readln(DataFile,Komment);
    Form2.Edit1.Text:=Komment;
    readln(DataFile,i1,i2);
      DiselWybor.ItemIndex:=i1;
      GMPWybor.ItemIndex:=i2;
      CloseFile(DataFile);
    finally
       end;
       end
     else
    begin
         ShowMessage('Указанный файл не существует');
           Exit;
         end; // Free();
 Dann;
  Grafik;
 end;

Procedure R_r(Nper:integer);
begin
v1:=3.6*Rk*n_d*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
Rkin:=Rk;  Rsil:=Rk;
if {(V1>2)and }(V1<10) then Rkin:=Rst-(10-V1)*(Rst-Rk)/10 else Rkin:=Rst;
             if V1<10 then Rsil:=Rst-(10-V1)*(Rst-Rk)/10{/0.993}
        else if V1>=10 then Rsil:=Rst;
            end;

procedure TForm2.V_Pk_GrafikClick(Sender: TObject);
begin
Dann;
with RezTR do begin
for I := 0 to 34 do begin RezTR.Mturb[i]:=0; RezTR.nturb[i]:=0; end;
for I := 0 to 34 do begin
 I_gt:=GT.IGTR[i];
 Sil_Block;
 Num:=i;
 RezTR.nturb[i]:=n_d*I_gt/Irom;
 RezTR.Mturb[i]:=Mtur;
 if I_gt=MaxValue(GT.IGTR) then
 begin OutTR_F; exit;
 end;
end;
    end;
   end;

procedure TForm2.Button1Click(Sender: TObject);
begin
Dann;
with RezTR do begin
for I := 0 to 34 do begin RezTR.Mturb[i]:=0; RezTR.nturb[i]:=0; end;
for I := 0 to 34 do begin
 I_gt:=GT.IGTR[i];
 Sil_Block;
 Num:=i;
 RezTR.nturb[i]:=n_d*I_gt/Irom;
 RezTR.Mturb[i]:=Mtur;
 if I_gt=MaxValue(GT.IGTR) then begin
                    OutTR_R; exit;
                     end;
            end;
    end;
   end;

Procedure Ex_Out1;
var Buk: char;
    i,Nrow: integer;
    Pfile: file;
    St,FN: ansistring;
begin
  j:=1;
  ExcelSht.PageSetup.BottomMargin := 45;
  ExcelSht.PageSetup.RightFooter := Komment+','+Diz.Comm+','+GT.CommGTR+'. Страница &P &С';
  ExcelSht.Range['A' + IntToStr(j)] :='i моста';
  ExcelSht.Range['B' + IntToStr(j)] :='η моста';
  ExcelSht.Range['C' + IntToStr(j)] :='i РОМа';
  ExcelSht.Range['D' + IntToStr(j)] :='η РОМа';
  ExcelSht.Range['E' + IntToStr(j)] :='Rk,м';
  ExcelSht.Range['F' + IntToStr(j)] :='Rst,м';
  ExcelSht.Range['G' + IntToStr(j)] :='Масса,кг';
  ExcelSht.Range['H' + IntToStr(j)] :=Komment+' '+GT.CommGTR;
  ExcelSht.range['H' + IntToStr(j),'N'+IntToStr(j+1)].merge;
  ExcelSht.range['H' + IntToStr(j),'N'+IntToStr(j+1)].WrapText:=True;
  ExcelSht.Range['H' + IntToStr(j)].VerticalAlignment:= xlHAlignCenter;
  ExcelSht.Range['H1'].Font.size:=13;
       inc(j);
  ExcelSht.Range['A' + IntToStr(j)] :=imost;
  ExcelSht.Range['B' + IntToStr(j)] :=Numost;
  ExcelSht.Range['C' + IntToStr(j)] :=irom;
  ExcelSht.Range['D' + IntToStr(j)] :=Nurom;
  ExcelSht.Range['E' + IntToStr(j)] :=Rk;
  ExcelSht.Range['F' + IntToStr(j)] :=Rst;
  ExcelSht.Range['G' + IntToStr(j)] :=Ga;

 ExcelSht.Range['D4','N4'].NumberFormat := '###0.00';
 ExcelSht.Range['B5','N'+IntToStr(N_Md+5)].NumberFormat := '###0.0'; //Вещественные числа с 1 знаками после запятой
 ExcelSht.Range['A1','N3'].Font.Bold:= True;       // атрибут полужирности - OK!
 ExcelSht.Range['A4']   :='n ДВС м-1';
 ExcelSht.Range['B4']   :='М ДВС Нм';
 ExcelSht.Range['C4']   :='N ДВС л.с/кВт';
 ExcelSht.Range['A3']   :=Diz.Comm;
 ExcelSht.range['A3:C3'].merge;
  for j:=5 to N_Md+5 do begin// repeat
   n_d:=Diz.n[j-5]; //n_d:=1000;
   Md_brt:=Diz.M[j-5];
  ExcelSht.Range['A' + IntToStr(j)] :=Format('%5.1f',[n_d]);
  ExcelSht.Range['B' + IntToStr(j)] :=Md_brt;
  ExcelSht.Range['C' + IntToStr(j)] :=Format('%5.1f /%5.1f',[Md_brt/9.807*n_d/716.2,Md_brt/9.807*n_d/716.2/1.36]);
      end;
  ExcelSht.Range['A3','C'+ IntToStr(j-1)].borders.linestyle:=7;
  St:='. Момент и мощность ДВС указаны по внешней (регуляторной) ветви';
  if MLost=0 then ExcelSht.Range['A' + IntToStr(j)] :=Format('Предел загрузки ДВС=%5.1f',[Mdr])+'%'+St
             else ExcelSht.Range['A' + IntToStr(j)] :=Format('Момент потерь ДВС=%5.1f Нм',[Mlost])+St;
  ExcelSht.Range['A' + IntToStr(j),'L' + IntToStr(j)].merge;
     j:=j-N_Md-3;   Nrow:=j;
 ExcelSht.Range['E'+ IntToStr(j)]   :='Параметры коробки передач';
 ExcelSht.range['E'+ IntToStr(j),'K'+ IntToStr(j)].merge;
    inc(j);
 ExcelSht.Range['E'+ IntToStr(j)]   :='N';
 ExcelSht.Range['F'+ IntToStr(j)]   :='i КП for';
 ExcelSht.Range['G'+ IntToStr(j)]   :='η КП for';
 ExcelSht.Range['H'+ IntToStr(j)]   :='f for';
 ExcelSht.Range['I'+ IntToStr(j)]   :='i КП rev';
 ExcelSht.Range['J'+ IntToStr(j)]   :='η КП rev';
 ExcelSht.Range['K'+ IntToStr(j)]   :='f rev';
  j0:=1;
 while (j0<=Nfor) do begin
  ExcelSht.Range['E' + IntToStr(j+j0)] :=j0;
  ExcelSht.Range['F' + IntToStr(j+j0)] :=Ikp[j0];
  ExcelSht.Range['G' + IntToStr(j+j0)] :=Nu[j0];
  ExcelSht.Range['H' + IntToStr(j+j0)] :=f[j0];
     if j0<=Nrev then begin
    ExcelSht.Range['I' + IntToStr(j+j0)] :=Ikp[j0+Nfor];
    ExcelSht.Range['J' + IntToStr(j+j0)] :=Nu[j0+Nfor];
    ExcelSht.Range['K' + IntToStr(j+j0)] :=f[j0+Nfor];
       end;
       inc(j0);
    end;
  ExcelSht.Range['E' + IntToStr(Nrow),'K'+ IntToStr(j+Nfor)].borders.linestyle:=7;
  ExcelSht.Range['E' + IntToStr(Nrow),'E' +IntToStr(j+Nfor)].NumberFormat := '###0.';
  ExcelSht.Range['F' + IntToStr(Nrow),'K' +IntToStr(j+Nfor)].NumberFormat := '###0.000';
   j:=Nrow+N_Md+3;
         inc(j);
  ExcelSht.Range['A'+IntToStr(j)]:='n ДВС';
  ExcelSht.range['A'+IntToStr(j),'A'+IntToStr(j+1)].merge;
     inc(j);
 for j0 := 0 to N_Md do ExcelSht.Range['A'+IntToStr(j+j0+1)]:=Diz.n[j0];
     i:=0; Buk:='A';
     I_gt:=0;
     repeat    Buk:=Succ(Buk);  // i
     ExcelSht.Range[Buk+IntToStr(j)]:=I_gt;
                     for j0 := 0 to N_Md do  begin
                     n_d:=Diz.n[j0];
                     GTD_DWS(I_gt);
                     ExcelSht.Range[Buk+IntToStr(j+j0+1)]:=Mnasos;
                     end;
        n_d:=1000*Irom;  GTD_DWS(I_Gt);
                     ExcelSht.Range[Buk+IntToStr(j+j0+1)]:=Mnasos;
                     ExcelSht.Range[Buk+IntToStr(j+j0+2)]:=Format('%5.3f',[Interpol2(I_gt,GT.IGTR,GT.KGTR)]);
                     ExcelSht.Range[Buk+IntToStr(j+j0+3)]:=Format('%5.3f',[100*I_gt*Interpol2(I_gt,GT.IGTR,GT.KGTR)]);
                     if I_gt<0.7 then I_Gt:=I_gt+0.1 else I_Gt:=I_gt+0.05;
     until (I_gt>=MaxValue(GT.IGTR)+0.05) or (I_gt>=1);

      ExcelSht.Range['A' + IntToStr(j-1),  Buk+ IntToStr(j+N_Md+4)].borders.linestyle:=7;
      ExcelSht.Range['B' + IntToStr(j+1),Buk +IntToStr(j+N_Md+2)].NumberFormat := '###0.0';
      ExcelSht.Range['B' + IntToStr(j+N_Md+4),Buk +IntToStr(j+N_Md+4)].NumberFormat := '###0.00';
  ExcelSht.Range['B'+IntToStr(j-1)]:='Момент насоса [Нм] для гидротрансформатора '+GT.CommGTR+' при igt';
  ExcelSht.range['B'+IntToStr(j-1),Buk+ IntToStr(j-1)].merge;
     j:=j+j0+1;
 ExcelSht.Range['A' + IntToStr(j)]:='n=1000';
     inc(j);
 ExcelSht.Range['A' + IntToStr(j)]:='Kгт';
  inc(j);
 ExcelSht.Range['A' + IntToStr(j)]:='η гт,%';
  inc(j);
  ExcelSht.Range['A1','P400'].HorizontalAlignment:= xlHAlignCenter;
  ExcelSht.PageSetup.PrintTitleRows:='$'+IntToStr(j+2)+':$'+IntToStr(j+2);
 // ExcelSht.Range['A2:C2'].HorizontalAlignment:= xlLeft;
       end;

Procedure Ex_Out2(i:integer);
  var bu:char; KPDt:double;
  begin
         inc(j);
  if (1-Pk[1]/(Ga*9.807e-3*(FiKrPr+f[i])))<0 then Bux:=1 else
  Bux:=Delta_lim*(1-Power((1-Pk[1]/(Ga*9.807e-3*(FiKrPr+f[i]))),KBux));
     if Bux<0 then Bux:=0;
  ExcelSht.Range['A' + IntToStr(j)] :=Format('%5.2f/%5.2f',[V1,V1*(1-Bux)]);
  ExcelSht.Range['B' + IntToStr(j)] :=Format('%5.1f', [Pk[1]]);
  ExcelSht.Range['C' + IntToStr(j)] :=i_gt;
  ExcelSht.Range['D' + IntToStr(j)] :=n_d;      Bu:='E';
if form2.CheckBox1.Checked then begin ExcelSht.Range[Bu + IntToStr(j)] :=Mnasos; Bu:=succ(Bu); end;
if form2.CheckBox2.Checked then begin ExcelSht.Range[Bu + IntToStr(j)] :=Md_brt; Bu:=succ(Bu); end;
if form2.CheckBox3.Checked then begin ExcelSht.Range[Bu + IntToStr(j)] :=n_d/Irom*i_gt; Bu:=succ(Bu); end;
if form2.CheckBox4.Checked then begin ExcelSht.Range[Bu + IntToStr(j)] :=Mtur; Bu:=succ(Bu); end;
if form2.CheckBox5.Checked then begin ExcelSht.Range[Bu + IntToStr(j)] :=Mtur*n_d/Irom*I_gt/1000*Pi/30; Bu:=succ(Bu); end;
  ExcelSht.Range[Bu + IntToStr(j)] :=Md_brt*1e-3* n_d *Pi/30*1.36;   Bu:=succ(Bu);
  ExcelSht.Range[Bu + IntToStr(j)] :=Mtur * i_gt/Mnasos*100;{кпд ГТ} Bu:=succ(Bu);
  if Form2.RadioGroup1.ItemIndex=0 then begin
  ExcelSht.Range[Bu + IntToStr(j)] :=Bux*100;                        Bu:=succ(Bu);
  KPDt:=((1-Bux)*v1*(Pk[1]/9.807e-3-Ga*f[i])/270)/Ndv_net;
  if (KPDt<0) or(Pk[1]<1e-4) then KPDt:=0;
  if KPDt>0.5 then ExcelSht.Range[succ(Bu) + IntToStr(j)].Interior.Color:=clxLightGreen;
  ExcelSht.Range[Bu + IntToStr(j)] :=100*KPDt;
        end;
            end;

Procedure Ex_Zagol_Pered;
var buk:char;
begin
  ExcelSht.Range['A' + IntToStr(j),'N'+IntToStr(j)].Font.Bold:= True;
  ExcelSht.Range['B' + IntToStr(j)] :='Pk,kH';
  ExcelSht.Range['C' + IntToStr(j)] :='Iгт';
  ExcelSht.Range['A' + IntToStr(j)] :='V/Vбук.км/ч';
  ExcelSht.Range['D' + IntToStr(j)] :='n ДВС';
  Buk:='E';
if form2.CheckBox1.Checked then begin ExcelSht.Range[Buk + IntToStr(j)] :='Mнасоса'; Buk:=succ(Buk); end;
if form2.CheckBox2.Checked then begin ExcelSht.Range[Buk + IntToStr(j)] :='Mдв Нм';Buk:=succ(Buk); end;
if form2.CheckBox3.Checked then begin ExcelSht.Range[Buk + IntToStr(j)] :='n турб.';Buk:=succ(Buk); end;
if form2.CheckBox4.Checked then begin ExcelSht.Range[Buk + IntToStr(j)] :='М турб.';Buk:=succ(Buk); end;
if form2.CheckBox5.Checked then begin ExcelSht.Range[Buk + IntToStr(j)] :='Ngt,kw';Buk:=succ(Buk); end;
   ExcelSht.Range[Buk + IntToStr(j)] :='Nдв л.с.'; Buk:=succ(Buk);
   ExcelSht.Range[Buk + IntToStr(j)] :='η ГТ%';    Buk:=succ(Buk);
  if Form2.RadioGroup1.ItemIndex=0 then begin
  ExcelSht.Range[Buk + IntToStr(j)] :='Букс.%';    Buk:=succ(Buk);
  ExcelSht.Range[Buk + IntToStr(j)] :='η тяг.%';
               end;
                     end;

function CheckExcelRun: boolean;
begin
  try
    ExcelApp:=GetActiveOleObject(ExcelApp);
    Result:=True;
  except
    Result:=false;
  end;
end;

procedure TForm2.Igt_ShagClick(Sender: TObject);   // расчет с шагом по I_gt
Var
i,k: integer;
Pt,dI_gt:double;
DataRange: OLEVariant;
Cellname:string;
Tim: TDateTime;
Pt_bolse:boolean;
begin
Dann;
tim:=Now;  j:=0;
 try
 if not CheckExcelRun then ExcelApp := CreateOleObject('Excel.Application');
ExcelApp.Application.EnableEvents := false;
ExcelApp.Visible := False;
ExcelDoc := ExcelApp.Workbooks.Add;{('GMP120_6x3_'+Form3.Edit3.Text)}// Добавляем документ на основе шаблона
ExcelSht := ExcelDoc.WorkSheets.Add;        // Добавляем страницу в документ
ExcelSht.PageSetup.Orientation := 2;        //Ориентация страницы (1 – книжная, 2 – альбомная).
Ex_Out1;
  for k := 1 to Nfor+Nrev do begin
    Nper:=k;
     inc(j);
 if k<=Nfor then ExcelSht.Range['A' + IntToStr(j),'M' + IntToStr(j)].Interior.Color:= clxLightYellow
            else ExcelSht.Range['A' + IntToStr(j),'M' + IntToStr(j)].Interior.Color:= clxLightBrown;
      if k<=Nfor then ExcelSht.Range['A' + IntToStr(j)] :=IntTostr(k)+'-я пер.'
                 else ExcelSht.Range['A' + IntToStr(j)] :=IntTostr(k-Nfor)+'-я rev';
    ExcelSht.Range['B' + IntToStr(j)] :=Ikp[k];
    ExcelSht.Range['C' + IntToStr(j)] :=Format('η=%5.3f ',[nu[k]]);
    ExcelSht.Range['D' + IntToStr(j)] :=Format('f=%5.3f ',[f[k]]);
      inc(j);  j0:=j;
    Ex_Zagol_Pered; I_gt:=0;   dI_gt:=0.1; Pt_Bolse:=false;
    repeat //for I := 0 to N_Igt do begin
        // i_gt:=GT.IGTR[i];
         Sil_Block;
         v1:=3.6*Rk  *n_d/Irom*i_gt/30*pi/Imost/Ikp[Nper];
         R_r(Nper);
         v1:=3.6*Rkin*n_d/Irom*i_gt/30*pi/Imost/Ikp[Nper];
         Pk[1]:=Mtur*Imost*Ikp[Nper]/Rsil*1e-3*nu[Nper]*NuMost; //=======================================
 {  Fimax=0.7; kfi=-8.48; // стерня зерновых на суглинке - БНТУ
  PkBNTU[n]:=Fimax*(1-Exp(kfi*Delta));
//Fimax=0.6; kfi=-7.69 // стерня зерновых на супеси
//Fimax=0.55; kfi=-7.01 // поле, подготовленное под посев на суглинке и супеси}
    Ex_Out2(k);
      //  end;
      if I_gt<0.7 then I_Gt:=I_gt+0.1 else I_Gt:=I_gt+0.05;
    until (I_gt>=MaxValue(GT.IGTR)+0.05) or (I_gt=1);
         ExcelSht.Range['D'+IntToStr(j0),'P'+IntToStr(j)].NumberFormat := '###0.0';
         ExcelSht.Range['C'+IntToStr(j0),'C'+IntToStr(j)].NumberFormat := '###0.000';
            end;
     ExcelSht.Range['A1:P200'].Columns.AutoFit; // Автоматический подбор ширины
   Form2.Memo1.Lines.Add('Расчет выполнен '+DateToStr(Now)+' за '+TimeToStr(Now-Tim)+'ч/мин/с');
      finally
  if not VarIsEmpty(ExcelApp) then ExcelApp.Visible := True;
         // ExcelApp := UnAssigned;
         end;
{ if VarIsEmpty(Excel) = false then
  begin
    Excel.Quit;
    Excel := 0;
end; }
try
 //   if ExcelSht.Visible then ExcelSht.Visible:=false;
    ExcelSht.Quit;
    ExcelSht:=Unassigned;
  except
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

procedure TForm2.Button2Click(Sender: TObject);
begin
 if VarIsEmpty(ExcelApp) = false then
  begin              //завершаем процесс Excel.exe
    ExcelApp.Quit;
    ExcelApp := 0;
end;
end;


procedure TForm2.Button3Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TForm2.T_DinamClick(Sender: TObject);
var
i,k,I_strt,I_en,I_razg,Iper: integer;
Pt,h_s,Pkfin,t,s,Gruz:double;
A,Uskor:array[1..12]of double;
DataRange: OLEVariant;
Cellname:string;
Pt_bolse:boolean;
begin
   Din.V:=0;
    Memo1.Lines.Clear;
       Dann;
       Gruz:=StrToFloat(Edit3.Text);
       I_strt:=StrToInt(I_start.Text);  // с какой передачи разгон
       I_en:=StrToInt(I_end.Text);
       I_razg:=1+I_en-I_strt;
      //  if maxvalue(Ikp)<I_en then I_en:=1+round(maxvalue(Ikp));
       for I := 4 to 12 do Uskor[I]:=0.8;
                              Uskor[I_strt]  :=StrToFloat(Usk_strt.Text);
       if I_en>I_strt   then  Uskor[I_strt+1]:=StrToFloat(Usk_p1.Text);
       if I_en>I_strt+1 then  Uskor[I_strt+2]:=StrToFloat(Usk_p2.Text);
       if I_en>I_strt+2 then  Uskor[I_strt+3]:=StrToFloat(Usk_p3.Text);
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       Nper:=I_strt;    t:=0;  s:=0;
       repeat
       Pk[1]:=Uskor[Nper]*(Ga+Gruz);  // [H]

    Memo1.Lines.Add('Разгон на '+IntToStr(Nper)+'-й передаче  с желаемым ускорением '+FloatToStr(Uskor[Nper])+ ' м/с2');
        //  n_d:=1600;
     if Nper=I_strt then begin
     i_gt:=0;  V1:=0; Din.Epolez:=0; Din.Esumm:=0;  // Энергия полезная и затраченная кДж
                          end
      else i_gt:=0.45;
       repeat
          V1:=Din.V;
          i_gt:=i_gt+0.01;
          Sil_Block;
            Pk[1]:=Mtur*Imost*Ikp[Nper]/Rk*nu[Nper]*NuMost;
                 if Pk[1]<=Uskor[Nper]*(Ga+Gruz)
                 then Din.a:=Pk[1]/(Ga+Gruz)
           else begin
          Sil_Block_Din(Uskor[Nper]*(Ga+Gruz),Pkfin); // Nd_net, Mnasos
            Pk[1]:=Pkfin;
                     end;
         Pk[1]:=Mtur*Imost*Ikp[Nper]/Rk*nu[Nper]*NuMost;
          Din.a:=Pk[1]/(Ga+Gruz);
          if Din.a=0 then Din.a:=1e-3;
         Din.V:=Rk*(Pi*n_d/30)*i_gt/Imost/Ikp[Nper]/Irom;  // м/s
          Din.t:=(Din.V-V1)/Din.A;      // dt на шаге
          t:=t+Din.t;
          Din.S:=(V1+Din.V)/2*Din.t;
          Din.Epolez:=Din.Epolez+Din.S*Pk[1]*1e-3; // кДж работа на колесах
          Din.Esumm:=Din.Esumm+Md_brt*n_d*Pi/30*Din.t/1000;
          S:=S+Din.S;
      if frac(i_gt*25)<1e-3 then
      Memo1.Lines.Add(' ' +Format('%10.2f с %14.2f м %9.2f %9.2f км/ч %9.2f м/с2 %10.0f %11.4f',[t,s,I_gt, Din.V*3.6, Din.A, n_d, Din.Epolez/Din.Esumm]));
     //  v1:=MaxValue(GT.IGTR);
       until (i_gt>=MaxValue(GT.IGTR)) or ((I_gt>=MaxValue(GT.IGTR)-0.01{0.95}) and (Nper<I_en));

        //  R_r(Nper);
       //   Pk[1]:=Mtur*Imost*Ikp[Nper]/Rsil*1e-3*nu[Nper]*NuMost;
//        GTD_DWS(i_gt);   //************************** Dinami
//        v1:=3.6*Rkin*n_d*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
//        Ndv_net:=Mnasos*n_d/Irom/9.807/716.2/Nurom;
//        Pk[1]:=Mtur*Imost*Ikp[Nper]/Rsil*1e-3*nu[Nper]*NuMost;
       //  Pfin:=5000*(ceil(0.24*Pk[1])div 5);
       //  if Pfin<5000 then Pfin:=5000;
//            if Mnasos=0 then Mnasos:=1e-6;
//            if n_d*I_gt<5000 then Ex_Out2(i);
//       Pt:=100000-i*10000;
      // Pt:=Pfin*4;
//        if i>Nfor then Pt:=90000-(i-Nfor)*10000;
//              repeat h_s:=0.01;               Pt_bolse:=true;
//                     n_d:=0.979*Diz.n[N_md];  zz:=0;

  //    until (I_gt>MaxValue(GT.IGTR)-0.03) or(Pt<3000);//(Pt<Pfin) ;
             inc(Nper);
             until Nper>I_en;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
 StringGrid1.ColCount:=4;
 StringGrid1.ColWidths[0]:=210;
 StringGrid1.ColWidths[1]:=50;
 StringGrid1.ColWidths[2]:=50;
 StringGrid1.ColWidths[3]:=50;
 StringGrid1.Width:=360;
 StringGrid1.Cells[0,0]:='Параметры';
 StringGrid1.Cells[3,0]:='f_i';
    end;

procedure TForm2.Pk_ShagClick(Sender: TObject);
Var
i,k,zz: integer;
Pt,h_s,Pfin:double;
DataRange: OLEVariant;
Cellname:string;
Tim: TDateTime;
Pt_bolse:boolean;
    begin
Dann;
tim:=Now;   j:=0;
 try
if not CheckExcelRun then ExcelApp := CreateOleObject('Excel.Application');
ExcelApp.Application.EnableEvents := false;
ExcelApp.Visible := False;                                            // Временно скрываем Excel
ExcelDoc := ExcelApp.Workbooks.Add{('GMP120_6x3_'+Form3.Edit3.Text)}; // Добавляем документ на основе шаблона
ExcelSht := ExcelDoc.WorkSheets.Add;                                  // Добавляем страницу в документ
ExcelSht.PageSetup.Orientation := 2;                                  //Ориентация страницы (1 – книжная, 2 – альбомная).
  Ex_Out1;
  for i := 1 to Nfor+Nrev do begin
    Nper:=i;  j:=j+1;  j0:=j;   zz:=0;
 if i<=Nfor then ExcelSht.Range['A' + IntToStr(j),'N' + IntToStr(j)].Interior.Color:= clxLightYellow
            else ExcelSht.Range['A' + IntToStr(j),'N' + IntToStr(j)].Interior.Color:= clxLightViolet;
  if i<=Nfor then
  ExcelSht.Range['A' + IntToStr(j)] :=IntTostr(i)+'-я пер.'
  else
  ExcelSht.Range['A' + IntToStr(j)] :=IntTostr(i-Nfor)+'-я rev';
  ExcelSht.Range['B' + IntToStr(j)] :='i='+Format(' %5.3f',[Ikp[i]]);
  ExcelSht.Range['C' + IntToStr(j)] :=Format('η=%5.3f ',[nu[i]]);
  ExcelSht.Range['D' + IntToStr(j)] :=Format('f=%5.3f ',[f[i]]);
    inc(j);
     Ex_Zagol_Pered;
          n_d:=Diz.n[N_md-1];
          i_gt:=0;  V1:=0;
          Sil_Block;
          R_r(Nper);
          GTD_DWS(i_gt);
        v1:=3.6*Rkin*n_d*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
        Ndv_net:=Mnasos*n_d/Irom/9.807/716.2/Nurom;
        Pk[1]:=Mtur*Imost*Ikp[Nper]/Rsil*1e-3*nu[Nper]*NuMost;
       //  Pfin:=5000*(ceil(0.24*Pk[1])div 5);
       //  if Pfin<5000 then Pfin:=5000;
            if Mnasos=0 then Mnasos:=1e-6;
            if n_d*I_gt<5000 then Ex_Out2(i);
       Pt:=100000-i*10000;
      // Pt:=Pfin*4;
        if i>Nfor then Pt:=90000-(i-Nfor)*10000;
              repeat h_s:=0.01;               Pt_bolse:=true;
                     n_d:=0.979*Diz.n[N_md];  zz:=0;
            repeat
         Sil_Block;
          R_r(Nper);
         GTD_DWS(i_gt);
        v1:=3.6*Rkin*n_d*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
        Ndv_net:=Mnasos*n_d/Irom/9.807/716.2/Nurom;
        Pk[1]:=Mtur*Imost*Ikp[Nper]/Rsil*1e-3*nu[Nper]*NuMost;
            if Mnasos=0 then Mnasos:=1e-6;
    if (1e3*Pk[1]>Pt) and (not Pt_bolse)
      then begin h_s:=-h_s/1.5; Pt_bolse:=true; end;
   if (1e3*Pk[1]<Pt) and (Pt_bolse)
      then begin h_s:=-h_s/1.5; Pt_bolse:=false; end;
      I_gt:=I_gt+h_s;  inc(zz)
        until (abs(h_s)<1e-5) or (zz>200);
       if (I_gt>0)and(I_gt<1)and(V1>-1e-3) then Ex_Out2(i);
         if Pt>10000 then Pt:=Pt-5000 else Pt:=Pt-2500;
      until (I_gt>MaxValue(GT.IGTR)-0.03) or(Pt<3000);//(Pt<Pfin) ;
     ExcelSht.Range['D'+IntToStr(j0),'N'+IntToStr(j)].NumberFormat := '###0.0';
     ExcelSht.Range['C'+IntToStr(j0),'C'+IntToStr(j)].NumberFormat := '###0.000';
   end;
     ExcelSht.Range['A1:E100'].Columns.AutoFit; // Автоматический подбор ширины
     ExcelSht.Range['I1:o100'].Columns.AutoFit; // Автоматический подбор ширины
     ExcelSht.Range['A1:o2'].HorizontalAlignment := xlHAlignCenter;
        Form2.Memo1.Lines.Add('Расчет выполнен '+DateToStr(Now)+' за '+TimeToStr(Now-Tim)+'ч/мин/с');
      finally
  if not VarIsEmpty(ExcelApp) then ExcelApp.Visible := True;
          ExcelApp := UnAssigned;
              end;
      end;
end.

(* procedure HookJi(Pras:double);
 label 0,1,2,3,4,5,6,7;
 var j:integer;
  procedure calculate; // Процедура,вычисляющая функцию
 var
  i,k: integer;
 begin
  Z:=0;
   i_gt:=x[1];
   n_d  :=x[2];
   V1:=3.6*Rkin*n_d/Irom*i_gt/30*pi/Imost/Ikp[Nper];
   R_r(Nper);
   Mk[1]:=Pras*Rsil;
   Mr:=Mk[1]/Imost/Ikp[Nper]/nu[Nper]/NuMost;
      GTD_DWS(i_gt);
     // R_r(Nper);
    v1:=3.6*Rk*n_d/Irom*i_gt/30*pi/Imost/Ikp[Nper];  // км/ч  +++
    z:=1e3*Sqr(Mtur-Mr);                               //+1*Abs(n_d-MaxValue(Diz.n))/v1;
    if (Md_brt*MdR/100-Mlost)<=Mnasos/Irom/NuRom then z:=z+5e3*Sqr(Mnasos/Irom/NuRom-Md_net)/v1;
            inc(fe);
         end;

begin
     n:=2;        // число переменных
     x[1]:=0.85;
     x[2]:=0.93*MaxValue(Diz.n);  // начальные точки x1,...xN'
     h:=0.0015;    // длина шага
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
   if k<1e-13 then goto 7; //Если поиск не закончен, произвести новое исследование вокруг новой базисной точки
      j:=1; goto 0;
// Поиск по образцу
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
                (*    i_gt:=p[1]; n_d:=p[2];
                    GTD_DWS(i_gt);
                    R_r(Nper);
        v1:=3.6*Rkin*n_d*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
        Ndv_net:=Mnasos*n_d/Irom/9.807/716.2/Nurom;  if Mnasos=0 then Mnasos:=1e-6;
        Pk[1]:=Mtur*Imost*Ikp[Nper]/Rsil*1e-3*nu[Nper]*NuMost;
// Form3.Memo1.Lines.Add(Format('Шаг параметров = %10.8e', [H_s[1]]));
                        exit;
              end;
           end;


Function Bux2:double;
const
c=0.0333;
d=1.377;
s=2;
var fi: double;
begin
  fi:=Pk[1]*1000/(Ga*9.807);
  Bux2:=C*Fi/(1-d*Power(Fi,s));
  if Bux2>0.7 then Bux2:=0.7;
  end;
{Sheet.Range['A2:B3'].WrapText := True; // Перенос текста
Sheet.Range['A2:B3'].Font.Size:=10;  // Размер шрифта
Sheet.Range['A2:B3'].Font.Name := 'Times New Roman'; // Шрифт
Sheet.Range['A2:B3'].Font.Bold:=True; //Стиль шрифта (Жирный)
Sheet.Range['A2:B3'].Interior.Color := 8421376; // Цвет обводки ячейки
Sheet.Range['A2:B3'].Font.Color:=clWhite; // Цвет текста в ячейке
Sheet.Range['A2:B3'].borders.linestyle:=7;  // Стиль линий обводки
Sheet.Range['A2:B3'].borders.color:=clBlack;  // Цвет линий обводки
Sheet.Range['A1:B10'].Columns.AutoFit; // Автоматический подбор ширины
Sheet.Columns[1].ColumnWidth:=10; //Ширина 1го столбца
Sheet.Rows[1].RowHieght := 5; //Высота 1ой строки}
  // ExcelSht.Range['A' + IntToStr(j),'N' + IntToStr(j)]{UsedRange}.Borders[xlEdgeBottom].LineStyle:=xlDouble;
   // ExcelSht.Range['A' + IntToStr(j),'N' + IntToStr(j)].Borders[xlEdgeBottom].Weight:=xlThick;
   // Borders[xlEdgeTop].LineStyle:=xlDouble;
   // Borders[xlEdgeLeft].LineStyle:=xlDouble;
   // Borders[xlEdgeRight].LineStyle:=xlDouble;
   // ExcelSht.Range['A' + IntToStr(j),'N' + IntToStr(j)].Borders[xlInsideHorizontal].Weight:=xlThick;
   // ExcelSht.Range['A' + IntToStr(j),'N' + IntToStr(j)].Borders[xlInsideHorizontal].ColorIndex:=41;
   // Borders[xlInsideVertical].LineStyle:=xlSolid;
Function SetPatternRange(sheet:variant;range:string;
  Pattern,ColorIndex,PatternColorIndex,Color,PatternColor:integer):boolean;
begin
  SetPatternRange:=true;
  try
  E.ActiveWorkbook.Sheets.Item[sheet].Range[range].Interior.Pattern:=Pattern;
  if ColorIndex>0
   then E.ActiveWorkbook.Sheets.Item[sheet].Range
   [range].Interior.ColorIndex:=ColorIndex
   else E.ActiveWorkbook.Sheets.Item[sheet].Range
   [range].Interior.Color:=color;
  if PatternColorIndex>0
   then E.ActiveWorkbook.Sheets.Item[sheet].Range
   [range].Interior.PatternColorIndex:=PatternColorIndex
   else E.ActiveWorkbook.Sheets.Item[sheet].Range
   [range].Interior.PatternColor:=PatternColor;
  except
  SetPatternRange:=false;
  end;
End;

function ZelKS(Pras:double):boolean;
 var
  i,k: integer;
begin
  Z:=0;
   i_gt:=xx[1];
   n_d  :=xx[2];
   Mk[1]:=Pras*Dsh[1]/2;
   Mr:=Mk[1]/Imost/Ikp[Nper]/nu[Nper]/NuRom/NuMost;
      GTD_DWS(i_gt);
    v1:=3.6*Dsh[1]/2*n_d*i_gt/30*pi/Imost/Ikp[Nper]/Irom;  // км/ч
    z:=1e3*Sqr(Mtur-Mr)+3e4/V1;
    if Md_brt*Mdr/100-Mlost<=Mnasos then z:=z+1e4*Sqr(Mnasos-Md_brt{*Kimd});
            inc(fe);
           Fun:=z;
           Result:=true;
                end;

procedure KoordSp_Ord(Pras:double);
label k1;
const Dshag=3;
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
           end;*)
