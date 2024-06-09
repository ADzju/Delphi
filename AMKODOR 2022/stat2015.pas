unit stat2015;    //Модуль процедур статобработки данных

interface
  uses Out_Graph2015,obrotk2015,Classes,SysUtils,Math, StrUtils, Graphics;

const Max_Start=1e306;

var SRmin,SRmax:double;
    bCopyBest: boolean;
    dMinimumAll: double;
    iMaxBest: integer;

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

  PXromosome = ^Xromosome;        // указатель на хромосому
  PPosGen = ^PosGen;              // указатель на ген

  TGen = class(TThread)           // популяция особей, класс "процесс-поток" для раздельного исполнения
    // private     { Private declarations }
  protected
    SizePopulation: integer;      // Число особей в поколении. Должно быть чётным!!!
    fPCrossingOver: double;       // Вероятность кроссинговера
    fPMutation: double;           // Вероятность мутации
    ListPopulation: TList;        // Список популяции
    ListBest: TList;
    ListGens: TList;
    AXrome: PXromosome;
    AGen: PPosGen;                // указатель позиции гена  AGen.gStart, AGen.gLenght
    LengthXrome: integer;         // Длина хромосомы
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
Function  weibpdf (A,B,X:double):double;
Function  weibCDF (A,B,X:double):double;     //интегральная функция распр по закону Вейбулла
Function  weibCDF2(A,B,X1,X2:double):double; //вероятность попадания в диапазон х1...х2
Procedure Podbor_Weib_Pirson(Var Arez,Brez:double);
Procedure Podbor_Weib_Smirnow(Var Arez,Brez:double);
Function  CDF_Gauss(Sred,SKO,X:double):double;
Function  weibstat(A,B:double):MasParam;
Function  weibinv(A,B,P:double):extended;
Function  normstat(Sred,SKO:double):MasParam;
//Procedure sort_puz ( Var z:Mas12);
Procedure sort_MinMax ( Var z: array of Problems);
Procedure hist; //*************
Procedure Hist_Made(A,B:double;Kpowt:double; var Mas_Model_Hist:RealArray; var N_Nakopl,SKO_:double);
Procedure Kolmogor(Kpwt,A,B,Mu,Sig:double; var Kolm:double;var S:string);

implementation
uses windows,Dialogs;


type
  MyFunc=function(MU,SIG,X:double):double;
  MyFuncX=function(X:double):double;


function ErfC(X : double):double;  //библиотека AlgLib
var
    P : double;
    Q : double;
begin
    if (X<0) then begin
        Result := 2-ErfC(-X);
        Exit;
    end;
    if (X<0.5) then begin
        Result := 1.0-Erf(X);
        Exit;
    end;
    if(X>=10) then begin
        Result := 0;
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
    Result := Exp(-Sqr(X))*P/Q;
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
        Result := S*1.1283791670955125738961589031*X*P/Q;
        Exit;
    end;
    if X>10 then begin
        Result := S;
        Exit;
    end;
    Result := S*(1-ErfC(X));
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
    Result := 0.5*(Erf(x/1.41421356237309504880)+1);
end;

Function NormCDF (X:double):double; //значение интегральной функции распределения
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
             else if x<-6 then normCDF:=-1e-12/x;
           end;
       end;

Function CDF_Gauss(Sred,SKO,X:double):double;
var x_priv,t: double;
begin
x_priv:=(x-Sred)/SKO;
t:=normcdf(x_priv);
t:=NormalDistribution(x_priv);
CDF_Gauss:=t;
//CDF_Gauss:=erf(x_priv);
end;

Function WeibCDF(A,B,X:double):double; //интегральная вероятность - закон Вейбулла
var wcdf:double;
begin
if (A<=0) or (B<=0) then begin
     weibcdf:=1e-305;
      end
     else
 wcdf :=1-exp(-A*power(X,B));
 if wcdf>0 then Result:=wcdf
           else Result:=1e-305;
        end;

Function WeibCDF2(A,B,X1,X2:double):double; //вероятность попадания в х1...х2
var
wcdf2:double;
begin
if x2<x1 then
  begin
    MessageBox(GetActiveWindow, PWideChar('Параметры должны быть x2>x1'),
          PWideChar('ObrOtk'), MB_OK or MB_ICONHAND );
      Exit; end;
        Result := weibCDF(A,B,x2)-weibCDF(A,B,x1);
        if Result<0 then Result:=1e-305;
end;

Procedure Kolmogor(Kpwt,A,B,Mu,Sig:double; var Kolm:double;var S:string);
var Dmax,Fx,Ft,f1,f2,Fsum,t_z50:double;
    no50:boolean;
    i,k: integer;
begin
 Dmax:=0; Fx:=0;  f1:=0;  no50:=true;  Fsum:=0;
 k:=high(MasProbl);
 for i:=0 to k{high(MasProbl)} do begin
Fx:=Fx+1/(k+1);
f2:=WeibCDF(A,B,MasProbl[i].time);
// MGenet.Kol_F_Priv[i]:=Izd_Prived*k_pwt*MGenet.F_Weib[i]*(1-MGenet.F_norm[i]);
Fsum:=Fsum+(f2-f1)*(1-CDF_Gauss(Mu,Sig,MasProbl[i].time));
Ft:=Fsum*Izd_Prived*Kpwt/Kol_izw;
if no50 and (Ft>0.5) then begin
t_z50:=MasProbl[i].time; no50:= false; end;
    f1:=f2;
if Abs(Fx-Ft)>Dmax then Dmax:=Abs(Fx-Ft);
 end;
  Kolm:=Dmax*Sqrt(k+1);
  if Kolm<1.3581 then S:=' <1.3581(0.05)' else S:=' >1.3581(0.05)';
     end;


