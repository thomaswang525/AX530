library verilog;
use verilog.vl_types.all;
entity ddr2_example_driver is
    port(
        clk             : in     vl_logic;
        local_rdata     : in     vl_logic_vector(31 downto 0);
        local_rdata_valid: in     vl_logic;
        local_ready     : in     vl_logic;
        reset_n         : in     vl_logic;
        local_bank_addr : out    vl_logic_vector(2 downto 0);
        local_be        : out    vl_logic_vector(3 downto 0);
        local_burstbegin: out    vl_logic;
        local_col_addr  : out    vl_logic_vector(9 downto 0);
        local_cs_addr   : out    vl_logic;
        local_read_req  : out    vl_logic;
        local_row_addr  : out    vl_logic_vector(12 downto 0);
        local_size      : out    vl_logic_vector(2 downto 0);
        local_wdata     : out    vl_logic_vector(31 downto 0);
        local_write_req : out    vl_logic;
        pnf_per_byte    : out    vl_logic_vector(3 downto 0);
        pnf_persist     : out    vl_logic;
        test_complete   : out    vl_logic;
        test_status     : out    vl_logic_vector(7 downto 0)
    );
end ddr2_example_driver;
