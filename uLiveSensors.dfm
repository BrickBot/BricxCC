object frmLiveSensors: TfrmLiveSensors
  Left = 222
  Top = 200
  BorderIcons = [biSystemMenu, biMinimize, biHelp]
  BorderStyle = bsToolWindow
  Caption = 'Live Sensors'
  ClientHeight = 244
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pagDevices: TPageControl
    Left = 0
    Top = 0
    Width = 316
    Height = 244
    ActivePage = shtLayer1
    Align = alClient
    TabOrder = 0
    object shtLayer1: TTabSheet
      Caption = 'Layer 1'
    end
    object shtLayer2: TTabSheet
      Caption = 'Layer 2'
      ImageIndex = 1
    end
    object shtLayer3: TTabSheet
      Caption = 'Layer 3'
      ImageIndex = 2
    end
    object shtLayer4: TTabSheet
      Caption = 'Layer 4'
      ImageIndex = 3
    end
  end
  object tmrRefresh: TTimer
    Enabled = False
    OnTimer = tmrRefreshTimer
    Left = 228
    Top = 136
  end
  object actMain: TActionList
    Left = 160
    Top = 40
    object act100ms: TAction
      Tag = 100
      Category = 'Refresh'
      Caption = '100 ms'
      GroupIndex = 2
      Hint = '100 ms'
      ShortCut = 16434
      OnExecute = actRefreshExecute
    end
    object act200ms: TAction
      Tag = 200
      Category = 'Refresh'
      Caption = '200 ms'
      GroupIndex = 2
      Hint = '200 ms'
      ShortCut = 16435
      OnExecute = actRefreshExecute
    end
    object act500ms: TAction
      Tag = 500
      Category = 'Refresh'
      Caption = '500 ms'
      GroupIndex = 2
      Hint = '500 ms'
      ShortCut = 16436
      OnExecute = actRefreshExecute
    end
    object act1sec: TAction
      Tag = 1000
      Category = 'Refresh'
      Caption = '1 sec'
      Checked = True
      GroupIndex = 2
      Hint = '1 sec'
      ShortCut = 16437
      OnExecute = actRefreshExecute
    end
    object act2sec: TAction
      Tag = 2000
      Category = 'Refresh'
      Caption = '2 sec'
      GroupIndex = 2
      Hint = '2 sec'
      ShortCut = 16438
      OnExecute = actRefreshExecute
    end
    object act5sec: TAction
      Tag = 5000
      Category = 'Refresh'
      Caption = '5 sec'
      GroupIndex = 2
      Hint = '5 sec'
      ShortCut = 16439
      OnExecute = actRefreshExecute
    end
    object act10sec: TAction
      Tag = 10000
      Category = 'Refresh'
      Caption = '10 sec'
      GroupIndex = 2
      Hint = '10 sec'
      ShortCut = 16440
      OnExecute = actRefreshExecute
    end
    object actPollNow: TAction
      Category = 'Main'
      Caption = 'Poll &Now'
      Hint = 'Poll now'
      ShortCut = 16462
      OnExecute = actPollNowExecute
    end
    object actPolling: TAction
      Category = 'Main'
      Caption = '&Polling'
      GroupIndex = 1
      ShortCut = 16464
      OnExecute = actPollingExecute
    end
    object actMode0: TAction
      Category = 'Modes'
      Caption = 'Mode 0'
      GroupIndex = 3
      OnExecute = actSensorModeExecute
    end
    object actMode1: TAction
      Tag = 1
      Category = 'Modes'
      Caption = 'Mode 1'
      OnExecute = actSensorModeExecute
    end
    object actMode2: TAction
      Tag = 2
      Category = 'Modes'
      Caption = 'Mode 2'
      OnExecute = actSensorModeExecute
    end
    object actMode3: TAction
      Tag = 3
      Category = 'Modes'
      Caption = 'Mode3'
      OnExecute = actSensorModeExecute
    end
    object actMode4: TAction
      Tag = 4
      Category = 'Modes'
      Caption = 'Mode 4'
      OnExecute = actSensorModeExecute
    end
    object actMode5: TAction
      Tag = 5
      Category = 'Modes'
      Caption = 'Mode 5'
      OnExecute = actSensorModeExecute
    end
    object actMode6: TAction
      Tag = 6
      Category = 'Modes'
      Caption = 'Mode 6'
      OnExecute = actSensorModeExecute
    end
    object actMode7: TAction
      Tag = 7
      Category = 'Modes'
      Caption = 'Mode 7'
      OnExecute = actSensorModeExecute
    end
  end
end
