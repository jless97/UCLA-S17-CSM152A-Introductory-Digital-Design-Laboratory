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
	input wire alien_clk,
	input wire rst,
   input wire button_left, 
	input wire button_right, 
	input wire button_shoot,
	input wire button_display,
	input wire start_screen,
	input wire switch_screen,
   input wire [9:0] xCoord, 
	input wire [9:0] yCoord,
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
	parameter SCOREBOARD_BOTTOM = 11'd60;
	parameter BARRIER_TOP = 11'd340;
	parameter BARRIER_BOTTOM = 11'd400;
	parameter EXTRA_LIVES_TOP = 11'd445;
	parameter EXTRA_LIVES_BOTTOM = 11'd480;
	
	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// laser Parameters
	parameter LASER_HEIGHT = 11'd10;
	parameter LASER_LENGTH = 11'd3;
	parameter SPACESHIP_HEIGHT = 11'd10;
	parameter SPACESHIP_LENGTH = 11'd40;
	parameter SPACESHIP_TOP = 11'd420;
	parameter SPACESHIP_BOTTOM = 11'd430;
	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// Screen display mode
	// Mode 0: Black screen
	// Mode 1: Start screen
	// Mode 2: Game screen
	wire [1:0] mode;	
	reg [1:0] mode_temp;
	initial begin
		mode_temp = 0;
	end
	always @ (posedge button_display or posedge rst) begin
		if (rst) begin
			mode_temp <= 0;
		end
		else begin
			if (mode == 2) begin
					mode_temp <= 0;
			end
			else begin
				mode_temp <= mode + 1;
			end
		end
	end
	
	assign mode = mode_temp;

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// Instantiate modules
	
	// Instantiate start screen display
	wire [7:0] rgb_start_screen;
	start_screen start_screen_display(
	//Inputs
		.clk(clk),
		.xCoord(xCoord),
		.yCoord(yCoord),
	//Outputs
		.rgb(rgb_start_screen)
		);
/*
	// Instantiate gameover screen display
	wire [7:0] rgb_gameover_screen;
	gameover_screen gameover_screen_display(
	//Inputs
		.clk(clk),
		.xCoord(xCoord),
		.yCoord(yCoord),
	//Outputs
		.rgb(rgb_gameover_screen)
		);
	
	// Instantiate top scoreboard display
	wire [7:0] rgb_scoreboard_top;
	wire is_scoreboard_top;
	scoreboard_top scoreboard_top_display(
	//Inputs
		.clk(clk),
		.xCoord(xCoord),
		.yCoord(yCoord),
	//Outputs
		.rgb(rgb_scoreboard_top),
		.is_scoreboard_top(is_scoreboard_top)
		);
	
	// Instantiate bottom scoreboard display
//	wire [10:0] rgb_scoreboard_bottom;
//	wire is_scoreboard_bottom;
//	scoreboard_bottom scoreboard_bottom_display(
//	//Inputs
//		.clk(clk),
//		.xCoord(xCoord),
//		.yCoord(yCoord),
//	//Outputs
//		.rgb(rgb_scoreboard_bottom),
//		.is_scoreboard_bottom(is_scoreboard_bottom)
//		);
*/		
	// Instantiate space ship
	wire [7:0] rgb_spaceship;
	wire is_spaceship;
		// Coordinates of alien modules
	wire [131:0] alien_xCoord;
	wire [131:0] alien_yCoord;
		// Coordinates of the flying saucer
	wire [10:0] flying_saucer_xCoord;
	wire [10:0] flying_saucer_yCoord;
		// Coordinates of barrier(pieces)
		// Coordinates of spaceship laser
	wire [10:0] spaceship_laser_xCoord;
	wire [10:0] spaceship_laser_yCoord;
	wire [131:0] alien_laser_xCoord;
	wire [131:0] alien_laser_yCoord;
	wire [7:0] rgb_spaceship_laser;
	wire is_spaceship_laser;
	wire restart;
	reg restart_temp;
	wire barrSpaceshipLaserHit;
	spaceship update_spaceship(
	//Inputs
		.clk(clk),
		.rst(rst),
		.restart(restart),
		.button_left(button_left),
		.button_right(button_right),
		.button_shoot(button_shoot),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.alien_xCoord(alien_xCoord),
		.alien_yCoord(alien_yCoord),
		.alien_laser_xCoord(alien_laser_xCoord),
		.alien_laser_yCoord(alien_laser_yCoord),
		.flying_saucer_xCoord(flying_saucer_xCoord),
		.flying_saucer_yCoord(flying_saucer_yCoord),
		.barrSpaceshipLaserHit(barrSpaceshipLaserHit),
	//Outputs
		.rgb(rgb_spaceship),
		.is_spaceship(is_spaceship),
		.rgb_spaceship_laser(rgb_spaceship_laser),
		.is_spaceship_laser(is_spaceship_laser),
		.current_laser_xCoord(spaceship_laser_xCoord),
		.current_laser_yCoord(spaceship_laser_yCoord)
		);
