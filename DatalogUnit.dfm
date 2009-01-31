object DatalogForm: TDatalogForm
  Left = 237
  Top = 150
  HelpContext = 19
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Datalog'
  ClientHeight = 328
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 208
    Top = 40
    Width = 82
    Height = 13
    Caption = 'Set Datalog Size:'
  end
  object DatalogMemo: TMemo
    Left = 8
    Top = 8
    Width = 185
    Height = 313
    HelpContext = 19002
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object UploadBtn: TButton
    Left = 208
    Top = 8
    Width = 83
    Height = 25
    HelpContext = 19003
    Caption = '&Upload Datalog'
    Default = True
    TabOrder = 1
    OnClick = UploadBtnClick
  end
  object ClearBtn: TButton
    Left = 208
    Top = 85
    Width = 81
    Height = 25
    HelpContext = 19004
    Caption = '&Clear Datalog'
    TabOrder = 3
    OnClick = ClearBtnClick
  end
  object SizeBox: TComboBox
    Left = 208
    Top = 56
    Width = 81
    Height = 21
    HelpContext = 19005
    ItemHeight = 13
    TabOrder = 2
    OnChange = SizeBoxChange
    Items.Strings = (
      '10'
      '20'
      '50'
      '100'
      '200'
      '500'
      '1000')
  end
  object SaveBtn: TButton
    Left = 208
    Top = 232
    Width = 81
    Height = 25
    HelpContext = 19006
    Caption = '&Save'
    TabOrder = 7
    OnClick = SaveBtnClick
  end
  object btnAnalyze: TButton
    Left = 208
    Top = 125
    Width = 81
    Height = 25
    HelpContext = 19007
    Caption = '&Analyze'
    Enabled = False
    TabOrder = 4
    OnClick = btnAnalyzeClick
  end
  object btnAnalyzeXY: TButton
    Left = 208
    Top = 180
    Width = 81
    Height = 25
    HelpContext = 19008
    Caption = '&XY Analyze'
    Enabled = False
    TabOrder = 6
    OnClick = btnAnalyzeXYClick
  end
  object btnLoad: TButton
    Left = 208
    Top = 264
    Width = 81
    Height = 25
    HelpContext = 19009
    Caption = '&Load'
    TabOrder = 8
    OnClick = btnLoadClick
  end
  object chkRelativeTime: TCheckBox
    Left = 208
    Top = 157
    Width = 89
    Height = 17
    HelpContext = 19010
    Caption = 'Relative time'
    TabOrder = 5
  end
  object btnHelp: TButton
    Left = 208
    Top = 296
    Width = 81
    Height = 25
    HelpContext = 19011
    Caption = '&Help'
    TabOrder = 9
    OnClick = btnHelpClick
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'datalog.txt'
    Filter = 'Text Files (*.txt)|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Title = 'Save Datalog'
    Left = 240
    Top = 240
  end
  object dlgOpen: TOpenDialog
    Filter = 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 208
    Top = 240
  end
end
