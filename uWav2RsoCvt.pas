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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uWav2RsoCvt;

interface

uses
  Classes;

const
  RSO_DEFAULT_RATE = 8000;

procedure ConvertWave2RSO(filename, outdir : string; sample_rate : Cardinal;
  resample_method : integer; bUseComp : boolean; ext : string; msgs : TStrings);
procedure ConvertRSO2Wave(filename, outdir : string; msgs : TStrings);

implementation

uses
  SysUtils, uUtilities, uStreamRW, uSrc, uSrcCommon, uLocalizedStrings,
  uWavCommon;

procedure ConvertSampleRate(aStream : TMemoryStream; ratio : double; converter : integer);
var
  data : PSRC_DATA;
  i : integer;
  b : byte;
  sample : double;
  p : PChar;
begin
//  SetRoundMode(rmNearest);
  data := AllocMem(SizeOf(SRC_DATA));
  try
    // allocate memory for input and output data
    data^.data_in  := AllocMem(SizeOf(Double)*aStream.Size);
    data^.data_out := AllocMem(SizeOf(Double)*aStream.Size);
    data^.src_ratio := ratio;
    data^.input_frames := aStream.Size;
    data^.output_frames := aStream.Size;
    // load values from aStream into data
    aStream.Position := 0;
    p := Pointer(data^.data_in);
    for i := 0 to aStream.Size - 1 do
    begin
      aStream.Read(b, 1); // read a sample
      // scale 0..255 to -1.0..1.0
      sample := (b / 128.0) - 1.0;
      if sample < -1.0 then
        sample := -1.0
      else if sample > 1.0 then
        sample := 1.0;
      PDouble(p)^ := sample;
      inc(p, SizeOf(Double));
    end;
    aStream.Clear;
    src_simple(data, converter, 1);
    // now read data from data^.data_out
    p := Pointer(data^.data_out);
    for i := 0 to data^.output_frames_gen - 1 do
    begin
      sample := PDouble(p)^;
      b := Round((sample + 1.0) * 128);
      aStream.Write(b, 1);
      inc(p, SizeOf(Double));
    end;
  finally
    FreeMem(data);
  end;
end;

function ImaSamplesIn(dataLen, chans, blockAlign, samplesPerBlock : Word) : Word;
var
  m : Word;
begin
  if samplesPerBlock <> 0 then begin
    Result := (dataLen div blockAlign) * samplesPerBlock;
    m := (dataLen mod blockAlign);
  end
  else begin
    Result := 0;
    m := blockAlign;
  end;
  if m >= (4*chans) then begin
    dec(m, 4*chans);       // number of bytes beyond block-header
    m := m div (4*chans);  // number of 4-byte blocks/channel beyond header
    m := 8*m + 1;          // samples/chan beyond header + 1 in header
    if (samplesPerBlock <> 0) and (m > samplesPerBlock) then
      m := samplesPerBlock;
    inc(Result, m);
  end;
  //*wSamplesPerBlock = ((wBlockAlign - 4*wChannels)/(4*wChannels))*8 + 1;*/
end;

function AdpcmBytesPerBlock(chans, samplesPerBlock : Word) : Word;
begin
  Result := 7*chans;
  if samplesPerBlock > 2 then
    inc(Result, ((samplesPerBlock-2)*chans + 1) div 2);
end;

function ImaBytesPerBlock(chans, samplesPerBlock : Word) : Word;
begin
  Result := ((samplesPerBlock + 14) div 8) * 4 * chans;
end;

type
  adpcm_state = record
    valprev : SmallInt;	// Previous output value
    index : ShortInt;		// Index into stepsize table
  end;
  padpcm_state = ^adpcm_state;

const
  indexTable : array[0..15] of integer = (
    -1, -1, -1, -1, 2, 4, 6, 8,
    -1, -1, -1, -1, 2, 4, 6, 8
  );
  stepsizeTable : array[0..88] of integer = (
    7, 8, 9, 10, 11, 12, 13, 14, 16, 17,
    19, 21, 23, 25, 28, 31, 34, 37, 41, 45,
    50, 55, 60, 66, 73, 80, 88, 97, 107, 118,
    130, 143, 157, 173, 190, 209, 230, 253, 279, 307,
    337, 371, 408, 449, 494, 544, 598, 658, 724, 796,
    876, 963, 1060, 1166, 1282, 1411, 1552, 1707, 1878, 2066,
    2272, 2499, 2749, 3024, 3327, 3660, 4026, 4428, 4871, 5358,
    5894, 6484, 7132, 7845, 8630, 9493, 10442, 11487, 12635, 13899,
    15289, 16818, 18500, 20350, 22385, 24623, 27086, 29794, 32767
  );

