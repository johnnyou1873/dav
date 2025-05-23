module sineGenerator #(
	parameter BASE_SPEED = 50000000
)(
	input clockIn,
	input [19:0] speed,
	input reset,
	output logic [7:0] out
);

	logic [7:0] sine_lut [0:255];
	initial $readmemh("sine_lut.hex", sine_lut);

	assign out = sine_lut[phase];
	
	logic [7:0] phase = 0;
  	logic [31:0] counter = 0;
	
	always @(posedge clockIn) begin
		if (reset) begin
			counter <= 0;
		end else if (counter >= (BASE_SPEED / (speed * 256))) begin
			counter <= 0;
			phase <= phase + 1; // purposefully overflow
		end else begin
			counter <= counter + 1;
		end
	end

endmodule
