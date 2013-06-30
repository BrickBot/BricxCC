(*
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Initial Developer of this code is John Hansen.
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uEVALexer;

interface

uses
  Classes, uGenLexer;

type
  TEVASimpleLexer = class(TGenLexer)
  protected
    procedure InitForLanguage(Lex: TGenLexer); override;
  end;

  TEVALexer = class(TGenLexer)
  protected
    procedure InitForLanguage(Lex: TGenLexer); override;
  end;

implementation

uses
  SysUtils, mwGenericLex;

{ TEVASimpleLexer }

procedure TEVASimpleLexer.InitForLanguage(Lex: TGenLexer);
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

{ TEVALexer }

procedure TEVALexer.InitForLanguage(Lex: TGenLexer);
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

  { Symbol (VA_ARGS), Symbol (period)}
  Pat := TAny.Create(nil);
  Pat.Key:= '...';
  Pat.Id:= piSymbol;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '.';
  OptPat.Id:= piSymbol;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { Directive, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= '#download';
  Pat.Id:= piDirective;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := '#include';
  OptPat.Id:= piDirective;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
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
  OptPat.Key := '#import';
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
  Pat.Key:= 'arrayappend';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'arraywrite';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'arrayread';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'array';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'add1';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'add2';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'add4';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'addf';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'and1';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'and2';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'and4';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'bpset';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'bp0';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'bp1';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'bp2';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'bp3';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

(*
call
cmpeq1
cmpeq2
cmpeq4
cmpeqf
cmpgt1
cmpgt2
cmpgt4
cmpgteq1
cmpgteq2
cmpgteq4
cmpgteqf
cmpgtF
cmplt1
cmplt2
cmplt4
cmplteq1
cmplteq2
cmplteq4
cmplteqf
cmpltF
cmpneq1
cmpneq2
cmpneq4
cmpneqf
comget
comread
comreaddata
comready
comremove
comset
comtest
comwrite
comwritedata
comwritefile
*)
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
  Pat.Key:= 'decodeoutput';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'decodeinput';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'div1';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'div2';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'div4';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'divf';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'do';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'error';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'filename';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'file';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'indevlist';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'initbytes';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'inreadext';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'indevice';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'inreadsi';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'insample';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'inready';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'inwrite';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'inread';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'intest';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'info';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'jmpfalse';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpgteq1';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpgteq2';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpgteq4';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpgteqf';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmplteq1';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmplteq2';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmplteq4';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmplteqf';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpneq1';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpneq2';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpneq4';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpneqf';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmptrue';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpeq1';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpeq2';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpeq4';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpeqf';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpgt1';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpgt2';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpgt4';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpgtf';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmplt1';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmplt2';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmplt4';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpltf';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmpnan';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  OptPat := TAny.Create(nil);
  OptPat.Key := 'jmp';
  OptPat.Id:= piKeyWord;
  OptPat.Min:= 1;
  Pat.AddOption(OptPat);
  TAlphaNumeric.Create(OptPat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'keepalive';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

  { KeyWord, Identifier}
  Pat := TAny.Create(nil);
  Pat.Key:= 'label';
  Pat.Id:= piKeyWord;
  Pat.Min:= 1;
  TAlphaNumeric.Create(Pat);
  Lex.Add(Pat);
  Pat.AddOption(TIdentifier.Create(nil));

(*
math
mbclose
mbopen
mbread
mbready
mbtest
mbwrite
memread
memusage
memwrite
move11
move12
move14
move1f
move21
move22
move24
move2f
move41
move42
move44
move4f
movef1
movef2
movef4
moveff
mul1
mul2
mul4
mulf
*)
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

(*
nop
note2freq
*)
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

(*
objend
objstart
objstop
objtrigger
objwait
or1
or2
or4
outclearcount
outgetcount
outpolarity
outpower
outprgstop
outread
outready
outreset
outsettype
outspeed
outstart
outsteppower
outstepspeed
outstepsync
outstop
outtest
outtimepower
outtimespeed
outtimesync
prgstart
prgstop
probe
proginfo
random
read1
read2
read4
readf
return
rol1
rol2
rol4
select1
select2
select4
selectf
sleep
sound
soundready
soundtest
strings
sub1
sub2
sub4
subf
system
test
timerread
timerreadus
timerready
timerwait
uibutton
uidraw
uiflush
uiread
uiwrite
write1
write2
write4
writef
xor1
xor2
xor4
*)
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
