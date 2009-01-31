unit LEGOVPBrickLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision: 1.1.1.1 $
// File generated on 10/3/2002 1:40:31 PM from Type Library described below.

// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
// ************************************************************************ //
// Type Lib: C:\Program Files\LEGO Software\LEGO Mindstorms SDK\Bin\vpbcom.dll (1)
// IID\LCID: {534E0580-2D76-11D4-BBFD-00105A48D3F9}\0
// Helpfile: C:\Program Files\LEGO Software\LEGO Mindstorms SDK\Bin\VPB.hlp
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
// Errors:
//   Error creating palette bitmap of (TVPBrick) : Server C:\Program Files\LEGO Software\LEGO Mindstorms SDK\Bin\vpbcom.dll contains no icons
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  LEGOVPBrickLibMajorVersion = 1;
  LEGOVPBrickLibMinorVersion = 0;

  LIBID_LEGOVPBrickLib: TGUID = '{534E0580-2D76-11D4-BBFD-00105A48D3F9}';

  DIID_IVPBrickEvents: TGUID = '{F52EF661-2E3F-11D4-BBFD-00105A48D3F9}';
  IID_IVPBrick: TGUID = '{534E058E-2D76-11D4-BBFD-00105A48D3F9}';
  CLASS_VPBrick: TGUID = '{534E058F-2D76-11D4-BBFD-00105A48D3F9}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0001
type
  __MIDL___MIDL_itf_vpbcom_0000_0001 = TOleEnum;
const
  NoType = $00000000;
  UnknownType = $00000001;
  RCXnoFirmware = $00000003;
  RCX = $00000004;
  Scout = $00000005;
  RCX2 = $00000006;
  MicroScout = $00000007;
  Spybot = $00000008;

// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0002
type
  __MIDL___MIDL_itf_vpbcom_0000_0002 = TOleEnum;
const
  GeneralStatus = $00000001;
  PortStatus = $00000002;
  BrickStatus = $00000003;
  DownloadStatus = $00000004;
  DownloadProgress = $00000005;
  CheckBrickType = $00000006;

// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0003
type
  __MIDL___MIDL_itf_vpbcom_0000_0003 = TOleEnum;
const
  Downloading = $00000000;
  StatusReady = $00000001;
  StatusUnknown = $00000002;
  NotOpened = $00000003;
  NoTower = $00000004;
  BadTower = $00000005;
  NoBrick = $00000006;
  NoFirmware = $00000007;
  BadBrickBattery = $00000008;
  BrickMismatch = $00000009;
  BadComms = $0000000B;
  StatusBusy = $0000000C;
  NoDriver = $0000000D;
  UnlockFailed = $0000000E;

// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0004
type
  __MIDL___MIDL_itf_vpbcom_0000_0004 = TOleEnum;
const
  MindScript = $00000001;
  LASM = $00000002;
  RawByteCode = $00000003;
  SplitByteCode = $00000004;
  VLLByteCode = $00000006;

// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0005
type
  __MIDL___MIDL_itf_vpbcom_0000_0005 = TOleEnum;
const
  UnknownRange = $00000000;
  ShortRange = $00000001;
  MediumRange = $00000002;
  LongRange = $00000003;

// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0006
type
  __MIDL___MIDL_itf_vpbcom_0000_0006 = TOleEnum;
const
  ExecuteBlockSize = $00000000;
  DownloadBlockSize = $00000001;
  FirmwareBlockSize = $00000002;

// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0007
type
  __MIDL___MIDL_itf_vpbcom_0000_0007 = TOleEnum;
const
  ExecuteRetries = $00000000;
  DownloadRetries = $00000001;

// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0008
type
  __MIDL___MIDL_itf_vpbcom_0000_0008 = TOleEnum;
const
  ReceiveTimeout = $00000000;
  InterCharacterTimeout = $00000001;

// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0009
type
  __MIDL___MIDL_itf_vpbcom_0000_0009 = TOleEnum;
const
  NoLink = $00000000;
  SerialIRLink = $00000001;
  SerialRadioLink = $00000002;
  USBTowerLink = $00000003;
  SerialSpybotLink = $00000004;

// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0010
type
  __MIDL___MIDL_itf_vpbcom_0000_0010 = TOleEnum;
const
  ModeUnknown = $00000000;
  ModeIR = $00000001;
  ModeVLL = $00000002;
  ModeIRC = $00000003;

// Constants for enum __MIDL___MIDL_itf_vpbcom_0000_0011
type
  __MIDL___MIDL_itf_vpbcom_0000_0011 = TOleEnum;
const
  UnknownEndian = $00000000;
  LittleEndian = $00000001;
  BigEndian = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IVPBrickEvents = dispinterface;
  IVPBrick = interface;
  IVPBrickDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  VPBrick = IVPBrick;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PWideString1 = ^WideString; {*}
  PUserType1 = ^CodeType; {*}

  BrickTypes = __MIDL___MIDL_itf_vpbcom_0000_0001; 
  StatusRequest = __MIDL___MIDL_itf_vpbcom_0000_0002; 
  StatusResult = __MIDL___MIDL_itf_vpbcom_0000_0003; 
  CodeType = __MIDL___MIDL_itf_vpbcom_0000_0004; 
  RangeType = __MIDL___MIDL_itf_vpbcom_0000_0005; 
  BlockSizeType = __MIDL___MIDL_itf_vpbcom_0000_0006; 
  RetryType = __MIDL___MIDL_itf_vpbcom_0000_0007; 
  TimeoutType = __MIDL___MIDL_itf_vpbcom_0000_0008; 
  LinkType = __MIDL___MIDL_itf_vpbcom_0000_0009; 
  ModeType = __MIDL___MIDL_itf_vpbcom_0000_0010; 
  EndianType = __MIDL___MIDL_itf_vpbcom_0000_0011; 

