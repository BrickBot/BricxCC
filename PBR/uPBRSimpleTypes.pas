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
 * Portions created by John Hansen are Copyright (C) 2012-2103 John Hansen.
 * All Rights Reserved.
 *
 *)
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

  PRIMPAR_SHORT                 = $00;
  PRIMPAR_LONG                  = $80;
  PRIMPAR_CONST                 = $00;
  PRIMPAR_VARIABEL              = $40;
  PRIMPAR_LOCAL                 = $00;
  PRIMPAR_GLOBAL                = $20;
  PRIMPAR_HANDLE                = $10;
  PRIMPAR_ADDR                  = $08;
  PRIMPAR_INDEX                 = $1F;
  PRIMPAR_CONST_SIGN            = $20;
  PRIMPAR_VALUE                 = $3F;
  PRIMPAR_BYTES                 = $07;
  PRIMPAR_STRING_OLD            = 0;
  PRIMPAR_1_BYTE                = 1;
  PRIMPAR_2_BYTES               = 2;
  PRIMPAR_4_BYTES               = 3;
  PRIMPAR_STRING                = 4;
  PRIMPAR_LABEL                 = $20;
  LCS                           = (PRIMPAR_LONG or PRIMPAR_STRING);

  SYSTEM_REPLY_OK               = $03;    //  System command reply
  SYSTEM_REPLY_ERROR            = $05;    //  System command reply error
  DIRECT_REPLY_OK               = $02;    //  Direct command reply
  DIRECT_REPLY_ERROR            = $04;    //  Direct command reply error

  DEVCMD_RESET   = $11; //!< UART device reset
  DEVCMD_FIRE    = $11; //!< UART device fire   (ultrasonic)
  DEVCMD_CHANNEL = $12; //!< UART device channel (IR seeker)

  MODE_KEEP      = $FF;
  TYPE_KEEP      = $00;

  DATA_PCT      = $10; //!< Percent (used in opINPUT_READEXT)
  DATA_RAW      = $12; //!< Raw     (used in opINPUT_READEXT)
  DATA_SI       = $13; //!< SI unit (used in opINPUT_READEXT)

  NO_BUTTON     = 0;
  UP_BUTTON     = 1;
  ENTER_BUTTON  = 2;
  DOWN_BUTTON   = 3;
  RIGHT_BUTTON  = 4;
  LEFT_BUTTON   = 5;
  BACK_BUTTON   = 6;
  ANY_BUTTON    = 7;

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
		ascDelete, // 0
		ascCreate8,
		ascCreate16,
		ascCreate32,
		ascCreateF,
		ascResize, // 5
		ascFill,
		ascCopy,
		ascInit8,
		ascInit16,
		ascInit32, // 10
		ascInitF,
		ascSize,
		ascReadContent,
		ascWriteContent,
		ascReadSize // 15
	);

  TComGetSubCommand = (
    cgscUnused0, // 0
		cgscOnOff,
		cgscVisible,
		cgscUnused3,
		cgscResult,
		cgscPin,   // 5
    cgscUnused6,
    cgscUnused7,
		cgscSearchItems,
		cgscSearchItem,
		cgscFavorItems, // 10
		cgscFavorItem,
		cgscId,
		cgscBrickName,
		cgscNetwork,
		cgscPresent, // 15
		cgscEncrypt,
		cgscConnectItems,
		cgscConnectItem,
		cgscIncoming,
    cgscMode2 // 20
  );

  TComSetSubCommand = (
    csscUnused0, // 0
		csscOnOff,
		csscVisible,
		csscSearch,
    csscUnused4,
		csscPin, // 5
    csscPassKey,
		csscConnection,
		csscBrickName,
		csscMoveUp,
		csscMoveDown, // 10
		csscEncrypt,
		csscSSID,
    csscMode2 // 13
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

  TFilenameSubCommand = (
    fnscUnused15 = 15,
    fnscExist,
    fnscTotalSize,
    fnscSplit,
    fnscMerge,
    fnscCheck, // 20
    fnscPack,
    fnscUnpack,
    fnscGetFoldername
  );

	TFileSubCommand = (
		fscOpenAppend, // 0
		fscOpenRead,
		fscOpenWrite,
		fscReadValue,
		fscWriteValue,
		fscReadText, // 5
		fscWriteText,
		fscClose,
		fscLoadImage,
		fscGetHandle,
		fscMakeFolder, // 10
		fscGetPool,
		fscSetLogSyncTime,
		fscGetFolders,
		fscGetLogSyncTime,
		fscGetSubFolderName, // 15
		fscWriteLog,
		fscCloseLog,
		fscGetImage,
		fscGetItem,
		fscGetCacheFiles, // 20
		fscPutCacheFile,
		fscGetCacheFile,
		fscDelCacheFile,
		fscDelSubFolder,
		fscGetLogName, // 25
		fscUnused26,
		fscOpenLog,
		fscReadBytes,
		fscWriteBytes,
		fscRemove, // 30
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
		fhsFileExists,
		fhsEndOfFile,
		fhsSizeError,
		fhsUnknownError,
    fhsIllegalFilename,
    fhsIllegalConnection
	);

	THardwareTransportLayer = (
		htlNone,
		htlUsb,
		htlBluetooth,
		htlWifi
	);

  TInfoSubCommand = (
    iscUnused0, // 0
    iscSetError,
    iscGetError,
    iscErrorText,
    iscGetVolume,
    iscSetVolume, // 5
    iscGetMinutes,
    iscSetMinutes
  );

  TInputDeviceSubCommand = (
    idcUnused0, // 0
    idcUnused1,
		idscGetFormat,
		idscCalMinMax,
		idscCalDefault,
		idscGetTypeMode, // 5
		idscGetSymbol,
		idscCalMin,
		idscCalMax,
    idscSetup,
		idscClrAll, // 10
		idscGetRaw,
    idscGetConnection,
    idscStopAll,
    idscUnused14,
    idscUnused15, // 15
    idscUnused16,
    idscUnused17,
    idscUnused18,
    idscUnused19,
    idscUnused20, // 20
		idscGetName,
		idscGetModeName,
		idscSetRaw,
		idscGetFigures,
		idscGetChanges, // 25
		idscClrChanges,
		idscReadyPct,
		idscReadyRaw,
		idscReadySI,
		idscGetMinMax, // 30
    idscGetBumps
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
    mscUnused0, // 0
		mscEToTheX, 
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
    pbopSystem, // 96
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
		pbopUIREAD = 129,
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
		pbopOUTPUTGETTYPE, // 160  // not implemented
		pbopOUTPUTSETTYPE,         // not really implemented
		pbopOUTPUTRESET,
		pbopOUTPUTSTOP,
		pbopOUTPUTPOWER,
		pbopOUTPUTSPEED,
		pbopOUTPUTSTART,
		pbopOUTPUTPOLARITY,
		pbopOUTPUTREAD,
		pbopOUTPUTTEST,
		pbopOUTPUTREADY, // 170
		pbopOUTPUTPOSITION, // not implemented
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

	TProgramInfoCommand = (
		picObjectStop,
		picObjectStart = 4,
		picGetStatus = 22,
		picGetSpeed,
    picGetProgramResult,
    picSetInstruction
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

  TSoundSubCommand = (
		sscBreak, // 0
		sscTone,
		sscPlayFile,
		sscRepeat,
		sscService
  );

	TStorageClass = (
		scNone,
		scGlobal,
		scLocal,
		scNested,
		scConstant
	);

	TStringCommand = (
		stcUnused0, // 0
		stcGetSize,
		stcConcat,
		stcCompare,
		stcUnused4,
		stcDuplicate, // 5
		stcValueToString,
		stcStringToValue,
		stcStrip,
    stcNumberToString,
    stcSub, // 10
    stcValueFormatted,
    stcNumberFormatted
	);

	TSystemCommand = (
		sycIllegalCommand,    // 0
		sycFileDownloadHeader = 146, // ($92) begin download
		sycFileDownloadBlock, // 147 ($93) continue download
		sycBeginUpload,       // 148 ($94)
		sycContinueUpload,    // 149 ($95)
		sycBeginGetFile,      // 150 ($96)
		sycContinueGetFile,   // 151 ($97)
		sycCloseHandle,       // 152 ($98)
		sycListFiles,         // 153 ($99)
		sycContinueListFiles, // 154 ($9a)
		sycCreateDir,         // 155 ($9b)
		sycDeleteFile,        // 156 ($9c)
		sycListOpenHandles,   // 157 ($9d)
		sycWriteMailbox,      // 158 ($9e)
		sycBluetoothPin,      // 159 ($9f)
    sycEnterFirmwareUpdate, // 160 (a0)
    sycSetBundleID,       // 160 ($a1)
    sycSetBundleSeedID    // 161 ($a2)
	);

  TTestSubCommand = (
    tscUnused0, // 0
    tscTestOpen = 10,   //!< MUST BE GREATER OR EQUAL TO "INFO_SUBCODES"
    tscTestClose,
    tscTestReadPins,
    tscTestWritePins,
    tscTestReadAdc,
    tscTestWriteUart, // 15
    tscTestReadUart,
    tscTestEnableUart,
    tscTestDisableUart,
    tscTestAccuSwitch,
    tscTestBootMode2, // 20
    tscTestPollMode2,
    tscTestCloseMode2,
    tscTestRamCheck
  );

  TUIButtonCommand = (
    ubcUnused0, // 0
    ubcShortPress,
    ubcLongPress,
    ubcWaitForPress,
    ubcFlush,
    ubcPress, // 5
    ubcRelease,
    ubcGetHorz,
    ubcGetVert,
    ubcPressed,
    ubcSetBackBlock, // 10
    ubcGetBackBlock,
    ubcTestShortPress,
    ubcTestLongPress,
    ubcGetBumped,
    ubcGetClick // 15
  );

	TUiDrawCommand = (
		udcUpdate, // 0
		udcClean,
		udcPixel,
		udcLine,
		udcCircle,
		udcText, // 5
		udcIcon,
		udcPicture,
		udcValue,
		udcFillRect,
		udcRect, // 10
		udcNotification,
		udcQuestion,
		udcKeyboard,
		udcBrowse,
		udcVertBar, // 15
		udcInverseRect,
		udcSelectFont,
		udcTopLine,
		udcFillWindow,
		udcScroll, // 20
		udcDotLine,
		udcViewValue,
		udcViewUnit,
		udcFillCircle,
		udcStore, // 25
		udcRestore,
		udcIconQuestion,
		udcBmpFile,
		udcPopup,
    udcGraphSetup, // 30
    udcGraphDraw,
    udcTextBox
	);

	TUIReadCommand = (
		urcUnused0, // 0
		urcGetVBattery,
		urcGetIBattery,
		urcGetOSVersion,
    urcGetEvent,
    urcGetTBattery, // 5
		urcGetIInt,
		urcGetIMotor,
		urcGetString,
		urcGetHWVersion,
		urcGetFWVersion, // 10
		urcGetFWBuild,
		urcGetOSBuild,
		urcGetAddress,
		urcGetCode,
		urcGetKey, // 15
		urcGetShutdown,
		urcGetWarning,
		urcGetLBattery,
		urcUnused19,
		urcUnused20, // 20
    urcTextBoxRead,
    urcUnused22,
    urcUnused23,
    urcUnused24,
    urcUnused25, // 25
		urcGetVersion,
    urcGetIPAddress,
    urcUnused28,
		urcGetPower,// 29
    urcGetSDCard,
    urcGetUsbStick,
		urcButtons
	);

  TUiWriteCommand = (
		uwcUnused0, // 0
    uwcFlush,
    uwcFloatValue,
    uwcStamp,
    uwcUnused4,
    uwcUnused5, // 5
    uwcUnused6,
    uwcUnused7,
		uwcPutString,
		uwcValue8,
		uwcValue16, // 10
		uwcValue32,
		uwcValueF,
		uwcAddress,
		uwcCode,
    uwcDownloadEnd, // 15
    uwcScreenBlock,
    uwcUnused17,
    uwcUnused18,
    uwcUnused19,
    uwcUnused20, // 20
    uwcTextBoxAppend,
    uwcSetBusy,
    uwcUnused23,
		uwcSetTestPin,
    uwcInitRun, // 25
		uwcUpdateRun,
		uwcLed,
    uwcUnused28,
		uwcPower,
    uwcGraphSample, // 30
		uwcTerminal
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
function UiButtonCommandToStr(aValue : TUiButtonCommand) : string;

function MakeOpCode(subcommand : TUIReadCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TUIWriteCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TUIButtonCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TUIDrawCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TStringCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TMathSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TComGetSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TComSetSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TSoundSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TInputDeviceSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TFileSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TArraySubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TProgramInfoCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TFilenameSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TInfoSubCommand) : TPBrickOpCode; overload;
function MakeOpCode(subcommand : TTestSubCommand) : TPBrickOpCode; overload;

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

function UiButtonCommandToStr(aValue : TUiButtonCommand) : string;
begin
  Result := GetEnumName(TypeInfo(TUiButtonCommand), integer(aValue));
  System.Delete(Result, 1, 3); // trim "ubc"
end;

function MakeOpCode(subcommand : TUIReadCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($8100 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TUIWriteCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($8200 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TUIButtonCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($8300 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TUIDrawCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($8400 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TStringCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($7D00 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TMathSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($8D00 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TComGetSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($D300 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TComSetSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($D400 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TSoundSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($9400 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TInputDeviceSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($9900 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TFileSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($C000 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TArraySubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($C100 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TProgramInfoCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($0C00 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TFilenameSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($C600 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TInfoSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($7C00 + Byte(subcommand));
end;

function MakeOpCode(subcommand : TTestSubCommand) : TPBrickOpCode;
begin
  Result := TPBrickOpCode($FF00 + Byte(subcommand));
end;

end.
