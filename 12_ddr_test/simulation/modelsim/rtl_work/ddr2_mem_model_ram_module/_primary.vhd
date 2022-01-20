library verilog;
use verilog.vl_types.all;
entity ddr2_mem_model_ram_module is
    generic(
        ARRAY_DEPTH     : integer := 2048
    );
    port(
        data            : in     vl_logic_vector(31 downto 0);
        rdaddress       : in     vl_logic_vector(24 downto 0);
        wraddress       : in     vl_logic_vector(24 downto 0);
        wrclock         : in     vl_logic;
        wren            : in     vl_logic;
        q               : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ARRAY_DEPTH : constant is 1;
end ddr2_mem_model_ram_module;