// *********************************************************************//
// DispIntf:  IVPBrickEvents
// Flags:     (4096) Dispatchable
// GUID:      {F52EF661-2E3F-11D4-BBFD-00105A48D3F9}
// *********************************************************************//
  IVPBrickEvents = dispinterface
    ['{F52EF661-2E3F-11D4-BBFD-00105A48D3F9}']
    procedure DownloadProgress(nPercent: Integer); dispid 1;
    procedure DownloadDone(nErrorCode: Integer); dispid 2;
    procedure Received(const strData: WideString); dispid 3;
  end;

// *********************************************************************//
// Interface: IVPBrick
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {534E058E-2D76-11D4-BBFD-00105A48D3F9}
// *********************************************************************//
  IVPBrick = interface(IDispatch)
    ['{534E058E-2D76-11D4-BBFD-00105A48D3F9}']
    procedure FindPort(var strPort: WideString); safecall;
    procedure Open(const strPort: WideString); safecall;
    procedure Close; safecall;
    function  Status(nRequest: StatusRequest): StatusResult; safecall;
    function  Execute(var strCommand: WideString; var nCodeType: CodeType; out nErrPos: Integer; 
                      out pResult: OleVariant): Integer; safecall;
    procedure Validate(var strProgram: WideString; var nCodeType: CodeType; out nErrPos: Integer); safecall;
    procedure Download(var strProgram: WideString; var nCodeType: CodeType; out nErrPos: Integer); safecall;
    procedure DownloadFirmware(const strFilename: WideString); safecall;
    procedure MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                     out nDataLast: Integer; out pTasks: OleVariant; out pSubs: OleVariant; 
                     out pSounds: OleVariant; out pDisplays: OleVariant); safecall;
    function  Upload(nStartAddress: Integer; nSize: Integer): OleVariant; safecall;
    procedure GetStatistics(out nRequests: Integer; out nFails: Integer; out nAborts: Integer; 
                            out nTxRequests: Integer; out nTxFails: Integer; 
                            out nRxRequests: Integer; out nRxErrors: Integer); safecall;
    procedure GetInfo(out nProgramSlots: Integer; out nOutputs: Integer; out nInputs: Integer; 
                      out nGlobals: Integer; out nLocals: Integer; out nTasks: Integer; 
                      out nSubs: Integer; out nTimers: Integer; out nCounters: Integer; 
                      out nSemaphores: Integer; out nRAM: Integer); safecall;
    procedure Monitor(bMonitor: WordBool); safecall;
    procedure EnumBrickTypes(var nBrickType: Smallint; out strBrickName: WideString); safecall;
    function  Get_BrickType: Smallint; safecall;
    procedure Set_BrickType(pVal: Smallint); safecall;
    function  Get_Path: WideString; safecall;
    procedure Set_Path(const pVal: WideString); safecall;
    function  Get_ProgramSlot: Smallint; safecall;
    procedure Set_ProgramSlot(pVal: Smallint); safecall;
    function  Get_PortTxRange: RangeType; safecall;
    procedure Set_PortTxRange(pVal: RangeType); safecall;
    function  Get_BrickTxRange: RangeType; safecall;
    procedure Set_BrickTxRange(pVal: RangeType); safecall;
    function  Get_PowerDownTime: Smallint; safecall;
    procedure Set_PowerDownTime(pVal: Smallint); safecall;
    function  Get_BlockSize(nType: BlockSizeType): Smallint; safecall;
    procedure Set_BlockSize(nType: BlockSizeType; pVal: Smallint); safecall;
    function  Get_Retries(nType: RetryType): Smallint; safecall;
    procedure Set_Retries(nType: RetryType; pVal: Smallint); safecall;
    function  Get_Timeout(nType: TimeoutType): Smallint; safecall;
    procedure Set_Timeout(nType: TimeoutType; pVal: Smallint); safecall;
    function  Get_Trace: Smallint; safecall;
    procedure Set_Trace(pVal: Smallint); safecall;
    function  Get_Symbols: OleVariant; safecall;
    procedure Set_Symbols(pVal: OleVariant); safecall;
    function  Get_PortName: WideString; safecall;
    function  Get_PortType: LinkType; safecall;
    function  Get_HelpFile: WideString; safecall;
    function  Get_PortTxBaudRate: Smallint; safecall;
    procedure Set_PortTxBaudRate(pVal: Smallint); safecall;
    function  Get_PortRxBaudRate: Smallint; safecall;
    procedure Set_PortRxBaudRate(pVal: Smallint); safecall;
    function  Get_PortMode: ModeType; safecall;
    procedure Set_PortMode(pVal: ModeType); safecall;
    function  Get_PortEndian: EndianType; safecall;
    procedure Set_PortEndian(pVal: EndianType); safecall;
    function  Get_BrickVersion: WideString; safecall;
    function  Get_FreeRAM: Smallint; safecall;
    property BrickType: Smallint read Get_BrickType write Set_BrickType;
    property Path: WideString read Get_Path write Set_Path;
    property ProgramSlot: Smallint read Get_ProgramSlot write Set_ProgramSlot;
    property PortTxRange: RangeType read Get_PortTxRange write Set_PortTxRange;
    property BrickTxRange: RangeType read Get_BrickTxRange write Set_BrickTxRange;
    property PowerDownTime: Smallint read Get_PowerDownTime write Set_PowerDownTime;
    property BlockSize[nType: BlockSizeType]: Smallint read Get_BlockSize write Set_BlockSize;
    property Retries[nType: RetryType]: Smallint read Get_Retries write Set_Retries;
    property Timeout[nType: TimeoutType]: Smallint read Get_Timeout write Set_Timeout;
    property Trace: Smallint read Get_Trace write Set_Trace;
    property Symbols: OleVariant read Get_Symbols write Set_Symbols;
    property PortName: WideString read Get_PortName;
    property PortType: LinkType read Get_PortType;
    property HelpFile: WideString read Get_HelpFile;
    property PortTxBaudRate: Smallint read Get_PortTxBaudRate write Set_PortTxBaudRate;
    property PortRxBaudRate: Smallint read Get_PortRxBaudRate write Set_PortRxBaudRate;
    property PortMode: ModeType read Get_PortMode write Set_PortMode;
    property PortEndian: EndianType read Get_PortEndian write Set_PortEndian;
    property BrickVersion: WideString read Get_BrickVersion;
    property FreeRAM: Smallint read Get_FreeRAM;
  end;

