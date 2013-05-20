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
      chunkSize, position : integer; handle : byte; aStream : TStream);
		class procedure ContinueDownload(fileContents : TStream;
      chunkSize, position : integer; handle : byte; aStream : TStream);
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
  public
    class procedure BuildCommand(aCommandType : TCommandType;
      globals, locals : integer; args : TStream; aStream: TStream);
		class procedure OutputPower(layer : byte; port : TPortId; power : byte; aStream : TStream);
		class procedure OutputSpeed(layer : byte; port : TPortId; speed : byte; aStream : TStream);
		class procedure OutputStart(layer : byte; port : TPortId; aStream : TStream);
		class procedure OutputStop(layer : byte; port : TPortId; forceStop : Boolean; aStream : TStream);
		class procedure OutputClearCount(layer, portBitField : byte; aStream : TStream);
		class procedure MemoryRead(slot : TProgramSlot; objId, offset, size, globalIndex : integer; aStream : TStream);
		class procedure MemoryWrite(slot : TProgramSlot; objId, offset, size, arrayHandle : integer; aStream : TStream);
    class procedure ReadArrayContent(slot : TProgramSlot; arrayHandle, index, bytes, dataOut : integer; aStream : TStream);
		class procedure SensorRead(layer : byte; port : TPortId; sensor, mode, readSI, globalIndex : byte; aStream : TStream);
		class procedure SensorReadyRead(layer : byte; port : TPortId; sensor, mode, numberOfReturnValues, readSI, globalIndex : byte; aStream : TStream);
		class procedure SensorGetType(layer : byte; port : TPortId; globalIndexType, globalIndexMode : byte; aStream : TStream);
    class procedure InputClear(layer : byte; port : TPortId; aStream : TStream);
    class procedure InputWrite(layer : byte; port : TPortId; data : TStream; aStream : TStream);
		class procedure PutInMruList(fileName : string; aStream : TStream);
		class procedure LoadImage(imageName : string; slot, size, address : integer; aStream : TStream);
		class procedure ProgramStart(slot : TProgramSlot; size, address : integer; mode : TProgramStartMode; aStream : TStream);
		class procedure RenameBrick(name : string; aStream : TStream);
		class procedure GetBrickName(maxLength, globalOffset : integer; aStream : TStream);
		class procedure ProgramStop(slot : TProgramSlot; aStream : TStream);
		class procedure GetFavorItemsCount(aStream : TStream);
		class procedure GetFavorItem(index : byte; aStream : TStream);
		class procedure GetProgramStatus(slot : TProgramSlot; statusGlobalIndex : byte; aStream : TStream);
		class procedure GetBrickPowerStatus(blockIndex : byte; aStream : TStream);
		class procedure GetBrickSDCardStatus(presentIndex, totalKBIndex, freeKBIndex : byte; aStream : TStream);
		class procedure GetOnBrickStorageStatus(totalKBIndex, freeKBIndex : byte; aStream : TStream);
		class procedure GetBrickFirmwareVersion(stringLength, stringIndex : byte; aStream : TStream);
		class procedure ProgramObjectStart(slot : TProgramSlot; objectID : integer; aStream : TStream);
		class procedure MoveValueToGlobal(value, globalIndex : integer; aStream : TStream);
		class procedure InitBytes(destinationIndex : integer; values : TBytes; aStream : TStream);
		class procedure DoesFileExist(fileName : string; statusGlobalIndex : byte; aStream : TStream);
		class procedure DeleteFile(path : string; aStream : TStream);
		class procedure CopyFile(sourcePath, destinationPath : string; aStream : TStream);
		class procedure DownloadCompleteSound(aStream : TStream);
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
  WriteByte(aStream, 0);
end;

class procedure TSystemCommandBuilder.FileDownloadSection(
  fileContents: TStream; chunkSize, position: integer;
  handle: byte; aStream : TStream);
begin
  ContinueDownload(fileContents, chunkSize, position, handle, aStream);
end;

class procedure TSystemCommandBuilder.ContinueDownload(
  fileContents: TStream; chunkSize, position: integer;
  handle: byte; aStream : TStream);
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
  WriteByte(aStream, 0);
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
  WriteByte(aStream, 0);
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
  WriteByte(aStream, 0);
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
  WriteByte(aStream, 0);
end;

class procedure TSystemCommandBuilder.DeleteFile(fileName: string;
  aStream: TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycDeleteFile));
  WriteString(aStream, fileName);
  WriteByte(aStream, 0);
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
  WriteByte(aStream, 0);
  WriteWord(aStream, Length(aPayload));
  WriteString(aStream, aPayload);
  WriteByte(aStream, 0);
