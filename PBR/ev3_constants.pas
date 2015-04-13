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
unit ev3_constants;

interface

// Reserved device types
const
  DEVICE_TYPE_NXT_TOUCH         =   1;  // Device is NXT touch sensor
  DEVICE_TYPE_NXT_LIGHT         =   2;  // Device is NXT light sensor
  DEVICE_TYPE_NXT_SOUND         =   3;  // Device is NXT sound sensor
  DEVICE_TYPE_NXT_COLOR         =   4;  // Device is NXT color sensor
  DEVICE_TYPE_TACHO             =   7;  // Device is a tacho motor
  DEVICE_TYPE_MINITACHO         =   8;  // Device is a mini tacho motor
  DEVICE_TYPE_NEWTACHO          =   9;  // Device is a new tacho motor
  DEVICE_TYPE_THIRD_PARTY_START =  50;
  DEVICE_TYPE_THIRD_PARTY_END   =  99;
  DEVICE_TYPE_IIC_UNKNOWN       = 100;
  DEVICE_TYPE_NXT_TEST          = 101;  // Device is a NXT ADC test sensor
  DEVICE_TYPE_NXT_IIC           = 123;  // Device is NXT IIC sensor
  DEVICE_TYPE_TERMINAL          = 124;  // Port is connected to a terminal
  DEVICE_TYPE_UNKNOWN           = 125;  // Port not empty but type has not been determined
  DEVICE_TYPE_NONE              = 126;  // Port empty or not available
  DEVICE_TYPE_ERROR             = 127;  // Port not empty and type is invalid

// connection types
const
  CONN_UNKNOWN            = 111;  // Connection is fake (test)
  CONN_DAISYCHAIN         = 117;  // Connection is daisy chained
  CONN_NXT_COLOR          = 118;  // Connection type is NXT color sensor
  CONN_NXT_DUMB           = 119;  // Connection type is NXT analog sensor
  CONN_NXT_IIC            = 120;  // Connection type is NXT IIC sensor
  CONN_INPUT_DUMB         = 121;  // Connection type is LMS2012 input device with ID resistor
  CONN_INPUT_UART         = 122;  // Connection type is LMS2012 UART sensor
  CONN_OUTPUT_DUMB        = 123;  // Connection type is LMS2012 output device with ID resistor
  CONN_OUTPUT_INTELLIGENT = 124;  // Connection type is LMS2012 output device with communication
  CONN_OUTPUT_TACHO       = 125;  // Connection type is LMS2012 tacho motor with series ID resistance
  CONN_NONE               = 126;  // Port empty or not available
  CONN_ERROR              = 127;  // Port not empty and type is invalid

const
  NUM_OUTPUTS           = 4;   // Number of output ports in the system
  NUM_INPUTS            = 4;   // Number of input  ports in the system
  NUM_BUTTONS           = 6;   // Number of buttons in the system
  NUM_LEDS              = 4;   // Number of LEDs in the system
  LCD_WIDTH             = 178; // LCD horizontal pixels
  LCD_HEIGHT            = 128; // LCD vertical pixels
  TOPLINE_HEIGHT        = 10;  // Top line vertical pixels
  LCD_STORE_LEVELS      = 3;   // Store levels

  DEFAULT_VOLUME        = 100;
  DEFAULT_SLEEPMINUTES  = 30;

  MAX_PROGRAMS          = 5;  // Max number of programs (including UI and direct commands) running at a time
  MAX_BREAKPOINTS       = 4;  // Max number of breakpoints (opCODES depends on this value)
  MAX_LABELS            = 32;  // Max number of labels per program
  MAX_DEVICE_TYPE       = 127;  // Highest type number (positive)
  MAX_DEVICE_MODES      = 8;  // Max number of modes in one device
  MAX_DEVICE_DATASETS   = 8;  // Max number of data sets in one device
  MAX_DEVICE_DATALENGTH = 32;  // Max device data length

  MAX_DEVICE_BUSY_TIME  = 1200;  // Max number of mS a device can be busy when read

  MAX_DEVICE_TYPES      = ((MAX_DEVICE_TYPE + 1) * MAX_DEVICE_MODES); //!< Max number of different device types and modes (max type data list size)

  MAX_FRAMES_PER_SEC    = 10;  // Max frames per second update in display

  CACHE_DEEPT           = 10;  // Max number of programs cached (in RECENT FILES MENU)
  MAX_HANDLES           = 250;  // Max number of handles to memory pools and arrays in one program

  MAX_ARRAY_SIZE        = 1000000000;  // Max array size
  MIN_ARRAY_ELEMENTS    = 0;  // Min elements in a DATA8 array

  INSTALLED_MEMORY      = 6000;  // Flash allocated to hold user programs/data
  RESERVED_MEMORY       = 100;  // Memory reserve for system [KB]
  LOW_MEMORY            = 500;  // Low memory warning [KB]

  LOGBUFFER_SIZE        = 1000;  // Min log buffer size
  DEVICE_LOGBUF_SIZE    = 300;  // Device log buffer size (black layer buffer)
  MIN_LIVE_UPDATE_TIME  = 10;  // Min sample time when live update (mS)

  MIN_IIC_REPEAT_TIME   = 10;  // Min IIC device repeat time (mS)
  MAX_IIC_REPEAT_TIME   = 1000;  // Max IIC device repeat time (mS)

  MAX_COMMAND_BYTECODES = 64;  // Max number of byte codes in a debug terminal direct command
  MAX_COMMAND_LOCALS    = 64;  // Max number of bytes allocated for direct command local variables
  MAX_COMMAND_GLOBALS   = 1021;  // Max number of bytes allocated for direct command global variables

  UI_PRIORITY           = 20;  // UI byte codes before switching VM thread
  C_PRIORITY            = 200;  // C call byte codes

