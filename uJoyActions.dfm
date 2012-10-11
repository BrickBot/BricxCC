object frmJoyActions: TfrmJoyActions
  Left = 253
  Top = 139
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Joystick Options'
  ClientHeight = 217
  ClientWidth = 263
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grpChangeActions: TGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 175
    Caption = 'Joystick change action'
    TabOrder = 0
    object lblMailbox: TLabel
      Left = 48
      Top = 96
      Width = 101
      Height = 13
      Caption = 'NXT &mailbox number:'
      FocusControl = cboMailbox
    end
    object radCADefault: TRadioButton
      Left = 8
      Top = 24
      Width = 231
      Height = 17
      Caption = '&Default'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = ActionsClick
    end
    object radCAScript: TRadioButton
      Left = 8
      Top = 48
      Width = 231
      Height = 17
      Caption = '&Execute Pascal script'
      TabOrder = 1
      OnClick = ActionsClick
    end
    object radCAMessage: TRadioButton
      Left = 8
      Top = 72
      Width = 231
      Height = 17
      Caption = '&Send message to brick'
      TabOrder = 2
      OnClick = ActionsClick
    end
    object cboMailbox: TComboBox
      Left = 48
      Top = 115
      Width = 81
      Height = 21
      HelpContext = 18016
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 3
      Text = 'Mailbox 1'
      Items.Strings = (
        'Mailbox 1'
        'Mailbox 2'
        'Mailbox 3'
        'Mailbox 4'
        'Mailbox 5'
        'Mailbox 6'
        'Mailbox 7'
        'Mailbox 8'
        'Mailbox 9'
        'Mailbox 10')
    end
    object chkEnhancedMsg: TCheckBox
      Left = 48
      Top = 144
      Width = 185
      Height = 17
      Caption = 'Raw joystick information'
      TabOrder = 4
    end
  end
  object btnOK: TButton
    Left = 96
    Top = 188
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 182
    Top = 188
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
