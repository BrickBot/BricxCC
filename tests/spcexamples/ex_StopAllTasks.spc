task main()
{
  while(true)
  {
    if (CurrentTick() > 50000)
      StopAllTasks(); // stop the program
  }
}
