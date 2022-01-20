library verilog;
use verilog.vl_types.all;
entity ddr2_phy_alt_mem_phy_mimic_debug is
    generic(
        NUM_DEBUG_SAMPLES_TO_STORE: integer := 4096;
        PLL_STEPS_PER_CYCLE: integer := 24;
        RAM_WR_ADDRESS_WIDTH: vl_notype
    );
    port(
        measure_clk     : in     vl_logic;
        reset_measure_clk_n: in     vl_logic;
        mimic_recapture_debug_data: in     vl_logic;
        mmc_seq_done    : in     vl_logic;
        mmc_seq_value   : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_DEBUG_SAMPLES_TO_STORE : constant is 1;
    attribute mti_svvh_generic_type of PLL_STEPS_PER_CYCLE : constant is 1;
    attribute mti_svvh_generic_type of RAM_WR_ADDRESS_WIDTH : constant is 3;
end ddr2_phy_alt_mem_phy_mimic_debug;
