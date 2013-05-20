unit uCompilerEmit;

interface

uses
  Classes, Contnrs, uPBRSimpleTypes;

type
	TStorageClass = (
		scNone,
		scGlobal,
		scLocal,
		scNested,
		scConstant
	);

  TDataBuilder = class
  end;

  IDataType = interface
  end;

  TDataBuilderList = class(TObjectList)
  protected
    function GetItem(Index: Integer): TDataBuilder;
    procedure SetItem(Index: Integer; AObject: TDataBuilder);
  public
    function Add(AObject: TDataBuilder): Integer;
    function Remove(AObject: TDataBuilder): Integer;
    function IndexOf(AObject: TDataBuilder): Integer;
    procedure Insert(Index: Integer; AObject: TDataBuilder);
    function First: TDataBuilder;
    function Last: TDataBuilder;
    property Items[Index: Integer]: TDataBuilder read GetItem write SetItem; default;
  end;

  TParameter = class
  private
    fIsOutput: boolean;
    fIsInput: boolean;
    fDBType: IDataType;
    fConnectorIndex: integer;
    fDataBuilder: TDataBuilder;
  public
    constructor Create(db : TDataBuilder; dataBuilderType : IDataType;
      connectorIndex : integer; isInput, isOutput : boolean);
    property DataBuilder : TDataBuilder read fDataBuilder;
    property DBType : IDataType read fDBType;
    property ConnectorIndex : integer read fConnectorIndex;
    property IsInput : boolean read fIsInput;
    property IsOutput : boolean read fIsOutput;
  end;

  TParameterList = class(TObjectList)
  protected
    function GetItem(Index: Integer): TParameter;
    procedure SetItem(Index: Integer; AObject: TParameter);
  public
    function Add(AObject: TParameter): Integer;
    function Remove(AObject: TParameter): Integer;
    function IndexOf(AObject: TParameter): Integer;
    procedure Insert(Index: Integer; AObject: TParameter);
    function First: TParameter;
    function Last: TParameter;
    property Items[Index: Integer]: TParameter read GetItem write SetItem; default;
  end;

	TCallableBuilder = class
  protected
    fParameters : TParameterList;
	public
    constructor Create();
    destructor Destroy; override;
    property Parameters : TParameterList read fParameters;
	end;

  TClumpBuilder = class;

  TViBuilder = class(TCallableBuilder)
  private
    fIsReentrant: boolean;
    fIsSubVI: boolean;
    fFoundRootClump: boolean;
    fReentrantCallerAdditionalHeaderCount: integer;
    fName: string;
    fRootClump: TClumpBuilder;
    fMyMutex: TDataBuilder;
    fLocals: TDataBuilderList;
  public
    constructor Create(aName : string; aIsReentrant : boolean);
    destructor Destroy; override;
    property Name : string read fName;
    property Locals : TDataBuilderList read fLocals write fLocals;
    property MyMutex : TDataBuilder read fMyMutex write fMyMutex;
    property IsSubVI : boolean read fIsSubVI write fIsSubVI;
    property RootClump : TClumpBuilder read fRootClump;
    property IsReentrant : boolean read fIsReentrant;
    property ReentrantCallerAdditionalHeaderCount : integer read fReentrantCallerAdditionalHeaderCount;
    property FoundRootClump : boolean read fFoundRootClump write fFoundRootClump;
    function DefineLocal(aType : IDataType) : TDataBuilder; overload;
    function DefineLocal(aType : IDataType; aValue : TObject) : TDataBuilder; overload;
    function DefineOrGetClump(id : integer) : TClumpBuilder;
    function AddReentrantCaller : integer;

