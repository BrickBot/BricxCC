task main()
{
  int x = 1000 - CurrentTick();
  char val = sign(x); // return -1, 0, or 1
  printf("sign(x) = %d\n", val);
}

