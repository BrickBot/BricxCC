object frmRICView: TfrmRICView
  Left = 329
  Top = 210
  Width = 371
  Height = 480
  Caption = 'RIC View'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grpPreview: TGroupBox
    Left = 0
    Top = 0
    Width = 363
    Height = 89
    Align = alTop
    Caption = 'Preview'
    TabOrder = 0
    object pnlImage: TPanel
      Left = 8
      Top = 16
      Width = 102
      Height = 66
      BevelInner = bvLowered
      BevelOuter = bvNone
      TabOrder = 0
      object imgRIC: TImage
        Left = 1
        Top = 1
        Width = 100
        Height = 64
        Align = alClient
      end
    end
  end
  object grpAsText: TGroupBox
    Left = 0
    Top = 89
    Width = 363
    Height = 357
    Align = alClient
    Caption = 'As Text'
    TabOrder = 1
    object mmoText: TMemo
      Left = 2
      Top = 15
      Width = 359
      Height = 299
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object pnlBottom: TPanel
      Left = 2
      Top = 314
      Width = 359
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btnCompile: TButton
        Left = 8
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Compile'
        TabOrder = 0
        OnClick = btnCompileClick
      end
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'ric'
    Filter = 'RIC Files (*.ric)|*.ric|All Files (*.*)|*.*'
    Title = 'Save RIC File'
    Left = 152
    Top = 361
  end
end
