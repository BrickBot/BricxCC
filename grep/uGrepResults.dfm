object fmGrepResults: TfmGrepResults
  Left = 324
  Top = 243
  Width = 509
  Height = 545
  Caption = 'Grep Results'
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = True
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 501
    Height = 474
    Align = alClient
    BevelOuter = bvNone
    FullRepaint = False
    TabOrder = 0
    object Splitter: TSplitter
      Left = 0
      Top = 384
      Width = 501
      Height = 8
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      Beveled = True
      MinSize = 20
    end
    object lbResults: TListBox
      Left = 0
      Top = 22
      Width = 501
      Height = 362
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 17
      TabOrder = 0
      OnClick = lbResultsClick
      OnDblClick = actListGotoSelectedExecute
      OnDrawItem = lbResultsDrawItem
      OnKeyDown = lbResultsKeyDown
      OnKeyPress = lbResultsKeyPress
      OnMouseUp = lbResultsMouseUp
    end
    object ToolBar: TToolBar
      Left = 0
      Top = 0
      Width = 501
      Height = 22
      AutoSize = True
      DisabledImages = dmSharedImages.DisabledImages
      EdgeBorders = []
      Flat = True
      Images = dmSharedImages.Images
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Wrapable = False
      object tbnSearch: TToolButton
        Left = 0
        Top = 0
        Action = actFileSearch
      end
      object tbnRefresh: TToolButton
        Left = 23
        Top = 0
        Action = actFileRefresh
      end
      object tbnSep1: TToolButton
        Left = 46
        Top = 0
        Width = 8
        ImageIndex = 7
        Style = tbsSeparator
      end
      object tbnAbort: TToolButton
        Left = 54
        Top = 0
        Action = actFileAbort
      end
      object tbnSep2: TToolButton
        Left = 77
        Top = 0
        Width = 8
        ImageIndex = 3
        Style = tbsSeparator
      end
      object tbnGoto: TToolButton
        Left = 85
        Top = 0
        Action = actListGotoSelected
      end
      object tbnSep3: TToolButton
        Left = 108
        Top = 0
        Width = 8
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbnPrint: TToolButton
        Left = 116
        Top = 0
        Action = actFilePrint
      end
      object tbnSep4: TToolButton
        Left = 139
        Top = 0
        Width = 8
        ImageIndex = 5
        Style = tbsSeparator
      end
      object tbnContract: TToolButton
        Left = 147
        Top = 0
        Action = actListContract
      end
      object tbnExpand: TToolButton
        Left = 170
        Top = 0
        Action = actListExpand
      end
      object tbnSep5: TToolButton
        Left = 193
        Top = 0
        Width = 8
        ImageIndex = 8
        Style = tbsSeparator
      end
      object tbnReplaceSelected: TToolButton
        Left = 201
        Top = 0
        Action = actReplaceSelected
      end
      object tbnReplaceAll: TToolButton
        Left = 224
        Top = 0
        Action = actReplaceAll
      end
      object tbnSep6: TToolButton
        Left = 247
        Top = 0
        Width = 8
        ImageIndex = 9
        Style = tbsSeparator
      end
      object tbnStayOnTop: TToolButton
        Left = 255
        Top = 0
        Action = actViewStayOnTop
      end
      object tbnSep7: TToolButton
        Left = 278
        Top = 0
        Width = 8
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbnHelp: TToolButton
        Left = 286
        Top = 0
        Action = actHelpHelp
      end
    end
    object reContext: TRichEdit
      Left = 0
      Top = 392
      Width = 501
      Height = 82
      Align = alBottom
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      WordWrap = False
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 474
    Width = 501
    Height = 17
    Panels = <
      item
        Width = 250
      end
      item
        Width = 60
      end>
    ParentFont = True
    UseSystemFont = False
  end
  object MainMenu: TMainMenu
    Images = dmSharedImages.Images
    Left = 24
    Top = 32
    object mitFile: TMenuItem
      Caption = '&File'
      Left = 522
      Top = 351
      object mitFileSearch: TMenuItem
        Action = actFileSearch
        Left = 532
        Top = 361
      end
      object mitFileRefresh: TMenuItem
        Action = actFileRefresh
        Left = 542
        Top = 371
      end
      object mitFileAbort: TMenuItem
        Action = actFileAbort
        Left = 552
        Top = 381
      end
      object mitFileSep1: TMenuItem
        Caption = '-'
      end
      object mitFilePrint: TMenuItem
        Action = actFilePrint
        Left = 562
        Top = 391
      end
      object mitFileSave: TMenuItem
        Action = actFileSave
      end
      object mitFileSep3: TMenuItem
        Caption = '-'
      end
      object mitFileExit: TMenuItem
        Action = actFileExit
        Left = 592
        Top = 421
      end
    end
    object mitList: TMenuItem
      Caption = '&List'
      Left = 602
      Top = 422
      object mitListGotoSelected: TMenuItem
        Action = actListGotoSelected
        Left = 764
        Top = 422
      end
      object mitListSep1: TMenuItem
        Caption = '-'
      end
      object mitFileCopy: TMenuItem
        Action = actFileCopy
      end
      object mitListSep2: TMenuItem
        Caption = '-'
      end
      object mitListContract: TMenuItem
        Action = actListContract
        Left = 764
        Top = 422
      end
      object mitListExpand: TMenuItem
        Action = actListExpand
        Left = 764
        Top = 422
      end
    end
    object mitView: TMenuItem
      Caption = '&View'
      object mitViewOptions: TMenuItem
        Action = actViewOptions
      end
      object mitViewSep1: TMenuItem
        Caption = '-'
      end
      object mitViewToolBar: TMenuItem
        Action = actViewToolBar
      end
      object miViewShowMatchContext: TMenuItem
        Action = actViewShowContext
      end
      object mitViewSep2: TMenuItem
        Caption = '-'
      end
      object mitViewStayOnTop: TMenuItem
        Action = actViewStayOnTop
        Left = 572
        Top = 401
      end
    end
    object mitReplace: TMenuItem
      Caption = 'Replace'
      object mitReplaceReplaceAll: TMenuItem
        Action = actReplaceAll
      end
      object mitReplaceSelected: TMenuItem
        Action = actReplaceSelected
      end
    end
    object mitHelp: TMenuItem
      Caption = '&Help'
      Left = 764
      Top = 422
      object mitHelpHelp: TMenuItem
        Action = actHelpHelp
        Left = 764
        Top = 422
      end
      object mitHelpContents: TMenuItem
        Action = actHelpContents
      end
      object mitHelpSep1: TMenuItem
        Caption = '-'
      end
      object mitHelpAbout: TMenuItem
        Action = actHelpAbout
        Left = 764
        Top = 422
      end
    end
  end
  object Actions: TActionList
    Images = dmSharedImages.Images
    OnUpdate = ActionsUpdate
    Left = 88
    Top = 32
    object actReplaceSelected: TAction
      Category = 'Replace'
      Caption = 'Replace Selected Item...'
      Hint = 'Replace selected item...'
      ImageIndex = 60
      ShortCut = 24659
      OnExecute = actReplaceSelectedExecute
    end
    object actFileSearch: TAction
      Category = 'File'
      Caption = '&Search...'
      Hint = 'New search...'
      ImageIndex = 14
      ShortCut = 16467
      OnExecute = actFileSearchExecute
    end
    object actFileRefresh: TAction
      Category = 'File'
      Caption = '&Refresh'
      Hint = 'Refresh search'
      ImageIndex = 34
      ShortCut = 116
      OnExecute = actFileRefreshExecute
    end
    object actFileAbort: TAction
      Category = 'File'
      Caption = '&Abort'
      Hint = 'Abort search'
      ImageIndex = 32
      ShortCut = 16449
      OnExecute = actFileAbortExecute
    end
    object actFilePrint: TAction
      Category = 'File'
      Caption = '&Print'
      Hint = 'Print results'
      ImageIndex = 3
      ShortCut = 16464
      OnExecute = actFilePrintExecute
    end
    object actViewStayOnTop: TAction
      Category = 'View'
      Caption = 'Stay on Top'
      Hint = 'Stay on top'
      ImageIndex = 33
      OnExecute = actViewStayOnTopExecute
    end
    object actFileExit: TAction
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit'
      ImageIndex = 8
      ShortCut = 32883
      OnExecute = actFileExitExecute
    end
    object actListGotoSelected: TAction
      Category = 'List'
      Caption = 'Goto Selected'
      Hint = 'Goto match'
      ImageIndex = 27
      OnExecute = actListGotoSelectedExecute
    end
    object actListContract: TAction
      Category = 'List'
      Caption = '&Contract'
      Hint = 'Contract all'
      ImageIndex = 13
      ShortCut = 16462
      OnExecute = actListContractExecute
    end
    object actListExpand: TAction
      Category = 'List'
      Caption = '&Expand'
      Hint = 'Expand all'
      ImageIndex = 12
      ShortCut = 16453
      OnExecute = actListExpandExecute
    end
    object actHelpHelp: TAction
      Category = 'Help'
      Caption = '&Help'
      Hint = 'Help'
      ImageIndex = 0
      ShortCut = 112
      OnExecute = actHelpHelpExecute
    end
    object actHelpContents: TAction
      Category = 'Help'
      Caption = '&Contents'
      Hint = 'Contents'
      OnExecute = actHelpContentsExecute
    end
    object actHelpAbout: TAction
      Category = 'Help'
      Caption = '&About...'
      Hint = 'About...'
      ImageIndex = 16
      OnExecute = actHelpAboutExecute
    end
    object actViewShowContext: TAction
      Category = 'View'
      Caption = 'Show Match Context'
      Checked = True
      ShortCut = 16468
      OnExecute = actShowMatchContextExecute
    end
    object actFileSave: TAction
      Category = 'File'
      Caption = '&Save...'
      Hint = 'Save results to file...'
      ImageIndex = 31
      ShortCut = 49235
      OnExecute = actFileSaveExecute
    end
    object actFileCopy: TAction
      Category = 'File'
      Caption = '&Copy'
      Hint = 'Copy results to clipboard'
      ImageIndex = 6
      ShortCut = 16451
      OnExecute = actFileCopyExecute
    end
    object actViewToolBar: TAction
      Category = 'View'
      Caption = 'Toolbar'
      Checked = True
      OnExecute = actViewToolBarExecute
    end
    object actViewOptions: TAction
      Category = 'View'
      Caption = 'Options...'
      ImageIndex = 17
      ShortCut = 16460
      OnExecute = actViewOptionsExecute
    end
    object actReplaceAll: TAction
      Category = 'Replace'
      Caption = 'Replace All Items...'
      Hint = 'Replace all items...'
      ImageIndex = 61
      ShortCut = 24641
      OnExecute = actReplaceAllExecute
    end
  end
end
