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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uParseCommon;

interface

uses
  uLocalizedStrings,
  mPasLex,
  mwBCBTokenList;

type
  TProcType = (ptMacros, ptFunctions, ptSubroutines, ptTasks, ptProcedures,
               ptConstructors, ptDestructors);

  TExploredLanguage = (elNQC, elMindScript, elCpp, elPas, elJava, elForth,
    elNBC, elLASM, elNXC);

  TCodeExplorerProperties = record
    CategorySort : string;
    AutoShowExplorer : boolean;
    DeclarationSyntax : boolean;
    UseAlphaSort : boolean;
    Visible : array[TProcType] of Boolean;
    Expand : array[TProcType] of Boolean;
  end;

  TProcedureListProperties = record
    SearchAll : Boolean;
    Left : Integer;
    Top : Integer;
    Width : Integer;
    Height : Integer;
    SortColumn : Integer;
    FontName : string;
    FontSize : Integer;
  end;

const
  K_VOID = 'void';
  K_PROC = 'proc';
  K_CONS = 'cons';
  K_DEST = 'des';
  K_SUBR = 'sub';
  K_TASK = 'task';
  K_MACR = 'macro';

const
  PROC_TYPES : array[TProcType] of string =
    (sMacros, sFunctions, sSubroutines, sTasks, sProcedures,
     sConstructors, sDestructors);

  PROC_NAMES : array[TProcType] of string =
    (K_MACR, K_VOID, K_SUBR, K_TASK, K_PROC, K_CONS, K_DEST);

  VISIBLE_PROC_TYPES : array[TExploredLanguage] of array[TProcType] of Boolean =
    (
     (false,  true,  true,  true, false, false, false), // elNQC
     ( true,  true,  true,  true, false, false, false), // elMindScript
     (false,  true, false, false,  true,  true,  true), // elCpp
     (false,  true, false, false,  true,  true,  true), // elPas
     (false,  true, false, false,  true,  true,  true), // elJava
     (false,  true, false, false, false, false, false), // elForth
     (false, false,  true,  true, false, false, false), // elNBC
     (false, false,  true,  true, false, false, false), // elLASM
     (false,  true, false,  true,  true, false, false)  // elNXC
    );

type
  TPascalProcessProc = procedure(pline : string; ptype : TTokenKind;
    lineNo : Integer; isClass : Boolean) of object;
  TCppProcessProc = procedure(pidx, lineNo : Integer;
    pline, ptype, pname, pclass, pargs, retType : string) of object;
  TMindscriptProcessProc = procedure(lineNo : Integer; pname, ptype : string) of object;
  TForthProcessProc = procedure(lineNo : Integer; pname, ptype : string) of object;
  TNBCProcessProc = procedure(lineNo : Integer; pname, ptype : string) of object;
  TLASMProcessProc = procedure(lineNo : Integer; pname, ptype : string) of object;


function GetCppProcType(idx : Integer; theLang : TExploredLanguage; retType : string; ExplorerMode : Boolean = true) : string;
function GetProperProcName(ProcType: TTokenKind; IsClass: Boolean; ExplorerMode : Boolean = true): string;
function ProcessPascalName(const aName : string) : String;
function CompressWhiteSpace(const Str: string): string;
function RemoveTrailingSemicolon(const aName : string) : string;
function FindBeginningProcedureBrace(CParser : TBCBTokenList; theLang : TExploredLanguage;
  start, Timeout : Cardinal; var BraceCount : Integer; var Name : string) : Integer;
procedure FindPascalProcs(Timeout : Cardinal; Parser : TmwPasLex; Proc : TPascalProcessProc);
procedure FindCppProcs(Timeout : Cardinal; CParser : TBCBTokenList; theLang : TExploredLanguage;
  Proc : TCppProcessProc; ExplorerMode : Boolean = True);

implementation

uses
  SysUtils, Classes, mwGenericLex, uCommonUtils;

