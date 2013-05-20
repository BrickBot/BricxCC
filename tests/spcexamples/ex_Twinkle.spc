void PlayNoteStacato(int note, int dur)
{
  DAC1Frequency = note;
  DAC1Voltage = 1023;
  Wait(7*dur/8);
  DAC1Voltage = 0;
  Wait(dur/8);
}

void PlayNoteLagato(int note, int dur)
{
  DAC1Frequency = note;
  DAC1Voltage = 1023;
  Wait(dur);
  DAC1Voltage = 0;
}

void TwinkleA()
{
    PlayNoteStacato(TONE_C3, NOTE_QUARTER);
    PlayNoteStacato(TONE_C3, NOTE_QUARTER);
    PlayNoteStacato(TONE_G3, NOTE_QUARTER);
    PlayNoteStacato(TONE_G3, NOTE_QUARTER);
    PlayNoteStacato(TONE_A3, NOTE_QUARTER);
    PlayNoteStacato(TONE_A3, NOTE_QUARTER);
    PlayNoteStacato(TONE_G3, NOTE_HALF);

    PlayNoteStacato(TONE_F3, NOTE_QUARTER);
    PlayNoteStacato(TONE_F3, NOTE_QUARTER);
    PlayNoteStacato(TONE_E3, NOTE_QUARTER);
    PlayNoteStacato(TONE_E3, NOTE_QUARTER);
    PlayNoteStacato(TONE_D3, NOTE_QUARTER);
    PlayNoteStacato(TONE_D3, NOTE_QUARTER);
    PlayNoteStacato(TONE_C3, NOTE_HALF);
}

void TwinkleB()
{
    PlayNoteStacato(TONE_G3, NOTE_QUARTER);
    PlayNoteStacato(TONE_G3, NOTE_QUARTER);
    PlayNoteStacato(TONE_F3, NOTE_QUARTER);
    PlayNoteStacato(TONE_F3, NOTE_QUARTER);
    PlayNoteStacato(TONE_E3, NOTE_QUARTER);
    PlayNoteStacato(TONE_E3, NOTE_QUARTER);
    PlayNoteStacato(TONE_D3, NOTE_HALF);
}

task main()
{
  int A0;

  // Set up Analog 1 output to output a square wave
  DAC1Voltage = 0;
  DAC1Mode = DAC_MODE_SQUAREWAVE;
  DAC1Frequency = 0;

  // Sample Analog input A0 every 1/10 second
  // and output value
  while(true)
  {
    TwinkleA();
    TwinkleB();
    TwinkleB();
    TwinkleA();
    Wait(SEC_1);
  }
}
