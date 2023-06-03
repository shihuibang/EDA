module  seg7_scan(clk_4Khz,clk_50Mhz,rst_n,key_val,DIG_OUT,SEL,sec,min,hou,sec_back,min_back,hou_back);
	
	input clk_4Khz,rst_n,clk_50Mhz;
	input [3:0] key_val;
	input [5:0] sec,min,hou;
	output reg[5:0] sec_back,min_back,hou_back;
	output reg[7:0] DIG_OUT;
	output reg[5:0] SEL;
	reg clk_1hz;
	
//	reg[6:0] sec_orign = 12,min_orign = 58,hou_orign = 23;
	reg[6:0] val;
//	reg[23:0] cnt;
//	reg [24:0] counter;
//	reg stop_clk = 0;
	reg [5:0] current_state,next_state;
	
	parameter SEL0 = 6'b11_1111;
	parameter SEL_sec0 = 6'b01_1111;
	parameter SEL_sec1 = 6'b10_1111;
	parameter SEL_min0 = 6'b11_0111;
	parameter SEL_min1 = 6'b11_1011;
	parameter SEL_hou0 = 6'b11_1101;
	parameter SEL_hou1 = 6'b11_1110;
	
	always @(posedge clk_50Mhz )begin
		sec_back <= sec;
		min_back <= min;
		hou_back <= hou;
end
//	
//	reg sec_temp;

	
//	always @(posedge clk_1hz )begin
//	
////	sec = key_sec;min = key_min;hou = key_hou;
//		
//			if(!stop_clk) sec = sec + 1;
//			if(sec == 60)begin
//				sec = 0;
//				min = min + 1;
//			end
//			
//			if(min == 60)begin
//				min = 0;
//				hou = hou + 1;
//			end
//			
//			if(hou == 24)begin
//				hou = 0;
//			end
//	end
	
