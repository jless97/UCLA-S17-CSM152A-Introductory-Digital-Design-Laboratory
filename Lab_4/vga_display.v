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
	wire [10:0] rgb_start_screen;
	start_screen start_screen_display(
	//Inputs
		.clk(clk),
		.xCoord(xCoord),
		.yCoord(yCoord),
	//Outputs
		.rgb(rgb_start_screen)
		);

	// Instantiate gameover screen display
	wire [10:0] rgb_gameover_screen;
	gameover_screen gameover_screen_display(
	//Inputs
		.clk(clk),
		.xCoord(xCoord),
		.yCoord(yCoord),
	//Outputs
		.rgb(rgb_gameover_screen)
		);
	
	// Instantiate space ship
	wire [7:0] rgb_spaceship;
	wire is_spaceship;
		// Coordinates of alien modules (55 aliens, each having 11 bits)
	wire [604:0] alien_xCoord;
	wire [604:0] alien_yCoord;
		// Coordinates of the flying saucer
	wire [10:0] flying_saucer_xCoord;
	wire [10:0] flying_saucer_yCoord;
		// Coordinates of barrier(pieces)
		
		// Coordinates of spaceship laser
	wire [10:0] spaceship_laser_xCoord;
	wire [10:0] spaceship_laser_yCoord;
	wire [7:0] rgb_spaceship_laser;
	wire is_spaceship_laser;
	wire restart;
	reg restart_temp;
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
//		.alien_xCoord(alien_xCoord),
//		.alien_yCoord(alien_yCoord),
		.flying_saucer_xCoord(flying_saucer_xCoord),
		.flying_saucer_yCoord(flying_saucer_yCoord),
	//Outputs
		.rgb(rgb_spaceship),
		.is_spaceship(is_spaceship),
		.rgb_spaceship_laser(rgb_spaceship_laser),
		.is_spaceship_laser(is_spaceship_laser),
		.current_laser_xCoord(spaceship_laser_xCoord),
		.current_laser_yCoord(spaceship_laser_yCoord)
		);
	
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
		
	// Instantiate barriers
	wire [7:0] rgb_barrier;
	wire is_barrier;
	wire [10:0] damage_x;
	wire [10:0] damage_y;
	wire is_damage;
	assign damage_x = 0;
	assign damage_y = 0;
	assign is_damage = 0;
	set_barriers update_barriers(
	//Inputs
		.clk(clk),
	   .rst(rst),
		.restart(restart),
	   .xCoord(xCoord),
	   .yCoord(yCoord),
	   .damage_x(damage_x),
	   .damage_y(damage_y),
	   .new_damage(new_damage),
	//Outputs
	   .rgb(rgb_barrier),
	   .is_barrier(is_barrier)
		);
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// ALIEN IMPLEMENTATION
		// Instantiate aliens
	wire [54:0] aliens;
	wire [440:0] rgb_aliens;
		// Player Lives
	wire [2:0] lives;
	reg [2:0] lives_temp;
	wire gameover;
	reg gameover_temp;
		// Controls
	wire [54:0] is_alien;
	wire [54:0] is_edge;
	//wire [54:0]is_bottom;
		// Directions
	wire move_left;
	wire move_right;
	wire move_down;
		// Color scheme
	wire color;
	
	// Instantiation of alien top module (not working right now, so just instantiating aliens here)
//	aliens_top create_aliens(
//		.clk(clk),
//		.rst(rst),
//		.mode(mode),
//		.xCoord(xCoord),
//		.yCoord(yCoord),
//		.aliens(aliens),
//		.rgb_aliens(rgb_aliens),
//		.is_alien(is_alien)
//		);

