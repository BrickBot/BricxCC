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
unit uMidi2MS;

interface

uses
  Classes, SysUtils;

type
  EInvalidSMFFormat = class(Exception);

  TMIDIConversionType = (mctNQC, mctMindScript, mctLASM, mctC, mctPascal,
    mctForth, mctJava, mctNBC, mctNXC, mctNXTMelody);
  TTranspose = -2..2;

  TMIDIFileToRCX = class
  private
    fTempo: Double;
    fPBS: Double;
    fGap: Integer;
    fConvType: TMIDIConversionType;
    fCurTempo : Double;
    fDivision : Integer;
    fOff : Integer;
    fNoteCount : Integer;
    fPitchBend: Boolean;
    fTranspose: TTranspose;
    fTrack: integer;
    function  GetVarInteger(s: TStream): Integer;
    procedure ProcessSysExEvent(s: TStream);
    function  ProcessMetaEvent(in_str, out_str: TStream): Integer;
    procedure ProcessMIDIFile(in_str, out_str: TStream);
    function  GetNextChar(s: TStream): Integer;
    function  TickToTime(ipend: Integer): Double;
    procedure OutputTone(out_str: TStream; pitch: Double; velo, len, gap: Integer);
    procedure InitializeTone;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Convert(const fName, fOutName : string); overload;
    procedure Convert(fStream, fOutStream : TStream); overload;
    function Convert(const fName :string) : string; overload;
    function Convert(fStream : TStream) : string; overload;
    property Tempo : Double read fTempo write fTempo;
    property CurrentTempo : Double read fCurTempo;
    property PBS : Double read fPBS write fPBS;
    property Gap : Integer read fGap write fGap;
    property ConversionType : TMIDIConversionType read fConvType write fConvType;
    property PitchBend : Boolean read fPitchBend write fPitchBend;
    property Transpose : TTranspose read fTranspose write fTranspose;
    property Track : integer read fTrack write fTrack;
  end;

function GetWait(CT : TMIDIConversionType; val: Integer;
  bAddCRLF : Boolean = true; bUseParam : Boolean = false): string;
function GetTone(T : TTranspose; CT : TMIDIConversionType; tone : Double;
  val: Integer; bAddCRLF : Boolean = true; bUseParam : Boolean = false): string;
function GetMusicHeader(CT : TMIDIConversionType): string;
function GetMusicFooter(CT : TMIDIConversionType): string;
function GetComment(CT : TMIDIConversionType; bAddCRLF : Boolean = true;
  bOnlyStart : Boolean = false): string;
function LanguageNeedsWaits(CT : TMIDIConversionType): Boolean;
procedure SaveStreamToMelodyFile(aStream : TStream; const filename : string);

function TrackCount(const filename : string) : integer;

implementation

uses
  uCommonUtils;

