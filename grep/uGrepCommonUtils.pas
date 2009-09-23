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
  Classes, Controls, Dialogs, SysUtils, Windows, Registry, Graphics;

type
  TGXFontFlag = (ffColor);
  TGXFontFlags = set of TGXFontFlag;

  TGExpertsBaseSettings = class(TRegistryIniFile);

  TGExpertsSettings = class(TGExpertsBaseSettings)
  public
    // Save settings of Font to the registry under Section.
    procedure SaveFont(const Section: string; const Font: TFont; Flags: TGXFontFlags = []);
    // From Section, load settings into Font from the registry.
    procedure LoadFont(const Section: string; const Font: TFont; Flags: TGXFontFlags = []);
    // Write List to registry at Section, using Ident as the prefix for the string values
    procedure ReadStrings(const List: TStrings; const Section, Ident: string);
    // Read from registry at Section strings into List, using Ident as the prefix for the string values.
    procedure WriteStrings(const List: TStrings; const Section, Ident: string);
    constructor Create(const FileName: string = '');
  end;

const
  AllFilesWildCard = '*.*';

function IsCharIdentifier(aCh : Char) : boolean;
function NotEmpty(const Str: string): Boolean;
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
function GxOtaGetCurrentSelection : string;
function GxOtaGetCurrentIdent : string;
function GxOtaGetFileNameOfCurrentModule : string;
function GxOtaGetOpenFilenames : string;
procedure GxOtaGoToFileLineColumn(const FileName: string; Line: Integer; StartColumn: Integer = 0; StopColumn: Integer = 0; ShowInMiddle: Boolean = True);

// Save settings of Font to the registry under Key.
procedure RegSaveFont(const Settings: TGExpertsSettings; const Key: string; const Font: TFont);
// From Key, load settings into Font from the registry.
procedure RegLoadFont(const Settings: TGExpertsSettings; const Key: string; const Font: TFont);
// Write List to registry at Key, using SubKey as the prefix for the string values
procedure RegReadStrings(const Settings: TGExpertsSettings; const List: TStrings; const Key, SubKey: string);
// Read from registry at Key strings into List, using SubKey as the prefix for the string values.
procedure RegWriteStrings(const Settings: TGExpertsSettings; const List: TStrings; const Key, SubKey: string);

resourcestring
  SAllAlphaNumericChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890';
  
implementation

uses
  FileCtrl, uMiscDefines, BricxCCSynEdit, MainUnit, Math;

function IsCharIdentifier(aCh : Char) : boolean;
const
  Alpha = ['A'..'Z', 'a'..'z', '_'];
  AlphaNumeric = Alpha + ['0'..'9'];
begin
  Result := aCh in AlphaNumeric;
end;

function NotEmpty(const Str: string): Boolean;
begin
  Result := Trim(Str) <> '';
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
  Result := SelectDirectory('Select a directory', '', aDir);
end;

function GetScrollbarWidth : integer;
begin
{$IFDEF FPC}
  Result := 16;
{$ELSE}
  Result := GetSystemMetrics(SM_CXVSCROLL);
{$ENDIF}
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

function GxOtaGetCurrentSelection : string;
var
  E : TBricxCCSynEdit;
begin
  Result := '';
  E := GetActiveEditor;
  if Assigned(E) then
    Result := E.SelText;
end;

function GxOtaGetCurrentIdent : string;
var
  E : TBricxCCSynEdit;
begin
  Result := '';
  E := GetActiveEditor;
  if Assigned(E) then
    Result := E.TextAtCursor;
end;

function GxOtaGetFileNameOfCurrentModule : string;
begin
  Result := GetActiveEditorFilename;
end;

function GxOtaGetOpenFilenames : string;
var
  i, count : integer;
  SL : TStringList;
begin
  Result := '';
  if Assigned(MainForm) then
  begin
    SL := TStringList.Create;
    try
      count := MainForm.EditorFormCount;
      for i := 0 to count - 1 do
        SL.Add(MainForm.EditorForms[i].Filename);
      Result := SL.CommaText;
    finally
      FreeAndNil(SL);
    end;
  end;
end;

procedure GxOtaGoToFileLineColumn(const FileName: string; Line: Integer; StartColumn: Integer = 0; StopColumn: Integer = 0; ShowInMiddle: Boolean = True);
var
  E : TBricxCCSynEdit;
  pC, pB, pA : TPoint;
