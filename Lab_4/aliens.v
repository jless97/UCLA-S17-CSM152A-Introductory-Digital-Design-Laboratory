`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:09:26 05/31/2017 
// Design Name: 
// Module Name:    aliens 
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
module aliens(
	// Inputs
	input wire clk,
	input wire mode,
	input wire [9:0] xCoord,
	input wire [9:0] yCoord,
	// Trying to add aliens top
	input wire [9:0] initial_xCoord,
	input wire [9:0] initial_yCoord,
	input wire [9:0] spaceship_laser_xCoord,
	input wire [9:0] spaceship_laser_yCoord,
	input wire move_left,
	input wire move_right,
	input wire move_down,
	input wire [11:0] shoot_timer,
	input wire barrAlienLaserHit,
	input wire alien_rst,
	input wire [8:0] alienSpeed,
	// Outputs
	output wire [7:0] rgb,
	output wire is_alien,
	output wire [9:0] current_xCoord,
	output wire [9:0] current_yCoord,
	output wire is_edge,
	//output reg is_hit,
	output wire [7:0] rgb_alien_laser,
	output wire is_alien_laser,
	output wire [9:0] current_laser_xCoord,
	output wire [9:0] current_laser_yCoord,
	output reg can_move
    );

	// Display screen boundaries
	parameter LEFT_EDGE = 10'd5;
	parameter RIGHT_EDGE = 10'd635;

	// RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	reg [7:0] set_color_laser;
	parameter COLOR_ALIEN = 8'b10101010;
	parameter COLOR_LASER = 8'b11111111;
	parameter COLOR_LASER_BLACK = 8'b00000000;
	
		// Alien Parameters
	parameter ALIEN_HEIGHT = 10'd16;
	parameter ALIEN_LENGTH = 10'd30;
	parameter HALF_ALIEN_HEIGHT = 10'd8;
	parameter HALF_ALIEN_LENGTH = 10'd15;
	parameter ALIEN_DEAD = 10'd700;
	
	// Alien registers
	reg [9:0] alien_xCoord;
	reg [9:0] alien_yCoord;
	reg [9:0] alien_counter;
	reg is_edge_temp;
		
	// Position Updates
	parameter ALIEN_MOVE_LEFT = 10'd10;
	parameter ALIEN_MOVE_RIGHT = 10'd10;
	parameter ALIEN_MOVE_DOWN = 10'd10;	
	parameter MOVE_UP = 10'd1;
	parameter MOVE_DOWN = 10'd1;
	
	// Border (separation of objects) Parameters
	parameter BARRIER_TOP = 10'd340;
	parameter BARRIER_BOTTOM = 10'd400;
	parameter EXTRA_LIVES_BOTTOM = 10'd480;
	parameter EXTRA_LIVES_TOP = 10'd445;

	// Laser Parameters
	parameter LASER_HEIGHT = 10'd10;
	parameter LASER_LENGTH = 10'd3;
	parameter HALF_LASER_HEIGHT = 10'd5;
	parameter HALF_LASER_LENGTH = 10'd1;
	parameter LASER_INITIAL_X = 10'd320;
	parameter LASER_INITIAL_Y = 10'd417;
	
	// Laser implementation
	reg [9:0] laser_xCoord;
	reg [9:0] laser_yCoord;
	reg [12:0] laser_counter;
	reg is_active_laser;
	
	// Initialize alien ships
	initial begin
		alien_xCoord = initial_xCoord;
		alien_yCoord = initial_yCoord;
		alien_counter = 0;
		can_move = 1;
		is_edge_temp = 0;
		is_active_laser <= 0;
		laser_counter <= 0;
	end

	wire clk_frame = (xCoord == 0 && yCoord == 0);
	always @ (posedge clk) begin
		if ( mode == 0 || alien_rst ) begin
			// TODO: When new objects added, reset their properties
			// TODO: Reset screens (right now, just resets game level)
			// Reset alien spaceship
			alien_xCoord <= initial_xCoord;
			alien_yCoord <= initial_yCoord;
			laser_xCoord <= initial_xCoord;
			laser_yCoord <= initial_yCoord;
			alien_counter <= 0;
			can_move <= 1;
			is_active_laser <= 0;
			laser_counter <= 0;
		end
		else if(mode == 1 && barrAlienLaserHit) begin
			laser_xCoord <= alien_xCoord;
			laser_yCoord <= alien_yCoord;
			set_color_laser <= COLOR_ALIEN;
			is_active_laser <= 0;
		end
		if (clk_frame && mode == 1) begin
			// Alien Controls
			// Check to see if hit by laser (if so move alien off of screen, and set can_move to 0)
			if ((spaceship_laser_yCoord <= alien_yCoord + HALF_ALIEN_HEIGHT + MOVE_UP && /*spaceship_laser_yCoord >= alien_yCoord - HALF_ALIEN_HEIGHT + MOVE_UP &&*/
				  spaceship_laser_xCoord >= alien_xCoord - HALF_ALIEN_LENGTH && spaceship_laser_xCoord <= alien_xCoord + HALF_ALIEN_LENGTH) 
				) begin
				// Solving weird edge case (where alien is at the edge gets hit by laser, is_edge never gets set)
//				if	((alien_xCoord <= LEFT_EDGE + ALIEN_LENGTH / 2 + 2*ALIEN_MOVE_LEFT) ||
//				    (alien_xCoord >= RIGHT_EDGE + ALIEN_LENGTH / 2 - ALIEN_MOVE_RIGHT)
//					) begin
//					is_edge_temp <= 0;
				alien_xCoord <= ALIEN_DEAD;
				laser_xCoord <= ALIEN_DEAD;
				set_color_laser <= COLOR_LASER_BLACK;
				can_move <= 0;
			end
			// Check to see that alien is not destroyed
			if (can_move) begin
				// Laser controls
				// Update alien laser
				if (laser_counter >= shoot_timer) begin
					laser_counter <= 0;
					is_active_laser <= 1;
					laser_xCoord <= alien_xCoord;
					laser_yCoord <= alien_yCoord;
				end
				else begin
					laser_counter <= laser_counter + 1;
					laser_xCoord <= alien_xCoord;
					laser_yCoord <= alien_yCoord;
				end
				if (is_active_laser) begin
					if ((laser_yCoord >= EXTRA_LIVES_TOP + HALF_LASER_HEIGHT + MOVE_UP)) begin
						laser_xCoord <= alien_xCoord;
						laser_yCoord <= alien_yCoord;
						set_color_laser <= COLOR_ALIEN;
						is_active_laser <= 0;
					end
					else begin
						laser_yCoord <= laser_yCoord + MOVE_DOWN;
						laser_xCoord <= laser_xCoord;
						set_color_laser <= COLOR_LASER;
					end
				end
				else begin
					laser_xCoord <= alien_xCoord;
					laser_yCoord <= alien_yCoord;
					set_color_laser <= COLOR_ALIEN;
				end
				
				// Update alien
				if (alien_counter >= alienSpeed) begin
					alien_counter <= 0;
					// Moving down
					if (move_down) begin
						// If at the bottom edge of the barriers, then game over
						if (alien_yCoord >= BARRIER_BOTTOM - HALF_ALIEN_HEIGHT - ALIEN_MOVE_DOWN) begin
							// gameover or remove a life

						end
						// Normal move down
						else begin
							alien_yCoord <= alien_yCoord + ALIEN_MOVE_DOWN;
							is_edge_temp <= 0;
						end
					end
					// Moving left
					else if (move_left && !is_edge) begin
						// If at left edge of the display, bounce back
						if (alien_xCoord <= LEFT_EDGE + HALF_ALIEN_LENGTH + 2*ALIEN_MOVE_LEFT ) begin
							is_edge_temp <= 1;
							alien_xCoord <= alien_xCoord - ALIEN_MOVE_LEFT;
						end
						//Normal left move
						else begin
							alien_xCoord <= alien_xCoord - ALIEN_MOVE_LEFT;
						end
					end
					// Moving right
					else if (move_right && !is_edge) begin
						// If at right edge of the display, bounce back
						if (alien_xCoord >= RIGHT_EDGE - HALF_ALIEN_LENGTH - ALIEN_MOVE_RIGHT) begin
							is_edge_temp <= 1;
							alien_xCoord <= alien_xCoord + ALIEN_MOVE_RIGHT;
						end
						// Normal right move
						else begin
							alien_xCoord <= alien_xCoord + ALIEN_MOVE_RIGHT;
						end
					end
				end
				else begin
					alien_counter <= alien_counter + 1;
				end
			end
			else begin
				set_color_laser <= COLOR_LASER_BLACK;
			end
			// Update display of aliens
			if (yCoord >= alien_yCoord - HALF_ALIEN_HEIGHT && yCoord <= alien_yCoord + HALF_ALIEN_HEIGHT &&
				 xCoord >= alien_xCoord - HALF_ALIEN_LENGTH && xCoord <= alien_xCoord + HALF_ALIEN_LENGTH
				) begin
				set_color <= COLOR_ALIEN;
			end
		end
	end
	
	// Assign movement conditions
	assign is_edge = is_edge_temp;
	
	// Assign coordinates (to be fed to the spaceship coordinate)
	assign current_xCoord = alien_xCoord;
	assign current_yCoord = alien_yCoord;
	
	// Assign color parameters
	assign rgb = set_color;
	assign is_alien = (yCoord >= alien_yCoord - HALF_ALIEN_HEIGHT && yCoord <= alien_yCoord + HALF_ALIEN_HEIGHT &&
							 xCoord >= alien_xCoord - HALF_ALIEN_LENGTH && xCoord <= alien_xCoord + HALF_ALIEN_LENGTH
							 );
	
	// Assign laser coordinates (to be fed into barriers and spaceship)
	assign current_laser_xCoord = laser_xCoord;
	assign current_laser_yCoord = laser_yCoord;
	
	// Assign laser colors
	assign rgb_alien_laser = set_color_laser;
	assign is_alien_laser = (yCoord >= laser_yCoord - HALF_LASER_HEIGHT && yCoord <= laser_yCoord + HALF_LASER_HEIGHT &&
							 xCoord >= laser_xCoord - HALF_LASER_LENGTH && xCoord <= laser_xCoord + HALF_LASER_LENGTH); // TODO
							 
endmodule 