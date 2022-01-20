/*-------------------------------------------------------------------------
// Module Name:    audio_test
// function: Key1 push down-record the voice to sdram, after record finish,
//           play the voice from ddr
===========================================================================*/
`timescale 1ns / 1ps
module audio_test
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

	//wm8731 control	
	input            BCLK,           //WM8731 IIS/PCM clock
	input            DACLRC,         //WM8731 左右声道输出
	output           DACDAT,         //WM8731 语音输出					
	input            ADCLRC,         //WM8731 左右声道输入
	input            ADCDAT,			//WM8731 语音输入
	
	output           I2C_SCLK,       //I2C control clk
	inout            I2C_SDAT,       //I2C control data
	
	//led status indication
	output   [3:0]   led
	
);

assign led[0] = ~ddr_init_done;
assign led[1] = ~record_en;
assign led[2] = ~play_en;
assign led[3] = 1'b0;

//-----------------------------------------------       
//按键KEY1检测程序
wire          record_en;
wire          play_en;
wire          wr_load;
wire          rd_load;
key_dect	key_dect_inst(
	.clk50M           (clk),             //global clock  50MHZ
	.key1             (key1),            //key1
	.reset_n          (rst_n),	          //external reset
	
	.ddr_init_done		(ddr_init_done),	 //ddr init done	
	.record_en        (record_en),       //record enable  
	.play_en          (play_en),         //play enable  	
	.wr_load          (wr_load),         //ddr write fifo load 	
	.rd_load          (rd_load)          //ddr read fifo load 	   
	
);

//-----------------------------------------------               
//驱动wm8731的部分
wire			   sys_rd; 						//rdfifo read enable
wire	[31:0]	sys_data_out; 				//rdfifo read data 
wire			   sys_we; 						//rdfifo write enable
wire	[31:0]	sys_data_in; 				//rdfifo write data 
mywav	mywav_inst(
	.clk50M           (clk),                //global clock  50MHZ
	.rst_n			   (rst_n),		          //external reset
	
	.wav_out_data     (sys_data_out),       //ddr audio data output 
	.wav_rden         (sys_rd),             //audio data read
	.wav_in_data      (sys_data_in),        //ddr audio data input      
	.wav_wren         (sys_we),             //audio data write
	
 	.record_en        (record_en),          //record enable   
	.play_en          (play_en),            //play enable  
	
	.BCLK             (BCLK),	             //WM8731 IIS/PCM clock
	.DACLRC           (DACLRC),             //WM8731 左右声道输出
	.DACDAT           (DACDAT),	          //WM8731 语音输出	
	.ADCLRC           (ADCLRC),             //WM8731 左右声道输入
	.ADCDAT           (ADCDAT),				 //WM8731 语音输入
	
	.I2C_SCLK         (I2C_SCLK),           //I2C control clk
	.I2C_SDAT         (I2C_SDAT)            //I2C control data
);




//-------------------------------------
// ddr fifo control 
wire	         ddr_init_done;			   //ddr init done
ddr_2fifo_top	ddr_2fifo_top_inst
(
	//global clock
	.source_clk			   (clk),			         //ddr reference clock
  
	.clk_read				(clk),		            //fifo read clock      
	.clk_write				(clk),	               //fifo write clock
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
	.sys_we	            (sys_we),               //fifo write enable
	.sys_data_in	      (sys_data_in),          //fifo data input	
	.sys_rd	            (sys_rd),	            //fifo read enable
	.sys_data_out	      (sys_data_out),	      //fifo data output
	.wr_load	            (wr_load),	            //ddr write address reset
	.rd_load	            (rd_load)	            //ddr read address reset
	
);




endmodule


