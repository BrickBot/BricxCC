unit TOWERAPI;

interface

uses
  Windows;

const
  FILE_DEVICE_UNKNOWN           = $00000022;
  METHOD_BUFFERED               =  0;
  METHOD_IN_DIRECT              =  1;
  METHOD_OUT_DIRECT             =  2;
  METHOD_NEITHER                =  3;
  METHOD_DIRECT_TO_HARDWARE     =  METHOD_IN_DIRECT;
  METHOD_DIRECT_FROM_HARDWARE   =  METHOD_OUT_DIRECT;

  FILE_ANY_ACCESS           = 0;
  FILE_SPECIAL_ACCESS       = FILE_ANY_ACCESS;
  FILE_READ_ACCESS          = $0001;
  FILE_WRITE_ACCESS         = $0002;

  LEGO_DEVICE_TYPE = (FILE_DEVICE_UNKNOWN shl 16);
  LEGO_FILE_ACCESSMETHOD = (FILE_ANY_ACCESS shl 14) or METHOD_BUFFERED;

	LEGOUSBTOWER_IOCTL_SETRANGE		 = LEGO_DEVICE_TYPE or ($800 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETRANGE		 = LEGO_DEVICE_TYPE or ($801 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETLINK		 = LEGO_DEVICE_TYPE or ($802 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETLINK		 = LEGO_DEVICE_TYPE or ($803 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETCAPS		 = LEGO_DEVICE_TYPE or ($804 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETVERSION	 = LEGO_DEVICE_TYPE or ($805 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_FLUSH			 = LEGO_DEVICE_TYPE or ($806 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETTIMEOUTS = LEGO_DEVICE_TYPE or ($807 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETTIMEOUTS = LEGO_DEVICE_TYPE or ($808 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETBUFFERSIZE = LEGO_DEVICE_TYPE or ($80A shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETBUFFERSIZE = LEGO_DEVICE_TYPE or ($80B shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_RESET			   = LEGO_DEVICE_TYPE or ($80C shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETCOPYRIGHT	 = LEGO_DEVICE_TYPE or ($80D shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETCREDITS		 = LEGO_DEVICE_TYPE or ($80E shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETLEDMODE		 = LEGO_DEVICE_TYPE or ($80F shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETLEDMODE		 = LEGO_DEVICE_TYPE or ($810 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETLEDSTATE	 = LEGO_DEVICE_TYPE or ($811 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETLEDSTATE	 = LEGO_DEVICE_TYPE or ($812 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETERRORSTATE = LEGO_DEVICE_TYPE or ($814 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETENDIANNESS = LEGO_DEVICE_TYPE or ($815 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETENDIANNESS = LEGO_DEVICE_TYPE or ($816 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETCOMMSPEED	 = LEGO_DEVICE_TYPE or ($817 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETCOMMSPEED	 = LEGO_DEVICE_TYPE or ($818 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_RESETCOMMSTATS= LEGO_DEVICE_TYPE or ($819 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETCOMMSTATS	 = LEGO_DEVICE_TYPE or ($81A shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETCARRIERFREQUENCY = LEGO_DEVICE_TYPE or ($81B shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETCARRIERFREQUENCY = LEGO_DEVICE_TYPE or ($81C shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETCARRIERDUTYCYCLE = LEGO_DEVICE_TYPE or ($81D shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETCARRIERDUTYCYCLE = LEGO_DEVICE_TYPE or ($81E shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETPARM  		 = LEGO_DEVICE_TYPE or ($820 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETPARM  		 = LEGO_DEVICE_TYPE or ($821 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_SETPARM_IRC   = LEGO_DEVICE_TYPE or ($822 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETPARM_IRC   = LEGO_DEVICE_TYPE or ($823 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_GETTOWERSTATE = LEGO_DEVICE_TYPE or ($825 shl 2) or LEGO_FILE_ACCESSMETHOD;
	LEGOUSBTOWER_IOCTL_RESTART			 = LEGO_DEVICE_TYPE or ($826 shl 2) or LEGO_FILE_ACCESSMETHOD;

type
  unsigned_char = Byte;
  unsigned_short = Word;

type
	//	COMMUNICATION SPEED
  PLT_COMMSPEED = ^LT_COMMSPEED;
	LT_COMMSPEED = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		wtxspeed : Word;		// transmission speed (a LT_SPEED_xxx constant)
		wrxspeed : Word;		// receive speed
		wlink : Word;			// NOT USED; set to 0 or (better for future compatibility) to LT_LINK_IR
		wspare2 : Word;
  end;

const
  LT_SPEED_BPS_300	  = $0001;
  LT_SPEED_BPS_600	  = $0002;
  LT_SPEED_BPS_1200	  = $0004;
  LT_SPEED_BPS_2400	  = $0008;
  LT_SPEED_BPS_4800	  = $0010;
  LT_SPEED_BPS_9600	  = $0020;
  LT_SPEED_BPS_19200  = $0040;
  LT_SPEED_BPS_38400  = $0080;
  LT_SPEED_BPS_57600  = $00C0;
  LT_SPEED_BPS_115200 = $0180;
  LT_SPEED_BPS_230400 = $0300;
  LT_SPEED_BPS_460800 = $0600;

type
  PLT_LINK = ^LT_LINK;
	LT_LINK = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		dwlink : DWORD;  	// One of the LT_LINK... constants
  end;

const
	LT_LINK_INVALID	= $00;
	LT_LINK_VLL			= $01; // Send VLL
	LT_LINK_IR			= $02; // Send/Receive IR
	LT_LINK_IRC			= $04; // Send/Receive IR according to the LEGO Infrared Remote Control protocol (Technic Cars)
	LT_LINK_RADIO		= $08; // Send/Receive Radio signals
	LT_MODE_VLL			= LT_LINK_VLL;		// Defined for historical/compatibility reasons
	LT_MODE_IR			= LT_LINK_IR;
	LT_MODE_IRC			= LT_LINK_IRC;
	LT_MODE_RADIO		= LT_LINK_RADIO;

type
  LT_MINMAX = record
		wmin : Word;
		wmax : Word;
  end;

  LT_COMM = record
		bdirections : Byte;	// LT_CAPS_COMM_DIRECTION_xxx
		brange : Byte;			// LT_CAPS_COMM_RANGE_xxx
		wtxspeed : Word;		// LT_CAPS_COMM_SPEED_xxx
		wrxspeed : Word;		// LT_CAPS_COMM_SPEED_xxx
    frequency : LT_MINMAX; // min/max frequency
    dutycycle : LT_MINMAX; // min/max duty cycle
  end;

	//	LEGO Tower Device capabilities (returned by LEGOTowerGetCaps)
  PLT_CAPS = ^LT_CAPS;
  LT_CAPS = record
    dwsize : DWORD; // size of this structure
    wfwresult : Word; // firmware return code
    wspare : Word; // reserved
    wlink : Word; // type of capability requested (VLL/IR/IRC)
    comm : LT_COMM; // communication capabilities
  end;

const
  LT_CAPS_COMM_DIRECTION_TRANSMIT		= $01;	// - Transmit
  LT_CAPS_COMM_DIRECTION_RECEIVE		= $02;	// - Receive
  LT_CAPS_COMM_DIRECTION_BOTH			= LT_CAPS_COMM_DIRECTION_TRANSMIT or LT_CAPS_COMM_DIRECTION_RECEIVE;

  LT_CAPS_COMM_RANGE_SHORT			= $01;	// - Short
  LT_CAPS_COMM_RANGE_MEDIUM			= $02;	// - Medium
  LT_CAPS_COMM_RANGE_LONG				= $04;	// - Long
  LT_CAPS_COMM_RANGE_ALL				= LT_CAPS_COMM_RANGE_SHORT or	LT_CAPS_COMM_RANGE_MEDIUM or LT_CAPS_COMM_RANGE_LONG;

  LT_CAPS_SPEED_BPS_300		 = LT_SPEED_BPS_300;
  LT_CAPS_SPEED_BPS_600		 = LT_SPEED_BPS_600;
  LT_CAPS_SPEED_BPS_1200	 = LT_SPEED_BPS_1200;
  LT_CAPS_SPEED_BPS_2400	 = LT_SPEED_BPS_2400;
  LT_CAPS_SPEED_BPS_4800	 = LT_SPEED_BPS_4800;
  LT_CAPS_SPEED_BPS_9600	 = LT_SPEED_BPS_9600;
  LT_CAPS_SPEED_BPS_19200	 = LT_SPEED_BPS_19200;
  LT_CAPS_SPEED_BPS_38400	 = LT_SPEED_BPS_38400;

  LT_CAPS_LINK_VLL					= LT_LINK_VLL;	 // Send VLL
  LT_CAPS_LINK_IR						= LT_LINK_IR;		 // Send/Receive IR
  LT_CAPS_LINK_IRC					= LT_LINK_IRC;	 // Send/Receive IR according to the LEGO Infrared Remote Control protocol (Technic Cars)
  LT_CAPS_LINK_RADIO			 	= LT_LINK_RADIO; // Send/Receive Radio signals

type
	//	TIMEOUT
	LT_TIMEOUT = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		dwspare : DWORD;			// reserved
		dwwrite : DWORD;			// write timeout
		dwread_first : DWORD;		// read timeout (first byte)
		dwread_ic : DWORD;			// read timeout (intercharacter timeout)
  end;

type
  PLT_VER = ^LT_VER;
	LT_VER = record
    bmajor : unsigned_char; // major version number
    bminor : unsigned_char; // minor version number
    wbuild : unsigned_short; // build number
  end;
	//	Version description structure, filled in by LEGOTowerGetVersion.
  PLT_VERSION = ^LT_VERSION;
	LT_VERSION = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		driver : LT_VER;			// driver version information
		firmware : LT_VER;		// firmware version information
  end;

	//	Communication statistics (returned by LEGOTowerGetCommStats)
  PLT_COMMSTATS = ^LT_COMMSTATS;
  LT_COMMSTATS = record
    dwsize : DWORD;   //  Size of this structure
		wfwresult : Word;	// Firmware return code
		wspare : Word;		// Reserved
		dwrxbytes : DWORD; // total received bytes
		dwoverrun : DWORD; // # of times overrun error has happen
		dwnoise : DWORD;	 // # of bytes with wrong bits
		dwframing : DWORD; // # of bytes with framing errors
  end;

	//	RANGE
  PLT_RANGE = ^LT_RANGE;
	LT_RANGE = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		dwrange : DWORD;  	// One of the LT_RANGE... constants
  end;

const
	LT_RANGE_INVALID = $00;
	LT_RANGE_SHORT	 = $01; // - Short
	LT_RANGE_MEDIUM	 = $02; // - Medium
	LT_RANGE_LONG		 = $03; // - Long

type
	// FLUSH
	LT_FLUSH = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		wflags : Word;			// One or more of the LT_FLUSH flags, ORred together
  end;

const
  LT_FLUSH_TX_BUFFER	 = $01;		// Transmission buffer
  LT_FLUSH_RX_BUFFER	 = $02;		// Receiver buffer
  LT_FLUSH_ALL			   = $03;		// All buffers

type
	// BUFFER SIZE
  PLT_BUFFERSIZE = ^LT_BUFFERSIZE;
	LT_BUFFERSIZE = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		dwbufsize : DWORD;		// New driver's receive buffer size (in bytes)
  end;

	// RESET TOWER
  PLT_RESET = ^LT_RESET;
	LT_RESET = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		wflags : Word;			// no flags defined in this version. Just set it to 0
  end;

type
	// LEDMODE and LEDSTATE
  PLT_LEDMODE = ^LT_LEDMODE;
	LT_LEDMODE = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		wledid : Word;			// id of the led to set mode (not used in this version; set to LT_LED_ID)
		wledmode : Word;		// new led mode -- one of LT_LEDMODE_xxx constants
  end;

const
  LT_LED_ID				= $01;		// ID LED (the green led)
  LT_LED_VLL			= $02;		// VLL LED (the red led)

  LT_LED_CTRL_HW			= $01;		// the led is automatically controlled by the tower itself
  LT_LED_CTRL_SW			= $02;		// the led is controlled by the host software via the SETLEDSTATE command

  LT_LED_COLOR_BLACK	= $00;		// Black = same as off
  LT_LED_COLOR_GREEN	= $01;		// Green
  LT_LED_COLOR_YELLOW	= $02;		// Yellow
  LT_LED_COLOR_ORANGE	= $04;		// Orange
  LT_LED_COLOR_RED		= $08;		// Red

	//	more color codes can be added here...
	//
  LT_LED_COLOR_DEFAULT	= $FF;		// Whatever color is the default

  LT_LED_COLOR_ON			= LT_LED_COLOR_DEFAULT;		// generic ON
  LT_LED_COLOR_OFF		= LT_LED_COLOR_BLACK;			// generic OFF
  
type
  PLT_LEDSTATE = ^LT_LEDSTATE;
	LT_LEDSTATE = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		wledid : Word;			// id of the led to set mode (not used in this version; set to LT_LED_ID)
		wcolor : Word;			// led color -- one of the LT_LED_COLOR_xxx constants
  end;

type
	// ERRORSTATE
  PLT_ERRORSTATE = ^LT_ERRORSTATE;
	LT_ERRORSTATE = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		werrorstate : Word;	// current error state of the firmware
  end;

type
	// ENDIANNESS
  PLT_ENDIANNESS = ^LT_ENDIANNESS;
	LT_ENDIANNESS = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		wendianness : Word;	// one of the LT_ENDIAN_xxx constants
  end;

const
  LT_ENDIAN_LITTLE	= $01;	// Little endian (Intel word format: LSB first, MSB last)
  LT_ENDIAN_BIG			= $02;	// Big endian (Others word format: MSB first, LSB last)

type
	//	FREQUENCY (valid for IR and IRC modes)
  PLT_FREQUENCY = ^LT_FREQUENCY;
	LT_FREQUENCY = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		wfrequency : Word;		// carrier frequency. Allowable values are between the ranges
									        //	given in the caps structure (typically between 30-99 KHz)
  end;

type
	//	DUTY CYCLE (valid for IR and IRC modes)
  PLT_DUTYCYCLE = ^LT_DUTYCYCLE;
	LT_DUTYCYCLE = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		wrange : Word;			// Range for which we set/get the duty cycle --> LT_RANGE_xxx
		wdutycycle : Word;		// Duty cycle value, in 1/100 of usec
  end;

const
	//	IRC (Technic cars) protocol-specific parameters
  LT_PARM_IRC_PACKETSIZE       	= $01;	// Packet size, in bytes (default = 2)
  LT_PARM_IRC_TIMEFRAME       	= $02;	// Time frame for packet syncronization, in ms (default = 80)

type
  PLT_PARM = ^LT_PARM;
	LT_PARM = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wspare : Word;			// Reserved
		bparm : Byte;			// parameter code
		barg : Byte;			// Parameter value
		windex : Word;			// index
  end;

const
	//	Flags returned by LEGOTowerGetState
  LT_TOWERSTATE_CONNECTED	= $01;	// Tower is connected
  LT_TOWERSTATE_STARTED		= $02;	// Tower is started
  LT_TOWERSTATE_OPEN			= $04;	// Tower is open
  LT_TOWERSTATE_READY			= $08;	// Tower is ready
  LT_TOWERSTATE_ALLRIGHT	= $0F;	// all of the above

type
  PLT_TOWERSTATE = ^LT_TOWERSTATE;
	LT_TOWERSTATE = record
		dwsize : DWORD;			// Size of this structure
		wfwresult : Word;		// Firmware return code
		wtowerstate : Word;	// LT_TOWERSTATE_xxx (can be more than one)
	end;

type
  // to LEGOTowerSet/GetDefaultConfig
  LT_CONFIG = record
    dwsize: LongInt;
    dwrange: LongInt;  // a LT_RANGE_xxx constant
    dwlink: LongInt;   // a LT_LINK_xxx constant
    fhighpower: Bool;  // if set to TRUE, enables long range transmission but requires a high-power USB plug
    dwtimeout_read_1st: LongInt; // first byte timeout
    dwtimeout_read_ic: LongInt;  // inter-character timeout
    dwtimeout_write: LongInt;    // write timeout
    dwbuffersize: LongInt;
  end;

var
  LEGOTowerSetRange: function(hdevice: THandle; wrange: Word): Boolean; stdcall;
  LEGOTowerGetRange: function(hdevice: THandle; var pwrange: Word): Boolean; stdcall;
  LEGOTowerSetLinkMode: function(hdevice: THandle; wlinkmode: Word): Boolean; stdcall;
  LEGOTowerGetLinkMode: function(hdevice: THandle; var pwlinkmode: Word): Boolean; stdcall;
  LEGOTowerSetEndianness: function(hdevice: THandle; wendianness: Word): Boolean; stdcall;
  LEGOTowerGetEndianness: function(hdevice: THandle; var pwendianness: Word): Boolean; stdcall;
  LEGOTowerFlush: function(hdevice: THandle; wflags: Word): Boolean; stdcall;
  LEGOTowerReset: function(hdevice: THandle): Boolean; stdcall;
  LEGOTowerSetTimeouts: function(hdevice: THandle; dwread_first, dwread_ic, dwwrite: LongInt): Boolean; stdcall;
  LEGOTowerGetTimeouts: function(hdevice: THandle; var pdwread_first, pdwread_ic, pdwwrite: LongInt): Boolean; stdcall;
  LEGOTowerGetCaps: function(hdevice: THandle; dwcaps: LongInt; var pcaps: LT_CAPS): Boolean; stdcall;
  LEGOTowerGetVersion: function(hdevice: THandle; var pver: LT_VERSION): Boolean; stdcall;
  LEGOTowerGetCopyright: function(hdevice: THandle; lpszbuffer: PWideChar; size: DWORD): Boolean; stdcall;
  LEGOTowerGetCredits: function(hdevice: THandle; lpszbuffer: PWideChar; size: DWORD): Boolean; stdcall;
  LEGOTowerGetLedMode: function(hdevice: THandle; var pwledmode: BYTE): Boolean; stdcall;
  LEGOTowerSetLedMode: function(hdevice: THandle; wledmode: BYTE): Boolean; stdcall;
  LEGOTowerGetLedState: function(hdevice: THandle; bledid: Byte; var pbcolor: BYTE): Boolean; stdcall;
  LEGOTowerSetLedState: function(hdevice: THandle; bledid, bnewcolor: BYTE): Boolean; stdcall;
  LEGOTowerGetIRSpeed: function(hdevice: THandle; var pwtxspeed, pwrxspeed: Word): Boolean; stdcall;
  LEGOTowerSetIRSpeed: function(hdevice: THandle; wtxspeed, wrxspeed: Word): Boolean; stdcall;
  LEGOTowerResetCommStats: function(hdevice: THandle): Boolean; stdcall;
  LEGOTowerGetCommStats: function(hdevice: THandle; var pstats: LT_COMMSTATS): Boolean; stdcall;
  LEGOTowerSetDefaultConfig: function(var pltcfg: LT_CONFIG): Boolean; stdcall;
  LEGOTowerGetDefaultConfig: function(var pltcfg: LT_CONFIG): Boolean; stdcall;
  LEGOTowerGetFactoryConfig: function(var pltcfg: LT_CONFIG): Boolean; stdcall;
  LEGOTowerGetErrorState: function(hdevice: THandle; var pwerror: Word): Boolean; stdcall;
  LEGOTowerGetState: function(hdevice: THandle; var pwtowerstate: Word): Boolean; stdcall;
  LEGOTowerGetWin32Error: function(wtowererror: Word): Boolean; stdcall;
  LEGOTowerSetCarrierFrequency: function(hdevice: THandle; wfrequency: Word): Boolean; stdcall;
  LEGOTowerGetCarrierFrequency: function(hdevice: THandle; var pwfrequency: Word): Boolean; stdcall;
  LEGOTowerSetCarrierDutyCycle: function(hdevice: THandle; wrange, wdutycycle: Word): Boolean; stdcall;
  LEGOTowerGetCarrierDutyCycle: function(hdevice: THandle; wrange: Word; var pwdutycycle: Word): Boolean; stdcall;
  LEGOTowerSetIRCParm: function(hdevice: THandle; bparmcode, barg: Byte; windex: Word): Boolean; stdcall;
  LEGOTowerGetIRCParm: function(hdevice: THandle; bparmcode: Byte; var pbvalue: BYTE): Boolean; stdcall;
  LEGOTowerSetIRCTimeFrame: function(hdevice: THandle; btimeframe: BYTE): Boolean; stdcall;
  LEGOTowerGetIRCTimeFrame: function(hdevice: THandle; var pbtimeframe: BYTE): Boolean; stdcall;
  LEGOTowerSetIRCPacketSize: function(hdevice: THandle; bpacketsize: BYTE): Boolean; stdcall;
  LEGOTowerGetIRCPacketSize: function(hdevice: THandle; var pbpacketsize: BYTE): Boolean; stdcall;
  LEGOTowerRestart: function(hdevice: THandle): Boolean; stdcall;
  LEGOTowerRestartAll: function: Boolean; stdcall;
  LEGOTowerReenumerateAll: function: Boolean; stdcall;
  LEGOTowerIsUSBEnabled: function: Boolean; stdcall;

{/// Diagnostic Functions }
const
  SZBUF_FRIENDLYNAME = 128;
  SZBUF_PROVIDERNAME = 128;
  SZBUF_DRIVERNAME = 260;
  SZBUF_DRIVERVER = 64;
  SZBUF_DEVICEPATH = MAX_PATH;

type
  HTOWERINFO = Pointer;

type
  LT_DRIVER = record
    szdriverver: Array[0..SZBUF_DRIVERVER-1] of Char;
    szdrivername: Array[0..SZBUF_DRIVERNAME-1] of Char;
    szprovidername: Array[0..SZBUF_PROVIDERNAME-1] of Char;
  end;
	//	Parent hub information
  LT_PHUB = record
    fbuspowered : BOOL; // true if bus powered
    dwaddr : DWORD;     // USB Address;
    szfriendlyname: Array[0..SZBUF_FRIENDLYNAME-1] of Char;
  end;
  // Tower information
  LT_TOWERPNPINFO = record
    dwaddr: LongInt;
    dwstatus: LongInt;
    dwconnected: LongInt;
    dwproblem: LongInt;
    dwordinal: LongInt;
    szfriendlyname: Array[0..SZBUF_FRIENDLYNAME-1] of Char;
    szdevpath: Array[0..SZBUF_DEVICEPATH-1] of Char;
    parenthub : LT_PHUB;
    driver : LT_DRIVER; // driver information
  end;

type
  LT_HCINFO = record
    dwhcerror: LongInt;
    szdevicekeyname: Array[0..SZBUF_DRIVERNAME-1] of Char;
    szdevicedesc: Array[0..SZBUF_FRIENDLYNAME-1] of Char;
  end;

// Device status flags (duplicated from the DDK header file cfg.h -- added LT prefix)
const
  LTDN_ROOT_ENUMERATED = ($00000001); {// Was enumerated by ROOT}
  LTDN_DRIVER_LOADED = ($00000002); {// Has Register_Device_Driver}
  LTDN_ENUM_LOADED = ($00000004); {// Has Register_Enumerator}
  LTDN_STARTED = ($00000008); {// Is currently configured}
  LTDN_MANUAL = ($00000010); {// Manually installed}
  LTDN_NEED_TO_ENUM = ($00000020); {// May need reenumeration}
  LTDN_NOT_FIRST_TIME = ($00000040); {// Has received a config}
  LTDN_HARDWARE_ENUM = ($00000080); {// Enum generates hardware ID}
  LTDN_LIAR = ($00000100); {// Lied about can reconfig once}
  LTDN_HAS_MARK = ($00000200); {// Not CM_Create_DevInst lately}
  LTDN_HAS_PROBLEM = ($00000400); {// Need device installer}
  LTDN_FILTERED = ($00000800); {// Is filtered}
  LTDN_MOVED = ($00001000); {// Has been moved}
  LTDN_DISABLEABLE = ($00002000); {// Can be rebalanced}
  LTDN_REMOVABLE = ($00004000); {// Can be removed}
  LTDN_PRIVATE_PROBLEM = ($00008000); {// Has a private problem}
  LTDN_MF_PARENT = ($00010000); {// Multi function parent}
  LTDN_MF_CHILD = ($00020000); {// Multi function child}
  LTDN_WILL_BE_REMOVED = ($00040000); {// DevInst is being removed}

// Windows 4 OPK2 Flags
const
  LTDN_NOT_FIRST_TIMEE = $00080000; {// S: Has received a config enumerate}
  LTDN_STOP_FREE_RES = $00100000; {// S: When child is stopped, free resources}
  LTDN_REBAL_CANDIDATE = $00200000; {// S: Don't skip during rebalance}
  LTDN_BAD_PARTIAL = $00400000; {// S: This devnode's log_confs do not have same resources}
  LTDN_NT_ENUMERATOR = $00800000; {// S: This devnode's is an NT enumerator}
  LTDN_NT_DRIVER = $01000000; {// S: This devnode's is an NT driver}

// Windows 4.1 Flags
const
  LTDN_NEEDS_LOCKING = $02000000; {// S: Devnode need lock resume processing}
  LTDN_ARM_WAKEUP = $04000000; {// S: Devnode can be the wakeup device}
  LTDN_APM_ENUMERATOR = $08000000; {// S: APM aware enumerator}
  LTDN_APM_DRIVER = $10000000; {// S: APM aware driver}
  LTDN_SILENT_INSTALL = $20000000; {// S: Silent install}
  LTDN_NO_SHOW_IN_DM = $40000000; {// S: No show in device manager}
  LTDN_BOOT_LOG_PROB = $80000000; {// S: Had a problem during preassignment of boot log conf}

// Device problem flags (duplicated from the DDK header file cfg.h -- added LT prefix)
const
  LTCM_PROB_NOT_CONFIGURED = ($00000001); {// no config for device}
  LTCM_PROB_DEVLOADER_FAILED = ($00000002); {// service load failed}
  LTCM_PROB_OUT_OF_MEMORY = ($00000003); {// out of memory}
  LTCM_PROB_ENTRY_IS_WRONG_TYPE = ($00000004); {//}
  LTCM_PROB_LACKED_ARBITRATOR = ($00000005); {//}
  LTCM_PROB_BOOT_CONFIG_CONFLICT = ($00000006); {// boot config conflict}
  LTCM_PROB_FAILED_FILTER = ($00000007); {//}
  LTCM_PROB_DEVLOADER_NOT_FOUND = ($00000008); {// Devloader not found}
  LTCM_PROB_INVALID_DATA = ($00000009); {//}
  LTCM_PROB_FAILED_START = ($0000000A); {//}
  LTCM_PROB_LIAR = ($0000000B); {//}
  LTCM_PROB_NORMAL_CONFLICT = ($0000000C); {// config conflict}
  LTCM_PROB_NOT_VERIFIED = ($0000000D); {//}
  LTCM_PROB_NEED_RESTART = ($0000000E); {// requires restart}
  LTCM_PROB_REENUMERATION = ($0000000); {//}
  LTCM_PROB_PARTIAL_LOG_CONF = ($00000010); {//}
  LTCM_PROB_UNKNOWN_RESOURCE = ($00000011); {// unknown res type}
  LTCM_PROB_REINSTALL = ($00000012); {//}
  LTCM_PROB_REGISTRY = ($00000013); {//}
  LTCM_PROB_VXDLDR = ($00000014); {// WINDOWS 95 ONLY}
  LTCM_PROB_WILL_BE_REMOVED = ($00000015); {// devinst will remove}
  LTCM_PROB_DISABLED = ($00000016); {// devinst is disabled}
  LTCM_PROB_DEVLOADER_NOT_READY = ($00000017); {// Devloader not ready}
  LTCM_PROB_DEVICE_NOT_THERE = ($00000018); {// device doesn't exist}
  LTCM_PROB_MOVED = ($00000019); {//}
  LTCM_PROB_TOO_EARLY = ($0000001A); {//}
  LTCM_PROB_NO_VALID_LOG_CONF = ($0000001B); {// no valid log config}
  LTCM_PROB_FAILED_INSTALL = ($0000001C); {// install failed}
  LTCM_PROB_HARDWARE_DISABLED = ($0000001D); {// device disabled}
  LTCM_PROB_CANT_SHARE_IRQ = ($0000001E); {// can't share IRQ}
  LTCM_PROB_FAILED_ADD = ($0000001); {// driver failed add}
  LTCM_PROB_DISABLED_SERVICE = ($00000020); {// service's Start = 4}
  LTCM_PROB_TRANSLATION_FAILED = ($00000021); {// resource translation failed}
  LTCM_PROB_NO_SOFTCONFIG = ($00000022); {// no soft config}
  LTCM_PROB_BIOS_TABLE = ($00000023); {// device missing in BIOS table}
  LTCM_PROB_IRQ_TRANSLATION_FAILED = ($00000024); {// IRQ translator failed}
  NUM_LTCM_PROB = ($00000025);

type
  PLT_USBPNPINFO = ^LT_USBPNPINFO;
  LT_USBPNPINFO = record
    finstalled : boolean;
    dwnumcontrollers : DWORD;
    dwstatus : DWORD;
    dwproblem : DWORD;
  end;

const
  LTFIND_ALL = $00; {// finds all tower known to the system (even if not currently connected)}
  LTFIND_CONNECTED = $01; {// finds only connected devices (working and not working)}
  LTFIND_WORKING = $02; {// finds only working and connected devices}

var
  LEGOTowerFindFirst: function(dwfindfilter: LongInt): HTOWERINFO; stdcall;
  LEGOTowerFindNext: function(htower: HTOWERINFO): Boolean; stdcall;
  LEGOTowerFindPrev: function(htower: HTOWERINFO): Boolean; stdcall;
  LEGOTowerFindStop: function(htower: HTOWERINFO): Boolean; stdcall;

  LEGOTowerGetDeviceInfo: function(htower: HTOWERINFO; var ptowerinfo: LT_TOWERPNPINFO): Boolean; stdcall;
  LEGOTowerGetPathName: function(htower: HTOWERINFO): PChar; stdcall;
  LEGOTowerGetPathNameCopy: function(htower: HTOWERINFO; pszname: PChar; size: DWORD): Boolean; stdcall;

  LEGOTowerGetProblemDesc: function(dwproblem: Longint; pszdesc: PChar; size: DWORD): Boolean; stdcall;
  LEGOTowerGetDeviceInfoByNumber: function(dwdeviceno: Longint; dwfindfilter: Longint; var ppnpinfo: LT_TOWERPNPINFO): Boolean; stdcall;
  LEGOTowerGetHostControllerInfo: function(dwindex: Longint; var phcinfo: LT_HCINFO): Boolean; stdcall;

var
  LegoTowerApiLoaded: Boolean = False;

implementation

var
  SaveExit: pointer;
  DLLHandle: THandle;
{$IFNDEF MSDOS}
  ErrorMode: Integer;
{$ENDIF}

  procedure NewExit; far;
  begin
    ExitProc := SaveExit;
    FreeLibrary(DLLHandle)
  end {NewExit};

procedure LoadDLL;
begin
  if LegoTowerApiLoaded then Exit;
{$IFNDEF MSDOS}
  ErrorMode := SetErrorMode($8000{SEM_NoOpenFileErrorBox});
{$ENDIF}
  DLLHandle := LoadLibrary('TOWERAPI.DLL');
  if DLLHandle >= 32 then
  begin
    LegoTowerApiLoaded := True;
    SaveExit := ExitProc;
    ExitProc := @NewExit;
    @LEGOTowerSetRange := GetProcAddress(DLLHandle,'LEGOTowerSetRange');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetRange <> nil);
  {$ENDIF}
    @LEGOTowerGetRange := GetProcAddress(DLLHandle,'LEGOTowerGetRange');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetRange <> nil);
  {$ENDIF}
    @LEGOTowerSetLinkMode := GetProcAddress(DLLHandle,'LEGOTowerSetLinkMode');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetLinkMode <> nil);
  {$ENDIF}
    @LEGOTowerGetLinkMode := GetProcAddress(DLLHandle,'LEGOTowerGetLinkMode');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetLinkMode <> nil);
  {$ENDIF}
    @LEGOTowerSetEndianness := GetProcAddress(DLLHandle,'LEGOTowerSetEndianness');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetEndianness <> nil);
  {$ENDIF}
    @LEGOTowerGetEndianness := GetProcAddress(DLLHandle,'LEGOTowerGetEndianness');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetEndianness <> nil);
  {$ENDIF}
    @LEGOTowerFlush := GetProcAddress(DLLHandle,'LEGOTowerFlush');
  {$IFDEF WIN32}
    Assert(@LEGOTowerFlush <> nil);
  {$ENDIF}
    @LEGOTowerReset := GetProcAddress(DLLHandle,'LEGOTowerReset');
  {$IFDEF WIN32}
    Assert(@LEGOTowerReset <> nil);
  {$ENDIF}
    @LEGOTowerSetTimeouts := GetProcAddress(DLLHandle,'LEGOTowerSetTimeouts');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetTimeouts <> nil);
  {$ENDIF}
    @LEGOTowerGetTimeouts := GetProcAddress(DLLHandle,'LEGOTowerGetTimeouts');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetTimeouts <> nil);
  {$ENDIF}
    @LEGOTowerGetCaps := GetProcAddress(DLLHandle,'LEGOTowerGetCaps');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetCaps <> nil);
  {$ENDIF}
    @LEGOTowerGetVersion := GetProcAddress(DLLHandle,'LEGOTowerGetVersion');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetVersion <> nil);
  {$ENDIF}
    @LEGOTowerGetCopyright := GetProcAddress(DLLHandle,'LEGOTowerGetCopyright');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetCopyright <> nil);
  {$ENDIF}
    @LEGOTowerGetCredits := GetProcAddress(DLLHandle,'LEGOTowerGetCredits');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetCredits <> nil);
  {$ENDIF}
    @LEGOTowerGetLedMode := GetProcAddress(DLLHandle,'LEGOTowerGetLedMode');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetLedMode <> nil);
  {$ENDIF}
    @LEGOTowerSetLedMode := GetProcAddress(DLLHandle,'LEGOTowerSetLedMode');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetLedMode <> nil);
  {$ENDIF}
    @LEGOTowerGetLedState := GetProcAddress(DLLHandle,'LEGOTowerGetLedState');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetLedState <> nil);
  {$ENDIF}
    @LEGOTowerSetLedState := GetProcAddress(DLLHandle,'LEGOTowerSetLedState');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetLedState <> nil);
  {$ENDIF}
    @LEGOTowerGetIRSpeed := GetProcAddress(DLLHandle,'LEGOTowerGetIRSpeed');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetIRSpeed <> nil);
  {$ENDIF}
    @LEGOTowerSetIRSpeed := GetProcAddress(DLLHandle,'LEGOTowerSetIRSpeed');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetIRSpeed <> nil);
  {$ENDIF}
    @LEGOTowerResetCommStats := GetProcAddress(DLLHandle,'LEGOTowerResetCommStats');
  {$IFDEF WIN32}
    Assert(@LEGOTowerResetCommStats <> nil);
  {$ENDIF}
    @LEGOTowerGetCommStats := GetProcAddress(DLLHandle,'LEGOTowerGetCommStats');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetCommStats <> nil);
  {$ENDIF}
    @LEGOTowerSetDefaultConfig := GetProcAddress(DLLHandle,'LEGOTowerSetDefaultConfig');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetDefaultConfig <> nil);
  {$ENDIF}
    @LEGOTowerGetDefaultConfig := GetProcAddress(DLLHandle,'LEGOTowerGetDefaultConfig');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetDefaultConfig <> nil);
  {$ENDIF}
    @LEGOTowerGetFactoryConfig := GetProcAddress(DLLHandle,'LEGOTowerGetFactoryConfig');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetFactoryConfig <> nil);
  {$ENDIF}
    @LEGOTowerGetErrorState := GetProcAddress(DLLHandle,'LEGOTowerGetErrorState');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetErrorState <> nil);
  {$ENDIF}
    @LEGOTowerGetState := GetProcAddress(DLLHandle,'LEGOTowerGetState');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetState <> nil);
  {$ENDIF}
    @LEGOTowerGetWin32Error := GetProcAddress(DLLHandle,'LEGOTowerGetWin32Error');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetWin32Error <> nil);
  {$ENDIF}
    @LEGOTowerSetCarrierFrequency := GetProcAddress(DLLHandle,'LEGOTowerSetCarrierFrequency');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetCarrierFrequency <> nil);
  {$ENDIF}
    @LEGOTowerGetCarrierFrequency := GetProcAddress(DLLHandle,'LEGOTowerGetCarrierFrequency');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetCarrierFrequency <> nil);
  {$ENDIF}
    @LEGOTowerSetCarrierDutyCycle := GetProcAddress(DLLHandle,'LEGOTowerSetCarrierDutyCycle');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetCarrierDutyCycle <> nil);
  {$ENDIF}
    @LEGOTowerGetCarrierDutyCycle := GetProcAddress(DLLHandle,'LEGOTowerGetCarrierDutyCycle');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetCarrierDutyCycle <> nil);
  {$ENDIF}
    @LEGOTowerSetIRCParm := GetProcAddress(DLLHandle,'LEGOTowerSetIRCParm');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetIRCParm <> nil);
  {$ENDIF}
    @LEGOTowerGetIRCParm := GetProcAddress(DLLHandle,'LEGOTowerGetIRCParm');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetIRCParm <> nil);
  {$ENDIF}
    @LEGOTowerSetIRCTimeFrame := GetProcAddress(DLLHandle,'LEGOTowerSetIRCTimeFrame');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetIRCTimeFrame <> nil);
  {$ENDIF}
    @LEGOTowerGetIRCTimeFrame := GetProcAddress(DLLHandle,'LEGOTowerGetIRCTimeFrame');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetIRCTimeFrame <> nil);
  {$ENDIF}
    @LEGOTowerSetIRCPacketSize := GetProcAddress(DLLHandle,'LEGOTowerSetIRCPacketSize');
  {$IFDEF WIN32}
    Assert(@LEGOTowerSetIRCPacketSize <> nil);
  {$ENDIF}
    @LEGOTowerGetIRCPacketSize := GetProcAddress(DLLHandle,'LEGOTowerGetIRCPacketSize');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetIRCPacketSize <> nil);
  {$ENDIF}
    @LEGOTowerRestart := GetProcAddress(DLLHandle,'LEGOTowerRestart');
  {$IFDEF WIN32}
    Assert(@LEGOTowerRestart <> nil);
  {$ENDIF}
    @LEGOTowerRestartAll := GetProcAddress(DLLHandle,'LEGOTowerRestartAll');
  {$IFDEF WIN32}
    Assert(@LEGOTowerRestartAll <> nil);
  {$ENDIF}
    @LEGOTowerReenumerateAll := GetProcAddress(DLLHandle,'LEGOTowerReenumerateAll');
  {$IFDEF WIN32}
    Assert(@LEGOTowerReenumerateAll <> nil);
  {$ENDIF}
    @LEGOTowerIsUSBEnabled := GetProcAddress(DLLHandle,'LEGOTowerIsUSBEnabled');
  {$IFDEF WIN32}
    Assert(@LEGOTowerIsUSBEnabled <> nil);
  {$ENDIF}
    @LEGOTowerFindFirst := GetProcAddress(DLLHandle,'LEGOTowerFindFirst');
  {$IFDEF WIN32}
    Assert(@LEGOTowerFindFirst <> nil);
  {$ENDIF}
    @LEGOTowerFindNext := GetProcAddress(DLLHandle,'LEGOTowerFindNext');
  {$IFDEF WIN32}
    Assert(@LEGOTowerFindNext <> nil);
  {$ENDIF}
    @LEGOTowerFindPrev := GetProcAddress(DLLHandle,'LEGOTowerFindPrev');
  {$IFDEF WIN32}
    Assert(@LEGOTowerFindPrev <> nil);
  {$ENDIF}
    @LEGOTowerGetDeviceInfo := GetProcAddress(DLLHandle,'LEGOTowerGetDeviceInfo');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetDeviceInfo <> nil);
  {$ENDIF}
    @LEGOTowerFindStop := GetProcAddress(DLLHandle,'LEGOTowerFindStop');
  {$IFDEF WIN32}
    Assert(@LEGOTowerFindStop <> nil);
  {$ENDIF}
    @LEGOTowerGetPathName := GetProcAddress(DLLHandle,'LEGOTowerGetPathName');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetPathName <> nil);
  {$ENDIF}
    @LEGOTowerGetPathNameCopy := GetProcAddress(DLLHandle,'LEGOTowerGetPathNameCopy');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetPathNameCopy <> nil);
  {$ENDIF}
    @LEGOTowerGetProblemDesc := GetProcAddress(DLLHandle,'LEGOTowerGetProblemDesc');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetProblemDesc <> nil);
  {$ENDIF}
    @LEGOTowerGetDeviceInfoByNumber := GetProcAddress(DLLHandle,'LEGOTowerGetDeviceInfoByNumber');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetDeviceInfoByNumber <> nil);
  {$ENDIF}
    @LEGOTowerGetHostControllerInfo := GetProcAddress(DLLHandle,'LEGOTowerGetHostControllerInfo');
  {$IFDEF WIN32}
    Assert(@LEGOTowerGetHostControllerInfo <> nil);
  {$ENDIF}
  end
  else
  begin
    LegoTowerApiLoaded := False;
    { Error: TOWERAPI.DLL could not be loaded !! }
  end;
{$IFNDEF MSDOS}
  SetErrorMode(ErrorMode)
{$ENDIF}
end {LoadDLL};

begin
  LoadDLL;
end.
