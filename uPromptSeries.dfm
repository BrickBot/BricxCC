object frmSeriesPrompt: TfrmSeriesPrompt
  Left = 457
  Top = 239
  HelpContext = 39000
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Select Series'
  ClientHeight = 186
  ClientWidth = 172
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
  object lblSeries: TLabel
    Left = 8
    Top = 3
    Width = 32
    Height = 13
    Caption = '&Series:'
    FocusControl = lstSeries
  end
  object lstSeries: TListBox
    Left = 8
    Top = 19
    Width = 156
    Height = 129
    HelpContext = 39001
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = lstSeriesDblClick
  end
  object btnOK: TButton
    Left = 5
    Top = 155
    Width = 52
    Height = 25
    HelpContext = 39002
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 60
    Top = 155
    Width = 52
    Height = 25
    HelpContext = 39003
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 115
    Top = 155
    Width = 52
    Height = 25
    HelpContext = 39004
    Caption = '&Help'
    TabOrder = 3
    OnClick = btnHelpClick
  end
end
