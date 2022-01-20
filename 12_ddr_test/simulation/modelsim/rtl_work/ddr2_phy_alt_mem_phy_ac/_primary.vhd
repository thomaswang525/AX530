library verilog;
use verilog.vl_types.all;
entity ddr2_phy_alt_mem_phy_ac is
    generic(
        POWER_UP_HIGH   : integer := 1;
        DWIDTH_RATIO    : integer := 4
    );
    port(
        clk_2x          : in     vl_logic;
        reset_2x_n      : in     vl_logic;
        phy_clk_1x      : in     vl_logic;
        ctl_add_1t_ac_lat: in     vl_logic;
        ctl_negedge_en  : in     vl_logic;
        ctl_add_intermediate_regs: in     vl_logic;
        period_sel      : in     vl_logic;
        seq_ac_sel      : in     vl_logic;
        ctl_ac_h        : in     vl_logic;
        ctl_ac_l        : in     vl_logic;
        seq_ac_h        : in     vl_logic;
        seq_ac_l        : in     vl_logic;
        mem_ac          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of POWER_UP_HIGH : constant is 1;
    attribute mti_svvh_generic_type of DWIDTH_RATIO : constant is 1;
end ddr2_phy_alt_mem_phy_ac;
