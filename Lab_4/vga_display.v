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
   parameter LEFT_EDGE = 10'd0;
   parameter RIGHT_EDGE = 10'd640;
   parameter TOP_EDGE = 10'd0;
   parameter BOTTOM_EDGE = 10'd480;

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
   // RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	parameter COLOR_SPACESHIP = 8'b01111000;
	parameter COLOR_ALIEN = 8'b10101010;
	parameter COLOR_SPACE = 8'b00000000;
	parameter COLOR_BLACK = 8'b00000000;

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// Border (separation of objects) Parameters
	parameter BARRIER_TOP = 10'd340;
	parameter BARRIER_BOTTOM = 10'd397;

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// laser Parameters
	parameter LASER_HEIGHT = 10'd10;
	parameter LASER_LENGTH = 10'd3;

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////
	// Screen display mode
	// Mode 0: Black screen
	// Mode 1: Game screen	
	reg mode;
	initial begin
		mode = 0;
	end
	always @ (posedge button_display or posedge rst) begin
		if (rst) begin
			mode <= 0;
		end
		else if (mode == 0) begin
			mode <= 1;
		end
		else if (mode == 1) begin
			mode <= 0;
		end
	end

	///////////////////////////////////////////////////////
	///////////////////////////////////////////////////////	
	// Instantiate space ship
	wire [7:0] rgb_spaceship;
	wire is_spaceship;
	// Coordinates of alien modules
	wire [29:0] alien_xCoord;
	wire [29:0] alien_yCoord;
		
	// Coordinates of spaceship laser
	wire [9:0] spaceship_laser_xCoord;
	wire [9:0] spaceship_laser_yCoord;
	wire [29:0] alien_laser_xCoord;
	wire [29:0] alien_laser_yCoord;
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
		.barrSpaceshipLaserHit(barrSpaceshipLaserHit),
	//Outputs
		.rgb(rgb_spaceship),
		.is_spaceship(is_spaceship),
		.rgb_spaceship_laser(rgb_spaceship_laser),
		.is_spaceship_laser(is_spaceship_laser),
		.current_laser_xCoord(spaceship_laser_xCoord),
		.current_laser_yCoord(spaceship_laser_yCoord)
		);
	
	// Instantiate barriers
	wire [7:0] rgb_barrier;
	wire is_barrier;
	wire [11:0] barrAlienLaserHit;
	set_barriers update_barriers(
	//Inputs
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.restart(restart),
		.xCoord(xCoord),
		.yCoord(yCoord),
	//Laser coordinates for interaction
		.spaceshipLaserXcoord(spaceship_laser_xCoord),
		.spaceshipLaserYcoord(spaceship_laser_yCoord),
		.alienLaserXcoord(alien_laser_xCoord),
		.alienLaserYcoord(alien_laser_yCoord),
	//Outputs
		.rgb(rgb_barrier),
		.is_barrier(is_barrier),
		.spaceshipLaserHit(barrSpaceshipLaserHit),
		.alienLaserHit(barrAlienLaserHit)
		);
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// ALIEN IMPLEMENTATION
	// Instantiate aliens

	wire [2:0] aliens;
	wire [23:0] rgb_aliens;
	wire [23:0] rgb_alien_laser;
	// Player Lives
	wire [2:0] lives;
	reg [2:0] lives_temp;
	wire gameover;
	reg gameover_temp;
	// Controls
	wire [2:0] is_alien;
	wire [2:0] is_alien_laser;
	// Timer before certain alien can shoot
	wire [35:0] shoot_timer;
	assign shoot_timer[11:0] = 12'd986;
	assign shoot_timer[23:12] = 12'd1532;
	assign shoot_timer[35:24] = 12'd668;
	wire [2:0] is_edge;
	// Directions
	wire move_left;
	wire move_right;
	wire move_down;

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

	// Alien 0
	aliens update_alien_0(
	// Inputs
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[0]),
		.initial_xCoord(10'd195),
		.initial_yCoord(10'd150),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[11:0]),
		.barrAlienLaserHit(barrAlienLaserHit[0]),
	// Outputs
		.rgb(rgb_aliens[7:0]),
		.is_alien(is_alien[0]),
		.rgb_alien_laser(rgb_alien_laser[7:0]),
		.is_alien_laser(is_alien_laser[0]),
		.current_laser_xCoord(alien_laser_xCoord[9:0]),
		.current_laser_yCoord(alien_laser_yCoord[9:0]),
		.current_xCoord(alien_xCoord[9:0]),
		.current_yCoord(alien_yCoord[9:0]),
		.is_edge(is_edge[0])
		);

	// Alien 1
	aliens update_alien_1(
	//Inputs
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[1]),
		.initial_xCoord(10'd245),
		.initial_yCoord(10'd150),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[23:12]),
		.barrAlienLaserHit(barrAlienLaserHit[1]),
	//Outputs
		.rgb(rgb_aliens[15:8]),
		.is_alien(is_alien[1]),
		.rgb_alien_laser(rgb_alien_laser[15:8]),
		.is_alien_laser(is_alien_laser[1]),
		.current_laser_xCoord(alien_laser_xCoord[19:10]),
		.current_laser_yCoord(alien_laser_yCoord[19:10]),
		.current_xCoord(alien_xCoord[19:10]),
		.current_yCoord(alien_yCoord[19:10]),
		.is_edge(is_edge[1])
		);

		// Alien 2
	aliens update_alien_2(
	//Inputs
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[2]),
		.initial_xCoord(10'd295),
		.initial_yCoord(10'd150),
		.spaceship_laser_xCoord(spaceship_laser_xCoord),
		.spaceship_laser_yCoord(spaceship_laser_yCoord),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.shoot_timer(shoot_timer[35:24]),
		.barrAlienLaserHit(barrAlienLaserHit[2]),
	//Outputs
		.rgb(rgb_aliens[23:16]),
		.is_alien(is_alien[2]),
		.rgb_alien_laser(rgb_alien_laser[23:16]),
		.is_alien_laser(is_alien_laser[2]),
		.current_laser_xCoord(alien_laser_xCoord[29:20]),
		.current_laser_yCoord(alien_laser_yCoord[29:20]),
		.current_xCoord(alien_xCoord[29:20]),
		.current_yCoord(alien_yCoord[29:20]),
		.is_edge(is_edge[2])
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
			// Switch screen
			// Game mode
			else if (mode == 1) begin
				// Color in barriers
				if(is_barrier) begin
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
				else if (is_alien[0]) begin
					set_color <= rgb_aliens[7:0];
				end
				else if (is_alien[1]) begin
					set_color <= rgb_aliens[15:8];
				end
				else if (is_alien[2]) begin
					set_color <= rgb_aliens[23:16];
				end
				// Color in alien laser
			
				else if (is_alien_laser[0]) begin
					set_color <= rgb_alien_laser[7:0];
				end
				else if (is_alien_laser[1]) begin
					set_color <= rgb_alien_laser[15:8];
				end
				else if (is_alien_laser[2]) begin
					set_color <= rgb_alien_laser[23:16];
				end
				else begin
					set_color <= COLOR_SPACE;
				end
			end
		end
	end
	
   assign rgb = set_color;

endmodule 
