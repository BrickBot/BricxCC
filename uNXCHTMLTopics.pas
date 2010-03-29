unit uNXCHTMLTopics;

interface

uses
  uHTMLHelp;

const
  uNXCHTMLTopicsSize = 2333;
  uNXCHTMLTopicsData: array[0..uNXCHTMLTopicsSize-1] of TNameValue = (
    (
     Name: 'ColorSensorReadType';
     Value: 'struct_color_sensor_read_type.html'
    ),
    (
     Name: 'CommBTCheckStatusType';
     Value: 'struct_comm_b_t_check_status_type.html'
    ),
    (
     Name: 'CommBTConnectionType';
     Value: 'struct_comm_b_t_connection_type.html'
    ),
    (
     Name: 'CommBTOnOffType';
     Value: 'struct_comm_b_t_on_off_type.html'
    ),
    (
     Name: 'CommBTWriteType';
     Value: 'struct_comm_b_t_write_type.html'
    ),
    (
     Name: 'CommExecuteFunctionType';
     Value: 'struct_comm_execute_function_type.html'
    ),
    (
     Name: 'CommHSCheckStatusType';
     Value: 'struct_comm_h_s_check_status_type.html'
    ),
    (
     Name: 'CommHSControlType';
     Value: 'struct_comm_h_s_control_type.html'
    ),
    (
     Name: 'CommHSReadWriteType';
     Value: 'struct_comm_h_s_read_write_type.html'
    ),
    (
     Name: 'CommLSCheckStatusType';
     Value: 'struct_comm_l_s_check_status_type.html'
    ),
    (
     Name: 'CommLSReadType';
     Value: 'struct_comm_l_s_read_type.html'
    ),
    (
     Name: 'CommLSWriteExType';
     Value: 'struct_comm_l_s_write_ex_type.html'
    ),
    (
     Name: 'CommLSWriteType';
     Value: 'struct_comm_l_s_write_type.html'
    ),
    (
     Name: 'ComputeCalibValueType';
     Value: 'struct_compute_calib_value_type.html'
    ),
    (
     Name: 'DatalogGetTimesType';
     Value: 'struct_datalog_get_times_type.html'
    ),
    (
     Name: 'DatalogWriteType';
     Value: 'struct_datalog_write_type.html'
    ),
    (
     Name: 'DisplayExecuteFunctionType';
     Value: 'struct_display_execute_function_type.html'
    ),
    (
     Name: 'div_t';
     Value: 'structdiv__t.html'
    ),
    (
     Name: 'DrawCircleType';
     Value: 'struct_draw_circle_type.html'
    ),
    (
     Name: 'DrawEllipseType';
     Value: 'struct_draw_ellipse_type.html'
    ),
    (
     Name: 'DrawFontType';
     Value: 'struct_draw_font_type.html'
    ),
    (
     Name: 'DrawGraphicArrayType';
     Value: 'struct_draw_graphic_array_type.html'
    ),
    (
     Name: 'DrawGraphicType';
     Value: 'struct_draw_graphic_type.html'
    ),
    (
     Name: 'DrawLineType';
     Value: 'struct_draw_line_type.html'
    ),
    (
     Name: 'DrawPointType';
     Value: 'struct_draw_point_type.html'
    ),
    (
     Name: 'DrawPolygonType';
     Value: 'struct_draw_polygon_type.html'
    ),
    (
     Name: 'DrawRectType';
     Value: 'struct_draw_rect_type.html'
    ),
    (
     Name: 'DrawTextType';
     Value: 'struct_draw_text_type.html'
    ),
    (
     Name: 'FileCloseType';
     Value: 'struct_file_close_type.html'
    ),
    (
     Name: 'FileDeleteType';
     Value: 'struct_file_delete_type.html'
    ),
    (
     Name: 'FileFindType';
     Value: 'struct_file_find_type.html'
    ),
    (
     Name: 'FileOpenType';
     Value: 'struct_file_open_type.html'
    ),
    (
     Name: 'FileReadWriteType';
     Value: 'struct_file_read_write_type.html'
    ),
    (
     Name: 'FileRenameType';
     Value: 'struct_file_rename_type.html'
    ),
    (
     Name: 'FileResizeType';
     Value: 'struct_file_resize_type.html'
    ),
    (
     Name: 'FileResolveHandleType';
     Value: 'struct_file_resolve_handle_type.html'
    ),
    (
     Name: 'FileSeekType';
     Value: 'struct_file_seek_type.html'
    ),
    (
     Name: 'GetStartTickType';
     Value: 'struct_get_start_tick_type.html'
    ),
    (
     Name: 'IOMapReadByIDType';
     Value: 'struct_i_o_map_read_by_i_d_type.html'
    ),
    (
     Name: 'IOMapReadType';
     Value: 'struct_i_o_map_read_type.html'
    ),
    (
     Name: 'IOMapWriteByIDType';
     Value: 'struct_i_o_map_write_by_i_d_type.html'
    ),
    (
     Name: 'IOMapWriteType';
     Value: 'struct_i_o_map_write_type.html'
    ),
    (
     Name: 'KeepAliveType';
     Value: 'struct_keep_alive_type.html'
    ),
    (
     Name: 'ldiv_t';
     Value: 'structldiv__t.html'
    ),
    (
     Name: 'ListFilesType';
     Value: 'struct_list_files_type.html'
    ),
    (
     Name: 'LoaderExecuteFunctionType';
     Value: 'struct_loader_execute_function_type.html'
    ),
    (
     Name: 'LocationType';
     Value: 'struct_location_type.html'
    ),
    (
     Name: 'MessageReadType';
     Value: 'struct_message_read_type.html'
    ),
    (
     Name: 'MessageWriteType';
     Value: 'struct_message_write_type.html'
    ),
    (
     Name: 'RandomNumberType';
     Value: 'struct_random_number_type.html'
    ),
    (
     Name: 'ReadButtonType';
     Value: 'struct_read_button_type.html'
    ),
    (
     Name: 'ReadSemDataType';
     Value: 'struct_read_sem_data_type.html'
    ),
    (
     Name: 'SetScreenModeType';
     Value: 'struct_set_screen_mode_type.html'
    ),
    (
     Name: 'SetSleepTimeoutType';
     Value: 'struct_set_sleep_timeout_type.html'
    ),
    (
     Name: 'SizeType';
     Value: 'struct_size_type.html'
    ),
    (
     Name: 'SoundGetStateType';
     Value: 'struct_sound_get_state_type.html'
    ),
    (
     Name: 'SoundPlayFileType';
     Value: 'struct_sound_play_file_type.html'
    ),
    (
     Name: 'SoundPlayToneType';
     Value: 'struct_sound_play_tone_type.html'
    ),
    (
     Name: 'SoundSetStateType';
     Value: 'struct_sound_set_state_type.html'
    ),
    (
     Name: 'UpdateCalibCacheInfoType';
     Value: 'struct_update_calib_cache_info_type.html'
    ),
    (
     Name: 'WriteSemDataType';
     Value: 'struct_write_sem_data_type.html'
    ),
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
     Name: 'Type';
     Value: 'group___input_field_constants_gae1f0ac82c78444bf9b69e7dbdd1d1983.html'
    ),
    (
     Name: 'InputMode';
     Value: 'group___input_field_constants_ga9eb109be24ed3161a6fe3ed738810f97.html'
    ),
    (
     Name: 'RawValue';
     Value: 'group___input_field_constants_ga5d03adb0ac3829248c0731c3d51bf1c2.html'
    ),
    (
     Name: 'NormalizedValue';
     Value: 'group___input_field_constants_ga4ae1a3bcdad74201d465ad2c0189a552.html'
    ),
    (
     Name: 'ScaledValue';
     Value: 'group___input_field_constants_ga635d01574d8cb1297fde091603fc506a.html'
    ),
    (
     Name: 'InvalidData';
     Value: 'group___input_field_constants_ga0ce5c43add5742da785356baa4d60e12.html'
    ),
    (
     Name: 'INPUT_DIGI0';
     Value: 'group___input_module_constants_gad78c594fbae4333ba96cc7aeae31c101.html'
    ),
    (
     Name: 'INPUT_DIGI1';
     Value: 'group___input_module_constants_ga335f5381a75a2fde58d057696c91c996.html'
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
     Name: 'InputOffsetColorSensorBoolean';
     Value: 'group___input_i_o_m_a_p_gac048d36ce295daa125e52c74a6d90a25.html'
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
     Name: 'UpdateFlags';
     Value: 'group___output_field_constants_ga0e47fc42dc4366472790f9f41b24e3fc.html'
    ),
    (
     Name: 'OutputMode';
     Value: 'group___output_field_constants_gab4b3213ad49f7c3cf544861324332370.html'
    ),
    (
     Name: 'Power';
     Value: 'group___output_field_constants_ga724d7c9183e504b583cddb0ac6d6fb18.html'
    ),
    (
     Name: 'ActualSpeed';
     Value: 'group___output_field_constants_ga34120d406efe963e3ec869f28598794a.html'
    ),
    (
     Name: 'TachoCount';
     Value: 'group___output_field_constants_gaa27a3e43ee02a5fce1711e18e63e5f99.html'
    ),
    (
     Name: 'TachoLimit';
     Value: 'group___output_field_constants_ga860c3cb59292683f04dd757afa0f5bab.html'
    ),
    (
     Name: 'RunState';
     Value: 'group___output_field_constants_gad34c226de8411ee40ddf10006568957d.html'
    ),
    (
     Name: 'TurnRatio';
     Value: 'group___output_field_constants_ga0f312efe3275dbd122377f67a94c44cb.html'
    ),
    (
     Name: 'RegMode';
     Value: 'group___output_field_constants_ga5866ea8d43018227d31e5ad24c3eb59e.html'
    ),
    (
     Name: 'Overload';
     Value: 'group___output_field_constants_gaaa44331cd12167f50ae728bd81bf9923.html'
    ),
    (
     Name: 'RegPValue';
     Value: 'group___output_field_constants_ga63a9f7bc4a63ded6e2bbb445f487cd95.html'
    ),
    (
     Name: 'RegIValue';
     Value: 'group___output_field_constants_gabbb8be26902334fec6f1e665aa88723a.html'
    ),
    (
     Name: 'RegDValue';
     Value: 'group___output_field_constants_ga0172ec1d96069315677639ce6f56c5bd.html'
    ),
    (
     Name: 'BlockTachoCount';
     Value: 'group___output_field_constants_ga834dcfeb2b6610afeefae3efb93d511c.html'
    ),
    (
     Name: 'RotationCount';
     Value: 'group___output_field_constants_ga8fbc06db521ef917fda60c86abda971f.html'
    ),
    (
     Name: 'OutputOptions';
     Value: 'group___output_field_constants_gaa889a83338b89b509edc0180fdaaf1bd.html'
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
     Name: 'OutputOffsetPwnFreq';
     Value: 'group___output_i_o_m_a_p_ga4b319c46049e7750be282c80d499b1d8.html'
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
     Name: 'TEMP_RES_12BIT';
     Value: 'group___temp_i2_c_constants_gaf8320c5eda0d3f2055666fd84444941b.html'
    ),
    (
     Name: 'TEMP_RES_11BIT';
     Value: 'group___temp_i2_c_constants_ga52f0d6cb434712c9f4ca231398475e60.html'
    ),
    (
     Name: 'TEMP_RES_10BIT';
     Value: 'group___temp_i2_c_constants_gaa12067aa4df773c457133cb4627a2088.html'
    ),
    (
     Name: 'TEMP_RES_9BIT';
     Value: 'group___temp_i2_c_constants_ga5f44cc4fc21a140905ac16b2a9416557.html'
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
     Name: 'TEMP_I2C_ADDRESS';
     Value: 'group___temp_i2_c_constants_ga51bd7ac0228ce613b61ecd0632474c54.html'
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
     Name: 'RCX_SOUND_CLICK';
     Value: 'group___r_c_x_sound_constants_ga128a265414022bb7a2947ee0b1ba2240.html'
    ),
    (
     Name: 'RCX_SOUND_DOUBLE_BEEP';
     Value: 'group___r_c_x_sound_constants_gaa15b548de30075d4adb481e97ed4be59.html'
    ),
    (
     Name: 'RCX_SOUND_DOWN';
     Value: 'group___r_c_x_sound_constants_ga4e8686d0d4701e739961839c382c196b.html'
    ),
    (
     Name: 'RCX_SOUND_UP';
     Value: 'group___r_c_x_sound_constants_gab5c8a127e793c76f74c86e7127669056.html'
    ),
    (
     Name: 'RCX_SOUND_LOW_BEEP';
     Value: 'group___r_c_x_sound_constants_gaa09b3fe87f0e38a160fa99e201eebfc2.html'
    ),
    (
     Name: 'RCX_SOUND_FAST_UP';
     Value: 'group___r_c_x_sound_constants_gabc3b73dfef999ac4906b0c0050540b2f.html'
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
     Name: 'u8';
     Value: 'group___type_aliases_gaf3b86d961da0a3575b4f99c9ffaf01fd.html'
    ),
    (
     Name: 's8';
     Value: 'group___type_aliases_ga543c9bcb4e7b83b40dd6ae7a024a63d2.html'
    ),
    (
     Name: 'u16';
     Value: 'group___type_aliases_ga2b19d553290a8d4a083d3c03280ea800.html'
    ),
    (
     Name: 's16';
     Value: 'group___type_aliases_gad6aafede8a0cfa326715005e57f9d9f5.html'
    ),
    (
     Name: 'u32';
     Value: 'group___type_aliases_ga332ccd83dfe2973e6cb2b61e4f3ab7e6.html'
    ),
    (
     Name: 's32';
     Value: 'group___type_aliases_gaf0938d8dd13b4f7a595e78aacafd3323.html'
    ),
    (
     Name: 'S1';
     Value: 'group___in_ports_ga690d30e9ad3647835c243368b36d4c41.html'
    ),
    (
     Name: 'S2';
     Value: 'group___in_ports_gad5e70dee3c36d645b0eb1743b8a7d2bf.html'
    ),
    (
     Name: 'S3';
     Value: 'group___in_ports_gab29872af8ce9dc9463b7f7ecfbea02ae.html'
    ),
    (
     Name: 'S4';
     Value: 'group___in_ports_gac6dd50ea82e237280daf26bd9b562ba9.html'
    ),
    (
     Name: 'SENSOR_TYPE_NONE';
     Value: 'group___sensor_types_ga386835857bf600880bad754bea5160a6.html'
    ),
    (
     Name: 'SENSOR_TYPE_TOUCH';
     Value: 'group___sensor_types_ga2d58e88ceaa8bf1d0658ce2c7e8d1394.html'
    ),
    (
     Name: 'SENSOR_TYPE_TEMPERATURE';
     Value: 'group___sensor_types_gafb4ae0506fc7cd6743247dae31528d46.html'
    ),
    (
     Name: 'SENSOR_TYPE_LIGHT';
     Value: 'group___sensor_types_ga1d7abf431e8ebeb6f44060d41bffc9d5.html'
    ),
    (
     Name: 'SENSOR_TYPE_ROTATION';
     Value: 'group___sensor_types_gafbe98913a16dd3befc6c4c8565f8017d.html'
    ),
    (
     Name: 'SENSOR_TYPE_LIGHT_ACTIVE';
     Value: 'group___sensor_types_ga76832033dca72709614b9a677a370f4b.html'
    ),
    (
     Name: 'SENSOR_TYPE_LIGHT_INACTIVE';
     Value: 'group___sensor_types_gafe95c6c1503979c6ca8c1bab5cd19d3f.html'
    ),
    (
     Name: 'SENSOR_TYPE_SOUND_DB';
     Value: 'group___sensor_types_ga342ec7aa32fe5dabdec9694f23fe3818.html'
    ),
    (
     Name: 'SENSOR_TYPE_SOUND_DBA';
     Value: 'group___sensor_types_ga5cbb7e6134337a6c8f62cbd7d4f1b84b.html'
    ),
    (
     Name: 'SENSOR_TYPE_CUSTOM';
     Value: 'group___sensor_types_ga3152bfff655d2193e2589d5913783917.html'
    ),
    (
     Name: 'SENSOR_TYPE_LOWSPEED';
     Value: 'group___sensor_types_ga1a6fd0fabdcecab26fe4932033e2b291.html'
    ),
    (
     Name: 'SENSOR_TYPE_LOWSPEED_9V';
     Value: 'group___sensor_types_ga8a14148741f6c4d4cba80ea10a55c639.html'
    ),
    (
     Name: 'SENSOR_TYPE_HIGHSPEED';
     Value: 'group___sensor_types_ga9563836fb2fc6403538188b9b2e8b158.html'
    ),
    (
     Name: 'SENSOR_TYPE_COLORFULL';
     Value: 'group___sensor_types_ga95b1720559acf808676c093993ae0b21.html'
    ),
    (
     Name: 'SENSOR_TYPE_COLORRED';
     Value: 'group___sensor_types_ga0b6c6e7c7cb033e691d9ac7978545e5b.html'
    ),
    (
     Name: 'SENSOR_TYPE_COLORGREEN';
     Value: 'group___sensor_types_gad0362405915459b4345ef20aa2fc6df8.html'
    ),
    (
     Name: 'SENSOR_TYPE_COLORBLUE';
     Value: 'group___sensor_types_gac4239660e3aeb0a3e4e0b8d6f2e05f11.html'
    ),
    (
     Name: 'SENSOR_TYPE_COLORNONE';
     Value: 'group___sensor_types_ga16611785a196dc4ccfebaf4637a406c6.html'
    ),
    (
     Name: 'SENSOR_MODE_RAW';
     Value: 'group___sensor_modes_gaae7bc31a709afd0b8932dd56e767ec5c.html'
    ),
    (
     Name: 'SENSOR_MODE_BOOL';
     Value: 'group___sensor_modes_gaf923b6b490e181e46a4e8b013ef110d2.html'
    ),
    (
     Name: 'SENSOR_MODE_EDGE';
     Value: 'group___sensor_modes_ga9f6708b9bcbf9c5d1c67f3642f098da0.html'
    ),
    (
     Name: 'SENSOR_MODE_PULSE';
     Value: 'group___sensor_modes_gaceb2c7f70da86a943da39e0a07b30ca1.html'
    ),
    (
     Name: 'SENSOR_MODE_PERCENT';
     Value: 'group___sensor_modes_gaf8e05d6e5b3595b584a93180dac2204f.html'
    ),
    (
     Name: 'SENSOR_MODE_CELSIUS';
     Value: 'group___sensor_modes_ga21157cd9453ae35d69fde92a86b1ca08.html'
    ),
    (
     Name: 'SENSOR_MODE_FAHRENHEIT';
     Value: 'group___sensor_modes_ga1d35d51185dbed6b03af5c792e3bdfac.html'
    ),
    (
     Name: 'SENSOR_MODE_ROTATION';
     Value: 'group___sensor_modes_gad4cb64c99df8969255d3e37b3a64dd5a.html'
    ),
    (
     Name: '_SENSOR_CFG';
     Value: 'group___sensor_type_modes_ga2501fa7f043878243e86cdadfbd72c6e.html'
    ),
    (
     Name: 'SENSOR_TOUCH';
     Value: 'group___sensor_type_modes_ga901285138c5fb576faecd4fc5ab7e10c.html'
    ),
    (
     Name: 'SENSOR_LIGHT';
     Value: 'group___sensor_type_modes_gaca24d604a62f087424e7b784efeaea27.html'
    ),
    (
     Name: 'SENSOR_ROTATION';
     Value: 'group___sensor_type_modes_ga00ce1695cfc66a96f151b8ed8000407c.html'
    ),
    (
     Name: 'SENSOR_CELSIUS';
     Value: 'group___sensor_type_modes_ga2f1c48f2eeb7dc890d2e2d88f277daab.html'
    ),
    (
     Name: 'SENSOR_FAHRENHEIT';
     Value: 'group___sensor_type_modes_ga9eeadc7b626697042717185819914431.html'
    ),
    (
     Name: 'SENSOR_PULSE';
     Value: 'group___sensor_type_modes_ga63c20eb5a567c6d919459a3cd3faa477.html'
    ),
    (
     Name: 'SENSOR_EDGE';
     Value: 'group___sensor_type_modes_ga6a8b156803ac431dfd42efea8414e846.html'
    ),
    (
     Name: 'SENSOR_NXTLIGHT';
     Value: 'group___sensor_type_modes_gac08ba115b256ed061791c96fc96dfd74.html'
    ),
    (
     Name: 'SENSOR_SOUND';
     Value: 'group___sensor_type_modes_gab14793f386886a3429602155d2f12922.html'
    ),
    (
     Name: 'SENSOR_LOWSPEED_9V';
     Value: 'group___sensor_type_modes_ga43a1fd83b60a6733847c37a94c9e74be.html'
    ),
    (
     Name: 'SENSOR_LOWSPEED';
     Value: 'group___sensor_type_modes_ga1112f05fed7b9d76abccd8e621df0beb.html'
    ),
    (
     Name: 'SENSOR_COLORFULL';
     Value: 'group___sensor_type_modes_gae5bee6a0888a138f24eb3308bf18dc69.html'
    ),
    (
     Name: 'SENSOR_COLORRED';
     Value: 'group___sensor_type_modes_ga787c4a50ee3cbfc3c3fbb70f765da16f.html'
    ),
    (
     Name: 'SENSOR_COLORGREEN';
     Value: 'group___sensor_type_modes_gaa32264c2a88949f8667698ad4d90e336.html'
    ),
    (
     Name: 'SENSOR_COLORBLUE';
     Value: 'group___sensor_type_modes_ga4c39da4e2ab788e0bdb323f995fb6c23.html'
    ),
    (
     Name: 'SENSOR_COLORNONE';
     Value: 'group___sensor_type_modes_gab469a1b991950c3236903b17c65ccdb7.html'
    ),
    (
     Name: 'SENSOR_1';
     Value: 'group___basic_sensor_values_ga87c3ec7e3e3a97dfa4e13be826528036.html'
    ),
    (
     Name: 'SENSOR_2';
     Value: 'group___basic_sensor_values_ga0237077fbf4ed0403b73a97449c7b4d2.html'
    ),
    (
     Name: 'SENSOR_3';
     Value: 'group___basic_sensor_values_ga98f0394da26bd7ceda74f5bb8bf10526.html'
    ),
    (
     Name: 'SENSOR_4';
     Value: 'group___basic_sensor_values_gaba55a26d989467d0e9efa34c1bcadb7c.html'
    ),
    (
     Name: 'Sqrt';
     Value: 'group__cmath_a_p_i_ga6fa27ad1b70847bbde36914220d1eea3.html'
    ),
    (
     Name: 'Sin';
     Value: 'group__cmath_a_p_i_ga2b5bf68b7ca5638fc501f809bebdafee.html'
    ),
    (
     Name: 'Cos';
     Value: 'group__cmath_a_p_i_ga6d492c3050d74886aaaa47868c4541b0.html'
    ),
    (
     Name: 'Asin';
     Value: 'group__cmath_a_p_i_gac82b2c614fa25a9e5189e9ea71bd45bf.html'
    ),
    (
     Name: 'Acos';
     Value: 'group__cmath_a_p_i_gace5a30feb0c55255b0c4e6543f5a901b.html'
    ),
    (
     Name: 'Atan';
     Value: 'group__cmath_a_p_i_gac23c9bf57e50be42311634de904bfaba.html'
    ),
    (
     Name: 'Ceil';
     Value: 'group__cmath_a_p_i_gaa3f68e6702aa009c5702e4a104e5f137.html'
    ),
    (
     Name: 'Exp';
     Value: 'group__cmath_a_p_i_ga06dcc3237e4df974a1bf39c20172399e.html'
    ),
    (
     Name: 'Floor';
     Value: 'group__cmath_a_p_i_ga7e2a3dec9c0fc1da9c6bd1194050cd0f.html'
    ),
    (
     Name: 'Tan';
     Value: 'group__cmath_a_p_i_ga6806af62197751a8110998c16100646e.html'
    ),
    (
     Name: 'Tanh';
     Value: 'group__cmath_a_p_i_ga071a01e2981083a049032a593d5a2acf.html'
    ),
    (
     Name: 'Cosh';
     Value: 'group__cmath_a_p_i_gac9b08a6df29fd431f4438c134f4e058d.html'
    ),
    (
     Name: 'Sinh';
     Value: 'group__cmath_a_p_i_ga719339d6d6c719901476f2b26da3bdd9.html'
    ),
    (
     Name: 'Log';
     Value: 'group__cmath_a_p_i_gadfc53cc40e6e667f08dfcd14d2d9546b.html'
    ),
    (
     Name: 'Log10';
     Value: 'group__cmath_a_p_i_ga89c038979067265cc5f0ccf783ec6906.html'
    ),
    (
     Name: 'Atan2';
     Value: 'group__cmath_a_p_i_ga9a93fbfa45561d05b9850bef290c24ce.html'
    ),
    (
     Name: 'Pow';
     Value: 'group__cmath_a_p_i_gaeb70e3516ea286a23ba12990a680c7a7.html'
    ),
    (
     Name: 'Trunc';
     Value: 'group__cmath_a_p_i_gad6977f2bc1f4e3c08717b832b1d66599.html'
    ),
    (
     Name: 'Frac';
     Value: 'group__cmath_a_p_i_ga7092b9481adc40b06dedb7fc674576d0.html'
    ),
    (
     Name: 'MulDiv32';
     Value: 'group__cmath_a_p_i_gaf62393f2ffa306d540d86ae9d8588237.html'
    ),
    (
     Name: 'SinD';
     Value: 'group__cmath_a_p_i_gaf40f21916f88ae1008780df3d73b55f2.html'
    ),
    (
     Name: 'CosD';
     Value: 'group__cmath_a_p_i_ga968f3a082298625039f75d1deda67413.html'
    ),
    (
     Name: 'AsinD';
     Value: 'group__cmath_a_p_i_ga925cb412a6be1ddb2af9b149ec341801.html'
    ),
    (
     Name: 'AcosD';
     Value: 'group__cmath_a_p_i_gac332d013183a5a48586c13fd667932a2.html'
    ),
    (
     Name: 'AtanD';
     Value: 'group__cmath_a_p_i_ga4faadb579dee750294e377ac5e33fcf4.html'
    ),
    (
     Name: 'TanD';
     Value: 'group__cmath_a_p_i_gaf79a68515262f43b4ec975978b738402.html'
    ),
    (
     Name: 'TanhD';
     Value: 'group__cmath_a_p_i_ga9b4381d1697e25b4f599c38b68292ad1.html'
    ),
    (
     Name: 'CoshD';
     Value: 'group__cmath_a_p_i_gaf8a3bcb67baa649fa55522c3252f1bbc.html'
    ),
    (
     Name: 'SinhD';
     Value: 'group__cmath_a_p_i_gad4b8b72cf9a8a03077cf9e7adf6bf252.html'
    ),
    (
     Name: 'Atan2D';
     Value: 'group__cmath_a_p_i_ga5f22b542a198a6988c53a8b3c4a3aebf.html'
    ),
    (
     Name: 'getc';
     Value: 'group__cstdio_a_p_i_ga1b8bc288bd2a533f131bfbfbef49f1fd.html'
    ),
    (
     Name: 'putc';
     Value: 'group__cstdio_a_p_i_ga074b343acca0659634a729aa4a353a4f.html'
    ),
    (
     Name: 'SEEK_SET';
     Value: 'group__fseek_constants_ga0d112bae8fd35be772185b6ec6bcbe64.html'
    ),
    (
     Name: 'SEEK_CUR';
     Value: 'group__fseek_constants_ga4c8d0b76b470ba65a43ca46a88320f39.html'
    ),
    (
     Name: 'SEEK_END';
     Value: 'group__fseek_constants_gad2a2e6c114780c3071efd24f16c7f7d8.html'
    ),
    (
     Name: 'RICSetValue';
     Value: 'group___r_i_c_macros_gada63d00ea264346287dc9ad75809fd4e.html'
    ),
    (
     Name: 'SetSensorType';
     Value: 'group___input_module_functions_ga1abf8d2a5ee147b22dbdd05d7cc06e3c.html'
    ),
    (
     Name: 'SetSensorMode';
     Value: 'group___input_module_functions_gac486b741423af7b30cf281beed74a12a.html'
    ),
    (
     Name: 'ClearSensor';
     Value: 'group___input_module_functions_gaea9f1917b39e27a9c07a8d9dd6434954.html'
    ),
    (
     Name: 'ResetSensor';
     Value: 'group___input_module_functions_ga918c371b1f43e4ac11fe2696cad8fe35.html'
    ),
    (
     Name: 'SetSensor';
     Value: 'group___input_module_functions_gac8a51a5406ec412735c132f4efbc028b.html'
    ),
    (
     Name: 'SetSensorTouch';
     Value: 'group___input_module_functions_ga725438cfe21ad4eb9e8e81bb3616bc03.html'
    ),
    (
     Name: 'SetSensorLight';
     Value: 'group___input_module_functions_gad4ee525f94263650be8ee9457ac4ea3b.html'
    ),
    (
     Name: 'SetSensorSound';
     Value: 'group___input_module_functions_gaff2be15516c0f1a32d066109d205e144.html'
    ),
    (
     Name: 'SetSensorLowspeed';
     Value: 'group___input_module_functions_ga218d00df36cc25f385be5eaf4972defc.html'
    ),
    (
     Name: 'SetSensorColorFull';
     Value: 'group___input_module_functions_ga7205c67397fb4a38a33d1b89efe8131f.html'
    ),
    (
     Name: 'SetSensorColorRed';
     Value: 'group___input_module_functions_ga5a0f5cdab9b08650cd0b0301c8e44ee1.html'
    ),
    (
     Name: 'SetSensorColorGreen';
     Value: 'group___input_module_functions_gaa3bc941dc2243c55e56dbd38bb9ffa24.html'
    ),
    (
     Name: 'SetSensorColorBlue';
     Value: 'group___input_module_functions_ga527e2212a18144be0142c459128db5cd.html'
    ),
    (
     Name: 'SetSensorColorNone';
     Value: 'group___input_module_functions_gaa01fe205f2303fd753ed8ec71d80ce99.html'
    ),
    (
     Name: 'GetInput';
     Value: 'group___input_module_functions_ga4c5bba5cc70cd66fbab0911f30580c67.html'
    ),
    (
     Name: 'SetInput';
     Value: 'group___input_module_functions_gade83390b69fbf2677468f7530c5f6d26.html'
    ),
    (
     Name: 'Sensor';
     Value: 'group___input_module_functions_gaed970c76e7d6b6ec934eacd5bd190bdd.html'
    ),
    (
     Name: 'SensorBoolean';
     Value: 'group___input_module_functions_ga6167c8eb0d0ed429223ae0500d1effef.html'
    ),
    (
     Name: 'SensorDigiPinsDirection';
     Value: 'group___input_module_functions_ga1eb10aa61a293ac6439eca27fb5b183f.html'
    ),
    (
     Name: 'SensorDigiPinsOutputLevel';
     Value: 'group___input_module_functions_ga190d47067b1fe5418ce7efa8d63b7cf0.html'
    ),
    (
     Name: 'SensorDigiPinsStatus';
     Value: 'group___input_module_functions_gaa586f98c95b2b3cb71da944476b224d2.html'
    ),
    (
     Name: 'SensorInvalid';
     Value: 'group___input_module_functions_gad1132d096bcfa07b3d9c2635210c50aa.html'
    ),
    (
     Name: 'SensorMode';
     Value: 'group___input_module_functions_gad0fd6523b72f23d085eaf0379ac8f4bf.html'
    ),
    (
     Name: 'SensorNormalized';
     Value: 'group___input_module_functions_gab188a488542719f43f561f14a4656cfc.html'
    ),
    (
     Name: 'SensorRaw';
     Value: 'group___input_module_functions_gadd83e72ee5c6c3079321b31c582f66cc.html'
    ),
    (
     Name: 'SensorScaled';
     Value: 'group___input_module_functions_ga09d82af4992d906d96b08832452f3cab.html'
    ),
    (
     Name: 'SensorType';
     Value: 'group___input_module_functions_ga0b0f61a2a0e92e9263bff25c79f98547.html'
    ),
    (
     Name: 'SensorValue';
     Value: 'group___input_module_functions_ga4c76db831f80cff3f9f341b54ccb7cf8.html'
    ),
    (
     Name: 'SensorValueBool';
     Value: 'group___input_module_functions_ga7160e0becfca5aff7b1bcc533cd5f43a.html'
    ),
    (
     Name: 'SensorValueRaw';
     Value: 'group___input_module_functions_gabe616109f9bc876bece67ec3b10ec285.html'
    ),
    (
     Name: 'CustomSensorActiveStatus';
     Value: 'group___input_module_functions_ga15645554e5a449687abbef0aa5fe9fc6.html'
    ),
    (
     Name: 'CustomSensorPercentFullScale';
     Value: 'group___input_module_functions_ga97bc91f36ced70284da3b7ef8fa2b3f1.html'
    ),
    (
     Name: 'CustomSensorZeroOffset';
     Value: 'group___input_module_functions_gab96ef3293574938fc41168a42ce3ca3c.html'
    ),
    (
     Name: 'SetCustomSensorActiveStatus';
     Value: 'group___input_module_functions_gaeac66dc87896451330486c4f0babf6d5.html'
    ),
    (
     Name: 'SetCustomSensorPercentFullScale';
     Value: 'group___input_module_functions_ga9ffe53f67eda8333894b85ca29513f91.html'
    ),
    (
     Name: 'SetCustomSensorZeroOffset';
     Value: 'group___input_module_functions_ga1cdbe7680a3ebf068c4809dc85dc5e42.html'
    ),
    (
     Name: 'SetSensorBoolean';
     Value: 'group___input_module_functions_ga82fd04418f73f6aa524449d3ec9e9bed.html'
    ),
    (
     Name: 'SetSensorDigiPinsDirection';
     Value: 'group___input_module_functions_ga0c02582066fc338bbf8ad349db5bbaa0.html'
    ),
    (
     Name: 'SetSensorDigiPinsOutputLevel';
     Value: 'group___input_module_functions_gaa949cd79e050d881444f777d1240e954.html'
    ),
    (
     Name: 'SetSensorDigiPinsStatus';
     Value: 'group___input_module_functions_gab6240485dfaa36b9ed94c14e125f4212.html'
    ),
    (
     Name: 'SysColorSensorRead';
     Value: 'group___input_module_functions_gab36236669ac7756bad6841157cf4450d.html'
    ),
    (
     Name: 'ReadSensorColorEx';
     Value: 'group___input_module_functions_gaf8e01f28be7f3476baface8d4515357f.html'
    ),
    (
     Name: 'ReadSensorColorRaw';
     Value: 'group___input_module_functions_gae29b1117df46bf44aaf25843d61ccbaf.html'
    ),
    (
     Name: 'ColorADRaw';
     Value: 'group___input_module_functions_ga500d004e6827bea86423c79ac0e5049a.html'
    ),
    (
     Name: 'ColorBoolean';
     Value: 'group___input_module_functions_ga0fdce903c2a4bd362606e65fb67b98cd.html'
    ),
    (
     Name: 'ColorCalibration';
     Value: 'group___input_module_functions_ga6a1a0ebbc7e429fb65c6678c237a562e.html'
    ),
    (
     Name: 'ColorCalibrationState';
     Value: 'group___input_module_functions_ga4f0505fbe213af9f58c0e10f737ea8fc.html'
    ),
    (
     Name: 'ColorCalLimits';
     Value: 'group___input_module_functions_gabc2827613c0118f74db5a2fd57b87d3e.html'
    ),
    (
     Name: 'ColorSensorRaw';
     Value: 'group___input_module_functions_gae26f02d545d5372e4b626845638bd293.html'
    ),
    (
     Name: 'ColorSensorValue';
     Value: 'group___input_module_functions_gab48186b0feebd05618666269e1507270.html'
    ),
    (
     Name: 'SetMotorPwnFreq';
     Value: 'group___output_module_functions_ga2f740b6a6b9811aab0fb10062ca3b818.html'
    ),
    (
     Name: 'OnFwdSyncPID';
     Value: 'group___output_module_functions_ga50b40af5ac2cbfa46f6f49341a683daa.html'
    ),
    (
     Name: 'OnFwdSyncExPID';
     Value: 'group___output_module_functions_ga171e55f3613f9bb572df4d2affe5f9ce.html'
    ),
    (
     Name: 'OnRevSyncPID';
     Value: 'group___output_module_functions_gaf0274d62899ea4ed110c96fe482ad2dd.html'
    ),
    (
     Name: 'OnRevSyncExPID';
     Value: 'group___output_module_functions_gac1c36d0a2055cf6521260f5f06cf278f.html'
    ),
    (
     Name: 'OnFwdRegPID';
     Value: 'group___output_module_functions_gab0d1b8ef459b181193d74f73098e4341.html'
    ),
    (
     Name: 'OnFwdRegExPID';
     Value: 'group___output_module_functions_gaa5dd57e44bbe3fd6fc78c27c3991f243.html'
    ),
    (
     Name: 'OnRevRegPID';
     Value: 'group___output_module_functions_ga587bfcdf0078f041ac78a9699b3c26dd.html'
    ),
    (
     Name: 'OnRevRegExPID';
     Value: 'group___output_module_functions_ga27d687dc0a617e3b890476938d44559b.html'
    ),
    (
     Name: 'Off';
     Value: 'group___output_module_functions_ga8d19ad643f3e3a0a5d7ad08e7ea5c809.html'
    ),
    (
     Name: 'OffEx';
     Value: 'group___output_module_functions_ga0ce1500792d60a30789cbb64f48f7d57.html'
    ),
    (
     Name: 'Coast';
     Value: 'group___output_module_functions_ga4e8fbbacd2579085c5d144550545a82b.html'
    ),
    (
     Name: 'CoastEx';
     Value: 'group___output_module_functions_ga06700f7305ca088def48cefdedb26f94.html'
    ),
    (
     Name: 'Float';
     Value: 'group___output_module_functions_ga277e6ad37dc5714db216d86d1227a450.html'
    ),
    (
     Name: 'OnFwd';
     Value: 'group___output_module_functions_gaff5b57943544cce13f2e7fcf7eb17b3c.html'
    ),
    (
     Name: 'OnFwdEx';
     Value: 'group___output_module_functions_ga54d8423bdaa00d56b14b6dc4a8c4a112.html'
    ),
    (
     Name: 'OnRev';
     Value: 'group___output_module_functions_gaabf0c191c4e61576735f8d7087b7fc38.html'
    ),
    (
     Name: 'OnRevEx';
     Value: 'group___output_module_functions_gab6b3ba16ee0864a1eba4862602a1f550.html'
    ),
    (
     Name: 'OnFwdReg';
     Value: 'group___output_module_functions_gad4c4a24190aebe2e06a7a4ff41f147f5.html'
    ),
    (
     Name: 'OnFwdRegEx';
     Value: 'group___output_module_functions_gafa657f3ff7256b42b9c993c24c2810a3.html'
    ),
    (
     Name: 'OnRevReg';
     Value: 'group___output_module_functions_ga6f915e43f4b630775d3b84d64be04c14.html'
    ),
    (
     Name: 'OnRevRegEx';
     Value: 'group___output_module_functions_ga23be8f55d95c27cc602fedd6b5a53870.html'
    ),
    (
     Name: 'OnFwdSync';
     Value: 'group___output_module_functions_ga470e2dac6606677d0582cb14c1d31776.html'
    ),
    (
     Name: 'OnFwdSyncEx';
     Value: 'group___output_module_functions_gae9839df67ce3ea90ef49cc9a5a99a593.html'
    ),
    (
     Name: 'OnRevSync';
     Value: 'group___output_module_functions_ga9b4abfa8f99355b600764a4028122e94.html'
    ),
    (
     Name: 'OnRevSyncEx';
     Value: 'group___output_module_functions_ga78f2bd81279cfe3ef1c263b52ccd65cf.html'
    ),
    (
     Name: 'RotateMotor';
     Value: 'group___output_module_functions_gab638baa46cfa84602c8517d9ed9b36ae.html'
    ),
    (
     Name: 'RotateMotorPID';
     Value: 'group___output_module_functions_ga67b6d2a522b1c1aaa54f48440ad38846.html'
    ),
    (
     Name: 'RotateMotorEx';
     Value: 'group___output_module_functions_ga25995f6a1fde8c79a686aa4492568f43.html'
    ),
    (
     Name: 'RotateMotorExPID';
     Value: 'group___output_module_functions_ga74338c85cf59c9db5d987ebdd9388a0f.html'
    ),
    (
     Name: 'ResetTachoCount';
     Value: 'group___output_module_functions_ga89b494fec2591253658a55cc74d7c6e7.html'
    ),
    (
     Name: 'ResetBlockTachoCount';
     Value: 'group___output_module_functions_ga0551f7dff96508c3f6707ccdd776cd3d.html'
    ),
    (
     Name: 'ResetRotationCount';
     Value: 'group___output_module_functions_ga1f07b7f5f06116fffe738f699d0ce83f.html'
    ),
    (
     Name: 'ResetAllTachoCounts';
     Value: 'group___output_module_functions_ga07519ade593f829174fe25a07137d815.html'
    ),
    (
     Name: 'SetOutput';
     Value: 'group___output_module_functions_ga3a3cade87e47f20bd68d371b6896dd15.html'
    ),
    (
     Name: 'GetOutput';
     Value: 'group___output_module_functions_ga956dcd8cfbd30a3b5ddcc0d7c7c810d4.html'
    ),
    (
     Name: 'MotorMode';
     Value: 'group___output_module_functions_gaef49caa1a21a5f15fba5bc7b8c145916.html'
    ),
    (
     Name: 'MotorPower';
     Value: 'group___output_module_functions_ga8acbc6ac97d595b01a2dfa630f74abb2.html'
    ),
    (
     Name: 'MotorActualSpeed';
     Value: 'group___output_module_functions_gaa49e8a82e84f258d4b0a9004a64d8653.html'
    ),
    (
     Name: 'MotorTachoCount';
     Value: 'group___output_module_functions_ga9607b978216f0bd22d6e093e8891c2dd.html'
    ),
    (
     Name: 'MotorTachoLimit';
     Value: 'group___output_module_functions_ga3186c712915ed01de46920d0a7a55ae0.html'
    ),
    (
     Name: 'MotorRunState';
     Value: 'group___output_module_functions_gac583ed7c0869f05006bc8103a3fc2c10.html'
    ),
    (
     Name: 'MotorTurnRatio';
     Value: 'group___output_module_functions_gaede26654a3b4b05c0e210b1651c7f19b.html'
    ),
    (
     Name: 'MotorRegulation';
     Value: 'group___output_module_functions_gadf2e4c1c12091c9f6f9dd0d920a4877c.html'
    ),
    (
     Name: 'MotorOverload';
     Value: 'group___output_module_functions_gafa5c117cd88f14bfb7d4d94b15ccf746.html'
    ),
    (
     Name: 'MotorRegPValue';
     Value: 'group___output_module_functions_ga5550ca186a91bc5ff4eeb9e6b7b60403.html'
    ),
    (
     Name: 'MotorRegIValue';
     Value: 'group___output_module_functions_ga5c95ad1958cd6613ee07274920b7c64f.html'
    ),
    (
     Name: 'MotorRegDValue';
     Value: 'group___output_module_functions_gaf31a7aed74f6ca5175b1ccf9eb14d2fe.html'
    ),
    (
     Name: 'MotorBlockTachoCount';
     Value: 'group___output_module_functions_ga87c16988e5c8a81e244b7331f99a4f63.html'
    ),
    (
     Name: 'MotorRotationCount';
     Value: 'group___output_module_functions_ga24e7343c80ac7a9ec4eeb04e2e645131.html'
    ),
    (
     Name: 'MotorPwnFreq';
     Value: 'group___output_module_functions_ga3ea881cd98bd6a68ace54c31f0b3d0af.html'
    ),
    (
     Name: 'ResetScreen';
     Value: 'group___display_module_functions_ga5f6047bae9bf82be7be019edf176fdba.html'
    ),
    (
     Name: 'CircleOut';
     Value: 'group___display_module_functions_ga1eb681df7693ac76693a90a5ccd402a8.html'
    ),
    (
     Name: 'LineOut';
     Value: 'group___display_module_functions_ga36604633e8510bb5d498842ad2fac759.html'
    ),
    (
     Name: 'PointOut';
     Value: 'group___display_module_functions_ga032802d7467ad6b31a2db54cc374c0f5.html'
    ),
    (
     Name: 'RectOut';
     Value: 'group___display_module_functions_gac581f66f682827f64af2551fd45e74f9.html'
    ),
    (
     Name: 'TextOut';
     Value: 'group___display_module_functions_ga9a070f70dbe14ebfb0b6b0c0abbef64c.html'
    ),
    (
     Name: 'NumOut';
     Value: 'group___display_module_functions_ga6406022f2fd608fe87d8e11ae33b023d.html'
    ),
    (
     Name: 'EllipseOut';
     Value: 'group___display_module_functions_ga396352abfce5d2487a8d94940c57f798.html'
    ),
    (
     Name: 'PolyOut';
     Value: 'group___display_module_functions_ga3f09eb9b7d093628c603093e4ee1ef4c.html'
    ),
    (
     Name: 'FontTextOut';
     Value: 'group___display_module_functions_ga5d4df2c1e8c3951018a865013cb4f31b.html'
    ),
    (
     Name: 'FontNumOut';
     Value: 'group___display_module_functions_gaa860b3f8791f921c7fcce67848cee409.html'
    ),
    (
     Name: 'GraphicOut';
     Value: 'group___display_module_functions_gaed14a2b6c5e90b0853c0e87e8efceaae.html'
    ),
    (
     Name: 'GraphicArrayOut';
     Value: 'group___display_module_functions_gafe305347826a938cda52ce719e7fb405.html'
    ),
    (
     Name: 'GraphicOutEx';
     Value: 'group___display_module_functions_gae931ef362c7835feb3fd99c168c0c749.html'
    ),
    (
     Name: 'GraphicArrayOutEx';
     Value: 'group___display_module_functions_gaa7a93062174fb1f1b16ac2ba35864dea.html'
    ),
    (
     Name: 'GetDisplayNormal';
     Value: 'group___display_module_functions_gabf7c7286d01e689f07a9cf53cf9f13d2.html'
    ),
    (
     Name: 'SetDisplayNormal';
     Value: 'group___display_module_functions_ga7f7e9c41a7daa20853d2b93508df53b7.html'
    ),
    (
     Name: 'GetDisplayPopup';
     Value: 'group___display_module_functions_gae33a7e9c7dc09222e998b02467b35c25.html'
    ),
    (
     Name: 'SetDisplayPopup';
     Value: 'group___display_module_functions_gaa2362b6fac5b71f2103837a7ae47c4d5.html'
    ),
    (
     Name: 'DisplayEraseMask';
     Value: 'group___display_module_functions_ga5cd5a4c35f4734f699e5c9151c594c7e.html'
    ),
    (
     Name: 'DisplayUpdateMask';
     Value: 'group___display_module_functions_ga4c5712d4836fe5c931f3b30e22e8c098.html'
    ),
    (
     Name: 'DisplayDisplay';
     Value: 'group___display_module_functions_ga5e3407313d9a61510407c326697ce9bc.html'
    ),
    (
     Name: 'DisplayFlags';
     Value: 'group___display_module_functions_gacae6ac55393b741b43482247adaceaad.html'
    ),
    (
     Name: 'DisplayTextLinesCenterFlags';
     Value: 'group___display_module_functions_gae678d17a54d15a2e6df70c6e3d4e2bb3.html'
    ),
    (
     Name: 'SysDrawText';
     Value: 'group___display_module_functions_gad797e85b3de8b2cc7bdd246b2bc6841f.html'
    ),
    (
     Name: 'SysDrawPoint';
     Value: 'group___display_module_functions_gac20e1745d60520cc885bee9f87e01f05.html'
    ),
    (
     Name: 'SysDrawLine';
     Value: 'group___display_module_functions_ga5c56e494289ba7fce319aec76d0b7dc8.html'
    ),
    (
     Name: 'SysDrawCircle';
     Value: 'group___display_module_functions_ga6165db50ebefd5f24fa9fc79ee1b3097.html'
    ),
    (
     Name: 'SysDrawRect';
     Value: 'group___display_module_functions_gaefef4f2d7bd2d25e4359636673991819.html'
    ),
    (
     Name: 'SysDrawGraphic';
     Value: 'group___display_module_functions_ga6bf37cf05ec1a8f039a957147c5e2a55.html'
    ),
    (
     Name: 'SysSetScreenMode';
     Value: 'group___display_module_functions_gadd433d4df42c2a639b7a04a24da232c0.html'
    ),
    (
     Name: 'SysDisplayExecuteFunction';
     Value: 'group___display_module_functions_ga4d44dbbb9631f96d385adf49887ff7ae.html'
    ),
    (
     Name: 'DisplayContrast';
     Value: 'group___display_module_functions_gaf9ea52412acbc8868d8ec9ad05c94550.html'
    ),
    (
     Name: 'SysDrawGraphicArray';
     Value: 'group___display_module_functions_gabeea40683dc91ec2d526697573525848.html'
    ),
    (
     Name: 'SysDrawPolygon';
     Value: 'group___display_module_functions_gabc093201b21c198fbeb395d32a073aae.html'
    ),
    (
     Name: 'SysDrawEllipse';
     Value: 'group___display_module_functions_gabad9f2688ab46a5edde6da3d8e58e823.html'
    ),
    (
     Name: 'SysDrawFont';
     Value: 'group___display_module_functions_gaecbb6a0a341d1849bf67c9113e48e85a.html'
    ),
    (
     Name: 'ClearScreen';
     Value: 'group___display_module_functions_ga6a3ca153f0817e8ba91a023b886bb662.html'
    ),
    (
     Name: 'SetDisplayDisplay';
     Value: 'group___display_module_functions_ga91faf1ea1874d9f3ba7cdf7394e4d5b8.html'
    ),
    (
     Name: 'SetDisplayEraseMask';
     Value: 'group___display_module_functions_gab8d994d5963b942be5484bf7e40c10f9.html'
    ),
    (
     Name: 'SetDisplayFlags';
     Value: 'group___display_module_functions_ga6aaf606f8a00cb4950ffa250ba7b043b.html'
    ),
    (
     Name: 'SetDisplayTextLinesCenterFlags';
     Value: 'group___display_module_functions_gaeb18e3fd78f5e676645b5ad22303e487.html'
    ),
    (
     Name: 'SetDisplayUpdateMask';
     Value: 'group___display_module_functions_ga5086eabff0c3fb6dc7b9534f9186de0d.html'
    ),
    (
     Name: 'SetDisplayContrast';
     Value: 'group___display_module_functions_gad73988805842a86affa052f9c2e9b020.html'
    ),
    (
     Name: 'PlayFile';
     Value: 'group___sound_module_functions_ga44cdcc978853d615cc6fc27703e8d0cf.html'
    ),
    (
     Name: 'PlayFileEx';
     Value: 'group___sound_module_functions_gae2526a76df5bb846796374ca0af330e3.html'
    ),
    (
     Name: 'PlayTone';
     Value: 'group___sound_module_functions_ga2461ac0148600b1e5135c8abd8a0ad26.html'
    ),
    (
     Name: 'PlayToneEx';
     Value: 'group___sound_module_functions_ga62c4748422326135566807b24be8d0ac.html'
    ),
    (
     Name: 'SoundState';
     Value: 'group___sound_module_functions_ga77ff1ecc74c4578df36e3f780173efb2.html'
    ),
    (
     Name: 'SoundFlags';
     Value: 'group___sound_module_functions_gaf77be36326eb3976f6e841d3aea55479.html'
    ),
    (
     Name: 'StopSound';
     Value: 'group___sound_module_functions_ga448489f2aebe99c14846335ccecfe702.html'
    ),
    (
     Name: 'SoundFrequency';
     Value: 'group___sound_module_functions_ga8bc552d678b69460c598233001050eb7.html'
    ),
    (
     Name: 'SoundDuration';
     Value: 'group___sound_module_functions_ga1427487643acbceadd96388932e4e0f0.html'
    ),
    (
     Name: 'SoundSampleRate';
     Value: 'group___sound_module_functions_ga131663beffe71d6eeef451345e77a146.html'
    ),
    (
     Name: 'SoundMode';
     Value: 'group___sound_module_functions_ga50ab059c4e57f527389f04b43e057c1b.html'
    ),
    (
     Name: 'SoundVolume';
     Value: 'group___sound_module_functions_ga937a3aeaadc4bbabaacee3a8b5ae9ffb.html'
    ),
    (
     Name: 'SetSoundDuration';
     Value: 'group___sound_module_functions_gaf4eb635bd0e0a1285590d684edb644d7.html'
    ),
    (
     Name: 'SetSoundFlags';
     Value: 'group___sound_module_functions_ga7d95bfd9fc8d97700ddab7ca03c26264.html'
    ),
    (
     Name: 'SetSoundFrequency';
     Value: 'group___sound_module_functions_ga48933159268dff45e5ff5141120373c0.html'
    ),
    (
     Name: 'SetSoundMode';
     Value: 'group___sound_module_functions_ga6c5d11010baa3169939ca1f216b04ad7.html'
    ),
    (
     Name: 'SetSoundModuleState';
     Value: 'group___sound_module_functions_ga3a3c05d3adb787004b09b86948d09b46.html'
    ),
    (
     Name: 'SetSoundSampleRate';
     Value: 'group___sound_module_functions_gae032890f01e8bd2733624b85ff199dac.html'
    ),
    (
     Name: 'SetSoundVolume';
     Value: 'group___sound_module_functions_gacc762838bf03508c641266e17df8e243.html'
    ),
    (
     Name: 'SysSoundPlayFile';
     Value: 'group___sound_module_functions_ga589f05761cb1b466f8334499476cda09.html'
    ),
    (
     Name: 'SysSoundPlayTone';
     Value: 'group___sound_module_functions_gab31d5acfa74843e4715e0bbabb61570a.html'
    ),
    (
     Name: 'SysSoundGetState';
     Value: 'group___sound_module_functions_gaaca1de1737c855860da0e1dc01ea6cae.html'
    ),
    (
     Name: 'SysSoundSetState';
     Value: 'group___sound_module_functions_ga6a74d183a87b2de187805e68691722c5.html'
    ),
    (
     Name: 'SensorUS';
     Value: 'group___low_speed_module_functions_ga7543e9f7d63dda6389db68271134f62e.html'
    ),
    (
     Name: 'ReadSensorUSEx';
     Value: 'group___low_speed_module_functions_ga95d443e1902408c417b392e6b829572c.html'
    ),
    (
     Name: 'ReadI2CRegister';
     Value: 'group___low_speed_module_functions_gaf9b8809b9b5a84ed4103d6ab1ef3708c.html'
    ),
    (
     Name: 'WriteI2CRegister';
     Value: 'group___low_speed_module_functions_gac6175981ccdad6db3e3ebbe364daa562.html'
    ),
    (
     Name: 'LowspeedStatus';
     Value: 'group___low_speed_module_functions_gadfe700e10310199b8aefdc6a19a6be94.html'
    ),
    (
     Name: 'LowspeedCheckStatus';
     Value: 'group___low_speed_module_functions_ga6459a9c5107e23f4d4437038e901e9cd.html'
    ),
    (
     Name: 'LowspeedBytesReady';
     Value: 'group___low_speed_module_functions_ga325ce4e7d27dbc4a56ecc7c3feb2b509.html'
    ),
    (
     Name: 'LowspeedWrite';
     Value: 'group___low_speed_module_functions_ga35c9dfd920448a0a791babbe3cd802f6.html'
    ),
    (
     Name: 'LowspeedRead';
     Value: 'group___low_speed_module_functions_gaab95235e9af826d826b2cb679fd826b4.html'
    ),
    (
     Name: 'I2CStatus';
     Value: 'group___low_speed_module_functions_ga46f151502b61d8d55d1255178dd3b03c.html'
    ),
    (
     Name: 'I2CCheckStatus';
     Value: 'group___low_speed_module_functions_gaa9aa51f9a9c4483e8490de8f6543b2c2.html'
    ),
    (
     Name: 'I2CBytesReady';
     Value: 'group___low_speed_module_functions_ga7131ca5599f7bdbd7009c7c6a7c95bab.html'
    ),
    (
     Name: 'I2CWrite';
     Value: 'group___low_speed_module_functions_ga7b91cee283fe6abcf754401e4da20b58.html'
    ),
    (
     Name: 'I2CRead';
     Value: 'group___low_speed_module_functions_gad015f7e693d493392322cb6b5b92d77d.html'
    ),
    (
     Name: 'I2CBytes';
     Value: 'group___low_speed_module_functions_ga085c21caa6674a6066c1cf67b7ef5374.html'
    ),
    (
     Name: 'I2CDeviceInfo';
     Value: 'group___low_speed_module_functions_ga3a0e7d5f971ec679f7d50d3a1c2965f1.html'
    ),
    (
     Name: 'I2CDeviceInfoEx';
     Value: 'group___low_speed_module_functions_ga74ea3e9f81b6bafe9f499ccd0c4a85a8.html'
    ),
    (
     Name: 'I2CVersion';
     Value: 'group___low_speed_module_functions_gac6fa850f732feee24341d8aab214069b.html'
    ),
    (
     Name: 'I2CVersionEx';
     Value: 'group___low_speed_module_functions_ga7ea1581017b559cec0735729b9c24716.html'
    ),
    (
     Name: 'I2CVendorId';
     Value: 'group___low_speed_module_functions_gad73c93d8cf6266d24c900637adb19a8e.html'
    ),
    (
     Name: 'I2CVendorIdEx';
     Value: 'group___low_speed_module_functions_ga9637a6fe16f4b15e496887da83bdbcd0.html'
    ),
    (
     Name: 'I2CDeviceId';
     Value: 'group___low_speed_module_functions_ga69b9bb6cdb18b9fc7b5b41812dad6402.html'
    ),
    (
     Name: 'I2CDeviceIdEx';
     Value: 'group___low_speed_module_functions_gade60329ca6ac7e0e904fe82f3b4b0bdc.html'
    ),
    (
     Name: 'I2CSendCommand';
     Value: 'group___low_speed_module_functions_ga3434f5e720ec58128372e6e9fca47513.html'
    ),
    (
     Name: 'I2CSendCommandEx';
     Value: 'group___low_speed_module_functions_ga27f583a892f54dbbe18cb7a704370125.html'
    ),
    (
     Name: 'GetLSInputBuffer';
     Value: 'group___low_level_low_speed_module_functions_ga7ccaba5effb0f8cf4a47612a1d3be054.html'
    ),
    (
     Name: 'GetLSOutputBuffer';
     Value: 'group___low_level_low_speed_module_functions_ga5a1b2de511d8cf1ab4f1c57990997386.html'
    ),
    (
     Name: 'LSInputBufferInPtr';
     Value: 'group___low_level_low_speed_module_functions_ga3bb658aad04156aff8ae214a95df856a.html'
    ),
    (
     Name: 'LSInputBufferOutPtr';
     Value: 'group___low_level_low_speed_module_functions_gaf3af9052d470460d0eb133e3b08bee9b.html'
    ),
    (
     Name: 'LSInputBufferBytesToRx';
     Value: 'group___low_level_low_speed_module_functions_ga8c638292f2bf4b9d3a48dd4b821a892b.html'
    ),
    (
     Name: 'LSOutputBufferInPtr';
     Value: 'group___low_level_low_speed_module_functions_ga0165b0c1357ae347071fc6f86e663e34.html'
    ),
    (
     Name: 'LSOutputBufferOutPtr';
     Value: 'group___low_level_low_speed_module_functions_gae4020fa1496877506e4a06b1dccfcd9b.html'
    ),
    (
     Name: 'LSOutputBufferBytesToRx';
     Value: 'group___low_level_low_speed_module_functions_ga506267af6d58d64c2b2f052b150c373e.html'
    ),
    (
     Name: 'LSMode';
     Value: 'group___low_level_low_speed_module_functions_ga7adb79527b2dee332045af04d8a63563.html'
    ),
    (
     Name: 'LSChannelState';
     Value: 'group___low_level_low_speed_module_functions_gaf4ff129c02ce2962087595e7cc7e4bb1.html'
    ),
    (
     Name: 'LSErrorType';
     Value: 'group___low_level_low_speed_module_functions_ga5c9ca57b24b436ca47b5c3891e6f61fc.html'
    ),
    (
     Name: 'LSState';
     Value: 'group___low_level_low_speed_module_functions_ga258190a1dc2f828071cb183321840b7c.html'
    ),
    (
     Name: 'LSSpeed';
     Value: 'group___low_level_low_speed_module_functions_ga09f88efa5bcf677e3fb36a912a848127.html'
    ),
    (
     Name: 'LSNoRestartOnRead';
     Value: 'group___low_level_low_speed_module_functions_ga17beb1068a9cbe8cc270c50d7c0e8851.html'
    ),
    (
     Name: 'SysCommLSWrite';
     Value: 'group___low_speed_module_system_call_functions_ga50a27e152ee9c627091c4046b19fc4ba.html'
    ),
    (
     Name: 'SysCommLSRead';
     Value: 'group___low_speed_module_system_call_functions_ga59da4f6f1e8e85b1172e7d565efd08eb.html'
    ),
    (
     Name: 'SysCommLSCheckStatus';
     Value: 'group___low_speed_module_system_call_functions_ga1008b4278d6ac6744711f43b42977400.html'
    ),
    (
     Name: 'SysCommLSWriteEx';
     Value: 'group___low_speed_module_system_call_functions_ga24d58a9c2c21af890efad13984defc26.html'
    ),
    (
     Name: 'PowerDown';
     Value: 'group___i_o_ctrl_module_functions_gad250149295f663a8d474fd25086fd376.html'
    ),
    (
     Name: 'SleepNow';
     Value: 'group___i_o_ctrl_module_functions_gadecafd9ae6d682ee5a26fdfe68d8cf85.html'
    ),
    (
     Name: 'RebootInFirmwareMode';
     Value: 'group___i_o_ctrl_module_functions_ga64deba6187c8a5c061fcfed88b668566.html'
    ),
    (
     Name: 'CurrentTick';
     Value: 'group___command_module_functions_ga792aeb4749e2b045d0c896df9a0ef21a.html'
    ),
    (
     Name: 'FirstTick';
     Value: 'group___command_module_functions_ga8455ea60ae45289b3e82cc619d4b538a.html'
    ),
    (
     Name: 'ResetSleepTimer';
     Value: 'group___command_module_functions_ga5f828be1c6d60dd34554bc7062d87338.html'
    ),
    (
     Name: 'SysCall';
     Value: 'group___command_module_functions_ga48452295fbdcabea34c033eed3615e9a.html'
    ),
    (
     Name: 'SysGetStartTick';
     Value: 'group___command_module_functions_ga6816a338ad72dce892d3ba0bf9f1eeeb.html'
    ),
    (
     Name: 'SysKeepAlive';
     Value: 'group___command_module_functions_ga3deab51bdfe0021ec67ac696b7e8bb26.html'
    ),
    (
     Name: 'SysIOMapRead';
     Value: 'group___command_module_functions_ga0c918e541158d300dec3c7bc58c09e7e.html'
    ),
    (
     Name: 'SysIOMapWrite';
     Value: 'group___command_module_functions_gac7c0e73bd76ee3679304a9dd0b35f3c2.html'
    ),
    (
     Name: 'SysIOMapReadByID';
     Value: 'group___command_module_functions_gaf5669e344371371e7987caf0daaf0cd8.html'
    ),
    (
     Name: 'SysIOMapWriteByID';
     Value: 'group___command_module_functions_ga652abebd3b0f4f536fb22274a25aa116.html'
    ),
    (
     Name: 'SysDatalogWrite';
     Value: 'group___command_module_functions_ga02e9cfaf1e241b58ae2eccbab8cb59a3.html'
    ),
    (
     Name: 'SysDatalogGetTimes';
     Value: 'group___command_module_functions_ga31b62e8fda9b22305930b709826b2204.html'
    ),
    (
     Name: 'SysReadSemData';
     Value: 'group___command_module_functions_ga87a686a4f82f9fb97df1e2e95c4cb05e.html'
    ),
    (
     Name: 'SysWriteSemData';
     Value: 'group___command_module_functions_ga3f12d1860a8512bb04584e458b43adfe.html'
    ),
    (
     Name: 'SysUpdateCalibCacheInfo';
     Value: 'group___command_module_functions_gace596bec3583d3f625ee7f7c15a517a3.html'
    ),
    (
     Name: 'SysComputeCalibValue';
     Value: 'group___command_module_functions_ga1d3daa068d5bb97a74bd00737219da3d.html'
    ),
    (
     Name: 'Wait';
     Value: 'group___command_module_functions_ga01e64d2250db0e5b41486e316228983f.html'
    ),
    (
     Name: 'Yield';
     Value: 'group___command_module_functions_gaf1c0e21e0767ef32cb1a785ed610e839.html'
    ),
    (
     Name: 'StopAllTasks';
     Value: 'group___command_module_functions_gaccc90f57482de569cccfad5ae0f81161.html'
    ),
    (
     Name: 'Stop';
     Value: 'group___command_module_functions_gae0b7b4cbddeeaa97c008626c305b0b13.html'
    ),
    (
     Name: 'ExitTo';
     Value: 'group___command_module_functions_gabfaff59fc3febef6a33807ba51d38bb4.html'
    ),
    (
     Name: 'Precedes';
     Value: 'group___command_module_functions_ga59bc18d456217192cffcfb1d0bef3863.html'
    ),
    (
     Name: 'Follows';
     Value: 'group___command_module_functions_gacfb98e808819952fc1fc8edcf4e1faf3.html'
    ),
    (
     Name: 'Acquire';
     Value: 'group___command_module_functions_gae2dc7a23d31e7874ae3b6929e4a29300.html'
    ),
    (
     Name: 'Release';
     Value: 'group___command_module_functions_ga1dff3d84967a491413b2331501653cb6.html'
    ),
    (
     Name: 'StartTask';
     Value: 'group___command_module_functions_ga7ecb5d6444d6b2283730af5ddd145b75.html'
    ),
    (
     Name: 'StopTask';
     Value: 'group___command_module_functions_ga3e86a933a9c4bc0e4bb7587a493ab9a7.html'
    ),
    (
     Name: 'ArrayBuild';
     Value: 'group___array_functions_gae8d75e08c670f09f01200a897d7ed2ba.html'
    ),
    (
     Name: 'ArrayLen';
     Value: 'group___array_functions_ga976ecd49f48279bebe51a946d96037c7.html'
    ),
    (
     Name: 'ArrayInit';
     Value: 'group___array_functions_ga49d48de55d817e96ed132eadc21260eb.html'
    ),
    (
     Name: 'ArraySubset';
     Value: 'group___array_functions_ga007959abef61d9e7ca36c588d5a99fc8.html'
    ),
    (
     Name: 'ArraySum';
     Value: 'group___array_functions_ga8165950fda279c2f016ef7b4c0c29b41.html'
    ),
    (
     Name: 'ArrayMean';
     Value: 'group___array_functions_gafb8c16c1b180a56c716a505894bfa0e3.html'
    ),
    (
     Name: 'ArraySumSqr';
     Value: 'group___array_functions_gaae74c963c3985bd942067a6b5a8088d2.html'
    ),
    (
     Name: 'ArrayStd';
     Value: 'group___array_functions_ga15248ed3afee3d6ae9d43b3d17a06514.html'
    ),
    (
     Name: 'ArrayMin';
     Value: 'group___array_functions_ga4ed5da57255795a6e43f6c089d09a990.html'
    ),
    (
     Name: 'ArrayMax';
     Value: 'group___array_functions_gaa2b3f28dc6937b9e2d117fdd186bef13.html'
    ),
    (
     Name: 'ArraySort';
     Value: 'group___array_functions_gaac7aaacb79484c7af81ba0bf35a181d2.html'
    ),
    (
     Name: 'ArrayOp';
     Value: 'group___array_functions_ga000a314fd93cd84a5c46b1e5e22c3a71.html'
    ),
    (
     Name: 'SendMessage';
     Value: 'group___comm_module_functions_gaa0dcf38898e9b509650a456d1393e9c7.html'
    ),
    (
     Name: 'ReceiveMessage';
     Value: 'group___comm_module_functions_ga2d0f44fe54ee34627d4423de5a08539e.html'
    ),
    (
     Name: 'BluetoothStatus';
     Value: 'group___comm_module_functions_ga794c07c04c9062b4477535b2edcfd7b5.html'
    ),
    (
     Name: 'BluetoothWrite';
     Value: 'group___comm_module_functions_ga0cc59e241cc0e588d73818f5112bcbd1.html'
    ),
    (
     Name: 'SendRemoteBool';
     Value: 'group___comm_module_functions_ga932a8bf1221cb52b1ce54e8392a2a785.html'
    ),
    (
     Name: 'SendRemoteNumber';
     Value: 'group___comm_module_functions_ga30beab417cafc0c414eaea0cf58ada14.html'
    ),
    (
     Name: 'SendRemoteString';
     Value: 'group___comm_module_functions_gab0fbb5bd16ba155fe3a7a3ac541b4952.html'
    ),
    (
     Name: 'SendResponseBool';
     Value: 'group___comm_module_functions_gad9d1b72ebef21d78dc659465a6040874.html'
    ),
    (
     Name: 'SendResponseNumber';
     Value: 'group___comm_module_functions_ga91ff51f864ad53c03403177dbc5b73d0.html'
    ),
    (
     Name: 'SendResponseString';
     Value: 'group___comm_module_functions_gae966a0a293b3e5e3b4ca41919bd3fc98.html'
    ),
    (
     Name: 'ReceiveRemoteBool';
     Value: 'group___comm_module_functions_ga512177a39ea1e88e3a63a895abed2d82.html'
    ),
    (
     Name: 'ReceiveRemoteMessageEx';
     Value: 'group___comm_module_functions_gaf2ae51daedc5449f0553ebc47ce9446e.html'
    ),
    (
     Name: 'ReceiveRemoteNumber';
     Value: 'group___comm_module_functions_ga6c1a6c444a5a91e662b218ea37dc0bae.html'
    ),
    (
     Name: 'ReceiveRemoteString';
     Value: 'group___comm_module_functions_gad6d57411062a96381d31f0b83c686b21.html'
    ),
    (
     Name: 'RemoteKeepAlive';
     Value: 'group___comm_module_functions_ga077787b4e8e698a283aff23c529c6338.html'
    ),
    (
     Name: 'RemoteMessageRead';
     Value: 'group___comm_module_functions_ga9a6108ddeefefc5ff5a1893b16fce45a.html'
    ),
    (
     Name: 'RemoteMessageWrite';
     Value: 'group___comm_module_functions_gaeb58ee321ceb422aa6096e53392d25de.html'
    ),
    (
     Name: 'RemotePlaySoundFile';
     Value: 'group___comm_module_functions_ga07c4a4214471ac4a594c7b3c19a7333e.html'
    ),
    (
     Name: 'RemotePlayTone';
     Value: 'group___comm_module_functions_ga4ee2a9d0917362d14a7045fda979e0fe.html'
    ),
    (
     Name: 'RemoteResetMotorPosition';
     Value: 'group___comm_module_functions_gac67efce61704d809226ae014ed0fd188.html'
    ),
    (
     Name: 'RemoteResetScaledValue';
     Value: 'group___comm_module_functions_ga367136db44b6a133988b1142ddaec1b6.html'
    ),
    (
     Name: 'RemoteSetInputMode';
     Value: 'group___comm_module_functions_ga3c92f90fd5ffa0d6d8ee45c676c97249.html'
    ),
    (
     Name: 'RemoteSetOutputState';
     Value: 'group___comm_module_functions_ga9b80406ca9bd35fbc6d1ff38bb9a5a3f.html'
    ),
    (
     Name: 'RemoteStartProgram';
     Value: 'group___comm_module_functions_gaa323856be7980bd6f82f8f87b74fb387.html'
    ),
    (
     Name: 'RemoteStopProgram';
     Value: 'group___comm_module_functions_gadb8ddf6b9e434b053aac96a304a18f98.html'
    ),
    (
     Name: 'RemoteStopSound';
     Value: 'group___comm_module_functions_ga7783a50c02443a19e76b0e5b86505c8e.html'
    ),
    (
     Name: 'RS485Control';
     Value: 'group___comm_module_functions_ga2602cfd3ec9185597a98e1e66714030e.html'
    ),
    (
     Name: 'RS485DataAvailable';
     Value: 'group___comm_module_functions_gae53b9de9e9e0067eef1b773af74bc2de.html'
    ),
    (
     Name: 'RS485Exit';
     Value: 'group___comm_module_functions_ga7b330efb935ca8d971fd9bbafb1e4c55.html'
    ),
    (
     Name: 'RS485Init';
     Value: 'group___comm_module_functions_gaec3fd1ddf435a465f04030b3bf0796b9.html'
    ),
    (
     Name: 'RS485Read';
     Value: 'group___comm_module_functions_ga9cd4f3e460395836bb72ebb60741a7b3.html'
    ),
    (
     Name: 'RS485SendingData';
     Value: 'group___comm_module_functions_gace90b44caaee4367222a2047328e2f4d.html'
    ),
    (
     Name: 'RS485Status';
     Value: 'group___comm_module_functions_ga40c51d3fb017399a10f65cb66dc1ffd6.html'
    ),
    (
     Name: 'RS485Uart';
     Value: 'group___comm_module_functions_gaf9941cbe12019af71e6176cbe431c9bb.html'
    ),
    (
     Name: 'RS485Write';
     Value: 'group___comm_module_functions_ga29d48221788b707299a4d76ebb6cf127.html'
    ),
    (
     Name: 'SendRS485Bool';
     Value: 'group___comm_module_functions_gac9e90050f945ba33437e5ee15ae9da3e.html'
    ),
    (
     Name: 'SendRS485Number';
     Value: 'group___comm_module_functions_ga9a060947b611a17c6d326c8937c783c2.html'
    ),
    (
     Name: 'SendRS485String';
     Value: 'group___comm_module_functions_gae0749c3912f69b803ad5d30fee650af3.html'
    ),
    (
     Name: 'GetBTInputBuffer';
     Value: 'group___comm_module_functions_gad6db7e1fdbf367e934284736c53cf9b8.html'
    ),
    (
     Name: 'GetBTOutputBuffer';
     Value: 'group___comm_module_functions_ga5302c6b28eb5167027d0669bf47e1cbe.html'
    ),
    (
     Name: 'GetHSInputBuffer';
     Value: 'group___comm_module_functions_gafc2ef00546b9a9d1909dbfc4be248086.html'
    ),
    (
     Name: 'GetHSOutputBuffer';
     Value: 'group___comm_module_functions_gaf8ef4b0c79e96f5564c7ef5fa57a4864.html'
    ),
    (
     Name: 'GetUSBInputBuffer';
     Value: 'group___comm_module_functions_gaa59e9b3272ab47d6c8df390e416825ba.html'
    ),
    (
     Name: 'GetUSBOutputBuffer';
     Value: 'group___comm_module_functions_ga7347a4bc00f35558b267ec6c9ddf9c52.html'
    ),
    (
     Name: 'GetUSBPollBuffer';
     Value: 'group___comm_module_functions_ga197af024a3921861b671bada294a1100.html'
    ),
    (
     Name: 'BTDeviceName';
     Value: 'group___comm_module_functions_ga464576a706a7c09b8afb212806d610d7.html'
    ),
    (
     Name: 'BTConnectionName';
     Value: 'group___comm_module_functions_ga24b328638653be852965d36f1c2a4a3f.html'
    ),
    (
     Name: 'BTConnectionPinCode';
     Value: 'group___comm_module_functions_ga3fb32167160f1738ad152141a0de0218.html'
    ),
    (
     Name: 'BrickDataName';
     Value: 'group___comm_module_functions_gafc78b73002bf89829b36f51f5831bbf6.html'
    ),
    (
     Name: 'GetBTDeviceAddress';
     Value: 'group___comm_module_functions_ga64e935a2d94d0ab4bd2511a1dcf3f24f.html'
    ),
    (
     Name: 'GetBTConnectionAddress';
     Value: 'group___comm_module_functions_ga78c493e4889af7d4d08a6ddb2a2ac339.html'
    ),
    (
     Name: 'GetBrickDataAddress';
     Value: 'group___comm_module_functions_gad14f5765f2f0fc72ec89bb1e853e0094.html'
    ),
    (
     Name: 'BTDeviceClass';
     Value: 'group___comm_module_functions_ga17d9fc1ff643f609ace6e1d3a2be2258.html'
    ),
    (
     Name: 'BTDeviceStatus';
     Value: 'group___comm_module_functions_ga592bac36f3d06325078d6b22d01865af.html'
    ),
    (
     Name: 'BTConnectionClass';
     Value: 'group___comm_module_functions_ga157e3f7b381b32b40c43aa7c8aa4994d.html'
    ),
    (
     Name: 'BTConnectionHandleNum';
     Value: 'group___comm_module_functions_ga0ed86d44c42b9a41482c9aa974b0fc69.html'
    ),
    (
     Name: 'BTConnectionStreamStatus';
     Value: 'group___comm_module_functions_ga7f884202b0a8f47d0384ec0a7c3e3bbf.html'
    ),
    (
     Name: 'BTConnectionLinkQuality';
     Value: 'group___comm_module_functions_ga071a9a24c6ae17797f41a5ba85e0b542.html'
    ),
    (
     Name: 'BrickDataBluecoreVersion';
     Value: 'group___comm_module_functions_ga964c5e7ad4e902a12a46add60ed0f0a0.html'
    ),
    (
     Name: 'BrickDataBtStateStatus';
     Value: 'group___comm_module_functions_ga770a417df78614fc859773a1b4a37ad4.html'
    ),
    (
     Name: 'BrickDataBtHardwareStatus';
     Value: 'group___comm_module_functions_ga9a612a88771a4cf6b06fd78cddfc7fbf.html'
    ),
    (
     Name: 'BrickDataTimeoutValue';
     Value: 'group___comm_module_functions_ga26b7c183b4b20e2d857ec3c8007084d1.html'
    ),
    (
     Name: 'BTInputBufferInPtr';
     Value: 'group___comm_module_functions_ga86965453f6c57355ce2ef2ff8efb8fa6.html'
    ),
    (
     Name: 'BTInputBufferOutPtr';
     Value: 'group___comm_module_functions_gad28481b8554af8edbf807ced44742760.html'
    ),
    (
     Name: 'BTOutputBufferInPtr';
     Value: 'group___comm_module_functions_gad4bd4955a793acc69d8347dcf14c4478.html'
    ),
    (
     Name: 'BTOutputBufferOutPtr';
     Value: 'group___comm_module_functions_ga2090ab579db1eb65b8c4e0b7a0322389.html'
    ),
    (
     Name: 'HSInputBufferInPtr';
     Value: 'group___comm_module_functions_ga31416415da33867d12070d2eb7ab684b.html'
    ),
    (
     Name: 'HSInputBufferOutPtr';
     Value: 'group___comm_module_functions_ga47eaa9a3a1346a84cb3181a6a8dc1e5c.html'
    ),
    (
     Name: 'HSOutputBufferInPtr';
     Value: 'group___comm_module_functions_gac069cf44817633ba823cdaaf0fbb9279.html'
    ),
    (
     Name: 'HSOutputBufferOutPtr';
     Value: 'group___comm_module_functions_gaaf62d2ac0f41bde9fd908a2e51ea82a9.html'
    ),
    (
     Name: 'USBInputBufferInPtr';
     Value: 'group___comm_module_functions_gaeea7436f6eccd3dfb1744fbb95d043c1.html'
    ),
    (
     Name: 'USBInputBufferOutPtr';
     Value: 'group___comm_module_functions_ga07ae3065564a6dc8ce8668d61b7b49f0.html'
    ),
    (
     Name: 'USBOutputBufferInPtr';
     Value: 'group___comm_module_functions_gab8e5fcc3c3a0ff60ea3dfccaa5dd8665.html'
    ),
    (
     Name: 'USBOutputBufferOutPtr';
     Value: 'group___comm_module_functions_ga68fbaae4d1fa7112311ad270286dbb6f.html'
    ),
    (
     Name: 'USBPollBufferInPtr';
     Value: 'group___comm_module_functions_ga7165df1cfc5955382c91c2cb30a8cada.html'
    ),
    (
     Name: 'USBPollBufferOutPtr';
     Value: 'group___comm_module_functions_gafdee731cd61f12e278523a7fba45b4c7.html'
    ),
    (
     Name: 'BTDeviceCount';
     Value: 'group___comm_module_functions_gac15f8dd562f2563f7ba0a4c08a182913.html'
    ),
    (
     Name: 'BTDeviceNameCount';
     Value: 'group___comm_module_functions_ga7421bfab9a3527c129805c75a4e50b78.html'
    ),
    (
     Name: 'HSFlags';
     Value: 'group___comm_module_functions_ga2dfd219872dde743cc5dfa24c142cad3.html'
    ),
    (
     Name: 'HSSpeed';
     Value: 'group___comm_module_functions_ga11ee13540fc96d6ce2864d0e1ff75c37.html'
    ),
    (
     Name: 'HSState';
     Value: 'group___comm_module_functions_ga9d03b106378bf478570240daf77d1679.html'
    ),
    (
     Name: 'HSMode';
     Value: 'group___comm_module_functions_ga1225d66a464ad788be40f93d8d526b66.html'
    ),
    (
     Name: 'USBState';
     Value: 'group___comm_module_functions_gae7579412c21a9ae26b4f36e86929fd11.html'
    ),
    (
     Name: 'SetBTInputBuffer';
     Value: 'group___comm_module_functions_ga3f4ee10cce5cd2674ee42de23a8eab90.html'
    ),
    (
     Name: 'SetBTInputBufferInPtr';
     Value: 'group___comm_module_functions_gaa626037ee52b034c148edc1303831b85.html'
    ),
    (
     Name: 'SetBTInputBufferOutPtr';
     Value: 'group___comm_module_functions_gabc245701277d31a6db96ab1a4a8c1211.html'
    ),
    (
     Name: 'SetBTOutputBuffer';
     Value: 'group___comm_module_functions_gaf9b2e853c469fd5d2d0513b3f4dcead2.html'
    ),
    (
     Name: 'SetBTOutputBufferInPtr';
     Value: 'group___comm_module_functions_ga969b6502c2b374e81bfb4496187f25f3.html'
    ),
    (
     Name: 'SetBTOutputBufferOutPtr';
     Value: 'group___comm_module_functions_gac83101aacd930dd23df9c8bb8637a1a4.html'
    ),
    (
     Name: 'SetHSInputBuffer';
     Value: 'group___comm_module_functions_gaf45b20c235220dc134d6368b7a78581c.html'
    ),
    (
     Name: 'SetHSInputBufferInPtr';
     Value: 'group___comm_module_functions_ga3eec6963d2dcd43b698fd84ebc0ff77a.html'
    ),
    (
     Name: 'SetHSInputBufferOutPtr';
     Value: 'group___comm_module_functions_gacc4dc3f793b19e3bdaa3e20ce95d665a.html'
    ),
    (
     Name: 'SetHSOutputBuffer';
     Value: 'group___comm_module_functions_ga5eb11223416ae5250c46bdbc7671243e.html'
    ),
    (
     Name: 'SetHSOutputBufferInPtr';
     Value: 'group___comm_module_functions_ga626bdf50223e86d90be0230584d431bb.html'
    ),
    (
     Name: 'SetHSOutputBufferOutPtr';
     Value: 'group___comm_module_functions_gabf4b574c6e9266c86bf1940ec401b273.html'
    ),
    (
     Name: 'SetUSBInputBuffer';
     Value: 'group___comm_module_functions_gaa66ef1f5ee9f204db63bcb8aa7dbcc7d.html'
    ),
    (
     Name: 'SetUSBInputBufferInPtr';
     Value: 'group___comm_module_functions_ga42bf6a0ed3d3dddd1a277f5a508f746a.html'
    ),
    (
     Name: 'SetUSBInputBufferOutPtr';
     Value: 'group___comm_module_functions_ga0d7e3c01cb5a6902e42625a9332b3c3e.html'
    ),
    (
     Name: 'SetUSBOutputBuffer';
     Value: 'group___comm_module_functions_gaa46d2f90746d9b7b671be834535cceb6.html'
    ),
    (
     Name: 'SetUSBOutputBufferInPtr';
     Value: 'group___comm_module_functions_ga6f12e7cf94122bf099f01475a9e15c06.html'
    ),
    (
     Name: 'SetUSBOutputBufferOutPtr';
     Value: 'group___comm_module_functions_gaa5170d82878f407f4bbf4ab0496d690e.html'
    ),
    (
     Name: 'SetUSBPollBuffer';
     Value: 'group___comm_module_functions_gac6d28aadf0d4ced671acf12a0493cf1e.html'
    ),
    (
     Name: 'SetUSBPollBufferInPtr';
     Value: 'group___comm_module_functions_ga39a77df9db88ee531be0f5a21f707da8.html'
    ),
    (
     Name: 'SetUSBPollBufferOutPtr';
     Value: 'group___comm_module_functions_ga535db96af7ea8b162d07c410027e6937.html'
    ),
    (
     Name: 'SetHSFlags';
     Value: 'group___comm_module_functions_ga40e314b4f73197e41e02f5ffb182f6ed.html'
    ),
    (
     Name: 'SetHSSpeed';
     Value: 'group___comm_module_functions_gaaf2d7f541514e266ae3520205a2d119b.html'
    ),
    (
     Name: 'SetHSState';
     Value: 'group___comm_module_functions_ga24d8ec42f4e96f2efae10e7bacda9452.html'
    ),
    (
     Name: 'SetHSMode';
     Value: 'group___comm_module_functions_ga3a2e446dc3cfd9445b0ddc237b9d7a41.html'
    ),
    (
     Name: 'SetUSBState';
     Value: 'group___comm_module_functions_ga03e112e961e0ed18986a928d3fcacb1c.html'
    ),
    (
     Name: 'SysMessageWrite';
     Value: 'group___comm_module_functions_ga16f2cf513d5154574d34d6bc7e6db71e.html'
    ),
    (
     Name: 'SysMessageRead';
     Value: 'group___comm_module_functions_gafec3a4b5ac2472c2ca1de14e64bd5677.html'
    ),
    (
     Name: 'SysCommBTWrite';
     Value: 'group___comm_module_functions_ga8e08a8615ac16f56c2b87477075d97ad.html'
    ),
    (
     Name: 'SysCommBTCheckStatus';
     Value: 'group___comm_module_functions_ga7be5601c8966e17bdfcec4fde05a5443.html'
    ),
    (
     Name: 'SysCommExecuteFunction';
     Value: 'group___comm_module_functions_gaa59d4f6aadf74c248d7f17df8f110fc5.html'
    ),
    (
     Name: 'SysCommHSControl';
     Value: 'group___comm_module_functions_ga2fa9add72f670246e804168073e038d4.html'
    ),
    (
     Name: 'SysCommHSCheckStatus';
     Value: 'group___comm_module_functions_gac8763c4089daf6ab088116f949eaaf04.html'
    ),
    (
     Name: 'SysCommHSRead';
     Value: 'group___comm_module_functions_ga9dd0450eeabaaad8cab92d3bfc6c4f72.html'
    ),
    (
     Name: 'SysCommHSWrite';
     Value: 'group___comm_module_functions_ga472319548e57b0208e511a35aaee7ebe.html'
    ),
    (
     Name: 'SysCommBTOnOff';
     Value: 'group___comm_module_functions_gafd9ff0aebd6d15312a48512e1d7abd91.html'
    ),
    (
     Name: 'SysCommBTConnection';
     Value: 'group___comm_module_functions_ga842ce6b10457e9dbb1bc8c91f6d0d3ae.html'
    ),
    (
     Name: 'ButtonPressed';
     Value: 'group___button_module_functions_ga70357246663b8eb2e93ff90dfdb42ef1.html'
    ),
    (
     Name: 'ButtonCount';
     Value: 'group___button_module_functions_ga7204d5f855d30e7f85bbdbc750cdccb4.html'
    ),
    (
     Name: 'ReadButtonEx';
     Value: 'group___button_module_functions_ga962aa3bd34dcf435b36d30f73bebb3e3.html'
    ),
    (
     Name: 'ButtonPressCount';
     Value: 'group___button_module_functions_ga6302b443c0500eaea6a2164b81580fb7.html'
    ),
    (
     Name: 'ButtonLongPressCount';
     Value: 'group___button_module_functions_gad3da3e95404bb16224e474452c3a5915.html'
    ),
    (
     Name: 'ButtonShortReleaseCount';
     Value: 'group___button_module_functions_ga34cc70463a3c870d0bf56aa6f5faa920.html'
    ),
    (
     Name: 'ButtonLongReleaseCount';
     Value: 'group___button_module_functions_gaf3fa640aedef16d0815cca41a8b44714.html'
    ),
    (
     Name: 'ButtonReleaseCount';
     Value: 'group___button_module_functions_gaff5146bcfb5fc8a27ca92c44bf45818e.html'
    ),
    (
     Name: 'ButtonState';
     Value: 'group___button_module_functions_gab2806b509572d576e9a2f30e7d6c007f.html'
    ),
    (
     Name: 'SetButtonLongPressCount';
     Value: 'group___button_module_functions_ga5f16bb46382f9b33374221e9a671dda6.html'
    ),
    (
     Name: 'SetButtonLongReleaseCount';
     Value: 'group___button_module_functions_ga9f1c9e5ac2dd8646ec65b6f5c4d7155d.html'
    ),
    (
     Name: 'SetButtonPressCount';
     Value: 'group___button_module_functions_ga0a7e5b7f0dadf90bf2662f33708797e2.html'
    ),
    (
     Name: 'SetButtonReleaseCount';
     Value: 'group___button_module_functions_ga4f54e86054e1ef02ef9cd892eb4ece30.html'
    ),
    (
     Name: 'SetButtonShortReleaseCount';
     Value: 'group___button_module_functions_ga57f72fe52c7aa582733dae20c97975d1.html'
    ),
    (
     Name: 'SetButtonState';
     Value: 'group___button_module_functions_ga9431c7b1178be40933a5e3b57309caa2.html'
    ),
    (
     Name: 'SysReadButton';
     Value: 'group___button_module_functions_ga7539adb3705b0d59f359d4688bc8794b.html'
    ),
    (
     Name: 'CommandFlags';
     Value: 'group___ui_module_functions_gad76bcd625b0a895f98d0853051a64dff.html'
    ),
    (
     Name: 'UIState';
     Value: 'group___ui_module_functions_ga92ee0a50219dd8dc2805a3db56b24b71.html'
    ),
    (
     Name: 'UIButton';
     Value: 'group___ui_module_functions_ga36e4f12b572614b134690095b6df4bc1.html'
    ),
    (
     Name: 'VMRunState';
     Value: 'group___ui_module_functions_gaa1dd27bc00fd2c2152759c3164d176d1.html'
    ),
    (
     Name: 'BatteryState';
     Value: 'group___ui_module_functions_ga7aa4b5743574a50cf553544308367b55.html'
    ),
    (
     Name: 'BluetoothState';
     Value: 'group___ui_module_functions_gad5b54611981b0354a333a1bf40f0bea4.html'
    ),
    (
     Name: 'UsbState';
     Value: 'group___ui_module_functions_ga2860ce53b476b94f36d30092c0665e73.html'
    ),
    (
     Name: 'SleepTimeout';
     Value: 'group___ui_module_functions_ga49891078cc0c032480ad5746056662ec.html'
    ),
    (
     Name: 'SleepTime';
     Value: 'group___ui_module_functions_gad9b343d4a6f887901eaf8cae7cd223e0.html'
    ),
    (
     Name: 'SleepTimer';
     Value: 'group___ui_module_functions_ga98e982ca521453ef8d9f2ca8896990bf.html'
    ),
    (
     Name: 'RechargeableBattery';
     Value: 'group___ui_module_functions_gac23cb2126f516f7ecfc57b2c5bec6a79.html'
    ),
    (
     Name: 'Volume';
     Value: 'group___ui_module_functions_gab3783fa8eb4714a8fd8bb39337ef6550.html'
    ),
    (
     Name: 'OnBrickProgramPointer';
     Value: 'group___ui_module_functions_gafed08926132cf674fac6b5e5f411b8de.html'
    ),
    (
     Name: 'AbortFlag';
     Value: 'group___ui_module_functions_ga4bf657e61435af801f0078a4d040cf7f.html'
    ),
    (
     Name: 'LongAbort';
     Value: 'group___ui_module_functions_ga82271e1630251483f49b40e29c857549.html'
    ),
    (
     Name: 'BatteryLevel';
     Value: 'group___ui_module_functions_gadab48c54d5ff7333fe086152a4c634d1.html'
    ),
    (
     Name: 'SetCommandFlags';
     Value: 'group___ui_module_functions_ga4b592f77ead243054358a65ec62cc65e.html'
    ),
    (
     Name: 'SetUIButton';
     Value: 'group___ui_module_functions_ga379edbffdfe6d4488b13a347cbd29ac0.html'
    ),
    (
     Name: 'SetUIState';
     Value: 'group___ui_module_functions_ga86c39b71bfa7b244995745c932379f82.html'
    ),
    (
     Name: 'SetVMRunState';
     Value: 'group___ui_module_functions_gab9ba4b4e50de6e899e083aab3463a597.html'
    ),
    (
     Name: 'SetBatteryState';
     Value: 'group___ui_module_functions_ga838303b8fce965ce00e2e585aed604be.html'
    ),
    (
     Name: 'SetBluetoothState';
     Value: 'group___ui_module_functions_ga3e1d02098d0ed4ec09b2412cb45bddb0.html'
    ),
    (
     Name: 'SetSleepTimeout';
     Value: 'group___ui_module_functions_ga9a424a8728947cd102922d60f316822c.html'
    ),
    (
     Name: 'SetSleepTime';
     Value: 'group___ui_module_functions_ga3ad5f62315d1b295901872cec3ebe060.html'
    ),
    (
     Name: 'SetSleepTimer';
     Value: 'group___ui_module_functions_ga4253652d829836f9da9ad6608a567afb.html'
    ),
    (
     Name: 'SetVolume';
     Value: 'group___ui_module_functions_ga998e2678b97428b98796548bd7a8f164.html'
    ),
    (
     Name: 'SetOnBrickProgramPointer';
     Value: 'group___ui_module_functions_ga17831ae8357457e9ddc2d98d81d1ef86.html'
    ),
    (
     Name: 'ForceOff';
     Value: 'group___ui_module_functions_ga2845348c8d35c782af66b21af45b7933.html'
    ),
    (
     Name: 'SetAbortFlag';
     Value: 'group___ui_module_functions_ga588ec1132940b08cc706bb843422d494.html'
    ),
    (
     Name: 'SetLongAbort';
     Value: 'group___ui_module_functions_gace23a1d08934fde2c2cc7c5d65280604.html'
    ),
    (
     Name: 'SysSetSleepTimeout';
     Value: 'group___ui_module_functions_gacc06664b2b2aa8221b1e9d98a58f016a.html'
    ),
    (
     Name: 'FreeMemory';
     Value: 'group___loader_module_functions_gaa54c9305e497a2d06942d78e0e02218f.html'
    ),
    (
     Name: 'CreateFile';
     Value: 'group___loader_module_functions_gada63da95141ff19ffa6ee15c5ccba1e8.html'
    ),
    (
     Name: 'OpenFileAppend';
     Value: 'group___loader_module_functions_gad726b331d30cbecdbcb1707dd72fb0bb.html'
    ),
    (
     Name: 'OpenFileRead';
     Value: 'group___loader_module_functions_ga3061ab47184fd4a90cd1d8ed04d9f6a3.html'
    ),
    (
     Name: 'CloseFile';
     Value: 'group___loader_module_functions_ga17ac87a3d0fcb018de6a4e75d5570528.html'
    ),
    (
     Name: 'ResolveHandle';
     Value: 'group___loader_module_functions_gad62674140724d9a7224633e369192aa9.html'
    ),
    (
     Name: 'RenameFile';
     Value: 'group___loader_module_functions_gaf61ab8be7811c3d71d7223dd4e218ab7.html'
    ),
    (
     Name: 'DeleteFile';
     Value: 'group___loader_module_functions_gaa89e91e96e56f2a8ea643c6250dcd68d.html'
    ),
    (
     Name: 'ResizeFile';
     Value: 'group___loader_module_functions_ga2eab4efcde5a3ced5ecf3e472c0fc0bd.html'
    ),
    (
     Name: 'CreateFileLinear';
     Value: 'group___loader_module_functions_ga82743413eccdd38076ff1ba266a225f4.html'
    ),
    (
     Name: 'CreateFileNonLinear';
     Value: 'group___loader_module_functions_ga2c562ef29f14c285e8ac696a73847491.html'
    ),
    (
     Name: 'OpenFileReadLinear';
     Value: 'group___loader_module_functions_gae0a0e291a865ccb8b4678ddc59160b99.html'
    ),
    (
     Name: 'FindFirstFile';
     Value: 'group___loader_module_functions_ga3d737b6a801bf167a97cf0427a02ad83.html'
    ),
    (
     Name: 'FindNextFile';
     Value: 'group___loader_module_functions_gaa5264f1649b74c1e0d8c0ef92cc2121d.html'
    ),
    (
     Name: 'Read';
     Value: 'group___loader_module_functions_gaac1ea059f7224207b51573784c344537.html'
    ),
    (
     Name: 'ReadLn';
     Value: 'group___loader_module_functions_gab29d31beaf0fa0e2272e765f1b874045.html'
    ),
    (
     Name: 'ReadBytes';
     Value: 'group___loader_module_functions_gae8ae82f26e206da40c3bde47a4dd652b.html'
    ),
    (
     Name: 'ReadLnString';
     Value: 'group___loader_module_functions_ga0378bbf5561771317961d8b11b8e0157.html'
    ),
    (
     Name: 'Write';
     Value: 'group___loader_module_functions_ga4db689546a8284ed46aa5838bd6e7dcf.html'
    ),
    (
     Name: 'WriteBytes';
     Value: 'group___loader_module_functions_ga1422e2caa5778b269a54c5f1e4bdda61.html'
    ),
    (
     Name: 'WriteBytesEx';
     Value: 'group___loader_module_functions_ga49d752bc44503859ee78cc6ad92a3aa0.html'
    ),
    (
     Name: 'WriteLn';
     Value: 'group___loader_module_functions_ga4e0c625c81653096752094ddaef0cf6c.html'
    ),
    (
     Name: 'WriteLnString';
     Value: 'group___loader_module_functions_ga4a8644eec9e0b19af7a20911eb520037.html'
    ),
    (
     Name: 'WriteString';
     Value: 'group___loader_module_functions_ga4b6afe0059527e6079e5c99e1e0ffadf.html'
    ),
    (
     Name: 'SysFileOpenRead';
     Value: 'group___loader_module_functions_ga994e013f5399ccd37118fecb006e70ae.html'
    ),
    (
     Name: 'SysFileOpenWrite';
     Value: 'group___loader_module_functions_ga42ad132448cce615481020d882e9edd0.html'
    ),
    (
     Name: 'SysFileOpenAppend';
     Value: 'group___loader_module_functions_ga5cb21014646e567ccfab6050baaddee1.html'
    ),
    (
     Name: 'SysFileRead';
     Value: 'group___loader_module_functions_gad28a222a8f18cebec60a32d04b2c8769.html'
    ),
    (
     Name: 'SysFileWrite';
     Value: 'group___loader_module_functions_ga15b4a20a82cceecad74db98ff0fc6f55.html'
    ),
    (
     Name: 'SysFileClose';
     Value: 'group___loader_module_functions_ga8dff293c4eb561e104781939f2332fd8.html'
    ),
    (
     Name: 'SysFileResolveHandle';
     Value: 'group___loader_module_functions_ga572083efeb02103742756441d951ef29.html'
    ),
    (
     Name: 'SysFileRename';
     Value: 'group___loader_module_functions_ga0c74d5bd705c2ce4a1ce1c82ef8b584e.html'
    ),
    (
     Name: 'SysFileDelete';
     Value: 'group___loader_module_functions_gad128f8a1b756239ac0901f2545467bf7.html'
    ),
    (
     Name: 'SysLoaderExecuteFunction';
     Value: 'group___loader_module_functions_gaea838edff2cf5f31f2c138f6f7407924.html'
    ),
    (
     Name: 'SysFileFindFirst';
     Value: 'group___loader_module_functions_ga866544072133f01b9b4948a5dafcc7d8.html'
    ),
    (
     Name: 'SysFileFindNext';
     Value: 'group___loader_module_functions_ga317950015b0f9c6bd01e9156c19d4954.html'
    ),
    (
     Name: 'SysFileOpenWriteLinear';
     Value: 'group___loader_module_functions_ga5ef8bec4fb31522683c8cd4c27bb7eb8.html'
    ),
    (
     Name: 'SysFileOpenWriteNonLinear';
     Value: 'group___loader_module_functions_ga20be5b18be66f1efe068c880ecb3d3d9.html'
    ),
    (
     Name: 'SysFileOpenReadLinear';
     Value: 'group___loader_module_functions_gab2cc70710eae4879bae0879ff4d372a0.html'
    ),
    (
     Name: 'SysFileSeek';
     Value: 'group___loader_module_functions_gaca9c80455432d977ba6e4c1c4d3f2153.html'
    ),
    (
     Name: 'SysFileResize';
     Value: 'group___loader_module_functions_ga99a07eba34cccd730476e3e3a0b42c80.html'
    ),
    (
     Name: 'SysListFiles';
     Value: 'group___loader_module_functions_ga5dddeb542d9427bb16d997f61427f3f7.html'
    ),
    (
     Name: 'SensorHTGyro';
     Value: 'group___hi_technic_a_p_i_gabdb455bf56fa8e2d0c834eccf0e5b532.html'
    ),
    (
     Name: 'SensorHTEOPD';
     Value: 'group___hi_technic_a_p_i_ga666fbc3dea3a90268ddd4be401bd32d3.html'
    ),
    (
     Name: 'SetSensorHTEOPD';
     Value: 'group___hi_technic_a_p_i_ga76e3af1e9477cc443085109f65ce17b3.html'
    ),
    (
     Name: 'SetSensorHTGyro';
     Value: 'group___hi_technic_a_p_i_gaea028b5e636bef58d384fe0f7f064027.html'
    ),
    (
     Name: 'SensorHTColorNum';
     Value: 'group___hi_technic_a_p_i_gae1fd199476d619089558f7d2df50ef15.html'
    ),
    (
     Name: 'SensorHTCompass';
     Value: 'group___hi_technic_a_p_i_ga6acad43b9093e56fd45d2a76d21a6782.html'
    ),
    (
     Name: 'SensorHTIRSeekerDir';
     Value: 'group___hi_technic_a_p_i_ga1dfe105eb38114e456873671b4e42e0b.html'
    ),
    (
     Name: 'SensorHTIRSeeker2Addr';
     Value: 'group___hi_technic_a_p_i_gaae544e7992a52e58d4b733ab6964ae21.html'
    ),
    (
     Name: 'SensorHTIRSeeker2DCDir';
     Value: 'group___hi_technic_a_p_i_ga244b0f1f29854492503f230513a8e48c.html'
    ),
    (
     Name: 'SensorHTIRSeeker2ACDir';
     Value: 'group___hi_technic_a_p_i_ga24c5a45da67b4f64a50918396e49451e.html'
    ),
    (
     Name: 'SetHTColor2Mode';
     Value: 'group___hi_technic_a_p_i_ga4bf5798b8c0bcd427da26f47983ea04e.html'
    ),
    (
     Name: 'SetHTIRSeeker2Mode';
     Value: 'group___hi_technic_a_p_i_ga483f98611d3441ced552e7bf3e5b6c26.html'
    ),
    (
     Name: 'ReadSensorHTAccel';
     Value: 'group___hi_technic_a_p_i_gaccb90829f8390c6731dfdf1af1dcf2b0.html'
    ),
    (
     Name: 'ReadSensorHTColor';
     Value: 'group___hi_technic_a_p_i_gafe4c0ed777c2bc436c109d68eb232b2c.html'
    ),
    (
     Name: 'ReadSensorHTIRSeeker';
     Value: 'group___hi_technic_a_p_i_gafbba4be00b16a4cb83127ab5575e7908.html'
    ),
    (
     Name: 'ReadSensorHTNormalizedColor';
     Value: 'group___hi_technic_a_p_i_ga0706d3a06e1981a0a2c2da4deed539d0.html'
    ),
    (
     Name: 'ReadSensorHTRawColor';
     Value: 'group___hi_technic_a_p_i_gac1a3d66c3697160f4804bf3f6d012c22.html'
    ),
    (
     Name: 'ReadSensorHTColor2Active';
     Value: 'group___hi_technic_a_p_i_gad745c4078b81d8888dba87a7524ce210.html'
    ),
    (
     Name: 'ReadSensorHTNormalizedColor2Active';
     Value: 'group___hi_technic_a_p_i_ga422531aab0399d53c90337d24cccef9b.html'
    ),
    (
     Name: 'ReadSensorHTRawColor2';
     Value: 'group___hi_technic_a_p_i_ga69edf42e1328eed4db665f78e76b2dc8.html'
    ),
    (
     Name: 'ReadSensorHTIRReceiver';
     Value: 'group___hi_technic_a_p_i_ga4dcecec08c61f9d79439f3dad42d2ecd.html'
    ),
    (
     Name: 'ReadSensorHTIRReceiverEx';
     Value: 'group___hi_technic_a_p_i_gacd083ef3c92ae43bad66cd07f28dca5d.html'
    ),
    (
     Name: 'ReadSensorHTIRSeeker2AC';
     Value: 'group___hi_technic_a_p_i_ga05430b9dc24cba9a82ebdf62c11efa24.html'
    ),
    (
     Name: 'ReadSensorHTIRSeeker2DC';
     Value: 'group___hi_technic_a_p_i_ga7aefe1c5216e6aab272eb4ba8b8ed0da.html'
    ),
    (
     Name: 'ReadSensorHTTouchMultiplexer';
     Value: 'group___hi_technic_a_p_i_gafb017f21259eb60929865969ae9f4c14.html'
    ),
    (
     Name: 'HTIRTrain';
     Value: 'group___hi_technic_a_p_i_ga485e215d22518a7ecd3d50339b1bb254.html'
    ),
    (
     Name: 'HTPFComboDirect';
     Value: 'group___hi_technic_a_p_i_ga02028bf0002796ada5b44675ebfed512.html'
    ),
    (
     Name: 'HTPFComboPWM';
     Value: 'group___hi_technic_a_p_i_ga3303f0705e9e43e66700f0fd209f9dfc.html'
    ),
    (
     Name: 'HTPFRawOutput';
     Value: 'group___hi_technic_a_p_i_gaad83cc30f999b73df7c774df4cc5f44e.html'
    ),
    (
     Name: 'HTPFRepeat';
     Value: 'group___hi_technic_a_p_i_ga07792729bbb4fbfeb9c83e6bf5c28894.html'
    ),
    (
     Name: 'HTPFSingleOutputCST';
     Value: 'group___hi_technic_a_p_i_gae80fb6b909862f02b1a26ae5d3da5c5d.html'
    ),
    (
     Name: 'HTPFSingleOutputPWM';
     Value: 'group___hi_technic_a_p_i_gab8b043b3aa4f11237b136492b61c226a.html'
    ),
    (
     Name: 'HTPFSinglePin';
     Value: 'group___hi_technic_a_p_i_ga23d405c2946a4a9a600cacd4a66e2aa7.html'
    ),
    (
     Name: 'HTPFTrain';
     Value: 'group___hi_technic_a_p_i_gaf5d9306cea9fa13dbadf7865dd6e0055.html'
    ),
    (
     Name: 'HTRCXSetIRLinkPort';
     Value: 'group___hi_technic_a_p_i_ga25f3722b44d50daf7934765193e40a72.html'
    ),
    (
     Name: 'HTRCXBatteryLevel';
     Value: 'group___hi_technic_a_p_i_gad063c346adccbd193217ebb07e9aef56.html'
    ),
    (
     Name: 'HTRCXPoll';
     Value: 'group___hi_technic_a_p_i_ga6ba49b5fd87b3ad379a07b5ef5247559.html'
    ),
    (
     Name: 'HTRCXPollMemory';
     Value: 'group___hi_technic_a_p_i_ga5b0bae03ec48ac98eb558aa43bca3878.html'
    ),
    (
     Name: 'HTRCXAddToDatalog';
     Value: 'group___hi_technic_a_p_i_ga9241c690bbb54e3a644736797d775fb3.html'
    ),
    (
     Name: 'HTRCXClearAllEvents';
     Value: 'group___hi_technic_a_p_i_ga614a59f9ad8a24a5372efb05948c0e19.html'
    ),
    (
     Name: 'HTRCXClearCounter';
     Value: 'group___hi_technic_a_p_i_ga3f1f7d3d7a3efbc418ec2efa817f2212.html'
    ),
    (
     Name: 'HTRCXClearMsg';
     Value: 'group___hi_technic_a_p_i_gafcd51c98b19996d62e85545d4db5a39c.html'
    ),
    (
     Name: 'HTRCXClearSensor';
     Value: 'group___hi_technic_a_p_i_ga0379b553190489ba697e2b869a445117.html'
    ),
    (
     Name: 'HTRCXClearSound';
     Value: 'group___hi_technic_a_p_i_ga7f6ef0a21624d81794c608b7e8a4e3d7.html'
    ),
    (
     Name: 'HTRCXClearTimer';
     Value: 'group___hi_technic_a_p_i_ga48b35c851355f40074d7e437a5cfa1ab.html'
    ),
    (
     Name: 'HTRCXCreateDatalog';
     Value: 'group___hi_technic_a_p_i_ga58a422b4a7a6ccefca133c520aeb02fe.html'
    ),
    (
     Name: 'HTRCXDecCounter';
     Value: 'group___hi_technic_a_p_i_ga5bd634623b8d61df23e7b36204f86d1f.html'
    ),
    (
     Name: 'HTRCXDeleteSub';
     Value: 'group___hi_technic_a_p_i_gadc0aa5bcbd9a12482f8a1caf30537e19.html'
    ),
    (
     Name: 'HTRCXDeleteSubs';
     Value: 'group___hi_technic_a_p_i_gad7a89b17a4daa1b6a3750b6dcf7b51fe.html'
    ),
    (
     Name: 'HTRCXDeleteTask';
     Value: 'group___hi_technic_a_p_i_ga55036804fb7e8d2ae29b6b1a17acf516.html'
    ),
    (
     Name: 'HTRCXDeleteTasks';
     Value: 'group___hi_technic_a_p_i_ga9e4c91b906082bf598bc35a09ebe4a84.html'
    ),
    (
     Name: 'HTRCXDisableOutput';
     Value: 'group___hi_technic_a_p_i_gae0182d5825f9f5e44e94068488a36b8d.html'
    ),
    (
     Name: 'HTRCXEnableOutput';
     Value: 'group___hi_technic_a_p_i_gaa5dd1efce577756a55ae01c2a7b9f7e0.html'
    ),
    (
     Name: 'HTRCXEvent';
     Value: 'group___hi_technic_a_p_i_gabf9152ac52e9e1aa8cac53a595c4e442.html'
    ),
    (
     Name: 'HTRCXFloat';
     Value: 'group___hi_technic_a_p_i_ga2d8fdd30a569c5748d1048867ddc62f5.html'
    ),
    (
     Name: 'HTRCXFwd';
     Value: 'group___hi_technic_a_p_i_gaa5dae3c88923b3185910e3923c3acd94.html'
    ),
    (
     Name: 'HTRCXIncCounter';
     Value: 'group___hi_technic_a_p_i_ga4c858cb028de33510febed2345aec524.html'
    ),
    (
     Name: 'HTRCXInvertOutput';
     Value: 'group___hi_technic_a_p_i_ga6b5be24801d17b54d620df15b50fe64f.html'
    ),
    (
     Name: 'HTRCXMuteSound';
     Value: 'group___hi_technic_a_p_i_ga33cbed46c71d555681eab90ff5ae4003.html'
    ),
    (
     Name: 'HTRCXObvertOutput';
     Value: 'group___hi_technic_a_p_i_gaf415f468f2e19331036f9e852b5ffc01.html'
    ),
    (
     Name: 'HTRCXOff';
     Value: 'group___hi_technic_a_p_i_ga3e6e4aca22289c390dff7d2e78d6c5ac.html'
    ),
    (
     Name: 'HTRCXOn';
     Value: 'group___hi_technic_a_p_i_gabd80a1331ceb42689e90f189c03a2294.html'
    ),
    (
     Name: 'HTRCXOnFor';
     Value: 'group___hi_technic_a_p_i_ga8ee6a144e8a74e4bdbcd7e79d1223cac.html'
    ),
    (
     Name: 'HTRCXOnFwd';
     Value: 'group___hi_technic_a_p_i_ga70a0e0677f2c00315a2e496e9dbe078b.html'
    ),
    (
     Name: 'HTRCXOnRev';
     Value: 'group___hi_technic_a_p_i_gaec772182d2d4d22f3879e094f441105d.html'
    ),
    (
     Name: 'HTRCXPBTurnOff';
     Value: 'group___hi_technic_a_p_i_ga9b9a68e34ba3946cb6bdf6599145c743.html'
    ),
    (
     Name: 'HTRCXPing';
     Value: 'group___hi_technic_a_p_i_gabb4ce89fbcc51b1de00a67bf82352fc4.html'
    ),
    (
     Name: 'HTRCXPlaySound';
     Value: 'group___hi_technic_a_p_i_gadfdc8bd92b118bc223764d850d7575e8.html'
    ),
    (
     Name: 'HTRCXPlayTone';
     Value: 'group___hi_technic_a_p_i_gadb67a71d8322dd355d11ffb4c73e1dd1.html'
    ),
    (
     Name: 'HTRCXPlayToneVar';
     Value: 'group___hi_technic_a_p_i_ga6fb550de94af3b8196c0590e6b54a744.html'
    ),
    (
     Name: 'HTRCXRemote';
     Value: 'group___hi_technic_a_p_i_ga971a1eebb17d6baf276578dea47bcc33.html'
    ),
    (
     Name: 'HTRCXRev';
     Value: 'group___hi_technic_a_p_i_ga2fdb47e423b5d837a0f03e21453ae5d5.html'
    ),
    (
     Name: 'HTRCXSelectDisplay';
     Value: 'group___hi_technic_a_p_i_gac7c3e04bfceb8216eb844cb490bf4a6c.html'
    ),
    (
     Name: 'HTRCXSelectProgram';
     Value: 'group___hi_technic_a_p_i_gaf73993366ac8d1dcabc368b723a8124b.html'
    ),
    (
     Name: 'HTRCXSendSerial';
     Value: 'group___hi_technic_a_p_i_gaa648159aa86487b4925d2e773b5077dc.html'
    ),
    (
     Name: 'HTRCXSetDirection';
     Value: 'group___hi_technic_a_p_i_ga17f12d14dca7773525ac4da0f02e5809.html'
    ),
    (
     Name: 'HTRCXSetEvent';
     Value: 'group___hi_technic_a_p_i_gafaa975491b06b944ba3da2fc4de35113.html'
    ),
    (
     Name: 'HTRCXSetGlobalDirection';
     Value: 'group___hi_technic_a_p_i_ga489eec8156c8b0e7494abd142f84d33e.html'
    ),
    (
     Name: 'HTRCXSetGlobalOutput';
     Value: 'group___hi_technic_a_p_i_ga109c4f1c17b5727a1c0dc4810ce4428e.html'
    ),
    (
     Name: 'HTRCXSetMaxPower';
     Value: 'group___hi_technic_a_p_i_ga2bce3654037a08e9ef3918922e9c5109.html'
    ),
    (
     Name: 'HTRCXSetMessage';
     Value: 'group___hi_technic_a_p_i_ga5d0e6689a9aae6a7826c1e451e255944.html'
    ),
    (
     Name: 'HTRCXSetOutput';
     Value: 'group___hi_technic_a_p_i_ga18769c6dd7ced62d755ac732502ec981.html'
    ),
    (
     Name: 'HTRCXSetPower';
     Value: 'group___hi_technic_a_p_i_ga44575c8a4439e6042e565b47571e78b9.html'
    ),
    (
     Name: 'HTRCXSetPriority';
     Value: 'group___hi_technic_a_p_i_gaca40ea74d558dae8184fc5faf99ebf46.html'
    ),
    (
     Name: 'HTRCXSetSensorMode';
     Value: 'group___hi_technic_a_p_i_ga5e1feed4991e77abf0e5b962360b484d.html'
    ),
    (
     Name: 'HTRCXSetSensorType';
     Value: 'group___hi_technic_a_p_i_gacb0d99b1d0250d6809054d9dc54f714b.html'
    ),
    (
     Name: 'HTRCXSetSleepTime';
     Value: 'group___hi_technic_a_p_i_gabca7914b1d31026f1093d33dc493c80c.html'
    ),
    (
     Name: 'HTRCXSetTxPower';
     Value: 'group___hi_technic_a_p_i_gad23894a1f6aedea0603ec60bd82b1dac.html'
    ),
    (
     Name: 'HTRCXSetWatch';
     Value: 'group___hi_technic_a_p_i_ga05b8869ad910118771d054c7d68cf12d.html'
    ),
    (
     Name: 'HTRCXStartTask';
     Value: 'group___hi_technic_a_p_i_ga728dfb37aac27cff402b52d2469db384.html'
    ),
    (
     Name: 'HTRCXStopAllTasks';
     Value: 'group___hi_technic_a_p_i_ga8005885831ee18b09b1d568f486b6b5b.html'
    ),
    (
     Name: 'HTRCXStopTask';
     Value: 'group___hi_technic_a_p_i_ga95da9f3db99b8b677d8e55fad4b0ece0.html'
    ),
    (
     Name: 'HTRCXToggle';
     Value: 'group___hi_technic_a_p_i_gadd71f25e94dc99e8cad6ea2270720cdf.html'
    ),
    (
     Name: 'HTRCXUnmuteSound';
     Value: 'group___hi_technic_a_p_i_gaf126862e9e7eb07d8ebf25d98031837c.html'
    ),
    (
     Name: 'HTScoutCalibrateSensor';
     Value: 'group___hi_technic_a_p_i_ga3075adb9a5b64370fa67431c606fce48.html'
    ),
    (
     Name: 'HTScoutMuteSound';
     Value: 'group___hi_technic_a_p_i_gacefe2c441127804f9d5d3c2d902cece4.html'
    ),
    (
     Name: 'HTScoutSelectSounds';
     Value: 'group___hi_technic_a_p_i_gaa2310c74fdb59923969297bb1ba8941d.html'
    ),
    (
     Name: 'HTScoutSendVLL';
     Value: 'group___hi_technic_a_p_i_ga7aaad513325f7aafe05a4d67408c6bd3.html'
    ),
    (
     Name: 'HTScoutSetEventFeedback';
     Value: 'group___hi_technic_a_p_i_ga2c5dac0f4ca6e536df3d830f52b4a75a.html'
    ),
    (
     Name: 'HTScoutSetLight';
     Value: 'group___hi_technic_a_p_i_ga94f81a2f6690ec81fd653b3f33906393.html'
    ),
    (
     Name: 'HTScoutSetScoutMode';
     Value: 'group___hi_technic_a_p_i_gafa06b5762c944c7f5e9d64a126ef0cfe.html'
    ),
    (
     Name: 'HTScoutSetSensorClickTime';
     Value: 'group___hi_technic_a_p_i_ga9f24e2abb821bd6bb6cf465c682d76ad.html'
    ),
    (
     Name: 'HTScoutSetSensorHysteresis';
     Value: 'group___hi_technic_a_p_i_gad6841b46176fdd709c2b44ded1cee76f.html'
    ),
    (
     Name: 'HTScoutSetSensorLowerLimit';
     Value: 'group___hi_technic_a_p_i_gab6f651aed501517fd41306f18cef8c7a.html'
    ),
    (
     Name: 'HTScoutSetSensorUpperLimit';
     Value: 'group___hi_technic_a_p_i_ga91438bbc6e2f46eebe3ca8fd4b080e6e.html'
    ),
    (
     Name: 'HTScoutUnmuteSound';
     Value: 'group___hi_technic_a_p_i_gaab487282e32d152c8e57e2774f6ba1de.html'
    ),
    (
     Name: 'SetSensorMSPressure';
     Value: 'group___mind_sensors_a_p_i_ga303fc25c8e11965796bd06f553d8f1ae.html'
    ),
    (
     Name: 'SetSensorMSDROD';
     Value: 'group___mind_sensors_a_p_i_ga993ab384a7353851c077d81191c34581.html'
    ),
    (
     Name: 'SensorMSPressure';
     Value: 'group___mind_sensors_a_p_i_ga6b50d16038277c477abac03df8a17983.html'
    ),
    (
     Name: 'SensorMSCompass';
     Value: 'group___mind_sensors_a_p_i_ga397d5dacc50adf1091b8d932dc77aa08.html'
    ),
    (
     Name: 'SensorMSCompassEx';
     Value: 'group___mind_sensors_a_p_i_ga2baf571c1002fc867b7f8a2b1b7145dc.html'
    ),
    (
     Name: 'SensorMSDROD';
     Value: 'group___mind_sensors_a_p_i_gacb172fcc9e6707d7ee159760212dff59.html'
    ),
    (
     Name: 'SensorMSPressureRaw';
     Value: 'group___mind_sensors_a_p_i_ga2af490eb0d3319e6970e47737f0c39c9.html'
    ),
    (
     Name: 'ReadSensorMSAccel';
     Value: 'group___mind_sensors_a_p_i_ga384105eabf66c486b173d73cced2a98f.html'
    ),
    (
     Name: 'ReadSensorMSAccelEx';
     Value: 'group___mind_sensors_a_p_i_ga144d97cfd67bdc762d18cf62a212fa44.html'
    ),
    (
     Name: 'ReadSensorMSPlayStation';
     Value: 'group___mind_sensors_a_p_i_ga4c6bbe91b0203146fb6f58347addd5a4.html'
    ),
    (
     Name: 'ReadSensorMSPlayStationEx';
     Value: 'group___mind_sensors_a_p_i_gafb8db01475956bf5212a13ef1e4f9d7f.html'
    ),
    (
     Name: 'ReadSensorMSRTClock';
     Value: 'group___mind_sensors_a_p_i_ga624aefb799d7f5d3184347179f14f0e4.html'
    ),
    (
     Name: 'ReadSensorMSTilt';
     Value: 'group___mind_sensors_a_p_i_ga3f8d0b9da7cfaff99e030a8991685310.html'
    ),
    (
     Name: 'ReadSensorMSTiltEx';
     Value: 'group___mind_sensors_a_p_i_ga28208f617be209a168ad3286448f3847.html'
    ),
    (
     Name: 'MSReadValue';
     Value: 'group___mind_sensors_a_p_i_gad74898de27308feb6813c3839d25dc59.html'
    ),
    (
     Name: 'MSReadValueEx';
     Value: 'group___mind_sensors_a_p_i_ga26d7d079a1fc8488aecca73c46a7335c.html'
    ),
    (
     Name: 'MSEnergize';
     Value: 'group___mind_sensors_a_p_i_ga24ac8d9a20f211ecef4c950e10dc09c7.html'
    ),
    (
     Name: 'MSEnergizeEx';
     Value: 'group___mind_sensors_a_p_i_gad6710978b098db1b1df28c750bca233f.html'
    ),
    (
     Name: 'MSDeenergize';
     Value: 'group___mind_sensors_a_p_i_ga8dd690bf22ef37449c6060ed4dd3264b.html'
    ),
    (
     Name: 'MSDeenergizeEx';
     Value: 'group___mind_sensors_a_p_i_gaac8a49b0c1353cca60ad6a73766a401f.html'
    ),
    (
     Name: 'MSADPAOn';
     Value: 'group___mind_sensors_a_p_i_gad14fba048fcc2edac04315ade29340ac.html'
    ),
    (
     Name: 'MSADPAOnEx';
     Value: 'group___mind_sensors_a_p_i_ga118eac1fe62bf9d476a8a49b7fd39b3f.html'
    ),
    (
     Name: 'MSADPAOff';
     Value: 'group___mind_sensors_a_p_i_ga5cc0fb2350e2dbc5a28770265b6c214d.html'
    ),
    (
     Name: 'MSADPAOffEx';
     Value: 'group___mind_sensors_a_p_i_ga1ea9e4fcda989a2f6f68d864d4e19a5c.html'
    ),
    (
     Name: 'DISTNxGP2D12';
     Value: 'group___mind_sensors_a_p_i_ga20045465c9d0ec5f20c9bf06603e0d0b.html'
    ),
    (
     Name: 'DISTNxGP2D12Ex';
     Value: 'group___mind_sensors_a_p_i_ga2dfb14de2f109886fa4a9c84c9b29880.html'
    ),
    (
     Name: 'DISTNxGP2D120';
     Value: 'group___mind_sensors_a_p_i_ga446520375939b24af472492e6d800eb4.html'
    ),
    (
     Name: 'DISTNxGP2D120Ex';
     Value: 'group___mind_sensors_a_p_i_gabffca75446f0f2c28f47b1abdd573c21.html'
    ),
    (
     Name: 'DISTNxGP2YA02';
     Value: 'group___mind_sensors_a_p_i_ga4864a2fff824729bd1233caddafcb912.html'
    ),
    (
     Name: 'DISTNxGP2YA02Ex';
     Value: 'group___mind_sensors_a_p_i_ga2a906af1ec2da506908e51a794e4ada3.html'
    ),
    (
     Name: 'DISTNxGP2YA21';
     Value: 'group___mind_sensors_a_p_i_gab6b98d561aa3652880db864206567aa4.html'
    ),
    (
     Name: 'DISTNxGP2YA21Ex';
     Value: 'group___mind_sensors_a_p_i_ga88fff288543593592831d411cf8fba6c.html'
    ),
    (
     Name: 'DISTNxDistance';
     Value: 'group___mind_sensors_a_p_i_ga981785c965d6639077a92965647a0bab.html'
    ),
    (
     Name: 'DISTNxDistanceEx';
     Value: 'group___mind_sensors_a_p_i_gaecd1ed4c6b9933c5624d7aa4ce83e05c.html'
    ),
    (
     Name: 'DISTNxMaxDistance';
     Value: 'group___mind_sensors_a_p_i_gaa16e1cf1d57781c5d903e900d83bca70.html'
    ),
    (
     Name: 'DISTNxMaxDistanceEx';
     Value: 'group___mind_sensors_a_p_i_ga9675c56c0295eb5f0c41c540df7b610b.html'
    ),
    (
     Name: 'DISTNxMinDistance';
     Value: 'group___mind_sensors_a_p_i_gadf51fb35f8bb69713a98a4b4224524a9.html'
    ),
    (
     Name: 'DISTNxMinDistanceEx';
     Value: 'group___mind_sensors_a_p_i_gab335530adc578901ce66504cb509746b.html'
    ),
    (
     Name: 'DISTNxModuleType';
     Value: 'group___mind_sensors_a_p_i_gaa999931722fc097db26f60e8139f11f6.html'
    ),
    (
     Name: 'DISTNxModuleTypeEx';
     Value: 'group___mind_sensors_a_p_i_gadc287913cfab152ed145439111111beb.html'
    ),
    (
     Name: 'DISTNxNumPoints';
     Value: 'group___mind_sensors_a_p_i_ga6eb702d3505730ea7b26381862a390fe.html'
    ),
    (
     Name: 'DISTNxNumPointsEx';
     Value: 'group___mind_sensors_a_p_i_ga037d3d199b8b9d2df60367926e9babf1.html'
    ),
    (
     Name: 'DISTNxVoltage';
     Value: 'group___mind_sensors_a_p_i_ga4c1bc8e163c37423eff555eb16984103.html'
    ),
    (
     Name: 'DISTNxVoltageEx';
     Value: 'group___mind_sensors_a_p_i_ga01061a27012b43890ecffbde4de0a140.html'
    ),
    (
     Name: 'PSPNxDigital';
     Value: 'group___mind_sensors_a_p_i_ga672077ff5ff4766d9c89790d91de5814.html'
    ),
    (
     Name: 'PSPNxDigitalEx';
     Value: 'group___mind_sensors_a_p_i_ga7ed399172a37ef54999a9ce890d75a05.html'
    ),
    (
     Name: 'PSPNxAnalog';
     Value: 'group___mind_sensors_a_p_i_ga791e0b0a4cd0622068a869707fe7a9d2.html'
    ),
    (
     Name: 'PSPNxAnalogEx';
     Value: 'group___mind_sensors_a_p_i_gaaf91837c892a981f1eb479b74c262c20.html'
    ),
    (
     Name: 'NRLink2400';
     Value: 'group___mind_sensors_a_p_i_ga227f021c3b50d34b1375f6bc6118d9fd.html'
    ),
    (
     Name: 'NRLink2400Ex';
     Value: 'group___mind_sensors_a_p_i_ga5fa84690e1fbcfc86694df710fd40429.html'
    ),
    (
     Name: 'NRLink4800';
     Value: 'group___mind_sensors_a_p_i_ga14a236002935be4da8756219000dcfac.html'
    ),
    (
     Name: 'NRLink4800Ex';
     Value: 'group___mind_sensors_a_p_i_gaf818fbcffd7c6289965d3df671e859ff.html'
    ),
    (
     Name: 'NRLinkFlush';
     Value: 'group___mind_sensors_a_p_i_ga6a773813db0fb5e6a8af691c86a47d56.html'
    ),
    (
     Name: 'NRLinkFlushEx';
     Value: 'group___mind_sensors_a_p_i_ga6add7f58c1845d392954cb8eb70279db.html'
    ),
    (
     Name: 'NRLinkIRLong';
     Value: 'group___mind_sensors_a_p_i_gadffc14e03c60984954f1ee000d102aad.html'
    ),
    (
     Name: 'NRLinkIRLongEx';
     Value: 'group___mind_sensors_a_p_i_gaa2bd84a3b73176a8a761cf175cf1dbf6.html'
    ),
    (
     Name: 'NRLinkIRShort';
     Value: 'group___mind_sensors_a_p_i_gaa565ff17224a1702c300bfca9144a5e4.html'
    ),
    (
     Name: 'NRLinkIRShortEx';
     Value: 'group___mind_sensors_a_p_i_ga9bdf73107aeaeb4e9d9feff667287dac.html'
    ),
    (
     Name: 'NRLinkSetPF';
     Value: 'group___mind_sensors_a_p_i_ga15a8a8ac2a9f44f2bb99507bfa75b082.html'
    ),
    (
     Name: 'NRLinkSetPFEx';
     Value: 'group___mind_sensors_a_p_i_gafc6368a10de6d82a340f0505167481b5.html'
    ),
    (
     Name: 'NRLinkSetRCX';
     Value: 'group___mind_sensors_a_p_i_gad558fee7c5f5135a7f3ee9621370d7a3.html'
    ),
    (
     Name: 'NRLinkSetRCXEx';
     Value: 'group___mind_sensors_a_p_i_gab06c84cdf215b585a8a87b22bd6313ab.html'
    ),
    (
     Name: 'NRLinkSetTrain';
     Value: 'group___mind_sensors_a_p_i_gae21cd408f418dd198a9ac7351e1cdc27.html'
    ),
    (
     Name: 'NRLinkSetTrainEx';
     Value: 'group___mind_sensors_a_p_i_ga813d1ab22e678bd94b662a6ece03d63c.html'
    ),
    (
     Name: 'NRLinkTxRaw';
     Value: 'group___mind_sensors_a_p_i_ga282eb36b8045542aa3579e35c691d423.html'
    ),
    (
     Name: 'NRLinkTxRawEx';
     Value: 'group___mind_sensors_a_p_i_gaa1b01be64c8bbb65419a5ad98291d3a0.html'
    ),
    (
     Name: 'NRLinkStatus';
     Value: 'group___mind_sensors_a_p_i_ga928a1db7c91d31ab5cfa044cbdcd47a0.html'
    ),
    (
     Name: 'NRLinkStatusEx';
     Value: 'group___mind_sensors_a_p_i_gac0471a1dad88fd1e5f96175fedd71fdf.html'
    ),
    (
     Name: 'RunNRLinkMacro';
     Value: 'group___mind_sensors_a_p_i_gaa3f43341748875f5fcce4320cb7a5e4c.html'
    ),
    (
     Name: 'RunNRLinkMacroEx';
     Value: 'group___mind_sensors_a_p_i_gae9ecbe8a70298fd737127f16c7b7978f.html'
    ),
    (
     Name: 'WriteNRLinkBytes';
     Value: 'group___mind_sensors_a_p_i_ga9fcfd7ce1ff4e7ec16b4b2f0aebe195e.html'
    ),
    (
     Name: 'WriteNRLinkBytesEx';
     Value: 'group___mind_sensors_a_p_i_ga5815d75aecabff2862bdcac734d76c4a.html'
    ),
    (
     Name: 'ReadNRLinkBytes';
     Value: 'group___mind_sensors_a_p_i_gaa8757cf8b6d34983843930cf08cd1162.html'
    ),
    (
     Name: 'ReadNRLinkBytesEx';
     Value: 'group___mind_sensors_a_p_i_ga8f5037ccf2754d94cb96e7b69f967b97.html'
    ),
    (
     Name: 'MSIRTrain';
     Value: 'group___mind_sensors_a_p_i_gaa9c64f96b54b8a7dc4eeada46105bd39.html'
    ),
    (
     Name: 'MSIRTrainEx';
     Value: 'group___mind_sensors_a_p_i_gafbb4226ae32a56fe58594213b5518a1d.html'
    ),
    (
     Name: 'MSPFComboDirect';
     Value: 'group___mind_sensors_a_p_i_ga66ffca20f417536c7b62ece948571eff.html'
    ),
    (
     Name: 'MSPFComboDirectEx';
     Value: 'group___mind_sensors_a_p_i_ga13d17d4db1aaa5df5620d88da4274008.html'
    ),
    (
     Name: 'MSPFComboPWM';
     Value: 'group___mind_sensors_a_p_i_ga8eee0ed9ca30b1cafe2025ae060a0b01.html'
    ),
    (
     Name: 'MSPFComboPWMEx';
     Value: 'group___mind_sensors_a_p_i_ga3ac6e455912a09ba0a9766afd1235240.html'
    ),
    (
     Name: 'MSPFRawOutput';
     Value: 'group___mind_sensors_a_p_i_gae11576e34ff1d62f96fa05265e8c3252.html'
    ),
    (
     Name: 'MSPFRawOutputEx';
     Value: 'group___mind_sensors_a_p_i_ga656b5b1894fe7f8277c9d2bb6d73a6d8.html'
    ),
    (
     Name: 'MSPFRepeat';
     Value: 'group___mind_sensors_a_p_i_ga87ee0b4e86275ee54f386947d2cddc68.html'
    ),
    (
     Name: 'MSPFRepeatEx';
     Value: 'group___mind_sensors_a_p_i_gaf2a8b7f2f84a3c0aead076abc345b62b.html'
    ),
    (
     Name: 'MSPFSingleOutputCST';
     Value: 'group___mind_sensors_a_p_i_ga093ebc5096bfd0512a59528533eef17f.html'
    ),
    (
     Name: 'MSPFSingleOutputCSTEx';
     Value: 'group___mind_sensors_a_p_i_gade5f5133e24ce6b33734fff88cbee0b1.html'
    ),
    (
     Name: 'MSPFSingleOutputPWM';
     Value: 'group___mind_sensors_a_p_i_gadbeaedb57e457cf2e551c16b11b59f4a.html'
    ),
    (
     Name: 'MSPFSingleOutputPWMEx';
     Value: 'group___mind_sensors_a_p_i_ga88009da2b94aaf0c6c87d5134e4d69ee.html'
    ),
    (
     Name: 'MSPFSinglePin';
     Value: 'group___mind_sensors_a_p_i_ga9f7f227c5a770ad2c5fda916042d1915.html'
    ),
    (
     Name: 'MSPFSinglePinEx';
     Value: 'group___mind_sensors_a_p_i_ga60b3bea477518b2369c74c7bf241e636.html'
    ),
    (
     Name: 'MSPFTrain';
     Value: 'group___mind_sensors_a_p_i_ga3dfe5ce0d14a0bfb6b3316239ee72c66.html'
    ),
    (
     Name: 'MSPFTrainEx';
     Value: 'group___mind_sensors_a_p_i_ga14cac55b8dff221147c7648585ed2e07.html'
    ),
    (
     Name: 'MSRCXSetNRLinkPort';
     Value: 'group___mind_sensors_a_p_i_gaaed5113f2f6a1c132b55ba97a5e8a8ad.html'
    ),
    (
     Name: 'MSRCXSetNRLinkPortEx';
     Value: 'group___mind_sensors_a_p_i_gaa1cdb9f14adf5a569370332f29e9a1bf.html'
    ),
    (
     Name: 'MSRCXBatteryLevel';
     Value: 'group___mind_sensors_a_p_i_gac7ef075de7088d57a20166b97a256b45.html'
    ),
    (
     Name: 'MSRCXPoll';
     Value: 'group___mind_sensors_a_p_i_ga6d32f3ddc922a04e19af8c4c216f9920.html'
    ),
    (
     Name: 'MSRCXPollMemory';
     Value: 'group___mind_sensors_a_p_i_ga26e9d7180d55ce82d45399006d862c94.html'
    ),
    (
     Name: 'MSRCXAbsVar';
     Value: 'group___mind_sensors_a_p_i_gab49065ea7ce33aa85f1c854d1fdf890b.html'
    ),
    (
     Name: 'MSRCXAddToDatalog';
     Value: 'group___mind_sensors_a_p_i_gad84aee809f84172d7669c7d8ce327e59.html'
    ),
    (
     Name: 'MSRCXAndVar';
     Value: 'group___mind_sensors_a_p_i_gac2db8ef54ad2067f7610f2f40e137678.html'
    ),
    (
     Name: 'MSRCXBoot';
     Value: 'group___mind_sensors_a_p_i_ga411ed1a834f14384d5b68a0f27fb2854.html'
    ),
    (
     Name: 'MSRCXCalibrateEvent';
     Value: 'group___mind_sensors_a_p_i_ga087024d5d8581212cb62470b75e2b8c5.html'
    ),
    (
     Name: 'MSRCXClearAllEvents';
     Value: 'group___mind_sensors_a_p_i_gafec52d22f643469e67b941ba86afb1bc.html'
    ),
    (
     Name: 'MSRCXClearCounter';
     Value: 'group___mind_sensors_a_p_i_ga15d75034d7fd58846e1b811118687622.html'
    ),
    (
     Name: 'MSRCXClearMsg';
     Value: 'group___mind_sensors_a_p_i_gaf64070ed7e6b8a7495f520f4d9d0afe0.html'
    ),
    (
     Name: 'MSRCXClearSensor';
     Value: 'group___mind_sensors_a_p_i_ga75c93c7201ef07b976db11996210cf9c.html'
    ),
    (
     Name: 'MSRCXClearSound';
     Value: 'group___mind_sensors_a_p_i_ga94790d6dd64362e3eb3a11fcf964920a.html'
    ),
    (
     Name: 'MSRCXClearTimer';
     Value: 'group___mind_sensors_a_p_i_ga1a6f2dfa36cf4d3a2a23de472d032f28.html'
    ),
    (
     Name: 'MSRCXCreateDatalog';
     Value: 'group___mind_sensors_a_p_i_ga7394ae627171f3c3813e2a9c32272123.html'
    ),
    (
     Name: 'MSRCXDecCounter';
     Value: 'group___mind_sensors_a_p_i_ga8411df188eaf9e688c77165610da27ba.html'
    ),
    (
     Name: 'MSRCXDeleteSub';
     Value: 'group___mind_sensors_a_p_i_gaaa4590fda6b5f1f6561ca782930625d0.html'
    ),
    (
     Name: 'MSRCXDeleteSubs';
     Value: 'group___mind_sensors_a_p_i_gaf1dc8f8b056912a9caa869fec0cb97da.html'
    ),
    (
     Name: 'MSRCXDeleteTask';
     Value: 'group___mind_sensors_a_p_i_ga6b4f0cadf988ae365dd4293ec3b66a02.html'
    ),
    (
     Name: 'MSRCXDeleteTasks';
     Value: 'group___mind_sensors_a_p_i_ga1ecd20ff9a8929f66cf70a6696fc762f.html'
    ),
    (
     Name: 'MSRCXDisableOutput';
     Value: 'group___mind_sensors_a_p_i_gab8dcb76fd804493632bad8b7e19a8a3d.html'
    ),
    (
     Name: 'MSRCXDivVar';
     Value: 'group___mind_sensors_a_p_i_ga1796258df9d64b83c1f7b27f8bb9e5dd.html'
    ),
    (
     Name: 'MSRCXEnableOutput';
     Value: 'group___mind_sensors_a_p_i_gab662147fcf332c0a9960cd7ae925def1.html'
    ),
    (
     Name: 'MSRCXEvent';
     Value: 'group___mind_sensors_a_p_i_ga567751ce237a9b1a0c62bef226af5c89.html'
    ),
    (
     Name: 'MSRCXFloat';
     Value: 'group___mind_sensors_a_p_i_ga62c73c9e955bde83d274ad72f4452df7.html'
    ),
    (
     Name: 'MSRCXFwd';
     Value: 'group___mind_sensors_a_p_i_ga729c738a954632b8b24b4d6156fd0007.html'
    ),
    (
     Name: 'MSRCXIncCounter';
     Value: 'group___mind_sensors_a_p_i_gab0b283636d0511430623f3ab7491b1be.html'
    ),
    (
     Name: 'MSRCXInvertOutput';
     Value: 'group___mind_sensors_a_p_i_ga64ac6e384141716df78a39f74d2e159f.html'
    ),
    (
     Name: 'MSRCXMulVar';
     Value: 'group___mind_sensors_a_p_i_gafb98e7bb2295042d025914e0ecbede66.html'
    ),
    (
     Name: 'MSRCXMuteSound';
     Value: 'group___mind_sensors_a_p_i_ga72dcc2e9c88061b0e6bfb0d3811d5b3c.html'
    ),
    (
     Name: 'MSRCXObvertOutput';
     Value: 'group___mind_sensors_a_p_i_ga4fe504dfc2523b6ab157c2653c653974.html'
    ),
    (
     Name: 'MSRCXOff';
     Value: 'group___mind_sensors_a_p_i_ga4b7c2549c5e12aaa32661938279b740f.html'
    ),
    (
     Name: 'MSRCXOn';
     Value: 'group___mind_sensors_a_p_i_gaa71f682b946ad2e9472f5cee496b4016.html'
    ),
    (
     Name: 'MSRCXOnFor';
     Value: 'group___mind_sensors_a_p_i_ga02a2511f8b6c0e6e88749140e6fbce1d.html'
    ),
    (
     Name: 'MSRCXOnFwd';
     Value: 'group___mind_sensors_a_p_i_ga0dc6207aeddd42da225f1a65ea2202b3.html'
    ),
    (
     Name: 'MSRCXOnRev';
     Value: 'group___mind_sensors_a_p_i_gac67b55f0a1d117e478ae72ea7d8d1f68.html'
    ),
    (
     Name: 'MSRCXOrVar';
     Value: 'group___mind_sensors_a_p_i_ga6fcc33477afda64e12514c95a53f362f.html'
    ),
    (
     Name: 'MSRCXPBTurnOff';
     Value: 'group___mind_sensors_a_p_i_ga2f7cbf2d093546825199e71be297d811.html'
    ),
    (
     Name: 'MSRCXPing';
     Value: 'group___mind_sensors_a_p_i_gad2566941e3eef6fe5087b0e10ef5bc24.html'
    ),
    (
     Name: 'MSRCXPlaySound';
     Value: 'group___mind_sensors_a_p_i_gade49a0c8179c959083650ab23b857421.html'
    ),
    (
     Name: 'MSRCXPlayTone';
     Value: 'group___mind_sensors_a_p_i_ga647d78b972a2d3f68fefbe97c217fff1.html'
    ),
    (
     Name: 'MSRCXPlayToneVar';
     Value: 'group___mind_sensors_a_p_i_gaa0c7a89281b28a67b3cee8ca6ff68545.html'
    ),
    (
     Name: 'MSRCXRemote';
     Value: 'group___mind_sensors_a_p_i_ga23ebdc5a76579cb785efa0080a3f7c25.html'
    ),
    (
     Name: 'MSRCXReset';
     Value: 'group___mind_sensors_a_p_i_ga65e48d6c125b9ecf46f4e8df7ae598b2.html'
    ),
    (
     Name: 'MSRCXRev';
     Value: 'group___mind_sensors_a_p_i_ga5ab1ac1f92d0b3ffdc5406f8d8dae538.html'
    ),
    (
     Name: 'MSRCXSelectDisplay';
     Value: 'group___mind_sensors_a_p_i_ga316c048f2c7e17de489e22ccf4c7933e.html'
    ),
    (
     Name: 'MSRCXSelectProgram';
     Value: 'group___mind_sensors_a_p_i_ga604c88ec4e6ec5fc1f4543f2f4803850.html'
    ),
    (
     Name: 'MSRCXSendSerial';
     Value: 'group___mind_sensors_a_p_i_gab48ec237399a9281181321ce289d13b7.html'
    ),
    (
     Name: 'MSRCXSet';
     Value: 'group___mind_sensors_a_p_i_gaa294dbd95240cd862f80984298fd12a4.html'
    ),
    (
     Name: 'MSRCXSetDirection';
     Value: 'group___mind_sensors_a_p_i_ga75e8165e32650497a3aaa1d4610fce04.html'
    ),
    (
     Name: 'MSRCXSetEvent';
     Value: 'group___mind_sensors_a_p_i_ga9c12502e42609b41cda4fefd88938d06.html'
    ),
    (
     Name: 'MSRCXSetGlobalDirection';
     Value: 'group___mind_sensors_a_p_i_ga9284855db34bfc5defcf40e47b2cf735.html'
    ),
    (
     Name: 'MSRCXSetGlobalOutput';
     Value: 'group___mind_sensors_a_p_i_gabd3e7ebc42eb222e18b9cac288619f9d.html'
    ),
    (
     Name: 'MSRCXSetMaxPower';
     Value: 'group___mind_sensors_a_p_i_ga295f3c95eaeac31d63f06b8e28d1fde7.html'
    ),
    (
     Name: 'MSRCXSetMessage';
     Value: 'group___mind_sensors_a_p_i_gac788a01ad1fa75e2714061f4cded6ea7.html'
    ),
    (
     Name: 'MSRCXSetOutput';
     Value: 'group___mind_sensors_a_p_i_ga2914f93567a03e6347b51e8f4179b252.html'
    ),
    (
     Name: 'MSRCXSetPower';
     Value: 'group___mind_sensors_a_p_i_ga94ad2b282df96eddf6cb59c5f9515035.html'
    ),
    (
     Name: 'MSRCXSetPriority';
     Value: 'group___mind_sensors_a_p_i_ga406b08ba3f3ffaef6a47006fa6721e85.html'
    ),
    (
     Name: 'MSRCXSetSensorMode';
     Value: 'group___mind_sensors_a_p_i_ga77cd94791881ae1e0b762301fd1d1f93.html'
    ),
    (
     Name: 'MSRCXSetSensorType';
     Value: 'group___mind_sensors_a_p_i_gad83563ce5eecefb5ccff466d1ff93e0a.html'
    ),
    (
     Name: 'MSRCXSetSleepTime';
     Value: 'group___mind_sensors_a_p_i_gaa267840a804a659a043616a9d07c064e.html'
    ),
    (
     Name: 'MSRCXSetTxPower';
     Value: 'group___mind_sensors_a_p_i_gaa206c0f567d673f3f2789fc19c2b9c89.html'
    ),
    (
     Name: 'MSRCXSetUserDisplay';
     Value: 'group___mind_sensors_a_p_i_gad96a072e66cfd5f26b465093deaacc24.html'
    ),
    (
     Name: 'MSRCXSetVar';
     Value: 'group___mind_sensors_a_p_i_gaf8ee7e8a8027f82611560f3770883d3c.html'
    ),
    (
     Name: 'MSRCXSetWatch';
     Value: 'group___mind_sensors_a_p_i_ga58b10a5143cc20f79667732232c8a9c6.html'
    ),
    (
     Name: 'MSRCXSgnVar';
     Value: 'group___mind_sensors_a_p_i_gac57c43f712247b60861cbaa9910492c5.html'
    ),
    (
     Name: 'MSRCXStartTask';
     Value: 'group___mind_sensors_a_p_i_ga742a5847f758468765a34cc20adfafc3.html'
    ),
    (
     Name: 'MSRCXStopAllTasks';
     Value: 'group___mind_sensors_a_p_i_ga2454e2883eb53b8b1c6a60eefc138717.html'
    ),
    (
     Name: 'MSRCXStopTask';
     Value: 'group___mind_sensors_a_p_i_ga5d86ff25985d1d1f16cd3e4512e2e52d.html'
    ),
    (
     Name: 'MSRCXSubVar';
     Value: 'group___mind_sensors_a_p_i_ga255644bcb5ba408a2e2ebb74eb36dcd5.html'
    ),
    (
     Name: 'MSRCXSumVar';
     Value: 'group___mind_sensors_a_p_i_ga5d2f4d0f68e5d9b7fd0f12b41df7cb92.html'
    ),
    (
     Name: 'MSRCXToggle';
     Value: 'group___mind_sensors_a_p_i_gaccdd2732975ce6ca25b33056627492e3.html'
    ),
    (
     Name: 'MSRCXUnlock';
     Value: 'group___mind_sensors_a_p_i_gaba416a52acb9c2e11d1207d2f8a3b735.html'
    ),
    (
     Name: 'MSRCXUnmuteSound';
     Value: 'group___mind_sensors_a_p_i_ga25a302da0335827083572eb5e64f7ab0.html'
    ),
    (
     Name: 'MSScoutCalibrateSensor';
     Value: 'group___mind_sensors_a_p_i_gaa556176760f1ae8149c5afc46f0c4333.html'
    ),
    (
     Name: 'MSScoutMuteSound';
     Value: 'group___mind_sensors_a_p_i_gafce155997b0255253db4d90c99fab9b5.html'
    ),
    (
     Name: 'MSScoutSelectSounds';
     Value: 'group___mind_sensors_a_p_i_ga27d981cf9e67733785889b68140e404f.html'
    ),
    (
     Name: 'MSScoutSendVLL';
     Value: 'group___mind_sensors_a_p_i_ga26ff6a651be0d56222f8b8c20e068e2d.html'
    ),
    (
     Name: 'MSScoutSetCounterLimit';
     Value: 'group___mind_sensors_a_p_i_gaf5b373b0dd0ada6e2751cc484340ca52.html'
    ),
    (
     Name: 'MSScoutSetEventFeedback';
     Value: 'group___mind_sensors_a_p_i_ga3b209a691631d897dd049c94be1586e3.html'
    ),
    (
     Name: 'MSScoutSetLight';
     Value: 'group___mind_sensors_a_p_i_ga221b1f1c782d72e03a6d5bdd8db849d3.html'
    ),
    (
     Name: 'MSScoutSetScoutMode';
     Value: 'group___mind_sensors_a_p_i_ga23a42585d8d12425924dae5d5cedd7bb.html'
    ),
    (
     Name: 'MSScoutSetScoutRules';
     Value: 'group___mind_sensors_a_p_i_ga802967ec515e105dd3692892f8ae0aa7.html'
    ),
    (
     Name: 'MSScoutSetSensorClickTime';
     Value: 'group___mind_sensors_a_p_i_ga08889fffc2605b478ff3c9779feb7b42.html'
    ),
    (
     Name: 'MSScoutSetSensorHysteresis';
     Value: 'group___mind_sensors_a_p_i_ga1288377f9a825dec60c963400664b7e8.html'
    ),
    (
     Name: 'MSScoutSetSensorLowerLimit';
     Value: 'group___mind_sensors_a_p_i_ga303ddcf09957eb8ac35f956a1cf23174.html'
    ),
    (
     Name: 'MSScoutSetSensorUpperLimit';
     Value: 'group___mind_sensors_a_p_i_ga8f6e7407524df88e8d9f6ee24a0183e3.html'
    ),
    (
     Name: 'MSScoutSetTimerLimit';
     Value: 'group___mind_sensors_a_p_i_ga52f3e695d9ca51242c0051021b528d36.html'
    ),
    (
     Name: 'MSScoutUnmuteSound';
     Value: 'group___mind_sensors_a_p_i_gaffa127a4a3e3c555fb43f4b2fc9a3e3d.html'
    ),
    (
     Name: 'sqrt';
     Value: 'group__cmath_a_p_i_ga592e5b536e9e1b69f4520e9566521a17.html'
    ),
    (
     Name: 'cos';
     Value: 'group__cmath_a_p_i_ga5e88e48c21b60ac9b58a322cf8a8bb67.html'
    ),
    (
     Name: 'sin';
     Value: 'group__cmath_a_p_i_ga15876915492b5aff219d1dd03ad66def.html'
    ),
    (
     Name: 'tan';
     Value: 'group__cmath_a_p_i_ga26971409112830841bd7c7a0d7681b8a.html'
    ),
    (
     Name: 'acos';
     Value: 'group__cmath_a_p_i_gad3746d6ae34f39dc1929395d6af1ecb1.html'
    ),
    (
     Name: 'asin';
     Value: 'group__cmath_a_p_i_gaf7a153258c174c284724467debb9458c.html'
    ),
    (
     Name: 'atan';
     Value: 'group__cmath_a_p_i_gaa1707595eec76a358520359b4f20267e.html'
    ),
    (
     Name: 'atan2';
     Value: 'group__cmath_a_p_i_gaaf4b636b09041878e1542054c73d81e9.html'
    ),
    (
     Name: 'cosh';
     Value: 'group__cmath_a_p_i_ga2ebcd12a3f554326958712eb4e298eec.html'
    ),
    (
     Name: 'sinh';
     Value: 'group__cmath_a_p_i_ga2b779d5089ff8362eb9b3d362083de19.html'
    ),
    (
     Name: 'tanh';
     Value: 'group__cmath_a_p_i_gafde1d7d92227ce384c236b80161e11c8.html'
    ),
    (
     Name: 'exp';
     Value: 'group__cmath_a_p_i_ga9b5b75b78eff58c7f376e3ce51e9fdfd.html'
    ),
    (
     Name: 'log';
     Value: 'group__cmath_a_p_i_gad04ff2fafc7559725e22b969af498b7d.html'
    ),
    (
     Name: 'log10';
     Value: 'group__cmath_a_p_i_ga9072957ddf2d504ecc13b926c225ab59.html'
    ),
    (
     Name: 'trunc';
     Value: 'group__cmath_a_p_i_ga7f1b134a8a05d4c24030dd5f61ab895e.html'
    ),
    (
     Name: 'frac';
     Value: 'group__cmath_a_p_i_ga39b5c388cab149413887f1bdbd8b008f.html'
    ),
    (
     Name: 'pow';
     Value: 'group__cmath_a_p_i_ga0cb1b3000989378ad48b37b358adecf2.html'
    ),
    (
     Name: 'ceil';
     Value: 'group__cmath_a_p_i_ga65b86cc953409a678d94f6db9653fd98.html'
    ),
    (
     Name: 'floor';
     Value: 'group__cmath_a_p_i_gada8a2be1464302cc6dda3b2ab19e15ad.html'
    ),
    (
     Name: 'muldiv32';
     Value: 'group__cmath_a_p_i_gab8e6dd993a0e6a1a57dcbee511665c45.html'
    ),
    (
     Name: 'cosd';
     Value: 'group__cmath_a_p_i_ga502f5a841d8d1fcba289e167a1177bda.html'
    ),
    (
     Name: 'sind';
     Value: 'group__cmath_a_p_i_gaf191247f966a40ecf3ee0fe9a717c0f3.html'
    ),
    (
     Name: 'tand';
     Value: 'group__cmath_a_p_i_ga17594ace979a55af690e03333370535c.html'
    ),
    (
     Name: 'acosd';
     Value: 'group__cmath_a_p_i_ga890e7b1e04fc333ebacc7adcc9305f02.html'
    ),
    (
     Name: 'asind';
     Value: 'group__cmath_a_p_i_ga010688f3321fe4059cca19b5be0c0fe3.html'
    ),
    (
     Name: 'atand';
     Value: 'group__cmath_a_p_i_ga99a6dae1b6a0cf075d57c37cff04e907.html'
    ),
    (
     Name: 'atan2d';
     Value: 'group__cmath_a_p_i_ga14462153d28b0ed79cfa18931abf3df6.html'
    ),
    (
     Name: 'coshd';
     Value: 'group__cmath_a_p_i_ga38e161a1ff5f924830acd1ac695fb055.html'
    ),
    (
     Name: 'sinhd';
     Value: 'group__cmath_a_p_i_gab280b957071558d83b8ae9e4ba239417.html'
    ),
    (
     Name: 'tanhd';
     Value: 'group__cmath_a_p_i_gad86c97f3120b2d6d33a193121d74e8d0.html'
    ),
    (
     Name: 'bcd2dec';
     Value: 'group__cmath_a_p_i_ga370ecedca3418d42ec3f2a5e38f08411.html'
    ),
    (
     Name: 'isNAN';
     Value: 'group__cmath_a_p_i_ga0034068ee46f42530598c39757b22038.html'
    ),
    (
     Name: 'sign';
     Value: 'group__cmath_a_p_i_ga90f77c8b3df60383861c2bf620063c74.html'
    ),
    (
     Name: 'Random';
     Value: 'group__cmath_a_p_i_ga7a0e69b48d53c5647f09ab8b80c148b6.html'
    ),
    (
     Name: 'SysRandomNumber';
     Value: 'group__cmath_a_p_i_gab485d2bc34b70873158cae0500683681.html'
    ),
    (
     Name: 'fclose';
     Value: 'group__cstdio_a_p_i_ga78341155278a926a518130763ae9887b.html'
    ),
    (
     Name: 'remove';
     Value: 'group__cstdio_a_p_i_ga058834d925e086875a6b873e1d0ba5fa.html'
    ),
    (
     Name: 'rename';
     Value: 'group__cstdio_a_p_i_ga0ced44d6a8f9acbf1ca0f349b3da3db0.html'
    ),
    (
     Name: 'fgetc';
     Value: 'group__cstdio_a_p_i_gafd54f6047719371cc7a9d9ee1ef96d27.html'
    ),
    (
     Name: 'fgets';
     Value: 'group__cstdio_a_p_i_ga66a374bc9be9c7172e77d7fb314aa5c2.html'
    ),
    (
     Name: 'feof';
     Value: 'group__cstdio_a_p_i_gaf3017f823c03bbc16dd3c66e99f68b52.html'
    ),
    (
     Name: 'fopen';
     Value: 'group__cstdio_a_p_i_ga5d172e1b352898e1a13a836656d70a03.html'
    ),
    (
     Name: 'fflush';
     Value: 'group__cstdio_a_p_i_ga764d9bc83a9e3e8dfef824a646ff59c1.html'
    ),
    (
     Name: 'ftell';
     Value: 'group__cstdio_a_p_i_gab63bd34f14af56e990318f069f23297f.html'
    ),
    (
     Name: 'fputc';
     Value: 'group__cstdio_a_p_i_ga7184413c7de347cb51fcce534af60170.html'
    ),
    (
     Name: 'fputs';
     Value: 'group__cstdio_a_p_i_gaf85c7002f5d8d9ff2c9663d726f28e6d.html'
    ),
    (
     Name: 'printf';
     Value: 'group__cstdio_a_p_i_ga8e7f8b03b05f9affe2dbbbdc3fd0985a.html'
    ),
    (
     Name: 'fprintf';
     Value: 'group__cstdio_a_p_i_ga9c9fc2c8e79988b9bd66aaf71c3344ff.html'
    ),
    (
     Name: 'sprintf';
     Value: 'group__cstdio_a_p_i_ga371602cef541e81b14dc2ffdb0f13539.html'
    ),
    (
     Name: 'fseek';
     Value: 'group__cstdio_a_p_i_gabea819317fe740c7376ca24eaf1225c6.html'
    ),
    (
     Name: 'rewind';
     Value: 'group__cstdio_a_p_i_ga1628898dfcdc94ac664c7a7cafb773b5.html'
    ),
    (
     Name: 'abort';
     Value: 'group__cstdlib_a_p_i_gac54f53dc342019e8db34f4aa581a5792.html'
    ),
    (
     Name: 'abs';
     Value: 'group__cstdlib_a_p_i_gafa60b7b723d42d4d0823518b011d2876.html'
    ),
    (
     Name: 'rand';
     Value: 'group__cstdlib_a_p_i_ga866c3f5e3e89035c3ba01b22d786d8bc.html'
    ),
    (
     Name: 'atof';
     Value: 'group__cstdlib_a_p_i_ga98ed4a3e898eb3faa8707ffe8a770644.html'
    ),
    (
     Name: 'atoi';
     Value: 'group__cstdlib_a_p_i_gaf523a2033f2ca5f7794cb261879e9fe1.html'
    ),
    (
     Name: 'atol';
     Value: 'group__cstdlib_a_p_i_ga3548d4cc5981e10c809f8cdc1e9ef225.html'
    ),
    (
     Name: 'labs';
     Value: 'group__cstdlib_a_p_i_ga3b270e0b7f5c47e2511ecf21dab24b5b.html'
    ),
    (
     Name: 'strtod';
     Value: 'group__cstdlib_a_p_i_gac1db1816f8e8ece593c7a5329636b3c3.html'
    ),
    (
     Name: 'strtol';
     Value: 'group__cstdlib_a_p_i_ga946b010fb3c8e6440d6d18f14d704734.html'
    ),
    (
     Name: 'strtoul';
     Value: 'group__cstdlib_a_p_i_gadff1d9998bc9d54d98c3f7545e3eba37.html'
    ),
    (
     Name: 'div';
     Value: 'group__cstdlib_a_p_i_ga4476a5dc418924ee3ad18ce699581dfd.html'
    ),
    (
     Name: 'ldiv';
     Value: 'group__cstdlib_a_p_i_ga66fb11dc4734db57fdda6f32f3977935.html'
    ),
    (
     Name: 'StrToNum';
     Value: 'group__cstring_a_p_i_ga66139f3a7d68d84bf7527dee102666aa.html'
    ),
    (
     Name: 'StrLen';
     Value: 'group__cstring_a_p_i_ga13b226120fec7be8bcc5dcc477c2776c.html'
    ),
    (
     Name: 'StrIndex';
     Value: 'group__cstring_a_p_i_ga47434e9d95f28a810744cef52622fec0.html'
    ),
    (
     Name: 'NumToStr';
     Value: 'group__cstring_a_p_i_ga4cf4c03b015a26cec27eb7f4baeaaef3.html'
    ),
    (
     Name: 'StrCat';
     Value: 'group__cstring_a_p_i_ga2b29257801af5e2fe7ee06528f9d6b40.html'
    ),
    (
     Name: 'SubStr';
     Value: 'group__cstring_a_p_i_ga35d32335d12e1f453977797ad5a1d861.html'
    ),
    (
     Name: 'Flatten';
     Value: 'group__cstring_a_p_i_ga90c550f699edf34280a5740a25c0c38d.html'
    ),
    (
     Name: 'StrReplace';
     Value: 'group__cstring_a_p_i_ga18c44b704ade62daf30101e2fcca8660.html'
    ),
    (
     Name: 'FormatNum';
     Value: 'group__cstring_a_p_i_gae1e152293a956a9911b3940664b7b9f4.html'
    ),
    (
     Name: 'FlattenVar';
     Value: 'group__cstring_a_p_i_gad05dcd98d787d4497e41a84c3d8a78b6.html'
    ),
    (
     Name: 'UnflattenVar';
     Value: 'group__cstring_a_p_i_ga057308170bd294325c21c7ed0db989db.html'
    ),
    (
     Name: 'ByteArrayToStr';
     Value: 'group__cstring_a_p_i_ga9605bc4543e9a4d67b13b551ed06d859.html'
    ),
    (
     Name: 'ByteArrayToStrEx';
     Value: 'group__cstring_a_p_i_ga4bdbcfda25ea32caf850346be215df23.html'
    ),
    (
     Name: 'StrToByteArray';
     Value: 'group__cstring_a_p_i_gaa0c0df9844525dd7ce7ed39fb63bda47.html'
    ),
    (
     Name: 'Copy';
     Value: 'group__cstring_a_p_i_gabc76adbaa747c5c30b3412ac10092d8a.html'
    ),
    (
     Name: 'MidStr';
     Value: 'group__cstring_a_p_i_ga3e2a0a753a474359d5d92cf82411e664.html'
    ),
    (
     Name: 'RightStr';
     Value: 'group__cstring_a_p_i_gae6de656a583e8c6153a74da1cc7ae7ac.html'
    ),
    (
     Name: 'LeftStr';
     Value: 'group__cstring_a_p_i_gac2c5cae82d07e975fcf30cd3ff3a20ef.html'
    ),
    (
     Name: 'strlen';
     Value: 'group__cstring_a_p_i_gae61811f057680a116e4cf4dc5ca6e656.html'
    ),
    (
     Name: 'strcat';
     Value: 'group__cstring_a_p_i_gaec7ca6ec01a3aeff44b437bf26dd032e.html'
    ),
    (
     Name: 'strncat';
     Value: 'group__cstring_a_p_i_ga725fde606db880b95a8248aaf205817b.html'
    ),
    (
     Name: 'strcpy';
     Value: 'group__cstring_a_p_i_ga3de92c10ed9dd0a72d79e8351d6bfdba.html'
    ),
    (
     Name: 'strncpy';
     Value: 'group__cstring_a_p_i_ga1c5956e682a5c31dd09ea4cfc1e7e3b1.html'
    ),
    (
     Name: 'strcmp';
     Value: 'group__cstring_a_p_i_ga243861c2298764c4abf28bbb58ca7663.html'
    ),
    (
     Name: 'strncmp';
     Value: 'group__cstring_a_p_i_ga337c73015b829b6cc19efd9894f4cb97.html'
    ),
    (
     Name: 'memcpy';
     Value: 'group__cstring_a_p_i_ga15f3cb261c6b0b54ee6aa4dcb95097da.html'
    ),
    (
     Name: 'memmove';
     Value: 'group__cstring_a_p_i_gaa785929d7471cb3fe8b33fcca62d5958.html'
    ),
    (
     Name: 'memcmp';
     Value: 'group__cstring_a_p_i_ga35b031b0ba754f880e5d0152634f77d8.html'
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
     Name: '$##@$@#$@#$@$';
     Value: '$##@$@#$@#$@$'
    )
  );

implementation

end.
