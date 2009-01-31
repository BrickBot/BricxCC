unit uCmdLineUtils;

interface

uses
  Classes;

function progName : string;
procedure PrintVersion(const ts : string = '');
procedure PrintUsageError(const ts : string = '');
function redirectErrorsToFile : boolean;
procedure setErrorOutputFile(var F : TextFile);
function getIncludePath : string;

implementation

uses
  SysUtils, ParamUtils, uVersionInfo, uLocalizedStrings;

function progName : string;
begin
  Result := ExtractFileName(ParamStr(0));
  Result := ChangeFileExt(Result, '');
end;

procedure PrintVersion(const ts : string);
var
  V : TVersionInfo;
  app, tmp : string;
begin
  app := ParamStr(0);
  V := GetVersionInfo(app);
  tmp := V.ProductName + VersionString + V.ProductVersion + ' (' +  V.FileVersion;
  if ts <> '' then
    tmp := tmp + ',' + BuiltString + ts;
  tmp := tmp + ')';
  Writeln(tmp);
  Writeln('     ' + V.LegalCopyright);
end;

procedure PrintUsageError(const ts : string);
begin
  PrintVersion(ts);
  Writeln(Format(UsageErrorMessage, [progName]));
end;

function redirectErrorsToFile : boolean;
begin
  Result := ParamSwitch('-E', false);
end;

procedure setErrorOutputFile(var F : TextFile);
var
  val, dir : string;
begin
  val := '';
  if ParamSwitch('-E', false) then
  begin
    val := ParamValue('-E', false);
    dir := ExtractFilePath(val);
    if dir <> '' then
      ForceDirectories(dir);
  end;
  AssignFile(F, val);
  Rewrite(F);
end;

function getIncludePath : string;
begin
  Result := ExtractFilePath(ParamStr(0));
  if ParamSwitch('-I', false) then
  begin
    Result := ParamValue('-I', false);
  end;
end;

end.
