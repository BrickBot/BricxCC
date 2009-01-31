object frmWindowList: TfrmWindowList
  Left = 252
  Top = 320
  Width = 200
  Height = 200
  HelpContext = 45000
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Window List'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 200
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 192
    Height = 139
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 6
    TabOrder = 0
    object lstWindows: TListBox
      Left = 6
      Top = 6
      Width = 180
      Height = 127
      HelpContext = 45001
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = lstWindowsDblClick
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 139
    Width = 192
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object pnlBotRight: TPanel
      Left = 16
      Top = 0
      Width = 176
      Height = 34
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnHelp: TButton
        Left = 118
        Top = 4
        Width = 52
        Height = 25
        HelpContext = 45004
        Caption = '&Help'
        TabOrder = 0
        OnClick = btnHelpClick
      end
      object btnCancel: TButton
        Left = 62
        Top = 4
        Width = 52
        Height = 25
        HelpContext = 45003
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
      object btnOK: TButton
        Left = 6
        Top = 4
        Width = 52
        Height = 25
        HelpContext = 45002
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 2
        OnClick = btnOKClick
      end
    end
    object pnlBotLeft: TPanel
      Left = 0
      Top = 0
      Width = 16
      Height = 34
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
end
