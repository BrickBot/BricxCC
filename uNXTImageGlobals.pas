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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uNXTImageGlobals;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Registry, Graphics;

var
  LCDBackgroundColor : TColor = clMoneyGreen;
  DefaultNXTImageFileExt : string = '.png';
  BaseNXTImageFilenameFormat : string = 'nxtimage_';
  DefaultNXTImageDirectory : string;
  NXTImageIndex : integer = 0;
  NXTImageUseIndex : boolean = True;
  NXTImageScale : integer = 6; // 2.5x
  NXTImageMaxFramesPerMovie : integer = 1000;
  NXTImageDefaultRefreshRate : integer = 1000;


procedure LoadNXTImageValues(reg : TRegistry);
procedure SaveNXTImageValues(reg : TRegistry);
procedure ResetNXTImageValues(reg : TRegistry);

implementation

uses
{$IFNDEF FPC}
  SHFolder,
  Windows,
{$ENDIF}
  SysUtils, uNXTImage, uRegUtils, uGlobals;

procedure LoadNXTImageValues(reg : TRegistry);
begin
  Reg_OpenKey(reg, 'NXTImageValues');
  try
    LCDBackgroundColor := Reg_ReadColor(reg, 'LCDBackgroundColor', LCDBackgroundColor);
    DefaultNXTImageFileExt := Reg_ReadString(reg, 'DefaultNXTImageFileExt', DefaultNXTImageFileExt);
    BaseNXTImageFilenameFormat := Reg_ReadString(reg, 'BaseNXTImageFilenameFormat', BaseNXTImageFilenameFormat);
    DefaultNXTImageDirectory := Reg_ReadString(reg, 'DefaultNXTImageDirectory', DefaultNXTImageDirectory);
    NXTImageIndex := Reg_ReadInteger(reg, 'NXTImageIndex', NXTImageIndex);
    NXTImageUseIndex := Reg_ReadBool(reg, 'NXTImageUseIndex', NXTImageUseIndex);
    NXTImageScale := Reg_ReadInteger(reg, 'NXTImageScale', NXTImageScale);
    NXTImageMaxFramesPerMovie := Reg_ReadInteger(reg, 'NXTImageMaxFramesPerMovie', NXTImageMaxFramesPerMovie);
    NXTImageDefaultRefreshRate := Reg_ReadInteger(reg, 'NXTImageDefaultRefreshRate', NXTImageDefaultRefreshRate);
  finally
    reg.CloseKey;
  end;
end;

procedure SaveNXTImageValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'NXTImageValues');
  Reg_OpenKey(reg, 'NXTImageValues');
  try
    Reg_WriteColor(reg, 'LCDBackgroundColor', LCDBackgroundColor);
    reg.WriteString('DefaultNXTImageFileExt', DefaultNXTImageFileExt);
    reg.WriteString('BaseNXTImageFilenameFormat', BaseNXTImageFilenameFormat);
    reg.WriteString('DefaultNXTImageDirectory', DefaultNXTImageDirectory);
    reg.WriteInteger('NXTImageIndex', NXTImageIndex);
    reg.WriteBool('NXTImageUseIndex', NXTImageUseIndex);
    reg.WriteInteger('NXTImageScale', NXTImageScale);
    reg.WriteInteger('NXTImageMaxFramesPerMovie', NXTImageMaxFramesPerMovie);
    reg.WriteInteger('NXTImageDefaultRefreshRate', NXTImageDefaultRefreshRate);
  finally
    reg.CloseKey;
  end;
end;

procedure ResetNXTImageValues(reg : TRegistry);
begin
  Reg_DeleteKey(reg, 'NXTImageValues');
  LoadNXTImageValues(reg);
end;

initialization

{$IFNDEF FPC}
  DefaultNXTImageDirectory := IncludeTrailingPathDelimiter(GetSpecialFolderPath(CSIDL_MYPICTURES));
{$ELSE}
  DefaultNXTImageDirectory := IncludeTrailingPathDelimiter(ExpandFilename('~')) + 'Documents/';
{$ENDIF}

end.