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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit rcx_constants;

interface

const
  // opcodes
  kRCX_PingOp           = $10;
  kRCX_MemMapOp         = $20; // not scout, not spybot
  kRCX_BatteryLevelOp   = $30; // not scout
  kRCX_DeleteTasksOp    = $40; // not spybot ?
  kRCX_StopAllOp        = $50;
  kRCX_PBTurnOffOp      = $60;
  kRCX_DeleteSubsOp     = $70; // not spybot
  kRCX_ClearSound       = $80; // rcx2 & spybot only
  kRCX_ClearMsgOp       = $90; // not spybot
  kRCX_ExitAccessCtrlOp = $a0; // rcx2, scout, & spybot (program)
  kRCX_ExitEventChkOp   = $b0; // rcx2, scout, & spybot (program)
  kRCX_LSCalibrateOp    = $c0; // scout only
  kRCX_MuteSoundOp      = $d0; // rcx2 & spybot only
  kRCX_UnmuteSoundOp    = $e0; // rcx2 & spybot only
//  kRCX_UnknownOp        = $f0;

  kRCX_PopStackEntryOp = $01; // spybot (program)
  kRCX_UploadEepromOp  = $11; // spybot (direct)
  kRCX_ClearTachoOp    = $11; // cybermaster only
  kRCX_OutputModeOp    = $21; // not spybot
  kRCX_IRModeOp	       = $31; // not spybot
  kRCX_DriveOp	       = $41; // cybermaster only
  kRCX_PlaySoundOp     = $51;
  kRCX_DeleteTaskOp    = $61; // not spybot
  kRCX_StartTaskOp     = $71;
  kRCX_StopTaskOp      = $81;
  kRCX_SelectProgramOp = $91; // rcx only
  kRCX_ClearTimerOp    = $a1;
  kRCX_AutoOffOp       = $b1;
  kRCX_DeleteSubOp     = $c1; // not spybot
  kRCX_ClearSensorOp   = $d1; // not spybot
  kRCX_OutputDirOp     = $e1;
//  kRCX_UnknownOp       = $f1;

  kRCX_PlayToneVarOp  = $02;
  kRCX_PollOp	        = $12;
  kRCX_SetWatchOp     = $22; // not spybot
  kRCX_InputTypeOp    = $32; // not spybot
  kRCX_InputModeOp    = $42;
  kRCX_SetDatalogOp   = $52; // rcx/rcx2 only
  kRCX_DatalogOp      = $62; // rcx/rcx2 only
  kRCX_JumpOp	        = $72; // (program)
  kRCX_SetLoopOp      = $82; // (program) not spybot
  kRCX_CheckLoopOp    = $92; // (program) not spybot
//  kRCX_UnknownOp      = $a2;
  kRCX_SendMessageOp  = $b2; // (program) not spybot
  kRCX_SendUARTDataOp = $c2; // rcx2 & spybot only
  kRCX_OnWaitOp	      = $c2; // cybermaster only
  kRCX_Remote	        = $d2; // rcx2 & scout only
  kRCX_VLLOp          = $e2; // scout & spybot
  kRCX_DecVarJmpLTZOp = $f2; // (program)

  kRCX_DirectEventOp     = $03;
  kRCX_OutputPowerOp     = $13;
  kRCX_PlayToneOp        = $23;
  kRCX_DisplayOp         = $33; // not spybot
  kRCX_WaitOp            = $43; // (program)
  kRCX_OnWaitDifferentOp = $53; // cybermaster only
  kRCX_PollMemoryOp      = $63; // rcx2, scout, and spybot
  kRCX_EnterAccessCtrlOp = $73; // rcx2, scout, and spybot (program)
  kRCX_SetFeedbackOp     = $83; // scout
  kRCX_SetEventOp        = $93; // rcx2 & spybot only
  kRCX_GOutputPowerOp    = $a3; // rcx2, scout, & spybot
  kRCX_LSUpperThreshOp   = $b3; // scout
  kRCX_LSLowerThreshOp   = $c3; // scout
  kRCX_LSHysteresisOp    = $d3; // scout
  kRCX_PushStackEntryOp  = $e3; // spybot (program)
  kRCX_LSBlinkTimeOp     = $e3; // scout
  kRCX_LDecVarJmpLTZOp   = $f3; // (program)

  kRCX_CalibrateEventOp = $04; // rcx2 & spybot only
  kRCX_SetVarOp         = $14;
  kRCX_SumVarOp         = $24;
  kRCX_SubVarOp         = $34;
  kRCX_DivVarOp         = $44;
  kRCX_MulVarOp         = $54;
  kRCX_SgnVarOp         = $64;
  kRCX_AbsVarOp         = $74;
  kRCX_AndVarOp         = $84;
  kRCX_OrVarOp          = $94;
  kRCX_UploadDatalogOp  = $a4; // rcx/rcx2 only
  kRCX_SEnterEventChkOp = $b4; // rcx2, scout, & spybot (program)
  kRCX_SetTimerLimitOp  = $c4; // scout
  kRCX_SetCounterOp     = $d4; // scout
