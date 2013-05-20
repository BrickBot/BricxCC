task main()
{
  while(true)
  {
    LEDControl = LED_BLUE;
    Wait(SEC_1);
    LEDControl = LED_RED;
    Wait(SEC_1);
    LEDControl = LED_BLUE|LED_RED;
    Wait(SEC_1);
  }
}
