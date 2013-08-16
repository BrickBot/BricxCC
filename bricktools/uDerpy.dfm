object Form1: TForm1
  Left = 192
  Top = 136
  Width = 928
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 216
    Top = 56
    Width = 585
    Height = 345
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object IdUDPServer1: TIdUDPServer
    OnStatus = IdUDPServer1Status
    Active = True
    BroadcastEnabled = True
    Bindings = <
      item
        IP = '0.0.0.0'
        Port = 3015
      end>
    DefaultPort = 3015
    OnUDPRead = IdUDPServer1UDPRead
    Left = 112
    Top = 176
  end
end
