`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    vga_test 
//
//////////////////////////////////////////////////////////////////////////////////
module vga_disp(
			input        vga_clk,
	      input        vga_rst, 
         input        key1,			
	      input [31:0] ddr_data,          //DDR中的图像数据			

			output       vga_hsync,
			output       vga_vsync,
			output [4:0] vga_r,
			output [5:0] vga_g,
			output [4:0] vga_b,
			output       vga_framesync,
			output       vga_valid,
	      output reg   ddr_rden,
			input        ddr_init_done

    );

//-----------------------------------------------------------//
// 水平扫描参数的设定1280*768 VGA 60FPS_79.5MHz
//-----------------------------------------------------------//
parameter LinePeriod =1664;            //行周期数
parameter H_SyncPulse=128;             //行同步脉冲（Sync a）
parameter H_BackPorch=192;            //显示后沿（Back porch b）
parameter H_ActivePix=1280;            //显示时序段（Display interval c）
parameter H_FrontPorch=64;            //显示前沿（Front porch d）
parameter Hde_start=320;
parameter Hde_end=1600;
//-----------------------------------------------------------//
// 垂直扫描参数的设定1280*768 VGA 60FPS_79.5MHz
//-----------------------------------------------------------//
parameter FramePeriod =790;           //列周期数
parameter V_SyncPulse=7;              //列同步脉冲（Sync o）
parameter V_BackPorch=12;             //显示后沿（Back porch p）
parameter V_ActivePix=768;            //显示时序段（Display interval q）
parameter V_FrontPorch=3;            //显示前沿（Front porch r）
parameter Vde_start=43;              //19+24 实际显示720
parameter Vde_end=763;               //787-24个实际显示720


  reg[10 : 0] x_cnt;
  reg[9 : 0]  y_cnt;
  reg[4 : 0] vga_r_reg;
  reg[5 : 0] vga_g_reg;
  reg[4 : 0] vga_b_reg;  

  
  reg hsync_r;
  reg vsync_r; 
  reg vsync_de;
  reg hsync_de;
 
  reg [31:0] ddr_data_reg;               //ddr的输入数据存储
  reg  sig_data;       
		  
  reg first_read;

  
//----------------------------------------------------------------
////////// 水平扫描计数
//----------------------------------------------------------------
always @ (posedge vga_clk)
       if(1'b0)    x_cnt <= 1;
       else if(x_cnt == LinePeriod) x_cnt <= 1;
       else x_cnt <= x_cnt+ 1;
		 
//----------------------------------------------------------------
////////// 水平扫描信号hsync,hsync_de产生
//----------------------------------------------------------------
always @ (posedge vga_clk)
   begin
       if(1'b0) hsync_r <= 1'b1;
       else if(x_cnt == 1) hsync_r <= 1'b0;             //产生hsync信号
       else if(x_cnt == H_SyncPulse) hsync_r <= 1'b1;
		 
		 		 
	    if(1'b0) hsync_de <= 1'b0;
       else if(x_cnt == Hde_start) hsync_de <= 1'b1;    //产生hsync_de信号
       else if(x_cnt == Hde_end) hsync_de <= 1'b0;					 
 
	end

//----------------------------------------------------------------
////////// 垂直扫描计数
//----------------------------------------------------------------
always @ (posedge vga_clk)
       if(1'b0) y_cnt <= 1;
       else if(y_cnt == FramePeriod) y_cnt <= 1;
       else if(x_cnt == LinePeriod) y_cnt <= y_cnt+1;

//----------------------------------------------------------------
////////// 垂直扫描信号vsync, vsync_de产生
//----------------------------------------------------------------
always @ (posedge vga_clk)
  begin
       if(1'b0) vsync_r <= 1'b1;
       else if(y_cnt == 1) vsync_r <= 1'b0;    //产生vsync信号
       else if(y_cnt == V_SyncPulse) vsync_r <= 1'b1;
		 
	    if(1'b0) vsync_de <= 1'b0;
       else if(y_cnt == Vde_start) vsync_de <= 1'b1;    //产生vsync_de信号
       else if(y_cnt == Vde_end) vsync_de <= 1'b0;	 
  end
		 

//----------------------------------------------------------------
////////// 一帧图像之前提前产生一个ddr读数据
//---------------------------------------------------------------- 
always @(posedge vga_clk)
begin
   if (vga_rst) begin
	    first_read<=1'b0;
     end
   else begin
       if ((x_cnt==Hde_start-1'b1) && (y_cnt==Vde_start-1'b1))      //提前产生一个VGA显示数据
	        first_read<=1'b1;
		 else
		     first_read<=1'b0;		   
	   end
end

//----------------------------------------------------------------
////////// ddr读请求信号产生程序, 32bit的DDR数据转成2个像素输出
//---------------------------------------------------------------- 
 always @(negedge vga_clk)
 begin
   if (vga_rst && ~ddr_init_done) begin
		 ddr_data_reg<=32'd0;
		 vga_r_reg<=5'd0;
		 vga_g_reg<=6'd0;
		 vga_b_reg<=5'd0;
		 sig_data<=1'b0;
		 ddr_rden<=1'b0;   
   end
   else begin
	  if (first_read==1'b1) 
				 ddr_rden<=1'b1;                          //产生第一个数据读信号,让数据准备好     	    
     else if (hsync_de && vsync_de ) begin            //如果vga输出有效的图像数据
	    if(sig_data==1'b0) begin                       //输出第一个像素的图像
             vga_b_reg<=ddr_data_reg[31:27]; 
             vga_g_reg<=ddr_data_reg[26:21];
             vga_r_reg<=ddr_data_reg[20:16];
				 ddr_data_reg<=ddr_data_reg;
				 ddr_rden<=1'b1;                           //ddr读数据请求 				 
				 sig_data<=1'b1;				 
		 end	
	    else begin	                                    //输出第二个像素的图像
				 vga_b_reg<=ddr_data_reg[15:11];
             vga_g_reg<=ddr_data_reg[10:5];
             vga_r_reg<=ddr_data_reg[4:0];	
			    ddr_data_reg<=ddr_data;                 //ddr数据改变							
				 ddr_rden<=1'b0;
				 sig_data<=1'b0;
		 end
     end		 
	  else begin
				vga_b_reg<=5'd0;                    
            vga_g_reg<=6'd0;
            vga_r_reg<=5'd0;
				sig_data<=1'b0;	
				ddr_rden<=1'b0;
			   ddr_data_reg<=ddr_data;                    //ddr数据保持
	  end
	end
end



  assign vga_hsync = hsync_r;
  assign vga_vsync = vsync_r;  
  assign vga_r = (hsync_de & vsync_de)?vga_r_reg:5'b00000;
  assign vga_g = (hsync_de & vsync_de)?vga_g_reg:6'b000000;
  assign vga_b = (hsync_de & vsync_de)?vga_b_reg:5'b00000;
  assign vga_framesync=vga_vsync;
  assign vga_valid=hsync_de && vsync_de;

endmodule
