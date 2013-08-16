object frmAddText: TfrmAddText
  Left = 296
  Top = 184
  BorderIcons = [biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Add Text'
  ClientHeight = 321
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label_FontSize: TLabel
    Left = 242
    Top = 8
    Width = 42
    Height = 13
    Caption = 'Font size'
    Color = clBtnFace
    ParentColor = False
  end
  object Lavel_Font: TLabel
    Left = 298
    Top = 8
    Width = 21
    Height = 13
    Caption = 'Font'
    Color = clBtnFace
    ParentColor = False
  end
  object Label_Text: TLabel
    Left = 8
    Top = 8
    Width = 21
    Height = 13
    Caption = 'Text'
    Color = clBtnFace
    ParentColor = False
  end
  object Memo_Text: TMemo
    Left = 8
    Top = 24
    Width = 225
    Height = 113
    TabOrder = 0
    OnChange = Memo_TextChange
  end
  object ComboBox_FontName: TComboBox
    Left = 298
    Top = 24
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'Arial'
    OnChange = ComboBox_FontNameChange
  end
  object BitBtn1: TBitBtn
    Left = 242
    Top = 192
    Width = 97
    Height = 49
    TabOrder = 3
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 346
    Top = 192
    Width = 97
    Height = 49
    TabOrder = 4
    Kind = bkCancel
  end
  object GroupBox_Preview: TGroupBox
    Left = 8
    Top = 152
    Width = 222
    Height = 157
    Caption = 'Preview'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object Image_Preview: TImage
      Left = 21
      Top = 19
      Width = 178
      Height = 128
    end
  end
  object GroupBox_TextStyle: TGroupBox
    Left = 242
    Top = 56
    Width = 201
    Height = 89
    Caption = 'Text style'
    TabOrder = 6
    object CheckBox_Italic: TCheckBox
      Left = 12
      Top = 18
      Width = 42
      Height = 19
      Caption = 'Italic'
      TabOrder = 0
      OnClick = CheckBox_ItalicClick
    end
    object CheckBox_Underline: TCheckBox
      Left = 12
      Top = 38
      Width = 65
      Height = 19
      Caption = 'Underline'
      TabOrder = 1
      OnClick = CheckBox_UnderlineClick
    end
    object CheckBox_StrikeOut: TCheckBox
      Left = 12
      Top = 58
      Width = 65
      Height = 19
      Caption = 'Strike out'
      TabOrder = 2
      OnClick = CheckBox_StrikeOutClick
    end
  end
  object SpinEdit_FontSize: TBricxccSpinEdit
    Left = 242
    Top = 24
    Width = 49
    Height = 24
    MaxValue = 128
    MinValue = 1
    TabOrder = 1
    Value = 8
    OnChange = SpinEdit_FontSizeChange
  end
end
