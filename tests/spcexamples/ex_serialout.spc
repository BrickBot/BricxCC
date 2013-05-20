task main()
{
  while(true)
  {
    if (SerialOutCount > 200)
      continue;
    SerialOutByte = 'a';
    SerialOutByte = 'b';
    SerialOutByte = 'c';
    SerialOutByte = 'd';
    SerialOutByte = 'e';
    printf("%d\n", SerialOutCount);
    Wait(MS_500);
  }
}
