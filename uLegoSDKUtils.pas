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
unit uLegoSDKUtils;

interface

function GetSDKRootPath : string;

implementation

uses
  SysUtils, Registry, uCommonUtils;

function GetSDKRootPath : string;
const
  K_VPBCOM = 'Vpbcom.VPBrick\CLSID';
var
  R : TRegistry;
  g, p : string;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CLASSES_ROOT;
    if R.OpenKeyReadOnly(K_VPBCOM) then
    begin
      g := R.ReadString(''); // read default value
      R.CloseKey;
      if (g <> '') and R.OpenKeyReadOnly('CLSID\' + g + '\InprocServer32') then
      begin
        p := R.ReadString(''); // read default value
        R.CloseKey;
        if p <> '' then
          Result := ExtractFilePath(p);
      end;
    end;
  finally
    R.Free;
  end;
end;


end.