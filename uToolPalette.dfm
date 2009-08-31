object frmNXTTools: TfrmNXTTools
  Left = 366
  Top = 144
  BorderStyle = bsDialog
  Caption = 'NeXT Tools'
  ClientHeight = 70
  ClientWidth = 906
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 51
    Width = 906
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 906
    Height = 50
    AutoSize = True
    ButtonHeight = 48
    ButtonWidth = 48
    Caption = 'NeXT Tools'
    Flat = True
    Images = imgList
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actControl
    end
    object ToolButton2: TToolButton
      Left = 48
      Top = 0
      Action = actDiagnose
    end
    object ToolButton3: TToolButton
      Left = 96
      Top = 0
      Action = actWatch
    end
    object ToolButton4: TToolButton
      Left = 144
      Top = 0
      Action = actPiano
    end
    object ToolButton5: TToolButton
      Left = 192
      Top = 0
      Action = actJoystick
    end
    object ToolButton6: TToolButton
      Left = 240
      Top = 0
      Action = actRemote
    end
    object ToolButton19: TToolButton
      Left = 288
      Top = 0
      Action = actExplorer
    end
    object ToolButton20: TToolButton
      Left = 336
      Top = 0
      Action = actScreen
    end
    object ToolButton18: TToolButton
      Left = 384
      Top = 0
      Width = 8
      Caption = 'ToolButton18'
      ImageIndex = 17
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 392
      Top = 0
      Action = actMessage
    end
    object ToolButton8: TToolButton
      Left = 440
      Top = 0
      Action = actMemory
    end
    object ToolButton21: TToolButton
      Left = 488
      Top = 0
      Action = actClear
    end
    object ToolButton16: TToolButton
      Left = 536
      Top = 0
      Action = actMIDIConvert
    end
    object ToolButton17: TToolButton
      Left = 584
      Top = 0
      Action = actRSOConvert
    end
    object ToolButton22: TToolButton
      Left = 632
      Top = 0
      Width = 8
      Caption = 'ToolButton22'
      ImageIndex = 17
      Style = tbsSeparator
    end
    object ToolButton9: TToolButton
      Left = 640
      Top = 0
      Action = actFindBrick
    end
    object ToolButton10: TToolButton
      Left = 688
      Top = 0
      Action = actTurnOff
    end
    object ToolButton11: TToolButton
      Left = 736
      Top = 0
      Action = actCloseComm
    end
    object ToolButton23: TToolButton
      Left = 784
      Top = 0
      Width = 8
      Caption = 'ToolButton23'
      ImageIndex = 15
      Style = tbsSeparator
    end
    object ToolButton12: TToolButton
      Left = 792
      Top = 0
      Action = actFirmware
    end
    object ToolButton13: TToolButton
      Left = 840
      Top = 0
      Action = actCode
    end
  end
  object imgList: TImageList
    Height = 24
    Width = 24
    Left = 312
    Top = 8
  end
  object alMain: TActionList
    Images = imgList
    OnUpdate = alMainUpdate
    Left = 384
    Top = 8
    object actControl: TAction
      Caption = 'Direct control'
      Hint = 'Direct control'
      ImageIndex = 0
      OnExecute = actControlExecute
    end
    object actDiagnose: TAction
      Caption = 'Diagnostics'
      Hint = 'Diagnostics'
      ImageIndex = 1
      OnExecute = actDiagnoseExecute
    end
    object actWatch: TAction
      Caption = 'Watching the brick'
      Hint = 'Watching the brick'
      ImageIndex = 2
      OnExecute = actWatchExecute
    end
    object actPiano: TAction
      Caption = 'Brick piano'
      Hint = 'Brick piano'
      ImageIndex = 3
      OnExecute = actPianoExecute
    end
    object actJoystick: TAction
      Caption = 'Brick joystick'
      Hint = 'Brick joystick'
      ImageIndex = 4
      OnExecute = actJoystickExecute
    end
    object actRemote: TAction
      Caption = 'Remote'
      Hint = 'Remote'
      ImageIndex = 5
      OnExecute = actRemoteExecute
    end
    object actMessage: TAction
      Caption = 'Send messages'
      Hint = 'Send messages'
      ImageIndex = 6
      OnExecute = actMessageExecute
    end
    object actMemory: TAction
      Caption = 'Memory map'
      Hint = 'Memory map'
      ImageIndex = 7
      OnExecute = actMemoryExecute
    end
    object actFindBrick: TAction
      Caption = 'Find brick'
      Hint = 'Find brick'
      ImageIndex = 8
      OnExecute = actFindBrickExecute
    end
    object actTurnOff: TAction
      Caption = 'Turn brick off'
      Hint = 'Turn brick off'
      ImageIndex = 9
      OnExecute = actTurnOffExecute
    end
    object actCloseComm: TAction
      Caption = 'Close communication'
      Hint = 'Close communication'
      ImageIndex = 10
      OnExecute = actCloseCommExecute
    end
    object actExplorer: TAction
      Caption = 'NXT Explorer'
      Hint = 'NXT Explorer'
      ImageIndex = 14
      OnExecute = actExplorerExecute
    end
    object actScreen: TAction
      Caption = 'NXT Screen'
      Hint = 'NXT Screen'
      ImageIndex = 13
      OnExecute = actScreenExecute
    end
    object actMIDIConvert: TAction
      Caption = 'MIDI Conversion...'
      Hint = 'MIDI Conversion'
      ImageIndex = 15
      OnExecute = actMIDIConvertExecute
    end
    object actRSOConvert: TAction
      Caption = 'Sound Conversion...'
      Hint = 'Sound Conversion'
      ImageIndex = 16
      OnExecute = actRSOConvertExecute
    end
    object actFirmware: TAction
      Caption = 'Download firmware...'
      Hint = 'Download firmware'
      ImageIndex = 11
      OnExecute = actFirmwareExecute
    end
    object actCode: TAction
      Caption = 'Code editor'
      Hint = 'Code editor'
      ImageIndex = 12
      OnExecute = actCodeExecute
    end
    object actClear: TAction
      Caption = 'Clear memory'
      Hint = 'Clear memory'
      ImageIndex = 17
      OnExecute = actClearExecute
    end
  end
  object dlgOpenFirmware: TOpenDialog
    DefaultExt = 'rfw'
    FileName = 'LEGO MINDSTORMS NXT Firmware V1.28.rfw'
    Filter = 
      'Lego NXT Firmware (*.rfw)|*.rfw|Alternate NXT Firmware files (*.' +
      'a79)|*.a79|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Choose the Firmware file'
    Left = 184
    Top = 8
  end
  object MainMenu1: TMainMenu
    Images = imgList
    Left = 488
    Top = 24
    object File1: TMenuItem
      Caption = 'File'
      object Codeeditor1: TMenuItem
        Action = actCode
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
    object ools1: TMenuItem
      Caption = 'Tools'
      object Directcontrol1: TMenuItem
        Action = actControl
      end
      object Diagnostics1: TMenuItem
        Action = actDiagnose
      end
      object Watchingthebrick1: TMenuItem
        Action = actWatch
      end
      object Brickpiano1: TMenuItem
        Action = actPiano
      end
      object Brickjoystick1: TMenuItem
        Action = actJoystick
      end
      object Remote1: TMenuItem
        Action = actRemote
      end
      object NXTExplorer1: TMenuItem
        Action = actExplorer
      end
      object NXTScreen1: TMenuItem
        Action = actScreen
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sendmessages1: TMenuItem
        Action = actMessage
      end
      object Memorymap1: TMenuItem
        Action = actMemory
      end
      object Clearmemory1: TMenuItem
        Action = actClear
      end
      object MIDIConversion1: TMenuItem
        Action = actMIDIConvert
      end
      object SoundConversion1: TMenuItem
        Action = actRSOConvert
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Findbrick1: TMenuItem
        Action = actFindBrick
      end
      object urnbrickoff1: TMenuItem
        Action = actTurnOff
      end
      object Closecommunication1: TMenuItem
        Action = actCloseComm
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Downloadfirmware1: TMenuItem
        Action = actFirmware
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object About1: TMenuItem
        Caption = '&About NeXT Tools...'
        OnClick = About1Click
      end
    end
  end
end