//  kRCX_UnknownOp        = $e4;
//  kRCX_UnknownOp        = $f4;

  kRCX_SetSourceValueOp = $05;
  kRCX_UnlockOp         = $15;
  kRCX_BeginTaskOp      = $25; // (program) not spybot
  kRCX_BeginSubOp	      = $35; // (program) not spybot
  kRCX_DownloadOp       = $45; // (program)
//  kRCX_UnknownOp        = $55;
  kRCX_BootModeOp       = $65; // rcx/rcx2 only
  kRCX_BeginFirmwareOp  = $75; // (program)
  kRCX_SCheckDoOp       = $85; // (program)
  kRCX_LCheckDoOp       = $95; // (program)
  kRCX_UnlockFirmOp     = $a5; // not spybot
  kRCX_LEnterEventChkOp = $b5; // rcx2 & spybot only (program)
//  kRCX_UnknownOp        = $c5;
  kRCX_FindOp           = $d5; // spybot only
  kRCX_ScoutRulesOp     = $d5; // scout
  kRCX_ViewSourceValOp  = $e5; // rcx2 only
//  kRCX_UnknownOp        = $f5;

  kRCX_ClearAllEventsOp = $06; // rcx2 & spybot only
//  kRCX_UnknownOp        = $16;
//  kRCX_UnknownOp        = $26;
  kRCX_ClearRelTableOp  = $36; // spybot (program)
//  kRCX_UnknownOp        = $46;
//  kRCX_UnknownOp        = $56;
//  kRCX_UnknownOp        = $66;
//  kRCX_UnknownOp        = $76;
//  kRCX_UnknownOp        = $86;
//  kRCX_UnknownOp        = $96;
//  kRCX_UnknownOp        = $a6;
//  kRCX_UnknownOp        = $b6;
//  kRCX_UnknownOp        = $c6;
//  kRCX_UnknownOp        = $d6;
//  kRCX_UnknownOp        = $e6;
  kRCX_EndOfSubOp       = $F6; // (program)

//  kRCX_UnknownOp       = $07;
  kRCX_GoSubOp	       = $17; // (program)
  kRCX_SJumpOp	       = $27; // (program)
  kRCX_SChkLoopCtrOp   = $37; // (program) not spybot?
  kRCX_ScoutOp         = $47; // scout only
  kRCX_SoundOp         = $57; // scout only
  kRCX_GOutputModeOp   = $67; // rcx2, scout, & spybot
  kRCX_GOutputDirOp    = $77; // rcx2, scout, & spybot
  kRCX_LightOp         = $87; // scout & spybot
  kRCX_IncCounterOp    = $97; // rcx2, scout, & spybot
  kRCX_DecCounterOp    = $a7; // rcx2, scout, & spybot
  kRCX_ClearCounterOp  = $b7; // rcx2, scout, & spybot
  kRCX_PlaySysMoodOp   = $c7; // spybot only
  kRCX_SetPriorityOp   = $d7; // rcx2, scout, & spybot (program)
  kRCX_PlaySysSndVarOp = $e7; // spybot only
  kRCX_Message         = $f7; // not spybot

  // output mode
  kRCX_OutputFloat = 0;
  kRCX_OutputOff   = $40;
  kRCX_OutputOn    = $80;

  // output direction
  kRCX_OutputBackward = 0;
  kRCX_OutputToggle   = $40;
  kRCX_OutputForward  = $80;

