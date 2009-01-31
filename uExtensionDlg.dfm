object frmExtensionDlg: TfrmExtensionDlg
  Left = 401
  Top = 245
  HelpContext = 3100
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'File Extensions'
  ClientHeight = 335
  ClientWidth = 198
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblClaimThese: TLabel
    Left = 8
    Top = 5
    Width = 143
    Height = 13
    Caption = 'Claim the following extensions:'
  end
  object chkNQC: TCheckBox
    Left = 8
    Top = 22
    Width = 180
    Height = 17
    HelpContext = 3102
    Caption = '.nqc .nqh (Not Quite C)'
    TabOrder = 0
  end
  object chkRCX2: TCheckBox
    Left = 8
    Top = 40
    Width = 180
    Height = 17
    HelpContext = 3103
    Caption = '.rcx2 (MindScript)'
    TabOrder = 1
  end
  object chkLSC: TCheckBox
    Left = 8
    Top = 59
    Width = 180
    Height = 17
    HelpContext = 3104
    Caption = '.lsc (MindScript)'
    TabOrder = 2
  end
  object chkASM: TCheckBox
    Left = 8
    Top = 77
    Width = 180
    Height = 17
    HelpContext = 3105
    Caption = '.lasm (LASM)'
    TabOrder = 3
  end
  object btnOK: TButton
    Left = 17
    Top = 304
    Width = 52
    Height = 25
    HelpContext = 3106
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 14
  end
  object btnCancel: TButton
    Left = 73
    Top = 304
    Width = 52
    Height = 25
    HelpContext = 3107
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 15
  end
  object chkCpp: TCheckBox
    Left = 8
    Top = 96
    Width = 180
    Height = 17
    HelpContext = 3108
    Caption = '.cpp (BrickOS CPP)'
    TabOrder = 4
  end
  object chkPas: TCheckBox
    Left = 8
    Top = 133
    Width = 180
    Height = 17
    HelpContext = 3109
    Caption = '.pas (BrickOS Pascal)'
    TabOrder = 6
  end
  object chkC: TCheckBox
    Left = 8
    Top = 114
    Width = 180
    Height = 17
    HelpContext = 3110
    Caption = '.c (BrickOS C)'
    TabOrder = 5
  end
  object chkJava: TCheckBox
    Left = 8
    Top = 151
    Width = 180
    Height = 17
    HelpContext = 3111
    Caption = '.java (leJOS Java)'
    TabOrder = 7
  end
  object chkForth: TCheckBox
    Left = 8
    Top = 170
    Width = 180
    Height = 17
    HelpContext = 3112
    Caption = '.4th .fr .f .fth (pbForth)'
    TabOrder = 8
  end
  object btnHelp: TButton
    Left = 129
    Top = 304
    Width = 52
    Height = 25
    HelpContext = 3113
    Caption = '&Help'
    TabOrder = 16
  end
  object chkNBC: TCheckBox
    Left = 8
    Top = 188
    Width = 180
    Height = 17
    HelpContext = 3114
    Caption = '.nbc (Next Byte Codes)'
    TabOrder = 9
  end
  object chkRICScript: TCheckBox
    Left = 8
    Top = 244
    Width = 180
    Height = 17
    HelpContext = 3114
    Caption = '.rs (RICScript)'
    TabOrder = 12
  end
  object chkNXC: TCheckBox
    Left = 8
    Top = 207
    Width = 180
    Height = 17
    HelpContext = 3114
    Caption = '.nxc (NXT C)'
    TabOrder = 10
  end
  object chkNPG: TCheckBox
    Left = 8
    Top = 225
    Width = 180
    Height = 17
    HelpContext = 3114
    Caption = '.npg (NXT Program)'
    TabOrder = 11
  end
  object chkLua: TCheckBox
    Left = 8
    Top = 263
    Width = 180
    Height = 17
    HelpContext = 3114
    Caption = '.lua .lpr (Lua)'
    TabOrder = 13
  end
  object chkPascalScript: TCheckBox
    Left = 8
    Top = 281
    Width = 180
    Height = 17
    HelpContext = 3114
    Caption = '.rops (Pascal Script)'
    TabOrder = 17
  end
end
