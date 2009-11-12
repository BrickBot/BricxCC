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
unit uNXTConstants;

interface

type
  TDSType = (dsVoid, dsUByte, dsSByte, dsUWord, dsSWord, dsULong, dsSLong,
    dsArray, dsCluster, dsMutex, dsFloat);

const
  MIN_FW_VER1X = 101; // 1.01
  MAX_FW_VER1X = 107; // 1.07
  MIN_FW_VER2X = 120; // 1.20

const
  OPCC1_LT   = $00;
  OPCC1_GT   = $01;
  OPCC1_LTEQ = $02;
  OPCC1_GTEQ = $03;
  OPCC1_EQ   = $04;
  OPCC1_NEQ  = $05;

const
  OPARR_SUM    = $00;
  OPARR_MEAN   = $01;
  OPARR_SUMSQR = $02;
  OPARR_STD    = $03;
  OPARR_MIN    = $04;
  OPARR_MAX    = $05;
  OPARR_SORT   = $06;

const
  OPCODE_COUNT  = $51;
  HEX_FMT = '0x%x';

type
  TOpCode = Byte;

const
  OP_ADD           = $00;
  OP_SUB           = $01;
  OP_NEG           = $02;
  OP_MUL           = $03;
  OP_DIV           = $04;
  OP_MOD           = $05;
  OP_AND           = $06;
  OP_OR            = $07;
  OP_XOR           = $08;
  OP_NOT           = $09;
  OP_CMNT          = $0a;
  OP_LSL           = $0b;
  OP_LSR           = $0c;
  OP_ASL           = $0d;
  OP_ASR           = $0e;
  OP_ROTL          = $0f;
  OP_ROTR          = $10;
  OP_CMP           = $11;
  OP_TST           = $12;
  OP_CMPSET        = $13;
  OP_TSTSET        = $14;
  OP_INDEX         = $15;
  OP_REPLACE       = $16;
  OP_ARRSIZE       = $17;
  OP_ARRBUILD      = $18;
  OP_ARRSUBSET     = $19;
  OP_ARRINIT       = $1a;
  OP_MOV           = $1b;
  OP_SET           = $1c;
  OP_FLATTEN       = $1d;
  OP_UNFLATTEN     = $1e;
  OP_NUMTOSTRING   = $1f;
  OP_STRINGTONUM   = $20;
  OP_STRCAT        = $21;
  OP_STRSUBSET     = $22;
  OP_STRTOBYTEARR  = $23;
  OP_BYTEARRTOSTR  = $24;
  OP_JMP           = $25;
  OP_BRCMP         = $26;
  OP_BRTST         = $27;
  OP_SYSCALL       = $28;
  OP_STOP          = $29;
  OP_FINCLUMP      = $2a;
  OP_FINCLUMPIMMED = $2b;
  OP_ACQUIRE       = $2c;
  OP_RELEASE       = $2d;
  OP_SUBCALL       = $2e;
  OP_SUBRET        = $2f;
  OP_SETIN         = $30;
  OP_SETOUT        = $31;
  OP_GETIN         = $32;
  OP_GETOUT        = $33;
  OP_WAIT          = $34; // standard 1.26+ or enhanced 1.07+
  OP_GETTICK       = $35;

  // enhanced firmware opcodes (1.07)
  OPS_WAITV        = $36;
  OPS_ABS          = $37;
  OPS_SIGN         = $38;
  OPS_STOPCLUMP    = $39;
  OPS_START        = $3a;
  OPS_PRIORITY     = $3b;
  OPS_FMTNUM       = $3c;
  OPS_ARROP        = $3d;
  OPS_ACOS         = $3e;
  OPS_ASIN         = $3f;
  OPS_ATAN         = $40;
  OPS_CEIL         = $41;
  OPS_EXP          = $42;
  OPS_FABS         = $43;
  OPS_FLOOR        = $44;
  OPS_SQRT         = $45;
  OPS_TAN          = $46;
  OPS_TANH         = $47;
  OPS_COS          = $48;
  OPS_COSH         = $49;
  OPS_LOG          = $4a;
  OPS_LOG10        = $4b;
  OPS_SIN          = $4c;
  OPS_SINH         = $4d;
  OPS_ATAN2        = $4e;
  OPS_FMOD         = $4f;
  OPS_POW          = $50;

  // standard firmware opcodes (1.26+)
  OP_SQRT_2        = $36;
  OP_ABS_2         = $37;

  // enhanced firmware opcodes (1.28)
  OPS_WAITI_2      = $64;
  OPS_WAITV_2      = $65;
  OPS_SIGN_2       = $66;
  OPS_STOPCLUMP_2  = $67;
  OPS_START_2      = $68;
  OPS_PRIORITY_2   = $69;
  OPS_FMTNUM_2     = $6a;
  OPS_ARROP_2      = $6b;
  OPS_ACOS_2       = $6c;
  OPS_ASIN_2       = $6d;
  OPS_ATAN_2       = $6e;
  OPS_CEIL_2       = $6f;
  OPS_EXP_2        = $70;
  OPS_FLOOR_2      = $71;
  OPS_TAN_2        = $72;
  OPS_TANH_2       = $73;
  OPS_COS_2        = $74;
  OPS_COSH_2       = $75;
  OPS_LOG_2        = $76;
  OPS_LOG10_2      = $77;
  OPS_SIN_2        = $78;
  OPS_SINH_2       = $79;
  OPS_TRUNC_2      = $7a;
  OPS_FRAC_2       = $7b;
  OPS_ATAN2_2      = $7c;
  OPS_POW_2        = $7d;
  OPS_MULDIV_2     = $7e;

  // transcendental opcodes that use degrees instead of radians
  OPS_ACOSD_2      = $7f;
  OPS_ASIND_2      = $80;
  OPS_ATAND_2      = $81;
  OPS_TAND_2       = $82;
  OPS_TANHD_2      = $83;
  OPS_COSD_2       = $84;
  OPS_COSHD_2      = $85;
  OPS_SIND_2       = $86;
  OPS_SINHD_2      = $87;
  OPS_ATAN2D_2     = $88;

  // pseudo opcodes
  OPS_THREAD       = $90;
  OPS_ENDT         = $91;
  OPS_SUBROUTINE   = $92;
  OPS_REQUIRES     = $93;
  OPS_USES         = $94;
  OPS_SEGMENT      = $95;
  OPS_ENDS         = $96;
  OPS_TYPEDEF      = $97;
  OPS_STRUCT       = $98;
  // var declarations
  OPS_DB           = $99;
  OPS_BYTE         = $9a;
  OPS_SBYTE        = $9b;
  OPS_UBYTE        = $9c;
  OPS_DW           = $9d;
  OPS_WORD         = $9e;
  OPS_SWORD        = $9f;
  OPS_UWORD        = $a0;
  OPS_DD           = $a1;
  OPS_DWORD        = $a2;
  OPS_SDWORD       = $a3;
  OPS_UDWORD       = $a4;
  OPS_LONG         = $a5;
  OPS_SLONG        = $a6;
  OPS_ULONG        = $a7;
  OPS_VOID         = $a8;
  OPS_MUTEX        = $a9;
  OPS_FLOAT        = $aa;
  // pseudo opcodes
  OPS_CALL         = $ab;
  OPS_RETURN       = $ac;
  OPS_STRINDEX     = $ad;
  OPS_STRREPLACE   = $ae;
  OPS_SHL          = $af;
  OPS_SHR          = $b0;
  OPS_STRLEN       = $b1;
  OPS_COMPCHK      = $b2;
  OPS_COMPIF       = $b3;
  OPS_COMPELSE     = $b4;
  OPS_COMPEND      = $b5;
  OPS_COMPCHKTYPE  = $b6;
  OPS_COMMENT      = $b7;
  // invalid opcode
  OPS_INVALID      = $f0;

(*
type
  TOpCode = (
    OP_ADD,
    OP_SUB,
    OP_NEG,
    OP_MUL,
    OP_DIV,
    OP_MOD,
    OP_AND,
    OP_OR,
    OP_XOR,
    OP_NOT,
    OP_CMNT,
    OP_LSL,
    OP_LSR,
    OP_ASL,
    OP_ASR,
    OP_ROTL,
    OP_ROTR,
    OP_CMP,
    OP_TST,
    OP_CMPSET,
    OP_TSTSET,
    OP_INDEX,
    OP_REPLACE,
    OP_ARRSIZE,
    OP_ARRBUILD,
    OP_ARRSUBSET,
    OP_ARRINIT,
    OP_MOV,
    OP_SET,
    OP_FLATTEN,
    OP_UNFLATTEN,
    OP_NUMTOSTRING,
    OP_STRINGTONUM,
    OP_STRCAT,
    OP_STRSUBSET,
    OP_STRTOBYTEARR,
    OP_BYTEARRTOSTR,
    OP_JMP,
    OP_BRCMP,
    OP_BRTST,
    OP_SYSCALL,
    OP_STOP,
    OP_FINCLUMP,
    OP_FINCLUMPIMMED,
    OP_ACQUIRE,
    OP_RELEASE,
    OP_SUBCALL,
    OP_SUBRET,
    OP_SETIN,
    OP_SETOUT,
    OP_GETIN,
    OP_GETOUT,
    OP_WAIT,      // 0x34
    OP_GETTICK,   // 0x35
    OPS_WAITV,
    OPS_ABS,
    OPS_SIGN,
    OPS_STOPCLUMP,
    OPS_START,
    OPS_PRIORITY,
    OPS_FMTNUM,
    OPS_ARROP,
    OPS_ACOS,
    OPS_ASIN,
    OPS_ATAN,
    OPS_CEIL,
    OPS_EXP,
    OPS_FABS,
    OPS_FLOOR,
    OPS_SQRT,
    OPS_TAN,
    OPS_TANH,
    OPS_COS,
    OPS_COSH,
    OPS_LOG,
    OPS_LOG10,
    OPS_SIN,
    OPS_SINH,
    OPS_ATAN2,
    OPS_FMOD,
    OPS_POW,
    OPS_THREAD,
    OPS_ENDT,
    OPS_SUBROUTINE,
    OPS_REQUIRES,
    OPS_USES,
    OPS_SEGMENT,
    OPS_ENDS,
    OPS_TYPEDEF,
    OPS_STRUCT,
    OPS_DB,
    OPS_BYTE,
    OPS_SBYTE,
    OPS_UBYTE,
    OPS_DW,
    OPS_WORD,
    OPS_SWORD,
    OPS_UWORD,
    OPS_DD,
    OPS_DWORD,
    OPS_SDWORD,
    OPS_UDWORD,
    OPS_LONG,
    OPS_SLONG,
    OPS_ULONG,
    OPS_VOID,
    OPS_MUTEX,
    OPS_FLOAT,
    OPS_CALL,
    OPS_RETURN,
    OPS_STRINDEX,
    OPS_STRREPLACE,
    OPS_SHL,
    OPS_SHR,
    OPS_STRLEN,
    OPS_COMPCHK,
    OPS_COMPIF,
    OPS_COMPELSE,
    OPS_COMPEND,
    OPS_COMPCHKTYPE,
    OPS_COMMENT,
    OPS_INVALID
  );
*)


