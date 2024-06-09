object Form2: TForm2
  Left = 0
  Top = 0
  AutoSize = True
  BorderWidth = 1
  Caption = #1058#1103#1075#1086#1074#1086'-'#1076#1080#1085#1072#1084#1080#1095#1077#1089#1082#1080#1081' '#1088#1072#1089#1095#1077#1090' '#1084#1072#1096#1080#1085#1099' '#1089' '#1043#1052#1055'. v2 2019, '#1040'.'#1044#1102#1078#1077#1074
  ClientHeight = 802
  ClientWidth = 1376
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
    Top = 62
    Width = 138
    Height = 32
    Caption = '1. '#1043#1088#1072#1092#1080#1082' Md-Mturb'
    TabOrder = 0
    OnClick = GrafikBtnClick
  end
  object Memo1: TMemo
    Left = 799
    Top = 497
    Width = 577
    Height = 304
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object OpenDannFile: TButton
    Left = 215
    Top = 6
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
    Top = 6
    Width = 770
    Height = 21
    TabOrder = 4
  end
  object Chart1: TChart
    Left = 215
    Top = 62
    Width = 578
    Height = 484
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
    Top = 178
    Width = 138
    Height = 32
    Caption = '3'#1072'. '#1057#1090#1091#1087#1077#1085#1080' '#1087#1086' Igt'
    TabOrder = 6
    OnClick = Igt_ShagClick
  end
  object PrintForm: TButton
    Left = 1224
    Top = 255
    Width = 138
    Height = 32
    Caption = '3'#1074'. '#1055#1077#1095#1072#1090#1100' '#1092#1086#1088#1084#1099
    TabOrder = 8
    OnClick = PrintFormClick
  end
  object Pk_Shag: TButton
    Left = 1224
    Top = 216
    Width = 138
    Height = 32
    Caption = '3'#1073'. '#1056#1072#1085#1078#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086' Pk'
    TabOrder = 9
    OnClick = Pk_ShagClick
  end
  object V_Pk_Grafik: TButton
    Left = 1224
    Top = 100
    Width = 138
    Height = 32
    Caption = '2'#1072'. '#1043#1088#1072#1092#1080#1082' V-Pk '#1074#1087#1077#1088#1077#1076
    TabOrder = 10
    OnClick = V_Pk_GrafikClick
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
    TabOrder = 11
  end
  object Button1: TButton
    Left = 1224
    Top = 139
    Width = 138
    Height = 32
    Caption = '2'#1073'. '#1043#1088#1072#1092#1080#1082' V-Pk '#1085#1072#1079#1072#1076
    TabOrder = 12
    OnClick = Button1Click
  end
  object DiselWybor: TRadioGroup
    Left = 0
    Top = 544
    Width = 793
    Height = 258
    Caption = #1044#1080#1079#1077#1083#1100
    Color = clWhite
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 2
    Items.Strings = (
      #1052#1052#1047' 245.'#1057'2'#1057' 90 '#1082#1042#1090' 2200 '#1084#1080#1085'-1'
      #1052#1052#1047' 245.16'#1057'2 90 '#1082#1042#1090' 1800 '#1084#1080#1085'-1'
      #1052#1052#1047' '#1044'245'#1057'2 121 '#1083'.'#1089'./89 '#1082#1042#1090' 2200 '#1084#1080#1085'-1'
      #1052#1052#1047' 260.2 130 ps/95.6 '#1082#1042#1090' 2100 '#1084#1080#1085'-1'
      #1052#1052#1047' 260.1s2 158 '#1083'.'#1089'./116 '#1082#1042#1090
      #1052#1052#1047' 260.9 180 '#1083'.'#1089'./132 '#1082#1042#1090
      #1052#1052#1047' 260.9 S2 180 '#1083'.'#1089'/132 '#1082#1042#1090' 2100 '#1084#1080#1085'-1'
      #1052#1052#1047' 260.7 245 '#1083'.'#1089'./180 '#1082#1042#1090' 2100 '#1084#1080#1085'-1'
      #1052#1052#1047' 262.1S2 280 '#1083'.'#1089'./206 '#1082#1042#1090
      'Deutz BF4M1013EC (ZF) 141 '#1083'.'#1089'./104 '#1082#1042#1090
      'Deutz BF6M2012C 158 '#1083'.'#1089'./116 '#1082#1042#1090
      'Cummins QSB4.5-C110-30 112 '#1083'.'#1089'./82 kW 2200 '#1084#1080#1085'-1'
      'Cummins 6B5.9 FR90870 173 '#1083'.'#1089'.'
      'CumminsQSB 6.7 FR94284-EN02 179 '#1083'.'#1089'. 129 kW 2200 '#1084#1080#1085'-1'
      'Cummins 6'#1057#1058#1040#1040'8.3 C260 265 '#1083'.'#1089'.'
      'Cummins QSM11 360 '#1083'.'#1089'./267 kW 2100 '#1084#1080#1085'-1'
      'Perkins 1106D-E66TA 185 '#1083'.'#1089'.'
      #1071#1052#1047' 236'#1052'2 180 '#1083'.'#1089'. 2100 '#1084#1080#1085'-1'
      #1071#1052#1047' 5344 136 '#1083'.'#1089'. 2300 '#1084#1080#1085'-1'
      #1071#1052#1047' 65652 197 '#1082#1042#1090'/270 '#1083#1089' 2100 '#1084'-1'
      #1071#1052#1047' 6566 198 '#1082#1042#1090' 1900 '#1084#1080#1085'-1'
      #1071#1052#1047' 7601.10 221 '#1082#1042#1090' 1900 '#1084#1080#1085'-1'
      'Iveco F4GE0684Q*D6 152 '#1083'.'#1089'./112 kW 2200 '#1084#1080#1085'-1'
      'Iveco F4HE0684E*D1 182 '#1083'.'#1089'./134 kW 2200 '#1084#1080#1085'-1'
      'WP6G175E331 175 '#1083'.'#1089'./130 kW 2200 '#1084#1080#1085'-1'
      'WP6G180E331 180 '#1083'.'#1089'./132 kW 2000 '#1084#1080#1085'-1')
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 7
  end
  object GMPWybor: TRadioGroup
    Tag = 2
    Left = 1
    Top = 6
    Width = 209
    Height = 540
    Caption = #1043#1080#1076#1088#1086#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088
    Color = clWhite
    ItemIndex = 5
    Items.Strings = (
      'W300  1.87/104 (ZF  '#1041#1088#1103#1085#1089#1082')'
      #1043#1058'280'
      'P-O 305 3.0/48.8'
      #1043#1058' 320  2.767/105'
      'Dana 330  2.13/175'
      #1051#1043' 340 ('#1051#1100#1074#1086#1074' 2005) 2.66/133'
      #1043#1058#1044'340 2.64/130'
      #1043#1058' 350  2.567/152 '
      #1043#1058' 350  2.725/148'
      #1043#1058' 350  2.512/139 v.0'
      #1043#1058' 350  2.859/126'
      #1043#1058'350 2.86/123'
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
    Top = 0
    Width = 152
    Height = 57
    Caption = #1042#1080#1076' '#1090#1103#1075#1086#1074#1086#1075#1086' '#1088#1072#1089#1095#1077#1090#1072
    ItemIndex = 0
    Items.Strings = (
      #1044#1083#1103' '#1090#1088#1072#1082#1090#1086#1088#1072
      #1044#1083#1103' '#1076#1088#1091#1075#1086#1081' '#1084#1072#1096#1080#1085#1099)
    TabOrder = 13
  end
  object Panel1: TPanel
    Left = 799
    Top = 330
    Width = 577
    Height = 141
    Color = clHighlightText
    ParentBackground = False
    TabOrder = 14
    object Label1: TLabel
      Left = 8
      Top = 0
      Width = 74
      Height = 13
      Caption = #1042#1099#1074#1086#1076' '#1074' Excel:'
    end
    object Label2: TLabel
      Left = 218
      Top = 78
      Width = 106
      Height = 28
      Caption = #1052#1072#1089#1089#1072' '#1075#1088#1091#1079#1072' '#1087#1088#1080' '#1088#1072#1079#1075#1086#1085#1077', '#1082#1075
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label3: TLabel
      Left = 336
      Top = 38
      Width = 169
      Height = 42
      Caption = 
        #1059#1089#1082#1086#1088#1077#1085#1080#1077' '#1078#1077#1083#1072#1077#1084#1086#1077' '#1084'/'#1089'2 '#1085#1072' '#1087#1077#1088#1077#1076#1072#1095#1072#1093'-'#1085#1072#1095#1072#1083#1100#1085#1086#1081' '#1080' '#1087#1086#1089#1083#1077#1076#1091#1102#1097#1080#1093' '#1087#1077#1088 +
        #1077#1076#1072#1095#1072#1093
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label4: TLabel
      Left = 0
      Top = 78
      Width = 142
      Height = 14
      Caption = #1055#1077#1088#1077#1076#1072#1095#1080' '#1087#1088#1080' '#1088#1072#1079#1075#1086#1085#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 0
      Top = 94
      Width = 54
      Height = 13
      Caption = #1085#1072#1095#1072#1083#1100#1085#1072#1103
    end
    object Label6: TLabel
      Left = 88
      Top = 94
      Width = 48
      Height = 13
      Caption = #1082#1086#1085#1077#1095#1085#1072#1103
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
    object Edit3: TEdit
      Left = 248
      Top = 112
      Width = 41
      Height = 21
      TabOrder = 5
      Text = '4700'
    end
    object Usk_strt: TEdit
      Left = 520
      Top = 32
      Width = 41
      Height = 21
      TabOrder = 6
      Text = '2'
    end
    object I_end: TEdit
      Left = 104
      Top = 113
      Width = 25
      Height = 21
      TabOrder = 7
      Text = '3'
    end
    object I_Start: TEdit
      Left = 16
      Top = 113
      Width = 25
      Height = 21
      TabOrder = 8
      Text = '1'
    end
    object Usk_p1: TEdit
      Left = 520
      Top = 59
      Width = 41
      Height = 21
      TabOrder = 9
      Text = '2'
    end
    object Usk_p2: TEdit
      Left = 520
      Top = 86
      Width = 41
      Height = 21
      TabOrder = 10
      Text = '1.5'
    end
    object Usk_p3: TEdit
      Left = 520
      Top = 113
      Width = 41
      Height = 21
      TabOrder = 11
      Text = '1'
    end
    object Button3: TButton
      Left = 216
      Top = 40
      Width = 105
      Height = 32
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1086#1082#1085#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnClick = Button3Click
    end
  end
  object Button2: TButton
    Left = 1224
    Top = 294
    Width = 138
    Height = 32
    Caption = 'Stop Excel'
    TabOrder = 15
    OnClick = Button2Click
  end
  object T_Dinam: TButton
    Left = 799
    Top = 370
    Width = 188
    Height = 32
    Caption = #1058#1103#1075#1086#1074#1086#1089#1082#1086#1088#1086#1089#1090#1085#1086#1081' '#1088#1072#1089#1095#1077#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    OnClick = T_DinamClick
  end
  object Edit1: TEdit
    Left = 216
    Top = 33
    Width = 577
    Height = 21
    TabOrder = 17
    Text = 'Edit1'
  end
  object TD_out: TEdit
    Left = 799
    Top = 477
    Width = 577
    Height = 21
    TabOrder = 18
    Text = 
      '          t, '#1089'             S, '#1084'          I'#1075#1090'        V, '#1082#1084'/'#1095'     ' +
      '     '#1072', '#1084'/c2   n'#1076#1074' '#1084#1080#1085'-1     '#1050#1055#1044'%'
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
