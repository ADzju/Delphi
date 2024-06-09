unit obrotk2015;     {управление}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, Math, AppEvnts, ComCtrls, Grids,FileCtrl,
  ToolWin,Out_Graph_2_2015,IniFiles, VclTee.TeeGDIPlus, VCLTee.Series,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart;

const
  N_Param_Opt = 5;    //макс. число оптимизируемых параметров
  Mx_prich=20;//18;         //макс. число причин отказров

type
 RealArray= array of Double;
 Mas012   = array [0..Mx_prich+1] of RealArray;  // для гисторамм 0 - часы, 1 -x2 2..12 - причины,
 MasParam = array [0..2]  of double;     // параметры распределения Вейбулла
 OptArray = array [1..N_Param_Opt] of double;

WeibKf = record
A,B:double;
end;

Problems = record
    time         : double;
    chey         : integer;
    Pri,komment  : string
    end;

Hist_Rec = record
  time   : double;
  Npr    : array [0..Mx_prich] of integer;
  Nund   : integer;
  Sum    : integer;
  end;

 Mod_Weib = record
 A,B,Kol_Nakopl,SKO,Sred,K_powtor,SKO_out,Unsens,KolmCrt,LamStart,Lam1000: double;
 Kol_F_priv,F_Weib,F_norm :RealArray;
 Executed: boolean;
         end;

 Vid_otkaza =record
 Nazv_Prich: string;
 Dolya     : double;
 end;

 Var
  MasProbl : array of Problems;
  B_otk,Vidy_otkazov: array [0..Mx_Prich] of Vid_otkaza;
  Hist_Arr : array of Hist_Rec;    // столбцы гистограммы
  MPirsN,MPirsS,MSmirn,MGenet: Mod_Weib;
  Path,Comment: String;
  uk,Sred_Opt,SKO_Opt,Perv,Stop_Gen: boolean;
  SK_otkl,A_Like,B_Like,Kdiv,Kol_Nakopl_Like,tGar,Kol_Izd_All,Popravka_Unknow,Pot08,
  Sum_X,Sum_Y,Sum_X2,Sum_XY,A_ln,B_ln,
  Sred,SKO,T10expl,T20expl,t50zen,T50expl,T80expl,T90expl,Otk_Izd :double;
  D_Hist1,D_Hist2,KolOtk,Kol_izw,Kol_neizvest,Color_Pr,Tst:integer;

  Mas_Out_Like,MassT,MinDel,F_OutGar,MasTGarant:RealArray;
  MUrez,SIGrez,SRrez,SKOrez,N_rot,Izd_Prived,SumNund:double;
  Sum_PrichRow,Sum_PrichCol : array[0..Mx_Prich+1] of double;
 // MReal_Hist: Mas012;                        // для гисторамм 0 - часы, 1 -x2 (с уплотнением),2..11 - причины,
  Ao, Aopt, NormA: OptArray;                   // массив оптимизируемых параметров и коэфф.нормирования
  iop: integer;                                // Количество оптимизируемых параметров генетического алгоритма
  Precision: extended;                         // точность в генетическом алгоритме

  const Alim:array [1..2,1..N_Param_Opt] of double = ((1e-2,      1e-5,   0.1,  80,  30),   // нижний предел Ai
                                            (50000,     5{1e-3}, 5,   500, 100));  // диапазон Ai
type
  TForm1 = class(TForm)
    Panel1: TPanel;
    FilePath: TEdit;
    Label1: TLabel;
    OpenFileStart: TBitBtn;
    meKolAll: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    meKolOtk: TMaskEdit;
    OpenDialog1: TOpenDialog;
    Mass_List: TStringGrid;
    Memo2: TMemo;
    Timer1: TTimer;
    SavDout: TSaveDialog;
    Label10: TLabel;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Label6: TLabel;
    Label5: TLabel;
    Sred_flag: TCheckBox;
    SKO_Flag: TCheckBox;
    SpirSpusk: TCheckBox;
    BoxNewton: TCheckBox;
    BoxSmirnow: TCheckBox;
    RadioGroup1: TRadioGroup;
    Edit1: TEdit;
    bbRaschet: TBitBtn;
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    btnCopyBest: TButton;
    Edit3: TLabeledEdit;
    Edit2: TLabeledEdit;
    NPokoleny: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    ToolBRunGenOptim: TBitBtn;
    TabSheet3: TTabSheet;
    Button1: TButton;
    meSred: TLabeledEdit;
    meSKO: TLabeledEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Label16: TLabel;
    StopBtn: TButton;
    ProgressBar2: TProgressBar;
    Edit6: TEdit;
    Label17: TLabel;
    LabeledEdit2: TLabeledEdit;
    Label18: TLabel;
    Chart2: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButton1: TSpeedButton;
    Edit4: TEdit;
    MaskEdit1: TMaskEdit;
    MaskEditSrednee: TMaskEdit;
    MaskEditSKO: TMaskEdit;
    Label15: TLabel;
    LabeledEdit3: TLabeledEdit;
    procedure OpenFileStartClick(Sender: TObject);
    procedure bbRaschetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ToolBRunGenOptimClick(Sender: TObject);
    procedure ToolBSaveClick(Sender: TObject);
    procedure ThreadTerminated(Sender: TObject);
    procedure ThreadStarted;
    procedure ToolBPauseOptClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure btnCopyBestClick(Sender: TObject);
    procedure SaveFileBTNClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);

 private

  procedure LoadData;
  { Private declarations }
      public
  { Public declarations }
     end;