procedure ImaAdpcmCoder(indata, outdata : PByte; len : LongInt; state : padpcm_state);
var
  inp, outp : PByte;
  val, sign, delta, diff, step : integer;
  valpred, vpdiff, index, outputbuffer : integer;
  bufferstep : boolean;
begin
  outputbuffer := 0;
  outp := outdata;
  inp  := indata;
  valpred := state^.valprev;
  index   := state^.index;
  step    := stepsizeTable[index];
  bufferstep := True;
  while (len > 0) do begin
    val := Integer(inp^);
    inc(inp);
	  // Step 1 - compute difference with previous value
    diff := val - valpred;
    if diff < 0 then
      sign := 8
    else
      sign := 0;
    if sign <> 0 then
      diff := -diff;

    (* Step 2 - Divide and clamp
     Note:
     This code *approximately* computes:
        delta = diff*4/step;
        vpdiff = (delta+0.5)*step/4;
     but in shift step bits are dropped. The net result of this is
     that even if you have fast mul/div hardware you cannot put it to
     good use since the fixup would be too expensive.
    *)
    delta := 0;
    vpdiff := (step shr 3);

    if diff >= step then begin
      delta := 4;
      dec(diff, step);
      inc(vpdiff, step);
    end;
    step := step shr 1;
    if diff >= step then begin
      delta := delta or 2;
      dec(diff, step);
      inc(vpdiff, step);
    end;
    step := step shr 1;
    if diff >= step then begin
      delta := delta or 1;
      inc(vpdiff, step);
    end;

    // Step 3 - Update previous value
    if sign <> 0 then
      dec(valpred, vpdiff)
    else
      inc(valpred, vpdiff);

    // Step 4 - Clamp previous value to 16 bits
    if valpred > 32767 then
      valpred := 32767
    else if valpred < -32768 then
      valpred := -32768;

    // Step 5 - Assemble value, update index and step values
    delta := delta or sign;

    inc(index, indexTable[delta]);
    if index < 0 then index := 0;
    if index > 88 then index := 88;
    step := stepsizeTable[index];

    // Step 6 - Output value
    if bufferstep then begin
      outputbuffer := (delta shl 4) and $f0;
    end
    else begin
      outp^ := (delta and $0f) or outputbuffer;
      inc(outp);
    end;
    bufferstep := not bufferstep;
    dec(len);
  end;
  // Output last step, if needed
  if not bufferstep then begin
    outp^ := Byte(outputbuffer);
    inc(outp);
  end;

  state^.valprev := valpred;
  state^.index := index;
end;

procedure ImaAdpcmDecoder(indata, outdata : PByte; len : LongInt; state : padpcm_state);
var
  inp, outp : PByte;
  sign, delta, step : integer;
  valpred, vpdiff, index, inputbuffer : integer;
  bufferstep : boolean;
begin
  inputbuffer := 0;
  outp := outdata;
  inp  := indata;
  valpred := state^.valprev;
  index := state^.index;
  step := stepsizeTable[index];

  bufferstep := False;

  while (len > 0) do begin

    //* Step 1 - get the delta value */
    if bufferstep then begin
      delta := inputbuffer and $f;
    end
    else begin
      inputbuffer := Integer(inp^);
      inc(inp);
      delta := (inputbuffer shr 4) and $f;
    end;
    bufferstep := not bufferstep;

    // Step 2 - Find new index value (for later)
    inc(index, indexTable[delta]);
    if index < 0 then index := 0;
    if index > 88 then index := 88;

    // Step 3 - Separate sign and magnitude
    sign := delta and 8;
    delta := delta and 7;

    (* Step 4 - Compute difference and new predicted value

     Computes 'vpdiff = (delta+0.5)*step/4', but see comment
     in adpcm_coder.
    *)
    vpdiff := step shr 3;
    if (delta and 4) <> 0 then inc(vpdiff, step);
    if (delta and 2) <> 0 then inc(vpdiff, step shr 1);
    if (delta and 1) <> 0 then inc(vpdiff, step shr 2);

    if sign <> 0 then
      dec(valpred, vpdiff)
    else
      inc(valpred, vpdiff);

    // Step 5 - clamp output value
    if valpred > 32767  then
      valpred := 32767
    else if valpred < -32768 then
      valpred := -32768;

    // Step 6 - Update step value
    step := stepsizeTable[index];

    // Step 7 - Output value
    outp^ := Byte(valpred);
    inc(outp);
    dec(len);
  end;
  state^.valprev := valpred;
  state^.index := index;
