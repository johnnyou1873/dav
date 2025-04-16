module fft_4pt #(
    parameter int WIDTH = 32  // Total width (default 32: 16 real + 16 imag)
    )
    (
     input logic signed [WIDTH-1:0] A_In [3:0],   // 4 complex 32 bit inputs
     input reset,
     input start,
     input clk,
     output logic signed [WIDTH-1:0] A_Out [3:0]  // 4 complex 32 bit outputs
     output status,                               // indicates completion
    )

     // State encoding
    typedef enum logic [1:0] {
        RESET  = 2'b00,
        STAGE1  = 2'b01,
        STAGE2 = 2'b10,
        DONE  = 2'b11
    } state_t;
	state_t currentState = RESET, nextState = RESET;

    logic [WIDTH-1:0] butterflyIn [3:0];
    logic [WIDTH-1:0] butterflyOut [3:0];

    butterflyIn = A_In;

    always_comb begin
		case (currentState)
			RESET: begin  // RESET (0,0)
				if (start) begin
					nextState = STAGE1;
				end else begin
					nextState = RESET;
				end
			end
			STAGE1: begin   // STAGE1 (0,1)
                // outputs calculated combinationally
                .fft_butterfly();
				nextState = STAGE2;
			end
			STAGE2: begin  // STAGE2 (1,0)
				nextState = DONE;
			end
			DONE: begin  // DONE (1,1)
				// outputs of the module are set to the outputs of the butterfly units 
                // after the previous stage. The done flag is set to high
                A_Out = A_In;
				if (reset) begin
                    // Wait until the reset input goes high to return to RESET.
					nextState = RESET;
				end else begin
					nextState = DONE;
				end
			end
		endcase
	end

    // transition from current to next stage at every high in clock
    always @(posedge clock) begin
		currentState <= nextState;
	end

endmodule