{$ifndef DISABLE_PREEMPTED_VM}
  PRG_PRIORITY          = 2000;  // Prg byte codes before switching VM thread
{$else}
  PRG_PRIORITY          = 200;  // Prg byte codes before switching VM thread
{$endif}

  BUTTON_DEBOUNCE_TIME     = 30;
  BUTTON_START_REPEAT_TIME = 400;
  BUTTON_REPEAT_TIME       = 200;
  LONG_PRESS_TIME          = 3000;  // Time pressed before long press recognised (mS)

  ADC_REF               = 5000;  // maximal value on ADC (mV)
  ADC_RES               = 4095;  // maximal count on ADC (CNT)

  IN1_ID_HYSTERESIS     = 50;  // half of the span one Id takes up on input connection 1 voltage (mV)
  OUT5_ID_HYSTERESIS    = 100;  // half of the span one Id takes up on output connection 5 voltage (mV)

  DEVICE_UPDATE_TIME    = 1000000;  // Min device (sensor) update time [nS]
  DELAY_TO_TYPEDATA     = 10000;  // Time from daisy chain active to upload type data [mS]
  DAISYCHAIN_MODE_TIME  = 10;  // Time for daisy chain change mode [mS]
  
  MAX_FILE_HANDLES      = 64;  // Max number of down load file handles
  MIN_HANDLE            = 3;  // Min file handle to close

  ID_LENGTH             = 7;  // Id length  (BT MAC id) (incl. zero terminator)
  NAME_LENGTH           = 12;  // Name length (not including zero termination)

  ERROR_BUFFER_SIZE     = 8;  // Number of errors in buffer