(*
		public Dictionary<int, ClumpBuilder> Clumps
		{
			get;
			internal set;
		}
		public DataBuilder DefineLocal(IDataType type)
		{
			DataBuilder dataBuilder = new DataBuilder(type, null, StorageClass.Local);
			this.Locals.Add(dataBuilder);
			return dataBuilder;
		}
		public DataBuilder DefineLocal(IDataType type, object value)
		{
			DataBuilder dataBuilder = new DataBuilder(type, value, StorageClass.Local);
			this.Locals.Add(dataBuilder);
			return dataBuilder;
		}
		public ReadOnlyCollection<DataBuilder> GetNonParameterLocals()
		{
			List<DataBuilder> list = new List<DataBuilder>();
			List<DataBuilder> list2 = new List<DataBuilder>();
			using (List<Parameter>.Enumerator enumerator = base.Parameters.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					Parameter current = enumerator.Current;
					list.Add(current.DataBuilder);
				}
			}
			using (List<DataBuilder>.Enumerator enumerator2 = this.Locals.GetEnumerator())
			{
				while (enumerator2.MoveNext())
				{
					DataBuilder current2 = enumerator2.Current;
					if (!list.Contains(current2))
					{
						list2.Add(current2);
					}
				}
			}
			return list2.AsReadOnly();
		}
		public ClumpBuilder DefineOrGetClump(int id)
		{
			ClumpBuilder result;
			if (this.Clumps.ContainsKey(id))
			{
				result = this.Clumps[id];
			}
			else
			{
				ClumpBuilder clumpBuilder = new ClumpBuilder(this);
				clumpBuilder.FireCount = 0;
				this.Clumps.Add(id, clumpBuilder);
				result = clumpBuilder;
			}
			return result;
		}
