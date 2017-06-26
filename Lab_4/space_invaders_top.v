`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:27:40 05/30/2017 
// Design Name: 
// Module Name:    space_invaders_top 
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
module space_invaders_top(
	// Inputs
	input wire clk,
	// Buttons
	input wire button_left,
	input wire button_right,
	input wire button_shoot,
	input wire button_display,
	// Outputs
	output [7:0] rgb,
	output wire hsync,
	output wire vsync
    );

	// Wires for horizontal and vertical counters
	wire [9:0] xCoord;
	wire [9:0] yCoord;
	
	// Wires for clocks
	wire dclk;
	
	// Wires for signals
	wire button_left_db;
	wire button_right_db;
	wire button_shoot_db;
	wire button_display_db;
	
	// Left button
	debouncer button_left_func(
		.clk(clk),
		.button(button_left),
		.bounce_state(button_left_db)
	);
	// Right button
	debouncer button_right_func(
		.clk(clk),
		.button(button_right),
		.bounce_state(button_right_db)
	);
		// Center button
	debouncer button_shoot_func(
		.clk(clk),
		.button(button_shoot),
		.bounce_state(button_shoot_db)
	);
		// Change display button
	debouncer_display_button button_display_func(
		.clk(clk),
		.button(button_display),
		.bounce_state(button_display_db)
	);
	
	// Generate display clock and in-game clock
	clk_div clk_div(
		.clk(clk),
		.rst(button_display_db),
		.dclk(dclk)
	);
	
	// VGA controller
	vga_controller controller(
		.clk(dclk),
		.rst(button_display_db),
		.hsync(hsync),
		.vsync(vsync),
		.xCoord(xCoord),
		.yCoord(yCoord)
	);
	
	// VGA display
	vga_display display(
		.clk(clk),
		.button_left(button_left_db),
		.button_right(button_right_db),
		.button_shoot(button_shoot_db),
		.button_display(button_display_db),
		.xCoord(xCoord),
		.yCoord(yCoord),
		.rgb(rgb)
	);

endmodule
