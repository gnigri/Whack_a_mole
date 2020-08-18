module seg7(
	input [3:0] NUM,
	input point,
	input nothing,
	output reg [7:0] HEX0
	);
	
	
	always @( * ) begin
		if (nothing) begin
			HEX0[7:0] = 8'b10111111;
		end
		else begin
			case (NUM[3:0])
				4'b0000: begin
					HEX0[7:0] = {point, 7'b100_0000}; 
				end
				
				4'b0001: begin
					HEX0[7:0] = {point, 7'b111_1001}; 
				end
				
				4'b0010: begin
					HEX0[7:0] = {point, 7'b010_0100};
				end
				
				4'b0011: begin
					HEX0[7:0] = {point, 7'b011_0000}; 
				end
					
				4'b0100: begin
					HEX0[7:0] = {point, 7'b001_1001}; 
				end
				
				4'b0101: begin
					HEX0[7:0] = {point, 7'b001_0010}; 
				end
				
				4'b0110: begin
					HEX0[7:0] = {point, 7'b000_0010}; 
				end
				
				4'b0111: begin
					HEX0[7:0] = {point, 7'b111_1000}; 
				end
				
				4'b1000: begin
					HEX0[7:0] = {point, 7'b000_0000}; 
				end
				
				4'b1001: begin
					HEX0[7:0] = {point, 7'b001_0000}; 
				end
				
				4'b1010: begin
					HEX0[7:0] = {point, 7'b000_1000}; 
				end
				
				4'b1011: begin
					HEX0[7:0] = {point, 7'b000_0011}; 
				end
				
				4'b1100: begin
					HEX0[7:0] = {point, 7'b100_0110}; 
				end
				
				4'b1101: begin
					HEX0[7:0] = {point, 7'b010_0001}; 
				end
				
				4'b1110: begin
					HEX0[7:0] = {point, 7'b000_0110}; 
				end
				
				4'b1111: begin
					HEX0[7:0] = {point, 7'b000_1110}; 
				end
			endcase
		end
	end
endmodule 