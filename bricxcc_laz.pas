{ This file was automatically created by Lazarus. Do not edit!
This source is only used to compile and install the package.
 }

unit bricxcc_laz; 

interface

uses
  BricxccSynReg, LazarusPackageIntf; 

implementation

procedure Register; 
begin
  RegisterUnit('BricxccSynReg', @BricxccSynReg.Register); 
end; 

initialization
  RegisterPackage('bricxcc_laz', @Register); 
end.
