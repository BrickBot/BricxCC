int foo[] = {1, 2, 3, 4, 5, 6};
int bar = 34;

int Foo(int x);

void Testing(int x, int y);

task main()
{
  int data[] = {0, 1, 2, 3, 4};
  long x;
  x = 80001;
  x++;
  int y=34*2+50-13/40%33;
  y = x+1-y;
  y--;
  x *= y;
  data[0] = x;
  int i=0;
  data[i] = y;
  data[i+1] = 2;
  data[i+2] = x*4;
  data[i+3] = foo[0]+bar;
  if (x > 50) {
    y++;
  }
  else {
    y--;
  }
  Testing(x, data[0]);
}

int Foo(int x)
{
  return x*x;
}

void Testing(int x, int y)
{
  int z = x+y-Foo(x);
  z--;
}