const
  M_LN2    = 0.69314718055994530942;

  BUFSIZ   = 1024;

  DEFTEMPO = 150;
  DEFGAP   = 2;
  DEFPBS   = 2.0;

  NOTEOF   = $80;
  NOTEON   = $90;

  PKEYPR   = $a0;
  CNTCHG   = $b0;
  PRGCHG   = $c0;
  CHANPR   = $d0;
  PITCHG   = $e0;

  A4       = 69;

  EXCLUSIVE0 = $f0;
  EXCLUSIVE7 = $f7;

  META       = $ff;
  EOT        = $2f;
  MTEMPO     = $51;
  COPYRIGHT  = $02;
  MARKER     = $06;
  CUE        = $07;

  pri_lsc =
    'program midi {'#13#10 +
    '  macro MUSIC1 {'#13#10;
  post_lsc =
    '  }'#13#10 +
    #13#10 +
    '  main {'#13#10 +
    '    try {'#13#10 +
    '      MUSIC1'#13#10 +
    '    } retry on fail'#13#10 +
    '  }'#13#10 +
    '}'#13#10;

  pri_nqc =
    'task main() {'#13#10;
  post_nqc =
    '}'#13#10;

  pri_nbc =
    'dseg segment'#13#10 +
    ' pta TSoundPlayTone'#13#10 +
    'dseg ends'#13#10 +
    #13#10 +
    'thread'#9'main'#13#10 +
    '  set pta.Loop, 0'#13#10 +
    '  set pta.Volume, 3'#13#10 +
    #13#10 +
    '; beginning of song'#13#10;
  post_nbc =
    '; end of song'#13#10 +
    'endt';

  pri_nxc =
    'task main() {'#13#10;
  post_nxc =
    '}'#13#10;

  pri_nxtmelody = '';
  post_nxtmelody = '';

  pri_lasm =
  	#9'task'#9'0'#13#10 +
    'Main:'#13#10 +
    'Retry0001:'#13#10 +
    #9'monal'#9'4,Retry0001'#13#10;
  post_lasm =
    #9'monax'#13#10 +
    'EndMain:'#13#10 +
    #9'endt'#13#10;

  pri_c =
    '#include <config.h>'#13#10 +
    '#include <dsound.h>'#13#10 +
    '#include <tm.h>'#13#10 +
    #13#10 +
    'static const note_t music[] = {'#13#10;
  post_c =
    '  { PITCH_END, 0 }'#13#10 +
    '};'#13#10 +
    #13#10 +
    'int main(int argc,char *argv[]) {'#13#10 +
    #13#10 +
    '  dsound_set_duration(10);'#13#10 +
    '  dsound_set_internote(0);'#13#10 +
    '  dsound_play(music);'#13#10 +
    '  wait_event(dsound_finished, 0);'#13#10 +
    '  dsound_set_duration(DSOUND_DEFAULT_16th_ms);'#13#10 +
    '  dsound_set_internote(DSOUND_DEFAULT_internote_ms);'#13#10 +
    '  return 0;'#13#10 +
    '}'#13#10;

  pri_pascal =
    'program midi;'#13#10 +
    #13#10 +
    'uses'#13#10 +
    '  dsound, unistd;'#13#10 +
    #13#10 +
    'const'#13#10 +
    '  music : array[0..%NOTE_COUNT%] of note_t = ('#13#10;
  post_pascal =
    '  ( PITCH_END, 0 )'#13#10 +
    '  );'#13#10 +
    #13#10 +
    'begin'#13#10 +
    '  dsound_set_duration(10);'#13#10 +
    '  dsound_set_internote(0);'#13#10 +
    '  dsound_play(@music[0]);'#13#10 +
    '  wait_event(@dsound_finished, 0);'#13#10 +
    '  dsound_set_duration(DSOUND_DEFAULT_16th_ms);'#13#10 +
    '  dsound_set_internote(DSOUND_DEFAULT_internote_ms);'#13#10 +
    'end.'#13#10;

  pri_forth =
    'BASE @'#13#10 +
    'DECIMAL'#13#10 +
    #13#10 +
    'CREATE_SONG MUSIC'#13#10;
  post_forth =
    '   0     0 NOTE,'#13#10 +
    #13#10 +
    'BASE !'#13#10;

  pri_java =
    'import josx.platform.rcx.*;'#13#10 +
    #13#10 +
    'class PlayMusic'#13#10 +
    '{'#13#10 +
    '  public static void main (String[] args)'#13#10 +
    '  {'#13#10;
  post_java =
    '  }'#13#10 +
    '}'#13#10;



  brickOS_MIDI_delta = 21; // subtract this from pitch to get brickOS note #
  brickOS_wait_name = 'PITCH_PAUSE';
  brickOS_PitchNames : array[0..96] of string = (
    'PITCH_A0', 'PITCH_Am0', 'PITCH_H0', 'PITCH_C1', 'PITCH_Cm1', 'PITCH_D1',
    'PITCH_Dm1', 'PITCH_E1', 'PITCH_F1', 'PITCH_Fm1', 'PITCH_G1', 'PITCH_Gm1',
    'PITCH_A1', 'PITCH_Am1', 'PITCH_H1', 'PITCH_C2', 'PITCH_Cm2', 'PITCH_D2',
    'PITCH_Dm2', 'PITCH_E2', 'PITCH_F2', 'PITCH_Fm2', 'PITCH_G2', 'PITCH_Gm2',
    'PITCH_A2', 'PITCH_Am2', 'PITCH_H2', 'PITCH_C3', 'PITCH_Cm3', 'PITCH_D3',
    'PITCH_Dm3', 'PITCH_E3', 'PITCH_F3', 'PITCH_Fm3', 'PITCH_G3', 'PITCH_Gm3',
    'PITCH_A3', 'PITCH_Am3', 'PITCH_H3', 'PITCH_C4', 'PITCH_Cm4', 'PITCH_D4',
    'PITCH_Dm4', 'PITCH_E4', 'PITCH_F4', 'PITCH_Fm4', 'PITCH_G4', 'PITCH_Gm4',
    'PITCH_A4', 'PITCH_Am4', 'PITCH_H4', 'PITCH_C5', 'PITCH_Cm5', 'PITCH_D5',
    'PITCH_Dm5', 'PITCH_E5', 'PITCH_F5', 'PITCH_Fm5', 'PITCH_G5', 'PITCH_Gm5',
    'PITCH_A5', 'PITCH_Am5', 'PITCH_H5', 'PITCH_C6', 'PITCH_Cm6', 'PITCH_D6',
    'PITCH_Dm6', 'PITCH_E6', 'PITCH_F6', 'PITCH_Fm6', 'PITCH_G6', 'PITCH_Gm6',
    'PITCH_A6', 'PITCH_Am6', 'PITCH_H6', 'PITCH_C7', 'PITCH_Cm7', 'PITCH_D7',
    'PITCH_Dm7', 'PITCH_E7', 'PITCH_F7', 'PITCH_Fm7', 'PITCH_G7', 'PITCH_Gm7',
    'PITCH_A7', 'PITCH_Am7', 'PITCH_H7', 'PITCH_C8', 'PITCH_Cm8', 'PITCH_D8',
    'PITCH_Dm8', 'PITCH_E8', 'PITCH_F8', 'PITCH_Fm8', 'PITCH_G8', 'PITCH_Gm8',
    'PITCH_A8'
  );

