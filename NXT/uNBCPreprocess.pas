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
unit uNBCPreprocess;

interface

uses
  uPreprocess;

type
  TNBCLangPreprocessor = class(TLangPreprocessor)
  private
    function ImportRIC(const fname, varname: string): string;
  protected
    function ImportFile(const fname : string; varname : string) : string; override;
  end;

implementation

uses
  SysUtils, uRICCompBase;

{ TNBCLangPreprocessor }

function TNBCLangPreprocessor.ImportRIC(const fname, varname: string): string;
var
  RC : TRICCompBase;
begin
  RC := TRICCompBase.Create;
  try
    RC.LoadFromFile(fname);
    Result := RC.SaveAsDataArray(LanguageName, varname);
  finally
    RC.Free;
  end;
end;

function TNBCLangPreprocessor.ImportFile(const fname : string; varname: string): string;
begin
  if LowerCase(ExtractFileExt(fname)) = '.ric' then
  begin
    Result := ImportRIC(fname, varname);
  end
  else
    Result := inherited ImportFile(fname, varname);
end;

end.