Function Pirson_Gen(A,B,k_pwt,Mu,Sig:double):double;
var Delta2,x1,x2,Kritery_Moy: double;
                           i: integer;
  begin
  x1:=0; //if k_pwt<1 then k_pwt:=1;

for i:=0 to high(Hist_Arr) do begin   // предварительно для каждого столбца гистограммы
 x2:=Hist_Arr[i].time;
 MGenet.F_norm[i]:=CDF_Gauss(Mu,Sig,(x1+x2)/2);   // накопление выхода из наблюдения (цензурирования)
     x1:=x2;
            end;   // for i:=0 to high(Mdouble_Hist)
    Delta2:=0; MGenet.Kol_Nakopl:=0; MGenet.SKO_out:=0;
    //Kol:=Izd_Prived*k_pwt;               //Kol_Izw
   x1:=0;
   for i:=0 to high(Hist_Arr) do      //по столбцам гистограммы
          begin
  x2:=Hist_Arr[i].time;
  MGenet.F_Weib[i]:=weibCDF2(A,B,x1,x2);   //генерация в интервале столбца
  MGenet.Kol_F_Priv[i]:=Izd_Prived*k_pwt*MGenet.F_Weib[i]*(1-MGenet.F_norm[i]); //приведенное к известным число отказов модели в столбце
  MGenet.Kol_Nakopl:=MGenet.Kol_Nakopl+MGenet.Kol_F_Priv[i];
  MGenet.SKO_out:=MGenet.SKO_out+Sqr((Hist_Arr[i].Sum-MGenet.Kol_F_Priv[i]){/(i+1)});
  Delta2:=Delta2+Sqr((Hist_Arr[i].Sum-MGenet.Kol_F_Priv[i]))*MGenet.F_Weib[i];
     x1:=x2;
           end;
   MGenet.SKO_out:=Sqrt(MGenet.SKO_out)/Kol_Izw;  // Среднее кв отклонение - отнесено к известным отказам!
   Kritery_Moy:=Delta2+Sqr(Kol_Izw-MGenet.Kol_Nakopl);
   if k_pwt>(Alim[1,3]+Alim[2,3]) then Kritery_Moy:=Kritery_Moy*Sqr(k_pwt/(Alim[1,3]+Alim[2,3]));
   Pirson_Gen:=Kritery_Moy;

  end;

Function CelevFunction: double;
var
k, i, N_hist: integer;
     begin
    N_hist:=high(Hist_Arr)+1;
setlength(MGenet.F_Weib,N_hist);
setlength(MGenet.F_Norm,N_hist);
setlength(MGenet.Kol_F_priv,N_hist);
  Randomize;    //  Tim:=Time;
 if (Sred_Opt=false)and(SKO_Opt=false) then Result:=Pirson_Gen(Ao[2],Ao[1],Ao[3],Sred,SKO) else
 if (Sred_Opt)and(SKO_Opt=false) then Result :=Pirson_Gen(Ao[2],Ao[1],Ao[3],Ao[4],SKO) else
 if (Sred_Opt=false)and(SKO_Opt) then Result :=Pirson_Gen(Ao[2],Ao[1],Ao[3],Sred, Ao[4])
                                 else Result :=Pirson_Gen(Ao[2],Ao[1],Ao[3],Ao[4],Ao[5]);
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

{ Класс TGen *********************************************************************}
procedure TGen.XromeToA(sXrome: AnsiString);  // извлечение Ao[j]
var j: integer;
  begin
  for j := 1 to iop do
Ao[j]:=Abs(NormA[j]*BinToInt(Copy(sXrome, PPosGen(ListGens.Items[j-1])^.gStart, PPosGen(ListGens.Items[j-1])^.gLength)));
            end;

procedure TGen.CrossingOver(iNumPokolenie: integer);//в ListPopulation добавляются особи поколения iNumPokolenie
var  i,iX1, iX2, iCrossX, Nx: integer;
  begin
   Nx:=round(ListPopulation.Count*fPCrossingOver); // к-во скрещиваний с учетом заданной интенсивности
          for i := 1 to Nx do begin
    iX1 := Round(Random*((ListPopulation.Count)/2));                        // экземпляр из нижней половины
    iX2 := ListPopulation.Count-1-Round(Random*((ListPopulation.Count)/2)); // экземпляр из верхней половины
    iCrossX := 1+Round(Random*(LengthXrome-2));                             // точка скрещивания (не в начале и конце)
            New(AXrome);
    AXrome^.sX := Copy(PXromosome(ListPopulation.Items[iX1])^.sX, 1, iCrossX); //вырезаем из iX1 до точки iCrossX
    AXrome^.sX := AXrome^.sX + Copy(PXromosome(ListPopulation.Items[iX2])^.sX, iCrossX+1, LengthXrome-iCrossX); //добавляем
    XromeToA(AXrome^.sX);
    AXrome^.Celev_F := CelevFunction;
    AXrome^.Pokolenie := iNumPokolenie;
    ListPopulation.Add(AXrome);           // добавим хромосому AXrome поколения iNumPokolenie с CelevFunction
    New(AXrome);
    AXrome^.sX := Copy(PXromosome(ListPopulation.Items[iX2])^.sX, 1, iCrossX);  //вырезаем из iX2 в точке iCrossX
    AXrome^.sX := AXrome^.sX + Copy(PXromosome(ListPopulation.Items[iX1])^.sX, iCrossX+1, LengthXrome-iCrossX); //добавляем
    XromeToA(AXrome^.sX);
    AXrome^.Celev_F := CelevFunction;
    AXrome^.Pokolenie := iNumPokolenie;
    ListPopulation.Add(AXrome);
 //   if (Form1.CheckBoxProm.Checked) then Form1.Memo2.Lines.Add(Format('F= %-8.3f S2',[AXrome^.Celev_F]));
      end;
       end;