const
  MUSIC_HEADER : array[TMIDIConversionType] of string = (pri_nqc, pri_lsc,
    pri_lasm, pri_c, pri_pascal, pri_forth, pri_java, pri_nbc, pri_nxc, pri_nxtmelody);
  MUSIC_FOOTER : array[TMIDIConversionType] of string = (post_nqc, post_lsc,
    post_lasm, post_c, post_pascal, post_forth, post_java, post_nbc, post_nxc, post_nxtmelody);

{ TMIDIFileToRCX }

function TMIDIFileToRCX.GetNextChar(s : TStream) : Integer;
var
  c : Byte;
begin
  c := 0;
  if s.Read(c, 1) = 0 then
    raise EReadError.Create('unexpected EOF');
  Result := c;
end;

function TMIDIFileToRCX.GetVarInteger(s : TStream) : Integer;
var
  c : Integer;
begin
  c := 0;
  Result := 0;
  while true do begin
    c := GetNextChar(s);
    if (c and $80) = 0 then Break;
    Result := (Result + (c and $7f)) * 128;
  end;
  Result := Result + c;
end;

function PitchToFrequency(T : TTranspose; pitch : Double) : Integer;
const
  FREQ : array[TTranspose] of Double = (110.0, 220.0, 440.0, 880.0, 1760.0);
begin
  Result := trunc(FREQ[T] * exp((pitch - A4) / 12.0 * M_LN2) + 0.4);
end;

procedure TMIDIFileToRCX.InitializeTone;
begin
  fOff := 0;
end;

procedure TMIDIFileToRCX.ProcessSysExEvent(s : TStream);
var
  len : Integer;
