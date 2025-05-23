module bapple_rom #(
	parameter int HPIXELS     = 640,    // number of visible pixels per horizontal line
	parameter int VPIXELS     = 480,    // number of visible horizontal lines per frame
	parameter int BLOCK_SIZE  = 16,
	parameter int BUFFER_SIZE = (HPIXELS / BLOCK_SIZE) * (VPIXELS / BLOCK_SIZE)
) (
	input  logic                     clk,
	input  logic							rst,
	input  logic                     vsync,
	output logic [0:BUFFER_SIZE-1]   frame,
	output logic [$clog2(NUM_FRAMES)-1:0] frame_num
);
	
	localparam NUM_FRAMES = 3286;
   localparam RLE_DEPTH = 185215;
	localparam RLE_WIDTH = 6;

   logic [0:BUFFER_SIZE-1] buf0, buf1;
   logic buf_sel;

   logic vsync_prev;
   always_ff @(posedge clk) vsync_prev <= vsync;
   wire vsync_posedge = vsync & ~vsync_prev;

   logic [$clog2(RLE_DEPTH)-1:0] rom_addr = 0;
   logic [7:0] rom_data;
	
	logic [$clog2(NUM_FRAMES)-1:0] frame_n = 0;
	
	rom rom (
		.clock   (clk),
		.address (rom_addr),
		.q       (rom_data)
	);

	logic [RLE_WIDTH-1:0]                   run_rem = 0;   // pixels left in current run
	logic                                   run_val = 0;   // bit to write
	logic [$clog2(BUFFER_SIZE)-1:0]         pix_cnt = 0;   // pixel index within frame

	typedef enum logic [1:0] { IDLE, FETCH, READ, OUTPUT } state_t;
	state_t state = IDLE;

	always_ff @(posedge clk) begin
		if (rst) begin
			state <= IDLE;
			buf_sel <= 0;
			rom_addr <= 0;
			pix_cnt <= 0;
			run_rem <= 0;
			run_val <= 0;
			frame_n <= 0;
		end else 
		case (state)
			//--------------------------------------------------------
			IDLE: begin
			// do nothing until next vsync
				if (vsync_posedge) begin
					buf_sel <= ~buf_sel;       // swap which buffer we’ll write into
					pix_cnt <= 0;
					frame_n <= frame_n + 1;
					if (run_rem == 0 || rom_addr == RLE_DEPTH-1) begin // if no more or at the end of rom (in case last run overflows)
						state <= FETCH;
					end else begin
						state <= OUTPUT;
					end
				end
			end

			//--------------------------------------------------------
			FETCH: begin
				if (rom_addr == RLE_DEPTH-1) begin // next address points past end of ROM
					rom_addr <= 0;
					frame_n <= 0;
					state <= IDLE; // end frame early
				end else begin // continue with next address
					rom_addr <= rom_addr + 1; // ROM takes 1 cycle to read; we are essentially queueing the next read
					state 	<= READ;
				end
			end
			
			//--------------------------------------------------------
			// This part is needed to allow for even the tighest timing with one pixel
			READ: begin // Read the outgoing data! This will change over the next clock cycle
				run_val  <= rom_data[RLE_WIDTH-1];
				run_rem  <= {1'b0, rom_data[RLE_WIDTH-2:0]} + 1;
				state <= OUTPUT;
			end
			
			//--------------------------------------------------------
			OUTPUT: begin
				// write one pixel of this run into the active buffer
				if (buf_sel) begin
					buf0[pix_cnt] <= run_val;
				end else begin
					buf1[pix_cnt] <= run_val;
				end
				
				run_rem <= run_rem - 1;
				
				if (pix_cnt == BUFFER_SIZE - 1) begin // frame is done
					state <= IDLE;
				end else begin // continue frame
					pix_cnt <= pix_cnt + 1;
					if (run_rem == 1) begin // run is done
						state <= FETCH;
					end else begin // continue run
						state <= OUTPUT;
					end
				end
			end

		default: state <= FETCH;
		endcase
	end

	always_comb begin
		frame = buf_sel ? buf1 : buf0;
		frame_num = frame_n;
	end

endmodule
