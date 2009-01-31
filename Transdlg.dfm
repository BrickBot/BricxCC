object frmTransEdit: TfrmTransEdit
  Left = 238
  Top = 153
  HelpContext = 43000
  ActiveControl = edTitle
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Tool Properties'
  ClientHeight = 310
  ClientWidth = 426
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    Left = 8
    Top = 12
    Width = 23
    Height = 13
    Caption = '&Title:'
    FocusControl = edTitle
    IsControl = True
  end
  object lblProgram: TLabel
    Left = 8
    Top = 40
    Width = 42
    Height = 13
    Caption = '&Program:'
    FocusControl = edProgram
    IsControl = True
  end
  object lblParameters: TLabel
    Left = 8
    Top = 96
    Width = 56
    Height = 13
    Caption = 'P&arameters:'
    FocusControl = edParameters
    IsControl = True
  end
  object lblMacros: TLabel
    Left = 8
    Top = 188
    Width = 38
    Height = 13
    Caption = 'Ma&cros:'
    FocusControl = MacroList
    IsControl = True
  end
  object lblWorkingDir: TLabel
    Left = 8
    Top = 68
    Width = 57
    Height = 13
    Caption = '&Working dir:'
    FocusControl = edWorkingDir
    IsControl = True
  end
  object lblExt: TLabel
    Left = 248
    Top = 124
    Width = 49
    Height = 13
    Caption = 'E&xtension:'
    FocusControl = edtExt
    IsControl = True
  end
  object edTitle: TEdit
    Left = 84
    Top = 8
    Width = 257
    Height = 21
    HelpContext = 43001
    MaxLength = 80
    TabOrder = 0
    OnChange = edTitleChange
    IsControl = True
  end
  object edProgram: TEdit
    Left = 84
    Top = 36
    Width = 257
    Height = 21
    HelpContext = 43002
    MaxLength = 255
    TabOrder = 1
    OnChange = edTitleChange
    IsControl = True
  end
  object edParameters: TEdit
    Left = 84
    Top = 92
    Width = 257
    Height = 21
    HelpContext = 43004
    MaxLength = 255
    TabOrder = 3
    IsControl = True
  end
  object MacroButton: TBitBtn
    Left = 8
    Top = 148
    Width = 72
    Height = 25
    HelpContext = 43005
    Caption = '&Macros'
    TabOrder = 6
    OnClick = MacroButtonClick
    IsControl = True
  end
  object MacroList: TListBox
    Left = 8
    Top = 204
    Width = 333
    Height = 97
    HelpContext = 43006
    ItemHeight = 13
    TabOrder = 7
    TabWidth = 60
    OnClick = MacroListClick
    OnDblClick = InsertButtonClick
    IsControl = True
  end
  object edWorkingDir: TEdit
    Left = 84
    Top = 64
    Width = 257
    Height = 21
    HelpContext = 43003
    TabOrder = 2
    IsControl = True
  end
  object OKButton: TButton
    Left = 348
    Top = 7
    Width = 75
    Height = 25
    HelpContext = 43009
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 8
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 348
    Top = 39
    Width = 75
    Height = 25
    HelpContext = 43010
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 9
  end
  object InsertButton: TButton
    Left = 348
    Top = 204
    Width = 75
    Height = 25
    HelpContext = 43008
    Caption = '&Insert'
    TabOrder = 11
    OnClick = InsertButtonClick
  end
  object BrowseButton: TButton
    Left = 348
    Top = 148
    Width = 75
    Height = 25
    HelpContext = 43007
    Caption = '&Browse...'
    TabOrder = 12
    OnClick = BrowseButtonClick
  end
  object btnHelp: TButton
    Left = 348
    Top = 71
    Width = 75
    Height = 25
    HelpContext = 43011
    Caption = '&Help'
    TabOrder = 10
    OnClick = btnHelpClick
  end
  object chkWait: TCheckBox
    Left = 84
    Top = 152
    Width = 105
    Height = 17
    Caption = 'Wait for program'
    TabOrder = 13
  end
  object chkClose: TCheckBox
    Left = 204
    Top = 152
    Width = 134
    Height = 17
    Caption = 'Close and reopen port'
    TabOrder = 14
  end
  object edtExt: TEdit
    Left = 304
    Top = 120
    Width = 37
    Height = 21
    HelpContext = 43004
    MaxLength = 255
    TabOrder = 5
    IsControl = True
  end
  object chkRestrict: TCheckBox
    Left = 84
    Top = 122
    Width = 161
    Height = 17
    Caption = 'Restrict by file extension?'
    TabOrder = 4
  end
  object OpenDialog: TOpenDialog
    HelpContext = 43012
    Filter = 
      'Programs (*.exe;*.com;*.pif)|*.exe;*.com;*.pif|Any file (*.*)|*.' +
      '*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofShowHelp, ofFileMustExist, ofEnableSizing]
    Title = 'Select Transfer Item'
    Left = 376
    Top = 228
  end
end
