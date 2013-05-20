// NXT Communications is possible with memory locations 0x20-0x3F which
// correspond to I2C addresses 0x80 to 0xff
#define NXTCOMM SharedMem01

void PlayNoteStacato(int note, int dur)
{
  if (NXTCOMM) {
    DAC1Frequency = note;
    DAC1Voltage = 1023;
    Wait(7*dur/8);
    DAC1Voltage = 0;
    Wait(dur/8);
  } else {
    DAC1Voltage = 0;
  }
}

void TwinkleA()
{
    PlayNoteStacato(TONE_C4, NOTE_QUARTER);
    PlayNoteStacato(TONE_C4, NOTE_QUARTER);
    PlayNoteStacato(TONE_G4, NOTE_QUARTER);
    PlayNoteStacato(TONE_G4, NOTE_QUARTER);
    PlayNoteStacato(TONE_A4, NOTE_QUARTER);
    PlayNoteStacato(TONE_A4, NOTE_QUARTER);
    PlayNoteStacato(TONE_G4, NOTE_HALF);

    PlayNoteStacato(TONE_F4, NOTE_QUARTER);
    PlayNoteStacato(TONE_F4, NOTE_QUARTER);
    PlayNoteStacato(TONE_E4, NOTE_QUARTER);
    PlayNoteStacato(TONE_E4, NOTE_QUARTER);
    PlayNoteStacato(TONE_D4, NOTE_QUARTER);
    PlayNoteStacato(TONE_D4, NOTE_QUARTER);
    PlayNoteStacato(TONE_C4, NOTE_HALF);
}

void TwinkleB()
{
    PlayNoteStacato(TONE_G4, NOTE_QUARTER);
    PlayNoteStacato(TONE_G4, NOTE_QUARTER);
    PlayNoteStacato(TONE_F4, NOTE_QUARTER);
    PlayNoteStacato(TONE_F4, NOTE_QUARTER);
    PlayNoteStacato(TONE_E4, NOTE_QUARTER);
    PlayNoteStacato(TONE_E4, NOTE_QUARTER);
    PlayNoteStacato(TONE_D4, NOTE_HALF);
}

task main()
{
  // Set up Analog 1 output to output a square wave
  DAC1Voltage = 0;
  DAC1Mode = DAC_MODE_SQUAREWAVE;
  DAC1Frequency = 0;

  // Play Twinkle if NXTCOMM != 0
  while(true) {
    while(NXTCOMM != 0)
    {
      TwinkleA();    if (NXTCOMM == 0) break;
      TwinkleB();    if (NXTCOMM == 0) break;
      TwinkleB();    if (NXTCOMM == 0) break;
      TwinkleA();    if (NXTCOMM == 0) break;
      Wait(SEC_1);
    }
  }
}
