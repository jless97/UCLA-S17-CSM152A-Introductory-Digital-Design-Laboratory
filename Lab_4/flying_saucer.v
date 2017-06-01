`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:32:59 05/30/2017 
// Design Name: 
// Module Name:    flying_saucer 
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
// Flying saucer appears at certain intervals (TBD)
// After moving past left edge of screen, it needs to wait until next apperance interval
module flying_saucer(
	// Inputs
	input wire clk,
	input wire rst,
	input wire restart,
	input wire [1:0] mode,
	input wire [10:0] xCoord,
	input wire [10:0] yCoord,
	// Outputs
	output wire [7:0] rgb,
	output wire is_flying_saucer
    );
	  	  
	// Display screen boundaries
   parameter LEFT_EDGE = 11'd0;
   parameter RIGHT_EDGE = 11'd640;
   parameter TOP_EDGE = 11'd0;
   parameter BOTTOM_EDGE = 11'd480;
	
	// RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	parameter COLOR_FLYING_SAUCER = 8'b10100111;
	
	// Flying Saucer Parameters
	parameter FLYING_SAUCER_HEIGHT = 11'd15;
	parameter FLYING_SAUCER_LENGTH = 11'd40;
	parameter FLYING_SAUCER_TOP = 11'd50;
	parameter FLYING_SAUCER_BOTTOM = 11'd65;
	parameter FLYING_SAUCER_INITIAL = -11'd50;
	 
	// Position Updates
   parameter MOVE_LEFT  = 11'd1;
	parameter MOVE_RIGHT = 11'd1;

	// Counter variables
	reg [10:0] flying_saucer_wait_timer;
	reg [10:0] flying_saucer_counter;
	reg flying_saucer_move_left;
	reg [10:0] flying_saucer_coord;
	
	// Initialize flying saucer
	initial begin
		flying_saucer_coord = FLYING_SAUCER_INITIAL;
		flying_saucer_wait_timer = 11'd0;
		flying_saucer_move_left = 1;
		flying_saucer_counter = 0;
	end
	
	// Only moves left, update flying saucer position (if possible)
	wire clk_frame = (xCoord == 0 && yCoord == 0);
	always @ (posedge clk) begin
	// Flying Saucer Controls
		if (rst || mode == 0 || mode == 1 || restart) begin
			flying_saucer_coord = FLYING_SAUCER_INITIAL;
			flying_saucer_wait_timer = 11'd0;
			flying_saucer_move_left = 1;
			flying_saucer_counter = 0;
		end
		if (clk_frame && mode == 2) begin
			if (flying_saucer_move_left) begin
				// If valid operation, move left
				if (flying_saucer_coord == -50) begin
					flying_saucer_move_left = 0;
				end
				if (flying_saucer_counter == 2) begin
					flying_saucer_coord = flying_saucer_coord - MOVE_LEFT;
					flying_saucer_counter = 0;
				end
				else begin
					flying_saucer_counter = flying_saucer_counter + 1;
				end
			end
			// Begin wait timer, until next appearance
			else if (!flying_saucer_move_left) begin
				flying_saucer_wait_timer = flying_saucer_wait_timer + 11'b1;
				if (flying_saucer_wait_timer == 11'd25) begin
					flying_saucer_move_left = 1;
					flying_saucer_coord = FLYING_SAUCER_INITIAL;
					flying_saucer_wait_timer = 11'd0;
				end
			end
			if (xCoord >= 0 && xCoord < 640 && yCoord >= 0 && yCoord < 480) begin
				if (yCoord >= FLYING_SAUCER_TOP && yCoord <= FLYING_SAUCER_BOTTOM &&
					 xCoord >= flying_saucer_coord - FLYING_SAUCER_LENGTH / 2 && xCoord <= flying_saucer_coord + FLYING_SAUCER_LENGTH / 2
					) begin
					set_color <= COLOR_FLYING_SAUCER;
				end
			end
		end
	 end 
	 
	 assign rgb = set_color;
	 assign is_flying_saucer = (yCoord >= FLYING_SAUCER_TOP && yCoord <= FLYING_SAUCER_BOTTOM &&
										 xCoord >= flying_saucer_coord - FLYING_SAUCER_LENGTH / 2 && xCoord <= flying_saucer_coord + FLYING_SAUCER_LENGTH / 2
										);
	 
endmodule 
