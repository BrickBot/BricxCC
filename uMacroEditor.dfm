object frmMacroEditor: TfrmMacroEditor
  Left = 429
  Top = 328
  Width = 330
  Height = 378
  HelpContext = 33000
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Macro Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 313
    Width = 322
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object pnlBotRight: TPanel
      Left = 80
      Top = 0
      Width = 242
      Height = 31
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        242
        31)
      object btnCancel: TButton
        Left = 83
        Top = 3
        Width = 75
        Height = 25
        HelpContext = 33001
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 0
      end
      object btnOK: TButton
        Left = 4
        Top = 3
        Width = 75
        Height = 25
        HelpContext = 33002
        Caption = 'OK'
        ModalResult = 1
        TabOrder = 1
      end
      object btnHelp: TButton
        Left = 163
        Top = 3
        Width = 75
        Height = 25
        HelpContext = 33004
        Anchors = [akTop, akRight]
        Caption = '&Help'
        TabOrder = 2
        OnClick = btnHelpClick
      end
    end
    object pnlBotLeft: TPanel
      Left = 0
      Top = 0
      Width = 80
      Height = 31
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 322
    Height = 313
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 6
    TabOrder = 1
  end
end
