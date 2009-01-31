object frmChartConfig: TfrmChartConfig
  Left = 192
  Top = 123
  HelpContext = 20000
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Chart Configuration'
  ClientHeight = 344
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 311
    Width = 381
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      381
      33)
    object btnOK: TButton
      Left = 141
      Top = 5
      Width = 75
      Height = 25
      HelpContext = 20002
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 221
      Top = 5
      Width = 75
      Height = 25
      HelpContext = 20003
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnHelp: TButton
      Left = 301
      Top = 5
      Width = 75
      Height = 25
      HelpContext = 20004
      Anchors = [akTop, akRight]
      Caption = '&Help'
      TabOrder = 2
      OnClick = btnHelpClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 381
    Height = 311
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 379
      Height = 309
      Align = alClient
      BevelOuter = bvLowered
      BorderWidth = 2
      Caption = 'Panel2'
      TabOrder = 0
      object pagConfig: TPageControl
        Left = 3
        Top = 3
        Width = 373
        Height = 303
        ActivePage = shtPanel
        Align = alClient
        TabOrder = 0
        object shtGeneral: TTabSheet
          Caption = 'General'
          object grpChartType: TGroupBox
            Left = 6
            Top = 3
            Width = 354
            Height = 49
            Caption = 'Chart Type'
            TabOrder = 0
            object radTypeLine: TRadioButton
              Left = 8
              Top = 20
              Width = 52
              Height = 17
              HelpContext = 20010
              Caption = '&Line'
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = radTypeAreaClick
            end
            object radTypeBar: TRadioButton
              Left = 67
              Top = 20
              Width = 45
              Height = 17
              HelpContext = 20011
              Caption = '&Bar'
              TabOrder = 1
              OnClick = radTypeAreaClick
            end
            object radTypeHBar: TRadioButton
              Left = 120
              Top = 20
              Width = 97
              Height = 17
              HelpContext = 20012
              Caption = '&Horizontal Bar'
              TabOrder = 2
              OnClick = radTypeAreaClick
            end
            object radTypeArea: TRadioButton
              Left = 222
              Top = 20
              Width = 52
              Height = 17
              HelpContext = 20013
              Caption = '&Area'
              TabOrder = 3
              OnClick = radTypeAreaClick
            end
            object radTypePoint: TRadioButton
              Left = 280
              Top = 20
              Width = 51
              Height = 17
              HelpContext = 20014
              Caption = '&Point'
              TabOrder = 4
              OnClick = radTypeAreaClick
            end
          end
          object grpPaging: TGroupBox
            Left = 6
            Top = 56
            Width = 154
            Height = 73
            Caption = 'Paging'
            TabOrder = 1
            object Label13: TLabel
              Left = 8
              Top = 21
              Width = 78
              Height = 13
              Caption = 'P&oints per Page:'
            end
            object edtPointsPerPage: TEdit
              Left = 92
              Top = 17
              Width = 40
              Height = 21
              HelpContext = 20017
              MaxLength = 3
              TabOrder = 0
              Text = '0'
              OnKeyPress = EditKeyPress
            end
            object udPointsPerPage: TUpDown
              Left = 132
              Top = 17
              Width = 15
              Height = 21
              HelpContext = 20018
              Associate = edtPointsPerPage
              Max = 999
              TabOrder = 1
            end
            object chkScaleLastPage: TCheckBox
              Left = 8
              Top = 48
              Width = 129
              Height = 17
              HelpContext = 20019
              Caption = '&Scale Last Page'
              TabOrder = 2
            end
          end
          object grpMargins: TGroupBox
            Left = 164
            Top = 56
            Width = 196
            Height = 73
            Caption = 'Margins'
            TabOrder = 2
            object edtMarginTop: TEdit
              Left = 70
              Top = 14
              Width = 40
              Height = 21
              HelpContext = 20021
              MaxLength = 3
              TabOrder = 0
              Text = '0'
              OnKeyPress = EditKeyPress
            end
            object edtMarginLeft: TEdit
              Left = 8
              Top = 32
              Width = 40
              Height = 21
              HelpContext = 20022
              MaxLength = 3
              TabOrder = 2
              Text = '0'
              OnKeyPress = EditKeyPress
            end
            object edtMarginRight: TEdit
              Left = 132
              Top = 32
              Width = 40
              Height = 21
              HelpContext = 20023
              MaxLength = 3
              TabOrder = 4
              Text = '0'
              OnKeyPress = EditKeyPress
            end
            object edtMarginBot: TEdit
              Left = 70
              Top = 45
              Width = 40
              Height = 21
              HelpContext = 20024
              MaxLength = 3
              TabOrder = 6
              Text = '0'
              OnKeyPress = EditKeyPress
            end
            object udMarginRight: TUpDown
              Left = 172
              Top = 32
              Width = 16
              Height = 21
              HelpContext = 20025
              Associate = edtMarginRight
              TabOrder = 5
              Wrap = True
            end
            object udMarginTop: TUpDown
              Left = 110
              Top = 14
              Width = 16
              Height = 21
              HelpContext = 20026
              Associate = edtMarginTop
              TabOrder = 1
              Wrap = True
            end
            object udMarginBot: TUpDown
              Left = 110
              Top = 45
              Width = 16
              Height = 21
              HelpContext = 20027
              Associate = edtMarginBot
              TabOrder = 7
              Wrap = True
            end
            object udMarginLeft: TUpDown
              Left = 48
              Top = 32
              Width = 16
              Height = 21
              HelpContext = 20028
              Associate = edtMarginLeft
              TabOrder = 3
              Wrap = True
            end
          end
        end
        object shtTitles: TTabSheet
          Caption = 'Titles'
          ImageIndex = 1
          object btnFootFont: TButton
            Left = 8
            Top = 112
            Width = 75
            Height = 25
            HelpContext = 20064
            Caption = 'Font...'
            TabOrder = 6
            OnClick = btnTitleFontClick
          end
          object grpFootFrame: TGroupBox
            Left = 120
            Top = 1
            Width = 129
            Height = 137
            Caption = 'Frame'
            TabOrder = 8
            object Label29: TLabel
              Left = 8
              Top = 45
              Width = 31
              Height = 13
              Caption = 'Width:'
            end
            object Label30: TLabel
              Left = 9
              Top = 112
              Width = 26
              Height = 13
              Caption = 'Style:'
            end
            object chkFootFrameVis: TCheckBox
              Left = 8
              Top = 19
              Width = 65
              Height = 17
              HelpContext = 20033
              Caption = 'Visible'
              TabOrder = 0
            end
            object edtFootFrameWidth: TEdit
              Left = 48
              Top = 41
              Width = 40
              Height = 21
              HelpContext = 20034
              MaxLength = 3
              TabOrder = 1
              Text = '1'
              OnKeyPress = EditKeyPress
            end
            object udFootFrameWidth: TUpDown
              Left = 88
              Top = 41
              Width = 15
              Height = 21
              HelpContext = 20035
              Associate = edtFootFrameWidth
              Min = 1
              Position = 1
              TabOrder = 2
              Wrap = True
            end
            object btnFootFrameColor: TButton
              Left = 8
              Top = 74
              Width = 75
              Height = 25
              HelpContext = 20036
              Caption = '&Color...'
              TabOrder = 3
              OnClick = btnFootFrameColorClick
            end
            object cboFootFrameStyle: TComboBox
              Left = 41
              Top = 108
              Width = 80
              Height = 21
              HelpContext = 20037
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
            object pnlFootFrameColor: TPanel
              Left = 80
              Top = 16
              Width = 33
              Height = 25
              Caption = 'Color'
              TabOrder = 5
              Visible = False
            end
          end
          object grpTitleFrame: TGroupBox
            Left = 120
            Top = 1
            Width = 129
            Height = 137
            Caption = 'Frame'
            TabOrder = 7
            object Label27: TLabel
              Left = 8
              Top = 45
              Width = 31
              Height = 13
              Caption = 'Width:'
            end
            object Label28: TLabel
              Left = 9
              Top = 112
              Width = 26
              Height = 13
              Caption = 'Style:'
            end
            object chkTitleFrameVis: TCheckBox
              Left = 8
              Top = 19
              Width = 65
              Height = 17
              HelpContext = 20042
              Caption = 'Visible'
              TabOrder = 0
            end
            object edtTitleFrameWidth: TEdit
              Left = 48
              Top = 41
              Width = 40
              Height = 21
              HelpContext = 20043
              MaxLength = 3
              TabOrder = 1
              Text = '1'
              OnKeyPress = EditKeyPress
            end
            object udTitleFrameWidth: TUpDown
              Left = 88
              Top = 41
              Width = 15
              Height = 21
              HelpContext = 20044
              Associate = edtTitleFrameWidth
              Min = 1
              Position = 1
              TabOrder = 2
              Wrap = True
            end
            object btnTitleFrameColor: TButton
              Left = 8
              Top = 74
              Width = 75
              Height = 25
              HelpContext = 20045
              Caption = '&Color...'
              TabOrder = 3
              OnClick = btnTitleFrameColorClick
            end
            object cboTitleFrameStyle: TComboBox
              Left = 41
              Top = 108
              Width = 80
              Height = 21
              HelpContext = 20046
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
            object pnlTitleFrameColor: TPanel
              Left = 80
              Top = 16
              Width = 33
              Height = 25
              Caption = 'Color'
              TabOrder = 5
              Visible = False
            end
          end
          object grpFootAlign: TGroupBox
            Left = 268
            Top = 1
            Width = 81
            Height = 73
            Caption = 'Alignment'
            TabOrder = 10
            object radFootLeft: TRadioButton
              Left = 6
              Top = 16
              Width = 67
              Height = 17
              HelpContext = 20049
              Caption = '&Left'
              TabOrder = 0
            end
            object radFootCenter: TRadioButton
              Left = 6
              Top = 34
              Width = 67
              Height = 17
              HelpContext = 20050
              Caption = '&Center'
              Checked = True
              TabOrder = 1
              TabStop = True
            end
            object radFootRight: TRadioButton
              Left = 6
              Top = 51
              Width = 67
              Height = 17
              HelpContext = 20051
              Caption = '&Right'
              TabOrder = 2
            end
          end
          object chkFootAdjustFrame: TCheckBox
            Left = 8
            Top = 80
            Width = 97
            Height = 17
            HelpContext = 20052
            Caption = '&Adjust Frame'
            Checked = True
            State = cbChecked
            TabOrder = 4
          end
          object chkFootVisible: TCheckBox
            Left = 8
            Top = 48
            Width = 81
            Height = 17
            HelpContext = 20053
            Caption = '&Visible'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object mmoFoot: TMemo
            Left = 8
            Top = 144
            Width = 345
            Height = 121
            HelpContext = 20054
            ScrollBars = ssBoth
            TabOrder = 12
          end
          object mmoTitle: TMemo
            Left = 8
            Top = 144
            Width = 345
            Height = 121
            HelpContext = 20055
            ScrollBars = ssBoth
            TabOrder = 11
          end
          object cboTitle: TComboBox
            Left = 8
            Top = 8
            Width = 97
            Height = 21
            HelpContext = 20056
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            OnChange = cboTitleChange
            Items.Strings = (
              'Title'
              'Footer')
          end
          object chkTitleVisible: TCheckBox
            Left = 8
            Top = 48
            Width = 81
            Height = 17
            HelpContext = 20057
            Caption = '&Visible'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object btnTitleFont: TButton
            Left = 8
            Top = 112
            Width = 75
            Height = 25
            HelpContext = 20058
            Caption = 'Font...'
            TabOrder = 5
            OnClick = btnTitleFontClick
          end
          object grpTitleAlign: TGroupBox
            Left = 268
            Top = 1
            Width = 81
            Height = 73
            Caption = 'Alignment'
            TabOrder = 9
            object radTitleLeft: TRadioButton
              Left = 6
              Top = 16
              Width = 67
              Height = 17
              HelpContext = 20060
              Caption = '&Left'
              TabOrder = 0
            end
            object radTitleCenter: TRadioButton
              Left = 6
              Top = 34
              Width = 67
              Height = 17
              HelpContext = 20061
              Caption = '&Center'
              Checked = True
              TabOrder = 1
              TabStop = True
            end
            object radTitleRight: TRadioButton
              Left = 6
              Top = 51
              Width = 67
              Height = 17
              HelpContext = 20062
              Caption = '&Right'
              TabOrder = 2
            end
          end
          object chkTitleAdjustFrame: TCheckBox
            Left = 8
            Top = 80
            Width = 97
            Height = 17
            HelpContext = 20063
            Caption = '&Adjust Frame'
            Checked = True
            State = cbChecked
            TabOrder = 3
          end
        end
        object shtLegend: TTabSheet
          Caption = 'Legend'
          ImageIndex = 2
          object Label1: TLabel
            Left = 144
            Top = 8
            Width = 65
            Height = 13
            Caption = 'Legend &Style:'
            FocusControl = cboLegendStyle
          end
          object Label2: TLabel
            Left = 159
            Top = 34
            Width = 50
            Height = 13
            Caption = 'Text St&yle:'
            FocusControl = cboTextStyle
          end
          object chkLegendVisible: TCheckBox
            Left = 8
            Top = 6
            Width = 97
            Height = 17
            HelpContext = 20068
            Caption = '&Visible'
            TabOrder = 0
          end
          object btnLegendBackColor: TButton
            Left = 8
            Top = 32
            Width = 75
            Height = 25
            HelpContext = 20069
            Caption = 'Bac&k Color...'
            TabOrder = 1
            OnClick = btnLegendBackColorClick
          end
          object btnLegendFont: TButton
            Left = 8
            Top = 64
            Width = 75
            Height = 25
            HelpContext = 20070
            Caption = 'F&ont...'
            TabOrder = 2
            OnClick = btnLegendFontClick
          end
          object cboLegendStyle: TComboBox
            Left = 216
            Top = 4
            Width = 145
            Height = 21
            HelpContext = 20071
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 3
            Items.Strings = (
              'Automatic'
              'Series Names'
              'Series Values'
              'Last Values')
          end
          object cboTextStyle: TComboBox
            Left = 216
            Top = 30
            Width = 145
            Height = 21
            HelpContext = 20072
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 4
            Items.Strings = (
              'Plain'
              'Left Value'
              'Right Value'
              'Left Percent'
              'Right Percent'
              'X Value')
          end
          object chkResizeChart: TCheckBox
            Left = 216
            Top = 59
            Width = 97
            Height = 17
            HelpContext = 20073
            Caption = 'Resi&ze Chart'
            TabOrder = 5
          end
          object chkInverted: TCheckBox
            Left = 216
            Top = 75
            Width = 97
            Height = 17
            HelpContext = 20074
            Caption = '&Inverted'
            TabOrder = 6
          end
          object grpLegFrame: TGroupBox
            Left = 8
            Top = 96
            Width = 222
            Height = 85
            Caption = 'Frame'
            TabOrder = 7
            object Label3: TLabel
              Left = 112
              Top = 21
              Width = 31
              Height = 13
              Caption = 'Width:'
            end
            object Label14: TLabel
              Left = 97
              Top = 56
              Width = 26
              Height = 13
              Caption = 'Style:'
            end
            object chkLegFrameVisible: TCheckBox
              Left = 8
              Top = 19
              Width = 65
              Height = 17
              HelpContext = 20078
              Caption = 'Visible'
              TabOrder = 0
            end
            object edtLegFrameWidth: TEdit
              Left = 152
              Top = 17
              Width = 40
              Height = 21
              HelpContext = 20079
              MaxLength = 3
              TabOrder = 1
              Text = '1'
              OnKeyPress = EditKeyPress
            end
            object udLegFrameWidth: TUpDown
              Left = 192
              Top = 17
              Width = 16
              Height = 21
              HelpContext = 20080
              Associate = edtLegFrameWidth
              Min = 1
              Position = 1
              TabOrder = 2
              Wrap = True
            end
            object btnLegFrameColor: TButton
              Left = 8
              Top = 50
              Width = 75
              Height = 25
              HelpContext = 20081
              Caption = '&Color...'
              TabOrder = 3
              OnClick = btnLegFrameColorClick
            end
            object cboLegFrameStyle: TComboBox
              Left = 129
              Top = 52
              Width = 80
              Height = 21
              HelpContext = 20082
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
            object pnlLegFrameColor: TPanel
              Left = 72
              Top = 16
              Width = 33
              Height = 25
              Caption = 'Color'
              TabOrder = 5
              Visible = False
            end
          end
          object grpLegendPosition: TGroupBox
            Left = 232
            Top = 96
            Width = 129
            Height = 85
            Caption = 'Position'
            TabOrder = 8
            object Label4: TLabel
              Left = 8
              Top = 58
              Width = 35
              Height = 13
              Caption = '&Margin:'
            end
            object radLegendTop: TRadioButton
              Left = 68
              Top = 16
              Width = 56
              Height = 17
              HelpContext = 20086
              Caption = '&Top'
              TabOrder = 0
            end
            object radLegendLeft: TRadioButton
              Left = 8
              Top = 16
              Width = 59
              Height = 17
              HelpContext = 20087
              Caption = '&Left'
              TabOrder = 1
            end
            object radLegendRight: TRadioButton
              Left = 8
              Top = 32
              Width = 59
              Height = 17
              HelpContext = 20088
              Caption = '&Right'
              TabOrder = 2
            end
            object radLegendBottom: TRadioButton
              Left = 68
              Top = 32
              Width = 56
              Height = 17
              HelpContext = 20089
              Caption = '&Bottom'
              TabOrder = 3
            end
            object edtLegendMargin: TEdit
              Left = 56
              Top = 54
              Width = 40
              Height = 21
              HelpContext = 20090
              MaxLength = 3
              TabOrder = 4
              Text = '0'
              OnKeyPress = EditKeyPress
            end
            object udLegMargin: TUpDown
              Left = 96
              Top = 54
              Width = 16
              Height = 21
              HelpContext = 20091
              Associate = edtLegendMargin
              TabOrder = 5
              Wrap = True
            end
          end
          object grpLegendShadow: TGroupBox
            Left = 232
            Top = 184
            Width = 129
            Height = 85
            Caption = 'Shadow'
            TabOrder = 10
            object Label5: TLabel
              Left = 8
              Top = 56
              Width = 23
              Height = 13
              Caption = 'Siz&e:'
            end
            object btnLegShadowColor: TButton
              Left = 8
              Top = 20
              Width = 75
              Height = 25
              HelpContext = 20094
              Caption = '&Color...'
              TabOrder = 0
              OnClick = btnLegShadowColorClick
            end
            object edtLegShadowSize: TEdit
              Left = 40
              Top = 52
              Width = 40
              Height = 21
              HelpContext = 20095
              MaxLength = 3
              TabOrder = 1
              Text = '0'
              OnKeyPress = EditKeyPress
            end
            object udShadowSize: TUpDown
              Left = 80
              Top = 52
              Width = 16
              Height = 21
              HelpContext = 20096
              Associate = edtLegShadowSize
              TabOrder = 2
              Wrap = True
            end
            object pnlShadowColor: TPanel
              Left = 48
              Top = 28
              Width = 73
              Height = 17
              Caption = 'Shadow Color'
              TabOrder = 3
              Visible = False
            end
          end
          object grpLegDivLine: TGroupBox
            Left = 8
            Top = 184
            Width = 222
            Height = 85
            Caption = 'Dividing Lines'
            TabOrder = 9
            object Label6: TLabel
              Left = 112
              Top = 21
              Width = 31
              Height = 13
              Caption = 'Width:'
            end
            object Label23: TLabel
              Left = 97
              Top = 56
              Width = 26
              Height = 13
              Caption = 'Style:'
            end
            object chkDivLineVisible: TCheckBox
              Left = 8
              Top = 19
              Width = 65
              Height = 17
              HelpContext = 20101
              Caption = 'Visible'
              TabOrder = 0
            end
            object edtLegDivWidth: TEdit
              Left = 152
              Top = 17
              Width = 40
              Height = 21
              HelpContext = 20102
              MaxLength = 3
              TabOrder = 1
              Text = '1'
              OnKeyPress = EditKeyPress
            end
            object udLegDivWidth: TUpDown
              Left = 192
              Top = 17
              Width = 16
              Height = 21
              HelpContext = 20103
              Associate = edtLegDivWidth
              Min = 1
              Position = 1
              TabOrder = 2
              Wrap = True
            end
            object btnLegDLColor: TButton
              Left = 8
              Top = 50
              Width = 75
              Height = 25
              HelpContext = 20104
              Caption = '&Color...'
              TabOrder = 3
              OnClick = btnLegDLColorClick
            end
            object cboLegDLStyle: TComboBox
              Left = 129
              Top = 52
              Width = 80
              Height = 21
              HelpContext = 20105
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
            object pnlLegDLColor: TPanel
              Left = 72
              Top = 16
              Width = 33
              Height = 25
              Caption = 'Color'
              TabOrder = 5
              Visible = False
            end
          end
          object pnlLegend: TPanel
            Left = 88
            Top = 64
            Width = 89
            Height = 25
            Caption = 'Color and Font'
            TabOrder = 11
            Visible = False
          end
        end
        object shtPanel: TTabSheet
          Caption = 'Panel'
          ImageIndex = 3
          object btnPanelColor: TButton
            Left = 8
            Top = 8
            Width = 89
            Height = 25
            HelpContext = 20109
            Caption = '&Panel Color...'
            TabOrder = 0
            OnClick = btnPanelColorClick
          end
          object chkPanelBorder: TCheckBox
            Left = 112
            Top = 12
            Width = 97
            Height = 17
            HelpContext = 20110
            Caption = '&Border'
            TabOrder = 1
          end
          object grpGradient: TGroupBox
            Left = 8
            Top = 40
            Width = 241
            Height = 193
            Caption = 'Gradient'
            TabOrder = 2
            object pnlGEndColor: TShape
              Left = 104
              Top = 47
              Width = 33
              Height = 25
            end
            object pnlGStartColor: TShape
              Left = 104
              Top = 15
              Width = 33
              Height = 25
            end
            object chkGradVisible: TCheckBox
              Left = 9
              Top = 19
              Width = 73
              Height = 17
              HelpContext = 20114
              Caption = '&Visible'
              TabOrder = 0
            end
            object btnStartColor: TButton
              Left = 150
              Top = 15
              Width = 75
              Height = 25
              HelpContext = 20115
              Caption = '&Start Color...'
              TabOrder = 1
              OnClick = btnStartColorClick
            end
            object btnEndColor: TButton
              Left = 150
              Top = 47
              Width = 75
              Height = 25
              HelpContext = 20116
              Caption = '&End Color...'
              TabOrder = 2
              OnClick = btnEndColorClick
            end
            object grpDirection: TGroupBox
              Left = 8
              Top = 80
              Width = 217
              Height = 105
              Caption = '&Direction'
              TabOrder = 3
              object radGDirTopBot: TRadioButton
                Left = 8
                Top = 24
                Width = 81
                Height = 17
                HelpContext = 20118
                Caption = 'Top Bottom'
                Checked = True
                TabOrder = 0
                TabStop = True
              end
              object radGDirBotTop: TRadioButton
                Left = 8
                Top = 40
                Width = 81
                Height = 17
                HelpContext = 20119
                Caption = 'Bottom Top'
                TabOrder = 1
              end
              object radGDirLeftRight: TRadioButton
                Left = 8
                Top = 56
                Width = 81
                Height = 17
                HelpContext = 20120
                Caption = 'Left Right'
                TabOrder = 2
              end
              object radGDirFromBotLeft: TRadioButton
                Left = 104
                Top = 40
                Width = 105
                Height = 17
                HelpContext = 20121
                Caption = 'From Bottom Left'
                TabOrder = 5
              end
              object radGDirFromCenter: TRadioButton
                Left = 104
                Top = 24
                Width = 81
                Height = 17
                HelpContext = 20122
                Caption = 'From Center'
                TabOrder = 4
              end
              object radGDirRightLeft: TRadioButton
                Left = 8
                Top = 72
                Width = 81
                Height = 17
                HelpContext = 20123
                Caption = 'Right Left'
                TabOrder = 3
              end
              object radGDirFromTopLeft: TRadioButton
                Left = 104
                Top = 56
                Width = 105
                Height = 17
                HelpContext = 20124
                Caption = 'From Top Left'
                TabOrder = 6
              end
            end
          end
          object pnlPanelColor: TPanel
            Left = 272
            Top = 16
            Width = 33
            Height = 33
            Caption = 'pnlPanelColor'
            TabOrder = 3
            Visible = False
          end
        end
        object shtWalls: TTabSheet
          Caption = 'Walls'
          ImageIndex = 5
          object chkWallsVisible: TCheckBox
            Left = 8
            Top = 6
            Width = 97
            Height = 17
            HelpContext = 20127
            Caption = '&Visible Walls'
            TabOrder = 0
          end
          object pagWalls: TPageControl
            Left = 8
            Top = 32
            Width = 345
            Height = 217
            ActivePage = shtLeftWall
            TabOrder = 1
            object shtLeftWall: TTabSheet
              Caption = 'Left Wall'
              object Label20: TLabel
                Left = 24
                Top = 152
                Width = 23
                Height = 13
                Caption = '&Size:'
                FocusControl = edtLeftWallSize
              end
              object pnlLeftWallColor: TShape
                Left = 112
                Top = 16
                Width = 41
                Height = 25
              end
              object btnLeftBack: TButton
                Left = 8
                Top = 16
                Width = 97
                Height = 25
                HelpContext = 20132
                Caption = '&Background...'
                TabOrder = 0
                OnClick = btnLeftBackClick
              end
              object grpBorder: TGroupBox
                Left = 8
                Top = 56
                Width = 222
                Height = 85
                Caption = 'Border'
                TabOrder = 1
                object Label17: TLabel
                  Left = 112
                  Top = 18
                  Width = 31
                  Height = 13
                  Caption = '&Width:'
                  FocusControl = edtLeftWallWidth
                end
                object Label26: TLabel
                  Left = 97
                  Top = 56
                  Width = 26
                  Height = 13
                  Caption = 'Style:'
                end
                object chkLeftWallBVis: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  HelpContext = 20136
                  Caption = 'V&isible'
                  TabOrder = 0
                end
                object edtLeftWallWidth: TEdit
                  Left = 152
                  Top = 14
                  Width = 40
                  Height = 21
                  HelpContext = 20137
                  MaxLength = 3
                  TabOrder = 1
                  Text = '1'
                  OnKeyPress = EditKeyPress
                end
                object udLeftWallWidth: TUpDown
                  Left = 192
                  Top = 14
                  Width = 16
                  Height = 21
                  HelpContext = 20138
                  Associate = edtLeftWallWidth
                  Min = 1
                  Position = 1
                  TabOrder = 2
                  Wrap = True
                end
                object btnLeftWallBdrColor: TButton
                  Left = 8
                  Top = 50
                  Width = 75
                  Height = 25
                  HelpContext = 20139
                  Caption = '&Color...'
                  TabOrder = 3
                  OnClick = btnLeftWallBdrColorClick
                end
                object pnlLeftWallBdrColor: TPanel
                  Left = 72
                  Top = 16
                  Width = 33
                  Height = 25
                  Caption = 'Color'
                  TabOrder = 5
                  Visible = False
                end
                object cboLeftWallBdrStyle: TComboBox
                  Left = 129
                  Top = 52
                  Width = 80
                  Height = 21
                  HelpContext = 20141
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
              object chkLeftWallTrans: TCheckBox
                Left = 240
                Top = 64
                Width = 90
                Height = 17
                HelpContext = 20142
                Caption = '&Transparent'
                TabOrder = 2
              end
              object edtLeftWallSize: TEdit
                Left = 56
                Top = 148
                Width = 40
                Height = 21
                HelpContext = 20143
                MaxLength = 3
                TabOrder = 3
                Text = '0'
                OnKeyPress = EditKeyPress
              end
              object udLeftWallSize: TUpDown
                Left = 96
                Top = 148
                Width = 16
                Height = 21
                HelpContext = 20144
                Associate = edtLeftWallSize
                TabOrder = 4
                Wrap = True
              end
            end
            object shtBottomWall: TTabSheet
              Caption = 'Bottom Wall'
              ImageIndex = 1
              object Label21: TLabel
                Left = 24
                Top = 152
                Width = 23
                Height = 13
                Caption = '&Size:'
                FocusControl = edtBotWallSize
              end
              object pnlBotWallColor: TShape
                Left = 112
                Top = 16
                Width = 41
                Height = 25
              end
              object GroupBox2: TGroupBox
                Left = 8
                Top = 56
                Width = 222
                Height = 85
                Caption = 'Border'
                TabOrder = 0
                object Label18: TLabel
                  Left = 112
                  Top = 18
                  Width = 31
                  Height = 13
                  Caption = '&Width:'
                  FocusControl = edtBotWallWidth
                end
                object Label24: TLabel
                  Left = 97
                  Top = 56
                  Width = 26
                  Height = 13
                  Caption = 'Style:'
                end
                object chkBotWallBVis: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  HelpContext = 20151
                  Caption = 'V&isible'
                  TabOrder = 0
                end
                object edtBotWallWidth: TEdit
                  Left = 152
                  Top = 14
                  Width = 40
                  Height = 21
                  HelpContext = 20152
                  MaxLength = 3
                  TabOrder = 1
                  Text = '1'
                  OnKeyPress = EditKeyPress
                end
                object udBotWallWidth: TUpDown
                  Left = 192
                  Top = 14
                  Width = 16
                  Height = 21
                  HelpContext = 20153
                  Associate = edtBotWallWidth
                  Min = 1
                  Position = 1
                  TabOrder = 2
                  Wrap = True
                end
                object btnBotWallBdrColor: TButton
                  Left = 8
                  Top = 50
                  Width = 75
                  Height = 25
                  HelpContext = 20154
                  Caption = '&Color...'
                  TabOrder = 3
                  OnClick = btnBotWallBdrColorClick
                end
                object pnlBotWallBdrColor: TPanel
                  Left = 72
                  Top = 16
                  Width = 33
                  Height = 25
                  Caption = 'Color'
                  TabOrder = 4
                  Visible = False
                end
                object cboBotWallBdrStyle: TComboBox
                  Left = 129
                  Top = 52
                  Width = 80
                  Height = 21
                  HelpContext = 20156
                  Style = csDropDownList
                  ItemHeight = 13
                  TabOrder = 5
                  Items.Strings = (
                    'Solid'
                    'Dash'
                    'Dot'
                    'Dash Dot'
                    'Dash Dot Dot')
                end
              end
              object btnBotBack: TButton
                Left = 8
                Top = 16
                Width = 97
                Height = 25
                HelpContext = 20157
                Caption = '&Background...'
                TabOrder = 1
                OnClick = btnBotBackClick
              end
              object chkBotWallTrans: TCheckBox
                Left = 240
                Top = 64
                Width = 90
                Height = 17
                HelpContext = 20158
                Caption = '&Transparent'
                TabOrder = 2
              end
              object udBotWallSize: TUpDown
                Left = 96
                Top = 148
                Width = 16
                Height = 21
                HelpContext = 20159
                Associate = edtBotWallSize
                TabOrder = 3
                Wrap = True
              end
              object edtBotWallSize: TEdit
                Left = 56
                Top = 148
                Width = 40
                Height = 21
                HelpContext = 20160
                MaxLength = 3
                TabOrder = 4
                Text = '0'
                OnKeyPress = EditKeyPress
              end
            end
            object shtBackWall: TTabSheet
              Caption = 'Back Wall'
              ImageIndex = 2
              object Label22: TLabel
                Left = 24
                Top = 152
                Width = 23
                Height = 13
                Caption = '&Size:'
                FocusControl = edtBackWallSize
              end
              object pnlBackWallColor: TShape
                Left = 112
                Top = 16
                Width = 41
                Height = 25
              end
              object GroupBox5: TGroupBox
                Left = 8
                Top = 56
                Width = 220
                Height = 85
                Caption = 'Border'
                TabOrder = 0
                object Label19: TLabel
                  Left = 112
                  Top = 18
                  Width = 31
                  Height = 13
                  Caption = '&Width:'
                  FocusControl = edtBackWallWidth
                end
                object Label25: TLabel
                  Left = 97
                  Top = 56
                  Width = 26
                  Height = 13
                  Caption = 'Style:'
                end
                object chkBackWallBVis: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  HelpContext = 20167
                  Caption = 'V&isible'
                  TabOrder = 0
                end
                object edtBackWallWidth: TEdit
                  Left = 152
                  Top = 14
                  Width = 40
                  Height = 21
                  HelpContext = 20168
                  MaxLength = 3
                  TabOrder = 1
                  Text = '1'
                  OnKeyPress = EditKeyPress
                end
                object udBackWallWidth: TUpDown
                  Left = 192
                  Top = 14
                  Width = 16
                  Height = 21
                  HelpContext = 20169
                  Associate = edtBackWallWidth
                  Min = 1
                  Position = 1
                  TabOrder = 2
                  Wrap = True
                end
                object btnBackWallBdrColor: TButton
                  Left = 8
                  Top = 50
                  Width = 75
                  Height = 25
                  HelpContext = 20170
                  Caption = '&Color...'
                  TabOrder = 3
                  OnClick = btnBackWallBdrColorClick
                end
                object pnlBackWallBdrColor: TPanel
                  Left = 72
                  Top = 16
                  Width = 33
                  Height = 25
                  Caption = 'Color'
                  TabOrder = 4
                  Visible = False
                end
                object cboBackWallBdrStyle: TComboBox
                  Left = 129
                  Top = 52
                  Width = 80
                  Height = 21
                  HelpContext = 20172
                  Style = csDropDownList
                  ItemHeight = 13
                  TabOrder = 5
                  Items.Strings = (
                    'Solid'
                    'Dash'
                    'Dot'
                    'Dash Dot'
                    'Dash Dot Dot')
                end
              end
              object btnBackBack: TButton
                Left = 8
                Top = 16
                Width = 97
                Height = 25
                HelpContext = 20173
                Caption = '&Background...'
                TabOrder = 1
                OnClick = btnBackBackClick
              end
              object chkBackWallTrans: TCheckBox
                Left = 240
                Top = 64
                Width = 90
                Height = 17
                HelpContext = 20174
                Caption = '&Transparent'
                TabOrder = 2
              end
              object udBackWallSize: TUpDown
                Left = 96
                Top = 148
                Width = 16
                Height = 21
                HelpContext = 20175
                Associate = edtBackWallSize
                TabOrder = 3
                Wrap = True
              end
              object edtBackWallSize: TEdit
                Left = 56
                Top = 148
                Width = 40
                Height = 21
                HelpContext = 20176
                MaxLength = 3
                TabOrder = 4
                Text = '0'
                OnKeyPress = EditKeyPress
              end
            end
          end
        end
        object sht3D: TTabSheet
          Caption = '3D'
          ImageIndex = 4
          object grp3D: TGroupBox
            Left = 8
            Top = 4
            Width = 345
            Height = 265
            Caption = '3D'
            TabOrder = 0
            object Label7: TLabel
              Left = 8
              Top = 43
              Width = 28
              Height = 13
              Caption = '3&D %:'
            end
            object Label8: TLabel
              Left = 160
              Top = 24
              Width = 30
              Height = 13
              Caption = '&Zoom:'
            end
            object Label9: TLabel
              Left = 147
              Top = 48
              Width = 43
              Height = 13
              Caption = '&Rotation:'
            end
            object Label10: TLabel
              Left = 143
              Top = 73
              Width = 47
              Height = 13
              Caption = 'E&levation:'
            end
            object Label11: TLabel
              Left = 129
              Top = 122
              Width = 61
              Height = 13
              Caption = '&Horiz. Offset:'
            end
            object Label12: TLabel
              Left = 134
              Top = 146
              Width = 56
              Height = 13
              Caption = '&Vert. Offset:'
            end
            object lblZoom: TLabel
              Left = 304
              Top = 24
              Width = 26
              Height = 13
              Caption = '100%'
            end
            object lblRotation: TLabel
              Left = 304
              Top = 48
              Width = 12
              Height = 13
              Caption = '00'
            end
            object lblElevation: TLabel
              Left = 304
              Top = 73
              Width = 12
              Height = 13
              Caption = '00'
            end
            object lblHorizOffset: TLabel
              Left = 304
              Top = 122
              Width = 12
              Height = 13
              Caption = '00'
            end
            object lblVertOffset: TLabel
              Left = 304
              Top = 146
              Width = 12
              Height = 13
              Caption = '00'
            end
            object Label15: TLabel
              Left = 173
              Top = 97
              Width = 17
              Height = 13
              Caption = '&Tilt:'
            end
            object lblTilt: TLabel
              Left = 304
              Top = 97
              Width = 12
              Height = 13
              Caption = '00'
            end
            object Label16: TLabel
              Left = 47
              Top = 120
              Width = 38
              Height = 13
              Caption = 'Preview'
            end
            object chk3D: TCheckBox
              Left = 8
              Top = 16
              Width = 97
              Height = 17
              HelpContext = 20193
              Caption = '&3 Dimensions'
              TabOrder = 0
              OnClick = chk3DClick
            end
            object edt3DPct: TEdit
              Left = 44
              Top = 39
              Width = 40
              Height = 21
              HelpContext = 20194
              MaxLength = 3
              TabOrder = 1
              Text = '0'
              OnChange = edt3DPctChange
              OnKeyPress = EditKeyPress
            end
            object ud3DPct: TUpDown
              Left = 84
              Top = 39
              Width = 16
              Height = 21
              HelpContext = 20195
              Associate = edt3DPct
              TabOrder = 2
              Wrap = True
            end
            object chkOrthogonal: TCheckBox
              Left = 8
              Top = 72
              Width = 97
              Height = 17
              HelpContext = 20196
              Caption = '&Orthogonal'
              TabOrder = 3
              OnClick = chkOrthogonalClick
            end
            object barZoom: TScrollBar
              Left = 198
              Top = 22
              Width = 100
              Height = 16
              HelpContext = 20197
              Max = 600
              PageSize = 0
              Position = 100
              TabOrder = 4
              OnChange = barZoomChange
            end
            object barRotation: TScrollBar
              Left = 198
              Top = 46
              Width = 100
              Height = 16
              HelpContext = 20198
              Max = 360
              PageSize = 0
              TabOrder = 5
              OnChange = barRotationChange
            end
            object barElevation: TScrollBar
              Left = 198
              Top = 71
              Width = 100
              Height = 16
              HelpContext = 20199
              Max = 360
              PageSize = 0
              TabOrder = 6
              OnChange = barElevationChange
            end
            object barHorizOffset: TScrollBar
              Left = 198
              Top = 120
              Width = 100
              Height = 16
              HelpContext = 20200
              Min = -100
              PageSize = 0
              TabOrder = 7
              OnChange = barHorizOffsetChange
            end
            object barVertOffset: TScrollBar
              Left = 198
              Top = 144
              Width = 100
              Height = 16
              HelpContext = 20201
              Min = -100
              PageSize = 0
              TabOrder = 8
              OnChange = barVertOffsetChange
            end
            object barTilt: TScrollBar
              Left = 198
              Top = 95
              Width = 100
              Height = 16
              HelpContext = 20202
              Max = 180
              Min = -180
              PageSize = 0
              TabOrder = 9
              OnChange = barTiltChange
            end
            object chtPreview: TChart
              Left = 6
              Top = 138
              Width = 121
              Height = 121
              HelpContext = 20203
              BackWall.Brush.Color = clWhite
              BackWall.Brush.Style = bsClear
              Title.Text.Strings = (
                'TChart')
              Title.Visible = False
              BottomAxis.Labels = False
              LeftAxis.Labels = False
              Legend.Visible = False
              RightAxis.Labels = False
              TabOrder = 10
              object Series1: TLineSeries
                Marks.ArrowLength = 8
                Marks.Visible = False
                SeriesColor = clRed
                Pointer.InflateMargins = True
                Pointer.Style = psRectangle
                Pointer.Visible = False
                XValues.DateTime = False
                XValues.Name = 'X'
                XValues.Multiplier = 1.000000000000000000
                XValues.Order = loAscending
                YValues.DateTime = False
                YValues.Name = 'Y'
                YValues.Multiplier = 1.000000000000000000
                YValues.Order = loNone
              end
            end
          end
        end
      end
    end
  end
  object dlgFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 128
    Top = 68
  end
  object dlgColor: TColorDialog
    Left = 312
    Top = 100
  end
end
