object frmHIDDevices: TfrmHIDDevices
  Left = 192
  Top = 136
  Width = 425
  Height = 480
  Caption = 'HID Devices'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    409
    442)
  PixelsPerInch = 96
  TextHeight = 13
  object lstDeviceList: TListBox
    Left = 8
    Top = 8
    Width = 313
    Height = 337
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object btnConnect: TButton
    Left = 328
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Connect'
    TabOrder = 1
    OnClick = btnConnectClick
  end
  object btnDisconnect: TButton
    Left = 328
    Top = 40
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Disconnect'
    Enabled = False
    TabOrder = 2
    OnClick = btnDisconnectClick
  end
  object btnRescan: TButton
    Left = 328
    Top = 72
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Rescan'
    TabOrder = 3
    OnClick = btnRescanClick
  end
  object edtMessages: TMemo
    Left = 8
    Top = 352
    Width = 313
    Height = 81
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 4
  end
end