begin
  if GxOtaGetFileNameOfCurrentModule = FileName then
  begin
    E := GetActiveEditor;
    if Assigned(E) then
    begin
      if ShowInMiddle then
        E.GotoLineAndCenter(Line)
      else
        E.GotoLineNumber(Line);
    end;
  end
  else
  begin
    if Assigned(MainForm) then
    begin
      MainForm.OpenFile(Filename, Line);
    end;
  end;
  E := GetActiveEditor;
  if Assigned(E) then
  begin
    pC := Point(StartColumn, Line);
    pB := Point(StartColumn, Line);
    pA := Point(StopColumn+1, Line);
    E.SetCaretAndSel(pC, pB, pA);
    E.Refresh;
  end;
end;

procedure RegSaveFont(const Settings: TGExpertsSettings; const Key: string; const Font: TFont);
begin
  Settings.SaveFont(Key, Font);
end;

procedure RegLoadFont(const Settings: TGExpertsSettings; const Key: string; const Font: TFont);
begin
  Settings.LoadFont(Key, Font);
end;

procedure RegReadStrings(const Settings: TGExpertsSettings; const List: TStrings; const Key, SubKey: string);
begin
  Settings.ReadStrings(List, Key, SubKey);
end;

procedure RegWriteStrings(const Settings: TGExpertsSettings; const List: TStrings; const Key, SubKey: string);
begin
  Settings.WriteStrings(List, Key, SubKey);
end;

const
  FontNameIdent = 'Name'; // Do not localize.
  FontSizeIdent = 'Size'; // Do not localize.
  FontColorIdent = 'Color'; // Do not localize.
  FontStyleBoldIdent = 'Bold'; // Do not localize.
  FontStyleItalicIdent = 'Italic'; // Do not localize.
  FontStyleUnderlineIdent = 'Underline'; // Do not localize.
  CountIdent = 'Count'; // Do not localize.

{ TGExpertsSettings }

constructor TGExpertsSettings.Create(const FileName: string);
begin
  if FileName = '' then
    inherited Create('Software\BricxCC\3.3')
  else
    inherited Create(FileName);
end;

procedure TGExpertsSettings.SaveFont(const Section: string; const Font: TFont; Flags: TGXFontFlags);
begin
  Assert(Assigned(Font), 'nil font in TGExpertsSettings.SaveFont');
  WriteString(Section, FontNameIdent, Font.Name);
  WriteInteger(Section, FontSizeIdent, Font.Size);
  WriteBool(Section, FontStyleBoldIdent, (fsBold in Font.Style));
  WriteBool(Section, FontStyleItalicIdent, (fsItalic in Font.Style));
  WriteBool(Section, FontStyleUnderlineIdent, (fsUnderline in Font.Style));
  if ffColor in Flags then
    WriteInteger(Section, FontColorIdent, Font.Color);
end;

procedure TGExpertsSettings.LoadFont(const Section: string; const Font: TFont; Flags: TGXFontFlags);
begin
  Assert(Assigned(Font),  'nil font in TGExpertsSettings.LoadFont');
  Font.Name := ReadString(Section, FontNameIdent, Font.Name);
  Font.Size := ReadInteger(Section, FontSizeIdent, Font.Size);
  if ReadBool(Section, FontStyleBoldIdent, (fsBold in Font.Style)) then
    Font.Style := Font.Style + [fsBold];
  if ReadBool(Section, FontStyleItalicIdent, (fsItalic in Font.Style)) then
    Font.Style := Font.Style + [fsItalic];
  if ReadBool(Section, FontStyleUnderlineIdent, (fsUnderline in Font.Style)) then
    Font.Style := Font.Style + [fsUnderline];
  if ffColor in Flags then
    Font.Color := ReadInteger(Section, FontColorIdent, Font.Color);
end;

procedure TGExpertsSettings.ReadStrings(const List: TStrings; const Section, Ident: string);
var
  i: Integer;
  RegistryValueCount: Integer;
  ListString: string;
  Identifier: string;
begin
  Assert(Assigned(List));
  RegistryValueCount := Max(0, ReadInteger(Section, CountIdent, 0));
  for i := 0 to RegistryValueCount - 1 do
  begin
    Identifier := Ident + IntToStr(i);
    if ValueExists(Section, Identifier) then
    begin
      ListString := ReadString(Section, Identifier, '');
      List.Add(ListString);
    end;
  end;
end;

procedure TGExpertsSettings.WriteStrings(const List: TStrings; const Section, Ident: string);
var
  i: Integer;
begin
  Assert(Assigned(List), 'nil string list in TGExpertsSettings.WriteStrings');
  EraseSection(Section);
  // Assume brutally that a write will fail.
  WriteInteger(Section, CountIdent, 0);
  for i := 0 to List.Count - 1 do
  begin
    // We do never run into a conflict with the "Count" value,
    // as the Ident always gets a number appended.
    WriteString(Section, Format('%s%d', [Ident, i]), List.Strings[i]);
  end;
  // Record the amount of values written.
  WriteInteger(Section, CountIdent, List.Count);
end;

end.
