object frmEditCodeTemplate: TfrmEditCodeTemplate
  Left = 271
  Top = 237
  HelpContext = 29000
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Code Template'
  ClientHeight = 89
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblName: TLabel
    Left = 8
    Top = 12
    Width = 31
    Height = 13
    Caption = '&Name:'
    FocusControl = edtName
  end
  object lblDesc: TLabel
    Left = 8
    Top = 36
    Width = 56
    Height = 13
    Caption = '&Description:'
    FocusControl = edtDesc
  end
  object edtName: TEdit
    Left = 72
    Top = 8
    Width = 105
    Height = 21
    HelpContext = 29003
    MaxLength = 20
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 32
    Top = 60
    Width = 75
    Height = 25
    HelpContext = 29004
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 112
    Top = 60
    Width = 75
    Height = 25
    HelpContext = 29005
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object edtDesc: TEdit
    Left = 72
    Top = 32
    Width = 193
    Height = 21
    HelpContext = 29006
    MaxLength = 40
    TabOrder = 1
  end
  object btnHelp: TButton
    Left = 193
    Top = 60
    Width = 75
    Height = 25
    HelpContext = 29007
    Caption = '&Help'
    TabOrder = 4
    OnClick = btnHelpClick
  end
end