const
  ImageIndexGear     = 0;
  ImageIndexFunction = 1;
  ImageIndexNew      = 2;
  ImageIndexTrash    = 3;

type
  TPascalProcType = (pptUnknown, pptFunction, pptProcedure, pptConstructor, pptDestructor);

const
  PascalProcTypeNames : array[Boolean, Boolean, TPascalProcType] of string =
  (
   ((sUnknown, sFunction, sProcedure, sConstructor, sDestructor),
    (sUnknown, sClassFunc, sClassProc, sUnknown, sUnknown)),
   ((sUnknown, K_VOID, K_PROC, K_CONS, K_DEST),
    (sUnknown, K_VOID, K_PROC, sUnknown, sUnknown))
  );

function TokenKindToPascalProcType(aTokenKind : TTokenKind) : TPascalProcType;
begin
  case aTokenKind of
    tkFunction : Result := pptFunction;
    tkProcedure : Result := pptProcedure;
    tkConstructor : Result := pptConstructor;
    tkDestructor : Result := pptDestructor;
  else
    Result := pptUnknown;
  end;
end;

function GetProperProcName(ProcType: TTokenKind; IsClass: Boolean; ExplorerMode : Boolean): string;
begin
  Result := PascalProcTypeNames[ExplorerMode, IsClass, TokenKindToPascalProctype(ProcType)];
end;

function MoveToImplementation(aPascalLexer : TmwPasLex) : Boolean;
var
  bUnitOrProgram : Boolean;
begin
  bUnitOrProgram := False;
  // does it start with the word unit?
  while aPascalLexer.TokenID <> tkNull do
  begin
    // look for program or unit
    if aPascalLexer.TokenID in [tkProgram, tkUnit] then
    begin
      bUnitOrProgram := True;
      Break;
    end;
    aPascalLexer.Next;
  end;
  if bUnitOrProgram then
  begin
    if aPascalLexer.TokenID = tkProgram then
    begin
      Result := True;
      Exit;
    end;
  end
  else
  begin
    // must be an include file???
    aPascalLexer.RunPos := 0;
    Result := True;
    Exit;
  end;
  Result := False;
  while aPascalLexer.TokenID <> tkNull do
  begin
    if aPascalLexer.TokenID = tkImplementation then
      Result := True;
    aPascalLexer.Next;
    if Result then
      Break;
  end;
end;

function ProcessPascalName(const aName : string) : string;
var
  i : Integer;
begin
  Result := aName;
  // Remove the class reserved word
  i := Pos('CLASS ', UpperCase(Result)); // Do not localize.
  if i = 1 then
    Delete(Result, 1, Length('CLASS ')); // Do not localize.
  // Remove 'function' or 'procedure'
  i := Pos(' ', Result);
  if i > 0 then
    Result := Copy(Result, i + 1, Length(Result))
  else
    Result := Result;
  // Remove the paramater list
  i := Pos('(', Result);
  if i > 0 then
    Result := Copy(Result, 1, i - 1);
  // Remove the function return type
  i := Pos(':', Result);
  if i > 0 then
    Result := Copy(Result, 1, i - 1);
end;

function CompressWhiteSpace(const Str: string): string;
var
  i: Integer;
  Len: Integer;
  NextResultChar: Integer;
  CheckChar: Char;
  NextChar: Char;
