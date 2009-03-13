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
unit rcx_cmd;

interface

uses
  Classes, rcx_constants;
  
const
  kRCX_Cmd_MaxShortLength	= 8;

type
  // rcx fragment type
  TRcxFragment = (kRCX_TaskFragment, kRCX_SubFragment);
  // variable code
  TRcxVarCode = (kRCX_SetVar, kRCX_AddVar, kRCX_SubVar, kRCX_DivVar,
    kRCX_MulVar, kRCX_SgnVar, kRCX_AbsVar, kRCX_AndVar, kRCX_OrVar);

  TBaseCmd = class
  protected
    fLength : integer;
    fBodyPtr : PByte;
    fBodyData : array [0..kRCX_Cmd_MaxShortLength] of Byte;
    function MakeValue16(opcode : Byte; value : integer) : TBaseCmd;
    function MakeValue8(opcode : Byte; value : integer) : TBaseCmd;
    procedure ClearBodyPointer;
  protected
    fLog : string;
    procedure WriteToLog(s : string);
  public
    constructor Create;
    destructor Destroy; override;

    function GetLength : integer;
    function GetBody : PByte;
    function CopyOut(dst : PByte) : integer;
    procedure SetLength(length : integer);

    function SetVal(data : PByte; length : integer) : TBaseCmd; overload;
    function SetVal(d0 : Byte) : TBaseCmd; overload;
    function SetVal(d0, d1 : Byte) : TBaseCmd; overload;
    function SetVal(d0, d1, d2 : Byte) : TBaseCmd; overload;
    function SetVal(d0, d1, d2, d3 : Byte) : TBaseCmd; overload;
    function SetVal(d0, d1, d2, d3, d4 : Byte) : TBaseCmd; overload;
    function SetVal(d0, d1, d2, d3, d4, d5 : Byte) : TBaseCmd; overload;
    function SetVal(d0, d1, d2, d3, d4, d5, d6: Byte): TBaseCmd; overload;

    procedure Print;
    property Log : string read fLog;
  end;

  TNxtCmd = class(TBaseCmd)
  public
    function MakeCmdWriteFile(const b1, b2 : byte; const handle : byte;
      const Count : Word; Data : array of Byte) : TNxtCmd;
    function MakeCmdWithFilename(const b1, b2 : byte; const filename : string;
      const filesize : Cardinal = 0) : TNxtCmd;
    function MakeCmdRenameFile(const b1 : byte; const old, new : string) : TNxtCmd;
    function MakeBoot(bResponse : boolean) : TNxtCmd;
    function MakeSetName(const name : string; bResponse : boolean) : TNxtCmd;
    function MakeCmdWriteIOMap(const b1, b2 : byte; const ModID : Cardinal;
      const Offset, Count : Word; Data : array of Byte) : TNxtCmd;
    function MakeCmdReadIOMap(const b1, b2 : byte; const ModID : Cardinal;
      const Offset, Count : Word) : TNxtCmd;
    function MakeSetOutputState(port, mode, regmode, runstate : byte;
      power, turnratio : shortint; tacholimit : cardinal; bResponse : boolean) : TNxtCmd;
  end;

  TNINxtCmd = class(TNxtCmd)
  public
    function BytePtr : PByte;
    function Len : integer;
  end;

  TRcxCmd = class(TBaseCmd)
  private
  protected
    procedure SetOffset(offset : integer);
    function DirSpeed(val : integer) : Byte;
  public
    // utility functions to create specific commands
    // variables
    function  MakeVar(code : TRcxVarCode; myvar : Byte; value : integer) : TRcxCmd;

    // outputs
    function  MakeOutputMode(outputs : Byte; mode : integer) : TRcxCmd;
    function  MakeOutputPower(outputs : Byte; value : integer) : TRcxCmd;
    function  MakeOutputDir(outputs : Byte; dir : integer) : TRcxCmd;

    // inputs
    function 	MakeInputMode(input : Byte; mode : integer) : TRcxCmd;
    function 	MakeInputType(input : Byte; itype : integer) : TRcxCmd;

    // sound
    function  MakePlaySound(sound : Byte) : TRcxCmd;
    function  MakePlayTone(freq : Word; duration : Byte) : TRcxCmd;

    // control flow
    function  MakeTest(v1 : integer; rel : integer; v2 : integer; offset : smallint) : TRcxCmd;
    function  MakeJump(offset : smallint) : TRcxCmd;
    function  MakeSetLoop(v : integer) : TRcxCmd;
    function  MakeCheckLoop(offset : smallint) : TRcxCmd;

    // cybermaster stuff
    function MakeDrive(m0, m1 : integer) : TRcxCmd;
    function MakeOnWait(outputs : Byte; aNum : integer; aTime : Byte) : TRcxCmd;
    function MakeOnWaitDifferent(outputs : Byte; aNum0, aNum1, aNum2 : integer; aTime : Byte) : TRcxCmd;

    // misc
    function  MakeStopTask(task : Byte) : TRcxCmd;
    function  MakeWait(value : integer) : TRcxCmd;
    function  MakeDisplay(value : integer) : TRcxCmd; overload;
    function  MakeDisplay(src, value : integer) : TRcxCmd; overload;
    function  MakeSet(dst, src : integer) : TRcxCmd;

    // system commands
    function  MakePoll(value : integer) : TRcxCmd;
    function  MakeUnlock : TRcxCmd;
    function  MakeBegin(ftype : TRcxFragment; taskNumber : Byte; length : Word) : TRcxCmd;
    function  MakeDownload(seq : Word; data : PByte; length : Word) : TRcxCmd;
    function  MakeDeleteTasks : TRcxCmd;
    function  MakeDeleteSubs : TRcxCmd;
    function  MakePing : TRcxCmd;
    function  MakeUploadDatalog(start, count : Word) : TRcxCmd;
    function  MakeSetDatalog(size : Word) : TRcxCmd;
    function  MakeBoot : TRcxCmd;

    // special command to unlock CyberMaster
    function  MakeUnlockCM : TRcxCmd;
  end;

