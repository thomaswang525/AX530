library verilog;
use verilog.vl_types.all;
entity ddr2_phy_alt_mem_phy_mimic is
    generic(
        NUM_MIMIC_SAMPLE_CYCLES: integer := 6;
        SHIFT_REG_COUNTER_WIDTH: vl_notype
    );
    port(
        measure_clk     : in     vl_logic;
        mimic_data_in   : in     vl_logic;
        reset_measure_clk_n: in     vl_logic;
        seq_mmc_start   : in     vl_logic;
        mmc_seq_done    : out    vl_logic;
        mmc_seq_value   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_MIMIC_SAMPLE_CYCLES : constant is 1;
    attribute mti_svvh_generic_type of SHIFT_REG_COUNTER_WIDTH : constant is 3;
end ddr2_phy_alt_mem_phy_mimic;
