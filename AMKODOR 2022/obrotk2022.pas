unit obrotk2022;     {����������}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, Math, AppEvnts, ComCtrls, Grids,FileCtrl,
  ToolWin,OutG_2022_5,Exp1,IniFiles, VclTee.TeeGDIPlus, VCLTee.Series,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,ShellAPI;

const
  N_Param_Opt = 5;    //����. ����� �������������� ����������
  Mx_prich = 52;      //����. ����� ������ ��������

ColorArray:array [0..Mx_prich] of TColor = (clBlack,clWhite, clRed,clWebGold,clWebMagenta,clWebYellow,clOlive,clWebCornFlowerBlue,
clWebKhaki,clWebLightSeaGreen,clWebHotPink,clWebPaleTurquoise,clWebMistyRose,clLime,clBlue,clWebMediumVioletRed,
clAqua,clMoneyGreen,clWebOrange,clGreen,clMaroon,clGray,
clWebLightGoldenrodYellow,clGreen,clyellow,clFuchsia,clPurple,{}clMoneyGreen,clWebOrange,clGreen,clMaroon,clGray,
clWebLightGoldenrodYellow,clGreen,clyellow,clFuchsia,clPurple,clWebPaleTurquoise,clAqua,clMoneyGreen,clWebOrange,clYellow,6,7,8,9,10,11,12,13,14,15,1);

type
 DoubArr        = array of Double;
 Mas_NPrich     = array [0..Mx_prich+1] of DoubArr;   // ��� ��������� 0 - ����, 1 -x2 2..12 - �������,
 MasParam       = array [0..2]  of double;            // ��������� ������������� ��������
 OptArray       = array [1..N_Param_Opt] of double;

       Problems = record
    time        : double;
    chey        : integer;
    Pri,komment : string
    end;

       Hist_Rec = record
        time    : double;
        Npr     : array [0..Mx_prich+1] of integer;
        Sum     : integer;
        end;

        Mod_Weib = record
 A,B,Kol_Nakopl,SKO,Sred,K_powtor,SKO_out,Unsens,KolmCrt,LamStart,Lam1000: double;
 Kol_F_priv,F_Weib,F_norm :DoubArr; // 1-������ ������� ������ ��� ���������
 Executed: boolean;
         end;

        Vid_otkaza =record
 Nazv_Prich: string;
 Dolya     : double;
 end;

 Hist40= array of Hist_Rec;

 Var
  MasProbl : array of Problems;
  Hist_Stol : Hist40;    // ������� �����������
  V_otk,Vidy_otkazov: array of Vid_otkaza; //  ����� Nprich+2
  MPirsN,MPirsS,MSmirn,MGenet,Mpir,Mgo: Mod_Weib;
  Path,Comment: String;
  uk,Sred_Opt,SKO_Opt,Perv,Stop_Gen: boolean;
  SK_otkl,A_Like,B_Like,Kdiv,Kol_Nakopl_Like,tGar,Kol_Izd_All,Popravka_Unknow,Pot08,
  Sum_X,Sum_Y,Sum_X2,Sum_XY,A_ln,B_ln,T_Prirab, tfin,
  Sred,SKO,T10expl,T20expl,t90,t90zen,t50zen,T50expl,T80expl,T90expl,Otk_Izd :double;
  D_Hist1,D_Hist2,KolOtk,Kol_izw,Kol_neizvest,Color_Pr,Tst,NPrich,Num_Col,N_ser:integer;

  Mas_Out_Like,MassT,MinDel,F_OutGar,MasTGarant:DoubArr;
  MUrez,SIGrez,SRrez,SKOrez,N_rot,Izd_Prived,SumNund:double;
  NoNul_PrichRow: array [0..Mx_prich] of boolean;
  Sum_PrichCol : array[0..Mx_prich] of double;
  Ao, Aopt, NormA: OptArray;                   // ������ �������������� ���������� � �����.������������
  iop: integer;                                // ���������� �������������� ���������� ������������� ���������
  Precision: extended;                         // �������� � ������������ ���������
  i,i2,j,t1,t2,Ns1,Ns2,Ns3,Nnew:integer;
    Nakopl,K_Interval,Expl_sum,SumNundCol: double;
    f: TextFile;
    Text_Name,x2str: AnsiString;
    KolmStr: string;
    tprev,SumI,t50,tz50: double;

  Procedure Potok08;
  Procedure DiaBarCol(ChartOne: TChart; i,Transpar:integer; St: string ); // � �������� ������ �������
  Procedure DiaStart;
  Procedure DiaGen;

  const Alim:array [1..2,1..N_Param_Opt] of double =    ((1,    0.1,     0.5,  80,    30),   // ������ ������ Ai
                                                        (40000,   3,     20,   5000, 1000));  // �������� Ai
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
    Problems_Grid: TStringGrid;
    Memo2: TMemo;
    Timer1: TTimer;
    SavDout: TSaveDialog;
    Label10: TLabel;
    meSred: TLabeledEdit;
    meSKO: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
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
    Button2: TButton;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Sred_flag: TCheckBox;
    SKO_Flag: TCheckBox;
    SpirSpusk: TCheckBox;
    BoxNewton: TCheckBox;
    BoxSmirnow: TCheckBox;
    RadioGroup1: TRadioGroup;
    Edit1: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    bbRaschet: TBitBtn;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label18: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    btnCopyBest: TButton;
    Edit3: TLabeledEdit;
    Edit2: TLabeledEdit;
    NPokoleny: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    ProgressBar2: TProgressBar;
    Label19: TLabel;
    ToolBRunGenOptim: TButton;
    OutsorsGoBtn: TButton;
    procedure OpenFileStartClick(Sender: TObject);
    procedure bbRaschetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ToolBRunGenOptimClick(Sender: TObject);
    procedure ToolBSaveClick(Sender: TObject);
    procedure ThreadTerminated(Sender: TObject);
    procedure ThreadStarted;
    //procedure ToolBPauseOptClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure btnCopyBestClick(Sender: TObject);
    procedure SaveFileBTNClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OutsorsGoBtnClick(Sender: TObject);
    //procedure Problems_GridClick(Sender: TObject);

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

uses GLVar_stat2022, LNview2022;
{$R *.DFM}

var  Gen: TGen;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
beep;
if Gen<>nil then begin Gen.Terminate;
                       Gen.Destroy;
                  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
 var St: String;
