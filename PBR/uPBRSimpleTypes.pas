unit uPBRSimpleTypes;

interface

type
  TByteArray = array of byte;

const
  PBrickDefinitionRuntimeName = 'PBR';
	PBrickDefinitionVMVersion   = 57;
	FileExtensionsProject           = '.ev3';
  FileExtensionsProgram           = '.ev3p';
	FileExtensionsInternalVI        = '.vix';
	FileExtensionsDataLogger        = '.ev3e';
	FileExtensionsMyBlockDefinition = '.mbxml';
	FileExtensionsFirmware          = '.bin';
	FileExtensionsBrickSound        = '.rsf';
	FileExtensionsBrickImage        = '.rgf';
	FileExtensionsDataLogData       = '.rdf';
  FileExtensionExecutable         = '.rbf';

type
	TArgType = (
		atInteger,
		atFloatingPoint,
		atString,
		atArray,
		atLocalOffset,
		atGlobalOffset,
		atVariableOut,
		atLabelOffset,
		atObjectId,
		atProgramSlot,
		atInfoCommand,
		atStringCommand,
		atFileCommand,
		atMemoryCommand,
		atArrayCommand,
		atUiWriteCommand,
		atUiReadCommand,
		atUiDrawCommand,
		atSoundCommand,
		atFileNameCommand
	);

  TArraySubCommand = (
		ascDelete, // = 49408,
		ascCreate8,
		ascCreate16,
		ascCreate32,
		ascCreateF,
		ascResize,
		ascFill,
		ascCopy,
		ascInit8,
		ascInit16,
		ascInit32,
		ascInitF,
		ascSize,
		ascReadContent,
		ascWriteContent,
		ascReadSize
	);

  TComGetSubCommand = (
		cgscOnOff,// = 54017,
		cgscVisible,
		cgscUnused2,
		cgscResult,// = 54020,
		cgscPin,
    cgscUnused5,
    cgscUnused6,
		cgscSearchItems,// = 54024,
		cgscSearchItem,
		cgscFavorItems,
		cgscFavorItem,
		cgscId,
		cgscBrickName,
		cgscNetwork,
		cgscPresent,
		cgscEncrypt,
		cgscConnectItems,
		cgscConnectItem,
		cgscIncoming
  );

  TComSetSubCommand = (
		csscOnOff,// = 54273,
		csscVisible,
		csscSearch,
    csscUnused3,
		csscPin,// = 54277,
    csscUnused5,
		csscConnection,// = 54279,
		csscBrickName,
		csscMoveUp,
		csscMoveDown,
		csscEncrypt,
		csscSSID
  );

	TCommandType = (
		ctDirectWithReply, // 0
		ctSystemWithReply, // 1
		ctDirectCommandResponse,
		ctSystemCommandResponse,
		ctDirectCommandResponseError,
		ctSystemCommandResponseError,
		ctDirectNoReply = 128, // 0x80
		ctSystemNoReply        // 0z81
	);

	TFileSubCommand = (
		fscOpenAppend, // = 49152,
		fscOpenRead,
		fscOpenWrite,
		fscReadValue,
		fscWriteValue,
		fscReadText,
		fscWriteText,
		fscClose,
		fscLoadImage,
		fscGetHandle,
		fscLoadPicture,
		fscGetPool,
		fscSetLogSyncTime,
		fscGetFolders,
		fscGetLogSyncTime,
		fscGetSubFolderName,
		fscWriteLog,
		fscCloseLog,
		fscGetImage,
		fscGetItem,
		fscGetCacheFiles,
		fscPutCacheFile,
		fscGetCacheFile,
		fscDelCacheFile,
		fscDelSubFolder,
		fscLoadSound,
		fscGetCacheName,
		fscOpenLog,
		fscReadBytes,
		fscWriteBytes,
		fscRemove,
		fscMove
	);

	TFileHandlingStatus = (
		fhsSuccess,
		fhsUnknownHandle,
		fhsHandleNotReady,
		fhsCorruptFile,
		fhsNoHandlesAvailable,
		fhsNoPermission,
		fhsIllegalPath,
		fhsFileExits,
		fhsEndOfFile,
		fhsSizeError,
		fhsUnknownError
	);

	THardwareTransportLayer = (
		htlNone,
		htlUsb,
		htlBluetooth,
		htlWifi
	);

  TInputDeviceSubCommand = (
		idscGetFormat,// = 39170,
		idscCalMinMax,
		idscCalDefault,
		idscGetTypeMode,
		idscGetSymbol,
		idscCalMin,
		idscCalMax,
    idscUnused7,
		idscClrAll,// = 39178,
		idscGetRaw,
    idscUnused10,
    idscUnused11,
    idscUnused12,
    idscUnused13,
    idscUnused14,
    idscUnused15,
    idscUnused16,
    idscUnused17,
    idscUnused18,
		idscGetName,// = 39189,
		idscGetModeName,
		idscSetRaw,
		idscGetFigures,
		idscGetChanges,
		idscClrChanges,
		idscReadyPct,
		idscReadyRaw,
		idscReadySI,
		idscGetMinMax
  );

	TProgramInfoCommand = (
		picObjectStop,
		picObjectStart = 4,
		picGetStatus = 22,
		picGetSpeed,
    picGetProgramResult
	);

	TLeadByte = (
		lbZero = 0,
		lbLongFormatFlag = 128,
		lbVariableFlag = 64,
		lbGlobalVariableFlag = 32,
		lbNegativeConstantFlag = 32,
		lbShortValueMask = 31,
		lbShortValueNegativeBitsMask = 224,
		lbBytesToFollowMask = 3,
		lbNullTerminatedStringToFollow = 0,
		lbOneByteFollows = 1,
		lbTwoBytesFollow = 2,
		lbFourBytesFollow = 3
	);

  TMathSubCommand = (
		mscEToTheX, // 36097
		mscModulo,
		mscFloor,
		mscCeiling,
		mscRound,
		mscAbsoluteValue,
		mscNegate,
		mscSquareRoot,
		mscLog,
		mscLn,
		mscSin,
		mscCos,
		mscTan,
		mscASin,
		mscACos,
		mscATan,
		mscMod8,
		mscMod16,
		mscMod32,
		mscPower
  );

	TMemoryCommand = (
		mcDelete,
		mcCreate8,
		mcCreate16,
		mcCreate32,
		mcCreateF,
		mcResize,
		mcFill,
		mcCopy,
		mcLoadImage,
		mcSaveImage,
		mcLoadPicture,
		mcGetPool,
		mcClose,
		mcGetProjects,
		mcGetProjectIcon,
		mcGetProjectName,
		mcGetProjectFileNames,
		mcGetProjectFileName,
		mcGetProjectImage,
		mcGetApps,
		mcGetAppIcon,
		mcGetAppName,
		mcGetAppImage,
		mcGetTools,
		mcGetToolsIcon,
		mcGetToolName,
		mcGetToolImage
	);

	TPBrickOpCode = (
		pbopERROR,
		pbopNOP,
		pbopPROGRAMSTOP,
		pbopPROGRAMSTART,
		pbopOBJECTSTOP,
		pbopOBJECTSTART,
		pbopOBJECTTRIG,
		pbopOBJECTWAIT,
		pbopRETURN,
		pbopCALL,
		pbopOBJECTEND,
		pbopSLEEP,
		pbopPROGRAMINFO,
		pbopLABEL,
		pbopPROBE,
		pbopDO,
		pbopADD8,
		pbopADD16,
		pbopADD32,
		pbopADDF,
		pbopSUB8,
		pbopSUB16,
		pbopSUB32,
		pbopSUBF,
		pbopMUL8,
		pbopMUL16,
		pbopMUL32,
		pbopMULF,
		pbopDIV8,
		pbopDIV16,
		pbopDIV32,
		pbopDIVF,
		pbopOR8,
		pbopOR16,
		pbopOR32,
		pbopAND8 = 36,
		pbopAND16,
		pbopAND32,
		pbopXOR8 = 40,
		pbopXOR16,
		pbopXOR32,
		pbopINITBYTES = 47,
		pbopMOVE88,
		pbopMOVE816,
		pbopMOVE832,
		pbopMOVE8F,
		pbopMOVE168,
		pbopMOVE1616,
		pbopMOVE1632,
		pbopMOVE16F,
		pbopMOVE328,
		pbopMOVE3216,
		pbopMOVE3232,
		pbopMOVE32F,
		pbopMOVEF8,
		pbopMOVEF16,
		pbopMOVEF32,
		pbopMOVEFF,
		pbopJR,
		pbopJRFALSE,
		pbopJRTRUE,
		pbopSWITCH8,
		pbopCPLT8,
		pbopCPLT16,
		pbopCPLT32,
		pbopCPLTF,
		pbopCPGT8,
		pbopCPGT16,
		pbopCPGT32,
		pbopCPGTF,
		pbopCPEQ8,
		pbopCPEQ16,
		pbopCPEQ32,
		pbopCPEQF,
		pbopCPNEQ8,
		pbopCPNEQ16,
		pbopCPNEQ32,
		pbopCPNEQF,
		pbopCPLTEQ8,
		pbopCPLTEQ16,
		pbopCPLTEQ32,
		pbopCPLTEQF,
		pbopCPGTEQ8,
		pbopCPGTEQ16,
		pbopCPGTEQ32,
		pbopCPGTEQF,
		pbopSELECT8,
		pbopSELECT16,
		pbopSELECT32,
		pbopSELECTF,
		pbopPortConverOutput = 97,
		pbopPortConverInput,
		pbopNoteToFrequency,
		pbopJRLT8,
		pbopJRLT16,
		pbopJRLT32,
		pbopJRLTF,
		pbopJRGT8,
		pbopJRGT16,
		pbopJRGT32,
		pbopJRGTF,
		pbopJREQ8,
		pbopJREQ16,
		pbopJREQ32,
		pbopJREQF,
		pbopJRNEQ8,
		pbopJRNEQ16,
		pbopJRNEQ32,
		pbopJRNEQF,
		pbopJRLTEQ8,
		pbopJRLTEQ16,
		pbopJRLTEQ32,
		pbopJRLTEQF,
		pbopJRGTEQ8,
		pbopJRGTEQ16,
		pbopJRGTEQ32,
		pbopJRGTEQF,
		pbopINFO,
//		pbopInfoGetMinutes = 31750,
//		pbopInfoSetMinutes,
		pbopSTRING, // 125
//		pbopStringGetSize = 32001,
//		pbopStringConcat,
//		pbopStringCompare,
//		pbopStringDuplicate = 32005,
//		pbopStringValueToString,
//		pbopStringToValue,
//		pbopStringStrip,
//		pbopStringNumberToString,
		pbopMemoryWrite = 126,
		pbopMemoryRead = 127,
		pbopUIFLUSH = 128,
		pbopUIREAD,
//		pbopUIReadGetVBatt = 33025,
//		pbopUIReadGetIBatt,
//		pbopUIReadGetOSVersion,
//		pbopUIReadGetEvent,
//		pbopUIReadTBatt = 33030,
//		pbopUIReadIMotor,
//		pbopUIReadString,
//		pbopUIReadGetPower = 33053,
		pbopUIWRITE = 130,
//		pbopUIWriteFlush = 33281,
//		pbopUIWritePutString = 33288,
//		pbopUIWriteValue8,
//		pbopUIWriteValue16,
//		pbopUIWriteValue32,
//		pbopUIWriteValueF,
//		pbopUIWriteAddress,
//		pbopUIWriteCode,
//		pbopUIWriteSetTestPin = 33304,
//		pbopUIWriteInitRun,
//		pbopUIWriteUpdateRun,
//		pbopUIWriteLed,
//		pbopUIWritePower,
//		pbopUIWriteGraphSample,
//		pbopUIWriteTerminal,
		pbopUIBUTTON = 131,
		pbopUIButtonPressed = 33545,
		pbopUIButtonGetBumped = 33550,
		pbopUIDRAW = 132,
//		pbopUIDrawUpdate = 33792,
//		pbopUIDrawClean,
//		pbopUIDrawPixel,
//		pbopUIDrawLine,
//		pbopUIDrawCircle,
//		pbopUIDrawText,
//		pbopUIDrawIcon,
//		pbopUIDrawPicture,
//		pbopUIDrawValue,
//		pbopUIDrawFillRect,
//		pbopUIDrawRect,
//		pbopUIDrawNotification,
//		pbopUIDrawQuestion,
//		pbopUIDrawKeyboard,
//		pbopUIDrawProjectSelect,
//		pbopUIDrawAppSelect,
//		pbopUIDrawInverseRect,
//		pbopUIDrawSelectFont,
//		pbopUIDrawTopLine,
//		pbopUIDrawEraseWindow,
//		pbopUIDrawCacheSelect,
//		pbopUIDrawDotLine,
//		pbopUIDrawViewValue,
//		pbopUIDrawViewUnit,
//		pbopUIDrawFillCircle,
//		pbopUIDrawStore,
//		pbopUIDrawRestore,
//		pbopUIDrawIconQuestion,
//		pbopUIDrawBmpFile,
//		pbopUIDrawFileSelect,
		pbopTIMERWAIT = 133,
		pbopTIMERREADY,
		pbopTIMERREAD,
		pbopTimerReadMicroseconds = 143,
		pbopBP0 = 136,
		pbopBP1,
		pbopBP2,
		pbopBP3,
		pbopBPSET,
		pbopMATH,
//		pbopMathEToTheX = 36097,
//		pbopMathModulo,
//		pbopMathFloor,
//		pbopMathCeiling,
//		pbopMathRound,
//		pbopMathAbsoluteValue,
//		pbopMathNegate,
//		pbopMathSquareRoot,
//		pbopMathLog,
//		pbopMathLn,
//		pbopMathSin,
//		pbopMathCos,
//		pbopMathTan,
//		pbopMathASin,
//		pbopMathACos,
//		pbopMathATan,
//		pbopMathMod8,
//		pbopMathMod16,
//		pbopMathMod32,
//		pbopMathPower,
		pbopRANDOM = 142,
		pbopKeepAlive = 144,
		pbopComReady = 208,
		pbopCOMREAD = 145,
		pbopComGet = 211,
//		pbOpComGetOnOff = 54017,
//		pbOpComGetVisible,
//		pbOpComGetResult = 54020,
//		pbOpComGetPin,
//		pbOpComSearchItems = 54024,
//		pbOpComSearchItem,
//		pbOpComFavorItems,
//		pbOpComFavorItem,
//		pbOpComGetId,
//		pbOpComGetBrickName,
//		pbOpComGetNetwork,
//		pbOpComGetPresent,
//		pbOpComGetEncrypt,
//		pbOpComConnectItems,
//		pbOpComConnectItem,
//		pbOpComGetIncoming,
		pbopComSet = 212,
//		pbopComSetOnOff = 54273,
//		pbopComSetVisible,
//		pbopComSetSearch,
//		pbopComSetPin = 54277,
//		pbopComSetConnection = 54279,
//		pbopComSetBrickName,
//		pbopComSetMoveUp,
//		pbopComSetMoveDown,
//		pbopComSetEncrypt,
//		pbopComSetSSID,
		pbopComTest = 213,
		pbopCOMWRITE = 146,
		pbopSOUND = 148,
//		pbopSoundBreak = 37888,
//		pbopSoundTone,
//		pbopSoundPlayFile,
//		pbopSoundRepeat,
//		pbopSoundService,
		pbopSOUNDTEST = 149,
		pbopSOUNDREADY,
		pbopInputSample,
		pbopINPUTDEVICELIST,
		pbopINPUTDEVICE,
//		pbopInputDeviceGetFormat = 39170,
//		pbopInputDeviceCalMinMax,
//		pbopInputDeviceCalDefault,
//		pbopInputDeviceGetTypeMode,
//		pbopInputDeviceGetSymbol,
//		pbopInputDeviceCalMin,
//		pbopInputDeviceCalMax,
//		pbopInputDeviceClrAll = 39178,
//		pbopInputDeviceGetRaw,
//		pbopInputDeviceGetName = 39189,
//		pbopInputDeviceGetModeName,
//		pbopInputDeviceSetRaw,
//		pbopInputDeviceGetFigures,
//		pbopInputDeviceGetChanges,
//		pbopInputDeviceClrChanges,
//		pbopInputDeviceReadyPct,
//		pbopInputDeviceReadyRaw,
//		pbopInputDeviceReadySI,
//		pbopInputDeviceGetMinMax,
		pbopINPUTREAD = 154,
		pbopINPUTTEST,
		pbopINPUTREADY,
		pbopINPUTREADSI,
		pbopINPUTREADEXT,
		pbopINPUTWRITE,
		pbopOUTPUTGETTYPE, // 160
		pbopOUTPUTSETTYPE,
		pbopOUTPUTRESET,
		pbopOUTPUTSTOP,
		pbopOUTPUTPOWER,
		pbopOUTPUTSPEED,
		pbopOUTPUTSTART,
		pbopOUTPUTPOLARITY,
		pbopOUTPUTREAD,
		pbopOUTPUTTEST,
		pbopOUTPUTREADY, // 170
		pbopOUTPUTPOSITION,
		pbopOUTPUTSTEPPOWER,
		pbopOUTPUTTIMEPOWER,
		pbopOUTPUTSTEPSPEED,
		pbopOUTPUTTIMESPEED,
		pbopOUTPUTSTEPSYNC,
		pbopOUTPUTTIMESYNC,
		pbopOUTPUTCLRCOUNT,
		pbopOUTPUTGETCOUNT, // 179
		pbopFILE = 192,
//		pbopFileOpenAppend = 49152,
//		pbopFileOpenRead,
//		pbopFileOpenWrite,
//		pbopFileReadValue,
//		pbopFileWriteValue,
//		pbopFileReadText,
//		pbopFileWriteText,
//		pbopFileClose,
//		pbopFileLoadImage,
//		pbopFileGetHandle,
//		pbopFileLoadPicture,
//		pbopFileGetPool,
//		pbopFileSetLogSyncTime,
//		pbopFileGetFolders,
//		pbopFileGetLogSyncTime,
//		pbopFileGetSubFolderName,
//		pbopFileWriteLog,
//		pbopFileCloseLog,
//		pbopFileGetImage,
//		pbopFileGetItem,
//		pbopFileGetCacheFiles,
//		pbopFilePutCacheFile,
//		pbopFileGetCacheFile,
//		pbopFileDelCacheFile,
//		pbopFileDelSubFolder,
//		pbopFileLoadSound,
//		pbopFileGetCacheName,
//		pbopFileOpenLog,
//		pbopFileReadBytes,
//		pbopFileWriteBytes,
//		pbopFileRemove,
//		pbopFileMove,
		pbopFileName = 198,
		pbopFileNameExist = 50704,
		pbopFileNameTotalSize,
		pbopFileNameSplit,
		pbopFileNameMerge,
		pbopARRAY = 193,
//		pbopArrayDelete = 49408,
//		pbopArrayCreate8,
//		pbopArrayCreate16,
//		pbopArrayCreate32,
//		pbopArrayCreateF,
//		pbopArrayResize,
//		pbopArrayFill,
//		pbopArrayCopy,
//		pbopArrayInit8,
//		pbopArrayInit16,
//		pbopArrayInit32,
//		pbopArrayInitF,
//		pbopArraySize,
//		pbopArrayReadContent,
//		pbopArrayWriteContent,
//		pbopArrayReadSize,
		pbopARRAYWRITE = 194,
		pbopARRAYREAD,
		pbopArrayAppend,
    pbopMemoryUsage,
		pbopMailboxOpen = 216,
		pbopMailboxWrite,
		pbopMailboxRead,
		pbopMailboxTest,
		pbopMailboxReady,
		pbopMailboxClose,
		pbopFAIL = 255
	);

	TPortId = (
		pidNone,
		pidOutputFlag = 256,
		pidOutputA = 272,
		pidOutputB,
		pidOutputC,
		pidOutputD,
		pidAllOutputs = 287,
		pidInputFlag = 512,
		pidInputOne = 512,
		pidInputTwo,
		pidInputThree,
		pidInputFour,
		pidLayerMask = 16711680
	);

	TPower = (
		pwrMax = 100,
		pwrZeroPower = 0
	);

	TProgramSlot = (
		pslGuiSlot,
		pslUserSlot,
		pslCmdSlot,
		pslTermSlot,
		pslDebugSlot,
    pslCurrentSlot = -1
	);

	TProgramStartMode = (
		psmNormal,
		psmDebug,
		psmLoadOnly
	);

	TProgramStatus = (
		pstNone,
		pstRunning = 16,
		pstWaiting = 32,
		pstStopped = 64,
		pstHalted = 128
	);

	TRecoveryCommand = (
		rcNone,
		rcBeginDownloadWithErase = 240,
		rcBeginDownload, // 241
		rcDownloadData,  // 242
		rcChipErase,     // 243
		rcStartApp,      // 244
		rcGetChecksum,   // 245
		rcGetVersion     // 246
	);

	TStringCommand = (
		stcInvalid,
		stcGetSize,
		stcConcat,
		stcCompare,
		stcUnused4,
		stcDuplicate, // 5
		stcValueToString,
		stcStringToValue,
		stcStrip
	);

	TSystemCommand = (
		sycIllegalCommand, // 0
		sycFileDownloadHeader = 146, // ($92) begin download
		sycFileDownloadBlock, // 147 // ($93) continue download
		sycBeginUpload,      // 148 ($94)
		sycContinueUpload,   // 149 ($95)
		sycBeginGetFile,     // 150 ($96)
		sycContinueGetFile,  // 151 ($97)
		sycCloseHandle,      // 152 ($98)
		sycListFiles,        // 153 ($99)
		sycContinueListFiles,// 154 ($9a)
		sycCreateDir,        // 155 ($9b)
		sycDeleteFile,       // 156 ($9c)
		sycListOpenHandles,  // 157 ($9d)
		sycWriteMailbox,     // 158 ($9e)
		sycBluetoothPin,     // 159 ($9f)
    sycEnterFirmwareUpdate, // 160 (a0)
    sycSetBundleID, // 160 ($a1)
    sycSetBundleSeedID // 161 ($a2)
	);

	TUiDrawCommand = (
		udcUpdate,
		udcClean,
		udcPixel,
		udcLine,
		udcCircle,
		udcText,
		udcIcon,
		udcPicture,
		udcValue,
		udcFillRect,
		udcRect,
		udcNotification,
		udcQuestion,
		udcKeyboard,
		udcProjectSelect,
		udcAppSelect,
		udcInverseRect,
		udcSelectFont,
		udcTopLine,
		udcEraseWindow,
		udcCacheSelect,
		udcDotLine,
		udcViewValue,
		udcViewUnit,
		udcFillCircle,
		udcStore,
		udcRestore,
		udcIconQuestion,
		udcBmpFile,
		udcFileSelect
	);

	TUIReadCommand = (
		urcStyleCopZero,
		urcGetVBattery,
		urcGetIBattery,
		urcGetOSVersion,
    urcGetEvent,
    urcUnused5,
		urcGetTBattery,// 6
		urcGetIMotor,
		urcGetString,
		urcGetHWVersion,
		urcGetFWVersion,
		urcGetFWBuild,
		urcGetOSBuild,
		urcGetAddress,
		urcGetCode,
		urcKey,
		urcButton0,
		urcButton1,
		urcButton2,
		urcButton3,
		urcButton4,
    urcTextBoxRead,
    urcUnused22,
    urcUnused23,
    urcUnused24,
    urcUnused25,
		urcGetVersion,// 26
    urcUnused27,
    urcUnused28,
		urcGetPower,// 29
    urcGetSDCardPresent,
    urcGetUsbStickPresent,
		urcButtons
	);

  TUiWriteCommand = (
		uwcInvalid, // 0
    uwcFlush,
    uwcUnused2,
    uwcUnused3,
    uwcUnused4,
    uwcUnused5,
    uwcUnused6,
    uwcUnused7,
		uwcPutString, // 8
		uwcValue8,
		uwcValue16,
		uwcValue32,
		uwcValueF,
		uwcAddress,
		uwcCode,
    uwcDownloadEnd,
    uwcUnused16,
    uwcUnused17,
    uwcUnused18,
    uwcUnused19,
    uwcUnused20,
    uwcUnused21,
    uwcUnused22,
    uwcUnused23,
		uwcSetTestPin, // 24
    uwcInitRun,
		uwcVersion, // 26
		uwcLed,
		uwcPower, // 28
    uwcGraphSample,
		uwcTerminal// 30
{
		uwcSetTestPin, // 24
    uwcInitRun,
		uwcVersion, // 26 
		uwcLed,
    uwcUnused28,
		uwcPower, // 29
    uwcGraphSample,
		uwcTerminal// 31
}
	);

	TStorageClass = (
		scNone,
		scGlobal,
		scLocal,
		scNested,
		scConstant
	);

  TSoundSubCommand = (
		sscBreak,// = 37888,
		sscTone,
		sscPlayFile,
		sscRepeat,
		sscService
  );

	TPBrickRecoveryState = (
		pbrsDownloadingImage,
		pbrsDownloadingImageFailed,
		pbrsErasingChip,
		pbrsStartingApplication,
		pbrsFileNotFound,
		pbrsVerifyingImage,
		pbrsImageVerificationFailed,
		pbrsDeviceNotFound,
		pbrsDeviceNotInRecoveryMode,
		pbrsAborted
	);

	TPBrickStreamState = (
		pbssNone,
		pbssUpload,
		pbssDownload,
		pbssFileList,
		pbssEndOfFile
	);


