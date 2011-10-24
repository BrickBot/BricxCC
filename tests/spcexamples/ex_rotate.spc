task main()
{
  int x = ADChannel0;
  printf("x = %d\n", x);
  repeat(4)
    RotateLeft(x); // rotate left through carry by 1 bit (4 times)
  printf("x = %d\n", x);
  repeat(2)
    RotateRight(x); // rotate right through carry by 1 bit (2 times)
  printf("x = %d\n", x);
}
