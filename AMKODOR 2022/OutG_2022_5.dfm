object Form5: TForm5
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Align = alTop
  Caption = 
    #1050#1086#1083#1080#1095#1077#1089#1090#1074#1077#1085#1085#1099#1081' '#1072#1085#1072#1083#1080#1079' '#1079#1072#1082#1086#1085#1072' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1103' '#1086#1090#1082#1072#1079#1086#1074'. '#1040#1085#1072#1083#1080#1079' '#1085#1072#1076#1077#1078 +
    #1085#1086#1089#1090#1080' '#1074' '#1101#1082#1089#1087#1083#1091#1072#1090#1072#1094#1080#1080'.  v.6.0'#169' '#1040'. '#1044#1102#1078#1077#1074', 2024'
  ClientHeight = 1119
  ClientWidth = 1803
  Color = clBtnFace
  DockSite = True
  DragKind = dkDock
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  PixelsPerInch = 134
  DesignSize = (
    1803
    1119)
  TextHeight = 23
  object Label10: TLabel
    Left = 820
    Top = 3
    Width = 8
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial Black'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object Chart2: TChart
    Left = 1300
    Top = 401
    Width = 595
    Height = 716
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BackWall.Color = clWhite
    Legend.Alignment = laBottom
    Legend.ColorWidth = 30
    Legend.Symbol.Width = 30
    Legend.Title.Font.Height = -11
    Legend.Title.Margins.Left = 7
    Legend.Title.Margins.Top = 3
    Legend.Title.Margins.Right = 5
    Legend.TopPos = 6
    Legend.Visible = False
    Title.Font.Color = clBlack
    Title.Font.Style = [fsBold]
    Title.Margins.Left = 6
    Title.Text.Strings = (
      #1048#1085#1090#1077#1075#1088#1072#1083#1100#1085#1099#1077' ('#1085#1072#1082#1086#1087#1083#1077#1085#1085#1099#1077') '#1086#1094#1077#1085#1082#1080' '#1087#1086#1090#1086#1082#1072' '#1086#1090#1082#1072#1079#1086#1074)
    Title.VertMargin = 4
    Chart3DPercent = 20
    LeftAxis.Title.Caption = #1054#1090#1082#1072#1079#1086#1074' '#1085#1072' 1 '#1080#1079#1076#1077#1083#1080#1077
    LeftAxis.Title.Font.Style = [fsBold]
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    RightAxis.Maximum = 100.000000000000000000
    RightAxis.Title.Caption = #1042#1099#1073#1099#1074#1072#1085#1080#1077' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080', %'
    RightAxis.Title.Font.Style = [fsBold]
    View3D = False
    View3DOptions.FontZoom = 140
    View3DWalls = False
    Zoom.Animated = True
    Zoom.AnimatedSteps = 4
    ZoomWheel = pmwNormal
    Color = clWhite
    TabOrder = 0
    Anchors = [akLeft, akTop, akRight, akBottom]
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series15: TAreaSeries
      HoverElement = [heCurrent]
      SeriesColor = 13018309
      Title = #1054#1090#1082#1072#1079#1099' ('#1088#1077#1072#1083#1100#1085#1099#1077')'
      AreaChartBrush.Color = clGray
      AreaChartBrush.BackColor = clDefault
      AreaLinesPen.Visible = False
      Dark3D = False
      DrawArea = True
      MultiArea = maStacked
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      Transparency = 24
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series7: TAreaSeries
      HoverElement = [heCurrent]
      Marks.Frame.Visible = False
      Marks.Callout.Length = 20
      Marks.Symbol.Transparency = 12
      SeriesColor = 1441791
      Title = #1042#1099#1073#1099#1074#1072#1085#1080#1077' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080', %'
      VertAxis = aRightAxis
      AreaChartBrush.Color = clGray
      AreaChartBrush.BackColor = clDefault
      AreaLinesPen.Visible = False
      DrawArea = True
      LinePen.Width = 2
      MultiArea = maStacked
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      Transparency = 8
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series8: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = 10197760
      Title = #1052#1086#1076#1077#1083#1100' '#1087#1086' '#1055#1080#1088#1089#1086#1085#1091
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series9: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = 55552
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
    object Series10: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = 16711808
      Title = #1052#1086#1076#1077#1083#1100' '#1087#1086' '#1057#1084#1080#1088#1085#1086#1074#1091
      Brush.BackColor = clDefault
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series11: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = clRed
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
    object Series12: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = 6579455
      Title = #1052#1086#1076#1077#1083#1100' "'#1075#1077#1085#1077#1090#1080#1095#1077#1089#1082#1072#1103'" '#1089' '#1074#1083#1080#1103#1085#1080#1077#1084' '#1094#1077#1085#1079#1091#1088#1080#1088#1086#1074#1072#1085#1080#1103
      Brush.BackColor = clDefault
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series16: TBarSeries
      HoverElement = []
      Active = False
      Marks.Visible = False
      MultiBar = mbStacked
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
    object Series22: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = clFuchsia
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series23: TLineSeries
      HoverElement = [heCurrent]
      SeriesColor = 16744703
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 401
    Width = 1298
    Height = 716
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BackWall.Pen.Visible = False
    Legend.Alignment = laBottom
    Legend.ColorWidth = 25
    Legend.Font.Height = -9
    Legend.Frame.Visible = False
    Legend.Symbol.Pen.Color = 33554432
    Legend.Symbol.Pen.Width = 0
    Legend.Symbol.Width = 25
    Legend.TopPos = 3
    Legend.VertMargin = 2
    MarginBottom = 3
    MarginTop = 3
    Title.Color = clBlack
    Title.Font.Color = clBlack
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1086#1090#1086#1082#1072' '#1086#1090#1082#1072#1079#1086#1074' '#1074' '#1090#1077#1095#1077#1085#1080#1077' '#1075#1072#1088#1072#1085#1090#1080#1081#1085#1086#1075#1086' '#1087#1077#1088#1080#1086#1076#1072)
    Frame.Visible = False
    LeftAxis.Title.Caption = #1054#1090#1082#1072#1079#1086#1074' '#1079#1072' 100 '#1095#1072#1089' '#1085#1072' 1 '#1080#1079#1076#1077#1083#1080#1077
    LeftAxis.Title.Font.Height = -11
    LeftAxis.Title.Font.Style = [fsBold]
    Panning.MouseWheel = pmwNone
    RightAxis.Title.Caption = #1053#1072#1082#1086#1087#1083#1077#1085#1080#1077' '#1086#1090#1082#1072#1079#1086#1074', '#1091#1093#1086#1076' '#1080#1079' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1103' ('#1075#1072#1088#1072#1085#1090#1080#1080'), %'
    RightAxis.Title.Font.Height = -11
    RightAxis.Title.Font.Style = [fsBold]
    Shadow.Visible = False
    View3D = False
    View3DOptions.FontZoom = 140
    Zoom.MouseWheel = pmwNormal
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    Anchors = [akLeft, akTop, akBottom]
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series4: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = #1052#1086#1076#1077#1083#1100' '#1087#1086' '#1057#1084#1080#1088#1085#1086#1074#1091
      LegendTitle = #1052#1086#1076#1077#1083#1100' '#1087#1086' '#1057#1084#1080#1088#1085#1086#1074#1091
      SeriesColor = clBlue
      Title = #1052#1086#1076#1077#1083#1100' '#1087#1086' '#1057#1084#1080#1088#1085#1086#1074#1091
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
      LinePen.Width = 2
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
      Depth = 0
      Marks.Visible = True
      Marks.Style = smsValue
      Marks.SoftClip = True
      PercentFormat = '##0.# %'
      SeriesColor = 4194368
      Title = #1053#1072#1082#1086#1087#1083#1077#1085#1080#1077' '#1086#1090#1082#1072#1079#1086#1074' '#1092#1072#1082#1090#1080#1095#1089#1077#1082#1086#1077' % '#1087#1072#1088#1082#1072
      ValueFormat = '#,##0.#'
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      LinePen.Style = psDash
      LinePen.Width = 4
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loNone
      YValues.Name = 'Y'
      YValues.Order = loAscending
    end
    object Series3: TLineSeries
      HoverElement = [heCurrent]
      Legend.Visible = False
      SeriesColor = clLime
      ShowInLegend = False
      Title = #1052#1086#1076#1077#1083#1100' '#1087#1086' '#1055#1080#1088#1089#1086#1085#1091
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
      LinePen.Width = 3
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Transparency = 12
    end
    object Series2: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = 'Pirson/'#1057#1057' 1.1'
      LegendTitle = 'Pirson/'#1057#1057' 1.1'
      SeriesColor = 43520
      Title = #1052#1086#1076#1077#1083#1100' '#1087#1086' '#1055#1080#1088#1089#1086#1085#1091' '#1089' '#1074#1083#1080#1103#1085#1080#1077#1084' '#1094#1077#1085#1079#1091#1088#1080#1088#1086#1074#1072#1085#1080#1103
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
      LinePen.Width = 3
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series1: TAreaSeries
      HoverElement = [heCurrent]
      Legend.Text = #1042#1099#1073#1099#1074#1072#1085#1080#1077
      LegendTitle = #1042#1099#1073#1099#1074#1072#1085#1080#1077
      Gradient.Visible = True
      SeriesColor = clYellow
      Title = #1042#1099#1073#1099#1074#1072#1085#1080#1077' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080
      VertAxis = aRightAxis
      AreaBrush = bsHorizontal
      AreaChartBrush.Color = 8454143
      AreaChartBrush.Style = bsHorizontal
      AreaChartBrush.BackColor = clDefault
      AreaChartBrush.Gradient.Visible = True
      AreaLinesPen.Color = clYellow
      AreaLinesPen.Width = 0
      AreaLinesPen.Visible = False
      DrawArea = True
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series20: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = 'Pirson/Newton 1.2'
      LegendTitle = 'Pirson/Newton 1.2'
      SeriesColor = 15728880
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
      LineHeight = 1
      LinePen.Width = 3
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series21: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = 'Pirson/Newton 1.2 '#1094#1077#1085#1079'.'
      LegendTitle = 'Pirson/Newton 1.2 '#1094#1077#1085#1079'.'
      SeriesColor = 16744703
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
      LineHeight = 1
      LinePen.Width = 3
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series6: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = #1043#1077#1085#1077#1090#1080#1095#1077#1089#1082#1072#1103
      LegendTitle = #1043#1077#1085#1077#1090#1080#1095#1077#1089#1082#1072#1103
      SeriesColor = 7303167
      Title = #1052#1086#1076#1077#1083#1100' "'#1075#1077#1085#1077#1090#1080#1095#1077#1089#1082#1072#1103'"'
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
      LinePen.Width = 3
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series5: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = #1043#1077#1085#1077#1090#1080#1095#1077#1089#1082#1072#1103' '#1094#1077#1085#1079'.'
      Legend.Visible = False
      LegendTitle = #1043#1077#1085#1077#1090#1080#1095#1077#1089#1082#1072#1103' '#1094#1077#1085#1079'.'
      Emboss.Visible = True
      SeriesColor = clRed
      ShowInLegend = False
      Title = #1052#1086#1076#1077#1083#1100' "'#1075#1077#1085#1077#1090#1080#1095#1077#1089#1082#1072#1103'" '#1089' '#1074#1083#1080#1103#1085#1080#1077#1084' '#1094#1077#1085#1079#1091#1088#1080#1088#1086#1074#1072#1085#1080#1103
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
      LinePen.Width = 3
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
      Legend.Visible = False
      Active = False
      ShowInLegend = False
      MultiBar = mbStacked
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
    object Series24: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = 'Go '#1043#1077#1085#1077#1090#1080#1095'.'
      LegendTitle = 'Go '#1043#1077#1085#1077#1090#1080#1095'.'
      SeriesColor = 16744576
      Title = #1052#1086#1076#1077#1083#1100' Go'
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
      LinePen.Width = 3
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Transparency = 9
    end
  end
  object Chart3: TChart
    Left = 0
    Top = 7
    Width = 782
    Height = 390
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    AllowPanning = pmNone
    Legend.Alignment = laBottom
    Legend.ColorWidth = 50
    Legend.Symbol.Width = 50
    Legend.Title.Visible = False
    Legend.TopPos = 8
    Legend.Visible = False
    SubTitle.Font.Height = -13
    SubTitle.Font.Style = [fsBold]
    Title.Font.Color = clBlack
    Title.Margins.Left = 5
    Title.Margins.Top = 3
    Title.Margins.Right = 8
    Title.Margins.Bottom = 4
    Title.Text.Strings = (
      
        #1054#1090#1082#1072#1079#1099' - '#1092#1072#1082#1090' '#1080' '#1089' '#1082#1086#1088#1088#1077#1082#1094#1080#1077#1081' '#1087#1086' '#1074#1099#1073#1099#1074#1072#1085#1080#1102' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080', Ln '#1082#1086#1083#1080#1095#1077 +
        #1089#1090#1074#1072
      #1045#1089#1083#1080' '#1087#1086#1090#1086#1082' '#1089#1085#1080#1078#1072#1077#1090#1089#1103', '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1075#1072#1088#1072#1085#1090#1080#1081#1085#1086#1075#1086' '#1089#1088#1086#1082#1072' '#1079#1072#1074#1099#1096#1077#1085#1099' ')
    BottomAxis.Title.Caption = #1042#1088#1077#1084#1103' '#1085#1072#1088#1072#1073#1086#1090#1082#1080', '#1095#1072#1089
    BottomAxis.Title.Font.Height = -11
    LeftAxis.Title.Caption = #1054#1090#1082#1072#1079#1086#1074' '#1079#1072' 100 '#1095#1072#1089'. '#1085#1072' '#1080#1079#1076#1077#1083#1080#1077
    LeftAxis.Title.Font.Height = -11
    LeftAxis.Title.Font.Style = [fsBold]
    RightAxis.LogarithmicBase = 2.718281828459050000
    RightAxis.Title.Caption = 'Ln '#1095#1080#1089#1083#1072' '#1086#1090#1082#1072#1079#1086#1074
    RightAxis.Title.Font.Height = -11
    TopAxis.LogarithmicBase = 2.718281828459050000
    TopAxis.Title.Caption = 'Ln '#1074#1088#1077#1084#1077#1085#1080' '#1085#1072#1088#1072#1073#1086#1090#1082#1080
    TopAxis.Title.Font.Height = -11
    View3D = False
    View3DOptions.FontZoom = 140
    View3DWalls = False
    Color = clWhite
    TabOrder = 2
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series13: TLineSeries
      HoverElement = [heCurrent]
      Active = False
      Marks.Margins.Top = 2
      Marks.Margins.Right = 12
      Marks.Margins.Bottom = 2
      Stacked = cssStack
      Title = #1042#1099#1073#1099#1074#1072#1085#1080#1077' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series18: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = 'Ln '#1053#1072#1082#1086#1087#1083#1077#1085#1080#1103
      LegendTitle = 'Ln '#1053#1072#1082#1086#1087#1083#1077#1085#1080#1103
      HorizAxis = aTopAxis
      Marks.DrawEvery = 2
      SeriesColor = 4194432
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psCross
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series19: TLineSeries
      HoverElement = [heCurrent]
      Legend.Text = #1040#1087#1087#1088#1086#1082#1089#1080#1084#1072#1094#1080#1103' Ln '#1085#1072#1082#1086#1087#1083#1077#1085#1080#1103
      LegendTitle = #1040#1087#1087#1088#1086#1082#1089#1080#1084#1072#1094#1080#1103' Ln '#1085#1072#1082#1086#1087#1083#1077#1085#1080#1103
      HorizAxis = aTopAxis
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Result_Grid: TStringGrid
    Left = 782
    Top = 36
    Width = 1102
    Height = 365
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alCustom
    Anchors = []
    BevelEdges = [beTop, beRight]
    BevelOuter = bvSpace
    BorderStyle = bsNone
    ColCount = 7
    Ctl3D = True
    DefaultColWidth = 237
    DefaultRowHeight = 28
    DragCursor = crNo
    DragKind = dkDock
    FixedCols = 0
    RowCount = 12
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing, goTabs]
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssHorizontal
    TabOrder = 3
  end
  object Prodolgenie: TButton
    Left = 1691
    Top = 2
    Width = 97
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alCustom
    Anchors = [akRight]
    Caption = #1055#1088#1086#1076#1086#1083#1078'.'
    Constraints.MaxHeight = 32
    Constraints.MaxWidth = 98
    Constraints.MinHeight = 32
    Constraints.MinWidth = 97
    TabOrder = 5
    OnClick = ProdolgenieClick
  end
  object Button1: TButton
    Left = 1585
    Top = 2
    Width = 98
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = []
    Caption = #1055#1077#1095#1072#1090#1100
    Constraints.MaxHeight = 32
    Constraints.MaxWidth = 98
    Constraints.MinHeight = 32
    Constraints.MinWidth = 98
    TabOrder = 4
    OnClick = Button1Click
  end
  object PrintDialog1: TPrintDialog
    Options = [poPrintToFile]
    Left = 1563
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 1562
    Top = 16
  end
end
