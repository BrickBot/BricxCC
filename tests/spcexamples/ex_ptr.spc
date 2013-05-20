task main()
{
  int data[10];
  for (int i=0; i<10; i++)
    data[i] = i;

  int * ptr = &data;
  for (int i=0; i<10; i++)
  {
    printf("data[%d] = %d\n", i, *ptr);
    ptr++;
  }
}
