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
	input wire rst,
   input wire button_left, 
	input wire button_right, 
	input wire button_center,
	input wire start_screen,
	input wire switch_screen,
   input wire [10:0] xCoord, 
	input wire [10:0] yCoord,
	// Outputs
   output wire [7:0] rgb
	);
	
	// Display screen boundaries
   parameter LEFT_EDGE = 11'd0;
   parameter RIGHT_EDGE = 11'd640;
   parameter TOP_EDGE = 11'd0;
   parameter BOTTOM_EDGE = 11'd480;

   // RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	parameter COLOR_SPACESHIP = 8'b00111111;
	parameter COLOR_SPACE = 8'b00000000;
	parameter COLOR_BLACK = 8'b00000000;
	parameter COLOR_WHITE = 8'b11111111;
	parameter COLOR_GREEN = 8'b00111000;
	parameter COLOR_RED = 8'b00000111;
	parameter COLOR_BLUE = 8'b11000000;
	parameter COLOR_YELLOW = 8'b00111111;
	
	// Border (separation of objects) Parameters
	parameter SCOREBOARD_TOP = 11'd0;
	parameter SCOREBOARD_BOTTOM = 11'd40;
	parameter BARRIER_TOP = 11'd340;
	parameter BARRIER_BOTTOM = 11'd400;
	parameter EXTRA_LIVES_TOP = 11'd460;
	parameter EXTRA_LIVES_BOTTOM = 11'd480;
	
	// Scoreboard Parameters
	
	
	// Spaceship Parameters
	reg [10:0] SPACESHIP_HEIGHT = 11'd10;
	reg [10:0] SPACESHIP_LENGTH = 11'd40;
	reg [10:0] SPACESHIP_TOP = 11'd420;
	reg [10:0] SPACESHIP_BOTTOM = 11'd430;
	reg [10:0] SPACESHIP_INITIAL = 11'd320;
	
	// Alien Parameters
	
	
	// Flying Saucer Parameters
	
	
   	// Position Updates
   parameter MOVE_LEFT  = 10'd1;
	parameter MOVE_RIGHT = 10'd1;

  	// Initialize game objects
	reg [10:0] spaceship_coord;
	reg is_blank_screen;
	reg is_start_screen;
	reg is_switch_screen;
	// TODO: when player dies, or game is quit, then display gameover screen
	reg is_gameover_screen;
   initial begin
		// Initial display is all black
		set_color = COLOR_BLACK;
		// Spaceship begins in the middle of the scren
		spaceship_coord = SPACESHIP_INITIAL;
		// Initialize switches
		is_blank_screen = 1;
		is_start_screen = 0;
		is_switch_screen = 0;
   end

	// Instantiate modules
		// Instantiate start screen display
	wire [10:0] set_color_start_screen;
	start_screen start_screen_display(
		.clk(clk),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.rgb(set_color_start_screen)
		);

	wire clk_frame = (xCoord == 0 && yCoord == 0);
   always @(posedge clk) begin
		// Reset controls
		// Reset button pressed, display start screen, reset all game variables
		if (rst) begin
			// TODO: When new objects added, reset their properties
			// TODO: Reset screens (right now, just resets game level)
			
			// Reset spaceship
			spaceship_coord = SPACESHIP_INITIAL;
		end
		// Update objects
		if (clk_frame) begin
			// Switch Controls
			// Start screen switch flipped
			if (start_screen && !switch_screen) begin
				is_start_screen = 1;
			end
			// Switch screen switch flipped
			else if (switch_screen) begin
				is_switch_screen = 1;
				is_start_screen = 0;
			end
			else if (!start_screen && !switch_screen) begin
				is_blank_screen = 1;
				is_start_screen = 0;
				is_switch_screen = 0;
			end
			// Spaceship Controls
			// Left button pressed, update spaceship position to the left (is possible)
        	if (switch_screen && button_left && spaceship_coord > 0 + SPACESHIP_LENGTH / 2) begin
				spaceship_coord = spaceship_coord - MOVE_LEFT;
			end
			// Right button pressed, update spaceship position to the right (if possible)
         if (switch_screen && button_right && spaceship_coord < 640 - SPACESHIP_LENGTH / 2) begin
				spaceship_coord = spaceship_coord + MOVE_RIGHT;
			end
			// Center button pressed, shoot spaceship laser
         //if (switch_screen && button_center) begin
					
			//end
		end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		// Display visual
      if (xCoord >= 0 && xCoord < 640 && yCoord >= 0 && yCoord < 480) begin
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// Start screen
			if (is_start_screen) begin
				// Color start screen
				// Read in pixels from the start_screen module
				set_color <= set_color_start_screen;
			end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// Switch screen
// Game mode
			else if (is_switch_screen) begin
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
				// Color in spaceship
				else if (yCoord >= SPACESHIP_TOP && yCoord <= SPACESHIP_BOTTOM && 
							xCoord >= spaceship_coord - SPACESHIP_LENGTH / 2 && 
							xCoord <= spaceship_coord + SPACESHIP_LENGTH / 2
						) begin
					set_color <= COLOR_SPACESHIP;
				end
				// Color in alien ships
				
				// Color in flying saucer
				
				// Color in scoreboard
				
				// Color in space
				else begin
					set_color <= COLOR_SPACE;
				end
			end 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// Blank screen
			else begin
				set_color <= COLOR_BLACK;
			end
		end
		// Outside the 640x480 display
		else begin
         		set_color <= COLOR_BLACK;
      		end
	end

   assign rgb = set_color;

endmodule
