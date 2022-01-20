/*-------------------------------------------------------------------------
Filename			:		sd_ddr_lcd.v
Description		:		read picture from sd, and store in ddr, display on 4.3' lcd.
===========================================================================*/
`timescale 1ns / 1ps
module sd_ddr_lcd
(
	//global clock 50MHz
	input			clk,	
	input			key1,			   //key1	
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
	
	//LCD port	
	output          lcd_dclk,        //lcd clock out
	output			 lcd_hs,			   //horizontal sync 
	output			 lcd_vs,			   //vertical sync
	output          lcd_de,          //lcd data enable
	output	[7:0]	 lcd_red,		   //LCD R data
	output	[7:0]	 lcd_green,		   //LCD G data
	output	[7:0]	 lcd_blue,		   //LCD B data
	
	//SD SPI interface
	output          SD_clk,          //sd spi clock
	output 		 	 SD_cs,           //sd spi cs
	output 			 SD_datain,       //sd spi data input
	input 			 SD_dataout,      //sd spi data output
	
	//led status indication
	output   [3:0]  led
	
);

assign led[0] = ~ddr_init_done;
assign led[1] = ~sd_init_done;
assign led[2] = ~pic_read_done;
assign led[3] = 1'b0;

//---------------------------------------------
wire	clk_lcd;		   //lcd clock
wire	clk_sd;		   //sd clock

system_ctrl	u_system_ctrl
(
	.clk				   (clk),			//global clock  50MHZ
	.rst_n				(rst_n),		   //external reset

	.clk_c0				(clk_lcd),		//9MHz lcd clock
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
	.init_o           (sd_init_done),   //sd initial done
	.pic_read_done    (pic_read_done)   //sd read finish

);


//-------------------------------------
// lcd display
wire	         ddr_init_done;			   //ddr init done
wire           rd_load;    	         //ddr read address and fifo reset 
wire           data_valid;             //system data output enable 
wire           ddr_rden;               //lcd ddr read data request
wire  [95:0]   ddr_data;               //lcd ddr data
lcd_disp	lcd_disp_inst
(
	//global clock
	.lcd_clk			   (clk_lcd),			//lcd clock
	.lcd_rst				(~rst_n),		   //global reset
	.key1				   (key1),	         //key1 input 
	
	//vga port
	.lcd_dclk         (lcd_dclk),        //lcd clock out
	.lcd_hsync			(lcd_hs),		   //lcd horizontal sync 
	.lcd_vsync			(lcd_vs),		   //lcd vertical sync
	.lcd_de           (lcd_de),		   //lcd data enable        
	.lcd_r			   (lcd_red),			//lcd red data	
	.lcd_g			   (lcd_green),		//lcd red data		
	.lcd_b			   (lcd_blue),			//lcd red data	

	//user interface
	.ddr_rden   		(ddr_rden),			//lcd read enable
	.ddr_data  		   (ddr_data),	//lcd data
	.lcd_framesync	   (data_valid),     //lcd frame sync
	//.ddr_addr_set	   (rd_load),	      //ddr address reset
	.ddr_init_done	   (ddr_init_done),	//ddr init done

);


//-------------------------------------
// ddr fifo control 
wire phy_clk;
wire frame_write_done;
wire frame_read_done;
wire			   sys_rd; 						//rdfifo read enable
wire	[31:0]	sys_data_out; 				//rdfifo read data 
ddr_2fifo_top	ddr_2fifo_top_inst
(
	//global clock
	.source_clk			   (clk),			         //ddr reference clock
	.phy_clk			      (phy_clk),	            //memory user clock     
	.clk_read				(phy_clk),		         //fifo read clock      
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


//-------------------------------------
// data conbine 32->96bit
data_combine data_combine_inst
(
	//global clock
	.clk			         (phy_clk),			      //lcd clock
	.rst_n			      (rst_n),		            //global reset
	
	//data 32->96bit
	.sys_rd			      (sys_rd),		         //fifo read enable
	.lcd_data_32			(sys_data_out),	      //fifo data output
	.lcd_rden			   (ddr_rden),			      //lcd red enable	
	.lcd_data_96			(ddr_data)		         //lcd red data		


);



endmodule


