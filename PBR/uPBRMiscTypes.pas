unit uPBRMiscTypes;

interface

uses
  Classes, Contnrs, SysUtils, uUtilities, uPBRSimpleTypes;

type
  EArgumentOutOfRangeException = class(Exception);
  
	TRuntimePBrickPolyArgument = class
  private
    fIntValue: Integer;
    fSingleValue: single;
    fStringValue: string;
    fArgType: TArgType;
  public
    property ArgType : TArgType read fArgType write fArgType;
    property IntValue : Integer read fIntValue write fIntValue;
    property SingleValue : single read fSingleValue write fSingleValue;
    property StringValue : string read fStringValue write fStringValue;
    function ToString : string;
	end;

  TRuntimePBrickPolyArgumentList = class(TObjectList)
  protected
    function GetItem(Index: Integer): TRuntimePBrickPolyArgument;
    procedure SetItem(Index: Integer; AObject: TRuntimePBrickPolyArgument);
  public
    function Add(AObject: TRuntimePBrickPolyArgument): Integer;
    function Remove(AObject: TRuntimePBrickPolyArgument): Integer;
    function IndexOf(AObject: TRuntimePBrickPolyArgument): Integer;
    procedure Insert(Index: Integer; AObject: TRuntimePBrickPolyArgument);
    function First: TRuntimePBrickPolyArgument;
    function Last: TRuntimePBrickPolyArgument;
    property Items[Index: Integer]: TRuntimePBrickPolyArgument read GetItem write SetItem; default;
  end;

	TCVPBrickInstruction = class
  private
    fOpCode: TPBrickOpCode;
    fInstructionSize: integer;
    fParameters: TRuntimePBrickPolyArgumentList;
    fAddress: integer;
    procedure SetParameters(const Value: TRuntimePBrickPolyArgumentList);
	public
    constructor Create(opcode : TPBrickOpCode; position : integer);
    destructor Destroy; override;
    property OpCode : TPBrickOpCode read fOpCode write fOpCode;
    property InstructionSize : integer read fInstructionSize write fInstructionSize;
    property Parameters : TRuntimePBrickPolyArgumentList read fParameters write SetParameters;
    property Address : integer read fAddress write fAddress;
	end;

	TCVPBrickObject = class
  private
    fNumParameters: byte;
    fTriggerCount: byte;
    fLocalBytes: integer;
    fOffsetToInstructions: integer;
    fOwnerObjectID: SmallInt;
	public
    property OffsetToInstructions : integer read fOffsetToInstructions write fOffsetToInstructions;
    property OwnerObjectID : SmallInt read fOwnerObjectID write fOwnerObjectID;
    property TriggerCount : byte read fTriggerCount write fTriggerCount;
    property NumParameters : byte read fNumParameters write fNumParameters;
    property LocalBytes : integer read fLocalBytes write fLocalBytes;
	end;

  TCVPBrickObjectList = class(TObjectList)
  protected
    function GetItem(Index: Integer): TCVPBrickObject;
    procedure SetItem(Index: Integer; AObject: TCVPBrickObject);
  public
    function Add(AObject: TCVPBrickObject): Integer;
    function Remove(AObject: TCVPBrickObject): Integer;
    function IndexOf(AObject: TCVPBrickObject): Integer;
    procedure Insert(Index: Integer; AObject: TCVPBrickObject);
    function First: TCVPBrickObject;
    function Last: TCVPBrickObject;
    property Items[Index: Integer]: TCVPBrickObject read GetItem write SetItem; default;
  end;

  TPBrickCodeStreamReader = class
  private
    fImageData : TMemoryStream;
    fVersionInfoStr : string;
    fVersionInfoNum : SmallInt;
    fNumberOfObjects : SmallInt;
    fGlobalBytes : integer;
    fObjectHeaders : TCVPBrickObjectList;
    fInstructionsAsStrings : TStrings;
    fSubCallOffsets : TIntegers;
    fUnused32bitValue: Integer;
    procedure ReadImgHeader;
    procedure ReadObjectHeaders;
    procedure FormatInstructions(aInstruction : TCVPBrickInstruction);
    function ReadPBrickInstruction : TCVPBrickInstruction;
    procedure ReadStuff;
    procedure SubCallOffsetsAdd(aValue : integer);
    function SubCallOffsetsContains(aValue : integer) : boolean;
  public
    constructor Create(aStream : TStream);
    destructor Destroy; override;
    property VersionInfoStr : string read fVersionInfoStr;
    property NumberOfObjects : SmallInt read fNumberOfObjects;
    property Unused32bitValue : Integer read fUnused32bitValue;
    property GlobalBytes : Integer read fGlobalBytes;
    property ObjectHeaders : TCVPBrickObjectList read fObjectHeaders;
    property InstructionsAsStrings : TStrings read fInstructionsAsStrings;
    function GetImgHead : string;
  end;

  TBinaryWriterExtension = class
  public
		class procedure WriteIntArgument(aStream : TStream; argument : integer;
      argumentType : TArgType; isHandle : boolean); overload;
		class procedure WriteIntArgument(aStream : TStream; argument : integer;
      argumentType : TArgType); overload;
		class procedure WriteOpCode(aStream : TStream; opCode : TPBrickOpCode);
		class procedure WriteStringArgument(aStream : TStream; value : string);
		class procedure WriteFloatArgument(aStream : TStream; value : single);
    class procedure Write(aStream : TStream; value : byte); overload;
    class procedure Write(aStream : TStream; value : word); overload;
    class procedure Write(aStream : TStream; value : cardinal); overload;
    class procedure Write(aStream : TStream; value : single); overload;
    class procedure Write(aStream : TStream; value : string); overload;
		class function ArgSize(value : integer) : integer; overload;
		class function ArgSize(value : single) : integer; overload;
  end;

  TSystemCommandBuilder = class
  public
    class procedure EraseFlash(aStream : TStream);
    class procedure BeginFlashDownload(address, imageSize : integer; aStream : TStream);
    class procedure BeginFlashDownloadWithErase(address, imageSize : integer; aStream : TStream);
    class procedure GetVersion(aStream : TStream);
    class procedure DownloadProgram(offset, length : integer; image, aStream : TStream);
    class procedure StartApplication(aStream : TStream);
    class procedure GetChecksum(address, imageSize : integer; aStream: TStream);
    class procedure FileDownloadHeader(fileName : string; fileSize : Cardinal; aStream : TStream);
    class procedure BeginDownload(fileName : string; fileSize : Cardinal; aStream : TStream);
		class procedure FileDownloadSection(fileContents : TStream;
      chunkSize, position : integer; handle : byte; aStream : TStream); overload;
		class procedure FileDownloadSection(Data : PByte;
      chunkSize : integer; handle : byte; aStream : TStream); overload;
		class procedure ContinueDownload(fileContents : TStream;
      chunkSize, position : integer; handle : byte; aStream : TStream); overload;
		class procedure ContinueDownload(Data : PByte;
      chunkSize : integer; handle : byte; aStream : TStream); overload;
		class procedure FileUploadHeader(path : string; maxBytesToRead : integer;
      directoryList : boolean; aStream : TStream);
		class procedure BeginUpload(path : string; maxBytesToRead : integer;
      directoryList : boolean; aStream : TStream);
		class procedure FileUploadSection(handle : byte; maximumPacketSize : integer;
      directoryList : boolean; aStream : TStream);
		class procedure ContinueUpload(handle : byte; maximumPacketSize : integer;
      directoryList : boolean; aStream : TStream);
		class procedure BeginGetFile(path : string ; maxBytesToRead : integer;
      aStream : TStream);
		class procedure ContinueGetFile(handle : byte; maximumPacketSize : integer;
      aStream : TStream);
		class procedure FileDownloadCloseHandle(handle : byte; aStream : TStream);
		class procedure CloseHandle(handle : byte; aStream : TStream);
		class procedure ListFiles(path : string; aStream : TStream);
		class procedure ContinueListFiles(handle : byte; maximumPacketSize : integer;
      aStream : TStream);
		class procedure CreateDir(path : string; aStream : TStream);
		class procedure DeleteFile(fileName : string; aStream : TStream);
		class procedure ListOpenHandles(aStream : TStream);
		class procedure WriteMailbox(aName, aPayload : string; aStream : TStream);
		class procedure BluetoothPin(aAddress : string; aPin : string; aStream : TStream);
		class procedure EnterFirmwareUpdate(aStream : TStream);
  end;

  TDirectCommandBuilder = class
  private
  public
    class procedure BuildCommand(aCommandType : TCommandType;
      globals, locals : integer; args : TStream; aStream: TStream);
    class procedure StartCommand(aCommandType : TCommandType;
      globals, locals : integer; aStream: TStream);
    class procedure ObjectEnd(aStream: TStream);

    class procedure System(const cmd : string; globalOffset : byte; aStream: TStream);

		class procedure OutputTimeSync(layer, ports : byte; speed : ShortInt;
      Turn : word; Time : Integer; useBrake : boolean; aStream : TStream);
		class procedure OutputStepSync(layer, ports : byte; speed : ShortInt;
      Turn : word; Step : Integer; useBrake : boolean; aStream : TStream);
		class procedure OutputTimeSpeed(layer, ports : byte; speed : ShortInt;
      Time1, Time2, Time3 : Integer; useBrake : boolean; aStream : TStream);
		class procedure OutputStepSpeed(layer, ports : byte; speed : ShortInt;
      Step1, Step2, Step3 : Integer; useBrake : boolean; aStream : TStream);
		class procedure OutputTimePower(layer, ports : byte; power : ShortInt;
      Time1, Time2, Time3 : Integer; useBrake : boolean; aStream : TStream);
		class procedure OutputStepPower(layer, ports : byte; power : ShortInt;
      Step1, Step2, Step3 : Integer; useBrake : boolean; aStream : TStream);
		class procedure OutputGetCount(layer, port : byte; globalOffset : byte; aStream : TStream);
		class procedure OutputTest(layer, ports : byte; globalOffset : byte; aStream : TStream);
		class procedure OutputRead(layer, port : byte; globalOffset : byte; aStream : TStream);
		class procedure OutputPolarity(layer, ports : byte; polarity : ShortInt; aStream : TStream);
		class procedure OutputReset(layer, ports : byte; aStream : TStream);
		class procedure OutputPower(layer : byte; ports : byte; power : ShortInt; aStream : TStream);
		class procedure OutputSpeed(layer : byte; ports : byte; speed : ShortInt; aStream : TStream);
		class procedure OutputClearCount(layer, ports : byte; aStream : TStream);
		class procedure OutputStop(layer : byte; ports : byte; forceStop : Boolean; aStream : TStream);
		class procedure OutputStart(layer : byte; ports : byte; aStream : TStream);

		class procedure MemoryRead(slot : TProgramSlot; objId, offset, size, globalIndex : integer; aStream : TStream);
		class procedure MemoryWrite(slot : TProgramSlot; objId, offset, size, arrayHandle : integer; aStream : TStream);

    class procedure ReadArrayContent(slot : TProgramSlot; arrayHandle, index, bytes, dataOut : integer; aStream : TStream);
    class procedure ReadArraySize(slot: TProgramSlot; arrayHandle, dataOut: integer; aStream: TStream);

		class procedure InputDeviceGetTypeMode(layer : byte; port : TPortId; globalIndexType, globalIndexMode : byte; aStream : TStream);
		class procedure InputDeviceGetName(layer : byte; port : TPortId; maxLen : byte; globalIndex : byte; aStream : TStream);
		class procedure InputDeviceGetSymbol(layer : byte; port : TPortId; maxLen : byte; globalIndex : byte; aStream : TStream);
		class procedure InputDeviceGetFormat(layer : byte; port : TPortId; giDatasets, giFormat, giModes, giViews : byte; aStream : TStream);
		class procedure InputDeviceGetRaw(layer : byte; port : TPortId; globalIndex : byte; aStream : TStream);
		class procedure InputDeviceGetModeName(layer : byte; port : TPortId; mode : byte; maxLen : byte; globalIndex : byte; aStream : TStream);
    class procedure InputDeviceGetFigures(layer: byte; port: TPortId; giFigures, giDecimals: byte; aStream: TStream);
    class procedure InputDeviceGetMinMax(layer: byte; port: TPortId; giMin, giMax: byte; aStream: TStream);
    class procedure InputDeviceReadyPct(layer: byte; port: TPortId; stype, smode, numValues : byte; globalIndex: byte; aStream: TStream);
    class procedure InputDeviceReadyRaw(layer: byte; port: TPortId; stype, smode, numValues : byte; globalIndex: byte; aStream: TStream);
    class procedure InputDeviceReadySI(layer: byte; port: TPortId; stype, smode, numValues : byte; globalIndex: byte; aStream: TStream);
    class procedure InputDeviceGetChanges(layer: byte; port: TPortId; giValue: byte; aStream: TStream);
    class procedure InputDeviceGetBumps(layer: byte; port: TPortId; giValue: byte; aStream: TStream);
    class procedure InputDeviceClearChanges(layer : byte; port : TPortId; aStream : TStream);
    class procedure InputDeviceCalMinMax(stype, smode : byte; aMin, aMax : Integer; aStream : TStream);
    class procedure InputDeviceCalMin(stype, smode : byte;  aMin : Integer; aStream : TStream);
    class procedure InputDeviceCalMax(stype, smode : byte;  aMax : Integer; aStream : TStream);
    class procedure InputDeviceCalDefault(stype, smode : byte; aStream : TStream);
