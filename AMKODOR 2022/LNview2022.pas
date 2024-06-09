unit LNview2022;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine,Printers,
  VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, Vcl.StdCtrls;

type
  TLNview = class(TForm)
    Button2: TButton;
    Prodolgenie: TButton;
    Chart2: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog1: TPrintDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure ProdolgenieClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }

  end;
var
  LNview: TLNview;

implementation

{$R *.dfm}

uses obrotk2022;

procedure TLNview.Button2Click(Sender: TObject);
begin
    Printer.PrinterIndex:=0;
    Printer.Orientation:=poLandscape;//poPortrait
 LNview.PrintScale:=poPrintToFit;//poProportional;//
 PrinterSetupDialog1.Execute;
 LNview.Print;
end;

procedure TLNview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
LNView.Destroy;
 Form1.Visible:=true;
end;

procedure TLNview.ProdolgenieClick(Sender: TObject);
begin
  LNView.Destroy;
Form1.Visible:=true;
end;

end.
