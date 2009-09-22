object frmForthConsole: TfrmForthConsole
  Left = 399
  Top = 243
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
  object pnlSep: TPanel
    Left = 0
    Top = 0
    Width = 382
    Height = 2
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
  object edtConsoleOutput2: TMemo
    Left = 0
    Top = 311
    Width = 382
    Height = 65
    Cursor = crIBeam
    HelpContext = 3215
    TabStop = False
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = []
    HideSelection = False
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
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
