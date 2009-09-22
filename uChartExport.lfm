object frmChartExport: TfrmChartExport
  Left = 347
  Top = 294
  HelpContext = 51000
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Chart Export'
  ClientHeight = 138
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 5
    Top = 5
    Width = 172
    Height = 124
    Caption = 'Format'
    TabOrder = 0
    object radBmp: TRadioButton
      Tag = 1
      Left = 8
      Top = 17
      Width = 113
      Height = 17
      HelpContext = 51001
      Caption = 'As &Bitmap (BMP)'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = FormatClicked
    end
    object radWMF: TRadioButton
      Tag = 2
      Left = 8
      Top = 53
      Width = 113
      Height = 17
      HelpContext = 51002
      Caption = 'As &Metafile (WMF)'
      TabOrder = 1
      OnClick = FormatClicked
    end
    object radEMF: TRadioButton
      Tag = 3
      Left = 8
      Top = 90
      Width = 157
      Height = 17
      HelpContext = 51003
      Caption = 'As &Enhanced Metafile (EMF)'
      TabOrder = 2
      OnClick = FormatClicked
    end
  end
  object btnClipboard: TButton
    Left = 184
    Top = 8
    Width = 105
    Height = 25
    HelpContext = 51004
    Caption = '&Copy To Clipboard'
    TabOrder = 1
    OnClick = btnClipboardClick
  end
  object btnSave: TButton
    Left = 184
    Top = 40
    Width = 105
    Height = 25
    HelpContext = 51005
    Caption = '&Save To File...'
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnClose: TButton
    Left = 184
    Top = 72
    Width = 105
    Height = 25
    HelpContext = 51006
    Cancel = True
    Caption = 'Close'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnHelp: TButton
    Left = 184
    Top = 104
    Width = 105
    Height = 25
    HelpContext = 51007
    Caption = '&Help'
    TabOrder = 4
    OnClick = btnHelpClick
  end
  object dlgSave: TSaveDialog
    FileName = 'Chart.BMP'
    Filter = 
      'Bitmap Files (*.bmp)|*.bmp|Metafile Files (*.wmf)|*.wmf|Enhanced' +
      ' Metafile Files (*.emf)|*.emf'
    Title = 'Save Graph'
    Left = 56
    Top = 2
  end
end
