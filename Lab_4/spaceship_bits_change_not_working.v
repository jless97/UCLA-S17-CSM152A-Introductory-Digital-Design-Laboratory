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
	input wire [9:0] xCoord,
	input wire [9:0] yCoord,
	input wire [9:0] flying_saucer_xCoord,
	input wire [9:0] flying_saucer_yCoord,
	input wire [549:0] alien_xCoord,
	input wire [549:0] alien_yCoord,
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
	parameter SCOREBOARD_BOTTOM = 10'd40;
	
	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
   // RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	reg [7:0] set_color_laser;
	parameter COLOR_SPACESHIP = 8'b01111000;
	parameter COLOR_LASER = 8'b11111111;
	parameter COLOR_LASER_BLACK = 8'b00000000;
	
	// Spaceship Parameters
	parameter SPACESHIP_HEIGHT = 10'd10;
	parameter SPACESHIP_LENGTH = 10'd40;
	parameter SPACESHIP_TOP = 10'd420;
	parameter SPACESHIP_BOTTOM = 10'd430;
	parameter SPACESHIP_INITIAL = 10'd320;
	reg [9:0] spaceship_coord;
		
	// Laser Parameters
	parameter LASER_HEIGHT = 10'd10;
	parameter LASER_LENGTH = 10'd3;
	parameter LASER_INITIAL_X = 10'd320;
	parameter LASER_INITIAL_Y = 10'd417;
	
	// Flying Saucer Parameters
	parameter FLYING_SAUCER_HEIGHT = 10'd15;
	parameter FLYING_SAUCER_LENGTH = 10'd40;
	
	// Alien Parameters
	parameter ALIEN_HEIGHT = 10'd16;
	parameter ALIEN_LENGTH = 10'd30;
	
	// Position Updates
   parameter MOVE_LEFT  = 10'd1;
	parameter MOVE_RIGHT = 10'd1;
	parameter MOVE_UP = 10'd1;
		
	// Laser implementation
	reg [9:0] laser_xCoord;
	reg [9:0] laser_yCoord;
	reg [9:0] laser_counter;
	reg is_active_laser;
	
	// Initialize spaceship
	initial begin
		// Spaceship begins in the middle of the scren
		spaceship_coord = SPACESHIP_INITIAL;
		laser_xCoord = LASER_INITIAL_X;
		laser_yCoord = LASER_INITIAL_Y;
		laser_counter = 10'd0;
		is_active_laser = 0;
	end
	
	wire clk_frame = (xCoord == 0 && yCoord == 0);
	always @ (posedge clk) begin
		if (rst || mode == 0 || mode == 1 || restart) begin
			// Reset position of the spaceship
			spaceship_coord <= SPACESHIP_INITIAL;
			laser_xCoord <= LASER_INITIAL_X;
			laser_yCoord <= LASER_INITIAL_Y;
			laser_counter <= 10'd0;
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
    				 (laser_yCoord <= alien_yCoord[9:0] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[9:0] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[9:0] + ALIEN_LENGTH / 2) ||
					  // Alien 1
					 (laser_yCoord <= alien_yCoord[19:10] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[19:10] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[19:10] + ALIEN_LENGTH / 2) ||
					  // Alien 2
					 (laser_yCoord <= alien_yCoord[29:20] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[29:20] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[29:20] + ALIEN_LENGTH / 2) 
/*					  // Alien 3
					 (laser_yCoord <= alien_yCoord[39:30] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[39:30] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[39:30] + ALIEN_LENGTH / 2) ||
					  // Alien 4
					  (laser_yCoord <= alien_yCoord[49:40] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[49:40] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[49:40] + ALIEN_LENGTH / 2) ||
					  // Alien 5
					 (laser_yCoord <= alien_yCoord[59:50] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[59:50] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[59:50] + ALIEN_LENGTH / 2) ||
					  // Alien 6
					  (laser_yCoord <= alien_yCoord[69:60] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[69:60] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[69:60] + ALIEN_LENGTH / 2) ||
					  // Alien 7
					 (laser_yCoord <= alien_yCoord[79:70] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[79:70] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[79:70] + ALIEN_LENGTH / 2) ||
					  // Alien 8
					  (laser_yCoord <= alien_yCoord[89:80] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[89:80] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[89:80] + ALIEN_LENGTH / 2) ||
					  // Alien 9
					 (laser_yCoord <= alien_yCoord[99:90] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[99:90] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[99:90] + ALIEN_LENGTH / 2) ||
					  // Alien 10
					  (laser_yCoord <= alien_yCoord[109:100] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[109:100] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[109:100] + ALIEN_LENGTH / 2) ||
					  // Alien 11
					 (laser_yCoord <= alien_yCoord[119:110] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[119:110] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[119:110] + ALIEN_LENGTH / 2) ||
					  // Alien 12
					  (laser_yCoord <= alien_yCoord[129:120] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[129:120] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[129:120] + ALIEN_LENGTH / 2) ||
					  // Alien 13
					 (laser_yCoord <= alien_yCoord[139:130] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[139:130] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[139:130] + ALIEN_LENGTH / 2) ||
					  // Alien 14
					  (laser_yCoord <= alien_yCoord[149:140] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[149:140] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[149:140] + ALIEN_LENGTH / 2) ||
					  // Alien 15
					 (laser_yCoord <= alien_yCoord[159:150] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[159:150] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[159:150] + ALIEN_LENGTH / 2) ||
					  // Alien 16
					  (laser_yCoord <= alien_yCoord[169:160] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[169:160] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[169:160] + ALIEN_LENGTH / 2) ||
					  // Alien 17
					 (laser_yCoord <= alien_yCoord[179:170] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[179:170] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[179:170] + ALIEN_LENGTH / 2) ||
					  // Alien 18
					  (laser_yCoord <= alien_yCoord[189:180] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[189:180] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[189:180] + ALIEN_LENGTH / 2) ||
					  // Alien 19
					 (laser_yCoord <= alien_yCoord[199:190] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[199:190] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[199:190] + ALIEN_LENGTH / 2) ||
					  // Alien 20
					  (laser_yCoord <= alien_yCoord[209:200] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[209:200] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[209:200] + ALIEN_LENGTH / 2) ||
					  // Alien 21
					 (laser_yCoord <= alien_yCoord[219:210] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[219:210] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[219:210] + ALIEN_LENGTH / 2) || 
					  // Alien 22
					  (laser_yCoord <= alien_yCoord[229:220] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[229:220] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[229:220] + ALIEN_LENGTH / 2) ||
					  // Alien 23
					 (laser_yCoord <= alien_yCoord[239:230] + ALIEN_HEIGHT / 2 + MOVE_UP &&
					  laser_xCoord >= alien_xCoord[239:230] - ALIEN_LENGTH / 2 && laser_xCoord <= alien_xCoord[239:230] + ALIEN_LENGTH / 2) 
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
