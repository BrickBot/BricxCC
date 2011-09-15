
#pragma autostart

task main()
{
  while(true)
  {
    printf("%x\n", SystemClock);
//    asm {TRND SystemClock}
    Wait(5000);
    
  }
}