function RCX_VALUE(t : TRcxValueType; d : smallint) : integer;

implementation

uses
  SysUtils, uCommonUtils;

function RCX_VALUE(t : TRcxValueType; d : smallint) : integer;
begin
  result := integer((t shl 16) or (d and $FFFF));
end;

function RCX_VALUE_TYPE(v : integer) : TRcxValueType;
begin
  result := Byte(smallint(v shr 16) and $FF);
end;

function RCX_VALUE_DATA(v : integer) : smallint;
begin
  result := smallint(v and $FFFF);
end;

function kRCX_VarOp(code : TRcxVarCode) : integer;
begin
  result := $14 + (Ord(code) * 16);
end;

{ TBaseCmd }

procedure TBaseCmd.ClearBodyPointer;
begin
  if fLength > kRCX_Cmd_MaxShortLength then
    FreeMem(fBodyPtr, fLength);
end;

function TBaseCmd.CopyOut(dst: PByte): integer;
var
  tmp : PByte;
begin
  tmp := GetBody;
  Move(tmp^, dst^, fLength);
  result := fLength;
end;

constructor TBaseCmd.Create;
begin
  inherited Create;
  fLog := '';
  fLength := 0;
end;

destructor TBaseCmd.Destroy;
begin
  ClearBodyPointer;
  inherited Destroy;
end;

function TBaseCmd.MakeValue16(opcode: Byte; value: integer): TBaseCmd;
var
  data : SmallInt;
begin
  data := RCX_VALUE_DATA(value);
  result := SetVal(opcode, Byte(RCX_VALUE_TYPE(value)), Lo(data), Hi(data));
end;

function TBaseCmd.MakeValue8(opcode: Byte; value: integer): TBaseCmd;
begin
  result := SetVal(opcode, Byte(RCX_VALUE_TYPE(value)), Byte(RCX_VALUE_DATA(value)));
end;

procedure TBaseCmd.Print;
var
  ptr : PByte;
  i : integer;
  tmp : string;