const
  FILENAME_LENGTH        = 19;    // zero termination not included
  FILEHEADER_LENGTH      = 8;     // all simple file headers
  DISPLAYLINE_LENGTH     = 16;    // zero termination not included
  ON_BRICK_PROGRAMSTEPS  = 5;     // no of on brick program steps
  STATUSTEXT_SIZE        = 8;     // zero termination not included

function INC_ID(X : Word) : Word;

const
  DATA_ARG_ADDR_MASK = $3FFF;
  DATA_ARG_IMM_MASK  = $7FFF;
  MOD_INPUT          = 0;
  MOD_OUTPUT         = 1;
  NO_OF_INPUTS       = 4;
  IO_IN_FPP          = 6;
  IO_IN_FIELD_COUNT  = IO_IN_FPP * NO_OF_INPUTS;
  NO_OF_OUTPUTS      = 3;
  IO_OUT_FPP         = 15;
  IO_OUT_FIELD_COUNT = IO_OUT_FPP * NO_OF_OUTPUTS;
  NO_OF_BTNS         = 4;

// flags passed into the UpdateFlags field of RCXOutput/RCXOutputMulti
const
  UF_UPDATE_MODE                 = $01;
  UF_UPDATE_SPEED                = $02;
  UF_UPDATE_TACHO_LIMIT          = $04;
  UF_UPDATE_RESET_COUNT          = $08;
  UF_UPDATE_PID_VALUES           = $10;
  UF_UPDATE_RESET_BLOCK_COUNT    = $20;
  UF_UPDATE_RESET_ROTATION_COUNT = $40;
  UF_PENDING_UPDATES             = $80;

// flags passed into the Mode field of RCXOutput/RCXOutputMulti
const
  OUT_MODE_COAST     = $00;
  OUT_MODE_MOTORON   = $01;
  OUT_MODE_BRAKE     = $02;
  OUT_MODE_REGULATED = $04;
  OUT_MODE_REGMETHOD = $f0;
  // may be more ???

const
  OUT_RUNSTATE_IDLE     = $00;
  OUT_RUNSTATE_RAMPUP   = $10;
  OUT_RUNSTATE_RUNNING  = $20;
  OUT_RUNSTATE_RAMPDOWN = $40;

const
  OUT_REGMODE_IDLE  = 0;
  OUT_REGMODE_SPEED = 1;
  OUT_REGMODE_SYNC  = 2;

// values passed into the Type field of the RCXInput
const
  IN_TYPE_NO_SENSOR      = $0;
  IN_TYPE_SWITCH         = $1;
  IN_TYPE_TEMPERATURE    = $2;
  IN_TYPE_REFLECTION     = $3;
  IN_TYPE_ANGLE          = $4;
  IN_TYPE_LIGHT_ACTIVE   = $5;
  IN_TYPE_LIGHT_INACTIVE = $6;
  IN_TYPE_SOUND_DB       = $7;
  IN_TYPE_SOUND_DBA      = $8;
  IN_TYPE_CUSTOM         = $9;
  IN_TYPE_LOWSPEED       = $A;
  IN_TYPE_LOWSPEED_9V    = $B;
  IN_TYPE_HISPEED        = $C;
  IN_TYPE_COLORFULL      = $D;
  IN_TYPE_COLORRED       = $E;
  IN_TYPE_COLORGREEN     = $F;
  IN_TYPE_COLORBLUE      = $10;
  IN_TYPE_COLORNONE      = $11;

// flags passed into the Mode field of the RCXInput
const
  IN_MODE_RAW           = $00;
  IN_MODE_BOOLEAN       = $20;
  IN_MODE_TRANSITIONCNT = $40;
  IN_MODE_PERIODCOUNTER = $60;
  IN_MODE_PCTFULLSCALE  = $80;
  IN_MODE_CELSIUS       = $A0;
  IN_MODE_FAHRENHEIT    = $C0;
  IN_MODE_ANGLESTEP     = $E0;
  IN_MODE_SLOPEMASK     = $1F;
  IN_MODE_MODEMASK      = $E0;

const
  UpdateFlags     = 0;
  OutputMode      = 1;
  Power           = 2;
  ActualSpeed     = 3;
  TachoCount      = 4;
  TachoLimit      = 5;
  RunState        = 6;
  TurnRatio       = 7;
  RegMode         = 8;
  Overloaded      = 9;
  RegPValue       = 10;
  RegIValue       = 11;
  RegDValue       = 12;
  BlockTachoCount = 13;
  RotationCount   = 14;

const
  InputType       = 0;
  InputMode       = 1;
  RawValue        = 2;
  NormalizedValue = 3;
  ScaledValue     = 4;
  InvalidData     = 5;


// IOMap Constants
const
  STAT_MSG_EMPTY_MAILBOX = 64; //Specified mailbox contains no new messages
  STAT_COMM_PENDING      = 32; //Pending setup operation in progress

const
  STOP_REQ      = 5;
  BREAKOUT_REQ  = 4;
  PC_OVERRIDE   = 3;
  CLUMP_SUSPEND = 2;
  CLUMP_DONE    = 1;
  NO_ERR        = 0;

const
//Fatal errors
  ERR_ARG      = ShortInt($FF); //0xFF Bad arguments;
  ERR_INSTR    = ShortInt($FE); //0xFE Illegal bytecode instruction;
  ERR_FILE     = ShortInt($FD); //0xFD Mal-formed file contents;
  ERR_VER      = ShortInt($FC); //0xFC Version mismatch between firmware and compiler;
  ERR_MEM      = ShortInt($FB); //0xFB Insufficient memory available;
  ERR_BAD_PTR  = ShortInt($FA); //0xFA Someone passed us a bad pointer!;
//General errors
  ERR_INVALID_PORT   = ShortInt($F0); // Bad input or output port specified
  ERR_INVALID_FIELD  = ShortInt($EF); // Attempted to access invalid field of a structure
  ERR_INVALID_QUEUE  = ShortInt($EE); // Illegal queue ID specified
  ERR_INVALID_SIZE   = ShortInt($ED); // Illegal size specified
  ERR_NO_PROG        = ShortInt($EC); // No active program
//Communications specific errors
  ERR_COMM_CHAN_NOT_READY = ShortInt($E0); // Specified channel/connection not configured or busy
  ERR_COMM_CHAN_INVALID   = ShortInt($DF); // Specified channel/connection is not valid
  ERR_COMM_BUFFER_FULL    = ShortInt($DE); // No room in comm buffer
  ERR_COMM_BUS_ERR        = ShortInt($DD); // Something went wrong on the communications bus
//Remote control ("direct commands") errors
  ERR_RC_ILLEGAL_VAL = ShortInt($C0); // Data contains out-of-range values
  ERR_RC_BAD_PACKET  = ShortInt($BF); // Clearly insane packet
  ERR_RC_UNKNOWN_CMD = ShortInt($BE); // Unknown command opcode
  ERR_RC_FAILED      = ShortInt($BD); // Request failed (i.e. specified file not found)

function IS_ERR(Status : Integer) : boolean;
function IS_FATAL(Status : Integer) : boolean;

const
  RC_START_PROGRAM    = 0;
  RC_STOP_PROGRAM     = 1;
  RC_PLAY_SOUND_FILE  = 2;
  RC_PLAY_TONE        = 3;
  RC_SET_OUT_STATE    = 4;
  RC_SET_IN_MODE      = 5;
  RC_GET_OUT_STATE    = 6;
  RC_GET_IN_VALS      = 7;
  RC_RESET_IN_VAL     = 8;
  RC_MESSAGE_WRITE    = 9;
  RC_RESET_POSITION   = 10;
  RC_GET_BATT_LVL     = 11;
  RC_STOP_SOUND       = 12;
  RC_KEEP_ALIVE       = 13;
  RC_LS_GET_STATUS    = 14;
  RC_LS_WRITE         = 15;
  RC_LS_READ          = 16;
  RC_GET_CURR_PROGRAM = 17;
  RC_GET_BUTTON_STATE = 18;
  RC_MESSAGE_READ     = 19;
  NUM_RC_OPCODES      = 20;

const
// ProgStatus
  PROG_IDLE     = 0;
  PROG_OK       = 1; //PROG_OK: Last program finished normally.
  PROG_RUNNING  = 2; //PROG_RUNNING: Program currently running
  PROG_ERROR    = 3; //PROG_ERROR: Last program ended because of an error
  PROG_ABORT    = 4; //PROG_ABORT: Last program ended because of (user) abort
  PROG_RESET    = 5;

const
  POOL_MAX_SIZE  = 32768; //Maximum size of memory pool, in bytes

const
  VM_FORMAT_STRING             = 'MindstormsNXT';
  VM_FORMAT_STRING_SIZE        = 16;
  VM_OLDEST_COMPATIBLE_VERSION = $0004;
  FIRMWARE_VERSION             = $0;

const
  NOT_A_HANDLE   = $FF;
  NOT_A_CLUMP    = $FF;
  NOT_AN_ELEMENT = $FFFF;
  NOT_A_DS_ID    = $FFFF;
  NOT_AN_OFFSET  = $FFFF;
  MAX_CLUMPS     = 255;

const
  DV_ARRAY_GROWTH_COUNT = 5;
  DS_DEFAULT_DEFAULT    = 1;

