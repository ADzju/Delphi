unit tyaga120_6x3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,System.Math, Vcl.Grids, Vcl.StdCtrls,ComObj,
  Vcl.ColorGrd, Vcl.ExtCtrls,Vcl.Buttons, Vcl.ValEdit;

type
  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Button1: TButton;
    StringGrid1: TStringGrid;
    RadioGroup1: TRadioGroup;
    FilePath: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    DataList: TValueListEditor;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

type {
GTRec=record
Igt,Kgt,YL :array [0..10]of double;
end;  }
GTmas=array[0..34]of double;
MasDV=array[1..2,0..14]of double;
var
  //GT:GTRec;
  OutMemo:boolean;
  Igt,Kgt,YL:GTmas;
  Ikp:array[1..9]of double;
  Nper: byte;
  h_koleya,L_kont,Sigma0,Sigma,K_kazygin,Bgrz2,Pgrunt,G1,G2,
  Ky1,Ky2,Cy1,Cy2,Tem,Cc,v1,v2,x1,x2,y1,y2,c1,c2,c3,Hprof,Rpriv,Ak,Bk,Fk,k0,
  Sigma_Sh,TanFi,Kc,DLk,Fipr,Fisk,Fip,Tau0,Tausr,Ktau,Imost                      : extended;
  Dr,n1,It,I_gt,Ktr,M1,M2,Mdv,Ndv,KM_GT,K_Nas_Dv,Mr,Mnasos,Mtur: double;
  Po,fSh,fst,Dsh,Rst,Bsh,Dob,Psh,Pmin,Pmax,Qmin,Qmax,Pf,K_Pf,t_gz,H_gz,
  Pkfi,Pk,PkBNTU,PkGus,Hgrunt,q_max,e,Mk,Bux,Itr,KPDgm,KPDm,KPDtr,q12           : array[1..2] of real;
  Nsl: array[1..2] of integer;
 // holdColor: TColor;
// for Hook-Jeews
z,h,k,fi,fb: extended;
x,y,p,b : array[1..10] of extended;
fe,n,i,j,ps,bs: integer;
Md:MasDV;


