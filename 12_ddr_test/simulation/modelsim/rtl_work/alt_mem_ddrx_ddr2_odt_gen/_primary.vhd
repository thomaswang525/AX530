library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_ddr2_odt_gen is
    generic(
        CFG_DWIDTH_RATIO: integer := 2;
        CFG_PORT_WIDTH_ADD_LAT: integer := 3;
        CFG_PORT_WIDTH_OUTPUT_REGD: integer := 1;
        CFG_PORT_WIDTH_TCL: integer := 4
    );
    port(
        ctl_clk         : in     vl_logic;
        ctl_reset_n     : in     vl_logic;
        cfg_tcl         : in     vl_logic_vector;
        cfg_add_lat     : in     vl_logic_vector;
        cfg_burst_length: in     vl_logic_vector(4 downto 0);
        cfg_output_regd : in     vl_logic_vector;
        bg_do_write     : in     vl_logic;
        bg_do_read      : in     vl_logic;
        int_odt_l       : out    vl_logic;
        int_odt_h       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CFG_DWIDTH_RATIO : constant is 1;
    attribute mti_svvh_generic_type of CFG_PORT_WIDTH_ADD_LAT : constant is 1;
    attribute mti_svvh_generic_type of CFG_PORT_WIDTH_OUTPUT_REGD : constant is 1;
    attribute mti_svvh_generic_type of CFG_PORT_WIDTH_TCL : constant is 1;
end alt_mem_ddrx_ddr2_odt_gen;