//    class procedure InputDeviceSetup(TBD; aStream : TStream);
    class procedure InputDeviceClearAll(layer : byte; aStream : TStream);
    class procedure InputDeviceStopAll(layer : byte; aStream : TStream);

    // opINPUT_DEVICE_LIST (LENGTH, ARRAY, CHANGED)
    // opINPUT_TEST (LAYER, NO, BUSY)
    // opINPUT_READY (LAYER, NO)
    // opINPUT_READEXT (LAYER, NO, TYPE, MODE, FORMAT, VALUES, VALUE1)
    // opINPUT_SAMPLE (TIME, SAMPLES, INIT, DEVICES, TYPES, MODES, DATASETS, VALUES)

		class procedure InputRead(layer : byte; port : TPortId; stype, smode, readSI, globalIndex : byte; aStream : TStream);
		class procedure InputReadyRead(layer : byte; port : TPortId; stype, smode, numValues, readSI, globalIndex : byte; aStream : TStream);

		class procedure InputTest(layer : byte; port : TPortId; globalIndex : byte; aStream : TStream);

    class procedure InputWrite(layer : byte; port : TPortId; data : TStream; aStream : TStream); overload;
    class procedure InputWrite(layer : byte; port : TPortId; data : TJCHBytes; aStream : TStream); overload;

		class procedure PutInMruList(fileName : string; aStream : TStream);
		class procedure LoadImage(imageName : string; slot, size, address : integer; aStream : TStream);

		class procedure RenameBrick(name : string; aStream : TStream);
		class procedure GetBrickName(maxLength, globalOffset : byte; aStream : TStream);

    class procedure SetDatalogSyncTimeAndTick(globalScratch : integer; aStream: TStream);
		class procedure GetFavorItemsCount(aStream : TStream);
		class procedure GetFavorItem(index : byte; aStream : TStream);

		class procedure ProgramStart(slot : TProgramSlot; size, address : integer; mode : TProgramStartMode; aStream : TStream);
		class procedure ProgramObjectStart(slot : TProgramSlot; objectID : integer; aStream : TStream);
		class procedure ProgramStop(slot : TProgramSlot; aStream : TStream);
		class procedure GetProgramStatus(slot : TProgramSlot; statusGlobalIndex : byte; aStream : TStream);

		class procedure GetBrickBatteryVoltage(blockIndex : byte; aStream : TStream);
		class procedure GetBrickBatteryLevel(blockIndex : byte; aStream : TStream);
		class procedure GetBrickPowerStatus(blockIndex : byte; aStream : TStream);
		class procedure GetBrickBatteryCurrent(blockIndex : byte; aStream : TStream);
		class procedure GetBrickIntegratedCurrent(blockIndex : byte; aStream : TStream);
		class procedure GetBrickMotorCurrent(blockIndex : byte; aStream : TStream);
		class procedure GetBrickBatteryTemp(blockIndex : byte; aStream : TStream);
		class procedure GetBrickSDCardStatus(presentIndex, totalKBIndex, freeKBIndex : byte; aStream : TStream);
		class procedure GetBrickUSBStickStatus(presentIndex, totalKBIndex, freeKBIndex : byte; aStream : TStream);
		class procedure GetOnBrickStorageStatus(totalKBIndex, freeKBIndex : byte; aStream : TStream);
		class procedure GetBrickFirmwareVersion(stringLength, stringIndex : byte; aStream : TStream);
		class procedure GetBrickHardwareVersion(stringLength, stringIndex : byte; aStream : TStream);
		class procedure GetBrickFirmwareBuild(stringLength, stringIndex : byte; aStream : TStream);
    class procedure GetBrickOSVersion(stringLength, stringIndex: byte; aStream: TStream);
    class procedure GetBrickOSBuild(stringLength, stringIndex: byte; aStream: TStream);
    class procedure GetBrickVersion(stringLength, stringIndex: byte; aStream: TStream);
    class procedure GetBrickIPAddress(stringLength, stringIndex: byte; aStream: TStream);
    class procedure GetBrickBTAddress(maxLength, globalOffset: byte; aStream: TStream);

		class procedure MoveValueToGlobal(value, globalIndex : integer; aStream : TStream);
		class procedure InitBytes(destinationIndex : integer; values : TJCHBytes; aStream : TStream);

		class procedure DoesFileExist(fileName : string; statusGlobalIndex : byte; aStream : TStream);
		class procedure DeleteFile(path : string; aStream : TStream);
		class procedure CopyFile(sourcePath, destinationPath : string; aStream : TStream);
		class procedure DownloadCompleteSound(aStream : TStream);
    class procedure CleanDirectory(path: string; aStream: TStream);
    class procedure ResolveLogFileName(path: string; aStream: TStream);
    class procedure MakeFolder(name : string; globalOffset: byte; aStream : TStream);

    class procedure PlayTone(volume : byte; frequency, duration : word; aStream : TStream);
    class procedure StopSound(aStream : TStream);
    class procedure PlaySoundFile(filename : string; volume, loop : byte; aStream : TStream);
    class procedure SoundReady(aStream: TStream);
    class procedure KeepAlive(blockIndex: byte; aStream: TStream);
    class procedure SetSleepMinutes(minutes: byte; aStream: TStream);

    class procedure ButtonFlush(aStream : TStream);
    class procedure ButtonWaitForPress(aStream : TStream);
    class procedure ButtonPressed(btn, globalOffset : byte; aStream : TStream);
    class procedure ButtonShortPressed(btn, globalOffset : byte; aStream : TStream);
    class procedure ButtonGetBumped(btn, globalOffset : byte; aStream : TStream);
    class procedure ButtonLongPressed(btn, globalOffset : byte; aStream : TStream);
    class procedure ButtonPress(btn : byte; aStream : TStream);
    class procedure ButtonRelease(btn : byte; aStream : TStream);
    class procedure ButtonGetHorz(globalOffset : byte; aStream : TStream);
    class procedure ButtonGetVert(globalOffset : byte; aStream : TStream);
    class procedure ButtonGetClick(globalOffset : byte; aStream : TStream);
(*
    ubcSetBackBlock, // 10
    ubcGetBackBlock,
    ubcTestShortPress,
    ubcTestLongPress,
*)
(*
 *  <b>     opUI_BUTTON (CMD, ....)  </b>
 *  - CMD = SET_BACK_BLOCK
 *    -  \param  (DATA8)   BLOCKED  - Set UI back button blocked flag (0 = not blocked, 1 = blocked)\n
 *
 *  - CMD = GET_BACK_BLOCK
 *    -  \return (DATA8)   BLOCKED  - Get UI back button blocked flag (0 = not blocked, 1 = blocked)\n
 *
 *  - CMD = TESTSHORTPRESS
 *    -  \param  (DATA8)   BUTTON   - \ref buttons \n
 *    -  \return (DATA8)   STATE    - Button has been hold down(0 = no, 1 = yes)\n
 *
 *  - CMD = TESTLONGPRESS
 *    -  \param  (DATA8)   BUTTON   - \ref buttons \n
 *    -  \return (DATA8)   STATE    - Button has been hold down(0 = no, 1 = yes)\n
*)
  end;

  TCrcCalculator = class
  private
    fTable : array of Cardinal;
    fCrc32Ieee : Cardinal;
    procedure InitializeTable(aPoly : Cardinal);
  public
    constructor Create; overload;
    constructor Create(aPoly : Cardinal); overload;
    destructor Destroy; override;
    function CalculateCrc(buffer : TStream; crc : Cardinal = 0) : Cardinal; overload;
    function CalculateCrc(buffer : TStream; length : integer; crc : Cardinal) : Cardinal; overload;
    function CalculateCrc(buffer : TByteArray; len : integer; crc : Cardinal) : Cardinal; overload;
  end;

	TPBrickGenericCommandObject = class
  private
    fStream : TStream;
    procedure SetStream(const Value: TStream);
//    function GetArray: TByteArray;
  public
    constructor Create;
    destructor Destroy; override;
    property OutStream : TStream read fStream write SetStream;
    property BaseStream : TStream read fStream;
//    property ToArray : TByteArray read GetArray;
    procedure Write(aValue : Integer); overload;
    procedure Write(aValue : Byte); overload;
    procedure Write(aValue : TCommandType); overload;
    procedure Write(aValue : TRecoveryCommand); overload;
    function Seek(Offset: Longint; Origin: Word): Longint;
  end;

	TPBrickDirectCommandObject = class(TPBrickGenericCommandObject)
  public
    constructor Create(commandType : TCommandType; globals, locals : integer);
  end;



implementation

uses
  Math, uStreamRW;

{ TCVPBrickObjectList }

function TCVPBrickObjectList.Add(AObject: TCVPBrickObject): Integer;
begin
  Result := inherited Add(AObject);
end;

function TCVPBrickObjectList.First: TCVPBrickObject;
begin
  Result := TCVPBrickObject(inherited First);
end;

function TCVPBrickObjectList.GetItem(Index: Integer): TCVPBrickObject;
begin
  Result := TCVPBrickObject(inherited Items[Index]);
end;

function TCVPBrickObjectList.IndexOf(AObject: TCVPBrickObject): Integer;
begin
  Result := inherited IndexOf(AObject);
end;

procedure TCVPBrickObjectList.Insert(Index: Integer; AObject: TCVPBrickObject);
begin
  inherited Insert(Index, AObject);
end;

function TCVPBrickObjectList.Last: TCVPBrickObject;
begin
  Result := TCVPBrickObject(inherited Last);
end;

function TCVPBrickObjectList.Remove(AObject: TCVPBrickObject): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TCVPBrickObjectList.SetItem(Index: Integer; AObject: TCVPBrickObject);
begin
  inherited Items[Index] := AObject;
end;

{ TPBrickCodeStreamReader }

constructor TPBrickCodeStreamReader.Create(aStream : TStream);
begin
  fImageData := TMemoryStream.Create;
  fImageData.CopyFrom(aStream, 0);
  fImageData.Position := 0;
  fObjectHeaders := TCVPBrickObjectList.Create(true);
  fInstructionsAsStrings := TStringList.Create;
  SetLength(fSubCallOffsets, 0);
  ReadImgHeader;
  ReadObjectHeaders;
  ReadStuff;
end;

destructor TPBrickCodeStreamReader.Destroy;
begin
  FreeAndNil(fImageData);
  FreeAndNil(fInstructionsAsStrings);
  FreeAndNil(fObjectHeaders);
  SetLength(fSubCallOffsets, 0);
  inherited;
end;

procedure TPBrickCodeStreamReader.FormatInstructions(aInstruction: TCVPBrickInstruction);
begin
(*
			StringBuilder stringBuilder = new StringBuilder(100);
			stringBuilder.AppendFormat("{0,-4}:{1,-12}  ", new object[]
			{
				instruction.Address,
				instruction.OpCode.ToString()
			});
			bool flag = true;
			using (List<PolyArgument>.Enumerator enumerator = instruction.Parameters.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					PolyArgument current = enumerator.Current;
					if (flag)
					{
						flag = false;
					}
					else
					{
						stringBuilder.Append(", ");
					}
					stringBuilder.AppendFormat(current.ToString(), new object[0]);
				}
			}
			this._instructionsAsStrings.Add(stringBuilder.ToString());
*)
end;

function TPBrickCodeStreamReader.GetImgHead: string;
begin
(*
			string text = string.Empty;
			object obj = text;
			text = string.Concat(new object[]
			{
				obj,
				"Version ",
				this._versionInfoStr,
				this._versionInfoNum,
				"\n"
			});
			obj = text;
			text = string.Concat(new object[]
			{
				obj,
				"# Objects ",
				this._numberOfObjects,
				"\n"
			});
			obj = text;
			return string.Concat(new object[]
			{
				obj,
				"Global bytes ",
				this._globalBytes,
				"\n"
			});
*)
end;

procedure TPBrickCodeStreamReader.ReadImgHeader;
var
  buffer : array[0..4] of Char;
  i : integer;
begin
  for i := Low(buffer) to High(buffer) do
    buffer[i] := #0;
  fImageData.Read(buffer, 4);
  fVersionInfoStr   := buffer;
  fUnused32bitValue := ReadInteger(fImageData);
  fVersionInfoNum   := ReadSmallInt(fImageData);
  fNumberOfObjects  := ReadSmallInt(fImageData);
  fGlobalBytes      := ReadInteger(fImageData);
end;

procedure TPBrickCodeStreamReader.ReadObjectHeaders;
var
  i : integer;
  pbo : TCVPBrickObject;
