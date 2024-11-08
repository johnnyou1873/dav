// miniALU_top.sv
// you was here! 2024-11-06

module
	miniALU_top(
		input [9:0] switches,
		output logic [9:0] leds,
		output logic [7:0] displayBits [0:5]
	);

	logic [19:0] result;
	miniALU miniALU(.op1(switches[9:6]), .op2(switches[5:2]), .operation(switches[1]), .sign(switches[0]), .result(result));
	displayEncoder displayEncoder(.result(result), .displayBits(displayBits));
	
	always_comb begin
		leds[9:0] = switches[9:0];
	end
endmodule