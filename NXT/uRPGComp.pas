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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uRPGComp;

interface

uses
  Classes;

type
  TOnCompilerMessage = procedure(const msg : string; var stop : boolean) of object;

  TMainState = (msNormal, msBlockComment);

  TRPGComp = class
  private
    fMainStateLast : TMainState;
    fMainStateCurrent : TMainState;
    fCommands : TStrings;
    fCurFile: string;
    fMsgs: TStrings;
    fBadProgram : boolean;
    fProgErrorCount : integer;
    fLineCounter : integer;
    fOnCompMSg: TOnCompilerMessage;
    fCheckEOPLine : boolean;
    fMaxCommands: integer;
    fMaxErrors: word;
    procedure ProcessRPGLine(line : string);
    procedure ReportProblem(const lineNo: integer; const fName, line,
      msg: string; err: boolean);
    function ValidCommand(const line : string) : boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Parse(aStream : TStream); overload;
    procedure Parse(aStrings : TStrings); overload;
    function SaveToStream(aStream : TStream) : boolean;
    property CompilerMessages : TStrings read fMsgs;
    property CurrentFile : string read fCurFile write fCurFile;
    property MaxCommands : integer read fMaxCommands write fMaxCommands;
    property MaxErrors : word read fMaxErrors write fMaxErrors;
    property OnCompilerMessage : TOnCompilerMessage read fOnCompMSg write fOnCompMsg;
  end;

implementation

uses
  SysUtils, uStreamRW, uLocalizedStrings;

{ TRPGComp }

constructor TRPGComp.Create;
begin
  fMsgs := TStringList.Create;
  fCommands := TStringList.Create;
  fMaxCommands := 5;
  fMaxErrors := 0;
end;

destructor TRPGComp.Destroy;
begin
  FreeAndNil(fMsgs);
  FreeAndNil(fCommands);
  inherited;
end;

procedure TRPGComp.Parse(aStream: TStream);
var
  S : TStrings;
begin
  S := TStringList.Create;
  try
    S.LoadFromStream(aStream);
    Parse(S);
  finally
    S.Free;
  end;
end;

procedure TRPGComp.Parse(aStrings: TStrings);
var
  i : integer;
begin
  try
    fCommands.Clear;
    fBadProgram       := False;
    fProgErrorCount   := 0;
    fLineCounter      := 0;
    fMainStateLast    := msNormal;
    fMainStateCurrent := msNormal;
    fCheckEOPLine     := False;
    for i := 0 to aStrings.Count - 1 do
    begin
      inc(fLineCounter);
      ProcessRPGLine(aStrings[i]);
    end;
  except
    on E : EAbort do
    begin
      fBadProgram := True;
      // end processing file due to Abort in ReportProblem
    end;
    on E : Exception do
    begin
      fBadProgram := True;
      ReportProblem(fLineCounter, CurrentFile, sException, E.Message, true);
    end;
  end;
end;

(*
typedef   struct
{
  UBYTE   FormatMsb;
  UBYTE   FormatLsb;
  UBYTE   DataBytesMsb;
  UBYTE   DataBytesLsb;
  UBYTE   Steps;
  UBYTE   NotUsed1;
  UBYTE   NotUsed2;
  UBYTE   NotUsed3;
  UBYTE   Data[];
}
PROGRAM;

*)

const
  FILEFORMAT_PROGRAM  = $0800;

  cmdTypeEmptyMove      = $21;
  cmdTypeForward        = $22;
  cmdTypeForwardFive    = $23;
  cmdTypeBackLeftTwo    = $24;
  cmdTypeTurnLeft       = $25;
  cmdTypeTurnLeftTwo    = $26;
  cmdTypeBackRight      = $27;
  cmdTypeTurnRight      = $28;
  cmdTypeTurnRightTwo   = $29;
  cmdTypeBackLeft       = $2A;
  cmdTypePlayTone1      = $2B;
  cmdTypePlayTone2      = $2C;
  cmdTypeBackward       = $2D;
  cmdTypeBackwardFive   = $2E;
  cmdTypeBackRightTwo   = $2F;
  cmdTypeINVALID        = $30;
  waitTypeEmptyWait       = $41;
  waitTypeWaitForLight    = $42;
  waitTypeWaitForObject   = $43;
  waitTypeWaitForSound    = $44;
  waitTypeWaitForTouch    = $45;
  waitTypeWaitTwoSeconds  = $46;
  waitTypeWaitFiveSeconds = $47;
  waitTypeWaitTenSeconds  = $48;
  waitTypeWaitForDark     = $49;
