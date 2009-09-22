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
 * Portions of this code are covered under the GExperts license
 * http://www.gexperts.org/license.html
 *
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uGrepCommonUtils;

interface

uses
  Classes, Controls, Dialogs, Forms, SysUtils, Windows;

const
  AllFilesWildCard = '*.*';

function IsCharIdentifier(aCh : Char) : boolean;
function IsEmpty(const Str: string): Boolean;
function PosFrom(const Pat, Text: string; StartIndex: Integer): Integer;
function CaseInsensitivePos(const Pat, Text: string): Integer;
function CaseInsensitivePosFrom(const Pat, Text: string; StartIndex: Integer): Integer;
function AnsiCaseInsensitivePos(const SubString, S: string): Integer;
function StringInArray(const S: string; const SArray: array of string): Boolean;
function FileMatchesExtensions(const FileName, FileExtensions: string): Boolean; overload;
function FileMatchesExtensions(const FileName: string; FileExtensions: array of string): Boolean; overload;
function FileMatchesExtension(const FileName, FileExtension: string): Boolean;
procedure LoadDiskFileToStrings(const FileName: string; Data: TStringList);
function GetOpenSaveDialogExecute(Dialog: TOpenDialog): Boolean;
function LeftTrimChars(var Value: string; const TrimChars: TSysCharSet = [#9, #32]): Integer;
function ShowError(const Error: string): Boolean;
function GetDirectory(var aDir : string) : boolean;
function GetScrollbarWidth : integer;
procedure AnsiStrTok(const Source, Delimiter: string; Dest: TStrings);
function TryFocusControl(Control: TWinControl): Boolean;
procedure AddMRUString(Text: string; List: TStrings; DeleteTrailingDelimiter: Boolean);
procedure DeleteStringFromList(List: TStrings; const Item: string);
procedure EnsureFormVisible(const Form: TCustomForm);
function GetScreenWorkArea(const Form: TCustomForm = nil): TRect;
procedure CenterForm(const Form: TCustomForm);
function GxOtaGetCurrentSelection : string;
function GxOtaGetCurrentIdent : string;
function GxOtaGetFileNameOfCurrentModule : string;
procedure GxOtaGoToFileLineColumn(const FileName: string; Line: Integer; StartColumn: Integer = 0; StopColumn: Integer = 0; ShowInMiddle: Boolean = True);

resourcestring
  SAllAlphaNumericChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890';
  
implementation

function IsCharIdentifier(aCh : Char) : boolean;
const
  Alpha = ['A'..'Z', 'a'..'z', '_'];
  AlphaNumeric = Alpha + ['0'..'9'];
begin
  Result := aCh in AlphaNumeric;
end;

function IsEmpty(const Str: string): Boolean;
begin
  Result := Trim(Str) = '';
end;

function PosFrom(const Pat, Text: string; StartIndex: Integer): Integer;
var
  S: string;
begin
  if StartIndex > 1 then
  begin
    S := Copy(Text, StartIndex, MaxInt);
    Result := Pos(Pat, S);
  end else
    Result := Pos(Pat, Text);
  if Result > 0 then
     Inc(Result, Pred(StartIndex));
end;

function CaseInsensitivePos(const Pat, Text: string): Integer;
begin
  Result := Pos(AnsiUpperCase(Pat), AnsiUpperCase(Text));
end;

function CaseInsensitivePosFrom(const Pat, Text: string; StartIndex: Integer): Integer;
var
  S: string;
begin
  if StartIndex > 1 then
  begin
    S := Copy(Text, StartIndex, MaxInt);
    Result := CaseInsensitivePos(Pat, S);
  end else
    Result := CaseInsensitivePos(Pat, Text);
  if Result > 0 then
     Inc(Result, Pred(StartIndex));
end;

function AnsiCaseInsensitivePos(const SubString, S: string): Integer;
begin
  Result := AnsiPos(AnsiUpperCase(SubString), AnsiUpperCase(S));
end;

function StringInArray(const S: string; const SArray: array of string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Length(SArray) - 1 do
    if SameText(S, SArray[i]) then begin
      Result := True;
      Break;
    end;
end;

function FileMatchesExtensions(const FileName, FileExtensions: string): Boolean; overload;
begin
  Result := (AnsiCaseInsensitivePos(ExtractFileExt(FileName), FileExtensions) <> 0);
end;

function FileMatchesExtensions(const FileName: string; FileExtensions: array of string): Boolean; overload;
begin
  Result := StringInArray(ExtractFileExt(FileName), FileExtensions);
end;

function FileMatchesExtension(const FileName, FileExtension: string): Boolean;
begin
  Result := FileMatchesExtensions(FileName, [FileExtension]);
end;

procedure LoadDiskFileToStrings(const FileName: string; Data: TStringList);
begin
  if not FileExists(FileName) then
    raise Exception.CreateFmt('The file %s does not exist.', [FileName]);
  Data.LoadFromFile(FileName);
end;

function GetOpenSaveDialogExecute(Dialog: TOpenDialog): Boolean;
begin
  Result := Dialog.Execute;
end;

function LeftTrimChars(var Value: string; const TrimChars: TSysCharSet = [#9, #32]): Integer;
begin
  Result := 0;
  while (Length(Value) > Result) and (Value[Result+1] in TrimChars) do
    Inc(Result);

  Delete(Value, 1, Result);
end;

function ShowError(const Error: string): Boolean;
begin
  Result := Trim(Error) <> '';
  if Result then
    MessageDlg(Error, mtError, [mbOK], 0);
end;

function GetDirectory(var aDir : string) : boolean;
begin
  aDir := '';
  Result := False;
end;

function GetScrollbarWidth : integer;
begin
  Result := 24;
end;

procedure AnsiStrTok(const Source, Delimiter: string; Dest: TStrings);
var
  i: Integer;
  SubString: string;
  Temp: string;
begin
  if (Source = '') or (Delimiter = '') or (Dest = nil) then
    Exit;

  Dest.Clear;
  SubString := Source;
  repeat
    i := AnsiPos(Delimiter, SubString);

    if i = 0 then
      Temp := SubString
    else
      Temp := Copy(SubString, 1, i - 1);

    if Temp <> '' then
      Dest.Add(Temp);

    SubString := Copy(SubString, i + Length(Delimiter), Length(SubString) - i);
  until i = 0;
end;

function TryFocusControl(Control: TWinControl): Boolean;
begin
  Result := False;
  if Assigned(Control) then begin
    if Control.CanFocus and Control.Visible then begin
      try
        Control.SetFocus;
        Result := True;
      except
        // Ignore focus errors
      end;
    end;
  end;
end;

procedure AddMRUString(Text: string; List: TStrings; DeleteTrailingDelimiter: Boolean);
begin
  if Trim(Text) = '' then Exit;
  if Length(Text) > 300 then Exit;

  if DeleteTrailingDelimiter then
    Text := ExcludeTrailingPathDelimiter(Text);

  DeleteStringFromList(List, Text);

  if List.Count = 0 then
    List.Add(Text)
  else
    List.Insert(0, Text);

  if List.Count > 20 then
    List.Delete(List.Count - 1);
end;

procedure DeleteStringFromList(List: TStrings; const Item: string);
var
  Index: Integer;
begin
  Assert(Assigned(List));
  Index := List.IndexOf(Item);
  if Index >= 0 then
    List.Delete(Index);
end;

procedure EnsureFormVisible(const Form: TCustomForm);
var
  Rect: TRect;
begin
  Assert(Assigned(Form));
  if not Form.Floating then
    Exit;
  Rect := GetScreenWorkArea(Form);
  if (Form.Left + Form.Width > Rect.Right) then
    Form.Left := Form.Left - ((Form.Left + Form.Width) - Rect.Right);
  if (Form.Top + Form.Height > Rect.Bottom) then
    Form.Top := Form.Top - ((Form.Top + Form.Height) - Rect.Bottom);
  if Form.Left < Rect.Left then
    Form.Left := Rect.Left;
  if Form.Top < Rect.Top then
    Form.Top := Rect.Top;
end;

function GetScreenWorkArea(const Form: TCustomForm = nil): TRect;
var
  Monitor: TMonitor;
begin
   Result.Top := Screen.DesktopTop;
   Result.Left := Screen.DesktopLeft;
   Result.Right := Screen.DesktopWidth;
   Result.Bottom := Screen.DesktopHeight;

   if Assigned(Form) then
   begin
     Monitor := Screen.MonitorFromWindow(Form.Handle, mdNearest);
     if Assigned(Monitor) then
       Result := Monitor.WorkareaRect;
   end
   else
     SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0);
end;

procedure CenterForm(const Form: TCustomForm);
var
  Rect: TRect;
begin
  if Form = nil then
    Exit;

  if not Form.Floating then
    Exit;
  Rect := GetScreenWorkArea;
  with Form do
  begin
    SetBounds((Rect.Right - Rect.Left - Width) div 2,
      (Rect.Bottom - Rect.Top - Height) div 2, Width, Height);
  end;
end;

function GxOtaGetCurrentSelection : string;
begin
end;

function GxOtaGetCurrentIdent : string;
begin
end;

function GxOtaGetFileNameOfCurrentModule : string;
begin
end;

procedure GxOtaGoToFileLineColumn(const FileName: string; Line: Integer; StartColumn: Integer = 0; StopColumn: Integer = 0; ShowInMiddle: Boolean = True);
begin
end;

end.
