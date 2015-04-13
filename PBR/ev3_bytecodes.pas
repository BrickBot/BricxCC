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
unit ev3_bytecodes;

interface

uses
  ev3_constants;

const
(*
//#define   OLDCALL                       // Don't use optimised sub calls
//#define   DISABLE_PRU_UARTS             // Don't use port 3 and 4 for UART sensors
//#define   DISABLE_OLD_COLOR             // Don't support NXT color sensor
//#define   DISABLE_ADC                   // Don't use ADC (no clock EMC test)
//#define   ADC_BITBANGING                // Don't use SPI for a/d converter
//#define   DISABLE_DAISYCHAIN
//#define   DISABLE_DAISYCHAIN_COM_CALL
//#define   DISABLE_FAST_DATALOG_BUFFER
//#define   DISABLE_BUMBED
//#define   LOG_ASCII
//#define   DISABLE_FIQ_IIC
#define   UART1_FAKE_INTERRUPT          // Don't use real interrupt on UART1 (linux prompt)
//#define   DISABLE_LOW_VOLTAGE           // Don't shut down on low voltage
//#define   ENABLE_HIGH_CURRENT           // Don't shut down on high current
//#define   DISABLE_LOW_MEMORY            // Don't check low memory
//#define   DISABLE_UART_DATA_ERROR       // Don't reset UART sensor if timeout or crc error
#define   DISABLE_PREEMPTED_VM          // Don't run VM as preempted
//#define   DISABLE_SDCARD_SUPPORT        // Don't use SD card
#define   DISABLE_USBSTICK_SUPPORT      // Don't use USB stick
//#define   ENABLE_PERFORMANCE_TEST       // Show performance bar in the top line
//#define   ENABLE_LOAD_TEST              // Show integrated current in the top line
//#define   ENABLE_MEMORY_TEST            // Show used memory in the top line
//#define   ENABLE_STATUS_TEST
//#define   DISABLE_VIRTUAL_BATT_TEMP
//#define   DISABLE_SOUND
//#define   DISABLE_PAR_ALIGNMENT         // Disable possibility to align sub call parameter types
//#define   DISABLE_NEW_CALL_MUTEX        // Disable smart object switching after return from non reentrant sub call (enables blocked thread call)
//#define   DISABLE_SYSTEM_BYTECODE       // Disable the use of opSystem command
//#define   DISABLE_FILENAME_CHECK        // Disable "c_memory" filename check
//#define   DISABLE_AD_WORD_PROTECT       // Disable A/D word result protection
*)
  BYTECODE_VERSION  = 1.04;

  // SOFTWARE

  FG_COLOR = 1; // Forground color
  BG_COLOR = 0; // Background color

  CHAIN_DEPT = 4; // Number of bricks in the USB daisy chain (master + slaves)

  PATHSIZE = 84;  // Max path size excluding trailing forward slash including zero termination
  NAMESIZE = 32;  // Max name size including zero termination (must be divideable by 4)
  EXTSIZE  = 5;   // Max extension size including dot and zero termination
  FILENAMESIZE = 120; // Max filename size including path, name, extension and termination (must be divideable by 4)
  MACSIZE  = 18;  // Max WIFI MAC size including zero termination
  IPSIZE   = 16;  // Max WIFI IP size including zero termination
  BTADRSIZE = 13;  // Max bluetooth address size including zero termination

  ERR_STRING_SIZE             = 32;  // Inclusive zero termination

  EVENT_BT_PIN                = 1;
  EVENT_BT_REQ_CONF           = 2;

  MAX_VALID_TYPE              = 101; // Highest valid device type

  // FOLDERS

  MEMORY_FOLDER   = '/mnt/ramdisk';         // Folder for non volatile user programs/data
  PROGRAM_FOLDER  = '../prjs/BrkProg_SAVE'; // Folder for On Brick Programming programs
  DATALOG_FOLDER  = '../prjs/BrkDL_SAVE';   // Folder for On Brick Data log files
  SDCARD_FOLDER   = '../prjs/SD_Card';      // Folder for SD card mount
  USBSTICK_FOLDER = '../prjs/USB_Stick';    // Folder for USB stick mount

  PRJS_DIR  = '../prjs';              // Project folder
  APPS_DIR  = '../apps';              // Apps folder
  TOOLS_DIR = '../tools';             // Tools folder
  TMP_DIR   = '../tmp';               // Temporary folder

  SETTINGS_DIR = '../sys/settings';      // Folder for non volatile settings

  DIR_DEEPT = 127; // Max directory items allocated including "." and ".."

  // FILES USED IN APPLICATION

  LASTRUN_FILE_NAME = 'lastrun'; // Last run filename
  CALDATA_FILE_NAME = 'caldata'; // Calibration data filename

  // FILES USED IN APPS

  SLEEP_FILE_NAME     = 'Sleep';     // File used in "Sleep" app to save status
  VOLUME_FILE_NAME    = 'Volume';    // File used in "Volume" app to save status
  WIFI_FILE_NAME      = 'WiFi';      // File used in "WiFi" app to save status
  BLUETOOTH_FILE_NAME = 'Bluetooth'; // File used in "Bluetooth" app to save status

  // EXTENSIONS

  EXT_SOUND     = '.rsf'; // Robot Sound File
  EXT_GRAPHICS  = '.rgf'; // Robot Graphics File
  EXT_BYTECODE  = '.rbf'; // Robot Byte code File
  EXT_TEXT      = '.rtf'; // Robot Text File
  EXT_DATALOG   = '.rdf'; // Robot Datalog File
  EXT_PROGRAM   = '.rpf'; // Robot Program File
  EXT_CONFIG    = '.rcf'; // Robot Configuration File
  EXT_ARCHIVE   = '.raf'; // Robot Archive File

  // NAME LENGTHs

  BRICKNAMESIZE    = 120; // Brick name maximal size (including zero termination)
  BTPASSKEYSIZE    = 7;   // Bluetooth pass key size (including zero termination)
  WIFIPASSKEYSIZE  = 33;  // WiFi pass key size (including zero termination)

  // VALID CHARACTERS

  CHARSET_NAME        = $01; // Character set allowed in brick name and raw filenames
  CHARSET_FILENAME    = $02; // Character set allowed in file names
  CHARSET_BTPASSKEY   = $04; // Character set allowed in bluetooth pass key
  CHARSET_WIFIPASSKEY = $08; // Character set allowed in WiFi pass key
  CHARSET_WIFISSID    = $10; // Character set allowed in WiFi ssid

  // Browser Types Avaliable
  BROWSE_FOLDERS     = 0; // Browser for folders
  BROWSE_FOLDS_FILES = 1; // Browser for folders and files
  BROWSE_CACHE       = 2; // Browser for cached / recent files
  BROWSE_FILES       = 3; // Browser for files
  BROWSERTYPES       = 4; // Maximum font types supported by the VM

  // Font Types Avaliable
  NORMAL_FONT = 0;
  SMALL_FONT  = 1;
  LARGE_FONT  = 2;
  TINY_FONT   = 3;
  FONTTYPES   = 4; // Maximum font types supported by the VM

  // Icon Types Avaliable
  NORMAL_ICON  = 0; // "24x12_Files_Folders_Settings.bmp"
  SMALL_ICON   = 1;
  LARGE_ICON   = 2; // "24x22_Yes_No_OFF_FILEOps.bmp"
  MENU_ICON    = 3;
  ARROW_ICON   = 4; // "8x12_miniArrows.bmp"
  ICONTYPES    = 5; // Maximum icon types supported by the VM

  // S_ICON numbers
  S_ICON_CHARGING        = 0;
  S_ICON_BATT_4          = 1;
  S_ICON_BATT_3          = 2;
  S_ICON_BATT_2          = 3;
  S_ICON_BATT_1          = 4;
  S_ICON_BATT_0          = 5;
  S_ICON_WAIT1           = 6;
  S_ICON_WAIT2           = 7;
  S_ICON_BT_ON           = 8;
  S_ICON_BT_VISIBLE      = 9;
  S_ICON_BT_CONNECTED    = 10;
  S_ICON_BT_CONNVISIB    = 11;
  S_ICON_WIFI_3          = 12;
  S_ICON_WIFI_2          = 13;
  S_ICON_WIFI_1          = 14;
  S_ICON_WIFI_CONNECTED  = 15;
  S_ICON_USB             = 21;
  S_ICON_NOS             = 22;

  // N_ICON numbers
  N_ICON_NONE            = -1;
  N_ICON_RUN             = 0;
  N_ICON_FOLDER          = 1;
  N_ICON_FOLDER2         = 2;
  N_ICON_USB             = 3;
  N_ICON_SD              = 4;
  N_ICON_SOUND           = 5;
  N_ICON_IMAGE           = 6;
  N_ICON_SETTINGS        = 7;
  N_ICON_ONOFF           = 8;
  N_ICON_SEARCH          = 9;
  N_ICON_WIFI            = 10;
  N_ICON_CONNECTIONS     = 11;
  N_ICON_ADD_HIDDEN      = 12;
  N_ICON_TRASHBIN        = 13;
  N_ICON_VISIBILITY      = 14;
  N_ICON_KEY             = 15;
  N_ICON_CONNECT         = 16;
  N_ICON_DISCONNECT      = 17;
  N_ICON_UP              = 18;
  N_ICON_DOWN            = 19;
  N_ICON_WAIT1           = 20;
  N_ICON_WAIT2           = 21;
  N_ICON_BLUETOOTH       = 22;
  N_ICON_INFO            = 23;
  N_ICON_TEXT            = 24;
  N_ICON_QUESTIONMARK    = 27;
  N_ICON_INFO_FILE       = 28;
  N_ICON_DISC            = 29;
  N_ICON_CONNECTED       = 30;
  N_ICON_OBP             = 31;
  N_ICON_OBD             = 32;
  N_ICON_OPENFOLDER      = 33;
  N_ICON_BRICK1          = 34;
  N_ICON_NOS             = 35;

  // L_ICON numbers
  L_ICON_YES_NOTSEL    = 0;
  L_ICON_YES_SEL       = 1;
  L_ICON_NO_NOTSEL     = 2;
  L_ICON_NO_SEL        = 3;
  L_ICON_OFF           = 4;
  L_ICON_WAIT_VERT     = 5;
  L_ICON_WAIT_HORZ     = 6;
  L_ICON_TO_MANUAL     = 7;
  L_ICON_WARNSIGN      = 8;
  L_ICON_WARN_BATT     = 9;
  L_ICON_WARN_POWER    = 10;
  L_ICON_WARN_TEMP     = 11;
  L_ICON_NO_USBSTICK   = 12;
  L_ICON_TO_EXECUTE    = 13;
  L_ICON_TO_BRICK      = 14;
  L_ICON_TO_SDCARD     = 15;
  L_ICON_TO_USBSTICK   = 16;
  L_ICON_TO_BLUETOOTH  = 17;
  L_ICON_TO_WIFI       = 18;
  L_ICON_TO_TRASH      = 19;
  L_ICON_TO_COPY       = 20;
  L_ICON_TO_FILE       = 21;
  L_ICON_CHAR_ERROR    = 22;
  L_ICON_COPY_ERROR    = 23;
  L_ICON_PROGRAM_ERROR = 24;
  L_ICON_WARN_MEMORY   = 27;
  L_ICON_NOS           = 28;

  // M_ICON numbers
  M_ICON_STAR          = 0;
  M_ICON_LOCKSTAR      = 1;
  M_ICON_LOCK          = 2;
  M_ICON_PC            = 3; // Bluetooth type PC
  M_ICON_PHONE         = 4; // Bluetooth type PHONE
  M_ICON_BRICK         = 5; // Bluetooth type BRICK
  M_ICON_UNKNOWN       = 6; // Bluetooth type UNKNOWN
  M_ICON_FROM_FOLDER   = 7;
  M_ICON_CHECKBOX      = 8;
  M_ICON_CHECKED       = 9;
  M_ICON_XED           = 10;
  M_ICON_NOS           = 11;

  // A_ICON numbers
  A_ICON_LEFT   = 1;
  A_ICON_RIGHT  = 2;
  A_ICON_NOS    = 3;

  // Bluetooth Device Types
  BT_TYPE_PC       = 3; // Bluetooth type PC
  BT_TYPE_PHONE    = 4; // Bluetooth type PHONE
  BT_TYPE_BRICK    = 5; // Bluetooth type BRICK
  BT_TYPE_UNKNOWN  = 6; // Bluetooth type UNKNOWN
  BT_TYPE_NOS      = 7;

  // LED Patterns
  LED_BLACK          = 0;
  LED_GREEN          = 1;
  LED_RED            = 2;
  LED_ORANGE         = 3;
  LED_GREEN_FLASH    = 4;
  LED_RED_FLASH      = 5;
  LED_ORANGE_FLASH   = 6;
  LED_GREEN_PULSE    = 7;
  LED_RED_PULSE      = 8;
  LED_ORANGE_PULSE   = 9;
  LED_PATTERN_NOS    = 10;

  // LED Types
  LED_ALL  = 0; // All LEDs
  LED_RR   = 1; // Right red
  LED_RG   = 2; // Right green
  LED_LR   = 3; // Left red
  LED_LG   = 4; // Left green

  // File Types Avaliable
  FILETYPE_UNKNOWN      = $00;
  FILETYPE_FOLDER       = $01;
  FILETYPE_SOUND        = $02;
  FILETYPE_BYTECODE     = $03;
  FILETYPE_GRAPHICS     = $04;
  FILETYPE_DATALOG      = $05;
  FILETYPE_PROGRAM      = $06;
  FILETYPE_TEXT         = $07;
  FILETYPE_SDCARD       = $10;
  FILETYPE_USBSTICK     = $20;
  FILETYPE_NOS          = $21; // Maximum file types supported by the VM

  FILETYPE_RESTART_BROWSER  = -1;
  FILETYPE_REFRESH_BROWSER  = -2;

  // Results
  RESULT_OK    = 0; // No errors to report
  RESULT_BUSY  = 1; // Busy - try again
  RESULT_FAIL  = 2; // Something failed
  RESULT_STOP  = 4; // Stopped

  // Data type formats
  DATA_8          = $00; // DATA8  (don't change)
  DATA_16         = $01; // DATA16 (don't change)
  DATA_32         = $02; // DATA32 (don't change)
  DATA_F          = $03; // DATAF  (don't change)
  DATA_S          = $04; // Zero terminated string
  DATA_A          = $05; // Array handle
  DATA_V          = $07; // Variable type
  DATA_PCT        = $10; // Percent (used in opInputReadext)
  DATA_RAW        = $12; // Raw     (used in opInputReadext)
  DATA_SI         = $13; // SI unit (used in opInputReadext)
  DATA_FORMAT_NOS = $14;

  // Data File Delimiter Types
  DEL_NONE      = 0;  // No delimiter at all
  DEL_TAB       = 1;  // Use tab as delimiter
  DEL_SPACE     = 2;  // Use space as delimiter
  DEL_RETURN    = 3;  // Use return as delimiter
  DEL_COLON     = 4;  // Use colon as delimiter
  DEL_COMMA     = 5;  // Use comma as delimiter
  DEL_LINEFEED  = 6;  // Use line feed as delimiter
  DEL_CRLF      = 7;  // Use return+line feed as delimiter
  DEL_NOS       = 8;

  // Hardware Transport Layers
  HW_TPORT_USB  = 1;
  HW_TPORT_BT   = 2;
  HW_TPORT_WIFI = 3;
  HW_TPORT_NOS  = 4;

  // Encryption Types
  ENCRYPT_NONE = 0;
  ENCRYPT_WPA2 = 1;
  ENCRYPT_NOS  = 2;

  // MIX modes/types
  MIX_MODE_KEEP  = -1;
  MIX_TYPE_KEEP  =  0;
  MIX_NOS        =  1;

  // COLORS
  COLOR_RED   = 0;
  COLOR_GREEN = 1;
  COLOR_BLUE  = 2;
  COLOR_BLANK = 3;
  COLOR_NOS   = 4;

  // Constants related to color sensor value using
  // Color sensor as color detector
  BLACKCOLOR   = 1;
  BLUECOLOR    = 2;
  GREENCOLOR   = 3;
  YELLOWCOLOR  = 4;
  REDCOLOR     = 5;
  WHITECOLOR   = 6;

  // Warning numbers
  WARNING_TEMP      = $01;
  WARNING_CURRENT   = $02;
  WARNING_VOLTAGE   = $04;
  WARNING_MEMORY    = $08;
  WARNING_DSPSTAT   = $10;
  WARNING_BATTLOW   = $40;
  WARNING_BUSY      = $80;
  WARNING_NOS       = $3F;

  DATA8_NAN     = -128;
  DATA16_NAN    = -32768;
  DATA32_NAN    = $80000000;
  DATAF_NAN     = $7FC00000;

  DATA8_MIN     = -127;
  DATA8_MAX     = 127;
  DATA16_MIN    = -32767;
  DATA16_MAX    = 32767;
  DATA32_MIN    = -2147483647;
  DATA32_MAX    = 2147483647;
  DATAF_MIN     = -2147483647;
  DATAF_MAX     = 2147483647;

  // Values used to describe an object's status
  OBJECT_STATUS_RUNNING = $0010; // Object code is running
  OBJECT_STATUS_WAITING = $0020; // Object is waiting for final trigger
  OBJECT_STATUS_STOPPED = $0040; // Object is stopped or not triggered yet
  OBJECT_STATUS_HALTED  = $0080; // Object is halted because a call is in progress

  // Device commands used to control (UART sensors) devices
  DEVCMD_RESET   = $11; // UART device reset
  DEVCMD_FIRE    = $11; // UART device fire   (ultrasonic)
  DEVCMD_CHANNEL = $12; // UART device channel (IR seeker)
  DEVCMD_NOS     = $13;

  // GRAPHICS
  POP3_ABS_X                  = 16;        //
  POP3_ABS_Y                  = 50;        //
  POP3_ABS_WARN_ICON_X        = 64;
  POP3_ABS_WARN_ICON_X1       = 40;
  POP3_ABS_WARN_ICON_X2       = 72;
  POP3_ABS_WARN_ICON_X3       = 104;
  POP3_ABS_WARN_ICON_Y        = 60;
  POP3_ABS_WARN_SPEC_ICON_X   = 88;
  POP3_ABS_WARN_SPEC_ICON_Y   = 60;
  POP3_ABS_WARN_TEXT_X        = 80;
  POP3_ABS_WARN_TEXT_Y        = 68;
  POP3_ABS_WARN_YES_X         = 72;
  POP3_ABS_WARN_YES_Y         = 90;
  POP3_ABS_WARN_LINE_X        = 21;
  POP3_ABS_WARN_LINE_Y        = 89;
  POP3_ABS_WARN_LINE_ENDX     = 155;


  // MACROS FOR PRIMITIVES AND SYSTEM CALLS
  PRIMPAR_SHORT                 = $00;
  PRIMPAR_LONG                  = $80;
  PRIMPAR_CONST                 = $00;
  PRIMPAR_VARIABLE              = $40;
  PRIMPAR_LOCAL                 = $00;
  PRIMPAR_GLOBAL                = $20;
  PRIMPAR_HANDLE                = $10;
  PRIMPAR_ADDR                  = $08;
  PRIMPAR_INDEX                 = $1F;
  PRIMPAR_CONST_SIGN            = $20;
  PRIMPAR_VALUE                 = $3F;
  PRIMPAR_BYTES                 = $07;
  PRIMPAR_STRING_OLD            = $00;
  PRIMPAR_1_BYTE                = $01;
  PRIMPAR_2_BYTES               = $02;
  PRIMPAR_4_BYTES               = $03;
  PRIMPAR_STRING                = $04;
  PRIMPAR_LABEL                 = $20;

  LCS        = (PRIMPAR_LONG or PRIMPAR_STRING);
  
  // MACROS FOR SUB CALLS
  CALLPAR_IN      = $80;
  CALLPAR_OUT     = $40;
  CALLPAR_TYPE    = $07;
  CALLPAR_DATA8   = DATA_8;
  CALLPAR_DATA16  = DATA_16;
  CALLPAR_DATA32  = DATA_32;
  CALLPAR_DATAF   = DATA_F;
  CALLPAR_STRING  = DATA_S;

  IN_8            = (CALLPAR_IN  or CALLPAR_DATA8);
  IN_16           = (CALLPAR_IN  or CALLPAR_DATA16);
  IN_32           = (CALLPAR_IN  or CALLPAR_DATA32);
  IN_F            = (CALLPAR_IN  or CALLPAR_DATAF);
  IN_S            = (CALLPAR_IN  or CALLPAR_STRING);
  OUT_8           = (CALLPAR_OUT or CALLPAR_DATA8);
  OUT_16          = (CALLPAR_OUT or CALLPAR_DATA16);
  OUT_32          = (CALLPAR_OUT or CALLPAR_DATA32);
  OUT_F           = (CALLPAR_OUT or CALLPAR_DATAF);
  OUT_S           = (CALLPAR_OUT or CALLPAR_STRING);

  IO_8            = IN_8  or OUT_8;
  IO_16           = IN_16 or OUT_16;
  IO_32           = IN_32 or OUT_32;
  IO_F            = IN_F  or OUT_F;
  IO_S            = IN_S  or OUT_S;