//  waitTypeINVALID       = $4A;
  eopLOOP               = $FC;
  eopSTOP               = $FB;

type
  RPGCommand = record
    Name : string;
    Value : byte;
  end;

const
  RPG_COMMAND_COUNT = 26;
  RPGCommands : array[0..RPG_COMMAND_COUNT - 1] of RPGCommand = (
    (Name : 'EmptyMove';       Value : cmdTypeEmptyMove;),
    (Name : 'Forward';         Value : cmdTypeForward;),
    (Name : 'ForwardFive';     Value : cmdTypeForwardFive;),
    (Name : 'BackLeftTwo';     Value : cmdTypeBackLeftTwo;),
    (Name : 'TurnLeft';        Value : cmdTypeTurnLeft;),
    (Name : 'TurnLeftTwo';     Value : cmdTypeTurnLeftTwo;),
    (Name : 'BackRight';       Value : cmdTypeBackRight;),
    (Name : 'TurnRight';       Value : cmdTypeTurnRight;),
    (Name : 'TurnRightTwo';    Value : cmdTypeTurnRightTwo;),
    (Name : 'BackLeft';        Value : cmdTypeBackLeft;),
    (Name : 'PlayToneOne';     Value : cmdTypePlayTone1;),
    (Name : 'PlayToneTwo';     Value : cmdTypePlayTone2;),
    (Name : 'Backward';        Value : cmdTypeBackward;),
    (Name : 'BackwardFive';    Value : cmdTypeBackwardFive;),
    (Name : 'BackRightTwo';    Value : cmdTypeBackRightTwo;),
    (Name : 'EmptyWait';       Value : waitTypeEmptyWait;),
    (Name : 'WaitForLight';    Value : waitTypeWaitForLight;),
    (Name : 'WaitForObject';   Value : waitTypeWaitForObject;),
    (Name : 'WaitForSound';    Value : waitTypeWaitForSound;),
    (Name : 'WaitForTouch';    Value : waitTypeWaitForTouch;),
    (Name : 'WaitTwoSeconds';  Value : waitTypeWaitTwoSeconds;),
    (Name : 'WaitFiveSeconds'; Value : waitTypeWaitFiveSeconds;),
    (Name : 'WaitTenSeconds';  Value : waitTypeWaitTenSeconds;),
    (Name : 'WaitForDark';     Value : waitTypeWaitForDark;),
    (Name : 'EndLoop';         Value : eopLOOP;),
    (Name : 'EndStop';         Value : eopSTOP;)
  );


function NameToValue(const name : string) : byte;
var
  i : integer;
begin
  Result := cmdTypeINVALID;
  for i := Low(RPGCommands) to High(RPGCommands) do
  begin
    if LowerCase(RPGCommands[i].Name) = LowerCase(name) then
    begin
      Result := RPGCommands[i].Value;
      break;
    end;
  end;
end;

function TRPGComp.SaveToStream(aStream: TStream) : boolean;
var
  w : word;
  b : byte;
  i : integer;
begin
  Result := False;
  if fBadProgram then
  begin
    ReportProblem(-1, CurrentFile, '', Format(sProgramError, [fProgErrorCount]), true)
  end
  else
  begin
    // and write everything to the stream
    aStream.Position := 0;
    w := FILEFORMAT_PROGRAM;
    WriteWord(aStream, w, False);
    w := Word(fCommands.Count);
    WriteWord(aStream, w, False);
    b := Byte(w);
    aStream.Write(b, 1);
    // three bytes of zero
    b := 0;
    aStream.Write(b, 1);
    aStream.Write(b, 1);
    aStream.Write(b, 1);
    for i := 0 to fCommands.Count - 1 do
    begin
      b := NameToValue(fCommands[i]);
      aStream.Write(b, 1);
    end;
    Result := True;
  end;
end;

