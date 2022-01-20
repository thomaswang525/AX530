library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_ddr3_odt_gen is
    generic(
        CFG_DWIDTH_RATIO: integer := 2;
        CFG_PORT_WIDTH_OUTPUT_REGD: integer := 1;
        CFG_PORT_WIDTH_TCL: integer := 4;
        CFG_PORT_WIDTH_CAS_WR_LAT: integer := 4
    );
    port(
        ctl_clk         : in     vl_logic;
        ctl_reset_n     : in     vl_logic;
        cfg_tcl         : in     vl_logic_vector;
        cfg_cas_wr_lat  : in     vl_logic_vector;
        cfg_output_regd : in     vl_logic_vector;
        bg_do_write     : in     vl_logic;
        bg_do_read      : in     vl_logic;
        bg_do_burst_chop: in     vl_logic;
        int_odt_l       : out    vl_logic;
        int_odt_h       : out    vl_logic;
        int_odt_i_1     : out    vl_logic;
        int_odt_i_2     : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CFG_DWIDTH_RATIO : constant is 1;
    attribute mti_svvh_generic_type of CFG_PORT_WIDTH_OUTPUT_REGD : constant is 1;
    attribute mti_svvh_generic_type of CFG_PORT_WIDTH_TCL : constant is 1;
    attribute mti_svvh_generic_type of CFG_PORT_WIDTH_CAS_WR_LAT : constant is 1;
end alt_mem_ddrx_ddr3_odt_gen;
