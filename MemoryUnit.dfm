object MemoryForm: TMemoryForm
  Left = 124
  Top = 84
  HelpContext = 21
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Memory Map'
  ClientHeight = 380
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MemoryMemo: TMemo
    Left = 8
    Top = 8
    Width = 466
    Height = 337
    HelpContext = 21001
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object RefreshBtn: TButton
    Left = 8
    Top = 352
    Width = 83
    Height = 25
    HelpContext = 21002
    Caption = '&Refresh'
    Default = True
    TabOrder = 1
    OnClick = RefreshBtnClick
  end
  object chkUseHex: TCheckBox
    Left = 104
    Top = 356
    Width = 145
    Height = 17
    HelpContext = 21003
    Caption = 'Hexadecimal format'
    TabOrder = 2
    OnClick = chkUseHexClick
  end
  object btnHelp: TButton
    Left = 424
    Top = 352
    Width = 52
    Height = 25
    HelpContext = 21004
    Caption = '&Help'
    TabOrder = 3
    OnClick = btnHelpClick
  end
end
