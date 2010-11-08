object frmNXTWatchProperties: TfrmNXTWatchProperties
  Left = 294
  Top = 132
  BorderStyle = bsDialog
  Caption = 'Watch Properties'
  ClientHeight = 228
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 54
    Height = 13
    Caption = '&Expression:'
    FocusControl = cboExpression
  end
  object Label2: TLabel
    Left = 8
    Top = 34
    Width = 64
    Height = 13
    Caption = 'Gr&oup name::'
    FocusControl = cboGroupName
  end
  object btnOK: TButton
    Left = 221
    Top = 198
    Width = 52
    Height = 25
    HelpContext = 45002
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 277
    Top = 198
    Width = 52
    Height = 25
    HelpContext = 45003
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnHelp: TButton
    Left = 333
    Top = 198
    Width = 52
    Height = 25
    HelpContext = 45004
    Caption = '&Help'
    TabOrder = 2
  end
  object cboExpression: TComboBox
    Left = 96
    Top = 6
    Width = 289
    Height = 21
    ItemHeight = 13
    TabOrder = 3
  end
  object cboGroupName: TComboBox
    Left = 96
    Top = 30
    Width = 289
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Text = 'Watches'
    Items.Strings = (
      'Watches')
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 104
    Width = 377
    Height = 89
    TabOrder = 5
    object radCharacter: TRadioButton
      Left = 8
      Top = 16
      Width = 110
      Height = 17
      Caption = '&Character'
      TabOrder = 0
    end
    object radString: TRadioButton
      Left = 8
      Top = 40
      Width = 110
      Height = 17
      Caption = '&String'
      TabOrder = 1
    end
    object radDecimal: TRadioButton
      Left = 8
      Top = 64
      Width = 110
      Height = 17
      Caption = '&Decimal'
      TabOrder = 2
    end
    object radHexadecimal: TRadioButton
      Left = 124
      Top = 16
      Width = 110
      Height = 17
      Caption = 'He&xadecimal'
      TabOrder = 3
    end
    object radFloatingPoint: TRadioButton
      Left = 124
      Top = 40
      Width = 110
      Height = 17
      Caption = '&Floating point'
      TabOrder = 4
    end
    object radPointer: TRadioButton
      Left = 124
      Top = 64
      Width = 110
      Height = 17
      Caption = '&Pointer'
      TabOrder = 5
    end
    object radRecStruct: TRadioButton
      Left = 240
      Top = 16
      Width = 110
      Height = 17
      Caption = '&Record/Structure'
      TabOrder = 6
    end
    object radDefault: TRadioButton
      Left = 240
      Top = 40
      Width = 110
      Height = 17
      Caption = 'Defau&lt'
      Checked = True
      TabOrder = 7
      TabStop = True
    end
    object radMemoryDump: TRadioButton
      Left = 240
      Top = 64
      Width = 110
      Height = 17
      Caption = '&Memory Dump'
      TabOrder = 8
    end
  end
  object chkEnabled: TCheckBox
    Left = 8
    Top = 80
    Width = 81
    Height = 17
    Caption = 'E&nabled'
    TabOrder = 6
  end
  object chkAllowFunctionCalls: TCheckBox
    Left = 96
    Top = 80
    Width = 185
    Height = 17
    Caption = '&Allow Function Calls'
    Enabled = False
    TabOrder = 7
  end
end