// lms OS devices
const
  LMS_PWM_DEVICE            = 'lms_pwm';             // PWM device name
  LMS_PWM_DEVICE_NAME       = '/dev/lms_pwm';        // PWM device file name
  LMS_MOTOR_DEVICE          = 'lms_motor';           // TACHO device name
  LMS_MOTOR_DEVICE_NAME     = '/dev/lms_motor';      // TACHO device file name
  LMS_ANALOG_DEVICE         = 'lms_analog';          // ANALOG device name
  LMS_ANALOG_DEVICE_NAME    = '/dev/lms_analog';     // ANALOG device file name
  LMS_POWER_DEVICE          = 'lms_power';           // POWER device name
  LMS_POWER_DEVICE_NAME     = '/dev/lms_power';      // POWER device file name
  LMS_DCM_DEVICE            = 'lms_dcm';             // DCM device name
  LMS_DCM_DEVICE_NAME       = '/dev/lms_dcm';        // DCM device file name
  LMS_UI_DEVICE             = 'lms_ui';              // UI device name
  LMS_UI_DEVICE_NAME        = '/dev/lms_ui';         // UI device file name
  LMS_LCD_DEVICE            = 'lms_display';         // DISPLAY device name
  LMS_LCD_DEVICE_NAME       = '/dev/fb0';            // DISPLAY device file name
  LMS_UART_DEVICE           = 'lms_uart';            // UART device name
  LMS_UART_DEVICE_NAME      = '/dev/lms_uart';       // UART device file name
  LMS_USBDEV_DEVICE         = 'lms_usbdev';          // USB device
  LMS_USBDEV_DEVICE_NAME    = '/dev/lms_usbdev';     // USB device
  LMS_USBHOST_DEVICE        = 'lms_usbhost';         // USB host
  LMS_USBHOST_DEVICE_NAME   = '/dev/lms_usbhost';    // USB host
  LMS_SOUND_DEVICE          = 'lms_sound';           // SOUND device name
  LMS_SOUND_DEVICE_NAME     = '/dev/lms_sound';      // SOUND device
  LMS_IIC_DEVICE            = 'lms_iic';             // IIC device name
  LMS_IIC_DEVICE_NAME       = '/dev/lms_iic';        // IIC device
  LMS_BT_DEVICE             = 'lms_bt';              // BT device name
  LMS_BT_DEVICE_NAME        = '/dev/lms_bt';         // BT device
  LMS_UPDATE_DEVICE         = 'lms_update';          // UPDATE device name
  LMS_UPDATE_DEVICE_NAME    = '/dev/lms_update';     // UPDATE device
  LMS_TEST_PIN_DEVICE       = 'lms_tst_pin';         // TEST pin device name
  LMS_TEST_PIN_DEVICE_NAME  = '/dev/lms_tst_pin';    // TEST pin device file name
  LMS_TEST_UART_DEVICE      = 'lms_tst_uart';        // TEST UART device name
  LMS_TEST_UART_DEVICE_NAME = '/dev/lms_tst_uart';   // TEST UART device file name

