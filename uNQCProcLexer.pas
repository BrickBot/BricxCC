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
unit uNQCProcLexer;

interface

uses
  Classes, uGenLexer, uBricxCCProcLexer, uParseCommon, uNQCLexer;

type
  TNQCProcLexer = class(TBricxCCProcLexer)
  protected
    procedure Execute; override;
    function GetLanguage: TExploredLanguage; override;
  end;


implementation

uses
{$IFDEF FPC}
  LCLIntf,
{$ENDIF}
  SysUtils, mwGenericLex, uCommonUtils;

{ TNQCProcLexer }

procedure TNQCProcLexer.Execute;
var
  Lex: TNQCLexer;
  Stream: TStringStream;
  MStream : TMemoryStream;
  bInProc : Boolean;
  t, msg : string;
  start, tOut : Cardinal;
  lineNum : Integer;
begin
  tOut := Cardinal(Timeout);
  bInProc := False;
  Lex := TNQCLexer.CreateLexer;
  try
    Stream := TStringStream.Create(TextToParse);
    try
      Stream.Position := 0;
      MStream := TMemoryStream.Create;
      try
        MStream.LoadFromStream(Stream);
        Lex.Origin := MStream.Memory;
        Lex.EndPos := Stream.Size;
        start := GetTick;
        while not Lex.AtEnd do
        begin
          try
            repeat
              Lex.Next;
              t := Lex.Token;
              if (GetTick - start) > tOut then Break;
            until (not (Lex.Id in [piComment, piSpace])) or Lex.AtEnd;
          except
            Break;
          end;
          if (Lex.Id = piKeyword) and
             ((t = 'task') or (t = 'void') or (t = 'sub')) then
          begin
            bInProc := True;
            msg := '';
          end
          else if bInProc and
                  ((Lex.Id = piLineEnd) or
                   ((Lex.Id = piSymbol) and
                    ((t = '(') or (t = ')') or (t = ';')))) then
          begin
            bInProc := False;
            if Lex.Id = piLineEnd then
              lineNum := Lex.LinePos - 1
            else
              lineNum := Lex.LinePos;
            // protect against a void foo(void) function definition
            if (msg <> '') and (t <> ')') then
              Results := Results + IntToStr(lineNum) + '|' + msg + #13#10;
          end;

          if bInProc then
          begin
            if msg = '' then msg := t
            else
            begin
              // we only want to end up with something like blah|foo so
              // don't add anything if the | is already there
              if Pos('|', msg) = 0 then
                msg := msg + '|' + t;
            end;
          end;
          if (GetTick - start) > tOut then Break;
        end;
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

function TNQCProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elNQC;
end;

end.