end;

class procedure TSystemCommandBuilder.BluetoothPin(aAddress: string;
  aPin: string; aStream: TStream);
begin
  WriteByte(aStream, Ord(ctSystemWithReply));
  WriteByte(aStream, Ord(sycBluetoothPin));
  WriteByte(aStream, Length(aAddress) + 1); // # bytes in bt address
  WriteString(aStream, aAddress);
  WriteByte(aStream, 0);
  WriteByte(aStream, Length(aPin) + 1); // # bytes in Pin
  WriteString(aStream, aPin);
  WriteByte(aStream, 0);
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
  WriteByte(aStream, Byte(aCommandType));
  WriteByte(aStream, Byte(globals and 255));
  WriteByte(aStream, Byte(((locals and 63) shl 2) or ((globals shr 8) and 3)));
  if Assigned(args) then
    aStream.CopyFrom(args, 0);
  WriteByte(aStream, 10);
end;

class procedure TDirectCommandBuilder.OutputPower(layer: byte;
  port: TPortId; power: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTPOWER);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, power, atInteger);
end;

class procedure TDirectCommandBuilder.OutputSpeed(layer: byte;
  port: TPortId; speed: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopOUTPUTSPEED);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, speed, atInteger);
end;

class procedure TDirectCommandBuilder.OutputStart(layer: byte;
  port: TPortId; aStream: TStream);
begin
  TBinaryWriterExtension.Write(aStream, Byte(pbopOUTPUTSTART));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
end;

class procedure TDirectCommandBuilder.OutputStop(layer: byte;
  port: TPortId; forceStop: Boolean; aStream: TStream);
begin
  TBinaryWriterExtension.Write(aStream, Byte(pbopOUTPUTSTOP));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.Write(aStream, Byte(Ord(forceStop)));
end;

class procedure TDirectCommandBuilder.OutputClearCount(layer,
  portBitField: byte; aStream: TStream);
begin
  TBinaryWriterExtension.Write(aStream, Byte(pbopOUTPUTCLRCOUNT));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, portBitField);
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
end;

class procedure TDirectCommandBuilder.SensorRead(layer: byte;
  port: TPortId; sensor, mode, readSI, globalIndex: byte;
  aStream: TStream);
var
  op : TPBrickOpCode;
begin
  op := pbopINPUTREAD;
  if readSI <> 0 then
    op := pbopINPUTREADSI;
  TBinaryWriterExtension.WriteOpCode(aStream, op);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, sensor, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, mode, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.SensorReadyRead(layer: byte;
  port: TPortId; sensor, mode, numberOfReturnValues, readSI,
  globalIndex: byte; aStream: TStream);
var
  op : TPBrickOpCode;
begin
  op := MakeOpCode(idscReadyPct);
  if readSI <> 0 then
    op := MakeOpCode(idscReadySI);
  TBinaryWriterExtension.WriteOpCode(aStream, op);
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, sensor, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, mode, atInteger);
  TBinaryWriterExtension.Write(aStream, numberOfReturnValues);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.SensorGetType(layer: byte;
  port: TPortId; globalIndexType, globalIndexMode: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscGetTypeMode));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndexType, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndexMode, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InputClear(layer: byte;
  port: TPortId; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(idscClrChanges));
  TBinaryWriterExtension.Write(aStream, layer);
  TBinaryWriterExtension.Write(aStream, Byte(port));
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
    TBinaryWriterExtension.WriteIntArgument(astream, arg, atInteger);
  end;
end;

class procedure TDirectCommandBuilder.PutInMruList(fileName: string;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopFILE);
  TBinaryWriterExtension.Write(aStream, Byte(fscPutCacheFile));
  TBinaryWriterExtension.WriteStringArgument(aStream, fileName);
end;

class procedure TDirectCommandBuilder.LoadImage(imageName: string; slot,
  size, address: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopFILE);
  TBinaryWriterExtension.Write(aStream, Byte(fscLoadImage));
  TBinaryWriterExtension.WriteIntArgument(aStream, Ord(slot), atInteger);
  TBinaryWriterExtension.WriteStringArgument(aStream, imageName);
  TBinaryWriterExtension.WriteIntArgument(aStream, size, atLocalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, address, atLocalOffset);
end;

class procedure TDirectCommandBuilder.ProgramStart(slot: TProgramSlot;
  size, address: integer; mode: TProgramStartMode; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopPROGRAMSTART);
  TBinaryWriterExtension.WriteIntArgument(aStream, Byte(slot), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, size, atLocalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, address, atLocalOffset);
  TBinaryWriterExtension.Write(aStream, Byte(mode));
