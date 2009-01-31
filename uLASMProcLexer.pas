unit uLASMProcLexer;

interface

uses
  Classes, uGenLexer, uBricxCCProcLexer, uParseCommon;

type
  TLASMLexer = class(TGenLexer)
  protected
    procedure InitForLanguage(Lex: TGenLexer); override;
  end;

  TLASMProcLexer = class(TBricxCCProcLexer)
  protected
    procedure HandleLASMProcFound(lineNo : Integer; pname, ptype : string);
    procedure Execute; override;
    function GetLanguage: TExploredLanguage; override;
  end;

procedure FindLASMProcs(Timeout : Cardinal; MLexer : TLASMLexer; Proc : TLASMProcessProc);

implementation

uses
  Windows, SysUtils, mwGenericLex;

procedure FindLASMProcs(Timeout : Cardinal; MLexer : TLASMLexer; Proc : TLASMProcessProc);
var
  bInProc: Boolean;
  j: Integer;
  LineNo: Integer;
  ProcName : string;
  ProcedureType : string;
  t, lt: string;
  start : cardinal;
begin
  start := GetTickCount;
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
       ((lt = 'task') or (lt = 'sub')) then
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
    if (GetTickCount - start) > Timeout then Break;
  end;
end;

{ TLASMProcLexer }

procedure TLASMProcLexer.Execute;
var
  Lex: TLASMLexer;
  Stream: TStringStream;
  MStream : TMemoryStream;
  tOut : Cardinal;
begin
  tOut := Cardinal(Timeout);
  Lex := TLASMLexer.CreateLexer;
  try
    Stream := TStringStream.Create(TextToParse);
    try
      Stream.Position := 0;
      MStream := TMemoryStream.Create;
      try
        MStream.LoadFromStream(Stream);
        Lex.Origin := MStream.Memory;
        Lex.EndPos := Stream.Size;
        FindLASMProcs(tOut, Lex, HandleLASMProcFound);
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

function TLASMProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elLASM;
end;

procedure TLASMProcLexer.HandleLASMProcFound(lineNo: Integer; pname,
  ptype: string);
begin
  Results := Results + IntToStr(lineNo-1) + '|' + ptype + '|' + pname + #13#10;
end;

{ TLASMLexer }

procedure TLASMLexer.InitForLanguage(Lex: TGenLexer);
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
//  Pat := TIdentifier.Create(nil);
//  Lex.Add(Pat);
  Pat := TIdentifier.Create(nil);
  Pat.CharClass := [#33..#126];
  Lex.Add(Pat);


  { Symbol, Comment }
  Pat := TAny.Create(nil);
  Pat.Key := '//';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '/';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  OptPat := TTillLineEnd.Create(Pat);
  OptPat.Id := piComment;

  { Symbol, Comment }
  Pat := TAny.Create(nil);
  Pat.Key := ';';
  Pat.Min := 1;
  Pat.Id  := piComment;
  Lex.Add(Pat);
  OptPat := TTillLineEnd.Create(Pat);
  OptPat.Id := piComment;

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

end;

end.
