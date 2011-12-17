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
unit uProgram;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, uNXTConstants;

type
  TProgClumpData = class;
  TClumpOffsets = class;
  TDSTocEntries = class;
  TProgram = class;

  TDSTocEntry = class(TCollectionItem)
  private
    fStale : boolean;
    fName : string;
    fDataType : TDSType;
    fOffset : integer;
    fSize : integer;
    function GetValue: Variant;
    function GetDSTOCEntries: TDSTocEntries;
    function GetPrettyName: string;
  public
    constructor Create(ACollection: TCollection); override;
    property Name : string read fName write fName;
    property DataType : TDSType read fDataType write fDataType;
    property Offset : integer read fOffset write fOffset;
    property Size : integer read fSize write fSize;
    property Value : Variant read GetValue;
    property DSTOCEntries : TDSTocEntries read GetDSTOCEntries;
    property Stale : boolean read fStale;
    property PrettyName : string read GetPrettyName;
  end;

  TDSTocEntries = class(TCollection)
  private
    fTheProgram : TProgram;
    function GetItem(Index: Integer): TDSTocEntry;
    procedure SetItem(Index: Integer; const Value: TDSTocEntry);
    procedure RefreshFromOffset(const offset : integer);
  public
    constructor Create; virtual;
    function Add: TDSTocEntry;
    function Insert(Index: Integer): TDSTocEntry;
    function IndexOfName(const name : string) : integer;
    procedure RefreshAll;
    procedure RefreshByIndex(const index : integer);
    property Items[Index: Integer]: TDSTocEntry read GetItem write SetItem; default;
    property TheProgram : TProgram read fTheProgram;
  end;

  TOffset = class(TCollectionItem)
  private
    fLineNo : integer;
    fPC : integer;
    fFilename : string;
    fSource : string;
    function GetClumpName: string;
    function GetClumpID: integer;
    procedure SetPC(const Value: integer);
    function GetClumpOffsets: TClumpOffsets;
  public
    constructor Create(ACollection: TCollection); override;
    property PC : integer read fPC write SetPC;
    property LineNumber : integer read fLineNo write fLineNo;
    property Filename : string read fFilename write fFilename;
    property Source : string read fSource write fSource;
    property ClumpID : integer read GetClumpID;
    property ClumpName : string read GetClumpName;
    property ClumpOffsets : TClumpOffsets read GetClumpOffsets;
  end;

  TClumpOffsets = class(TCollection)
  private
    fClumpData : TProgClumpData;
    function GetItem(Index: Integer): TOffset;
    procedure SetItem(Index: Integer; const Value: TOffset);
  public
    constructor Create(aOwner : TProgClumpData); virtual;
    function Add: TOffset;
    function Insert(Index: Integer): TOffset;
    function IndexOfLine(const line : integer) : integer;
    function IndexOfPC(const pc: word): integer;
    property Items[Index: Integer]: TOffset read GetItem write SetItem; default;
    property ClumpData : TProgClumpData read fClumpData;
  end;

  TProgClumpData = class(TCollectionItem)
  private
    fName : string;
    fOffset : integer;
    fFilename : string;
    fOffsets : TClumpOffsets;
    fFullOffsets : TClumpOffsets;
    function GetClumpID: integer;
    function GetTheProgram: TProgram;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure AddOffset(const aLineNo, aPC : integer; const aSrc, aFilename : string);
    property Name : string read fName write fName;
    property Offset : integer read fOffset write fOffset;
    property Filename : string read fFilename write fFilename;
    property Offsets : TClumpOffsets read fOffsets;
    property FullOffsets : TClumpOffsets read fFullOffsets;
    property ClumpID : integer read GetClumpID;
    property TheProgram : TProgram read GetTheProgram;
  end;

  TProgram = class(TCollection)
  private
    fName : string;
    fIsNXC : boolean;
    fDS: TDSTocEntries;
    fOffsetDS : integer;
    fOffsetDVA : integer;
    function  GetItem(Index: Integer): TProgClumpData;
    procedure SetItem(Index: Integer; const Value: TProgClumpData);
    procedure LoadDataspace(SL : TStrings);
    procedure LoadClumpData(SL : TStrings);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function  Add: TProgClumpData;
    function  Insert(Index: Integer): TProgClumpData;
    procedure ClearAll;
    function  IndexOfName(const name : string) : integer;
    function  TraceInto : boolean;
    function  StepOver : boolean;
