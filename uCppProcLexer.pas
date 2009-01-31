unit uCppProcLexer;

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
  Windows,
  SysUtils,
  mwBCBTokenList;

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
