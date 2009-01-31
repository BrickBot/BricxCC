object frmRICLoader: TfrmRICLoader
  Left = 192
  Top = 205
  Width = 550
  Height = 298
  Caption = 'RIC Loader'
  Color = clBtnFace
  Constraints.MinHeight = 298
  Constraints.MinWidth = 550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    542
    264)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOpen: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Open...'
    TabOrder = 0
    OnClick = btnOpenClick
  end
  object pagMain: TPageControl
    Left = 96
    Top = 8
    Width = 438
    Height = 195
    ActivePage = shtDescr
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object shtDescr: TTabSheet
      Caption = 'Description'
      ImageIndex = 4
      object Label14: TLabel
        Left = 8
        Top = 13
        Width = 14
        Height = 13
        Caption = 'W:'
      end
      object Label15: TLabel
        Left = 8
        Top = 37
        Width = 11
        Height = 13
        Caption = 'H:'
      end
      object Label22: TLabel
        Left = 8
        Top = 61
        Width = 20
        Height = 13
        Caption = 'Opt:'
      end
      object edtDescrW: TSpinEdit
        Left = 32
        Top = 8
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object edtDescrH: TSpinEdit
        Left = 32
        Top = 32
        Width = 49
        Height = 22
        MaxLength = 2
        MaxValue = 64
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object btnAddDescr: TButton
        Left = 256
        Top = 2
        Width = 57
        Height = 25
        Caption = 'Add'
        TabOrder = 3
        OnClick = btnAddDescrClick
      end
      object edtDescrOpt: TSpinEdit
        Left = 32
        Top = 56
        Width = 49
        Height = 22
        MaxLength = 2
        MaxValue = 64
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
    end
    object shtPixel: TTabSheet
      Caption = 'Pixel'
      object Label1: TLabel
        Left = 8
        Top = 13
        Width = 10
        Height = 13
        Caption = 'X:'
      end
      object Label2: TLabel
        Left = 8
        Top = 37
        Width = 10
        Height = 13
        Caption = 'Y:'
      end
      object Label20: TLabel
        Left = 256
        Top = 72
        Width = 64
        Height = 13
        Caption = 'Firmware Bug'
      end
      object Label21: TLabel
        Left = 8
        Top = 61
        Width = 18
        Height = 13
        Caption = 'Val:'
      end
      object edtPixelX: TSpinEdit
        Left = 32
        Top = 8
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object edtPixelY: TSpinEdit
        Left = 32
        Top = 32
        Width = 49
        Height = 22
        MaxLength = 2
        MaxValue = 64
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object btnAddPixel: TButton
        Left = 256
        Top = 2
        Width = 57
        Height = 25
        Caption = 'Add'
        TabOrder = 9
        OnClick = btnAddPixelClick
      end
      object chkPixelX: TCheckBox
        Left = 88
        Top = 11
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 1
      end
      object chkPixelY: TCheckBox
        Left = 88
        Top = 35
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 4
      end
      object chkPixelWorkaround: TCheckBox
        Left = 256
        Top = 88
        Width = 97
        Height = 17
        Caption = 'Work around'
        Checked = True
        State = cbChecked
        TabOrder = 10
      end
      object edtPixelVal: TSpinEdit
        Left = 32
        Top = 56
        Width = 49
        Height = 22
        MaxLength = 2
        MaxValue = 64
        MinValue = 0
        TabOrder = 6
        Value = 0
      end
      object chkPixelVal: TCheckBox
        Left = 88
        Top = 59
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 7
      end
      object cboPixelMapX: TComboBox
        Left = 160
        Top = 9
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboPixelMapY: TComboBox
        Left = 160
        Top = 33
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 5
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboPixelMapVal: TComboBox
        Left = 160
        Top = 57
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 8
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
    end
    object shtLine: TTabSheet
      Caption = 'Line'
      ImageIndex = 1
      object Label3: TLabel
        Left = 8
        Top = 13
        Width = 16
        Height = 13
        Caption = 'X1:'
      end
      object Label4: TLabel
        Left = 8
        Top = 37
        Width = 16
        Height = 13
        Caption = 'Y1:'
      end
      object Label5: TLabel
        Left = 8
        Top = 61
        Width = 16
        Height = 13
        Caption = 'X2:'
      end
      object Label6: TLabel
        Left = 8
        Top = 85
        Width = 16
        Height = 13
        Caption = 'Y2:'
      end
      object btnAddLine: TButton
        Left = 256
        Top = 2
        Width = 57
        Height = 25
        Caption = 'Add'
        TabOrder = 12
        OnClick = btnAddLineClick
      end
      object edtLineX1: TSpinEdit
        Left = 32
        Top = 8
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object edtLineY1: TSpinEdit
        Left = 32
        Top = 32
        Width = 49
        Height = 22
        MaxLength = 2
        MaxValue = 64
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object edtLineX2: TSpinEdit
        Left = 32
        Top = 56
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 6
        Value = 0
      end
      object edtLineY2: TSpinEdit
        Left = 32
        Top = 80
        Width = 49
        Height = 22
        MaxLength = 2
        MaxValue = 64
        MinValue = 0
        TabOrder = 9
        Value = 0
      end
      object chkLineX1: TCheckBox
        Left = 88
        Top = 11
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 1
      end
      object chkLineY1: TCheckBox
        Left = 88
        Top = 35
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 4
      end
      object chkLineX2: TCheckBox
        Left = 88
        Top = 59
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 7
      end
      object chkLineY2: TCheckBox
        Left = 88
        Top = 83
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 10
      end
      object cboLineMapX1: TComboBox
        Left = 160
        Top = 9
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboLineMapY1: TComboBox
        Left = 160
        Top = 33
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 5
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboLineMapX2: TComboBox
        Left = 160
        Top = 57
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 8
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboLineMapY2: TComboBox
        Left = 160
        Top = 81
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 11
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
    end
    object shtRect: TTabSheet
      Caption = 'Rect'
      ImageIndex = 2
      object Label7: TLabel
        Left = 8
        Top = 13
        Width = 10
        Height = 13
        Caption = 'X:'
      end
      object Label8: TLabel
        Left = 8
        Top = 37
        Width = 10
        Height = 13
        Caption = 'Y:'
      end
      object Label9: TLabel
        Left = 8
        Top = 61
        Width = 14
        Height = 13
        Caption = 'W:'
      end
      object Label10: TLabel
        Left = 8
        Top = 85
        Width = 11
        Height = 13
        Caption = 'H:'
      end
      object btnAddRect: TButton
        Left = 256
        Top = 2
        Width = 57
        Height = 25
        Caption = 'Add'
        TabOrder = 12
        OnClick = btnAddRectClick
      end
      object edtRectX: TSpinEdit
        Left = 32
        Top = 8
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object edtRectY: TSpinEdit
        Left = 32
        Top = 32
        Width = 49
        Height = 22
        MaxLength = 2
        MaxValue = 64
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object edtRectW: TSpinEdit
        Left = 32
        Top = 56
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 6
        Value = 0
      end
      object edtRectH: TSpinEdit
        Left = 32
        Top = 80
        Width = 49
        Height = 22
        MaxLength = 2
        MaxValue = 64
        MinValue = 0
        TabOrder = 9
        Value = 0
      end
      object chkRectX: TCheckBox
        Left = 88
        Top = 11
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 1
      end
      object chkRectY: TCheckBox
        Left = 88
        Top = 35
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 4
      end
      object chkRectW: TCheckBox
        Left = 88
        Top = 59
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 7
      end
      object chkRectH: TCheckBox
        Left = 88
        Top = 83
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 10
      end
      object cboRectMapX: TComboBox
        Left = 160
        Top = 9
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboRectMapY: TComboBox
        Left = 160
        Top = 33
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 5
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboRectMapW: TComboBox
        Left = 160
        Top = 57
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 8
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboRectMapH: TComboBox
        Left = 160
        Top = 81
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 11
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
    end
    object shtCircle: TTabSheet
      Caption = 'Circle'
      ImageIndex = 3
      object Label11: TLabel
        Left = 8
        Top = 13
        Width = 10
        Height = 13
        Caption = 'X:'
      end
      object Label12: TLabel
        Left = 8
        Top = 37
        Width = 10
        Height = 13
        Caption = 'Y:'
      end
      object Label13: TLabel
        Left = 8
        Top = 61
        Width = 11
        Height = 13
        Caption = 'R:'
      end
      object Label19: TLabel
        Left = 256
        Top = 72
        Width = 64
        Height = 13
        Caption = 'Firmware Bug'
      end
      object btnAddCircle: TButton
        Left = 256
        Top = 2
        Width = 57
        Height = 25
        Caption = 'Add'
        TabOrder = 9
        OnClick = btnAddCircleClick
      end
      object edtCircleX: TSpinEdit
        Left = 32
        Top = 8
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object edtCircleY: TSpinEdit
        Left = 32
        Top = 32
        Width = 49
        Height = 22
        MaxLength = 2
        MaxValue = 64
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object edtCircleR: TSpinEdit
        Left = 32
        Top = 56
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 6
        Value = 0
      end
      object chkCircleX: TCheckBox
        Left = 88
        Top = 11
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 1
      end
      object chkCircleY: TCheckBox
        Left = 88
        Top = 35
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 4
      end
      object chkCircleR: TCheckBox
        Left = 88
        Top = 59
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 7
      end
      object cboCircleMapX: TComboBox
        Left = 160
        Top = 9
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboCircleMapY: TComboBox
        Left = 160
        Top = 33
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 5
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboCircleMapR: TComboBox
        Left = 160
        Top = 57
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 8
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
    end
    object shtNumBox: TTabSheet
      Caption = 'NumBox'
      ImageIndex = 5
      object Label16: TLabel
        Left = 8
        Top = 13
        Width = 10
        Height = 13
        Caption = 'X:'
      end
      object Label17: TLabel
        Left = 8
        Top = 37
        Width = 10
        Height = 13
        Caption = 'Y:'
      end
      object Label18: TLabel
        Left = 8
        Top = 61
        Width = 18
        Height = 13
        Caption = 'Val:'
      end
      object btnAddNumBox: TButton
        Left = 256
        Top = 2
        Width = 57
        Height = 25
        Caption = 'Add'
        TabOrder = 9
        OnClick = btnAddNumBoxClick
      end
      object edtNumBoxX: TSpinEdit
        Left = 32
        Top = 8
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object edtNumBoxY: TSpinEdit
        Left = 32
        Top = 32
        Width = 49
        Height = 22
        MaxLength = 2
        MaxValue = 64
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object edtNumBoxVal: TSpinEdit
        Left = 32
        Top = 56
        Width = 49
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 6
        Value = 0
      end
      object chkNumBoxVal: TCheckBox
        Left = 88
        Top = 59
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 7
      end
      object chkNumBoxY: TCheckBox
        Left = 88
        Top = 35
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 4
      end
      object chkNumBoxX: TCheckBox
        Left = 88
        Top = 11
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 1
      end
      object cboNumBoxMapX: TComboBox
        Left = 160
        Top = 9
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboNumBoxMapY: TComboBox
        Left = 160
        Top = 33
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 5
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object cboNumBoxMapVal: TComboBox
        Left = 160
        Top = 57
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 8
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
    end
    object shtSprite: TTabSheet
      Caption = 'Sprite'
      ImageIndex = 6
      object Label23: TLabel
        Left = 8
        Top = 13
        Width = 17
        Height = 13
        Caption = 'Idx:'
      end
      object btnAddSprite: TButton
        Left = 256
        Top = 2
        Width = 57
        Height = 25
        Caption = 'Add'
        TabOrder = 1
        OnClick = btnAddSpriteClick
      end
      object edtSpriteAddr: TSpinEdit
        Left = 32
        Top = 8
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
    end
    object shtVarMap: TTabSheet
      Caption = 'VarMap'
      ImageIndex = 7
      object btnAddVarMap: TButton
        Left = 256
        Top = 2
        Width = 57
        Height = 25
        Caption = 'Add'
        TabOrder = 0
        OnClick = btnAddVarMapClick
      end
    end
    object shtCopyBits: TTabSheet
      Caption = 'CopyBits'
      ImageIndex = 8
      object Label28: TLabel
        Left = 8
        Top = 13
        Width = 17
        Height = 13
        Caption = 'Idx:'
      end
      object btnAddCopyBits: TButton
        Left = 256
        Top = 2
        Width = 57
        Height = 25
        Caption = 'Add'
        TabOrder = 5
        OnClick = btnAddCopyBitsClick
      end
      object grpCopyBitsSource: TGroupBox
        Left = 0
        Top = 30
        Width = 205
        Height = 117
        Caption = 'Source'
        TabOrder = 3
        object Label24: TLabel
          Left = 8
          Top = 21
          Width = 10
          Height = 13
          Caption = 'X:'
        end
        object Label25: TLabel
          Left = 8
          Top = 45
          Width = 10
          Height = 13
          Caption = 'Y:'
        end
        object Label26: TLabel
          Left = 8
          Top = 69
          Width = 14
          Height = 13
          Caption = 'W:'
        end
        object Label27: TLabel
          Left = 8
          Top = 93
          Width = 11
          Height = 13
          Caption = 'H:'
        end
        object edtCopyBitsSrcX: TSpinEdit
          Left = 32
          Top = 16
          Width = 49
          Height = 22
          MaxLength = 3
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object edtCopyBitsSrcY: TSpinEdit
          Left = 32
          Top = 40
          Width = 49
          Height = 22
          MaxLength = 2
          MaxValue = 64
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object edtCopyBitsSrcW: TSpinEdit
          Left = 32
          Top = 64
          Width = 49
          Height = 22
          MaxLength = 3
          MaxValue = 100
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
        object edtCopyBitsSrcH: TSpinEdit
          Left = 32
          Top = 88
          Width = 49
          Height = 22
          MaxLength = 2
          MaxValue = 64
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
        object chkCopyBitsSrcX: TCheckBox
          Left = 88
          Top = 19
          Width = 68
          Height = 17
          Caption = 'Use Args'
          TabOrder = 1
        end
        object chkCopyBitsSrcY: TCheckBox
          Left = 88
          Top = 43
          Width = 68
          Height = 17
          Caption = 'Use Args'
          TabOrder = 4
        end
        object chkCopyBitsSrcW: TCheckBox
          Left = 88
          Top = 67
          Width = 68
          Height = 17
          Caption = 'Use Args'
          TabOrder = 7
        end
        object chkCopyBitsSrcH: TCheckBox
          Left = 88
          Top = 91
          Width = 68
          Height = 17
          Caption = 'Use Args'
          TabOrder = 10
        end
        object cboCopyBitsMapSrcX: TComboBox
          Left = 160
          Top = 17
          Width = 37
          Height = 21
          Hint = 'VarMap Address'
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 2
          Text = '0'
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
        end
        object cboCopyBitsMapSrcY: TComboBox
          Left = 160
          Top = 41
          Width = 37
          Height = 21
          Hint = 'VarMap Address'
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 5
          Text = '0'
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
        end
        object cboCopyBitsMapSrcW: TComboBox
          Left = 160
          Top = 65
          Width = 37
          Height = 21
          Hint = 'VarMap Address'
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 8
          Text = '0'
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
        end
        object cboCopyBitsMapSrcH: TComboBox
          Left = 160
          Top = 89
          Width = 37
          Height = 21
          Hint = 'VarMap Address'
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 11
          Text = '0'
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
        end
      end
      object edtCopyBitsAddr: TSpinEdit
        Left = 32
        Top = 8
        Width = 49
        Height = 22
        MaxLength = 3
        MaxValue = 100
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object chkCopyBitsAddr: TCheckBox
        Left = 88
        Top = 11
        Width = 68
        Height = 17
        Caption = 'Use Args'
        TabOrder = 1
      end
      object cboCopyBitsMapAddr: TComboBox
        Left = 160
        Top = 9
        Width = 37
        Height = 21
        Hint = 'VarMap Address'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = '0'
        Items.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
      object grpCopyBitsDest: TGroupBox
        Left = 216
        Top = 30
        Width = 205
        Height = 69
        Caption = 'Destination'
        TabOrder = 4
        object Label29: TLabel
          Left = 8
          Top = 21
          Width = 10
          Height = 13
          Caption = 'X:'
        end
        object Label30: TLabel
          Left = 8
          Top = 45
          Width = 10
          Height = 13
          Caption = 'Y:'
        end
        object edtCopyBitsDstX: TSpinEdit
          Left = 32
          Top = 16
          Width = 49
          Height = 22
          MaxLength = 3
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object edtCopyBitsDstY: TSpinEdit
          Left = 32
          Top = 40
          Width = 49
          Height = 22
          MaxLength = 2
          MaxValue = 64
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object chkCopyBitsDstX: TCheckBox
          Left = 88
          Top = 19
          Width = 68
          Height = 17
          Caption = 'Use Args'
          TabOrder = 1
        end
        object chkCopyBitsDstY: TCheckBox
          Left = 88
          Top = 43
          Width = 68
          Height = 17
          Caption = 'Use Args'
          TabOrder = 4
        end
        object cboCopyBitsMapDstX: TComboBox
          Left = 160
          Top = 17
          Width = 37
          Height = 21
          Hint = 'VarMap Address'
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 2
          Text = '0'
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
        end
        object cboCopyBitsMapDstY: TComboBox
          Left = 160
          Top = 41
          Width = 37
          Height = 21
          Hint = 'VarMap Address'
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 5
          Text = '0'
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
        end
      end
    end
  end
  object btnNew: TButton
    Left = 8
    Top = 40
    Width = 75
    Height = 25
    Caption = 'New'
    TabOrder = 2
    OnClick = btnNewClick
  end
  object btnSaveAs: TButton
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Save As...'
    TabOrder = 3
    OnClick = btnSaveAsClick
  end
  object btnTestCode: TButton
    Left = 8
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Test Code'
    TabOrder = 4
    OnClick = btnTestCodeClick
  end
  object grpCopyOptions: TGroupBox
    Left = 96
    Top = 210
    Width = 438
    Height = 41
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Copy Options'
    TabOrder = 5
    object radCopy: TRadioButton
      Left = 8
      Top = 16
      Width = 65
      Height = 17
      Caption = 'Copy'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object radCopyNot: TRadioButton
      Left = 80
      Top = 16
      Width = 65
      Height = 17
      Caption = 'Copy not'
      TabOrder = 1
    end
    object radOr: TRadioButton
      Left = 152
      Top = 16
      Width = 65
      Height = 17
      Caption = 'Or'
      TabOrder = 2
    end
    object radBitClear: TRadioButton
      Left = 224
      Top = 16
      Width = 65
      Height = 17
      Caption = 'Bit clear'
      TabOrder = 3
    end
  end
  object btnView: TButton
    Left = 8
    Top = 104
    Width = 75
    Height = 25
    Caption = 'View'
    TabOrder = 6
    OnClick = btnViewClick
  end
  object dlgOpen: TOpenDialog
    Filter = 'RIC Files (*.ric)|*.ric'
    Left = 64
    Top = 192
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'ric'
    Filter = 'RIC Files (*.ric)|*.ric'
    Left = 40
    Top = 192
  end
end