// *********************************************************************//
// DispIntf:  IVPBrickDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {534E058E-2D76-11D4-BBFD-00105A48D3F9}
// *********************************************************************//
  IVPBrickDisp = dispinterface
    ['{534E058E-2D76-11D4-BBFD-00105A48D3F9}']
    procedure FindPort(var strPort: WideString); dispid 1;
    procedure Open(const strPort: WideString); dispid 2;
    procedure Close; dispid 3;
    function  Status(nRequest: StatusRequest): StatusResult; dispid 4;
    function  Execute(var strCommand: WideString; var nCodeType: CodeType; out nErrPos: Integer; 
                      out pResult: OleVariant): Integer; dispid 5;
    procedure Validate(var strProgram: WideString; var nCodeType: CodeType; out nErrPos: Integer); dispid 6;
    procedure Download(var strProgram: WideString; var nCodeType: CodeType; out nErrPos: Integer); dispid 7;
    procedure DownloadFirmware(const strFilename: WideString); dispid 8;
    procedure MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                     out nDataLast: Integer; out pTasks: OleVariant; out pSubs: OleVariant; 
                     out pSounds: OleVariant; out pDisplays: OleVariant); dispid 9;
    function  Upload(nStartAddress: Integer; nSize: Integer): OleVariant; dispid 10;
    procedure GetStatistics(out nRequests: Integer; out nFails: Integer; out nAborts: Integer; 
                            out nTxRequests: Integer; out nTxFails: Integer; 
                            out nRxRequests: Integer; out nRxErrors: Integer); dispid 11;
    procedure GetInfo(out nProgramSlots: Integer; out nOutputs: Integer; out nInputs: Integer; 
                      out nGlobals: Integer; out nLocals: Integer; out nTasks: Integer; 
                      out nSubs: Integer; out nTimers: Integer; out nCounters: Integer; 
                      out nSemaphores: Integer; out nRAM: Integer); dispid 12;
    procedure Monitor(bMonitor: WordBool); dispid 13;
    procedure EnumBrickTypes(var nBrickType: Smallint; out strBrickName: WideString); dispid 14;
    property BrickType: Smallint dispid 15;
    property Path: WideString dispid 16;
    property ProgramSlot: Smallint dispid 17;
    property PortTxRange: RangeType dispid 18;
    property BrickTxRange: RangeType dispid 19;
    property PowerDownTime: Smallint dispid 20;
    property BlockSize[nType: BlockSizeType]: Smallint dispid 21;
    property Retries[nType: RetryType]: Smallint dispid 22;
    property Timeout[nType: TimeoutType]: Smallint dispid 23;
    property Trace: Smallint dispid 24;
    property Symbols: OleVariant dispid 25;
    property PortName: WideString readonly dispid 26;
    property PortType: LinkType readonly dispid 27;
    property HelpFile: WideString readonly dispid 28;
    property PortTxBaudRate: Smallint dispid 29;
    property PortRxBaudRate: Smallint dispid 30;
    property PortMode: ModeType dispid 31;
    property PortEndian: EndianType dispid 32;
    property BrickVersion: WideString readonly dispid 33;
    property FreeRAM: Smallint readonly dispid 34;
  end;

// *********************************************************************//
// The Class CoVPBrick provides a Create and CreateRemote method to          
// create instances of the default interface IVPBrick exposed by              
// the CoClass VPBrick. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVPBrick = class
    class function Create: IVPBrick;
    class function CreateRemote(const MachineName: string): IVPBrick;
  end;

  TVPBrickDownloadProgress = procedure(Sender: TObject; nPercent: Integer) of object;
  TVPBrickDownloadDone = procedure(Sender: TObject; nErrorCode: Integer) of object;
  TVPBrickReceived = procedure(Sender: TObject; var strData: OleVariant) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TVPBrick
