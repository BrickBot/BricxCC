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
 * The Initial Developer of this code is Mark Overmars.
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit PuzzleUnit;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Graphics, Controls, Forms, ExtCtrls, StdCtrls;

type
  TPuzzleForm = class(TForm)
    SchuifImg: TImage;
    TheImage: TImage;
    ShuffleBtn: TButton;
    procedure SchuifImgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure ShuffleBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure Toonveld;
    procedure ShowPuzzle;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

var bezig : boolean;            { Busy playing }

var veld: array[1..4,1..4] of integer;
    xempty,yempty:integer;

procedure TPuzzleForm.Toonveld;
{Laat het veld zien}
var i,j,x,y:integer;
begin
  with SchuifImg do
  begin
    {Zet de plaatjes}
    if bezig then
    begin
      for i:=1 to 4 do
        for j:=1 to 4 do
          if veld[i,j] <>15 then
            begin
              x := 32*(veld[i,j] mod 4);
              y := 32*(veld[i,j] div 4);
              Canvas.CopyRect(Rect(32*(i-1),32*(j-1),32*i,32*j),
                          TheImage.Canvas,
                          Rect(x,y,x+32,y+32));
            end else begin
              Canvas.Brush.Color:=clWhite;
              Canvas.Rectangle(32*(i-1),32*(j-1),32*i,32*j);
            end;
      {Trek de lijnen}
      for i:=0 to 4 do Canvas.Rectangle(0,32*i-1,128,32*i+1);
      for i:=0 to 4 do Canvas.Rectangle(32*i-1,0,32*i+1,128);
    end else begin
      Canvas.CopyRect(Rect(0,0,128,128),
                      TheImage.Canvas,
                      Rect(0,0,128,128));
    end;
    Update;
  end;
end;

function DoeZet(x,y:integer):boolean;
{Doet een zet op vakje (x,y). Geeft terug of dat lukte.}
var i:integer;
begin
  if ((x = xempty) and (y = yempty)) or
         ((x <> xempty) and (y <> yempty)) then
  begin
    DoeZet:=false;
    Exit;
  end else begin
    if x = xempty then
    begin
      if y<yempty then
        for i:=yempty downto y+1 do veld[x,i] := veld[x,i-1]
      else
        for i:=yempty to y-1 do veld[x,i] := veld[x,i+1];
    end else begin
      if x<xempty then
        for i:=xempty downto x+1 do veld[i,y] := veld[i-1,y]
      else
        for i:=xempty to x-1 do veld[i,y] := veld[i+1,y];
    end;
    veld[x,y]:=15;
    xempty:=x; yempty:=y;
    DoeZet:=true;
  end;
end;

function IsKlaar:boolean;
{Check of het klaar is}
var i,j:integer;
begin
  IsKlaar := true;
  for i:=1 to 4 do
    for j:=1 to 4 do
      if veld[i,j] <> 4*(j-1)+(i-1) then IsKlaar:=false;
end;

procedure TPuzzleForm.ShowPuzzle;
{Shows the puzzle}
var i,j:integer;
begin
  // Shuffle the image
  SchuifImg.Visible:=false;
  for i:=1 to 4 do
    for j:=1 to 4 do
      veld[i,j] := 4*(j-1)+(i-1);
  xempty:=4; yempty:=4;
  for i:=1 to 1000 do DoeZet(1+Random(4),1+Random(4));
  // Show it and get going
  bezig := true;
  ToonVeld;
  SchuifImg.Visible:=true;
end;

{==========================================
 = De handle routines                     =
 ==========================================}

procedure TPuzzleForm.SchuifImgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not bezig then Exit;
  if DoeZet(x div 32 +1, y div 32 +1) then
  begin
    ToonVeld;
    SchuifImg.Update;
    if IsKlaar() then
      begin bezig:=false; ToonVeld; end;
  end
end;

procedure TPuzzleForm.FormShow(Sender: TObject);
begin
  ShowPuzzle;
end;

procedure TPuzzleForm.ShuffleBtnClick(Sender: TObject);
begin
  ShowPuzzle;
end;

{$IFDEF FPC}
initialization
  {$i PuzzleUnit.lrs}
{$ENDIF}

end.