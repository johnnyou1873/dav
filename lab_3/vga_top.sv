module vga_top(
	input clk,
	input button,
   output logic VGA_hsync,
	output logic VGA_vsync,
   output logic [3:0] VGA_red,
	output logic [3:0] VGA_green,
	output logic [3:0] VGA_blue
);

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
	vgaclk vgaclk (.areset(rst), .inclk0(clk), .c0(pllclk), .locked());
	// instantiate driver
	vga vga (.vgaclk(pllclk), .rst(rst), .input_red(input_red), .input_green(input_green), .input_blue(input_blue), .hc_out(hc), .vc_out(vc), .hsync(VGA_hsync), .vsync(VGA_vsync), .red(VGA_red), .green(VGA_green), .blue(VGA_blue));
	// ping-pong buffer
	doubleBuffer doubleBuffer (.clk(clk), .hc(hc), .vc(vc), .write_addr(write_addr), .pixel_data_in(pixel_data_in), .pixel_data_out(pixel_data_out));

	localparam BLK = 8'h00;
	localparam WHT = 8'hff;
	localparam RED = 8'he0;
	localparam BLU = 8'h03;
//	assign color = test_sprite[address];
	logic [7:0] test_sprite [0:767] = '{ 
	//  0       1       2      3      4      5      6      7      8      9      10     11     12     13     14     15     16     17     18     19     20     21     22     23      24      25      26     27     28     29     30     31      
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 0
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 1
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 2
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 3
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 4
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   RED,   RED,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 5
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 6
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 7
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   RED,   WHT,   WHT,   RED,   RED,   RED,   RED,   WHT,   WHT,   RED,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 8
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   WHT,   WHT,   WHT,   WHT,   RED,   RED,   WHT,   WHT,   WHT,   WHT,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 9
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   WHT,   WHT,   BLU,   BLU,   RED,   RED,   WHT,   WHT,   BLU,   BLU,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 10
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   RED,   WHT,   WHT,   BLU,   BLU,   RED,   RED,   WHT,   WHT,   BLU,   BLU,   RED,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 11
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   RED,   RED,   WHT,   WHT,   RED,   RED,   RED,   RED,   WHT,   WHT,   RED,   RED,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 12
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 13
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 14
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 15
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   RED,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 16
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   RED,   BLK,   RED,   RED,   RED,   BLK,   BLK,   RED,   RED,   RED,   BLK,   RED,   RED,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 17
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   RED,   BLK,   BLK,   BLK,   RED,   RED,   BLK,   BLK,   RED,   RED,   BLK,   BLK,   BLK,   RED,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 18
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 19
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 20
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 21
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   // 22
		 BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,   BLK,    BLK,    BLK,    BLK,   BLK,   BLK,   BLK,   BLK,   BLK    // 23
	};
	
	logic [5:0] xpos;
	logic [5:0] ypos;
	
	assign xpos = hc / 20; // HPIXELS / 20
	assign ypos = vc / 20; // VPIXELS / 20
	
	//take in the horizontal and vertical position from your VGA driver (hc_out and vc_out)
	// output the pixel address calculated from those counters alongside the RGB color
	// combinationally calculate [(vertical position) * (pixels per line) + (horizontal position)] 
	//anytime the VGA is within the active display area
	// set the address to some don't-care value when the VGA is in a blanking period
	// Define some signals to be scaled-down versions 
	// (use a factor of 20 for this lab) of the horizontal and vertical position
	// effectively reducing the resolution of our display, and you'll need to change the "pixels per line"
	always_comb begin
		// calc position when within active display area
		if (hc < 640 && vc < 480) begin
			pixel_data_in = test_sprite[(ypos * 32) + xpos];
			write_addr = ypos * 32 + xpos;
			input_red = pixel_data_out[7:5];
			input_blue = pixel_data_out[1:0];
			input_green = pixel_data_out[4:2];
		end else begin
		// set don't care value for blanking period
			pixel_data_in = test_sprite[0];
			write_addr = 0;
			input_red = 0;
			input_green = 0;
			input_blue = 0;
		end
	end
	
	always_ff @(posedge clk) begin
		rstPrev <= button;
		rst <= !button && rstPrev;
	end
	
endmodule