const
  MAX_SUBCODES    = 33; // Max number of sub codes
  OPCODE_NAMESIZE = 20; // Opcode and sub code name length
  MAX_LABELS      = 32; // Max number of labels per program

  // misc
  SUBP      = $01;              // Next nibble is sub parameter table no
  PARNO     = $02;              // Defines no of following parameters
  PARLAB    = $03;              // Defines label no
  PARVALUES = $04;              // Last parameter defines number of values to follow
  PAR       = $08;              // Plain  parameter as below:
  PAR8      = (PAR + DATA_8);    // DATA8  parameter
  PAR16     = (PAR + DATA_16);   // DATA16 parameter
  PAR32     = (PAR + DATA_32);   // DATA32 parameter
  PARF      = (PAR + DATA_F);    // DATAF  parameter
  PARS      = (PAR + DATA_S);    // DATAS  parameter
  PARV      = (PAR + DATA_V);    // Parameter type variable

  ParTypeNames : array[0..7] of string = (
    'DATA8', 'DATA16', 'DATA32', 'DATAF', 'STRING', 'ARRAY', '', 'UNKNOWN'
  );

  ParMin : array[0..2] of integer = (
    DATA8_MIN, DATA16_MIN, DATA32_MIN
  );

  ParMax : array[0..2] of integer = (
    DATA8_MAX, DATA16_MAX, DATA32_MAX
  );

  // subp numbers
  UI_READ_SUBP    = 0;
  UI_WRITE_SUBP   = 1;
  UI_DRAW_SUBP    = 2;
  UI_BUTTON_SUBP  = 3;
  FILE_SUBP       = 4;
  PROGRAM_SUBP    = 5;
  VM_SUBP         = 6;
  STRING_SUBP     = 7;
  COM_READ_SUBP   = 8;
  COM_WRITE_SUBP  = 9;
  SOUND_SUBP      = 10;
  INPUT_SUBP      = 11;
  ARRAY_SUBP      = 12;
  MATH_SUBP       = 13;
  COM_GET_SUBP    = 14;
  COM_SET_SUBP    = 15;
//  FILENAME_SUBP   = 16;
  SUBP_NOS        = 17;

  FILENAME_SUBP   = ARRAY_SUBP;
  TEST_SUBP       = VM_SUBP;

type
  TOpCode = record
    Pars : cardinal;
    ParCount : byte;
    Name : string;
  end;

  TSubCode = record
    Pars : cardinal;
    ParCount : byte;
    Name : string;
  end;

  OpcodeArray = array of TOpCode;
  SubCodeArray = array of TSubCode;
  SubCodeArrayArray = array of SubCodeArray;

var
  OPCODES : array[0..255] of TOpCode;
  SUBCODES : array[0..SUBP_NOS-1] of array[0..MAX_SUBCODES-1] of TSubCode;

const
  LCD_BUFFER_SIZE  = (((LCD_WIDTH + 7) div 8) * LCD_HEIGHT);
  LCD_TOPLINE_SIZE = (((LCD_WIDTH + 7) div 8) * (TOPLINE_HEIGHT + 1));

{$IFNDEF DISABLE_OLD_COLOR}
const
  NUM_OLD_COLORS    = 4;
  NUM_OLD_CALPOINTS = 3;

type
  TColorStruct = record
    Calibration : array [0..NUM_OLD_CALPOINTS-1, 0..NUM_OLD_COLORS-1] of Cardinal;
    CalLimits : array [0..NUM_OLD_CALPOINTS-1 -1] of Word;
    Crc : Word;
    ADRaw : array[0..NUM_OLD_COLORS-1] of Word;
    SensorRaw : array[0..NUM_OLD_COLORS-1] of Word;
  end;
{$ENDIF}


type
// AnalogModuleMemory
  TANALOG = record
    InPin1 : array[0..NUM_INPUTS-1] of SmallInt;
    InPin6 : array[0..NUM_INPUTS-1] of SmallInt;
    OutPin5 : array[0..NUM_OUTPUTS-1] of SmallInt;
    BatteryTemp : SmallInt;
    MotorCurrent : SmallInt;
    BatteryCurrent : SmallInt;
    Cell123456 : SmallInt;
{$IFNDEF DISABLE_FAST_DATALOG_BUFFER}
    Pin1 : array[0..NUM_INPUTS-1, 0..DEVICE_LOGBUF_SIZE-1] of SmallInt;
    Pin6 : array[0..NUM_INPUTS-1, 0..DEVICE_LOGBUF_SIZE-1] of SmallInt;
    Actual : array[0..NUM_INPUTS-1] of Word;
    LogIn : array[0..NUM_INPUTS-1] of Word;
    LogOut : array[0..NUM_INPUTS-1] of Word;
{$ENDIF}
{$IFNDEF DISABLE_OLD_COLOR}
    NxtCol : array[0.. NUM_INPUTS-1] of TColorStruct;
{$ENDIF}
    OutPin5Low : array[0..NUM_OUTPUTS-1] of SmallInt; // Analog value at output port connection 5 when connection 6 is low
    Updated : array[0..NUM_INPUTS-1] of ShortInt;
    InDcm : array[0..NUM_INPUTS-1] of ShortInt; // Input port device types
    InConn : array[0..NUM_INPUTS-1] of ShortInt;
    OutDcm : array[0..NUM_OUTPUTS-1] of ShortInt; // Output port device types
    OutConn : array[0..NUM_OUTPUTS-1] of ShortInt;
{$IFNDEF DISABLE_PREEMPTED_VM}
    PreemptMilliSeconds : Word;
{$ENDIF}
  end;

// UartModuleMemory
const
  UART_DATA_LENGTH = MAX_DEVICE_DATALENGTH;
  UART_BUFFER_SIZE = 64;

