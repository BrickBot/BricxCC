object frmSetValues: TfrmSetValues
  Left = 218
  Top = 219
  HelpContext = 41000
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Set Values'
  ClientHeight = 215
  ClientWidth = 264
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
  object grpDest: TGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 81
    Caption = 'Set this source'
    TabOrder = 0
    object lblSource: TLabel
      Left = 8
      Top = 25
      Width = 37
      Height = 13
      Caption = 'S&ource:'
    end
    object lblValue: TLabel
      Left = 8
      Top = 53
      Width = 30
      Height = 13
      Caption = '&Value:'
    end
    object cboSource: TComboBox
      Left = 56
      Top = 21
      Width = 161
      Height = 21
      HelpContext = 41001
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cboSourceChange
    end
    object edtValue: TEdit
      Left = 56
      Top = 48
      Width = 49
      Height = 21
      HelpContext = 41002
      MaxLength = 5
      TabOrder = 1
      Text = '0'
      OnExit = edtValueExit
      OnKeyPress = edtValueKeyPress
    end
    object udValue: TUpDown
      Left = 105
      Top = 48
      Width = 15
      Height = 21
      HelpContext = 41003
      Associate = edtValue
      TabOrder = 2
      Thousands = False
    end
  end
  object grpOrigin: TGroupBox
    Left = 8
    Top = 96
    Width = 249
    Height = 81
    Caption = 'to this value'
    TabOrder = 1
    object lblSource2: TLabel
      Left = 8
      Top = 25
      Width = 37
      Height = 13
      Caption = 'So&urce:'
    end
    object lblValue2: TLabel
      Left = 8
      Top = 53
      Width = 30
      Height = 13
      Caption = 'V&alue:'
    end
    object edtValue2: TEdit
      Left = 56
      Top = 48
      Width = 49
      Height = 21
      HelpContext = 41005
      MaxLength = 5
      TabOrder = 0
      Text = '0'
      OnExit = edtValueExit
      OnKeyPress = edtValueKeyPress
    end
    object udValue2: TUpDown
      Left = 105
      Top = 48
      Width = 15
      Height = 21
      HelpContext = 41006
      Associate = edtValue2
      TabOrder = 1
      Thousands = False
    end
    object cboSource2: TComboBox
      Left = 56
      Top = 21
      Width = 161
      Height = 21
      HelpContext = 41004
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = cboSourceChange
    end
  end
  object btnSet: TButton
    Left = 52
    Top = 184
    Width = 75
    Height = 25
    HelpContext = 41007
    Caption = '&Set'
    TabOrder = 2
    OnClick = btnSetClick
  end
  object btnHelp: TButton
    Left = 136
    Top = 184
    Width = 75
    Height = 25
    HelpContext = 41008
    Caption = '&Help'
    TabOrder = 3
    OnClick = btnHelpClick
  end
end
