task main()
{
  open("w");
  if (stat() == LOG_STATUS_OPEN)
  {
    write(Timer0);
  }
  close();
}