type
  TUART = record
    TypeData : array [0..NUM_INPUTS-1, 0..MAX_DEVICE_MODES-1] of ShortInt; // TypeData
{$IFNDEF DISABLE_FAST_DATALOG_BUFFER}
    Repeats : array [0..NUM_INPUTS-1, 0..DEVICE_LOGBUF_SIZE-1] of Word;
    Raw : array [0..NUM_INPUTS-1, 0..DEVICE_LOGBUF_SIZE-1, 0..UART_DATA_LENGTH-1] of ShortInt; // Raw value from UART device
    Actual : array [0..NUM_INPUTS-1] of Word;
    LogIn : array [0..NUM_INPUTS-1] of Word;
{$ELSE}
    Raw : array [0..NUM_INPUTS-1, 0..UART_DATA_LENGTH-1] of ShortInt;      // Raw value from UART device
{$ENDIF}
    Status : array [0..NUM_INPUTS-1] of ShortInt;  // Status
    Output : array [0..NUM_INPUTS-1, 0..UART_DATA_LENGTH-1] of ShortInt;   // Bytes to UART device
    OutputLength : array [0..NUM_INPUTS-1] of ShortInt;
  end;

const
  UART_PORT_CHANGED  = $01; // Input port changed
  UART_DATA_READY    = $08; // Data is ready
  UART_WRITE_REQUEST = $10; // Write request

type
  TDEVCON = record
    Connection : array [0..NUM_INPUTS-1] of ShortInt;
    DevType : array [0..NUM_INPUTS-1] of ShortInt;
    DevMode : array [0..NUM_INPUTS-1] of ShortInt;
  end;

  TUARTCTL = record
    TypeData : ShortInt;
    Port : ShortInt;
    Mode : ShortInt;
  end;

  //IicModuleMemory
const
  IIC_DATA_LENGTH = MAX_DEVICE_DATALENGTH;
  IIC_NAME_LENGTH = 8;

type
  TIIC = record
    TypeData : array [0..NUM_INPUTS-1, 0..MAX_DEVICE_MODES-1] of ShortInt; // TypeData
{$IFNDEF DISABLE_FAST_DATALOG_BUFFER}
    Repeats : array [0..NUM_INPUTS-1, 0..DEVICE_LOGBUF_SIZE-1] of Word;
    Raw : array [0..NUM_INPUTS-1, 0..DEVICE_LOGBUF_SIZE-1, 0..IIC_DATA_LENGTH-1] of ShortInt; // Raw value from IIC device
    Actual : array [0..NUM_INPUTS-1] of Word;
    LogIn : array [0..NUM_INPUTS-1] of Word;
{$ELSE}
    Raw : array [0..NUM_INPUTS-1, 0..IIC_DATA_LENGTH-1] of ShortInt;      // Raw value from IIC device
{$ENDIF}
    Status : array [0..NUM_INPUTS-1] of ShortInt;  // Status
    Changed : array [0..NUM_INPUTS-1] of ShortInt;  // Changed
    Output : array [0..NUM_INPUTS-1, 0..IIC_DATA_LENGTH-1] of ShortInt;   // Bytes to IIC device
    OutputLength : array [0..NUM_INPUTS-1] of ShortInt;
  end;

const
  IIC_PORT_CHANGED  = $01; // Input port changed
  IIC_DATA_READY    = $08; // Data is ready
  IIC_WRITE_REQUEST = $10; // Write request

type
  TIICCTL = record
    TypeData : ShortInt;
    Port: ShortInt;
    Mode: ShortInt;
  end;

  TIICDAT = record
    Result: ShortInt;
    Port: ShortInt;
    Repeats: ShortInt;
    Time : SmallInt;
    WrLng: ShortInt;
    WrData : array [0..IIC_DATA_LENGTH-1] of ShortInt;
    RdLng: ShortInt;
    RdData : array [0..IIC_DATA_LENGTH-1] of ShortInt;
  end;

  TIICSTR = record
    Port : ShortInt;
    Time : SmallInt;
    DevType : ShortInt;
    DevMode : ShortInt;
    Manufacturer : array [0..IIC_NAME_LENGTH-1] of Byte;
    SensorType : array [0..IIC_NAME_LENGTH-1] of Byte;
    SetupLng : ShortInt;
    SetupString : Cardinal;
    PollLng : ShortInt;
    PollString : Cardinal;
    ReadLng : ShortInt;
  end;

  // ButtonModuleMemory
type
  TBUTTON = record
    Pressed : array[0..NUM_BUTTONS-1] of ShortInt;
  end;

  // DisplayModuleMemory
type
  TLCD = record
    Lcd : array[0..LCD_BUFFER_SIZE-1] of Byte;
  end;

  //SoundModuleMemory
type
  TSOUND = record
    Status : ShortInt;
  end;

  // UsbModuleMemory
const
  USB_FULL_SPEED = 0;
  USB_HIGH_SPEED = 1;

type
  TUSB_SPEED = record
    Speed : ShortInt;
  end;

implementation

uses
  SysUtils;

var
  SubCodeNames : array[0..SUBP_NOS-1] of array[0..MAX_SUBCODES-1] of string;

function SubCodeToString(ParameterFormat, SubCode : byte) : string;
begin
  Result := 'Unknown';
  if (ParameterFormat < SUBP_NOS) and (SubCode < MAX_SUBCODES) then
    Result := SubCodeNames[ParameterFormat][SubCode];
end;

function ParameterCount(Par1, Par2, Par3, Par4, Par5, Par6, Par7, Par8 : byte) : Byte;
begin
  Result := 0;
  if Par1 <> 0 then inc(Result);
  if Par2 <> 0 then inc(Result);
  if Par3 <> 0 then inc(Result);
  if Par4 <> 0 then inc(Result);
  if Par5 <> 0 then inc(Result);
  if Par6 <> 0 then inc(Result);
  if Par7 <> 0 then inc(Result);
  if Par8 <> 0 then inc(Result);
end;

procedure CreateOpCode(opCode, Par1, Par2, Par3, Par4, Par5, Par6, Par7, Par8 : byte; aName : string = '');
begin
  if aName = '' then
    aName := Format('opUnknown%d', [opCode]);
  OPCODES[opCode].Name := aName;
  OPCODES[opCode].ParCount := ParameterCount(Par1, Par2, Par3, Par4, Par5, Par6, Par7, Par8);
  OPCODES[opCode].Pars := Cardinal(Par1) +
    Cardinal(Par2) shl 4 +
    Cardinal(Par3) shl 8 +
    Cardinal(Par4) shl 12 +
    Cardinal(Par5) shl 16 +
    Cardinal(Par6) shl 20 +
    Cardinal(Par7) shl 24 +
    Cardinal(Par8) shl 28;
end;

procedure CreateSubCode(ParameterFormat, SubCode, Par1, Par2, Par3, Par4, Par5, Par6, Par7, Par8 : byte);
begin
  SUBCODES[ParameterFormat][SubCode].Name := SubCodeToString(ParameterFormat, SubCode);
  SUBCODES[ParameterFormat][SubCode].ParCount := ParameterCount(Par1, Par2, Par3, Par4, Par5, Par6, Par7, Par8);
  SUBCODES[ParameterFormat][SubCode].Pars :=  Cardinal(Par1) +
    Cardinal(Par2) shl 4 +
    Cardinal(Par3) shl 8 +
    Cardinal(Par4) shl 12 +
    Cardinal(Par5) shl 16 +
    Cardinal(Par6) shl 20 +
    Cardinal(Par7) shl 24 +
    Cardinal(Par8) shl 28;
end;

procedure SCName(ParameterFormat, SubCode : byte; aName : string);
begin
  if (ParameterFormat < SUBP_NOS) and (SubCode < MAX_SUBCODES) then
    SubCodeNames[ParameterFormat][SubCode] := aName;
end;

