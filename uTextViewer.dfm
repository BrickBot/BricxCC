object frmTextView: TfrmTextView
  Left = 192
  Top = 130
  BorderStyle = bsDialog
  Caption = 'Text Viewer'
  ClientHeight = 415
  ClientWidth = 605
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 396
    Width = 605
    Height = 19
    Panels = <>
  end
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 605
    Height = 396
    Align = alClient
    PopupMenu = MenuPopup
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object OpenDlg: TOpenDialog
    Left = 40
    Top = 40
  end
  object SaveDlg: TSaveDialog
    Left = 40
    Top = 80
  end
  object MenuPopup: TPopupMenu
    OnPopup = MenuPopupPopup
    Left = 104
    Top = 168
    object MenuCopy: TMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = MenuCopyClick
    end
    object MenuSelectAll: TMenuItem
      Caption = 'Select All'
      ShortCut = 16449
      OnClick = MenuSelectAllClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuOpen: TMenuItem
      Caption = 'Open...'
      OnClick = MenuOpenClick
    end
    object MenuSaveAs: TMenuItem
      Caption = 'Save As...'
      OnClick = MenuSaveAsClick
    end
  end
end
