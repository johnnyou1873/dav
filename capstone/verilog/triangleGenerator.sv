module triangleGenerator #(
	parameter BASE_SPEED = 50000000
)(
	input clk,
	input rst,
	input [19:0] freq,
	output logic [7:0] out
);

	logic [31:0] counter = 0;

	logic direction = 0; // 0: up, 1: down

	always @(posedge clk) begin
		if (rst || freq == 0) begin
			counter <= 0;
			out <= 0;
			direction <= 0;
		end else if (counter >= (BASE_SPEED / (freq * 512))) begin
			counter <= 0;
			if (!direction) begin
				if (out == 8'hFF) begin
					direction <= 1;
					out <= out - 1;
				end else begin
					out <= out + 1;
				end
			end else begin
				if (out == 8'h00) begin
					direction <= 0;
					out <= out + 1;
				end else begin
					out <= out - 1;
				end
			end
		end else begin
			counter <= counter + 1;
		end
	end

endmodule