procedure PopulateOpcodes;
begin
  CreateOpCode(opError,                0,        0,0,0,0,0,0,0         , 'error');
  CreateOpCode(opNop,                  0,        0,0,0,0,0,0,0         , 'nop');
  CreateOpCode(opProgramStop,          PAR16,    0,0,0,0,0,0,0         , 'prgstop');
  CreateOpCode(opProgramStart,         PAR16,PAR32,PAR32,PAR8,      0,0,0,0               , 'prgstart');
  CreateOpCode(opObjectStop,           PAR16,    0,0,0,0,0,0,0         , 'objstop');
  CreateOpCode(opObjectStart,          PAR16,    0,0,0,0,0,0,0         , 'objstart');
  CreateOpCode(opObjectTrigger,        PAR16,    0,0,0,0,0,0,0         , 'objtrigger');
  CreateOpCode(opObjectWait,           PAR16,    0,0,0,0,0,0,0         , 'objwait');
  CreateOpCode(opReturn,               0,        0,0,0,0,0,0,0         , 'return');
  CreateOpCode(opCall,                 PAR16,PARNO,                 0,0,0,0,0,0           , 'call');
  CreateOpCode(opObjectEnd,            0,        0,0,0,0,0,0,0         , 'objend');
  CreateOpCode(opSleep,                0,        0,0,0,0,0,0,0         , 'sleep');
  CreateOpCode(opProgramInfo,          PAR8, SUBP, PROGRAM_SUBP,    0,0,0,0,0             , 'proginfo');
  CreateOpCode(opLabel,                PARLAB,   0,0,0,0,0,0,0         , 'label');
  CreateOpCode(opProbe,                PAR16,PAR16,PAR32,PAR32,     0,0,0,0               , 'probe');
  CreateOpCode(opDo,                   PAR16,PAR32,PAR32,           0,0,0,0,0             , 'do');
  CreateOpCode(opAdd1,                 PAR8,PAR8,PAR8,              0,0,0,0,0             , 'add1');
  CreateOpCode(opAdd2,                 PAR16,PAR16,PAR16,           0,0,0,0,0             , 'add2');
  CreateOpCode(opAdd4,                 PAR32,PAR32,PAR32,           0,0,0,0,0             , 'add4');
  CreateOpCode(opAddF,                 PARF,PARF,PARF,              0,0,0,0,0             , 'addf');
  CreateOpCode(opSub1,                 PAR8,PAR8,PAR8,              0,0,0,0,0             , 'sub1');
  CreateOpCode(opSub2,                 PAR16,PAR16,PAR16,           0,0,0,0,0             , 'sub2');
  CreateOpCode(opSub4,                 PAR32,PAR32,PAR32,           0,0,0,0,0             , 'sub4');
  CreateOpCode(opSubF,                 PARF,PARF,PARF,              0,0,0,0,0             , 'subf');
  CreateOpCode(opMul1,                 PAR8,PAR8,PAR8,              0,0,0,0,0             , 'mul1');
  CreateOpCode(opMul2,                 PAR16,PAR16,PAR16,           0,0,0,0,0             , 'mul2');
  CreateOpCode(opMul4,                 PAR32,PAR32,PAR32,           0,0,0,0,0             , 'mul4');
  CreateOpCode(opMulF,                 PARF,PARF,PARF,              0,0,0,0,0             , 'mulf');
  CreateOpCode(opDiv1,                 PAR8,PAR8,PAR8,              0,0,0,0,0             , 'div1');
  CreateOpCode(opDiv2,                 PAR16,PAR16,PAR16,           0,0,0,0,0             , 'div2');
  CreateOpCode(opDiv4,                 PAR32,PAR32,PAR32,           0,0,0,0,0             , 'div4');
  CreateOpCode(opDivF,                 PARF,PARF,PARF,              0,0,0,0,0             , 'divf');
  CreateOpCode(opOr1,                  PAR8,PAR8,PAR8,              0,0,0,0,0             , 'or1');
  CreateOpCode(opOr2,                  PAR16,PAR16,PAR16,           0,0,0,0,0             , 'or2');
  CreateOpCode(opOr4,                  PAR32,PAR32,PAR32,           0,0,0,0,0             , 'or4');
  CreateOpCode(opAnd1,                 PAR8,PAR8,PAR8,              0,0,0,0,0             , 'and1');
  CreateOpCode(opAnd2,                 PAR16,PAR16,PAR16,           0,0,0,0,0             , 'and2');
  CreateOpCode(opAnd4,                 PAR32,PAR32,PAR32,           0,0,0,0,0             , 'and4');
  CreateOpCode(opXor1,                 PAR8,PAR8,PAR8,              0,0,0,0,0             , 'xor1');
  CreateOpCode(opXor2,                 PAR16,PAR16,PAR16,           0,0,0,0,0             , 'xor2');
  CreateOpCode(opXor4,                 PAR32,PAR32,PAR32,           0,0,0,0,0             , 'xor4');
  CreateOpCode(opRl1,                  PAR8,PAR8,PAR8,              0,0,0,0,0             , 'rol1');
  CreateOpCode(opRl2,                  PAR16,PAR16,PAR16,           0,0,0,0,0             , 'rol2');
  CreateOpCode(opRl4,                  PAR32,PAR32,PAR32,           0,0,0,0,0             , 'rol4');
  CreateOpCode(opInitBytes,            PAR8,PAR32,PARVALUES,PAR8,   0,0,0,0               , 'initbytes');
  CreateOpCode(opMove11,               PAR8,PAR8,                   0,0,0,0,0,0           , 'move11');
  CreateOpCode(opMove12,               PAR8,PAR16,                  0,0,0,0,0,0           , 'move12');
  CreateOpCode(opMove14,               PAR8,PAR32,                  0,0,0,0,0,0           , 'move14');
  CreateOpCode(opMove1F,               PAR8,PARF,                   0,0,0,0,0,0           , 'move1f');
  CreateOpCode(opMove21,               PAR16,PAR8,                  0,0,0,0,0,0           , 'move21');
  CreateOpCode(opMove22,               PAR16,PAR16,                 0,0,0,0,0,0           , 'move22');
  CreateOpCode(opMove24,               PAR16,PAR32,                 0,0,0,0,0,0           , 'move24');
  CreateOpCode(opMove2F,               PAR16,PARF,                  0,0,0,0,0,0           , 'move2f');
  CreateOpCode(opMove41,               PAR32,PAR8,                  0,0,0,0,0,0           , 'move41');
  CreateOpCode(opMove42,               PAR32,PAR16,                 0,0,0,0,0,0           , 'move42');
  CreateOpCode(opMove44,               PAR32,PAR32,                 0,0,0,0,0,0           , 'move44');
  CreateOpCode(opMove4F,               PAR32,PARF,                  0,0,0,0,0,0           , 'move4f');
  CreateOpCode(opMoveF1,               PARF,PAR8,                   0,0,0,0,0,0           , 'movef1');
  CreateOpCode(opMoveF2,               PARF,PAR16,                  0,0,0,0,0,0           , 'movef2');
  CreateOpCode(opMoveF4,               PARF,PAR32,                  0,0,0,0,0,0           , 'movef4');
  CreateOpCode(opMoveFF,               PARF,PARF,                   0,0,0,0,0,0           , 'moveff');
  CreateOpCode(opJmp,                  PAR32,    0,0,0,0,0,0,0         , 'jmp');
  CreateOpCode(opJmpFalse,             PAR8,PAR32,                  0,0,0,0,0,0           , 'jmpfalse');
  CreateOpCode(opJmpTrue,              PAR8,PAR32,                  0,0,0,0,0,0           , 'jmptrue');
  CreateOpCode(opJmpNan,               PARF,PAR32,                  0,0,0,0,0,0           , 'jmpnan');
  CreateOpCode(opCmpLT1,               PAR8,PAR8,PAR8,              0,0,0,0,0             , 'cmplt1');
  CreateOpCode(opCmpLT2,               PAR16,PAR16,PAR8,            0,0,0,0,0             , 'cmplt2');
  CreateOpCode(opCmpLT4,               PAR32,PAR32,PAR8,            0,0,0,0,0             , 'cmplt4');
  CreateOpCode(opCmpLTF,               PARF,PARF,PAR8,              0,0,0,0,0             , 'cmpltF');
  CreateOpCode(opCmpGT1,               PAR8,PAR8,PAR8,              0,0,0,0,0             , 'cmpgt1');
  CreateOpCode(opCmpGT2,               PAR16,PAR16,PAR8,            0,0,0,0,0             , 'cmpgt2');
  CreateOpCode(opCmpGT4,               PAR32,PAR32,PAR8,            0,0,0,0,0             , 'cmpgt4');
  CreateOpCode(opCmpGTF,               PARF,PARF,PAR8,              0,0,0,0,0             , 'cmpgtF');
  CreateOpCode(opCmpEQ1,               PAR8,PAR8,PAR8,              0,0,0,0,0             , 'cmpeq1');
  CreateOpCode(opCmpEQ2,               PAR16,PAR16,PAR8,            0,0,0,0,0             , 'cmpeq2');
  CreateOpCode(opCmpEQ4,               PAR32,PAR32,PAR8,            0,0,0,0,0             , 'cmpeq4');
  CreateOpCode(opCmpEQF,               PARF,PARF,PAR8,              0,0,0,0,0             , 'cmpeqf');
  CreateOpCode(opCmpNEQ1,              PAR8,PAR8,PAR8,              0,0,0,0,0             , 'cmpneq1');
  CreateOpCode(opCmpNEQ2,              PAR16,PAR16,PAR8,            0,0,0,0,0             , 'cmpneq2');
  CreateOpCode(opCmpNEQ4,              PAR32,PAR32,PAR8,            0,0,0,0,0             , 'cmpneq4');
  CreateOpCode(opCmpNEQF,              PARF,PARF,PAR8,              0,0,0,0,0             , 'cmpneqf');
  CreateOpCode(opCmpLTEQ1,             PAR8,PAR8,PAR8,              0,0,0,0,0             , 'cmplteq1');
  CreateOpCode(opCmpLTEQ2,             PAR16,PAR16,PAR8,            0,0,0,0,0             , 'cmplteq2');
  CreateOpCode(opCmpLTEQ4,             PAR32,PAR32,PAR8,            0,0,0,0,0             , 'cmplteq4');
  CreateOpCode(opCmpLTEQF,             PARF,PARF,PAR8,              0,0,0,0,0             , 'cmplteqf');
  CreateOpCode(opCmpGTEQ1,             PAR8,PAR8,PAR8,              0,0,0,0,0             , 'cmpgteq1');
  CreateOpCode(opCmpGTEQ2,             PAR16,PAR16,PAR8,            0,0,0,0,0             , 'cmpgteq2');
  CreateOpCode(opCmpGTEQ4,             PAR32,PAR32,PAR8,            0,0,0,0,0             , 'cmpgteq4');
  CreateOpCode(opCmpGTEQF,             PARF,PARF,PAR8,              0,0,0,0,0             , 'cmpgteqf');
  CreateOpCode(opSelect1,              PAR8,PAR8,PAR8,PAR8,         0,0,0,0               , 'select1');
  CreateOpCode(opSelect2,              PAR8,PAR16,PAR16,PAR16,      0,0,0,0               , 'select2');
  CreateOpCode(opSelect4,              PAR8,PAR32,PAR32,PAR32,      0,0,0,0               , 'select4');
  CreateOpCode(opSelectF,              PAR8,PARF,PARF,PARF,         0,0,0,0               , 'selectf');
  CreateOpCode(opSystem,               PAR8,PAR32,                  0,0,0,0,0,0           , 'system');
  CreateOpCode(opPortConvertOutput,    PAR32,PAR8,PAR8,PAR8,        0,0,0,0               , 'decodeoutput');
  CreateOpCode(opPortConvertInput,     PAR32,PAR8,PAR8,             0,0,0,0,0             , 'decodeinput');
  CreateOpCode(opNote2Freq,            PAR8,PAR16,                  0,0,0,0,0,0           , 'note2freq');
  CreateOpCode(opJmpLT1,               PAR8,PAR8,PAR32,             0,0,0,0,0             , 'jmplt1');
  CreateOpCode(opJmpLT2,               PAR16,PAR16,PAR32,           0,0,0,0,0             , 'jmplt2');
  CreateOpCode(opJmpLT4,               PAR32,PAR32,PAR32,           0,0,0,0,0             , 'jmplt4');
  CreateOpCode(opJmpLTF,               PARF,PARF,PAR32,             0,0,0,0,0             , 'jmpltf');
  CreateOpCode(opJmpGT1,               PAR8,PAR8,PAR32,             0,0,0,0,0             , 'jmpgt1');
  CreateOpCode(opJmpGT2,               PAR16,PAR16,PAR32,           0,0,0,0,0             , 'jmpgt2');
  CreateOpCode(opJmpGT4,               PAR32,PAR32,PAR32,           0,0,0,0,0             , 'jmpgt4');
  CreateOpCode(opJmpGTF,               PARF,PARF,PAR32,             0,0,0,0,0             , 'jmpgtf');
  CreateOpCode(opJmpEQ1,               PAR8,PAR8,PAR32,             0,0,0,0,0             , 'jmpeq1');
  CreateOpCode(opJmpEQ2,               PAR16,PAR16,PAR32,           0,0,0,0,0             , 'jmpeq2');
  CreateOpCode(opJmpEQ4,               PAR32,PAR32,PAR32,           0,0,0,0,0             , 'jmpeq4');
  CreateOpCode(opJmpEQF,               PARF,PARF,PAR32,             0,0,0,0,0             , 'jmpeqf');
  CreateOpCode(opJmpNEQ1,              PAR8,PAR8,PAR32,             0,0,0,0,0             , 'jmpneq1');
  CreateOpCode(opJmpNEQ2,              PAR16,PAR16,PAR32,           0,0,0,0,0             , 'jmpneq2');
  CreateOpCode(opJmpNEQ4,              PAR32,PAR32,PAR32,           0,0,0,0,0             , 'jmpneq4');
  CreateOpCode(opJmpNEQF,              PARF,PARF,PAR32,             0,0,0,0,0             , 'jmpneqf');
  CreateOpCode(opJmpLTEQ1,             PAR8,PAR8,PAR32,             0,0,0,0,0             , 'jmplteq1');
  CreateOpCode(opJmpLTEQ2,             PAR16,PAR16,PAR32,           0,0,0,0,0             , 'jmplteq2');
  CreateOpCode(opJmpLTEQ4,             PAR32,PAR32,PAR32,           0,0,0,0,0             , 'jmplteq4');
  CreateOpCode(opJmpLTEQF,             PARF,PARF,PAR32,             0,0,0,0,0             , 'jmplteqf');
  CreateOpCode(opJmpGTEQ1,             PAR8,PAR8,PAR32,             0,0,0,0,0             , 'jmpgteq1');
  CreateOpCode(opJmpGTEQ2,             PAR16,PAR16,PAR32,           0,0,0,0,0             , 'jmpgteq2');
  CreateOpCode(opJmpGTEQ4,             PAR32,PAR32,PAR32,           0,0,0,0,0             , 'jmpgteq4');
  CreateOpCode(opJmpGTEQF,             PARF,PARF,PAR32,             0,0,0,0,0             , 'jmpgteqf');
  CreateOpCode(opInfo,                 PAR8,SUBP,VM_SUBP,           0,0,0,0,0             , 'info');
  CreateOpCode(opStrings,              PAR8,SUBP,STRING_SUBP,       0,0,0,0,0             , 'strings');
  CreateOpCode(opMemoryWrite,          PAR16,PAR16,PAR32,PAR32,PAR8,                   0,0,0                 , 'memwrite');
  CreateOpCode(opMemoryRead,           PAR16,PAR16,PAR32,PAR32,PAR8,                   0,0,0                 , 'memread');
  CreateOpCode(opUIFlush,              0,        0,0,0,0,0,0,0         , 'uiflush');
  CreateOpCode(opUIRead,               PAR8,SUBP,UI_READ_SUBP,      0,0,0,0,0             , 'uiread');
  CreateOpCode(opUIWrite,              PAR8,SUBP,UI_WRITE_SUBP,     0,0,0,0,0             , 'uiwrite');
  CreateOpCode(opUIButton,             PAR8,SUBP,UI_BUTTON_SUBP,    0,0,0,0,0             , 'uibutton');
  CreateOpCode(opUIDraw,               PAR8,SUBP,UI_DRAW_SUBP,      0,0,0,0,0             , 'uidraw');
  CreateOpCode(opTimerWait,            PAR32,PAR32,                 0,0,0,0,0,0           , 'timerwait');
  CreateOpCode(opTimerReady,           PAR32,    0,0,0,0,0,0,0         , 'timerready');
  CreateOpCode(opTimerRead,            PAR32,    0,0,0,0,0,0,0         , 'timerread');
  CreateOpCode(opBreakpoint0,          0,        0,0,0,0,0,0,0         , 'bp0');
  CreateOpCode(opBreakpoint1,          0,        0,0,0,0,0,0,0         , 'bp1');
  CreateOpCode(opBreakpoint2,          0,        0,0,0,0,0,0,0         , 'bp2');
  CreateOpCode(opBreakpoint3,          0,        0,0,0,0,0,0,0         , 'bp3');
  CreateOpCode(opBreakpointSet,        PAR16,PAR8,PAR32,            0,0,0,0,0             , 'bpset');
  CreateOpCode(opMath,                 PAR8,SUBP,MATH_SUBP,         0,0,0,0,0             , 'math');
  CreateOpCode(opRandom,               PAR16,PAR16,PAR16,           0,0,0,0,0             , 'random');
  CreateOpCode(opTimerReadUS,          PAR32,    0,0,0,0,0,0,0         , 'timerreadus');
  CreateOpCode(opKeepAlive,            PAR8,     0,0,0,0,0,0,0         , 'keepalive');
  CreateOpCode(opComRead,              PAR8,SUBP,COM_READ_SUBP,     0,0,0,0,0             , 'comread');
  CreateOpCode(opComWrite,             PAR8,SUBP,COM_WRITE_SUBP,    0,0,0,0,0             , 'comwrite');
  CreateOpCode(opSound,                PAR8,SUBP,SOUND_SUBP,        0,0,0,0,0             , 'sound');
  CreateOpCode(opSoundTest,            PAR8,     0,0,0,0,0,0,0         , 'soundtest');
  CreateOpCode(opSoundReady,           0,        0,0,0,0,0,0,0         , 'soundready');
  CreateOpCode(opInputSample,          PAR32,PAR16,PAR16,PAR8,PAR8,PAR8,PAR8,PARF         , 'insample');
  CreateOpCode(opInputDeviceList,      PAR8,PAR8,PAR8,              0,0,0,0,0             , 'indevlist');
  CreateOpCode(opInputDevice,          PAR8,SUBP,INPUT_SUBP,        0,0,0,0,0             , 'indevice');
  CreateOpCode(opInputRead,            PAR8,PAR8,PAR8,PAR8,PAR8,    0,0,0                 , 'inread');
  CreateOpCode(opInputReadSI,          PAR8,PAR8,PAR8,PAR8,PARF,    0,0,0                 , 'inreadsi');
  CreateOpCode(opInputTest,            PAR8,PAR8,PAR8,              0,0,0,0,0             , 'intest');
  CreateOpCode(opInputReady,           PAR8,PAR8,                   0,0,0,0,0,0           , 'inready');
  CreateOpCode(opInputReadext,         PAR8,PAR8,PAR8,PAR8,PAR8,PARNO,                 0,0                   , 'inreadext');
  CreateOpCode(opInputWrite,           PAR8,PAR8,PAR8,PAR8,         0,0,0,0               , 'inwrite');
  CreateOpCode(opOutputSetType,        PAR8,PAR8,PAR8,              0,0,0,0,0             , 'outsettype');
  CreateOpCode(opOutputReset,          PAR8,PAR8,                   0,0,0,0,0,0           , 'outreset');
  CreateOpCode(opOutputStop,           PAR8,PAR8,PAR8,              0,0,0,0,0             , 'outstop');
  CreateOpCode(opOutputSpeed,          PAR8,PAR8,PAR8,              0,0,0,0,0             , 'outspeed');
  CreateOpCode(opOutputPower,          PAR8,PAR8,PAR8,              0,0,0,0,0             , 'outpower');
  CreateOpCode(opOutputStart,          PAR8,PAR8,                   0,0,0,0,0,0           , 'outstart');
  CreateOpCode(opOutputPolarity,       PAR8,PAR8,PAR8,              0,0,0,0,0             , 'outpolarity');
  CreateOpCode(opOutputRead,           PAR8,PAR8,PAR8,PAR32,        0,0,0,0               , 'outread');
  CreateOpCode(opOutputReady,          PAR8,PAR8,                   0,0,0,0,0,0           , 'outready');
  CreateOpCode(opOutputTest,           PAR8,PAR8,PAR8,              0,0,0,0,0             , 'outtest');
  CreateOpCode(opOutputStepPower,      PAR8,PAR8,PAR8,PAR32,PAR32,PAR32,PAR8,          0  , 'outsteppower');
  CreateOpCode(opOutputTimePower,      PAR8,PAR8,PAR8,PAR32,PAR32,PAR32,PAR8,          0  , 'outtimepower');
  CreateOpCode(opOutputStepSpeed,      PAR8,PAR8,PAR8,PAR32,PAR32,PAR32,PAR8,          0  , 'outstepspeed');
  CreateOpCode(opOutputTimeSpeed,      PAR8,PAR8,PAR8,PAR32,PAR32,PAR32,PAR8,          0  , 'outtimespeed');
  CreateOpCode(opOutputStepSync,       PAR8,PAR8,PAR8,PAR16,PAR32,PAR8,                0,0                   , 'outstepsync');
  CreateOpCode(opOutputTimeSync,       PAR8,PAR8,PAR8,PAR16,PAR32,PAR8,                0,0                   , 'outtimesync');
  CreateOpCode(opOutputClearCount,     PAR8,PAR8,                   0,0,0,0,0,0           , 'outclearcount');
  CreateOpCode(opOutputGetCount,       PAR8,PAR8,PAR32,             0,0,0,0,0             , 'outgetcount');
  CreateOpCode(opOutputProgramStop,    0,        0,0,0,0,0,0,0         , 'outprgstop');
  CreateOpCode(opFile,                 PAR8,SUBP,FILE_SUBP,         0,0,0,0,0             , 'file');
  CreateOpCode(opArray,                PAR8,SUBP,ARRAY_SUBP,        0,0,0,0,0             , 'array');
  CreateOpCode(opArrayWrite,           PAR16,PAR32,PARV,            0,0,0,0,0             , 'arraywrite');
  CreateOpCode(opArrayRead,            PAR16,PAR32,PARV,            0,0,0,0,0             , 'arrayread');
  CreateOpCode(opArrayAppend,          PAR16,PARV,                  0,0,0,0,0,0           , 'arrayappend');
  CreateOpCode(opMemoryUsage,          PAR32,PAR32,                 0,0,0,0,0,0           , 'memusage');
  CreateOpCode(opFilename,             PAR8,SUBP,FILENAME_SUBP,     0,0,0,0,0             , 'filename');
  CreateOpCode(opRead1,                PAR8,PAR8,PAR8,              0,0,0,0,0             , 'read1');
  CreateOpCode(opRead2,                PAR16,PAR8,PAR16,            0,0,0,0,0             , 'read2');
  CreateOpCode(opRead4,                PAR32,PAR8,PAR32,            0,0,0,0,0             , 'read4');
  CreateOpCode(opReadF,                PARF,PAR8,PARF,              0,0,0,0,0             , 'readf');
  CreateOpCode(opWrite1,               PAR8,PAR8,PAR8,              0,0,0,0,0             , 'write1');
  CreateOpCode(opWrite2,               PAR16,PAR8,PAR16,            0,0,0,0,0             , 'write2');
  CreateOpCode(opWrite4,               PAR32,PAR8,PAR32,            0,0,0,0,0             , 'write4');
  CreateOpCode(opWriteF,               PARF,PAR8,PARF,              0,0,0,0,0             , 'writef');
  CreateOpCode(opComReady,             PAR8,PAR8,                   0,0,0,0,0,0           , 'comready');
  CreateOpCode(opComReadData,          PAR8,PAR8,PAR16,PAR8,        0,0,0,0               , 'comreaddata');
  CreateOpCode(opComWriteData,         PAR8,PAR8,PAR16,PAR8,        0,0,0,0               , 'comwritedata');
  CreateOpCode(opComGet,               PAR8,SUBP,COM_GET_SUBP,      0,0,0,0,0             , 'comget');
  CreateOpCode(opComSet,               PAR8,SUBP,COM_SET_SUBP,      0,0,0,0,0             , 'comset');
  CreateOpCode(opComTest,              PAR8,PAR8,PAR8,              0,0,0,0,0             , 'comtest');
  CreateOpCode(opComRemove,            PAR8,PAR8,                   0,0,0,0,0,0           , 'comremove');
  CreateOpCode(opComWriteFile,         PAR8,PAR8,PAR8,PAR8,         0,0,0,0               , 'comwritefile');
  CreateOpCode(opMailboxOpen,          PAR8,PAR8,PAR8,PAR8,PAR8,    0,0,0                 , 'mbopen');
  CreateOpCode(opMailboxWrite,         PAR8,PAR8,PAR8,PAR8,PARNO,   0,0,0                 , 'mbwrite');
  CreateOpCode(opMailboxRead,          PAR8,PAR8,PARNO,             0,0,0,0,0             , 'mbread');
  CreateOpCode(opMailboxTest,          PAR8,PAR8,                   0,0,0,0,0,0           , 'mbtest');
  CreateOpCode(opMailboxReady,         PAR8,     0,0,0,0,0,0,0         , 'mbready');
  CreateOpCode(opMailboxClose,         PAR8,     0,0,0,0,0,0,0         , 'mbclose');
  CreateOpCode(opTest,                 PAR8,SUBP,TEST_SUBP,          0,0,0,0,0             , 'test');
