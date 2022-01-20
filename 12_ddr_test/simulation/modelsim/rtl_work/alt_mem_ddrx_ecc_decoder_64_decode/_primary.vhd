library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_ecc_decoder_64_decode is
    port(
        data            : in     vl_logic_vector(6 downto 0);
        eq              : out    vl_logic_vector(127 downto 0)
    );
end alt_mem_ddrx_ecc_decoder_64_decode;