procedure TGen.Mutation;
var
  i, j, k: integer;
  iBitMut1: integer;
Begin
  for i := 1 to Round(SizePopulation * fPMutation) do
  begin
         iBitMut1 := 1+Round(Random * (LengthXrome-1)); // позиция мутации
    j := Round(Random * (SizePopulation - 1));
      if PXromosome(ListPopulation.Items[j])^.sX[iBitMut1] = '0'
    then PXromosome(ListPopulation.Items[j])^.sX[iBitMut1]:= '1'
    else PXromosome(ListPopulation.Items[j])^.sX[iBitMut1]:= '0';
       XromeToA(PXromosome(ListPopulation.Items[j])^.sX);
        PXromosome(ListPopulation.Items[j])^.Celev_F := CelevFunction;
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

procedure TGen.DestroyBad(iNumOsobey: integer);//сокращение популяции до iNumOsobey со стороны худших
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

procedure TGen.DestroyPopulation(iNumPokolenie: integer); // выборочно уничтожить поколение
var
  i: integer;
begin
  for i := ListPopulation.Count - 1 downto 0 do
  begin
    if PXromosome(ListPopulation.Items[i])^.Pokolenie = iNumPokolenie then
    begin
      Dispose(PXromosome(ListPopulation.Items[i])); // уничтожение особей
      ListPopulation.Delete(i);
    end;
  end;
  if ListPopulation.Count = 0 then                  // когда особей не осталось
    for i := ListGens.Count - 1 downto 0 do
    begin
      Dispose(PPosGen(ListGens.Items[i]));          // уничтожение генов
      ListGens.Delete(i);
    end;
end;

procedure TGen.MakePopulation;   // начало популяции
var
  i, j, i1, j1 : integer;
  APrevGen: PPosGen;
begin
    for j := 1 to iop do
    begin
      New(AGen);                                     // новый ген
      try       //*****
        APrevGen := ListGens.Last;
        AGen^.gStart := APrevGen^.gStart + APrevGen^.gLength;
      except
        AGen^.gStart := 1;                           // 0 1 исключение - начало первого гена
      end;   //try
       AGen^.gLength := iGetBits(Round(1/Precision)); //длина гена
       ListGens.Add(AGen);
    end;

  for i := 1 to SizePopulation do
  begin
    New(AXrome);                          // хромосома
    AXrome^.sX := '';
      for j1 := 1 to iop do
      begin
        AGen := ListGens.Items[j1-1];        // j1-1-й ген
        Ao[j1] := Alim[1,j1]+Random * Alim[2,j1];      // случайное значение параметра Ao[j1]
        AXrome^.sX := AXrome^.sX + IntToBin(Round(Ao[j1]/NormA[j1]), AGen^.gLength);  // хромосома из генов
      end;                                //  цикл iop
    AXrome^.Celev_F := CelevFunction;
    AXrome^.Pokolenie := 1;                //1-е новое поколение
    ListPopulation.Add(AXrome);
   end;                                    // цикл i to SizePopulation
    LengthXrome := Length(AXrome^.sX);     // размер строки-хромосомы
      end;

procedure TGen.UpdMain;
var
  i, j, k,i1,j1: integer;
  AGenTmp: PPosGen;
begin
  k := 0;
 Form1.Memo2.Lines.Add('Создано генов '+FloatToStr(ListGens.Count));
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
    for i := 0 to iCopy do   // Скопировать лучшие
    begin
      New(AXrome);
      AXrome^.sX := PXromosome(ListBest.Items[i])^.sX;
      AXrome^.Celev_F := PXromosome(ListBest.Items[i])^.Celev_F;
      AXrome^.Pokolenie := iNPokolenie;
      ListPopulation.Add(AXrome);
    end;
    while ListBest.Count > 0 do  // Удалить все лучшие
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
  SizePopulation := 2*StrToInt(Form1.Edit3.Text) div 2; //четное !!!
