void Bar1(int xx)
{
  xx++;
  xx += 34;
}

int Bar2(int & yy)
{
  yy++;
  yy += 34;
  return yy;
}

int Foo(int & x)
{
  Bar1(x);
  x++;
  x += 5;
  x = x*3;
//	MOV __Bar2_7qG2_yy_7qG2_000, __Foo_7qG2_x_7qG2_000 (good code)
  x += Bar2(x);
  return x;
}

task main()
{
  int y=5;
  int z;
  z = Foo(y);
}
