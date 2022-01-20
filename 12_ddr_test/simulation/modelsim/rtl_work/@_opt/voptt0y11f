library verilog;
use verilog.vl_types.all;
entity alt_mem_ddrx_ecc_encoder is
    generic(
        CFG_DATA_WIDTH  : integer := 40;
        CFG_ECC_CODE_WIDTH: integer := 8;
        CFG_ECC_ENC_REG : integer := 0;
        CFG_MMR_DRAM_DATA_WIDTH: integer := 7;
        CFG_MMR_LOCAL_DATA_WIDTH: integer := 7;
        CFG_PORT_WIDTH_ENABLE_ECC: integer := 1
    );
    port(
        ctl_clk         : in     vl_logic;
        ctl_reset_n     : in     vl_logic;
        cfg_local_data_width: in     vl_logic_vector;
        cfg_dram_data_width: in     vl_logic_vector;
        cfg_enable_ecc  : in     vl_logic_vector;
        input_data      : in     vl_logic_vector;
        input_ecc_code  : in     vl_logic_vector;
        input_ecc_code_overwrite: in     vl_logic;
        output_data     : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CFG_DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CFG_ECC_CODE_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CFG_ECC_ENC_REG : constant is 1;
    attribute mti_svvh_generic_type of CFG_MMR_DRAM_DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CFG_MMR_LOCAL_DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CFG_PORT_WIDTH_ENABLE_ECC : constant is 1;
end alt_mem_ddrx_ecc_encoder;
