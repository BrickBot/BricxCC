object frmRGFPreview: TfrmRGFPreview
  Left = 192
  Top = 136
  BorderStyle = bsDialog
  Caption = 'RGF Preview'
  ClientHeight = 163
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnOpen: TButton
    Left = 208
    Top = 16
    Width = 65
    Height = 25
    Caption = 'Open'
    TabOrder = 0
    OnClick = btnOpenClick
  end
  object btnImport: TButton
    Left = 208
    Top = 80
    Width = 65
    Height = 25
    Caption = 'Import'
    TabOrder = 1
    OnClick = btnImportClick
  end
  object dlgOpen: TOpenDialog
    Filter = 'RGF Files|*.rgf'
    Title = 'Open RGF file'
    Left = 232
    Top = 48
  end
end
