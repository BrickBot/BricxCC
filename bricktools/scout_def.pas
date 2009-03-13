(*
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Initial Developer of this code is John Hansen.
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit scout_def;

interface

const

// Subroutines in ROM

 SUB_MOTOR_DRIVE       = 3;
 SUB_BASIC_MOTION      = 4;
 SUB_AVOID             = 5;
 SUB_MOVEMENTS         = 6;
 SUB_GET_AVERAGE_LIGHT = 7;
 SUB_AUTO_ADJUST_LIGHT = 8;
 SUB_SEEK              = 9;
 SUB_FIND_BRIGHT       = 10;
 SUB_GET_MOTOR_STATUS  = 11;
 SUB_MOTOR_2_SOUND     = 12;
 SUB_LIGHT_GEIGER      = 13;
 SUB_FWD               = 14;
 SUB_RWD               = 15;
 SUB_SPIN_RIGHT        = 16;
 SUB_SPIN_LEFT         = 17;
 SUB_FWD_TURN_RIGHT    = 18;
 SUB_RWD_TURN_LEFT     = 19;
 SUB_FWD_TURN_LEFT     = 20;
 SUB_RWD_TURN_RIGHT    = 21;
 SUB_ZIGZAG            = 22;
 SUB_CIRCLE_RIGHT      = 23;
 SUB_CIRCLE_LEFT       = 24;
 SUB_AVOID_RIGHT       = 25;
 SUB_AVOID_LEFT        = 26;
 SUB_BUGSHAKE          = 27;
 SUB_LOOP_AB           = 28;
 SUB_GET_SEMA0         = 29;
 SUB_GET_SEMA1         = 30;
 SUB_GET_SEMA2         = 31;
 SUB_INIT_SYS          = 32;

//==============================================================================
// Scout modes
// Command use: scout
//==============================================================================

 MODE_SA               = 0;
 MODE_POWER            = 1;


//==============================================================================
// Scout sounds
// Command use: plays
//==============================================================================

// System sounds

 SND_CLICK             = 0;
 SND_BEEP              = 1;
 SND_SWEEP_DOWN        = 2;
 SND_SWEEP_UP          = 3;
 SND_ERROR             = 4;
 SND_SWEEP_FAST        = 5;
 SND_REMOTE            = 6;
 SND_ENTER_SA          = 7;
 SND_KEY_ERROR         = 8;
 SND_NONE              = 9; // Used to terminate another sound

// Sound set contained sounds

 SND_TOUCH1_PRES       = 10;
 SND_TOUCH1_REL        = 11;
 SND_TOUCH2_PRES       = 12;
 SND_TOUCH2_REL        = 13;
 SND_ENTER_BRIGHT      = 14;
 SND_ENTER_NORMAL      = 15;
 SND_ENTER_DARK        = 16;
 SND_1_BLINK           = 17;
 SND_2_BLINK           = 18;
 SND_COUNTER1          = 19;
 SND_COUNTER2          = 20;
 SND_TIMER1            = 21;
 SND_TIMER2            = 22;
 SND_TIMER3            = 23;
 SND_MAIL_RECEIVED     = 24;
 SND_SPECIAL1          = 25;
 SND_SPECIAL2          = 26;
 SND_SPECIAL3          = 27;

//==============================================================================
// Sound command selection
// Command use: sound (1. parameter)
//==============================================================================

 SOUND_SEL_SOUNDSET    = 0;
 SOUND_SEL_ONOFF       = 1;

//==============================================================================
// Sound mute/unmute
// Command use: sound (2. parameter)
//==============================================================================

 SNDCTRL_SOUND_ON      = 0;
 SNDCTRL_SOUND_OFF     = 1;

//==============================================================================
// Sound sets
// Command use: sound (3. parameter)
//==============================================================================

 SNDSET_NONE           = 0;
 SNDSET_BASIC          = 1;
 SNDSET_BUG            = 2;
 SNDSET_ALARM          = 3;
 SNDSET_RANDOM         = 4;
 SNDSET_SCIENCE        = 5;

//==============================================================================
// Shorthand versions for sound control
//==============================================================================

// mute                  sound SOUND_SEL_ONOFF, SOUND_SOUND_OFF, 0
// speak                 sound SOUND_SEL_ONOFF, SOUND_SOUND_ON, 0
// sndset                sound SOUND_SEL_SOUNDSET, 0,


//==============================================================================
// Sound feedback bitmasks
// Command use: setfb
//==============================================================================

 FBMASK_NO_FB          = $0000;
 FBMASK_TOUCH          = $000F;  // 0000 0000 0000 1111
 FBMASK_LIGHT          = $0050;  // 0000 0000 0111 0000
 FBMASK_HEART          = $0800;  // 0000 1000 0000 0000
 FBMASK_SA             = $085F;  // 0000 1000 0111 1111

//==============================================================================
// Sensor names
// Command use: Together with SRC_SENVAL, SRC_SENTYPE and SRC_SENRAW
//==============================================================================

 SEN_TOUCH1            = 0;
 SEN_TOUCH2            = 1;
 SEN_LIGHT             = 2;

//==============================================================================
// Touch sensor states
// Setting of touch sensor value
//==============================================================================

 TVAL_RELEASED         = 0;
 TVAL_PRESSED          = 1;

//==============================================================================
// Touch sensor ID
// Setting of touch sensor type
//==============================================================================

 TOUCH_ID_RED          = 5;
 TOUCH_ID_YELLOW       = 6;
 TOUCH_ID_WHITE        = 7;

//==============================================================================
// Light sensor states
// Setting of light sensor value
//==============================================================================

 LVAL_DARK             = 0;
 LVAL_NORMAL           = 1;
 LVAL_BRIGHT           = 2;
 LVAL_UNDEFINED        = 255;

//==============================================================================
// Stand Alone setup groups
// Command use: Together with SRC_SASET
//==============================================================================

 SA_MOTION             = 0;
 SA_TOUCH              = 1;
 SA_LIGHT              = 2;
 SA_TIME               = 3;
 SA_FX                 = 4;

//==============================================================================
// Stand Alone Scout setup
// Command use: rules
//==============================================================================

// Motion rules

 MR_NO_MOTION          = 0;
 MR_FORWARD            = 1;
 MR_ZIGZAG             = 2;
 MR_CIRCLE_RIGHT       = 3;
 MR_CIRCLE_LEFT        = 4;
 MR_LOOP_A             = 5;
 MR_LOOP_B             = 6;
 MR_LOOP_AB            = 7;

// Touch rules

 TR_IGNORE             = 0;
 TR_REVERSE            = 1;
 TR_AVOID              = 2;
 TR_WAIT_FOR           = 3;
 TR_OFF_WHEN           = 4;

// Light rules

 LR_IGNORE             = 0;
 LR_SEEK_LIGHT         = 1;
 LR_SEEK_DARK          = 2;
 LR_AVOID              = 3;
 LR_WAIT_FOR           = 4;
 LR_OFF_WHEN           = 5;

// Time group settings

 TGS_SHORT             = 0;
 TGS_MEDIUM            = 1;
 TGS_LONG              = 2;

// FX rules

 FXR_NONE              = 0;
 FXR_BUG               = 1;
 FXR_ALARM             = 2;
 FXR_RANDOM            = 3;
 FXR_SCIENCE           = 4;

//==============================================================================
// Task event register
// Command use: Together with SRC_EVENT
//==============================================================================

 REG_TASKEVENT         = 0;

//==============================================================================
// Sound feedback register
// Command use: Together with SRC_SOUND
//==============================================================================

 REG_SOUNDFBK          = 0;

//==============================================================================
// Output lists
// Command use: dir, gdir, out, gout, pwr and gpwr
//==============================================================================

 OUTLIST_A             = 1;
 OUTLIST_B             = 2;
 OUTLIST_AB            = 3;
 OUTLIST_C             = 4;
 OUTLIST_AC            = 5;
 OUTLIST_BC            = 6;
 OUTLIST_ABC           = 7;

//==============================================================================
// Resources
// Motor A: A
// Motor B: B
// Sound  : S
// VLL    : V
// Command use: monal
//==============================================================================

 RES_A                 = 1;
 RES_B                 = 2;
 RES_AB                = 3;
 RES_S                 = 4;
 RES_AS                = 5;
 RES_BS                = 6;
 RES_ABS               = 7;
 RES_V                 = 8;
 RES_AV                = 9;
 RES_BV                = 10;
 RES_ABV               = 11;
 RES_SV                = 12;
 RES_ASV               = 13;
 RES_BSV               = 14;
 RES_ABSV              = 15;

//==============================================================================
// Priority levels
// Command use: setp
//==============================================================================

 PRT0                  = 0;
 PRT1                  = 1;
 PRT2                  = 2;
 PRT3                  = 3;
 PRT4                  = 4;
 PRT5                  = 5;
 PRT6                  = 6;
 PRT7                  = 7;


//==============================================================================
// Micro Scout VLL codes
// _D_ are direct commands
// _S_ are script commands
// Command use: vll
//==============================================================================

 MSVLL_D_FWD           = 0;
 MSVLL_D_RWD           = 1;

 MSVLL_D_BEEP1         = 4;
 MSVLL_D_BEEP2         = 5;
 MSVLL_D_BEEP3         = 6;
 MSVLL_D_BEEP4         = 7;
 MSVLL_D_BEEP5         = 8;

 MSVLL_S_FWD05         = 16;
 MSVLL_S_FWD1          = 17;
 MSVLL_S_FWD2          = 18;
 MSVLL_S_FWD5          = 19;

 MSVLL_S_RWD05         = 20;
 MSVLL_S_RWD1          = 21;
 MSVLL_S_RWD2          = 22;
 MSVLL_S_RWD5          = 23;

 MSVLL_S_BEEP1         = 24;
 MSVLL_S_BEEP2         = 25;
 MSVLL_S_BEEP3         = 26;
 MSVLL_S_BEEP4         = 27;
 MSVLL_S_BEEP5         = 28;

 MSVLL_S_WAIT4_LIGHT   = 29;
 MSVLL_S_SEEK_LIGHT    = 30;
 MSVLL_S_CODE          = 31;
 MSVLL_S_KEEP_ALIVE    = 32;

 MSVLL_D_RUN           = 33;
 MSVLL_D_DEL_SCRIPT    = 34;

//==============================================================================
// Fine resolution time constants
// Command use: wait, playt and playv
//==============================================================================

 FR_MS_10              = 1;
 FR_MS_20              = 2;
 FR_MS_30              = 3;
 FR_MS_40              = 4;
 FR_MS_50              = 5;
 FR_MS_60              = 6;
 FR_MS_70              = 7;
 FR_MS_80              = 8;
 FR_MS_90              = 9;
 FR_MS_100             = 10;
 FR_MS_150             = 15;
 FR_MS_200             = 20;
 FR_MS_250             = 25;
 FR_MS_300             = 30;
 FR_MS_350             = 35;
 FR_MS_400             = 40;
 FR_MS_450             = 45;
 FR_MS_500             = 50;
 FR_MS_600             = 60;
 FR_MS_700             = 70;
 FR_MS_800             = 80;
 FR_MS_900             = 90;
 FR_SEC_1              = 100;
 FR_SEC_2              = 200;
 FR_SEC_3              = 300;
 FR_SEC_4              = 400;
 FR_SEC_5              = 500;
 FR_SEC_6              = 600;
 FR_SEC_7              = 700;
 FR_SEC_8              = 800;
 FR_SEC_9              = 900;
 FR_SEC_10             = 1000;
 FR_SEC_15             = 1500;
 FR_SEC_20             = 2000;
 FR_SEC_30             = 3000;
 FR_MIN_1              = 6000;

//==============================================================================
// Coarse resolution time constants
// Command use: Together with timers
//==============================================================================

 CR_MS_100             = 1;
 CR_MS_200             = 2;
 CR_MS_300             = 3;
 CR_MS_400             = 4;
 CR_MS_500             = 5;
 CR_MS_600             = 6;
 CR_MS_700             = 7;
 CR_MS_800             = 8;
 CR_MS_900             = 9;
 CR_SEC_1              = 10;
 CR_SEC_2              = 20;
 CR_SEC_3              = 30;
 CR_SEC_4              = 40;
 CR_SEC_5              = 50;
 CR_SEC_6              = 60;
 CR_SEC_7              = 70;
 CR_SEC_8              = 80;
 CR_SEC_9              = 90;
 CR_SEC_10             = 100;
 CR_SEC_15             = 150;
 CR_SEC_20             = 200;
 CR_SEC_30             = 300;
 CR_MIN_1              = 600;
 CR_MIN_2              = 1200;
 CR_MIN_3              = 1800;
 CR_MIN_4              = 2400;
 CR_MIN_5              = 3000;
 CR_MIN_10             = 6000;

//==============================================================================
// Tones
// Command use: playt
//==============================================================================

 TONE_A4               = 220;
 TONE_AS4              = 247;
 TONE_C4               = 262;
 TONE_CS4              = 277;
 TONE_D4               = 294;
 TONE_DS4              = 311;
 TONE_E4               = 330;
 TONE_F4               = 349;
 TONE_FS4              = 370;
 TONE_G4               = 392;
 TONE_GS4              = 415;

 TONE_A5               = 440;
 TONE_AS5              = 466;
 TONE_B5               = 494;
 TONE_C5               = 523;
 TONE_CS5              = 554;
 TONE_D5               = 587;
 TONE_DS5              = 622;
 TONE_E5               = 659;
 TONE_F5               = 698;
 TONE_FS5              = 740;
 TONE_G5               = 784;
 TONE_GS5              = 831;

 TONE_A6               = 880;
 TONE_AS6              = 932;
 TONE_B6               = 988;
 TONE_C6               = 1047;
 TONE_CS6              = 1109;
 TONE_D6               = 1175;
 TONE_DS6              = 1245;
 TONE_E6               = 1319;
 TONE_F6               = 1397;
 TONE_FS6              = 1480;
 TONE_G6               = 1568;
 TONE_GS6              = 1661;

 TONE_A7               = 1760;
 TONE_AS7              = 1865;
 TONE_B7               = 1976;
 TONE_C7               = 2093;
 TONE_CS7              = 2217;
 TONE_D7               = 2349;
 TONE_DS7              = 2489;
 TONE_E7               = 2637;
 TONE_F7               = 2794;
 TONE_FS7              = 2960;
 TONE_G7               = 3136;
 TONE_GS7              = 3322;

//==============================================================================
// Eventlist bitmasks
// Command use: event, mone
//==============================================================================

 EVENT_NONE            = $0000; // /* 0000 0000 0000 0000 */

 EVENT_T1PR            = $0001; // /* 0000 0000 0000 0001 */
 EVENT_T1RE            = $0002; // /* 0000 0000 0000 0010 */
 EVENT_T1              = $0003; // /* 0000 0000 0000 0011 */

 EVENT_T2PR            = $0004; //  /* 0000 0000 0000 0100 */
 EVENT_T2RE            = $0008; //  /* 0000 0000 0000 1000 */
 EVENT_T2              = $000C; //  /* 0000 0000 0000 1100 */

 EVENT_TPR             = $0005; // /* 0000 0000 0000 0101 */
 EVENT_TRE             = $000A; //  /* 0000 0000 0000 1010 */

 EVENT_TOUCH           = $000F; //  /* 0000 0000 0000 1111 */

 EVENT_LGT             = $0010; //  /* 0000 0000 0001 0000 */
 EVENT_NOR             = $0020; //  /* 0000 0000 0010 0000 */
 EVENT_LGT_NOR         = $0030; //  /* 0000 0000 0011 0000 */
 EVENT_DAR             = $0040; //  /* 0000 0000 0100 0000 */
 EVENT_LGT_DAR         = $0050; //  /* 0000 0000 0101 0000 */
 EVENT_NOR_DAR         = $0060; //  /* 0000 0000 0110 0000 */
 EVENT_LGT_NOR_DAR     = $0070; //  /* 0000 0000 0111 0000 */

 EVENT_1BLINK          = $0080; //  /* 0000 0000 1000 0000 */
 EVENT_2BLINKS         = $0100; //  /* 0000 0001 0000 0000 */

 EVENT_CTR1            = $0200; //  /* 0000 0010 0000 0000 */
 EVENT_CTR2            = $0400; //  /* 0000 0100 0000 0000 */
 EVENT_CTR             = $0600; //  /* 0000 0110 0000 0000 */

 EVENT_TMR1            = $0800; //  /* 0000 1000 0000 0000  */
 EVENT_TMR2            = $1000; //  /* 0001 0000 0000 0000  */
 EVENT_TMR3            = $2000; //  /* 0010 0000 0000 0000  */

 EVENT_PBM             = $4000; //  /* 0100 0000 0000 0000  */

//==============================================================================
// Memory addresses
// Command use: pollm
//==============================================================================

// PB message register

 ADDR_MESSAGE           = $00000096;

//------------------------------------------------------------------------------
//      Input/output
//------------------------------------------------------------------------------

 ADDR_IO                = $00000100;

// Timers
 ADDR_TMR               = $00000107;
 ADDR_TMR0_LO           = ADDR_TMR;
 ADDR_TMR0_HI           = ADDR_TMR + 1;
 ADDR_TMR1_LO           = ADDR_TMR + 2;
 ADDR_TMR1_HI           = ADDR_TMR + 3;
 ADDR_TMR2_LO           = ADDR_TMR + 4;
 ADDR_TMR2_HI           = ADDR_TMR + 5;

// Input states

 ADDR_T1_STATE          = ADDR_IO + 46;
 ADDR_T2_STATE          = ADDR_IO + 47;
 ADDR_L_STATE           = ADDR_IO + 48;

// Input types

 ADDR_T1_TYPE           = ADDR_IO + 49;
 ADDR_T2_TYPE           = ADDR_IO + 50;

// Input (raw) value

 ADDR_T1_VAL_LO         = ADDR_IO + 52;
 ADDR_T1_VAL_HI         = ADDR_IO + 53;
 ADDR_T2_VAL_LO         = ADDR_IO + 54;
 ADDR_T2_VAL_HI         = ADDR_IO + 55;
 ADDR_L_VAL_LO          = ADDR_IO + 56;
 ADDR_L_VAL_HI          = ADDR_IO + 57;

// Battery voltage
// The relation between the value BV read in BatteryVoltage and the actual
// voltage Vbat on the battery is: Vbat = 0.109*BV

 ADDR_BATTERY           = ADDR_IO + 58;

// Output State Registers

 ADDR_OUTA_STATE        = ADDR_IO + 68;
 ADDR_OUTB_STATE        = ADDR_IO + 69;
 ADDR_OUTC_STATE        = ADDR_IO + 70;

//------------------------------------------------------------------------------
//      Global variables
//------------------------------------------------------------------------------

 ADDR_GV                = $000001B7;

 ADDR_VAR0_LO           = ADDR_GV;
 ADDR_VAR0_HI           = ADDR_GV + 1;
 ADDR_VAR1_LO           = ADDR_GV + 2;
 ADDR_VAR1_HI           = ADDR_GV + 3;
 ADDR_VAR2_LO           = ADDR_GV + 4;
 ADDR_VAR2_HI           = ADDR_GV + 5;
 ADDR_VAR3_LO           = ADDR_GV + 6;
 ADDR_VAR3_HI           = ADDR_GV + 7;
 ADDR_VAR4_LO           = ADDR_GV + 8;
 ADDR_VAR4_HI           = ADDR_GV + 9;
 ADDR_VAR5_LO           = ADDR_GV + 10;
 ADDR_VAR5_HI           = ADDR_GV + 11;
 ADDR_VAR6_LO           = ADDR_GV + 12;
 ADDR_VAR6_HI           = ADDR_GV + 13;
 ADDR_VAR7_LO           = ADDR_GV + 14;
 ADDR_VAR7_HI           = ADDR_GV + 15;
 ADDR_VAR8_LO           = ADDR_GV + 16;
 ADDR_VAR8_HI           = ADDR_GV + 17;
 ADDR_VAR9_LO           = ADDR_GV + 18;
 ADDR_VAR9_HI           = ADDR_GV + 19;

//------------------------------------------------------------------------------
//      Counters
//------------------------------------------------------------------------------

 ADDR_CTR               = $0000022B;

 ADDR_CTR1_LO           = ADDR_CTR;
 ADDR_CTR1_HI           = ADDR_CTR + 1;
 ADDR_CTR2_LO           = ADDR_CTR + 2;
 ADDR_CTR2_HI           = ADDR_CTR + 3;

 // memory map address
 ADDR_MEM               = $00000233;

implementation

end.
