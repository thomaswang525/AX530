library verilog;
use verilog.vl_types.all;
entity ddr2_phy_alt_mem_phy_write_dp_fr is
    generic(
        BIDIR_DPINS     : integer := 1;
        LOCAL_IF_DRATE  : string  := "FULL";
        LOCAL_IF_DWIDTH : integer := 256;
        MEM_IF_DM_WIDTH : integer := 8;
        MEM_IF_DQ_PER_DQS: integer := 8;
        MEM_IF_DQS_WIDTH: integer := 8;
        GENERATE_WRITE_DQS: integer := 1;
        MEM_IF_DWIDTH   : integer := 64;
        DWIDTH_RATIO    : integer := 2;
        MEM_IF_DM_PINS_EN: integer := 1;
        NUM_DUPLICATE_REGS: integer := 4;
        DQ_OE_REPS      : vl_notype
    );
    port(
        phy_clk_1x      : in     vl_logic;
        mem_clk_2x      : in     vl_logic;
        write_clk_2x    : in     vl_logic;
        reset_phy_clk_1x_n: in     vl_logic;
        reset_mem_clk_2x_n: in     vl_logic;
        reset_write_clk_2x_n: in     vl_logic;
        ctl_mem_be      : in     vl_logic_vector;
        ctl_mem_dqs_burst: in     vl_logic_vector;
        ctl_mem_wdata   : in     vl_logic_vector;
        ctl_mem_wdata_valid: in     vl_logic_vector;
        seq_be          : in     vl_logic_vector;
        seq_dqs_burst   : in     vl_logic_vector;
        seq_wdata       : in     vl_logic_vector;
        seq_wdata_valid : in     vl_logic_vector;
        seq_ctl_sel     : in     vl_logic;
        wdp_wdata_h_2x  : out    vl_logic_vector;
        wdp_wdata_l_2x  : out    vl_logic_vector;
        wdp_wdata_oe_2x : out    vl_logic_vector;
        wdp_wdqs_2x     : out    vl_logic_vector;
        wdp_wdqs_oe_2x  : out    vl_logic_vector;
        wdp_dm_h_2x     : out    vl_logic_vector;
        wdp_dm_l_2x     : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BIDIR_DPINS : constant is 1;
    attribute mti_svvh_generic_type of LOCAL_IF_DRATE : constant is 1;
    attribute mti_svvh_generic_type of LOCAL_IF_DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DM_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DQ_PER_DQS : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DQS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of GENERATE_WRITE_DQS : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH_RATIO : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DM_PINS_EN : constant is 1;
    attribute mti_svvh_generic_type of NUM_DUPLICATE_REGS : constant is 1;
    attribute mti_svvh_generic_type of DQ_OE_REPS : constant is 3;
end ddr2_phy_alt_mem_phy_write_dp_fr;