begin
  for i := 0 to fNumberOfObjects - 1 do
  begin
    pbo := TCVPBrickObject.Create;
    pbo.OffsetToInstructions := ReadInteger(fImageData);
    pbo.OwnerObjectID        := ReadSmallInt(fImageData);
    pbo.TriggerCount         := ReadByte(fImageData);
    pbo.NumParameters        := ReadByte(fImageData);
    pbo.LocalBytes           := ReadInteger(fImageData);
    fObjectHeaders.Add(pbo);
    if (pbo.OwnerObjectID = 0) and (pbo.TriggerCount = 1) then
    begin
      SubCallOffsetsAdd(pbo.OffsetToInstructions);
    end;
  end;
end;

function TPBrickCodeStreamReader.ReadPBrickInstruction: TCVPBrickInstruction;
var
  position : integer;
  pbo : TPBrickOpCode;
begin
  position := Integer(fImageData.Position);
  pbo := TPBrickOpCode(ReadByte(fImageData));
  Result := TCVPBrickInstruction.Create(pbo, position);

(*
			ArgType[] argTypes = pBrickOpCode.GetArgTypes();
			instruction.Parameters = new List<PolyArgument>();
			ArgType[] array = argTypes;
			for (int i = 0; i < array.Length; i++)
			{
				ArgType expectedType = array[i];
				instruction.Parameters.Add(stream.ReadArg(expectedType));
			}
			PBrickOpCode opCode = instruction.OpCode;
			if (opCode <= PBrickOpCode.opUIDRAW)
			{
				if (opCode == PBrickOpCode.opCALL)
				{
					int intValue = instruction.Parameters.Item(1).IntValue;
					for (int j = 0; j < intValue; j++)
					{
						instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
					}
					return instruction;
				}
				switch (opCode)
				{
				case PBrickOpCode.opINFO:
				case PBrickOpCode.opUIREAD:
					break;
				case PBrickOpCode.opSTRING:
					stream.AddStringArguments(instruction);
					return instruction;
				case PBrickOpCode.opMemoryWrite:
				case PBrickOpCode.opMemoryRead:
				case PBrickOpCode.opUIFLUSH:
				case PBrickOpCode.opUIBUTTON:
					return instruction;
				case PBrickOpCode.opUIWRITE:
					stream.AddUIWriteArguments(instruction);
					return instruction;
				case PBrickOpCode.opUIDRAW:
					stream.AddUIDrawArguments(instruction);
					return instruction;
				default:
					return instruction;
				}
			}
			else
			{
				switch (opCode)
				{
				case PBrickOpCode.opCOMREAD:
				case PBrickOpCode.opCOMWRITE:
				case PBrickOpCode.opSOUND:
					break;
				case (PBrickOpCode)147:
					return instruction;
				default:
					switch (opCode)
					{
					case PBrickOpCode.opFILE:
						break;
					case PBrickOpCode.opARRAY:
						stream.AddArrayArguments(instruction);
						return instruction;
					default:
						return instruction;
					}
					break;
				}
			}
			throw new NotImplementedException("opcode not decoded" + instruction.OpCode.ToString());
		}
*)

(*
		private static void AddArrayArguments(this BinaryReader stream, Instruction instruction)
		{
			switch (instruction.Parameters.Item(0).IntValue)
			{
			case 0:
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				break;
			case 1:
			case 2:
			case 3:
			case 4:
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.VariableOut));
				break;
			case 5:
			case 7:
			case 12:
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				break;
			case 6:
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				break;
			case 8:
			case 9:
			case 10:
			case 11:
			{
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				PolyArgument polyArgument = stream.ReadArg(ArgType.Integer);
				instruction.Parameters.Add(polyArgument);
				for (int i = 0; i < polyArgument.IntValue; i++)
				{
					instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				}
				break;
			}
			default:
				throw new NotImplementedException("ArrayCommand not uspported" + (ArrayCommand)instruction.Parameters.Item(0).IntValue);
			}
		}
		private static void AddStringArguments(this BinaryReader stream, Instruction instruction)
		{
			switch (instruction.Parameters.Item(0).IntValue)
			{
			case 1:
			case 5:
				instruction.Parameters.Add(stream.ReadArg(ArgType.String));
				instruction.Parameters.Add(stream.ReadArg(ArgType.VariableOut));
				return;
			case 2:
			case 3:
				instruction.Parameters.Add(stream.ReadArg(ArgType.String));
				instruction.Parameters.Add(stream.ReadArg(ArgType.String));
				instruction.Parameters.Add(stream.ReadArg(ArgType.VariableOut));
				return;
			}
			throw new NotImplementedException("StringCommand not uspported" + (StringCommand)instruction.Parameters.Item(0).IntValue);
		}
		private static void AddUIDrawArguments(this BinaryReader stream, Instruction instruction)
		{
			switch (instruction.Parameters.Item(0).IntValue)
			{
			case 0:
			case 1:
				return;
			case 3:
			case 10:
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				return;
			case 4:
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				return;
			case 5:
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.String));
				return;
			case 8:
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				return;
			}
			throw new NotImplementedException("UiDrawCommand not supported" + (UiWriteCommand)instruction.Parameters.Item(0).IntValue);
		}
		private static void AddUIWriteArguments(this BinaryReader stream, Instruction instruction)
		{
			switch (instruction.Parameters.Item(0).IntValue)
			{
			case 8:
				instruction.Parameters.Add(stream.ReadArg(ArgType.String));
				break;
			case 9:
			case 10:
			case 11:
				instruction.Parameters.Add(stream.ReadArg(ArgType.Integer));
				break;
			default:
				throw new NotImplementedException("UiWriteCommand not supported" + (UiWriteCommand)instruction.Parameters.Item(0).IntValue);
			}
		}
*)
end;

procedure TPBrickCodeStreamReader.ReadStuff;
var
  num : integer;
  instr : TCVPBrickInstruction;
begin
  if fImageData.Position <> fObjectHeaders[0].OffsetToInstructions then
    raise Exception.Create('PBrick byte code not doing what we expected to do');
  while fImageData.Position < fImageData.Size do
  begin
    if SubCallOffsetsContains(Integer(fImageData.Position)) then
    begin
      num := Integer(ReadByte(fImageData));
      // skip past num bytes
      fImageData.Position := fImageData.Position + num;
    end;
//    Instruction instruction = reader.ReadPBrickInstruction();
//    FormatInstructions(instruction);
  end;
end;

procedure TPBrickCodeStreamReader.SubCallOffsetsAdd(aValue: integer);
var
  len : integer;
begin
  len := Length(fSubCallOffsets);
  SetLength(fSubCallOffsets, len+1);
  fSubCallOffsets[len] := aValue;
end;

function TPBrickCodeStreamReader.SubCallOffsetsContains(aValue: integer): boolean;
var
  i : integer;
begin
  Result := False;
  for i := 0 to Length(fSubCallOffsets) - 1 do
  begin
    if fSubCallOffsets[i] = aValue then
    begin
      Result := True;
      break;
    end;
  end;
end;

(*
		private static string ReadStringBytes(this BinaryReader stream)
		{
			byte[] array = new byte[2000];
			int num = 0;
			byte b;
			do
			{
				b = stream.ReadByte();
				array[num++] = b;
			}
			while (b != 0);
			return Encoding.UTF8.GetString(array, 0, num);
		}
		private static int ReadIntValueBytes(this BinaryReader stream, LeadByte leadByte)
		{
			int result;
			if ((byte)(leadByte & LeadByte.LongFormatFlag) != 0)
			{
				switch ((byte)(leadByte & LeadByte.BytesToFollowMask))
				{
				case 1:
					result = (int)stream.ReadByte();
					break;
				case 2:
					result = (int)stream.ReadInt16();
					break;
				case 3:
					result = stream.ReadInt32();
					break;
				default:
					throw new IOException("bad byte count encoding");
				}
			}
			else
			{
				result = (int)((byte)(leadByte & LeadByte.ShortValueMask));
			}
			return result;
		}
		public static PolyArgument ReadArg(this BinaryReader stream, ArgType expectedType)
		{
			LeadByte leadByte = (LeadByte)stream.ReadByte();
			PolyArgument polyArgument = new PolyArgument();
			if ((byte)(leadByte & LeadByte.VariableFlag) != 0)
			{
				if ((byte)(leadByte & LeadByte.GlobalVariableFlag) != 0)
				{
					polyArgument.ArgType = ArgType.GlobalOffset;
				}
				else
				{
					polyArgument.ArgType = ArgType.LocalOffset;
				}
				polyArgument.IntValue = stream.ReadIntValueBytes(leadByte);
			}
			else
			{
				if ((byte)(leadByte & LeadByte.LongFormatFlag) != 0)
				{
					if ((byte)(leadByte & LeadByte.BytesToFollowMask) == 0)
					{
						polyArgument.ArgType = ArgType.String;
						polyArgument.StringValue = stream.ReadStringBytes();
						polyArgument.StringValue = polyArgument.StringValue.Replace('\0', '*');
					}
					else
					{
						if (expectedType == ArgType.FloatingPoint)
						{
							polyArgument.SingleValue = stream.ReadSingle();
							polyArgument.ArgType = expectedType;
						}
						else
						{
							polyArgument.IntValue = stream.ReadIntValueBytes(leadByte);
							polyArgument.ArgType = expectedType;
						}
					}
				}
				else
				{
					polyArgument.ArgType = expectedType;
					if ((byte)(leadByte & LeadByte.GlobalVariableFlag) != 0)
					{
						polyArgument.IntValue = (int)((byte)(leadByte & LeadByte.ShortValueMask) | 224);
					}
					else
					{
						polyArgument.IntValue = (int)((byte)(leadByte & LeadByte.ShortValueMask));
					}
				}
			}
			return polyArgument;
		}
*)

{ TCVPBrickInstruction }

constructor TCVPBrickInstruction.Create(opcode: TPBrickOpCode; position: integer);
begin
  fParameters := TRuntimePBrickPolyArgumentList.Create(true);
  fOpCode := opcode;
  fAddress := position;
end;

destructor TCVPBrickInstruction.Destroy;
begin
  FreeAndNil(fParameters);
  inherited;
end;

procedure TCVPBrickInstruction.SetParameters(const Value: TRuntimePBrickPolyArgumentList);
begin
  //
end;

{ TRuntimePBrickPolyArgument }

function TRuntimePBrickPolyArgument.ToString: string;
begin
  case fArgType of
    atInteger, atObjectId, atProgramSlot : begin
      Result := IntToStr(fIntValue);
    end;
    atFloatingPoint : begin
      Result := FloatToStr(fSingleValue);
    end;
    atString : begin
      Result := '"' + fStringValue + '"';
    end;
    atLocalOffset : begin
      Result := 'L[' + IntToStr(fIntValue) + ']';
    end;
    atGlobalOffset : begin
      Result := 'G[' + IntToStr(fIntValue) + ']';
    end;
    atLabelOffset : begin
      Result := '#' + IntToStr(fIntValue);
    end;
    atStringCommand : begin
      Result := StringCommandToStr(TStringCommand(fIntValue));
    end;
    atFileCommand : begin
      Result := FileCommandToStr(TFileSubCommand(fIntValue));
    end;
    atMemoryCommand : begin
      Result := MemoryCommandToStr(TMemoryCommand(fIntValue));
    end;
    atArrayCommand : begin
      Result := ArrayCommandToStr(TArraySubCommand(fIntValue));
    end;
    atUiWriteCommand : begin
      Result := UiWriteCommandToStr(TUiWriteCommand(fIntValue));
    end;
    atUiDrawCommand : begin
      Result := UiDrawCommandToStr(TUiDrawCommand(fIntValue));
    end;
  else
    Result := 'TODO:' + ArgTypeToStr(fArgType);
  end;
end;

{ TRuntimePBrickPolyArgumentList }

function TRuntimePBrickPolyArgumentList.Add(AObject: TRuntimePBrickPolyArgument): Integer;
begin
  Result := inherited Add(AObject);
end;

function TRuntimePBrickPolyArgumentList.First: TRuntimePBrickPolyArgument;
begin
  Result := TRuntimePBrickPolyArgument(inherited First);
end;

function TRuntimePBrickPolyArgumentList.GetItem(Index: Integer): TRuntimePBrickPolyArgument;
begin
  Result := TRuntimePBrickPolyArgument(inherited Items[Index]);
end;

function TRuntimePBrickPolyArgumentList.IndexOf(AObject: TRuntimePBrickPolyArgument): Integer;
begin
  Result := inherited IndexOf(AObject);
end;

procedure TRuntimePBrickPolyArgumentList.Insert(Index: Integer; AObject: TRuntimePBrickPolyArgument);
begin
  inherited Insert(Index, AObject);
end;

function TRuntimePBrickPolyArgumentList.Last: TRuntimePBrickPolyArgument;
begin
  Result := TRuntimePBrickPolyArgument(inherited Last);
end;

function TRuntimePBrickPolyArgumentList.Remove(AObject: TRuntimePBrickPolyArgument): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TRuntimePBrickPolyArgumentList.SetItem(Index: Integer; AObject: TRuntimePBrickPolyArgument);
begin
  inherited Items[Index] := AObject;
