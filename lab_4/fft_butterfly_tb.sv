`timescale 1ns/1ns

module fft_butterfly_tb;

    // Parameters
    localparam WIDTH = 32;
    localparam HALF = WIDTH / 2;

    // DUT I/O
    logic signed [WIDTH-1:0] A, B, W;
    logic signed [WIDTH-1:0] out0, out1;

    // Instantiate the DUT
    fft_butterfly #(.WIDTH(WIDTH)) dut (
        .A(A),
        .B(B),
        .W(W),
        .out0(out0),
        .out1(out1)
    );

    // Helper tasks
    function automatic [WIDTH-1:0] complex_pack(input signed [HALF-1:0] r, i);
        return {r, i};
    endfunction

    task print_complex(string label, input [WIDTH-1:0] val);
        logic signed [HALF-1:0] r, i;
        r = val[WIDTH-1:HALF];
        i = val[HALF-1:0];
        $display("%s: %d + j%d", label, r, i);
    endtask

    initial begin
        $display("Starting FFT Butterfly Testbench\n");

        // Example Test Case 1
        // A = 3 + j1, B = 2 + j2, W = 1 + j0
        A = complex_pack(16'sd300, 16'sd100);
        B = complex_pack(16'sd200, 16'sd200);
        W = 32'b01111111111111110000000000000000;

        #10;
        $display("Test 1:");
        print_complex("A", A);
        print_complex("B", B);
        print_complex("W", W);
        print_complex("out0 (A + B*W)", out0);
        print_complex("out1 (A - B*W)", out1);
        $display("");

        // Example Test Case 2
        // A = -4 + j5, B = 1 - j1, W = 0 + j1
        A = complex_pack(-16'sd400, 16'sd500);
        B = complex_pack(16'sd100, -16'sd100);
        W = 32'b00000000000000001000000000000000;

        #10;
        $display("Test 2:");
        print_complex("A", A);
        print_complex("B", B);
        print_complex("W", W);
        print_complex("out0", out0);
        print_complex("out1", out1);
        $display("");

        // Additional test vectors can go here...

        $display("FFT Butterfly Testbench Complete\n");
        $finish;
    end

endmodule