end;

procedure ImaAdpcmCompress(ms : TMemoryStream);
var
  inp, outp : PByte;
  state : adpcm_state;
  len : integer;
begin
  len := ms.Size;
  state.valprev := 0;
  state.index   := 0;
  GetMem(inp, len);
  try
    GetMem(outp, len);
    try
      FillChar(outp^, len, 0);
      ms.Position := 0;
      ms.Read(inp^, len);
      ImaAdpcmCoder(inp, outp, len, @state);
      ms.Clear;
      ms.Write(outp^, len div 2);
    finally
      FreeMem(outp);
    end;
  finally
    FreeMem(inp);
  end;
end;

procedure ImaAdpcmDecompress(ms : TMemoryStream);
var
  inp, outp : PByte;
  state : adpcm_state;
  len : integer;
begin
  len := ms.Size;
  state.valprev := 0;
  state.index   := 0;
  GetMem(inp, len);
  try
    ms.Position := 0;
    ms.Read(inp^, len);
    len := len*2;
    GetMem(outp, len);
    try
      FillChar(outp^, len, 0);
      ImaAdpcmDecoder(inp, outp, len, @state);
      ms.Clear;
      ms.Write(outp^, len);
    finally
      FreeMem(outp);
    end;
  finally
    FreeMem(inp);
  end;
end;

procedure ConvertRSO2Wave(filename, outdir : string; msgs : TStrings);
var
  msIn, msOut, msData : TMemoryStream;
  hdrRiff : RIFFHeader;
  hdrWaveData : WaveDataHeader;
  W, size, srate : Word;
  SubChunk1Size, SubChunk2Size : Word;
  bUseComp : boolean;
begin
  // convert files to WAV format from RSO format
  msIn := TMemoryStream.Create;
  try
    msOut := TMemoryStream.Create;
    try
      // reset output stream
      msOut.Clear;
      msOut.Position := 0;
      // reset input stream and load it
      msIn.Clear;
      msIn.LoadFromFile(filename);
      msIn.Position := 0;
      // read RSO header
      ReadWord(msIn, W, False); // format $0100
      bUseComp := (W = $0101);
      ReadWord(msIn, size, False);
      ReadWord(msIn, srate, False);
      ReadWord(msIn, W, False); // play mode
      // begin writing the wave file
      hdrRiff.ChunkID := 'RIFF';
      hdrRiff.ChunkFormat := 'WAVE';
      SubChunk1Size := 16;
      SubChunk2Size := msIn.Size - 8;
      hdrRiff.ChunkSize := 4 + (8 + SubChunk1Size) + (8 + SubChunk2Size);
      // write values to stream
      msOut.Write(hdrRiff.ChunkID, 4);
      WriteCardinal(msOut, hdrRiff.ChunkSize);
      msOut.Write(hdrRiff.ChunkFormat, 4);
      // write values to stream
      msOut.Write('fmt ', 4);
      WriteCardinal(msOut, SubChunk1Size);
      msData := TMemoryStream.Create;
      try
        msData.CopyFrom(msIn, msIn.Size - 8);
        if bUseComp then begin
          // decompress msData
          ImaAdpcmDecompress(msData);
        end;
        WriteWord(msOut, WAVE_FORMAT_PCM);
        WriteWord(msOut, 1); // num channels
        WriteCardinal(msOut, srate); // sample rate
        WriteCardinal(msOut, srate); // byte rate
        WriteWord(msOut, 1); // block align
        WriteWord(msOut, 8); // bits per sample
        with hdrWaveData do
        begin
          SubChunkID := 'data';
          SubChunkSize := msData.Size;
          // write values to stream
          msOut.Write(SubChunkID, 4);
          WriteCardinal(msOut, SubChunkSize);
        end;
        msOut.CopyFrom(msData, 0);
      finally
        msData.Free;
      end;
      // save the output
      filename := IncludeTrailingPathDelimiter(outdir) + ChangeFileExt(ExtractFileName(filename), '.wav');
      msOut.SaveToFile(filename);
      msgs.Add(Format(sSuccess, [filename]));
    finally
      msOut.Free;
    end;
  finally
    msIn.Free;
  end;
