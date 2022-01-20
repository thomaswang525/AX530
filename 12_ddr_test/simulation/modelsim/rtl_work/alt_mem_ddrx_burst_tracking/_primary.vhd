library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_burst_tracking is
    generic(
        CFG_BURSTCOUNT_TRACKING_WIDTH: integer := 7;
        CFG_BUFFER_ADDR_WIDTH: integer := 6;
        CFG_INT_SIZE_WIDTH: integer := 4
    );
    port(
        ctl_clk         : in     vl_logic;
        ctl_reset_n     : in     vl_logic;
        burst_ready     : in     vl_logic;
        burst_valid     : in     vl_logic;
        burst_pending_burstcount: out    vl_logic_vector;
        burst_next_pending_burstcount: out    vl_logic_vector;
        burst_consumed_valid: in     vl_logic;
        burst_counsumed_burstcount: in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CFG_BURSTCOUNT_TRACKING_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CFG_BUFFER_ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CFG_INT_SIZE_WIDTH : constant is 1;
end alt_mem_ddrx_burst_tracking;
