object frmSimpleTerm: TfrmSimpleTerm
  Left = 324
  Top = 177
  Width = 478
  Height = 391
  Caption = 'Simple Terminal'
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
  object mmoTerm: TMemo
    Left = 0
    Top = 0
    Width = 462
    Height = 353
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WantTabs = True
    OnKeyPress = mmoTermKeyPress
  end
  object tmrPoll: TTimer
    Interval = 50
    OnTimer = tmrPollTimer
    Left = 40
    Top = 248
  end
  object alSimpleTerm: TActionList
    OnUpdate = alSimpleTermUpdate
    Left = 136
    Top = 88
    object actEditCut1: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object actEditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object actEditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object actEditDelete1: TEditDelete
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 5
      ShortCut = 46
    end
    object actEditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
    object actPolling: TAction
      Category = 'Preferences'
      Caption = '&Polling'
      OnExecute = actPollingExecute
    end
    object actLabelLines: TAction
      Category = 'Preferences'
      Caption = '&Label Lines'
      OnExecute = actLabelLinesExecute
    end
    object actEchoSends: TAction
      Category = 'Preferences'
      Caption = '&Echo Sends'
      OnExecute = actEchoSendsExecute
    end
  end
end
