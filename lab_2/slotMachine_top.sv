// slotMachine_top.sv
// You was here! 2025-01-29
// Happy Lunar New Year!

module slotMachine_top(
	input clock,
	input button [1:0],
	output logic [7:0] displayBits [0:2] [0:1],
	output logic buzzer
);
	
	logic [19:0] slotSpeed [0:2];
	logic slotClockIn;
	logic slotClock [0:2];
	
	logic [11:0] display;
	logic [3:0] digits [0:2];
	logic [19:0] displayBlinkSpeed;
	logic buzzerDisable;

	logic reset = 0; // Active high pulse
	logic startStop = 0;	// Active high pulse
	
	clockDivider slotClockDivider [0:2] (.clockIn(slotClockIn), .speed(slotSpeed), .reset(reset), .clockOut(slotClock));
	slot slot [0:2] (.clock(slotClock), .reset(reset), .digit(digits));
	
	displayEncoder displayEncoder [0:2] (.digits(digits), .shutdown(displayClock), .displayBits(displayBits));
	clockDivider displayClockDivider (.clockIn(clock), .speed(displayBlinkSpeed), .reset(reset), .clockOut(displayClock));
	
//	clockDivider buzzerClockDivider (.clockIn(clock), .speed(440), .reset(buzzerDisable), .clockOut(buzzer));
	buzzerSong buzzerSong (.clock(clock), .reset(buzzerDisable), .buzzer(buzzer));
	
	 // State encoding
    typedef enum logic [1:0] {
        SET  = 2'b00,
        RUN  = 2'b01,
        STOP = 2'b10,
        WIN  = 2'b11
    } state_t;
	 
	state_t currentState = SET, nextState = SET;
	
	always_comb begin
		slotSpeed[0] = 20'd5;
		slotSpeed[1] = 20'd1;
		slotSpeed[2] = 20'd2;

		// I'm no gambler...
//		slotSpeed[0] = 20'd5;
//		slotSpeed[1] = 20'd5;
//		slotSpeed[2] = 20'd5;
	
		slotClockIn = (clock && (currentState == RUN));

		case (currentState)
			SET: begin  // Set (0,0)
				displayBlinkSpeed = 20'd0;
				buzzerDisable = 1;
				if (startStop) begin
					nextState = RUN;
				end else begin
					nextState = SET;
				end
			end
			RUN: begin   // Run (0,1)
				displayBlinkSpeed = 20'd0;
				buzzerDisable = 1;
				if (reset) begin
					nextState = SET;
				end else if (startStop) begin
					if (digits[0] == digits[1] && digits[1] == digits[2]) begin
						nextState = WIN;
					end else begin
						nextState = STOP;
					end
				end else begin
					nextState = RUN;
				end
			end
			STOP: begin  // Stop (1,0)
				displayBlinkSpeed = 20'd1;
				buzzerDisable = 1;
				if (reset) begin
					nextState = SET;
				end else if (startStop) begin
					nextState = RUN;
				end else begin
					nextState = STOP;
				end
			end
			WIN: begin  // Win (1,1)
				displayBlinkSpeed = 20'd5;
				buzzerDisable = 0;
				if (reset) begin
					nextState = SET;
				end else if (startStop) begin
					nextState = RUN;
				end else begin
					nextState = WIN;
				end
			end
		endcase
	end
	
	logic resetPrev = 0;
	logic startStopPrev = 0;

	always @(posedge clock) begin
		currentState <= nextState;
		
		resetPrev <= button[0];
		reset <= (!button[0] && resetPrev);
		
		startStopPrev <= button[1];
		startStop <= (!button[1] && startStopPrev);
	end
	
endmodule