object frmMacroManager: TfrmMacroManager
  Left = 260
  Top = 123
  HelpContext = 3400
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Macro Library'
  ClientHeight = 360
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblMacroName: TLabel
    Left = 8
    Top = 27
    Width = 62
    Height = 13
    Caption = '&Macro name:'
    FocusControl = edtName
  end
  object lblMacrosIn: TLabel
    Left = 8
    Top = 240
    Width = 49
    Height = 13
    Caption = 'M&acros in:'
    FocusControl = cboLibrary
  end
  object lblDescription: TLabel
    Left = 8
    Top = 284
    Width = 56
    Height = 13
    Caption = 'Descr&iption:'
    FocusControl = mmoDescription
  end
  object lblHotKey: TLabel
    Left = 8
    Top = 264
    Width = 37
    Height = 13
    Caption = '&Hotkey:'
  end
  object edtName: TEdit
    Left = 8
    Top = 43
    Width = 224
    Height = 21
    HelpContext = 3405
    TabOrder = 0
    OnChange = edtNameChange
  end
  object lstMacros: TListBox
    Left = 8
    Top = 67
    Width = 224
    Height = 161
    HelpContext = 3406
    ItemHeight = 13
    TabOrder = 1
    OnClick = lstMacrosClick
    OnDblClick = btnRunClick
  end
  object btnRun: TButton
    Left = 245
    Top = 13
    Width = 113
    Height = 24
    HelpContext = 3407
    Caption = '&Run'
    Default = True
    TabOrder = 6
    OnClick = btnRunClick
  end
  object btnEdit: TButton
    Left = 245
    Top = 42
    Width = 113
    Height = 24
    HelpContext = 3408
    Caption = '&Edit'
    TabOrder = 7
    OnClick = btnEditClick
  end
  object btnCreate: TButton
    Left = 245
    Top = 72
    Width = 113
    Height = 24
    HelpContext = 3409
    Caption = '&Create'
    TabOrder = 8
    OnClick = btnCreateClick
  end
  object btnDelete: TButton
    Left = 245
    Top = 102
    Width = 113
    Height = 24
    HelpContext = 3410
    Caption = '&Delete'
    TabOrder = 9
    OnClick = btnDeleteClick
  end
  object btnCancel: TButton
    Left = 245
    Top = 174
    Width = 113
    Height = 24
    HelpContext = 3411
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 11
    OnClick = btnCancelClick
  end
  object cboLibrary: TComboBox
    Left = 64
    Top = 236
    Width = 270
    Height = 21
    HelpContext = 3412
    ItemHeight = 13
    TabOrder = 2
    OnClick = cboLibraryClick
    OnExit = cboLibraryExit
  end
  object btnBrowse: TButton
    Left = 337
    Top = 236
    Width = 21
    Height = 21
    HelpContext = 3413
    Caption = '...'
    TabOrder = 3
    OnClick = btnBrowseClick
  end
  object mmoDescription: TMemo
    Left = 8
    Top = 300
    Width = 353
    Height = 55
    HelpContext = 3414
    MaxLength = 200
    TabOrder = 5
    OnChange = mmoDescriptionChange
  end
  object btnOK: TButton
    Left = 245
    Top = 144
    Width = 113
    Height = 24
    HelpContext = 3415
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 10
    OnClick = btnOKClick
  end
  object chkSuspend: TCheckBox
    Left = 8
    Top = 8
    Width = 201
    Height = 17
    HelpContext = 3416
    Caption = '&Suspend macro recording'
    TabOrder = 13
    OnClick = chkSuspendClick
  end
  object btnHelp: TButton
    Left = 245
    Top = 204
    Width = 113
    Height = 24
    HelpContext = 3417
    Caption = '&Help'
    TabOrder = 12
    OnClick = btnHelpClick
  end
  object hkMacro2: TEdit
    Left = 64
    Top = 261
    Width = 121
    Height = 21
    HelpContext = 3418
    TabOrder = 4
    Text = 'None'
    OnExit = hkMacroExit
  end
  object dlgOpen: TOpenDialog
    Filter = 'Macro Library (*.mlb)|*.mlb|All Files (*.*)|*.*'
    Title = 'Browse for Macro Library'
    Left = 256
    Top = 276
  end
end
