module bintoBCD(
		input [9:0] bin,
		input autofrange,
		output reg [11:0] BCD);
		
reg [3:0] unit;
reg [3:0] dec;
reg [3:0] hund;

always @(*) begin
	if (autofrange) begin
		BCD = 12'b1000_1000_1000;
	end
	else if (bin > 10'd0999) begin
		BCD = 12'b1001_1001_1001;
	end
	else begin
		unit = (bin % 10'd0010);
		dec = (((bin % 10'd0100) - (bin % 10'd0010))/10'd0010);
		hund = (((bin % 10'd1000) - (bin % 10'd0100))/10'd100);
		BCD = { hund , dec, unit};
	end
end
endmodule 