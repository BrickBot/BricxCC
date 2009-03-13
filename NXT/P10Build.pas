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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit P10Build;

{$H+,S-} { long strings, no stack-checking}

{.$DEFINE DEBUG} { by default make it lean and efficient }
{$IFNDEF DEBUG}
  {$D-} {$L-} {$Q-} {$R-} {$S-}
{$ENDIF}

{$I+} { I/O checking ON }

interface

uses
  Parser10,
  SysUtils, Classes;


procedure ParseFunction( FunctionString: string; { the unparsed string }
                         Variables: TStringlist; { list of variables }

                         { lists of available functions }
                         FunctionOne,               { functions with ONE argument, e.g. exp() }
                         FunctionTwo: TStringList;  { functions with TWO arguments, e.g. max(,) }

                         UsePascalNumbers: boolean; { true: -> Val; false: StrToFloat }

                         CaseSensitive: boolean;

                         { return pointer to tree, number of performed operations and error state }
                         var FirstOP : PExpOperation;

                         var Error : boolean);
                         { error actually is superfluous as we are now using exceptions }



implementation


resourcestring
  msgErrBlanks = 'Expression has blanks';
  msgMissingBrackets = 'Missing brackets in expression';
  msgParseError = 'Error parsing expression:';
  msgNestings = 'Expression contains too many nestings';
  msgTooComplex = 'Expression is too complex';
  msgInternalError = 'TParser internal error';

const
  TokenOperators = [ sum, diff, prod, divis, modulo, IntDiv,
                     bitand, bitor, bitxor, sleft, sright,
                     logand, logor,
                     lessthan,lessoreq,
                     greaterthan,greateroreq,
                     equalto,notequalto,
                     integerpower, realpower];

type
  TermString = string;


