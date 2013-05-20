unit uWavCommon;

interface

type
  RIFFHeader = record
    ChunkID : array[0..3] of char;
    ChunkSize : Cardinal;
    ChunkFormat : array[0..3] of char;
  end;
  WaveFmtHeader = record
    SubChunkID : array[0..3] of Char;
    SubChunkSize : Cardinal;
    AudioFormat : Word;
    NumChannels : Word;
    SampleRate : Cardinal;
    ByteRate : Cardinal;
    BlockAlign : Word;
    BitsPerSample : Word;
  end;
  WaveDataHeader = record
    SubChunkID : array[0..3] of Char;
    SubChunkSize : Cardinal;
  end;

const
  MAXWORD  = 65535;

const
  WAVE_FORMAT_UNKNOWN           = $0000;
  WAVE_FORMAT_PCM               = $0001;
  WAVE_FORMAT_ADPCM             = $0002;
  WAVE_FORMAT_IEEE_FLOAT        = $0003;
  WAVE_FORMAT_ALAW              = $0006;
  WAVE_FORMAT_MULAW             = $0007;
  WAVE_FORMAT_OKI_ADPCM         = $0010;
  WAVE_FORMAT_IMA_ADPCM         = $0011;
  WAVE_FORMAT_DIGISTD           = $0015;
  WAVE_FORMAT_DIGIFIX           = $0016;
  WAVE_FORMAT_DOLBY_AC2         = $0030;
  WAVE_FORMAT_GSM610            = $0031;
  WAVE_FORMAT_ROCKWELL_ADPCM    = $003b;
  WAVE_FORMAT_ROCKWELL_DIGITALK = $003c;
  WAVE_FORMAT_G721_ADPCM        = $0040;
  WAVE_FORMAT_G728_CELP         = $0041;
  WAVE_FORMAT_MPEG              = $0050;
  WAVE_FORMAT_MPEGLAYER3        = $0055;
  WAVE_FORMAT_G726_ADPCM        = $0064;
  WAVE_FORMAT_G722_ADPCM        = $0065;
  WAVE_FORMAT_EXTENSIBLE        = $fffe;

implementation

end.