begin
  len := GetVarInteger(s);
  s.Seek(len, soFromCurrent); 
end;

function TMIDIFileToRCX.TickToTime(ipend : Integer) : Double;
begin
  Result := (ipend * 1.0) * fDivision * fCurTempo / 6000.0;
end;

function TMIDIFileToRCX.ProcessMetaEvent(in_str, out_str : TStream) : Integer;
var
  buff : array[0..BUFSIZ] of Char;
  subcom, len : Integer;
  tmp : string;
begin
  buff[0] := #0;
  subcom := GetNextChar(in_str);
  case subcom of
    EOT: begin
      if fOff > 0 then begin
        tmp := GetWait(ConversionType, fOff);
        Inc(fNoteCount);
        out_str.Write(PChar(tmp)^, Length(tmp));
      end;
      Result := -1;
      Exit;
    end;
    MTEMPO : begin
      GetVarInteger(in_str);
      fCurTempo := (GetNextChar(in_str) * 256 + GetNextChar(in_str)) * 256 + GetNextChar(in_str);
      fCurTempo := 60.0e6 / fCurTempo;
      Result := 0;
      Exit;
    end;
    COPYRIGHT : begin
      len := GetVarInteger(in_str);
      if len > BUFSIZ - 1 then begin
        raise EReadError.Create('Too long COPYRIGHT Meta Event');
      end
      else if in_str.Read(buff, len) < len then begin
        raise EReadError.Create('Error in COPYRIGHT Meta Event');
      end
      else begin
        buff[len] := #0;
        tmp := GetComment(ConversionType, False, True) + ' Midi Copyright: ' + buff + #13#10;
        out_str.Write(PChar(tmp)^, Length(tmp));
      end;
      Result := 0;
      Exit;
    end;
    MARKER, CUE : begin
      len := GetVarInteger(in_str);
      if len > BUFSIZ - 1 then begin
        raise EReadError.Create('Too long Marker or Cue Meta Event');
      end
      else if in_str.Read(buff, len) < len then begin
        raise EReadError.Create('Error in Marker or Cue Meta Event');
      end
      else begin
        buff[len] := #0;
        tmp := GetComment(ConversionType, False, True) + ' Midi Marker: ' + buff + #13#10;
(*
		if (strncasecmp(buff, "nqc:", 4) == 0)
    {
		    printf("\t");
		    if (fOff > 0) {
          if (LSC)
            printf("\twait %d\n", fOff);
          else
            printf("Wait(%d); ", fOff);
          fOff = 0;
		    }
		    printf("%s\n", buff + 4);
		}
*)
        out_str.Write(PChar(tmp)^, Length(tmp));
      end;
      Result := 0;
      Exit;
    end;
  else
    len := GetVarInteger(in_str);
    in_str.Seek(len, soFromCurrent);
    Result := 0;
    Exit;
  end;
end;

procedure TMIDIFileToRCX.OutputTone(out_str : TStream; pitch : Double; velo, len, gap : Integer);
var
  iOn : Integer;
  tmp : string;
begin
  if len <= 0 then begin
    Exit;
  end
  else if velo = 0 then begin
    Inc(fOff, len);
  end
  else begin
    iOn := len - gap;
    if fOff > 0 then begin
      tmp := GetWait(ConversionType, fOff);
      Inc(fNoteCount);
      out_str.Write(PChar(tmp)^, Length(tmp));
    end;
    while iOn > 255 do begin
      tmp := GetTone(Transpose, ConversionType, pitch, 255);
      Inc(fNoteCount);
      // not all languages require a wait when playing a tone
      if LanguageNeedsWaits(ConversionType) then begin
        tmp := tmp + GetWait(ConversionType, 255);
        Inc(fNoteCount);
      end;
      out_str.Write(PChar(tmp)^, Length(tmp));
      Dec(iOn, 255);
      Dec(len, 255);
    end;
    if iOn > 0 then begin
      tmp := GetTone(Transpose, ConversionType, pitch, iOn);
      Inc(fNoteCount);
      out_str.Write(PChar(tmp)^, Length(tmp));
    end;
    if LanguageNeedsWaits(ConversionType) then
      fOff := len
    else
      fOff := 0;
  end;