const
  kNXT_VMState_Idle    = 0;
  kNXT_VMState_RunFree = 1;
  kNXT_VMState_Single  = 2;
  kNXT_VMState_Pause   = 3;
  kNXT_VMState_Reset   = 4;

  // NXT constants
  kNXT_NoResponseMask   = $80;
  kNXT_DirectCmd        = $00;
  kNXT_SystemCmd        = $01;
  kNXT_CmdReply         = $02;
  kNXT_DirectCmdNoReply = $80;
  kNXT_SystemCmdNoReply = $81;
  kNXT_MaxBytes         = 64;
  kNXT_NameMaxLen       = 15;
  kEV3_MaxBytes         = 1024;

  // NXT direct commands
  kNXT_DCStartProgram          = $00;
  kNXT_DCStopProgram           = $01;
  kNXT_DCPlaySoundFile         = $02;
  kNXT_DCPlayTone              = $03;
  kNXT_DCSetOutputState        = $04;
  kNXT_DCSetInputMode          = $05;
  kNXT_DCGetOutputState        = $06;
  kNXT_DCGetInputValues        = $07;
  kNXT_DCResetInputScaledValue = $08;
  kNXT_DCMessageWrite          = $09;
  kNXT_DCResetMotorPosition    = $0A;
  kNXT_DCGetBatteryLevel       = $0B;
  kNXT_DCStopSoundPlayback     = $0C;
  kNXT_DCKeepAlive             = $0D;
  kNXT_DCLSGetStatus           = $0E;
  kNXT_DCLSWrite               = $0F;
  kNXT_DCLSRead                = $10;
  kNXT_DCGetCurrentProgramName = $11;
  kNXT_DCGetButtonState        = $12;
  kNXT_DCMessageRead           = $13;
  kNXT_DCReserved1             = $14;
  kNXT_DCReserved2             = $15;
  kNXT_DCReserved3             = $16;
  kNXT_DCReserved4             = $17;
  kNXT_DCReserved5             = $18;
  kNXT_DCDatalogRead           = $19;
  kNXT_DCDatalogSetTimes       = $1a;
  kNXT_DCBTGetContactCount     = $1b;
  kNXT_DCBTGetContactName      = $1c;
  kNXT_DCBTGetConnectionCount  = $1d;
  kNXT_DCBTGetConnectionName   = $1e;
  kNXT_DCSetProperty           = $1f;
  kNXT_DCGetProperty           = $20;
  kNXT_DCUpdateResetCount      = $21;
  kNXT_DCSetVMState            = $22;
  kNXT_DCGetVMState            = $23;
  kNXT_DCSetBreakpoints        = $24;
  kNXT_DCGetBreakpoints        = $25;

  kNXT_Property_BTOnOff        = $0;
  kNXT_Property_SoundLevel     = $1;
  kNXT_Property_SleepTimeout   = $2;
  kNXT_Property_Undefined1     = $3;
  kNXT_Property_Undefined2     = $4;
  kNXT_Property_Undefined3     = $5;
  kNXT_Property_Undefined4     = $6;
  kNXT_Property_Undefined5     = $7;
  kNXT_Property_Undefined6     = $8;
  kNXT_Property_Undefined7     = $9;
  kNXT_Property_Undefined8     = $a;
  kNXT_Property_Undefined9     = $b;
  kNXT_Property_Undefined10    = $c;
  kNXT_Property_Undefined11    = $d;
  kNXT_Property_Undefined12    = $e;
  kNXT_Property_Debugging      = $f;

  // NXT system commands
  kNXT_SCOpenRead              = $80;
  kNXT_SCOpenWrite             = $81;
  kNXT_SCRead                  = $82;
  kNXT_SCWrite                 = $83;
  kNXT_SCClose                 = $84;
  kNXT_SCDelete                = $85;
  kNXT_SCFindFirst             = $86;
  kNXT_SCFindNext              = $87;
  kNXT_SCGetVersions           = $88;
  kNXT_SCOpenWriteLinear       = $89;
  kNXT_SCOpenReadLinear        = $8A;
  kNXT_SCOpenWriteData         = $8B;
  kNXT_SCOpenAppendData        = $8C;
  kNXT_SCUnknown1              = $8D;
  kNXT_SCUnknown2              = $8E;
  kNXT_SCUnknown3              = $8F;
  kNXT_SCFindFirstModule       = $90;
  kNXT_SCFindNextModule        = $91;
  kNXT_SCCloseModuleHandle     = $92;
  kNXT_SCUnknown4              = $93;
  kNXT_SCIOMapRead             = $94;
  kNXT_SCIOMapWrite            = $95;
  kNXT_SCUnknown5              = $96;
  kNXT_SCBootCommand           = $97;
  kNXT_SCSetBrickName          = $98;
  kNXT_SCUnknown6              = $99;
  kNXT_SCGetBTAddress          = $9A;
  kNXT_SCGetDeviceInfo         = $9B;
  kNXT_SCUnknown7              = $9C;
  kNXT_SCUnknown8              = $9D;
  kNXT_SCUnknown9              = $9E;
  kNXT_SCUnknown10             = $9F;
  kNXT_SCDeleteUserFlash       = $A0;
  kNXT_SCPollCommandLen        = $A1;
  kNXT_SCPollCommand           = $A2;
  kNXT_SCRenameFile            = $A3;
  kNXT_SCBTFactoryReset        = $A4;

  // NXT status codes
  kNXT_StatusSuccess           = $00;
  kNXT_StatusNoMoreHandles     = $81;
  kNXT_StatusNoSpace           = $82;
  kNXT_StatusNoMoreFiles       = $83;
  kNXT_StatusEOFExpected       = $84;
  kNXT_StatusEOF               = $85;
  kNXT_StatusNotLinearFile     = $86;
  kNXT_StatusFileNotFound      = $87;
  kNXT_StatusHandleClosed      = $88;
  kNXT_StatusNoLinearSpace     = $89;
  kNXT_StatusUndefinedErr      = $8a;
  kNXT_StatusFileIsBusy        = $8b;
  kNXT_StatusNoWriteBufs       = $8c;
  kNXT_StatusAppendNotPoss     = $8d;
  kNXT_StatusFileIsFull        = $8e;
  kNXT_StatusFileExists        = $8f;
  kNXT_StatusModuleNotFound    = $90;
  kNXT_StatusOutOfBoundary     = $91;
  kNXT_StatusIllegalFilname    = $92;
  kNXT_StatusIllegalHandle     = $93;

