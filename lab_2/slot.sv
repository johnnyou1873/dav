// slot.sv
// you was here! 2024-12-04

module slot  #(
	parameter SEED = 4'b0000
)(
	input clk,
	input rst,
	output logic [3:0] digit
);
	
	always @(posedge clk) begin
		if (rst) begin
			digit <= SEED;
		end else begin
			digit <= { digit[0] ^ digit[1], digit[3:1] };
		end
	end
	
//	always_comb begin
//
//	end
	
endmodule