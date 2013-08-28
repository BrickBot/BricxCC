object RemoteForm: TRemoteForm
  Left = 349
  Top = 221
  HelpContext = 17
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Remote'
  ClientHeight = 343
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grpMotorA: TGroupBox
    Left = 11
    Top = 108
    Width = 41
    Height = 97
    TabOrder = 1
    object btnMotorAFwd: TSpeedButton
      Tag = 1
      Left = 9
      Top = 14
      Width = 23
      Height = 14
      AllowAllUp = True
      GroupIndex = 4
      OnMouseDown = MotorMouseDown
      OnMouseUp = MotorMouseUp
    end
    object btnMotorARwd: TSpeedButton
      Tag = 9
      Left = 9
      Top = 74
      Width = 23
      Height = 14
      AllowAllUp = True
      GroupIndex = 4
      OnMouseDown = MotorMouseDown
      OnMouseUp = MotorMouseUp
    end
    object barASpeed: TTrackBar
      Left = 17
      Top = 29
      Width = 17
      Height = 44
      Max = 7
      Orientation = trVertical
      Position = 4
      TabOrder = 0
      ThumbLength = 12
    end
  end
  object grpMotorB: TGroupBox
    Left = 71
    Top = 108
    Width = 41
    Height = 97
    TabOrder = 3
    object btnMotorBFwd: TSpeedButton
      Tag = 2
      Left = 9
      Top = 14
      Width = 23
      Height = 14
      AllowAllUp = True
      GroupIndex = 5
      OnMouseDown = MotorMouseDown
      OnMouseUp = MotorMouseUp
    end
    object btnMotorBRwd: TSpeedButton
      Tag = 10
      Left = 9
      Top = 74
      Width = 23
      Height = 14
      AllowAllUp = True
      GroupIndex = 5
      OnMouseDown = MotorMouseDown
      OnMouseUp = MotorMouseUp
    end
    object barBSpeed: TTrackBar
      Left = 17
      Top = 29
      Width = 17
      Height = 44
      Max = 7
      Orientation = trVertical
      Position = 4
      TabOrder = 0
      ThumbLength = 12
    end
  end
  object grpMotorC: TGroupBox
    Left = 131
    Top = 108
    Width = 41
    Height = 97
    TabOrder = 5
    object btnMotorCFwd: TSpeedButton
      Tag = 4
      Left = 9
      Top = 14
      Width = 23
      Height = 14
      AllowAllUp = True
      GroupIndex = 6
      OnMouseDown = MotorMouseDown
      OnMouseUp = MotorMouseUp
    end
    object btnMotorCRwd: TSpeedButton
      Tag = 12
      Left = 9
      Top = 74
      Width = 23
      Height = 14
      AllowAllUp = True
      GroupIndex = 6
      OnMouseDown = MotorMouseDown
      OnMouseUp = MotorMouseUp
    end
    object barCSpeed: TTrackBar
      Left = 17
      Top = 29
      Width = 17
      Height = 44
      Max = 7
      Orientation = trVertical
      Position = 4
      TabOrder = 0
      ThumbLength = 12
    end
  end
  object lblMotorA: TStaticText
    Left = 7
    Top = 146
    Width = 17
    Height = 27
    HelpContext = 17024
    Caption = 'A'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 0
    Transparent = False
  end
  object lblMotorB: TStaticText
    Left = 67
    Top = 146
    Width = 17
    Height = 27
    HelpContext = 17025
    Caption = 'B'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 2
    Transparent = False
  end
  object lblMotorC: TStaticText
    Left = 127
    Top = 146
    Width = 18
    Height = 27
    HelpContext = 17026
    Caption = 'C'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 4
    Transparent = False
  end
  object grpMotorD: TGroupBox
    Left = 191
    Top = 108
    Width = 41
    Height = 97
    TabOrder = 6
    object btnMotorDFwd: TSpeedButton
      Tag = 8
      Left = 9
      Top = 14
      Width = 23
      Height = 14
      AllowAllUp = True
      GroupIndex = 7
      OnMouseDown = MotorMouseDown
      OnMouseUp = MotorMouseUp
    end
    object btnMotorDRwd: TSpeedButton
      Tag = 16
      Left = 9
      Top = 74
      Width = 23
      Height = 14
      AllowAllUp = True
      GroupIndex = 7
      OnMouseDown = MotorMouseDown
      OnMouseUp = MotorMouseUp
    end
    object barDSpeed: TTrackBar
      Left = 17
      Top = 29
      Width = 17
      Height = 44
      Max = 7
      Orientation = trVertical
      Position = 4
      TabOrder = 0
      ThumbLength = 12
    end
  end
  object lblMotorD: TStaticText
    Left = 187
    Top = 146
    Width = 18
    Height = 27
    HelpContext = 17026
    Caption = 'D'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 7
    Transparent = False
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 184
    Height = 105
    BevelOuter = bvNone
    TabOrder = 8
    object lblMsg1: TLabel
      Left = 23
      Top = 65
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMsg2: TLabel
      Left = 83
      Top = 65
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMsg3: TLabel
      Left = 143
      Top = 65
      Width = 17
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object bclMessage: TBevel
      Left = 11
      Top = 86
      Width = 161
      Height = 9
      Shape = bsTopLine
    end
    object lblMessage: TLabel
      Left = 70
      Top = 44
      Width = 43
      Height = 13
      Caption = 'Message'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object imgIcon: TImage
      Left = 76
      Top = 5
      Width = 32
      Height = 32
      Picture.Data = {
        055449636F6E0000010001002020100000000000E80200001600000028000000
        2000000040000000010004000000000080020000000000000000000000000000
        0000000000000000000080000080000000808000800000008000800080800000
        C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
        FFFFFF0000000000000000000000000000000000000000000BBBBBBBBBBBBBBB
        00000000000000000BBBBBBBBBBBBBBB00000000000000000B000BB000BB000B
        00000000000000000B000BB000BB000B00000000000000000B000BB000BB000B
        00000000000000000BBBBBBBBBBBBBBB00000000000000000B99BBBBBBBBBAAB
        00000000000000040BBBB8888888BBBB04000000000000040BBB800808008BBB
        040000000000044C0BBBB8888888BBBB0C4400000004444C0B00BBBBBBBBB88B
        0C4444000044444C0BBBBBBBBBBBBBBB0C4444400444444C0B888BB888BB888B
        0C444444044444CC0B888BB888BB888B0CC4444404444CCC0B888BB888BB888B
        0CCC44440444CC000BBBBBBBBBBBBBBB000CC4440444C0000BBBB0000000BBBB
        0000C4440444C00000000077777000000000C4440444C0000000077777770000
        0000C4440444C00000000799999700000000C4440444C0000000077777770000
        0000C4440444C00000007777777770000000C444000000000000000000000000
        0000000000000000077999977799997700000000000000000779999777999977
        000000000000000007799F977799F97700000000000000000000000000000000
        0000000000000000000777777777770000000000000000000007777777777700
        0000000000000000000077777777700000000000000000000000000000000000
        00000000FF00007FFF00007FFF00007FFF00007FFF00007FFF00007FFF00007F
        FF00007FFE00003FFE00003FF800000FE0000003C00000018000000080000000
        8000000083000060870000708700007087F007F087F007F087F007F087E003F0
        878000F0CF0000798700007087000070938000E493C001E493C001E49FE003FC
        9FF007FC}
    end
    object btnMsg1: TButton
      Tag = 1
      Left = 20
      Top = 80
      Width = 23
      Height = 14
      HelpContext = 17035
      TabOrder = 0
      OnClick = ButtonClicked
    end
    object btnMsg2: TButton
      Tag = 2
      Left = 80
      Top = 80
      Width = 23
      Height = 14
      HelpContext = 17036
      TabOrder = 1
      OnClick = ButtonClicked
    end
    object btnMsg3: TButton
      Tag = 3
      Left = 140
      Top = 80
      Width = 23
      Height = 14
      HelpContext = 17037
      TabOrder = 2
      OnClick = ButtonClicked
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 208
    Width = 184
    Height = 133
    BevelOuter = bvNone
    TabOrder = 9
    object Shape1: TShape
      Left = 15
      Top = 78
      Width = 32
      Height = 17
      Brush.Color = clRed
      Pen.Style = psClear
      Shape = stRoundRect
    end
    object lblProgram: TLabel
      Left = 72
      Top = 15
      Width = 39
      Height = 13
      Caption = 'Program'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblP1: TLabel
      Left = 25
      Top = 4
      Width = 13
      Height = 13
      Alignment = taCenter
      Caption = 'P1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblP2: TLabel
      Left = 145
      Top = 4
      Width = 13
      Height = 13
      Alignment = taCenter
      Caption = 'P2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblP3: TLabel
      Left = 25
      Top = 35
      Width = 13
      Height = 13
      Alignment = taCenter
      Caption = 'P3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblP4: TLabel
      Left = 85
      Top = 35
      Width = 13
      Height = 13
      Alignment = taCenter
      Caption = 'P4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblP5: TLabel
      Left = 145
      Top = 35
      Width = 13
      Height = 13
      Alignment = taCenter
      Caption = 'P5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblStop: TLabel
      Left = 51
      Top = 80
      Width = 22
      Height = 13
      Caption = 'Stop'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblBeep: TLabel
      Left = 119
      Top = 80
      Width = 14
      Height = 13
      Caption = '<|))'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnProg1: TButton
      Tag = 4
      Left = 17
      Top = 17
      Width = 28
      Height = 14
      HelpContext = 17029
      TabOrder = 0
      OnClick = ButtonClicked
      OnMouseDown = ProgramMouseDown
    end
    object btnProg5: TButton
      Tag = 8
      Left = 137
      Top = 48
      Width = 28
      Height = 14
      HelpContext = 17030
      TabOrder = 1
      OnClick = ButtonClicked
      OnMouseDown = ProgramMouseDown
    end
    object btnProg4: TButton
      Tag = 7
      Left = 77
      Top = 48
      Width = 28
      Height = 14
      HelpContext = 17031
      TabOrder = 2
      OnClick = ButtonClicked
      OnMouseDown = ProgramMouseDown
    end
    object btnProg3: TButton
      Tag = 6
      Left = 17
      Top = 48
      Width = 28
      Height = 14
      HelpContext = 17032
      TabOrder = 3
      OnClick = ButtonClicked
      OnMouseDown = ProgramMouseDown
    end
    object btnProg2: TButton
      Tag = 5
      Left = 137
      Top = 17
      Width = 28
      Height = 14
      HelpContext = 17033
      TabOrder = 4
      OnClick = ButtonClicked
      OnMouseDown = ProgramMouseDown
    end
    object btnBeep: TButton
      Tag = 10
      Left = 137
      Top = 79
      Width = 28
      Height = 14
      HelpContext = 17034
      TabOrder = 5
      OnClick = ButtonClicked
      OnMouseDown = ProgramMouseDown
    end
    object btnHelp: TButton
      Left = 66
      Top = 104
      Width = 52
      Height = 25
      HelpContext = 17038
      Caption = '&Help'
      TabOrder = 6
      OnClick = btnHelpClick
    end
    object btnStop: TButton
      Tag = 9
      Left = 17
      Top = 79
      Width = 28
      Height = 14
      HelpContext = 17028
      TabOrder = 7
      OnClick = ButtonClicked
    end
  end
  object tmrMain: TTimer
    Enabled = False
    Interval = 125
    OnTimer = tmrMainTimer
    Left = 136
    Top = 16
  end
end
