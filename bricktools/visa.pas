unit visa;

interface

uses
  VisaDefs;

var
  NIVISA_viClose : function(vi : VisaHandle) : ViStatus; cdecl; // ViObject?
  NIVISA_viSetAttribute : function(vi : VisaHandle; attrName : ViAttr; attrValue : ViAttrState) : ViStatus; cdecl;
  NIVISA_viGetAttribute : function(vi : VisaHandle; attrName : ViAttr; var attrValue : ViAttrState) : ViStatus; cdecl;
//  NIVISA_viStatusDesc : function(vi : VisaHandle; status : ViStatus; desc : PChar) : ViStatus; cdedl;
//  NIVISA_viTerminate : function(vi : VisaHandle; degree : Word; jobId : ViJobId) : ViStatus; cdecl;
  NIVISA_viOpenDefaultRM : function(var vi : VisaHandle) : ViStatus; cdecl;

const
  // Completion and Error Codes
  VI_SUCCESS          = $0;

  // Other VISA Definitions
  VI_NULL             = 0;
  VI_TRUE             = 1;
  VI_FALSE            = 0;

  //  Attributes (platform independent size)
  VI_ATTR_RSRC_CLASS          = $BFFF0001;
  VI_ATTR_RSRC_NAME           = $BFFF0002;
  VI_ATTR_RSRC_IMPL_VERSION   = $3FFF0003;
  VI_ATTR_RSRC_LOCK_STATE     = $3FFF0004;
  VI_ATTR_MAX_QUEUE_LENGTH    = $3FFF0005;
  VI_ATTR_USER_DATA_32        = $3FFF0007;
  VI_ATTR_FDC_CHNL            = $3FFF000D;
  VI_ATTR_FDC_MODE            = $3FFF000F;
  VI_ATTR_FDC_GEN_SIGNAL_EN   = $3FFF0011;
  VI_ATTR_FDC_USE_PAIR        = $3FFF0013;
  VI_ATTR_SEND_END_EN         = $3FFF0016;
  VI_ATTR_TERMCHAR            = $3FFF0018;
  VI_ATTR_TMO_VALUE           = $3FFF001A;
  VI_ATTR_GPIB_READDR_EN      = $3FFF001B;
  VI_ATTR_IO_PROT             = $3FFF001C;
  VI_ATTR_DMA_ALLOW_EN        = $3FFF001E;
  VI_ATTR_ASRL_BAUD           = $3FFF0021;
  VI_ATTR_ASRL_DATA_BITS      = $3FFF0022;
  VI_ATTR_ASRL_PARITY         = $3FFF0023;
  VI_ATTR_ASRL_STOP_BITS      = $3FFF0024;
  VI_ATTR_ASRL_FLOW_CNTRL     = $3FFF0025;
  VI_ATTR_RD_BUF_OPER_MODE    = $3FFF002A;
  VI_ATTR_RD_BUF_SIZE         = $3FFF002B;
  VI_ATTR_WR_BUF_OPER_MODE    = $3FFF002D;
  VI_ATTR_WR_BUF_SIZE         = $3FFF002E;
  VI_ATTR_SUPPRESS_END_EN     = $3FFF0036;
  VI_ATTR_TERMCHAR_EN         = $3FFF0038;
  VI_ATTR_DEST_ACCESS_PRIV    = $3FFF0039;
  VI_ATTR_DEST_BYTE_ORDER     = $3FFF003A;
  VI_ATTR_SRC_ACCESS_PRIV     = $3FFF003C;
  VI_ATTR_SRC_BYTE_ORDER      = $3FFF003D;
  VI_ATTR_SRC_INCREMENT       = $3FFF0040;
  VI_ATTR_DEST_INCREMENT      = $3FFF0041;
  VI_ATTR_WIN_ACCESS_PRIV     = $3FFF0045;
  VI_ATTR_WIN_BYTE_ORDER      = $3FFF0047;
  VI_ATTR_GPIB_ATN_STATE      = $3FFF0057;
  VI_ATTR_GPIB_ADDR_STATE     = $3FFF005C;
  VI_ATTR_GPIB_CIC_STATE      = $3FFF005E;
  VI_ATTR_GPIB_NDAC_STATE     = $3FFF0062;
  VI_ATTR_GPIB_SRQ_STATE      = $3FFF0067;
  VI_ATTR_GPIB_SYS_CNTRL_STATE = $3FFF0068;
  VI_ATTR_GPIB_HS488_CBL_LEN  = $3FFF0069;
  VI_ATTR_CMDR_LA             = $3FFF006B;
  VI_ATTR_VXI_DEV_CLASS       = $3FFF006C;
  VI_ATTR_MAINFRAME_LA        = $3FFF0070;
  VI_ATTR_MANF_NAME           = $BFFF0072;
  VI_ATTR_MODEL_NAME          = $BFFF0077;
  VI_ATTR_VXI_VME_INTR_STATUS = $3FFF008B;
  VI_ATTR_VXI_TRIG_STATUS     = $3FFF008D;
  VI_ATTR_VXI_VME_SYSFAIL_STATE = $3FFF0094;
  VI_ATTR_WIN_BASE_ADDR_32    = $3FFF0098;
  VI_ATTR_WIN_SIZE_32         = $3FFF009A;
  VI_ATTR_ASRL_AVAIL_NUM      = $3FFF00AC;
  VI_ATTR_MEM_BASE_32         = $3FFF00AD;
  VI_ATTR_ASRL_CTS_STATE      = $3FFF00AE;
  VI_ATTR_ASRL_DCD_STATE      = $3FFF00AF;
  VI_ATTR_ASRL_DSR_STATE      = $3FFF00B1;
  VI_ATTR_ASRL_DTR_STATE      = $3FFF00B2;
  VI_ATTR_ASRL_END_IN         = $3FFF00B3;
  VI_ATTR_ASRL_END_OUT        = $3FFF00B4;
  VI_ATTR_ASRL_REPLACE_CHAR   = $3FFF00BE;
  VI_ATTR_ASRL_RI_STATE       = $3FFF00BF;
  VI_ATTR_ASRL_RTS_STATE      = $3FFF00C0;
  VI_ATTR_ASRL_XON_CHAR       = $3FFF00C1;
  VI_ATTR_ASRL_XOFF_CHAR      = $3FFF00C2;
  VI_ATTR_WIN_ACCESS          = $3FFF00C3;
  VI_ATTR_RM_SESSION          = $3FFF00C4;
  VI_ATTR_VXI_LA              = $3FFF00D5;
  VI_ATTR_MANF_ID             = $3FFF00D9;
  VI_ATTR_MEM_SIZE_32         = $3FFF00DD;
  VI_ATTR_MEM_SPACE           = $3FFF00DE;
  VI_ATTR_MODEL_CODE          = $3FFF00DF;
  VI_ATTR_SLOT                = $3FFF00E8;
  VI_ATTR_INTF_INST_NAME      = $BFFF00E9;
  VI_ATTR_IMMEDIATE_SERV      = $3FFF0100;
  VI_ATTR_INTF_PARENT_NUM     = $3FFF0101;
  VI_ATTR_RSRC_SPEC_VERSION   = $3FFF0170;
  VI_ATTR_INTF_TYPE           = $3FFF0171;
  VI_ATTR_GPIB_PRIMARY_ADDR   = $3FFF0172;
  VI_ATTR_GPIB_SECONDARY_ADDR = $3FFF0173;
  VI_ATTR_RSRC_MANF_NAME      = $BFFF0174;
  VI_ATTR_RSRC_MANF_ID        = $3FFF0175;
  VI_ATTR_INTF_NUM            = $3FFF0176;
  VI_ATTR_TRIG_ID             = $3FFF0177;
  VI_ATTR_GPIB_REN_STATE      = $3FFF0181;
  VI_ATTR_GPIB_UNADDR_EN      = $3FFF0184;
  VI_ATTR_DEV_STATUS_BYTE     = $3FFF0189;
  VI_ATTR_FILE_APPEND_EN      = $3FFF0192;
  VI_ATTR_VXI_TRIG_SUPPORT    = $3FFF0194;
  VI_ATTR_TCPIP_ADDR          = $BFFF0195;
  VI_ATTR_TCPIP_HOSTNAME      = $BFFF0196;
  VI_ATTR_TCPIP_PORT          = $3FFF0197;
  VI_ATTR_TCPIP_DEVICE_NAME   = $BFFF0199;
  VI_ATTR_TCPIP_NODELAY       = $3FFF019A;
  VI_ATTR_TCPIP_KEEPALIVE     = $3FFF019B;
  VI_ATTR_4882_COMPLIANT      = $3FFF019F;
  VI_ATTR_USB_SERIAL_NUM      = $BFFF01A0;
  VI_ATTR_USB_INTFC_NUM       = $3FFF01A1;
  VI_ATTR_USB_PROTOCOL        = $3FFF01A7;
  VI_ATTR_USB_MAX_INTR_SIZE   = $3FFF01AF;
  VI_ATTR_PXI_DEV_NUM         = $3FFF0201;
  VI_ATTR_PXI_FUNC_NUM        = $3FFF0202;
  VI_ATTR_PXI_BUS_NUM         = $3FFF0205;
  VI_ATTR_PXI_CHASSIS         = $3FFF0206;
  VI_ATTR_PXI_SLOTPATH        = $BFFF0207;
  VI_ATTR_PXI_SLOT_LBUS_LEFT  = $3FFF0208;
  VI_ATTR_PXI_SLOT_LBUS_RIGHT = $3FFF0209;
  VI_ATTR_PXI_TRIG_BUS        = $3FFF020A;
  VI_ATTR_PXI_STAR_TRIG_BUS   = $3FFF020B;
  VI_ATTR_PXI_STAR_TRIG_LINE  = $3FFF020C;
  VI_ATTR_PXI_MEM_TYPE_BAR0   = $3FFF0211;
  VI_ATTR_PXI_MEM_TYPE_BAR1   = $3FFF0212;
  VI_ATTR_PXI_MEM_TYPE_BAR2   = $3FFF0213;
  VI_ATTR_PXI_MEM_TYPE_BAR3   = $3FFF0214;
  VI_ATTR_PXI_MEM_TYPE_BAR4   = $3FFF0215;
  VI_ATTR_PXI_MEM_TYPE_BAR5   = $3FFF0216;
  VI_ATTR_PXI_MEM_BASE_BAR0   = $3FFF0221;
  VI_ATTR_PXI_MEM_BASE_BAR1   = $3FFF0222;
  VI_ATTR_PXI_MEM_BASE_BAR2   = $3FFF0223;
  VI_ATTR_PXI_MEM_BASE_BAR3   = $3FFF0224;
  VI_ATTR_PXI_MEM_BASE_BAR4   = $3FFF0225;
  VI_ATTR_PXI_MEM_BASE_BAR5   = $3FFF0226;
  VI_ATTR_PXI_MEM_SIZE_BAR0   = $3FFF0231;
  VI_ATTR_PXI_MEM_SIZE_BAR1   = $3FFF0232;
  VI_ATTR_PXI_MEM_SIZE_BAR2   = $3FFF0233;
  VI_ATTR_PXI_MEM_SIZE_BAR3   = $3FFF0234;
  VI_ATTR_PXI_MEM_SIZE_BAR4   = $3FFF0235;
  VI_ATTR_PXI_MEM_SIZE_BAR5   = $3FFF0236;
  VI_ATTR_PXI_IS_EXPRESS      = $3FFF0240;
  VI_ATTR_PXI_SLOT_LWIDTH     = $3FFF0241;
  VI_ATTR_PXI_MAX_LWIDTH      = $3FFF0242;
  VI_ATTR_PXI_ACTUAL_LWIDTH   = $3FFF0243;
  VI_ATTR_PXI_DSTAR_BUS       = $3FFF0244;
  VI_ATTR_PXI_DSTAR_SET       = $3FFF0245;
  VI_ATTR_JOB_ID              = $3FFF4006;
  VI_ATTR_EVENT_TYPE          = $3FFF4010;
  VI_ATTR_SIGP_STATUS_ID      = $3FFF4011;
  VI_ATTR_RECV_TRIG_ID        = $3FFF4012;
  VI_ATTR_INTR_STATUS_ID      = $3FFF4023;
  VI_ATTR_STATUS              = $3FFF4025;
  VI_ATTR_RET_COUNT_32        = $3FFF4026;
  VI_ATTR_BUFFER              = $3FFF4027;
  VI_ATTR_RECV_INTR_LEVEL     = $3FFF4041;
  VI_ATTR_OPER_NAME           = $BFFF4042;
  VI_ATTR_GPIB_RECV_CIC_STATE = $3FFF4193;
  VI_ATTR_RECV_TCPIP_ADDR     = $BFFF4198;
  VI_ATTR_USB_RECV_INTR_SIZE  = $3FFF41B0;
  VI_ATTR_USB_RECV_INTR_DATA  = $BFFF41B1;
