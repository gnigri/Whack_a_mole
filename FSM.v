module FSM(
	output reg [9:0] win,
	input [1:0] KEY,
	output reg nothing,
	output reg [2:0] reset,
	input [13:0] state_c,
	output reg [2:0] state,
	input [9:0] location,
	output reg [9:0] LEDR,
	input clk,
	input [9:0] operandi,
	output reg [1:0] times, 
	output reg enable);
	
reg [2:0] n_state;
reg [9:0] mole;
reg [1:0] times_c;
reg [1:0] turn;

always @(posedge clk) begin
	if (KEY[1] == 1'b0) begin
		state <= #1 3'b001;
		times <= #1 3'b000;
	end
	else begin
		state <= #1 n_state;
		times <= #1 times_c;
	end
end
	
always @(*) begin
	times_c = times;
	n_state = state;
	case (state)
	3'b000:begin
		win = 10'b00_0000_0000;
		LEDR = 10'b00_0000_0000;
		nothing = 1'b1;
		reset[2:0] = 3'b111;
		enable = 1'b0;
		if (KEY[1] == 1'b0) begin
			n_state = 3'b001;
			reset[2:0] = 3'b111;
		end
	end
	3'b001:begin
		nothing = 1'b1;
		win = 10'b00_0000_0000;
		LEDR = 10'b00_0000_0000;
		reset[2:0] = 3'b000;
		if (state_c[1:0] == 2'b10) begin
			n_state = 3'b010;
			reset[2:0] = 3'b110;
		end
	end
	3'b010:begin
		nothing = 1'b0;
		mole = location;
		LEDR = mole;
		reset[2:0] = 3'b000;
		if (state_c[3:2] == 2'b01) begin
			n_state = 3'b011;
		end
	end
	3'b011:begin
		nothing = 1'b0;
		LEDR = operandi;
		reset[2:0] = 3'b000;
		if (state_c[13:4] == 10'd0999) begin
			enable =1'b1;
			win = 10'd0999;
			n_state = 3'b100;
		end
		else if (KEY[0] == 1'b0) begin
			n_state = 3'b111;
		end
	end
	3'b111:begin
		reset[2:0] = 3'b000;
		if (LEDR == mole) begin
				enable = 1'b1;
				win = state_c[13:4];
				n_state = 3'b100;
				reset[2:0] = 3'b111;
		end
		else 
				n_state = 3'b011;
	end
	3'b100:begin
		enable = 1'b0;
		LEDR = 10'b0000_0000_00;
		reset[2:0] = 3'b000;
		reset[0] = 1'b0;
		if (times_c < 2'b11) begin
			n_state = 3'b001;
			reset[0] = 1'b1;
		end
		else if (times_c == 2'b11) begin
			n_state = 3'b101;
		end
		times_c = times +1'b1;
	end
	3'b101:begin
		nothing = 1'b0;
		LEDR = 10'b0000_0000_00;
		reset[2:0] = 3'b000;
		if (KEY[1] == 1'b0) begin
			n_state = 3'b001;
		end
	end
	endcase
end

endmodule 