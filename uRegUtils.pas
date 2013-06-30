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
unit uRegUtils;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I bricxcc.inc}

interface

uses
  Registry, Graphics;

const
  K_MAINKEY       = '\Software\BricxCC';
  K_VERSION       = '3.3';

var
  fMainKey : string = K_MAINKEY;
  fVersion : string = K_VERSION;


procedure DeleteMainKey;
procedure Reg_OpenKey(r : TRegistry; name:string);
procedure Reg_DeleteKey(r : TRegistry; name:string);
function Reg_KeyExists(r : TRegistry; name:string):boolean;
function Reg_ReadBool(r: TRegistry; name:string; def:boolean):boolean;
function Reg_ReadInteger(r: TRegistry; name:string; def:integer):integer;
function Reg_ReadString(r: TRegistry; name:string; def:string):string;
procedure Reg_WriteStyle(r : TRegistry; name:string; val:TFontStyles);
function Reg_ReadStyle(r : TRegistry; name:string; def:TFontStyles):TFontStyles;
procedure Reg_WriteColor(r : TRegistry; name:string; val:TColor);
function Reg_ReadColor(r : TRegistry; name:string; def:TColor) : TColor;

implementation

{$IFNDEF FPC}
uses
  Windows;
{$ENDIF}

procedure DeleteMainKey;
var
  tmpReg : TRegistry;
begin
  tmpReg := TRegistry.Create;
  try
    tmpReg.DeleteKey(fMainKey + '\' + fVersion);
  finally
    tmpReg.Free;
  end;
end;

procedure Reg_OpenKey(r : TRegistry; name:string);
begin
  {Opens the registry key}
  r.OpenKey(fMainKey+'\'+fVersion+'\'+name,true);
end;

procedure Reg_DeleteKey(r : TRegistry; name:string);
begin
  {Deletes the registry key}
  r.DeleteKey(fMainKey+'\'+fVersion+'\'+name);
end;

function Reg_KeyExists(r : TRegistry; name:string):boolean;
begin
  Result := r.KeyExists(fMainKey+'\'+fVersion+'\'+name);
end;

{-- Booleans --}

function Reg_ReadBool(r: TRegistry; name:string; def:boolean):boolean;
begin
  {Read a boolean value from the registry. Returns the
   default when it does not exist.}
  if r.ValueExists(name) then
    Result := r.ReadBool(name)
  else
    Result := def;
end;

{-- Integers --}

function Reg_ReadInteger(r: TRegistry; name:string; def:integer):integer;
begin
  {Read a integer value from the registry. Returns the
   default when it does not exist.}
  if r.ValueExists(name) then
    Result := r.ReadInteger(name)
  else
    Result := def;
end;

{-- Strings --}

function Reg_ReadString(r: TRegistry; name:string; def:string):string;
begin
  {Read a string value from the registry. Returns the
   default when it does not exist.}
  if r.ValueExists(name) then
    Result := r.ReadString(name)
  else
    Result := def;
end;

{-- Styles --}

procedure Reg_WriteStyle(r : TRegistry; name:string; val:TFontStyles);
var
  tt : integer;
begin
{Writes a style value to the registry}
  tt := 0;
  if fsBold in val then tt := tt+1;
  if fsItalic in val then tt := tt+2;
  r.WriteInteger(name,tt);
end;

function Reg_ReadStyle(r : TRegistry; name:string; def:TFontStyles):TFontStyles;
var
  tt : integer;
begin
  {Read a style value from the registry. Returns the default when it does not exist.}
  if r.ValueExists(name) then
  begin
    tt := r.ReadInteger(name);
    Result := [];
    if (tt and 1) > 0 then Result := Result + [fsBold];
    if (tt and 2) > 0 then Result := Result + [fsItalic];
  end
  else
    Result := def;
end;

{-- Colors --}

procedure Reg_WriteColor(r : TRegistry; name:string; val:TColor);
begin
  {Writes a color value to the registry}
  r.WriteInteger(name,integer(val));
end;

function Reg_ReadColor(r : TRegistry; name:string; def:TColor) : TColor;
begin
//  Read a color value from the registry. Returns the default when it does not exist.
  if r.ValueExists(name) then
  begin
    Result := TColor(r.ReadInteger(name));
{$IFDEF VER_D7_UP}
    // handle D7/D5 differences
    //  clSystemColor = $FF000000 in D7, $80000000 in D5
    if (Result and not $80000000) in [0..COLOR_ENDCOLORS] then
      Result := (Result and not $80000000) or TColor(clSystemColor);
{$ENDIF}
  end
  else
    Result := def;
end;

end.