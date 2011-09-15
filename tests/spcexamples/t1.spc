#include "spmem.h"

#pragma autostart

task t1()
{
  while(true)
  {
    puts("1 ");
    Wait(500);
  }
}

task t2()
{
  while(true)
  {
    puts("2 ");
    Wait(500);
  }
}

task main()
{
  start t1;
  start t2;
}
