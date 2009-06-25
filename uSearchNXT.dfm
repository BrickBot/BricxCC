object frmSearchNXT: TfrmSearchNXT
  Left = 535
  Top = 318
  BorderStyle = bsToolWindow
  Caption = 'Searching for NXTs'
  ClientHeight = 35
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -32
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 36
  object barProgress: TProgressBar
    Left = 0
    Top = 0
    Width = 353
    Height = 35
    Align = alClient
    TabOrder = 0
  end
  object tmrMain: TTimer
    Interval = 50
    OnTimer = tmrMainTimer
    Left = 16
  end
end