end;

procedure PopulateSubCodeNames;
begin
  SCName(PROGRAM_SUBP, PROG_INFO_OBJ_STOP, 'OBJ_STOP');
  SCName(PROGRAM_SUBP, PROG_INFO_OBJ_START, 'OBJ_START');
  SCName(PROGRAM_SUBP, PROG_INFO_GET_STATUS, 'GET_STATUS');
  SCName(PROGRAM_SUBP, PROG_INFO_GET_SPEED, 'GET_SPEED');
  SCName(PROGRAM_SUBP, PROG_INFO_GET_PRGRESULT, 'GET_PRGRESULT');
  SCName(PROGRAM_SUBP, PROG_INFO_SET_INSTR, 'SET_INSTR');
  SCName(FILE_SUBP, FILE_OPEN_APPEND, 'OPEN_APPEND');
  SCName(FILE_SUBP, FILE_OPEN_READ, 'OPEN_READ');
  SCName(FILE_SUBP, FILE_OPEN_WRITE, 'OPEN_WRITE');
  SCName(FILE_SUBP, FILE_READ_VALUE, 'READ_VALUE');
  SCName(FILE_SUBP, FILE_WRITE_VALUE, 'WRITE_VALUE');
  SCName(FILE_SUBP, FILE_READ_TEXT, 'READ_TEXT');
  SCName(FILE_SUBP, FILE_WRITE_TEXT, 'WRITE_TEXT');
  SCName(FILE_SUBP, FILE_CLOSE, 'CLOSE');
  SCName(FILE_SUBP, FILE_LOAD_IMAGE, 'LOAD_IMAGE');
  SCName(FILE_SUBP, FILE_GET_HANDLE, 'GET_HANDLE');
  SCName(FILE_SUBP, FILE_MAKE_FOLDER, 'MAKE_FOLDER');
  SCName(FILE_SUBP, FILE_GET_LOG_NAME, 'GET_LOG_NAME');
  SCName(FILE_SUBP, FILE_GET_POOL, 'GET_POOL');
  SCName(FILE_SUBP, FILE_GET_FOLDERS, 'GET_FOLDERS');
  SCName(FILE_SUBP, FILE_GET_SUBFOLDER_NAME, 'GET_SUBFOLDER_NAME');
  SCName(FILE_SUBP, FILE_WRITE_LOG, 'WRITE_LOG');
  SCName(FILE_SUBP, FILE_CLOSE_LOG, 'CLOSE_LOG');
  SCName(FILE_SUBP, FILE_SET_LOG_SYNC_TIME, 'SET_LOG_SYNC_TIME');
  SCName(FILE_SUBP, FILE_DEL_SUBFOLDER, 'DEL_SUBFOLDER');
  SCName(FILE_SUBP, FILE_GET_LOG_SYNC_TIME, 'GET_LOG_SYNC_TIME');
  SCName(FILE_SUBP, FILE_GET_IMAGE, 'GET_IMAGE');
  SCName(FILE_SUBP, FILE_GET_ITEM, 'GET_ITEM');
  SCName(FILE_SUBP, FILE_GET_CACHE_FILES, 'GET_CACHE_FILES');
  SCName(FILE_SUBP, FILE_GET_CACHE_FILE, 'GET_CACHE_FILE');
  SCName(FILE_SUBP, FILE_PUT_CACHE_FILE, 'PUT_CACHE_FILE');
  SCName(FILE_SUBP, FILE_DEL_CACHE_FILE, 'DEL_CACHE_FILE');
  SCName(FILE_SUBP, FILE_OPEN_LOG, 'OPEN_LOG');
  SCName(FILE_SUBP, FILE_READ_BYTES, 'READ_BYTES');
  SCName(FILE_SUBP, FILE_WRITE_BYTES, 'WRITE_BYTES');
  SCName(FILE_SUBP, FILE_REMOVE, 'REMOVE');
  SCName(FILE_SUBP, FILE_MOVE, 'MOVE');
  SCName(ARRAY_SUBP, ARRAY_CREATE8, 'CREATE8');
  SCName(ARRAY_SUBP, ARRAY_CREATE16, 'CREATE16');
  SCName(ARRAY_SUBP, ARRAY_CREATE32, 'CREATE32');
  SCName(ARRAY_SUBP, ARRAY_CREATEF, 'CREATEF');
  SCName(ARRAY_SUBP, ARRAY_RESIZE, 'RESIZE');
  SCName(ARRAY_SUBP, ARRAY_DELETE, 'DELETE');
  SCName(ARRAY_SUBP, ARRAY_FILL, 'FILL');
  SCName(ARRAY_SUBP, ARRAY_COPY, 'COPY');
  SCName(ARRAY_SUBP, ARRAY_INIT8, 'INIT8');
  SCName(ARRAY_SUBP, ARRAY_INIT16, 'INIT16');
  SCName(ARRAY_SUBP, ARRAY_INIT32, 'INIT32');
  SCName(ARRAY_SUBP, ARRAY_INITF, 'INITF');
  SCName(ARRAY_SUBP, ARRAY_SIZE, 'SIZE');
  SCName(ARRAY_SUBP, ARRAY_READ_CONTENT, 'READ_CONTENT');
  SCName(ARRAY_SUBP, ARRAY_WRITE_CONTENT, 'WRITE_CONTENT');
  SCName(ARRAY_SUBP, ARRAY_READ_SIZE, 'READ_SIZE');
  SCName(FILENAME_SUBP, FILENAME_EXIST, 'EXIST');
  SCName(FILENAME_SUBP, FILENAME_TOTALSIZE, 'TOTALSIZE');
  SCName(FILENAME_SUBP, FILENAME_SPLIT, 'SPLIT');
  SCName(FILENAME_SUBP, FILENAME_MERGE, 'MERGE');
  SCName(FILENAME_SUBP, FILENAME_CHECK, 'CHECK');
  SCName(FILENAME_SUBP, FILENAME_PACK, 'PACK');
  SCName(FILENAME_SUBP, FILENAME_UNPACK, 'UNPACK');
  SCName(FILENAME_SUBP, FILENAME_GET_FOLDERNAME, 'GET_FOLDERNAME');
  SCName(VM_SUBP, INFO_SET_ERROR, 'SET_ERROR');
  SCName(VM_SUBP, INFO_GET_ERROR, 'GET_ERROR');
  SCName(VM_SUBP, INFO_ERRORTEXT, 'ERRORTEXT');
  SCName(VM_SUBP, INFO_GET_VOLUME, 'GET_VOLUME');
  SCName(VM_SUBP, INFO_SET_VOLUME, 'SET_VOLUME');
  SCName(VM_SUBP, INFO_GET_MINUTES, 'GET_MINUTES');
  SCName(VM_SUBP, INFO_SET_MINUTES, 'SET_MINUTES');
  SCName(TEST_SUBP, TEST_OPEN, 'OPEN');
  SCName(TEST_SUBP, TEST_CLOSE, 'CLOSE');
  SCName(TEST_SUBP, TEST_READ_PINS, 'READ_PINS');
  SCName(TEST_SUBP, TEST_WRITE_PINS, 'WRITE_PINS');
  SCName(TEST_SUBP, TEST_READ_ADC, 'READ_ADC');
  SCName(TEST_SUBP, TEST_WRITE_UART, 'WRITE_UART');
  SCName(TEST_SUBP, TEST_READ_UART, 'READ_UART');
  SCName(TEST_SUBP, TEST_ENABLE_UART, 'ENABLE_UART');
  SCName(TEST_SUBP, TEST_DISABLE_UART, 'DISABLE_UART');
  SCName(TEST_SUBP, TEST_ACCU_SWITCH, 'ACCU_SWITCH');
  SCName(TEST_SUBP, TEST_BOOT_MODE2, 'BOOT_MODE2');
  SCName(TEST_SUBP, TEST_POLL_MODE2, 'POLL_MODE2');
  SCName(TEST_SUBP, TEST_CLOSE_MODE2, 'CLOSE_MODE2');
  SCName(TEST_SUBP, TEST_RAM_CHECK, 'RAM_CHECK');
  SCName(STRING_SUBP, STRING_GET_SIZE, 'GET_SIZE');
  SCName(STRING_SUBP, STRING_ADD, 'ADD');
  SCName(STRING_SUBP, STRING_COMPARE, 'COMPARE');
  SCName(STRING_SUBP, STRING_DUPLICATE, 'DUPLICATE');
  SCName(STRING_SUBP, STRING_VALUE_TO_STRING, 'VALUE_TO_STRING');
  SCName(STRING_SUBP, STRING_STRING_TO_VALUE, 'STRING_TO_VALUE');
  SCName(STRING_SUBP, STRING_STRIP, 'STRIP');
  SCName(STRING_SUBP, STRING_NUMBER_TO_STRING, 'NUMBER_TO_STRING');
  SCName(STRING_SUBP, STRING_SUB, 'SUB');
  SCName(STRING_SUBP, STRING_VALUE_FORMATTED, 'VALUE_FORMATTED');
  SCName(STRING_SUBP, STRING_NUMBER_FORMATTED, 'NUMBER_FORMATTED');
  SCName(UI_READ_SUBP, UI_READ_GET_VBATT, 'GET_VBATT');
  SCName(UI_READ_SUBP, UI_READ_GET_IBATT, 'GET_IBATT');
  SCName(UI_READ_SUBP, UI_READ_GET_OS_VERS, 'GET_OS_VERS');
  SCName(UI_READ_SUBP, UI_READ_GET_EVENT, 'GET_EVENT');
  SCName(UI_READ_SUBP, UI_READ_GET_TBATT, 'GET_TBATT');
  SCName(UI_READ_SUBP, UI_READ_GET_IINT, 'GET_IINT');
  SCName(UI_READ_SUBP, UI_READ_GET_IMOTOR, 'GET_IMOTOR');
  SCName(UI_READ_SUBP, UI_READ_GET_STRING, 'GET_STRING');
  SCName(UI_READ_SUBP, UI_READ_KEY, 'KEY');
  SCName(UI_READ_SUBP, UI_READ_GET_SHUTDOWN, 'GET_SHUTDOWN');
  SCName(UI_READ_SUBP, UI_READ_GET_WARNING, 'GET_WARNING');
  SCName(UI_READ_SUBP, UI_READ_GET_LBATT, 'GET_LBATT');
  SCName(UI_READ_SUBP, UI_READ_GET_ADDRESS, 'GET_ADDRESS');
  SCName(UI_READ_SUBP, UI_READ_GET_CODE, 'GET_CODE');
  SCName(UI_READ_SUBP, UI_READ_TEXTBOX_READ, 'TEXTBOX_READ');
  SCName(UI_READ_SUBP, UI_READ_GET_HW_VERS, 'GET_HW_VERS');
  SCName(UI_READ_SUBP, UI_READ_GET_FW_VERS, 'GET_FW_VERS');
  SCName(UI_READ_SUBP, UI_READ_GET_FW_BUILD, 'GET_FW_BUILD');
  SCName(UI_READ_SUBP, UI_READ_GET_OS_BUILD, 'GET_OS_BUILD');
  SCName(UI_READ_SUBP, UI_READ_GET_VERSION, 'GET_VERSION');
  SCName(UI_READ_SUBP, UI_READ_GET_IP, 'GET_IP');
  SCName(UI_READ_SUBP, UI_READ_GET_SDCARD, 'GET_SDCARD');
  SCName(UI_READ_SUBP, UI_READ_GET_USBSTICK, 'GET_USBSTICK');
  SCName(UI_WRITE_SUBP, UI_WRITE_WRITE_FLUSH, 'WRITE_FLUSH');
  SCName(UI_WRITE_SUBP, UI_WRITE_FLOATVALUE, 'FLOATVALUE');
  SCName(UI_WRITE_SUBP, UI_WRITE_STAMP, 'STAMP');
  SCName(UI_WRITE_SUBP, UI_WRITE_PUT_STRING, 'PUT_STRING');
  SCName(UI_WRITE_SUBP, UI_WRITE_CODE, 'CODE');
  SCName(UI_WRITE_SUBP, UI_WRITE_DOWNLOAD_END, 'DOWNLOAD_END');
  SCName(UI_WRITE_SUBP, UI_WRITE_SCREEN_BLOCK, 'SCREEN_BLOCK');
  SCName(UI_WRITE_SUBP, UI_WRITE_TEXTBOX_APPEND, 'TEXTBOX_APPEND');
  SCName(UI_WRITE_SUBP, UI_WRITE_SET_BUSY, 'SET_BUSY');
  SCName(UI_WRITE_SUBP, UI_WRITE_VALUE8, 'VALUE8');
  SCName(UI_WRITE_SUBP, UI_WRITE_VALUE16, 'VALUE16');
  SCName(UI_WRITE_SUBP, UI_WRITE_VALUE32, 'VALUE32');
  SCName(UI_WRITE_SUBP, UI_WRITE_VALUEF, 'VALUEF');
  SCName(UI_WRITE_SUBP, UI_WRITE_INIT_RUN, 'INIT_RUN');
  SCName(UI_WRITE_SUBP, UI_WRITE_UPDATE_RUN, 'UPDATE_RUN');
  SCName(UI_WRITE_SUBP, UI_WRITE_LED, 'LED');
  SCName(UI_WRITE_SUBP, UI_WRITE_POWER, 'POWER');
  SCName(UI_WRITE_SUBP, UI_WRITE_TERMINAL, 'TERMINAL');
  SCName(UI_WRITE_SUBP, UI_WRITE_GRAPH_SAMPLE, 'GRAPH_SAMPLE');
  SCName(UI_WRITE_SUBP, UI_WRITE_SET_TESTPIN, 'SET_TESTPIN');
  SCName(UI_DRAW_SUBP, UI_DRAW_UPDATE, 'UPDATE');
  SCName(UI_DRAW_SUBP, UI_DRAW_CLEAN, 'CLEAN');
  SCName(UI_DRAW_SUBP, UI_DRAW_FILLRECT, 'FILLRECT');
  SCName(UI_DRAW_SUBP, UI_DRAW_RECT, 'RECT');
  SCName(UI_DRAW_SUBP, UI_DRAW_PIXEL, 'PIXEL');
  SCName(UI_DRAW_SUBP, UI_DRAW_LINE, 'LINE');
  SCName(UI_DRAW_SUBP, UI_DRAW_CIRCLE, 'CIRCLE');
  SCName(UI_DRAW_SUBP, UI_DRAW_TEXT, 'TEXT');
  SCName(UI_DRAW_SUBP, UI_DRAW_ICON, 'ICON');
  SCName(UI_DRAW_SUBP, UI_DRAW_PICTURE, 'PICTURE');
  SCName(UI_DRAW_SUBP, UI_DRAW_VALUE, 'VALUE');
  SCName(UI_DRAW_SUBP, UI_DRAW_NOTIFICATION, 'NOTIFICATION');
  SCName(UI_DRAW_SUBP, UI_DRAW_QUESTION, 'QUESTION');
  SCName(UI_DRAW_SUBP, UI_DRAW_KEYBOARD, 'KEYBOARD');
  SCName(UI_DRAW_SUBP, UI_DRAW_BROWSE, 'BROWSE');
  SCName(UI_DRAW_SUBP, UI_DRAW_VERTBAR, 'VERTBAR');
  SCName(UI_DRAW_SUBP, UI_DRAW_INVERSERECT, 'INVERSERECT');
  SCName(UI_DRAW_SUBP, UI_DRAW_SELECT_FONT, 'SELECT_FONT');
  SCName(UI_DRAW_SUBP, UI_DRAW_TOPLINE, 'TOPLINE');
  SCName(UI_DRAW_SUBP, UI_DRAW_FILLWINDOW, 'FILLWINDOW');
  SCName(UI_DRAW_SUBP, UI_DRAW_SCROLL, 'SCROLL');
  SCName(UI_DRAW_SUBP, UI_DRAW_DOTLINE, 'DOTLINE');
  SCName(UI_DRAW_SUBP, UI_DRAW_VIEW_VALUE, 'VIEW_VALUE');
  SCName(UI_DRAW_SUBP, UI_DRAW_VIEW_UNIT, 'VIEW_UNIT');
  SCName(UI_DRAW_SUBP, UI_DRAW_FILLCIRCLE, 'FILLCIRCLE');
  SCName(UI_DRAW_SUBP, UI_DRAW_STORE, 'STORE');
  SCName(UI_DRAW_SUBP, UI_DRAW_RESTORE, 'RESTORE');
  SCName(UI_DRAW_SUBP, UI_DRAW_ICON_QUESTION, 'ICON_QUESTION');
  SCName(UI_DRAW_SUBP, UI_DRAW_BMPFILE, 'BMPFILE');
  SCName(UI_DRAW_SUBP, UI_DRAW_GRAPH_SETUP, 'GRAPH_SETUP');
  SCName(UI_DRAW_SUBP, UI_DRAW_GRAPH_DRAW, 'GRAPH_DRAW');
  SCName(UI_DRAW_SUBP, UI_DRAW_POPUP, 'POPUP');
  SCName(UI_DRAW_SUBP, UI_DRAW_TEXTBOX, 'TEXTBOX');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_SHORTPRESS, 'SHORTPRESS');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_LONGPRESS, 'LONGPRESS');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_FLUSH, 'FLUSH');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_WAIT_FOR_PRESS, 'WAIT_FOR_PRESS');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_PRESS, 'PRESS');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_RELEASE, 'RELEASE');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_GET_HORZ, 'GET_HORZ');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_GET_VERT, 'GET_VERT');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_PRESSED, 'PRESSED');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_SET_BACK_BLOCK, 'SET_BACK_BLOCK');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_GET_BACK_BLOCK, 'GET_BACK_BLOCK');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_TESTSHORTPRESS, 'TESTSHORTPRESS');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_TESTLONGPRESS, 'TESTLONGPRESS');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_GET_BUMBED, 'GET_BUMBED');
  SCName(UI_BUTTON_SUBP, UI_BUTTON_GET_CLICK, 'GET_CLICK');
  SCName(COM_READ_SUBP, COM_READ_COMMAND, 'COMMAND');
  SCName(COM_WRITE_SUBP, COM_WRITE_REPLY, 'REPLY');
  SCName(SOUND_SUBP, SOUND_BREAK, 'BREAK');
  SCName(SOUND_SUBP, SOUND_TONE, 'TONE');
  SCName(SOUND_SUBP, SOUND_PLAY, 'PLAY');
  SCName(SOUND_SUBP, SOUND_REPEAT, 'REPEAT');
  SCName(SOUND_SUBP, SOUND_SERVICE, 'SERVICE');
  SCName(INPUT_SUBP, INPUT_GET_TYPEMODE, 'GET_TYPEMODE');
  SCName(INPUT_SUBP, INPUT_GET_CONNECTION, 'GET_CONNECTION');
  SCName(INPUT_SUBP, INPUT_GET_NAME, 'GET_NAME');
  SCName(INPUT_SUBP, INPUT_GET_SYMBOL, 'GET_SYMBOL');
  SCName(INPUT_SUBP, INPUT_GET_FORMAT, 'GET_FORMAT');
  SCName(INPUT_SUBP, INPUT_GET_RAW, 'GET_RAW');
  SCName(INPUT_SUBP, INPUT_GET_MODENAME, 'GET_MODENAME');
  SCName(INPUT_SUBP, INPUT_SET_RAW, 'SET_RAW');
  SCName(INPUT_SUBP, INPUT_GET_FIGURES, 'GET_FIGURES');
  SCName(INPUT_SUBP, INPUT_GET_CHANGES, 'GET_CHANGES');
  SCName(INPUT_SUBP, INPUT_CLR_CHANGES, 'CLR_CHANGES');
  SCName(INPUT_SUBP, INPUT_READY_PCT, 'READY_PCT');
  SCName(INPUT_SUBP, INPUT_READY_RAW, 'READY_RAW');
  SCName(INPUT_SUBP, INPUT_READY_SI, 'READY_SI');
  SCName(INPUT_SUBP, INPUT_GET_MINMAX, 'GET_MINMAX');
  SCName(INPUT_SUBP, INPUT_CAL_MINMAX, 'CAL_MINMAX');
  SCName(INPUT_SUBP, INPUT_CAL_DEFAULT, 'CAL_DEFAULT');
  SCName(INPUT_SUBP, INPUT_CAL_MIN, 'CAL_MIN');
  SCName(INPUT_SUBP, INPUT_CAL_MAX, 'CAL_MAX');
  SCName(INPUT_SUBP, INPUT_GET_BUMPS, 'GET_BUMPS');
  SCName(INPUT_SUBP, INPUT_SETUP, 'SETUP');
  SCName(INPUT_SUBP, INPUT_CLR_ALL, 'CLR_ALL');
  SCName(INPUT_SUBP, INPUT_STOP_ALL, 'STOP_ALL');
  SCName(MATH_SUBP, MATH_EXP, 'EXP');
  SCName(MATH_SUBP, MATH_MOD, 'MOD');
  SCName(MATH_SUBP, MATH_FLOOR, 'FLOOR');
  SCName(MATH_SUBP, MATH_CEIL, 'CEIL');
  SCName(MATH_SUBP, MATH_ROUND, 'ROUND');
  SCName(MATH_SUBP, MATH_ABS, 'ABS');
  SCName(MATH_SUBP, MATH_NEGATE, 'NEGATE');
  SCName(MATH_SUBP, MATH_SQRT, 'SQRT');
  SCName(MATH_SUBP, MATH_LOG, 'LOG');
  SCName(MATH_SUBP, MATH_LN, 'LN');
  SCName(MATH_SUBP, MATH_SIN, 'SIN');
  SCName(MATH_SUBP, MATH_COS, 'COS');
  SCName(MATH_SUBP, MATH_TAN, 'TAN');
  SCName(MATH_SUBP, MATH_ASIN, 'ASIN');
  SCName(MATH_SUBP, MATH_ACOS, 'ACOS');
  SCName(MATH_SUBP, MATH_ATAN, 'ATAN');
  SCName(MATH_SUBP, MATH_MOD8, 'MOD8');
  SCName(MATH_SUBP, MATH_MOD16, 'MOD16');
  SCName(MATH_SUBP, MATH_MOD32, 'MOD32');
  SCName(MATH_SUBP, MATH_POW, 'POW');
  SCName(MATH_SUBP, MATH_TRUNC, 'TRUNC');
  SCName(COM_GET_SUBP, COM_GET_ON_OFF, 'GET_ON_OFF');
  SCName(COM_GET_SUBP, COM_GET_VISIBLE, 'GET_VISIBLE');
  SCName(COM_GET_SUBP, COM_GET_RESULT, 'GET_RESULT');
  SCName(COM_GET_SUBP, COM_GET_PIN, 'GET_PIN');
  SCName(COM_GET_SUBP, COM_SEARCH_ITEMS, 'SEARCH_ITEMS');
  SCName(COM_GET_SUBP, COM_SEARCH_ITEM, 'SEARCH_ITEM');
  SCName(COM_GET_SUBP, COM_FAVOUR_ITEMS, 'FAVOUR_ITEMS');
  SCName(COM_GET_SUBP, COM_FAVOUR_ITEM, 'FAVOUR_ITEM');
  SCName(COM_GET_SUBP, COM_GET_ID, 'GET_ID');
  SCName(COM_GET_SUBP, COM_GET_BRICKNAME, 'GET_BRICKNAME');
  SCName(COM_GET_SUBP, COM_GET_NETWORK, 'GET_NETWORK');
  SCName(COM_GET_SUBP, COM_GET_PRESENT, 'GET_PRESENT');
  SCName(COM_GET_SUBP, COM_GET_ENCRYPT, 'GET_ENCRYPT');
  SCName(COM_GET_SUBP, COM_CONNEC_ITEMS, 'CONNEC_ITEMS');
  SCName(COM_GET_SUBP, COM_CONNEC_ITEM, 'CONNEC_ITEM');
  SCName(COM_GET_SUBP, COM_GET_INCOMING, 'GET_INCOMING');
  SCName(COM_GET_SUBP, COM_GET_MODE2, 'GET_MODE2');
  SCName(COM_SET_SUBP, COM_SET_ON_OFF, 'SET_ON_OFF');
  SCName(COM_SET_SUBP, COM_SET_VISIBLE, 'SET_VISIBLE');
  SCName(COM_SET_SUBP, COM_SET_SEARCH, 'SET_SEARCH');
  SCName(COM_SET_SUBP, COM_SET_PIN, 'SET_PIN');
  SCName(COM_SET_SUBP, COM_SET_PASSKEY, 'SET_PASSKEY');
  SCName(COM_SET_SUBP, COM_SET_CONNECTION, 'SET_CONNECTION');
  SCName(COM_SET_SUBP, COM_SET_BRICKNAME, 'SET_BRICKNAME');
  SCName(COM_SET_SUBP, COM_SET_MOVEUP, 'SET_MOVEUP');
  SCName(COM_SET_SUBP, COM_SET_MOVEDOWN, 'SET_MOVEDOWN');
  SCName(COM_SET_SUBP, COM_SET_ENCRYPT, 'SET_ENCRYPT');
  SCName(COM_SET_SUBP, COM_SET_SSID, 'SET_SSID');
  SCName(COM_SET_SUBP, COM_SET_MODE2, 'SET_MODE2');