*)
  end;

  TClumpBuilder = class
  end;

  TObjectArray = array of TObject;

	TInstruction = class
  private
    fTargetAddress: integer;
    fOpName: string;
	public
    constructor Create(aOpName : string);
    function GetArgs : TObjectArray; virtual;
    property OpName : string read fOpName write fOpName;
    property TargetAddress : integer read fTargetAddress write fTargetAddress;
	end;

  TByteCodeGenerator = class
  private
    function GetInstruction(index: integer): TInstruction;
  protected
  public
    property Instructions[index : integer] : TInstruction read GetInstruction;
  end;

	TLabel = class
	private
		fGenerator : TByteCodeGenerator;
    fTargetInstructionIndex: integer;
    function GetGenerator: TByteCodeGenerator;
    function GetTargetInstruction: TInstruction;
  public
    property Generator : TByteCodeGenerator read GetGenerator;
    property TargetInstruction : TInstruction read GetTargetInstruction;
    property TargetInstructionIndex : integer read fTargetInstructionIndex write fTargetInstructionIndex;
    constructor Create(generator : TByteCodeGenerator);
	end;

	TBranchInstruction = class(TInstruction)
  private
    fTheLabel: TLabel;
	public
    constructor Create(aOpName : string; aLabel : TLabel);
    function GetArgs : TObjectArray; override;
    property TheLabel : TLabel read fTheLabel;
	end;

	TClumpInstruction = class(TInstruction)
  private
    fClumpBuilder : TClumpBuilder;
	public
    constructor Create(aOpName : string; aClumpBuilder : TClumpBuilder);
    function GetArgs : TObjectArray; override;
    property Clump : TClumpBuilder read fClumpBuilder;
	end;

	TCodeEndInstruction = class(TInstruction)
  private
    function GetOwningClump: TClumpBuilder;
  protected
		fOwningClump : TClumpBuilder;
		fRxeCallingClumpStore : TDataBuilder;
	public
    constructor Create(aOpName : string; thisClump : TClumpBuilder); overload;
    constructor Create(aOpName : string; thisClump : TClumpBuilder; rxeCallingClumpStore : TDataBuilder); overload;
    property OwningClump : TClumpBuilder read GetOwningClump;
    function GetArgs : TObjectArray; override;
	end;

  TArgumentList = class(TObjectList)
  end;

	TGeneralInstruction = class(TInstruction)
  private
    fIsVarArg: boolean;
    fArguments: TArgumentList;
	public
    constructor Create(aOpName : string; aArgs : TArgumentList; aIsVarArg : boolean);
    function GetArgs : TObjectArray; override;
    property Arguments : TArgumentList read fArguments;
    property IsVarArg : boolean read fIsVarArg;
	end;

	TImmediateValueInstruction = class(TInstruction)
  private
    fValue: word;
    function GetArg1: TDataBuilder;
  protected
    fDB : TDataBuilder;
  public
    constructor Create(aOpName : string; aValue : word; aDB : TDataBuilder);
    function GetArgs : TObjectArray; override;
    property Arg1 : TDataBuilder read GetArg1;
    property Value : word read fValue;
	end;

	TPBRDirectCodeInstruction = class(TInstruction)
  private
    fArguments: TArgumentList;
    fOpCode: TPBrickOpCode;
	public
    constructor Create(aOpCode : TPBrickOpCode; aArgs : TArgumentList);
    function GetArgs : TObjectArray; override;
    property Arguments : TArgumentList read fArguments;
    property OpCode : TPBrickOpCode read fOpCode;
	end;

	TCallInstruction = class(TInstruction)
  private
  private
    fReentrantIndex: integer;
    fArguments: TArgumentList;
    fVi : TViBuilder;
	public
    constructor Create(aVI : TViBuilder; aArgs : TArgumentList);
    function GetArgs : TObjectArray; override;
    property Arguments : TArgumentList read fArguments;
    property VI : TViBuilder read fVi;
    property ReentrantIndex : integer read fReentrantIndex;
	end;

	TConditionCode = (
		ccLessThan,
		ccGreaterThan,
		ccLessThanOrEqualTo,
		ccGreaterThanOrEqualTo,
		ccEqualTo,
		ccNotEqualTo
	);

	TConditionalInstruction = class(TInstruction)
  private
    fConditionCode: TConditionCode;
	public
    constructor Create(aOpName : string; cc : TConditionCode);
    property ConditionCode : TConditionCode read fConditionCode;
	end;

	TCompareInstruction = class(TConditionalInstruction)
  private
    fCompareResult: TDataBuilder;
    fOperand1: TDataBuilder;
    fOperand2: TDataBuilder;
  public
    constructor Create(aOpName : string; aCC : TConditionCode; aOperand1, aOperand2, aCompareResult : TDataBuilder);
    function GetArgs : TObjectArray; override;
    property Operand1 : TDataBuilder read fOperand1;
    property Operand2 : TDataBuilder read fOperand2;
    property CompareResult : TDataBuilder read fCompareResult;
	end;

	TConditionalBranchInstruction = class(TConditionalInstruction)
  private
    fCompareOperand1: TDataBuilder;
    fCompareOperand2: TDataBuilder;
    fTheLabel: TLabel;
	public
    constructor Create(aOpName : string; aCC : TConditionCode; aLabel : TLabel; aArg1, aArg2 : TDataBuilder);
    function GetArgs : TObjectArray; override;
    property CompareOperand1 : TDataBuilder read fCompareOperand1;
    property CompareOperand2 : TDataBuilder read fCompareOperand2;
    property TheLabel : TLabel read fTheLabel;
	end;

	TPerformanceCounterRecord = class
  private
    fSourceId: string;
    fPC: TDataBuilder;
	public
    constructor Create(aDB : TDataBuilder; aSourceID : string);
    property SourceId : string read fSourceId write fSourceId;
    property PerformanceCounter : TDataBuilder read fPC write fPC;
	end;

