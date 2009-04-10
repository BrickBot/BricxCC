object fmAlign: TfmAlign
  Left = 459
  Top = 281
  ActiveControl = lstTokens
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'Align Lines'
  ClientHeight = 268
  ClientWidth = 181
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 135
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  DesignSize = (
    181
    268)
  PixelsPerInch = 96
  TextHeight = 14
  object lblToken: TLabel
    Left = 8
    Top = 7
    Width = 84
    Height = 14
    Caption = '&Align on token:'
    FocusControl = lstTokens
  end
  object btnOK: TButton
    Left = 8
    Top = 235
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 97
    Top = 235
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object lstTokens: TListBox
    Left = 8
    Top = 25
    Width = 163
    Height = 181
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 14
    PopupMenu = pmuTokens
    TabOrder = 0
    OnDblClick = lstTokensDblClick
  end
  object cbxMode: TComboBox
    Left = 8
    Top = 210
    Width = 164
    Height = 22
    Style = csDropDownList
    Anchors = [akLeft, akRight, akBottom]
    ItemHeight = 14
    ItemIndex = 0
    TabOrder = 1
    Text = 'Align at rightmost token'
    Items.Strings = (
      'Align at rightmost token'
      'Align at first token')
  end
  object pmuTokens: TPopupMenu
    Left = 16
    Top = 32
    object mitConfiguration: TMenuItem
      Caption = 'Configuration...'
      OnClick = mitConfigurationClick
    end
  end
end
