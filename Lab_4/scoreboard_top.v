`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:03:19 06/03/2017 
// Design Name: 
// Module Name:    scoreboard_top 
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
module scoreboard_top(
	// Inputs
	input wire clk,
	input wire [10:0] xCoord,
	input wire [10:0] yCoord,
	// Outputs
	output wire [7:0] rgb,
	output wire is_scoreboard_top
    );
	
	// RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	parameter COLOR_BLACK = 8'b00000000;
	parameter COLOR_GREEN = 8'b00111000;
	parameter COLOR_YELLOW = 8'b00111111;
	parameter COLOR_BLUE = 8'b11000000;
	
	// SCORE (20 < x < 140) (5 < y < 25)
	// HI-SCORE (280 < x < 425) (5 < y < 25)
	always @ (posedge clk) begin
		if (xCoord > 20 && xCoord < 425 && yCoord > 5 && yCoord < 25) begin
			// S
			if (xCoord > 20 && xCoord < 40 && yCoord > 5 && yCoord < 25) begin
				if (
				    (xCoord > 20 && xCoord < 24 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 36 && xCoord < 40 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 24 && xCoord < 36 && yCoord > 10 && yCoord <= 13) ||
					 (xCoord > 20 && xCoord < 24 && yCoord > 15 && yCoord < 18) ||
					 (xCoord > 36 && xCoord < 40 && yCoord > 13 && yCoord < 15) ||
					 (xCoord > 24 && xCoord < 36 && yCoord >= 17 && yCoord < 20) || 
					 (xCoord > 20 && xCoord < 24 && yCoord > 23 && yCoord < 25) ||
					 (xCoord > 36 && xCoord < 40 && yCoord > 23 && yCoord < 25)
					 ) begin
					 set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_BLUE;
				end
			end
			// C
			else if (xCoord > 45 && xCoord < 65 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord > 45 && xCoord < 49 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 61 && xCoord < 65 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 49 && xCoord < 61 && yCoord > 10 && yCoord < 20) ||
					 (xCoord >= 61 && xCoord < 65 && yCoord > 13 && yCoord < 18) ||
					 (xCoord > 45 && xCoord < 49 && yCoord > 23 && yCoord < 25) ||
					 (xCoord > 61 && xCoord < 65 && yCoord > 23 && yCoord < 25)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_BLUE;
				end
			end
			// O
			else if (xCoord > 70 && xCoord < 90 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord > 70 && xCoord < 74 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 86 && xCoord < 90 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 74 && xCoord < 86 && yCoord > 10 && yCoord < 20) ||
					 (xCoord > 70 && xCoord < 74 && yCoord > 23 && yCoord < 25) ||
					 (xCoord > 86 && xCoord < 90 && yCoord > 23 && yCoord < 25) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_BLUE;
				end
			end	
			// R
			else if (xCoord > 95 && xCoord < 115 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord >= 114 && xCoord < 115 && yCoord > 5 && yCoord < 8) ||
					 (xCoord > 99 && xCoord < 111 && yCoord > 10 && yCoord < 15) ||
					 (xCoord >= 114 && xCoord < 115 && yCoord > 15 && yCoord < 20) ||
					 (xCoord > 99 && xCoord <= 104 && yCoord > 18 && yCoord < 25) ||
					 (xCoord > 99 && xCoord < 111 && yCoord > 20 && yCoord < 25)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_BLUE;
				end
			end
			// E
			else if (xCoord > 120 && xCoord < 140 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord > 124 && xCoord < 136 && yCoord > 10 && yCoord <= 12) ||
					 (xCoord >= 136 && xCoord < 140 && yCoord > 10 && yCoord <= 20) ||
					 (xCoord > 124 && xCoord < 136 && yCoord > 18 && yCoord <= 20) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_BLUE;
				end
			end
			// H
			else if (xCoord > 230 && xCoord < 250 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord > 234 && xCoord < 246 && yCoord > 5 && yCoord < 13) ||
					 (xCoord > 234 && xCoord < 246 && yCoord > 18 && yCoord < 25) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// I
			else if (xCoord > 255 && xCoord < 275 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord > 255 && xCoord < 263 && yCoord > 10 && yCoord < 20) ||
					 (xCoord > 267 && xCoord < 275 && yCoord > 10 && yCoord < 20) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// -
			else if (xCoord > 280 && xCoord < 300 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord > 280 && xCoord < 300 && yCoord > 5 && yCoord < 13) ||
					 (xCoord > 280 && xCoord < 300 && yCoord > 18 && yCoord < 25) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// S
			else if (xCoord > 305 && xCoord < 325 && yCoord > 5 && yCoord < 25) begin
				if (
				    (xCoord > 305 && xCoord < 309 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 321 && xCoord < 325 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 309 && xCoord < 321 && yCoord > 10 && yCoord <= 13) ||
					 (xCoord > 305 && xCoord < 309 && yCoord > 15 && yCoord < 18) ||
					 (xCoord > 321 && xCoord < 325 && yCoord > 13 && yCoord < 15) ||
					 (xCoord > 309 && xCoord < 321 && yCoord >= 17 && yCoord < 20) || 
					 (xCoord > 305 && xCoord < 309 && yCoord > 23 && yCoord < 25) ||
					 (xCoord > 321 && xCoord < 325 && yCoord > 23 && yCoord < 25)
					 ) begin
					 set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// C
			else if (xCoord > 330 && xCoord < 350 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord > 330 && xCoord < 334 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 346 && xCoord < 3250 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 334 && xCoord < 346 && yCoord > 10 && yCoord < 20) ||
					 (xCoord >= 346 && xCoord < 350 && yCoord > 13 && yCoord < 18) ||
					 (xCoord > 330 && xCoord < 334 && yCoord > 23 && yCoord < 25) ||
					 (xCoord > 346 && xCoord < 350 && yCoord > 23 && yCoord < 25)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// O
			else if (xCoord > 355 && xCoord < 375 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord > 355 && xCoord < 359 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 371 && xCoord < 375 && yCoord > 5 && yCoord < 7) ||
					 (xCoord > 359 && xCoord < 371 && yCoord > 10 && yCoord < 20) ||
					 (xCoord > 355 && xCoord < 359 && yCoord > 23 && yCoord < 25) ||
					 (xCoord > 371 && xCoord < 375 && yCoord > 23 && yCoord < 25) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end	
			// R
			else if (xCoord > 380 && xCoord < 400 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord > 399 && xCoord < 400 && yCoord > 5 && yCoord < 10) ||
					 (xCoord > 384 && xCoord < 396 && yCoord > 10 && yCoord < 15) ||
					 (xCoord >= 399 && xCoord < 400 && yCoord > 15 && yCoord < 20) ||
					 (xCoord > 384 && xCoord <= 389 && yCoord > 18 && yCoord < 25) ||
					 (xCoord > 384 && xCoord < 396 && yCoord > 20 && yCoord < 25)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// E
			else if (xCoord > 405 && xCoord < 425 && yCoord > 5 && yCoord < 25) begin
				if (
					 (xCoord > 409 && xCoord < 421 && yCoord > 10 && yCoord <= 12) ||
					 (xCoord >= 421 && xCoord < 425 && yCoord > 10 && yCoord <= 20) ||
					 (xCoord > 409 && xCoord < 421 && yCoord > 18 && yCoord <= 20) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			else begin
				set_color <= COLOR_BLACK;
			end
		end
	end

	assign rgb = set_color;
	assign is_scoreboard_top = (xCoord > 20 && xCoord < 425 && yCoord > 5 && yCoord < 25);
endmodule 