(*
	public static class OpName
	{
		public const string Move = "Move";
		public const string Add = "Add";
		public const string Subtract = "Subtract";
		public const string Multiply = "Multiply";
		public const string Divide = "Divide";
		public const string Quotient = "Divide";
		public const string Modulo = "Modulo";
		public const string Sqrt = "Sqrt";
		public const string AbsoluteValue = "AbsoluteValue";
		public const string Floor = "Floor";
		public const string Ceiling = "Ceiling";
		public const string Round = "Round";
		public const string RoundDown = "RoundDown";
		public const string RoundUp = "RoundUp";
		public const string Log = "Log";
		public const string Ln = "Ln";
		public const string Exponent = "Exponent";
		public const string Wait = "WaitMilliseconds";
		public const string And = "And";
		public const string Or = "Or";
		public const string Not = "Not";
		public const string Xor = "Xor";
		public const string Compare = "Compare";
		public const string CompareAndJump = "CompareAndJump";
		public const string TestAndJump = "TestAndJump";
		public const string Jump = "Jump";
		public const string Call = "Call";
		public const string Return = "Return";
		public const string ArrayIndex = "ArrayIndex";
		public const string ArrayInit = "ArrayInit";
		public const string ArrayBuild = "ArrayBuild";
		public const string ArraySize = "ArraySize";
		public const string ArraySubset = "ArraySubset";
		public const string ArrayResize = "ArrayResize";
		public const string ArrayReplaceSubset = "ArrayReplaceSubset";
		public const string ArrayInsertElement = "ArrayInsertElement";
		public const string ArrayConcatenate = "ArrayConcatenate";
		public const string StringSubset = "StringSubset";
		public const string StringConcatenate = "StringConcatenate";
		public const string NumToString = "ToString";
		public const string StringToByteArray = "StringToByteArray";
		public const string StringToNum = "StringToNum";
		public const string CodeEnd = "CodeEnd";
		public const string RXEWait = "Wait";
		public const string RxeSysCall = "RxeSysCall";
		public const string RxeFinishClumpImmediate = "RxeFinishClumpImmediate";
		public const string RxeSetOut = "RxeSetOut";
		public const string RxeGetOut = "RxeGetOut";
		public const string RxeSetIn = "RxeSetIn";
		public const string RxeGetIn = "RxeGetIn";
		public const string RxeGetTick = "RxeGetTick";
		public const string PbrInputRead = "PbrInputRead";
		public const string PbrUIWrite = "PbrUIWrite";
		public const string PbrUIFlush = "PbrUIFlush";
		public const string PbrOutputPower = "PbrOutput_Power";
		public const string PbrTimerWait = "PbrTimerWait";
		public const string PbrTimerReady = "PbrTimerReady";
		public const string ObjectTrigger = "ObjectTrigger";
		public const string ObjectWait = "ObjectWait";
		public const string Sine = "Sine";
		public const string Cosine = "Cosine";
		public const string Tangent = "Tangent";
		public const string InverseCosine = "InverseCosine";
		public const string InverseSine = "InverseSine";
		public const string InverseTangent = "InverseTangent";
	}
*)  

implementation

uses
  SysUtils;

{ TParameter }

constructor TParameter.Create(db: TDataBuilder; dataBuilderType: IDataType;
  connectorIndex: integer; isInput, isOutput: boolean);
begin
  fDataBuilder := db;
  fDBType := dataBuilderType;
  fIsInput := isInput;
  fIsOutput := isOutput;
  fConnectorIndex := connectorIndex;
end;

{ TParameterList }

function TParameterList.Add(AObject: TParameter): Integer;
begin
  Result := inherited Add(AObject);
end;

function TParameterList.First: TParameter;
begin
  Result := TParameter(inherited First);
end;

function TParameterList.GetItem(Index: Integer): TParameter;
begin
  Result := TParameter(inherited Items[Index]);
end;

function TParameterList.IndexOf(AObject: TParameter): Integer;
begin
  Result := inherited IndexOf(AObject);
end;

procedure TParameterList.Insert(Index: Integer; AObject: TParameter);
begin
  inherited Insert(Index, AObject);
end;

function TParameterList.Last: TParameter;
begin
  Result := TParameter(inherited Last);
end;

function TParameterList.Remove(AObject: TParameter): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TParameterList.SetItem(Index: Integer; AObject: TParameter);
begin
  inherited Items[Index] := AObject;
end;

{ TCallableBuilder }

constructor TCallableBuilder.Create;
begin
  inherited;
  fParameters := TParameterList.Create(true);
end;

destructor TCallableBuilder.Destroy;
begin
  FreeAndNil(fParameters);
  inherited;
end;

{ TInstruction }

constructor TInstruction.Create(aOpName: string);
begin
  fOpName := aOpName;
  fTargetAddress := -1;
end;

function TInstruction.GetArgs: TObjectArray;
begin
  SetLength(Result, 0);
end;

{ TByteCodeGenerator }

function TByteCodeGenerator.GetInstruction(index: integer): TInstruction;
begin

end;

{ TLabel }

constructor TLabel.Create(generator: TByteCodeGenerator);
begin
  fGenerator := generator;
