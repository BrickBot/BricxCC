object frmVTConfig: TfrmVTConfig
  Left = 521
  Top = 136
  BorderStyle = bsDialog
  Caption = 'Configure Value Types'
  ClientHeight = 350
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 81
    Height = 13
    Caption = '&I2C Value Types:'
    FocusControl = lstValueTypes
  end
  object lstValueTypes: TListBox
    Left = 8
    Top = 32
    Width = 177
    Height = 284
    ItemHeight = 13
    TabOrder = 0
  end
  object grpVTDef: TGroupBox
    Left = 192
    Top = 16
    Width = 308
    Height = 300
    Caption = 'I2C Value Type Definition'
    TabOrder = 1
    object lblVTName: TLabel
      Left = 8
      Top = 28
      Width = 31
      Height = 13
      Caption = '&Name:'
      FocusControl = edtName
    end
    object lblRxCount: TLabel
      Left = 8
      Top = 77
      Width = 44
      Height = 13
      Caption = 'R&xCount:'
      FocusControl = edtIRxCount
    end
    object lblValue: TLabel
      Left = 8
      Top = 100
      Width = 53
      Height = 13
      Caption = '&Value type:'
      FocusControl = cboValueType
    end
    object lblSend: TLabel
      Left = 8
      Top = 120
      Width = 28
      Height = 13
      Caption = '&Send:'
      FocusControl = edtSend
    end
    object lblAddress: TLabel
      Left = 8
      Top = 52
      Width = 41
      Height = 13
      Caption = 'A&ddress:'
      FocusControl = edtAddress
    end
    object lblScript: TLabel
      Left = 8
      Top = 192
      Width = 30
      Height = 13
      Caption = 'S&cript:'
      FocusControl = edtScript
    end
    object edtName: TEdit
      Left = 100
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtIRxCount: TBricxccSpinEdit
      Left = 100
      Top = 72
      Width = 42
      Height = 22
      Hint = '0..16'
      MaxLength = 2
      MaxValue = 16
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object cboValueType: TComboBox
      Left = 100
      Top = 96
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 3
      Text = 'valByte'
      Items.Strings = (
        'valChar'
        'valByte'
        'valSmallInt'
        'valWord'
        'valInteger'
        'valCardinal'
        'valInt64'
        'valDouble'
        'valString')
    end
    object edtSend: TMemo
      Left = 100
      Top = 120
      Width = 121
      Height = 65
      Hint = 'e.g., 42 or 01,60'
      ScrollBars = ssBoth
      TabOrder = 4
      OnKeyPress = edtSendKeyPress
    end
    object edtAddress: TEdit
      Left = 100
      Top = 48
      Width = 42
      Height = 21
      Hint = 'e.g., 02 (hexadecimal - must be even)'
      MaxLength = 2
      TabOrder = 1
      OnKeyPress = edtAddressKeyPress
    end
    object edtScript: TMemo
      Left = 100
      Top = 192
      Width = 200
      Height = 100
      Hint = '(Data1*256+Data0)/1000'
      Lines.Strings = (
        'rt:=(Data0*256+Data1)*10/16'
        'result:=(rt/16)'
        'if(rt>20470)'
        'result:=result-2560')
      ScrollBars = ssBoth
      TabOrder = 5
    end
  end
  object btnOK: TButton
    Left = 344
    Top = 322
    Width = 75
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 424
    Top = 322
    Width = 75
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object btnAdd: TButton
    Left = 8
    Top = 322
    Width = 75
    Height = 24
    Caption = '&Add'
    TabOrder = 4
    OnClick = btnAddClick
  end
  object btnRemove: TButton
    Left = 88
    Top = 322
    Width = 75
    Height = 24
    Caption = '&Remove'
    TabOrder = 5
    OnClick = btnRemoveClick
  end
end
