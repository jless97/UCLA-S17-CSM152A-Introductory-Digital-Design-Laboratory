`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:27:46 05/30/2017 
// Design Name: 
// Module Name:    vga_display 
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
// TODO: When not game screen, freeze objects (or kill them)
module vga_display(
	// Inputs
   input wire clk, 
	input wire flying_saucer_clk,
	input wire rst,
   input wire button_left, 
	input wire button_right, 
	input wire button_center,
	input wire button_display,
	input wire start_screen,
	input wire switch_screen,
   input wire [10:0] xCoord, 
	input wire [10:0] yCoord,
	// Outputs
   output wire [7:0] rgb
	);
	
	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// Display screen boundaries
   parameter LEFT_EDGE = 11'd0;
   parameter RIGHT_EDGE = 11'd640;
   parameter TOP_EDGE = 11'd0;
   parameter BOTTOM_EDGE = 11'd480;

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
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
	
	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// Border (separation of objects) Parameters
	parameter SCOREBOARD_TOP = 11'd0;
	parameter SCOREBOARD_BOTTOM = 11'd40;
	parameter BARRIER_TOP = 11'd340;
	parameter BARRIER_BOTTOM = 11'd400;
	parameter EXTRA_LIVES_TOP = 11'd460;
	parameter EXTRA_LIVES_BOTTOM = 11'd480;
	
	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// Scoreboard Parameters

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// Instantiate modules
		// Instantiate start screen display
	wire [10:0] rgb_start_screen;
	start_screen start_screen_display(
		.clk(clk),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.rgb(rgb_start_screen)
		);

		// Instantiate space ship
	wire [10:0] rgb_spaceship;
	wire is_spaceship;
	spaceship update_spaceship(
		.clk(clk),
		.rst(rst),
		.button_left(button_left),
		.button_right(button_right),
		.button_center(button_center),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.rgb(rgb_spaceship),
		.is_spaceship(is_spaceship)
		);
	
		// Instantiate flying saucer 
	wire [10:0] rgb_flying_saucer;
	wire is_flying_saucer;
	flying_saucer update_flying_saucer(
		.clk(clk),
		.rst(rst),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.rgb(rgb_flying_saucer),
		.is_flying_saucer(is_flying_saucer)
		);
		
		// Instantiate aliens
	wire [10:0] rgb_aliens;
	wire is_alien;
	aliens update_aliens(
		.clk(clk),
		.rst(rst),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.rgb(rgb_aliens),
		.is_alien(is_alien)
		);

	// Screen display mode
	/*
	wire [1:0] mode;	
	initial begin
		mode = 0;
	end
	always @ (posedge clk) begin
		if (rst) begin
			mode = 0;
		end
		if (button_display) begin
			if (mode == 3) begin
				mode = 0;
			end
			else begin
				mode = mode + 1;
			end
		end
	end
	*/
	
   always @ (posedge clk) begin
		// Display visual (in valid screen display)
      if (xCoord >= 0 && xCoord < 640 && yCoord >= 0 && yCoord < 480) begin
			// Start screen
			if (start_screen && !switch_screen) begin
				// Read in pixels from the start_screen module
				set_color <= rgb_start_screen;
			end
			// Switch screen
			// Game mode
			else if (switch_screen) begin
				// Color in borders (temporary to show how much space is available)
					// Scoreboard border
				if (yCoord == SCOREBOARD_TOP || yCoord == SCOREBOARD_BOTTOM) begin
					set_color <= COLOR_RED;
				end
					// Barrier border
				else if (yCoord == BARRIER_TOP || yCoord == BARRIER_BOTTOM) begin
					set_color <= COLOR_BLUE;
				end
					// Extra lives border 
				else if (yCoord == EXTRA_LIVES_TOP || yCoord == EXTRA_LIVES_BOTTOM) begin
					set_color <= COLOR_GREEN;
				end
				// Color in flying saucer
				else if (is_flying_saucer) begin
					set_color <= rgb_flying_saucer;
				end
				// Color in scoreboard
				
				// Color in spaceship
				else if (is_spaceship) begin
					set_color <= rgb_spaceship;
				end
				// Color in alien
				else if (is_alien) begin
					set_color <= rgb_aliens;
				end
				else begin
					set_color <= COLOR_SPACE;
				end
			end 
		end
	end
	
   assign rgb = set_color;

endmodule 
