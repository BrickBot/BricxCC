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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uRICCodeComp;

interface

uses
  Classes;

function RICScriptCodeCompIndex(aName : string) : Integer;
procedure AddRICScriptCodeCompParams(aStrings : TStrings; Index : integer);

implementation

uses
  uCppCode;

type
  TRICCodeComp = record
    Name : string;
    Params : string;
  end;

const
  RICScriptCodeCompDataSize = 12;
  RICScriptCodeCompData: array[0..RICScriptCodeCompDataSize-1] of TRICCodeComp = (
    (
     Name: 'desc';
     Params: '(options, width, height)'
    ),
    (
     Name: 'sprite';
     Params: '(addr, rowbits1, rowbits2, rowbits3, rowbitsN)'
    ),
    (
     Name: 'copybits';
     Params: '(options, address, srcX, srcY, srcW, srcH, destX, desY)'
    ),
    (
     Name: 'varmap';
     Params: '(addr, func1, func2, func3, funcN)'
    ),
    (
     Name: 'pixel';
     Params: '(options, x, y, value)'
    ),
    (
     Name: 'line';
     Params: '(options, x1, y1, x2, y2)'
    ),
    (
     Name: 'rect';
     Params: '(options, x, y, width, height)'
    ),
    (
     Name: 'circle';
     Params: '(options, x, y, radius)'
    ),
    (
     Name: 'numbox';
     Params: '(options, x, y, value)'
    ),
    (
     Name: 'arg';
     Params: '(index)'
    ),
    (
     Name: 'maparg';
     Params: '(mapidx, argidx)'
    ),
    (
     Name: 'f';
     Params: '(xval)=yval'
    )
  );

function RICScriptCodeCompIndex(aName : string) : Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to RICScriptCodeCompDataSize - 1 do begin
    if RICScriptCodeCompData[i].Name = aName then begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure AddRICScriptCodeCompParams(aStrings : TStrings; Index : integer);
begin
  if (Index < 0) or (Index >= RICScriptCodeCompDataSize) then Exit;
  AddCodeCompParamsHelper(aStrings, RICScriptCodeCompData[Index].Params, 'void', ',');
end;

end.