task main()
{
  int x = Timer3;
  int y;
  y = push(x);
  x = x*x;
  printf("x = %d\n", x);
  x = pop();
  printf("x = %d\n", x);
}
