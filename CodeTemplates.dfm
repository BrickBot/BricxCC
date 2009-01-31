object frmCodeTemplates: TfrmCodeTemplates
  Left = 261
  Top = 140
  HelpContext = 5200
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Code Templates'
  ClientHeight = 300
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grpTemplates: TGroupBox
    Left = 4
    Top = 4
    Width = 361
    Height = 263
    Caption = 'Code Templates'
    TabOrder = 0
    object lblTemplate: TLabel
      Left = 8
      Top = 16
      Width = 47
      Height = 13
      Caption = '&Template:'
    end
    object lblCode: TLabel
      Left = 8
      Top = 99
      Width = 28
      Height = 13
      Caption = '&Code:'
    end
    object grdTemplates: TStringGrid
      Left = 59
      Top = 16
      Width = 233
      Height = 80
      HelpContext = 5204
      ColCount = 2
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goDrawFocusSelected]
      TabOrder = 0
      OnSelectCell = grdTemplatesSelectCell
      ColWidths = (
        57
        151)
    end
    object btnAdd: TButton
      Left = 299
      Top = 17
      Width = 55
      Height = 24
      HelpContext = 5205
      Caption = '&Add...'
      TabOrder = 2
      OnClick = btnAddClick
    end
    object btnEdit: TButton
      Left = 299
      Top = 44
      Width = 55
      Height = 24
      HelpContext = 5206
      Caption = '&Edit...'
      TabOrder = 3
      OnClick = btnEditClick
    end
    object btnDelete: TButton
      Left = 299
      Top = 71
      Width = 55
      Height = 24
      HelpContext = 5207
      Caption = '&Delete'
      TabOrder = 4
      OnClick = btnDeleteClick
    end
    object mmoCode: TMemo
      Left = 59
      Top = 99
      Width = 296
      Height = 157
      HelpContext = 5208
      ScrollBars = ssBoth
      TabOrder = 1
      OnChange = mmoCodeChange
    end
    object btnLoad: TButton
      Left = 6
      Top = 204
      Width = 50
      Height = 24
      HelpContext = 5209
      Caption = '&Load'
      TabOrder = 5
      OnClick = btnLoadClick
    end
    object btnSave: TButton
      Left = 6
      Top = 232
      Width = 50
      Height = 24
      HelpContext = 5210
      Caption = '&Save'
      TabOrder = 6
      OnClick = btnSaveClick
    end
  end
  object btnOK: TButton
    Left = 129
    Top = 272
    Width = 75
    Height = 25
    HelpContext = 5211
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 209
    Top = 272
    Width = 75
    Height = 25
    HelpContext = 5212
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 289
    Top = 272
    Width = 75
    Height = 25
    HelpContext = 5215
    Caption = '&Help'
    TabOrder = 3
    OnClick = btnHelpClick
  end
  object dlgOpen: TOpenDialog
    DefaultExt = 'dci'
    Filter = 'Code Templates (*.dci)|*.dci'
    Left = 216
    Top = 8
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'dci'
    Filter = 'Code Templates (*.dci)|*.dci'
    Left = 248
    Top = 8
  end
end
