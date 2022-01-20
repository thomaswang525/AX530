library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_list is
    generic(
        CTL_LIST_WIDTH  : integer := 3;
        CTL_LIST_DEPTH  : integer := 8;
        CTL_LIST_INIT_VALUE_TYPE: string  := "INCR";
        CTL_LIST_INIT_VALID: string  := "VALID"
    );
    port(
        ctl_clk         : in     vl_logic;
        ctl_reset_n     : in     vl_logic;
        list_get_entry_valid: out    vl_logic;
        list_get_entry_ready: in     vl_logic;
        list_get_entry_id: out    vl_logic_vector;
        list_get_entry_id_vector: out    vl_logic_vector;
        list_put_entry_valid: in     vl_logic;
        list_put_entry_ready: out    vl_logic;
        list_put_entry_id: in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CTL_LIST_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CTL_LIST_DEPTH : constant is 1;
    attribute mti_svvh_generic_type of CTL_LIST_INIT_VALUE_TYPE : constant is 1;
    attribute mti_svvh_generic_type of CTL_LIST_INIT_VALID : constant is 1;
end alt_mem_ddrx_list;
