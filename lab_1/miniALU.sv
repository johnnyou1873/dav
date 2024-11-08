// miniALU.sv
// you was here! 2024-11-06

module
	miniALU(
   	input [3:0] op1,
		input [3:0] op2,
		input operation,
		input sign,
		output logic [19:0] result
   );

   always_comb begin
		if (operation) begin
			if (sign) begin
				result = op1 >> op2;
			end else begin
				result = op1 << op2;
			end
		end else begin
			if (sign) begin
				result = op1 - op2;
			end else begin
				result = op1 + op2;
			end
		end
		
		// this can also be implemented as a single case statement, but requires more logic cells due to the concatenation
//		case ({operation, sign})
//			2'b11: result = op1 >> op2;
//			2'b10: result = op1 << op2;
//			2'b01: result = op1 - op2;
//			2'b00: result = op1 + op2;
//		endcase
   end
endmodule