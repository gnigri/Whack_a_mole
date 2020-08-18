module teste;

reg  [9:0] operandi_n;
wire [9:0] win;
wire [2:0] reset;
wire nothing;
reg [13:0] state_c;
reg [9:0] location;
wire [2:0] state;
wire [1:0] times;
wire enable;
reg [1:0] KEY;
wire [9:0] LEDR;
reg clk;

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
	
always @(*) begin
	clk <= #1 ~clk;
end 

initial begin
	state_c = 14'b0000_0000_0000_00;
	location = 10'b1000_0000_00;
	operandi_n = location;
	clk = 1'b1;
	KEY[1:0] = 2'b00;
	#10
	KEY[1:0] = 2'b11;
	#20

repeat (4) begin
		$display("state= %h, turn = %h , mole = %d, win = %d", state, times, proc3.mole, win );		
		#10
		state_c[1:0] = 2'b10;
		#10
		$display("state= %h, turn = %h , mole = %d, win = %d", state, times, proc3.mole, win );		#10
		state_c[3:2] = 2'b01;
		#10
		$display("state= %h, turn = %h , mole = %d, win = %d", state, times, proc3.mole, win );
		state_c[13:4] = 10'd0999;
		#10
		KEY[0] =1'b0;
		#10
		KEY[0] =1'b1;
		$display("state= %h, turn = %h , mole = %d, win = %d", state, times, proc3.mole, win );	
		end
end 

endmodule 