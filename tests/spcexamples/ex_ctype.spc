task main()
{
  printf("%d\n", isalnum('a'));
  printf("%d\n", isalpha('1'));
  printf("%d\n", iscntrl('g'));
  printf("%d\n", isdigit('2'));
  printf("%d\n", isgraph('%'));
  printf("%d\n", islower('G'));
  printf("%d\n", isprint('('));

  printf("%d\n", ispunct('a'));
  printf("%d\n", isspace('1'));
  printf("%d\n", isupper('g'));
  printf("%d\n", isxdigit('2'));
  printf("%d\n", tolower('.'));
  printf("%d\n", toupper('f'));

  Wait(SEC_5);
}
