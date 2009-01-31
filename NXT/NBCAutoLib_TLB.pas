unit NBCAutoLib_TLB;

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
// File generated on 7/2/2007 12:01:08 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: G:\nxt\BricxCC\source\NXT\NBCAutoLib.tlb (1)
// LIBID: {9D60B95C-F9AE-4E9C-AF1C-F00F92DDBF6B}
// LCID: 0
// Helpfile: 
// HelpString: NBCAutoLib Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
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
  NBCAutoLibMajorVersion = 1;
  NBCAutoLibMinorVersion = 0;

  LIBID_NBCAutoLib: TGUID = '{9D60B95C-F9AE-4E9C-AF1C-F00F92DDBF6B}';

  IID_INBCAuto: TGUID = '{C06F983E-1FBC-4108-AFDA-4D1E59430ABA}';
  CLASS_NBCAuto: TGUID = '{EFF09EEA-9575-4E96-847A-59C244B887AB}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  INBCAuto = interface;
  INBCAutoDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  NBCAuto = INBCAuto;


// *********************************************************************//
// Interface: INBCAuto
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C06F983E-1FBC-4108-AFDA-4D1E59430ABA}
// *********************************************************************//
  INBCAuto = interface(IDispatch)
    ['{C06F983E-1FBC-4108-AFDA-4D1E59430ABA}']
    function compilefile(const filename: WideString; const includes: WideString; 
                         const defines: WideString; const outputfile: WideString; 
                         const port: WideString; optLevel: Shortint; bOutput: WordBool; 
                         bDownload: WordBool; out Errors: WideString; out Symbols: WideString; 
                         out Listing: WideString): WordBool; safecall;
    function compiletext(const sourcecode: WideString; const filename: WideString; 
                         const includes: WideString; const defines: WideString; 
                         const outputfile: WideString; const port: WideString; optLevel: Shortint; 
                         bOutput: WordBool; bDownload: WordBool; out Errors: WideString; 
                         out Symbols: WideString; out Listing: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  INBCAutoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C06F983E-1FBC-4108-AFDA-4D1E59430ABA}
// *********************************************************************//
  INBCAutoDisp = dispinterface
    ['{C06F983E-1FBC-4108-AFDA-4D1E59430ABA}']
    function compilefile(const filename: WideString; const includes: WideString; 
                         const defines: WideString; const outputfile: WideString; 
                         const port: WideString; optLevel: {??Shortint}OleVariant; 
                         bOutput: WordBool; bDownload: WordBool; out Errors: WideString; 
                         out Symbols: WideString; out Listing: WideString): WordBool; dispid 201;
    function compiletext(const sourcecode: WideString; const filename: WideString; 
                         const includes: WideString; const defines: WideString; 
                         const outputfile: WideString; const port: WideString; 
                         optLevel: {??Shortint}OleVariant; bOutput: WordBool; bDownload: WordBool; 
                         out Errors: WideString; out Symbols: WideString; out Listing: WideString): WordBool; dispid 202;
  end;

// *********************************************************************//
// The Class CoNBCAuto provides a Create and CreateRemote method to          
// create instances of the default interface INBCAuto exposed by              
// the CoClass NBCAuto. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNBCAuto = class
    class function Create: INBCAuto;
    class function CreateRemote(const MachineName: string): INBCAuto;
  end;

implementation

uses ComObj;

class function CoNBCAuto.Create: INBCAuto;
begin
  Result := CreateComObject(CLASS_NBCAuto) as INBCAuto;
end;

class function CoNBCAuto.CreateRemote(const MachineName: string): INBCAuto;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NBCAuto) as INBCAuto;
end;

end.
