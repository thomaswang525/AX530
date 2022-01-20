library verilog;
use verilog.vl_types.all;
entity ddr2_mem_model is
    port(
        mem_addr        : in     vl_logic_vector(12 downto 0);
        mem_ba          : in     vl_logic_vector(2 downto 0);
        mem_cas_n       : in     vl_logic;
        mem_cke         : in     vl_logic;
        mem_clk         : in     vl_logic;
        mem_clk_n       : in     vl_logic;
        mem_cs_n        : in     vl_logic;
        mem_dm          : in     vl_logic_vector(1 downto 0);
        mem_odt         : in     vl_logic;
        mem_ras_n       : in     vl_logic;
        mem_we_n        : in     vl_logic;
        global_reset_n  : out    vl_logic;
        mem_dq          : inout  vl_logic_vector(15 downto 0);
        mem_dqs         : inout  vl_logic_vector(1 downto 0);
        mem_dqs_n       : inout  vl_logic_vector(1 downto 0)
    );
end ddr2_mem_model;