// other
  VI_FIND_BUFLEN              = 256;
  VI_INTF_GPIB                = 1;
  VI_INTF_VXI                 = 2;
  VI_INTF_GPIB_VXI            = 3;
  VI_INTF_ASRL                = 4;
  VI_INTF_PXI                 = 5;
  VI_INTF_TCPIP               = 6;
  VI_INTF_USB                 = 7;
  VI_PROT_NORMAL              = 1;
  VI_PROT_FDC                 = 2;
  VI_PROT_HS488               = 3;
  VI_PROT_4882_STRS           = 4;
  VI_PROT_USBTMC_VENDOR       = 5;
  VI_FDC_NORMAL               = 1;
  VI_FDC_STREAM               = 2;
  VI_LOCAL_SPACE              = 0;
  VI_A16_SPACE                = 1;
  VI_A24_SPACE                = 2;
  VI_A32_SPACE                = 3;
  VI_A64_SPACE                = 4;
  VI_PXI_ALLOC_SPACE          = 9;
  VI_PXI_CFG_SPACE            = 10;
  VI_PXI_BAR0_SPACE           = 11;
  VI_PXI_BAR1_SPACE           = 12;
  VI_PXI_BAR2_SPACE           = 13;
  VI_PXI_BAR3_SPACE           = 14;
  VI_PXI_BAR4_SPACE           = 15;
  VI_PXI_BAR5_SPACE           = 16;
  VI_OPAQUE_SPACE             = $FFFF;

  VI_UNKNOWN_LA               = -1;
  VI_UNKNOWN_SLOT             = -1;
  VI_UNKNOWN_LEVEL            = -1;
  VI_UNKNOWN_CHASSIS          = -1;

  VI_QUEUE                    = 1;
  VI_HNDLR                    = 2;
  VI_SUSPEND_HNDLR            = 4;
  VI_ALL_MECH                 = $FFFF;

  VI_ANY_HNDLR                = 0;

  VI_TRIG_ALL                 = -2;
  VI_TRIG_SW                  = -1;
  VI_TRIG_TTL0                = 0;
  VI_TRIG_TTL1                = 1;
  VI_TRIG_TTL2                = 2;
  VI_TRIG_TTL3                = 3;
  VI_TRIG_TTL4                = 4;
  VI_TRIG_TTL5                = 5;
  VI_TRIG_TTL6                = 6;
  VI_TRIG_TTL7                = 7;
  VI_TRIG_ECL0                = 8;
  VI_TRIG_ECL1                = 9;
  VI_TRIG_PANEL_IN            = 27;
  VI_TRIG_PANEL_OUT           = 28;

  VI_TRIG_PROT_DEFAULT        = 0;
  VI_TRIG_PROT_ON             = 1;
  VI_TRIG_PROT_OFF            = 2;
  VI_TRIG_PROT_SYNC           = 5;
  VI_TRIG_PROT_RESERVE        = 6;
  VI_TRIG_PROT_UNRESERVE      = 7;

  VI_READ_BUF                 = 1;
  VI_WRITE_BUF                = 2;
  VI_READ_BUF_DISCARD         = 4;
  VI_WRITE_BUF_DISCARD        = 8;
  VI_IO_IN_BUF                = 16;
  VI_IO_OUT_BUF               = 32;
  VI_IO_IN_BUF_DISCARD        = 64;
  VI_IO_OUT_BUF_DISCARD       = 128;

  VI_FLUSH_ON_ACCESS          = 1;
  VI_FLUSH_WHEN_FULL          = 2;
  VI_FLUSH_DISABLE            = 3;

  VI_NMAPPED                  = 1;
  VI_USE_OPERS                = 2;
  VI_DEREF_ADDR               = 3;
  VI_DEREF_ADDR_BYTE_SWAP     = 4;

  VI_TMO_IMMEDIATE            = 0;
  VI_TMO_INFINITE             = $FFFFFFFF;

  VI_NO_LOCK                  = 0;
  VI_EXCLUSIVE_LOCK           = 1;
  VI_SHARED_LOCK              = 2;
  VI_LOAD_CONFIG              = 4;

  VI_NO_SEC_ADDR              = $FFFF;

  VI_ASRL_PAR_NONE            = 0;
  VI_ASRL_PAR_ODD             = 1;
  VI_ASRL_PAR_EVEN            = 2;
  VI_ASRL_PAR_MARK            = 3;
  VI_ASRL_PAR_SPACE           = 4;
  VI_ASRL_STOP_ONE            = 10;
  VI_ASRL_STOP_ONE5           = 15;
  VI_ASRL_STOP_TWO            = 20;

  VI_ASRL_FLOW_NONE           = 0;
  VI_ASRL_FLOW_XON_XOFF       = 1;
  VI_ASRL_FLOW_RTS_CTS        = 2;
  VI_ASRL_FLOW_DTR_DSR        = 4;

  VI_ASRL_END_NONE            = 0;
  VI_ASRL_END_LAST_BIT        = 1;
  VI_ASRL_END_TERMCHAR        = 2;
  VI_ASRL_END_BREAK           = 3;

  VI_STATE_ASSERTED           = 1;
  VI_STATE_UNASSERTED         = 0;
  VI_STATE_UNKNOWN            = -1;

  VI_BIG_ENDIAN               = 0;
  VI_LITTLE_ENDIAN            = 1;

  VI_DATA_PRIV                = 0;
  VI_DATA_NPRIV               = 1;
  VI_PROG_PRIV                = 2;
  VI_PROG_NPRIV               = 3;
  VI_BLCK_PRIV                = 4;
  VI_BLCK_NPRIV               = 5;
  VI_D64_PRIV                 = 6;
  VI_D64_NPRIV                = 7;

  VI_WIDTH_8                  = 1;
  VI_WIDTH_16                 = 2;
  VI_WIDTH_32                 = 4;
  VI_WIDTH_64                 = 8;

  VI_GPIB_REN_DEASSERT        = 0;
  VI_GPIB_REN_ASSERT          = 1;
  VI_GPIB_REN_DEASSERT_GTL    = 2;
  VI_GPIB_REN_ASSERT_ADDRESS  = 3;
  VI_GPIB_REN_ASSERT_LLO      = 4;
  VI_GPIB_REN_ASSERT_ADDRESS_LLO = 5;
  VI_GPIB_REN_ADDRESS_GTL     = 6;

  VI_GPIB_ATN_DEASSERT        = 0;
  VI_GPIB_ATN_ASSERT          = 1;
  VI_GPIB_ATN_DEASSERT_HANDSHAKE = 2;
  VI_GPIB_ATN_ASSERT_IMMEDIATE = 3;

  VI_GPIB_HS488_DISABLED      = 0;
  VI_GPIB_HS488_NIMPL         = -1;

  VI_GPIB_UNADDRESSED         = 0;
  VI_GPIB_TALKER              = 1;
  VI_GPIB_LISTENER            = 2;

  VI_VXI_CMD16                = $0200;
  VI_VXI_CMD16_RESP16         = $0202;
  VI_VXI_RESP16               = $0002;
  VI_VXI_CMD32                = $0400;
  VI_VXI_CMD32_RESP16         = $0402;
  VI_VXI_CMD32_RESP32         = $0404;
  VI_VXI_RESP32               = $0004;

  VI_ASSERT_SIGNAL            = -1;
  VI_ASSERT_USE_ASSIGNED      = 0;
  VI_ASSERT_IRQ1              = 1;
  VI_ASSERT_IRQ2              = 2;
  VI_ASSERT_IRQ3              = 3;
  VI_ASSERT_IRQ4              = 4;
  VI_ASSERT_IRQ5              = 5;
  VI_ASSERT_IRQ6              = 6;
  VI_ASSERT_IRQ7              = 7;

  VI_UTIL_ASSERT_SYSRESET     = 1;
  VI_UTIL_ASSERT_SYSFAIL      = 2;
  VI_UTIL_DEASSERT_SYSFAIL    = 3;

  VI_VXI_CLASS_MEMORY         = 0;
  VI_VXI_CLASS_EXTENDED       = 1;
  VI_VXI_CLASS_MESSAGE        = 2;
  VI_VXI_CLASS_REGISTER       = 3;
  VI_VXI_CLASS_OTHER          = 4;

  VI_PXI_ADDR_NONE            = 0;
  VI_PXI_ADDR_MEM             = 1;
  VI_PXI_ADDR_IO              = 2;
  VI_PXI_ADDR_CFG             = 3;

  VI_TRIG_UNKNOWN             = -1;

  VI_PXI_LBUS_UNKNOWN         = -1;
  VI_PXI_LBUS_NONE            = 0;
  VI_PXI_LBUS_STAR_TRIG_BUS_0 = 1000;
  VI_PXI_LBUS_STAR_TRIG_BUS_1 = 1001;
  VI_PXI_LBUS_STAR_TRIG_BUS_2 = 1002;
  VI_PXI_LBUS_STAR_TRIG_BUS_3 = 1003;
  VI_PXI_LBUS_STAR_TRIG_BUS_4 = 1004;
  VI_PXI_LBUS_STAR_TRIG_BUS_5 = 1005;
  VI_PXI_LBUS_STAR_TRIG_BUS_6 = 1006;
  VI_PXI_LBUS_STAR_TRIG_BUS_7 = 1007;
  VI_PXI_LBUS_STAR_TRIG_BUS_8 = 1008;
  VI_PXI_LBUS_STAR_TRIG_BUS_9 = 1009;
  VI_PXI_STAR_TRIG_CONTROLLER = 1413;

  // Event Types
  VI_EVENT_IO_COMPLETION      = $3FFF2009;
  VI_EVENT_TRIG               = $BFFF200A;
  VI_EVENT_SERVICE_REQ        = $3FFF200B;
  VI_EVENT_CLEAR              = $3FFF200D;
  VI_EVENT_EXCEPTION          = $BFFF200E;
  VI_EVENT_GPIB_CIC           = $3FFF2012;
  VI_EVENT_GPIB_TALK          = $3FFF2013;
  VI_EVENT_GPIB_LISTEN        = $3FFF2014;
  VI_EVENT_VXI_VME_SYSFAIL    = $3FFF201D;
  VI_EVENT_VXI_VME_SYSRESET   = $3FFF201E;
  VI_EVENT_VXI_SIGP           = $3FFF2020;
  VI_EVENT_VXI_VME_INTR       = $BFFF2021;
  VI_EVENT_PXI_INTR           = $3FFF2022;
  VI_EVENT_TCPIP_CONNECT      = $3FFF2036;
  VI_EVENT_USB_INTR           = $3FFF2037;
  VI_ALL_ENABLED_EVENTS       = $3FFF7FFF;

  // Completion and Error Codes
  VI_SUCCESS_EVENT_EN         = $3FFF0002;
  VI_SUCCESS_EVENT_DIS        = $3FFF0003;
  VI_SUCCESS_QUEUE_EMPTY      = $3FFF0004;
  VI_SUCCESS_TERM_CHAR        = $3FFF0005;
  VI_SUCCESS_MAX_CNT          = $3FFF0006;
  VI_SUCCESS_DEV_NPRESENT     = $3FFF007D;
  VI_SUCCESS_TRIG_MAPPED      = $3FFF007E;
  VI_SUCCESS_QUEUE_NEMPTY     = $3FFF0080;
  VI_SUCCESS_NCHAIN           = $3FFF0098;
  VI_SUCCESS_NESTED_SHARED    = $3FFF0099;
  VI_SUCCESS_NESTED_EXCLUSIVE = $3FFF009A;
  VI_SUCCESS_SYNC             = $3FFF009B;
  VI_WARN_QUEUE_OVERFLOW      = $3FFF000C;
  VI_WARN_CONFIG_NLOADED      = $3FFF0077;
  VI_WARN_NULL_OBJECT         = $3FFF0082;
  VI_WARN_NSUP_ATTR_STATE     = $3FFF0084;
  VI_WARN_UNKNOWN_STATUS      = $3FFF0085;
  VI_WARN_NSUP_BUF            = $3FFF0088;
  VI_WARN_EXT_FUNC_NIMPL      = $3FFF00A9;
  _VI_ERROR                   = -2147483647 - 1;
  VI_ERROR_SYSTEM_ERROR       = _VI_ERROR+$3FFF0000;
  VI_ERROR_INV_OBJECT         = _VI_ERROR+$3FFF000E;
  VI_ERROR_RSRC_LOCKED        = _VI_ERROR+$3FFF000F;
  VI_ERROR_INV_EXPR           = _VI_ERROR+$3FFF0010;
  VI_ERROR_RSRC_NFOUND        = _VI_ERROR+$3FFF0011;
  VI_ERROR_INV_RSRC_NAME      = _VI_ERROR+$3FFF0012;
  VI_ERROR_INV_ACC_MODE       = _VI_ERROR+$3FFF0013;
  VI_ERROR_TMO                = _VI_ERROR+$3FFF0015;
  VI_ERROR_CLOSING_FAILED     = _VI_ERROR+$3FFF0016;
  VI_ERROR_INV_DEGREE         = _VI_ERROR+$3FFF001B;
  VI_ERROR_INV_JOB_ID         = _VI_ERROR+$3FFF001C;
  VI_ERROR_NSUP_ATTR          = _VI_ERROR+$3FFF001D;
  VI_ERROR_NSUP_ATTR_STATE    = _VI_ERROR+$3FFF001E;
  VI_ERROR_ATTR_READONLY      = _VI_ERROR+$3FFF001F;
  VI_ERROR_INV_LOCK_TYPE      = _VI_ERROR+$3FFF0020;
  VI_ERROR_INV_ACCESS_KEY     = _VI_ERROR+$3FFF0021;
  VI_ERROR_INV_EVENT          = _VI_ERROR+$3FFF0026;
  VI_ERROR_INV_MECH           = _VI_ERROR+$3FFF0027;
  VI_ERROR_HNDLR_NINSTALLED   = _VI_ERROR+$3FFF0028;
  VI_ERROR_INV_HNDLR_REF      = _VI_ERROR+$3FFF0029;
  VI_ERROR_INV_CONTEXT        = _VI_ERROR+$3FFF002A;
  VI_ERROR_QUEUE_OVERFLOW     = _VI_ERROR+$3FFF002D;
  VI_ERROR_NENABLED           = _VI_ERROR+$3FFF002F;
  VI_ERROR_ABORT              = _VI_ERROR+$3FFF0030;
  VI_ERROR_RAW_WR_PROT_VIOL   = _VI_ERROR+$3FFF0034;
  VI_ERROR_RAW_RD_PROT_VIOL   = _VI_ERROR+$3FFF0035;
  VI_ERROR_OUTP_PROT_VIOL     = _VI_ERROR+$3FFF0036;
  VI_ERROR_INP_PROT_VIOL      = _VI_ERROR+$3FFF0037;
  VI_ERROR_BERR               = _VI_ERROR+$3FFF0038;
  VI_ERROR_IN_PROGRESS        = _VI_ERROR+$3FFF0039;
  VI_ERROR_INV_SETUP          = _VI_ERROR+$3FFF003A;
  VI_ERROR_QUEUE_ERROR        = _VI_ERROR+$3FFF003B;
  VI_ERROR_ALLOC              = _VI_ERROR+$3FFF003C;
  VI_ERROR_INV_MASK           = _VI_ERROR+$3FFF003D;
  VI_ERROR_IO                 = _VI_ERROR+$3FFF003E;
  VI_ERROR_INV_FMT            = _VI_ERROR+$3FFF003F;
  VI_ERROR_NSUP_FMT           = _VI_ERROR+$3FFF0041;
  VI_ERROR_LINE_IN_USE        = _VI_ERROR+$3FFF0042;
  VI_ERROR_NSUP_MODE          = _VI_ERROR+$3FFF0046;
  VI_ERROR_SRQ_NOCCURRED      = _VI_ERROR+$3FFF004A;
  VI_ERROR_INV_SPACE          = _VI_ERROR+$3FFF004E;
  VI_ERROR_INV_OFFSET         = _VI_ERROR+$3FFF0051;
  VI_ERROR_INV_WIDTH          = _VI_ERROR+$3FFF0052;
  VI_ERROR_NSUP_OFFSET        = _VI_ERROR+$3FFF0054;
  VI_ERROR_NSUP_VAR_WIDTH     = _VI_ERROR+$3FFF0055;
  VI_ERROR_WINDOW_NMAPPED     = _VI_ERROR+$3FFF0057;
  VI_ERROR_RESP_PENDING       = _VI_ERROR+$3FFF0059;
  VI_ERROR_NLISTENERS         = _VI_ERROR+$3FFF005F;
  VI_ERROR_NCIC               = _VI_ERROR+$3FFF0060;
  VI_ERROR_NSYS_CNTLR         = _VI_ERROR+$3FFF0061;
  VI_ERROR_NSUP_OPER          = _VI_ERROR+$3FFF0067;
  VI_ERROR_INTR_PENDING       = _VI_ERROR+$3FFF0068;
  VI_ERROR_ASRL_PARITY        = _VI_ERROR+$3FFF006A;
  VI_ERROR_ASRL_FRAMING       = _VI_ERROR+$3FFF006B;
  VI_ERROR_ASRL_OVERRUN       = _VI_ERROR+$3FFF006C;
  VI_ERROR_TRIG_NMAPPED       = _VI_ERROR+$3FFF006E;
  VI_ERROR_NSUP_ALIGN_OFFSET  = _VI_ERROR+$3FFF0070;
  VI_ERROR_USER_BUF           = _VI_ERROR+$3FFF0071;
  VI_ERROR_RSRC_BUSY          = _VI_ERROR+$3FFF0072;
  VI_ERROR_NSUP_WIDTH         = _VI_ERROR+$3FFF0076;
  VI_ERROR_INV_PARAMETER      = _VI_ERROR+$3FFF0078;
  VI_ERROR_INV_PROT           = _VI_ERROR+$3FFF0079;
  VI_ERROR_INV_SIZE           = _VI_ERROR+$3FFF007B;
  VI_ERROR_WINDOW_MAPPED      = _VI_ERROR+$3FFF0080;
  VI_ERROR_NIMPL_OPER         = _VI_ERROR+$3FFF0081;
  VI_ERROR_INV_LENGTH         = _VI_ERROR+$3FFF0083;
  VI_ERROR_INV_MODE           = _VI_ERROR+$3FFF0091;
  VI_ERROR_SESN_NLOCKED       = _VI_ERROR+$3FFF009C;
  VI_ERROR_MEM_NSHARED        = _VI_ERROR+$3FFF009D;
  VI_ERROR_LIBRARY_NFOUND     = _VI_ERROR+$3FFF009E;
  VI_ERROR_NSUP_INTR          = _VI_ERROR+$3FFF009F;
  VI_ERROR_INV_LINE           = _VI_ERROR+$3FFF00A0;
  VI_ERROR_FILE_ACCESS        = _VI_ERROR+$3FFF00A1;
  VI_ERROR_FILE_IO            = _VI_ERROR+$3FFF00A2;
  VI_ERROR_NSUP_LINE          = _VI_ERROR+$3FFF00A3;
  VI_ERROR_NSUP_MECH          = _VI_ERROR+$3FFF00A4;
  VI_ERROR_INTF_NUM_NCONFIG   = _VI_ERROR+$3FFF00A5;
  VI_ERROR_CONN_LOST          = _VI_ERROR+$3FFF00A6;
  VI_ERROR_MACHINE_NAVAIL     = _VI_ERROR+$3FFF00A7;
  VI_ERROR_NPERMISSION        = _VI_ERROR+$3FFF00A8;


