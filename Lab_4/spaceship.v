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
	input wire [604:0] alien_xCoord,
	input wire [604:0] alien_yCoord,
	// Outputs
	output wire [7:0] rgb,
	output wire is_spaceship,
	output wire [7:0] rgb_spaceship_laser,
	output wire is_spaceship_laser,
	output wire [10:0] current_laser_xCoord,
	output wire [10:0] current_laser_yCoord
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
						// Alien 0
    				 (laser_yCoord <= alien_yCoord[10:0] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[10:0] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[10:0] + ALIEN_LENGTH / 2) ||
					  // Alien 1
					 (laser_yCoord <= alien_yCoord[21:11] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[21:11] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[21:11] + ALIEN_LENGTH / 2) ||
					  // Alien 2
					 (laser_yCoord <= alien_yCoord[32:22] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[32:22] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[32:22] + ALIEN_LENGTH / 2) ||
					  // Alien 3
					 (laser_yCoord <= alien_yCoord[43:33] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[43:33] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[43:33] + ALIEN_LENGTH / 2) ||
					  // Alien 4
					  (laser_yCoord <= alien_yCoord[54:44] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[54:44] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[54:44] + ALIEN_LENGTH / 2) ||
					  // Alien 5
					 (laser_yCoord <= alien_yCoord[65:55] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[65:55] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[65:55] + ALIEN_LENGTH / 2) ||
					  // Alien 6
					  (laser_yCoord <= alien_yCoord[76:66] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[76:66] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[76:66] + ALIEN_LENGTH / 2) ||
					  // Alien 7
					 (laser_yCoord <= alien_yCoord[87:77] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[87:77] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[87:77] + ALIEN_LENGTH / 2) ||
					  // Alien 8
					  (laser_yCoord <= alien_yCoord[98:88] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[98:88] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[98:88] + ALIEN_LENGTH / 2) ||
					  // Alien 9
					 (laser_yCoord <= alien_yCoord[109:99] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[109:99] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[109:99] + ALIEN_LENGTH / 2) ||
					  // Alien 10
					  (laser_yCoord <= alien_yCoord[120:110] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[120:110] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[120:110] + ALIEN_LENGTH / 2) ||
					  // Alien 11
					 (laser_yCoord <= alien_yCoord[131:121] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[131:121] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[131:121] + ALIEN_LENGTH / 2) ||
					  // Alien 12
					  (laser_yCoord <= alien_yCoord[142:132] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[142:132] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[142:132] + ALIEN_LENGTH / 2) ||
					  // Alien 13
					 (laser_yCoord <= alien_yCoord[153:143] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[153:143] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[153:143] + ALIEN_LENGTH / 2) ||
					  // Alien 14
					  (laser_yCoord <= alien_yCoord[164:154] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[164:154] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[164:154] + ALIEN_LENGTH / 2) ||
					  // Alien 15
					 (laser_yCoord <= alien_yCoord[175:165] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[175:165] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[175:165] + ALIEN_LENGTH / 2) ||
					  // Alien 16
					  (laser_yCoord <= alien_yCoord[186:176] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[186:176] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[186:176] + ALIEN_LENGTH / 2) ||
					  // Alien 17
					 (laser_yCoord <= alien_yCoord[197:187] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[197:187] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[197:187] + ALIEN_LENGTH / 2) ||
					  // Alien 18
					  (laser_yCoord <= alien_yCoord[208:198] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[208:198] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[208:198] + ALIEN_LENGTH / 2) ||
					  // Alien 19
					 (laser_yCoord <= alien_yCoord[219:209] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[219:209] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[219:209] + ALIEN_LENGTH / 2) ||
					  // Alien 20
					  (laser_yCoord <= alien_yCoord[230:220] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[230:220] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[230:220] + ALIEN_LENGTH / 2) ||
					  // Alien 21
					 (laser_yCoord <= alien_yCoord[241:231] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[241:231] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[241:231] + ALIEN_LENGTH / 2)  
					  // Alien 22
