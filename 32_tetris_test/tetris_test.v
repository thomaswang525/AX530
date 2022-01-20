//�����������ʵ�ֵĹ��ܣ� Enter������ʼ��Ϸ
//                           Left���� ��ľ��ƽ��
//                           Right������ľ��ƽ��
//                           Up����   ��ľ����ת
//                           Down���� ��ľ�ҷ�ת


 module tetris_test
 (clk, rst_n,
 right, left, rotateR, rotateL, enter,
 hsync_out, vsync_out, red_o, green_o, blue_o,
 vga_clk
 );
 input clk;
 input rst_n;
 input right;
 input left;
 input rotateR;
 input rotateL;
 input enter;
 output hsync_out;
 output vsync_out;
 output [4:0] red_o;
 output [5:0] green_o;
 output [4:0] blue_o;
 output vga_clk;

 
 /**************************************************/
 
 assign vga_clk = ~clk_40MHz;
 assign red_o = {5{red_out}};
 assign green_o = {6{green_out}};
 assign blue_o = {5{blue_out}};
 
 wire red_out;
 wire green_out;
 wire blue_out; 
 
 wire clk_40MHz;
 
 pll_module U1
 (
  .inclk0(clk),
  .c0(clk_40MHz)
 );
 
 /**************************************************/
 
 wire move_right;
 
 debouncer U2
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .key_in(right),
  .key_out(move_right)
 );
 
 /**************************************************/
 
 wire move_left;
 
 debouncer U3
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .key_in(left),
  .key_out(move_left)
 );
 
 /**************************************************/
 
 wire rotate_r;
 
 debouncer U4
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .key_in(rotateR),
  .key_out(rotate_r)
 );
 
 /**************************************************/
 
 wire rotate_l;
 
 debouncer U5
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .key_in(rotateL),
  .key_out(rotate_l)
 );
 
 /**************************************************/
 
 wire start;
 
 debouncer U6
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .key_in(enter),
  .key_out(start)
 );
 
 /**************************************************/
 
 wire[10:0] ready_col_addr_sig;
 wire[10:0] ready_row_addr_sig;
 wire ready_out_sig;
 wire ready_hsync;
 wire ready_vsync;
 
 ready_sync_module U7
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .ready_col_addr_sig(ready_col_addr_sig),
  .ready_row_addr_sig(ready_row_addr_sig),
  .ready_out_sig(ready_out_sig),
  .ready_hsync(ready_hsync),
  .ready_vsync(ready_vsync)
 );

 /**************************************************/
 
 wire[63:0] tetris_rom_data;
 
 tetris_rom_module U8
 (
  .address(tetris_rom_addr),
  .clock(clk_40MHz),
  .q(tetris_rom_data)
 );
 
 /**************************************************/
 
 wire[8:0] tetris_rom_addr;
 wire ready_red_sig;
 wire ready_green_sig;
 wire ready_blue_sig;
 
 ready_vga_control_module U9
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .ready_col_addr_sig(ready_col_addr_sig),
  .ready_row_addr_sig(ready_row_addr_sig),
  .ready_sig(ready_out_sig),
  .gameready_sig(gameready_sig),
  .tetris_rom_data(tetris_rom_data),
  .tetris_rom_addr(tetris_rom_addr),
  .ready_red_sig(ready_red_sig),
  .ready_green_sig(ready_green_sig),
  .ready_blue_sig(ready_blue_sig)
 );
 
 /**************************************************/
 
 wire[10:0] over_col_addr_sig;
 wire[10:0] over_row_addr_sig;
 wire over_out_sig;
 wire over_hsync;
 wire over_vsync;
 
 over_sync_module U10
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .over_col_addr_sig(over_col_addr_sig),
  .over_row_addr_sig(over_row_addr_sig),
  .over_out_sig(over_out_sig),
  .over_hsync(over_hsync),
  .over_vsync(over_vsync)
 );
 
 /**************************************************/
 
 wire[63:0] over_rom_data;
 
 over_rom_module U11
 (
  .address(over_rom_addr),
  .clock(clk_40MHz),
  .q(over_rom_data)
 );
 
 /**************************************************/
 
 wire[8:0] over_rom_addr;
 wire over_red_sig;
 wire over_green_sig;
 wire over_blue_sig;
 
 over_vga_control_module U12
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .over_col_addr_sig(over_col_addr_sig),
  .over_row_addr_sig(over_row_addr_sig),
  .ready_sig(over_out_sig),
  .over_sig(over_sig),
  .over_rom_data(over_rom_data),
  .over_rom_addr(over_rom_addr),
  .over_red_sig(over_red_sig),
  .over_green_sig(over_green_sig),
  .over_blue_sig(over_blue_sig)
 );
 
 /**************************************************/
 
 wire[10:0] col_addr_sig;
 wire[10:0] row_addr_sig;
 wire hsync;
 wire vsync;
 wire ready_sig;        
 
 game_sync_module U13
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .col_addr_sig(col_addr_sig),
  .row_addr_sig(row_addr_sig),
  .hsync(hsync),
  .vsync(vsync),
  .ready_sig(ready_sig)
 );
 
 /**************************************************/
 
 wire[103:0] next_rom_data;
 wire[7:0] next_rom_addr;
 
 next_rom_module U14
 (
  .address(next_rom_addr),
  .clock(clk_40MHz),
  .q(next_rom_data)
 ); 
 
 /**************************************************/
 
 wire[10:0] h;
 wire[10:0] v;
 wire[359:0] enable_little;
 wire[15:0] enable_moving;
 wire loading_square;
 wire[8:0] little_square_num;
 
 loading_happen U15 
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .move_right(move_right),
  .move_left(move_left),
  .start_sig(start_sig),
  .row_addr_sig(row_addr_sig),
  .blue(blue),
  .h(h),
  .v(v),
  .enable_little(enable_little),
  .enable_moving(enable_moving),
  .loading_square(loading_square),
  .little_square_num(little_square_num),
  .over_out(over_out)
 );
 
 /**************************************************/
 
 wire enable_red_border;
    
 display_border U16 
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .col_addr_sig(col_addr_sig),
  .row_addr_sig(row_addr_sig),
  .enable_red_border(enable_red_border)
 );
 
 /**************************************************/
 
 wire enable_blue_moving;
                                    
 display_moving_square U17 
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .col_addr_sig(col_addr_sig),
  .row_addr_sig(row_addr_sig),
  .h(h),
  .v(v),
  .enable_blue_moving(enable_blue_moving),
  .enable_moving(enable_moving)
 );
 
 /**************************************************/
 
 wire enable_blue_little_flag;
 
 display_little_square U18 
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .col_addr_sig(col_addr_sig),
  .row_addr_sig(row_addr_sig),
  .enable_little(enable_little),
  .enable_blue_little_flag(enable_blue_little_flag)
 );
 
 /**************************************************/
	 
 square_gen U19
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .enable_moving(enable_moving),
  .rotate_r(rotate_r),
  .rotate_l(rotate_l),
  .loading_square(loading_square),
  .little_square_num(little_square_num),
  .enable_little(enable_little)									
 );
 
 /**************************************************/
 
 wire next_yellow_display;
 
 display_next_square U20
 (
  .clk(clk_40MHz), 
  .rst_n(rst_n), 
  .col_addr_sig(col_addr_sig), 
  .row_addr_sig(row_addr_sig), 
  .loading_square(loading_square), 
  .next_yellow_display(next_yellow_display)
 );   
 
 /**************************************************/
 
 wire red;
 wire green;
 wire blue;
 
 game_display U21
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .ready_sig(ready_sig),
  .enable_red_border(enable_red_border),
  .enable_blue_moving(enable_blue_moving),
  .enable_blue_little_flag(enable_blue_little_flag),
  .next_rom_data(next_rom_data),
  .row_addr_sig(row_addr_sig),
  .col_addr_sig(col_addr_sig),
  .next_yellow_display(next_yellow_display),
  .next_rom_addr(next_rom_addr),
  .red(red),
  .green(green),
  .blue(blue)
 );
 
 /**************************************************/
 
 wire over_out;
 wire over_sig;
 wire start_sig;
 wire gameready_sig;
 
 game_process U22
(
 .clk(clk_40MHz),
 .rst_n(rst_n),
 .start(start),
 .over(over_out),
 .start_sig(start_sig),
 .gameready_sig(gameready_sig),
 .over_sig(over_sig)
 );
 
 /**************************************************/
 
 vga_select_module U23
 (
  .clk(clk_40MHz),
  .rst_n(rst_n),
  .start_sig(start_sig),
  .hsync(hsync),
  .vsync(vsync),
  .red(red),
  .green(green),
  .blue(blue),
  .gameready_sig(gameready_sig),
  .ready_hsync(ready_hsync),
  .ready_vsync(ready_vsync),
  .ready_red_sig(ready_red_sig),
  .ready_green_sig(ready_green_sig),
  .ready_blue_sig(ready_blue_sig),
  .over_sig(over_sig),
  .over_hsync(over_hsync),
  .over_vsync(over_vsync),
  .over_red_sig(over_red_sig),
  .over_green_sig(over_green_sig),
  .over_blue_sig(over_blue_sig),
  .hsync_out(hsync_out),
  .vsync_out(vsync_out),
  .red_out(red_out),
  .green_out(green_out),
  .blue_out(blue_out)
 );
 
 /**************************************************/  
                                              
 endmodule
 
 
 
