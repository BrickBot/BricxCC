#include "spmem.h"

int foo[] = {1, 2, 3, 4, 5, 6}; // good code
int bar = 34; // good code
int * pFoo; // good code
char ch = '\n';
/*
__initialize_global_data:
	MVI __signed_stack_001Testing, foo
	MVI (__signed_stack_001Testing), 1
	INC __signed_stack_001Testing
	MVI (__signed_stack_001Testing), 2
	INC __signed_stack_001Testing
	MVI (__signed_stack_001Testing), 3
	INC __signed_stack_001Testing
	MVI (__signed_stack_001Testing), 4
	INC __signed_stack_001Testing
	MVI (__signed_stack_001Testing), 5
	INC __signed_stack_001Testing
	MVI (__signed_stack_001Testing), 6
	MVI bar, 34
	RET
*/

// complex structs are not completely working yet
typedef struct {
  int x;
  int y;
  int z;
} PointType;

struct Person {
  int Age;
  int Height;
  int Weight;
};

PointType p;
Person me;

// arrays of more than one dimension are not working yet
// reference types are also not working as true references yet

// pointer syntax in functions not working yet
// char * Bogus(const char * ch);

task two() // good code
{
  while(true)
  {
    putchar('x');
  }
}
/*
two:
__ASM_Label_188:
	MVI __D0two, 1
	TST __D0two
	JZ __ASM_Label_189
	TRCH x
	MVI __D0two, 120
	JMP __ASM_Label_188
__ASM_Label_189:
	HALTME
*/

task three() // good code
{
  puts("3");
}
/*
three:
	TRCH 3
	HALTME
*/

int Foo(int x) // good code
{
  return x*x;
}
/*
Foo:
	MOV __signed_stack_001Foo, __Foo_7qG2_x_7qG2_000
	MOV __D0Foo, __Foo_7qG2_x_7qG2_000
	MUL __D0Foo, __signed_stack_001Foo
	RET
	RET
*/

void Testing(int x, int y) // good code
{
  int z = x+y-Foo(x)+Timer0;
  z--;
}
/*
Testing:
	MOV __signed_stack_001Testing, __Testing_7qG2_x_7qG2_000
	MOV __D0Testing, __Testing_7qG2_y_7qG2_000
	ADD __D0Testing, __signed_stack_001Testing
	MOV __signed_stack_001Testing, __D0Testing
	MOV __Foo_7qG2_x_7qG2_000, __Testing_7qG2_x_7qG2_000
	CALL Foo
	MOV __D0Testing, __D0Foo
	SUB __signed_stack_001Testing, __D0Testing
	MOV __D0Testing, 0CH
	ADD __D0Testing, __signed_stack_001Testing
	MOV __Testing_7qG2_z_7qG2_000, __D0Testing
	DEC __Testing_7qG2_z_7qG2_000
	RET
*/

