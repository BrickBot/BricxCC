// When run, this program alternates between task A and task B until halted
// by pressing the gray button.

task B();

task A()
{
   printf("task A\n");
   ExitTo(B);
}

task B()
{
   printf("task B\n");
   ExitTo(A);
}

task main()
{
   printf("task main\n");
   ExitTo(B);
}
