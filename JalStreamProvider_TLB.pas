unit JalStreamProvider_TLB;

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
// File generated on 4/22/2003 8:41:53 AM from Type Library described below.

// ************************************************************************ //
// Type Lib: C:\winapps\borland\Delphi5\Projects\JalSS\JalStreamProvider.tlb (1)
// IID\LCID: {200D0306-9D69-4615-A271-05246BD610EB}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
//   (3) v1.0 WMSCLIENTNETMGRLib, (C:\WINNT\System32\wmnetmgr.dll)
//   (4) v1.0 stdole, (C:\WINNT\system32\stdole32.tlb)
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
  JalStreamProviderMajorVersion = 1;
  JalStreamProviderMinorVersion = 0;

  LIBID_JalStreamProvider: TGUID = '{200D0306-9D69-4615-A271-05246BD610EB}';

  IID_IJalStream: TGUID = '{DA1A399D-C815-44FB-B71E-DFC199405402}';
  CLASS_JalStream: TGUID = '{8C04C683-68AE-481E-ACA8-CF6167F6C6AF}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IJalStream = interface;
  IJalStreamDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  JalStream = IJalStream;


// *********************************************************************//
// Interface: IJalStream
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA1A399D-C815-44FB-B71E-DFC199405402}
// *********************************************************************//
  IJalStream = interface(IDispatch)
    ['{DA1A399D-C815-44FB-B71E-DFC199405402}']
  end;

// *********************************************************************//
// DispIntf:  IJalStreamDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DA1A399D-C815-44FB-B71E-DFC199405402}
// *********************************************************************//
  IJalStreamDisp = dispinterface
    ['{DA1A399D-C815-44FB-B71E-DFC199405402}']
  end;

// *********************************************************************//
// The Class CoJalStream provides a Create and CreateRemote method to          
// create instances of the default interface IJalStream exposed by              
// the CoClass JalStream. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoJalStream = class
    class function Create: IJalStream;
    class function CreateRemote(const MachineName: string): IJalStream;
  end;

implementation

uses ComObj;

class function CoJalStream.Create: IJalStream;
begin
  Result := CreateComObject(CLASS_JalStream) as IJalStream;
end;

class function CoJalStream.CreateRemote(const MachineName: string): IJalStream;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_JalStream) as IJalStream;
end;

end.
