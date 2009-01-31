unit uBricxCCProcLexer;

interface

uses
  Classes, uParseCommon;

type
  TProcRec = record
    LineNum : Integer;
    ProcName : string;
  end;
  PProcRec = ^TProcRec;

  TBricxCCProcLexer = class(TThread)
  private
    { Private declarations }
    FTextToParse: string;
    FResults: string;
    fTimeout: Integer;
  protected
    function GetLanguage: TExploredLanguage; virtual; abstract;
  public
    property TextToParse : string read FTextToParse write FTextToParse;
    property Results : string read FResults write FResults;
    property Timeout : Integer read fTimeout write fTimeout;
    property Language : TExploredLanguage read GetLanguage;
  end;

implementation

end.
