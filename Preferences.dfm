object PrefForm: TPrefForm
  Left = 193
  Top = 205
  HelpContext = 11
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Preferences'
  ClientHeight = 352
  ClientWidth = 452
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 321
    Width = 452
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnDefault: TButton
      Left = 8
      Top = 4
      Width = 73
      Height = 25
      HelpContext = 11002
      Caption = '&Default'
      TabOrder = 0
      OnClick = btnDefaultClick
    end
    object btnOK: TButton
      Left = 213
      Top = 4
      Width = 75
      Height = 25
      HelpContext = 11003
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 1
    end
    object btnCancel: TButton
      Left = 293
      Top = 4
      Width = 75
      Height = 25
      HelpContext = 11004
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
    object btnHelp: TButton
      Left = 373
      Top = 4
      Width = 75
      Height = 25
      HelpContext = 11001
      Caption = '&Help'
      TabOrder = 3
      OnClick = btnHelpClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 452
    Height = 321
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    object pagPrefs: TPageControl
      Left = 1
      Top = 1
      Width = 450
      Height = 319
      ActivePage = shtGeneral
      Align = alClient
      TabOrder = 0
      OnChange = pagPrefsChange
      object shtGeneral: TTabSheet
        Caption = 'General'
        object lblMaxRecent: TLabel
          Left = 8
          Top = 239
          Width = 77
          Height = 13
          Caption = 'Ma&x recent files:'
          FocusControl = edtMaxRecent
        end
        object lblFirmChunk: TLabel
          Left = 8
          Top = 264
          Width = 79
          Height = 13
          Caption = 'Firmware &Chunk:'
          FocusControl = edtFirmwareChunkSize
        end
        object lblWaitTime: TLabel
          Left = 192
          Top = 264
          Width = 51
          Height = 13
          Caption = 'Wait Time:'
          FocusControl = edtWaitTime
        end
        object CheckSavePos: TCheckBox
          Left = 8
          Top = 0
          Width = 229
          Height = 17
          HelpContext = 11010
          Caption = 'Save and restore &window positions'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object CheckSaveBackup: TCheckBox
          Left = 8
          Top = 18
          Width = 229
          Height = 17
          HelpContext = 11011
          Caption = 'Save &backup copies'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object CheckShowRecent: TCheckBox
          Left = 8
          Top = 36
          Width = 229
          Height = 17
          HelpContext = 11012
          Caption = 'Display &recently opened files in menu'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object chkShowCompileStatus: TCheckBox
          Left = 8
          Top = 55
          Width = 229
          Height = 17
          HelpContext = 11013
          Caption = 'Show compiler st&atus message'
          TabOrder = 3
        end
        object chkFirmfast: TCheckBox
          Left = 8
          Top = 166
          Width = 229
          Height = 17
          HelpContext = 11014
          Caption = '&Use fast mode when downloading firmware'
          TabOrder = 9
          OnClick = chkFirmfastClick
        end
        object grpLockedProgs: TGroupBox
          Left = 306
          Top = 63
          Width = 130
          Height = 168
          Caption = 'Locked Programs'
          TabOrder = 17
          object cbProg1: TCheckBox
            Left = 8
            Top = 17
            Width = 88
            Height = 17
            HelpContext = 11016
            Caption = 'Program &1'
            TabOrder = 0
          end
          object cbProg2: TCheckBox
            Left = 8
            Top = 35
            Width = 88
            Height = 17
            HelpContext = 11017
            Caption = 'Program &2'
            TabOrder = 1
          end
          object cbProg3: TCheckBox
            Left = 8
            Top = 54
            Width = 88
            Height = 17
            HelpContext = 11018
            Caption = 'Program &3'
            TabOrder = 2
          end
          object cbProg4: TCheckBox
            Left = 8
            Top = 72
            Width = 88
            Height = 17
            HelpContext = 11019
            Caption = 'Program &4'
            TabOrder = 3
          end
          object cbProg5: TCheckBox
            Left = 8
            Top = 90
            Width = 88
            Height = 17
            HelpContext = 11020
            Caption = 'Program &5'
            TabOrder = 4
          end
          object cbProg6: TCheckBox
            Left = 8
            Top = 108
            Width = 88
            Height = 17
            HelpContext = 11021
            Caption = 'Program &6'
            TabOrder = 5
          end
          object cbProg7: TCheckBox
            Left = 8
            Top = 127
            Width = 88
            Height = 17
            HelpContext = 11022
            Caption = 'Program &7'
            TabOrder = 6
          end
          object cbProg8: TCheckBox
            Left = 8
            Top = 145
            Width = 88
            Height = 17
            HelpContext = 11023
            Caption = 'Program &8'
            TabOrder = 7
          end
        end
        object grpAutoSave: TGroupBox
          Left = 306
          Top = 0
          Width = 130
          Height = 60
          Caption = 'Autosave Options'
          TabOrder = 16
          object chkAutoSave: TCheckBox
            Left = 8
            Top = 16
            Width = 109
            Height = 17
            HelpContext = 11026
            Caption = 'Editor &files'
            TabOrder = 0
          end
          object chkSaveDesktop: TCheckBox
            Left = 8
            Top = 34
            Width = 109
            Height = 17
            HelpContext = 11027
            Caption = 'Project Des&ktop'
            TabOrder = 1
          end
        end
        object chkSaveBinaryOutput: TCheckBox
          Left = 8
          Top = 73
          Width = 229
          Height = 17
          HelpContext = 11028
          Caption = 'Save compiler ou&tput'
          TabOrder = 4
        end
        object chkLockToolbars: TCheckBox
          Left = 8
          Top = 92
          Width = 193
          Height = 17
          HelpContext = 11031
          Caption = 'Lock toolbars in default &positions'
          TabOrder = 5
        end
        object chkMaxEditWindows: TCheckBox
          Left = 8
          Top = 110
          Width = 193
          Height = 17
          HelpContext = 11032
          Caption = 'Max&imize editor windows'
          TabOrder = 6
        end
        object chkMultiFormatCopy: TCheckBox
          Left = 8
          Top = 129
          Width = 193
          Height = 17
          HelpContext = 11033
          Caption = 'Multi-format clipboard c&opy'
          TabOrder = 7
        end
        object chkUseMDI: TCheckBox
          Left = 8
          Top = 147
          Width = 193
          Height = 17
          HelpContext = 11034
          Caption = 'Use &MDI mode'
          TabOrder = 8
        end
        object chkQuietFirmware: TCheckBox
          Left = 8
          Top = 184
          Width = 193
          Height = 17
          HelpContext = 11035
          Caption = '&Quiet firmware download'
          TabOrder = 11
        end
        object chkFirmComp: TCheckBox
          Left = 250
          Top = 161
          Width = 45
          Height = 17
          HelpContext = 11037
          Caption = '2 x'
          TabOrder = 10
        end
        object chkDroppedRecent: TCheckBox
          Left = 8
          Top = 203
          Width = 241
          Height = 17
          Caption = 'Add dropped files to recent file list'
          TabOrder = 12
        end
        object edtMaxRecent: TSpinEdit
          Left = 98
          Top = 234
          Width = 50
          Height = 22
          HelpContext = 11029
          MaxLength = 2
          MaxValue = 10
          MinValue = 2
          TabOrder = 13
          Value = 2
        end
        object edtFirmwareChunkSize: TSpinEdit
          Left = 98
          Top = 259
          Width = 50
          Height = 22
          HelpContext = 11036
          Increment = 50
          MaxLength = 4
          MaxValue = 4400
          MinValue = 4
          TabOrder = 14
          Value = 200
        end
        object edtWaitTime: TSpinEdit
          Left = 250
          Top = 259
          Width = 50
          Height = 22
          HelpContext = 11255
          Increment = 50
          MaxLength = 3
          MaxValue = 900
          MinValue = 100
          TabOrder = 15
          Value = 100
        end
      end
      object shtEditor: TTabSheet
        Caption = 'Editor'
        object pagEditor: TPageControl
          Left = 0
          Top = 0
          Width = 442
          Height = 291
          ActivePage = shtEditorOptions
          Align = alClient
          TabOrder = 0
          object shtEditorOptions: TTabSheet
            Caption = 'Options'
            object lblScrollBars: TLabel
              Left = 8
              Top = 119
              Width = 52
              Height = 13
              Caption = 'Scro&ll bars:'
              FocusControl = cbxScrollBars
            end
            object Label3: TLabel
              Left = 8
              Top = 143
              Width = 64
              Height = 13
              Caption = 'Max le&ft char:'
              FocusControl = edtMaxLeftChar
            end
            object lblTabWidth: TLabel
              Left = 8
              Top = 167
              Width = 50
              Height = 13
              Caption = '&Tab width:'
              FocusControl = inpTabWidth
            end
            object lblMaxUndo: TLabel
              Left = 8
              Top = 190
              Width = 50
              Height = 13
              Caption = 'Ma&x undo:'
              FocusControl = inpMaxUndo
            end
            object lblExtraSpace: TLabel
              Left = 8
              Top = 214
              Width = 86
              Height = 13
              Caption = 'Extra line spac&ing:'
              FocusControl = inpExtraLineSpacing
            end
            object lblRightEdge: TLabel
              Left = 8
              Top = 237
              Width = 55
              Height = 13
              Caption = '&Right edge:'
              FocusControl = inpRightEdge
            end
            object btnFont: TButton
              Left = 114
              Top = 87
              Width = 95
              Height = 25
              HelpContext = 11053
              Caption = 'Editor Fo&nt ...'
              TabOrder = 4
              OnClick = btnFontClick
            end
            object cbxScrollBars: TComboBox
              Left = 114
              Top = 115
              Width = 95
              Height = 21
              HelpContext = 11060
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 5
              Items.Strings = (
                'Both'
                'Horizontal'
                'None'
                'Vertical')
            end
            object chkGroupUndo: TCheckBox
              Left = 256
              Top = 144
              Width = 177
              Height = 17
              HelpContext = 11072
              Caption = '&With grouped undo'
              TabOrder = 20
            end
            object chkEnhHomeKey: TCheckBox
              Left = 256
              Top = 128
              Width = 177
              Height = 17
              HelpContext = 11071
              Caption = 'Enhanced home ke&y'
              TabOrder = 19
            end
            object chkKeepBlanks: TCheckBox
              Left = 256
              Top = 112
              Width = 177
              Height = 17
              HelpContext = 11069
              Caption = '&Keep trailing blanks'
              TabOrder = 18
            end
            object chkSmartTab: TCheckBox
              Left = 256
              Top = 96
              Width = 177
              Height = 17
              HelpContext = 11070
              Caption = '&Quick tab'
              TabOrder = 17
            end
            object chkDragDrop: TCheckBox
              Left = 256
              Top = 80
              Width = 177
              Height = 17
              HelpContext = 11066
              Caption = 'Dra&g and drop editing'
              TabOrder = 16
            end
            object cbHalfPageScroll: TCheckBox
              Left = 256
              Top = 64
              Width = 177
              Height = 17
              HelpContext = 11056
              Caption = '&HalfPage Scroll'
              TabOrder = 15
            end
            object cbScrollPastEOL: TCheckBox
              Left = 256
              Top = 48
              Width = 177
              Height = 17
              HelpContext = 11055
              Caption = 'Scroll Past &EOL'
              TabOrder = 14
            end
            object cbHideSelection: TCheckBox
              Left = 8
              Top = 48
              Width = 227
              Height = 17
              HelpContext = 11054
              Caption = 'Hide &selection'
              TabOrder = 3
            end
            object chkMoveRight: TCheckBox
              Left = 256
              Top = 32
              Width = 177
              Height = 17
              HelpContext = 11068
              Caption = 'Mo&ve cursor on right click'
              TabOrder = 13
            end
            object chkAltSelMode: TCheckBox
              Left = 256
              Top = 16
              Width = 177
              Height = 17
              HelpContext = 11067
              Caption = 'Alt sets col&umn selection'
              TabOrder = 12
            end
            object CheckMacrosOn: TCheckBox
              Left = 8
              Top = 32
              Width = 227
              Height = 17
              HelpContext = 11052
              Caption = 'Use <Ctrl><Alt> combinations for &macros'
              Checked = True
              State = cbChecked
              TabOrder = 2
            end
            object CheckAutoIndentCode: TCheckBox
              Left = 256
              Top = 0
              Width = 177
              Height = 17
              HelpContext = 11051
              Caption = '&Automatically indent lines'
              Checked = True
              State = cbChecked
              TabOrder = 11
            end
            object CheckShowTemplates: TCheckBox
              Left = 8
              Top = 16
              Width = 227
              Height = 17
              HelpContext = 11050
              Caption = 'Show &pop-up menu with templates'
              Checked = True
              State = cbChecked
              TabOrder = 1
            end
            object CheckColorCoding: TCheckBox
              Left = 8
              Top = 0
              Width = 227
              Height = 17
              HelpContext = 11049
              Caption = '&Color code the program'
              Checked = True
              State = cbChecked
              TabOrder = 0
            end
            object chkTabIndent: TCheckBox
              Left = 256
              Top = 160
              Width = 177
              Height = 17
              HelpContext = 11072
              Caption = 'Use Tab to indent'
              TabOrder = 21
            end
            object chkShowSpecialChars: TCheckBox
              Left = 256
              Top = 176
              Width = 177
              Height = 17
              HelpContext = 11072
              Caption = 'Show special characters'
              TabOrder = 22
            end
            object chkConvertTabs: TCheckBox
              Left = 256
              Top = 192
              Width = 177
              Height = 17
              HelpContext = 11072
              Caption = 'Convert tabs to spaces'
              TabOrder = 23
            end
            object chkHighlightCurLine: TCheckBox
              Left = 256
              Top = 208
              Width = 177
              Height = 17
              HelpContext = 11072
              Caption = 'Highlight current line'
              TabOrder = 24
            end
            object chkKeepCaretX: TCheckBox
              Left = 256
              Top = 224
              Width = 177
              Height = 17
              HelpContext = 11072
              Caption = 'Keep caret x position'
              TabOrder = 25
            end
            object chkAutoMaxLeft: TCheckBox
              Left = 256
              Top = 240
              Width = 177
              Height = 17
              HelpContext = 11072
              Caption = 'Autosize max left character'
              TabOrder = 26
            end
            object edtMaxLeftChar: TSpinEdit
              Left = 114
              Top = 138
              Width = 60
              Height = 22
              HelpContext = 11065
              MaxLength = 4
              MaxValue = 9999
              MinValue = 0
              TabOrder = 6
              Value = 1024
            end
            object inpTabWidth: TSpinEdit
              Left = 114
              Top = 162
              Width = 60
              Height = 22
              HelpContext = 11065
              MaxValue = 16
              MinValue = 1
              TabOrder = 7
              Value = 2
            end
            object inpMaxUndo: TSpinEdit
              Left = 114
              Top = 186
              Width = 60
              Height = 22
              HelpContext = 11064
              MaxValue = 9999
              MinValue = 0
              TabOrder = 8
              Value = 10
            end
            object inpExtraLineSpacing: TSpinEdit
              Left = 114
              Top = 209
              Width = 60
              Height = 22
              HelpContext = 11057
              MaxLength = 3
              MaxValue = 99
              MinValue = -99
              TabOrder = 9
              Value = 0
            end
            object inpRightEdge: TSpinEdit
              Left = 114
              Top = 233
              Width = 60
              Height = 22
              HelpContext = 11058
              MaxLength = 3
              MaxValue = 999
              MinValue = 0
              TabOrder = 10
              Value = 80
            end
          end
          object shtEditorColors: TTabSheet
            Caption = 'Colors'
            ImageIndex = 1
            object lblRightEdgeColor: TLabel
              Left = 8
              Top = 12
              Width = 81
              Height = 13
              Caption = 'Right e&dge color:'
            end
            object lblSelFore: TLabel
              Left = 8
              Top = 35
              Width = 101
              Height = 13
              Caption = 'Selection &foreground:'
            end
            object lblSelBack: TLabel
              Left = 8
              Top = 59
              Width = 107
              Height = 13
              Caption = 'Selection &background:'
            end
            object lblEditorColor: TLabel
              Left = 8
              Top = 83
              Width = 87
              Height = 13
              Caption = 'Background c&olor:'
            end
            object lblStructureColor: TLabel
              Left = 8
              Top = 107
              Width = 91
              Height = 13
              Caption = '&Structure line color:'
            end
            object Label4: TLabel
              Left = 8
              Top = 131
              Width = 78
              Height = 13
              Caption = '&Active line color:'
            end
            object cbxREColor: TColorBox
              Left = 150
              Top = 7
              Width = 128
              Height = 22
              ItemHeight = 16
              TabOrder = 0
            end
            object cbxForeground: TColorBox
              Left = 150
              Top = 30
              Width = 128
              Height = 22
              ItemHeight = 16
              TabOrder = 1
            end
            object cbxBackground: TColorBox
              Left = 150
              Top = 54
              Width = 128
              Height = 22
              ItemHeight = 16
              TabOrder = 2
            end
            object cbxColor: TColorBox
              Left = 150
              Top = 78
              Width = 128
              Height = 22
              ItemHeight = 16
              TabOrder = 3
            end
            object cbxStructureColor: TColorBox
              Left = 150
              Top = 102
              Width = 128
              Height = 22
              Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone]
              ItemHeight = 16
              TabOrder = 4
            end
            object cbxActiveLineColor: TColorBox
              Left = 150
              Top = 126
              Width = 128
              Height = 22
              ItemHeight = 16
              TabOrder = 5
            end
          end
          object shtExperts: TTabSheet
            Caption = 'Experts'
            ImageIndex = 2
            object lblBlockComment: TLabel
              Left = 8
              Top = 16
              Width = 251
              Height = 13
              Caption = 'Block comment/uncomment (Ctrl+Alt+Period/Comma)'
            end
            object lblAlignLines: TLabel
              Left = 8
              Top = 48
              Width = 114
              Height = 13
              Caption = 'Align lines (Ctrl+Alt+End)'
            end
            object Label7: TLabel
              Left = 8
              Top = 80
              Width = 205
              Height = 13
              Caption = 'Previous/Next identifier (Ctrl+Alt+Up/Down)'
            end
            object Label8: TLabel
              Left = 8
              Top = 112
              Width = 170
              Height = 13
              Caption = 'Reverse statements (Ctrl+Alt+Home)'
            end
            object btnCommentConfig: TButton
              Left = 337
              Top = 10
              Width = 89
              Height = 25
              Caption = 'Configure'
              TabOrder = 0
              OnClick = btnCommentConfigClick
            end
            object btnAlignLinesConfig: TButton
              Left = 337
              Top = 42
              Width = 89
              Height = 25
              Caption = 'Configure'
              TabOrder = 1
              OnClick = btnAlignLinesConfigClick
            end
            object Button1: TButton
              Left = 337
              Top = 74
              Width = 89
              Height = 25
              Caption = 'Configure'
              Enabled = False
              TabOrder = 2
              OnClick = btnAlignLinesConfigClick
            end
            object Button2: TButton
              Left = 337
              Top = 106
              Width = 89
              Height = 25
              Caption = 'Configure'
              Enabled = False
              TabOrder = 3
              OnClick = btnAlignLinesConfigClick
            end
          end
        end
      end
      object shtCompiler: TTabSheet
        Caption = 'Compiler'
        ImageIndex = 8
        object pagCompiler: TPageControl
          Left = 8
          Top = 8
          Width = 425
          Height = 276
          ActivePage = shtCompilerCommon
          TabOrder = 0
          object shtCompilerCommon: TTabSheet
            Caption = 'Common'
            object lblCompilerTimeout: TLabel
              Left = 6
              Top = 8
              Width = 41
              Height = 13
              Caption = '&Timeout:'
              FocusControl = edtCompilerTimeout
            end
            object lblCompilerSwitches: TLabel
              Left = 6
              Top = 32
              Width = 46
              Height = 13
              Caption = '&Switches:'
              FocusControl = edtCompilerSwitches
            end
            object lblCommonSeconds: TLabel
              Left = 136
              Top = 8
              Width = 46
              Height = 13
              Caption = '(seconds)'
            end
            object edtCompilerSwitches: TEdit
              Left = 76
              Top = 28
              Width = 337
              Height = 21
              HelpContext = 11081
              TabOrder = 1
            end
            object grpDefLanguage: TGroupBox
              Left = 76
              Top = 52
              Width = 337
              Height = 55
              Caption = 'Preferred language for standard firmware'
              TabOrder = 2
              object radPrefNQC: TRadioButton
                Left = 8
                Top = 16
                Width = 89
                Height = 17
                HelpContext = 11083
                Caption = 'NQC'
                Checked = True
                TabOrder = 0
                TabStop = True
              end
              object radPrefMindScript: TRadioButton
                Left = 8
                Top = 34
                Width = 89
                Height = 17
                HelpContext = 11084
                Caption = 'MindScript'
                TabOrder = 1
              end
              object radPrefLASM: TRadioButton
                Left = 120
                Top = 16
                Width = 89
                Height = 17
                HelpContext = 11085
                Caption = 'LASM'
                TabOrder = 2
              end
              object radPrefNBC: TRadioButton
                Left = 120
                Top = 34
                Width = 89
                Height = 17
                HelpContext = 11086
                Caption = 'NBC'
                TabOrder = 3
              end
              object radPrefNXC: TRadioButton
                Left = 232
                Top = 16
                Width = 89
                Height = 17
                HelpContext = 11086
                Caption = 'NXC'
                TabOrder = 4
              end
            end
            object btnPrecompile: TButton
              Left = 76
              Top = 112
              Width = 120
              Height = 25
              Caption = 'Pre-compile Tools'
              TabOrder = 3
              OnClick = btnPrecompileClick
            end
            object btnPostcompile: TButton
              Left = 76
              Top = 144
              Width = 120
              Height = 25
              Caption = 'Post-compile Tools'
              TabOrder = 4
              OnClick = btnPostcompileClick
            end
            object edtCompilerTimeout: TSpinEdit
              Left = 76
              Top = 3
              Width = 56
              Height = 22
              HelpContext = 11080
              Increment = 10
              MaxLength = 3
              MaxValue = 999
              MinValue = 0
              TabOrder = 0
              Value = 0
            end
          end
          object shtCompilerNQC: TTabSheet
            Caption = 'NQC'
            ImageIndex = 1
            object lblNQCIncludePath: TLabel
              Left = 6
              Top = 7
              Width = 62
              Height = 13
              Caption = '&Include path:'
            end
            object lblNQCSwitches: TLabel
              Left = 6
              Top = 32
              Width = 46
              Height = 13
              Caption = '&Switches:'
              FocusControl = edtNQCSwitches
            end
            object lblNQCPath: TLabel
              Left = 6
              Top = 57
              Width = 48
              Height = 13
              Caption = 'EXE &path:'
            end
            object edtNQCSwitches: TEdit
              Left = 76
              Top = 28
              Width = 337
              Height = 21
              HelpContext = 11091
              TabOrder = 1
            end
            object edtNQCIncludePath: TComboBox
              Left = 76
              Top = 3
              Width = 337
              Height = 21
              HelpContext = 11092
              DropDownCount = 4
              ItemHeight = 0
              TabOrder = 0
              OnExit = edtNQCIncludePathExit
            end
            object btnGetNQCVersion: TButton
              Left = 76
              Top = 80
              Width = 75
              Height = 25
              HelpContext = 11094
              Caption = '&Version'
              TabOrder = 3
              OnClick = btnGetNQCVersionClick
            end
            object edtNQCExePath2: TEdit
              Left = 76
              Top = 53
              Width = 337
              Height = 21
              HelpContext = 11093
              AutoSize = False
              TabOrder = 2
            end
            object chkIncludeSrcInList: TCheckBox
              Left = 76
              Top = 120
              Width = 229
              Height = 17
              HelpContext = 11024
              Caption = '&Show source in code listing'
              TabOrder = 4
            end
          end
          object shtCompilerLCC: TTabSheet
            Caption = 'LCC'
            ImageIndex = 2
            object lblLCCIncludePath: TLabel
              Left = 6
              Top = 7
              Width = 62
              Height = 13
              Caption = '&Include path:'
            end
            object lblLCCSwitches: TLabel
              Left = 6
              Top = 32
              Width = 46
              Height = 13
              Caption = '&Switches:'
              FocusControl = edtLCCSwitches
            end
            object lblLCCExePath: TLabel
              Left = 6
              Top = 57
              Width = 48
              Height = 13
              Caption = 'EXE &path:'
            end
            object edtLCCSwitches: TEdit
              Left = 76
              Top = 28
              Width = 337
              Height = 21
              HelpContext = 11100
              TabOrder = 1
            end
            object edtLCCIncludePath: TComboBox
              Left = 76
              Top = 3
              Width = 337
              Height = 21
              HelpContext = 11101
              DropDownCount = 4
              ItemHeight = 0
              TabOrder = 0
              OnExit = edtLCCIncludePathExit
            end
            object btnGetLCCVersion: TButton
              Left = 76
              Top = 80
              Width = 75
              Height = 25
              HelpContext = 11103
              Caption = '&Version'
              TabOrder = 3
              OnClick = btnGetLCCVersionClick
            end
            object edtLCCExePath2: TEdit
              Left = 76
              Top = 53
              Width = 337
              Height = 21
              HelpContext = 11102
              AutoSize = False
              TabOrder = 2
            end
          end
          object shtNBC: TTabSheet
            Caption = 'NBC/NXC'
            ImageIndex = 6
            object lblNBCIncludePath: TLabel
              Left = 6
              Top = 7
              Width = 62
              Height = 13
              Caption = '&Include path:'
            end
            object lblNBCSwitches: TLabel
              Left = 6
              Top = 32
              Width = 46
              Height = 13
              Caption = '&Switches:'
              FocusControl = edtNBCSwitches
            end
            object lblNBCExePath: TLabel
              Left = 6
              Top = 57
              Width = 48
              Height = 13
              Caption = 'EXE &path:'
            end
            object Label2: TLabel
              Left = 261
              Top = 86
              Width = 85
              Height = 13
              Caption = 'Optimization &level:'
            end
            object lblMaxErrors: TLabel
              Left = 261
              Top = 117
              Width = 52
              Height = 13
              Caption = 'Ma&x errors:'
              FocusControl = edtMaxErrors
            end
            object btnGetNBCVersion: TButton
              Left = 76
              Top = 80
              Width = 75
              Height = 25
              HelpContext = 11104
              Caption = '&Version'
              TabOrder = 3
              OnClick = btnGetNBCVersionClick
            end
            object edtNBCSwitches: TEdit
              Left = 76
              Top = 28
              Width = 337
              Height = 21
              HelpContext = 11106
              TabOrder = 1
            end
            object edtNBCIncludePath: TComboBox
              Left = 76
              Top = 3
              Width = 337
              Height = 21
              HelpContext = 11107
              DropDownCount = 4
              ItemHeight = 13
              TabOrder = 0
              OnExit = edtNBCIncludePathExit
            end
            object chkUseIntNBCComp: TCheckBox
              Left = 76
              Top = 112
              Width = 173
              Height = 17
              Caption = 'Use internal &compiler'
              TabOrder = 4
            end
            object cboOptLevel: TComboBox
              Left = 354
              Top = 82
              Width = 50
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 7
              Items.Strings = (
                '0'
                '1'
                '2'
                '3'
                '4'
                '5'
                '6')
            end
            object chkEnhancedFirmware: TCheckBox
              Left = 76
              Top = 128
              Width = 173
              Height = 17
              Caption = 'Enhanced &firmware'
              TabOrder = 5
            end
            object chkIgnoreSysFiles: TCheckBox
              Left = 76
              Top = 144
              Width = 173
              Height = 17
              Caption = 'Ignore system i&nclude files'
              TabOrder = 6
            end
            object edtMaxErrors: TSpinEdit
              Left = 354
              Top = 112
              Width = 50
              Height = 22
              MaxLength = 3
              MaxValue = 999
              MinValue = 0
              TabOrder = 8
              Value = 0
            end
            object edtNBCExePath2: TEdit
              Left = 76
              Top = 53
              Width = 337
              Height = 21
              HelpContext = 11105
              AutoSize = False
              TabOrder = 2
            end
            object chkNXT2Firmare: TCheckBox
              Left = 76
              Top = 160
              Width = 173
              Height = 17
              Caption = 'NXT &2.0 compatible firmware'
              TabOrder = 9
            end
            object GroupBox1: TGroupBox
              Left = 76
              Top = 180
              Width = 325
              Height = 61
              Caption = 'RIC Decompilation'
              TabOrder = 10
              object Label6: TLabel
                Left = 160
                Top = 16
                Width = 88
                Height = 13
                Caption = '&Array name format:'
              end
              object radRICDecompScript: TRadioButton
                Left = 8
                Top = 16
                Width = 121
                Height = 17
                Caption = 'RICScript'
                Checked = True
                TabOrder = 0
                TabStop = True
                OnClick = radRICDecompScriptClick
              end
              object radRICDecompArray: TRadioButton
                Left = 8
                Top = 32
                Width = 121
                Height = 17
                Caption = 'Byte array'
                TabOrder = 1
                OnClick = radRICDecompScriptClick
              end
              object edtRICDecompArrayFmt: TEdit
                Left = 160
                Top = 30
                Width = 121
                Height = 21
                Enabled = False
                TabOrder = 2
                Text = '%s_data'
              end
            end
          end
          object shtCompilerBrickOS: TTabSheet
            Caption = 'C/C++/Pascal'
            ImageIndex = 3
            object lblOSRoot: TLabel
              Left = 6
              Top = 32
              Width = 39
              Height = 13
              Caption = '&OS root:'
              FocusControl = edtOSRoot
            end
            object lblCPPSwitches: TLabel
              Left = 6
              Top = 57
              Width = 46
              Height = 13
              Caption = '&Switches:'
              FocusControl = edtCPPSwitches
            end
            object lblBrickOSMakefileTemplate: TLabel
              Left = 6
              Top = 80
              Width = 67
              Height = 41
              AutoSize = False
              Caption = '&Makefile template:'
              WordWrap = True
            end
            object lblCygwin: TLabel
              Left = 6
              Top = 7
              Width = 37
              Height = 13
              Caption = '&Cygwin:'
            end
            object lblPascalCompilerPrefix: TLabel
              Left = 6
              Top = 220
              Width = 63
              Height = 13
              Caption = '&Pascal prefix:'
              FocusControl = edtPascalCompilerPrefix
            end
            object edtOSRoot: TEdit
              Left = 76
              Top = 28
              Width = 337
              Height = 21
              HelpContext = 11111
              TabOrder = 1
            end
            object edtCPPSwitches: TEdit
              Left = 76
              Top = 53
              Width = 337
              Height = 21
              HelpContext = 11112
              TabOrder = 2
            end
            object edtBrickOSMakefileTemplate: TMemo
              Left = 76
              Top = 80
              Width = 337
              Height = 113
              HelpContext = 11113
              ScrollBars = ssBoth
              TabOrder = 3
              WantTabs = True
            end
            object chkKeepBrickOSMakefile: TCheckBox
              Left = 76
              Top = 196
              Width = 325
              Height = 17
              HelpContext = 11115
              Caption = 'Keep the makefile after compilation'
              TabOrder = 4
            end
            object edtPascalCompilerPrefix: TEdit
              Left = 76
              Top = 216
              Width = 337
              Height = 21
              HelpContext = 11116
              TabOrder = 5
            end
            object edtCygwin2: TEdit
              Left = 76
              Top = 3
              Width = 337
              Height = 21
              HelpContext = 11110
              AutoSize = False
              TabOrder = 0
            end
          end
          object shtCompilerLeJOS: TTabSheet
            Caption = 'Java'
            ImageIndex = 4
            object lblJavaSwitches: TLabel
              Left = 6
              Top = 57
              Width = 46
              Height = 13
              Caption = '&Switches:'
              FocusControl = edtJavaSwitches
            end
            object lblLeJOSMakefileTemplate: TLabel
              Left = 6
              Top = 80
              Width = 67
              Height = 41
              AutoSize = False
              Caption = '&Makefile template:'
              WordWrap = True
            end
            object Label1: TLabel
              Left = 6
              Top = 7
              Width = 47
              Height = 13
              Caption = '&JDK path:'
            end
            object lblLeJOSRoot: TLabel
              Left = 6
              Top = 32
              Width = 39
              Height = 13
              Caption = '&OS root:'
            end
            object edtJavaSwitches: TEdit
              Left = 76
              Top = 53
              Width = 337
              Height = 21
              HelpContext = 11124
              TabOrder = 2
            end
            object edtLeJOSMakefileTemplate: TMemo
              Left = 76
              Top = 80
              Width = 337
              Height = 137
              HelpContext = 11125
              ScrollBars = ssBoth
              TabOrder = 3
              WantTabs = True
            end
            object chkKeepLeJOSMakefile: TCheckBox
              Left = 76
              Top = 224
              Width = 325
              Height = 17
              HelpContext = 11126
              Caption = 'Keep the makefile after compilation'
              TabOrder = 4
            end
            object edtJavaPath2: TEdit
              Left = 76
              Top = 3
              Width = 337
              Height = 21
              HelpContext = 11122
              AutoSize = False
              TabOrder = 0
            end
            object edtLeJOSRoot2: TEdit
              Left = 76
              Top = 28
              Width = 337
              Height = 21
              HelpContext = 11123
              AutoSize = False
              TabOrder = 1
            end
          end
          object shtForth: TTabSheet
            Caption = 'Forth Console'
            ImageIndex = 5
            object lblInterCharacterDelay: TLabel
              Left = 16
              Top = 112
              Width = 100
              Height = 13
              Caption = 'Inter-&character delay:'
              FocusControl = edtICDelay
            end
            object lblInterLineDelay: TLabel
              Left = 16
              Top = 138
              Width = 71
              Height = 13
              Caption = 'Inter-&line delay:'
              FocusControl = edtILDelay
            end
            object chkShowAllOutput: TCheckBox
              Left = 16
              Top = 16
              Width = 166
              Height = 17
              HelpContext = 11132
              Caption = 'Show all &output'
              TabOrder = 0
            end
            object chkStopOnAborted: TCheckBox
              Left = 16
              Top = 32
              Width = 166
              Height = 17
              HelpContext = 11133
              Caption = 'Stop download on any &error'
              TabOrder = 1
            end
            object chkSkipBlankLines: TCheckBox
              Left = 16
              Top = 48
              Width = 166
              Height = 17
              HelpContext = 11134
              Caption = 'Skip &blank lines'
              Checked = True
              State = cbChecked
              TabOrder = 2
            end
            object chkStripComments: TCheckBox
              Left = 16
              Top = 64
              Width = 166
              Height = 17
              HelpContext = 11135
              Caption = '&Strip comments'
              TabOrder = 3
            end
            object chkConsoleSyntaxHL: TCheckBox
              Left = 198
              Top = 48
              Width = 211
              Height = 17
              HelpContext = 11138
              Caption = 'Syntax &highlighting'
              Checked = True
              State = cbChecked
              TabOrder = 6
            end
            object chkOutputSeparate: TCheckBox
              Left = 198
              Top = 16
              Width = 211
              Height = 17
              HelpContext = 11139
              Caption = 'Download output in sep&arate window'
              TabOrder = 4
            end
            object chkShowConsoleLineNumbers: TCheckBox
              Left = 198
              Top = 32
              Width = 211
              Height = 17
              HelpContext = 11140
              Caption = 'Show line &numbers'
              TabOrder = 5
            end
            object grpUSB: TGroupBox
              Left = 216
              Top = 104
              Width = 185
              Height = 97
              Caption = 'USB Tower Settings'
              TabOrder = 10
              object lblReadFirstTimeout: TLabel
                Left = 12
                Top = 22
                Width = 85
                Height = 13
                Caption = 'Read &first timeout:'
                FocusControl = edtConsoleReadFirstTimeout
              end
              object lblReadICTimeout: TLabel
                Left = 12
                Top = 46
                Width = 77
                Height = 13
                Caption = 'Read &ic timeout:'
                FocusControl = edtConsoleReadICTimeout
              end
              object lblWriteTimeout: TLabel
                Left = 12
                Top = 70
                Width = 65
                Height = 13
                Caption = '&Write timeout:'
                FocusControl = edtConsoleWriteTimeout
              end
              object edtConsoleReadFirstTimeout: TSpinEdit
                Left = 114
                Top = 17
                Width = 60
                Height = 22
                HelpContext = 11145
                MaxLength = 4
                MaxValue = 9999
                MinValue = 0
                TabOrder = 0
                Value = 10
              end
              object edtConsoleReadICTimeout: TSpinEdit
                Left = 114
                Top = 41
                Width = 60
                Height = 22
                HelpContext = 11146
                MaxLength = 4
                MaxValue = 9999
                MinValue = 0
                TabOrder = 1
                Value = 0
              end
              object edtConsoleWriteTimeout: TSpinEdit
                Left = 114
                Top = 65
                Width = 60
                Height = 22
                HelpContext = 11147
                MaxLength = 4
                MaxValue = 9999
                MinValue = 0
                TabOrder = 2
                Value = 0
              end
            end
            object chkConsoleCompProp: TCheckBox
              Left = 198
              Top = 64
              Width = 211
              Height = 17
              HelpContext = 11148
              Caption = 'Code co&mpletion'
              Checked = True
              State = cbChecked
              TabOrder = 7
            end
            object edtICDelay: TSpinEdit
              Left = 126
              Top = 107
              Width = 60
              Height = 22
              HelpContext = 11136
              MaxLength = 4
              MaxValue = 9999
              MinValue = 0
              TabOrder = 8
              Value = 0
            end
            object edtILDelay: TSpinEdit
              Left = 126
              Top = 133
              Width = 60
              Height = 22
              HelpContext = 11137
              MaxLength = 4
              MaxValue = 9999
              MinValue = 0
              TabOrder = 9
              Value = 200
            end
          end
        end
      end
      object shtAPI: TTabSheet
        Caption = 'API'
        ImageIndex = 7
        object pagAPILang: TPageControl
          Left = 4
          Top = 4
          Width = 434
          Height = 277
          ActivePage = shtNQCAPI
          TabOrder = 2
          object shtNQCAPI: TTabSheet
            Caption = 'NQC'
            object pagNQCAPI: TPageControl
              Left = 6
              Top = 6
              Width = 414
              Height = 237
              ActivePage = shtAPIKeywords
              TabOrder = 0
              OnChange = pagNQCAPIChange
              object shtAPIKeywords: TTabSheet
                Caption = 'Keywords'
                object lstKeywords: TListBox
                  Left = 4
                  Top = 28
                  Width = 200
                  Height = 173
                  HelpContext = 11152
                  IntegralHeight = True
                  ItemHeight = 13
                  Sorted = True
                  TabOrder = 0
                  OnClick = lstAPIClick
                end
                object edtKeyword: TEdit
                  Left = 4
                  Top = 2
                  Width = 200
                  Height = 21
                  HelpContext = 11153
                  TabOrder = 1
                  OnChange = edtAPIChange
                end
              end
              object shtAPICommands: TTabSheet
                Caption = 'Commands'
                ImageIndex = 1
                object lstCommands: TListBox
                  Left = 4
                  Top = 28
                  Width = 200
                  Height = 173
                  HelpContext = 11155
                  IntegralHeight = True
                  ItemHeight = 13
                  Sorted = True
                  TabOrder = 0
                  OnClick = lstAPIClick
                end
                object edtCommand: TEdit
                  Left = 4
                  Top = 2
                  Width = 200
                  Height = 21
                  HelpContext = 11156
                  TabOrder = 1
                  OnChange = edtAPIChange
                end
              end
              object shtAPIConstants: TTabSheet
                Caption = 'Constants'
                ImageIndex = 2
                object lstConstants: TListBox
                  Left = 4
                  Top = 28
                  Width = 200
                  Height = 173
                  HelpContext = 11158
                  IntegralHeight = True
                  ItemHeight = 13
                  Sorted = True
                  TabOrder = 0
                  OnClick = lstAPIClick
                end
                object edtConstant: TEdit
                  Left = 4
                  Top = 2
                  Width = 200
                  Height = 21
                  HelpContext = 11159
                  TabOrder = 1
                  OnChange = edtAPIChange
                end
              end
            end
          end
          object shtNXCAPI: TTabSheet
            Caption = 'NXC'
            ImageIndex = 1
            object pagNXCAPI: TPageControl
              Left = 6
              Top = 6
              Width = 414
              Height = 237
              ActivePage = shtNXCKeywords
              TabOrder = 0
              OnChange = pagNQCAPIChange
              object shtNXCKeywords: TTabSheet
                Caption = 'Keywords'
                object lstNXCKeywords: TListBox
                  Left = 4
                  Top = 28
                  Width = 200
                  Height = 173
                  HelpContext = 11152
                  IntegralHeight = True
                  ItemHeight = 13
                  Sorted = True
                  TabOrder = 0
                  OnClick = lstAPIClick
                end
                object edtNXCKeyword: TEdit
                  Left = 4
                  Top = 2
                  Width = 200
                  Height = 21
                  HelpContext = 11153
                  TabOrder = 1
                  OnChange = edtAPIChange
                end
              end
              object shtNXCCommands: TTabSheet
                Caption = 'Commands'
                ImageIndex = 1
                object lstNXCCommands: TListBox
                  Left = 4
                  Top = 28
                  Width = 200
                  Height = 173
                  HelpContext = 11155
                  IntegralHeight = True
                  ItemHeight = 13
                  Sorted = True
                  TabOrder = 0
                  OnClick = lstAPIClick
                end
                object edtNXCCommand: TEdit
                  Left = 4
                  Top = 2
                  Width = 200
                  Height = 21
                  HelpContext = 11156
                  TabOrder = 1
                  OnChange = edtAPIChange
                end
              end
              object shtNXCConstants: TTabSheet
                Caption = 'Constants'
                ImageIndex = 2
                object lstNXCConstants: TListBox
                  Left = 4
                  Top = 28
                  Width = 200
                  Height = 173
                  HelpContext = 11158
                  IntegralHeight = True
                  ItemHeight = 13
                  Sorted = True
                  TabOrder = 0
                  OnClick = lstAPIClick
                end
                object edtNXCConstant: TEdit
                  Left = 4
                  Top = 2
                  Width = 200
                  Height = 21
                  HelpContext = 11159
                  TabOrder = 1
                  OnChange = edtAPIChange
                end
              end
            end
          end
        end
        object btnAddAPI: TButton
          Left = 233
          Top = 60
          Width = 75
          Height = 25
          HelpContext = 11160
          Caption = '&Add'
          TabOrder = 0
          OnClick = btnAddAPIClick
        end
        object btnDeleteAPI: TButton
          Left = 233
          Top = 92
          Width = 75
          Height = 25
          HelpContext = 11161
          Caption = '&Delete'
          TabOrder = 1
          OnClick = btnDeleteAPIClick
        end
      end
      object shtStartup: TTabSheet
        Caption = 'Start Up'
        object CheckShowForm: TRadioButton
          Left = 8
          Top = 8
          Width = 177
          Height = 17
          HelpContext = 11163
          Caption = '&Show startup form'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = CheckConnectClick
        end
        object CheckNoConnect: TRadioButton
          Left = 8
          Top = 24
          Width = 169
          Height = 17
          HelpContext = 11164
          Caption = '&Don'#39't connect to the brick'
          TabOrder = 1
          OnClick = CheckConnectClick
        end
        object CheckConnect: TRadioButton
          Left = 8
          Top = 40
          Width = 225
          Height = 17
          HelpContext = 11165
          Caption = '&Connect immediately to the brick'
          TabOrder = 2
          OnClick = CheckConnectClick
        end
        object grpDefValues: TGroupBox
          Left = 8
          Top = 61
          Width = 414
          Height = 173
          Caption = 'Default Values'
          TabOrder = 3
          object grpBrickType: TGroupBox
            Left = 176
            Top = 24
            Width = 156
            Height = 66
            Caption = 'Brick Type'
            Color = clBtnFace
            ParentColor = False
            TabOrder = 0
            object cboBrickType: TComboBox
              Left = 8
              Top = 16
              Width = 136
              Height = 21
              HelpContext = 11040
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 0
              Items.Strings = (
                'RCX'
                'CyberMaster'
                'Scout'
                'RCX2'
                'Spybot'
                'Swan'
                'NXT')
            end
          end
          object grpPorts: TGroupBox
            Left = 14
            Top = 24
            Width = 156
            Height = 66
            Caption = 'Port'
            Color = clBtnFace
            ParentColor = False
            TabOrder = 1
            object cboPort: TComboBox
              Left = 8
              Top = 16
              Width = 136
              Height = 21
              HelpContext = 11041
              ItemHeight = 13
              TabOrder = 0
              Items.Strings = (
                'Automatic'
                'usb')
            end
          end
          object grpFirmware: TGroupBox
            Left = 14
            Top = 96
            Width = 385
            Height = 57
            Caption = 'Firmware'
            TabOrder = 2
            object radStandard: TRadioButton
              Left = 8
              Top = 24
              Width = 69
              Height = 17
              HelpContext = 11191
              Caption = 'Standard'
              TabOrder = 0
            end
            object radBrickOS: TRadioButton
              Left = 83
              Top = 24
              Width = 69
              Height = 17
              HelpContext = 11192
              Caption = 'brickOS'
              TabOrder = 1
            end
            object radPBForth: TRadioButton
              Left = 157
              Top = 24
              Width = 69
              Height = 17
              HelpContext = 11193
              Caption = 'pbForth'
              TabOrder = 2
            end
            object radLejos: TRadioButton
              Left = 232
              Top = 24
              Width = 69
              Height = 17
              HelpContext = 11194
              Caption = 'leJOS'
              TabOrder = 3
            end
            object radOtherFirmware: TRadioButton
              Left = 306
              Top = 24
              Width = 69
              Height = 17
              HelpContext = 11195
              Caption = 'Other'
              TabOrder = 4
            end
          end
        end
        object chkFBAlwaysPrompt: TCheckBox
          Left = 8
          Top = 256
          Width = 297
          Height = 17
          HelpContext = 11196
          Caption = 'Al&ways prompt on Find Brick'
          TabOrder = 4
        end
      end
      object shtTemplates: TTabSheet
        Caption = 'Templates'
        object lblLangTemp: TLabel
          Left = 87
          Top = 8
          Width = 51
          Height = 13
          Caption = '&Language:'
          FocusControl = cboLangTemp
        end
        object InsertBtn: TButton
          Left = 8
          Top = 259
          Width = 57
          Height = 25
          HelpContext = 11199
          Caption = 'Insert'
          TabOrder = 2
          OnClick = InsertBtnClick
        end
        object ChangeBtn: TButton
          Left = 72
          Top = 259
          Width = 57
          Height = 25
          HelpContext = 11200
          Caption = 'Change'
          TabOrder = 3
          OnClick = ChangeBtnClick
        end
        object DeleteBtn: TButton
          Left = 136
          Top = 259
          Width = 57
          Height = 25
          HelpContext = 11201
          Caption = 'Delete'
          TabOrder = 4
          OnClick = DeleteBtnClick
        end
        object UpBtn: TBitBtn
          Left = 224
          Top = 259
          Width = 25
          Height = 25
          HelpContext = 11007
          TabOrder = 5
          OnClick = UpBtnClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003C3333339333
            337437FFF3337F3333F73CCC33339333344437773F337F33377733CCC3339337
            4447337F73FF7F3F337F33CCCCC3934444433373F7737F773373333CCCCC9444
            44733337F337773337F3333CCCCC9444443333373F337F3337333333CCCC9444
            473333337F337F337F333333CCCC94444333333373F37F33733333333CCC9444
            7333333337F37F37F33333333CCC944433333333373F7F373333333333CC9447
            33333333337F7F7F3333333333CC94433333333333737F7333333333333C9473
            33333333333737F333333333333C943333333333333737333333333333339733
            3333333333337F33333333333333933333333333333373333333}
          NumGlyphs = 2
        end
        object DownBtn: TBitBtn
          Left = 256
          Top = 259
          Width = 25
          Height = 25
          HelpContext = 11203
          TabOrder = 6
          OnClick = DownBtnClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333393333
            333333333337F3333333333333397333333333333337FF333333333333C94333
            3333333333737F333333333333C9473333333333337373F3333333333CC94433
            3333333337F7F7F3333333333CC94473333333333737F73F33333333CCC94443
            333333337F37F37F33333333CCC94447333333337337F373F333333CCCC94444
            33333337F337F337F333333CCCC94444733333373337F3373F3333CCCCC94444
            4333337F3337FF337F3333CCCCC94444473333733F7773FF73F33CCCCC393444
            443337F37737F773F7F33CCC33393374447337F73337F33737FFCCC333393333
            444377733337F333777FC3333339333337437333333733333373}
          NumGlyphs = 2
        end
        object cboLangTemp: TComboBox
          Left = 146
          Top = 4
          Width = 145
          Height = 21
          HelpContext = 11224
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnChange = cboLangTempChange
        end
        object btnSaveTemplates: TButton
          Left = 312
          Top = 259
          Width = 57
          Height = 25
          HelpContext = 11201
          Caption = 'Save'
          TabOrder = 7
          OnClick = btnSaveTemplatesClick
        end
        object btnLoadTemplates: TButton
          Left = 376
          Top = 259
          Width = 57
          Height = 25
          HelpContext = 11201
          Caption = 'Load'
          TabOrder = 8
          OnClick = btnLoadTemplatesClick
        end
        object NewTemplatesList2: TMemo
          Left = 8
          Top = 32
          Width = 425
          Height = 217
          Cursor = crIBeam
          HelpContext = 11005
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          HideSelection = False
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 1
          OnChange = NewTemplatesList2Change
          OnDblClick = TemplatesListDblClick
        end
      end
      object shtMacros: TTabSheet
        Caption = 'Macros'
        object MShift: TSpeedButton
          Left = 8
          Top = 259
          Width = 57
          Height = 25
          HelpContext = 11205
          AllowAllUp = True
          GroupIndex = 1
          Caption = '<Shift>'
          OnClick = MShiftClick
        end
        object ShiftMacrosList: TListBox
          Left = 8
          Top = 8
          Width = 425
          Height = 245
          HelpContext = 11206
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ItemHeight = 14
          ParentFont = False
          TabOrder = 0
          OnDblClick = ShiftMacrosListDblClick
        end
        object MacrosList: TListBox
          Left = 8
          Top = 8
          Width = 425
          Height = 245
          HelpContext = 11207
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ItemHeight = 14
          ParentFont = False
          TabOrder = 1
          OnDblClick = ShiftMacrosListDblClick
        end
        object MChange: TButton
          Left = 312
          Top = 259
          Width = 57
          Height = 25
          HelpContext = 11208
          Caption = 'Change'
          TabOrder = 2
          OnClick = MChangeClick
        end
        object MDelete: TButton
          Left = 376
          Top = 259
          Width = 57
          Height = 25
          HelpContext = 11209
          Caption = 'Delete'
          TabOrder = 3
          OnClick = MDeleteClick
        end
      end
      object shtColors: TTabSheet
        Caption = 'Color'
        ImageIndex = 5
        object lblElement: TLabel
          Left = 8
          Top = 33
          Width = 41
          Height = 13
          Caption = '&Element:'
        end
        object lblColor: TLabel
          Left = 170
          Top = 33
          Width = 84
          Height = 13
          Caption = 'Foreground &Color:'
        end
        object lblLanguages: TLabel
          Left = 87
          Top = 8
          Width = 51
          Height = 13
          Caption = '&Language:'
          FocusControl = cboLanguages
        end
        object Label5: TLabel
          Left = 170
          Top = 81
          Width = 88
          Height = 13
          Caption = 'Background &Color:'
        end
        object lbElements: TListBox
          Left = 8
          Top = 49
          Width = 145
          Height = 111
          HelpContext = 11008
          ItemHeight = 13
          TabOrder = 1
          OnClick = lbElementsClick
        end
        object grpTextAttributes: TGroupBox
          Left = 299
          Top = 33
          Width = 132
          Height = 73
          Caption = 'Text attributes:'
          TabOrder = 4
          object chkBold: TCheckBox
            Left = 8
            Top = 16
            Width = 97
            Height = 17
            HelpContext = 11217
            Caption = '&Bold'
            TabOrder = 0
            OnClick = chkBoldClick
          end
          object chkItalic: TCheckBox
            Left = 8
            Top = 32
            Width = 97
            Height = 17
            HelpContext = 11218
            Caption = '&Italic'
            TabOrder = 1
            OnClick = chkItalicClick
          end
          object chkUnderline: TCheckBox
            Left = 8
            Top = 48
            Width = 97
            Height = 17
            HelpContext = 11219
            Caption = '&Underline'
            TabOrder = 2
            OnClick = chkUnderlineClick
          end
        end
        object grpFGBG: TGroupBox
          Left = 299
          Top = 109
          Width = 132
          Height = 52
          Caption = 'Use defaults for:'
          TabOrder = 5
          object chkFG: TCheckBox
            Left = 8
            Top = 16
            Width = 91
            Height = 17
            HelpContext = 11222
            Caption = '&Foreground'
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = chkFGClick
          end
          object chkBG: TCheckBox
            Left = 8
            Top = 32
            Width = 91
            Height = 17
            HelpContext = 11223
            Caption = 'Back&ground'
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = chkBGClick
          end
        end
        object cboLanguages: TComboBox
          Left = 146
          Top = 4
          Width = 145
          Height = 21
          HelpContext = 11224
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnChange = cboLanguagesChange
        end
        object cbxFGColor: TColorBox
          Left = 168
          Top = 48
          Width = 121
          Height = 22
          ItemHeight = 16
          TabOrder = 2
          OnChange = cbxFGColorChange
        end
        object cbxBGColor: TColorBox
          Left = 168
          Top = 96
          Width = 121
          Height = 22
          ItemHeight = 16
          TabOrder = 3
          OnChange = cbxBGColorChange
        end
        object SynEditColors2: TMemo
          Left = 8
          Top = 166
          Width = 425
          Height = 118
          Cursor = crIBeam
          HelpContext = 11005
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          HideSelection = False
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 6
        end
      end
      object shtOptions: TTabSheet
        Caption = 'Options'
        ImageIndex = 7
        object grpGutter: TGroupBox
          Left = 8
          Top = 1
          Width = 265
          Height = 209
          Caption = 'Gutter'
          TabOrder = 0
          object lblGutterRightOffset: TLabel
            Left = 8
            Top = 116
            Width = 57
            Height = 13
            Caption = '&Right offset:'
            FocusControl = inpRightOffset
          end
          object lblGutterLeftOffset: TLabel
            Left = 8
            Top = 92
            Width = 50
            Height = 13
            Caption = 'L&eft offset:'
            FocusControl = inpLeftOffset
          end
          object lblGutterDigCnt: TLabel
            Left = 8
            Top = 68
            Width = 54
            Height = 13
            Caption = '&Digit count:'
            FocusControl = inpDigitCount
          end
          object lblGutterWidth: TLabel
            Left = 8
            Top = 44
            Width = 31
            Height = 13
            Caption = '&Width:'
            FocusControl = inpGutterWidth
          end
          object lblGutterColor: TLabel
            Left = 8
            Top = 20
            Width = 27
            Height = 13
            Caption = '&Color:'
          end
          object cbUseFontStyle: TCheckBox
            Left = 143
            Top = 169
            Width = 97
            Height = 17
            HelpContext = 11232
            Caption = '&Use font style'
            TabOrder = 10
          end
          object cbGutterVisible: TCheckBox
            Left = 143
            Top = 153
            Width = 97
            Height = 17
            HelpContext = 11233
            Caption = '&Visible'
            TabOrder = 9
          end
          object cbAutoSize: TCheckBox
            Left = 143
            Top = 137
            Width = 97
            Height = 17
            HelpContext = 11234
            Caption = 'Auto &size'
            TabOrder = 8
          end
          object cbLineNumbers: TCheckBox
            Left = 7
            Top = 137
            Width = 97
            Height = 17
            HelpContext = 11235
            Caption = 'Line &numbers'
            TabOrder = 4
          end
          object cbLeadingZeros: TCheckBox
            Left = 7
            Top = 153
            Width = 97
            Height = 17
            HelpContext = 11236
            Caption = '&Leading zeros'
            TabOrder = 5
          end
          object cbZeroStart: TCheckBox
            Left = 7
            Top = 169
            Width = 97
            Height = 17
            HelpContext = 11237
            Caption = '&Zero start'
            TabOrder = 6
          end
          object cbSelectOnClick: TCheckBox
            Left = 7
            Top = 185
            Width = 130
            Height = 17
            HelpContext = 11232
            Caption = 'Selec&t line on click'
            TabOrder = 7
            Visible = False
          end
          object cbxGutterColor: TColorBox
            Left = 80
            Top = 15
            Width = 128
            Height = 22
            ItemHeight = 16
            TabOrder = 11
          end
          object inpRightOffset: TSpinEdit
            Left = 80
            Top = 111
            Width = 60
            Height = 22
            HelpContext = 11238
            MaxLength = 2
            MaxValue = 99
            MinValue = 1
            TabOrder = 3
            Value = 2
          end
          object inpLeftOffset: TSpinEdit
            Left = 80
            Top = 87
            Width = 60
            Height = 22
            HelpContext = 11239
            MaxValue = 100
            MinValue = 0
            TabOrder = 2
            Value = 16
          end
          object inpDigitCount: TSpinEdit
            Left = 80
            Top = 64
            Width = 60
            Height = 22
            HelpContext = 11240
            MaxLength = 2
            MaxValue = 99
            MinValue = 1
            TabOrder = 1
            Value = 4
          end
          object inpGutterWidth: TSpinEdit
            Left = 80
            Top = 40
            Width = 60
            Height = 22
            HelpContext = 11241
            MaxValue = 100
            MinValue = 0
            TabOrder = 0
            Value = 2
          end
        end
        object btnKeystrokes: TButton
          Left = 280
          Top = 8
          Width = 158
          Height = 25
          HelpContext = 11243
          Caption = 'Edit &Keystrokes...'
          TabOrder = 1
          OnClick = btnKeystrokesClick
        end
        object btnEditCodeTemplates: TButton
          Left = 280
          Top = 40
          Width = 158
          Height = 25
          HelpContext = 11244
          Caption = 'Edit Code Te&mplates...'
          TabOrder = 2
          OnClick = btnEditCodeTemplatesClick
        end
        object btnClaimExt: TButton
          Left = 280
          Top = 72
          Width = 158
          Height = 25
          HelpContext = 11245
          Caption = 'Claim File E&xtensions'
          TabOrder = 3
          OnClick = btnClaimExtClick
        end
        object grpHotKeys: TGroupBox
          Left = 280
          Top = 104
          Width = 158
          Height = 177
          Caption = 'Other Hot Keys'
          TabOrder = 4
          object lblCodeComp: TLabel
            Left = 8
            Top = 16
            Width = 82
            Height = 13
            Caption = 'Code comple&tion:'
          end
          object lblParamComp: TLabel
            Left = 8
            Top = 56
            Width = 105
            Height = 13
            Caption = '&Parameter completion:'
          end
          object lblRecMacro: TLabel
            Left = 8
            Top = 96
            Width = 70
            Height = 13
            Caption = 'Rec&ord macro:'
          end
          object lblPlayMacro: TLabel
            Left = 8
            Top = 136
            Width = 79
            Height = 13
            Caption = 'Pla&yback macro:'
          end
          object hkCodeComp2: TEdit
            Left = 8
            Top = 32
            Width = 138
            Height = 21
            HelpContext = 11251
            TabOrder = 0
            Text = 'None'
          end
          object hkParamComp2: TEdit
            Left = 8
            Top = 72
            Width = 138
            Height = 21
            HelpContext = 11252
            TabOrder = 1
            Text = 'None'
          end
          object hkRecMacro2: TEdit
            Left = 8
            Top = 112
            Width = 138
            Height = 21
            HelpContext = 11253
            TabOrder = 2
            Text = 'None'
          end
          object hkPlayMacro2: TEdit
            Left = 8
            Top = 152
            Width = 138
            Height = 21
            HelpContext = 11254
            TabOrder = 3
            Text = 'None'
          end
        end
        object grpOther: TGroupBox
          Left = 8
          Top = 214
          Width = 265
          Height = 67
          Caption = 'Other'
          TabOrder = 5
          object chkNewMenu: TCheckBox
            Left = 7
            Top = 16
            Width = 250
            Height = 17
            Caption = 'Add file types to Explorer context menu'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
        end
      end
    end
  end
  object dlgFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [fdAnsiOnly, fdFixedPitchOnly, fdForceFontExist, fdNoVectorFonts]
    Left = 236
    Top = 144
  end
  object dlgLoadTemplates: TOpenDialog
    Filter = 'Template files (*.txt)|*.txt|All files (*.*)|*.*'
    Left = 229
    Top = 177
  end
  object dlgSaveTemplates: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Template files (*.txt)|*.txt|All files (*.*)|*.*'
    Left = 261
    Top = 177
  end
end