//  SizePopulation :=2*(SizePopulation div 2);
  ListPopulation := TList.Create;
  ListGens := TList.Create;
  ListBest := TList.Create;
  iMaxBest := StrToInt(Form1.NPokoleny.Text);     //----------------------------------
 try
    Randomize;
    MakePopulation;
 //   Synchronize(UpdMain);
    iNPokolenie := 1;// 0;
    dMinimumAll := 1e306;

 try
    repeat
      if Abs(fPCrossingOver - (Form1.TrackBar1.Position / 100)) > 0.01 then
         begin
        fPCrossingOver := Form1.TrackBar1.Position / 101;
     //  Form1.Memo2.Lines.Add(Format('Скрещиваний %4.2f', [fPCrossingOver]));
          end
         else begin
       fPCrossingOver:=0.45*Abs(sin(1-8*iNPokolenie/iMaxBest));
                  Form1.TrackBar1.Position:=round(101*fPCrossingOver);
         end;
      if Abs(fPMutation - (Form1.TrackBar2.Position / 100)) > 0.01 then
      begin
        fPMutation := Form1.TrackBar2.Position / 101;
      //  Form1.Memo2.Lines.Add(Format('Мутаций %4.2f', [fPMutation]));
      end
      else begin
      fPMutation:=0.5*Abs(sin(-0.025+12*iNPokolenie/iMaxBest{273}));
    //  fPMutation:=Abs(0.8-fPCrossingOver);
       Form1.TrackBar2.Position:=round(101*fPMutation);
      end;
      if bCopyBest then
      begin
        bCopyBest := False;
        Form1.Memo2.Lines.Add('Копирование лучших');
        MoveBest(iNPokolenie);
      end;
          if (Abs(iNPokolenie/iMaxBest-0.8)<2e-4)
          or (Abs(iNPokolenie/iMaxBest-0.6)<2e-4)
          or (Abs(iNPokolenie/iMaxBest-0.2)<2e-4)
              then bCopyBest := true;

      ListPopulation.Sort(SortPopulation);

     if ListPopulation.Count > 0 then
      if PXromosome(ListPopulation.First)^.Celev_F < dMinimumAll then
        begin
         dMinimumAll := PXromosome(ListPopulation.First)^.Celev_F;  // начальные условия оптимизации
         XromeBest := PXromosome(ListPopulation.First)^.sX;
         XromeToA(PXromosome(ListPopulation.First)^.sX);
         Aopt := Ao;
     Form1.Memo2.Lines.Add('Улучшение: '+Format(' ЦФ=%-9.5f A1=%-9.6f A2=%-9.7f  A3=%-9.6f',[CelevFunction,Aopt[1],Aopt[2],Aopt[3]]));
        end;   // Format('%10.8f',[B])

      New(AXrome);
      AXrome^.sX := PXromosome(ListPopulation.First)^.sX;
      AXrome^.Celev_F := PXromosome(ListPopulation.First)^.Celev_F;
      AXrome^.Pokolenie := iNPokolenie;
      ListBest.Add(AXrome);
   if iMaxBest > ListBest.Count then
        Form1.NPokoleny.Text := FloatToStr(ListBest.Count)    //******* почему
      else
        Form1.NPokoleny.Text := FloatToStr(iMaxBest);

  // if Form1.CheckBoxProm.Checked then Synchronize(UpdMain);
     CrossingOver(iNPokolenie+1);
     ListPopulation.Sort(SortPopulation);    //
     DestroyBad(SizePopulation);     //++++++++
      Inc(iNPokolenie);
      Mutation;
      Form1.ProgressBar2.Position:=Round(100*iNPokolenie/iMaxBest);
    until Stop_Gen{Terminated} or (iNPokolenie>iMaxBest);
except
   Form1.Memo2.Lines.Add('Исключительная ситуация!');
    end;  //   ***************
     //DestroyBad(SizePopulation div 18);//
     DestroyBad((SizePopulation div 4){0}); // 08.02.2015
 finally
   Ao := Aopt;
    MGenet.Executed:=true;
    MGenet.A:=Ao[2]; MGenet.B:=Ao[1]; MGenet.K_Powtor:=Ao[3];

 if (Sred_Opt)and(SKO_Opt=false) then Sred:=Ao[4];
 if (Sred_Opt=false)and(SKO_Opt) then SKO :=Ao[4];
 if (Sred_Opt)and(SKO_Opt) then begin Sred:=Ao[4]; SKO:=Ao[5]; end;
    MGenet.SKO:=SKO; MGenet.Sred:=Sred; MGenet.SKO_Out:=SKO;
    x1:=0;
 MGenet.Unsens:=0;  MGenet.Kol_Nakopl:=0;
 for i:=0 to high(Hist_Arr) do begin
    x2:=Hist_Arr[i].time;
 MGenet.F_norm[i]:=CDF_Gauss(MGenet.Sred,MGenet.SKO,(x1+x2)/2);
 MGenet.F_Weib[i]:=weibCDF2(MGenet.A,MGenet.B,x1,x2);                                    //генерация в интервале столбца
 MGenet.Kol_F_Priv[i]:=Izd_Prived*MGenet.K_powtor*MGenet.F_Weib[i]*(1-MGenet.F_norm[i]); //приведенное число отказов модели в столбце
     x1:=x2;
        end;

    ListBest.Free;
    ListPopulation.Free;
    ListGens.Free;
   Hist_Made(MGenet.A,MGenet.B,MGenet.K_powtor,Mas_Out_Like,Kol_Nakopl_Like,MGenet.SKO_out);
     Diagrams;
              end;
                 end;

procedure sort_MinMax (Var z: array of Problems); //сортировка массива по возрастанию методом пузырька
Var
a,b:problems;
i,j:integer;
begin
for j:=0 to high(z) do
  for i:=0 to high(z)-1 do
   if z[i].time>z[i+1].time then
    begin
     a:=z[i];      //  b:=z[2,i];
     z[i]:=z[i+1]; //z[2,i]:=z[2,i+1];
     z[i+1]:=a;    //
    end;
end;

function WeibPDF(A,B,X:double):double; //плотность распределения вероятностей по закону Вейбулла
  var wpdf:double;
begin
if (A<=0) or (B<=0) then begin
    MessageBox(GetActiveWindow, PWideChar('А и B должны быть >0'),
          PWideChar('ObrOtk'), MB_OK or MB_ICONHAND );
            Exit; end;
    Result := A*B*power(x,(b-1))*exp(-A*power(X,B));
  if Result<0 then Result:=1e-99;
          end;

Procedure hist;
Var
i,i2,j,k,Ngis:integer;
graniza,x2:double;
label Menshe;
  begin
 //  graniza:=0;
     D_Hist1:=100;
       Case round(MasProbl[high(MasProbl)].time)of
          1..600:    D_Hist2:=100;
        601..1600:   D_Hist2:=100;
       1601..2300:   D_Hist2:=100;
       2301..90000:  D_Hist2:=200;
                     End;
Menshe:  Ngis:=1;                // число столбцов гистограммы
         setlength(Hist_Arr,0);  // обнуление массива диаграммы
           for i := 0 to 10 do begin
           Sum_PrichCol[i]:=0; Sum_PrichRow[i]:=0;
           end;