//		// Instantiate bottom scoreboard
//	wire [7:0] rgb_scoreboard_bottom;
//	wire is_scoreboard_bottom;
//	scoreboard_bottom scoreboard_bottom_display(
//		.clk(clk),
//		.rst(rst),
//		.mode(mode),
//		.lives(lives),
//		.xCoord(xCoord),
//		.yCoord(yCoord),
//		.rgb(rgb_scoreboard_bottom),
//		.is_scoreboard_bottom(is_scoreboard_bottom)
//		);

	reg move_left_temp;
	reg move_right_temp;
	reg move_down_temp;
		reg halt_temp;
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
	// Alien 0
	aliens update_alien_0(
	// Inputs
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[0]),
		.initial_xCoord(11'd70),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		//.color(0),
	// Outputs
		.rgb(rgb_aliens[7:0]),
		.is_alien(is_alien[0]),
		//.current_xCoord(alien_xCoord[10:0]),
		//.current_yCoord(alien_yCoord[10:0]),
		.is_edge(is_edge[0])
		//.is_bottom//.is_bottom[0])
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
		.initial_xCoord(11'd120),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		//.color(0),
		.rgb(rgb_aliens[15:8]),
		.is_alien(is_alien[1]),
		//.current_xCoord(alien_xCoord[21:11]),
		//.current_yCoord(alien_yCoord[21:11]),
		.is_edge(is_edge[1])
		//.is_bottom//.is_bottom[1])
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
		.initial_xCoord(11'd170),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(0),
		.rgb(rgb_aliens[23:16]),
		.is_alien(is_alien[2]),
		//.current_xCoord(alien_xCoord[32:22]),
		//.current_yCoord(alien_yCoord[32:22]),
		.is_edge(is_edge[2])
		//.is_bottom//.is_bottom[2])
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
		.initial_xCoord(11'd220),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(0),
		.rgb(rgb_aliens[31:24]),
		.is_alien(is_alien[3]),
		//.current_xCoord(alien_xCoord[43:33]),
		//.current_yCoord(alien_yCoord[43:33]),
		.is_edge(is_edge[3])
		//.is_bottom//.is_bottom[3])
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
		.initial_xCoord(11'd270),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(0),
		.rgb(rgb_aliens[39:32]),
		.is_alien(is_alien[4]),
		//.current_xCoord(alien_xCoord[54:44]),
		//.current_yCoord(alien_yCoord[54:44]),
		.is_edge(is_edge[4])
		//.is_bottom//.is_bottom[4])
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
		.initial_xCoord(11'd320),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(0),
		.rgb(rgb_aliens[47:40]),
		.is_alien(is_alien[5]),
		//.current_xCoord(alien_xCoord[65:55]),
		//.current_yCoord(alien_yCoord[65:55]),
		.is_edge(is_edge[5])
		//.is_bottom//.is_bottom[5])
//		.is_hit(is_hit[5])
		);
		
	// Alien 6
	aliens update_alien_6(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[6]),
		.initial_xCoord(11'd370),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(0),
		.rgb(rgb_aliens[55:48]),
		.is_alien(is_alien[6]),
		//.current_xCoord(alien_xCoord[76:66]),
		//.current_yCoord(alien_yCoord[76:66]),
		.is_edge(is_edge[6])
		//.is_bottom//.is_bottom[6])
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
		.initial_xCoord(11'd420),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(0),
		.rgb(rgb_aliens[63:56]),
		.is_alien(is_alien[7]),
		//.current_xCoord(alien_xCoord[87:77]),
		//.current_yCoord(alien_yCoord[87:77]),
		.is_edge(is_edge[7])
		//.is_bottom//.is_bottom[7])
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
		.initial_xCoord(11'd470),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(0),
		.rgb(rgb_aliens[71:64]),
		.is_alien(is_alien[8]),
		//.current_xCoord(alien_xCoord[98:88]),
		//.current_yCoord(alien_yCoord[98:88]),
		.is_edge(is_edge[8])
		//.is_bottom//.is_bottom[8])
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
		.initial_xCoord(11'd520),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(0),
		.rgb(rgb_aliens[79:72]),
		.is_alien(is_alien[9]),
		//.current_xCoord(alien_xCoord[109:99]),
		//.current_yCoord(alien_yCoord[109:99]),
		.is_edge(is_edge[9])
		//.is_bottom//.is_bottom[9])
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
		.initial_xCoord(11'd570),
		.initial_yCoord(11'd90),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(0),
		.rgb(rgb_aliens[87:80]),
		.is_alien(is_alien[10]),
		//.current_xCoord(alien_xCoord[120:110]),
		//.current_yCoord(alien_yCoord[120:110]),
		.is_edge(is_edge[10])
		//.is_bottom//.is_bottom[10])
//		.is_hit(is_hit[10])
		);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// Second row	
	// Alien 11
	aliens update_alien_11(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[11]),
		.initial_xCoord(11'd70),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[95:88]),
		.is_alien(is_alien[11]),
		//.current_xCoord(alien_xCoord[131:121]),
		//.current_yCoord(alien_yCoord[131:121]),
		.is_edge(is_edge[11])
		//.is_bottom//.is_bottom[11])
//		.is_hit(is_hit[11])
		);
		// Alien 12
	aliens update_alien_12(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[12]),
		.initial_xCoord(11'd120),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[103:96]),
		.is_alien(is_alien[12]),
		//.current_xCoord(alien_xCoord[142:132]),
		//.current_yCoord(alien_yCoord[142:132]),
		.is_edge(is_edge[12])
		//.is_bottom//.is_bottom[12])
//		.is_hit(is_hit[12])
		);
		
	// Alien 13
	aliens update_alien_13(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[13]),
		.initial_xCoord(11'd170),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[111:104]),
		.is_alien(is_alien[13]),
		//.current_xCoord(alien_xCoord[153:143]),
		//.current_yCoord(alien_yCoord[153:143]),
		.is_edge(is_edge[13])
		//.is_bottom//.is_bottom[13])
//		.is_hit(is_hit[13])
		);
		
	// Alien 14
	aliens update_alien_14(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[14]),
		.initial_xCoord(11'd220),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[119:112]),
		.is_alien(is_alien[14]),
		//.current_xCoord(alien_xCoord[164:154]),
		//.current_yCoord(alien_yCoord[164:154]),
		.is_edge(is_edge[14])
		//.is_bottom//.is_bottom[14])
//		.is_hit(is_hit[14])
		);
		
	// Alien 15
	aliens update_alien_15(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[15]),
		.initial_xCoord(11'd270),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[127:120]),
		.is_alien(is_alien[15]),
		//.current_xCoord(alien_xCoord[175:165]),
		//.current_yCoord(alien_yCoord[175:165]),
		.is_edge(is_edge[15])
		//.is_bottom//.is_bottom[15])
//		.is_hit(is_hit[15])
		);
		
	// Alien 16
	aliens update_alien_16(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[16]),
		.initial_xCoord(11'd320),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[135:128]),
		.is_alien(is_alien[16]),
		//.current_xCoord(alien_xCoord[186:176]),
		//.current_yCoord(alien_yCoord[186:176]),
		.is_edge(is_edge[16])
		//.is_bottom//.is_bottom[16])
//		.is_hit(is_hit[16])
		);
		// Alien 17
	aliens update_alien_17(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[17]),
		.initial_xCoord(11'd370),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[143:136]),
		.is_alien(is_alien[17]),
		//.current_xCoord(alien_xCoord[197:187]),
		//.current_yCoord(alien_yCoord[197:187]),
		.is_edge(is_edge[17])
		//.is_bottom//.is_bottom[17])
//		.is_hit(is_hit[17])
		);
		
	// Alien 18
	aliens update_alien_18(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[18]),
		.initial_xCoord(11'd420),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[151:144]),
		.is_alien(is_alien[18]),
		//.current_xCoord(alien_xCoord[208:198]),
		//.current_yCoord(alien_yCoord[208:198]),
		.is_edge(is_edge[18])
		//.is_bottom//.is_bottom[18])
//		.is_hit(is_hit[18])
		);
		
	// Alien 19
	aliens update_alien_19(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[19]),
		.initial_xCoord(11'd470),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[159:152]),
		.is_alien(is_alien[19]),
		//.current_xCoord(alien_xCoord[219:209]),
		//.current_yCoord(alien_yCoord[219:209]),
		.is_edge(is_edge[19])
		//.is_bottom//.is_bottom[19])
//		.is_hit(is_hit[19])
		);
		
	// Alien 20
	aliens update_alien_20(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[20]),
		.initial_xCoord(11'd520),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[167:160]),
		.is_alien(is_alien[20]),
		//.current_xCoord(alien_xCoord[230:220]),
		//.current_yCoord(alien_yCoord[230:220]),
		.is_edge(is_edge[20])
		//.is_bottom//.is_bottom[20])
//		.is_hit(is_hit[20])
		);
		
	// Alien 21
	aliens update_alien_21(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[21]),
		.initial_xCoord(11'd570),
		.initial_yCoord(11'd120),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(1),
		.rgb(rgb_aliens[175:168]),
		.is_alien(is_alien[21]),
		//.current_xCoord(alien_xCoord[241:231]),
		//.current_yCoord(alien_yCoord[241:231]),
		.is_edge(is_edge[21])
		//.is_bottom//.is_bottom[21])
//		.is_hit(is_hit[21])
		);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	

// Third row
	// Alien 22
	aliens update_alien_22(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[22]),
		.initial_xCoord(11'd70),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[183:176]),
		.is_alien(is_alien[22]),
		//.current_xCoord(alien_xCoord[252:242]),
		//.current_yCoord(alien_yCoord[252:242]),
		.is_edge(is_edge[22])
		//.is_bottom//.is_bottom[22])
//		.is_hit(is_hit[22])
		);
	// Alien 23
	aliens update_alien_23(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[23]),
		.initial_xCoord(11'd120),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[191:184]),
		.is_alien(is_alien[23]),
		//.current_xCoord(alien_xCoord[263:253]),
		//.current_yCoord(alien_yCoord[263:253]),
		.is_edge(is_edge[23])
		//.is_bottom//.is_bottom[23])
//		.is_hit(is_hit[23])
		);
		
	// Alien 24
	aliens update_alien_24(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[24]),
		.initial_xCoord(11'd170),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[199:192]),
		.is_alien(is_alien[24]),
		//.current_xCoord(alien_xCoord[274:264]),
		//.current_yCoord(alien_yCoord[274:264]),
		.is_edge(is_edge[24])
		//.is_bottom//.is_bottom[24])
//		.is_hit(is_hit[24])
		);
		
	// Alien 25
	aliens update_alien_25(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[25]),
		.initial_xCoord(11'd220),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[207:200]),
		.is_alien(is_alien[25]),
		//.current_xCoord(alien_xCoord[285:275]),
		//.current_yCoord(alien_yCoord[285:275]),
		.is_edge(is_edge[25])
		//.is_bottom//.is_bottom[25])
//		.is_hit(is_hit[25])
		);
		
	// Alien 26
	aliens update_alien_26(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[26]),
		.initial_xCoord(11'd270),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[215:208]),
		.is_alien(is_alien[26]),
		//.current_xCoord(alien_xCoord[296:286]),
		//.current_yCoord(alien_yCoord[296:286]),
		.is_edge(is_edge[26])
		//.is_bottom//.is_bottom[26])
//		.is_hit(is_hit[26])
		);
		
	// Alien 27
	aliens update_alien_27(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[27]),
		.initial_xCoord(11'd320),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[223:216]),
		.is_alien(is_alien[27]),
		//.current_xCoord(alien_xCoord[307:297]),
		//.current_yCoord(alien_yCoord[307:297]),
		.is_edge(is_edge[27])
		//.is_bottom//.is_bottom[27])
//		.is_hit(is_hit[27])
		);
		// Alien 28
	aliens update_alien_28(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[28]),
		.initial_xCoord(11'd370),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[231:224]),
		.is_alien(is_alien[28]),
		//.current_xCoord(alien_xCoord[318:308]),
		//.current_yCoord(alien_yCoord[318:308]),
		.is_edge(is_edge[28])
		//.is_bottom//.is_bottom[28])
//		.is_hit(is_hit[28])
		);
		
	// Alien 29
	aliens update_alien_29(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[29]),
		.initial_xCoord(11'd420),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[239:232]),
		.is_alien(is_alien[29]),
		//.current_xCoord(alien_xCoord[329:319]),
		//.current_yCoord(alien_yCoord[329:319]),
		.is_edge(is_edge[29])
		//.is_bottom//.is_bottom[29])
//		.is_hit(is_hit[29])
		);
		
	// Alien 30
	aliens update_alien_30(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[30]),
		.initial_xCoord(11'd470),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[247:240]),
		.is_alien(is_alien[30]),
		//.current_xCoord(alien_xCoord[340:330]),
		//.current_yCoord(alien_yCoord[340:330]),
		.is_edge(is_edge[30])
		//.is_bottom//.is_bottom[30])
//		.is_hit(is_hit[30])
		);
		
	// Alien 31
	aliens update_alien_31(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[31]),
		.initial_xCoord(11'd520),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[255:248]),
		.is_alien(is_alien[31]),
		//.current_xCoord(alien_xCoord[351:341]),
		//.current_yCoord(alien_yCoord[351:341]),
		.is_edge(is_edge[31])
		//.is_bottom//.is_bottom[31])
//		.is_hit(is_hit[31])
		);
		
	// Alien 32
	aliens update_alien_32(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[32]),
		.initial_xCoord(11'd570),
		.initial_yCoord(11'd150),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(2),
		.rgb(rgb_aliens[263:256]),
		.is_alien(is_alien[32]),
		//.current_xCoord(alien_xCoord[362:352]),
		//.current_yCoord(alien_yCoord[362:352]),
		.is_edge(is_edge[32])
		//.is_bottom//.is_bottom[32])
//		.is_hit(is_hit[32])
		);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////	

// Fourth row
	// Alien 33
	aliens update_alien_33(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[33]),
		.initial_xCoord(11'd70),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[271:264]),
		.is_alien(is_alien[33]),
		//.current_xCoord(alien_xCoord[373:363]),
		//.current_yCoord(alien_yCoord[373:363]),
		.is_edge(is_edge[33])
		//.is_bottom//.is_bottom[33])
//		.is_hit(is_hit[33])
		);
		
	// Alien 34
	aliens update_alien_34(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[34]),
		.initial_xCoord(11'd120),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[279:272]),
		.is_alien(is_alien[34]),
		//.current_xCoord(alien_xCoord[384:374]),
		//.current_yCoord(alien_yCoord[384:374]),
		.is_edge(is_edge[34])
		//.is_bottom//.is_bottom[34])
//		.is_hit(is_hit[34])
		);
		
	// Alien 35
	aliens update_alien_35(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[35]),
		.initial_xCoord(11'd170),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[287:280]),
		.is_alien(is_alien[35]),
		//.current_xCoord(alien_xCoord[395:385]),
		//.current_yCoord(alien_yCoord[395:385]),
		.is_edge(is_edge[35])
		//.is_bottom//.is_bottom[35])
//		.is_hit(is_hit[35])
		);
		
	// Alien 36
	aliens update_alien_36(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[36]),
		.initial_xCoord(11'd220),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[295:288]),
		.is_alien(is_alien[36]),
		//.current_xCoord(alien_xCoord[406:396]),
		//.current_yCoord(alien_yCoord[406:396]),
		.is_edge(is_edge[36])
		//.is_bottom//.is_bottom[36])
//		.is_hit(is_hit[36])
		);
		
	// Alien 37
	aliens update_alien_37(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[37]),
		.initial_xCoord(11'd270),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[303:296]),
		.is_alien(is_alien[37]),
		//.current_xCoord(alien_xCoord[417:407]),
		//.current_yCoord(alien_yCoord[417:407]),
		.is_edge(is_edge[37])
		//.is_bottom//.is_bottom[37])
//		.is_hit(is_hit[37])
		);
		
	// Alien 38
	aliens update_alien_38(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[38]),
		.initial_xCoord(11'd320),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[311:304]),
		.is_alien(is_alien[38]),
		//.current_xCoord(alien_xCoord[428:418]),
		//.current_yCoord(alien_yCoord[428:418]),
		.is_edge(is_edge[38])
		//.is_bottom//.is_bottom[38])
//		.is_hit(is_hit[38])
		);
		
	// Alien 39
	aliens update_alien_39(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[39]),
		.initial_xCoord(11'd370),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[319:312]),
		.is_alien(is_alien[39]),
		//.current_xCoord(alien_xCoord[439:429]),
		//.current_yCoord(alien_yCoord[439:429]),
		.is_edge(is_edge[39])
//		//.is_bottom//.is_bottom[39])
//		.is_hit(is_hit[39])
		);
		
	// Alien 40
	aliens update_alien_40(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[40]),
		.initial_xCoord(11'd420),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[327:320]),
		.is_alien(is_alien[40]),
		//.current_xCoord(alien_xCoord[450:440]),
		//.current_yCoord(alien_yCoord[450:440]),
		.is_edge(is_edge[40])
		//.is_bottom//.is_bottom[40])
//		.is_hit(is_hit[40])
		);
		
	// Alien 41
	aliens update_alien_41(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[41]),
		.initial_xCoord(11'd470),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[335:328]),
		.is_alien(is_alien[41]),
		//.current_xCoord(alien_xCoord[461:451]),
		//.current_yCoord(alien_yCoord[461:451]),
		.is_edge(is_edge[41])
		//.is_bottom//.is_bottom[41])
//		.is_hit(is_hit[41])
		);
		
	// Alien 42
	aliens update_alien_42(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[42]),
		.initial_xCoord(11'd520),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[343:336]),
		.is_alien(is_alien[42]),
		//.current_xCoord(alien_xCoord[472:462]),
		//.current_yCoord(alien_yCoord[472:462]),
		.is_edge(is_edge[42])
		//.is_bottom//.is_bottom[42])
//		.is_hit(is_hit[42])
		);
		
	// Alien 43
	aliens update_alien_43(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[43]),
		.initial_xCoord(11'd570),
		.initial_yCoord(11'd180),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(3),
		.rgb(rgb_aliens[351:344]),
		.is_alien(is_alien[43]),
		//.current_xCoord(alien_xCoord[483:473]),
		//.current_yCoord(alien_yCoord[483:473]),
		.is_edge(is_edge[43])
		//.is_bottom//.is_bottom[43])
//		.is_hit(is_hit[43])
		);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	

// Fifth row
	// Alien 44
	aliens update_alien_44(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[44]),
		.initial_xCoord(11'd70),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[359:352]),
		.is_alien(is_alien[44]),
		//.current_xCoord(alien_xCoord[494:484]),
		//.current_yCoord(alien_yCoord[494:484]),
		.is_edge(is_edge[44])
		//.is_bottom//.is_bottom[44])
//		.is_hit(is_hit[44])
		);
		
	// Alien 45
	aliens update_alien_45(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[45]),
		.initial_xCoord(11'd120),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[367:360]),
		.is_alien(is_alien[45]),
		//.current_xCoord(alien_xCoord[505:495]),
		//.current_yCoord(alien_yCoord[505:495]),
		.is_edge(is_edge[45])
		//.is_bottom//.is_bottom[45])
//		.is_hit(is_hit[45])
		);
		
	// Alien 46
	aliens update_alien_46(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[46]),
		.initial_xCoord(11'd170),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[375:368]),
		.is_alien(is_alien[46]),
		//.current_xCoord(alien_xCoord[516:506]),
		//.current_yCoord(alien_yCoord[516:506]),
		.is_edge(is_edge[46])
		//.is_bottom//.is_bottom[46])
//		.is_hit(is_hit[46])
		);
		
	// Alien 47
	aliens update_alien_47(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[47]),
		.initial_xCoord(11'd220),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[383:376]),
		.is_alien(is_alien[47]),
		//.current_xCoord(alien_xCoord[527:517]),
		//.current_yCoord(alien_yCoord[527:517]),
		.is_edge(is_edge[47])
		//.is_bottom//.is_bottom[47])
//		.is_hit(is_hit[47])
		);
		
	// Alien 48
	aliens update_alien_48(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[48]),
		.initial_xCoord(11'd270),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[391:384]),
		.is_alien(is_alien[48]),
		//.current_xCoord(alien_xCoord[538:528]),
		//.current_yCoord(alien_yCoord[538:528]),
		.is_edge(is_edge[48])
		//.is_bottom//.is_bottom[48])
//		.is_hit(is_hit[48])
		);
		
	// Alien 49
	aliens update_alien_49(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[49]),
		.initial_xCoord(11'd320),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[399:392]),
		.is_alien(is_alien[49]),
		//.current_xCoord(alien_xCoord[549:539]),
		//.current_yCoord(alien_yCoord[549:539]),
		//.is_bottom//.is_bottom[49])
		.is_edge(is_edge[49])
//		.is_hit(is_hit[49])
		);
	// Alien 50
	aliens update_alien_50(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[50]),
		.initial_xCoord(11'd370),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[407:400]),
		.is_alien(is_alien[50]),
		//.current_xCoord(alien_xCoord[560:550]),
		//.current_yCoord(alien_yCoord[560:550]),
		.is_edge(is_edge[50])
		//.is_bottom//.is_bottom[50])
//		.is_hit(is_hit[50])
		);
		
	// Alien 51
	aliens update_alien_51(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[51]),
		.initial_xCoord(11'd420),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[415:408]),
		.is_alien(is_alien[51]),
		//.current_xCoord(alien_xCoord[571:561]),
		//.current_yCoord(alien_yCoord[571:561]),
		.is_edge(is_edge[51])
		//.is_bottom//.is_bottom[51])
//		.is_hit(is_hit[51])
		);
		
	// Alien 52
	aliens update_alien_52(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[52]),
		.initial_xCoord(11'd470),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[423:416]),
		.is_alien(is_alien[52]),
		//.current_xCoord(alien_xCoord[582:572]),
		//.current_yCoord(alien_yCoord[582:572]),
		.is_edge(is_edge[52])
		//.is_bottom//.is_bottom[52])
//		.is_hit(is_hit[52])
		);
		
	// Alien 53
	aliens update_alien_53(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[53]),
		.initial_xCoord(11'd520),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[431:424]),
		.is_alien(is_alien[53]),
		//.current_xCoord(alien_xCoord[593:583]),
		//.current_yCoord(alien_yCoord[593:583]),
		.is_edge(is_edge[53])
		//.is_bottom//.is_bottom[53])
//		.is_hit(is_hit[53])
		);
		
	// Alien 54
	aliens update_alien_54(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[54]),
		.initial_xCoord(11'd570),
//		.initial_yCoord(11'd208),
		.initial_yCoord(11'd210),
		//.spaceship_laser_xCoord//.spaceship_laser_xCoord),
		//.spaceship_laser_yCoord//.spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
//		.color(4),
		.rgb(rgb_aliens[439:432]),
		.is_alien(is_alien[54]),
		//.current_xCoord(alien_xCoord[604:594]),
		//.current_yCoord(alien_yCoord[604:594]),
		.is_edge(is_edge[54])
		//.is_bottom//.is_bottom[54])
//		.is_hit(is_hit[54])
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
				set_color <= rgb_start_screen;
			end
			// Switch screen
			// Game mode
			else if (mode == 2) begin
				if (gameover) begin
					set_color <= rgb_gameover_screen;
				end
				else begin
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
					else if (yCoord == EXTRA_LIVES_TOP || yCoord == EXTRA_LIVES_BOTTOM) begin
						set_color <= COLOR_GREEN;
					end
					// Extra lives scoreboard
//					else if (is_scoreboard_bottom) begin
//						set_color <= rgb_scoreboard_bottom;
//					end
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
					else if (is_alien[12]) begin
						set_color <= rgb_aliens[103:96];
					end
					else if (is_alien[13]) begin
						set_color <= rgb_aliens[111:104];
					end
					else if (is_alien[14]) begin
						set_color <= rgb_aliens[119:112];
					end
					else if (is_alien[15]) begin
						set_color <= rgb_aliens[127:120];
					end
					else if (is_alien[16]) begin
						set_color <= rgb_aliens[135:128];
					end
					else if (is_alien[17]) begin
						set_color <= rgb_aliens[143:136];
					end
					else if (is_alien[18]) begin
						set_color <= rgb_aliens[151:144];
					end
					else if (is_alien[19]) begin
						set_color <= rgb_aliens[159:152];
					end
					else if (is_alien[20]) begin
						set_color <= rgb_aliens[167:160];
					end
					else if (is_alien[21]) begin
						set_color <= rgb_aliens[175:168];
					end
					else if (is_alien[22]) begin
						set_color <= rgb_aliens[183:176];
					end
					else if (is_alien[23]) begin
						set_color <= rgb_aliens[191:184];
					end
					else if (is_alien[24]) begin
						set_color <= rgb_aliens[199:192];
					end
					else if (is_alien[25]) begin
						set_color <= rgb_aliens[207:200];
					end
					else if (is_alien[26]) begin
						set_color <= rgb_aliens[215:208];
					end
					else if (is_alien[27]) begin
						set_color <= rgb_aliens[223:216];
					end
					else if (is_alien[28]) begin
						set_color <= rgb_aliens[231:224];
					end
					else if (is_alien[29]) begin
						set_color <= rgb_aliens[239:232];
					end
					else if (is_alien[30]) begin
						set_color <= rgb_aliens[247:240];
					end
					else if (is_alien[31]) begin
						set_color <= rgb_aliens[255:248];
					end
					else if (is_alien[32]) begin
						set_color <= rgb_aliens[263:256];
					end
					else if (is_alien[33]) begin
						set_color <= rgb_aliens[271:264];
					end
					else if (is_alien[34]) begin
						set_color <= rgb_aliens[279:272];
					end
					else if (is_alien[35]) begin
						set_color <= rgb_aliens[287:280];
					end
					else if (is_alien[36]) begin
						set_color <= rgb_aliens[295:288];
					end
					else if (is_alien[37]) begin
						set_color <= rgb_aliens[303:296];
					end
					else if (is_alien[38]) begin
						set_color <= rgb_aliens[311:304];
					end
					else if (is_alien[39]) begin
						set_color <= rgb_aliens[319:312];
					end
					else if (is_alien[40]) begin
						set_color <= rgb_aliens[327:320];
					end
					else if (is_alien[41]) begin
						set_color <= rgb_aliens[335:328];
					end
					else if (is_alien[42]) begin
						set_color <= rgb_aliens[343:336];
					end
					else if (is_alien[43]) begin
						set_color <= rgb_aliens[351:344];
					end
					else if (is_alien[44]) begin
						set_color <= rgb_aliens[359:352];
					end
					else if (is_alien[45]) begin
						set_color <= rgb_aliens[367:360];
					end
					else if (is_alien[46]) begin
						set_color <= rgb_aliens[375:368];
					end
					else if (is_alien[47]) begin
						set_color <= rgb_aliens[383:376];
					end
					else if (is_alien[48]) begin
						set_color <= rgb_aliens[391:384];
					end
					else if (is_alien[49]) begin
						set_color <= rgb_aliens[399:392];
					end
					else if (is_alien[50]) begin
						set_color <= rgb_aliens[407:400];
					end
					else if (is_alien[51]) begin
						set_color <= rgb_aliens[415:408];
					end
					else if (is_alien[52]) begin
						set_color <= rgb_aliens[423:416];
					end
					else if (is_alien[53]) begin
						set_color <= rgb_aliens[431:424];
					end
					else if (is_alien[54]) begin
						set_color <= rgb_aliens[439:432];
					end				
					else begin
						set_color <= COLOR_SPACE;
					end
				end 
			end
		end
	end
	
   assign rgb = set_color;

endmodule 