end;

procedure TMIDIFileToRCX.ProcessMIDIFile(in_str, out_str : TStream);
var
  mhead : MTHD;
  tkhead : MTRK;
  delta, laststat, lastvelocity : Integer;
  lastpitch, pitch, shift, lastshift : Double;
  event, velocity : Integer;
  midiend : Integer;
  lsb, msb, tmpInt : Integer;
  pbsense, pend : Double;
  poly, ipend, lgap : Integer;
  smfFormat, smfTracks : Word;
  smfHeadLen, trackLen : Cardinal;
  curTrack : integer;
begin
  poly := 0;
  pend := 0.0;
  pbsense := PBS / ($2000 * 1.0);
  fCurTempo := Tempo;
  lgap := Gap;
  InitializeTone;

  mhead.id := 'MThd'; // initialize struct to quiet compiler hints
  if not ReadMIDIMTHD(in_str, mhead) then
    raise EInvalidSMFFormat.Create('Too short');
  if CompareStr(mhead.id, 'MThd') <> 0 then
    raise EInvalidSMFFormat.Create('No SMF header');
  // file has an apparently valid SMF header
  smfFormat  := mhead.fmt;
  smfTracks  := mhead.track;
  smfHeadLen := mhead.len;
  fDivision  := mhead.div_;


  if smfHeadLen <> 6 then
    raise EInvalidSMFFormat.CreateFmt('Invalid SMF header length (%d)', [smfHeadLen]);
  if (smfFormat <> 0) and (smfFormat <> 1) then
    raise EReadError.Create('Not SMF format 0 or format 1 data');
  if smfTracks < Track then
    raise EReadError.Create('Specified track does not exist');

  tkhead.id := 'MTrk'; // initialize struct to quiet compiler hints
  // now we need to advance to the specified track.
  // If theTrack == 0 then we are already there
  curTrack := 0;
  while curTrack <= Track do
  begin
    if not ReadMIDIMTRK(in_str, tkhead) then
      raise EReadError.Create('No track data');
    if CompareStr(tkhead.id, 'MTrk') <> 0 then
      raise EReadError.Create('No SMF track chunk');
    trackLen := tkhead.len;
    inc(curTrack);
    // if curTrack is less than or equal to Track then we need to skip ahead
    // the trackLen number of bytes to the next track header
    if curTrack <= Track then
      in_str.Seek(trackLen, soFromCurrent);
  end;
  
  // we are positioned to read data from the desired track
  laststat     := 0;
  lastvelocity := 0;
  lastshift    := 0.0;
  lastpitch    := 0.0;

  midiend      := 0;
  while midiend = 0 do begin
    delta := GetVarInteger(in_str);
    pend  := pend + (delta * 1.0);
    ipend := trunc(pend * 6000 / fDivision / fCurTempo);
    event := GetNextChar(in_str);
    if (event and $80) = 0 then begin
      in_str.Seek(-1, soFromCurrent);
      event := laststat;
    end;
    tmpInt := event and $F0;
    case tmpInt of
      NOTEOF : begin
        pitch := GetNextChar(in_str);
        GetNextChar(in_str);
        velocity := 0;
        Dec(poly);
        if poly = 0 then begin
          OutputTone(out_str, lastpitch, lastvelocity, ipend, lgap);
          pend := pend - TickToTime(ipend);
          lastpitch := pitch;
          lastvelocity := velocity;
        end;
      end;
      NOTEON : begin
        pitch := GetNextChar(in_str);
        velocity := GetNextChar(in_str);
        if velocity <> 0 then begin
          OutputTone(out_str, lastpitch + lastshift, lastvelocity, ipend, lgap);
          Inc(poly);
          pend := pend - TickToTime(ipend);
          lastpitch := pitch;
          lastvelocity := velocity;
        end
        else begin
          Dec(poly);
          if poly = 0 then begin
            OutputTone(out_str, lastpitch + lastshift, lastvelocity, ipend, lgap);
            pend := pend - TickToTime(ipend);
            lastpitch := pitch;
            lastvelocity := velocity;
          end;
        end;
      end;
      PKEYPR, CNTCHG : begin
        GetNextChar(in_str);
        GetNextChar(in_str);
      end;
      PRGCHG, CHANPR : begin
        GetNextChar(in_str);
      end;
      PITCHG : begin
        lsb := GetNextChar(in_str);
        msb := GetNextChar(in_str);
        shift := (msb * 128 + lsb - $2000) * pbsense;
        if lastvelocity <> 0 then begin
          if PitchBend then
            OutputTone(out_str, lastpitch + lastshift, lastvelocity, ipend, 0);
          pend := pend - TickToTime(ipend);
        end;
        lastshift := shift;
      end;
    else
      case event of
        EXCLUSIVE0, EXCLUSIVE7 : begin
          ProcessSysExEvent(in_str);
          lastpitch := 0;
          lastvelocity := 0;
        end;
        META : begin
          midiend := ProcessMetaEvent(in_str, out_str);
          lastpitch := 0;
          lastvelocity := 0;
        end;
      end;
    end;
    laststat := event;
  end;
