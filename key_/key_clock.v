module  key_clock(clk_50Mhz,rst_n,key1,key2,DIG,SEL,key_row,key_col,led,led4,buzzer);
	input clk_50Mhz,rst_n,key1,key2;

	input [3:0] key_col;
	output buzzer;
	output [7:0] DIG;
	output [5:0] SEL;
	output [3:0] key_row;
	output [15:0] led;
	output [3:0] led4;
  
	wire [5:0] sec,min,hou,sec_show,min_show,hou_show,sec_back,min_back,hou_back;
	wire [3:0] stop_clk,h,m,s;
	wire [15:0] led16;
	wire ring;
	wire clk_4Khz;
	wire clk_25hz;
	wire clk_1hz;

	clk_div_4Khz U1(clk_50Mhz,rst_n,clk_4Khz);
	
	clk_div_25hz U4(clk_50Mhz,rst_n,clk_25hz,clk_1hz);
	
	key_scan U3(clk_50Mhz,rst_n,key_col,key_row,led,hou_back,min_back,sec_back,stop_clk,h,m,s,hou,min,sec,led4);
	
//	control ctrl(clk_50Mhz,key_vale,key_press,button_negedge1,button_negedge2,rst_n,hou_show,min_show,sec_show,stop_clk,h,m,s,hou,min,sec,led4);
	
	runing U6(clk_50Mhz,rst_n,h,m,s,stop_clk,hou,min,sec,hou_show,min_show,sec_show,ring);
	
	seg7_scan U2(clk_4Khz,clk_50Mhz,rst_n,key_vale,DIG,SEL,sec_show,min_show,hou_show,sec_back,min_back,hou_back);
	
	music_top music(clk_50Mhz,rst_n,ring,buzzer);
	

endmodule