end;

function TLabel.GetGenerator: TByteCodeGenerator;
begin
  Result := fGenerator;
end;

function TLabel.GetTargetInstruction: TInstruction;
begin
  Result := fGenerator.Instructions[TargetInstructionIndex];
end;

{ TBranchInstruction }

constructor TBranchInstruction.Create(aOpName: string; aLabel: TLabel);
begin
  inherited Create(aOpName);
  fTheLabel := aLabel;
end;

function TBranchInstruction.GetArgs: TObjectArray;
begin
  SetLength(Result, 1);
  Result[1] := fTheLabel;
end;

{ TClumpInstruction }

constructor TClumpInstruction.Create(aOpName: string; aClumpBuilder: TClumpBuilder);
begin
  inherited Create(aOpName);
  fClumpBuilder := aClumpBuilder;
end;

function TClumpInstruction.GetArgs: TObjectArray;
begin
  SetLength(Result, 1);
  Result[1] := fClumpBuilder;
end;

{ TCodeEndInstruction }

constructor TCodeEndInstruction.Create(aOpName: string;
  thisClump: TClumpBuilder);
begin
  Create(aOpName, thisClump, nil);
end;

constructor TCodeEndInstruction.Create(aOpName: string;
  thisClump: TClumpBuilder; rxeCallingClumpStore: TDataBuilder);
begin
  inherited Create(aOpName);
  fOwningClump := thisClump;
  fRxeCallingClumpStore := rxeCallingClumpStore;
end;

function TCodeEndInstruction.GetArgs: TObjectArray;
begin
  if Assigned(fRxeCallingClumpStore) then
  begin
    SetLength(Result, 1);
    Result[0] := fRxeCallingClumpStore;
  end
  else
  begin
    SetLength(Result, 0);
  end;
end;

function TCodeEndInstruction.GetOwningClump: TClumpBuilder;
begin
  Result := fOwningClump;
end;

{ TGeneralInstruction }

constructor TGeneralInstruction.Create(aOpName: string; aArgs: TArgumentList; aIsVarArg: boolean);
begin
  inherited Create(aOpName);
  fArguments := aArgs;
  fIsVarArg := aIsVarArg;
end;

function TGeneralInstruction.GetArgs: TObjectArray;
var
  i : integer;
begin
  SetLength(Result, fArguments.Count);
  for i := 0 to fArguments.Count - 1 do
    Result[i] := fArguments[i];
end;

{ TConditionalInstruction }

constructor TConditionalInstruction.Create(aOpName: string; cc: TConditionCode);
begin
  inherited Create(aOpName);
  fConditionCode := cc;
end;

{ TCompareInstruction }

constructor TCompareInstruction.Create(aOpName: string; aCC: TConditionCode;
  aOperand1, aOperand2, aCompareResult: TDataBuilder);
begin
  inherited Create(aOpName, aCC);
  fOperand1 := aOperand1;
  fOperand2 := aOperand2;
  fCompareResult := aCompareResult;
end;

function TCompareInstruction.GetArgs: TObjectArray;
begin
  SetLength(Result, 4);
  Result[0] := TObject(ConditionCode);
  Result[1] := Operand1;
  Result[2] := Operand2;
  Result[3] := CompareResult;
end;

{ TImmediateValueInstruction }

constructor TImmediateValueInstruction.Create(aOpName: string;
  aValue: word; aDB: TDataBuilder);
begin
  inherited Create(aOpName);
  fDB := aDB;
  fValue := aValue;
end;

function TImmediateValueInstruction.GetArg1: TDataBuilder;
begin
  Result := fDB;
end;

function TImmediateValueInstruction.GetArgs: TObjectArray;
begin
  SetLength(Result, 1);
  Result[0] := Arg1;
end;

{ TPBRDirectCodeInstruction }

constructor TPBRDirectCodeInstruction.Create(aOpCode: TPBrickOpCode;
  aArgs: TArgumentList);
begin
  inherited Create('PBR Direct opCode Instruction');
  fArguments := aArgs;
  fOpCode := aOpCode;
end;

