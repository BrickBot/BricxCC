object frmHIDDevices: TfrmHIDDevices
  Left = 192
  Top = 136
  BorderStyle = bsDialog
  Caption = 'HID Devices'
  ClientHeight = 442
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lstDeviceList: TListBox
    Left = 8
    Top = 8
    Width = 313
    Height = 425
    ItemHeight = 13
    TabOrder = 0
  end
  object btnConnect: TButton
    Left = 328
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 1
    OnClick = btnConnectClick
  end
  object btnDisconnect: TButton
    Left = 328
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 2
    OnClick = btnDisconnectClick
  end
  object btnRescan: TButton
    Left = 328
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Rescan'
    TabOrder = 3
    OnClick = btnRescanClick
  end
end