task main()
{
  me.Age = 40; // good code
  PointType pt;
  pt.x = me.Age;
  pt.y = pt.x;
  pt.z = sqrt(pt.x);
  pt.z++;
  pt.y--;
/*
	MVI me.Age, 40
	MOV __main_7qG2_pt_7qG2_000.x, me.Age
	MOV __main_7qG2_pt_7qG2_000.y, __main_7qG2_pt_7qG2_000.x
	MOV __D0main, __main_7qG2_pt_7qG2_000.x
	SQRT __D0main
	MOV __main_7qG2_pt_7qG2_000.z, __D0main
	INC __main_7qG2_pt_7qG2_000.z
	DEC __main_7qG2_pt_7qG2_000.y
*/
  long * ptr;
  long x;
  @0x0C = 2; // good code
  Timer0 = 2; // good code
/*
	MVI 0CH, 2
	MVI 0CH, 2
*/
  x = @0x1F; // good code
  x = SystemClock; // good code
/*
	MOV __main_7qG2_x_7qG2_000, 1FH
	MOV __main_7qG2_x_7qG2_000, 1FH
*/
  x = SystemClock + Timer0 * Foo(SerialInByte); // good code
/*
	MOV __signed_stack_001main, 1FH
	MOV __signed_stack_002main, 0CH
	MOV __Foo_7qG2_x_7qG2_000, 11H
	CALL Foo
	MOV __D0main, __D0Foo
	MUL __D0main, __signed_stack_002main
	ADD __D0main, __signed_stack_001main
	MOV __main_7qG2_x_7qG2_000, __D0main
*/
  int data[] = {0, 1, 2, 3, 4}; // good code
/*
	MVI __signed_stack_001main, __main_7qG2_data_7qG2_000
	MVI (__signed_stack_001main), 0
	INC __signed_stack_001main
	MVI (__signed_stack_001main), 1
	INC __signed_stack_001main
	MVI (__signed_stack_001main), 2
	INC __signed_stack_001main
	MVI (__signed_stack_001main), 3
	INC __signed_stack_001main
	MVI (__signed_stack_001main), 4
*/
  ptr = &x; // good code
  *ptr = 23; // good code
  *ptr += 23; // good code
  x = *ptr; // good code
/*
	MVI __main_7qG2_ptr_7qG2_000, __main_7qG2_x_7qG2_000
	MVI (__main_7qG2_ptr_7qG2_000), 23
	ADI (__main_7qG2_ptr_7qG2_000), 23
	MOV __main_7qG2_x_7qG2_000, (__main_7qG2_ptr_7qG2_000)
*/
  x = *ptr % *ptr++; // good code
/*
	MOV __signed_stack_001main, (__main_7qG2_ptr_7qG2_000)
	MOV __D0main, (__main_7qG2_ptr_7qG2_000)
	INC __main_7qG2_ptr_7qG2_000
	MOV __signed_stack_002main, __signed_stack_001main
	DIV __signed_stack_002main, __D0main
	MUL __signed_stack_002main, __D0main
	SUB __signed_stack_001main, __signed_stack_002main
	MOV __main_7qG2_x_7qG2_000, __signed_stack_001main
*/
  x = ptr % 4; // good code
/*
	MOV __signed_stack_001main, __main_7qG2_ptr_7qG2_000
	MVI __D0main, 4
	MOV __signed_stack_002main, __signed_stack_001main
	DIV __signed_stack_002main, __D0main
	MUL __signed_stack_002main, __D0main
	SUB __signed_stack_001main, __signed_stack_002main
	MOV __main_7qG2_x_7qG2_000, __signed_stack_001main
*/
  x %= 4; // good code
/*
	MVI __D0main, 4
	MOV __signed_stack_001main, __main_7qG2_x_7qG2_000
	DIV __signed_stack_001main, __D0main
	MUL __signed_stack_001main, __D0main
	SUB __main_7qG2_x_7qG2_000, __signed_stack_001main
*/
  x = 80001; // good code
/*
	MVI __D0main, 00001H
	LSL __D0main, 16
	ORI __D0main, 03881H
	MOV __main_7qG2_x_7qG2_000, __D0main
*/
  if (5<4) // good code
    x++;
  else
    x--;
/*
	MVI __D0main, 0
	TST __D0main
	JZ __ASM_Label_52
	INC __main_7qG2_x_7qG2_000
	JMP __ASM_Label_53
__ASM_Label_52:
	DEC __main_7qG2_x_7qG2_000
__ASM_Label_53:
*/
  if (x<4) // good code
    x++;
  else
    x--;
/*
	MOV __signed_stack_001main, __main_7qG2_x_7qG2_000
	MVI __D0main, 4
	MOV __signed_stack_002main, __signed_stack_001main
	SUB __signed_stack_002main, __D0main
	MVI __signed_stack_002main, 1
	JN __ASM_Label_56
	MVI __signed_stack_002main, 0
__ASM_Label_56:
	TST __signed_stack_002main
	MVI __D0main, 0
	JZ __ASM_Label_57
	MVI __D0main, 1
__ASM_Label_57:
	JZ __ASM_Label_58
	INC __main_7qG2_x_7qG2_000
	JMP __ASM_Label_59
__ASM_Label_58:
	DEC __main_7qG2_x_7qG2_000
__ASM_Label_59:
*/

  for (int i=0; i<100; i++)  // good code
    data[i%5] = data[i%5] + i;
/*
	MVI __main_7qG2_i_7qG2_001, 0
__ASM_Label_60:
	MOV __signed_stack_001main, __main_7qG2_i_7qG2_001
	MVI __D0main, 100
	MOV __signed_stack_002main, __signed_stack_001main
	SUB __signed_stack_002main, __D0main
	MVI __signed_stack_002main, 1
	JN __ASM_Label_68
	MVI __signed_stack_002main, 0
__ASM_Label_68:
	TST __signed_stack_002main
	MVI __D0main, 0
	JZ __ASM_Label_69
	MVI __D0main, 1
__ASM_Label_69:
	JZ __ASM_Label_61
	JMP __ASM_Label_62
__ASM_Label_63:
	INC __main_7qG2_i_7qG2_001
	JMP __ASM_Label_60
__ASM_Label_62:
	MOV __signed_stack_001main, __main_7qG2_i_7qG2_001
	MVI __D0main, 5
	MOV __signed_stack_002main, __signed_stack_001main
	DIV __signed_stack_002main, __D0main
	MUL __signed_stack_002main, __D0main
	SUB __signed_stack_001main, __signed_stack_002main
	MOV __signed_stack_002main, __main_7qG2_i_7qG2_001
	MVI __D0main, 5
	MOV __signed_stack_003main, __signed_stack_002main
	DIV __signed_stack_003main, __D0main
	MUL __signed_stack_003main, __D0main
	SUB __signed_stack_002main, __signed_stack_003main
	MVI __signed_stack_003main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_003main, __signed_stack_002main
	MOV __signed_stack_002main, (__signed_stack_003main)
	MOV __D0main, __main_7qG2_i_7qG2_001
	ADD __D0main, __signed_stack_002main
	MVI __signed_stack_002main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_002main, __signed_stack_001main
	MOV (__signed_stack_002main), __D0main
	JMP __ASM_Label_63
__ASM_Label_61:
*/

  while (true) {  // good code
    x += 5;
    if (x > 1000)
      break;
  }
/*
__ASM_Label_76:
	MVI __D0main, 1
	TST __D0main
	JZ __ASM_Label_77
	ADI __main_7qG2_x_7qG2_000, 5
	MOV __signed_stack_001main, __main_7qG2_x_7qG2_000
	MVI __D0main, 1000
	MOV __signed_stack_002main, __signed_stack_001main
	SUB __signed_stack_002main, __D0main
	MVI __signed_stack_002main, 1
	JP __ASM_Label_84
	MVI __signed_stack_002main, 0
__ASM_Label_84:
	TST __signed_stack_002main
	MVI __D0main, 0
	JZ __ASM_Label_85
	MVI __D0main, 1
__ASM_Label_85:
	JZ __ASM_Label_86
	JMP __ASM_Label_77
__ASM_Label_86:
	JMP __ASM_Label_76
__ASM_Label_77:
*/

  repeat(100) // good code
  {
    x++;
    if (x > 50) break;
  }
/*
	MVI __signed_stack_001main, 100
__ASM_Label_87:
	DEC __signed_stack_001main
	INC __main_7qG2_x_7qG2_000
	MOV __signed_stack_002main, __main_7qG2_x_7qG2_000
	MVI __D0main, 50
	MOV __signed_stack_003main, __signed_stack_002main
	SUB __signed_stack_003main, __D0main
	MVI __signed_stack_003main, 1
	JP __ASM_Label_93
	MVI __signed_stack_003main, 0
__ASM_Label_93:
	TST __signed_stack_003main
	MVI __D0main, 0
	JZ __ASM_Label_94
	MVI __D0main, 1
__ASM_Label_94:
	JZ __ASM_Label_95
	JMP __ASM_Label_88
__ASM_Label_95:
	TST __signed_stack_001main
	JP __ASM_Label_87
__ASM_Label_88:
*/

  int y=34*2+50-13/40%33; // good code
/*
	MVI __main_7qG2_y_7qG2_000, 118
*/
  y = x+1-y; // good code
/*
	MOV __signed_stack_001main, __main_7qG2_x_7qG2_000
	MVI __D0main, 1
	ADD __D0main, __signed_stack_001main
	MOV __signed_stack_001main, __D0main
	MOV __D0main, __main_7qG2_y_7qG2_000
	SUB __signed_stack_001main, __D0main
	MOV __main_7qG2_y_7qG2_000, __signed_stack_001main
*/
  y--; // good code
/*
	DEC __main_7qG2_y_7qG2_000
*/
  x *= y; // good code
/*
	MOV __D0main, __main_7qG2_y_7qG2_000
	MUL __main_7qG2_x_7qG2_000, __D0main
*/
  data[0] = x; // good code
/*
	MVI __signed_stack_001main, 0
	MOV __D0main, __main_7qG2_x_7qG2_000
	MVI __signed_stack_002main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_002main, __signed_stack_001main
	MOV (__signed_stack_002main), __D0main
*/
  int i=0; // good code
/*
	MVI __main_7qG2_i_7qG2_000, 0
*/
  data[i] = y; // good code
/*
	MOV __signed_stack_001main, __main_7qG2_i_7qG2_000
	MOV __D0main, __main_7qG2_y_7qG2_000
	MVI __signed_stack_002main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_002main, __signed_stack_001main
	MOV (__signed_stack_002main), __D0main
*/
  data[i+1] = 2; // good code
/*
	MOV __signed_stack_001main, __main_7qG2_i_7qG2_000
	MVI __D0main, 1
	ADD __D0main, __signed_stack_001main
	MOV __signed_stack_001main, __D0main
	MVI __D0main, 2
	MVI __signed_stack_002main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_002main, __signed_stack_001main
	MOV (__signed_stack_002main), __D0main
*/
  data[i+2] = x*4; // good code
/*
	MOV __signed_stack_001main, __main_7qG2_i_7qG2_000
	MVI __D0main, 2
	ADD __D0main, __signed_stack_001main
	MOV __signed_stack_001main, __D0main
	MOV __signed_stack_002main, __main_7qG2_x_7qG2_000
	MVI __D0main, 4
	MUL __D0main, __signed_stack_002main
	MVI __signed_stack_002main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_002main, __signed_stack_001main
	MOV (__signed_stack_002main), __D0main
*/
  data[i+3] = foo[0]+bar; // good code
/*
	MOV __signed_stack_001main, __main_7qG2_i_7qG2_000
	MVI __D0main, 3
	ADD __D0main, __signed_stack_001main
	MOV __signed_stack_001main, __D0main
	MVI __signed_stack_002main, 0
	MVI __signed_stack_003main, foo
	ADD __signed_stack_003main, __signed_stack_002main
	MOV __signed_stack_002main, (__signed_stack_003main)
	MOV __D0main, bar
	ADD __D0main, __signed_stack_002main
	MVI __signed_stack_002main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_002main, __signed_stack_001main
	MOV (__signed_stack_002main), __D0main
*/
  if (x > 50) { // good code
    y++;
  }
  else {
    y--;
  }
/*
	MOV __signed_stack_001main, __main_7qG2_x_7qG2_000
	MVI __D0main, 50
	MOV __signed_stack_002main, __signed_stack_001main
	SUB __signed_stack_002main, __D0main
	MVI __signed_stack_002main, 1
	JP __ASM_Label_128
	MVI __signed_stack_002main, 0
__ASM_Label_128:
	TST __signed_stack_002main
	MVI __D0main, 0
	JZ __ASM_Label_129
	MVI __D0main, 1
__ASM_Label_129:
	JZ __ASM_Label_130
	INC __main_7qG2_y_7qG2_000
	JMP __ASM_Label_131
__ASM_Label_130:
	DEC __main_7qG2_y_7qG2_000
__ASM_Label_131:
*/
  Testing(x, data[0]); // good code
/*
	MOV __Testing_7qG2_x_7qG2_000, __main_7qG2_x_7qG2_000
	MVI __signed_stack_001main, 0
	MVI __signed_stack_002main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_002main, __signed_stack_001main
	MOV __Testing_7qG2_y_7qG2_000, (__signed_stack_002main)
	CALL Testing
*/
  switch(x) // good code
  {
    case 0:
      i++;
      break;
    case 1:
    case 2:
      i--;
      break;
    case 3: // fall through
      y++;
    case 4:
      data[i] = 23;
      break;
    default:
      data[0] = data[1];
  }
/*
	MOV __signed_stack_001main, __main_7qG2_x_7qG2_000
	SUI __signed_stack_001main, 0
	JZ __ASM_Label_141
	MOV __signed_stack_001main, __D0main
	SUI __signed_stack_001main, 1
	JZ __ASM_Label_142
	MOV __signed_stack_001main, __D0main
	SUI __signed_stack_001main, 2
	JZ __ASM_Label_143
	MOV __signed_stack_001main, __D0main
	SUI __signed_stack_001main, 3
	JZ __ASM_Label_144
	MOV __signed_stack_001main, __D0main
	SUI __signed_stack_001main, 4
	JZ __ASM_Label_145
	JMP __ASM_Label_150
	JMP __ASM_Label_140
__ASM_Label_141:
	INC __main_7qG2_i_7qG2_000
	JMP __ASM_Label_140
__ASM_Label_142:
__ASM_Label_143:
	DEC __main_7qG2_i_7qG2_000
	JMP __ASM_Label_140
__ASM_Label_144:
	INC __main_7qG2_y_7qG2_000
__ASM_Label_145:
	MOV __signed_stack_001main, __main_7qG2_i_7qG2_000
	MVI __D0main, 23
	MVI __signed_stack_002main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_002main, __signed_stack_001main
	MOV (__signed_stack_002main), __D0main
	JMP __ASM_Label_140
__ASM_Label_150:
	MVI __signed_stack_001main, 0
	MVI __signed_stack_002main, 1
	MVI __signed_stack_003main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_003main, __signed_stack_002main
	MOV __D0main, (__signed_stack_003main)
	MVI __signed_stack_002main, __main_7qG2_data_7qG2_000
	ADD __signed_stack_002main, __signed_stack_001main
	MOV (__signed_stack_002main), __D0main
__ASM_Label_140:
*/
  open("r"); // good code
/*
	LOPEN
	MVI __D0main, 0
	JC __ASM_Label_157
	MVI __D0main, 1
__ASM_Label_157:
*/
  x = read(); // good code
/*
	READ __main_7qG2_x_7qG2_000
*/
  close(); // good code
/*
	LCLOSE
	MVI __D0main, 0
	JC __ASM_Label_160
	MVI __D0main, 1
__ASM_Label_160:
*/
  open("w"); // good code
/*
	LINIT
	MVI __D0main, 0
	JC __ASM_Label_161
	MVI __D0main, 1
__ASM_Label_161:
*/
  write(x); // good code
/*
	MOV __D0main, __main_7qG2_x_7qG2_000
	LOG __D0main
*/
  x = stat(); // good code
/*
	LSTAT
	MVI __D0main, 2
	JZ __ASM_Label_166
	DEC __D0main
	JC __ASM_Label_166
	DEC __D0main
__ASM_Label_166:
	MOV __main_7qG2_x_7qG2_000, __D0main
*/
  x = push(y); // good code
/*
	MOV __D0main, __main_7qG2_y_7qG2_000
	PUSH __D0main
	MOV __main_7qG2_x_7qG2_000, __D0main
*/
  y = pop(); // good code
/*
	POP __main_7qG2_y_7qG2_000
*/
  y = sqrt(x); // good code
/*
	MOV __D0main, __main_7qG2_x_7qG2_000
	SQRT __D0main
	MOV __main_7qG2_y_7qG2_000, __D0main
*/
  y = putchar('\n'); // good code
/*
	TRNL
	MVI __main_7qG2_y_7qG2_000, 10
*/
  // unsupported escapes are output as ' '
  y = putchar('\t'); // good code
/*
	TRSP
	MVI __main_7qG2_y_7qG2_000, 32
*/
  y = putchar('\r'); // good code
/*
	TRCR
	MVI __main_7qG2_y_7qG2_000, 13
*/
  y = putchar('X'); // good code
/*
	TRCH X
	MVI __main_7qG2_y_7qG2_000, 88
*/
  y = puts("string\\\n \"constant\""); // good code
/*
	TRST 'string'
	TRCH \
	TRNL
	TRST ' '
	TRST '"'
	TRST 'constant'
	TRST '"'
	MVI __main_7qG2_y_7qG2_000, 1
*/
  // good code
  y = printf("Foo(x) = %d, x = %x, %s", Foo(x), x, "wow\n");
/*
	TRST 'Foo(x) = '
	MOV __Foo_7qG2_x_7qG2_000, __main_7qG2_x_7qG2_000
	CALL Foo
	MOV __D0main, __D0Foo
	TRND __D0main
	TRST ', x = '
	MOV __D0main, __main_7qG2_x_7qG2_000
	TRNH __D0main
	TRST ', '
	TRST 'wow'
	TRNL
	MVI __main_7qG2_y_7qG2_000, 1
*/
  // stop the program if boolean expression is true
  Stop(x>5); // good code
/*
	MOV __signed_stack_001main, __main_7qG2_x_7qG2_000
	MVI __D0main, 5
	MOV __signed_stack_002main, __signed_stack_001main
	SUB __signed_stack_002main, __D0main
	MVI __signed_stack_002main, 1
	JP __ASM_Label_197
	MVI __signed_stack_002main, 0
__ASM_Label_197:
	TST __signed_stack_002main
	MVI __D0main, 0
	JZ __ASM_Label_198
	MVI __D0main, 1
__ASM_Label_198:
	TST __D0main
	JZ __ASM_Label_199
	HALTALL
__ASM_Label_199:
*/

  start two; // good code
  ExitTo(three); // maybe good code?
/*
	FORK two
	FORK three
	HALTME
*/

  RotateLeft(x); // good code
  RotateRight(x); // good code
  StopProcesses(); // good code
  Run(4); // good code
/*
	RLC __main_7qG2_x_7qG2_000
	RRC __main_7qG2_x_7qG2_000
	HALTEX
	SWITCH 4
*/

  Wait(10); // good code
/*
	MVI __D0main, 10
	MOV __signed_stack_001main, 01FH
	ADD __signed_stack_001main, __D0main
__ASM_Label_202:
	MOV __signed_stack_002main, __signed_stack_001main
	SUB __signed_stack_002main, 01FH
	JP __ASM_Label_202
*/

  x = sign(y); // good code
/*
	MOV __D0main, __main_7qG2_y_7qG2_000
	TST __D0main
	MVI __D0main, 1
	JP __ASM_Label_207
	MVI __D0main, -1
	JN __ASM_Label_207
	MVI __D0main, 0
__ASM_Label_207:
	MOV __main_7qG2_x_7qG2_000, __D0main
*/

  x = abs(pt.z);
/*
	MOV __D0main, __main_7qG2_pt_7qG2_000.z
	TST __D0main
	JP __ASM_Label_212
	NEG __D0main
__ASM_Label_212:
	MOV __main_7qG2_x_7qG2_000, __D0main
*/

}

