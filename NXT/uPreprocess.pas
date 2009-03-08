unit uPreprocess;

interface

uses
  Classes, Contnrs, SysUtils, mwGenericLex, uGenLexer, uNBCCommon;

type
  EPreprocessorException = class(Exception)
  private
    fLineNo : integer;
  public
    constructor Create(const msg : string; const lineno : integer);
    property LineNo : integer read fLineNo;
  end;

  { TMapList }

  TMapList = class(TStringList)
  private
    fConsiderCase: boolean;
    function GetMapValue(index: integer): string;
    procedure SetConsiderCase(const AValue: boolean);
    procedure SetMapValue(index: integer; const Value: string);
  protected
{$IFDEF FPC}
    function DoCompareText(const s1,s2 : string) : PtrInt; override;
{$ENDIF}
  public
    constructor Create;
    function  AddEntry(const aName, aValue : string) : integer;
    procedure AddDefines(aValue : TStrings);
    procedure Define(const aName : string);
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    property MapValue[index : integer] : string read GetMapValue write SetMapValue;
    property ConsiderCase : boolean read fConsiderCase write SetConsiderCase;
  end;

  TLangPreprocessor = class
  private
    fWarnings : TStrings;
    fCalc : TNBCExpParser;
    fIncludeFilesToSkip : TStrings;
    IncludeDirs : TStringList;
    MacroDefs : TMapList;
    MacroFuncArgs : TMapList;
    fLevel : integer;
    fLevelIgnore : TObjectList;
    fGLC : TGenLexerClass;
    fLexers : TObjectList;
    fRecursionDepth : integer;
    fAddPoundLine: boolean;
{
    fVarI : integer;
    fVarJ : integer;
    procedure SetThreadName(const name : string);
    procedure SetCurrentFile(const name : string);
    procedure SetVarJ(val : integer);
    procedure SetVarI(val : integer);
    procedure LoadStandardMacros;
}
    function DoProcessStream(name: string; lineNo: integer;
      Stream: TMemoryStream; OutStrings: TStrings) : string;
    function GetLevelIgnoreValue(const lineno : integer): boolean;
    procedure SwitchLevelIgnoreValue(const lineno : integer);
    function ProcessIdentifier(Lex: TGenLexer; var lineNo: integer): string;
    function EvaluateIdentifier(const ident : string) : string;
    function ReplaceTokens(const tokenstring: string; lineNo : integer;
      bArgs : boolean): string;
    function ProcessMacroDefinition(bUndefine : boolean; Lex: TGenLexer;
      var lineNo: integer): integer;
    function GenLexerType : TGenLexerClass;
    function GetDefines: TMapList;
    function ProcessDefinedFunction(expr : string) : string;
    function EvaluateExpression(expr : string; lineno : integer) : boolean;
    function AcquireLexer(const lineNo : integer) : TGenLexer;
    procedure ReleaseLexer;
    procedure InitializeLexers(const num: integer);
    procedure AddOneOrMoreLines(OutStrings: TStrings; const S,
      name: string; var lineNo: integer);
  public
    class function PreprocessStrings(GLType : TGenLexerClass; const fname : string; aStrings : TStrings) : string;
    class function PreprocessFile(GLType : TGenLexerClass; const fin, fout : string) : string;
    constructor Create(GLType : TGenLexerClass; const defIncDir : string);
    destructor Destroy; override;
    procedure SkipIncludeFile(const fname : string);
    function Preprocess(const fname: string; aStrings: TStrings) : string; overload;
    function Preprocess(const fname: string; aStream: TMemoryStream) : string; overload;
    procedure AddIncludeDirs(aStrings : TStrings);
    property Defines : TMapList read GetDefines;
    property AddPoundLineToMultiLineMacros : boolean read fAddPoundLine write fAddPoundLine;
    property Warnings : TStrings read fWarnings;
  end;

implementation

uses
  uVersionInfo, uLocalizedStrings;

type
  TPreprocLevel = class
  public
    Taken : boolean;
    Ignore : boolean;
    constructor Create; virtual;
  end;

  TIgnoreLevel = class(TPreprocLevel)
  public
    constructor Create; override;
  end;

  TProcessLevel = class(TPreprocLevel)
  public
    constructor Create; override;
  end;

function CountLineEndings(ablock : string) : integer;
var
  tmpSL : TStringList;
begin
  tmpSL := TStringList.Create;
  try
    tmpSL.Text := ablock+'_';
    Result := tmpSL.Count - 1;
  finally
    tmpSL.Free;
  end;
end;

{ TLangPreprocessor }

class function TLangPreprocessor.PreprocessStrings(GLType : TGenLexerClass;
  const fname : string; aStrings : TStrings) : string;
var
  P : TLangPreprocessor;
begin
  P := TLangPreprocessor.Create(GLType, ExtractFilePath(fname));
  try
    Result := P.Preprocess(fname, aStrings);
  finally
    P.Free;
  end;