const
  NXT_MODULE_COUNT = 12;
  // NXT modules type ID (TT)
  kNXT_TT_Cmd      = $01;
  kNXT_TT_Output   = $02;
  kNXT_TT_Input    = $03;
  kNXT_TT_Button   = $04;
  kNXT_TT_Comm     = $05;
  kNXT_TT_IOCtrl   = $06;
  kNXT_TT_Led      = $07;
  kNXT_TT_Sound    = $08;
  kNXT_TT_Loader   = $09;
  kNXT_TT_Display  = $0A;
  kNXT_TT_LowSpeed = $0B;
  kNXT_TT_UI       = $0C;

  // Module programmer ID (PP)
  kNXT_PidLEGOGroup   = $01;

  // module IDs are
  // PP TT CC FF (MSB..LSB)
  // programmer Id, module ID (above), coarse version, fine version
  // e.g., $01 $03 $01 $14 == TLG, Input, 1.14

  kNXT_ModuleCmd      = $00010001;
  kNXT_ModuleOutput   = $00020001;
  kNXT_ModuleInput    = $00030001;
  kNXT_ModuleButton   = $00040001;
  kNXT_ModuleComm     = $00050001;
  kNXT_ModuleIOCtrl   = $00060001;
  kNXT_ModuleLed      = $00070001;
  kNXT_ModuleSound    = $00080001;
  kNXT_ModuleLoader   = $00090001;
  kNXT_ModuleDisplay  = $000A0001;
  kNXT_ModuleLowSpeed = $000B0001;
  kNXT_ModuleUI       = $000C0001;

