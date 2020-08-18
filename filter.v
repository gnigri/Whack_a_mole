module filter(
	input [1:0] filter,
	input [15:0] accelerometer0,
	input clock,
	output reg [9:0] smooth_out);

reg [15:0] sum;

reg [15:0] accelerometer1;
reg [15:0] accelerometer2;
reg [15:0] accelerometer3;
reg [15:0] accelerometer4;
reg [15:0] accelerometer5;
reg [15:0] accelerometer6;
reg [15:0] accelerometer7;
reg [15:0] accelerometer8;
reg [15:0] accelerometer9;
reg [15:0] accelerometer10;
reg [15:0] accelerometer11;
reg [15:0] accelerometer12;
reg [15:0] accelerometer13;
reg [15:0] accelerometer14;
reg [15:0] accelerometer15;

always @(posedge clock) begin
	accelerometer1 <= #1 accelerometer0;
	accelerometer2 <= #1 accelerometer1;
	accelerometer3 <= #1 accelerometer2;
	accelerometer4 <= #1 accelerometer3;
	accelerometer5 <= #1 accelerometer4;
	accelerometer6 <= #1 accelerometer5;
	accelerometer7 <= #1 accelerometer6;
	accelerometer8 <= #1 accelerometer7;
	accelerometer9 <= #1 accelerometer8;
	accelerometer10 <= #1 accelerometer9;
	accelerometer11 <= #1 accelerometer10;
	accelerometer12 <= #1 accelerometer11;
	accelerometer13 <= #1 accelerometer12;
	accelerometer14 <= #1 accelerometer13;
	accelerometer15 <= #1 accelerometer14;
end

	
always @(*) begin

	case (filter) 
		2'b00:begin
			smooth_out = accelerometer0[9:0];
		end
		2'b01:begin 
			sum = accelerometer0 + accelerometer1;
			smooth_out = sum[10:1];
		end
		2'b10:begin
			sum = accelerometer0 + accelerometer1 + accelerometer2 + accelerometer3;
			smooth_out = sum[11:2];
		end
		2'b11:begin
			sum = accelerometer0 + accelerometer1 + accelerometer2 + accelerometer3 + accelerometer4 + accelerometer5 + accelerometer6 + accelerometer7 + accelerometer8 + accelerometer9 + accelerometer10 + accelerometer11 + accelerometer12 + accelerometer13 + accelerometer14 + accelerometer15;
			smooth_out = sum[13:4];
		end
	endcase
end 
endmodule 