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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uPasProcLexer;

interface

uses
  Classes, uBricxCCProcLexer, mPasLex, uParseCommon;

type
  TPasProcLexer = class(TBricxCCProcLexer)
  protected
    procedure HandleProcFound(line : string; ptype : TTokenKind;
      lineNo : integer; isClass : Boolean);
    procedure Execute; override;
    function GetLanguage: TExploredLanguage; override;
  end;

implementation

uses
{$IFDEF FPC}
  LCLIntf,
{$ENDIF}
  SysUtils;

function ProcessProcLine(const aLine: string; var DispName : string): Boolean;
var
  TempStr : string;
begin
  Result := False;
  TempStr := ProcessPascalName(CompressWhiteSpace(aLine));
  // Check for an implementation procedural type
  if Length(TempStr) = 0 then
    Exit;
  TempStr := RemoveTrailingSemicolon(TempStr);
  // return as a var parameter
  DispName := TempStr;
  Result := True;
end;

{ TPasProcLexer }

procedure TPasProcLexer.Execute;
var
  Parser: TmwPasLex;
  Stream: TStringStream;
  MStream : TMemoryStream;
  tOut : Cardinal;
begin
  tOut := Cardinal(Timeout);
  Parser := TmwPasLex.Create;
  try
    Stream := TStringStream.Create(TextToParse);
    try
      Stream.Position := 0;
      MStream := TMemoryStream.Create;
      try
        MStream.LoadFromStream(Stream);
        Parser.Origin := MStream.Memory;
        FindPascalProcs(tOut, Parser, HandleProcFound);
      finally
        MStream.Free;
      end;
    finally
      Stream.Free;
    end;
  finally
    Parser.Free;
  end;
end;

function TPasProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elPas;
end;

procedure TPasProcLexer.HandleProcFound(line: string; ptype: TTokenKind;
  lineNo: integer; isClass: Boolean);
var
  ProcName : string;
begin
  if ProcessProcLine(line, ProcName) then
  begin
    Results := Results + IntToStr(lineNo-1) + '|';
    Results := Results + GetProperProcName(ptype, isClass) + '|' + ProcName + #13#10;
  end;
end;

end.
