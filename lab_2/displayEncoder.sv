// displayEncoder.sv
// You was here! 2024-12-04

module
	displayEncoder(
		input [3:0] digits,
		input shutdown,
		output logic [7:0] displayBits [0:1] // 2x outputs
	);
	
	logic [3:0] digit [0:1];
	
	sevenSegDigit sevenSegDigit [0:1] (.digit(digit), .shutdown(shutdown), .displayBits(displayBits));
	
	logic [7:0] bcd; // temporary storage of bcd number before going to displayBits
	
	always_comb begin
		
		// Double Dabble (binary to BCD) algorithm
		bcd = 0;
		for (int i = 0; i < 4; i++) begin
			for (int j = 1; j >= 0; j--) begin
				if (bcd[j*4+:4] >= 5) bcd[j*4+:4] = bcd[j*4+:4] + 4'd3;
			end
			bcd = { bcd[6:0], digits[3-i] };
		end
		
		for (int i = 0; i < 2; i++) begin
			digit[i] <= bcd[i*4+:4];
		end
		
	end
endmodule