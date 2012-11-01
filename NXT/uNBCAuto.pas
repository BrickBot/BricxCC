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
unit uNBCAuto;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, NBCAutoLib_TLB, StdVcl, Classes,
  uSpirit,
  FantomSpirit
  ;

type
  TNBCAuto = class(TAutoObject, INBCAuto)
  private
    function compile(aStream : TStream; optLevel : byte;
      bOutput, bDownload : boolean;
      const port, filename, includes, defines, outputfile: WideString;
      out Errors, Symbols, Listing: WideString): WordBool; safecall;
  protected
    function compilefile(const filename, includes, defines, outputfile,
      port: WideString; optLevel: Shortint; bOutput, bDownload: WordBool;
      out Errors, Symbols, Listing: WideString): WordBool; safecall;
    function compiletext(const sourcecode, filename, includes, defines,
      outputfile, port: WideString; optLevel: Shortint; bOutput,
      bDownload: WordBool; out Errors, Symbols,
      Listing: WideString): WordBool; safecall;
  end;

implementation

uses
  ComServ,
  SysUtils,
  Math,
  uRPGComp,
  uNXCComp,
  uNXTClasses
;

var
  TC : TNXCComp;
  RC : TRPGComp;
  BC : TBrickComm;

function BrickComm : TBrickComm;
begin
  if not Assigned(BC) then
  begin
    BC := TFantomSpirit.Create();
  end;
  Result := BC;
end;


function TNBCAuto.compile(aStream : TStream; optLevel : byte;
  bOutput, bDownload : boolean;
  const port, filename, includes, defines, outputfile: WideString;
  out Errors, Symbols, Listing: WideString): WordBool;
var
  C : TRXEProgram;
  sOut : TMemoryStream;
  incDirs : string;
  i : integer;
  tmpIncDirs : TStringList;
begin
  aStream.Position := 0;
  if bDownload then
  begin
    BrickComm.BrickType := rtNXT;
    if port <> '' then
      BrickComm.Port := port
    else
      BrickComm.Port := 'usb';
//    BrickComm.UseBluetooth := ParamSwitch('-BT');
  end;
  tmpIncDirs := TStringList.Create;
  try
    if includes <> '' then
    begin
      incDirs := includes;
      // does the path contain ';'?  If so parse
      i := Pos(';', incDirs);
      while i > 0 do begin
        tmpIncDirs.Add(Copy(incDirs, 1, i-1));
        Delete(incDirs, 1, i);
        i := Pos(';', incDirs);
      end;
      tmpIncDirs.Add(incDirs);
    end;
    if LowerCase(ExtractFileExt(Filename)) = '.npg' then
    begin
      // RPG compiler
      RC := TRPGComp.Create;
      try
        RC.CurrentFile := filename;
        try
          RC.Parse(aStream);
          sOut := TMemoryStream.Create;
          try
            if RC.SaveToStream(sOut) then
            begin
              if bDownload then
              begin
                // download the compiled code to the brick
                if not BrickComm.IsOpen then
                  BrickComm.Open;
                BrickComm.DownloadStream(sOut, ChangeFileExt(outputfile, '.rpg'), nftOther);
              end;
              if bOutput then
                sOut.SaveToFile(outputfile);
            end;
          finally
            sOut.Free;
          end;
        finally
          Errors := RC.CompilerMessages.Text;
        end;
      finally
        RC.Free;
      end;
    end
    else
    begin
      if LowerCase(ExtractFileExt(filename)) = '.nxc' then
      begin
        TC := TNXCComp.Create;
        try
          TC.IncludeDirs.AddStrings(tmpIncDirs);
          TC.CurrentFile := filename;
          try
            TC.Parse(aStream);
            aStream.Size := 0;
            TC.NBCSource.SaveToStream(aStream);
            optLevel := Max(optLevel, 1);
            aStream.Position := 0;
          except
            // write compiler messages to output
            Errors := TC.CompilerMessages.Text;
            raise;
          end;
        finally
          TC.Free;
        end;
      end;
      // compile the nbc file
      C := TRXEProgram.Create;
      try
        C.ReturnRequiredInSubroutine := True;
        C.OptimizeLevel := optLevel;
        try
          if includes <> '' then
          begin
            incDirs := includes;
            // does the path contain ';'?  If so parse
            i := Pos(';', incDirs);
            while i > 0 do begin
              C.IncludeDirs.Add(Copy(incDirs, 1, i-1));
              Delete(incDirs, 1, i);
              i := Pos(';', incDirs);
            end;
            C.IncludeDirs.Add(incDirs);
          end;
          C.CurrentFile := filename;
          C.Parse(aStream);

          sOut := TMemoryStream.Create;
          try
            if C.SaveToStream(sOut) then
            begin
              Listing := C.CompilerOutput.Text;
              Symbols := C.SymbolTable.Text;
              if bDownload then
              begin
                if not BrickComm.IsOpen then
                  BrickComm.Open;
                BrickComm.DownloadStream(sOut, ChangeFileExt(outputfile, '.rxe'), nftProgram);
              end;
              if bOutput then
                sOut.SaveToFile(outputfile);
            end;
          finally
            sOut.Free;
          end;
        finally
          Errors := C.CompilerMessages.Text;
        end;
      finally
        C.Free;
      end;
    end;
  finally
    tmpIncDirs.Free;
  end;
end;

function TNBCAuto.compilefile(const filename, includes, defines,
  outputfile, port: WideString; optLevel: Shortint; bOutput,
  bDownload: WordBool; out Errors, Symbols, Listing: WideString): WordBool;
var
  MS : TMemoryStream;
begin
  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile(filename);
    Result := compile(MS, optLevel, bOutput, bDownload, port,
      filename, includes, defines, outputfile, Errors, Symbols, Listing);
  finally
    MS.Free;
  end;
end;

function TNBCAuto.compiletext(const sourcecode, filename, includes,
  defines, outputfile, port: WideString; optLevel: Shortint; bOutput,
  bDownload: WordBool; out Errors, Symbols, Listing: WideString): WordBool;
var
  SS : TStringStream;
begin
  SS := TStringStream.Create(sourcecode);
  try
    Result := compile(SS, optLevel, bOutput, bDownload, port,
      filename, includes, defines, outputfile, Errors, Symbols, Listing);
  finally
    SS.Free;
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TNBCAuto, Class_NBCAuto,
    ciMultiInstance, tmApartment);
end.