end;

procedure ConvertWave2RSO(filename, outdir : string; sample_rate : Cardinal;
  resample_method : integer; bUseComp : boolean; ext : string; msgs : TStrings);
var
  msIn, msOut, msData : TMemoryStream;
  hdrRiff : RIFFHeader;
  hdrWaveFmt : WaveFmtHeader;
  hdrWaveData : WaveDataHeader;
  W, nc, bytesPerSample : Word;
  B : Byte;
  waveData : array of Double;
  sampleFrame : array of Byte;
  pctChannel : double;
  i, size, frameLen : integer;
  j, padBits, tmp, hdrLen : integer;
  sample : Double;
  wExtSize, wSamplesPerBlock, bytesPerBlock, nCoefs : Word;
  iCoefs : array of SmallInt;
begin
  // convert files to RSO format
  msIn := TMemoryStream.Create;
  try
    msOut := TMemoryStream.Create;
    try
      // reset output stream
      msOut.Clear;
      msOut.Position := 0;
      // reset input stream and load it
      msIn.Clear;
      msIn.LoadFromFile(filename);
      msIn.Position := 0;
      // begin processing the wave file
      msIn.Read(hdrRiff.ChunkID, 4);
      ReadCardinal(msIn, hdrRiff.ChunkSize);
      msIn.Read(hdrRiff.ChunkFormat, 4);
      if (hdrRiff.ChunkID = 'RIFF') and (hdrRiff.ChunkFormat = 'WAVE') then
      begin
        with hdrWaveFmt do
        begin
          msIn.Read(SubChunkID, 4);
          ReadCardinal(msIn, SubChunkSize);
          ReadWord(msIn, AudioFormat);
          ReadWord(msIn, NumChannels);
          ReadCardinal(msIn, SampleRate);
          ReadCardinal(msIn, ByteRate);
          ReadWord(msIn, BlockAlign);
          ReadWord(msIn, BitsPerSample);
        end;
        if (UpperCase(hdrWaveFmt.SubChunkID) = 'FMT ') and
           (hdrWaveFmt.AudioFormat in [WAVE_FORMAT_PCM,
                                       WAVE_FORMAT_ADPCM,
                                       WAVE_FORMAT_IMA_ADPCM]) then
        begin
          hdrLen := hdrWaveFmt.SubChunkSize - 16;
          wExtSize := 0;
          if hdrWaveFmt.AudioFormat <> WAVE_FORMAT_PCM then begin
            if hdrLen < 2 then begin
              msgs.Add('wave header missing FmtExt chunk');
              Exit;
            end;
            ReadWord(msIn, wExtSize);
            dec(hdrLen, 2);
          end;
          if wExtSize > hdrLen then begin
            msgs.Add('wave header error: wExtSize inconsistent with wFmtLen');
            Exit;
          end;
          case hdrWaveFmt.AudioFormat of
            WAVE_FORMAT_IMA_ADPCM : begin
              if wExtSize < 2 then begin
                msgs.Add('IMA ADPCM format expects wExtSize >= 2');
                Exit;
              end;
              if hdrWaveFmt.BitsPerSample <> 4 then begin
                msgs.Add('Can only handle 4-bit IMA ADPCM in wav files');
                Exit;
              end;
              ReadWord(msIn, wSamplesPerBlock);
              bytesPerBlock := ImaBytesPerBlock(hdrWaveFmt.NumChannels, wSamplesPerBlock);
              if (bytesPerBlock > hdrWaveFmt.BlockAlign) or
                 ((wSamplesPerBlock mod 8) <> 1) then begin
                msgs.Add(Format('IMA ADPCM: samplesPerBlock (%d) incompatible with blockAlign (%d)', [wSamplesPerBlock, hdrWaveFmt.BlockAlign]));
                Exit;
              end;
              // allocate a packet
//              wav->packet = (unsigned char * )xmalloc(wav->blockAlign);
              dec(hdrLen, 2);
              // allocate room for samples
