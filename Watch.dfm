object WatchForm: TWatchForm
  Left = 303
  Top = 193
  HelpContext = 14
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Watching the brick'
  ClientHeight = 410
  ClientWidth = 549
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PopupMenu = menuPopup
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pagWatch: TPageControl
    Left = 0
    Top = 0
    Width = 444
    Height = 410
    ActivePage = shtCommon
    Align = alClient
    TabOrder = 0
    object shtCommon: TTabSheet
      Caption = 'Common'
      object grpVar: TGroupBox
        Left = 4
        Top = 2
        Width = 264
        Height = 298
        HelpContext = 14006
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object VVar0: TEdit
          Left = 64
          Top = 16
          Width = 58
          Height = 17
          HelpContext = 14007
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object CVar0: TCheckBox
          Left = 8
          Top = 16
          Width = 49
          Height = 17
          HelpContext = 14008
          Caption = 'Var  0'
          TabOrder = 0
        end
        object CVar1: TCheckBox
          Left = 8
          Top = 32
          Width = 49
          Height = 17
          HelpContext = 14009
          Caption = 'Var  1'
          TabOrder = 2
        end
        object VVar1: TEdit
          Left = 64
          Top = 32
          Width = 58
          Height = 17
          HelpContext = 14010
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object CVar2: TCheckBox
          Left = 8
          Top = 48
          Width = 49
          Height = 17
          HelpContext = 14011
          Caption = 'Var  2'
          TabOrder = 4
        end
        object VVar2: TEdit
          Left = 64
          Top = 48
          Width = 58
          Height = 17
          HelpContext = 14012
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object VVar3: TEdit
          Left = 64
          Top = 64
          Width = 58
          Height = 17
          HelpContext = 14013
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object CVar3: TCheckBox
          Left = 8
          Top = 64
          Width = 49
          Height = 17
          HelpContext = 14014
          Caption = 'Var  3'
          TabOrder = 6
        end
        object CVar4: TCheckBox
          Left = 8
          Top = 80
          Width = 49
          Height = 17
          HelpContext = 14015
          Caption = 'Var  4'
          TabOrder = 8
        end
        object VVar4: TEdit
          Left = 64
          Top = 80
          Width = 58
          Height = 17
          HelpContext = 14016
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
        end
        object CVar5: TCheckBox
          Left = 8
          Top = 96
          Width = 49
          Height = 17
          HelpContext = 14017
          Caption = 'Var  5'
          TabOrder = 10
        end
        object VVar5: TEdit
          Left = 64
          Top = 96
          Width = 58
          Height = 17
          HelpContext = 14018
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
        end
        object VVar6: TEdit
          Left = 64
          Top = 112
          Width = 58
          Height = 17
          HelpContext = 14019
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
        end
        object CVar6: TCheckBox
          Left = 8
          Top = 112
          Width = 49
          Height = 17
          HelpContext = 14020
          Caption = 'Var  6'
          TabOrder = 12
        end
        object CVar7: TCheckBox
          Left = 8
          Top = 128
          Width = 49
          Height = 17
          HelpContext = 14021
          Caption = 'Var  7'
          TabOrder = 14
        end
        object VVar7: TEdit
          Left = 64
          Top = 128
          Width = 58
          Height = 17
          HelpContext = 14022
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 15
        end
        object CVar8: TCheckBox
          Left = 144
          Top = 16
          Width = 49
          Height = 17
          HelpContext = 14023
          Caption = 'Var  8'
          TabOrder = 16
        end
        object VVar8: TEdit
          Left = 200
          Top = 16
          Width = 58
          Height = 17
          HelpContext = 14024
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 17
        end
        object VVar9: TEdit
          Left = 200
          Top = 32
          Width = 58
          Height = 17
          HelpContext = 14025
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 19
        end
        object CVar9: TCheckBox
          Left = 144
          Top = 32
          Width = 49
          Height = 17
          HelpContext = 14026
          Caption = 'Var  9'
          TabOrder = 18
        end
        object CVar10: TCheckBox
          Left = 144
          Top = 48
          Width = 49
          Height = 17
          HelpContext = 14027
          Caption = 'Var 10'
          TabOrder = 20
        end
        object VVar10: TEdit
          Left = 200
          Top = 48
          Width = 58
          Height = 17
          HelpContext = 14028
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 21
        end
        object CVar11: TCheckBox
          Left = 144
          Top = 64
          Width = 49
          Height = 17
          HelpContext = 14029
          Caption = 'Var 11'
          TabOrder = 22
        end
        object VVar11: TEdit
          Left = 200
          Top = 64
          Width = 58
          Height = 17
          HelpContext = 14030
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 23
        end
        object VVar12: TEdit
          Left = 200
          Top = 80
          Width = 58
          Height = 17
          HelpContext = 14031
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 25
        end
        object CVar12: TCheckBox
          Left = 144
          Top = 80
          Width = 49
          Height = 17
          HelpContext = 14032
          Caption = 'Var 12'
          TabOrder = 24
        end
        object CVar13: TCheckBox
          Left = 144
          Top = 96
          Width = 49
          Height = 17
          HelpContext = 14033
          Caption = 'Var 13'
          TabOrder = 26
        end
        object VVar13: TEdit
          Left = 200
          Top = 96
          Width = 58
          Height = 17
          HelpContext = 14034
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 27
        end
        object CVar14: TCheckBox
          Left = 144
          Top = 112
          Width = 49
          Height = 17
          HelpContext = 14035
          Caption = 'Var 14'
          TabOrder = 28
        end
        object VVar14: TEdit
          Left = 200
          Top = 112
          Width = 58
          Height = 17
          HelpContext = 14036
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 29
        end
        object VVar15: TEdit
          Left = 200
          Top = 128
          Width = 58
          Height = 17
          HelpContext = 14037
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 31
        end
        object CVar15: TCheckBox
          Left = 144
          Top = 128
          Width = 49
          Height = 17
          HelpContext = 14038
          Caption = 'Var 15'
          TabOrder = 30
        end
        object VVar16: TEdit
          Left = 64
          Top = 160
          Width = 58
          Height = 17
          HelpContext = 14039
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 33
        end
        object CVar16: TCheckBox
          Left = 8
          Top = 160
          Width = 49
          Height = 17
          HelpContext = 14040
          Caption = 'Var 16'
          TabOrder = 32
        end
        object CVar17: TCheckBox
          Left = 8
          Top = 176
          Width = 49
          Height = 17
          HelpContext = 14041
          Caption = 'Var 17'
          TabOrder = 34
        end
        object VVar17: TEdit
          Left = 64
          Top = 176
          Width = 58
          Height = 17
          HelpContext = 14042
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 35
        end
        object CVar18: TCheckBox
          Left = 8
          Top = 192
          Width = 49
          Height = 17
          HelpContext = 14043
          Caption = 'Var 18'
          TabOrder = 36
        end
        object VVar18: TEdit
          Left = 64
          Top = 192
          Width = 58
          Height = 17
          HelpContext = 14044
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 37
        end
        object VVar19: TEdit
          Left = 64
          Top = 208
          Width = 58
          Height = 17
          HelpContext = 14045
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 39
        end
        object CVar19: TCheckBox
          Left = 8
          Top = 208
          Width = 49
          Height = 17
          HelpContext = 14046
          Caption = 'Var 19'
          TabOrder = 38
        end
        object CVar20: TCheckBox
          Left = 8
          Top = 224
          Width = 49
          Height = 17
          HelpContext = 14047
          Caption = 'Var 20'
          TabOrder = 40
        end
        object VVar20: TEdit
          Left = 64
          Top = 224
          Width = 58
          Height = 17
          HelpContext = 14048
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 41
        end
        object CVar21: TCheckBox
          Left = 8
          Top = 240
          Width = 49
          Height = 17
          HelpContext = 14049
          Caption = 'Var 21'
          TabOrder = 42
        end
        object VVar21: TEdit
          Left = 64
          Top = 240
          Width = 58
          Height = 17
          HelpContext = 14050
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 43
        end
        object VVar22: TEdit
          Left = 64
          Top = 256
          Width = 58
          Height = 17
          HelpContext = 14051
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 45
        end
        object CVar22: TCheckBox
          Left = 8
          Top = 256
          Width = 49
          Height = 17
          HelpContext = 14052
          Caption = 'Var 22'
          TabOrder = 44
        end
        object CVar23: TCheckBox
          Left = 8
          Top = 272
          Width = 49
          Height = 17
          HelpContext = 14053
          Caption = 'Var 23'
          TabOrder = 46
        end
        object VVar23: TEdit
          Left = 64
          Top = 272
          Width = 58
          Height = 17
          HelpContext = 14054
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 47
        end
        object VVar24: TEdit
          Left = 200
          Top = 160
          Width = 58
          Height = 17
          HelpContext = 14055
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 49
        end
        object CVar24: TCheckBox
          Left = 144
          Top = 160
          Width = 49
          Height = 17
          HelpContext = 14056
          Caption = 'Var 24'
          TabOrder = 48
        end
        object CVar25: TCheckBox
          Left = 144
          Top = 176
          Width = 49
          Height = 17
          HelpContext = 14057
          Caption = 'Var 25'
          TabOrder = 50
        end
        object VVar25: TEdit
          Left = 200
          Top = 176
          Width = 58
          Height = 17
          HelpContext = 14058
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 51
        end
        object CVar26: TCheckBox
          Left = 144
          Top = 192
          Width = 49
          Height = 17
          HelpContext = 14059
          Caption = 'Var 26'
          TabOrder = 52
        end
        object VVar26: TEdit
          Left = 200
          Top = 192
          Width = 58
          Height = 17
          HelpContext = 14060
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 53
        end
        object VVar27: TEdit
          Left = 200
          Top = 208
          Width = 58
          Height = 17
          HelpContext = 14061
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 55
        end
        object CVar27: TCheckBox
          Left = 144
          Top = 208
          Width = 49
          Height = 17
          HelpContext = 14062
          Caption = 'Var 27'
          TabOrder = 54
        end
        object CVar28: TCheckBox
          Left = 144
          Top = 224
          Width = 49
          Height = 17
          HelpContext = 14063
          Caption = 'Var 28'
          TabOrder = 56
        end
        object VVar28: TEdit
          Left = 200
          Top = 224
          Width = 58
          Height = 17
          HelpContext = 14064
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 57
        end
        object CVar29: TCheckBox
          Left = 144
          Top = 240
          Width = 49
          Height = 17
          HelpContext = 14065
          Caption = 'Var 29'
          TabOrder = 58
        end
        object VVar29: TEdit
          Left = 200
          Top = 240
          Width = 58
          Height = 17
          HelpContext = 14066
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 59
        end
        object VVar30: TEdit
          Left = 200
          Top = 256
          Width = 58
          Height = 17
          HelpContext = 14067
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 61
        end
        object CVar30: TCheckBox
          Left = 144
          Top = 256
          Width = 49
          Height = 17
          HelpContext = 14068
          Caption = 'Var 30'
          TabOrder = 60
        end
        object CVar31: TCheckBox
          Left = 144
          Top = 272
          Width = 49
          Height = 17
          HelpContext = 14069
          Caption = 'Var 31'
          TabOrder = 62
        end
        object VVar31: TEdit
          Left = 200
          Top = 272
          Width = 58
          Height = 17
          HelpContext = 14070
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 63
        end
      end
      object grpMotor: TGroupBox
        Left = 4
        Top = 300
        Width = 264
        Height = 74
        HelpContext = 14081
        TabOrder = 1
        object CheckMotorA: TCheckBox
          Left = 8
          Top = 16
          Width = 65
          Height = 17
          HelpContext = 14082
          Caption = 'Motor A'
          TabOrder = 0
        end
        object ValueMotorA: TEdit
          Left = 80
          Top = 16
          Width = 154
          Height = 17
          HelpContext = 14083
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object CheckMotorB: TCheckBox
          Left = 8
          Top = 32
          Width = 65
          Height = 17
          HelpContext = 14084
          Caption = 'Motor B'
          TabOrder = 2
        end
        object ValueMotorB: TEdit
          Left = 80
          Top = 32
          Width = 154
          Height = 17
          HelpContext = 14085
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object CheckMotorC: TCheckBox
          Left = 8
          Top = 48
          Width = 65
          Height = 17
          HelpContext = 14086
          Caption = 'Motor C'
          TabOrder = 4
        end
        object ValueMotorC: TEdit
          Left = 80
          Top = 48
          Width = 154
          Height = 17
          HelpContext = 14087
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object grpSensor: TGroupBox
        Left = 272
        Top = 2
        Width = 145
        Height = 90
        HelpContext = 14088
        TabOrder = 2
        object CheckSensor1: TCheckBox
          Left = 8
          Top = 16
          Width = 65
          Height = 17
          HelpContext = 14089
          Caption = 'Sensor 1'
          TabOrder = 0
        end
        object ValueSensor1: TEdit
          Left = 80
          Top = 16
          Width = 58
          Height = 17
          HelpContext = 14090
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object CheckSensor2: TCheckBox
          Left = 8
          Top = 32
          Width = 65
          Height = 17
          HelpContext = 14091
          Caption = 'Sensor 2'
          TabOrder = 2
        end
        object ValueSensor2: TEdit
          Left = 80
          Top = 32
          Width = 58
          Height = 17
          HelpContext = 14092
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object CheckSensor3: TCheckBox
          Left = 8
          Top = 48
          Width = 65
          Height = 17
          HelpContext = 14093
          Caption = 'Sensor 3'
          TabOrder = 4
        end
        object ValueSensor3: TEdit
          Left = 80
          Top = 48
          Width = 58
          Height = 17
          HelpContext = 14094
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object ValueSensor4: TEdit
          Left = 80
          Top = 64
          Width = 58
          Height = 17
          HelpContext = 14094
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object CheckSensor4: TCheckBox
          Left = 9
          Top = 64
          Width = 65
          Height = 17
          HelpContext = 14093
          Caption = 'Sensor 4'
          TabOrder = 6
        end
      end
      object grpTimer: TGroupBox
        Left = 272
        Top = 92
        Width = 145
        Height = 90
        HelpContext = 14071
        TabOrder = 3
        object CheckTimer0: TCheckBox
          Left = 8
          Top = 16
          Width = 65
          Height = 17
          HelpContext = 14072
          Caption = 'Timer 0'
          TabOrder = 0
        end
        object ValueTimer0: TEdit
          Left = 80
          Top = 16
          Width = 58
          Height = 17
          HelpContext = 14073
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object CheckTimer1: TCheckBox
          Left = 8
          Top = 32
          Width = 65
          Height = 17
          HelpContext = 14074
          Caption = 'Timer 1'
          TabOrder = 2
        end
        object ValueTImer1: TEdit
          Left = 80
          Top = 32
          Width = 58
          Height = 17
          HelpContext = 14075
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object CheckTimer2: TCheckBox
          Left = 8
          Top = 48
          Width = 65
          Height = 17
          HelpContext = 14076
          Caption = 'Timer 2'
          TabOrder = 4
        end
        object ValueTimer2: TEdit
          Left = 80
          Top = 48
          Width = 58
          Height = 17
          HelpContext = 14077
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object ValueTimer3: TEdit
          Left = 80
          Top = 64
          Width = 58
          Height = 17
          HelpContext = 14078
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object CheckTimer3: TCheckBox
          Left = 8
          Top = 64
          Width = 65
          Height = 17
          HelpContext = 14079
          Caption = 'Timer 3'
          TabOrder = 6
        end
      end
      object grpCounter: TGroupBox
        Left = 272
        Top = 226
        Width = 145
        Height = 74
        HelpContext = 14110
        TabOrder = 4
        object CheckCounter0: TCheckBox
          Left = 8
          Top = 16
          Width = 65
          Height = 17
          HelpContext = 14111
          Caption = 'Counter 0'
          TabOrder = 0
        end
        object ValueCounter0: TEdit
          Left = 80
          Top = 16
          Width = 58
          Height = 17
          HelpContext = 14112
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object CheckCounter1: TCheckBox
          Left = 8
          Top = 32
          Width = 65
          Height = 17
          HelpContext = 14113
          Caption = 'Counter 1'
          TabOrder = 2
        end
        object ValueCounter1: TEdit
          Left = 80
          Top = 32
          Width = 58
          Height = 17
          HelpContext = 14114
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object CheckCounter2: TCheckBox
          Left = 8
          Top = 48
          Width = 65
          Height = 17
          HelpContext = 14115
          Caption = 'Counter 2'
          TabOrder = 4
        end
        object ValueCounter2: TEdit
          Left = 80
          Top = 48
          Width = 58
          Height = 17
          HelpContext = 14116
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object grpMessage: TGroupBox
        Left = 272
        Top = 182
        Width = 145
        Height = 44
        TabOrder = 5
        object CheckMessage: TCheckBox
          Left = 8
          Top = 16
          Width = 65
          Height = 17
          HelpContext = 14004
          Caption = 'Message'
          TabOrder = 0
        end
        object ValueMessage: TEdit
          Left = 80
          Top = 16
          Width = 58
          Height = 17
          HelpContext = 14005
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
      end
    end
    object shtCybermaster: TTabSheet
      Caption = 'Cybermaster'
      object grpTacho: TGroupBox
        Left = 4
        Top = 2
        Width = 229
        Height = 135
        HelpContext = 14099
        TabOrder = 0
        Visible = False
        object CheckTCounterL: TCheckBox
          Left = 8
          Top = 16
          Width = 127
          Height = 17
          HelpContext = 14100
          Caption = 'Tacho Counter Left'
          TabOrder = 0
        end
        object ValueTCounterL: TEdit
          Left = 142
          Top = 16
          Width = 80
          Height = 17
          HelpContext = 14101
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object CheckTSpeedR: TCheckBox
          Left = 8
          Top = 82
          Width = 127
          Height = 17
          HelpContext = 14102
          Caption = 'Tacho Speed Right'
          TabOrder = 6
        end
        object ValueTSpeedR: TEdit
          Left = 142
          Top = 82
          Width = 80
          Height = 17
          HelpContext = 14103
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object CheckMCurrent: TCheckBox
          Left = 8
          Top = 105
          Width = 127
          Height = 17
          HelpContext = 14104
          Caption = 'Motor Current'
          TabOrder = 8
        end
        object ValueMCurrent: TEdit
          Left = 142
          Top = 104
          Width = 80
          Height = 17
          HelpContext = 14105
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
        end
        object ValueTCounterR: TEdit
          Left = 142
          Top = 38
          Width = 80
          Height = 17
          HelpContext = 14106
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object CheckTCounterR: TCheckBox
          Left = 8
          Top = 38
          Width = 127
          Height = 17
          HelpContext = 14107
          Caption = 'Tacho Counter Right'
          TabOrder = 2
        end
        object ValueTSpeedL: TEdit
          Left = 142
          Top = 60
          Width = 80
          Height = 17
          HelpContext = 14108
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object CheckTSpeedL: TCheckBox
          Left = 8
          Top = 60
          Width = 127
          Height = 17
          HelpContext = 14109
          Caption = 'Tacho Speed Left'
          TabOrder = 4
        end
      end
    end
    object shtNXT: TTabSheet
      Caption = 'NXT'
      object grpNXTMotors: TGroupBox
        Left = 4
        Top = 2
        Width = 341
        Height = 215
        HelpContext = 14081
        TabOrder = 0
        object chkPortA: TCheckBox
          Left = 135
          Top = 10
          Width = 34
          Height = 17
          HelpContext = 14082
          Caption = 'A'
          TabOrder = 0
        end
        object edtPAPower: TEdit
          Left = 135
          Top = 28
          Width = 61
          Height = 17
          HelpContext = 14083
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object chkPortB: TCheckBox
          Left = 203
          Top = 10
          Width = 36
          Height = 17
          HelpContext = 14084
          Caption = 'B'
          TabOrder = 10
        end
        object edtPBPower: TEdit
          Left = 203
          Top = 28
          Width = 61
          Height = 17
          HelpContext = 14085
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
        end
        object chkPortC: TCheckBox
          Left = 271
          Top = 10
          Width = 34
          Height = 17
          HelpContext = 14086
          Caption = 'C'
          TabOrder = 20
        end
        object edtPCPower: TEdit
          Left = 271
          Top = 28
          Width = 61
          Height = 17
          HelpContext = 14087
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 21
        end
        object edtPAMode: TEdit
          Left = 135
          Top = 48
          Width = 61
          Height = 17
          HelpContext = 14083
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object edtPBMode: TEdit
          Left = 203
          Top = 48
          Width = 61
          Height = 17
          HelpContext = 14085
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 12
        end
        object edtPCMode: TEdit
          Left = 271
          Top = 48
          Width = 61
          Height = 17
          HelpContext = 14087
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 22
        end
        object edtPARegMode: TEdit
          Left = 135
          Top = 68
          Width = 61
          Height = 17
          HelpContext = 14083
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object edtPBRegMode: TEdit
          Left = 203
          Top = 68
          Width = 61
          Height = 17
          HelpContext = 14085
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
        end
        object edtPCRegMode: TEdit
          Left = 271
          Top = 68
          Width = 61
          Height = 17
          HelpContext = 14087
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 23
        end
        object edtPATurnRatio: TEdit
          Left = 135
          Top = 108
          Width = 61
          Height = 17
          HelpContext = 14083
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object edtPBTurnRatio: TEdit
          Left = 203
          Top = 108
          Width = 61
          Height = 17
          HelpContext = 14085
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 15
        end
        object edtPCTurnRatio: TEdit
          Left = 271
          Top = 108
          Width = 61
          Height = 17
          HelpContext = 14087
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 25
        end
        object edtPARunState: TEdit
          Left = 135
          Top = 88
          Width = 61
          Height = 17
          HelpContext = 14083
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object edtPBRunState: TEdit
          Left = 203
          Top = 88
          Width = 61
          Height = 17
          HelpContext = 14085
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 14
        end
        object edtPCRunState: TEdit
          Left = 271
          Top = 88
          Width = 61
          Height = 17
          HelpContext = 14087
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 24
        end
        object edtPATachoLimit: TEdit
          Left = 135
          Top = 128
          Width = 61
          Height = 17
          HelpContext = 14083
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object edtPBTachoLimit: TEdit
          Left = 203
          Top = 128
          Width = 61
          Height = 17
          HelpContext = 14085
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 16
        end
        object edtPCTachoLimit: TEdit
          Left = 271
          Top = 128
          Width = 61
          Height = 17
          HelpContext = 14087
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 26
        end
        object edtPATachoCount: TEdit
          Left = 135
          Top = 148
          Width = 61
          Height = 17
          HelpContext = 14083
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object edtPBTachoCount: TEdit
          Left = 203
          Top = 148
          Width = 61
          Height = 17
          HelpContext = 14085
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 17
        end
        object edtPCTachoCount: TEdit
          Left = 271
          Top = 148
          Width = 61
          Height = 17
          HelpContext = 14087
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 27
        end
        object edtPABlockTachoCount: TEdit
          Left = 135
          Top = 168
          Width = 61
          Height = 17
          HelpContext = 14083
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
        end
        object edtPBBlockTachoCount: TEdit
          Left = 203
          Top = 168
          Width = 61
          Height = 17
          HelpContext = 14085
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 18
        end
        object edtPCBlockTachoCount: TEdit
          Left = 271
          Top = 168
          Width = 61
          Height = 17
          HelpContext = 14087
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 28
        end
        object edtPARotationCount: TEdit
          Left = 135
          Top = 188
          Width = 61
          Height = 17
          HelpContext = 14083
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
        end
        object edtPBRotationCount: TEdit
          Left = 203
          Top = 188
          Width = 61
          Height = 17
          HelpContext = 14085
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 19
        end
        object edtPCRotationCount: TEdit
          Left = 271
          Top = 188
          Width = 61
          Height = 17
          HelpContext = 14087
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 29
        end
        object chkNXTPower: TCheckBox
          Left = 6
          Top = 30
          Width = 117
          Height = 13
          Caption = 'Power'
          TabOrder = 30
        end
        object chkNXTMode: TCheckBox
          Left = 6
          Top = 50
          Width = 117
          Height = 13
          Caption = 'Mode'
          TabOrder = 31
        end
        object chkNXTRegMode: TCheckBox
          Left = 6
          Top = 70
          Width = 117
          Height = 13
          Caption = 'Regulation Mode'
          TabOrder = 32
        end
        object chkNXTTurnRatio: TCheckBox
          Left = 6
          Top = 110
          Width = 117
          Height = 13
          Caption = 'Turn Ratio'
          TabOrder = 34
        end
        object chkNXTRunState: TCheckBox
          Left = 6
          Top = 90
          Width = 117
          Height = 13
          Caption = 'Run State'
          TabOrder = 33
        end
        object chkNXTTachoLimit: TCheckBox
          Left = 6
          Top = 130
          Width = 117
          Height = 13
          Caption = 'Tacho Limit'
          TabOrder = 35
        end
        object chkNXTTachoCount: TCheckBox
          Left = 6
          Top = 150
          Width = 117
          Height = 13
          Caption = 'Tacho Count'
          TabOrder = 36
        end
        object chkNXTBlockTachoCount: TCheckBox
          Left = 6
          Top = 170
          Width = 117
          Height = 13
          Caption = 'Block Tacho Count'
          TabOrder = 37
        end
        object chkNXTRotationCount: TCheckBox
          Left = 6
          Top = 190
          Width = 117
          Height = 13
          Caption = 'Rotation Count'
          TabOrder = 38
        end
      end
      object grpI2C: TGroupBox
        Left = 4
        Top = 229
        Width = 341
        Height = 140
        HelpContext = 14088
        TabOrder = 1
        object lblI2CPort: TLabel
          Left = 6
          Top = 12
          Width = 38
          Height = 13
          Caption = 'I2C Port'
        end
        object lblI2CResponse: TLabel
          Left = 222
          Top = 12
          Width = 48
          Height = 13
          Caption = 'Response'
        end
        object lblI2CUltra: TLabel
          Left = 80
          Top = 12
          Width = 15
          Height = 13
          Caption = 'US'
        end
        object lblI2CBuffer: TLabel
          Left = 104
          Top = 12
          Width = 28
          Height = 13
          Caption = 'Buffer'
        end
        object lblI2CLen: TLabel
          Left = 175
          Top = 12
          Width = 33
          Height = 13
          Caption = 'Length'
        end
        object chkI2C1: TCheckBox
          Left = 6
          Top = 29
          Width = 72
          Height = 17
          HelpContext = 14089
          Caption = 'Port 1'
          TabOrder = 0
        end
        object edtI2CVal1: TEdit
          Left = 222
          Top = 26
          Width = 110
          Height = 22
          HelpContext = 14090
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object chkI2C2: TCheckBox
          Left = 6
          Top = 54
          Width = 72
          Height = 17
          HelpContext = 14091
          Caption = 'Port 2'
          TabOrder = 5
        end
        object edtI2CVal2: TEdit
          Left = 222
          Top = 51
          Width = 110
          Height = 22
          HelpContext = 14092
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
        end
        object chkI2C3: TCheckBox
          Left = 6
          Top = 79
          Width = 72
          Height = 17
          HelpContext = 14093
          Caption = 'Port 3'
          TabOrder = 10
        end
        object edtI2CVal3: TEdit
          Left = 222
          Top = 76
          Width = 110
          Height = 22
          HelpContext = 14094
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 14
        end
        object edtI2CVal4: TEdit
          Left = 222
          Top = 101
          Width = 110
          Height = 22
          HelpContext = 14094
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 19
        end
        object chkI2C4: TCheckBox
          Left = 6
          Top = 104
          Width = 72
          Height = 17
          HelpContext = 14093
          Caption = 'Port 4'
          TabOrder = 15
        end
        object chkUltra1: TCheckBox
          Left = 82
          Top = 29
          Width = 17
          Height = 17
          HelpContext = 14089
          TabOrder = 1
          OnClick = chkUltra1Click
        end
        object chkUltra2: TCheckBox
          Left = 82
          Top = 54
          Width = 17
          Height = 17
          HelpContext = 14091
          TabOrder = 6
          OnClick = chkUltra2Click
        end
        object chkUltra3: TCheckBox
          Left = 82
          Top = 79
          Width = 17
          Height = 17
          HelpContext = 14093
          TabOrder = 11
          OnClick = chkUltra3Click
        end
        object chkUltra4: TCheckBox
          Left = 82
          Top = 104
          Width = 17
          Height = 17
          HelpContext = 14093
          TabOrder = 16
          OnClick = chkUltra4Click
        end
        object edtI2CBuf1: TEdit
          Left = 104
          Top = 26
          Width = 62
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object edtI2CBuf2: TEdit
          Left = 104
          Top = 51
          Width = 62
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object edtI2CBuf3: TEdit
          Left = 104
          Top = 76
          Width = 62
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object edtI2CBuf4: TEdit
          Left = 104
          Top = 101
          Width = 62
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
        end
        object edtI2CLen1: TBricxccSpinEdit
          Left = 175
          Top = 26
          Width = 42
          Height = 22
          MaxLength = 2
          MaxValue = 16
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object edtI2CLen2: TBricxccSpinEdit
          Left = 175
          Top = 51
          Width = 42
          Height = 22
          MaxLength = 2
          MaxValue = 16
          MinValue = 0
          TabOrder = 8
          Value = 0
        end
        object edtI2CLen4: TBricxccSpinEdit
          Left = 175
          Top = 101
          Width = 42
          Height = 22
          MaxLength = 2
          MaxValue = 16
          MinValue = 0
          TabOrder = 18
          Value = 0
        end
        object edtI2CLen3: TBricxccSpinEdit
          Left = 175
          Top = 76
          Width = 42
          Height = 22
          MaxLength = 2
          MaxValue = 16
          MinValue = 0
          TabOrder = 13
          Value = 0
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 444
    Top = 0
    Width = 105
    Height = 410
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object btnPollRegular: TSpeedButton
      Left = 8
      Top = 135
      Width = 89
      Height = 25
      HelpContext = 14001
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Poll &Regular'
      OnClick = btnPollRegularClick
    end
    object btnGraph: TSpeedButton
      Left = 8
      Top = 232
      Width = 89
      Height = 25
      HelpContext = 14002
      AllowAllUp = True
      GroupIndex = 4
      Caption = '&Graph'
      OnClick = btnGraphClick
    end
    object btnPollNow: TButton
      Left = 8
      Top = 107
      Width = 89
      Height = 25
      HelpContext = 14080
      Caption = '&Poll Now'
      TabOrder = 0
      OnClick = btnPollNowClick
    end
    object btnCheckAll: TButton
      Left = 8
      Top = 8
      Width = 89
      Height = 25
      HelpContext = 14095
      Caption = '&All'
      TabOrder = 1
      OnClick = btnCheckAllClick
    end
    object btnCheckNone: TButton
      Left = 8
      Top = 36
      Width = 89
      Height = 25
      HelpContext = 14096
      Caption = '&None'
      TabOrder = 2
      OnClick = btnCheckNoneClick
    end
    object cboTimes: TComboBox
      Left = 8
      Top = 163
      Width = 89
      Height = 21
      HelpContext = 14097
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = cboTimesChange
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
      Left = 8
      Top = 185
      Width = 91
      Height = 17
      HelpContext = 14098
      Caption = 'Only if active'
      TabOrder = 4
    end
    object chkSyncSeries: TCheckBox
      Left = 8
      Top = 213
      Width = 91
      Height = 17
      HelpContext = 14117
      Caption = 'Sync series'
      TabOrder = 5
    end
    object btnClear: TButton
      Left = 8
      Top = 64
      Width = 89
      Height = 25
      HelpContext = 14118
      Caption = '&Clear'
      TabOrder = 6
      OnClick = btnClearClick
    end
    object btnHelp: TButton
      Left = 8
      Top = 270
      Width = 89
      Height = 25
      HelpContext = 14119
      Caption = '&Help'
      TabOrder = 7
      OnClick = btnHelpClick
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 360
    Top = 8
  end
  object menuPopup: TPopupMenu
    Left = 484
    Top = 328
    object mniOpenSym: TMenuItem
      Caption = 'L&oad symbol file ...'
      ShortCut = 16463
      OnClick = mniOpenSymClick
    end
  end
  object dlgOpen: TOpenDialog
    Filter = 'Symbol files (*.sym)|*.sym'
    Title = 'Open Symbol File'
    Left = 484
    Top = 368
  end
end