i := 0;  j:=0;  k:=0;   x2:=0;
         repeat    // 111
         setlength(Hist_Arr,Ngis);
           repeat  //222
        if Ngis<9 then x2:=x2+D_Hist1    // первые столбцы диаграммы с интервалом D_Hist1, далее D_Hist2
                  else x2:=x2+D_Hist2;
                        {for i2 := 0 to 12 do}
          while (j<=high(MasProbl)) and (MasProbl[j].time<x2+1e-1) do begin // попадание в предел массива и в столбец
    if (MasProbl[j].chey)=0 then Hist_Arr[k].Nund:=Hist_Arr[k].Nund+1
                            else Hist_Arr[k].Npr[round(MasProbl[j].chey)]:=Hist_Arr[k].Npr[round(MasProbl[j].chey)]+1;
                          inc(j);
                      end;
           Hist_Arr[k].Sum:=j-i; //общее число отказов в интервале
           until (j-i>0) or (x2>=MasProbl[high(MasProbl)].time);  //222    true=>выход
        Hist_Arr[k].time:=x2;
        inc(Ngis);
         for I2 := 1 to Mx_prich do Sum_PrichCol[i2]:=Sum_PrichCol[i2]+Hist_Arr[k].Npr[i2];
              inc(k);
         i:=j;
         // inc(Num);
     until x2>=MasProbl[high(MasProbl)].time; // 111
  if (j>70) and (high(Hist_Arr)<10) then
   begin D_Hist1:= D_Hist1 div 2;
         setlength(Hist_Arr,0);
      goto Menshe;
            end;
if high(Hist_Arr)>30 then begin
        D_Hist2:= 2*D_Hist2;
          setlength(Hist_Arr,0);
      goto Menshe;
            end;
         end;

Procedure Hist_Made(A,B:double;Kpowt:double; var Mas_Model_Hist:RealArray; var N_Nakopl,SKO_:double);
//возвращает массив, значения которого указывают кол-во элементов модели с распределением Вейбулла
Var
i,n:integer;
x1,x2:double;
Razn:RealArray;
  begin
 n:=high(Hist_Arr)+1;                   {число столбцов гистограммы}
 setlength(Mas_Model_Hist,n); setlength(Razn,n);
         x1:=0; N_Nakopl:=0; SKO_:=0;
  for i:=0 to high(Hist_Arr) do begin    // цикл по столбцам 7777
         x2:=Hist_Arr[i].time;
 //Mas_Model_Hist[i]:=Izd_Prived*Kpowt*weibCDF2(A,B,x1,x2)*(1-((CDF_Gauss(Sred,SKO,x2)+CDF_Gauss(Sred,SKO,x1))/2));  //модель "известных" отказов
  Mas_Model_Hist[i]:=Izd_Prived*Kpowt*weibCDF2(A,B,x1,x2)*(1-(CDF_Gauss(Sred,SKO,x2)));  //модель "известных" отказов - оценка справа
//MGenet.Kol_F_Priv[i]:=Izd_Prived*k_pwt*MGenet.F_Weib[i]*(1-MGenet.F_norm[i]);
   N_Nakopl:=N_Nakopl+Mas_Model_Hist[i];
    Razn[i]:=Hist_Arr[i].Sum-Mas_Model_Hist[i];
   SKO_:=SKO_+Sqr(Razn[i]{/high(Mas_Otkazov[1])});
      x1:=x2;
    end;
 SKO_:=Sqrt(SKO_/n);
 Form1.Memo2.Lines.Add('Доверительный 95% интервал модели '+Format('= %6.4f,  СКО= %6.4f', [1.96*SKO_, SKO_]))
     end;

Function PodIntLogCDF(MU,SIG,t:double):double;
  begin
    Result:=exp(-(sqr(Ln(t)-MU))/(2*sqr(SIG)))/ t;
  end;


function erfinv(t:double):double;   //вычисляет обратную функцию ошибки при -1<t<=0
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
   MessageDlg('Ошибка вычисления функции erfinv ' , mtWarning, [mbOk], 0);
          halt;
    end;
end;



function gamma(x:double):double; //Вычисление Гамма функции с погрешностью 1*10^-5 Г(х)
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
      MessageDlg('Гамма функция не определена ' , mtWarning, [mbOk], 0);
      Exit;
    end;
end;

function weibstat(A,B:double):MasParam;
begin
  if B>1 then weibstat[0]:=power(((1-1/B)/A),(1/B))                   //Мода
         else weibstat[0]:=0;
  weibstat[1]:=(power(A,-1/B))*(gamma(1+(1/B)));                      //Математическое ожидание
  weibstat[2]:=(power(A,-2/B))*(gamma(1+(2/B))-sqr(gamma(1+(1/B))));  //Дисперсия

end;

function normstat(Sred,SKO:double):MasParam;
 begin
  normstat[0]:=Sred;      //Мода
  normstat[1]:=Sred;      //Математическое ожидание
  normstat[2]:=sqr(SKO);  //Дисперсия
      end;

function weibinv(A,B,P:double):extended;
begin
  if P<1 then Result:=power((1/A)*ln(1/(1-P)),1/B)
         else Result:=1e10;
   end;

function logninv(MU,SIG,P:double):double;
begin
  logninv:=exp(sqrt(2)*SIG*erfinv((2*P)-1)+MU);
    end;


Procedure Potok08;
var i,i1 :integer;
    x1,x2:double;
begin
  x2:=0;
  for i:=0 to high(MasProbl) do
     if MasProbl[i].time>=0.2*Sred then
     begin
    x1:=MasProbl[i].time;
    for I1 := 1 to 10 do  // номера видов отказов
    if Sum_PrichRow[i1]>0 then x2:=x2+1/(1-CDF_Gauss(Sred,SKO,x1));
  end;
    Pot08:=x2/(0.8*Sred)/(Kol_Izw/Popravka_Unknow);
