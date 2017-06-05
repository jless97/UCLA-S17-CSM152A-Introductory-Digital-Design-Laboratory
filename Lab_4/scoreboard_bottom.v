`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:01:54 06/03/2017 
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
	input wire [10:0] xCoord,
	input wire [10:0] yCoord,
	// Outputs
	output wire [7:0] rgb,
	output wire is_scoreboard_bottom
    );
	
	// RGB Parameters [ BLUE | GREEN | RED ]
	reg [7:0] set_color;
	parameter COLOR_BLACK = 8'b00000000;
	parameter COLOR_WHITE = 8'b11111111;
	
	// CREDIT (370 < x < 590) (455 < y < 475)
	always @ (posedge clk) begin
		if (xCoord > 370 && xCoord < 600 && yCoord > 450 && yCoord < 470) begin
			// C
			if (xCoord > 370 && xCoord < 390 && yCoord > 450 && yCoord < 470) begin
				if (
					 (xCoord > 370 && xCoord < 374 && yCoord > 450 && yCoord < 452) ||
					 (xCoord > 386 && xCoord < 390 && yCoord > 450 && yCoord < 452) ||
					 (xCoord > 374 && xCoord < 386 && yCoord > 455 && yCoord < 465) ||
					 (xCoord >= 386 && xCoord < 390 && yCoord > 458 && yCoord < 463) ||
					 (xCoord > 370 && xCoord < 374 && yCoord > 468 && yCoord < 470) ||
					 (xCoord > 386 && xCoord < 390 && yCoord > 468 && yCoord < 470) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// R
			else if (xCoord > 395 && xCoord < 415 && yCoord > 455 && yCoord < 475) begin
				if (
					 (xCoord >= 414 && xCoord < 415 && yCoord > 455 && yCoord < 458) ||
					 (xCoord > 399 && xCoord < 411 && yCoord > 460 && yCoord < 465) ||
					 (xCoord >= 414 && xCoord < 415 && yCoord > 465 && yCoord < 470) ||
					 (xCoord > 399 && xCoord < 404 && yCoord > 468 && yCoord < 475) ||
					 (xCoord > 399 && xCoord < 411 && yCoord > 470 && yCoord < 475) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// E
			else if (xCoord > 420 && xCoord < 440 && yCoord > 455 && yCoord < 475) begin
				if (
					 (xCoord > 424 && xCoord < 436 && yCoord > 460 && yCoord <= 462) ||
					 (xCoord >= 436 && xCoord < 440 && yCoord > 460 && yCoord <= 470) ||
					 (xCoord > 424 && xCoord < 436 && yCoord > 468 && yCoord <= 470) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// D
			else if (xCoord > 445 && xCoord < 465 && yCoord > 455 && yCoord < 475) begin
				if (
					 (xCoord > 461 && xCoord < 465 && yCoord > 455 && yCoord < 458) ||
					 (xCoord > 449 && xCoord < 461 && yCoord > 460 && yCoord < 470) ||
					 (xCoord > 461 && xCoord < 465 && yCoord > 473 && yCoord < 475) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// I
			else if (xCoord > 470 && xCoord < 490 && yCoord > 455 && yCoord < 475) begin
				if (
					 (xCoord > 470 && xCoord < 478 && yCoord > 460 && yCoord < 470) ||
					 (xCoord > 482 && xCoord < 490 && yCoord > 460 && yCoord < 470) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// T
			else if (xCoord > 495 && xCoord < 515 && yCoord > 455 && yCoord < 475) begin
				if (
					 (xCoord > 495 && xCoord < 503 && yCoord > 460 && yCoord < 475) ||
					 (xCoord > 507 && xCoord < 515 && yCoord > 460 && yCoord < 475) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// 0
			
			else if (xCoord > 545 && xCoord < 565 && yCoord > 455 && yCoord < 475) begin
				if (
					 (xCoord > 545 && xCoord < 549 && yCoord > 455 && yCoord < 460) ||
					 (xCoord > 561 && xCoord < 565 && yCoord > 455 && yCoord < 460) ||
					 (xCoord > 545 && xCoord < 549 && yCoord > 470 && yCoord < 475) ||
					 (xCoord > 561 && xCoord < 565 && yCoord > 470 && yCoord < 475) ||
					 (xCoord > 549 && xCoord < 553 && yCoord > 460 && yCoord < 465) ||
					 (xCoord > 553 && xCoord < 557 && yCoord > 460 && yCoord < 468) ||
					 (xCoord > 553 && xCoord < 557 && yCoord > 468 && yCoord < 470) ||
					 (xCoord > 557 && xCoord < 561 && yCoord > 465 && yCoord < 470) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_WHITE;
				end
			end
			// 0
			else if (xCoord >= 570 && xCoord <= 590) begin
				if (
					 (xCoord > 570 && xCoord < 574 && yCoord > 455 && yCoord < 460) ||
					 (xCoord > 586 && xCoord < 590 && yCoord > 455 && yCoord < 460) ||
					 (xCoord > 570 && xCoord < 574 && yCoord > 470 && yCoord < 475) ||
					 (xCoord > 586 && xCoord < 590 && yCoord > 470 && yCoord < 475) ||
					 (xCoord > 574 && xCoord < 578 && yCoord > 460 && yCoord < 465) ||
					 (xCoord > 578 && xCoord < 582 && yCoord > 460 && yCoord < 463) ||
					 (xCoord > 578 && xCoord < 582 && yCoord > 468 && yCoord < 470) ||
					 (xCoord > 586 && xCoord < 590 && yCoord > 470 && yCoord < 475) 
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
		assign is_scoreboard_bottom = (xCoord > 370 && xCoord < 600 && yCoord > 450 && yCoord < 470);
		
endmodule
