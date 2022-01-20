transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {c:/altera/12.1/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {c:/altera/12.1/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {c:/altera/12.1/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {c:/altera/12.1/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {c:/altera/12.1/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cycloneive_ver
vmap cycloneive_ver ./verilog_libs/cycloneive_ver
vlog -vlog01compat -work cycloneive_ver {c:/altera/12.1/quartus/eda/sim_lib/cycloneive_atoms.v}

vlib verilog_libs/cycloneiii_ver
vmap cycloneiii_ver ./verilog_libs/cycloneiii_ver
vlog -vlog01compat -work cycloneiii_ver {c:/altera/12.1/quartus/eda/sim_lib/cycloneiii_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_alt_mem_ddrx_controller_top.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_controller.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_addr_cmd.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_addr_cmd_wrap.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_controller_st_top.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ddr2_odt_gen.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ddr3_odt_gen.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_lpddr2_addr_cmd.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_odt_gen.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_rdwr_data_tmg.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_arbiter.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_burst_gen.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_cmd_gen.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_csr.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_buffer.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_buffer_manager.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_burst_tracking.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_dataid_manager.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_fifo.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_list.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_rdata_path.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_wdata_path.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_decoder.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_decoder_32_syn.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_decoder_64_syn.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_encoder.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_encoder_32_syn.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_encoder_64_syn.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_encoder_decoder_wrapper.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_input_if.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_mm_st_converter.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_rank_timer.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_sideband.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_tbp.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_timing_param.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_phy_alt_mem_phy_seq_wrapper.vo}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_phy.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_example_top.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_controller.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ddr2_odt_gen.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ddr3_odt_gen.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_rdwr_data_tmg.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_arbiter.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_buffer.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_burst_tracking.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_dataid_manager.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_fifo.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_list.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_wdata_path.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_decoder.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_decoder_32_syn.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_encoder.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_encoder_32_syn.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_ecc_encoder_decoder_wrapper.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_input_if.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_mm_st_converter.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_rank_timer.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_phy_alt_mem_phy_pll.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_phy_defines.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_controller_phy.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_example_driver.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_ex_lfsr8.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_alt_mem_ddrx_controller_top.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_addr_cmd.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_addr_cmd_wrap.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_controller_st_top.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_odt_gen.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_burst_gen.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_cmd_gen.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_rdata_path.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_sideband.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_tbp.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/alt_mem_ddrx_timing_param.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_phy_alt_mem_phy_seq_wrapper.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_phy_alt_mem_phy.v}
vcom -93 -work work {E:/Project/AX530/verilog/11_ddr_test/ipcore/ddr2_phy_alt_mem_phy_seq.vhd}

vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore/testbench {E:/Project/AX530/verilog/11_ddr_test/ipcore/testbench/ddr2_mem_model.v}
vlog -vlog01compat -work work +incdir+E:/Project/AX530/verilog/11_ddr_test/ipcore/testbench {E:/Project/AX530/verilog/11_ddr_test/ipcore/testbench/ddr2_example_top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  ddr2_example_top_tb

add wave *
view structure
view signals
run -all
