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
unit uCppProcLexer;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, uBricxCCProcLexer, uParseCommon;

type
  TCppProcLexer = class(TBricxCCProcLexer)
  protected
    fLanguage : TExploredLanguage;
    procedure HandleCppProcFound(pidx, lineNo : Integer;
      pline, ptype, pname, pclass, pargs, retType : string);
    procedure Execute; override;
    function GetLanguage: TExploredLanguage; override;
  end;

  TJavaProcLexer = class(TCppProcLexer)
  protected
    function GetLanguage: TExploredLanguage; override;
  end;

implementation

uses
  SysUtils, mwBCBTokenList;

{ TCppProcLexer }

procedure TCppProcLexer.Execute;
var
  CParser : TBCBTokenList;
  Stream: TStringStream;
  MStream : TMemoryStream;
  tOut : Cardinal;
begin
  tOut := Cardinal(Timeout);
  CParser := TBCBTokenList.Create;
  try
    Stream := TStringStream.Create(TextToParse);
    try
      Stream.Position := 0;
      MStream := TMemoryStream.Create;
      try
        MStream.LoadFromStream(Stream);
        CParser.SetOrigin(MStream.Memory, MStream.Size);
        FindCppProcs(tOut, CParser, Language, HandleCppProcFound);
      finally
        MStream.Free;
      end;
    finally
      Stream.Free;
    end;
  finally
    CParser.Free;
  end;
end;

function TCppProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elCpp;
end;

procedure TCppProcLexer.HandleCppProcFound(pidx, lineNo: Integer; pline,
  ptype, pname, pclass, pargs, retType: string);
begin
  Results := Results + IntToStr(lineNo-1) + '|' + ptype + '|' + pname + #13#10;
end;

{ TJavaProcLexer }

function TJavaProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elJava;
end;

end.