begin
  Len := Length(Str);
  NextResultChar := 1;
  SetLength(Result, Len);

  for i := 1 to Len do
  begin
    CheckChar := Str[i];
    {$RANGECHECKS OFF}
    NextChar := Str[i + 1];
    {$RANGECHECKS ON}
    case CheckChar of
      #9, #10, #13, #32:
        begin
          if (NextChar in [#0, #9, #10, #13, #32]) or (NextResultChar = 1) then
            Continue
          else
          begin
            Result[NextResultChar] := #32;
            Inc(NextResultChar);
          end;
        end;
      else
        begin
          Result[NextResultChar] := Str[i];
          Inc(NextResultChar);
        end;
    end;
  end;
  if Len = 0 then
    Exit;
  SetLength(Result, NextResultChar - 1);
end;

function RemoveTrailingSemicolon(const aName : string) : string;
begin
  Result := aName;
  // Remove any trailing ';'
  if Result[Length(Result)] = ';' then
    Delete(Result, Length(Result), 1);
  Result := Trim(Result);
end;

procedure FindBeginningBrace(CParser : TBCBTokenList; start, Timeout : Cardinal; var BraceCount : integer);
begin
  repeat
    CParser.NextNonJunk;
    case CParser.RunID of
      ctkbraceopen: Inc(BraceCount);
      ctkbraceclose: Dec(BraceCount);
      ctknull: Exit;
    end;
    if (GetTick - start) > Timeout then Exit;
  until (CParser.RunID = ctkbraceopen) or
        (CParser.RunID = ctkbracepair) or
        (CParser.RunID = ctknull);
end;

function CheckForJavaThrows(CParser : TBCBTokenList; theStart : integer; start, Timeout : Cardinal) : integer;
begin
  Result := CParser.RunPosition; // if not found go back here
  while CParser.RunPosition >= theStart do
  begin
    if CParser.RunToken = 'throws' then
      Exit;
    // Now we want to break if we are equal to start
    if CParser.RunPosition = theStart then
      Break;
    CParser.PreviousNonJunk;
    if (GetTick - start) > Timeout then Exit;
  end;
  while CParser.RunPosition < Result do begin
    CParser.NextNonJunk;
    if (GetTick - start) > Timeout then Exit;
  end;
end;

function FindBeginningProcedureBrace(CParser : TBCBTokenList; theLang : TExploredLanguage;
  start, Timeout : Cardinal; var BraceCount : Integer; var Name : string) : Integer;
var
  InitialPosition, RestorePosition, ThrowRestorePos : Integer;
  FoundClass : Boolean;
begin
  Result := 0;
  InitialPosition := CParser.RunPosition;
  // Skip these: enum {a, b, c};  or  int a[] = {0, 3, 5};  and find  foo () {
  FindBeginningBrace(CParser, start, Timeout, BraceCount);
  ThrowRestorePos := CParser.RunPosition;
  if CParser.RunID = ctknull then
    Exit;
  if theLang = elJava then
    ThrowRestorePos := CheckForJavaThrows(CParser, InitialPosition, start, Timeout);
  CParser.PreviousNonJunk;
  // JCH - we might want to keep track of namespace names and class names (just in case)
  if CParser.RunID = ctkidentifier then
  begin
    Name := CParser.RunToken;
    // but maybe it is a descendant class so double check
    // search backward no further than InitialPosition
    RestorePosition := CParser.RunPosition;
    FoundClass      := False;
    while CParser.RunPosition >= InitialPosition do
    begin
      if CParser.RunID in [ctkclass, ctkstruct, ctknamespace] then
      begin
        FoundClass := True;
        Break;
      end;
      // Now we want to break if we are equal to our initial position
      if CParser.RunPosition = InitialPosition then
        Break;
      CParser.PreviousNonJunk;
      if (GetTick - start) > Timeout then Exit;
    end;
    // if we found a class then the next token should be the correct Name
    if FoundClass then begin
      CParser.NextNonJunk;
      if CParser.RunID = ctkidentifier then begin
        // JCH - special handling for ATL_NO_VTABLE
        if CParser.RunToken = 'ATL_NO_VTABLE' then
        begin
          CParser.NextNonJunk;
          if CParser.RunID = ctkidentifier then
            Name := CParser.RunToken;
        end
        else
          Name := CParser.RunToken;
      end;
    end;
    // now get back to where you belong
    while CParser.RunPosition < RestorePosition do begin
      CParser.NextNonJunk;
      if (GetTick - start) > Timeout then Exit;
    end;
    CParser.NextNonJunk;
    result := CParser.RunPosition;
  end
  else
  begin
    if (CParser.RunID in [ctkroundclose, ctkroundpair, ctkconst, ctkvolatile, ctknull]) then
    begin
      Name := '';
      if theLang = elJava then
      begin
        while CParser.RunPosition < ThrowRestorePos do begin
          CParser.NextNonJunk;
          if (GetTick - start) > Timeout then Exit;
        end;
      end
      else
        CParser.NextNonJunk;
      result := CParser.RunPosition;
    end
    else
    begin
      while not (CParser.RunID in [ctkroundclose, ctkroundpair, ctkconst, ctkvolatile, ctknull]) do
      begin
        CParser.NextNonJunk;
        // recurse if we haven't reached the end of the file.
        if CParser.RunID = ctknull then Exit; // Break;
        Result := FindBeginningProcedureBrace(CParser, theLang, start, Timeout, BraceCount, Name);
        CParser.PreviousNonJunk;
        if Name <> '' then Break;
        if (GetTick - start) > Timeout then Exit;
      end;
      CParser.NextNonJunk;
    end;
  end;
end;

procedure FindPascalProcs(Timeout : Cardinal; Parser : TmwPasLex; Proc : TPascalProcessProc);
var
  ProcLine: string;
  ProcType: TTokenKind;
  Line: Integer;
  ClassLast: Boolean;
  InParenthesis: Boolean;
  InTypeDeclaration: Boolean;
  FoundNonEmptyType: Boolean;
  IdentifierNeeded: Boolean;
  start : cardinal;
begin
  start := GetTick;
  if not MoveToImplementation(Parser) then
    raise Exception.Create(SImplementationNotFound);
  ClassLast := False;
  InParenthesis := False;
  InTypeDeclaration := False;
  FoundNonEmptyType := False;

  while Parser.TokenID <> tkNull do
  begin
    if not InTypeDeclaration and
      (Parser.TokenID in [tkFunction, tkProcedure, tkConstructor, tkDestructor]) then
    begin
      IdentifierNeeded := True;
      ProcType := Parser.TokenID;
      Line := Parser.LineNumber + 1;
      ProcLine := '';
      while not (Parser.TokenId in [tkNull]) do
      begin
        case Parser.TokenID of
          tkIdentifier, tkRegister:
            IdentifierNeeded := False;

          tkRoundOpen:
            begin
              // Did we run into an identifier already?
              // This prevents
              //    AProcedure = procedure() of object
              // from being recognised as a procedure
              if IdentifierNeeded then
                Break;
              InParenthesis := True;
            end;

          tkRoundClose:
            InParenthesis := False;

        else
          // nothing
        end; // case

        if (not InParenthesis) and (Parser.TokenID = tkSemiColon) then
          Break;

        if not (Parser.TokenID in [tkCRLF, tkCRLFCo]) then
          ProcLine := ProcLine + Parser.Token;
        Parser.Next;
      end; // while
      if Parser.TokenID = tkSemicolon then
        ProcLine := ProcLine + ';';
      if ClassLast then
        ProcLine := 'class ' + ProcLine; // Do not localize.
      if not IdentifierNeeded then
      begin
        Proc(ProcLine, ProcType, Line, ClassLast);
      end;
    end;
    if (Parser.TokenID in [tkClass, tkObject]) and Parser.IsClass then
    begin
      InTypeDeclaration := True;
      FoundNonEmptyType := False;
    end
    else if InTypeDeclaration and
      (Parser.TokenID in [tkIdentifier, tkProcedure, tkFunction, tkProperty,
      tkPrivate, tkProtected, tkPublic, tkPublished]) then
    begin
      FoundNonEmptyType := True;
    end
    else if InTypeDeclaration and
      ((Parser.TokenID = tkEnd) or
      ((Parser.TokenID = tkSemiColon) and not FoundNonEmptyType)) then
    begin
      InTypeDeclaration := False;
    end;
    ClassLast := Parser.TokenID in [tkClass, tkObject];
    if ClassLast then
    begin
      Parser.NextNoJunk;
    end
    else
      Parser.Next;
    if (GetTick - start) > Timeout then Exit;
  end;
end;

function GetCppProcType(idx : Integer; theLang : TExploredLanguage; retType : string; ExplorerMode : boolean) : string;
begin
  if ExplorerMode then
  begin
    case idx of
      ImageIndexFunction, ImageIndexGear:
        if theLang = elNXC then
        begin
          if Pos(K_VOID, retType) <> 0 then
            Result := K_PROC   // Procedure
          else if Pos(K_SUBR, retType) <> 0 then
            Result := K_PROC
          else if Pos(K_TASK, retType) <> 0 then
            Result := K_TASK
          else
            Result := K_VOID; // Function
        end
        else
        begin
          if Pos(K_VOID, retType) <> 0 then
            Result := K_PROC   // Procedure
          else
            Result := K_VOID; // Function
        end;
      ImageIndexNew: Result := K_CONS;   // Constructor
      ImageIndexTrash: Result := K_DEST;   // Destructor
    else
      Result := sUnknown;
    end;
  end
  else
  begin
    case idx of
      ImageIndexFunction, ImageIndexGear:
        if theLang = elNQC then
        begin
          if Pos(K_VOID, retType) <> 0 then
            Result := sFunction
          else if Pos(K_SUBR, retType) <> 0 then
            Result := sSubroutine
          else if Pos(K_TASK, retType) <> 0 then
            Result := sTask;
        end
        else if theLang = elNXC then
        begin
          if Pos(K_VOID, retType) <> 0 then
            Result := sSubroutine
          else if Pos(K_SUBR, retType) <> 0 then
            Result := sSubroutine
          else if Pos(K_TASK, retType) <> 0 then
            Result := sTask
          else
            Result := sFunction;
        end
        else
        begin
          if Pos(K_VOID, retType) <> 0 then
            if idx = ImageIndexGear then
              Result := sClassProc
            else
              Result := sProcedure
          else
            if idx = ImageIndexGear then
              Result := sClassFunc
            else
              Result := sFunction;
        end;
      ImageIndexNew: Result := sConstructor;
      ImageIndexTrash: Result := sDestructor;
    else
      Result := sUnknown;
    end;
  end;
end;

procedure FindCppProcs(Timeout : Cardinal; CParser : TBCBTokenList; theLang : TExploredLanguage;
  Proc : TCppProcessProc; ExplorerMode : Boolean);
var
  ProcLine: string;
  BeginProcHeaderPosition, ThrowsPos: Longint;
  i, j: Integer;
  LineNo: Integer;
  ProcName, ProcReturnType: string;
  ProcedureType, ProcClass, ProcArgs: string;
  ProcIndex: Integer;
  BeginBracePosition: Longint;
  BraceCount, PreviousBraceCount: Integer;
  start : cardinal;
  NameList : TStringList;
  NewName, TmpName, ProcClassAdd, ClassName : string;
  BraceCountDelta : Integer;
  TemplateArgs : string;

    function SearchForProcedureName : string;
    var
      ParenCount : Integer;
    begin
      ParenCount := 0;
      Result := '';
      repeat
        CParser.Previous;
        if CParser.RunID <> ctkcrlf then
          if (CParser.RunID = ctkspace) and (CParser.RunToken = #9) then
            Result := #32 + Result
          else
            Result := CParser.RunToken + Result;
        case CParser.RunID of
          ctkroundclose: Inc(ParenCount);
          ctkroundopen: Dec(ParenCount);
          ctknull: Exit;
        end;
        if (GetTick - start) > Timeout then Exit;
      until ((ParenCount = 0) and ((CParser.RunID = ctkroundopen) or (CParser.RunID = ctkroundpair)));
      CParser.PreviousNonJunk; // This is the procedure name
    end;

    function SearchForTemplateArgs : string;
    var
      AngleCount : Integer;
    begin
      Result := '';
      if CParser.RunID <> ctkGreater then
        Exit; // only use if we are on a '>'
      AngleCount := 1;
      Result := CParser.RunToken;
      repeat
        CParser.Previous;
        if CParser.RunID <> ctkcrlf then
          if (CParser.RunID = ctkspace) and (CParser.RunToken = #9) then
            Result := #32 + Result
          else
            Result := CParser.RunToken + Result;
        case CParser.RunID of
          ctkgreater: Inc(AngleCount);
          ctklower: Dec(AngleCount);
          ctknull: Exit;
        end;
        if (GetTick - start) > Timeout then Exit;
      until  (((AngleCount = 0) and (CParser.RunID = ctklower)) or (CParser.RunIndex = 0));
      CParser.PreviousNonJunk; // This is the token before the template args
    end;

    function ProcHasThrowsSpec(theStart, theEnd : Integer; var ThrowsPos : integer) : Boolean;
    begin
      Result := False;
      ThrowsPos := 0;
      // search backward toward theStart looking for a token == 'throws'
      while CParser.RunPosition > theStart do
      begin
        if CParser.RunToken = 'throws' then
        begin
          Result := True;
          ThrowsPos := CParser.RunPosition;
          Exit;
        end;
        CParser.PreviousNonJunk;
        if (GetTick - start) > Timeout then Exit;
      end;
      // reset the parser back to where it was
      while CParser.RunPosition < theEnd do begin
        CParser.NextNonComment;
        if (GetTick - start) > Timeout then Exit;
      end;
    end;

  procedure EraseName(Index : Integer);
  var
    NameIndex : Integer;
  begin
    NameIndex := NameList.IndexOfName(IntToStr(Index));
    if NameIndex <> -1 then
      NameList.Delete(NameIndex);
  end;
begin
  start := GetTick;
  NameList := TStringList.Create;
  try
    BraceCount := 0;
    NameList.Add('0='); // empty enclosure name
    j := CParser.TokenPositionsList[CParser.TokenPositionsList.Count - 1];
    PreviousBraceCount := BraceCount;
    BeginBracePosition := FindBeginningProcedureBrace(CParser, theLang, start, Timeout, BraceCount, NewName);

    while (CParser.RunPosition <= j - 1) or (CParser.RunID <> ctknull) do
    begin
      // if NewName = '' then we are looking at a real procedure - otherwise
      // we've just found a new enclosure name to add to our list
      if NewName = '' then
      begin
        // If we found a brace pair then special handling is necessary
        // for the bracecounting stuff (it is off by one)
        if CParser.RunID = ctkbracepair then
          BraceCountDelta := 0
        else
          BraceCountDelta := 1;
        if (BraceCountDelta > 0) and (PreviousBraceCount >= BraceCount) then
          EraseName(PreviousBraceCount);
        // back up a tiny bit so that we are "in front of" the
        // ctkbraceopen or ctkbracepair we just found
        CParser.Previous;

        while not ((CParser.RunID in [ctksemicolon, ctkbraceclose, ctkbraceopen, ctkbracepair]) or
                   (CParser.RunID in IdentDirect) or
                   (CParser.RunIndex = 0)) do
        begin
          CParser.PreviousNonJunk;
          // Handle the case where a colon is part of a valid procedure definition
          if CParser.RunID = ctkcolon then
          begin
            // the only way a colon is valid in a procedure definition
            // is if it is immediately following a close parenthesis
            // possibly separated by only "junk"
            CParser.PreviousNonJunk;
            if CParser.RunID in [ctkroundclose, ctkroundpair] then
              CParser.NextNonJunk
            else
            begin
              // restore position and stop searching backward.
              CParser.NextNonJunk;
              Break;
            end;
          end;
          if (GetTick - start) > Timeout then Exit;
        end;

        if CParser.RunID in [ctkcolon, ctksemicolon, ctkbraceclose, ctkbraceopen, ctkbracepair] then
          CParser.NextNonComment
        else if CParser.RunIndex = 0 then
        begin
          if CParser.IsJunk then
            CParser.NextNonJunk;
        end
        else // IdentDirect
        begin
          while CParser.RunID <> ctkcrlf do
          begin
            if (CParser.RunID = ctknull) then
              Exit;
            CParser.Next;
            if (GetTick - start) > Timeout then Exit;
          end;
          CParser.NextNonJunk;
        end;
        // We are at the beginning of procedure header
        BeginProcHeaderPosition := CParser.RunPosition;

        ProcLine := '';
        while (CParser.RunPosition < BeginBracePosition) and (CParser.RunID <> ctkcolon) do
        begin
          if (CParser.RunID = ctknull) then
            Exit
          else if (CParser.RunID <> ctkcrlf) then
            if (CParser.RunID = ctkspace) and (CParser.RunToken = #9) then
              ProcLine := ProcLine + #32
            else
              ProcLine := ProcLine + CParser.RunToken;
          CParser.NextNonComment;
          if (GetTick - start) > Timeout then Exit;
        end;
        // We are at the end of a procedure header
        // Go back and skip parenthesis to find the procedure name
        ProcName := '';
        ProcClass := '';
        ProcReturnType := '';
        if (theLang = elJava) and
           ProcHasThrowsSpec(BeginProcHeaderPosition, CParser.RunPosition, ThrowsPos) then
        begin
          // if the Java method has a throws specification then back up past it
          // Then use the Cpp technique as normal.  A side effect of calling
          // this method (if it returns true) is that we have already backed
          // up to the 'throws' token
        end;
        ProcArgs := SearchForProcedureName;
        if CParser.RunID = ctknull then
          Exit;
        if (theLang = elCpp) and (CParser.RunID = ctkthrow) then
        begin
          ProcArgs := CParser.RunToken + ProcArgs;
          ProcArgs := SearchForProcedureName + ProcArgs;
        end;
        // Since we've enabled nested procedures it is now possible
        // that we think we've found a procedure but what we've really found
        // is a standard C or C++ construct (like if or for, etc...)
        // To guard against this we require that our procedures be of type
        // ctkidentifier.  If not, then skip this step.
        if (CParser.RunID = ctkidentifier) and {not InProcedureBlacklist(CParser.RunToken) and}
          not ((theLang in [elNQC, elNXC]) and
               ((CParser.RunToken = 'until') or
                (CParser.RunToken = 'repeat'))) and
          not ((theLang = elJava) and
               (CParser.RunToken = 'synchronized')) then
        begin
          ProcName := CParser.RunToken;
          LineNo := CParser.PositionAtLine(CParser.RunPosition);
          CParser.PreviousNonJunk;
          if CParser.RunID = ctkcoloncolon then // The object/method delimiter
          begin
            // there may be multiple name::name::name:: sets here
            // so loop until no more are found
            ClassName := '';
            while CParser.RunID = ctkcoloncolon do begin
              CParser.PreviousNonJunk; // The object name ??
              // Unfortunately, it is possible that we are looking at a
              // templatized class and what we have in front of the :: is
              // the end of a template specialization
              // (i.e., ClassName<x, y, z>::Function)
              if CParser.RunID = ctkgreater then
                TemplateArgs := SearchForTemplateArgs;
              ProcClass := CParser.RunToken + ProcClass;
              if ClassName = '' then
                ClassName := CParser.RunToken;
              CParser.PreviousNonJunk; // look for another ::
              if CParser.RunID = ctkcoloncolon then
                ProcClass := CParser.RunToken + ProcClass;
              if (GetTick - start) > Timeout then Exit;
            end;
            // we went back one step too far so go ahead once
            CParser.NextNonJunk;
            ProcIndex := ImageIndexFunction;   // 0 ???
            if ProcName = ClassName then
              ProcIndex := ImageIndexNew;      // 2
            if ProcName = '~' + ClassName then
              ProcIndex := ImageIndexTrash;    // 3
          end
          else
          begin
            ProcIndex := ImageIndexFunction;   // 1
            // if ProcIndex is 1 then we have backed up too far
            // already so restore our previous position
            CParser.NextNonJunk;
          end;

          while CParser.RunPosition > BeginProcHeaderPosition do // Find the return type of the procedure
          begin
            CParser.PreviousNonComment;
            // Handle the possibility of template specifications and
            // do not include them in the return type
            if CParser.RunID = ctkGreater then
              TemplateArgs := SearchForTemplateArgs;
            if CParser.RunID = ctktemplate then
              Continue;
            if CParser.RunID = ctkcrlf then
              ProcReturnType := ' ' + ProcReturnType
            else
              ProcReturnType := CParser.RunToken + ProcReturnType;
            if (GetTick - start) > Timeout then Exit;
          end;

          // if the return type is an empty string then it must be a constructor
          // or a destructor (depending on the presence of a ~ in the name
          if (theLang in [elCpp, elJava]) and
             ((Trim(ProcReturnType) = '') or
              (Trim(ProcReturnType) = 'virtual') or
              (Trim(ProcReturnType) = 'public') or
              (Trim(ProcReturnType) = 'protected') or
              (Trim(ProcReturnType) = 'private')) then
          begin
            if Pos('~', ProcName) = 1 then
              ProcIndex := ImageIndexTrash // 3
            else
              ProcIndex := ImageIndexNew; // 2
          end;

          ProcLine := Trim(ProcReturnType) + ' ';

          ProcClassAdd := '';
          for i := 0 to BraceCount - BraceCountDelta do begin
            if i < NameList.Count then
            begin
              TmpName := NameList.Values[IntToStr(i)];
              if TmpName <> '' then
              begin
                if ProcClassAdd <> '' then
                  ProcClassAdd := ProcClassAdd + '::';
                ProcClassAdd := ProcClassAdd + TmpName;
              end;
            end;
          end;

          if Length(ProcClassAdd) > 0 then
          begin
            if Length(ProcClass) > 0 then
              ProcClassAdd := ProcClassAdd + '::';
            ProcClass := ProcClassAdd + ProcClass;
          end;
          if Length(ProcClass) > 0 then
            ProcLine := ProcLine + ' ' + ProcClass + '::';
          ProcLine := ProcLine + ProcName + ' ' + ProcArgs;

          // We need to double check the ProcIndex if it is = 0
          // if it isn't a "static" method it should be 1
          if (ProcIndex in [ImageIndexFunction, ImageIndexGear]) then
            if (Pos('static ', Trim(ProcReturnType)) > 0) and
               (Length(ProcClass) > 0) then
              ProcIndex := ImageIndexGear
            else
              ProcIndex := ImageIndexFunction;

          ProcedureType := GetCppProcType(ProcIndex, theLang, ProcReturnType, ExplorerMode);

          Proc(ProcIndex, LineNo, ProcLine, ProcedureType, ProcName, ProcClass, ProcArgs, ProcReturnType);

        end;
        while (CParser.RunPosition < BeginBracePosition) do begin
          CParser.Next;
          if (GetTick - start) > Timeout then Exit;
        end;
      end
      else begin
        // insert enclosure name into our list (delete the old one if found)
        EraseName(BraceCount);
        NameList.Add(IntToStr(BraceCount) + '=' + NewName);
      end;
      PreviousBraceCount := BraceCount;
      BeginBracePosition := FindBeginningProcedureBrace(CParser, theLang, start, Timeout, BraceCount, NewName);
      if (GetTick - start) > Timeout then Exit;
    end; //while (RunPosition <= j-1) ...
  finally
    NameList.Free;
  end;
end;

end.
