object frmCompStatus: TfrmCompStatus
  Left = 577
  Top = 238
  Width = 362
  Height = 236
  BorderStyle = bsSizeToolWin
  Caption = 'Compiler Status'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    354
    202)
  PixelsPerInch = 96
  TextHeight = 13
  object edtMemo: TMemo
    Left = 8
    Top = 7
    Width = 337
    Height = 164
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object btnClose: TButton
    Left = 270
    Top = 174
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = btnCloseClick
  end
end