function TPBRDirectCodeInstruction.GetArgs: TObjectArray;
var
  i : integer;
begin
  SetLength(Result, fArguments.Count);
  for i := 0 to fArguments.Count - 1 do
    Result[i] := fArguments[i];
end;

{ TConditionalBranchInstruction }

constructor TConditionalBranchInstruction.Create(aOpName: string;
  aCC: TConditionCode; aLabel: TLabel; aArg1, aArg2: TDataBuilder);
begin
  inherited Create(aOpName, aCC);
  fTheLabel := aLabel;
  fCompareOperand1 := aArg1;
  fCompareOperand2 := aArg2;
end;

function TConditionalBranchInstruction.GetArgs: TObjectArray;
begin
  if Assigned(fCompareOperand2) then
  begin
    SetLength(Result, 4);
    Result[0] := TObject(ConditionCode);
    Result[1] := TheLabel;
    Result[2] := CompareOperand1;
  end
  else
  begin
    SetLength(Result, 3);
    Result[0] := TObject(ConditionCode);
    Result[1] := TheLabel;
    Result[2] := CompareOperand1;
    Result[3] := CompareOperand2;
  end;
end;

{ TPerformanceCounterRecord }

constructor TPerformanceCounterRecord.Create(aDB: TDataBuilder;
  aSourceID: string);
begin
  fPC := aDB;
  fSourceId := aSourceID;
end;

{ TCallInstruction }

constructor TCallInstruction.Create(aVI: TViBuilder; aArgs: TArgumentList);
begin
  inherited Create('Call');
  fVi := aVI;
  fArguments := aArgs;
  if fVi.IsReentrant then
    fReentrantIndex := fVi.AddReentrantCaller
  else
    fReentrantIndex := 0;
end;

function TCallInstruction.GetArgs: TObjectArray;
var
  i : integer;
begin
  SetLength(Result, fArguments.Count);
  for i := 0 to fArguments.Count - 1 do
    Result[i] := fArguments[i];
end;

{ TViBuilder }

function TViBuilder.AddReentrantCaller : integer;
begin
  inc(fReentrantCallerAdditionalHeaderCount);
  Result := fReentrantCallerAdditionalHeaderCount;
end;

constructor TViBuilder.Create(aName: string; aIsReentrant: boolean);
begin
  inherited Create();
  fLocals := TDataBuilderList.Create(true);
//  fClumps = new Dictionary<int, ClumpBuilder>();
  fRootClump := DefineOrGetClump(-1);
  fName := aName;
  fFoundRootClump := False;
  fIsReentrant := aIsReentrant;
  fReentrantCallerAdditionalHeaderCount := -1;
end;

destructor TViBuilder.Destroy;
begin
  FreeAndNil(fLocals);
  inherited;
end;

function TViBuilder.DefineLocal(aType: IDataType): TDataBuilder;
begin

end;

function TViBuilder.DefineLocal(aType: IDataType;
  aValue: TObject): TDataBuilder;
begin

end;

function TViBuilder.DefineOrGetClump(id: integer): TClumpBuilder;
begin

end;

{ TDataBuilderList }

function TDataBuilderList.Add(AObject: TDataBuilder): Integer;
begin
  Result := inherited Add(AObject);
end;

function TDataBuilderList.First: TDataBuilder;
begin
  Result := TDataBuilder(inherited First);
end;

function TDataBuilderList.GetItem(Index: Integer): TDataBuilder;
begin
  Result := TDataBuilder(inherited Items[Index]);
end;

function TDataBuilderList.IndexOf(AObject: TDataBuilder): Integer;
begin
  Result := inherited IndexOf(AObject);
end;

procedure TDataBuilderList.Insert(Index: Integer; AObject: TDataBuilder);
begin
  inherited Insert(Index, AObject);
end;

function TDataBuilderList.Last: TDataBuilder;
begin
  Result := TDataBuilder(inherited Last);
end;

function TDataBuilderList.Remove(AObject: TDataBuilder): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TDataBuilderList.SetItem(Index: Integer; AObject: TDataBuilder);
begin
  inherited Items[Index] := AObject;
end;

end.
