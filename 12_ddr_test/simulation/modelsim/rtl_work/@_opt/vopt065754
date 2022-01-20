library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_ecc_decoder_32_altecc_decoder is
    generic(
        CFG_ECC_DECODER_REG: integer := 0
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        data            : in     vl_logic_vector(38 downto 0);
        err_corrected   : out    vl_logic;
        err_detected    : out    vl_logic;
        err_fatal       : out    vl_logic;
        err_sbe         : out    vl_logic;
        q               : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CFG_ECC_DECODER_REG : constant is 1;
end alt_mem_ddrx_ecc_decoder_32_altecc_decoder;
