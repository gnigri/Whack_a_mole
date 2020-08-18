module remapper(
	input [9:0] in,
	output reg [9:0] out );
	
always @(*) begin
	if (in <= 10'b11_1011_0000) begin
		out = 10'b0000000001;
	end
	else if (in <= 10'b11_1100_0100) begin 
		out = 10'b0000000010;
	end
	else if (in <= 10'b11_11011000) begin
		out = 10'b0000000100;
	end
	else if (in <= 10'b11_11101100) begin
		out = 10'b0000001000;
	end
	else if (in <= 10'b00_0000_0000) begin
		out = 10'b0000010000;
	end
	else if (in <= 10'd0020) begin
		out = 10'b0000100000;
	end
	else if (in <= 10'd0040) begin
		out = 10'b0001000000;
	end
	else if (in <= 10'd0060) begin
		out = 10'b0010000000;
	end
	else if (in <= 10'd0080) begin
		out = 10'b0100000000;
	end
	else begin
		out = 10'b1000000000;
	end
end 

endmodule 