end;


Function Pirson(A,B,k_pwt,Mu,Sig:double;Mpir:Mod_Weib):double;
var Delta2,x1,x2,Kritery_Moy,P_sum,Kol: double;
               i: integer;
  begin
  x1:=0;
  for i:=0 to high(Hist_Arr) do begin
       x2:=Hist_Arr[i].time;
       if i>0 then x1:=Hist_Arr[i-1].time; // dec 2015
   MPir.F_norm[i]:=CDF_Gauss(Mu,Sig,(x2+x1)/2); // dec 2015  // накопленная доля выбывших по столбцам
           end;                                                   // for i:=0 to high(Mdouble_Hystogramm)
    Delta2:=0; MPir.Kol_Nakopl:=0; SK_otkl:=0;
    Kol:=Izd_Prived*k_pwt; //Kol_Izw                         // считаем количество известных
      x1:=0;
 for i:=0 to high(Hist_Arr) do begin                         // по столбцам гистограммы
  x2:=Hist_Arr[i].time;
  MPir.F_Weib[i]:=weibCDF2(A,B,x1,x2);
  if MPir.F_Weib[i]<0 then MPir.F_Weib[i]:=0;                 // генерация в интервале столбца}
  MPir.Kol_F_Priv[i]:=Kol*MPir.F_Weib[i]*(1-MPir.F_norm[i]);   // число отказов в столбце с учетом цензурирования
  MPir.Kol_Nakopl:=MPir.Kol_Nakopl+MPir.Kol_F_Priv[i];
  SK_otkl:=SK_otkl+Sqr((Hist_Arr[i].Sum-MPir.Kol_F_Priv[i]));    // {/(i+1)});
  if Form1.RadioGroup1.ItemIndex=0
      then Delta2:=Delta2+Sqr((Hist_Arr[i].Sum-MPir.Kol_F_Priv[i])/MPir.Kol_F_Priv[i])
  else if Form1.RadioGroup1.ItemIndex=1
     then Delta2:=Delta2+Sqr((Hist_Arr[i].Sum-MPir.Kol_F_Priv[i]))
     else Delta2:=Delta2+Sqr((Hist_Arr[i].Sum-MPir.Kol_F_Priv[i])*MPir.F_Weib[i]);
  x1:=x2;
 end;
  // SK_otkl:=Sqrt(SK_otkl)/Kol_Izw;
   Kritery_Moy:=Delta2+Sqr(Kol_Izw-MPir.Kol_Nakopl); //сравнение известных отказов дек 2015
   Pirson:=Kritery_Moy;
      end;

Procedure Podbor_Weib_Pirson(Var Arez,Brez:double); //подбор параметров распределения Вейбулла по критерию Пирсона.
const izm_shag=1.0537;
var
B_s,C_s,Big_ZF,Kdiv_Pirs: double;
x1,x2:double;
i,j,n_hist,Np,kk: integer;
A_s,A_max,A_min,h_s,ee,A_sr: array[1..5] of double;
Tim:TDateTime;
label Met;

 Function limit: boolean;
 begin
   if (A_s[j]+h_s[j]<=A_min[j]) or (A_s[j]>A_max[j]) then Result:=true
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
Np:=3;   kk:=0;     Kdiv_Pirs:=StrToFloat(Form1.Edit6.Text);
A_s[2]:=0.00005;    A_max[2]:=0.1;       A_min[2]:=1e-9;//B
A_s[1]:=1.0;        A_max[1]:=2;         A_min[1]:=1e-2;//A
A_s[3]:=1.0;        A_max[3]:=30;        A_min[3]:=0.1; //K_powtor
h_s[2]:=0.000005;    ee[2]:=1e-10;
h_s[1]:=0.001;       ee[1]:=1e-8;
h_s[3]:=0.001;       ee[3]:=1e-8;

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

  N_hist:=high(Hist_Arr)+1;
setlength(MPirsN.F_Weib,n_hist);
setlength(MPirsN.F_Norm,n_hist);
setlength(MPirsN.Kol_F_priv,n_hist);
x1:=0;
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
    until (Big_ZF>=C_s) or limit;
    B_s:=C_s;
    A_s:=A_sr;  inc(kk); (* if kk>5e6 then begin izm_shag:=izm_shag+1e-3; goto Met; end; *)
    h_s[j]:=-h_s[j]/Kdiv_Pirs{izm_shag};
     end;                    ///////for j:=1 to Np
      Arez:=A_s[2]; Brez:=A_s[1]; MPirsN.K_Powtor:=A_s[3];
   if (Sred_Opt)and(SKO_Opt=false) then Sred:=A_s[4];
   if (Sred_Opt=false)and(SKO_Opt) then SKO:=A_s[4];
   if (Sred_Opt=true)and(SKO_Opt=true) then begin Sred:=A_s[4]; SKO:=A_s[5]; end;
       MPirsN.Executed:=true;  MPirsN.SKO:=SKO;  MPirsN.Sred:=Sred;
  if Out_Pirs then begin
    MPirsN.Kol_Nakopl:=0; MPirsN.SKO_out:=0;
 MPirsN.Unsens:=0; x1:=0;
    for i:=0 to high(Hist_Arr) do begin
      x2:=Hist_Arr[i].time;
  MPirsN.F_Weib[i]:=weibCDF2(MPirsN.A,MPirsN.B,x1,x2);
  MPirsN.F_norm[i]:=(CDF_Gauss(Sred,SKO,(x1+x2)/2));//+CDF_Gauss(Sred,SKO,x1))/2;
  MPirsN.Kol_F_Priv[i]:=Izd_Prived*MPirsN.K_powtor*MPirsN.F_Weib[i]*(1-MPirsN.F_norm[i]);  // Kol:=Izd_Prived*k_pwt
  MPirsN.SKO_out:=MPirsN.SKO_out+Sqr(Hist_Arr[i].Sum-MPirsN.Kol_F_Priv[i]);
      x1:=x2;
    end;
  MPirsN.SKO_out:=Sqrt((MPirsN.SKO_out)/(1+high(Hist_Arr))){Kol_Izw};
  Form1.Memo2.Lines.Add('Расчёт модели по Пирсону методом Ньютона выполнен за '+TimeToStr(Time-Tim)+'ч/мин/с');
  Exit; end;
      {else} Goto Met;
         end;

