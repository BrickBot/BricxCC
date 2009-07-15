object frmMidiBatch: TfrmMidiBatch
  Left = 192
  Top = 160
  BorderStyle = bsDialog
  Caption = 'Batch Convert MIDI to NXT Melody'
  ClientHeight = 480
  ClientWidth = 336
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
  object lblInputDirs: TLabel
    Left = 16
    Top = 48
    Width = 80
    Height = 13
    Caption = 'Input Directories:'
  end
  object lblOutputDir: TLabel
    Left = 16
    Top = 8
    Width = 80
    Height = 13
    Caption = 'Output Directory:'
  end
  object lstDirs: TListBox
    Left = 16
    Top = 88
    Width = 241
    Height = 98
    ItemHeight = 13
    TabOrder = 2
    OnClick = lstDirsClick
  end
  object btnExecute: TButton
    Left = 264
    Top = 198
    Width = 60
    Height = 25
    Caption = '&Execute'
    TabOrder = 9
    OnClick = btnExecuteClick
  end
  object edtDir: TEdit
    Left = 16
    Top = 64
    Width = 241
    Height = 21
    TabOrder = 1
    OnChange = edtDirChange
  end
  object mmoLog: TMemo
    Left = 16
    Top = 328
    Width = 305
    Height = 138
    ScrollBars = ssBoth
    TabOrder = 10
    WordWrap = False
  end
  object edtOutputDir: TEdit
    Left = 16
    Top = 24
    Width = 241
    Height = 21
    TabOrder = 0
    OnChange = edtOutputDirChange
  end
  object btnAdd: TButton
    Left = 264
    Top = 62
    Width = 60
    Height = 25
    Caption = '&Add'
    TabOrder = 3
    OnClick = mniAddClick
  end
  object btnDelete: TButton
    Left = 264
    Top = 96
    Width = 60
    Height = 25
    Caption = '&Delete'
    TabOrder = 4
    OnClick = mniDeleteClick
  end
  object btnClear: TButton
    Left = 264
    Top = 136
    Width = 60
    Height = 25
    Caption = '&Clear'
    TabOrder = 5
    OnClick = mniClearClick
  end
  object grpTracks: TGroupBox
    Left = 16
    Top = 192
    Width = 84
    Height = 61
    Caption = 'Tracks'
    TabOrder = 6
    object radAllTracks: TRadioButton
      Left = 8
      Top = 16
      Width = 70
      Height = 17
      Caption = 'All'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radFirstTrack: TRadioButton
      Left = 8
      Top = 36
      Width = 70
      Height = 17
      Caption = '1st track'
      TabOrder = 1
    end
  end
  object grpTempo: TGroupBox
    Left = 16
    Top = 256
    Width = 84
    Height = 61
    Caption = 'Tempo'
    TabOrder = 7
    object edtTempo: TBricxccSpinEdit
      Left = 8
      Top = 23
      Width = 60
      Height = 22
      HelpContext = 3518
      MaxLength = 3
      MaxValue = 999
      MinValue = 0
      TabOrder = 0
      Value = 150
    end
  end
  object grpParameters: TGroupBox
    Left = 104
    Top = 192
    Width = 153
    Height = 125
    Caption = 'Parameters'
    TabOrder = 8
    object lblGap: TLabel
      Left = 8
      Top = 22
      Width = 23
      Height = 13
      Caption = '&Gap:'
      FocusControl = edtGap
    end
    object lblTranspose: TLabel
      Left = 8
      Top = 44
      Width = 53
      Height = 13
      Caption = 'T&ranspose:'
      FocusControl = barTranspose
    end
    object lblPBS: TLabel
      Left = 8
      Top = 99
      Width = 50
      Height = 13
      Caption = '&Sensitivity:'
      FocusControl = edtPBS
    end
    object barTranspose: TTrackBar
      Left = 72
      Top = 44
      Width = 56
      Height = 25
      Hint = '0'
      HelpContext = 3519
      Max = 2
      Min = -2
      ParentShowHint = False
      PageSize = 1
      ShowHint = True
      TabOrder = 1
      ThumbLength = 12
    end
    object chkUsePB: TCheckBox
      Left = 8
      Top = 71
      Width = 117
      Height = 17
      HelpContext = 3520
      Caption = 'Track pitch &bend'
      TabOrder = 2
      OnClick = chkUsePBClick
    end
    object edtGap: TBricxccSpinEdit
      Left = 78
      Top = 17
      Width = 52
      Height = 22
      HelpContext = 3517
      MaxLength = 2
      MaxValue = 99
      MinValue = 0
      TabOrder = 0
      Value = 2
    end
    object edtPBS: TBricxccSpinEdit
      Left = 78
      Top = 94
      Width = 52
      Height = 22
      HelpContext = 3521
      Enabled = False
      MaxLength = 2
      MaxValue = 99
      MinValue = 0
      TabOrder = 3
      Value = 2
    end
  end
end
