task main()
{
  int i;
  int myVector[10];

  // take 10 samples spaced every 1 mS
  for (i=0; i<10; i++)
  {
    myVector[i] = ADChannel0;
    Wait(MS_1);
  }

  // print with comma separators
  for (i=0; i<10; i++)
  {
    int val = myVector[i]; // bug!!!!!
    printf("%d", val);
    printf(",");
  }
}

