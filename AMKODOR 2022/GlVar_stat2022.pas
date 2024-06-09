unit GlVar_stat2022;   // ���� 2022 ����� �������� ������ �������� ����������, ������ ��� � Excel
                 // ������ �������������.������������ ������ 2-���������������� ������ �������
interface
uses obrotk2022, OutG_2022_5,Classes,SysUtils,Math, StrUtils; //Graphics;//DateUtils;
const Max_Start=1e306;

var SRmin,SRmax:double;
    bCopyBest: boolean;
    dMinimumAll: double;
    iMaxBest: integer;
    Tim,dT:TDateTime;
    th,tm,ts,tms: word;

type
  Xromosome = record
    sX: AnsiString;
    Celev_F: double;
    Pokolenie: integer;
  end;

  PosGen = record
    gStart: integer;
    gLength: integer;
  end;

  PXromosome = ^Xromosome;        // ��������� �� ���������
  PPosGen = ^PosGen;              // ��������� �� ���

TGen = class(TThread)           // ��������� ������, ����� "�������-�����" ��� ����������� ����������
    // private     { Private declarations }
  protected
    SizePopulation: integer;      // ����� ������ � ���������. ������ ���� ������!!!
    fPCrossingOver: double;       // ����������� �������������
    fPMutation: double;           // ����������� �������
    ListPopulation: TList;        // ������ ���������
    ListBest: TList;
    ListGens: TList;
    AXrome: PXromosome;
    AGen: PPosGen;                // ��������� ������� ����  AGen.gStart, AGen.gLenght
    LengthXrome: integer;         // ����� ���������
    procedure Execute; override;
    procedure UpdMain;
    procedure MakePopulation;
    procedure DestroyPopulation(iNumPokolenie: integer);
    procedure DestroyBad(iNumOsobey: integer);
    procedure CrossingOver(iNumPokolenie: integer);
    procedure Mutation;
    procedure XromeToA(sXrome: AnsiString);
    procedure MoveBest(iNPokolenie: integer);
        public
            end; //TGen

Procedure SpirSp_Execute;
function  ErfC(X : double):double;
function  Erf(X : double):double;
Function  normCDF (X:double):double;
Function  WeibF(A,B,t:double):double; //��������� ������������� - ����� ��������
Function  weibCDF (A,B,t:double):double;     //������������ ������� ����� �� ������ ��������
Function  weibCDF2(A,B,t1,t2:double):double; //����������� ��������� � �������� �1...�2
Procedure Podbor_Weib_Pirson(Var Arez,Brez:double);
Procedure Podbor_Weib_Smirnow(Var Arez,Brez:double);
Function  CDF_Gauss(Sred,SKO,X:double):double;
Function  weibinv(A,B,P:double):extended;
Function  normstat(Sred,SKO:double):MasParam;
Procedure sort_MinMax; // ( Var z: array of Problems);
Procedure hist_Format;//1) ��������, ������������ ������� �� ����� ����� Sum_PrichCol[],�� �������� Hist_Stol[k].Npr[]
Procedure Hist_SKO(Model:Mod_Weib);
Function  Kolmogor(Kpwt,A,B,Mu,Sig:double; var KolmCrt:double;var S:string): double;
Procedure Sigmas(var Wei:Mod_Weib;T_pr:double);


implementation

uses windows,Dialogs, Winapi.Messages, System.Variants,
  Vcl.Controls, Vcl.Forms, Printers,  // VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart,
   Vcl.ExtCtrls,  Vcl.StdCtrls;

type
  MyFunc=function(MU,SIG,X:double):double;
  MyFuncX=function(X:double):double;


function ErfC(X : double):double;  //���������� AlgLib
var
    P : double;
    Q : double;
begin
    if (X<0) then begin
        ErfC := 2-ErfC(-X);
        Exit;
    end;
    if (X<0.5) then begin
        ErfC := 1.0-Erf(X);
        Exit;
    end;
    if(X>=10) then begin
        ErfC := 0;
        Exit;
    end;
    P := 0.0;
    P := 0.564187782550+X*P;
    P := 9.675807882987+X*P;
    P := 77.08161730368+X*P;
    P := 368.5196154710+X*P;
    P := 1143.262070703+X*P;
    P := 2320.439590251+X*P;
    P := 2898.029329216+X*P;
    P := 1826.334884229+X*P;
    Q := 1.0;
    Q := 17.14980943627+X*Q;
    Q := 137.1255960500+X*Q;
    Q := 661.7361207107+X*Q;
    Q := 2094.384367789+X*Q;
    Q := 4429.612803883+X*Q;
    Q := 6089.542423272+X*Q;
    Q := 4958.827564721+X*Q;
    Q := 1826.334884229+X*Q;
    ErfC := Exp(-Sqr(X))*P/Q;
end;

  (*************************************************************************
Error function
The integral is
                          x
                           -
                2         | |          2
  erf(x)  =  --------     |    exp( - t  ) dt.
             sqrt(pi)   | |
                         -
                          0

For 0 <= |x| < 1, erf(x) = x * P4(x**2)/Q5(x**2); otherwise
erf(x) = 1 - erfc(x).

ACCURACY:
                     Relative error:
arithmetic   domain     # trials      peak         rms
   IEEE      0,1         30000       3.7e-16     1.0e-16

Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 1988, 1992, 2000 by Stephen L. Moshier
*************************************************************************)
function Erf(X : double):double;
var
    XSq : double;
    S : double;
    P : double;
    Q : double;
begin
    S := Sign(X);
    X := Abs(X);
    if (X<0.5) then
    begin
        XSq := X*X;
        P := 0.007547728033418631287834;
        P := 0.288805137207594084924010+XSq*P;
        P := 14.3383842191748205576712+XSq*P;
        P := 38.0140318123903008244444+XSq*P;
        P := 3017.82788536507577809226+XSq*P;
        P := 7404.07142710151470082064+XSq*P;
        P := 80437.3630960840172832162+XSq*P;
        Q := 0.0;
        Q := 1.00000000000000000000000+XSq*Q;
        Q := 38.0190713951939403753468+XSq*Q;
        Q := 658.070155459240506326937+XSq*Q;
        Q := 6379.60017324428279487120+XSq*Q;
        Q := 34216.5257924628539769006+XSq*Q;
        Q := 80437.3630960840172826266+XSq*Q;
        Erf := S*1.1283791670955125738961589031*X*P/Q;
        Exit;
    end;
    if X>10 then begin
        Erf := S;
        Exit;
    end;
    Erf := S*(1-ErfC(X));
end;

(****************************************************************
Complementary error function
 1 - erf(x) =
                          inf.
                            -
                 2         | |          2
  erfc(x)  =  --------     |    exp( - t  ) dt
              sqrt(pi)   | |
                          -
                           x
For small x, erfc(x) = 1 - erf(x); otherwise rational
approximations are computed.
ACCURACY:
                     Relative error:
arithmetic   domain     # trials      peak         rms
   IEEE      0,26.6417   30000       5.7e-14     1.5e-14
Cephes Math Library Release 2.8:  June, 2000
Copyright 1984, 1987, 1988, 1992, 2000 by Stephen L. Moshier
*************************************************************************)

function NormalDistribution(X : double):double;
begin
    NormalDistribution := 0.5*(Erf(x/1.41421356237309504880)+1);