(*
/*---------------------------------------------------------------------------*/
/* Distributed by IVI Foundation Inc.                                        */
/*                                                                           */
/* Do not modify the contents of this file.                                  */
/*---------------------------------------------------------------------------*/
/*                                                                           */
/* Title   : VISATYPE.H                                                      */
/* Date    : 04-14-2006                                                      */
/* Purpose : Fundamental VISA data types and macro definitions               */
/*                                                                           */
/*---------------------------------------------------------------------------*/

#ifndef __VISATYPE_HEADER__
#define __VISATYPE_HEADER__

#if defined(_WIN64)
#define _VI_FAR
#define _VI_FUNC            __fastcall
#define _VI_FUNCC           __fastcall
#define _VI_FUNCH           __fastcall
#define _VI_SIGNED          signed
#elif (defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__)) && !defined(_NI_mswin16_)
#define _VI_FAR
#define _VI_FUNC            __stdcall
#define _VI_FUNCC           __cdecl
#define _VI_FUNCH           __stdcall
#define _VI_SIGNED          signed
#elif defined(_CVI_) && defined(_NI_i386_)
#define _VI_FAR
#define _VI_FUNC            _pascal
#define _VI_FUNCC
#define _VI_FUNCH           _pascal
#define _VI_SIGNED          signed
#elif (defined(_WINDOWS) || defined(_Windows)) && !defined(_NI_mswin16_)
#define _VI_FAR             _far
#define _VI_FUNC            _far _pascal _export
#define _VI_FUNCC           _far _cdecl  _export
#define _VI_FUNCH           _far _pascal
#define _VI_SIGNED          signed
#elif (defined(hpux) || defined(__hpux)) && (defined(__cplusplus) || defined(__cplusplus__))
#define _VI_FAR
#define _VI_FUNC
#define _VI_FUNCC
#define _VI_FUNCH
#define _VI_SIGNED
#else
#define _VI_FAR
#define _VI_FUNC
#define _VI_FUNCC
#define _VI_FUNCH
#define _VI_SIGNED          signed
#endif

#define _VI_PTR             _VI_FAR *

/*- VISA Types --------------------------------------------------------------*/

#ifndef _VI_INT64_UINT64_DEFINED
#if defined(_WIN64) || ((defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__)) && !defined(_NI_mswin16_))
#if (defined(_MSC_VER) && (_MSC_VER >= 1200)) || (defined(_CVI_) && (_CVI_ >= 700)) || (defined(__BORLANDC__) && (__BORLANDC__ >= 0x0520))
typedef unsigned   __int64  ViUInt64;
typedef _VI_SIGNED __int64  ViInt64;
#define _VI_INT64_UINT64_DEFINED
#if defined(_WIN64)
#define _VISA_ENV_IS_64_BIT
#else
/* This is a 32-bit OS, not a 64-bit OS */
#endif
#endif
#elif defined(__GNUC__) && (__GNUC__ >= 3)
#include <limits.h>
#include <sys/types.h>
typedef u_int64_t           ViUInt64;
typedef int64_t             ViInt64;
#define _VI_INT64_UINT64_DEFINED
#if defined(LONG_MAX) && (LONG_MAX > 0x7FFFFFFFL)
#define _VISA_ENV_IS_64_BIT
#else
/* This is a 32-bit OS, not a 64-bit OS */
#endif
#else
/* This platform does not support 64-bit types */
#endif
#endif

#if defined(_VI_INT64_UINT64_DEFINED)
typedef ViUInt64    _VI_PTR ViPUInt64;
typedef ViUInt64    _VI_PTR ViAUInt64;
typedef ViInt64     _VI_PTR ViPInt64;
typedef ViInt64     _VI_PTR ViAInt64;
#endif

#if defined(LONG_MAX) && (LONG_MAX > 0x7FFFFFFFL)
typedef unsigned int        ViUInt32;
typedef _VI_SIGNED int      ViInt32;
#else
typedef unsigned long       ViUInt32;
typedef _VI_SIGNED long     ViInt32;
#endif

typedef ViUInt32    _VI_PTR ViPUInt32;
typedef ViUInt32    _VI_PTR ViAUInt32;
typedef ViInt32     _VI_PTR ViPInt32;
typedef ViInt32     _VI_PTR ViAInt32;

typedef unsigned short      ViUInt16;
typedef ViUInt16    _VI_PTR ViPUInt16;
typedef ViUInt16    _VI_PTR ViAUInt16;

typedef _VI_SIGNED short    ViInt16;
typedef ViInt16     _VI_PTR ViPInt16;
typedef ViInt16     _VI_PTR ViAInt16;

typedef unsigned char       ViUInt8;
typedef ViUInt8     _VI_PTR ViPUInt8;
typedef ViUInt8     _VI_PTR ViAUInt8;

typedef _VI_SIGNED char     ViInt8;
typedef ViInt8      _VI_PTR ViPInt8;
typedef ViInt8      _VI_PTR ViAInt8;

typedef char                ViChar;
typedef ViChar      _VI_PTR ViPChar;
typedef ViChar      _VI_PTR ViAChar;

typedef unsigned char       ViByte;
typedef ViByte      _VI_PTR ViPByte;
typedef ViByte      _VI_PTR ViAByte;

typedef void        _VI_PTR ViAddr;
typedef ViAddr      _VI_PTR ViPAddr;
typedef ViAddr      _VI_PTR ViAAddr;

typedef float               ViReal32;
typedef ViReal32    _VI_PTR ViPReal32;
typedef ViReal32    _VI_PTR ViAReal32;

typedef double              ViReal64;
typedef ViReal64    _VI_PTR ViPReal64;
typedef ViReal64    _VI_PTR ViAReal64;

typedef ViPByte             ViBuf;
typedef ViPByte             ViPBuf;
typedef ViPByte     _VI_PTR ViABuf;

typedef ViPChar             ViString;
typedef ViPChar             ViPString;
typedef ViPChar     _VI_PTR ViAString;

typedef ViString            ViRsrc;
typedef ViString            ViPRsrc;
typedef ViString    _VI_PTR ViARsrc;

typedef ViUInt16            ViBoolean;
typedef ViBoolean   _VI_PTR ViPBoolean;
typedef ViBoolean   _VI_PTR ViABoolean;

typedef ViInt32             ViStatus;
typedef ViStatus    _VI_PTR ViPStatus;
typedef ViStatus    _VI_PTR ViAStatus;

typedef ViUInt32            ViVersion;
typedef ViVersion   _VI_PTR ViPVersion;
typedef ViVersion   _VI_PTR ViAVersion;

typedef ViUInt32            ViObject;
typedef ViObject    _VI_PTR ViPObject;
typedef ViObject    _VI_PTR ViAObject;

typedef ViObject            ViSession;
typedef ViSession   _VI_PTR ViPSession;
typedef ViSession   _VI_PTR ViASession;

typedef ViUInt32             ViAttr;

#ifndef _VI_CONST_STRING_DEFINED
typedef const ViChar * ViConstString;
#define _VI_CONST_STRING_DEFINED
#endif  


/*- Backward Compatibility Macros -------------------------------------------*/

#define VISAFN              _VI_FUNC
#define ViPtr               _VI_PTR

#endif

/*- The End -----------------------------------------------------------------*/

*)