begin
  ptr := GetBody;

  tmp := '';
  for i := 0 to fLength-1 do
  begin
    tmp := tmp + Format('%2x', [ptr^]);
    inc(ptr);
  end;
  WriteToLog(tmp + #13#10);
end;

procedure TBaseCmd.SetLength(length: integer);
begin
  if length = fLength then Exit;
  ClearBodyPointer;

  fLength := length;

  if fLength > kRCX_Cmd_MaxShortLength then
    fBodyPtr := AllocMem(fLength * sizeof(Byte));
end;

function TBaseCmd.SetVal(data: PByte; length: integer): TBaseCmd;
var
  tmp : PByte;
begin
  SetLength(length);
  tmp := GetBody;
  Move(data^, tmp^, length);
  result := self;
end;

function TBaseCmd.SetVal(d0: Byte): TBaseCmd;
begin
  SetLength(1);
  fBodyData[0] := d0;
  result := self;
end;

function TBaseCmd.SetVal(d0, d1: Byte): TBaseCmd;
begin
  SetLength(2);
  fBodyData[0] := d0;
  fBodyData[1] := d1;
  result := self;
end;

function TBaseCmd.SetVal(d0, d1, d2: Byte): TBaseCmd;
begin
  SetLength(3);
  fBodyData[0] := d0;
  fBodyData[1] := d1;
  fBodyData[2] := d2;
  result := self;
end;

function TBaseCmd.SetVal(d0, d1, d2, d3: Byte): TBaseCmd;
begin
  SetLength(4);
  fBodyData[0] := d0;
  fBodyData[1] := d1;
  fBodyData[2] := d2;
  fBodyData[3] := d3;
  result := self;
end;

function TBaseCmd.SetVal(d0, d1, d2, d3, d4: Byte): TBaseCmd;
begin
  SetLength(5);
  fBodyData[0] := d0;
  fBodyData[1] := d1;
  fBodyData[2] := d2;
  fBodyData[3] := d3;
  fBodyData[4] := d4;
  result := self;
end;

function TBaseCmd.SetVal(d0, d1, d2, d3, d4, d5: Byte): TBaseCmd;
begin
  SetLength(6);
  fBodyData[0] := d0;
  fBodyData[1] := d1;
  fBodyData[2] := d2;
  fBodyData[3] := d3;
  fBodyData[4] := d4;
  fBodyData[5] := d5;
  result := self;
end;

function TBaseCmd.SetVal(d0, d1, d2, d3, d4, d5, d6: Byte): TBaseCmd;
begin
  SetLength(7);
  fBodyData[0] := d0;
  fBodyData[1] := d1;
  fBodyData[2] := d2;
  fBodyData[3] := d3;
  fBodyData[4] := d4;
  fBodyData[5] := d5;
  fBodyData[6] := d6;
  result := self;
end;

procedure TBaseCmd.WriteToLog(s: string);
begin
  fLog := fLog + s;
end;

function TBaseCmd.GetBody: PByte;
begin
  if fLength <= kRCX_Cmd_MaxShortLength then
    result := @fBodyData[0]
  else
    result := fBodyPtr;
end;

function TBaseCmd.GetLength: integer;
begin
  result := fLength;
end;

{ TRcxCmd }

function TRcxCmd.DirSpeed(val: integer): Byte;
begin
  result := Byte((val) and 8 xor 8 or ((val)*(((val) shr 3) * 2 xor 1)) and 7);
end;

function TRcxCmd.MakeBegin(ftype: TRcxFragment; taskNumber: Byte;
  length: Word): TRcxCmd;
var
  op : Byte;
begin
  if ftype = kRCX_TaskFragment then
    op := kRCX_BeginTaskOp
  else
    op := kRCX_BeginSubOp;
  result := TRcxCmd(SetVal(op, 0, taskNumber, 0, Lo(length), Hi(length)));
end;

function TRcxCmd.MakeBoot: TRcxCmd;
begin
  SetVal(kRCX_UnlockFirmOp, $4c, $45, $47, $4f, $ae);
  // LEGO
  result := self;
end;

function TRcxCmd.MakeCheckLoop(offset: smallint): TRcxCmd;
begin
  SetVal(kRCX_CheckLoopOp, 0, 0);
  SetOffset(offset);
  result := self;
end;

function TRcxCmd.MakeWait(value: integer): TRcxCmd;
begin
  result := TRcxCmd(MakeValue16(kRCX_WaitOp, value));
end;

function TRcxCmd.MakeDeleteSubs: TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_DeleteSubsOp));
end;

