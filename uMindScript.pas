unit uMindScript;

interface

uses
  Classes;

procedure PopulateMindscriptWordList(aWord : string; aStrings : TStrings);

implementation

uses
  SysUtils;

const
  MindScriptWords : array[0..90] of string = (
    'abort','abs','as','assert',
    'backward','bk','boot','brick',
    'calibrate','clear','comment','const','counter',
    'data','dir','direction','display',
    'eeprom','else','event',
    'fd','find','fire','fixed',
    'float','for','forever','forward','fragment','fx',
    'gate','get','glide','global',
    'if','in','is',
    'led','link','local','log',
    'macro','main','message','mode','monitor',
    'off','on','output',
    'ping','power','priority','program',
    'random','randomize','remote','repeat',
    'restart','retry','reverse',
    'select','semaphore','send','sensor','sgn','sleep','slot','sound',
    'standalone','start','stop','sub',
    'target','task','timer','to','tone',
    'trigger','try','type',
    'until',
    'value','var','vibrato','vll',
    'wait','watch','watcher','when','while','world'
  );

  MSDotWords : array[0..16] of string = (
    'change','click','doubleclick',
    'enter','high','hysteresis',
    'low','normal','power','pressed',
    'raw','released','sound','state','status','time','type'
  );

  BrickWords : array[0..4] of string = (
    'alive?','battery?','transmitter power','tx power','version?'
  );

  GetWords : array[0..5] of string = (
    'data','eeprom','map','message','target','world'
  );

  ClearWords : array[0..10] of string = (
    'data','display','message',
    'sleep','sound','sub','subs',
    'target','task','tasks','world'
  );

  IsWords : array[0..7] of string = (
    'closed','light','not','opened','rotation',
    'switch','temperature','unknown'
  );

  AsWords : array[0..7] of string = (
    'angle','boolean','celsius','fahrenheit',
    'percent','periodic','raw','transition'
  );

  WaitWords : array[0..1] of string = (
    'random','until'
  );

  FixedWords : array[0..1] of string = (
    'tone','wait'
  );

  SoundWords : array[0..2] of string = (
    'off','on','when'
  );

  ForWords : array[0..0] of string = (
    'random'
  );

  StopWords : array[0..1] of string = (
    'on','tasks'
  );

  SleepWords : array[0..0] of string = (
    'after'
  );

  BootWords : array[0..1] of string = (
    'firmware','rom'
  );

  GateWords : array[0..0] of string = (
    'off'
  );

  OnWords : array[0..1] of string = (
    'event', 'fail'
  );

  GlobalWords : array[0..10] of string = (
    'backward','bk','dir','direction',
    'fd','float','forward','off','on','power','reverse'
  );

  LogWords : array[0..0] of string = (
    'message'
  );

  StartWords : array[0..0] of string = (
    'main'
  );

  SendWords : array[0..1] of string = (
    'message','rcx'
  );

  ModeWords : array[0..1] of string = (
    'power','standalone'
  );

  RepeatWords : array[0..0] of string = (
    'random'
  );

  AbortWords : array[0..0] of string = (
    'on'
  );

  RestartWords : array[0..0] of string = (
    'on'
  );

  RetryWords : array[0..0] of string = (
    'on'
  );

  VLLWords : array[0..1] of string = (
    'off','on'
  );

  DisplayWords : array[0..0] of string = (
    'watch'
  );

  FindWords : array[0..0] of string = (
    'world'
  );

type
  TMapEntry = record
    key : string;
    size : Integer;
    values : array of string;
  end;

var
  WordMap : array[0..27] of TMapEntry;

procedure PopulateMindscriptWordList(aWord : string; aStrings : TStrings);
var
  i, j : Integer;
begin
  aStrings.Clear;
  j := 0;
  for i := Low(WordMap) to High(WordMap) do
  begin
    if WordMap[i].key = LowerCase(aWord) then
    begin
      j := i;
      Break;
    end;
  end;

  for i := 0 to WordMap[j].size do
  begin
    aStrings.Add(WordMap[j].values[i]);
  end;

end;

var
  i : Integer;
  j : Integer = 0;