const
  NXT_CMD_RESPONSE_LENGTH : array[0..$ff] of byte = (
   3, // DCStartProgram (x00)
   3, // DCStopProgram (x01)
   3, // DCPlaySoundFile (x02)
   3, // DCPlayTone (x03)
   3, // DCSetOutputState (x04)
   3, // DCSetInputMode (x05)
  25, // DCGetOutputState (x06)
  16, // DCGetInputValues (x07)
   3, // DCResetInputScaledValue (x08)
   3, // DCMessageWrite (x09)
   3, // DCResetMotorPosition (x0a)
   5, // DCGetBatteryLevel (x0b)
   3, // DCStopSoundPlayback (x0c)
   7, // DCKeepAlive (x0d)
   4, // DCLSGetStatus (x0e)
   3, // DCLSWrite (x0f)
  20, // DCLSRead (x10)
  23, // DCGetCurrentProgramName (x11)
   0, // DCGetButtonState (not implemented) (x12)
  64, // DCMessageRead (x13)
   0, // DCRESERVED1 (x14)
   0, // DCRESERVED2 (x15)
   0, // DCRESERVED3 (x16)
   0, // DCRESERVED4 (x17)
   0, // DCRESERVED5 (x18)
  64, // DCDatalogRead (1.28+) (x19)
   3, // DCDatalogSetTimes (1.28+) (x1a)
   4, // DCBTGetContactCount (1.28+) (x1b)
  21, // DCBTGetContactName (1.28+) (x1c)
   4, // DCBTGetConnCount (1.28+) (x1d)
  21, // DCBTGetConnName (1.28+) (x1e)
   3, // DCSetProperty(1.28+) (x1f)
   7, // DCGetProperty (1.28+) (x20)
   3, // DCUpdateResetCount (1.28+) (x21)
   7, // RC_SET_VM_STATE (enhanced only) (x22)
   7, // RC_GET_VM_STATE (enhanced only) (x23)
  15, // RC_SET_BREAKPOINTS (enhanced only) (x24)
  15, // RC_GET_BREAKPOINTS (enhanced only) (x25)
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (x26-x2f)
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (x30-x3f)
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (x40-x4f)
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (x50-x5f)
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (x60-x6f)
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (x70-x7f)
   8, //   OPENREAD        = 0x80,
   4, //   OPENWRITE       = 0x81,
  64, //   READ            = 0x82, (actually is a variable length response)
   6, //   WRITE           = 0x83,
   4, //   CLOSE           = 0x84,
  23, //   DELETE          = 0x85,
  28, //   FINDFIRST       = 0x86,
  28, //   FINDNEXT        = 0x87,
   7, //   VERSIONS        = 0x88,
   4, //   OPENWRITELINEAR = 0x89,
   7, //   OPENREADLINEAR  = 0x8A, (not actually implemented)
   4, //   OPENWRITEDATA   = 0x8B,
   8, //   OPENAPPENDDATA  = 0x8C,
   4, //   CROPDATAFILE    = 0x8D,    /* New cmd for datalogging */
   0, //   XXXXXXXXXXXXXX  = 0x8E,
   0, //   XXXXXXXXXXXXXX  = 0x8F,
  34, //   FINDFIRSTMODULE = 0x90,
  34, //   FINDNEXTMODULE  = 0x91,
   4, //   CLOSEMODHANDLE  = 0x92,
   0, //   XXXXXXXXXXXXXX  = 0x93,
  64, //   IOMAPREAD       = 0x94, (actually is a variable length response)
   9, //   IOMAPWRITE      = 0x95,
   0, //   XXXXXXXXXXXXXX  = 0x96,
   7, //   BOOTCMD         = 0x97,  (can only be executed via USB)
   3, //   SETBRICKNAME    = 0x98,
   0, //   XXXXXXXXXXXXXX  = 0x99,
  10, //   BTGETADR        = 0x9A,
  33, //   DEVICEINFO      = 0x9B,
   0, //   XXXXXXXXXXXXXX  = 0x9C,
   0, //   XXXXXXXXXXXXXX  = 0x9D,
   0, //   XXXXXXXXXXXXXX  = 0x9E,
   0, //   XXXXXXXXXXXXXX  = 0x9F,
   3, //   DELETEUSERFLASH = 0xA0,
   5, //   POLLCMDLEN      = 0xA1,
  64, //   POLLCMD         = 0xA2,
  44, //   RENAMEFILE      = 0xA3,
   3, //   BTFACTORYRESET  = 0xA4,
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (xA5-xAF)
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (xB0-xBf)
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (xC0-xCf)
   0, //   RESIZEDATAFILE  = 0xD0,
   0, //   SEEKFROMSTART   = 0xD1,
   0, //   SEEKFROMCURRENT = 0xD2,
   0, //   SEEKFROMEND     = 0xD3
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (xD4-xDF)
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // (xE0-xEF)
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  // (xF0-xFF)
);


