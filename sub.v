module sub(
	input [15:0] data_x,
	input clk,
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,
	input 		     [1:0]		KEY,
	output		     [9:0]		LEDR,
	input 		     [9:0]		SW );

assign HEX3 = 8'b1111_1111;

wire [9:0] operandi;
wire  [9:0] operandi_n;
wire [9:0] win;
wire [2:0] reset;
wire nothing;
reg [9:0] bin;
wire [13:0] state_c;
wire [9:0] location;
wire [2:0] state;
wire [11:0] BCD;
wire [1:0] times;
reg [3:0] times_c;
reg reset1;
wire enable;

reg [3:0] sn;
reg [3:0] s;
wire [1:0] c;
	
	
	filter proc1(
	.filter (SW[1:0]),
	.accelerometer0 (data_x),
	.clock (clk),
	.smooth_out (operandi) );
	
remapper proc2(
	.in (operandi),
	.out(operandi_n) );

counter10 proc13(
	.clk(clk),
	.state (location) );
	
counter3 proc4(
	.reset (reset[0]),
	.clk (clk),
	.state (state_c[1:0]) );
	
counter2 proc5(
	.reset (reset[1]),
	.clk (clk),
	.state (state_c[3:2]) );
	
counter20 proc7(
	.reset (reset[2]),
	.clk (clk),
	.state (state_c[13:4]) );
	
FSM proc3(
	.win (win),
	.KEY (KEY),
	.nothing (nothing),
	.reset (reset),
	.state_c (state_c),
	.state (state),
	.location (location),
	.LEDR (LEDR),
	.clk (clk),
	.operandi (operandi_n),
	.times (times),
	.enable (enable) );

counter3 proc40(
	.reset (reset1),
	.clk (clk),
	.state (c) );
	
reg [9:0] mem [3:0];
	
always @(posedge clk) begin
	if (enable) begin
		mem[times] <= #1 win;
	end
end 
	
always @(posedge clk) begin
	s <= #1 sn; 
end

initial begin
	s = 3'b00;
	reset1 = 1'b1;
end

always @(*) begin
	if (state == 3'b101) begin
		sn = s;
		case (s)
		3'b000:begin
			reset1 = 1'b0;
			bin = mem[s];
			times_c = 4'b1010 + s;
			if (c ==  2'b10) begin
				sn = 3'b001;
				reset1 = 1'b1;
			end
		end
		3'b001:begin
			reset1 = 1'b0;
			bin = mem[s];
			times_c = 4'b1010 + s;
			if (c ==  2'b10) begin
				sn = 3'b010;
				reset1 = 1'b1;
			end
		end
		3'b010:begin
			reset1 = 1'b0;
			bin = mem[s];
			times_c = 4'b1010 + s;
			if (c ==  2'b10) begin
				sn = 3'b011;
				reset1 = 1'b1;
			end
		end
		3'b011:begin
			reset1 = 1'b0;
			bin = mem[s];
			times_c = 4'b1010 + s;
			if (c ==  2'b10) begin
				sn = 3'b000;
				reset1 = 1'b1;
			end
		end
		endcase
	end
	else begin
		bin = state_c[13:4];
		times_c = 4'b1010 + times;
	end
end

	
bintoBCD proc11(
		.bin (bin),
		.autofrange (1'b0),
		.BCD (BCD) );

seg7 proc8(
	.NUM (BCD[3:0]),
	.point (1'b1),
	.nothing (nothing),
	.HEX0 (HEX0));

seg7 proc9(
	.NUM (BCD[7:4]),
	.point (1'b1),
	.nothing (nothing),
	.HEX0 (HEX1));
	
seg7 proc10(
	.NUM (BCD[11:8]),
	.point (1'b0),
	.nothing (nothing),
	.HEX0 (HEX2));
	
seg7 proc15(
	.NUM ({1'b0, state}),
	.point (1'b1),
	.nothing (1'b0),
	.HEX0 (HEX5)); 
	
seg7 proc16(
	.NUM (times_c),
	.point (1'b1),
	.nothing (1'b0),
	.HEX0 (HEX4));

endmodule 