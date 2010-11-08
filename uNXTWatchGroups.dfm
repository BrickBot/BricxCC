object frmNXTWatchGroups: TfrmNXTWatchGroups
  Left = 307
  Top = 330
  BorderStyle = bsDialog
  Caption = 'Add Watch Group'
  ClientHeight = 95
  ClientWidth = 305
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
  object lblGroupName: TLabel
    Left = 8
    Top = 10
    Width = 63
    Height = 13
    Caption = '&Group Name:'
    FocusControl = cboGroupName
  end
  object cboGroupName: TComboBox
    Left = 9
    Top = 30
    Width = 289
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'Watches'
    Items.Strings = (
      'Watches')
  end
  object btnOK: TButton
    Left = 131
    Top = 62
    Width = 52
    Height = 25
    HelpContext = 45002
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 187
    Top = 62
    Width = 52
    Height = 25
    HelpContext = 45003
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 244
    Top = 62
    Width = 52
    Height = 25
    HelpContext = 45004
    Caption = '&Help'
    TabOrder = 3
  end
end
