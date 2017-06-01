`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:08:26 06/01/2017 
// Design Name: 
// Module Name:    scoreboard_bottom 
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
module scoreboard_bottom(
	// Inputs
	input wire clk,
	input wire rst,
	input wire [1:0] mode,
	input wire [2:0] lives,
	input wire [10:0] xCoord,
	input wire [10:0] yCoord,
	// Outputs
	output wire [7:0] rgb,
	output wire is_scoreboard_bottom
    );
	 
	// RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	parameter COLOR_SPACESHIP = 8'b01111000;
	parameter COLOR_SPACE = 8'b11010001;
	parameter COLOR_BLACK = 8'b00000000;
	parameter COLOR_WHITE = 8'b11111111;

	// Border (separation of objects) Parameters
	parameter EXTRA_LIVES_TOP = 11'd460;
	parameter EXTRA_LIVES_BOTTOM = 11'd480;

	wire clk_frame = (xCoord == 0 && yCoord == 0);
	always @ (posedge clk) begin
		if (rst) begin
			// TODO
		end
		if (clk_frame && mode == 2) begin
			if (yCoord >= EXTRA_LIVES_TOP && yCoord <= EXTRA_LIVES_BOTTOM) begin
				if ((xCoord > 0 && xCoord < 10) || (xCoord > 640-10 && xCoord < 640)) begin
					set_color <= COLOR_WHITE;
				end
				// Life 2
				else if (xCoord >= 50 && xCoord <= 90 && yCoord >= EXTRA_LIVES_TOP + 5 && yCoord <= EXTRA_LIVES_BOTTOM - 5 && lives > 0) begin
						set_color <= COLOR_SPACESHIP;
				end
				// Life 3
				else if (xCoord >= 100 && xCoord <= 140 && yCoord >= EXTRA_LIVES_TOP + 5 && yCoord <= EXTRA_LIVES_BOTTOM - 5 && lives > 1) begin
						set_color <= COLOR_SPACESHIP;
				end
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
				else begin
					set_color <= COLOR_BLACK;
				end
			end
		end
	end
	
	assign rgb = set_color;
	assign is_scoreboard_bottom = (yCoord >= EXTRA_LIVES_TOP + 5 && yCoord <= EXTRA_LIVES_BOTTOM - 5 &&
											 xCoord >= 50 && xCoord <= 90 && xCoord >= 100 && xCoord <= 140 && xCoord >= 150 && xCoord <= 190);
	
endmodule
