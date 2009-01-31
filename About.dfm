object AboutBox: TAboutBox
  Left = 236
  Top = 193
  BorderStyle = bsDialog
  Caption = 'About BricxCC'
  ClientHeight = 223
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 9
    Top = 8
    Width = 345
    Height = 185
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    object ProgramIcon: TImage
      Left = 8
      Top = 8
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
      Stretch = True
      OnClick = ProgramIconClick
      IsControl = True
    end
    object ProductName: TLabel
      Left = 88
      Top = 8
      Width = 177
      Height = 13
      AutoSize = False
      Caption = 'Bricx Command Center'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      IsControl = True
    end
    object Version: TLabel
      Left = 88
      Top = 25
      Width = 185
      Height = 13
      AutoSize = False
      Caption = 'product version'
      IsControl = True
    end
    object lblOrigAuth: TLabel
      Left = 8
      Top = 66
      Width = 77
      Height = 13
      AutoSize = False
      Caption = 'Original Author:'
      IsControl = True
    end
    object Comments: TLabel
      Left = 88
      Top = 144
      Width = 249
      Height = 34
      AutoSize = False
      Caption = 'NQC written and copyright by Dave Baum'
      ShowAccelChar = False
      WordWrap = True
      IsControl = True
    end
    object lblAuthor: TLabel
      Left = 88
      Top = 66
      Width = 164
      Height = 13
      Caption = 'Mark Overmars (markov@cs.uu.nl)'
      ShowAccelChar = False
      IsControl = True
    end
    object lblBuild: TLabel
      Left = 88
      Top = 41
      Width = 37
      Height = 13
      Caption = 'file date'
    end
    object lblMaint: TLabel
      Left = 8
      Top = 84
      Width = 52
      Height = 13
      Caption = 'Maintainer:'
    end
    object lblMaintainer: TLabel
      Left = 88
      Top = 84
      Width = 175
      Height = 13
      Caption = 'John Hansen (bricxcc@comcast.net)'
      ShowAccelChar = False
    end
    object lblCopyright: TLabel
      Left = 88
      Top = 104
      Width = 249
      Height = 25
      AutoSize = False
      Caption = 'lblCopyright'
      ShowAccelChar = False
      WordWrap = True
    end
  end
  object OKButton: TButton
    Left = 144
    Top = 196
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
