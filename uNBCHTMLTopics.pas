unit uNBCHTMLTopics;

interface

uses
  uHTMLHelp;

const
  uNBCHTMLTopicsSize = 2416;
  uNBCHTMLTopicsData: array[0..uNBCHTMLTopicsSize-1] of TNameValue = (
    (
     Name: 'TRUE';
     Value: 'group___misc_constants_gaa8cecfc5c5c054d2875c03e77b7be15d.html'
    ),
    (
     Name: 'FALSE';
     Value: 'group___misc_constants_gaa93f0eb578d23995850d61f7d61c55c1.html'
    ),
    (
     Name: 'NA';
     Value: 'group___misc_constants_ga68eddd535923d17ddbc8bb03bab70b3b.html'
    ),
    (
     Name: 'RC_PROP_BTONOFF';
     Value: 'group___r_c_property_constants_gaead0deb991108085e8831ba84841baab.html'
    ),
    (
     Name: 'RC_PROP_SOUND_LEVEL';
     Value: 'group___r_c_property_constants_ga70acce21ed290d3a32798c6f36e90e7c.html'
    ),
    (
     Name: 'RC_PROP_SLEEP_TIMEOUT';
     Value: 'group___r_c_property_constants_ga2b3b9232ed8a3aebf0acde1f9cf642d1.html'
    ),
    (
     Name: 'RC_PROP_DEBUGGING';
     Value: 'group___r_c_property_constants_gaf1bc14447737f83e98c387eae9095457.html'
    ),
    (
     Name: 'OPARR_SUM';
     Value: 'group___array_op_constants_ga848f712589294a11fa96769f5a95d876.html'
    ),
    (
     Name: 'OPARR_MEAN';
     Value: 'group___array_op_constants_ga35e78178f6f56dd4fefbcbf43da5d700.html'
    ),
    (
     Name: 'OPARR_SUMSQR';
     Value: 'group___array_op_constants_ga42071f00edc58fe1a653d746f5e81def.html'
    ),
    (
     Name: 'OPARR_STD';
     Value: 'group___array_op_constants_ga9e0801ef307e86e4a2f00cac7e3bbd0e.html'
    ),
    (
     Name: 'OPARR_MIN';
     Value: 'group___array_op_constants_ga3d3653a87750c6855cae4126c9fdec29.html'
    ),
    (
     Name: 'OPARR_MAX';
     Value: 'group___array_op_constants_gaf02d7c6038d0fcabae3d022875836d6a.html'
    ),
    (
     Name: 'OPARR_SORT';
     Value: 'group___array_op_constants_gaff414f199c86a914989315eedfdacf33.html'
    ),
    (
     Name: 'PI';
     Value: 'group___misc_constants_ga598a3330b3c21701223ee0ca14316eca.html'
    ),
    (
     Name: 'RADIANS_PER_DEGREE';
     Value: 'group___misc_constants_ga3478b02a2cce17123c3d98aa39decee1.html'
    ),
    (
     Name: 'DEGREES_PER_RADIAN';
     Value: 'group___misc_constants_gaf65f0fc64856d532f66e45529cabe800.html'
    ),
    (
     Name: 'FileOpenRead';
     Value: 'group___sys_call_constants_gaa11310e7917542d2afdc38356cada5e2.html'
    ),
    (
     Name: 'FileOpenWrite';
     Value: 'group___sys_call_constants_gabdc18387e0c023a01ff84c6db505b323.html'
    ),
    (
     Name: 'FileOpenAppend';
     Value: 'group___sys_call_constants_ga4f4746027a4757304acba1df655be551.html'
    ),
    (
     Name: 'FileRead';
     Value: 'group___sys_call_constants_gaea1c14b29566d1a92e7229a1b5ff4aa8.html'
    ),
    (
     Name: 'FileWrite';
     Value: 'group___sys_call_constants_ga57813c388a224abb962429ba7f490551.html'
    ),
    (
     Name: 'FileClose';
     Value: 'group___sys_call_constants_ga47763291e6565dd0f2854f49b1100b42.html'
    ),
    (
     Name: 'FileResolveHandle';
     Value: 'group___sys_call_constants_ga1b7fab56f83da2f81e9be5fdec88252e.html'
    ),
    (
     Name: 'FileRename';
     Value: 'group___sys_call_constants_ga31914a01f0e983c8aa5c2c5833cf48a7.html'
    ),
    (
     Name: 'FileDelete';
     Value: 'group___sys_call_constants_gacf90f6c3d896757c8fabdf548da658e1.html'
    ),
    (
     Name: 'SoundPlayFile';
     Value: 'group___sys_call_constants_ga0ca273c4be6d751384f69e3beccd04dd.html'
    ),
    (
     Name: 'SoundPlayTone';
     Value: 'group___sys_call_constants_ga1405ee73f07d86529ea010234c77f739.html'
    ),
    (
     Name: 'SoundGetState';
     Value: 'group___sys_call_constants_gaed8e03e48f20a0565e4c62299cbee8b0.html'
    ),
    (
     Name: 'SoundSetState';
     Value: 'group___sys_call_constants_gaa7dbc765535767eb5636ae09275e47d4.html'
    ),
    (
     Name: 'DrawText';
     Value: 'group___sys_call_constants_ga7a570133aedce5b48b6e894ce000a6d1.html'
    ),
    (
     Name: 'DrawPoint';
     Value: 'group___sys_call_constants_gaae3076e13a03294507fe642d87188e4e.html'
    ),
    (
     Name: 'DrawLine';
     Value: 'group___sys_call_constants_ga90b0f408e8a54bd106c53ffacdf65d74.html'
    ),
    (
     Name: 'DrawCircle';
     Value: 'group___sys_call_constants_ga4b5f14cd60026b256c1666e750948f83.html'
    ),
    (
     Name: 'DrawRect';
     Value: 'group___sys_call_constants_gaaf708f64cc1d889eb33e82137217e4e6.html'
    ),
    (
     Name: 'DrawGraphic';
     Value: 'group___sys_call_constants_ga52131e12c9e11f2cbdd44edd39125b13.html'
    ),
    (
     Name: 'SetScreenMode';
     Value: 'group___sys_call_constants_ga84a7443c67c29aff4494d60fe44a1d55.html'
    ),
    (
     Name: 'ReadButton';
     Value: 'group___sys_call_constants_gacaa5a4190107199949cf91769d00e790.html'
    ),
    (
     Name: 'CommLSWrite';
     Value: 'group___sys_call_constants_gaf10aa6e8b76a6fd16de7141785ce1dc4.html'
    ),
    (
     Name: 'CommLSRead';
     Value: 'group___sys_call_constants_ga8de0519d1031ca07bec706cbdba24496.html'
    ),
    (
     Name: 'CommLSCheckStatus';
     Value: 'group___sys_call_constants_ga78bf2e2b3d376df51f89a1e8a2bcc214.html'
    ),
    (
     Name: 'RandomNumber';
     Value: 'group___sys_call_constants_gadb9a50d3ea122517ac436aa40f08b681.html'
    ),
    (
     Name: 'GetStartTick';
     Value: 'group___sys_call_constants_gab3390fe5bb565df78bd5a48e5cd12c52.html'
    ),
    (
     Name: 'MessageWrite';
     Value: 'group___sys_call_constants_gadb4cefd3856f8e82073011bd129caefc.html'
    ),
    (
     Name: 'MessageRead';
     Value: 'group___sys_call_constants_gadf9af97feec266d60dc7c3e8a8647539.html'
    ),
    (
     Name: 'CommBTCheckStatus';
     Value: 'group___sys_call_constants_ga34adb747d21ab0e02241f6f60eb51c49.html'
    ),
    (
     Name: 'CommBTWrite';
     Value: 'group___sys_call_constants_ga72e6e0b0c61096ae4b4e7033b2214828.html'
    ),
    (
     Name: 'CommBTRead';
     Value: 'group___sys_call_constants_gae5d3e99d0d224a9857941366deb4fe69.html'
    ),
    (
     Name: 'KeepAlive';
     Value: 'group___sys_call_constants_gafa7abff7f5f40af01f3948d333c61e19.html'
    ),
    (
     Name: 'IOMapRead';
     Value: 'group___sys_call_constants_gaac694ed6565ce83ef11ace12b2737c0f.html'
    ),
    (
     Name: 'IOMapWrite';
     Value: 'group___sys_call_constants_ga5d090225c8af1fe317a3b0067a072682.html'
    ),
    (
     Name: 'ColorSensorRead';
     Value: 'group___sys_call_constants_gadeb14fa367e99fda405df19a5ce28873.html'
    ),
    (
     Name: 'CommBTOnOff';
     Value: 'group___sys_call_constants_gab1b69bb30764f3defcc265487a92ca47.html'
    ),
    (
     Name: 'CommBTConnection';
     Value: 'group___sys_call_constants_gacf252ba1485bd868ffe5b7d6d7022d3a.html'
    ),
    (
     Name: 'CommHSWrite';
     Value: 'group___sys_call_constants_ga7e24d727b6485b5a3c3060decfe14a22.html'
    ),
    (
     Name: 'CommHSRead';
     Value: 'group___sys_call_constants_gad9651b81a0229bd5f03f15d66ae02af1.html'
    ),
    (
     Name: 'CommHSCheckStatus';
     Value: 'group___sys_call_constants_ga6c8914bdd1df48c842449916c2456c8b.html'
    ),
    (
     Name: 'ReadSemData';
     Value: 'group___sys_call_constants_ga334a20d7f28c264bedd80ab6ec0b4ee2.html'
    ),
    (
     Name: 'WriteSemData';
     Value: 'group___sys_call_constants_gabc9218dd578f35a251fc1bc2d74bccf1.html'
    ),
    (
     Name: 'ComputeCalibValue';
     Value: 'group___sys_call_constants_gaf5a28dff5b3d8308a76d45b81837e32f.html'
    ),
    (
     Name: 'UpdateCalibCacheInfo';
     Value: 'group___sys_call_constants_gad2e5b1ce6cc02ead2e95a38cd3c727fe.html'
    ),
    (
     Name: 'DatalogWrite';
     Value: 'group___sys_call_constants_ga6930054e57f2fbc06b5dd18f2ec5a012.html'
    ),
    (
     Name: 'DatalogGetTimes';
     Value: 'group___sys_call_constants_ga3d995785b86c7310ddb0f4197704dfa7.html'
    ),
    (
     Name: 'SetSleepTimeoutVal';
     Value: 'group___sys_call_constants_ga6fc32efbf6626cab5389778f46e55c50.html'
    ),
    (
     Name: 'ListFiles';
     Value: 'group___sys_call_constants_gaa8eab7de886a0bc56511917ea862d92f.html'
    ),
    (
     Name: 'IOMapReadByID';
     Value: 'group___sys_call_constants_ga428ebda0acf49de7aea1936faedcf54c.html'
    ),
    (
     Name: 'IOMapWriteByID';
     Value: 'group___sys_call_constants_gad156b10bf62264947ec65fe6f833fe67.html'
    ),
    (
     Name: 'DisplayExecuteFunction';
     Value: 'group___sys_call_constants_gad9e6bd95a1c76be2dc89d3390107b22c.html'
    ),
    (
     Name: 'CommExecuteFunction';
     Value: 'group___sys_call_constants_ga4295f400fd2304445e3045b40d9d1da2.html'
    ),
    (
     Name: 'LoaderExecuteFunction';
     Value: 'group___sys_call_constants_gada924e287632b2039964af50a25fbb04.html'
    ),
    (
     Name: 'FileFindFirst';
     Value: 'group___sys_call_constants_ga4a03e11a666bf7a94e95ffed63ee463b.html'
    ),
    (
     Name: 'FileFindNext';
     Value: 'group___sys_call_constants_gaa293f6e62cb43e092e16fada1cc78e2c.html'
    ),
    (
     Name: 'FileOpenWriteLinear';
     Value: 'group___sys_call_constants_ga51d759ccab31d76a2d474e1ebcddf5c3.html'
    ),
    (
     Name: 'FileOpenWriteNonLinear';
     Value: 'group___sys_call_constants_ga3efec4b4748da95b038b6b902fb41b87.html'
    ),
    (
     Name: 'FileOpenReadLinear';
     Value: 'group___sys_call_constants_gad5ca7f04dbdd2011b347076cf56433bd.html'
    ),
    (
     Name: 'CommHSControl';
     Value: 'group___sys_call_constants_ga269ff005a21b5fc6a831c9d3b95361fc.html'
    ),
    (
     Name: 'CommLSWriteEx';
     Value: 'group___sys_call_constants_ga4d803f5a134f20c9e58730e23b010433.html'
    ),
    (
     Name: 'FileSeek';
     Value: 'group___sys_call_constants_gaf5b12ef3b028a29611579baca6aaf8bd.html'
    ),
    (
     Name: 'FileResize';
     Value: 'group___sys_call_constants_ga64868e34091bf90bf8356ad179076bb4.html'
    ),
    (
     Name: 'DrawGraphicArray';
     Value: 'group___sys_call_constants_gab9ceeeefcb16dba7147a14abb4c567d7.html'
    ),
    (
     Name: 'DrawPolygon';
     Value: 'group___sys_call_constants_ga5f7d025a6869ac7806ee7df204c7baa5.html'
    ),
    (
     Name: 'DrawEllipse';
     Value: 'group___sys_call_constants_gabd2de3e76e51deebd0b56286a59ac24a.html'
    ),
    (
     Name: 'DrawFont';
     Value: 'group___sys_call_constants_gaef725e2d3882d19d0e4bc47844d1af81.html'
    ),
    (
     Name: 'MemoryManager';
     Value: 'group___sys_call_constants_ga550d1be8705de22ee44c940c7aa4a586.html'
    ),
    (
     Name: 'ReadLastResponse';
     Value: 'group___sys_call_constants_ga9dfd7356f9afbc92e2f3187c2d77a322.html'
    ),
    (
     Name: 'FileTell';
     Value: 'group___sys_call_constants_ga96d34bde6de975ae279f2b38584ccb38.html'
    ),
    (
     Name: 'RandomEx';
     Value: 'group___sys_call_constants_ga427a64253e63e090166d9a32a2473c4d.html'
    ),
    (
     Name: 'LCD_LINE8';
     Value: 'group___line_constants_gabb513f5dfae0f51c17e6c50293aba7aa.html'
    ),
    (
     Name: 'LCD_LINE7';
     Value: 'group___line_constants_ga040b5cb9e5bab34c9da1b1154fc6c272.html'
    ),
    (
     Name: 'LCD_LINE6';
     Value: 'group___line_constants_gafcc8e9014f8c52dcf196effb35ee0f43.html'
    ),
    (
     Name: 'LCD_LINE5';
     Value: 'group___line_constants_ga2837d602821040a1df6c666fdd6dc97d.html'
    ),
    (
     Name: 'LCD_LINE4';
     Value: 'group___line_constants_ga11fc99e0a8ac2eb3504e94b0a771234f.html'
    ),
    (
     Name: 'LCD_LINE3';
     Value: 'group___line_constants_ga3a2ee32835c7649e5da01563407d8665.html'
    ),
    (
     Name: 'LCD_LINE2';
     Value: 'group___line_constants_gaee2c59879d4dca634a1ba6a2769e4ee6.html'
    ),
    (
     Name: 'LCD_LINE1';
     Value: 'group___line_constants_gac30f9eb729142201bec6ef0aa45e5c07.html'
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
     Name: 'MAILBOX1';
     Value: 'group___mailbox_constants_ga73e4efa9bd0c9113f8c3a196b84b9297.html'
    ),
    (
     Name: 'MAILBOX2';
     Value: 'group___mailbox_constants_gaf25b31739b78efc20d13aff839c532b2.html'
    ),
    (
     Name: 'MAILBOX3';
     Value: 'group___mailbox_constants_gab952266ef5b8f3214477c685235bd02b.html'
    ),
    (
     Name: 'MAILBOX4';
     Value: 'group___mailbox_constants_ga64a709d40682470cffc204876682e90e.html'
    ),
    (
     Name: 'MAILBOX5';
     Value: 'group___mailbox_constants_gacad5352634720dac042a8469f6961d78.html'
    ),
    (
     Name: 'MAILBOX6';
     Value: 'group___mailbox_constants_ga5280d5b613e1a6992345d9c4a5c90ba6.html'
    ),
    (
     Name: 'MAILBOX7';
     Value: 'group___mailbox_constants_gab7c2ba085abb8b7b3a8e76da743980eb.html'
    ),
    (
     Name: 'MAILBOX8';
     Value: 'group___mailbox_constants_gacf1a334076af0eb83fb30f077e66b941.html'
    ),
    (
     Name: 'MAILBOX9';
     Value: 'group___mailbox_constants_ga77b9b59cd2e40ef1e2560fdb2bd942f5.html'
    ),
    (
     Name: 'MAILBOX10';
     Value: 'group___mailbox_constants_ga982e9e2fe6c55db685e66adcf7879136.html'
    ),
    (
     Name: 'CommandModuleName';
     Value: 'group___module_name_constants_ga555177649545da6732f2eae349111f6c.html'
    ),
    (
     Name: 'IOCtrlModuleName';
     Value: 'group___module_name_constants_gaa9ba4d8a916b47a9a4380d26611a5e36.html'
    ),
    (
     Name: 'LoaderModuleName';
     Value: 'group___module_name_constants_gaa14d474bcf399bf57949be64e005e9d5.html'
    ),
    (
     Name: 'SoundModuleName';
     Value: 'group___module_name_constants_ga93e202ffe7e8fadab91d8dc28cae5da6.html'
    ),
    (
     Name: 'ButtonModuleName';
     Value: 'group___module_name_constants_ga301be985b553f15eedfe6f1452996fdf.html'
    ),
    (
     Name: 'UIModuleName';
     Value: 'group___module_name_constants_gaac6775411b7ef0ca63a855d0ef4f994c.html'
    ),
    (
     Name: 'InputModuleName';
     Value: 'group___module_name_constants_ga81473538a1582dfbf8f566a1f7bb3509.html'
    ),
    (
     Name: 'OutputModuleName';
     Value: 'group___module_name_constants_gaba207bdfbea08ded1bfb5e4068231c4a.html'
    ),
    (
     Name: 'LowSpeedModuleName';
     Value: 'group___module_name_constants_ga06e7b28d29ff6e295a54d9747f378b62.html'
    ),
    (
     Name: 'DisplayModuleName';
     Value: 'group___module_name_constants_ga4dddf897b7f85be122aa251487357ee5.html'
    ),
    (
     Name: 'CommModuleName';
     Value: 'group___module_name_constants_ga2205d1645d215bbb58680baad169e028.html'
    ),
    (
     Name: 'CommandModuleID';
     Value: 'group___module_i_d_constants_gaa8368bda9b528e5db2708f578e003a64.html'
    ),
    (
     Name: 'IOCtrlModuleID';
     Value: 'group___module_i_d_constants_ga05d779b28f98c2debb85cde2bbc59e32.html'
    ),
    (
     Name: 'LoaderModuleID';
     Value: 'group___module_i_d_constants_ga29016da2d21c1321432e38cf968b4b37.html'
    ),
    (
     Name: 'SoundModuleID';
     Value: 'group___module_i_d_constants_gaae86eb44cbc3ff41475953e61dc2b223.html'
    ),
    (
     Name: 'ButtonModuleID';
     Value: 'group___module_i_d_constants_ga51cab1717770714762c4a6f32aac8dee.html'
    ),
    (
     Name: 'UIModuleID';
     Value: 'group___module_i_d_constants_ga07a6da91b8d0bec8591ea5fee98360fb.html'
    ),
    (
     Name: 'InputModuleID';
     Value: 'group___module_i_d_constants_ga2334705cf72588d203684ab45aa0f22a.html'
    ),
    (
     Name: 'OutputModuleID';
     Value: 'group___module_i_d_constants_ga324a0ae3e98dd28dc42733405b387fab.html'
    ),
    (
     Name: 'LowSpeedModuleID';
     Value: 'group___module_i_d_constants_gad2bd19cff1885b08ae9d2831cdc68e57.html'
    ),
    (
     Name: 'DisplayModuleID';
     Value: 'group___module_i_d_constants_gaae42bd98c6cc44f1197754e02cc6822a.html'
    ),
    (
     Name: 'CommModuleID';
     Value: 'group___module_i_d_constants_gaf4267b9ade741adcdfa45aff7720f583.html'
    ),
    (
     Name: 'STAT_MSG_EMPTY_MAILBOX';
     Value: 'group___command_module_constants_ga95cbfebe13f2eb2af6bc26d71b6452e6.html'
    ),
    (
     Name: 'STAT_COMM_PENDING';
     Value: 'group___command_module_constants_gaff5d0e89c9ff770ed9bb56948de1f8c6.html'
    ),
    (
     Name: 'POOL_MAX_SIZE';
     Value: 'group___command_module_constants_ga6e0c753131d7613db37ef5a3fd2108c0.html'
    ),
    (
     Name: 'TIMES_UP';
     Value: 'group___command_v_m_state_gab5769153d95b9e4b65339938f214b9a2.html'
    ),
    (
     Name: 'ROTATE_QUEUE';
     Value: 'group___command_v_m_state_ga1f6a86f5ed4570800e2902562e1d4164.html'
    ),
    (
     Name: 'STOP_REQ';
     Value: 'group___command_v_m_state_ga9eca3259d834d9807b3aebedc80aa95f.html'
    ),
    (
     Name: 'BREAKOUT_REQ';
     Value: 'group___command_v_m_state_gaafaf8e1edfbbf813974d8e2b498c80c6.html'
    ),
    (
     Name: 'CLUMP_SUSPEND';
     Value: 'group___command_v_m_state_ga77954a64b52c5427ac70e38185e27808.html'
    ),
    (
     Name: 'CLUMP_DONE';
     Value: 'group___command_v_m_state_ga62e9f0b994970389e9b6f363d5f0619e.html'
    ),
    (
     Name: 'NO_ERR';
     Value: 'group___command_module_constants_ga0ac74b7a179f050bce712dac77d0c6b4.html'
    ),
    (
     Name: 'ERR_ARG';
     Value: 'group___command_fatal_errors_ga8700518a3e3d0c7a4439a37dcbcf2143.html'
    ),
    (
     Name: 'ERR_INSTR';
     Value: 'group___command_fatal_errors_ga27163bc2cc1d15c4bb0af10415c543b7.html'
    ),
    (
     Name: 'ERR_FILE';
     Value: 'group___command_fatal_errors_ga846551741a0d8ec6d1efd5491798d50d.html'
    ),
    (
     Name: 'ERR_VER';
     Value: 'group___command_fatal_errors_ga0f647f5384c2986633bae51c5f52537b.html'
    ),
    (
     Name: 'ERR_MEM';
     Value: 'group___command_fatal_errors_ga6ab63185cc5dff3c50c61d99bdf98369.html'
    ),
    (
     Name: 'ERR_BAD_PTR';
     Value: 'group___command_fatal_errors_ga7a682b414814167ad537babde5933c0f.html'
    ),
    (
     Name: 'ERR_CLUMP_COUNT';
     Value: 'group___command_fatal_errors_ga342df3f67731061c0b47ada5181d8059.html'
    ),
    (
     Name: 'ERR_NO_CODE';
     Value: 'group___command_fatal_errors_ga529c9580cfa5b3eb9f07137e685ffb27.html'
    ),
    (
     Name: 'ERR_INSANE_OFFSET';
     Value: 'group___command_fatal_errors_gaff587a715e222c0fbf9f205f6c546ca9.html'
    ),
    (
     Name: 'ERR_BAD_POOL_SIZE';
     Value: 'group___command_fatal_errors_ga12d8758c9765e3e53445102d7b5da9a6.html'
    ),
    (
     Name: 'ERR_LOADER_ERR';
     Value: 'group___command_fatal_errors_gacfcedbe021c177abe6bc678690c5d012.html'
    ),
    (
     Name: 'ERR_SPOTCHECK_FAIL';
     Value: 'group___command_fatal_errors_ga59d740388950b9d3c0801e3d586c5ea7.html'
    ),
    (
     Name: 'ERR_NO_ACTIVE_CLUMP';
     Value: 'group___command_fatal_errors_ga48c2cadddb345c448c244cca9bdbe146.html'
    ),
    (
     Name: 'ERR_DEFAULT_OFFSETS';
     Value: 'group___command_fatal_errors_gaf82123e7533f8ac545459cec1885dd01.html'
    ),
    (
     Name: 'ERR_MEMMGR_FAIL';
     Value: 'group___command_fatal_errors_gaffcdf716512f7bbab52d94ed0a19cb4d.html'
    ),
    (
     Name: 'ERR_NON_FATAL';
     Value: 'group___command_fatal_errors_gaef55386fde8897a72a72874d16cddde7.html'
    ),
    (
     Name: 'ERR_INVALID_PORT';
     Value: 'group___command_gen_errors_ga4bae61de63b2ef848cadcaa69615a277.html'
    ),
    (
     Name: 'ERR_INVALID_FIELD';
     Value: 'group___command_gen_errors_gaf1d9237bbc6cf057f8de94cbf40e6230.html'
    ),
    (
     Name: 'ERR_INVALID_QUEUE';
     Value: 'group___command_gen_errors_gaa2f9071bc4bc19442a99286745a0c9df.html'
    ),
    (
     Name: 'ERR_INVALID_SIZE';
     Value: 'group___command_gen_errors_ga8437fc6851e35812d6d7001f65106c76.html'
    ),
    (
     Name: 'ERR_NO_PROG';
     Value: 'group___command_gen_errors_gac18ed5076bcbe55ff14e0bd2bbee2c78.html'
    ),
    (
     Name: 'ERR_COMM_CHAN_NOT_READY';
     Value: 'group___command_comm_errors_ga23607fdf3c706a1c797795a8c7dd2e4f.html'
    ),
    (
     Name: 'ERR_COMM_CHAN_INVALID';
     Value: 'group___command_comm_errors_ga6d9c76eba722fe7f7caed82575ab8da5.html'
    ),
    (
     Name: 'ERR_COMM_BUFFER_FULL';
     Value: 'group___command_comm_errors_ga844e7f52d54c19e3dd42fd7ce7f91e4a.html'
    ),
    (
     Name: 'ERR_COMM_BUS_ERR';
     Value: 'group___command_comm_errors_ga25d1549b82fd686a9a9ba01f26b404ce.html'
    ),
    (
     Name: 'ERR_RC_ILLEGAL_VAL';
     Value: 'group___command_r_c_errors_gad7967dd006e3d76e53abec24be111582.html'
    ),
    (
     Name: 'ERR_RC_BAD_PACKET';
     Value: 'group___command_r_c_errors_gaa32bfed6766b1ebd2551c9b9fd8fd1d5.html'
    ),
    (
     Name: 'ERR_RC_UNKNOWN_CMD';
     Value: 'group___command_r_c_errors_ga4f45eb0641804f50149d1dec3b187a3e.html'
    ),
    (
     Name: 'ERR_RC_FAILED';
     Value: 'group___command_r_c_errors_ga689116cb4d4cdcfbe254ffb30af222d8.html'
    ),
    (
     Name: 'PROG_IDLE';
     Value: 'group___command_prog_status_ga13ad82dae400a8df24d0dc3cb1334582.html'
    ),
    (
     Name: 'PROG_OK';
     Value: 'group___command_prog_status_ga30990ace34f8875e7c42792bee134c1b.html'
    ),
    (
     Name: 'PROG_RUNNING';
     Value: 'group___command_prog_status_gaadf7dbde572d89bb6645cd47574b108e.html'
    ),
    (
     Name: 'PROG_ERROR';
     Value: 'group___command_prog_status_ga7df4778520c0caccd3988a8e2f73cc91.html'
    ),
    (
     Name: 'PROG_ABORT';
     Value: 'group___command_prog_status_ga1fff6054fb6fa1d52b9a3e9d63c13503.html'
    ),
    (
     Name: 'PROG_RESET';
     Value: 'group___command_prog_status_ga1d553348eae6fd7c09614b6ad8596e26.html'
    ),
    (
     Name: 'CommandOffsetFormatString';
     Value: 'group___command_i_o_m_a_p_gae1179c4102d9cfd10fff345393153a7e.html'
    ),
    (
     Name: 'CommandOffsetPRCHandler';
     Value: 'group___command_i_o_m_a_p_ga0f3c54acec94de0520921f39b34211d2.html'
    ),
    (
     Name: 'CommandOffsetTick';
     Value: 'group___command_i_o_m_a_p_ga89e2787d422d273a2c440ba2fee78f03.html'
    ),
    (
     Name: 'CommandOffsetOffsetDS';
     Value: 'group___command_i_o_m_a_p_ga8289c1326c2d6848a3b14d3574c1cc99.html'
    ),
    (
     Name: 'CommandOffsetOffsetDVA';
     Value: 'group___command_i_o_m_a_p_ga808c3e84ea467d0317e2467e6cc40016.html'
    ),
    (
     Name: 'CommandOffsetProgStatus';
     Value: 'group___command_i_o_m_a_p_gac6a0f2d0ea811973d4d158bc524d06b1.html'
    ),
    (
     Name: 'CommandOffsetAwake';
     Value: 'group___command_i_o_m_a_p_ga117118cd127ead53a5858eca2b62cd66.html'
    ),
    (
     Name: 'CommandOffsetActivateFlag';
     Value: 'group___command_i_o_m_a_p_ga38a86a765c81a8231c6cb8cee728fa27.html'
    ),
    (
     Name: 'CommandOffsetDeactivateFlag';
     Value: 'group___command_i_o_m_a_p_gae1d6474bc6ab97a289e5a7cf57016d2f.html'
    ),
    (
     Name: 'CommandOffsetFileName';
     Value: 'group___command_i_o_m_a_p_ga7ffaad4f549388fc6a824df76dde26d7.html'
    ),
    (
     Name: 'CommandOffsetMemoryPool';
     Value: 'group___command_i_o_m_a_p_ga598ba66ba06f6c080f5f40f3c9887215.html'
    ),
    (
     Name: 'CommandOffsetSyncTime';
     Value: 'group___command_i_o_m_a_p_ga03b16d86da55e7958c2613a0e2ed5acc.html'
    ),
    (
     Name: 'CommandOffsetSyncTick';
     Value: 'group___command_i_o_m_a_p_ga00c9e5aedfedbe7d09ee4dd5203b1849.html'
    ),
    (
     Name: 'IOCTRL_POWERDOWN';
     Value: 'group___i_o_ctrl_p_o_ga247700d4210b18a616caca53f1a490e2.html'
    ),
    (
     Name: 'IOCTRL_BOOT';
     Value: 'group___i_o_ctrl_p_o_gaebe6136350add98a2e96c4f6583b2038.html'
    ),
    (
     Name: 'IOCtrlOffsetPowerOn';
     Value: 'group___i_o_ctrl_i_o_m_a_p_ga98e0806370067800781bf142180f5128.html'
    ),
    (
     Name: 'LoaderOffsetPFunc';
     Value: 'group___loader_i_o_m_a_p_ga60594ca6b0926559db80a49b7f37a44e.html'
    ),
    (
     Name: 'LoaderOffsetFreeUserFlash';
     Value: 'group___loader_i_o_m_a_p_ga0b7ace6b0cf9530aeff2af214695fec8.html'
    ),
    (
     Name: 'EOF';
     Value: 'group___loader_module_constants_ga59adc4c82490d23754cd39c2fb99b0da.html'
    ),
    (
     Name: 'NULL';
     Value: 'group___loader_module_constants_ga070d2ce7b6bb7e5c05602aa8c308d0c4.html'
    ),
    (
     Name: 'LDR_SUCCESS';
     Value: 'group___loader_errors_gae790348c1c98af48245c4d910ef71550.html'
    ),
    (
     Name: 'LDR_INPROGRESS';
     Value: 'group___loader_errors_ga958de2ebebb27b4cdd97f0ce211e99df.html'
    ),
    (
     Name: 'LDR_REQPIN';
     Value: 'group___loader_errors_gaf9b6d896b3b5bafb5c0291d26842013e.html'
    ),
    (
     Name: 'LDR_NOMOREHANDLES';
     Value: 'group___loader_errors_gae3f223e8e27508111214da7c8f081171.html'
    ),
    (
     Name: 'LDR_NOSPACE';
     Value: 'group___loader_errors_gae4d4eea61861156f62c8eec6598ac687.html'
    ),
    (
     Name: 'LDR_NOMOREFILES';
     Value: 'group___loader_errors_gaf4a9ed1280414116a736918c2c2bbdf3.html'
    ),
    (
     Name: 'LDR_EOFEXPECTED';
     Value: 'group___loader_errors_ga2e1522360e0751d8fec9e01038a9a5ee.html'
    ),
    (
     Name: 'LDR_ENDOFFILE';
     Value: 'group___loader_errors_gaecc3a455e80c48f0ad682e84e71a8964.html'
    ),
    (
     Name: 'LDR_NOTLINEARFILE';
     Value: 'group___loader_errors_ga1966f5efdf47886283362af4e1d0c88f.html'
    ),
    (
     Name: 'LDR_FILENOTFOUND';
     Value: 'group___loader_errors_gab475a8f35fb5a0a8a78323c1cdc6294e.html'
    ),
    (
     Name: 'LDR_HANDLEALREADYCLOSED';
     Value: 'group___loader_errors_gaf50d0acde851dcc4a038f1dec7f10117.html'
    ),
    (
     Name: 'LDR_NOLINEARSPACE';
     Value: 'group___loader_errors_ga87edc705d9ec5047ad349c10855e09ec.html'
    ),
    (
     Name: 'LDR_UNDEFINEDERROR';
     Value: 'group___loader_errors_gadc701a77cd62350ac2ecf2c7c42aedd0.html'
    ),
    (
     Name: 'LDR_FILEISBUSY';
     Value: 'group___loader_errors_ga38d02dc59b65875091190506c17fc397.html'
    ),
    (
     Name: 'LDR_NOWRITEBUFFERS';
     Value: 'group___loader_errors_gae6c8f17d160ee5500c85596b13a52483.html'
    ),
    (
     Name: 'LDR_APPENDNOTPOSSIBLE';
     Value: 'group___loader_errors_ga38d0750b90a21fb660db33d5197d4628.html'
    ),
    (
     Name: 'LDR_FILEISFULL';
     Value: 'group___loader_errors_gac2ee8e73d3d4bfe215ef133b95c937c3.html'
    ),
    (
     Name: 'LDR_FILEEXISTS';
     Value: 'group___loader_errors_gaf6d59d1ed31015c1100da711ab5868e4.html'
    ),
    (
     Name: 'LDR_MODULENOTFOUND';
     Value: 'group___loader_errors_ga3d78c8fd386bc660275ecaac3568230f.html'
    ),
    (
     Name: 'LDR_OUTOFBOUNDARY';
     Value: 'group___loader_errors_ga7ab187f87a4da6745327d8a9a7af1d4c.html'
    ),
    (
     Name: 'LDR_ILLEGALFILENAME';
     Value: 'group___loader_errors_ga5080df63e7e6e0cd18da32962b28cfdb.html'
    ),
    (
     Name: 'LDR_ILLEGALHANDLE';
     Value: 'group___loader_errors_ga045ba286394dc0ef9689045408ad00c1.html'
    ),
    (
     Name: 'LDR_BTBUSY';
     Value: 'group___loader_errors_ga6c9e9d16978d346b0f85309d986e69fc.html'
    ),
    (
     Name: 'LDR_BTCONNECTFAIL';
     Value: 'group___loader_errors_gabc41c26ff8f970420e22381ee36ee46b.html'
    ),
    (
     Name: 'LDR_BTTIMEOUT';
     Value: 'group___loader_errors_gae471d5af49435e93355163d2e2cb30f1.html'
    ),
    (
     Name: 'LDR_FILETX_TIMEOUT';
     Value: 'group___loader_errors_gafa3ec55e8fc588f0f75f97f75a6a2390.html'
    ),
    (
     Name: 'LDR_FILETX_DSTEXISTS';
     Value: 'group___loader_errors_ga12ff51c0b5195763157b0a566c227bac.html'
    ),
    (
     Name: 'LDR_FILETX_SRCMISSING';
     Value: 'group___loader_errors_ga91abdbe99a694a49e61c2332abc1780f.html'
    ),
    (
     Name: 'LDR_FILETX_STREAMERROR';
     Value: 'group___loader_errors_ga31417de2282db8cb4665fba974582819.html'
    ),
    (
     Name: 'LDR_FILETX_CLOSEERROR';
     Value: 'group___loader_errors_ga3efc05f6c8e72014c3c518a3ee8bc1f2.html'
    ),
    (
     Name: 'LDR_INVALIDSEEK';
     Value: 'group___loader_errors_ga2d9b7fec508548ae30214d08adf67dee.html'
    ),
    (
     Name: 'LDR_CMD_OPENREAD';
     Value: 'group___loader_function_constants_ga2ba940c9157cf24c0ca1d983d8f15aaa.html'
    ),
    (
     Name: 'LDR_CMD_OPENWRITE';
     Value: 'group___loader_function_constants_ga5141e10f50c64430f960828461ef58f4.html'
    ),
    (
     Name: 'LDR_CMD_READ';
     Value: 'group___loader_function_constants_ga0cda2dc7ab98100b41f1e7bb6dcf0b3d.html'
    ),
    (
     Name: 'LDR_CMD_WRITE';
     Value: 'group___loader_function_constants_ga8c61e6b011ee3ca9023bd358792f01f9.html'
    ),
    (
     Name: 'LDR_CMD_CLOSE';
     Value: 'group___loader_function_constants_gaf6bbd700a446f07778f4c99640d395b3.html'
    ),
    (
     Name: 'LDR_CMD_DELETE';
     Value: 'group___loader_function_constants_ga92c2e8d1c33d3394e03c7c58d39edd42.html'
    ),
    (
     Name: 'LDR_CMD_FINDFIRST';
     Value: 'group___loader_function_constants_gaaf18cda840c1ea3bc8fe8fea1321bdbe.html'
    ),
    (
     Name: 'LDR_CMD_FINDNEXT';
     Value: 'group___loader_function_constants_ga178c2aac881f30bd79a76679d05c433d.html'
    ),
    (
     Name: 'LDR_CMD_VERSIONS';
     Value: 'group___loader_function_constants_gad5d7d835a0f7f9e61fb7c0f1f05a5ae3.html'
    ),
    (
     Name: 'LDR_CMD_OPENWRITELINEAR';
     Value: 'group___loader_function_constants_ga0ef8248d70224fc06d9d7f3f461f73df.html'
    ),
    (
     Name: 'LDR_CMD_OPENREADLINEAR';
     Value: 'group___loader_function_constants_ga1f0e6b91cc9ec5702b842834a0175570.html'
    ),
    (
     Name: 'LDR_CMD_OPENWRITEDATA';
     Value: 'group___loader_function_constants_ga22f539a7c537b37bb43cd22308fe3ed0.html'
    ),
    (
     Name: 'LDR_CMD_OPENAPPENDDATA';
     Value: 'group___loader_function_constants_gaee523186cfadc82000fb5ca37b7da408.html'
    ),
    (
     Name: 'LDR_CMD_CROPDATAFILE';
     Value: 'group___loader_function_constants_gaa424c6cdf14b20f9616466200b6ae12d.html'
    ),
    (
     Name: 'LDR_CMD_FINDFIRSTMODULE';
     Value: 'group___loader_function_constants_gad9af4605253d58c3542e494bf814a3d5.html'
    ),
    (
     Name: 'LDR_CMD_FINDNEXTMODULE';
     Value: 'group___loader_function_constants_gad0df065433b938d27171901032498824.html'
    ),
    (
     Name: 'LDR_CMD_CLOSEMODHANDLE';
     Value: 'group___loader_function_constants_ga5114dac2ec86878b2d924d7512177f3f.html'
    ),
    (
     Name: 'LDR_CMD_IOMAPREAD';
     Value: 'group___loader_function_constants_gab6878db2ae58f1c1e5d14ca4df4ccc20.html'
    ),
    (
     Name: 'LDR_CMD_IOMAPWRITE';
     Value: 'group___loader_function_constants_gafa22d5f7c90c1d91f7c8912e4046e5c6.html'
    ),
    (
     Name: 'LDR_CMD_BOOTCMD';
     Value: 'group___loader_function_constants_gab3ad1d50f8d5f017c055067877e3768c.html'
    ),
    (
     Name: 'LDR_CMD_SETBRICKNAME';
     Value: 'group___loader_function_constants_ga7f2bc91c03154dc85359d17953b3987d.html'
    ),
    (
     Name: 'LDR_CMD_BTGETADR';
     Value: 'group___loader_function_constants_ga44b70b36039429246ad2167012326a65.html'
    ),
    (
     Name: 'LDR_CMD_DEVICEINFO';
     Value: 'group___loader_function_constants_gad7c56bc6d4ec79faa8988210bf589da8.html'
    ),
    (
     Name: 'LDR_CMD_DELETEUSERFLASH';
     Value: 'group___loader_function_constants_gab3b9d1e3f6d2c13e310bdd5c0cc99a74.html'
    ),
    (
     Name: 'LDR_CMD_POLLCMDLEN';
     Value: 'group___loader_function_constants_ga1aa39440cdd88795fb0dbebda70156fd.html'
    ),
    (
     Name: 'LDR_CMD_POLLCMD';
     Value: 'group___loader_function_constants_ga90ae7fd48bf15fddcd14129ef46cbd8e.html'
    ),
    (
     Name: 'LDR_CMD_RENAMEFILE';
     Value: 'group___loader_function_constants_ga2e7a2fdf8b2a99bfb596e648dd5366ae.html'
    ),
    (
     Name: 'LDR_CMD_BTFACTORYRESET';
     Value: 'group___loader_function_constants_ga232ad111a40bea56adb946a9ed37059c.html'
    ),
    (
     Name: 'LDR_CMD_RESIZEDATAFILE';
     Value: 'group___loader_function_constants_ga0d107ae7f25fcbb136891e53065990fe.html'
    ),
    (
     Name: 'LDR_CMD_SEEKFROMSTART';
     Value: 'group___loader_function_constants_ga883d3f9aca7eb2a2ccd2cf3e39b087fe.html'
    ),
    (
     Name: 'LDR_CMD_SEEKFROMCURRENT';
     Value: 'group___loader_function_constants_gae07978535b0edcfe76435fe6361cfe8a.html'
    ),
    (
     Name: 'LDR_CMD_SEEKFROMEND';
     Value: 'group___loader_function_constants_gae2928ca18d511f1e431602bcae75fe54.html'
    ),
    (
     Name: 'SOUND_FLAGS_IDLE';
     Value: 'group___sound_flags_constants_ga4162e3853486bd7dab3c97ab8287fca3.html'
    ),
    (
     Name: 'SOUND_FLAGS_UPDATE';
     Value: 'group___sound_flags_constants_ga7ab0aa253db07e2cf043572055175c0f.html'
    ),
    (
     Name: 'SOUND_FLAGS_RUNNING';
     Value: 'group___sound_flags_constants_ga044316b3e2c27caac2322f2328ad66e2.html'
    ),
    (
     Name: 'SOUND_STATE_IDLE';
     Value: 'group___sound_state_constants_ga9842ea2c7f2ee0a13437e98060c3a389.html'
    ),
    (
     Name: 'SOUND_STATE_FILE';
     Value: 'group___sound_state_constants_gabd1c6a3bcb2321f540438e61ecb26728.html'
    ),
    (
     Name: 'SOUND_STATE_TONE';
     Value: 'group___sound_state_constants_ga6fe95355af973a83ecb07da64393fe08.html'
    ),
    (
     Name: 'SOUND_STATE_STOP';
     Value: 'group___sound_state_constants_ga6153bb2a43188aaa84fa6c0ef6f6a992.html'
    ),
    (
     Name: 'SOUND_MODE_ONCE';
     Value: 'group___sound_mode_constants_ga1538549f2e5883c161040bbd93bf80d7.html'
    ),
    (
     Name: 'SOUND_MODE_LOOP';
     Value: 'group___sound_mode_constants_gaaafcfef1a0f7c97c767e2e8b02381e6c.html'
    ),
    (
     Name: 'SOUND_MODE_TONE';
     Value: 'group___sound_mode_constants_gae7161272360c753c746e7d9a7183c9f6.html'
    ),
    (
     Name: 'SoundOffsetFreq';
     Value: 'group___sound_i_o_m_a_p_gab428437d816dad8839041dd175959418.html'
    ),
    (
     Name: 'SoundOffsetDuration';
     Value: 'group___sound_i_o_m_a_p_gad08b9852b3b74c9eac549731a928c365.html'
    ),
    (
     Name: 'SoundOffsetSampleRate';
     Value: 'group___sound_i_o_m_a_p_ga21f09cea446ac5184f93ff0c22c7fc7b.html'
    ),
    (
     Name: 'SoundOffsetSoundFilename';
     Value: 'group___sound_i_o_m_a_p_ga1158d5873dde2c48c8db6f9e852679d8.html'
    ),
    (
     Name: 'SoundOffsetFlags';
     Value: 'group___sound_i_o_m_a_p_gabeaf3d153084f75a6dcc29d76177ddee.html'
    ),
    (
     Name: 'SoundOffsetState';
     Value: 'group___sound_i_o_m_a_p_ga3fc4f576e607279dd5f2da81400244d4.html'
    ),
    (
     Name: 'SoundOffsetMode';
     Value: 'group___sound_i_o_m_a_p_ga9feb3621279e0085d7feee70f3f4805b.html'
    ),
    (
     Name: 'SoundOffsetVolume';
     Value: 'group___sound_i_o_m_a_p_gaf302d7b31ecaed9b1333596d242cfd44.html'
    ),
    (
     Name: 'FREQUENCY_MIN';
     Value: 'group___sound_misc_gaab1126a23f72e0d2b7e271f19ee330ba.html'
    ),
    (
     Name: 'FREQUENCY_MAX';
     Value: 'group___sound_misc_ga723455414fa26047e35c5e96c09ccf0c.html'
    ),
    (
     Name: 'SAMPLERATE_MIN';
     Value: 'group___sound_misc_ga8f323f89bae7b127cc77a84e5053bbfe.html'
    ),
    (
     Name: 'SAMPLERATE_DEFAULT';
     Value: 'group___sound_misc_ga152c08e80a1b3da91f2b4ca610a4f2d9.html'
    ),
    (
     Name: 'SAMPLERATE_MAX';
     Value: 'group___sound_misc_gaed8e727e6d441332ca24f89687a76575.html'
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
     Name: 'BTN1';
     Value: 'group___button_name_constants_ga3a4cc5e218cef7de139625a519e29ff3.html'
    ),
    (
     Name: 'BTN2';
     Value: 'group___button_name_constants_ga9dc19cdd6944e087c077044296a1ad8e.html'
    ),
    (
     Name: 'BTN3';
     Value: 'group___button_name_constants_ga32ab148d835d10ad11a9cdef186a3a13.html'
    ),
    (
     Name: 'BTN4';
     Value: 'group___button_name_constants_ga58e3866ab149e4384d37befbfb8bb41f.html'
    ),
    (
     Name: 'BTNEXIT';
     Value: 'group___button_name_constants_ga5918915df53368f5a085b42a1bdc57f3.html'
    ),
    (
     Name: 'BTNRIGHT';
     Value: 'group___button_name_constants_ga79f1c288a0bd8e0777a1fc0a3b28c643.html'
    ),
    (
     Name: 'BTNLEFT';
     Value: 'group___button_name_constants_ga1ba2040e55941f3c9d8e0bd444615985.html'
    ),
    (
     Name: 'BTNCENTER';
     Value: 'group___button_name_constants_ga0638ee8c73da7c04c9a56a6de29539bb.html'
    ),
    (
     Name: 'NO_OF_BTNS';
     Value: 'group___button_name_constants_gaa3f7ac374b8264d68616cd71502dab2e.html'
    ),
    (
     Name: 'BTNSTATE_PRESSED_EV';
     Value: 'group___button_state_constants_ga7926ffe0dd74d9b03d04eac83510fc52.html'
    ),
    (
     Name: 'BTNSTATE_SHORT_RELEASED_EV';
     Value: 'group___button_state_constants_ga36f62c421684b1b8f65d7e6538443bd4.html'
    ),
    (
     Name: 'BTNSTATE_LONG_PRESSED_EV';
     Value: 'group___button_state_constants_ga7758e91eeb1605b621c213a7c74222d1.html'
    ),
    (
     Name: 'BTNSTATE_LONG_RELEASED_EV';
     Value: 'group___button_state_constants_ga8112d8e4f1ccb6ec8f8216978169b873.html'
    ),
    (
     Name: 'BTNSTATE_PRESSED_STATE';
     Value: 'group___button_state_constants_gab259b297f5769357620e4bac6ca1a822.html'
    ),
    (
     Name: 'BTNSTATE_NONE';
     Value: 'group___button_state_constants_ga717591de44b35246471ff1e8f5b191ce.html'
    ),
    (
     Name: 'ButtonOffsetPressedCnt';
     Value: 'group___button_i_o_m_a_p_ga78e6fd4f8ac156488111a10a843d1801.html'
    ),
    (
     Name: 'ButtonOffsetLongPressCnt';
     Value: 'group___button_i_o_m_a_p_ga55a1386350d7b0d93354a0d2a5b792e2.html'
    ),
    (
     Name: 'ButtonOffsetShortRelCnt';
     Value: 'group___button_i_o_m_a_p_ga0d8c2881a957cd2f30994adab17b8ebf.html'
    ),
    (
     Name: 'ButtonOffsetLongRelCnt';
     Value: 'group___button_i_o_m_a_p_ga07cc43dd06127aaaf8d6ec644b6d222c.html'
    ),
    (
     Name: 'ButtonOffsetRelCnt';
     Value: 'group___button_i_o_m_a_p_ga9a5a914fd297ec47d8dfcfe81043a616.html'
    ),
    (
     Name: 'ButtonOffsetState';
     Value: 'group___button_i_o_m_a_p_ga21a2d0f644b2bf38187a8f975770358a.html'
    ),
    (
     Name: 'UI_FLAGS_UPDATE';
     Value: 'group___ui_flags_constants_ga399973ec09ef081203a0031cf5215777.html'
    ),
    (
     Name: 'UI_FLAGS_DISABLE_LEFT_RIGHT_ENTER';
     Value: 'group___ui_flags_constants_ga8e2a0c2b87504886e42b7b8ecea652d8.html'
    ),
    (
     Name: 'UI_FLAGS_DISABLE_EXIT';
     Value: 'group___ui_flags_constants_ga6ec8810a99ea24979de3aaadf437bee5.html'
    ),
    (
     Name: 'UI_FLAGS_REDRAW_STATUS';
     Value: 'group___ui_flags_constants_gae7a3f2bb9ecc482c48db49a09f7c1f49.html'
    ),
    (
     Name: 'UI_FLAGS_RESET_SLEEP_TIMER';
     Value: 'group___ui_flags_constants_ga5d71dc806e5db1d1311594309ff83ca9.html'
    ),
    (
     Name: 'UI_FLAGS_EXECUTE_LMS_FILE';
     Value: 'group___ui_flags_constants_ga5d3c2873d39985365fcaed9b6f35da87.html'
    ),
    (
     Name: 'UI_FLAGS_BUSY';
     Value: 'group___ui_flags_constants_ga1690b884f16149949ebc7328cffd4924.html'
    ),
    (
     Name: 'UI_FLAGS_ENABLE_STATUS_UPDATE';
     Value: 'group___ui_flags_constants_ga759399beeb61fedc1c77ea74f3a23a79.html'
    ),
    (
     Name: 'UI_STATE_INIT_DISPLAY';
     Value: 'group___ui_state_constants_ga1a20a93e09aee5b5b582e3c307bd1184.html'
    ),
    (
     Name: 'UI_STATE_INIT_LOW_BATTERY';
     Value: 'group___ui_state_constants_gaafd4a7f9c45edf87c3a1906fe4d4c770.html'
    ),
    (
     Name: 'UI_STATE_INIT_INTRO';
     Value: 'group___ui_state_constants_ga7871910e5371b740151c776293e172ef.html'
    ),
    (
     Name: 'UI_STATE_INIT_WAIT';
     Value: 'group___ui_state_constants_ga30bc6252ca8437033c456d93b5763987.html'
    ),
    (
     Name: 'UI_STATE_INIT_MENU';
     Value: 'group___ui_state_constants_ga9df9616934b4c042fb20212acc43d8b4.html'
    ),
    (
     Name: 'UI_STATE_NEXT_MENU';
     Value: 'group___ui_state_constants_gae0990493f40e67469ec28a0ee07df11a.html'
    ),
    (
     Name: 'UI_STATE_DRAW_MENU';
     Value: 'group___ui_state_constants_ga44b0e784e1a4ad0b35d0e031d9c8b48d.html'
    ),
    (
     Name: 'UI_STATE_TEST_BUTTONS';
     Value: 'group___ui_state_constants_ga3f5ab3bafe35d841a8843f764b80ad70.html'
    ),
    (
     Name: 'UI_STATE_LEFT_PRESSED';
     Value: 'group___ui_state_constants_ga23c4d1a2d2ec51eb576f6eabfbf43dbd.html'
    ),
    (
     Name: 'UI_STATE_RIGHT_PRESSED';
     Value: 'group___ui_state_constants_ga4a62b245437f09541eff2351f31cd69f.html'
    ),
    (
     Name: 'UI_STATE_ENTER_PRESSED';
     Value: 'group___ui_state_constants_ga8e6ad547cb05e466c2fb268655e63d30.html'
    ),
    (
     Name: 'UI_STATE_EXIT_PRESSED';
     Value: 'group___ui_state_constants_ga24cf08e79804666eba3bfa4ba44d25c6.html'
    ),
    (
     Name: 'UI_STATE_CONNECT_REQUEST';
     Value: 'group___ui_state_constants_gabd23393709acd6b5d98c9f765fed1c86.html'
    ),
    (
     Name: 'UI_STATE_EXECUTE_FILE';
     Value: 'group___ui_state_constants_ga8268ec36ba76f50625bbc9541c2720ad.html'
    ),
    (
     Name: 'UI_STATE_EXECUTING_FILE';
     Value: 'group___ui_state_constants_ga7a562a973e1877b24a17cdcd4ea9843c.html'
    ),
    (
     Name: 'UI_STATE_LOW_BATTERY';
     Value: 'group___ui_state_constants_ga45207d6ff0d0823b96003ddb1ec355a5.html'
    ),
    (
     Name: 'UI_STATE_BT_ERROR';
     Value: 'group___ui_state_constants_gaa5d0aecd30a243ed407574568efc1826.html'
    ),
    (
     Name: 'UI_BUTTON_NONE';
     Value: 'group___ui_button_constants_ga8d44190bb7c0a42bb3d8e119e081e40d.html'
    ),
    (
     Name: 'UI_BUTTON_LEFT';
     Value: 'group___ui_button_constants_ga051661db9771c61767c64bd5424d8fcd.html'
    ),
    (
     Name: 'UI_BUTTON_ENTER';
     Value: 'group___ui_button_constants_gaf05c561e419e7358815eec41ad8f6c67.html'
    ),
    (
     Name: 'UI_BUTTON_RIGHT';
     Value: 'group___ui_button_constants_ga91a86cf77463700fb1f2be34b742dacc.html'
    ),
    (
     Name: 'UI_BUTTON_EXIT';
     Value: 'group___ui_button_constants_ga75158da4b6e32b3b52a62ddaeae40ef8.html'
    ),
    (
     Name: 'UI_BT_STATE_VISIBLE';
     Value: 'group___ui_bluetooth_state_constants_ga054e31780e8069c08cd5f85aa0005239.html'
    ),
    (
     Name: 'UI_BT_STATE_CONNECTED';
     Value: 'group___ui_bluetooth_state_constants_ga6c7b75b65c6a16b046bb16184ff61e9a.html'
    ),
    (
     Name: 'UI_BT_STATE_OFF';
     Value: 'group___ui_bluetooth_state_constants_gadaf739ae9e6962b668b09f27949924bf.html'
    ),
    (
     Name: 'UI_BT_ERROR_ATTENTION';
     Value: 'group___ui_bluetooth_state_constants_gae508909e5cc6982c56b6a663a7b1a3d4.html'
    ),
    (
     Name: 'UI_BT_CONNECT_REQUEST';
     Value: 'group___ui_bluetooth_state_constants_ga2523e16b3aa85f77f396f06c4d914343.html'
    ),
    (
     Name: 'UI_BT_PIN_REQUEST';
     Value: 'group___ui_bluetooth_state_constants_gae622b1e73ff2339a8de39fbc30463331.html'
    ),
    (
     Name: 'UI_VM_IDLE';
     Value: 'group___ui_v_m_run_state_constants_ga13a732675360ceca11e055db3f94c7e0.html'
    ),
    (
     Name: 'UI_VM_RUN_FREE';
     Value: 'group___ui_v_m_run_state_constants_ga515a479fe8559d3d6ce2e2bb5b875ee5.html'
    ),
    (
     Name: 'UI_VM_RUN_SINGLE';
     Value: 'group___ui_v_m_run_state_constants_ga5c319f2a7dbde957a9f6e4467bdb8d61.html'
    ),
    (
     Name: 'UI_VM_RUN_PAUSE';
     Value: 'group___ui_v_m_run_state_constants_ga49d4777c506a5f7c0fe198a264eb49ce.html'
    ),
    (
     Name: 'UI_VM_RESET1';
     Value: 'group___ui_v_m_run_state_constants_ga5702ded484fc36878e7ecf29fc673264.html'
    ),
    (
     Name: 'UI_VM_RESET2';
     Value: 'group___ui_v_m_run_state_constants_gae639bd062fe47e709d4434f3ece5aa65.html'
    ),
    (
     Name: 'UIOffsetPMenu';
     Value: 'group___ui_i_o_m_a_p_ga17099befed6339f3906748ca5b698973.html'
    ),
    (
     Name: 'UIOffsetBatteryVoltage';
     Value: 'group___ui_i_o_m_a_p_gaf65203a967608eaa8716faa4ef03d57a.html'
    ),
    (
     Name: 'UIOffsetLMSfilename';
     Value: 'group___ui_i_o_m_a_p_gaefb25f555aff2ed7535628fabdfcecf8.html'
    ),
    (
     Name: 'UIOffsetFlags';
     Value: 'group___ui_i_o_m_a_p_ga171acc154c2651e380e13647e578b55d.html'
    ),
    (
     Name: 'UIOffsetState';
     Value: 'group___ui_i_o_m_a_p_ga067405b2680f29ccd1abf1da0354a7e5.html'
    ),
    (
     Name: 'UIOffsetButton';
     Value: 'group___ui_i_o_m_a_p_ga882f2ecbf21e264c626b7e9025e2de33.html'
    ),
    (
     Name: 'UIOffsetRunState';
     Value: 'group___ui_i_o_m_a_p_gaac753a824aee742d3f31b24626871642.html'
    ),
    (
     Name: 'UIOffsetBatteryState';
     Value: 'group___ui_i_o_m_a_p_gaf7c9eade4b0d3ccdd25bf9e9b67665d1.html'
    ),
    (
     Name: 'UIOffsetBluetoothState';
     Value: 'group___ui_i_o_m_a_p_ga0edc7266fd8d7dad3a505b32e9122032.html'
    ),
    (
     Name: 'UIOffsetUsbState';
     Value: 'group___ui_i_o_m_a_p_ga4814714bdbc5591f67cf430dd4fa4bdf.html'
    ),
    (
     Name: 'UIOffsetSleepTimeout';
     Value: 'group___ui_i_o_m_a_p_ga109726dde539e35aa8234873b73b84d9.html'
    ),
    (
     Name: 'UIOffsetSleepTimer';
     Value: 'group___ui_i_o_m_a_p_gac27d16bbc867909607ceeea4f4251e4a.html'
    ),
    (
     Name: 'UIOffsetRechargeable';
     Value: 'group___ui_i_o_m_a_p_ga4ec3dfef8cd41c069e751dfe2892c314.html'
    ),
    (
     Name: 'UIOffsetVolume';
     Value: 'group___ui_i_o_m_a_p_gae958de436c0a5a43f72ab6eef724150d.html'
    ),
    (
     Name: 'UIOffsetError';
     Value: 'group___ui_i_o_m_a_p_gaba83c521e3660ecc09532675f44603f8.html'
    ),
    (
     Name: 'UIOffsetOBPPointer';
     Value: 'group___ui_i_o_m_a_p_ga6f995e82e63a1552b0d94e364722c029.html'
    ),
    (
     Name: 'UIOffsetForceOff';
     Value: 'group___ui_i_o_m_a_p_ga0bac067a6eb3e62f4c411a0778e5a884.html'
    ),
    (
     Name: 'UIOffsetAbortFlag';
     Value: 'group___ui_i_o_m_a_p_ga9c09c021929da11b000ab2d91ea10f15.html'
    ),
    (
     Name: 'IN_1';
     Value: 'group___n_b_c_input_port_constants_ga9f96581595ba16bf7696cde741877e1a.html'
    ),
    (
     Name: 'IN_2';
     Value: 'group___n_b_c_input_port_constants_ga66e4710ca0108a45faaa4a92852225ad.html'
    ),
    (
     Name: 'IN_3';
     Value: 'group___n_b_c_input_port_constants_ga0702b131cca172dcc6f3e8d2834dd6ee.html'
    ),
    (
     Name: 'IN_4';
     Value: 'group___n_b_c_input_port_constants_ga4493eeb6a444956c813b2e87ba54656b.html'
    ),
    (
     Name: 'IN_TYPE_NO_SENSOR';
     Value: 'group___n_b_c_sensor_type_constants_gaaca5d10ac39447e29204b5c613eb823a.html'
    ),
    (
     Name: 'IN_TYPE_SWITCH';
     Value: 'group___n_b_c_sensor_type_constants_gac720fd06428ca2c38941905df7fc6a70.html'
    ),
    (
     Name: 'IN_TYPE_TEMPERATURE';
     Value: 'group___n_b_c_sensor_type_constants_gabadfd1047ea0005493bae72d49e11d9e.html'
    ),
    (
     Name: 'IN_TYPE_REFLECTION';
     Value: 'group___n_b_c_sensor_type_constants_ga20cc1c7a8a9a999f60a39c0a09e0d4cc.html'
    ),
    (
     Name: 'IN_TYPE_ANGLE';
     Value: 'group___n_b_c_sensor_type_constants_ga023ae9cd616a44a075cf7d686807ce5f.html'
    ),
    (
     Name: 'IN_TYPE_LIGHT_ACTIVE';
     Value: 'group___n_b_c_sensor_type_constants_gac10a95effd0f5d945530ca3cd00d0b57.html'
    ),
    (
     Name: 'IN_TYPE_LIGHT_INACTIVE';
     Value: 'group___n_b_c_sensor_type_constants_ga33ae2b9169f63c3b8076050b0dd6edad.html'
    ),
    (
     Name: 'IN_TYPE_SOUND_DB';
     Value: 'group___n_b_c_sensor_type_constants_gabf40ad1fbc5c3982bc3f5e98ef133c2c.html'
    ),
    (
     Name: 'IN_TYPE_SOUND_DBA';
     Value: 'group___n_b_c_sensor_type_constants_gac5b8c983aa563dad9457bfe25e39013e.html'
    ),
    (
     Name: 'IN_TYPE_CUSTOM';
     Value: 'group___n_b_c_sensor_type_constants_gab867de89cb9cd160ad8eb117baf8b208.html'
    ),
    (
     Name: 'IN_TYPE_LOWSPEED';
     Value: 'group___n_b_c_sensor_type_constants_gab1fd6f73e1a2825a8690a87aba306f45.html'
    ),
    (
     Name: 'IN_TYPE_LOWSPEED_9V';
     Value: 'group___n_b_c_sensor_type_constants_gae01491f34b81384cdc2e327cf53f8096.html'
    ),
    (
     Name: 'IN_TYPE_HISPEED';
     Value: 'group___n_b_c_sensor_type_constants_ga8e8b8f31caa13e7824b98253f4e9bfa0.html'
    ),
    (
     Name: 'IN_TYPE_COLORFULL';
     Value: 'group___n_b_c_sensor_type_constants_ga388cde123fad566d9434b29087a61e86.html'
    ),
    (
     Name: 'IN_TYPE_COLORRED';
     Value: 'group___n_b_c_sensor_type_constants_gad7d1e54d98a80d3364663909a8b51e4d.html'
    ),
    (
     Name: 'IN_TYPE_COLORGREEN';
     Value: 'group___n_b_c_sensor_type_constants_ga1e6f3386103c8cf9048f103db61e5769.html'
    ),
    (
     Name: 'IN_TYPE_COLORBLUE';
     Value: 'group___n_b_c_sensor_type_constants_ga980dfe3add1ab5c796b00e49d428fb0c.html'
    ),
    (
     Name: 'IN_TYPE_COLORNONE';
     Value: 'group___n_b_c_sensor_type_constants_gaa8ba82485d4535d8e484718f7d401c60.html'
    ),
    (
     Name: 'IN_TYPE_COLOREXIT';
     Value: 'group___n_b_c_sensor_type_constants_ga08f556c96351ed23c8f3ccee36dac426.html'
    ),
    (
     Name: 'IN_MODE_RAW';
     Value: 'group___n_b_c_sensor_mode_constants_gaa7265e6ee2e2452960ca53456c752bfa.html'
    ),
    (
     Name: 'IN_MODE_BOOLEAN';
     Value: 'group___n_b_c_sensor_mode_constants_gacee330a407c7303dd8b3eb0eba746a90.html'
    ),
    (
     Name: 'IN_MODE_TRANSITIONCNT';
     Value: 'group___n_b_c_sensor_mode_constants_ga0932ffbc46a4b66b76017efa51bc8c13.html'
    ),
    (
     Name: 'IN_MODE_PERIODCOUNTER';
     Value: 'group___n_b_c_sensor_mode_constants_gae117f04df4ccdcc4a22c63baefe84986.html'
    ),
    (
     Name: 'IN_MODE_PCTFULLSCALE';
     Value: 'group___n_b_c_sensor_mode_constants_gaaca3c95d36be5180d0a5e7cf2c654ada.html'
    ),
    (
     Name: 'IN_MODE_CELSIUS';
     Value: 'group___n_b_c_sensor_mode_constants_ga6c32cc612795e4da468691a7ee110def.html'
    ),
    (
     Name: 'IN_MODE_FAHRENHEIT';
     Value: 'group___n_b_c_sensor_mode_constants_gac2eee470c1058e46050b4a1009f38f42.html'
    ),
    (
     Name: 'IN_MODE_ANGLESTEP';
     Value: 'group___n_b_c_sensor_mode_constants_ga7bcd02a1b0b4441d87bbe739e7d5390f.html'
    ),
    (
     Name: 'IN_MODE_SLOPEMASK';
     Value: 'group___n_b_c_sensor_mode_constants_ga5482fe1c9c330ed9961df6794ca48648.html'
    ),
    (
     Name: 'IN_MODE_MODEMASK';
     Value: 'group___n_b_c_sensor_mode_constants_ga544337aeb5577a74051ccf94f3666109.html'
    ),
    (
     Name: 'TypeField';
     Value: 'group___input_field_constants_ga8e2023454ae2bf23914c98347e490c3c.html'
    ),
    (
     Name: 'InputModeField';
     Value: 'group___input_field_constants_ga3abfec79648ceddd0dead20674efba9b.html'
    ),
    (
     Name: 'RawValueField';
     Value: 'group___input_field_constants_ga930ec7a68aa71d31da8bae8f63942e33.html'
    ),
    (
     Name: 'NormalizedValueField';
     Value: 'group___input_field_constants_gac957b812aad4092d97eb04241e6b53b7.html'
    ),
    (
     Name: 'ScaledValueField';
     Value: 'group___input_field_constants_ga7c552b90dc7f01b3b581b4023e71693a.html'
    ),
    (
     Name: 'InvalidDataField';
     Value: 'group___input_field_constants_gaf1f2f17f4b8c6863bb9b6301a8765321.html'
    ),
    (
     Name: 'INPUT_DIGI0';
     Value: 'group___input_digi_pin_constants_gad78c594fbae4333ba96cc7aeae31c101.html'
    ),
    (
     Name: 'INPUT_DIGI1';
     Value: 'group___input_digi_pin_constants_ga335f5381a75a2fde58d057696c91c996.html'
    ),
    (
     Name: 'INPUT_CUSTOMINACTIVE';
     Value: 'group___input_module_constants_gaba5429d22d8cee53d7770ca6eb510640.html'
    ),
    (
     Name: 'INPUT_CUSTOM9V';
     Value: 'group___input_module_constants_ga9225d90bd7214db57bdaf597c50695fc.html'
    ),
    (
     Name: 'INPUT_CUSTOMACTIVE';
     Value: 'group___input_module_constants_ga8f837fa64bc9903d75a9da1ca0019f22.html'
    ),
    (
     Name: 'INPUT_INVALID_DATA';
     Value: 'group___input_module_constants_gaa9ad86d8fa7d51f9b10e55e19e6d1904.html'
    ),
    (
     Name: 'INPUT_RED';
     Value: 'group___input_color_idx_constants_gad7c28c0a4df123e7f77f6915d10eb692.html'
    ),
    (
     Name: 'INPUT_GREEN';
     Value: 'group___input_color_idx_constants_ga014e5b96253a1a1a8ac710234c0e378a.html'
    ),
    (
     Name: 'INPUT_BLUE';
     Value: 'group___input_color_idx_constants_gab706ced296f90335645759904052ce48.html'
    ),
    (
     Name: 'INPUT_BLANK';
     Value: 'group___input_color_idx_constants_ga4d76ca2a84464a2b80c90049b54b7c6e.html'
    ),
    (
     Name: 'INPUT_NO_OF_COLORS';
     Value: 'group___input_color_idx_constants_ga17f24cfc2d31b0a9a7c61c5a24d829e9.html'
    ),
    (
     Name: 'INPUT_BLACKCOLOR';
     Value: 'group___input_color_value_constants_ga8f56aaf09cd6006c2a709c560578b40c.html'
    ),
    (
     Name: 'INPUT_BLUECOLOR';
     Value: 'group___input_color_value_constants_gaa868a89c82831a208b879886c43eb4e4.html'
    ),
    (
     Name: 'INPUT_GREENCOLOR';
     Value: 'group___input_color_value_constants_gaef0d4ea2f2f340cda28f29ddef326f2d.html'
    ),
    (
     Name: 'INPUT_YELLOWCOLOR';
     Value: 'group___input_color_value_constants_gad2e568d2e21ba7d6a4118486f8a50595.html'
    ),
    (
     Name: 'INPUT_REDCOLOR';
     Value: 'group___input_color_value_constants_ga94f45c51cfd8b3439d108c68f21d56c8.html'
    ),
    (
     Name: 'INPUT_WHITECOLOR';
     Value: 'group___input_color_value_constants_ga0575a8d959e500a29fd99fb202769460.html'
    ),
    (
     Name: 'INPUT_SENSORCAL';
     Value: 'group___input_color_calibration_state_constants_ga9d51210efeb612d475eb3f5405bad109.html'
    ),
    (
     Name: 'INPUT_SENSOROFF';
     Value: 'group___input_color_calibration_state_constants_ga31263b1bb364122c680af11e800fa6cb.html'
    ),
    (
     Name: 'INPUT_RUNNINGCAL';
     Value: 'group___input_color_calibration_state_constants_ga34c37f5ef2e93120640248e568585da9.html'
    ),
    (
     Name: 'INPUT_STARTCAL';
     Value: 'group___input_color_calibration_state_constants_ga6e1834dd75c68bcc98de9468561932b2.html'
    ),
    (
     Name: 'INPUT_RESETCAL';
     Value: 'group___input_color_calibration_state_constants_ga3eb64b7f274f61c4a999e3e6f7717293.html'
    ),
    (
     Name: 'INPUT_CAL_POINT_0';
     Value: 'group___input_color_calibration_constants_ga18219d1a5d56ba51e94adf589946e1da.html'
    ),
    (
     Name: 'INPUT_CAL_POINT_1';
     Value: 'group___input_color_calibration_constants_ga9119c55ed0cf380b12a4cd2fb09a4be6.html'
    ),
    (
     Name: 'INPUT_CAL_POINT_2';
     Value: 'group___input_color_calibration_constants_gaefde1c10aaa5bf02d7b23c7bcf64c194.html'
    ),
    (
     Name: 'INPUT_NO_OF_POINTS';
     Value: 'group___input_color_calibration_constants_ga0c647e813fec144e9186dcb5096e0e3c.html'
    ),
    (
     Name: 'InputOffsetCustomZeroOffset';
     Value: 'group___input_i_o_m_a_p_gafbb22abff2ff16ba18e1f59c021d1820.html'
    ),
    (
     Name: 'InputOffsetADRaw';
     Value: 'group___input_i_o_m_a_p_gae70de7cfe4a02def2bc0af82bd2ffb1c.html'
    ),
    (
     Name: 'InputOffsetSensorRaw';
     Value: 'group___input_i_o_m_a_p_gac4d9feee19d2d599bb6618b703795e5d.html'
    ),
    (
     Name: 'InputOffsetSensorValue';
     Value: 'group___input_i_o_m_a_p_ga14ed59ad6fb7c52f464f05ed679b5c23.html'
    ),
    (
     Name: 'InputOffsetSensorType';
     Value: 'group___input_i_o_m_a_p_ga68619da03edc3bc28acc305776614a90.html'
    ),
    (
     Name: 'InputOffsetSensorMode';
     Value: 'group___input_i_o_m_a_p_gafdcf3f4faf496ded6eb1f664612c442a.html'
    ),
    (
     Name: 'InputOffsetSensorBoolean';
     Value: 'group___input_i_o_m_a_p_gae7245ea2272bfc8959766885164f6846.html'
    ),
    (
     Name: 'InputOffsetDigiPinsDir';
     Value: 'group___input_i_o_m_a_p_ga56e4186c7f2abc4121911578018efbe4.html'
    ),
    (
     Name: 'InputOffsetDigiPinsIn';
     Value: 'group___input_i_o_m_a_p_ga34704846fd5a0451ec0971fb9cd18172.html'
    ),
    (
     Name: 'InputOffsetDigiPinsOut';
     Value: 'group___input_i_o_m_a_p_gac456c04fee49e43440c050a9c6a69548.html'
    ),
    (
     Name: 'InputOffsetCustomPctFullScale';
     Value: 'group___input_i_o_m_a_p_ga2d4d3da68af2b2944e320219bc545bec.html'
    ),
    (
     Name: 'InputOffsetCustomActiveStatus';
     Value: 'group___input_i_o_m_a_p_gae3fa8958e2f75e4e1921fcf21624b5c2.html'
    ),
    (
     Name: 'InputOffsetInvalidData';
     Value: 'group___input_i_o_m_a_p_ga9f1d823bca30c07b85f9a716336d2033.html'
    ),
    (
     Name: 'InputOffsetColorCalibration';
     Value: 'group___input_i_o_m_a_p_ga67e0596e413e19f74b0d2136ec3f6187.html'
    ),
    (
     Name: 'InputOffsetColorCalLimits';
     Value: 'group___input_i_o_m_a_p_gab2e7775ebebd6f3a79dcdb0e2202c19b.html'
    ),
    (
     Name: 'InputOffsetColorADRaw';
     Value: 'group___input_i_o_m_a_p_ga0238c458bc7ce28981ff8dbeb7f69c25.html'
    ),
    (
     Name: 'InputOffsetColorSensorRaw';
     Value: 'group___input_i_o_m_a_p_gac7d335a435039d2a3d7e3ef9b54469a3.html'
    ),
    (
     Name: 'InputOffsetColorSensorValue';
     Value: 'group___input_i_o_m_a_p_ga48812c03031f08b5c181a3756817ebda.html'
    ),
    (
     Name: 'InputOffsetColorBoolean';
     Value: 'group___input_i_o_m_a_p_gaafe8e00d90dc5070d5b37f9493d884f4.html'
    ),
    (
     Name: 'InputOffsetColorCalibrationState';
     Value: 'group___input_i_o_m_a_p_gabd3c28426fcb8b6cf1c2d417b792ad1c.html'
    ),
    (
     Name: 'OUT_A';
     Value: 'group___output_port_constants_ga26800436eab9c6012bfb27f225b7d7a5.html'
    ),
    (
     Name: 'OUT_B';
     Value: 'group___output_port_constants_gae1c048e227993b7ee275e34cc6f385dc.html'
    ),
    (
     Name: 'OUT_C';
     Value: 'group___output_port_constants_gac1e9da1cfa44fe7f20f8a23390e9f0c7.html'
    ),
    (
     Name: 'OUT_AB';
     Value: 'group___output_port_constants_ga1e92dd8c4beec783cc67a9ae280935cc.html'
    ),
    (
     Name: 'OUT_AC';
     Value: 'group___output_port_constants_ga8a5057008eb937a06d4b85f37c3d8138.html'
    ),
    (
     Name: 'OUT_BC';
     Value: 'group___output_port_constants_ga804311126c87dfb2e7a8b85398bbd66d.html'
    ),
    (
     Name: 'OUT_ABC';
     Value: 'group___output_port_constants_ga42c78ce271482711c419b30e3c7bfe3d.html'
    ),
    (
     Name: 'PID_0';
     Value: 'group___p_i_d_constants_gaa951eeb5ebfc3f7f2c4a82313d255a38.html'
    ),
    (
     Name: 'PID_1';
     Value: 'group___p_i_d_constants_ga64e202f97b195488c96ec0ede618b299.html'
    ),
    (
     Name: 'PID_2';
     Value: 'group___p_i_d_constants_ga2eeb6fe27f1eb1472ae2799904d1f5af.html'
    ),
    (
     Name: 'PID_3';
     Value: 'group___p_i_d_constants_gac27b13f409698a8a44da5f5b57c54a68.html'
    ),
    (
     Name: 'PID_4';
     Value: 'group___p_i_d_constants_ga6f45f6948f5c8ea0dd5c7592651799d2.html'
    ),
    (
     Name: 'PID_5';
     Value: 'group___p_i_d_constants_gabb618cb43dbae86cf329fb8fca0c180a.html'
    ),
    (
     Name: 'PID_6';
     Value: 'group___p_i_d_constants_gad4c25e52d5eb235b0d7a39bea5ea7f4e.html'
    ),
    (
     Name: 'PID_7';
     Value: 'group___p_i_d_constants_gad2a9b67128cd034928774f1509696496.html'
    ),
    (
     Name: 'UF_UPDATE_MODE';
     Value: 'group___out_u_f_constants_ga51435b54892552f635f2befff723726d.html'
    ),
    (
     Name: 'UF_UPDATE_SPEED';
     Value: 'group___out_u_f_constants_ga8424b9e698b18b877d2c35fff8d78574.html'
    ),
    (
     Name: 'UF_UPDATE_TACHO_LIMIT';
     Value: 'group___out_u_f_constants_ga49ca4d8f3bcb14245cc4051926f1feef.html'
    ),
    (
     Name: 'UF_UPDATE_RESET_COUNT';
     Value: 'group___out_u_f_constants_ga48e68c017756347b3c2e2207ff06ca14.html'
    ),
    (
     Name: 'UF_UPDATE_PID_VALUES';
     Value: 'group___out_u_f_constants_gab10aedfcbdbecab99ba131f53417b3ce.html'
    ),
    (
     Name: 'UF_UPDATE_RESET_BLOCK_COUNT';
     Value: 'group___out_u_f_constants_gae348ab4f507266ea1adef9774c7e5553.html'
    ),
    (
     Name: 'UF_UPDATE_RESET_ROTATION_COUNT';
     Value: 'group___out_u_f_constants_ga5cd2bf98a2afef0d0f01322ac0569adf.html'
    ),
    (
     Name: 'UF_PENDING_UPDATES';
     Value: 'group___out_u_f_constants_ga8f612585d7602c3877daa63b4a8135dd.html'
    ),
    (
     Name: 'RESET_NONE';
     Value: 'group___tacho_reset_constants_gae8b208eec276a5ce05739f850ad3dcb6.html'
    ),
    (
     Name: 'RESET_COUNT';
     Value: 'group___tacho_reset_constants_ga6f918b4c4fd78a6a98a73d38d327f160.html'
    ),
    (
     Name: 'RESET_BLOCK_COUNT';
     Value: 'group___tacho_reset_constants_ga2b59ade72abe1c90e959de4ae5f7067b.html'
    ),
    (
     Name: 'RESET_ROTATION_COUNT';
     Value: 'group___tacho_reset_constants_ga6573239ad5c7677e4111cdb995b5b729.html'
    ),
    (
     Name: 'RESET_BLOCKANDTACHO';
     Value: 'group___tacho_reset_constants_ga7684c80b33025e541c39ba43bba78844.html'
    ),
    (
     Name: 'RESET_ALL';
     Value: 'group___tacho_reset_constants_ga67084a90a363b9478fb18aeafd135574.html'
    ),
    (
     Name: 'OUT_MODE_COAST';
     Value: 'group___out_mode_constants_ga47332d253a44a398aa14a7593ace6cc0.html'
    ),
    (
     Name: 'OUT_MODE_MOTORON';
     Value: 'group___out_mode_constants_ga4249fc5cfb6405a45009723e6da2f6a1.html'
    ),
    (
     Name: 'OUT_MODE_BRAKE';
     Value: 'group___out_mode_constants_ga8a1e1f0c11dceb60119db50db1d5a1b5.html'
    ),
    (
     Name: 'OUT_MODE_REGULATED';
     Value: 'group___out_mode_constants_gaaff340571fba217bd46d4e912f45258c.html'
    ),
    (
     Name: 'OUT_MODE_REGMETHOD';
     Value: 'group___out_mode_constants_ga24c70ab6f99725d089df83b755728d0f.html'
    ),
    (
     Name: 'OUT_OPTION_HOLDATLIMIT';
     Value: 'group___out_option_constants_gabb99341e9f1d11b07ac9e92fb5f12a30.html'
    ),
    (
     Name: 'OUT_OPTION_RAMPDOWNTOLIMIT';
     Value: 'group___out_option_constants_gaaf5537f7d80f5de850d9a88646f455cd.html'
    ),
    (
     Name: 'OUT_REGOPTION_NO_SATURATION';
     Value: 'group___out_reg_option_constants_ga41c8ddf8711845616d6b03d5ad048593.html'
    ),
    (
     Name: 'OUT_RUNSTATE_IDLE';
     Value: 'group___out_run_state_constants_gacf6b1a9da8449ac73177323065842627.html'
    ),
    (
     Name: 'OUT_RUNSTATE_RAMPUP';
     Value: 'group___out_run_state_constants_ga1a451084217e8ed3282b84aad676c6db.html'
    ),
    (
     Name: 'OUT_RUNSTATE_RUNNING';
     Value: 'group___out_run_state_constants_gacf9eadcadceb13184412f6ed152c0529.html'
    ),
    (
     Name: 'OUT_RUNSTATE_RAMPDOWN';
     Value: 'group___out_run_state_constants_gad4e4f81f3c5f68615f13d61d936e7453.html'
    ),
    (
     Name: 'OUT_RUNSTATE_HOLD';
     Value: 'group___out_run_state_constants_gaa9009c8f75e50ce76e9958b776454f7a.html'
    ),
    (
     Name: 'OUT_REGMODE_IDLE';
     Value: 'group___out_reg_mode_constants_gad83d0d2451ddf8ec904b49ca5aa03e71.html'
    ),
    (
     Name: 'OUT_REGMODE_SPEED';
     Value: 'group___out_reg_mode_constants_gaea920a8220545614675e39c95f9f4ff0.html'
    ),
    (
     Name: 'OUT_REGMODE_SYNC';
     Value: 'group___out_reg_mode_constants_ga19a355d3ef359f3d8bc2159fa5cc5223.html'
    ),
    (
     Name: 'OUT_REGMODE_POS';
     Value: 'group___out_reg_mode_constants_ga48a38ba28cf3b5eb6dff3670e3404578.html'
    ),
    (
     Name: 'UpdateFlagsField';
     Value: 'group___output_field_constants_ga9324894d6e935871fef24f5084495e19.html'
    ),
    (
     Name: 'OutputModeField';
     Value: 'group___output_field_constants_ga35b48d72e9ef1a94ed2c1a9ee11ce49e.html'
    ),
    (
     Name: 'PowerField';
     Value: 'group___output_field_constants_ga03b0de7a59e4479208463a8f96dbab12.html'
    ),
    (
     Name: 'ActualSpeedField';
     Value: 'group___output_field_constants_gaa4347d75f0a171a2fe9ef032e0876b14.html'
    ),
    (
     Name: 'TachoCountField';
     Value: 'group___output_field_constants_gadbefe561893676f00de6af782d3c6e99.html'
    ),
    (
     Name: 'TachoLimitField';
     Value: 'group___output_field_constants_gae1ad7bc4ec75dcc0dfd1fc4241a0baff.html'
    ),
    (
     Name: 'RunStateField';
     Value: 'group___output_field_constants_ga0e7a195646903b42389e358fa482a965.html'
    ),
    (
     Name: 'TurnRatioField';
     Value: 'group___output_field_constants_ga91064f8b19e74eacc19081445c4ad3fe.html'
    ),
    (
     Name: 'RegModeField';
     Value: 'group___output_field_constants_ga783a1687b9af81c20435365efdba06ef.html'
    ),
    (
     Name: 'OverloadField';
     Value: 'group___output_field_constants_gaa3b52595839de27d7b1ba203426e1f65.html'
    ),
    (
     Name: 'RegPValueField';
     Value: 'group___output_field_constants_gad2207df2ba2fae972afe6ac609faf7e7.html'
    ),
    (
     Name: 'RegIValueField';
     Value: 'group___output_field_constants_ga9af4da9cdf7226e96e11c845b7d67251.html'
    ),
    (
     Name: 'RegDValueField';
     Value: 'group___output_field_constants_ga09e5dfb061b8e11f70764135b521fee2.html'
    ),
    (
     Name: 'BlockTachoCountField';
     Value: 'group___output_field_constants_ga63b8d2e206a10d4301c9519c5c412d8e.html'
    ),
    (
     Name: 'RotationCountField';
     Value: 'group___output_field_constants_ga6891156379ee7f8bf6261f7d7acb667a.html'
    ),
    (
     Name: 'OutputOptionsField';
     Value: 'group___output_field_constants_ga8169d3d3c8c851c27156d97d7272e751.html'
    ),
    (
     Name: 'MaxSpeedField';
     Value: 'group___output_field_constants_ga5bfe531937d84c6512885fee58fed498.html'
    ),
    (
     Name: 'MaxAccelerationField';
     Value: 'group___output_field_constants_ga8fabefa9d835342305f296fb9bdfafe6.html'
    ),
    (
     Name: 'OutputOffsetTachoCount';
     Value: 'group___output_i_o_m_a_p_ga9edae45f2614396f1335795e08f5a5e2.html'
    ),
    (
     Name: 'OutputOffsetBlockTachoCount';
     Value: 'group___output_i_o_m_a_p_gab599e087d4f79acdd2728db0b5115062.html'
    ),
    (
     Name: 'OutputOffsetRotationCount';
     Value: 'group___output_i_o_m_a_p_gabae865f8ca3f559148243e2996f07242.html'
    ),
    (
     Name: 'OutputOffsetTachoLimit';
     Value: 'group___output_i_o_m_a_p_ga2172dc3d243e45a43d9b17aec1688f1b.html'
    ),
    (
     Name: 'OutputOffsetMotorRPM';
     Value: 'group___output_i_o_m_a_p_ga43b257554ac09389ab23e85f985b74a2.html'
    ),
    (
     Name: 'OutputOffsetFlags';
     Value: 'group___output_i_o_m_a_p_ga98fd2d7c4475fa01448a09cfe2a9d706.html'
    ),
    (
     Name: 'OutputOffsetMode';
     Value: 'group___output_i_o_m_a_p_ga0905b3639cee9d637dd7dad9e5b90c55.html'
    ),
    (
     Name: 'OutputOffsetSpeed';
     Value: 'group___output_i_o_m_a_p_ga8a2c5541f78396b26b1725fbc829ffb5.html'
    ),
    (
     Name: 'OutputOffsetActualSpeed';
     Value: 'group___output_i_o_m_a_p_gaebf3712fff9466713cf2d32ca4ba4978.html'
    ),
    (
     Name: 'OutputOffsetRegPParameter';
     Value: 'group___output_i_o_m_a_p_ga99245b384932b70062897f67af124644.html'
    ),
    (
     Name: 'OutputOffsetRegIParameter';
     Value: 'group___output_i_o_m_a_p_gac37bd801e76715768200a6825ef927e0.html'
    ),
    (
     Name: 'OutputOffsetRegDParameter';
     Value: 'group___output_i_o_m_a_p_gaf9009ae7c31f2ab3ec31ffab0db22c23.html'
    ),
    (
     Name: 'OutputOffsetRunState';
     Value: 'group___output_i_o_m_a_p_ga8d01c70dd13d6d5b5ac771a419c39251.html'
    ),
    (
     Name: 'OutputOffsetRegMode';
     Value: 'group___output_i_o_m_a_p_gaf4c5fe0e9ac7a38a8ad4eb66ac0a90c5.html'
    ),
    (
     Name: 'OutputOffsetOverloaded';
     Value: 'group___output_i_o_m_a_p_ga6545f47099184e506287db725bba1662.html'
    ),
    (
     Name: 'OutputOffsetSyncTurnParameter';
     Value: 'group___output_i_o_m_a_p_gaaee1ca895f96cffeb4bbff6309354c0a.html'
    ),
    (
     Name: 'OutputOffsetOptions';
     Value: 'group___output_i_o_m_a_p_ga14982701795bb219dce207423ba4f70b.html'
    ),
    (
     Name: 'OutputOffsetMaxSpeed';
     Value: 'group___output_i_o_m_a_p_ga8c40122b453a1347919871d5b7d5f023.html'
    ),
    (
     Name: 'OutputOffsetMaxAccel';
     Value: 'group___output_i_o_m_a_p_gae2179ef2fb9a0b8e29fbfde10e540e9f.html'
    ),
    (
     Name: 'OutputOffsetRegulationTime';
     Value: 'group___output_i_o_m_a_p_ga0c6dbfb0a59a93142f5f81f31ace2a1b.html'
    ),
    (
     Name: 'OutputOffsetRegulationOptions';
     Value: 'group___output_i_o_m_a_p_gad9ac1384f0cf49a9807698cb77e75f79.html'
    ),
    (
     Name: 'COM_CHANNEL_NONE_ACTIVE';
     Value: 'group___low_speed_state_constants_ga0f6a0133d078f3b42d48d4c81830cc6d.html'
    ),
    (
     Name: 'COM_CHANNEL_ONE_ACTIVE';
     Value: 'group___low_speed_state_constants_ga123fe313d504f4cef29a7847d052f2ce.html'
    ),
    (
     Name: 'COM_CHANNEL_TWO_ACTIVE';
     Value: 'group___low_speed_state_constants_gaaec1192d21fab413a34f0bc1c80a72f1.html'
    ),
    (
     Name: 'COM_CHANNEL_THREE_ACTIVE';
     Value: 'group___low_speed_state_constants_ga1f7b00fa151f241c583e39223bb768ba.html'
    ),
    (
     Name: 'COM_CHANNEL_FOUR_ACTIVE';
     Value: 'group___low_speed_state_constants_ga36545379595a2af9323db28ef06c2313.html'
    ),
    (
     Name: 'LOWSPEED_IDLE';
     Value: 'group___low_speed_channel_state_constants_gac1f5cf02e2c4d30a201c41cc7c20d3b3.html'
    ),
    (
     Name: 'LOWSPEED_INIT';
     Value: 'group___low_speed_channel_state_constants_ga635b5f9de376c7448379867362ed60b9.html'
    ),
    (
     Name: 'LOWSPEED_LOAD_BUFFER';
     Value: 'group___low_speed_channel_state_constants_gaac98a22bb318246d72c65baaaac8a58a.html'
    ),
    (
     Name: 'LOWSPEED_COMMUNICATING';
     Value: 'group___low_speed_channel_state_constants_ga1ce06eae7e302ce036c3597e562f8288.html'
    ),
    (
     Name: 'LOWSPEED_ERROR';
     Value: 'group___low_speed_channel_state_constants_ga1712bfda921cf85dde0beddf1cf613f4.html'
    ),
    (
     Name: 'LOWSPEED_DONE';
     Value: 'group___low_speed_channel_state_constants_ga845181f633d6f0f98525f0acc3048ba9.html'
    ),
    (
     Name: 'LOWSPEED_TRANSMITTING';
     Value: 'group___low_speed_mode_constants_ga52494a969eb64f739d25c1339652cf16.html'
    ),
    (
     Name: 'LOWSPEED_RECEIVING';
     Value: 'group___low_speed_mode_constants_ga5d310b8c19a6b55a2938a2c998b9d45b.html'
    ),
    (
     Name: 'LOWSPEED_DATA_RECEIVED';
     Value: 'group___low_speed_mode_constants_ga4d57aa4890f309c53298f536a492fa2a.html'
    ),
    (
     Name: 'LOWSPEED_NO_ERROR';
     Value: 'group___low_speed_error_type_constants_gaf9a464cebf23c0897a45b02e4fa8c8cd.html'
    ),
    (
     Name: 'LOWSPEED_CH_NOT_READY';
     Value: 'group___low_speed_error_type_constants_ga81196975a8225981c0c5130fd1e56dcd.html'
    ),
    (
     Name: 'LOWSPEED_TX_ERROR';
     Value: 'group___low_speed_error_type_constants_gae42ebdde6dbdfd7a20d1034a2b9d1b10.html'
    ),
    (
     Name: 'LOWSPEED_RX_ERROR';
     Value: 'group___low_speed_error_type_constants_gab21accca567c925ff6473d4f412c62b6.html'
    ),
    (
     Name: 'LowSpeedOffsetInBufBuf';
     Value: 'group___low_speed_i_o_m_a_p_ga006ad92b0f4eb856579e85a048d16447.html'
    ),
    (
     Name: 'LowSpeedOffsetInBufInPtr';
     Value: 'group___low_speed_i_o_m_a_p_gafc577a935effeba9ac1900444028baac.html'
    ),
    (
     Name: 'LowSpeedOffsetInBufOutPtr';
     Value: 'group___low_speed_i_o_m_a_p_gae0e8f6dd41f3e41f21e593edcb8231cc.html'
    ),
    (
     Name: 'LowSpeedOffsetInBufBytesToRx';
     Value: 'group___low_speed_i_o_m_a_p_ga34b1b550c048b7c9a12f7342f73e062b.html'
    ),
    (
     Name: 'LowSpeedOffsetOutBufBuf';
     Value: 'group___low_speed_i_o_m_a_p_ga3b0e8b793a80024c6f22080cea6064b6.html'
    ),
    (
     Name: 'LowSpeedOffsetOutBufInPtr';
     Value: 'group___low_speed_i_o_m_a_p_ga576b80c4d9f1f3b4cb7663ee2302e503.html'
    ),
    (
     Name: 'LowSpeedOffsetOutBufOutPtr';
     Value: 'group___low_speed_i_o_m_a_p_ga5613d19352b7b2bb55c25ae89269aa14.html'
    ),
    (
     Name: 'LowSpeedOffsetOutBufBytesToRx';
     Value: 'group___low_speed_i_o_m_a_p_gabda4b0ab210fa3cbe13ee63a9561a635.html'
    ),
    (
     Name: 'LowSpeedOffsetMode';
     Value: 'group___low_speed_i_o_m_a_p_gae9299339f9d04d87a9c24d41a7cc75b6.html'
    ),
    (
     Name: 'LowSpeedOffsetChannelState';
     Value: 'group___low_speed_i_o_m_a_p_gad405023f19811e03fa868b83ce030dec.html'
    ),
    (
     Name: 'LowSpeedOffsetErrorType';
     Value: 'group___low_speed_i_o_m_a_p_ga0abb0bd07f3036a5b1f784ebefd4456a.html'
    ),
    (
     Name: 'LowSpeedOffsetState';
     Value: 'group___low_speed_i_o_m_a_p_ga7c004abe5cc230a2d04a0d6e0df648a3.html'
    ),
    (
     Name: 'LowSpeedOffsetSpeed';
     Value: 'group___low_speed_i_o_m_a_p_ga210161e7435db389ef96a75f7479abf8.html'
    ),
    (
     Name: 'LowSpeedOffsetNoRestartOnRead';
     Value: 'group___low_speed_i_o_m_a_p_ga67deb0a438fe522d3679d1e5d76e09be.html'
    ),
    (
     Name: 'LSREAD_RESTART_ALL';
     Value: 'group___low_speed_no_restart_constants_ga2e79937be48a9a9e7eea20410a3f16ad.html'
    ),
    (
     Name: 'LSREAD_NO_RESTART_1';
     Value: 'group___low_speed_no_restart_constants_ga361fee051464c392eeb3bb1270305771.html'
    ),
    (
     Name: 'LSREAD_NO_RESTART_2';
     Value: 'group___low_speed_no_restart_constants_ga827f704c948ef18b0cab074840c6d659.html'
    ),
    (
     Name: 'LSREAD_NO_RESTART_3';
     Value: 'group___low_speed_no_restart_constants_ga1928d8fe6a956b80f6d4f8ab78c761a4.html'
    ),
    (
     Name: 'LSREAD_NO_RESTART_4';
     Value: 'group___low_speed_no_restart_constants_ga3e0deb4a7a03b2b1c4ec8e7996fa2f06.html'
    ),
    (
     Name: 'LSREAD_RESTART_NONE';
     Value: 'group___low_speed_no_restart_constants_gaf6a6761928cff6b12d23d6443048f800.html'
    ),
    (
     Name: 'LSREAD_NO_RESTART_MASK';
     Value: 'group___low_speed_no_restart_constants_ga2be9b6adec09a367c9dcd0b52f86b474.html'
    ),
    (
     Name: 'I2C_ADDR_DEFAULT';
     Value: 'group___generic_i2_c_constants_gaee2d9de639e34f5e042a88b9ed4cfe4d.html'
    ),
    (
     Name: 'I2C_REG_VERSION';
     Value: 'group___generic_i2_c_constants_gac6e70764e55d76e80fc93d09e76362c3.html'
    ),
    (
     Name: 'I2C_REG_VENDOR_ID';
     Value: 'group___generic_i2_c_constants_gaca5d67c585a976d5e5e2fa2e5a7a98b8.html'
    ),
    (
     Name: 'I2C_REG_DEVICE_ID';
     Value: 'group___generic_i2_c_constants_ga99efee5a0e6cec95136b956e1dd82e1d.html'
    ),
    (
     Name: 'I2C_REG_CMD';
     Value: 'group___generic_i2_c_constants_ga54163be3ae882039a68a5983fc944dd5.html'
    ),
    (
     Name: 'LEGO_ADDR_US';
     Value: 'group___l_e_g_o_i2_c_address_constants_ga95b38b6a27727e3398f49047ed7c12f7.html'
    ),
    (
     Name: 'LEGO_ADDR_TEMP';
     Value: 'group___l_e_g_o_i2_c_address_constants_gaa004417307d1ce3c2823b5c033b55743.html'
    ),
    (
     Name: 'LEGO_ADDR_EMETER';
     Value: 'group___l_e_g_o_i2_c_address_constants_ga4f3c45258315d731f1025557633bc1c1.html'
    ),
    (
     Name: 'US_CMD_OFF';
     Value: 'group___u_s_i2_c_constants_gac386215d85dd0e47d28289eb5fe1f27e.html'
    ),
    (
     Name: 'US_CMD_SINGLESHOT';
     Value: 'group___u_s_i2_c_constants_ga301ee34f71acf202eb8fb961626e7218.html'
    ),
    (
     Name: 'US_CMD_CONTINUOUS';
     Value: 'group___u_s_i2_c_constants_ga61a172e43853ba07292b3a033bb2a61a.html'
    ),
    (
     Name: 'US_CMD_EVENTCAPTURE';
     Value: 'group___u_s_i2_c_constants_ga32369f13464ebfaadc6760098988fda4.html'
    ),
    (
     Name: 'US_CMD_WARMRESET';
     Value: 'group___u_s_i2_c_constants_ga16efbbce83609082329f425c4f3d5089.html'
    ),
    (
     Name: 'US_REG_CM_INTERVAL';
     Value: 'group___u_s_i2_c_constants_gafdd7d632d21d3f415a3ddc9b5616c1d4.html'
    ),
    (
     Name: 'US_REG_ACTUAL_ZERO';
     Value: 'group___u_s_i2_c_constants_gad6a1ee55d3edd75302ed071ac585b726.html'
    ),
    (
     Name: 'US_REG_SCALE_FACTOR';
     Value: 'group___u_s_i2_c_constants_ga4136ea4a795e7c34c0cb2ee869a8a7eb.html'
    ),
    (
     Name: 'US_REG_SCALE_DIVISOR';
     Value: 'group___u_s_i2_c_constants_ga4160fa927d0a72096aa6721f44e923ca.html'
    ),
    (
     Name: 'US_REG_FACTORY_ACTUAL_ZERO';
     Value: 'group___u_s_i2_c_constants_gac3ad8828f1f926d43456c309062f56d0.html'
    ),
    (
     Name: 'US_REG_FACTORY_SCALE_FACTOR';
     Value: 'group___u_s_i2_c_constants_ga87d37d0f2e194b1e21ac22dadd5f0700.html'
    ),
    (
     Name: 'US_REG_FACTORY_SCALE_DIVISOR';
     Value: 'group___u_s_i2_c_constants_gad2909df2ca0c1996a547fb5e96c7267d.html'
    ),
    (
     Name: 'US_REG_MEASUREMENT_UNITS';
     Value: 'group___u_s_i2_c_constants_gaf1d2e605ad48ba2cb357c386b53ffd81.html'
    ),
    (
     Name: 'TEMP_RES_9BIT';
     Value: 'group___temp_i2_c_constants_ga5f44cc4fc21a140905ac16b2a9416557.html'
    ),
    (
     Name: 'TEMP_RES_10BIT';
     Value: 'group___temp_i2_c_constants_gaa12067aa4df773c457133cb4627a2088.html'
    ),
    (
     Name: 'TEMP_RES_11BIT';
     Value: 'group___temp_i2_c_constants_ga52f0d6cb434712c9f4ca231398475e60.html'
    ),
    (
     Name: 'TEMP_RES_12BIT';
     Value: 'group___temp_i2_c_constants_gaf8320c5eda0d3f2055666fd84444941b.html'
    ),
    (
     Name: 'TEMP_SD_CONTINUOUS';
     Value: 'group___temp_i2_c_constants_ga6f79c1ac6dde64767b1c9b059dd730b4.html'
    ),
    (
     Name: 'TEMP_SD_SHUTDOWN';
     Value: 'group___temp_i2_c_constants_ga3333c299e60354a4cc667604c2b11f5a.html'
    ),
    (
     Name: 'TEMP_TM_COMPARATOR';
     Value: 'group___temp_i2_c_constants_ga3bc49f6b1591ff983f66deaa5a3ee2da.html'
    ),
    (
     Name: 'TEMP_TM_INTERRUPT';
     Value: 'group___temp_i2_c_constants_ga78115380fa8a3d502a969a7782d928aa.html'
    ),
    (
     Name: 'TEMP_OS_ONESHOT';
     Value: 'group___temp_i2_c_constants_ga909b1d55eb9658730195836de8f28ef4.html'
    ),
    (
     Name: 'TEMP_FQ_1';
     Value: 'group___temp_i2_c_constants_ga18e4f2c5c76fa85e35513c5a86a0787f.html'
    ),
    (
     Name: 'TEMP_FQ_2';
     Value: 'group___temp_i2_c_constants_gaa735231f74ee73d8b6b3295ef8d94df3.html'
    ),
    (
     Name: 'TEMP_FQ_4';
     Value: 'group___temp_i2_c_constants_ga92c5061fa23aa53248c2dd4b4c40c139.html'
    ),
    (
     Name: 'TEMP_FQ_6';
     Value: 'group___temp_i2_c_constants_gad0554a9be1f080e863098a67a2de3336.html'
    ),
    (
     Name: 'TEMP_POL_LOW';
     Value: 'group___temp_i2_c_constants_gac9f51614755f8824b2c2026ca9cabbf7.html'
    ),
    (
     Name: 'TEMP_POL_HIGH';
     Value: 'group___temp_i2_c_constants_gab40a7daed813b085ca417f3a76f00ab1.html'
    ),
    (
     Name: 'TEMP_REG_TEMP';
     Value: 'group___temp_i2_c_constants_ga2c07c09ba69212b83cbd0133daa4ce0c.html'
    ),
    (
     Name: 'TEMP_REG_CONFIG';
     Value: 'group___temp_i2_c_constants_ga73ecc1fe7dbbcf26cf894b2adf3b8817.html'
    ),
    (
     Name: 'TEMP_REG_TLOW';
     Value: 'group___temp_i2_c_constants_ga18a27506057837eacdfb9010654080ff.html'
    ),
    (
     Name: 'TEMP_REG_THIGH';
     Value: 'group___temp_i2_c_constants_ga0c081dbef3e1890f1b4abf65dd4a170c.html'
    ),
    (
     Name: 'EMETER_REG_VIN';
     Value: 'group___e_meter_i2_c_constants_ga2be9047872b33b8fe4ee94436b1f9e8b.html'
    ),
    (
     Name: 'EMETER_REG_AIN';
     Value: 'group___e_meter_i2_c_constants_ga6da2cb8af8125429f0f7eab105b14e4e.html'
    ),
    (
     Name: 'EMETER_REG_VOUT';
     Value: 'group___e_meter_i2_c_constants_gacd2d5a3137fd74e2b3e26119f8dc69e9.html'
    ),
    (
     Name: 'EMETER_REG_AOUT';
     Value: 'group___e_meter_i2_c_constants_gaafa2cec7fc5c628f9ff39384f0665c24.html'
    ),
    (
     Name: 'EMETER_REG_JOULES';
     Value: 'group___e_meter_i2_c_constants_gac2f6d150556cc6b1240ba867e923d2dd.html'
    ),
    (
     Name: 'EMETER_REG_WIN';
     Value: 'group___e_meter_i2_c_constants_ga2e94d0a3722221c982ce92be30e4a0ee.html'
    ),
    (
     Name: 'EMETER_REG_WOUT';
     Value: 'group___e_meter_i2_c_constants_ga352fa58ce7f96b4fec6db8b86ee09562.html'
    ),
    (
     Name: 'DISPLAY_ERASE_ALL';
     Value: 'group___display_execute_function_constants_ga170fa293581d57a4c1f75d30957975b5.html'
    ),
    (
     Name: 'DISPLAY_PIXEL';
     Value: 'group___display_execute_function_constants_ga496742fb640e40a1e3e12e53ce12017a.html'
    ),
    (
     Name: 'DISPLAY_HORIZONTAL_LINE';
     Value: 'group___display_execute_function_constants_gaed208dcd63f2ec63e309cd7dcfa203c2.html'
    ),
    (
     Name: 'DISPLAY_VERTICAL_LINE';
     Value: 'group___display_execute_function_constants_ga61b7a22e6e79da00faebb73cbd407aa9.html'
    ),
    (
     Name: 'DISPLAY_CHAR';
     Value: 'group___display_execute_function_constants_gab95e5bb3b5f6fb109a052e2cc5d9f5e0.html'
    ),
    (
     Name: 'DISPLAY_ERASE_LINE';
     Value: 'group___display_execute_function_constants_gada10001acf21958bb6828169b5ae1856.html'
    ),
    (
     Name: 'DISPLAY_FILL_REGION';
     Value: 'group___display_execute_function_constants_ga317a1fcc650167fd462c1fa67529c5fa.html'
    ),
    (
     Name: 'DISPLAY_FRAME';
     Value: 'group___display_execute_function_constants_gae8618f10b91911b88b9e3eec9d39e476.html'
    ),
    (
     Name: 'DRAW_OPT_NORMAL';
     Value: 'group___display_draw_option_constants_gae625e13db0a2e0b651acd75a4445e80f.html'
    ),
    (
     Name: 'DRAW_OPT_CLEAR_WHOLE_SCREEN';
     Value: 'group___display_draw_option_constants_ga0b0170fdd1a6b13482dd167b50e47f37.html'
    ),
    (
     Name: 'DRAW_OPT_CLEAR_EXCEPT_STATUS_SCREEN';
     Value: 'group___display_draw_option_constants_ga4dcd1b5054b45e29c914b9d2ca7f8ed8.html'
    ),
    (
     Name: 'DRAW_OPT_CLEAR_PIXELS';
     Value: 'group___display_draw_option_constants_gade4fafbe52a0b34deedfb69fae1165f0.html'
    ),
    (
     Name: 'DRAW_OPT_CLEAR';
     Value: 'group___display_draw_option_constants_gac40f2a3d36980926775cee774f6a4a1f.html'
    ),
    (
     Name: 'DRAW_OPT_INVERT';
     Value: 'group___display_draw_option_constants_ga9c40872cc18573e8d62d75c17a9167b2.html'
    ),
    (
     Name: 'DRAW_OPT_LOGICAL_COPY';
     Value: 'group___display_draw_option_constants_ga95f22d17db6596fab0fa6bc4ea235ee0.html'
    ),
    (
     Name: 'DRAW_OPT_LOGICAL_AND';
     Value: 'group___display_draw_option_constants_ga94b7ef97cfc955a981ba3904d3e2e1a6.html'
    ),
    (
     Name: 'DRAW_OPT_LOGICAL_OR';
     Value: 'group___display_draw_option_constants_gab08f9323ef0b8616ddce804ffc2feea4.html'
    ),
    (
     Name: 'DRAW_OPT_LOGICAL_XOR';
     Value: 'group___display_draw_option_constants_gab534fda324836bc868ba0eed0da6e0ce.html'
    ),
    (
     Name: 'DRAW_OPT_FILL_SHAPE';
     Value: 'group___display_draw_option_constants_gaacec823ca229fcac40c7bbf4b98aa937.html'
    ),
    (
     Name: 'DRAW_OPT_CLEAR_SCREEN_MODES';
     Value: 'group___display_draw_option_constants_ga98a4cf40b04737e66111c712f4bbfeeb.html'
    ),
    (
     Name: 'DRAW_OPT_LOGICAL_OPERATIONS';
     Value: 'group___display_draw_option_constants_ga3f24240fd7905bac0e28c70c29bf12ad.html'
    ),
    (
     Name: 'DRAW_OPT_POLYGON_POLYLINE';
     Value: 'group___display_draw_option_constants_ga83c7d7e89e00d814ef7ad101d63ee1a7.html'
    ),
    (
     Name: 'DRAW_OPT_FONT_DIRECTIONS';
     Value: 'group___display_font_draw_option_constants_gac50e4fb8be486c5ac2caa2523f2faa2f.html'
    ),
    (
     Name: 'DRAW_OPT_FONT_WRAP';
     Value: 'group___display_font_draw_option_constants_ga44ef2382d49d2ee3806d1044fa2d524f.html'
    ),
    (
     Name: 'DRAW_OPT_FONT_DIR_L2RB';
     Value: 'group___display_font_draw_option_constants_ga05802e14d5f170501f40d876915ac316.html'
    ),
    (
     Name: 'DRAW_OPT_FONT_DIR_L2RT';
     Value: 'group___display_font_draw_option_constants_ga7bc586d1137a304d871276497d1d123d.html'
    ),
    (
     Name: 'DRAW_OPT_FONT_DIR_R2LB';
     Value: 'group___display_font_draw_option_constants_gaa4028365a5b9f94db7be21199bae3373.html'
    ),
    (
     Name: 'DRAW_OPT_FONT_DIR_R2LT';
     Value: 'group___display_font_draw_option_constants_gaefc5fe8fa6218a8536829d4013e55521.html'
    ),
    (
     Name: 'DRAW_OPT_FONT_DIR_B2TL';
     Value: 'group___display_font_draw_option_constants_ga9f972ce39d32783e9c6d162d4ecf2ae9.html'
    ),
    (
     Name: 'DRAW_OPT_FONT_DIR_B2TR';
     Value: 'group___display_font_draw_option_constants_ga1052b115dcb4f65e97f437d824afbade.html'
    ),
    (
     Name: 'DRAW_OPT_FONT_DIR_T2BL';
     Value: 'group___display_font_draw_option_constants_ga9e1ef994697e73355c898256fb09ebcc.html'
    ),
    (
     Name: 'DRAW_OPT_FONT_DIR_T2BR';
     Value: 'group___display_font_draw_option_constants_ga2b24738d192da82b7aafd9bbb4fbc9ce.html'
    ),
    (
     Name: 'DISPLAY_ON';
     Value: 'group___display_flags_group_ga5ae6b05b3e1559c97f0d1b2daaaa0ee4.html'
    ),
    (
     Name: 'DISPLAY_REFRESH';
     Value: 'group___display_flags_group_gad57d5f1983d83611877c68c3ce5c78a9.html'
    ),
    (
     Name: 'DISPLAY_POPUP';
     Value: 'group___display_flags_group_gaafdc214b587b3ccd024894b82ca0c539.html'
    ),
    (
     Name: 'DISPLAY_REFRESH_DISABLED';
     Value: 'group___display_flags_group_ga5877ca47ae8be3f892ada749c2401b18.html'
    ),
    (
     Name: 'DISPLAY_BUSY';
     Value: 'group___display_flags_group_gaa23683c82dbc5b48e8645f092ec6da2c.html'
    ),
    (
     Name: 'DISPLAY_CONTRAST_DEFAULT';
     Value: 'group___display_contrast_constants_ga9139d7966c82e2d15a88286b3d522748.html'
    ),
    (
     Name: 'DISPLAY_CONTRAST_MAX';
     Value: 'group___display_contrast_constants_gaabb589c114b50a446ec826c3490b870b.html'
    ),
    (
     Name: 'SCREEN_MODE_RESTORE';
     Value: 'group___display_module_constants_ga2939b1d3b5efe9ed433c5dc7b41920fa.html'
    ),
    (
     Name: 'SCREEN_MODE_CLEAR';
     Value: 'group___display_module_constants_ga84e03fab51408ccfea60b4f3b7754d22.html'
    ),
    (
     Name: 'DISPLAY_HEIGHT';
     Value: 'group___display_module_constants_ga43b7b2061f733ea1dc0a5a6028e131ff.html'
    ),
    (
     Name: 'DISPLAY_WIDTH';
     Value: 'group___display_module_constants_ga46d67d48a7faab308f2e058dc35da83a.html'
    ),
    (
     Name: 'DISPLAY_MENUICONS_Y';
     Value: 'group___display_module_constants_ga4fbcf364c4db64ddbec5128844920a56.html'
    ),
    (
     Name: 'DISPLAY_MENUICONS_X_OFFS';
     Value: 'group___display_module_constants_ga3323ec4802aaf217b7fdef851ae630cd.html'
    ),
    (
     Name: 'DISPLAY_MENUICONS_X_DIFF';
     Value: 'group___display_module_constants_ga27ef4e470df15e0d61916109123ddbe9.html'
    ),
    (
     Name: 'TEXTLINE_1';
     Value: 'group___display_text_line_constants_ga3c0af75689c8a4ad9bf68ac9750e120b.html'
    ),
    (
     Name: 'TEXTLINE_2';
     Value: 'group___display_text_line_constants_gad73dfe2b667e1cf57839ed9f5c43fc32.html'
    ),
    (
     Name: 'TEXTLINE_3';
     Value: 'group___display_text_line_constants_ga1e07b3bffc0c4e729dfaff72c11f3977.html'
    ),
    (
     Name: 'TEXTLINE_4';
     Value: 'group___display_text_line_constants_ga8dddbb97da1db1b068428b5a4ff9f1c3.html'
    ),
    (
     Name: 'TEXTLINE_5';
     Value: 'group___display_text_line_constants_gaa037065e0a959ef0a5d6a1be809e1be7.html'
    ),
    (
     Name: 'TEXTLINE_6';
     Value: 'group___display_text_line_constants_gaeb5669ec52455d168f299c1bc1ca6555.html'
    ),
    (
     Name: 'TEXTLINE_7';
     Value: 'group___display_text_line_constants_ga43784acfc0746e862e294ab4b0bb265a.html'
    ),
    (
     Name: 'TEXTLINE_8';
     Value: 'group___display_text_line_constants_gae5757a9b6a72b758690d0cc331989299.html'
    ),
    (
     Name: 'TEXTLINES';
     Value: 'group___display_text_line_constants_gacca4caf393d9a1a0dcd95b64fc8c617e.html'
    ),
    (
     Name: 'MENUICON_LEFT';
     Value: 'group___display_module_constants_ga7f1ebd3cc39b9a9db3d2baa5bae7cf2d.html'
    ),
    (
     Name: 'MENUICON_CENTER';
     Value: 'group___display_module_constants_ga7a635a01d92dc9666a0d594ca6d61b52.html'
    ),
    (
     Name: 'MENUICON_RIGHT';
     Value: 'group___display_module_constants_ga3a7de108ce36e3ba90b8983511cda125.html'
    ),
    (
     Name: 'MENUICONS';
     Value: 'group___display_module_constants_ga63886e15e2ccfd7a7a410dba94fa6c4d.html'
    ),
    (
     Name: 'FRAME_SELECT';
     Value: 'group___display_module_constants_gad4d3f4d16664295b0ca7f5c312b7ec14.html'
    ),
    (
     Name: 'STATUSTEXT';
     Value: 'group___display_module_constants_ga729f5d797b1ccfa6cbba4b8f2fd28df2.html'
    ),
    (
     Name: 'MENUTEXT';
     Value: 'group___display_module_constants_ga0f9cbc406a9eebd74507002f93ee0107.html'
    ),
    (
     Name: 'STEPLINE';
     Value: 'group___display_module_constants_ga80375d65e28609a857999aaab7a74b9e.html'
    ),
    (
     Name: 'TOPLINE';
     Value: 'group___display_module_constants_ga2f230edf8a9d5997f4fc9f45bc6048e6.html'
    ),
    (
     Name: 'SPECIALS';
     Value: 'group___display_module_constants_ga2e1ba74d2e5a4b6bdb7e2b1d00f4f4c0.html'
    ),
    (
     Name: 'STATUSICON_BLUETOOTH';
     Value: 'group___display_module_constants_ga8edb860e76f993869d274751265c1a78.html'
    ),
    (
     Name: 'STATUSICON_USB';
     Value: 'group___display_module_constants_ga5a7d1ce727ac3cd0c44862ba2a541910.html'
    ),
    (
     Name: 'STATUSICON_VM';
     Value: 'group___display_module_constants_ga4431ece05c083c9398adcb4c6c979c9a.html'
    ),
    (
     Name: 'STATUSICON_BATTERY';
     Value: 'group___display_module_constants_ga7865d9ca04a4b2e55f7950a88d0e796a.html'
    ),
    (
     Name: 'STATUSICONS';
     Value: 'group___display_module_constants_ga870b844a40b086f37cffa6982a997763.html'
    ),
    (
     Name: 'SCREEN_BACKGROUND';
     Value: 'group___display_module_constants_gacbc339d9e43cfc080fa39f36cba78226.html'
    ),
    (
     Name: 'SCREEN_LARGE';
     Value: 'group___display_module_constants_gaae662770db6be2e416b5e27ec70fbcbf.html'
    ),
    (
     Name: 'SCREEN_SMALL';
     Value: 'group___display_module_constants_ga1eadd6b363999ba9ed5f3391550316e6.html'
    ),
    (
     Name: 'SCREENS';
     Value: 'group___display_module_constants_ga6e2cfb4c90846697793db75311e865f1.html'
    ),
    (
     Name: 'BITMAP_1';
     Value: 'group___display_module_constants_gac7f4f524621db3fc4cb32214a176604e.html'
    ),
    (
     Name: 'BITMAP_2';
     Value: 'group___display_module_constants_ga4d1f76fc4494d91042b88f7c9cd32c30.html'
    ),
    (
     Name: 'BITMAP_3';
     Value: 'group___display_module_constants_gae116df1ea13452537b1005e2ad3b0907.html'
    ),
    (
     Name: 'BITMAP_4';
     Value: 'group___display_module_constants_ga21ef592738662aea5664534bb36a531e.html'
    ),
    (
     Name: 'BITMAPS';
     Value: 'group___display_module_constants_ga3746a5c44f711b633ca618b6ebb8e75f.html'
    ),
    (
     Name: 'STEPICON_1';
     Value: 'group___display_module_constants_ga140431912c60ebccef7cfd904a648c8a.html'
    ),
    (
     Name: 'STEPICON_2';
     Value: 'group___display_module_constants_ga6e774a519cadd0588a2775ba338b5f62.html'
    ),
    (
     Name: 'STEPICON_3';
     Value: 'group___display_module_constants_ga19272e349f748ac4645c2848fb65b73e.html'
    ),
    (
     Name: 'STEPICON_4';
     Value: 'group___display_module_constants_gac91ef0a03a85f2108df4daeee16da720.html'
    ),
    (
     Name: 'STEPICON_5';
     Value: 'group___display_module_constants_gaab6d259ca1d9bdfd05210496d5c6baf1.html'
    ),
    (
     Name: 'STEPICONS';
     Value: 'group___display_module_constants_ga1accd4ccd4ddd817c49d3be851952f6e.html'
    ),
    (
     Name: 'DisplayOffsetPFunc';
     Value: 'group___display_i_o_m_a_p_gaecec26cbee95be825104257302fed9b3.html'
    ),
    (
     Name: 'DisplayOffsetEraseMask';
     Value: 'group___display_i_o_m_a_p_ga49e17b97faed7919c2592c758c29a727.html'
    ),
    (
     Name: 'DisplayOffsetUpdateMask';
     Value: 'group___display_i_o_m_a_p_ga2112af0a92ff61329a5ae784b54716ac.html'
    ),
    (
     Name: 'DisplayOffsetPFont';
     Value: 'group___display_i_o_m_a_p_ga07715fb2681d2446c295df7c5da879a7.html'
    ),
    (
     Name: 'DisplayOffsetPTextLines';
     Value: 'group___display_i_o_m_a_p_ga96eaee1619cc15571746821829c46e09.html'
    ),
    (
     Name: 'DisplayOffsetPStatusText';
     Value: 'group___display_i_o_m_a_p_ga8fbac896c1b96fa8ae2aab772066e43c.html'
    ),
    (
     Name: 'DisplayOffsetPStatusIcons';
     Value: 'group___display_i_o_m_a_p_ga42b921bcd0d84e070bb0083ee5165124.html'
    ),
    (
     Name: 'DisplayOffsetPScreens';
     Value: 'group___display_i_o_m_a_p_ga5f1e97d77a80197d735a82b6e1abe103.html'
    ),
    (
     Name: 'DisplayOffsetPBitmaps';
     Value: 'group___display_i_o_m_a_p_gaa352865d9ae5dfc6f1b20725ab44b8a8.html'
    ),
    (
     Name: 'DisplayOffsetPMenuText';
     Value: 'group___display_i_o_m_a_p_gaad218da14bdd1c4b977e258bf6d87ec6.html'
    ),
    (
     Name: 'DisplayOffsetPMenuIcons';
     Value: 'group___display_i_o_m_a_p_ga029e895b26c5e7978e080a138ba1c356.html'
    ),
    (
     Name: 'DisplayOffsetPStepIcons';
     Value: 'group___display_i_o_m_a_p_gac5002589180fd51df8417c2f65304994.html'
    ),
    (
     Name: 'DisplayOffsetDisplay';
     Value: 'group___display_i_o_m_a_p_gac17cfed355f3d7b2eccfd4adf8b267bd.html'
    ),
    (
     Name: 'DisplayOffsetStatusIcons';
     Value: 'group___display_i_o_m_a_p_ga4a6bf3ff7a9e8e7d3e8226fde107b188.html'
    ),
    (
     Name: 'DisplayOffsetStepIcons';
     Value: 'group___display_i_o_m_a_p_ga2e447b9d9256089a5145a30d76f6b1d0.html'
    ),
    (
     Name: 'DisplayOffsetFlags';
     Value: 'group___display_i_o_m_a_p_ga696d28978521651604f281d07fd0091f.html'
    ),
    (
     Name: 'DisplayOffsetTextLinesCenterFlags';
     Value: 'group___display_i_o_m_a_p_ga03774e6aaa52f210dbde1cf734f3c2ba.html'
    ),
    (
     Name: 'DisplayOffsetNormal';
     Value: 'group___display_i_o_m_a_p_ga2c6735db2244cccb54e176f8df773f4c.html'
    ),
    (
     Name: 'DisplayOffsetPopup';
     Value: 'group___display_i_o_m_a_p_gaf91db264d84670c5d3fa568a9929dd2f.html'
    ),
    (
     Name: 'DisplayOffsetContrast';
     Value: 'group___display_i_o_m_a_p_ga2f894f68547865129f9ad096477510b8.html'
    ),
    (
     Name: 'SIZE_OF_USBBUF';
     Value: 'group___comm_misc_constants_gafd1e14b5f87c6de92ff258e7ac99524e.html'
    ),
    (
     Name: 'USB_PROTOCOL_OVERHEAD';
     Value: 'group___comm_misc_constants_gaad5df52cb22c6647efedc539e154c08a.html'
    ),
    (
     Name: 'SIZE_OF_USBDATA';
     Value: 'group___comm_misc_constants_gae4d37f28d17ff5905deca7eafa9d4262.html'
    ),
    (
     Name: 'SIZE_OF_HSBUF';
     Value: 'group___comm_misc_constants_ga3e4a4b5626951d6ba869d049ed69dfad.html'
    ),
    (
     Name: 'SIZE_OF_BTBUF';
     Value: 'group___comm_misc_constants_gac603047014504c8a86a8dbc7d7557990.html'
    ),
    (
     Name: 'BT_CMD_BYTE';
     Value: 'group___comm_misc_constants_ga40e6f0225abcdf69bdb6e54b1c471099.html'
    ),
    (
     Name: 'SIZE_OF_BT_DEVICE_TABLE';
     Value: 'group___comm_misc_constants_ga2d95590d9775f0ede9b1a29be7214583.html'
    ),
    (
     Name: 'SIZE_OF_BT_CONNECT_TABLE';
     Value: 'group___comm_misc_constants_gaf9579821731d907dc627b339e11dc688.html'
    ),
    (
     Name: 'SIZE_OF_BT_NAME';
     Value: 'group___comm_misc_constants_ga9d82c0c6f1aeb39d848ee3fe4a877a42.html'
    ),
    (
     Name: 'SIZE_OF_BRICK_NAME';
     Value: 'group___comm_misc_constants_ga9ee299f2059c1de2165bfd8bde39d03b.html'
    ),
    (
     Name: 'SIZE_OF_CLASS_OF_DEVICE';
     Value: 'group___comm_misc_constants_ga4623de1e5b40a3e37abb8a720122cf15.html'
    ),
    (
     Name: 'SIZE_OF_BT_PINCODE';
     Value: 'group___comm_misc_constants_ga68d1d7f614dfb9c5c8196665e3db0456.html'
    ),
    (
     Name: 'SIZE_OF_BDADDR';
     Value: 'group___comm_misc_constants_gaab53c790258a31c73853b2429ec808bd.html'
    ),
    (
     Name: 'MAX_BT_MSG_SIZE';
     Value: 'group___comm_misc_constants_ga1f2043289af5dcaa8e435676848db142.html'
    ),
    (
     Name: 'BT_DEFAULT_INQUIRY_MAX';
     Value: 'group___comm_misc_constants_ga93d32b3dd459b0223a09841e5ccfdd00.html'
    ),
    (
     Name: 'BT_DEFAULT_INQUIRY_TIMEOUT_LO';
     Value: 'group___comm_misc_constants_ga90ab712c66ab0903f5f66f7b867ab92d.html'
    ),
    (
     Name: 'BT_ARM_OFF';
     Value: 'group___comm_bt_state_constants_gac742054d235b6290878034c5626925ae.html'
    ),
    (
     Name: 'BT_ARM_CMD_MODE';
     Value: 'group___comm_bt_state_constants_ga39e01b8daba1a09f009bb7f31422bcc4.html'
    ),
    (
     Name: 'BT_ARM_DATA_MODE';
     Value: 'group___comm_bt_state_constants_ga8e9cf140e52658b4ce9e3cc5199191b5.html'
    ),
    (
     Name: 'DATA_MODE_NXT';
     Value: 'group___comm_data_mode_constants_gab6e0de6c5aa64bb363c9c69b73917958.html'
    ),
    (
     Name: 'DATA_MODE_GPS';
     Value: 'group___comm_data_mode_constants_gaf72ae86adb80283f92650cb634ec74d2.html'
    ),
    (
     Name: 'DATA_MODE_RAW';
     Value: 'group___comm_data_mode_constants_gaeeec1dd3127ec56730eb7f1d2a9dbcdc.html'
    ),
    (
     Name: 'DATA_MODE_MASK';
     Value: 'group___comm_data_mode_constants_ga395fe7349791be7cf743a2c63221fdea.html'
    ),
    (
     Name: 'DATA_MODE_UPDATE';
     Value: 'group___comm_data_mode_constants_gaa2c36f88935ef6bec1e1b1456ee9aa8b.html'
    ),
    (
     Name: 'BT_BRICK_VISIBILITY';
     Value: 'group___comm_bt_state_status_constants_ga1bdea7ce03cdd2c2dcbeed9925c178bb.html'
    ),
    (
     Name: 'BT_BRICK_PORT_OPEN';
     Value: 'group___comm_bt_state_status_constants_ga25381775adfd5181ae8763761d3d8aec.html'
    ),
    (
     Name: 'BT_CONNECTION_0_ENABLE';
     Value: 'group___comm_bt_state_status_constants_ga81be7b800f3c6db4bd4d7b3a7dfc0638.html'
    ),
    (
     Name: 'BT_CONNECTION_1_ENABLE';
     Value: 'group___comm_bt_state_status_constants_ga378552ab3cc0e1260dfa82490fb4ed76.html'
    ),
    (
     Name: 'BT_CONNECTION_2_ENABLE';
     Value: 'group___comm_bt_state_status_constants_ga50928ac5d9366e9eaff5f91f37d0e968.html'
    ),
    (
     Name: 'BT_CONNECTION_3_ENABLE';
     Value: 'group___comm_bt_state_status_constants_gad4524437ec66c863b85eb9a86ffc42ed.html'
    ),
    (
     Name: 'CONN_BT0';
     Value: 'group___comm_connection_constants_gae8192686cbb9cb01165a7714b22dc170.html'
    ),
    (
     Name: 'CONN_BT1';
     Value: 'group___comm_connection_constants_ga869148ae3f5fb3ae68cd66c75cc8846e.html'
    ),
    (
     Name: 'CONN_BT2';
     Value: 'group___comm_connection_constants_gaecbae96ba68f09b11b5e6775562576dd.html'
    ),
    (
     Name: 'CONN_BT3';
     Value: 'group___comm_connection_constants_gafd7f9e58eb759a2782531bc31611ca6a.html'
    ),
    (
     Name: 'CONN_HS4';
     Value: 'group___comm_connection_constants_ga1102704ef285a2ee6b0f320683f9cc65.html'
    ),
    (
     Name: 'CONN_HS_ALL';
     Value: 'group___comm_connection_constants_gad7f2a6e07195c8f346170f2d5d6b7a33.html'
    ),
    (
     Name: 'CONN_HS_1';
     Value: 'group___comm_connection_constants_ga95315370d9f52ddf90be976cacf7b4b5.html'
    ),
    (
     Name: 'CONN_HS_2';
     Value: 'group___comm_connection_constants_ga0b37b2ca4b6acb921a10877c1f26c49f.html'
    ),
    (
     Name: 'CONN_HS_3';
     Value: 'group___comm_connection_constants_ga6602e61a746c180bcf19b762e1e0380b.html'
    ),
    (
     Name: 'CONN_HS_4';
     Value: 'group___comm_connection_constants_gad2203cfb23165d371b6fb15fc4161311.html'
    ),
    (
     Name: 'CONN_HS_5';
     Value: 'group___comm_connection_constants_ga744f40c4d7ac453eab7d47175c142f4a.html'
    ),
    (
     Name: 'CONN_HS_6';
     Value: 'group___comm_connection_constants_ga4ac9e84172d8cde269cdb2827e005a43.html'
    ),
    (
     Name: 'CONN_HS_7';
     Value: 'group___comm_connection_constants_ga34b61b5be3197259727de158c4bce432.html'
    ),
    (
     Name: 'CONN_HS_8';
     Value: 'group___comm_connection_constants_ga0247707c38e40d0fb544712f2b155b04.html'
    ),
    (
     Name: 'BT_ENABLE';
     Value: 'group___comm_bt_hw_status_constants_gaf6adcd80b73b825e326cd30b688ddf41.html'
    ),
    (
     Name: 'BT_DISABLE';
     Value: 'group___comm_bt_hw_status_constants_gac9e6e3cec266960e16c9b91fb643bfd4.html'
    ),
    (
     Name: 'HS_UPDATE';
     Value: 'group___comm_hi_speed_flags_constants_ga1f8c23b692c64ce3c25889b2cc311501.html'
    ),
    (
     Name: 'HS_INITIALISE';
     Value: 'group___comm_hi_speed_state_constants_ga621a2fcaebd168ccdf17f53e703b8e21.html'
    ),
    (
     Name: 'HS_INIT_RECEIVER';
     Value: 'group___comm_hi_speed_state_constants_gabbd08451022bc3ef5e0a91eef7525475.html'
    ),
    (
     Name: 'HS_SEND_DATA';
     Value: 'group___comm_hi_speed_state_constants_ga3ec3601abfd2791a79a6bd93687be1ed.html'
    ),
    (
     Name: 'HS_DISABLE';
     Value: 'group___comm_hi_speed_state_constants_gaaf7430a4d4eaa168bb0e6b688b771067.html'
    ),
    (
     Name: 'HS_ENABLE';
     Value: 'group___comm_hi_speed_state_constants_ga6465eef4ccfead34c0786ca277b6344b.html'
    ),
    (
     Name: 'HS_CTRL_INIT';
     Value: 'group___comm_hi_speed_ctrl_constants_ga4c53c48a2553754f5f8de77979565a09.html'
    ),
    (
     Name: 'HS_CTRL_UART';
     Value: 'group___comm_hi_speed_ctrl_constants_ga2ba8ba0fe4f896d71186676ef2e92d1f.html'
    ),
    (
     Name: 'HS_CTRL_EXIT';
     Value: 'group___comm_hi_speed_ctrl_constants_ga57d880bb2e986f2363a4549d48101ebc.html'
    ),
    (
     Name: 'HS_BAUD_1200';
     Value: 'group___comm_hi_speed_baud_constants_gabb950699a829c0d33f26568a2ec6909f.html'
    ),
    (
     Name: 'HS_BAUD_2400';
     Value: 'group___comm_hi_speed_baud_constants_ga5c1074ed624fe4a708e444165e3c2d63.html'
    ),
    (
     Name: 'HS_BAUD_3600';
     Value: 'group___comm_hi_speed_baud_constants_ga89e3204809c63649ea59e0b3f84e24a7.html'
    ),
    (
     Name: 'HS_BAUD_4800';
     Value: 'group___comm_hi_speed_baud_constants_ga32eb0e759eb0e8b20169a81564452932.html'
    ),
    (
     Name: 'HS_BAUD_7200';
     Value: 'group___comm_hi_speed_baud_constants_ga2f7c5e176bfce84d858812b9a640f8cc.html'
    ),
    (
     Name: 'HS_BAUD_9600';
     Value: 'group___comm_hi_speed_baud_constants_ga73f8c1131b29c3dcd668f5d0ff2e67c4.html'
    ),
    (
     Name: 'HS_BAUD_14400';
     Value: 'group___comm_hi_speed_baud_constants_ga063705ec3a1afbc037227ecd89dde596.html'
    ),
    (
     Name: 'HS_BAUD_19200';
     Value: 'group___comm_hi_speed_baud_constants_ga27f7deaa91b6a4ffe88795edd425312f.html'
    ),
    (
     Name: 'HS_BAUD_28800';
     Value: 'group___comm_hi_speed_baud_constants_ga4d742deba2f52b26a1850603301d4f14.html'
    ),
    (
     Name: 'HS_BAUD_38400';
     Value: 'group___comm_hi_speed_baud_constants_gac5e888f5281e3c4663d309a6ee03f4f5.html'
    ),
    (
     Name: 'HS_BAUD_57600';
     Value: 'group___comm_hi_speed_baud_constants_gaa3ed50b6bbe3a3e34ee36c17be56c005.html'
    ),
    (
     Name: 'HS_BAUD_76800';
     Value: 'group___comm_hi_speed_baud_constants_ga81af2ae7c195322eace5f20333aa4301.html'
    ),
    (
     Name: 'HS_BAUD_115200';
     Value: 'group___comm_hi_speed_baud_constants_ga3486d8f3bae226d8ad5c2f8bb7505a21.html'
    ),
    (
     Name: 'HS_BAUD_230400';
     Value: 'group___comm_hi_speed_baud_constants_gaa8465c9a0030bf88e1618d30008675c3.html'
    ),
    (
     Name: 'HS_BAUD_460800';
     Value: 'group___comm_hi_speed_baud_constants_ga9a70fa5be00499488c74a54a0ed50322.html'
    ),
    (
     Name: 'HS_BAUD_921600';
     Value: 'group___comm_hi_speed_baud_constants_gacccb5bdf2856e741a351af7c81a0f568.html'
    ),
    (
     Name: 'HS_BAUD_DEFAULT';
     Value: 'group___comm_hi_speed_baud_constants_gaa633e006ef5a2c6f8592bc91ba5dda14.html'
    ),
    (
     Name: 'HS_MODE_DEFAULT';
     Value: 'group___comm_hi_speed_mode_constants_gabf088f7bca4a51c61f3c309dfd9fdaee.html'
    ),
    (
     Name: 'HS_MODE_5_DATA';
     Value: 'group___comm_hi_speed_data_bits_constants_ga6f856b239b0128f0645bb31704c7d146.html'
    ),
    (
     Name: 'HS_MODE_6_DATA';
     Value: 'group___comm_hi_speed_data_bits_constants_gabfda8849943542db70afe244b3868077.html'
    ),
    (
     Name: 'HS_MODE_7_DATA';
     Value: 'group___comm_hi_speed_data_bits_constants_ga21a1f9c88a65b07dc57117b51b8318d8.html'
    ),
    (
     Name: 'HS_MODE_8_DATA';
     Value: 'group___comm_hi_speed_data_bits_constants_ga406678309526bb3c33b2419fa6a9a2ad.html'
    ),
    (
     Name: 'HS_MODE_10_STOP';
     Value: 'group___comm_hi_speed_stop_bits_constants_ga15e9711900a9497bbd14f4be0c9a0ed8.html'
    ),
    (
     Name: 'HS_MODE_15_STOP';
     Value: 'group___comm_hi_speed_stop_bits_constants_ga178d9f8fb6e87c6c58acd5c3d21a45b1.html'
    ),
    (
     Name: 'HS_MODE_20_STOP';
     Value: 'group___comm_hi_speed_stop_bits_constants_ga4e7c3071b0235a533271cbdc0fb4cbf7.html'
    ),
    (
     Name: 'HS_MODE_E_PARITY';
     Value: 'group___comm_hi_speed_parity_constants_gae316bb3b33715f2ff7a4ebe63779dd7f.html'
    ),
    (
     Name: 'HS_MODE_O_PARITY';
     Value: 'group___comm_hi_speed_parity_constants_ga34b9a323d80a108ca939a5632fbcfffa.html'
    ),
    (
     Name: 'HS_MODE_S_PARITY';
     Value: 'group___comm_hi_speed_parity_constants_ga4221f1fbb1e64ecd328997c6b4bf3338.html'
    ),
    (
     Name: 'HS_MODE_M_PARITY';
     Value: 'group___comm_hi_speed_parity_constants_gafffa49d9df26e8cbf8f1aa0c5ec332bc.html'
    ),
    (
     Name: 'HS_MODE_N_PARITY';
     Value: 'group___comm_hi_speed_parity_constants_ga95fb88a670b720476fb8864d46083ca8.html'
    ),
    (
     Name: 'HS_MODE_8N1';
     Value: 'group___comm_hi_speed_combined_constants_gaa2950dec470fcedeb656ad5b0f59a322.html'
    ),
    (
     Name: 'HS_MODE_7E1';
     Value: 'group___comm_hi_speed_combined_constants_ga7bb23f5c6f3e527be4a21b5cd46a9b29.html'
    ),
    (
     Name: 'HS_ADDRESS_ALL';
     Value: 'group___comm_hi_speed_address_constants_ga1b65637a8b7decbc4cf10066ee606205.html'
    ),
    (
     Name: 'HS_ADDRESS_1';
     Value: 'group___comm_hi_speed_address_constants_ga25abfab9246e25d850555f64544e4f37.html'
    ),
    (
     Name: 'HS_ADDRESS_2';
     Value: 'group___comm_hi_speed_address_constants_gac71fc16741b95b79bceaf91b357c8275.html'
    ),
    (
     Name: 'HS_ADDRESS_3';
     Value: 'group___comm_hi_speed_address_constants_ga46514c3410446effe049911f68de0867.html'
    ),
    (
     Name: 'HS_ADDRESS_4';
     Value: 'group___comm_hi_speed_address_constants_gac82c67011be549c2d86643633105f985.html'
    ),
    (
     Name: 'HS_ADDRESS_5';
     Value: 'group___comm_hi_speed_address_constants_gac675bc2db04e2174bea4cc247479ca4b.html'
    ),
    (
     Name: 'HS_ADDRESS_6';
     Value: 'group___comm_hi_speed_address_constants_gaa71760000ae0a339435f6355c61c0d2a.html'
    ),
    (
     Name: 'HS_ADDRESS_7';
     Value: 'group___comm_hi_speed_address_constants_ga6bdfb55279cabd7a2ec58b60fbc48441.html'
    ),
    (
     Name: 'HS_ADDRESS_8';
     Value: 'group___comm_hi_speed_address_constants_ga9481691fb839b72ff9e2e43af19113c6.html'
    ),
    (
     Name: 'BT_DEVICE_EMPTY';
     Value: 'group___comm_device_status_constants_gadc88225cd12480d76123d220afeab696.html'
    ),
    (
     Name: 'BT_DEVICE_UNKNOWN';
     Value: 'group___comm_device_status_constants_gaa9811c266d8369645f57c17850b3fd5f.html'
    ),
    (
     Name: 'BT_DEVICE_KNOWN';
     Value: 'group___comm_device_status_constants_ga930c949ffdf4efecbdfa16288e597318.html'
    ),
    (
     Name: 'BT_DEVICE_NAME';
     Value: 'group___comm_device_status_constants_ga4bd1916653b0c48e44f6541fe94ab711.html'
    ),
    (
     Name: 'BT_DEVICE_AWAY';
     Value: 'group___comm_device_status_constants_ga12fd770453b5fc5154e4788866ce0d65.html'
    ),
    (
     Name: 'INTF_SENDFILE';
     Value: 'group___comm_interface_constants_gaee722635fa5643410c369b30eadfb1c6.html'
    ),
    (
     Name: 'INTF_SEARCH';
     Value: 'group___comm_interface_constants_ga94d14e2b8a9d4e3ba411e20cd718dc44.html'
    ),
    (
     Name: 'INTF_STOPSEARCH';
     Value: 'group___comm_interface_constants_ga508be7db3be6e1097b73c1c079ed26c0.html'
    ),
    (
     Name: 'INTF_CONNECT';
     Value: 'group___comm_interface_constants_ga3d89e55ad7a2b98f297ac8385e67d448.html'
    ),
    (
     Name: 'INTF_DISCONNECT';
     Value: 'group___comm_interface_constants_gad0a4962e29053bf25d3287ca6975d4b9.html'
    ),
    (
     Name: 'INTF_DISCONNECTALL';
     Value: 'group___comm_interface_constants_ga27890e1e9ccf0fa294162ca42a0c8377.html'
    ),
    (
     Name: 'INTF_REMOVEDEVICE';
     Value: 'group___comm_interface_constants_gae7ef575deba8d3351331ec3778756941.html'
    ),
    (
     Name: 'INTF_VISIBILITY';
     Value: 'group___comm_interface_constants_gaff82009a4a5244a06ff27b460cf65222.html'
    ),
    (
     Name: 'INTF_SETCMDMODE';
     Value: 'group___comm_interface_constants_ga0dda8ef624aacb1961b493754ea15b3c.html'
    ),
    (
     Name: 'INTF_OPENSTREAM';
     Value: 'group___comm_interface_constants_ga3d9829550768eb8f0629dd8e11fc8ac3.html'
    ),
    (
     Name: 'INTF_SENDDATA';
     Value: 'group___comm_interface_constants_ga071f64fb98bdcd14539895e4d9d0d044.html'
    ),
    (
     Name: 'INTF_FACTORYRESET';
     Value: 'group___comm_interface_constants_gae64e9c10b2317765d45f6008ad995d51.html'
    ),
    (
     Name: 'INTF_BTON';
     Value: 'group___comm_interface_constants_ga99aa6fed10e381b824704e36ff12b065.html'
    ),
    (
     Name: 'INTF_BTOFF';
     Value: 'group___comm_interface_constants_ga65aea3b4a5e0cd6cd136cdc8a1f9bbe1.html'
    ),
    (
     Name: 'INTF_SETBTNAME';
     Value: 'group___comm_interface_constants_ga8f3f356f763227490c3412d2440613ee.html'
    ),
    (
     Name: 'INTF_EXTREAD';
     Value: 'group___comm_interface_constants_ga7a945cc63c49f33de526080be592e90e.html'
    ),
    (
     Name: 'INTF_PINREQ';
     Value: 'group___comm_interface_constants_gaf390bea18dae14e874033888afc35b36.html'
    ),
    (
     Name: 'INTF_CONNECTREQ';
     Value: 'group___comm_interface_constants_gab063cfe9170dd294d932a081e3da73a8.html'
    ),
    (
     Name: 'INTF_CONNECTBYNAME';
     Value: 'group___comm_interface_constants_ga6ffb8684a71aceaf38896cc6936a25e8.html'
    ),
    (
     Name: 'LR_SUCCESS';
     Value: 'group___comm_status_codes_constants_ga07b9b2b1fec215676b359abf8fa88887.html'
    ),
    (
     Name: 'LR_COULD_NOT_SAVE';
     Value: 'group___comm_status_codes_constants_gaf7a992fbae245474b837d1e1e64580b3.html'
    ),
    (
     Name: 'LR_STORE_IS_FULL';
     Value: 'group___comm_status_codes_constants_ga0c0cf548a1f375de3e3df0f41f866ecb.html'
    ),
    (
     Name: 'LR_ENTRY_REMOVED';
     Value: 'group___comm_status_codes_constants_ga856201d7594cc63fb4c0fe25c5e5c5db.html'
    ),
    (
     Name: 'LR_UNKNOWN_ADDR';
     Value: 'group___comm_status_codes_constants_gafdf8420c2392e026c8722fdcff2e5f1e.html'
    ),
    (
     Name: 'USB_CMD_READY';
     Value: 'group___comm_status_codes_constants_gad5004b5ee603da5d0ccfa1bfb2a675a2.html'
    ),
    (
     Name: 'BT_CMD_READY';
     Value: 'group___comm_status_codes_constants_ga7ea470257df13edc9b960c6091698bbb.html'
    ),
    (
     Name: 'HS_CMD_READY';
     Value: 'group___comm_status_codes_constants_ga541453b1efbcae02bede39911e85d73f.html'
    ),
    (
     Name: 'CommOffsetPFunc';
     Value: 'group___comm_i_o_m_a_p_gad06547eb525466a11c6e70aa3815ba82.html'
    ),
    (
     Name: 'CommOffsetPFuncTwo';
     Value: 'group___comm_i_o_m_a_p_gad2cdf9705bc119e0d58a2238b9577386.html'
    ),
    (
     Name: 'CommOffsetBtDeviceTableName';
     Value: 'group___comm_i_o_m_a_p_ga465ca6a55d192639076656ac6200693e.html'
    ),
    (
     Name: 'CommOffsetBtDeviceTableClassOfDevice';
     Value: 'group___comm_i_o_m_a_p_gae4ec1e0b9e1242328ffc5dd090e583cb.html'
    ),
    (
     Name: 'CommOffsetBtDeviceTableBdAddr';
     Value: 'group___comm_i_o_m_a_p_ga071b0b61e389ee32dddd5159b7f408f8.html'
    ),
    (
     Name: 'CommOffsetBtDeviceTableDeviceStatus';
     Value: 'group___comm_i_o_m_a_p_gaa50b0453e3b30dd6290f020ced8faf07.html'
    ),
    (
     Name: 'CommOffsetBtConnectTableName';
     Value: 'group___comm_i_o_m_a_p_ga4c626d687b51f1660be0042580b562e8.html'
    ),
    (
     Name: 'CommOffsetBtConnectTableClassOfDevice';
     Value: 'group___comm_i_o_m_a_p_gab15f99c4be848e57325059c71ba3efcb.html'
    ),
    (
     Name: 'CommOffsetBtConnectTablePinCode';
     Value: 'group___comm_i_o_m_a_p_gaece4e69b39a850f8fe718ed844bfad2a.html'
    ),
    (
     Name: 'CommOffsetBtConnectTableBdAddr';
     Value: 'group___comm_i_o_m_a_p_gac87dc5b69db42753b3526afe533c696a.html'
    ),
    (
     Name: 'CommOffsetBtConnectTableHandleNr';
     Value: 'group___comm_i_o_m_a_p_ga25d19864bfbb61b695fefd3cd6bdf5de.html'
    ),
    (
     Name: 'CommOffsetBtConnectTableStreamStatus';
     Value: 'group___comm_i_o_m_a_p_ga8c95d02f904c774f2bee432e8c9337c7.html'
    ),
    (
     Name: 'CommOffsetBtConnectTableLinkQuality';
     Value: 'group___comm_i_o_m_a_p_gabe75739ad5936b53ceaa09229bcd05eb.html'
    ),
    (
     Name: 'CommOffsetBrickDataName';
     Value: 'group___comm_i_o_m_a_p_gab371f121aaaab53070c95007add82398.html'
    ),
    (
     Name: 'CommOffsetBrickDataBluecoreVersion';
     Value: 'group___comm_i_o_m_a_p_ga249454bdc834a52d09e586ba8c9f0510.html'
    ),
    (
     Name: 'CommOffsetBrickDataBdAddr';
     Value: 'group___comm_i_o_m_a_p_ga31b5112ad5250417ddd33602bf957271.html'
    ),
    (
     Name: 'CommOffsetBrickDataBtStateStatus';
     Value: 'group___comm_i_o_m_a_p_ga84df1dcc7e1bf11f780a6015be6ee060.html'
    ),
    (
     Name: 'CommOffsetBrickDataBtHwStatus';
     Value: 'group___comm_i_o_m_a_p_gaa65db037ea4816a5c9b8480e7a02e6f0.html'
    ),
    (
     Name: 'CommOffsetBrickDataTimeOutValue';
     Value: 'group___comm_i_o_m_a_p_gaf968f7076c4543b1c2eb841d547179d0.html'
    ),
    (
     Name: 'CommOffsetBtInBufBuf';
     Value: 'group___comm_i_o_m_a_p_ga91deedcdc4d11564c34f688c40edb160.html'
    ),
    (
     Name: 'CommOffsetBtInBufInPtr';
     Value: 'group___comm_i_o_m_a_p_ga2e147b5a9c58df4c12bc317cb02bfde4.html'
    ),
    (
     Name: 'CommOffsetBtInBufOutPtr';
     Value: 'group___comm_i_o_m_a_p_ga3a29de217399a599b2233f6389a5453f.html'
    ),
    (
     Name: 'CommOffsetBtOutBufBuf';
     Value: 'group___comm_i_o_m_a_p_gacbe728e085e45774f2c67f0ea19c6301.html'
    ),
    (
     Name: 'CommOffsetBtOutBufInPtr';
     Value: 'group___comm_i_o_m_a_p_ga31190a1dbc1a5c72fed6473613cef39f.html'
    ),
    (
     Name: 'CommOffsetBtOutBufOutPtr';
     Value: 'group___comm_i_o_m_a_p_gae5a767dd366d9527955d4c857a9c9ac5.html'
    ),
    (
     Name: 'CommOffsetHsInBufBuf';
     Value: 'group___comm_i_o_m_a_p_ga65359d54edc80b300a092f08f26123bf.html'
    ),
    (
     Name: 'CommOffsetHsInBufInPtr';
     Value: 'group___comm_i_o_m_a_p_ga7f8c931a2663074f83d5d8da90752413.html'
    ),
    (
     Name: 'CommOffsetHsInBufOutPtr';
     Value: 'group___comm_i_o_m_a_p_ga947218670b43c826badc961dd6b75f5f.html'
    ),
    (
     Name: 'CommOffsetHsOutBufBuf';
     Value: 'group___comm_i_o_m_a_p_gac6ebe9cd54b0e82d2e80406d4090bf7e.html'
    ),
    (
     Name: 'CommOffsetHsOutBufInPtr';
     Value: 'group___comm_i_o_m_a_p_gadb381db5253e5df430bb0a01c7951157.html'
    ),
    (
     Name: 'CommOffsetHsOutBufOutPtr';
     Value: 'group___comm_i_o_m_a_p_ga41d0a7e750acaabe4753f7f387448b56.html'
    ),
    (
     Name: 'CommOffsetUsbInBufBuf';
     Value: 'group___comm_i_o_m_a_p_ga23a29d1e1f7e629a3831d74ad15a563e.html'
    ),
    (
     Name: 'CommOffsetUsbInBufInPtr';
     Value: 'group___comm_i_o_m_a_p_ga684b169fdee09bc2548446916ba01574.html'
    ),
    (
     Name: 'CommOffsetUsbInBufOutPtr';
     Value: 'group___comm_i_o_m_a_p_gad9f4a9ef5fac2b497535b89fb82dabe8.html'
    ),
    (
     Name: 'CommOffsetUsbOutBufBuf';
     Value: 'group___comm_i_o_m_a_p_ga1f923309290b3b296fe64ff820532007.html'
    ),
    (
     Name: 'CommOffsetUsbOutBufInPtr';
     Value: 'group___comm_i_o_m_a_p_ga4ec6fedbc373f7a18b6d788438813564.html'
    ),
    (
     Name: 'CommOffsetUsbOutBufOutPtr';
     Value: 'group___comm_i_o_m_a_p_ga2d9b15097cf0984710bcd7492cba4d1f.html'
    ),
    (
     Name: 'CommOffsetUsbPollBufBuf';
     Value: 'group___comm_i_o_m_a_p_ga8955fafdd40c8738887a286508a035ef.html'
    ),
    (
     Name: 'CommOffsetUsbPollBufInPtr';
     Value: 'group___comm_i_o_m_a_p_ga11778d91e354d5df1a7d2f6eeed60ef6.html'
    ),
    (
     Name: 'CommOffsetUsbPollBufOutPtr';
     Value: 'group___comm_i_o_m_a_p_ga4569f2dcd50900155580571b4967c289.html'
    ),
    (
     Name: 'CommOffsetBtDeviceCnt';
     Value: 'group___comm_i_o_m_a_p_ga9d52dd63b1942cc70c65cfea7c3bbc83.html'
    ),
    (
     Name: 'CommOffsetBtDeviceNameCnt';
     Value: 'group___comm_i_o_m_a_p_ga5e02977df5740b39d4b55f3e48ec3c2b.html'
    ),
    (
     Name: 'CommOffsetHsFlags';
     Value: 'group___comm_i_o_m_a_p_ga3991de75dcc5a4a71daa1fc815ebc25b.html'
    ),
    (
     Name: 'CommOffsetHsSpeed';
     Value: 'group___comm_i_o_m_a_p_ga66d12157a91960f14dec591a4fe37e7e.html'
    ),
    (
     Name: 'CommOffsetHsState';
     Value: 'group___comm_i_o_m_a_p_ga77e036942fa8188bd039511ce128272e.html'
    ),
    (
     Name: 'CommOffsetUsbState';
     Value: 'group___comm_i_o_m_a_p_ga1dfb5b73cc16ff9651b83badae02757e.html'
    ),
    (
     Name: 'CommOffsetHsMode';
     Value: 'group___comm_i_o_m_a_p_ga4b28fbc0d6b8de8fa092b05a3160ba4c.html'
    ),
    (
     Name: 'CommOffsetBtDataMode';
     Value: 'group___comm_i_o_m_a_p_ga59656e3cb25c2b0dcb92a0f967ec7c4e.html'
    ),
    (
     Name: 'CommOffsetHsDataMode';
     Value: 'group___comm_i_o_m_a_p_ga45843124709e2ee206503753c9966fa0.html'
    ),
    (
     Name: 'RCX_OUT_A';
     Value: 'group___r_c_x_output_constants_ga358bf219cba90b0673711caaf070c585.html'
    ),
    (
     Name: 'RCX_OUT_B';
     Value: 'group___r_c_x_output_constants_gad5f5af564e6c4af308619c0d56cb5d29.html'
    ),
    (
     Name: 'RCX_OUT_C';
     Value: 'group___r_c_x_output_constants_ga6ea0ac9625f714f5374731cb262cb0fc.html'
    ),
    (
     Name: 'RCX_OUT_AB';
     Value: 'group___r_c_x_output_constants_gad2257ca289bbc16bf9dd0e3b0bbb2f6a.html'
    ),
    (
     Name: 'RCX_OUT_AC';
     Value: 'group___r_c_x_output_constants_gaf3e80bcdabb7193a2e839e1b6951b2f3.html'
    ),
    (
     Name: 'RCX_OUT_BC';
     Value: 'group___r_c_x_output_constants_ga46987fa966901fca4acc328287b4954e.html'
    ),
    (
     Name: 'RCX_OUT_ABC';
     Value: 'group___r_c_x_output_constants_ga39c2a3995a1b48d9bcb4088a4ef9c0dc.html'
    ),
    (
     Name: 'RCX_OUT_FLOAT';
     Value: 'group___r_c_x_output_mode_gab0031d1a48ac5a1d451f051544d7da7a.html'
    ),
    (
     Name: 'RCX_OUT_OFF';
     Value: 'group___r_c_x_output_mode_ga369b3f17db587b7430b62a0a1ba79f05.html'
    ),
    (
     Name: 'RCX_OUT_ON';
     Value: 'group___r_c_x_output_mode_ga6e2d3d32120660175ccd9853d22f21c6.html'
    ),
    (
     Name: 'RCX_OUT_REV';
     Value: 'group___r_c_x_output_direction_ga0bcf420c12e342c395ac1717b71ee90d.html'
    ),
    (
     Name: 'RCX_OUT_TOGGLE';
     Value: 'group___r_c_x_output_direction_ga3bad56497da59af8d2975141af5a6f22.html'
    ),
    (
     Name: 'RCX_OUT_FWD';
     Value: 'group___r_c_x_output_direction_ga62de74ef86c1e3816f472c6501135a5a.html'
    ),
    (
     Name: 'RCX_OUT_LOW';
     Value: 'group___r_c_x_output_power_ga184fd7f91deeb4d2ed573520cd342e29.html'
    ),
    (
     Name: 'RCX_OUT_HALF';
     Value: 'group___r_c_x_output_power_ga0564dcc2e61a04d0da43497134b623ad.html'
    ),
    (
     Name: 'RCX_OUT_FULL';
     Value: 'group___r_c_x_output_power_gaa7e0c8d7d7dda5d94058dc9876d84a67.html'
    ),
    (
     Name: 'RCX_RemoteKeysReleased';
     Value: 'group___r_c_x_remote_constants_ga8598e5a3066eb3cfea14dbd23d935232.html'
    ),
    (
     Name: 'RCX_RemotePBMessage1';
     Value: 'group___r_c_x_remote_constants_ga9627d5b25ae15635bb7dee8f146f4876.html'
    ),
    (
     Name: 'RCX_RemotePBMessage2';
     Value: 'group___r_c_x_remote_constants_gadb3cba867a72e4f84f152e586d4c8859.html'
    ),
    (
     Name: 'RCX_RemotePBMessage3';
     Value: 'group___r_c_x_remote_constants_ga580490b735c28b0a439d698c16d472b8.html'
    ),
    (
     Name: 'RCX_RemoteOutAForward';
     Value: 'group___r_c_x_remote_constants_ga0d4019b25d79a5c7382f67db0334cd00.html'
    ),
    (
     Name: 'RCX_RemoteOutBForward';
     Value: 'group___r_c_x_remote_constants_ga63e01d11e75e0bfa31d45a8f32be6fd0.html'
    ),
    (
     Name: 'RCX_RemoteOutCForward';
     Value: 'group___r_c_x_remote_constants_ga3c8584f9aecd7fc4262dd41532d641fd.html'
    ),
    (
     Name: 'RCX_RemoteOutABackward';
     Value: 'group___r_c_x_remote_constants_ga81d1d4821ed8cb29c6e899cf6eea89ec.html'
    ),
    (
     Name: 'RCX_RemoteOutBBackward';
     Value: 'group___r_c_x_remote_constants_ga2c554b95a9730cbd69fa07610da842f2.html'
    ),
    (
     Name: 'RCX_RemoteOutCBackward';
     Value: 'group___r_c_x_remote_constants_ga3a6e554b42240e1d4b313996fe5a6b89.html'
    ),
    (
     Name: 'RCX_RemoteSelProgram1';
     Value: 'group___r_c_x_remote_constants_ga3119ad87fcfcf0395203caa9cc573ed5.html'
    ),
    (
     Name: 'RCX_RemoteSelProgram2';
     Value: 'group___r_c_x_remote_constants_ga60ab4ec01da0f9eb96cc952615a1791d.html'
    ),
    (
     Name: 'RCX_RemoteSelProgram3';
     Value: 'group___r_c_x_remote_constants_ga681534fe27e0f802f571f105e76f1d46.html'
    ),
    (
     Name: 'RCX_RemoteSelProgram4';
     Value: 'group___r_c_x_remote_constants_gafffcaa371eb8a2a22310e745ee463f52.html'
    ),
    (
     Name: 'RCX_RemoteSelProgram5';
     Value: 'group___r_c_x_remote_constants_ga3585e84454bc5a9078f25a071dd9bf66.html'
    ),
    (
     Name: 'RCX_RemoteStopOutOff';
     Value: 'group___r_c_x_remote_constants_ga08bf79a4d773a67a9ae0f59a94f1044d.html'
    ),
    (
     Name: 'RCX_RemotePlayASound';
     Value: 'group___r_c_x_remote_constants_gab1e407ef945eeb43e405a45086dd5b5c.html'
    ),
    (
     Name: 'SOUND_CLICK';
     Value: 'group___r_c_x_sound_constants_ga462ff98696f599c724ae019fdba77164.html'
    ),
    (
     Name: 'SOUND_DOUBLE_BEEP';
     Value: 'group___r_c_x_sound_constants_gafc552bfcd399998ee7aaeee58c3d94df.html'
    ),
    (
     Name: 'SOUND_DOWN';
     Value: 'group___r_c_x_sound_constants_gaaf6556da89bf342c63b510846ba8b7fe.html'
    ),
    (
     Name: 'SOUND_UP';
     Value: 'group___r_c_x_sound_constants_ga7177ff0898c62c6df3a0b0d519b6eb6a.html'
    ),
    (
     Name: 'SOUND_LOW_BEEP';
     Value: 'group___r_c_x_sound_constants_ga141f96108eb9899a1c1b2b681fc271e8.html'
    ),
    (
     Name: 'SOUND_FAST_UP';
     Value: 'group___r_c_x_sound_constants_gaf70fd08e5c244068d6df08e4421d6348.html'
    ),
    (
     Name: 'SCOUT_LIGHT_ON';
     Value: 'group___scout_light_constants_gad956cb2546e6e80518bec9075ce78ccb.html'
    ),
    (
     Name: 'SCOUT_LIGHT_OFF';
     Value: 'group___scout_light_constants_ga35dcba1a34e54e0738e6b14529120c42.html'
    ),
    (
     Name: 'SCOUT_SOUND_REMOTE';
     Value: 'group___scout_sound_constants_gadee611fc3b00b1f167f149ec3706741b.html'
    ),
    (
     Name: 'SCOUT_SOUND_ENTERSA';
     Value: 'group___scout_sound_constants_gac61dac3551f7831907058623dc14d96b.html'
    ),
    (
     Name: 'SCOUT_SOUND_KEYERROR';
     Value: 'group___scout_sound_constants_ga4a1f4f55b864d65423a1e2e0f40ba82e.html'
    ),
    (
     Name: 'SCOUT_SOUND_NONE';
     Value: 'group___scout_sound_constants_ga9ee04c42acc7b81318e61f241e352803.html'
    ),
    (
     Name: 'SCOUT_SOUND_TOUCH1_PRES';
     Value: 'group___scout_sound_constants_ga0c505a37c358b243d3738a723da3dc2a.html'
    ),
    (
     Name: 'SCOUT_SOUND_TOUCH1_REL';
     Value: 'group___scout_sound_constants_gaa63c5df63a8a47d3f0bfcd796edf77c8.html'
    ),
    (
     Name: 'SCOUT_SOUND_TOUCH2_PRES';
     Value: 'group___scout_sound_constants_gab616270f3a0ea83a547fd503755f6abf.html'
    ),
    (
     Name: 'SCOUT_SOUND_TOUCH2_REL';
     Value: 'group___scout_sound_constants_ga0be9dad190ee6801d8f4ac5a288594cc.html'
    ),
    (
     Name: 'SCOUT_SOUND_ENTER_BRIGHT';
     Value: 'group___scout_sound_constants_gae19b5a4d0dd6ef18f8df3a9de80891b1.html'
    ),
    (
     Name: 'SCOUT_SOUND_ENTER_NORMAL';
     Value: 'group___scout_sound_constants_gaa09f7db8d844cc3edecd41a2e8d45841.html'
    ),
    (
     Name: 'SCOUT_SOUND_ENTER_DARK';
     Value: 'group___scout_sound_constants_ga15cc51d0431fb48989fb80e1d6b9d763.html'
    ),
    (
     Name: 'SCOUT_SOUND_1_BLINK';
     Value: 'group___scout_sound_constants_ga1c1c760b2f18d1093a1827bcfe759029.html'
    ),
    (
     Name: 'SCOUT_SOUND_2_BLINK';
     Value: 'group___scout_sound_constants_gad28075b06eca19ddcb6c41aa644dc185.html'
    ),
    (
     Name: 'SCOUT_SOUND_COUNTER1';
     Value: 'group___scout_sound_constants_ga2e7a332e7557bcdf994f4a668de52df7.html'
    ),
    (
     Name: 'SCOUT_SOUND_COUNTER2';
     Value: 'group___scout_sound_constants_ga372fd0de61671bc497c6c414ad01ca19.html'
    ),
    (
     Name: 'SCOUT_SOUND_TIMER1';
     Value: 'group___scout_sound_constants_ga85d96b6d4e4bb3c36eaa80dc563b292b.html'
    ),
    (
     Name: 'SCOUT_SOUND_TIMER2';
     Value: 'group___scout_sound_constants_gaf55cc701b5bf66e622d332669c61c738.html'
    ),
    (
     Name: 'SCOUT_SOUND_TIMER3';
     Value: 'group___scout_sound_constants_gabe43df44962a570d588971874757b275.html'
    ),
    (
     Name: 'SCOUT_SOUND_MAIL_RECEIVED';
     Value: 'group___scout_sound_constants_ga73a1ae60ca188e3b7babd1a9c0244f4b.html'
    ),
    (
     Name: 'SCOUT_SOUND_SPECIAL1';
     Value: 'group___scout_sound_constants_ga7f97e460d5f6b491c3cfe197794f386a.html'
    ),
    (
     Name: 'SCOUT_SOUND_SPECIAL2';
     Value: 'group___scout_sound_constants_gafdc341f44a5a1a10e32cd8a094609e6b.html'
    ),
    (
     Name: 'SCOUT_SOUND_SPECIAL3';
     Value: 'group___scout_sound_constants_gacf94a715288c5270d3a812f5d6c742c2.html'
    ),
    (
     Name: 'SCOUT_SNDSET_NONE';
     Value: 'group___scout_snd_set_constants_gabece03633fe5e651f54155b7816b4155.html'
    ),
    (
     Name: 'SCOUT_SNDSET_BASIC';
     Value: 'group___scout_snd_set_constants_ga9732924b57760e9e0dc7f6e3948fa195.html'
    ),
    (
     Name: 'SCOUT_SNDSET_BUG';
     Value: 'group___scout_snd_set_constants_ga687c235f64f457e0a2619b2b85efc8e8.html'
    ),
    (
     Name: 'SCOUT_SNDSET_ALARM';
     Value: 'group___scout_snd_set_constants_gac9505c099968d03bde61cbf0bc08df40.html'
    ),
    (
     Name: 'SCOUT_SNDSET_RANDOM';
     Value: 'group___scout_snd_set_constants_gaf4806c101b8314958a0d28666c58ff75.html'
    ),
    (
     Name: 'SCOUT_SNDSET_SCIENCE';
     Value: 'group___scout_snd_set_constants_ga6361415d07edb93a9415f789abf2271d.html'
    ),
    (
     Name: 'SCOUT_MODE_STANDALONE';
     Value: 'group___scout_mode_constants_ga0c584697ff1926c02c8cf2a8d09e3a0a.html'
    ),
    (
     Name: 'SCOUT_MODE_POWER';
     Value: 'group___scout_mode_constants_gacb86f6f9ac06f60f45cd7d4143ca8b45.html'
    ),
    (
     Name: 'SCOUT_MR_NO_MOTION';
     Value: 'group___scout_motion_rule_constants_ga853e3cd4e957628df2433d82792d75ff.html'
    ),
    (
     Name: 'SCOUT_MR_FORWARD';
     Value: 'group___scout_motion_rule_constants_gaafb0f343c670e44f8476c7f7a5cc5518.html'
    ),
    (
     Name: 'SCOUT_MR_ZIGZAG';
     Value: 'group___scout_motion_rule_constants_ga0a051bda476f179f735174d1cfaf819a.html'
    ),
    (
     Name: 'SCOUT_MR_CIRCLE_RIGHT';
     Value: 'group___scout_motion_rule_constants_ga7b1fee9187fd1462d5649398ea79218d.html'
    ),
    (
     Name: 'SCOUT_MR_CIRCLE_LEFT';
     Value: 'group___scout_motion_rule_constants_ga1e55bc2ac9f049f3a3bb63683ff482e3.html'
    ),
    (
     Name: 'SCOUT_MR_LOOP_A';
     Value: 'group___scout_motion_rule_constants_ga2cad81b49c23917c1f4688f3d837d57b.html'
    ),
    (
     Name: 'SCOUT_MR_LOOP_B';
     Value: 'group___scout_motion_rule_constants_gaf9a20b1c33eb92df22732333b49d7c76.html'
    ),
    (
     Name: 'SCOUT_MR_LOOP_AB';
     Value: 'group___scout_motion_rule_constants_ga8debb38879fa4ae83bb75d7faf5c3149.html'
    ),
    (
     Name: 'SCOUT_TR_IGNORE';
     Value: 'group___scout_touch_rule_constants_ga26651bef277154cf8e1c56b5a507df56.html'
    ),
    (
     Name: 'SCOUT_TR_REVERSE';
     Value: 'group___scout_touch_rule_constants_ga0569cf1e485e7b63f35278336a14cb6f.html'
    ),
    (
     Name: 'SCOUT_TR_AVOID';
     Value: 'group___scout_touch_rule_constants_gafeb35d10bd9d8d49a71adc2fd9b35e4f.html'
    ),
    (
     Name: 'SCOUT_TR_WAIT_FOR';
     Value: 'group___scout_touch_rule_constants_ga94775cb0c9a8f8058382846d6de230bc.html'
    ),
    (
     Name: 'SCOUT_TR_OFF_WHEN';
     Value: 'group___scout_touch_rule_constants_ga1953c5bfce58bff5d419e02d1f51a002.html'
    ),
    (
     Name: 'SCOUT_LR_IGNORE';
     Value: 'group___scout_light_rule_constants_ga1e482558f7b719c95b8ee28215241818.html'
    ),
    (
     Name: 'SCOUT_LR_SEEK_LIGHT';
     Value: 'group___scout_light_rule_constants_ga8d6f8b3a95b639da8b72f0cf90fdae84.html'
    ),
    (
     Name: 'SCOUT_LR_SEEK_DARK';
     Value: 'group___scout_light_rule_constants_ga34c4d04d180d9e4cf6d7f8c66696ee26.html'
    ),
    (
     Name: 'SCOUT_LR_AVOID';
     Value: 'group___scout_light_rule_constants_gaa8894e2e6cbfb04567d7454a67a3d6aa.html'
    ),
    (
     Name: 'SCOUT_LR_WAIT_FOR';
     Value: 'group___scout_light_rule_constants_gaaec077d4a1e8622678fe23678d395080.html'
    ),
    (
     Name: 'SCOUT_LR_OFF_WHEN';
     Value: 'group___scout_light_rule_constants_ga743a50c6e7f5264083fe78e32fed468b.html'
    ),
    (
     Name: 'SCOUT_TGS_SHORT';
     Value: 'group___scout_transmit_rule_constants_gab5832e5bd291e2512bc4bc352ddb4f0d.html'
    ),
    (
     Name: 'SCOUT_TGS_MEDIUM';
     Value: 'group___scout_transmit_rule_constants_ga203e7a2ae9a81b4b4d648ea00b5f9b7c.html'
    ),
    (
     Name: 'SCOUT_TGS_LONG';
     Value: 'group___scout_transmit_rule_constants_gafa95b2b475e3afbc030cd7bb03392c2a.html'
    ),
    (
     Name: 'SCOUT_FXR_NONE';
     Value: 'group___scout_special_effect_constants_ga9f7e5afcab2402aee7d5bcb9e9fac909.html'
    ),
    (
     Name: 'SCOUT_FXR_BUG';
     Value: 'group___scout_special_effect_constants_ga76a6c56b2e22dbf9010f300a218857fa.html'
    ),
    (
     Name: 'SCOUT_FXR_ALARM';
     Value: 'group___scout_special_effect_constants_gaa1754c009078a930e24558e16ed009fa.html'
    ),
    (
     Name: 'SCOUT_FXR_RANDOM';
     Value: 'group___scout_special_effect_constants_gac5eb6213a972ebd20a3458ec2f287d88.html'
    ),
    (
     Name: 'SCOUT_FXR_SCIENCE';
     Value: 'group___scout_special_effect_constants_gacf03afddc57c0003cb466dd5cf4be683.html'
    ),
    (
     Name: 'RCX_VariableSrc';
     Value: 'group___r_c_x_source_constants_ga23f3f95bc02f776c24dfaebaba415bc4.html'
    ),
    (
     Name: 'RCX_TimerSrc';
     Value: 'group___r_c_x_source_constants_gabe36c4dc454ff320ca3e65887a98847c.html'
    ),
    (
     Name: 'RCX_ConstantSrc';
     Value: 'group___r_c_x_source_constants_ga96100a557cc782387164e20538d8ee6e.html'
    ),
    (
     Name: 'RCX_OutputStatusSrc';
     Value: 'group___r_c_x_source_constants_ga021cf028f211caf0631485ca227806ff.html'
    ),
    (
     Name: 'RCX_RandomSrc';
     Value: 'group___r_c_x_source_constants_gacb0ee1ecaadf1a3c7d8ed97802e24bb8.html'
    ),
    (
     Name: 'RCX_ProgramSlotSrc';
     Value: 'group___r_c_x_source_constants_ga20a99df2c1f7ec751b13d00a3ed1e1d7.html'
    ),
    (
     Name: 'RCX_InputValueSrc';
     Value: 'group___r_c_x_source_constants_ga2243b9e004761e752671fca2350fc4e7.html'
    ),
    (
     Name: 'RCX_InputTypeSrc';
     Value: 'group___r_c_x_source_constants_gada68c4ef3213b3385bf34a3128951af1.html'
    ),
    (
     Name: 'RCX_InputModeSrc';
     Value: 'group___r_c_x_source_constants_gaccf5b1694bc10ee49b952773150fe791.html'
    ),
    (
     Name: 'RCX_InputRawSrc';
     Value: 'group___r_c_x_source_constants_gac16c735f56370261d8799b9c86c21b8a.html'
    ),
    (
     Name: 'RCX_InputBooleanSrc';
     Value: 'group___r_c_x_source_constants_ga8d2f4b83bf86f6c27baf4cf4230352e9.html'
    ),
    (
     Name: 'RCX_WatchSrc';
     Value: 'group___r_c_x_source_constants_gaa3c28943c66f88d03ddbe800150a76a2.html'
    ),
    (
     Name: 'RCX_MessageSrc';
     Value: 'group___r_c_x_source_constants_ga7d3cd3c6c91572a9a5b5227a76693169.html'
    ),
    (
     Name: 'RCX_GlobalMotorStatusSrc';
     Value: 'group___r_c_x_source_constants_ga07100e72036a55c70a62e52f06d3c98b.html'
    ),
    (
     Name: 'RCX_ScoutRulesSrc';
     Value: 'group___r_c_x_source_constants_ga31909ff3ae13630e19f7479a0aca36cb.html'
    ),
    (
     Name: 'RCX_ScoutLightParamsSrc';
     Value: 'group___r_c_x_source_constants_gaad79bf60a91bf80875a16b3bb8e98c70.html'
    ),
    (
     Name: 'RCX_ScoutTimerLimitSrc';
     Value: 'group___r_c_x_source_constants_ga7b2768af6f208cf58839a2e92f68aeb1.html'
    ),
    (
     Name: 'RCX_CounterSrc';
     Value: 'group___r_c_x_source_constants_gac4136387a1c87cdfa97b082ac7da3d00.html'
    ),
    (
     Name: 'RCX_ScoutCounterLimitSrc';
     Value: 'group___r_c_x_source_constants_gaf8ec143786bc72b10ac3afc66811d062.html'
    ),
    (
     Name: 'RCX_TaskEventsSrc';
     Value: 'group___r_c_x_source_constants_gab4add7830a9c36a73736b4b50a0d3ebe.html'
    ),
    (
     Name: 'RCX_ScoutEventFBSrc';
     Value: 'group___r_c_x_source_constants_gacab94791a7314e835277fc3f4bb7ff9d.html'
    ),
    (
     Name: 'RCX_EventStateSrc';
     Value: 'group___r_c_x_source_constants_ga9f1d1da8bbd60bbfc045b5478a15cf15.html'
    ),
    (
     Name: 'RCX_TenMSTimerSrc';
     Value: 'group___r_c_x_source_constants_ga0fb145e7fa7f9aecb69bbb1b023fb12c.html'
    ),
    (
     Name: 'RCX_ClickCounterSrc';
     Value: 'group___r_c_x_source_constants_ga6426ab0fc2946c0544f256a3ca9998f4.html'
    ),
    (
     Name: 'RCX_UpperThresholdSrc';
     Value: 'group___r_c_x_source_constants_ga03172585f9783f689926dbf1b69f6359.html'
    ),
    (
     Name: 'RCX_LowerThresholdSrc';
     Value: 'group___r_c_x_source_constants_gaf442abc9d407eb0f41e0183d07f05886.html'
    ),
    (
     Name: 'RCX_HysteresisSrc';
     Value: 'group___r_c_x_source_constants_ga3766448daa9863cc6d83a8a295561303.html'
    ),
    (
     Name: 'RCX_DurationSrc';
     Value: 'group___r_c_x_source_constants_gabfeadb2cc98fc688a55e42619c84a71a.html'
    ),
    (
     Name: 'RCX_UARTSetupSrc';
     Value: 'group___r_c_x_source_constants_gac54edbb6e491349e782546cda3577144.html'
    ),
    (
     Name: 'RCX_BatteryLevelSrc';
     Value: 'group___r_c_x_source_constants_gaaeb9b23d1350798a450d99c1c5e8c78a.html'
    ),
    (
     Name: 'RCX_FirmwareVersionSrc';
     Value: 'group___r_c_x_source_constants_gafc4aa16023e09d09a66a43fdf2c9175f.html'
    ),
    (
     Name: 'RCX_IndirectVarSrc';
     Value: 'group___r_c_x_source_constants_ga13935ca85ad099c5fed01b73a177456e.html'
    ),
    (
     Name: 'RCX_DatalogSrcIndirectSrc';
     Value: 'group___r_c_x_source_constants_ga72d8ef70838eabb75f5ed0ff4b6ddb38.html'
    ),
    (
     Name: 'RCX_DatalogSrcDirectSrc';
     Value: 'group___r_c_x_source_constants_ga26eab7b593985a0eb0fd6dd5231ab38b.html'
    ),
    (
     Name: 'RCX_DatalogValueIndirectSrc';
     Value: 'group___r_c_x_source_constants_ga34c7453bdd4faf3be89fcd7790c6b376.html'
    ),
    (
     Name: 'RCX_DatalogValueDirectSrc';
     Value: 'group___r_c_x_source_constants_gaec4c5580c3581c8b2b151afba0404845.html'
    ),
    (
     Name: 'RCX_DatalogRawIndirectSrc';
     Value: 'group___r_c_x_source_constants_gae4f73a26ced3d3aa2101c2e547164ca3.html'
    ),
    (
     Name: 'RCX_DatalogRawDirectSrc';
     Value: 'group___r_c_x_source_constants_ga5252c356253ee9be8b65a000c7843f12.html'
    ),
    (
     Name: 'RCX_PingOp';
     Value: 'group___r_c_x_opcode_constants_gad098209d920715b70f7e72f0c0e259a4.html'
    ),
    (
     Name: 'RCX_BatteryLevelOp';
     Value: 'group___r_c_x_opcode_constants_ga297a0faff379d171d63d830fef47795a.html'
    ),
    (
     Name: 'RCX_DeleteTasksOp';
     Value: 'group___r_c_x_opcode_constants_ga0803a6b8171998b1efece0bfc111b024.html'
    ),
    (
     Name: 'RCX_StopAllTasksOp';
     Value: 'group___r_c_x_opcode_constants_ga6c6a300e6bcc52ed9f0d4d9957c8b1ed.html'
    ),
    (
     Name: 'RCX_PBTurnOffOp';
     Value: 'group___r_c_x_opcode_constants_ga9e07773365f3e9ac5e13e501b2d4a994.html'
    ),
    (
     Name: 'RCX_DeleteSubsOp';
     Value: 'group___r_c_x_opcode_constants_ga65ea27cc61be12a4a7689ac0317ff575.html'
    ),
    (
     Name: 'RCX_ClearSoundOp';
     Value: 'group___r_c_x_opcode_constants_ga823c0ee34c9b482391b52aa8e8d98d67.html'
    ),
    (
     Name: 'RCX_ClearMsgOp';
     Value: 'group___r_c_x_opcode_constants_gaf34b316c9871fb397d630c9cf7925f72.html'
    ),
    (
     Name: 'RCX_LSCalibrateOp';
     Value: 'group___r_c_x_opcode_constants_ga8f9f4d7d1c017f278c57a266eb8ffe1d.html'
    ),
    (
     Name: 'RCX_MuteSoundOp';
     Value: 'group___r_c_x_opcode_constants_ga16d3698341152bc2268c20b1f6fb4bba.html'
    ),
    (
     Name: 'RCX_UnmuteSoundOp';
     Value: 'group___r_c_x_opcode_constants_ga9fa7f408c0285b0af2a282779d135f6d.html'
    ),
    (
     Name: 'RCX_ClearAllEventsOp';
     Value: 'group___r_c_x_opcode_constants_ga9437adc49955002e2b79d2372fe3f39e.html'
    ),
    (
     Name: 'RCX_OnOffFloatOp';
     Value: 'group___r_c_x_opcode_constants_ga6baf5c864f85e7ed3d66ecece7340c56.html'
    ),
    (
     Name: 'RCX_IRModeOp';
     Value: 'group___r_c_x_opcode_constants_ga4607ba505adbaac4615ccc5f74b76c24.html'
    ),
    (
     Name: 'RCX_PlaySoundOp';
     Value: 'group___r_c_x_opcode_constants_ga9abf5913e1d3a095d34fc84ffd21ec33.html'
    ),
    (
     Name: 'RCX_DeleteTaskOp';
     Value: 'group___r_c_x_opcode_constants_ga20a8b482d7f62cc9512add1506a8cdd3.html'
    ),
    (
     Name: 'RCX_StartTaskOp';
     Value: 'group___r_c_x_opcode_constants_gae19d41544193b7c0516355ccb96f5429.html'
    ),
    (
     Name: 'RCX_StopTaskOp';
     Value: 'group___r_c_x_opcode_constants_gac1429260d7789a67f07d58f80203d424.html'
    ),
    (
     Name: 'RCX_SelectProgramOp';
     Value: 'group___r_c_x_opcode_constants_gaee9924ce02af721ec17bc380440dbdd9.html'
    ),
    (
     Name: 'RCX_ClearTimerOp';
     Value: 'group___r_c_x_opcode_constants_ga43edca3ae34762684e8a61638a752bfc.html'
    ),
    (
     Name: 'RCX_AutoOffOp';
     Value: 'group___r_c_x_opcode_constants_gaefa27ed9e989c96f277025da558ecee3.html'
    ),
    (
     Name: 'RCX_DeleteSubOp';
     Value: 'group___r_c_x_opcode_constants_gaa5de71a8c385d8ff964c73ec27114385.html'
    ),
    (
     Name: 'RCX_ClearSensorOp';
     Value: 'group___r_c_x_opcode_constants_gaab562f2dee5760eba89f4fca35950ada.html'
    ),
    (
     Name: 'RCX_OutputDirOp';
     Value: 'group___r_c_x_opcode_constants_ga020509600c93f9d62c95187607e83e5f.html'
    ),
    (
     Name: 'RCX_PlayToneVarOp';
     Value: 'group___r_c_x_opcode_constants_gaa9299e6ab68229c7acc4b0901713450f.html'
    ),
    (
     Name: 'RCX_PollOp';
     Value: 'group___r_c_x_opcode_constants_ga5091e95ae3538fa37279d335901898e9.html'
    ),
    (
     Name: 'RCX_SetWatchOp';
     Value: 'group___r_c_x_opcode_constants_ga4dd6e2973872374dce855d5920c189da.html'
    ),
    (
     Name: 'RCX_InputTypeOp';
     Value: 'group___r_c_x_opcode_constants_ga7b6cc31b64cbdd0b359ab813aec23da0.html'
    ),
    (
     Name: 'RCX_InputModeOp';
     Value: 'group___r_c_x_opcode_constants_ga4640f00802bdd780acbc9955aeb79aa3.html'
    ),
    (
     Name: 'RCX_SetDatalogOp';
     Value: 'group___r_c_x_opcode_constants_gab8571bb95a3f25fee5421acc4c94a739.html'
    ),
    (
     Name: 'RCX_DatalogOp';
     Value: 'group___r_c_x_opcode_constants_gabb596f7c833237264c4786f5c57312d3.html'
    ),
    (
     Name: 'RCX_SendUARTDataOp';
     Value: 'group___r_c_x_opcode_constants_gae539cc9cde242ff028520930bbf866c3.html'
    ),
    (
     Name: 'RCX_RemoteOp';
     Value: 'group___r_c_x_opcode_constants_ga669aaaa195ebd01a024f04108a0ffc9c.html'
    ),
    (
     Name: 'RCX_VLLOp';
     Value: 'group___r_c_x_opcode_constants_ga79af49d6f6b88d51f2597dcd1f4eff3c.html'
    ),
    (
     Name: 'RCX_DirectEventOp';
     Value: 'group___r_c_x_opcode_constants_ga78c21890c87c2e8a1dc618f64cabc627.html'
    ),
    (
     Name: 'RCX_OutputPowerOp';
     Value: 'group___r_c_x_opcode_constants_ga4ea1c2ec14ad70d574b5ff2646aab22d.html'
    ),
    (
     Name: 'RCX_PlayToneOp';
     Value: 'group___r_c_x_opcode_constants_ga0b9d4d069a850c6426bc5fb4152f70ab.html'
    ),
    (
     Name: 'RCX_DisplayOp';
     Value: 'group___r_c_x_opcode_constants_ga8808d66b2a0f8ae565f0c541e5bb96fa.html'
    ),
    (
     Name: 'RCX_PollMemoryOp';
     Value: 'group___r_c_x_opcode_constants_ga0491cc6d39b7f2c6793594d770c2fe95.html'
    ),
    (
     Name: 'RCX_SetFeedbackOp';
     Value: 'group___r_c_x_opcode_constants_gac7cff31022d0a20bb2ee40ee2f47aa9f.html'
    ),
    (
     Name: 'RCX_SetEventOp';
     Value: 'group___r_c_x_opcode_constants_ga8cc2e142952bbc28367cb2e3b1eebd3e.html'
    ),
    (
     Name: 'RCX_GOutputPowerOp';
     Value: 'group___r_c_x_opcode_constants_ga6b8f4f5ff229985bb744a4594ca58be4.html'
    ),
    (
     Name: 'RCX_LSUpperThreshOp';
     Value: 'group___r_c_x_opcode_constants_ga9fc439368ef90402860e2738cd998dec.html'
    ),
    (
     Name: 'RCX_LSLowerThreshOp';
     Value: 'group___r_c_x_opcode_constants_ga1472fbfc2634ce6e2f5570c22dbf6f81.html'
    ),
    (
     Name: 'RCX_LSHysteresisOp';
     Value: 'group___r_c_x_opcode_constants_ga044c48a093d689a95db8db55fdc1f6f4.html'
    ),
    (
     Name: 'RCX_LSBlinkTimeOp';
     Value: 'group___r_c_x_opcode_constants_gaf67ccf7a0406ff79a0955123796350eb.html'
    ),
    (
     Name: 'RCX_CalibrateEventOp';
     Value: 'group___r_c_x_opcode_constants_ga8af3b7e22e5c0647e146133f0b3783f8.html'
    ),
    (
     Name: 'RCX_SetVarOp';
     Value: 'group___r_c_x_opcode_constants_gaf9bc162bcb565a2055bda15877cc3b0d.html'
    ),
    (
     Name: 'RCX_SumVarOp';
     Value: 'group___r_c_x_opcode_constants_ga56cda58af4ae689d09e04c3c2a9fe42e.html'
    ),
    (
     Name: 'RCX_SubVarOp';
     Value: 'group___r_c_x_opcode_constants_ga952edc3890bf13bba288bace09b0bf3d.html'
    ),
    (
     Name: 'RCX_DivVarOp';
     Value: 'group___r_c_x_opcode_constants_gad766aa33ab614a959fefa3bf5264fc0c.html'
    ),
    (
     Name: 'RCX_MulVarOp';
     Value: 'group___r_c_x_opcode_constants_ga844741fd4272ac414253962c8f95c40a.html'
    ),
    (
     Name: 'RCX_SgnVarOp';
     Value: 'group___r_c_x_opcode_constants_ga683e73817eef4694db6c24c03fcbafcd.html'
    ),
    (
     Name: 'RCX_AbsVarOp';
     Value: 'group___r_c_x_opcode_constants_gae74dd1d075c34b2450d796817bb03483.html'
    ),
    (
     Name: 'RCX_AndVarOp';
     Value: 'group___r_c_x_opcode_constants_ga3678e73551597459cc492e9309bed8b1.html'
    ),
    (
     Name: 'RCX_OrVarOp';
     Value: 'group___r_c_x_opcode_constants_ga69621db8d5719ecae380fb4adb7315b0.html'
    ),
    (
     Name: 'RCX_UploadDatalogOp';
     Value: 'group___r_c_x_opcode_constants_ga7efa0cc3bf740fd2c25eb2422bb9aa0b.html'
    ),
    (
     Name: 'RCX_SetTimerLimitOp';
     Value: 'group___r_c_x_opcode_constants_ga2ef8094b7c127c0cba4ec0a6cfd810d1.html'
    ),
    (
     Name: 'RCX_SetCounterOp';
     Value: 'group___r_c_x_opcode_constants_gad2b241800d7d2fe92b51a58d0decd7f7.html'
    ),
    (
     Name: 'RCX_SetSourceValueOp';
     Value: 'group___r_c_x_opcode_constants_gacac25264c41fd6205827cb0d7d40ead9.html'
    ),
    (
     Name: 'RCX_UnlockOp';
     Value: 'group___r_c_x_opcode_constants_gacc84b2c902ec0b5d2779625c72068efd.html'
    ),
    (
     Name: 'RCX_BootModeOp';
     Value: 'group___r_c_x_opcode_constants_ga2e00e1060fcb423da73ad10f00edd78c.html'
    ),
    (
     Name: 'RCX_UnlockFirmOp';
     Value: 'group___r_c_x_opcode_constants_gafae33c2246de5fcb6d4533f857fffcb6.html'
    ),
    (
     Name: 'RCX_ScoutRulesOp';
     Value: 'group___r_c_x_opcode_constants_ga7277c1c08c21a68dfe60f8cab14ef89c.html'
    ),
    (
     Name: 'RCX_ViewSourceValOp';
     Value: 'group___r_c_x_opcode_constants_ga6dc18ae1c1811241eedfa872abcb06d9.html'
    ),
    (
     Name: 'RCX_ScoutOp';
     Value: 'group___r_c_x_opcode_constants_gac95e21e5a0ea71801a50e3be0ba12d84.html'
    ),
    (
     Name: 'RCX_SoundOp';
     Value: 'group___r_c_x_opcode_constants_ga4f0d4e3c62fe3cb3999c188b75ff858a.html'
    ),
    (
     Name: 'RCX_GOutputModeOp';
     Value: 'group___r_c_x_opcode_constants_ga1576b650fca297da98cfe99d3df7e913.html'
    ),
    (
     Name: 'RCX_GOutputDirOp';
     Value: 'group___r_c_x_opcode_constants_ga4498333e136e0cf2aef969b71ea2c419.html'
    ),
    (
     Name: 'RCX_LightOp';
     Value: 'group___r_c_x_opcode_constants_ga64aaf789bca549ec050bfbb76ca742a3.html'
    ),
    (
     Name: 'RCX_IncCounterOp';
     Value: 'group___r_c_x_opcode_constants_ga97d003f2d8c02a4c0bb2cf4e6d0f3236.html'
    ),
    (
     Name: 'RCX_DecCounterOp';
     Value: 'group___r_c_x_opcode_constants_ga5312641abc0db6de9d01fa8f72e353be.html'
    ),
    (
     Name: 'RCX_ClearCounterOp';
     Value: 'group___r_c_x_opcode_constants_ga69f30707ad7710b17aab8bfd7ec081ad.html'
    ),
    (
     Name: 'RCX_SetPriorityOp';
     Value: 'group___r_c_x_opcode_constants_ga4b741aecfddb1ce6a4b7a8dad6804b7c.html'
    ),
    (
     Name: 'RCX_MessageOp';
     Value: 'group___r_c_x_opcode_constants_ga30bf66e9e9849f41666f0ee483391b7c.html'
    ),
    (
     Name: 'PF_CMD_STOP';
     Value: 'group___p_f_cmd_constants_gabb5c3a931694750197d559339fc1d81b.html'
    ),
    (
     Name: 'PF_CMD_FLOAT';
     Value: 'group___p_f_cmd_constants_gaf6bd25144b71485cbd1042c6e9825583.html'
    ),
    (
     Name: 'PF_CMD_FWD';
     Value: 'group___p_f_cmd_constants_gad4dc6e9ac10070f09f815d33e61b4aaf.html'
    ),
    (
     Name: 'PF_CMD_REV';
     Value: 'group___p_f_cmd_constants_ga70e1197662332ed0b1c8ec0fdf014633.html'
    ),
    (
     Name: 'PF_CMD_BRAKE';
     Value: 'group___p_f_cmd_constants_ga4aa34e486fae2b7c5fa3b1285df72d07.html'
    ),
    (
     Name: 'PF_CHANNEL_1';
     Value: 'group___p_f_channel_constants_ga928ce3dce6661254a16358cda0fa20af.html'
    ),
    (
     Name: 'PF_CHANNEL_2';
     Value: 'group___p_f_channel_constants_gabe8fccc85c64daf5691ed984fb4b3bb1.html'
    ),
    (
     Name: 'PF_CHANNEL_3';
     Value: 'group___p_f_channel_constants_ga0e2f1d378a2bf6b234ed7e3781eec958.html'
    ),
    (
     Name: 'PF_CHANNEL_4';
     Value: 'group___p_f_channel_constants_ga6e9ef4e88eeb7a28bf3d71f56215f085.html'
    ),
    (
     Name: 'PF_MODE_TRAIN';
     Value: 'group___p_f_mode_constants_gaba0d6c7cc6bb6f9815781cb0bc3935fd.html'
    ),
    (
     Name: 'PF_MODE_COMBO_DIRECT';
     Value: 'group___p_f_mode_constants_ga992e3b6cf965b98952bdd3a5b7f9cf98.html'
    ),
    (
     Name: 'PF_MODE_SINGLE_PIN_CONT';
     Value: 'group___p_f_mode_constants_ga2a9aec8c5efc5d93e499d4b368812490.html'
    ),
    (
     Name: 'PF_MODE_SINGLE_PIN_TIME';
     Value: 'group___p_f_mode_constants_ga408866b42357f94afd0fdb68406a8843.html'
    ),
    (
     Name: 'PF_MODE_COMBO_PWM';
     Value: 'group___p_f_mode_constants_ga33aad2960abf690c87280562776a0206.html'
    ),
    (
     Name: 'PF_MODE_SINGLE_OUTPUT_PWM';
     Value: 'group___p_f_mode_constants_ga99f48c046e9ca9cd19e7582dbadd803e.html'
    ),
    (
     Name: 'PF_MODE_SINGLE_OUTPUT_CST';
     Value: 'group___p_f_mode_constants_ga787a359479596906074102eb2ce851bf.html'
    ),
    (
     Name: 'TRAIN_FUNC_STOP';
     Value: 'group___i_r_train_funcs_ga3d83b5fe69729852f6cac33f463fc827.html'
    ),
    (
     Name: 'TRAIN_FUNC_INCR_SPEED';
     Value: 'group___i_r_train_funcs_gaf0d54699c4875ba45cec0ed6edca927d.html'
    ),
    (
     Name: 'TRAIN_FUNC_DECR_SPEED';
     Value: 'group___i_r_train_funcs_ga5bd4b5b1f6a6c7319d7af5fe8253b1fa.html'
    ),
    (
     Name: 'TRAIN_FUNC_TOGGLE_LIGHT';
     Value: 'group___i_r_train_funcs_ga784fe10ed37b4425869726a4a379975d.html'
    ),
    (
     Name: 'TRAIN_CHANNEL_1';
     Value: 'group___i_r_train_channels_ga31f2963d115754685afe69b5ba9100a4.html'
    ),
    (
     Name: 'TRAIN_CHANNEL_2';
     Value: 'group___i_r_train_channels_gaeafb6048956cfa7114be1d6c38b38a5f.html'
    ),
    (
     Name: 'TRAIN_CHANNEL_3';
     Value: 'group___i_r_train_channels_gaa87efcdec0c23afc4908256694a38d04.html'
    ),
    (
     Name: 'TRAIN_CHANNEL_ALL';
     Value: 'group___i_r_train_channels_ga683655ed99569ab528b34ee6d40d77fe.html'
    ),
    (
     Name: 'PF_OUT_A';
     Value: 'group___p_f_outputs_gad07078510ebe6f7244462492ba35b346.html'
    ),
    (
     Name: 'PF_OUT_B';
     Value: 'group___p_f_outputs_ga82a88fa3781b542a7436da1634418a26.html'
    ),
    (
     Name: 'PF_PIN_C1';
     Value: 'group___p_f_pin_constants_ga32d8ed0b72f322cd9a5b039af96aaf17.html'
    ),
    (
     Name: 'PF_PIN_C2';
     Value: 'group___p_f_pin_constants_gaf6aae79036f0e9a89471fd4d1ae4229f.html'
    ),
    (
     Name: 'PF_FUNC_NOCHANGE';
     Value: 'group___p_f_pin_funcs_ga3274e5550bcf5d3710cedd5c3584e571.html'
    ),
    (
     Name: 'PF_FUNC_CLEAR';
     Value: 'group___p_f_pin_funcs_gad39dc2fa8e18552eea5c0bb9ab8b612e.html'
    ),
    (
     Name: 'PF_FUNC_SET';
     Value: 'group___p_f_pin_funcs_gab5e96f1a87248938b44f1909a68ca31e.html'
    ),
    (
     Name: 'PF_FUNC_TOGGLE';
     Value: 'group___p_f_pin_funcs_ga24df88540a3acd7def2955e4db5c1ede.html'
    ),
    (
     Name: 'PF_CST_CLEAR1_CLEAR2';
     Value: 'group___p_f_c_s_t_options_ga21f9b6bfd9479089167b2fa30b97b579.html'
    ),
    (
     Name: 'PF_CST_SET1_CLEAR2';
     Value: 'group___p_f_c_s_t_options_ga84c5a9c7a3ac92c93f6abb0bab4a349a.html'
    ),
    (
     Name: 'PF_CST_CLEAR1_SET2';
     Value: 'group___p_f_c_s_t_options_ga4a0fb6cb534ec091c63220f632e31062.html'
    ),
    (
     Name: 'PF_CST_SET1_SET2';
     Value: 'group___p_f_c_s_t_options_ga6969253ec92c97fe7708cebfa01295f8.html'
    ),
    (
     Name: 'PF_CST_INCREMENT_PWM';
     Value: 'group___p_f_c_s_t_options_ga996b06ff947fb96cf539b3c958196a30.html'
    ),
    (
     Name: 'PF_CST_DECREMENT_PWM';
     Value: 'group___p_f_c_s_t_options_ga31cb96c3992f264e4a95dae920a49e69.html'
    ),
    (
     Name: 'PF_CST_FULL_FWD';
     Value: 'group___p_f_c_s_t_options_ga16382076ca3dca68dba06b3582f013ac.html'
    ),
    (
     Name: 'PF_CST_FULL_REV';
     Value: 'group___p_f_c_s_t_options_ga44d7bb538251b2375b9e8417ce093e99.html'
    ),
    (
     Name: 'PF_CST_TOGGLE_DIR';
     Value: 'group___p_f_c_s_t_options_ga4880526bc118b01a767c6d4cdea47c97.html'
    ),
    (
     Name: 'PF_PWM_FLOAT';
     Value: 'group___p_f_p_w_m_options_ga425d28593e7abbe5ff7b74dfb2b30489.html'
    ),
    (
     Name: 'PF_PWM_FWD1';
     Value: 'group___p_f_p_w_m_options_ga128d20fea81bd3e1b9e029594c4b220e.html'
    ),
    (
     Name: 'PF_PWM_FWD2';
     Value: 'group___p_f_p_w_m_options_ga7437693f3ab70cbb7462aafcaa0d2ff9.html'
    ),
    (
     Name: 'PF_PWM_FWD3';
     Value: 'group___p_f_p_w_m_options_gaa786c5eb66b3af9f275f661f634f6516.html'
    ),
    (
     Name: 'PF_PWM_FWD4';
     Value: 'group___p_f_p_w_m_options_ga11bb5a5d2c81ce9f718445d59089e370.html'
    ),
    (
     Name: 'PF_PWM_FWD5';
     Value: 'group___p_f_p_w_m_options_ga7139e2ee9a53e99af453c3ea35bc3ccc.html'
    ),
    (
     Name: 'PF_PWM_FWD6';
     Value: 'group___p_f_p_w_m_options_gad3db6a497c63562797e45efdd1c481fe.html'
    ),
    (
     Name: 'PF_PWM_FWD7';
     Value: 'group___p_f_p_w_m_options_ga935cf205e58f150ed17502c849d5389d.html'
    ),
    (
     Name: 'PF_PWM_BRAKE';
     Value: 'group___p_f_p_w_m_options_ga1f7dfa97f72eccf1aa7ac0dbd425338e.html'
    ),
    (
     Name: 'PF_PWM_REV7';
     Value: 'group___p_f_p_w_m_options_ga592eb40ac5953ac0c3961d2cda7605ce.html'
    ),
    (
     Name: 'PF_PWM_REV6';
     Value: 'group___p_f_p_w_m_options_ga8841b6345c6c6e82301d4b61ef89bf39.html'
    ),
    (
     Name: 'PF_PWM_REV5';
     Value: 'group___p_f_p_w_m_options_ga18b5e14d97d473fcf38a077e088ddb88.html'
    ),
    (
     Name: 'PF_PWM_REV4';
     Value: 'group___p_f_p_w_m_options_gadcdb87a28e7454e65a32b04bf5fa0bb6.html'
    ),
    (
     Name: 'PF_PWM_REV3';
     Value: 'group___p_f_p_w_m_options_ga68efa2115f8969c8ae94819ce95b8b16.html'
    ),
    (
     Name: 'PF_PWM_REV2';
     Value: 'group___p_f_p_w_m_options_ga68046950881e9ce743b33a33ef163e8a.html'
    ),
    (
     Name: 'PF_PWM_REV1';
     Value: 'group___p_f_p_w_m_options_ga9d7c0a3c81333c3fbcba9a66d3bc3909.html'
    ),
    (
     Name: 'HT_ADDR_IRSEEKER';
     Value: 'group___hi_technic_constants_ga12516597b79cd534e80f74ef9c6ac9b2.html'
    ),
    (
     Name: 'HT_ADDR_IRSEEKER2';
     Value: 'group___hi_technic_constants_ga966edd5ee8d796051cedffbcdd6ae18d.html'
    ),
    (
     Name: 'HT_ADDR_IRRECEIVER';
     Value: 'group___hi_technic_constants_gad9836f2a99d32124c0fda74a7cd18f04.html'
    ),
    (
     Name: 'HT_ADDR_COMPASS';
     Value: 'group___hi_technic_constants_ga2df9e2e68763fcb1c7f71b3dcd263d3f.html'
    ),
    (
     Name: 'HT_ADDR_ACCEL';
     Value: 'group___hi_technic_constants_ga7ab0dbcc8ac9fa3c11491ddb10ff7572.html'
    ),
    (
     Name: 'HT_ADDR_COLOR';
     Value: 'group___hi_technic_constants_gab5a9238d6d39fbac33d6d407f8d272d5.html'
    ),
    (
     Name: 'HT_ADDR_COLOR2';
     Value: 'group___hi_technic_constants_gae1b82171c88923d8ce812b59ff191e48.html'
    ),
    (
     Name: 'HT_ADDR_IRLINK';
     Value: 'group___hi_technic_constants_ga4633d2e9361d461022473411fb65a432.html'
    ),
    (
     Name: 'HT_ADDR_ANGLE';
     Value: 'group___hi_technic_constants_gaab38d9edcb1bd4e47b34a11626bf140d.html'
    ),
    (
     Name: 'HTIR2_MODE_1200';
     Value: 'group___h_t_i_r_seeker2_constants_ga3ec2348617d3fae0aadb1eef110f7e2f.html'
    ),
    (
     Name: 'HTIR2_MODE_600';
     Value: 'group___h_t_i_r_seeker2_constants_gafcc380d4643025cda46a4142dd2b3b96.html'
    ),
    (
     Name: 'HTIR2_REG_MODE';
     Value: 'group___h_t_i_r_seeker2_constants_ga8e8727d7b6b54d740157742fb211e35b.html'
    ),
    (
     Name: 'HTIR2_REG_DCDIR';
     Value: 'group___h_t_i_r_seeker2_constants_ga34d420909bc68d2782bee825c7bcc5f7.html'
    ),
    (
     Name: 'HTIR2_REG_DC01';
     Value: 'group___h_t_i_r_seeker2_constants_ga2d19f3d65c619563dc774edbf4596fcb.html'
    ),
    (
     Name: 'HTIR2_REG_DC02';
     Value: 'group___h_t_i_r_seeker2_constants_ga4a20baa9fd346af17e68a32c924c03cd.html'
    ),
    (
     Name: 'HTIR2_REG_DC03';
     Value: 'group___h_t_i_r_seeker2_constants_gace794437e133491a5e2fae1ca3855693.html'
    ),
    (
     Name: 'HTIR2_REG_DC04';
     Value: 'group___h_t_i_r_seeker2_constants_ga42c5abf34e9ee4fb6fae8e3e50630ec5.html'
    ),
    (
     Name: 'HTIR2_REG_DC05';
     Value: 'group___h_t_i_r_seeker2_constants_gab2ff4e26121109846899822b16859934.html'
    ),
    (
     Name: 'HTIR2_REG_DCAVG';
     Value: 'group___h_t_i_r_seeker2_constants_gab8bc897a0631492b0a507740be9111a7.html'
    ),
    (
     Name: 'HTIR2_REG_ACDIR';
     Value: 'group___h_t_i_r_seeker2_constants_gaef58ce07ccc466fa4a10355dab538132.html'
    ),
    (
     Name: 'HTIR2_REG_AC01';
     Value: 'group___h_t_i_r_seeker2_constants_ga81f310672a59c9857f8a447133a8790e.html'
    ),
    (
     Name: 'HTIR2_REG_AC02';
     Value: 'group___h_t_i_r_seeker2_constants_gaf7b9b2ec045281ca2c819e6e1a50722c.html'
    ),
    (
     Name: 'HTIR2_REG_AC03';
     Value: 'group___h_t_i_r_seeker2_constants_ga72004fc6ecab50b281f82b2ae668f56b.html'
    ),
    (
     Name: 'HTIR2_REG_AC04';
     Value: 'group___h_t_i_r_seeker2_constants_ga5c8febcb5f4367d9696a564237ca9d95.html'
    ),
    (
     Name: 'HTIR2_REG_AC05';
     Value: 'group___h_t_i_r_seeker2_constants_ga076b4ca0f4f6cedce890632310a2954d.html'
    ),
    (
     Name: 'HT_CH1_A';
     Value: 'group___h_t_i_r_receiver_constants_gabb6199c532b8600bf2df3419a2aea10a.html'
    ),
    (
     Name: 'HT_CH1_B';
     Value: 'group___h_t_i_r_receiver_constants_ga4f50f8db31681d9025866c9f5f4f01a8.html'
    ),
    (
     Name: 'HT_CH2_A';
     Value: 'group___h_t_i_r_receiver_constants_gac77708427663692f8f0d9fb230259492.html'
    ),
    (
     Name: 'HT_CH2_B';
     Value: 'group___h_t_i_r_receiver_constants_gad3c4d227e87cd2227e138788b0f93ca6.html'
    ),
    (
     Name: 'HT_CH3_A';
     Value: 'group___h_t_i_r_receiver_constants_ga06d4c71af30b5648d22da59e6aac0522.html'
    ),
    (
     Name: 'HT_CH3_B';
     Value: 'group___h_t_i_r_receiver_constants_ga8f9bf0652def9e678b2458849f8053b7.html'
    ),
    (
     Name: 'HT_CH4_A';
     Value: 'group___h_t_i_r_receiver_constants_ga393abaaac47c892a7fb0bf2ac4349e79.html'
    ),
    (
     Name: 'HT_CH4_B';
     Value: 'group___h_t_i_r_receiver_constants_ga717653a1e7afc1d0793c5a1d34fb77e0.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_ACTIVE';
     Value: 'group___h_t_color2_constants_gaa10a1a4e9b28fea0641a13bf93738b40.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_PASSIVE';
     Value: 'group___h_t_color2_constants_gadacce805d234aeb40c0f79d80373fda0.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_RAW';
     Value: 'group___h_t_color2_constants_gae9ebe445aacf819329db0b6bc6584f52.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_50HZ';
     Value: 'group___h_t_color2_constants_ga103fcd227cfbb677f3f5fcc40120645d.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_60HZ';
     Value: 'group___h_t_color2_constants_ga1f559dc410816ea5b1d273e81067193f.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_BLCAL';
     Value: 'group___h_t_color2_constants_ga18e4d3056f93e66b2782fb392b66ada3.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_WBCAL';
     Value: 'group___h_t_color2_constants_ga085a6a0b16612a1ee5a673652fe40eb6.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_FAR';
     Value: 'group___h_t_color2_constants_gac6d75f61ca2cf0b9417efbdc552ca5a1.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_LED_HI';
     Value: 'group___h_t_color2_constants_ga44d5b50a13bd312dd9c643be72f00e0e.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_LED_LOW';
     Value: 'group___h_t_color2_constants_gabc0fe6f55c8868352b8814ccf65e8ed5.html'
    ),
    (
     Name: 'HT_CMD_COLOR2_NEAR';
     Value: 'group___h_t_color2_constants_ga72d606b2cde01cefb363ececf0321d04.html'
    ),
    (
     Name: 'HTANGLE_MODE_NORMAL';
     Value: 'group___h_t_angle_constants_ga5a088114760cd5b03077efbd77ac4b97.html'
    ),
    (
     Name: 'HTANGLE_MODE_CALIBRATE';
     Value: 'group___h_t_angle_constants_gadd4731a47ec48248156b673031ad8fbd.html'
    ),
    (
     Name: 'HTANGLE_MODE_RESET';
     Value: 'group___h_t_angle_constants_gaa299e655aeec12d8f3dc00377475d8e8.html'
    ),
    (
     Name: 'HTANGLE_REG_MODE';
     Value: 'group___h_t_angle_constants_ga4a73be180f66ad29b6f29c6088db63fa.html'
    ),
    (
     Name: 'HTANGLE_REG_DCDIR';
     Value: 'group___h_t_angle_constants_ga07b8396774eeaf221d155be5dbcb1e87.html'
    ),
    (
     Name: 'HTANGLE_REG_DC01';
     Value: 'group___h_t_angle_constants_ga709007c94793e98050c42284b1ee95fd.html'
    ),
    (
     Name: 'HTANGLE_REG_DC02';
     Value: 'group___h_t_angle_constants_gada954aa1c1604bf9d7e71bbd13d4503b.html'
    ),
    (
     Name: 'HTANGLE_REG_DC03';
     Value: 'group___h_t_angle_constants_gae2c8bfe0aecc11d221a9372f7ce738c8.html'
    ),
    (
     Name: 'HTANGLE_REG_DC04';
     Value: 'group___h_t_angle_constants_ga5753a90fd6e79ac9bf54c8533eae470b.html'
    ),
    (
     Name: 'HTANGLE_REG_DC05';
     Value: 'group___h_t_angle_constants_ga847084685d207668d9efd5e496d65c94.html'
    ),
    (
     Name: 'HTANGLE_REG_DCAVG';
     Value: 'group___h_t_angle_constants_ga58d62971264c00bd4a101b347eab5edc.html'
    ),
    (
     Name: 'HTANGLE_REG_ACDIR';
     Value: 'group___h_t_angle_constants_gab98acbb8edd369f305062915025c13a1.html'
    ),
    (
     Name: 'MS_CMD_ENERGIZED';
     Value: 'group___mind_sensors_constants_gadf1788cf326ea1e2f73f4157ba67cf29.html'
    ),
    (
     Name: 'MS_CMD_DEENERGIZED';
     Value: 'group___mind_sensors_constants_ga5cc6a92cd0d32210ef6e1f8864016b2c.html'
    ),
    (
     Name: 'MS_CMD_ADPA_ON';
     Value: 'group___mind_sensors_constants_ga7dbfbe096dea05369ba968530e76a4a0.html'
    ),
    (
     Name: 'MS_CMD_ADPA_OFF';
     Value: 'group___mind_sensors_constants_gaab6ebb532c31888477242a6f49942986.html'
    ),
    (
     Name: 'MS_ADDR_RTCLOCK';
     Value: 'group___mind_sensors_constants_gacf5037b2757324aa61468db668d0be01.html'
    ),
    (
     Name: 'MS_ADDR_DISTNX';
     Value: 'group___mind_sensors_constants_ga69c3fd7d254825ea358e72e3d1ad7c8e.html'
    ),
    (
     Name: 'MS_ADDR_NRLINK';
     Value: 'group___mind_sensors_constants_ga2e6be74583fc4323102025fc9f8167fd.html'
    ),
    (
     Name: 'MS_ADDR_ACCLNX';
     Value: 'group___mind_sensors_constants_ga63484fdd24d22fbaff37c9b714b7e7eb.html'
    ),
    (
     Name: 'MS_ADDR_CMPSNX';
     Value: 'group___mind_sensors_constants_ga80056f355bc257b4b19ca9fc40976ce1.html'
    ),
    (
     Name: 'MS_ADDR_PSPNX';
     Value: 'group___mind_sensors_constants_gadf0423b83b3358f7274c0f8a1cb9efaa.html'
    ),
    (
     Name: 'MS_ADDR_LINELDR';
     Value: 'group___mind_sensors_constants_gaf1ff0e5278221cd93bac57b9ac5e7a0c.html'
    ),
    (
     Name: 'MS_ADDR_NXTCAM';
     Value: 'group___mind_sensors_constants_ga00aad4208f9ad6fba896d204d58bc774.html'
    ),
    (
     Name: 'MS_ADDR_NXTHID';
     Value: 'group___mind_sensors_constants_gaa1679bf33767504105dbdd2c949a5387.html'
    ),
    (
     Name: 'MS_ADDR_NXTSERVO';
     Value: 'group___mind_sensors_constants_ga87e40fae609239e7de3d0bc34c6fe9b0.html'
    ),
    (
     Name: 'MS_ADDR_NXTSERVO_EM';
     Value: 'group___mind_sensors_constants_gaf18de4e25af4060e7326924de071da5d.html'
    ),
    (
     Name: 'MS_ADDR_PFMATE';
     Value: 'group___mind_sensors_constants_ga63ab6ca23a0e84220cdd965b63255d43.html'
    ),
    (
     Name: 'MS_ADDR_MTRMUX';
     Value: 'group___mind_sensors_constants_gae03be225a80f65dc4944447e99e65fff.html'
    ),
    (
     Name: 'MS_ADDR_NXTMMX';
     Value: 'group___mind_sensors_constants_gadf5d5eff85734dc24d54ab3a47c3a685.html'
    ),
    (
     Name: 'MS_ADDR_IVSENS';
     Value: 'group___mind_sensors_constants_ga5639a2403deee3cff0c7f72f4d8609d2.html'
    ),
    (
     Name: 'MS_ADDR_RXMUX';
     Value: 'group___mind_sensors_constants_gafebbbb3b894f637973b0969bb904251e.html'
    ),
    (
     Name: 'DIST_CMD_GP2D12';
     Value: 'group___m_s_dist_n_x_ga8a96057baba23e26eccaee9d1b2e65f0.html'
    ),
    (
     Name: 'DIST_CMD_GP2D120';
     Value: 'group___m_s_dist_n_x_gae0abc10f371f8770893ddc4cbe2851bb.html'
    ),
    (
     Name: 'DIST_CMD_GP2YA21';
     Value: 'group___m_s_dist_n_x_ga81452ed65d8a738f006d1b7479e96952.html'
    ),
    (
     Name: 'DIST_CMD_GP2YA02';
     Value: 'group___m_s_dist_n_x_ga60369fcf578e9097198d675b76c82b01.html'
    ),
    (
     Name: 'DIST_CMD_CUSTOM';
     Value: 'group___m_s_dist_n_x_ga3d40e632e9be308804cb88ae2ad629ee.html'
    ),
    (
     Name: 'DIST_REG_DIST';
     Value: 'group___m_s_dist_n_x_ga45d52711266a644e5ff008d14e220774.html'
    ),
    (
     Name: 'DIST_REG_VOLT';
     Value: 'group___m_s_dist_n_x_ga3c852f88f8160c8dd25aa79d2cbcbca8.html'
    ),
    (
     Name: 'DIST_REG_MODULE_TYPE';
     Value: 'group___m_s_dist_n_x_gaf62187bdfcbbf831f52a89147d959ce0.html'
    ),
    (
     Name: 'DIST_REG_NUM_POINTS';
     Value: 'group___m_s_dist_n_x_gadf7338a94a8b08ae1b4804098cdab090.html'
    ),
    (
     Name: 'DIST_REG_DIST_MIN';
     Value: 'group___m_s_dist_n_x_ga19b2e5c6dfd324af094e3acb6855157a.html'
    ),
    (
     Name: 'DIST_REG_DIST_MAX';
     Value: 'group___m_s_dist_n_x_gac1d9654bf3f5cceb744b63db5e406bb2.html'
    ),
    (
     Name: 'DIST_REG_VOLT1';
     Value: 'group___m_s_dist_n_x_ga23a4d0dfeeb5c2763873a695b4985ea2.html'
    ),
    (
     Name: 'DIST_REG_DIST1';
     Value: 'group___m_s_dist_n_x_gac32cf9d4e0a8d524fbd1f466c3917413.html'
    ),
    (
     Name: 'PSP_CMD_DIGITAL';
     Value: 'group___m_s_p_s_p_n_x_ga5ffbe485ce1d3a064203fa52a24473bc.html'
    ),
    (
     Name: 'PSP_CMD_ANALOG';
     Value: 'group___m_s_p_s_p_n_x_gac381c30c4d6c28ab837e751af30ce20d.html'
    ),
    (
     Name: 'PSP_REG_BTNSET1';
     Value: 'group___m_s_p_s_p_n_x_ga3e7bd2c19ee2f3420669656d04ca4df7.html'
    ),
    (
     Name: 'PSP_REG_BTNSET2';
     Value: 'group___m_s_p_s_p_n_x_ga9222572db163cb7b18c8d5058e30b2f8.html'
    ),
    (
     Name: 'PSP_REG_XLEFT';
     Value: 'group___m_s_p_s_p_n_x_ga59e8273a389873269d6ecd86b5597060.html'
    ),
    (
     Name: 'PSP_REG_YLEFT';
     Value: 'group___m_s_p_s_p_n_x_ga1832459a85c3126d14c0ddbefb93a768.html'
    ),
    (
     Name: 'PSP_REG_XRIGHT';
     Value: 'group___m_s_p_s_p_n_x_gac9da42c0150617e3ad9004100b274862.html'
    ),
    (
     Name: 'PSP_REG_YRIGHT';
     Value: 'group___m_s_p_s_p_n_x_ga98fcdf16e438a0d48e182197f660ba64.html'
    ),
    (
     Name: 'PSP_BTNSET1_LEFT';
     Value: 'group___m_s_p_s_p_n_x_btn_set1_ga55753ae2562c50d8ad240b17db24552e.html'
    ),
    (
     Name: 'PSP_BTNSET1_DOWN';
     Value: 'group___m_s_p_s_p_n_x_btn_set1_ga7b2472e7553a4c6a3cf6e6b9c9fed044.html'
    ),
    (
     Name: 'PSP_BTNSET1_RIGHT';
     Value: 'group___m_s_p_s_p_n_x_btn_set1_ga64a753abd76dbbcc63a26e990c1d652e.html'
    ),
    (
     Name: 'PSP_BTNSET1_UP';
     Value: 'group___m_s_p_s_p_n_x_btn_set1_ga62313f5ef82e1e466363f7dacee0c20e.html'
    ),
    (
     Name: 'PSP_BTNSET1_R3';
     Value: 'group___m_s_p_s_p_n_x_btn_set1_gab9959a1e606a395a582ae58f53d3bc3f.html'
    ),
    (
     Name: 'PSP_BTNSET1_L3';
     Value: 'group___m_s_p_s_p_n_x_btn_set1_ga4d1a3a46309a749eee192a6f239430ec.html'
    ),
    (
     Name: 'PSP_BTNSET2_SQUARE';
     Value: 'group___m_s_p_s_p_n_x_btn_set2_ga544f6b2a115afe49b9fbc2efb1215923.html'
    ),
    (
     Name: 'PSP_BTNSET2_CROSS';
     Value: 'group___m_s_p_s_p_n_x_btn_set2_ga9c09b4c43bb332a58cc607cb87ed9e4f.html'
    ),
    (
     Name: 'PSP_BTNSET2_CIRCLE';
     Value: 'group___m_s_p_s_p_n_x_btn_set2_ga540cebb34768d7e687721c3ea9f627db.html'
    ),
    (
     Name: 'PSP_BTNSET2_TRIANGLE';
     Value: 'group___m_s_p_s_p_n_x_btn_set2_ga61c94af1701081b137243d785ce143a5.html'
    ),
    (
     Name: 'PSP_BTNSET2_R1';
     Value: 'group___m_s_p_s_p_n_x_btn_set2_ga8b28074a50c534c4c2d371ac8cbcc5da.html'
    ),
    (
     Name: 'PSP_BTNSET2_L1';
     Value: 'group___m_s_p_s_p_n_x_btn_set2_ga10b604654a37a46e4d36aba13d2f05ae.html'
    ),
    (
     Name: 'PSP_BTNSET2_R2';
     Value: 'group___m_s_p_s_p_n_x_btn_set2_ga67fd5e6b619dcf767477a96d6072a7f4.html'
    ),
    (
     Name: 'PSP_BTNSET2_L2';
     Value: 'group___m_s_p_s_p_n_x_btn_set2_gaa59d2f2093c7ef8de9f4e789ef28c2df.html'
    ),
    (
     Name: 'NRLINK_CMD_2400';
     Value: 'group___m_s_n_r_link_ga33642a72a70044351d52aa9c3ef54bd5.html'
    ),
    (
     Name: 'NRLINK_CMD_FLUSH';
     Value: 'group___m_s_n_r_link_ga3283dba9434c8f2495502c578e22f439.html'
    ),
    (
     Name: 'NRLINK_CMD_4800';
     Value: 'group___m_s_n_r_link_ga30f0cdc15eeb40a48a17df7ee44687a2.html'
    ),
    (
     Name: 'NRLINK_CMD_IR_LONG';
     Value: 'group___m_s_n_r_link_gac4749d8f36c0b23d6f06960a1f833f65.html'
    ),
    (
     Name: 'NRLINK_CMD_IR_SHORT';
     Value: 'group___m_s_n_r_link_ga7b0cc120b78d71e531f6015d35e224f3.html'
    ),
    (
     Name: 'NRLINK_CMD_RUN_MACRO';
     Value: 'group___m_s_n_r_link_ga55b56a7eaa98f13f8de1af983cbc91dc.html'
    ),
    (
     Name: 'NRLINK_CMD_TX_RAW';
     Value: 'group___m_s_n_r_link_ga1c779931dd327e084947b55551de8d75.html'
    ),
    (
     Name: 'NRLINK_CMD_SET_RCX';
     Value: 'group___m_s_n_r_link_gaf79055f14fa969d3d7d5ee3adbccc909.html'
    ),
    (
     Name: 'NRLINK_CMD_SET_TRAIN';
     Value: 'group___m_s_n_r_link_gad3a1e4ffd8cfabda1cad334846943299.html'
    ),
    (
     Name: 'NRLINK_CMD_SET_PF';
     Value: 'group___m_s_n_r_link_ga7d56130b30a711518448810573ce9f84.html'
    ),
    (
     Name: 'NRLINK_REG_BYTES';
     Value: 'group___m_s_n_r_link_ga072227513db310301d5b205dcb909335.html'
    ),
    (
     Name: 'NRLINK_REG_DATA';
     Value: 'group___m_s_n_r_link_ga5ff4d0153664abbd1d14c180af27b7d1.html'
    ),
    (
     Name: 'NRLINK_REG_EEPROM';
     Value: 'group___m_s_n_r_link_ga40e9a9f73332bdcf8f649910c940567d.html'
    ),
    (
     Name: 'ACCL_CMD_X_CAL';
     Value: 'group___m_s_a_c_c_l_nx_gabd1bd72c77161aaa841c1a337dd654f8.html'
    ),
    (
     Name: 'ACCL_CMD_Y_CAL';
     Value: 'group___m_s_a_c_c_l_nx_gaa247a68824167c085352a0c1e26a9d95.html'
    ),
    (
     Name: 'ACCL_CMD_Z_CAL';
     Value: 'group___m_s_a_c_c_l_nx_ga1f11e72f0874c0acfb53f80a658ef1da.html'
    ),
    (
     Name: 'ACCL_CMD_X_CAL_END';
     Value: 'group___m_s_a_c_c_l_nx_ga9245094468ab805aca19b28f96c587e2.html'
    ),
    (
     Name: 'ACCL_CMD_Y_CAL_END';
     Value: 'group___m_s_a_c_c_l_nx_gac2f6ae62f57d6f2d2d5c0b54219c1c60.html'
    ),
    (
     Name: 'ACCL_CMD_Z_CAL_END';
     Value: 'group___m_s_a_c_c_l_nx_gabab3e279362283825057696260774954.html'
    ),
    (
     Name: 'ACCL_CMD_RESET_CAL';
     Value: 'group___m_s_a_c_c_l_nx_gaaeb16eec898aebcf1abf0363055362b0.html'
    ),
    (
     Name: 'ACCL_REG_SENS_LVL';
     Value: 'group___m_s_a_c_c_l_nx_gacead314404dcf99da93ae0998b278f51.html'
    ),
    (
     Name: 'ACCL_REG_X_TILT';
     Value: 'group___m_s_a_c_c_l_nx_gac831044c126ec4fa5b12b4295042c36c.html'
    ),
    (
     Name: 'ACCL_REG_Y_TILT';
     Value: 'group___m_s_a_c_c_l_nx_ga0408596016102293fcef15e8aac92e8b.html'
    ),
    (
     Name: 'ACCL_REG_Z_TILT';
     Value: 'group___m_s_a_c_c_l_nx_gafeae9b18af1591c2c16b093572c95771.html'
    ),
    (
     Name: 'ACCL_REG_X_ACCEL';
     Value: 'group___m_s_a_c_c_l_nx_ga60140fdd177a7b5fd2fd7ab09f18b429.html'
    ),
    (
     Name: 'ACCL_REG_Y_ACCEL';
     Value: 'group___m_s_a_c_c_l_nx_gab95b8e9e3eb74d77adc452c701ea057a.html'
    ),
    (
     Name: 'ACCL_REG_Z_ACCEL';
     Value: 'group___m_s_a_c_c_l_nx_ga3fb6e95d0417f30adc442c21f41ab1f1.html'
    ),
    (
     Name: 'ACCL_REG_X_OFFSET';
     Value: 'group___m_s_a_c_c_l_nx_ga724abb56f7fec0f714ebaa99c92bf0dd.html'
    ),
    (
     Name: 'ACCL_REG_X_RANGE';
     Value: 'group___m_s_a_c_c_l_nx_ga34c2d0deeee76ecbda07248e9120604c.html'
    ),
    (
     Name: 'ACCL_REG_Y_OFFSET';
     Value: 'group___m_s_a_c_c_l_nx_ga170d3e8844d06b76695769b2bdceaf16.html'
    ),
    (
     Name: 'ACCL_REG_Y_RANGE';
     Value: 'group___m_s_a_c_c_l_nx_ga1f80ca111b07272e659efc7eb9779974.html'
    ),
    (
     Name: 'ACCL_REG_Z_OFFSET';
     Value: 'group___m_s_a_c_c_l_nx_ga46921c25df61e3bce140b750dce1bbe9.html'
    ),
    (
     Name: 'ACCL_REG_Z_RANGE';
     Value: 'group___m_s_a_c_c_l_nx_ga55c51263358c0cb8c4df4c0a60ddcd51.html'
    ),
    (
     Name: 'ACCL_SENSITIVITY_LEVEL_1';
     Value: 'group___m_s_a_c_c_l_nx_s_level_gaf0894b457aba4e013794de01b8205395.html'
    ),
    (
     Name: 'ACCL_SENSITIVITY_LEVEL_2';
     Value: 'group___m_s_a_c_c_l_nx_s_level_ga3052e165f2870854d4286eec088752f3.html'
    ),
    (
     Name: 'ACCL_SENSITIVITY_LEVEL_3';
     Value: 'group___m_s_a_c_c_l_nx_s_level_ga6a9a16f3eebff833d04d34908f861479.html'
    ),
    (
     Name: 'ACCL_SENSITIVITY_LEVEL_4';
     Value: 'group___m_s_a_c_c_l_nx_s_level_ga587b1074c4da94a77fe9acb8a844f1d0.html'
    ),
    (
     Name: 'PFMATE_REG_CMD';
     Value: 'group___p_f_mate_constants_ga2d93e4757ee25902b0b02b70264e9b01.html'
    ),
    (
     Name: 'PFMATE_REG_CHANNEL';
     Value: 'group___p_f_mate_constants_gab03eea433a628449572288c69b1cd796.html'
    ),
    (
     Name: 'PFMATE_REG_MOTORS';
     Value: 'group___p_f_mate_constants_ga89fa31b2f05e97759e4d5d7ef80ea6db.html'
    ),
    (
     Name: 'PFMATE_REG_A_CMD';
     Value: 'group___p_f_mate_constants_ga4e5f39c463d33afbaadd578c1ab32374.html'
    ),
    (
     Name: 'PFMATE_REG_A_SPEED';
     Value: 'group___p_f_mate_constants_ga093f624cd3c2467b6dd5299989293ccd.html'
    ),
    (
     Name: 'PFMATE_REG_B_CMD';
     Value: 'group___p_f_mate_constants_ga46e3c8587624f5f7873571fc2378f766.html'
    ),
    (
     Name: 'PFMATE_REG_B_SPEED';
     Value: 'group___p_f_mate_constants_ga71b5c2a4b3f6a6174c0b8bf61ef31b62.html'
    ),
    (
     Name: 'PFMATE_CMD_GO';
     Value: 'group___p_f_mate_constants_gad591f4fe750ad78d2e32881fb7c4a8d7.html'
    ),
    (
     Name: 'PFMATE_CMD_RAW';
     Value: 'group___p_f_mate_constants_ga7b2f7a6cc67db262f7c6b71981ba66c7.html'
    ),
    (
     Name: 'PFMATE_MOTORS_BOTH';
     Value: 'group___p_f_mate_motor_constants_ga3d8086b2e9e2c174f3d681eaebc417df.html'
    ),
    (
     Name: 'PFMATE_MOTORS_A';
     Value: 'group___p_f_mate_motor_constants_gaa68b2f3f986d4d0efd3bc2e5890caa06.html'
    ),
    (
     Name: 'PFMATE_MOTORS_B';
     Value: 'group___p_f_mate_motor_constants_ga7c0a0967e176e300cdee409969d14a88.html'
    ),
    (
     Name: 'PFMATE_CHANNEL_1';
     Value: 'group___p_f_mate_channel_constants_ga200dd5516757729a2294072d6ac1595f.html'
    ),
    (
     Name: 'PFMATE_CHANNEL_2';
     Value: 'group___p_f_mate_channel_constants_ga32ae5dde62a21ab55ff6e06635bc28ff.html'
    ),
    (
     Name: 'PFMATE_CHANNEL_3';
     Value: 'group___p_f_mate_channel_constants_ga5b8b97dddc1bbe68dbff009f7e025634.html'
    ),
    (
     Name: 'PFMATE_CHANNEL_4';
     Value: 'group___p_f_mate_channel_constants_gabb2032002dcf2123b541b415d7a455f7.html'
    ),
    (
     Name: 'NXTSERVO_REG_VOLTAGE';
     Value: 'group___n_x_t_servo_registers_ga287bda9bb376fc4a8d614618c4245afd.html'
    ),
    (
     Name: 'NXTSERVO_REG_CMD';
     Value: 'group___n_x_t_servo_registers_ga6b03e903167c9e43596c35434b220b62.html'
    ),
    (
     Name: 'NXTSERVO_REG_S1_POS';
     Value: 'group___n_x_t_servo_registers_ga3390792ce2e319b6c336152e3f0d4718.html'
    ),
    (
     Name: 'NXTSERVO_REG_S2_POS';
     Value: 'group___n_x_t_servo_registers_ga60e107234e9f0809cffd69e947df6917.html'
    ),
    (
     Name: 'NXTSERVO_REG_S3_POS';
     Value: 'group___n_x_t_servo_registers_ga8f16047b7e21adffe04e1580bf19953b.html'
    ),
    (
     Name: 'NXTSERVO_REG_S4_POS';
     Value: 'group___n_x_t_servo_registers_ga6965e231288da30677d41923a46adc59.html'
    ),
    (
     Name: 'NXTSERVO_REG_S5_POS';
     Value: 'group___n_x_t_servo_registers_ga7e123c79eef62f13097ba8136535a064.html'
    ),
    (
     Name: 'NXTSERVO_REG_S6_POS';
     Value: 'group___n_x_t_servo_registers_gad708a2afd6617bdbf12c1de58f462dac.html'
    ),
    (
     Name: 'NXTSERVO_REG_S7_POS';
     Value: 'group___n_x_t_servo_registers_ga11480dcfc13d383d5bc4214bd07de697.html'
    ),
    (
     Name: 'NXTSERVO_REG_S8_POS';
     Value: 'group___n_x_t_servo_registers_ga80da5a0c8ce915cef87713044e3057dd.html'
    ),
    (
     Name: 'NXTSERVO_REG_S1_SPEED';
     Value: 'group___n_x_t_servo_registers_gad3d788f80c8f78080058f629cd8128bf.html'
    ),
    (
     Name: 'NXTSERVO_REG_S2_SPEED';
     Value: 'group___n_x_t_servo_registers_gac75cf2fa27c154db37583f46b449a7ed.html'
    ),
    (
     Name: 'NXTSERVO_REG_S3_SPEED';
     Value: 'group___n_x_t_servo_registers_gaa88607f776bb89944b67adcc95b8d090.html'
    ),
    (
     Name: 'NXTSERVO_REG_S4_SPEED';
     Value: 'group___n_x_t_servo_registers_ga5da5852b620dac4ef71cf3fff55f23d6.html'
    ),
    (
     Name: 'NXTSERVO_REG_S5_SPEED';
     Value: 'group___n_x_t_servo_registers_ga7701fe1dd310c06ff3879fb42f70f08b.html'
    ),
    (
     Name: 'NXTSERVO_REG_S6_SPEED';
     Value: 'group___n_x_t_servo_registers_gab2ff74483bfe03830e2b951a2577de2c.html'
    ),
    (
     Name: 'NXTSERVO_REG_S7_SPEED';
     Value: 'group___n_x_t_servo_registers_ga9fc5f1cfd451c04d8593895ca2ae090a.html'
    ),
    (
     Name: 'NXTSERVO_REG_S8_SPEED';
     Value: 'group___n_x_t_servo_registers_gad76e7737fa6c6f0e957d10a9fbf2b6f9.html'
    ),
    (
     Name: 'NXTSERVO_REG_S1_QPOS';
     Value: 'group___n_x_t_servo_registers_ga24ba0f078299671b66a99755134da690.html'
    ),
    (
     Name: 'NXTSERVO_REG_S2_QPOS';
     Value: 'group___n_x_t_servo_registers_ga566172cdce99bdc5640e787d2281b7c3.html'
    ),
    (
     Name: 'NXTSERVO_REG_S3_QPOS';
     Value: 'group___n_x_t_servo_registers_ga820b566fb17e83db083e9391aab6d3cd.html'
    ),
    (
     Name: 'NXTSERVO_REG_S4_QPOS';
     Value: 'group___n_x_t_servo_registers_gac0d604cc04665cd5b281fbf445d67ae7.html'
    ),
    (
     Name: 'NXTSERVO_REG_S5_QPOS';
     Value: 'group___n_x_t_servo_registers_ga8473401c00badfa7d1d85522afcb5578.html'
    ),
    (
     Name: 'NXTSERVO_REG_S6_QPOS';
     Value: 'group___n_x_t_servo_registers_gaac006f43f7c56e57734c06e042079f4c.html'
    ),
    (
     Name: 'NXTSERVO_REG_S7_QPOS';
     Value: 'group___n_x_t_servo_registers_ga22ce61c0e3ea41f27d7e537a560cc991.html'
    ),
    (
     Name: 'NXTSERVO_REG_S8_QPOS';
     Value: 'group___n_x_t_servo_registers_gaf0f8857c863a85f58460a5356802bd83.html'
    ),
    (
     Name: 'NXTSERVO_EM_REG_CMD';
     Value: 'group___n_x_t_servo_registers_gaa83276220566201e2b8b465b155ae40f.html'
    ),
    (
     Name: 'NXTSERVO_EM_REG_EEPROM_START';
     Value: 'group___n_x_t_servo_registers_gae913bc597f057f3305146d14d2c53c11.html'
    ),
    (
     Name: 'NXTSERVO_EM_REG_EEPROM_END';
     Value: 'group___n_x_t_servo_registers_ga0846b1e87396008ae7c12f9bc70ae654.html'
    ),
    (
     Name: 'NXTSERVO_POS_CENTER';
     Value: 'group___n_x_t_servo_pos_ga96108e99d9a89f006fe91b985ec4f40e.html'
    ),
    (
     Name: 'NXTSERVO_POS_MIN';
     Value: 'group___n_x_t_servo_pos_ga206b839672b273a1924828ba85b4a067.html'
    ),
    (
     Name: 'NXTSERVO_POS_MAX';
     Value: 'group___n_x_t_servo_pos_gaaea20332e499a2cefda806c49dd422e6.html'
    ),
    (
     Name: 'NXTSERVO_QPOS_CENTER';
     Value: 'group___n_x_t_servo_q_pos_gaa7744a9d2d070e52fa1d12fdf202f611.html'
    ),
    (
     Name: 'NXTSERVO_QPOS_MIN';
     Value: 'group___n_x_t_servo_q_pos_ga254bc7338798fff9e239755e2ab88730.html'
    ),
    (
     Name: 'NXTSERVO_QPOS_MAX';
     Value: 'group___n_x_t_servo_q_pos_ga27690f7996fcabdf99270d2cf12fe5f5.html'
    ),
    (
     Name: 'NXTSERVO_SERVO_1';
     Value: 'group___n_x_t_servo_numbers_ga28f3c8b6640f21ca30ae2193529d71a4.html'
    ),
    (
     Name: 'NXTSERVO_SERVO_2';
     Value: 'group___n_x_t_servo_numbers_ga2e30ae52ca02ccfbf97540dd03409a8c.html'
    ),
    (
     Name: 'NXTSERVO_SERVO_3';
     Value: 'group___n_x_t_servo_numbers_ga502a5befe23ddfef3c88ae3c502747d2.html'
    ),
    (
     Name: 'NXTSERVO_SERVO_4';
     Value: 'group___n_x_t_servo_numbers_ga0108ac5b87b11b0fc22e7d0c4a20fee6.html'
    ),
    (
     Name: 'NXTSERVO_SERVO_5';
     Value: 'group___n_x_t_servo_numbers_ga9dd3d10492f87c11101955a524123994.html'
    ),
    (
     Name: 'NXTSERVO_SERVO_6';
     Value: 'group___n_x_t_servo_numbers_ga27b56e65c1ebc749622b2e4e980218c2.html'
    ),
    (
     Name: 'NXTSERVO_SERVO_7';
     Value: 'group___n_x_t_servo_numbers_gaa97196c0d4af6fb6205c52e11dc28952.html'
    ),
    (
     Name: 'NXTSERVO_SERVO_8';
     Value: 'group___n_x_t_servo_numbers_ga42d0bec1151b124fdd4e6181ed0cb502.html'
    ),
    (
     Name: 'NXTSERVO_CMD_INIT';
     Value: 'group___n_x_t_servo_commands_ga2633d1e3c6809a35b10eebc7c112b534.html'
    ),
    (
     Name: 'NXTSERVO_CMD_RESET';
     Value: 'group___n_x_t_servo_commands_ga0b7410596cd7f3e8830f206393497dec.html'
    ),
    (
     Name: 'NXTSERVO_CMD_HALT';
     Value: 'group___n_x_t_servo_commands_ga1515ca535f65e13da8d48eae0ce7352a.html'
    ),
    (
     Name: 'NXTSERVO_CMD_RESUME';
     Value: 'group___n_x_t_servo_commands_ga8fe50901f2f5b9a94eee57297971d648.html'
    ),
    (
     Name: 'NXTSERVO_CMD_GOTO';
     Value: 'group___n_x_t_servo_commands_gab2bf2fff9e43022ee008eb44a6292973.html'
    ),
    (
     Name: 'NXTSERVO_CMD_PAUSE';
     Value: 'group___n_x_t_servo_commands_gad0af90fbcff93ebf537215e0fb55ddee.html'
    ),
    (
     Name: 'NXTSERVO_CMD_EDIT1';
     Value: 'group___n_x_t_servo_commands_ga5eef977a9ae25a76a7338ed2d67af5ea.html'
    ),
    (
     Name: 'NXTSERVO_CMD_EDIT2';
     Value: 'group___n_x_t_servo_commands_ga19ed328ae27c95f16a74a0fcc1584f1e.html'
    ),
    (
     Name: 'NXTSERVO_EM_CMD_QUIT';
     Value: 'group___n_x_t_servo_commands_ga8127aeaf42188b4891d58e5ea218b8b0.html'
    ),
    (
     Name: 'NXTHID_REG_CMD';
     Value: 'group___n_x_t_h_i_d_registers_gaf3f882435a24a8e6b3b582f1d5600151.html'
    ),
    (
     Name: 'NXTHID_REG_MODIFIER';
     Value: 'group___n_x_t_h_i_d_registers_gaf66167418ef2d38068b4fb38d6f35671.html'
    ),
    (
     Name: 'NXTHID_REG_DATA';
     Value: 'group___n_x_t_h_i_d_registers_gaf49dcc2d29264aa614f24b9f00e60ea4.html'
    ),
    (
     Name: 'NXTHID_MOD_NONE';
     Value: 'group___n_x_t_h_i_d_modifiers_gad12cbaf14463ae4efa05cac66129e198.html'
    ),
    (
     Name: 'NXTHID_MOD_LEFT_CTRL';
     Value: 'group___n_x_t_h_i_d_modifiers_gab03597010e5e6d60ff937592931c9c90.html'
    ),
    (
     Name: 'NXTHID_MOD_LEFT_SHIFT';
     Value: 'group___n_x_t_h_i_d_modifiers_ga5f52ca6c188fa64fd7063773cba9bc1a.html'
    ),
    (
     Name: 'NXTHID_MOD_LEFT_ALT';
     Value: 'group___n_x_t_h_i_d_modifiers_ga2fc46b5f6840601fa68c8aae2254e6b0.html'
    ),
    (
     Name: 'NXTHID_MOD_LEFT_GUI';
     Value: 'group___n_x_t_h_i_d_modifiers_ga88ddf932d123408d432f42541d9f3ee2.html'
    ),
    (
     Name: 'NXTHID_MOD_RIGHT_CTRL';
     Value: 'group___n_x_t_h_i_d_modifiers_ga9032bd4c435601d27f67cc7413f74952.html'
    ),
    (
     Name: 'NXTHID_MOD_RIGHT_SHIFT';
     Value: 'group___n_x_t_h_i_d_modifiers_gadee77c6ef5c2d0998ab3b94ff1f14ccf.html'
    ),
    (
     Name: 'NXTHID_MOD_RIGHT_ALT';
     Value: 'group___n_x_t_h_i_d_modifiers_ga703f342ce6bbec1a3fadbcf403e725c2.html'
    ),
    (
     Name: 'NXTHID_MOD_RIGHT_GUI';
     Value: 'group___n_x_t_h_i_d_modifiers_ga8aa3032a1cb47c43673b9d515190b8e8.html'
    ),
    (
     Name: 'NXTHID_CMD_ASCII';
     Value: 'group___n_x_t_h_i_d_commands_gab39891754361ab622625900317d7d232.html'
    ),
    (
     Name: 'NXTHID_CMD_DIRECT';
     Value: 'group___n_x_t_h_i_d_commands_ga30c9e1f05d842d41513eb4267e76f12e.html'
    ),
    (
     Name: 'NXTHID_CMD_TRANSMIT';
     Value: 'group___n_x_t_h_i_d_commands_gaf17b4b6cc5ba7bf20b2999084ade461e.html'
    ),
    (
     Name: 'NXTPM_REG_CMD';
     Value: 'group___n_x_t_power_meter_registers_ga732fa24e725593a449e0734b2920d23f.html'
    ),
    (
     Name: 'NXTPM_REG_CURRENT';
     Value: 'group___n_x_t_power_meter_registers_ga6e50c64055444b8f647be166f46442a8.html'
    ),
    (
     Name: 'NXTPM_REG_VOLTAGE';
     Value: 'group___n_x_t_power_meter_registers_ga99634dba77f573195d61b4890b66b34b.html'
    ),
    (
     Name: 'NXTPM_REG_CAPACITY';
     Value: 'group___n_x_t_power_meter_registers_gaa315ef2e1fe7819f2fcc20f17a8bd761.html'
    ),
    (
     Name: 'NXTPM_REG_POWER';
     Value: 'group___n_x_t_power_meter_registers_ga963e72a523adab6ef622adc6854f486f.html'
    ),
    (
     Name: 'NXTPM_REG_TOTALPOWER';
     Value: 'group___n_x_t_power_meter_registers_ga82ab42d6c27c251b72f1712a934c2c42.html'
    ),
    (
     Name: 'NXTPM_REG_MAXCURRENT';
     Value: 'group___n_x_t_power_meter_registers_ga98ad39c8bf7ff9baf306f2e1775bcd62.html'
    ),
    (
     Name: 'NXTPM_REG_MINCURRENT';
     Value: 'group___n_x_t_power_meter_registers_ga1bac59c4e72c23bc0e3a1391c0b7c270.html'
    ),
    (
     Name: 'NXTPM_REG_MAXVOLTAGE';
     Value: 'group___n_x_t_power_meter_registers_gac6e167c164f60b786bf3002027a780a5.html'
    ),
    (
     Name: 'NXTPM_REG_MINVOLTAGE';
     Value: 'group___n_x_t_power_meter_registers_gaf219965f9c0c2c91986e6b4ed60a4e31.html'
    ),
    (
     Name: 'NXTPM_REG_TIME';
     Value: 'group___n_x_t_power_meter_registers_ga1dac4fced36e1faa7d34b4f875067c67.html'
    ),
    (
     Name: 'NXTPM_REG_USERGAIN';
     Value: 'group___n_x_t_power_meter_registers_ga262e0ca6366cf2df66d492cd43f516c9.html'
    ),
    (
     Name: 'NXTPM_REG_GAIN';
     Value: 'group___n_x_t_power_meter_registers_gadc30f4f7cd67d0c224f72f7130c1ccd8.html'
    ),
    (
     Name: 'NXTPM_REG_ERRORCOUNT';
     Value: 'group___n_x_t_power_meter_registers_ga37b15d380dfde43dd7468ea9a8d310d0.html'
    ),
    (
     Name: 'NXTPM_CMD_RESET';
     Value: 'group___n_x_t_power_meter_commands_ga1f553aa2320905b5a4ad58ad116f9474.html'
    ),
    (
     Name: 'NXTSE_ZONE_NONE';
     Value: 'group___n_x_t_sumo_eyes_constants_gae94563ef1ecffd7dc46c109f6ffbee7e.html'
    ),
    (
     Name: 'NXTSE_ZONE_FRONT';
     Value: 'group___n_x_t_sumo_eyes_constants_ga627bcf8bbca51748ea951cc952fe53a1.html'
    ),
    (
     Name: 'NXTSE_ZONE_LEFT';
     Value: 'group___n_x_t_sumo_eyes_constants_gadf1e95c567847ba1d37b33b21a46eb51.html'
    ),
    (
     Name: 'NXTSE_ZONE_RIGHT';
     Value: 'group___n_x_t_sumo_eyes_constants_gaba18b35bba915186ccd95462ca5b1f78.html'
    ),
    (
     Name: 'NXTLL_REG_CMD';
     Value: 'group___n_x_t_line_leader_registers_gaf1b83cd1c4dea97b04c68323884810d2.html'
    ),
    (
     Name: 'NXTLL_REG_STEERING';
     Value: 'group___n_x_t_line_leader_registers_gaa060bb1f3ee54da02d7d83b4c93fa198.html'
    ),
    (
     Name: 'NXTLL_REG_AVERAGE';
     Value: 'group___n_x_t_line_leader_registers_gaa12f3096cfa20cf3bc87f52ac96d6064.html'
    ),
    (
     Name: 'NXTLL_REG_RESULT';
     Value: 'group___n_x_t_line_leader_registers_gad07a707d78a061529dcf1262c557962b.html'
    ),
    (
     Name: 'NXTLL_REG_SETPOINT';
     Value: 'group___n_x_t_line_leader_registers_ga7271c1d56d87fc0371b06cdbc0c0335d.html'
    ),
    (
     Name: 'NXTLL_REG_KP_VALUE';
     Value: 'group___n_x_t_line_leader_registers_gac041b929daed4da9899520fb7462bd5c.html'
    ),
    (
     Name: 'NXTLL_REG_KI_VALUE';
     Value: 'group___n_x_t_line_leader_registers_gab1f0b4e93abaacdbd5606372f2511abd.html'
    ),
    (
     Name: 'NXTLL_REG_KD_VALUE';
     Value: 'group___n_x_t_line_leader_registers_ga457ad2bf94f21ec81082903776b5fb2b.html'
    ),
    (
     Name: 'NXTLL_REG_CALIBRATED';
     Value: 'group___n_x_t_line_leader_registers_ga7823527faae7ffa98f5c34e6b88095c6.html'
    ),
    (
     Name: 'NXTLL_REG_WHITELIMITS';
     Value: 'group___n_x_t_line_leader_registers_gab8c340ed1df9fb00968926a1ade36fc2.html'
    ),
    (
     Name: 'NXTLL_REG_BLACKLIMITS';
     Value: 'group___n_x_t_line_leader_registers_ga45a8397768404d1620dd4bc385b26439.html'
    ),
    (
     Name: 'NXTLL_REG_KP_FACTOR';
     Value: 'group___n_x_t_line_leader_registers_ga5d3ca5bca1c8804e9f517c712f70e5d2.html'
    ),
    (
     Name: 'NXTLL_REG_KI_FACTOR';
     Value: 'group___n_x_t_line_leader_registers_ga4ec90b2428450543210e0d1ae33f2aad.html'
    ),
    (
     Name: 'NXTLL_REG_KD_FACTOR';
     Value: 'group___n_x_t_line_leader_registers_ga58d786c2b73476e1d64ffa000b803b95.html'
    ),
    (
     Name: 'NXTLL_REG_WHITEDATA';
     Value: 'group___n_x_t_line_leader_registers_ga7b97c59ee0d1adaa85570407a44272be.html'
    ),
    (
     Name: 'NXTLL_REG_BLACKDATA';
     Value: 'group___n_x_t_line_leader_registers_ga358aab0257eeb2251ffa450202053d3e.html'
    ),
    (
     Name: 'NXTLL_REG_RAWVOLTAGE';
     Value: 'group___n_x_t_line_leader_registers_gac08c56847666ea0cc42077a77285a323.html'
    ),
    (
     Name: 'NXTLL_CMD_USA';
     Value: 'group___n_x_t_line_leader_commands_ga8f0a411fed71a8b02091f2e492bc3839.html'
    ),
    (
     Name: 'NXTLL_CMD_BLACK';
     Value: 'group___n_x_t_line_leader_commands_gaddb44c9d49fcbda4f87fec05acdf9760.html'
    ),
    (
     Name: 'NXTLL_CMD_POWERDOWN';
     Value: 'group___n_x_t_line_leader_commands_gaa587016e0a7df82add8c121f4aff2a6f.html'
    ),
    (
     Name: 'NXTLL_CMD_EUROPEAN';
     Value: 'group___n_x_t_line_leader_commands_ga3b31aeac50d8f46cd941ada19e3ef7c7.html'
    ),
    (
     Name: 'NXTLL_CMD_INVERT';
     Value: 'group___n_x_t_line_leader_commands_ga05232b42ebc9ee401726ea86cf68a88d.html'
    ),
    (
     Name: 'NXTLL_CMD_POWERUP';
     Value: 'group___n_x_t_line_leader_commands_ga19fe19cc80c4caf5472bc19a897eba06.html'
    ),
    (
     Name: 'NXTLL_CMD_RESET';
     Value: 'group___n_x_t_line_leader_commands_ga0641237242ecc2b7ad2b40e769dce2e0.html'
    ),
    (
     Name: 'NXTLL_CMD_SNAPSHOT';
     Value: 'group___n_x_t_line_leader_commands_ga8e5a5d945df03dceb5585ee288140bfe.html'
    ),
    (
     Name: 'NXTLL_CMD_UNIVERSAL';
     Value: 'group___n_x_t_line_leader_commands_ga127b045ebe4c4338f87e99bef0a0168f.html'
    ),
    (
     Name: 'NXTLL_CMD_WHITE';
     Value: 'group___n_x_t_line_leader_commands_ga831a8f649ba0bd3187e76656944780b6.html'
    ),
    (
     Name: 'RFID_MODE_STOP';
     Value: 'group___c_t_r_f_i_d_mode_constants_ga41f48d27490a21c45054c0dc4daef8a6.html'
    ),
    (
     Name: 'RFID_MODE_SINGLE';
     Value: 'group___c_t_r_f_i_d_mode_constants_ga9300bfb6f2ae049939c0923790e38eeb.html'
    ),
    (
     Name: 'RFID_MODE_CONTINUOUS';
     Value: 'group___c_t_r_f_i_d_mode_constants_ga9064d5262b76ff646fa0f9f8136673c8.html'
    ),
    (
     Name: 'CT_ADDR_RFID';
     Value: 'group___c_t_r_f_i_d_constants_ga8a306018ec49a04ec0b4cf3ccf8a0f89.html'
    ),
    (
     Name: 'CT_REG_STATUS';
     Value: 'group___c_t_r_f_i_d_constants_ga4ea363f279ab97a226f0815e9b28d388.html'
    ),
    (
     Name: 'CT_REG_MODE';
     Value: 'group___c_t_r_f_i_d_constants_gad885999bd4202cd96b7192981287c0b7.html'
    ),
    (
     Name: 'CT_REG_DATA';
     Value: 'group___c_t_r_f_i_d_constants_gafb06afdd122091ad3bf2a54b9dead516.html'
    ),
    (
     Name: 'DI_ADDR_DGPS';
     Value: 'group___d_i_g_p_s_constants_gaa16dc7c944304f5bba03026112cdc0ea.html'
    ),
    (
     Name: 'DGPS_REG_TIME';
     Value: 'group___d_i_g_p_s_constants_gab8527946457679b19d1aacf73d28fdf2.html'
    ),
    (
     Name: 'DGPS_REG_STATUS';
     Value: 'group___d_i_g_p_s_constants_ga43ec4e1db6337325df342c416c28596b.html'
    ),
    (
     Name: 'DGPS_REG_LATITUDE';
     Value: 'group___d_i_g_p_s_constants_ga2f60a7f1ae5dba314ceffb08797335b9.html'
    ),
    (
     Name: 'DGPS_REG_LONGITUDE';
     Value: 'group___d_i_g_p_s_constants_ga8a345daecd19890aa8c232608267d5ca.html'
    ),
    (
     Name: 'DGPS_REG_VELOCITY';
     Value: 'group___d_i_g_p_s_constants_ga5d08a9a60e251413a9cb03b381962f97.html'
    ),
    (
     Name: 'DGPS_REG_HEADING';
     Value: 'group___d_i_g_p_s_constants_gaeaf881456fc3d4fa89dd50c643a32c47.html'
    ),
    (
     Name: 'DGPS_REG_DISTANCE';
     Value: 'group___d_i_g_p_s_constants_ga5b5d29b67278bfba59bf93292cc5fcb1.html'
    ),
    (
     Name: 'DGPS_REG_WAYANGLE';
     Value: 'group___d_i_g_p_s_constants_ga37fd69db76af8456c233067490b7ce9b.html'
    ),
    (
     Name: 'DGPS_REG_LASTANGLE';
     Value: 'group___d_i_g_p_s_constants_gaf49f358a3f1491e491f6c75cad217c54.html'
    ),
    (
     Name: 'DGPS_REG_SETLATITUDE';
     Value: 'group___d_i_g_p_s_constants_gaeba71854d1b4b32aba3c5a7b718019f3.html'
    ),
    (
     Name: 'DGPS_REG_SETLONGITUDE';
     Value: 'group___d_i_g_p_s_constants_ga337e05bb0e6f5aad4cc5debf22603810.html'
    ),
    (
     Name: 'RICImgPoint';
     Value: 'group___r_i_c_macros_ga8ec61712d0ac0a8dc03f6093515cac22.html'
    ),
    (
     Name: 'RICImgRect';
     Value: 'group___r_i_c_macros_ga0f660ee50780513706425e0e82418b46.html'
    ),
    (
     Name: 'RICOpDescription';
     Value: 'group___r_i_c_macros_ga74e0ee86a970cdf8328d9c6315507514.html'
    ),
    (
     Name: 'RICOpCopyBits';
     Value: 'group___r_i_c_macros_ga9aa470660ff0237e8fe04cf46aa2a8fb.html'
    ),
    (
     Name: 'RICOpPixel';
     Value: 'group___r_i_c_macros_gac51d52759d803fded2fa39001a97eb17.html'
    ),
    (
     Name: 'RICOpLine';
     Value: 'group___r_i_c_macros_ga3d2932c82c41910b8b5f8c3e5b26ebbd.html'
    ),
    (
     Name: 'RICOpRect';
     Value: 'group___r_i_c_macros_gaa75fde1484bb07dc3a2a12a77ff0d999.html'
    ),
    (
     Name: 'RICOpCircle';
     Value: 'group___r_i_c_macros_gab7cc420a6d3519f8c0b7229c0071e892.html'
    ),
    (
     Name: 'RICOpNumBox';
     Value: 'group___r_i_c_macros_gaf67e36d7f38440c1396c011074ab717d.html'
    ),
    (
     Name: 'RICOpSprite';
     Value: 'group___r_i_c_macros_ga362ad8a25ddc24131c1fc5da12632928.html'
    ),
    (
     Name: 'RICSpriteData';
     Value: 'group___r_i_c_macros_ga543519ec0725419845c4de038aa1ac1b.html'
    ),
    (
     Name: 'RICOpVarMap';
     Value: 'group___r_i_c_macros_ga3a57d52a36143647e970557ec3e4059d.html'
    ),
    (
     Name: 'RICMapElement';
     Value: 'group___r_i_c_macros_gaf017251cb39f0531a082655bdca19b58.html'
    ),
    (
     Name: 'RICMapFunction';
     Value: 'group___r_i_c_macros_gacfae94d0e2ee9fe621e8276adcb9bbee.html'
    ),
    (
     Name: 'RICArg';
     Value: 'group___r_i_c_macros_gacabd1c83d292ecc4c0368a91c751aae0.html'
    ),
    (
     Name: 'RICMapArg';
     Value: 'group___r_i_c_macros_ga49542d23268c73f5e3ec413d80e0e82f.html'
    ),
    (
     Name: 'RICOpPolygon';
     Value: 'group___r_i_c_macros_ga6eaeffde8ee0e12e15d86f32c01da226.html'
    ),
    (
     Name: 'RICPolygonPoints';
     Value: 'group___r_i_c_macros_ga7ea781dd9087dc70013364cdf78e5dfa.html'
    ),
    (
     Name: 'RICOpEllipse';
     Value: 'group___r_i_c_macros_ga1900edc23f6dcc942c194f529683eaea.html'
    ),
    (
     Name: 'CHAR_BIT';
     Value: 'group___n_x_t_limits_ga308d9dd2c0028ddb184b455bbd7865de.html'
    ),
    (
     Name: 'SCHAR_MIN';
     Value: 'group___n_x_t_limits_gaa05d197000ad5c143ada0fcd9379b236.html'
    ),
    (
     Name: 'SCHAR_MAX';
     Value: 'group___n_x_t_limits_ga8c13fdd8c2840edf0cb04a65297037bb.html'
    ),
    (
     Name: 'UCHAR_MAX';
     Value: 'group___n_x_t_limits_ga4066e640ee269d5d8f83ff6643b7af5f.html'
    ),
    (
     Name: 'CHAR_MIN';
     Value: 'group___n_x_t_limits_ga5d707bd32338557ced18c6ac76ca1b3a.html'
    ),
    (
     Name: 'CHAR_MAX';
     Value: 'group___n_x_t_limits_ga778eefd6535a9d4b752fca5dd0af58db.html'
    ),
    (
     Name: 'SHRT_MIN';
     Value: 'group___n_x_t_limits_gae59de266aceffa1c258ac13f45fe0d18.html'
    ),
    (
     Name: 'SHRT_MAX';
     Value: 'group___n_x_t_limits_ga1f758438cb1c7bcf55da2431f5e319e6.html'
    ),
    (
     Name: 'USHRT_MAX';
     Value: 'group___n_x_t_limits_ga689b119da994dece91d44b5aeac643ed.html'
    ),
    (
     Name: 'INT_MIN';
     Value: 'group___n_x_t_limits_ga21658776274b3d146c674318b635a334.html'
    ),
    (
     Name: 'INT_MAX';
     Value: 'group___n_x_t_limits_ga9ec306f36d50c7375e74f0d1c55a3a67.html'
    ),
    (
     Name: 'UINT_MAX';
     Value: 'group___n_x_t_limits_gac998ea02fbd821fc123d60445ce76f38.html'
    ),
    (
     Name: 'LONG_MIN';
     Value: 'group___n_x_t_limits_gae8a44c5a7436466221e0f3859d02420f.html'
    ),
    (
     Name: 'LONG_MAX';
     Value: 'group___n_x_t_limits_ga50fece4db74f09568b2938db583c5655.html'
    ),
    (
     Name: 'ULONG_MAX';
     Value: 'group___n_x_t_limits_ga41c51926a1997aab3503f9083935e06c.html'
    ),
    (
     Name: 'RAND_MAX';
     Value: 'group___n_x_t_limits_ga690f251553b39fd4f31894826141b61a.html'
    ),
    (
     Name: 'GL_POLYGON';
     Value: 'group___g_l_constants_begin_modes_gabed3bfcbd65f2285c12e96b566668b6f.html'
    ),
    (
     Name: 'GL_LINE';
     Value: 'group___g_l_constants_begin_modes_gabbfc2afe81343b8bb6e636fd60aa8e39.html'
    ),
    (
     Name: 'GL_POINT';
     Value: 'group___g_l_constants_begin_modes_ga18f542292378fb0f3093fcaec1878b60.html'
    ),
    (
     Name: 'GL_CIRCLE';
     Value: 'group___g_l_constants_begin_modes_gaa4c003d85039abadc2665d71ac28fcb9.html'
    ),
    (
     Name: 'GL_TRANSLATE_X';
     Value: 'group___g_l_constants_actions_gadd59c353c57bc6c417e9fc9f6b663b8d.html'
    ),
    (
     Name: 'GL_TRANSLATE_Y';
     Value: 'group___g_l_constants_actions_gaada02bd81a1adea0cf52210c53f14872.html'
    ),
    (
     Name: 'GL_TRANSLATE_Z';
     Value: 'group___g_l_constants_actions_ga6040ac3c11f3664cc19ea25a94ab48b7.html'
    ),
    (
     Name: 'GL_ROTATE_X';
     Value: 'group___g_l_constants_actions_gada0d2b4207f230a6f76f90b4ced9045e.html'
    ),
    (
     Name: 'GL_ROTATE_Y';
     Value: 'group___g_l_constants_actions_ga09dca7df94e864380ec7ee8113500be0.html'
    ),
    (
     Name: 'GL_ROTATE_Z';
     Value: 'group___g_l_constants_actions_ga26ab20bf9ddb23ddab50616a64473eab.html'
    ),
    (
     Name: 'GL_SCALE_X';
     Value: 'group___g_l_constants_actions_ga74be5736f17efc25b4ed860e30796b9f.html'
    ),
    (
     Name: 'GL_SCALE_Y';
     Value: 'group___g_l_constants_actions_ga11cb5e554493dbc92165143a7e081eb3.html'
    ),
    (
     Name: 'GL_SCALE_Z';
     Value: 'group___g_l_constants_actions_gaca1325ac6d1545143e5db76c595989bb.html'
    ),
    (
     Name: 'GL_CIRCLE_SIZE';
     Value: 'group___g_l_constants_settings_ga33d43872a6831dba2fd6741793f54df1.html'
    ),
    (
     Name: 'GL_CULL_MODE';
     Value: 'group___g_l_constants_settings_gad79b50a1b2a95831c56ca6fc4dfa9c0b.html'
    ),
    (
     Name: 'GL_CAMERA_DEPTH';
     Value: 'group___g_l_constants_settings_ga29f6e1a402743fcad0a489449616d9fa.html'
    ),
    (
     Name: 'GL_ZOOM_FACTOR';
     Value: 'group___g_l_constants_settings_ga69fb657ae7e361b4a8c6e90edf14e4f0.html'
    ),
    (
     Name: 'GL_CULL_BACK';
     Value: 'group___g_l_constants_cull_mode_gaa786847ed4697e95ddd20d634a862907.html'
    ),
    (
     Name: 'GL_CULL_FRONT';
     Value: 'group___g_l_constants_cull_mode_gab6fdd16e37937bbe318ace2ce27bc310.html'
    ),
    (
     Name: 'GL_CULL_NONE';
     Value: 'group___g_l_constants_cull_mode_ga4183b74ce9f7e1517a76994b75178264.html'
    ),
    (
     Name: 'LT';
     Value: 'group__cmpconst_gaaf56b99cbe34023f42ce5b7878c827d8.html'
    ),
    (
     Name: 'GT';
     Value: 'group__cmpconst_gab89310b3f2f97e4e9415fc5a51549612.html'
    ),
    (
     Name: 'LTEQ';
     Value: 'group__cmpconst_ga02df353ac0479078a86faf2cb90764d2.html'
    ),
    (
     Name: 'GTEQ';
     Value: 'group__cmpconst_gaa4a13738d5fcbfd2aa83aba2992d0b0e.html'
    ),
    (
     Name: 'EQ';
     Value: 'group__cmpconst_gabaab8d42f075ee8ddc9b70951d3fd6cd.html'
    ),
    (
     Name: 'NEQ';
     Value: 'group__cmpconst_ga2b6ba3ea1fe3e8cc970ad05cd05d703b.html'
    ),
    (
     Name: 'ResetTachoCount';
     Value: 'group___output_module_functions_ga228b20c45135f090bda07f645d8453c1.html'
    ),
    (
     Name: 'ResetBlockTachoCount';
     Value: 'group___output_module_functions_gae230e3b798d2bb2978f3d48cd30f23ee.html'
    ),
    (
     Name: 'ResetRotationCount';
     Value: 'group___output_module_functions_ga3dac894bb7adae8702bfbb0ee0a786aa.html'
    ),
    (
     Name: 'ResetAllTachoCounts';
     Value: 'group___output_module_functions_ga2490d5b7547efbd5767e2791496b28ab.html'
    ),
    (
     Name: 'OnFwdEx';
     Value: 'group___output_module_functions_gad0d0d28c0cc3619adb7556d9335addb1.html'
    ),
    (
     Name: 'OnRevEx';
     Value: 'group___output_module_functions_gad61382478117e95a8ba658ddce54c2e9.html'
    ),
    (
     Name: 'OnFwdExPID';
     Value: 'group___output_module_functions_gab8c5ad3a416b44c3957f9fb19ed698c9.html'
    ),
    (
     Name: 'OnRevExPID';
     Value: 'group___output_module_functions_ga850f0aba6b10986bf15d9a4442d81151.html'
    ),
    (
     Name: 'OnFwd';
     Value: 'group___output_module_functions_gad37be4ce40821e4f4087eb7b6d310240.html'
    ),
    (
     Name: 'OnRev';
     Value: 'group___output_module_functions_ga78952b7af0e66086a19ddc0cd6d4ec00.html'
    ),
    (
     Name: 'CoastEx';
     Value: 'group___output_module_functions_ga7dc7392315ad0ad8e8c5abcd33cf7f72.html'
    ),
    (
     Name: 'OffEx';
     Value: 'group___output_module_functions_ga5599b0cf0c4c16f2653698bcff1c047c.html'
    ),
    (
     Name: 'Coast';
     Value: 'group___output_module_functions_gabaa39b23aca015acc4ad50cbf178cb86.html'
    ),
    (
     Name: 'Off';
     Value: 'group___output_module_functions_ga92d36f57c48bb74c59b6257f01b2a266.html'
    ),
    (
     Name: 'Float';
     Value: 'group___output_module_functions_gae613f32994acac03cc854d7709276fd5.html'
    ),
    (
     Name: 'OnFwdRegEx';
     Value: 'group___output_module_functions_gad5e80d687ddd7c696a9a0fdf3af61f8d.html'
    ),
    (
     Name: 'OnRevRegEx';
     Value: 'group___output_module_functions_gad25e0480e5d4c11cfa9b3eacea36eb66.html'
    ),
    (
     Name: 'OnFwdRegExPID';
     Value: 'group___output_module_functions_ga1a97e5f78984e6bee028843d4c85d8a2.html'
    ),
    (
     Name: 'OnRevRegExPID';
     Value: 'group___output_module_functions_gaf3f6dc88ea4a30b3137cd8e170cfa9d1.html'
    ),
    (
     Name: 'OnFwdReg';
     Value: 'group___output_module_functions_ga340956396cd2ff1ffcbc8601ab0c8906.html'
    ),
    (
     Name: 'OnRevReg';
     Value: 'group___output_module_functions_ga9edfa489dce4005014f29d9c6d8f413d.html'
    ),
    (
     Name: 'OnFwdRegPID';
     Value: 'group___output_module_functions_ga874c609cdcd824de2bd970ce125b74a7.html'
    ),
    (
     Name: 'OnRevRegPID';
     Value: 'group___output_module_functions_gab5ead2d672e1a79acf3c91db96e5ba97.html'
    ),
    (
     Name: 'OnFwdSyncEx';
     Value: 'group___output_module_functions_ga5f759a14d35abf9c0b3aef38d7fb884b.html'
    ),
    (
     Name: 'OnRevSyncEx';
     Value: 'group___output_module_functions_ga2bbf5d52acb5974555530a90b9aa2dde.html'
    ),
    (
     Name: 'OnFwdSyncExPID';
     Value: 'group___output_module_functions_gad67d71838766f30027540cd46300c37f.html'
    ),
    (
     Name: 'OnRevSyncExPID';
     Value: 'group___output_module_functions_ga283b766be89d6d2dc340fdf670495f77.html'
    ),
    (
     Name: 'OnFwdSync';
     Value: 'group___output_module_functions_gaf63f7db5af59d89a5bb0fccbd51ab586.html'
    ),
    (
     Name: 'OnRevSync';
     Value: 'group___output_module_functions_gaa087302f68b136a09558e398fb2ff822.html'
    ),
    (
     Name: 'OnFwdSyncPID';
     Value: 'group___output_module_functions_gae13eb935cc730ffe7bcb11a9c9845622.html'
    ),
    (
     Name: 'OnRevSyncPID';
     Value: 'group___output_module_functions_ga43b0ffbbe07a122449a70220b87e2d1b.html'
    ),
    (
     Name: 'RotateMotorExPID';
     Value: 'group___output_module_functions_ga894ca04c6400dc043b564f65eb320f2e.html'
    ),
    (
     Name: 'RotateMotorPID';
     Value: 'group___output_module_functions_gade854738a8970f6d3fdfb50e56390962.html'
    ),
    (
     Name: 'RotateMotorEx';
     Value: 'group___output_module_functions_ga7b91ca180b56d4a4fda1f3c80025e474.html'
    ),
    (
     Name: 'RotateMotor';
     Value: 'group___output_module_functions_gaeb8e9980948a9d934edf0ea7c46191f9.html'
    ),
    (
     Name: 'SetOutPwnFreq';
     Value: 'group___output_module_functions_ga2068febadcb6c8334a63a103009a4ffb.html'
    ),
    (
     Name: 'GetOutPwnFreq';
     Value: 'group___output_module_functions_gabfb33d557f0f59260d7bd91c0335d51a.html'
    ),
    (
     Name: 'SetOutRegulationTime';
     Value: 'group___output_module_functions_ga3e6daa41ece9e8eb1f5cca8cb5839e70.html'
    ),
    (
     Name: 'GetOutRegulationTime';
     Value: 'group___output_module_functions_gaeb1772312b26f0a5b3f64720e1fd3895.html'
    ),
    (
     Name: 'SetOutRegulationOptions';
     Value: 'group___output_module_functions_ga75860a6a7e1b7a4929a06e21ff35c064.html'
    ),
    (
     Name: 'GetOutRegulationOptions';
     Value: 'group___output_module_functions_ga3d429c8db773483e91da9f010c03a327.html'
    ),
    (
     Name: 'SetSensorType';
     Value: 'group___input_module_functions_ga56bd140e24fb44ee2bd13e4414c3e1bd.html'
    ),
    (
     Name: 'SetSensorMode';
     Value: 'group___input_module_functions_ga0a7e6921cdd09c0c4a18d670e3f993b9.html'
    ),
    (
     Name: 'ReadSensor';
     Value: 'group___input_module_functions_ga168e4db7666040c2f3c0fe756c76a499.html'
    ),
    (
     Name: 'ClearSensor';
     Value: 'group___input_module_functions_gaa427475d32bb7ee394a9edbde5556f1f.html'
    ),
    (
     Name: 'SetSensorTouch';
     Value: 'group___input_module_functions_ga381cae9d1db57d0217bd8e39ea50677d.html'
    ),
    (
     Name: 'SetSensorLight';
     Value: 'group___input_module_functions_ga3dcbeb2af286b195c9c37b6775c7ad02.html'
    ),
    (
     Name: 'SetSensorSound';
     Value: 'group___input_module_functions_ga8b0c17b911b0bd7baefe797302a91b4c.html'
    ),
    (
     Name: 'SetSensorLowspeed';
     Value: 'group___input_module_functions_ga4eacfc91502818206fb5c3540df9ec87.html'
    ),
    (
     Name: 'SetSensorUltrasonic';
     Value: 'group___input_module_functions_gaf593560e5687f87b840cfd5cb3c2b8b5.html'
    ),
    (
     Name: 'SetSensorEMeter';
     Value: 'group___input_module_functions_ga24eaffa7e27b089f52d934e9df6d19bf.html'
    ),
    (
     Name: 'SetSensorTemperature';
     Value: 'group___input_module_functions_ga97348a2088944e8ee11916adbb571d72.html'
    ),
    (
     Name: 'SetSensorColorFull';
     Value: 'group___input_module_functions_ga89d7bbd5fc09c5109051e476d5fb6170.html'
    ),
    (
     Name: 'SetSensorColorRed';
     Value: 'group___input_module_functions_ga5eb5aba0df4ea4cc3641a5f00c11d317.html'
    ),
    (
     Name: 'SetSensorColorGreen';
     Value: 'group___input_module_functions_gaba6c3569de2ae091813b3b9f483de237.html'
    ),
    (
     Name: 'SetSensorColorBlue';
     Value: 'group___input_module_functions_ga1477e51756b6677c37f9cc039f4e38b1.html'
    ),
    (
     Name: 'SetSensorColorNone';
     Value: 'group___input_module_functions_gabd98ca27dc196031f51ede0c51eac43b.html'
    ),
    (
     Name: 'ResetSensor';
     Value: 'group___input_module_functions_gac34b4e430a7bf3217b6293a594600599.html'
    ),
    (
     Name: 'ReadSensorColorRaw';
     Value: 'group___input_module_functions_ga8c4c69d2db9bd9550bea8b354b8b9e6c.html'
    ),
    (
     Name: 'ReadSensorColorEx';
     Value: 'group___input_module_functions_gafb9aa8e2d490da97e442a04f4aea6b26.html'
    ),
    (
     Name: 'GetInCustomZeroOffset';
     Value: 'group___input_module_functions_ga71bfeaf4bcaad040476d9c5e41ef4b67.html'
    ),
    (
     Name: 'GetInSensorBoolean';
     Value: 'group___input_module_functions_ga4cba7aa10eead72cf8550c1a2a58e428.html'
    ),
    (
     Name: 'GetInDigiPinsDirection';
     Value: 'group___input_module_functions_gaaf9c78044c15b7d296dbb55bac6c1c92.html'
    ),
    (
     Name: 'GetInDigiPinsStatus';
     Value: 'group___input_module_functions_ga408c9aa27cff0048a52cebd4fed1a7fe.html'
    ),
    (
     Name: 'GetInDigiPinsOutputLevel';
     Value: 'group___input_module_functions_ga0590fb32044d5cacb9626618cf6704c8.html'
    ),
    (
     Name: 'GetInCustomPercentFullScale';
     Value: 'group___input_module_functions_gaf56cabde5ef0035fd444f0097db69bfb.html'
    ),
    (
     Name: 'GetInCustomActiveStatus';
     Value: 'group___input_module_functions_ga4ac6ae2d5a740206dbf0635e851fd69e.html'
    ),
    (
     Name: 'GetInColorCalibration';
     Value: 'group___input_module_functions_gaad3689e718acfc84e8c1542d8533ea05.html'
    ),
    (
     Name: 'GetInColorCalLimits';
     Value: 'group___input_module_functions_gab70266460643763cd944eeda4767dc9d.html'
    ),
    (
     Name: 'GetInColorADRaw';
     Value: 'group___input_module_functions_gac9d4c454a44e8d269ac462cfda839fc6.html'
    ),
    (
     Name: 'GetInColorSensorRaw';
     Value: 'group___input_module_functions_ga356e5937ecf490b2bd707be316ebe226.html'
    ),
    (
     Name: 'GetInColorSensorValue';
     Value: 'group___input_module_functions_gaf5755d19b1f71d40d74c27946606f46e.html'
    ),
    (
     Name: 'GetInColorBoolean';
     Value: 'group___input_module_functions_gab64bbfb616e30b37711289f846aef31e.html'
    ),
    (
     Name: 'GetInColorCalibrationState';
     Value: 'group___input_module_functions_gae49a6fd35d5258bcca00a30a149d858d.html'
    ),
    (
     Name: 'SetInCustomZeroOffset';
     Value: 'group___input_module_functions_ga65483431895c9448694e76a2e3161ffd.html'
    ),
    (
     Name: 'SetInSensorBoolean';
     Value: 'group___input_module_functions_gaa449b0b724d98cced3b78b2ee99f611c.html'
    ),
    (
     Name: 'SetInDigiPinsDirection';
     Value: 'group___input_module_functions_ga125de186e886f32c02a319c025be7df9.html'
    ),
    (
     Name: 'SetInDigiPinsStatus';
     Value: 'group___input_module_functions_gae5da6b29eab7d7d315f9fa72611ea5f1.html'
    ),
    (
     Name: 'SetInDigiPinsOutputLevel';
     Value: 'group___input_module_functions_gaa9a8534ab342d0cf218a4f7c9c71e96b.html'
    ),
    (
     Name: 'SetInCustomPercentFullScale';
     Value: 'group___input_module_functions_ga3ac647c044c2442d394abc142fe3a6e5.html'
    ),
    (
     Name: 'SetInCustomActiveStatus';
     Value: 'group___input_module_functions_ga3f6e2bbbbf5abe6d9f01e15e6dd6c3c9.html'
    ),
    (
     Name: 'ReadSensorUS';
     Value: 'group___low_speed_module_functions_ga613d7de9408db02c43b68e0d4e4b8495.html'
    ),
    (
     Name: 'ReadSensorUSEx';
     Value: 'group___low_speed_module_functions_ga624272c8430a2d6a8bc39f5f372ed21b.html'
    ),
    (
     Name: 'ReadSensorEMeter';
     Value: 'group___low_speed_module_functions_ga71d57fcd77253d58db6ce99ec912bec4.html'
    ),
    (
     Name: 'ConfigureTemperatureSensor';
     Value: 'group___low_speed_module_functions_ga0a08bc67655d06dfc0c305341fb4e8e1.html'
    ),
    (
     Name: 'ReadSensorTemperature';
     Value: 'group___low_speed_module_functions_gae8e5962a351adeb3c8b810d0b42c513f.html'
    ),
    (
     Name: 'LowspeedStatus';
     Value: 'group___low_speed_module_functions_gad48d2164b772915b09f04fb659a0c906.html'
    ),
    (
     Name: 'LowspeedCheckStatus';
     Value: 'group___low_speed_module_functions_gad715cffba221ca38309f731c953bfeb3.html'
    ),
    (
     Name: 'LowspeedBytesReady';
     Value: 'group___low_speed_module_functions_gaa104e491241a036e97713ce614b55ef5.html'
    ),
    (
     Name: 'LowspeedWrite';
     Value: 'group___low_speed_module_functions_ga1486061cc930ab1c1ed5613193cdaa72.html'
    ),
    (
     Name: 'LowspeedRead';
     Value: 'group___low_speed_module_functions_ga0579e052f1ef6e9708bd08e0df9d17e3.html'
    ),
    (
     Name: 'ReadI2CBytes';
     Value: 'group___low_speed_module_functions_gaa932713b7c47961f439e13620a397b72.html'
    ),
    (
     Name: 'ReadI2CDeviceInfo';
     Value: 'group___low_speed_module_functions_ga977f62eb0ac36f60100756a974107e7b.html'
    ),
    (
     Name: 'ReadI2CVersion';
     Value: 'group___low_speed_module_functions_gad98d8ed528ab28fe9aec0f7d560b1581.html'
    ),
    (
     Name: 'ReadI2CVendorId';
     Value: 'group___low_speed_module_functions_ga63935492219c15ecc66b2afd72427c10.html'
    ),
    (
     Name: 'ReadI2CDeviceId';
     Value: 'group___low_speed_module_functions_gabaaf2781215874ce54c9a5a7c8350ebf.html'
    ),
    (
     Name: 'ReadI2CRegister';
     Value: 'group___low_speed_module_functions_gaff2a47e64cccdb75b26a99a320fd92dc.html'
    ),
    (
     Name: 'WriteI2CRegister';
     Value: 'group___low_speed_module_functions_gad2b8f87fdd709fa382a16a367010c74b.html'
    ),
    (
     Name: 'I2CSendCommand';
     Value: 'group___low_speed_module_functions_ga6bd255188f2891ecb445411615f98b35.html'
    ),
    (
     Name: 'GetLSInputBuffer';
     Value: 'group___low_level_low_speed_module_functions_ga4830775998ee3a6b8d63d78b9ab3a3fb.html'
    ),
    (
     Name: 'GetLSInputBufferInPtr';
     Value: 'group___low_level_low_speed_module_functions_ga256ac2ec6358246572cfd4d03e6fa2bf.html'
    ),
    (
     Name: 'GetLSInputBufferOutPtr';
     Value: 'group___low_level_low_speed_module_functions_ga9e9af1e7ae76eee2e214de76943abd8b.html'
    ),
    (
     Name: 'GetLSInputBufferBytesToRx';
     Value: 'group___low_level_low_speed_module_functions_ga139f0cc19722f02da2aca8be86766454.html'
    ),
    (
     Name: 'GetLSOutputBuffer';
     Value: 'group___low_level_low_speed_module_functions_ga6db4d27b89185d511f3b613234a39ec9.html'
    ),
    (
     Name: 'GetLSOutputBufferInPtr';
     Value: 'group___low_level_low_speed_module_functions_ga9bce9e68aca24bed12cc7a87e5a353a9.html'
    ),
    (
     Name: 'GetLSOutputBufferOutPtr';
     Value: 'group___low_level_low_speed_module_functions_gad5668b5eb9466becdcd22dea5d80d235.html'
    ),
    (
     Name: 'GetLSOutputBufferBytesToRx';
     Value: 'group___low_level_low_speed_module_functions_gaf2fa9a9f8861acfc8dc1b524bec44243.html'
    ),
    (
     Name: 'GetLSMode';
     Value: 'group___low_level_low_speed_module_functions_ga7104436acc62dcceb8609718c152c753.html'
    ),
    (
     Name: 'GetLSChannelState';
     Value: 'group___low_level_low_speed_module_functions_ga34a66026cb8068c7a1599c6abb53e419.html'
    ),
    (
     Name: 'GetLSErrorType';
     Value: 'group___low_level_low_speed_module_functions_gafc1ece828e1610358fd3cde35836fda8.html'
    ),
    (
     Name: 'GetLSState';
     Value: 'group___low_level_low_speed_module_functions_ga52552b317fcc2f95c1977e602f7753ec.html'
    ),
    (
     Name: 'GetLSSpeed';
     Value: 'group___low_level_low_speed_module_functions_ga8bf81a1d114b526b795e50cadf50db0f.html'
    ),
    (
     Name: 'GetLSNoRestartOnRead';
     Value: 'group___low_level_low_speed_module_functions_ga66766946eb661876d0dfd9336eda203e.html'
    ),
    (
     Name: 'ClearLine';
     Value: 'group___display_module_functions_ga43b0c08f24c7d8fec69c71df28500740.html'
    ),
    (
     Name: 'PointOutEx';
     Value: 'group___display_module_functions_ga4105f608b95d1629c5a8a480054b5cbe.html'
    ),
    (
     Name: 'PointOut';
     Value: 'group___display_module_functions_gac7b71a21a4fcd6ab47e23cf80220e186.html'
    ),
    (
     Name: 'ClearScreen';
     Value: 'group___display_module_functions_ga8b3ae29bcb49e0bc76e9d3285098b55d.html'
    ),
    (
     Name: 'LineOutEx';
     Value: 'group___display_module_functions_ga3632fed2aec18b46656ac765bf3a735f.html'
    ),
    (
     Name: 'LineOut';
     Value: 'group___display_module_functions_ga0490a02fe8bcda669024f24aa2cddd0e.html'
    ),
    (
     Name: 'RectOutEx';
     Value: 'group___display_module_functions_ga5b4abcbb2409103d0595f02b3a209407.html'
    ),
    (
     Name: 'RectOut';
     Value: 'group___display_module_functions_ga755823f6e6d842e7c8ccc2b1e292ca84.html'
    ),
    (
     Name: 'CircleOutEx';
     Value: 'group___display_module_functions_ga378c88b6b2c7e15083510f09b6688ff1.html'
    ),
    (
     Name: 'CircleOut';
     Value: 'group___display_module_functions_ga92835039fc3c64d673627470fa5d7c25.html'
    ),
    (
     Name: 'NumOutEx';
     Value: 'group___display_module_functions_ga31ef9d6db45ded5550fb613cfd01a629.html'
    ),
    (
     Name: 'NumOut';
     Value: 'group___display_module_functions_gaf811ebd5af074e9a79e3d0f316a4bb88.html'
    ),
    (
     Name: 'TextOutEx';
     Value: 'group___display_module_functions_gae754a17a4c452f3495859c812ae57c01.html'
    ),
    (
     Name: 'TextOut';
     Value: 'group___display_module_functions_ga1d572c8e43c229337a1c3791df3445ed.html'
    ),
    (
     Name: 'GraphicOutEx';
     Value: 'group___display_module_functions_gaf8dc8dc97b4dea59c871993351f9175d.html'
    ),
    (
     Name: 'GraphicOut';
     Value: 'group___display_module_functions_ga5aad727fe7f3a1dc0cb7c409435ea7fc.html'
    ),
    (
     Name: 'GraphicArrayOutEx';
     Value: 'group___display_module_functions_gac6079c372adbba70ff890274cc4afeb0.html'
    ),
    (
     Name: 'GraphicArrayOut';
     Value: 'group___display_module_functions_ga89c7021a95183b0b2a381a70a9598238.html'
    ),
    (
     Name: 'EllipseOutEx';
     Value: 'group___display_module_functions_gaa99c2db994d89e926098829e2a2c9335.html'
    ),
    (
     Name: 'EllipseOut';
     Value: 'group___display_module_functions_ga50ad44187b4cedfad46204d765942a80.html'
    ),
    (
     Name: 'PolyOutEx';
     Value: 'group___display_module_functions_ga1db86d861f97d93005eaf80a7670f8d9.html'
    ),
    (
     Name: 'PolyOut';
     Value: 'group___display_module_functions_ga65ce21f11c88f4ec8eb13bbefd3bf070.html'
    ),
    (
     Name: 'FontTextOutEx';
     Value: 'group___display_module_functions_ga8d7e602469fddc99bec0ca650040d771.html'
    ),
    (
     Name: 'FontTextOut';
     Value: 'group___display_module_functions_ga180d3a72cff954d16a4e43dae2e1e07e.html'
    ),
    (
     Name: 'FontNumOutEx';
     Value: 'group___display_module_functions_gae8993fc12bd1e5b8469dad3f511f1c94.html'
    ),
    (
     Name: 'FontNumOut';
     Value: 'group___display_module_functions_ga692a07668ac690e94acb6ebbe4157653.html'
    ),
    (
     Name: 'GetDisplayEraseMask';
     Value: 'group___display_module_functions_gaee5883b8c084893b29295dfc938545d8.html'
    ),
    (
     Name: 'GetDisplayUpdateMask';
     Value: 'group___display_module_functions_gafb9a3d38aea2d95447566c4f7358787b.html'
    ),
    (
     Name: 'GetDisplayFont';
     Value: 'group___display_module_functions_ga5db72f17922babc0718480bf0c40959a.html'
    ),
    (
     Name: 'GetDisplayDisplay';
     Value: 'group___display_module_functions_ga1561ae5edbf8884f5ea55fea61fce78c.html'
    ),
    (
     Name: 'GetDisplayFlags';
     Value: 'group___display_module_functions_gafedb3e89f23669f9b377857e4d9cbc87.html'
    ),
    (
     Name: 'GetDisplayTextLinesCenterFlags';
     Value: 'group___display_module_functions_ga8262e33ad2ce38210158080edfd98a31.html'
    ),
    (
     Name: 'GetDisplayContrast';
     Value: 'group___display_module_functions_ga4a5d9fcccfca6b274dfe38bed6df86c1.html'
    ),
    (
     Name: 'GetDisplayNormal';
     Value: 'group___display_module_functions_ga338f1c89dc4bbdd42016faac03bbd648.html'
    ),
    (
     Name: 'GetDisplayPopup';
     Value: 'group___display_module_functions_ga640d96906410975e0173efa54a547bd4.html'
    ),
    (
     Name: 'SetDisplayFont';
     Value: 'group___display_module_functions_gad1bf23e74edfa66a863bd4a940e83dc0.html'
    ),
    (
     Name: 'SetDisplayDisplay';
     Value: 'group___display_module_functions_ga49ab72a6a558287ca3a43d455b59b192.html'
    ),
    (
     Name: 'SetDisplayEraseMask';
     Value: 'group___display_module_functions_ga2c4ce11e4fbac47dfbe6f5a7ffe76789.html'
    ),
    (
     Name: 'SetDisplayFlags';
     Value: 'group___display_module_functions_ga61a1b6b00467a4de87bd4c8e8db8e730.html'
    ),
    (
     Name: 'SetDisplayTextLinesCenterFlags';
     Value: 'group___display_module_functions_gadf127b587a8c2353939cd32295183f49.html'
    ),
    (
     Name: 'SetDisplayUpdateMask';
     Value: 'group___display_module_functions_ga1f4227f77b828ff72b92427883c7a57b.html'
    ),
    (
     Name: 'SetDisplayContrast';
     Value: 'group___display_module_functions_gaf0187bddc419fea0d89d7c05feb91f4a.html'
    ),
    (
     Name: 'SetDisplayNormal';
     Value: 'group___display_module_functions_ga974bc5c15a3bc373ec25421ccf73d912.html'
    ),
    (
     Name: 'SetDisplayPopup';
     Value: 'group___display_module_functions_gadb4e66e4ffa9da13453c4b6197d3a380.html'
    ),
    (
     Name: 'PlayToneEx';
     Value: 'group___sound_module_functions_ga150de77e432a8af1cc28065c93979609.html'
    ),
    (
     Name: 'PlayTone';
     Value: 'group___sound_module_functions_ga3d11cbfb5c460e2f147e11860b94fda6.html'
    ),
    (
     Name: 'PlayFile';
     Value: 'group___sound_module_functions_ga2a68d3ad0a35ac575be7eeef33f85d14.html'
    ),
    (
     Name: 'PlayFileEx';
     Value: 'group___sound_module_functions_gaa6955e11e950dbdea51cc7a79c6a4bb1.html'
    ),
    (
     Name: 'GetSoundState';
     Value: 'group___sound_module_functions_ga10550ae6e54e6c8d3ab722d84424646b.html'
    ),
    (
     Name: 'SetSoundState';
     Value: 'group___sound_module_functions_gad7c3ea34c05030bbcbe0c750d8ecdaca.html'
    ),
    (
     Name: 'GetSoundFrequency';
     Value: 'group___sound_module_functions_gaff377020c1d8a550d0cfd9689588b1bf.html'
    ),
    (
     Name: 'GetSoundDuration';
     Value: 'group___sound_module_functions_ga3777ecba0b5cf054da733513b0044c6a.html'
    ),
    (
     Name: 'GetSoundSampleRate';
     Value: 'group___sound_module_functions_ga90d10365afa4ac4753b4b364a2f77fce.html'
    ),
    (
     Name: 'GetSoundMode';
     Value: 'group___sound_module_functions_ga9d61d5f573668915d8334b96c59a6750.html'
    ),
    (
     Name: 'GetSoundVolume';
     Value: 'group___sound_module_functions_ga9e579d7a8a48335b57923ac2018ea8df.html'
    ),
    (
     Name: 'SetSoundDuration';
     Value: 'group___sound_module_functions_ga0a179781affb892fd37a6a77487fc7c7.html'
    ),
    (
     Name: 'SetSoundFlags';
     Value: 'group___sound_module_functions_ga2661fe87359b0c15600f04841e65d6ee.html'
    ),
    (
     Name: 'SetSoundFrequency';
     Value: 'group___sound_module_functions_ga36a2b84937781ddec530752dc68b93af.html'
    ),
    (
     Name: 'SetSoundMode';
     Value: 'group___sound_module_functions_ga9212d3a2dab22114f6e728a4cccf229c.html'
    ),
    (
     Name: 'SetSoundModuleState';
     Value: 'group___sound_module_functions_gad8802bed4c30b9277e0a6e8d56ea64d6.html'
    ),
    (
     Name: 'SetSoundSampleRate';
     Value: 'group___sound_module_functions_ga58cfd42ab4fc1b4a307afe17b2ccae5c.html'
    ),
    (
     Name: 'SetSoundVolume';
     Value: 'group___sound_module_functions_gaadd7081bab4a68de50764ed5637679f8.html'
    ),
    (
     Name: 'SetIOMapBytes';
     Value: 'group___command_module_functions_ga42106c310122b1b30689f0befbce50db.html'
    ),
    (
     Name: 'SetIOMapValue';
     Value: 'group___command_module_functions_ga9d66c5023d528ebb96f75ca9deed6671.html'
    ),
    (
     Name: 'SetIOMapBytesByID';
     Value: 'group___command_module_functions_ga7e8fa06dce9529734e5584568b9248d3.html'
    ),
    (
     Name: 'SetIOMapValueByID';
     Value: 'group___command_module_functions_ga96c396c39cab05f6062a7629cf076ba9.html'
    ),
    (
     Name: 'SetCommandModuleValue';
     Value: 'group___command_module_functions_ga98529f4c585b76048eaec1130059fbf2.html'
    ),
    (
     Name: 'SetIOCtrlModuleValue';
     Value: 'group___command_module_functions_gaa3cdaa286f366f54193493564c31b175.html'
    ),
    (
     Name: 'SetLoaderModuleValue';
     Value: 'group___command_module_functions_ga1fc5755ab07714556bb85547195aa96a.html'
    ),
    (
     Name: 'SetUIModuleValue';
     Value: 'group___command_module_functions_gaa6842b924c13d10434fc7b94797874ea.html'
    ),
    (
     Name: 'SetSoundModuleValue';
     Value: 'group___command_module_functions_ga151b70e61d9248023fabfc9fd03edfef.html'
    ),
    (
     Name: 'SetButtonModuleValue';
     Value: 'group___command_module_functions_gaa3e329acd240cb6481913d3ddaac3a88.html'
    ),
    (
     Name: 'SetInputModuleValue';
     Value: 'group___command_module_functions_ga7291f6ca18ef18c746374ccfc0b3d99f.html'
    ),
    (
     Name: 'SetOutputModuleValue';
     Value: 'group___command_module_functions_gaae1d950922c4b62f57ca3dc83dc803ce.html'
    ),
    (
     Name: 'SetLowSpeedModuleValue';
     Value: 'group___command_module_functions_gac987644d25eb95dc60b4fa21a282e174.html'
    ),
    (
     Name: 'SetDisplayModuleValue';
     Value: 'group___command_module_functions_ga6704917f9f9845a1e67528e55ba7b7a4.html'
    ),
    (
     Name: 'SetCommModuleValue';
     Value: 'group___command_module_functions_ga8c0822c7fdb2fa87dc9837e93a885e83.html'
    ),
    (
     Name: 'SetCommandModuleBytes';
     Value: 'group___command_module_functions_gaa4eefc0217b817075507053673a97c71.html'
    ),
    (
     Name: 'SetLowSpeedModuleBytes';
     Value: 'group___command_module_functions_ga31f0e4b50c2f8a715f5dacbca2d401d2.html'
    ),
    (
     Name: 'SetDisplayModuleBytes';
     Value: 'group___command_module_functions_gac1b0517b0295a56acec77a55c3e1f8d1.html'
    ),
    (
     Name: 'SetCommModuleBytes';
     Value: 'group___command_module_functions_gaf32e281e72bd986d8a74da4e00a74bda.html'
    ),
    (
     Name: 'GetIOMapBytes';
     Value: 'group___command_module_functions_gaf0d9da3186d8722f354aaeefcd651ab8.html'
    ),
    (
     Name: 'GetIOMapValue';
     Value: 'group___command_module_functions_ga121466a4aa43eb7a89722ab84e7a7315.html'
    ),
    (
     Name: 'GetIOMapBytesByID';
     Value: 'group___command_module_functions_gae119a250876e0679986fd097f98096a3.html'
    ),
    (
     Name: 'GetIOMapValueByID';
     Value: 'group___command_module_functions_gab42e43d4767750a29ab14e9d5c5678e6.html'
    ),
    (
     Name: 'GetCommandModuleValue';
     Value: 'group___command_module_functions_ga8eca26dc1cbf3d161aefe2cebb2d3e97.html'
    ),
    (
     Name: 'GetLoaderModuleValue';
     Value: 'group___command_module_functions_gabebf406e7d86f3667bb752c07585b3fd.html'
    ),
    (
     Name: 'GetSoundModuleValue';
     Value: 'group___command_module_functions_gabf51a384efb8a6df302fa9df28509364.html'
    ),
    (
     Name: 'GetButtonModuleValue';
     Value: 'group___command_module_functions_ga97664bbdbedb2444ea5b71317d4d0f79.html'
    ),
    (
     Name: 'GetUIModuleValue';
     Value: 'group___command_module_functions_ga50b71f28d99dc07c9ee67cd1179abeea.html'
    ),
    (
     Name: 'GetInputModuleValue';
     Value: 'group___command_module_functions_ga462bae91e9a92462d7dc1a3665245e0a.html'
    ),
    (
     Name: 'GetOutputModuleValue';
     Value: 'group___command_module_functions_ga3f9d966b26f8fc1673911cf3bc7f317c.html'
    ),
    (
     Name: 'GetLowSpeedModuleValue';
     Value: 'group___command_module_functions_gad2e6ee688f5b727722c5652e3ffa22b8.html'
    ),
    (
     Name: 'GetDisplayModuleValue';
     Value: 'group___command_module_functions_gae07e012caae6d28eaaf4322e00fada79.html'
    ),
    (
     Name: 'GetCommModuleValue';
     Value: 'group___command_module_functions_gad6ffebaf8a4abcd3cf94a36e6d64744c.html'
    ),
    (
     Name: 'GetLowSpeedModuleBytes';
     Value: 'group___command_module_functions_ga2e5d06187633a91c391f485b3935fe9c.html'
    ),
    (
     Name: 'GetDisplayModuleBytes';
     Value: 'group___command_module_functions_ga74f05d2b414a22bff9405bce6f41d57a.html'
    ),
    (
     Name: 'GetCommModuleBytes';
     Value: 'group___command_module_functions_ga499d5f86adea45b62ee4a8b93dc1eb1d.html'
    ),
    (
     Name: 'GetCommandModuleBytes';
     Value: 'group___command_module_functions_ga91b406ef3d7124d8c10c6c7cd478aeb8.html'
    ),
    (
     Name: 'ResetSleepTimer';
     Value: 'group___command_module_functions_gac2226337f70bdcc261a91fb5d5f3855e.html'
    ),
    (
     Name: 'GetFirstTick';
     Value: 'group___command_module_functions_ga7712c6ce123812c874c57ee7fd52c9e5.html'
    ),
    (
     Name: 'Wait';
     Value: 'group___command_module_functions_ga162e90c0444b6165fde38f8544652e45.html'
    ),
    (
     Name: 'GetMemoryInfo';
     Value: 'group___command_module_functions_ga353c88e671ec5d25e1843000115c3361.html'
    ),
    (
     Name: 'GetLastResponseInfo';
     Value: 'group___command_module_functions_ga79c93d2601a45ae1965631c86bfbe5ff.html'
    ),
    (
     Name: 'ReadButtonEx';
     Value: 'group___button_module_functions_gace9d36ab22715e80fc10d89b13e6f42a.html'
    ),
    (
     Name: 'GetButtonPressCount';
     Value: 'group___button_module_functions_ga7ce460269818c5c1d0829ef58a268c6b.html'
    ),
    (
     Name: 'GetButtonLongPressCount';
     Value: 'group___button_module_functions_ga2f9c4fc72e2987587d0786b56bc63450.html'
    ),
    (
     Name: 'GetButtonShortReleaseCount';
     Value: 'group___button_module_functions_gadf690a283433e4cc4f33d33773c90e3a.html'
    ),
    (
     Name: 'GetButtonLongReleaseCount';
     Value: 'group___button_module_functions_ga0bc8e2a42f2ff8d3ff7c7ddf4d050b1b.html'
    ),
    (
     Name: 'GetButtonReleaseCount';
     Value: 'group___button_module_functions_ga2430b92c85253d99b464630c34db6fba.html'
    ),
    (
     Name: 'GetButtonState';
     Value: 'group___button_module_functions_gabc2d2fcbd889581424864c455e67cfaf.html'
    ),
    (
     Name: 'SetButtonPressCount';
     Value: 'group___button_module_functions_ga1847c3cd700e4165d717f3ec6ebb2882.html'
    ),
    (
     Name: 'SetButtonLongPressCount';
     Value: 'group___button_module_functions_gaf3507db2ca3264f20f8531e47123febb.html'
    ),
    (
     Name: 'SetButtonShortReleaseCount';
     Value: 'group___button_module_functions_gab9bd2865b1979cdcd44b1d8ac7ed3e2f.html'
    ),
    (
     Name: 'SetButtonLongReleaseCount';
     Value: 'group___button_module_functions_gaa2fef3fce732e74bb7b96cca3dec9fef.html'
    ),
    (
     Name: 'SetButtonReleaseCount';
     Value: 'group___button_module_functions_ga9841cf0cd633f21f1da1f112e8f77781.html'
    ),
    (
     Name: 'SetButtonState';
     Value: 'group___button_module_functions_ga9019afc6ab1749a9bfb5405d1518d6d6.html'
    ),
    (
     Name: 'SetCommandFlags';
     Value: 'group___ui_module_functions_gaa174bea55da5f748026015e44f5247c4.html'
    ),
    (
     Name: 'SetUIState';
     Value: 'group___ui_module_functions_gaa62f97498857088367ac1b4a299a8ac5.html'
    ),
    (
     Name: 'SetUIButton';
     Value: 'group___ui_module_functions_ga33358dc751938fc972c28807b43862fe.html'
    ),
    (
     Name: 'SetVMRunState';
     Value: 'group___ui_module_functions_gab9aa3f711e8eb66cd95b86927784ace1.html'
    ),
    (
     Name: 'SetBatteryState';
     Value: 'group___ui_module_functions_ga8a72f53d62eac0706fbf7db437d5ff0c.html'
    ),
    (
     Name: 'SetBluetoothState';
     Value: 'group___ui_module_functions_ga17b46321a91999d8c4fbd6f2bbbb8b95.html'
    ),
    (
     Name: 'SetUsbState';
     Value: 'group___ui_module_functions_gafb33cd5dc001462407784bc5b7097b50.html'
    ),
    (
     Name: 'SetSleepTimeout';
     Value: 'group___ui_module_functions_gaae20e003c3811b7c5345a1428b5e1e45.html'
    ),
    (
     Name: 'SetSleepTimer';
     Value: 'group___ui_module_functions_ga0c1603d6fe4e72259d28996ca4239c68.html'
    ),
    (
     Name: 'SetVolume';
     Value: 'group___ui_module_functions_gafd53c11ddbda9333185279ef50cbd99e.html'
    ),
    (
     Name: 'SetOnBrickProgramPointer';
     Value: 'group___ui_module_functions_ga4dd0abb4fccf1343c2ce37402113b2f7.html'
    ),
    (
     Name: 'ForceOff';
     Value: 'group___ui_module_functions_ga7d437700b8c37bf3d0a5315d01d95ff2.html'
    ),
    (
     Name: 'SetAbortFlag';
     Value: 'group___ui_module_functions_gaa61f23d76c689b41cc9ae141cd4f6274.html'
    ),
    (
     Name: 'GetBatteryLevel';
     Value: 'group___ui_module_functions_ga5753f8b86d2d2c3819fbdf540ad7799c.html'
    ),
    (
     Name: 'GetCommandFlags';
     Value: 'group___ui_module_functions_ga821489bc7041cca928d2b720789fb96d.html'
    ),
    (
     Name: 'GetUIState';
     Value: 'group___ui_module_functions_gabbcdba2754be13a35e5f2b7376e0d679.html'
    ),
    (
     Name: 'GetUIButton';
     Value: 'group___ui_module_functions_gae794f9ecf548b345fcac73fcae98dab7.html'
    ),
    (
     Name: 'GetVMRunState';
     Value: 'group___ui_module_functions_gaf4d0ce7ed33fc0e8196bb39dc0bd2905.html'
    ),
    (
     Name: 'GetBatteryState';
     Value: 'group___ui_module_functions_gafb3e24524ba3cdc8e69cbc513a51321e.html'
    ),
    (
     Name: 'GetBluetoothState';
     Value: 'group___ui_module_functions_ga2d074724abb05adbcb1fbe2cc3e64219.html'
    ),
    (
     Name: 'GetUsbState';
     Value: 'group___ui_module_functions_gab80a0b44fd650887b1d61e4c98e965d5.html'
    ),
    (
     Name: 'GetSleepTimeout';
     Value: 'group___ui_module_functions_gab05983c248921ac4e0bee42a0b7ec9fb.html'
    ),
    (
     Name: 'GetSleepTimer';
     Value: 'group___ui_module_functions_gac6358751c778fdfbba8518edac640830.html'
    ),
    (
     Name: 'GetRechargeableBattery';
     Value: 'group___ui_module_functions_ga06bd35d6ed43f20d4280c0ffe03e9f11.html'
    ),
    (
     Name: 'GetVolume';
     Value: 'group___ui_module_functions_gafef5048cb627b363a88b89dbf80ee5e6.html'
    ),
    (
     Name: 'GetOnBrickProgramPointer';
     Value: 'group___ui_module_functions_ga2b3081ed19df7351e118a927b683dd97.html'
    ),
    (
     Name: 'GetAbortFlag';
     Value: 'group___ui_module_functions_gad63b1e408b2d32ab346dd0f468f976d1.html'
    ),
    (
     Name: 'SendMessage';
     Value: 'group___comm_module_functions_ga899c0cdecd1dc4bb9245034345f91342.html'
    ),
    (
     Name: 'ReceiveMessage';
     Value: 'group___comm_module_functions_ga04f95dc554a8c75f15bcbcb467860bb1.html'
    ),
    (
     Name: 'ReceiveRemoteBool';
     Value: 'group___comm_module_functions_ga42836b3111d11eeb4503d33103e46b93.html'
    ),
    (
     Name: 'ReceiveRemoteNumber';
     Value: 'group___comm_module_functions_ga74aa9cb3e7dbb87a5782f05f504b9f00.html'
    ),
    (
     Name: 'ReceiveRemoteString';
     Value: 'group___comm_module_functions_ga05822874e79787b2832ffe5d71b826e3.html'
    ),
    (
     Name: 'ReceiveRemoteMessageEx';
     Value: 'group___comm_module_functions_ga1dc6d58d8491b8fa49cc59428bdb480f.html'
    ),
    (
     Name: 'SendResponseString';
     Value: 'group___comm_module_functions_ga01da1dd574b5484fc7714377deaeb883.html'
    ),
    (
     Name: 'SendResponseBool';
     Value: 'group___comm_module_functions_ga44b4118c1b9e309a0165154b913adc78.html'
    ),
    (
     Name: 'SendResponseNumber';
     Value: 'group___comm_module_functions_gaec040ce4495df458e805a665d02f1601.html'
    ),
    (
     Name: 'BluetoothStatus';
     Value: 'group___comm_module_functions_gae8bae6efc6f368beb2df5fcf18328604.html'
    ),
    (
     Name: 'BluetoothWrite';
     Value: 'group___comm_module_functions_gab59c0f07f85c23373dc62abb39cbe573.html'
    ),
    (
     Name: 'RemoteConnectionWrite';
     Value: 'group___comm_module_functions_gaf97be478344415ed5386d95a51d9d962.html'
    ),
    (
     Name: 'RemoteConnectionIdle';
     Value: 'group___comm_module_functions_gaa8875e02f6fe1dafad29849c17e47000.html'
    ),
    (
     Name: 'SendRemoteBool';
     Value: 'group___comm_module_functions_ga3feb9da6508ab1b5ecb203d9ae0d8337.html'
    ),
    (
     Name: 'SendRemoteNumber';
     Value: 'group___comm_module_functions_ga4cd4e3907889f078f26d042231e6509a.html'
    ),
    (
     Name: 'SendRemoteString';
     Value: 'group___comm_module_functions_ga8d18a0c1ef391665cffb644e46611bcc.html'
    ),
    (
     Name: 'RemoteMessageRead';
     Value: 'group___comm_module_d_c_functions_ga6f6858fb2e74ee4b2a1a5ed970870961.html'
    ),
    (
     Name: 'RemoteMessageWrite';
     Value: 'group___comm_module_d_c_functions_ga445d67d21f6011bbdcd061dbf943e8c8.html'
    ),
    (
     Name: 'RemoteStartProgram';
     Value: 'group___comm_module_d_c_functions_gab611aa719e7925801e0d3371a7b51a6f.html'
    ),
    (
     Name: 'RemoteStopProgram';
     Value: 'group___comm_module_d_c_functions_gac9410a75ad9502986e41e03d3ca995ea.html'
    ),
    (
     Name: 'RemotePlaySoundFile';
     Value: 'group___comm_module_d_c_functions_gab78ae911640b2c13402686272083e31d.html'
    ),
    (
     Name: 'RemotePlayTone';
     Value: 'group___comm_module_d_c_functions_ga271d5ca29d0df222e416b577e1c09df3.html'
    ),
    (
     Name: 'RemoteStopSound';
     Value: 'group___comm_module_d_c_functions_gaac8cb6c1fbc803531797de5769406030.html'
    ),
    (
     Name: 'RemoteKeepAlive';
     Value: 'group___comm_module_d_c_functions_gaebf9f386501148adad7bff7cf52063ed.html'
    ),
    (
     Name: 'RemoteResetScaledValue';
     Value: 'group___comm_module_d_c_functions_ga0ff72e27e84798b5c138a6d6b98caec4.html'
    ),
    (
     Name: 'RemoteResetMotorPosition';
     Value: 'group___comm_module_d_c_functions_gafb551c0bf236c264e88a4586c5279f8f.html'
    ),
    (
     Name: 'RemoteSetInputMode';
     Value: 'group___comm_module_d_c_functions_ga8564097ef9bc0442c2e3c710046e72b5.html'
    ),
    (
     Name: 'RemoteSetOutputState';
     Value: 'group___comm_module_d_c_functions_ga631259681dcc1c657bc9f716c6d61aea.html'
    ),
    (
     Name: 'RemoteGetOutputState';
     Value: 'group___comm_module_d_c_functions_gae22dac52803f846589927603f3a7d10b.html'
    ),
    (
     Name: 'RemoteGetInputValues';
     Value: 'group___comm_module_d_c_functions_ga45c146d3ef42889420b8e79de11d9f3d.html'
    ),
    (
     Name: 'RemoteGetBatteryLevel';
     Value: 'group___comm_module_d_c_functions_ga0af7abec6d4fd0704fe736546164660b.html'
    ),
    (
     Name: 'RemoteLowspeedGetStatus';
     Value: 'group___comm_module_d_c_functions_gaf7fb2a0387b358633386cd280b3b82e2.html'
    ),
    (
     Name: 'RemoteLowspeedRead';
     Value: 'group___comm_module_d_c_functions_ga67e4aa2e49f436b3527295bce4c2ce0f.html'
    ),
    (
     Name: 'RemoteGetCurrentProgramName';
     Value: 'group___comm_module_d_c_functions_ga9165a1565db32f122612c613bd50226f.html'
    ),
    (
     Name: 'RemoteDatalogRead';
     Value: 'group___comm_module_d_c_functions_ga16892f08737bf2c147d9750d97c9aa91.html'
    ),
    (
     Name: 'RemoteGetContactCount';
     Value: 'group___comm_module_d_c_functions_ga8bb70f31e15bdf98e071ede30db7c873.html'
    ),
    (
     Name: 'RemoteGetContactName';
     Value: 'group___comm_module_d_c_functions_gaf6b4ed2bc56ba0978c711e69040b77d4.html'
    ),
    (
     Name: 'RemoteGetConnectionCount';
     Value: 'group___comm_module_d_c_functions_ga81dbec85f517a31b083345d7001f4d07.html'
    ),
    (
     Name: 'RemoteGetConnectionName';
     Value: 'group___comm_module_d_c_functions_ga7213722de9d600d8f6a76c00acc66464.html'
    ),
    (
     Name: 'RemoteResetTachoCount';
     Value: 'group___comm_module_d_c_functions_ga889968f499d66abb7bc30ae2af210296.html'
    ),
    (
     Name: 'RemoteGetProperty';
     Value: 'group___comm_module_d_c_functions_gaca60d4c73c3caffcdc3e29a84fb76cbc.html'
    ),
    (
     Name: 'RemoteDatalogSetTimes';
     Value: 'group___comm_module_d_c_functions_ga913d043bfb1200408acc2e276c35b041.html'
    ),
    (
     Name: 'RemoteSetProperty';
     Value: 'group___comm_module_d_c_functions_ga80a278b855f8b79f634368985f02d334.html'
    ),
    (
     Name: 'RemoteLowspeedWrite';
     Value: 'group___comm_module_d_c_functions_ga047f09bf29e1744c715ddc515e8ecb47.html'
    ),
    (
     Name: 'RemoteOpenRead';
     Value: 'group___comm_module_s_c_functions_ga349b6258c460172ae9ae9af15c5b0360.html'
    ),
    (
     Name: 'RemoteOpenAppendData';
     Value: 'group___comm_module_s_c_functions_ga4e51505136d7bc8ba50cd8b236b0ebb6.html'
    ),
    (
     Name: 'RemoteDeleteFile';
     Value: 'group___comm_module_s_c_functions_ga62283d3078dc8d4ae101d6dc7e6b7395.html'
    ),
    (
     Name: 'RemoteFindFirstFile';
     Value: 'group___comm_module_s_c_functions_gacc483523b89f0ef8d6a0f3449cb10a0e.html'
    ),
    (
     Name: 'RemoteGetFirmwareVersion';
     Value: 'group___comm_module_s_c_functions_ga22ef42867cd3abe991b7a3f2cae35d20.html'
    ),
    (
     Name: 'RemoteGetBluetoothAddress';
     Value: 'group___comm_module_s_c_functions_gaa61d87ee43d36258dbbe1a8e14bd2673.html'
    ),
    (
     Name: 'RemoteGetDeviceInfo';
     Value: 'group___comm_module_s_c_functions_ga8839739bef7917d8ad6b55c7bd277b9a.html'
    ),
    (
     Name: 'RemoteDeleteUserFlash';
     Value: 'group___comm_module_s_c_functions_ga9de90677a1d2ab654b819f9f6a1353b0.html'
    ),
    (
     Name: 'RemoteOpenWrite';
     Value: 'group___comm_module_s_c_functions_ga6d3042cbdc510f15359249649c028626.html'
    ),
    (
     Name: 'RemoteOpenWriteLinear';
     Value: 'group___comm_module_s_c_functions_gac123a9c02a7c129acf7acf4b28ec710c.html'
    ),
    (
     Name: 'RemoteOpenWriteData';
     Value: 'group___comm_module_s_c_functions_gae40674f0f47679ddd200dd1f76f2c038.html'
    ),
    (
     Name: 'RemoteCloseFile';
     Value: 'group___comm_module_s_c_functions_gae983d80cbece17e13c94f9afe36b1d41.html'
    ),
    (
     Name: 'RemoteFindNextFile';
     Value: 'group___comm_module_s_c_functions_ga3faa47bfcc2768e568329ed892ae1a9b.html'
    ),
    (
     Name: 'RemotePollCommandLength';
     Value: 'group___comm_module_s_c_functions_ga8a03b6a7f163e4932b3d8f53bdd29972.html'
    ),
    (
     Name: 'RemoteWrite';
     Value: 'group___comm_module_s_c_functions_ga1254d825a5493e65d3cf643278daf4f0.html'
    ),
    (
     Name: 'RemoteRead';
     Value: 'group___comm_module_s_c_functions_ga496229047840139d33a843665051409d.html'
    ),
    (
     Name: 'RemoteIOMapRead';
     Value: 'group___comm_module_s_c_functions_gab03f3560209b0339274980d237cba5fd.html'
    ),
    (
     Name: 'RemotePollCommand';
     Value: 'group___comm_module_s_c_functions_gaca7a687dcbf1bf98a2e3b75cc8a85c27.html'
    ),
    (
     Name: 'RemoteRenameFile';
     Value: 'group___comm_module_s_c_functions_ga97566d63e972f36689d859bcc681e368.html'
    ),
    (
     Name: 'RemoteBluetoothFactoryReset';
     Value: 'group___comm_module_s_c_functions_gabae6a8c92d90bcb759be2611a062d10a.html'
    ),
    (
     Name: 'RemoteIOMapWriteValue';
     Value: 'group___comm_module_s_c_functions_gaff8f9006f40ac9e86388f7b3fbabd4ec.html'
    ),
    (
     Name: 'RemoteIOMapWriteBytes';
     Value: 'group___comm_module_s_c_functions_gab9b7f2e83d15d6ba28dba49a6dbb0689.html'
    ),
    (
     Name: 'RemoteSetBrickName';
     Value: 'group___comm_module_s_c_functions_ga4ae1e83c078bcd902950f0be32d34d43.html'
    ),
    (
     Name: 'UseRS485';
     Value: 'group___comm_module_functions_ga8bea1385ebd3db2a4aaed2b699240f12.html'
    ),
    (
     Name: 'RS485Status';
     Value: 'group___comm_module_functions_gaa33f02829c707436e961302476bef461.html'
    ),
    (
     Name: 'RS485Write';
     Value: 'group___comm_module_functions_gac86cfb81d4cf2745bdfb05ffa11c98c7.html'
    ),
    (
     Name: 'RS485Read';
     Value: 'group___comm_module_functions_gada70f4c7a5dcfd25a5f729fa4bbb0913.html'
    ),
    (
     Name: 'RS485Control';
     Value: 'group___comm_module_functions_gab447f940b7a995ca7a6a7effc94c7e27.html'
    ),
    (
     Name: 'RS485Uart';
     Value: 'group___comm_module_functions_ga13ba6c532dbb256c5c37b182c4d662db.html'
    ),
    (
     Name: 'RS485Initialize';
     Value: 'group___comm_module_functions_gad02c97d76ba00e1956fe8bc05e8e44f2.html'
    ),
    (
     Name: 'RS485Enable';
     Value: 'group___comm_module_functions_gab3fe552d24acd38be39de77b92af9f98.html'
    ),
    (
     Name: 'RS485Disable';
     Value: 'group___comm_module_functions_ga3c34e18a0e3c3795a84e2f2c5881f25d.html'
    ),
    (
     Name: 'SendRS485Bool';
     Value: 'group___comm_module_functions_ga2b8076d2c5313235669483bbc6a574c6.html'
    ),
    (
     Name: 'SendRS485Number';
     Value: 'group___comm_module_functions_ga91a40be02bfa51945d253786922283b0.html'
    ),
    (
     Name: 'SendRS485String';
     Value: 'group___comm_module_functions_ga5f7d01e11d316aec904962dd3cf654ee.html'
    ),
    (
     Name: 'GetBTDeviceName';
     Value: 'group___comm_module_functions_ga3d580fec88df52071d968297a65b5542.html'
    ),
    (
     Name: 'GetBTDeviceClass';
     Value: 'group___comm_module_functions_ga9b0d7c5073119a9732b3995befb5f355.html'
    ),
    (
     Name: 'GetBTDeviceAddress';
     Value: 'group___comm_module_functions_ga9839c870fa6eb689849c8fa36e57d7f8.html'
    ),
    (
     Name: 'GetBTDeviceStatus';
     Value: 'group___comm_module_functions_ga174b54389b929d60351e74a2c5e4e7b6.html'
    ),
    (
     Name: 'GetBTConnectionName';
     Value: 'group___comm_module_functions_ga5bc8f81317cb9d1d7d577728ded3c611.html'
    ),
    (
     Name: 'GetBTConnectionClass';
     Value: 'group___comm_module_functions_gac83531e2d6c61d5ad71d0ec6ae51dd11.html'
    ),
    (
     Name: 'GetBTConnectionPinCode';
     Value: 'group___comm_module_functions_gaeca476b0c13d4e47fa88d7f882fe915a.html'
    ),
    (
     Name: 'GetBTConnectionAddress';
     Value: 'group___comm_module_functions_ga13b325ac860df48893d592e4b7bc2653.html'
    ),
    (
     Name: 'GetBTConnectionHandleNum';
     Value: 'group___comm_module_functions_ga0ffb6a7b1451b0df0c6df63886217b7a.html'
    ),
    (
     Name: 'GetBTConnectionStreamStatus';
     Value: 'group___comm_module_functions_gaa017dd6f2a970037bc2d6a30a16d6bb5.html'
    ),
    (
     Name: 'GetBTConnectionLinkQuality';
     Value: 'group___comm_module_functions_ga8d8c988651adac5dd27dae2277211432.html'
    ),
    (
     Name: 'GetBrickDataName';
     Value: 'group___comm_module_functions_ga4e10adb6b3b0f1c4465b03ea683b0528.html'
    ),
    (
     Name: 'GetBrickDataBluecoreVersion';
     Value: 'group___comm_module_functions_ga57897236339e00c2571069fdb0e7b9b6.html'
    ),
    (
     Name: 'GetBrickDataAddress';
     Value: 'group___comm_module_functions_ga1bdf6039673dbbb99f45b0dd9849df79.html'
    ),
    (
     Name: 'GetBrickDataBtStateStatus';
     Value: 'group___comm_module_functions_ga9e5c8d84010eedba271e8df266cb1c0f.html'
    ),
    (
     Name: 'GetBrickDataBtHardwareStatus';
     Value: 'group___comm_module_functions_gad305b50ee2fef993d945c53968b363ad.html'
    ),
    (
     Name: 'GetBrickDataTimeoutValue';
     Value: 'group___comm_module_functions_ga82da4113e17d7973a194cfeab4313982.html'
    ),
    (
     Name: 'GetBTInputBuffer';
     Value: 'group___comm_module_functions_ga852a3646039b3faa1f2615c91238df1d.html'
    ),
    (
     Name: 'GetBTInputBufferInPtr';
     Value: 'group___comm_module_functions_ga9c75e246513bbd9a573201be1301afa7.html'
    ),
    (
     Name: 'GetBTInputBufferOutPtr';
     Value: 'group___comm_module_functions_ga692cb3de823f23cc2dbc5403e0d26286.html'
    ),
    (
     Name: 'GetBTOutputBuffer';
     Value: 'group___comm_module_functions_ga177ab054cb3df796d498d72fb3819372.html'
    ),
    (
     Name: 'GetBTOutputBufferInPtr';
     Value: 'group___comm_module_functions_ga18d07b0cfbc3b85119bdda50ad40a6c6.html'
    ),
    (
     Name: 'GetBTOutputBufferOutPtr';
     Value: 'group___comm_module_functions_ga8041aade6463ded769be6a9c495029c1.html'
    ),
    (
     Name: 'GetHSInputBuffer';
     Value: 'group___comm_module_functions_ga06ded0a08bff002ed3b03a23cf37e221.html'
    ),
    (
     Name: 'GetHSInputBufferInPtr';
     Value: 'group___comm_module_functions_gad64ef1911c1e5033cb5b3b63901b7eea.html'
    ),
    (
     Name: 'GetHSInputBufferOutPtr';
     Value: 'group___comm_module_functions_ga22704b16a08ff957eab2c2c32f0b7706.html'
    ),
    (
     Name: 'GetHSOutputBuffer';
     Value: 'group___comm_module_functions_ga69b5e309e55cdf02e8290905c469f827.html'
    ),
    (
     Name: 'GetHSOutputBufferInPtr';
     Value: 'group___comm_module_functions_ga73260be9ba39a34d4c526ed4359bf55f.html'
    ),
    (
     Name: 'GetHSOutputBufferOutPtr';
     Value: 'group___comm_module_functions_ga5caf2e49b4ff656829cf8694cc6d934a.html'
    ),
    (
     Name: 'GetUSBInputBuffer';
     Value: 'group___comm_module_functions_ga9f2037164a82742d191ed3266ec47a53.html'
    ),
    (
     Name: 'GetUSBInputBufferInPtr';
     Value: 'group___comm_module_functions_gafc7d538857efb565e56811830a43a7dc.html'
    ),
    (
     Name: 'GetUSBInputBufferOutPtr';
     Value: 'group___comm_module_functions_ga008ba6f1d48987d5078dffeba4802348.html'
    ),
    (
     Name: 'GetUSBOutputBuffer';
     Value: 'group___comm_module_functions_gaf989daece5153add1ce8aeeedb06c901.html'
    ),
    (
     Name: 'GetUSBOutputBufferInPtr';
     Value: 'group___comm_module_functions_gab553f5d6edcedd411dfcbfa68ad4c8c4.html'
    ),
    (
     Name: 'GetUSBOutputBufferOutPtr';
     Value: 'group___comm_module_functions_gac123f17ef86c7e81c20a50b72d0a94f3.html'
    ),
    (
     Name: 'GetUSBPollBuffer';
     Value: 'group___comm_module_functions_ga9e952b39d142c0d6244e5edf683186db.html'
    ),
    (
     Name: 'GetUSBPollBufferInPtr';
     Value: 'group___comm_module_functions_ga8095c6131896d46ca1faabc8a2bcf3b9.html'
    ),
    (
     Name: 'GetUSBPollBufferOutPtr';
     Value: 'group___comm_module_functions_gaeaf0e6f66c25fa13e905ad5101ae298c.html'
    ),
    (
     Name: 'GetBTDeviceCount';
     Value: 'group___comm_module_functions_ga7d7094a468cc059e7deafb12c1b0d1fd.html'
    ),
    (
     Name: 'GetBTDeviceNameCount';
     Value: 'group___comm_module_functions_gae87738fd11cb8c90e8dd1e0dd9c4733f.html'
    ),
    (
     Name: 'GetHSFlags';
     Value: 'group___comm_module_functions_ga84b838b1bbad99732e3cd1f78b527a3c.html'
    ),
    (
     Name: 'GetHSSpeed';
     Value: 'group___comm_module_functions_ga255bfd9e2c873a4be7264a1745a5d85b.html'
    ),
    (
     Name: 'GetHSState';
     Value: 'group___comm_module_functions_gac21fd538b372fa937f9f8ce96f0778b1.html'
    ),
    (
     Name: 'GetUSBState';
     Value: 'group___comm_module_functions_ga0bff70ae26ac25aeb1c60c929d5e88cd.html'
    ),
    (
     Name: 'GetHSMode';
     Value: 'group___comm_module_functions_gafcd1fc078f3c8e0a2a3ac507d33edc2d.html'
    ),
    (
     Name: 'GetBTDataMode';
     Value: 'group___comm_module_functions_gaf54caf6c0dcaf39be307410aeefb8f42.html'
    ),
    (
     Name: 'GetHSDataMode';
     Value: 'group___comm_module_functions_ga042075fc4444e8d8b1cc7be0aabf766f.html'
    ),
    (
     Name: 'SetBTInputBuffer';
     Value: 'group___comm_module_functions_ga6d0f5525c091f0aa8210c80300479f12.html'
    ),
    (
     Name: 'SetBTInputBufferInPtr';
     Value: 'group___comm_module_functions_ga04a9e3e00862870cf0cd0f6884201bf7.html'
    ),
    (
     Name: 'SetBTInputBufferOutPtr';
     Value: 'group___comm_module_functions_gab26440069651cb40b658fe78299625fc.html'
    ),
    (
     Name: 'SetBTOutputBuffer';
     Value: 'group___comm_module_functions_ga6c7d76629a74adc37fe571e4f9394313.html'
    ),
    (
     Name: 'SetBTOutputBufferInPtr';
     Value: 'group___comm_module_functions_gae3eaf021be41bbc8bd7d8fabb7cd81f3.html'
    ),
    (
     Name: 'SetBTOutputBufferOutPtr';
     Value: 'group___comm_module_functions_gaec7cc966e771059d573fc606eaf97cdc.html'
    ),
    (
     Name: 'SetHSInputBuffer';
     Value: 'group___comm_module_functions_ga71aae05b110395b4896d23b347676624.html'
    ),
    (
     Name: 'SetHSInputBufferInPtr';
     Value: 'group___comm_module_functions_ga43a72f143b72d9a68a77ea55f63819fa.html'
    ),
    (
     Name: 'SetHSInputBufferOutPtr';
     Value: 'group___comm_module_functions_ga33af058e9bfbabf4e4dc0ce54784e2a3.html'
    ),
    (
     Name: 'SetHSOutputBuffer';
     Value: 'group___comm_module_functions_ga825519d32442ba90ae63f68bc6b6c462.html'
    ),
    (
     Name: 'SetHSOutputBufferInPtr';
     Value: 'group___comm_module_functions_gafd199e469e05980d61c313d3a311f65e.html'
    ),
    (
     Name: 'SetHSOutputBufferOutPtr';
     Value: 'group___comm_module_functions_ga073ccc393497f5a881b035a425d84f4d.html'
    ),
    (
     Name: 'SetUSBInputBuffer';
     Value: 'group___comm_module_functions_ga1deefc574eb0b96dc2a9776e606ddcd6.html'
    ),
    (
     Name: 'SetUSBInputBufferInPtr';
     Value: 'group___comm_module_functions_ga3f82715291d0a1fda3e826409abf9d86.html'
    ),
    (
     Name: 'SetUSBInputBufferOutPtr';
     Value: 'group___comm_module_functions_gadbc56271f87d8f3802e912a724f778bf.html'
    ),
    (
     Name: 'SetUSBOutputBuffer';
     Value: 'group___comm_module_functions_ga0e34d99b9b039109016149d79107d2d5.html'
    ),
    (
     Name: 'SetUSBOutputBufferInPtr';
     Value: 'group___comm_module_functions_gaeeaf3476e6cdf24ecd3a9e07419ed38a.html'
    ),
    (
     Name: 'SetUSBOutputBufferOutPtr';
     Value: 'group___comm_module_functions_ga086861563a9067b6593cd102843b6151.html'
    ),
    (
     Name: 'SetUSBPollBuffer';
     Value: 'group___comm_module_functions_gac7713ed1d2b56a7497ef166bb65b1539.html'
    ),
    (
     Name: 'SetUSBPollBufferInPtr';
     Value: 'group___comm_module_functions_gac0ca0c319f7635cbcd40beae72ef5b13.html'
    ),
    (
     Name: 'SetUSBPollBufferOutPtr';
     Value: 'group___comm_module_functions_ga61581437e98915c0aac70842a453a1ac.html'
    ),
    (
     Name: 'SetHSFlags';
     Value: 'group___comm_module_functions_ga1f835c443b053a6a6199c88339f5f945.html'
    ),
    (
     Name: 'SetHSSpeed';
     Value: 'group___comm_module_functions_ga2b0ac2e57cedb29fde3d31267ada23ef.html'
    ),
    (
     Name: 'SetHSState';
     Value: 'group___comm_module_functions_ga56ee127c5d212b28a2ac50028452e2fb.html'
    ),
    (
     Name: 'SetUSBState';
     Value: 'group___comm_module_functions_ga00573da02aae4d8eaf579e6c34d6655c.html'
    ),
    (
     Name: 'SetHSMode';
     Value: 'group___comm_module_functions_ga49c2796905fdda56cfc8bd5f4152731e.html'
    ),
    (
     Name: 'SetBTDataMode';
     Value: 'group___comm_module_functions_ga935f57b6d05f007f46b3d2c92c481128.html'
    ),
    (
     Name: 'SetHSDataMode';
     Value: 'group___comm_module_functions_gaa111595ee6de472ee80262e7f5d3ac22.html'
    ),
    (
     Name: 'PowerDown';
     Value: 'group___i_o_ctrl_module_functions_ga9a995a7c43e95daf9d4af93e2f1ab776.html'
    ),
    (
     Name: 'RebootInFirmwareMode';
     Value: 'group___i_o_ctrl_module_functions_ga1c92f1f2a0e5a1003b8fdb8f9f545397.html'
    ),
    (
     Name: 'GetFreeMemory';
     Value: 'group___loader_module_functions_ga71c632ccc74897c8e13e257d5156ad18.html'
    ),
    (
     Name: 'CreateFile';
     Value: 'group___loader_module_functions_ga354859a67db7f47d16b469077d8587a7.html'
    ),
    (
     Name: 'OpenFileAppend';
     Value: 'group___loader_module_functions_ga2059ef205718fd6215990814e84f874a.html'
    ),
    (
     Name: 'OpenFileRead';
     Value: 'group___loader_module_functions_ga6d3e5fe9c9b4935b2aa4fa804288c6c9.html'
    ),
    (
     Name: 'CloseFile';
     Value: 'group___loader_module_functions_gad54259b2ead98298aa9bc2e222057315.html'
    ),
    (
     Name: 'ResolveHandle';
     Value: 'group___loader_module_functions_ga838beef575a120d7589f8ab7b0bf8f6e.html'
    ),
    (
     Name: 'RenameFile';
     Value: 'group___loader_module_functions_gabb3670632b1d20c2ad996b7e1e26ff91.html'
    ),
    (
     Name: 'DeleteFile';
     Value: 'group___loader_module_functions_ga3fc7d51c004cec69d5ec6c86b31b99b8.html'
    ),
    (
     Name: 'ResizeFile';
     Value: 'group___loader_module_functions_ga8d3a48a08d9e9b699f12fac379939f9e.html'
    ),
    (
     Name: 'CreateFileLinear';
     Value: 'group___loader_module_functions_gaf3852d20f86e393dc15a6b9ca8d21af1.html'
    ),
    (
     Name: 'CreateFileNonLinear';
     Value: 'group___loader_module_functions_gaccabb452623b59c143c3e1533505759f.html'
    ),
    (
     Name: 'OpenFileReadLinear';
     Value: 'group___loader_module_functions_gacde17e3ee051e0d90ff99f53b9201372.html'
    ),
    (
     Name: 'FindFirstFile';
     Value: 'group___loader_module_functions_ga62dcbebe9fae417d4b8fcc000b76bf69.html'
    ),
    (
     Name: 'FindNextFile';
     Value: 'group___loader_module_functions_gaaae160166b4bf9d3bbf5e092bc29b645.html'
    ),
    (
     Name: 'SizeOf';
     Value: 'group___loader_module_functions_gae02eb7c427a635cfc955317e3dd21f84.html'
    ),
    (
     Name: 'Read';
     Value: 'group___loader_module_functions_ga400d0bc74f9e3f26bc04aa664151cd01.html'
    ),
    (
     Name: 'ReadLn';
     Value: 'group___loader_module_functions_gad8ce92af454e317b8aed679f521aa5a6.html'
    ),
    (
     Name: 'ReadBytes';
     Value: 'group___loader_module_functions_gad64024b161657a49b9090b2df1135c84.html'
    ),
    (
     Name: 'ReadLnString';
     Value: 'group___loader_module_functions_gabd65a20b86b578d689474e8421ad2332.html'
    ),
    (
     Name: 'Write';
     Value: 'group___loader_module_functions_gaaaeeadb59ea9ce1eec6bb7d805ec5a3a.html'
    ),
    (
     Name: 'WriteLn';
     Value: 'group___loader_module_functions_ga6806e4469bab263e7541a417f52ea64f.html'
    ),
    (
     Name: 'WriteString';
     Value: 'group___loader_module_functions_ga331670fd903083ab7806c92c22ac6b96.html'
    ),
    (
     Name: 'WriteLnString';
     Value: 'group___loader_module_functions_ga711fcead3bb1ae86ac414d74fe5035f5.html'
    ),
    (
     Name: 'WriteBytes';
     Value: 'group___loader_module_functions_ga8e17998942e491f8c60271b0121bc2d2.html'
    ),
    (
     Name: 'WriteBytesEx';
     Value: 'group___loader_module_functions_gabe4935b654a5af8bdda8901f8468088f.html'
    ),
    (
     Name: 'Random';
     Value: 'group__cstdlib_a_p_i_gae68df3a6c1372e78b2770e931ac65904.html'
    ),
    (
     Name: 'SignedRandom';
     Value: 'group__cstdlib_a_p_i_gae2fa0806e2891cc712a87e73482c1578.html'
    ),
    (
     Name: 'bcd2dec';
     Value: 'group__cmath_a_p_i_ga894db31a31382679b8fe4abd37aeea46.html'
    ),
    (
     Name: 'SetSensorHTGyro';
     Value: 'group___hi_technic_a_p_i_gaea22a05730283dada2c8d61b9d4d1139.html'
    ),
    (
     Name: 'ReadSensorHTGyro';
     Value: 'group___hi_technic_a_p_i_ga68bd42b99ccdd09b6bdc763a584f152e.html'
    ),
    (
     Name: 'SetSensorHTMagnet';
     Value: 'group___hi_technic_a_p_i_gaf02385dd35bc21b14eed9f6ecc3cc6f0.html'
    ),
    (
     Name: 'ReadSensorHTMagnet';
     Value: 'group___hi_technic_a_p_i_ga6d3b9dc81583aa8e3c62b7b8143bcc5b.html'
    ),
    (
     Name: 'SetSensorHTEOPD';
     Value: 'group___hi_technic_a_p_i_ga38ca116f86e924955d599e6c095cde61.html'
    ),
    (
     Name: 'ReadSensorHTEOPD';
     Value: 'group___hi_technic_a_p_i_ga2774835ed1a4bf860e2e404621f54526.html'
    ),
    (
     Name: 'ReadSensorHTTouchMultiplexer';
     Value: 'group___hi_technic_a_p_i_ga1048d30de64a8ec04b7279877d9fd916.html'
    ),
    (
     Name: 'HTPowerFunctionCommand';
     Value: 'group___hi_technic_a_p_i_ga2950af612562b0d28a73d3a39348ff5f.html'
    ),
    (
     Name: 'HTIRTrain';
     Value: 'group___hi_technic_a_p_i_ga3e0d441979ff04b8095aaa7d512fe81d.html'
    ),
    (
     Name: 'HTPFComboDirect';
     Value: 'group___hi_technic_a_p_i_ga88987fb0e6ac7725a440b4e346b45b53.html'
    ),
    (
     Name: 'HTPFComboPWM';
     Value: 'group___hi_technic_a_p_i_ga419d0c4d6072e512b2cac9125f6ff172.html'
    ),
    (
     Name: 'HTPFRawOutput';
     Value: 'group___hi_technic_a_p_i_ga6047bef2845b83558dc7a62dab9e5ea5.html'
    ),
    (
     Name: 'HTPFRepeat';
     Value: 'group___hi_technic_a_p_i_ga115b43d6f2ba2b04a78cf58b0a3011dc.html'
    ),
    (
     Name: 'HTPFSingleOutputCST';
     Value: 'group___hi_technic_a_p_i_ga303ca02d90ddf6bba9c7460e7682d175.html'
    ),
    (
     Name: 'HTPFSingleOutputPWM';
     Value: 'group___hi_technic_a_p_i_ga05a4c46c61195c47abf348a69802f849.html'
    ),
    (
     Name: 'HTPFSinglePin';
     Value: 'group___hi_technic_a_p_i_gadc06a34c1933a25480130a3dfe5c98d7.html'
    ),
    (
     Name: 'HTPFTrain';
     Value: 'group___hi_technic_a_p_i_ga65609fd9a64f2b73f792a4386df6dea2.html'
    ),
    (
     Name: 'HTRCXSetIRLinkPort';
     Value: 'group___hi_technic_a_p_i_ga00061a0e97cb8f68bd3a12d166c2cd8a.html'
    ),
    (
     Name: 'HTRCXBatteryLevel';
     Value: 'group___hi_technic_a_p_i_gac0f16194c7f2888a6eaff6f2b6c4c7cc.html'
    ),
    (
     Name: 'HTRCXPoll';
     Value: 'group___hi_technic_a_p_i_gadbaecfde0a6d2726d9e3b3ea506d42ec.html'
    ),
    (
     Name: 'HTRCXPollMemory';
     Value: 'group___hi_technic_a_p_i_gaa238406d24445572c014f3a212a436d3.html'
    ),
    (
     Name: 'HTRCXAddToDatalog';
     Value: 'group___hi_technic_a_p_i_gaf899a7f4ea98c1c5f624183377c72ffa.html'
    ),
    (
     Name: 'HTRCXClearAllEvents';
     Value: 'group___hi_technic_a_p_i_ga307ef5d8e5baf47e5742c078dbfc48cf.html'
    ),
    (
     Name: 'HTRCXClearCounter';
     Value: 'group___hi_technic_a_p_i_ga0605d32a268160d8745f2d51f83e953e.html'
    ),
    (
     Name: 'HTRCXClearMsg';
     Value: 'group___hi_technic_a_p_i_ga4e47420163ecd3dfa958135b4b16d20e.html'
    ),
    (
     Name: 'HTRCXClearSensor';
     Value: 'group___hi_technic_a_p_i_ga85862596581ade99a28795e86858c290.html'
    ),
    (
     Name: 'HTRCXClearSound';
     Value: 'group___hi_technic_a_p_i_gaac4343ed52002b8d1bdee4ecce4e3ecd.html'
    ),
    (
     Name: 'HTRCXClearTimer';
     Value: 'group___hi_technic_a_p_i_ga223d9c66cc2b56b674ca8a10130eaeff.html'
    ),
    (
     Name: 'HTRCXCreateDatalog';
     Value: 'group___hi_technic_a_p_i_ga003c89c194b91a1cccc82f41be5c6076.html'
    ),
    (
     Name: 'HTRCXDecCounter';
     Value: 'group___hi_technic_a_p_i_ga6867a3b02fecaa3b6501f733243fdc8f.html'
    ),
    (
     Name: 'HTRCXDeleteSub';
     Value: 'group___hi_technic_a_p_i_ga586ba62b074718af586f3d28a3c0d356.html'
    ),
    (
     Name: 'HTRCXDeleteSubs';
     Value: 'group___hi_technic_a_p_i_ga914951b3fa056ce386cb1a16a274753b.html'
    ),
    (
     Name: 'HTRCXDeleteTask';
     Value: 'group___hi_technic_a_p_i_ga2db4e6249760a556064bb7ba92622874.html'
    ),
    (
     Name: 'HTRCXDeleteTasks';
     Value: 'group___hi_technic_a_p_i_gaa4eb132cb32240fd076dab946ecb64c4.html'
    ),
    (
     Name: 'HTRCXDisableOutput';
     Value: 'group___hi_technic_a_p_i_gaafe95b42121e7cbfaef80a2816480f62.html'
    ),
    (
     Name: 'HTRCXEnableOutput';
     Value: 'group___hi_technic_a_p_i_gae33520ea111cbfe0ebd21eee26f98e1a.html'
    ),
    (
     Name: 'HTRCXEvent';
     Value: 'group___hi_technic_a_p_i_gaf9087cc230543b650c67ee38ba9e88da.html'
    ),
    (
     Name: 'HTRCXFloat';
     Value: 'group___hi_technic_a_p_i_ga951fec91bcab3d6442c01b87cf4fb1b1.html'
    ),
    (
     Name: 'HTRCXFwd';
     Value: 'group___hi_technic_a_p_i_ga7d011b2591056ba3c052a18bd9713361.html'
    ),
    (
     Name: 'HTRCXIncCounter';
     Value: 'group___hi_technic_a_p_i_ga52fd7f5e30825be08a943714912fbcac.html'
    ),
    (
     Name: 'HTRCXInvertOutput';
     Value: 'group___hi_technic_a_p_i_gaa454bea900bf2a94d0d86a8d4ce3fbba.html'
    ),
    (
     Name: 'HTRCXMuteSound';
     Value: 'group___hi_technic_a_p_i_ga81724a9c60be78f06e42faa778dd2cf7.html'
    ),
    (
     Name: 'HTRCXObvertOutput';
     Value: 'group___hi_technic_a_p_i_ga4c52ef3e3562984b44007a138c59412e.html'
    ),
    (
     Name: 'HTRCXOff';
     Value: 'group___hi_technic_a_p_i_gacd870430259d51658519f687f879bf67.html'
    ),
    (
     Name: 'HTRCXOn';
     Value: 'group___hi_technic_a_p_i_gace76c2a223f7d819d09a10f5d20dda53.html'
    ),
    (
     Name: 'HTRCXOnFor';
     Value: 'group___hi_technic_a_p_i_gaea7398b08eab73c8a921d0e1731229e9.html'
    ),
    (
     Name: 'HTRCXOnFwd';
     Value: 'group___hi_technic_a_p_i_gad2ad3b84861678ee7b26353fe5424f93.html'
    ),
    (
     Name: 'HTRCXOnRev';
     Value: 'group___hi_technic_a_p_i_gaf1aa22797636ee2f3c2ec6d54690b567.html'
    ),
    (
     Name: 'HTRCXPBTurnOff';
     Value: 'group___hi_technic_a_p_i_ga0534e925f45031d04db05139db023fc7.html'
    ),
    (
     Name: 'HTRCXPing';
     Value: 'group___hi_technic_a_p_i_ga7f511b0c9e062ae624e0f2d9e3130bad.html'
    ),
    (
     Name: 'HTRCXPlaySound';
     Value: 'group___hi_technic_a_p_i_ga958f4374c976326dc8b54ecaa4fe6164.html'
    ),
    (
     Name: 'HTRCXPlayTone';
     Value: 'group___hi_technic_a_p_i_ga68d1ae8148c69a139d786b00af8f9fc6.html'
    ),
    (
     Name: 'HTRCXPlayToneVar';
     Value: 'group___hi_technic_a_p_i_gae39fbd93fe257c485860edda1ebdca82.html'
    ),
    (
     Name: 'HTRCXRemote';
     Value: 'group___hi_technic_a_p_i_gad8392105a7c0cd084e14c7cfc99b156b.html'
    ),
    (
     Name: 'HTRCXRev';
     Value: 'group___hi_technic_a_p_i_ga2103ff84fca64400e0cfd9a8d01559e8.html'
    ),
    (
     Name: 'HTRCXSelectDisplay';
     Value: 'group___hi_technic_a_p_i_ga340d76e97d41fb187070f7e1d3c05907.html'
    ),
    (
     Name: 'HTRCXSelectProgram';
     Value: 'group___hi_technic_a_p_i_ga0c28ff798126820c3f7e5f74407d28e9.html'
    ),
    (
     Name: 'HTRCXSendSerial';
     Value: 'group___hi_technic_a_p_i_gad1a59b4d745b1776d0857aad320f23e3.html'
    ),
    (
     Name: 'HTRCXSetDirection';
     Value: 'group___hi_technic_a_p_i_gaa7b1c3ce3ac56add46ccaf12a87f7753.html'
    ),
    (
     Name: 'HTRCXSetEvent';
     Value: 'group___hi_technic_a_p_i_ga856065307e73776120c4c238a90a40a6.html'
    ),
    (
     Name: 'HTRCXSetGlobalDirection';
     Value: 'group___hi_technic_a_p_i_gab2e29e00839e4287074d6579fb7fd3b1.html'
    ),
    (
     Name: 'HTRCXSetGlobalOutput';
     Value: 'group___hi_technic_a_p_i_ga7b89ee94968c64c1ae6cca65586b99de.html'
    ),
    (
     Name: 'HTRCXSetMaxPower';
     Value: 'group___hi_technic_a_p_i_ga580b02795e7f094bfd5eaadd1188fae1.html'
    ),
    (
     Name: 'HTRCXSetMessage';
     Value: 'group___hi_technic_a_p_i_gae8c0765ac666ab6b0096c2b685f61df8.html'
    ),
    (
     Name: 'HTRCXSetOutput';
     Value: 'group___hi_technic_a_p_i_gab9bf874bccd64e3eae530f487c925dbd.html'
    ),
    (
     Name: 'HTRCXSetPower';
     Value: 'group___hi_technic_a_p_i_ga380f8f29511facd7879a9b5b83effa30.html'
    ),
    (
     Name: 'HTRCXSetPriority';
     Value: 'group___hi_technic_a_p_i_ga07922da9680074d6d9b74d218d4ff374.html'
    ),
    (
     Name: 'HTRCXSetSensorMode';
     Value: 'group___hi_technic_a_p_i_ga803a6a7c82f1160044443271a4ff674b.html'
    ),
    (
     Name: 'HTRCXSetSensorType';
     Value: 'group___hi_technic_a_p_i_ga9a692027002099696279cf3570d8b36a.html'
    ),
    (
     Name: 'HTRCXSetSleepTime';
     Value: 'group___hi_technic_a_p_i_gadc982cb27f8065d0fa14d58829232ee4.html'
    ),
    (
     Name: 'HTRCXSetTxPower';
     Value: 'group___hi_technic_a_p_i_ga1a8bebe41326725c2f7b56ba06979ee9.html'
    ),
    (
     Name: 'HTRCXSetWatch';
     Value: 'group___hi_technic_a_p_i_ga1ffc33a1456294f9a0ac02bd69fd0dac.html'
    ),
    (
     Name: 'HTRCXStartTask';
     Value: 'group___hi_technic_a_p_i_ga5b6be0582e81f894e6b03310d45204ad.html'
    ),
    (
     Name: 'HTRCXStopAllTasks';
     Value: 'group___hi_technic_a_p_i_gacf54787318acfc68ef4090c4e988dab0.html'
    ),
    (
     Name: 'HTRCXStopTask';
     Value: 'group___hi_technic_a_p_i_ga95fb0d2791932b808ee5e40e059fef6f.html'
    ),
    (
     Name: 'HTRCXToggle';
     Value: 'group___hi_technic_a_p_i_ga04c238cda2075d1749d08e8b0be83353.html'
    ),
    (
     Name: 'HTRCXUnmuteSound';
     Value: 'group___hi_technic_a_p_i_ga5f24e4e179f314044b017081b8c8281b.html'
    ),
    (
     Name: 'HTScoutCalibrateSensor';
     Value: 'group___hi_technic_a_p_i_gae5e2c958897b5efa27d42c514e3793bc.html'
    ),
    (
     Name: 'HTScoutMuteSound';
     Value: 'group___hi_technic_a_p_i_ga6e0dc01a6b1e8e32980b7c0e9a91189b.html'
    ),
    (
     Name: 'HTScoutSelectSounds';
     Value: 'group___hi_technic_a_p_i_gacac0cefcbf67ff0314a8f6181b069244.html'
    ),
    (
     Name: 'HTScoutSendVLL';
     Value: 'group___hi_technic_a_p_i_gaebc89c43e1181105a7afa7643ed4cc04.html'
    ),
    (
     Name: 'HTScoutSetEventFeedback';
     Value: 'group___hi_technic_a_p_i_ga04150569b62bd4b200d94482c86d9b6d.html'
    ),
    (
     Name: 'HTScoutSetLight';
     Value: 'group___hi_technic_a_p_i_ga485cd843f61be81694d362d403bdba41.html'
    ),
    (
     Name: 'HTScoutSetScoutMode';
     Value: 'group___hi_technic_a_p_i_ga4bd96e358474212192d8e7c779ba6cfe.html'
    ),
    (
     Name: 'HTScoutSetSensorClickTime';
     Value: 'group___hi_technic_a_p_i_gaa0220f97303dbd965e22c73c09758fb7.html'
    ),
    (
     Name: 'HTScoutSetSensorHysteresis';
     Value: 'group___hi_technic_a_p_i_ga3c341cab37aa1e3d13d7d079d4292bf7.html'
    ),
    (
     Name: 'HTScoutSetSensorLowerLimit';
     Value: 'group___hi_technic_a_p_i_ga40bc66abb8458d4294c389a03ba9fde7.html'
    ),
    (
     Name: 'HTScoutSetSensorUpperLimit';
     Value: 'group___hi_technic_a_p_i_ga3cc4a59580881cdc3921fb629fa70859.html'
    ),
    (
     Name: 'HTScoutUnmuteSound';
     Value: 'group___hi_technic_a_p_i_ga6edb641adebeef46d40681a9563d6d8a.html'
    ),
    (
     Name: 'ReadSensorHTCompass';
     Value: 'group___hi_technic_a_p_i_ga7ad383ae8a831d671ab53476656f46c3.html'
    ),
    (
     Name: 'ReadSensorHTColorNum';
     Value: 'group___hi_technic_a_p_i_ga4dd68f1840842874e307429299b0e891.html'
    ),
    (
     Name: 'ReadSensorHTIRSeekerDir';
     Value: 'group___hi_technic_a_p_i_ga488b38bc26feba59fdaaa49018140628.html'
    ),
    (
     Name: 'ReadSensorHTIRSeeker2Addr';
     Value: 'group___hi_technic_a_p_i_ga250a5aee462589f67196303d0b5849f3.html'
    ),
    (
     Name: 'ReadSensorHTAccel';
     Value: 'group___hi_technic_a_p_i_ga14d5a8c6eb95333692075c4925481366.html'
    ),
    (
     Name: 'ReadSensorHTColor';
     Value: 'group___hi_technic_a_p_i_ga4283e30a6ee682e185cf0c157356c466.html'
    ),
    (
     Name: 'ReadSensorHTRawColor';
     Value: 'group___hi_technic_a_p_i_ga8d453756179b03ff8142f246b4899ee0.html'
    ),
    (
     Name: 'ReadSensorHTNormalizedColor';
     Value: 'group___hi_technic_a_p_i_ga768c27797d169f6776aa7e5710a9b159.html'
    ),
    (
     Name: 'ReadSensorHTIRSeeker';
     Value: 'group___hi_technic_a_p_i_gae9ca63f4a82c98a0e0a31f2e2bf82e24.html'
    ),
    (
     Name: 'ReadSensorHTIRSeeker2DC';
     Value: 'group___hi_technic_a_p_i_ga932bec62d3e616499a14c96748a0bc1c.html'
    ),
    (
     Name: 'ReadSensorHTIRSeeker2AC';
     Value: 'group___hi_technic_a_p_i_ga162bcfe391d073288d7c99ab9a43301c.html'
    ),
    (
     Name: 'SetHTIRSeeker2Mode';
     Value: 'group___hi_technic_a_p_i_gaf28ba2531d320d2dc6b18c76af3789c1.html'
    ),
    (
     Name: 'SetHTColor2Mode';
     Value: 'group___hi_technic_a_p_i_ga6cc16497c0630436c1751cccc0686c68.html'
    ),
    (
     Name: 'ReadSensorHTColor2Active';
     Value: 'group___hi_technic_a_p_i_ga2a310788bd3be1cc66d08006ccb07983.html'
    ),
    (
     Name: 'ReadSensorHTNormalizedColor2Active';
     Value: 'group___hi_technic_a_p_i_ga1c9be9733dbb887aa617a48cb8e2b1a0.html'
    ),
    (
     Name: 'ReadSensorHTRawColor2';
     Value: 'group___hi_technic_a_p_i_ga98da78cad58c46f526c35a8f8d343706.html'
    ),
    (
     Name: 'ReadSensorHTIRReceiver';
     Value: 'group___hi_technic_a_p_i_gadddc777cc6e34c9981374993d7aa02f6.html'
    ),
    (
     Name: 'ReadSensorHTIRReceiverEx';
     Value: 'group___hi_technic_a_p_i_gad85044f5d543d62200daef12c73881b1.html'
    ),
    (
     Name: 'ResetSensorHTAngle';
     Value: 'group___hi_technic_a_p_i_ga2426d0a71f5232fe1cc64453ff03ee0f.html'
    ),
    (
     Name: 'ReadSensorHTAngle';
     Value: 'group___hi_technic_a_p_i_ga168678aaa538ad4f73091839ac89c57b.html'
    ),
    (
     Name: 'ReadSensorMSCompass';
     Value: 'group___mind_sensors_a_p_i_ga1af1f9b53eedf14ac15d73c62c06c1ee.html'
    ),
    (
     Name: 'ReadSensorMSDROD';
     Value: 'group___mind_sensors_a_p_i_gac3985151ddc6de5bfeec475c3af85279.html'
    ),
    (
     Name: 'SetSensorMSDRODActive';
     Value: 'group___mind_sensors_a_p_i_ga00faad550bbccd6aafa42aab546aa473.html'
    ),
    (
     Name: 'SetSensorMSDRODInactive';
     Value: 'group___mind_sensors_a_p_i_ga8f056e379701566b0f2015da66c2ee2a.html'
    ),
    (
     Name: 'ReadSensorNXTSumoEyes';
     Value: 'group___mind_sensors_a_p_i_ga63202611e31a53093b1eaddd64349e82.html'
    ),
    (
     Name: 'SetSensorNXTSumoEyesLong';
     Value: 'group___mind_sensors_a_p_i_ga8cdaba30d4bb066a16ab221a1092341e.html'
    ),
    (
     Name: 'SetSensorNXTSumoEyesShort';
     Value: 'group___mind_sensors_a_p_i_gaa945cc85d762fc04b9837b4d3ce9aa7d.html'
    ),
    (
     Name: 'ReadSensorMSPressureRaw';
     Value: 'group___mind_sensors_a_p_i_ga32c8a41e1924e28ec25c6d9592f6d962.html'
    ),
    (
     Name: 'ReadSensorMSPressure';
     Value: 'group___mind_sensors_a_p_i_gaceed65190882dc1e7553cfb0b03c97b5.html'
    ),
    (
     Name: 'SetSensorMSPressure';
     Value: 'group___mind_sensors_a_p_i_ga8d08e7d8b5a97bd7abc4e151b9f1b1c1.html'
    ),
    (
     Name: 'SetSensorMSTouchMux';
     Value: 'group___mind_sensors_a_p_i_ga97f854f5306493cb43adfea66ab81b7c.html'
    ),
    (
     Name: 'ReadSensorMSAccel';
     Value: 'group___mind_sensors_a_p_i_gac3321744f9b8e6d3fa307fa0fe74e689.html'
    ),
    (
     Name: 'ReadSensorMSPlayStation';
     Value: 'group___mind_sensors_a_p_i_gae19eb90089e12badea4ef4c081cf3f14.html'
    ),
    (
     Name: 'ReadSensorMSRTClock';
     Value: 'group___mind_sensors_a_p_i_gaf3ea44c13bac140003dd883616e889e1.html'
    ),
    (
     Name: 'ReadSensorMSTilt';
     Value: 'group___mind_sensors_a_p_i_ga1befaaedf90595ad85a368234f1e0a47.html'
    ),
    (
     Name: 'PFMateSend';
     Value: 'group___mind_sensors_a_p_i_ga660efa00c0dc9780a5d0a5bc9707e71e.html'
    ),
    (
     Name: 'PFMateSendRaw';
     Value: 'group___mind_sensors_a_p_i_ga933bea0816b78bb1ee0feded9794d757.html'
    ),
    (
     Name: 'MSReadValue';
     Value: 'group___mind_sensors_a_p_i_gad06a9b6abea0fd86a2c7595453006bac.html'
    ),
    (
     Name: 'MSEnergize';
     Value: 'group___mind_sensors_a_p_i_ga0548f666c34c809669cfad4b1a719c22.html'
    ),
    (
     Name: 'MSDeenergize';
     Value: 'group___mind_sensors_a_p_i_gafe5c99bc24f41d626263c085e60fdefc.html'
    ),
    (
     Name: 'MSADPAOn';
     Value: 'group___mind_sensors_a_p_i_gadfde1588c0d54c874944d7c56cd83f9c.html'
    ),
    (
     Name: 'MSADPAOff';
     Value: 'group___mind_sensors_a_p_i_ga7bb04410da89b846eb7ac11deb9e6d0e.html'
    ),
    (
     Name: 'DISTNxGP2D12';
     Value: 'group___mind_sensors_a_p_i_ga2188e9e53c35796deae74de2f43b3d70.html'
    ),
    (
     Name: 'DISTNxGP2D120';
     Value: 'group___mind_sensors_a_p_i_gac65ab9ac21388c3ba20b77501806bfb1.html'
    ),
    (
     Name: 'DISTNxGP2YA02';
     Value: 'group___mind_sensors_a_p_i_ga7969bebad4561e19325b94f0bc2f9b9f.html'
    ),
    (
     Name: 'DISTNxGP2YA21';
     Value: 'group___mind_sensors_a_p_i_ga25b6e765671a854486d73c023d8ab780.html'
    ),
    (
     Name: 'ReadDISTNxDistance';
     Value: 'group___mind_sensors_a_p_i_ga71d52ee44edf41f22bb8233fbbf495f1.html'
    ),
    (
     Name: 'ReadDISTNxMaxDistance';
     Value: 'group___mind_sensors_a_p_i_gac78d95d807a2a3feebdf10451bd26c4a.html'
    ),
    (
     Name: 'ReadDISTNxMinDistance';
     Value: 'group___mind_sensors_a_p_i_ga7c00b930eb0881c7a65ed9a9ff805636.html'
    ),
    (
     Name: 'ReadDISTNxModuleType';
     Value: 'group___mind_sensors_a_p_i_gaa6839f131dd7b152208848fb4a36e3f4.html'
    ),
    (
     Name: 'ReadDISTNxNumPoints';
     Value: 'group___mind_sensors_a_p_i_gac8f4a9d599f29e80c411f2b8a6f78cc8.html'
    ),
    (
     Name: 'ReadDISTNxVoltage';
     Value: 'group___mind_sensors_a_p_i_ga30b2d4f9acc8989baf44ea54f1522ed9.html'
    ),
    (
     Name: 'ACCLNxCalibrateX';
     Value: 'group___mind_sensors_a_p_i_ga16323dc51a11cdeade40a986ecea70a0.html'
    ),
    (
     Name: 'ACCLNxCalibrateXEnd';
     Value: 'group___mind_sensors_a_p_i_ga6497a845cfa7c4831e4008c687b6a471.html'
    ),
    (
     Name: 'ACCLNxCalibrateY';
     Value: 'group___mind_sensors_a_p_i_ga896d9b934386aa2c76816a82b1a26a49.html'
    ),
    (
     Name: 'ACCLNxCalibrateYEnd';
     Value: 'group___mind_sensors_a_p_i_ga4dc1acce93912e6684b4c291b9774ba4.html'
    ),
    (
     Name: 'ACCLNxCalibrateZ';
     Value: 'group___mind_sensors_a_p_i_ga406e64db85176fe32bc4125db56ac1c0.html'
    ),
    (
     Name: 'ACCLNxCalibrateZEnd';
     Value: 'group___mind_sensors_a_p_i_gac47516c9d4cdde7f8e06798cfe0627b0.html'
    ),
    (
     Name: 'ACCLNxResetCalibration';
     Value: 'group___mind_sensors_a_p_i_gad8193bdcc367261e7029a136faa52cf6.html'
    ),
    (
     Name: 'SetACCLNxSensitivity';
     Value: 'group___mind_sensors_a_p_i_ga0f05d0a71606d54ff49539bf49af20f3.html'
    ),
    (
     Name: 'ReadACCLNxSensitivity';
     Value: 'group___mind_sensors_a_p_i_gafda32f3c62dc23285636c561e58321bb.html'
    ),
    (
     Name: 'ReadACCLNxXOffset';
     Value: 'group___mind_sensors_a_p_i_ga8f5b60dd5d207c1855bffcdc4d122654.html'
    ),
    (
     Name: 'ReadACCLNxXRange';
     Value: 'group___mind_sensors_a_p_i_ga732a135a1c0b33d3ad48091d9db6f502.html'
    ),
    (
     Name: 'ReadACCLNxYOffset';
     Value: 'group___mind_sensors_a_p_i_gafb7fbad6e1062d9b198cd8bdb6612e86.html'
    ),
    (
     Name: 'ReadACCLNxYRange';
     Value: 'group___mind_sensors_a_p_i_ga2beb591bde1576a3cfef8b984ed63356.html'
    ),
    (
     Name: 'ReadACCLNxZOffset';
     Value: 'group___mind_sensors_a_p_i_gaba1eedb0afd968c7b4dcd6803b108bcd.html'
    ),
    (
     Name: 'ReadACCLNxZRange';
     Value: 'group___mind_sensors_a_p_i_gab48ce992f6847dfe987c2af90258e569.html'
    ),
    (
     Name: 'PSPNxDigital';
     Value: 'group___mind_sensors_a_p_i_gae0af689c436fe00e25e395362ca35445.html'
    ),
    (
     Name: 'PSPNxAnalog';
     Value: 'group___mind_sensors_a_p_i_ga457c2061ad080d4388352044fe23df99.html'
    ),
    (
     Name: 'ReadNXTServoPosition';
     Value: 'group___mind_sensors_a_p_i_ga98b7268ad70f6a5192e6091b6fe5158f.html'
    ),
    (
     Name: 'ReadNXTServoSpeed';
     Value: 'group___mind_sensors_a_p_i_ga94c413275fbca515212e88ce366b26c3.html'
    ),
    (
     Name: 'ReadNXTServoBatteryVoltage';
     Value: 'group___mind_sensors_a_p_i_ga02f73d9873ab939b2f2c637396534f74.html'
    ),
    (
     Name: 'SetNXTServoSpeed';
     Value: 'group___mind_sensors_a_p_i_ga64ba71693c2ff1a59561d3e159cd90d9.html'
    ),
    (
     Name: 'SetNXTServoQuickPosition';
     Value: 'group___mind_sensors_a_p_i_gad050cd31604393e7f495f5d11f3dec18.html'
    ),
    (
     Name: 'SetNXTServoPosition';
     Value: 'group___mind_sensors_a_p_i_gac4042c6717667c5f4ea48a1e5f302cd5.html'
    ),
    (
     Name: 'NXTServoReset';
     Value: 'group___mind_sensors_a_p_i_gac9e61f97614f7c707fda2a1d1043c06b.html'
    ),
    (
     Name: 'NXTServoHaltMacro';
     Value: 'group___mind_sensors_a_p_i_ga89ec80ef66760098099df8cb16ec1c9c.html'
    ),
    (
     Name: 'NXTServoResumeMacro';
     Value: 'group___mind_sensors_a_p_i_ga89bccd030a1586d9d53dab9395a18636.html'
    ),
    (
     Name: 'NXTServoPauseMacro';
     Value: 'group___mind_sensors_a_p_i_ga736e23f057cc3ee06438edf703dcdc48.html'
    ),
    (
     Name: 'NXTServoInit';
     Value: 'group___mind_sensors_a_p_i_ga658f4abcc0d6bf0bcdf02d0ed1875350.html'
    ),
    (
     Name: 'NXTServoGotoMacroAddress';
     Value: 'group___mind_sensors_a_p_i_ga36324086a039f41879ba7be0d9e8c728.html'
    ),
    (
     Name: 'NXTServoEditMacro';
     Value: 'group___mind_sensors_a_p_i_ga3d043c7fdec784d23a2cbdf313a1615b.html'
    ),
    (
     Name: 'NXTServoQuitEdit';
     Value: 'group___mind_sensors_a_p_i_ga5ec02b67cc4870c79f12c709bc220b0e.html'
    ),
    (
     Name: 'NXTHIDAsciiMode';
     Value: 'group___mind_sensors_a_p_i_ga140c3f7872d486de103f9a08402f89c5.html'
    ),
    (
     Name: 'NXTHIDDirectMode';
     Value: 'group___mind_sensors_a_p_i_gac1f1b801ea7316c887c181d1432d4de0.html'
    ),
    (
     Name: 'NXTHIDTransmit';
     Value: 'group___mind_sensors_a_p_i_ga6796592b78bbc902c7b209261c0c4e1d.html'
    ),
    (
     Name: 'NXTHIDLoadCharacter';
     Value: 'group___mind_sensors_a_p_i_gaeb96d89f48e09a03ef5d4d3f8b5ec8c1.html'
    ),
    (
     Name: 'NXTPowerMeterResetCounters';
     Value: 'group___mind_sensors_a_p_i_ga73bb35c774fe22db75c4de3bc6d88c7d.html'
    ),
    (
     Name: 'ReadNXTPowerMeterPresentCurrent';
     Value: 'group___mind_sensors_a_p_i_ga3497e967215b0057cb1bc8e2f9a85d41.html'
    ),
    (
     Name: 'ReadNXTPowerMeterPresentVoltage';
     Value: 'group___mind_sensors_a_p_i_ga50a3ea2e7b805211cc8069aab064e65e.html'
    ),
    (
     Name: 'ReadNXTPowerMeterCapacityUsed';
     Value: 'group___mind_sensors_a_p_i_gaa5960c9d9c1dda2690acf66692bfb790.html'
    ),
    (
     Name: 'ReadNXTPowerMeterPresentPower';
     Value: 'group___mind_sensors_a_p_i_ga016b4b86a970ea4457287bd854da82e5.html'
    ),
    (
     Name: 'ReadNXTPowerMeterTotalPowerConsumed';
     Value: 'group___mind_sensors_a_p_i_ga68b125493952d8b34028474c074372b8.html'
    ),
    (
     Name: 'ReadNXTPowerMeterMaxCurrent';
     Value: 'group___mind_sensors_a_p_i_ga16f78a358fc83e1c4e5809bbc5740104.html'
    ),
    (
     Name: 'ReadNXTPowerMeterMinCurrent';
     Value: 'group___mind_sensors_a_p_i_ga9e0d418d21ffd821d90a7a135485e6a2.html'
    ),
    (
     Name: 'ReadNXTPowerMeterMaxVoltage';
     Value: 'group___mind_sensors_a_p_i_ga6db9b518444126e7e8f5a9cad86a47d6.html'
    ),
    (
     Name: 'ReadNXTPowerMeterMinVoltage';
     Value: 'group___mind_sensors_a_p_i_gade0582c396cd99e1c096a24f934121f9.html'
    ),
    (
     Name: 'ReadNXTPowerMeterElapsedTime';
     Value: 'group___mind_sensors_a_p_i_gaf9fa730ca5ef1bdd041631877a341a29.html'
    ),
    (
     Name: 'ReadNXTPowerMeterErrorCount';
     Value: 'group___mind_sensors_a_p_i_ga329680b7db6b50552e2d50d2e583bb4e.html'
    ),
    (
     Name: 'NXTLineLeaderPowerDown';
     Value: 'group___mind_sensors_a_p_i_gae61145b2c13cad9ab263553be4e56caa.html'
    ),
    (
     Name: 'NXTLineLeaderPowerUp';
     Value: 'group___mind_sensors_a_p_i_ga5ebdc059f7f756064c37b04ab97468ee.html'
    ),
    (
     Name: 'NXTLineLeaderInvert';
     Value: 'group___mind_sensors_a_p_i_gad1f301e1fbf012d25e1e12c0ed48ee36.html'
    ),
    (
     Name: 'NXTLineLeaderReset';
     Value: 'group___mind_sensors_a_p_i_ga91305ac2d217d9a73622b0e646b1a8a3.html'
    ),
    (
     Name: 'NXTLineLeaderSnapshot';
     Value: 'group___mind_sensors_a_p_i_gaf881f66e0606de1c68f7d26a40b52997.html'
    ),
    (
     Name: 'NXTLineLeaderCalibrateWhite';
     Value: 'group___mind_sensors_a_p_i_ga8ef8a704fe0dc352e0c06f4ee8092e95.html'
    ),
    (
     Name: 'NXTLineLeaderCalibrateBlack';
     Value: 'group___mind_sensors_a_p_i_ga5e44823c0066da14a496e9b1fa243166.html'
    ),
    (
     Name: 'ReadNXTLineLeaderSteering';
     Value: 'group___mind_sensors_a_p_i_ga8b23e9f3157cd35512347424ab294a58.html'
    ),
    (
     Name: 'ReadNXTLineLeaderAverage';
     Value: 'group___mind_sensors_a_p_i_gafb8179298e36cf9f8f2ae6cc6983251f.html'
    ),
    (
     Name: 'ReadNXTLineLeaderResult';
     Value: 'group___mind_sensors_a_p_i_ga33096826fb3ef808234419135b1c7696.html'
    ),
    (
     Name: 'SetNXTLineLeaderSetpoint';
     Value: 'group___mind_sensors_a_p_i_ga2558948fe189c9bc19aac07cb0ae7df4.html'
    ),
    (
     Name: 'SetNXTLineLeaderKpValue';
     Value: 'group___mind_sensors_a_p_i_ga137af0336711eea7832ccce39bf2fc01.html'
    ),
    (
     Name: 'SetNXTLineLeaderKiValue';
     Value: 'group___mind_sensors_a_p_i_gab06b64498891586c45444c77249e0035.html'
    ),
    (
     Name: 'SetNXTLineLeaderKdValue';
     Value: 'group___mind_sensors_a_p_i_ga2498c2fe3d2a0f1d6e8bef752bb44ef4.html'
    ),
    (
     Name: 'SetNXTLineLeaderKpFactor';
     Value: 'group___mind_sensors_a_p_i_ga9661639c2d4953b6dfe3073ab52443d0.html'
    ),
    (
     Name: 'SetNXTLineLeaderKiFactor';
     Value: 'group___mind_sensors_a_p_i_ga5a5dc58b5a0304a88f2e46d69d43c507.html'
    ),
    (
     Name: 'SetNXTLineLeaderKdFactor';
     Value: 'group___mind_sensors_a_p_i_ga3f2e3a60a4614a5e40e8c9383ef9b081.html'
    ),
    (
     Name: 'NRLink2400';
     Value: 'group___mind_sensors_a_p_i_ga7d372e82e185b9fe2c4081af7b77fef6.html'
    ),
    (
     Name: 'NRLink4800';
     Value: 'group___mind_sensors_a_p_i_ga8a8a7dd19c14404f9bb83b778fa46d1c.html'
    ),
    (
     Name: 'NRLinkFlush';
     Value: 'group___mind_sensors_a_p_i_ga48115d40713cfaaf0724d4d8844e1c76.html'
    ),
    (
     Name: 'NRLinkIRLong';
     Value: 'group___mind_sensors_a_p_i_gae131757294880b6616c208960f98bdad.html'
    ),
    (
     Name: 'NRLinkIRShort';
     Value: 'group___mind_sensors_a_p_i_ga2c0cb4f951c8817d5f1a7e0ced9022c2.html'
    ),
    (
     Name: 'NRLinkSetPF';
     Value: 'group___mind_sensors_a_p_i_gad20d913dc0d5d15c0bc30470180a0f41.html'
    ),
    (
     Name: 'NRLinkSetRCX';
     Value: 'group___mind_sensors_a_p_i_ga2285e87034c73aedf976935827b63f1a.html'
    ),
    (
     Name: 'NRLinkSetTrain';
     Value: 'group___mind_sensors_a_p_i_ga28562869260ca34b98fcd1e45e0c7825.html'
    ),
    (
     Name: 'NRLinkTxRaw';
     Value: 'group___mind_sensors_a_p_i_ga8a1abbd894c0da1b8a73082ff8dcf54b.html'
    ),
    (
     Name: 'ReadNRLinkStatus';
     Value: 'group___mind_sensors_a_p_i_ga4353009e25eadd941d5d774bcbd54c9e.html'
    ),
    (
     Name: 'RunNRLinkMacro';
     Value: 'group___mind_sensors_a_p_i_ga2f6eacb44656dde18252bda26e7ad069.html'
    ),
    (
     Name: 'WriteNRLinkBytes';
     Value: 'group___mind_sensors_a_p_i_gab8dfc382ade445a18228a248bb8e93cc.html'
    ),
    (
     Name: 'ReadNRLinkBytes';
     Value: 'group___mind_sensors_a_p_i_ga1f2b19c281ed9b31e6d0c2ac2e6aec5d.html'
    ),
    (
     Name: 'MSIRTrain';
     Value: 'group___mind_sensors_a_p_i_ga9020747e7b630feba6fd205d594b2e6c.html'
    ),
    (
     Name: 'MSPFComboDirect';
     Value: 'group___mind_sensors_a_p_i_ga3f584758bc5947dd08b977158eb76b29.html'
    ),
    (
     Name: 'MSPFComboPWM';
     Value: 'group___mind_sensors_a_p_i_gaaa59e9d3a211e8d1a15e6354a629f674.html'
    ),
    (
     Name: 'MSPFRawOutput';
     Value: 'group___mind_sensors_a_p_i_ga99afc828c2ac656ec7abd8e10c46cceb.html'
    ),
    (
     Name: 'MSPFRepeat';
     Value: 'group___mind_sensors_a_p_i_ga18770895f1c792bc2349624f9b682058.html'
    ),
    (
     Name: 'MSPFSingleOutputCST';
     Value: 'group___mind_sensors_a_p_i_ga859f1b0ea6e0def5e2f7a7255c166746.html'
    ),
    (
     Name: 'MSPFSingleOutputPWM';
     Value: 'group___mind_sensors_a_p_i_ga4caa9a6601244636c987cfc28c62ba14.html'
    ),
    (
     Name: 'MSPFSinglePin';
     Value: 'group___mind_sensors_a_p_i_gace97cbe100df1d485602aa413cb838d5.html'
    ),
    (
     Name: 'MSPFTrain';
     Value: 'group___mind_sensors_a_p_i_ga7bde47b5e90e104fefee154ecbccf758.html'
    ),
    (
     Name: 'MSRCXSetNRLinkPort';
     Value: 'group___mind_sensors_a_p_i_ga8e401b706943d10482488e03f7845f39.html'
    ),
    (
     Name: 'MSRCXBatteryLevel';
     Value: 'group___mind_sensors_a_p_i_ga529db777167c5268529d813b132c6446.html'
    ),
    (
     Name: 'MSRCXPoll';
     Value: 'group___mind_sensors_a_p_i_gafd56405831f642d1f566e5d37320d736.html'
    ),
    (
     Name: 'MSRCXPollMemory';
     Value: 'group___mind_sensors_a_p_i_ga3655355bbcfe8d19e20e56154b87baf0.html'
    ),
    (
     Name: 'MSRCXAbsVar';
     Value: 'group___mind_sensors_a_p_i_ga51c29a4fa1e736911fc559aecf71bc67.html'
    ),
    (
     Name: 'MSRCXAddToDatalog';
     Value: 'group___mind_sensors_a_p_i_ga1d7714df91750724a4edd012d3c23a12.html'
    ),
    (
     Name: 'MSRCXAndVar';
     Value: 'group___mind_sensors_a_p_i_ga8fa44eb57077e761e4b9da0bd50fdea6.html'
    ),
    (
     Name: 'MSRCXBoot';
     Value: 'group___mind_sensors_a_p_i_gaaeba1fab8558d0838093bc8c2a2d9d3c.html'
    ),
    (
     Name: 'MSRCXCalibrateEvent';
     Value: 'group___mind_sensors_a_p_i_ga7012ef5eaa77379777ffdf53b72f75ed.html'
    ),
    (
     Name: 'MSRCXClearAllEvents';
     Value: 'group___mind_sensors_a_p_i_ga2310c94aa809dc2dad2f4efff3f014e4.html'
    ),
    (
     Name: 'MSRCXClearCounter';
     Value: 'group___mind_sensors_a_p_i_ga41191c417c85cd955734eed740885123.html'
    ),
    (
     Name: 'MSRCXClearMsg';
     Value: 'group___mind_sensors_a_p_i_gabe242f1a7d3e8b7e4bee7aa9cef7ad21.html'
    ),
    (
     Name: 'MSRCXClearSensor';
     Value: 'group___mind_sensors_a_p_i_ga1304c05f19cc7fe719112761c5f55f06.html'
    ),
    (
     Name: 'MSRCXClearSound';
     Value: 'group___mind_sensors_a_p_i_gaf1e9c281ba870715ddb720bb36b1f80b.html'
    ),
    (
     Name: 'MSRCXClearTimer';
     Value: 'group___mind_sensors_a_p_i_ga972132adad02692c4156437cc961b8f4.html'
    ),
    (
     Name: 'MSRCXCreateDatalog';
     Value: 'group___mind_sensors_a_p_i_gaca903dbd5268f142ff9379d34f80a433.html'
    ),
    (
     Name: 'MSRCXDecCounter';
     Value: 'group___mind_sensors_a_p_i_ga832386374987454200de54613f621766.html'
    ),
    (
     Name: 'MSRCXDeleteSub';
     Value: 'group___mind_sensors_a_p_i_ga453bf3138662210fec88eb6503f84543.html'
    ),
    (
     Name: 'MSRCXDeleteSubs';
     Value: 'group___mind_sensors_a_p_i_gaa2c5118bef54ea8cc11482db9447fb12.html'
    ),
    (
     Name: 'MSRCXDeleteTask';
     Value: 'group___mind_sensors_a_p_i_ga359d33e9097105ae4bdb547f051301b7.html'
    ),
    (
     Name: 'MSRCXDeleteTasks';
     Value: 'group___mind_sensors_a_p_i_ga06d94363e747f3de462e71ae6bd5b3a9.html'
    ),
    (
     Name: 'MSRCXDisableOutput';
     Value: 'group___mind_sensors_a_p_i_gaaa651ed44db8e0613774f22ce9fbafb4.html'
    ),
    (
     Name: 'MSRCXDivVar';
     Value: 'group___mind_sensors_a_p_i_ga96f6046637bc8655b9aa1e7b84d10073.html'
    ),
    (
     Name: 'MSRCXEnableOutput';
     Value: 'group___mind_sensors_a_p_i_gaa8a8f912bf3381fa468ccc3504c8af78.html'
    ),
    (
     Name: 'MSRCXEvent';
     Value: 'group___mind_sensors_a_p_i_gae5ae106dc1cef5b98c39f93680723365.html'
    ),
    (
     Name: 'MSRCXFloat';
     Value: 'group___mind_sensors_a_p_i_gaa142f6ddbea3518dd4c254887ed8d8b8.html'
    ),
    (
     Name: 'MSRCXFwd';
     Value: 'group___mind_sensors_a_p_i_ga4ca9f5fe60ef10bf463020bb91e43414.html'
    ),
    (
     Name: 'MSRCXIncCounter';
     Value: 'group___mind_sensors_a_p_i_gaa9bd37c21c1d5fd57920270d3624c883.html'
    ),
    (
     Name: 'MSRCXInvertOutput';
     Value: 'group___mind_sensors_a_p_i_ga1792c93da830a9034447fe4bfa4a6cb7.html'
    ),
    (
     Name: 'MSRCXMulVar';
     Value: 'group___mind_sensors_a_p_i_ga28ac36d41de702e8ee8d3803a192acdb.html'
    ),
    (
     Name: 'MSRCXMuteSound';
     Value: 'group___mind_sensors_a_p_i_ga6bec6fe828c50cd6afe234f1c9a70cab.html'
    ),
    (
     Name: 'MSRCXObvertOutput';
     Value: 'group___mind_sensors_a_p_i_ga0081b92aed5bb6aeb51438dda7000fb1.html'
    ),
    (
     Name: 'MSRCXOff';
     Value: 'group___mind_sensors_a_p_i_ga24274f0b43e520c0fc1619941c8fd8cf.html'
    ),
    (
     Name: 'MSRCXOn';
     Value: 'group___mind_sensors_a_p_i_gab5b6f57a23d68928a80f50f9ee7fc7f9.html'
    ),
    (
     Name: 'MSRCXOnFor';
     Value: 'group___mind_sensors_a_p_i_ga8a3aaeff8bfab59a94b7fc65ecb626aa.html'
    ),
    (
     Name: 'MSRCXOnFwd';
     Value: 'group___mind_sensors_a_p_i_ga4939b673589aac7897513728e66c127b.html'
    ),
    (
     Name: 'MSRCXOnRev';
     Value: 'group___mind_sensors_a_p_i_ga2a4d749241db4bfc707c52af107abaf4.html'
    ),
    (
     Name: 'MSRCXOrVar';
     Value: 'group___mind_sensors_a_p_i_ga41e6b6e5f27bbd6ba8a3506f3f700105.html'
    ),
    (
     Name: 'MSRCXPBTurnOff';
     Value: 'group___mind_sensors_a_p_i_ga55ed295266591e59ccc0281107a33e14.html'
    ),
    (
     Name: 'MSRCXPing';
     Value: 'group___mind_sensors_a_p_i_gae2ae3b143077cc551b8e88d7eac268ff.html'
    ),
    (
     Name: 'MSRCXPlaySound';
     Value: 'group___mind_sensors_a_p_i_ga5192eb183bb07cd0fab2c5ea570416c8.html'
    ),
    (
     Name: 'MSRCXPlayTone';
     Value: 'group___mind_sensors_a_p_i_gab51b02b9a9e5aa27f6d4754efcd43f86.html'
    ),
    (
     Name: 'MSRCXPlayToneVar';
     Value: 'group___mind_sensors_a_p_i_ga59da30b58236b416c1b96198b0c44c55.html'
    ),
    (
     Name: 'MSRCXRemote';
     Value: 'group___mind_sensors_a_p_i_ga6611463580d09faac316d01cc16dd7ac.html'
    ),
    (
     Name: 'MSRCXReset';
     Value: 'group___mind_sensors_a_p_i_ga344571a1a0552e94a86c3b1b3d6aafb2.html'
    ),
    (
     Name: 'MSRCXRev';
     Value: 'group___mind_sensors_a_p_i_ga5500486ee917955c6cd958cd67edbe28.html'
    ),
    (
     Name: 'MSRCXSelectDisplay';
     Value: 'group___mind_sensors_a_p_i_gab0f40ff75225b6d3f668c7b05ff8827f.html'
    ),
    (
     Name: 'MSRCXSelectProgram';
     Value: 'group___mind_sensors_a_p_i_gab0559cecf01b0013a306a834bef0a653.html'
    ),
    (
     Name: 'MSRCXSendSerial';
     Value: 'group___mind_sensors_a_p_i_ga389e2b57e7c149319409658ae72afef4.html'
    ),
    (
     Name: 'MSRCXSet';
     Value: 'group___mind_sensors_a_p_i_ga37729352877e4b75da1acc1ba087553a.html'
    ),
    (
     Name: 'MSRCXSetDirection';
     Value: 'group___mind_sensors_a_p_i_ga514f5ee7e9671f1c7535845a386d3af5.html'
    ),
    (
     Name: 'MSRCXSetEvent';
     Value: 'group___mind_sensors_a_p_i_ga61e8f9f7d613db57a0f6104f4541ade8.html'
    ),
    (
     Name: 'MSRCXSetGlobalDirection';
     Value: 'group___mind_sensors_a_p_i_ga2f6c3df75b6b5fae2894b1652c1ef850.html'
    ),
    (
     Name: 'MSRCXSetGlobalOutput';
     Value: 'group___mind_sensors_a_p_i_ga1896d5de15ee3bc2a9e2e3e0efcd3c9e.html'
    ),
    (
     Name: 'MSRCXSetMaxPower';
     Value: 'group___mind_sensors_a_p_i_ga98d8ad25708fd08da037ba6828becf03.html'
    ),
    (
     Name: 'MSRCXSetMessage';
     Value: 'group___mind_sensors_a_p_i_gab32da223c18a01b63decaf3b7ea7d61e.html'
    ),
    (
     Name: 'MSRCXSetOutput';
     Value: 'group___mind_sensors_a_p_i_ga2c347de33dd93e6b39e40fa0beb130ec.html'
    ),
    (
     Name: 'MSRCXSetPower';
     Value: 'group___mind_sensors_a_p_i_gac515f27b40be68bde1161d3fb5d749f1.html'
    ),
    (
     Name: 'MSRCXSetPriority';
     Value: 'group___mind_sensors_a_p_i_ga4f847133e6b5582f842544157e7b40e7.html'
    ),
    (
     Name: 'MSRCXSetSensorMode';
     Value: 'group___mind_sensors_a_p_i_ga697e111f45cb77d13247b5cbee43094b.html'
    ),
    (
     Name: 'MSRCXSetSensorType';
     Value: 'group___mind_sensors_a_p_i_ga83d2c407293f1dce9ddb0d6c130a524a.html'
    ),
    (
     Name: 'MSRCXSetSleepTime';
     Value: 'group___mind_sensors_a_p_i_ga47aa34a453085914e5e0a19f19301fc9.html'
    ),
    (
     Name: 'MSRCXSetTxPower';
     Value: 'group___mind_sensors_a_p_i_ga116660ade2872b694aa372364967b808.html'
    ),
    (
     Name: 'MSRCXSetUserDisplay';
     Value: 'group___mind_sensors_a_p_i_ga62182bf4e825e683148b41a98ce928cd.html'
    ),
    (
     Name: 'MSRCXSetVar';
     Value: 'group___mind_sensors_a_p_i_gace713bb93017bbc8eaf60412ae2be24c.html'
    ),
    (
     Name: 'MSRCXSetWatch';
     Value: 'group___mind_sensors_a_p_i_ga4cc5dde59ab0546ab178da9f22f33153.html'
    ),
    (
     Name: 'MSRCXSgnVar';
     Value: 'group___mind_sensors_a_p_i_ga808bef922edebf67989f3b4279613b5f.html'
    ),
    (
     Name: 'MSRCXStartTask';
     Value: 'group___mind_sensors_a_p_i_ga46ad645728530066579dbfeeb7d34502.html'
    ),
    (
     Name: 'MSRCXStopAllTasks';
     Value: 'group___mind_sensors_a_p_i_gab9e8785884eadd735e48feecae7fecca.html'
    ),
    (
     Name: 'MSRCXStopTask';
     Value: 'group___mind_sensors_a_p_i_ga6986bca51e9f7c71dd9772d93293c440.html'
    ),
    (
     Name: 'MSRCXSubVar';
     Value: 'group___mind_sensors_a_p_i_ga75c08b772be61260f564fdfac810db4e.html'
    ),
    (
     Name: 'MSRCXSumVar';
     Value: 'group___mind_sensors_a_p_i_gaf804831a0cae734309733244c296ba1e.html'
    ),
    (
     Name: 'MSRCXToggle';
     Value: 'group___mind_sensors_a_p_i_ga45104645dfc094498c43323492e99a7b.html'
    ),
    (
     Name: 'MSRCXUnlock';
     Value: 'group___mind_sensors_a_p_i_ga9d93bc3354c03bc9f69d4a622e980946.html'
    ),
    (
     Name: 'MSRCXUnmuteSound';
     Value: 'group___mind_sensors_a_p_i_ga10703d3c0cb77ec0b84eb0971638eeff.html'
    ),
    (
     Name: 'MSScoutCalibrateSensor';
     Value: 'group___mind_sensors_a_p_i_ga9842d357f9db49124aade19e6cc4d5da.html'
    ),
    (
     Name: 'MSScoutMuteSound';
     Value: 'group___mind_sensors_a_p_i_gacf43a4f38662fe3b58d4479a637ba68f.html'
    ),
    (
     Name: 'MSScoutSelectSounds';
     Value: 'group___mind_sensors_a_p_i_ga1104fedf9dc7c6df35d2a1dd5560cc34.html'
    ),
    (
     Name: 'MSScoutSendVLL';
     Value: 'group___mind_sensors_a_p_i_gaa956a1a1aa2eab89f67cb4ffcc467695.html'
    ),
    (
     Name: 'MSScoutSetCounterLimit';
     Value: 'group___mind_sensors_a_p_i_ga897dee6c9c7a1e0b0c4eacf7b2c688c1.html'
    ),
    (
     Name: 'MSScoutSetEventFeedback';
     Value: 'group___mind_sensors_a_p_i_gadfe319540455028e642f256eb9c0052c.html'
    ),
    (
     Name: 'MSScoutSetLight';
     Value: 'group___mind_sensors_a_p_i_gafd44535f92b3e15cf95965a5ef3cfa10.html'
    ),
    (
     Name: 'MSScoutSetScoutMode';
     Value: 'group___mind_sensors_a_p_i_ga89192741d68f065c1037a8809a77465a.html'
    ),
    (
     Name: 'MSScoutSetScoutRules';
     Value: 'group___mind_sensors_a_p_i_gaa537c8d7112ddd7906f0aa57dcef0a5a.html'
    ),
    (
     Name: 'MSScoutSetSensorClickTime';
     Value: 'group___mind_sensors_a_p_i_gae1cbe8b27ddeb7bc0f40893a50c69672.html'
    ),
    (
     Name: 'MSScoutSetSensorHysteresis';
     Value: 'group___mind_sensors_a_p_i_gab1c8e1596a0fb427bc61f728b571b778.html'
    ),
    (
     Name: 'MSScoutSetSensorLowerLimit';
     Value: 'group___mind_sensors_a_p_i_gae687b0f0db200c6fb4009657d6e70e77.html'
    ),
    (
     Name: 'MSScoutSetSensorUpperLimit';
     Value: 'group___mind_sensors_a_p_i_ga72adee30365b5e9a9f0d3504e32f4192.html'
    ),
    (
     Name: 'MSScoutSetTimerLimit';
     Value: 'group___mind_sensors_a_p_i_ga6a3ce2d16d147578ab38c033589d1048.html'
    ),
    (
     Name: 'MSScoutUnmuteSound';
     Value: 'group___mind_sensors_a_p_i_gab269c6b6060501dd553ccd2e3694c88e.html'
    ),
    (
     Name: 'RFIDInit';
     Value: 'group___codatex_a_p_i_ga400c0de5de8f4f02a7a2d138f70251a2.html'
    ),
    (
     Name: 'RFIDMode';
     Value: 'group___codatex_a_p_i_gacb51a35d1ff521ffd4f517c052a746a6.html'
    ),
    (
     Name: 'RFIDStatus';
     Value: 'group___codatex_a_p_i_ga3d0c0a3b4502fc69e12f678da7a1de76.html'
    ),
    (
     Name: 'RFIDRead';
     Value: 'group___codatex_a_p_i_gae21bd94af642a9c768086e31a86d18c5.html'
    ),
    (
     Name: 'RFIDStop';
     Value: 'group___codatex_a_p_i_gaf0b68e0be49693c5e258ebb2bc591910.html'
    ),
    (
     Name: 'RFIDReadSingle';
     Value: 'group___codatex_a_p_i_gaad5e167befcfb5530692ca2506621c6c.html'
    ),
    (
     Name: 'RFIDReadContinuous';
     Value: 'group___codatex_a_p_i_ga78408313b07acb318e930325fd6e1961.html'
    ),
    (
     Name: 'ReadSensorDIGPSStatus';
     Value: 'group___dexter_industries_a_p_i_gae744b0bb4d2f82f11ec38f3c797f90d9.html'
    ),
    (
     Name: 'ReadSensorDIGPSTime';
     Value: 'group___dexter_industries_a_p_i_gab2c2ce845ed9bb423e298d7e6d5a8cec.html'
    ),
    (
     Name: 'ReadSensorDIGPSLatitude';
     Value: 'group___dexter_industries_a_p_i_ga35d72a30e26e1ee73c07e5a045c18543.html'
    ),
    (
     Name: 'ReadSensorDIGPSLongitude';
     Value: 'group___dexter_industries_a_p_i_gac10cc3f3413fc3556a54954d7ae95f00.html'
    ),
    (
     Name: 'ReadSensorDIGPSVelocity';
     Value: 'group___dexter_industries_a_p_i_ga3ad282f72a7fbf7bf59fb4f6b2c3e54a.html'
    ),
    (
     Name: 'ReadSensorDIGPSHeading';
     Value: 'group___dexter_industries_a_p_i_gaa3f7123ca95172234a3dcbfc74b025f3.html'
    ),
    (
     Name: 'ReadSensorDIGPSDistanceToWaypoint';
     Value: 'group___dexter_industries_a_p_i_gafb1ef78d54ea14d203d198bc3ccaa4c3.html'
    ),
    (
     Name: 'ReadSensorDIGPSHeadingToWaypoint';
     Value: 'group___dexter_industries_a_p_i_ga419e802f6419a02e3e54866cfcbbbbf5.html'
    ),
    (
     Name: 'ReadSensorDIGPSRelativeHeading';
     Value: 'group___dexter_industries_a_p_i_ga7936d6684414fbfe9587e99e05a9878b.html'
    ),
    (
     Name: 'SetSensorDIGPSWaypoint';
     Value: 'group___dexter_industries_a_p_i_gacf18c4353ecc80f967f002d23efdf34b.html'
    ),
    (
     Name: 'glInit';
     Value: 'group___graphics_library_gad3f6557f091e0a958b9156f859cf9f88.html'
    ),
    (
     Name: 'glSet';
     Value: 'group___graphics_library_ga2b3649c13ead0b4e039ce6d01927b2cc.html'
    ),
    (
     Name: 'glBeginObject';
     Value: 'group___graphics_library_gadc046c65763a3c3da07241c8fb4cbc0f.html'
    ),
    (
     Name: 'glEndObject';
     Value: 'group___graphics_library_gac66cdba4ff2075cd26c1527201edea48.html'
    ),
    (
     Name: 'glObjectAction';
     Value: 'group___graphics_library_ga0af56c9b505c558e8594906aaae6632f.html'
    ),
    (
     Name: 'glAddVertex';
     Value: 'group___graphics_library_ga3771b2bf5ba4e3930a26df0f846faac2.html'
    ),
    (
     Name: 'glBegin';
     Value: 'group___graphics_library_ga292df24d2b702bba7635ff091a22361b.html'
    ),
    (
     Name: 'glEnd';
     Value: 'group___graphics_library_gad39740e21d4938761f36145e39197a4b.html'
    ),
    (
     Name: 'glBeginRender';
     Value: 'group___graphics_library_gac09fae1c1e2260d7d5c08c533826875e.html'
    ),
    (
     Name: 'glCallObject';
     Value: 'group___graphics_library_gaa5cec6121981ff240f3b452b6fd93ad8.html'
    ),
    (
     Name: 'glFinishRender';
     Value: 'group___graphics_library_ga1b1ed00d01dfddb0ae883d5f971344f7.html'
    ),
    (
     Name: 'glSetAngleX';
     Value: 'group___graphics_library_ga837c59dfb04e48b9750e4b5aba43518b.html'
    ),
    (
     Name: 'glAddToAngleX';
     Value: 'group___graphics_library_gaf6e593472d92d39bdd4e12cdfc87fcd5.html'
    ),
    (
     Name: 'glSetAngleY';
     Value: 'group___graphics_library_gaac2ad9ce078624315bd6e0e383697766.html'
    ),
    (
     Name: 'glAddToAngleY';
     Value: 'group___graphics_library_gaf4cb1ee90d4126fa51c0a545b21f54e2.html'
    ),
    (
     Name: 'glSetAngleZ';
     Value: 'group___graphics_library_ga9526d4ee2d7f62b7df4870a4cf299621.html'
    ),
    (
     Name: 'glAddToAngleZ';
     Value: 'group___graphics_library_ga33afc74efb698c0e15b1337752818ef6.html'
    ),
    (
     Name: 'glSin32768';
     Value: 'group___graphics_library_gaa5e84db5144a3c5296979ef37b353598.html'
    ),
    (
     Name: 'glCos32768';
     Value: 'group___graphics_library_ga6406208ab66cbee37cec8373c43f056b.html'
    ),
    (
     Name: 'glBox';
     Value: 'group___graphics_library_ga4ef8e607479f2a2f5da79e16a7f96e03.html'
    ),
    (
     Name: 'glCube';
     Value: 'group___graphics_library_ga3dd2850a6085cff9505065571e05461c.html'
    ),
    (
     Name: 'glPyramid';
     Value: 'group___graphics_library_ga63f4ee5b656a8551b0a8196d9aa878ff.html'
    ),
    (
     Name: '$##@$@#$@#$@$';
     Value: '$##@$@#$@#$@$'
    )
  );

implementation

end.
