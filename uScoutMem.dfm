object Form1: TForm1
  Left = 267
  Top = 231
  BorderStyle = bsDialog
  Caption = 'Scout Memory'
  ClientHeight = 271
  ClientWidth = 340
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
  object Label1: TLabel
    Left = 8
    Top = 17
    Width = 22
    Height = 13
    Caption = 'Port:'
  end
  object Memo1: TMemo
    Left = 8
    Top = 48
    Width = 321
    Height = 217
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object Button1: TButton
    Left = 129
    Top = 11
    Width = 97
    Height = 25
    Caption = 'Mark Memory'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 209
    Top = 184
    Width = 97
    Height = 25
    Caption = 'Modify'
    TabOrder = 1
    Visible = False
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 233
    Top = 11
    Width = 97
    Height = 25
    Caption = 'Compare Memory'
    TabOrder = 2
    OnClick = Button3Click
  end
  object cboPort: TComboBox
    Left = 40
    Top = 13
    Width = 57
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnChange = cboPortChange
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8')
  end
  object PopupMenu1: TPopupMenu
    OwnerDraw = True
    Left = 112
    Top = 152
    object Copy1: TMenuItem
      Caption = 'Copy'
      OnClick = Copy1Click
    end
    object SelectAll1: TMenuItem
      Caption = 'Select All'
      OnClick = SelectAll1Click
    end
    object CopyToClipboard1: TMenuItem
      Caption = 'Formatted Copy To Clipboard'
      OnClick = CopyToClipboard1Click
    end
  end
end