//    function  SingleStep(const bInto : boolean) : boolean;
    function  Run : boolean;
    function  RunUntilReturn : boolean;
    function  RunToCursor(const aLine : integer) : boolean;
    function  TraceToNextSourceLine(const aLine : integer) : boolean;
    function  ProgramPause : boolean;
    function  ProgramReset(const bEnhanced : boolean) : boolean;
    function  VMState : byte;
    procedure LoadFromFile(const name : string);
    procedure UpdateOffsets;
    function  Loaded(const aName : string) : boolean;
    function  HasBreakPoint(const aLine : integer) : boolean;
    procedure ClearBreakPoint(const aLine : integer);
    procedure SetBreakPoint(const aLine : integer);
    property  Items[Index: Integer]: TProgClumpData read GetItem write SetItem; default;
    property  Dataspace : TDSTocEntries read fDS;
    property  IsNXC : boolean read fIsNXC write fIsNXC;
  end;

function CurrentProgram : TProgram;

var
  fNXTVMState : byte;
  fNXTCurrentOffset : TOffset;
  fNXTClump : byte;
  fNXTProgramCounter : word;

implementation

uses
  SysUtils, rcx_constants, uSpirit, brick_common, uNBCCommon;

var
  CP : TProgram;

function CurrentProgram : TProgram;
begin
  if not Assigned(CP) then
    CP := TProgram.Create;
  Result := CP;
end;

function ExtractCurrentFile(name : string) : string;
var
  i : integer;