end;

const
  OP : array[mctC..mctPascal] of string = ('  { ', '  ( ');
  CP : array[mctC..mctPascal] of string = (' },', ' ),');

function GetBrickOSPitchName(T : TTranspose; tone: Double): string;
var
  i : Integer;
begin
  i := trunc(tone) - brickOS_MIDI_delta + (T * 12);
  if (i < Low(brickOS_PitchNames)) or (i > High(brickOS_PitchNames)) then
    Result := brickOS_wait_name
  else
    Result := brickOS_PitchNames[i];
end;

function GetWait(CT : TMIDIConversionType; val: Integer; bAddCRLF : boolean;
  bUseParam : Boolean): string;
var
  CRLF : string;
  WT : string;
begin
  CRLF := '';
  if bAddCRLF then
    CRLF := #13#10;
  WT := '';
  if bUseParam then
    WT := '*__WAITTIME';
  case CT of
    mctNQC        : Result := Format('  Wait(%d' + WT + ');'+CRLF, [val]);
    mctMindScript : Result := Format('    wait %d'+CRLF, [val]);
    mctLASM       : Result := Format(#9'wait'#9'2,%d'+CRLF, [val]);
    mctNBC        : Result := Format('  waitv %d'+CRLF, [val*10]);
    mctNXC        : Result := Format('  Wait(%d);'+CRLF, [val*10]);
    mctNXTMelody  : Result := Format('w=%d'#13#10, [val*10]);
    mctC,
    mctPascal     :
      Result := Format(OP[CT] + brickOS_wait_name + ', %d' + CP[CT] + CRLF, [val]);
    mctForth    : Result := Format(' %3d %5d NOTE,'+CRLF, [val, 0]);
    mctJava     : Result := Format('    sleep(%d);'+CRLF, [val*10]);
  end;
end;

function GetTone(T : TTranspose; CT : TMIDIConversionType; tone : Double;
  val: Integer; bAddCRLF : Boolean; bUseParam : Boolean): string;
var
  CRLF : string;
  NT : string;
begin
  CRLF := '';
  if bAddCRLF then
    CRLF := #13#10;
  NT := '';
  if bUseParam then
    NT := '*__NOTETIME';
  case CT of
    mctNQC :
      Result := Format('  PlayTone(%d,%d' + NT + ');'+CRLF, [PitchToFrequency(T, tone), val]);
    mctMindScript :
      Result := Format('    tone %d for %d'+CRLF, [PitchToFrequency(T, tone), val]);
    mctLASM :
      Result := Format(#9'playt'#9'%d,%d'+CRLF, [PitchToFrequency(T, tone), val]);
    mctNBC :
      Result := Format('  set pta.Frequency, %d'+CRLF+'  set pta.Duration, %d'+
        CRLF+'  syscall SoundPlayTone, pta'+CRLF, [PitchToFrequency(T, tone), val*10]);
    mctNXC :
      Result := Format('  PlayTone(%d,%d);'+CRLF, [PitchToFrequency(T, tone), val*10]);
    mctNXTMelody :
      Result := Format('f=%d'#13#10'w=%d'#13#10, [PitchToFrequency(T, tone), val*10]);
    mctC,
    mctPascal :
      Result := Format(OP[CT] + '%s, %d' + CP[CT] + CRLF,
                       [GetBrickOSPitchName(T, tone), val]);
    mctForth :
      Result := Format(' %3d %5d NOTE,'+CRLF, [val, PitchToFrequency(T, tone)]);
    mctJava :
      Result := Format('    Sound.playTone(%d,%d);'+CRLF, [PitchToFrequency(T, tone), val]);
  end;
end;

function GetMusicHeader(CT : TMIDIConversionType): string;
begin
  Result := MUSIC_HEADER[CT];
end;

function GetMusicFooter(CT : TMIDIConversionType): string;
begin
  Result := MUSIC_FOOTER[CT];
end;

function GetComment(CT : TMIDIConversionType; bAddCRLF : boolean;
  bOnlyStart : Boolean): string;
var
  CRLF : string;
begin
  CRLF := '';
  if bAddCRLF then
    CRLF := #13#10;
  case CT of
    mctNQC,
    mctMindScript,
    mctC,
    mctNXC,
    mctJava,
    mctPascal    : Result := '//';
    mctLASM,
    mctNBC,
    mctNXTMelody : Result := ';';
    mctForth     : Result := '\';
  end;
  if not bOnlyStart then
    Result := Result + ' code generated by Bricx Command Center'+CRLF;
end;

constructor TMIDIFileToRCX.Create;
begin
  inherited Create;
  fTempo     := DEFTEMPO;
  fPBS       := DEFPBS;
  fGap       := DEFGAP;
  fConvType  := mctNQC;
  fPitchBend := False;
  fTranspose := 0;
  fTrack     := 0;
end;

destructor TMIDIFileToRCX.Destroy;
begin
  inherited;
end;

procedure TMIDIFileToRCX.Convert(const fName, fOutName: string);
var
  S : TFileStream;
  MS : TMemoryStream;
begin
  S := TFileStream.Create(fName, fmOpenRead or fmShareDenyNone);
  try
    MS := TMemoryStream.Create;
    try
      Convert(S, MS);
      if ConversionType = mctNXTMelody then
      begin
        // convert to Melody file format
        SaveStreamToMelodyFile(MS, fOutName);
      end
      else
        MS.SaveToFile(fOutName);
    finally
      MS.Free;
    end;
  finally
    S.Free;
  end;
end;

procedure TMIDIFileToRCX.Convert(fStream, fOutStream: TStream);
var
  tmpStr : string;
begin
  tmpStr := GetComment(ConversionType);
  fOutStream.Write(PChar(tmpStr)^, length(tmpStr));
  tmpStr := GetMusicHeader(ConversionType);
  fOutStream.Write(PChar(tmpStr)^, length(tmpStr));
  fNoteCount := 0;

  ProcessMIDIFile(fStream, fOutStream);

  tmpStr := GetMusicFooter(ConversionType);
  fOutStream.Write(PChar(tmpStr)^, length(tmpStr));
  fOutStream.Position := 0;
end;

function TMIDIFileToRCX.Convert(const fName: string): string;
var
  S : TFileStream;
begin
  S := TFileStream.Create(fName, fmOpenRead or fmShareDenyNone);
  try
    Result := Convert(S);
  finally
    S.Free;
  end;
end;

function TMIDIFileToRCX.Convert(fStream: TStream): string;
var
  MS : TMemoryStream;
  SL : TStringList;
begin
  MS := TMemoryStream.Create;
  try
    SL := TStringList.Create;
    try
      Convert(fStream, MS);
      SL.LoadFromStream(MS);
      if ConversionType = mctPascal then
        Result := StringReplace(SL.Text, '%NOTE_COUNT%', IntToStr(fNoteCount), [])
      else
        Result := SL.Text;
    finally
      SL.Free;
    end;
  finally
    MS.Free;
  end;
end;

function LanguageNeedsWaits(CT : TMIDIConversionType): Boolean;
begin
  Result := CT in [mctNQC, mctMindScript, mctLASM, mctJava, mctNBC, mctNXC];
end;

procedure SaveStreamToMelodyFile(aStream: TStream; const filename: string);
var
  SL : TStringList;
  tmpStr : String;
  msOut : TMemoryStream;
  i, oldLen : integer;
  B : Byte;
  MelodyFmt, PlayMode, Tones, DataBytes, freq, dur : word;
  dbArray : array of Byte;
begin
  SetLength(dbArray, 0);
  MelodyFmt := $0600; // melody file format
  SL := TStringList.Create;
  try
    aStream.Position := 0;
    SL.LoadFromStream(aStream);
    // process the string list into dbArray
    i := 0;
    while i < SL.Count do
    begin
      tmpStr := SL[i];
      if Pos('w=', tmpStr) = 1 then
      begin
        // for every wait line output frequency and duration information
        // the frequence information is from the previous line or 0 if
        // the previous line is either not available or not a f= line
        if (i > 0) and (Pos('f=', SL[i-1]) = 1) then
        begin
          freq := Word(StrToIntDef(Copy(SL[i-1], 3, MaxInt), 0));
        end
        else
          freq := 0;
        dur := Word(StrToIntDef(Copy(tmpStr, 3, MaxInt), 0));
        oldLen := Length(dbArray);
        SetLength(dbArray, oldLen+4);
        dbArray[oldLen+0] := Hi(freq);
        dbArray[oldLen+1] := Lo(freq);
        dbArray[oldLen+2] := Hi(dur);
        dbArray[oldLen+3] := Lo(dur);
      end;
      inc(i);
    end;
    if Length(dbArray) > 0 then
    begin
      msOut := TMemoryStream.Create;
      try
        // write the Melody file format
        B := Hi(MelodyFmt);
        msOut.Write(B, 1);
        B := Lo(MelodyFmt);
        msOut.Write(B, 1);

        // write the DataBytesMSB/LSB
        DataBytes := Word(Length(dbArray));
        B := Hi(DataBytes);
        msOut.Write(B, 1);
        B := Lo(DataBytes);
        msOut.Write(B, 1);

        // write the TonesMSB/LSB
        Tones := 0;
        B := Hi(Tones);
        msOut.Write(B, 1);
        B := Lo(Tones);
        msOut.Write(B, 1);

        // write the PlayModeMSB/LSB
        PlayMode := 0;
        B := Hi(PlayMode);
        msOut.Write(B, 1);
        B := Lo(PlayMode);
        msOut.Write(B, 1);

        // copy to msOut from dbArray
        for i := 0 to DataBytes - 1 do
          msOut.Write(dbArray[i], 1);

        msOut.SaveToFile(filename);
      finally
        msOut.Free;
      end;
    end;
  finally
    SL.Free;
  end;
end;

function TrackCount(const filename : string) : integer;
var
  mhead : MTHD;
  in_str : TFileStream;
begin
  Result := 0;
  if FileExists(filename) then
  begin
    in_str := TFileStream.Create(filename, fmOpenRead);
    try
      mhead.id := 'MThd'; // initialize struct to quiet compiler hints
      if not ReadMIDIMTHD(in_str, mhead) then
      if CompareStr(mhead.id, 'MThd') <> 0 then
        Exit;
      // file has an apparently valid SMF header
      Result := mhead.track;
    finally
      in_str.Free;
    end;
  end;
end;


end.

