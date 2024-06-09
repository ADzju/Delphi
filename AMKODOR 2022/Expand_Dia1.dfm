object ExpandForm: TExpandForm
  AlignWithMargins = True
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'v 4.3 '#169' '#1040'. '#1044#1102#1078#1077#1074', 2021'
  ClientHeight = 1001
  ClientWidth = 1731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  ScreenSnap = True
  WindowState = wsMaximized
  PixelsPerInch = 120
  TextHeight = 17
  object Chart1: TChart
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 1723
    Height = 993
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    AllowPanning = pmHorizontal
    BackWall.Pen.Visible = False
    Legend.Alignment = laBottom
    Legend.CustomPosition = True
    Legend.Left = 110
    Legend.LeftPercent = 10
    Legend.PositionUnits = muPercent
    Legend.ResizeChart = False
    Legend.Title.Font.Height = -19
    Legend.Top = 583
    Legend.TopPercent = 93
    Legend.TopPos = 1
    Legend.VertMargin = 2
    MarginBottom = 9
    Title.Color = clBlack
    Title.Font.Color = clBlack
    Title.Font.Height = -19
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      
        #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1086#1090#1086#1082#1072' '#1086#1090#1082#1072#1079#1086#1074' '#1086#1090' '#1085#1072#1088#1072#1073#1086#1090#1095#1082#1080' ('#1084#1095#1072#1089') '#1074' '#1090#1077#1095#1077#1085#1080#1077' '#1075#1072#1088#1072#1085#1090#1080#1081 +
        #1085#1086#1075#1086' '#1087#1077#1088#1080#1086#1076#1072)
    Emboss.Smooth = False
    Frame.Visible = False
    LeftAxis.LabelsFormat.Font.Height = -16
    LeftAxis.Title.Caption = #1054#1090#1082#1072#1079#1086#1074' '#1079#1072' 100 '#1095#1072#1089' '#1085#1072' 1 '#1080#1079#1076#1077#1083#1080#1077
    LeftAxis.Title.Font.Height = -19
    LeftAxis.Title.Font.Style = [fsBold]
    Pages.AutoScale = True
    Pages.ScaleLastPage = False
    RightAxis.LabelsFormat.Font.Height = -16
    RightAxis.Title.Caption = #1044#1086#1083#1103' '#1086#1090#1082#1072#1079#1072#1074#1096#1080#1093', '#1074#1099#1073#1099#1074#1072#1085#1080#1077' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080', %'
    RightAxis.Title.Font.Height = -19
    RightAxis.Title.Font.Style = [fsBold]
    Shadow.Visible = False
    View3D = False
    View3DWalls = False
    Zoom.MinimumPixels = 12
    Align = alClient
    BorderWidth = 1
    TabOrder = 0
    Visible = False
    ExplicitWidth = 1374
    ExplicitHeight = 784
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Label1: TLabel
      Left = 3
      Top = 3
      Width = 82
      Height = 30
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      Alignment = taCenter
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 670
      Top = 1036
      Width = 46
      Height = 19
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Label2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 1150
      Top = 1036
      Width = 46
      Height = 19
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Label3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 161
      Top = 1036
      Width = 445
      Height = 19
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '50%-'#1103' '#1085#1072#1088#1072#1073#1086#1090#1082#1072' '#1085#1072' '#1086#1090#1082#1072#1079' '#1087#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1080#1088#1086#1074#1072#1085#1085#1099#1084' '#1089#1083#1091#1095#1072#1103#1084':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Button2: TButton
      Left = 11
      Top = 13
      Width = 62
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Print'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Series1: TLineSeries
      HoverElement = [heCurrent]
      Marks.Font.Height = -16
      SeriesColor = clYellow
      Title = #1042#1099#1073#1099#1074#1072#1085#1080#1077' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      DrawStyle = dsCurve
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
      SeriesColor = clRed
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
    object Series14: TBarSeries
      HoverElement = []
      Active = False
      MultiBar = mbStacked
      UseYOrigin = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
    object Series7: TLineSeries
      HoverElement = [heCurrent]
      Depth = 0
      Marks.Emboss.Clip = True
      Marks.Font.Height = -16
      Marks.Frame.Visible = False
      Marks.Shadow.Clip = True
      Marks.Transparent = True
      Marks.Visible = True
      Marks.Style = smsValue
      Marks.Callout.Style = psStar
      Marks.Callout.Length = 20
      Marks.Clip = True
      Marks.UseSeriesTransparency = False
      PercentFormat = '#.#%'
      SeriesColor = clRed
      Shadow.Clip = True
      Shadow.HorizSize = 2
      Shadow.VertSize = 2
      Title = #1042#1099#1073#1099#1074#1072#1085#1080#1077' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080' '#1101#1082#1089#1087'.'
      ValueFormat = '#.#'
      VertAxis = aRightAxis
      Brush.BackColor = clDefault
      LineHeight = 3
      LinePen.Style = psDash
      LinePen.Width = 3
      OutLine.Style = psDash
      OutLine.Width = 4
      Pointer.InflateMargins = True
      Pointer.Style = psDiagCross
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 16
    Top = 472
  end
  object PrintDialog1: TPrintDialog
    Copies = 1
    Left = 8
    Top = 48
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
    PageWidth = 29700
    PageHeight = 21000
    Left = 7
    Top = 112
  end
end