const
// VM_STATE
  VM_IDLE        = 0; //VM_IDLE: Just sitting around.  Request to run program will lead to ONE of the VM_RUN* states.
  VM_RUN_FREE    = 1; //VM_RUN_FREE: Attempt to run as many instructions as possible within our timeslice
  VM_RUN_SINGLE  = 2; //VM_RUN_SINGLE: Run exactly one instruction per timeslice
  VM_RUN_PAUSE   = 3; //VM_RUN_PAUSE: Program still "active", but someone has asked us to pause
  VM_RESET1      = 4; //VM_RESET2: Final clean up and return to IDLE
  VM_RESET2      = 5; //VM_RESET1: Initialize state variables and some I/O devices -- executed when programs end

const
  SUCCESS             = $0000;
  INPROGRESS          = $0001;
  REQPIN              = $0002;
  NOMOREHANDLES       = $8100;
  NOSPACE             = $8200;
  NOMOREFILES         = $8300;
  EOFEXSPECTED        = $8400;
  ENDOFFILE           = $8500;
  NOTLINEARFILE       = $8600;
  FILENOTFOUND        = $8700;
  HANDLEALREADYCLOSED = $8800;
  NOLINEARSPACE       = $8900;
  UNDEFINEDERROR      = $8A00;
  FILEISBUSY          = $8B00;
  NOWRITEBUFFERS      = $8C00;
  APPENDNOTPOSSIBLE   = $8D00;
  FILEISFULL          = $8E00;
  FILE_EXISTS         = $8F00;
  MODULENOTFOUND      = $9000;
  OUTOFBOUNDERY       = $9100;
  ILLEGALFILENAME     = $9200;
  ILLEGALHANDLE       = $9300;
  BTBUSY              = $9400;
  BTCONNECTFAIL       = $9500;
  BTTIMEOUT           = $9600;
  FILETX_TIMEOUT      = $9700;
  FILETX_DSTEXISTS    = $9800;
  FILETX_SRCMISSING   = $9900;
  FILETX_STREAMERROR  = $9A00;
  FILETX_CLOSEERROR   = $9B00;

const
  MESSAGES_PER_QUEUE   = 5;
  MESSAGE_QUEUE_COUNT  = 20;
  INCOMING_QUEUE_COUNT = MESSAGE_QUEUE_COUNT div 2;
  NOT_A_QUEUE          = $FF;
  MAX_MESSAGE_SIZE     = 59;


// IOMAP Offsets
const
  CommandOffsetFormatString   = 0;
  CommandOffsetPRCHandler     = $10;
  CommandOffsetTick           = $14;
  CommandOffsetOffsetDS       = $18;
  CommandOffsetOffsetDVA      = $1A;
  CommandOffsetProgStatus     = $1C;
  CommandOffsetAwake          = $1D;
  CommandOffsetActivateFlag   = $1E;
  CommandOffsetDeactivateFlag = $1F;
  CommandOffsetFileName       = $20;
  CommandOffsetMemoryPool     = $34; // 32768 bytes

(*
varsCmd information
  pCodespace: pointer for flat codespace (stored in flash, includes all clumps)
  CodespaceCount: count of code words
  pAllClumps: Pointer to list of CLUMP_RECs
  AllClumpsCount: Count of CLUMP_RECs in list
  RunQ: Head and tail of run queue (elements in-place in AllClumps list)
  ScratchPC: Temp PC value for control flow instructions
  pDataspaceTOC: Pointer to DSTOC entries (stored in flash)
  DataspaceCount: Count of entries in DSTOC
  pDataspace: Base pointer of actual dataspace
  DataspaceSize: Size, in bytes, of dataspace
  DSStaticSize: Size, in bytes, of static portion of the dataspace (used as an offset to the dynamic dataspace)
  VMState: Internal state of VM's loader/scheduler (cCmdCtrl())
  MemMgr: Contains data to manage dynamic arrays
  PoolSize: Current size of main memory pool, in bytes.
  Pool: Static pool of bytes for stashing all program run-time data
  ActiveProgHandle: Handle of the program that is currently running

NOTES ON THE ABOVE STRUCTURES
  The main memory pool is used for all clump records, dataspace tracking data,
  and the dataspace itself.  In other words, pAllClumps and
  pDataspace must all point to memory within the pool.  Watch for RCX_ASSERTs
  to enforce safe indexing into the pool.

*)

const
  ClumpRecOffsetCodeStart      = $00; // 2 bytes
  ClumpRecOffsetCodeEnd        = $02; // 2 bytes
  ClumpRecOffsetPC             = $04; // 2 bytes
  ClumpRecOffsetInitFireCount  = $06; // 1 byte
  ClumpRecOffsetCurrFireCount  = $07; // 1 byte
  ClumpRecOffsetLink           = $08; // 1 byte
  ClumpRecOffsetPriority       = $09; // 1 byte
  ClumpRecOffsetPadBytes       = $0A; // 2 bytes
  ClumpRecOffsetPDependents    = $0C; // 4 bytes (UBYTE*)
  ClumpRecOffsetDependentCount = $10; // 1 byte
  ClumpRecOffsetPadBytes2      = $11; // 3 bytes
  ClumpRecSize                 =  20; // total size = 20 bytes ($14)

const
  DSTOCEntryOffsetTypeCode = 0; // 1 byte
  DSTOCEntryOffsetFlags    = 1; // 1 byte
  DSTOCEntryOffsetDSOffset = 2; // 2 bytes
  DSTOCEntrySize           = 4;

const
  DopeVectorOffsetOffset   = 0; // 2 bytes
  DopeVectorOffsetElemSize = 2; // 2 bytes
  DopeVectorOffsetCount    = 4; // 2 bytes
  DopeVectorOffsetBackPtr  = 6; // 2 bytes
  DopeVectorOffsetLink     = 8; // 2 bytes
  DopeVectorSize           = 10;

const
  MemMgrOffsetHead             = 0; // 2 bytes
  MemMgrOffsetTail             = 2; // 2 bytes
  MemMgrOffsetFreeHead         = 4; // 2 bytes
  MemMgrOffsetPDopeVectorArray = 6; // 4 bytes (DOPE_VECTOR*)
  MemMgrSize                   = 10;

const
  ClumpQueueOffsetHead = 0; // 1 byte
  ClumpQueueOffsetTail = 1; // 1 byte
  ClumpQueueSize       = 2;

const
  MessageQueueOffsetReadIndex  = 0; // 2 bytes
  MessageQueueOffsetWriteIndex = 2; // 2 bytes
  MessageQueueOffsetMessages   = 4; // 10 bytes (UWORD[5])
  MessageQueueSize             = 14;

const
  VarsCmdOffsetBase             = $8034; // varsCmd record lives just past the end of the IOMapCmd record (above)
  VarsCmdOffsetPCodespace       = $8034; // 4 bytes (SWORD*)
  VarsCmdOffsetPAllClumps       = $8038; // 4 bytes (CLUMP_REC*) (see above for ClumpRec offsets)
  VarsCmdOffsetPDataspaceTOC    = $803C; // 4 bytes (DS_TOC_ENTRY*) (see above for DSTOCEntry offsets)
  VarsCmdOffsetPDataspace       = $8040; // 4 bytes (UBYTE *)
  VarsCmdOffsetPool             = $8044; // 4 bytes (UBYTE *)
  VarsCmdOffsetPoolSize         = $8048; // 4 bytes (ULONG)
  VarsCmdOffsetCodespaceCount   = $804C; // 2 bytes (UWORD)
  VarsCmdOffsetAllClumpsCount   = $804E; // 1 byte (UBYTE)
  VarsCmdOffsetDataspaceCount   = $804F; // 2 byte (UWORD)
  VarsCmdOffsetDataspaceSize    = $8051; // 2 byte (UWORD)
  VarsCmdOffsetDSStaticSize     = $8053; // 2 byte (UWORD)
  VarsCmdOffsetVMState          = $8055; // 1 byte ????? (VM_STATE enum)
  VarsCmdOffsetMemMgr           = $8056; // 10 bytes (MEM_MGR struct)
  VarsCmdOffsetMemMgrHead       = VarsCmdOffsetMemMgr + 0; // 2 bytes
  VarsCmdOffsetMemMgrTail       = VarsCmdOffsetMemMgr + 2; // 2 bytes
  VarsCmdOffsetMemMgrFreeHead   = VarsCmdOffsetMemMgr + 4; // 2 bytes
  VarsCmdOffsetMemMgrPDopeVectorArray = VarsCmdOffsetMemMgr + 6; // 4 bytes (DOPE_VECTOR*)
  VarsCmdOffsetRunQ             = $8060; // 2 bytes (CLUMP_Q)
  VarsCmdOffsetRunQHead         = VarsCmdOffsetRunQ + 0; // 1 byte (CLUMP_Q.Head)
  VarsCmdOffsetRunQTail         = VarsCmdOffsetRunQ + 1; // 1 byte (CLUMP_Q.Tail)
  VarsCmdOffsetScratchPC        = $8062; // 2 bytes (UWORD)
  VarsCmdOffsetCallerClump      = $8064; // 1 byte (UBYTE)
  VarsCmdOffsetActiveProgHandle = $8065; // 1 byte (UBYTE)
  VarsCmdOffsetActiveProgName   = $8066; // 20 bytes (filename)
  VarsCmdOffsetFileHandleTable  = $807A; // 336 bytes
  VarsCmdOffsetMessageQueues    = $81CA; // 280 bytes
  VarsCmdOffsetCommStat         = $82E2; // 2 bytes
  VarsCmdOffsetCommStatReset    = $82E4; // 2 bytes
  VarsCmdOffsetCommCurrConn     = $82E6; // 1 byte
  VarsCmdOffsetDirtyComm        = $82E7; // 1 byte
  VarsCmdOffsetDirtyDisplay     = $82E8; // 1 byte
  VarsCmdOffsetStartTick        = $82E9; // 4 bytes
  // ifdef VM_BENCHMARK
  VarsCmdOffsetInstrCount         = $82ED; // 4 bytes
  VarsCmdOffsetAverage            = $82F1; // 4 bytes
  VarsCmdOffsetOverTimeCount      = $82F5; // 4 bytes
  VarsCmdOffsetMaxOverTimeLength  = $82F9; // 4 bytes
  VarsCmdOffsetCmdCtrlCount       = $82FD; // 4 bytes
  VarsCmdOffsetCompactionCount    = $8301; // 4 bytes
  VarsCmdOffsetLastCompactionTick = $8305; // 4 bytes
  VarsCmdOffsetMaxCompactionTime  = $8309; // 4 bytes
  VarsCmdOffsetOpcodeBenchmarks   = $830D; // 864 bytes
  VarCmdOffsetSyscallBenchmarks   = $866D; // 544 bytes
  VarCmdOffsetBuffer              = $888D; // 256 bytes;
  // ifdef ARM_DEBUG
  VarCmdOffsetAssertFlag          = $898D; // 1 byte
  VarCmdOffsetAssertLine          = $898E; // 4 bytes

