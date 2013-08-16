object frmNXTImagePrefs: TfrmNXTImagePrefs
  Left = 365
  Top = 170
  BorderStyle = bsDialog
  Caption = 'Brick Screen Preferences'
  ClientHeight = 273
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblBackgroundColor: TLabel
    Left = 8
    Top = 12
    Width = 87
    Height = 13
    Caption = 'Background color:'
  end
  object lblBaseFilename: TLabel
    Left = 8
    Top = 40
    Width = 69
    Height = 13
    Caption = 'Base filename:'
    FocusControl = edtBaseFilename
  end
  object lblNQCPath: TLabel
    Left = 8
    Top = 65
    Width = 112
    Height = 13
    Caption = 'Default Image directory:'
  end
  object lblImageTypes: TLabel
    Left = 8
    Top = 92
    Width = 60
    Height = 13
    Caption = 'Image types:'
  end
  object btnOK: TButton
    Left = 256
    Top = 240
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object btnCancel: TButton
    Left = 338
    Top = 240
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object cbxBackgroundColor: TColorBox
    Left = 174
    Top = 7
    Width = 128
    Height = 22
    DefaultColorColor = clMoneyGreen
    Selected = clMoneyGreen
    ItemHeight = 16
    TabOrder = 0
  end
  object edtBaseFilename: TEdit
    Left = 174
    Top = 36
    Width = 245
    Height = 21
    TabOrder = 1
    Text = 'image_'
  end
  object edtDefaultDir2: TEdit
    Left = 174
    Top = 61
    Width = 245
    Height = 21
    AutoSize = False
    TabOrder = 2
  end
  object grpAutoFilenames: TGroupBox
    Left = 174
    Top = 120
    Width = 243
    Height = 113
    Caption = 'Automatic filenames'
    TabOrder = 4
    object lblCurrentIndex: TLabel
      Left = 40
      Top = 47
      Width = 65
      Height = 13
      Caption = 'Current index:'
      FocusControl = edtCurrentIndex
    end
    object rbUseIndex: TRadioButton
      Left = 16
      Top = 24
      Width = 113
      Height = 17
      Caption = 'Use index'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbUseIndexClick
    end
    object rbUseTimestamp: TRadioButton
      Left = 16
      Top = 80
      Width = 113
      Height = 17
      Caption = 'Use timestamp'
      TabOrder = 2
      OnClick = rbUseIndexClick
    end
    object edtCurrentIndex: TBricxccSpinEdit
      Left = 122
      Top = 42
      Width = 60
      Height = 22
      MaxLength = 4
      MaxValue = 9999
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
  object cboImageTypes: TComboBox
    Left = 174
    Top = 88
    Width = 128
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 3
    Text = 'PNG'
    Items.Strings = (
      'JPEG'
      'PNG'
      'BMP')
  end
end
