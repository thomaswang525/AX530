`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    sd_audio 
//////////////////////////////////////////////////////////////////////////////////
module sd_audio(
					input  clk_50m,           //50Mhz clock input
					input rst_n,
					output SD_clk,
					
					output SD_cs,
					output SD_datain,
					input  SD_dataout,
					
					input DACLRC,
					input BCLK,
					output DACDAT,
					
					input ADCLRC,                    //WM8731 左右声道输入
					input ADCDAT,					      //WM8731 语音输入
	
					output I2C_SCLK,
					inout I2C_SDAT				   
					
    );

wire [15:0] wav_data;
wire wav_rden;

wire [31:0]read_sec;
wire read_SD;

wire [7:0]mydata_o;
wire myvalid_o;

wire [7:0]rx_o;
wire init_o;
wire read_o;


//PLL,产生25Mhz的SD CLK
pll	pll_inst(
					
	.areset(~rst_n),
	.inclk0(clk_50m),
	.c0(SD_clk),
	.locked()

);
	
//SD卡初始化程序
sd_initial	sd_initial_inst(
					
	.rst_n(rst_n),
	.SD_clk(SD_clk),
	.SD_cs(SD_cs_i),
	.SD_datain(SD_datain_i),
	.SD_dataout(SD_dataout),
	.rx(),
	.init_o(init_o),
	.state()

);


//SD卡读音乐程序	 
sd_read	sd_read_inst(   
	.SD_clk(SD_clk),
	.SD_cs(SD_cs_r),
	.SD_datain(SD_datain_r),
	.SD_dataout(SD_dataout),
	
	.sec(read_sec),
	.read_req(read_SD),
						
	.mydata_o(mydata_o),
	.myvalid_o(myvalid_o),
	
	.data_come(data_come),
						
	.init(init_o),
			
	.mystate()						
						
    );


//驱动wm8731的部分
mywav	mywav_inst(
	.clk50M(clk_50m),
	.rst_n(rst_n),
	
	.wav_data(wav_data),
	.myvalid(wav_rden),
	
	.DACLRC(DACLRC),
	.BCLK(BCLK),
	.DACDAT(DACDAT),
	
	.I2C_SCLK(I2C_SCLK),
	.I2C_SDAT(I2C_SDAT)
);

//RAM的读写控制程序
ram_rw_control ram_rw_control_inst(
	.clk_50M(clk_50m),
	.SD_clk(SD_clk),
	.init(init_o),
	.data_come(data_come),
	
	
	
	.read_sec(read_sec),
	
	.read_SD(read_SD),
	
	.mydata(mydata_o),
	.myvalid(myvalid_o),
	
	
	.wav_rden(wav_rden),
	.wav_data(wav_data)
    );

assign SD_cs=init_o?SD_cs_r:SD_cs_i;                     //SD_cs信号选择
assign SD_datain=init_o?SD_datain_r:SD_datain_i;         //SD_datain信号选择	 
   	 
	 
endmodule