/*
	// Instantiate flying saucer 
	wire [10:0] rgb_flying_saucer;
	wire is_flying_saucer;
	flying_saucer update_flying_saucer(
	//Inputs
		.clk(clk),
		.rst(rst),
		.restart(restart),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
	//Outputs
		.rgb(rgb_flying_saucer),
		.is_flying_saucer(is_flying_saucer),
		.current_xCoord(flying_saucer_xCoord),
		.current_yCoord(flying_saucer_yCoord)
		);
*/		
			// Instantiate barriers
	wire [7:0] rgb_barrier;
	wire is_barrier;
	set_barriers update_barriers(
	//Inputs
		.clk(clk),
	   .rst(rst),
	   .mode(mode),
		.restart(restart),
	   .xCoord(xCoord),
	   .yCoord(yCoord),

		.spaceshipLaserXcoord(spaceship_laser_xCoord),
		.spaceshipLaserYcoord(spaceship_laser_yCoord-LASER_HEIGHT),
	//Outputs
	   .rgb(rgb_barrier),
	   .is_barrier(is_barrier),
	   .spaceshipLaserHit(barrSpaceshipLaserHit)
		);
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// ALIEN IMPLEMENTATION
		// Instantiate aliens
	wire [11:0] aliens;
	wire [95:0] rgb_aliens;
	wire [95:0] rgb_alien_laser;
		// Player Lives
	wire [2:0] lives;
	reg [2:0] lives_temp;
	wire gameover;
	reg gameover_temp;
		// Controls
	wire [11:0] is_alien;
	wire [11:0] is_alien_laser;
		// Timer before certain alien can shoot
	wire [143:0] shoot_timer;
	assign shoot_timer[11:0] = 12'd986;
	assign shoot_timer[23:12] = 12'd1532;
	assign shoot_timer[35:24] = 12'd668;
	assign shoot_timer[47:36] = 12'd843;
	assign shoot_timer[59:48] = 12'd4001;
	assign shoot_timer[71:60] = 12'd1823;
	assign shoot_timer[83:72] = 12'd4495;
	assign shoot_timer[95:84] = 12'd3643;
	assign shoot_timer[107:96] = 12'd1493;
	assign shoot_timer[119:108] = 12'd3908;
	assign shoot_timer[131:120] = 12'd2929;
	assign shoot_timer[143:132] = 12'd4231;
	wire [11:0] is_edge;
	wire [11:0] is_bottom;
		// Directions
	wire move_left;
	wire move_right;
	wire move_down;
		// Color scheme
	wire color;

	reg move_left_temp;
	reg move_right_temp;
	reg move_down_temp;
	initial begin
		move_left_temp = 0;
		move_right_temp = 1;
		move_down_temp = 0;
	end

	always @ (posedge clk) begin
		if (rst || button_display) begin
			move_left_temp <= 0;
			move_right_temp <= 1;
			move_down_temp <= 0;
		end
		else begin
			if (is_edge && move_left) begin
				move_down_temp <= 1;
				move_right_temp <= 1;
				move_left_temp <= 0;
			end
			if (is_edge && move_right) begin
				move_down_temp <= 1;
				move_left_temp <= 1;
				move_right_temp <= 0;
			end
			if (!is_edge) begin
				move_left_temp <= move_left;
				move_right_temp <= move_right;
				move_down_temp <= 0;
			end
		end
	end
	
	assign move_left = move_left_temp;
	assign move_right = move_right_temp;
	assign move_down = move_down_temp;
	
	// Assign Player Lives
	assign lives = lives_temp;
	assign gameover = gameover_temp;
	assign restart = restart_temp;
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// First row
/*
	// Alien 0
	aliens update_alien_0(
	// Inputs
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[0]),
		.initial_xCoord(11'd195),
		.initial_yCoord(11'd150),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[0]),
		//.color(0),
	// Outputs
		.rgb(rgb_aliens[7:0]),
		.is_alien(is_alien[0]),
		.rgb_alien_laser(rgb_alien_laser[7:0]),
		.is_alien_laser(is_alien_laser[0]),
		.current_xCoord(alien_xCoord[10:0]),
		.current_yCoord(alien_yCoord[10:0]),
		.is_edge(is_edge[0])
//		.is_hit(is_hit[0])
		);

	// Alien 1
	aliens update_alien_1(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[1]),
		.initial_xCoord(11'd245),
		.initial_yCoord(11'd150),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[1]),
		//.color(0),
		.rgb(rgb_aliens[15:8]),
		.is_alien(is_alien[1]),
		.rgb_alien_laser(rgb_alien_laser[15:8]),
		.is_alien_laser(is_alien_laser[1]),
		.current_xCoord(alien_xCoord[21:11]),
		.current_yCoord(alien_yCoord[21:11]),
		.is_edge(is_edge[1])
//		.is_hit(is_hit[1])
		);

		// Alien 2
	aliens update_alien_2(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[2]),
		.initial_xCoord(11'd295),
		.initial_yCoord(11'd150),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[2]),
//		.color(0),
		.rgb(rgb_aliens[23:16]),
		.is_alien(is_alien[2]),
		.rgb_alien_laser(rgb_alien_laser[23:16]),
		.is_alien_laser(is_alien_laser[2]),
		.current_xCoord(alien_xCoord[32:22]),
		.current_yCoord(alien_yCoord[32:22]),
		.is_edge(is_edge[2])
//		.is_hit(is_hit[2])
		);
		
	// Alien 3
	aliens update_alien_3(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[3]),
		.initial_xCoord(11'd345),
		.initial_yCoord(11'd150),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[3]),
//		.color(0),
		.rgb(rgb_aliens[31:24]),
		.is_alien(is_alien[3]),
		.rgb_alien_laser(rgb_alien_laser[31:24]),
		.is_alien_laser(is_alien_laser[3]),
		.current_xCoord(alien_xCoord[43:33]),
		.current_yCoord(alien_yCoord[43:33]),
		.is_edge(is_edge[3])
//		.is_hit(is_hit[3])
		);
		
	// Alien 4
	aliens update_alien_4(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[4]),
		.initial_xCoord(11'd395),
		.initial_yCoord(11'd150),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[4]),
//		.color(0),
		.rgb(rgb_aliens[39:32]),
		.is_alien(is_alien[4]),
		.rgb_alien_laser(rgb_alien_laser[39:32]),
		.is_alien_laser(is_alien_laser[4]),
		.current_xCoord(alien_xCoord[54:44]),
		.current_yCoord(alien_yCoord[54:44]),
		.is_edge(is_edge[4])
//		.is_hit(is_hit[4])
		);
	// Alien 5
	aliens update_alien_5(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[5]),
		.initial_xCoord(11'd445),
		.initial_yCoord(11'd150),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[5]),
//		.color(0),
		.rgb(rgb_aliens[47:40]),
		.is_alien(is_alien[5]),
		.rgb_alien_laser(rgb_alien_laser[47:40]),
		.is_alien_laser(is_alien_laser[5]),
		.current_xCoord(alien_xCoord[65:55]),
		.current_yCoord(alien_yCoord[65:55]),
		.is_edge(is_edge[5])
//		.is_hit(is_hit[5])
		);
		*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// Second row		

	// Alien 6
	aliens update_alien_6(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[6]),
		.initial_xCoord(11'd445),
		.initial_yCoord(11'd180),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[83:72]),
//		.color(0),
		.rgb(rgb_aliens[55:48]),
		.is_alien(is_alien[6]),
		.rgb_alien_laser(rgb_alien_laser[55:48]),
		.is_alien_laser(is_alien_laser[6]),
		.current_xCoord(alien_xCoord[76:66]),
		.current_yCoord(alien_yCoord[76:66]),
		.current_laser_xCoord(alien_laser_xCoord[76:66]),
		.current_laser_yCoord(alien_laser_yCoord[76:66]),
		.is_edge(is_edge[6])
//		.is_hit(is_hit[6])
		);
		
		// Alien 7
	aliens update_alien_7(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[7]),
		.initial_xCoord(11'd395),
		.initial_yCoord(11'd180),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[95:84]),
//		.color(0),
		.rgb(rgb_aliens[63:56]),
		.is_alien(is_alien[7]),
		.rgb_alien_laser(rgb_alien_laser[63:56]),
		.is_alien_laser(is_alien_laser[7]),
		.current_xCoord(alien_xCoord[87:77]),
		.current_yCoord(alien_yCoord[87:77]),
		.current_laser_xCoord(alien_laser_xCoord[87:77]),
		.current_laser_yCoord(alien_laser_yCoord[87:77]),
		.is_edge(is_edge[7])
//		.is_hit(is_hit[7])
		);
		
	// Alien 8
	aliens update_alien_8(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[8]),
		.initial_xCoord(11'd345),
		.initial_yCoord(11'd180),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[107:96]),
//		.color(0),
		.rgb(rgb_aliens[71:64]),
		.is_alien(is_alien[8]),
		.rgb_alien_laser(rgb_alien_laser[71:64]),
		.is_alien_laser(is_alien_laser[8]),
		.current_xCoord(alien_xCoord[98:88]),
		.current_yCoord(alien_yCoord[98:88]),
		.current_laser_xCoord(alien_laser_xCoord[98:88]),
		.current_laser_yCoord(alien_laser_yCoord[98:88]),
		.is_edge(is_edge[8])
//		.is_hit(is_hit[8])
		);
		
	// Alien 9
	aliens update_alien_9(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[9]),
		.initial_xCoord(11'd295),
		.initial_yCoord(11'd180),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[119:108]),
//		.color(0),
		.rgb(rgb_aliens[79:72]),
		.is_alien(is_alien[9]),
		.rgb_alien_laser(rgb_alien_laser[79:72]),
		.is_alien_laser(is_alien_laser[9]),
		.current_xCoord(alien_xCoord[109:99]),
		.current_yCoord(alien_yCoord[109:99]),
		.current_laser_xCoord(alien_laser_xCoord[109:99]),
		.current_laser_yCoord(alien_laser_yCoord[109:99]),
		.is_edge(is_edge[9])
//		.is_hit(is_hit[9])
		);
		
	// Alien 10
	aliens update_alien_10(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[0]),
		.initial_xCoord(11'd245),
		.initial_yCoord(11'd180),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[131:120]),
//		.color(0),
		.rgb(rgb_aliens[87:80]),
		.is_alien(is_alien[10]),
		.rgb_alien_laser(rgb_alien_laser[87:80]),
		.is_alien_laser(is_alien_laser[10]),
		.current_xCoord(alien_xCoord[120:110]),
		.current_yCoord(alien_yCoord[120:110]),
		.current_laser_xCoord(alien_laser_xCoord[120:110]),
		.current_laser_yCoord(alien_laser_yCoord[120:110]),
		.is_edge(is_edge[10])
//		.is_hit(is_hit[10])
		);
	
	// Alien 11
	aliens update_alien_11(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[11]),
		.initial_xCoord(11'd195),
		.initial_yCoord(11'd180),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[143:132]),
//		.color(1),
		.rgb(rgb_aliens[95:88]),
		.is_alien(is_alien[11]),
		.rgb_alien_laser(rgb_alien_laser[95:88]),
		.is_alien_laser(is_alien_laser[11]),
		.current_xCoord(alien_xCoord[131:121]),
		.current_yCoord(alien_yCoord[131:121]),
		.current_laser_xCoord(alien_laser_xCoord[131:121]),
		.current_laser_yCoord(alien_laser_yCoord[131:121]),
		.is_edge(is_edge[11])
//		.is_hit(is_hit[11])
		);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	

   always @ (posedge clk) begin
		// Display visual (in valid screen display)
      if (xCoord >= 0 && xCoord < 640 && yCoord >= 0 && yCoord < 480) begin
			// Blank screen
			if (mode == 0) begin
				set_color <= COLOR_BLACK;
			end
			// Start screen
			else if (mode == 1) begin
				// Read in pixels from the start_screen module
				//set_color <= rgb_start_screen;
				if (xCoord >= 10 && xCoord <= 630 && yCoord >= 10 && yCoord <= 470) begin
					set_color <= COLOR_GREEN;
				end
			end
			// Switch screen
			// Game mode
			else if (mode == 2) begin
			/*
				if (gameover) begin
					set_color <= rgb_gameover_screen;
				end
				else begin*/
				
					// Color in borders (temporary to show how much space is available)
					// Scoreboard border
					if (yCoord == SCOREBOARD_BOTTOM) begin
						set_color <= COLOR_GREEN;
					end
					// Barrier border
					else if (yCoord == BARRIER_BOTTOM) begin
						set_color <= COLOR_BLUE;
					end
					// Extra lives border 
					else if (yCoord == EXTRA_LIVES_TOP) begin
						set_color <= COLOR_GREEN;
					end
					/*
					// Color in flying saucer
					else if (is_flying_saucer) begin
						set_color <= rgb_flying_saucer;
					end
					*/
					// Color in barriers
					else if(is_barrier) begin
						set_color <= rgb_barrier;
					end
					// Color in spaceship
					else if (is_spaceship) begin
						set_color <= rgb_spaceship;
					end
					// Color in spaceship laser
					else if (is_spaceship_laser) begin
						set_color <= rgb_spaceship_laser;
					end
					// Extra lives border 
					else if (yCoord == EXTRA_LIVES_TOP) begin
						set_color <= COLOR_GREEN;
					end