/*					  (laser_yCoord <= alien_yCoord[252:242] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[252:242] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[252:242] + ALIEN_LENGTH / 2) ||
					  // Alien 23
					 (laser_yCoord <= alien_yCoord[263:253] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[263:253] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[263:253] + ALIEN_LENGTH / 2) ||
					  // Alien 24
					  (laser_yCoord <= alien_yCoord[274:264] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[274:264] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[274:264] + ALIEN_LENGTH / 2) ||
					  // Alien 25
					 (laser_yCoord <= alien_yCoord[285:275] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[285:275] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[285:275] + ALIEN_LENGTH / 2) ||
					  // Alien 26
					  (laser_yCoord <= alien_yCoord[296:286] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[296:286] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[296:286] + ALIEN_LENGTH / 2) ||
					  // Alien 27
					 (laser_yCoord <= alien_yCoord[307:297] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[307:297] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[307:297] + ALIEN_LENGTH / 2) ||
					  // Alien 28
					  (laser_yCoord <= alien_yCoord[318:308] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[318:308] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[318:308] + ALIEN_LENGTH / 2) ||
					  // Alien 29
					 (laser_yCoord <= alien_yCoord[329:319] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[329:319] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[329:319] + ALIEN_LENGTH / 2) ||
					  // Alien 30
					  (laser_yCoord <= alien_yCoord[340:330] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[340:330] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[340:330] + ALIEN_LENGTH / 2) ||
					  // Alien 31
					 (laser_yCoord <= alien_yCoord[351:341] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[351:341] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[351:341] + ALIEN_LENGTH / 2) ||
					  // Alien 32
					  (laser_yCoord <= alien_yCoord[362:352] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[362:352] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[362:352] + ALIEN_LENGTH / 2) ||
					  // Alien 33
					 (laser_yCoord <= alien_yCoord[373:363] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[373:363] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[373:363] + ALIEN_LENGTH / 2) ||
					  // Alien 34
					  (laser_yCoord <= alien_yCoord[384:374] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[384:374] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[384:374] + ALIEN_LENGTH / 2) ||
					  // Alien 35
					 (laser_yCoord <= alien_yCoord[395:385] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[395:385] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[395:385] + ALIEN_LENGTH / 2) ||
					  // Alien 36
					  (laser_yCoord <= alien_yCoord[406:396] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[406:396] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[406:396] + ALIEN_LENGTH / 2) ||
					  // Alien 37
					 (laser_yCoord <= alien_yCoord[417:407] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[417:407] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[417:407] + ALIEN_LENGTH / 2) ||
					  // Alien 38
					  (laser_yCoord <= alien_yCoord[428:418] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[428:418] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[428:418] + ALIEN_LENGTH / 2) ||
					  // Alien 39
					 (laser_yCoord <= alien_yCoord[439:429] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[439:429] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[439:429] + ALIEN_LENGTH / 2) ||
					  // Alien 40
					  (laser_yCoord <= alien_yCoord[450:440] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[450:440] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[450:440] + ALIEN_LENGTH / 2) ||
					  // Alien 41
					 (laser_yCoord <= alien_yCoord[461:451] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[461:451] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[461:451] + ALIEN_LENGTH / 2) ||
					  // Alien 42
					  (laser_yCoord <= alien_yCoord[472:462] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[472:462] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[472:462] + ALIEN_LENGTH / 2) ||
					  // Alien 43
					 (laser_yCoord <= alien_yCoord[483:473] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[483:473] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[483:473] + ALIEN_LENGTH / 2) ||
					  // Alien 44
					  (laser_yCoord <= alien_yCoord[494:484] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[494:484] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[494:484] + ALIEN_LENGTH / 2) ||
					  // Alien 45
					 (laser_yCoord <= alien_yCoord[505:495] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[505:495] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[505:495] + ALIEN_LENGTH / 2) ||
					  // Alien 46
					  (laser_yCoord <= alien_yCoord[516:506] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[516:506] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[516:506] + ALIEN_LENGTH / 2) ||
					  // Alien 47
					 (laser_yCoord <= alien_yCoord[527:517] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[527:517] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[527:517] + ALIEN_LENGTH / 2) ||
					  // Alien 48
					  (laser_yCoord <= alien_yCoord[538:528] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[538:528] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[538:528] + ALIEN_LENGTH / 2) ||
					  // Alien 49
					 (laser_yCoord <= alien_yCoord[549:539] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[549:539] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[549:539] + ALIEN_LENGTH / 2) ||
					  // Alien 50
					  (laser_yCoord <= alien_yCoord[560:550] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[560:550] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[560:550] + ALIEN_LENGTH / 2) ||
					  // Alien 51
					 (laser_yCoord <= alien_yCoord[571:561] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[571:561] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[571:561] + ALIEN_LENGTH / 2) ||
					  // Alien 52
					  (laser_yCoord <= alien_yCoord[582:572] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[582:572] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[582:572] + ALIEN_LENGTH / 2) ||
					  // Alien 53
					 (laser_yCoord <= alien_yCoord[593:583] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[593:583] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[593:583] + ALIEN_LENGTH / 2) ||
					  // Alien 54
					  (laser_yCoord <= alien_yCoord[604:594] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[604:594] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[604:594] + ALIEN_LENGTH / 2) */
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
								  xCoord >= spaceship_coord - SPACESHIP_LENGTH / 2 && xCoord <= spaceship_coord + SPACESHIP_LENGTH / 2
								  );
	// Assign laser colors
	assign rgb_spaceship_laser = set_color_laser;
	assign is_spaceship_laser = (yCoord >= laser_yCoord - LASER_HEIGHT / 2 && yCoord <= laser_yCoord + LASER_HEIGHT / 2 &&
							 xCoord >= laser_xCoord - LASER_LENGTH / 2 && xCoord <= laser_xCoord + LASER_LENGTH / 2); // TODO
	
endmodule 