Procedure Podbor_Weib_Smirnow(Var Arez,Brez:double);//подбор параметров распр-я Вейбулла по Смирнову
const Np=3; {число оптимизируемых параметров}
var
B_s,C_s,Big_ZF,x1,x2,KdivSm:double;
i,j,n_hist: integer;
A_s,A_max,A_min,h_s,ee,A_sr: array[1..Np] of extended;
limit: boolean;
Tim:TDateTime;
label Met;

 Function Smirnow(A,B,K_powt,Mu,Sig:double):double; //оценка для каждого элемента ряда !!!!!!
  var Delta2,x1,x2,_Kol_Know,y,sum2: double;
      i,n_hist: integer;
  begin
   Delta2:=0; x1:=0;  sum2:=0;
   for i:=0 to high(MasProbl) do
     begin
    x2:=MasProbl[i].time;
  y:=weibCDF2(A,B,x1,x2);      //генерация в интервале между элементами x(i)-x(i+1)
  sum2:=sum2+y*(1-MSmirn.F_norm[i])*Izd_Prived*K_powt;;
  Delta2:=Delta2+Sqr(i+1-Sum2){/(i+1)*i};  // Delta2:=Delta2+Sqr(Ln(i+1)-Ln(Sum2)){*i};
    x1:=x2;
  end;
   Smirnow:=Sqrt(Delta2)/Kol_Izw;
     end;

 Procedure limit1;
     begin
     limit:=false;
       if (A_s[j]+h_s[j]<=A_min[j]) or (A_s[j]>A_max[j]) then limit:=true;
       end;

begin
A_s[1]:=0.0005;     A_max[1]:=0.01;      A_min[1]:=1e-10;
A_s[2]:=1.15;       A_max[2]:=3;         A_min[2]:=3e-1;
A_s[3]:=1.0;        A_max[3]:=30;        A_min[3]:=0.1; //Kpowtor
h_s[1]:=0.00005;    ee[1]:=1e-9;
h_s[2]:=0.001;       ee[2]:=1e-7;
h_s[3]:=0.001;       ee[3]:=1e-7;
KdivSm:=StrToFloat(Form1.Edit5.Text);
setlength(MSmirn.F_norm,high(MasProbl)+1); // равно числу известных отказов
for i:=0 to high(MasProbl) do MSmirn.F_norm[i]:=CDF_Gauss(Sred,SKO,MasProbl[i].time);
N_hist:=high(Hist_Arr)+1;
setlength(MSmirn.F_Weib,n_hist);
setlength(MSmirn.Kol_F_priv,n_hist);
      x1:=0;       Tim:=Time;
      Big_ZF:=Smirnow(A_s[1],A_s[2],A_s[3],Sred,SKO);
      B_s:=Big_ZF;
 Met: for j:=1 to Np do
      begin
       repeat
         A_sr:=A_s;
         A_s[j]:=A_s[j]+h_s[j]; limit1;
      Big_ZF:=Smirnow(A_s[1],A_s[2],A_s[3],Sred,SKO);
        C_s:=B_s;
        B_s:=Big_ZF;
          until (Big_ZF>=C_s) or (limit);
            B_s:=C_s;
            A_s:=A_sr;
            h_s[j]:=-h_s[j]/KdivSm;
               end; {for j:=1 to Np}
   if not ((Abs(h_s[1])<ee[1]) and (Abs(h_s[2])<ee[2])and (Abs(h_s[3])<ee[3])) then goto Met;
          MSmirn.A:=A_s[1]; MSmirn.B:=A_s[2]; MSmirn.K_powtor:=A_s[3];
           x1:=0;
      for i:=0 to high(Hist_Arr) do begin
  x2:=Hist_Arr[i].time;               //mas otkaz?
  MSmirn.F_Weib[i]:=weibCDF2(MSmirn.A,MSmirn.B,x1,x2);
  if MSmirn.F_Weib[i]<0 then MSmirn.F_Weib[i]:=0; //******
  MSmirn.F_norm[i]:=CDF_Gauss(Sred,SKO,(x1+x2)/2);
  MSmirn.Kol_F_Priv[i]:=Izd_Prived*MSmirn.K_powtor*MSmirn.F_Weib[i]*(1-MSmirn.F_norm[i]);
  MSmirn.SKO_out:=MSmirn.SKO_out+Sqr(Hist_Arr[i].Sum-MSmirn.Kol_F_Priv[i]);
  x1:=x2;
end;
   MSmirn.Executed:=true;
   MSmirn.Sred:=Sred; MSmirn.SKO:=SKO;
   MSmirn.SKO_out:=Sqrt((MSmirn.SKO_out)/Kol_Izw);
   Form1.Memo2.Lines.Add('Расчёт модели по Смирнову выполнен за '+TimeToStr(Time-Tim)+'ч/мин/с');
   end;