//	
//	reg[3:0] key1_cnt = 0;
//	reg h,m,s;
//	reg[6:0] key_sec,key_min,key_hou;
//	key_sec = sec,
//	key_min = min,
//	key_hou = hou,
//	
//		always @(key_val)begin
//		
//		if (key_val == 4) begin
////            sec = 12;
////				min = 58;
////				hou = 23;
//        end
//		
//		if(key_val == 1)begin
//			key1_cnt = key1_cnt + 1;
//		end
//		if(key1_cnt == 5)begin
//			key1_cnt = 0;
//		end
//		
//		case(key1_cnt)
//			4'd1:begin 
//				stop_clk = 1;
//				h = 1;
//				m = 0;
//				s = 0;
//			end
//			4'd2:begin
//				h = 0;
//				m = 1;
//				s = 0;
//			end
//			
//			4'd3:begin
//				h = 0;
//				m = 0;
//				s = 1;
//			end
//			4'd4:begin
//				stop_clk = 0;  // 按下4键，开始计时
//				h = 0;
//				m = 0;
//				s = 0;
//			end
//			
//		endcase
//		
//		if(key_val == 2)begin
//			if(h==1&&m==0&&s==0) begin key_hou = key_hou + 1; if (key_hou >= 24) key_hou = 0;end
//			if(h==0&&m==1&&s==0) begin key_min = key_min + 1; if (key_min >= 60) key_min = 0;end
//			if(h==1&&m==0&&s==0) begin key_sec = key_sec + 1; if (key_sec >= 60) key_sec = 0;end
//		end
//		
//		if(key_val == 3)begin
//			if(h==1&&m==0&&s==0) begin key_hou = key_hou - 1; if (key_hou < 0) key_hou = 23;end
//			if(h==0&&m==1&&s==0) begin key_min = key_min - 1; if (key_min < 0) key_min = 59;end
//			if(h==1&&m==0&&s==0) begin key_sec = key_sec - 1; if (key_sec < 0) key_sec = 59;end
//		end	
//	end
//	
//		
//		if(key1_cnt == 1) begin
//			stop_clk = 1;
//		end
//		else begin
//			stop_clk = 0;
//		end
//		

	
	
	always @(posedge clk_4Khz or negedge rst_n)begin
		if(!rst_n)
			current_state <= SEL0;
		else
			current_state <= next_state;
		
	end
	
	
	always @(current_state)begin
		case(current_state)
			SEL0:next_state = SEL_sec0;
			SEL_sec0:next_state = SEL_sec1;
			SEL_sec1:next_state = SEL_min0;
			SEL_min0:next_state = SEL_min1;
			SEL_min1:next_state = SEL_hou0;
			SEL_hou0:next_state = SEL_hou1;
			SEL_hou1:next_state = SEL0;
		endcase
	end
	
	always @(current_state)begin
		
		case(current_state)
			SEL_sec0:
				begin
					val = sec % 10;
					SEL = SEL_sec0;
					case(val)
						4'd0: DIG_OUT <= 8'b1100_0000;//0
						4'd1: DIG_OUT <= 8'b1111_1001;//1
						4'd2: DIG_OUT <= 8'b1010_0100;//2
						4'd3: DIG_OUT <= 8'b1011_0000;//3
						4'd4: DIG_OUT <= 8'b1001_1001;//4
						4'd5: DIG_OUT <= 8'b1001_0010;//5
						4'd6: DIG_OUT <= 8'b1000_0010;//6
						4'd7: DIG_OUT <= 8'b1111_1000;//7
						4'd8: DIG_OUT <= 8'b1000_0000;//8
						4'd9: DIG_OUT <= 8'b1001_0000;//9
					endcase
				end
			SEL_sec1:
				begin
					val = sec / 10;
					SEL = SEL_sec1;
					case(val)
						4'd0: DIG_OUT <= 8'b1100_0000;//0
						4'd1: DIG_OUT <= 8'b1111_1001;//1
						4'd2: DIG_OUT <= 8'b1010_0100;//2
						4'd3: DIG_OUT <= 8'b1011_0000;//3
						4'd4: DIG_OUT <= 8'b1001_1001;//4
						4'd5: DIG_OUT <= 8'b1001_0010;//5
						4'd6: DIG_OUT <= 8'b1000_0010;//6
						4'd7: DIG_OUT <= 8'b1111_1000;//7
						4'd8: DIG_OUT <= 8'b1000_0000;//8
						4'd9: DIG_OUT <= 8'b1001_0000;//9
					endcase
				end
			SEL_min0:
				begin
					val = min % 10;
					SEL = SEL_min0;
					case(val)
						4'd0: DIG_OUT <= 8'b0100_0000;//0
						4'd1: DIG_OUT <= 8'b0111_1001;//1
						4'd2: DIG_OUT <= 8'b0010_0100;//2
						4'd3: DIG_OUT <= 8'b0011_0000;//3
						4'd4: DIG_OUT <= 8'b0001_1001;//4
						4'd5: DIG_OUT <= 8'b0001_0010;//5
						4'd6: DIG_OUT <= 8'b0000_0010;//6
						4'd7: DIG_OUT <= 8'b0111_1000;//7
						4'd8: DIG_OUT <= 8'b0000_0000;//8
						4'd9: DIG_OUT <= 8'b0001_0000;//9
					endcase
				end
			
			SEL_min1:
				begin
					val = min / 10;
					SEL = SEL_min1;
					case(val)
						4'd0: DIG_OUT <= 8'b1100_0000;//0
						4'd1: DIG_OUT <= 8'b1111_1001;//1
						4'd2: DIG_OUT <= 8'b1010_0100;//2
						4'd3: DIG_OUT <= 8'b1011_0000;//3
						4'd4: DIG_OUT <= 8'b1001_1001;//4
						4'd5: DIG_OUT <= 8'b1001_0010;//5
						4'd6: DIG_OUT <= 8'b1000_0010;//6
						4'd7: DIG_OUT <= 8'b1111_1000;//7
						4'd8: DIG_OUT <= 8'b1000_0000;//8
						4'd9: DIG_OUT <= 8'b1001_0000;//9
					endcase
				end
			SEL_hou0:
				begin
					val = hou % 10;
					SEL = SEL_hou0;
					case(val)
						4'd0: DIG_OUT <= 8'b0100_0000;//0
						4'd1: DIG_OUT <= 8'b0111_1001;//1
						4'd2: DIG_OUT <= 8'b0010_0100;//2
						4'd3: DIG_OUT <= 8'b0011_0000;//3
						4'd4: DIG_OUT <= 8'b0001_1001;//4
						4'd5: DIG_OUT <= 8'b0001_0010;//5
						4'd6: DIG_OUT <= 8'b0000_0010;//6
						4'd7: DIG_OUT <= 8'b0111_1000;//7
						4'd8: DIG_OUT <= 8'b0000_0000;//8
						4'd9: DIG_OUT <= 8'b0001_0000;//9
					endcase
				end
			SEL_hou1:
				begin
					val = hou / 10;
					SEL = SEL_hou1;
					case(val)
						4'd0: DIG_OUT <= 8'b1100_0000;//0
						4'd1: DIG_OUT <= 8'b1111_1001;//1
						4'd2: DIG_OUT <= 8'b1010_0100;//2
						4'd3: DIG_OUT <= 8'b1011_0000;//3
						4'd4: DIG_OUT <= 8'b1001_1001;//4
						4'd5: DIG_OUT <= 8'b1001_0010;//5
						4'd6: DIG_OUT <= 8'b1000_0010;//6
						4'd7: DIG_OUT <= 8'b1111_1000;//7
						4'd8: DIG_OUT <= 8'b1000_0000;//8
						4'd9: DIG_OUT <= 8'b1001_0000;//9
					endcase
				end
		endcase
	end
	
endmodule