// Help String      : VPBrick Class
// Default Interface: IVPBrick
// Def. Intf. DISP? : No
// Event   Interface: IVPBrickEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TVPBrickProperties= class;
{$ENDIF}
  TVPBrick = class(TOleServer)
  private
    FOnDownloadProgress: TVPBrickDownloadProgress;
    FOnDownloadDone: TVPBrickDownloadDone;
    FOnReceived: TVPBrickReceived;
    FIntf:        IVPBrick;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TVPBrickProperties;
    function      GetServerProperties: TVPBrickProperties;
{$ENDIF}
    function      GetDefaultInterface: IVPBrick;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function  Get_BrickType: Smallint;
    procedure Set_BrickType(pVal: Smallint);
    function  Get_Path: WideString;
    procedure Set_Path(const pVal: WideString);
    function  Get_ProgramSlot: Smallint;
    procedure Set_ProgramSlot(pVal: Smallint);
    function  Get_PortTxRange: RangeType;
    procedure Set_PortTxRange(pVal: RangeType);
    function  Get_BrickTxRange: RangeType;
    procedure Set_BrickTxRange(pVal: RangeType);
    function  Get_PowerDownTime: Smallint;
    procedure Set_PowerDownTime(pVal: Smallint);
    function  Get_BlockSize(nType: BlockSizeType): Smallint;
    procedure Set_BlockSize(nType: BlockSizeType; pVal: Smallint);
    function  Get_Retries(nType: RetryType): Smallint;
    procedure Set_Retries(nType: RetryType; pVal: Smallint);
    function  Get_Timeout(nType: TimeoutType): Smallint;
    procedure Set_Timeout(nType: TimeoutType; pVal: Smallint);
    function  Get_Trace: Smallint;
    procedure Set_Trace(pVal: Smallint);
    function  Get_Symbols: OleVariant;
    procedure Set_Symbols(pVal: OleVariant);
    function  Get_PortName: WideString;
    function  Get_PortType: LinkType;
    function  Get_HelpFile: WideString;
    function  Get_PortTxBaudRate: Smallint;
    procedure Set_PortTxBaudRate(pVal: Smallint);
    function  Get_PortRxBaudRate: Smallint;
    procedure Set_PortRxBaudRate(pVal: Smallint);
    function  Get_PortMode: ModeType;
    procedure Set_PortMode(pVal: ModeType);
    function  Get_PortEndian: EndianType;
    procedure Set_PortEndian(pVal: EndianType);
    function  Get_BrickVersion: WideString;
    function  Get_FreeRAM: Smallint;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IVPBrick);
    procedure Disconnect; override;
    procedure FindPort(var strPort: WideString);
    procedure Open(const strPort: WideString);
    procedure Close;
    function  Status(nRequest: StatusRequest): StatusResult;
    function  Execute(var strCommand: WideString; var nCodeType: CodeType; out nErrPos: Integer): Integer; overload;
    function  Execute(var strCommand: WideString; var nCodeType: CodeType; out nErrPos: Integer; 
                      out pResult: OleVariant): Integer; overload;
    procedure Validate(var strProgram: WideString; var nCodeType: CodeType; out nErrPos: Integer);
    procedure Download(var strProgram: WideString; var nCodeType: CodeType; out nErrPos: Integer);
    procedure DownloadFirmware(const strFilename: WideString);
    procedure MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                     out nDataLast: Integer); overload;
    procedure MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                     out nDataLast: Integer; out pTasks: OleVariant); overload;
    procedure MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                     out nDataLast: Integer; out pTasks: OleVariant; out pSubs: OleVariant); overload;
    procedure MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                     out nDataLast: Integer; out pTasks: OleVariant; out pSubs: OleVariant; 
                     out pSounds: OleVariant); overload;
    procedure MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                     out nDataLast: Integer; out pTasks: OleVariant; out pSubs: OleVariant; 
                     out pSounds: OleVariant; out pDisplays: OleVariant); overload;
    function  Upload(nStartAddress: Integer; nSize: Integer): OleVariant;
    procedure GetStatistics(out nRequests: Integer; out nFails: Integer; out nAborts: Integer; 
                            out nTxRequests: Integer; out nTxFails: Integer; 
                            out nRxRequests: Integer; out nRxErrors: Integer);
    procedure GetInfo(out nProgramSlots: Integer; out nOutputs: Integer; out nInputs: Integer; 
                      out nGlobals: Integer; out nLocals: Integer; out nTasks: Integer; 
                      out nSubs: Integer; out nTimers: Integer; out nCounters: Integer; 
                      out nSemaphores: Integer; out nRAM: Integer);
    procedure Monitor(bMonitor: WordBool);
    procedure EnumBrickTypes(var nBrickType: Smallint; out strBrickName: WideString);
    property  DefaultInterface: IVPBrick read GetDefaultInterface;
    property BlockSize[nType: BlockSizeType]: Smallint read Get_BlockSize write Set_BlockSize;
    property Retries[nType: RetryType]: Smallint read Get_Retries write Set_Retries;
    property Timeout[nType: TimeoutType]: Smallint read Get_Timeout write Set_Timeout;
    property Symbols: OleVariant read Get_Symbols write Set_Symbols;
    property PortName: WideString read Get_PortName;
    property PortType: LinkType read Get_PortType;
    property HelpFile: WideString read Get_HelpFile;
    property BrickVersion: WideString read Get_BrickVersion;
    property FreeRAM: Smallint read Get_FreeRAM;
    property BrickType: Smallint read Get_BrickType write Set_BrickType;
    property Path: WideString read Get_Path write Set_Path;
    property ProgramSlot: Smallint read Get_ProgramSlot write Set_ProgramSlot;
    property PortTxRange: RangeType read Get_PortTxRange write Set_PortTxRange;
    property BrickTxRange: RangeType read Get_BrickTxRange write Set_BrickTxRange;
    property PowerDownTime: Smallint read Get_PowerDownTime write Set_PowerDownTime;
    property Trace: Smallint read Get_Trace write Set_Trace;
    property PortTxBaudRate: Smallint read Get_PortTxBaudRate write Set_PortTxBaudRate;
    property PortRxBaudRate: Smallint read Get_PortRxBaudRate write Set_PortRxBaudRate;
    property PortMode: ModeType read Get_PortMode write Set_PortMode;
    property PortEndian: EndianType read Get_PortEndian write Set_PortEndian;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TVPBrickProperties read GetServerProperties;
{$ENDIF}
    property OnDownloadProgress: TVPBrickDownloadProgress read FOnDownloadProgress write FOnDownloadProgress;
    property OnDownloadDone: TVPBrickDownloadDone read FOnDownloadDone write FOnDownloadDone;
    property OnReceived: TVPBrickReceived read FOnReceived write FOnReceived;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TVPBrick
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TVPBrickProperties = class(TPersistent)
  private
    FServer:    TVPBrick;
    function    GetDefaultInterface: IVPBrick;
    constructor Create(AServer: TVPBrick);
  protected
    function  Get_BrickType: Smallint;
    procedure Set_BrickType(pVal: Smallint);
    function  Get_Path: WideString;
    procedure Set_Path(const pVal: WideString);
    function  Get_ProgramSlot: Smallint;
    procedure Set_ProgramSlot(pVal: Smallint);
    function  Get_PortTxRange: RangeType;
    procedure Set_PortTxRange(pVal: RangeType);
    function  Get_BrickTxRange: RangeType;
    procedure Set_BrickTxRange(pVal: RangeType);
    function  Get_PowerDownTime: Smallint;
    procedure Set_PowerDownTime(pVal: Smallint);
    function  Get_BlockSize(nType: BlockSizeType): Smallint;
    procedure Set_BlockSize(nType: BlockSizeType; pVal: Smallint);
    function  Get_Retries(nType: RetryType): Smallint;
    procedure Set_Retries(nType: RetryType; pVal: Smallint);
    function  Get_Timeout(nType: TimeoutType): Smallint;
    procedure Set_Timeout(nType: TimeoutType; pVal: Smallint);
    function  Get_Trace: Smallint;
    procedure Set_Trace(pVal: Smallint);
    function  Get_Symbols: OleVariant;
    procedure Set_Symbols(pVal: OleVariant);
    function  Get_PortName: WideString;
    function  Get_PortType: LinkType;
    function  Get_HelpFile: WideString;
    function  Get_PortTxBaudRate: Smallint;
    procedure Set_PortTxBaudRate(pVal: Smallint);
    function  Get_PortRxBaudRate: Smallint;
    procedure Set_PortRxBaudRate(pVal: Smallint);
    function  Get_PortMode: ModeType;
    procedure Set_PortMode(pVal: ModeType);
    function  Get_PortEndian: EndianType;
    procedure Set_PortEndian(pVal: EndianType);
    function  Get_BrickVersion: WideString;
    function  Get_FreeRAM: Smallint;
  public
    property DefaultInterface: IVPBrick read GetDefaultInterface;
  published
    property BrickType: Smallint read Get_BrickType write Set_BrickType;
    property Path: WideString read Get_Path write Set_Path;
    property ProgramSlot: Smallint read Get_ProgramSlot write Set_ProgramSlot;
    property PortTxRange: RangeType read Get_PortTxRange write Set_PortTxRange;
    property BrickTxRange: RangeType read Get_BrickTxRange write Set_BrickTxRange;
    property PowerDownTime: Smallint read Get_PowerDownTime write Set_PowerDownTime;
    property Trace: Smallint read Get_Trace write Set_Trace;
    property PortTxBaudRate: Smallint read Get_PortTxBaudRate write Set_PortTxBaudRate;
    property PortRxBaudRate: Smallint read Get_PortRxBaudRate write Set_PortRxBaudRate;
    property PortMode: ModeType read Get_PortMode write Set_PortMode;
    property PortEndian: EndianType read Get_PortEndian write Set_PortEndian;
  end;
{$ENDIF}