Procedure SpirSp_Execute; {миним. методом спирального координатного спуска}
  var
  C_s,B_ss: double;
  A_S, A_sr,A_max,A_min,h_s,ee: array[1..5] of double;
  i, j, Np,N_hist: integer;
   Terminated: boolean;
   dMinF,x1,x2,KdivSpir: double;
   Tim:TDateTime;
 label m2;

 Function Out_SPir: boolean;
 var i:integer;
  begin
 Result:=true;
  for i := 1 to Np do Result:=Result and ((Abs(h_s[i])<ee[i]));
        end;

 Procedure ZF(var B_ss:double);
  begin
   if Sred_Opt=false then     // без оптимизации среднего времени цензурирования
          if SKO_Opt=false then B_ss:=Pirson(A_s[2],A_s[1],A_s[3],Sred,SKO,MPirsS)
                           else B_ss:=Pirson(A_s[2],A_s[1],A_s[3],Sred,A_s[4],MPirsS)
   else if SKO_Opt=false then B_ss:=Pirson(A_s[2],A_s[1],A_s[3],A_s[4],SKO,MPirsS)
                         else B_ss:=Pirson(A_s[2],A_s[1],A_s[3],A_s[4],A_s[5],MPirsS);
                          end;
begin
Np:=3;
A_s[2]:=0.0005;     A_max[2]:=0.1{0.0005};    A_min[2]:=1e-10{2e-9};//A
A_s[1]:=1.1;        A_max[1]:=3;         A_min[1]:=6e-1;//B
A_s[3]:=1.0;        A_max[3]:=30;        A_min[3]:=0.1; //K_powtor1
h_s[2]:=0.00005;    ee[2]:=1e-9;
h_s[1]:=0.001;      ee[1]:=1e-7;
h_s[3]:=0.001;      ee[3]:=1e-7;

 if Sred_Opt then begin  ///// Sred_Opt
   Np:=4;
   A_s[4]:=400;        A_max[4]:=3000;      A_min[4]:=150; //Sred
   h_s[4]:=0.25;       ee[4]:=1e-2;
   if SKO_Opt then begin
   Np:=5;
   A_s[5]:=100;        A_max[5]:=900;       A_min[5]:=50;  //SKO
   h_s[5]:=0.5;          ee[5]:=1e-1;
     end;
       end
        else      //////////// Sred_Opt=false
     if SKO_Opt then begin
   Np:=4;
   A_s[4]:=100;        A_max[4]:=900;       A_min[4]:=80; //SKO
   h_s[4]:=0.5;          ee[4]:=1e-1;
     end;
N_hist:=high(Hist_Arr)+1;
    setlength(MPirsS.F_Weib,n_hist);
    setlength(MPirsS.F_Norm,n_hist);
    setlength(MPirsS.Kol_F_priv,n_hist);
  C_s := 0;
  B_ss := 0;
  Randomize;      Tim:=Time; KdivSpir:=StrToFloat(Form1.Edit1.Text);
        ZF(B_ss);
        dMinF := Max_Start;
 //Form1.ProgressBar1.Min:=0; Form1.ProgressBar1.Max:=1000;
     repeat
      for j := 1 to Np do begin
        repeat
          for i:=1 to Np do A_sr[i]:=A_s[i];
          if A_S[j]+H_s[j]>0 then A_S[j]:=A_S[j]+H_s[j];
          if A_S[j]>A_max[j] then goto m2;
              C_s:=B_ss;
              ZF(B_ss);
      if dMinF > B_ss then dMinF := B_ss;
        until ((B_ss > C_s)  {or (A_S[j] < 0)});
  m2:      B_ss:=C_s;
        A_s[j]:=A_sr[j]-H_s[j];
        H_s[j] := -H_s[j]/KdivSpir{1.135};
// Form1.ProgressBar1.StepBy(Round(10/Np));
      end;
    until (Out_SPir);
   MPirsS.A:=A_s[2]; MPirsS.B:=A_s[1]; MPirsS.K_powtor:=A_s[3];
   if (Sred_Opt) and (SKO_Opt=false) then Sred:=A_s[4];
   if (Sred_Opt=false)and(SKO_Opt)   then SKO:=A_s[4];
   if (Sred_Opt=true)and(SKO_Opt=true) then begin Sred:=A_s[4]; SKO:=A_s[5]; end;
      MPirsS.SKO:=SKO; MPirsS.Sred:=Sred;
      MPirsS.Kol_Nakopl:=0; MPirsS.SKO_out:=0; MPirsS.Unsens:=0; x1:=0;
    for i:=0 to high(Hist_Arr) do begin
      x2:=Hist_Arr[i].time;
  MPirsS.F_Weib[i]:=weibCDF2(MPirsS.A,MPirsS.B,x1,x2);
  MPirsS.F_norm[i]:=(CDF_Gauss(Sred,SKO,(x1+x2)/2));//+CDF_Gauss(Sred,SKO,x1))/2;
  MPirsS.Kol_F_Priv[i]:=Izd_Prived*MPirsS.K_powtor*MPirsS.F_Weib[i]*(1-MPirsS.F_norm[i]);  // Kol:=Izd_Prived*k_pwt
  MPirsS.SKO_out:=MPirsS.SKO_out+Sqr(Hist_Arr[i].Sum-MPirsS.Kol_F_Priv[i]);
      x1:=x2;
end;
   MPirsS.Executed:=true;
   MPirsS.Sred:=Sred; MPirsS.SKO:=SKO;
   MPirsS.SKO_out:=Sqrt((MPirsS.SKO_out)/(1+high(Hist_Arr))){Kol_Izw};
   Form1.Memo2.Lines.Add('Расчёт модели по Пирсону методом спирального спуска выполнен за '+TimeToStr(Time-Tim)+'ч/мин/с');
 //  Form1.Memo2.Lines.Add(Format('Шаг=%12.10e  SKO=%10.3f', [H_s[2],MPirsS.SKO_out]));
end;
       end.


