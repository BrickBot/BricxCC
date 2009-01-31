unit mwPatternReader;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

(*
  KeyWords:
  Any, Not, Or

*)

const
  ckComma = ',';
  ckDollar = '$';
  ckDot = '.';
  ckNull = #0;
  ckQuestionMark = '?';
  ckQuotationMark = #39;
  ckRoundOpen = '(';
  ckRoundClose = ')';
  ckSharp = '#';
  ckSquareOpen = '[';
  ckSquareClose = ']';
  ckStar = '*';


type

  TmwSymbolKind = (
    skAlpha, // ['A'..'Z','a'..'z']
    skChar,
    skComma, // ','
    skDollar, // '$'
    skDot, // '.'
    skDoubleDott, // '..'
    skNull, // #0
    skNumber, // ['0'..'9']
    skPlus, // '+'
    skQuestionMark, // '?'
    skQuotationMark, // #39
    skRoundOpen, // '('
    skRoundClose, // ')'
    skSharp, // '#'
    skSquareOpen, // '['
    skSquareClose, // ']'
    skStar, // '*'
    skString
    );

  TmwPatternError = (
    peUnterminatedString
    );

  TmwPatternErrorEvent = procedure(Sender: TObject; Error: TmwPatternError;
    EStart, EEnd: Word) of object;

  TmwPatternReader = class(TObject)
  private
    Origin: PChar;
    Run: Word;
    Start: Word;
    FToken: string;
    FSymbol: TmwSymbolKind;
    FOnError: TmwPatternErrorEvent;
    FValue: Word;
    procedure ApplyAlpha;
    procedure ApplyComma;
    procedure ApplyDollar;
    procedure ApplyDot;
    procedure ApplyNumber;
    procedure ApplyPlus;
    procedure ApplyQuestionMark;
    procedure ApplyQuotationMark;
    procedure ApplyRoundOpen;
    procedure ApplyRoundClose;
    procedure ApplySharp;
    procedure ApplySquareOpen;
    procedure ApplySquareClose;
    procedure ApplyStar;
    function GetFinished: Boolean;
    procedure SkipSpace;
    procedure SetInput(const Value: string);
    function GetInput: string;
    function GetTokenLen: Word;
  public
    procedure Next;
    procedure Reset;
    property Finished: Boolean read GetFinished;
    property Symbol: TmwSymbolKind read FSymbol;
    property Input: string read GetInput write SetInput;
    property Token: string read FToken;
    property TokenLen: Word read GetTokenLen;
    property Value: Word read FValue;
    property OnError: TmwPatternErrorEvent read FOnError write FOnError;
  end;

implementation

{ TmwPatternReader }

procedure TmwPatternReader.ApplyAlpha;
begin
  FSymbol := skAlpha;
  while (Origin[Run] <> #0)
    and (Origin[Run] in ['A'..'Z', 'a'..'z']) do
  begin
    FToken := FToken + Origin[Run];
    inc(Run)
  end;
end;

procedure TmwPatternReader.ApplyComma;
begin
  FSymbol := skComma;
end;

procedure TmwPatternReader.ApplyDollar;
begin
  FSymbol := skDollar;
end;

procedure TmwPatternReader.ApplyDot;
begin
  FSymbol := skDot;
  FToken := '.';
end;

procedure TmwPatternReader.ApplyNumber;
begin
  FSymbol := skNumber;
  while (Origin[Run] <> #0)
    and (Origin[Run] in ['0'..'9']) do
  begin
    FToken := FToken + Origin[Run];
    inc(Run)
  end;
  FValue := StrToInt(Token);
end;

procedure TmwPatternReader.ApplyPlus;
begin
  FSymbol := skPlus;
end;

procedure TmwPatternReader.ApplyQuestionMark;
begin
  FSymbol := skQuestionMark
end;

procedure TmwPatternReader.ApplyQuotationMark;
var
  QuotationMarkCount: Integer;
begin
  QuotationMarkCount := 1;
  FSymbol := skString;
  inc(Run);
  while Odd(QuotationMarkCount) do
  begin
    case Origin[Run] of
      #0, #10, #13:
        begin
          if Assigned(FOnError) then
            FOnError(Self, peUnterminatedString, Start, Run);
          break;
        end;
      #39:
        begin
          FToken := FToken + #39;
          inc(QuotationMarkCount);
          if (Origin[Run + 1] = #39) then
          begin
            inc(QuotationMarkCount);
            inc(Run);
          end;
        end;
    else inc(Run);
    end;
  end;
  if Origin[Run] = #39 then inc(Run);
  if TokenLen = 1 then FSymbol := skChar;
end;

procedure TmwPatternReader.ApplyRoundClose;
begin
  FSymbol := skRoundClose;
end;

procedure TmwPatternReader.ApplyRoundOpen;
begin
  FSymbol := skRoundOpen;
end;

procedure TmwPatternReader.ApplySharp;
var
  Temp: string;
  aStart: Word;
begin
  FSymbol := skChar;
  Temp := '';
  inc(Run);
  aStart := Run;
  while (Origin[Run] <> #0)
    and (Origin[Run] in ['0'..'9']) do
  begin
    Temp := Temp + Origin[Run];
    inc(Run);
    if TokenLen = 3 then break;
  end;
  FToken := Char(StrToInt(Temp));
end;

procedure TmwPatternReader.ApplySquareClose;
begin
  FSymbol := skSquareClose;
end;

procedure TmwPatternReader.ApplySquareOpen;
begin
  FSymbol := skSquareOpen;
end;

procedure TmwPatternReader.ApplyStar;
begin
  FSymbol := skStar;
end;

function TmwPatternReader.GetFinished: Boolean;
begin
  Result := Origin[Run] = #0;
end;

function TmwPatternReader.GetInput: string;
begin
  Result := Origin;
end;

function TmwPatternReader.GetTokenLen: Word;
begin
  Result := Length(FToken);
end;

procedure TmwPatternReader.Next;
begin
  Start := Run;
  FToken := '';
  FValue := 0;
  if Finished then Exit;
  case Origin[Run] of
    #0:
      begin
        fSymbol := skNull;
        Exit;
      end;
    ',': ApplyComma;
    '$': ApplyDollar;
    '.': ApplyDot;
    '+': ApplyPlus;
    '?': ApplyQuestionMark;
    #39: ApplyQuotationMark;
    '(': ApplyRoundOpen;
    ')': ApplyRoundClose;
    '#': ApplySharp;
    '[': ApplySquareOpen;
    ']': ApplySquareClose;
    '*': ApplyStar;
    '0'..'9': ApplyNumber;
    'A'..'Z', 'a'..'z': ApplyAlpha;
  else
    begin
      FSymbol := skChar;
      FToken := Origin[Run];
    end;
  end;
  SkipSpace;
end;

procedure TmwPatternReader.Reset;
begin
  Run := 0;
end;

procedure TmwPatternReader.SetInput(const Value: string);
begin
  Reset;
  Origin := PChar(Value);
  SkipSpace;
end;

procedure TmwPatternReader.SkipSpace;
begin
  while (Origin[Run] <> #0)
    and (Origin[Run] in [#1..#32]) do inc(Run);
end;

end.

