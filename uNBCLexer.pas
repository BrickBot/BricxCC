unit uNBCLexer;

interface

uses
  Classes, uGenLexer;

type
  TNBCSimpleLexer = class(TGenLexer)
  protected
    procedure InitForLanguage(Lex: TGenLexer); override;
  end;

  TNBCLexer = class(TGenLexer)
  protected
    procedure InitForLanguage(Lex: TGenLexer); override;
  end;

implementation

uses
  SysUtils, mwGenericLex;

{ TNBCSimpleLexer }

procedure TNBCSimpleLexer.InitForLanguage(Lex: TGenLexer);
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
  Pat.Key:= 'subroutine';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'thread';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

end;

{ TNBCLexer }

procedure TNBCLexer.InitForLanguage(Lex: TGenLexer);
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

  { String }
  Pat := TAny.Create(nil);
  Pat.Key := '''';
  Lex.Add(Pat);
  Pat := TAny.Create(Pat);
  Pat.Key := '''';
  Pat.Min := 1;
  Pat.Max := 1;
  Pat.Id := piString;
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

  { Symbol, Comment }
  Pat := TAny.Create(nil);
  Pat.Key := ';';
  Pat.Min := 1;
  Pat.Id  := piComment;
  Lex.Add(Pat);
  OptPat := TTillLineEnd.Create(Pat);
  OptPat.Id := piComment;

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
{
  OptPat := TAny.Create(nil);
  OptPat.Key := '##';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
}
  OptPat := TAny.Create(nil);
  OptPat.Key := '#';
  OptPat.Min := 1;
  OptPat.Id := piSymbol;
  Pat.AddOption(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'arrsubset';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'arrbuild';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'arrtostr';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'acquire';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'arrinit';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'arrsize';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'abs';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'add';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'and';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'asl';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'asr';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'brcmp';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'brtst';
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
  Pat.Key:= 'cmpset';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'call';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'cmnt';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'cmp';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'dword';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'div';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'db';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'dd';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'dw';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'exitto';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'ends';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'endt';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'exit';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'flatten';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'follows';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'fmtnum';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'gettick';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'getout';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'getin';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'index';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'jmp';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'long';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'lsl';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'lsr';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'mutex';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'mod';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'mov';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'mul';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'numtostr';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'neg';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'not';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'or';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'precedes';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'priority';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'release';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'replace';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'return';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'rotl';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'rotr';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'stopthread';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'subroutine';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'strsubset';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'strtoarr';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'strtonum';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'segment';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'subcall';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'syscall';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'sdword';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'setout';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'strcat';
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
  OptPat.Key := 'subret';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'sbyte';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'setin';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'slong';
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
  OptPat.Key := 'sword';
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
  OptPat.Key := 'set';
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
  OptPat.Key := 'thread';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'tstset';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'tst';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'unflatten';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'udword';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'ubyte';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'ulong';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'uword';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
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
  Pat.Key:= 'waitv';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'wait';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'word';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'xor';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

end;

end.
