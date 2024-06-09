object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1058#1103#1075#1086#1074#1099#1081' '#1088#1072#1089#1095#1077#1090' '#1084#1072#1096#1080#1085#1099' '#1089' '#1043#1052#1055'. 2015, '#1040'. '#1044#1102#1078#1077#1074
  ClientHeight = 761
  ClientWidth = 1264
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = -1
    Top = 0
    Width = 1266
    Height = 753
    BorderRound = 4
    Legend.DrawBehind = True
    Legend.Font.Height = -13
    Legend.HorizMargin = 2
    Legend.ResizeChart = False
    Legend.Title.Font.Height = -19
    Legend.Title.TextAlignment = taCenter
    MarginBottom = 8
    MarginLeft = 5
    MarginRight = 5
    MarginTop = 5
    Title.ClipText = False
    Title.Font.Color = clBlack
    Title.Font.Height = -19
    Title.Frame.Color = clDefault
    Title.Margins.Left = 14
    Title.Margins.Top = 12
    Title.Margins.Bottom = 13
    Title.Margins.Units = maPercentSize
    Title.ShapeCallout.Side = csBottom
    Title.Text.Strings = (
      'TChart')
    Title.TextFormat = ttfHtml
    Title.VertMargin = 3
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Axis.Color = clDefault
    BottomAxis.AxisValuesFormat = '0.0'
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 5.000000000000000000
    BottomAxis.LabelsFormat.Font.Height = -19
    BottomAxis.LabelsFormat.Font.Quality = fqNormal
    BottomAxis.LabelsFormat.Font.OutLine.Width = 3
    BottomAxis.LabelsFormat.Font.Shadow.Visible = False
    BottomAxis.LabelStyle = talMark
    BottomAxis.MaximumOffset = 5
    BottomAxis.Title.Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1082#1084'/'#1095
    BottomAxis.Title.Font.Height = -19
    BottomAxis.Title.Font.Quality = fqNormal
    BottomAxis.Title.Font.Emboss.Color = 13027014
    BottomAxis.Title.Font.Emboss.Smooth = False
    BottomAxis.Title.Font.OutLine.Width = 0
    BottomAxis.Title.Font.OutLine.Visible = True
    BottomAxis.Title.Color = clBlue
    BottomAxis.Title.Pen.Width = 25
    Emboss.HorizSize = 2
    Emboss.VertSize = 2
    Emboss.Visible = True
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.AxisValuesFormat = '0'
    LeftAxis.Grid.Style = psDash
    LeftAxis.Grid.ZPosition = 2.000000000000000000
    LeftAxis.LabelsFormat.Font.Height = -13
    LeftAxis.LabelsFormat.Margins.Left = 4
    LeftAxis.LabelsOnAxis = False
    LeftAxis.LabelsSeparation = 20
    LeftAxis.LabelsSize = 2
    LeftAxis.MaximumRound = True
    LeftAxis.RoundFirstLabel = False
    LeftAxis.Title.Caption = 'Pk, kH'
    LeftAxis.Title.Font.Height = -19
    LeftAxis.Title.Font.Quality = fqNormal
    LeftAxis.Title.Font.Emboss.HorizSize = 23
    LeftAxis.Title.Font.Emboss.VertSize = 23
    LeftAxis.Title.Bevel = bvLowered
    LeftAxis.Title.BevelWidth = 4
    LeftAxis.Title.Pen.Width = 0
    LeftAxis.Title.ShapeCallout.Side = csLeft
    Pages.AutoScale = True
    Panning.MouseWheel = pmwNone
    Shadow.Smooth = False
    Shadow.Visible = False
    TopAxis.Axis.Width = 3
    TopAxis.Axis.Visible = False
    View3D = False
    BevelWidth = 4
    Color = clWhite
    TabOrder = 0
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      21
      15
      21)
    ColorPaletteIndex = 17
    object Button1: TButton
      Left = 1152
      Top = 16
      Width = 91
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100' '#1075#1088#1072#1092#1080#1082#1072
      TabOrder = 0
      OnClick = Button1Click
    end
    object Series1: TFastLineSeries
      Active = False
      Marks.Visible = True
      Marks.DrawEvery = 2
      LinePen.Color = 16711842
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 176
    Top = 16
  end
  object PrintDialog1: TPrintDialog
    Copies = 1
    PrintToFile = True
    Left = 120
    Top = 16
  end
  object PageSetupDialog1: TPageSetupDialog
    MinMarginLeft = 0
    MinMarginTop = 0
    MinMarginRight = 0
    MinMarginBottom = 0
    MarginLeft = 2500
    MarginTop = 2500
    MarginRight = 2500
    MarginBottom = 2500
    Options = [psoDefaultMinMargins, psoDisableOrientation]
    PageWidth = 29700
    PageHeight = 21000
    Left = 272
    Top = 16
  end
end
