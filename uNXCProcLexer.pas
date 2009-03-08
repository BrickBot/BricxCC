unit uNXCProcLexer;

interface

uses
  Classes, uGenLexer, uBricxCCProcLexer, uParseCommon, uCppProcLexer;

type
  TNXCProcLexer = class(TCppProcLexer)
  protected
    function GetLanguage: TExploredLanguage; override;
  end;

implementation

{ TNXCProcLexer }

function TNXCProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elNXC;
end;

end.
