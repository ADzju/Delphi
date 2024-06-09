object LNview: TLNview
  Left = 0
  Top = 0
  Caption = 
    #1040#1085#1072#1083#1080#1079' '#1079#1072#1082#1086#1085#1072' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1103' '#1086#1090#1082#1072#1079#1086#1074'. '#1040#1085#1072#1083#1080#1079' '#1085#1072#1076#1077#1078#1085#1086#1089#1090#1080' '#1074' '#1101#1082#1089#1087#1083#1091#1072 +
    #1090#1072#1094#1080#1080'.  v.5.0'#169' '#1040'. '#1044#1102#1078#1077#1074', 2022'
  ClientHeight = 546
  ClientWidth = 838
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Visible = True
  StyleName = 'Windows'
  OnClose = FormClose
  TextHeight = 15
  object Chart2: TChart
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 832
    Height = 540
    BackWall.Color = clWhite
    Legend.Alignment = laBottom
    Legend.ColorWidth = 30
    Legend.Symbol.Width = 30
    Legend.TopPos = 6
    Legend.Visible = False
    Title.Font.Color = clBlack
    Title.Font.Height = -18
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      #1053#1072#1082#1086#1087#1083#1077#1085#1085#1080#1077' '#1086#1090#1082#1072#1079#1086#1074' '#1087#1086' '#1074#1088#1077#1084#1077#1085#1080' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1103)
    BottomAxis.Axis.Style = psDash
    BottomAxis.AxisValuesFormat = '#,##0.#'
    BottomAxis.ExactDateTime = False
    BottomAxis.Grid.DrawAlways = True
    BottomAxis.Grid.DrawEvery = 2
    BottomAxis.Labels = False
    BottomAxis.LabelsFormat.Visible = False
    BottomAxis.LabelsSeparation = 30
    BottomAxis.LabelsSize = 2
    BottomAxis.LogarithmicBase = 2.718281828459050000
    BottomAxis.Title.Caption = 'Log t ('#1095#1072#1089#1086#1074')'
    BottomAxis.Title.Font.Style = [fsBold]
    BottomAxis.Title.Position = tpStart
    BottomAxis.TitleSize = 5
    Chart3DPercent = 20
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Axis.Style = psDash
    LeftAxis.Labels = False
    LeftAxis.LabelsFormat.Visible = False
    LeftAxis.LogarithmicBase = 2.718281828459050000
    LeftAxis.Title.Caption = 'Log N ('#1086#1090#1082#1072#1079#1086#1074')'
    LeftAxis.Title.Font.Style = [fsBold]
    Panning.MouseWheel = pmwNone
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    RightAxis.Maximum = 100.000000000000000000
    RightAxis.Title.Caption = #1042#1099#1073#1099#1074#1072#1085#1080#1077' '#1080#1079' '#1075#1072#1088#1072#1085#1090#1080#1080', %'
    RightAxis.Title.Font.Style = [fsBold]
    RightAxis.Visible = False
    View3D = False
    View3DWalls = False
    Zoom.Animated = True
    Zoom.AnimatedSteps = 4
    Align = alClient
    Color = clWhite
    TabOrder = 0
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Label1: TLabel
      Left = 579
      Top = 382
      Width = 34
      Height = 15
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 579
      Top = 405
      Width = 34
      Height = 15
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 97
      Top = 59
      Width = 4
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button2: TButton
      Left = 670
      Top = 4
      Width = 73
      Height = 22
      Caption = #1055#1077#1095#1072#1090#1100
      TabOrder = 0
      OnClick = Button2Click
    end
    object Prodolgenie: TButton
      Left = 750
      Top = 4
      Width = 75
      Height = 22
      Caption = #1055#1088#1086#1076#1086#1083#1078'.'
      TabOrder = 1
      OnClick = ProdolgenieClick
    end
    object Series1: TLineSeries
      HoverElement = [heCurrent]
      Marks.DrawEvery = 10
      Brush.BackColor = clDefault
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      HoverElement = [heCurrent]
      Legend.Visible = False
      ShowInLegend = False
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 1013
  end
  object PrintDialog1: TPrintDialog
    Options = [poPrintToFile]
    Left = 1013
    Top = 10
  end
end
