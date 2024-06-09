object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 726
  ClientWidth = 1025
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  PixelsPerInch = 120
  DesignSize = (
    1025
    726)
  TextHeight = 20
  object Chart1: TChart
    Left = -29
    Top = 0
    Width = 1054
    Height = 726
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BackWall.Pen.Visible = False
    Legend.Alignment = laBottom
    Legend.TopPos = 6
    Title.Color = clBlack
    Title.Font.Color = clBlack
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1086#1090#1086#1082#1072' '#1086#1090#1082#1072#1079#1086#1074' '#1074' '#1090#1077#1095#1077#1085#1080#1077' '#1075#1072#1088#1072#1085#1090#1080#1081#1085#1086#1075#1086' '#1087#1077#1088#1080#1086#1076#1072)
    Frame.Visible = False
    LeftAxis.Title.Caption = #1054#1090#1082#1072#1079#1086#1074' '#1079#1072' 100 '#1095#1072#1089' '#1085#1072' 1 '#1080#1079#1076#1077#1083#1080#1077
    LeftAxis.Title.Font.Style = [fsBold]
    RightAxis.Title.Caption = #1053#1072#1082#1086#1087#1083#1077#1085#1080#1077' '#1086#1090#1082#1072#1079#1086#1074', '#1091#1093#1086#1076' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080', %'
    RightAxis.Title.Font.Style = [fsBold]
    Shadow.Visible = False
    View3D = False
    Color = clWhite
    TabOrder = 0
    Anchors = [akLeft, akTop, akBottom]
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Label1: TLabel
      Left = 190
      Top = 68
      Width = 49
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Series2: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = clGreen
      Title = #1052#1086#1076#1077#1083#1100' '#1087#1086' '#1055#1080#1088#1089#1086#1085#1091' '#1089' '#1074#1083#1080#1103#1085#1080#1077#1084' '#1094#1077#1085#1079#1091#1088#1080#1088#1086#1074#1072#1085#1080#1103
      Brush.BackColor = clDefault
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = clLime
      Title = #1052#1086#1076#1077#1083#1100' '#1087#1086' '#1055#1080#1088#1089#1086#1085#1091
      Brush.BackColor = clDefault
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Transparency = 12
    end
    object Series4: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = clBlue
      Title = #1052#1086#1076#1077#1083#1100' '#1087#1086' '#1057#1084#1080#1088#1085#1086#1074#1091
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series6: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = 7303167
      Title = #1052#1086#1076#1077#1083#1100' "'#1075#1077#1085#1077#1090#1080#1095#1077#1089#1082#1072#1103'"'
      Brush.BackColor = clDefault
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series5: TLineSeries
      HoverElement = [heCurrent]
      Emboss.Visible = True
      SeriesColor = clRed
      Title = #1052#1086#1076#1077#1083#1100' "'#1075#1077#1085#1077#1090#1080#1095#1077#1089#1082#1072#1103'" '#1089' '#1074#1083#1080#1103#1085#1080#1077#1084' '#1094#1077#1085#1079#1091#1088#1080#1088#1086#1074#1072#1085#1080#1103
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
      LinePen.Width = 2
      Pointer.DarkPen = 22
      Pointer.InflateMargins = True
      Pointer.Pen.Style = psDot
      Pointer.Style = psDonut
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Transparency = 16
    end
    object Series14: TBarSeries
      HoverElement = []
      Active = False
      MultiBar = mbStacked
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
    object Series7: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = #1053#1072#1082#1086#1087#1083#1077#1085#1080#1077' '#1087#1086' '#1055#1080#1088#1089#1086#1085#1091
      LegendTitle = #1053#1072#1082#1086#1087#1083#1077#1085#1080#1077' '#1087#1086' '#1055#1080#1088#1089#1086#1085#1091
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series8: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = #1053#1072#1082#1086#1087#1083#1077#1085#1080#1077' '#1087#1086' '#1055#1080#1088#1089#1086#1085#1091' '#1094#1077#1085#1079'.'
      LegendTitle = #1053#1072#1082#1086#1087#1083#1077#1085#1080#1077' '#1087#1086' '#1055#1080#1088#1089#1086#1085#1091' '#1094#1077#1085#1079'.'
      Depth = 0
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      LinePen.Style = psDashDot
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series1: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = clYellow
      Title = #1042#1099#1073#1099#1074#1072#1085#1080#1077' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      LineHeight = 1
      LinePen.Width = 2
      OutLine.Width = 3
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series17: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = #1060#1072#1082#1090#1080#1095'. '#1085#1072#1082#1086#1087#1083#1077#1085#1080#1077', % '#1086#1090' '#1087#1072#1088#1082#1072
      LegendTitle = #1060#1072#1082#1090#1080#1095'. '#1085#1072#1082#1086#1087#1083#1077#1085#1080#1077', % '#1086#1090' '#1087#1072#1088#1082#1072
      Marks.Frame.Visible = False
      Marks.Visible = True
      Marks.Style = smsValue
      Marks.Callout.Length = 20
      PercentFormat = '##0.# %'
      SeriesColor = clSilver
      Title = #1053#1072#1082#1086#1087#1083#1077#1085#1080#1077' '#1086#1090#1082#1072#1079#1086#1074' '#1092#1072#1082#1090#1080#1095#1089#1077#1082#1086#1077' % '#1087#1072#1088#1082#1072
      ValueFormat = '#,##0.#'
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      DrawStyle = dsAll
      LinePen.Color = clGray
      LinePen.Width = 4
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Shadow.Smooth = False
      Pointer.Style = psCircle
      Pointer.VertSize = 2
      XValues.Name = 'X'
      XValues.Order = loNone
      YValues.Name = 'Y'
      YValues.Order = loAscending
      Transparency = 9
    end
  end
  object Prodolgenie: TButton
    Left = 903
    Top = 0
    Width = 94
    Height = 27
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #1055#1088#1086#1076#1086#1083#1078'.'
    TabOrder = 1
    OnClick = ProdolgenieClick
  end
  object Button1: TButton
    Left = 796
    Top = 0
    Width = 91
    Height = 27
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #1055#1077#1095#1072#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object PrintDialog1: TPrintDialog
    Options = [poPrintToFile]
    Left = 318
    Top = 65517
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 230
    Top = 65504
  end
end
