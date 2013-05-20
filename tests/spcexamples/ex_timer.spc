#define START_MS MIN_1

task main()
{
  Timer0 = START_MS;
  Timer1 = START_MS;
  Timer2 = START_MS;
  Timer3 = START_MS;
  while(true)
  {
    printf("%d\n", Timer0);
    printf("%d\n", Timer1);
    printf("%d\n", Timer2);
    printf("%d\n", Timer3);
    Wait(SEC_2);
    if (Timer2 < SEC_15)
      Timer2 = START_MS;
    if (Timer3 < SEC_30)
      Timer3 = START_MS;
  }
}
