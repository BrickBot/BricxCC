object JoystickForm: TJoystickForm
  Left = 465
  Top = 42
  HelpContext = 16
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Joystick'
  ClientHeight = 456
  ClientWidth = 121
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grpLeftMotor: TGroupBox
    Left = 8
    Top = 220
    Width = 105
    Height = 65
    HelpContext = 47005
    Caption = 'Left Motor'
    TabOrder = 0
    object LMotorA: TRadioButton
      Left = 8
      Top = 16
      Width = 25
      Height = 17
      Caption = 'A'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = LMotorClick
    end
    object LMotorB: TRadioButton
      Tag = 1
      Left = 40
      Top = 16
      Width = 25
      Height = 17
      Caption = 'B'
      TabOrder = 1
      OnClick = LMotorClick
    end
    object LMotorC: TRadioButton
      Tag = 2
      Left = 72
      Top = 16
      Width = 25
      Height = 17
      Caption = 'C'
      TabOrder = 2
      OnClick = LMotorClick
    end
    object LReversed: TCheckBox
      Left = 8
      Top = 40
      Width = 89
      Height = 17
      Caption = 'Reversed'
      TabOrder = 3
      OnClick = LReversedClick
    end
  end
  object grpRightMotor: TGroupBox
    Left = 8
    Top = 292
    Width = 105
    Height = 65
    HelpContext = 47006
    Caption = 'Right Motor'
    TabOrder = 1
    object RMotorA: TRadioButton
      Left = 8
      Top = 16
      Width = 25
      Height = 17
      Caption = 'A'
      TabOrder = 0
      OnClick = RMotorClick
    end
    object RMotorB: TRadioButton
      Tag = 1
      Left = 40
      Top = 16
      Width = 25
      Height = 17
      Caption = 'B'
      TabOrder = 1
      OnClick = RMotorClick
    end
    object RmotorC: TRadioButton
      Tag = 2
      Left = 72
      Top = 16
      Width = 25
      Height = 17
      Caption = 'C'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = RMotorClick
    end
    object RReversed: TCheckBox
      Left = 8
      Top = 40
      Width = 89
      Height = 17
      Caption = 'Reversed'
      TabOrder = 3
      OnClick = RReversedClick
    end
  end
  object grpSpeed: TGroupBox
    Left = 9
    Top = 361
    Width = 104
    Height = 60
    HelpContext = 47007
    Caption = 'Speed'
    TabOrder = 2
    object SpeedBar: TTrackBar
      Left = 8
      Top = 16
      Width = 89
      Height = 33
      Max = 7
      Position = 4
      TabOrder = 0
      OnChange = SpeedBarChange
    end
  end
  object grpDriveMode: TGroupBox
    Left = 8
    Top = 148
    Width = 105
    Height = 65
    HelpContext = 47004
    Caption = 'Drive Mode'
    TabOrder = 3
    object LeftRightBtn: TRadioButton
      Left = 8
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Left-Right'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = LeftRightBtnClick
    end
    object DriveSteerBtn: TRadioButton
      Left = 8
      Top = 40
      Width = 73
      Height = 17
      Caption = 'Drive-Steer'
      TabOrder = 1
      OnClick = DriveSteerBtnClick
    end
  end
  object grpMovement: TGroupBox
    Left = 8
    Top = 4
    Width = 105
    Height = 137
    HelpContext = 47001
    Caption = 'Movement'
    TabOrder = 4
    object DirBtn7: TSpeedButton
      Tag = 7
      Left = 16
      Top = 24
      Width = 25
      Height = 25
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333FFF3333333333333707333333333333F777F3333333333370
        9033333333F33F7737F33333373337090733333337F3F7737733333330037090
        73333333377F7737733333333090090733333333373773773333333309999073
        333333337F333773333333330999903333333333733337F33333333099999903
        33333337F3333F7FF33333309999900733333337333FF7773333330999900333
        3333337F3FF7733333333309900333333333337FF77333333333309003333333
        333337F773333333333330033333333333333773333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = DirBtnClick
      OnMouseDown = DirBtnMouseDown
      OnMouseUp = DirBtnMouseUp
    end
    object DirBtn8: TSpeedButton
      Tag = 8
      Left = 40
      Top = 24
      Width = 25
      Height = 25
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        3333333333777F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
        3333333777737777F333333099999990333333373F3333373333333309999903
        333333337F33337F33333333099999033333333373F333733333333330999033
        3333333337F337F3333333333099903333333333373F37333333333333090333
        33333333337F7F33333333333309033333333333337373333333333333303333
        333333333337F333333333333330333333333333333733333333}
      NumGlyphs = 2
      OnClick = DirBtnClick
      OnMouseDown = DirBtnMouseDown
      OnMouseUp = DirBtnMouseUp
    end
    object DirBtn9: TSpeedButton
      Tag = 9
      Left = 64
      Top = 24
      Width = 25
      Height = 25
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333333333333333333333333333333FF333333333333370733333333
        33333777F33333333333309073333333333337F77F3333F33333370907333733
        3333377F77F337F3333333709073003333333377F77F77F33333333709009033
        333333377F77373F33333333709999033333333377F3337F3333333330999903
        3333333337333373F333333309999990333333337FF33337F333333700999990
        33333337773FF3373F333333330099990333333333773FF37F33333333330099
        033333333333773F73F3333333333300903333333333337737F3333333333333
        0033333333333333773333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = DirBtnClick
      OnMouseDown = DirBtnMouseDown
      OnMouseUp = DirBtnMouseUp
    end
    object DirBtn4: TSpeedButton
      Tag = 4
      Left = 16
      Top = 48
      Width = 25
      Height = 25
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333FF3333333333333003333333333333F77F33333333333009033
        333333333F7737F333333333009990333333333F773337FFFFFF330099999000
        00003F773333377777770099999999999990773FF33333FFFFF7330099999000
        000033773FF33777777733330099903333333333773FF7F33333333333009033
        33333333337737F3333333333333003333333333333377333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = DirBtnClick
      OnMouseDown = DirBtnMouseDown
      OnMouseUp = DirBtnMouseUp
    end
    object DirBtn5: TSpeedButton
      Tag = 5
      Left = 40
      Top = 48
      Width = 25
      Height = 25
      GroupIndex = 1
      Down = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333FFFFFFFFFFF3333300000000003333383888888888F33333099999999
        0333338F333333338F333330999999990333338F333333338F33333099999999
        0333338F333333338F333330999999990333338F333333338F33333099999999
        0333338F333333338F333330999999990333338F333333338F33333099999999
        0333338F333333338F333330999999990333338F333333338F33333000000000
        0333338FFFFFFFFF3F3333333333333333333388888888888333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = DirBtnClick
      OnMouseDown = DirBtnMouseDown
      OnMouseUp = DirBtnMouseUp
    end
    object DirBtn6: TSpeedButton
      Tag = 6
      Left = 64
      Top = 48
      Width = 25
      Height = 25
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333FF3333333333333003333
        3333333333773FF3333333333309003333333333337F773FF333333333099900
        33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
        99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
        33333333337F3F77333333333309003333333333337F77333333333333003333
        3333333333773333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = DirBtnClick
      OnMouseDown = DirBtnMouseDown
      OnMouseUp = DirBtnMouseUp
    end
    object DirBtn1: TSpeedButton
      Tag = 1
      Left = 16
      Top = 72
      Width = 25
      Height = 25
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333333333333333333333333333333FF333333333333300333333333
        33333773FF33333333333090033333333333373773FF33333333330990033333
        3333337F3773FF33333333099990033333333373F33773FFF333333099999007
        33333337F33337773333333099999903333333373F3333733333333309999033
        333333337F3337F333333333099990733333333373F3F77F3333333330900907
        3333333337F77F77F33333333003709073333333377377F77F33333337333709
        073333333733377F77F33333333333709033333333333377F7F3333333333337
        0733333333333337773333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = DirBtnClick
      OnMouseDown = DirBtnMouseDown
      OnMouseUp = DirBtnMouseUp
    end
    object DirBtn2: TSpeedButton
      Tag = 2
      Left = 40
      Top = 72
      Width = 25
      Height = 25
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337F33333333333333033333333333333373F333333333333090333
        33333333337F7F33333333333309033333333333337373F33333333330999033
        3333333337F337F33333333330999033333333333733373F3333333309999903
        333333337F33337F33333333099999033333333373333373F333333099999990
        33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333300033333333333337773333333}
      NumGlyphs = 2
      OnClick = DirBtnClick
      OnMouseDown = DirBtnMouseDown
      OnMouseUp = DirBtnMouseUp
    end
    object DirBtn3: TSpeedButton
      Tag = 3
      Left = 64
      Top = 72
      Width = 25
      Height = 25
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333333333333FFF3333333333333
        00333333333333FF77F3333333333300903333333333FF773733333333330099
        0333333333FF77337F3333333300999903333333FF7733337333333700999990
        3333333777333337F3333333099999903333333373F333373333333330999903
        33333333F7F3337F33333333709999033333333F773FF3733333333709009033
        333333F7737737F3333333709073003333333F77377377F33333370907333733
        33333773773337333333309073333333333337F7733333333333370733333333
        3333377733333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = DirBtnClick
      OnMouseDown = DirBtnMouseDown
      OnMouseUp = DirBtnMouseUp
    end
    object Task1Btn: TBitBtn
      Tag = 1
      Left = 24
      Top = 104
      Width = 25
      Height = 25
      HelpContext = 47002
      Caption = 'T1'
      TabOrder = 0
      OnClick = TaskBtnClick
    end
    object Task2Btn: TBitBtn
      Tag = 2
      Left = 56
      Top = 104
      Width = 25
      Height = 25
      HelpContext = 47003
      Caption = 'T2'
      TabOrder = 1
      OnClick = TaskBtnClick
    end
  end
  object btnHelp: TButton
    Left = 34
    Top = 427
    Width = 52
    Height = 25
    HelpContext = 47008
    Caption = '&Help'
    TabOrder = 5
    OnClick = btnHelpClick
  end
  object JoyTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = JoyTimerTimer
    Left = 8
    Top = 168
  end
end
