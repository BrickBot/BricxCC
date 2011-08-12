#include "spmem.h"

#pragma autostart

task main()
{
  while(true)
  {
    printf("%d\n", SystemClock);
//    asm {TRND SystemClock}
    Wait(1000);
    
  }
}
