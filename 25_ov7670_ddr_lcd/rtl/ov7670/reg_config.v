//camera中寄存器的配置程序
 module reg_config(clk_25M,
                  i2c_sclk,
                  i2c_sdat,
                  reset,
						reg_conf_done
);

input clk_25M;
input reset;
output reg_conf_done;
output i2c_sclk;
inout i2c_sdat;

reg clock_20k;
reg [15:0]clock_20k_cnt;
reg [1:0]config_step;
reg [8:0]reg_index;
reg [23:0]i2c_data;
reg [15:0]reg_data;
reg start;
reg reg_conf_done_reg;
    
i2c_com u1(

			.clock_i2c(clock_20k),
         .reset(reset),
         .ack(ack),
         .i2c_data(i2c_data),
         .start(start),
         .tr_end(tr_end),
         .i2c_sclk(i2c_sclk),
         .i2c_sdat(i2c_sdat)
);

assign reg_conf_done=reg_conf_done_reg;
//产生i2c控制时钟-20khz    
always@(posedge clk_25M)   
begin
   if(reset)
      begin
        clock_20k<=0;
        clock_20k_cnt<=0;
      end
   else if(clock_20k_cnt<625)
      clock_20k_cnt<=clock_20k_cnt+1'b1;
   else
      begin
         clock_20k<=!clock_20k;
         clock_20k_cnt<=0;
      end
end

