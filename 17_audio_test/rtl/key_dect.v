`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    key_dect 
//////////////////////////////////////////////////////////////////////////////////
module key_dect(
	input         clk50M,
	input         reset_n,
	input         key1,
 	input         ddr_init_done,	 //ddr init done	
	
	output  reg   record_en,       //record enable  
	output  reg   play_en,         //play enable  	
	output  reg   wr_load,	       //ddr write fifo load 	
	output  reg   rd_load	       //ddr read fifo load 

);

reg  [15:0] clk_counter;
wire clk_div;
//clock divide
always @(posedge clk50M)
begin
   if (reset_n==1'b0) 
        clk_counter<=0;
   else
        clk_counter<=clk_counter+1'b1;	
end

assign clk_div=clk_counter[15];

reg [31:0] down_counter;           //按键按下寄存器
reg [31:0] up_counter;             //按键松开寄存器

wire key_up;
wire key_down;

reg key1_r1;
reg key1_r2;
always @(posedge clk_div)
begin
	  key1_r1<=key1;
	  key1_r2<=key1_r1;
end  

assign key_up=~key1_r2 & key1_r1;	   //按键松开
assign key_down=key1_r2 & ~key1_r1;	   //按键按下

//按键按下处理程序,录音
always @(posedge clk_div)
begin
   if (reset_n==1'b0) begin
       down_counter<=0;
		 record_en<=1'b0;
	end
	else begin
	    if (key_down==1'b1) begin                             //如果按钮按下，计时清0
		    down_counter<=0;
		    record_en<=1'b0;
			 wr_load<=1'b1;
       end 	
       else if(key1==1'b0) begin                            //录音开始,并计时                     
	       down_counter<=down_counter+1'b1;
		    record_en<=1'b1;	
			 wr_load<=1'b0;
	    end		 
	    else begin                                           //如果按钮松开
	       down_counter<=down_counter;
		    record_en<=1'b0;
			 wr_load<=1'b0;	
       end
   end 
end


//按键松开处理程序,播音
always @(posedge clk_div)
begin
   if (reset_n==1'b0) begin
       up_counter<=0;
		 play_en<=1'b0;
		 rd_load<=1'b0;
	end
	else begin
	    if (key_up==1'b1) begin                             //如果按钮松开，计时清0
		    up_counter<=0;
		    play_en<=1'b0;
		    rd_load<=1'b1;			 
       end 	
       else if(key1==1'b1) begin  
          if(up_counter<down_counter) begin               //播放开始,并计时到录音的长度 
				 up_counter<=up_counter+1'b1;
				 play_en<=1'b1;
		       rd_load<=1'b0;					 
          end
          else begin
				 up_counter<=up_counter;
				 play_en<=1'b0;
		       rd_load<=1'b0;				 
          end
       end			 
	    else begin                                         //如果按钮松开
	       up_counter<=up_counter;
		    play_en<=1'b0;
		    rd_load<=1'b0;			 
       end
   end 
end


endmodule