begin
  i := Pos('''', name);
  if i = 0 then
    i := Pos('"', name);
  Result := Copy(name, i+1, MaxInt);
  System.Delete(Result, Length(Result), 1); // remove trailing quote
end;

{ TDSTocEntries }

function TDSTocEntries.Add: TDSTocEntry;
begin
  Result := TDSTocEntry(inherited Add);
end;

constructor TDSTocEntries.Create;
begin
  inherited Create(TDSTocEntry);
end;

function TDSTocEntries.GetItem(Index: Integer): TDSTocEntry;
begin
  Result := TDSTocEntry(inherited GetItem(Index));
end;

function TDSTocEntries.IndexOfName(const name: string): integer;
var
  i : integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if Items[i].Name = name then
    begin
      Result := Items[i].Index;
      break;
    end;
  end;
end;

function TDSTocEntries.Insert(Index: Integer): TDSTocEntry;
begin
  Result := TDSTocEntry(inherited Insert(Index));
end;

procedure TDSTocEntries.RefreshAll;
begin
  // refresh all toc entries.  Mark them as not stale
end;

procedure TDSTocEntries.RefreshByIndex(const index: integer);
begin

end;

procedure TDSTocEntries.RefreshFromOffset(const offset: integer);
begin

end;

procedure TDSTocEntries.SetItem(Index: Integer; const Value: TDSTocEntry);
begin
  inherited SetItem(Index, Value);
end;

{ TDSTocEntry }

constructor TDSTocEntry.Create(ACollection: TCollection);
begin
  inherited;
  fStale    := True;
  fName     := '';
  fDataType := dsVoid;
  fOffset   := -1;
  fSize     := -1;
end;

function TDSTocEntry.GetDSTOCEntries: TDSTocEntries;
begin
  Result := TDSTocEntries(Collection);
end;

function TDSTocEntry.GetPrettyName: string;
begin
  Result := PrettyNameStrip(Name);
  // names can be decorated in various ways...
end;

function TDSTocEntry.GetValue: Variant;
begin
  // grab offsets if we don't have them already.
  if (DSTOCEntries.TheProgram.fOffsetDS = MaxInt) or
     (DSTOCEntries.TheProgram.fOffsetDVA = MaxInt) then
  begin
    DSTOCEntries.TheProgram.UpdateOffsets;
  end;
  if (DSTOCEntries.TheProgram.fOffsetDS <> $FFFF) and
     (DSTOCEntries.TheProgram.fOffsetDVA <> $FFFF) then
  begin
//    if (self.Offset <> -1) and (self.Size <> -1) and (self.
  end;
(*
        DoGetVarInfoByID(aNum, offset, size, vartype);
        if (offset <> -1) and (size <> -1) and (vartype <> -1) then
        begin
          dst := TDSType(Byte(vartype));
          // if vartype == scalar type then
          if dst in [dsUByte, dsSByte, dsUWord, dsSWord, dsULong, dsSLong, dsFloat] then
          begin
            // IOMapRead from fOffsetDS+offset, size bytes
            // IOMapRead CommandOffsetTick
            modID := kNXT_ModuleCmd;
            count := size; // variable size
            buffer.Data[0] := 0;
            res := NXTReadIOMap(modID, fOffsetDS+offset, count, buffer);
            if res then
            begin
              case dst of
                dsUByte : Result := Integer(buffer.Data[0]);
                dsSByte : Result := Integer(Char(buffer.Data[0]));
                dsUWord :
                  Result := Integer(Word(BytesToCardinal(buffer.Data[0],
                    buffer.Data[1])));
                dsSWord :
                  Result := Integer(SmallInt(BytesToCardinal(buffer.Data[0],
                    buffer.Data[1])));
                dsULong :
                  Result := BytesToCardinal(buffer.Data[0], buffer.Data[1],
                    buffer.Data[2], buffer.Data[2]);
                dsSLong :
                  Result := Integer(BytesToCardinal(buffer.Data[0],
                    buffer.Data[1], buffer.Data[2], buffer.Data[3]));
              else
                Result := 0; // floats are a problem...
              end;
            end;
          end
          else if dst = dsArray then
          begin
            // read first value from array?????
          end;
        end;
*)
end;

{ TOffset }

constructor TOffset.Create(ACollection: TCollection);
begin
  inherited;
  fLineNo   := -1;
  fPC       := -1;
  fFilename := '';
  fSource   := '';
end;

function TOffset.GetClumpName: string;
begin
  Result := TClumpOffsets(Collection).ClumpData.Name;
end;

function TOffset.GetClumpID: integer;
begin
  Result := TClumpOffsets(Collection).ClumpData.ClumpID;
end;

procedure TOffset.SetPC(const Value: integer);
begin
  if Value > fPC then
    fPC := Value;
end;

function TOffset.GetClumpOffsets: TClumpOffsets;
begin
  Result := TClumpOffsets(Collection);
end;

{ TClumpOffsets }

function TClumpOffsets.Add: TOffset;
begin
  Result := TOffset(inherited Add);
end;

constructor TClumpOffsets.Create(aOwner : TProgClumpData);
begin
  inherited Create(TOffset);
  fClumpData := aOwner;
end;

function TClumpOffsets.GetItem(Index: Integer): TOffset;
begin
  Result := TOffset(inherited GetItem(Index));
end;

function TClumpOffsets.IndexOfLine(const line: integer): integer;
var
  i : integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if Items[i].LineNumber = line then
    begin
      Result := Items[i].Index;
      break;
    end;
  end;
end;

function TClumpOffsets.IndexOfPC(const pc: word): integer;
var
  i : integer;
begin
  // find the first offset object with a PC > pc and same filename
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if Items[i].PC >= Integer(pc) then
    begin
      Result := Items[i].Index;
      break;
    end;
  end;
end;

function TClumpOffsets.Insert(Index: Integer): TOffset;
begin
  Result := TOffset(inherited Insert(Index));
end;

procedure TClumpOffsets.SetItem(Index: Integer; const Value: TOffset);
begin
  inherited SetItem(Index, Value);
end;

{ TProgClumpData }

procedure TProgClumpData.AddOffset(const aLineNo, aPC: integer; const aSrc, aFilename: string);
var
  CO : TOffset;
//  i : integer;
begin
{
  i := Offsets.IndexOfLine(aLineNo);
  if i = -1 then
  begin
    CO := Offsets.Add;
    CO.LineNumber := aLineNo;
  end
  else
    CO := Offsets.Items[i];
}
  CO := Offsets.Add;
  CO.LineNumber := aLineNo;
  CO.PC := aPC;
  CO.Filename := aFilename;
  CO.Source := aSrc;
end;

constructor TProgClumpData.Create(ACollection: TCollection);
begin
  inherited;
  fOffsets := TClumpOffsets.Create(Self);
  fFullOffsets := TClumpOffsets.Create(Self);
  fName := '';
  fOffset := -1;
  fFilename := '';
end;

destructor TProgClumpData.Destroy;
begin
  FreeAndNil(fOffsets);
  FreeAndNil(fFullOffsets);
  inherited;
end;

function TProgClumpData.GetClumpID: integer;
begin
  Result := Self.ID;
end;

function TProgClumpData.GetTheProgram: TProgram;
begin
  Result := TProgram(Collection);
end;

{ TProgram }

function TProgram.Add: TProgClumpData;
begin
  Result := TProgClumpData(inherited Add);
end;

constructor TProgram.Create;
begin
  inherited Create(TProgClumpData);
  fDS := TDSTocEntries.Create;
  fDS.fTheProgram := Self;
  fIsNXC := False;
  fName := '';
  fOffsetDS := MaxInt;
  fOffsetDVA := MaxInt;
end;

destructor TProgram.Destroy;
begin
  FreeAndNil(fDS);
  inherited;
end;

function TProgram.GetItem(Index: Integer): TProgClumpData;
begin
  Result := TProgClumpData(inherited GetItem(Index));
end;

function TProgram.IndexOfName(const name: string): integer;
var
  i : integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if Items[i].Name = name then
    begin
      Result := Items[i].Index;
      break;
    end;
  end;
end;

function TProgram.Insert(Index: Integer): TProgClumpData;
begin
  Result := TProgClumpData(inherited Insert(Index));
end;

procedure TProgram.LoadClumpData(SL: TStrings);
var
  values : TStringList;
  i, tmpID, lineNo, PC : integer;
  tmp, currentFile : string;
  CD : TProgClumpData;
  CO : TOffset;
begin
  Clear; // clear the collection of clumps
  i := SL.IndexOf('#CLUMPS');
  if i <> -1 then
  begin
    inc(i, 2); // skip two lines
    values := TStringList.Create;
    try
      while i < SL.Count do begin
        tmp := SL[i];
        values.Clear;
        ExtractStrings([#9], [], PChar(tmp), values);
        if values.Count = 4 then
        begin
          // only process valid lines
          CD := Add;
          CD.Name     := values[1];
          CD.Offset   := StrToIntDef(values[2], -1);
          CD.Filename := values[3];
        end;
        inc(i);
      end;
      // now process the #sources
      i := SL.IndexOf('#SOURCES');
      if i <> -1 then
      begin
        inc(i, 2); // skip two lines
        tmp := SL[i];
        CD := nil;
        currentFile := '';
        while tmp <> '#CLUMPS' do
        begin
          values.Clear;
          ExtractStrings([#9], [], PChar(tmp), values);
          if values.Count = 4 then
          begin
            tmpID  := StrToIntDef(values[0], -1);
            lineNo := StrToIntDef(values[1], -1);
            PC     := StrToIntDef(values[2], -1);
            if Pos('#line', values[3]) > 0 then
            begin
              // update current file
              currentFile := ExtractCurrentFile(values[3]);
              inc(lineNo);
            end;
            // find the clump data
            if not Assigned(CD) or (CD.ID <> tmpID) then
            begin
              CD := Self.Items[tmpID];
            end;
            CD.AddOffset(lineNo, PC, values[3], currentFile);
            // add an offset for each source line in the FullOffsets
            CO := CD.FullOffsets.Add;
            CO.LineNumber := lineNo;
            CO.PC         := PC;
            CO.Source     := values[3];
            CO.Filename   := currentFile;
          end;
          inc(i);
          tmp := SL[i];
        end;
      end;
    finally
      values.Free;
    end;
  end;
end;

procedure TProgram.LoadDataspace(SL : TStrings);
var
  values : TStringList;
  tmp : string;
  i : integer;
  DSE : TDSTocEntry;
begin
  fDS.Clear;
  // load DSTOC entries from Symbol file
  if (SL.Count > 2) and (Pos('#SOURCES', SL.Text) > 0) then
  begin
    i := 2; // skip the first two lines
    tmp := SL[i];
    // each line is Index->Identifier->Type->Flag->Data->Size->RefCount
    values := TStringList.Create;
    try
      while Pos('#SOURCES', tmp) = 0 do
      begin
        values.Clear;
        ExtractStrings([#9], [], PChar(tmp), values);
        DSE := fDS.Add;
        DSE.Name     := values[1];
        DSE.Offset   := StrToIntDef(values[4], -1);
        DSE.Size     := StrToIntDef(values[5], -1);
        DSE.DataType := TDSType(StrToIntDef(values[2], 0));
        // on to the next line
        inc(i);
        tmp := SL[i];
      end;
    finally
      values.Free;
    end;
  end;
end;

procedure TProgram.LoadFromFile(const name: string);
var
  SL : TStringList;
begin
  fOffsetDS := MaxInt;
  fOffsetDVA := MaxInt;
  SL := TStringList.Create;
  try
    SL.LoadFromFile(name);
    LoadDataspace(SL);
    LoadClumpData(SL);
  finally
    SL.Free;
  end;
  fName := name;
  fNXTVMState := kNXT_VMState_Idle;
end;

function TProgram.ProgramPause: boolean;
begin
  // use kNXT_VMState_Single instead of kNXT_VMState_Pause because for
  // some unexplained reason I get back NOT_A_CLUMP (0xFF) for the current
  // clump when I use kNXT_VMState_Pause
  Result := BrickComm.NXTSetVMState(kNXT_VMState_Single);
  if Result then
    Result := BrickComm.NXTGetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
end;

function TProgram.Run: boolean;
begin
  // is the program already running?
  if fNXTVMState = kNXT_VMState_Idle then
    Result := BrickComm.NXTStartProgram(ChangeFileExt(fName, '.rxe'))
  else
  begin
    Result := BrickComm.NXTSetVMState(kNXT_VMState_RunFree);
    if Result then
      Result := BrickComm.NXTGetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
  end;
end;

procedure TProgram.SetItem(Index: Integer; const Value: TProgClumpData);
begin
  inherited SetItem(Index, Value);
end;

function TProgram.TraceInto: boolean;
var
  i, curLine, newLine : integer;
  CD : TProgClumpData;
  CO : TOffset;
  bc : TBrickComm;
begin
  bc := BrickComm;
  curLine := -1;
  Assert(bc <> nil, 'bc == nil');
  fNXTClump := $FF; // NOT_A_CLUMP
 // single step until line increments
  if Assigned(fNXTCurrentOffset) then
    curLine := fNXTCurrentOffset.LineNumber;
  newLine := curLine;
  Result := True;
  while (newLine = curLine) and Result do
  begin
    if bc.NXTSetVMState(kNXT_VMState_Single) then
    begin
      fNXTVMState := kNXT_VMState_Idle;
      fNXTClump   := $FF;
      fNXTProgramCounter := 0;
      Result := bc.NXTGetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
      if Result and (fNXTClump < CurrentProgram.Count) then
      begin
        CD := CurrentProgram[fNXTClump];
        i := CD.Offsets.IndexOfPC(fNXTProgramCounter);
        if i <> -1 then
        begin
          CO := CD.Offsets[i];
          fNXTCurrentOffset := CO;
          newLine := CO.LineNumber;
        end
        else
          Result := False;
      end;
    end
    else
      Result := False;
  end;
end;

(*
function TProgram.StepOver: boolean;
var
  i, curLine, newLine : integer;
  CD : TProgClumpData;
  CO : TOffset;
  bc : TBrickComm;
  oldClump : Byte;
begin
  // instead we need to figure out the PC of the next line in this clump
  // and set a breakpoint there
  Result := False;
  if fNXTClump <> $FF then
  begin
    CD := CurrentProgram[fNXTClump];
//    if Assigned(fNXTCurrentOffset)
//    CD.offsets
  end;
//        i := CD.Offsets.IndexOfPC(fNXTProgramCounter);
//        if i <> -1 then
//        begin
//          CO := CD.Offsets[i];
//          fNXTCurrentOffset := CO;
//          newLine := CO.LineNumber;
//        end
//        else
//          Result := False;
//
//  if Assigned(fNXTCurrentOffset) then
//  begin
//    // find the next offset in our list of offsets
//    curLine := fNXTCurrentOffset.LineNumber;
//  end;
end;
*)

function TProgram.StepOver: boolean;
var
  i, curLine, newLine : integer;
  CD : TProgClumpData;
  CO : TOffset;
  bc : TBrickComm;
  oldClump : Byte;
begin
  // this takes too long
  // the difference between stepping into or stepping over is that
  // you step until the line number changes in Step Into
  // but you step until the line number changes AND the clump is the same
  bc := BrickComm;
  Result := False;
  curLine := -1;
  Assert(bc <> nil, 'bc == nil');
  oldClump := fNXTClump;
  fNXTClump := $FF; // NOT_A_CLUMP
  // single step until line increments
  if Assigned(fNXTCurrentOffset) then
    curLine := fNXTCurrentOffset.LineNumber;
  newLine := curLine;
  Result := True;
  while ((newLine = curLine) or
         ((oldClump <> $FF) and (oldClump <> fNXTClump))) and Result do
  begin
    if bc.NXTSetVMState(kNXT_VMState_Single) then
    begin
      fNXTVMState := kNXT_VMState_Idle;
      fNXTClump   := $FF;
      fNXTProgramCounter := 0;
      Result := bc.NXTGetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
      if Result and (fNXTClump < CurrentProgram.Count) then
      begin
        CD := CurrentProgram[fNXTClump];
        i := CD.Offsets.IndexOfPC(fNXTProgramCounter);
        if i <> -1 then
        begin
          CO := CD.Offsets[i];
          fNXTCurrentOffset := CO;
          newLine := CO.LineNumber;
        end
        else
          Result := False;
      end;
    end
    else
      Result := False;
  end;
end;


(*
function TProgram.SingleStep(const bInto : boolean) : boolean;
var
  i, curLine, newLine : integer;
  CD : TProgClumpData;
  CO : TOffset;
  bc : TBrickComm;
  oldClump : Byte;
begin
  // the difference between stepping into or stepping over is that
  // you step until the line number changes in Step Into
  // but you step until the line number changes AND the clump is the same
  bc := BrickComm;
  Result := False;
  curLine := -1;
  Assert(bc <> nil, 'bc == nil');
  oldClump := fNXTClump;
  fNXTClump := $FF; // NOT_A_CLUMP
 // single step until line increments
  if Assigned(fNXTCurrentOffset) then
    curLine := fNXTCurrentOffset.LineNumber;
  newLine := curLine;
  Result := True;
  while (bInto and ((newLine = curLine) and Result)) or
        (not bInto and (((newLine = curLine) or (oldClump <> fNXTClump)) and Result)) do
  begin
    if bc.SetVMState(kNXT_VMState_Single) then
    begin
      fNXTVMState := kNXT_VMState_Idle;
      fNXTClump   := $FF;
      fNXTProgramCounter := 0;
      Result := bc.GetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
      if Result and (fNXTClump < CurrentProgram.Count) then
      begin
        CD := CurrentProgram[fNXTClump];
        i := CD.Offsets.IndexOfPC(fNXTProgramCounter);
        if i <> -1 then
        begin
          CO := CD.Offsets[i];
          fNXTCurrentOffset := CO;
          newLine := CO.LineNumber;
        end
        else
          Result := False;
      end;
    end
    else
      Result := False;
  end;
  end
  else
  begin // NBC
    // what is the current clump?
    oldClump := fNXTClump;
    if bc.SetVMState(kNXT_VMState_Single) then
    begin
      fNXTVMState := kNXT_VMState_Idle;
      fNXTClump   := $FF;
      fNXTProgramCounter := 0;
      Result := bc.GetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
    end;
    if not bInto and (fNXTClump <> oldClump) and Result then
    begin
      while (fNXTClump <> oldClump) and Result do
      begin
        if bc.SetVMState(kNXT_VMState_Single) then
        begin
          fNXTVMState := kNXT_VMState_Idle;
          fNXTClump   := $FF;
          fNXTProgramCounter := 0;
          Result := bc.GetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
        end;
      end;
    end;
  end;
end;
*)

procedure TProgram.UpdateOffsets;
var
  res : boolean;
  modID : Cardinal;
  buffer : NXTDataBuffer;
  acount : Word;
begin
  fOffsetDS := $FFFF;
  fOffsetDVA := $FFFF;
  // IOMapRead CommandOffsetOffsetDS
  modID := kNXT_ModuleCmd;
  acount := 2;
  buffer.Data[0] := 0;
  buffer.Data[1] := 0;
  res := BrickComm.NXTReadIOMap(modID, CommandOffsetOffsetDS, acount, buffer);
  if res then
    fOffsetDS := Word(BytesToCardinal(buffer.Data[0], buffer.Data[1]));
  // IOMapRead CommandOffsetOffsetDVA
  modID := kNXT_ModuleCmd;
  acount := 2;
  buffer.Data[0] := 0;
  buffer.Data[1] := 0;
  res := BrickComm.NXTReadIOMap(modID, CommandOffsetOffsetDVA, acount, buffer);
  if res then
    fOffsetDVA := Word(BytesToCardinal(buffer.Data[0], buffer.Data[1]));
end;

function TProgram.VMState: byte;
begin
  fNXTVMState := kNXT_VMState_Idle;
  fNXTClump   := $FF;
  fNXTProgramCounter := 0;
  BrickComm.NXTGetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
  Result := fNXTVMState;
end;

function TProgram.ProgramReset(const bEnhanced : boolean) : boolean;
begin
  // before stopping the program make sure the VM State is RunFree
  if bEnhanced and (fNXTVMState = kNXT_VMState_Pause) then
  begin
    BrickComm.NXTSetVMState(kNXT_VMState_RunFree);
  end;
  Result := BrickComm.NXTStopProgram;
  fNXTVMState := kNXT_VMState_Idle;
end;

(*
function TProgram.RunToCursor(const aLine : integer) : boolean;
begin
  Result := False;
end;
*)

function TProgram.RunToCursor(const aLine : integer) : boolean;
var
  i, curLine : integer;
  CD : TProgClumpData;
  CO : TOffset;
  bc : TBrickComm;
begin
  // run to cursor means single step while the line number < aLine
  bc := BrickComm;
  curLine := -1;
  Assert(bc <> nil, 'bc == nil');
  if Assigned(fNXTCurrentOffset) then
    curLine := fNXTCurrentOffset.LineNumber;
  Result := True;
  while (aLine > curLine) and Result do
  begin
    if bc.NXTSetVMState(kNXT_VMState_Single) then
    begin
      fNXTVMState := kNXT_VMState_Idle;
      fNXTClump   := $FF;
      fNXTProgramCounter := 0;
      Result := bc.NXTGetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
      if Result and (fNXTClump < CurrentProgram.Count) then
      begin
        CD := CurrentProgram[fNXTClump];
        i := CD.Offsets.IndexOfPC(fNXTProgramCounter);
        if i <> -1 then
        begin
          CO := CD.Offsets[i];
          fNXTCurrentOffset := CO;
          curline := CO.LineNumber;
        end
        else
          Result := False;
      end;
    end
    else
      Result := False;
  end;
end;

(*
function TProgram.RunUntilReturn: boolean;
begin
  Result := False;
end;
*)

function TProgram.RunUntilReturn: boolean;
var
  bc : TBrickComm;
  oldClump : Byte;
begin
  // aka step out
  // run until return means single step until the clump # changes (sort of)
  bc := BrickComm;
  Result := True;
  Assert(bc <> nil, 'bc == nil');
  oldClump := fNXTClump;
  while (oldClump = fNXTClump) and Result do
  begin
    if bc.NXTSetVMState(kNXT_VMState_Single) then
    begin
      fNXTVMState := kNXT_VMState_Idle;
      fNXTClump   := $FF;
      fNXTProgramCounter := 0;
      Result := bc.NXTGetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
    end
    else
      Result := False;
  end;
end;

function TProgram.TraceToNextSourceLine(const aLine : integer) : boolean;
begin
  Result := RunToCursor(aLine);
end;

function TProgram.Loaded(const aName : string) : boolean;
begin
  Result := Lowercase(ChangeFileExt(ExtractFileName(fName),'')) =
            Lowercase(ChangeFileExt(ExtractFileName(aName),''));
end;

procedure TProgram.ClearAll;
begin
  Clear;
  Dataspace.Clear;
  fName := '';
end;

function TProgram.HasBreakPoint(const aLine: integer): boolean;
var
  bc : TBrickComm;
begin
  Result := False;
  bc := BrickComm;
  Assert(bc <> nil, 'bc == nil');
  // figure out what clump they are in based on the line number
  // also figure out the PC for this line number.
(*
      case RC_SET_BREAKPOINTS:
      {
        CLUMP_ID Clump = (CLUMP_ID)pInBuf[1];
        //Don't do anything if illegal clump specification is made
        if (Clump >= VarsCmd.AllClumpsCount)
        {
          RCStatus = ERR_RC_ILLEGAL_VAL;
          break;
        }
        // setting breakpoint information turns on debugging mode
        VarsCmd.Debugging = TRUE;
        CLUMP_BREAK_REC* pBreakpoints = VarsCmd.pAllClumps[Clump].Breakpoints;
        // length varies from 6 bytes min to 18 bytes max
        // clump byte, bpidx, bplocation (2 bytes), bp enabled, [...] terminal byte 0xFF
        UBYTE idx = 2;
        UBYTE bDone = FALSE;
        while (!bDone) {
          UBYTE bpIdx = (UBYTE)pInBuf[idx];
          idx++;
          memcpy((PSZ)(&(pBreakpoints[bpIdx].Location)), (PSZ)(&pInBuf[idx]), 2);
          idx += 2;
          pBreakpoints[bpIdx].Enabled = (UBYTE)pInBuf[idx];
          idx++;
          bDone = (((UBYTE)pInBuf[idx] == 0xFF) || (idx >= 18));
        }
        // fall through to RC_GET_BREAKPOINTS
      }
      
      case RC_GET_BREAKPOINTS:
      {
        if (SendResponse == TRUE)
        {
          // output the list of breakpoints for the specified clump ID
          CLUMP_ID Clump = (CLUMP_ID)pInBuf[1];
          //Don't do anything if illegal clump specification is made
          if (Clump >= VarsCmd.AllClumpsCount)
          {
            RCStatus = ERR_RC_ILLEGAL_VAL;
            break;
          }
          CLUMP_BREAK_REC* pBreakpoints = VarsCmd.pAllClumps[Clump].Breakpoints;
          for(int j = 0; j < MAX_BREAKPOINTS; j++)
          {
            memcpy((PSZ)&(pOutBuf[ResponseLen]), (PSZ)&(pBreakpoints[j].Location), 2);
            ResponseLen += 2;
            pOutBuf[ResponseLen] = pBreakpoints[j].Enabled;
            ResponseLen++;
          }
        }
      }
*)
(*
  if bc.SetVMState(kNXT_VMState_Single) then
  begin
    Result := bc.GetVMState(fNXTVMState, fNXTClump, fNXTProgramCounter);
  end
*)
end;

procedure TProgram.ClearBreakPoint(const aLine: integer);
var
  bc : TBrickComm;
begin
  bc := BrickComm;
  Assert(bc <> nil, 'bc == nil');

end;

procedure TProgram.SetBreakPoint(const aLine: integer);
var
  bc : TBrickComm;
begin
  bc := BrickComm;
  Assert(bc <> nil, 'bc == nil');

end;

initialization
  CP := nil;

finalization
  FreeAndNil(CP);

end.