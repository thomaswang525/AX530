library verilog;
use verilog.vl_types.all;
entity ddr2_phy_alt_mem_phy_reset_pipe is
    generic(
        PIPE_DEPTH      : integer := 4
    );
    port(
        clock           : in     vl_logic;
        pre_clear       : in     vl_logic;
        reset_out       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PIPE_DEPTH : constant is 1;
end ddr2_phy_alt_mem_phy_reset_pipe;
