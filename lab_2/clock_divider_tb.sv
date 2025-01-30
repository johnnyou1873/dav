// clock_divider_tb.sv
// you was here 2024-11-13

`timescale 1ns/1ns

module clock_divider_tb(
	output logic clk,
	output logic clockOut
);

	logic clock;
	logic [19:0] speed;
	logic reset;
	
	clock_divider clock_divider (.clockIn(clock), .speed(speed), .reset(reset), .clockOut(clockOut));
//	clock_divider #(.BASE_SPEED(50)) clock_divider (.clockIn(clock), .speed(speed), .reset(reset), .clockOut(clockOut));;

	always begin
		#5 clock = ~clock;
		clk = clock;
	end
	
	initial begin
		#20;
		clock = 0;
		speed = 20'd1000000;
//		speed = 20'd1;
		reset = 0;
		#2000;
		$stop;
	end

endmodule