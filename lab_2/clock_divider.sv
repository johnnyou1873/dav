// clock_divider.sv
// you was here! 2024-11-13

module clock_divider #(
	parameter BASE_SPEED = 50000000
)(
	input clk,
	input [19:0] speed,
	input rst,
	output logic outClk
);
	
	logic [19:0] counter;
	int counter_d = 0;
	
	always @(posedge clk) begin
		 if ((counter >= (BASE_SPEED / speed)) || rst) begin
			counter <= 0;
		 end else begin
			counter_d = counter + 1;
			counter <= counter_d[19:0];
		 end
	end
	
	always_comb begin
		if (counter >= ((BASE_SPEED / speed) / 2)) begin
			outClk = 1;
		end else begin
			outClk = 0;
		end
	end
	
endmodule