procedure Register;

implementation

uses ComObj;

class function CoVPBrick.Create: IVPBrick;
begin
  Result := CreateComObject(CLASS_VPBrick) as IVPBrick;
end;

class function CoVPBrick.CreateRemote(const MachineName: string): IVPBrick;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VPBrick) as IVPBrick;
end;

procedure TVPBrick.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{534E058F-2D76-11D4-BBFD-00105A48D3F9}';
    IntfIID:   '{534E058E-2D76-11D4-BBFD-00105A48D3F9}';
    EventIID:  '{F52EF661-2E3F-11D4-BBFD-00105A48D3F9}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TVPBrick.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IVPBrick;
  end;
end;

procedure TVPBrick.ConnectTo(svrIntf: IVPBrick);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TVPBrick.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TVPBrick.GetDefaultInterface: IVPBrick;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TVPBrick.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TVPBrickProperties.Create(Self);
{$ENDIF}
end;

destructor TVPBrick.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TVPBrick.GetServerProperties: TVPBrickProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TVPBrick.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
   1: if Assigned(FOnDownloadProgress) then
            FOnDownloadProgress(Self, Params[0] {Integer});
   2: if Assigned(FOnDownloadDone) then
            FOnDownloadDone(Self, Params[0] {Integer});
   3: if Assigned(FOnReceived) then
            FOnReceived(Self, Params[0] {const WideString});
  end; {case DispID}