end;
Function NormCDF (X:double):double; //�������� ������������ ������� �������������
var y,xx,k: double;
    i:integer;
        begin
   //if X>7{5.6} then y:=1 else
   try
   if X<-5.6 then y:=0
   else begin
   xx:=x*x;  k:=1/Sqrt(2*Pi)*exp(-xx/2);
   if x<0 then begin x:=-x; k:=-k; end;
      y:=x; i:=1;
         repeat
   i:=i+2; x:=xx*x/i;y:=y+x;
      until x<1e-12;
       normCDF:=0.5+k*y;
        end;
       finally
      if x>6 then normCDF:=1
             else if x<-6 then normCDF:=1e-12/x;
           end;
       end;

Function CDF_Gauss(Sred,SKO,X:double):double;
var x_priv,t: double;
        begin
// sred:=1; SKO:=0.1; X:=0.7;
x_priv:=(x-Sred)/SKO;
t:=NormalDistribution(x_priv); //  ��������� 26.02.2022
if t<=0 then t:=1e-12;
CDF_Gauss:=t;
        end;

Function WeibF(A,B,t:double):double; //��������� ������������� - ����� ��������
var wf:double;
        begin
if (A<=0) or (B<=0) then begin
     WeibF:=1e-305;
      end
     else
     {$I-}
// wcdf :=1-exp(-A*Power(t,b));  //- ��� � Matlab. �-��������, �������� ������������� �-�� ��������
 wf :=exp(-Power(t/B,A))*A/Power(B,A)*Power(t,(A-1));  // ��� � Excel 28.02.2022
 if wf>0 then WeibF:=wf
           else WeibF:=1e-30;
           {$I+}
        end;


Function WeibCDF(A,B,t:double):double; //������������ ����������� - ����� ��������
var wcdf:double;
        begin
if (A<=0) or (B<=0) then begin
     weibcdf:=1e-305;
      end
     else
     {$I-}
// wcdf :=1-exp(-A*Power(t,b));  //- ��� � Matlab. �-��������, �������� ������������� �-�� ��������
 wcdf :=1-exp(-Power(t/B,A));  // ��� � Excel 28.02.2022
 if wcdf>0 then WeibCDF:=wcdf
           else WeibCDF:=1e-30;
           {$I+}
        end;

Function WeibCDF2(A,B,t1,t2:double):double; //����������� ��������� � �1...�2
     begin

if t2<t1 then
  begin   WeibCDF2:=1;
    if MessageBox(GetActiveWindow, PWideChar('��������� ������ ���� t2>t1'),
          PWideChar('ObrOtk'), MB_OK or MB_ICONHAND )>0 then Halt;
      Exit; end
      else WeibCDF2 := weibCDF(A,B,t2)-weibCDF(A,B,t1);
        end;

procedure sort_MinMax; // ���������� ������� �� ����������� ������� ��������
Var
a,b:problems;
i,j:integer;
                begin
       for j:=0 to high(MasProbl) do
         for i:=0 to high(MasProbl)-1 do
   if MasProbl[i].time>MasProbl[i+1].time then
    begin
     a:=MasProbl[i];      //  b:=z[2,i];
     MasProbl[i]:=MasProbl[i+1]; //z[2,i]:=z[2,i+1];
     MasProbl[i+1]:=a;    //
    end;
                end;

Procedure Hist_Format;
// �������� �� �������, ������������ ������� �� ����� ����� Sum_PrichCol � �� �������� Hist_Stol[k].Npr[..]- #1
Var  // �������� 05.03.2022
i,i2,i_0,j,k:integer;
t2:double;
label Menshe;
const MaxColmn = 40;

            begin
         D_Hist1:=100;  D_Hist2:=100;
Menshe:  setlength(Hist_Stol,0);
           for i := 0 to MaxColmn do begin
                Sum_PrichCol[i]:=0;
                        end;
              i :=0;    j:=0;           // ���������� ����� ������
              i_0:=0;   k:=0;           // � ������� �����������
                        t2:=0;
         repeat                         // ���� �� ��������
         setlength(Hist_Stol,k+1);
           repeat  //222
        if K<10 then t2:=t2+D_Hist1     // ������ ������� ��������� � ���������� D_Hist1, ����� D_Hist2
                else t2:=t2+D_Hist2;    // ���� �������� �����
                                        // k- ������� i2-����� ���� ������ j-����� ������
  while (j<=high(MasProbl)) and (MasProbl[j].time<t2+1e-1) do
           // if MasProbl[j].time>0 then
                begin // ��������� � ������ ������� � � �������
                if MasProbl[j].time<1 then
                begin
  Hist_Stol[0].Npr[MasProbl[j].chey]:=Hist_Stol[0].Npr[MasProbl[j].chey]+1;
          inc(I_0)
                end
                else
  Hist_Stol[k].Npr[MasProbl[j].chey]:=Hist_Stol[k].Npr[MasProbl[j].chey]+1;
      //����� ������� �� � ������� ��� ������� t1..t2, ������� ������� ������
              inc(j);
                end;
            if k=0 then Hist_Stol[k].Sum:=j-i-i_0
                   else
                        Hist_Stol[k].Sum:=j-i; // ����� ���� ������� � ���������
           until (j-i>0) or (t2>=MasProbl[high(MasProbl)].time);  //222    true=>�����
        Hist_Stol[k].time:=t2;
  for I2 := 0{0} to Nprich+1 do Sum_PrichCol[i2]:=Sum_PrichCol[i2]+Hist_Stol[k].Npr[i2];
         // ������������ ������� ���� ������ �� ��� �����, ������������ � ��� ������� ��������� �������
              inc(k);
         i:=j;
    until t2>=MasProbl[high(MasProbl)].time; // 111
  if ((j>70) and (high(Hist_Stol)<10)) or (high(Hist_Stol)<6) then // ������� ���� ��������
   begin
   D_Hist1:= D_Hist1 div 2;
         setlength(Hist_Stol,0);
      goto Menshe;
            end;
if high(Hist_Stol)>MaxColmn then begin                            // ������� ����� ��������
        D_Hist2:= 2*D_Hist2;
          setlength(Hist_Stol,0);
      goto Menshe;
                     end;
                 end;

Procedure Hist_SKO(Model:Mod_Weib); // ����� �����������!  05.03.2022
// #2 - ���������� ������, �������� �������� ��������� ���-�� ��������� ������ � �������������� ��������
Var
i,n:integer;
SKO_Stolb,t1,t2,ModFi,Razn:double;
        begin
        SKO_Stolb:=0;
  with Model do begin
        t1:=0;
  for i:=0 to high(Hist_Stol) do begin    // ���� �� ��������
        t2:=Hist_Stol[i].time;
 ModFi:=Izd_Prived*K_powtor*weibCDF2(A,B,t1,t2)*(1-(CDF_Gauss(Sred,SKO,(t1+t2))/2)); // ????? t2+t1/2 ��������� ������� ��� t1...t2
  Razn:=Hist_Stol[i].Sum-ModFi;   // ��� ����������� (t<1) !
  SKO_Stolb:=SKO_Stolb+Sqr(Razn);//
        t1:=t2;
    end;
  SKO_Stolb:=Sqrt(SKO_Stolb)/(High(Hist_Stol)+1);
  SKO_Out:=SKO_Stolb;  // �����
Form1.Memo2.Lines.Add('������������� 95% �������� ��������� ��������� '+Format('= %6.4f,  ���= %6.4f', [1.96*Model.SKO_Out, Model.SKO_Out]))
     end;
        end;

