/*-------------------------------------------------------------------------
Filename			:		sd_ddr_vga.v
Description		:		read picture from sd, and store in ddr, display on VGA.
===========================================================================*/
`timescale 1ns / 1ps
module sd_ddr_vga
(
	//global clock 50MHz
	input			clk,	
	input       rst_n,
	
	//ddr control
   output  [ 14: 0] mem_addr,			//ddr address
   output  [  2: 0] mem_ba,			//ddr bank address
   output           mem_cas_n,		//ddr column address strobe
   output  [  0: 0] mem_cke,		   //ddr clock enable
   inout   [  0: 0] mem_clk,		   //ddr positive clock
   inout   [  0: 0] mem_clk_n, 	   //ddr negative clock  
   output  [  0: 0] mem_cs_n,			//ddr chip select
   output  [  1: 0] mem_dm,	      //ddr data enable (H:8)
   inout   [ 15: 0] mem_dq,         //ddr data
   inout   [  1: 0] mem_dqs,        //ddr data clock
   output  [  0: 0] mem_odt,        //ddr On-Die Termination
   output           mem_ras_n,		//ddr row address strobe
   output           mem_we_n,  		//ddr write enable
	
	//VGA port	
	output			 vga_hs,			   //horizontal sync 
	output			 vga_vs,			   //vertical sync
	output	[4:0]	 vga_red,		   //VGA R data
	output	[5:0]	 vga_green,		   //VGA G data
	output	[4:0]	 vga_blue,		   //VGA B data
	
	//SD SPI interface
	output          SD_clk,          //sd spi clock
	output 		 	 SD_cs,           //sd spi cs
	output 			 SD_datain,       //sd spi data input
	input 			 SD_dataout,      //sd spi data output
	
	//led status indication
	output   [3:0]  led
	
);

assign led[0] = ~ddr_init_done;          //led1灯亮:ddr初始化成功
assign led[1] = ~sd_init_done;           //led2灯亮:SD初始化成功
assign led[2] = ~pic_read_done;          //led3灯亮:SD图像读取完成
assign led[3] = 1'b0;

//---------------------------------------------
wire	clk_vga;		   //vga clock
wire	clk_sd;		   //sd clock

system_ctrl	u_system_ctrl
(
	.clk				   (clk),			//global clock  50MHZ
	.rst_n				(rst_n),		   //external reset

	.clk_c0				(clk_vga),		//65MHz vga clock
	.clk_c1				(clk_sd)		   //25MHz sd clock

);
 

//-----------------------------------------------               
//SD card ctrl system
wire			   sys_we; 						//wrfifo write enable
wire	[31:0]	sys_data_in; 				//wrfifo write data 
wire           sd_init_done;           //SD initial done
wire           pic_read_done;          //picture read done

SD_TOP	u_SD_TOP
(
	//Global Clock
	.clk			      (clk_sd),			//sd clock	
	.sd_rst_n  		   (rst_n),	         //global reset
	.ddr_init_done	   (ddr_init_done),	//ddr init done
	
	//SD SPI Interface
	.SD_clk			   (SD_clk),         //SD SPI clock 
	.SD_cs			   (SD_cs),          //SD SPI CS	
	.SD_datain			(SD_datain),		//SD SPI data in	
	.SD_dataout			(SD_dataout),		//SD SPI data out

	//Ouput SD Data                 
	.sd_valid		   (sys_we),			//sd data valid
	.sd_data			   (sys_data_in),  	//sd data
	.init_o           (sd_init_done),
	.pic_read_done    (pic_read_done)   //sd read finish

);


//-------------------------------------
// vga display
wire	         ddr_init_done;			   //ddr init done
wire			   sys_rd; 						//rdfifo read enable
wire	[31:0]	sys_data_out; 				//rdfifo read data 
wire           rd_load;    	         //ddr read address and fifo reset 
wire           data_valid;             //system data output enable   
vga_disp	vga_disp_inst
(
	//global clock
	.vga_clk			   (clk_vga),			//vga clock
	.vga_rst				(~rst_n),		   //global reset

	//vga port
	.vga_hsync			(vga_hs),		   //vga horizontal sync 
	.vga_vsync			(vga_vs),		   //vga vertical sync
	.vga_r			   (vga_red),			//vga red data	
	.vga_g			   (vga_green),		//vga red data		
	.vga_b			   (vga_blue),			//vga red data	

	//user interface
	.ddr_rden   		(sys_rd),			//vga read enable
	.ddr_data  		   (sys_data_out),	//vga data
	.vga_framesync	   (data_valid),     //vga frame sync
	.ddr_init_done	   (ddr_init_done)	//ddr init done

);


//-------------------------------------
// ddr fifo control 
wire frame_write_done;
wire frame_read_done;
ddr_2fifo_top	ddr_2fifo_top_inst
(
	//global clock
	.source_clk			   (clk),			         //ddr reference clock
	.clk_read				(clk_vga),		         //fifo read clock      
	.clk_write				(clk_sd),	            //fifo write clock
	.ddr_init_done			(ddr_init_done),	      //ddr init done	
	.rst_n				   (rst_n),		            //global reset
	
	//ddr interface
	.mem_addr			   (mem_addr),		         //ddr address	
	.mem_ba			      (mem_ba),			      //ddr bank address
	.mem_cas_n		      (mem_cas_n),		      //ddr column address strobe
	.mem_cke			      (mem_cke),		         //ddr clock enable 	
	.mem_clk			      (mem_clk),		         //ddr positive clock	
	.mem_clk_n			   (mem_clk_n),		      //ddr negative clock 	
	.mem_cs_n			   (mem_cs_n),		         //ddr chip select		
	.mem_dm			      (mem_dm),		         //ddr data enable 	
	.mem_dq			      (mem_dq),		         //ddr data	
	.mem_dqs			      (mem_dqs),		         //ddr data clock	
	.mem_odt			      (mem_odt),		         //ddr On-Die Termination
	.mem_ras_n		      (mem_ras_n),		      //ddr row address strobe	
	.mem_we_n			   (mem_we_n),		         //ddr write enable
	
	//user interface
	.frame_write_done		(frame_write_done),	   //ddr write one frame
	.frame_read_done  	(frame_read_done),	   //ddr read one frame
	.sys_we	            (sys_we),               //fifo write enable
	.sys_data_in	      (sys_data_in),          //fifo data input	
	.sys_rd	            (sys_rd),	            //fifo read enable
	.sys_data_out	      (sys_data_out),	      //fifo data output
	.wr_load	            (wr_load),	            //ddr write address reset
	.rd_load	            (rd_load),	            //ddr read address reset
	.data_valid	         (data_valid)	         //system data output enable	
	
);



endmodule


