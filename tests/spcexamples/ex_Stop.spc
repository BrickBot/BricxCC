task main()
{
  int x;
  Timer0 = SEC_10;
  while (true)
  {
    x = Timer0;
    Stop(x == 24); // stop the program if x==24
  }
}

