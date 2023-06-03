module control(clk_50Mhz,key,key_press,button_negedge1,button_negedge2,rst_n,show_hou,show_min,show_sec,stop_clk,h,m,s,hou,min,sec,led4);
	input clk_50Mhz,button_negedge1,button_negedge2;
	input [3:0] key,key_press;
	input [3:0] show_hou,show_min,show_sec;
	input rst_n;
	output reg[3:0] stop_clk,h,m,s,led4 = 4'b0000;
	output reg[6:0] hou,min,sec;
	reg[3:0] key_val,prev_key_press = 0;
	
	
	
	always @(*)begin
		hou = show_hou;
		min = show_min;
		sec = show_sec;

		key_val <= key;

		case(key_val)
			4'd1:begin
				led4 = 4'b0001;
				stop_clk <= 1;
				h<=1;
				m<=0;
				s<=0;
			
			end
			4'd2:begin
				led4 = 4'b0010;
				stop_clk <= 1;
				h<=0;
				m<=1;
				s<=0;
				
			end
			4'd3:begin
				led4 = 4'b0100;
				stop_clk <= 1;
				h<=0;
				m<=0;
				s<=1;
				
			end
//			4'd4:begin
//				if(key_press == prev_key_press)begin
//				led4 <= 4'b1100;
//				stop_clk <= 1;
//				if(h==1&&m==0&&s==0) begin hou = hou + 1;key_val <= 0; if (hou >= 24) hou = 0;end
//				if(h==0&&m==1&&s==0) begin min = min + 1;key_val <= 0; if (min >= 60) min = 0;end
//				if(h==0&&m==0&&s==1) begin sec = sec + 1;key_val <= 0; if (sec >= 60) sec = 0;end
//				end
//			end
			
//			4'd5:begin
//				if(key_press == prev_key_press)begin
//				led4 = 4'b0011;
//				stop_clk <= 1;
//				if(h==1&&m==0&&s==0) begin hou = hou - 1; if (hou <= 0) hou = 23;end
//				if(h==0&&m==1&&s==0) begin min = min - 1; if (min <= 0) min = 59;end
//				if(h==0&&m==0&&s==1) begin sec = sec - 1; if (sec <= 0) sec = 59;end
//				end
//			end
			
			4'd6:begin
				led4 = 4'b1000;
				stop_clk <= 0;
				h<=0;
				m<=0;
				s<=0;
				
			end
			4'd7:begin
				stop_clk <= 1;
				led4 = 4'b0101;
				h<=1;
				m<=1;
				s<=1;
				hou = 12;
				min = 12;
				sec = 12;
				
			end
			default: led4 = 4'b0000;
		endcase
		
		
		
		if(button_negedge1)begin
				led4 = 4'b1100;
				stop_clk <= 1;
				if(h==1&&m==0&&s==0) begin hou = hou + 1;key_val <= 0; if (hou >= 24) hou = 0;end
				if(h==0&&m==1&&s==0) begin min = min + 1;key_val <= 0; if (min >= 60) min = 0;end
				if(h==0&&m==0&&s==1) begin sec = sec + 1;key_val <= 0; if (sec >= 60) sec = 0;end
				end
				
		if(button_negedge2)begin
				led4 = 4'b0011;
				stop_clk <= 1;
				if(h==1&&m==0&&s==0) begin hou = hou - 1; if (hou <= 0) hou = 23;end
				if(h==0&&m==1&&s==0) begin min = min - 1; if (min <= 0) min = 59;end
				if(h==0&&m==0&&s==1) begin sec = sec - 1; if (sec <= 0) sec = 59;end
				end
				
				
				
				
		prev_key_press = key_press;
	end

endmodule



//if (key_val == 4) begin
//            sec <= 12;
//				min <= 58;
//				hou <= 23;
//        end
//		
//		if(key_val == 1)begin
//			key1_cnt <= key1_cnt + 1;
//		end
//		if(key1_cnt == 5)begin
//			key1_cnt <= 0;
//		end
//		
//		case(key1_cnt)
//			4'd1:begin 
//				stop_clk <= 1;
//				h <= 1;
//				m <= 0;
//				s <= 0;
//				led4 = 4'b0001;
//			end
//			4'd2:begin
//				h <= 0;
//				m <= 1;
//				s <= 0;
//				led4 <= 4'b0010;
//			end
//			
//			4'd3:begin
//				h <= 0;
//				m <= 0;
//				s <= 1;
//				led4 <= 4'b0100;
//			end
//			4'd4:begin
//				stop_clk <= 0;  // 按下4键，开始计时
//				h <= 0;
//				m <= 0;
//				s <= 0;
//				led4 <= 4'b1000;
//			end
//			
//		endcase
//		
//		if(key_val == 2)begin
//			if(h==1&&m==0&&s==0) begin hou <= hou + 1; if (hou >= 24) hou <= 0;end
//			if(h==0&&m==1&&s==0) begin min <= min + 1; if (min >= 60) min <= 0;end
//			if(h==1&&m==0&&s==0) begin sec <= sec + 1; if (sec >= 60) sec <= 0;end
//		end
//		
//		if(key_val == 3)begin
//			if(h==1&&m==0&&s==0) begin hou <= hou - 1; if (hou < 0) hou <= 23;end
//			if(h==0&&m==1&&s==0) begin min <= min - 1; if (min < 0) min <= 59;end
//			if(h==1&&m==0&&s==0) begin sec <= sec - 1; if (sec < 0) sec <= 59;end
//		end	