end;


{ TSystemCommandBuilder }

class procedure TSystemCommandBuilder.FileDownloadHeader(fileName: string;
  fileSize: Cardinal; aStream : TStream);
begin
  BeginDownload(fileName, fileSize, aStream);
end;

class procedure TSystemCommandBuilder.BeginDownload(fileName: string;
  fileSize: Cardinal; aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycFileDownloadHeader));
  WriteCardinal(aStream, fileSize);
  WriteString(aStream, fileName);
  WriteByte(aStream, 0); // write the null terminator at the end of the string
end;

class procedure TSystemCommandBuilder.FileDownloadSection(fileContents: TStream;
  chunkSize, position: integer; handle: byte; aStream : TStream);
begin
  ContinueDownload(fileContents, chunkSize, position, handle, aStream);
end;

class procedure TSystemCommandBuilder.FileDownloadSection(Data : PByte;
  chunkSize: integer; handle: byte; aStream : TStream);
begin
  ContinueDownload(Data, chunkSize, handle, aStream);
end;

class procedure TSystemCommandBuilder.ContinueDownload(fileContents: TStream;
  chunkSize, position: integer; handle: byte; aStream : TStream);
begin
  if chunkSize > 65532 then
    raise EArgumentOutOfRangeException.Create('ChunkSize exceeds capacity');
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycFileDownloadBlock));
  WriteByte(aStream, handle);
  // copy portion of file contents into output stream
  fileContents.Seek(position, soFromBeginning);
  aStream.CopyFrom(fileContents, chunkSize);
end;

class procedure TSystemCommandBuilder.ContinueDownload(Data : PByte;
  chunkSize: integer; handle: byte; aStream : TStream);
begin
  if chunkSize > 65532 then
    raise EArgumentOutOfRangeException.Create('ChunkSize exceeds capacity');
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycFileDownloadBlock));
  WriteByte(aStream, handle);
  // copy portion of file contents into output stream
  aStream.Write(Data^, chunkSize);
end;

class procedure TSystemCommandBuilder.FileUploadHeader(path : string;
  maxBytesToRead : integer; directoryList : boolean; aStream : TStream);
begin
  BeginUpload(path, maxBytesToRead, directoryList, aStream);
end;

class procedure TSystemCommandBuilder.BeginUpload(path: string;
  maxBytesToRead: integer; directoryList : boolean; aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  if directoryList then
    WriteByte(aStream, Ord(sycListFiles))
  else
    WriteByte(aStream, Ord(sycBeginUpload));
  WriteWord(aStream, Word(maxBytesToRead));
  WriteString(aStream, path);
  WriteByte(aStream, 0); // null terminator
end;

class procedure TSystemCommandBuilder.FileUploadSection(handle: byte;
  maximumPacketSize: integer; directoryList : boolean; aStream : TStream);
begin
  ContinueUpload(handle, maximumPacketSize, directoryList, aStream);
end;

class procedure TSystemCommandBuilder.ContinueUpload(handle: byte;
  maximumPacketSize: integer; directoryList : boolean; aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  if directoryList then
    WriteByte(aStream, Ord(sycContinueListFiles))
  else
    WriteByte(aStream, Ord(sycContinueUpload));
  WriteByte(aStream, handle);
  WriteWord(aStream, Word(maximumPacketSize));
end;

class procedure TSystemCommandBuilder.BeginGetFile(path: string;
  maxBytesToRead: integer; aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycBeginGetFile));
  WriteWord(aStream, Word(maxBytesToRead));
  WriteString(aStream, path);
  WriteByte(aStream, 0); // null terminator
end;

class procedure TSystemCommandBuilder.ContinueGetFile(handle: byte;
  maximumPacketSize: integer; aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycContinueGetFile));
  WriteByte(aStream, handle);
  WriteWord(aStream, Word(maximumPacketSize));
end;

class procedure TSystemCommandBuilder.FileDownloadCloseHandle(handle: byte;
  aStream : TStream);
begin
  CloseHandle(handle, aStream);
end;

class procedure TSystemCommandBuilder.CloseHandle(handle: byte;
  aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycCloseHandle));
  WriteByte(aStream, handle);
  WriteCardinal(aStream, 0);
  WriteCardinal(aStream, 0);
end;

class procedure TSystemCommandBuilder.ListFiles(path: string;
  aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycListFiles));
  WriteWord(aStream, 900); // max bytes to read
  WriteString(aStream, path);
  WriteByte(aStream, 0); // null terminator
end;

class procedure TSystemCommandBuilder.ContinueListFiles(handle : byte; maximumPacketSize : integer;
  aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycContinueListFiles));
  WriteByte(aStream, handle);
  WriteWord(aStream, Word(maximumPacketSize));
end;

class procedure TSystemCommandBuilder.CreateDir(path: string;
  aStream: TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycCreateDir));
  WriteString(aStream, path);
  WriteByte(aStream, 0); // null terminator
end;

class procedure TSystemCommandBuilder.DeleteFile(fileName: string;
  aStream: TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycDeleteFile));
  WriteString(aStream, fileName);
  WriteByte(aStream, 0); // null terminator
end;

class procedure TSystemCommandBuilder.ListOpenHandles(aStream: TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycListOpenHandles));
end;

class procedure TSystemCommandBuilder.WriteMailbox(aName, aPayload: string;
  aStream: TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycWriteMailbox));
  WriteByte(aStream, Length(aName));
  WriteString(aStream, aName);
  WriteByte(aStream, 0); // null terminator
  WriteWord(aStream, Length(aPayload));
  WriteString(aStream, aPayload);
  WriteByte(aStream, 0); // null terminator
end;

class procedure TSystemCommandBuilder.BluetoothPin(aAddress: string;
  aPin: string; aStream: TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycBluetoothPin));
  WriteByte(aStream, Length(aAddress) + 1); // # bytes in bt address
  WriteString(aStream, aAddress);
  WriteByte(aStream, 0); // null terminator
  WriteByte(aStream, Length(aPin) + 1); // # bytes in Pin
  WriteString(aStream, aPin);
  WriteByte(aStream, 0); // null terminator
(*
  byte[] response;
  if (this.CasperDevice.SendMessage(commandBytes, true).TryReceiveMessage(out response) && response[0] == 3)
  {
    byte commandType = response[0];
    byte command = response[1];
    byte returnStatus = response[2];
    byte maclength = response[3];
    byte pinlength = response[17];
    string remoteMac = Encoding.UTF8.GetString(response, 4, 12);
    string remotePin = Encoding.UTF8.GetString(response, 18, 4);
  }
*)
end;

class procedure TSystemCommandBuilder.EnterFirmwareUpdate(aStream: TStream);
begin
  WriteByte(aStream, Ord(ctSystemNoReply));
  WriteByte(aStream, Ord(sycEnterFirmwareUpdate));
end;

class procedure TSystemCommandBuilder.EraseFlash(aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(rcChipErase));
end;

class procedure TSystemCommandBuilder.BeginFlashDownload(address,
  imageSize: integer; aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(rcBeginDownload));
  WriteInteger(aStream, address);
  WriteInteger(aStream, imageSize);
end;

class procedure TSystemCommandBuilder.BeginFlashDownloadWithErase(address,
  imageSize: integer; aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(rcBeginDownloadWithErase));
  WriteInteger(aStream, address);
  WriteInteger(aStream, imageSize);
end;

class procedure TSystemCommandBuilder.GetVersion(aStream : TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(rcGetVersion));
end;

class procedure TSystemCommandBuilder.DownloadProgram(offset, length : integer; image, aStream: TStream);
begin
  // create packet for 'length' bytes from 'image' starting at 'offset'
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(rcDownloadData));
  image.Seek(offset, soFromBeginning);
  aStream.CopyFrom(image, length);
end;

class procedure TSystemCommandBuilder.StartApplication(aStream: TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(rcStartApp));
end;

class procedure TSystemCommandBuilder.GetChecksum(address,
  imageSize: integer; aStream: TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(rcGetChecksum));
  WriteInteger(aStream, address);
  WriteInteger(aStream, imageSize);
end;

{ TDirectCommandBuilder }

class procedure TDirectCommandBuilder.BuildCommand(aCommandType : TCommandType;
  globals, locals : integer; args : TStream; aStream: TStream);
begin
  StartCommand(aCommandType, globals, locals, aStream);
  if Assigned(args) then
    aStream.CopyFrom(args, 0);
  ObjectEnd(aStream);
end;

class procedure TDirectCommandBuilder.StartCommand(
  aCommandType: TCommandType; globals, locals: integer; aStream: TStream);
begin
  WriteByte(aStream, Byte(aCommandType));
  WriteByte(aStream, Byte(globals and 255));
  WriteByte(aStream, Byte(((locals and 63) shl 2) or ((globals shr 8) and 3)));
end;

class procedure TDirectCommandBuilder.ObjectEnd(aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOBJECTEND);
end;

class procedure TDirectCommandBuilder.OutputTimeSync(layer, ports : byte; speed : ShortInt;
  Turn : word; Time : Integer; useBrake : boolean; aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTTIMESPEED);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.WriteIntArgument(aStream, speed, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Turn, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Time, atInteger);
  TBinaryWriterExtension.Write(aStream, Byte(Ord(useBrake)));
end;

class procedure TDirectCommandBuilder.OutputStepSync(layer, ports : byte; speed : ShortInt;
  Turn : word; Step : Integer; useBrake : boolean; aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTSTEPSYNC);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.WriteIntArgument(aStream, speed, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Turn, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Step, atInteger);
  TBinaryWriterExtension.Write(aStream, Byte(Ord(useBrake)));
end;

class procedure TDirectCommandBuilder.OutputTimeSpeed(layer, ports : byte;
  speed : ShortInt; Time1, Time2, Time3 : Integer; useBrake : boolean;
  aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTTIMESPEED);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.WriteIntArgument(aStream, speed, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Time1, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Time2, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Time3, atInteger);
  TBinaryWriterExtension.Write(aStream, Byte(Ord(useBrake)));
end;

class procedure TDirectCommandBuilder.OutputStepSpeed(layer, ports : byte;
  speed : ShortInt; Step1, Step2, Step3 : Integer; useBrake : boolean;
  aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTSTEPSPEED);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.WriteIntArgument(aStream, speed, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Step1, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Step2, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Step3, atInteger);
  TBinaryWriterExtension.Write(aStream, Byte(Ord(useBrake)));
end;

class procedure TDirectCommandBuilder.OutputTimePower(layer, ports : byte;
  power : ShortInt; Time1, Time2, Time3 : Integer; useBrake : boolean;
  aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTTIMEPOWER);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.WriteIntArgument(aStream, power, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Time1, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Time2, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Time3, atInteger);
  TBinaryWriterExtension.Write(aStream, Byte(Ord(useBrake)));
end;

class procedure TDirectCommandBuilder.OutputStepPower(layer, ports : byte;
  power : ShortInt; Step1, Step2, Step3 : Integer; useBrake : boolean;
  aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTSTEPPOWER);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.WriteIntArgument(aStream, power, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Step1, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Step2, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Step3, atInteger);
  TBinaryWriterExtension.Write(aStream, Byte(Ord(useBrake)));
end;

class procedure TDirectCommandBuilder.OutputGetCount(layer, port : byte;
  globalOffset : byte; aStream : TStream);
begin
  // read 4 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTGETCOUNT);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, port);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.OutputTest(layer, ports : byte;
  globalOffset : byte; aStream : TStream);
begin
  // read 1 byte
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTTEST);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.OutputRead(layer, port : byte;
  globalOffset : byte; aStream : TStream);
begin
  // read 5 bytes
  // port is 0..3 (not 1, 2, 4, 8)
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTREAD);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, port);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.OutputPolarity(layer, ports : byte;
  polarity : ShortInt; aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTPOLARITY);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.WriteIntArgument(aStream, polarity, atInteger);
//  TBinaryWriterExtension.Write(aStream, polarity);
end;

class procedure TDirectCommandBuilder.OutputReset(layer, ports : byte;
  aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTRESET);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
end;

class procedure TDirectCommandBuilder.OutputPower(layer: byte;
  ports: byte; power: ShortInt; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTPOWER);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.WriteIntArgument(aStream, power, atInteger);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opOUTPUTPOWER);
				binaryWriter.Write(layer);
				binaryWriter.Write((byte)port);
				binaryWriter.WriteIntArgument((int)power, ArgType.Integer);
*)
end;

class procedure TDirectCommandBuilder.OutputSpeed(layer: byte;
  ports: byte; speed: ShortInt; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTSPEED);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.WriteIntArgument(aStream, speed, atInteger);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opOUTPUTSPEED);
				binaryWriter.Write(layer);
				binaryWriter.Write((byte)port);
				binaryWriter.WriteIntArgument((int)speed, ArgType.Integer);
*)
end;

