library verilog;
use verilog.vl_types.all;
entity ddr2_example_top is
    port(
        clock_source    : in     vl_logic;
        global_reset_n  : in     vl_logic;
        mem_addr        : out    vl_logic_vector(12 downto 0);
        mem_ba          : out    vl_logic_vector(2 downto 0);
        mem_cas_n       : out    vl_logic;
        mem_cke         : out    vl_logic_vector(0 downto 0);
        mem_clk         : inout  vl_logic_vector(0 downto 0);
        mem_clk_n       : inout  vl_logic_vector(0 downto 0);
        mem_cs_n        : out    vl_logic_vector(0 downto 0);
        mem_dm          : out    vl_logic_vector(1 downto 0);
        mem_dq          : inout  vl_logic_vector(15 downto 0);
        mem_dqs         : inout  vl_logic_vector(1 downto 0);
        mem_odt         : out    vl_logic_vector(0 downto 0);
        mem_ras_n       : out    vl_logic;
        mem_we_n        : out    vl_logic;
        pnf             : out    vl_logic;
        pnf_per_byte    : out    vl_logic_vector(3 downto 0);
        test_complete   : out    vl_logic;
        test_status     : out    vl_logic_vector(7 downto 0)
    );
end ddr2_example_top;
