task main()
{
  printf("tick = %d\n", SystemClock);
  Yield();
  printf("tick = %d\n", SystemClock);
}
