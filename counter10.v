module counter10(
	input clk,
	output reg [9:0] state );

initial begin
	state = 10'b0000_0000_01;
end	
	
always @(posedge clk) begin
	if (state == 10'b1000_0000_00) begin
		state <= #1 10'b0000_0000_01;
	end
	else begin
		state <= #1 (state << 1'b1 );
	end	
end
endmodule 