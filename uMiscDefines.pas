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
unit uMiscDefines;

interface

uses
  Classes, uParseCommon, Editor, uNXTConstants;

type
  TProgramNames = array[0..5] of string;
  TFirmwareType = (ftStandard, ftBrickOS, ftPBForth, ftLeJOS, ftOther);

  TDSTocEntry = class(TCollectionItem)
  private
    fName : string;
    fDataType : TDSType;
    fOffset : integer;
    fSize : integer;
  public
    constructor Create(ACollection: TCollection); override;
    property Name : string read fName write fName;
    property DataType : TDSType read fDataType write fDataType;
    property Offset : integer read fOffset write fOffset;
    property Size : integer read fSize write fSize;
  end;

  TDSTocEntries = class(TCollection)
  private
    function GetItem(Index: Integer): TDSTocEntry;
    procedure SetItem(Index: Integer; const Value: TDSTocEntry);
  public
    constructor Create; virtual;
    function Add: TDSTocEntry;
    function Insert(Index: Integer): TDSTocEntry;
    function IndexOfName(const name : string) : integer;
    property Items[Index: Integer]: TDSTocEntry read GetItem write SetItem; default;
  end;

  TOffset = class(TCollectionItem)
  private
    fLineNo : integer;
    fPC : integer;
    fFilename : string;
    function GetClumpName: string;
    function GetClumpID: integer;
    procedure SetPC(const Value: integer);
  public
    constructor Create(ACollection: TCollection); override;
    property PC : integer read fPC write SetPC;
    property LineNumber : integer read fLineNo write fLineNo;
    property Filename : string read fFilename write fFilename;
    property ClumpID : integer read GetClumpID;
    property ClumpName : string read GetClumpName;
  end;

  TClumpData = class;
  
  TClumpOffsets = class(TCollection)
  private
    fClumpData : TClumpData;
    function GetItem(Index: Integer): TOffset;
    procedure SetItem(Index: Integer; const Value: TOffset);
  public
    constructor Create(aOwner : TClumpData); virtual;
    function Add: TOffset;
    function Insert(Index: Integer): TOffset;
    function IndexOfLine(const line : integer) : integer;
    function IndexOfPC(const pc: word): integer;
    property Items[Index: Integer]: TOffset read GetItem write SetItem; default;
    property ClumpData : TClumpData read fClumpData;
  end;

  TClumpData = class(TCollectionItem)
  private
    fName : string;
    fOffset : integer;
    fFilename : string;
    fOffsets : TClumpOffsets;
    function GetClumpID: integer;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    procedure AddOffset(const lineNo, PC : integer; const fname : string);
    property Name : string read fName write fName;
    property Offset : integer read fOffset write fOffset;
    property Filename : string read fFilename write fFilename;
    property Offsets : TClumpOffsets read fOffsets;
    property ClumpID : integer read GetClumpID;
  end;

  TProgram = class(TCollection)
  private
    fDS: TDSTocEntries;
    function GetItem(Index: Integer): TClumpData;
    procedure SetItem(Index: Integer; const Value: TClumpData);
    procedure LoadDataspace(SL : TStrings);
    procedure LoadClumpData(SL : TStrings);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function  Add: TClumpData;
    function  Insert(Index: Integer): TClumpData;
    function  IndexOfName(const name : string) : integer;
    procedure LoadFromFile(const name : string);
    property  Items[Index: Integer]: TClumpData read GetItem write SetItem; default;
    property  Dataspace : TDSTocEntries read fDS;
  end;

const
  SU_SHOWFORM = 0;
  SU_CONNECT = 1;
  SU_NOCONNECT = 2;

var
  LocalPort : string;    // Name of the port to use for this instance
  LocalStartupAction : integer; // action to take at startup for this instance
  LocalStandardFirmware : Boolean;
  LocalUseBluetooth : Boolean;
  LocalFirmwareType : TFirmwareType;

