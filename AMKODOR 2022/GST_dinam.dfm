object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 468
  ClientWidth = 856
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 833
    Height = 460
    Caption = 'Panel1'
    TabOrder = 0
    object Memo1: TMemo
      Left = 344
      Top = 56
      Width = 489
      Height = 393
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
    object Button1: TButton
      Left = 16
      Top = 88
      Width = 97
      Height = 33
      Caption = 'Start'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 24
      Top = 8
      Width = 593
      Height = 21
      TabOrder = 2
      Text = 'Edit1'
    end
    object Button2: TButton
      Left = 16
      Top = 136
      Width = 97
      Height = 25
      Caption = 'Button2'
      TabOrder = 3
    end
  end
end
