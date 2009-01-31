object frmForthConsole: TfrmForthConsole
  Left = 405
  Top = 249
  Width = 390
  Height = 410
  HelpContext = 3200
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'pbForth Console'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splConsole: TSplitter
    Left = 0
    Top = 308
    Width = 382
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object TheTerminal: TSynTerm
    Left = 0
    Top = 28
    Width = 382
    Height = 280
    Cursor = crIBeam
    HelpContext = 3202
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    ReadOnly = True
    SwFlow = sfXONXOFF
    InterCharacterDelay = 10
    InterLineDelay = 225
    StripComments = False
    SkipBlankLines = False
    OnDataSendResponse = TheTerminalDataSendResponse
  end
  object edtConsoleOutput: TBricxccSynEdit
    Left = 0
    Top = 311
    Width = 382
    Height = 65
    Cursor = crIBeam
    HelpContext = 3215
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    TabStop = False
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Terminal'
    Gutter.Font.Style = []
    Gutter.Visible = False
    Keystrokes = <
      item
        Command = ecUp
        ShortCut = 38
      end
      item
        Command = ecSelUp
        ShortCut = 8230
      end
      item
        Command = ecScrollUp
        ShortCut = 16422
      end
      item
        Command = ecDown
        ShortCut = 40
      end
      item
        Command = ecSelDown
        ShortCut = 8232
      end
      item
        Command = ecScrollDown
        ShortCut = 16424
      end
      item
        Command = ecLeft
        ShortCut = 37
      end
      item
        Command = ecSelLeft
        ShortCut = 8229
      end
      item
        Command = ecWordLeft
        ShortCut = 16421
      end
      item
        Command = ecSelWordLeft
        ShortCut = 24613
      end
      item
        Command = ecRight
        ShortCut = 39
      end
      item
        Command = ecSelRight
        ShortCut = 8231
      end
      item
        Command = ecWordRight
        ShortCut = 16423
      end
      item
        Command = ecSelWordRight
        ShortCut = 24615
      end
      item
        Command = ecPageDown
        ShortCut = 34
      end
      item
        Command = ecSelPageDown
        ShortCut = 8226
      end
      item
        Command = ecPageBottom
        ShortCut = 16418
      end
      item
        Command = ecSelPageBottom
        ShortCut = 24610
      end
      item
        Command = ecPageUp
        ShortCut = 33
      end
      item
        Command = ecSelPageUp
        ShortCut = 8225
      end
      item
        Command = ecPageTop
        ShortCut = 16417
      end
      item
        Command = ecSelPageTop
        ShortCut = 24609
      end
      item
        Command = ecLineStart
        ShortCut = 36
      end
      item
        Command = ecSelLineStart
        ShortCut = 8228
      end
      item
        Command = ecEditorTop
        ShortCut = 16420
      end
      item
        Command = ecSelEditorTop
        ShortCut = 24612
      end
      item
        Command = ecLineEnd
        ShortCut = 35
      end
      item
        Command = ecSelLineEnd
        ShortCut = 8227
      end
      item
        Command = ecEditorBottom
        ShortCut = 16419
      end
      item
        Command = ecSelEditorBottom
        ShortCut = 24611
      end
      item
        Command = ecToggleMode
        ShortCut = 45
      end
      item
        Command = ecCopy
        ShortCut = 16429
      end
      item
        Command = ecCut
        ShortCut = 8238
      end
      item
        Command = ecPaste
        ShortCut = 8237
      end
      item
        Command = ecDeleteChar
        ShortCut = 46
      end
      item
        Command = ecDeleteLastChar
        ShortCut = 8
      end
      item
        Command = ecDeleteLastChar
        ShortCut = 8200
      end
      item
        Command = ecDeleteLastWord
        ShortCut = 16392
      end
      item
        Command = ecUndo
        ShortCut = 32776
      end
      item
        Command = ecRedo
        ShortCut = 40968
      end
      item
        Command = ecLineBreak
        ShortCut = 13
      end
      item
        Command = ecLineBreak
        ShortCut = 8205
      end
      item
        Command = ecTab
        ShortCut = 9
      end
      item
        Command = ecShiftTab
        ShortCut = 8201
      end
      item
        Command = ecContextHelp
        ShortCut = 112
      end
      item
        Command = ecSelectAll
        ShortCut = 16449
      end
      item
        Command = ecCopy
        ShortCut = 16451
      end
      item
        Command = ecPaste
        ShortCut = 16470
      end
      item
        Command = ecCut
        ShortCut = 16472
      end
      item
        Command = ecBlockIndent
        ShortCut = 24649
      end
      item
        Command = ecBlockUnindent
        ShortCut = 24661
      end
      item
        Command = ecLineBreak
        ShortCut = 16461
      end
      item
        Command = ecInsertLine
        ShortCut = 16462
      end
      item
        Command = ecDeleteWord
        ShortCut = 16468
      end
      item
        Command = ecDeleteLine
        ShortCut = 16473
      end
      item
        Command = ecDeleteEOL
        ShortCut = 24665
      end
      item
        Command = ecUndo
        ShortCut = 16474
      end
      item
        Command = ecRedo
        ShortCut = 24666
      end
      item
        Command = ecGotoMarker0
        ShortCut = 16432
      end
      item
        Command = ecGotoMarker1
        ShortCut = 16433
      end
      item
        Command = ecGotoMarker2
        ShortCut = 16434
      end
      item
        Command = ecGotoMarker3
        ShortCut = 16435
      end
      item
        Command = ecGotoMarker4
        ShortCut = 16436
      end
      item
        Command = ecGotoMarker5
        ShortCut = 16437
      end
      item
        Command = ecGotoMarker6
        ShortCut = 16438
      end
      item
        Command = ecGotoMarker7
        ShortCut = 16439
      end
      item
        Command = ecGotoMarker8
        ShortCut = 16440
      end
      item
        Command = ecGotoMarker9
        ShortCut = 16441
      end
      item
        Command = ecSetMarker0
        ShortCut = 24624
      end
      item
        Command = ecSetMarker1
        ShortCut = 24625
      end
      item
        Command = ecSetMarker2
        ShortCut = 24626
      end
      item
        Command = ecSetMarker3
        ShortCut = 24627
      end
      item
        Command = ecSetMarker4
        ShortCut = 24628
      end
      item
        Command = ecSetMarker5
        ShortCut = 24629
      end
      item
        Command = ecSetMarker6
        ShortCut = 24630
      end
      item
        Command = ecSetMarker7
        ShortCut = 24631
      end
      item
        Command = ecSetMarker8
        ShortCut = 24632
      end
      item
        Command = ecSetMarker9
        ShortCut = 24633
      end
      item
        Command = ecNormalSelect
        ShortCut = 24654
      end
      item
        Command = ecColumnSelect
        ShortCut = 24643
      end
      item
        Command = ecLineSelect
        ShortCut = 24652
      end
      item
        Command = ecMatchBracket
        ShortCut = 24642
      end
      item
        Command = ecAutoCompletion
        ShortCut = 16458
      end>
    Options = [eoShowScrollHint]
    ReadOnly = True
    StructureLineColor = clNone
  end
  object ocbMain: TOfficeControlBar
    Left = 0
    Top = 0
    Width = 382
    Height = 26
    Align = alTop
    AutoSize = True
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ParentColor = False
    TabOrder = 2
    GradientFrom = clBtnFace
    GradientTo = clBtnFace
    BorderColor = clBlack
    object ogpMain: TOfficeGradientPanel
      Left = 11
      Top = 2
      Width = 226
      Height = 22
      GradientFrom = clBtnFace
      GradientTo = clBtnFace
      BorderColor = clBlack
      Horizontal = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object OfficeSpeedButton1: TOfficeSpeedButton
        Left = 77
        Top = 0
        Width = 23
        Height = 22
        Action = actPaste
        ResourceName = 'IMG_PASTE'
        Align = alLeft
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
      end
      object OfficeSpeedButton2: TOfficeSpeedButton
        Left = 0
        Top = 0
        Width = 23
        Height = 22
        Action = actConnect
        ResourceName = 'IMG_LED'
        Align = alLeft
        AllowAllUp = True
        GroupIndex = 1
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
      end
      object bvlFile: TBevel
        Left = 23
        Top = 0
        Width = 8
        Height = 22
        Align = alLeft
        Shape = bsSpacer
      end
      object OfficeSpeedButton3: TOfficeSpeedButton
        Left = 54
        Top = 0
        Width = 23
        Height = 22
        Action = actCopy
        ResourceName = 'IMG_COPY'
        Align = alLeft
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
      end
      object OfficeSpeedButton4: TOfficeSpeedButton
        Left = 31
        Top = 0
        Width = 23
        Height = 22
        Action = actCut
        ResourceName = 'IMG_CUT'
        Align = alLeft
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
      end
      object Bevel1: TBevel
        Left = 131
        Top = 0
        Width = 8
        Height = 22
        Align = alLeft
        Shape = bsSpacer
      end
      object OfficeSpeedButton5: TOfficeSpeedButton
        Left = 108
        Top = 0
        Width = 23
        Height = 22
        Action = actDownloadScript
        ResourceName = 'IMG_DOWNLOAD'
        Align = alLeft
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
      end
      object Bevel2: TBevel
        Left = 100
        Top = 0
        Width = 8
        Height = 22
        Align = alLeft
        Shape = bsSpacer
      end
      object OfficeSpeedButton6: TOfficeSpeedButton
        Left = 139
        Top = 0
        Width = 23
        Height = 22
        Action = actClearConsole
        ResourceName = 'IMG_CLEARMEM'
        Align = alLeft
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
      end
      object Bevel3: TBevel
        Left = 162
        Top = 0
        Width = 8
        Height = 22
        Align = alLeft
        Shape = bsSpacer
      end
      object OfficeSpeedButton7: TOfficeSpeedButton
        Left = 170
        Top = 0
        Width = 23
        Height = 22
        Action = actClose
        ResourceName = 'IMG_EXIT'
        Align = alLeft
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
      end
      object OfficeSpeedButton8: TOfficeSpeedButton
        Left = 201
        Top = 0
        Width = 23
        Height = 22
        Action = actHelp
        ResourceName = 'IMG_HELP'
        Align = alLeft
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
      end
      object Bevel4: TBevel
        Left = 193
        Top = 0
        Width = 8
        Height = 22
        Align = alLeft
        Shape = bsSpacer
      end
    end
  end
  object pnlSep: TPanel
    Left = 0
    Top = 26
    Width = 382
    Height = 2
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
  end
  object aclMain: TActionList
    OnUpdate = aclMainUpdate
    Left = 256
    Top = 104
    object actConnect: TAction
      Category = 'Console'
      Caption = 'Connect'
      HelpContext = 3216
      Hint = 'Connect|Connect to pbForth'
      OnExecute = actConnectExecute
    end
    object actClose: TAction
      Category = 'Console'
      Caption = 'Close'
      HelpContext = 3217
      Hint = 'Close|Close the console'
      OnExecute = actCloseExecute
    end
    object actCopy: TAction
      Category = 'Console'
      Caption = 'Copy'
      HelpContext = 3218
      Hint = 'Copy|Copy from console'
      ShortCut = 16451
      OnExecute = actCutCopyPasteExecute
    end
    object actCut: TAction
      Category = 'Console'
      Caption = 'Cut'
      HelpContext = 3219
      Hint = 'Cut|Cut from console'
      ShortCut = 16472
      OnExecute = actCutCopyPasteExecute
    end
    object actPaste: TAction
      Category = 'Console'
      Caption = 'Paste'
      HelpContext = 3220
      Hint = 'Paste|Paste to console'
      ShortCut = 16470
      OnExecute = actCutCopyPasteExecute
    end
    object actDownloadScript: TAction
      Category = 'Console'
      Caption = 'Download script'
      HelpContext = 3221
      Hint = 'Download|Download script to brick'
      OnExecute = actDownloadScriptExecute
    end
    object actClearConsole: TAction
      Category = 'Console'
      Caption = 'Clear'
      HelpContext = 3222
      Hint = 'Clear|Clear the console'
      OnExecute = actClearConsoleExecute
    end
    object actHelp: TAction
      Category = 'Console'
      Caption = 'Help'
      Hint = 'Help|Display help'
      OnExecute = actHelpExecute
    end
  end
end
