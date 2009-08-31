object MessageForm: TMessageForm
  Left = 313
  Top = 108
  HelpContext = 18
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Messages'
  ClientHeight = 275
  ClientWidth = 296
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
  object btnHelp: TButton
    Left = 46
    Top = 246
    Width = 52
    Height = 25
    HelpContext = 18015
    Caption = '&Help'
    TabOrder = 0
    OnClick = btnHelpClick
  end
  object grpSingleDigit: TGroupBox
    Left = 8
    Top = 5
    Width = 129
    Height = 180
    Caption = 'Single digit message'
    TabOrder = 1
    object Button2: TButton
      Tag = 2
      Left = 48
      Top = 96
      Width = 33
      Height = 33
      HelpContext = 18003
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button0Click
    end
    object Button0: TButton
      Left = 8
      Top = 136
      Width = 33
      Height = 33
      HelpContext = 18011
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button0Click
    end
    object Button1: TButton
      Tag = 1
      Left = 8
      Top = 96
      Width = 33
      Height = 33
      HelpContext = 18002
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Button0Click
    end
    object Button3: TButton
      Tag = 3
      Left = 88
      Top = 96
      Width = 33
      Height = 33
      HelpContext = 18004
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = Button0Click
    end
    object Button6: TButton
      Tag = 6
      Left = 88
      Top = 56
      Width = 33
      Height = 33
      HelpContext = 18007
      Caption = '6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = Button0Click
    end
    object Button5: TButton
      Tag = 5
      Left = 48
      Top = 56
      Width = 33
      Height = 33
      HelpContext = 18006
      Caption = '5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = Button0Click
    end
    object Button4: TButton
      Tag = 4
      Left = 8
      Top = 56
      Width = 33
      Height = 33
      HelpContext = 18005
      Caption = '4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = Button0Click
    end
    object Button7: TButton
      Tag = 7
      Left = 8
      Top = 16
      Width = 33
      Height = 33
      HelpContext = 18008
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = Button0Click
    end
    object Button8: TButton
      Tag = 8
      Left = 48
      Top = 16
      Width = 33
      Height = 33
      HelpContext = 18009
      Caption = '8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = Button0Click
    end
    object Button9: TButton
      Tag = 9
      Left = 88
      Top = 16
      Width = 33
      Height = 33
      HelpContext = 18010
      Caption = '9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = Button0Click
    end
  end
  object grpMultiDigit: TGroupBox
    Left = 8
    Top = 192
    Width = 129
    Height = 49
    Caption = 'Numeric message'
    TabOrder = 2
    object SendButton: TButton
      Tag = 100
      Left = 80
      Top = 16
      Width = 41
      Height = 25
      HelpContext = 18013
      Caption = 'Send'
      TabOrder = 0
      OnClick = SendButtonClick
    end
    object edtMessageNum: TBricxccSpinEdit
      Left = 8
      Top = 17
      Width = 57
      Height = 22
      HelpContext = 18014
      MaxLength = 3
      MaxValue = 255
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
  object grpNXTMsg: TGroupBox
    Left = 144
    Top = 5
    Width = 145
    Height = 236
    Caption = 'NXT Messages'
    TabOrder = 3
    object lblMailbox: TLabel
      Left = 8
      Top = 19
      Width = 39
      Height = 13
      Caption = '&Mailbox:'
      FocusControl = cboMailbox
    end
    object lblMemo: TLabel
      Left = 8
      Top = 117
      Width = 32
      Height = 13
      Caption = 'M&emo:'
      FocusControl = mmoMessage
    end
    object cboMailbox: TComboBox
      Left = 56
      Top = 15
      Width = 81
      Height = 21
      HelpContext = 18016
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
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
    object mmoMessage: TMemo
      Left = 8
      Top = 133
      Width = 81
      Height = 94
      HelpContext = 18022
      MaxLength = 59
      ScrollBars = ssVertical
      TabOrder = 6
    end
    object btnSendString: TButton
      Tag = 200
      Left = 96
      Top = 131
      Width = 41
      Height = 25
      HelpContext = 18023
      Caption = 'Send'
      TabOrder = 7
      OnClick = btnSendNXTClick
    end
    object chkBoolValue: TCheckBox
      Left = 8
      Top = 64
      Width = 81
      Height = 17
      HelpContext = 18018
      Caption = 'Boolean'
      TabOrder = 2
    end
    object btnSendBool: TButton
      Tag = 300
      Left = 96
      Top = 60
      Width = 41
      Height = 25
      HelpContext = 18019
      Caption = 'Send'
      TabOrder = 3
      OnClick = btnSendNXTClick
    end
    object btnSendNum: TButton
      Tag = 400
      Left = 96
      Top = 91
      Width = 41
      Height = 25
      HelpContext = 18021
      Caption = 'Send'
      TabOrder = 5
      OnClick = btnSendNXTClick
    end
    object chkResponse: TCheckBox
      Left = 56
      Top = 39
      Width = 81
      Height = 17
      HelpContext = 18017
      Caption = 'Response'
      TabOrder = 1
    end
    object edtNum: TBricxccSpinEdit
      Left = 8
      Top = 92
      Width = 81
      Height = 22
      HelpContext = 18020
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
  end
end