function VarCmdOffsetFHT(const i : byte) : word;
function VarCmdOffsetFHTHandle(const i : byte) : word;
function VarCmdOffsetFHTFilename(const i : byte) : word;

function VarCmdOffsetMessageQueue(const queue : byte) : word;
function VarCmdOffsetMessageQueueReadIndex(const queue : byte) : word;
function VarCmdOffsetMessageQueueWriteIndex(const queue : byte) : word;
function VarCmdOffsetMessageQueueMessage(const queue, msg : byte) : word;

//  VarsCmdOffsetOpcodeBenchmarks[54][4];
//  VarsCmdOffsetSyscallBenchmarks[34][4];


const
  IOCtrlOffsetPowerOn       = 0;

const
  LoaderOffsetPFunc         = 0;
  LoaderOffsetFreeUserFlash = 4;

const // error codes
  LDR_SUCCESS             = $0000;
  LDR_INPROGRESS          = $0001;
  LDR_REQPIN              = $0002;
  LDR_NOMOREHANDLES       = $8100;
  LDR_NOSPACE             = $8200;
  LDR_NOMOREFILES         = $8300;
  LDR_EOFEXSPECTED        = $8400;
  LDR_ENDOFFILE           = $8500;
  LDR_NOTLINEARFILE       = $8600;
  LDR_FILENOTFOUND        = $8700;
  LDR_HANDLEALREADYCLOSED = $8800;
  LDR_NOLINEARSPACE       = $8900;
  LDR_UNDEFINEDERROR      = $8A00;
  LDR_FILEISBUSY          = $8B00;
  LDR_NOWRITEBUFFERS      = $8C00;
  LDR_APPENDNOTPOSSIBLE   = $8D00;
  LDR_FILEISFULL          = $8E00;
  LDR_FILEEXISTS          = $8F00;
  LDR_MODULENOTFOUND      = $9000;
  LDR_OUTOFBOUNDERY       = $9100;
  LDR_ILLEGALFILENAME     = $9200;
  LDR_ILLEGALHANDLE       = $9300;
  LDR_BTBUSY              = $9400;
  LDR_BTCONNECTFAIL       = $9500;
  LDR_BTTIMEOUT           = $9600;
  LDR_FILETX_TIMEOUT      = $9700;
  LDR_FILETX_DSTEXISTS    = $9800;
  LDR_FILETX_SRCMISSING   = $9900;
  LDR_FILETX_STREAMERROR  = $9A00;
  LDR_FILETX_CLOSEERROR   = $9B00;

const
  SoundOffsetFreq           = 0;
  SoundOffsetDuration       = 2;
  SoundOffsetSampleRate     = 4;
  SoundOffsetSoundFilename  = 6;
  SoundOffsetFlags         = 26;
  SoundOffsetState         = 27;
  SoundOffsetMode          = 28;
  SoundOffsetVolume        = 29;

const
  ButtonOffsetPressedCnt0   = 0;
  ButtonOffsetLongPressCnt0 = 1;
  ButtonOffsetShortRelCnt0  = 2;
  ButtonOffsetLongRelCnt0   = 3;
  ButtonOffsetRelCnt0       = 4;
  ButtonOffsetPressedCnt1   = 8;
  ButtonOffsetLongPressCnt1 = 9;
  ButtonOffsetShortRelCnt1  = 10;
  ButtonOffsetLongRelCnt1   = 11;
  ButtonOffsetRelCnt1       = 12;
  ButtonOffsetPressedCnt2   = 16;
  ButtonOffsetLongPressCnt2 = 17;
  ButtonOffsetShortRelCnt2  = 18;
  ButtonOffsetLongRelCnt2   = 19;
  ButtonOffsetRelCnt2       = 20;
  ButtonOffsetPressedCnt3   = 24;
  ButtonOffsetLongPressCnt3 = 25;
  ButtonOffsetShortRelCnt3  = 26;
  ButtonOffsetLongRelCnt3   = 27;
  ButtonOffsetRelCnt3       = 28;
  ButtonOffsetState0        = 32;
  ButtonOffsetState1        = 33;
  ButtonOffsetState2        = 34;
  ButtonOffsetState3        = 35;

const
  PRESSED_EV         = $01;
  SHORT_RELEASED_EV  = $02;
  LONG_PRESSED_EV    = $04;
  LONG_RELEASED_EV   = $08;
  PRESSED_STATE      = $80;

const
  UIOffsetPMenu           = 0;
  UIOffsetBatteryVoltage  = 4;
  UIOffsetLMSfilename     = 6;
  UIOffsetFlags           = 26;
  UIOffsetState           = 27;
  UIOffsetButton          = 28;
  UIOffsetRunState        = 29;
  UIOffsetBatteryState    = 30;
  UIOffsetBluetoothState  = 31;
  UIOffsetUsbState        = 32;
  UIOffsetSleepTimeout    = 33;
  UIOffsetSleepTimer      = 34;
  UIOffsetRechargeable    = 35;
  UIOffsetVolume          = 36;
  UIOffsetError           = 37;
  UIOffsetOBPPointer      = 38;
  UIOffsetForceOff        = 39;

const
  InputOffsetCustomZeroOffset0   = 0;
  InputOffsetADRaw0              = 2;
  InputOffsetSensorRaw0          = 4;
  InputOffsetSensorValue0        = 6;
  InputOffsetSensorType0         = 8;
  InputOffsetSensorMode0         = 9;
  InputOffsetSensorBoolean0      = 10;
  InputOffsetDigiPinsDir0        = 11;
  InputOffsetDigiPinsIn0         = 12;
  InputOffsetDigiPinsOut0        = 13;
  InputOffsetCustomPctFullScale0 = 14;
  InputOffsetCustomActiveStatus0 = 15;
  InputOffsetInvalidData0        = 16;
  InputOffsetSpare10             = 17;
  InputOffsetSpare20             = 18;
  InputOffsetSpare30             = 19;
  InputOffsetCustomZeroOffset1   = 20;
  InputOffsetADRaw1              = 22;
  InputOffsetSensorRaw1          = 24;
  InputOffsetSensorValue1        = 26;
  InputOffsetSensorType1         = 28;
  InputOffsetSensorMode1         = 29;
  InputOffsetSensorBoolean1      = 30;
  InputOffsetDigiPinsDir1        = 31;
  InputOffsetDigiPinsIn1         = 32;
  InputOffsetDigiPinsOut1        = 33;
  InputOffsetCustomPctFullScale1 = 34;
  InputOffsetCustomActiveStatus1 = 35;
  InputOffsetInvalidData1        = 36;
  InputOffsetSpare11             = 37;
  InputOffsetSpare21             = 38;
  InputOffsetSpare31             = 39;
  InputOffsetCustomZeroOffset2   = 40;
  InputOffsetADRaw2              = 42;
  InputOffsetSensorRaw2          = 44;
  InputOffsetSensorValue2        = 46;
  InputOffsetSensorType2         = 48;
  InputOffsetSensorMode2         = 49;
  InputOffsetSensorBoolean2      = 50;
  InputOffsetDigiPinsDir2        = 51;
  InputOffsetDigiPinsIn2         = 52;
  InputOffsetDigiPinsOut2        = 53;
  InputOffsetCustomPctFullScale2 = 54;
  InputOffsetCustomActiveStatus2 = 55;
  InputOffsetInvalidData2        = 56;
  InputOffsetSpare12             = 57;
  InputOffsetSpare22             = 58;
  InputOffsetSpare32             = 59;
  InputOffsetCustomZeroOffset3   = 60;
  InputOffsetADRaw3              = 63;
  InputOffsetSensorRaw3          = 64;
  InputOffsetSensorValue3        = 66;
  InputOffsetSensorType3         = 68;
  InputOffsetSensorMode3         = 69;
  InputOffsetSensorBoolean3      = 70;
  InputOffsetDigiPinsDir3        = 71;
  InputOffsetDigiPinsIn3         = 72;
  InputOffsetDigiPinsOut3        = 73;
  InputOffsetCustomPctFullScale3 = 74;
  InputOffsetCustomActiveStatus3 = 75;
  InputOffsetInvalidData3        = 76;
  InputOffsetSpare13             = 77;
  InputOffsetSpare23             = 78;
  InputOffsetSpare33             = 79;