function Min(const v1, v2: Integer): Integer;
function Max(const v1, v2: Integer): Integer;
function ExploredLanguageType : TExploredLanguage;
function FileCanBeCompiled: Boolean;
function FileCanBeProcessed: Boolean;
function FileIsCPPOrPascalOrJava(AEF : TEditorForm = nil): Boolean;
function FileIsMindScriptOrLASM(AEF : TEditorForm = nil): Boolean;
function FileIsNBCOrNXCOrNPGOrRICScript(AEF : TEditorForm = nil): Boolean;
function FileIsNBCOrNXC(AEF : TEditorForm = nil): Boolean;
function FileIsPascal(AEF : TEditorForm = nil): Boolean;
function FileIsCPP(AEF : TEditorForm = nil): Boolean;
function FileIsLASM(AEF : TEditorForm = nil): Boolean;
function FileIsNBC(AEF : TEditorForm = nil): Boolean;
function FileIsNXC(AEF : TEditorForm = nil): Boolean;
function FileIsNPG(AEF : TEditorForm = nil): Boolean;
function FileIsRICScript(AEF : TEditorForm = nil): Boolean;
function FileIsMindScript(AEF : TEditorForm = nil): Boolean;
function FileIsNQC(AEF : TEditorForm = nil): Boolean;
function FileIsJava(AEF : TEditorForm = nil): Boolean;
function FileIsForth(AEF : TEditorForm = nil): Boolean;
function FileIsROPS(AEF : TEditorForm = nil): Boolean;

function CurrentProgram : TProgram;

var
  fNXTVMState : byte;
  fNXTCurrentOffset : TOffset;

implementation

uses
  MainUnit, SysUtils;

function Min(const v1, v2: Integer): Integer;
begin
  if v1 < v2 then
    Result := v1
  else
    Result := v2;
end;

function Max(const v1, v2: Integer): Integer;
begin
  if v1 > v2 then
    Result := v1
  else
    Result := v2;
end;

function ExploredLanguageType : TExploredLanguage;
var
  AEF : TEditorForm;
begin
  result := elNQC;
  AEF := nil;
  if Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  if FileIsCPP(AEF) then
    result := elCpp
  else if FileIsPascal(AEF) then
    result := elPas
  else if FileIsROPS(AEF) then
    result := elPas
  else if FileIsJava(AEF) then
    result := elJava
  else if FileIsForth(AEF) then
    result := elForth
  else if FileIsLASM(AEF) then
    result := elLASM
  else if FileIsNBC(AEF) then
    result := elNBC
  else if FileIsNXC(AEF) then
    result := elNXC
  else if FileIsMindScript(AEF) then
    result := elMindScript;
end;

function FileCanBeCompiled: Boolean;
var
  AEF : TEditorForm;
begin
  Result := False;
  AEF := nil;
  if Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsNQC(AEF) or
            FileIsMindScript(AEF) or
            FileIsLASM(AEF) or
            FileIsNBC(AEF) or
            FileIsNXC(AEF) or
            FileIsNPG(AEF) or
            FileIsRICScript(AEF) or
            FileIsCPP(AEF) or
            FileIsPascal(AEF) or
            FileIsROPS(AEF) or
            FileIsJava(AEF);
end;

function FileCanBeProcessed: Boolean;
var
  AEF : TEditorForm;
begin
  Result := False;
  AEF := nil;
  if Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsNQC(AEF) or
            FileIsMindScript(AEF) or
            FileIsNBC(AEF) or
            FileIsNXC(AEF) or
            FileIsLASM(AEF) or
            FileIsCPP(AEF) or
            FileIsJava(AEF) or
            FileIsForth(AEF) or
            FileIsROPS(AEF) or
            FileIsPascal(AEF);
end;