function ArgTypeToStr(aValue : TArgType) : string;
function StringCommandToStr(aValue : TStringCommand) : string;
function FileCommandToStr(aValue : TFileSubCommand) : string;
function MemoryCommandToStr(aValue : TMemoryCommand) : string;
function ArrayCommandToStr(aValue : TArraySubCommand) : string;
function UiWriteCommandToStr(aValue : TUiWriteCommand) : string;
function UiReadCommandToStr(aValue : TUiReadCommand) : string;
function UiDrawCommandToStr(aValue : TUiDrawCommand) : string;

function MakeOpCode(subcommand : TUIReadCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TUIWriteCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TUIDrawCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TStringCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TMathSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TComGetSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TComSetSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TSoundSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TInputDeviceSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TFileSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TArraySubCommand) : TPBrickOpCode; overload;

implementation

uses
  TypInfo;

function ArgTypeToStr(aValue : TArgType) : string;
begin
  Result := GetEnumName(TypeInfo(TArgType), integer(aValue));
  System.Delete(Result, 1, 2); // trim "at"
end;

function StringCommandToStr(aValue : TStringCommand) : string;
begin
  Result := GetEnumName(TypeInfo(TStringCommand), integer(aValue));
  System.Delete(Result, 1, 3); // trim "stc"