end;

function  TVPBrick.Get_BrickType: Smallint;
begin
  Result := DefaultInterface.Get_BrickType;
end;

procedure TVPBrick.Set_BrickType(pVal: Smallint);
begin
  DefaultInterface.Set_BrickType(pVal);
end;

function  TVPBrick.Get_Path: WideString;
begin
  Result := DefaultInterface.Get_Path;
end;

procedure TVPBrick.Set_Path(const pVal: WideString);
begin
  DefaultInterface.Set_Path(pVal);
end;

function  TVPBrick.Get_ProgramSlot: Smallint;
begin
  Result := DefaultInterface.Get_ProgramSlot;
end;

procedure TVPBrick.Set_ProgramSlot(pVal: Smallint);
begin
  DefaultInterface.Set_ProgramSlot(pVal);
end;

function  TVPBrick.Get_PortTxRange: RangeType;
begin
  Result := DefaultInterface.Get_PortTxRange;
end;

procedure TVPBrick.Set_PortTxRange(pVal: RangeType);
begin
  DefaultInterface.Set_PortTxRange(pVal);
end;

function  TVPBrick.Get_BrickTxRange: RangeType;
begin
  Result := DefaultInterface.Get_BrickTxRange;
end;

procedure TVPBrick.Set_BrickTxRange(pVal: RangeType);
begin
  DefaultInterface.Set_BrickTxRange(pVal);
end;

function  TVPBrick.Get_PowerDownTime: Smallint;
begin
  Result := DefaultInterface.Get_PowerDownTime;
end;

procedure TVPBrick.Set_PowerDownTime(pVal: Smallint);
begin
  DefaultInterface.Set_PowerDownTime(pVal);
end;

function  TVPBrick.Get_BlockSize(nType: BlockSizeType): Smallint;
begin
  Result := DefaultInterface.Get_BlockSize(nType);
end;

procedure TVPBrick.Set_BlockSize(nType: BlockSizeType; pVal: Smallint);
begin
  DefaultInterface.Set_BlockSize(nType, pVal);
end;

function  TVPBrick.Get_Retries(nType: RetryType): Smallint;
begin
  Result := DefaultInterface.Get_Retries(nType);
end;

procedure TVPBrick.Set_Retries(nType: RetryType; pVal: Smallint);
begin
  DefaultInterface.Set_Retries(nType, pVal);
end;

function  TVPBrick.Get_Timeout(nType: TimeoutType): Smallint;
begin
  Result := DefaultInterface.Get_Timeout(nType);
end;

procedure TVPBrick.Set_Timeout(nType: TimeoutType; pVal: Smallint);
begin
  DefaultInterface.Set_Timeout(nType, pVal);
end;

function  TVPBrick.Get_Trace: Smallint;
begin
  Result := DefaultInterface.Get_Trace;
end;

procedure TVPBrick.Set_Trace(pVal: Smallint);
begin
  DefaultInterface.Set_Trace(pVal);
end;

function  TVPBrick.Get_Symbols: OleVariant;
begin
  Result := DefaultInterface.Get_Symbols;
end;

procedure TVPBrick.Set_Symbols(pVal: OleVariant);
begin
  DefaultInterface.Set_Symbols(pVal);
end;

function  TVPBrick.Get_PortName: WideString;
begin
  Result := DefaultInterface.Get_PortName;
end;

function  TVPBrick.Get_PortType: LinkType;
begin
  Result := DefaultInterface.Get_PortType;
end;

function  TVPBrick.Get_HelpFile: WideString;
begin
  Result := DefaultInterface.Get_HelpFile;
end;

function  TVPBrick.Get_PortTxBaudRate: Smallint;
begin
  Result := DefaultInterface.Get_PortTxBaudRate;
end;

procedure TVPBrick.Set_PortTxBaudRate(pVal: Smallint);
begin
  DefaultInterface.Set_PortTxBaudRate(pVal);
end;

function  TVPBrick.Get_PortRxBaudRate: Smallint;
begin
  Result := DefaultInterface.Get_PortRxBaudRate;
end;

procedure TVPBrick.Set_PortRxBaudRate(pVal: Smallint);
begin
  DefaultInterface.Set_PortRxBaudRate(pVal);
end;

function  TVPBrick.Get_PortMode: ModeType;
begin
  Result := DefaultInterface.Get_PortMode;
end;

procedure TVPBrick.Set_PortMode(pVal: ModeType);
begin
  DefaultInterface.Set_PortMode(pVal);
end;

function  TVPBrick.Get_PortEndian: EndianType;
begin
  Result := DefaultInterface.Get_PortEndian;
end;

