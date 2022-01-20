library verilog;
use verilog.vl_types.all;
entity ddr2_ex_lfsr8 is
    generic(
        seed            : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        enable          : in     vl_logic;
        pause           : in     vl_logic;
        load            : in     vl_logic;
        data            : out    vl_logic_vector(7 downto 0);
        ldata           : in     vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of seed : constant is 1;
end ddr2_ex_lfsr8;
