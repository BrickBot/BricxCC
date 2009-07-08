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
unit uRICImage;

interface

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  Classes, Graphics, uRICComp;

type
  TRICObject = class(TGraphic)
  private
    fRICComp : TRICComp;
    fCanvas: TCanvas;
    fImportThreshold: byte;
    fImportMinWidth: Word;
    fImportMaxWidth: Word;
  protected
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
    function GetEmpty: Boolean; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    procedure SetHeight(Value: Integer); override;
    procedure SetWidth(Value: Integer); override;
  protected
    procedure AssignRIC(Source: TRICObject);
    procedure ClearRIC;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
{$IFNDEF FPC}
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle;
      APalette: HPalette); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
      var APalette: HPalette); override;
{$ENDIF}
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure LoadFromResourceName(Instance: THandle; const ResName: String);
    // properties
    property Canvas: TCanvas read fCanvas;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property Empty: Boolean read GetEmpty;
    property ImportThreshold : byte read fImportThreshold write fImportThreshold;
    property ImportMaxWidth : Word read fImportMaxWidth write fImportMaxWidth;
    property ImportMinWidth : Word read fImportMinWidth write fImportMinWidth;
  end;

resourcestring
  sNXTIconFile = 'NXT Icon File';
  sFailedRICPaste	= 'Failed to store RIC on clipboard';

var
  CF_RIC : WORD;

implementation

uses
  SysUtils, uRIC, Consts;

{ TRICObject }

procedure TRICObject.Assign(Source: TPersistent);
begin
  if Source = nil then
    ClearRIC
  else if Source is TRICObject then
    AssignRIC(Source as TRICObject)
  else if Source is TBitmap then
  begin
    // assign from a TBitmap
  end
  else
    inherited;
end;

procedure TRICObject.AssignRIC(Source: TRICObject);
begin

end;

procedure TRICObject.AssignTo(Dest: TPersistent);
begin
  if Dest is TRICObject then
    TRICObject(Dest).AssignRIC(Self)
  else if Dest is TBitmap then
  begin
    {Copies the handle using CopyImage API}
    TBitmap(Dest).PixelFormat := pf1bit;
    TBitmap(Dest).Width := Width;
    TBitmap(Dest).Height := Height;
    TBitmap(Dest).Canvas.Draw(0, 0, Self);
  end
  else
    inherited AssignTo(Dest);
end;

procedure TRICObject.ClearRIC;
begin

end;

constructor TRICObject.Create;
begin
  inherited;
  fCanvas := TCanvas.Create;
  fImportThreshold := 50;
  fImportMaxWidth  := 0;
  fImportMinWidth  := 0;
end;

destructor TRICObject.Destroy;
begin
  FreeAndNil(fCanvas);
  inherited;
end;

procedure TRICObject.Draw(ACanvas: TCanvas; const Rect: TRect);
begin
  inherited;

end;

function TRICObject.GetEmpty: Boolean;
begin
  Result := True;
end;

function TRICObject.GetHeight: Integer;
begin
  Result := 0;
end;

function TRICObject.GetWidth: Integer;
begin
  Result := 0;
end;

{$IFNDEF FPC}
procedure TRICObject.LoadFromClipboardFormat(AFormat: Word; AData: THandle;
  APalette: HPalette);
var
  Size	 : Longint;
  Buffer : Pointer;
  Stream : TMemoryStream;
  Bmp		 : TBitmap;
begin
  if (AData = 0) then
    AData := GetClipboardData(AFormat);
  if (AData <> 0) and (AFormat = CF_RIC) then
  begin
    // Get size and pointer to data
    Size := GlobalSize(AData);
    Buffer := GlobalLock(AData);
    try
      Stream := TMemoryStream.Create;
      try
        // Copy data to a stream
        Stream.SetSize(Size);
        Move(Buffer^, Stream.Memory^, Size);
        // Load RIC from stream
        LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    finally
      GlobalUnlock(AData);
    end;
  end
  else if (AData <> 0) and (AFormat = CF_BITMAP) then
  begin
    // No RIC on clipboard - try loading a bitmap instead
    Bmp := TBitmap.Create;
    try
      Bmp.LoadFromClipboardFormat(AFormat, AData, APalette);
      Assign(Bmp);
    finally
      Bmp.Free;
    end;
  end else
   raise Exception.Create(SUnknownClipboardFormat);
end;
{$ENDIF}


procedure TRICObject.LoadFromResourceName(Instance: THandle; const ResName: String);
var
  Stream: TCustomMemoryStream;
begin
  Stream := TResourceStream.Create(Instance, ResName, RT_RCDATA);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TRICObject.LoadFromStream(Stream: TStream);
begin
  inherited;

end;

{$IFNDEF FPC}
procedure TRICObject.SaveToClipboardFormat(var AFormat: Word;
  var AData: THandle; var APalette: HPalette);
var
  Stream		: TMemoryStream;
  Data			: THandle;
  Buffer		: Pointer;
begin
  if (Empty) then
    Exit;
//  // First store a bitmap version on the clipboard...
//  Bitmap.SaveToClipboardFormat(AFormat, AData, APalette);
  // ...then store a RIC
  Stream := TMemoryStream.Create;
  try
    // Save the RIC to a memory stream
    SaveToStream(Stream);
    Stream.Position := 0;
    // Allocate some memory for the RIC data
    Data := GlobalAlloc(HeapAllocFlags, Stream.Size);
    try
      if (Data <> 0) then
      begin
        Buffer := GlobalLock(Data);
        try
          // Copy RIC data from stream memory to clipboard memory
          Move(Stream.Memory^, Buffer^, Stream.Size);
        finally
          GlobalUnlock(Data);
        end;
        // Transfer data to clipboard
        if (SetClipboardData(CF_RIC, Data) = 0) then
          raise Exception.Create(sFailedRICPaste);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    Stream.Free;
  end;
end;
{$ENDIF}

procedure TRICObject.SaveToStream(Stream: TStream);
begin
  inherited;

end;

procedure TRICObject.SetHeight(Value: Integer);
begin
  // do nothing
end;

procedure TRICObject.SetWidth(Value: Integer);
begin
  // do nothing
end;

initialization
  TPicture.RegisterFileFormat('RIC', sNXTIconFile, TRICObject);
  CF_RIC := RegisterClipboardFormat(PChar(sNXTIconFile));
  TPicture.RegisterClipboardFormat(CF_RIC, TRICObject);

finalization
  TPicture.UnregisterGraphicClass(TRICObject);

end.
