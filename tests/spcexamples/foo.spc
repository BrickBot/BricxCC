
#pragma autostart

int x = 10;

task main()
{
  x++;
  while(true)
  {
    printf("%x\n", SystemClock);
//    asm {TRND SystemClock}
    Wait(5000);
    
  }
}
