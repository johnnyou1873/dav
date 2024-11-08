// displayEncoder.sv
// you was here! 2024-11-06

module
	displayEncoder(
		input [19:0] result,
		output logic [7:0] displayBits [0:5] // 6x 4-bit outputs
	);
	
	// create signals for the six 4-bit digits
	logic [3:0] digit [0:5];
	
	// instantiate six copies of sevenSegDigit, one for each digit (calculated below)
	sevenSegDigit sevenSegDigit [0:5] (.digit(digit), .displayBits(displayBits));
	
	// the above is equilvant to:
//	sevenSegDigit sevenSegDigit0(.digit(digit[0]), .displayBits(displayBits[0]));
//	sevenSegDigit sevenSegDigit1(.digit(digit[1]), .displayBits(displayBits[1]));
//	sevenSegDigit sevenSegDigit2(.digit(digit[2]), .displayBits(displayBits[2]));
//	sevenSegDigit sevenSegDigit3(.digit(digit[3]), .displayBits(displayBits[3]));
//	sevenSegDigit sevenSegDigit4(.digit(digit[4]), .displayBits(displayBits[4]));
//	sevenSegDigit sevenSegDigit5(.digit(digit[5]), .displayBits(displayBits[5]));
	
	logic [23:0] bcd; // temporary storage of bcd number before going to displayBits
	
	always_comb begin
		// 20-bit binary to 24-bit BCD converter
		bcd = 0;
		for (int i = 0; i < 20; i++) begin
			for (int j = 5; j >= 0; j--) begin
				if (bcd[j*4+:4] >= 5) bcd[j*4+:4] = bcd[j*4+:4] + 4'd3;
			end

			// the loop is expands to:
//			if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 4'd3;
//			if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 4'd3;
//			if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 4'd3;
//			if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 4'd3;
//			if (bcd[19:16] >= 5) bcd[19:16] = bcd[19:16] + 4'd3;
//			if (bcd[23:20] >= 5) bcd[23:20] = bcd[23:20] + 4'd3;

			bcd = {bcd[22:0], result[19-i]};
		end
		
		for (int i = 0; i < 6; i++) begin
			digit[i] <= bcd[i*4+:4];
		end
		
		// the loop expands to:
//		digit[0] <= bcd[3:0];
//		digit[1] <= bcd[7:4];
//		digit[2] <= bcd[11:8];
//		digit[3] <= bcd[15:12];
//		digit[4] <= bcd[19:16];
//		digit[5] <= bcd[23:20];
		
	end
endmodule