(*


#define VI_SPEC_VERSION     (0x00400000UL)

/*- VISA Types --------------------------------------------------------------*/

typedef ViObject             ViEvent;
typedef ViEvent      _VI_PTR ViPEvent;
typedef ViObject             ViFindList;
typedef ViFindList   _VI_PTR ViPFindList;

#if defined(_VI_INT64_UINT64_DEFINED) && defined(_VISA_ENV_IS_64_BIT)
typedef ViUInt64             ViBusAddress;
typedef ViUInt64             ViBusSize;
typedef ViUInt64             ViAttrState;
#else
typedef ViUInt32             ViBusAddress;
typedef ViUInt32             ViBusSize;
typedef ViUInt32             ViAttrState;
#endif

#if defined(_VI_INT64_UINT64_DEFINED)
typedef ViUInt64             ViBusAddress64;
typedef ViBusAddress64 _VI_PTR ViPBusAddress64;
#endif

typedef ViUInt32             ViEventType;
typedef ViEventType  _VI_PTR ViPEventType;
typedef ViEventType  _VI_PTR ViAEventType;
typedef void         _VI_PTR ViPAttrState;
typedef ViAttr       _VI_PTR ViPAttr;
typedef ViAttr       _VI_PTR ViAAttr;

typedef ViString             ViKeyId;
typedef ViPString            ViPKeyId;
typedef ViUInt32             ViJobId;
typedef ViJobId      _VI_PTR ViPJobId;
typedef ViUInt32             ViAccessMode;
typedef ViAccessMode _VI_PTR ViPAccessMode;
typedef ViBusAddress _VI_PTR ViPBusAddress;
typedef ViUInt32             ViEventFilter;

typedef va_list              ViVAList;

typedef ViStatus (_VI_FUNCH _VI_PTR ViHndlr)
   (ViSession vi, ViEventType eventType, ViEvent event, ViAddr userHandle);

/*- Resource Manager Functions and Operations -------------------------------*/

ViStatus _VI_FUNC  viOpenDefaultRM (ViPSession vi);
ViStatus _VI_FUNC  viFindRsrc      (ViSession sesn, ViString expr, ViPFindList vi,
                                    ViPUInt32 retCnt, ViChar _VI_FAR desc[]);
ViStatus _VI_FUNC  viFindNext      (ViFindList vi, ViChar _VI_FAR desc[]);
ViStatus _VI_FUNC  viParseRsrc     (ViSession rmSesn, ViRsrc rsrcName,
                                    ViPUInt16 intfType, ViPUInt16 intfNum);
ViStatus _VI_FUNC  viParseRsrcEx   (ViSession rmSesn, ViRsrc rsrcName, ViPUInt16 intfType,
                                    ViPUInt16 intfNum, ViChar _VI_FAR rsrcClass[],
                                    ViChar _VI_FAR expandedUnaliasedName[],
                                    ViChar _VI_FAR aliasIfExists[]);
ViStatus _VI_FUNC  viOpen          (ViSession sesn, ViRsrc name, ViAccessMode mode,
                                    ViUInt32 timeout, ViPSession vi);

/*- Resource Template Operations --------------------------------------------*/

ViStatus _VI_FUNC  viClose         (ViObject vi);
ViStatus _VI_FUNC  viSetAttribute  (ViObject vi, ViAttr attrName, ViAttrState attrValue);
ViStatus _VI_FUNC  viGetAttribute  (ViObject vi, ViAttr attrName, void _VI_PTR attrValue);
ViStatus _VI_FUNC  viStatusDesc    (ViObject vi, ViStatus status, ViChar _VI_FAR desc[]);
ViStatus _VI_FUNC  viTerminate     (ViObject vi, ViUInt16 degree, ViJobId jobId);

ViStatus _VI_FUNC  viLock          (ViSession vi, ViAccessMode lockType, ViUInt32 timeout,
                                    ViKeyId requestedKey, ViChar _VI_FAR accessKey[]);
ViStatus _VI_FUNC  viUnlock        (ViSession vi);
ViStatus _VI_FUNC  viEnableEvent   (ViSession vi, ViEventType eventType, ViUInt16 mechanism,
                                    ViEventFilter context);
ViStatus _VI_FUNC  viDisableEvent  (ViSession vi, ViEventType eventType, ViUInt16 mechanism);
ViStatus _VI_FUNC  viDiscardEvents (ViSession vi, ViEventType eventType, ViUInt16 mechanism);
ViStatus _VI_FUNC  viWaitOnEvent   (ViSession vi, ViEventType inEventType, ViUInt32 timeout,
                                    ViPEventType outEventType, ViPEvent outContext);
ViStatus _VI_FUNC  viInstallHandler(ViSession vi, ViEventType eventType, ViHndlr handler,
                                    ViAddr userHandle);
ViStatus _VI_FUNC  viUninstallHandler(ViSession vi, ViEventType eventType, ViHndlr handler,
                                      ViAddr userHandle);

/*- Basic I/O Operations ----------------------------------------------------*/

ViStatus _VI_FUNC  viRead          (ViSession vi, ViPBuf buf, ViUInt32 cnt, ViPUInt32 retCnt);
ViStatus _VI_FUNC  viReadAsync     (ViSession vi, ViPBuf buf, ViUInt32 cnt, ViPJobId  jobId);
ViStatus _VI_FUNC  viReadToFile    (ViSession vi, ViConstString filename, ViUInt32 cnt,
                                    ViPUInt32 retCnt);
ViStatus _VI_FUNC  viWrite         (ViSession vi, ViBuf  buf, ViUInt32 cnt, ViPUInt32 retCnt);
ViStatus _VI_FUNC  viWriteAsync    (ViSession vi, ViBuf  buf, ViUInt32 cnt, ViPJobId  jobId);
ViStatus _VI_FUNC  viWriteFromFile (ViSession vi, ViConstString filename, ViUInt32 cnt,
                                    ViPUInt32 retCnt);
ViStatus _VI_FUNC  viAssertTrigger (ViSession vi, ViUInt16 protocol);
ViStatus _VI_FUNC  viReadSTB       (ViSession vi, ViPUInt16 status);
ViStatus _VI_FUNC  viClear         (ViSession vi);

/*- Formatted and Buffered I/O Operations -----------------------------------*/

ViStatus _VI_FUNC  viSetBuf        (ViSession vi, ViUInt16 mask, ViUInt32 size);
ViStatus _VI_FUNC  viFlush         (ViSession vi, ViUInt16 mask);

ViStatus _VI_FUNC  viBufWrite      (ViSession vi, ViBuf  buf, ViUInt32 cnt, ViPUInt32 retCnt);
ViStatus _VI_FUNC  viBufRead       (ViSession vi, ViPBuf buf, ViUInt32 cnt, ViPUInt32 retCnt);

ViStatus _VI_FUNCC viPrintf        (ViSession vi, ViString writeFmt, ...);
ViStatus _VI_FUNC  viVPrintf       (ViSession vi, ViString writeFmt, ViVAList params);
ViStatus _VI_FUNCC viSPrintf       (ViSession vi, ViPBuf buf, ViString writeFmt, ...);
ViStatus _VI_FUNC  viVSPrintf      (ViSession vi, ViPBuf buf, ViString writeFmt,
                                    ViVAList parms);

ViStatus _VI_FUNCC viScanf         (ViSession vi, ViString readFmt, ...);
ViStatus _VI_FUNC  viVScanf        (ViSession vi, ViString readFmt, ViVAList params);
ViStatus _VI_FUNCC viSScanf        (ViSession vi, ViBuf buf, ViString readFmt, ...);
ViStatus _VI_FUNC  viVSScanf       (ViSession vi, ViBuf buf, ViString readFmt,
                                    ViVAList parms);

ViStatus _VI_FUNCC viQueryf        (ViSession vi, ViString writeFmt, ViString readFmt, ...);
ViStatus _VI_FUNC  viVQueryf       (ViSession vi, ViString writeFmt, ViString readFmt, 
                                    ViVAList params);

/*- Memory I/O Operations ---------------------------------------------------*/

ViStatus _VI_FUNC  viIn8           (ViSession vi, ViUInt16 space,
                                    ViBusAddress offset, ViPUInt8  val8);
ViStatus _VI_FUNC  viOut8          (ViSession vi, ViUInt16 space,
                                    ViBusAddress offset, ViUInt8   val8);
ViStatus _VI_FUNC  viIn16          (ViSession vi, ViUInt16 space,
                                    ViBusAddress offset, ViPUInt16 val16);
ViStatus _VI_FUNC  viOut16         (ViSession vi, ViUInt16 space,
                                    ViBusAddress offset, ViUInt16  val16);
ViStatus _VI_FUNC  viIn32          (ViSession vi, ViUInt16 space,
                                    ViBusAddress offset, ViPUInt32 val32);
ViStatus _VI_FUNC  viOut32         (ViSession vi, ViUInt16 space,
                                    ViBusAddress offset, ViUInt32  val32);

#if defined(_VI_INT64_UINT64_DEFINED)
ViStatus _VI_FUNC  viIn64          (ViSession vi, ViUInt16 space,
                                    ViBusAddress offset, ViPUInt64 val64);
ViStatus _VI_FUNC  viOut64         (ViSession vi, ViUInt16 space,
                                    ViBusAddress offset, ViUInt64  val64);

ViStatus _VI_FUNC  viIn8Ex         (ViSession vi, ViUInt16 space,
                                    ViBusAddress64 offset, ViPUInt8  val8);
ViStatus _VI_FUNC  viOut8Ex        (ViSession vi, ViUInt16 space,
                                    ViBusAddress64 offset, ViUInt8   val8);
ViStatus _VI_FUNC  viIn16Ex        (ViSession vi, ViUInt16 space,
                                    ViBusAddress64 offset, ViPUInt16 val16);
ViStatus _VI_FUNC  viOut16Ex       (ViSession vi, ViUInt16 space,
                                    ViBusAddress64 offset, ViUInt16  val16);
ViStatus _VI_FUNC  viIn32Ex        (ViSession vi, ViUInt16 space,
                                    ViBusAddress64 offset, ViPUInt32 val32);
ViStatus _VI_FUNC  viOut32Ex       (ViSession vi, ViUInt16 space,
                                    ViBusAddress64 offset, ViUInt32  val32);
ViStatus _VI_FUNC  viIn64Ex        (ViSession vi, ViUInt16 space,
                                    ViBusAddress64 offset, ViPUInt64 val64);
ViStatus _VI_FUNC  viOut64Ex       (ViSession vi, ViUInt16 space,
                                    ViBusAddress64 offset, ViUInt64  val64);
#endif

ViStatus _VI_FUNC  viMoveIn8       (ViSession vi, ViUInt16 space, ViBusAddress offset,
                                    ViBusSize length, ViAUInt8  buf8);
ViStatus _VI_FUNC  viMoveOut8      (ViSession vi, ViUInt16 space, ViBusAddress offset,
                                    ViBusSize length, ViAUInt8  buf8);
ViStatus _VI_FUNC  viMoveIn16      (ViSession vi, ViUInt16 space, ViBusAddress offset,
                                    ViBusSize length, ViAUInt16 buf16);
ViStatus _VI_FUNC  viMoveOut16     (ViSession vi, ViUInt16 space, ViBusAddress offset,
                                    ViBusSize length, ViAUInt16 buf16);
ViStatus _VI_FUNC  viMoveIn32      (ViSession vi, ViUInt16 space, ViBusAddress offset,
                                    ViBusSize length, ViAUInt32 buf32);
ViStatus _VI_FUNC  viMoveOut32     (ViSession vi, ViUInt16 space, ViBusAddress offset,
                                    ViBusSize length, ViAUInt32 buf32);

#if defined(_VI_INT64_UINT64_DEFINED)
ViStatus _VI_FUNC  viMoveIn64      (ViSession vi, ViUInt16 space, ViBusAddress offset,
                                    ViBusSize length, ViAUInt64 buf64);
ViStatus _VI_FUNC  viMoveOut64     (ViSession vi, ViUInt16 space, ViBusAddress offset,
                                    ViBusSize length, ViAUInt64 buf64);

ViStatus _VI_FUNC  viMoveIn8Ex     (ViSession vi, ViUInt16 space, ViBusAddress64 offset,
                                    ViBusSize length, ViAUInt8  buf8);
ViStatus _VI_FUNC  viMoveOut8Ex    (ViSession vi, ViUInt16 space, ViBusAddress64 offset,
                                    ViBusSize length, ViAUInt8  buf8);
ViStatus _VI_FUNC  viMoveIn16Ex    (ViSession vi, ViUInt16 space, ViBusAddress64 offset,
                                    ViBusSize length, ViAUInt16 buf16);
ViStatus _VI_FUNC  viMoveOut16Ex   (ViSession vi, ViUInt16 space, ViBusAddress64 offset,
                                    ViBusSize length, ViAUInt16 buf16);
ViStatus _VI_FUNC  viMoveIn32Ex    (ViSession vi, ViUInt16 space, ViBusAddress64 offset,
                                    ViBusSize length, ViAUInt32 buf32);
ViStatus _VI_FUNC  viMoveOut32Ex   (ViSession vi, ViUInt16 space, ViBusAddress64 offset,
                                    ViBusSize length, ViAUInt32 buf32);
ViStatus _VI_FUNC  viMoveIn64Ex    (ViSession vi, ViUInt16 space, ViBusAddress64 offset,
                                    ViBusSize length, ViAUInt64 buf64);
ViStatus _VI_FUNC  viMoveOut64Ex   (ViSession vi, ViUInt16 space, ViBusAddress64 offset,
                                    ViBusSize length, ViAUInt64 buf64);
#endif

ViStatus _VI_FUNC  viMove          (ViSession vi, ViUInt16 srcSpace, ViBusAddress srcOffset,
                                    ViUInt16 srcWidth, ViUInt16 destSpace, 
                                    ViBusAddress destOffset, ViUInt16 destWidth, 
                                    ViBusSize srcLength); 
ViStatus _VI_FUNC  viMoveAsync     (ViSession vi, ViUInt16 srcSpace, ViBusAddress srcOffset,
                                    ViUInt16 srcWidth, ViUInt16 destSpace, 
                                    ViBusAddress destOffset, ViUInt16 destWidth, 
                                    ViBusSize srcLength, ViPJobId jobId);

#if defined(_VI_INT64_UINT64_DEFINED)
ViStatus _VI_FUNC  viMoveEx        (ViSession vi, ViUInt16 srcSpace, ViBusAddress64 srcOffset,
                                    ViUInt16 srcWidth, ViUInt16 destSpace, 
                                    ViBusAddress64 destOffset, ViUInt16 destWidth, 
                                    ViBusSize srcLength); 
ViStatus _VI_FUNC  viMoveAsyncEx   (ViSession vi, ViUInt16 srcSpace, ViBusAddress64 srcOffset,
                                    ViUInt16 srcWidth, ViUInt16 destSpace, 
                                    ViBusAddress64 destOffset, ViUInt16 destWidth, 
                                    ViBusSize srcLength, ViPJobId jobId);
#endif

ViStatus _VI_FUNC  viMapAddress    (ViSession vi, ViUInt16 mapSpace, ViBusAddress mapOffset,
                                    ViBusSize mapSize, ViBoolean access,
                                    ViAddr suggested, ViPAddr address);
ViStatus _VI_FUNC  viUnmapAddress  (ViSession vi);

#if defined(_VI_INT64_UINT64_DEFINED)
ViStatus _VI_FUNC  viMapAddressEx  (ViSession vi, ViUInt16 mapSpace, ViBusAddress64 mapOffset,
                                    ViBusSize mapSize, ViBoolean access,
                                    ViAddr suggested, ViPAddr address);
#endif

void     _VI_FUNC  viPeek8         (ViSession vi, ViAddr address, ViPUInt8  val8);
void     _VI_FUNC  viPoke8         (ViSession vi, ViAddr address, ViUInt8   val8);
void     _VI_FUNC  viPeek16        (ViSession vi, ViAddr address, ViPUInt16 val16);
void     _VI_FUNC  viPoke16        (ViSession vi, ViAddr address, ViUInt16  val16);
void     _VI_FUNC  viPeek32        (ViSession vi, ViAddr address, ViPUInt32 val32);
void     _VI_FUNC  viPoke32        (ViSession vi, ViAddr address, ViUInt32  val32);

#if defined(_VI_INT64_UINT64_DEFINED)
void     _VI_FUNC  viPeek64        (ViSession vi, ViAddr address, ViPUInt64 val64);
void     _VI_FUNC  viPoke64        (ViSession vi, ViAddr address, ViUInt64  val64);
#endif

/*- Shared Memory Operations ------------------------------------------------*/

ViStatus _VI_FUNC  viMemAlloc      (ViSession vi, ViBusSize size, ViPBusAddress offset);
ViStatus _VI_FUNC  viMemFree       (ViSession vi, ViBusAddress offset);

#if defined(_VI_INT64_UINT64_DEFINED)
ViStatus _VI_FUNC  viMemAllocEx    (ViSession vi, ViBusSize size, ViPBusAddress64 offset);
ViStatus _VI_FUNC  viMemFreeEx     (ViSession vi, ViBusAddress64 offset);
#endif

/*- Interface Specific Operations -------------------------------------------*/

ViStatus _VI_FUNC  viGpibControlREN(ViSession vi, ViUInt16 mode);
ViStatus _VI_FUNC  viGpibControlATN(ViSession vi, ViUInt16 mode);
ViStatus _VI_FUNC  viGpibSendIFC   (ViSession vi);
ViStatus _VI_FUNC  viGpibCommand   (ViSession vi, ViBuf cmd, ViUInt32 cnt, ViPUInt32 retCnt);
ViStatus _VI_FUNC  viGpibPassControl(ViSession vi, ViUInt16 primAddr, ViUInt16 secAddr);

ViStatus _VI_FUNC  viVxiCommandQuery(ViSession vi, ViUInt16 mode, ViUInt32 cmd,
                                     ViPUInt32 response);
ViStatus _VI_FUNC  viAssertUtilSignal(ViSession vi, ViUInt16 line);
ViStatus _VI_FUNC  viAssertIntrSignal(ViSession vi, ViInt16 mode, ViUInt32 statusID);
ViStatus _VI_FUNC  viMapTrigger    (ViSession vi, ViInt16 trigSrc, ViInt16 trigDest, 
                                    ViUInt16 mode);
ViStatus _VI_FUNC  viUnmapTrigger  (ViSession vi, ViInt16 trigSrc, ViInt16 trigDest);
ViStatus _VI_FUNC  viUsbControlOut (ViSession vi, ViInt16 bmRequestType, ViInt16 bRequest,
                                    ViUInt16 wValue, ViUInt16 wIndex, ViUInt16 wLength,
                                    ViBuf buf);
ViStatus _VI_FUNC  viUsbControlIn  (ViSession vi, ViInt16 bmRequestType, ViInt16 bRequest,
                                    ViUInt16 wValue, ViUInt16 wIndex, ViUInt16 wLength,
                                    ViPBuf buf, ViPUInt16 retCnt);


/*- Attributes (platform dependent size) ------------------------------------*/

#if defined(_VI_INT64_UINT64_DEFINED) && defined(_VISA_ENV_IS_64_BIT)
#define VI_ATTR_USER_DATA_64        (0x3FFF000AUL)
#define VI_ATTR_RET_COUNT_64        (0x3FFF4028UL)
#define VI_ATTR_USER_DATA           (VI_ATTR_USER_DATA_64)
#define VI_ATTR_RET_COUNT           (VI_ATTR_RET_COUNT_64)
#else
#define VI_ATTR_USER_DATA           (VI_ATTR_USER_DATA_32)
#define VI_ATTR_RET_COUNT           (VI_ATTR_RET_COUNT_32)
#endif

#if defined(_VI_INT64_UINT64_DEFINED)
#define VI_ATTR_WIN_BASE_ADDR_64    (0x3FFF009BUL)
#define VI_ATTR_WIN_SIZE_64         (0x3FFF009CUL)
#define VI_ATTR_MEM_BASE_64         (0x3FFF00D0UL)
#define VI_ATTR_MEM_SIZE_64         (0x3FFF00D1UL)
#endif
#if defined(_VI_INT64_UINT64_DEFINED) && defined(_VISA_ENV_IS_64_BIT)
#define VI_ATTR_WIN_BASE_ADDR       (VI_ATTR_WIN_BASE_ADDR_64)
#define VI_ATTR_WIN_SIZE            (VI_ATTR_WIN_SIZE_64)
#define VI_ATTR_MEM_BASE            (VI_ATTR_MEM_BASE_64)
#define VI_ATTR_MEM_SIZE            (VI_ATTR_MEM_SIZE_64)
#else
#define VI_ATTR_WIN_BASE_ADDR       (VI_ATTR_WIN_BASE_ADDR_32)
#define VI_ATTR_WIN_SIZE            (VI_ATTR_WIN_SIZE_32)
#define VI_ATTR_MEM_BASE            (VI_ATTR_MEM_BASE_32)
#define VI_ATTR_MEM_SIZE            (VI_ATTR_MEM_SIZE_32)
#endif

/*- Other VISA Definitions --------------------------------------------------*/

#define VI_VERSION_MAJOR(ver)       ((((ViVersion)ver) & 0xFFF00000UL) >> 20)
#define VI_VERSION_MINOR(ver)       ((((ViVersion)ver) & 0x000FFF00UL) >>  8)
#define VI_VERSION_SUBMINOR(ver)    ((((ViVersion)ver) & 0x000000FFUL)      )


/*- Backward Compatibility Macros -------------------------------------------*/

#define viGetDefaultRM(vi)          viOpenDefaultRM(vi)
#define VI_ERROR_INV_SESSION        (VI_ERROR_INV_OBJECT)
#define VI_INFINITE                 (VI_TMO_INFINITE)
#define VI_NORMAL                   (VI_PROT_NORMAL)
#define VI_FDC                      (VI_PROT_FDC)
#define VI_HS488                    (VI_PROT_HS488)
#define VI_ASRL488                  (VI_PROT_4882_STRS)
#define VI_ASRL_IN_BUF              (VI_IO_IN_BUF)
#define VI_ASRL_OUT_BUF             (VI_IO_OUT_BUF)
#define VI_ASRL_IN_BUF_DISCARD      (VI_IO_IN_BUF_DISCARD)
#define VI_ASRL_OUT_BUF_DISCARD     (VI_IO_OUT_BUF_DISCARD)

/*- National Instruments ----------------------------------------------------*/

#define VI_INTF_RIO                 (8)
#define VI_INTF_FIREWIRE            (9) 

#define VI_ATTR_SYNC_MXI_ALLOW_EN   (0x3FFF0161UL) /* ViBoolean, read/write */

/* This is for VXI SERVANT resources */

#define VI_EVENT_VXI_DEV_CMD        (0xBFFF200FUL)
#define VI_ATTR_VXI_DEV_CMD_TYPE    (0x3FFF4037UL) /* ViInt16, read-only */
#define VI_ATTR_VXI_DEV_CMD_VALUE   (0x3FFF4038UL) /* ViUInt32, read-only */

#define VI_VXI_DEV_CMD_TYPE_16      (16)
#define VI_VXI_DEV_CMD_TYPE_32      (32)

ViStatus _VI_FUNC viVxiServantResponse(ViSession vi, ViInt16 mode, ViUInt32 resp);
/* mode values include VI_VXI_RESP16, VI_VXI_RESP32, and the next 2 values */
#define VI_VXI_RESP_NONE            (0)
#define VI_VXI_RESP_PROT_ERROR      (-1)

/* This is for VXI TTL Trigger routing */

#define VI_ATTR_VXI_TRIG_LINES_EN   (0x3FFF4043UL)
#define VI_ATTR_VXI_TRIG_DIR        (0x3FFF4044UL)

/* This allows extended Serial support on Win32 and on NI ENET Serial products */

#define VI_ATTR_ASRL_DISCARD_NULL   (0x3FFF00B0UL)
#define VI_ATTR_ASRL_CONNECTED      (0x3FFF01BBUL)
#define VI_ATTR_ASRL_BREAK_STATE    (0x3FFF01BCUL)
#define VI_ATTR_ASRL_BREAK_LEN      (0x3FFF01BDUL)
#define VI_ATTR_ASRL_ALLOW_TRANSMIT (0x3FFF01BEUL)
#define VI_ATTR_ASRL_WIRE_MODE      (0x3FFF01BFUL)

#define VI_ASRL_WIRE_485_4          (0)
#define VI_ASRL_WIRE_485_2_DTR_ECHO (1)
#define VI_ASRL_WIRE_485_2_DTR_CTRL (2)
#define VI_ASRL_WIRE_485_2_AUTO     (3)
#define VI_ASRL_WIRE_232_DTE        (128)
#define VI_ASRL_WIRE_232_DCE        (129)
#define VI_ASRL_WIRE_232_AUTO       (130)

#define VI_EVENT_ASRL_BREAK         (0x3FFF2023UL)
#define VI_EVENT_ASRL_CTS           (0x3FFF2029UL)
#define VI_EVENT_ASRL_DSR           (0x3FFF202AUL)
#define VI_EVENT_ASRL_DCD           (0x3FFF202CUL)
#define VI_EVENT_ASRL_RI            (0x3FFF202EUL)
#define VI_EVENT_ASRL_CHAR          (0x3FFF2035UL)
#define VI_EVENT_ASRL_TERMCHAR      (0x3FFF2024UL)

/* This is for fast viPeek/viPoke macros */

#if defined(NIVISA_PEEKPOKE)

#if defined(NIVISA_PEEKPOKE_SUPP)
#undef NIVISA_PEEKPOKE_SUPP
#endif

#if (defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__)) && !defined(_NI_mswin16_)
/* This macro is supported for all Win32 compilers, including CVI. */
#define NIVISA_PEEKPOKE_SUPP
#elif (defined(_WINDOWS) || defined(_Windows)) && !defined(_CVI_) && !defined(_NI_mswin16_)
/* This macro is supported for Borland and Microsoft compilers on Win16, but not CVI. */
#define NIVISA_PEEKPOKE_SUPP
#elif defined(_CVI_) && defined(_NI_sparc_)
/* This macro is supported for Solaris 1 and 2, from CVI only. */
#define NIVISA_PEEKPOKE_SUPP
#else
/* This macro is not supported on other platforms. */
#endif

#if defined(NIVISA_PEEKPOKE_SUPP)

extern ViBoolean NI_viImplVISA1;
ViStatus _VI_FUNC NI_viOpenDefaultRM (ViPSession vi);
#define viOpenDefaultRM(vi) NI_viOpenDefaultRM(vi)

#define viPeek8(vi,addr,val)                                                \
   {                                                                        \
      if ((NI_viImplVISA1) && (*((ViPUInt32)(vi))))                         \
      {                                                                     \
         do (*((ViPUInt8)(val)) = *((volatile ViUInt8 _VI_PTR)(addr)));     \
         while (**((volatile ViUInt8 _VI_PTR _VI_PTR)(vi)) & 0x10);         \
      }                                                                     \
      else                                                                  \
      {                                                                     \
         (viPeek8)((vi),(addr),(val));                                      \
      }                                                                     \
   }

#define viPoke8(vi,addr,val)                                                \
   {                                                                        \
      if ((NI_viImplVISA1) && (*((ViPUInt32)(vi))))                         \
      {                                                                     \
         do (*((volatile ViUInt8 _VI_PTR)(addr)) = ((ViUInt8)(val)));       \
         while (**((volatile ViUInt8 _VI_PTR _VI_PTR)(vi)) & 0x10);         \
      }                                                                     \
      else                                                                  \
      {                                                                     \
         (viPoke8)((vi),(addr),(val));                                      \
      }                                                                     \
   }

#define viPeek16(vi,addr,val)                                               \
   {                                                                        \
      if ((NI_viImplVISA1) && (*((ViPUInt32)(vi))))                         \
      {                                                                     \
         do (*((ViPUInt16)(val)) = *((volatile ViUInt16 _VI_PTR)(addr)));   \
         while (**((volatile ViUInt8 _VI_PTR _VI_PTR)(vi)) & 0x10);         \
      }                                                                     \
      else                                                                  \
      {                                                                     \
         (viPeek16)((vi),(addr),(val));                                     \
      }                                                                     \
   }

#define viPoke16(vi,addr,val)                                               \
   {                                                                        \
      if ((NI_viImplVISA1) && (*((ViPUInt32)(vi))))                         \
      {                                                                     \
         do (*((volatile ViUInt16 _VI_PTR)(addr)) = ((ViUInt16)(val)));     \
         while (**((volatile ViUInt8 _VI_PTR _VI_PTR)(vi)) & 0x10);         \
      }                                                                     \
      else                                                                  \
      {                                                                     \
         (viPoke16)((vi),(addr),(val));                                     \
      }                                                                     \
   }

#define viPeek32(vi,addr,val)                                               \
   {                                                                        \
      if ((NI_viImplVISA1) && (*((ViPUInt32)(vi))))                         \
      {                                                                     \
         do (*((ViPUInt32)(val)) = *((volatile ViUInt32 _VI_PTR)(addr)));   \
         while (**((volatile ViUInt8 _VI_PTR _VI_PTR)(vi)) & 0x10);         \
      }                                                                     \
      else                                                                  \
      {                                                                     \
         (viPeek32)((vi),(addr),(val));                                     \
      }                                                                     \
   }

#define viPoke32(vi,addr,val)                                               \
   {                                                                        \
      if ((NI_viImplVISA1) && (*((ViPUInt32)(vi))))                         \
      {                                                                     \
         do (*((volatile ViUInt32 _VI_PTR)(addr)) = ((ViUInt32)(val)));     \
         while (**((volatile ViUInt8 _VI_PTR _VI_PTR)(vi)) & 0x10);         \
      }                                                                     \
      else                                                                  \
      {                                                                     \
         (viPoke32)((vi),(addr),(val));                                     \
      }                                                                     \
   }

#endif

#endif

#if defined(NIVISA_PXI) || defined(PXISAVISA_PXI)

#if 0
/* The following 2 attributes were incorrectly implemented in earlier
   versions of NI-VISA.  You should now query VI_ATTR_MANF_ID or
   VI_ATTR_MODEL_CODE.  Those attributes contain sub-vendor information
   when it exists.  To get both the actual primary and subvendor codes
   from the device, you should call viIn16 using VI_PXI_CFG_SPACE. */
#define VI_ATTR_PXI_SUB_MANF_ID     (0x3FFF0203UL)
#define VI_ATTR_PXI_SUB_MODEL_CODE  (0x3FFF0204UL)
#endif

#define VI_ATTR_PXI_SRC_TRIG_BUS    (0x3FFF020DUL)
#define VI_ATTR_PXI_DEST_TRIG_BUS   (0x3FFF020EUL)

#define VI_ATTR_PXI_RECV_INTR_SEQ   (0x3FFF4240UL)
#define VI_ATTR_PXI_RECV_INTR_DATA  (0x3FFF4241UL)

#endif

#if defined(NIVISA_USB)

#define VI_ATTR_USB_BULK_OUT_PIPE   (0x3FFF01A2UL)
#define VI_ATTR_USB_BULK_IN_PIPE    (0x3FFF01A3UL)
#define VI_ATTR_USB_INTR_IN_PIPE    (0x3FFF01A4UL)
#define VI_ATTR_USB_CLASS           (0x3FFF01A5UL)
#define VI_ATTR_USB_SUBCLASS        (0x3FFF01A6UL)
#define VI_ATTR_USB_ALT_SETTING     (0x3FFF01A8UL)
#define VI_ATTR_USB_END_IN          (0x3FFF01A9UL)
#define VI_ATTR_USB_NUM_INTFCS      (0x3FFF01AAUL)
#define VI_ATTR_USB_NUM_PIPES       (0x3FFF01ABUL)
#define VI_ATTR_USB_BULK_OUT_STATUS (0x3FFF01ACUL)
#define VI_ATTR_USB_BULK_IN_STATUS  (0x3FFF01ADUL)
#define VI_ATTR_USB_INTR_IN_STATUS  (0x3FFF01AEUL)
#define VI_ATTR_USB_CTRL_PIPE       (0x3FFF01B0UL)

#define VI_USB_PIPE_STATE_UNKNOWN   (-1)
#define VI_USB_PIPE_READY           (0)
#define VI_USB_PIPE_STALLED         (1)

#define VI_USB_END_NONE             (0)
#define VI_USB_END_SHORT            (4)
#define VI_USB_END_SHORT_OR_COUNT   (5)

#endif

#define VI_ATTR_FIREWIRE_DEST_UPPER_OFFSET (0x3FFF01F0UL)
#define VI_ATTR_FIREWIRE_SRC_UPPER_OFFSET  (0x3FFF01F1UL)
#define VI_ATTR_FIREWIRE_WIN_UPPER_OFFSET  (0x3FFF01F2UL)
#define VI_ATTR_FIREWIRE_VENDOR_ID         (0x3FFF01F3UL)
#define VI_ATTR_FIREWIRE_LOWER_CHIP_ID     (0x3FFF01F4UL)
#define VI_ATTR_FIREWIRE_UPPER_CHIP_ID     (0x3FFF01F5UL)

#define VI_FIREWIRE_DFLT_SPACE           (5)

#if defined(__cplusplus) || defined(__cplusplus__)
   }
