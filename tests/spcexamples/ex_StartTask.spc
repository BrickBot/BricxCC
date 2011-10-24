task foo()
{
  while(true) {
    Wait(SEC_5);
    puts("foo is running\n");
  }
}

task main()
{
  StartTask(foo); // start the foo task
  while(true)
  {
    Wait(SEC_3);
    puts("main is running\n");
  }
}

