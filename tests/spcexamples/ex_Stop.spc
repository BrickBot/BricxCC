task main()
{
  int x;
  Timer0 = 10000;
  while (true)
  {
    x = Timer0;
    Stop(x == 24); // stop the program if x==24
  }
}

