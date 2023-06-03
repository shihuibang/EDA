module  clk_div_4Khz(clk_50Mhz,rst_n,clk_4Khz);
	input clk_50Mhz,rst_n;
	output reg clk_4Khz;

	parameter NUM = 10000;
	reg[13:0] cnt;
	always@(posedge clk_50Mhz or negedge rst_n) begin
		if(!rst_n)
			begin
				cnt <= 0;
				clk_4Khz <= 0;
			end
		else if(cnt == NUM - 1) 
			begin
				cnt <= 0;
				clk_4Khz <= ~clk_4Khz;
			end
		else
			cnt <= cnt + 1'b1;
	end
	
endmodule