unit uRmdPlayer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uOfficeComp, uSpin;

type
  TfrmRmdPlayer = class(TForm)
    lblFile: TLabel;
    edtFile: TEdit;
    btnOpen: TSpeedButton;
    dlgOpen: TOpenDialog;
    radSpeaker: TRadioButton;
    radSoundCard: TRadioButton;
    ogpTop: TOfficeGradientPanel;
    osbPlay: TOfficeSpeedButton;
    osbConvert: TOfficeSpeedButton;
    osbStop: TOfficeSpeedButton;
    Bevel1: TBevel;
    Label1: TLabel;
    edtVolume: TSpinEdit;
    procedure btnOpenClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StateChange(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    procedure WMDROPFILES(var Message: TWMDROPFILES);  message WM_DROPFILES;
    procedure UpdateButtonState;
  public
    { Public declarations }
  end;

var
  frmRmdPlayer: TfrmRmdPlayer;

type
  TVolumeLevel = 0..127;

procedure PlayRMDFile(const filename : string; bSpeaker : boolean;
  vol : TVolumeLevel; bConvert : boolean);

implementation

{$R *.dfm}

uses
  Math, MMSystem, ShellAPI, uCommonUtils;

procedure TfrmRmdPlayer.WMDROPFILES(var Message: TWMDROPFILES);
var
  buffer:array[0..255] of char;
  cnt, i : Integer;
begin
  cnt := DragQueryFile(Message.Drop, $FFFFFFFF, @buffer, sizeof(buffer));
  Screen.Cursor := crHourGlass;
  try
    for i := 0 to cnt - 1 do
    begin
      DragQueryFile(Message.Drop,i,@buffer,sizeof(buffer));
      edtFile.Text := buffer;
      UpdateButtonState;
      Application.ProcessMessages;
      btnPlayClick(Self);
      Application.ProcessMessages;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmRmdPlayer.btnOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edtFile.Text := dlgOpen.FileName;
end;

type
  IntArray = array of Integer;

const
  WAVE_FORMAT_PCM = 1;

{writes tone to memory and plays it}
procedure MakeSound(Frequency{Hz}, Duration{mSec}: IntArray;
  const SampleRate : Integer = 8000; const Volume: TVolumeLevel = 60;
  const filename : string = '');
var
  WaveFormatEx: TWaveFormatEx;
  MS: TMemoryStream;
  i, j, TempInt, DataCount, TotalDuration, RiffCount: integer;
  dur : integer;
  SoundValue: byte;
  w: double; // omega ( 2 * pi * frequency)
  buf : PChar;
const
  Mono: Word = $0001;
  RiffId: string = 'RIFF';
  WaveId: string = 'WAVE';
  FmtId: string = 'fmt ';
  DataId: string = 'data';
begin
  with WaveFormatEx do
  begin
    wFormatTag := WAVE_FORMAT_PCM;
    nChannels := Mono;
    nSamplesPerSec := SampleRate;
    wBitsPerSample := $0008;
    nBlockAlign := (nChannels * wBitsPerSample) div 8;
    nAvgBytesPerSec := nSamplesPerSec * nBlockAlign;
    cbSize := 0;
  end;
  MS := TMemoryStream.Create;
  try
    with MS do
    begin
      // what is the total duration?
      TotalDuration := 0;
      for i := Low(Duration) to High(Duration) do
      begin
        inc(TotalDuration, Duration[i]);
      end;
      {Calculate length of sound data and of file data}
      DataCount := Max(1,(TotalDuration div 1000)) * SampleRate; // sound data
      RiffCount := Length(WaveId) + Length(FmtId) + SizeOf(DWORD) +
        SizeOf(TWaveFormatEx) + Length(DataId) + SizeOf(DWORD) + DataCount; // file data
      {write out the wave header}
      Write(RiffId[1], 4); // 'RIFF'
      WriteCardinalToStream(MS, RiffCount);
      Write(WaveId[1], 4); // 'WAVE'
      Write(FmtId[1], 4); // 'fmt '
      TempInt := SizeOf(TWaveFormatEx);
      WriteCardinalToStream(MS, TempInt);
      WriteWaveFormatToStream(MS, WaveFormatEx);
      Write(DataId[1], 4); // 'data'
      WriteCardinalToStream(MS, DataCount);
      for j := Low(Duration) to High(Duration) do
      begin
        // chop the durations just a bit
        dur := Trunc(Duration[j] * 0.9);
        // play the tone for 9/10ths of the duration
        DataCount := (dur * SampleRate) div 1000; // sound data
        {calculate and write out the tone signal} // now the data values
        w := 2 * Pi * Frequency[j]; // omega
        for i := 0 to DataCount - 1 do
        begin
          SoundValue := 127 + trunc(Volume * sin(i * w / SampleRate)); // wt = w * i / SampleRate
          Write(SoundValue, SizeOf(Byte));
        end;
        // now silence for the remaining 1/10th
        DataCount := ((Duration[j] - dur) * SampleRate) div 1000; // sound data
        {calculate and write out the tone signal} // now the data values
        w := 0; // omega
        for i := 0 to DataCount - 1 do
        begin
          SoundValue := 127 + trunc(Volume * sin(i * w / SampleRate)); // wt = w * i / SampleRate
          Write(SoundValue, SizeOf(Byte));
        end;
      end;
      {now play the sound or save it to a file}
      if filename <> '' then
        MS.SaveToFile(filename)
      else
      begin
        GetMem(buf, MS.Size);
        MoveMemory(buf, MS.Memory, MS.Size);
        PlaySound(buf, Application.Handle, SND_MEMORY or SND_ASYNC or SND_NOSTOP);
      end;
    end;
  finally
    MS.Free;
  end;
end;

procedure TfrmRmdPlayer.btnPlayClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    PlayRMDFile(edtFile.Text, radSpeaker.Checked, edtVolume.Value, Sender = osbConvert);
  finally
    Screen.Cursor := crDefault;
  end;
end;

const
  SampleRate: Integer = 8000; // 8000, 11025, 22050, or 44100

procedure PlayRMDFile(const filename : string; bSpeaker : boolean;
  vol : TVolumeLevel; bConvert : boolean);
var
  ms : TMemoryStream;
  msb, lsb : Byte;
  dataBytes : Word;
  MelodyFmt, freq, dur : Word;
  freqArray, durArray : IntArray;
  i, oldLen : integer;
begin
  MelodyFmt := $0600; // melody file format
  if FileExists(filename) then
  begin
    ms := TMemoryStream.Create;
    try
      ms.LoadFromFile(filename);
      if ms.Size >= 8 then
      begin
        ms.Position := 0;
        // read the format
        ms.Read(msb, 1);
        ms.Read(lsb, 1);
        if ((msb * 256) + lsb) = MelodyFmt then
        begin
          // read data bytes
          ms.Read(msb, 1);
          ms.Read(lsb, 1);
          dataBytes := (msb * 256) + lsb;
          if (dataBytes > 0) and ((dataBytes mod 4) = 0) then
          begin
            // tones exist and dataBytes is a multiple of 4
            ms.Seek(4, soFromCurrent); // skip the next 4 bytes
            // build up our data arrays
            while dataBytes > 0 do
            begin
              // read frequency
              ms.Read(msb, 1);
              ms.Read(lsb, 1);
              freq := (msb * 256) + lsb;
              // read duration
              ms.Read(msb, 1);
              ms.Read(lsb, 1);
              dur := (msb * 256) + lsb;
              oldLen := Length(freqArray);
              SetLength(freqArray, oldLen + 1);
              SetLength(durArray, oldLen + 1);
              freqArray[oldLen] := freq;
              durArray[oldLen]  := dur;
              dec(dataBytes, 4);
            end;
            if Length(freqArray) > 0 then
            begin
              if bSpeaker then
              begin
                if bConvert then
                  MakeSound(freqArray, durArray, SampleRate, vol, ChangeFileExt(filename, '.wav'));
                for i := Low(freqArray) to High(freqArray) do
                begin
                  freq := freqArray[i];
                  dur  := durArray[i];
                  if freq > 0 then
                    Windows.Beep(freq, dur)
                  else
                    Sleep(dur);
                end;
              end
              else
              begin
                if bConvert then
                  MakeSound(freqArray, durArray, SampleRate, vol, ChangeFileExt(filename, '.wav'))
                else
                  MakeSound(freqArray, durArray, SampleRate, vol);
              end;
            end;
          end;
        end;
      end;
    finally
      ms.Free;
    end;
  end;
end;

procedure TfrmRmdPlayer.FormCreate(Sender: TObject);
begin
  {Let Windows know we accept dropped files}
  DragAcceptFiles(Handle,true);
  UpdateButtonState;
end;

procedure TfrmRmdPlayer.StateChange(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TfrmRmdPlayer.UpdateButtonState;
begin
  osbPlay.Enabled := FileExists(edtFile.Text);
  osbConvert.Enabled := osbPlay.Enabled;
  osbStop.Enabled := True;
end;

procedure TfrmRmdPlayer.btnStopClick(Sender: TObject);
begin
  if radSoundCard.Checked then
    PlaySound(nil, Application.Handle, SND_MEMORY or SND_ASYNC);
end;

procedure TfrmRmdPlayer.btnSaveClick(Sender: TObject);
begin
  btnPlayClick(osbConvert);
end;

end.
