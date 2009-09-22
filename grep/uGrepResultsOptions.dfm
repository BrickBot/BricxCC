object fmGrepResultsOptions: TfmGrepResultsOptions
  Left = 322
  Top = 238
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Grep Results Options'
  ClientHeight = 295
  ClientWidth = 317
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  DesignSize = (
    317
    295)
  PixelsPerInch = 96
  TextHeight = 14
  object gbxMatchList: TGroupBox
    Left = 9
    Top = 8
    Width = 298
    Height = 106
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Match Results List'
    TabOrder = 0
    DesignSize = (
      298
      106)
    object pnlListFont: TPanel
      Left = 48
      Top = 62
      Width = 197
      Height = 33
      BevelWidth = 2
      Caption = 'Match List Font...'
      Color = clWindow
      TabOrder = 2
      OnClick = pnlListFontClick
    end
    object chkGrepMiddle: TCheckBox
      Left = 12
      Top = 39
      Width = 277
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Jump to matches in the &middle of the editor'
      TabOrder = 1
    end
    object chkGrepExpandAll: TCheckBox
      Left = 12
      Top = 19
      Width = 277
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Expand all matches after searching'
      TabOrder = 0
    end
  end
  object gbxMatchContext: TGroupBox
    Left = 9
    Top = 124
    Width = 298
    Height = 132
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Match Context Display'
    TabOrder = 1
    object lblContextLines: TLabel
      Left = 48
      Top = 104
      Width = 132
      Height = 14
      Caption = 'Number of context lines'
    end
    object pnlContextFont: TPanel
      Left = 48
      Top = 21
      Width = 197
      Height = 33
      BevelWidth = 2
      Caption = 'Context Font...'
      Color = clWindow
      TabOrder = 0
      OnClick = pnlContextFontClick
    end
    object pnlMatchLineColor: TPanel
      Left = 48
      Top = 61
      Width = 197
      Height = 33
      BevelWidth = 2
      Caption = 'Match Font Color...'
      Color = clWindow
      TabOrder = 1
      OnClick = pnlMatchLineColorClick
    end
    object edtContextLines: TEdit
      Left = 187
      Top = 101
      Width = 46
      Height = 22
      TabOrder = 2
      Text = '1'
    end
    object udContextLines: TUpDown
      Left = 233
      Top = 101
      Width = 12
      Height = 22
      Associate = edtContextLines
      Min = 1
      Position = 1
      TabOrder = 3
    end
  end
  object btnOK: TButton
    Left = 147
    Top = 262
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 232
    Top = 262
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object dlgGrepListFont: TFontDialog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 255
    Top = 66
  end
  object dlgGrepContextFont: TFontDialog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Left = 256
    Top = 140
  end
  object dlgContextFontColor: TColorDialog
    Options = [cdSolidColor]
    Left = 255
    Top = 180
  end
end
