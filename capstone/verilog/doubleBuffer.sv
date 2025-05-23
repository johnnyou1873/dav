module doubleBuffer #(
    parameter HPIXELS    = 640,    // number of visible pixels per horizontal line
    parameter VPIXELS    = 480,    // number of visible horizontal lines per frame
    parameter BLOCK_SIZE = 16,
    parameter BUFFER_SIZE = (HPIXELS / BLOCK_SIZE) * (VPIXELS / BLOCK_SIZE)
)(
    input  logic        clk,
    input  logic [9:0]  hc,
    input  logic [9:0]  vc,
    input  logic [9:0]  write_addr,
    input  logic [7:0]  pixel_data_in,
    output logic [7:0]  pixel_data_out
);

    logic read_buffer_select;
    logic [$clog2(BUFFER_SIZE)-1:0] read_addr;
	 
//	logic [7:0] buffer [0:1] [0:BUFFER_SIZE-1];
//
//	always_ff @(posedge clk) begin
//		buffer[read_buffer_select][write_addr] <= pixel_data_in;
//		if (hc == 0 && vc == 0) begin
//			read_buffer_select <= ~read_buffer_select;
//		end
//	end
//
//	always_comb begin
//		if (hc < HPIXELS && vc < VPIXELS) begin
//			read_addr = (vc / 20 * (HPIXELS / 20)) + (hc / 20);
//		end else begin
//			read_addr = 0;
//		end
//		pixel_data_out = buffer[read_buffer_select][read_addr];
//	end

    logic [7:0] q0, q1;

    ram buffer0 (
        .clock(clk),
        .address(read_buffer_select ? write_addr : read_addr),
        .data(pixel_data_in),
        .wren(~read_buffer_select),
        .q(q0)
    );

    ram buffer1 (
        .clock(clk),
        .address(read_buffer_select ? read_addr : write_addr),
        .data(pixel_data_in),
        .wren(read_buffer_select),
        .q(q1)
    );

	always_ff @(posedge clk) begin
		if (hc == 0 && vc == 0) begin
			read_buffer_select <= ~read_buffer_select;
		end
	end

    always_comb begin
        if (hc < HPIXELS && vc < VPIXELS) begin
            read_addr = (vc / BLOCK_SIZE * (HPIXELS / BLOCK_SIZE)) + (hc / BLOCK_SIZE);
        end else begin
            read_addr = 0;
        end
        pixel_data_out = read_buffer_select ? q1 : q0;
    end
	
endmodule