end;

class function TLangPreprocessor.PreprocessFile(GLType : TGenLexerClass;
  const fin, fout : string) : string;
var
  SL : TStringList;
begin
  SL := TStringList.Create;
  try
    SL.LoadFromFile(fin);
    Result := TLangPreprocessor.PreprocessStrings(GLType, fin, SL);
    SL.SaveToFile(fout);
  finally
    SL.Free;
  end;
end;

function TLangPreprocessor.Preprocess(const fname: string; aStream: TMemoryStream) : string;
var
  Strings : TStringList;
begin
//  MacroDefs.Clear;
  fWarnings.Clear;
  fLevelIgnore.Clear;
  IncludeDirs.Add(ExtractFilePath(fname));
  fLevelIgnore.Add(TProcessLevel.Create); // level zero is NOT ignored
  fLevel := 0; // starting level is zero
  fRecursionDepth := 0;
  Strings := TStringList.Create;
  try
    Result := DoProcessStream(fname, 0, aStream, Strings);
    aStream.Size := 0; // empty the stream
    Strings.SaveToStream(aStream);
    aStream.Position := 0;
  finally
    Strings.Free;
  end;
end;

function TLangPreprocessor.Preprocess(const fname : string; aStrings : TStrings) : string;
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    aStrings.SaveToStream(Stream);
    aStrings.Clear;
    Result := Preprocess(fname, Stream);
    aStrings.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

function TLangPreprocessor.GetLevelIgnoreValue(const lineno : integer) : boolean;
var
  PL : TPreprocLevel;
begin
  if (fLevel < 0) or (fLevel >= fLevelIgnore.Count) then
    raise EPreprocessorException.Create(sInvalidPreprocDirective, lineno);
  PL := TPreprocLevel(fLevelIgnore[fLevel]);
  Result := PL.Ignore;
end;

procedure TLangPreprocessor.SwitchLevelIgnoreValue(const lineno : integer);
var
  PL : TPreprocLevel;
begin
  if (fLevel < 0) or (fLevel >= fLevelIgnore.Count) then
    raise EPreprocessorException.Create(sInvalidPreprocDirective, lineno);
  PL := TPreprocLevel(fLevelIgnore[fLevel]);
  if PL.Taken then
    PL.Ignore := True
  else
    PL.Ignore := not PL.Ignore;
  if not PL.Ignore then
    PL.Taken := True;
end;

procedure TLangPreprocessor.AddOneOrMoreLines(OutStrings : TStrings; const S, name : string; var lineNo : integer);
var
  SL : TStringList;
  lineCount : integer;