class procedure TDirectCommandBuilder.MemoryRead(slot: TProgramSlot; objId,
  offset, size, globalIndex: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopMemoryRead);
  TBinaryWriterExtension.Write(aStream, Byte(slot));
  TBinaryWriterExtension.Write(aStream, Byte(objId));
  TBinaryWriterExtension.WriteIntArgument(aStream, offset, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, size, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opMemoryRead);
				binaryWriter.Write((byte)slot);
				binaryWriter.Write((byte)objId);
				binaryWriter.WriteIntArgument(offset, ArgType.Integer);
				binaryWriter.WriteIntArgument(size, ArgType.Integer);
				binaryWriter.WriteIntArgument(globalIndex, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.MemoryWrite(slot: TProgramSlot;
  objId, offset, size, arrayHandle: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopMemoryWrite);
  TBinaryWriterExtension.Write(aStream, Byte(slot));
  TBinaryWriterExtension.Write(aStream, Byte(objId));
  TBinaryWriterExtension.WriteIntArgument(aStream, offset, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, size, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, arrayHandle, atLocalOffset);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opMemoryWrite);
				binaryWriter.Write((byte)slot);
				binaryWriter.Write((byte)objId);
				binaryWriter.WriteIntArgument(offset, ArgType.Integer);
				binaryWriter.WriteIntArgument(size, ArgType.Integer);
				binaryWriter.WriteIntArgument(arrayHandle, ArgType.LocalOffset);
*)
end;

class procedure TDirectCommandBuilder.ReadArrayContent(slot: TProgramSlot;
  arrayHandle, index, bytes, dataOut: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ascReadContent));
  TBinaryWriterExtension.Write(aStream, Byte(slot));
  TBinaryWriterExtension.WriteIntArgument(aStream, arrayHandle, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, index, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, bytes, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, dataOut, atGlobalOffset);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opArrayReadContent);
				binaryWriter.Write((byte)slot);
				binaryWriter.WriteIntArgument(arrayHandle, ArgType.GlobalOffset);
				binaryWriter.WriteIntArgument(index, ArgType.Integer);
				binaryWriter.WriteIntArgument(bytes, ArgType.Integer);
				binaryWriter.WriteIntArgument(dataOut, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.ReadArraySize(slot: TProgramSlot;
  arrayHandle, dataOut: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ascReadSize));
  TBinaryWriterExtension.Write(aStream, Byte(slot));
  TBinaryWriterExtension.WriteIntArgument(aStream, arrayHandle, atGlobalOffset, True);
  TBinaryWriterExtension.WriteIntArgument(aStream, dataOut, atGlobalOffset);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opArrayReadSize);
				binaryWriter.Write((byte)slot);
				binaryWriter.WriteIntArgument(arrayHandle, ArgType.GlobalOffset, true);
				binaryWriter.WriteIntArgument(dataOut, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.OutputClearCount(layer,
  ports: byte; aStream: TStream);
begin
  TBinaryWriterExtension.Write(aStream, Byte(pbopOUTPUTCLRCOUNT));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
(*
				178,
				layer,
				portBitField
*)
end;

class procedure TDirectCommandBuilder.OutputStop(layer: byte;
  ports: byte; forceStop: Boolean; aStream: TStream);
begin
  TBinaryWriterExtension.Write(aStream, Byte(pbopOUTPUTSTOP));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
  TBinaryWriterExtension.Write(aStream, Byte(Ord(forceStop)));
(*
				163,
				layer,
				(byte)port,
				forceStop ? 1 : 0
*)
end;

class procedure TDirectCommandBuilder.OutputStart(layer: byte;
  ports: byte; aStream: TStream);
begin
  TBinaryWriterExtension.Write(aStream, Byte(pbopOUTPUTSTART));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, ports);
(*
				166,
				layer,
				(byte)port
*)
end;

class procedure TDirectCommandBuilder.InputRead(layer: byte;
  port: TPortId; stype, smode, readSI, globalIndex: byte;
  aStream: TStream);
var
  op : TPBrickOpCode;
begin
  // read 1 or 4 bytes
  op := pbopINPUTREAD; // pct
  if readSI <> 0 then
    op := pbopINPUTREADSI; // scaled
  TBinaryWriterExtension.WriteOpCode(aStream, op);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, stype, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, smode, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
(*
				if (readSI)
				{
					binaryWriter.WriteOpCode(PBrickOpCode.opINPUTREADSI);
				}
				else
				{
					binaryWriter.WriteOpCode(PBrickOpCode.opINPUTREAD);
				}
				binaryWriter.Write(layer);
				binaryWriter.Write(port);
				binaryWriter.WriteIntArgument((int)sensorType, ArgType.Integer);
				binaryWriter.WriteIntArgument((int)mode, ArgType.Integer);
				binaryWriter.WriteIntArgument(globalIndex, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.InputReadyRead(layer: byte;
  port: TPortId; stype, smode, numValues, readSI,
  globalIndex: byte; aStream: TStream);
var
  op : TPBrickOpCode;
  i, cnt : integer;
begin
  op := MakeOpCode(idscReadyPct);
  cnt := 1;
  if readSI <> 0 then
  begin
    op := MakeOpCode(idscReadySI);
    cnt := 4;
  end;
  TBinaryWriterExtension.WriteOpCode(aStream, op);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, stype, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, smode, atInteger);
  TBinaryWriterExtension.Write(aStream, numValues);
  for i := 0 to numValues - 1 do
  begin
    TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
    Inc(globalIndex, cnt);
  end;
(*
				if (readSI)
				{
					binaryWriter.WriteOpCode(PBrickOpCode.opInputDeviceReadySI);
				}
				else
				{
					binaryWriter.WriteOpCode(PBrickOpCode.opInputDeviceReadyPct);
				}
				binaryWriter.Write(layer);
				binaryWriter.Write(port);
				binaryWriter.WriteIntArgument((int)sensor, ArgType.Integer);
				binaryWriter.WriteIntArgument((int)mode, ArgType.Integer);
				binaryWriter.Write(numberOfReturnValues);
				for (int i = 0; i < (int)numberOfReturnValues; i++)
				{
					binaryWriter.WriteIntArgument(globalIndex, ArgType.GlobalOffset);
					globalIndex += 4;
				}
*)
end;

class procedure TDirectCommandBuilder.CleanDirectory(path: string; aStream: TStream);
var
  position, argument : integer;
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopMOVE88);
  TBinaryWriterExtension.WriteIntArgument(aStream, 0, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 0, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(ascCreate8));
  TBinaryWriterExtension.WriteIntArgument(aStream, 100, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 4, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(ascCreate8));
  TBinaryWriterExtension.WriteIntArgument(aStream, 32, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 6, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(ascCreate8));
  TBinaryWriterExtension.WriteIntArgument(aStream, 132, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 8, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcDuplicate));
  TBinaryWriterExtension.WriteStringArgument(aStream, path);
  TBinaryWriterExtension.WriteIntArgument(aStream, 4, atGlobalOffset, true);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscGetFolders));
  TBinaryWriterExtension.WriteIntArgument(aStream, 4, atGlobalOffset, true);
  TBinaryWriterExtension.WriteIntArgument(aStream, 1, atGlobalOffset);
  position := aStream.Position;
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscGetSubFolderName));
  TBinaryWriterExtension.WriteIntArgument(aStream, 4, atGlobalOffset, true);
  TBinaryWriterExtension.WriteIntArgument(aStream, 1, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 32, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 6, atGlobalOffset, true);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcConcat));
  TBinaryWriterExtension.WriteIntArgument(aStream, 4, atGlobalOffset, true);
  TBinaryWriterExtension.WriteIntArgument(aStream, 6, atGlobalOffset, true);
  TBinaryWriterExtension.WriteIntArgument(aStream, 8, atGlobalOffset, true);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcConcat));
  TBinaryWriterExtension.WriteIntArgument(aStream, 8, atGlobalOffset, true);
  TBinaryWriterExtension.WriteStringArgument(aStream, '.rbf');
  TBinaryWriterExtension.WriteIntArgument(aStream, 10, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fnscExist));
  TBinaryWriterExtension.WriteIntArgument(aStream, 10, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, pbopJRFALSE);
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 3, atInteger);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscRemove));
  TBinaryWriterExtension.WriteIntArgument(aStream, 10, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcConcat));
  TBinaryWriterExtension.WriteIntArgument(aStream, 8, atGlobalOffset, true);
  TBinaryWriterExtension.WriteStringArgument(aStream, '.rsf');
  TBinaryWriterExtension.WriteIntArgument(aStream, 10, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fnscExist));
  TBinaryWriterExtension.WriteIntArgument(aStream, 10, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, pbopJRFALSE);
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 3, atInteger);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscRemove));
  TBinaryWriterExtension.WriteIntArgument(aStream, 10, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcConcat));
  TBinaryWriterExtension.WriteIntArgument(aStream, 8, atGlobalOffset, true);
  TBinaryWriterExtension.WriteStringArgument(aStream, '.rgf');
  TBinaryWriterExtension.WriteIntArgument(aStream, 10, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fnscExist));
  TBinaryWriterExtension.WriteIntArgument(aStream, 10, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, pbopJRFALSE);
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 3, atInteger);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscRemove));
  TBinaryWriterExtension.WriteIntArgument(aStream, 10, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, pbopSUB8);
  TBinaryWriterExtension.WriteIntArgument(aStream, 1, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 1, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 1, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, pbopJRLT8);
  TBinaryWriterExtension.WriteIntArgument(aStream, 0, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 1, atGlobalOffset);
  argument := position - aStream.Position + 2;
  TBinaryWriterExtension.WriteIntArgument(aStream, argument, atInteger);
end;

class procedure TDirectCommandBuilder.ResolveLogFileName(path: string; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopMOVE1616);
  TBinaryWriterExtension.WriteIntArgument(aStream, 1, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 6, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(ascCreate8));
  TBinaryWriterExtension.WriteIntArgument(aStream, 100, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 0, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcDuplicate));
  TBinaryWriterExtension.WriteStringArgument(aStream, path);
  TBinaryWriterExtension.WriteIntArgument(aStream, 0, atGlobalOffset, true);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(ascCreate8));
  TBinaryWriterExtension.WriteIntArgument(aStream, 10, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcDuplicate));
  TBinaryWriterExtension.WriteStringArgument(aStream, '.rdf');
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset, true);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(ascCreate8));
  TBinaryWriterExtension.WriteIntArgument(aStream, 32, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 4, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcConcat));
  TBinaryWriterExtension.WriteIntArgument(aStream, 0, atGlobalOffset, true);
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset, true);
  TBinaryWriterExtension.WriteIntArgument(aStream, 13, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fnscExist));
  TBinaryWriterExtension.WriteIntArgument(aStream, 13, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 12, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, pbopJRFALSE);
  TBinaryWriterExtension.WriteIntArgument(aStream, 12, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 38, atInteger);
  TBinaryWriterExtension.WriteOpCode(aStream, pbopMOVE16F);
  TBinaryWriterExtension.WriteIntArgument(aStream, 6, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 8, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcValueToString));
  TBinaryWriterExtension.WriteIntArgument(aStream, 8, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, -6, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 0, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset, true);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcConcat));
  TBinaryWriterExtension.WriteStringArgument(aStream, '_');
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset, true);
  TBinaryWriterExtension.WriteIntArgument(aStream, 4, atGlobalOffset, true);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(stcConcat));
  TBinaryWriterExtension.WriteIntArgument(aStream, 4, atGlobalOffset, true);
  TBinaryWriterExtension.WriteStringArgument(aStream, '.rdf');
  TBinaryWriterExtension.WriteIntArgument(aStream, 2, atGlobalOffset, true);
  TBinaryWriterExtension.WriteOpCode(aStream, pbopADD16);
  TBinaryWriterExtension.WriteIntArgument(aStream, 6, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 1, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 6, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, pbopJR);
  TBinaryWriterExtension.WriteIntArgument(aStream, -53, atInteger);
end;

class procedure TDirectCommandBuilder.InputDeviceGetTypeMode(layer: byte;
  port: TPortId; globalIndexType, globalIndexMode: byte; aStream: TStream);
begin
  // read 2 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetTypeMode));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndexType, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndexMode, atGlobalOffset);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opInputDeviceGetTypeMode);
				binaryWriter.Write(layer);
				binaryWriter.Write(port);
				binaryWriter.WriteIntArgument((int)globalIndexType, ArgType.GlobalOffset);
				binaryWriter.WriteIntArgument((int)globalIndexMode, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.InputDeviceGetName(layer : byte;
  port : TPortId; maxLen : byte; globalIndex : byte; aStream : TStream);
begin
  // read maxLen bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetName));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.Write(aStream, maxLen);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputDeviceGetSymbol(layer : byte;
  port : TPortId; maxLen : byte; globalIndex : byte; aStream : TStream);
begin
  // read maxLen bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetSymbol));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.Write(aStream, maxLen);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputDeviceGetFormat(layer : byte;
  port : TPortId; giDatasets, giFormat, giModes, giViews : byte; aStream : TStream);