const
  OutputOffsetTachoCnt0          = 0;
  OutputOffsetBlockTachoCount0   = 4;
  OutputOffsetRotationCount0     = 8;
  OutputOffsetTachoLimit0        = 12;
  OutputOffsetMotorRPM0          = 16;
  OutputOffsetFlags0             = 18;
  OutputOffsetMode0              = 19;
  OutputOffsetSpeed0             = 20;
  OutputOffsetActualSpeed0       = 21;
  OutputOffsetRegPParameter0     = 22;
  OutputOffsetRegIParameter0     = 23;
  OutputOffsetRegDParameter0     = 24;
  OutputOffsetRunState0          = 25;
  OutputOffsetRegMode0           = 26;
  OutputOffsetOverloaded0        = 27;
  OutputOffsetSyncTurnParameter0 = 28;
  OutputOffsetSpareOne0          = 29;
  OutputOffsetSpareTwo0          = 30;
  OutputOffsetSpareThree0        = 31;
  OutputOffsetTachoCnt1          = 32;
  OutputOffsetBlockTachoCount1   = 36;
  OutputOffsetRotationCount1     = 40;
  OutputOffsetTachoLimit1        = 44;
  OutputOffsetMotorRPM1          = 48;
  OutputOffsetFlags1             = 50;
  OutputOffsetMode1              = 51;
  OutputOffsetSpeed1             = 52;
  OutputOffsetActualSpeed1       = 53;
  OutputOffsetRegPParameter1     = 54;
  OutputOffsetRegIParameter1     = 55;
  OutputOffsetRegDParameter1     = 56;
  OutputOffsetRunState1          = 57;
  OutputOffsetRegMode1           = 58;
  OutputOffsetOverloaded1        = 59;
  OutputOffsetSyncTurnParameter1 = 60;
  OutputOffsetSpareOne1          = 61;
  OutputOffsetSpareTwo1          = 62;
  OutputOffsetSpareThree1        = 63;
  OutputOffsetTachoCnt2          = 64;
  OutputOffsetBlockTachoCount2   = 68;
  OutputOffsetRotationCount2     = 72;
  OutputOffsetTachoLimit2        = 76;
  OutputOffsetMotorRPM2          = 80;
  OutputOffsetFlags2             = 82;
  OutputOffsetMode2              = 83;
  OutputOffsetSpeed2             = 84;
  OutputOffsetActualSpeed2       = 85;
  OutputOffsetRegPParameter2     = 86;
  OutputOffsetRegIParameter2     = 87;
  OutputOffsetRegDParameter2     = 88;
  OutputOffsetRunState2          = 89;
  OutputOffsetRegMode2           = 90;
  OutputOffsetOverloaded2        = 91;
  OutputOffsetSyncTurnParameter2 = 92;
  OutputOffsetSpareOne2          = 93;
  OutputOffsetSpareTwo2          = 94;
  OutputOffsetSpareThree2        = 95;
  OutputOffsetPwnFreq            = 96;

const
  LowSpeedOffsetInBufBuf0        = 0;
  LowSpeedOffsetInBufInPtr0      = 16;
  LowSpeedOffsetInBufOutPtr0     = 17;
  LowSpeedOffsetInBufBytesToRx0  = 18;
  LowSpeedOffsetInBufBuf1        = 19;
  LowSpeedOffsetInBufInPtr1      = 35;
  LowSpeedOffsetInBufOutPtr1     = 36;
  LowSpeedOffsetInBufBytesToRx1  = 37;
  LowSpeedOffsetInBufBuf2        = 38;
  LowSpeedOffsetInBufInPtr2      = 54;
  LowSpeedOffsetInBufOutPtr2     = 55;
  LowSpeedOffsetInBufBytesToRx2  = 56;
  LowSpeedOffsetInBufBuf3        = 57;
  LowSpeedOffsetInBufInPtr3      = 73;
  LowSpeedOffsetInBufOutPtr3     = 74;
  LowSpeedOffsetInBufBytesToRx3  = 75;
  LowSpeedOffsetOutBufBuf0       = 76;
  LowSpeedOffsetOutBufInPtr0     = 92;
  LowSpeedOffsetOutBufOutPtr0    = 93;
  LowSpeedOffsetOutBufBytesToRx0 = 94;
  LowSpeedOffsetOutBufBuf1       = 95;
  LowSpeedOffsetOutBufInPtr1     = 111;
  LowSpeedOffsetOutBufOutPtr1    = 112;
  LowSpeedOffsetOutBufBytesToRx1 = 113;
  LowSpeedOffsetOutBufBuf2       = 114;
  LowSpeedOffsetOutBufInPtr2     = 130;
  LowSpeedOffsetOutBufOutPtr2    = 131;
  LowSpeedOffsetOutBufBytesToRx2 = 132;
  LowSpeedOffsetOutBufBuf3       = 133;
  LowSpeedOffsetOutBufInPtr3     = 149;
  LowSpeedOffsetOutBufOutPtr3    = 150;
  LowSpeedOffsetOutBufBytesToRx3 = 151;
  LowSpeedOffsetMode0            = 152;
  LowSpeedOffsetMode1            = 153;
  LowSpeedOffsetMode2            = 154;
  LowSpeedOffsetMode3            = 155;
  LowSpeedOffsetChannelState0    = 156;
  LowSpeedOffsetChannelState1    = 157;
  LowSpeedOffsetChannelState2    = 158;
  LowSpeedOffsetChannelState3    = 159;
  LowSpeedOffsetErrorType0       = 160;
  LowSpeedOffsetErrorType1       = 161;
  LowSpeedOffsetErrorType2       = 162;
  LowSpeedOffsetErrorType3       = 163;
  LowSpeedOffsetState            = 164;
  LowSpeedOffsetSpeed            = 165;
  LowSpeedOffsetSpare            = 166;

const
// Constants related to simple draw entry (x = dont care)
  DISPLAY_ERASE_ALL       = $00;     // W  - erase entire screen     (CMD,x,x,x,x,x)
  DISPLAY_PIXEL           = $01;     // W  - set pixel (on/off)      (CMD,TRUE/FALSE,X,Y,x,x)
  DISPLAY_HORIZONTAL_LINE = $02;     // W  - draw horisontal line    (CMD,TRUE,X1,Y1,X2,x)
  DISPLAY_VERTICAL_LINE   = $03;     // W  - draw vertical line      (CMD,TRUE,X1,Y1,x,Y2)
  DISPLAY_CHAR            = $04;     // W  - draw char (actual font) (CMD,TRUE,X1,Y1,Char,x)

// Constants related to Flags
  DISPLAY_ON               = $01;     // W  - Display on
  DISPLAY_REFRESH          = $02;     // W  - Enable refresh
  DISPLAY_POPUP            = $08;     // W  - Use popup display memory
  DISPLAY_REFRESH_DISABLED = $40;     // R  - Refresh disabled
  DISPLAY_BUSY             = $80;     // R  - Refresh in progress

  DISPLAY_HEIGHT = 64;        // Y pixels
  DISPLAY_WIDTH  = 100;       // X pixels

  DISPLAY_MENUICONS_Y       = 40;
  DISPLAY_MENUICONS_X_OFFS  = 7;
  DISPLAY_MENUICONS_X_DIFF  = 31;

// Used in macro "TEXTLINE_BIT"
  TEXTLINE_1 = 0; // Upper most line
  TEXTLINE_2 = 1; //
  TEXTLINE_3 = 2; //
  TEXTLINE_4 = 3; //
  TEXTLINE_5 = 4; //
  TEXTLINE_6 = 5; //
  TEXTLINE_7 = 6; //
  TEXTLINE_8 = 7; // Bottom line
  TEXTLINES  = 8;

// Used in macro "MENUICON_BIT"
  MENUICON_LEFT   = 0; // Left icon
  MENUICON_CENTER = 1; // Center icon
  MENUICON_RIGHT  = 2; // Right icon
  MENUICONS       = 3;

// Used in macro "SPECIAL_BIT"
  FRAME_SELECT = 0;   // Center icon select frame
  STATUSTEXT   = 1;   // Status text (BT name)
  MENUTEXT     = 2;   // Center icon text
  STEPLINE     = 3;   // Step collection lines
  TOPLINE      = 4;   // Top status underline
  SPECIALS     = 5;

// Used in macro "STATUSICON_BIT"
  STATUSICON_BLUETOOTH = 0; // BlueTooth status icon collection
  STATUSICON_USB       = 1; // USB status icon collection
  STATUSICON_VM        = 2; // VM status icon collection
  STATUSICON_BATTERY   = 3; // Battery status icon collection
  STATUSICONS          = 4;

  SCREENBIT = $20000000;
// Used in macro "SCREEN_BIT"
  SCREEN_BACKGROUND = 0; // Entire screen
  SCREEN_LARGE      = 1; // Entire screen except status line
  SCREEN_SMALL      = 2; // Screen between menu icons and status line
  SCREENS           = 3;

// Used in macro "BITMAP_BIT"
  BITMAP_1 = 0; // Bitmap 1
  BITMAP_2 = 1; // Bitmap 2
  BITMAP_3 = 2; // Bitmap 3
  BITMAP_4 = 3; // Bitmap 4
  BITMAPS  = 4;

// Used in macro "STEPICON_BIT"
  STEPICON_1 = 0; // Left most step icon
  STEPICON_2 = 1; //
  STEPICON_3 = 2; //
  STEPICON_4 = 3; //
  STEPICON_5 = 4; // Right most step icon
  STEPICONS  = 5;

  SCREEN_BITS     = ($E0000000);  // Executed as 1.
  STEPICON_BITS   = ($1F000000);  // Executed as 2.
  BITMAP_BITS     = ($00F00000);  // Executed as 3.
  MENUICON_BITS   = ($000E0000);  // Executed as 4.
  STATUSICON_BITS = ($0001E000);  // Executed as 5.
  SPECIAL_BITS    = ($00001F00);  // Executed as 6.
  TEXTLINE_BITS   = ($000000FF);  // Executed as 7.

function SCREEN_BIT(const No : byte) : Cardinal;
function STEPICON_BIT(const No : byte) : Cardinal;
function BITMAP_BIT(const No : byte) : Cardinal;
function MENUICON_BIT(const No : byte) : Cardinal;
function STATUSICON_BIT(const No : byte) : Cardinal;
function SPECIAL_BIT(const No : byte) : Cardinal;
function TEXTLINE_BIT(const No : byte) : Cardinal;

const
  DisplayOffsetPFunc                = 0; // Simple draw entry
  DisplayOffsetEraseMask            = 4; // Section erase mask   (executed first)
  DisplayOffsetUpdateMask           = 8; // Section update mask  (executed next)
  DisplayOffsetPFont                = 12; // Pointer to font file
  DisplayOffsetPStatusText          = 48; // Pointer to status text string
  DisplayOffsetPStatusIcons         = 52; // Pointer to status icon collection file
  DisplayOffsetPMenuText            = 84; // Pointer to menu icon text (NULL == none)
  DisplayOffsetPStepIcons           = 100; // Pointer to step icon collection file
  DisplayOffsetDisplay              = 104; // Display content copied to physical display every 17 mS
  DisplayOffsetFlags                = 117; // Update flags enumerated above
  DisplayOffsetTextLinesCenterFlags = 118; // Mask to center TextLines

