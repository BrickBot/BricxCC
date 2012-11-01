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
unit uForthProcLexer;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, uGenLexer, uBricxCCProcLexer, uParseCommon;

type
  TForthLexer = class(TGenLexer)
  protected
    procedure InitForLanguage(Lex: TGenLexer); override;
  public
    constructor CreateLexer; override;
  end;

  TForthProcLexer = class(TBricxCCProcLexer)
  protected
    procedure HandleForthProcFound(lineNo : Integer; pname, ptype : string);
    procedure Execute; override;
    function GetLanguage: TExploredLanguage; override;
  end;

procedure FindForthProcs(Timeout : Cardinal; FLexer : TForthLexer;
  Proc : TForthProcessProc);

implementation

uses
  SysUtils, mwGenericLex, uGuiUtils;

{ TForthProcLexer }

procedure TForthProcLexer.Execute;
var
  Lex: TForthLexer;
  Stream: TStringStream;
  MStream : TMemoryStream;
  tOut : Cardinal;
begin
  tOut := Cardinal(Timeout);
  Lex := TForthLexer.CreateLexer;
  try
    Stream := TStringStream.Create(TextToParse);
    try
      Stream.Position := 0;
      MStream := TMemoryStream.Create;
      try
        MStream.LoadFromStream(Stream);
        Lex.Origin := MStream.Memory;
        Lex.EndPos := Stream.Size;
        FindForthProcs(tOut, Lex, HandleForthProcFound);
      finally
        MStream.Free;
      end;
    finally
      Stream.Free;
    end;
  finally
    Lex.Free;
  end;
end;

function TForthProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elForth;
end;

procedure TForthProcLexer.HandleForthProcFound(lineNo: Integer; pname,
  ptype: string);
begin
  Results := Results + IntToStr(lineNo-1) + '|void|' + pname + #13#10;
end;

{ TForthLexer }

constructor TForthLexer.CreateLexer;
begin
  inherited CreateLexer;
  Sensitive := False;
end;

procedure TForthLexer.InitForLanguage(Lex: TGenLexer);
var
  Pat, OptPat: TAny;
begin
  { Space}
  Pat := TAny.Create(nil);
  Pat.CharClass := [#1..#9, #11, #12, #14..#32];
  Pat.Id := piSpace;
  Lex.Add(Pat);

  { LineEnd}
  Pat := TAny.Create(nil);
  Pat.Kind := pkLineEnd;
  Pat.Id := piLineEnd;
  Pat.Max := 1;
  Lex.Add(Pat);

  { Identifier}
  Pat := TIdentifier.Create(nil);
  Pat.CharClass := [#33..#126];
  Lex.Add(Pat);

  { Symbol, Comment }
  Pat := TAny.Create(nil);
  Pat.Key := '()';
  Pat.Min := 1;
  Pat.Id := piIdent;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '(';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  Pat := TAny.Create(OptPat);
  Pat.Key := ')';
  Pat.Id := piComment;
  Pat.Kind := pkTillKey;
  Pat.MultiLine := True;

  Pat := TAny.Create(nil);
  Pat.Key := '\';
  Pat.Min := 1;
  Pat.Id  := piComment;
  Lex.Add(Pat);
  OptPat := TTillLineEnd.Create(Pat);
  OptPat.Id := piComment;

  {string}
  Pat := TAny.Create(nil);
  Pat.Key := '."';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '.';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;       // piIdent
  Pat.AddOption(OptPat);
  Pat := TAny.Create(Pat);
  Pat.Key := '"';
  Pat.Id := piString;
  Pat.Kind := pkTillKey;
  Pat.MultiLine := True;

  {string}
  Pat := TAny.Create(nil);
  Pat.Key := 'ABORT"';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'ABORT';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'ABOR';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'ABO';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'AB';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'A';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  Pat := TAny.Create(Pat);
  Pat.Key := '"';
  Pat.Id := piString;
  Pat.Kind := pkTillKey;
  Pat.MultiLine := True;

  {keywords}
  Pat := TAny.Create(nil);
  Pat.Key := ':';
  Pat.Id  := piKeyWord;
  Pat.Min := 1;
//  Pat.Max := 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
end;

procedure FindForthProcs(Timeout : Cardinal; FLexer : TForthLexer;
  Proc : TForthProcessProc);
var
  bInProc: Boolean;
  j: Integer;
  LineNo: Integer;
  ProcName : string;
  ProcedureType : string;
  t, lt: string;
  start : cardinal;
begin
  start := GetTick;
  bInProc := False;
  while not FLexer.AtEnd do
  begin
    try
      repeat
        FLexer.Next;
        t := FLexer.Token;
      until (not (FLexer.Id in [piSpace, piComment])) or FLexer.AtEnd;
    except
      Break;
    end;
    lt := Lowercase(t);
    if (FLexer.Id = piKeyword) and (lt = ':') then
    begin
      bInProc := True;
      ProcName := '';
    end
    else if bInProc and
            ((FLexer.Id = piLineEnd) or (FLexer.Id = piSpace)) then
    begin
      bInProc := False;
      if FLexer.Id = piLineEnd then
        LineNo := FLexer.LinePos
      else
        LineNo := FLexer.LinePos + 1;
      // now split ProcName into procedure type & procedure name
      j := Pos('|', ProcName);
      ProcedureType := Copy(ProcName, 1, j-1);
      ProcName      := Copy(ProcName, j+1, Length(ProcName));

      Proc(LineNo, ProcName, ProcedureType);
    end;

    if bInProc then
    begin
      if ProcName = '' then
        ProcName := lt
      else
      begin
        // we only want to end up with something like blah|foo so
        // don't add anything if the | is already there
        if Pos('|', ProcName) = 0 then
          ProcName := ProcName + '|' + t;
      end;
    end;
    if (GetTick - start) > Timeout then Break;
  end;
end;

end.