const
  kNXT_ModuleCmdName      = 'Command.mod';
  kNXT_ModuleOutputName   = 'Output.mod';
  kNXT_ModuleInputName    = 'Input.mod';
  kNXT_ModuleButtonName   = 'Button.mod';
  kNXT_ModuleCommName     = 'Comm.mod';
  kNXT_ModuleIOCtrlName   = 'IOCtrl.mod';
  kNXT_ModuleLedName      = 'Led.mod';
  kNXT_ModuleSoundName    = 'Sound.mod';
  kNXT_ModuleLoaderName   = 'Loader.mod';
  kNXT_ModuleDisplayName  = 'Display.mod';
  kNXT_ModuleLowSpeedName = 'Low Speed.mod';
  kNXT_ModuleUIName       = 'Ui.mod';

type
  TNXTModule = record
    ID : Cardinal;
    Name : String;
  end;

const
  NXTModuleMap : array[0..NXT_MODULE_COUNT-1] of TNXTModule = (
  (ID: kNXT_ModuleCmd;      Name: kNXT_ModuleCmdName),
  (ID: kNXT_ModuleOutput;   Name: kNXT_ModuleOutputName),
  (ID: kNXT_ModuleInput;    Name: kNXT_ModuleInputName),
  (ID: kNXT_ModuleButton;   Name: kNXT_ModuleButtonName),
  (ID: kNXT_ModuleComm;     Name: kNXT_ModuleCommName),
  (ID: kNXT_ModuleIOCtrl;   Name: kNXT_ModuleIOCtrlName),
  (ID: kNXT_ModuleLed;      Name: kNXT_ModuleLedName),
  (ID: kNXT_ModuleSound;    Name: kNXT_ModuleSoundName),
  (ID: kNXT_ModuleLoader;   Name: kNXT_ModuleLoaderName),
  (ID: kNXT_ModuleDisplay;  Name: kNXT_ModuleDisplayName),
  (ID: kNXT_ModuleLowSpeed; Name: kNXT_ModuleLowSpeedName),
  (ID: kNXT_ModuleUI;       Name: kNXT_ModuleUIName)
  );


type
  // Value type
  TRcxValueType = 0..63;