Function Kolmogor(Kpwt,A,B,Mu,Sig:double; var KolmCrt:double;var S:string):double; // ������ �� �������� �����������
var Dmax,Dplus,Dminus,Fx,Ft,f1,f2,Fsum,t_z50:double;
    no50:boolean;
    i,k,Nk: integer;
        begin
 Dmax:=0; Fx:=0; Ft:=0; f1:=0;  no50:=true;  Fsum:=0; Dplus:=0;Dminus:=0;
 k:=high(MasProbl);
 Nk:=K+1;
         for i:=0 to k do begin
Fx:=Fx+1/Nk;
f2:=WeibCDF(A,B,MasProbl[i].time);
// MGenet.Kol_F_Priv[i]:=Izd_Prived*k_pwt*MGenet.F_Weib[i]*(1-MGenet.F_norm[i]);
Fsum:=Fsum+(f2-f1)*(1-CDF_Gauss(Mu,Sig,MasProbl[i].time));
Ft:=Fsum*Izd_Prived*Kpwt/Kol_izw; // ���������� �������
if no50 and (Ft>0.5) then begin
t_z50:=MasProbl[i].time; no50:= false; end;
    f1:=f2;
 if MasProbl[i].time>0 then begin  // ��������� ������ �� ������� ���������
    if Dplus<(i/NK-Ft)      then Dplus:=(i/NK-Ft);
    if Dminus<(Ft-(i-1)/NK) then Dminus:=(Ft-(i-1)/(NK));
          end;
                end;
     Dmax:=Max(Dplus,Dminus);
  KolmCrt:=Dmax*Sqrt(NK);   //  KolmCrt:=Dmax*Sqrt(k+1);
  Kolmogor:=Dmax*Sqrt(NK);
  if KolmCrt<1.3581 then S:=' <1.3581(0.05)' else S:=' >1.3581(0.05)'; // ��� �����=0.05
        end;

Function ZF_Histo(A,B,k_pwt{Ao3},Mu,Sig:double; Hist: array of Hist_Rec):double;
var Delta2,x1,x2,Kritery_Moy: double;
                         i,j: integer;

  begin
  x1:=0; j:=0;//if k_pwt<1 then k_pwt:=1;

for i:=0 to high(Hist) do begin   // �������������� ��� ������� ������� �����������
 x2:=Hist[i].time;
 MGenet.F_norm[i]:=CDF_Gauss(Mu,Sig,(x1+x2)/2);   // ���������� ������ �� ���������� (��������������)
     x1:=x2;
            end;   // for i:=0 to high(Mdouble_Hist)
    Delta2:=0; MGenet.Kol_Nakopl:=0; MGenet.SKO_out:=0;
    //Kol:=Izd_Prived*k_pwt;               //Kol_Izw
   x1:=0;
   for i:=0 to high(Hist) do      //�� �������� �����������
          begin
  x2:=Hist[i].time;
  MGenet.F_Weib[i]:=weibCDF2(A,B,x1,x2);   //���������� � ��������� �������
  MGenet.Kol_F_Priv[i]:=Izd_Prived*k_pwt*MGenet.F_Weib[i]*(1-MGenet.F_norm[i]); //����������� � ��������� ����� ������� ������ � �������
  MGenet.Kol_Nakopl:=MGenet.Kol_Nakopl+MGenet.Kol_F_Priv[i];
  MGenet.SKO_out:=MGenet.SKO_out+Sqr((Hist[i].Sum-MGenet.Kol_F_Priv[i]){/(i+1)});
  Delta2:=Delta2+Sqr((Hist[i].Sum-MGenet.Kol_F_Priv[i]));//*MGenet.F_Weib[i];
     x1:=x2;
           end;
   MGenet.SKO_out:=Sqrt(MGenet.SKO_out)/Kol_Izw;  // ������� �� ���������� - �������� � ��������� �������!
   Kritery_Moy:=Delta2+Sqr(Kol_Izw-MGenet.Kol_Nakopl);
   //if k_pwt>(Alim[1,3]+Alim[2,3]) then Kritery_Moy:=Kritery_Moy*Sqr(k_pwt/(Alim[1,3]+Alim[2,3]));
   ZF_Histo:=Kritery_Moy;
       end;

Function CelevFunction(Hist : array of Hist_Rec): double;
var
k, i, N_hist: integer;
     begin
    N_hist:=high(Hist)+1;

  Randomize;    //  Tim:=Time;
 if (Sred_Opt=false)and(SKO_Opt=false) then Result :=ZF_Histo(Ao[2],Ao[1],Ao[3],Sred,SKO,Hist) else
 if (Sred_Opt)and(SKO_Opt=false)       then Result :=ZF_Histo(Ao[2],Ao[1],Ao[3],Ao[4],SKO,Hist) else
 if (Sred_Opt=false)and(SKO_Opt)       then Result :=ZF_Histo(Ao[2],Ao[1],Ao[3],Sred, Ao[4],Hist)
                                       else Result :=ZF_Histo(Ao[2],Ao[1],Ao[3],Ao[4],Ao[5],Hist);
     end;

function BinToInt(Value: AnsiString): Int64;
var
 i : Integer;
        begin
  Result := 0;
   for i := Length(Value) downto 0 do
    if Copy(Value, i, 1)= '1' then Result:= Result + (1 shl i);
       end;

function IntToBin(Value: Int64; Size: Integer): AnsiString;
var
  i: Integer;
        begin
  Result := '';
  for i := Size downto 0 do
  begin
    if Value and (1 shl i) <> 0 then Result:= Result + '1'
                                else Result:= Result + '0';
             end;
         end;

function SortPopulation(Item1, Item2: Pointer): Integer;
        begin
  if PXromosome(Item1)^.Celev_F < PXromosome(Item2)^.Celev_F
  then Result := -1
  else
    if PXromosome(Item1)^.Celev_F > PXromosome(Item2)^.Celev_F then
           Result := 1
      else Result := 0;
        end;

{ ����� TGen *********************************************************************}
Procedure TGen.XromeToA(sXrome: AnsiString);//.procedure MyProcedure(); => Ao[j]
var j: integer;
  begin
  for j := 1 to iop do
Ao[j]:=Abs(NormA[j]*BinToInt(Copy(sXrome, PPosGen(ListGens.Items[j-1])^.gStart, PPosGen(ListGens.Items[j-1])^.gLength)));
            end;

procedure TGen.CrossingOver(iNumPokolenie: integer);//� ListPopulation ����������� ����� ��������� iNumPokolenie
var  i,iX1, iX2, iCrossX, Nx: integer;
  begin
   Nx:=round(ListPopulation.Count*fPCrossingOver); // �-�� ����������� � ������ �������� �������������
          for i := 1 to Nx do begin
    iX1 := Round(Random*((ListPopulation.Count)/2));                        // ��������� �� ������ ��������
    iX2 := ListPopulation.Count-1-Round(Random*((ListPopulation.Count)/2)); // ��������� �� ������� ��������
    iCrossX := 1+Round(Random*(LengthXrome-2));                             // ����� ����������� (�� � ������ � �����)
            New(AXrome);
    AXrome^.sX := Copy(PXromosome(ListPopulation.Items[iX1])^.sX, 1, iCrossX); //�������� �� iX1 �� ����� iCrossX
    AXrome^.sX := AXrome^.sX + Copy(PXromosome(ListPopulation.Items[iX2])^.sX, iCrossX+1, LengthXrome-iCrossX); //���������
    XromeToA(AXrome^.sX);
    AXrome^.Celev_F := CelevFunction(Hist_Stol);
    AXrome^.Pokolenie := iNumPokolenie;
    ListPopulation.Add(AXrome);           // ������� ��������� AXrome ��������� iNumPokolenie � CelevFunction
    New(AXrome);
    AXrome^.sX := Copy(PXromosome(ListPopulation.Items[iX2])^.sX, 1, iCrossX);  //�������� �� iX2 � ����� iCrossX
    AXrome^.sX := AXrome^.sX + Copy(PXromosome(ListPopulation.Items[iX1])^.sX, iCrossX+1, LengthXrome-iCrossX); //���������
    XromeToA(AXrome^.sX);
    AXrome^.Celev_F := CelevFunction(Hist_Stol);
    AXrome^.Pokolenie := iNumPokolenie;
    ListPopulation.Add(AXrome);
  //  if (Form1.CheckBoxProm.Checked) then Form1.Memo2.Lines.Add(Format('F= %-8.3f S2',[AXrome^.Celev_F]));
      end;
       end;

