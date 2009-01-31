object frmExpTester: TfrmExpTester
  Left = 226
  Top = 343
  BorderStyle = bsDialog
  Caption = 'Expression Tester'
  ClientHeight = 283
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object edtExp: TEdit
    Left = 8
    Top = 40
    Width = 273
    Height = 21
    TabOrder = 2
  end
  object edtResult: TEdit
    Left = 8
    Top = 72
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object btnCalc: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Evaluate'
    TabOrder = 0
    OnClick = btnCalcClick
  end
  object chkUseProg: TCheckBox
    Left = 136
    Top = 12
    Width = 97
    Height = 17
    Caption = 'Heavy'
    TabOrder = 1
  end
  object mmoMessages: TMemo
    Left = 8
    Top = 104
    Width = 273
    Height = 169
    ScrollBars = ssBoth
    TabOrder = 4
  end
end
