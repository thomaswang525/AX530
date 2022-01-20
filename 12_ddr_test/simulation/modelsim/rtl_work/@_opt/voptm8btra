library verilog;
use verilog.vl_types.all;
entity ddr2_phy_alt_mem_phy_rdata_valid is
    generic(
        FAMILY          : string  := "CYCLONEIII";
        MEM_IF_DQS_WIDTH: integer := 8;
        RDATA_VALID_AWIDTH: integer := 5;
        RDATA_VALID_INITIAL_LAT: integer := 16;
        DWIDTH_RATIO    : integer := 2
    );
    port(
        phy_clk_1x      : in     vl_logic;
        reset_phy_clk_1x_n: in     vl_logic;
        seq_rdata_valid_lat_dec: in     vl_logic;
        seq_rdata_valid_lat_inc: in     vl_logic;
        seq_doing_rd    : in     vl_logic_vector;
        ctl_doing_rd    : in     vl_logic_vector;
        ctl_cal_success : in     vl_logic;
        ctl_rdata_valid : out    vl_logic_vector;
        seq_rdata_valid : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of FAMILY : constant is 1;
    attribute mti_svvh_generic_type of MEM_IF_DQS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of RDATA_VALID_AWIDTH : constant is 1;
    attribute mti_svvh_generic_type of RDATA_VALID_INITIAL_LAT : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH_RATIO : constant is 1;
end ddr2_phy_alt_mem_phy_rdata_valid;
