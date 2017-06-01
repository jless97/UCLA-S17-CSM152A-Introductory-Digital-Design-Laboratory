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
			mode_temp = 0;
		end
		else begin
			if (mode == 2) begin
				mode_temp = 0;
			end
			else begin
				mode_temp = mode + 1;
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
		.mode(mode),
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
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.rgb(rgb_flying_saucer),
		.is_flying_saucer(is_flying_saucer)
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
		.clk(clk),
	   .rst(rst),
	   .xCoord(xCoord),
	   .yCoord(yCoord),
	   .damage_x(damage_x),
	   .damage_y(damage_y),
	   .new_damage(new_damage),
	   .rgb(rgb_barrier),
	   .is_barrier(is_barrier)
		);
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// ALIEN IMPLEMENTATION
		// Instantiate aliens
	wire [4:0] aliens;
	wire [40:0] rgb_aliens;
	wire [4:0] is_alien;
	wire [4:0] is_edge;
	wire move_left;
	wire move_right;
	wire move_down;
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

	reg move_left_temp;
	reg move_right_temp;
	reg move_down_temp;
		reg halt_temp;
	initial begin
		move_left_temp = 0;
		move_right_temp = 1;
		move_down_temp = 0;
		halt_temp = 0;
	end

	always @ (posedge clk) begin
		if (rst || button_display) begin
			move_left_temp <= 1;
			move_right_temp <= 0;
			move_down_temp <= 0;
		end
		else begin
			if (is_edge) begin
				move_down_temp <= 1;
				if (move_left) begin
					move_right_temp <= 1;
					move_left_temp <= 0;
				end
				if (move_right) begin
					move_left_temp <= 1;
					move_right_temp <= 0;
				end
			end
			else begin
				move_left_temp <= move_left;
				move_right_temp <= move_right;
				move_down_temp <= 0;
			end
		end
	end
	
	assign move_left = move_left_temp;
	assign move_right = move_right_temp;
	assign move_down = move_down_temp;
 
	// Alien 0
	aliens update_alien_0(
		.clk(clk),
		.rst(rst),
		.mode(mode),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.aliens(aliens[0]),
		.initial_xCoord(11'd220),
		.initial_yCoord(11'd88),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.rgb(rgb_aliens[7:0]),
		.is_alien(is_alien[0]),
		.is_edge(is_edge[0])
//		.is_bottom(is_bottom[0]),
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
		.initial_xCoord(11'd270),
		.initial_yCoord(11'd88),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.rgb(rgb_aliens[15:8]),
		.is_alien(is_alien[1]),
		.is_edge(is_edge[1])
//		.is_bottom(is_bottom[1]),
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
		.initial_xCoord(11'd320),
		.initial_yCoord(11'd88),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.rgb(rgb_aliens[23:16]),
		.is_alien(is_alien[2]),
		.is_edge(is_edge[2])
//		.is_bottom(is_bottom[2]),
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
		.initial_xCoord(11'd370),
		.initial_yCoord(11'd88),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.rgb(rgb_aliens[31:24]),
		.is_alien(is_alien[3]),
		.is_edge(is_edge[3])
//		.is_bottom(is_bottom[3]),
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
		.initial_xCoord(11'd420),
		.initial_yCoord(11'd88),
		.move_left(move_left),
		.move_right(move_right),
		.move_down(move_down),
		.rgb(rgb_aliens[39:32]),
		.is_alien(is_alien[4]),
		.is_edge(is_edge[4])
//		.is_bottom(is_bottom[4]),
//		.is_hit(is_hit[4])
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
				// Color in aliens
//				else if (is_alien) begin
//					set_color <= rgb_aliens;
//				end
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
				else begin
					set_color <= COLOR_SPACE;
				end
			end 
			else if (mode == 3) begin
				set_color <= COLOR_YELLOW;
			end
		end
	end
	
   assign rgb = set_color;

endmodule 