initialization

  WordMap[j].key := '';
  WordMap[j].size := High(MindScriptWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(MindScriptWords) to High(MindScriptWords) do
    WordMap[j].values[i] := MindScriptWords[i];
  Inc(j);

  WordMap[j].key := '.';
  WordMap[j].size := High(MSDotWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(MSDotWords) to High(MSDotWords) do
    WordMap[j].values[i] := MSDotWords[i];
  Inc(j);

  WordMap[j].key := 'brick';
  WordMap[j].size := High(BrickWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(BrickWords) to High(BrickWords) do
    WordMap[j].values[i] := BrickWords[i];
  Inc(j);

  WordMap[j].key := 'get';
  WordMap[j].size := High(GetWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(GetWords) to High(GetWords) do
    WordMap[j].values[i] := GetWords[i];
  Inc(j);

  WordMap[j].key := 'clear';
  WordMap[j].size := High(ClearWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(ClearWords) to High(ClearWords) do
    WordMap[j].values[i] := ClearWords[i];
  Inc(j);

  WordMap[j].key := 'is';
  WordMap[j].size := High(IsWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(IsWords) to High(IsWords) do
    WordMap[j].values[i] := IsWords[i];
  Inc(j);

  WordMap[j].key := 'as';
  WordMap[j].size := High(AsWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(AsWords) to High(AsWords) do
    WordMap[j].values[i] := AsWords[i];
  Inc(j);

  WordMap[j].key := 'wait';
  WordMap[j].size := High(WaitWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(WaitWords) to High(WaitWords) do
    WordMap[j].values[i] := WaitWords[i];
  Inc(j);

  WordMap[j].key := 'fixed';
  WordMap[j].size := High(FixedWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(FixedWords) to High(FixedWords) do
    WordMap[j].values[i] := FixedWords[i];
  Inc(j);

  WordMap[j].key := 'sound';
  WordMap[j].size := High(SoundWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(SoundWords) to High(SoundWords) do
    WordMap[j].values[i] := SoundWords[i];
  Inc(j);

  WordMap[j].key := 'for';
  WordMap[j].size := High(ForWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(ForWords) to High(ForWords) do
    WordMap[j].values[i] := ForWords[i];
  Inc(j);

  WordMap[j].key := 'stop';
  WordMap[j].size := High(StopWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(StopWords) to High(StopWords) do
    WordMap[j].values[i] := StopWords[i];
  Inc(j);

  WordMap[j].key := 'sleep';
  WordMap[j].size := High(SleepWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(SleepWords) to High(SleepWords) do
    WordMap[j].values[i] := SleepWords[i];
  Inc(j);

  WordMap[j].key := 'boot';
  WordMap[j].size := High(BootWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(BootWords) to High(BootWords) do
    WordMap[j].values[i] := BootWords[i];
  Inc(j);

  WordMap[j].key := 'gate';
  WordMap[j].size := High(GateWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(GateWords) to High(GateWords) do
    WordMap[j].values[i] := GateWords[i];
  Inc(j);

  WordMap[j].key := 'on';
  WordMap[j].size := High(OnWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(OnWords) to High(OnWords) do
    WordMap[j].values[i] := OnWords[i];
  Inc(j);

  WordMap[j].key := 'global';
  WordMap[j].size := High(GlobalWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(GlobalWords) to High(GlobalWords) do
    WordMap[j].values[i] := GlobalWords[i];
  Inc(j);

  WordMap[j].key := 'log';
  WordMap[j].size := High(LogWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(LogWords) to High(LogWords) do
    WordMap[j].values[i] := LogWords[i];
  Inc(j);

  WordMap[j].key := 'start';
  WordMap[j].size := High(StartWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(StartWords) to High(StartWords) do
    WordMap[j].values[i] := StartWords[i];
  Inc(j);

  WordMap[j].key := 'send';
  WordMap[j].size := High(SendWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(SendWords) to High(SendWords) do
    WordMap[j].values[i] := SendWords[i];
  Inc(j);

  WordMap[j].key := 'mode';
  WordMap[j].size := High(ModeWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(ModeWords) to High(ModeWords) do
    WordMap[j].values[i] := ModeWords[i];
  Inc(j);

  WordMap[j].key := 'repeat';
  WordMap[j].size := High(RepeatWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(RepeatWords) to High(RepeatWords) do
    WordMap[j].values[i] := RepeatWords[i];
  Inc(j);

  WordMap[j].key := 'abort';
  WordMap[j].size := High(AbortWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(AbortWords) to High(AbortWords) do
    WordMap[j].values[i] := AbortWords[i];
  Inc(j);

  WordMap[j].key := 'restart';
  WordMap[j].size := High(RestartWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(RestartWords) to High(RestartWords) do
    WordMap[j].values[i] := RestartWords[i];
  Inc(j);

  WordMap[j].key := 'retry';
  WordMap[j].size := High(RetryWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(RetryWords) to High(RetryWords) do
    WordMap[j].values[i] := RetryWords[i];
  Inc(j);

  WordMap[j].key := 'vll';
  WordMap[j].size := High(VLLWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(VLLWords) to High(VLLWords) do
    WordMap[j].values[i] := VLLWords[i];
  Inc(j);

  WordMap[j].key := 'display';
  WordMap[j].size := High(DisplayWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(DisplayWords) to High(DisplayWords) do
    WordMap[j].values[i] := DisplayWords[i];
  Inc(j);

  WordMap[j].key := 'find';
  WordMap[j].size := High(FindWords);
  SetLength(WordMap[j].values, WordMap[j].size+1);
  for i := Low(FindWords) to High(FindWords) do
    WordMap[j].values[i] := FindWords[i];
  Inc(j);

end.
