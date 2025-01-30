// clockDivider.sv
// You was here! 2024-11-13

module clockDivider #(
	parameter BASE_SPEED = 50000000
)(
	input clockIn,
	input [19:0] speed,
	input reset,
	output logic clockOut
);
	
	logic [31:0] counter;
	
	always @(posedge clockIn) begin
		if (speed == 0) begin
			counter <= counter;
			clockOut <= 0;
		end else if (reset) begin
			counter <= 0;
		end else if (counter >= (BASE_SPEED / (speed * 2))) begin
			// The clock should be toggled here instead of in a separate always_comb block to prevent a level-sensitive comparison
			clockOut <= ~clockOut;
			counter <= 0;
		end else begin
			counter <= counter + 1;
		end
	end
	
endmodule