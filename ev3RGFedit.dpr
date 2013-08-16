//------------------------------------------------------------------------------
// nxtRICedit - (C) 2006 Andreas Dreier
//                       Dorfleite 17
//                       86641 Staudheim
//                       Germany
//------------------------------------------------------------------------------
// Image editor for the RGF graphic images of the EV3
//------------------------------------------------------------------------------
// 03/2006  AD  Creation of program
// 04/2006  AD  Correction of save function (error detected by Philo)
// 04/2006  AD  Correction of save function (border and data bytes)
//------------------------------------------------------------------------------

program ev3RGFedit;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses
{$IFNDEF FPC}
{$ELSE}
  Interfaces,
{$ENDIF}
  Forms,
  ev3RGFedit_Basis in 'ev3RGFedit_Basis.pas',
  ev3RGFedit_MainForm in 'ev3RGFedit_MainForm.pas' {frmEV3RGFEDIT},
  ev3RGFedit_AddText in 'ev3RGFedit_AddText.pas' {frmAddText},
  ev3RGFEdit_FileOpen in 'ev3RGFEdit_FileOpen.pas' {frmFileOpen},
  ev3RGFedit_FileSave in 'ev3RGFedit_FileSave.pas' {frmFileSave},
  ev3RGFedit_FileImport in 'ev3RGFedit_FileImport.pas' {frmImageImport};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmEV3RGFEDIT, frmEV3RGFEDIT);
  Application.CreateForm(TfrmAddText, frmAddText);
  Application.CreateForm(TfrmFileSave, frmFileSave);
  Application.Run;
end.

