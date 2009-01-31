object Form1: TForm1
  Left = 195
  Top = 227
  Width = 696
  Height = 480
  Caption = 'Form1'
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
  object sbUpload: TSpeedButton
    Left = 208
    Top = 152
    Width = 23
    Height = 22
    Caption = '->'
    Enabled = False
    OnClick = sbUploadClick
  end
  object sbDownload: TSpeedButton
    Left = 208
    Top = 288
    Width = 23
    Height = 22
    Caption = '<-'
    Enabled = False
    OnClick = sbDownloadClick
  end
  object lblDir: TLabel
    Left = 264
    Top = 96
    Width = 109
    Height = 13
    Caption = 'G:\nxt\BricxCC\source'
  end
  object Label1: TLabel
    Left = 432
    Top = 56
    Width = 65
    Height = 13
    Caption = 'Battery Level:'
  end
  object Label2: TLabel
    Left = 432
    Top = 104
    Width = 63
    Height = 13
    Caption = 'Free memory:'
    Visible = False
  end
  object NXTFiles: TListBox
    Left = 40
    Top = 136
    Width = 145
    Height = 233
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
    OnClick = NXTFilesClick
  end
  object chkBluetooth: TCheckBox
    Left = 40
    Top = 24
    Width = 97
    Height = 17
    Caption = 'Bluetooth'
    TabOrder = 1
  end
  object edtComPort: TEdit
    Left = 40
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'usb'
  end
  object btnListFiles: TButton
    Left = 40
    Top = 80
    Width = 75
    Height = 25
    Caption = 'List Files'
    Enabled = False
    TabOrder = 3
    OnClick = btnListFilesClick
  end
  object btnOpen: TButton
    Left = 176
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 4
    OnClick = btnOpenClick
  end
  object lstFiles: TFileListBox
    Left = 264
    Top = 224
    Width = 153
    Height = 145
    FileEdit = edtFile
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 5
  end
  object dlbDirectories: TDirectoryListBox
    Left = 264
    Top = 112
    Width = 153
    Height = 81
    DirLabel = lblDir
    FileList = lstFiles
    ItemHeight = 16
    TabOrder = 6
  end
  object dcbDrives: TDriveComboBox
    Left = 264
    Top = 72
    Width = 153
    Height = 19
    DirList = dlbDirectories
    TabOrder = 7
  end
  object edtFile: TEdit
    Left = 264
    Top = 198
    Width = 153
    Height = 21
    TabOrder = 8
    Text = '*.*'
  end
  object btnClose: TButton
    Left = 176
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Close'
    Enabled = False
    TabOrder = 9
    OnClick = btnCloseClick
  end
  object edtMask: TEdit
    Left = 40
    Top = 112
    Width = 145
    Height = 21
    TabOrder = 10
    Text = '*.*'
  end
  object btnDelete: TButton
    Left = 40
    Top = 376
    Width = 57
    Height = 25
    Caption = 'Delete'
    Enabled = False
    TabOrder = 11
    OnClick = btnDeleteClick
  end
  object edtBatteryLevel: TEdit
    Left = 432
    Top = 74
    Width = 121
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 12
  end
  object edtFreeMem: TEdit
    Left = 432
    Top = 122
    Width = 121
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 13
    Visible = False
  end
  object btnListModules: TButton
    Left = 104
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Modules'
    TabOrder = 14
    OnClick = btnListModulesClick
  end
end