//              wav->samples = (short * )xmalloc(wChannels*wav->samplesPerBlock*sizeof(short));
              bytesPerSample := 2; // after de-compression
            end;
            WAVE_FORMAT_ADPCM : begin
              if wExtSize < 4 then begin
                msgs.Add('Microsoft ADPCM format expects wExtSize >= 4');
                Exit;
              end;
              if hdrWaveFmt.BitsPerSample <> 4 then begin
                msgs.Add('Can only handle 4-bit MS ADPCM in wav files');
                Exit;
              end;
              ReadWord(msIn, wSamplesPerBlock);
              bytesPerBlock := AdpcmBytesPerBlock(hdrWaveFmt.NumChannels, wSamplesPerBlock);
              if bytesPerBlock > hdrWaveFmt.BlockAlign then begin
                msgs.Add(Format('MS ADPCM: samplesPerBlock (%d) incompatible with blockAlign (%d)', [wSamplesPerBlock, hdrWaveFmt.BlockAlign]));
                Exit;
              end;
              ReadWord(msIn, nCoefs);
              if (nCoefs < 7) or (nCoefs > $100) then begin
                msgs.Add(Format('ADPCM file nCoefs (%d) makes no sense', [nCoefs]));
                Exit;
              end;
              // allocate a packet
//              wav->packet = (unsigned char * )xmalloc(wav->blockAlign);
              dec(hdrLen, 4);
              if wExtSize < (4 + 4*nCoefs) then begin
                msgs.Add(Format('wave header error: wExtSize(%d) too small for nCoefs(%d)', [wExtSize, nCoefs]));
                Exit;
              end;
              // allocate room for samples
