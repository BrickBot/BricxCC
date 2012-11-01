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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit Parser10;

{$H+,S-} { long strings, no stack-checking}

{.$DEFINE DEBUG} { by default make it lean and efficient }
{$IFNDEF DEBUG}
  {$D-}
{$IFNDEF FPC}
  {$L-}
{$ENDIF}
  {$Q-}
  {$R-}
  {$S-}
{$ENDIF}

{$I+} { I/O checking ON }

interface

uses
  SysUtils,
  Classes;

type
  { a couple of unfortunately necessary global declarations }
  ParserFloat = Extended;  { please do NOT use "real", only single, double, extended}
  PParserFloat = ^ParserFloat;

  TToken=( variab, constant,
           minus, bitnot, lognot,
           sum, diff, prod, divis, modulo, IntDiv,
           bitand, bitor, bitxor, sleft, sright,
           logand, logor,
           lessthan,lessoreq,
           greaterthan,greateroreq,
           equalto,notequalto,
           integerpower, realpower,
           square, third, fourth,
           FuncOneVar, FuncTwoVar);

  PExpOperation = ^TExpOperation;
  { functions that are added to the engine MUST have this declaration }
  { make sure that the procedure is declared far !!! }
  TMathProcedure = procedure(AnOperation: PExpOperation);
  TExpOperation = record
                 { MUST use pointers (!), because argument and destination are linked... }
                 Arg1, Arg2 : PParserFloat;
                 Dest : PParserFloat;

                 NextOperation : PExpOperation;

                 Operation: TMathProcedure;
                 Token : TToken;
               end;

  EMathParserError = class(Exception); { create a new exception class and... }

  { ... some descendants }
  ESyntaxError = class(EMathParserError);
  EExpressionHasBlanks = class(EMathParserError);
  EExpressionTooComplex = class(EMathParserError);
  ETooManyNestings = class(EMathParserError);
  EMissMatchingBracket = class(EMathParserError);
  EBadName = class(EMathParserError);
  EParserInternalError = class(EMathParserError); { hopefully we will never see this one }


  { we COULD use Forms and the TExceptionEvent therein,
    but that would give us all the VCL overhead.
    Consequentially we just redeclare an appropriate event }
  TParserExceptionEvent = procedure (Sender: TObject; E: Exception) of object;

  TCustomParser = class(TComponent)
  private
    fCaseSensitive: boolean;
    fSilent: boolean;
    procedure SetCaseSensitive(const Value: boolean);
    procedure SetSilentExpression(const Value: string);
    function GetSilentExpression: string;
  private
    FExpression : string;
    FPascalNumberformat: boolean;
    FParserError : boolean;
    FErrorMessage : string;

    FVariables: TStringList;

    FStartOperationList: PExpOperation;

    FOnParserError : TParserExceptionEvent;

    function CalcValue: extended;
    procedure SetExpression(const AnExpression: string);
    procedure SetVar(const VarName: string; const Value: extended);
  protected
    { lists of available functions, see .Create for example use }
    FunctionOne : TStringList;     { functions with ONE argument, e.g. exp() }
    FunctionTwo : TStringList;     { functions with TWO arguments, e.g. max(,) }

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ParseExpression(const AnExpression: string): boolean;
    procedure FreeExpression;

    { The PParserFloat returned points to the place in memory where the
      variable actually sits; to speed up assignment you can DIRECTLY
      assign data to the memory area. }
    function SetVariable(VarName: string; const Value: extended): PParserFloat;
    function GetVariable(const VarName: string): extended;

    procedure AddFunctionOneParam(const AFunctionName: string; const Func: TMathProcedure);
    procedure AddFunctionTwoParam(const AFunctionName: string; const Func: TMathProcedure);

    procedure ClearVariables;
    procedure ClearVariable(const AVarName: string);
    function  VariableExists(const AVarName: string): boolean;

    procedure ClearFunctions;
    procedure ClearFunction(const AFunctionName: string);

    property ParserError: boolean read FParserError;
    property ErrorMessage : string read FErrorMessage;
    property LinkedOperationList: PExpOperation read FStartOperationList;

    property Variable[const VarName: string]: extended read GetVariable write SetVar;
    property CaseSensitive : boolean read fCaseSensitive write SetCaseSensitive;
    property Silent : boolean read fSilent write fSilent;
  published
    property Value: extended read CalcValue stored false;

    { setting Expression automatically parses it
      Warning: exceptions MAY be raised, if OnParserError is NOT assigned,
               otherwise the event will be triggered in case of an error }
    property Expression: string read FExpression write SetExpression;
    property SilentExpression: string read GetSilentExpression write SetSilentExpression;
    property PascalNumberformat: boolean read FPascalNumberformat write FPascalNumberformat default true;
    property OnParserError: TParserExceptionEvent read FOnParserError write FOnParserError;
  end;




  TExpParser = class(TCustomParser)
  public
    { overrides to add the properties below as variables
      and adds all the functions }
    constructor Create(AOwner: TComponent); override;

    { returns the string with the blanks inside removed }
    class function RemoveBlanks(const s: string): string;
 end;



