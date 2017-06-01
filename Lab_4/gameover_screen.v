`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:08:26 06/01/2017 
// Design Name: 
// Module Name:    gameover_screen 
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
module gameover_screen(
	// Inputs
	input wire clk,
	input wire [10:0] xCoord,
	input wire [10:0] yCoord,
	// Outputs
	output wire [7:0] rgb
    );
	 
	// RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	parameter COLOR_SPACESHIP = 8'b00111111;
	parameter COLOR_SPACE = 8'b11010001;
	parameter COLOR_BLACK = 8'b00000000;
	parameter COLOR_WHITE = 8'b11111111;
	parameter COLOR_GREEN = 8'b00111000;
	parameter COLOR_YELLOW = 8'b00111111;

	always @ (posedge clk) begin
		if (yCoord >= 0 && yCoord < 480) begin
			// Temporary (eventually, should say gameover, and display score)
			set_color <= COLOR_WHITE;
		end
	end
	
	assign rgb = set_color;
	
endmodule
