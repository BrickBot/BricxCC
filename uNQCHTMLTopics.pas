unit uNQCHTMLTopics;

interface

uses
  uHTMLHelp;

const
  uNQCHTMLTopicsSize = 858;
  uNQCHTMLTopicsData: array[0..uNQCHTMLTopicsSize-1] of TNameValue = (
    (
     Name: 'DatalogValue';
     Value: 'nqc/nqc_02zp.htm'
    ),
    (
     Name: 'GateOff';
     Value: 'nqc/nqc_03c6.htm'
    ),
    (
     Name: 'SetTxPower';
     Value: 'nqc/nqc_03hu.htm'
    ),
    (
     Name: 'TX_POWER_LO';
     Value: 'nqc/nqc_03hu.htm'
    ),
    (
     Name: 'TX_POWER_HI';
     Value: 'nqc/nqc_03hu.htm'
    ),
    (
     Name: 'WorldLinkID';
     Value: 'nqc/nqc_03ok.htm'
    ),
    (
     Name: 'QueuedSoundCount';
     Value: 'nqc/nqc_03uc.htm'
    ),
    (
     Name: 'WorldRange';
     Value: 'nqc/nqc_03z9.htm'
    ),
    (
     Name: 'Glide';
     Value: 'nqc/nqc_04bp.htm'
    ),
    (
     Name: 'SetSpybotCtrlMessage';
     Value: 'nqc/nqc_04dh.htm'
    ),
    (
     Name: 'rcx specific features';
     Value: 'nqc/nqc_04o3.htm'
    ),
    (
     Name: 'MotorTransitionDelay';
     Value: 'nqc/nqc_069l.htm'
    ),
    (
     Name: 'SetMotorPowerSigned';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_A';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_B';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_C';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_D';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_E';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_F';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MPD_FWD';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MPD_REV';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MPD_FLOAT';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MPD_OFF';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MS_FLOAT';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MS_BRAKE';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MS_FWD';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MS_REV';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FWD_POWER_1';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FWD_POWER_2';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FWD_POWER_3';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FWD_POWER_4';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FWD_POWER_5';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FWD_POWER_6';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FWD_POWER_7';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FWD_POWER_8';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_REV_POWER_1';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_REV_POWER_2';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_REV_POWER_3';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_REV_POWER_4';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_REV_POWER_5';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_REV_POWER_6';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_REV_POWER_7';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_REV_POWER_8';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FLOAT_POWER_1';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FLOAT_POWER_2';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FLOAT_POWER_3';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FLOAT_POWER_4';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FLOAT_POWER_5';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FLOAT_POWER_6';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FLOAT_POWER_7';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_FLOAT_POWER_8';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_BRAKE_POWER_1';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_BRAKE_POWER_2';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_BRAKE_POWER_3';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_BRAKE_POWER_4';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_BRAKE_POWER_5';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_BRAKE_POWER_6';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_BRAKE_POWER_7';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'MTR_BRAKE_POWER_8';
     Value: 'nqc/nqc_06g4.htm'
    ),
    (
     Name: 'RandomMove';
     Value: 'nqc/nqc_07ol.htm'
    ),
    (
     Name: 'MOVE_RANDOM_FORWARD';
     Value: 'nqc/nqc_07ol.htm'
    ),
    (
     Name: 'MOVE_RANDOM_BACKWARD';
     Value: 'nqc/nqc_07ol.htm'
    ),
    (
     Name: 'MOVE_RANDOM_SPIN_LEFT';
     Value: 'nqc/nqc_07ol.htm'
    ),
    (
     Name: 'MOVE_RANDOM_SPIN_RIGHT';
     Value: 'nqc/nqc_07ol.htm'
    ),
    (
     Name: 'MOVE_RANDOM_TURN_LEFT';
     Value: 'nqc/nqc_07ol.htm'
    ),
    (
     Name: 'MOVE_RANDOM_TURN_RIGHT';
     Value: 'nqc/nqc_07ol.htm'
    ),
    (
     Name: 'MOVE_RANDOM_REST';
     Value: 'nqc/nqc_07ol.htm'
    ),
    (
     Name: 'SetExpandedRemoteMessages';
     Value: 'nqc/nqc_07ub.htm'
    ),
    (
     Name: 'SetSpybotMessage';
     Value: 'nqc/nqc_090l.htm'
    ),
    (
     Name: 'Sum4Mem';
     Value: 'nqc/nqc_094d.htm'
    ),
    (
     Name: 'SetEventSrc';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_SENSOR_1';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_SENSOR_2';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_SENSOR_3';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_TIMER_1';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_TIMER_2';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_TIMER_3';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_TIMER_4';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_LAST_IR_MSG';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_COUNTER_1';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_COUNTER_2';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_COUNTER_3';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_USER_EVENT_0';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_USER_EVENT_1';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_USER_EVENT_2';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_USER_EVENT_3';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_USER_EVENT_4';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_VIRTUAL_MOTOR';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_VIRTUAL_SENSOR';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_WAIT_FOR_MSG';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_INFRARED_STATUS';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'EST_SENSOR_UNUSED';
     Value: 'nqc/nqc_0ag3.htm'
    ),
    (
     Name: 'SetSensor';
     Value: 'nqc/nqc_0b02.htm'
    ),
    (
     Name: 'SENSOR_TOUCH';
     Value: 'nqc/nqc_0b02.htm'
    ),
    (
     Name: 'SENSOR_LIGHT';
     Value: 'nqc/nqc_0b02.htm'
    ),
    (
     Name: 'SENSOR_ROTATION';
     Value: 'nqc/nqc_0b02.htm'
    ),
    (
     Name: 'SENSOR_CELSIUS';
     Value: 'nqc/nqc_0b02.htm'
    ),
    (
     Name: 'SENSOR_FAHRENHEIT';
     Value: 'nqc/nqc_0b02.htm'
    ),
    (
     Name: 'SENSOR_PULSE';
     Value: 'nqc/nqc_0b02.htm'
    ),
    (
     Name: 'SENSOR_EDGE';
     Value: 'nqc/nqc_0b02.htm'
    ),
    (
     Name: 'SetTimerLimit';
     Value: 'nqc/nqc_0bas.htm'
    ),
    (
     Name: 'lexical rules';
     Value: 'nqc/nqc_0ckz.htm'
    ),
    (
     Name: 'SetSystem';
     Value: 'nqc/nqc_0cod.htm'
    ),
    (
     Name: 'SetPingData';
     Value: 'nqc/nqc_0f35.htm'
    ),
    (
     Name: 'structure';
     Value: 'nqc/nqc_0gyt.htm'
    ),
    (
     Name: 'start';
     Value: 'nqc/nqc_0i0g.htm'
    ),
    (
     Name: 'stop';
     Value: 'nqc/nqc_0i0g.htm'
    ),
    (
     Name: 'SetPingInterval';
     Value: 'nqc/nqc_0izw.htm'
    ),
    (
     Name: 'CalibrateEvent';
     Value: 'nqc/nqc_0jn8.htm'
    ),
    (
     Name: 'ObvertOutput';
     Value: 'nqc/nqc_0jp0.htm'
    ),
    (
     Name: 'WorldShortID';
     Value: 'nqc/nqc_0kro.htm'
    ),
    (
     Name: 'MessageParam';
     Value: 'nqc/nqc_0lkd.htm'
    ),
    (
     Name: 'PingControl';
     Value: 'nqc/nqc_0lnw.htm'
    ),
    (
     Name: 'CommErrorsOverrun';
     Value: 'nqc/nqc_0omm.htm'
    ),
    (
     Name: 'sensors';
     Value: 'nqc/nqc_0p67.htm'
    ),
    (
     Name: 'sensors, information';
     Value: 'nqc/nqc_0p67.htm'
    ),
    (
     Name: 'SetLowerLimit';
     Value: 'nqc/nqc_0px0.htm'
    ),
    (
     Name: 'SendSpybotMessage';
     Value: 'nqc/nqc_0r1u.htm'
    ),
    (
     Name: 'SetSpybotCtrlPingMessage';
     Value: 'nqc/nqc_0rdx.htm'
    ),
    (
     Name: 'SetMessageByteParam';
     Value: 'nqc/nqc_0rhp.htm'
    ),
    (
     Name: 'RepeatEffect';
     Value: 'nqc/nqc_0sdw.htm'
    ),
    (
     Name: 'MotorPower128';
     Value: 'nqc/nqc_0u2g.htm'
    ),
    (
     Name: 'Disp';
     Value: 'nqc/nqc_0v5c.htm'
    ),
    (
     Name: 'comments';
     Value: 'nqc/nqc_0voz.htm'
    ),
    (
     Name: 'LowerLimit';
     Value: 'nqc/nqc_0vqs.htm'
    ),
    (
     Name: 'DefaultStackSize';
     Value: 'nqc/nqc_0wyt.htm'
    ),
    (
     Name: 'FixedTone';
     Value: 'nqc/nqc_0x5x.htm'
    ),
    (
     Name: 'SetWatch';
     Value: 'nqc/nqc_0xwo.htm'
    ),
    (
     Name: 'reserving storage';
     Value: 'nqc/nqc_0zol.htm'
    ),
    (
     Name: 'Float';
     Value: 'nqc/nqc_11ro.htm'
    ),
    (
     Name: 'SendAllRangeMessage';
     Value: 'nqc/nqc_1291.htm'
    ),
    (
     Name: 'ClickTime';
     Value: 'nqc/nqc_13fp.htm'
    ),
    (
     Name: 'while';
     Value: 'nqc/nqc_15r9.htm'
    ),
    (
     Name: 'SetLED';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_ON';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_BLINK';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_DURATION';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_SCALE';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_SCALE_BLINK';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_SCALE_DURATION';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_RED_SCALE';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_RED_SCALE_BLINK';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_GREEN_SCALE';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_GREEN_SCALE_BLINK';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_YELLOW';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_YELLOW_BLINK';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_YELLOW_DURATION';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_VLL';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_VLL_BLINK';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_MODE_VLL_DURATION';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_RED1';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_RED2';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_RED3';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_GREEN1';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_GREEN2';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_GREEN3';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_YELLOW';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_ALL_RED';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_ALL_GREEN';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_ALL_RED_GREEN';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'LED_ALL';
     Value: 'nqc/nqc_17dw.htm'
    ),
    (
     Name: 'SetOutput';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_OFF';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_ON';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_FLOAT';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_A';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_B';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_C';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_AB';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_AC';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_BC';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_ABC';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_D';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_E';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'OUT_F';
     Value: 'nqc/nqc_17lg.htm'
    ),
    (
     Name: 'SendRCMsg';
     Value: 'nqc/nqc_186f.htm'
    ),
    (
     Name: 'EventType';
     Value: 'nqc/nqc_18f9.htm'
    ),
    (
     Name: 'IntrinsicIndGlobal';
     Value: 'nqc/nqc_18rw.htm'
    ),
    (
     Name: 'World';
     Value: 'nqc/nqc_1a3o.htm'
    ),
    (
     Name: 'Tone';
     Value: 'nqc/nqc_1a79.htm'
    ),
    (
     Name: 'outputs';
     Value: 'nqc/nqc_1a7a.htm'
    ),
    (
     Name: 'outputs, primitive calls';
     Value: 'nqc/nqc_1a7a.htm'
    ),
    (
     Name: 'GetWorldNote';
     Value: 'nqc/nqc_1cdh.htm'
    ),
    (
     Name: 'SetSensorUpperLimit';
     Value: 'nqc/nqc_1cqc.htm'
    ),
    (
     Name: 'CommErrorsParity';
     Value: 'nqc/nqc_1da1.htm'
    ),
    (
     Name: 'UnsolicitedMessages';
     Value: 'nqc/nqc_1f03.htm'
    ),
    (
     Name: 'language';
     Value: 'nqc/nqc_1gh1.htm'
    ),
    (
     Name: 'AGC';
     Value: 'nqc/nqc_1grn.htm'
    ),
    (
     Name: 'asm';
     Value: 'nqc/nqc_1hd9.htm'
    ),
    (
     Name: 'SetSerialType';
     Value: 'nqc/nqc_1hwl.htm'
    ),
    (
     Name: 'ExpandedSubroutines';
     Value: 'nqc/nqc_1i2b.htm'
    ),
    (
     Name: 'ClearSensor';
     Value: 'nqc/nqc_1k8i.htm'
    ),
    (
     Name: 'technical details';
     Value: 'nqc/nqc_1mur.htm'
    ),
    (
     Name: 'SerialType';
     Value: 'nqc/nqc_1nqd.htm'
    ),
    (
     Name: 'SetWorldNote';
     Value: 'nqc/nqc_1qat.htm'
    ),
    (
     Name: 'expressions';
     Value: 'nqc/nqc_1qb7.htm'
    ),
    (
     Name: 'true';
     Value: 'nqc/nqc_1qb7.htm'
    ),
    (
     Name: 'false';
     Value: 'nqc/nqc_1qb7.htm'
    ),
    (
     Name: 'ANIMATION';
     Value: 'nqc/nqc_1sfi.htm'
    ),
    (
     Name: 'AnimateLED';
     Value: 'nqc/nqc_1smc.htm'
    ),
    (
     Name: 'SensorValueRaw';
     Value: 'nqc/nqc_1ttj.htm'
    ),
    (
     Name: 'WorldDirection';
     Value: 'nqc/nqc_1uem.htm'
    ),
    (
     Name: 'SetMessageWordParam';
     Value: 'nqc/nqc_1uzx.htm'
    ),
    (
     Name: 'for';
     Value: 'nqc/nqc_1wz6.htm'
    ),
    (
     Name: 'Fwd';
     Value: 'nqc/nqc_1xd0.htm'
    ),
    (
     Name: 'SetSerialChecksum';
     Value: 'nqc/nqc_1ynh.htm'
    ),
    (
     Name: 'BitSet';
     Value: 'nqc/nqc_1yno.htm'
    ),
    (
     Name: 'StopTask';
     Value: 'nqc/nqc_1zqj.htm'
    ),
    (
     Name: 'DefaultSerialComm';
     Value: 'nqc/nqc_1zql.htm'
    ),
    (
     Name: 'SetFloatDuringInactivePWM';
     Value: 'nqc/nqc_2019.htm'
    ),
    (
     Name: 'IncCounter';
     Value: 'nqc/nqc_21te.htm'
    ),
    (
     Name: 'contents';
     Value: 'nqc/nqc_21v7.htm'
    ),
    (
     Name: 'SetTaskSchedulingPriority';
     Value: 'nqc/nqc_229l.htm'
    ),
    (
     Name: 'DisableOutput';
     Value: 'nqc/nqc_22ic.htm'
    ),
    (
     Name: 'GetWorldShortID';
     Value: 'nqc/nqc_22sk.htm'
    ),
    (
     Name: 'FirmwareVersion';
     Value: 'nqc/nqc_233i.htm'
    ),
    (
     Name: '#define';
     Value: 'nqc/nqc_2351.htm'
    ),
    (
     Name: '#undef';
     Value: 'nqc/nqc_2351.htm'
    ),
    (
     Name: 'IgnoreMessagesCPU';
     Value: 'nqc/nqc_24qd.htm'
    ),
    (
     Name: 'ClearEvent';
     Value: 'nqc/nqc_25bo.htm'
    ),
    (
     Name: 'identifiers';
     Value: 'nqc/nqc_25ir.htm'
    ),
    (
     Name: 'keywords';
     Value: 'nqc/nqc_25ir.htm'
    ),
    (
     Name: 'SetSensorHysteresis';
     Value: 'nqc/nqc_26yb.htm'
    ),
    (
     Name: 'EnableOutput';
     Value: 'nqc/nqc_294k.htm'
    ),
    (
     Name: 'SetTargetNote';
     Value: 'nqc/nqc_2cbp.htm'
    ),
    (
     Name: 'outputs';
     Value: 'nqc/nqc_2dbn.htm'
    ),
    (
     Name: 'control structures';
     Value: 'nqc/nqc_2drn.htm'
    ),
    (
     Name: 'variables';
     Value: 'nqc/nqc_2egj.htm'
    ),
    (
     Name: 'operators';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: 'abs';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: 'sign';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '<<';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '>>';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '&amp;&amp;';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '||';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '<=';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '>=';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '++';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '--';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '?:';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '==';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: '!=';
     Value: 'nqc/nqc_2elv.htm'
    ),
    (
     Name: 'SetSerialBiPhase';
     Value: 'nqc/nqc_2exx.htm'
    ),
    (
     Name: 'LED';
     Value: 'nqc/nqc_2ffo.htm'
    ),
    (
     Name: 'WaitEffect';
     Value: 'nqc/nqc_2hf8.htm'
    ),
    (
     Name: 'reserve';
     Value: 'nqc/nqc_2hut.htm'
    ),
    (
     Name: '#pragma';
     Value: 'nqc/nqc_2hut.htm'
    ),
    (
     Name: 'messages';
     Value: 'nqc/nqc_2i43.htm'
    ),
    (
     Name: 'SendSpybotCtrlMessage';
     Value: 'nqc/nqc_2jol.htm'
    ),
    (
     Name: 'FindWorld';
     Value: 'nqc/nqc_2kx0.htm'
    ),
    (
     Name: 'REL_GT';
     Value: 'nqc/nqc_2kx0.htm'
    ),
    (
     Name: 'REL_LT';
     Value: 'nqc/nqc_2kx0.htm'
    ),
    (
     Name: 'REL_EQ';
     Value: 'nqc/nqc_2kx0.htm'
    ),
    (
     Name: 'REL_NE';
     Value: 'nqc/nqc_2kx0.htm'
    ),
    (
     Name: 'WorldAspect';
     Value: 'nqc/nqc_2ldg.htm'
    ),
    (
     Name: 'Off';
     Value: 'nqc/nqc_2oyu.htm'
    ),
    (
     Name: 'InvertOutput';
     Value: 'nqc/nqc_2pbo.htm'
    ),
    (
     Name: 'OpcodesPerTimeslice';
     Value: 'nqc/nqc_2pid.htm'
    ),
    (
     Name: 'SetPower';
     Value: 'nqc/nqc_2pma.htm'
    ),
    (
     Name: 'OUT_LOW';
     Value: 'nqc/nqc_2pma.htm'
    ),
    (
     Name: 'OUT_HALF';
     Value: 'nqc/nqc_2pma.htm'
    ),
    (
     Name: 'OUT_FULL';
     Value: 'nqc/nqc_2pma.htm'
    ),
    (
     Name: 'UnmuteSound';
     Value: 'nqc/nqc_2s4k.htm'
    ),
    (
     Name: 'Watch';
     Value: 'nqc/nqc_2s6g.htm'
    ),
    (
     Name: '#include';
     Value: 'nqc/nqc_2s85.htm'
    ),
    (
     Name: 'switch';
     Value: 'nqc/nqc_2sh4.htm'
    ),
    (
     Name: 'case';
     Value: 'nqc/nqc_2sh4.htm'
    ),
    (
     Name: 'default';
     Value: 'nqc/nqc_2sh4.htm'
    ),
    (
     Name: 'Pop';
     Value: 'nqc/nqc_2skw.htm'
    ),
    (
     Name: 'SetRandomSeed';
     Value: 'nqc/nqc_2v1g.htm'
    ),
    (
     Name: 'SetRCTxChannel';
     Value: 'nqc/nqc_2w4s.htm'
    ),
    (
     Name: 'monitor';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_1_PRESSED';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_1_RELEASED';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_2_PRESSED';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_2_RELEASED';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_LIGHT_HIGH';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_LIGHT_NORMAL';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_LIGHT_LOW';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_LIGHT_CLICK';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_LIGHT_DOUBLECLICK';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_COUNTER_0';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_COUNTER_1';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_TIMER_0';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_TIMER_1';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_TIMER_2';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'EVENT_MESSAGE';
     Value: 'nqc/nqc_2wxe.htm'
    ),
    (
     Name: 'NQC';
     Value: 'nqc/nqc_2xgl.htm'
    ),
    (
     Name: 'guide';
     Value: 'nqc/nqc_2xgl.htm'
    ),
    (
     Name: 'programmer';
     Value: 'nqc/nqc_2xgl.htm'
    ),
    (
     Name: 'dave baum';
     Value: 'nqc/nqc_2xgl.htm'
    ),
    (
     Name: 'sensors';
     Value: 'nqc/nqc_2yer.htm'
    ),
    (
     Name: 'sensors, types';
     Value: 'nqc/nqc_2yer.htm'
    ),
    (
     Name: 'sensors, modes';
     Value: 'nqc/nqc_2yer.htm'
    ),
    (
     Name: 'Rev';
     Value: 'nqc/nqc_2yeu.htm'
    ),
    (
     Name: 'StackSize';
     Value: 'nqc/nqc_2zxh.htm'
    ),
    (
     Name: 'Set';
     Value: 'nqc/nqc_31kk.htm'
    ),
    (
     Name: 'SetSensorMode';
     Value: 'nqc/nqc_3279.htm'
    ),
    (
     Name: 'SENSOR_MODE_RAW';
     Value: 'nqc/nqc_3279.htm'
    ),
    (
     Name: 'SENSOR_MODE_BOOL';
     Value: 'nqc/nqc_3279.htm'
    ),
    (
     Name: 'SENSOR_MODE_EDGE';
     Value: 'nqc/nqc_3279.htm'
    ),
    (
     Name: 'SENSOR_MODE_PULSE';
     Value: 'nqc/nqc_3279.htm'
    ),
    (
     Name: 'SENSOR_MODE_PERCENT';
     Value: 'nqc/nqc_3279.htm'
    ),
    (
     Name: 'SENSOR_MODE_FAHRENHEIT';
     Value: 'nqc/nqc_3279.htm'
    ),
    (
     Name: 'SENSOR_MODE_CELSIUS';
     Value: 'nqc/nqc_3279.htm'
    ),
    (
     Name: 'SENSOR_MODE_ROTATION';
     Value: 'nqc/nqc_3279.htm'
    ),
    (
     Name: 'outputs';
     Value: 'nqc/nqc_32er.htm'
    ),
    (
     Name: 'outputs, spybotics';
     Value: 'nqc/nqc_32er.htm'
    ),
    (
     Name: 'EEPROM';
     Value: 'nqc/nqc_32ul.htm'
    ),
    (
     Name: 'SelectDisplay';
     Value: 'nqc/nqc_32ux.htm'
    ),
    (
     Name: 'DISPLAY_WATCH';
     Value: 'nqc/nqc_32ux.htm'
    ),
    (
     Name: 'DISPLAY_SENSOR_1';
     Value: 'nqc/nqc_32ux.htm'
    ),
    (
     Name: 'DISPLAY_SENSOR_2';
     Value: 'nqc/nqc_32ux.htm'
    ),
    (
     Name: 'DISPLAY_SENSOR_3';
     Value: 'nqc/nqc_32ux.htm'
    ),
    (
     Name: 'DISPLAY_OUT_A';
     Value: 'nqc/nqc_32ux.htm'
    ),
    (
     Name: 'DISPLAY_OUT_B';
     Value: 'nqc/nqc_32ux.htm'
    ),
    (
     Name: 'DISPLAY_OUT_C';
     Value: 'nqc/nqc_32ux.htm'
    ),
    (
     Name: 'DISPLAY_USER';
     Value: 'nqc/nqc_32ux.htm'
    ),
    (
     Name: 'DISPLAY_EXCEPTION';
     Value: 'nqc/nqc_32ux.htm'
    ),
    (
     Name: 'SetDefaultSerialComm';
     Value: 'nqc/nqc_344t.htm'
    ),
    (
     Name: 'InitSpybotComm';
     Value: 'nqc/nqc_3771.htm'
    ),
    (
     Name: 'SensorMode';
     Value: 'nqc/nqc_3811.htm'
    ),
    (
     Name: 'FixedWaitEffect';
     Value: 'nqc/nqc_38dw.htm'
    ),
    (
     Name: 'RCTxChannel';
     Value: 'nqc/nqc_392k.htm'
    ),
    (
     Name: 'events';
     Value: 'nqc/nqc_39mb.htm'
    ),
    (
     Name: 'events, RCX2';
     Value: 'nqc/nqc_39mb.htm'
    ),
    (
     Name: 'SetSensorType';
     Value: 'nqc/nqc_3aat.htm'
    ),
    (
     Name: 'SENSOR_TYPE_NONE';
     Value: 'nqc/nqc_3aat.htm'
    ),
    (
     Name: 'SENSOR_TYPE_TOUCH';
     Value: 'nqc/nqc_3aat.htm'
    ),
    (
     Name: 'SENSOR_TYPE_TEMPERATURE';
     Value: 'nqc/nqc_3aat.htm'
    ),
    (
     Name: 'SENSOR_TYPE_LIGHT';
     Value: 'nqc/nqc_3aat.htm'
    ),
    (
     Name: 'SENSOR_TYPE_ROTATION';
     Value: 'nqc/nqc_3aat.htm'
    ),
    (
     Name: 'conditional compilation';
     Value: 'nqc/nqc_3acu.htm'
    ),
    (
     Name: 'SendSpybotMessage';
     Value: 'nqc/nqc_3ajp.htm'
    ),
    (
     Name: 'SelectProgram';
     Value: 'nqc/nqc_3bjh.htm'
    ),
    (
     Name: 'SetInterCharTimeout';
     Value: 'nqc/nqc_3d10.htm'
    ),
    (
     Name: 'PingID';
     Value: 'nqc/nqc_3e78.htm'
    ),
    (
     Name: 'SetCounterLimit';
     Value: 'nqc/nqc_3f78.htm'
    ),
    (
     Name: 'SensorType';
     Value: 'nqc/nqc_3g4l.htm'
    ),
    (
     Name: 'SetLCDRefreshRate';
     Value: 'nqc/nqc_3g4m.htm'
    ),
    (
     Name: '@';
     Value: 'nqc/nqc_3gl0.htm'
    ),
    (
     Name: 'do';
     Value: 'nqc/nqc_3gq7.htm'
    ),
    (
     Name: 'general features';
     Value: 'nqc/nqc_3gvg.htm'
    ),
    (
     Name: 'if';
     Value: 'nqc/nqc_3gyu.htm'
    ),
    (
     Name: 'else';
     Value: 'nqc/nqc_3gyu.htm'
    ),
    (
     Name: 'On';
     Value: 'nqc/nqc_3h9q.htm'
    ),
    (
     Name: 'SetSensorLowerLimit';
     Value: 'nqc/nqc_3hh0.htm'
    ),
    (
     Name: 'SensorScanCount';
     Value: 'nqc/nqc_3ilw.htm'
    ),
    (
     Name: 'PingInterval';
     Value: 'nqc/nqc_3j1o.htm'
    ),
    (
     Name: 'RCTxMode';
     Value: 'nqc/nqc_3kv9.htm'
    ),
    (
     Name: 'statements';
     Value: 'nqc/nqc_3omr.htm'
    ),
    (
     Name: 'ClearTimer';
     Value: 'nqc/nqc_3pde.htm'
    ),
    (
     Name: 'SendSpybotPing';
     Value: 'nqc/nqc_3q7b.htm'
    ),
    (
     Name: 'access control';
     Value: 'nqc/nqc_3quk.htm'
    ),
    (
     Name: 'CurrentTask';
     Value: 'nqc/nqc_3qy3.htm'
    ),
    (
     Name: 'Program';
     Value: 'nqc/nqc_3r1p.htm'
    ),
    (
     Name: 'data';
     Value: 'nqc/nqc_3v53.htm'
    ),
    (
     Name: 'logging';
     Value: 'nqc/nqc_3v53.htm'
    ),
    (
     Name: 'DefaultSerialPacket';
     Value: 'nqc/nqc_3vp0.htm'
    ),
    (
     Name: 'BitClear';
     Value: 'nqc/nqc_3vzm.htm'
    ),
    (
     Name: 'DecCounter';
     Value: 'nqc/nqc_3woi.htm'
    ),
    (
     Name: 'TaskSchedulingPriority()';
     Value: 'nqc/nqc_3yg9.htm'
    ),
    (
     Name: 'expressions';
     Value: 'nqc/nqc_40hf.htm'
    ),
    (
     Name: 'SetNoPowerDownOnAC';
     Value: 'nqc/nqc_40wz.htm'
    ),
    (
     Name: 'ExpandedRemoteMessages';
     Value: 'nqc/nqc_4303.htm'
    ),
    (
     Name: 'CurrentTaskID';
     Value: 'nqc/nqc_436s.htm'
    ),
    (
     Name: 'repeat';
     Value: 'nqc/nqc_43hw.htm'
    ),
    (
     Name: 'ExternalMotorRunning';
     Value: 'nqc/nqc_43mv.htm'
    ),
    (
     Name: 'BatteryLevel';
     Value: 'nqc/nqc_465o.htm'
    ),
    (
     Name: 'SetSleepTime';
     Value: 'nqc/nqc_47fp.htm'
    ),
    (
     Name: 'MotorPowerSigned';
     Value: 'nqc/nqc_4810.htm'
    ),
    (
     Name: 'SensorStartupDelay';
     Value: 'nqc/nqc_49tl.htm'
    ),
    (
     Name: 'serial';
     Value: 'nqc/nqc_4awc.htm'
    ),
    (
     Name: 'program initialization';
     Value: 'nqc/nqc_4e9a.htm'
    ),
    (
     Name: 'Random';
     Value: 'nqc/nqc_4ey5.htm'
    ),
    (
     Name: 'BasicMove';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'MOVE_BASIC_FORWARD';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'MOVE_BASIC_BACKWARD';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'MOVE_BASIC_SPIN_LEFT';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'MOVE_BASIC_SPIN_RIGHT';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'MOVE_BASIC_TURN_LEFT';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'MOVE_BASIC_TURN_RIGHT';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'MOVE_BASIC_AVOID_LEFT';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'MOVE_BASIC_AVOID_RIGHT';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'MOVE_BASIC_REST';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'MOVE_BASIC_STOP';
     Value: 'nqc/nqc_4f6t.htm'
    ),
    (
     Name: 'sensors';
     Value: 'nqc/nqc_4far.htm'
    ),
    (
     Name: 'StartTask';
     Value: 'nqc/nqc_4gff.htm'
    ),
    (
     Name: 'DebugTaskMode';
     Value: 'nqc/nqc_4gh1.htm'
    ),
    (
     Name: 'SerialBiPhase';
     Value: 'nqc/nqc_4i3p.htm'
    ),
    (
     Name: 'Vibrato';
     Value: 'nqc/nqc_4igf.htm'
    ),
    (
     Name: 'SetSerialPacket';
     Value: 'nqc/nqc_4ilw.htm'
    ),
    (
     Name: 'SERIAL_PACKET_DEFAULT';
     Value: 'nqc/nqc_4ilw.htm'
    ),
    (
     Name: 'SERIAL_PACKET_PREAMBLE';
     Value: 'nqc/nqc_4ilw.htm'
    ),
    (
     Name: 'SERIAL_PACKET_NEGATED';
     Value: 'nqc/nqc_4ilw.htm'
    ),
    (
     Name: 'SERIAL_PACKET_CHECKSUM';
     Value: 'nqc/nqc_4ilw.htm'
    ),
    (
     Name: 'SERIAL_PACKET_RCX';
     Value: 'nqc/nqc_4ilw.htm'
    ),
    (
     Name: 'SensorValue';
     Value: 'nqc/nqc_4omd.htm'
    ),
    (
     Name: 'SetClickTime';
     Value: 'nqc/nqc_4opx.htm'
    ),
    (
     Name: 'FancyMove';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_ZIGZAG';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_SHAKE';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_SCAN';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_STEP';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_STEP_BACK';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_SEARCH';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_FAKE_LEFT';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_RAKE_RIGHT';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_BUG_FORWARD';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_LAZY';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_WALK';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_WALK_BACK';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'MOVE_FANCY_DANCE';
     Value: 'nqc/nqc_4rxh.htm'
    ),
    (
     Name: 'SOUNDEFFECT';
     Value: 'nqc/nqc_4tdg.htm'
    ),
    (
     Name: 'SetEventType';
     Value: 'nqc/nqc_4tph.htm'
    ),
    (
     Name: 'DatalogByte';
     Value: 'nqc/nqc_4wh1.htm'
    ),
    (
     Name: 'BeaconControl';
     Value: 'nqc/nqc_4wmk.htm'
    ),
    (
     Name: 'SendSpybotCtrlPingMsg';
     Value: 'nqc/nqc_4wtj.htm'
    ),
    (
     Name: 'outputs';
     Value: 'nqc/nqc_4xf0.htm'
    ),
    (
     Name: 'outputs, global control';
     Value: 'nqc/nqc_4xf0.htm'
    ),
    (
     Name: 'SetTaskAcquirePriority';
     Value: 'nqc/nqc_4xrt.htm'
    ),
    (
     Name: 'SetEvent';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_PRESSED';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_RELEASED';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_PULSE';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_EDGE';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_FASTCHANGE';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_LOW';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_NORMAL';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_HIGH';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_CLICK';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_DOUBLECLICK';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'EVENT_TYPE_MESSAGE';
     Value: 'nqc/nqc_4xv8.htm'
    ),
    (
     Name: 'SetMessage';
     Value: 'nqc/nqc_50o5.htm'
    ),
    (
     Name: 'OutputStatus';
     Value: 'nqc/nqc_512r.htm'
    ),
    (
     Name: 'SetMaxPower';
     Value: 'nqc/nqc_519u.htm'
    ),
    (
     Name: 'Volume';
     Value: 'nqc/nqc_51d1.htm'
    ),
    (
     Name: 'SetSpybotPing';
     Value: 'nqc/nqc_5207.htm'
    ),
    (
     Name: 'Drive';
     Value: 'nqc/nqc_52p1.htm'
    ),
    (
     Name: 'OUT_L';
     Value: 'nqc/nqc_52p1.htm'
    ),
    (
     Name: 'OUT_R';
     Value: 'nqc/nqc_52p1.htm'
    ),
    (
     Name: 'OUT_X';
     Value: 'nqc/nqc_52p1.htm'
    ),
    (
     Name: 'SENSOR_L';
     Value: 'nqc/nqc_52p1.htm'
    ),
    (
     Name: 'SENSOR_M';
     Value: 'nqc/nqc_52p1.htm'
    ),
    (
     Name: 'SENSOR_R';
     Value: 'nqc/nqc_52p1.htm'
    ),
    (
     Name: 'SetScoutMode';
     Value: 'nqc/nqc_5339.htm'
    ),
    (
     Name: 'SetSerialComm';
     Value: 'nqc/nqc_53jh.htm'
    ),
    (
     Name: 'SERIAL_COMM_DEFAULT';
     Value: 'nqc/nqc_53jh.htm'
    ),
    (
     Name: 'SERIAL_COMM_4800';
     Value: 'nqc/nqc_53jh.htm'
    ),
    (
     Name: 'SERIAL_COMM_DUTY25';
     Value: 'nqc/nqc_53jh.htm'
    ),
    (
     Name: 'SERIAL_COMM_76KHZ';
     Value: 'nqc/nqc_53jh.htm'
    ),
    (
     Name: 'touch';
     Value: 'nqc/nqc_54dv.htm'
    ),
    (
     Name: 'light';
     Value: 'nqc/nqc_54dv.htm'
    ),
    (
     Name: 'sensors';
     Value: 'nqc/nqc_54dv.htm'
    ),
    (
     Name: 'sensors, touch';
     Value: 'nqc/nqc_54dv.htm'
    ),
    (
     Name: 'sensors, light';
     Value: 'nqc/nqc_54dv.htm'
    ),
    (
     Name: 'sensors, spybotics';
     Value: 'nqc/nqc_54dv.htm'
    ),
    (
     Name: 'Target';
     Value: 'nqc/nqc_560k.htm'
    ),
    (
     Name: 'SPY_TARGETID';
     Value: 'nqc/nqc_560k.htm'
    ),
    (
     Name: 'SPY_NOTE';
     Value: 'nqc/nqc_560k.htm'
    ),
    (
     Name: 'SPY_LINKID';
     Value: 'nqc/nqc_560k.htm'
    ),
    (
     Name: 'SPY_RANGE';
     Value: 'nqc/nqc_560k.htm'
    ),
    (
     Name: 'SPY_DIRECTION';
     Value: 'nqc/nqc_560k.htm'
    ),
    (
     Name: 'SPY_ASPECT';
     Value: 'nqc/nqc_560k.htm'
    ),
    (
     Name: 'SPY_INFO';
     Value: 'nqc/nqc_560k.htm'
    ),
    (
     Name: 'SPY_SHORTID';
     Value: 'nqc/nqc_560k.htm'
    ),
    (
     Name: 'SensorRefreshRate';
     Value: 'nqc/nqc_56cl.htm'
    ),
    (
     Name: 'SetMotorBrakePower';
     Value: 'nqc/nqc_56eq.htm'
    ),
    (
     Name: 'GlobalOutputStatus';
     Value: 'nqc/nqc_56lv.htm'
    ),
    (
     Name: 'GetWorldRange';
     Value: 'nqc/nqc_56w5.htm'
    ),
    (
     Name: 'RANGE_NOWHERE';
     Value: 'nqc/nqc_56w5.htm'
    ),
    (
     Name: 'RANGE_ANYWHERE';
     Value: 'nqc/nqc_56w5.htm'
    ),
    (
     Name: 'RANGE_THERE';
     Value: 'nqc/nqc_56w5.htm'
    ),
    (
     Name: 'RANGE_HERE';
     Value: 'nqc/nqc_56w5.htm'
    ),
    (
     Name: 'SetPlaySounds';
     Value: 'nqc/nqc_57cj.htm'
    ),
    (
     Name: 'PowerDownDelay';
     Value: 'nqc/nqc_586x.htm'
    ),
    (
     Name: 'Message';
     Value: 'nqc/nqc_595x.htm'
    ),
    (
     Name: 'SerialComm';
     Value: 'nqc/nqc_59d9.htm'
    ),
    (
     Name: 'SetEEPROM';
     Value: 'nqc/nqc_59gt.htm'
    ),
    (
     Name: 'ActiveEvents';
     Value: 'nqc/nqc_59pv.htm'
    ),
    (
     Name: 'GetWorldLinkID';
     Value: 'nqc/nqc_5a5g.htm'
    ),
    (
     Name: 'cybermaster specific features';
     Value: 'nqc/nqc_5cir.htm'
    ),
    (
     Name: 'PlaySounds';
     Value: 'nqc/nqc_5d6b.htm'
    ),
    (
     Name: 'InterCharTimeout';
     Value: 'nqc/nqc_5dis.htm'
    ),
    (
     Name: 'SetAnimation';
     Value: 'nqc/nqc_5dpq.htm'
    ),
    (
     Name: 'ANIMATION';
     Value: 'nqc/nqc_5dpq.htm'
    ),
    (
     Name: 'ANIMATION_SCAN';
     Value: 'nqc/nqc_5dpq.htm'
    ),
    (
     Name: 'ANIMATION_SPARKLE';
     Value: 'nqc/nqc_5dpq.htm'
    ),
    (
     Name: 'ANIMATION_FLASH';
     Value: 'nqc/nqc_5dpq.htm'
    ),
    (
     Name: 'ANIMATION_RED_TO_GREEN';
     Value: 'nqc/nqc_5dpq.htm'
    ),
    (
     Name: 'ANIMATION_GREEN_TO_RED';
     Value: 'nqc/nqc_5dpq.htm'
    ),
    (
     Name: 'ANIMATION_POINT_FORWARD';
     Value: 'nqc/nqc_5dpq.htm'
    ),
    (
     Name: 'ANIMATION_ALARM';
     Value: 'nqc/nqc_5dpq.htm'
    ),
    (
     Name: 'ANIMATION_THINKING';
     Value: 'nqc/nqc_5dpq.htm'
    ),
    (
     Name: 'EventSrc';
     Value: 'nqc/nqc_5e1v.htm'
    ),
    (
     Name: 'ES_BELOW_LOWER';
     Value: 'nqc/nqc_5e1v.htm'
    ),
    (
     Name: 'ES_BETWEEN';
     Value: 'nqc/nqc_5e1v.htm'
    ),
    (
     Name: 'ES_ABOVE_UPPER';
     Value: 'nqc/nqc_5e1v.htm'
    ),
    (
     Name: 'ES_UNDETERMINED';
     Value: 'nqc/nqc_5e1v.htm'
    ),
    (
     Name: 'functions';
     Value: 'nqc/nqc_5e9f.htm'
    ),
    (
     Name: 'ClearMessage';
     Value: 'nqc/nqc_5fol.htm'
    ),
    (
     Name: 'SetGlobalOutput';
     Value: 'nqc/nqc_5fsk.htm'
    ),
    (
     Name: 'CommErrorsFraming';
     Value: 'nqc/nqc_5giv.htm'
    ),
    (
     Name: 'PingData';
     Value: 'nqc/nqc_5iox.htm'
    ),
    (
     Name: 'MuteSound';
     Value: 'nqc/nqc_5kh0.htm'
    ),
    (
     Name: 'SerialChecksum';
     Value: 'nqc/nqc_5kx9.htm'
    ),
    (
     Name: 'NoPowerDownOnAC';
     Value: 'nqc/nqc_5mar.htm'
    ),
    (
     Name: 'variable declaration';
     Value: 'nqc/nqc_5myb.htm'
    ),
    (
     Name: 'SendSpybotPingMsg';
     Value: 'nqc/nqc_5non.htm'
    ),
    (
     Name: 'SetClickCounter';
     Value: 'nqc/nqc_5oaa.htm'
    ),
    (
     Name: 'RepeatAnimation';
     Value: 'nqc/nqc_5rn2.htm'
    ),
    (
     Name: 'events';
     Value: 'nqc/nqc_5v5f.htm'
    ),
    (
     Name: 'events, scout';
     Value: 'nqc/nqc_5v5f.htm'
    ),
    (
     Name: 'FloatDuringInactivePWM';
     Value: 'nqc/nqc_5v71.htm'
    ),
    (
     Name: 'introduction';
     Value: 'nqc/nqc_5w32.htm'
    ),
    (
     Name: 'language';
     Value: 'nqc/nqc_5w32.htm'
    ),
    (
     Name: 'MSTimer';
     Value: 'nqc/nqc_5wky.htm'
    ),
    (
     Name: 'conditions';
     Value: 'nqc/nqc_5xpv.htm'
    ),
    (
     Name: 'SensorRefreshState';
     Value: 'nqc/nqc_5zol.htm'
    ),
    (
     Name: 'DatalogType';
     Value: 'nqc/nqc_615x.htm'
    ),
    (
     Name: 'counters';
     Value: 'nqc/nqc_62k3.htm'
    ),
    (
     Name: 'StopAllTasks';
     Value: 'nqc/nqc_62pf.htm'
    ),
    (
     Name: 'SetSensorStartupDelay';
     Value: 'nqc/nqc_633t.htm'
    ),
    (
     Name: 'arrays';
     Value: 'nqc/nqc_63w3.htm'
    ),
    (
     Name: 'SendVLL';
     Value: 'nqc/nqc_64fg.htm'
    ),
    (
     Name: 'UploadDatalog';
     Value: 'nqc/nqc_64h3.htm'
    ),
    (
     Name: 'break';
     Value: 'nqc/nqc_64kl.htm'
    ),
    (
     Name: 'continue';
     Value: 'nqc/nqc_64kl.htm'
    ),
    (
     Name: 'SendRCMessage';
     Value: 'nqc/nqc_661x.htm'
    ),
    (
     Name: 'ImmediateBatteryLevel';
     Value: 'nqc/nqc_6624.htm'
    ),
    (
     Name: 'SetSerialChannel';
     Value: 'nqc/nqc_67cc.htm'
    ),
    (
     Name: 'SendRCXMessage';
     Value: 'nqc/nqc_69b9.htm'
    ),
    (
     Name: 'SetIndirectVar';
     Value: 'nqc/nqc_6a42.htm'
    ),
    (
     Name: 'SlowDownMove';
     Value: 'nqc/nqc_6acl.htm'
    ),
    (
     Name: 'MOVE_SLOWDOWN_FORWARD';
     Value: 'nqc/nqc_6acl.htm'
    ),
    (
     Name: 'MOVE_SLOWDOWN_BACKWARD';
     Value: 'nqc/nqc_6acl.htm'
    ),
    (
     Name: 'MOVE_SLOWDOWN_SPIN_LEFT';
     Value: 'nqc/nqc_6acl.htm'
    ),
    (
     Name: 'MOVE_SLOWDOWN_SPIN_RIGHT';
     Value: 'nqc/nqc_6acl.htm'
    ),
    (
     Name: 'SetSensorRefreshRate';
     Value: 'nqc/nqc_6aqt.htm'
    ),
    (
     Name: 'SystemPreambleSize';
     Value: 'nqc/nqc_6c11.htm'
    ),
    (
     Name: 'CommErrorsTimeout';
     Value: 'nqc/nqc_6cac.htm'
    ),
    (
     Name: 'GlobalVar';
     Value: 'nqc/nqc_6cdu.htm'
    ),
    (
     Name: 'communication';
     Value: 'nqc/nqc_6coe.htm'
    ),
    (
     Name: 'SetMotorPower8';
     Value: 'nqc/nqc_6coo.htm'
    ),
    (
     Name: 'CreateDatalog';
     Value: 'nqc/nqc_6duv.htm'
    ),
    (
     Name: 'SetTimer';
     Value: 'nqc/nqc_6hwy.htm'
    ),
    (
     Name: 'RxMessageChannel';
     Value: 'nqc/nqc_6kdo.htm'
    ),
    (
     Name: 'SetEventFeedback';
     Value: 'nqc/nqc_6l63.htm'
    ),
    (
     Name: 'SerialLinkStatus';
     Value: 'nqc/nqc_6mk3.htm'
    ),
    (
     Name: 'SpeedUpMove';
     Value: 'nqc/nqc_6msl.htm'
    ),
    (
     Name: 'MOVE_SPEEDUP_FORWARD';
     Value: 'nqc/nqc_6msl.htm'
    ),
    (
     Name: 'MOVE_SPEEDUP_BACKWARD';
     Value: 'nqc/nqc_6msl.htm'
    ),
    (
     Name: 'MOVE_SPEEDUP_SPIN_LEFT';
     Value: 'nqc/nqc_6msl.htm'
    ),
    (
     Name: 'MOVE_SPEEDUP_SPIN_RIGHT';
     Value: 'nqc/nqc_6msl.htm'
    ),
    (
     Name: 'Indirect';
     Value: 'nqc/nqc_6n5g.htm'
    ),
    (
     Name: 'until';
     Value: 'nqc/nqc_6n8s.htm'
    ),
    (
     Name: 'ClearWorld';
     Value: 'nqc/nqc_6nac.htm'
    ),
    (
     Name: 'whitespace';
     Value: 'nqc/nqc_6nj9.htm'
    ),
    (
     Name: '#if';
     Value: 'nqc/nqc_6nn4.htm'
    ),
    (
     Name: '#ifdef';
     Value: 'nqc/nqc_6nn4.htm'
    ),
    (
     Name: '#ifndef';
     Value: 'nqc/nqc_6nn4.htm'
    ),
    (
     Name: '#else';
     Value: 'nqc/nqc_6nn4.htm'
    ),
    (
     Name: '#elif';
     Value: 'nqc/nqc_6nn4.htm'
    ),
    (
     Name: '#endif';
     Value: 'nqc/nqc_6nn4.htm'
    ),
    (
     Name: 'defined';
     Value: 'nqc/nqc_6nn4.htm'
    ),
    (
     Name: 'ResetMSTimer';
     Value: 'nqc/nqc_6o1e.htm'
    ),
    (
     Name: '#define';
     Value: 'nqc/nqc_6ov9.htm'
    ),
    (
     Name: 'access control';
     Value: 'nqc/nqc_6pdf.htm'
    ),
    (
     Name: 'events';
     Value: 'nqc/nqc_6pdf.htm'
    ),
    (
     Name: 'MotorPower8';
     Value: 'nqc/nqc_6pmg.htm'
    ),
    (
     Name: 'assignment';
     Value: 'nqc/nqc_6po4.htm'
    ),
    (
     Name: 'assignment';
     Value: 'nqc/nqc_6qyc.htm'
    ),
    (
     Name: 'FastTimer';
     Value: 'nqc/nqc_6r76.htm'
    ),
    (
     Name: 'MotorBrakePower';
     Value: 'nqc/nqc_6rsi.htm'
    ),
    (
     Name: 'Event';
     Value: 'nqc/nqc_6s50.htm'
    ),
    (
     Name: 'SendSpybotCtrlMsg';
     Value: 'nqc/nqc_6v53.htm'
    ),
    (
     Name: 'Wait';
     Value: 'nqc/nqc_6wj8.htm'
    ),
    (
     Name: 'SENSOR_1';
     Value: 'nqc/nqc_6ynl.htm'
    ),
    (
     Name: 'SENSOR_2';
     Value: 'nqc/nqc_6ynl.htm'
    ),
    (
     Name: 'SENSOR_3';
     Value: 'nqc/nqc_6ynl.htm'
    ),
    (
     Name: 'CurrentEvents';
     Value: 'nqc/nqc_6z1v.htm'
    ),
    (
     Name: 'other statements';
     Value: 'nqc/nqc_701f.htm'
    ),
    (
     Name: 'SendSpybotCtrlPingMessage';
     Value: 'nqc/nqc_70h1.htm'
    ),
    (
     Name: 'Gate';
     Value: 'nqc/nqc_70px.htm'
    ),
    (
     Name: 'LCDRefreshRate';
     Value: 'nqc/nqc_72ed.htm'
    ),
    (
     Name: 'RxMessageID';
     Value: 'nqc/nqc_73c4.htm'
    ),
    (
     Name: 'Negate';
     Value: 'nqc/nqc_75d1.htm'
    ),
    (
     Name: 'GetWorld';
     Value: 'nqc/nqc_778k.htm'
    ),
    (
     Name: 'InitRCComm';
     Value: 'nqc/nqc_77l9.htm'
    ),
    (
     Name: 'numerical constants';
     Value: 'nqc/nqc_77qr.htm'
    ),
    (
     Name: 'constants';
     Value: 'nqc/nqc_77qr.htm'
    ),
    (
     Name: 'SetVolume';
     Value: 'nqc/nqc_77z9.htm'
    ),
    (
     Name: 'SetSensorClickTime';
     Value: 'nqc/nqc_789x.htm'
    ),
    (
     Name: 'scout specific features';
     Value: 'nqc/nqc_78o3.htm'
    ),
    (
     Name: 'sound';
     Value: 'nqc/nqc_7azo.htm'
    ),
    (
     Name: 'SetMessageVariableParam';
     Value: 'nqc/nqc_7bcd.htm'
    ),
    (
     Name: 'SendMessage';
     Value: 'nqc/nqc_7bj9.htm'
    ),
    (
     Name: 'api';
     Value: 'nqc/nqc_7ca1.htm'
    ),
    (
     Name: 'outputs';
     Value: 'nqc/nqc_7cf9.htm'
    ),
    (
     Name: 'outputs, convenience calls';
     Value: 'nqc/nqc_7cf9.htm'
    ),
    (
     Name: 'asm';
     Value: 'nqc/nqc_7cfh.htm'
    ),
    (
     Name: 'OnWait';
     Value: 'nqc/nqc_7e44.htm'
    ),
    (
     Name: '#include';
     Value: 'nqc/nqc_7eud.htm'
    ),
    (
     Name: 'acquire';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'catch';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'ACQUIRE_OUT_A';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'ACQUIRE_OUT_B';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'ACQUIRE_OUT_C';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'ACQUIRE_SOUND';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'ACQUIRE_USER_1';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'ACQUIRE_USER_2';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'ACQUIRE_USER_3';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'ACQUIRE_USER_4';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'ACQUIRE_LED';
     Value: 'nqc/nqc_7git.htm'
    ),
    (
     Name: 'TachoSpeed';
     Value: 'nqc/nqc_7gro.htm'
    ),
    (
     Name: 'SetRxMessageLock';
     Value: 'nqc/nqc_7hd7.htm'
    ),
    (
     Name: 'MSG_NONE';
     Value: 'nqc/nqc_7hd7.htm'
    ),
    (
     Name: 'MSG_IR';
     Value: 'nqc/nqc_7hd7.htm'
    ),
    (
     Name: 'MSG_PC';
     Value: 'nqc/nqc_7hd7.htm'
    ),
    (
     Name: 'light';
     Value: 'nqc/nqc_7icy.htm'
    ),
    (
     Name: 'sensors';
     Value: 'nqc/nqc_7icy.htm'
    ),
    (
     Name: 'sensors, light';
     Value: 'nqc/nqc_7icy.htm'
    ),
    (
     Name: 'sensors, scout';
     Value: 'nqc/nqc_7icy.htm'
    ),
    (
     Name: 'SerialPacket';
     Value: 'nqc/nqc_7ino.htm'
    ),
    (
     Name: 'SetExpandedSubroutines';
     Value: 'nqc/nqc_7k8j.htm'
    ),
    (
     Name: 'data sources';
     Value: 'nqc/nqc_7lbn.htm'
    ),
    (
     Name: 'SetStack';
     Value: 'nqc/nqc_7nhn.htm'
    ),
    (
     Name: 'subroutines';
     Value: 'nqc/nqc_7nlf.htm'
    ),
    (
     Name: 'SetWatchFormat';
     Value: 'nqc/nqc_7nlg.htm'
    ),
    (
     Name: 'Toggle';
     Value: 'nqc/nqc_7opx.htm'
    ),
    (
     Name: 'LinkID';
     Value: 'nqc/nqc_7ov8.htm'
    ),
    (
     Name: 'ID_NONE';
     Value: 'nqc/nqc_7ov8.htm'
    ),
    (
     Name: 'ID_CTRL1';
     Value: 'nqc/nqc_7ov8.htm'
    ),
    (
     Name: 'ID_CTRL2';
     Value: 'nqc/nqc_7ov8.htm'
    ),
    (
     Name: 'ID_CTRL3';
     Value: 'nqc/nqc_7ov8.htm'
    ),
    (
     Name: 'ID_CTRL4';
     Value: 'nqc/nqc_7ov8.htm'
    ),
    (
     Name: 'ID_CTRL5';
     Value: 'nqc/nqc_7ov8.htm'
    ),
    (
     Name: 'ID_CTRL6';
     Value: 'nqc/nqc_7ov8.htm'
    ),
    (
     Name: 'ID_PC';
     Value: 'nqc/nqc_7ov8.htm'
    ),
    (
     Name: 'GetWorldAspect';
     Value: 'nqc/nqc_7ruc.htm'
    ),
    (
     Name: 'ASPECT_FRONT_LEFT';
     Value: 'nqc/nqc_7ruc.htm'
    ),
    (
     Name: 'ASPECT_FRONT';
     Value: 'nqc/nqc_7ruc.htm'
    ),
    (
     Name: 'ASPECT_FRONT_RIGHT';
     Value: 'nqc/nqc_7ruc.htm'
    ),
    (
     Name: 'ASPECT_BACK_RIGHT';
     Value: 'nqc/nqc_7ruc.htm'
    ),
    (
     Name: 'ASPECT_BACK';
     Value: 'nqc/nqc_7ruc.htm'
    ),
    (
     Name: 'ASPECT_BACK_LEFT';
     Value: 'nqc/nqc_7ruc.htm'
    ),
    (
     Name: 'PlayTone';
     Value: 'nqc/nqc_7s9x.htm'
    ),
    (
     Name: 'WaitMS';
     Value: 'nqc/nqc_7sj7.htm'
    ),
    (
     Name: 'StackAddress';
     Value: 'nqc/nqc_7u0j.htm'
    ),
    (
     Name: 'SetGlobalDirection';
     Value: 'nqc/nqc_7uem.htm'
    ),
    (
     Name: 'SetUserDisplay';
     Value: 'nqc/nqc_7um1.htm'
    ),
    (
     Name: 'OnFor';
     Value: 'nqc/nqc_7v02.htm'
    ),
    (
     Name: 'OnFwd';
     Value: 'nqc/nqc_7vdw.htm'
    ),
    (
     Name: 'SetScoutRules';
     Value: 'nqc/nqc_7voz.htm'
    ),
    (
     Name: 'return';
     Value: 'nqc/nqc_7zzi.htm'
    ),
    (
     Name: 'keywords';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: 'int';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: 'const';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: 'sub';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: 'task';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: '__sensor';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: '__type';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: '__event_src';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: 'inline';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: 'void';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: '__nolist';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: '__res';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: '__taskid';
     Value: 'nqc/nqc_806r.htm'
    ),
    (
     Name: 'WatchFormat';
     Value: 'nqc/nqc_80j8.htm'
    ),
    (
     Name: 'SetMotorTransitionDelay';
     Value: 'nqc/nqc_81bt.htm'
    ),
    (
     Name: 'ScoutRules';
     Value: 'nqc/nqc_81ir.htm'
    ),
    (
     Name: 'tasks';
     Value: 'nqc/nqc_8243.htm'
    ),
    (
     Name: 'SetRCMessage';
     Value: 'nqc/nqc_82at.htm'
    ),
    (
     Name: 'SerialPreambleLen';
     Value: 'nqc/nqc_82b2.htm'
    ),
    (
     Name: 'SelectSounds';
     Value: 'nqc/nqc_835f.htm'
    ),
    (
     Name: 'display';
     Value: 'nqc/nqc_84zd.htm'
    ),
    (
     Name: 'lcd';
     Value: 'nqc/nqc_84zd.htm'
    ),
    (
     Name: 'WorldNote';
     Value: 'nqc/nqc_850l.htm'
    ),
    (
     Name: 'SetSystemPreambleSize';
     Value: 'nqc/nqc_85b9.htm'
    ),
    (
     Name: 'System';
     Value: 'nqc/nqc_8625.htm'
    ),
    (
     Name: 'RxMessageIndex';
     Value: 'nqc/nqc_869k.htm'
    ),
    (
     Name: 'swan specific features';
     Value: 'nqc/nqc_86g3.htm'
    ),
    (
     Name: 'OnWaitDifferent';
     Value: 'nqc/nqc_886s.htm'
    ),
    (
     Name: 'SetTimerState';
     Value: 'nqc/nqc_88kl.htm'
    ),
    (
     Name: 'TIMER_RUNNING';
     Value: 'nqc/nqc_88kl.htm'
    ),
    (
     Name: 'TIMER_STOPPED';
     Value: 'nqc/nqc_88kl.htm'
    ),
    (
     Name: 'goto';
     Value: 'nqc/nqc_88z3.htm'
    ),
    (
     Name: 'SetSerialBaud';
     Value: 'nqc/nqc_89es.htm'
    ),
    (
     Name: 'timers';
     Value: 'nqc/nqc_89rn.htm'
    ),
    (
     Name: 'SerialChannel';
     Value: 'nqc/nqc_8ai4.htm'
    ),
    (
     Name: 'SensorValueBool';
     Value: 'nqc/nqc_8c30.htm'
    ),
    (
     Name: 'Timer';
     Value: 'nqc/nqc_8c6q.htm'
    ),
    (
     Name: 'T1';
     Value: 'nqc/nqc_8c6q.htm'
    ),
    (
     Name: 'T2';
     Value: 'nqc/nqc_8c6q.htm'
    ),
    (
     Name: 'T3';
     Value: 'nqc/nqc_8c6q.htm'
    ),
    (
     Name: 'T4';
     Value: 'nqc/nqc_8c6q.htm'
    ),
    (
     Name: 'SetPriority';
     Value: 'nqc/nqc_8d89.htm'
    ),
    (
     Name: 'RxMessage';
     Value: 'nqc/nqc_8e1x.htm'
    ),
    (
     Name: 'MSG_INDEX';
     Value: 'nqc/nqc_8e1x.htm'
    ),
    (
     Name: 'MSG_COMMAND';
     Value: 'nqc/nqc_8e1x.htm'
    ),
    (
     Name: 'MSG_HI_BYTE';
     Value: 'nqc/nqc_8e1x.htm'
    ),
    (
     Name: 'MSG_LO_BYTE';
     Value: 'nqc/nqc_8e1x.htm'
    ),
    (
     Name: 'TimerState';
     Value: 'nqc/nqc_8eed.htm'
    ),
    (
     Name: 'SerialBaud';
     Value: 'nqc/nqc_8f8k.htm'
    ),
    (
     Name: 'SerialPreamblePos';
     Value: 'nqc/nqc_8fg3.htm'
    ),
    (
     Name: 'SetRCTxMode';
     Value: 'nqc/nqc_8h9h.htm'
    ),
    (
     Name: 'RCTXMODE_SINGLE_SHOT';
     Value: 'nqc/nqc_8h9h.htm'
    ),
    (
     Name: 'RCTXMODE_CONTINUOUS';
     Value: 'nqc/nqc_8h9h.htm'
    ),
    (
     Name: 'ClearSound';
     Value: 'nqc/nqc_8jc4.htm'
    ),
    (
     Name: 'preprocessor';
     Value: 'nqc/nqc_8joy.htm'
    ),
    (
     Name: 'SetUpperLimit';
     Value: 'nqc/nqc_8l6c.htm'
    ),
    (
     Name: 'RotErrorsCount';
     Value: 'nqc/nqc_8lx0.htm'
    ),
    (
     Name: 'events';
     Value: 'nqc/nqc_8mpf.htm'
    ),
    (
     Name: 'GetWorldDirection';
     Value: 'nqc/nqc_8nji.htm'
    ),
    (
     Name: 'DIRECTION_LEFT';
     Value: 'nqc/nqc_8nji.htm'
    ),
    (
     Name: 'DIRECTION_LEFT_OF_CENTER';
     Value: 'nqc/nqc_8nji.htm'
    ),
    (
     Name: 'DIRECTION_CENTER';
     Value: 'nqc/nqc_8nji.htm'
    ),
    (
     Name: 'DIRECTION_RIGHT_OF_CENTER';
     Value: 'nqc/nqc_8nji.htm'
    ),
    (
     Name: 'DIRECTION_RIGHT';
     Value: 'nqc/nqc_8nji.htm'
    ),
    (
     Name: 'EventFeedback';
     Value: 'nqc/nqc_8obv.htm'
    ),
    (
     Name: 'ClickCounter';
     Value: 'nqc/nqc_8oc2.htm'
    ),
    (
     Name: 'ClearAll';
     Value: 'nqc/nqc_8ovg.htm'
    ),
    (
     Name: 'SetMotorPower128';
     Value: 'nqc/nqc_8qwo.htm'
    ),
    (
     Name: 'UpperLimit';
     Value: 'nqc/nqc_8r04.htm'
    ),
    (
     Name: 'MemoryMapAddress';
     Value: 'nqc/nqc_8rar.htm'
    ),
    (
     Name: 'SetOpcodesPerTimeslice';
     Value: 'nqc/nqc_8rol.htm'
    ),
    (
     Name: 'EVENT_MASK';
     Value: 'nqc/nqc_8s6j.htm'
    ),
    (
     Name: 'TaskAcquirePriority';
     Value: 'nqc/nqc_8vll.htm'
    ),
    (
     Name: 'OnRev';
     Value: 'nqc/nqc_8wfq.htm'
    ),
    (
     Name: 'SetDefaultStackSize';
     Value: 'nqc/nqc_8wh1.htm'
    ),
    (
     Name: 'SetEventCounts';
     Value: 'nqc/nqc_8xkj.htm'
    ),
    (
     Name: 'SendSerial';
     Value: 'nqc/nqc_8y7g.htm'
    ),
    (
     Name: 'SetRCRxChannel';
     Value: 'nqc/nqc_90h8.htm'
    ),
    (
     Name: 'RC_CHANNEL_BROADCAST';
     Value: 'nqc/nqc_90h8.htm'
    ),
    (
     Name: 'RC_CHANNEL_1';
     Value: 'nqc/nqc_90h8.htm'
    ),
    (
     Name: 'RC_CHANNEL_2';
     Value: 'nqc/nqc_90h8.htm'
    ),
    (
     Name: 'RC_CHANNEL_3';
     Value: 'nqc/nqc_90h8.htm'
    ),
    (
     Name: 'RC_CHANNEL_DISABLED';
     Value: 'nqc/nqc_90h8.htm'
    ),
    (
     Name: 'Sum2Mem';
     Value: 'nqc/nqc_90kt.htm'
    ),
    (
     Name: 'SoundActive';
     Value: 'nqc/nqc_90md.htm'
    ),
    (
     Name: 'CalibrateSensor';
     Value: 'nqc/nqc_90s2.htm'
    ),
    (
     Name: 'DatalogSize';
     Value: 'nqc/nqc_90th.htm'
    ),
    (
     Name: 'spybotics specific features';
     Value: 'nqc/nqc_91r7.htm'
    ),
    (
     Name: 'AddToDatalog';
     Value: 'nqc/nqc_93tz.htm'
    ),
    (
     Name: 'SetEffectTime';
     Value: 'nqc/nqc_94x1.htm'
    ),
    (
     Name: 'noinit';
     Value: 'nqc/nqc_95tg.htm'
    ),
    (
     Name: 'init';
     Value: 'nqc/nqc_95tg.htm'
    ),
    (
     Name: '#pragma';
     Value: 'nqc/nqc_95tg.htm'
    ),
    (
     Name: 'vll';
     Value: 'nqc/nqc_96gc.htm'
    ),
    (
     Name: 'SetSerialPreambleLen';
     Value: 'nqc/nqc_96pa.htm'
    ),
    (
     Name: 'RotDebouncedGlitches';
     Value: 'nqc/nqc_96sz.htm'
    ),
    (
     Name: 'MissedSensorADConversions';
     Value: 'nqc/nqc_96yb.htm'
    ),
    (
     Name: 'SetLight';
     Value: 'nqc/nqc_981g.htm'
    ),
    (
     Name: 'LIGHT_ON';
     Value: 'nqc/nqc_981g.htm'
    ),
    (
     Name: 'LIGHT_OFF';
     Value: 'nqc/nqc_981g.htm'
    ),
    (
     Name: 'ClearAllEvents';
     Value: 'nqc/nqc_98qb.htm'
    ),
    (
     Name: 'SetDirection';
     Value: 'nqc/nqc_98vi.htm'
    ),
    (
     Name: 'OUT_FWD';
     Value: 'nqc/nqc_98vi.htm'
    ),
    (
     Name: 'OUT_REV';
     Value: 'nqc/nqc_98vi.htm'
    ),
    (
     Name: 'OUT_TOGGLE';
     Value: 'nqc/nqc_98vi.htm'
    ),
    (
     Name: 'EventCounts';
     Value: 'nqc/nqc_9aib.htm'
    ),
    (
     Name: 'EffectTime';
     Value: 'nqc/nqc_9aqt.htm'
    ),
    (
     Name: 'PlaySound';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_CLICK';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_DOUBLE_BEEP';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_DOWN';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_UP';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_LOW_BEEP';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_FAST_UP';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_SHORT_BLIP';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_EXCEPTION';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_SHOCKED';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_FIRE_LASER';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_FIRE_ELECTRONET';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_FIRE_SPINNER';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_HIT_BY_LASER';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_HIT_BY_ELECTRONET';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_HIT_BY_SPINNER';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_TAG';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_CRASH';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_FIGHT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_GOT_IT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_GENERAL_ALERT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_OUT_OF_ENERGY_ALERT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_LOW_ENERGY_ALERT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_SCORE_ALERT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_TIME_ALERT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_PROXIMITY_ALERT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_DANGER_ALERT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_BOMB_ALERT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_FINAL_COUNTDOWN';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_TICK_TOCK';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_GOTO';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_SCAN';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_POINT_TO';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_ACTIVATE_SHIELDS';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_ACTIVATE_REFLECT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_ACTIVATE_CLOAK';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_ACTIVATE_FLASH_BLIND';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_MAGNET';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_QUAD_DAMAGE';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_REPULSE';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_TURBO';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_FREEZE';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_SLOW';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_REVERSE';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_DIZZY';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_BOOST';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_DEACTIVATE_SHIELDS';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_DEACTIVATE_REFLECT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_DEACTIVATE_CLOAK';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_REFLECT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_EXPLOSION';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_BIG_EXPLOSION';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_PLACE_BOMB';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_HIT_BY_WIND';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_OUCH';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_GEIGER';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_WHISTLE';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_IM_IT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_HELP';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_SIREN';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_BURNT';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_GRINDED';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_SMACKED';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_TRILL_UP';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_TRILL_DOWN';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_YELL';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_WHISPER';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'SOUND_NONE';
     Value: 'nqc/nqc_9aw4.htm'
    ),
    (
     Name: 'ClearTachoCounter';
     Value: 'nqc/nqc_9bqq.htm'
    ),
    (
     Name: 'SendSpybotMsg';
     Value: 'nqc/nqc_9c87.htm'
    ),
    (
     Name: 'Push';
     Value: 'nqc/nqc_9cbs.htm'
    ),
    (
     Name: 'RCRxChannel';
     Value: 'nqc/nqc_9df0.htm'
    ),
    (
     Name: 'Counter';
     Value: 'nqc/nqc_9df6.htm'
    ),
    (
     Name: 'SetHysteresis';
     Value: 'nqc/nqc_9feb.htm'
    ),
    (
     Name: 'SetTargetID';
     Value: 'nqc/nqc_9gv8.htm'
    ),
    (
     Name: 'TARGET_NONE';
     Value: 'nqc/nqc_9gv8.htm'
    ),
    (
     Name: 'ID_BOT_MIN';
     Value: 'nqc/nqc_9gv8.htm'
    ),
    (
     Name: 'ID_BOT_MAX';
     Value: 'nqc/nqc_9gv8.htm'
    ),
    (
     Name: 'Stack';
     Value: 'nqc/nqc_9hrf.htm'
    ),
    (
     Name: 'SetSerialData';
     Value: 'nqc/nqc_9hwh.htm'
    ),
    (
     Name: 'Action';
     Value: 'nqc/nqc_9ir2.htm'
    ),
    (
     Name: 'SetSerialPreamblePos';
     Value: 'nqc/nqc_9jub.htm'
    ),
    (
     Name: 'ClearCounter';
     Value: 'nqc/nqc_9jxu.htm'
    ),
    (
     Name: 'RxMessageLock';
     Value: 'nqc/nqc_9kiz.htm'
    ),
    (
     Name: 'SetEffectSound';
     Value: 'nqc/nqc_9kro.htm'
    ),
    (
     Name: 'Hysteresis';
     Value: 'nqc/nqc_9l83.htm'
    ),
    (
     Name: 'TransmitterRange';
     Value: 'nqc/nqc_9med.htm'
    ),
    (
     Name: 'SerialData';
     Value: 'nqc/nqc_9nq9.htm'
    ),
    (
     Name: 'TachoCount';
     Value: 'nqc/nqc_9rec.htm'
    ),
    (
     Name: 'SensorDelayCycles';
     Value: 'nqc/nqc_9u43.htm'
    ),
    (
     Name: 'EffectSound';
     Value: 'nqc/nqc_9xpg.htm'
    ),
    (
     Name: 'SetDefaultSerialPacket';
     Value: 'nqc/nqc_9xv8.htm'
    ),
    (
     Name: 'SleepNow';
     Value: 'nqc/nqc_9yk7.htm'
    ),
    (
     Name: 'SendMessageWithParam';
     Value: 'nqc/nqc_9yr1.htm'
    ),
    (
     Name: 'EventState';
     Value: 'nqc/nqc_9zs5.htm'
    ),
    (
     Name: '$##@$@#$@#$@$';
     Value: '$##@$@#$@#$@$'
    )
  );

implementation

end.
