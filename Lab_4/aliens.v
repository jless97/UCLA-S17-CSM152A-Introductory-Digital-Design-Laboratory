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
	input wire aliens,
	// Trying to add aliens top
	input wire [10:0] initial_xCoord,
	input wire [10:0] initial_yCoord,
	input wire move_left,
	input wire move_right,
	input wire move_down,
	// Outputs
	output wire [7:0] rgb,
	output wire is_alien,
	output wire [10:0] current_xCoord,
	output wire [10:0] current_yCoord,
	output wire is_edge,
	output wire is_bottom
//	output wire is_hit
    );

	// Display screen boundaries
   parameter LEFT_EDGE = 11'd5;
   parameter RIGHT_EDGE = 11'd635;

	// RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	parameter COLOR_ALIEN = 8'b10101010;

		// Alien Parameters
	parameter ALIEN_HEIGHT = 11'd16;
	parameter ALIEN_LENGTH = 11'd30;
	
	// Alien registers
	reg [10:0] alien_xCoord;
	reg [10:0] alien_yCoord;
	reg [10:0] alien_counter;
	reg is_edge_temp;
		
	// Position Updates
	parameter ALIEN_MOVE_LEFT = 11'd10;
	parameter ALIEN_MOVE_RIGHT = 11'd10;
	parameter ALIEN_MOVE_DOWN = 11'd10;	
	
	// Border (separation of objects) Parameters
	parameter BARRIER_TOP = 11'd340;
	
	// Initialize alien ships
	initial begin
		alien_xCoord = initial_xCoord;
		alien_yCoord = initial_yCoord;
		alien_counter = 0;
		is_edge_temp = 0;
	end

	wire clk_frame = (xCoord == 0 && yCoord == 0);
	always @ (posedge clk) begin
		if (rst || mode == 0 || mode == 1) begin
			// TODO: When new objects added, reset their properties
			// TODO: Reset screens (right now, just resets game level)
			// Reset alien spaceship
			alien_xCoord <= initial_xCoord;
			alien_yCoord <= initial_yCoord;
		end
		if (clk_frame && mode == 2) begin
			// Alien Controls
			// Moving left, update alien position to the left (if possible)
			if (alien_counter >= 200) begin
				alien_counter <= 0;
				// Moving down, update alien position downwards (if possible)
				if (move_down) begin
					// If at the bottom edge of the barriers, then game over
					if (alien_yCoord >= BARRIER_TOP - ALIEN_HEIGHT / 2) begin
						// gameover
						//is_start_screen = 1;
						//is_switch_screen = 0;
						//is_gameover_screen = 1;
					end
					// Normal move down
					else begin
						alien_yCoord <= alien_yCoord + ALIEN_MOVE_DOWN;
						is_edge_temp <= 0;
					end
				end
				else if (move_left && !is_edge) begin
					// If at left edge of the display, bounce back
					if (alien_xCoord <= LEFT_EDGE + ALIEN_LENGTH / 2 + 2*ALIEN_MOVE_LEFT ) begin
						is_edge_temp <= 1;
                        alien_xCoord <= alien_xCoord - ALIEN_MOVE_LEFT;
					end
					//Normal left move
					else begin
						alien_xCoord <= alien_xCoord - ALIEN_MOVE_LEFT;
					end
				end
				// Moving right, update alien position to the right (if possible)
				else if (move_right && !is_edge) begin
					// If at right edge of the display, bounce back
					if (alien_xCoord >= RIGHT_EDGE - ALIEN_LENGTH / 2 - ALIEN_MOVE_RIGHT) begin
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
			// Update display of aliens
			if (yCoord >= alien_yCoord - ALIEN_HEIGHT / 2 && yCoord <= alien_yCoord + ALIEN_HEIGHT / 2 &&
				 xCoord >= alien_xCoord - ALIEN_LENGTH / 2 && xCoord <= alien_xCoord + ALIEN_LENGTH / 2
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
	assign is_alien = (yCoord >= alien_yCoord - ALIEN_HEIGHT / 2 && yCoord <= alien_yCoord + ALIEN_HEIGHT / 2 &&
							 xCoord >= alien_xCoord - ALIEN_LENGTH / 2 && xCoord <= alien_xCoord + ALIEN_LENGTH / 2
							 );
							 
endmodule 