procedure TRPGComp.ReportProblem(const lineNo: integer; const fName, line,
  msg: string; err : boolean);
var
  tmp, tmp1, tmp2, tmp3, tmp4 : string;
  stop : boolean;
begin
  if lineNo = -1 then
  begin
    tmp := msg;
    fMsgs.Add(tmp);
  end
  else
  begin
    if err then
      tmp1 := Format('# Error: %s', [msg])
    else
      tmp1 := Format('# Warning: %s', [msg]);
    fMsgs.Add(tmp1);
    tmp2 := Format('File "%s" ; line %d', [fName, lineNo]);
    fMsgs.Add(tmp2);
    tmp3 := Format('#   %s', [line]);
    fMsgs.Add(tmp3);
    tmp4 := '#----------------------------------------------------------';
    fMsgs.Add(tmp4);
    tmp := tmp1+#13#10+tmp2+#13#10+tmp3+#13#10+tmp4;
  end;
  fBadProgram := err;
  if err then
    inc(fProgErrorCount);
  stop := (MaxErrors > 0) and (fProgErrorCount >= MaxErrors);
//  stop := false;
  if assigned(fOnCompMsg) then
    fOnCompMsg(tmp, stop);
  if stop then
    Abort;
end;

procedure TRPGComp.ProcessRPGLine(line: string);
var
  i, endBCPos : integer;
  inBlockComment : boolean;
  lowline : string;
begin
  line := Trim(line);
  // do nothing if line is blank or a comment
  if (line = '') or (Pos(';', line) = 1) or (Pos('//', line) = 1) then
    Exit;
  // check for the possibility that we are starting or ending a block comment on this line
  // nesting block comments is not supported and will result in compiler errors
  i := Pos('/*', line);
  endBCPos := Pos('*/', line);
  if (endBCPos = 0) or ((fMainStateCurrent <> msBlockComment) and (endBCPos = 0)) then
    inBlockComment := i > 0
  else if endBCPos <> 0 then
    inBlockComment := i > endBCPos+1
  else
    inBlockComment := False;
  if (endBCPos > 0) and (fMainStateCurrent = msBlockComment) then
  begin
    // remove everything from line up to end block comment
    Delete(line, 1, endBCPos+1);
    // revert to previous state
    fMainStateCurrent := fMainStateLast;
  end;
  if inBlockComment then
  begin
    Delete(line, i, MaxInt); // delete to end of line
  end
  else if (i > 0) and (endBCPos > i+1) then
  begin
    // just remove the block comment portion of the line
    Delete(line, i, endBCPos-i+2);
    // we don't want a block comment remove to result in a valid
    // identifier or function
    Insert(' ', line, i);
  end;
  // if we were already in a block comment before starting this line
  // and we still are in a block comment after the above processing
  // then we can skip the rest of this routine
  if fMainStateCurrent = msBlockComment then
    Exit;
  // double check for a blank line since we have manipulated it
  if Trim(line) <> '' then
  begin
    if fCheckEOPLine then
    begin
      ReportProblem(fLineCounter, CurrentFile, line, sNothingAfterEnd, true);
    end
    else
    begin
      if fCommands.Count >= MaxCommands then
        ReportProblem(fLineCounter, CurrentFile, line, sTooManyCommands, true)
      else
      begin
        i := Pos(';', line);
        if i <> 0 then
          System.Delete(line, i, MaxInt);
        i := Pos('//', line);
        if i <> 0 then
          System.Delete(line, i, MaxInt);
        if ValidCommand(line) then
        begin
          lowline := LowerCase(line);
          fCommands.Add(lowline);
          if (lowline = 'endloop') or (lowline = 'endstop') then
            fCheckEOPLine := True;
        end
        else
        begin
          ReportProblem(fLineCounter, CurrentFile, line, sUnknownCommand, true);
        end;
      end;
    end;
  end;
end;

function TRPGComp.ValidCommand(const line: string): boolean;
var
  i : integer;
begin
  Result := False;
  for i := Low(RPGCommands) to High(RPGCommands) do
  begin
    if LowerCase(RPGCommands[i].Name) = LowerCase(line) then
    begin
      Result := True;
      break;
    end;
  end;
end;

end.