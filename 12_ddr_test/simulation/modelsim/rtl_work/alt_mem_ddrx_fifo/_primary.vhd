library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_fifo is
    generic(
        CTL_FIFO_DATA_WIDTH: integer := 8;
        CTL_FIFO_ADDR_WIDTH: integer := 3
    );
    port(
        ctl_clk         : in     vl_logic;
        ctl_reset_n     : in     vl_logic;
        get_valid       : out    vl_logic;
        get_ready       : in     vl_logic;
        get_data        : out    vl_logic_vector;
        put_valid       : in     vl_logic;
        put_ready       : out    vl_logic;
        put_data        : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CTL_FIFO_DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CTL_FIFO_ADDR_WIDTH : constant is 1;
end alt_mem_ddrx_fifo;
