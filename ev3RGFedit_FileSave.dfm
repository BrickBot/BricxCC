object frmFileSave: TfrmFileSave
  Left = 451
  Top = 228
  BorderStyle = bsDialog
  Caption = 'Save Image'
  ClientHeight = 368
  ClientWidth = 219
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label_Filename: TLabel
    Left = 8
    Top = 8
    Width = 42
    Height = 13
    Caption = 'Filename'
    Color = clBtnFace
    ParentColor = False
  end
  object Label_InfoImageWidth: TLabel
    Left = 24
    Top = 60
    Width = 57
    Height = 13
    Caption = 'Image width'
    Color = clBtnFace
    ParentColor = False
  end
  object Label_InfoImageHeight: TLabel
    Left = 24
    Top = 80
    Width = 61
    Height = 13
    Caption = 'Image height'
    Color = clBtnFace
    ParentColor = False
  end
  object Label_ImageWidth: TLabel
    Left = 100
    Top = 60
    Width = 5
    Height = 13
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label_ImageHeight: TLabel
    Left = 100
    Top = 80
    Width = 5
    Height = 13
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object BitBtn_Abort: TBitBtn
    Left = 20
    Top = 308
    Width = 177
    Height = 41
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn_Save: TBitBtn
    Left = 20
    Top = 260
    Width = 177
    Height = 41
    Caption = 'Save'
    Default = True
    TabOrder = 1
    OnClick = BitBtn_SaveClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object Edit_Filename: TEdit
    Left = 8
    Top = 24
    Width = 193
    Height = 21
    Hint = 'Define the file name for saving the image'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object GroupBox_Borders: TGroupBox
    Left = 20
    Top = 104
    Width = 177
    Height = 137
    Caption = 'Add Borders'
    TabOrder = 3
    object Label_FillBorder: TLabel
      Left = 24
      Top = 88
      Width = 48
      Height = 13
      Caption = 'Fill border:'
      Color = clBtnFace
      ParentColor = False
    end
    object RadioButton_Dark: TRadioButton
      Left = 88
      Top = 108
      Width = 41
      Height = 19
      Hint = 'Fill border with dark pixels'
      Caption = 'dark'
      TabOrder = 4
    end
    object RadioButton_Bright: TRadioButton
      Left = 88
      Top = 88
      Width = 46
      Height = 19
      Hint = 'Fill border with bright pixels'
      Caption = 'bright'
      Checked = True
      TabOrder = 5
      TabStop = True
    end
    object SpinEdit_BorderTop: TBricxccSpinEdit
      Left = 68
      Top = 20
      Width = 41
      Height = 22
      Hint = 'Add pixels to the upper border'
      MaxValue = 99
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 0
    end
    object SpinEdit_BorderLeft: TBricxccSpinEdit
      Left = 24
      Top = 40
      Width = 41
      Height = 22
      Hint = 'Add pixels to the left border'
      MaxValue = 99
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 0
    end
    object SpinEdit_BorderRight: TBricxccSpinEdit
      Left = 112
      Top = 40
      Width = 41
      Height = 22
      Hint = 'Add pixels to the right border'
      MaxValue = 99
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = 0
    end
    object SpinEdit_BorderBottom: TBricxccSpinEdit
      Left = 68
      Top = 60
      Width = 41
      Height = 22
      Hint = 'Add pixels to the bottom border'
      MaxValue = 99
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Value = 0
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = '.rgf'
    Filter = 
      'RGF Files (*.rgf)|*.rgf|RIC Files (*.ric)|*.ric|All Files (*.*)|' +
      '*.*'
    Title = 'Save File...'
    Left = 168
    Top = 64
  end
end
