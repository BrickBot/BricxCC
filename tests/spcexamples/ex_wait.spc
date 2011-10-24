task main()
{
  printf("tick = %d\n", SystemClock);
  Wait(SEC_5); // wait 5 seconds
  printf("tick = %d\n", SystemClock);
}