procedure TVPBrick.Set_PortEndian(pVal: EndianType);
begin
  DefaultInterface.Set_PortEndian(pVal);
end;

function  TVPBrick.Get_BrickVersion: WideString;
begin
  Result := DefaultInterface.Get_BrickVersion;
end;

function  TVPBrick.Get_FreeRAM: Smallint;
begin
  Result := DefaultInterface.Get_FreeRAM;
end;

procedure TVPBrick.FindPort(var strPort: WideString);
begin
  DefaultInterface.FindPort(strPort);
end;

procedure TVPBrick.Open(const strPort: WideString);
begin
  DefaultInterface.Open(strPort);
end;

procedure TVPBrick.Close;
begin
  DefaultInterface.Close;
end;

function  TVPBrick.Status(nRequest: StatusRequest): StatusResult;
begin
  Result := DefaultInterface.Status(nRequest);
end;

function  TVPBrick.Execute(var strCommand: WideString; var nCodeType: CodeType; out nErrPos: Integer): Integer;
begin
  Result := DefaultInterface.Execute(strCommand, nCodeType, nErrPos, EmptyParam);
end;

function  TVPBrick.Execute(var strCommand: WideString; var nCodeType: CodeType; 
                           out nErrPos: Integer; out pResult: OleVariant): Integer;
begin
  Result := DefaultInterface.Execute(strCommand, nCodeType, nErrPos, pResult);
end;

procedure TVPBrick.Validate(var strProgram: WideString; var nCodeType: CodeType; 
                            out nErrPos: Integer);
begin
  DefaultInterface.Validate(strProgram, nCodeType, nErrPos);
end;

procedure TVPBrick.Download(var strProgram: WideString; var nCodeType: CodeType; 
                            out nErrPos: Integer);
begin
  DefaultInterface.Download(strProgram, nCodeType, nErrPos);
end;

procedure TVPBrick.DownloadFirmware(const strFilename: WideString);
begin
  DefaultInterface.DownloadFirmware(strFilename);
end;

procedure TVPBrick.MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                          out nDataLast: Integer);
begin
  DefaultInterface.MemMap(nMemLast, nMemTop, nDataStart, nDataLast, EmptyParam, EmptyParam, 
                          EmptyParam, EmptyParam);
end;

procedure TVPBrick.MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                          out nDataLast: Integer; out pTasks: OleVariant);
begin
  DefaultInterface.MemMap(nMemLast, nMemTop, nDataStart, nDataLast, pTasks, EmptyParam, EmptyParam, 
                          EmptyParam);
end;

procedure TVPBrick.MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                          out nDataLast: Integer; out pTasks: OleVariant; out pSubs: OleVariant);
begin
  DefaultInterface.MemMap(nMemLast, nMemTop, nDataStart, nDataLast, pTasks, pSubs, EmptyParam, 
                          EmptyParam);
end;

procedure TVPBrick.MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                          out nDataLast: Integer; out pTasks: OleVariant; out pSubs: OleVariant; 
                          out pSounds: OleVariant);
begin
  DefaultInterface.MemMap(nMemLast, nMemTop, nDataStart, nDataLast, pTasks, pSubs, pSounds, 
                          EmptyParam);
end;

procedure TVPBrick.MemMap(out nMemLast: Integer; out nMemTop: Integer; out nDataStart: Integer; 
                          out nDataLast: Integer; out pTasks: OleVariant; out pSubs: OleVariant; 
                          out pSounds: OleVariant; out pDisplays: OleVariant);
begin
  DefaultInterface.MemMap(nMemLast, nMemTop, nDataStart, nDataLast, pTasks, pSubs, pSounds, 
                          pDisplays);
end;

function  TVPBrick.Upload(nStartAddress: Integer; nSize: Integer): OleVariant;
begin
  Result := DefaultInterface.Upload(nStartAddress, nSize);
end;

procedure TVPBrick.GetStatistics(out nRequests: Integer; out nFails: Integer; out nAborts: Integer; 
                                 out nTxRequests: Integer; out nTxFails: Integer; 
                                 out nRxRequests: Integer; out nRxErrors: Integer);
begin
  DefaultInterface.GetStatistics(nRequests, nFails, nAborts, nTxRequests, nTxFails, nRxRequests, 
                                 nRxErrors);
end;

procedure TVPBrick.GetInfo(out nProgramSlots: Integer; out nOutputs: Integer; out nInputs: Integer; 
                           out nGlobals: Integer; out nLocals: Integer; out nTasks: Integer; 
                           out nSubs: Integer; out nTimers: Integer; out nCounters: Integer; 
                           out nSemaphores: Integer; out nRAM: Integer);
begin
  DefaultInterface.GetInfo(nProgramSlots, nOutputs, nInputs, nGlobals, nLocals, nTasks, nSubs, 
                           nTimers, nCounters, nSemaphores, nRAM);
end;

procedure TVPBrick.Monitor(bMonitor: WordBool);
begin
  DefaultInterface.Monitor(bMonitor);
end;

procedure TVPBrick.EnumBrickTypes(var nBrickType: Smallint; out strBrickName: WideString);
begin
  DefaultInterface.EnumBrickTypes(nBrickType, strBrickName);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TVPBrickProperties.Create(AServer: TVPBrick);
begin
  inherited Create;
  FServer := AServer;
end;

function TVPBrickProperties.GetDefaultInterface: IVPBrick;
begin
  Result := FServer.DefaultInterface;