function DisplayOffsetPTextLines(const p : byte) : word; // Pointer to text strings
function DisplayOffsetPScreens(const p : byte) : word; // Pointer to screen bitmap file
function DisplayOffsetPBitmaps(const p : byte) : word; // Pointer to free bitmap files
function DisplayOffsetPMenuIcons(const p : byte) : word; // Pointer to menu icon images (NULL == none)
function DisplayOffsetStatusIcons(const p : byte) : word; // Index in status icon collection file (index = 0 -> none)
function DisplayOffsetStepIcons(const p : byte) : word; // Index in step icon collection file (index = 0 -> none)
function DisplayOffsetNormal(const h, w : byte) : word; // Raw display memory for normal screen
function DisplayOffsetPopup(const h, w : byte) : word; // Raw display memory for normal screen


const
  CommOffsetPFunc    = 0;
  CommOffsetPFuncTwo = 4;
  CommOffsetBrickDataName            = 1126;
  CommOffsetBrickDataBluecoreVersion = 1142;
  CommOffsetBrickDataBdAddr          = 1144;
  CommOffsetBrickDataBtStateStatus   = 1151;
  CommOffsetBrickDataBtHwStatus      = 1152;
  CommOffsetBrickDataTimeOutValue    = 1153;
  CommOffsetBrickDataSpareOne        = 1154;
  CommOffsetBrickDataSpareTwo        = 1155;
  CommOffsetBrickDataSpareThree      = 1156;
  CommOffsetBtInBufBuf               = 1157;
  CommOffsetBtInBufInPtr             = 1285;
  CommOffsetBtInBufOutPtr            = 1286;
  CommOffsetBtInBufSpareOne          = 1287;
  CommOffsetBtInBufSpareTwo          = 1288;
  CommOffsetBtOutBufBuf              = 1289;
  CommOffsetBtOutBufInPtr            = 1417;
  CommOffsetBtOutBufOutPtr           = 1418;
  CommOffsetBtOutBufSpareOne         = 1419;
  CommOffsetBtOutBufSpareTwo         = 1420;
  CommOffsetHsInBufBuf               = 1421;
  CommOffsetHsInBufInPtr             = 1549;
  CommOffsetHsInBufOutPtr            = 1550;
  CommOffsetHsInBufSpareOne          = 1551;
  CommOffsetHsInBufSpareTwo          = 1552;
  CommOffsetHsOutBufBuf              = 1553;
  CommOffsetHsOutBufInPtr            = 1681;
  CommOffsetHsOutBufOutPtr           = 1682;
  CommOffsetHsOutBufSpareOne         = 1683;
  CommOffsetHsOutBufSpareTwo         = 1684;
  CommOffsetUsbInBufBuf              = 1685;
  CommOffsetUsbInBufInPtr            = 1749;
  CommOffsetUsbInBufOutPtr           = 1750;
  CommOffsetUsbInBufSpareOne         = 1751;
  CommOffsetUsbInBufSpareTwo         = 1752;
  CommOffsetUsbOutBufBuf             = 1753;
  CommOffsetUsbOutBufInPtr           = 1817;
  CommOffsetUsbOutBufOutPtr          = 1818;
  CommOffsetUsbOutBufSpareOne        = 1819;
  CommOffsetUsbOutBufSpareTwo        = 1820;
  CommOffsetUsbPollBufBuf            = 1821;
  CommOffsetUsbPollBufInPtr          = 1885;
  CommOffsetUsbPollBufOutPtr         = 1886;
  CommOffsetUsbPollBufSpareOne       = 1887;
  CommOffsetUsbPollBufSpareTwo       = 1888;
  CommOffsetBtDeviceCnt              = 1889;
  CommOffsetBtDeviceNameCnt          = 1890;
  CommOffsetHsFlags                  = 1891;
  CommOffsetHsSpeed                  = 1892;
  CommOffsetHsState                  = 1893;
  CommOffsetUsbState                 = 1894;

function CommOffsetBtDeviceTableName(const p : byte) : word;
function CommOffsetBtDeviceTableClassOfDevice(const p : byte) : word;
function CommOffsetBtDeviceTableBdAddr(const p : byte) : word;
function CommOffsetBtDeviceTableDeviceStatus(const p : byte) : word;
function CommOffsetBtDeviceTableSpareOne(const p : byte) : word;
function CommOffsetBtDeviceTableSpareTwo(const p : byte) : word;
function CommOffsetBtDeviceTableSpareThree(const p : byte) : word;
function CommOffsetBtConnectTableName(const p : byte) : word;
function CommOffsetBtConnectTableClassOfDevice(const p : byte) : word;
function CommOffsetBtConnectTablePinCode(const p : byte) : word;
function CommOffsetBtConnectTableBdAddr(const p : byte) : word;
function CommOffsetBtConnectTableHandleNr(const p : byte) : word;
function CommOffsetBtConnectTableStreamStatus(const p : byte) : word;
function CommOffsetBtConnectTableLinkQuality(const p : byte) : word;
function CommOffsetBtConnectTableSpare(const p : byte) : word;

function CCToStr(const cc : integer) : string;
function NXTInputTypeToStr(const stype : integer) : string;
function NXTInputModeToStr(const smode : integer) : string;
function NXTOutputModeToStr(const mode : integer) : string;
function NXTOutputRunStateToStr(const runstate : integer) : string;
function NXTOutputRegModeToStr(const regmode : integer) : string;

const
  TONES : array[3..9,0..11] of Word = (
 //   C     C#    D     D#    E     F     F#    G     G#    A     A#    B
  (  131,  139,  147,  156,  165,  175,  185,  196,  208,  220,  233,  247),
  (  262,  277,  294,  311,  330,  349,  370,  392,  415,  440,  466,  494),
  (  523,  554,  587,  622,  659,  698,  740,  784,  831,  880,  932,  988),
  ( 1047, 1109, 1175, 1245, 1319, 1397, 1480, 1568, 1661, 1760, 1865, 1976),
  ( 2093, 2217, 2349, 2489, 2637, 2794, 2960, 3136, 3322, 3520, 3729, 3951),
  ( 4186, 4434, 4698, 4978, 5274, 5588, 5920, 6272, 6644, 7040, 7458, 7902),
  ( 8372, 8868, 9396, 9956,10548,11176,11840,12544,13288,14080,14916,15804)
  );


const
  HTPF_CMD_FWD   = $1;
  HTPF_CMD_REV   = $2;
  HTPF_CMD_BRAKE = $3;

  HTPF_CHANNEL_1 = $0;
  HTPF_CHANNEL_2 = $1;
  HTPF_CHANNEL_3 = $2;
  HTPF_CHANNEL_4 = $3;

  PF_MODE_TRAIN             = $0;
  PF_MODE_COMBO_DIRECT      = $1;
  PF_MODE_SINGLE_PIN_CONT   = $2;
  PF_MODE_SINGLE_PIN_TIME   = $3;
  PF_MODE_COMBO_PWM         = $4;
  PF_MODE_SINGLE_OUTPUT_PWM = $4;
  PF_MODE_SINGLE_OUTPUT_CST = $6;

  TRAIN_FUNC_STOP         = $0;
  TRAIN_FUNC_INCR_SPEED   = $1;
  TRAIN_FUNC_DECR_SPEED   = $2;
  TRAIN_FUNC_TOGGLE_LIGHT = $4;

  TRAIN_CHANNEL_1   = $0;
  TRAIN_CHANNEL_2   = $1;
  TRAIN_CHANNEL_3   = $2;
  TRAIN_CHANNEL_ALL = $3;

  PF_OUT_A = $0;
  PF_OUT_B = $1;

  PF_PIN_C1 = $0;
  PF_PIN_C2 = $1;

  PF_FUNC_NOCHANGE = $0;
  PF_FUNC_CLEAR    = $1;
  PF_FUNC_SET      = $2;
  PF_FUNC_TOGGLE   = $3;

  PF_CST_CLEAR1_CLEAR2 = $0;
  PF_CST_SET1_CLEAR2   = $1;
  PF_CST_CLEAR1_SET2   = $2;
  PF_CST_SET1_SET2     = $3;
  PF_CST_INCREMENT_PWM = $4;
  PF_CST_DECREMENT_PWM = $5;
  PF_CST_FULL_FWD      = $6;
  PF_CST_FULL_REV      = $7;
  PF_CST_TOGGLE_DIR    = $8;

  PF_PWM_FLOAT = $0;
  PF_PWM_FWD1  = $1;
  PF_PWM_FWD2  = $2;
  PF_PWM_FWD3  = $3;
  PF_PWM_FWD4  = $4;
  PF_PWM_FWD5  = $5;
  PF_PWM_FWD6  = $6;
  PF_PWM_FWD7  = $7;
  PF_PWM_BRAKE = $8;
  PF_PWM_REV7  = $9;
  PF_PWM_REV6  = $a;
  PF_PWM_REV5  = $b;
  PF_PWM_REV4  = $c;
  PF_PWM_REV3  = $d;
  PF_PWM_REV2  = $e;
  PF_PWM_REV1  = $f;