/*
					// Top scoreboard (SCORE and HI-SCORE)
					else if (is_scoreboard_top) begin
						set_color <= rgb_scoreboard_top;
					end
*/
					// Bottom scoreboard (CREDIT 00)
//					else if (is_scoreboard_bottom) begin
//						set_color <= rgb_scoreboard_bottom;
//					end
					// Extra lives scoreboard
						// Life 2
//					else if (yCoord >= EXTRA_LIVES_TOP + 5 && yCoord <= EXTRA_LIVES_BOTTOM - 5 && xCoord >= 50 && xCoord <= 90 && lives > 0) begin
//						set_color <= COLOR_SPACESHIP;
//					end
//						 //Life 3
//					else if (yCoord >= EXTRA_LIVES_TOP + 5 && yCoord <= EXTRA_LIVES_BOTTOM - 5 && xCoord >= 100 && xCoord <= 140 && lives > 1) begin
//						set_color <= COLOR_SPACESHIP;
//					end
				// Life 4 (when cheat code)
//					else if (yCoord >= EXTRA_LIVES_TOP + 5 && yCoord <= EXTRA_LIVES_BOTTOM - 5 && xCoord >= 150 && xCoord <= 190 && lives > 2) begin
//						set_color <= COLOR_SPACESHIP;
//					end
//						// Life 5 (when cheat code)
//					else if (yCoord >= EXTRA_LIVES_TOP + 5 && yCoord <= EXTRA_LIVES_BOTTOM - 5 && xCoord >= 200 && xCoord <= 240 && lives > 3) begin
//						set_color <= COLOR_SPACESHIP;
//					end
//						// Life 6 (when cheat code)
//					else if (yCoord >= EXTRA_LIVES_TOP + 5 && yCoord <= EXTRA_LIVES_BOTTOM - 5 && xCoord >= 250 && xCoord <= 290 && lives > 4) begin
//						set_color <= COLOR_SPACESHIP;
//					end
					// Color in aliens