implementation

{$DEFINE UseMath}
{ Note: if you do not have the MATH unit simply remove the conditional define
        the component will continue to work, just a bit slower }

uses
{$IFDEF UseMath}
  Math,
{$ENDIF}
  P10Build;

{****************************************************************}
{                                                                }
{   Following are "built-in" calculation procedures              }
{                                                                }
{****************************************************************}
{
Naming convention for functions:

  Name of built-in function, prepended with an underscore.
  Example:

    ln --> _ln

Passed arguments / results:

  If the function takes any arguments - i.e. if it has been added to
  either the FunctionOne or the FunctionTwo list:

  - First  argument --> Arg1^
  - Second argument --> Arg2^

  The result of the operation must ALWAYS be put into

     Dest^


 Note: These are POINTERS to floats.
}



{****************************************************************}
{                                                                }
{   These are mandatory procedures - never remove them           }
{                                                                }
{****************************************************************}

{ do nothing - this only happens if the "term" is just a number
  or a variable; otherwise this procedure will never be called }
procedure _nothing(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := Dest^;
end;

procedure _Add(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := Arg1^ + Arg2^;
end;

procedure _Subtract(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := Arg1^ - Arg2^;
end;

procedure _Multiply(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := Arg1^ * Arg2^;
end;

procedure _RealDivide(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := Arg1^ / Arg2^;
end;

procedure _Modulo(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := trunc(Arg1^) mod trunc(Arg2^);
end;

procedure _IntDiv(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := trunc(Arg1^) div trunc(Arg2^);
end;

procedure _BitAnd(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := trunc(Arg1^) and trunc(Arg2^);
end;

procedure _BitOr(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := trunc(Arg1^) or trunc(Arg2^);
end;

procedure _BitXor(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := trunc(Arg1^) xor trunc(Arg2^);
end;

procedure _ShiftLeft(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := trunc(Arg1^) shl trunc(Arg2^);
end;

procedure _ShiftRight(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := trunc(Arg1^) shr trunc(Arg2^);
end;

procedure _Negate(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := -Arg1^;
end;

procedure _BitNot(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := not Trunc(Arg1^);
end;

const
  bVals : array[boolean] of integer = (0, 1);

procedure _LogicalNot(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := bVals[Trunc(Arg1^) = 0]; // not is implied
end;

procedure _LogicalAnd(AnOp: PExpOperation);
var
  b1, b2 : boolean;
begin
  with AnOp^ do begin
    b1 := Trunc(Arg1^) <> 0;
    b2 := Trunc(Arg2^) <> 0;
    Dest^ := bVals[b1 and b2];
  end;
end;

procedure _LogicalOr(AnOp: PExpOperation);
var
  b1, b2 : boolean;
begin
  with AnOp^ do begin
    b1 := Trunc(Arg1^) <> 0;
    b2 := Trunc(Arg2^) <> 0;
    Dest^ := bVals[b1 or b2];
  end;
end;

procedure _LessThan(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := bVals[Arg1^ < Arg2^];
end;

procedure _LessOrEqual(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := bVals[Arg1^ <= Arg2^];
end;

procedure _GreaterThan(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := bVals[Arg1^ > Arg2^];
end;

procedure _GreaterOrEqual(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := bVals[Arg1^ >= Arg2^];
end;

procedure _EqualTo(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := bVals[Arg1^ = Arg2^];
end;

procedure _NotEqualTo(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := bVals[Arg1^ <> Arg2^];
end;

procedure _IntPower(AnOp: PExpOperation);
{$IFNDEF UseMath}
var
  n, i: longint;
{$ENDIF}
begin

{$IFNDEF UseMath}
  with AnOp^ do
  begin
    n := trunc(abs(Arg2^))-1;

    case n of
      -1: Dest^ := 1;
       0: Dest^ := Arg1^;
    else
      Dest^ := Arg1^;
      for i := 1 to n do
        Dest^ := Dest^ * Arg1^;
    end;

    if Arg2^ < 0 then
      Dest^ := 1 / Dest^;

  end;
{$ELSE}
  with AnOp^ do
    Dest^ := IntPower(Arg1^, Integer(Trunc(Arg2^)));
{$ENDIF}
end;

procedure _square(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := sqr(Arg1^);
end;

procedure _third(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := Arg1^ * Arg1^ * Arg1^;
end;

procedure _forth(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := sqr(sqr(Arg1^));
end;

procedure _power(AnOp: PExpOperation);
begin
  with AnOp^ do
  begin
{$IFNDEF UseMath}
    if Arg1^ = 0 then
      Dest^ := 0
    else
      Dest^ := exp(Arg2^*ln(Arg1^));
{$ELSE}
    Dest^ := Power(Arg1^, Arg2^);
{$ENDIF}
  end;
end;


{****************************************************************}
{                                                                }
{   These are OPTIONAL procedures - you may remove them, though  }
{   it is preferable to not register them for use                }
{                                                                }
{****************************************************************}
procedure _sin(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := sin(Arg1^);
end;

procedure _cos(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := cos(Arg1^);
end;

procedure _arctan(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := arctan(Arg1^);
end;

procedure _arg(AnOp: PExpOperation);
begin
  with AnOp^ do
    if Arg1^ < 0 then
      Dest^ := arctan(Arg2^/Arg1^)+Pi
    else
      if Arg1^>0 then
        Dest^ := arctan(Arg2^/Arg1^)
      else
        if Arg2^ > 0 then
          Dest^ := 0.5 * Pi
        else
          Dest^ := -0.5 * Pi;
end;

procedure _sinh(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := (exp(Arg1^)-exp(-Arg1^))*0.5;
end;

procedure _cosh(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := (exp(Arg1^)+exp(-Arg1^))*0.5;
end;

procedure _cotan(AnOp: PExpOperation);
begin
  with AnOp^ do
  {$IFNDEF UseMath}
    Dest^ := cos(Arg1^) / sin(Arg1^);
  {$ELSE}
    Dest^ := cotan(Arg1^);
  {$ENDIF}
end;

procedure _tan(AnOp: PExpOperation);
begin
  with AnOp^ do
  {$IFNDEF UseMath}
    Dest^ := sin(Arg1^) / cos(Arg1^);
  {$ELSE}
    Dest^ := tan(Arg1^);
  {$ENDIF}
end;

procedure _exp(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := exp(Arg1^);
end;

procedure _ln(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := ln(Arg1^);
end;

procedure _log10(AnOp: PExpOperation);
{$IFNDEF UseMath}
const
  _1_ln10 =  0.4342944819033;
{$ENDIF}
begin
  with AnOp^ do
{$IFDEF UseMath}
    Dest^ := log10(Arg1^);
{$ELSE}
    Dest^ := ln(Arg1^) * _1_ln10;
{$ENDIF}
end;

procedure _log2(AnOp: PExpOperation);
{$IFNDEF UseMath}
const
  _1_ln2 = 1.4426950409;
{$ENDIF}
begin
  with AnOp^ do
{$IFDEF UseMath}
    Dest^ := log2(Arg1^);
{$ELSE}
    Dest^ := ln(Arg1^) * _1_ln2;
{$ENDIF}
end;

procedure _logN(AnOp: PExpOperation);
begin
  with AnOp^ do
{$IFDEF UseMath}
    Dest^ := logN(Arg1^, Arg2^);
{$ELSE}
    Dest^ := ln(Arg1^) / ln(Arg2^);
{$ENDIF}
end;

procedure _sqrt(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := sqrt(Arg1^);
end;

procedure _abs(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := abs(Arg1^);
end;

procedure _min(AnOp: PExpOperation);
begin
  with AnOp^ do
    if Arg1^ < Arg2^ then
      Dest^ := Arg1^
    else
      Dest^ := Arg2^;
end;

procedure _max(AnOp: PExpOperation);
begin
  with AnOp^ do
    if Arg1^ < Arg2^ then
      Dest^ := Arg2^
    else
      Dest^ := Arg1^;
end;

procedure _heaviside(AnOp: PExpOperation);
begin
  with AnOp^ do
    if Arg1^ < 0 then
      Dest^ := 0
    else
      Dest^ := 1;
end;

procedure _sign(AnOp: PExpOperation);
begin
  with AnOp^ do
    if Arg1^ < 0 then
      Dest^ := -1
    else
      if Arg1^ > 0 then
        Dest^ := 1.0
      else
        Dest^ := 0.0;
end;

procedure _zero(AnOp: PExpOperation);
begin
  with AnOp^ do
    if Arg1^ = 0.0 then
      Dest^ := 0.0
    else
      Dest^ := 1.0;
end;

procedure _trunc(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := int(Arg1^)
end;

procedure _ceil(AnOp: PExpOperation);
begin
  with AnOp^ do
    if frac(Arg1^) > 0 then
      Dest^ := int(Arg1^ + 1)
    else
      Dest^ := int(Arg1^);
end;

procedure _floor(AnOp: PExpOperation);
begin
  with AnOp^ do
    if frac(Arg1^) < 0 then
      Dest^ := int(Arg1^ - 1)
    else
      Dest^ := int(Arg1^);
end;

procedure _rnd(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := Random * int(Arg1^);
end;

procedure _random(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := Random(Trunc(Arg1^));
end;

procedure _radius(AnOp: PExpOperation);
begin
  with AnOp^ do
    Dest^ := sqrt(sqr(Arg1^)+sqr(Arg2^));
end;

procedure _phase(AnOp: PExpOperation);
var
  a: ParserFloat;
begin
  with AnOp^ do
  begin
    a := Arg1^ / (2/pi);
    Dest^ := (2*pi) * (a-round(a));
  end;
end;

{****************************************************************}
{                                                                }
{   TCustomParser                                                }
{                                                                }
{    A base class which does not publish the variable properties }
{    and adds no functions by default                            }
{                                                                }
{****************************************************************}
function TCustomParser.ParseExpression(const AnExpression: string):boolean;
var
  OperationLoop: PExpOperation;
begin
  FreeExpression;
  FExpression := AnExpression;

  if AnExpression <> '' then
  begin
    Result := false;

    try
      ParseFunction( AnExpression,

                     FVariables,

                     FunctionOne,
                     FunctionTwo,

                     FPascalNumberformat,

                     CaseSensitive,

                     Silent,

                     FErrorMessage, 

                     FStartOperationList,
                     Result);

      FParserError := Result;

    except
      on E: Exception do
      begin
        FParserError := true;
        FErrorMessage := E.Message;

        if not Silent then
        begin
          if Assigned(FOnParserError) then
          begin
            FOnParserError(Self, E);
            exit;
          end
          else
            raise;
        end;
      end;
    end;

    Result := not Result;

    OperationLoop := FStartOperationList;
    while OperationLoop <> nil do
    begin
      with OperationLoop^ do
      begin
        case Token of

          variab,
          constant:      Operation := @_nothing;

          minus:         Operation := @_negate;
          bitnot:        Operation := @_BitNot;
          lognot:        Operation := @_LogicalNot;

          logand:        Operation := @_LogicalAnd;
          logor:         Operation := @_LogicalOr;

          lessthan:      Operation := @_LessThan;
          lessoreq:      Operation := @_LessOrEqual;
          greaterthan:   Operation := @_GreaterThan;
          greateroreq:   Operation := @_GreaterOrEqual;
          equalto:       Operation := @_EqualTo;
          notequalto:    Operation := @_NotEqualTo;

          sum:           Operation := @_add;
          diff:          Operation := @_subtract;
          prod:          Operation := @_multiply;
          divis:         Operation := @_RealDivide;

          modulo:        Operation := @_Modulo;
          intdiv:        Operation := @_IntDiv;

          bitand:        Operation := @_BitAnd;
          bitor:         Operation := @_BitOr;
          bitxor:        Operation := @_BitXor;
          sleft:         Operation := @_ShiftLeft;
          sright:        Operation := @_ShiftRight;

          integerpower:  Operation := @_IntPower;
          realpower:     Operation := @_Power;

          square:        Operation := @_square;
          third:         Operation := @_third;
          fourth:        Operation := @_forth;

          FuncOneVar, FuncTwoVar:    { job has been done in build already !};
        end; {case}

        OperationLoop := NextOperation;
      end; {with OperationLoop^}

    end; {while OperationLoop<>nil}
  end;
  // reset Silent to False (it is always a one-shot use)
  Silent := False;
end;

constructor TCustomParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fCaseSensitive := true;
  FPascalNumberformat := true;

  FVariables := TStringList.Create;
  FVariables.CaseSensitive := fCaseSensitive;
  with FVariables do
  begin
    Sorted := true;
    Duplicates := dupIgnore;
  end;

  FunctionOne := TStringList.Create;
  FunctionOne.CaseSensitive := fCaseSensitive;
  with FunctionOne do
  begin
    Sorted := true;
    Duplicates := dupError;
  end;

  FunctionTwo := TStringList.Create;
  FunctionTwo.CaseSensitive := fCaseSensitive;
  with FunctionTwo do
  begin
    Sorted := true;
    Duplicates := dupError;
  end;

end;

destructor TCustomParser.Destroy;
begin
  FreeExpression;

  ClearVariables;
  FVariables.Free;

  FunctionOne.Free;
  FunctionTwo.Free;

  inherited Destroy;
end;




procedure TCustomParser.SetVar(const VarName: string; const Value: extended);
begin
  SetVariable(VarName, Value);
end;

function TCustomParser.SetVariable(VarName: string; const Value: extended): PParserFloat;
var
  i: integer;
begin
  if not CaseSensitive then
    VarName := UpperCase(VarName);

  i := 0;
  with FVariables do
    if Find(VarName, i) then
    begin
      Result := PParserFloat(Objects[i]);
      Result^ := Value;
    end
    else
    begin
      if Length(Varname) = 1 then
      begin
        { is the variable name a valid identifier? }
        if not IsValidIdent(VarName) then
          raise EBadName.Create(VarName);

        { unravelled loop for improved (string!) performance! }

        { check whether the variable contains any of the operators (DIV and MOD)
          this would confuse the parser... }
        if pos('+', VarName) <> 0 then
            raise EBadName.Create(VarName);

        if pos('-', VarName) <> 0 then
            raise EBadName.Create(VarName);

        if pos('*', VarName) <> 0 then
            raise EBadName.Create(VarName);

        if pos('/', VarName) <> 0 then
            raise EBadName.Create(VarName);

        if pos('^', VarName) <> 0 then
            raise EBadName.Create(VarName);

        if pos('div', VarName) <> 0 then
            raise EBadName.Create(VarName);

        if pos('mod', VarName) <> 0 then
            raise EBadName.Create(VarName);

        new(Result);
      end
      else
      begin
        { is the variable name a valid identifier? }
        if not IsValidIdent(VarName) then
          raise EBadName.Create(VarName);

        new(Result);
      end;

      Result^ := Value;

      AddObject(VarName, TObject(Result));
    end
end;

function TCustomParser.GetVariable(const VarName: string): extended;
var
  i: integer;
  tmpVarName : string;
begin
  with FVariables do
  begin
    if CaseSensitive then
      tmpVarName := VarName
    else
      tmpVarName := UpperCase(VarName);
    i := 0;
    if Find(tmpVarName, i) then
      Result := PParserFloat(Objects[i])^
    else
      Result := 0.0;
  end;
end;

procedure TCustomParser.AddFunctionOneParam(const AFunctionName: string; const Func: TMathProcedure);
var
  tmpFuncName : string;
begin
  if CaseSensitive then
    tmpFuncName := AFunctionName
  else
    tmpFuncName := UpperCase(AFunctionName);
  if IsValidIdent(AFunctionName) then
    FunctionOne.AddObject(tmpFuncName, TObject(@Func))
  else
    raise EBadName.Create(AFunctionName);
end;

procedure TCustomParser.AddFunctionTwoParam(const AFunctionName: string; const Func: TMathProcedure);
var
  tmpFuncName : string;
begin
  if CaseSensitive then
    tmpFuncName := AFunctionName
  else
    tmpFuncName := UpperCase(AFunctionName);
  if IsValidIdent(AFunctionName) then
    FunctionTwo.AddObject(tmpFuncName, TObject(@Func))
  else
    raise EBadName.Create(AFunctionName);
end;

procedure TCustomParser.ClearVariables;
var
  i: integer;
  APPFloat: PParserFloat;
//  AString: string; { disregard stack consumption }
begin
  with FVariables do
  begin
    i := Count;
    while i > 0 do
    begin
      dec(i);
//      AString := Strings[i];
      APPFloat := PParserFloat(Objects[i]);
      if APPFloat <> nil then
        dispose( APPFloat ); { dispose only user-defined variables }
    end;

    Clear;
  end;
  SetExpression(''); { invalidate expression }
end;

procedure TCustomParser.ClearVariable(const AVarName: string);
var
  index: integer;
begin
  index := 0;
  with FVariables do
  begin
    if Find(AVarName, index) then
    begin
      dispose( PParserFloat(Objects[index]) ); 

      Delete(index);
    end;
  end;

  SetExpression(''); { invalidate expression }
end;

function TCustomParser.VariableExists(const AVarName: string): boolean;
var
  index: integer;
  tmpVarName : string;
begin
  index := 0;
  if CaseSensitive then
    tmpVarName := AVarName
  else
    tmpVarName := UpperCase(AVarName);
  Result := FVariables.Find(tmpVarName, index);
end;

procedure TCustomParser.ClearFunctions;
begin
  FunctionOne.Clear;
  FunctionTwo.Clear;

  SetExpression(''); { invalidate expression }
end;

procedure TCustomParser.ClearFunction(const AFunctionName: string);
var
  index: integer;
begin
  index := 0;
  with FunctionOne do
  begin
    if Find(AFunctionName, index) then
    begin
      Delete(index);
      SetExpression(''); { invalidate expression }
      exit;
    end;
  end;

  with FunctionTwo do
  begin
    if Find(AFunctionName, index) then
    begin
      Delete(index);
      SetExpression(''); { invalidate expression }
    end;
  end;
end;


procedure TCustomParser.FreeExpression;
var
  LastOP,
  NextOP: PExpOperation;
begin
  LastOP := FStartOperationList;

  while LastOP <> nil do
  begin
    NextOP := LastOP^.NextOperation;

    while NextOP <> nil do
      with NextOP^ do
      begin
        if (Arg1 = lastop^.Arg1) or (Arg1 = lastop^.Arg2) or (Arg1 = lastop^.Dest) then
          Arg1 := nil;

        if (Arg2 = lastop^.Arg1) or (Arg2 = lastop^.Arg2) or (Arg2 = lastop^.Dest) then
          Arg2 := nil;

        if (Dest = lastop^.Arg1) or (Dest = lastop^.Arg2) or (Dest = lastop^.Dest) then
          Dest := nil;

        NextOP := NextOperation;
      end;

    with LastOP^, FVariables do
    begin
      if IndexOfObject( TObject(Arg1)) >= 0 then Arg1 := nil;
      if IndexOfObject( TObject(Arg2)) >= 0 then Arg2 := nil;
      if IndexOfObject( TObject(Dest)) >= 0 then Dest := nil;

      if (Dest <> nil) and (Dest <> Arg2) and (Dest <> Arg1) then
        dispose(Dest);

      if (Arg2 <> nil) and (Arg2 <> Arg1) then
        dispose(Arg2);

      if (Arg1 <> nil) then
        dispose(Arg1);
    end;

    NextOP := LastOP^.NextOperation;
    dispose(LastOP);
    LastOP := NextOP;
  end;

  FStartOperationList := nil;
end;

procedure TCustomParser.SetExpression(const AnExpression: string);
begin
  ParseExpression(AnExpression); { this implies FExpression := AnExpression }
end;


function TCustomParser.CalcValue: extended;
var
  LastOP: PExpOperation;
begin
  if FStartOperationList <> nil then
  begin
    LastOP := FStartOperationList;

    while LastOP^.NextOperation <> nil do
    begin
      with LastOP^ do
      begin
        Operation(LastOP);
        LastOP := NextOperation;
      end;
    end;
    LastOP^.Operation(LastOP);

    Result := LastOP^.Dest^;
  end
  else
    Result := 0;
end;


{****************************************************************}
{                                                                }
{   TExpParser                                                }
{                                                                }
{****************************************************************}
constructor TExpParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  with FunctionOne do
  begin
{.$DEFINE SpeedCompare} { compare speed against older versions with less functions }

    AddObject('tan', TObject(@_tan));
    AddObject('sin', TObject(@_sin));
    AddObject('cos', TObject(@_cos));
    AddObject('sinh', TObject(@_sinh));
    AddObject('cosh', TObject(@_cosh));
    AddObject('arctan', TObject(@_arctan));
{$IFNDEF SpeedCompare}
    AddObject('cotan', TObject(@_cotan));
    AddObject('arg', TObject(@_arg));
{$ENDIF}

    AddObject('exp', TObject(@_exp));
    AddObject('ln', TObject(@_ln));
{$IFNDEF SpeedCompare}
    AddObject('log10', TObject(@_log10));
    AddObject('log2', TObject(@_log2));

    AddObject('sqr', TObject(@_square));
{$ENDIF}
    AddObject('sqrt', TObject(@_sqrt));

    AddObject('abs', TObject(@_abs));
{$IFNDEF SpeedCompare}
    AddObject('trunc', TObject(@_trunc));
    AddObject('int', TObject(@_trunc)); { NOTE: INT = TRUNC ! }
    AddObject('ceil', TObject(@_ceil));
    AddObject('floor', TObject(@_floor));
{$ENDIF}

    AddObject('heav', TObject(@_heaviside));
    AddObject('sign', TObject(@_sign));
    AddObject('zero', TObject(@_zero));
    AddObject('ph', TObject(@_phase));
    AddObject('rnd', TObject(@_rnd));
{$IFNDEF SpeedCompare}
    AddObject('random', TObject(@_random));
{$ENDIF}
  end;

  with FunctionTwo do
  begin

    AddObject('max', TObject(@_max));
    AddObject('min', TObject(@_min));

{$IFNDEF SpeedCompare}
    AddObject('power', TObject(@_Power));
    AddObject('intpower', TObject(@_IntPower));

    AddObject('logn', TObject(@_logN));
{$ENDIF}
  end;
end;


class function TExpParser.RemoveBlanks(const s: string): string;
{deletes all blanks in s}
var
  i : integer;
begin
  Result := s;

  i := pos(' ', Result);
  while i > 0 do
  begin
    delete(Result, i, 1);
    i := pos(' ', Result);
  end;
end;

procedure TCustomParser.SetCaseSensitive(const Value: boolean);
begin
  fCaseSensitive := Value;
  FVariables.CaseSensitive  := fCaseSensitive;
  FunctionOne.CaseSensitive := fCaseSensitive;
  FunctionTwo.CaseSensitive := fCaseSensitive;
end;

procedure TCustomParser.SetSilentExpression(const Value: string);
begin
  Silent := True;
  try
    Expression := Value;
  finally
    Silent := False; // make sure it is turned off again
  end;
end;

function TCustomParser.GetSilentExpression: string;
begin
  Result := Expression;
end;

initialization
  Randomize;

end.