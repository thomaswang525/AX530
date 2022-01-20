library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_ecc_encoder_64 is
    generic(
        CFG_ECC_ENC_REG : integer := 0
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        data            : in     vl_logic_vector(63 downto 0);
        q               : out    vl_logic_vector(71 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CFG_ECC_ENC_REG : constant is 1;
end alt_mem_ddrx_ecc_encoder_64;
