unit uRXEMiscTypes;

interface

const
  RxeDefinitionRuntimeName = 'NXT';

type
	TClumpView = class
  private
    fFireCount: integer;
    fDepCount: integer;
    fAddress: integer;
    fName: string;
    fDownStream: string;
	public
    property Name : string read fName write fName;
    property FireCount : integer read fFireCount write fFireCount;
    property DepCount : integer read fDepCount write fDepCount;
    property Address : integer read fAddress write fAddress;
    property DownStream : string read fDownStream write fDownstream;
	end;

	TCommandModuleOffsets = (
		cmoFormatString,
		cmoPRCHandler = 16,
		cmoTick = 20,
		cmoDataSpaceOffset = 24,
		cmoDopeVectorArrayOffset = 26,
		cmoProgramStatus = 28,
		cmoAwake,
		cmoActivateFlag,
		cmoDeactivateFlag,
		cmoFileName,
		cmoMemoryPool = 52
	);

	TDopeVectorVisualization = class
  private
    fOffset: word;
    fElementCount: word;
    fLinkIndex: word;
    fElementSize: word;
    fBackPointer: word;
	public
    property Offset : word read fOffset write fOffset;
    property ElementSize : word read fElementSize write fElementSize;
    property ElementCount : word read fElementCount write fElementCount;
    property BackPointer : word read fBackPointer write fBackPointer;
    property LinkIndex : word read fLinkIndex write fLinkIndex;
	end;

	TDopeVectorCompiler = class
	private
		_offset : word;
		_elementSize : word;
		_elementCount : word;
		_backPointer : word;
		_linkIndex : word;
  public
    constructor Create(offset, elementSize, elementCount, backPointer, linkIndex : word);
    procedure WriteToStream(stream : TMemoryStream);
	end;

	TDstocType = (
		dtcVoid,
		dtcByte,
		dtcSByte,
		dtcUInt16,
		dtcInt16,
		dtcUInt32,
		dtcInt32,
		dtcArray,
		dtcCluster,
		dtcMutex,
		dtcFloat32
	);

	TNxtDataTypes = (
		ndtVoid,
		ndtUByte,
		ndtSByte,
		ndtUInt16,
		ndtInt16,
		ndtUInt32,
		ndtInt32,
		ndtArray,
		ndtStruct,
		ndtMutex,
		ndtFloat32
	);

	TRxeProgramStatus = (
		rpsIdle,
		rpsOk,
		rpsRunning,
		rpsError,
		rpsAbort,
		rpsReset
	);

	TRxeConditionCode = (
		rccLessThan,
		rccGreaterThan,
		rccLessThanOrEqualTo,
		rccGreaterThanOrEqualTo,
		rccEqualTo,
		rccNotEqualTo
	);

	TRxeInPropertyId = (
		ipidType,
		ipidMode,
		ipidRawValue,
		ipidNormalizedValue,
		ipidScaledValue,
		ipidInvalidData
	);

	TRxeOpCode = (
		rocAdd,
		rocSubtract,
		rocNegate,
		rocMultiply,
		rocDivide,
		rocModulo,
		rocAnd,
		rocOr,
		rocXor,
		rocNot,
		rocCmt,
		rocLsl,
		rocLsr,
		rocAsl,
		rocAsr,
		rocRotl,
		rocRotr,
		rocCompare,
		rocTest,
		rocCmpSet,
		rocTestSet,
		rocIndex,
		rocReplace,
		rocArraySize,
		rocArrayBuild,
		rocArraySubset,
		rocArrayInit,
		rocMove,
		rocSet,
		rocFlatten,
		rocUnflatten,
		rocNumToString,
		rocStringToNum,
		rocStringCat,
		rocStringSubset,
		rocStringToByteArray,
		rocByteArrayToString,
		rocJump,
		rocBranchCompare,
		rocBranchTest,
		rocSystemCall,
		rocStop,
		rocFinishClump,
		rocFinishClumpImmediate,
		rocAcquire,
		rocRelease,
		rocSubroutineCall,
		rocSubroutineReturn,
		rocSetIn,
		rocSetOut,
		rocGetIn,
		rocGetOut,
		rocWait,
		rocGetTickCount,
		rocSquareRoot,
		rocAbsolute
	);

	TRxeOutPropertyId = (
		opidFlags,
		opidMode,
		opidSpeed,
		opidActualSpeed,
		opidTachCount,
		opidTachLimit,
		opidRunState,
		opidTurnRatio,
		opidRegMode,
		opidOverLoad,
		opidRegPValue,
		opidRegIValue,
		opidRegDValue,
		opidBlockTachCount,
		opidRotationCount
	);

	TRxeSysCall = (
		rscFileOpenRead,
		rscFileOpenWrite,
		rscFileOpenAppend,
		rscFileRead,
		rscFileWrite,
		rscFileClose,
		rscFileResolveHandle,
		rscFileRename,
		rscFileDelete,
		rscSoundPlayFile,
		rscSoundPlayTone,
		rscSoundGetState,
		rscSoundSetState,
		rscDrawText,
		rscDrawPoint,
		rscDrawLine,
		rscDrawCircle,
		rscDrawRect,
		rscDrawPicture,
		rscSetScreenMode,
		rscReadButton,
		rscCommLSWrite,
		rscCommLSRead,
		rscCommLSCheckStatus,
		rscRandomNumber,
		rscGetStartTick,
		rscMessageWrite,
		rscMessageRead,
		rscCommBTCheckStatus,
		rscCommBTWrite,
		rscCommBTRead,
		rscKeepAlive,
		rscIOMapRead,
		rscIOMapWrite,
		rscColorSensorRead,
		rscCommBTOnOff,
		rscCommBTConnection,
		rscCommHSWrite,
		rscCommHSRead,
		rscCommHSCheckStatus,
		rscReadSemData,
		rscWriteSemData,
		rscComputeCalibValue,
		rscUpdateCalibCacheInfo,
		rscDatalogWrite,
		rscDatalogGetTimes,
		rscSetSleepTimeout,
		rscListFiles
	);

implementation

{ TDopeVectorCompiler }

constructor TDopeVectorCompiler.Create(offset, elementSize, elementCount,
  backPointer, linkIndex: word);
begin
  inherited;
  _offset       := offset;
	_elementSize  := elementSize;
	_elementCount := elementCount;
	_backPointer  := backPointer;
	_linkIndex    := linkIndex;
end;

procedure TDopeVectorCompiler.WriteToStream(stream: TMemoryStream);
begin
{
			RxeStreamBuilder.WriteUInt16ToStream(this._offset, stream);
			RxeStreamBuilder.WriteUInt16ToStream(this._elementSize, stream);
			RxeStreamBuilder.WriteUInt16ToStream(this._elementCount, stream);
			RxeStreamBuilder.WriteUInt16ToStream(this._backPointer, stream);
			RxeStreamBuilder.WriteUInt16ToStream(this._linkIndex, stream);
}
end;

end.
