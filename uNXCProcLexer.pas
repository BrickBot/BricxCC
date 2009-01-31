unit uNXCProcLexer;

interface

uses
  Classes, uGenLexer, uBricxCCProcLexer, uParseCommon, uCppProcLexer{, uNXCLexer};

type
  TNXCProcLexer = class(TCppProcLexer)
  protected
    function GetLanguage: TExploredLanguage; override;
  end;

{
  TNXCProcLexer = class(TBricxCCProcLexer)
  protected
    procedure Execute; override;
    function GetLanguage: TExploredLanguage; override;
  end;
}


implementation

uses
  Windows, SysUtils, mwGenericLex;

{ TNXCProcLexer }

function TNXCProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elNXC;
end;

(*
procedure TNXCProcLexer.Execute;
var
  Lex: TNXCLexer;
  Stream: TStringStream;
  MStream : TMemoryStream;
  bInProc : Boolean;
  t, msg : string;
  start, tOut : Cardinal;
  lineNum : Integer;
begin
  tOut := Cardinal(Timeout);
  bInProc := False;
  Lex := TNXCLexer.CreateLexer;
  try
    Stream := TStringStream.Create(TextToParse);
    try
      Stream.Position := 0;
      MStream := TMemoryStream.Create;
      try
        MStream.LoadFromStream(Stream);
        Lex.Origin := MStream.Memory;
        Lex.EndPos := Stream.Size;
        start := GetTickCount;
        while not Lex.AtEnd do
        begin
          try
            repeat
              Lex.Next;
              t := Lex.Token;
              if (GetTickCount - start) > tOut then Break;
            until (not (Lex.Id in [piComment, piSpace])) or Lex.AtEnd;
          except
            Break;
          end;
          if (Lex.Id = piKeyword) and
             ((t = 'task') or
              (t = 'void') or
              (t = 'sub')) then
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
          if (GetTickCount - start) > tOut then Break;
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
*)

end.
