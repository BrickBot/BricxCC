task main()
{
  Timer0 = MIN_1;
  open("w");
  if (stat() == LOG_STATUS_OPEN)
  {
    write(Timer0);
  }
  close();
}
