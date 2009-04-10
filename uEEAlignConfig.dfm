object frmAlignOptions: TfrmAlignOptions
  Left = 268
  Top = 200
  BorderStyle = bsDialog
  Caption = 'Align Options'
  ClientHeight = 353
  ClientWidth = 245
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  DesignSize = (
    245
    353)
  PixelsPerInch = 96
  TextHeight = 13
  object gbxTokens: TGroupBox
    Left = 8
    Top = 6
    Width = 229
    Height = 246
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Tokens to Align On'
    TabOrder = 0
    DesignSize = (
      229
      246)
    object mmoTokens: TMemo
      Left = 11
      Top = 20
      Width = 205
      Height = 215
      Anchors = [akLeft, akTop, akRight, akBottom]
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
    end
  end
  object btnOK: TButton
    Left = 65
    Top = 320
    Width = 80
    Height = 26
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 157
    Top = 320
    Width = 80
    Height = 26
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object gbxOptions: TGroupBox
    Left = 8
    Top = 258
    Width = 229
    Height = 54
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Options'
    TabOrder = 1
    object lblWhitespace: TLabel
      Left = 15
      Top = 22
      Width = 115
      Height = 13
      Caption = 'Minimum leading spaces'
      FocusControl = edtWhitespace
    end
    object edtWhitespace: TSpinEdit
      Left = 152
      Top = 18
      Width = 63
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
  end
end
