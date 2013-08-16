object DiagForm: TDiagForm
  Left = 258
  Top = 106
  HelpContext = 13
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Diagnostics'
  ClientHeight = 458
  ClientWidth = 241
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    241
    458)
  PixelsPerInch = 96
  TextHeight = 13
  object grpInfo: TGroupBox
    Left = 8
    Top = 0
    Width = 225
    Height = 161
    Caption = ' Info '
    TabOrder = 0
    object lblAlive: TLabel
      Left = 26
      Top = 20
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'Alive'
    end
    object lblVersion: TLabel
      Left = 14
      Top = 44
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Version'
    end
    object lblBattery: TLabel
      Left = 16
      Top = 68
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Battery'
    end
    object lblPort: TLabel
      Left = 30
      Top = 92
      Width = 19
      Height = 13
      Alignment = taRightJustify
      Caption = 'Port'
    end
    object lblProgram: TLabel
      Left = 10
      Top = 116
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = 'Program'
    end
    object Alive: TPanel
      Left = 56
      Top = 16
      Width = 161
      Height = 17
      BevelOuter = bvLowered
      Caption = 'Brick is alive'
      TabOrder = 0
    end
    object Version: TPanel
      Left = 56
      Top = 40
      Width = 161
      Height = 17
      BevelOuter = bvLowered
      Caption = '0'
      TabOrder = 1
    end
    object RefreshBtn: TButton
      Left = 144
      Top = 132
      Width = 72
      Height = 24
      HelpContext = 13008
      Caption = '&Refresh'
      TabOrder = 2
      OnClick = RefreshBtnClick
    end
    object Port: TPanel
      Left = 56
      Top = 88
      Width = 161
      Height = 17
      BevelOuter = bvLowered
      Caption = '0'
      TabOrder = 3
    end
    object ProgramNumb: TPanel
      Left = 56
      Top = 112
      Width = 161
      Height = 17
      BevelOuter = bvLowered
      Caption = '0'
      TabOrder = 4
    end
    object BatStatus: TPanel
      Left = 56
      Top = 64
      Width = 161
      Height = 17
      BevelOuter = bvLowered
      Caption = '0'
      TabOrder = 5
    end
  end
  object IRGroup: TGroupBox
    Left = 8
    Top = 224
    Width = 225
    Height = 41
    Caption = ' Infrared Power '
    TabOrder = 2
    object IRShort: TRadioButton
      Left = 48
      Top = 16
      Width = 57
      Height = 17
      HelpContext = 13009
      Caption = '&Short'
      TabOrder = 0
      OnClick = IRShortClick
    end
    object IRLong: TRadioButton
      Left = 128
      Top = 16
      Width = 49
      Height = 17
      HelpContext = 13010
      Caption = '&Long'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = IRLongClick
    end
  end
  object WatchGroup: TGroupBox
    Left = 8
    Top = 272
    Width = 225
    Height = 41
    Caption = ' Watch '
    TabOrder = 3
    object lblTime: TLabel
      Left = 26
      Top = 18
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'Time'
    end
    object CurrentBtn: TButton
      Left = 144
      Top = 12
      Width = 72
      Height = 24
      HelpContext = 13012
      Caption = 'Set &Current'
      TabOrder = 0
      OnClick = CurrentBtnClick
    end
    object Watch: TPanel
      Left = 56
      Top = 16
      Width = 65
      Height = 17
      BevelOuter = bvLowered
      Caption = '0'
      TabOrder = 1
    end
  end
  object PowerGroup: TGroupBox
    Left = 8
    Top = 168
    Width = 225
    Height = 49
    Caption = ' Power Down '
    TabOrder = 1
    object lblMinutes: TLabel
      Left = 12
      Top = 20
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = '&Minutes'
      FocusControl = PowerDown
    end
    object PowerDown: TBricxccSpinEdit
      Left = 64
      Top = 16
      Width = 57
      Height = 22
      HelpContext = 13011
      MaxLength = 3
      MaxValue = 255
      MinValue = 0
      TabOrder = 0
      Value = 15
      OnChange = PowerDownChange
    end
  end
  object btnHelp: TButton
    Left = 98
    Top = 430
    Width = 52
    Height = 25
    HelpContext = 13001
    Anchors = [akLeft, akBottom]
    Caption = '&Help'
    TabOrder = 5
    OnClick = btnHelpClick
  end
  object grpNXTDiag: TGroupBox
    Left = 8
    Top = 224
    Width = 225
    Height = 145
    Caption = 'Brick Info'
    TabOrder = 6
    object Label1: TLabel
      Left = 21
      Top = 20
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'Name'
    end
    object Label2: TLabel
      Left = 10
      Top = 44
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = 'BT Addr'
    end
    object Label3: TLabel
      Left = 3
      Top = 68
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'BT Signal'
    end
    object Label4: TLabel
      Left = 3
      Top = 92
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Free mem'
    end
    object NXTName: TPanel
      Left = 56
      Top = 16
      Width = 161
      Height = 17
      BevelOuter = bvLowered
      TabOrder = 0
      OnDblClick = NXTNameDblClick
    end
    object BTAddress: TPanel
      Left = 56
      Top = 40
      Width = 161
      Height = 17
      BevelOuter = bvLowered
      TabOrder = 1
      OnDblClick = BTAddressDblClick
    end
    object BTSignal: TPanel
      Left = 56
      Top = 64
      Width = 161
      Height = 17
      BevelOuter = bvLowered
      TabOrder = 2
    end
    object FreeMemory: TPanel
      Left = 56
      Top = 88
      Width = 161
      Height = 17
      BevelOuter = bvLowered
      TabOrder = 3
    end
    object btnRefreshNXT: TButton
      Left = 144
      Top = 113
      Width = 72
      Height = 24
      HelpContext = 13013
      Caption = '&Refresh'
      TabOrder = 4
      OnClick = btnRefreshNXTClick
    end
  end
  object DisplayGroup: TGroupBox
    Left = 8
    Top = 320
    Width = 225
    Height = 106
    Caption = ' Display '
    TabOrder = 4
    object lblPrecision: TLabel
      Left = 115
      Top = 20
      Width = 46
      Height = 13
      Caption = '&Precision:'
      FocusControl = cboPrecision
    end
    object lblSource: TLabel
      Left = 8
      Top = 47
      Width = 37
      Height = 13
      Caption = 'S&ource:'
    end
    object lblValue: TLabel
      Left = 8
      Top = 77
      Width = 30
      Height = 13
      Caption = '&Value:'
    end
    object DisplayType: TComboBox
      Left = 8
      Top = 16
      Width = 97
      Height = 21
      HelpContext = 13002
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = DisplayTypeChange
    end
    object btnUpdateDisplay: TButton
      Left = 144
      Top = 71
      Width = 72
      Height = 24
      HelpContext = 13003
      Caption = '&Update'
      TabOrder = 5
      OnClick = btnUpdateDisplayClick
    end
    object cboPrecision: TComboBox
      Left = 168
      Top = 16
      Width = 49
      Height = 21
      HelpContext = 13004
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4')
    end
    object cboSource: TComboBox
      Left = 56
      Top = 43
      Width = 161
      Height = 21
      HelpContext = 13005
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = cboSourceChange
    end
    object udValue: TUpDown
      Left = 105
      Top = 72
      Width = 16
      Height = 21
      HelpContext = 13006
      Associate = edtValue
      TabOrder = 4
      Thousands = False
    end
    object edtValue: TEdit
      Left = 56
      Top = 72
      Width = 49
      Height = 21
      HelpContext = 13007
      MaxLength = 5
      TabOrder = 3
      Text = '0'
      OnExit = edtValueExit
      OnKeyPress = edtValueKeyPress
    end
  end
end
