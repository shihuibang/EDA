module  clk_div_25hz(clk_50Mhz,rst_n,clk_25hz,clk_1hz);
	input clk_50Mhz,rst_n;
	output reg clk_25hz,clk_1hz;

	parameter NUM = 2000000;
	reg[23:0] cnt;
	reg [24:0] counter;
	always@(posedge clk_50Mhz or negedge rst_n) begin
		if(!rst_n)
			begin
				cnt <= 0;
				clk_25hz <= 0;
			end
		else if(cnt == NUM - 1) 
			begin
				cnt <= 0;
				clk_25hz <= ~clk_25hz;
			end
		else
			cnt <= cnt + 1'b1;
	end
	
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

	
endmodule