unit uSPCHTMLTopics;

interface

uses
  uHTMLHelp;

const
  uSPCHTMLTopicsSize = 205;
  uSPCHTMLTopicsData: array[0..uSPCHTMLTopicsSize-1] of TNameValue = (
    (
     Name: 'TRUE';
     Value: 'group___misc_constants_gaa8cecfc5c5c054d2875c03e77b7be15d.html'
    ),
    (
     Name: 'FALSE';
     Value: 'group___misc_constants_gaa93f0eb578d23995850d61f7d61c55c1.html'
    ),
    (
     Name: 'SERIAL_BUFFER_SIZE';
     Value: 'group___misc_constants_gaaa07390e6158db5d82d40510d2ae02d5.html'
    ),
    (
     Name: 'CHAR_BIT';
     Value: 'group___s_p_r_o_limits_ga308d9dd2c0028ddb184b455bbd7865de.html'
    ),
    (
     Name: 'LONG_MIN';
     Value: 'group___s_p_r_o_limits_gae8a44c5a7436466221e0f3859d02420f.html'
    ),
    (
     Name: 'SCHAR_MIN';
     Value: 'group___s_p_r_o_limits_gaa05d197000ad5c143ada0fcd9379b236.html'
    ),
    (
     Name: 'INT_MIN';
     Value: 'group___s_p_r_o_limits_ga21658776274b3d146c674318b635a334.html'
    ),
    (
     Name: 'CHAR_MIN';
     Value: 'group___s_p_r_o_limits_ga5d707bd32338557ced18c6ac76ca1b3a.html'
    ),
    (
     Name: 'LONG_MAX';
     Value: 'group___s_p_r_o_limits_ga50fece4db74f09568b2938db583c5655.html'
    ),
    (
     Name: 'SCHAR_MAX';
     Value: 'group___s_p_r_o_limits_ga8c13fdd8c2840edf0cb04a65297037bb.html'
    ),
    (
     Name: 'INT_MAX';
     Value: 'group___s_p_r_o_limits_ga9ec306f36d50c7375e74f0d1c55a3a67.html'
    ),
    (
     Name: 'CHAR_MAX';
     Value: 'group___s_p_r_o_limits_ga778eefd6535a9d4b752fca5dd0af58db.html'
    ),
    (
     Name: 'DAC_MODE_DCOUT';
     Value: 'group___dac_mode_constants_gadaf6d447e4b95dba462e252a6f3df2d0.html'
    ),
    (
     Name: 'DAC_MODE_SINEWAVE';
     Value: 'group___dac_mode_constants_ga1060ca2abdfc3ea868fff22570f2b2be.html'
    ),
    (
     Name: 'DAC_MODE_SQUAREWAVE';
     Value: 'group___dac_mode_constants_ga6def662d26258217e7e1440ad9cc5dda.html'
    ),
    (
     Name: 'DAC_MODE_SAWPOSWAVE';
     Value: 'group___dac_mode_constants_gaf7f4d6e43e30496099b7b09eea9a2b62.html'
    ),
    (
     Name: 'DAC_MODE_SAWNEGWAVE';
     Value: 'group___dac_mode_constants_gaf8fbb1caddf5bd5bc09f45b4b072146f.html'
    ),
    (
     Name: 'DAC_MODE_TRIANGLEWAVE';
     Value: 'group___dac_mode_constants_ga810ac12137076ea46c13d319e53c6f6f.html'
    ),
    (
     Name: 'DAC_MODE_PWMVOLTAGE';
     Value: 'group___dac_mode_constants_gacbeee81c0ec345769f54766a91048b58.html'
    ),
    (
     Name: 'LED_BLUE';
     Value: 'group___l_e_d_ctrl_constants_gae2e40566d27689f8581d7b0f12271d45.html'
    ),
    (
     Name: 'LED_RED';
     Value: 'group___l_e_d_ctrl_constants_ga31e20330f8ce94e0dd10b005a15c5898.html'
    ),
    (
     Name: 'DIGI_PIN0';
     Value: 'group___digital_pin_constants_ga9060e318451b503ccd4833fbba74d98a.html'
    ),
    (
     Name: 'DIGI_PIN1';
     Value: 'group___digital_pin_constants_ga49d5fb9b290523c1364b0033a623cbc3.html'
    ),
    (
     Name: 'DIGI_PIN2';
     Value: 'group___digital_pin_constants_gae0f6fb5d22b8d89f800e1672d966a9d5.html'
    ),
    (
     Name: 'DIGI_PIN3';
     Value: 'group___digital_pin_constants_gadd0231b9203248c14174b781a21e203f.html'
    ),
    (
     Name: 'DIGI_PIN4';
     Value: 'group___digital_pin_constants_gadcb9392cf25a8ffacc8bf7587b47febe.html'
    ),
    (
     Name: 'DIGI_PIN5';
     Value: 'group___digital_pin_constants_gac1eb5328757f8b7259340108f54aadcd.html'
    ),
    (
     Name: 'DIGI_PIN6';
     Value: 'group___digital_pin_constants_ga5e8c8f2424478415337448e0cce1bdb3.html'
    ),
    (
     Name: 'DIGI_PIN7';
     Value: 'group___digital_pin_constants_gad72aa338c49ff927997299802a341e4f.html'
    ),
    (
     Name: 'STROBE_S0';
     Value: 'group___strobe_ctrl_constants_gaae896e16f79e60c31509b9379a5f8af6.html'
    ),
    (
     Name: 'STROBE_S1';
     Value: 'group___strobe_ctrl_constants_ga680dd82c4fa7b4b7448a6be1187a01b6.html'
    ),
    (
     Name: 'STROBE_S2';
     Value: 'group___strobe_ctrl_constants_ga873145802a38afbf2684656c2fb81c4b.html'
    ),
    (
     Name: 'STROBE_S3';
     Value: 'group___strobe_ctrl_constants_ga91eea3420d4e893e594ea2a3dc3c62f5.html'
    ),
    (
     Name: 'STROBE_READ';
     Value: 'group___strobe_ctrl_constants_ga797ffee1f320b591d31b5d4e9370864f.html'
    ),
    (
     Name: 'STROBE_WRITE';
     Value: 'group___strobe_ctrl_constants_ga5f18be7419d2992898e1d596a9d75356.html'
    ),
    (
     Name: 'SLOT1';
     Value: 'group___slot_constants_ga86e7f1b7f5ebbab30d693661f380d1b9.html'
    ),
    (
     Name: 'SLOT2';
     Value: 'group___slot_constants_ga31de44a4d7df249dd52269e2192fad86.html'
    ),
    (
     Name: 'SLOT3';
     Value: 'group___slot_constants_ga036fbc14cce3b67513de25a348ceda9f.html'
    ),
    (
     Name: 'SLOT4';
     Value: 'group___slot_constants_gaa04579e8d5ec2ed904350993982388ec.html'
    ),
    (
     Name: 'SLOT5';
     Value: 'group___slot_constants_ga4720cda8ba28902000be25c4d7247af3.html'
    ),
    (
     Name: 'SLOT6';
     Value: 'group___slot_constants_ga89c97ef15880e9e2b482d35d0e81c8de.html'
    ),
    (
     Name: 'SLOT7';
     Value: 'group___slot_constants_ga48cf6da75b7b97dcd92b6970aee84841.html'
    ),
    (
     Name: 'LOG_STATUS_OPEN';
     Value: 'group___log_status_constants_gaeef2a5a33c780a15ca274402920ab8ce.html'
    ),
    (
     Name: 'LOG_STATUS_BUSY';
     Value: 'group___log_status_constants_ga47d82fe9c754fd8a16b961bec5d4d58c.html'
    ),
    (
     Name: 'LOG_STATUS_CLOSED';
     Value: 'group___log_status_constants_gaa26763169720f90302c16ff772c1a174.html'
    ),
    (
     Name: 'MS_1';
     Value: 'group___time_constants_gabc7c0db723ae7ed4f2e01e9f56610234.html'
    ),
    (
     Name: 'MS_2';
     Value: 'group___time_constants_ga4819096c374a27cead88ea2938a6c454.html'
    ),
    (
     Name: 'MS_3';
     Value: 'group___time_constants_ga4eaaaaa38f6605c1a11578e5c752a0b6.html'
    ),
    (
     Name: 'MS_4';
     Value: 'group___time_constants_ga405886c074e1b00cc697b54b4995c8ab.html'
    ),
    (
     Name: 'MS_5';
     Value: 'group___time_constants_ga87ba2db786267120b7e3cbea1a16ad7e.html'
    ),
    (
     Name: 'MS_6';
     Value: 'group___time_constants_gab9220bd4d542e70d40c3db6759fa8d49.html'
    ),
    (
     Name: 'MS_7';
     Value: 'group___time_constants_ga32c9d7bd8f457fae08a1bee7dd88dfbe.html'
    ),
    (
     Name: 'MS_8';
     Value: 'group___time_constants_ga5c40301df942c0fe341c3d32c415d481.html'
    ),
    (
     Name: 'MS_9';
     Value: 'group___time_constants_ga7aec52424dd5b3fba4fa91adec106864.html'
    ),
    (
     Name: 'MS_10';
     Value: 'group___time_constants_ga073c6a6198de0dbb10506254274d504d.html'
    ),
    (
     Name: 'MS_20';
     Value: 'group___time_constants_gaf850f092cb6d44b3f20dde28666ef4c6.html'
    ),
    (
     Name: 'MS_30';
     Value: 'group___time_constants_ga560a5fb70b3f94352cc37ebf524845b3.html'
    ),
    (
     Name: 'MS_40';
     Value: 'group___time_constants_ga313a760833e1bcfadb251437e7f600e9.html'
    ),
    (
     Name: 'MS_50';
     Value: 'group___time_constants_ga5e50253998030d0918c2240c801e00ad.html'
    ),
    (
     Name: 'MS_60';
     Value: 'group___time_constants_gacf4401da047624c556d8315f89050ef2.html'
    ),
    (
     Name: 'MS_70';
     Value: 'group___time_constants_ga55593a3dddfbe95e7dbf69fa4050e97f.html'
    ),
    (
     Name: 'MS_80';
     Value: 'group___time_constants_gad6887a40809e6bb8077c4002566b208b.html'
    ),
    (
     Name: 'MS_90';
     Value: 'group___time_constants_ga9bc8926a2b6731434212fa863ef6e4ba.html'
    ),
    (
     Name: 'MS_100';
     Value: 'group___time_constants_gae931a0b8af2371754c32048c4a616015.html'
    ),
    (
     Name: 'MS_150';
     Value: 'group___time_constants_gad47b3b1b2d731e7ccfae854df979a8f4.html'
    ),
    (
     Name: 'MS_200';
     Value: 'group___time_constants_gaff598eeff82198e73fe18ab1f3935d02.html'
    ),
    (
     Name: 'MS_250';
     Value: 'group___time_constants_ga81abf7e65dc4ffa4036b0cfcb5209163.html'
    ),
    (
     Name: 'MS_300';
     Value: 'group___time_constants_ga01a386293cdeaee15cc685da1a96233b.html'
    ),
    (
     Name: 'MS_350';
     Value: 'group___time_constants_ga8f58c04048cadc97e4934bf191f3bc07.html'
    ),
    (
     Name: 'MS_400';
     Value: 'group___time_constants_gafb6c5fcae3077120592c40ec09450df9.html'
    ),
    (
     Name: 'MS_450';
     Value: 'group___time_constants_ga4aaeeb700eece175b395a7f579f2f42c.html'
    ),
    (
     Name: 'MS_500';
     Value: 'group___time_constants_gac025258ec976b27f878c84a91f4df909.html'
    ),
    (
     Name: 'MS_600';
     Value: 'group___time_constants_ga8b33325eeffcc3ead1c22c940ad44f51.html'
    ),
    (
     Name: 'MS_700';
     Value: 'group___time_constants_gaa82d1c8238006a96e4cd8a34a130e0c4.html'
    ),
    (
     Name: 'MS_800';
     Value: 'group___time_constants_ga5ce67951b218ce42862ba98507041ee2.html'
    ),
    (
     Name: 'MS_900';
     Value: 'group___time_constants_ga2ad74bedf1f7437974191b46ef3ee9c7.html'
    ),
    (
     Name: 'SEC_1';
     Value: 'group___time_constants_ga985f1ed5808435c49c85af2dd34b52bc.html'
    ),
    (
     Name: 'SEC_2';
     Value: 'group___time_constants_gac4e9795a6829e1488357d060d02253b5.html'
    ),
    (
     Name: 'SEC_3';
     Value: 'group___time_constants_ga68233949f06949d334d5981269b2e31a.html'
    ),
    (
     Name: 'SEC_4';
     Value: 'group___time_constants_ga6813ddd0d7fe08ec237548dbb0e46da6.html'
    ),
    (
     Name: 'SEC_5';
     Value: 'group___time_constants_ga76e29f67ccf10560f272e60cc2856927.html'
    ),
    (
     Name: 'SEC_6';
     Value: 'group___time_constants_gaacfe4a3fe945a6a482f18c5db031f1b3.html'
    ),
    (
     Name: 'SEC_7';
     Value: 'group___time_constants_ga94b5ab62f8bd7f40cce568476ae92b24.html'
    ),
    (
     Name: 'SEC_8';
     Value: 'group___time_constants_ga8d51ee79bda751e4d61d2c60d64f52c0.html'
    ),
    (
     Name: 'SEC_9';
     Value: 'group___time_constants_gaa8278a89dd8e2ac8d5e8070ad8365ef2.html'
    ),
    (
     Name: 'SEC_10';
     Value: 'group___time_constants_ga49b2fd35d96046ccd5735517270d9971.html'
    ),
    (
     Name: 'SEC_15';
     Value: 'group___time_constants_gabf3dd4478f8b29338bac1a81d992fea1.html'
    ),
    (
     Name: 'SEC_20';
     Value: 'group___time_constants_ga0a4c1ba18936bb4024b19e387a3952bc.html'
    ),
    (
     Name: 'SEC_30';
     Value: 'group___time_constants_ga3e01ef867b9a33531c94bf8e8d0eba83.html'
    ),
    (
     Name: 'MIN_1';
     Value: 'group___time_constants_ga4dc6c3c69ab80e7958c48cb67da66192.html'
    ),
    (
     Name: 'TONE_A3';
     Value: 'group___tone_constants_ga8fbb28081d3657ce43c6420da76a18c0.html'
    ),
    (
     Name: 'TONE_AS3';
     Value: 'group___tone_constants_gacf23b2695df30b1b0ed83502867aaba7.html'
    ),
    (
     Name: 'TONE_B3';
     Value: 'group___tone_constants_gaa441bcae2160596de729c8ecfc16ef0b.html'
    ),
    (
     Name: 'TONE_C4';
     Value: 'group___tone_constants_gab107ac092fba11fcb8ea961b72cc6a27.html'
    ),
    (
     Name: 'TONE_CS4';
     Value: 'group___tone_constants_gacd2c9cf28bb44b956dfcc2a03b67f79b.html'
    ),
    (
     Name: 'TONE_D4';
     Value: 'group___tone_constants_ga3a16d093640ef25b260a62a927f7989e.html'
    ),
    (
     Name: 'TONE_DS4';
     Value: 'group___tone_constants_ga70ae84d4e3119a1c4effa38be7124dba.html'
    ),
    (
     Name: 'TONE_E4';
     Value: 'group___tone_constants_ga2747e3e5bdd09a02c03c72a8080cc486.html'
    ),
    (
     Name: 'TONE_F4';
     Value: 'group___tone_constants_gaf1d747a6f7b2cd8a724297834112f2b9.html'
    ),
    (
     Name: 'TONE_FS4';
     Value: 'group___tone_constants_gadc19887534f599a12df88e93c0a612cf.html'
    ),
    (
     Name: 'TONE_G4';
     Value: 'group___tone_constants_gab50c6abe6377f8fb5b1e47e9069533f3.html'
    ),
    (
     Name: 'TONE_GS4';
     Value: 'group___tone_constants_gad9ed8c0bc82590b46e249296bfeb2537.html'
    ),
    (
     Name: 'TONE_A4';
     Value: 'group___tone_constants_gaa860d3cfc794a0c0d082ba641b024571.html'
    ),
    (
     Name: 'TONE_AS4';
     Value: 'group___tone_constants_ga79aee55a40625492ed2e99d4f1fc093b.html'
    ),
    (
     Name: 'TONE_B4';
     Value: 'group___tone_constants_ga767ee66a147babda4f43f9c5ef07a73b.html'
    ),
    (
     Name: 'TONE_C5';
     Value: 'group___tone_constants_ga6c1784a8c78d132f1b113605eb343965.html'
    ),
    (
     Name: 'TONE_CS5';
     Value: 'group___tone_constants_ga02a12e9adced1f9d98d0dba8a318239c.html'
    ),
    (
     Name: 'TONE_D5';
     Value: 'group___tone_constants_gaaebb5ce9bef82822ad24860c864380b1.html'
    ),
    (
     Name: 'TONE_DS5';
     Value: 'group___tone_constants_gaf492288f48108b122774bb3697bff3b8.html'
    ),
    (
     Name: 'TONE_E5';
     Value: 'group___tone_constants_ga318b0dad83e0ddbd506b93c1b07ecc82.html'
    ),
    (
     Name: 'TONE_F5';
     Value: 'group___tone_constants_gacd7a26eb305425acc13576e6a2be0feb.html'
    ),
    (
     Name: 'TONE_FS5';
     Value: 'group___tone_constants_ga49a76ea3082e5f7efb2d5b201b999220.html'
    ),
    (
     Name: 'TONE_G5';
     Value: 'group___tone_constants_gaffc55abeef2e6174916323cb2c31761d.html'
    ),
    (
     Name: 'TONE_GS5';
     Value: 'group___tone_constants_gaec447bcabea4db0de0497bddbea8fe10.html'
    ),
    (
     Name: 'TONE_A5';
     Value: 'group___tone_constants_ga90d5dd7bd597401c4159af0f06d6eae6.html'
    ),
    (
     Name: 'TONE_AS5';
     Value: 'group___tone_constants_ga1ccd6809186acfdad85d637f88e6127b.html'
    ),
    (
     Name: 'TONE_B5';
     Value: 'group___tone_constants_ga8a6255a2ed7ff221f2c69b36b50b34a4.html'
    ),
    (
     Name: 'TONE_C6';
     Value: 'group___tone_constants_ga979c3ac5ca76916f66d0b4cdd656d37d.html'
    ),
    (
     Name: 'TONE_CS6';
     Value: 'group___tone_constants_gae3cf44ebbb4175221e585c3cb7ecb40e.html'
    ),
    (
     Name: 'TONE_D6';
     Value: 'group___tone_constants_ga0aa2072dc2055edc930946438da7a793.html'
    ),
    (
     Name: 'TONE_DS6';
     Value: 'group___tone_constants_gaa8e87a9a6738c9dc3401088eb10485f4.html'
    ),
    (
     Name: 'TONE_E6';
     Value: 'group___tone_constants_gad9e8fb0b3a36a604a309af74a8f42e7c.html'
    ),
    (
     Name: 'TONE_F6';
     Value: 'group___tone_constants_ga3baf84cd07e25f9f278231a7abb42315.html'
    ),
    (
     Name: 'TONE_FS6';
     Value: 'group___tone_constants_ga350e0643e63dcc9073ca300145ea6cc8.html'
    ),
    (
     Name: 'TONE_G6';
     Value: 'group___tone_constants_gae9600b33d29533bbed2bc456f4122746.html'
    ),
    (
     Name: 'TONE_GS6';
     Value: 'group___tone_constants_ga82b4adffb9966296fad9863c051186c6.html'
    ),
    (
     Name: 'TONE_A6';
     Value: 'group___tone_constants_gac66c0f23345964ef85b23b3237cd2eb9.html'
    ),
    (
     Name: 'TONE_AS6';
     Value: 'group___tone_constants_gaf58bfbf66763055a74a516e2f2019e7b.html'
    ),
    (
     Name: 'TONE_B6';
     Value: 'group___tone_constants_ga54bd6ce321a408f987b3bd26caa704cf.html'
    ),
    (
     Name: 'TONE_C7';
     Value: 'group___tone_constants_gaf216bd7a58330707a6e305140a1183b0.html'
    ),
    (
     Name: 'TONE_CS7';
     Value: 'group___tone_constants_ga97de05d26393cb88da162ca40789af39.html'
    ),
    (
     Name: 'TONE_D7';
     Value: 'group___tone_constants_gaaac69150c12572e2e053aeceba21acaf.html'
    ),
    (
     Name: 'TONE_DS7';
     Value: 'group___tone_constants_ga38017eba29a55a73e9bc744d1f0cf2af.html'
    ),
    (
     Name: 'TONE_E7';
     Value: 'group___tone_constants_ga883babea4693f299d980fa9033e74a65.html'
    ),
    (
     Name: 'TONE_F7';
     Value: 'group___tone_constants_ga048e0df932c406f099c4a11432f0d622.html'
    ),
    (
     Name: 'TONE_FS7';
     Value: 'group___tone_constants_gac88536df9590a22e2dc24b3b4b856071.html'
    ),
    (
     Name: 'TONE_G7';
     Value: 'group___tone_constants_ga500948fb090068c2c369a6ccaee2d22a.html'
    ),
    (
     Name: 'TONE_GS7';
     Value: 'group___tone_constants_ga6aaa7afe3656ca6c679685976ab5a408.html'
    ),
    (
     Name: 'TONE_A7';
     Value: 'group___tone_constants_ga7199a90ee48753b63721441f4f7e00bd.html'
    ),
    (
     Name: 'TONE_AS7';
     Value: 'group___tone_constants_ga384abc25ca1b780a44ec274fee6a0984.html'
    ),
    (
     Name: 'TONE_B7';
     Value: 'group___tone_constants_ga2c595d24f20f310ea0046715c2d25f4d.html'
    ),
    (
     Name: 'Wait';
     Value: 'group__spcapi_ga5ee53fc315cd0055a3a83a72f77030bc.html'
    ),
    (
     Name: 'Yield';
     Value: 'group__spcapi_ga284c5823fecbe537eef1e1f37828fc61.html'
    ),
    (
     Name: 'StopAllTasks';
     Value: 'group__spcapi_gab291db0306c025255b93490bb4b23a74.html'
    ),
    (
     Name: 'Stop';
     Value: 'group__spcapi_gae0b7b4cbddeeaa97c008626c305b0b13.html'
    ),
    (
     Name: 'ExitTo';
     Value: 'group__spcapi_gabfaff59fc3febef6a33807ba51d38bb4.html'
    ),
    (
     Name: 'StartTask';
     Value: 'group__spcapi_ga7ecb5d6444d6b2283730af5ddd145b75.html'
    ),
    (
     Name: 'SizeOf';
     Value: 'group__spcapi_gadbf1c0fed1e8e1a406e212895f253a43.html'
    ),
    (
     Name: 'read';
     Value: 'group__spcapi_gaf3aac984a5eb2c21d26b5a4e35693194.html'
    ),
    (
     Name: 'write';
     Value: 'group__spcapi_ga44a2c6c66d92a1616bbf652fda7a87d1.html'
    ),
    (
     Name: 'sqrt';
     Value: 'group__spcapi_ga3e554a0a1e4b90adef8eb07b314546b9.html'
    ),
    (
     Name: 'abs';
     Value: 'group__spcapi_gaaa87dddb1e62142fd07ee17db1b5d673.html'
    ),
    (
     Name: 'sign';
     Value: 'group__spcapi_ga9d84dab6bcb8bca7db5dc4a28f86fe4d.html'
    ),
    (
     Name: 'close';
     Value: 'group__spcapi_gac75a3edd7d38d2ff772c9285b5daf721.html'
    ),
    (
     Name: 'open';
     Value: 'group__spcapi_gaf7372b0218a5765dce24cc9007389c98.html'
    ),
    (
     Name: 'putchar';
     Value: 'group__spcapi_gac98c34bea7a4ff24bfa281edbed74e1c.html'
    ),
    (
     Name: 'puts';
     Value: 'group__spcapi_ga24df0c04767d20bfc8337baa088605ff.html'
    ),
    (
     Name: 'printf';
     Value: 'group__spcapi_ga133c04c35a1c14c6f8d8078831705661.html'
    ),
    (
     Name: 'abort';
     Value: 'group__spcapi_ga8dec7c95227ff149687066cf04029191.html'
    ),
    (
     Name: 'CurrentTick';
     Value: 'group__spcapi_ga1a4d6cb2aef5412ec8ae7e5afc2785d8.html'
    ),
    (
     Name: 'pop';
     Value: 'group__spcapi_ga4c5807670c67d62abe111c66c053bd7e.html'
    ),
    (
     Name: 'push';
     Value: 'group__spcapi_ga02a4ea9becef22d82d0b77fb01070bdd.html'
    ),
    (
     Name: 'RotateLeft';
     Value: 'group__spcapi_gacd6da9adb42c999a8c39bcd16f0661e9.html'
    ),
    (
     Name: 'RotateRight';
     Value: 'group__spcapi_ga74bb7ababe3fa4d762885e149bc39c3b.html'
    ),
    (
     Name: 'Run';
     Value: 'group__spcapi_ga2a88f9119020a6a749c98924b7796f4d.html'
    ),
    (
     Name: 'stat';
     Value: 'group__spcapi_ga1469faffeca12a53731f369152b7ac55.html'
    ),
    (
     Name: 'StopProcesses';
     Value: 'group__spcapi_gafdba8b97330e9ff86f91a8e0411d2e51.html'
    ),
    (
     Name: 'isupper';
     Value: 'group__ctype_a_p_i_gadadd6582d46775aab6a51e29d16d9f77.html'
    ),
    (
     Name: 'islower';
     Value: 'group__ctype_a_p_i_ga7b8f652a0423a80922dd89d8829db5f2.html'
    ),
    (
     Name: 'isalpha';
     Value: 'group__ctype_a_p_i_ga25908ae63aac2df990634e1ae5bd14d9.html'
    ),
    (
     Name: 'isdigit';
     Value: 'group__ctype_a_p_i_ga3fa45b35c8abf67a950b6d3d4063dede.html'
    ),
    (
     Name: 'isalnum';
     Value: 'group__ctype_a_p_i_gadf38e126f73a010f30af76db2a28c6e1.html'
    ),
    (
     Name: 'isspace';
     Value: 'group__ctype_a_p_i_ga56be4166e4673843042a548a7f513dbc.html'
    ),
    (
     Name: 'iscntrl';
     Value: 'group__ctype_a_p_i_ga0008a4e8e7889734dc1d83297de07158.html'
    ),
    (
     Name: 'isprint';
     Value: 'group__ctype_a_p_i_ga99355d8f0fb41ec43effb95189db0ed4.html'
    ),
    (
     Name: 'isgraph';
     Value: 'group__ctype_a_p_i_ga49f40fd869fd0c90e4497fda08c89561.html'
    ),
    (
     Name: 'ispunct';
     Value: 'group__ctype_a_p_i_gaf29554b3ec04ea7684482bffed5dbce6.html'
    ),
    (
     Name: 'isxdigit';
     Value: 'group__ctype_a_p_i_gadaf3aadefe3fc4fb07b6be0d7b880f53.html'
    ),
    (
     Name: 'toupper';
     Value: 'group__ctype_a_p_i_ga9c2f57ac3865af9006fdbfd5db9fd517.html'
    ),
    (
     Name: 'tolower';
     Value: 'group__ctype_a_p_i_gac79d6114c9df7350cedcd8cf921a6ea4.html'
    ),
    (
     Name: 'ADChannel0';
     Value: 'spmem_8h_a214b3c18ec6fe36661b377d7adcf76e5.html'
    ),
    (
     Name: 'ADChannel1';
     Value: 'spmem_8h_acc747f58c3ca2ceaa641f9d8005a0695.html'
    ),
    (
     Name: 'ADChannel2';
     Value: 'spmem_8h_addb4c6284f2b408e04e07a07aa252232.html'
    ),
    (
     Name: 'ADChannel3';
     Value: 'spmem_8h_a6e8f52992ebc854798cc417d0b1c790d.html'
    ),
    (
     Name: 'DigitalIn';
     Value: 'spmem_8h_a21205084fc28b1608d218f659dd7c9cc.html'
    ),
    (
     Name: 'DigitalOut';
     Value: 'spmem_8h_a469ac3cde59fe38f5acf9ca9361b2978.html'
    ),
    (
     Name: 'DigitalControl';
     Value: 'spmem_8h_a49de0441ddb2bec679bd7ecd9ea2a1d7.html'
    ),
    (
     Name: 'StrobeControl';
     Value: 'spmem_8h_a4ba6cd3d2039e828071e537f1e2efa0b.html'
    ),
    (
     Name: 'Timer0';
     Value: 'spmem_8h_a0e7f5ff5f73d44234bd5bae36a1ab7a9.html'
    ),
    (
     Name: 'Timer1';
     Value: 'spmem_8h_a45f00acf0c329275ee4c40a0be422517.html'
    ),
    (
     Name: 'Timer2';
     Value: 'spmem_8h_a2c1a0f4e3d28ec23a5d9154302ea2236.html'
    ),
    (
     Name: 'Timer3';
     Value: 'spmem_8h_aaaca3174709decd802bbdefc589b693d.html'
    ),
    (
     Name: 'SerialInCount';
     Value: 'spmem_8h_afdd18b0dfcca6b3268cf81af5b249422.html'
    ),
    (
     Name: 'SerialInByte';
     Value: 'spmem_8h_a761b8a931648c7e54e9f4a68bc95a464.html'
    ),
    (
     Name: 'SerialOutCount';
     Value: 'spmem_8h_ae8283b46784b6b7713b52371d3f1ce8b.html'
    ),
    (
     Name: 'SerialOutByte';
     Value: 'spmem_8h_a85df71c9d52f34cddefb059f22576a3e.html'
    ),
    (
     Name: 'DAC0Mode';
     Value: 'spmem_8h_a3f46ee0bd86abef46362c197712e2d2d.html'
    ),
    (
     Name: 'DAC0Frequency';
     Value: 'spmem_8h_af4d8bafe56191f0f340feab9df90ab6d.html'
    ),
    (
     Name: 'DAC0Voltage';
     Value: 'spmem_8h_a0a1a1ecdf15aaa72953d9cc16331d146.html'
    ),
    (
     Name: 'DAC1Mode';
     Value: 'spmem_8h_aebd20f335cdbcb70f4e6f6796954f286.html'
    ),
    (
     Name: 'DAC1Frequency';
     Value: 'spmem_8h_a043b8ef2496eabccab946612b707f6cb.html'
    ),
    (
     Name: 'DAC1Voltage';
     Value: 'spmem_8h_ad50ab2f4922950d8e9e31af16c258586.html'
    ),
    (
     Name: 'LEDControl';
     Value: 'spmem_8h_a494f8000b32ecb2a02a1fa175a49f183.html'
    ),
    (
     Name: 'SystemClock';
     Value: 'spmem_8h_a0c040c6f94ebe66e594e43c480cff634.html'
    ),
    (
     Name: '$##@$@#$@#$@$';
     Value: '$##@$@#$@#$@$'
    )
  );

implementation

end.
