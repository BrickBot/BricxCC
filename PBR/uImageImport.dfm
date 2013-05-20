object frmImageImport: TfrmImageImport
  Left = 265
  Top = 232
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Image Import'
  ClientHeight = 255
  ClientWidth = 396
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
  object Bevel1: TBevel
    Left = 4
    Top = 20
    Width = 187
    Height = 137
  end
  object bvlEV3: TBevel
    Left = 203
    Top = 20
    Width = 187
    Height = 137
  end
  object lblPreview: TLabel
    Left = 8
    Top = 4
    Width = 34
    Height = 13
    Caption = 'Source'
  end
  object lblPreview2: TLabel
    Left = 203
    Top = 6
    Width = 63
    Height = 13
    Caption = 'RGF Preview'
  end
  object imgEV3: TImage
    Left = 208
    Top = 26
    Width = 178
    Height = 128
    OnMouseDown = imgEV3MouseDown
    OnMouseMove = imgEV3MouseMove
    OnMouseUp = imgEV3MouseUp
  end
  object lblContrast: TLabel
    Left = 9
    Top = 203
    Width = 39
    Height = 13
    Caption = 'Contrast'
  end
  object imgOriginal: TImage
    Left = 9
    Top = 26
    Width = 178
    Height = 128
  end
  object btnSelect: TButton
    Left = 8
    Top = 225
    Width = 75
    Height = 25
    Caption = 'Select'
    TabOrder = 0
    OnClick = btnSelectClick
  end
  object btnSave: TButton
    Left = 312
    Top = 225
    Width = 75
    Height = 25
    Caption = 'Save'
    Enabled = False
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object barBrightness: TTrackBar
    Left = 86
    Top = 198
    Width = 299
    Height = 23
    Max = 100
    Frequency = 5
    Position = 50
    TabOrder = 2
    TabStop = False
    ThumbLength = 10
    OnChange = barBrightnessChange
  end
  object chkStretch: TCheckBox
    Left = 8
    Top = 160
    Width = 67
    Height = 17
    Caption = 'Stretch'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = chkCenterClick
  end
  object chkCenter: TCheckBox
    Left = 8
    Top = 176
    Width = 67
    Height = 17
    Caption = 'Center'
    TabOrder = 4
    OnClick = chkCenterClick
  end
  object chkProportional: TCheckBox
    Left = 88
    Top = 176
    Width = 97
    Height = 17
    Caption = 'Proportional'
    TabOrder = 5
    OnClick = chkCenterClick
  end
  object dlgSelect: TOpenPictureDialog
    Filter = 
      'All Image Files|*.jpg;*.jpeg;*.bmp;*.png;*.gif|JPEG Image File (' +
      '*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|Bitmaps (*.bmp)|*.b' +
      'mp|PNG Image File (*.png)|*.png|GIF Image File (*.gif)|*.gif'
    Title = 'Select Image'
    Left = 184
    Top = 32
  end
  object dlgSave: TSaveDialog
    DefaultExt = '.rgf'
    Filter = 'RGF Image File (*.rgf)|*.rgf|All Files|*.*'
    Title = 'Save RGF'
    Left = 184
    Top = 64
  end
end
