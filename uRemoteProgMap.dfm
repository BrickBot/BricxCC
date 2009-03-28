object frmRemoteProgMap: TfrmRemoteProgMap
  Left = 192
  Top = 130
  BorderStyle = bsDialog
  Caption = 'NXT Remote Map'
  ClientHeight = 196
  ClientWidth = 236
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblP1: TLabel
    Left = 8
    Top = 12
    Width = 16
    Height = 13
    Caption = 'P&1:'
    FocusControl = edtP1
  end
  object lblP2: TLabel
    Left = 8
    Top = 36
    Width = 16
    Height = 13
    Caption = 'P&2:'
    FocusControl = edtP2
  end
  object lblP3: TLabel
    Left = 8
    Top = 60
    Width = 16
    Height = 13
    Caption = 'P&3:'
    FocusControl = edtP3
  end
  object lblP4: TLabel
    Left = 8
    Top = 84
    Width = 16
    Height = 13
    Caption = 'P&4:'
    FocusControl = edtP4
  end
  object lblP5: TLabel
    Left = 8
    Top = 108
    Width = 16
    Height = 13
    Caption = 'P&5:'
    FocusControl = edtP5
  end
  object lblTone: TLabel
    Left = 8
    Top = 132
    Width = 28
    Height = 13
    Caption = '&Tone:'
    FocusControl = edtTone
  end
  object btnOK: TButton
    Left = 37
    Top = 160
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object btnCancel: TButton
    Left = 125
    Top = 160
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object edtP1: TComboBox
    Left = 48
    Top = 8
    Width = 177
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object edtP2: TComboBox
    Left = 48
    Top = 32
    Width = 177
    Height = 21
    ItemHeight = 13
    TabOrder = 1
  end
  object edtP3: TComboBox
    Left = 48
    Top = 56
    Width = 177
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
  object edtP4: TComboBox
    Left = 48
    Top = 80
    Width = 177
    Height = 21
    ItemHeight = 13
    TabOrder = 3
  end
  object edtP5: TComboBox
    Left = 48
    Top = 104
    Width = 177
    Height = 21
    ItemHeight = 13
    TabOrder = 4
  end
  object edtTone: TComboBox
    Left = 48
    Top = 128
    Width = 177
    Height = 21
    ItemHeight = 13
    TabOrder = 7
  end
end
