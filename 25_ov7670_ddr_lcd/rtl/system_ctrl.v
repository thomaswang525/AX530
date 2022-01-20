/*-------------------------------------------------------------------------
Filename			:		system_ctrl.v
===========================================================================
13/02/1
--------------------------------------------------------------------------*/
`timescale 1 ns / 1 ns
module system_ctrl
(
	input 		clk,		//50MHz
	input 		rst_n,		//global reset

	output 		clk_c0,		     //24MHz camera clock
	output 		clk_c1           //9MHz lcd clock

);


//----------------------------------------------
//Component instantiation
wire 	locked;	
pll pll_inst
(
	.inclk0	(clk),
	.areset	(~rst_n),
	.locked	(locked),
			
	.c0		(clk_c0),         //24MHz camera clock
	.c1		(clk_c1)          //9MHz lcd clock

);


endmodule