procedure ParseFunction( FunctionString: string;
                         Variables: TStringList;

                         FunctionOne,
                         FunctionTwo: TStringList;

                         UsePascalNumbers: boolean;

                         CaseSensitive: boolean;

                         var FirstOP: PExpOperation;

                         var Error: boolean);


          function CheckNumberBrackets(const s: string): boolean; forward;
          { checks whether number of ( = number of ) }

          function CheckNumber(const s: string; var FloatNumber: ParserFloat): boolean; forward;
          { checks whether s is a number }

          function CheckVariable(const s: string; var VariableID: integer): boolean; forward;
          { checks whether s is a variable string }

          function CheckTerm(var s1: string): boolean; forward;
          { checks whether s is a valid term }

          function CheckBracket(const s: string; var s1: string): boolean; forward;
          { checks whether s =(...(s1)...) and s1 is a valid term }



          function CheckNegate(const s: string; var s1: string): boolean; forward;
          {checks whether s denotes the negative value of a valid operation}

          function CheckBitNot(const s: string; var s1: string): boolean; forward;
          {checks whether ~ is the primary operation in s}

          function CheckLogicalNot(const s: string; var s1: string): boolean; forward;
          {checks whether ! is the primary operation in s}

          function CheckAdd(const s: string; var s1, s2: string): boolean; forward;
          {checks whether + is the primary operation in s}

          function CheckSubtract(const s: string; var s1, s2: string): boolean; forward;
          {checks whether - is the primary operation in s}

          function CheckMultiply(const s: string; var s1, s2: string): boolean; forward;
          {checks whether * is the primary operation in s}

          function CheckIntegerDiv(const s: string; var s1, s2: string): boolean; forward;
          {checks whether DIV is the primary TOperation in s}

          function CheckModulo(const s: string; var s1, s2: string): boolean; forward;
          {checks whether MOD is the primary TOperation in s}

          function CheckLogicalAnd(const s: string; var s1, s2: string): boolean; forward;
          {checks whether && is the primary TOperation in s}

          function CheckLogicalOr(const s: string; var s1, s2: string): boolean; forward;
          {checks whether || is the primary TOperation in s}

          function CheckBitAnd(const s: string; var s1, s2: string): boolean; forward;
          {checks whether & is the primary TOperation in s}

          function CheckBitOr(const s: string; var s1, s2: string): boolean; forward;
          {checks whether | is the primary TOperation in s}

          function CheckBitXor(const s: string; var s1, s2: string): boolean; forward;
          {checks whether ^ is the primary TOperation in s}

          function CheckEqualTo(const s: string; var s1, s2: string): boolean; forward;
          {checks whether == is the primary TOperation in s}

          function CheckNotEqualTo(const s: string; var s1, s2: string): boolean; forward;
          {checks whether != is the primary TOperation in s}

          function CheckLessThan(const s: string; var s1, s2: string): boolean; forward;
          {checks whether < is the primary TOperation in s}

          function CheckLessOrEqual(const s: string; var s1, s2: string): boolean; forward;
          {checks whether <= is the primary TOperation in s}

          function CheckGreaterThan(const s: string; var s1, s2: string): boolean; forward;
          {checks whether > is the primary TOperation in s}

          function CheckGreaterOrEqual(const s: string; var s1, s2: string): boolean; forward;
          {checks whether >= is the primary TOperation in s}

          function CheckShiftLeft(const s: string; var s1, s2: string): boolean; forward;
          {checks whether << is the primary TOperation in s}

          function CheckShiftRight(const s: string; var s1, s2: string): boolean; forward;
          {checks whether >> is the primary TOperation in s}

          function CheckRealDivision(const s: string; var s1, s2: string): boolean;  forward;
          {checks whether / is the primary operation in s}



          function CheckFuncTwoVar(const s: string; var s1, s2: string): boolean; forward;
          {checks whether s=f(s1,s2); s1,s2 being valid terms}

          function CheckFuncOneVar(const s: string; var s1: string): boolean; forward;
          {checks whether s denotes the evaluation of a function fsort(s1)}


          function CheckPower(const s: string; var s1, s2: string; var AToken: TToken): boolean; forward;
          {checks whether ` is the primary operation in s}


          function CheckNumberBrackets(const s: string):boolean;
          {checks whether # of '(' equ. # of ')'}
          var
            counter,
            bracket : integer;
          begin
            bracket := 0;

            counter := length(s);
            while counter <> 0 do
            begin
              case s[counter] of
                '(': inc(bracket);
                ')': dec(bracket);
              end;
              dec(counter);
            end;

            Result := bracket = 0;
          end;


          function CheckNumber(const s: string; var FloatNumber: ParserFloat):boolean;
          {checks whether s is a number}
          var
            code: integer;
            tmpInt : Cardinal; // handle large hexadecimal strings (always a positive value)
          {$IFDEF Debug} { prevent debugger from showing conversion errors }
            SaveClass : TClass;
          {$ENDIF}
          begin
            if s = 'PI' then
            begin
              FloatNumber := Pi;
              Result := true;
            end
            else
            if s = '-PI' then
            begin
              FloatNumber := -Pi;
              Result := true;
            end
            else
            begin
              if UsePascalNumbers then
              begin
                code := 0;
                val(s, FloatNumber, code);
                Result := code = 0;
                // if this failed try an integer variable (handles hex notation)
                if not Result then
                begin
                  val(s, tmpInt, code);
                  Result := code = 0;
                  if Result then
                    FloatNumber := tmpInt;
                end;
              end
              else
              begin
                {$IFDEF Debug}
                  SaveClass := ExceptionClass;
                  ExceptionClass := nil;
                  try
                {$ENDIF}
                  try
                    FloatNumber := StrToFloatDef(s, 0);
                    if (FloatNumber = 0) and (s <> '0') then
                    begin
                      // if this failed try an integer variable (handles hex notation)
                      if Pos('0x', s) = 1 then
                      begin
                        val(s, tmpInt, code);
                        Result := code = 0;
                        if Result then
                          FloatNumber := tmpInt;
                      end
                      else
                      begin
                        FloatNumber := StrToFloat(s);
                        Result := true;
                      end;
                    end
                    else
                      Result := true;
                  except
                    on E: Exception do
                    begin
                      Result := false;
                    end;
                  end;
                {$IFDEF Debug}
                  finally
                    ExceptionClass := SaveClass;
                  end;
                {$ENDIF}
              end;
            end; 
          end;


          function CheckVariable(const s: string; var VariableID: integer): boolean;
          {checks whether s is a variable string}
          begin
            Result := Variables.Find(s, VariableID);
          end;


          function CheckTerm(var s1: string) :boolean;
          { checks whether s is a valid term }
          var
            s2, s3: TermString;
            FloatNumber: ParserFloat;
            fsort: TToken;
            VariableID: integer;
          begin
            Result := false;

            if length(s1) = 0 then
              exit;

            s2 := '';
            s3 := '';
            FloatNumber := 0;
            VariableID := 0;
            fsort := constant;
            if CheckNumber(s1, FloatNumber) or
               CheckVariable(s1, VariableID) or
               CheckNegate(s1, s2) or
               CheckBitNot(s1, s2) or
               CheckLogicalNot(s1, s2) or
               CheckLogicalOr(s1, s2, s3) or
               CheckLogicalAnd(s1, s2, s3) or
               CheckBitOr(s1, s2, s3) or
               CheckBitXor(s1, s2, s3) or
               CheckBitAnd(s1, s2, s3) or
               CheckEqualTo(s1, s2, s3) or
               CheckNotEqualTo(s1, s2, s3) or
               CheckLessThan(s1, s2, s3) or
               CheckLessOrEqual(s1, s2, s3) or
               CheckGreaterThan(s1, s2, s3) or
               CheckGreaterOrEqual(s1, s2, s3) or
               CheckShiftLeft(s1, s2, s3) or
               CheckShiftRight(s1, s2, s3) or
               CheckAdd(s1, s2, s3) or
               CheckSubtract(s1, s2, s3) or
               CheckMultiply(s1, s2, s3) or
               CheckIntegerDiv(s1, s2, s3) or
               CheckModulo(s1, s2, s3) or
               CheckRealDivision(s1, s2, s3) or
               CheckPower(s1, s2, s3, fsort) or
               CheckFuncTwoVar(s1, s2, s3) or
               CheckFuncOneVar(s1, s2)
            then
              Result := true
            else
              if CheckBracket(s1, s2) then
              begin
                s1 := s2;
                Result := true
              end;

          end;

          function CheckBracket(const s: string; var s1: string): boolean;
          {checks whether s =(...(s1)...) and s1 is a valid term}
          var
            SLen : integer;
          begin
            Result := false;

            SLen := Length(s);
            if (SLen > 0) and (s[SLen] = ')') and (s[1] = '(') then
            begin
              s1 := copy(s, 2, SLen-2);
              Result := CheckTerm(s1);
            end;
          end;


          function CheckNegate(const s: string; var s1: string) :boolean;
          {checks whether s denotes the negative value of a valid TOperation}
          var
            s2, s3: TermString;
            fsort: TToken;
            VariableID: integer;
          begin
            Result := false;

            if (length(s) <> 0) and (s[1] = '-') then
            begin
              s1 := copy(s, 2, length(s)-1);
              s2 := '';
              if CheckBracket(s1, s2) then
              begin
                s1 := s2;
                Result := true;
              end
              else
              begin
                VariableID := 0;
                fsort := constant;
                s3 := '';
                Result :=
                  CheckVariable(s1, VariableID) or
                  CheckPower(s1, s2, s3, fsort) or
                  CheckFuncOneVar(s1, s2) or
                  CheckFuncTwoVar(s1, s2, s3);
              end;
            end;
          end;

          function CheckBitNot(const s: string; var s1: string) :boolean;
          {checks whether '~' is the primary TOperation in s}
          var
            s2, s3: TermString;
            fsort: TToken;
            VariableID: integer;
            FloatNumber: ParserFloat;
          begin
            Result := false;

            if (length(s) <> 0) and (s[1] = '~') then
            begin
              s1 := copy(s, 2, length(s)-1);
              VariableID := 0;
              FloatNumber := 0;
              Result := CheckVariable(s1, VariableID) or CheckNumber(s1, FloatNumber);

              if not Result then
              begin
                s2 := '';
                Result := CheckBracket(s1, s2);
                if Result then
                  s1 := s2;
              end;

              if not Result then
              begin
                VariableID := 0;
                fsort := constant;
                s3 := '';
                Result :=
                  CheckNegate(s1, s3) or
                  CheckVariable(s1, VariableID) or
                  CheckPower(s1, s2, s3, fsort) or
                  CheckFuncOneVar(s1, s2) or
                  CheckFuncTwoVar(s1, s2, s3);
              end;
            end;
          end;

          function CheckLogicalNot(const s: string; var s1: string) :boolean;
          {checks whether '!' is the primary TOperation in s}
          var
            s2, s3: TermString;
            fsort: TToken;
            VariableID: integer;
            FloatNumber: ParserFloat;
          begin
            Result := false;

            if (length(s) <> 0) and (s[1] = '!') then
            begin
              s1 := copy(s, 2, length(s)-1);
              VariableID := 0;
              FloatNumber := 0;
              Result := CheckVariable(s1, VariableID) or
                        CheckNumber(s1, FloatNumber);

              if not Result then
              begin
                s2 := '';
                Result := CheckBracket(s1, s2);
                if Result then
                  s1 := s2;
              end;

              if not Result then
              begin
                VariableID := 0;
                fsort := constant;
                s3 := '';
                Result :=
                  CheckNegate(s1, s3) or
                  CheckBitNot(s1, s3) or
                  CheckVariable(s1, VariableID) or
                  CheckPower(s1, s2, s3, fsort) or
                  CheckFuncOneVar(s1, s2) or
                  CheckFuncTwoVar(s1, s2, s3);
              end;
            end;
          end;

          function CheckAdd(const s: string; var s1, s2: string): boolean;
          {checks whether '+' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
            VariableID: integer;
          begin
            Result := false;

            i := 0;
            j := length(s);
            repeat

              while i <> j do
              begin
                inc(i);
                if s[i] = '+' then
                  break;
              end;

              if (i > 1) and (i < j) then
              begin
                s1 := copy(s, 1, i-1);
                s2 := copy(s, i+1, j-i);

                Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                if Result then
                begin
                  VariableID := 0;
                  FloatNumber := 0;
                  Result := CheckVariable(s1, VariableID) or CheckNumber(s1, FloatNumber);

                  if not Result then
                  begin
                    s3 := '';
                    Result := CheckBracket(s1, s3);
                    if Result then
                      s1 := s3;
                  end;

                  if not Result then
                  begin
                    s4 := '';
                    fsort := constant;
                    Result := CheckNegate(s1, s3) or
                              CheckBitNot(s1, s3) or
                              CheckLogicalNot(s1, s3) or
                              CheckSubtract(s1, s3, s4) or
                              CheckMultiply(s1, s3, s4) or
                              CheckIntegerDiv(s1, s3, s4) or
                              CheckModulo(s1, s3, s4) or
                              CheckRealDivision(s1, s3, s4) or
                              CheckPower(s1, s3, s4, fsort) or
                              CheckFuncOneVar(s1, s3) or
                              CheckFuncTwoVar(s1, s3, s4);
                  end;
                  if Result then
                  begin
                    Result := CheckVariable(s2, VariableID) or CheckNumber(s2, FloatNumber);

                    if not Result then
                    begin
                      Result := CheckBracket(s2, s3);
                      if Result then
                        s2 := s3
                      else
                        Result := CheckNegate(s2, s3) or
                                  CheckBitNot(s2, s3) or
                                  CheckLogicalNot(s2, s3) or
                                  CheckAdd(s2, s3, s4) or
                                  CheckSubtract(s2, s3, s4) or
                                  CheckMultiply(s2, s3, s4) or
                                  CheckIntegerDiv(s2, s3, s4) or
                                  CheckModulo(s2, s3, s4) or
                                  CheckRealDivision(s2, s3, s4) or
                                  CheckPower(s2, s3, s4, fsort) or
                                  CheckFuncOneVar(s2, s3) or
                                  CheckFuncTwoVar(s2, s3, s4);
                    end;
                  end;
                end;
              end
              else
                break;
            until Result;
          end;

          function CheckSubtract(const s: string; var s1, s2: string): boolean;
          {checks whether '-' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
            VariableID: integer;
          begin
            Result := false;

            i := 0;
            j := length(s);

            repeat

              while i <> j do
              begin
                inc(i);
                if s[i] = '-' then
                  break;
              end;

              if (i > 1) and (i < j) then
              begin
                s1 := copy(s, 1, i-1);
                s2 := copy(s, i+1, j-i);

                Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                if Result then
                begin
                  VariableID := 0;
                  FloatNumber := 0;
                  Result := CheckVariable(s1, VariableID) or CheckNumber(s1, FloatNumber);

                  if not Result then
                  begin
                    s3 := '';
                    Result := CheckBracket(s1, s3);
                    if Result then
                      s1 := s3;
                  end;
                  if not Result then
                  begin
                    s4 := '';
                    fsort := constant;
                    Result := CheckNegate(s1, s3) or
                              CheckBitNot(s1, s3) or
                              CheckLogicalNot(s1, s3) or
                              CheckSubtract(s1, s3, s4) or
                              CheckMultiply(s1, s3, s4) or
                              CheckIntegerDiv(s1, s3, s4) or
                              CheckModulo(s1, s3, s4) or
                              CheckRealDivision(s1, s3, s4) or
                              CheckPower(s1, s3, s4, fsort) or
                              CheckFuncOneVar(s1, s3) or
                              CheckFuncTwoVar(s1, s3, s4);
                  end;
                  if Result then
                  begin
                    Result := CheckVariable(s2, VariableID) or CheckNumber(s2, FloatNumber);

                    if not Result then
                    begin
                       Result := CheckBracket(s2, s3);
                       if Result then
                         s2 := s3
                       else
                         Result := CheckNegate(s2, s3) or
                                   CheckBitNot(s2, s3) or
                                   CheckLogicalNot(s2, s3) or
                                   CheckMultiply(s2, s3, s4) or
                                   CheckIntegerDiv(s2, s3, s4) or
                                   CheckModulo(s2, s3, s4) or
                                   CheckRealDivision(s2, s3, s4) or
                                   CheckPower(s2, s3, s4, fsort) or
                                   CheckFuncOneVar(s2, s3) or
                                   CheckFuncTwoVar(s2, s3, s4);
                    end;
                  end;
                end;
              end
              else
                break;
            until Result;
          end;

          function CheckMultiply(const s: string; var s1, s2: string): boolean;
          {checks whether '*' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
            VariableID: integer;
          begin
            Result := false;

            i := 0;
            j := length(s);

            repeat
              while i <> j do
              begin
                inc(i);
                if s[i] = '*' then
                  break;
              end;

              if (i > 1) and (i < j) then
              begin
                s1 := copy(s, 1, i-1);
                s2 := copy(s, i+1, j-i);

                Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                if Result then
                begin
                  VariableID := 0;
                  FloatNumber := 0;
                  Result := CheckVariable(s1, VariableID) or
                            CheckNumber(s1, FloatNumber);

                  if not Result then
                  begin
                    s3 := '';
                    Result := CheckBracket(s1, s3);
                    if Result then
                      s1 := s3;
                  end;

                  if not Result then
                  begin
                    s4 := '';
                    fsort := constant;
                    Result := CheckNegate(s1, s3) or
                              CheckBitNot(s1, s3) or
                              CheckLogicalNot(s1, s3) or
                              CheckIntegerDiv(s1, s3, s4) or
                              CheckModulo(s1, s3, s4) or
                              CheckRealDivision(s1, s3, s4) or
                              CheckPower(s1, s3, s4, fsort) or
                              CheckFuncOneVar(s1, s3) or
                              CheckFuncTwoVar(s1, s3, s4);
                  end;
                  if Result then
                  begin
                    Result := CheckVariable(s2, VariableID) or
                              CheckNumber(s2, FloatNumber);

                    if not Result then
                    begin
                      Result := CheckBracket(s2, s3);
                      if Result then
                        s2 := s3
                      else
                        Result := CheckNegate(s2, s3) or
                                  CheckBitNot(s2, s3) or
                                  CheckLogicalNot(s2, s3) or
                                  CheckMultiply(s2, s3, s4) or
                                  CheckIntegerDiv(s2, s3, s4) or
                                  CheckModulo(s2, s3, s4) or
                                  CheckRealDivision(s2, s3, s4) or
                                  CheckPower(s2, s3, s4, fsort) or
                                  CheckFuncOneVar(s2, s3) or
                                  CheckFuncTwoVar(s2, s3, s4);
                    end;
                  end;
                end;
              end
              else
                break;
            until Result;
          end;

          function CheckIntegerDiv(const s: string; var s1, s2: string): boolean;
          {checks whether 'div' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          begin
            Result := false;

            i := 0;

            repeat

              j := pos('div', copy(s, i+1, length(s)-i));
              if j > 0 then
              begin

                inc(i, j);
                if (i > 1) and (i < length(s)) then
                begin
                  s1 := copy(s, 1, i-1);
                  s2 := copy(s, i+3, length(s)-i-2);

                  Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                  if Result then
                  begin
                    VariableID := 0;
                    FloatNumber := 0;
                    Result := CheckVariable(s1, VariableID) or
                              CheckNumber(s1, FloatNumber);

                    if not Result then
                    begin
                      s3 := '';
                      Result := CheckBracket(s1, s3);
                      if Result then
                        s1 := s3;
                    end;

                    if not Result then
                    begin
                      s4 := '';
                      fsort := constant;
                      Result := CheckNegate(s1, s3) or
                                CheckBitNot(s1, s3) or
                                CheckLogicalNot(s1, s3) or
                                CheckModulo(s1, s3, s4) or
                                CheckRealDivision(s1, s3, s4) or
                                CheckPower(s1, s3, s4, fsort) or
                                CheckFuncOneVar(s1, s3) or
                                CheckFuncTwoVar(s1, s3, s4);
                     end;
                    if Result then
                    begin
                      Result := CheckVariable(s2,VariableID) or
                                CheckNumber(s2,FloatNumber);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3
                        else
                          Result := CheckNegate(s2, s3) or
                                    CheckBitNot(s2, s3) or
                                    CheckLogicalNot(s2, s3) or
                                    CheckIntegerDiv(s2, s3, s4) or
                                    CheckModulo(s2, s3, s4) or
//                                    CheckRealDivision(s2, s3, s4) or
                                    CheckPower(s2, s3, s4, fsort) or
                                    CheckFuncOneVar(s2, s3) or
                                    CheckFuncTwoVar(s2, s3, s4);
                      end;
                    end;
                  end;
                end;
              end;
            until Result or (j = 0) or (i >= length(s));
          end;

          function CheckModulo(const s: string; var s1, s2: string): boolean;
          {checks whether 'MOD' ('%') is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          const
//            ModName = 'mod';
//            ModLen  = 3;
            ModName = '%';
            ModLen  = 1;
          begin
            Result := false;

            i := 0;
            repeat
              j := pos(ModName, copy(s, i+1, length(s)-i));
              if j > 0 then
              begin

                inc(i, j);
                if (i > 1) and (i < length(s)) then
                begin
                  s1 := copy(s, 1, i-1);
                  s2 := copy(s, i+ModLen, length(s)-i-(ModLen-1));

                  Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                  if Result then
                  begin
                    VariableID := 0;
                    FloatNumber := 0;
                    Result := CheckVariable(s1, VariableID) or
                              CheckNumber(s1, FloatNumber);

                    if not Result then
                    begin
                      s3 := '';
                      Result := CheckBracket(s1, s3);
                      if Result then
                        s1 := s3;
                    end;
                    if not Result then
                    begin
                      s4 := '';
                      fsort := constant;
                      Result := CheckNegate(s1, s3) or
                                CheckBitNot(s1, s3) or
                                CheckLogicalNot(s1, s3) or
//                                CheckIntegerDiv(s1, s3, s4) or
//                                CheckModulo(s1, s3, s4) or
                                CheckRealDivision(s1, s3, s4) or
                                CheckPower(s1, s3, s4, fsort) or
                                CheckFuncOneVar(s1, s3) or
                                CheckFuncTwoVar(s1, s3, s4);
                    end;
                    if Result then
                    begin
                      Result := CheckVariable(s2, VariableID) or
                                CheckNumber(s2, FloatNumber);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3
                        else
                          Result := CheckNegate(s2, s3) or
                                    CheckBitNot(s2, s3) or
                                    CheckLogicalNot(s2, s3) or
                                    CheckModulo(s2, s3, s4) or
//                                    CheckRealDivision(s2, s3, s4) or
                                    CheckPower(s2, s3, s4, fsort) or
                                    CheckFuncOneVar(s2, s3) or
                                    CheckFuncTwoVar(s2, s3, s4);

                      end
                    end;
                  end;
                end;
              end;
            until Result or (j = 0) or (i >= length(s));
          end;

          function CheckLogicalOr(const s: string; var s1, s2: string): boolean;
          {checks whether '||' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          begin
            Result := false;

            i := 0;
            repeat
              j := pos('||', copy(s, i+1, length(s)-i));
              if j > 0 then
              begin

                inc(i, j);
                if (i > 1) and (i < length(s)) then
                begin
                  s1 := copy(s, 1, i-1);
                  s2 := copy(s, i+2, length(s)-i-1);

                  Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                  if Result then
                  begin
                    VariableID := 0;
                    FloatNumber := 0;
                    Result := CheckVariable(s1, VariableID) or
                              CheckNumber(s1, FloatNumber);

                    if not Result then
                    begin
                      s3 := '';
                      Result := CheckBracket(s1, s3);
                      if Result then
                        s1 := s3;
                    end;
                    if not Result then
                    begin
                      s4 := '';
                      fsort := constant;
                      Result := CheckNegate(s1, s3) or
                                CheckBitNot(s1, s3) or
                                CheckLogicalNot(s1, s3) or
                                CheckLogicalAnd(s1, s3, s4) or
                                CheckBitOr(s1, s3, s4) or
                                CheckBitXor(s1, s3, s4) or
                                CheckBitAnd(s1, s3, s4) or
                                CheckEqualTo(s1, s3, s4) or
                                CheckNotEqualTo(s1, s3, s4) or
                                CheckLessThan(s1, s3, s4) or
                                CheckLessOrEqual(s1, s3, s4) or
                                CheckGreaterThan(s1, s3, s4) or
                                CheckGreaterOrEqual(s1, s3, s4) or
                                CheckShiftLeft(s1, s3, s4) or
                                CheckShiftRight(s1, s3, s4) or
                                CheckAdd(s1, s3, s4) or
                                CheckSubtract(s1, s3, s4) or
                                CheckMultiply(s1, s3, s4) or
                                CheckIntegerDiv(s1, s3, s4) or
                                CheckModulo(s1, s3, s4) or
                                CheckRealDivision(s1, s3, s4) or
                                CheckPower(s1, s3, s4, fsort) or
                                CheckFuncOneVar(s1, s3) or
                                CheckFuncTwoVar(s1, s3, s4);
                    end;
                    if Result then
                    begin
                      Result := CheckVariable(s2, VariableID) or
                                CheckNumber(s2, FloatNumber);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3
                        else
                          Result := CheckNegate(s2, s3) or
                                    CheckBitNot(s2, s3) or
                                    CheckLogicalNot(s2, s3) or
                                    CheckLogicalOr(s2, s3, s4) or
                                    CheckLogicalAnd(s2, s3, s4) or
                                    CheckBitOr(s2, s3, s4) or
                                    CheckBitXor(s2, s3, s4) or
                                    CheckBitAnd(s2, s3, s4) or
                                    CheckEqualTo(s2, s3, s4) or
                                    CheckNotEqualTo(s2, s3, s4) or
                                    CheckLessThan(s2, s3, s4) or
                                    CheckLessOrEqual(s2, s3, s4) or
                                    CheckGreaterThan(s2, s3, s4) or
                                    CheckGreaterOrEqual(s2, s3, s4) or
                                    CheckShiftLeft(s2, s3, s4) or
                                    CheckShiftRight(s2, s3, s4) or
                                    CheckAdd(s2, s3, s4) or
                                    CheckSubtract(s2, s3, s4) or
                                    CheckMultiply(s2, s3, s4) or
                                    CheckIntegerDiv(s2, s3, s4) or
                                    CheckModulo(s2, s3, s4) or
                                    CheckRealDivision(s2, s3, s4) or
                                    CheckPower(s2, s3, s4, fsort) or
                                    CheckFuncOneVar(s2, s3) or
                                    CheckFuncTwoVar(s2, s3, s4);
                      end
                    end;
                  end;
                end;
              end;
            until Result or (j = 0) or (i >= length(s));
          end;

          function CheckLogicalAnd(const s: string; var s1, s2: string): boolean;
          {checks whether '&&' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          begin
            Result := false;

            i := 0;
            repeat
              j := pos('&&', copy(s, i+1, length(s)-i));
              if j > 0 then
              begin

                inc(i, j);
                if (i > 1) and (i < length(s)) then
                begin
                  s1 := copy(s, 1, i-1);
                  s2 := copy(s, i+2, length(s)-i-1);

                  Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                  if Result then
                  begin
                    VariableID := 0;
                    FloatNumber := 0;
                    Result := CheckVariable(s1, VariableID) or
                              CheckNumber(s1, FloatNumber);

                    if not Result then
                    begin
                      s3 := '';
                      Result := CheckBracket(s1, s3);
                      if Result then
                        s1 := s3;
                    end;
                    if not Result then
                    begin
                      s4 := '';
                      fsort := constant;
                      Result := CheckNegate(s1, s3) or
                                CheckBitNot(s1, s3) or
                                CheckLogicalNot(s1, s3) or
                                CheckBitOr(s1, s3, s4) or
                                CheckBitXor(s1, s3, s4) or
                                CheckBitAnd(s1, s3, s4) or
                                CheckEqualTo(s1, s3, s4) or
                                CheckNotEqualTo(s1, s3, s4) or
                                CheckLessThan(s1, s3, s4) or
                                CheckLessOrEqual(s1, s3, s4) or
                                CheckGreaterThan(s1, s3, s4) or
                                CheckGreaterOrEqual(s1, s3, s4) or
                                CheckShiftLeft(s1, s3, s4) or
                                CheckShiftRight(s1, s3, s4) or
                                CheckAdd(s1, s3, s4) or
                                CheckSubtract(s1, s3, s4) or
                                CheckMultiply(s1, s3, s4) or
                                CheckIntegerDiv(s1, s3, s4) or
                                CheckModulo(s1, s3, s4) or
                                CheckRealDivision(s1, s3, s4) or
                                CheckPower(s1, s3, s4, fsort) or
                                CheckFuncOneVar(s1, s3) or
                                CheckFuncTwoVar(s1, s3, s4);
                    end;
                    if Result then
                    begin
                      Result := CheckVariable(s2, VariableID) or
                                CheckNumber(s2, FloatNumber);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3
                        else
                          Result := CheckNegate(s2, s3) or
                                    CheckBitNot(s2, s3) or
                                    CheckLogicalNot(s2, s3) or
                                    CheckLogicalAnd(s2, s3, s4) or
                                    CheckBitOr(s2, s3, s4) or
                                    CheckBitXor(s2, s3, s4) or
                                    CheckBitAnd(s2, s3, s4) or
                                    CheckEqualTo(s2, s3, s4) or
                                    CheckNotEqualTo(s2, s3, s4) or
                                    CheckLessThan(s2, s3, s4) or
                                    CheckLessOrEqual(s2, s3, s4) or
                                    CheckGreaterThan(s2, s3, s4) or
                                    CheckGreaterOrEqual(s2, s3, s4) or
                                    CheckShiftLeft(s2, s3, s4) or
                                    CheckShiftRight(s2, s3, s4) or
                                    CheckAdd(s2, s3, s4) or
                                    CheckSubtract(s2, s3, s4) or
                                    CheckMultiply(s2, s3, s4) or
                                    CheckIntegerDiv(s2, s3, s4) or
                                    CheckModulo(s2, s3, s4) or
                                    CheckRealDivision(s2, s3, s4) or
                                    CheckPower(s2, s3, s4, fsort) or
                                    CheckFuncOneVar(s2, s3) or
                                    CheckFuncTwoVar(s2, s3, s4);
                      end
                    end;
                  end;
                end;
              end;
            until Result or (j = 0) or (i >= length(s));
          end;

          function CheckBitAnd(const s: string; var s1, s2: string): boolean;
          {checks whether '&' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
            VariableID: integer;
          begin
            Result := false;

            i := 0;
            j := length(s);
            repeat

              while i <> j do
              begin
                inc(i);
                if s[i] = '&' then
                  break;
              end;

              if (i > 1) and (i < j) then
              begin
                s1 := copy(s, 1, i-1);
                s2 := copy(s, i+1, j-i);

                Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                if Result then
                begin
                  VariableID := 0;
                  FloatNumber := 0;
                  Result := CheckVariable(s1, VariableID) or CheckNumber(s1, FloatNumber);

                  if not Result then
                  begin
                    s3 := '';
                    Result := CheckBracket(s1, s3);
                    if Result then
                      s1 := s3;
                  end;

                  if not Result then
                  begin
                    s4 := '';
                    fsort := constant;
                    Result := CheckNegate(s1, s3) or
                              CheckBitNot(s1, s3) or
                              CheckLogicalNot(s1, s3) or
                              CheckEqualTo(s1, s3, s4) or
                              CheckNotEqualTo(s1, s3, s4) or
                              CheckLessThan(s1, s3, s4) or
                              CheckLessOrEqual(s1, s3, s4) or
                              CheckGreaterThan(s1, s3, s4) or
                              CheckGreaterOrEqual(s1, s3, s4) or
                              CheckShiftLeft(s1, s3, s4) or
                              CheckShiftRight(s1, s3, s4) or
                              CheckAdd(s1, s3, s4) or
                              CheckSubtract(s1, s3, s4) or
                              CheckMultiply(s1, s3, s4) or
                              CheckIntegerDiv(s1, s3, s4) or
                              CheckModulo(s1, s3, s4) or
                              CheckRealDivision(s1, s3, s4) or
                              CheckPower(s1, s3, s4, fsort) or
                              CheckFuncOneVar(s1, s3) or
                              CheckFuncTwoVar(s1, s3, s4);
                  end;
                  if Result then
                  begin
                    Result := CheckVariable(s2, VariableID) or CheckNumber(s2, FloatNumber);

                    if not Result then
                    begin
                      Result := CheckBracket(s2, s3);
                      if Result then
                        s2 := s3
                      else
                        Result := CheckNegate(s2, s3) or
                                  CheckBitNot(s2, s3) or
                                  CheckLogicalNot(s2, s3) or
                                  CheckBitAnd(s2, s3, s4) or
                                  CheckEqualTo(s2, s3, s4) or
                                  CheckNotEqualTo(s2, s3, s4) or
                                  CheckLessThan(s2, s3, s4) or
                                  CheckLessOrEqual(s2, s3, s4) or
                                  CheckGreaterThan(s2, s3, s4) or
                                  CheckGreaterOrEqual(s2, s3, s4) or
                                  CheckShiftLeft(s2, s3, s4) or
                                  CheckShiftRight(s2, s3, s4) or
                                  CheckAdd(s2, s3, s4) or
                                  CheckSubtract(s2, s3, s4) or
                                  CheckMultiply(s2, s3, s4) or
                                  CheckIntegerDiv(s2, s3, s4) or
                                  CheckModulo(s2, s3, s4) or
                                  CheckRealDivision(s2, s3, s4) or
                                  CheckPower(s2, s3, s4, fsort) or
                                  CheckFuncOneVar(s2, s3) or
                                  CheckFuncTwoVar(s2, s3, s4);
                    end;
                  end;
                end;
              end
              else
                break;
            until Result;
          end;

          function CheckBitOr(const s: string; var s1, s2: string): boolean;
          {checks whether '|' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
            VariableID: integer;
          begin
            Result := false;

            i := 0;
            j := length(s);
            repeat

              while i <> j do
              begin
                inc(i);
                if s[i] = '|' then
                  break;
              end;

              if (i > 1) and (i < j) then
              begin
                s1 := copy(s, 1, i-1);
                s2 := copy(s, i+1, j-i);

                Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                if Result then
                begin
                  VariableID := 0;
                  FloatNumber := 0;
                  Result := CheckVariable(s1, VariableID) or CheckNumber(s1, FloatNumber);

                  if not Result then
                  begin
                    s3 := '';
                    Result := CheckBracket(s1, s3);
                    if Result then
                      s1 := s3;
                  end;

                  if not Result then
                  begin
                    s4 := '';
                    fsort := constant;
                    Result := CheckNegate(s1, s3) or
                              CheckBitNot(s1, s3) or
                              CheckLogicalNot(s1, s3) or
                              CheckBitXor(s1, s3, s4) or
                              CheckBitAnd(s1, s3, s4) or
                              CheckEqualTo(s1, s3, s4) or
                              CheckNotEqualTo(s1, s3, s4) or
                              CheckLessThan(s1, s3, s4) or
                              CheckLessOrEqual(s1, s3, s4) or
                              CheckGreaterThan(s1, s3, s4) or
                              CheckGreaterOrEqual(s1, s3, s4) or
                              CheckShiftLeft(s1, s3, s4) or
                              CheckShiftRight(s1, s3, s4) or
                              CheckAdd(s1, s3, s4) or
                              CheckSubtract(s1, s3, s4) or
                              CheckMultiply(s1, s3, s4) or
                              CheckIntegerDiv(s1, s3, s4) or
                              CheckModulo(s1, s3, s4) or
                              CheckRealDivision(s1, s3, s4) or
                              CheckPower(s1, s3, s4, fsort) or
                              CheckFuncOneVar(s1, s3) or
                              CheckFuncTwoVar(s1, s3, s4);
                  end;
                  if Result then
                  begin
                    Result := CheckVariable(s2, VariableID) or CheckNumber(s2, FloatNumber);

                    if not Result then
                    begin
                      Result := CheckBracket(s2, s3);
                      if Result then
                        s2 := s3
                      else
                        Result := CheckNegate(s2, s3) or
                                  CheckBitNot(s2, s3) or
                                  CheckLogicalNot(s2, s3) or
                                  CheckBitOr(s2, s3, s4) or
                                  CheckBitXor(s2, s3, s4) or
                                  CheckBitAnd(s2, s3, s4) or
                                  CheckEqualTo(s2, s3, s4) or
                                  CheckNotEqualTo(s2, s3, s4) or
                                  CheckLessThan(s2, s3, s4) or
                                  CheckLessOrEqual(s2, s3, s4) or
                                  CheckGreaterThan(s2, s3, s4) or
                                  CheckGreaterOrEqual(s2, s3, s4) or
                                  CheckShiftLeft(s2, s3, s4) or
                                  CheckShiftRight(s2, s3, s4) or
                                  CheckAdd(s2, s3, s4) or
                                  CheckSubtract(s2, s3, s4) or
                                  CheckMultiply(s2, s3, s4) or
                                  CheckIntegerDiv(s2, s3, s4) or
                                  CheckModulo(s2, s3, s4) or
                                  CheckRealDivision(s2, s3, s4) or
                                  CheckPower(s2, s3, s4, fsort) or
                                  CheckFuncOneVar(s2, s3) or
                                  CheckFuncTwoVar(s2, s3, s4);
                    end;
                  end;
                end;
              end
              else
                break;
            until Result;
          end;

          function CheckBitXor(const s: string; var s1, s2: string): boolean;
          {checks whether '^' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
            VariableID: integer;
          begin
            Result := false;

            i := 0;
            j := length(s);
            repeat

              while i <> j do
              begin
                inc(i);
                if s[i] = '^' then
                  break;
              end;

              if (i > 1) and (i < j) then
              begin
                s1 := copy(s, 1, i-1);
                s2 := copy(s, i+1, j-i);

                Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                if Result then
                begin
                  VariableID := 0;
                  FloatNumber := 0;
                  Result := CheckVariable(s1, VariableID) or CheckNumber(s1, FloatNumber);

                  if not Result then
                  begin
                    s3 := '';
                    Result := CheckBracket(s1, s3);
                    if Result then
                      s1 := s3;
                  end;

                  if not Result then
                  begin
                    s4 := '';
                    fsort := constant;
                    Result := CheckNegate(s1, s3) or
                              CheckBitNot(s1, s3) or
                              CheckLogicalNot(s1, s3) or
                              CheckBitAnd(s1, s3, s4) or
                              CheckEqualTo(s1, s3, s4) or
                              CheckNotEqualTo(s1, s3, s4) or
                              CheckLessThan(s1, s3, s4) or
                              CheckLessOrEqual(s1, s3, s4) or
                              CheckGreaterThan(s1, s3, s4) or
                              CheckGreaterOrEqual(s1, s3, s4) or
                              CheckShiftLeft(s1, s3, s4) or
                              CheckShiftRight(s1, s3, s4) or
                              CheckAdd(s1, s3, s4) or
                              CheckSubtract(s1, s3, s4) or
                              CheckMultiply(s1, s3, s4) or
                              CheckIntegerDiv(s1, s3, s4) or
                              CheckModulo(s1, s3, s4) or
                              CheckRealDivision(s1, s3, s4) or
                              CheckPower(s1, s3, s4, fsort) or
                              CheckFuncOneVar(s1, s3) or
                              CheckFuncTwoVar(s1, s3, s4);
                  end;
                  if Result then
                  begin
                    Result := CheckVariable(s2, VariableID) or CheckNumber(s2, FloatNumber);

                    if not Result then
                    begin
                      Result := CheckBracket(s2, s3);
                      if Result then
                        s2 := s3
                      else
                        Result := CheckNegate(s2, s3) or
                                  CheckBitNot(s2, s3) or
                                  CheckLogicalNot(s2, s3) or
                                  CheckBitXor(s2, s3, s4) or
                                  CheckBitAnd(s2, s3, s4) or
                                  CheckEqualTo(s2, s3, s4) or
                                  CheckNotEqualTo(s2, s3, s4) or
                                  CheckLessThan(s2, s3, s4) or
                                  CheckLessOrEqual(s2, s3, s4) or
                                  CheckGreaterThan(s2, s3, s4) or
                                  CheckGreaterOrEqual(s2, s3, s4) or
                                  CheckShiftLeft(s2, s3, s4) or
                                  CheckShiftRight(s2, s3, s4) or
                                  CheckAdd(s2, s3, s4) or
                                  CheckSubtract(s2, s3, s4) or
                                  CheckMultiply(s2, s3, s4) or
                                  CheckIntegerDiv(s2, s3, s4) or
                                  CheckModulo(s2, s3, s4) or
                                  CheckRealDivision(s2, s3, s4) or
                                  CheckPower(s2, s3, s4, fsort) or
                                  CheckFuncOneVar(s2, s3) or
                                  CheckFuncTwoVar(s2, s3, s4);
                    end;
                  end;
                end;
              end
              else
                break;
            until Result;
          end;

          function CheckEqualTo(const s: string; var s1, s2: string): boolean;
          {checks whether '==' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          begin
            Result := false;

            i := 0;
            repeat
              j := pos('==', copy(s, i+1, length(s)-i));
              if j > 0 then
              begin

                inc(i, j);
                if (i > 1) and (i < length(s)) then
                begin
                  s1 := copy(s, 1, i-1);
                  s2 := copy(s, i+2, length(s)-i-1);

                  Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                  if Result then
                  begin
                    VariableID := 0;
                    FloatNumber := 0;
                    Result := CheckVariable(s1, VariableID) or
                              CheckNumber(s1, FloatNumber);

                    if not Result then
                    begin
                      s3 := '';
                      Result := CheckBracket(s1, s3);
                      if Result then
                        s1 := s3;
                    end;
                    if not Result then
                    begin
                      s4 := '';
                      fsort := constant;
                      Result := CheckNegate(s1, s3) or
                                CheckBitNot(s1, s3) or
                                CheckLogicalNot(s1, s3) or
                                CheckNotEqualTo(s1, s3, s4) or
                                CheckLessThan(s1, s3, s4) or
                                CheckLessOrEqual(s1, s3, s4) or
                                CheckGreaterThan(s1, s3, s4) or
                                CheckGreaterOrEqual(s1, s3, s4) or
                                CheckShiftLeft(s1, s3, s4) or
                                CheckShiftRight(s1, s3, s4) or
                                CheckAdd(s1, s3, s4) or
                                CheckSubtract(s1, s3, s4) or
                                CheckMultiply(s1, s3, s4) or
                                CheckIntegerDiv(s1, s3, s4) or
                                CheckModulo(s1, s3, s4) or
                                CheckRealDivision(s1, s3, s4) or
                                CheckPower(s1, s3, s4, fsort) or
                                CheckFuncOneVar(s1, s3) or
                                CheckFuncTwoVar(s1, s3, s4);
                    end;
                    if Result then
                    begin
                      Result := CheckVariable(s2, VariableID) or
                                CheckNumber(s2, FloatNumber);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3
                        else
                          Result := CheckNegate(s2, s3) or
                                    CheckBitNot(s2, s3) or
                                    CheckLogicalNot(s2, s3) or
                                    CheckEqualTo(s2, s3, s4) or
                                    CheckNotEqualTo(s2, s3, s4) or
                                    CheckLessThan(s2, s3, s4) or
                                    CheckLessOrEqual(s2, s3, s4) or
                                    CheckGreaterThan(s2, s3, s4) or
                                    CheckGreaterOrEqual(s2, s3, s4) or
                                    CheckShiftLeft(s2, s3, s4) or
                                    CheckShiftRight(s2, s3, s4) or
                                    CheckAdd(s2, s3, s4) or
                                    CheckSubtract(s2, s3, s4) or
                                    CheckMultiply(s2, s3, s4) or
                                    CheckIntegerDiv(s2, s3, s4) or
                                    CheckModulo(s2, s3, s4) or
                                    CheckRealDivision(s2, s3, s4) or
                                    CheckPower(s2, s3, s4, fsort) or
                                    CheckFuncOneVar(s2, s3) or
                                    CheckFuncTwoVar(s2, s3, s4);
                      end
                    end;
                  end;
                end;
              end;
            until Result or (j = 0) or (i >= length(s));
          end;

          function CheckNotEqualTo(const s: string; var s1, s2: string): boolean;
          {checks whether '!=' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          begin
            Result := false;

            i := 0;
            repeat
              j := pos('!=', copy(s, i+1, length(s)-i));
              if j > 0 then
              begin

                inc(i, j);
                if (i > 1) and (i < length(s)) then
                begin
                  s1 := copy(s, 1, i-1);
                  s2 := copy(s, i+2, length(s)-i-1);

                  Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                  if Result then
                  begin
                    VariableID := 0;
                    FloatNumber := 0;
                    Result := CheckVariable(s1, VariableID) or
                              CheckNumber(s1, FloatNumber);

                    if not Result then
                    begin
                      s3 := '';
                      Result := CheckBracket(s1, s3);
                      if Result then
                        s1 := s3;
                    end;
                    if not Result then
                    begin
                      s4 := '';
                      fsort := constant;
                      Result := CheckNegate(s1, s3) or
                                CheckBitNot(s1, s3) or
                                CheckLogicalNot(s1, s3) or
                                CheckLessThan(s1, s3, s4) or
                                CheckLessOrEqual(s1, s3, s4) or
                                CheckGreaterThan(s1, s3, s4) or
                                CheckGreaterOrEqual(s1, s3, s4) or
                                CheckShiftLeft(s1, s3, s4) or
                                CheckShiftRight(s1, s3, s4) or
                                CheckAdd(s1, s3, s4) or
                                CheckSubtract(s1, s3, s4) or
                                CheckMultiply(s1, s3, s4) or
                                CheckIntegerDiv(s1, s3, s4) or
                                CheckModulo(s1, s3, s4) or
                                CheckRealDivision(s1, s3, s4) or
                                CheckPower(s1, s3, s4, fsort) or
                                CheckFuncOneVar(s1, s3) or
                                CheckFuncTwoVar(s1, s3, s4);
                    end;
                    if Result then
                    begin
                      Result := CheckVariable(s2, VariableID) or
                                CheckNumber(s2, FloatNumber);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3
                        else
                          Result := CheckNegate(s2, s3) or
                                    CheckBitNot(s2, s3) or
                                    CheckLogicalNot(s2, s3) or
                                    CheckNotEqualTo(s2, s3, s4) or
                                    CheckLessThan(s2, s3, s4) or
                                    CheckLessOrEqual(s2, s3, s4) or
                                    CheckGreaterThan(s2, s3, s4) or
                                    CheckGreaterOrEqual(s2, s3, s4) or
                                    CheckShiftLeft(s2, s3, s4) or
                                    CheckShiftRight(s2, s3, s4) or
                                    CheckAdd(s2, s3, s4) or
                                    CheckSubtract(s2, s3, s4) or
                                    CheckMultiply(s2, s3, s4) or
                                    CheckIntegerDiv(s2, s3, s4) or
                                    CheckModulo(s2, s3, s4) or
                                    CheckRealDivision(s2, s3, s4) or
                                    CheckPower(s2, s3, s4, fsort) or
                                    CheckFuncOneVar(s2, s3) or
                                    CheckFuncTwoVar(s2, s3, s4);
                      end
                    end;
                  end;
                end;
              end;
            until Result or (j = 0) or (i >= length(s));
          end;

          function CheckLessThan(const s: string; var s1, s2: string): boolean;
          {checks whether '<' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
            VariableID: integer;
          begin
            Result := false;

            i := 0;
            j := length(s);
            repeat

              while i <> j do
              begin
                inc(i);
                if s[i] = '<' then
                  break;
              end;

              if (i > 1) and (i < j) then
              begin
                s1 := copy(s, 1, i-1);
                s2 := copy(s, i+1, j-i);

                Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                if Result then
                begin
                  VariableID := 0;
                  FloatNumber := 0;
                  Result := CheckVariable(s1, VariableID) or CheckNumber(s1, FloatNumber);

                  if not Result then
                  begin
                    s3 := '';
                    Result := CheckBracket(s1, s3);
                    if Result then
                      s1 := s3;
                  end;

                  if not Result then
                  begin
                    s4 := '';
                    fsort := constant;
                    Result := CheckNegate(s1, s3) or
                              CheckBitNot(s1, s3) or
                              CheckLogicalNot(s1, s3) or
                              CheckLessOrEqual(s1, s3, s4) or
                              CheckGreaterThan(s1, s3, s4) or
                              CheckGreaterOrEqual(s1, s3, s4) or
                              CheckShiftLeft(s1, s3, s4) or
                              CheckShiftRight(s1, s3, s4) or
                              CheckAdd(s1, s3, s4) or
                              CheckSubtract(s1, s3, s4) or
                              CheckMultiply(s1, s3, s4) or
                              CheckIntegerDiv(s1, s3, s4) or
                              CheckModulo(s1, s3, s4) or
                              CheckRealDivision(s1, s3, s4) or
                              CheckPower(s1, s3, s4, fsort) or
                              CheckFuncOneVar(s1, s3) or
                              CheckFuncTwoVar(s1, s3, s4);
                  end;
                  if Result then
                  begin
                    Result := CheckVariable(s2, VariableID) or CheckNumber(s2, FloatNumber);

                    if not Result then
                    begin
                      Result := CheckBracket(s2, s3);
                      if Result then
                        s2 := s3
                      else
                        Result := CheckNegate(s2, s3) or
                                  CheckBitNot(s2, s3) or
                                  CheckLogicalNot(s2, s3) or
                                  CheckLessThan(s2, s3, s4) or
                                  CheckLessOrEqual(s2, s3, s4) or
                                  CheckGreaterThan(s2, s3, s4) or
                                  CheckGreaterOrEqual(s2, s3, s4) or
                                  CheckShiftLeft(s2, s3, s4) or
                                  CheckShiftRight(s2, s3, s4) or
                                  CheckAdd(s2, s3, s4) or
                                  CheckSubtract(s2, s3, s4) or
                                  CheckMultiply(s2, s3, s4) or
                                  CheckIntegerDiv(s2, s3, s4) or
                                  CheckModulo(s2, s3, s4) or
                                  CheckRealDivision(s2, s3, s4) or
                                  CheckPower(s2, s3, s4, fsort) or
                                  CheckFuncOneVar(s2, s3) or
                                  CheckFuncTwoVar(s2, s3, s4);
                    end;
                  end;
                end;
              end
              else
                break;
            until Result;
          end;

          function CheckLessOrEqual(const s: string; var s1, s2: string): boolean;
          {checks whether '<=' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          begin
            Result := false;

            i := 0;
            repeat
              j := pos('<=', copy(s, i+1, length(s)-i));
              if j > 0 then
              begin

                inc(i, j);
                if (i > 1) and (i < length(s)) then
                begin
                  s1 := copy(s, 1, i-1);
                  s2 := copy(s, i+2, length(s)-i-1);

                  Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                  if Result then
                  begin
                    VariableID := 0;
                    FloatNumber := 0;
                    Result := CheckVariable(s1, VariableID) or
                              CheckNumber(s1, FloatNumber);

                    if not Result then
                    begin
                      s3 := '';
                      Result := CheckBracket(s1, s3);
                      if Result then
                        s1 := s3;
                    end;
                    if not Result then
                    begin
                      s4 := '';
                      fsort := constant;
                      Result := CheckNegate(s1, s3) or
                                CheckBitNot(s1, s3) or
                                CheckLogicalNot(s1, s3) or
                                CheckGreaterThan(s1, s3, s4) or
                                CheckGreaterOrEqual(s1, s3, s4) or
                                CheckShiftLeft(s1, s3, s4) or
                                CheckShiftRight(s1, s3, s4) or
                                CheckAdd(s1, s3, s4) or
                                CheckSubtract(s1, s3, s4) or
                                CheckMultiply(s1, s3, s4) or
                                CheckIntegerDiv(s1, s3, s4) or
                                CheckModulo(s1, s3, s4) or
                                CheckRealDivision(s1, s3, s4) or
                                CheckPower(s1, s3, s4, fsort) or
                                CheckFuncOneVar(s1, s3) or
                                CheckFuncTwoVar(s1, s3, s4);
                    end;
                    if Result then
                    begin
                      Result := CheckVariable(s2, VariableID) or
                                CheckNumber(s2, FloatNumber);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3
                        else
                          Result := CheckNegate(s2, s3) or
                                    CheckBitNot(s2, s3) or
                                    CheckLogicalNot(s2, s3) or
                                    CheckLessOrEqual(s2, s3, s4) or
                                    CheckGreaterThan(s2, s3, s4) or
                                    CheckGreaterOrEqual(s2, s3, s4) or
                                    CheckShiftLeft(s2, s3, s4) or
                                    CheckShiftRight(s2, s3, s4) or
                                    CheckAdd(s2, s3, s4) or
                                    CheckSubtract(s2, s3, s4) or
                                    CheckMultiply(s2, s3, s4) or
                                    CheckIntegerDiv(s2, s3, s4) or
                                    CheckModulo(s2, s3, s4) or
                                    CheckRealDivision(s2, s3, s4) or
                                    CheckPower(s2, s3, s4, fsort) or
                                    CheckFuncOneVar(s2, s3) or
                                    CheckFuncTwoVar(s2, s3, s4);
                      end
                    end;
                  end;
                end;
              end;
            until Result or (j = 0) or (i >= length(s));
          end;

          function CheckGreaterThan(const s: string; var s1, s2: string): boolean;
          {checks whether '>' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
            VariableID: integer;
          begin
            Result := false;

            i := 0;
            j := length(s);
            repeat

              while i <> j do
              begin
                inc(i);
                if s[i] = '>' then
                  break;
              end;

              if (i > 1) and (i < j) then
              begin
                s1 := copy(s, 1, i-1);
                s2 := copy(s, i+1, j-i);

                Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                if Result then
                begin
                  VariableID := 0;
                  FloatNumber := 0;
                  Result := CheckVariable(s1, VariableID) or CheckNumber(s1, FloatNumber);

                  if not Result then
                  begin
                    s3 := '';
                    Result := CheckBracket(s1, s3);
                    if Result then
                      s1 := s3;
                  end;

                  if not Result then
                  begin
                    s4 := '';
                    fsort := constant;
                    Result := CheckNegate(s1, s3) or
                              CheckBitNot(s1, s3) or
                              CheckLogicalNot(s1, s3) or
                              CheckGreaterOrEqual(s1, s3, s4) or
                              CheckShiftLeft(s1, s3, s4) or
                              CheckShiftRight(s1, s3, s4) or
                              CheckAdd(s1, s3, s4) or
                              CheckSubtract(s1, s3, s4) or
                              CheckMultiply(s1, s3, s4) or
                              CheckIntegerDiv(s1, s3, s4) or
                              CheckModulo(s1, s3, s4) or
                              CheckRealDivision(s1, s3, s4) or
                              CheckPower(s1, s3, s4, fsort) or
                              CheckFuncOneVar(s1, s3) or
                              CheckFuncTwoVar(s1, s3, s4);
                  end;
                  if Result then
                  begin
                    Result := CheckVariable(s2, VariableID) or CheckNumber(s2, FloatNumber);

                    if not Result then
                    begin
                      Result := CheckBracket(s2, s3);
                      if Result then
                        s2 := s3
                      else
                        Result := CheckNegate(s2, s3) or
                                  CheckBitNot(s2, s3) or
                                  CheckLogicalNot(s2, s3) or
                                  CheckGreaterThan(s2, s3, s4) or
                                  CheckGreaterOrEqual(s2, s3, s4) or
                                  CheckShiftLeft(s2, s3, s4) or
                                  CheckShiftRight(s2, s3, s4) or
                                  CheckAdd(s2, s3, s4) or
                                  CheckSubtract(s2, s3, s4) or
                                  CheckMultiply(s2, s3, s4) or
                                  CheckIntegerDiv(s2, s3, s4) or
                                  CheckModulo(s2, s3, s4) or
                                  CheckRealDivision(s2, s3, s4) or
                                  CheckPower(s2, s3, s4, fsort) or
                                  CheckFuncOneVar(s2, s3) or
                                  CheckFuncTwoVar(s2, s3, s4);
                    end;
                  end;
                end;
              end
              else
                break;
            until Result;
          end;

          function CheckGreaterOrEqual(const s: string; var s1, s2: string): boolean;
          {checks whether '>=' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          begin
            Result := false;

            i := 0;
            repeat
              j := pos('>=', copy(s, i+1, length(s)-i));
              if j > 0 then
              begin

                inc(i, j);
                if (i > 1) and (i < length(s)) then
                begin
                  s1 := copy(s, 1, i-1);
                  s2 := copy(s, i+2, length(s)-i-1);

                  Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                  if Result then
                  begin
                    VariableID := 0;
                    FloatNumber := 0;
                    Result := CheckVariable(s1, VariableID) or
                              CheckNumber(s1, FloatNumber);

                    if not Result then
                    begin
                      s3 := '';
                      Result := CheckBracket(s1, s3);
                      if Result then
                        s1 := s3;
                    end;
                    if not Result then
                    begin
                      s4 := '';
                      fsort := constant;
                      Result := CheckNegate(s1, s3) or
                                CheckBitNot(s1, s3) or
                                CheckLogicalNot(s1, s3) or
                                CheckShiftLeft(s1, s3, s4) or
                                CheckShiftRight(s1, s3, s4) or
                                CheckAdd(s1, s3, s4) or
                                CheckSubtract(s1, s3, s4) or
                                CheckMultiply(s1, s3, s4) or
                                CheckIntegerDiv(s1, s3, s4) or
                                CheckModulo(s1, s3, s4) or
                                CheckRealDivision(s1, s3, s4) or
                                CheckPower(s1, s3, s4, fsort) or
                                CheckFuncOneVar(s1, s3) or
                                CheckFuncTwoVar(s1, s3, s4);
                    end;
                    if Result then
                    begin
                      Result := CheckVariable(s2, VariableID) or
                                CheckNumber(s2, FloatNumber);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3
                        else
                          Result := CheckNegate(s2, s3) or
                                    CheckBitNot(s2, s3) or
                                    CheckLogicalNot(s2, s3) or
                                    CheckGreaterOrEqual(s2, s3, s4) or
                                    CheckShiftLeft(s2, s3, s4) or
                                    CheckShiftRight(s2, s3, s4) or
                                    CheckAdd(s2, s3, s4) or
                                    CheckSubtract(s2, s3, s4) or
                                    CheckMultiply(s2, s3, s4) or
                                    CheckIntegerDiv(s2, s3, s4) or
                                    CheckModulo(s2, s3, s4) or
                                    CheckRealDivision(s2, s3, s4) or
                                    CheckPower(s2, s3, s4, fsort) or
                                    CheckFuncOneVar(s2, s3) or
                                    CheckFuncTwoVar(s2, s3, s4);
                      end
                    end;
                  end;
                end;
              end;
            until Result or (j = 0) or (i >= length(s));
          end;

          function CheckShiftLeft(const s: string; var s1, s2: string): boolean;
          {checks whether '<<' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          begin
            Result := false;

            i := 0;
            repeat
              j := pos('<<', copy(s, i+1, length(s)-i));
              if j > 0 then
              begin

                inc(i, j);
                if (i > 1) and (i < length(s)) then
                begin
                  s1 := copy(s, 1, i-1);
                  s2 := copy(s, i+2, length(s)-i-1);

                  Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                  if Result then
                  begin
                    VariableID := 0;
                    FloatNumber := 0;
                    Result := CheckVariable(s1, VariableID) or
                              CheckNumber(s1, FloatNumber);

                    if not Result then
                    begin
                      s3 := '';
                      Result := CheckBracket(s1, s3);
                      if Result then
                        s1 := s3;
                    end;
                    if not Result then
                    begin
                      s4 := '';
                      fsort := constant;
                      Result := CheckNegate(s1, s3) or
                                CheckBitNot(s1, s3) or
                                CheckLogicalNot(s1, s3) or
                                CheckShiftRight(s1, s3, s4) or
                                CheckAdd(s1, s3, s4) or
                                CheckSubtract(s1, s3, s4) or
                                CheckMultiply(s1, s3, s4) or
                                CheckIntegerDiv(s1, s3, s4) or
                                CheckModulo(s1, s3, s4) or
                                CheckRealDivision(s1, s3, s4) or
                                CheckPower(s1, s3, s4, fsort) or
                                CheckFuncOneVar(s1, s3) or
                                CheckFuncTwoVar(s1, s3, s4);
                    end;
                    if Result then
                    begin
                      Result := CheckVariable(s2, VariableID) or
                                CheckNumber(s2, FloatNumber);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3
                        else
                          Result := CheckNegate(s2, s3) or
                                    CheckBitNot(s2, s3) or
                                    CheckLogicalNot(s2, s3) or
                                    CheckShiftLeft(s2, s3, s4) or
                                    CheckShiftRight(s2, s3, s4) or
                                    CheckAdd(s2, s3, s4) or
                                    CheckSubtract(s2, s3, s4) or
                                    CheckMultiply(s2, s3, s4) or
                                    CheckIntegerDiv(s2, s3, s4) or
                                    CheckModulo(s2, s3, s4) or
                                    CheckRealDivision(s2, s3, s4) or
                                    CheckPower(s2, s3, s4, fsort) or
                                    CheckFuncOneVar(s2, s3) or
                                    CheckFuncTwoVar(s2, s3, s4);
                      end
                    end;
                  end;
                end;
              end;
            until Result or (j = 0) or (i >= length(s));
          end;

          function CheckShiftRight(const s: string; var s1, s2: string): boolean;
          {checks whether '>>' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          begin
            Result := false;

            i := 0;
            repeat
              j := pos('>>', copy(s, i+1, length(s)-i));
              if j > 0 then
              begin

                inc(i, j);
                if (i > 1) and (i < length(s)) then
                begin
                  s1 := copy(s, 1, i-1);
                  s2 := copy(s, i+2, length(s)-i-1);

                  Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                  if Result then
                  begin
                    VariableID := 0;
                    FloatNumber := 0;
                    Result := CheckVariable(s1, VariableID) or
                              CheckNumber(s1, FloatNumber);

                    if not Result then
                    begin
                      s3 := '';
                      Result := CheckBracket(s1, s3);
                      if Result then
                        s1 := s3;
                    end;
                    if not Result then
                    begin
                      s4 := '';
                      fsort := constant;
                      Result := CheckNegate(s1, s3) or
                                CheckBitNot(s1, s3) or
                                CheckLogicalNot(s1, s3) or
                                CheckAdd(s1, s3, s4) or
                                CheckSubtract(s1, s3, s4) or
                                CheckMultiply(s1, s3, s4) or
                                CheckIntegerDiv(s1, s3, s4) or
                                CheckModulo(s1, s3, s4) or
                                CheckRealDivision(s1, s3, s4) or
                                CheckPower(s1, s3, s4, fsort) or
                                CheckFuncOneVar(s1, s3) or
                                CheckFuncTwoVar(s1, s3, s4);
                    end;
                    if Result then
                    begin
                      Result := CheckVariable(s2, VariableID) or
                                CheckNumber(s2, FloatNumber);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3
                        else
                          Result := CheckNegate(s2, s3) or
                                    CheckBitNot(s2, s3) or
                                    CheckLogicalNot(s2, s3) or
                                    CheckShiftRight(s2, s3, s4) or
                                    CheckAdd(s2, s3, s4) or
                                    CheckSubtract(s2, s3, s4) or
                                    CheckMultiply(s2, s3, s4) or
                                    CheckIntegerDiv(s2, s3, s4) or
                                    CheckModulo(s2, s3, s4) or
                                    CheckRealDivision(s2, s3, s4) or
                                    CheckPower(s2, s3, s4, fsort) or
                                    CheckFuncOneVar(s2, s3) or
                                    CheckFuncTwoVar(s2, s3, s4);
                      end
                    end;
                  end;
                end;
              end;
            until Result or (j = 0) or (i >= length(s));
          end;

          function CheckRealDivision(const s: string; var s1, s2: string): boolean;
          {checks whether '/' is the primary TOperation in s}
          var
            s3, s4: TermString;
            i, j: integer;
            VariableID: integer;
            FloatNumber: ParserFloat;
            fsort: TToken;
          begin
            Result := false;

            i := 0;
            j := length(s);

            repeat

              while i <> j do
              begin
                inc(i);
                if s[i] = '/' then
                  break;
              end;

              if (i > 1) and (i < j) then
              begin
                s1 := copy(s, 1, i-1);
                s2 := copy(s, i+1, j-i);

                Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                if Result then
                begin
                  VariableID := 0;
                  FloatNumber := 0;
                  Result := CheckVariable(s1, VariableID) or
                            CheckNumber(s1, FloatNumber);

                  if not Result then
                  begin
                    s3 := '';
                    Result := CheckBracket(s1, s3);
                    if Result then
                      s1 := s3;
                  end;

                  if not Result then
                  begin
                    s4 := '';
                    fsort := constant;
                    Result := CheckNegate(s1, s3) or
                              CheckBitNot(s1, s3) or
                              CheckLogicalNot(s1, s3) or
                              CheckIntegerDiv(s1, s3, s4) or
                              CheckModulo(s1, s3, s4) or
                              CheckRealDivision(s1, s3, s4) or
                              CheckPower(s1, s3, s4, fsort) or
                              CheckFuncOneVar(s1, s3) or
                              CheckFuncTwoVar(s1, s3, s4);
                  end;
                  if Result then
                  begin
                    Result := CheckVariable(s2, VariableID) or
                              CheckNumber(s2, FloatNumber);

                    if not Result then
                    begin
                      Result := CheckBracket(s2, s3);
                      if Result then
                        s2 := s3
                      else
                        Result := CheckNegate(s2, s3) or
                                  CheckBitNot(s2, s3) or
                                  CheckLogicalNot(s2, s3) or
                                  CheckPower(s2, s3, s4, fsort) or
                                  CheckFuncOneVar(s2, s3) or
                                  CheckFuncTwoVar(s2, s3, s4);
                    end;
                  end;
                end;
              end
              else
                break;
            until Result;
          end;

          function CheckFuncTwoVar(const s: string; var s1, s2: string): boolean;
          {checks whether s=f(s1,s2); s1,s2 being valid terms}

            function CheckComma(const s: string; var s1, s2: string): boolean;
            var
              i, j: integer;
            begin
              Result := false;

              i := 0;
              j := length(s);
              repeat

                while i <> j do
                begin
                  inc(i);
                  if s[i] = ',' then
                    break;
                end;

                if (i > 1) and (i < j) then
                begin
                  s1 := copy(s, 1, i-1);
                  if CheckTerm(s1) then
                  begin
                    s2 := copy(s, i+1, j-i);
                    Result := CheckTerm(s2);
                  end;

                end
                else
                  break;

              until Result;
            end;

          var
            SLen,
            counter : integer;
          begin

            Result := false;

            SLen := Pos('(', s);
            dec(SLen);

            if (SLen > 0) and (s[length(s)] = ')') then
            begin
              counter := 0;
              if FunctionTwo.Find(copy(s, 1, SLen), counter) then
              begin
                inc(SLen, 2);
                Result := CheckComma( copy(s, SLen, length(s)-SLen), s1, s2);
              end;
            end;
          end;


          function CheckFuncOneVar(const s: string; var s1: string): boolean;
          {checks whether s denotes the evaluation of a function fsort(s1)}
          var
            counter: integer;
            SLen: integer;
          begin
            Result := false;

            SLen := Pos('(', s);
            dec(SLen);

            if (SLen > 0) then
            begin
              counter := 0;
              if FunctionOne.Find(copy(s, 1, SLen), counter) then
              begin
                Result := CheckBracket(copy(s, SLen+1, length(s)-SLen), s1);
              end;
            end;
          end;



          function CheckPower(const s: string; var s1, s2: string; var AToken: TToken): boolean;
          var
            s3, s4: TermString;
            i, j: integer;
            FloatNumber: ParserFloat;
            VariableID: integer;
          begin
            Result := false;

            i := 0;
            j := length(s);
            repeat

              while i <> j do
              begin
                inc(i);
                if s[i] = '`' then
                  break;
              end;

              if (i > 1) and (i < j) then
              begin
                s1 := copy(s, 1, i-1);
                s2 := copy(s, i+1, j-i);

                Result := CheckNumberBrackets(s1) and CheckNumberBrackets(s2);

                if Result then
                begin
                  VariableID := 0;
                  FloatNumber := 0;
                  Result := CheckVariable(s1, VariableID) or CheckNumber(s1, FloatNumber);

                  if not Result then
                  begin
                    s3 := '';
                    Result := CheckBracket(s1, s3);
                    if Result then
                      s1 := s3;
                  end;

                  if not Result then
                  begin
                    s4 := '';
                    Result := CheckFuncOneVar(s1, s3) or
                              CheckFuncTwoVar(s1, s3, s4);
                  end;
                  if Result then
                  begin

                    if CheckNumber(s2, FloatNumber) then
                    begin
                      i := Integer(Trunc(FloatNumber));

                      if (i <> FloatNumber) then
                      begin
                        { this is a real number }
                        AToken := realpower;
                      end
                      else
                      begin
                        case i of
                          2: AToken := square;
                          3: AToken := third;
                          4: AToken := fourth;
                        else
                          AToken := integerpower;
                        end;
                      end;
                    end
                    else
                    begin
                      Result := CheckVariable(s2, VariableID);

                      if not Result then
                      begin
                        Result := CheckBracket(s2, s3);
                        if Result then
                          s2 := s3;
                      end;

                      if not Result then
                      begin
                        Result := CheckFuncOneVar(s2, s3) or
                                  CheckFuncTwoVar(s2, s3, s4);
                      end;

                      if Result then
                        AToken := realPower;
                    end;
                  end;

                end;
              end
              else
                break;

            until Result;
          end;

          function CreateOperation(const Term: TToken; const Proc: Pointer): PExpOperation;
          begin
            new(Result);
            with Result^ do
            begin
              Arg1 := nil;
              Arg2 := nil;
              Dest := nil;

              NextOperation := nil;

              Token := Term;

              Operation := TMathProcedure(Proc);
            end;
          end;

const
  BlankString = ' ';

type
  PTermRecord = ^TermRecord;
  TermRecord = record
                 { this usage of string is a bit inefficient,
                   as in 16bit always 256 bytes are consumed.
                   But since we
                   a) are allocating memory dynamically and
                   b) this will be released immediately when
                      finished with parsing
                   this seems to be OK

                   One COULD create a "TermClass" where this is handled }
                 StartString: string;
                 LeftString, RightString: string;

                 Token: TToken;

                 Position: array[1..3] of integer;

                 Next1,
                 Next2,
                 Previous: PTermRecord;
               end;