procedure TGen.Mutation;
var
  i, j, k: integer;
  iBitMut1: integer;
Begin
  for i := 1 to Round(SizePopulation * fPMutation) do
  begin
         iBitMut1 := 1+Round(Random * (LengthXrome-1)); // ������� �������
    j := 8+Round(Random * (SizePopulation - 10));
      if PXromosome(ListPopulation.Items[j])^.sX[iBitMut1] = '0'
    then PXromosome(ListPopulation.Items[j])^.sX[iBitMut1]:= '1'
    else PXromosome(ListPopulation.Items[j])^.sX[iBitMut1]:= '0';
       XromeToA(PXromosome(ListPopulation.Items[j])^.sX);
        PXromosome(ListPopulation.Items[j])^.Celev_F := CelevFunction(Hist_Stol);
     end;
   end;

function iGetBits(iVal: integer): integer;
begin
  Result := 0;
  while iVal >= 1 do
  begin
    Inc(Result);
    iVal := iVal div 2;
  end;
end;

procedure TGen.DestroyBad(iNumOsobey: integer);//���������� ��������� �� iNumOsobey �� ������� ������
begin
  while ListPopulation.Count > iNumOsobey do
  begin
    Dispose(PXromosome(ListPopulation.Last));
    ListPopulation.Delete(ListPopulation.Count - 1);
  end;
  if ListPopulation.Count = 0 then
    while ListGens.Count > 0 do
    begin
      Dispose(PPosGen(ListGens.Last));
      ListGens.Delete(ListGens.Count - 1);
    end;
end;

procedure TGen.DestroyPopulation(iNumPokolenie: integer); // ��������� ���������� ���������
var
  i: integer;
begin
  for i := ListPopulation.Count - 1 downto 0 do
  begin
    if PXromosome(ListPopulation.Items[i])^.Pokolenie = iNumPokolenie then
    begin
      Dispose(PXromosome(ListPopulation.Items[i]));     // ����������� ������
      ListPopulation.Delete(i);
    end;
  end;
  if ListPopulation.Count = 0 then                      // ����� ������ �� ��������
    for i := ListGens.Count - 1 downto 0 do
    begin
      Dispose(PPosGen(ListGens.Items[i]));              // ����������� �����
      ListGens.Delete(i);
    end;
end;

procedure TGen.MakePopulation;                          // ������ ���������
var
  i, j, i1, j1 : integer;
  APrevGen: PPosGen;
begin
    for j := 1 to iop do
    begin
      New(AGen);                                        // ����� ���
      try       //*****
        APrevGen := ListGens.Last;
        AGen^.gStart := APrevGen^.gStart + APrevGen^.gLength;
      except
        AGen^.gStart := 0;                              // 0 or 1 ���������� - ������ ������� ����
      end;   //try
       AGen^.gLength := iGetBits(Round(1/Precision));   //����� ����
       ListGens.Add(AGen);
    end;

  for i := 1 to SizePopulation do
  begin
    New(AXrome);                                        // ���������
    AXrome^.sX := '';
      for j1 := 1 to iop do
      begin
        AGen := ListGens.Items[j1-1];                   // j1-1-� ���
        Ao[j1] := Alim[1,j1]+Random * Alim[2,j1];       // ��������� �������� ��������� Ao[j1]
        AXrome^.sX := AXrome^.sX + IntToBin(Round(Ao[j1]/NormA[j1]), AGen^.gLength);  // ��������� �� �����
      end;
    AXrome^.Celev_F := CelevFunction(Hist_Stol);
    AXrome^.Pokolenie := 1;                             //1-� ����� ���������
    ListPopulation.Add(AXrome);
   end;                                                 // ���� i to SizePopulation
    LengthXrome := Length(AXrome^.sX);                  // ������ ������-���������
      end;

procedure TGen.UpdMain;
var
  i, j, k,i1,j1: integer;
  AGenTmp: PPosGen;
begin
  k := 0;
 Form1.Memo2.Lines.Add('������� ����� '+FloatToStr(ListGens.Count));
 for j := 1 to iop do
  begin
  AGenTmp := ListGens.Items[k];
   Inc(k);
    end;
 for i := 0 to ListPopulation.Count - 1 do AXrome := ListPopulation.Items[i];
               end;

procedure TGen.MoveBest(iNPokolenie: integer);
var
  iCopy, i: integer;

begin
  try
    iCopy := StrToInt(Form1.Labelededit1.Text);
    if iCopy > ListBest.Count then
      iCopy := ListBest.Count - 1;
    for i := 0 to iCopy do                      // ����������� iCopy ������
    begin
      New(AXrome);
      AXrome^.sX := PXromosome(ListBest.Items[i])^.sX;
      AXrome^.Celev_F := PXromosome(ListBest.Items[i])^.Celev_F;
      AXrome^.Pokolenie := iNPokolenie;
      ListPopulation.Add(AXrome);
    end;
    while ListBest.Count > 0 do                 // ������� "�����"
    begin
      Dispose(PXromosome(ListBest.Last));
      ListBest.Delete(ListBest.Count - 1);
    end;
    ListPopulation.Sort(SortPopulation);
    DestroyBad(SizePopulation);
  except
  end;
end;

procedure TGen.Execute;
var
  iNPokolenie,i: integer;
  P_sum,x1,x2: double;
  XromeBest: AnsiString;
 // iMaxBest: integer;

