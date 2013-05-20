program FantomTest2;

uses
  uGlobals,
  rcx_constants,
  rcx_cmd,
  FantomDefs,
  uSpirit,
  FantomSpirit,
  brick_common;

{$R *.res}

var
  bc : TBrickComm;
  status : integer;

type
  TBrickCommCracker = class(TFantomSpirit);  

procedure iNXT_Test(nxtHandle : FantomHandle; var status : integer);
var
  cmd : TNINxtCmd;
  scBuffer : PByte;
  b1, b2, b3, b4 : Byte;
begin
  cmd := TNINxtCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmd, kNXT_SCGetDeviceInfo);
    iNXT_sendSystemCommand(nxtHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
  finally
    cmd.Free;
  end;
end;

begin
  LocalBrickType := SU_NXT;
  bc := BrickComm;
  try
    bc.Port := 'alias0';
    if bc.Open then
    begin
      iNXT_Test(TBrickCommCracker(bc).fNXTHandle, status);
      bc.Close;
    end;
  finally
    bc.Free;
  end;
end.
