unit Exp1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.Series,  Printers,
  VCLTee.TeEngine, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series6: TLineSeries;
    Series5: TLineSeries;
    Series14: TBarSeries;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Prodolgenie: TButton;
    Button1: TButton;
    Label1: TLabel;
    Series7: TLineSeries;
    Series8: TLineSeries;
    Series17: TLineSeries;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ProdolgenieClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation
 uses obrotk2022, OutG_2022_5;
{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
     Printer.PrinterIndex:=0;
    Printer.Orientation:=poLandscape;//poPortrait
//  Form2.PrintDialog1.Execute;
//  Printdialog1.Create(Form2);
//  PrinterSetupDialog1.Execute;
//  PrintDialog1.Execute;
 //Form2.PrintScale:=poPrintToFit;//poProportional;//
 PrinterSetupDialog1.Execute;
 //Form2.Print;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form4.Destroy;
end;

procedure TForm4.ProdolgenieClick(Sender: TObject);
begin
Form4.Close;
end;

end.
