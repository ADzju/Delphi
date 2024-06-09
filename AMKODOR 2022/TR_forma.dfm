object Form2: TForm2
  Left = 0
  Top = 0
  Align = alLeft
  AutoSize = True
  Caption = #1058#1103#1075#1086#1074#1099#1081' '#1088#1072#1089#1095#1077#1090' '#1084#1072#1096#1080#1085#1099' '#1089' '#1043#1052#1055'. '#1040'.'#1044#1102#1078#1077#1074', 2015-2019'
  ClientHeight = 804
  ClientWidth = 1384
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GrafikBtn: TButton
    Left = 1224
    Top = 64
    Width = 138
    Height = 32
    Caption = '1. '#1043#1088#1072#1092#1080#1082' Md-Mturb'
    TabOrder = 0
    OnClick = GrafikBtnClick
  end
  object Memo1: TMemo
    Left = 792
    Top = 375
    Width = 592
    Height = 466
    Color = clWhite
    Lines.Strings = (
      #1057#1086#1074#1084#1077#1089#1090#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' '#1044#1042#1057' '#1080' '#1075#1080#1076#1088#1086#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088#1072)
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object OpenDannFile: TButton
    Left = 215
    Top = 8
    Width = 210
    Height = 25
    Caption = #1060#1072#1081#1083' '#1089' '#1087#1077#1088#1077#1076#1072#1090#1086#1095#1085#1099#1084#1080' '#1050#1055', '#1084#1086#1089#1090#1072' '#1080' Rk'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    StyleElements = [seFont, seClient]
    OnClick = OpenDannFileClick
  end
  object FilePath: TEdit
    Left = 431
    Top = 8
    Width = 770
    Height = 21
    TabOrder = 4
  end
  object Chart1: TChart
    Left = 215
    Top = 64
    Width = 578
    Height = 458
    Legend.Alignment = laBottom
    Legend.DrawBehind = True
    Title.Font.Color = clBlack
    Title.Font.Height = -21
    Title.Text.Strings = (
      #1057#1086#1075#1083#1072#1089#1086#1074#1072#1085#1080#1077' '#1076#1080#1079#1077#1083#1103' '#1089' '#1043#1052#1055)
    LeftAxis.LabelsFormat.Font.Height = -16
    LeftAxis.Title.Caption = 'M, '#1053#1084
    LeftAxis.Title.Font.Height = -16
    LeftAxis.Title.Font.Style = [fsBold]
    View3D = False
    Color = clWhite
    TabOrder = 5
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
  end
  object Igt_Shag: TButton
    Left = 1224
    Top = 180
    Width = 138
    Height = 32
    Caption = '3'#1072'. '#1057#1090#1091#1087#1077#1085#1080' '#1087#1086' Igt'
    TabOrder = 6
    OnClick = Igt_ShagClick
  end
  object PrintForm: TButton
    Left = 1224
    Top = 257
    Width = 138
    Height = 32
    Caption = '3'#1074'. '#1055#1077#1095#1072#1090#1100' '#1092#1086#1088#1084#1099
    TabOrder = 8
    OnClick = PrintFormClick
  end
  object Pk_Shag: TButton
    Left = 1224
    Top = 218
    Width = 138
    Height = 32
    Caption = '3'#1073'. '#1056#1072#1085#1078#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086' Pk'
    TabOrder = 9
    OnClick = Pk_ShagClick
  end
  object V_Pk_Grafik: TButton
    Left = 1224
    Top = 102
    Width = 138
    Height = 32
    Caption = '2'#1072'. '#1043#1088#1072#1092#1080#1082' V-Pk '#1074#1087#1077#1088#1077#1076
    TabOrder = 10
    OnClick = V_Pk_GrafikClick
  end
  object Edit1: TEdit
    Left = 215
    Top = 39
    Width = 578
    Height = 21
    TabOrder = 11
  end
  object StringGrid1: TStringGrid
    Left = 799
    Top = 39
    Width = 402
    Height = 287
    ColCount = 4
    Ctl3D = False
    DefaultRowHeight = 18
    FixedColor = clBtnHighlight
    RowCount = 14
    GradientEndColor = clBtnFace
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentCtl3D = False
    ScrollBars = ssNone
    TabOrder = 12
  end
  object Button1: TButton
    Left = 1224
    Top = 141
    Width = 138
    Height = 32
    Caption = '2'#1073'. '#1043#1088#1072#1092#1080#1082' V-Pk '#1085#1072#1079#1072#1076
    TabOrder = 13
    OnClick = Button1Click
  end
  object DiselWybor: TRadioGroup
    Left = 0
    Top = 528
    Width = 793
    Height = 273
    Caption = #1044#1080#1079#1077#1083#1100
    Color = clWhite
    Columns = 3
    ItemIndex = 2
    Items.Strings = (
      #1052#1052#1047' 245.'#1057'2'#1057' 90 '#1082#1042#1090' 2200 '#1084#1080#1085'-1'
      #1052#1052#1047' 245.16'#1057' 90 '#1082#1042#1090' 1800 '#1084#1080#1085'-1'
      #1052#1052#1047' 260.2 95.6 '#1082#1042#1090' 2100 '#1084#1080#1085'-1'
      #1052#1052#1047' 260.1s2 158 '#1083'.'#1089'.'
      #1052#1052#1047' 260.9 180 '#1083'.'#1089'.'
      #1052#1052#1047' 260.7 180 '#1082#1042#1090' 2100 '#1084#1080#1085'-1'
      #1052#1052#1047' 262.1S2 280 '#1083'.'#1089'.'
      'Deutz BF4M1013EC (ZF)'
      'Deutz BF6M2012C 158 '#1083'.'#1089'.'
      'Iveco F4GE0684Q*D6 152 '#1083'.'#1089'.'
      'Iveco F4HE0684E*D1 182 '#1083'.'#1089'.'
      'Cummins 6B5.9 FR90870 173 '#1083'.'#1089'.'
      'Cummins 6'#1057#1058#1040#1040'8.3 C260 265 '#1083'.'#1089'.'
      'Perkins 1106D-E66TA 185 '#1083'.'#1089'.'
      #1071#1052#1047' 236 180 '#1083'.'#1089'. 2100 '#1084#1080#1085'-1'
      #1071#1052#1047' 5344 136 '#1083'.'#1089'. 2300 '#1084#1080#1085'-1'
      #1071#1052#1047' 65652 197 '#1082#1042#1090'/270 '#1083#1089' 2100 '#1084'-1'
      #1071#1052#1047' 6566 198 '#1082#1042#1090' 1900 '#1084#1080#1085'-1'
      #1071#1052#1047' 7601.10 221 '#1082#1042#1090' 1900 '#1084#1080#1085'-1'
      #1052#1052#1047' 245'#1057'2 80 '#1082#1042#1090' 2200 '#1084#1080#1085'-1')
    ParentBackground = False
    ParentColor = False
    TabOrder = 7
  end
  object GMPWybor: TRadioGroup
    Tag = 2
    Left = 0
    Top = 1
    Width = 209
    Height = 521
    Caption = #1043#1080#1076#1088#1086#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088
    Color = clWhite
    ItemIndex = 5
    Items.Strings = (
      'W300  1.87/104 (ZF  '#1041#1088#1103#1085#1089#1082')'
      #1043#1058' 280'
      'P-O 305 3.0/48.8'
      #1043#1058' 320  2.767/105'
      'Dana 330  2.13/175'
      #1051#1043' 340 ('#1051#1100#1074#1086#1074' 2005) 2.66/133'
      #1043#1058#1044'340 2.64/130'
      #1043#1058' 350  2.567/152 '
      #1043#1058' 350  2.725/148'
      #1043#1058' 350  2.512/139 v.0'
      #1043#1058' 350  2.859/126'
      'P-O-350/2.1.2  2.635/146'
      #1043#1058' 370 3.32/114'
      #1051'-370 '#1051#1080#1090#1084#1072#1096' 2.30/301'
      'W340 2.813/124 (ZF A371)'
      'W340 2.352/200'
      'W340 2.359/168'
      'W340 1.540/288'
      'W370 2.30 2.104/240'
      'Dana 380 3.09/133')
    ParentBackground = False
    ParentColor = False
    TabOrder = 2
  end
  object RadioGroup1: TRadioGroup
    Left = 1224
    Top = 1
    Width = 152
    Height = 57
    Caption = #1042#1080#1076' '#1090#1103#1075#1086#1074#1086#1075#1086' '#1088#1072#1089#1095#1077#1090#1072
    ItemIndex = 1
    Items.Strings = (
      #1044#1083#1103' '#1089#1087#1077#1094#1084#1072#1096#1080#1085#1099
      #1044#1083#1103' '#1090#1088#1072#1082#1090#1086#1088#1072)
    ParentShowHint = False
    ShowHint = False
    TabOrder = 14
  end
  object Panel1: TPanel
    Left = 799
    Top = 332
    Width = 577
    Height = 37
    Color = clHighlightText
    ParentBackground = False
    TabOrder = 15
    object Label1: TLabel
      Left = 8
      Top = 0
      Width = 74
      Height = 13
      Caption = #1042#1099#1074#1086#1076' '#1074' Excel:'
    end
    object CheckBox1: TCheckBox
      Left = 96
      Top = 0
      Width = 73
      Height = 17
      Caption = ' M'#1085#1072#1089#1086#1089#1072
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 176
      Top = 0
      Width = 81
      Height = 17
      Caption = ' M '#1084#1086#1090#1086#1088#1072
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 273
      Top = 0
      Width = 82
      Height = 17
      Caption = ' n '#1090#1091#1088#1073
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 361
      Top = 2
      Width = 97
      Height = 17
      Caption = ' '#1052' '#1090#1091#1088#1073#1080#1085#1099
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 464
      Top = 0
      Width = 97
      Height = 17
      Caption = #1052#1086#1097#1085#1086#1089#1090#1100' '#1043#1052#1055
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
  end
  object Button2: TButton
    Left = 1224
    Top = 296
    Width = 138
    Height = 32
    Caption = 'Stop Excel'
    TabOrder = 16
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Left = 640
    Top = 65528
  end
  object PrintDialog1: TPrintDialog
    Copies = 1
    Left = 727
    Top = 65531
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 768
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
    PageWidth = 21000
    PageHeight = 29700
    Left = 688
    Top = 65528
  end
end