end;

function  TVPBrickProperties.Get_BrickType: Smallint;
begin
  Result := DefaultInterface.Get_BrickType;
end;

procedure TVPBrickProperties.Set_BrickType(pVal: Smallint);
begin
  DefaultInterface.Set_BrickType(pVal);
end;

function  TVPBrickProperties.Get_Path: WideString;
begin
  Result := DefaultInterface.Get_Path;
end;

procedure TVPBrickProperties.Set_Path(const pVal: WideString);
begin
  DefaultInterface.Set_Path(pVal);
end;

function  TVPBrickProperties.Get_ProgramSlot: Smallint;
begin
  Result := DefaultInterface.Get_ProgramSlot;
end;

procedure TVPBrickProperties.Set_ProgramSlot(pVal: Smallint);
begin
  DefaultInterface.Set_ProgramSlot(pVal);
end;

function  TVPBrickProperties.Get_PortTxRange: RangeType;
begin
  Result := DefaultInterface.Get_PortTxRange;
end;

procedure TVPBrickProperties.Set_PortTxRange(pVal: RangeType);
begin
  DefaultInterface.Set_PortTxRange(pVal);
end;

function  TVPBrickProperties.Get_BrickTxRange: RangeType;
begin
  Result := DefaultInterface.Get_BrickTxRange;
end;

procedure TVPBrickProperties.Set_BrickTxRange(pVal: RangeType);
begin
  DefaultInterface.Set_BrickTxRange(pVal);
end;

function  TVPBrickProperties.Get_PowerDownTime: Smallint;
begin
  Result := DefaultInterface.Get_PowerDownTime;
end;

procedure TVPBrickProperties.Set_PowerDownTime(pVal: Smallint);
begin
  DefaultInterface.Set_PowerDownTime(pVal);
end;

function  TVPBrickProperties.Get_BlockSize(nType: BlockSizeType): Smallint;
begin
  Result := DefaultInterface.Get_BlockSize(nType);
end;

procedure TVPBrickProperties.Set_BlockSize(nType: BlockSizeType; pVal: Smallint);
begin
  DefaultInterface.Set_BlockSize(nType, pVal);
end;

function  TVPBrickProperties.Get_Retries(nType: RetryType): Smallint;
begin
  Result := DefaultInterface.Get_Retries(nType);
end;

procedure TVPBrickProperties.Set_Retries(nType: RetryType; pVal: Smallint);
begin
  DefaultInterface.Set_Retries(nType, pVal);
end;

function  TVPBrickProperties.Get_Timeout(nType: TimeoutType): Smallint;
begin
  Result := DefaultInterface.Get_Timeout(nType);
end;

procedure TVPBrickProperties.Set_Timeout(nType: TimeoutType; pVal: Smallint);
begin
  DefaultInterface.Set_Timeout(nType, pVal);
end;

function  TVPBrickProperties.Get_Trace: Smallint;
begin
  Result := DefaultInterface.Get_Trace;
end;

procedure TVPBrickProperties.Set_Trace(pVal: Smallint);
begin
  DefaultInterface.Set_Trace(pVal);
end;

function  TVPBrickProperties.Get_Symbols: OleVariant;
begin
  Result := DefaultInterface.Get_Symbols;
end;

procedure TVPBrickProperties.Set_Symbols(pVal: OleVariant);
begin
  DefaultInterface.Set_Symbols(pVal);
end;

function  TVPBrickProperties.Get_PortName: WideString;
begin
  Result := DefaultInterface.Get_PortName;
end;

function  TVPBrickProperties.Get_PortType: LinkType;
begin
  Result := DefaultInterface.Get_PortType;
end;

function  TVPBrickProperties.Get_HelpFile: WideString;
begin
  Result := DefaultInterface.Get_HelpFile;
end;

function  TVPBrickProperties.Get_PortTxBaudRate: Smallint;
begin
  Result := DefaultInterface.Get_PortTxBaudRate;
end;

procedure TVPBrickProperties.Set_PortTxBaudRate(pVal: Smallint);
begin
  DefaultInterface.Set_PortTxBaudRate(pVal);
end;

function  TVPBrickProperties.Get_PortRxBaudRate: Smallint;
begin
  Result := DefaultInterface.Get_PortRxBaudRate;
end;

procedure TVPBrickProperties.Set_PortRxBaudRate(pVal: Smallint);
begin
  DefaultInterface.Set_PortRxBaudRate(pVal);
end;

function  TVPBrickProperties.Get_PortMode: ModeType;
begin
  Result := DefaultInterface.Get_PortMode;
end;

procedure TVPBrickProperties.Set_PortMode(pVal: ModeType);
begin
  DefaultInterface.Set_PortMode(pVal);
end;

function  TVPBrickProperties.Get_PortEndian: EndianType;
begin
  Result := DefaultInterface.Get_PortEndian;
end;

procedure TVPBrickProperties.Set_PortEndian(pVal: EndianType);
begin
  DefaultInterface.Set_PortEndian(pVal);
end;

function  TVPBrickProperties.Get_BrickVersion: WideString;
begin
  Result := DefaultInterface.Get_BrickVersion;
end;

function  TVPBrickProperties.Get_FreeRAM: Smallint;
begin
  Result := DefaultInterface.Get_FreeRAM;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents('ActiveX',[TVPBrick]);
end;

end.