function FileIsCPPOrPascalOrJava(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsCPP(AEF) or FileIsPascal(AEF) or FileIsJava(AEF);
end;

function FileIsMindScriptOrLASM(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsMindScript(AEF) or FileIsLASM(AEF);
end;

function FileIsNBCOrNXCOrNPGOrRICScript(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsNBC(AEF) or FileIsNXC(AEF) or FileIsNPG(AEF) or FileIsRICScript(AEF);
end;

function FileIsNBCOrNXC(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := FileIsNBC(AEF) or FileIsNXC(AEF);
end;

function FileIsPascal(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynPasSyn;
end;

function FileIsCPP(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynCppSyn;
end;

function FileIsLASM(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynLASMSyn;
end;

function FileIsNBC(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynNBCSyn;
end;

function FileIsNXC(AEF : TEditorForm = nil): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynNXCSyn;
end;

function FileIsNPG(AEF : TEditorForm = nil): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynNPGSyn;
end;

function FileIsRICScript(AEF : TEditorForm = nil): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynRSSyn;
end;

function FileIsMindScript(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynMindScriptSyn;
end;

function FileIsNQC(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynNQCSyn;
end;

function FileIsJava(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynJavaSyn;
end;

function FileIsForth(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynForthSyn;
end;

function FileIsROPS(AEF : TEditorForm): Boolean;
begin
  Result := False;
  if not Assigned(AEF) and Assigned(MainForm) then
    AEF := MainForm.ActiveEditorForm;
  if not Assigned(AEF) then Exit;
  Result := AEF.Highlighter = MainForm.SynROPSSyn;
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

procedure TDSTocEntries.SetItem(Index: Integer; const Value: TDSTocEntry);
begin
  inherited SetItem(Index, Value);
end;

{ TDSTocEntry }

constructor TDSTocEntry.Create(ACollection: TCollection);
begin
  inherited;
  fName     := '';
  fDataType := dsVoid;
  fOffset   := -1;
  fSize     := -1;
end;

var
  CP : TProgram;

function CurrentProgram : TProgram;
begin
  if not Assigned(CP) then
    CP := TProgram.Create;
  Result := CP;
end;

{ TOffset }

constructor TOffset.Create(ACollection: TCollection);
begin
  inherited;
  fLineNo   := -1;
  fPC       := -1;
  fFilename := '';
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

{ TClumpOffsets }

function TClumpOffsets.Add: TOffset;
begin
  Result := TOffset(inherited Add);
end;

constructor TClumpOffsets.Create;
begin
  inherited Create(TOffset);
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
  // find the first offset object with a PC > pc
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

{ TClumpData }

procedure TClumpData.AddOffset(const lineNo, PC: integer; const fname: string);
var
  CO : TOffset;
  i : integer;
begin
  i := Offsets.IndexOfLine(lineNo);
  if i = -1 then
  begin
    CO := Offsets.Add;
    CO.LineNumber := lineNo;
  end
  else
    CO := Offsets.Items[i];
  CO.PC := PC;
  CO.Filename := fname;
end;

constructor TClumpData.Create(ACollection: TCollection);
begin
  inherited;
  fOffsets := TClumpOffsets.Create(Self);
  fName := '';
  fOffset := -1;
  fFilename := '';
end;

destructor TClumpData.Destroy;
begin
  FreeAndNil(fOffsets);
  inherited;
end;

function TClumpData.GetClumpID: integer;
begin
  Result := Self.ID;
end;

{ TProgram }

function TProgram.Add: TClumpData;
begin
  Result := TClumpData(inherited Add);
end;

constructor TProgram.Create;
begin
  inherited Create(TClumpData);
  fDS := TDSTocEntries.Create;
end;

destructor TProgram.Destroy;
begin
  FreeAndNil(fDS);
  inherited;
end;

function TProgram.GetItem(Index: Integer): TClumpData;
begin
  Result := TClumpData(inherited GetItem(Index));
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

function TProgram.Insert(Index: Integer): TClumpData;
begin
  Result := TClumpData(inherited Insert(Index));
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

procedure TProgram.LoadClumpData(SL: TStrings);
var
  values : TStringList;
  i, tmpID, lineNo, PC : integer;
  tmp, currentFile : string;
  CD : TClumpData;
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
            end;
            // find the clump data
            if not Assigned(CD) or (CD.ID <> tmpID) then
            begin
              CD := Self.Items[tmpID];
            end;
            CD.AddOffset(lineNo, PC, currentFile);
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
  SL := TStringList.Create;
  try
    SL.LoadFromFile(name);
    LoadDataspace(SL);
    LoadClumpData(SL);
  finally
    SL.Free;
  end;
end;

procedure TProgram.SetItem(Index: Integer; const Value: TClumpData);
begin
  inherited SetItem(Index, Value);
end;

initialization
  CP := nil;

finalization
  FreeAndNil(CP);

end.
