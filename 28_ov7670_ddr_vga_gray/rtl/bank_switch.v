/*-------------------------------------------------------------------------
Filename			:		bank_switch.v
Description		:		back switch for ddr read and write.
Modification History	:
Data			By			Version			Change Description
===========================================================================
15/02/1
--------------------------------------------------------------------------*/
module	bank_switch
(
	input				clk,
	input				rst_n,
	input          data_valid,	         //vga数据输出有效
	input				bank_valid,          //ddr2 bank切换请求信号
	input				frame_write_done,    //一副图像采集并写入ddr2完成
	input				frame_read_done,     //一副图像从ddr2读取已经完成
		
	output	reg	[1:0]	wr_bank,
	output	reg	[1:0]	rd_bank,
	output	reg			wr_load,      //ddr write address reset	
	output	reg			rd_load       //ddr read address reset
);


//----------------------------------
//negedge of bank_valid signal
reg	bank_valid_r0, bank_valid_r1;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		bank_valid_r0 <= 0;
		bank_valid_r1 <= 0;
		end
	else
		begin
		bank_valid_r0 <= bank_valid;
		bank_valid_r1 <= bank_valid_r0;
		end
end
wire	bank_switch_flag = (bank_valid_r1 & ~bank_valid_r0) ? 1'b1 : 1'b0;	//检测bank_valid的下降沿

//----------------------------------------
//switch banks--ping pang write
reg	[2:0]	state_write;
always@(negedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		wr_bank <= 2'b00;	//2'b11;
		wr_load <= 0;
		state_write <=3'd0;
		end
	else
		begin
		case(state_write)
		3'd0:	begin	wr_load <= 1'b0;	state_write <= 3'd1;	end
		3'd1:	begin	wr_load <= 1'b1; 	state_write <= 3'd2;	end      //wr_load有效，复位ddr的写地址
		3'd2:	begin	wr_load <= 1'b0; 	state_write <= 3'd3;	end
		3'd3:	begin
				if(bank_switch_flag)    //bank swich请求有效
					state_write <= 3'd4;
				else
					state_write <= 3'd3;
				end
		3'd4:	begin	
				if(frame_write_done)		//to be sure data with the same image has been read 
					begin
					wr_bank <= ~wr_bank;   //写bank地址切换
					state_write <= 3'd0;
					end
				else
					begin
					wr_bank <= wr_bank;
					state_write <= 3'd4;
					end
				end
		default:;
		endcase
		end
end

//----------------------------------------
//switch banks--ping pang read
reg	[2:0]	state_read;
always@(negedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		rd_bank <= 2'b11;	//2'b00;
		rd_load <= 1'b0;
		state_read <=3'd0;
		end
	else
		begin
		case(state_read)
		3'd0:	begin	rd_load <= 1'b0; 	state_read <= 3'd1;	end
		3'd1:	begin	rd_load <= 1'b1;	state_read <= 3'd2;	end    //rd_load有效，复位ddr的读地址
		3'd2:	begin	rd_load <= 1'b0;	state_read <= 3'd3;	end
		3'd3:	begin
				if(bank_switch_flag)		
					state_read <= 3'd4;
				else
					state_read <= 3'd3;
				end
		3'd4:	begin	
				if(frame_read_done && ~data_valid)		//to be sure data with the same image has been read
					begin
					  state_read <= 3'd0;
					  if(wr_bank==rd_bank)        //确认cmos的图像存储已经完成 
					      rd_bank <= ~rd_bank;   //切换读图像的bank
					end
				else
					begin
					rd_bank <= rd_bank;
					state_read <= 3'd4;
					end
				end
		default:;
		endcase
		end
end

endmodule