// opcodes
const
  opError                     = $00;
  opNop                       = $01;
  opProgramStop               = $02;
  opProgramStart              = $03;
  opObjectStop                = $04;
  opObjectStart               = $05;
  opObjectTrigger             = $06;
  opObjectWait                = $07;
  opReturn                    = $08;
  opCall                      = $09;
  opObjectEnd                 = $0A;
  opSleep                     = $0B;
  opProgramInfo               = $0C;
  opLabel                     = $0D;
  opProbe                     = $0E;
  opDo                        = $0F;
  opAdd1                      = $10;
  opAdd2                      = $11;
  opAdd4                      = $12;
  opAddF                      = $13;
  opSub1                      = $14;
  opSub2                      = $15;
  opSub4                      = $16;
  opSubF                      = $17;
  opMul1                      = $18;
  opMul2                      = $19;
  opMul4                      = $1A;
  opMulF                      = $1B;
  opDiv1                      = $1C;
  opDiv2                      = $1D;
  opDiv4                      = $1E;
  opDivF                      = $1F;
  opOr1                       = $20;
  opOr2                       = $21;
  opOr4                       = $22;
  opAnd1                      = $24;
  opAnd2                      = $25;
  opAnd4                      = $26;
  opXor1                      = $28;
  opXor2                      = $29;
  opXor4                      = $2A;
  opRl1                       = $2C;
  opRl2                       = $2D;
  opRl4                       = $2E;
  opInitBytes                 = $2F;
  opMove11                    = $30;
  opMove12                    = $31;
  opMove14                    = $32;
  opMove1F                    = $33;
  opMove21                    = $34;
  opMove22                    = $35;
  opMove24                    = $36;
  opMove2F                    = $37;
  opMove41                    = $38;
  opMove42                    = $39;
  opMove44                    = $3A;
  opMove4F                    = $3B;
  opMoveF1                    = $3C;
  opMoveF2                    = $3D;
  opMoveF4                    = $3E;
  opMoveFF                    = $3F;
  opJmp                       = $40;
  opJmpFalse                  = $41;
  opJmpTrue                   = $42;
  opJmpNan                    = $43;
  opCmpLT1                    = $44;
  opCmpLT2                    = $45;
  opCmpLT4                    = $46;
  opCmpLTF                    = $47;
  opCmpGT1                    = $48;
  opCmpGT2                    = $49;
  opCmpGT4                    = $4A;
  opCmpGTF                    = $4B;
  opCmpEQ1                    = $4C;
  opCmpEQ2                    = $4D;
  opCmpEQ4                    = $4E;
  opCmpEQF                    = $4F;
  opCmpNEQ1                   = $50;
  opCmpNEQ2                   = $51;
  opCmpNEQ4                   = $52;
  opCmpNEQF                   = $53;
  opCmpLTEQ1                  = $54;
  opCmpLTEQ2                  = $55;
  opCmpLTEQ4                  = $56;
  opCmpLTEQF                  = $57;
  opCmpGTEQ1                  = $58;
  opCmpGTEQ2                  = $59;
  opCmpGTEQ4                  = $5A;
  opCmpGTEQF                  = $5B;
  opSelect1                   = $5C;
  opSelect2                   = $5D;
  opSelect4                   = $5E;
  opSelectF                   = $5F;
  opSystem                    = $60;
  opPortConvertOutput         = $61;
  opPortConvertInput          = $62;
  opNote2Freq                 = $63;
  opJmpLT1                    = $64;
  opJmpLT2                    = $65;
  opJmpLT4                    = $66;
  opJmpLTF                    = $67;
  opJmpGT1                    = $68;
  opJmpGT2                    = $69;
  opJmpGT4                    = $6A;
  opJmpGTF                    = $6B;
  opJmpEQ1                    = $6C;
  opJmpEQ2                    = $6D;
  opJmpEQ4                    = $6E;
  opJmpEQF                    = $6F;
  opJmpNEQ1                   = $70;
  opJmpNEQ2                   = $71;
  opJmpNEQ4                   = $72;
  opJmpNEQF                   = $73;
  opJmpLTEQ1                  = $74;
  opJmpLTEQ2                  = $75;
  opJmpLTEQ4                  = $76;
  opJmpLTEQF                  = $77;
  opJmpGTEQ1                  = $78;
  opJmpGTEQ2                  = $79;
  opJmpGTEQ4                  = $7A;
  opJmpGTEQF                  = $7B;
  opInfo                      = $7C;
  opStrings                   = $7D;
  opMemoryWrite               = $7E;
  opMemoryRead                = $7F;
  opUIFlush                   = $80;
  opUIRead                    = $81;
  opUIWrite                   = $82;
  opUIButton                  = $83;
  opUIDraw                    = $84;
  opTimerWait                 = $85;
  opTimerReady                = $86;
  opTimerRead                 = $87;
  opBreakpoint0               = $88;
  opBreakpoint1               = $89;
  opBreakpoint2               = $8A;
  opBreakpoint3               = $8B;
  opBreakpointSet             = $8C;
  opMath                      = $8D;
  opRandom                    = $8E;
  opTimerReadUS               = $8F;
  opKeepAlive                 = $90;
  opComRead                   = $91;
  opComWrite                  = $92;
  opSound                     = $94;
  opSoundTest                 = $95;
  opSoundReady                = $96;
  opInputSample               = $97;
  opInputDeviceList           = $98;
  opInputDevice               = $99;
  opInputRead                 = $9A;
  opInputTest                 = $9B;
  opInputReady                = $9C;
  opInputReadSI               = $9D;
  opInputReadext              = $9E;
  opInputWrite                = $9F;
  opOutputGetType             = $A0; // not implemented
  opOutputSetType             = $A1;
  opOutputReset               = $A2;
  opOutputStop                = $A3;
  opOutputPower               = $A4;
  opOutputSpeed               = $A5;
  opOutputStart               = $A6;
  opOutputPolarity            = $A7;
  opOutputRead                = $A8;
  opOutputTest                = $A9;
  opOutputReady               = $AA;
  opOutputPosition            = $AB; // not implemented
  opOutputStepPower           = $AC;
  opOutputTimePower           = $AD;
  opOutputStepSpeed           = $AE;
  opOutputTimeSpeed           = $AF;
  opOutputStepSync            = $B0;
  opOutputTimeSync            = $B1;
  opOutputClearCount          = $B2;
  opOutputGetCount            = $B3;
  opOutputProgramStop         = $B4;
  opFile                      = $C0;
  opArray                     = $C1;
  opArrayWrite                = $C2;
  opArrayRead                 = $C3;
  opArrayAppend               = $C4;
  opMemoryUsage               = $C5;
  opFilename                  = $C6;
  opRead1                     = $C8;
  opRead2                     = $C9;
  opRead4                     = $CA;
  opReadF                     = $CB;
  opWrite1                    = $CC;
  opWrite2                    = $CD;
  opWrite4                    = $CE;
  opWriteF                    = $CF;
  opComReadY                  = $D0;
  opComReadData               = $D1;
  opComWriteData              = $D2;
  opComGet                    = $D3;
  opComSet                    = $D4;
  opComTest                   = $D5;
  opComRemove                 = $D6;
  opComWriteFile              = $D7;
  opMailboxOpen               = $D8;
  opMailboxWrite              = $D9;
  opMailboxRead               = $DA;
  opMailboxTest               = $DB;
  opMailboxReady              = $DC;
  opMailboxClose              = $DD;
  opTest                      = $FF;

  // opUIRead specific command parameter
  UI_READ_GET_VBATT     = 1;
  UI_READ_GET_IBATT     = 2;
  UI_READ_GET_OS_VERS   = 3;
  UI_READ_GET_EVENT     = 4;
  UI_READ_GET_TBATT     = 5;
  UI_READ_GET_IINT      = 6;
  UI_READ_GET_IMOTOR    = 7;
  UI_READ_GET_STRING    = 8;
  UI_READ_GET_HW_VERS   = 9;
  UI_READ_GET_FW_VERS   = 10;
  UI_READ_GET_FW_BUILD  = 11;
  UI_READ_GET_OS_BUILD  = 12;
  UI_READ_GET_ADDRESS   = 13;
  UI_READ_GET_CODE      = 14;
  UI_READ_KEY           = 15;
  UI_READ_GET_SHUTDOWN  = 16;
  UI_READ_GET_WARNING   = 17;
  UI_READ_GET_LBATT     = 18;
  UI_READ_TEXTBOX_READ  = 21;
  UI_READ_GET_VERSION   = 26;
  UI_READ_GET_IP        = 27;
  UI_READ_GET_POWER     = 29;
  UI_READ_GET_SDCARD    = 30;
  UI_READ_GET_USBSTICK  = 31;
  UI_READ_SUBCODES      = 32;

  // opUIWrite specific command parameter
  UI_WRITE_WRITE_FLUSH   = 1;
  UI_WRITE_FLOATVALUE    = 2;
  UI_WRITE_STAMP         = 3;
  UI_WRITE_PUT_STRING    = 8;
  UI_WRITE_VALUE8        = 9;
  UI_WRITE_VALUE16       = 10;
  UI_WRITE_VALUE32       = 11;
  UI_WRITE_VALUEF        = 12;
  UI_WRITE_ADDRESS       = 13;
  UI_WRITE_CODE          = 14;
  UI_WRITE_DOWNLOAD_END  = 15;
  UI_WRITE_SCREEN_BLOCK  = 16;
  UI_WRITE_TEXTBOX_APPEND = 21;
  UI_WRITE_SET_BUSY      = 22;
  UI_WRITE_SET_TESTPIN   = 24;
  UI_WRITE_INIT_RUN      = 25;
  UI_WRITE_UPDATE_RUN    = 26;
  UI_WRITE_LED           = 27;
  UI_WRITE_POWER         = 29;
  UI_WRITE_GRAPH_SAMPLE  = 30;
  UI_WRITE_TERMINAL      = 31;
  UI_WRITE_SUBCODES      = 32;

  // opUIButton specific command parameter
  UI_BUTTON_SHORTPRESS      = 1;
  UI_BUTTON_LONGPRESS       = 2;
  UI_BUTTON_WAIT_FOR_PRESS  = 3;
  UI_BUTTON_FLUSH           = 4;
  UI_BUTTON_PRESS           = 5;
  UI_BUTTON_RELEASE         = 6;
  UI_BUTTON_GET_HORZ        = 7;
  UI_BUTTON_GET_VERT        = 8;
  UI_BUTTON_PRESSED         = 9;
  UI_BUTTON_SET_BACK_BLOCK  = 10;
  UI_BUTTON_GET_BACK_BLOCK  = 11;
  UI_BUTTON_TESTSHORTPRESS  = 12;
  UI_BUTTON_TESTLONGPRESS   = 13;
  UI_BUTTON_GET_BUMBED      = 14;
  UI_BUTTON_GET_CLICK       = 15;
  UI_BUTTON_SUBCODES        = 16;

  // opComRead specific command parameter
  COM_READ_COMMAND  = 14;
  COM_READ_SUBCODES = 15;

  // opComWrite specific command parameter
  COM_WRITE_REPLY    = 14;
  COM_WRITE_SUBCODES = 15;

  // opComGet specific command parameter
  COM_GET_ON_OFF    = 1;                    // Set, Get
  COM_GET_VISIBLE   = 2;                    // Set, Get
  COM_GET_RESULT    = 4;                    //      Get
  COM_GET_PIN       = 5;                    // Set, Get
  COM_SEARCH_ITEMS  = 8;                    //      Get
  COM_SEARCH_ITEM   = 9;                    //      Get
  COM_FAVOUR_ITEMS  = 10;                   //      Get
  COM_FAVOUR_ITEM   = 11;                   //      Get
  COM_GET_ID        = 12;
  COM_GET_BRICKNAME = 13;
  COM_GET_NETWORK   = 14;
  COM_GET_PRESENT   = 15;
  COM_GET_ENCRYPT   = 16;
  COM_CONNEC_ITEMS  = 17;
  COM_CONNEC_ITEM   = 18;
  COM_GET_INCOMING  = 19;
  COM_GET_MODE2     = 20;
  COM_GET_SUBCODES  = 21;

  // opComSet specific command parameter
  COM_SET_ON_OFF     = 1;                    // Set, Get
  COM_SET_VISIBLE    = 2;                    // Set, Get
  COM_SET_SEARCH     = 3;                    // Set
  COM_SET_PIN        = 5;                    // Set, Get
  COM_SET_PASSKEY    = 6;                    // Set
  COM_SET_CONNECTION = 7;                    // Set
  COM_SET_BRICKNAME  = 8;
  COM_SET_MOVEUP     = 9;
  COM_SET_MOVEDOWN   = 10;
  COM_SET_ENCRYPT    = 11;
  COM_SET_SSID       = 12;
  COM_SET_MODE2      = 13;
  COM_SET_SUBCODES   = 14;

  // opInputDevice specific command parameter
  INPUT_GET_FORMAT      = 2;
  INPUT_CAL_MINMAX      = 3;
  INPUT_CAL_DEFAULT     = 4;
  INPUT_GET_TYPEMODE    = 5;
  INPUT_GET_SYMBOL      = 6;
  INPUT_CAL_MIN         = 7;
  INPUT_CAL_MAX         = 8;
  INPUT_SETUP           = 9;
  INPUT_CLR_ALL         = 10;
  INPUT_GET_RAW         = 11;
  INPUT_GET_CONNECTION  = 12;
  INPUT_STOP_ALL        = 13;
  INPUT_GET_NAME        = 21;
  INPUT_GET_MODENAME    = 22;
  INPUT_SET_RAW         = 23;
  INPUT_GET_FIGURES     = 24;
  INPUT_GET_CHANGES     = 25;
  INPUT_CLR_CHANGES     = 26;
  INPUT_READY_PCT       = 27;
  INPUT_READY_RAW       = 28;
  INPUT_READY_SI        = 29;
  INPUT_GET_MINMAX      = 30;
  INPUT_GET_BUMPS       = 31;
  INPUT_SUBCODES        = 32;

  // opProgramInfo specific command parameter
  PROG_INFO_OBJ_STOP      = 0;    // VM
  PROG_INFO_OBJ_START     = 4;    // VM
  PROG_INFO_GET_STATUS    = 22;   // VM
  PROG_INFO_GET_SPEED     = 23;   // VM
  PROG_INFO_GET_PRGRESULT = 24;   // VM
  PROG_INFO_SET_INSTR     = 25;   // VM
  PROG_INFO_SUBCODES      = 26;

  // opUIDraw specific command parameter
  UI_DRAW_UPDATE        = 0;
  UI_DRAW_CLEAN         = 1;
  UI_DRAW_PIXEL         = 2;
  UI_DRAW_LINE          = 3;
  UI_DRAW_CIRCLE        = 4;
  UI_DRAW_TEXT          = 5;
  UI_DRAW_ICON          = 6;
  UI_DRAW_PICTURE       = 7;
  UI_DRAW_VALUE         = 8;
  UI_DRAW_FILLRECT      = 9;
  UI_DRAW_RECT          = 10;
  UI_DRAW_NOTIFICATION  = 11;
  UI_DRAW_QUESTION      = 12;
  UI_DRAW_KEYBOARD      = 13;
  UI_DRAW_BROWSE        = 14;
  UI_DRAW_VERTBAR       = 15;
  UI_DRAW_INVERSERECT   = 16;
  UI_DRAW_SELECT_FONT   = 17;
  UI_DRAW_TOPLINE       = 18;
  UI_DRAW_FILLWINDOW    = 19;
  UI_DRAW_SCROLL        = 20;
  UI_DRAW_DOTLINE       = 21;
  UI_DRAW_VIEW_VALUE    = 22;
  UI_DRAW_VIEW_UNIT     = 23;
  UI_DRAW_FILLCIRCLE    = 24;
  UI_DRAW_STORE         = 25;
  UI_DRAW_RESTORE       = 26;
  UI_DRAW_ICON_QUESTION = 27;
  UI_DRAW_BMPFILE       = 28;
  UI_DRAW_POPUP         = 29;
  UI_DRAW_GRAPH_SETUP   = 30;
  UI_DRAW_GRAPH_DRAW    = 31;
  UI_DRAW_TEXTBOX       = 32;
  UI_DRAW_SUBCODES      = 33;

  // opFile specific command parameter
  FILE_OPEN_APPEND         = 0;
  FILE_OPEN_READ           = 1;
  FILE_OPEN_WRITE          = 2;
  FILE_READ_VALUE          = 3;
  FILE_WRITE_VALUE         = 4;
  FILE_READ_TEXT           = 5;
  FILE_WRITE_TEXT          = 6;
  FILE_CLOSE               = 7;
  FILE_LOAD_IMAGE          = 8;
  FILE_GET_HANDLE          = 9;
  FILE_MAKE_FOLDER         = 10;
  FILE_GET_POOL            = 11;
  FILE_SET_LOG_SYNC_TIME   = 12;
  FILE_GET_FOLDERS         = 13;
  FILE_GET_LOG_SYNC_TIME   = 14;
  FILE_GET_SUBFOLDER_NAME  = 15;
  FILE_WRITE_LOG           = 16;
  FILE_CLOSE_LOG           = 17;
  FILE_GET_IMAGE           = 18;
  FILE_GET_ITEM            = 19;
  FILE_GET_CACHE_FILES     = 20;
  FILE_PUT_CACHE_FILE      = 21;
  FILE_GET_CACHE_FILE      = 22;
  FILE_DEL_CACHE_FILE      = 23;
  FILE_DEL_SUBFOLDER       = 24;
  FILE_GET_LOG_NAME        = 25;
  FILE_OPEN_LOG            = 27;
  FILE_READ_BYTES          = 28;
  FILE_WRITE_BYTES         = 29;
  FILE_REMOVE              = 30;
  FILE_MOVE                = 31;
  FILE_SUBCODES            = 32;

  // opArray specific command parameter
  ARRAY_DELETE              = 0;
  ARRAY_CREATE8             = 1;
  ARRAY_CREATE16            = 2;
  ARRAY_CREATE32            = 3;
  ARRAY_CREATEF             = 4;
  ARRAY_RESIZE              = 5;
  ARRAY_FILL                = 6;
  ARRAY_COPY                = 7;
  ARRAY_INIT8               = 8;
  ARRAY_INIT16              = 9;
  ARRAY_INIT32              = 10;
  ARRAY_INITF               = 11;
  ARRAY_SIZE                = 12;
  ARRAY_READ_CONTENT        = 13;
  ARRAY_WRITE_CONTENT       = 14;
  ARRAY_READ_SIZE           = 15;
  ARRAY_SUBCODES            = 16;

  // opFilename specific command parameter
  FILENAME_EXIST               = 16; // MUST BE GREATER OR EQUAL TO "ARRAY_SUBCODES"
  FILENAME_TOTALSIZE           = 17;
  FILENAME_SPLIT               = 18;
  FILENAME_MERGE               = 19;
  FILENAME_CHECK               = 20;
  FILENAME_PACK                = 21;
  FILENAME_UNPACK              = 22;
  FILENAME_GET_FOLDERNAME      = 23;
  FILENAME_SUBCODES            = 24;

  // opInfo specific command parameter
  INFO_SET_ERROR           = 1;
  INFO_GET_ERROR           = 2;
  INFO_ERRORTEXT           = 3;
  INFO_GET_VOLUME          = 4;
  INFO_SET_VOLUME          = 5;
  INFO_GET_MINUTES         = 6;
  INFO_SET_MINUTES         = 7;
  INFO_SUBCODES            = 8;

  // opSound specific command parameter
  SOUND_BREAK               = 0;
  SOUND_TONE                = 1;
  SOUND_PLAY                = 2;
  SOUND_REPEAT              = 3;
  SOUND_SERVICE             = 4;
  SOUND_SUBCODES            = 5;

  // opString specific command parameter
  STRING_GET_SIZE            = 1;    // VM       get string size
  STRING_ADD                 = 2;    // VM       add two strings
  STRING_COMPARE             = 3;    // VM       compare two strings
  STRING_DUPLICATE           = 5;    // VM       duplicate one string to another
  STRING_VALUE_TO_STRING     = 6;
  STRING_STRING_TO_VALUE     = 7;
  STRING_STRIP               = 8;
  STRING_NUMBER_TO_STRING    = 9;
  STRING_SUB                 = 10;
  STRING_VALUE_FORMATTED     = 11;
  STRING_NUMBER_FORMATTED    = 12;
  STRING_SUBCODES            = 13;

  // Program Slots
  PROG_GUI_SLOT     = 0; // Program slot reserved for executing the user interface
  PROG_USER_SLOT    = 1; // Program slot used to execute user projects; apps and tools
  PROG_CMD_SLOT     = 2; // Program slot used for direct commands coming from c_com
  PROG_TERM_SLOT    = 3; // Program slot used for direct commands coming from c_ui
  PROG_DEBUG_SLOT   = 4; // Program slot used to run the debug ui
  PROG_SLOTS        = 5; // Maximum slots supported by the VM
  PROG_CURRENT_SLOT = -1; // ONLY VALID IN opPROGRAM_STOP


  // Button Types
  BUTTON_TYPE_NO_BUTTON    = 0;
  BUTTON_TYPE_UP_BUTTON    = 1;
  BUTTON_TYPE_ENTER_BUTTON = 2;
  BUTTON_TYPE_DOWN_BUTTON  = 3;
  BUTTON_TYPE_RIGHT_BUTTON = 4;
  BUTTON_TYPE_LEFT_BUTTON  = 5;
  BUTTON_TYPE_BACK_BUTTON  = 6;
  BUTTON_TYPE_ANY_BUTTON   = 7;
  BUTTON_TYPES             = 8;

  // opMath specific command parameter
  MATH_EXP      = 1;    // e^x            r = expf(x)
  MATH_MOD      = 2;    // Modulo         r = fmod(x;y)
  MATH_FLOOR    = 3;    // Floor          r = floor(x)
  MATH_CEIL     = 4;    // Ceiling        r = ceil(x)
  MATH_ROUND    = 5;    // Round          r = round(x)
  MATH_ABS      = 6;    // Absolute       r = fabs(x)
  MATH_NEGATE   = 7;    // Negate         r = 0.0 - x
  MATH_SQRT     = 8;    // Squareroot     r = sqrt(x)
  MATH_LOG      = 9;    // Log            r = log10(x)
  MATH_LN       = 10;   // Ln             r = log(x)
  MATH_SIN      = 11;   //
  MATH_COS      = 12;   //
  MATH_TAN      = 13;   //
  MATH_ASIN     = 14;   //
  MATH_ACOS     = 15;   //
  MATH_ATAN     = 16;   //
  MATH_MOD8     = 17;   // Modulo DATA8   r = x % y
  MATH_MOD16    = 18;   // Modulo DATA16  r = x % y
  MATH_MOD32    = 19;   // Modulo DATA32  r = x % y
  MATH_POW      = 20;   // Exponent       r = powf(x;y)
  MATH_TRUNC    = 21;   // Truncate       r = (float)((int)(x * pow(y))) / pow(y)
  MATH_SUBCODES = 22;   // Maximum number of math functions supported by the VM

  // opTest specific command parameter
  TEST_OPEN         = 10; // MUST BE GREATER OR EQUAL TO "INFO_SUBCODES"
  TEST_CLOSE        = 11;
  TEST_READ_PINS    = 12;
  TEST_WRITE_PINS   = 13;
  TEST_READ_ADC     = 14;
  TEST_WRITE_UART   = 15;
  TEST_READ_UART    = 16;
  TEST_ENABLE_UART  = 17;
  TEST_DISABLE_UART = 18;
  TEST_ACCU_SWITCH  = 19;
  TEST_BOOT_MODE2   = 20;
  TEST_POLL_MODE2   = 21;
  TEST_CLOSE_MODE2  = 22;
  TEST_RAM_CHECK    = 23;
  TEST_SUBCODES     = 24;

implementation

end.
