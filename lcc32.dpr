program lcc32;
{$APPTYPE CONSOLE}
uses
  FastMM4,
  FastMove,
  Classes,
  Forms,
  SysUtils,
  Dialogs,
  ActiveX,
  FileCtrl,
  Windows,
  Registry,
  ParamUtils,
  uLegoSDKUtils,
  uVersionInfo,
  uCommonUtils,
  uCmdLineUtils,
  Variants,
  Math,
  ComObj,
  LEGOVPBrickLib_TLB;

{$R *.RES}

type
  TDownloadHandler = class
  private
    fCanTerminate: Boolean;
  public
    property CanTerminate : Boolean read fCanTerminate write fCanTerminate;
    procedure HandleDownloadProgress(Sender: TObject; nPercent: Integer);
    procedure HandleDownloadDone(Sender: TObject; nErrorCode: Integer);
  end;

var
  vpb : TVPBrick;
  port, code : WideString;
  cType : TOleEnum;
  ErrPos : Integer;
  Filename : string;
  F : TextFile;
  DH : TDownloadHandler;
  status : StatusResult;
  ExecuteCmd : WideString;
  TheErrorCode : Byte;
  retCnt : Integer;

const
  MAX_RETRIES   = 5;
  TRACE_LISTING = 4;

{ TDownloadHandler }

procedure TDownloadHandler.HandleDownloadDone(Sender: TObject;
  nErrorCode: Integer);
begin
  fCanTerminate := True;
end;

procedure TDownloadHandler.HandleDownloadProgress(Sender: TObject;
  nPercent: Integer);
begin
  DH.CanTerminate := False;
  Write('.');
end;

procedure PrintUsage;
begin
  PrintVersion;
  WriteLn('Syntax: ' + progName + ' [options] filename [options]');
  WriteLn('');
  WriteLn('   -T=<target>: target can be RCX, RCX2, Scout, MicroScout, Spy, or Swan');
  WriteLn('   -C=<codetype>: code type can be MindScript or LASM');
  WriteLn('   -TRACE=n: trace level can be 1-15');
  WriteLn('   -S=<portname>: specify port (COMn, usb)');
  Writeln('   -d: download program');
  Writeln('   -q: no sound upon download completion');
  Writeln('   -E=<filename> : write compiler errors to <filename>');
  Writeln('   -I=<path>: search <path> for include files');
  Writeln('   -L=<filename> : generate code listing to <filename>');
end;

function Silent : Boolean;
begin
  Result := ParamSwitch('-q', false);
end;

function getPort : string;
var
  val, tmp : string;
begin
  Result := '\\.\';
  val := 'COM1';
  if ParamSwitch('-S', false) then
  begin
    tmp := ParamValue('-S', false);
    if Pos('USB', UpperCase(tmp)) = 1 then
      val := 'LEGOTOWER1'
    else if Pos('COM', UpperCase(tmp)) = 1 then
      val := tmp;
  end;
  Result := Result + val;
end;

function getBrickType : Smallint;
var
  val : string;
begin
  Result := RCX2;  // 1
  if ParamSwitch('-T', false) then
  begin
    val := ParamValue('-T', false);
    if (UpperCase(val) = 'SCOUT') or (val = '2') then
      Result := Scout
    else if (UpperCase(val) = 'MICROSCOUT') or (val = '3') then
      Result := MicroScout
    else if (UpperCase(val) = 'SPY') or (val = '4') then
      Result := Spybot
    else if (UpperCase(val) = 'SWAN') or (val = '5') then
      Result := RCX2
    else if (UpperCase(val) = 'RCX') or (val = '0') then
      Result := RCX;
  end;
end;

function getSourceCode : String;
var
  Src : TStringList;
  i : Integer;
  tmp : string;
begin
  Src := TStringList.Create;
  try
    for i := 1 to ParamCount do
    begin
      tmp := ParamStr(i);
      if Pos('-', tmp) = 1 then Continue; // a switch
      if FileExists(tmp) then
      begin
        Filename := tmp;
        Src.LoadFromFile(Filename);
        Break;
      end;
    end;
    Result := Src.Text;
  finally
    Src.Free;
  end;
end;

function countCR(const str : string) : Integer;
var
  i : Integer;