var
  Form1   : TForm1;
  PathINI : string;
  SiniFile: TiniFile;

implementation

//uses stat2018,Out_Graph2015;
{$R *.DFM}


 procedure TForm1.FormCreate(Sender: TObject);
 var St: String;
begin

end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    LoadData;
end;

procedure TForm1.LoadData;
var
  i: integer;
begin
  ToolBRunGenOptim.Enabled := True;
   end;

procedure TForm1.ToolBRunGenOptimClick(Sender: TObject);
var i,j:integer;
begin

    end;

procedure TForm1.ToolBSaveClick(Sender: TObject);
begin
  if SavDOut.Execute then
    Memo2.Lines.SaveToFile(SavDOut.FileName);
end;

procedure TForm1.ThreadTerminated(Sender: TObject);
begin
  ToolBRunGenOptim.Enabled := True;
  Edit3.Enabled := True;
end;

procedure TForm1.ThreadStarted;
begin
  ToolBRunGenOptim.Enabled := False;
  Edit3.Enabled := False;
end;

procedure TForm1.ToolBPauseOptClick(Sender: TObject);
begin
// if Gen.Suspend then Gen.Resume else Gen.Suspend;
   // ToolBStopOpt.Enabled := Not ToolBStopOpt.Enabled;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  TrackBar1.Hint := 'Вероятность скрещивания '+Format('%4.2f',[TrackBar1.Position/100]);
  Application.CancelHint;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  TrackBar2.Hint := 'Вероятность мутации '+Format('%4.2f',[TrackBar2.Position/100]);
  Application.CancelHint;
end;

procedure TForm1.btnCopyBestClick(Sender: TObject);
begin
 // bCopyBest := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     Sred:=StrToFloat(Form1.meSred.Text);
     SKO:=StrToFloat(Form1.meSKO.Text);
//  Hist;
     Histogram_Exp;
end;

procedure TForm1.OpenFileStartClick(Sender: TObject);
var
FName,St,St2,S_Prich,Sall,S1:ANSIString;
DataFile:TextFile;
Flags: TReplaceFlags;
i,j,k,NPrich:integer;
n,SumN: longint;
x1,x2,sum,Tprev:double;
sIniFile: TiniFile;
N_t: array of real;
       begin
               end;

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

//***********************  Старт расчета 1 без генетического алгоритма  **********************************
procedure TForm1.bbRaschetClick(Sender: TObject);
var
 Stat_Parametr_Pirson,Stat_Parametr_Smirnow:MasParam;
  Begin
    
            end;

procedure TForm1.SaveFileBTNClick(Sender: TObject);
begin
 if SavDOut.Execute then  Memo2.Lines.SaveToFile(SavDOut.FileName);
   end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
 var
FName,P,F:String;
DataFile:TextFile;
D: Char;
i:integer;

 begin
  openDialog1.Filter :='Файл времен гарантии|gar*.txt';
  OpenDialog1.Execute;
  FName:=OpenDialog1.FileName;
  AssignFile(DataFile,FName);
  ProcessPath(FName,D,P,F);
  Edit4.Text :=D+':\..'+F;
   {$I-}
   Reset(DataFile);
   {$I+}
  if IOResult=0 then begin   //Файл существует
     i:=1; uk:=true;
             try
        readln(DataFile,Comment);         // Описание-комментарий файла
    Form1.Label15.Caption:=Comment;
    while (not EOF(DataFile)) do
      begin
       Setlength(MasTGarant,i);
       Readln(DataFile,MasTGarant[i-1]);  // наработка и вид отказа
            inc(i);
               end;
         Form1.MaskEdit1.Text:=IntToStr(1+High(MasTGarant));
         Sred:=Mean(MasTGarant);
         SKO:=StdDev(MasTGarant);
        Form1.MeSred.Text:=FloatToStrF(Sred,ffFixed,3,1);
        Form1.MeSKO.Text :=FloatToStrF(SKO, ffFixed,3,1);
        Form1.MaskEditSrednee.Text:=FloatToStrF(Sred,ffFixed,6,3);
        Form1.MaskEditSKO.Text    :=FloatToStrF(SKO, ffFixed,6,3);
    finally
        CloseFile(DataFile);
           end;
             end //Файл существует
         else    //Файл не существует
            begin
      uk:=false; ShowMessage('Указанный файл не существует');
           Exit;
             end;
          end;
procedure TForm1.StopBtnClick(Sender: TObject);
begin
Stop_Gen:=true;
end;
  end.


(*   Пример кода : Иллюстрация успешного и неудачного преобразования строки с вещественным числом
var
   numberString : string;
   float        : Extended;
   errorPos     : Integer;
 begin
  // Установка строки правильным с вещественным числом
  numberString := '12345.678';

  // Его преобразование в значение
  Val(numberString, float, errorPos);

  // Показ строки и преобразованного значения
  if errorPos = 0
   then ShowMessageFmt('Val(%s) = %12.3f',[numberString,float]);

  // Val игнорирует Десятичный Разделитель, а конвертеры SysUtils - нет
  DecimalSeparator := '_';
   numberString := '12345_678';
   Val(numberString, float, errorPos);
   if errorPos = 0
   then ShowMessageFmt('Val(%s) = %12.3f',[numberString,float])
   else ShowMessageFmt('Val(%s) потерпело неудачу в позиции %d',
                       [numberString, errorPos]);
 end;
 Val(12345.678) = 12345.678
 Val(12345_678) потерпело неудачу в позиции 6    *)

