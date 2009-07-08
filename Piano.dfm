object PianoForm: TPianoForm
  Left = 328
  Top = 228
  HelpContext = 15
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Brick Piano'
  ClientHeight = 345
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -5
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblNoteTime: TLabel
    Left = 8
    Top = 229
    Width = 48
    Height = 13
    Caption = '&Note time:'
    FocusControl = edtNoteTime
  end
  object Label1: TLabel
    Left = 136
    Top = 229
    Width = 47
    Height = 13
    Caption = '&Wait time:'
    FocusControl = edtWaitTime
  end
  object Label2: TLabel
    Left = 8
    Top = 112
    Width = 53
    Height = 13
    Caption = '&Transpose:'
    FocusControl = barTranspose
  end
  object pnlKeyboard: TPanel
    Left = 8
    Top = 9
    Width = 337
    Height = 96
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    TabOrder = 0
    object Shape01: TShape
      Tag = 7
      Left = 96
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape03: TShape
      Tag = 9
      Left = 120
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape02: TShape
      Tag = 8
      Left = 112
      Top = 0
      Width = 17
      Height = 61
      Brush.Color = clBlack
      OnMouseDown = Shape01MouseDown
    end
    object Shape05: TShape
      Tag = 11
      Left = 144
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape06: TShape
      Tag = 12
      Left = 168
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape04: TShape
      Tag = 10
      Left = 136
      Top = 0
      Width = 17
      Height = 61
      Brush.Color = clBlack
      OnMouseDown = Shape01MouseDown
    end
    object Shape08: TShape
      Tag = 14
      Left = 192
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape10: TShape
      Tag = 16
      Left = 216
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape12: TShape
      Tag = 18
      Left = 240
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape07: TShape
      Tag = 13
      Left = 184
      Top = 0
      Width = 17
      Height = 61
      Brush.Color = clBlack
      OnMouseDown = Shape01MouseDown
    end
    object Shape09: TShape
      Tag = 15
      Left = 208
      Top = 0
      Width = 16
      Height = 61
      Brush.Color = clBlack
      OnMouseDown = Shape01MouseDown
    end
    object Shape11: TShape
      Tag = 17
      Left = 232
      Top = 0
      Width = 17
      Height = 61
      Brush.Color = clBlack
      OnMouseDown = Shape01MouseDown
    end
    object Shape13: TShape
      Tag = 19
      Left = 264
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape15: TShape
      Tag = 21
      Left = 288
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape17: TShape
      Tag = 23
      Left = 312
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape14: TShape
      Tag = 20
      Left = 280
      Top = 0
      Width = 17
      Height = 61
      Brush.Color = clBlack
      OnMouseDown = Shape01MouseDown
    end
    object Shape16: TShape
      Tag = 22
      Left = 304
      Top = 0
      Width = 17
      Height = 61
      Brush.Color = clBlack
      OnMouseDown = Shape01MouseDown
    end
    object Shape007: TShape
      Tag = 6
      Left = 72
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape005: TShape
      Tag = 4
      Left = 48
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape003: TShape
      Tag = 2
      Left = 24
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape001: TShape
      Left = 0
      Top = 0
      Width = 25
      Height = 97
      OnMouseDown = Shape01MouseDown
    end
    object Shape006: TShape
      Tag = 5
      Left = 64
      Top = 0
      Width = 17
      Height = 61
      Brush.Color = clBlack
      OnMouseDown = Shape01MouseDown
    end
    object Shape004: TShape
      Tag = 3
      Left = 40
      Top = 0
      Width = 17
      Height = 61
      Brush.Color = clBlack
      OnMouseDown = Shape01MouseDown
    end
    object Shape002: TShape
      Tag = 1
      Left = 16
      Top = 0
      Width = 17
      Height = 61
      Brush.Color = clBlack
      OnMouseDown = Shape01MouseDown
    end
  end
  object grpLength: TGroupBox
    Left = 56
    Top = 146
    Width = 113
    Height = 65
    Caption = ' Length '
    TabOrder = 3
    object radWhole: TRadioButton
      Tag = 16
      Left = 8
      Top = 16
      Width = 41
      Height = 17
      HelpContext = 15030
      Caption = '1/&1'
      TabOrder = 0
      OnClick = radWholeClick
    end
    object radHalf: TRadioButton
      Tag = 8
      Left = 8
      Top = 32
      Width = 41
      Height = 17
      HelpContext = 15031
      Caption = '1/&2'
      TabOrder = 1
      OnClick = radWholeClick
    end
    object radQuarter: TRadioButton
      Tag = 4
      Left = 56
      Top = 8
      Width = 41
      Height = 17
      HelpContext = 15032
      Caption = '1/&4'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = radWholeClick
    end
    object radEighth: TRadioButton
      Tag = 2
      Left = 56
      Top = 24
      Width = 41
      Height = 17
      HelpContext = 15033
      Caption = '1/&8'
      TabOrder = 3
      OnClick = radWholeClick
    end
    object radSixteenth: TRadioButton
      Tag = 1
      Left = 56
      Top = 40
      Width = 41
      Height = 17
      HelpContext = 15034
      Caption = '1/1&6'
      TabOrder = 4
      OnClick = radWholeClick
    end
  end
  object btnPlay: TButton
    Left = 184
    Top = 186
    Width = 73
    Height = 25
    HelpContext = 15035
    Caption = '&Play'
    TabOrder = 6
    OnClick = btnPlayClick
  end
  object btnSave: TButton
    Left = 272
    Top = 186
    Width = 73
    Height = 25
    HelpContext = 15036
    Caption = '&Save'
    TabOrder = 7
    OnClick = btnSaveClick
  end
  object TempMemo: TMemo
    Left = 176
    Top = 0
    Width = 97
    Height = 17
    TabStop = False
    Lines.Strings = (
      'TempMemo')
    TabOrder = 12
    Visible = False
  end
  object btnCopy: TButton
    Left = 272
    Top = 152
    Width = 73
    Height = 25
    HelpContext = 15038
    Caption = '&Copy'
    TabOrder = 5
    OnClick = btnCopyClick
  end
  object btnClear: TButton
    Left = 184
    Top = 152
    Width = 75
    Height = 25
    HelpContext = 15039
    Caption = 'C&lear'
    TabOrder = 4
    OnClick = btnClearClick
  end
  object btnRest: TBitBtn
    Left = 8
    Top = 153
    Width = 33
    Height = 57
    HelpContext = 15040
    Caption = '&rest'
    TabOrder = 2
    OnMouseDown = Shape01MouseDown
    Glyph.Data = {
      96010000424D9601000000000000760000002800000018000000180000000100
      0400000000002001000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFF
      FFFFFFF88FFFFFFFFFFFFFFFFFFFFF80FFFFFFFFFFFFFFFFFFFFFF08FFFFFFFF
      FFFFFFFFFFFFFF08FF7FFFFFFFFFFFFFFFFFFF00800FFFFFFFFFFFFFFFFFFF88
      807FFFFFFFFFFFFFFFFFFFFF88FFFFFFFFFFFFFFFFFFFFF80FFFFFFFFFFFFFFF
      FFFFFF700FFFFFFFFFFFFFFFFFFFFF8007FFFFFFFFFFFFFFFFFFFF0008FFFFFF
      FFFFFFFFFFFFFF70007FFFFFFFFFFFFFFFFFFFF80007FFFFFFFFFFFFFFFFFFFF
      008FFFFFFFFFFFFFFFFFFFFF007FFFFFFFFFFFFFFFFFFFF707FFFFFFFFFFFFFF
      FFFFFFF88FFFFFFFFFFFFFFFFFFFFF78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Layout = blGlyphTop
  end
  object barTranspose: TTrackBar
    Left = 8
    Top = 127
    Width = 337
    Height = 16
    Hint = '2'
    HelpContext = 15041
    Max = 6
    ParentShowHint = False
    PageSize = 1
    Position = 2
    ShowHint = True
    TabOrder = 1
    ThumbLength = 10
    OnChange = barTransposeChange
  end
  object grpCode: TGroupBox
    Left = 8
    Top = 250
    Width = 337
    Height = 87
    Caption = 'Language'
    TabOrder = 11
    object radGenNQC: TRadioButton
      Left = 8
      Top = 16
      Width = 86
      Height = 17
      HelpContext = 15045
      Caption = '&NQC'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radGenMS: TRadioButton
      Left = 8
      Top = 32
      Width = 86
      Height = 17
      HelpContext = 15046
      Caption = '&MindScript'
      TabOrder = 1
    end
    object radGenLASM: TRadioButton
      Left = 8
      Top = 48
      Width = 86
      Height = 17
      HelpContext = 15047
      Caption = '&LASM'
      TabOrder = 2
    end
    object radGenC: TRadioButton
      Left = 8
      Top = 64
      Width = 86
      Height = 17
      HelpContext = 15048
      Caption = '&C'
      TabOrder = 3
    end
    object radGenPascal: TRadioButton
      Left = 115
      Top = 16
      Width = 86
      Height = 17
      HelpContext = 15049
      Caption = '&Pascal'
      TabOrder = 4
    end
    object radGenForth: TRadioButton
      Left = 115
      Top = 32
      Width = 86
      Height = 17
      HelpContext = 15050
      Caption = '&Forth'
      TabOrder = 5
    end
    object radGenJava: TRadioButton
      Left = 115
      Top = 48
      Width = 86
      Height = 17
      HelpContext = 15051
      Caption = '&Java'
      TabOrder = 6
    end
    object radGenNBC: TRadioButton
      Left = 115
      Top = 64
      Width = 86
      Height = 17
      HelpContext = 15052
      Caption = 'N&BC'
      TabOrder = 7
    end
    object radGenNXTMelody: TRadioButton
      Left = 226
      Top = 32
      Width = 86
      Height = 17
      HelpContext = 15054
      Caption = 'NXT Melo&dy'
      TabOrder = 9
    end
    object radGenNXC: TRadioButton
      Left = 226
      Top = 16
      Width = 86
      Height = 17
      HelpContext = 15053
      Caption = 'N&XC'
      TabOrder = 8
    end
  end
  object btnHelp: TButton
    Left = 272
    Top = 223
    Width = 73
    Height = 25
    HelpContext = 15055
    Caption = '&Help'
    TabOrder = 10
    OnClick = btnHelpClick
  end
  object edtNoteTime: TBricxccSpinEdit
    Left = 64
    Top = 224
    Width = 57
    Height = 22
    HelpContext = 15042
    MaxLength = 2
    MaxValue = 99
    MinValue = 1
    TabOrder = 8
    Value = 10
  end
  object edtWaitTime: TBricxccSpinEdit
    Left = 192
    Top = 224
    Width = 57
    Height = 22
    HelpContext = 15043
    MaxLength = 2
    MaxValue = 99
    MinValue = 1
    TabOrder = 9
    Value = 12
  end
end
