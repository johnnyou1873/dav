module noiseGenerator #(
	parameter BASE_SPEED = 50000000
)(
	input clk,
	input rst,
	input [19:0] freq,
	output logic [7:0] out
);

	logic [7:0] phase;
	
	sawtoothGenerator #(.BASE_SPEED(BASE_SPEED)) sawtoothGenerator (.clk(clk), .rst(rst), .freq(freq), .out(phase));

	logic [7:0] noise_lut [0:255];
	initial $readmemh("noise_lut.hex", noise_lut);

	assign out = noise_lut[phase];

endmodule