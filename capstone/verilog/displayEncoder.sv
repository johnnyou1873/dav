// displayEncoder.sv
// You was here! 2024-12-04

module
	displayEncoder(
		input [19:0] digits,
		input shutdown,
		output logic [7:0] displayBits [0:5] // 2x outputs
	);
	
	logic [3:0] digit [0:5];
	
	sevenSegDigit sevenSegDigit [0:5] (.digit(digit), .shutdown(shutdown), .displayBits(displayBits));
	
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

			bcd = {bcd[22:0], digits[19-i]};
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