library verilog;
use verilog.vl_types.all;
entity ddr2_phy_alt_mem_phy_pll is
    port(
        areset          : in     vl_logic;
        inclk0          : in     vl_logic;
        phasecounterselect: in     vl_logic_vector(2 downto 0);
        phasestep       : in     vl_logic;
        phaseupdown     : in     vl_logic;
        scanclk         : in     vl_logic;
        c0              : out    vl_logic;
        c1              : out    vl_logic;
        c2              : out    vl_logic;
        c3              : out    vl_logic;
        c4              : out    vl_logic;
        locked          : out    vl_logic;
        phasedone       : out    vl_logic
    );
end ddr2_phy_alt_mem_phy_pll;
