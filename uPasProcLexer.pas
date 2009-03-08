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
