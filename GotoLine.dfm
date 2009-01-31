object GotoForm: TGotoForm
  Left = 200
  Top = 100
  HelpContext = 46000
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Go to Line Number'
  ClientHeight = 88
  ClientWidth = 220
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGoto: TPanel
    Left = 8
    Top = 8
    Width = 204
    Height = 41
    Alignment = taLeftJustify
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = '  Enter Line Number:'
    TabOrder = 0
    object GotoLineField: TSpinEdit
      Left = 123
      Top = 9
      Width = 72
      Height = 22
      HelpContext = 46003
      MaxValue = 99999999
      MinValue = 1
      TabOrder = 0
      Value = 1
      OnExit = GotoLineFieldExit
      OnKeyDown = GotoLineFieldKeyDown
    end
  end
  object btnOK: TButton
    Left = 47
    Top = 56
    Width = 52
    Height = 25
    HelpContext = 46001
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 103
    Top = 56
    Width = 52
    Height = 25
    HelpContext = 46002
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 159
    Top = 56
    Width = 52
    Height = 25
    HelpContext = 46004
    Caption = '&Help'
    TabOrder = 3
    OnClick = btnHelpClick
  end
end