begin
  // read 4 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetFormat));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, giDatasets, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, giFormat, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, giModes, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, giViews, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputDeviceGetRaw(layer: byte;
  port: TPortId; globalIndex: byte; aStream: TStream);
begin
  // read 4 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetRaw));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputDeviceGetModeName(layer: byte;
  port: TPortId; mode, maxLen, globalIndex: byte; aStream: TStream);
begin
  // read maxLen bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetModeName));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.Write(aStream, mode);
  TBinaryWriterExtension.Write(aStream, maxLen);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputDeviceGetFigures(layer: byte;
  port: TPortId; giFigures, giDecimals: byte; aStream: TStream);
begin
  // read 2 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetFigures));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, giFigures, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, giDecimals, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputDeviceGetMinMax(layer: byte;
  port: TPortId; giMin, giMax: byte; aStream: TStream);
begin
  // read 8 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetFigures));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, giMin, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, giMax, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputDeviceReadyPct(layer: byte;
  port: TPortId; stype, smode, numValues : byte; globalIndex: byte; aStream: TStream);
var
  i : integer;
begin
  // read numValues bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscReadyPct));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.Write(aStream, stype);
  TBinaryWriterExtension.Write(aStream, smode);
  TBinaryWriterExtension.Write(aStream, numValues);
  for i := 0 to numValues - 1 do
  begin
    TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
    Inc(globalIndex, 1);
  end;
end;

class procedure TDirectCommandBuilder.InputDeviceReadyRaw(layer: byte;
  port: TPortId; stype, smode, numValues : byte; globalIndex: byte; aStream: TStream);
var
  i : integer;
begin
  // read 4*numValues bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscReadyRaw));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.Write(aStream, stype);
  TBinaryWriterExtension.Write(aStream, smode);
  TBinaryWriterExtension.Write(aStream, numValues);
  for i := 0 to numValues - 1 do
  begin
    TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
    Inc(globalIndex, 4);
  end;
end;

class procedure TDirectCommandBuilder.InputDeviceReadySI(layer: byte;
  port: TPortId; stype, smode, numValues : byte; globalIndex: byte; aStream: TStream);
var
  i : integer;
begin
  // read 4*numValues bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscReadySI));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.Write(aStream, stype);
  TBinaryWriterExtension.Write(aStream, smode);
  TBinaryWriterExtension.Write(aStream, numValues);
  for i := 0 to numValues - 1 do
  begin
    TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
    Inc(globalIndex, 4);
  end;
end;

class procedure TDirectCommandBuilder.InputDeviceGetChanges(layer: byte;
  port: TPortId; giValue: byte; aStream: TStream);
begin
  // read 4 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetChanges));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, giValue, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputDeviceGetBumps(layer: byte;
  port: TPortId; giValue: byte; aStream: TStream);
begin
  // read 4 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetBumps));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, giValue, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputDeviceClearChanges(layer: byte;
  port: TPortId; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscClrChanges));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opInputDeviceClrChanges);
				binaryWriter.Write(layer);
				binaryWriter.Write(port);
*)
end;

class procedure TDirectCommandBuilder.InputDeviceCalMinMax(stype, smode : byte;
  aMin, aMax : Integer; aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscCalMinMax));
  TBinaryWriterExtension.Write(aStream, stype);
  TBinaryWriterExtension.Write(aStream, smode);
  TBinaryWriterExtension.WriteIntArgument(aStream, aMin, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, aMax, atInteger);
end;

class procedure TDirectCommandBuilder.InputDeviceCalMin(stype, smode : byte;
  aMin : Integer; aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscCalMin));
  TBinaryWriterExtension.Write(aStream, stype);
  TBinaryWriterExtension.Write(aStream, smode);
  TBinaryWriterExtension.WriteIntArgument(aStream, aMin, atInteger);
end;

class procedure TDirectCommandBuilder.InputDeviceCalMax(stype, smode : byte;
  aMax : Integer; aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscCalMax));
  TBinaryWriterExtension.Write(aStream, stype);
  TBinaryWriterExtension.Write(aStream, smode);
  TBinaryWriterExtension.WriteIntArgument(aStream, aMax, atInteger);
end;

class procedure TDirectCommandBuilder.InputDeviceCalDefault(stype, smode : byte;
  aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscCalDefault));
  TBinaryWriterExtension.Write(aStream, stype);
  TBinaryWriterExtension.Write(aStream, smode);
end;

class procedure TDirectCommandBuilder.InputDeviceClearAll(layer: byte;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscClrAll));
  TBinaryWriterExtension.Write(aStream, layer);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opInputDeviceClrAll);
				binaryWriter.Write(layer);
*)
end;

class procedure TDirectCommandBuilder.InputDeviceStopAll(layer: byte;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscStopAll));
  TBinaryWriterExtension.Write(aStream, layer);
end;

class procedure TDirectCommandBuilder.InputTest(layer : byte;
  port : TPortId; globalIndex : byte; aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopINPUTTEST);
  TBinaryWriterExtension.WriteIntArgument(aStream, layer, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Byte(port), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputWrite(layer: byte;
  port: TPortId; data, aStream: TStream);
var
  arg : byte;
  i : integer;
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopINPUTWRITE);
  TBinaryWriterExtension.WriteIntArgument(aStream, layer, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Byte(port), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, data.Size, atInteger);
  for i := 0 to data.Size - 1 do
  begin
    data.Read(arg, 1);
    TBinaryWriterExtension.WriteIntArgument(aStream, arg, atInteger);
  end;
(*
				stream.WriteOpCode(PBrickOpCode.opINPUTWRITE);
				stream.WriteIntArgument((int)layer, ArgType.Integer);
				stream.WriteIntArgument((int)port, ArgType.Integer);
				stream.WriteIntArgument(data.Length, ArgType.Integer);
				for (int i = 0; i < data.Length; i++)
				{
					byte argument = data[i];
					stream.WriteIntArgument((int)argument, ArgType.Integer);
				}
*)
end;

class procedure TDirectCommandBuilder.InputWrite(layer : byte; port : TPortId; data : TJCHBytes; aStream : TStream);
var
  arg : byte;
  i, len : integer;
begin
  len := Length(data);
  TBinaryWriterExtension.WriteOpCode(aStream, pbopINPUTWRITE);
  TBinaryWriterExtension.WriteIntArgument(aStream, layer, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, Byte(port), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, len, atInteger);
  for i := 0 to len - 1 do
  begin
    arg := data[i];
    TBinaryWriterExtension.WriteIntArgument(astream, arg, atInteger);
  end;
end;

class procedure TDirectCommandBuilder.PutInMruList(fileName: string;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscPutCacheFile));
  TBinaryWriterExtension.WriteStringArgument(aStream, fileName);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opFILE);
				binaryWriter.Write(21);
				binaryWriter.WriteStringArgument(fileName);
*)
end;

class procedure TDirectCommandBuilder.LoadImage(imageName: string; slot,
  size, address: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscLoadImage));
  TBinaryWriterExtension.WriteIntArgument(aStream, Ord(slot), atInteger);
  TBinaryWriterExtension.WriteStringArgument(aStream, imageName);
  TBinaryWriterExtension.WriteIntArgument(aStream, size, atLocalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, address, atLocalOffset);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opFILE);
				binaryWriter.Write(8);
				binaryWriter.WriteIntArgument((int)((byte)slot), ArgType.Integer);
				binaryWriter.WriteStringArgument(imageName);
				binaryWriter.WriteIntArgument(size, ArgType.LocalOffset);
				binaryWriter.WriteIntArgument(address, ArgType.LocalOffset);
*)
end;

class procedure TDirectCommandBuilder.ProgramStart(slot: TProgramSlot;
  size, address: integer; mode: TProgramStartMode; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopPROGRAMSTART);
  TBinaryWriterExtension.WriteIntArgument(aStream, Byte(slot), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, size, atLocalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, address, atLocalOffset);
  TBinaryWriterExtension.Write(aStream, Byte(mode));
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opPROGRAMSTART);
				binaryWriter.WriteIntArgument((int)((byte)slot), ArgType.Integer);
				binaryWriter.WriteIntArgument(size, ArgType.LocalOffset);
				binaryWriter.WriteIntArgument(address, ArgType.LocalOffset);
				binaryWriter.Write((byte)mode);
*)
end;

class procedure TDirectCommandBuilder.RenameBrick(name: string;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(csscBrickName));
  TBinaryWriterExtension.WriteStringArgument(aStream, name);
end;

class procedure TDirectCommandBuilder.GetBrickName(maxLength,
  globalOffset: byte; aStream: TStream);
begin
  // read 120 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(cgscBrickName));
  TBinaryWriterExtension.WriteIntArgument(aStream, maxLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.SetDatalogSyncTimeAndTick(globalScratch : integer;
  aStream: TStream);
var
  argument : integer;
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopTimerReadMicroseconds);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalScratch, atGlobalOffset);
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscSetLogSyncTime));
//				int argument = (int)(DateTime.get_Now() - new DateTime(1970, 1, 1)).get_TotalSeconds();
  TBinaryWriterExtension.WriteIntArgument(aStream, argument, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalScratch, atGlobalOffset);