begin
Form1.WindowState:=wsMaximized;
Form1.Align:=alClient;
   St:=ExtractFilePath(ParamStr(0));
   sIniFile:=TiniFile.Create(St+'rel.txt');
   St:=SIniFile.ReadString('Path','ComStr',St);
   Form1.FilePath.Text:=St;
   sIniFile.Free;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    LoadData;
end;

function GettingData:boolean;
        begin
  GettingData:=true;
  Path:=Form1.FilePath.Text;
   if Path='' then
                begin
     GettingData:=false;
       ShowMessage('�� ������ ���� � ����� �������� ������');
                end
                else if uk=false then GettingData:=false;
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
     Sred:=StrToFloat(Form1.meSred.Text);
     SKO :=StrToFloat(Form1.meSKO.Text);
     TGar:=StrToFloat(Form1.LabeledEdit2.Text);
     T_Prirab:= StrToFloat(Form1.LabeledEdit3.Text);
 if not GettingData then Exit;
     SKO_Opt:=SKO_flag.Checked;  Sred_Opt:=Sred_flag.Checked;
   iop:=3;       // ����� �������������� ���������� ���������
   if Sred_Opt then inc(iop);
   if SKO_Opt then inc(iop);
      Precision:= StrToFloat(Form1.Edit2.Text);
for j := 1 to iop{N_Param_Opt} do NormA[j]:=(Alim[1,j]+Alim[2,j])*Precision; //������� ������� ����������
       Hist_Format;
setlength(MGenet.F_Weib,High(hist_Stol)+1);
setlength(MGenet.F_Norm,High(hist_Stol)+1);
setlength(MGenet.Kol_F_priv,High(hist_Stol)+1);
      Gen := TGen.Create(False);
      Gen.FreeOnTerminate := True;
      Gen.OnTerminate := ThreadTerminated;   //**���� - ��������� ����������
      Gen.Priority:=tpHigher;
      Gen.Resume;
        // Form5.Visible:=true;
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
  //Edit3.Enabled := False;  // 05.03.2022 ????
end;

{ procedure TForm1.ToolBPauseOptClick(Sender: TObject);
begin
// if Gen.Suspend then Gen.Resume else Gen.Suspend;
   // ToolBStopOpt.Enabled := Not ToolBStopOpt.Enabled;
end; }

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  TrackBar1.Hint := '����������� ����������� '+Format('%4.2f',[TrackBar1.Position/100]);
  Application.CancelHint;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  TrackBar2.Hint := '����������� ������� '+Format('%4.2f',[TrackBar2.Position/100]);
  Application.CancelHint;
end;

procedure TForm1.btnCopyBestClick(Sender: TObject);
begin
  bCopyBest := True;
end;

procedure TForm1.StopBtnClick(Sender: TObject);
begin
Stop_Gen:=true;
end;

Procedure Potok08;// ��������� �-�� ������� ����� T_prirab �� 1000 � � ���������������
var i :integer;
    x2:double;
begin
  x2:=0;
 T_prirab:=StrToFloat(Form1.LabeledEdit3.Text);
  for i:=0 to high(MasProbl) do
     if (MasProbl[i].time>T_prirab) and (MasProbl[i].time<=1000) then
if (MasProbl[i].time>T_prirab) and (MasProbl[i].time<=1000) then
     x2:=x2+1/(1-CDF_Gauss(Sred,SKO,MasProbl[i].time));
      Pot08:=1000*x2/(1000-T_prirab)/Izd_Prived;//(Kol_Izd_All)*KolOtk/Kol_izw;
end;

procedure TForm1.Button2Click(Sender: TObject); // LN ��������� 26.02.2022
  var j,Tst: integer;
      f,x1,y1: double;
begin
  Application.CreateForm(TLNview, LNview);
  Form1.Visible:=false;
   LNView.Visible:=true;
     Tst:=-1;
   With LNView do begin
    Series1.Clear; Series2.Clear;
 with LNview do begin
   for j:=0 to high(MasProbl) do   // �2 ???????
        if (masProbl[j].time>0) then begin
  //      f:=(j+1)/(high(MasProbl)+1);
  //      x1:=ln(MasProbl[j].time);
  //      y1:=-Ln(-1/Ln(1-f));
//  LNView.Chart2[0].AddXY(x1,y1,'',clGreen);
 if LNView.Chart2[0].AddXY(ln(1e-5+MasProbl[j].time),ln(j+1),'',clGreen)>0 then
            if (Tst=-1) then Tst:=j;
        end;
           end;
           j:=High(MasProbl);
 Label3.Caption:=Comment;
 Label1.Caption:='A= '+ Format('%6.4f',[A_Ln]);
 Label2.Caption:='B= ' + Format('%6.4f',[B_Ln]);
 if (LNView.Chart2[1].AddXY(ln(1e-5+MasProbl[Tst].time),A_ln*ln(1e-5+MasProbl[Tst].time)  + B_ln,'',clRed)>0) and
    (LNView.Chart2[1].AddXY(ln(1e-5+MasProbl[j-1].time),A_ln*ln(1e-5+MasProbl[j-1].time)  + B_ln,'',clRed)>0)
       then i:=0;
   end;
end;

