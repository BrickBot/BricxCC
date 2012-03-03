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
    Enabled = False
    Interval = 50
    OnTimer = tmrPollTimer
    Left = 40
    Top = 248
  end
  object alSimpleTerm: TActionList
    OnUpdate = alSimpleTermUpdate
    Left = 136
    Top = 88
    object actEditCut: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object actEditCopy: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object actEditPaste: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object actEditDelete: TEditDelete
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 5
      ShortCut = 46
    end
    object actEditSelectAll: TEditSelectAll
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
    object actNXTUseMailbox: TAction
      Category = 'Preferences'
      Caption = 'Use NXT Mailbox'
      OnExecute = actNXTUseMailboxExecute
    end
    object actMB1: TAction
      Category = 'MBNum'
      Caption = 'Mailbox1'
      GroupIndex = 2
      ShortCut = 16433
      OnExecute = actMBExecute
    end
    object actMB2: TAction
      Tag = 1
      Category = 'MBNum'
      Caption = 'Mailbox2'
      GroupIndex = 2
      ShortCut = 16434
      OnExecute = actMBExecute
    end
    object actMB3: TAction
      Tag = 2
      Category = 'MBNum'
      Caption = 'Mailbox3'
      GroupIndex = 2
      ShortCut = 16435
      OnExecute = actMBExecute
    end
    object actMB4: TAction
      Tag = 3
      Category = 'MBNum'
      Caption = 'Mailbox4'
      GroupIndex = 2
      ShortCut = 16436
      OnExecute = actMBExecute
    end
    object actMB5: TAction
      Tag = 4
      Category = 'MBNum'
      Caption = 'Mailbox5'
      GroupIndex = 2
      ShortCut = 16437
      OnExecute = actMBExecute
    end
    object actMB6: TAction
      Tag = 5
      Category = 'MBNum'
      Caption = 'Mailbox6'
      GroupIndex = 2
      ShortCut = 16438
      OnExecute = actMBExecute
    end
    object actMB7: TAction
      Tag = 6
      Category = 'MBNum'
      Caption = 'Mailbox7'
      GroupIndex = 2
      ShortCut = 16439
      OnExecute = actMBExecute
    end
    object actMB8: TAction
      Tag = 7
      Category = 'MBNum'
      Caption = 'Mailbox8'
      GroupIndex = 2
      ShortCut = 16440
      OnExecute = actMBExecute
    end
    object actMB9: TAction
      Tag = 8
      Category = 'MBNum'
      Caption = 'Mailbox9'
      GroupIndex = 2
      ShortCut = 16441
      OnExecute = actMBExecute
    end
    object actMB10: TAction
      Tag = 9
      Category = 'MBNum'
      Caption = 'Mailbox10'
      Checked = True
      GroupIndex = 2
      ShortCut = 16432
      OnExecute = actMBExecute
    end
  end
end