const
  kRCX_VariableType          = 0;
  kRCX_TimerType             = 1;
  kRCX_ConstantType          = 2;
  kRCX_OutputStatusType      = 3;
  kRCX_RandomType            = 4;
  kRCX_TachCounterType       = 5; // cybermaster only
  kRCX_TachSpeedType         = 6; // cybermaster only
  kRCX_OutputCurrentType     = 7; // cybermaster only
  kRCX_MotorPowerSignedType   = 5; // swan only
  kRCX_IntrinsicIndGlobalType = 6; // swan only
  kRCX_MotorBrakePowerType    = 7; // swan only
  kRCX_ProgramSlotType       = 8; // RCX only
  kRCX_InputValueType        = 9;
  kRCX_InputTypeType         = 10; // not spybot
  kRCX_InputModeType         = 11; // not scout
  kRCX_InputRawType          = 12;
  kRCX_InputBooleanType      = 13; // not spybot, not scout
  kRCX_WatchType             = 14; // RCX only
  kRCX_MessageType           = 15; // spybot = VLL
  // all sources beyond 15 are not present in RCX and Cybermaster
  kRCX_AGCType               = 16; // cybermaster only
  kRCX_MotorPower128Type     = 16; // swan only
  kRCX_GlobalMotorStatusType = 17; // not RCX or CM
  kRCX_ScoutRulesType        = 18; // scout only
  kRCX_ScoutLightParamsType  = 19; // scout only
  kRCX_ScoutTimerLimitType   = 20; // scout only
  kRCX_SpybotStackType       = 18; // spybot only
  kRCX_SpybotTimerCtrlType   = 19; // spybot only
  kRCX_SpybotEepromType      = 20; // spybot only
  kRCX_EventTypeType         = 18; // swan only
  kRCX_EventType             = 19; // swan only
  kRCX_EventCountsType       = 20; // swan only
  kRCX_CounterType           = 21; // RCX2, scout, & spybot only
  kRCX_ScoutCounterLimitType = 22; // scout only
  kRCX_SpybotLEDType         = 22; // spybot only
  kRCX_1MSTimerType          = 22; // swan only
  kRCX_TaskEventsType        = 23; // rcx2, scout, spybot
  kRCX_ScoutEventFBType      = 24; // scout only
  kRCX_SystemType            = 24; // swan only
  kRCX_EventStateType        = 25; // rcx2 & spybot
  kRCX_TenMSTimerType        = 26; // rcx2 & spybot fast timer
  kRCX_ClickCounterType      = 27; // rcx2
  kRCX_UpperThresholdType    = 28; // rcx2 & spybot
  kRCX_LowerThresholdType    = 29; // rcx2 & spybot
  kRCX_HysteresisType        = 30; // rcx2 & spybot
  kRCX_DurationType          = 31; // rcx2 & spybot
  kRCX_SpybotTaskIDType      = 32; // spybot only
  kRCX_MotorPower8Type       = 32; // swan only
  kRCX_UARTSetupType         = 33; // rcx2 & spybot
  kRCX_BatteryLevelType      = 34; // rcx2 & spybot
  kRCX_FirmwareVersionType   = 35; // rcx2 & spybot
  kRCX_IndirectVarType       = 36; // rcx2 & spybot
  kRCX_DatalogTypeIndirectType  = 37;
  kRCX_DatalogTypeDirectType    = 38;
  kRCX_DatalogValueIndirectType = 39;
  kRCX_DatalogValueDirectType   = 40;
  kRCX_DatalogRawIndirectType   = 41;
  kRCX_DatalogRawDirectType     = 42;
  kRCX_SpybotGameNotesType    = 43; // spybot only
  kRCX_SpybotRobotDistType    = 45; // spybot only
  kRCX_SpybotRobotDirType     = 46; // spybot only
  kRCX_SpybotRobotOrientType  = 47; // spybot only
  kRCX_SpybotRobotIDType      = 49; // spybot only
  kRCX_SpybotRobotTargetType  = 50; // spybot only
  kRCX_SpybotPingCtrlType     = 51; // spybot only
  kRCX_SpybotBeaconCtrlType   = 52; // spybot only
  kRCX_SpybotSoundCtrlType    = 53; // spybot only
  kRCX_SpybotIndEepromType    = 54; // spybot only
  kRCX_GlobalVarType          = 43; // swan only
  kRCX_IndirectGlobalIntType  = 44; // swan only
  kRCX_IndexedGlobalConstType	= 47; // swan only
  kRCX_StackVarType           = 49; // swan only
  kRCX_ConstantVarType        = 50; // swan only
  kRCX_FunctionRetValWordType = 51; // swan only
  kRCX_VarByteType            = 54; // swan only
  kRCX_VarWordType            = 55; // swan only
  kRCX_TaskStackVarByteType   = 57; // swan only
  kRCX_TaskStackVarWordType   = 58; // swan only
  kRCX_TaskVarType            = 60; // swan only
  kRCX_TaskStackAddressType   = 61; // swan only
  kRCX_TaskStackSizeType      = 62; // swan only

  kNXT_I2CBaseValueType       = 64; // NXT only
  kNXT_LEGOSonar              = kNXT_I2CBaseValueType + 0;
  kNXT_LEGOTemp               = kNXT_I2CBaseValueType + 1;
  kNXT_LEGOEMeterVIn          = kNXT_I2CBaseValueType + 2;
  kNXT_LEGOEMeterAIn          = kNXT_I2CBaseValueType + 3;
  kNXT_LEGOEMeterVOut         = kNXT_I2CBaseValueType + 4;
  kNXT_LEGOEMeterAOut         = kNXT_I2CBaseValueType + 5;
  kNXT_LEGOEMeterJoules       = kNXT_I2CBaseValueType + 6;
  kNXT_LEGOEMeterWIn          = kNXT_I2CBaseValueType + 7;
  kNXT_LEGOEMeterWOut         = kNXT_I2CBaseValueType + 8;
  kNXT_02Version              = kNXT_I2CBaseValueType + 9;
  kNXT_02Vendor               = kNXT_I2CBaseValueType + 10;
  kNXT_02Device               = kNXT_I2CBaseValueType + 11;

  kNXT_I2CMaxValueType        = 255;


