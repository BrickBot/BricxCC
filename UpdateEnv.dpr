program UpdateEnv;

uses
  SysUtils, Windows, Messages, Registry, Classes;

{.$R *.res}

const
  K_ENVIRONMENT_KEY = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';

procedure AddParamsToEnvironment;
var
  R : TRegistry;
  PL, SL : TStringList;
  p, name, value : string;
  i : integer;
begin
  PL := TStringList.Create;
  try
    for i := 1 to ParamCount do
      PL.Add(ParamStr(i));
    if PL.Count = 0 then Exit;
    // if param(1) exists then add it to the head of the PATH
    // if it isn't already listed in the PATH
    R := TRegistry.Create;
    try
      R.RootKey := HKEY_LOCAL_MACHINE;
      if R.KeyExists(K_ENVIRONMENT_KEY) then
      begin
        if R.OpenKey(K_ENVIRONMENT_KEY, False) then
        begin
          for i := 0 to PL.Count - 1 do
          begin
            name := PL.Names[i];
            value := PL.Values[name];
            // each param is Name=Value
            if name = 'Path' then
            begin
              p := R.ReadString(name);
              SL := TStringList.Create;
              try
                SL.QuoteChar := #0;
                SL.Delimiter := ';';
                SL.DelimitedText := p;
                if SL.IndexOf(value) = -1 then
                begin
                  // add to head of path
                  p := value + ';' + p;
                  R.WriteExpandString(name, p);
                end;
              finally
                SL.Free;
              end;
            end
            else
              if Pos('%', value) > 0 then
                R.WriteExpandString(name, value)
              else
                R.WriteString(name, value);
          end;
          R.CloseKey;
        end;
      end;
    finally
      R.Free;
    end;
  finally
    PL.Free;
  end;
end;

procedure BroadcastChange;
var
  lParam, wParam : Integer;   {Integers that indicate pointers to parameters}
  Buf     : Array[0..10] of Char; {Buffer used to indicate what setting we have changed.}
  aResult : Cardinal;         {Error Number returned from API Call}
  X : PDWORD;
  Y : DWORD;
begin
   Buf := 'Environment';
   wParam := 0;
   lParam := Integer(@Buf[0]);

   Y := BSM_APPLICATIONS or BSM_ALLCOMPONENTS;
   X := @Y;
   BroadcastSystemMessage(BSF_FLUSHDISK or BSF_IGNORECURRENTTASK, X,
     WM_SETTINGCHANGE, wParam, lParam);
   SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, wParam, lParam,
     SMTO_NORMAL, 4000, aResult);
end;

begin
  AddParamsToEnvironment;
  BroadcastChange;
end.
