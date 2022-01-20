`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module key(
     input key_clk,
     input key1,
	  input frame_over,                    //一帧图像发送结束
	  output reg frame_send_en                 //一帧图像发送使能

    );

reg [15:0] key1_counter;

 //按钮处理程序	
  always @(posedge key_clk)
	  begin
	    if (key1==1'b0)                               //如果按钮没有按下，寄存器为0
	       key1_counter<=0;
	    else if ((key1==1'b1)& (key1_counter<=16'hc350))      //如果按钮按下并按下时间少于1ms,计数      
          key1_counter<=key1_counter+1'b1;
  	  
	    if (frame_over==1'b1) begin
		     frame_send_en<=1'b0;               //清除frame发送使能
		 end	  
       else if (key1_counter==16'hc349)  begin               //一次按钮有效，改变显示模式		   
		     frame_send_en<=1'b1;               
       end	
     end	

endmodule