// HiTechnic IRLink RCX constants
  RCX_OUT_A   = $01;
  RCX_OUT_B   = $02;
  RCX_OUT_C   = $04;
  RCX_OUT_AB  = $03;
  RCX_OUT_AC  = $05;
  RCX_OUT_BC  = $06;
  RCX_OUT_ABC = $07;

  RCX_OUT_FLOAT = $0;
  RCX_OUT_OFF   = $40;
  RCX_OUT_ON    = $80;

  RCX_OUT_REV    = $0;
  RCX_OUT_TOGGLE = $40;
  RCX_OUT_FWD    = $80;

  RCX_OUT_LOW  = $0;
  RCX_OUT_HALF = $3;
  RCX_OUT_FULL = $7;

  RCX_RemoteKeysReleased = $0000;
  RCX_RemotePBMessage1   = $0100;
  RCX_RemotePBMessage2   = $0200;
  RCX_RemotePBMessage3   = $0400;
  RCX_RemoteOutAForward  = $0800;
  RCX_RemoteOutBForward  = $1000;
  RCX_RemoteOutCForward  = $2000;
  RCX_RemoteOutABackward = $4000;
  RCX_RemoteOutBBackward = $8000;
  RCX_RemoteOutCBackward = $0001;
  RCX_RemoteSelProgram1  = $0002;
  RCX_RemoteSelProgram2  = $0004;
  RCX_RemoteSelProgram3  = $0008;
  RCX_RemoteSelProgram4  = $0010;
  RCX_RemoteSelProgram5  = $0020;
  RCX_RemoteStopOutOff   = $0040;
  RCX_RemotePlayASound   = $0080;

  RCX_SOUND_CLICK       = $0;
  RCX_SOUND_DOUBLE_BEEP = $1;
  RCX_SOUND_DOWN        = $2;
  RCX_SOUND_UP          = $3;
  RCX_SOUND_LOW_BEEP    = $4;
  RCX_SOUND_FAST_UP     = $5;

  SCOUT_LIGHT_ON        = $80;
  SCOUT_LIGHT_OFF       = $0;

  SCOUT_SOUND_REMOTE    = $6;
  SCOUT_SOUND_ENTERSA   = $7;
  SCOUT_SOUND_KEYERROR  = $8;
  SCOUT_SOUND_NONE      = $9;

  SCOUT_SOUND_TOUCH1_PRES     = $0a;
  SCOUT_SOUND_TOUCH1_REL      = $0b;
  SCOUT_SOUND_TOUCH2_PRES     = $0c;
  SCOUT_SOUND_TOUCH2_REL      = $0d;
  SCOUT_SOUND_ENTER_BRIGHT    = $0e;
  SCOUT_SOUND_ENTER_NORMAL    = $0f;
  SCOUT_SOUND_ENTER_DARK      = $10;
  SCOUT_SOUND_1_BLINK         = $11;
  SCOUT_SOUND_2_BLINK         = $12;
  SCOUT_SOUND_COUNTER1        = $13;
  SCOUT_SOUND_COUNTER2        = $14;
  SCOUT_SOUND_TIMER1          = $15;
  SCOUT_SOUND_TIMER2          = $16;
  SCOUT_SOUND_TIMER3          = $17;
  SCOUT_SOUND_MAIL_RECEIVED   = $18;
  SCOUT_SOUND_SPECIAL1        = $19;
  SCOUT_SOUND_SPECIAL2        = $1a;
  SCOUT_SOUND_SPECIAL3        = $1b;

  SCOUT_SNDSET_NONE           = $0;
  SCOUT_SNDSET_BASIC          = $1;
  SCOUT_SNDSET_BUG            = $2;
  SCOUT_SNDSET_ALARM          = $3;
  SCOUT_SNDSET_RANDOM         = $4;
  SCOUT_SNDSET_SCIENCE        = $5;

  SCOUT_MODE_STANDALONE       = $0;
  SCOUT_MODE_POWER            = $1;

  SCOUT_MR_NO_MOTION          = $0;
  SCOUT_MR_FORWARD            = $1;
  SCOUT_MR_ZIGZAG             = $2;
  SCOUT_MR_CIRCLE_RIGHT       = $3;
  SCOUT_MR_CIRCLE_LEFT        = $4;
  SCOUT_MR_LOOP_A             = $5;
  SCOUT_MR_LOOP_B             = $6;
  SCOUT_MR_LOOP_AB            = $7;

  SCOUT_TR_IGNORE             = $0;
  SCOUT_TR_REVERSE            = $1;
  SCOUT_TR_AVOID              = $2;
  SCOUT_TR_WAIT_FOR           = $3;
  SCOUT_TR_OFF_WHEN           = $4;

  SCOUT_LR_IGNORE             = $0;
  SCOUT_LR_SEEK_LIGHT         = $1;
  SCOUT_LR_SEEK_DARK          = $2;
  SCOUT_LR_AVOID              = $3;
  SCOUT_LR_WAIT_FOR           = $4;
  SCOUT_LR_OFF_WHEN           = $5;

  SCOUT_TGS_SHORT             = $0;
  SCOUT_TGS_MEDIUM            = $1;
  SCOUT_TGS_LONG              = $2;

  SCOUT_FXR_NONE              = $0;
  SCOUT_FXR_BUG               = $1;
  SCOUT_FXR_ALARM             = $2;
  SCOUT_FXR_RANDOM            = $3;
  SCOUT_FXR_SCIENCE           = $4;

  RCX_VariableSrc             = 0;
  RCX_TimerSrc                = 1;
  RCX_ConstantSrc             = 2;
  RCX_OutputStatusSrc         = 3;
  RCX_RandomSrc               = 4;
  RCX_ProgramSlotSrc          = 8;
  RCX_InputValueSrc           = 9;
  RCX_InputTypeSrc            = 10;
  RCX_InputModeSrc            = 11;
  RCX_InputRawSrc             = 12;
  RCX_InputBooleanSrc         = 13;
  RCX_WatchSrc                = 14;
  RCX_MessageSrc              = 15;
  RCX_GlobalMotorStatusSrc    = 17;
  RCX_ScoutRulesSrc           = 18;
  RCX_ScoutLightParamsSrc     = 19;
  RCX_ScoutTimerLimitSrc      = 20;
  RCX_CounterSrc              = 21;
  RCX_ScoutCounterLimitSrc    = 22;
  RCX_TaskEventsSrc           = 23;
  RCX_ScoutEventFBSrc         = 24;
  RCX_EventStateSrc           = 25;
  RCX_TenMSTimerSrc           = 26;
  RCX_ClickCounterSrc         = 27;
  RCX_UpperThresholdSrc       = 28;
  RCX_LowerThresholdSrc       = 29;
  RCX_HysteresisSrc           = 30;
  RCX_DurationSrc             = 31;
  RCX_UARTSetupSrc            = 33;
  RCX_BatteryLevelSrc         = 34;
  RCX_FirmwareVersionSrc      = 35;
  RCX_IndirectVarSrc          = 36;
  RCX_DatalogSrcIndirectSrc   = 37;
  RCX_DatalogSrcDirectSrc     = 38;
  RCX_DatalogValueIndirectSrc = 39;
  RCX_DatalogValueDirectSrc   = 40;
  RCX_DatalogRawIndirectSrc   = 41;
  RCX_DatalogRawDirectSrc     = 42;

  RCX_PingOp           = $10;
  RCX_BatteryLevelOp   = $30;
  RCX_DeleteTasksOp    = $40;
  RCX_StopAllTasksOp   = $50;
  RCX_PBTurnOffOp      = $60;
  RCX_DeleteSubsOp     = $70;
  RCX_ClearSoundOp     = $80;
  RCX_ClearMsgOp       = $90;
  RCX_LSCalibrateOp    = $c0;
  RCX_MuteSoundOp      = $d0;
  RCX_UnmuteSoundOp    = $e0;
  RCX_ClearAllEventsOp = $06;
  RCX_OnOffFloatOp     = $21;
  RCX_IRModeOp         = $31;
  RCX_PlaySoundOp      = $51;
  RCX_DeleteTaskOp     = $61;
  RCX_StartTaskOp      = $71;
  RCX_StopTaskOp       = $81;
  RCX_SelectProgramOp  = $91;
  RCX_ClearTimerOp     = $a1;
  RCX_AutoOffOp        = $b1;
  RCX_DeleteSubOp      = $c1;
  RCX_ClearSensorOp    = $d1;
  RCX_OutputDirOp      = $e1;
  RCX_PlayToneVarOp    = $02;
  RCX_PollOp           = $12;
  RCX_SetWatchOp       = $22;
  RCX_InputTypeOp      = $32;
  RCX_InputModeOp      = $42;
  RCX_SetDatalogOp     = $52;
  RCX_DatalogOp        = $62;
  RCX_SendUARTDataOp   = $c2;
  RCX_RemoteOp         = $d2;
  RCX_VLLOp            = $e2;
  RCX_DirectEventOp    = $03;
  RCX_OutputPowerOp    = $13;
  RCX_PlayToneOp       = $23;
  RCX_DisplayOp        = $33;
  RCX_PollMemoryOp     = $63;
  RCX_SetFeedbackOp    = $83;
  RCX_SetEventOp       = $93;
  RCX_GOutputPowerOp   = $a3;
  RCX_LSUpperThreshOp  = $b3;
  RCX_LSLowerThreshOp  = $c3;
  RCX_LSHysteresisOp   = $d3;
  RCX_LSBlinkTimeOp    = $e3;
  RCX_CalibrateEventOp = $04;
  RCX_SetVarOp         = $14;
  RCX_SumVarOp         = $24;
  RCX_SubVarOp         = $34;
  RCX_DivVarOp         = $44;
  RCX_MulVarOp         = $54;
  RCX_SgnVarOp         = $64;
  RCX_AbsVarOp         = $74;
  RCX_AndVarOp         = $84;
  RCX_OrVarOp          = $94;
  RCX_UploadDatalogOp  = $a4;
  RCX_SetTimerLimitOp  = $c4;
  RCX_SetCounterOp     = $d4;
  RCX_SetSourceValueOp = $05;
  RCX_UnlockOp         = $15;
  RCX_BootModeOp       = $65;
  RCX_UnlockFirmOp     = $a5;
  RCX_ScoutRulesOp     = $d5;
  RCX_ViewSourceValOp  = $e5;
  RCX_ScoutOp          = $47;
  RCX_SoundOp          = $57;
  RCX_GOutputModeOp    = $67;
  RCX_GOutputDirOp     = $77;
  RCX_LightOp          = $87;
  RCX_IncCounterOp     = $97;
  RCX_DecCounterOp     = $a7;
  RCX_ClearCounterOp   = $b7;
  RCX_SetPriorityOp    = $d7;
  RCX_MessageOp        = $f7;



implementation

uses
  SysUtils;

function INC_ID(X : Word) : Word;
begin
  Result := Word(X + 1);
end;

function DisplayOffsetPTextLines(const p : byte) : word;
begin
  Result := Word((Word(p)*4)+16);
end;

function DisplayOffsetPScreens(const p : byte) : word;
begin
  Result := Word((Word(p)*4)+56);
end;

function DisplayOffsetPBitmaps(const p : byte) : word;
begin
  Result := Word((Word(p)*4)+68);
