object frmNXTDumper: TfrmNXTDumper
  Left = 320
  Top = 154
  Width = 454
  Height = 447
  Caption = 'NXT Program Dumper'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object barStatus: TStatusBar
    Left = 0
    Top = 374
    Width = 446
    Height = 19
    AutoHint = True
    Panels = <>
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 446
    Height = 2
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object pag1: TPageControl
    Left = 0
    Top = 2
    Width = 446
    Height = 372
    ActivePage = shtSource
    Align = alClient
    TabOrder = 2
    object shtSource: TTabSheet
      Caption = 'Sourcecode'
      object splMain: TSplitter
        Left = 0
        Top = 244
        Width = 438
        Height = 2
        Cursor = crVSplit
        Align = alBottom
        Color = clBtnFace
        ParentColor = False
      end
      object grpMessages: TGroupBox
        Left = 0
        Top = 246
        Width = 438
        Height = 98
        Align = alBottom
        Caption = 'Compiler messages'
        TabOrder = 0
        DesignSize = (
          438
          98)
        object mmoTest: TMemo
          Left = 8
          Top = 15
          Width = 422
          Height = 74
          Anchors = [akLeft, akTop, akRight, akBottom]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          HideSelection = False
          ParentFont = False
          PopupMenu = popMain
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
      end
      object mmoDump: TMemo
        Left = 0
        Top = 0
        Width = 438
        Height = 244
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        HideSelection = False
        ParentFont = False
        PopupMenu = popMain
        ScrollBars = ssBoth
        TabOrder = 1
        WantTabs = True
        WordWrap = False
        OnChange = mmoDumpChange
      end
    end
  end
  object dlgOpen: TOpenDialog
    DefaultExt = 'rxe'
    Filter = 
      'NXT Programs (*.rxe;*.rtm;*.sys)|*.rxe;*.rtm;*.sys|NXT Source co' +
      'de (*.nbc)|*.nbc|TXT Files (*.txt)|*.txt|All Files (*.*)|*.*'
    Title = 'Open existing file'
    Left = 312
    Top = 112
  end
  object aclMain: TActionList
    OnUpdate = aclMainUpdate
    Left = 280
    Top = 48
    object actFileSaveAs: TFileSaveAs
      Category = 'File'
      Caption = 'Save &As...'
      Dialog.DefaultExt = 'nbc'
      Dialog.Filter = 
        'NXT Source code (*.nbc)|*.nbc|TXT Files (*.txt)|*.txt|All Files ' +
        '(*.*)|*.*'
      Hint = 'Save As|Saves the active file with a new name'
      BeforeExecute = actFileSaveAsBeforeExecute
      OnAccept = actFileSaveAsAccept
    end
    object actFileExit: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
    end
    object actFileDump: TAction
      Category = 'File'
      Caption = '&Decompile...'
      Hint = 'Decompile|Decompile the information in an RXE file to text'
      ShortCut = 16452
      OnExecute = actFileDumpExecute
    end
    object actSearchFind: TSearchFind
      Category = 'Search'
      Caption = '&Find...'
      Hint = 'Find|Finds the specified text'
      ShortCut = 16454
    end
    object actSearchFindNext: TSearchFindNext
      Category = 'Search'
      Caption = 'Find &Next'
      Hint = 'Find Next|Repeats the last find'
      SearchFind = actSearchFind
      ShortCut = 114
    end
    object actEditCut: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
    end
    object actEditCopy: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
    end
    object actEditPaste: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
    end
    object actEditSelectAll: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
    end
    object actSearchReplace: TSearchReplace
      Category = 'Search'
      Caption = '&Replace...'
      Hint = 'Replace|Replaces specific text with different text'
      ShortCut = 16466
    end
    object actFileOpen: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Dialog.DefaultExt = 'nbc'
      Dialog.Filter = 
        'NXT Source code (*.nbc)|*.nbc|TXT Files (*.txt)|*.txt|All Files ' +
        '(*.*)|*.*'
      Hint = 'Open|Opens an existing source file'
      ShortCut = 16463
      OnAccept = actFileOpenAccept
    end
    object actCompile: TAction
      Category = 'File'
      Caption = '&Compile...'
      Hint = 'Compile|Compiles the current program to a .rxe file'
      ShortCut = 16504
      OnExecute = actCompileExecute
    end
    object actPrint: TPrintDlg
      Category = 'Dialog'
      Caption = '&Print...'
      Dialog.Options = [poSelection, poDisablePrintToFile]
      Hint = 'Print|Prints the current program'
      ShortCut = 16464
      OnAccept = actPrintAccept
    end
    object actFileSave: TAction
      Category = 'File'
      Caption = '&Save'
      Hint = 'Save|Saves the current file'
      ShortCut = 16467
      OnExecute = actFileSaveExecute
    end
    object actFileNew: TAction
      Category = 'File'
      Caption = '&New'
      Hint = 'New|Starts a new file'
      ShortCut = 16462
      OnExecute = actFileNewExecute
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'rxe'
    Title = 'Save file as'
    Left = 348
    Top = 112
  end
  object mnuMain: TMainMenu
    OwnerDraw = True
    Left = 280
    Top = 80
    object mniFile: TMenuItem
      Caption = '&File'
      object mniNew: TMenuItem
        Action = actFileNew
      end
      object mniOpen: TMenuItem
        Action = actFileOpen
      end
      object mniFileSave: TMenuItem
        Action = actFileSave
      end
      object mniSaveAs: TMenuItem
        Action = actFileSaveAs
      end
      object mniSep3: TMenuItem
        Caption = '-'
      end
      object mniCompile: TMenuItem
        Action = actCompile
      end
      object mniDump: TMenuItem
        Action = actFileDump
      end
      object mniSep2: TMenuItem
        Caption = '-'
      end
      object mniPrint: TMenuItem
        Action = actPrint
      end
      object mniSep1: TMenuItem
        Caption = '-'
      end
      object mniExit: TMenuItem
        Action = actFileExit
      end
    end
    object mniEdit: TMenuItem
      Caption = '&Edit'
      object mniCut: TMenuItem
        Action = actEditCut
        ShortCut = 16472
      end
      object mniCopy: TMenuItem
        Action = actEditCopy
        ShortCut = 16451
      end
      object mniPaste: TMenuItem
        Action = actEditPaste
        ShortCut = 16470
      end
      object mniSelectAll: TMenuItem
        Action = actEditSelectAll
        ShortCut = 16449
      end
    end
    object mniSearch: TMenuItem
      Caption = '&Search'
      object mniFind: TMenuItem
        Action = actSearchFind
      end
      object mniFindNext: TMenuItem
        Action = actSearchFindNext
      end
      object mniReplace: TMenuItem
        Action = actSearchReplace
      end
    end
    object mniHelp: TMenuItem
      Caption = '&Help'
      object mniAbout: TMenuItem
        Caption = '&About...'
        OnClick = mniAboutClick
      end
    end
  end
  object popMain: TPopupMenu
    OwnerDraw = True
    Left = 312
    Top = 48
    object mniPopCompile: TMenuItem
      Action = actCompile
    end
    object mniPopDump: TMenuItem
      Action = actFileDump
    end
    object mniPopSep1: TMenuItem
      Caption = '-'
    end
    object mniPopCut: TMenuItem
      Action = actEditCut
    end
    object mniPopCopy: TMenuItem
      Action = actEditCopy
    end
    object mniPopPaste: TMenuItem
      Action = actEditPaste
    end
    object mniPopSelectAll: TMenuItem
      Action = actEditSelectAll
    end
  end
end
