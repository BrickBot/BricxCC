object frmNewWatch: TfrmNewWatch
  Left = 247
  Top = 136
  HelpContext = 14
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Configurable Watch'
  ClientHeight = 179
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnPollRegular: TSpeedButton
    Left = 104
    Top = 148
    Width = 89
    Height = 25
    HelpContext = 3610
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Poll &Regular'
    OnClick = btnPollRegularClick
  end
  object btnGraph: TSpeedButton
    Left = 408
    Top = 148
    Width = 89
    Height = 25
    HelpContext = 3614
    AllowAllUp = True
    GroupIndex = 4
    Caption = '&Graph'
    OnClick = btnGraphClick
  end
  object lblSource: TLabel
    Left = 8
    Top = 9
    Width = 37
    Height = 13
    Caption = 'S&ource:'
  end
  object lblValue: TLabel
    Left = 8
    Top = 37
    Width = 30
    Height = 13
    Caption = '&Value:'
  end
  object btnPollNow: TButton
    Left = 8
    Top = 148
    Width = 89
    Height = 25
    HelpContext = 3609
    Caption = '&Poll Now'
    TabOrder = 8
    OnClick = btnPollNowClick
  end
  object btnCheckAll: TButton
    Left = 304
    Top = 31
    Width = 62
    Height = 24
    HelpContext = 3606
    Caption = '&All'
    TabOrder = 5
    OnClick = btnCheckAllClick
  end
  object btnCheckNone: TButton
    Left = 372
    Top = 31
    Width = 62
    Height = 24
    HelpContext = 3607
    Caption = '&None'
    TabOrder = 6
    OnClick = btnCheckNoneClick
  end
  object TimeBox: TComboBox
    Left = 200
    Top = 150
    Width = 89
    Height = 21
    HelpContext = 3611
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 9
    OnChange = TimeBoxChange
    Items.Strings = (
      '100 ms'
      '200 ms'
      '500 ms'
      '1 second'
      '2 seconds'
      '5 seconds'
      '10 seconds')
  end
  object chkIfActive: TCheckBox
    Left = 296
    Top = 143
    Width = 91
    Height = 17
    HelpContext = 3612
    Caption = 'Only if ac&tive'
    TabOrder = 10
  end
  object chkSyncSeries: TCheckBox
    Left = 296
    Top = 159
    Width = 91
    Height = 17
    HelpContext = 3613
    Caption = 'Sync s&eries'
    TabOrder = 11
  end
  object cboSource: TComboBox
    Left = 56
    Top = 5
    Width = 161
    Height = 21
    HelpContext = 3601
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cboSourceChange
  end
  object edtValue: TEdit
    Left = 56
    Top = 32
    Width = 49
    Height = 21
    HelpContext = 3602
    MaxLength = 5
    TabOrder = 1
    Text = '0'
    OnExit = edtValueExit
    OnKeyPress = edtValueKeyPress
  end
  object udValue: TUpDown
    Left = 105
    Top = 32
    Width = 15
    Height = 21
    HelpContext = 3603
    Associate = edtValue
    TabOrder = 2
    Thousands = False
  end
  object btnAddWatch: TButton
    Left = 127
    Top = 31
    Width = 62
    Height = 24
    HelpContext = 3604
    Caption = '&Watch'
    Enabled = False
    TabOrder = 3
    OnClick = btnAddWatchClick
  end
  object pagMain: TPageControl
    Left = 8
    Top = 64
    Width = 497
    Height = 73
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
  end
  object btnRemoveWatch: TButton
    Left = 195
    Top = 31
    Width = 62
    Height = 24
    HelpContext = 3605
    Caption = 'Re&move'
    Enabled = False
    TabOrder = 4
    OnClick = btnRemoveWatchClick
  end
  object btnClear: TButton
    Left = 440
    Top = 31
    Width = 62
    Height = 24
    HelpContext = 3608
    Caption = '&Clear'
    TabOrder = 12
    OnClick = btnClearClick
  end
  object btnHelp: TButton
    Left = 440
    Top = 3
    Width = 62
    Height = 24
    HelpContext = 3621
    Caption = '&Help'
    TabOrder = 13
    OnClick = btnHelpClick
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 424
    Top = 8
  end
end
