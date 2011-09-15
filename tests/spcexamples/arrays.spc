task main()
{
  int data[5][5], buf[5], foo[2][2][2], bar[2][3][2][3];
  int x;
  int *p;
  
  x = buf[3]; // good code
  x = data[4][3]; // bad code
  x = foo[2][3][4]; // bad code
  x++;
}
