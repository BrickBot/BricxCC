object SearchBrickForm: TSearchBrickForm
  Left = 196
  Top = 153
  HelpContext = 3
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Find Brick'
  ClientHeight = 209
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 73
    Top = 6
    Width = 183
    Height = 20
    Caption = 'Searching for the brick'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object OKBtn: TButton
    Left = 36
    Top = 178
    Width = 81
    Height = 25
    HelpContext = 3002
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 124
    Top = 178
    Width = 81
    Height = 25
    HelpContext = 3003
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object grpFirmware: TGroupBox
    Left = 6
    Top = 102
    Width = 319
    Height = 67
    Caption = 'Firmware'
    TabOrder = 4
    object radStandard: TRadioButton
      Left = 8
      Top = 16
      Width = 68
      Height = 17
      HelpContext = 3005
      Caption = 'Standard'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = FirmwareClick
    end
    object radBrickOS: TRadioButton
      Left = 117
      Top = 16
      Width = 64
      Height = 17
      HelpContext = 3006
      Caption = 'brickOS'
      TabOrder = 1
      OnClick = FirmwareClick
    end
    object radPBForth: TRadioButton
      Left = 227
      Top = 16
      Width = 62
      Height = 17
      HelpContext = 3007
      Caption = 'pbForth'
      TabOrder = 2
      OnClick = FirmwareClick
    end
    object radLejos: TRadioButton
      Left = 8
      Top = 40
      Width = 54
      Height = 17
      HelpContext = 3008
      Caption = 'leJOS'
      TabOrder = 3
      OnClick = FirmwareClick
    end
    object radOtherFirmware: TRadioButton
      Left = 227
      Top = 40
      Width = 52
      Height = 17
      HelpContext = 3009
      Caption = 'Other'
      TabOrder = 4
      OnClick = FirmwareClick
    end
    object radLinux: TRadioButton
      Left = 117
      Top = 40
      Width = 54
      Height = 17
      HelpContext = 3008
      Caption = 'Linux'
      TabOrder = 5
      OnClick = FirmwareClick
    end
  end
  object btnHelp: TButton
    Left = 212
    Top = 178
    Width = 81
    Height = 25
    HelpContext = 3033
    Caption = 'Help'
    TabOrder = 5
    OnClick = btnHelpClick
  end
  object pnlPorts: TGroupBox
    Left = 6
    Top = 32
    Width = 156
    Height = 66
    Caption = 'Port'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 2
    object cboPort: TComboBox
      Left = 8
      Top = 16
      Width = 136
      Height = 21
      HelpContext = 3011
      ItemHeight = 13
      TabOrder = 0
    end
    object chkUseBluetooth: TCheckBox
      Left = 8
      Top = 43
      Width = 97
      Height = 17
      HelpContext = 3010
      Caption = 'Bluetooth'
      TabOrder = 1
      Visible = False
    end
  end
  object pnlFirmware: TGroupBox
    Left = 168
    Top = 32
    Width = 156
    Height = 66
    Caption = 'Brick Type'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 3
    object cboBrickType: TComboBox
      Left = 8
      Top = 16
      Width = 136
      Height = 21
      HelpContext = 3012
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cboBrickTypeChange
      Items.Strings = (
        'RCX'
        'CyberMaster'
        'Scout'
        'RCX2'
        'Spybot'
        'Swan'
        'NXT'
        'SuperPro'
        'EV3')
    end
  end
end
