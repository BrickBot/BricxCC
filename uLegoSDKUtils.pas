unit uLegoSDKUtils;

interface

function GetSDKRootPath : string;

implementation

uses
  SysUtils, Registry, uCommonUtils;

function GetSDKRootPath : string;
const
  K_VPBCOM = 'Vpbcom.VPBrick\CLSID';
var
  R : TRegistry;
  g, p : string;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CLASSES_ROOT;
    if R.OpenKeyReadOnly(K_VPBCOM) then
    begin
      g := R.ReadString(''); // read default value
      R.CloseKey;
      if (g <> '') and R.OpenKeyReadOnly('CLSID\' + g + '\InprocServer32') then
      begin
        p := R.ReadString(''); // read default value
        R.CloseKey;
        if p <> '' then
          Result := ExtractFilePath(p);
      end;
    end;
  finally
    R.Free;
  end;
end;


end.