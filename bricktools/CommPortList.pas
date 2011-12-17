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
 * Portions created by John Hansen are Copyright (C) 2009-2011 John Hansen.
 * All Rights Reserved.
 *
 *)
unit CommPortList;

interface

uses Windows, Classes;

function CheckOS(var VersionInfo : TOSVersionInfo) : Integer;

procedure GetPortList(Strings : TStrings);

implementation

{$BOOLEVAL OFF}

uses
  Registry, SysUtils;

function CheckOS(var VersionInfo : TOSVersionInfo) : Integer;
begin
  VersionInfo.dwOSVersionInfoSize := SizeOf(VersionInfo);
  if GetVersionEx(VersionInfo) then
    Result := VersionInfo.dwPlatformId
  else
    Result := -1;
end;

procedure GetPortList(Strings : TStrings);
var
  Reg : TRegistry;

  procedure ScanRegHardware;
  var
    i : integer;
    PortName : string;
    LName : TStringList;
  begin
    if Reg.OpenKeyReadOnly('\hardware\devicemap\serialcomm') then
    begin
      LName := TStringList.Create;
      try
        Reg.GetValueNames(LName);
        for i := 0 to LName.Count - 1 do
        begin
          if Reg.GetDataType(LName.Strings[i]) = rdString then
          begin
            PortName := Reg.ReadString(LName.Strings[i]);
            if Strings.IndexOf(PortName) < 0 then
              Strings.Add(PortName);
          end;
        end;
      finally
        LName.Free;
      end;
    end;
  end;

  // This Subprocedure recurses thru all keys below key
  procedure ScanRegEnum(Key : String);
  var
    LKey : TStringList;
    LName : TStringList;
    i : Integer;
    Driver, PortName : String;
    PortSubClass : Byte;
  begin
    if not Reg.OpenKeyReadOnly(Key) then // Danke Andreas Schmidt!
      Exit;
    LName := TStringList.Create;
    try
      Reg.GetValueNames(LName);
      i := LName.IndexOf('class');
      if i >= 0 then
      begin
        if (Reg.GetDataType('class') = rdString) and
           ((LowerCase(Reg.ReadString('class')) = 'ports') or //normal Serialports like COMx
            (LowerCase(Reg.ReadString('class')) = 'modem')) and //some abnormal onboard Modems
           (Reg.GetDataType('driver') = rdString) and
           (Reg.GetDataType('portname') = rdString) then
        begin
          Driver := Reg.ReadString('driver');
          PortName := Reg.ReadString('portname');
          if Reg.OpenKeyReadOnly('\System\CurrentControlSet\Services\Class\'+ Driver) and
             (Reg.ReadBinaryData('PortSubClass',PortSubClass,1) = 1) and
             ((PortSubClass = 1) or //Ports
              (PortSubClass = 2)) and //Modems
             (Strings.IndexOf(PortName) < 0) then
            Strings.Add(PortName);
        end;
      end;
    finally
      LName.Free;
    end
    Reg.OpenKeyReadOnly(Key);
    if Reg.HasSubKeys then
    begin
      LKey := TStringList.Create;
      try
        Reg.GetKeyNames(LKey);
        for i := 0 to LKey.Count - 1 do
        begin
          ScanRegEnum(Key + '\' + LKey[i]);
        end;
      finally
        LKey.Free;
      end;
    end;
  end;

var
  VersionInfo : TOSVersionInfo;
begin
  if CheckOS(VersionInfo) > 0 then
    if VersionInfo.dwMajorVersion >= 4 then
    begin
      Reg := TRegistry.Create;
      try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        if VersionInfo.dwMajorVersion > 4 then
          ScanRegHardware //Win 2k, XP
        else if VersionInfo.dwMinorVersion > 0 then
          ScanRegEnum('\enum') //Win9x, mE
        else
          ScanRegHardware; //WinNT
      finally
        Reg.Free;
      end;
    end;
end;

end.