object frmNXTWatchList: TfrmNXTWatchList
  Left = 261
  Top = 320
  Width = 496
  Height = 197
  BorderStyle = bsSizeToolWin
  Caption = 'Watch List'
  Color = clBtnFace
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = pmuMain
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tabMain: TTabSet
    Left = 0
    Top = 138
    Width = 480
    Height = 21
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Tabs.Strings = (
      'Watches')
    TabIndex = 0
    OnChange = tabMainChange
  end
  object lstWatches: TListView
    Left = 0
    Top = 0
    Width = 480
    Height = 138
    Align = alClient
    BevelInner = bvNone
    BevelKind = bkTile
    BorderStyle = bsNone
    Checkboxes = True
    Columns = <
      item
        Caption = 'Watch Name'
        MinWidth = 100
        Width = 100
      end
      item
        Caption = 'Value'
        MinWidth = 100
        Width = 375
      end>
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnChange = lstWatchesChange
    OnChanging = lstWatchesChanging
    OnDblClick = lstWatchesDblClick
    OnEditing = lstWatchesEditing
    OnKeyDown = lstWatchesKeyDown
  end
  object pmuMain: TPopupMenu
    Left = 232
    Top = 8
    object mniEditWatch: TMenuItem
      Action = actEditWatch
    end
    object mniAddWatch: TMenuItem
      Action = actAddWatch
    end
    object Refresh1: TMenuItem
      Action = actRefresh
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mniEnableWatch: TMenuItem
      Action = actEnableWatch
    end
    object mniDisableWatch: TMenuItem
      Action = actDisableWatch
    end
    object mniDeleteWatch: TMenuItem
      Action = actDeleteWatch
    end
    object mniCopyWatchValue: TMenuItem
      Action = actCopyWatchValue
    end
    object mniCopyWatchName: TMenuItem
      Action = actCopyWatchName
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mniEnableAllWatches: TMenuItem
      Action = actEnableAllWatches
    end
    object mniDisableAllWatches: TMenuItem
      Action = actDisableAllWatches
    end
    object mniDeleteAllWatches: TMenuItem
      Action = actDeleteAllWatches
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mniAddGroup: TMenuItem
      Action = actAddGroup
    end
    object mniDeleteGroup: TMenuItem
      Action = actDeleteGroup
    end
    object mniMoveWatchToGroup: TMenuItem
      Action = actMoveWatchToGroup
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mniInspect: TMenuItem
      Action = actInspect
    end
    object mniBreakWhenChanged: TMenuItem
      Action = actBreakWhenChanged
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object mniShowColumnHeaders: TMenuItem
      Action = actShowColumnHeaders
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object mniStayonTop: TMenuItem
      Action = actStayOnTop
    end
    object mniDockable: TMenuItem
      Action = actDockable
    end
  end
  object alMain: TActionList
    OnUpdate = alMainUpdate
    Left = 160
    Top = 32
    object actEditWatch: TAction
      Caption = '&Edit Watch...'
      ShortCut = 16453
      OnExecute = actEditWatchExecute
    end
    object actAddWatch: TAction
      Caption = '&Add Watch...'
      ShortCut = 16449
      OnExecute = actAddWatchExecute
    end
    object actEnableWatch: TAction
      Caption = 'E&nable Watch'
      Enabled = False
      OnExecute = actEnableWatchExecute
    end
    object actDisableWatch: TAction
      Caption = 'D&isable Watch'
      Enabled = False
      OnExecute = actDisableWatchExecute
    end
    object actDeleteWatch: TAction
      Caption = '&Delete Watch'
      Enabled = False
      ShortCut = 16452
      OnExecute = actDeleteWatchExecute
    end
    object actCopyWatchValue: TAction
      Caption = 'Copy Watch &Value'
      Enabled = False
      OnExecute = actCopyWatchValueExecute
    end
    object actCopyWatchName: TAction
      Caption = 'Cop&y Watch Name'
      Enabled = False
      OnExecute = actCopyWatchNameExecute
    end
    object actEnableAllWatches: TAction
      Caption = 'Enab&le All Watches'
      Enabled = False
      OnExecute = actEnableAllWatchesExecute
    end
    object actDisableAllWatches: TAction
      Caption = 'Disa&ble All Watches'
      Enabled = False
      OnExecute = actDisableAllWatchesExecute
    end
    object actDeleteAllWatches: TAction
      Caption = 'Dele&te All Watches'
      Enabled = False
      OnExecute = actDeleteAllWatchesExecute
    end
    object actAddGroup: TAction
      Caption = 'Add Group...'
      OnExecute = actAddGroupExecute
    end
    object actDeleteGroup: TAction
      Caption = 'Delete Group'
      Enabled = False
      OnExecute = actDeleteGroupExecute
    end
    object actMoveWatchToGroup: TAction
      Caption = 'Move Watch To Group'
      Enabled = False
      OnExecute = actMoveWatchToGroupExecute
    end
    object actInspect: TAction
      Caption = 'Ins&pect'
      Enabled = False
      ShortCut = 16457
      OnExecute = actInspectExecute
    end
    object actBreakWhenChanged: TAction
      Caption = 'Break When &Changed'
      Enabled = False
      OnExecute = actBreakWhenChangedExecute
    end
    object actShowColumnHeaders: TAction
      Caption = 'Show Column &Headers'
      Checked = True
      OnExecute = actShowColumnHeadersExecute
    end
    object actStayOnTop: TAction
      Caption = '&Stay on Top'
      OnExecute = actStayOnTopExecute
    end
    object actDockable: TAction
      Caption = 'D&ockable'
      Checked = True
      OnExecute = actDockableExecute
    end
    object actRefresh: TAction
      Caption = '&Refresh'
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
  end
end