function TRcxCmd.MakeDeleteTasks: TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_DeleteTasksOp));
end;

function TRcxCmd.MakeDisplay(value: integer): TRcxCmd;
begin
  result := TRcxCmd(MakeValue16(kRCX_DisplayOp, value));
end;

function TRcxCmd.MakeDisplay(src, value: integer): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_DisplayOp, Byte(src), Lo(SmallInt(value)), Hi(SmallInt(value))));
end;

function TRcxCmd.MakeDownload(seq: Word; data: PByte; length: Word): TRcxCmd;
var
  ptr : PByte;
  checksum, b : Byte;
begin
  SetLength(6 + length);

  ptr := GetBody;
  ptr^ := kRCX_DownloadOp;
  inc(ptr);
  ptr^ := Lo(seq);
  inc(ptr);
  ptr^ := Hi(seq);
  inc(ptr);
  ptr^ := Lo(length);
  inc(ptr);
  ptr^ := Hi(length);
  inc(ptr);

  checksum := 0;
  while length > 0 do
  begin
    b := data^;
    inc(data);
    checksum := Byte(checksum + b);
    ptr^ := b;
    inc(ptr);
    dec(length);
  end;

  ptr^ := checksum;
  result := self;
end;

function TRcxCmd.MakeDrive(m0, m1: integer): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_DriveOp, DirSpeed(m0) or DirSpeed(m1) shl 4));
end;

function TRcxCmd.MakeInputMode(input: Byte; mode: integer): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_InputModeOp, input, Byte(mode)));
end;

function TRcxCmd.MakeInputType(input: Byte; itype: integer): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_InputTypeOp, input, Byte(itype)));
end;

function TRcxCmd.MakeJump(offset: smallint): TRcxCmd;
var
  ptr : PByte;
begin
  SetLength(3);
  ptr := GetBody;
  ptr^ := kRCX_JumpOp;
  SetOffset(offset);
  result := self;
end;

function TRcxCmd.MakeOnWait(outputs: Byte; aNum: integer;
  aTime: Byte): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_OnWaitOp, Byte((outputs shl 4) or DirSpeed(aNum)), aTime));
end;

function TRcxCmd.MakeOnWaitDifferent(outputs: Byte; aNum0, aNum1,
  aNum2: integer; aTime: Byte): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_OnWaitDifferentOp, Byte((outputs shl 4) or DirSpeed(aNum0)),
    Byte((DirSpeed(aNum1) shl 4) or DirSpeed(aNum2)), aTime));
end;

function TRcxCmd.MakeOutputDir(outputs: Byte; dir: integer): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_OutputDirOp, Byte(dir or outputs)));
end;

function TRcxCmd.MakeOutputMode(outputs: Byte; mode: integer): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_OutputModeOp, Byte(mode or outputs)));
end;

function TRcxCmd.MakeOutputPower(outputs: Byte; value: integer): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_OutputPowerOp, outputs, Byte(RCX_VALUE_TYPE(value)), Byte(RCX_VALUE_DATA(value))));
end;

function TRcxCmd.MakePing: TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_PingOp));
end;

function TRcxCmd.MakePlaySound(sound: Byte): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_PlaySoundOp, sound));
end;

function TRcxCmd.MakePlayTone(freq: Word; duration: Byte): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_PlayToneOp, Lo(freq), Hi(freq), duration));
end;

function TRcxCmd.MakePoll(value: integer): TRcxCmd;
begin
  result := TRcxCmd(MakeValue8(kRCX_PollOp, value));