#endif

#endif



*)

var
  VisaAPILoaded: Boolean = False;

procedure UnloadVisaAPI;

implementation

uses
  Windows;

var
  DLLHandle: THandle;
  ErrorMode: Integer;

procedure UnloadVisaAPI;
begin
  if VisaAPILoaded then
  begin
    if DLLHandle >= 32 then
      FreeLibrary(DLLHandle);
    VisaAPILoaded := False;
  end;
end;



procedure LoadDLL;
begin
  if VisaAPILoaded then Exit;
  ErrorMode := SetErrorMode($8000);
  DLLHandle := LoadLibrary('VISA32.DLL');
  if DLLHandle >= 32 then
  begin
    VisaAPILoaded := True;
    @NIVISA_viClose := GetProcAddress(DLLHandle, 'viClose');
    Assert(@NIVISA_viClose <> nil);
    @NIVISA_viSetAttribute := GetProcAddress(DLLHandle, 'viSetAttribute');
    Assert(@NIVISA_viSetAttribute <> nil);
    @NIVISA_viGetAttribute := GetProcAddress(DLLHandle, 'viGetAttribute');
    Assert(@NIVISA_viGetAttribute <> nil);
    @NIVISA_viOpenDefaultRM := GetProcAddress(DLLHandle, 'viOpenDefaultRM');
    Assert(@NIVISA_viOpenDefaultRM <> nil);
{
    @NIVISA_viStatusDesc := GetProcAddress(DLLHandle, 'viStatusDesc');
    Assert(@NIVISA_viStatusDesc <> nil);
    @NIVISA_viTerminate := GetProcAddress(DLLHandle, 'viTerminate');
    Assert(@NIVISA_viTerminate <> nil);
}
  end
  else
  begin
    VisaAPILoaded := False;
    { Error: visa32.dll could not be loaded !! }
  end;
  SetErrorMode(ErrorMode)
end;

initialization
  LoadDLL;

finalization
  UnloadVisaAPI;

end.