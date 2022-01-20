library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_ecc_decoder_32_decode is
    port(
        data            : in     vl_logic_vector(5 downto 0);
        eq              : out    vl_logic_vector(63 downto 0)
    );
end alt_mem_ddrx_ecc_decoder_32_decode;
