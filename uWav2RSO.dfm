object frmWave2RSO: TfrmWave2RSO
  Left = 190
  Top = 185
  BorderStyle = bsDialog
  Caption = 'Wav 2 RSO 2 Wav'
  ClientHeight = 446
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  DesignSize = (
    450
    446)
  PixelsPerInch = 96
  TextHeight = 13
  object lblMessages: TLabel
    Left = 40
    Top = 321
    Width = 51
    Height = 13
    Caption = 'Messages:'
  end
  object btnConvert: TButton
    Left = 8
    Top = 67
    Width = 81
    Height = 25
    Hint = 'Convert selected files'
    Caption = 'Convert'
    TabOrder = 2
    OnClick = btnConvertClick
  end
  object mmoMessages: TMemo
    Left = 104
    Top = 317
    Width = 337
    Height = 121
    Hint = 'Messages'
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object btnSelect: TButton
    Left = 8
    Top = 36
    Width = 81
    Height = 25
    Hint = 
      'Select the files you wish to convert (either .wav -> .rso or .rs' +
      'o -> .wav)'
    Caption = 'Select Files...'
    TabOrder = 0
    OnClick = btnSelectClick
  end
  object lstWavFiles: TListBox
    Left = 104
    Top = 34
    Width = 337
    Height = 271
    Hint = 'WAV files to be converted'
    ItemHeight = 13
    TabOrder = 1
  end
  object grpResample: TGroupBox
    Left = 8
    Top = 95
    Width = 81
    Height = 178
    Caption = 'Resample'
    TabOrder = 3
    object lblRate: TLabel
      Left = 8
      Top = 128
      Width = 26
      Height = 13
      Caption = 'Rate:'
    end
    object radSinc1: TRadioButton
      Left = 8
      Top = 16
      Width = 68
      Height = 17
      Hint = 
        'Band limited sinc interpolation, best quality, 97dB Signal to No' +
        'ise Ratio, 96% Bandwidth'
      Caption = 'Sinc 96%'
      TabOrder = 0
    end
    object radSinc2: TRadioButton
      Tag = 1
      Left = 8
      Top = 33
      Width = 68
      Height = 17
      Hint = 
        'Band limited sinc interpolation, medium quality, 97dB Signal to ' +
        'Noise Ratio, 90% Bandwidth'
      Caption = 'Sinc 90%'
      TabOrder = 1
    end
    object radSinc3: TRadioButton
      Tag = 2
      Left = 8
      Top = 50
      Width = 68
      Height = 17
      Hint = 
        'Band limited sinc interpolation, fastest, 97dB Signal to Noise R' +
        'atio, 80% Bandwidth'
      Caption = 'Sinc 80%'
      TabOrder = 2
    end
    object radZoh: TRadioButton
      Tag = 3
      Left = 8
      Top = 67
      Width = 57
      Height = 17
      Hint = 'Zero order hold interpolator, very fast, poor quality.'
      Caption = 'ZOH'
      TabOrder = 3
    end
    object radLinear: TRadioButton
      Tag = 4
      Left = 8
      Top = 84
      Width = 57
      Height = 17
      Hint = 'Linear interpolator, very fast, poor quality.'
      Caption = 'Linear'
      TabOrder = 4
    end
    object radNone: TRadioButton
      Tag = 4
      Left = 8
      Top = 102
      Width = 57
      Height = 17
      Hint = 'No resampling'
      Caption = 'None'
      Checked = True
      TabOrder = 5
      TabStop = True
    end
    object edtRate: TBricxccSpinEdit
      Left = 8
      Top = 144
      Width = 57
      Height = 22
      Hint = 'The output sample rate'
      MaxLength = 5
      MaxValue = 16000
      MinValue = 2000
      TabOrder = 6
      Value = 8000
    end
  end
  object btnOK: TButton
    Left = 8
    Top = 358
    Width = 81
    Height = 25
    HelpContext = 3522
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 8
    Top = 386
    Width = 81
    Height = 25
    HelpContext = 3523
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
    Visible = False
    OnClick = btnCancelClick
  end
  object btnHelp: TButton
    Left = 8
    Top = 412
    Width = 81
    Height = 25
    HelpContext = 3524
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 7
    Visible = False
    OnClick = btnHelpClick
  end
  object chkUseCompression: TCheckBox
    Left = 8
    Top = 280
    Width = 81
    Height = 17
    Hint = 'Compress the .rso output'
    Caption = 'Compressed'
    TabOrder = 8
  end
  object edtPath2: TEdit
    Left = 104
    Top = 8
    Width = 337
    Height = 21
    Cursor = crNo
    Hint = 'The specified output directory'
    AutoSize = False
    ReadOnly = True
    TabOrder = 9
    OnChange = OnPathChange
  end
  object dlgOpen: TOpenDialog
    Filter = 
      'WAV files (*.wav)|*.wav|RSO files (*.rso)|*.rso|All files (*.*)|' +
      '*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing, ofDontAddToRecent]
    Left = 216
    Top = 8
  end
  object pumFiles: TPopupMenu
    Left = 232
    Top = 152
    object mniClear: TMenuItem
      Caption = 'Clear'
      OnClick = mniClearClick
    end
  end
end