end;

function TRcxCmd.MakeSet(dst, src: integer): TRcxCmd;
var
  ptr : PByte;
begin
  SetLength(6);
  ptr := GetBody;

  ptr^ := kRCX_SetSourceValueOp;
  inc(ptr);
  ptr^ := Byte(RCX_VALUE_TYPE(dst));
  inc(ptr);
  ptr^ := Lo(RCX_VALUE_DATA(dst));
  inc(ptr);
  ptr^ := Byte(RCX_VALUE_TYPE(src));
  inc(ptr);
  ptr^ := Lo(RCX_VALUE_DATA(src));
  inc(ptr);
  ptr^ := Hi(RCX_VALUE_DATA(src));
  result := self;
end;

function TRcxCmd.MakeSetDatalog(size: Word): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_SetDatalogOp, Lo(size), Hi(size)));
end;

function TRcxCmd.MakeSetLoop(v: integer): TRcxCmd;
begin
  result := TRcxCmd(MakeValue8(kRCX_SetLoopOp, v));
end;

function TRcxCmd.MakeStopTask(task: Byte): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_StopTaskOp, task));
end;

function TRcxCmd.MakeTest(v1, rel, v2: integer; offset: smallint): TRcxCmd;
var
  d1 : SmallInt;
  ptr : PByte;
begin
  d1 := RCX_VALUE_DATA(v1);
  SetLength(8);
  ptr := GetBody;
  ptr^ := kRCX_LCheckDoOp;
  inc(ptr);
  ptr^ := Byte(((rel shl 6) or Byte(RCX_VALUE_TYPE(v1))));
  inc(ptr);
  ptr^ := Byte(RCX_VALUE_TYPE(v2));
  inc(ptr);
  ptr^ := Lo(d1);
  inc(ptr);
  ptr^ := Hi(d1);
  inc(ptr);
  ptr^ := Byte(RCX_VALUE_DATA(v2));
  SetOffset(offset);
  result := self;
end;

function TRcxCmd.MakeUnlock: TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_UnlockOp, 1, 3, 5, 7, 11));
end;

type
  MsgType = array[0..26] of Byte;

function TRcxCmd.MakeUnlockCM: TRcxCmd;
const
  unlockMsg : MsgType = (kRCX_UnlockFirmOp,
    Ord('D'),Ord('o'),Ord(' '),Ord('y'),Ord('o'),Ord('u'),
    Ord(' '),Ord('b'),Ord('y'),Ord('t'),Ord('e'),Ord(','),
    Ord(' '),Ord('w'),Ord('h'),Ord('e'),Ord('n'),Ord(' '),
    Ord('I'),Ord(' '),Ord('k'),Ord('n'),Ord('o'),Ord('c'),
    Ord('k'),Ord('?'));
var
  msg : MsgType;
begin
  msg := unlockMsg;
  SetVal(@msg[0], sizeof(unlockMsg));
  result := self;
end;

function TRcxCmd.MakeUploadDatalog(start, count: Word): TRcxCmd;
begin
  result := TRcxCmd(SetVal(kRCX_UploadDatalogOp,
    Lo(start), Hi(start),
    Lo(count), Hi(count)));
end;

function TRcxCmd.MakeVar(code: TRcxVarCode; myvar: Byte; value: integer): TRcxCmd;
var
  data : SmallInt;
begin
  data := RCX_VALUE_DATA(value);
  result := TRcxCmd(SetVal(Byte(kRCX_VarOp(code)), myvar, Byte(RCX_VALUE_TYPE(value)),
    Lo(data), Hi(data)));
end;

procedure TRcxCmd.SetOffset(offset: integer);
var
  ptr, tmp : PByte;
  neg : Byte;
