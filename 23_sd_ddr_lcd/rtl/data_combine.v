/*-------------------------------------------------------------------------
Filename			:		data_combine.v
Description    :     one read request output 96bit data 
==========================================================================*/
module	data_combine
(
	input				clk,
	input				rst_n,
	
	output reg	   sys_rd,            //rdfifo的数据读请求
	input	[31:0]	lcd_data_32,       //rdfifo读出的32bit数据
	input				lcd_rden,          //lcd的读数据请求
	output reg [95:0]	lcd_data_96     //lcd的96bit的读数据输出

);

//----------------------------------
//negedge of lcd_rden signal
reg	lcd_rden_r0, lcd_rden_r1;

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		lcd_rden_r0 <= 0;
		lcd_rden_r1 <= 0;
		end
	else
		begin
		lcd_rden_r0 <= lcd_rden;
		lcd_rden_r1 <= lcd_rden_r0;
		end
end
wire	lcd_rden_flag = (lcd_rden_r1 & ~lcd_rden_r0) ? 1'b1 : 1'b0;	 //检测lcd_rden的下降沿

//----------------------------------------
//generate 6 length read fifo to combine to 96bit 
reg	[2:0]	state_write;
reg 	[3:0]	read_counter;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
          read_counter<=0;
			 lcd_data_96 <= 0;
		    sys_rd <= 1'b0;		
		end
	else
		begin
		case(state_write)
		3'd0:	begin	
		      if (lcd_rden_flag==1'b1) begin //检测到lcd的读请求信号有效，读3次rdfifo里的数据
				   lcd_data_96 <= 0;
             	state_write <= 3'd1;
					read_counter<=0;
		         sys_rd <= 1'b1;      //读rdfifo有效
				end	
				else 
             	state_write <= 3'd0;			   
		end
		3'd1:	begin   
		      if(read_counter==3'd3) begin  //read data from rdfifo is delay one clock, read data at read_counter=1~3
				   read_counter<=3'd0;
		         sys_rd <= 1'b0;
					state_write <= 3'd2;
					lcd_data_96 <= {lcd_data_96[63:0], lcd_data_32};  //组合成96bit           
				end		
				else if(read_counter==3'd2) begin   //sys_rd is valid at read_counter=0~2
			      sys_rd <= 1'b0;
					lcd_data_96 <= {lcd_data_96[63:0], lcd_data_32};  //组合成96bit              
					state_write <= 3'd1;	
				   read_counter <= read_counter + 1'b1;
	         end				
			   else begin	
				   read_counter <= read_counter + 1'b1;
					state_write <= 3'd1;
		         sys_rd <= 1'b1;
					lcd_data_96 <= {lcd_data_96[63:0], lcd_data_32};             					
		      end
		end		
		3'd2:	begin	sys_rd <= 1'b0; state_write <= 3'd0;	end
		default:;
		endcase
		end
end


endmodule
