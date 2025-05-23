module vga_top(
	input clk,
	input button,
   output logic VGA_hsync,
	output logic VGA_vsync,
   output logic [3:0] VGA_red,
	output logic [3:0] VGA_green,
	output logic [3:0] VGA_blue,
	output logic [7:0] displayBits [0:5],
	output logic [7:0] DAC_bus
);

	localparam HPIXELS  = 640;    // number of visible pixels per horizontal line
   localparam VPIXELS  = 480;    // number of visible horizontal lines per frame
   localparam BLOCK_SIZE = 16;
   localparam BUFFER_SIZE = (HPIXELS / BLOCK_SIZE) * (VPIXELS / BLOCK_SIZE);

	logic pllclk;
	logic rst;
	logic rstPrev;
	
	logic [7:0] input_red;
	logic [7:0] input_green;
	logic [7:0] input_blue;
	
	logic [9:0] hc;
	logic [9:0] vc;
	
	logic [7:0] pixel_data_in;
	logic [7:0] pixel_data_out;
	logic [18:0] write_addr;
	
	// clock gen
	vgaclk vgaclk (.areset(), .inclk0(clk), .c0(pllclk), .locked());
	// instantiate driver
	vga vga (.vgaclk(pllclk), .rst(), .input_red(input_red), .input_green(input_green), .input_blue(input_blue), .hc_out(hc), .vc_out(vc), .hsync(VGA_hsync), .vsync(VGA_vsync), .red(VGA_red), .green(VGA_green), .blue(VGA_blue));
	// ping-pong buffer
	doubleBuffer #(
		.HPIXELS(HPIXELS),
		.VPIXELS(VPIXELS),
		.BLOCK_SIZE(BLOCK_SIZE)
	) doubleBuffer (
		.clk(clk),
		.hc(hc),
		.vc(vc),
		.write_addr(write_addr),
		.pixel_data_in(pixel_data_in),
		.pixel_data_out(pixel_data_out)
	);
	
	localparam BLK = 8'h00;
	localparam WHT = 8'hff;
	localparam RED = 8'he0;
	localparam BLU = 8'h03;
	
	localparam NUM_FRAMES = 3286;
	
	logic [0:BUFFER_SIZE-1] frame;
	logic sprite_bit;
	logic [$clog2(NUM_FRAMES)-1:0] frame_num;
	logic [2:0] clock_div = 0;
	
	displayEncoder displayEncoder (.digits(frame_num), .shutdown(), .displayBits(displayBits));
	
	bapple_rom #(
		.HPIXELS(HPIXELS),
		.VPIXELS(VPIXELS),
		.BLOCK_SIZE(BLOCK_SIZE)
	) bapple_rom (
		.clk(clk),
		.rst(rst),
		.vsync(clock_div == 0),
		.frame_num(frame_num),
		.frame(frame)
	);
	logic [5:0] xpos;
	logic [5:0] ypos;
	
	assign xpos = hc / BLOCK_SIZE;
	assign ypos = vc / BLOCK_SIZE;
	
	//take in the horizontal and vertical position from your VGA driver (hc_out and vc_out)
	// output the pixel address calculated from those counters alongside the RGB color
	// combinationally calculate [(vertical position) * (pixels per line) + (horizontal position)] 
	//anytime the VGA is within the active display area
	// set the address to some don't-care value when the VGA is in a blanking period
	// Define some signals to be scaled-down versions of the horizontal and vertical position
	// effectively reducing the resolution of our display, and you'll need to change the "pixels per line"
	always_comb begin
		sprite_bit = frame[ypos*(HPIXELS / BLOCK_SIZE) + xpos];
		// calc position when within active display area
		if (hc < 640 && vc < 480) begin
			// replicate it 8 times:
			pixel_data_in = {8{ sprite_bit }};
			write_addr = ypos * (HPIXELS / BLOCK_SIZE) + xpos;
			input_red = pixel_data_out[7:5];
			input_blue = pixel_data_out[1:0];
			input_green = pixel_data_out[4:2];
		end else begin
		// set don't care value for blanking period
			pixel_data_in = 8'b0;
			write_addr = 19'b0;
			input_red = 8'b0;
			input_green = 8'b0;
			input_blue = 8'b0;
		end
	end
	
	always_ff @(posedge clk) begin
		rstPrev <= button;
		rst <= !button && rstPrev;
	end
	
	always_ff @(posedge VGA_vsync) begin
		if (clock_div == 5) begin
			clock_div <= 0;
		end else begin
			clock_div <= clock_div + 1;
		end
	end
	
	buzzerSong buzzerSong(.clock(clk), .reset(rst), .out(DAC_bus));
	
endmodule