/*					
					else if (is_alien[0]) begin
						set_color <= rgb_aliens[7:0];
					end
					else if (is_alien[1]) begin
						set_color <= rgb_aliens[15:8];
					end
					else if (is_alien[2]) begin
						set_color <= rgb_aliens[23:16];
					end
					else if (is_alien[3]) begin
						set_color <= rgb_aliens[31:24];
					end
					else if (is_alien[4]) begin
						set_color <= rgb_aliens[39:32];
					end
					else if (is_alien[5]) begin
						set_color <= rgb_aliens[47:40];
					end
					*/
					else if (is_alien[6]) begin
						set_color <= rgb_aliens[55:48];
					end
					else if (is_alien[7]) begin
						set_color <= rgb_aliens[63:56];
					end
					else if (is_alien[8]) begin
						set_color <= rgb_aliens[71:64];
					end
					else if (is_alien[9]) begin
						set_color <= rgb_aliens[79:72];
					end
					else if (is_alien[10]) begin
						set_color <= rgb_aliens[87:80];
					end
					else if (is_alien[11]) begin
						set_color <= rgb_aliens[95:88];
					end
					// Color in alien laser
					/*
					else if (is_alien_laser[0]) begin
						set_color <= rgb_alien_laser[7:0];
					end
					else if (is_alien_laser[1]) begin
						set_color <= rgb_alien_laser[15:8];
					end
					else if (is_alien_laser[2]) begin
						set_color <= rgb_alien_laser[23:16];
					end
					else if (is_alien_laser[3]) begin
						set_color <= rgb_alien_laser[31:24];
					end
					else if (is_alien_laser[4]) begin
						set_color <= rgb_alien_laser[39:32];
					end
					else if (is_alien_laser[5]) begin
						set_color <= rgb_alien_laser[47:40];
					end
					*/
					else if (is_alien_laser[6]) begin
						set_color <= rgb_aliens[55:48];
					end
					else if (is_alien_laser[7]) begin
						set_color <= rgb_alien_laser[63:56];
					end
					else if (is_alien_laser[8]) begin
						set_color <= rgb_alien_laser[71:64];
					end
					else if (is_alien_laser[9]) begin
						set_color <= rgb_alien_laser[79:72];
					end
					else if (is_alien_laser[10]) begin
						set_color <= rgb_alien_laser[87:80];
					end
					else if (is_alien_laser[11]) begin
						set_color <= rgb_alien_laser[95:88];
					end
					else begin
						set_color <= COLOR_SPACE;
					end
				//end 
			end
		end
	end
	
   assign rgb = set_color;

endmodule 
