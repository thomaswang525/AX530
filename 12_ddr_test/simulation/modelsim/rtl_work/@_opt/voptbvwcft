library verilog;
use verilog.vl_types.all;
entity ddr2_phy_alt_mem_phy_read_dp is
    generic(
        ADDR_COUNT_WIDTH: integer := 4;
        BIDIR_DPINS     : integer := 1;
        DWIDTH_RATIO    : integer := 4;
        MEM_IF_CLK_PS   : integer := 4000;
        FAMILY          : string  := "Stratix II";
        LOCAL_IF_DWIDTH : integer := 256;
        MEM_IF_DQ_PER_DQS: integer := 8;
        MEM_IF_DQS_WIDTH: integer := 8;
        MEM_IF_DWIDTH   : integer := 64;
        MEM_IF_PHY_NAME : string  := "STRATIXII_DQS";
        RDP_INITIAL_LAT : integer := 6;
        RDP_RESYNC_LAT_CTL_EN: integer := 0;
        RESYNC_PIPELINE_DEPTH: integer := 1
    );
    port(
        phy_clk_1x      : in     vl_logic;
        resync_clk_2x   : in     vl_logic;
        reset_phy_clk_1x_n: in     vl_logic;
        reset_resync_clk_2x_n: in     vl_logic;
        seq_rdp_dec_read_lat_1x: in     vl_logic;
        seq_rdp_dmx_swap: in     vl_logic;
        seq_rdp_inc_read_lat_1x: in     vl_logic;
        dio_rdata_h_2x  : in     vl_logic_vector;
        dio_rdata_l_2x  : in     vl_logic_vector;
        ctl_mem_rdata   : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_COUNT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of BIDIR_DPINS : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH_RATIO : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_CLK_PS : constant is 1;
    attribute mti_svvh_generic_type of FAMILY : constant is 1;
    attribute mti_svvh_generic_type of LOCAL_IF_DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DQ_PER_DQS : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DQS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_PHY_NAME : constant is 1;
    attribute mti_svvh_generic_type of RDP_INITIAL_LAT : constant is 1;
    attribute mti_svvh_generic_type of RDP_RESYNC_LAT_CTL_EN : constant is 1;
    attribute mti_svvh_generic_type of RESYNC_PIPELINE_DEPTH : constant is 1;
end ddr2_phy_alt_mem_phy_read_dp;
