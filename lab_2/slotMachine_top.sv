// slotMachine_top.sv
// you was here! 2024-12-04

module slotMachine_top(
	input clk,
	input button[1:0],
	output logic [7:0] displayBits [0:2] [0:1]
);

	logic rst;
	logic hasRun;
	logic [1:0] state;
	logic [19:0] speed [0:2];
	logic interClk;
	logic outClk [0:2];
	logic [11:0] display;
	logic [3:0] digits [0:2];
	
	clock_divider clock_divider [0:2] (.clk(interClk), .speed(speed), .rst(rst), .outClk(outClk));
	slot slot [0:2] (.clk(outClk), .rst(rst), .digit(digits));
	displayEncoder displayEncoder [0:2] (.result(digits), .displayBits(displayBits));
	
	always begin
		speed[0] = 20'd10;
		speed[1] = 20'd1;
		speed[2] = 20'd5;
	end
	
	always @(posedge clk) begin
		case (state)
			2'd0: begin  // Stop (0,0)
				if (button[0]) begin
					state = 2'd1;
				end else if (hasRun && digits[0] == digits[1] && digits[1] == digits[2]) begin
					state = 2'd2;
				end else if (button[1]) begin
					state = 2'd3;
				end
			end
			2'd1: begin   // Run (0,1)
				hasRun = 1'b1;
				interClk = clk;
				if (button[0]) begin
					state = 2'd0;
				end
			end
			2'd2: begin  // Win (1,0)
				if (button[1]) begin
					state = 2'd3;
				end
				
			end
			2'd3: begin  // Set (1,1)
				hasRun = 1'b0;
				interClk = 1'b0;

			end
		endcase
	end
	
endmodule