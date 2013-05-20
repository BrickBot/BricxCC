#pragma autostart

task main()
{
  int DigValue = 1;
  int DigCount = 8;
  int DigLen   = 7;
  int DigDir   = 0;
  DigitalControl = 0xFF;

  while(true)
  {
    DigitalOut = DigValue; // output to LEDS
    Timer0 = 10000/(ADChannel0+25);
    while(Timer0 > 0); // wait for counter to reach 0
    DigCount--;
    if (DigCount != 0)
    {
      // shifting
      if (DigDir != 0) {
        DigValue >>= 1;
      } else
        DigValue <<= 1;
      continue;
    }
    DigCount = DigLen;
    DigDir ^= 1;
    if (DigDir != 0)
    {
      // shifting
      DigValue >>= 1;
      continue;
    }
    
    switch(ADChannel1/128)
    {
      case 0:
        DigLen   = 7;
        DigCount = 7;
        DigValue = 0x02;
        break;
      case 1:
        DigLen   = 6;
        DigCount = 6;
        DigValue = 0x06;
        break;
      case 2:
        DigLen   = 5;
        DigCount = 5;
        DigValue = 0x0E;
        break;
      case 3:
        DigLen   = 4;
        DigCount = 4;
        DigValue = 0x1E;
        break;
      case 4:
        DigLen   = 3;
        DigCount = 3;
        DigValue = 0x3E;
        break;
      case 5:
        DigLen   = 2;
        DigCount = 2;
        DigValue = 0x7E;
        break;
      default:
        DigLen   = 1;
        DigCount = 1;
        DigValue = 0xFE;
        break;
    }
    
  }
}
