`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:46:43 05/31/2017 
// Design Name: 
// Module Name:    spaceship 
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
module spaceship(
	// Inputs
	input wire clk,
	input wire rst,
	input wire restart,
	input wire button_left,
	input wire button_right,
	input wire button_shoot,
	input wire [1:0] mode,
	input wire [10:0] xCoord,
	input wire [10:0] yCoord,
	input wire [10:0] flying_saucer_xCoord,
	input wire [10:0] flying_saucer_yCoord,
	input wire [10:0] alien_xCoord,
	input wire [10:0] alien_yCoord,
	// Outputs
	output wire [7:0] rgb,
	output wire is_spaceship,
	output wire [7:0] rgb_laser,
	output wire is_laser
    );

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// Display screen boundaries
   parameter LEFT_EDGE = 11'd0;
   parameter RIGHT_EDGE = 11'd640;
   parameter TOP_EDGE = 11'd0;
   parameter BOTTOM_EDGE = 11'd480;
	parameter SCOREBOARD_TOP = 11'd0;
	parameter SCOREBOARD_BOTTOM = 11'd40;
	
	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
   // RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	reg [7:0] set_color_laser;
	parameter COLOR_SPACESHIP = 8'b01111000;
	parameter COLOR_LASER = 8'b11111111;
	parameter COLOR_LASER_BLACK = 8'b00000000;
	
	// Spaceship Parameters
	parameter SPACESHIP_HEIGHT = 11'd10;
	parameter SPACESHIP_LENGTH = 11'd40;
	parameter SPACESHIP_TOP = 11'd420;
	parameter SPACESHIP_BOTTOM = 11'd430;
	parameter SPACESHIP_INITIAL = 11'd320;
	reg [10:0] spaceship_coord;
		
	// Laser Parameters
	parameter LASER_HEIGHT = 11'd10;
	parameter LASER_LENGTH = 11'd3;
	parameter LASER_INITIAL_X = 11'd320;
	parameter LASER_INITIAL_Y = 11'd417;
	
	// Flying Saucer Parameters
	parameter FLYING_SAUCER_HEIGHT = 11'd15;
	parameter FLYING_SAUCER_LENGTH = 11'd40;
	
	// Alien Parameters
	parameter ALIEN_HEIGHT = 11'd16;
	parameter ALIEN_LENGTH = 11'd30;
	
	// Position Updates
   parameter MOVE_LEFT  = 11'd1;
	parameter MOVE_RIGHT = 11'd1;
	parameter MOVE_UP = 11'd1;
		
	// Laser implementation
	reg [10:0] laser_xCoord;
	reg [10:0] laser_yCoord;
	reg [10:0] laser_counter;
	reg is_active_laser;
	
	// Initialize spaceship
	initial begin
		// Spaceship begins in the middle of the scren
		spaceship_coord = SPACESHIP_INITIAL;
		laser_xCoord = LASER_INITIAL_X;
		laser_yCoord = LASER_INITIAL_Y;
		laser_counter = 11'd0;
		is_active_laser = 0;
	end
	
	wire clk_frame = (xCoord == 0 && yCoord == 0);
	always @ (posedge clk) begin
		if (rst || mode == 0 || mode == 1 || restart) begin
			// Reset position of the spaceship
			spaceship_coord <= SPACESHIP_INITIAL;
			laser_xCoord <= LASER_INITIAL_X;
			laser_yCoord <= LASER_INITIAL_Y;
			laser_counter <= 11'd0;
			is_active_laser <= 0;
		end
		if (clk_frame && mode == 2) begin
			// Spaceship Controls
			// Left button pressed, update spaceship position to the left (if possible)
        	if (button_left && spaceship_coord > LEFT_EDGE + SPACESHIP_LENGTH / 2) begin
				spaceship_coord <= spaceship_coord - MOVE_LEFT;
			end
			// Right button pressed, update spaceship position to the right (if possible)
         if (button_right && spaceship_coord < RIGHT_EDGE - SPACESHIP_LENGTH / 2) begin
				spaceship_coord <= spaceship_coord + MOVE_RIGHT;
			end
			// Update display of spaceship
			if (yCoord >= SPACESHIP_TOP && yCoord <= SPACESHIP_BOTTOM && 
				 xCoord >= spaceship_coord - SPACESHIP_LENGTH / 2 && xCoord <= spaceship_coord + SPACESHIP_LENGTH / 2
				) begin
				set_color <= COLOR_SPACESHIP;
			end
			// Laser controls
			// Update spaceship laser
			if (button_shoot) begin
				is_active_laser <= 1;
				laser_xCoord <= spaceship_coord;
			end
			if (is_active_laser) begin
				// If hit any objects, then reset laser back to the spaceship
					// Top of the display (the bottom of the scoreboard)
				if ((laser_yCoord <= SCOREBOARD_BOTTOM + LASER_HEIGHT / 2 + MOVE_UP) ||
					// Flying saucer
					 (laser_yCoord <= flying_saucer_yCoord + FLYING_SAUCER_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= flying_saucer_xCoord - FLYING_SAUCER_LENGTH / 2 &&
					  laser_xCoord <= flying_saucer_xCoord + FLYING_SAUCER_LENGTH / 2) ||
					// Aliens
    				 (laser_yCoord <= alien_yCoord + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord + ALIEN_LENGTH / 2)) begin
					laser_xCoord <= spaceship_coord;
					laser_yCoord <= LASER_INITIAL_Y;
					set_color_laser <= COLOR_LASER_BLACK;
					is_active_laser <= 0;
				end
				else begin
					laser_yCoord <= laser_yCoord - MOVE_UP;
					laser_xCoord <= laser_xCoord;
					set_color_laser <= COLOR_LASER;
				end
			end
			else begin
				set_color_laser <= COLOR_LASER_BLACK;
			end
		end
	end

	// Assign spaceship colors
	assign rgb = set_color;
	assign is_spaceship = (yCoord >= SPACESHIP_TOP && yCoord <= SPACESHIP_BOTTOM && 
								  xCoord >= spaceship_coord - SPACESHIP_LENGTH / 2 && xCoord <= spaceship_coord + SPACESHIP_LENGTH / 2
								  );
	// Assign laser colors
	assign rgb_laser = set_color_laser;
	assign is_laser = (yCoord >= laser_yCoord - LASER_HEIGHT / 2 && yCoord <= laser_yCoord + LASER_HEIGHT / 2 &&
							 xCoord >= laser_xCoord - LASER_LENGTH / 2 && xCoord <= laser_xCoord + LASER_LENGTH / 2); // TODO
	
endmodule
