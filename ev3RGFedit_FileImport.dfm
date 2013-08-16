object frmImageImport: TfrmImageImport
  Left = 170
  Top = 327
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Image Import'
  ClientHeight = 278
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object imgOriginal: TImage
    Left = 13
    Top = 26
    Width = 178
    Height = 128
  end
  object Bevel1: TBevel
    Left = 8
    Top = 20
    Width = 187
    Height = 137
  end
  object lblPreview: TLabel
    Left = 12
    Top = 4
    Width = 34
    Height = 13
    Caption = 'Source'
    Color = clBtnFace
    ParentColor = False
  end
  object lblPreview2: TLabel
    Left = 203
    Top = 6
    Width = 63
    Height = 13
    Caption = 'RGF Preview'
    Color = clBtnFace
    ParentColor = False
  end
  object bvlEV3: TBevel
    Left = 203
    Top = 20
    Width = 187
    Height = 137
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
    Color = clBtnFace
    ParentColor = False
  end
  object chkStretch: TCheckBox
    Left = 8
    Top = 160
    Width = 54
    Height = 19
    Caption = 'Stretch'
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = chkCenterClick
  end
  object chkCenter: TCheckBox
    Left = 8
    Top = 176
    Width = 51
    Height = 19
    Caption = 'Center'
    TabOrder = 1
    OnClick = chkCenterClick
  end
  object chkProportional: TCheckBox
    Left = 88
    Top = 176
    Width = 76
    Height = 19
    Caption = 'Proportional'
    TabOrder = 2
    OnClick = chkCenterClick
  end
  object barBrightness: TTrackBar
    Left = 86
    Top = 198
    Width = 299
    Height = 23
    Max = 100
    Frequency = 5
    Position = 50
    TabOrder = 3
    TabStop = False
    OnChange = barBrightnessChange
  end
  object btnSelect: TButton
    Left = 8
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 4
    OnClick = btnSelectClick
  end
  object btnOK: TButton
    Left = 216
    Top = 232
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 304
    Top = 232
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
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
