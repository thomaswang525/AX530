`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module mywav(
		input 	      clk50M,
	   input          rst_n,	
		
		input  [31:0]	wav_out_data,
		output     	   wav_rden,
		output [31:0] 	wav_in_data,
		output 	      wav_wren,		
		
 	   input          record_en,                  //录音使能信号
		input          play_en,                    //播音使能信号

		input 	      BCLK,		                   //WM8731 IIS/PCM clock
		input 	      DACLRC,                     //WM8731 左右声道输出
		output 	      DACDAT,	                   //WM8731 语音输出	
		input          ADCLRC,                     //WM8731 左右声道输入                
		input          ADCDAT,					       //WM8731 语音输入			      

		
		output   	   I2C_SCLK,                  //I2C control clk
		inout 	      I2C_SDAT                   //I2C control data
);

//配置WM8731的寄存器
reg_config	reg_config_inst(
	.clock_50m    (clk50M),
	.reset_n      (rst_n),
	.i2c_sdat     (I2C_SDAT),
	.i2c_sclk     (I2C_SCLK)
	);

//发送音频数据,right justified
sinwave_gen sinwave_gen_inst(
	.clock_50M    (clk50M),
	
	.bclk         (BCLK),
	.dacclk       (DACLRC),
	.dacdat       (DACDAT),

	.play_en      (play_en),	
	.wav_out_data (wav_out_data),	
	.wav_rden     (wav_rden)
	);
	
//接收音频数据,right justified
sinwave_store sinwave_store_inst(
	.clock_50M    (clk50M),

	.bclk         (BCLK),
	.adcclk       (ADCLRC),	
	.adcdat       (ADCDAT),

	.record_en    (record_en),	
	.wav_in_data  (wav_in_data),	
	.wav_wren     (wav_wren)
	
	);



endmodule
