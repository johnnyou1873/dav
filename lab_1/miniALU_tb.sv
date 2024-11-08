// miniALU_tb.sv
// you was here! 2024-11-05

// this testbench tests all possible inputs to the miniALU against their expected values

`timescale 1ns/1ns						// this is a directive for our simulation

module
	miniALU_tb(
		output [19:0] result
	);

	logic [3:0] op1;
	logic [3:0] op2;
	logic operation;
	logic sign;
	
	task addition_operation();
		operation <= 0;
		sign <= 0;
	endtask

	task subtraction_operation();
		operation <= 0;
		sign <= 1;
	endtask

	task leftShift_operation();
		operation <= 1;
		sign <= 0;
	endtask

	task rightShift_operation();
		operation <= 1;
		sign <= 1;
	endtask
	
	miniALU UUT(
		.op1(op1),
		.op2(op2),
		.operation(operation),
		.sign(sign),
		.result(result)
	);
	
	initial begin
		for (int i = 0; i < 15; i++) begin
			op1[3:0] = i[3:0];
			for (int j = 0; j < 15; j++) begin
				op2[3:0] = j[3:0];
				addition_operation();
				#5 // simulation delay
				assert (result[19:0] == (op1 + op2));
				subtraction_operation();
				#5
				assert (result[19:0] == (op1 - op2));
				leftShift_operation();
				#5
				assert (result[19:0] == (op1 << op2));
				rightShift_operation();
				#5
				assert (result[19:0] == (op1 >> op2));
			end
		end
		#20 $stop;							// after another 20ns, stop simulation
	end
endmodule