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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblExpression: TLabel
    Left = 8
    Top = 10
    Width = 54
    Height = 13
    Caption = '&Expression:'
    FocusControl = cboExpression
  end
  object lblGroupName: TLabel
    Left = 8
    Top = 34
    Width = 64
    Height = 13
    Caption = 'Gr&oup name::'
    FocusControl = cboGroupName
  end
  object lblRepeatCount: TLabel
    Left = 8
    Top = 59
    Width = 68
    Height = 13
    Caption = 'Repeat &count:'
    FocusControl = edtRepeat
  end
  object lblDigits: TLabel
    Left = 216
    Top = 59
    Width = 29
    Height = 13
    Caption = 'Di&gits:'
    FocusControl = edtDigits
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
    TabOrder = 7
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
    TabOrder = 8
  end
  object btnHelp: TButton
    Left = 333
    Top = 198
    Width = 52
    Height = 25
    HelpContext = 45004
    Caption = '&Help'
    TabOrder = 9
  end
  object cboExpression: TComboBox
    Left = 96
    Top = 6
    Width = 289
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = cboExpressionChange
  end
  object cboGroupName: TComboBox
    Left = 96
    Top = 30
    Width = 289
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'Watches'
    OnChange = cboGroupNameChange
    Items.Strings = (
      'Watches')
  end
  object grpFormat: TGroupBox
    Left = 8
    Top = 104
    Width = 377
    Height = 89
    TabOrder = 6
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
    TabOrder = 4
  end
  object chkAllowFunctionCalls: TCheckBox
    Left = 96
    Top = 80
    Width = 185
    Height = 17
    Caption = '&Allow Function Calls'
    Enabled = False
    TabOrder = 5
  end
  object edtRepeat: TBricxccSpinEdit
    Left = 96
    Top = 54
    Width = 49
    Height = 22
    MaxLength = 2
    MaxValue = 32
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object edtDigits: TBricxccSpinEdit
    Left = 256
    Top = 54
    Width = 49
    Height = 22
    MaxLength = 2
    MaxValue = 20
    MinValue = 0
    TabOrder = 3
    Value = 18
  end
end
