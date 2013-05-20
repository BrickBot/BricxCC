task main()
{
  while(true)
  {
    if (CurrentTick() > SEC_30)
      StopProcesses(); // stop any tasks except for this one.
  }
}
