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
	
	// Display boundaries
   	parameter LEFT_EDGE = 11'd0;
   	parameter RIGHT_EDGE = 11'd640;
   	parameter TOP_EDGE = 11'd0;
   	parameter BOTTOM_EDGE = 11'd480;

   	// RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	parameter COLOR_SPACESHIP = 8'b00111111;
	parameter COLOR_SPACE = 8'b11010001;
	parameter COLOR_BLACK = 8'b00000000;
	parameter COLOR_WHITE = 8'b11111111;
	parameter COLOR_GREEN = 8'b00111000;
	parameter COLOR_YELLOW = 8'b00111111;
	
	// Scoreboard Parameters
	
	
	// Spaceship Parameters
	reg [10:0] SPACESHIP_HEIGHT = 11'd10;
	reg [10:0] SPACESHIP_LENGTH = 11'd40;
	reg [10:0] SPACESHIP_TOP = 11'd450;
	reg [10:0] SPACESHIP_BOTTOM = 11'd460;
	
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
		spaceship_coord = 11'd320;
		// Initialize switches
		is_blank_screen = 1;
		is_start_screen = 0;
		is_switch_screen = 0;
   	end

	wire clk_frame = (xCoord == 0 && yCoord == 0);
   	always @(posedge clk) begin
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
        		 if (button_left && spaceship_coord > 0 + SPACESHIP_LENGTH / 2) begin
				spaceship_coord = spaceship_coord - MOVE_LEFT;
			end
			// Right button pressed, update spaceship position to the right (if possible)
         		if (button_right && spaceship_coord < 640 - SPACESHIP_LENGTH / 2) begin
				spaceship_coord = spaceship_coord + MOVE_RIGHT;
			end
			// Center button pressed, shoot spaceship laser
         		//if (button_center) begin
					
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
			// SPACE (40 by 50)
			// Letter S (revised)
			if ((xCoord > 0 && xCoord < 10) || (xCoord > 640-10 && xCoord < 640)) begin
				set_color <= COLOR_WHITE;
			end
			else if (xCoord > 200 && xCoord < 240 && yCoord > 100 && yCoord < 150) begin
				if (
					(xCoord > 200 && xCoord < 210 && yCoord > 100 && yCoord < 105) ||
					(xCoord > 230 && xCoord < 240 && yCoord > 100 && yCoord < 105) ||
					(xCoord > 210 && xCoord < 230 && yCoord > 110 && yCoord < 120) ||
					(xCoord >= 230 && xCoord < 240 && yCoord >= 115 && yCoord < 125) ||
					(xCoord > 200 && xCoord < 210 && yCoord > 125 && yCoord < 135) ||
					(xCoord >= 210 && xCoord < 230 && yCoord > 130 && yCoord < 140) ||
					(xCoord > 200 && xCoord < 210 && yCoord > 145 && yCoord < 150) ||
					(xCoord > 230 && xCoord < 240 && yCoord > 145 && yCoord < 150)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// Letter P (revised)
			else if (xCoord > 250 && xCoord < 290 && yCoord > 100 && yCoord < 150) begin
				if (
					(xCoord > 285 && xCoord < 290 && yCoord > 100 && yCoord < 105) ||
					(xCoord > 260 && xCoord < 280 && yCoord > 105 && yCoord < 120) ||
					(xCoord > 285 && xCoord < 290 && yCoord > 120 && yCoord < 125) ||
					(xCoord > 260 && xCoord < 290 && yCoord >= 125 && yCoord < 150)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// Letter A (revised)
			else if (xCoord > 300 && xCoord < 340 && yCoord > 100 && yCoord < 150) begin
				if (
					(xCoord > 300 && xCoord < 305 && yCoord > 100 && yCoord < 105) ||
					(xCoord > 335 && xCoord < 340 && yCoord > 100 && yCoord < 105) ||
					(xCoord > 310 && xCoord < 330 && yCoord > 105 && yCoord < 120) ||
					(xCoord > 310 && xCoord < 330 && yCoord > 125 && yCoord < 150)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// Letter C (revised)
			else if (xCoord > 350 && xCoord < 390 && yCoord > 100 && yCoord < 150) begin
				if (
					(xCoord > 350 && xCoord < 360 && yCoord > 100 && yCoord < 105) ||
					(xCoord > 380 && xCoord < 390 && yCoord > 100 && yCoord < 105) ||
					(xCoord > 360 && xCoord < 380 && yCoord > 110 && yCoord < 140) ||
					(xCoord >= 380 && xCoord < 390 && yCoord > 115 && yCoord < 135) ||
					(xCoord > 350 && xCoord < 360 && yCoord > 145 && yCoord < 150) ||
					(xCoord > 380 && xCoord < 390 && yCoord > 145 && yCoord < 150)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// Letter E (revised)
			else if (xCoord > 400 && xCoord < 440 && yCoord > 100 && yCoord < 150) begin
				if (
					(xCoord > 410 && xCoord < 440 && yCoord > 110 && yCoord < 120) ||
					(xCoord > 430 && xCoord < 440 && yCoord >= 120 && yCoord < 130) ||
					(xCoord > 410 && xCoord < 440 && yCoord >= 130 && yCoord < 140)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end	
			// INVADERS	(30 by 40)	
			// Letter I
			else if (xCoord > 185 && xCoord < 215 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 185 && xCoord < 195 && yCoord > 195 && yCoord < 225) ||
					(xCoord > 205 && xCoord < 215 && yCoord > 195 && yCoord < 225)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// Letter N
			else if (xCoord > 220 && xCoord < 250 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 230 && xCoord < 240 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 233 && xCoord < 240 && yCoord >= 195 && yCoord < 200) ||
					(xCoord > 236 && xCoord < 240 && yCoord >= 200 && yCoord < 205) ||
					(xCoord > 230 && xCoord < 233 && yCoord > 215 && yCoord < 220) ||
					(xCoord > 230 && xCoord < 236 && yCoord >= 220 && yCoord < 225) ||
					(xCoord > 230 && xCoord < 240 && yCoord >= 225 && yCoord < 230)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end 
			// Letter V
			else if (xCoord > 255 && xCoord < 285 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 265 && xCoord < 275 && yCoord > 190 && yCoord < 210) ||
					(xCoord > 255 && xCoord < 260 && yCoord > 215 && yCoord < 225) ||
					(xCoord > 280 && xCoord < 285 && yCoord > 215 && yCoord < 225) ||
					(xCoord > 255 && xCoord < 265 && yCoord >= 225 && yCoord < 230) ||
					(xCoord > 275 && xCoord < 285 && yCoord >= 225 && yCoord < 230)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// Letter A
			else if (xCoord > 290 && xCoord < 320 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 290 && xCoord < 295 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 315 && xCoord < 320 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 300 && xCoord < 310 && yCoord > 195 && yCoord < 205) ||
					(xCoord > 300 && xCoord < 310 && yCoord > 210 && yCoord < 230)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end 
			// Letter D
			else if (xCoord > 325 && xCoord < 355 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 345 && xCoord < 355 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 350 && xCoord < 355 && yCoord >= 195 && yCoord < 200) ||
					(xCoord > 345 && xCoord < 355 && yCoord >= 225 && yCoord < 230) ||
					(xCoord > 350 && xCoord < 355 && yCoord > 220 && yCoord < 225) ||
					(xCoord > 335 && xCoord < 340 && yCoord > 195 && yCoord < 225) ||
					(xCoord >= 340 && xCoord < 345 && yCoord > 200 && yCoord < 220)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// Letter E
			else if (xCoord > 360 && xCoord < 390 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 370 && xCoord < 390 && yCoord > 195 && yCoord < 205) ||
					(xCoord > 380 && xCoord < 390 && yCoord >= 205 && yCoord < 215) ||
					(xCoord > 370 && xCoord < 390 && yCoord >= 215 && yCoord < 225)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// Letter R
			else if (xCoord > 395 && xCoord < 425 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 420 && xCoord < 425 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 405 && xCoord < 415 && yCoord > 195 && yCoord < 205) ||
					(xCoord > 420 && xCoord < 425 && yCoord > 205 && yCoord < 215) ||
					(xCoord > 405 && xCoord < 410 && yCoord > 210 && yCoord < 215) ||
					(xCoord > 405 && xCoord < 415 && yCoord >= 215 && yCoord < 230)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end 
			// Letter S
			else if (xCoord > 430 && xCoord < 460 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 430 && xCoord < 435 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 455 && xCoord < 460 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 435 && xCoord <= 455 && yCoord > 200 && yCoord < 207) ||
					(xCoord >= 435 && xCoord < 455 && yCoord > 213 && yCoord < 220) ||
					(xCoord > 455 && xCoord < 460 && yCoord > 202 && yCoord < 210) ||
					(xCoord > 430 && xCoord < 435 && yCoord >= 210 && yCoord < 218) || 
					(xCoord > 430 && xCoord < 435 && yCoord > 225 && yCoord < 230) ||
					(xCoord > 455 && xCoord < 460 && yCoord > 225 && yCoord < 230) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end		
			// Space Invader (Enemy) (60 by 80)
			else if (xCoord > 290 && xCoord < 350 && yCoord > 270 && yCoord < 350) begin
				if (
					(xCoord > 290 && xCoord < 310 && yCoord > 270 && yCoord < 280) ||
					(xCoord > 330 && xCoord < 350 && yCoord > 270 && yCoord < 280) ||
					(xCoord > 290 && xCoord < 300 && yCoord >= 280 && yCoord < 290) ||
					(xCoord > 340 && xCoord < 350 && yCoord >= 280 && yCoord < 290) ||
					(xCoord > 305 && xCoord < 315 && yCoord > 290 && yCoord < 300) ||
					(xCoord > 325 && xCoord < 335 && yCoord > 290 && yCoord < 300) ||
					(xCoord > 290 && xCoord < 305 && yCoord > 310 && yCoord < 320) ||
					(xCoord > 315 && xCoord < 325 && yCoord > 310 && yCoord < 310) ||
					(xCoord > 335 && xCoord < 350 && yCoord > 310 && yCoord < 320) ||
					(xCoord > 290 && xCoord < 300 && yCoord >= 320 && yCoord < 330) ||
					(xCoord > 310 && xCoord < 315 && yCoord >= 320 && yCoord < 330) ||
					(xCoord > 325 && xCoord < 330 && yCoord >= 320 && yCoord < 330) ||
					(xCoord > 340 && xCoord < 350 && yCoord >= 320 && yCoord < 330) ||
					(xCoord > 300 && xCoord < 340 && yCoord > 340 && yCoord < 350)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			else begin
				set_color <= COLOR_BLACK;
			end
			end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// Switch screen
// Game mode
			else if (is_switch_screen) begin
				// Color in spaceship
				if (yCoord >= SPACESHIP_TOP && yCoord <= SPACESHIP_BOTTOM && 
					 xCoord >= spaceship_coord - SPACESHIP_LENGTH / 2 && 
					 xCoord <= spaceship_coord + SPACESHIP_LENGTH / 2
					) begin
					set_color <= COLOR_SPACESHIP;
				end
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
