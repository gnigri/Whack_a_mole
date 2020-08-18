module counter3(
	input reset,
	input clk,
	output reg [1:0] state );

initial begin
	state = 2'b00;
end

//transform clock in 1Hz
reg [24:0] count, count_c;
reg clk_n;
always @(*) begin
	count_c = count + 1;
	clk_n = 1'b0;
	if (count == 25'd25_999_999) begin
		count_c = 25'd00_000_000;
		clk_n = 1'b1;
	end
end
	
always @(posedge clk) begin
	count <= #1 count_c;
	if (reset) begin
			state <= #1 2'b00;
	end
	else if (state == 2'b10) begin
		state <= #1 2'b10;
	end
	else begin
		if (clk_n == 1'b1) begin
			state <= #1 state +1;
		end
	end	
end	
endmodule 