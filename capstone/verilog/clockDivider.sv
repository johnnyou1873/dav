// clockDivider.sv
// You was here! 2024-11-13

module clockDivider #(
	parameter BASE_SPEED = 50000000
)(
	input clk,
	input rst,
	input [19:0] freq,
	output logic clk0
);
	
	logic [31:0] counter = 0;
	
	initial begin
		clk0 = 0;
	end
	
	always @(posedge clk) begin
		if (rst || freq == 0) begin
			counter <= 0;
			clk0 <= 0;
		end else if (counter >= (BASE_SPEED / (freq * 2))) begin
			// The clock should be toggled here instead of in a separate always_comb block to prevent a level-sensitive comparison
			counter <= 0;
			clk0 <= ~clk0;
		end else begin
			counter <= counter + 1;
		end
	end
	
endmodule