const
Kimd=0.9; // к-т использования момента ДВС
nu=0.92;  // кпд трансмиссии механический
Igt0:GTmas=(0,     0.1,  0.2,  0.3,  0.4,  0.5,  0.6,  0.7,  0.8,  0.9,  0.95,  0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
//Ikp:array[1..9]of double=(5.732,3.6056,2.3352,1.4689,0.9715,0.6111,5.1787,2.1098,0.8777);
//Imost=15.576;
Igt3208:GTMas=(0,0.061125,0.10289375,0.153321875,0.20375,0.25570625,0.307153125,0.357071875,0.4075,0.4625125,0.51039375,0.53484375,0.56235,0.5868,0.61226875,0.637228125,0.664734375,0.688165625,0.715671875,0.740121875,0.766609375,0.79055,0.817546875,0.84046875,0.86695625,0.8944625,0.9189125,0.94234375,0.9678125,0,0,0,0,0,0);
Kgt3208:GTMas=(2.767497183,2.517090272,2.432130349,2.313477142,2.189788245,2.090837126,1.990015151,1.900598594,1.790910229,1.710633947,1.59250343,1.525199969,1.475525388,1.409985191,1.375524701,1.334837272,1.292283447,1.242185218,1.176221705,1.140458508,1.094751193,1.065319379,1.025925193,1.023403772,0.967280164,0.906806895,0.942331288,0.950362521,1,0,0,0,0,0,0);
// hгт,0,0.153857143,0.250251012,0.354706653,0.446169355,0.534640121,0.611239372,0.678650304,0.729795918,0.791189583,0.812803797,0.815743671,0.829761702,0.82737931,0.842190789,0.850595852,0.859025229,0.854829167,0.841788793,0.844078289,0.839246528,0.842188235,0.838741935,0.860138889,0.838589583,0.811104762,0.86592,0.895568182,0.9678125
YL3208:GTMas=(29.08305684,29.08305684,29.32046955,29.43917591,29.43917591,29.43917591,29.32046955,29.32046955,29.08305684,28.48952507,28.13340601,28.13340601,27.8959933,27.53987424,27.06504882,26.47151705,25.87798527,24.92833444,24.09738996,22.55420735,21.3671438,20.18008026,18.39948494,16.02535785,14.24476254,12.46416722,8.902976585,6.528849496,4.748254179,0,0,0,0,0,0);

Igt35010:GTMas=(0,0.05,0.1,0.15,0.21,0.26,0.31,0.36,0.41,0.46,0.51,0.54,0.56,0.59,0.61,0.64,0.67,0.69,0.71,0.74,0.77,0.79,0.82,0.84,0.87,0.89,0.92,0.94,0.97,0,0,0,0,0,0);
Kgt35010:GTmas=(2.859,2.652,2.518,2.388,2.263,2.129,2.009,1.889,1.801,1.684,1.577,1.517,1.471,1.409,1.367,1.317,1.261,1.225,1.178,1.107,1.061,1.023,1.008,1.01,1.006,1.002,1.013,1.02,1.024,0,0,0,0,0,0);
YL35010:GTmas=(22.22,22.37,22.75,22.98,23.13,23.28,23.28,23.28,23.13,22.9,22.52,22.3,21.99,21.77,21.61,21.23,20.86,20.48,19.87,18.96,18.2,17.06,15.93,15.17,13.65,12.13,10.62,8.72,5.69,0,0,0,0,0,0);

//Kgt320:GTmas=(2.77,  2.43, 2.19, 1.99, 1.79, 1.59, 1.38, 1.24, 1.07, 0.91, 0.95, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
Igt3704:GTMas=(0,0.04375,0.0875,0.13125,0.175,0.21875,0.2625,0.30625,0.35,0.39375,0.4375,0.459375,0.48125,0.503125,0.525,0.546875,0.56875,0.590625,0.6125,0.634375,
              0.65625,0.678125,0.7,0.721875,0.74375,0.765625,0.7875,0.809375,0.83125,0.853125,0.875,0.896875,0.91875,0.940625,0.9625);
Kgt3704:GTMas=(3.322911051,3.006543075,2.790966387,2.677402597,2.517346939,2.362907268,2.239087302,2.110567515,1.992251816,1.874517375,1.768339768,1.704665705,1.662953995,1.604842615,1.561710398,1.518283764,1.474559687,1.43546798,1.395946614,1.361111111,1.319919517,1.278622087,1.241167435,1.207272727,1.168067227,1.115034778,1.065337763,1.038095238,0.98031746,0.971153846,0.955357143,0.958471761,0.964285714,0.969387755,0.961038961);
// hгт,0,0.13153626,0.244209559,0.351409091,0.440535714,0.516885965,0.587760417,0.646361301,0.697288136,0.738091216,0.773648649,0.783080808,0.80029661,0.807436441,0.819897959,0.830311433,0.838655822,0.847823276,0.855017301,0.863454861,0.866197183,0.867065603,0.868817204,0.8715,0.86875,0.853698502,0.838953488,0.840208333,0.814888889,0.828515625,0.8359375,0.85962936,0.8859375,0.911830357,0.925
YL3704:GTMas=(15.22162831,15.04930799,15.62370906,15.79602938,16.08322992,16.37043045,16.54275077,16.7725112,16.94483152,17.00227163,17.00227163,17.05971173,16.94483152,16.94483152,16.88739141,16.8299513,16.7725112,16.65763098,16.60019088,16.54275077,16.31299034,16.19811013,16.02578981,15.79602938,15.62370906,15.33650853,14.81954757,13.78562564,12.92402404,11.94754222,11.02850051,9.879698377,8.041614958,5.629130471,3.159205876);
//Mн, Нм,265,262,272,275,280,285,288,292,295,296,296,297,295,295,294,293,292,290,289,288,284,282,279,275,272,267,258,240,225,208,192,172,140,98,55
//YL320 :GTmas=(29.04,29.32,29.44,29.32,29.08,28.13,27.07,24.93,20.18,12.46, 6.53, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
IgtZF:GTMas=(0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.85,0.9,0.95,0.965,0.977,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
KgtZF:GTMas=(1.874,1.824,1.764,1.687,1.583,1.479,1.349,1.222,1.090,1.021,0.94,0.86,0.841,0.827,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
YLZF:GTmas=(43.62,45.1,46.35,47.4,48.24,46.77,43.1,38.91,33.87,31.04,23.91,15.84,14.37,13.21,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

MdZF : MasDV =((1000,1200,1400,1600,1800,1900,2000,2100,2200,2332,2340,2342,2344,2346,2400),
                (467, 548, 577, 556, 524, 505, 488, 467, 451, 5,4,3,2,1,0));

Md1  : MasDV =((1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2150,2200,2340),
               (610, 630, 645, 660, 667, 659, 651, 642, 632, 622, 612, 602, 550, 300,  10));
  Fimax=0.7;  kfi=-8.48; // стерня зерновых на суглинке - БНТУ
//Fimax=0.6;  kfi=-7.69  // стерня зерновых на супеси
//Fimax=0.55; kfi=-7.01  // поле, подготовленное под посев на суглинке и супеси

procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
Rect: TRect; State: TGridDrawState);
var st:string; R:real;
begin
 with Form3 do begin
if (ARow=0) or (Form3.StringGrid1.Cells[ACol, ARow]='') then exit;
//  R:=StrToFloat(StringGrid1.Cells[ACol, ARow]);
//  St:=Format('%5.3f',[R]);
//  StringGrid1.Cells[ACol, ARow]:=St;
if {t4_4 and} (ACol in [3,4]) and (StrToFloat(StringGrid1.Cells[ACol, ARow])>20) then // буксование>20%
  begin
StringGrid1.Canvas.Brush.Color := clYellow;
StringGrid1.Canvas.FillRect (Rect);
StringGrid1.Canvas.TextRect (Rect, Rect.Left + 2, Rect.Top + 6, StringGrid1.Cells[ACol,ARow]);
  end; {if}
if {t4_4 and }(ACol in [5,6]) then begin
      if (StrToFloat(StringGrid1.Cells[ACol, ARow])>25) // давление>30 МПа
      then StringGrid1.Canvas.Brush.Color := clYellow; //clBlue;    {цвет}
      if (StrToFloat(StringGrid1.Cells[ACol, ARow])>40)
      then StringGrid1.Canvas.Brush.Color := clRed; //clBlue;    {цвет}
   StringGrid1.Canvas.FillRect (Rect);
   StringGrid1.Canvas.TextRect (Rect, Rect.Left + 2, Rect.Top + 6, StringGrid1.Cells[ACol,ARow]);
  end; {if}
      end;
end;

Procedure CntrText(i,N_Row:integer; Text: String);
 var WCells: Integer;
 Stroka:string;
     begin
     with Form3 do
     begin
 WCells:=StringGrid1.ColWidths[N_Row]-7; //7 - корректировка
 Stroka:=Text;
 with StringGrid1, Form3.StringGrid1.Canvas do
     while TextWidth(Stroka)<WCells do Stroka:=' '+Stroka+' ';
             Stroka:=' '+Stroka;
    Form3.StringGrid1.Cells[i,N_Row]:=Stroka;
       end;
     end;

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

     begin
 i:=0;
 while XMas[i]<x do inc(i);
 if x>MaxValue(XMas) then begin Result:=YMas[i]; exit; end;
  a:=((Ymas[i+1]-Ymas[i-1])*(Xmas[i]-Xmas[i-1])-(Ymas[i]-Ymas[i-1])*(Xmas[i+1]-Xmas[i-1]))
     /((Sqr(Xmas[i+1])-Sqr(Xmas[i-1]))*(Xmas[i]-Xmas[i-1])-(Sqr(Xmas[i])-Sqr(Xmas[i-1]))*(Xmas[i+1]-Xmas[i-1]));
     b:=(Ymas[i]-Ymas[i-1]-a*(Sqr(Xmas[i])-Sqr(Xmas[i-1])))/(Xmas[i]-Xmas[i-1]);
     c:=Ymas[i-1]-(a*Sqr(Xmas[i-1])+b*Xmas[i-1]);
     Result:=a*x*x+b*x+c;
         end;
end;


Procedure GTD_DWS(i_gt:double);
var   i:byte;  K:real;
const Ro=1000;

begin
//  Mnasos:={9.8}1e-7*Interpol2(0.4,Igt,YL)*1000*Sqr(2290)*Power(0.32,5);
//  k:=51.17/Mnasos;
   k:=Interpol1(i_gt,Igt,YL);
  Mnasos:=9.81e-7*Interpol2(i_gt,Igt,YL)*Ro*N1*N1*Power(Dr,5);
  Ktr:=Interpol2(i_gt,Igt,Kgt);
  Mtur:=Ktr*Mnasos;
  Mdv:=Interpol1(n1,Md[1],Md[2]);
  K_Nas_Dv:=Mnasos/Mdv;
  M1:=Mnasos;   M2:=Mtur;
  if Mnasos<Kimd*Mdv then begin KM_GT:=1;   {  M1:=Mnasos;   M2:=Mtur; } end
                     else begin KM_GT:=K_Nas_Dv; {M1:=Kimd*Mdv; M2:=Kimd*Mdv*Ktr;} end;
            end;

procedure TForm3.FormCreate(Sender: TObject);
var
x,y:real;
begin
OutMemo:=true;
Dsh[1]:=1.26;    // м Диаметр наружный шины
   end;


procedure HookJ(Pras:double);
 label 0,1,2,3,4,5,6,7;

procedure calculate; // Процедура,вычисляющая функцию
 var
  i,k: integer;
 begin
  Z:=0;
   i_gt:=x[1];
   n1  :=x[2];
   Mk[1]:=Pras*Dsh[1]/2;
   Mr:=Mk[1]/Imost/Ikp[Nper]/nu;
      GTD_DWS(i_gt);
    v1:=3.6*Dsh[1]/2*n1*i_gt/30*pi/Imost/Ikp[Nper];  // км/ч
    z:=1e3*Sqr(Mtur-Mr)+3e4/V1;
    if Mdv*Kimd<=Mnasos then z:=z+1e4*Sqr(Mnasos-Mdv{*Kimd});
            inc(fe);
         end;

begin
     n:=2;        // число переменных
     x[1]:=0.8;
     x[2]:=2200;  // начальные точки x1,...xN'
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
with Form3 do begin
 //  Memo1.Lines.Add('Начальное значение функции'+Format(' %5.3f ',[z]));
// for i:=1 to n do Memo1.Lines.Add(Format(' %5.3f ',[x[i]]));
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
// Но если исследование производилось вокруг точки шаблона PT, и уменьшение функции не было достигнуто,
// то изменить базисную точку в операторе 4: в противном случае уменьшить длину шага в операторе 5
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
        v1:=3.6*Dsh[1]/2*n1*i_gt/30*pi/Imost/Ikp[Nper];  // км/ч
        Ndv:=Mdv*n1/9.81/716.2;
        Pk[1]:=Mtur*Imost*Ikp[Nper]/Dsh[1]*2e-3*nu;
Form3.Memo1.Lines.Add('Передача '+IntToStr(Nper)+Format('. Itr=%7.3f    Pk= %7.1f kH    Скорость (без буксования) =%7.3f км/ч', [Imost*Ikp[Nper],Pk[1],V1]));
  // Form3.Memo1.Lines.Add(Format('Шаг параметров = %10.8e', [H_s[1]]));
   Form3.Memo1.Lines.Add(Format('I gt=%7.5f    n ДВС (n1) =%6.1f   Mdv=%6.2f  Mnasos=%6.2f  Mtur=%6.2f', [I_gt, n1, Mdv, Mnasos, Mtur]));
   Form3.Memo1.Lines.Add(Format('К-т использ.Mгмп =%5.3f,   К-т трансф-и=%6.4f    К-т использ.Мдвс =%5.3f,    Nдвс =%5.1f л.с.', [KM_GT,Ktr,K_Nas_dv, Ndv]));
   Form3.Memo1.Lines.Add(Format('КПД ГМП=%5.2f %%', [Mtur*i_gt/Mnasos*100]));
                        exit;
      end;

         end;

Procedure Dann;
begin

    with Form3 do begin
 case RadioGroup1.ItemIndex of
     0: begin Md:=Md1; Dr:=0.32; Igt:=Igt3208;  Kgt:=Kgt3208;  YL:=YL3208;  end;
     1: begin Md:=Md1; Dr:=0.35; Igt:=Igt35010; Kgt:=Kgt35010; YL:=YL35010; end;
     2: begin Md:=Md1; Dr:=0.37; Igt:=Igt3704;  Kgt:=Kgt3704;  YL:=YL3704;  end;
     3: begin Md:=MdZF; Dr:=0.3;  Igt:=IgtZF;    Kgt:=KgtZF;    YL:=YLZF;    end
         end;
         for I := 1 to 6 do Ikp[i]:=StrToFloat(DataList.Cells[1,i]);
         for I := 1 to 3 do Ikp[i+6]:=StrToFloat(DataList.Cells[1,i+6]);
         Imost:=StrToFloat(DataList.Cells[1,10]);
         Dsh[1]:=2*StrToFloat(DataList.Cells[1,11]);
         Nper:=StrToInt(DataList.Cells[1,12]);
              end;
          end;

procedure TForm3.BitBtn1Click(Sender: TObject);
var i: byte;
begin
   Dann;
   n1:=2000;
   Nper:=StrToInt(DataList.Cells[1,12]);   // Nper:=StrToInt(Form3.Edit1.Text);
   GTD_DWS(0.5);
  HookJ(1000*StrToFloat(DataList.Cells[1,13]));   // Opt2(StrToInt(Form3.Edit2.Text));
          end;

procedure TForm3.Button1Click(Sender: TObject);
  Var
i,j: integer; Pt:real;
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
       repeat
   n1:=800+j*100;
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
     j:=j+1;
  until n1>=2300;
  ExcelSht.Range['A' + IntToStr(j)] :=' Iмоста';
  ExcelSht.Range['B' + IntToStr(j)] :=' Rk';
       inc(j);
  ExcelSht.Range['A' + IntToStr(j)] :=Imost;
  ExcelSht.Range['B' + IntToStr(j)] :=Dsh[1]/2;
       inc(j);
  ExcelSht.Range['A' + IntToStr(j)] :=' Pk, kH';
  ExcelSht.Range['B' + IntToStr(j)] :=' Iгт';
  ExcelSht.Range['C' + IntToStr(j)] :=' V км/ч';
  ExcelSht.Range['D' + IntToStr(j)] :=' n двс';
  ExcelSht.Range['E' + IntToStr(j)] :=' Mнасоса';
  ExcelSht.Range['F' + IntToStr(j)] :=' n турбины';
  ExcelSht.Range['G' + IntToStr(j)] :=' М турбины';
  ExcelSht.Range['H' + IntToStr(j)] :=' Nдвс л.с.';
  ExcelSht.Range['I' + IntToStr(j)] :=' КПД ГМП';
  for i := 1 to 9 do begin
    Nper:=i;
     j:=j+2;
    ExcelSht.Range['A' + IntToStr(j)] :='Передача '+IntTostr(i); ExcelSht.Range['B' + IntToStr(j)] :=Ikp[i];
     n1:=2100;
     GTD_DWS(0);
       // v1:=3.6*Dsh[1]/2*n1*i_gt/30*pi/Imost/Ikp[Nper];  // км/ч
        Ndv:=Mdv*n1/9.81/716.2;
        Pk[1]:=Mtur*Imost*Ikp[Nper]/Dsh[1]*2e-3*nu;
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
     Pt:=90000-i*10000;

        if i>6 then Pt:=80000-(i-6)*10000;
              repeat
               HookJ(Pt); // Opt2(Pt);
               if Pk[1]>1e-3 then begin
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
      until (Pt<0) {or (Bux[1]>0.3) or (Bux[2]>0.3)};
   end;
   Form3.Memo1.Lines.Add('Расчет выполнен '+DateToStr(Now)+' за '+TimeToStr(Now-Tim)+'ч/мин/с');
      finally
  if not VarIsEmpty(ExcelApp) then ExcelApp.Visible := True;
          ExcelApp := UnAssigned;
    end;
      end;
procedure TForm3.Button2Click(Sender: TObject);
var
FName,St,Prich:AnsiString;
DataFile:TextFile;
Komm_Str:TList;
i,j,k:integer;

 begin
  OpenDialog1.Filter :='Передаточные числа КП|*.txt|';
  OpenDialog1.Execute;
  FName:=OpenDialog1.FileName;
  FilePath.Text :=FName;
 AssignFile(DataFile,FName);
   {$I-}
   Reset(DataFile);
   {$I+}
  if IOResult=0 then //Файл существует
             with Form3 do begin
          i:=0;
    try
       for I := 1 to 11 do begin
  readln(DataFile,St); DataList.Cells[1,i]:=St; end;
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


procedure TForm3.Button3Click(Sender: TObject);
begin
 Dann;
  Nper:=StrToInt(DataList.Cells[1,12]);//  Nper:=StrToInt(Form3.Edit1.Text);
   HookJ(1000*StrToFloat(DataList.Cells[1,13])); // HookJ(StrToInt(Form3.Edit2.Text));
     end;
   end.


     function GettingData:boolean;
 begin
  GettingData:=true;
  Path:=Form1.FilePath.Text;
   if Path='' then
    begin
     GettingData:=false;
       ShowMessage('Не указан путь к файлу исходных данных');
           end
          else if uk=false then GettingData:=false;
    end;

