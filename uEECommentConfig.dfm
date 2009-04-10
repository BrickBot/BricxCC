object frmCommentConfig: TfrmCommentConfig
  Left = 311
  Top = 211
  BorderStyle = bsDialog
  Caption = 'Comment Expert'
  ClientHeight = 98
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 14
  object GroupBox1: TGroupBox
    Left = 9
    Top = 5
    Width = 169
    Height = 60
    Caption = 'Comment Style'
    TabOrder = 0
    object rbSlash: TRadioButton
      Left = 8
      Top = 24
      Width = 65
      Height = 17
      Caption = '//'
      TabOrder = 0
    end
    object rbCpp: TRadioButton
      Left = 80
      Top = 24
      Width = 65
      Height = 17
      Caption = '/*  */'
      TabOrder = 1
    end
  end
  object btnOK: TButton
    Left = 186
    Top = 11
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 186
    Top = 43
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object chkInsertSpace: TCheckBox
    Left = 9
    Top = 74
    Width = 249
    Height = 17
    Caption = 'Insert and remove &space'
    TabOrder = 1
  end
end
