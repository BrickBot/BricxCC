unit FakeSpirit_TLB;

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

// PASTLWTR : 1.2
// File generated on 2006-3-31 15:08:26 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\winapps\projects\BricxCC\source\FakeSpirit.tlb (1)
// LIBID: {49E6D1D7-5DAB-4978-9F55-EC28D42185DE}
// LCID: 0
// Helpfile: 
// HelpString: FakeSpirit Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\System32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  FakeSpiritMajorVersion = 1;
  FakeSpiritMinorVersion = 0;

  LIBID_FakeSpirit: TGUID = '{49E6D1D7-5DAB-4978-9F55-EC28D42185DE}';

  IID_IFred: TGUID = '{7DC0B4E9-CC47-492B-8418-E6F97999DF88}';
  DIID_IFredEvents: TGUID = '{7D49813C-5F63-4CB7-A653-4CCABC0C0F4D}';
  CLASS_Fred: TGUID = '{E2B2C4D9-AE42-465B-B5B2-56FA4782536E}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFred = interface;
  IFredDisp = dispinterface;
  IFredEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Fred = IFred;


// *********************************************************************//
// Interface: IFred
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7DC0B4E9-CC47-492B-8418-E6F97999DF88}
// *********************************************************************//
  IFred = interface(IDispatch)
    ['{7DC0B4E9-CC47-492B-8418-E6F97999DF88}']
  end;

// *********************************************************************//
// DispIntf:  IFredDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7DC0B4E9-CC47-492B-8418-E6F97999DF88}
// *********************************************************************//
  IFredDisp = dispinterface
    ['{7DC0B4E9-CC47-492B-8418-E6F97999DF88}']
  end;

// *********************************************************************//
// DispIntf:  IFredEvents
// Flags:     (0)
// GUID:      {7D49813C-5F63-4CB7-A653-4CCABC0C0F4D}
// *********************************************************************//
  IFredEvents = dispinterface
    ['{7D49813C-5F63-4CB7-A653-4CCABC0C0F4D}']
  end;

// *********************************************************************//
// The Class CoFred provides a Create and CreateRemote method to          
// create instances of the default interface IFred exposed by              
// the CoClass Fred. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFred = class
    class function Create: IFred;
    class function CreateRemote(const MachineName: string): IFred;
  end;

implementation

uses ComObj;

class function CoFred.Create: IFred;
begin
  Result := CreateComObject(CLASS_Fred) as IFred;
end;

class function CoFred.CreateRemote(const MachineName: string): IFred;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Fred) as IFred;
end;

end.
