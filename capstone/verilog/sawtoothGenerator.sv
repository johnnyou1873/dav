module sawtoothGenerator #(
	parameter BASE_SPEED = 50000000
)(
	input clk,
	input rst,
	input [19:0] freq,
	output logic [7:0] out
);
	
	logic [31:0] counter = 0;

	always @(posedge clk) begin
		if (rst || freq == 0) begin
			counter <= 0;
			out <= 0;
		end else if (counter >= (BASE_SPEED / (freq * 256))) begin
			counter <= 0;
			out <= out + 1; // purposefully overflow
		end else begin
			counter <= counter + 1;
		end
	end

endmodule