//              wav->samples = (short * )xmalloc(wChannels*wav->samplesPerBlock*sizeof(short));
              SetLength(iCoefs, nCoefs*2);
              i := 0;
              while (hdrLen >= 2) and (i < 2*nCoefs) do begin
                ReadWord(msIn, W);
                iCoefs[i] := SmallInt(W);
                dec(hdrLen, 2);
                inc(i);
              end;
              bytesPerSample := 2; // after de-compression
            end;
          else
            bytesPerSample := (hdrWaveFmt.BitsPerSample + 7) div 8;
          end;
          // skip extra bytes
          msIn.Seek(hdrLen, soFromCurrent);
          with hdrWaveData do
          begin
            msIn.Read(SubChunkID, 4);
            ReadCardinal(msIn, SubChunkSize);
          end;
          // it is possible that instead of a DATA chunk we have some other chunk type
          // in such a situation just keep reading chunks until we find a DATA chunk
          // or until we reach end of file
          while (UpperCase(hdrWaveData.SubChunkID) <> 'DATA') and
                (msIn.Position < msIn.Size) do
          begin
            // skip to the next chunk
            msIn.Seek(hdrWaveData.SubChunkSize, soFromCurrent);
            if msIn.Position < msIn.Size then
              with hdrWaveData do
              begin
                msIn.Read(SubChunkID, 4);
                ReadCardinal(msIn, SubChunkSize);
              end;
          end;
          if UpperCase(hdrWaveData.SubChunkID) = 'DATA' then
          begin
            // output
            msData := TMemoryStream.Create;
            try
              if (hdrWaveFmt.NumChannels > 1) or
                 (hdrWaveFmt.BitsPerSample > 8) or
                 (hdrWaveFmt.AudioFormat <> WAVE_FORMAT_PCM) or
                 ((hdrWaveFmt.SampleRate <> sample_rate) and
                  (resample_method <> SRC_NONE)) then
              begin
                // manipulate data
                case hdrWaveFmt.AudioFormat of
                  WAVE_FORMAT_ADPCM : begin
                    // read and decompress
                    msgs.Add('Support for reading MS ADPCM wave files is not yet implemented');
                    Exit;
                  end;
                  WAVE_FORMAT_IMA_ADPCM : begin
                    // read and decompress
                    msgs.Add('Support for reading IMA ADPCM wave files is not yet implemented');
                    Exit;
                  end;
                  WAVE_FORMAT_PCM : begin
                    // we need buffers for each channel
                    nc := hdrWaveFmt.NumChannels;
                    SetLength(waveData, nc);
                    pctChannel := 1.0 / nc;
                    size := (hdrWaveData.SubChunkSize div nc) div bytesPerSample;
                    // setup our frame buffer
                    frameLen := hdrWaveFmt.BlockAlign;
                    SetLength(sampleFrame, frameLen);
                    padBits := (bytesPerSample * 8) - hdrWaveFmt.BitsPerSample;
                    // now read samples from input stream
                    for i := 0 to size - 1 do
                    begin
                      if (hdrWaveFmt.NumChannels > 1) or (hdrWaveFmt.BitsPerSample > 8) then
                      begin
                        for j := 0 to frameLen - 1 do
                          msIn.Read(sampleFrame[j], 1);
                        // we have read a sample frame (containing NumChannels samples)
                        for j := 0 to nc - 1 do
                        begin
                          case bytesPerSample of
                            1 : begin
                              tmp := BytesToCardinal(sampleFrame[0+j*nc]);
                              tmp := (tmp xor $80) shl 24;
                            end;
                            2 : begin
                              tmp := BytesToCardinal(sampleFrame[0+j*nc],
                                                     sampleFrame[1+j*nc]);
                              tmp := tmp shl 16;
                            end;
                            3 : begin
                              tmp := BytesToCardinal(sampleFrame[0+j*nc],
                                                     sampleFrame[1+j*nc],
                                                     sampleFrame[2+j*nc]);
                              tmp := tmp shl 8;
                            end;
                            4 : begin
                              tmp := BytesToCardinal(sampleFrame[0+j*nc],
                                                     sampleFrame[1+j*nc],
                                                     sampleFrame[2+j*nc],
                                                     sampleFrame[3+j*nc]);
                            end;
                          else
                            tmp := 0;
                          end;
                          waveData[j] := (tmp shr padBits);
                        end;
                        sample := 0;
                        for j := 0 to nc - 1 do
                          sample := sample + (waveData[j] * pctChannel);
                        B := ((Trunc(sample) shr 24) xor $80);
                      end
                      else
                        msIn.Read(B, 1);
                      msData.Write(B, 1);
                    end;
                  end;
                else
                  // unsupported wave file format
                  msgs.Add('Unsupported wave file format');
                  Exit;
                end;
                // perform sample rate conversion if needed
                if (hdrWaveFmt.SampleRate <> sample_rate) and
                   (resample_method <> SRC_NONE) then
                begin
                  ConvertSampleRate(msData,
                                    sample_rate / hdrWaveFmt.SampleRate,
                                    resample_method);
                  hdrWaveFmt.SampleRate := sample_rate;
                end;
              end
              else
              begin
                // copy to data stream
                msData.CopyFrom(msIn, hdrWaveData.SubChunkSize);
              end;
              // msData contains samples in PCM format
              if bUseComp then begin
                // compress data into IMA ADPCM format
                ImaAdpcmCompress(msData);
              end;
              if msData.Size <= MAXWORD then
              begin
                // write RSO format header (0x0100) (Big Endian)
                if bUseComp then
                  W := $0101
                else
                  W := $0100;
                WriteWord(msOut, W, False);
                // write chunk size (bytes of data) (big endian)
                W := Word(msData.Size);
                WriteWord(msOut, W, False);
                // write the sample rate (big endian)
                W := Word(hdrWaveFmt.SampleRate);
                WriteWord(msOut, W, False);
                // write a play mode word (big endian)
                W := 0; // playmode: 0 == do not loop
                WriteWord(msOut, W, False);
                // copy over the wave data
                msOut.CopyFrom(msData, 0);
                // save the output
                filename := IncludeTrailingPathDelimiter(outdir) + ChangeFileExt(ExtractFileName(filename), ext);
                msOut.SaveToFile(filename);
                msgs.Add(Format(sSuccess, [filename]));
              end
              else
                msgs.Add(Format(sErr64kLimit, [filename]));
            finally
              msData.Free;
            end;
          end
          else
            msgs.Add(Format(sErrRiffWaveFmt, [filename]));
        end
        else
        begin
          if not (hdrWaveFmt.AudioFormat in
                  [WAVE_FORMAT_PCM,
                   WAVE_FORMAT_ADPCM,
                   WAVE_FORMAT_IMA_ADPCM]) then
            msgs.Add(Format(sErrPCMFmt, [filename]))
          else
            msgs.Add(Format(sErrRiffWaveFmt, [filename]));
        end;
      end
      else
        msgs.Add(Format(sErrRiffWaveFmt, [filename]));
    finally
      msOut.Free;
    end;
  finally
    msIn.Free;
  end;
end;

end.