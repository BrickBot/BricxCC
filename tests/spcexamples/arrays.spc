struct Car {
  int Make;
  int Model;
  bool TwoDoor;
};

struct Person {
  int Age;
  bool Male;
  char Initial;
  int Kids;
  Car Vehicle;
  int Weight;
  int Data[4];
};

task main()
{
  int x;
/*
  int data[5][5], buf[5], foo[2][2][2], bar[2][3][2][3];
  int *p;
  
  x = buf[3]; // good code

  x = data[4][3]; // bad code

  x = foo[2][3][4]; // bad code

  x++;
  
  Person please[4], couples[3][3]; // good allocation code
*/
  Person jch;
  
  jch++;
  jch.Age = 23;
  jch.Kids = 4;
  jch.Kids = jch.Kids + 2;
  jch.Initial = 'C';
  jch.Male = true;
  jch.Kids = x++;
  jch.Kids++;
  jch.Kids *= 2;
  jch.Kids--;
  jch.Vehicle.Make = 10;
  jch.Vehicle.Model = 20;
  jch.Vehicle.TwoDoor = false;
  jch.Weight = 270;
//  ++jch.Kids; // bad code
//  please[0].Age = 45; // bad code
}
