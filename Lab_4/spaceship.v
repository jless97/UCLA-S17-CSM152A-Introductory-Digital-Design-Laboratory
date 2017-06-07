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
//	input wire restart,
	input wire button_left,
	input wire button_right,
	input wire button_shoot,
	input wire mode,
	input wire [9:0] xCoord,
	input wire [9:0] yCoord,
	input wire [29:0] alien_xCoord,
	input wire [29:0] alien_yCoord,
	input wire [29:0] alien_laser_xCoord,
	input wire [29:0] alien_laser_yCoord,
	input wire barrSpaceshipLaserHit,
	// Outputs
	output wire [7:0] rgb,
	output wire is_spaceship,
	output wire [7:0] rgb_spaceship_laser,
	output wire is_spaceship_laser,
	output wire [9:0] current_laser_xCoord,
	output wire [9:0] current_laser_yCoord
    );

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// Display screen boundaries
	parameter LEFT_EDGE = 10'd0;
	parameter RIGHT_EDGE = 10'd640;
	parameter TOP_EDGE = 10'd0;
	parameter BOTTOM_EDGE = 10'd480;
	parameter SCOREBOARD_TOP = 10'd0;
	parameter SCOREBOARD_BOTTOM = 10'd60;
	
	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
   // RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	reg [7:0] set_color_laser;
	parameter COLOR_SPACESHIP = 8'b01111000;
	parameter COLOR_LASER = 8'b11111111;
	parameter COLOR_LASER_BLACK = 8'b00000000;
	parameter COLOR_BLACK = 8'b00000000;
	
	// Spaceship Parameters
	parameter SPACESHIP_HEIGHT = 10'd10;
	parameter SPACESHIP_LENGTH = 10'd40;
	parameter HALF_SPACESHIP_HEIGHT = 10'd10;
	parameter HALF_SPACESHIP_LENGTH = 10'd20;
	parameter SPACESHIP_TOP = 10'd420;
	parameter SPACESHIP_BOTTOM = 10'd430;
	parameter SPACESHIP_INITIAL = 10'd320;
	parameter SPACESHIP_Y = 10'd425;
	reg [9:0] spaceship_coord;
		
	// Laser Parameters
	parameter LASER_HEIGHT = 10'd10;
	parameter LASER_LENGTH = 10'd3;
	parameter HALF_LASER_HEIGHT = 10'd5;
	parameter HALF_LASER_LENGTH = 10'd1;
	parameter LASER_INITIAL_X = 10'd320;
	parameter LASER_INITIAL_Y = 10'd417;
	// Alien Parameters
	parameter HALF_ALIEN_HEIGHT = 10'd8;
	parameter HALF_ALIEN_LENGTH = 10'd15;
	
	// Position Updates
	parameter MOVE_LEFT  = 10'd1;
	parameter MOVE_RIGHT = 10'd1;
	parameter MOVE_UP = 10'd1;
		
	// Laser implementation
	reg [9:0] laser_xCoord;
	reg [9:0] laser_yCoord;
	reg is_active_laser;
	reg can_move;
	
	// Initialize spaceship
	initial begin
		// Spaceship begins in the middle of the scren
		spaceship_coord = SPACESHIP_INITIAL;
		laser_xCoord = LASER_INITIAL_X;
		laser_yCoord = LASER_INITIAL_Y;
		is_active_laser = 0;
		can_move = 1;
	end
	
	wire clk_frame = (xCoord == 0 && yCoord == 0);
	always @ (posedge clk) begin
		if (mode == 0) begin
			// Reset position of the spaceship
			spaceship_coord <= SPACESHIP_INITIAL;
			laser_xCoord <= LASER_INITIAL_X;
			laser_yCoord <= LASER_INITIAL_Y;
			is_active_laser <= 0;
			can_move <= 1;
			set_color <= COLOR_SPACESHIP;
		end
		if(mode == 1 && barrSpaceshipLaserHit) begin
			laser_xCoord <= spaceship_coord;
			laser_yCoord <= LASER_INITIAL_Y;
			set_color_laser <= COLOR_LASER_BLACK;
			is_active_laser <= 0;
		end
		if (clk_frame && mode == 1) begin
			// Check to see if hit by laser (if so move alien off of screen, and set can_move to 0)
			if ((alien_laser_yCoord[9:0] >= SPACESHIP_Y - HALF_SPACESHIP_HEIGHT &&
				  alien_laser_xCoord[9:0] >= spaceship_coord - HALF_SPACESHIP_LENGTH && alien_laser_xCoord[9:0] <= spaceship_coord + HALF_SPACESHIP_LENGTH) ||
				 (alien_laser_yCoord[19:10] >= SPACESHIP_Y - HALF_SPACESHIP_HEIGHT &&
				  alien_laser_xCoord[19:10] >= spaceship_coord - HALF_SPACESHIP_LENGTH && alien_laser_xCoord[19:10] <= spaceship_coord + HALF_SPACESHIP_LENGTH) ||	
				 (alien_laser_yCoord[29:20] >= SPACESHIP_Y - HALF_SPACESHIP_HEIGHT &&
				  alien_laser_xCoord[29:20] >= spaceship_coord - HALF_SPACESHIP_LENGTH && alien_laser_xCoord[29:20] <= spaceship_coord + HALF_SPACESHIP_LENGTH) 
				) begin
				//spaceship_coord <= SPACESHIP_INITIAL;
				spaceship_coord <= 10'd700;
				set_color <= COLOR_BLACK;
				can_move <= 0;
			end
			if (can_move) begin
				// Spaceship Controls
				// Left button pressed, update spaceship position to the left (if possible)
				if (button_left && spaceship_coord > LEFT_EDGE + HALF_SPACESHIP_LENGTH) begin
					spaceship_coord <= spaceship_coord - MOVE_LEFT;
				end
				// Right button pressed, update spaceship position to the right (if possible)
				if (button_right && spaceship_coord < RIGHT_EDGE - HALF_SPACESHIP_LENGTH) begin
					spaceship_coord <= spaceship_coord + MOVE_RIGHT;
				end
				// Update display of spaceship
				if (yCoord >= SPACESHIP_TOP && yCoord <= SPACESHIP_BOTTOM && 
					 xCoord >= spaceship_coord - HALF_SPACESHIP_LENGTH && xCoord <= spaceship_coord + HALF_SPACESHIP_LENGTH
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
					if ((laser_yCoord <= SCOREBOARD_BOTTOM + HALF_LASER_HEIGHT + MOVE_UP) ||
						  //ALIENS!
	 					  //Alien 0
		   				 (laser_yCoord <= alien_yCoord[9:0] + HALF_ALIEN_HEIGHT + MOVE_UP &&
						  laser_xCoord >= alien_xCoord[9:0] - HALF_ALIEN_LENGTH && laser_xCoord <= alien_xCoord[9:0] + HALF_ALIEN_LENGTH) ||
						  // Alien 1
						 (laser_yCoord <= alien_yCoord[19:10] + HALF_ALIEN_HEIGHT + MOVE_UP &&
						  laser_xCoord >= alien_xCoord[19:10] - HALF_ALIEN_LENGTH && laser_xCoord <= alien_xCoord[19:10] + HALF_ALIEN_LENGTH) ||
						  // Alien 2
						 (laser_yCoord <= alien_yCoord[29:20] + HALF_ALIEN_HEIGHT + MOVE_UP &&
						  laser_xCoord >= alien_xCoord[29:20] - HALF_ALIEN_LENGTH && laser_xCoord <= alien_xCoord[29:20] + HALF_ALIEN_LENGTH) 
						  ) begin
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
					laser_yCoord <= LASER_INITIAL_Y;
					laser_xCoord <= spaceship_coord;
					set_color_laser <= COLOR_LASER_BLACK;
				end
			end
			else begin
				set_color_laser <= COLOR_LASER_BLACK;
			end
		end
	end

	// Assign laser coordinates (to be fed into barriers, aliens, and flying saucer modules)
	assign current_laser_xCoord = laser_xCoord;
	assign current_laser_yCoord = laser_yCoord;

	// Assign spaceship colors
	assign rgb = set_color;
	assign is_spaceship = (yCoord >= SPACESHIP_TOP && yCoord <= SPACESHIP_BOTTOM && 
								  xCoord >= spaceship_coord - HALF_SPACESHIP_LENGTH && xCoord <= spaceship_coord + HALF_SPACESHIP_LENGTH
								  );
	// Assign laser colors
	assign rgb_spaceship_laser = set_color_laser;
	assign is_spaceship_laser = (yCoord >= laser_yCoord - HALF_LASER_HEIGHT && yCoord <= laser_yCoord + HALF_LASER_HEIGHT &&
							 xCoord >= laser_xCoord - HALF_LASER_LENGTH && xCoord <= laser_xCoord + HALF_LASER_LENGTH); // TODO
	
endmodule 
