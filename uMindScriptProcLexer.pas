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
unit uMindScriptProcLexer;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, uGenLexer, uBricxCCProcLexer, uParseCommon;

type
  TMindScriptLexer = class(TGenLexer)
  protected
    procedure InitForLanguage(Lex: TGenLexer); override;
  public
    constructor CreateLexer; override;
  end;

  TMindScriptProcLexer = class(TBricxCCProcLexer)
  protected
    procedure HandleMindscriptProcFound(lineNo : Integer; pname, ptype : string);
    procedure Execute; override;
    function GetLanguage: TExploredLanguage; override;
  end;

procedure FindMindscriptProcs(Timeout : Cardinal; MLexer : TMindScriptLexer;
  Proc : TMindscriptProcessProc);

implementation

uses
  SysUtils, mwGenericLex, uGuiUtils;

procedure FindMindscriptProcs(Timeout : Cardinal; MLexer : TMindScriptLexer; Proc : TMindscriptProcessProc);
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
  while not MLexer.AtEnd do
  begin
    try
      repeat
        MLexer.Next;
        t := MLexer.Token;
      until (not (MLexer.Id in [piSpace, {piLineEnd, piInnerLineEnd, }piComment])) or MLexer.AtEnd;
    except
      Break;
    end;
    lt := Lowercase(t);
    if (MLexer.Id = piKeyword) and
       ((lt = 'main') or (lt = 'task') or (lt = 'sub') or
        (lt = 'watcher') or (lt = 'macro')) then
    begin
      bInProc := True;
      ProcName := '';
    end
    else if bInProc and
            ((MLexer.Id = piLineEnd) or
             ((MLexer.Id = piSymbol) and
              ((t = '(') or (t = '{')))) then
    begin
      bInProc := False;
      if MLexer.Id = piLineEnd then
        LineNo := MLexer.LinePos
      else
        LineNo := MLexer.LinePos + 1;
      // special handling for main in a MindScript program
      if ProcName = 'main' then ProcName := 'task|' + ProcName;
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
        // special handling for watcher
        if ProcName = 'watcher' then
          ProcName := 'task';
        // we only want to end up with something like blah|foo so
        // don't add anything if the | is already there
        if Pos('|', ProcName) = 0 then
          ProcName := ProcName + '|' + t;
      end;
    end;
    if (GetTick - start) > Timeout then Break;
  end;
end;

{ TMindScriptProcLexer }

procedure TMindScriptProcLexer.Execute;
var
  Lex: TMindScriptLexer;
  Stream: TStringStream;
  MStream : TMemoryStream;
  tOut : Cardinal;
begin
  tOut := Cardinal(Timeout);
  Lex := TMindScriptLexer.CreateLexer;
  try
    Stream := TStringStream.Create(TextToParse);
    try
      Stream.Position := 0;
      MStream := TMemoryStream.Create;
      try
        MStream.LoadFromStream(Stream);
        Lex.Origin := MStream.Memory;
        Lex.EndPos := Stream.Size;
        FindMindscriptProcs(tOut, Lex, HandleMindscriptProcFound);
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

function TMindScriptProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elMindscript;
end;

procedure TMindScriptProcLexer.HandleMindscriptProcFound(lineNo: Integer;
  pname, ptype: string);
begin
  Results := Results + IntToStr(lineNo-1) + '|' + ptype + '|' + pname + #13#10;
end;

{ TMindScriptLexer }

constructor TMindScriptLexer.CreateLexer;
begin
  inherited CreateLexer;
  Sensitive := False;
end;

procedure TMindScriptLexer.InitForLanguage(Lex: TGenLexer);
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
  Lex.Add(Pat);

  { Symbol, Comment }
  Pat := TAny.Create(nil);
  Pat.Key := '/*';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '//';
  OptPat.Id := piComment;
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  OptPat := TTillLineEnd.Create(OptPat);
  OptPat.Id := piComment;
  OptPat := TAny.Create(nil); // divided-by-equals symbol
  OptPat.Key := '/=';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '/';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  Pat := TAny.Create(Pat);
  Pat.Key := '*/';
  Pat.Id := piComment;
  Pat.Kind := pkTillKey;
  Pat.MultiLine := True;

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'main';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'macro';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'sub';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'task';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'watcher';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

end;

end.
