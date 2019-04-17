`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:27:52 05/30/2017 
// Design Name: 
// Module Name:    vga_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga_controller(
	// Inputs
	input wire clk,
	input wire rst,
	// Outputs
	output wire hsync, 
	output wire vsync,
	output wire [9:0] xCoord, 
	output wire [9:0] yCoord
	);

	// video structure constants
	parameter hpixels = 800;			// horizontal pixels per line
	parameter vlines = 521;				// vertical lines per frame
	parameter hpulse = 96;				// hsync pulse length
	parameter vpulse = 2;				// vsync pulse length
	parameter hbp = 144; 				// end of horizontal back porch
	parameter hfp = 784; 				// beginning of horizontal front porch
	parameter vbp = 31; 					// end of vertical back porch
	parameter vfp = 511; 				// beginning of vertical front porch
	// active horizontal video is therefore: 784 - 144 = 640
	// active vertical video is therefore: 511 - 31 = 480
	
	// registers for storing the horizontal and vertical counters
	reg [9:0] hc; 
	reg [9:0] vc;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			hc <= 0;
			vc <= 0;
		end
	  	else begin
			if (hc < hpixels - 1) begin
				hc <= hc + 1;
			end
			else begin
				hc <= 0;
				if (vc < vlines - 1) begin
					vc <= vc + 1;
				end
				else begin
					vc <= 0;
				end
			end
		end
	end

	// generate sync pulses (active low)
	// ----------------
	assign hsync = (hc < hpulse) ? 0:1;
	assign vsync = (vc < vpulse) ? 0:1;

	// Output the horizontal and vertical counters
	assign xCoord = hc - hbp;
	assign yCoord = vc - vbp;

endmodule
