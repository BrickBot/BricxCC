task main()
{
  while (true)
  {
    if (CurrentTick() > SEC_30)
      Run(SLOT2); // start running the program in slot 2
  }
}