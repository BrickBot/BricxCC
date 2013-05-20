#pragma autostart

task t1()
{
  while(true)
  {
    puts("1 ");
    Wait(MS_500);
  }
}

task t2()
{
  while(true)
  {
    puts("2 ");
    Wait(MS_500);
  }
}

task main()
{
  start t1;
  start t2;
}
