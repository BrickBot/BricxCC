object frmProjectManager: TfrmProjectManager
  Left = 309
  Top = 263
  Width = 180
  Height = 218
  HelpContext = 37000
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Project Manager'
  Color = clBtnFace
  Constraints.MinHeight = 190
  Constraints.MinWidth = 180
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    172
    184)
  PixelsPerInch = 96
  TextHeight = 13
  object lblFiles: TLabel
    Left = 4
    Top = 32
    Width = 24
    Height = 13
    Caption = '&Files:'
    FocusControl = lstFiles
  end
  object lblProject: TLabel
    Left = 4
    Top = 8
    Width = 43
    Height = 13
    Caption = 'lblProject'
  end
  object lstFiles: TListBox
    Left = 4
    Top = 48
    Width = 165
    Height = 104
    HelpContext = 37001
    Anchors = [akLeft, akTop, akRight, akBottom]
    DragMode = dmAutomatic
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
    OnClick = lstFilesClick
    OnDblClick = lstFilesDblClick
    OnDragDrop = lstFilesDragDrop
    OnDragOver = lstFilesDragOver
  end
  object btnHelp: TButton
    Left = 117
    Top = 156
    Width = 52
    Height = 25
    HelpContext = 37002
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 1
    OnClick = btnHelpClick
  end
  object dlgOpen: TOpenDialog
    Options = [ofHideReadOnly, ofNoChangeDir, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 120
    Top = 8
  end
end