end;

function FileCommandToStr(aValue : TFileSubCommand) : string;
begin
  Result := GetEnumName(TypeInfo(TFileSubCommand), integer(aValue));
  System.Delete(Result, 1, 3); // trim "fsc"
end;

function MemoryCommandToStr(aValue : TMemoryCommand) : string;
begin
  Result := GetEnumName(TypeInfo(TMemoryCommand), integer(aValue));
  System.Delete(Result, 1, 2); // trim "mc"
end;

function ArrayCommandToStr(aValue : TArraySubCommand) : string;
begin
  Result := GetEnumName(TypeInfo(TArraySubCommand), integer(aValue));
  System.Delete(Result, 1, 3); // trim "asc"
end;

function UiWriteCommandToStr(aValue : TUiWriteCommand) : string;
begin
  Result := GetEnumName(TypeInfo(TUiWriteCommand), integer(aValue));
  System.Delete(Result, 1, 3); // trim "uwc"
end;

function UiReadCommandToStr(aValue : TUiReadCommand) : string;
begin
  Result := GetEnumName(TypeInfo(TUiReadCommand), integer(aValue));
  System.Delete(Result, 1, 3); // trim "urc"
end;

function UiDrawCommandToStr(aValue : TUiDrawCommand) : string;
begin
  Result := GetEnumName(TypeInfo(TUiDrawCommand), integer(aValue));
  System.Delete(Result, 1, 3); // trim "udc"
end;

function MakeOpCode(subcommand : TUIReadCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(33024 or Byte(subcommand));
end;

function MakeOpCode(subcommand : TUIWriteCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(33280 or Byte(subcommand));
end;

function MakeOpCode(subcommand : TUIDrawCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(33792 or Byte(subcommand));
end;

function MakeOpCode(subcommand : TStringCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(32000 or Byte(subcommand));
end;

function MakeOpCode(subcommand : TMathSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(36097 or Byte(subcommand));
end;

function MakeOpCode(subcommand : TComGetSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(54017 or Byte(subcommand));
end;

function MakeOpCode(subcommand : TComSetSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(54273 or Byte(subcommand));
end;

function MakeOpCode(subcommand : TSoundSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(37888 or Byte(subcommand));
end;

function MakeOpCode(subcommand : TInputDeviceSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(39170 or Byte(subcommand));
end;

function MakeOpCode(subcommand : TFileSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(49152 or Byte(subcommand));
end;

function MakeOpCode(subcommand : TArraySubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode(49408 or Byte(subcommand));
end;


end.
