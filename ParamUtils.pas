unit ParamUtils;

interface

uses
  Classes;

function ParamSwitch(S: String; bIgnoreCase : Boolean = true; const cmdLine : string = ''): Boolean;
function ParamValue(S: String; bIgnoreCase : Boolean = true; const cmdLine : string = ''): String;
function ParamIntValue(S: String; def : Integer = -1; bIgnoreCase : Boolean = true; const cmdLine : string = ''): Integer;
function JCHParamStr(Index: Integer; const cmdLine : string = ''): string;
function JCHParamCount(const cmdLine : string = ''): Integer;
function getFilenameParam(const cmdLine : string = '') : string;
procedure LoadParamDefinitions(aStrings : TStrings; const cmdLine : string = '');

implementation

uses
  SysUtils;

function CharNext(P : PChar) : PChar;
begin
  Result := P;
  Inc(Result);
end;

function GetParamStr(P: PChar; var Param: string): PChar;
var
  i, Len: Integer;
  Start, S, Q: PChar;
begin
  while True do
  begin
    while (P[0] <> #0) and (P[0] <= ' ') do
      P := CharNext(P);
    if (P[0] = '"') and (P[1] = '"') then Inc(P, 2) else Break;
  end;
  Len := 0;
  Start := P;
  while P[0] > ' ' do
  begin
    if P[0] = '"' then
    begin
      P := CharNext(P);
      while (P[0] <> #0) and (P[0] <> '"') do
      begin
        Q := CharNext(P);
        Inc(Len, Q - P);
        P := Q;
      end;
      if P[0] <> #0 then
        P := CharNext(P);
    end
    else
    begin
      Q := CharNext(P);
      Inc(Len, Q - P);
      P := Q;
    end;
  end;

  SetLength(Param, Len);

  P := Start;
  S := Pointer(Param);
  i := 0;
  while P[0] > ' ' do
  begin
    if P[0] = '"' then
    begin
      P := CharNext(P);
      while (P[0] <> #0) and (P[0] <> '"') do
      begin
        Q := CharNext(P);
        while P < Q do
        begin
          S[i] := P^;
          Inc(P);
          Inc(i);
        end;
      end;
      if P[0] <> #0 then P := CharNext(P);
    end
    else
    begin
      Q := CharNext(P);
      while P < Q do
      begin
        S[i] := P^;
        Inc(P);
        Inc(i);
      end;
    end;
  end;

  Result := P;
end;

function JCHParamStr(Index: Integer; const cmdLine : string): string;
var
  P: PChar;
begin
  Result := '';
  if (Index = 0) or (cmdLine = '') then
    Result := ParamStr(Index)
  else
  begin
    P := PChar(cmdLine);
    while True do
    begin
      P := GetParamStr(P, Result);
      if (Index = 0) or (Result = '') then Break;
      Dec(Index);
    end;
  end;
end;

function JCHParamCount(const cmdLine : string): Integer;
var
  P: PChar;
  S: string;
begin
  Result := 0;
  S := '';
  if cmdLine = '' then
    Result := ParamCount
  else
  begin
    P := GetParamStr(PChar(cmdLine), S);
    while True do
    begin
      P := GetParamStr(P, S);
      if S = '' then Break;
      Inc(Result);
    end;
  end;
end;

function ParamSwitch(S: String; bIgnoreCase : Boolean; const cmdLine : string): Boolean;
var
  I: Integer;
  P: String;
begin
  Result := False ;
  if bIgnoreCase then S := UpperCase(S);
  for I := 0 to JCHParamCount(cmdLine) do begin
    P := JCHParamStr(I, cmdLine);
    if bIgnoreCase then P := UpperCase(P);
    if (P=S) or (Pos(S+'=',P)=1) then begin
      Result := True ;
      Break;
    end;
  end;
end;

function ParamValue(S: String; bIgnoreCase : Boolean; const cmdLine : string): String;
var
  I : Integer;
  P, val: String;
begin
  Result := '' ;
  if bIgnoreCase then S := UpperCase(S);
  for I := 0 to JCHParamCount(cmdLine) do begin
    val := JCHParamStr(I, cmdLine);
    if bIgnoreCase then
      P := UpperCase(val)
    else
      P := val;
    if (Pos(S+'=',P)<>0) then begin
      Result := Copy(val,Length(S)+2,MaxInt);
      Break;
    end;
  end;
end;

function ParamIntValue(S: String; def : integer; bIgnoreCase : Boolean; const cmdLine : string): Integer;
begin
  Result := StrToIntDef(ParamValue(S, bIgnoreCase, cmdLine), def);
end;

function getFilenameParam(const cmdLine : string) : string;
var
  i : Integer;
  tmp : string;
begin
  Result := '';
  for i := 1 to JCHParamCount(cmdLine) do
  begin
    tmp := JCHParamStr(i, cmdLine);
    if Pos('-', tmp) = 1 then Continue; // a switch
    if FileExists(tmp) then
    begin
      Result := tmp;
      Break;
    end;
  end;
end;

procedure LoadParamDefinitions(aStrings : TStrings; const cmdLine : string);
var
  I : Integer;
  P: String;
begin
  for I := 0 to JCHParamCount(cmdLine) do begin
    P := JCHParamStr(I, cmdLine);
    if Pos('-D=', P) = 1 then begin
      // this is a #define
      System.Delete(P, 1, 3);
      if Pos('=', P) = 0 then
        P := P + '=1';
      aStrings.Add(P);
    end;
  end;
end;

end.
