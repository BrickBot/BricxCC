unit brick_common;

interface

uses
  uSpirit;

var
  LocalBrickType : integer;      // Brick type to use for this instance

function BrickComm : TBrickComm;
procedure ReleaseBrickComm;
procedure CreateInitFile;

implementation

uses
  SysUtils, FakeSpirit, FantomSpirit, FANTOM;

var
  BC : TBrickComm;

function BrickComm : TBrickComm;
begin
  if not Assigned(BC) then
  begin
    if LocalBrickType = SU_NXT then
      BC := TFantomSpirit.Create()
    else
      BC := TFakeSpirit.Create();
  end;
  Result := BC;
end;

procedure ReleaseBrickComm;
begin
  if Assigned(BC) then
    FreeAndNil(BC);
end;

procedure CreateInitFile;
var
  oldbt : integer;
begin
  if FantomAPIAvailable then
  begin
    oldbt := LocalBrickType;
    try
      LocalBrickType := rtNXT;
      BrickComm.NXTInitializeResourceNames;
    finally
      ReleaseBrickComm;
      LocalBrickType := oldbt;
    end;
  end;
end;

initialization
  LocalBrickType := SU_RCX;
  BC := nil;

finalization
  BC.Free;

end.
