library verilog;
use verilog.vl_types.all;
entity ddr2_phy_alt_mem_phy_dp_io is
    generic(
        MEM_IF_CLK_PS   : integer := 4000;
        MEM_IF_BANKADDR_WIDTH: integer := 3;
        MEM_IF_CS_WIDTH : integer := 2;
        MEM_IF_DWIDTH   : integer := 64;
        MEM_IF_DM_PINS_EN: integer := 1;
        MEM_IF_DM_WIDTH : integer := 8;
        MEM_IF_DQ_PER_DQS: integer := 8;
        MEM_IF_DQS_CAPTURE_EN: integer := 0;
        MEM_IF_DQS_WIDTH: integer := 8;
        MEM_IF_ROWADDR_WIDTH: integer := 13;
        DLL_DELAY_BUFFER_MODE: string  := "HIGH";
        DQS_OUT_MODE    : string  := "DELAY_CHAIN2";
        DQS_PHASE       : integer := 72
    );
    port(
        reset_resync_clk_2x_n: in     vl_logic;
        resync_clk_2x   : in     vl_logic;
        mem_clk_2x      : in     vl_logic;
        write_clk_2x    : in     vl_logic;
        mem_dm          : out    vl_logic_vector;
        mem_dq          : inout  vl_logic_vector;
        mem_dqs         : inout  vl_logic_vector;
        dio_rdata_h_2x  : out    vl_logic_vector;
        dio_rdata_l_2x  : out    vl_logic_vector;
        wdp_dm_h_2x     : in     vl_logic_vector;
        wdp_dm_l_2x     : in     vl_logic_vector;
        wdp_wdata_h_2x  : in     vl_logic_vector;
        wdp_wdata_l_2x  : in     vl_logic_vector;
        wdp_wdata_oe_2x : in     vl_logic_vector;
        wdp_wdqs_2x     : in     vl_logic_vector;
        wdp_wdqs_oe_2x  : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MEM_IF_CLK_PS : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_BANKADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_CS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DM_PINS_EN : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DM_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DQ_PER_DQS : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DQS_CAPTURE_EN : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DQS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_ROWADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DLL_DELAY_BUFFER_MODE : constant is 1;
    attribute mti_svvh_generic_type of DQS_OUT_MODE : constant is 1;
    attribute mti_svvh_generic_type of DQS_PHASE : constant is 1;
end ddr2_phy_alt_mem_phy_dp_io;
