object frmNXTScreen: TfrmNXTScreen
  Left = 302
  Top = 204
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'NeXT Screen'
  ClientHeight = 350
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = mnuMain
  OldCreateOrder = False
  PopupMenu = pmuMain
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object imgScreen: TImage
    Left = 6
    Top = 34
    Width = 400
    Height = 256
    PopupMenu = pmuMain
  end
  object Bevel1: TBevel
    Left = 0
    Top = 26
    Width = 414
    Height = 3
    Align = alTop
    Shape = bsTopLine
  end
  object lblNXTOff: TLabel
    Left = 8
    Top = 302
    Width = 130
    Height = 13
    Caption = 'The NXT is not responding.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object cbrScreenTop: TOfficeControlBar
    Left = 0
    Top = 0
    Width = 414
    Height = 26
    Align = alTop
    AutoDock = False
    AutoSize = True
    BevelInner = bvNone
    BevelOuter = bvNone
    BevelKind = bkNone
    Color = clBtnFace
    DockSite = False
    ParentBackground = False
    ParentColor = False
    RowSnap = False
    TabOrder = 0
    GradientFrom = clBtnFace
    GradientTo = clBtnFace
    BorderColor = clBlack
    object ogpNXTScreen: TOfficeGradientPanel
      Left = 11
      Top = 2
      Width = 230
      Height = 22
      GradientFrom = clBtnFace
      GradientTo = clBtnFace
      BorderColor = clBlack
      Horizontal = False
      Constraints.MinWidth = 22
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object osbCopy: TOfficeSpeedButton
        Left = 27
        Top = 0
        Width = 23
        Height = 22
        Hint = 'Copy to clipboard (Ctrl+C)'
        ResourceName = 'IMG_COPY'
        Align = alLeft
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = mniCopyClick
      end
      object osbSave: TOfficeSpeedButton
        Left = 0
        Top = 0
        Width = 23
        Height = 22
        Hint = 'Save to file (Ctrl+S)'
        ResourceName = 'IMG_SAVE'
        Align = alLeft
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = mniSaveClick
      end
      object bvlFile2: TBevel
        Left = 50
        Top = 0
        Width = 4
        Height = 22
        Align = alLeft
        Shape = bsSpacer
      end
      object Bevel2: TBevel
        Left = 170
        Top = 0
        Width = 4
        Height = 22
        Align = alLeft
        Shape = bsSpacer
      end
      object Bevel3: TBevel
        Left = 23
        Top = 0
        Width = 4
        Height = 22
        Align = alLeft
        Shape = bsSpacer
      end
      object osbPolling: TOfficeSpeedButton
        Left = 77
        Top = 0
        Width = 23
        Height = 22
        Hint = 'Polling (Ctrl+P)'
        ResourceName = 'IMG_REFRESH'
        Align = alLeft
        AllowAllUp = True
        GroupIndex = 1
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = mniPollClick
      end
      object Bevel4: TBevel
        Left = 100
        Top = 0
        Width = 4
        Height = 22
        Align = alLeft
        Shape = bsSpacer
      end
      object osbPollNow: TOfficeSpeedButton
        Left = 54
        Top = 0
        Width = 23
        Height = 22
        Hint = 'Poll now (Ctrl+N)'
        ResourceName = 'IMG_DIAGNOSTICS'
        Align = alLeft
        Flat = True
        ShowCaption = False
        NumGlyphs = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = tmrRefreshTimer
      end
      object pnlRates: TPanel
        Left = 104
        Top = 0
        Width = 66
        Height = 22
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object cboRates: TComboBox
          Left = 2
          Top = 0
          Width = 61
          Height = 21
          Hint = 'Refresh rate'
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 4
          TabOrder = 0
          Text = '1 sec'
          OnChange = cboRatesChange
          Items.Strings = (
            '50 ms'
            '100 ms'
            '200 ms'
            '500 ms'
            '1 sec'
            '2 sec'
            '5 sec'
            '10 sec'
            '20 sec'
            '1 min')
        end
      end
      object pnlScale: TPanel
        Left = 174
        Top = 0
        Width = 49
        Height = 22
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object cboScale: TComboBox
          Left = 2
          Top = 0
          Width = 39
          Height = 21
          Hint = 'Scale factor'
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 3
          TabOrder = 0
          Text = '4x'
          OnChange = cboScaleChange
          Items.Strings = (
            '1x'
            '2x'
            '3x'
            '4x')
        end
      end
    end
  end
  object btnLeft: TButton
    Tag = 1
    Left = 162
    Top = 296
    Width = 25
    Height = 25
    Caption = '<-'
    TabOrder = 1
    OnClick = NXTbuttonClick
  end
  object btnEnter: TButton
    Tag = 2
    Left = 194
    Top = 296
    Width = 25
    Height = 25
    TabOrder = 2
    OnClick = NXTbuttonClick
  end
  object btnRight: TButton
    Tag = 3
    Left = 226
    Top = 296
    Width = 25
    Height = 25
    Caption = '->'
    TabOrder = 3
    OnClick = NXTbuttonClick
  end
  object btnExit: TButton
    Tag = 4
    Left = 194
    Top = 328
    Width = 25
    Height = 17
    TabOrder = 4
    OnClick = NXTbuttonClick
  end
  object tmrRefresh: TTimer
    Enabled = False
    OnTimer = tmrRefreshTimer
    Left = 24
    Top = 112
  end
  object dlgSavePic: TSavePictureDialog
    OnTypeChange = dlgSavePicTypeChange
    Left = 256
    Top = 240
  end
  object mnuMain: TOfficeMainMenu
    Left = 176
    Top = 56
    object mniFile: TOfficeMenuItem
      Caption = '&File'
      object mniSave: TOfficeMenuItem
        Caption = '&Save...'
        ShortCut = 16467
        OnClick = mniSaveClick
      end
      object mniSep4: TOfficeMenuItem
        Caption = '-'
      end
      object mniExit: TOfficeMenuItem
        Caption = 'E&xit'
        OnClick = mniExitClick
      end
    end
    object mniEdit: TOfficeMenuItem
      Caption = '&Edit'
      object mniCopy: TOfficeMenuItem
        Caption = '&Copy'
        ShortCut = 16451
        OnClick = mniCopyClick
      end
    end
    object mniOptions: TOfficeMenuItem
      Caption = '&Options'
      object mniPollNow: TOfficeMenuItem
        Caption = 'Poll &Now'
        ShortCut = 16462
        OnClick = tmrRefreshTimer
      end
      object mniPoll: TOfficeMenuItem
        Caption = '&Polling'
        ShortCut = 16464
        OnClick = mniPollClick
      end
      object mniRefreshRate: TOfficeMenuItem
        Caption = '&Refresh Rate'
        OnClick = mniRefreshRateClick
        object mni50ms: TOfficeMenuItem
          Tag = 50
          Caption = '50 ms'
          RadioItem = True
          ShortCut = 16433
          OnClick = RefreshRateClick
        end
        object mni100ms: TOfficeMenuItem
          Tag = 100
          Caption = '100 ms'
          RadioItem = True
          ShortCut = 16434
          OnClick = RefreshRateClick
        end
        object mni200ms: TOfficeMenuItem
          Tag = 200
          Caption = '200 ms'
          RadioItem = True
          ShortCut = 16435
          OnClick = RefreshRateClick
        end
        object mni500ms: TOfficeMenuItem
          Tag = 500
          Caption = '500 ms'
          RadioItem = True
          ShortCut = 16436
          OnClick = RefreshRateClick
        end
        object mni1sec: TOfficeMenuItem
          Tag = 1000
          Caption = '1 sec'
          Checked = True
          RadioItem = True
          ShortCut = 16437
          OnClick = RefreshRateClick
        end
        object mni2sec: TOfficeMenuItem
          Tag = 2000
          Caption = '2 sec'
          RadioItem = True
          ShortCut = 16438
          OnClick = RefreshRateClick
        end
        object mni5sec: TOfficeMenuItem
          Tag = 5000
          Caption = '5 sec'
          RadioItem = True
          ShortCut = 16439
          OnClick = RefreshRateClick
        end
        object mni10sec: TOfficeMenuItem
          Tag = 10000
          Caption = '10 sec'
          RadioItem = True
          ShortCut = 16440
          OnClick = RefreshRateClick
        end
        object mni20sec: TOfficeMenuItem
          Tag = 20000
          Caption = '20 sec'
          RadioItem = True
          ShortCut = 16441
          OnClick = RefreshRateClick
        end
        object mni1min: TOfficeMenuItem
          Tag = 60000
          Caption = '1 min'
          RadioItem = True
          ShortCut = 16432
          OnClick = RefreshRateClick
        end
      end
      object mniSep1: TOfficeMenuItem
        Caption = '-'
      end
      object mniScale: TOfficeMenuItem
        Caption = '&Scale'
        OnClick = mniScaleClick
        object mni1x: TOfficeMenuItem
          Caption = '1x'
          RadioItem = True
          OnClick = ScaleClick
        end
        object mni2x: TOfficeMenuItem
          Caption = '2x'
          RadioItem = True
          OnClick = ScaleClick
        end
        object mni3x: TOfficeMenuItem
          Caption = '3x'
          RadioItem = True
          OnClick = ScaleClick
        end
        object mni4x: TOfficeMenuItem
          Caption = '4x'
          Checked = True
          RadioItem = True
          OnClick = ScaleClick
        end
      end
      object mniSep2: TOfficeMenuItem
        Caption = '-'
      end
      object mniDisplay: TOfficeMenuItem
        Caption = '&Display'
        object mniDisplayNormal: TOfficeMenuItem
          Caption = '&Normal'
          Checked = True
          RadioItem = True
          OnClick = mniPopupClick
        end
        object mniPopup: TOfficeMenuItem
          Caption = '&Popup'
          RadioItem = True
          OnClick = mniPopupClick
        end
      end
      object mniSep3: TOfficeMenuItem
        Caption = '-'
      end
      object mniPlayClicks: TOfficeMenuItem
        Caption = 'Play Clicks'
        Checked = True
      end
    end
  end
  object pmuMain: TOfficePopupMenu
    Left = 136
    Top = 176
    object mniPopSave: TOfficeMenuItem
      Caption = 'Save...'
      ShortCut = 16467
      OnClick = mniSaveClick
    end
    object mniPopCopy: TOfficeMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = mniCopyClick
    end
  end
end
