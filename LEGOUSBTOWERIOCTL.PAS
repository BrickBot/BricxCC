{++

L E G O U S B T o w e r i o c t l . p a s

Translation of LEGOUSBTowerioctl.h, converted by htrans 0.3.4
Copyright (c) 1997 Alexander Staubo, all rights reserved.

[Generated on 22-08-2003 at 10:20]

--}

unit Legousbtowerioctl;

{$ALIGN ON}
{$MINENUMSIZE 4}

{$IFNDEF Ver100}
  !! { This unit requires Delphi 3.0 to compile }
{$ENDIF}

interface

{!! htrans: Unit list. Trim as appropriate }

uses
  Windows, SysUtils, ActiveX;

{!! htrans: Compatibility types }

type
  PPointer = ^Pointer;
  USHORT = Word;

{!! htrans: Translated header file begins here }

  //	LEGOUSBTowerioctl.h
  //
  //	Define control codes for LEGOUSBTower driver
  //
  //	Written by AS
  //	Copyright (C) 1999-2000 The LEGO Company. All rights reserved.
  //	
  //	@doc
  //	
  // _MSC_VER > 1000

{$IFNDEF __LEGOUSBTowerioctl__h_}

{$DEFINE __LEGOUSBTowerioctl__h_}

{$IFNDEF CTL_CODE}
{$ENDIF}

