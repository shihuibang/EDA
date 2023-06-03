module runing(clk_50Mhz,rst_n,h,m,s,stop_clk,hou_temp,min_temp,sec_temp,hou_show,min_show,sec_show,ring);
	input clk_50Mhz,h,m,s,stop_clk,rst_n;
	input [5:0]hou_temp,min_temp,sec_temp;
	output reg[5:0] hou_show,min_show,sec_show;
	output reg ring = 0;
	reg[5:0] hou,min,sec;
	reg [24:0] counter;
	reg clk_1hz;
	reg c = 1;
	
	
	always @(posedge clk_50Mhz or negedge rst_n)begin
	if(!rst_n)begin
		counter <= 25'd0;
		clk_1hz <= 0;
	
	end
	else if(counter == 25000000) begin
		counter <= 25'd0;
		clk_1hz <= ~clk_1hz;
	end
	else
		counter <= counter + 1;		
end
	always @(posedge clk_1hz )begin
//		if(!rst_n)begin
//			hou = 12;
//			min = 13;
//         sec = 14;
//		end
			if(c)begin
				hou = hou_temp;
				min = min_temp;
            sec = sec_temp;
				c = ~c;
			end
			if((h==1&&m==1&&s==1)||(h==1&&m==0&&s==0)||(h==0&&m==1&&s==0)||(h==0&&m==0&&s==1))begin
				hou = hou_temp;
				min = min_temp;
            sec = sec_temp;
			end
			
      

			if(!stop_clk) 
			sec = sec + 1;
			if(sec >= 60)begin
				sec = 0;
				min = min + 1;
			end
			
			if(min >= 60)begin
				min = 0;
				
				hou = hou + 1;
			end
			
			if(hou >= 24)begin
			hou = 0;
			end
			
			if(min == 0 && sec <= 3)
					ring = 1;
				else
					ring = 0;
	end
	
  always @(posedge clk_50Mhz) begin
        hou_show <= hou;
        min_show <= min;
        sec_show <= sec;
    end
	

endmodule