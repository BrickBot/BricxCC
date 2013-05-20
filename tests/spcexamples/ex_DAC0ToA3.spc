task main()
{
  int A3;
  int i, c;
  
  // Set up Analog 0 output to output a sine wave at 1 Hz
  DAC0Mode = DAC_MODE_SINEWAVE;
  DAC0Frequency = (1);
  DAC0Voltage = 1023;
  
  // Sample Analog input A3 every 1/10 second
  // and output value
  while(true)
  {
    A3 = ADChannel3;
    printf("Time: %d  ", SystemClock);
    printf("A3: %d ", A3);
    
    // Display an '*' sine wave on terminal
    c = A3 / 20;
    for (i=0;i<c;i++) {
      printf(" ");
    }
    printf("*\n");

    Wait(MS_10);
  }
}
