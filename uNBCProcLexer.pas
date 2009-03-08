unit uNBCProcLexer;

interface

uses
  Classes, mwGenericLex, uBricxCCProcLexer, uParseCommon, uNBCLexer;

type
  TNBCProcLexer = class(TBricxCCProcLexer)
  protected
    procedure HandleNBCProcFound(lineNo : Integer; pname, ptype : string);
    procedure Execute; override;
    function GetLanguage: TExploredLanguage; override;
  end;

procedure FindNBCProcs(Timeout : Cardinal; MLexer : TNBCSimpleLexer; Proc : TNBCProcessProc);

implementation

uses
  SysUtils, uCommonUtils;

procedure FindNBCProcs(Timeout : Cardinal; MLexer : TNBCSimpleLexer; Proc : TNBCProcessProc);
var
  bInProc: Boolean;
  j: Integer;
  LineNo: Integer;
  ProcName : string;
  ProcedureType : string;
  t: string;
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
        if (GetTick - start) > Timeout then Break;
      until (not (MLexer.Id in [piSpace, piComment])) or MLexer.AtEnd;
    except
      Break;
    end;
    if (MLexer.Id = piKeyWord) and
       ((t = 'thread') or (t = 'subroutine')) then
    begin
      bInProc := True;
      ProcName := '';
    end
    else if bInProc and (MLexer.Id = piLineEnd) then
    begin
      bInProc := False;
      if MLexer.Id = piLineEnd then
        LineNo := MLexer.LinePos
      else
        LineNo := MLexer.LinePos + 1;
      // now split ProcName into procedure type & procedure name
      j := Pos('|', ProcName);
      ProcedureType := Copy(ProcName, 1, j-1);
      if ProcedureType = 'thread' then
        ProcedureType := K_TASK
      else if ProcedureType = 'subroutine' then
        ProcedureType := K_SUBR;
      ProcName := Copy(ProcName, j+1, Length(ProcName));
      Proc(LineNo, ProcName, ProcedureType);
    end;

    if bInProc then
    begin
      if ProcName = '' then
        ProcName := t
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

{ TNBCProcLexer }

procedure TNBCProcLexer.Execute;
var
  Lex: TNBCSimpleLexer;
  Stream: TStringStream;
  MStream : TMemoryStream;
  tOut : Cardinal;
begin
  tOut := Cardinal(Timeout);
  Lex := TNBCSimpleLexer.CreateLexer;
  try
    Stream := TStringStream.Create(TextToParse);
    try
      Stream.Position := 0;
      MStream := TMemoryStream.Create;
      try
        MStream.LoadFromStream(Stream);
        Lex.Origin := MStream.Memory;
        Lex.EndPos := Stream.Size;
        FindNBCProcs(tOut, Lex, HandleNBCProcFound);
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

function TNBCProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elNBC;
end;

procedure TNBCProcLexer.HandleNBCProcFound(lineNo: Integer; pname,
  ptype: string);
begin
  Results := Results + IntToStr(lineNo-1) + '|' + ptype + '|' + pname + #13#10;
end;

end.
