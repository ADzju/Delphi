object Form2: TForm2
  Left = 0
  Top = 0
  Caption = #1058#1103#1075#1086#1074#1099#1081' '#1088#1072#1089#1095#1077#1090' '#1084#1072#1096#1080#1085#1099' '#1089' '#1043#1052#1055'. '#1040'.'#1044#1102#1078#1077#1074', 2015'
  ClientHeight = 771
  ClientWidth = 1282
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
    Left = 1136
    Top = 35
    Width = 138
    Height = 40
    Caption = '1. '#1043#1088#1072#1092#1080#1082' Md-Mturb'
    TabOrder = 0
    OnClick = GrafikBtnClick
  end
  object Memo1: TMemo
    Left = 807
    Top = 331
    Width = 474
    Height = 438
    Color = clWhite
    Lines.Strings = (
      #1057#1086#1074#1084#1077#1089#1090#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' '#1044#1042#1057' '#1080' '#1075#1080#1076#1088#1086#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088#1072)
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object GMPWybor: TRadioGroup
    Tag = 2
    Left = 0
    Top = 8
    Width = 209
    Height = 345
    Caption = #1043#1058
    Color = clWhite
    ItemIndex = 5
    Items.Strings = (
      #1043#1058' 320 '#1074#1072#1088#1080#1072#1085#1090' 8'
      'Dana 330 K=2.13'
      #1043#1058' 350 '#1074#1072#1088#1080#1072#1085#1090' 4 '
      #1043#1058' 350 '#1074#1072#1088#1080#1072#1085#1090' 7 '
      #1043#1058' 350 '#1074#1072#1088#1080#1072#1085#1090' 10'
      'P-O-350 2.1.2 K=2.635'
      #1043#1058' 370 '#1074#1072#1088#1080#1072#1085#1090' 4'
      'ZF W300 1.87/416 ( '#1041#1088#1103#1085#1089#1082')'
      #1051#1043' 340 ('#1051#1100#1074#1086#1074' 2005)'
      #1043#1058' 305'
      'ZF W340 2.813/124 (A371)'
      'W340 2.352'
      'W340 1.540'
      'Dana 380/3.09')
    ParentBackground = False
    ParentColor = False
    TabOrder = 2
  end
  object OpenDannFile: TButton
    Left = 215
    Top = 8
    Width = 210
    Height = 21
    Caption = #1060#1072#1081#1083' '#1089' '#1087#1077#1088#1077#1076#1072#1090#1086#1095#1085#1099#1084#1080' '#1050#1055', '#1084#1086#1089#1090#1072' '#1080' Rk'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    OnClick = OpenDannFileClick
  end
  object FilePath: TEdit
    Left = 431
    Top = 8
    Width = 850
    Height = 21
    TabOrder = 4
  end
  object Chart1: TChart
    Left = 215
    Top = 64
    Width = 586
    Height = 705
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
    Left = 1136
    Top = 173
    Width = 138
    Height = 40
    Caption = '3'#1072'. '#1057#1090#1091#1087#1077#1085#1080' '#1087#1086' Igt'
    TabOrder = 6
    OnClick = Igt_ShagClick
  end
  object DiselWybor: TRadioGroup
    Left = 0
    Top = 359
    Width = 209
    Height = 410
    Caption = #1044#1080#1079#1077#1083#1100
    Color = clWhite
    ItemIndex = 2
    Items.Strings = (
      #1071#1052#1047'236'
      #1052#1052#1047' 260.1'
      #1052#1052#1047' 260.9 180 '#1083'.'#1089'.'
      'Deutz BF4M1013EC (ZF)'
      'Deutz BF6M2012C 158 '#1083'.'#1089'.'
      'Iveco F4GE0684Q*D6 152 '#1083'.'#1089'.'
      'Iveco F4HE0684E*D1 182 '#1083'.'#1089'.'
      'Cummins 6B5.9 FR90870 173 '#1083'.'#1089'.'
      'Perkins: 1106D-E66TA 185 '#1083'.'#1089'.'
      #1052#1052#1047' 245.'#1057'2'#1057' 90 '#1082#1042#1090' 2200 '#1084#1080#1085'-1'
      #1052#1052#1047' 245.16'#1057' 90 '#1082#1042#1090' 1800 '#1084#1080#1085'-1'
      #1071#1052#1047' 65652 197 '#1082#1042#1090'/270 '#1083#1089' 2100 '#1084'-1'
      #1071#1052#1047' 6566 198 '#1082#1042#1090' 1900 '#1084#1080#1085'-1'
      #1071#1052#1047' 7601.10 221 '#1082#1042#1090' 1900 '#1084#1080#1085'-1'
      'Cummins 6'#1057#1058#1040#1040'8.3 C260 265 '#1083'.'#1089'.')
    ParentBackground = False
    ParentColor = False
    TabOrder = 7
  end
  object PrintForm: TButton
    Left = 1136
    Top = 265
    Width = 138
    Height = 40
    Caption = '3'#1074'. '#1055#1077#1095#1072#1090#1100' '#1092#1086#1088#1084#1099
    TabOrder = 8
    OnClick = PrintFormClick
  end
  object Pk_Shag: TButton
    Left = 1136
    Top = 219
    Width = 138
    Height = 40
    Caption = '3'#1073'. '#1056#1072#1085#1078#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086' Pk'
    TabOrder = 9
    OnClick = Pk_ShagClick
  end
  object V_Pk_Grafik: TButton
    Left = 1136
    Top = 81
    Width = 138
    Height = 40
    Caption = '2'#1072'. '#1043#1088#1072#1092#1080#1082' V-Pk '#1074#1087#1077#1088#1077#1076
    TabOrder = 10
    OnClick = V_Pk_GrafikClick
  end
  object Edit1: TEdit
    Left = 215
    Top = 32
    Width = 586
    Height = 21
    TabOrder = 11
  end
  object StringGrid1: TStringGrid
    Left = 807
    Top = 35
    Width = 310
    Height = 295
    ColCount = 3
    DefaultRowHeight = 18
    RowCount = 14
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 12
  end
  object Button1: TButton
    Left = 1136
    Top = 127
    Width = 138
    Height = 40
    Caption = '2'#1073'. '#1043#1088#1072#1092#1080#1082' V-Pk '#1085#1072#1079#1072#1076
    TabOrder = 13
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    Left = 640
    Top = 65520
  end
  object PrintDialog1: TPrintDialog
    Copies = 1
    Left = 831
    Top = 65523
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 912
    Top = 65528
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
    Left = 760
    Top = 65528
  end
end