begin
  neg := 0;
  offset := offset - (fLength - 2);
  ptr := GetBody;
  inc(ptr, fLength);
  dec(ptr, 2);

  tmp := GetBody;
  if tmp^ <> kRCX_JumpOp then
  begin
    ptr^ := Byte(offset and $FF);
    inc(ptr);
    ptr^ := Byte((offset shr 8) and $FF);
  end
  else
  begin
    if offset < 0 then
    begin
      neg := $80;
      offset := -offset;
    end;
    ptr^ := Byte(neg or (offset and $7F));
    inc(ptr);
    ptr^ := Byte((offset shr 7) and $FF);
  end;
end;

{ TNxtCmd }

function TNxtCmd.MakeCmdWriteFile(const b1, b2: byte; const handle : byte;
  const Count : Word; Data: array of Byte): TNxtCmd;
var
  i, n : integer;
  orig : PByte;
begin
  n := Count+3; //
  if n > kNXT_MaxBytes then
    n := kNXT_MaxBytes; // total bytes must be <= 64
  SetLength(n);
  orig := GetBody;
  orig^ := b1;
  inc(orig);
  orig^ := b2;
  inc(orig);
  orig^ := handle;
  inc(orig);
  dec(n, 3); // set n back to count (or max - 3, whichever is smaller)
  for i := Low(Data) to High(Data) do
  begin
    dec(n);
    if n < 0 then Break;
    orig^ := Data[i];
    inc(orig);
  end;
  Result := Self;
end;

function TNxtCmd.MakeCmdWithFilename(const b1, b2: byte; const filename: string;
  const filesize : cardinal): TNxtCmd;
var
  i : integer;
  orig : PByte;
begin
  // filename is limited to 19 bytes + null terminator
  if filesize > 0 then
    SetLength(26)
  else
    SetLength(22);
  orig := GetBody;
  orig^ := b1;
  inc(orig);
  orig^ := b2;
  inc(orig);
  i := 1;
  while i <= 19 do
  begin
    // copy the first nineteen bytes from the filename provided
    if i > Length(filename) then
      orig^ := 0
    else
      orig^ := Ord(filename[i]);
    inc(orig);
    inc(i);
  end;
  orig^ := 0; // set last byte to null
  inc(orig);
  if filesize > 0 then
  begin
    orig^ := Byte(Word(filesize));
    inc(orig);
    orig^ := HiByte(Word(filesize));
    inc(orig);
    orig^ := Byte(HiWord(filesize));
    inc(orig);
    orig^ := HiByte(HiWord(filesize));
  end;
  Result := Self;
end;

function TNxtCmd.MakeBoot(bResponse : boolean) : TNxtCmd;
var
  i : integer;
  orig : PByte;
const
  bootCmd = 'Let''s dance: SAMBA';
begin
  SetLength(21);
  orig := GetBody;
  if bResponse then
    orig^ := kNXT_SystemCmd
  else
    orig^ := kNXT_SystemCmdNoReply;
  inc(orig);
  orig^ := kNXT_SCBootCommand;
  inc(orig);
  for i := 1 to Length(bootCmd) do
  begin
    orig^ := Byte(bootCmd[i]);
    inc(orig);
  end;
  orig^ := 0; // set last byte to null
  Result := Self;
end;

function TNxtCmd.MakeSetName(const name: string; bResponse: boolean): TNxtCmd;
var
  i : integer;
  orig : PByte;
begin
  SetLength(18);
  orig := GetBody;
  if bResponse then
    orig^ := kNXT_SystemCmd
  else
    orig^ := kNXT_SystemCmdNoReply;
  inc(orig);
  orig^ := kNXT_SCSetBrickName;
  inc(orig);
  for i := 1 to kNXT_NameMaxLen do
  begin
    if i > Length(name) then
      orig^ := 0 // pad with nulls to fixed length
    else
      orig^ := Byte(name[i]);
    inc(orig);
  end;
  orig^ := 0; // set last byte to null
  Result := Self;
end;

function TNxtCmd.MakeCmdWriteIOMap(const b1, b2: byte;
  const ModID: Cardinal; const Offset, Count: Word;
  Data: array of Byte): TNxtCmd;
var
  i, n : integer;
  orig : PByte;
