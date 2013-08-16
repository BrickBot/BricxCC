object frmFileOpen: TfrmFileOpen
  Left = 146
  Top = 115
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Open RGF/RIC image'
  ClientHeight = 386
  ClientWidth = 201
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
  object Bevel1: TBevel
    Left = 7
    Top = 96
    Width = 187
    Height = 137
  end
  object Label_ImageWidth: TLabel
    Left = 83
    Top = 32
    Width = 22
    Height = 13
    Caption = 'test'
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
    Left = 83
    Top = 52
    Width = 22
    Height = 13
    Caption = 'test'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label_InfoImageHeight: TLabel
    Left = 7
    Top = 52
    Width = 61
    Height = 13
    Caption = 'Image height'
    Color = clBtnFace
    ParentColor = False
  end
  object Label_InfoImageWidth: TLabel
    Left = 7
    Top = 32
    Width = 57
    Height = 13
    Caption = 'Image width'
    Color = clBtnFace
    ParentColor = False
  end
  object Label_Preview: TLabel
    Left = 7
    Top = 80
    Width = 38
    Height = 13
    Caption = 'Preview'
    Color = clBtnFace
    ParentColor = False
  end
  object Image_Preview: TImage
    Left = 12
    Top = 101
    Width = 178
    Height = 128
  end
  object Label1: TLabel
    Left = 7
    Top = 13
    Width = 42
    Height = 13
    Caption = 'Filename'
    Color = clBtnFace
    ParentColor = False
  end
  object Label_Filename: TLabel
    Left = 83
    Top = 13
    Width = 22
    Height = 13
    Caption = 'test'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object btnAbort: TBitBtn
    Left = 11
    Top = 338
    Width = 177
    Height = 41
    Caption = 'Abort'
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
  object btnLoad: TBitBtn
    Left = 11
    Top = 290
    Width = 177
    Height = 41
    Caption = 'Load'
    TabOrder = 1
    OnClick = btnLoadClick
    Kind = bkOK
  end
  object btnBrowse: TBitBtn
    Left = 11
    Top = 242
    Width = 177
    Height = 41
    Caption = 'Browse'
    TabOrder = 2
    OnClick = btnBrowseClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330CFF
      FFC0333333337F7777F7333333330CFFFFC0333333337F777737333333330CCC
      CCC0333333337F33FF37333333330CC88CC0333333337F377F37333333330CC8
      8CC0333333337FF77FF733333333000000003FFFFFFF77777777000000033333
      33337777777F3333333F0FFFFF03333333937F33337F3333337F0FFFFF033333
      33937F33337F3333F37F0FFFFF03333933937F33337F3337F37F0FFFFF033399
      33937F33337F3377F37F0FFFFF03399933937F33FF7F3777FF7F0FF000039999
      99937F377773777777730FF0F033399933337F37F7333777F3330FF003333399
      33337FF773333377F33300003333333933337777333333373333}
    NumGlyphs = 2
  end
  object dlgOpen: TOpenDialog
    Filter = 
      'RGF Files (*.rgf)|*.rgf|RIC Files (*.ric)|*.ric|All images (*.ri' +
      'c;*.rgf)|*.ric;*.rgf'
    Left = 144
    Top = 72
  end
end
