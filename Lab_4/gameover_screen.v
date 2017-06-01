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
			else begin
				set_color <= COLOR_BLACK;
			end
		end
	end
	
	assign rgb = set_color;
	
endmodule