end;

class procedure TDirectCommandBuilder.RenameBrick(name: string;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(csscBrickName));
  TBinaryWriterExtension.WriteStringArgument(aStream, name);
end;

class procedure TDirectCommandBuilder.GetBrickName(maxLength,
  globalOffset: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(cgscBrickName));
  TBinaryWriterExtension.WriteIntArgument(aStream, maxLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalOffset, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.ProgramStop(slot: TProgramSlot;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopPROGRAMSTOP);
  TBinaryWriterExtension.WriteIntArgument(aStream, Byte(slot), atInteger);
end;

class procedure TDirectCommandBuilder.GetFavorItemsCount(aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(cgscFavorItems));
  TBinaryWriterExtension.WriteIntArgument(aStream, Ord(htlBluetooth), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, 0, atGlobalOffset);
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
end;

class procedure TDirectCommandBuilder.GetProgramStatus(slot: TProgramSlot;
  statusGlobalIndex: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopPROGRAMINFO);
  TBinaryWriterExtension.Write(aStream, Byte(picGetStatus));
  TBinaryWriterExtension.WriteIntArgument(aStream, Ord(slot), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, statusGlobalIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickPowerStatus(blockIndex: byte;
  aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetVBattery));
  TBinaryWriterExtension.WriteIntArgument(aStream, blockIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickSDCardStatus(presentIndex,
  totalKBIndex, freeKBIndex: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetSDCardPresent));
  TBinaryWriterExtension.WriteIntArgument(aStream, presentIndex, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, totalKBIndex, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, freeKBIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetOnBrickStorageStatus(totalKBIndex,
  freeKBIndex: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopMemoryUsage);
  TBinaryWriterExtension.WriteIntArgument(aStream, totalKBIndex, atGlobalOffset);
  TBinaryWriterExtension.WriteIntArgument(aStream, freeKBIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.GetBrickFirmwareVersion(stringLength,
  stringIndex: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(urcGetFWVersion));
  TBinaryWriterExtension.WriteIntArgument(aStream, stringLength, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, stringIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.ProgramObjectStart(
  slot: TProgramSlot; objectID: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopPROGRAMINFO);
  TBinaryWriterExtension.Write(aStream, Byte(picObjectStart));
  TBinaryWriterExtension.WriteIntArgument(aStream, Byte(slot), atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, objectID, atInteger);
end;

class procedure TDirectCommandBuilder.MoveValueToGlobal(value,
  globalIndex: integer; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopMOVE3232);
  TBinaryWriterExtension.WriteIntArgument(aStream, value, atInteger);
  TBinaryWriterExtension.WriteIntArgument(aStream, globalIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.InitBytes(destinationIndex: integer;
  values: TBytes; aStream: TStream);
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
end;

class procedure TDirectCommandBuilder.DoesFileExist(fileName: string;
  statusGlobalIndex: byte; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopFileName);
  TBinaryWriterExtension.Write(aStream, 16);
  TBinaryWriterExtension.WriteStringArgument(aStream, fileName);
  TBinaryWriterExtension.WriteIntArgument(aStream, statusGlobalIndex, atGlobalOffset);
end;

class procedure TDirectCommandBuilder.DeleteFile(path: string; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopFILE);
  TBinaryWriterExtension.Write(aStream, Byte(fscRemove));
  TBinaryWriterExtension.WriteStringArgument(aStream, path);
end;

class procedure TDirectCommandBuilder.CopyFile(sourcePath,
  destinationPath: string; aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, pbopFILE);
  TBinaryWriterExtension.Write(aStream, Byte(fscMove));
  TBinaryWriterExtension.WriteStringArgument(aStream, sourcePath);
  TBinaryWriterExtension.WriteStringArgument(aStream, destinationPath);
end;

class procedure TDirectCommandBuilder.DownloadCompleteSound(aStream: TStream);
begin
  TBinaryWriterExtension.WriteOpCode(aStream, MakeOpCode(uwcDownloadEnd));
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
    1:
      begin
        WriteByte(aStream, b or Byte(argument and 63));
      end;
    2:
      begin
        WriteByte(aStream, b or 129);
        WriteByte(aStream, Byte(argument));
      end;
    3:
      begin
        WriteByte(aStream, b or 130);
        WriteSmallInt(aStream, SmallInt(argument));
      end;
    5:
      begin
        WriteByte(aStream, b or 131);
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
    WriteWord(aStream, Word(opCode));
  end;
end;

class procedure TBinaryWriterExtension.WriteStringArgument(
  aStream: TStream; value: string);
begin
  WriteByte(aStream, 128);
  WriteString(aStream, value);
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