end;

procedure PopulateSubCodes;
begin
  // fill in sub code name 2d array
  PopulateSubCodeNames;

  // now fill in the sub code 2d array
  CreateSubCode(   PROGRAM_SUBP,           PROG_INFO_OBJ_STOP,      PAR16,PAR16,                 0,0,0,0,0,0           );
  CreateSubCode(   PROGRAM_SUBP,           PROG_INFO_OBJ_START,     PAR16,PAR16,                 0,0,0,0,0,0           );
  CreateSubCode(   PROGRAM_SUBP,           PROG_INFO_GET_STATUS,    PAR16,PAR8,                  0,0,0,0,0,0           );
  CreateSubCode(   PROGRAM_SUBP,           PROG_INFO_GET_SPEED,     PAR16,PAR32,                 0,0,0,0,0,0           );
  CreateSubCode(   PROGRAM_SUBP,           PROG_INFO_GET_PRGRESULT, PAR16,PAR8,                  0,0,0,0,0,0           );
  CreateSubCode(   PROGRAM_SUBP,           PROG_INFO_SET_INSTR,     PAR16,    0,0,0,0,0,0,0         );
  CreateSubCode(   FILE_SUBP,              FILE_OPEN_APPEND,        PAR8,PAR16,                  0,0,0,0,0,0           );
  CreateSubCode(   FILE_SUBP,              FILE_OPEN_READ,          PAR8,PAR16,PAR32,            0,0,0,0,0             );
  CreateSubCode(   FILE_SUBP,              FILE_OPEN_WRITE,         PAR8,PAR16,                  0,0,0,0,0,0           );
  CreateSubCode(   FILE_SUBP,              FILE_READ_VALUE,         PAR16,PAR8,PARF,             0,0,0,0,0             );
  CreateSubCode(   FILE_SUBP,              FILE_WRITE_VALUE,        PAR16,PAR8,PARF,PAR8,PAR8,   0,0,0                 );
  CreateSubCode(   FILE_SUBP,              FILE_READ_TEXT,          PAR16,PAR8,PAR16,PAR8,       0,0,0,0               );
  CreateSubCode(   FILE_SUBP,              FILE_WRITE_TEXT,         PAR16,PAR8,PAR8,             0,0,0,0,0             );
  CreateSubCode(   FILE_SUBP,              FILE_CLOSE,              PAR16,    0,0,0,0,0,0,0         );
  CreateSubCode(   FILE_SUBP,              FILE_LOAD_IMAGE,         PAR16,PAR8,PAR32,PAR32,      0,0,0,0               );
  CreateSubCode(   FILE_SUBP,              FILE_GET_HANDLE,         PAR8,PAR16,PAR8,             0,0,0,0,0             );
  CreateSubCode(   FILE_SUBP,              FILE_MAKE_FOLDER,        PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   FILE_SUBP,              FILE_GET_LOG_NAME,       PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   FILE_SUBP,              FILE_GET_POOL,           PAR32,PAR16,PAR32,           0,0,0,0,0             );
  CreateSubCode(   FILE_SUBP,              FILE_GET_FOLDERS,        PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   FILE_SUBP,              FILE_GET_SUBFOLDER_NAME, PAR8,PAR8,PAR8,PAR8,         0,0,0,0               );
  CreateSubCode(   FILE_SUBP,              FILE_WRITE_LOG,          PAR16,PAR32,PAR8,PARF,       0,0,0,0               );
  CreateSubCode(   FILE_SUBP,              FILE_CLOSE_LOG,          PAR16,PAR8,                  0,0,0,0,0,0           );
  CreateSubCode(   FILE_SUBP,              FILE_SET_LOG_SYNC_TIME,  PAR32,PAR32,                 0,0,0,0,0,0           );
  CreateSubCode(   FILE_SUBP,              FILE_DEL_SUBFOLDER,      PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   FILE_SUBP,              FILE_GET_LOG_SYNC_TIME,  PAR32,PAR32,                 0,0,0,0,0,0           );
  CreateSubCode(   FILE_SUBP,              FILE_GET_IMAGE,          PAR8,PAR16,PAR8,PAR32,       0,0,0,0               );
  CreateSubCode(   FILE_SUBP,              FILE_GET_ITEM,           PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   FILE_SUBP,              FILE_GET_CACHE_FILES,    PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   FILE_SUBP,              FILE_GET_CACHE_FILE,     PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   FILE_SUBP,              FILE_PUT_CACHE_FILE,     PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   FILE_SUBP,              FILE_DEL_CACHE_FILE,     PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   FILE_SUBP,              FILE_OPEN_LOG,           PAR8,PAR32,PAR32,PAR32,PAR32,PAR32,PAR8,PAR16      );
  CreateSubCode(   FILE_SUBP,              FILE_READ_BYTES,         PAR16,PAR16,PAR8,            0,0,0,0,0             );
  CreateSubCode(   FILE_SUBP,              FILE_WRITE_BYTES,        PAR16,PAR16,PAR8,            0,0,0,0,0             );
  CreateSubCode(   FILE_SUBP,              FILE_REMOVE,             PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   FILE_SUBP,              FILE_MOVE,               PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_CREATE8,           PAR32,PAR16,                 0,0,0,0,0,0           );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_CREATE16,          PAR32,PAR16,                 0,0,0,0,0,0           );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_CREATE32,          PAR32,PAR16,                 0,0,0,0,0,0           );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_CREATEF,           PAR32,PAR16,                 0,0,0,0,0,0           );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_RESIZE,            PAR16,PAR32,                 0,0,0,0,0,0           );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_DELETE,            PAR16,    0,0,0,0,0,0,0         );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_FILL,              PAR16,PARV,                  0,0,0,0,0,0           );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_COPY,              PAR16,PAR16,                 0,0,0,0,0,0           );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_INIT8,             PAR16,PAR32,PAR32,PARVALUES,PAR8,               0,0,0                 );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_INIT16,            PAR16,PAR32,PAR32,PARVALUES,PAR16,              0,0,0                 );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_INIT32,            PAR16,PAR32,PAR32,PARVALUES,PAR32,              0,0,0                 );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_INITF,             PAR16,PAR32,PAR32,PARVALUES,PARF,               0,0,0                 );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_SIZE,              PAR16,PAR32,                 0,0,0,0,0,0           );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_READ_CONTENT,      PAR16,PAR16,PAR32,PAR32,PAR8,                   0,0,0                 );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_WRITE_CONTENT,     PAR16,PAR16,PAR32,PAR32,PAR8,                   0,0,0                 );
  CreateSubCode(   ARRAY_SUBP,             ARRAY_READ_SIZE,         PAR16,PAR16,PAR32,           0,0,0,0,0             );
  CreateSubCode(   FILENAME_SUBP,          FILENAME_EXIST,          PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   FILENAME_SUBP,          FILENAME_TOTALSIZE,      PAR8,PAR32,PAR32,            0,0,0,0,0             );
  CreateSubCode(   FILENAME_SUBP,          FILENAME_SPLIT,          PAR8,PAR8,PAR8,PAR8,PAR8,    0,0,0                 );
  CreateSubCode(   FILENAME_SUBP,          FILENAME_MERGE,          PAR8,PAR8,PAR8,PAR8,PAR8,    0,0,0                 );
  CreateSubCode(   FILENAME_SUBP,          FILENAME_CHECK,          PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   FILENAME_SUBP,          FILENAME_PACK,           PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   FILENAME_SUBP,          FILENAME_UNPACK,         PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   FILENAME_SUBP,          FILENAME_GET_FOLDERNAME, PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   VM_SUBP,                INFO_SET_ERROR,          PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   VM_SUBP,                INFO_GET_ERROR,          PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   VM_SUBP,                INFO_ERRORTEXT,          PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   VM_SUBP,                INFO_GET_VOLUME,         PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   VM_SUBP,                INFO_SET_VOLUME,         PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   VM_SUBP,                INFO_GET_MINUTES,        PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   VM_SUBP,                INFO_SET_MINUTES,        PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   TEST_SUBP,              TEST_OPEN,                0,        0,0,0,0,0,0,0         );
  CreateSubCode(   TEST_SUBP,              TEST_CLOSE,               0,        0,0,0,0,0,0,0         );
  CreateSubCode(   TEST_SUBP,              TEST_READ_PINS,           PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   TEST_SUBP,              TEST_WRITE_PINS,          PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   TEST_SUBP,              TEST_READ_ADC,            PAR8,PAR16,                  0,0,0,0,0,0           );
  CreateSubCode(   TEST_SUBP,              TEST_WRITE_UART,          PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   TEST_SUBP,              TEST_READ_UART,           PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   TEST_SUBP,              TEST_ENABLE_UART,         PAR32,    0,0,0,0,0,0,0         );
  CreateSubCode(   TEST_SUBP,              TEST_DISABLE_UART,        0,        0,0,0,0,0,0,0         );
  CreateSubCode(   TEST_SUBP,              TEST_ACCU_SWITCH,         PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   TEST_SUBP,              TEST_BOOT_MODE2,          0,        0,0,0,0,0,0,0         );
  CreateSubCode(   TEST_SUBP,              TEST_POLL_MODE2,          PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   TEST_SUBP,              TEST_CLOSE_MODE2,         0,        0,0,0,0,0,0,0         );
  CreateSubCode(   TEST_SUBP,              TEST_RAM_CHECK,           PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   STRING_SUBP,            STRING_GET_SIZE,         PAR8,PAR16,                  0,0,0,0,0,0           );
  CreateSubCode(   STRING_SUBP,            STRING_ADD,              PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   STRING_SUBP,            STRING_COMPARE,          PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   STRING_SUBP,            STRING_DUPLICATE,        PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   STRING_SUBP,            STRING_VALUE_TO_STRING,  PARF,PAR8,PAR8,PAR8,         0,0,0,0               );
  CreateSubCode(   STRING_SUBP,            STRING_STRING_TO_VALUE,  PAR8,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   STRING_SUBP,            STRING_STRIP,            PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   STRING_SUBP,            STRING_NUMBER_TO_STRING, PAR16,PAR8,PAR8,             0,0,0,0,0             );
  CreateSubCode(   STRING_SUBP,            STRING_SUB,              PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   STRING_SUBP,            STRING_VALUE_FORMATTED,  PARF,PAR8,PAR8,PAR8,         0,0,0,0               );
  CreateSubCode(   STRING_SUBP,            STRING_NUMBER_FORMATTED, PAR32,PAR8,PAR8,PAR8,        0,0,0,0               );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_VBATT,       PARF,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_IBATT,       PARF,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_OS_VERS,     PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_EVENT,       PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_TBATT,       PARF,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_IINT,        PARF,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_IMOTOR,      PARF,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_STRING,      PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_KEY,             PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_SHUTDOWN,    PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_WARNING,     PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_LBATT,       PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_ADDRESS,     PAR32,    0,0,0,0,0,0,0         );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_CODE,        PAR32,PAR32,PAR32,PAR8,      0,0,0,0               );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_TEXTBOX_READ,    PAR8,PAR32,PAR8,PAR8,PAR16,PAR8,                0,0                   );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_HW_VERS,     PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_FW_VERS,     PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_FW_BUILD,    PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_OS_BUILD,    PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_VERSION,     PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_IP,          PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_SDCARD,      PAR8,PAR32,PAR32,            0,0,0,0,0             );
  CreateSubCode(   UI_READ_SUBP,           UI_READ_GET_USBSTICK,    PAR8,PAR32,PAR32,            0,0,0,0,0             );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_WRITE_FLUSH,    0,        0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_FLOATVALUE,     PARF,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_STAMP,          PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_PUT_STRING,     PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_CODE,           PAR8,PAR32,                  0,0,0,0,0,0           );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_DOWNLOAD_END,   0,        0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_SCREEN_BLOCK,   PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_TEXTBOX_APPEND, PAR8,PAR32,PAR8,PAR8,        0,0,0,0               );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_SET_BUSY,       PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_VALUE8,         PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_VALUE16,        PAR16,    0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_VALUE32,        PAR32,    0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_VALUEF,         PARF,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_INIT_RUN,       0,        0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_UPDATE_RUN,     0,        0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_LED,            PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_POWER,          PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_TERMINAL,       PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_GRAPH_SAMPLE,   0,        0,0,0,0,0,0,0         );
  CreateSubCode(   UI_WRITE_SUBP,          UI_WRITE_SET_TESTPIN,    PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_UPDATE,          0,        0,0,0,0,0,0,0         );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_CLEAN,           0,        0,0,0,0,0,0,0         );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_FILLRECT,        PAR8,PAR16,PAR16,PAR16,PAR16,                   0,0,0                 );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_RECT,            PAR8,PAR16,PAR16,PAR16,PAR16,                   0,0,0                 );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_PIXEL,           PAR8,PAR16,PAR16,            0,0,0,0,0             );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_LINE,            PAR8,PAR16,PAR16,PAR16,PAR16,                   0,0,0                 );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_CIRCLE,          PAR8,PAR16,PAR16,PAR16,      0,0,0,0               );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_TEXT,            PAR8,PAR16,PAR16,PAR8,       0,0,0,0               );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_ICON,            PAR8,PAR16,PAR16,PAR8,PAR8,  0,0,0                 );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_PICTURE,         PAR8,PAR16,PAR16,PAR32,      0,0,0,0               );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_VALUE,           PAR8,PAR16,PAR16,PARF,PAR8,PAR8,                0,0                   );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_NOTIFICATION,    PAR8,PAR16,PAR16,PAR8,PAR8,PAR8,PAR8,PAR8          );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_QUESTION,        PAR8,PAR16,PAR16,PAR8,PAR8,PAR8,PAR8,PAR8          );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_KEYBOARD,        PAR8,PAR16,PAR16,PAR8,PAR8,PAR8,PAR8,PAR8          );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_BROWSE,          PAR8,PAR16,PAR16,PAR16,PAR16,PAR8,PAR8,PAR8        );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_VERTBAR,         PAR8,PAR16,PAR16,PAR16,PAR16,PAR16,PAR16,PAR16     );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_INVERSERECT,     PAR16,PAR16,PAR16,PAR16,     0,0,0,0               );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_SELECT_FONT,     PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_TOPLINE,         PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_FILLWINDOW,      PAR8,PAR16,PAR16,            0,0,0,0,0             );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_SCROLL,          PAR16,    0,0,0,0,0,0,0         );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_DOTLINE,         PAR8,PAR16,PAR16,PAR16,PAR16,PAR16,PAR16,       0  );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_VIEW_VALUE,      PAR8,PAR16,PAR16,PARF,PAR8,PAR8,                0,0                   );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_VIEW_UNIT,       PAR8,PAR16,PAR16,PARF,PAR8,PAR8,PAR8,PAR8          );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_FILLCIRCLE,      PAR8,PAR16,PAR16,PAR16,      0,0,0,0               );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_STORE,           PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_RESTORE,         PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_ICON_QUESTION,   PAR8,PAR16,PAR16,PAR8,PAR32, 0,0,0                 );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_BMPFILE,         PAR8,PAR16,PAR16,PAR8,       0,0,0,0               );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_GRAPH_SETUP,     PAR16,PAR16,PAR16,PAR16,PAR8,PAR16,PAR16,PAR16     );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_GRAPH_DRAW,      PAR8,PARF,PARF,PARF,PARF,    0,0,0                 );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_POPUP,           PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_DRAW_SUBP,           UI_DRAW_TEXTBOX,         PAR16,PAR16,PAR16,PAR16,PAR8,PAR32,PAR8,PAR8       );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_SHORTPRESS,     PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_LONGPRESS,      PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_FLUSH,          0,        0,0,0,0,0,0,0         );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_WAIT_FOR_PRESS, 0,        0,0,0,0,0,0,0         );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_PRESS,          PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_RELEASE,        PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_GET_HORZ,       PAR16,    0,0,0,0,0,0,0         );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_GET_VERT,       PAR16,    0,0,0,0,0,0,0         );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_PRESSED,        PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_SET_BACK_BLOCK, PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_GET_BACK_BLOCK, PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_TESTSHORTPRESS, PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_TESTLONGPRESS,  PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_GET_BUMBED,     PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   UI_BUTTON_SUBP,         UI_BUTTON_GET_CLICK,      PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   COM_READ_SUBP,          COM_READ_COMMAND,         PAR32,PAR32,PAR32,PAR8,      0,0,0,0               );
  CreateSubCode(   COM_WRITE_SUBP,         COM_WRITE_REPLY,          PAR32,PAR32,PAR8,            0,0,0,0,0             );
  CreateSubCode(   SOUND_SUBP,             SOUND_BREAK,              0,        0,0,0,0,0,0,0         );
  CreateSubCode(   SOUND_SUBP,             SOUND_TONE,               PAR8,PAR16,PAR16,            0,0,0,0,0             );
  CreateSubCode(   SOUND_SUBP,             SOUND_PLAY,               PAR8,PARS,                   0,0,0,0,0,0           );
  CreateSubCode(   SOUND_SUBP,             SOUND_REPEAT,             PAR8,PARS,                   0,0,0,0,0,0           );
  CreateSubCode(   SOUND_SUBP,             SOUND_SERVICE,            0,        0,0,0,0,0,0,0         );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_TYPEMODE,       PAR8,PAR8,PAR8,PAR8,         0,0,0,0               );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_CONNECTION,     PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_NAME,           PAR8,PAR8,PAR8,PAR8,         0,0,0,0               );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_SYMBOL,         PAR8,PAR8,PAR8,PAR8,         0,0,0,0               );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_FORMAT,         PAR8,PAR8,PAR8,PAR8,PAR8,PAR8,                  0,0                   );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_RAW,            PAR8,PAR8,PAR32,             0,0,0,0,0             );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_MODENAME,       PAR8,PAR8,PAR8,PAR8,PAR8,    0,0,0                 );
  CreateSubCode(   INPUT_SUBP,             INPUT_SET_RAW,            PAR8,PAR8,PAR8,PAR32,        0,0,0,0               );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_FIGURES,        PAR8,PAR8,PAR8,PAR8,         0,0,0,0               );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_CHANGES,        PAR8,PAR8,PARF,              0,0,0,0,0             );
  CreateSubCode(   INPUT_SUBP,             INPUT_CLR_CHANGES,        PAR8,PAR8,0,                 0,0,0,0,0             );
  CreateSubCode(   INPUT_SUBP,             INPUT_READY_PCT,          PAR8,PAR8,PAR8,PAR8,PARNO,   0,0,0                 );
  CreateSubCode(   INPUT_SUBP,             INPUT_READY_RAW,          PAR8,PAR8,PAR8,PAR8,PARNO,   0,0,0                 );
  CreateSubCode(   INPUT_SUBP,             INPUT_READY_SI,           PAR8,PAR8,PAR8,PAR8,PARNO,   0,0,0                 );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_MINMAX,         PAR8,PAR8,PARF,PARF,         0,0,0,0               );
  CreateSubCode(   INPUT_SUBP,             INPUT_CAL_MINMAX,         PAR8,PAR8,PAR32,PAR32,       0,0,0,0               );
  CreateSubCode(   INPUT_SUBP,             INPUT_CAL_DEFAULT,        PAR8,PAR8,0,                 0,0,0,0,0             );
  CreateSubCode(   INPUT_SUBP,             INPUT_CAL_MIN,            PAR8,PAR8,PAR32,             0,0,0,0,0             );
  CreateSubCode(   INPUT_SUBP,             INPUT_CAL_MAX,            PAR8,PAR8,PAR32,             0,0,0,0,0             );
  CreateSubCode(   INPUT_SUBP,             INPUT_GET_BUMPS,          PAR8,PAR8,PARF,              0,0,0,0,0             );
  CreateSubCode(   INPUT_SUBP,             INPUT_SETUP,              PAR8,PAR8,PAR8,PAR16,PAR8,PAR8,PAR8,PAR8           );
  CreateSubCode(   INPUT_SUBP,             INPUT_CLR_ALL,            PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   INPUT_SUBP,             INPUT_STOP_ALL,           PAR8,     0,0,0,0,0,0,0         );
  CreateSubCode(   MATH_SUBP,              MATH_EXP,                PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_MOD,                PARF,PARF,PARF,              0,0,0,0,0             );
  CreateSubCode(   MATH_SUBP,              MATH_FLOOR,              PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_CEIL,               PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_ROUND,              PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_ABS,                PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_NEGATE,             PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_SQRT,               PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_LOG,                PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_LN,                 PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_SIN,                PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_COS,                PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_TAN,                PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_ASIN,               PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_ACOS,               PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_ATAN,               PARF,PARF,                   0,0,0,0,0,0           );
  CreateSubCode(   MATH_SUBP,              MATH_MOD8,               PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   MATH_SUBP,              MATH_MOD16,              PAR16,PAR16,PAR16,           0,0,0,0,0             );
  CreateSubCode(   MATH_SUBP,              MATH_MOD32,              PAR32,PAR32,PAR32,           0,0,0,0,0             );
  CreateSubCode(   MATH_SUBP,              MATH_POW,                PARF,PARF,PARF,              0,0,0,0,0             );
  CreateSubCode(   MATH_SUBP,              MATH_TRUNC,              PARF,PAR8,PARF,              0,0,0,0,0             );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_ON_OFF,         PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_VISIBLE,        PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_RESULT,         PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_PIN,            PAR8,PAR8,PAR8,PAR8,         0,0,0,0               );
  CreateSubCode(   COM_GET_SUBP,           COM_SEARCH_ITEMS,       PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_GET_SUBP,           COM_SEARCH_ITEM,        PAR8,PAR8,PAR8,PAR8,PAR8,PAR8,PAR8,PAR8            );
  CreateSubCode(   COM_GET_SUBP,           COM_FAVOUR_ITEMS,       PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_GET_SUBP,           COM_FAVOUR_ITEM,        PAR8,PAR8,PAR8,PAR8,PAR8,PAR8,PAR8,             0  );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_ID,             PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_BRICKNAME,      PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_NETWORK,        PAR8,PAR8,PAR8,PAR8,PAR8,    0,0,0                 );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_PRESENT,        PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_ENCRYPT,        PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   COM_GET_SUBP,           COM_CONNEC_ITEMS,       PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_GET_SUBP,           COM_CONNEC_ITEM,        PAR8,PAR8,PAR8,PAR8,PAR8,    0,0,0                 );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_INCOMING,       PAR8,PAR8,PAR8,PAR8,         0,0,0,0               );
  CreateSubCode(   COM_GET_SUBP,           COM_GET_MODE2,          PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_ON_OFF,         PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_VISIBLE,        PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_SEARCH,         PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_PIN,            PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_PASSKEY,        PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_CONNECTION,     PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_BRICKNAME,      PAR8,                        0,0,0,0,0,0,0         );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_MOVEUP,         PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_MOVEDOWN,       PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_ENCRYPT,        PAR8,PAR8,PAR8,              0,0,0,0,0             );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_SSID,           PAR8,PAR8,                   0,0,0,0,0,0           );
  CreateSubCode(   COM_SET_SUBP,           COM_SET_MODE2,          PAR8,PAR8,                   0,0,0,0,0,0           );
end;

initialization

  PopulateOpcodes;
  PopulateSubCodes;

end.
