library verilog;
use verilog.vl_types.all;
entity ddr2 is
    port(
        local_address   : in     vl_logic_vector(24 downto 0);
        local_write_req : in     vl_logic;
        local_read_req  : in     vl_logic;
        local_burstbegin: in     vl_logic;
        local_wdata     : in     vl_logic_vector(31 downto 0);
        local_be        : in     vl_logic_vector(3 downto 0);
        local_size      : in     vl_logic_vector(2 downto 0);
        global_reset_n  : in     vl_logic;
        pll_ref_clk     : in     vl_logic;
        soft_reset_n    : in     vl_logic;
        local_ready     : out    vl_logic;
        local_rdata     : out    vl_logic_vector(31 downto 0);
        local_rdata_valid: out    vl_logic;
        local_refresh_ack: out    vl_logic;
        local_init_done : out    vl_logic;
        reset_phy_clk_n : out    vl_logic;
        mem_odt         : out    vl_logic_vector(0 downto 0);
        mem_cs_n        : out    vl_logic_vector(0 downto 0);
        mem_cke         : out    vl_logic_vector(0 downto 0);
        mem_addr        : out    vl_logic_vector(12 downto 0);
        mem_ba          : out    vl_logic_vector(2 downto 0);
        mem_ras_n       : out    vl_logic;
        mem_cas_n       : out    vl_logic;
        mem_we_n        : out    vl_logic;
        mem_dm          : out    vl_logic_vector(1 downto 0);
        phy_clk         : out    vl_logic;
        aux_full_rate_clk: out    vl_logic;
        aux_half_rate_clk: out    vl_logic;
        reset_request_n : out    vl_logic;
        mem_clk         : inout  vl_logic_vector(0 downto 0);
        mem_clk_n       : inout  vl_logic_vector(0 downto 0);
        mem_dq          : inout  vl_logic_vector(15 downto 0);
        mem_dqs         : inout  vl_logic_vector(1 downto 0)
    );
end ddr2;
