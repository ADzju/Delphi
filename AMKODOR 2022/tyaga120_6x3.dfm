object Form3: TForm3
  Left = 0
  Top = 0
  Caption = #1043#1052#1055' 120 6'#1093'3 '#1040'.'#1040'.'#1044#1102#1078#1077#1074' 2015'
  ClientHeight = 487
  ClientWidth = 763
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 8
    Top = 421
    Width = 217
    Height = 28
    Caption = #1056#1072#1089#1095#1077#1090' '#1086#1076#1080#1085#1086#1095#1085#1099#1081
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Button1: TButton
    Left = 8
    Top = 455
    Width = 217
    Height = 31
    Caption = #1056#1072#1089#1095#1077#1090' '#1087#1072#1082#1077#1090#1086#1084' '#1080' '#1101#1082#1089#1087#1086#1088#1090
    TabOrder = 2
    OnClick = Button1Click
  end
  object StringGrid1: TStringGrid
    Left = 504
    Top = 295
    Width = 241
    Height = 147
    TabOrder = 3
  end
  object Memo1: TMemo
    Left = 231
    Top = 34
    Width = 530
    Height = 452
    Lines.Strings = (
      #1058#1103#1075#1086#1074#1099#1081' '#1088#1072#1089#1095#1077#1090' '#1043#1052#1055' 120 6'#1093'3')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 312
    Width = 217
    Height = 105
    Hint = #1040#1082#1090#1091#1072#1083#1100#1085#1099#1077' '#1084#1086#1076#1077#1083#1080' '#1085#1072' '#1072#1074#1075#1091#1089#1090' 2015'
    Caption = #1052#1086#1076#1077#1083#1100' '#1075#1080#1076#1088#1086#1090#1088#1072#1085#1089#1092#1086#1088#1084#1072#1090#1086#1088#1072
    ItemIndex = 1
    Items.Strings = (
      #1043#1058' 320 ('#1074#1072#1088#1080#1072#1085#1090' 8)'
      #1043#1058' 350 ('#1074#1072#1088#1080#1072#1085#1090' 10)'
      #1043#1058' 370 ('#1074#1072#1088#1080#1072#1085#1090' 4)'
      'ZF '#1082#1086#1084#1087#1083#1077#1082#1090)
    TabOrder = 4
  end
  object FilePath: TEdit
    Left = 160
    Top = 8
    Width = 601
    Height = 21
    TabOrder = 5
  end
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 146
    Height = 21
    Caption = #1060#1072#1081#1083' '#1089' '#1087#1077#1088#1077#1076#1072#1090#1086#1095#1085#1099#1084#1080' '#1050#1055
    ParentShowHint = False
    ShowHint = False
    TabOrder = 6
    OnClick = Button2Click
  end
  object DataList: TValueListEditor
    Left = 8
    Top = 34
    Width = 217
    Height = 272
    Hint = #1044#1072#1085#1085#1099#1077
    ParentShowHint = False
    ShowHint = True
    Strings.Strings = (
      #1055#1077#1088#1077#1076#1072#1095#1072' 1=5.7319'
      #1055#1077#1088#1077#1076#1072#1095#1072' 2=3.6056'
      #1055#1077#1088#1077#1076#1072#1095#1072' 3=2.3352'
      #1055#1077#1088#1077#1076#1072#1095#1072' 4=1.4689'
      #1055#1077#1088#1077#1076#1072#1095#1072' 5=0.9715'
      #1055#1077#1088#1077#1076#1072#1095#1072' 6=0.6111'
      #1055#1077#1088#1077#1076#1072#1095#1072' 7 (1-'#1103' '#1047#1061')=5.1787'
      #1055#1077#1088#1077#1076#1072#1095#1072' 8 (2-'#1103' '#1047#1061')=2.1098'
      #1055#1077#1088#1077#1076#1072#1095#1072' 9 (3-'#1103' '#1047#1061')=0.8777'
      #1042#1077#1076#1091#1097#1080#1081' '#1084#1086#1089#1090' =17.5'
      'R '#1082#1086#1083#1077#1089#1072', '#1084'=0.63'
      #8470' '#1087#1077#1088#1077#1076#1072#1095#1080'=1'
      #1050#1072#1089#1072#1090'. '#1089#1080#1083#1072' '#1085#1072' '#1082#1086#1083#1077#1089#1072#1093', '#1082#1053'=70')
    TabOrder = 7
    TitleCaptions.Strings = (
      #1056#1077#1076#1072#1082#1090#1080#1088#1091#1077#1084#1099#1077' '#1076#1072#1085#1085#1099#1077)
    ColWidths = (
      150
      61)
  end
  object OpenDialog1: TOpenDialog
    Left = 432
    Top = 65520
  end
end