(*
				stream.WriteOpCode(PBrickOpCode.opTimerReadMicroseconds);
				stream.WriteIntArgument(globalScratch, ArgType.GlobalOffset);
				stream.WriteOpCode(PBrickOpCode.opFileSetLogSyncTime);
				int argument = (int)(DateTime.get_Now() - new DateTime(1970, 1, 1)).get_TotalSeconds();
				stream.WriteIntArgument(argument, ArgType.Integer);
				stream.WriteIntArgument(globalScratch, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.ProgramStop(slot: TProgramSlot;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopPROGRAMSTOP);
  TBinaryWriterExtension.WriteIntArgument(aStream, Byte(slot), atInteger);
(*
				stream.WriteOpCode(PBrickOpCode.opPROGRAMSTOP);
				stream.WriteIntArgument((int)((byte)slot), ArgType.Integer);
*)
end;

class procedure TDirectCommandBuilder.GetFavorItemsCount(aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(cgscFavorItems));
  TBinaryWriterExtension.WriteIntArgument(aStream, Ord(htlBluetooth), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 0, atGlobalOffset);
(*
				stream.WriteOpCode(PBrickOpCode.OpComFavorItems);
				stream.WriteIntArgument(2, ArgType.Integer);
				stream.WriteIntArgument(0, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.GetFavorItem(index: byte;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(cgscFavorItem));
  TBinaryWriterExtension.WriteIntArgument(aStream, Ord(htlBluetooth), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, index, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 30, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 0, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 30, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 31, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, 32, atGlobalOffset);
(*
				stream.WriteOpCode(PBrickOpCode.OpComFavorItem);
				stream.WriteIntArgument(2, ArgType.Integer);
				stream.WriteIntArgument((int)index, ArgType.Integer);
				stream.WriteIntArgument(30, ArgType.Integer);
				stream.WriteIntArgument(0, ArgType.GlobalOffset);
				stream.WriteIntArgument(30, ArgType.GlobalOffset);
				stream.WriteIntArgument(31, ArgType.GlobalOffset);
				stream.WriteIntArgument(32, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.GetProgramStatus(slot: TProgramSlot;
  statusGlobalIndex: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(picGetStatus));
  TBinaryWriterExtension.WriteIntArgument(aStream, Ord(slot), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, statusGlobalIndex, atGlobalOffset);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opPROGRAMINFO);
				binaryWriter.Write(22);
				binaryWriter.WriteIntArgument((int)((byte)slot), ArgType.Integer);
				binaryWriter.WriteIntArgument((int)statusGlobalIndex, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.GetBrickBatteryVoltage(blockIndex: byte;
  aStream: TStream);
begin
  // read 4 bytes (1 single)
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetVBattery));
  TBinaryWriterExtension.WriteIntArgument(aStream, blockIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickBatteryLevel(blockIndex: byte;
  aStream: TStream);
begin
  // read 1 byte (0-100%)
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetLBattery));
  TBinaryWriterExtension.WriteIntArgument(aStream, blockIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickPowerStatus(blockIndex: byte;
  aStream: TStream);
begin
  // read 16 bytes (4 singles)
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetPower));
  TBinaryWriterExtension.WriteIntArgument(aStream, blockIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickBatteryCurrent(blockIndex: byte;
  aStream: TStream);
begin
  // read 4 bytes (1 single)
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetIBattery));
  TBinaryWriterExtension.WriteIntArgument(aStream, blockIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickIntegratedCurrent(blockIndex: byte;
  aStream: TStream);
begin
  // read 4 bytes (1 single)
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetIInt));
  TBinaryWriterExtension.WriteIntArgument(aStream, blockIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickMotorCurrent(blockIndex: byte;
  aStream: TStream);
begin
  // read 4 bytes (1 single)
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetIMotor));
  TBinaryWriterExtension.WriteIntArgument(aStream, blockIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickBatteryTemp(blockIndex: byte;
  aStream: TStream);
begin
  // read 4 bytes (1 single)
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetTBattery));
  TBinaryWriterExtension.WriteIntArgument(aStream, blockIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickSDCardStatus(presentIndex,
  totalKBIndex, freeKBIndex: byte; aStream: TStream);
begin
  // read 9 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetSDCard));
  TBinaryWriterExtension.WriteIntArgument(aStream, presentIndex, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, totalKBIndex, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, freeKBIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickUSBStickStatus(presentIndex,
  totalKBIndex, freeKBIndex: byte; aStream: TStream);
begin
  // read 9 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetUsbStick));
  TBinaryWriterExtension.WriteIntArgument(aStream, presentIndex, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, totalKBIndex, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, freeKBIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetOnBrickStorageStatus(totalKBIndex,
  freeKBIndex: byte; aStream: TStream);
begin
  // read 8 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, pbopMemoryUsage);
  TBinaryWriterExtension.WriteIntArgument(aStream, totalKBIndex, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, freeKBIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickFirmwareVersion(stringLength,
  stringIndex: byte; aStream: TStream);
begin
  // read 7 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetFWVersion));
  TBinaryWriterExtension.WriteIntArgument(aStream, stringLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, stringIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickHardwareVersion(stringLength,
  stringIndex: byte; aStream: TStream);
begin
  // read 6 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetHWVersion));
  TBinaryWriterExtension.WriteIntArgument(aStream, stringLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, stringIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickFirmwareBuild(stringLength,
  stringIndex: byte; aStream: TStream);
begin
  // read 11 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetFWBuild));
  TBinaryWriterExtension.WriteIntArgument(aStream, stringLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, stringIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickOSVersion(stringLength,
  stringIndex: byte; aStream: TStream);
begin
  // read 17 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetOSVersion));
  TBinaryWriterExtension.WriteIntArgument(aStream, stringLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, stringIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickOSBuild(stringLength,
  stringIndex: byte; aStream: TStream);
begin
  // read 11 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetOSBuild));
  TBinaryWriterExtension.WriteIntArgument(aStream, stringLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, stringIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickVersion(stringLength,
  stringIndex: byte; aStream: TStream);
begin
  // read up to 1000 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetVersion));
  TBinaryWriterExtension.WriteIntArgument(aStream, stringLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, stringIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickIPAddress(stringLength,
  stringIndex: byte; aStream: TStream);
begin
  // read 16 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetIPAddress));
  TBinaryWriterExtension.WriteIntArgument(aStream, stringLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, stringIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickBTAddress(maxLength,
  globalOffset: byte; aStream: TStream);
begin
  // read 13 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(cgscId));
  TBinaryWriterExtension.WriteIntArgument(aStream, Ord(htlBluetooth), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, maxLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.ProgramObjectStart(
  slot: TProgramSlot; objectID: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(picObjectStart));
  TBinaryWriterExtension.WriteIntArgument(aStream, Byte(slot), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, objectID, atInteger);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opPROGRAMINFO);
				binaryWriter.Write(4);
				binaryWriter.WriteIntArgument((int)((byte)slot), ArgType.Integer);
				binaryWriter.WriteIntArgument(objectID, ArgType.Integer);
*)
end;

class procedure TDirectCommandBuilder.MoveValueToGlobal(value,
  globalIndex: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopMOVE3232);
  TBinaryWriterExtension.WriteIntArgument(aStream, value, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
(*
				stream.WriteOpCode(PBrickOpCode.opMOVE3232);
				stream.WriteIntArgument(value, ArgType.Integer);
				stream.WriteIntArgument(globalIndex, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.InitBytes(destinationIndex: integer;
  values: TJCHBytes; aStream: TStream);
var
  i : integer;
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopINITBYTES);
  TBinaryWriterExtension.WriteIntArgument(aStream, destinationIndex, atLocalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, Length(values), atInteger);
  for i := 0 to Length(values) - 1 do
  begin
    TBinaryWriterExtension.WriteIntArgument(aStream, values[i], atInteger);
  end;
(*
				stream.WriteOpCode(PBrickOpCode.opINITBYTES);
				stream.WriteIntArgument(destinationIndex, ArgType.LocalOffset);
				stream.WriteIntArgument(values.Length, ArgType.Integer);
				for (int i = 0; i < values.Length; i++)
				{
					byte argument = values[i];
					stream.WriteIntArgument((int)argument, ArgType.Integer);
				}
*)
end;

class procedure TDirectCommandBuilder.DoesFileExist(fileName: string;
  statusGlobalIndex: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fnscExist));
  TBinaryWriterExtension.WriteStringArgument(aStream, fileName);
  TBinaryWriterExtension.WriteIntArgument(aStream, statusGlobalIndex, atGlobalOffset);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opFileName);
				binaryWriter.Write(16);
				binaryWriter.WriteStringArgument(fileName);
				binaryWriter.WriteIntArgument((int)statusGlobalIndex, ArgType.GlobalOffset);
*)
end;

class procedure TDirectCommandBuilder.DeleteFile(path: string; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscRemove));
  TBinaryWriterExtension.WriteStringArgument(aStream, path);
end;

class procedure TDirectCommandBuilder.CopyFile(sourcePath,
  destinationPath: string; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscMove));
  TBinaryWriterExtension.WriteStringArgument(aStream, sourcePath);
  TBinaryWriterExtension.WriteStringArgument(aStream, destinationPath);
(*
				binaryWriter.WriteOpCode(PBrickOpCode.opFILE);
				binaryWriter.Write(31);
				binaryWriter.WriteStringArgument(sourcePath);
				binaryWriter.WriteStringArgument(destinationPath);
*)
end;

class procedure TDirectCommandBuilder.MakeFolder(name: string;
  globalOffset: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpcode(fscMakeFolder));
  TBinaryWriterExtension.WriteStringArgument(aStream, name);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.DownloadCompleteSound(aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(uwcDownloadEnd));
end;

class procedure TDirectCommandBuilder.PlayTone(volume: byte; frequency,
  duration: word; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(sscTone));
  TBinaryWriterExtension.WriteIntArgument(aStream, volume, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, frequency, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, duration, atInteger);
end;

class procedure TDirectCommandBuilder.StopSound(aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(sscBreak));
end;

class procedure TDirectCommandBuilder.PlaySoundFile(filename: string;
  volume, loop: byte; aStream: TStream);
var
  sc : TSoundSubCommand;
begin
  if loop <> 0 then
    sc := sscRepeat
  else
    sc := sscPlayFile;
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(sc));
  TBinaryWriterExtension.WriteIntArgument(aStream, volume, atInteger);
  TBinaryWriterExtension.WriteStringArgument(aStream, filename);
end;

class procedure TDirectCommandBuilder.System(const cmd: string;
  globalOffset : byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopSystem);
  TBinaryWriterExtension.WriteStringArgument(aStream, cmd);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.KeepAlive(blockIndex: byte;
  aStream: TStream);
begin
  // read 1 byte (minutes until sleep)
  TBinaryWriterExtension.WriteOpCode(aStream, pbopKeepAlive);
  TBinaryWriterExtension.WriteIntArgument(aStream, blockIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.SetSleepMinutes(minutes: byte;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(iscSetMinutes));
  TBinaryWriterExtension.WriteIntArgument(aStream, minutes, atInteger);
end;

class procedure TDirectCommandBuilder.SoundReady(aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopSOUNDREADY);
end;

class procedure TDirectCommandBuilder.ButtonFlush(aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcFlush));
end;

class procedure TDirectCommandBuilder.ButtonWaitForPress(aStream : TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcWaitForPress));
end;

class procedure TDirectCommandBuilder.ButtonGetBumped(btn, globalOffset: byte; aStream: TStream);
begin
  // read 1 byte
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcGetBumped));
  TBinaryWriterExtension.WriteIntArgument(aStream, btn, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.ButtonGetHorz(globalOffset: byte; aStream: TStream);
begin
  // read 2 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcGetHorz));
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.ButtonGetVert(globalOffset: byte; aStream: TStream);
begin
  // read 2 bytes
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcGetVert));
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.ButtonLongPressed(btn, globalOffset: byte; aStream: TStream);
begin
  // read 1 byte
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcLongPress));
  TBinaryWriterExtension.WriteIntArgument(aStream, btn, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.ButtonPress(btn: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcPress));
  TBinaryWriterExtension.WriteIntArgument(aStream, btn, atInteger);
end;

class procedure TDirectCommandBuilder.ButtonPressed(btn, globalOffset: byte; aStream: TStream);
begin
  // read 1 byte
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcPressed));
  TBinaryWriterExtension.WriteIntArgument(aStream, btn, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.ButtonRelease(btn: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcRelease));
  TBinaryWriterExtension.WriteIntArgument(aStream, btn, atInteger);
end;

class procedure TDirectCommandBuilder.ButtonShortPressed(btn, globalOffset: byte; aStream: TStream);
begin
  // read 1 byte
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcShortPress));
  TBinaryWriterExtension.WriteIntArgument(aStream, btn, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.ButtonGetClick(globalOffset: byte;
  aStream: TStream);
begin
  // read 1 byte
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(ubcGetClick));
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

{ TBinaryWriterExtension }

class function TBinaryWriterExtension.ArgSize(value: single): integer;
begin
  Result := 5;
end;

class function TBinaryWriterExtension.ArgSize(value: integer): integer;
begin
  if (value >= -32) and (value <= 31) then
    Result := 1
  else if (value >= -128) and (value <= 127) then
    Result := 2
  else if (value >= -32768) and (value <= 32767) then
    Result := 3
  else
    Result := 5;
end;

class procedure TBinaryWriterExtension.Write(aStream: TStream; value: word);
begin
  WriteWord(aStream, value);
end;

class procedure TBinaryWriterExtension.Write(aStream: TStream; value: byte);
begin
  WriteByte(aStream, value);
end;

class procedure TBinaryWriterExtension.Write(aStream: TStream; value: single);
begin
  WriteSingle(aStream, value);
end;

class procedure TBinaryWriterExtension.Write(aStream: TStream; value: cardinal);
begin
  WriteCardinal(aStream, value);
end;

class procedure TBinaryWriterExtension.Write(aStream: TStream; value: string);
var
  b : byte;
begin
  b := 0;
  aStream.Write(Pointer(value)^, Length(value));
  aStream.Write(b, 1); // must write null terminator also
end;

class procedure TBinaryWriterExtension.WriteFloatArgument(aStream: TStream;
  value: single);
begin
  WriteByte(aStream, 131);
  WriteSingle(aStream, value);
end;

class procedure TBinaryWriterExtension.WriteIntArgument(aStream: TStream;
  argument: integer; argumentType: TArgType);
begin
  WriteIntArgument(aStream, argument, argumentType, false);
end;

class procedure TBinaryWriterExtension.WriteIntArgument(aStream: TStream;
  argument: integer; argumentType: TArgType; isHandle: boolean);
var
  b : byte;
  num : integer;
begin
  num := TBinaryWriterExtension.ArgSize(argument);
  b := 0;
  if argumentType <> atInteger then
  begin
    case argumentType of
      atLocalOffset :  b := 64;
      atGlobalOffset : b := 96;
    end;
  end;
  if isHandle then
  begin
    b := b or 16;
    if num = 1 then
      num := 2;
  end;
  case num of
    1: // LC0
      begin
        WriteByte(aStream, b or Byte(argument and 63));
      end;
    2: // LC1
      begin
        WriteByte(aStream, b or PRIMPAR_LONG or PRIMPAR_1_BYTE); // $81 or 129
        WriteByte(aStream, Byte(argument));
      end;
    3: // LC2
      begin
        WriteByte(aStream, b or PRIMPAR_LONG or PRIMPAR_2_BYTES); // $82 or 130
        WriteSmallInt(aStream, SmallInt(argument));
      end;
    5: // LC4
      begin
        WriteByte(aStream, b or PRIMPAR_LONG or PRIMPAR_4_BYTES); // $83 or 131
        WriteInteger(aStream, argument);
      end;
  end;
end;

class procedure TBinaryWriterExtension.WriteOpCode(aStream: TStream;
  opCode: TPBrickOpCode);
begin
  if opCode < pbopFAIL then
  begin
    WriteByte(aStream, Byte(opCode));
  end
  else
  begin
    WriteWord(aStream, Word(opCode), False); // must be big-endian!!!
  end;
end;

class procedure TBinaryWriterExtension.WriteStringArgument(
  aStream: TStream; value: string);
begin
  WriteByte(aStream, 128);
  WriteString(aStream, value);
  WriteByte(aStream, 0); //  null terminator
end;

{ TPBrickGenericCommandObject }

constructor TPBrickGenericCommandObject.Create;
begin
  fStream := TMemoryStream.Create;
end;

destructor TPBrickGenericCommandObject.Destroy;
begin
  FreeAndNil(fStream);
  inherited;
end;

//function TPBrickGenericCommandObject.GetArray: TByteArray;
//begin
//
//end;

function TPBrickGenericCommandObject.Seek(Offset: Integer; Origin: Word): Longint;
begin
  Result := fStream.Seek(Offset, Origin);
end;

procedure TPBrickGenericCommandObject.SetStream(const Value: TStream);
begin
  fStream.CopyFrom(Value, 0);
