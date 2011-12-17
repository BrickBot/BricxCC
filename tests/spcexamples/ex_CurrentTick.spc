task main()
{
  while (true) {
    Wait(MS_100);
    int x = CurrentTick();
    printf("x = %d\n", x);
  }
}

