object frmNXTName: TfrmNXTName
  Left = 192
  Top = 145
  BorderStyle = bsDialog
  Caption = 'Set Brick Name'
  ClientHeight = 62
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblNXTName: TLabel
    Left = 8
    Top = 10
    Width = 58
    Height = 13
    Caption = 'Brick &Name:'
    FocusControl = edtNXTName
  end
  object btnOK: TButton
    Left = 50
    Top = 33
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 130
    Top = 33
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object edtNXTName: TEdit
    Left = 90
    Top = 6
    Width = 158
    Height = 21
    MaxLength = 8
    TabOrder = 0
  end
end
