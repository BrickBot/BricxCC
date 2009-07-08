object frmSetLNPAddress: TfrmSetLNPAddress
  Left = 382
  Top = 300
  HelpContext = 40000
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Set LNP Address'
  ClientHeight = 71
  ClientWidth = 175
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 41
    Height = 13
    Caption = '&Address:'
    FocusControl = edtAddress
  end
  object btnOK: TButton
    Left = 5
    Top = 40
    Width = 52
    Height = 25
    HelpContext = 40002
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 61
    Top = 40
    Width = 52
    Height = 25
    HelpContext = 40003
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnHelp: TButton
    Left = 118
    Top = 40
    Width = 52
    Height = 25
    HelpContext = 40004
    Caption = '&Help'
    TabOrder = 2
    OnClick = btnHelpClick
  end
  object edtAddress: TBricxccSpinEdit
    Left = 108
    Top = 8
    Width = 59
    Height = 22
    HelpContext = 40001
    MaxLength = 2
    MaxValue = 15
    MinValue = 0
    TabOrder = 3
    Value = 0
    OnKeyPress = edtAddressKeyPress
  end
end