begin
  Result := 0;
  for i := 0 to Length(str) - 2 do
  begin
    if (str[i] = #13) and (str[i+1] = #10) then
    begin
      Inc(Result);
    end;
  end;
end;

function calcRow(const code : string; const errPos : Integer) : Integer;
var
  i : Integer;
begin
  Result := -1;
  i := 0;
  while i <= errPos-1 do
  begin
    if (code[i] = #13) and (code[i+1] = #10) then
    begin
      if Result = -1 then Result := 1;
      Inc(i);
      Inc(Result);
    end;
    Inc(i);
  end;
end;

function CountIncludes(code : string; row : integer) : Integer;
var
  SL : TStringList;
  i, p1, p2, p3, p4 : Integer;
  bInComment : Boolean;
begin
  Result := 0;
  SL := TStringList.Create;
  try
    SL.Text := code;
    bInComment := False;
    for i := 0 to Min(row-1, SL.Count - 1) do
    begin
      p1 := Pos('#include', SL[i]);
      p2 := Pos('//', SL[i]);
      p3 := Pos('/*', SL[i]);
      p4 := Pos('*/', SL[i]);
      if not bInComment and ((p3 > 0) and (p3 < p1)) then
        bInComment := True;
      if bInComment and ((p4 > 0) and (p4 > p3) and (p4 < p1)) then
        bInComment := False;
      if not bInComment and
         (p1 > 0) and
         ((p2 = 0) or (p2 > p1)) then
        Inc(Result);
      if not bInComment and (p3 > 0) then
        bInComment := True;
      if bInComment and (p4 > p3) then
        bInComment := False;
    end;
  finally
    SL.Free;
  end;
end;

procedure OutputError(const E : EOleException; code : string; errPos : Integer);
var
  src : TStringList;
  tmp : string;
  i, j, k, row, col : Integer;
//  origErrPos, oldRow : Integer;
begin
//  origErrPos := errPos;
  // get line number of source code from errPos if possible
  src := TStringList.Create;
  try
    row := -1;
    col := 0;
    if errPos <> -1 then
    begin
      src.Text := code;
      // calculate the line number containing character # errPos.
      row := calcRow(code, errPos);
      if row > -1 then
      begin
        // count the number of #includes before row
        j := CountIncludes(code, row);
        // count the number of CRLFs between the old errPos and the new errPos
        k := countCR(copy(code, errPos, row+j-1));
        // errPos is actually off by one for each line above the line
        // containing the error so move forward a bit
        errPos := errPos + row + j + k;
        // find the column
        tmp := Copy(code, errPos, Length(code));
        tmp := TrimLeft(Copy(tmp, 1, Pos(#13#10, tmp)-1));
//        oldRow := row;
        row := calcRow(code, errPos);
        if tmp = '' then
          col := Length(src[row-1])+1
        else
          col := Pos(tmp, src[row-1]);
      end;
    end;
    Writeln(F, '# Error:' +
               Copy(E.Message, Pos(':', E.Message) + 1, Length(E.Message))
{+ Format(' (oep=%d, ep=%d, row=%d, j=%d, k=%d)', [origErrPos, errPos, oldRow, j, k])}
            );
    if row > -1 then
    begin
      Writeln(F, 'File "' + Filename + '" ; line ' + IntToStr(row));
      Writeln(F, '# ' + src[row-1]);
      Write(F, '#');
      for i := 0 to col - 1 do
        Write(F, ' ');
      Writeln(F, '^');
    end
    else
      Writeln(F, 'File "' + Filename + '"');

    Writeln(F, '#----------------------------------------------------------');
    Writeln(F, '# 1 error during compilation');
  finally
    src.Free;
    DH.CanTerminate := True;
  end;
end;

procedure OutputSymbols(const s : OleVariant);
var
  i : Integer;
  l, h : Integer;
begin
  // s is a variant array of OleString
  l := VarArrayLowBound(s, 1);
  h := VarArrayHighBound(s, 1);
  for i := l to h do
  begin
    Writeln(s[i]);
  end;
end;

function getCodeType : CodeType;
var
  val : string;
begin
  Result := MindScript;
  if (Filename <> '') and
     (LowerCase(ExtractFileExt(Filename)) = '.asm') then
      Result := LASM;
  if ParamSwitch('-C', false) then
  begin
    val := ParamValue('-C', false);
    if (UpperCase(val) = 'LASM') or (val = '2') then
      Result := LASM
    else if (UpperCase(val) = 'RAWBYTECODE') or (val = '3') then
      Result := RawByteCode
    else if (UpperCase(val) = 'SPLITBYTECODE') or (val = '4') then
      Result := SplitByteCode
    else if (UpperCase(val) = 'VLLBYTECODE') or (val = '6') then
      Result := VLLByteCode;
  end;
end;

function getTraceLevel : Smallint;
begin
  Result := 0;
  if ParamSwitch('-TRACE') then
  begin
    Result := StrToIntDef(ParamValue('-TRACE'), 0);
  end;
end;

function getBrickStatusString(status : smallint) : string;
begin
  case status of
    NotOpened : Result := 'port not open';
    StatusReady : Result := 'brick ready';
    NoTower : Result := 'tower not connected';
    BadTower : Result := 'tower not alive';
    NoBrick : Result := 'no PBrick response';
    NoFirmware : Result := 'no firmware in PBrick';
    UnlockFailed : Result := 'failed to unlock PBrick';
    BadBrickBattery : Result := 'battery level too low';
    BrickMismatch : Result := 'wrong brick type';
    BadComms : Result := 'PBrick comms failed';
  else
    Result := 'unknown status code';
  end;
end;

function CheckVPBrick : Boolean;
var
  ivpb : IVPBrick;
begin
  Result := True;
  try
    ivpb := CoVPBrick.Create;
  except
    Result := False;
    TheErrorCode := StatusUnknown;
  end;
end;

procedure EnumBricks;
var
  i : Smallint;
  s : WideString;
  r : string;
begin
  i := NoType;
  repeat
    vpb.EnumBrickTypes(i, s);
    r := s;
  until i = NoType;
end;

procedure WriteCompilerOutput;
var
  dir, logFilename, sdk, traceFilename : string;
  traceSL, logSL : TStringList;
  i, start, stop : Integer;
const
  START_FLAG = 'Script::TranslateScript() returned: ';
  STOP_FLAG  = 'Xlate::Translate() returned:';
begin
  // copy from vpbtrace.txt to log file
  if ParamSwitch('-L', False) then
  begin
    logFilename := ParamValue('-L', False);
    dir := ExtractFilePath(logFilename);
    if dir <> '' then
      ForceDirectories(dir);
    // if the source type is ASM then the code listing is the source code
    if getCodeType = LASM then
    begin
      logSL := TStringList.Create;
      try
        logSL.Text := code;
        logSL.SaveToFile(logFilename);
      finally
        logSL.Free;
      end;
    end
    else
    begin
      // look for the vpbtrace.txt file
      sdk := GetSDKRootPath;
      if sdk <> '' then begin
        traceFilename := sdk + 'VPBrick1\vpbtrace.txt';
        if not FileExists(traceFilename) then
          traceFilename := sdk + 'VPBrick2\vpbtrace.txt';
        if FileExists(traceFilename) then
        begin
          // found the trace
          traceSL := TStringList.Create;
          try
            traceSL.LoadFromFile(traceFilename);
            start := traceSL.IndexOf(START_FLAG);
            if start <> -1 then begin
              // only continue if we manage do locate the start_flag line
              stop := traceSL.IndexOf(STOP_FLAG);
              if stop = -1 then
                stop := traceSL.Count;
              logSL := TStringList.Create;
              try
                for i := start + 1 to stop - 1 do begin
                  logSL.Add(traceSL[i]);
                end;
                logSL.SaveToFile(logFilename);
              finally
                logSL.Free;
              end;
            end;
          finally
            traceSL.Free;
          end;
          // delete the trace file if -TRACE was not specified
          if not ParamSwitch('-TRACE') then
            SysUtils.DeleteFile(traceFilename);
        end;
      end;
    end;
  end;
end;

begin
  TheErrorCode := 0;

  CoInitialize(nil);
  try
    if CheckVPBrick then
    begin
      DH := TDownloadHandler.Create;
      try
        DH.CanTerminate := True;

        if ParamCount = 0 then
        begin
          PrintUsage;
          Exit;
        end;

        vpb := TVPBrick.Create(nil);
        try
//          EnumBricks;
          // get source code
          code := getSourceCode;
          try
            // set pbrick type
            vpb.BrickType := getBrickType;
            // set path
            vpb.Path := getIncludePath;
            // set code type
            cType := getCodeType;
            // set trace level
            if ParamSwitch('-TRACE') then
              vpb.Trace := getTraceLevel;
            // if the user wants compiler code listing written to a file we need
            // to turn on tracing regardless of the -TRACE setting
            if ParamSwitch('-L', False) then
              vpb.Trace := vpb.Trace or TRACE_LISTING;
            // set compiler error output file
            setErrorOutputFile(F);
            try
              if code <> '' then
              begin
                ErrPos := -1;
                if ParamSwitch('-d', false) then
                begin
                  port := getPort;
                  try
                    vpb.Open(port);
                  except
                    on E : Exception do
                    begin
                      Writeln('error'#13#10 + E.message);
                      TheErrorCode := NotOpened;
                    end;
                  end;
                  try
                    vpb.OnDownloadDone := DH.HandleDownloadDone;
                    vpb.OnDownloadProgress := DH.HandleDownloadProgress;
                    // always check brick status first
                    status := vpb.Status(BrickStatus);
                    // the serial IR tower goes to sleep and needs to be awakened
                    if status = BadTower then
                    begin
                      // attempt to wake the tower by asking it a question and waiting a bit
                      retCnt := 0;
                      repeat
                        Sleep(100);
                        try
                          ExecuteCmd := vpb.BrickVersion;
                        except
                          on E : Exception do
                          begin
                            status := NoBrick;
                            Break;
                          end;
                        end;
                        Sleep(100);
                        status := vpb.Status(BrickStatus);
                        Inc(retCnt);
                      until (status <> BadTower) or (retCnt > MAX_RETRIES);
                    end;
                    if status = StatusReady then
                    begin
                      try
                        Write('Downloading Program:');
                        if status = StatusReady then
                        begin
                          vpb.Download(code, cType, ErrPos);
                          WriteCompilerOutput;
            //              OutputSymbols(vpb.Symbols);

                          status := vpb.Status(DownloadStatus);
                          while status = Downloading do
                          begin
                            Sleep(10);
                            Application.ProcessMessages;
                            status := vpb.Status(DownloadStatus);
                          end;
                          if not Silent then
                            try
                              // play system sound to indicate download is done
                              code := 'plays 5';
                              cType := LASM;
                              vpb.Execute(code, cType, ErrPos);
                            except
                            end;
        //                  if status <> StatusReady then
        //                    raise Exception.Create(IntToStr(status));
                        end
                        else
                        begin
                          Writeln('error'#13#10 + getBrickStatusString(status) + ' (' + IntToStr(status) + ')');
                          TheErrorCode := status;
                        end;

                      except
                        on E: EOleException do
                        begin
                          OutputError(E, code, ErrPos);
                          TheErrorCode := 0;
                        end;
                      end;
                    end
                    else
                    begin
                      Writeln('error'#13#10 + getBrickStatusString(status) + ' (' + IntToStr(status) + ')');
                      TheErrorCode := status;
                    end;
                  finally
                    vpb.OnDownloadProgress := nil;
                    vpb.OnDownloadDone := nil;
                    vpb.Close;
                  end;
                end
                else
                begin
                  try
                    vpb.Validate(code, cType, ErrPos);
                    WriteCompilerOutput
        //            OutputSymbols(vpb.Symbols);
                  except
                    on E: EOleException do
                    begin
                      OutputError(E, code, ErrPos);
                      TheErrorCode := 0;
                    end;
                  end;
                end;
              end;
            finally
              CloseFile(F);
            end;
          except
            on E : Exception do
            begin
              Writeln('error'#13#10 + E.message);
              TheErrorCode := StatusUnknown; // class not registered ?
            end;
          end;
        finally
          if Assigned(vpb) then
            vpb.Free;
        end;

      finally
        DH.Free;
      end;
    end
    else
    begin
      Writeln('error'#13#10'vpbcom.dll not registered');
    end;

  finally
    CoUninitialize;
  end;

  if TheErrorCode <> 0 then
    Halt(TheErrorCode);

end.