begin
  bCopyBest := False;  Stop_Gen:=False;
  SizePopulation := 2*StrToInt(Form1.Edit3.Text) div 2; //������ !!!
  ListPopulation := TList.Create;
  ListGens := TList.Create;
  ListBest := TList.Create;
  iMaxBest := StrToInt(Form1.NPokoleny.Text);     //----------------------------------
 //try
    Randomize;
    MakePopulation;
    Synchronize(UpdMain);
    iNPokolenie := 2;// 0;
    dMinimumAll := 1e306;

  try
    repeat
      if Abs(fPCrossingOver - (Form1.TrackBar1.Position / 100)) > 0.01 then
         begin
        fPCrossingOver := Form1.TrackBar1.Position / 101;
     //  Form1.Memo2.Lines.Add(Format('����������� %4.2f', [fPCrossingOver]));
          end
         else begin
       fPCrossingOver:=0.275*Abs(sin(1-8*iNPokolenie/iMaxBest));
       Form1.TrackBar1.Position:=round(101*fPCrossingOver);
         end;
      if Abs(fPMutation - (Form1.TrackBar2.Position / 100)) > 0.01 then
      begin
        fPMutation := Form1.TrackBar2.Position / 101;
      //  Form1.Memo2.Lines.Add(Format('������� %4.2f', [fPMutation]));
      end
      else begin
      fPMutation:=0.125*Abs(sin(-0.025+10*iNPokolenie/iMaxBest{273}));
    //  fPMutation:=Abs(0.8-fPCrossingOver);
       Form1.TrackBar2.Position:=round(101*fPMutation);
      end;
      if bCopyBest then
      begin
        bCopyBest := False;
        Form1.Memo2.Lines.Add('����������� ������');
        MoveBest(iNPokolenie);
      end;
          if (Abs(iNPokolenie/iMaxBest-0.8)<2e-4)
          or (Abs(iNPokolenie/iMaxBest-0.5)<2e-4)
          or (Abs(iNPokolenie/iMaxBest-0.2)<2e-4)
              then bCopyBest := true;

      ListPopulation.Sort(SortPopulation);

     if ListPopulation.Count > 0 then
      if PXromosome(ListPopulation.First)^.Celev_F < dMinimumAll then
        begin
         dMinimumAll := PXromosome(ListPopulation.First)^.Celev_F;  // ��������� ������� �����������
         XromeBest := PXromosome(ListPopulation.First)^.sX;
         XromeToA(PXromosome(ListPopulation.First)^.sX);
         Aopt := Ao;
     Form1.Memo2.Lines.Add(Format(' ��=%-10.5f  B=%-11.2f  A=%-10.5f   �����=%-9.5f',[CelevFunction(Hist_Stol),Aopt[1],1/Aopt[2],Aopt[3]]));
        end;   // Format('%10.8f',[B])

      New(AXrome);
      AXrome^.sX := PXromosome(ListPopulation.First)^.sX;
      AXrome^.Celev_F := PXromosome(ListPopulation.First)^.Celev_F;
      AXrome^.Pokolenie := iNPokolenie;
      ListBest.Add(AXrome);
   if iMaxBest > ListBest.Count then
        Form1.NPokoleny.Text := FloatToStr(ListBest.Count)    //******* ������
      else
        Form1.NPokoleny.Text := FloatToStr(iMaxBest);
  //  if Form1.CheckBoxProm.Checked then Synchronize(UpdMain);
     CrossingOver(iNPokolenie+1);
     ListPopulation.Sort(SortPopulation);    //
     DestroyBad(SizePopulation);     //++++++++
      Inc(iNPokolenie);
      Mutation;
      if frac(Round(100*iNPokolenie/iMaxBest)/5)=0 then     // 05.03.2022
        Form1.ProgressBar2.Position:=Round(100*iNPokolenie/iMaxBest);
    until Stop_Gen{Terminated} or (iNPokolenie>iMaxBest);

  except
   Form1.Memo2.Lines.Add('�������������� ��������!');
    end;
   // end;  //   ***************
  // finally
    DestroyBad((SizePopulation div 8{4}){0}); // 08.02.2015
    Ao := Aopt;
    MGenet.Executed:=true;
    MGenet.A:=Ao[2]; MGenet.B:=Ao[1]; MGenet.K_Powtor:=Ao[3];

 if (Sred_Opt)and(SKO_Opt=false) then Sred:=Ao[4];
 if (Sred_Opt=false)and(SKO_Opt) then SKO :=Ao[4];
 if (Sred_Opt)and(SKO_Opt) then begin Sred:=Ao[4]; SKO:=Ao[5]; end;
    MGenet.SKO:=SKO; MGenet.Sred:=Sred;
    //MGenet.SKO_Out:=SKO;
    x1:=0;
 MGenet.Unsens:=0;  MGenet.Kol_Nakopl:=0;
  for i:=0 to high(Hist_Stol) do begin
    x2:=Hist_Stol[i].time;
 MGenet.F_norm[i]:=CDF_Gauss(MGenet.Sred,MGenet.SKO,(x1+x2)/2);
 MGenet.F_Weib[i]:=weibCDF2(MGenet.A,MGenet.B,x1,x2);                                    //��������� � ��������� �������
 MGenet.Kol_F_Priv[i]:=Izd_Prived*MGenet.K_powtor*MGenet.F_Weib[i]*(1-MGenet.F_norm[i]); //����������� ����� ������� ������ � �������
     x1:=x2;
        end;
    ListBest.Free;
    ListPopulation.Free;
    ListGens.Free;
    Sigmas(MGenet,T_Prirab);
    Hist_SKO(MGenet);//
     // Gen.Synchronize(Gen,Diastart);
        DiaGen;
      //      Form5.Visible:=true;
             end;
  //               end;

Function PodIntLogCDF(MU,SIG,t:double):double;
  begin
    Result:=exp(-(sqr(Ln(t)-MU))/(2*sqr(SIG)))/ t;
  end;

function erfinv(t:double):extended;   //��������� �������� ������� ������ ��� -1<t<=0
begin
          if t=0 then erfinv:=0
  else if t=-0.1 then erfinv:=-0.088856
  else if t=-0.2 then erfinv:=-0.179143
  else if t=-0.3 then erfinv:=-0.272463
  else if t=-0.4 then erfinv:=-0.370807
  else if t=-0.5 then erfinv:=-0.476936
  else if t=-0.6 then erfinv:=-0.595116
  else if t=-0.7 then erfinv:=-0.732869
  else if t=-0.8 then erfinv:=-0.906194
  else if t=-0.9 then erfinv:=-1.163086
  else if (t>-1) and (t<0) then
    erfinv:=3.5316*power(t,5)+5.9031*power(t,4)+3.873*power(t,3)+0.9119*sqr(t)+0.962*t+0.0003
  else begin
   MessageDlg('������ ���������� ������� erfinv ' , mtWarning, [mbOk], 0);
          halt;
    end;
end;

function gamma(x:double):double; //���������� ����� ������� � ������������ 1*10^-5 �(�)
Var
  Z,A,B:double;
  i:integer;
begin
  if (x>-18) and (x<49) then
    begin
      Z:=x; A:=1;
      for i:=1 to 20 do
        Z:=Z*(X+i);
      B:=x+21;
      gamma:=exp(B*(ln(B)-1)+1/(12*B))*sqrt(2*Pi/B)/Z;
    end
  else
    begin
      gamma:=0;
      MessageDlg('����� ������� �� ���������� ' , mtWarning, [mbOk], 0);
      Exit;
    end;
end;

function normstat(Sred,SKO:double):MasParam;
 begin
  normstat[0]:=Sred;      //����
  normstat[1]:=Sred;      //�������������� ��������
  normstat[2]:=sqr(SKO);  //���������
      end;

function weibinv(A,B,P:double):extended;
begin
//  if P<1 then Result:=power(1/A*ln(1/(1-P)),1/B)  // = Matlab !!! 2018
//         else Result:=1e10;
  if P>=1 then P:=1-1e-6;
  if P<1 then Result:=B*power(-ln(1-P),1/A)  // = Excel 2022
         else Result:=99999;
            end;

function logninv(MU,SIG,P:double):double;
begin
  logninv:=exp(sqrt(2)*SIG*erfinv((2*P)-1)+MU);
    end;

Procedure Sigmas(var Wei:Mod_Weib;T_pr:double);  // �������� 26.02.2022
var SS,t1,t2,Npriv,Fnorm,FWeib: double;
    i : longint;