end;

procedure TPBrickGenericCommandObject.Write(aValue: TCommandType);
begin
  Write(Ord(aValue));
end;

procedure TPBrickGenericCommandObject.Write(aValue: TRecoveryCommand);
begin
  Write(Ord(aValue));
end;

procedure TPBrickGenericCommandObject.Write(aValue: Byte);
begin
  fStream.Write(aValue, 1);
end;

procedure TPBrickGenericCommandObject.Write(aValue: Integer);
begin
  WriteInteger(fStream, aValue);
end;

{ TCrcCalculator }

constructor TCrcCalculator.Create;
begin
  inherited Create;
  InitializeTable(3988292384);
end;

constructor TCrcCalculator.Create(aPoly: Cardinal);
begin
  inherited Create;
  InitializeTable(aPoly);
end;

destructor TCrcCalculator.Destroy;
begin
  SetLength(fTable, 0);
  inherited;
end;

procedure TCrcCalculator.InitializeTable(aPoly: Cardinal);
var
  i, j : integer;
  crc : Cardinal;
begin
  fCrc32Ieee := 3988292384;
  SetLength(fTable, 256);
  for i := 0 to 255 do
  begin
    crc := i;
    for j := 8 downto 1 do
    begin
      if (crc and $01) <> $00 then
      begin
        crc := (crc shr 1) xor aPoly;
      end
      else
      begin
        crc := crc shr 1;
      end;
    end;
    fTable[i] := crc;
  end;
end;

function TCrcCalculator.CalculateCrc(buffer: TStream; length: integer;
  crc: Cardinal): Cardinal;
var
  i, index : integer;
  b : byte;
begin
  length := Min(length, buffer.Size);
  crc := not crc;
  for i := 0 to length - 1 do
  begin
    buffer.Read(b, 1);
    index := (crc xor Cardinal(b)) and $FF;
    crc := (crc shr 8) xor fTable[index];
  end;
  result := not crc;
end;

function TCrcCalculator.CalculateCrc(buffer: TStream; crc: Cardinal): Cardinal;
var
  processingByte : byte;
  count, index : integer;
begin
  crc := not crc;
  count := buffer.Read(processingByte, 1);
  while count = 1 do
  begin
    index := (crc xor Cardinal(processingByte)) and $FF;
    crc := (crc shr 8) xor fTable[index]; 
    count := buffer.Read(processingByte, 1);
  end;
  result := not crc;
end;

function TCrcCalculator.CalculateCrc(buffer: TByteArray; len: integer;
  crc: Cardinal): Cardinal;
var
  i, index : integer;
begin
  len := Min(len, Length(buffer));
  crc := not crc;
  for i := 0 to len - 1 do
  begin
    index := (crc xor Cardinal(buffer[i])) and $FF;
    crc := (crc shr 8) xor fTable[index];
  end;
  result := not crc;
end;

{ TPBrickDirectCommandObject }

constructor TPBrickDirectCommandObject.Create(commandType: TCommandType;
  globals, locals: integer);
begin
  inherited Create;
  Write(commandType);
  Write(Byte(globals and $FF));
  Write(Byte(((locals and $3F) shl 2) or ((globals shr 8) and $03)));
end;

(*
	public static class PBrickWifi
	{
		public static bool IsPresent(CasperDevice device)
		{
			bool result;
			using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 10, 0))
			{
				pBrickDirectCommandObject.WriteOpCode(PBrickOpCode.OpComGetPresent);
				pBrickDirectCommandObject.Write(htlWifi);
				pBrickDirectCommandObject.WriteIntArgument(0, ArgType.GlobalOffset);
				lock (device)
				{
					DateTime now = DateTime.Now;
					PendingResponse pendingResponse = device.SendMessage(pBrickDirectCommandObject.ToArray(), true);
					byte[] array;
					pendingResponse.TryReceiveMessage(out array, 10000);
					Console.WriteLine("Check Enable took: {0}", (DateTime.Now - now).TotalMilliseconds);
					result = (array[1] != 0);
				}
			}
			return result;
		}
		public static bool IsEnabled(CasperDevice device)
		{
			bool result;
			using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 10, 0))
			{
				pBrickDirectCommandObject.WriteOpCode(PBrickOpCode.OpComGetOnOff);
				pBrickDirectCommandObject.Write(htlWifi);
				pBrickDirectCommandObject.WriteIntArgument(0, ArgType.GlobalOffset);
				lock (device)
				{
					DateTime now = DateTime.Now;
					PendingResponse pendingResponse = device.SendMessage(pBrickDirectCommandObject.ToArray(), true);
					byte[] array;
					bool flag2 = pendingResponse.TryReceiveMessage(out array, 10000);
					Console.WriteLine("Check Enable took: {0}", (DateTime.Now - now).TotalMilliseconds);
					result = (flag2 && array[1] != 0);
				}
			}
			return result;
		}
		public static void SetEnabled(CasperDevice device, bool value)
		{
			using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 10, 0))
			{
				pBrickDirectCommandObject.WriteOpCode(PBrickOpCode.opComSetOnOff);
				pBrickDirectCommandObject.Write(htlWifi);
				pBrickDirectCommandObject.Write(value ? 1 : 0);
				lock (device)
				{
					DateTime now = DateTime.Now;
					PendingResponse pendingResponse = device.SendMessage(pBrickDirectCommandObject.ToArray(), true);
					byte[] array;
					pendingResponse.TryReceiveMessage(out array, 20000);
					Console.WriteLine("Set Enable took: {0}", (DateTime.Now - now).TotalMilliseconds);
				}
			}
		}
		public static bool StartSearch(CasperDevice device)
		{
			bool result;
			using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 10, 0))
			{
				pBrickDirectCommandObject.WriteOpCode(PBrickOpCode.opComSetSearch);
				pBrickDirectCommandObject.Write(htlWifi);
				pBrickDirectCommandObject.Write(1);
				lock (device)
				{
					DateTime now = DateTime.Now;
					PendingResponse pendingResponse = device.SendMessage(pBrickDirectCommandObject.ToArray(), true);
					byte[] array;
					bool flag2 = pendingResponse.TryReceiveMessage(out array, 20000);
					Console.WriteLine("Search took: {0}", (DateTime.Now - now).TotalMilliseconds);
					result = (flag2 && array[1] != 0);
				}
			}
			return result;
		}
		public static ICollection<WifiItem> ResultsFromSearch(CasperDevice device)
		{
			List<WifiItem> list = new List<WifiItem>();
			int num = PBrickWifi.NumResults(device);
			for (int i = 0; i < num; i++)
			{
				WifiItem searchResult = PBrickWifi.GetSearchResult(device, i);
				list.Add(searchResult);
			}
			return list;
		}
		public static bool ConnectTo(CasperDevice device, string name, string pin)
		{
			if (pin != null)
			{
				PBrickWifi.SetEncrypted(device, name, true);
				PBrickWifi.SetPin(device, name, pin);
			}
			return PBrickWifi.SetConnection(device, name);
		}
		public static bool WaitBusy(CasperDevice device, int waitTime)
		{
			bool result;
			using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 10, 10))
			{
				DateTime dateTime = DateTime.Now.AddMilliseconds((double)waitTime);
				pBrickDirectCommandObject.WriteOpCode(PBrickOpCode.OpComGetResult);
				pBrickDirectCommandObject.Write(htlWifi);
				pBrickDirectCommandObject.WriteIntArgument(0, ArgType.Integer);
				pBrickDirectCommandObject.WriteIntArgument(0, ArgType.GlobalOffset);
				byte[] message = pBrickDirectCommandObject.ToArray();
				byte b = 1;
				while (b == 1 && DateTime.Now < dateTime)
				{
					lock (device)
					{
						PendingResponse pendingResponse = device.SendMessage(message, true);
						byte[] array;
						bool flag2 = pendingResponse.TryReceiveMessage(out array);
						if (flag2)
						{
							b = array[1];
						}
					}
					if (b == 0)
					{
						Console.WriteLine("WaitBusy success with: {0} ms remaining", (dateTime - DateTime.Now).TotalMilliseconds);
						result = true;
						return result;
					}
					if (b == 2 || b == 4)
					{
						result = false;
						return result;
					}
					Thread.Sleep(500);
				}
				result = false;
			}
			return result;
		}
		private static bool SetEncrypted(CasperDevice device, string name, bool encrypted)
		{
			bool result;
			using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 10, 0))
			{
				pBrickDirectCommandObject.WriteOpCode(PBrickOpCode.opComSetEncrypt);
				pBrickDirectCommandObject.Write(htlWifi);
				pBrickDirectCommandObject.WriteStringArgument(name);
				pBrickDirectCommandObject.Write(encrypted ? 1 : 0);
				byte[] array;
				bool flag2;
				lock (device)
				{
					PendingResponse pendingResponse = device.SendMessage(pBrickDirectCommandObject.ToArray(), true);
					flag2 = pendingResponse.TryReceiveMessage(out array);
				}
				result = (flag2 && array[1] == 1);
			}
			return result;
		}
		private static bool SetPin(CasperDevice device, string name, string pin)
		{
			bool result;
			using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 10, 0))
			{
				pBrickDirectCommandObject.WriteOpCode(PBrickOpCode.opComSetPin);
				pBrickDirectCommandObject.Write(htlWifi);
				pBrickDirectCommandObject.WriteStringArgument(name);
				pBrickDirectCommandObject.WriteStringArgument(pin);
				byte[] array;
				bool flag2;
				lock (device)
				{
					PendingResponse pendingResponse = device.SendMessage(pBrickDirectCommandObject.ToArray(), true);
					flag2 = pendingResponse.TryReceiveMessage(out array, 20000);
				}
				result = (flag2 && array[1] == 1);
			}
			return result;
		}
		private static bool SetConnection(CasperDevice device, string name)
		{
			bool result;
			using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 10, 0))
			{
				pBrickDirectCommandObject.WriteOpCode(PBrickOpCode.opComSetConnection);
				pBrickDirectCommandObject.Write(htlWifi);
				pBrickDirectCommandObject.WriteStringArgument(name);
				pBrickDirectCommandObject.Write(1);
				byte[] array;
				bool flag2;
				lock (device)
				{
					PendingResponse pendingResponse = device.SendMessage(pBrickDirectCommandObject.ToArray(), true);
					flag2 = pendingResponse.TryReceiveMessage(out array, 20000);
				}
				result = (flag2 && array[1] != 0);
			}
			return result;
		}
		private static int NumResults(CasperDevice device)
		{
			int result;
			using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 10, 0))
			{
				pBrickDirectCommandObject.WriteOpCode(PBrickOpCode.OpComSearchItems);
				pBrickDirectCommandObject.Write(htlWifi);
				pBrickDirectCommandObject.WriteIntArgument(0, ArgType.GlobalOffset);
				lock (device)
				{
					PendingResponse pendingResponse = device.SendMessage(pBrickDirectCommandObject.ToArray(), true);
					byte[] array;
					result = (int)(pendingResponse.TryReceiveMessage(out array, 30000) ? array[1] : 0);
				}
			}
			return result;
		}
		private static WifiItem GetSearchResult(CasperDevice device, int index)
		{
			WifiItem result;
			using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 40, 0))
			{
				pBrickDirectCommandObject.WriteOpCode(PBrickOpCode.OpComSearchItem);
				pBrickDirectCommandObject.Write(htlWifi);
				pBrickDirectCommandObject.WriteIntArgument(index, ArgType.Integer);
				pBrickDirectCommandObject.WriteIntArgument(32, ArgType.Integer);
				pBrickDirectCommandObject.WriteIntArgument(4, ArgType.GlobalOffset);
				pBrickDirectCommandObject.WriteIntArgument(0, ArgType.GlobalOffset);
				pBrickDirectCommandObject.WriteIntArgument(1, ArgType.GlobalOffset);
				pBrickDirectCommandObject.WriteIntArgument(2, ArgType.GlobalOffset);
				pBrickDirectCommandObject.WriteIntArgument(3, ArgType.GlobalOffset);
				byte[] array;
				lock (device)
				{
					PendingResponse pendingResponse = device.SendMessage(pBrickDirectCommandObject.ToArray(), true);
					pendingResponse.TryReceiveMessage(out array);
				}
				WifiItem wifiItem = new WifiItem();
				WifiItem arg_AC_0 = wifiItem;
				string arg_A7_0 = Encoding.ASCII.GetString(array, 5, 32);
				char[] trimChars = new char[1];
				arg_AC_0.SSID = arg_A7_0.TrimEnd(trimChars);
				wifiItem.State = ((array[1] != 0) ? WifiStates.Paired : ((WifiStates)0));
				wifiItem.State |= ((array[2] != 0) ? WifiStates.Connected : ((WifiStates)0));
				wifiItem.State |= ((array[3] != 0) ? WifiStates.Encrypted : ((WifiStates)0));
				wifiItem.State |= ((array[4] != 0) ? WifiStates.Visible : ((WifiStates)0));
				result = wifiItem;
			}
			return result;
		}
	}
*)

end.