const
//  kRCX_ValueUsesTemp = $1000000;

  // input mode
	kRCX_InputRaw             = 0;
	kRCX_InputBoolean         = $20;
	kRCX_InputEdgeCounter     = $40;
	kRCX_InputPeriodicCounter = $60;
	kRCX_InputPercentage      = $80;
	kRCX_InputCelcius         = $a0;
	kRCX_InputFahrenheit      = $c0;
	kRCX_InputAngle           = $e0;

type
  // input type
  TRcxInputType = (kRCX_InputNone, kRCX_InputSwitch, kRCX_InputTemp,
    kRCX_InputLight, kRCX_InputRotation, kRCX_InputID0, kRCX_InputID1,
    kRCX_InputID2);

  // rcx relation
  TRcxRelation = (kRCX_LessOrEqual, kRCX_GreaterOrEqual, kRCX_NotEqualTo,
    kRCX_EqualTo);

const
  kRCX_OK	             =  0;
  kRCX_OpenSerialError = -1;	// serial port could not be opened and/or configured
  kRCX_IREchoError     = -2;	// no echo received from IR tower
  kRCX_ReplyError      = -3;	// no (or invalid) reply from RCX
  kRCX_RequestError    = -4;	// attempt to send too much data
  kRCX_FileError       = -5;	// could not open/read/write file
  kRCX_FormatError     = -6;	// unknown file format
  kRCX_AbortError      = -7;	// canceled by RCX_Link::DownloadProgress()
  kRCX_MemFullError    = -8;	// not enough room in RCX program memory
  kRCX_PipeModeError   = -9;    // pipe mode error

  kRCX_LastError       = -9;	// last error code
  
implementation

end.