end;

function DisplayOffsetPMenuIcons(const p : byte) : word;
begin
  Result := Word((Word(p)*4)+88);
end;

function DisplayOffsetStatusIcons(const p : byte) : word;
begin
  Result := Word(Word(p)+108);
end;

function DisplayOffsetStepIcons(const p : byte) : word;
begin
  Result := Word(Word(p)+112);
end;

function DisplayOffsetNormal(const h, w : byte) : word;
begin
  Result := Word((Word(h)*100)+Word(w)+119);
end;

function DisplayOffsetPopup(const h, w : byte) : word;
begin
  Result := Word((Word(h)*100)+Word(w)+919);
end;

function CommOffsetBtDeviceTableName(const p : byte) : word;
begin
  Result := Word((Word(p)*31)+8);
end;

function CommOffsetBtDeviceTableClassOfDevice(const p : byte) : word;
begin
  Result := Word((Word(p)*31)+24);
end;

function CommOffsetBtDeviceTableBdAddr(const p : byte) : word;
begin
  Result := Word((Word(p)*31)+28);
end;

function CommOffsetBtDeviceTableDeviceStatus(const p : byte) : word;
begin
  Result := Word((Word(p)*31)+35);
end;

function CommOffsetBtDeviceTableSpareOne(const p : byte) : word;
begin
  Result := Word((Word(p)*31)+36);
end;

function CommOffsetBtDeviceTableSpareTwo(const p : byte) : word;
begin
  Result := Word((Word(p)*31)+37);
end;

function CommOffsetBtDeviceTableSpareThree(const p : byte) : word;
begin
  Result := Word((Word(p)*31)+38);
end;

function CommOffsetBtConnectTableName(const p : byte) : word;
begin
  Result := Word((Word(p)*47)+938);
end;

function CommOffsetBtConnectTableClassOfDevice(const p : byte) : word;
begin
  Result := Word((Word(p)*47)+954);
end;

function CommOffsetBtConnectTablePinCode(const p : byte) : word;
begin
  Result := Word((Word(p)*47)+958);
end;

function CommOffsetBtConnectTableBdAddr(const p : byte) : word;
begin
  Result := Word((Word(p)*47)+974);
end;

function CommOffsetBtConnectTableHandleNr(const p : byte) : word;
begin
  Result := Word((Word(p)*47)+981);
end;

function CommOffsetBtConnectTableStreamStatus(const p : byte) : word;
begin
  Result := Word((Word(p)*47)+982);
end;

function CommOffsetBtConnectTableLinkQuality(const p : byte) : word;
begin
  Result := Word((Word(p)*47)+983);
end;

function CommOffsetBtConnectTableSpare(const p : byte) : word;
begin
  Result := Word((Word(p)*47)+984);
end;

function IS_ERR(Status : Integer) : boolean;
begin
  Result := ((Status) < NO_ERR);
end;

function IS_FATAL(Status : Integer) : boolean;
begin
  Result := (Status < NO_ERR) and (Status >= ERR_BAD_PTR);
end;

function VarCmdOffsetFHT(const i : byte) : word;
begin
  Result := Word(VarsCmdOffsetFileHandleTable + (i*21));
end;

function VarCmdOffsetFHTHandle(const i : byte) : word;
begin
  Result := VarCmdOffsetFHT(i);
end;

function VarCmdOffsetFHTFilename(const i : byte) : word;
begin
  Result := Word(VarCmdOffsetFHT(i) + 1);
end;

function VarCmdOffsetMessageQueue(const queue : byte) : word;
begin
  Result := Word(VarsCmdOffsetMessageQueues + (queue*14));
end;

function VarCmdOffsetMessageQueueReadIndex(const queue : byte) : word;
begin
  Result := VarCmdOffsetMessageQueue(queue) + MessageQueueOffsetReadIndex;
end;

function VarCmdOffsetMessageQueueWriteIndex(const queue : byte) : word;
begin
  Result := Word(VarCmdOffsetMessageQueue(queue) + MessageQueueOffsetWriteIndex);
end;

function VarCmdOffsetMessageQueueMessage(const queue, msg : byte) : word;
begin
  Result := Word(VarCmdOffsetMessageQueue(queue) + MessageQueueOffsetMessages + Word(msg*2));
end;

function SCREEN_BIT(const No : byte) : Cardinal;
begin
  Result := ($20000000 shl (No));
end;

function STEPICON_BIT(const No : byte) : Cardinal;
begin
  Result := ($01000000 shl (No));
end;

function BITMAP_BIT(const No : byte) : Cardinal;
begin
  Result := ($00100000 shl (No));
end;

function MENUICON_BIT(const No : byte) : Cardinal;
begin
  Result := ($00020000 shl (No));
end;

function STATUSICON_BIT(const No : byte) : Cardinal;
begin
  Result := ($00002000 shl (No));
end;

function SPECIAL_BIT(const No : byte) : Cardinal;
begin
  Result := ($00000100 shl (No));
end;

function TEXTLINE_BIT(const No : byte) : Cardinal;
begin
  Result := ($00000001 shl (No));
end;

function CCToStr(const cc : integer) : string;
begin
  case cc of
    OPCC1_LT   : Result := 'less than';
    OPCC1_GT   : Result := 'greater than';
    OPCC1_LTEQ : Result := 'less than or equal to';
    OPCC1_GTEQ : Result := 'greater than or equal to';
    OPCC1_EQ   : Result := 'equal to';
    OPCC1_NEQ  : Result := 'not equal to';
  else
    Result := 'unknown'
  end;
end;

function NXTInputTypeToStr(const stype : integer) : string;
begin
  case stype of
    IN_TYPE_NO_SENSOR      : Result := 'No Sensor';
    IN_TYPE_SWITCH         : Result := 'Switch';
    IN_TYPE_TEMPERATURE    : Result := 'Temperature';
    IN_TYPE_REFLECTION     : Result := 'Reflection';
    IN_TYPE_ANGLE          : Result := 'Angle';
    IN_TYPE_LIGHT_ACTIVE   : Result := 'Light Active';
    IN_TYPE_LIGHT_INACTIVE : Result := 'Light Inactive';
    IN_TYPE_SOUND_DB       : Result := 'Sound DB';
    IN_TYPE_SOUND_DBA      : Result := 'Sound DBA';
    IN_TYPE_CUSTOM         : Result := 'Custom';
    IN_TYPE_LOWSPEED       : Result := 'Lowspeed';
    IN_TYPE_LOWSPEED_9V    : Result := 'Lowspeed 9v';
    IN_TYPE_HISPEED        : Result := 'Hispeed';
  else
    Result := Format(HEX_FMT, [stype]);
  end;
end;

function NXTInputModeToStr(const smode : integer) : string;
begin
  case (smode and IN_MODE_MODEMASK) of
    IN_MODE_RAW           : Result := 'Raw';
    IN_MODE_BOOLEAN       : Result := 'Boolean';
    IN_MODE_TRANSITIONCNT : Result := 'Transition Count';
    IN_MODE_PERIODCOUNTER : Result := 'Period Counter';
    IN_MODE_PCTFULLSCALE  : Result := 'Percent Full Scale';
    IN_MODE_CELSIUS       : Result := 'Celsius';
    IN_MODE_FAHRENHEIT    : Result := 'Fahrenheit';
    IN_MODE_ANGLESTEP     : Result := 'Angle Step';
  else
    Result := Format(HEX_FMT, [smode and IN_MODE_MODEMASK]);
  end;
  if (smode and IN_MODE_SLOPEMASK) <> 0 then
    Result := Result + Format(' (slope = %d)', [smode and IN_MODE_SLOPEMASK]);
end;

function NXTOutputModeToStr(const mode : integer) : string;
begin
  case (mode and $F) of
    OUT_MODE_COAST     : Result := 'COAST';
    OUT_MODE_MOTORON   : Result := 'MOTORON';
    OUT_MODE_BRAKE     : Result := 'BRAKE';
    OUT_MODE_MOTORON +
    OUT_MODE_BRAKE     : Result := 'MOTORON|BRAKE';
    OUT_MODE_REGULATED : Result := 'REGULATED';
    OUT_MODE_MOTORON +
    OUT_MODE_REGULATED : Result := 'MOTORON|REGULATED';
    OUT_MODE_BRAKE +
    OUT_MODE_REGULATED : Result := 'BRAKE|REGULATED';
    OUT_MODE_BRAKE +
    OUT_MODE_MOTORON +
    OUT_MODE_REGULATED : Result := 'MOTORON|BRAKE|REGULATED';
  else
    Result := Format(HEX_FMT, [mode and $F]);
  end;
end;

function NXTOutputRunStateToStr(const runstate : integer) : string;
begin
  case (runstate and $F0) of
    OUT_RUNSTATE_IDLE     : Result := 'IDLE';
    OUT_RUNSTATE_RAMPUP   : Result := 'RAMPUP';
    OUT_RUNSTATE_RUNNING  : Result := 'RUNNING';
    OUT_RUNSTATE_RAMPUP +
    OUT_RUNSTATE_RUNNING  : Result := 'RAMPUP|RUNNING';
    OUT_RUNSTATE_RAMPDOWN : Result := 'RAMPDOWN';
    OUT_RUNSTATE_RAMPUP +
    OUT_RUNSTATE_RAMPDOWN : Result := 'RAMPUP|RAMPDOWN';
    OUT_RUNSTATE_RUNNING +
    OUT_RUNSTATE_RAMPDOWN : Result := 'RUNNING|RAMPDOWN';
    OUT_RUNSTATE_RAMPUP +
    OUT_RUNSTATE_RUNNING +
    OUT_RUNSTATE_RAMPDOWN : Result := 'RAMPUP|RUNNING|RAMPDOWN';
  else
    Result := Format(HEX_FMT, [runstate and $F0]);
  end;
end;

function NXTOutputRegModeToStr(const regmode : integer) : string;
begin
  case regmode of
    OUT_REGMODE_IDLE  : Result := 'IDLE';
    OUT_REGMODE_SPEED : Result := 'SPEED';
    OUT_REGMODE_SYNC  : Result := 'SYNC';
  else
    Result := Format(HEX_FMT, [regmode]);
  end;
end;

end.
