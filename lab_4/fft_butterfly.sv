module fft_butterfly #(
	parameter int WIDTH = 32  // Total width (default 32: 16 real + 16 imag)
) (
	input logic signed [WIDTH-1:0] A,  // Complex input A
	input logic signed [WIDTH-1:0] B,  // Complex input B
	input logic signed [WIDTH-1:0] W,  // Twiddle factor
	output logic signed [WIDTH-1:0] out0, // A + B*W
	output logic signed [WIDTH-1:0] out1  // A - B*W
);

	// Split the real and imaginary components
	localparam HALF = WIDTH / 2;

	logic signed [HALF-1:0] Ar, Ai, Br, Bi, Wr, Wi;
	logic signed [WIDTH-1:0] WBr, WBi;
	logic signed [HALF:0] out0r, out0i, out1r, out1i;

	always_comb begin
		Ar = A[WIDTH-1:HALF];
		Ai = A[HALF-1:0];
		Br = B[WIDTH-1:HALF];
		Bi = B[HALF-1:0];
		Wr = W[WIDTH-1:HALF];
		Wi = W[HALF-1:0];
		
		WBr = ((Wr * Br) - (Wi * Bi));
		WBi = ((Wi * Br) + (Wr * Bi));
		
		out0r = Ar + WBr[WIDTH-2:HALF-1]; // Truncate to not overflow
		out0i = Ai + WBi[WIDTH-2:HALF-1];

		out1r = Ar - WBr[WIDTH-2:HALF-1];
		out1i = Ai - WBi[WIDTH-2:HALF-1];
		
		out0 = {out0r[HALF-1:0], out0i[HALF-1:0]};
		out1 = {out1r[HALF-1:0], out1i[HALF-1:0]};
	end

endmodule
