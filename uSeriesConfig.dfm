object frmSeriesConfig: TfrmSeriesConfig
  Left = 414
  Top = 300
  HelpContext = 38000
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Series Configuration'
  ClientHeight = 302
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlOuter: TPanel
    Left = 0
    Top = 0
    Width = 362
    Height = 269
    Align = alClient
    Caption = 'pnlOuter'
    TabOrder = 0
    object pnlInner: TPanel
      Left = 1
      Top = 1
      Width = 360
      Height = 267
      Align = alClient
      BevelOuter = bvLowered
      BorderWidth = 2
      Caption = 'pnlInner'
      TabOrder = 0
      object pagSeries: TPageControl
        Left = 3
        Top = 33
        Width = 354
        Height = 231
        ActivePage = shtLine
        Align = alClient
        TabOrder = 0
        object shtLine: TTabSheet
          HelpContext = 38002
          Caption = 'Line'
          object Label24: TLabel
            Left = 8
            Top = 60
            Width = 37
            Height = 13
            Caption = '&Pattern:'
            FocusControl = cboLinePattern
          end
          object pnlLineColor: TShape
            Left = 192
            Top = 84
            Width = 33
            Height = 25
          end
          object cboLinePattern: TComboBox
            Left = 56
            Top = 56
            Width = 89
            Height = 21
            HelpContext = 38012
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            Items.Strings = (
              'Solid'
              'Clear'
              'Horizontal'
              'Vertical'
              'Diagonal'
              'B. Diagonal'
              'Cross'
              'Diag Cross')
          end
          object chkLineColorEach: TCheckBox
            Left = 8
            Top = 88
            Width = 86
            Height = 17
            HelpContext = 38013
            Caption = 'Color &Each'
            TabOrder = 1
          end
          object chkLineDark3D: TCheckBox
            Left = 8
            Top = 112
            Width = 86
            Height = 17
            HelpContext = 38015
            Caption = '&Dark 3D'
            TabOrder = 3
          end
          object grpLineMode: TGroupBox
            Left = 8
            Top = 136
            Width = 169
            Height = 49
            Caption = 'Line Mode'
            TabOrder = 4
            object chkLineStairs: TCheckBox
              Left = 8
              Top = 20
              Width = 65
              Height = 17
              HelpContext = 38016
              Caption = '&Stairs'
              TabOrder = 0
            end
            object chkLineInverted: TCheckBox
              Left = 80
              Top = 20
              Width = 73
              Height = 17
              HelpContext = 38017
              Caption = '&Inverted'
              TabOrder = 1
            end
          end
          object btnLineColor: TButton
            Left = 104
            Top = 84
            Width = 75
            Height = 25
            HelpContext = 38014
            Caption = '&Color...'
            TabOrder = 2
            OnClick = btnLineColorClick
          end
          object grpBorder: TGroupBox
            Left = 2
            Top = 0
            Width = 342
            Height = 50
            Caption = 'Border'
            TabOrder = 5
            object Label5: TLabel
              Left = 225
              Top = 22
              Width = 26
              Height = 13
              Caption = 'Style:'
            end
            object Label23: TLabel
              Left = 70
              Top = 22
              Width = 31
              Height = 13
              Caption = '&Width:'
            end
            object pnlLineBdrColor: TPanel
              Left = 32
              Top = 16
              Width = 33
              Height = 25
              TabOrder = 5
              Visible = False
            end
            object chkLineBVis: TCheckBox
              Left = 8
              Top = 20
              Width = 54
              Height = 17
              HelpContext = 38007
              Caption = '&Visible'
              TabOrder = 0
            end
            object edtLineBWidth: TEdit
              Left = 106
              Top = 18
              Width = 40
              Height = 21
              HelpContext = 38008
              MaxLength = 3
              TabOrder = 1
              Text = '1'
              OnKeyPress = EditKeyPress
            end
            object udLineBWidth: TUpDown
              Left = 146
              Top = 18
              Width = 15
              Height = 21
              HelpContext = 38009
              Associate = edtLineBWidth
              Min = 1
              Position = 1
              TabOrder = 2
              Wrap = True
            end
            object btnLineBdrColor: TButton
              Left = 170
              Top = 16
              Width = 49
              Height = 25
              HelpContext = 38010
              Caption = '&Color...'
              TabOrder = 3
              OnClick = btnLineBdrColorClick
            end
            object cboLineBdrStyle: TComboBox
              Left = 257
              Top = 18
              Width = 80
              Height = 21
              HelpContext = 38011
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 4
              Items.Strings = (
                'Solid'
                'Dash'
                'Dot'
                'Dash Dot'
                'Dash Dot Dot')
            end
          end
        end
        object shtBar: TTabSheet
          HelpContext = 38003
          Caption = 'Bar'
          ImageIndex = 2
          object Label29: TLabel
            Left = 8
            Top = 89
            Width = 26
            Height = 13
            Caption = '&Style:'
          end
          object Label2: TLabel
            Left = 12
            Top = 120
            Width = 61
            Height = 13
            Caption = '% Bar Wi&dth:'
            FocusControl = edtBarWidthPct
          end
          object Label3: TLabel
            Left = 12
            Top = 160
            Width = 61
            Height = 13
            Caption = '% Bar O&ffset:'
            FocusControl = edtBarOffsetPct
          end
          object pnlBarColor: TShape
            Left = 232
            Top = 56
            Width = 33
            Height = 25
          end
          object cboBarStyle: TComboBox
            Left = 41
            Top = 85
            Width = 98
            Height = 21
            HelpContext = 38025
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            Items.Strings = (
              'Rectangle'
              'Pyramid'
              'Inverted Pyramid'
              'Cylinder'
              'Ellipse'
              'Arrow'
              'Gradient Rectangle')
          end
          object grpBarMBar: TGroupBox
            Left = 96
            Top = 111
            Width = 107
            Height = 89
            HelpContext = 38034
            Caption = 'Multiple Bars'
            TabOrder = 10
            object radMBNone: TRadioButton
              Left = 8
              Top = 16
              Width = 93
              Height = 17
              Caption = 'None'
              TabOrder = 0
            end
            object radMBSide: TRadioButton
              Left = 8
              Top = 32
              Width = 93
              Height = 17
              Caption = 'Side'
              TabOrder = 1
            end
            object radMBStacked: TRadioButton
              Left = 8
              Top = 48
              Width = 93
              Height = 17
              Caption = 'Stacked'
              TabOrder = 2
            end
            object radMBStackedPct: TRadioButton
              Left = 8
              Top = 64
              Width = 93
              Height = 17
              Caption = 'Stacled 100%'
              TabOrder = 3
            end
          end
          object grpBarOpts: TGroupBox
            Left = 208
            Top = 111
            Width = 131
            Height = 89
            TabOrder = 11
            object chkDB3DSides: TCheckBox
              Left = 8
              Top = 16
              Width = 116
              Height = 17
              HelpContext = 38035
              Caption = 'Dark Bar 3D Sides'
              TabOrder = 0
            end
            object chkBarSideMargins: TCheckBox
              Left = 8
              Top = 40
              Width = 116
              Height = 17
              HelpContext = 38036
              Caption = 'Bar Side Margins'
              TabOrder = 1
            end
            object chkAutoMarkPos: TCheckBox
              Left = 8
              Top = 64
              Width = 116
              Height = 17
              HelpContext = 38037
              Caption = 'Auto Mark Position'
              TabOrder = 2
            end
          end
          object chkBarColorEach: TCheckBox
            Left = 8
            Top = 60
            Width = 82
            Height = 17
            HelpContext = 38023
            Caption = 'Color &Each'
            TabOrder = 3
          end
          object btnBarColor: TButton
            Left = 152
            Top = 56
            Width = 75
            Height = 25
            HelpContext = 38024
            Caption = '&Color...'
            TabOrder = 4
            OnClick = btnBarColorClick
          end
          object chkBarUseOrigin: TCheckBox
            Left = 154
            Top = 87
            Width = 72
            Height = 17
            HelpContext = 38026
            Caption = '&Use Origin:'
            TabOrder = 5
          end
          object edtBarYOrigin: TEdit
            Left = 232
            Top = 85
            Width = 40
            Height = 21
            HelpContext = 38027
            MaxLength = 6
            TabOrder = 6
            Text = '0'
            OnKeyPress = EditKeyPress
          end
          object udBarYOrigin: TUpDown
            Left = 272
            Top = 85
            Width = 16
            Height = 21
            HelpContext = 38028
            Associate = edtBarYOrigin
            Min = -32768
            Max = 32767
            TabOrder = 7
            Thousands = False
            Wrap = True
          end
          object edtBarWidthPct: TEdit
            Left = 12
            Top = 135
            Width = 40
            Height = 21
            HelpContext = 38029
            MaxLength = 3
            TabOrder = 1
            Text = '0'
            OnKeyPress = EditKeyPress
          end
          object udBarWidthPct: TUpDown
            Left = 52
            Top = 135
            Width = 16
            Height = 21
            HelpContext = 38030
            Associate = edtBarWidthPct
            TabOrder = 2
            Wrap = True
          end
          object edtBarOffsetPct: TEdit
            Left = 12
            Top = 175
            Width = 40
            Height = 21
            HelpContext = 38031
            MaxLength = 3
            TabOrder = 8
            Text = '0'
            OnKeyPress = EditKeyPress
          end
          object udBarOffsetPct: TUpDown
            Left = 52
            Top = 175
            Width = 15
            Height = 21
            HelpContext = 38032
            Associate = edtBarOffsetPct
            TabOrder = 9
            Wrap = True
          end
          object GroupBox1: TGroupBox
            Left = 2
            Top = 0
            Width = 342
            Height = 50
            Caption = 'Border'
            TabOrder = 12
            object Label6: TLabel
              Left = 225
              Top = 22
              Width = 26
              Height = 13
              Caption = 'Style:'
            end
            object Label25: TLabel
              Left = 70
              Top = 22
              Width = 31
              Height = 13
              Caption = '&Width:'
            end
            object pnlBarBdrColor: TPanel
              Left = 32
              Top = 16
              Width = 33
              Height = 25
              TabOrder = 5
              Visible = False
            end
            object btnBarBdrColor: TButton
              Left = 170
              Top = 16
              Width = 49
              Height = 25
              HelpContext = 38021
              Caption = '&Color...'
              TabOrder = 3
              OnClick = btnBarBdrColorClick
            end
            object cboBarBdrStyle: TComboBox
              Left = 257
              Top = 18
              Width = 80
              Height = 21
              HelpContext = 38022
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 4
              Items.Strings = (
                'Solid'
                'Dash'
                'Dot'
                'Dash Dot'
                'Dash Dot Dot')
            end
            object chkBarBVis: TCheckBox
              Left = 8
              Top = 20
              Width = 54
              Height = 17
              HelpContext = 38018
              Caption = '&Visible'
              TabOrder = 0
            end
            object udBarBWidth: TUpDown
              Left = 146
              Top = 18
              Width = 15
              Height = 21
              HelpContext = 38020
              Associate = edtBarBWidth
              Min = 1
              Position = 1
              TabOrder = 2
              Wrap = True
            end
            object edtBarBWidth: TEdit
              Left = 106
              Top = 18
              Width = 40
              Height = 21
              HelpContext = 38019
              MaxLength = 3
              TabOrder = 1
              Text = '1'
              OnKeyPress = EditKeyPress
            end
          end
        end
        object shtArea: TTabSheet
          HelpContext = 38004
          Caption = 'Area'
          ImageIndex = 3
          object Label28: TLabel
            Left = 8
            Top = 12
            Width = 37
            Height = 13
            Caption = '&Pattern:'
            FocusControl = cboAreaPattern
          end
          object pnlAreaColor: TShape
            Left = 272
            Top = 31
            Width = 33
            Height = 25
          end
          object cboAreaPattern: TComboBox
            Left = 56
            Top = 8
            Width = 89
            Height = 21
            HelpContext = 38038
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            Items.Strings = (
              'Solid'
              'Clear'
              'Horizontal'
              'Vertical'
              'Diagonal'
              'B. Diagonal'
              'Cross'
              'Diag Cross')
          end
          object chkAreaStairs: TCheckBox
            Left = 8
            Top = 35
            Width = 62
            Height = 17
            HelpContext = 38040
            Caption = '&Stairs'
            TabOrder = 1
          end
          object grpMultipleAreas: TGroupBox
            Left = 2
            Top = 164
            Width = 342
            Height = 37
            HelpContext = 38052
            Caption = 'Multiple Areas'
            TabOrder = 6
            object radMANone: TRadioButton
              Left = 12
              Top = 14
              Width = 93
              Height = 17
              Caption = 'None'
              TabOrder = 0
            end
            object radMAStacked: TRadioButton
              Left = 124
              Top = 14
              Width = 93
              Height = 17
              Caption = 'Stacked'
              TabOrder = 1
            end
            object radMAStackedPct: TRadioButton
              Left = 236
              Top = 14
              Width = 93
              Height = 17
              Caption = 'Stacked 100%'
              TabOrder = 2
            end
          end
          object chkAreaColorEach: TCheckBox
            Left = 192
            Top = 10
            Width = 82
            Height = 17
            HelpContext = 38039
            Caption = 'Color &Each'
            TabOrder = 2
          end
          object btnAreaColor: TButton
            Left = 192
            Top = 31
            Width = 75
            Height = 25
            HelpContext = 38041
            Caption = '&Color'
            TabOrder = 3
            OnClick = btnAreaColorClick
          end
          object grpAreaBorder: TGroupBox
            Left = 2
            Top = 58
            Width = 342
            Height = 50
            Caption = 'Border'
            TabOrder = 4
            object Label7: TLabel
              Left = 225
              Top = 22
              Width = 26
              Height = 13
              Caption = 'Style:'
            end
            object Label27: TLabel
              Left = 72
              Top = 22
              Width = 31
              Height = 13
              Caption = '&Width:'
            end
            object pnlAreaBdrColor: TPanel
              Left = 32
              Top = 16
              Width = 33
              Height = 25
              Caption = 'pnlAreaBdrColor'
              TabOrder = 5
              Visible = False
            end
            object btnAreaBdrColor: TButton
              Left = 170
              Top = 16
              Width = 49
              Height = 25
              HelpContext = 38045
              Caption = '&Color...'
              TabOrder = 3
              OnClick = btnAreaBdrColorClick
            end
            object cboAreaBdrStyle: TComboBox
              Left = 257
              Top = 18
              Width = 80
              Height = 21
              HelpContext = 38046
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 4
              Items.Strings = (
                'Solid'
                'Dash'
                'Dot'
                'Dash Dot'
                'Dash Dot Dot')
            end
            object chkAreaBVis: TCheckBox
              Left = 8
              Top = 20
              Width = 54
              Height = 17
              HelpContext = 38042
              Caption = '&Visible'
              TabOrder = 0
            end
            object edtAreaBWidth: TEdit
              Left = 108
              Top = 18
              Width = 40
              Height = 21
              HelpContext = 38043
              MaxLength = 3
              TabOrder = 1
              Text = '1'
              OnKeyPress = EditKeyPress
            end
            object udAreaBWidth: TUpDown
              Left = 148
              Top = 18
              Width = 15
              Height = 21
              HelpContext = 38044
              Associate = edtAreaBWidth
              Min = 1
              Position = 1
              TabOrder = 2
              Wrap = True
            end
          end
          object grpAreaLines: TGroupBox
            Left = 2
            Top = 111
            Width = 342
            Height = 50
            Caption = 'Area Lines'
            TabOrder = 5
            object Label8: TLabel
              Left = 225
              Top = 21
              Width = 26
              Height = 13
              Caption = 'Style:'
            end
            object Label1: TLabel
              Left = 72
              Top = 22
              Width = 31
              Height = 13
              Caption = 'W&idth:'
            end
            object pnlAreaALColor: TPanel
              Left = 32
              Top = 16
              Width = 33
              Height = 28
              Caption = 'pnlAreaBdrColor'
              TabOrder = 5
              Visible = False
            end
            object btnAreaALColor: TButton
              Left = 170
              Top = 15
              Width = 49
              Height = 25
              HelpContext = 38050
              Caption = '&Color...'
              TabOrder = 3
              OnClick = btnAreaALColorClick
            end
            object cboAreaALStyle: TComboBox
              Left = 257
              Top = 17
              Width = 80
              Height = 21
              HelpContext = 38051
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 4
              Items.Strings = (
                'Solid'
                'Dash'
                'Dot'
                'Dash Dot'
                'Dash Dot Dot')
            end
            object chkAreaLinesVis: TCheckBox
              Left = 8
              Top = 20
              Width = 54
              Height = 17
              HelpContext = 38047
              Caption = 'Visib&le'
              TabOrder = 0
            end
            object edtAreaALWidth: TEdit
              Left = 108
              Top = 18
              Width = 40
              Height = 21
              HelpContext = 38048
              MaxLength = 3
              TabOrder = 1
              Text = '1'
              OnKeyPress = EditKeyPress
            end
            object udAreaALWidth: TUpDown
              Left = 148
              Top = 18
              Width = 15
              Height = 21
              HelpContext = 38049
              Associate = edtAreaALWidth
              Min = 1
              Position = 1
              TabOrder = 2
              Wrap = True
            end
          end
        end
        object shtPoint: TTabSheet
          HelpContext = 38005
          Caption = 'Point'
          ImageIndex = 4
          object Label30: TLabel
            Left = 8
            Top = 68
            Width = 26
            Height = 13
            Caption = '&Style:'
            FocusControl = cboPointStyle
          end
          object Label31: TLabel
            Left = 117
            Top = 8
            Width = 31
            Height = 13
            Caption = 'Width:'
            FocusControl = edtPointWidth
          end
          object Label32: TLabel
            Left = 114
            Top = 40
            Width = 34
            Height = 13
            Caption = 'Height:'
            FocusControl = edtPointHeight
          end
          object cboPointStyle: TComboBox
            Left = 48
            Top = 64
            Width = 97
            Height = 21
            HelpContext = 38060
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 3
            Items.Strings = (
              'Square'
              'Circle'
              'Triangle'
              'Down Triangle')
          end
          object chkPointVis: TCheckBox
            Left = 8
            Top = 8
            Width = 91
            Height = 17
            HelpContext = 38053
            Caption = '&Visible'
            TabOrder = 0
          end
          object chkPoint3D: TCheckBox
            Left = 8
            Top = 24
            Width = 91
            Height = 17
            HelpContext = 38054
            Caption = '&3D'
            TabOrder = 1
          end
          object edtPointWidth: TEdit
            Left = 157
            Top = 4
            Width = 40
            Height = 21
            HelpContext = 38056
            MaxLength = 3
            TabOrder = 4
            Text = '0'
            OnKeyPress = EditKeyPress
          end
          object udPointWidth: TUpDown
            Left = 197
            Top = 4
            Width = 16
            Height = 21
            HelpContext = 38057
            Associate = edtPointWidth
            TabOrder = 5
            Wrap = True
          end
          object edtPointHeight: TEdit
            Left = 157
            Top = 36
            Width = 40
            Height = 21
            HelpContext = 38058
            MaxLength = 3
            TabOrder = 6
            Text = '0'
            OnKeyPress = EditKeyPress
          end
          object udPointHeight: TUpDown
            Left = 197
            Top = 36
            Width = 16
            Height = 21
            HelpContext = 38059
            Associate = edtPointHeight
            TabOrder = 7
            Wrap = True
          end
          object chkPointInfMargin: TCheckBox
            Left = 8
            Top = 40
            Width = 91
            Height = 17
            HelpContext = 38055
            Caption = 'Inflate &Margin'
            TabOrder = 2
          end
          object grpPointBorder: TGroupBox
            Left = 2
            Top = 90
            Width = 342
            Height = 50
            Caption = 'Border'
            TabOrder = 8
            object Label9: TLabel
              Left = 225
              Top = 22
              Width = 26
              Height = 13
              Caption = 'Style:'
            end
            object Label26: TLabel
              Left = 71
              Top = 22
              Width = 31
              Height = 13
              Caption = '&Width:'
              FocusControl = edtPointBWidth
            end
            object pnlPointBdrColor: TPanel
              Left = 32
              Top = 16
              Width = 33
              Height = 28
              Caption = 'pnlAreaBdrColor'
              TabOrder = 5
              Visible = False
            end
            object btnPointBdrColor: TButton
              Left = 170
              Top = 16
              Width = 49
              Height = 25
              HelpContext = 38064
              Caption = '&Color...'
              TabOrder = 3
              OnClick = btnPointBdrColorClick
            end
            object cboPointBdrStyle: TComboBox
              Left = 257
              Top = 18
              Width = 80
              Height = 21
              HelpContext = 38065
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 4
              Items.Strings = (
                'Solid'
                'Dash'
                'Dot'
                'Dash Dot'
                'Dash Dot Dot')
            end
            object edtPointBWidth: TEdit
              Left = 107
              Top = 18
              Width = 41
              Height = 21
              HelpContext = 38062
              MaxLength = 3
              TabOrder = 1
              Text = '1'
              OnKeyPress = EditKeyPress
            end
            object udPointBWidth: TUpDown
              Left = 148
              Top = 18
              Width = 15
              Height = 21
              HelpContext = 38063
              Associate = edtPointBWidth
              Min = 1
              Position = 1
              TabOrder = 2
              Wrap = True
            end
            object chkPointBVis: TCheckBox
              Left = 8
              Top = 20
              Width = 54
              Height = 17
              HelpContext = 38061
              Caption = '&Visible'
              TabOrder = 0
            end
          end
        end
        object shtMarks: TTabSheet
          HelpContext = 38006
          Caption = 'Marks'
          ImageIndex = 1
          object chkMarkVisible: TCheckBox
            Left = 8
            Top = 3
            Width = 97
            Height = 17
            HelpContext = 38066
            Caption = 'Visible'
            TabOrder = 0
          end
          object grpMarkFormat: TGroupBox
            Left = 4
            Top = 24
            Width = 192
            Height = 111
            Caption = 'Format'
            TabOrder = 1
            object btnMarkBackColor: TButton
              Left = 8
              Top = 16
              Width = 87
              Height = 25
              HelpContext = 38067
              Caption = '&Back Color...'
              TabOrder = 0
              OnClick = btnMarkBackColorClick
            end
            object btnMarkFont: TButton
              Left = 117
              Top = 80
              Width = 67
              Height = 25
              HelpContext = 38073
              Caption = '&Font...'
              TabOrder = 4
              OnClick = btnMarkFontClick
            end
            object chkMarkTrans: TCheckBox
              Left = 104
              Top = 20
              Width = 81
              Height = 17
              HelpContext = 38068
              Caption = '&Transparent'
              TabOrder = 2
            end
            object chkMarkClip: TCheckBox
              Left = 117
              Top = 52
              Width = 68
              Height = 17
              HelpContext = 38072
              Caption = 'Cl&ipped'
              TabOrder = 3
            end
            object grpMarkBorder: TGroupBox
              Left = 6
              Top = 44
              Width = 106
              Height = 62
              Caption = 'Border'
              TabOrder = 1
              object Label14: TLabel
                Left = 8
                Top = 38
                Width = 31
                Height = 13
                Caption = 'Width:'
              end
              object chkMarkBVis: TCheckBox
                Left = 8
                Top = 16
                Width = 57
                Height = 17
                HelpContext = 38069
                Caption = 'Visible'
                TabOrder = 0
              end
              object edtMarkBWidth: TEdit
                Left = 43
                Top = 34
                Width = 41
                Height = 21
                HelpContext = 38070
                TabOrder = 1
                Text = '1'
                OnKeyPress = EditKeyPress
              end
              object udMarkBWidth: TUpDown
                Left = 84
                Top = 34
                Width = 15
                Height = 21
                HelpContext = 38071
                Associate = edtMarkBWidth
                Min = 1
                Position = 1
                TabOrder = 2
              end
            end
          end
          object grpArrows: TGroupBox
            Left = 4
            Top = 136
            Width = 192
            Height = 48
            Caption = 'Arrows'
            TabOrder = 2
            object Label13: TLabel
              Left = 89
              Top = 22
              Width = 36
              Height = 13
              Caption = '&Length:'
            end
            object btnArrowColor: TButton
              Left = 8
              Top = 16
              Width = 75
              Height = 25
              HelpContext = 38074
              Caption = '&Color...'
              TabOrder = 0
              OnClick = btnArrowColorClick
            end
            object edtArrowLen: TEdit
              Left = 129
              Top = 18
              Width = 40
              Height = 21
              HelpContext = 38075
              MaxLength = 3
              TabOrder = 1
              Text = '0'
              OnKeyPress = EditKeyPress
            end
            object udArrowLen: TUpDown
              Left = 169
              Top = 18
              Width = 16
              Height = 21
              HelpContext = 38076
              Associate = edtArrowLen
              TabOrder = 2
            end
          end
          object grpMarkStyle: TGroupBox
            Left = 201
            Top = 3
            Width = 141
            Height = 181
            Caption = 'Style:'
            TabOrder = 3
            object radMarkVal: TRadioButton
              Left = 8
              Top = 16
              Width = 127
              Height = 17
              HelpContext = 38077
              Caption = 'Value'
              TabOrder = 0
            end
            object radMarkPct: TRadioButton
              Left = 8
              Top = 34
              Width = 127
              Height = 17
              HelpContext = 38078
              Caption = 'Percent'
              TabOrder = 1
            end
            object radMarkLbl: TRadioButton
              Left = 8
              Top = 52
              Width = 127
              Height = 17
              HelpContext = 38079
              Caption = 'Label'
              Checked = True
              TabOrder = 2
              TabStop = True
            end
            object radMarkLblPct: TRadioButton
              Left = 8
              Top = 69
              Width = 127
              Height = 17
              HelpContext = 38080
              Caption = 'Label and Percent'
              TabOrder = 3
            end
            object radMarkLblVal: TRadioButton
              Left = 8
              Top = 87
              Width = 127
              Height = 17
              HelpContext = 38081
              Caption = 'Label and Value'
              TabOrder = 4
            end
            object radMarkLegend: TRadioButton
              Left = 8
              Top = 105
              Width = 127
              Height = 17
              HelpContext = 38082
              Caption = 'Legend'
              TabOrder = 5
            end
            object radMarkPctTot: TRadioButton
              Left = 8
              Top = 123
              Width = 127
              Height = 17
              HelpContext = 38083
              Caption = 'Percent Total'
              TabOrder = 6
            end
            object radMarkLblPctTot: TRadioButton
              Left = 8
              Top = 140
              Width = 127
              Height = 17
              HelpContext = 38084
              Caption = 'Label && Percent Total'
              TabOrder = 7
            end
            object radMarkXVal: TRadioButton
              Left = 8
              Top = 158
              Width = 127
              Height = 17
              HelpContext = 38085
              Caption = 'X Value'
              TabOrder = 8
            end
          end
          object pnlMark: TPanel
            Left = 88
            Top = 8
            Width = 33
            Height = 25
            Caption = 'pnlMark'
            TabOrder = 4
            Visible = False
          end
          object pnlArrowColor: TPanel
            Left = 144
            Top = 8
            Width = 33
            Height = 33
            Caption = 'pnlArrowColor'
            TabOrder = 5
            Visible = False
          end
        end
        object shtFunction: TTabSheet
          Caption = 'Function'
          ImageIndex = 5
          object lblFunctions: TLabel
            Left = 24
            Top = 12
            Width = 49
            Height = 13
            Caption = '&Functions:'
          end
          object cboFunctions: TComboBox
            Left = 96
            Top = 8
            Width = 145
            Height = 21
            HelpContext = 38092
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            Items.Strings = (
              'Copy'
              'Average'
              'Low'
              'High'
              'Divide'
              'Multiply'
              'Subtract'
              'Add'
              'Sum of squares')
          end
          object grpFuncSeries: TGroupBox
            Left = 24
            Top = 32
            Width = 297
            Height = 161
            TabOrder = 1
            object lblAvailable: TLabel
              Left = 8
              Top = 16
              Width = 46
              Height = 13
              Caption = '&Available:'
              FocusControl = lstFuncSeriesAvail
            end
            object lblSelected: TLabel
              Left = 168
              Top = 16
              Width = 45
              Height = 13
              Caption = '&Selected:'
              FocusControl = lstFuncSeriesSelected
            end
            object lstFuncSeriesAvail: TListBox
              Left = 8
              Top = 32
              Width = 121
              Height = 121
              HelpContext = 38091
              IntegralHeight = True
              ItemHeight = 13
              MultiSelect = True
              TabOrder = 0
            end
            object lstFuncSeriesSelected: TListBox
              Left = 168
              Top = 32
              Width = 121
              Height = 121
              HelpContext = 38086
              IntegralHeight = True
              ItemHeight = 13
              MultiSelect = True
              TabOrder = 5
            end
            object btnSelOne: TBitBtn
              Left = 136
              Top = 32
              Width = 25
              Height = 25
              HelpContext = 38087
              Action = actSelOne
              Caption = '>'
              TabOrder = 1
            end
            object btnSelAll: TBitBtn
              Left = 136
              Top = 64
              Width = 25
              Height = 25
              HelpContext = 38088
              Action = actSellAll
              Caption = '>>'
              TabOrder = 2
            end
            object btnDesOne: TBitBtn
              Left = 136
              Top = 96
              Width = 25
              Height = 25
              HelpContext = 38089
              Action = actDesOne
              Caption = '<'
              TabOrder = 3
            end
            object btnDesAll: TBitBtn
              Left = 136
              Top = 128
              Width = 25
              Height = 25
              HelpContext = 38090
              Action = actDesAll
              Caption = '<<'
              TabOrder = 4
            end
          end
          object btnEditFunction: TButton
            Left = 252
            Top = 6
            Width = 67
            Height = 25
            HelpContext = 38093
            Caption = '&Edit...'
            TabOrder = 2
            OnClick = btnEditFunctionClick
          end
        end
      end
      object pnlTitle: TPanel
        Left = 3
        Top = 3
        Width = 354
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label4: TLabel
          Left = 8
          Top = 8
          Width = 23
          Height = 13
          Caption = '&Title:'
          FocusControl = edtTitle
        end
        object edtTitle: TEdit
          Left = 37
          Top = 4
          Width = 225
          Height = 21
          HelpContext = 38001
          TabOrder = 0
        end
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 269
    Width = 362
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      362
      33)
    object btnOK: TButton
      Left = 194
      Top = 5
      Width = 52
      Height = 25
      HelpContext = 38094
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 250
      Top = 5
      Width = 52
      Height = 25
      HelpContext = 38095
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnHelp: TButton
      Left = 307
      Top = 5
      Width = 52
      Height = 25
      HelpContext = 38096
      Caption = '&Help'
      TabOrder = 2
      OnClick = btnHelpClick
    end
  end
  object dlgColor: TColorDialog
    Left = 312
    Top = 52
  end
  object dlgFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 273
    Top = 31
  end
  object aclFuncButtons: TActionList
    OnUpdate = aclFuncButtonsUpdate
    Left = 88
    Top = 178
    object actSelOne: TAction
      Caption = '>'
      OnExecute = actSelOneExecute
    end
    object actSellAll: TAction
      Caption = '>>'
      OnExecute = actSellAllExecute
    end
    object actDesOne: TAction
      Caption = '<'
      OnExecute = actDesOneExecute
    end
    object actDesAll: TAction
      Caption = '<<'
      OnExecute = actDesAllExecute
    end
  end
end
