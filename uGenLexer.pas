unit uGenLexer;

interface

uses
  mwGenericLex;

type
  TGenLexer = class(TmwGenLex)
  protected
    procedure InitForLanguage(Lex: TGenLexer); virtual; abstract;
  public
    constructor CreateLexer; virtual;
  end;

  TGenLexerClass = class of TGenLexer;


implementation

{ TGenLexer }

constructor TGenLexer.CreateLexer;
begin
  inherited Create;
  Sensitive := True;
  Clear;
  InitMainSelector;
  InitForLanguage(Self);
end;

end.