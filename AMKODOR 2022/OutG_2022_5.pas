unit OutG_2022_5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.Series,
  VCLTee.TeEngine, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, Vcl.Grids, Printers, Vcl.StdCtrls;

type
  TForm5 = class(TForm)
    Chart2: TChart;
    Series15: TAreaSeries;
    Series8: TLineSeries;
    Series9: TLineSeries;
    Series10: TLineSeries;
    Series11: TLineSeries;
    Series12: TLineSeries;
    Chart1: TChart;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series6: TLineSeries;
    Series5: TLineSeries;
    Series14: TBarSeries;
    Series17: TLineSeries;
    Chart3: TChart;
    Series13: TLineSeries;
    Series18: TLineSeries;
    Series19: TLineSeries;
    Result_Grid: TStringGrid;
    Label10: TLabel;
    Prodolgenie: TButton;
    Button1: TButton;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Series20: TLineSeries;
    Series21: TLineSeries;
    Series22: TLineSeries;
    Series23: TLineSeries;
    Series1: TAreaSeries;
    Series7: TAreaSeries;
    Series16: TBarSeries;
    Series24: TLineSeries;
   // procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ProdolgenieClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation
uses {Exp1,} obrotk2022, GLVar_stat2022;

{$R *.dfm}

procedure FormCreate(Sender: TObject);
begin
Form5.WindowState:=wsMaximized;
Form5.Align:=alClient;
Form5.Scaled:=false;
Form5.AutoScroll:=false;

end;

 procedure TForm5.Button1Click(Sender: TObject);

 begin
 Printer.PrinterIndex:=0;
 Printer.Orientation:=poLandscape;//poPortrait
 PrintScale:=poPrintToFit;//poProportional;//
 if PrinterSetupDialog1.Execute then
 Print;
end;



procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//Form5.Destroy;
Form1.visible:=true;
end;
procedure TForm5.ProdolgenieClick(Sender: TObject);
begin
Form5.Visible:=false;
Form1.Visible:=true;
end;

end.


