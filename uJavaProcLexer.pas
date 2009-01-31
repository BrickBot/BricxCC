unit uJavaProcLexer;

interface

uses
  Classes, uBricxCCProcLexer;

type
  TProcRec = record
    LineNum : Integer;
    ProcName : string;
  end;
  PProcRec = ^TProcRec;

  TCppProcLexer = class(TBricxCCProcLexer)
  protected
    procedure HandleCppProcFound(pidx, lineNo : Integer;
      pline, ptype, pname, pclass, pargs, retType : string);
    procedure Execute; override;
  end;

implementation

uses
  Windows,
  SysUtils,
  uParseCommon,
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
        FindCppProcs(tOut, CParser, False, HandleCppProcFound);
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

procedure TCppProcLexer.HandleCppProcFound(pidx, lineNo: Integer; pline,
  ptype, pname, pclass, pargs, retType: string);
begin
  Results := Results + IntToStr(lineNo-1) + '|' + ptype + '|' + pname + #13#10;
end;

end.
