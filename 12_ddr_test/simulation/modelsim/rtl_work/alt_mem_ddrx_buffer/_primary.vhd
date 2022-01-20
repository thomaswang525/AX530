library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_buffer is
    generic(
        ADDR_WIDTH      : integer := 3;
        DATA_WIDTH      : integer := 8;
        REGISTER_OUTPUT : integer := 0
    );
    port(
        ctl_clk         : in     vl_logic;
        ctl_reset_n     : in     vl_logic;
        write_valid     : in     vl_logic;
        write_address   : in     vl_logic_vector;
        write_data      : in     vl_logic_vector;
        read_valid      : in     vl_logic;
        read_address    : in     vl_logic_vector;
        read_data       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of REGISTER_OUTPUT : constant is 1;
end alt_mem_ddrx_buffer;
