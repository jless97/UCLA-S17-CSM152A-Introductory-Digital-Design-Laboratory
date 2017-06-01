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
	input wire rst,
	input wire [1:0] mode,
	input wire [10:0] xCoord,
	input wire [10:0] yCoord,
	// Outputs
	output wire [7:0] rgb,
	output wire is_alien
    );

	// Display screen boundaries
   parameter LEFT_EDGE = 11'd0;
   parameter RIGHT_EDGE = 11'd635;
   parameter TOP_EDGE = 11'd0;
   parameter BOTTOM_EDGE = 11'd480;

	// RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	parameter COLOR_SPACESHIP = 8'b01111000;
	parameter COLOR_ALIEN = 8'b10101010;
	parameter COLOR_FLYING_SAUCER = 8'b10100111;
	parameter COLOR_SPACE = 8'b00000000;
	parameter COLOR_BLACK = 8'b00000000;
	parameter COLOR_WHITE = 8'b11111111;
	parameter COLOR_GREEN = 8'b00111000;
	parameter COLOR_RED = 8'b00000111;
	parameter COLOR_BLUE = 8'b11000000;
	parameter COLOR_YELLOW = 8'b00111111;

		// Alien Parameters
	parameter ALIEN_HEIGHT = 11'd16;
	parameter ALIEN_LENGTH = 11'd30;
		// TEMPORARY
		parameter ALIEN_TOP = 11'd80;
		parameter ALIEN_BOTTOM = 11'd96;
		parameter ALIEN_INITIAL_X = 11'd320;
		parameter ALIEN_INITIAL_Y = 11'd88;
		reg [10:0] alien_xCoord;
		reg [10:0] alien_yCoord;
		reg [10:0] alien_counter;
		reg alien_move_left;
		reg alien_move_right;
		reg alien_move_down;
		
	// Position Updates
	parameter ALIEN_MOVE_LEFT = 11'd10;
	parameter ALIEN_MOVE_RIGHT = 11'd10;
	parameter ALIEN_MOVE_DOWN = 11'd10;	
	
	// Border (separation of objects) Parameters
	parameter SCOREBOARD_TOP = 11'd0;
	parameter SCOREBOARD_BOTTOM = 11'd40;
	parameter BARRIER_TOP = 11'd340;
	parameter BARRIER_BOTTOM = 11'd397;
	parameter EXTRA_LIVES_TOP = 11'd460;
	parameter EXTRA_LIVES_BOTTOM = 11'd480;
	
	// Initialize alien ships
	initial begin
		alien_xCoord = ALIEN_INITIAL_X;
		alien_yCoord = ALIEN_INITIAL_Y;
		alien_move_left = 0;
		alien_move_right = 1;
		alien_move_down = 0;
		alien_counter = 0;
	end

	wire clk_frame = (xCoord == 0 && yCoord == 0);
	always @ (posedge clk) begin
		if (rst || mode == 0 || mode == 1) begin
			// TODO: When new objects added, reset their properties
			// TODO: Reset screens (right now, just resets game level)
			// Reset alien spaceship
			alien_xCoord = ALIEN_INITIAL_X;
			alien_yCoord = ALIEN_INITIAL_Y;
			alien_move_left = 0;
			alien_move_right = 1;
			alien_move_down = 0;
		end
		if (clk_frame && mode == 2) begin
			// Alien Controls
			// Moving left, update alien position to the left (if possible)
			if (alien_counter == 100) begin
				alien_counter = 0;
				if (alien_move_left) begin
					// If at left edge of the display, bounce back
					if (alien_xCoord <= LEFT_EDGE + ALIEN_LENGTH / 2) begin
						alien_move_right = 1;
						alien_move_left = 0;
						alien_move_down = 1;
					end
					// Normal left move
					else begin
						alien_xCoord = alien_xCoord - ALIEN_MOVE_LEFT;
					end
				end
				// Moving right, update alien position to the right (if possible)
				if (alien_move_right) begin
					// If at right edge of the display, bounce back
					if (alien_xCoord >= RIGHT_EDGE - ALIEN_LENGTH / 2) begin
						alien_move_left = 1;
						alien_move_right = 0;
						alien_move_down = 1;
					end
					// Normal right move
					else begin
						alien_xCoord = alien_xCoord + ALIEN_MOVE_RIGHT;
					end
				end
				// Moving down, update alien position downwards (if possible)
				if (alien_move_down) begin
					// If at the bottom edge of the barriers, then game over
					if (alien_yCoord >= BARRIER_BOTTOM - ALIEN_HEIGHT / 2) begin
						// gameover
						//is_start_screen = 1;
						//is_switch_screen = 0;
						//is_gameover_screen = 1;
					end
					// Normal move down
					else begin
						alien_move_down = 0;
						alien_yCoord = alien_yCoord + ALIEN_MOVE_DOWN;
					end
				end
			end
			else begin
				alien_counter = alien_counter + 1;
			end
			// Update display of aliens
			if (yCoord >= alien_yCoord - ALIEN_HEIGHT / 2 && yCoord <= alien_yCoord + ALIEN_HEIGHT / 2 &&
				 xCoord >= alien_xCoord - ALIEN_LENGTH / 2 && xCoord <= alien_xCoord + ALIEN_LENGTH / 2
				) begin
				set_color <= COLOR_ALIEN;
			end
		end
	end
	
	assign rgb = set_color;
	assign is_alien = (yCoord >= alien_yCoord - ALIEN_HEIGHT / 2 && yCoord <= alien_yCoord + ALIEN_HEIGHT / 2 &&
							 xCoord >= alien_xCoord - ALIEN_LENGTH / 2 && xCoord <= alien_xCoord + ALIEN_LENGTH / 2
							 );
							 
endmodule 