const
  LEGOUSBTOWER_IOCTL_SETRANGE = CTL_CODE(FILE_DEVICE_UNKNOWN, $800, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETRANGE = CTL_CODE(FILE_DEVICE_UNKNOWN, $801, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_SETLINK = CTL_CODE(FILE_DEVICE_UNKNOWN, $802, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETLINK = CTL_CODE(FILE_DEVICE_UNKNOWN, $803, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETCAPS = CTL_CODE(FILE_DEVICE_UNKNOWN, $804, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETVERSION = CTL_CODE(FILE_DEVICE_UNKNOWN, $805, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_FLUSH = CTL_CODE(FILE_DEVICE_UNKNOWN, $806, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_SETTIMEOUTS = CTL_CODE(FILE_DEVICE_UNKNOWN, $807, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETTIMEOUTS = CTL_CODE(FILE_DEVICE_UNKNOWN, $808, METHOD_BUFFERED, FILE_ANY_ACCESS);
    // NOT USED #define LEGOUSBTOWER_IOCTL_RESERVED			CTL_CODE(FILE_DEVICE_UNKNOWN, 0x809, METHOD_BUFFERED, FILE_ANY_ACCESS)
  LEGOUSBTOWER_IOCTL_SETBUFFERSIZE = CTL_CODE(FILE_DEVICE_UNKNOWN, $80A, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETBUFFERSIZE = CTL_CODE(FILE_DEVICE_UNKNOWN, $80, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_RESET = CTL_CODE(FILE_DEVICE_UNKNOWN, $80C, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETCOPYRIGHT = CTL_CODE(FILE_DEVICE_UNKNOWN, $80D, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETCREDITS = CTL_CODE(FILE_DEVICE_UNKNOWN, $80E, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_SETLEDMODE = CTL_CODE(FILE_DEVICE_UNKNOWN, $80F, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETLEDMODE = CTL_CODE(FILE_DEVICE_UNKNOWN, $810, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_SETLEDSTATE = CTL_CODE(FILE_DEVICE_UNKNOWN, $811, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETLEDSTATE = CTL_CODE(FILE_DEVICE_UNKNOWN, $812, METHOD_BUFFERED, FILE_ANY_ACCESS);
    // 0x813 is reserved	CTL_CODE(FILE_DEVICE_UNKNOWN, 0x813, METHOD_BUFFERED, FILE_ANY_ACCESS)
  LEGOUSBTOWER_IOCTL_GETERRORSTATE = CTL_CODE(FILE_DEVICE_UNKNOWN, $814, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_SETENDIANNESS = CTL_CODE(FILE_DEVICE_UNKNOWN, $815, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETENDIANNESS = CTL_CODE(FILE_DEVICE_UNKNOWN, $816, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_SETCOMMSPEED = CTL_CODE(FILE_DEVICE_UNKNOWN, $817, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETCOMMSPEED = CTL_CODE(FILE_DEVICE_UNKNOWN, $818, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_RESETCOMMSTATS = CTL_CODE(FILE_DEVICE_UNKNOWN, $819, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETCOMMSTATS = CTL_CODE(FILE_DEVICE_UNKNOWN, $81A, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_SETCARRIERFREQUENCY = CTL_CODE(FILE_DEVICE_UNKNOWN, $81, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETCARRIERFREQUENCY = CTL_CODE(FILE_DEVICE_UNKNOWN, $81C, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_SETCARRIERDUTYCYCLE = CTL_CODE(FILE_DEVICE_UNKNOWN, $81D, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETCARRIERDUTYCYCLE = CTL_CODE(FILE_DEVICE_UNKNOWN, $81E, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_SETPARM = CTL_CODE(FILE_DEVICE_UNKNOWN, $820, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETPARM = CTL_CODE(FILE_DEVICE_UNKNOWN, $821, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_SETPARM_IRC = CTL_CODE(FILE_DEVICE_UNKNOWN, $822, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_GETPARM_IRC = CTL_CODE(FILE_DEVICE_UNKNOWN, $823, METHOD_BUFFERED, FILE_ANY_ACCESS);
    // 824 is reserved		CTL_CODE(FILE_DEVICE_UNKNOWN, 0x824, METHOD_BUFFERED, FILE_ANY_ACCESS)
  LEGOUSBTOWER_IOCTL_GETTOWERSTATE = CTL_CODE(FILE_DEVICE_UNKNOWN, $825, METHOD_BUFFERED, FILE_ANY_ACCESS);
  LEGOUSBTOWER_IOCTL_RESTART = CTL_CODE(FILE_DEVICE_UNKNOWN, $826, METHOD_BUFFERED, FILE_ANY_ACCESS);
    // 827 is reserved		CTL_CODE(FILE_DEVICE_UNKNOWN, 0x827, METHOD_BUFFERED, FILE_ANY_ACCESS)
    //	------------------------------------------------------------------
    //	------------------------------------------------------------------
    //	------------------------------------------------------------------
    //
    //	COMMAND STRUCTURES AND CONSTANTS
    //
    //	------------------------------------------------------------------
    //	RANGE
    //

type
  LT_RANGE =

    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      dwrange : DWORD;
        // One of the LT_RANGE... constants
    end;

  PLT_RANGE = ^LT_RANGE;

const
  LT_RANGE_INVALID = $00;
  LT_RANGE_SHORT = $01;
  LT_RANGE_MEDIUM = $02;
  LT_RANGE_LONG = $03;

type
  LT_LINK =

    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      dwlink : DWORD;
        // One of the LT_LINK... constants
    end;

  PLT_LINK = ^LT_LINK;

const
  LT_LINK_INVALID = $00;
  LT_LINK_VLL = $01;
  LT_LINK_IR = $02;
  LT_LINK_IRC = $04;
  LT_LINK_RADIO = $08;
  LT_MODE_VLL = LT_LINK_VLL;
  LT_MODE_IR = LT_LINK_IR;
  LT_MODE_IRC = LT_LINK_IRC;
  LT_MODE_RADIO = LT_LINK_RADIO;

type
  LT_CAPS =
        
    record
      dwsize : DWORD;
        // @field Size of this structure
      wfwresult : WORD;
        // @field Firmware return code
      wspare : WORD;
        // @field Reserved
        // --------------------------------------------------
      wlink : WORD;
        // @field Type of capability requested (VLL/IR/IRC)
        // @field <t comm> | comm | Communication capabilities
        //	@struct comm | Communication capabilities
        //	
      comm :         
        record
          bdirections : BYTE;
            // @field LT_CAPS_COMM_DIRECTION_xxx 
          brange : BYTE;
            // @field LT_CAPS_COMM_RANGE_xxx
          wtxspeed : WORD;
            // @field LT_CAPS_COMM_SPEED_xxx 
          wrxspeed : WORD;
            // @field LT_CAPS_COMM_SPEED_xxx 
            // @field <t frequency> | frequency | Minimum/maximum frequency
            // @field <t dutycycle> | dutycycle | Minimum/maximum duty cycle
            //	@struct frequency |
            //	
            //	Tx frequency range is given by min and max values (in KHertz) 
            //	Only integer values are allowed (eg 38 == 38 KHz)
            //	
          frequency :             
            record
              wmin : WORD;
                // @field Minimum frequency supported 
              wmax : WORD;
                // @field Maximum frequency supported 
            end;
          //	@struct dutycycle |
            //
            //	Allowed duty cycle values (min-max) in us multiplied by 100. E.g.  1,25 us = 125
            //	Is it possible to set different duty cycle for each range (long-medium-short).
            //	The duty cycle value actually DETERMINES the range (but also the power consumption 
            //	of the tower)
            //	
            //	Please tinker with these values only if you KNOW VERY WELL what you're doing -- AS
            //	
        dutycycle :             
            record
              wmin : WORD;
                // @field Minimum duty cycle value 
              wmax : WORD;
                // @field Maximum duty cycle value 
            end;
          end;
      //	Insert other capability types here...
        //	
    end;
    
  PLT_CAPS = ^LT_CAPS;

const
  LT_CAPS_COMM_DIRECTION_TRANSMIT = $01;
  LT_CAPS_COMM_DIRECTION_RECEIVE = $02;
  LT_CAPS_COMM_DIRECTION_BOTH = (LT_CAPS_COMM_DIRECTION_TRANSMIT or LT_CAPS_COMM_DIRECTION_RECEIVE);
  LT_CAPS_COMM_RANGE_SHORT = $01;
  LT_CAPS_COMM_RANGE_MEDIUM = $02;
  LT_CAPS_COMM_RANGE_LONG = $04;
  LT_CAPS_COMM_RANGE_ALL = (LT_CAPS_COMM_RANGE_SHORT or LT_CAPS_COMM_RANGE_MEDIUM or LT_CAPS_COMM_RANGE_LONG);
  LT_CAPS_SPEED_BPS_300 = LT_SPEED_BPS_300;
  LT_CAPS_SPEED_BPS_600 = LT_SPEED_BPS_600;
  LT_CAPS_SPEED_BPS_1200 = LT_SPEED_BPS_1200;
  LT_CAPS_SPEED_BPS_2400 = LT_SPEED_BPS_2400;
  LT_CAPS_SPEED_BPS_4800 = LT_SPEED_BPS_4800;
  LT_CAPS_SPEED_BPS_9600 = LT_SPEED_BPS_9600;
  LT_CAPS_SPEED_BPS_19200 = LT_SPEED_BPS_19200;
  LT_CAPS_SPEED_BPS_38400 = LT_SPEED_BPS_38400;
  LT_CAPS_LINK_VLL = LT_LINK_VLL;
  LT_CAPS_LINK_IR = LT_LINK_IR;
  LT_CAPS_LINK_IRC = LT_LINK_IRC;
  LT_CAPS_LINK_RADIO = LT_LINK_RADIO;

type
  LT_TIMEOUT = record
    dwsize : DWORD;  // Size of this structure
    wfwresult : Word; // Firmware return code
    wspare : Word;   // Reserved
    dwspare : DWORD; // reserved
    dwwrite : DWORD; // write timeout
    dwread_first : DWORD; // read timeout (first byte)
    dwread_ic : DWORD; // read timeout (intercharacter timeout)
  end;
  PLT_TIMEOUT = ^LT_TIMEOUT;

  LT_VER = record
    bmajor : Byte; // @field	Major version number
    bminor : Byte; // @field	Minor version number
    wbuild : Smallint;  // @field	Build number
  end;
  PLT_VER = ^LT_VER;

  LT_VERSION = record
    dwsize : DWORD;  // @field Size of this structure
    wfwresult : Word; // @field Firmware return code
    wspare : Word; // @field Reserved
    driver : LT_VER; // @field <t LT_VER> | driver	| driver version information
    firmware : LT_VER; // @field <t LT_VER> | firmware | firmware version information
  end;
  PLT_VERSION = ^LT_VERSION;

  LT_FLUSH = record
    dwsize : DWORD; // Size of this structure
    wfwresult : Word; // Firmware return code
    wspare : Word;  // Reserved
    wflags : Word; // One or more of the LT_FLUSH flags, ORred together
  end;
  PLT_FLUSH = ^LT_FLUSH;

const
  LT_FLUSH_TX_BUFFER = $01;
  LT_FLUSH_RX_BUFFER = $02;
  LT_FLUSH_ALL = $03;

type
  LT_BUFFERSIZE =

    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code		// Not used for this command
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      dwbufsize : DWORD;
        // New driver's receive buffer size (in bytes)
    end;
    
  PLT_BUFFERSIZE = ^LT_BUFFERSIZE;
  
    // -------------------------------------------------------------
    // RESET TOWER
    //
  LT_RESET = 
        
    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code		
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      wflags : WORD;
        // no flags defined in this version. Just set it to 0
    end;
    
  PLT_RESET = ^LT_RESET;
  
    // -------------------------------------------------------------
    // COPYRIGHT
    //
    //	There is no structure for copyright info. You just pass DeviceIoControl a 
    //	ptr to the buffer and set the size field accordingly.
    //	
    //	The copyright string is returned in UNICODE format. Size is given to the 
    //	driver in BYTES
    //	
    // -------------------------------------------------------------
    // LEDMODE and LEDSTATE
    //
  LT_LEDMODE = 
        
    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code		
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      wledid : WORD;
        // id of the led to set mode (not used in this version; set to LT_LED_ID)
      wledmode : WORD;
        // new led mode -- one of LT_LEDMODE_xxx constants
    end;
    
  PLT_LEDMODE = ^LT_LEDMODE;
  
const
  LT_LED_ID = $01  // ID LED (the green led)
  ;
  LT_LED_VLL = $02  // VLL LED (the red led)
  ;
  LT_LED_CTRL_HW = $01  // the led is automatically controlled by the tower itself
  ;
  LT_LED_CTRL_SW = $02  // the led is controlled by the host software via the SETLEDSTATE command 
  ;
  LT_LED_COLOR_BLACK = $00  // Black = same as off
  ;
  LT_LED_COLOR_GREEN = $01  // Green
  ;
  LT_LED_COLOR_YELLOW = $02  // Yellow
  ;
  LT_LED_COLOR_ORANGE = $04  // Orange
  ;
  LT_LED_COLOR_RED = $08  // Red
  ;
    //	more color codes can be added here...
    //												
  LT_LED_COLOR_DEFAULT = $FF  // Whatever color is the default
  ;
  LT_LED_COLOR_ON = LT_LED_COLOR_DEFAULT  // generic ON
  ;
  LT_LED_COLOR_OFF = LT_LED_COLOR_BLACK  // generic OFF
  ;

type
  LT_LEDSTATE = 
        
    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code		
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      wledid : WORD;
        // id of the led to set mode (not used in this version; set to LT_LED_ID)
      wcolor : WORD;
        // led color -- one of the LT_LED_COLOR_xxx constants
    end;
    
  PLT_LEDSTATE = ^LT_LEDSTATE;
  
    // -------------------------------------------------------------
    // ERRORSTATE
    //
  LT_ERRORSTATE = 
        
    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code		
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      werrorstate : WORD;
        // current error state of the firmware
    end;
    
  PLT_ERRORSTATE = ^LT_ERRORSTATE;
  
    // -------------------------------------------------------------
    // ENDIANNESS
    //
  LT_ENDIANNESS = 
        
    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code		
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      wendianness : WORD;
        // one of the LT_ENDIAN_xxx constants
    end;
    
  PLT_ENDIANNESS = ^LT_ENDIANNESS;
  
const
  LT_ENDIAN_LITTLE = $01  // Little endian (Intel word format: LSB first, MSB last)	
  ;
  LT_ENDIAN_BIG = $02  // Big endian (Others word format: MSB first, LSB last)
  ;
    //	-------------------------------------------------------------
    //	COMMUNICATION SPEED
    //	

type
  LT_COMMSPEED = 
        
    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code		
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      wtxspeed : WORD;
        // transmission speed (a LT_SPEED_xxx constant)
      wrxspeed : WORD;
        // receive speed
      wlink : WORD;
        // NOT USED; set to 0 or (better for future compatibility) to LT_LINK_IR
      wspare2 : WORD;
    end;
    
  PLT_COMMSPEED = ^LT_COMMSPEED;
  
const
  LT_SPEED_BPS_300 = $0001;
  LT_SPEED_BPS_600 = $0002;
  LT_SPEED_BPS_1200 = $0004;
  LT_SPEED_BPS_2400 = $0008;
  LT_SPEED_BPS_4800 = $0010;
  LT_SPEED_BPS_9600 = $0020;
  LT_SPEED_BPS_19200 = $0040;
  LT_SPEED_BPS_38400 = $0080;
    //	-------------------------------------------------------------
    //	COMMSTATS
    //	
    //	@struct LT_COMMSTATS | Communication statistics (returned by <f LEGOTowerGetCommStats>)
    //	
    //	

type
  LT_COMMSTATS = 
        
    record
      dwsize : DWORD;
        // @field Size of this structure
      wfwresult : WORD;
        // @field Firmware return code		
      wspare : WORD;
        // @field Reserved
        // --------------------------------------------------
        //	Communication statistics 
        //	
      dwrxbytes : DWORD;
        // @field total received bytes
      dwoverrun : DWORD;
        // @field # of times overrun error has happen
      dwnoise : DWORD;
        // @field # of bytes with wrong bits
      dwframing : DWORD;
        // @field # of bytes with framing errors 
    end;
    
  PLT_COMMSTATS = ^LT_COMMSTATS;
  
    //	--------------------------------------------------------------
    //	FREQUENCY (valid for IR and IRC modes)
    //	
  LT_FREQUENCY = 
        
    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code		
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      wfrequency : WORD;
        // carrier frequency. Allowable values are between the ranges 
        //	given in the caps structure (typically between 30-99 KHz)
    end;
    
  PLT_FREQUENCY = ^LT_FREQUENCY;
  
    //	--------------------------------------------------------------
    //	DUTY CYCLE (valid for IR and IRC modes)
    //	
  LT_DUTYCYCLE = 
        
    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code		
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      wrange : WORD;
        // Range for which we set/get the duty cycle --> LT_RANGE_xxx
      wdutycycle : WORD;
        // Duty cycle value, in 1/100 of usec
    end;
    
  PLT_DUTYCYCLE = ^LT_DUTYCYCLE;
  
    //	--------------------------------------------------------------
    //	IRC (Technic cars) protocol-specific parameters
    //	

const
  LT_PARM_IRC_PACKETSIZE = $01  // Packet size, in bytes (default = 2)
  ;
  LT_PARM_IRC_TIMEFRAME = $02  // Time frame for packet syncronization, in ms (default = 80)
  ;

type
  LT_PARM = 
        
    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code		
      wspare : WORD;
        // Reserved
        // --------------------------------------------------
      bparm : BYTE;
        // parameter code
      barg : BYTE;
        // Parameter value
      windex : WORD;
        // index
    end;
    
  PLT_PARM = ^LT_PARM;
  
    //	--------------------------------------------------------------
    //	GETTOWERSTATE 
    //	
    //	@enum LT_TOWERSTATE_xxx | Flags returned by <f LEGOTowerGetState>
    //	

const
  LT_TOWERSTATE_CONNECTED = $01  // @emem LT_TOWERSTATE_CONNECTED	| Tower is connected
  ;
  LT_TOWERSTATE_STARTED = $02  // @emem LT_TOWERSTATE_STARTED		| Tower is started
  ;
  LT_TOWERSTATE_OPEN = $04  // @emem LT_TOWERSTATE_OPEN			| Tower is open
  ;
  LT_TOWERSTATE_READY = $08  // @emem LT_TOWERSTATE_READY		| Tower is ready
  ;
  LT_TOWERSTATE_ALLRIGHT = $0F  // @emem LT_TOWERSTATE_ALLRIGHT		| all of the above
  ;

type
  LT_TOWERSTATE = 
        
    record
      dwsize : DWORD;
        // Size of this structure
      wfwresult : WORD;
        // Firmware return code	(NOT USED)
      wtowerstate : WORD;
        // LT_TOWERSTATE_xxx (can be more than one)
    end;
    
  PLT_TOWERSTATE = ^LT_TOWERSTATE;
  
{$ENDIF}

{!! htrans: Translated header file ends here }

implementation

end.