begin
  SS:=0;
  if T_Pr=0 then T_pr:=200;  // t ����������

with Wei do begin
        LamStart:= 1000*WeibF(A,B,T_Pr)*K_powtor;  // ������������� ������� �� 1000 � ��� ��������� T_Prirab
        if MasProbl[High(MasProbl)].time>1000 then
     Lam1000:= 1000*WeibF(A,B,1000)*K_powtor///(1-CDF_Gauss(Sred,SKO,1000)) // ����� ��� 1000 � ���������
else Lam1000:= 1000*WeibF(A,B,MasProbl[High(MasProbl)].time)*K_powtor;//(1-CDF_Gauss(Sred,SKO,MasProbl[High(MasProbl)].time));// ��� ������������ t<1000 �
    t1:=0;
for i:=0 to high(MasProbl){-1} do begin
    t2:=MasProbl[i].time;
    Fnorm:=(CDF_Gauss(Sred,SKO,(t1+t2)/2));
    FWeib:=weibCDF2(Wei.A,Wei.B,t1,t2);
    Npriv:=Izd_Prived*Wei.K_powtor*FWeib{/(1-Fnorm)}; // ����� ������� �����������
      SS:=SS+Npriv;                                 // �����
    Wei.SKO_out:=Wei.SKO_out+Sqr(i+1-SS);
     t1:=t2;
        end;
    Wei.SKO_out:= Sqrt(Wei.SKO_out)/high(MasProbl);
end;
end;

Function Pirson(A,B,k_pwt,Mu,Sig:double;var Mpir:Mod_Weib):double;
var Delta2,t1,t2,Kritery_Moy,P_sum,Kol: double;
               i: integer;
  begin
  t1:=0;
  for i:=1 to high(Hist_Stol) do begin
       t2:=Hist_Stol[i].time;
       if i>0 then t1:=Hist_Stol[i-1].time; // dec 2015
   MPir.F_norm[i]:=CDF_Gauss(Mu,Sig,(t2+t1)/2); // dec 2015  // ����������� ���� �������� �� ��������
           end;                                                   // for i:=0 to high(Mdouble_Hystogramm)
    Delta2:=0; MPir.Kol_Nakopl:=0; SK_otkl:=0;
    Kol:=Izd_Prived*k_pwt; //Kol_Izw                         // ������� ���������� ���������
      t1:=0;
 for i:=0 to high(Hist_Stol) do begin                         // �� �������� �����������
  t2:=Hist_Stol[i].time;
  MPir.F_Weib[i]:=weibCDF2(A,B,t1,t2);
  if MPir.F_Weib[i]<0 then MPir.F_Weib[i]:=0;                 // ��������� � ��������� �������}
  MPir.Kol_F_Priv[i]:=Kol*MPir.F_Weib[i]*(1-MPir.F_norm[i]);   // ����� ������� � ������� � ������ ��������������
  MPir.Kol_Nakopl:=MPir.Kol_Nakopl+MPir.Kol_F_Priv[i];
  SK_otkl:=SK_otkl+Sqr((Hist_Stol[i].Sum-MPir.Kol_F_Priv[i]));    // {/(i+1)});
  if Form1.RadioGroup1.ItemIndex=0
      then Delta2:=Delta2+Sqr((Hist_Stol[i].Sum-MPir.Kol_F_Priv[i])/MPir.Kol_F_Priv[i])
  else if Form1.RadioGroup1.ItemIndex=1
     then Delta2:=Delta2+Sqr((Hist_Stol[i].Sum-MPir.Kol_F_Priv[i]))
     else Delta2:=Delta2+Sqr((Hist_Stol[i].Sum-MPir.Kol_F_Priv[i])*(1-MPir.F_Weib[i]));
  t1:=t2;
 end;
  // SK_otkl:=Sqrt(SK_otkl)/Kol_Izw;
   Kritery_Moy:=Delta2+8*Sqr(Kol_Izw-MPir.Kol_Nakopl); //��������� ��������� ������� ��� 2015
   Pirson:=Kritery_Moy;
     end;

Procedure Podbor_Weib_Pirson(Var Arez,Brez:double);
const izm_shag=1.0537;  //������ ���������� ������������� �������� �� �������� �������� �������.
var
B_s,C_s,Big_ZF,Kdiv_Pirs: double;
t1,t2:double;
i,j,n_hist,Np,kk: integer;
A_s,A_max,A_min,h_s,ee,A_sr: array[1..5] of double;
Tim:TDateTime;
label Met;

 Function OutLimit: boolean;
 begin
   if (A_s[j]+h_s[j]<=A_min[j]) or (A_s[j]+h_s[j]>A_max[j]) then Result:=true
   else Result:=false;
     end;

 Function Out_Pirs: boolean;
  var i:integer;
  begin
    Result:=true; for i := 1 to Np do Result:=Result and (Abs(h_s[i])<ee[i]);
        end;

 Procedure ZF(var Big_ZF:double);
  begin
  if (Sred_Opt=false)and(SKO_Opt=false) then Big_ZF:=Pirson(A_s[2],A_s[1],A_s[3],Sred,SKO,MPirsN);
  if (Sred_Opt)and(SKO_Opt=false) then Big_ZF:=Pirson(A_s[2],A_s[1],A_s[3],A_s[4],SKO,MPirsN);
  if (Sred_Opt=false)and(SKO_Opt) then Big_ZF:=Pirson(A_s[2],A_s[1],A_s[3],Sred,A_s[4],MPirsN);
  if (Sred_Opt)and(SKO_Opt) then Big_ZF:=Pirson(A_s[2],A_s[1],A_s[3],A_s[4],A_s[5],MPirsN);
            end;


   Begin
Np:=3;   kk:=0;
Kdiv_Pirs:=StrToFloat(Form1.Edit6.Text);
MPirsN.Sred:=StrToFloat(Form1.MeSred.Text);
MPirsN.SKO :=StrToFloat(Form1.MeSKO.Text);

A_s[1]:=2000;               A_max[1]:=50000;           A_min[1]:=10;//B
A_s[2]:=1;                  A_max[2]:=3;               A_min[2]:=0.5{2e-9};//A
A_s[3]:=KolOtk/Kol_Izd_All; A_max[3]:=30;              A_min[3]:=1; //K_powtor1
h_s[1]:=0.25;               ee[1]:=1e-5;
h_s[2]:=0.001;              ee[2]:=1e-8;
h_s[3]:=0.0005;             ee[3]:=1e-8;

  if Sred_Opt then begin  /////////Sred_Opt
   Np:=4;
   A_s[4]:=500;        A_max[4]:=3000;      A_min[4]:=150; //Sred
   h_s[4]:=1;          ee[4]:=5e-2;
   if SKO_Opt then begin
   Np:=5;
   A_s[5]:=150;        A_max[5]:=900;       A_min[5]:=30;  //SKO
   h_s[5]:=1;          ee[5]:=5e-3;
     end;
       end
     else  /////////////////// Sred_Opt=false
     if SKO_Opt then begin
   Np:=4;
   A_s[4]:=150;        A_max[4]:=900;       A_min[4]:=30; //SKO
   h_s[4]:=5;          ee[4]:=1e-2;
     end;

  N_hist:=high(Hist_Stol)+1;
setlength(MPirsN.F_Weib,n_hist);
setlength(MPirsN.F_Norm,n_hist);
setlength(MPirsN.Kol_F_priv,n_hist);
t1:=0;
 Tim:=Time;
       ZF(Big_ZF);
       B_s:=Big_ZF;