begin
  if Pos(#10, S) > 0 then
  begin
    SL := TStringList.Create;
    try
      SL.Text := S;
      lineCount := SL.Count;
      if AddPoundLineToMultiLineMacros then
      begin
        dec(lineCount);
        if Copy(S, Length(S), 1) <> #10 then
          dec(lineCount);
      end;
      OutStrings.Add(Format('#pragma macro %d', [lineCount]));
      OutStrings.AddStrings(SL);
      // at the end of each multi-line macro expansion output a #line directive
      OutStrings.Add(Format('#line %d "%s"', [lineNo, name]));
    finally
      SL.Free;
    end;
  end
  else
    OutStrings.Add(S);
end;

function TLangPreprocessor.ReplaceTokens(const tokenstring: string;
  lineNo : integer; bArgs : boolean): string;
var
  Lex : TGenLexer;
  map : TMapList;

  procedure AddToResult;
  var
    i{, len} : integer;
    charTok : string;
  begin
    if Lex.Id = piIdent then
    begin
      if bArgs then
      begin
        i := map.IndexOf(Lex.Token);
        if i <> -1 then
        begin
          Result := Result + map.MapValue[i];
        end
        else
          Result := Result + Lex.Token;
      end
      else
      begin
        // pass lex to ProcessIdentifier
        Result := Result + ProcessIdentifier(Lex, lineNo);
      end;
    end
{
    else if (Lex.Id = piSymbol) and (Lex.Token = '#') then
    begin
      len := Length(Result);
      if Pos('#', Result) = len then
      begin
        // the previous token was '#' and current token is '#'
        System.Delete(Result, len, 1);
      end
      else
        Result := Result + Lex.Token;
    end
}
    else if Lex.Id = piChar then
    begin
      charTok := Lex.Token;
      charTok := Replace(charTok, '''', '');
      if Length(charTok) > 1 then
        raise EPreprocessorException.Create(sInvalidCharConstant, lineNo);
      Result := Result + IntToStr(Ord(charTok[1]));
    end
    else
      Result := Result + Lex.Token;
  end;
begin
  Result := '';
  if bArgs then
    map := MacroFuncArgs
  else
    map := MacroDefs;
  Lex := AcquireLexer(lineNo);
  try
    Lex.SetStartData(@tokenstring[1], Length(tokenstring));
    while not Lex.AtEnd do
    begin
      AddToResult;
      Lex.Next;
    end;
    if Lex.Id <> piUnknown then
      AddToResult;
  finally
    ReleaseLexer;
  end;
end;

const
  WhiteSpaceIds = [piSpace, piComment, piInnerLineEnd, piLineEnd];

procedure SkipWhitespace(Lex : TGenLexer; var linesSkipped : integer);
begin
  while (Lex.Id in WhiteSpaceIds) and not Lex.AtEnd do
  begin
    if Lex.Id = piLineEnd then
      inc(linesSkipped);
    Lex.Next;
  end;
end;

function TLangPreprocessor.ProcessIdentifier(Lex : TGenLexer; var lineNo : integer) : string;
var
  i, linesSkipped : integer;
  macroVal, dirText, prevToken, tmp, tok : string;
  nestLevel : integer;
  bDone : boolean;
begin
  Result := '';
  // is token in defmap?  if so replace it (smartly)
  // token may be a function which takes parameters
  // so if it is then we need to grab more tokens from ( to )
  tok := Lex.Token;
  i := MacroDefs.IndexOf(tok);
  if i <> -1 then
  begin
    macroVal := MacroDefs.MapValue[i];
    if Pos('#', macroVal) = 1 then
    begin
      linesSkipped := 0;
      // function macro - complicated
      // format of macroVal == #arg1,arg2,...,argn#formula
      // is next non-whitespace token '('?
      Lex.Next;
      // skip whitespace prior to '(' if any exists
      SkipWhitespace(Lex, linesSkipped);
      if (Lex.Id = piSymbol) and (Lex.Token = '(') then
      begin
        // move past the '('
        Lex.Next;
        MacroFuncArgs.Clear;  // start with an empty arg map
        Delete(macroVal, 1, 1); // remove starting '#'
        i := Pos('#', macroVal);
        dirText := Copy(macroVal, 1, i-1)+ ','; // arg1,arg2,...,argn,
        macroVal := Copy(macroVal, i+1, MaxInt);
        if (dirText = ',') and Lex.AtEnd then begin
          i := 1;
          dirText := '';
        end;
        while not Lex.AtEnd do
        begin
          // skip whitespace prior to each arg instance
          SkipWhitespace(Lex, linesSkipped);
          prevToken := '';
          // now collect tokens until either ',' or ')' or whitespace
          nestLevel := 0;
          while not ({((nestLevel <= 0) and (Lex.Id in WhiteSpaceIds)) or}
                     ((Lex.Id = piSymbol) and
                      (((nestLevel <= 0) and (Lex.Token = ',')) or
                       ((nestLevel <= 0) and (Lex.Token = ')'))))) do
          begin
            prevToken := prevToken + Lex.Token;
            if Lex.Token = '(' then
              inc(nestLevel)
            else if Lex.Token = ')' then
              dec(nestLevel);
            Lex.Next;
            if Lex.AtEnd then break;
          end;
          prevToken := TrimRight(prevToken); // trim any whitespace
          // now match instance to arg
          // each identifier in the instance maps to
          // an argument in the defined macro function
          i := Pos(',', dirText);
          if i = 0 then Break;
          if ((i > 1) and (prevToken = '')) or
             ((i = 1) and (prevToken <> '')) then
            Break;
          if i > 1 then
          begin
            tmp := Copy(dirText, 1, i-1);
            if tmp = '...' then
            begin
              tmp := '__VA_ARGS__';
              // now collect the rest of the tokens all the way up to the ')'
              while not (((Lex.Id = piSymbol) and
                          (((nestLevel <= 0) and (Lex.Token = ')'))))) do
              begin
                prevToken := prevToken + Lex.Token;
                if Lex.Token = '(' then
                  inc(nestLevel)
                else if Lex.Token = ')' then
                  dec(nestLevel);
                Lex.Next;
                if Lex.AtEnd then break;
              end;
              prevToken := TrimRight(prevToken); // trim any whitespace
            end;
            MacroFuncArgs.AddEntry(tmp, prevToken);
          end;
          Delete(dirText, 1, i);
          // skip whitespace following each arg instance
          SkipWhitespace(Lex, linesSkipped);
          if (Lex.Id = piSymbol) and (Lex.Token = ')') then
            Break; // stop looping
          Lex.Next;
        end;
        if (i = 0) or (dirText <> '') then
          raise EPreprocessorException.Create(Format(sMacroMismatch, [macroVal]), lineNo);
        // we have eaten '(' through ')' (possibly to end of line)
        bDone := False;
        Result := macroVal;
        while not bDone do
        begin
          tmp := Result;
          Result := ReplaceTokens(tmp, lineNo, True);
          Result := ReplaceTokens(Result, lineNo, False);
          Result := Replace(Result, '##', '');
          bDone := tmp = Result;
        end;
      end
      else
        raise EPreprocessorException.Create(Format(sMacroMismatch, [macroVal]), lineNo);
      inc(lineNo, linesSkipped);
    end
    else
    begin
      // simple macro substitution
//      Result := ReplaceTokens(macroVal, lineNo, False);
      bDone := False;
      Result := macroVal;
      while not bDone do
      begin
        tmp := Result;
        Result := ReplaceTokens(Result, lineNo, False);
        Result := Replace(Result, '##', '');
        bDone := tmp = Result;
      end;
    end;
    Result := EvaluateIdentifier(Result);
  end
  else
    Result := tok;
end;

function TrimTrailingSpaces(const S: string) : string;
var
  I: Integer;
begin
  I := Length(S);
  while (I > 0) and (S[I] = ' ') do Dec(I);
  Result := Copy(S, 1, I);
end;

function TLangPreprocessor.ProcessMacroDefinition(bUndefine : boolean;
  Lex : TGenLexer; var lineNo : integer) : integer;
var
  macro, dirText, macroVal, prevToken : string;
  bEndOfDefine, bArgMode : boolean;
  i, prevId : integer;

  procedure HandleDefinition;
  begin
    macroVal := '';
    bEndOfDefine := (Lex.Id = piLineEnd) or Lex.AtEnd;
    while not bEndOfDefine do
    begin
      prevId := Lex.Id;
      prevToken := Lex.Token;
      Lex.Next;
      if bArgMode then
      begin
        if prevId = piIdent then
        begin
          dirText := dirText + prevToken + ','; // add argument
        end
        else if (prevId = piSymbol) and (prevToken = '...') then
        begin
          dirText := dirText + prevToken + ','; // add argument
        end
        else if (prevId = piSymbol) and (prevToken = ')') then
        begin
          Delete(dirText, Length(dirText), 1); // remove last character
          dirText := dirText + '#'; // end arguments
          bArgMode := False;
        end;
      end
      else
      begin
        if prevId <> piComment then
        begin
          if (prevId = piSymbol) and (prevToken = '\') and (Lex.Id = piLineEnd) then
          begin
            inc(lineNo);
            inc(Result);
            continue;
          end
          else
            macroVal := macroVal + prevToken;
        end;
      end;
      bEndOfDefine := (Lex.Id = piLineEnd) or Lex.AtEnd;
    end;
  end;
begin
  Result := 0;
  // add/remove definition to/from defmap
  // line should have a space token (1) and then an identifier
  // token followed by an optional parameter list ( ... )
  // followed by an optional value (everything left on the line
  // to EOL -- or multiple lines if line ends with '\')
  Lex.Next; // token ID should be piSpace
  if Lex.Id <> piSpace then
    raise EPreprocessorException.Create(sInvalidPreprocDirective, lineNo);
  Lex.Next; // token ID should be piIdent
  if Lex.Id <> piIdent then
    raise EPreprocessorException.Create(sInvalidPreprocDirective, lineNo);
  macro := Lex.Token; // the macro name
  if bUndefine then
  begin
    // no more info needed.  Remove macro
    i := MacroDefs.IndexOf(macro);
    if i <> -1 then
      MacroDefs.Delete(i);
  end
  else
  begin
    // is the next token whitespace?
    Lex.Next;
    if Lex.Id in [piSpace, piLineEnd] then
    begin
      // collect to end of #define (skipping comments)
      bArgMode := False;
      dirText := '';
      HandleDefinition;
    end
    else if (Lex.Id = piSymbol) and (Lex.Token = '(') then
    begin
      bArgMode := True;
      Lex.Next;
      dirText := '#'; // flag that this is a function macro
      HandleDefinition;
    end;
    dirText := Trim(dirText) + TrimTrailingSpaces(TrimLeft(macroVal));
    // check for macro definition
    i := MacroDefs.IndexOf(macro);
    if i <> -1 then
    begin
      fWarnings.Add(IntToStr(lineNo) + '=Macro "' + macro + '" redefined');
      // now remove the previous declaration
      MacroDefs.Delete(i);
    end;
    MacroDefs.AddEntry(macro, dirText);
  end;
end;

function TLangPreprocessor.DoProcessStream(name : string; lineNo : integer;
  Stream : TMemoryStream; OutStrings : TStrings) : string;
var
  Lex: TGenLexer;
  S, dir, dirText, tmpname, usePath, macro, tmp : string;
  X : TMemoryStream;
  i, cnt, origLevel, qPos, oldLineNo : integer;
  bFileFound, bDefined, bProcess : boolean;
  origName : string;
begin
  Result := '';
  origName := name;
  S := '';
  origLevel := fLevel;
  // at the start of each call to this function output a #line directive
  bProcess := not GetLevelIgnoreValue(lineNo);
  if bProcess and (lineNo > 0) then
    OutStrings.Add('#line 0 "' + name + '"');
//    OutStrings.Add('#line ' + IntToStr(lineNo) + ' "' + name + '"');
  if lineNo <= 0 then
    lineNo := 1;
  Lex := GenLexerType.CreateLexer;
  try
    Lex.SetStartData(Stream.Memory, Integer(Stream.Size));
    while not Lex.AtEnd do
    begin
      case Lex.Id of
        piSpace : begin
          S := S + ' '; // all space == single space
        end;
        piLineEnd, piInnerLineEnd : begin
          // output S and clear it
          if bProcess then
            AddOneOrMoreLines(OutStrings, S, name, lineNo)
          else
            OutStrings.Add('');
          S := '';
          inc(lineNo);
        end;
        piComment : begin
          // strip all comments
        end;
        piDirective : begin
          // if we have some non-blank text collected then output it before
          // we process the directive
          if Trim(S) <> '' then
          begin
            // output S and clear it
            if bProcess then
              AddOneOrMoreLines(OutStrings, S, name, lineNo)
            else
              OutStrings.Add('');
            S := '';
          end;
          // some sort of preprocessor directive.
          dir := AnsiLowerCase(Lex.Token);
          dirText := '';
          if dir = '#download' then
          begin
            // collect to end of line
            Lex.Next;
            while (Lex.Id <> piLineEnd) and not Lex.AtEnd do
            begin
              dirText := dirText + Lex.Token;
              Lex.Next;
            end;
            if bProcess then
            begin
              dirText := Trim(dirText);
              // get filename
              qPos := Pos('"', dirText);
              if qPos > 0 then
              begin
                System.Delete(dirText, 1, qPos);
                qPos := Pos('"', dirText);
                if qPos > 0 then
                begin
                  tmpName := Copy(dirText, 1, qPos-1);
                  usePath := '';
                  bFileFound := False;
                  for i := 0 to IncludeDirs.Count - 1 do
                  begin
                    usePath := IncludeTrailingPathDelimiter(IncludeDirs[i]);
                    bFileFound := FileExists(usePath+tmpName);
                    if bFileFound then Break;
                  end;
                  if bFileFound then
                  begin
                    // add this filename to the result
                    Result := Result + usePath+tmpName + #13#10;
                  end
                  else
                    raise EPreprocessorException.Create(Format(sDownloadNotFound, [tmpName]), lineNo);
                  // output a blank line to replace directive
                  OutStrings.Add('');
                end
                else
                  raise EPreprocessorException.Create(sDownloadMissingQuotes, lineNo);
              end
              else
                raise EPreprocessorException.Create(sDownloadMissingQuotes, lineNo);
            end;
          end
          else if dir = '#include' then
          begin
            // collect to end of line
            Lex.Next;
            while (Lex.Id <> piLineEnd) and not Lex.AtEnd do
            begin
              dirText := dirText + Lex.Token;
              Lex.Next;
            end;
            if bProcess then
            begin
              dirText := Trim(dirText);
              // get filename
              qPos := Pos('"', dirText);
              if qPos > 0 then
              begin
                System.Delete(dirText, 1, qPos);
                qPos := Pos('"', dirText);
                if qPos > 0 then
                begin
                  tmpName := Copy(dirText, 1, qPos-1);
                  if fIncludeFilesToSkip.IndexOf(tmpName) = -1 then
                  begin
                    X := TMemoryStream.Create;
                    try
                      usePath := '';
                      bFileFound := False;
                      for i := 0 to IncludeDirs.Count - 1 do
                      begin
                        usePath := IncludeTrailingPathDelimiter(IncludeDirs[i]);
                        bFileFound := FileExists(usePath+tmpName);
                        if bFileFound then Break;
                      end;
                      if bFileFound then
                      begin
                        // load into stream
                        X.LoadFromFile(usePath+tmpName);
                        // call function recursively
                        DoProcessStream(usePath+tmpName, 1, X, OutStrings);
                      end
                      else
                        raise EPreprocessorException.Create(Format(sIncludeNotFound, [tmpName]), lineNo);
                    finally
                      X.Free;
                    end;
                    // at the end of each #include output a #line directive
                    OutStrings.Add('#line ' + IntToStr(lineNo) + ' "' + name + '"');
                  end
                  else
                    // output a blank line to replace directive
                    OutStrings.Add('');
                end
                else
                  raise EPreprocessorException.Create(sIncludeMissingQuotes, lineNo);
              end
              else
                raise EPreprocessorException.Create(sIncludeMissingQuotes, lineNo);
            end;
          end
          else if dir = '#reset' then
          begin
            lineNo := 0;
            name := origName;
            OutStrings.Add('#line ' + IntToStr(lineNo) + ' "' + name + '"');
          end
          else if dir = '#error' then
          begin
            // collect to end of line
            Lex.Next;
            while (Lex.Id <> piLineEnd) and not Lex.AtEnd do
            begin
              dirText := dirText + Lex.Token;
              Lex.Next;
            end;
            if bProcess then
            begin
              dirText := Replace(Trim(dirText), '"', '');
              raise EPreprocessorException.Create(dirText, lineNo);
            end;
            // output a blank line to replace directive
            OutStrings.Add('');
          end
          else if (dir = '#define') or (dir = '#undef') then
          begin
            cnt := 1; // number of lines in #define
            if bProcess then
              cnt := cnt + ProcessMacroDefinition(dir = '#undef', Lex, lineNo);
            // output blank line(s) to replace #define
            for i := 0 to cnt - 1 do
              OutStrings.Add('');
          end
          else if (dir = '#if') or (dir = '#elif') then
          begin
            // increment level
            Lex.Next; // token ID should be piSpace
            if Lex.Id <> piSpace then
              raise EPreprocessorException.Create(sInvalidPreprocDirective, lineNo);
            dirText := '';
            while (Lex.Id <> piLineEnd) and not Lex.AtEnd do
            begin
              dirText := dirText + Lex.Token;
              Lex.Next;
            end;
            // replace defined(xxx) or defined IDENT with a 0 or 1
            dirText := ProcessDefinedFunction(dirText);
            // replace defined macros in expression
            dirText := ReplaceTokens(dirText, lineNo, False);
            if dir = '#if' then
            begin
              // reset bProcess to reflect the containing level's value
              bProcess := not GetLevelIgnoreValue(lineNo);
              // evaluate expression
              // if we are already ignoring code because of a containing
              // if/elif/ifdef/ifndef then it doesn't matter what the
              // expression evaluates to
              bDefined := EvaluateExpression(dirText, lineNo) and bProcess;
              if bDefined then
                fLevelIgnore.Add(TProcessLevel.Create)
              else
                fLevelIgnore.Add(TIgnoreLevel.Create); // continue to ignore
              inc(fLevel);
              bProcess := not GetLevelIgnoreValue(lineNo);
            end
            else
            begin
              dec(fLevel);
              // reset bProcess to reflect the containing level's value
              bProcess := not GetLevelIgnoreValue(lineNo);
              // evaluate expression
              // if we are already ignoring code because of a containing
              // if/elif/ifdef/ifndef then it doesn't matter what the
              // expression evaluates to
              bDefined := EvaluateExpression(dirText, lineNo) and bProcess;
              // restore current nesting level
              inc(fLevel);
              // #elif does not increase the level
              // have we already been processing code at this level?
              bProcess := not GetLevelIgnoreValue(lineNo);
              if bProcess or (not bProcess and bDefined) then
              begin
                // if we are already processing then always
                // turn off processing
                // if we are not already processing then turn ON
                // processing if bDefined is true
                SwitchLevelIgnoreValue(lineNo);
                bProcess := not GetLevelIgnoreValue(lineNo);
              end;
            end;
            // output a blank line to replace directive
            OutStrings.Add('');
          end
          else if (dir = '#ifndef') or (dir = '#ifdef') then
          begin
            // increment level
            Lex.Next; // token ID should be piSpace
            if Lex.Id <> piSpace then
              raise EPreprocessorException.Create(sInvalidPreprocDirective, lineNo);
            Lex.Next; // token ID should be piIdent or piNumber
            if not Lex.Id in [piIdent, piNumber] then
              raise EPreprocessorException.Create(sInvalidPreprocDirective, lineNo);
            if Lex.Id = piIdent then
            begin
              macro := Lex.Token; // the macro name
              bDefined := MacroDefs.IndexOf(macro) <> -1;
            end
            else
            begin
              // Lex.Token == number
              i := StrToIntDef(Lex.Token, 0);
              bDefined := i <> 0;
            end;
            if not bProcess then
            begin
              // if we are already ignoring code because of a containing
              // ifdef/ifndef then always ignore anything below this level
              fLevelIgnore.Add(TIgnoreLevel.Create);
            end
            else
            begin
              if (bDefined and (dir = '#ifdef')) or not (bDefined or (dir = '#ifdef')) then
                fLevelIgnore.Add(TProcessLevel.Create)
              else
                fLevelIgnore.Add(TIgnoreLevel.Create);
            end;
            inc(fLevel);
            bProcess := not GetLevelIgnoreValue(lineNo);
            // output a blank line to replace directive
            OutStrings.Add('');
          end
          else if dir = '#endif' then
          begin
            // decrement level
            fLevelIgnore.Delete(fLevel);
            dec(fLevel);
            bProcess := not GetLevelIgnoreValue(lineNo);
            // output a blank line to replace directive
            OutStrings.Add('');
          end
          else if dir = '#else' then
          begin
            // switch mode at current level (must be > 0)
            SwitchLevelIgnoreValue(lineNo);
            bProcess := not GetLevelIgnoreValue(lineNo);
            // output a blank line to replace directive
            OutStrings.Add('');
          end
          else if (dir = '#pragma') or (dir = '#line') then
          begin
            // collect to end of line
            Lex.Next;
            while (Lex.Id <> piLineEnd) and not Lex.AtEnd do
            begin
              dirText := dirText + Lex.Token;
              Lex.Next;
            end;
            if bProcess then
            begin
              dirText := dir + ' ' + Trim(dirText);
              OutStrings.Add(dirText);
              if dir = '#line' then
              begin
                // get filename
                qPos := Pos('"', dirText);
                if qPos > 0 then
                begin
                  System.Delete(dirText, 1, qPos);
                  qPos := Pos('"', dirText);
                  if qPos > 0 then
                  begin
                    tmpName := Copy(dirText, 1, qPos-1);
                    name := tmpName;
                  end;
                end;
              end;
            end;
          end;
          // eat to end of line
          while (Lex.Id <> piLineEnd) and not Lex.AtEnd do
            Lex.Next;
          inc(lineNo);
        end;
        piZero, piUnknown : {do nothing};
        piIdent : begin
          if bProcess then
          begin
            oldLineNo := lineNo;
            tmp := ProcessIdentifier(Lex, lineNo);
            if Pos(#10, tmp) > 0 then
            begin
              if AddPoundLineToMultiLineMacros then
              begin
                // add #line to multi-line macros
                tmp := tmp + Format(#13#10'#line %d "%s"'#13#10, [oldLineNo-1, name]);
              end;
               // if we just processed a multi-line macro then we need to first
              // output S (if not empty) and then set S equal to our multi-line macro
              if Trim(S) <> '' then
              begin
                // output S and then set it to tmp
                AddOneOrMoreLines(OutStrings, S, name, lineNo);
              end;
              S := tmp;
            end
            else
              S := S + tmp;
          end;
        end;
      else
        if bProcess then
          S := S + Lex.Token;
      end;
      Lex.Next;
    end;
    // 2006-12-11 JCH - need to add the very last token
    if bProcess and not (Lex.Id in [piLineEnd, piInnerLineEnd]) then
      S := S + Lex.Token;
    if fLevel <> origLevel then
      raise EPreprocessorException.Create(sUnmatchedDirective, lineNo);
    if (S <> '') and bProcess then
      AddOneOrMoreLines(OutStrings, S, name, lineNo);
  finally
    Lex.Free;
  end;
end;

constructor TLangPreprocessor.Create(GLType : TGenLexerClass; const defIncDir : string);
begin
  inherited Create;
  fAddPoundLine := False;
  fGLC := GLType;
  fWarnings := TStringList.Create;
  IncludeDirs := TStringList.Create;
  IncludeDirs.Add(defIncDir);
  MacroDefs := TMapList.Create;
  MacroFuncArgs := TMapList.Create;
  fLevelIgnore := TObjectList.Create;
  fIncludeFilesToSkip := TStringList.Create;
  with TStringList(fIncludeFilesToSkip) do
  begin
    Sorted := True;
    Duplicates := dupIgnore;
  end;
  fCalc := TNBCExpParser.Create(nil);
  fCalc.CaseSensitive := True;
  fCalc.StandardDefines := True;
  fCalc.ExtraDefines := True;
  fLexers := TObjectList.Create;
  InitializeLexers(10);
//  fCalc.OnParserError := HandleCalcParserError;
//  fVarI := 0;
//  fVarJ := 0;
//  LoadStandardMacros;
end;

destructor TLangPreprocessor.Destroy;
begin
  IncludeDirs.Clear;
  MacroDefs.Clear;
  MacroFuncArgs.Clear;
  FreeAndNil(IncludeDirs);
  FreeAndNil(MacroDefs);
  FreeAndNil(MacroFuncArgs);
  FreeAndNil(fLevelIgnore);
  FreeAndNil(fIncludeFilesToSkip);
  FreeAndNil(fCalc);
  FreeAndNil(fLexers);
  FreeAndNil(fWarnings);
  inherited;
end;

procedure TLangPreprocessor.AddIncludeDirs(aStrings: TStrings);
begin
  IncludeDirs.AddStrings(aStrings);
end;

function TLangPreprocessor.GenLexerType: TGenLexerClass;
begin
  Result := fGLC;
end;

function TLangPreprocessor.EvaluateIdentifier(const ident: string): string;
begin
  Result := ident;
  // try to evaluate Result
  fCalc.SilentExpression := Result;
  if not fCalc.ParserError then
  begin
    Result := IntToStr(Trunc(fCalc.Value));
  end;
end;

function TLangPreprocessor.GetDefines: TMapList;
begin
  Result := MacroDefs;
end;

function TLangPreprocessor.EvaluateExpression(expr: string; lineno : integer): boolean;
begin
  // try to evaluate Result
  while Pos(' ', expr) > 0 do
    expr := Replace(expr, ' ', '');
  fCalc.SilentExpression := expr;
  if not fCalc.ParserError then
  begin
    Result := Trunc(fCalc.Value) <> 0;
  end
  else
    raise EPreprocessorException.Create(Format(sInvalidPreprocExpression, [fCalc.ErrorMessage]), lineno);
end;

function TLangPreprocessor.ProcessDefinedFunction(expr: string): string;
var
  p : integer;
  first, ident, last, delim : string;
begin
  Result := Trim(expr);
  p := Pos('defined', Result);
  while p <> 0 do
  begin
    // replace defined(xxx) or defined xxx with 0 or 1
    first := Copy(Result, 1, p-1);
    System.Delete(Result, 1, p+6);
    Result := Trim(Result); // remove any initial or trailing whitespace
    delim := ' ';
    if Pos('(', Result) = 1 then
    begin
      System.Delete(Result, 1, 1);
      delim := ')';
    end;
    // grab the identifier
    p := Pos(delim, Result);
    if p = 0 then
      p := Length(Result)+1;
    ident := Trim(Copy(Result, 1, p-1));
    System.Delete(Result, 1, p);
    last := Result;
    // is ident defined?
    Result := Format('%s %d %s', [first, Ord(MacroDefs.IndexOf(ident) <> -1), last]);
    p := Pos('defined', Result);
  end;
end;

procedure TLangPreprocessor.SkipIncludeFile(const fname: string);
begin
  fIncludeFilesToSkip.Add(fname);
end;

function TLangPreprocessor.AcquireLexer(const lineNo : integer): TGenLexer;
begin
  if fRecursionDepth < fLexers.Count then
  begin
    Result := TGenLexer(fLexers[fRecursionDepth]);
    inc(fRecursionDepth);
  end
  else
    raise EPreprocessorException.Create(Format(sMaxRecursionDepthError, [fLexers.Count]), lineNo);
end;

procedure TLangPreprocessor.ReleaseLexer;
begin
  dec(fRecursionDepth);
end;

procedure TLangPreprocessor.InitializeLexers(const num: integer);
var
  i : integer;
begin
  for i := 0 to num - 1 do
    fLexers.Add(fGLC.CreateLexer);
end;

{ EPreprocessorException }

constructor EPreprocessorException.Create(const msg: string;
  const lineno: integer);
begin
  inherited Create(msg);
  fLineNo := lineno;
end;

{ TMapList }

type
  TStrObj = class(TObject)
  public
    Value : string;
  end;

function TMapList.AddEntry(const aName, aValue: string): integer;
var
  obj : TStrObj;
begin
  Result := IndexOf(aName);
  if Result = -1 then
  begin
    obj := TStrObj.Create;
    Result := AddObject(aName, obj);
    obj.Value := aValue;
  end;
end;

procedure TMapList.Clear;
var
  i : integer;
begin
  for i := 0 to Count - 1 do
    Objects[i].Free;
  inherited;
end;

constructor TMapList.Create;
begin
  inherited;
  CaseSensitive := True;
  ConsiderCase  := True;
  Sorted := True;
  Duplicates := dupIgnore;
end;

procedure TMapList.Delete(Index: Integer);
begin
  Objects[Index].Free;
  Objects[Index] := nil;
  inherited;
end;

function TMapList.GetMapValue(index: integer): string;
begin
  Result := TStrObj(Objects[index]).Value;
end;

procedure TMapList.SetMapValue(index: integer; const Value: string);
begin
  TStrObj(Objects[index]).Value := Value;
end;

procedure TMapList.SetConsiderCase(const AValue: boolean);
begin
  if fConsiderCase=AValue then exit;
  fConsiderCase:=AValue;
  if Sorted then
    Sort;
end;

{$IFDEF FPC}
function TMapList.DoCompareText(const s1, s2: string): PtrInt;
begin
  if CaseSensitive or ConsiderCase then
    result := AnsiCompareStr(s1,s2)
  else
    result := AnsiCompareText(s1,s2);
end;
{$ENDIF}

procedure TMapList.AddDefines(aValue: TStrings);
var
  i : integer;
begin
  for i := 0 to aValue.Count - 1 do
    AddEntry(aValue.Names[i], aValue.ValueFromIndex[i]);
end;

procedure TMapList.Define(const aName: string);
begin
  AddEntry(aName, '1');
end;

{ TPreprocLevel }

constructor TPreprocLevel.Create;
begin
  Taken := False;
  Ignore := False;
end;

{ TProcessLevel }

constructor TProcessLevel.Create;
begin
  inherited;
  Ignore := False;
  Taken  := True;
end;

{ TIgnoreLevel }

constructor TIgnoreLevel.Create;
begin
  inherited;
  Ignore := True;
end;

end.
