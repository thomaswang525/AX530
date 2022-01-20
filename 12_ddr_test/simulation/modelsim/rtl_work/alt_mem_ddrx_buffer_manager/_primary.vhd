library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_buffer_manager is
    generic(
        CFG_BUFFER_ADDR_WIDTH: integer := 6
    );
    port(
        ctl_clk         : in     vl_logic;
        ctl_reset_n     : in     vl_logic;
        writeif_ready   : out    vl_logic;
        writeif_valid   : in     vl_logic;
        writeif_address : in     vl_logic_vector;
        writeif_address_blocked: in     vl_logic;
        buffwrite_valid : out    vl_logic;
        buffwrite_address: out    vl_logic_vector;
        readif_valid    : in     vl_logic;
        readif_address  : in     vl_logic_vector;
        buffread_valid  : out    vl_logic;
        buffread_datavalid: out    vl_logic;
        buffread_address: out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CFG_BUFFER_ADDR_WIDTH : constant is 1;
end alt_mem_ddrx_buffer_manager;