Met:
  for j:=1 to Np do begin
     repeat
        A_sr:=A_s;
        A_s[j]:=A_s[j]+h_s[j];
        ZF(Big_ZF);
        C_s:=B_s;
        B_s:=Big_ZF;
     until (Big_ZF>=C_s) or OutLimit;
    B_s:=C_s;
    A_s:=A_sr;  inc(kk); (* if kk>5e6 then begin izm_shag:=izm_shag+1e-3; goto Met; end; *)
    h_s[j]:=-h_s[j]/Kdiv_Pirs{izm_shag};
    dt:= Time-Tim;
      DecodeTime(dT,th,tm,ts,tms);
      if (ts>0.35*Np*Np) and (Kdiv_Pirs<3) then Kdiv_Pirs:=Kdiv_Pirs*1.075;
                    end; //for j:=1 to Np
      Arez:=A_s[2]; Brez:=A_s[1]; MPirsN.K_Powtor:=A_s[3];
   if (Sred_Opt)and(SKO_Opt=false) then Sred:=A_s[4];
   if (Sred_Opt=false)and(SKO_Opt) then SKO:=A_s[4];
   if (Sred_Opt=true)and(SKO_Opt=true) then begin Sred:=A_s[4]; SKO:=A_s[5]; end;
         MPirsN.A:=Arez;  MPirsN.B:=Brez;
       MPirsN.Executed:=true;  MPirsN.SKO:=SKO;  MPirsN.Sred:=Sred;
       ZF(Big_ZF);
   if Out_Pirs then begin
     MPirsN.Kol_Nakopl:=0;
     MPirsN.SKO_out:=0;
     MPirsN.Unsens:=0; t1:=0;
    for i:=0 to high(Hist_Stol) do begin
      t2:=Hist_Stol[i].time;
  MPirsN.F_Weib[i]:=weibCDF2(MPirsN.A,MPirsN.B,t1,t2);
  MPirsN.F_norm[i]:=(CDF_Gauss(Sred,SKO,(t1+t2)/2));//+CDF_Gauss(Sred,SKO,x1))/2;
  MPirsN.Kol_F_Priv[i]:=Izd_Prived*MPirsN.K_powtor*MPirsN.F_Weib[i]*(1-MPirsN.F_norm[i]);  // Kol:=Izd_Prived*k_pwt
 // MPirsN.SKO_out:=MPirsN.SKO_out+Sqr(Hist_Stol[i].Sum-MPirsN.Kol_F_Priv[i]);
      t1:=t2;
    end;
  Sigmas(MPirsN,T_Prirab);
 // MPirsN.SKO_out:=Sqrt((MPirsN.SKO_out)/(1+high(Hist_Stol))){Kol_Izw};
  Form1.Memo2.Lines.Add('������ ������ �� ������� ������� ������� �������� �� '+TimeToStr(Time-Tim)+'�/���/�');
  Form1.Memo2.Lines.Add(Format('���=%12.10e  Sred=%10.3f SKO=%10.3f', [H_s[2],Sred,SKO]));
  Exit;
                    end;
      {else} Goto Met;
         end;

Procedure Podbor_Weib_Smirnow(Var Arez,Brez:double);//������ 3 ������ ���������� �����-� �������� �� ��������
const Np=3; {����� �������������� ����������}
var
B_s,C_s,Big_ZF,t1,t2,KdivSm:double;
i,j,n_hist: integer;
A_s,A_max,A_min,h_s,ee,A_sr: array[1..Np] of extended;
OutLimit: boolean;
Tim:TDateTime;
label Met;

 Function Smirnow(A,B,K_powt,Mu,Sig:double):double; //������ ��� ������� �������� ���� !!!!!!
  var Delta2,t1,t2,_Kol_Know,y,sum2: double;
      i,j,n_hist: integer;
  begin
   Delta2:=0; t1:=0;  sum2:=0; j:=0;
   for i:=0 to high(MasProbl) do
        if MasProbl[i].time>=1 then
     begin
     t2:=MasProbl[i].time;
   y:=weibCDF2(A,B,t1,t2);      // ����� ���������� x(i)-x(i+1)
  sum2:=sum2+y*(1-MSmirn.F_norm[i])*Izd_Prived*K_powt;
                        //sum2:=sum2+y*(1-CDF_Gauss(Mu,Sig,x2))*Izd_Prived*K_powt;;
  Delta2:=Delta2+Sqr(j+1-Sum2){/(i+1)*i};
                         //  Delta2:=Delta2+Sqr(Ln(i+1)-Ln(Sum2)){*i};
                 t1:=t2;   inc(j);
  end;
   Smirnow:=Sqrt(Delta2)/Kol_Izw+Abs(Sum2-j+1)/200;
     end;

 Procedure OutLimitProc;
     begin
     OutLimit:=false;
       if (A_s[j]+h_s[j]<=A_min[j]) or (A_s[j]+h_s[j]>A_max[j]) then OutLimit:=true;
       end;

begin

A_s[1]:=2000;               A_max[1]:=50000;        A_min[1]:=1;        //B
A_s[2]:=1;                  A_max[2]:=3;            A_min[2]:=0.3{2e-9};//A
A_s[3]:=KolOtk/Kol_Izd_All; A_max[3]:=30;           A_min[3]:=1.01; //K_powtor1
h_s[1]:=0.25;      ee[1]:=1e-5;
h_s[2]:=0.0002;    ee[2]:=1e-7;
h_s[3]:=0.0001;    ee[3]:=1e-8;

KdivSm:=StrToFloat(Form1.Edit5.Text);
setlength(MSmirn.F_norm,high(MasProbl)+1); // ����� ����� ��������� �������
for i:=0 to high(MasProbl) do MSmirn.F_norm[i]:=CDF_Gauss(Sred,SKO,MasProbl[i].time);
N_hist:=high(Hist_Stol)+1;
setlength(MSmirn.F_Weib,n_hist);
setlength(MSmirn.Kol_F_priv,n_hist);
      t1:=0;       Tim:=Time;
      Big_ZF:=Smirnow(A_s[2],A_s[1],A_s[3],Sred,SKO);
      B_s:=Big_ZF;
 Met: for j:=1 to Np do
      begin
       repeat
         A_sr:=A_s;
         A_s[j]:=A_s[j]+h_s[j]; OutLimitProc;
      Big_ZF:=Smirnow(A_s[2],A_s[1],A_s[3],Sred,SKO);
        C_s:=B_s;
        B_s:=Big_ZF;
          until (Big_ZF>=C_s) or (OutLimit);
            B_s:=C_s;
            A_s:=A_sr;
            h_s[j]:=-h_s[j]/KdivSm;
               end; {for j:=1 to Np}
          dt:= Time-Tim;
      DecodeTime(dT,th,tm,ts,tms);
        if KdivSm<3 then begin
           if ts>5 then KdivSm:=KdivSm*1.0875;
        if ts>15 then KdivSm:=KdivSm*1.2875;
           end;
   if (not (Abs(h_s[1])<ee[1]) and (Abs(h_s[2])<ee[2])and (Abs(h_s[3])<ee[3]))
           or (ts<10) then goto Met;
          MSmirn.A:=A_s[2]; MSmirn.B:=A_s[1]; MSmirn.K_powtor:=A_s[3];
          MSmirn.SKO:=SKO; MSmirn.Sred:=Sred;
                t1:=0;
      for i:=0 to high(Hist_Stol) do begin
                t2:=Hist_Stol[i].time;
  MSmirn.F_Weib[i]:=weibCDF2(MSmirn.A,MSmirn.B,t1,t2);
  if MSmirn.F_Weib[i]<0 then MSmirn.F_Weib[i]:=0; //******
  MSmirn.F_norm[i]:=CDF_Gauss(Sred,SKO,(t1+t2)/2);
  MSmirn.Kol_F_Priv[i]:=Izd_Prived*MSmirn.K_powtor*MSmirn.F_Weib[i]*(1-MSmirn.F_norm[i]);