procedure TForm1.OpenFileStartClick(Sender: TObject);
var
FName,St,St2,S_Prich,Sall,S1,ss:String;
DataFile:TextFile;
Flags: TReplaceFlags;
Y: boolean;
i,ii,i_0,j,k:integer;
n,SumN: longint;
x1,x2,sum,Tprev:double;
sIniFile: TiniFile;
N_t: array of real;
label Nex;
          begin
         {$I-}
   St:= ExtractFilePath(ParamStr(0));
   sIniFile:=TiniFile.Create(St+'rel.txt');
   ss:=SIniFile.ReadString('Path','ComStr',St2);
   Opendialog1.InitialDir:=St2;
   SiniFile.Free;
   if OpenDialog1.Execute then
      FilePath.Text :=OpenDialog1.FileName;
     FName  := OpenDialog1.FileName;
       AssignFile(DataFile,FName);
   Reset(DataFile);
      {$I+};
  if IOResult=0 then //���� ����������
             begin
   St:= ExtractFilePath(ParamStr(0));
   sIniFile:=TiniFile.Create(St+'rel.txt');
   SIniFile.WriteString('Path','ComStr',Form1.FilePath.Text);
   SiniFile.Free;
             end;
      uk:=true;  Setlength(MasProbl,0); Otk_Izd:=0;
  with Form1 do begin
       try
      {$I-}
  MGenet.Kol_Nakopl:=0;
  MGenet.K_powtor:=1;
  MGenet.Unsens:=0;
  readln(DataFile,Comment);     Label10.Caption:=Comment;             // �������� �����
  readln(DataFile,Sred);        MeSred.Text:=FloatToStr(Sred);        // ������� ����� ��������
  readln(DataFile,SKO);         MeSKO.Text :=FloatToStr(SKO);         // ��� ��������
  readln(DataFile,Kol_Izd_All); MeKolAll.Text:=FloatToStr(Kol_Izd_All); // ����� ����� ����������� �������
  readln(DataFile,KolOtk);      MeKolOtk.Text:=IntToStr(KolOtk);      // ����� ����� ������� � �������������
  readln(DataFile,NPrich);                                            // ����� ����� ������ �������

  LabeledEdit2.Text:=MeSred.Text; tGar:=Sred;
  Edit1.Text:='1'+ FormatSettings.DecimalSeparator + '00025';
  Edit6.Text:='1'+ FormatSettings.DecimalSeparator + '00025';
  Edit5.Text:='1'+ FormatSettings.DecimalSeparator + '0005';
  Edit2.Text:='0'+ FormatSettings.DecimalSeparator + '0000002';

  Setlength(Vidy_otkazov,5);    Setlength(V_otk,5);  //***
  V_otk[0].Dolya:=0;
  V_otk[1].Dolya:=0;
  V_Otk[0].Nazv_Prich:='����';
  V_Otk[1].Nazv_Prich:='������';
  i:=1;
  NPrich:=1;
    Form1.Repaint;
       while true do begin
       readln(DataFile,S_Prich);
             St:=Trim(S_Prich);
        if length(S_Prich)>20 then goto Nex;
          inc(NPrich);
          inc(i);
          Setlength(Vidy_otkazov,NPrich+1);
          Setlength(V_otk,NPrich+1);
    V_otk[i].Nazv_Prich:=St; // �������� � ���� - ������ [0..Prich] of Vid_otkaza
    V_otk[i].Dolya:=0;
          
       end; // 29.05.2024


            //   end; {Form1 +++}
 Nex:       Form1.Label10.Caption:=Comment;

  Flags:= [ rfReplaceAll, rfIgnoreCase ];
       i:=0;
    while (not EOF(DataFile)) do
     begin
         Setlength(MasProbl,i+1);
         if i=0 then Sall:=St
         else Readln(DataFile,Sall);   // ��������� � ��� ������
       Sall:=Trim (Sall);
       S1:=Copy(Sall,0,Pos(#9, Sall)-1); // Delete(Sall, Pos(#9, Sall)-1, Length(Sall));
       S1:= StringReplace( S1, '.', FormatSettings.DecimalSeparator, Flags);
       S1:= StringReplace( S1, ',', FormatSettings.DecimalSeparator, Flags);
              try
       MasProbl[i].time:=StrToFloat(S1); // �������������� ������ � �����
              except
    on EConvertError do // ��������� ������ ��������������
      ShowMessage('������ � ������ �'+ inttoStr(i+NPrich+7)+' ����� ' +FName+', ���������)');
                end;
       S_Prich:=Copy(Sall,Pos(#9, Sall),Length(Sall));
       S_Prich:=Trim(S_Prich);                // ������� �������� � ����������� �������� ������� � �����
       if (S_Prich[2] in ['0'..'9'])
        then
        S_Prich:=Copy(Sall,Pos(#9, Sall),Length(Sall));

           if Pos('*', S_Prich)>0 then begin MasProbl[i].komment:=Copy(S_Prich,2+Pos('*', S_Prich));
           if MasProbl[i].time<1 then S_Prich:='����' else
           Delete(S_Prich, Pos('*', S_Prich)-1, Length(S_Prich));
                         end;
        //   MasProbl[i].chey:=0;


              Y:=false;
 for k := 0 to NPrich-1 do //begin                      // ������������� "���������" � ���� ����������                         // ������������� � ���� ����������
          if Pos(AnsiLowerCase(V_otk[k].Nazv_Prich),AnsiLowerCase(S_Prich))>0 then
               if MasProbl[i].time>=1 then begin
           MasProbl[i].chey:=k; Y:=true;
           MasProbl[i].Pri:=S_Prich;
           V_otk[k].Dolya:=V_otk[k].Dolya+1;
              Vidy_otkazov[k]:=V_otk[k];       // ���� ������� � ���� ����������
               end;
           if MasProbl[i].time<1 then
            begin
           MasProbl[i].chey:=0; Y:=true;
           MasProbl[i].Pri:='����';
           V_otk[0].Dolya:=V_otk[0].Dolya+1;
           Vidy_otkazov[0]:=V_otk[0];       // ���� ������� � ���� ����������
            end;
     ii:= Pos(AnsiLowerCase(V_otk[k].Nazv_Prich),AnsiLowerCase(S_Prich),1);
     if (not Y) and (Pos(AnsiLowerCase(V_otk[k].Nazv_Prich),AnsiLowerCase(S_Prich),1)<1) then begin
     MasProbl[i].chey:=1;
     MasProbl[i].Pri:='������';
     V_otk[1].Dolya:=V_otk[1].Dolya+1;  // "������" ������������ ����� ���� ���������
     Vidy_otkazov[1]:=V_otk[1]; //?
                    end;   //   *)
                //
                    //  end;
                 inc(i);
                 KolOtk:=i+1;                  // ��������� �����
                      end;

              // end;

               begin                                // ���������� �� �������� ����� ������� ������� �������
  for i:=2 to high(V_otk) do begin
       j:=i;
    while (j>2) and (Vidy_otkazov[j-1].Dolya<V_otk[i].Dolya) do
                        begin
          Vidy_otkazov[j]:=Vidy_otkazov[j-1];
                        j:=j-1;
                        end;
      Vidy_otkazov[j]:=V_otk[i];
                               end;
                end;
      for i:=0 to high(MasProbl) do
      for k := 2    to    NPrich do           // ������������� � ���� ����������
       if Pos(AnsiLowerCase(Vidy_otkazov[k].Nazv_Prich),AnsiLowerCase(MasProbl[i].Pri))>0 then
               begin
          MasProbl[i].chey:=k;
                 end;
       {$I+}
       Kol_izw:=High(MasProbl)+1-ceil(Vidy_otkazov[0].Dolya);
       MeKolOtk.Text:=IntToStr(Kol_izw);
       Sort_Minmax;
       Popravka_Unknow:=1;//Kol_izw/KolOtk;
            //��������� ����� ������� � ������� � ������ (� �������������),<1
       Izd_Prived:=Kol_Izd_All;//*Popravka_Unknow; //������������ (����������) ����� ��� �������
                CloseFile(DataFile);
            //    finally
          //        end;
   case KolOtk of
     0..500: Form1.NPokoleny.Text:='1500';  // ��� ������������� ���������
   501..999: Form1.NPokoleny.Text:='2000';
1000..99999: Form1.NPokoleny.Text:='4000'
            end;


  with Problems_Grid do begin    //���������� ������� �������
  ColWidths[0]:=65;  ColWidths[1]:=85;
  ColWidths[2]:=200; ColWidths[3]:=1010;

   Form1.Chart2.Series[0].Clear;
   Form1.Chart2.Series[1].Clear;
 if not Cells[1,1].IsEmpty then
                        begin
         for i:=0 to 3 do for j:=0 to high(MasProbl)+2 do Cells[i,j+1]:='';
                        end;
   Cells[0,0]:=' � ������'; Cells[1,0]:='���������, �'; Cells[2,0]:='�������� ������'; Cells[3,0]:='�������� ������';
        for i:=1 to 3 do for j:=0 to High(MasProbl) do Cells[i,j+1]:='';
         t90expl:=0; t90zen:=0;
         T80expl:=0;
         T50expl:=0; T50zen:=0;
         T20expl:=0;
         T10expl:=0;// P:=LOtkaz.PFirst; //P := P^.PNext;
      x1:=0; sum:=0; SumN:=0; Tprev:=0;    n:=1; i_0:=0;
      Tst:=-1; Sum_X:=0; Sum_Y:=0; Sum_X2:=0; Sum_XY:=0;
             for i:=0 to High(MasProbl) do begin
              if (masProbl[i].time>0) and (Tst=-1) then Tst:=i;
                  if (masProbl[i].time>=1) then
                        begin
              Sum_X:=Sum_X+ln(1e-5+masProbl[i].time);
              Sum_Y:=Sum_Y+ln(i+1);
              Sum_X2:=Sum_X2+Sqr(ln(1e-5+masProbl[i].time));
              Sum_XY:=Sum_XY+ln(i+1)*ln(1e-5+masProbl[i].time);
  if Form1.Chart2[0].AddXY(ln(1e-5+MasProbl[i].time),ln(i+1),'',clGreen)>0 then;
                        end
                  else inc(i_0);
          Cells[0,i+1]:=IntToStr(Round(i+1));
          Cells[1,i+1]:=FloatToStr(MasProbl[i].time);
 if (masProbl[i].time>0) then
    sum:=sum+1/(1-CDF_Gauss(Sred,SKO,MasProbl[i].time)){-CDF_Gauss(Sred,SKO,x1)};   // ���������� ������ �� ���������� (��������������)
    St:=Vidy_Otkazov[Round(MasProbl[i].chey)].Nazv_Prich;
          Cells[2,i+1]:=St;
          Cells[3,i+1]:=(MasProbl[i].komment);
   if (MasProbl[i].time>=2000{tGar}) and (Otk_Izd=0)then Otk_Izd:=sum/Izd_Prived*2000/MasProbl[i].time;
   if (sum/Izd_Prived {���� ��������� �� ���������� "���������" �����, �.� % ����������}
                   >=0.1) and (T90expl=0) then begin Cells[2,i+1]:=St+', ������� 10% �� �����';
   T90expl:=MasProbl[i].time-(MasProbl[i].time-MasProbl[i-1].time)*Frac(Sum-0.1*Izd_Prived); end;
   if (sum/Izd_Prived>=0.2) and (T80expl=0) then begin Cells[2,i+1]:=St+', ������� 20% �� �����';
   T80expl:=MasProbl[i].time-(MasProbl[i].time-MasProbl[i-1].time)*(Sum-0.2*Izd_Prived); end;
   if (sum/Izd_Prived>=0.5) and (T50expl=0) then begin
   Cells[2,i+1]:=St+', ������� 50% �� ������������ �����';
   T50expl:= MasProbl[i].time-(MasProbl[i].time-MasProbl[i-1].time)*Frac(Sum-0.5*Izd_Prived); end;
   if (sum/Izd_Prived>=0.5) and (T50zen=0) then begin
   Cells[2,i+1]:=St+', ������� 50% �� ����� � ������ ��������������';
   T50zen:=  MasProbl[i].time-(MasProbl[i].time-MasProbl[i-1].time)*Frac(Sum-0.5*Izd_Prived); end;
   if (sum/Izd_Prived>=0.8) and (T20expl=0) then begin Cells[2,i+1]:=St+', ������� 80% �� �����';
   T20expl:= MasProbl[i].time-(MasProbl[i].time-MasProbl[i-1].time)*Frac(Sum-0.8*Izd_Prived); end;
   if (sum/Izd_Prived>=0.9) and (T90expl=0) then
   begin Cells[2,i+1]:=St+', ������� 90% �� �����';
   t90expl:=MasProbl[i].time-(MasProbl[i].time-MasProbl[i-1].time)*Frac(i+1-0.9*Izd_Prived);
   t90zen:=MasProbl[i].time-(MasProbl[i].time-MasProbl[i-1].time)*Frac(Sum-0.9*Izd_Prived); end;
          Tprev:=MasProbl[i].time;
          RowCount:=RowCount+1;
           end;
  if (MasProbl[high(MasProbl)].time<2000{tGar}) and (Otk_Izd=0) then Otk_Izd:=sum/Izd_Prived*2000/MasProbl[high(MasProbl)].time;
                 end;
        A_ln:=(i*Sum_XY-Sum_X*Sum_Y)/(i*sum_X2-SQr(Sum_X));
        B_ln:=(Sum_Y-A_ln*Sum_X)/i;
        if (Form1.Chart2[1].AddXY(ln(1e-5+MasProbl[Tst].time),A_ln*ln(1e-5+MasProbl[Tst].time)  + B_ln,'',clRed))>0 then;
        if(Form1.Chart2[1].AddXY(ln(1e-5+MasProbl[i-1].time),A_ln*ln(1e-5+MasProbl[i-1].time)  + B_ln,'',clRed))>0 then
         ;
           finally
           //���� �� ����������
                begin
      //uk:=false;
      //   ShowMessage('��������� ���� �� ����������');
           //Exit;
                end; Perv:=true; // Free();
        end;
 end; // Form1
            end;

Procedure CntrText(i:integer; Text: String);
 var WCells: Integer;
 Stroka:string;
 begin
    with Form5.Result_Grid do begin
 WCells:=ColWidths[Num_Col]-7; //7 - �������������
 Stroka:=Text;
 with Canvas do begin
 Stroka:=' '+Stroka;
   while TextWidth(Stroka)<WCells do Stroka:=Stroka+' ';
          Cells[Num_Col,i]:=Stroka;
             end;
       end;
 end;

Procedure BlockOut(Model:Mod_Weib;st:string;Wi:integer);
var tt:real;
  begin
    if not Model.Executed then exit;
     with Form5.Result_Grid do
     with Model do begin
     ColWidths[Num_Col]:=wi;
     Cells[Num_Col,0]:=st;
     tt:=Kolmogor(K_Powtor,A,B,Sred,SKO,KolmCrt,KolmStr);
     CntrText(1,Format('%6.3f / %7.2f',[A,B]));
     CntrText(2,Format('%6.3f',[K_powtor]));
     CntrText(3,FloatToStr(Round(weibinv(A,B,0.5/K_powtor)))+' �.'); // ��������� 26.02.2022
     CntrText(4,FloatToStr(Round(weibinv(A,B,0.1/K_powtor)))+' �.');
     CntrText(5,FloatToStr(Round(Kol_Nakopl))+' /'+FloatToStr(Round(Kol_Nakopl/Popravka_Unknow)));
     CntrText(6,Format('%5.2f / %5.2f',[1.96*SKO_out,SKO_Out]));
     CntrText(7,Format('%4.1f',[Sred])+' �');
     CntrText(8,Format('%4.1f',[SKO]) +' �');
     CntrText(9,Format('%6.3f',[KolmCrt]) + KolmStr);
     CntrText(10,Format('%6.4f/ %6.4f',[LamStart,Lam1000]));
     CntrText(11,Format('%6.2f / %6.2f',[Model.K_powtor*weibCDF2(A,B,0,2000),Model.K_powtor*weibCDF2(A,B,0,4000)]));
      inc(Num_Col);// �������� ������� ��� ������
    end;
  end;

Procedure DiaBarCol(ChartOne: TChart; i,Transpar:integer; St: string ); // � �������� ������ �������
  var ch: TChartseries;
  begin
     with ChartOne do begin
     ch:=AddSeries(TBarSeries.Create(ChartOne));  // !!!!!!!!!
     Series[SeriesCount - 1].Clear;
     Series[SeriesCount - 1].Marks.Visible := false;
     Series[SeriesCount - 1].Transparency := Transpar; //20;
     Series[SeriesCount - 1].Title:=St;
     Series[SeriesCount - 1].Color:=ColorArray[i];  // �����!
      end;
    end;

Procedure DiaBarNo(ChartBar: TChart; i, Transpar:integer; St: string );  // � �������� ������ �������
  var ch: TChartseries;
  begin
   with ChartBar do begin
     ch:=AddSeries(TBarSeries.Create(ChartBar)); // !!!!!!!!!
     Series[SeriesCount - 1].Clear;
     Series[SeriesCount - 1].Marks.Visible := false;
     Series[SeriesCount - 1].Transparency := Transpar;
     series[SeriesCount - 1].Title:=St;
     Series[SeriesCount - 1].Color:=ColorArray[i];  // �����!
   end;
   end;

Procedure DiaStart;
 var i,j,i2,i3,ii: integer;  Y: boolean;
      t: double;

Begin    // 1- ��� ��� 2 - ��� ���� 3 - ������  +++++++ ��������� ++++++++++++++++++++++++++
     Potok08;
         With Form5 do begin
        Setlength(F_OutGar, high(Hist_Stol)+1);
    for j:=0  to Mx_prich do begin NoNul_PrichRow[j]:=false; Sum_PrichCol[j]:=0; end;
    for j:=0  to high(Hist_Stol) do
    for i:=0  to NPrich do
       if (Hist_Stol[j].Npr[i]>0) then NoNul_PrichRow[j]:= true; // ���� �� ������ �� ��������

   for i:=Chart1.SeriesCount-1 downto 11{Ns1} do Chart1.Series[i].Free;//�������� ������� ������ ����� �����
   for i:=Chart2.SeriesCount-1 downto 10{Ns2} do Chart2.Series[i].Free;//�������� ������� ������� ����� �����
   for i:=Chart3.SeriesCount-1 downto 3{Ns3} do Chart3.Series[i].Free;//�������� ������ ������ ���������} *)

    if MPirsN.Executed then begin MPirsN.Unsens:=0;       MPirsN.Kol_Nakopl:=0; end;
    if MPirsS.Executed then begin MPirsS.Unsens:=0;       MPirsS.Kol_Nakopl:=0; end;
                                  MGenet.Unsens:=0;       MGenet.Kol_Nakopl:=0;
                                  MGo.Unsens:=0;          MGo.Kol_Nakopl:=0;
                                  MPir.Unsens:=0;         MPir.Kol_Nakopl:=0;
                                  MSmirn.Unsens:=0;       MSmirn.Kol_Nakopl:=0;

    Series1.Clear;  Series2.Clear;  Series3.Clear;  Series4.Clear;  Series5.Clear;
    Series6.Clear;  Series7.Clear;  Series8.Clear;  Series9.Clear;  Series10.Clear;
    Series11.Clear; Series12.Clear; Series13.Clear; Series15.Clear; Series14.Clear;
    Series15.Clear; Series16.Clear; Series17.Clear; Series18.Clear; Series19.Clear;
    Series20.Clear; Series21.Clear; Series22.Clear; Series23.Clear; Series24.Clear;

     Ns1:=Chart1.SeriesCount;  //  ��� �������� 2-� ���������
     Ns2:=Chart2.SeriesCount;  //
     Ns3:=Chart3.SeriesCount;  //
        Nnew:=0;
       ColorPalettes.ApplyPalette( Chart1, 5{ 5 4}{7} );
       ColorPalettes.ApplyPalette( Chart2, 5 );
       ColorPalettes.ApplyPalette( Chart3, 5 );
       Chart1.Legend.Symbol.Continuous:=True;
       Chart3.legend.Symbol.Continuous:=True;
        i3:=0;
        i:=0;
     for j := 0 to Nprich{+1} do          // ������������ �������� ������� � �������
                begin
     Chart3.Series[Chart3.SeriesCount  -1].Color:=ColorArray[j]; // ����� ******************!
     Chart3.Series[Chart3.SeriesCount - 1].Color:=Chart3.Series[Chart3.SeriesCount - 2].Color;
        if Vidy_Otkazov[j].Dolya>0 then  begin // Ok
     DiaBarCol(Chart1, j, 0,  Vidy_Otkazov[j].Nazv_Prich + ' '+intToStr(Round(Vidy_Otkazov[j].Dolya))
          +' ��� ('+ Format('%3.1f', [100*Vidy_Otkazov[j].Dolya/Izd_Prived])+'%'+' /������');
     DiaBarNo(Chart2, j, 30, Vidy_Otkazov[j].Nazv_Prich);  //������ ����� ����� � ����
     DiaBarNo(Chart3, j, 0,  Vidy_Otkazov[j].Nazv_Prich);//+ ' '+intToStr(Round(Vidy_Otkazov[j].Dolya))
       //   +' ��� ('+ Format('%3.1f', [100*Vidy_Otkazov[j].Dolya/Izd_Prived])+'%'+' /������)');
     DiaBarNo(Chart3, j, 60, Vidy_Otkazov[j].Nazv_Prich+' � ������ ��������������');
                                         end;
                end;
                K_Interval:=CDF_Gauss(1,0.1,1);
                K_Interval:=1-CDF_Gauss(1,0.1,0.7);
                K_Interval:=CDF_Gauss(1,0.1,1.3);

          N_ser:=0;    t1:=0;  t2:=0; SumNund:=0; SumNundCol:=0; Expl_sum:=0;
          Num_Col:=1;

    for i := 0 to High(Hist_Stol) do
                   begin // ������ ����� �������    *****************************************
        if Hist_Stol[i].Sum>0 then begin
    t2:=round(Hist_Stol[i].time);
        K_Interval:=100/(t2-t1);
    F_OutGar[i]:=CDF_Gauss(SRED,SKO,t2);   // ���������� ���� �������� �� ��������
    Expl_sum:=Expl_sum+Hist_Stol[i].Sum;
        N_ser:=0;         x2Str:=FloatToStr(t2);
      for i2 := 0 to Nprich do
      if Vidy_Otkazov[i2].Dolya>0 then
                      begin
    x2Str:=FloatToStr(t2);
    Sum_PrichCol[i2]:=Sum_PrichCol[i2]+Hist_Stol[i].Npr[i2];  // ���������� �� i2 �������
// if NoNul_PrichRow[i2] then begin
   ii:=Chart1.series[Ns1+N_ser].Add(Hist_Stol[i].Npr[i2]*K_Interval/Izd_Prived,x2str,ColorArray[i2]);  // ����� ���
   ii:=Chart2.series[Ns2+N_ser].Add(Sum_PrichCol[i2]/Izd_Prived{*KolOtk/Kol_izw},x2str,ColorArray[i2]); //����� ����
// Chart2.series[Ns2+N_ser].Add(Hist_Stol[i].Nund/Izd_Prived*KolOtk/Kol_izw,x2str,ColorArray[i2]); //����� ����
//  if (F_OutGar[i]<0.9) and (1/(1-F_OutGar[i])<1.25) then
     begin
  Chart3.series[Ns3+2*N_ser].Color:=ColorArray[i2];
  Chart3.series[Ns3+2*N_ser+1].Color:=ColorArray[i2];
  //Chart3.series[Ns3+2*N_ser].Add(  Hist_Stol[i].Npr[i2]*2*K_Interval/Izd_Prived,x2str);  //������ ������ ���������
  ii:=Chart3.series[Ns3+2*N_ser+1].Add(Hist_Stol[i].Npr[i2]*2*K_Interval/Izd_Prived/(1-F_OutGar[i]),x2str);
         end;
              inc(N_ser);
                      end;

  ii:=Series17.Add(100*Expl_sum/Izd_Prived,x2str);        // ����� ������� ����� ������������ ����� ��� ��� 2

      if MPirsN.Executed then begin
    MPirsN.Unsens:=MPirsN.Unsens+MPirsN.F_Weib[i];                    // ����������� ��� ����� ��������������
    MPirsN.Kol_Nakopl:=MPirsN.Kol_Nakopl+MPirsN.Kol_F_Priv[i];        // ����������� ��������� ������
      end;
      if MPirsS.Executed then begin
    MPirsS.Unsens:=MPirsS.Unsens+MPirsS.F_Weib[i];                    // ����������� ��� ����� ��������������
    MPirsS.Kol_Nakopl:=MPirsS.Kol_Nakopl+MPirsS.Kol_F_Priv[i];        // �����������
            end;
      if MPirsS.Executed then begin
    //Chart1.series[1].Title:='������ �� ������� 1 � ������ ��������.';
    //Chart1.series[2].Title:='������ �� ������� 1';
    Chart1.series[2].Visible:=true;
    ii:=Series2.Add(MPirsS.F_Weib[i]     *K_Interval*MPirsS.K_powtor,x2str);{Ch1 Line ����������������� ��������� ������ �� �������}
    ii:=Series3.Add(MPirsS.Kol_F_priv[i] *K_Interval/Izd_Prived,x2str); {Ch1 Line �������� ��������� ������ �� �������}
    ii:=Series8.Add(MPirsS.Unsens        * MPirsS.K_powtor, x2str);       {Ch2 ������. ��������� ������ �� ������� ��� ��������������}
    ii:=Series9.Add(MPirsS.Kol_Nakopl/Izd_Prived, x2str);               {Ch2 ����������� ������ �� �������}
            end
            else begin
            Chart1.series[2].Visible:=false;
            Chart1.series[3].Visible:=false;
            end;
      if MPirsN.Executed then begin
    //Chart1.series[1].Title:='���������';
    //Chart1.series[2].Title:='������/������';
    Chart1.series[20].Visible:=true;
    ii:=Series20.Add(MPirsN.F_Weib[i]     *K_Interval*MPirsN.K_powtor,x2str);{Ch1 Line ����������������� ��������� ������ �� �������}
    ii:=Series21.Add(MPirsN.Kol_F_priv[i] *K_Interval/Izd_Prived,x2str); {Ch1 Line �������� ��������� ������ �� �������}
    ii:=Series22.Add(MPirsN.Unsens        * MPirsN.K_powtor, x2str);     {Ch2 ������. ��������� ������ �� ������� ��� ��������������}
    ii:=Series23.Add(MPirsN.Kol_Nakopl/Izd_Prived, x2str);               {Ch2 ����������� ������ �� �������}
           end
      else begin
      //Chart1.series[20].title:='';
     // Chart1.series[21].Visible:=false;
      end;

       if MGo.Executed then begin
    Chart1.series[24].Visible:=true;
    MGo.Unsens:=MGo.Unsens+MGo.F_Weib[i];                    // ����������� ��� ����� ��������������
    MGo.Kol_Nakopl:=MGo.Kol_Nakopl+MGo.Kol_F_Priv[i];        // ����������� ��������� ������
    ii:=Series24.Add(MGo.Kol_F_priv[i] *K_Interval/Izd_Prived,x2str);   {Ch2 ����������� ������ �� Go}
      end
      else Chart1.series[24].Visible:=false;

       if MGenet.Executed then begin
    MGenet.Unsens:=MGenet.Unsens+MGenet.F_Weib[i];
    MGenet.Kol_Nakopl:=MGenet.Kol_Nakopl+MGenet.Kol_F_Priv[i];
    ii:=Series5.Add(MGenet.F_Weib[i]    *MGenet.K_powtor*K_Interval,x2str); {Ch1 ������������ ������ ��� ����� ��������������}
    ii:=Series6.Add(MGenet.Kol_F_priv[i]/Izd_Prived     *K_Interval,x2str); {Ch1 �������� �������. ��������� ������}
    ii:=Series11.Add(MGenet.Unsens      *MGenet.K_powtor,           x2str); {Ch2 ����������� �������. ������ ��� ��������������}
    ii:=Series12.Add(MGenet.Kol_Nakopl  /Izd_Prived,x2str);                 {Ch2 ����������� ������������ ������}
          end
      else begin
      Chart1.series[5].Visible:=false;
      Chart1.series[6].Visible:=false;
      end;

      if MSmirn.Executed then begin
    MSmirn.Kol_Nakopl:=MSmirn.Kol_Nakopl+MSmirn.Kol_F_Priv[i];
    ii:=Series4.Add(MSmirn.Kol_F_Priv[i]*K_Interval/Izd_Prived,x2str); {Ch1 �������� ��������� ������ �� ��������}
    ii:=Series10.Add(MSmirn.Kol_Nakopl/Izd_Prived,x2str);              {Ch2 ����������� ������ �� ��������}
            end
      else begin
      Chart1.series[4].Visible:=false;
          end;
    ii:=Series1.Add(F_OutGar[i]*100,x2str);                             //% �������� �� ���������� ��� ���
    ii:=Series7.Add(F_OutGar[i]*100,x2str);                             //% �������� �� ���������� ��� 2
    ii:=Series15.Add(Expl_sum/Izd_Prived,x2str);                        //% ����������� ����. �� ������������ �-��
                        t1:=t2;
                end;
                        end;
 Form5.Label10.Caption:=Comment+' ('+FloatToStr(Kol_Izd_All)+' ��.)';  Perv:=false;
     Num_Col:=1;
        with Form5.Result_Grid do begin //���������� ������� �����������
    for i:=1 to 5 do for j:=0 to 13 do Cells[i,j]:='';
     ColWidths[0]:=240;
     BlockOut(MPirsN,'�������/�������'   ,145);
     BlockOut(MPirsS,'�������/����.�����',145);
     BlockOut(MSmirn,'�������� ��������',145);
     BlockOut(MGenet,'������������'      ,145);
     BlockOut(MGo,'Golang'      ,145);
     ColWidths[1]:=155;
     ColWidths[Num_Col]:=155;
 Cells[0,0] :='���������� ��� �������:'; Cells[Num_Col,0]:='������ ������������';
 Cells[0,1] :='�����. ��������(A,B ��� � Excel)';      //
 Cells[0,2] :='����������� �����������';
 Cells[0,3] :='����� 50%(N���./N����)';CntrText(3,floattostr(Round(T50Expl))+'(����.)/'+FloatToStr(Round(T50zen))+'(����.)');
 Cells[0,4] :='����� 90%';CntrText(4,floattostr(Round(T90Expl)));
// Cells[0,4] :='80%,90% �����-�������.'; CntrText(4,FloatToStr(Round(T80Expl))+' �., '+FloatToStr(Round(T90Expl))+' �.(����.)');
 Cells[0,5] :='����� ��������� �������'; CntrText(5,FloatToStr(Round(Kol_Izw)));
 Cells[0,6] :='95% �������. ���-�/��� ������';
 Cells[0,7] :='������� ������. ���� ��������';
 Cells[0,8] :='��� ������-�� ����� ��������';
 Cells[0,9] :='�������� �����������';
 if MasProbl[High(MasProbl)].time<1000 then tfin:=MasProbl[High(MasProbl)].time else tfin:=1000;
 Cells[0,10]:='������� �������/1000 � ('+FloatToStr(T_prirab)+','+FloatToStr(Tfin)+' �)'; //
 CntrText(10,Format('%5.3f',[Pot08])+' (�� 1000 �.)');
 Cells[0,11]:='�������/���. �� 2000/4000 �';  CntrText(11,Format('%4.2f',[Otk_Izd]));
           Tst:=-1;
   for j:=0 to high(MasProbl) do
          if (masProbl[j].time>0) then begin
  ii:=Form5.Series18.AddXY(ln(1e-5+MasProbl[j].time),ln(j+1),'',clGreen);
            if (Tst=-1) then Tst:=j;
                                        end;
                                end;
   j:=High(MasProbl);
// Label1.Caption:='A= '+ Format('%6.4f',[A_Ln]); Label2.Caption:='B= ' + Format('%6.4f',[B_Ln]);
 ii:=Form5.Series19.AddXY(ln(1e-5+MasProbl[Tst].time),A_ln*ln(1e-5+MasProbl[Tst].time)  + B_ln,'',clRed);
 ii:=Form5.Series19.AddXY(ln(1e-5+MasProbl[j].time),  A_ln*ln(1e-5+MasProbl[j].time)    + B_ln,'',clRed);
      Form5.Visible:=True;
      Screen.Cursor:=crDefault;
                      end;   // ����� Form 5 ��������
 end;

 Procedure DiaGen;
 begin
   Gen.Synchronize(Gen,Diastart);
   Gen.Terminate;
   gen.Destroy;
 end;


//***********************  ����� ������� 1 ��� ������������� ���������  **********************************
procedure TForm1.bbRaschetClick(Sender: TObject);
//var Stat_Parametr_Pirson,Stat_Parametr_Smirnow:MasParam;
  Begin
//  system.ReportMemoryLeaksOnShutdown:=true;   (**************************************************)

     Sred:=StrToFloat(Form1.meSred.Text);
     SKO :=StrToFloat(Form1.meSKO.Text);
     TGar:=StrToFloat(Form1.LabeledEdit2.Text);
     T_Prirab:= StrToFloat(Form1.LabeledEdit3.Text);// if True then

 if not GettingData then Exit;
     SKO_Opt:=SKO_flag.Checked;  Sred_Opt:=Sred_flag.Checked;
       Screen.Cursor :=crHourGlass;
     Hist_Format;
      if Spirspusk.Checked  then begin
         SpirSp_Execute;
         Sigmas(MPirsS,T_Prirab);
         Hist_SKO(MPirsS);
                        end;
      if BoxNewton.Checked  then begin
      Podbor_Weib_Pirson(MPirsN.A,MPirsN.B);
       Sigmas(MPirsN,T_Prirab);
      Hist_SKO(MPirsN);
                        end;
      if BoxSmirnow.Checked then begin
      Podbor_Weib_Smirnow(MSmirn.A, MSmirn.B);
      Sigmas(MSmirn,T_Prirab);
      Hist_SKO(MSmirn);
                        end;
        //  Form1.Visible:=False;//Close;//???
       DiaStart;   //  ����� ����������
         Screen.Cursor :=crDefault;
          beep;
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
  openDialog1.Filter :='���� ������ ��������|gar*.txt';
  if OpenDialog1.Execute then ;
  FName:=OpenDialog1.FileName;
  AssignFile(DataFile,FName);
  ProcessPath(FName,D,P,F);
  Edit4.Text :=D+':\..'+F;
   {$I-}
   Reset(DataFile);
   {$I+}
  if IOResult=0 then begin   //���� ����������
   MPirsN.Executed:=false; MPirsS.Executed:=false; MSmirn.Executed:=false; MGo.Executed:=False;
   Mgenet.Executed:=false;
     i:=1; uk:=true;
             try
        readln(DataFile,Comment);         // ��������-����������� �����
    Form1.Label15.Caption:=Comment;
    while (not EOF(DataFile)) do
      begin
       Setlength(MasTGarant,i);
       Readln(DataFile,MasTGarant[i-1]);  // ��������� � ��� ������
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
             end //���� ����������
         else    //���� �� ����������
            begin
      uk:=false; ShowMessage('��������� ���� �� ����������');
           Exit;
             end;
          end;

procedure TForm1.OutsorsGoBtnClick(Sender: TObject);
var
GoFile:TextFile;
i : integer;
t1, t2: double;
cmdLine,st:string;
  si: TStartupInfo;
  pi: TProcessInformation;
  Flags: TReplaceFlag;
  startupInfo: TStartupInfo;
  pInfo: TProcessInformation;
  returnCode: DWORD;
  shi: TShellExecuteInfo;
  label V;
       begin
st:= Form1.FilePath.Text;
cmdLine:= 'C:\Users\ADziu\go\hego\new3par.exe '+'"'+Form1.FilePath.Text+'"';

//ShowMessage('����: ' + cmdLine);
// ZeroMemory(@si, SizeOf(si));
//  si.cb := SizeOf(si);
 FillChar(startupInfo, SizeOf(startupInfo), 0);
  startupInfo.cb := SizeOf(startupInfo);
if CreateProcess(nil, PChar(cmdLine), nil, nil, false, 0, nil, nil, startupInfo, pInfo)
   then begin
//sleep(9000)
V: WaitForSingleObject(pInfo.hProcess, INFINITE);
    GetExitCodeProcess(pInfo.hProcess, returnCode);
    CloseHandle(pInfo.hProcess);
    CloseHandle(pInfo.hThread);
  end
  else begin beep;
  sleep(1000);
  goto V;
  end;
//  if CreateProcess(PChar('C:\Users\ADziu\go\hego\new3par.exe '),PChar('"'+Form1.FilePath.Text+'"'), nil,nil, False, 0, nil, nil, si, pi) then
//  begin
//    CloseHandle(pi.hThread);
//    CloseHandle(pi.hProcess);
//     end
//  else
//    ShowMessage('������ ��� ������� ��������: ' + SysErrorMessage(GetLastError));

    //if ShellExecute(Handle, 'open', PChar(cmdline), PChar('"'+Form1.FilePath.Text+'"'), nil, SW_SHOWNORMAL)>0 then
//   sleep(9000);

   AssignFile(GoFile,'d:/optymum.txt');
   Reset(GoFile);
      {$I+};
  if IOResult=0 then
        begin
  readln(GoFile,St);
  St:=Trim (St);
  St := St.Replace('.',',');
  MGo.A:=StrToFloat(St);
  readln(GoFile,St);
  St:=Trim (St);
  St := St.Replace('.',',');
  MGo.B:=StrToFloat(St);
  readln(GoFile,St);
  St:=Trim (St);
  St := St.Replace('.',',');
  MGo.K_powtor:=StrToFloat(St);
        end;
   Hist_Format;
   MGo.Executed:=true;  MGo.SKO:=SKO;  MGo.Sred:=Sred;
   MGo.Kol_Nakopl:=0;
   MGo.SKO_out:=0;
   MGo.Unsens:=0; t1:=0;
      setlength(MGo.F_Weib,High(hist_Stol)+1);
      setlength(MGo.F_Norm,High(hist_Stol)+1);
      setlength(MGo.Kol_F_priv,High(hist_Stol)+1);

   for i:=0 to high(Hist_Stol) do begin
      t2:=Hist_Stol[i].time;
  MGo.F_Weib[i]:=weibCDF2(MGo.A,MGo.B,t1,t2);
  MGo.F_norm[i]:=(CDF_Gauss(Sred,SKO,(t1+t2)/2));//+CDF_Gauss(Sred,SKO,x1))/2;
  MGo.Kol_F_Priv[i]:=Izd_Prived*MGo.K_powtor*MGo.F_Weib[i]*(1-MGo.F_norm[i]);  // Kol:=Izd_Prived*k_pwt
       t1:=t2;
    end;
  Sigmas(MGo,T_Prirab);
  Hist_SKO(MGo);
  DiaStart;   //  ����� ����������
         Screen.Cursor :=crDefault;
  Form1.Memo2.Lines.Add('������ ������ Golang ��������');
  Form1.Memo2.Lines.Add(Format('A=%10.3f B=%10.3f K=%10.3f', [MGo.A,MGo.B, MGo.K_powtor]));

      end;



end.

