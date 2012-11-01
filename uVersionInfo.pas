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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uVersionInfo;

interface

type
  TVersionAttributes = record
    PrivateBuild : Boolean;
    SpecialBuild : Boolean;
    PreRelease   : Boolean;
    Debug        : Boolean;
    InfoInferred : Boolean;
    Patched      : Boolean;
  end;

  TVersionInfo = record
    CompanyName      : String;
    FileDescription  : String;
    FileVersion      : String;
    InternalName     : String;
    LegalCopyright   : String;
    OriginalFileName : String;
    ProductName      : String;
    ProductVersion   : String;
    Comments         : String;
    FileFlags        : TVersionAttributes;
  end;

function GetVersionInfo(const FileName: String): TVersionInfo;
function GetProductVersion : string;

var
  VerCompanyName : string = '';
  VerFileDescription : string = '';
  VerFileVersion : string = '';
  VerInternalName : string = '';
  VerLegalCopyright : string = '';
  VerOriginalFileName : string = '';
  VerProductName : string = '';
  VerProductVersion : string = '';
  VerComments : string = '';


implementation

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  SysUtils;

{$IFNDEF FPC}
function GetProductVersion : string;
var
  VI : TVersionInfo;
begin
  VI := GetVersionInfo(ParamStr(0));
  Result := VI.ProductVersion;
end;

function GetVersionInfo(const FileName: String): TVersionInfo;
var
  PBlock : Pointer;
  BlockSize : Cardinal;
  Dummy : DWORD;
  Name : Array[0..1024] of Char;
  V : TVersionInfo;
  pTransTable: PLongint;
  sFileInfo:   string;

  function VerValue(P: Pointer;Value: String): String;
  var
    Dummy : UINT;
    Buffer : Pointer;
    S : String;
    B : Array[0..1024] of Char;
    T : Array[0..1024] of Char;
  begin
    S := sFileInfo + Value ;
    StrPCopy(B,S);
    Buffer := @T[1] ;
    VerQueryValue(P,B,Buffer,Dummy);
    Result := StrPas(Buffer);
  end;

  function AnalyzeFlags(const AFileFlags : Integer) : TVersionAttributes;
  var sflag,dflag, pflag, rflag, vflag, iflag : integer;
      temp : TVersionAttributes;
  begin
   	temp.SpecialBuild := False;
    temp.PrivateBuild := False;
    temp.PreRelease := False;
    temp.Debug := False;
    temp.InfoInferred := False;
    temp.Patched := False;

     // and returns type according to operand types
    sflag := AFileFlags and VS_FF_SPECIALBUILD;
    dflag := AFileFlags and VS_FF_DEBUG;
    rflag := AFileFlags and VS_FF_PRERELEASE;
    pflag := AFileFlags and VS_FF_PATCHED;
    vflag := AFileFlags and VS_FF_PRIVATEBUILD;
    iflag := AFileFlags and VS_FF_INFOINFERRED;

    if (sflag = VS_FF_SPECIALBUILD) then
      temp.SpecialBuild := True;

    if (dflag = VS_FF_DEBUG) then
      temp.Debug := True;

    if (rflag = VS_FF_PRERELEASE) then
      temp.PreRelease := True;

    if (pflag = VS_FF_PATCHED) then
      temp.Patched := True;

    if (vflag = VS_FF_PRIVATEBUILD) then
      temp.PrivateBuild := True;

    if (iflag = VS_FF_INFOINFERRED) then
      temp.InfoInferred := True;

    Result := temp;
  end;

  // get the fixed file attribute -FileFlags
  function VerFixedValue(P: Pointer): TVersionAttributes;
  var
    Dummy : UINT;
    Buffer : Pointer;
    sts : Boolean;
    S : String;
    B : Array[0..1024] of Char;
    T : Array[0..1024] of Char;
    Fl : DWord;
    V : PVSFixedFileInfo;
  begin
    S := '\';
    StrPCopy(B,S);
    Buffer := @T[1] ;
    sts := VerQueryValue(P,B,Buffer,Dummy);

    if sts then
    begin
      V := Buffer;
      Fl := V.dwFileFlags;
      Result := AnalyzeFlags(Fl);
    end;
  end;

begin
  StrPCopy(Name, FileName);
  BlockSize := GetFileVersionInfoSize(Name,Dummy);

  if BlockSize > 0 then begin
    GetMem(PBlock,2*BlockSize);
    try
      if GetFileVersionInfo(Name,Dummy,BlockSize,PBlock) then begin
        if VerQueryValue(PBlock, '\VarFileInfo\Translation', Pointer(pTransTable), BlockSize) then
          sFileInfo := Format('\StringFileInfo\%.4x%.4x\', [LoWord(pTransTable^), HiWord(pTransTable^)])
        else
          sFileInfo := '\StringFileInfo\040904e4\';
        V.CompanyName      := VerValue(PBlock,'CompanyName');
        V.FileDescription  := VerValue(PBlock,'FileDescription');
        V.FileVersion      := VerValue(PBlock,'FileVersion');
        V.InternalName     := VerValue(PBlock,'InternalName');
        V.LegalCopyright   := VerValue(PBlock,'LegalCopyright');
        V.OriginalFileName := VerValue(PBlock,'OriginalFileName');
        V.ProductName      := VerValue(PBlock,'ProductName');
        V.ProductVersion   := VerValue(PBlock,'ProductVersion');
        V.Comments         := VerValue(PBlock,'Comments');
        V.FileFlags        := VerFixedValue(PBlock);
      end;
    finally
      FreeMem(PBlock);
    end;
  end;
  Result := V ;
end;

{$ELSE}

function VerFixedValue: TVersionAttributes;
begin
  Result.PrivateBuild := False;
  Result.SpecialBuild := False;
  Result.PreRelease := False;
  Result.Debug := False;
  Result.InfoInferred := False;
  Result.Patched := False;
end;

function GetProductVersion : string;
begin
  Result := VerProductVersion;
end;

function GetVersionInfo(const FileName: String): TVersionInfo;
begin
  Result.CompanyName      := VerCompanyName;
  Result.FileDescription  := VerFileDescription;
  Result.FileVersion      := VerFileVersion;
  Result.InternalName     := VerInternalName;
  Result.LegalCopyright   := VerLegalCopyright;
  Result.OriginalFileName := VerOriginalFileName;
  Result.ProductName      := VerProductName;
  Result.ProductVersion   := VerProductVersion;
  Result.Comments         := VerComments;
  Result.FileFlags        := VerFixedValue;
  if FileName = 'xyzzy' then
    Result.Comments := FileName;
end;

{$ENDIF}


end.