////iic寄存器配置过程控制    
always@(posedge clock_20k)    
begin
   if(reset) begin
       config_step<=0;
       start<=0;
       reg_index<=0;
		 reg_conf_done_reg<=0;
   end
   else begin
       if(reg_index<169) begin                     //一共配置165个寄存器       
             case(config_step)
             0:begin
               i2c_data<={8'h42,reg_data};       //OV7670 IIC Device address is 0x42   
               start<=1;
               config_step<=1;
               end
             1:begin
               if(tr_end) begin                  //IIC发送结束  
 					    start<=0;
                   config_step<=2;
                 end
               end
             2:begin
                 reg_index<=reg_index+1'b1;
                 config_step<=0;
               end
             endcase
          end
		 else
         reg_conf_done_reg<=1'b1;	 
     end
 end

	

////OV7670需要配置的寄存器值 24Mhz input clock 30fps PCLK=24Mhz  			
always@(reg_index)   
 begin
    case(reg_index)
	 //0  :    reg_data <= 16'h1206;   //复位，VGA，RGB565 (00:YUV,04:RGB)(8x全局复位)
	 0  :    reg_data <= 16'h1204; //复位，VGA，RGB565 (00:YUV,04:RGB)(8x全局复位)
	 1  :    reg_data <= 16'h40d0;   //RGB565, 00-FF(d0)（YUV下要改01-FE(80)）
	 2  :    reg_data <= 16'h3a04;   //TSLB(TSLB[3], COM13[0])00:YUYV, 01:YVYU, 10:UYVY(CbYCrY), 11:VYUY
	 3  : 	reg_data	<=	16'h3dc8;	//COM13(TSLB[3], COM13[0])00:YUYV, 01:YVYU, 10:UYVY(CbYCrY), 11:VYUY
	 4  : 	reg_data	<= 16'h1e17;	//默认01，Bit[5]水平镜像，Bit[4]竖直镜像
	 5  : 	reg_data	<= 16'h6b00;	//旁路PLL倍频；0x0A：关闭内部LDO；0x00：
	// 5  : 	reg_data	<= 16'h6b0a;	//旁路PLL倍频；0x0A：关闭内部LDO；0x00：	
	 6  : 	reg_data	<= 16'h32b6;	//HREF 控制(80)
	 7  : 	reg_data	<= 16'h1713;	//HSTART 输出格式-行频开始高8位(11) 
	 8  : 	reg_data	<= 16'h1801;	//HSTOP  输出格式-行频结束高8位(61)
	 9  : 	reg_data	<= 16'h1902;	//VSTART 输出格式-场频开始高8位(03)
	 10 : 	reg_data	<= 16'h1a7a;	//VSTOP  输出格式-场频结束高8位(7b)
	 11 : 	reg_data	<= 16'h030a;	//VREF	帧竖直方向控制(00)
	 12 : 	reg_data	<= 16'h0c00;	//DCW使能 禁止(00)
	 13 : 	reg_data	<= 16'h3e00;	//PCLK分频00 Normal，10（1分频）,11（2分频）,12（4分频）,13（8分频）14（16分频）
	 //14 : 	reg_data	<= 16'h7080;	//00:Normal, 80:移位1, 00:彩条, 80:渐变彩条   7000
	 14 : 	reg_data	<= 16'h703a;	//00:Normal, 80:移位1, 00:彩条, 80:渐变彩条   7000
	 //15 : 	reg_data	<= 16'h7100;	//00:Normal, 00:移位1, 80:彩条, 80：渐变彩条  7100
	 15 : 	reg_data	<= 16'h7135;	//00:Normal, 00:移位1, 80:彩条, 80：渐变彩条  7100
	 16 : 	reg_data	<= 16'h7211;	//默认 水平，垂直8抽样(11)        
	 17 : 	reg_data	<= 16'h7300;	//DSP缩放时钟分频00 Normal，10（1分频）,11（2分频）,12（4分频）,13（8分频）14（16分频） 
	 18 : 	reg_data	<= 16'ha202;	//默认 像素始终延迟
	 19 : 	reg_data	<= 16'h1181;	//内部工作时钟设置，直接使用外部时钟源(80)   change from 80 to 81
	 20 : 	reg_data	<= 16'h7a20;
	 21 : 	reg_data	<= 16'h7b1c;
	 22 : 	reg_data	<= 16'h7c28;
	 23 : 	reg_data	<= 16'h7d3c;
	 24 : 	reg_data	<= 16'h7e55;
	 25 : 	reg_data	<= 16'h7f68;
	 26 : 	reg_data	<= 16'h8076;
	 27 : 	reg_data	<= 16'h8180;
	 28 : 	reg_data	<= 16'h8288;
	 29 : 	reg_data	<= 16'h838f;
	 30 : 	reg_data	<= 16'h8496;
	 31 : 	reg_data	<= 16'h85a3;
	 32 : 	reg_data	<= 16'h86af;
	 33 : 	reg_data	<= 16'h87c4;
	 34 : 	reg_data	<= 16'h88d7;
	 35 : 	reg_data	<= 16'h89e8;
	 36 : 	reg_data	<= 16'h13e0;          
	 37 : 	reg_data	<= 16'h0000;
	 38 : 	reg_data	<= 16'h1000;
	 39 : 	reg_data	<= 16'h0d00;
	 40 : 	reg_data	<= 16'h1428;	//
	 41 : 	reg_data	<= 16'ha505;
	 42 : 	reg_data	<= 16'hab07;
	 43 : 	reg_data	<= 16'h2475;
	 44 : 	reg_data	<= 16'h2563;
	 45 : 	reg_data	<= 16'h26a5;
	 46 : 	reg_data	<= 16'h9f78;
	 47 : 	reg_data	<= 16'ha068;
	 48 : 	reg_data	<= 16'ha103;
	 49 : 	reg_data	<= 16'ha6df;
	 50 : 	reg_data	<= 16'ha7df;
	 51 : 	reg_data	<= 16'ha8f0;
	 52 : 	reg_data	<= 16'ha990;
	 53 : 	reg_data	<= 16'haa94;
	 54 : 	reg_data	<= 16'h13ef;	
	 55 : 	reg_data	<= 16'h0e61;
	 56 : 	reg_data	<= 16'h0f4b;
	 57 : 	reg_data	<= 16'h1602;
	 58 : 	reg_data	<= 16'h2102;
	 59 : 	reg_data	<= 16'h2291;
	 60 : 	reg_data	<= 16'h2907;
	 61 : 	reg_data	<= 16'h330b;
	 62 : 	reg_data	<= 16'h350b;
	 63 : 	reg_data	<= 16'h371d;
	 64 : 	reg_data	<= 16'h3871;
	 65 : 	reg_data	<= 16'h392a;
	 66 : 	reg_data	<= 16'h3c78;
	 67 : 	reg_data	<= 16'h4d40;
	 68 : 	reg_data	<= 16'h4e20;
	 69 : 	reg_data	<= 16'h6900;
	 70 : 	reg_data	<= 16'h7419;
	 71 : 	reg_data	<= 16'h8d4f;
	 72 : 	reg_data	<= 16'h8e00;
	 73 : 	reg_data	<= 16'h8f00;
	 74 : 	reg_data	<= 16'h9000;
	 75 : 	reg_data	<= 16'h9100;
	 76 : 	reg_data	<= 16'h9200;
	 77 : 	reg_data	<= 16'h9600;
	 78 : 	reg_data	<= 16'h9a80;
	 79 : 	reg_data	<= 16'hb084;
	 80 : 	reg_data	<= 16'hb10c;
	 81 : 	reg_data	<= 16'hb20e;
	 82 : 	reg_data	<= 16'hb382;
	 83 : 	reg_data	<= 16'hb80a;
    84  :	reg_data	<=	16'h4314;
	 85  :	reg_data	<=	16'h44f0;
	 86  :	reg_data	<=	16'h4534;
	 87  :	reg_data	<=	16'h4658;
	 88  :	reg_data	<=	16'h4728;
	 89  :	reg_data	<=	16'h483a;
	 90  :	reg_data	<=	16'h5988;
	 91  :	reg_data	<=	16'h5a88;
	 92  :	reg_data	<=	16'h5b44;
	 93  :	reg_data	<=	16'h5c67;
	 94  :	reg_data	<=	16'h5d49;
	 95  :	reg_data	<=	16'h5e0e;
	 96  :	reg_data	<=	16'h6404;
	 97  :	reg_data	<=	16'h6520;
	 98  :	reg_data	<=	16'h6605;
	 99  :	reg_data	<=	16'h9404;
	 100 :	reg_data	<=	16'h9508;
	 101 :	reg_data	<=	16'h6c0a;
	 102 :	reg_data	<=	16'h6d55;
	 103 :	reg_data	<=	16'h4f80;	 
	 104 :	reg_data	<=	16'h5080;
	 105 :	reg_data	<= 16'h5100;
	 106 :	reg_data	<= 16'h5222;
	 107 :	reg_data	<= 16'h535e;
	 108 :	reg_data	<= 16'h5480;
	 109 :	reg_data	<= 16'h0903;	 
	 110 :	reg_data	<=	16'h6e11;
	 111 :	reg_data	<=	16'h6f9f;
	 112 :	reg_data	<=	16'h5500;
	 113 :	reg_data	<=	16'h5640;
	 114 :	reg_data	<=	16'h5740;
	 115 :	reg_data	<=	16'h6a40;
	 116 :	reg_data	<=	16'h0140;
	 117 :	reg_data	<=	16'h0240;
	 118 :	reg_data	<=	16'h13e7;
	 119 :	reg_data	<=	16'h1500;
	 120 :	reg_data	<= 16'h589e;
	 121 : 	reg_data	<=	16'h4108;
	 122 : 	reg_data	<=	16'h3f00;             
	 123 : 	reg_data	<=	16'h7505;
	 124 : 	reg_data	<=	16'h76e1;
	 125 : 	reg_data	<=	16'h4c00;
	 126 : 	reg_data	<=	16'h7701;
	 127 : 	reg_data	<=	16'h4b09;
	 128 : 	reg_data	<=	16'hc9f0;                  //16'hc960;
	 129 : 	reg_data	<=	16'h4138;
	 130 : 	reg_data	<=	16'h3411;
//	 131 : 	reg_data	<=	16'h3b02;
	 131 : 	reg_data	<=	16'h3b0a;
	 132 : 	reg_data	<=	16'ha489;
	 133 : 	reg_data	<=	16'h9600;
	 134 : 	reg_data	<=	16'h9730;
	 135 : 	reg_data	<=	16'h9820;
	 136 : 	reg_data	<=	16'h9930;
	 137 : 	reg_data	<=	16'h9a84;
	 138 : 	reg_data	<=	16'h9b29;
	 139 : 	reg_data	<=	16'h9c03;
	 140 : 	reg_data	<=	16'h9d4c;
	 141 : 	reg_data	<=	16'h9e3f;
	 142 : 	reg_data	<=	16'h7804;
	 143 :	reg_data	<=	16'h7901;
	 144 :	reg_data	<= 16'hc8f0;
	 145 :	reg_data	<= 16'h790f;
	 146 :	reg_data	<= 16'hc800;
	 147 :	reg_data	<= 16'h7910;
	 148 :	reg_data	<= 16'hc87e;
	 149 :	reg_data	<= 16'h790a;
	 150 :	reg_data	<= 16'hc880;
	 151 :	reg_data	<= 16'h790b;
	 152 :	reg_data	<= 16'hc801;
	 153 :	reg_data	<= 16'h790c;
	 154 :	reg_data	<= 16'hc80f;
	 155 :	reg_data	<= 16'h790d;
	 156 :	reg_data	<= 16'hc820;
	 157 :	reg_data	<= 16'h7909;
	 158 :	reg_data	<= 16'hc880;
	 159 :	reg_data	<= 16'h7902;
	 160 :	reg_data	<= 16'hc8c0;
	 161 :	reg_data	<= 16'h7903;
	 162 :	reg_data	<= 16'hc840;
	 163 :	reg_data	<= 16'h7905;
	 164 :	reg_data	<= 16'hc830; 
	 165 :	reg_data	<= 16'h7926;
	 166 :	reg_data	<= 16'h2a00;  
	 167 :	reg_data	<= 16'h2b00; 	 
	 168 :	reg_data	<= 16'h9300; 
	 
	 default:reg_data <= 16'h0000;
    endcase      
end	 



endmodule

