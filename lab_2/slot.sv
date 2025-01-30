// slot.sv
// You was here! 2025-01-29
// I'm feeling lucky...

module slot  #(
	parameter SEED = 4'b1000
)(
	input clock,
	input reset,
	output logic [3:0] digit
);
	
	logic [3:0] counter = SEED;
	
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			counter <= SEED;
		end else begin
			counter <= { counter[0] ^ counter[1], counter[3:1] };
		end
	end
	
	always_comb begin
		digit = counter;
	end
	
endmodule