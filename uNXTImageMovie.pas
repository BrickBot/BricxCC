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
unit uNXTImageMovie;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  AviWriter,
{$ENDIF}
  Classes, Graphics;

type
  TNXTImageMovie = class(TComponent)
  private
    fMaxFrames : integer;
    fFilename : string;
    fBaseFilename : string;
    fExt : string;
    fIndex : integer;
    function GetFileName: string;
    function GetFrameTime: Cardinal;
    function GetHeight: Integer;
    function GetStretch: boolean;
    function GetWidth: Integer;
    procedure SetFileName(const aValue: string);
    procedure SetFrameTime(const aValue: Cardinal);
    procedure SetHeight(const aValue: Integer);
    procedure SetStretch(const aValue: boolean);
    procedure SetWidth(const aValue: Integer);
    function GetMax: integer;
    procedure SetMax(const Value: integer);
    procedure SetAVIWriterName;
    procedure CheckFrameCount;
  protected
{$IFNDEF FPC}
    fAVIWriter : TAviWriter;
{$ENDIF}
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
    procedure AddPicture(aPic : TPicture);
    procedure Clear;
    procedure Write;
    function FrameCount : integer;
    property FileName : string read GetFileName write SetFileName;
    property FrameTime : Cardinal read GetFrameTime write SetFrameTime;
    property Height : Integer read GetHeight write SetHeight;
    property Width : Integer read GetWidth write SetWidth;
    property Stretch : boolean read GetStretch write SetStretch;
    property MaxFramesPerMovie : integer read GetMax write SetMax;
  end;

implementation

uses
  SysUtils;

{ TNXTImageMovie }

procedure TNXTImageMovie.AddPicture(aPic: TPicture);
var
  aviBmp : TBitmap;
begin
{$IFNDEF FPC}
  aviBmp := TBitmap.Create;
  aviBmp.Assign(aPic.Bitmap);
  fAviWriter.Bitmaps.Add(aviBmp);
{$ENDIF}
  CheckFrameCount;
end;

procedure TNXTImageMovie.CheckFrameCount;
begin
  if FrameCount >= fMaxFrames then
  begin
    Write;
    Clear;
    inc(fIndex);
    SetAVIWriterName;
  end;
end;

procedure TNXTImageMovie.Clear;
begin
{$IFNDEF FPC}
  fAviWriter.Bitmaps.Clear;
{$ENDIF}
end;

constructor TNXTImageMovie.Create(aOwner: TComponent);
begin
  inherited;
  fBaseFilename := 'nxtimage';
  fExt          := '.avi';
  fIndex        := 0;
  fMaxFrames    := MaxInt;
{$IFNDEF FPC}
  fAVIWriter := TAVIWriter.Create(Self);
{$ENDIF}
end;

destructor TNXTImageMovie.Destroy;
begin
{$IFNDEF FPC}
  FreeAndNil(fAVIWriter);
{$ENDIF}
  inherited;
end;

function TNXTImageMovie.FrameCount: integer;
begin
{$IFNDEF FPC}
  Result := fAVIWriter.Bitmaps.Count;
{$ELSE}
  Result := 0;
{$ENDIF}
end;

function TNXTImageMovie.GetFileName: string;
begin
  Result := fFilename;
end;

function TNXTImageMovie.GetFrameTime: Cardinal;
begin
{$IFNDEF FPC}
  Result := fAVIWriter.FrameTime;
{$ELSE}
  Result := 0;
{$ENDIF}
end;

function TNXTImageMovie.GetHeight: Integer;
begin
{$IFNDEF FPC}
  Result := fAVIWriter.Height;
{$ELSE}
  Result := 0;
{$ENDIF}
end;

function TNXTImageMovie.GetMax: integer;
begin
  result := fMaxFrames;
end;

function TNXTImageMovie.GetStretch: boolean;
begin
{$IFNDEF FPC}
  Result := fAVIWriter.Stretch;
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TNXTImageMovie.GetWidth: Integer;
begin
{$IFNDEF FPC}
  Result := fAVIWriter.Width;
{$ELSE}
  Result := 0;
{$ENDIF}
end;

procedure TNXTImageMovie.SetAVIWriterName;
begin
{$IFNDEF FPC}
  fAVIWriter.FileName := Format('%s_%3.3d%s', [fBaseFilename, fIndex, fExt]);
{$ENDIF}
end;

procedure TNXTImageMovie.SetFileName(const aValue: string);
begin
  fFilename := aValue;
  fBaseFilename := ChangeFileExt(aValue, '');
  fExt := ExtractFileExt(aValue);
  SetAVIWriterName;
end;

procedure TNXTImageMovie.SetFrameTime(const aValue: Cardinal);
begin
{$IFNDEF FPC}
  fAVIWriter.FrameTime := aValue;
{$ENDIF}
end;

procedure TNXTImageMovie.SetHeight(const aValue: Integer);
begin
{$IFNDEF FPC}
  fAVIWriter.Height := aValue;
{$ENDIF}
end;

procedure TNXTImageMovie.SetMax(const Value: integer);
begin
  fMaxFrames := Value;
  CheckFrameCount;
end;

procedure TNXTImageMovie.SetStretch(const aValue: boolean);
begin
{$IFNDEF FPC}
  fAVIWriter.Stretch := aValue;
{$ENDIF}
end;

procedure TNXTImageMovie.SetWidth(const aValue: Integer);
begin
{$IFNDEF FPC}
  fAVIWriter.Width := aValue;
{$ENDIF}
end;

procedure TNXTImageMovie.Write;
begin
{$IFNDEF FPC}
  try
    fAVIWriter.Write;
  except
    // eat any exceptions
  end;
{$ENDIF}
end;

end.
