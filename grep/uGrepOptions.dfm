object fmGrepOptions: TfmGrepOptions
  Left = 294
  Top = 263
  BorderStyle = bsDialog
  Caption = 'Grep Search Options'
  ClientHeight = 104
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  DesignSize = (
    400
    104)
  PixelsPerInch = 96
  TextHeight = 14
  object gbxOptions: TGroupBox
    Left = 8
    Top = 8
    Width = 383
    Height = 55
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Grep Options'
    TabOrder = 0
    DesignSize = (
      383
      55)
    object chkGrepUseCurrentIdent: TCheckBox
      Left = 12
      Top = 22
      Width = 361
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Use &current editor identifier as the default search string'
      TabOrder = 0
    end
  end
  object btnOK: TButton
    Left = 233
    Top = 72
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 316
    Top = 72
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