const
  { side effect: for each bracketing level added
      SizeOf(integer) bytes additional stack usage
      maxLevelWidth*SizeOf(Pointer) additional global memory used }
  maxBracketLevels = 20;

  { side effect: for each additional (complexity) level width
      maxBracketLevels*SizeOf(Pointer) additional global memory used }
  maxLevelWidth = 50;
type
  LevelArray = array[0..maxBracketLevels] of integer;

  OperationPointerArray = array[0..maxBracketLevels, 1..maxLevelWidth] of PExpOperation;
  POperationPointerArray = ^OperationPointerArray;
var
  Matrix: POperationPointerArray;

  { bracket positions }
  CurrentBracket,
  i,
  CurBracketLevels: integer;

  BracketLevel: LevelArray;

  LastOP: PExpOperation;
  FloatNumber: ParserFloat;
  VariableID: integer;


  ANewTerm, { need this particlar pointer to guarantee a good, flawless memory cleanup in except }

  FirstTerm,
  Next1Term,
  Next2Term,
  LastTerm: PTermRecord;

  counter1,
  counter2: integer;
begin
  { initialize local variables for safe checking in try..finally..end}

  { FirstTerm := nil; } { not necessary since not freed in finally }
  LastTerm := nil;
  ANewTerm := nil;
  Next1Term := nil;
  Next2Term := nil;

  Error := false;

  BracketLevel[0] := 0;
  FillChar(BracketLevel, SizeOf(BracketLevel), 0); { initialize bracket array }
  BracketLevel[0] := 1;
  CurBracketLevels := 0;

  new(Matrix);

  try { this block protects the whole of ALL assignments...}
    FillChar(Matrix^, SizeOf(Matrix^), 0);

    new(ANewTerm);
    with ANewTerm^ do
    begin

      if CaseSensitive then
        StartString := FunctionString
      else
        StartString := UpperCase(FunctionString);

      { remove leading and trailing spaces }
      counter1 := 1;
      counter2 := length(StartString);
      while counter1 <= counter2 do
        if StartString[counter1] <> ' ' then
          break
        else
          inc(counter1);

      counter2 := length(StartString);
      while counter2 > counter1 do
        if StartString[counter2] <> ' ' then
          break
        else
          dec(counter2);

      StartString := Copy(StartString, counter1, counter2 - counter1 + 1);

      if Pos(' ', StartString) > 0 then
        raise EExpressionHasBlanks.Create(msgErrBlanks);
      {
      Old code:

         StartString := RemoveBlanks(UpperCase(FunctionString));

      ...do not use! Using it would create the following situation:

         Passed string:   "e xp(12)"
         Modified string: "exp(12)"

      This MAY or may not be the desired meaning - there may well exist
      a variable "e" and a function "xp" and just the operator would be missing.

      Conclusion: the above line has the potential of changing the meaning
                  of an expression.
      }

      if not CheckNumberBrackets(StartString) then
        raise EMissMatchingBracket.Create(msgMissingBrackets);

      { remove enclosing brackets, e.g. ((pi)) }
      while CheckBracket(StartString, FunctionString) do
        StartString := FunctionString;

      LeftString := BlankString;
      RightString := BlankString;

      Token := variab;

      Next1 := nil;
      Next2 := nil;
      Previous := nil;
    end;

    Matrix^[0,1] := CreateOperation(variab, nil);

    LastTerm := ANewTerm;
    FirstTerm := ANewTerm;
    ANewTerm := nil;

    with LastTerm^ do
    begin
      Position[1] := 0;
      Position[2] := 1;
      Position[3] := 1;
    end;

    repeat

      repeat

        with LastTerm^ do
        begin

          CurrentBracket := Position[1];
          i := Position[2];

          if Next1 = nil then
          begin
            VariableID := 0;
            if CheckVariable(StartString, VariableID) then
            begin
              Token := variab;

              if Position[3] = 1 then
                Matrix^[CurrentBracket, i]^.Arg1 := PParserFloat(Variables.Objects[VariableID])
              else
                Matrix^[CurrentBracket, i]^.Arg2 := PParserFloat(Variables.Objects[VariableID])
            end
            else
            begin
              FloatNumber := 0;
              if CheckNumber(StartString, FloatNumber) then
              begin
                Token := constant;
                if Position[3] = 1 then
                begin
                  new(Matrix^[CurrentBracket, i]^.Arg1);
                  Matrix^[CurrentBracket, i]^.Arg1^ := FloatNumber;
                end
                else
                begin
                  new(Matrix^[CurrentBracket, i]^.Arg2);
                  Matrix^[CurrentBracket, i]^.Arg2^ := FloatNumber;
                end;
              end
              else if CheckNegate(StartString, LeftString) then
                Token := minus
              else if CheckBitNot(StartString, LeftString) then
                Token := bitnot
              else if CheckLogicalNot(StartString, LeftString) then
                Token := lognot
              else if CheckLogicalOr(StartString, LeftString, RightString) then
                Token := logor
              else if CheckLogicalAnd(StartString, LeftString, RightString) then
                Token := logand
              else if CheckBitOr(StartString, LeftString, RightString) then
                Token := bitor
              else if CheckBitXor(StartString, LeftString, RightString) then
                Token := bitxor
              else if CheckBitAnd(StartString, LeftString, RightString) then
                Token := bitand
              else if CheckEqualTo(StartString, LeftString, RightString) then
                Token := equalto
              else if CheckNotEqualTo(StartString, LeftString, RightString) then
                Token := notequalto
              else if CheckLessThan(StartString, LeftString, RightString) then
                Token := lessthan
              else if CheckLessOrEqual(StartString, LeftString, RightString) then
                Token := lessoreq
              else if CheckGreaterThan(StartString, LeftString, RightString) then
                Token := greaterthan
              else if CheckGreaterOrEqual(StartString, LeftString, RightString) then
                Token := greateroreq
              else if CheckShiftLeft(StartString, LeftString, RightString) then
                Token := sleft
              else if CheckShiftRight(StartString, LeftString, RightString) then
                Token := sright
              else if CheckAdd(StartString, LeftString, RightString) then
                Token := sum
              else if CheckSubtract(StartString, LeftString, RightString) then
                Token := diff
              else if CheckMultiply(StartString, LeftString, RightString) then
                Token := prod
              else if CheckIntegerDiv(StartString, LeftString, RightString) then
                Token := IntDiv
              else if CheckModulo(StartString, LeftString, RightString) then
                Token := modulo
              else if CheckRealDivision(StartString, LeftString, RightString) then
                Token := divis
              else if not CheckPower(StartString, LeftString, RightString, Token) then
              begin
                if CheckFuncOneVar(StartString, LeftString) then
                  Token := FuncOneVar
                else if CheckFuncTwoVar(StartString, LeftString, RightString) then
                  Token := FuncTwoVar
                else
                begin
                  Error := true; {with an exception raised this is meaningless...}
                  if (LeftString = BlankString) and (RightString = BlankString) then
                    raise ESyntaxError.CreateFmt(msgParseError+' %s', [StartString])
                  else
                    raise ESyntaxError.CreateFmt(msgParseError+' %s | %s', [Leftstring, RightString]);
                end;
              end;
            end;
          end;
        end; { with LastTerm^ }


        if LastTerm^.Token in ( [minus, bitnot, lognot, square, third, fourth, FuncOneVar, FuncTwoVar] + TokenOperators) then
        begin
          if LastTerm^.Next1 = nil then
          begin
            try
              Next1Term := nil;
              new(Next1Term);

              inc(CurrentBracket);
              if CurrentBracket > maxBracketLevels then
              begin
                Error := true;
                raise ETooManyNestings.Create(msgNestings);
              end;

              if CurBracketLevels < CurrentBracket then
                CurBracketLevels := CurrentBracket;

              i := BracketLevel[CurrentBracket] + 1;
              if i > maxLevelWidth then
              begin
                Error := true;
                raise EExpressionTooComplex.Create(msgTooComplex);
              end;

              with Next1Term^ do
              begin
                StartString := LastTerm^.LeftString;
                LeftString := BlankString;
                RightString := BlankString;

                Position[1] := CurrentBracket;
                Position[2] := i;
                Position[3] := 1;

                Token := variab;

                Previous := LastTerm;
                Next1 := nil;
                Next2 := nil;
              end;

              with LastTerm^ do
              begin
                case Token of
                  FuncOneVar:
                    with FunctionOne do
                      Matrix^[CurrentBracket, i] := CreateOperation(
                                       Token,
                                       Objects[IndexOf(copy(StartString, 1, pos('(', StartString)-1))]
                                                                   );

                  FuncTwoVar:
                    with FunctionTwo do
                      Matrix^[CurrentBracket, i] := CreateOperation(
                                       Token,
                                       Objects[IndexOf(copy(StartString, 1, pos('(', StartString)-1))]
                                                                  );
                else
                  Matrix^[CurrentBracket, i] := CreateOperation(Token, nil);
                end;

                new(Matrix^[CurrentBracket, i]^.Dest);
                Matrix^[CurrentBracket, i]^.Dest^ := 0;

                if Position[3] = 1 then
                  Matrix^[Position[1], Position[2]]^.Arg1 := Matrix^[CurrentBracket, i]^.Dest
                else
                  Matrix^[Position[1], Position[2]]^.Arg2 := Matrix^[CurrentBracket, i]^.Dest;

                Next1 := Next1Term;
                Next1Term := nil;
              end;

              if LastTerm^.Token in [minus, bitnot, lognot, square, third, fourth, FuncOneVar] then
                inc(BracketLevel[CurrentBracket]);

            except
              on E: Exception do
              begin
                if assigned(Next1Term) then
                begin
                  dispose(Next1Term);
                  Next1Term := nil;
                end;

                raise;
              end;
            end;

          end

          else
          begin
            if LastTerm^.Token in (TokenOperators + [FuncTwoVar]) then
            begin
              try
                Next2Term := nil;
                new(Next2Term);

                inc(CurrentBracket);
                if CurrentBracket > maxBracketLevels then
                begin
                  Error := true;
                  raise ETooManyNestings.Create(msgNestings);
                end;

                if CurBracketLevels < CurrentBracket then
                  CurBracketLevels := CurrentBracket;

                i := BracketLevel[CurrentBracket] + 1;
                if i > maxLevelWidth then
                begin
                  Error := true;
                  raise EExpressionTooComplex.Create(msgTooComplex);
                end;

                with Next2Term^ do
                begin
                  StartString := LastTerm^.RightString;

                  LeftString := BlankString;
                  RightString := BlankString;

                  Token := variab;

                  Position[1] := CurrentBracket;
                  Position[2] := i;
                  Position[3] := 2;

                  Previous := LastTerm;
                  Next1 := nil;
                  Next2 := nil;
                end;

                LastTerm^.Next2 := Next2Term;
                Next2Term := nil;
                inc(BracketLevel[CurrentBracket]);

              except
                on E: Exception do
                begin
                  if assigned(Next2Term) then
                  begin
                    dispose(Next2Term);
                    Next2Term := nil;
                  end;
                end;
              end;
            end
            else
              raise EParserInternalError.Create(msgInternalError);
          end;
        end;


        with LastTerm^ do
          if Next1 = nil then
          begin
          { we are done with THIS loop }
            break;
          end
          else
            if Next2 = nil then
              LastTerm := Next1
            else
              LastTerm := Next2;

      until false; { endless loop, break'ed 7 lines above }

      if LastTerm = FirstTerm then
      begin
        dispose(LastTerm);
        FirstTerm := nil;
        break; { OK - that is it, we did not find any more terms}
      end;

      repeat
        with LastTerm^ do { cannot use "with LastTerm^" OUTSIDE loop }
        begin
          if Next1 <> nil then
          begin
            dispose(Next1);
            Next1 := nil;
          end;

          if Next2 <> nil then
          begin
            dispose(Next2);
            Next2 := nil;
          end;

          LastTerm := Previous;
        end;
      until ((LastTerm^.Token in (TokenOperators + [FuncTwoVar])) and (LastTerm^.Next2 = nil)) or
            (LastTerm = FirstTerm);

      with FirstTerm^ do
      if (LastTerm = FirstTerm) and
            (  (Token in [minus, bitnot, lognot, square, third, fourth, FuncOneVar]) or
               ((Token in (TokenOperators + [FuncTwoVar])) and Assigned(Next2))
            ) then
      begin
        break;
      end;


    until false;


    { after having built the expression matrix, translate it into a tree/list }

    with FirstTerm^ do
      if FirstTerm <> nil then
      begin
        if Next1 <> nil then
        begin
          dispose(Next1);
          Next1 := nil;
        end;

        if Next2 <> nil then
        begin
          dispose(Next2);
          Next2 := nil;
        end;

        dispose(FirstTerm);
      end;

    BracketLevel[0] := 1;

    if CurBracketLevels = 0 then
    begin
      FirstOP := Matrix^[0,1];
      Matrix^[0,1] := nil;
      FirstOP^.Dest := FirstOP^.Arg1;
    end
    else
    begin

      FirstOP := Matrix^[CurBracketLevels, 1];
      LastOP := FirstOP;

      for counter2 := 2 to BracketLevel[CurBracketLevels] do
      begin
        LastOP^.NextOperation := Matrix^[CurBracketLevels, counter2];
        LastOP := LastOP^.NextOperation;
      end;


      for counter1 := CurBracketLevels-1 downto 1 do
        for counter2 := 1 to BracketLevel[counter1] do
        begin
          LastOP^.NextOperation := Matrix^[counter1, counter2];
          LastOP := LastOP^.NextOperation;
        end;


      with Matrix^[0,1]^ do
      begin
        Arg1 := nil;
        Arg2 := nil;
        Dest := nil;
      end;

      dispose(Matrix^[0,1]);
    end;

    dispose(Matrix);

  except

    on E: Exception do
    begin
      if Assigned(Matrix) then
      begin
        if assigned(Matrix^[0,1]) then
          dispose(Matrix^[0,1]);

        for counter1 := CurBracketLevels downto 1 do
          for counter2 := 1 to BracketLevel[counter1] do
            if Assigned(Matrix^[counter1, counter2]) then

              dispose(Matrix^[counter1, counter2]);

        dispose(Matrix);
      end;

      if Assigned(Next1Term) then
        dispose(Next1Term);

      if Assigned(Next2Term) then
        dispose(Next2Term);

  {   do NOT kill this one at it is possibly the same as LastTerm (see below)!
      if Assigned(FirstTerm) then
        dispose(FirstTerm);

      instead, DO kill ANewTerm, which will only be <> nil if it has NOT passed
      its value to some other pointer already so it can safely be freed
  }
      if Assigned(ANewTerm) then
        dispose(ANewTerm);

      if Assigned(LastTerm) and (LastTerm <> Next2Term) and (LastTerm <> Next1Term) then
        dispose(LastTerm);

      FirstOP := nil;

      raise; { re-raise exception }

    end; { on E:Exception do }
  end;
end;



end.
