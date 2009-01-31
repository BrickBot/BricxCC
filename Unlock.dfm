object UnlockForm: TUnlockForm
  Left = 200
  Top = 108
  HelpContext = 23
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Firmware Download'
  ClientHeight = 95
  ClientWidth = 236
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 205
    Height = 13
    Caption = 'Downloading Firmware, Please wait.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ProgressBar1: TProgressBar
    Left = 16
    Top = 40
    Width = 201
    Height = 17
    Max = 175
    Step = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 80
    Top = 64
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
end
