task main()
{
  int x = Timer0;
  int y;
  y = push(x);
  x = x*x;
  printf("x = %d\n", x);
  x = pop();
  printf("x = %d\n", x);
}
