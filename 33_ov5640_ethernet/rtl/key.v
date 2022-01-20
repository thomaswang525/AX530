`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module key(
     input key_clk,
     input key1,
	  input frame_over,                    //һ֡ͼ���ͽ���
	  output reg frame_send_en                 //һ֡ͼ����ʹ��

    );

reg [15:0] key1_counter;

 //��ť�������	
  always @(posedge key_clk)
	  begin
	    if (key1==1'b0)                               //�����ťû�а��£��Ĵ���Ϊ0
	       key1_counter<=0;
	    else if ((key1==1'b1)& (key1_counter<=16'hc350))      //�����ť���²�����ʱ������1ms,����      
          key1_counter<=key1_counter+1'b1;
  	  
	    if (frame_over==1'b1) begin
		     frame_send_en<=1'b0;               //���frame����ʹ��
		 end	  
       else if (key1_counter==16'hc349)  begin               //һ�ΰ�ť��Ч���ı���ʾģʽ		   
		     frame_send_en<=1'b1;               
       end	
     end	

endmodule