//  MSmirn.SKO_out:=MSmirn.SKO_out+Sqr(Hist_Stol[i].Sum-MSmirn.Kol_F_Priv[i]);
                t1:=t2;
end;
   MSmirn.Executed:=true;
  // MSmirn.Sred:=Sred; MSmirn.SKO:=SKO;
   Sigmas(MSmirN,T_Prirab);
 //  MSmirn.SKO_out:=Sqrt((MSmirn.SKO_out)/Kol_Izw);
   Form1.Memo2.Lines.Add('������ ������ �� �������� �������� �� '+TimeToStr(Time-Tim)+'�/���/�');
   end;

Procedure SpirSp_Execute; {�����. ������� ����������� ������������� ������}
  var
  C_s,B_ss: double;
  A_S, A_sr,A_max,A_min,h_s,ee: array[1..5] of double;
  i, j, Np,N_hist: integer;
   Terminated: boolean;
   dMinF,t1,t2,KdivSpir: double;

 label m2;

 Function Spir_Spusk: boolean;
 var i:integer;
  begin
 Result:=true;
  for i := 1 to Np do Result:=Result and ((Abs(h_s[i])<ee[i]));
        end;

 Procedure ZF(var B_ss:double);
  begin
   if Sred_Opt=false then     // ��� ����������� �������� ������� ��������������
          if SKO_Opt=false then B_ss:=Pirson(A_s[2],A_s[1],A_s[3],Sred,SKO,MPirsS)
                           else B_ss:=Pirson(A_s[2],A_s[1],A_s[3],Sred,A_s[4],MPirsS)
   else if SKO_Opt=false then B_ss:=Pirson(A_s[2],A_s[1],A_s[3],A_s[4],SKO,MPirsS)
                         else B_ss:=Pirson(A_s[2],A_s[1],A_s[3],A_s[4],A_s[5],MPirsS);
                          end;
    begin
Np:=3;
A_s[1]:=1000;               A_max[1]:=50000;           A_min[1]:=10;//B
A_s[2]:=1;                  A_max[2]:=10;              A_min[2]:=0.35{2e-9};//A
A_s[3]:=KolOtk/Kol_Izd_All; A_max[3]:=30;              A_min[3]:=1.01; //K_powtor1

h_s[1]:=0.5;             ee[1]:=1e-7;
h_s[2]:=0.00005;         ee[2]:=1e-8;
h_s[3]:=0.00005;         ee[3]:=1e-8;

 if Sred_Opt then begin  ///// Sred_Opt
   Np:=4;
   A_s[4]:=400;         A_max[4]:=5000;      A_min[4]:=150; //Sred
   h_s[4]:=0.125;       ee[4]:=1e-2;
         if SKO_Opt then begin  // ��� 5
   Np:=5;
   A_s[5]:=100;         A_max[5]:=900;       A_min[5]:=50;  //SKO
   h_s[5]:=0.125;       ee[5]:=1e-2;
      end;
        end
     else      // Sred_Opt=false
     if SKO_Opt then begin
   Np:=4;
   A_s[4]:=100;        A_max[4]:=900;       A_min[4]:=80; //SKO
   h_s[4]:=0.25;          ee[4]:=1e-1;
     end;
N_hist:=high(Hist_Stol)+1;
    setlength(MPirsS.F_Weib,n_hist);
    setlength(MPirsS.F_Norm,n_hist);
    setlength(MPirsS.Kol_F_priv,n_hist);
  C_s := 0;
  B_ss := 0;
  Randomize;      Tim:=Time; KdivSpir:=StrToFloat(Form1.Edit1.Text);
        ZF(B_ss);
        dMinF := Max_Start;
 repeat
      for j := 1 to Np do begin
        repeat
          for i:=1 to Np do A_sr[i]:=A_s[i];
          if A_S[j]+H_s[j]>0 then A_S[j]:=A_S[j]+H_s[j];
          if (A_S[j]>A_max[j]) or (A_S[j]<A_min[j]) then goto m2;
              C_s:=B_ss;
              ZF(B_ss);
      if dMinF > B_ss then dMinF := B_ss;
        until (B_ss > C_s);
  m2:      B_ss:=C_s;
        A_s[j]:=A_sr[j]-H_s[j];
        H_s[j] := -H_s[j]/KdivSpir{1.135};
      end;
      dt:= Time-Tim; DecodeTime(dT,th,tm,ts,tms);
         if KdivSpir<5 then begin
      if ts>0.5*Np*Np then KdivSpir:=KdivSpir*1.0755;
      if ts>2.5*Np*Np then KdivSpir:=KdivSpir*1.755;
         end;
 until (Spir_Spusk) or (ts>10);
   MPirsS.A:=A_s[2]; MPirsS.B:=A_s[1]; MPirsS.K_powtor:=A_s[3];
   if (Sred_Opt) and (SKO_Opt=false) then Sred:=A_s[4];
   if (Sred_Opt=false)and(SKO_Opt)   then SKO:=A_s[4];
   if (Sred_Opt=true)and(SKO_Opt=true) then begin Sred:=A_s[4]; SKO:=A_s[5]; end;
      MPirsS.SKO:=SKO; MPirsS.Sred:=Sred;
      MPirsS.Kol_Nakopl:=0; MPirsS.SKO_out:=0; MPirsS.Unsens:=0;
      t1:=0;
    for i:=0 to high(Hist_Stol) do begin
      t2:=Hist_Stol[i].time;
  MPirsS.F_Weib[i]:=weibCDF2(MPirsS.A,MPirsS.B,t1,t2);
  MPirsS.F_norm[i]:=(CDF_Gauss(Sred,SKO,(t1+t2)/2));//+CDF_Gauss(Sred,SKO,x1))/2;
  MPirsS.Kol_F_Priv[i]:=Izd_Prived*MPirsS.K_powtor*MPirsS.F_Weib[i]*(1-MPirsS.F_norm[i]);  // Kol:=Izd_Prived*k_pwt
//  MPirsS.SKO_out:=MPirsS.SKO_out+Sqr(Hist_Stol[i].Sum-MPirsS.Kol_F_Priv[i]); // ��� �������� ���������
      t1:=t2;
    end;
   MPirsS.Executed:=true;
   MPirsS.Sred:=Sred; MPirsS.SKO:=SKO;
  // MPirsS.SKO_out:=Sqrt((MPirsS.SKO_out)/(1+high(Hist_Stol))){Kol_Izw};  ��� �������� ���������
    Sigmas(MPirsS,T_Prirab);
   Form1.Memo2.Lines.Add('������ ������ �� ������� ������� ����������� ������ �������� �� '+TimeToStr(Time-Tim)+'�/���/�');
   Form1.Memo2.Lines.Add(Format('���=%12.10e  Sred=%10.3f SKO=%10.3f', [H_s[2],Sred,SKO]));
    end;
end.
