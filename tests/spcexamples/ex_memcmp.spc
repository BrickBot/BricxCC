task main()
{
  byte myArray[] = {1, 2, 3, 4};
  byte x[] = {1, 2, 3, 5};
  int i = 5;
  int j;
  j = memcmp(myArray, x, 1); // returns -1, 0, or 1
  NumOut(0, LCD_LINE1, i);
  NumOut(0, LCD_LINE2, j);
  NumOut(0, LCD_LINE3, memcmp(i, j, 1));
  Wait(SEC_15);
}