begin
  n := Count+10; // (10 bytes in addition to the actual data
  if n > kNXT_MaxBytes then
    n := kNXT_MaxBytes; // total bytes must be <= 64
  SetLength(n);
  orig := GetBody;
  orig^ := b1;
  inc(orig);
  orig^ := b2;
  inc(orig);
  orig^ := Lo(Word(ModID));
  inc(orig);
  orig^ := Hi(Word(ModID));
  inc(orig);
  orig^ := Lo(HiWord(ModID));
  inc(orig);
  orig^ := Hi(HiWord(ModID));
  inc(orig);
  orig^ := Lo(Offset);
  inc(orig);
  orig^ := Hi(Offset);
  inc(orig);
  orig^ := Lo(count);
  inc(orig);
  orig^ := Hi(count);
  inc(orig);
  dec(n, 10); // set n back to count (or max - 10, whichever is smaller)
  for i := Low(Data) to High(Data) do
  begin
    dec(n);
    if n < 0 then Break;
    orig^ := Data[i];
    inc(orig);
  end;
  Result := Self;
end;

function TNxtCmd.MakeCmdReadIOMap(const b1, b2: byte;
  const ModID: Cardinal; const Offset, Count: Word): TNxtCmd;
var
  orig : PByte;
begin
  SetLength(10);
  orig := GetBody;
  orig^ := b1;
  inc(orig);
  orig^ := b2;
  inc(orig);
  orig^ := Lo(Word(ModID));
  inc(orig);
  orig^ := Hi(Word(ModID));
  inc(orig);
  orig^ := Lo(HiWord(ModID));
  inc(orig);
  orig^ := Hi(HiWord(ModID));
  inc(orig);
  orig^ := Lo(Offset);
  inc(orig);
  orig^ := Hi(Offset);
  inc(orig);
  orig^ := Lo(Count);
  inc(orig);
  orig^ := Hi(Count);
  Result := Self;
end;

function TNxtCmd.MakeSetOutputState(port, mode, regmode, runstate: byte;
  power, turnratio: shortint; tacholimit: cardinal;
  bResponse: boolean): TNxtCmd;
var
  orig : PByte;
begin
  SetLength(12);
  orig := GetBody;
  if bResponse then
    orig^ := kNXT_DirectCmd
  else
    orig^ := kNXT_DirectCmdNoReply;
  inc(orig);
  orig^ := kNXT_DCSetOutputState;
  inc(orig);
  orig^ := port;
  inc(orig);
  orig^ := power;
  inc(orig);
  orig^ := mode;
  inc(orig);
  orig^ := regmode;
  inc(orig);
  orig^ := turnratio;
  inc(orig);
  orig^ := runstate;
  inc(orig);
  orig^ := Lo(Word(tacholimit));
  inc(orig);
  orig^ := Hi(Word(tacholimit));
  inc(orig);
  orig^ := Lo(HiWord(tacholimit));
  inc(orig);
  orig^ := Hi(HiWord(tacholimit));
  Result := Self;
end;

function TNxtCmd.MakeCmdRenameFile(const b1: byte; const old,
  new: string): TNxtCmd;
var
  i, j : integer;
  orig : PByte;
  tmp : string;
begin
//kNXT_SCRenameFile
  SetLength(42);
  orig := GetBody;
  orig^ := b1;
  inc(orig);
  orig^ := kNXT_SCRenameFile;
  inc(orig);
  for j := 0 to 1 do
  begin
    if j = 0 then
      tmp := old
    else
      tmp := new;
    i := 1;
    while i <= 19 do
    begin
      // copy the first nineteen bytes from the filename provided
      if i > Length(tmp) then
        orig^ := 0
      else
        orig^ := Ord(tmp[i]);
      inc(orig);
      inc(i);
    end;
    orig^ := 0; // set last byte to null
    inc(orig);
  end;
  Result := Self;
end;

{ TNINxtCmd }

function TNINxtCmd.BytePtr: PByte;
begin
  Result := GetBody;
  inc(Result);
end;

function TNINxtCmd.Len: integer;
begin
  Result := GetLength;
  dec(Result);
end;

end.
