object frmMIDIConversion: TfrmMIDIConversion
  Left = 307
  Top = 267
  HelpContext = 3500
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'MIDI Conversion'
  ClientHeight = 295
  ClientWidth = 301
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
  object grpCode: TGroupBox
    Left = 4
    Top = 2
    Width = 99
    Height = 226
    Caption = 'Language'
    TabOrder = 0
    object radGenNQC: TRadioButton
      Left = 8
      Top = 16
      Width = 84
      Height = 17
      HelpContext = 3502
      Caption = '&NQC'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = LanguageClick
    end
    object radGenMS: TRadioButton
      Left = 8
      Top = 36
      Width = 84
      Height = 17
      HelpContext = 3503
      Caption = '&MindScript'
      TabOrder = 1
      OnClick = LanguageClick
    end
    object radGenLASM: TRadioButton
      Left = 8
      Top = 57
      Width = 84
      Height = 17
      HelpContext = 3504
      Caption = '&LASM'
      TabOrder = 2
      OnClick = LanguageClick
    end
    object radGenC: TRadioButton
      Left = 8
      Top = 78
      Width = 84
      Height = 17
      HelpContext = 3505
      Caption = '&C'
      TabOrder = 3
      OnClick = LanguageClick
    end
    object radGenPascal: TRadioButton
      Left = 8
      Top = 99
      Width = 84
      Height = 17
      HelpContext = 3506
      Caption = '&Pascal'
      TabOrder = 4
      OnClick = LanguageClick
    end
    object radGenForth: TRadioButton
      Left = 8
      Top = 119
      Width = 84
      Height = 17
      HelpContext = 3507
      Caption = '&Forth'
      TabOrder = 5
      OnClick = LanguageClick
    end
    object radGenJava: TRadioButton
      Left = 8
      Top = 140
      Width = 84
      Height = 17
      HelpContext = 3508
      Caption = '&Java'
      TabOrder = 6
      OnClick = LanguageClick
    end
    object radGenNBC: TRadioButton
      Left = 8
      Top = 161
      Width = 84
      Height = 17
      HelpContext = 3509
      Caption = 'N&BC'
      TabOrder = 7
      OnClick = LanguageClick
    end
    object radGenNXC: TRadioButton
      Left = 8
      Top = 182
      Width = 84
      Height = 17
      HelpContext = 3510
      Caption = 'N&XC'
      TabOrder = 8
      OnClick = LanguageClick
    end
    object radGenNXTMelody: TRadioButton
      Left = 8
      Top = 203
      Width = 84
      Height = 17
      HelpContext = 3511
      Caption = 'NXT Melo&dy'
      TabOrder = 9
      OnClick = LanguageClick
    end
  end
  object grpDestination: TGroupBox
    Left = 4
    Top = 231
    Width = 99
    Height = 58
    Caption = 'Destination'
    TabOrder = 2
    object radToClip: TRadioButton
      Left = 8
      Top = 16
      Width = 78
      Height = 17
      HelpContext = 3512
      Caption = 'Clip&board'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radToFile: TRadioButton
      Left = 8
      Top = 35
      Width = 78
      Height = 17
      HelpContext = 3513
      Caption = 'F&ile'
      TabOrder = 1
    end
  end
  object grpParameters: TGroupBox
    Left = 104
    Top = 2
    Width = 193
    Height = 226
    Caption = 'Parameters'
    TabOrder = 1
    object lblGap: TLabel
      Left = 8
      Top = 78
      Width = 23
      Height = 13
      Caption = '&Gap:'
      FocusControl = edtGap
    end
    object lblTempo: TLabel
      Left = 8
      Top = 49
      Width = 36
      Height = 13
      Caption = '&Tempo:'
      FocusControl = edtTempo
    end
    object lblTranspose: TLabel
      Left = 8
      Top = 106
      Width = 53
      Height = 13
      Caption = 'T&ranspose:'
      FocusControl = barTranspose
    end
    object lblPBS: TLabel
      Left = 8
      Top = 174
      Width = 50
      Height = 13
      Caption = '&Sensitivity:'
      FocusControl = edtPBS
    end
    object lblTrack: TLabel
      Left = 8
      Top = 20
      Width = 59
      Height = 13
      Caption = 'Use trac&k #:'
      FocusControl = edtTrack
    end
    object barTranspose: TTrackBar
      Left = 72
      Top = 106
      Width = 113
      Height = 25
      Hint = '0'
      HelpContext = 3519
      Max = 2
      Min = -2
      ParentShowHint = False
      PageSize = 1
      ShowHint = True
      TabOrder = 3
      ThumbLength = 12
      OnChange = barTransposeChange
    end
    object chkUsePB: TCheckBox
      Left = 8
      Top = 139
      Width = 137
      Height = 17
      HelpContext = 3520
      Caption = 'Track pitch &bend'
      TabOrder = 4
      OnClick = chkUsePBClick
    end
    object edtGap: TSpinEdit
      Left = 78
      Top = 73
      Width = 52
      Height = 22
      HelpContext = 3517
      MaxLength = 2
      MaxValue = 99
      MinValue = 0
      TabOrder = 2
      Value = 2
      OnKeyPress = edtGapKeyPress
    end
    object edtTempo: TSpinEdit
      Left = 78
      Top = 44
      Width = 52
      Height = 22
      HelpContext = 3518
      MaxLength = 3
      MaxValue = 999
      MinValue = 0
      TabOrder = 1
      Value = 150
      OnKeyPress = edtGapKeyPress
    end
    object edtPBS: TSpinEdit
      Left = 78
      Top = 169
      Width = 52
      Height = 22
      HelpContext = 3521
      Enabled = False
      MaxLength = 2
      MaxValue = 99
      MinValue = 0
      TabOrder = 5
      Value = 2
      OnKeyPress = edtGapKeyPress
    end
    object edtTrack: TSpinEdit
      Left = 78
      Top = 15
      Width = 52
      Height = 22
      HelpContext = 3516
      MaxLength = 2
      MaxValue = 256
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnKeyPress = edtGapKeyPress
    end
  end
  object btnOK: TButton
    Left = 121
    Top = 250
    Width = 52
    Height = 25
    HelpContext = 3522
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 179
    Top = 250
    Width = 52
    Height = 25
    HelpContext = 3523
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object btnHelp: TButton
    Left = 237
    Top = 250
    Width = 52
    Height = 25
    HelpContext = 3524
    Caption = '&Help'
    TabOrder = 5
    OnClick = btnHelpClick
  end
  object dlgOpenMIDI: TOpenDialog
    Filter = 'MIDI Files (*.mid)|*.mid'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 256
    Top = 176
  end
end
