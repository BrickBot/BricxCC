object frmSpybotEEPROM: TfrmSpybotEEPROM
  Left = 192
  Top = 138
  HelpContext = 42000
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Spybot EEPROM'
  ClientHeight = 374
  ClientWidth = 450
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
  object pagMain: TPageControl
    Left = 0
    Top = 0
    Width = 450
    Height = 374
    ActivePage = shtGameItems
    Align = alClient
    TabOrder = 0
    OnChange = pagMainChange
    object shtGameItems: TTabSheet
      HelpContext = 42035
      Caption = 'Game Items'
      object pnlGameBottom: TPanel
        Left = 0
        Top = 314
        Width = 442
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object btnRead: TButton
          Left = 310
          Top = 4
          Width = 60
          Height = 25
          HelpContext = 42028
          Caption = '&Read'
          TabOrder = 3
          OnClick = btnReadClick
        end
        object btnWrite: TButton
          Left = 376
          Top = 4
          Width = 60
          Height = 25
          HelpContext = 42029
          Caption = 'Writ&e'
          TabOrder = 4
          OnClick = btnWriteClick
        end
        object btnSave: TButton
          Left = 6
          Top = 4
          Width = 60
          Height = 25
          HelpContext = 42026
          Caption = 'Sa&ve'
          TabOrder = 0
          OnClick = btnSaveClick
        end
        object btnLoad: TButton
          Left = 72
          Top = 4
          Width = 60
          Height = 25
          HelpContext = 42027
          Caption = 'Lo&ad'
          TabOrder = 1
          OnClick = btnLoadClick
        end
        object btnHelp: TButton
          Left = 191
          Top = 4
          Width = 60
          Height = 25
          HelpContext = 42039
          Caption = '&Help'
          TabOrder = 2
          OnClick = btnHelpClick
        end
      end
      object pnlGameItems: TPanel
        Left = 0
        Top = 0
        Width = 442
        Height = 314
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 1
        object pagGameItems: TPageControl
          Left = 1
          Top = 1
          Width = 440
          Height = 312
          ActivePage = shtGame1
          Align = alClient
          TabOrder = 0
          object shtGame1: TTabSheet
            HelpContext = 42037
            Caption = 'Configuration data'
            object lblSpecies: TLabel
              Left = 6
              Top = 70
              Width = 41
              Height = 13
              Caption = '&Species:'
              FocusControl = cboSpecies
            end
            object lblLongID: TLabel
              Left = 6
              Top = 94
              Width = 41
              Height = 13
              Caption = '&Long ID:'
              FocusControl = edtLongID
            end
            object lblUserLevel: TLabel
              Left = 6
              Top = 118
              Width = 50
              Height = 13
              Caption = '&User level:'
              FocusControl = edtUserLevel
            end
            object lblPingRate: TLabel
              Left = 6
              Top = 142
              Width = 45
              Height = 13
              Caption = '&Ping rate:'
              FocusControl = edtDefaultPingRate
            end
            object lblRuns: TLabel
              Left = 6
              Top = 166
              Width = 28
              Height = 13
              Caption = '&Runs:'
              FocusControl = edtRuns
            end
            object lblWins: TLabel
              Left = 6
              Top = 190
              Width = 27
              Height = 13
              Caption = '&Wins:'
              FocusControl = edtWins
            end
            object lblLosses: TLabel
              Left = 6
              Top = 214
              Width = 36
              Height = 13
              Caption = 'L&osses:'
              FocusControl = edtLosses
            end
            object lblPoints: TLabel
              Left = 6
              Top = 238
              Width = 32
              Height = 13
              Caption = 'Po&ints:'
              FocusControl = edtPoints
            end
            object lblPlaySeconds: TLabel
              Left = 6
              Top = 262
              Width = 66
              Height = 13
              Caption = 'Play se&conds:'
              FocusControl = edtPlaySeconds
            end
            object lblTotalPlayTime: TLabel
              Left = 206
              Top = 70
              Width = 71
              Height = 13
              Caption = '&Total play time:'
              FocusControl = edtTotalPlayTime
            end
            object lblMaxBots: TLabel
              Left = 206
              Top = 94
              Width = 46
              Height = 13
              Caption = 'Max bots:'
              FocusControl = edtMaxBots
            end
            object lblMissionID: TLabel
              Left = 206
              Top = 118
              Width = 52
              Height = 13
              Caption = 'Mission ID:'
              FocusControl = edtMissionID
            end
            object lblMissionPoints: TLabel
              Left = 206
              Top = 142
              Width = 69
              Height = 13
              Caption = 'Mission points:'
              FocusControl = edtMissionPoints
            end
            object lblHighScore: TLabel
              Left = 206
              Top = 166
              Width = 54
              Height = 13
              Caption = 'High score:'
              FocusControl = edtHighScore
            end
            object lblRobotName: TLabel
              Left = 206
              Top = 189
              Width = 61
              Height = 13
              Caption = 'Robot name:'
              FocusControl = edtRobotName
            end
            object lblBirthDate: TLabel
              Left = 206
              Top = 213
              Width = 48
              Height = 13
              Caption = 'Birth date:'
            end
            object lblBotData: TLabel
              Left = 206
              Top = 238
              Width = 43
              Height = 13
              Caption = 'Bot data:'
              FocusControl = edtBotData
            end
            object lblStatus: TLabel
              Left = 206
              Top = 262
              Width = 33
              Height = 13
              Caption = 'Status:'
              FocusControl = edtStatus
            end
            object grpMotorControl: TGroupBox
              Left = 2
              Top = 2
              Width = 427
              Height = 56
              Caption = '&Motor Control'
              TabOrder = 0
              object lblMCNormal: TLabel
                Left = 6
                Top = 25
                Width = 36
                Height = 13
                Caption = 'Normal:'
                FocusControl = edtMCNormal
              end
              object lblMCSlow: TLabel
                Left = 98
                Top = 25
                Width = 26
                Height = 13
                Caption = 'Slow:'
                FocusControl = edtMCSlow
              end
              object grpLeftDir: TGroupBox
                Left = 183
                Top = 8
                Width = 114
                Height = 41
                HelpContext = 42003
                Caption = 'Left Motor Direction'
                TabOrder = 2
                object radLeftFwd: TRadioButton
                  Left = 8
                  Top = 16
                  Width = 46
                  Height = 17
                  Caption = 'Fwd'
                  Checked = True
                  TabOrder = 0
                  TabStop = True
                  OnClick = UpdateRawData
                end
                object radLeftRev: TRadioButton
                  Left = 60
                  Top = 16
                  Width = 46
                  Height = 17
                  Caption = 'Rev'
                  TabOrder = 1
                  OnClick = UpdateRawData
                end
              end
              object grpRightDir: TGroupBox
                Left = 303
                Top = 8
                Width = 114
                Height = 41
                HelpContext = 42004
                Caption = 'Right Motor Direction'
                TabOrder = 3
                object radRightFwd: TRadioButton
                  Left = 8
                  Top = 16
                  Width = 46
                  Height = 17
                  Caption = 'Fwd'
                  Checked = True
                  TabOrder = 0
                  TabStop = True
                  OnClick = UpdateRawData
                end
                object radRightRev: TRadioButton
                  Left = 60
                  Top = 16
                  Width = 46
                  Height = 17
                  Caption = 'Rev'
                  TabOrder = 1
                  OnClick = UpdateRawData
                end
              end
              object edtMCNormal: TBricxccSpinEdit
                Left = 49
                Top = 20
                Width = 42
                Height = 22
                HelpContext = 42001
                MaxLength = 1
                MaxValue = 8
                MinValue = 1
                TabOrder = 0
                Value = 7
                OnChange = UpdateRawData
              end
              object edtMCSlow: TBricxccSpinEdit
                Left = 133
                Top = 20
                Width = 42
                Height = 22
                HelpContext = 42002
                MaxLength = 1
                MaxValue = 8
                MinValue = 1
                TabOrder = 1
                Value = 7
                OnChange = UpdateRawData
              end
            end
            object cboSpecies: TComboBox
              Tag = 1
              Left = 82
              Top = 66
              Width = 113
              Height = 21
              HelpContext = 42005
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 1
              OnChange = UpdateRawData
              Items.Strings = (
                'Gigamesh'
                'Snaptrax'
                'Shadowstrike'
                'Technojaw')
            end
            object edtRobotName: TEdit
              Tag = 32
              Left = 282
              Top = 185
              Width = 143
              Height = 21
              HelpContext = 42019
              MaxLength = 32
              TabOrder = 15
              OnChange = UpdateRawData
            end
            object dtpBirthdate: TDateTimePicker
              Tag = 64
              Left = 282
              Top = 209
              Width = 88
              Height = 21
              HelpContext = 42020
              Date = 35796.742620937500000000
              Time = 35796.742620937500000000
              DateMode = dmUpDown
              MaxDate = 65745.000000000000000000
              MinDate = 29221.000000000000000000
              TabOrder = 16
              OnChange = UpdateRawData
            end
            object edtUserLevel: TBricxccSpinEdit
              Tag = 6
              Left = 82
              Top = 113
              Width = 46
              Height = 22
              HelpContext = 42007
              MaxLength = 3
              MaxValue = 255
              MinValue = 0
              TabOrder = 3
              Value = 0
              OnChange = UpdateRawData
            end
            object edtDefaultPingRate: TBricxccSpinEdit
              Tag = 7
              Left = 82
              Top = 137
              Width = 46
              Height = 22
              HelpContext = 42008
              MaxLength = 3
              MaxValue = 255
              MinValue = 0
              TabOrder = 4
              Value = 0
              OnChange = UpdateRawData
            end
            object edtRuns: TBricxccSpinEdit
              Tag = 8
              Left = 82
              Top = 161
              Width = 58
              Height = 22
              HelpContext = 42009
              MaxLength = 5
              MaxValue = 65535
              MinValue = 0
              TabOrder = 5
              Value = 0
              OnChange = UpdateRawData
            end
            object edtWins: TBricxccSpinEdit
              Tag = 10
              Left = 82
              Top = 185
              Width = 58
              Height = 22
              HelpContext = 42010
              MaxLength = 5
              MaxValue = 65535
              MinValue = 0
              TabOrder = 6
              Value = 0
              OnChange = UpdateRawData
            end
            object edtLosses: TBricxccSpinEdit
              Tag = 12
              Left = 82
              Top = 209
              Width = 58
              Height = 22
              HelpContext = 42011
              MaxLength = 5
              MaxValue = 65535
              MinValue = 0
              TabOrder = 7
              Value = 0
              OnChange = UpdateRawData
            end
            object edtPoints: TBricxccSpinEdit
              Tag = 14
              Left = 82
              Top = 233
              Width = 58
              Height = 22
              HelpContext = 42012
              MaxLength = 5
              MaxValue = 65535
              MinValue = 0
              TabOrder = 8
              Value = 0
              OnChange = UpdateRawData
            end
            object edtPlaySeconds: TBricxccSpinEdit
              Tag = 16
              Left = 82
              Top = 257
              Width = 58
              Height = 22
              HelpContext = 42013
              MaxLength = 5
              MaxValue = 65535
              MinValue = 0
              TabOrder = 9
              Value = 0
              OnChange = UpdateRawData
            end
            object edtTotalPlayTime: TBricxccSpinEdit
              Tag = 18
              Left = 282
              Top = 65
              Width = 113
              Height = 22
              HelpContext = 42014
              MaxLength = 11
              MaxValue = 2147483647
              MinValue = 0
              TabOrder = 10
              Value = 0
              OnChange = UpdateRawData
            end
            object edtMaxBots: TBricxccSpinEdit
              Tag = 22
              Left = 282
              Top = 89
              Width = 46
              Height = 22
              HelpContext = 42015
              MaxLength = 3
              MaxValue = 255
              MinValue = 0
              TabOrder = 11
              Value = 0
              OnChange = UpdateRawData
            end
            object edtMissionID: TBricxccSpinEdit
              Tag = 23
              Left = 282
              Top = 113
              Width = 46
              Height = 22
              HelpContext = 42016
              MaxLength = 3
              MaxValue = 255
              MinValue = 0
              TabOrder = 12
              Value = 0
              OnChange = UpdateRawData
            end
            object edtMissionPoints: TBricxccSpinEdit
              Tag = 28
              Left = 282
              Top = 137
              Width = 58
              Height = 22
              HelpContext = 42017
              MaxLength = 5
              MaxValue = 65535
              MinValue = 0
              TabOrder = 13
              Value = 0
              OnChange = UpdateRawData
            end
            object edtHighScore: TBricxccSpinEdit
              Tag = 30
              Left = 282
              Top = 161
              Width = 58
              Height = 22
              HelpContext = 42018
              MaxLength = 5
              MaxValue = 65535
              MinValue = 0
              TabOrder = 14
              Value = 0
              OnChange = UpdateRawData
            end
            object edtBotData: TBricxccSpinEdit
              Tag = 70
              Left = 282
              Top = 233
              Width = 46
              Height = 22
              HelpContext = 42021
              MaxLength = 3
              MaxValue = 255
              MinValue = 0
              TabOrder = 17
              Value = 0
              OnChange = UpdateRawData
            end
            object edtStatus: TBricxccSpinEdit
              Tag = 71
              Left = 282
              Top = 257
              Width = 46
              Height = 22
              HelpContext = 42022
              MaxLength = 3
              MaxValue = 255
              MinValue = 0
              TabOrder = 18
              Value = 0
              OnChange = UpdateRawData
            end
            object edtLongID: TBricxccSpinEdit
              Tag = 2
              Left = 82
              Top = 89
              Width = 113
              Height = 22
              HelpContext = 42006
              MaxLength = 11
              MaxValue = 2147483647
              MinValue = 0
              TabOrder = 2
              Value = 0
              OnChange = UpdateRawData
            end
          end
          object shtGame2: TTabSheet
            HelpContext = 42038
            Caption = 'Missions && Tokens'
            ImageIndex = 1
            object grpMissionsPlayed: TGroupBox
              Left = 2
              Top = 2
              Width = 90
              Height = 280
              HelpContext = 42023
              Caption = 'Missions played'
              TabOrder = 0
            end
            object grpTokens: TGroupBox
              Left = 95
              Top = 2
              Width = 333
              Height = 280
              HelpContext = 42024
              Caption = 'Tokens'
              TabOrder = 1
            end
          end
        end
      end
    end
    object shtRawData: TTabSheet
      HelpContext = 42025
      Caption = 'Raw Data'
      ImageIndex = 1
      object Label1: TLabel
        Left = 24
        Top = 4
        Width = 5
        Height = 12
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 50
        Top = 4
        Width = 5
        Height = 12
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 77
        Top = 4
        Width = 5
        Height = 12
        Caption = '2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 103
        Top = 4
        Width = 5
        Height = 12
        Caption = '3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 181
        Top = 4
        Width = 5
        Height = 12
        Caption = '6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 207
        Top = 4
        Width = 5
        Height = 12
        Caption = '7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 129
        Top = 4
        Width = 5
        Height = 12
        Caption = '4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 155
        Top = 4
        Width = 5
        Height = 12
        Caption = '5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 233
        Top = 4
        Width = 5
        Height = 12
        Caption = '8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 259
        Top = 4
        Width = 5
        Height = 12
        Caption = '9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 285
        Top = 4
        Width = 5
        Height = 12
        Caption = 'A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 311
        Top = 4
        Width = 5
        Height = 12
        Caption = 'B'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 389
        Top = 4
        Width = 5
        Height = 12
        Caption = 'E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 415
        Top = 4
        Width = 5
        Height = 12
        Caption = 'F'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 336
        Top = 4
        Width = 5
        Height = 12
        Caption = 'C'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 362
        Top = 4
        Width = 5
        Height = 12
        Caption = 'D'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 3
        Top = 19
        Width = 10
        Height = 12
        Caption = '00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label18: TLabel
        Left = 3
        Top = 39
        Width = 10
        Height = 12
        Caption = '10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 3
        Top = 79
        Width = 10
        Height = 12
        Caption = '30'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 3
        Top = 59
        Width = 10
        Height = 12
        Caption = '20'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 3
        Top = 159
        Width = 10
        Height = 12
        Caption = '70'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 3
        Top = 139
        Width = 10
        Height = 12
        Caption = '60'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label23: TLabel
        Left = 3
        Top = 119
        Width = 10
        Height = 12
        Caption = '50'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label24: TLabel
        Left = 3
        Top = 99
        Width = 10
        Height = 12
        Caption = '40'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label25: TLabel
        Left = 3
        Top = 179
        Width = 10
        Height = 12
        Caption = '80'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label26: TLabel
        Left = 3
        Top = 199
        Width = 10
        Height = 12
        Caption = '90'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label27: TLabel
        Left = 3
        Top = 239
        Width = 10
        Height = 12
        Caption = 'B0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label28: TLabel
        Left = 3
        Top = 219
        Width = 10
        Height = 12
        Caption = 'A0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label29: TLabel
        Left = 3
        Top = 319
        Width = 10
        Height = 12
        Caption = 'F0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label30: TLabel
        Left = 3
        Top = 299
        Width = 10
        Height = 12
        Caption = 'E0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label31: TLabel
        Left = 3
        Top = 279
        Width = 10
        Height = 12
        Caption = 'D0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label32: TLabel
        Left = 3
        Top = 259
        Width = 10
        Height = 12
        Caption = 'C0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
    end
    object shtCustom: TTabSheet
      HelpContext = 42036
      Caption = 'Custom'
      ImageIndex = 2
      object lblBlockNum: TLabel
        Left = 8
        Top = 324
        Width = 89
        Height = 13
        Caption = 'EEPROM &Block #:'
        FocusControl = edtBlock
      end
      object lblBlockCnt: TLabel
        Left = 166
        Top = 324
        Width = 61
        Height = 13
        Caption = 'Bloc&k Count:'
        FocusControl = edtBlockCount
      end
      object edtData: TMemo
        Left = 8
        Top = 8
        Width = 425
        Height = 303
        HelpContext = 42030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object btnBlockRead: TButton
        Left = 310
        Top = 318
        Width = 60
        Height = 25
        HelpContext = 42033
        Caption = '&Read'
        TabOrder = 3
        OnClick = btnBlockReadClick
      end
      object btnBlockClear: TButton
        Left = 376
        Top = 318
        Width = 60
        Height = 25
        HelpContext = 42034
        Caption = '&Clear'
        TabOrder = 4
        OnClick = btnBlockClearClick
      end
      object edtBlock: TBricxccSpinEdit
        Left = 107
        Top = 319
        Width = 45
        Height = 22
        HelpContext = 42031
        MaxLength = 3
        MaxValue = 255
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object edtBlockCount: TBricxccSpinEdit
        Left = 238
        Top = 319
        Width = 45
        Height = 22
        HelpContext = 42032
        MaxLength = 3
        MaxValue = 256
        MinValue = 1
        TabOrder = 2
        Value = 1
      end
    end
  end
  object dlgOpen: TOpenDialog
    DefaultExt = 'dat'
    Filter = 'EEPROM Data (*.dat)|*.dat|All Files (*.*)|*.*'
    Title = 'Open EEPROM Data'
    Left = 169
    Top = 321
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'dat'
    Filter = 'EEPROM Data (*.dat)|*.dat|All Files (*.*)|*.*'
    Title = 'Save EEPROM Data'
    Left = 169
    Top = 289
  end
end
