object frmTransferDlg: TfrmTransferDlg
  Left = 266
  Top = 119
  HelpContext = 44000
  ActiveControl = ItemList
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Tool Options'
  ClientHeight = 274
  ClientWidth = 291
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblTools: TLabel
    Left = 8
    Top = 8
    Width = 29
    Height = 13
    Caption = '&Tools:'
    FocusControl = ItemList
    IsControl = True
  end
  object ItemList: TListBox
    Left = 8
    Top = 24
    Width = 189
    Height = 245
    HelpContext = 44001
    ItemHeight = 13
    TabOrder = 0
    OnClick = ItemListClick
    OnDblClick = EditButtonClick
    OnDragOver = ItemListDragOver
    IsControl = True
  end
  object DnBtn: TBitBtn
    Left = 248
    Top = 124
    Width = 23
    Height = 23
    HelpContext = 44006
    TabOrder = 5
    OnClick = MoveClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333833333333333333488333333333333CC4883333333333CCCC488
      33333333CCCCCC488333333CCCCCC444333333333CCCC483333333333CCCC483
      333333333CCCC483333333333CCCC483333333333CCCC483333333333CCCC433
      3333333333333333333333333333333333333333333333333333}
  end
  object UpBtn: TBitBtn
    Left = 220
    Top = 124
    Width = 25
    Height = 23
    HelpContext = 44005
    TabOrder = 4
    OnClick = MoveClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333338888833333333334444483333333333CCCC483
      333333333CCCC483333333333CCCC483333333333CCCC483333333333CCCC488
      8333333CCCCCCCCC33333333CCCCCCC3333333333CCCCC333333333333CCC333
      33333333333C3333333333333333333333333333333333333333}
  end
  object AddButton: TButton
    Left = 208
    Top = 24
    Width = 75
    Height = 25
    HelpContext = 44002
    Caption = '&Add...'
    TabOrder = 1
    OnClick = AddButtonClick
  end
  object DelButton: TButton
    Left = 208
    Top = 56
    Width = 75
    Height = 25
    HelpContext = 44003
    Caption = '&Delete'
    TabOrder = 2
    OnClick = DelButtonClick
  end
  object EditButton: TButton
    Left = 208
    Top = 88
    Width = 75
    Height = 25
    HelpContext = 44004
    Caption = '&Edit'
    TabOrder = 3
    OnClick = EditButtonClick
  end
  object CloseButton: TButton
    Left = 208
    Top = 211
    Width = 75
    Height = 25
    HelpContext = 44008
    Cancel = True
    Caption = '&Close'
    ModalResult = 1
    TabOrder = 6
  end
  object btnHelp: TButton
    Left = 208
    Top = 243
    Width = 75
    Height = 25
    HelpContext = 44007
    Caption = '&Help'
    TabOrder = 7
    OnClick = btnHelpClick
  end
end
