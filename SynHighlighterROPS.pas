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
unit SynHighlighterROPS;

{$I BricxCCSynEdit.inc}

interface

uses
  Classes, SynHighlighterPas;

type
  TSynROPSSyn = class(TSynPasSyn)
  protected
    function GetSampleSource: string; override;                                 //pp 2001-08-13
    function IsFilterStored: boolean; override;                                 //mh 2000-10-08
  public
    constructor Create(AOwner: TComponent); override;
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}
    function GetLanguageName: string; override;
  end;

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  SYNS_LangPascalScript   = 'Pascal Script';
  SYNS_FilterPascalScript = 'Pascal Script Files (*.rops)|*.rops';


implementation

{ TSynROPSSyn }

constructor TSynROPSSyn.Create(AOwner: TComponent);
begin
  inherited;
  fDefaultFilter := SYNS_FilterPascalScript;
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}
function TSynROPSSyn.GetLanguageName: string;
begin
  Result := SYNS_LangPascalScript;
end;

function TSynROPSSyn.GetSampleSource: string;
begin
  Result :=
    '{ Syntax highlighting }'#13#10 +
    'program test;'#13#10 +
    'var'#13#10 +
    '  Number, I, X: Integer;'#13#10 +
    'begin'#13#10 +
    '  Number := 123456;'#13#10 +
    '  Self.Caption := ''The Number is'' + #32 + IntToStr(Number);'#13#10 +
    '  for I := 0 to Number do'#13#10 +
    '  begin'#13#10 +
    '    Inc(X);'#13#10 +
    '    Dec(X);'#13#10 +
    '    X := X + 1.0;'#13#10 +
    '    X := X - $5E;'#13#10 +
    '  end;'#13#10 +
    'end.';
end;

function TSynROPSSyn.IsFilterStored: boolean;
begin
  Result := fDefaultFilter <> SYNS_FilterPascalScript;
end;

end.