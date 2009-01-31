unit uNXCLexer;

interface

uses
  Classes, uGenLexer;

type
  TNXCLexer = class(TGenLexer)
  protected
    procedure InitForLanguage(Lex: TGenLexer); override;
  end;

implementation

uses
  SysUtils, mwGenericLex;

{ TNXCLexer }

procedure TNXCLexer.InitForLanguage(Lex: TGenLexer);
var
  Pat, OptPat, Temp: TAny;
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
  Pat := TIdentifier.Create(nil);
  Lex.Add(Pat);

  // TODO: need to try to add support for \"
  { String }
  Pat := TAny.Create(nil);
  Pat.Key := '"';
  Lex.Add(Pat);
  Pat := TAny.Create(Pat);
  Pat.Key := '"';
  Pat.Min := 1;
  Pat.Max := 1;
  Pat.Id := piString;
  Pat.Kind := pkTillKey;
  Temp:= Pat;
  Pat := TAny.Create(Pat);
  Pat.Key := '"';
  Pat.Id := piBadString;
  Pat.Min := 1;
  Pat.Max := 1;
  Pat.Regress := True;
  Pat.ToRegress := Temp;

  // TODO: need to try to add support for \'
  { String }
  Pat := TAny.Create(nil);
  Pat.Key := '''';
  Lex.Add(Pat);
  Pat := TAny.Create(Pat);
  Pat.Key := '''';
  Pat.Min := 1;
  Pat.Max := 1;
  Pat.Id := piChar;
  Pat.Kind := pkTillKey;
  Temp:= Pat;
  Pat := TAny.Create(Pat);
  Pat.Key := '''';
  Pat.Id := piBadString;
  Pat.Min := 1;
  Pat.Max := 1;
  Pat.Regress := True;
  Pat.ToRegress := Temp;

  { Symbol, Comment }
  Pat := TAny.Create(nil);
  Pat.Key := '/*';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '//';
  OptPat.Id := piComment;
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  OptPat := TTillLineEnd.Create(OptPat);
  OptPat.Id := piComment;
  OptPat := TAny.Create(nil); // divided-by-equals symbol
  OptPat.Key := '/=';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '/';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  Pat := TAny.Create(Pat);
  Pat.Key := '*/';
  Pat.Id := piComment;
  Pat.Kind := pkTillKey;
  Pat.MultiLine := True;

  { Number }
  Pat := TAny.Create(nil);
  Pat.CharClass := ['1'..'9'];
  Pat.Min := 1;
  Pat.Id := piNumber;
  Lex.Add(Pat);
  Pat := TAny.Create(Pat);
  Pat.CharClass := ['0'..'9'];
  Pat.Id := piNumber;

  { Number }
  Pat := TAny.Create(nil);
  Pat.Key := '0x';
  Pat.Id := piNumber;
  Pat.Min := 1;
  Pat.Max := 2;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '0';
  OptPat.Min := 1;
  OptPat.Id := piNumber;
  Pat.AddOption(OptPat);
  Pat := TAny.Create(Pat);
  Pat.CharClass := ['0'..'9', 'A'..'F', 'a'..'f'];
  Pat.Id := piNumber;

  { Symbol }
  Pat := TAny.Create(nil);
  Pat.Key := '||=';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '||';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '|=';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '|';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);


  { Symbol }
  Pat := TAny.Create(nil);
  Pat.Key := '&&';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '&=';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '&';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);

  { Symbol }
  Pat := TAny.Create(nil);
  Pat.Key := '!=';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '!';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);

  { Symbol }
  Pat := TAny.Create(nil);
  Pat.Key := '*=';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '*';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);

  { Symbol }
  Pat := TAny.Create(nil);
  Pat.Key := '<=';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '<<';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '<';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);

  { Symbol }
  Pat := TAny.Create(nil);
  Pat.Key := '>=';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '>>';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '>';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);

  { Symbol }
  Pat := TAny.Create(nil);
  Pat.Key := '==';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '=';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);

  { Symbol }
  Pat := TAny.Create(nil);
  Pat.Key := '+-=';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '+=';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '++';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '+';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);

  { Symbol }
  Pat := TAny.Create(nil);
  Pat.Key := '-=';
  Pat.Min := 1;
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '--';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '-';
  OptPat.Min := 1;
  Pat.AddOption(OptPat);

  { Directive, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= '#include';
  Pat.Id:= piDirective;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#define';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#ifndef';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#pragma';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#endif';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#error';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#ifdef';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#reset';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#undef';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#elif';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#else';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#line';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#if';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= '__TMPBYTE__';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '__TMPLONG__';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '__TMPWORD__';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '__RETURN__';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '__RETVAL__';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'abs';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'asm';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'break';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'bool';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'byte';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'continue';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'const';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'case';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'char';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'default';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'do';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'else';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'false';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'for';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'goto';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'inline';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'int';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'if';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'long';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'mutex';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'priority';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'repeat';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'return';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'safecall';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'string';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'struct';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'switch';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'short';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'start';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'sign';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'stop';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'sub';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'typedef';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'task';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'true';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'unsigned';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'void';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'while';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));
end;

end.
