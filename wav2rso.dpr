(*
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Initial Developer of this code is John Hansen.
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
program wav2rso;

uses
{$IFNDEF FPC}
  FastMM4,
  FastMove,
  XPMan,
{$ELSE}
  Interfaces,
{$ENDIF}
  Forms,
  uWav2RSO in 'uWav2RSO.pas' {frmWave2RSO},
  uSrcZoh in 'samplerate\uSrcZoh.pas',
  uSrcLinear in 'samplerate\uSrcLinear.pas',
  uSrcSinc in 'samplerate\uSrcSinc.pas',
  uSrcCommon in 'samplerate\uSrcCommon.pas',
  uSrc in 'samplerate\uSrc.pas',
  uCommonUtils in 'uCommonUtils.pas',
  uWav2RsoCvt in 'uWav2RsoCvt.pas';

{$IFNDEF FPC}
{$R *.res}
{$ENDIF}

begin
  Application.Initialize;
  Application.Title := 'WAV 2 RSO';
  Application.CreateForm(TfrmWave2RSO, frmWave2RSO);
  Application.Run;
end.