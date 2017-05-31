`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:05:38 05/29/2017 
// Design Name: 
// Module Name:    start_screen 
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
module start_screen(
	// Inputs
	input wire clk,
	input wire [9:0] xCoord,
	input wire [9:0] yCoord,
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
			// INVADERS	(30 by 40)	
			// Letter I
			else if (xCoord > 185 && xCoord < 215 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 185 && xCoord < 195 && yCoord > 195 && yCoord < 225) ||
					(xCoord > 205 && xCoord < 215 && yCoord > 195 && yCoord < 225)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// Letter N
			else if (xCoord > 220 && xCoord < 250 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 230 && xCoord < 240 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 233 && xCoord < 240 && yCoord >= 195 && yCoord < 200) ||
					(xCoord > 236 && xCoord < 240 && yCoord >= 200 && yCoord < 205) ||
					(xCoord > 230 && xCoord < 233 && yCoord > 215 && yCoord < 220) ||
					(xCoord > 230 && xCoord < 236 && yCoord >= 220 && yCoord < 225) ||
					(xCoord > 230 && xCoord < 240 && yCoord >= 225 && yCoord < 230)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end 
			// Letter V
			else if (xCoord > 255 && xCoord < 285 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 265 && xCoord < 275 && yCoord > 190 && yCoord < 210) ||
					(xCoord > 255 && xCoord < 260 && yCoord > 215 && yCoord < 225) ||
					(xCoord > 280 && xCoord < 285 && yCoord > 215 && yCoord < 225) ||
					(xCoord > 255 && xCoord < 265 && yCoord >= 225 && yCoord < 230) ||
					(xCoord > 275 && xCoord < 285 && yCoord >= 225 && yCoord < 230)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// Letter A
			else if (xCoord > 290 && xCoord < 320 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 290 && xCoord < 295 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 315 && xCoord < 320 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 300 && xCoord < 310 && yCoord > 195 && yCoord < 205) ||
					(xCoord > 300 && xCoord < 310 && yCoord > 210 && yCoord < 230)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end 
			// Letter D
			else if (xCoord > 325 && xCoord < 355 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 345 && xCoord < 355 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 350 && xCoord < 355 && yCoord >= 195 && yCoord < 200) ||
					(xCoord > 345 && xCoord < 355 && yCoord >= 225 && yCoord < 230) ||
					(xCoord > 350 && xCoord < 355 && yCoord > 220 && yCoord < 225) ||
					(xCoord > 335 && xCoord < 340 && yCoord > 195 && yCoord < 225) ||
					(xCoord >= 340 && xCoord < 345 && yCoord > 200 && yCoord < 220)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// Letter E
			else if (xCoord > 360 && xCoord < 390 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 370 && xCoord < 390 && yCoord > 195 && yCoord < 205) ||
					(xCoord > 380 && xCoord < 390 && yCoord >= 205 && yCoord < 215) ||
					(xCoord > 370 && xCoord < 390 && yCoord >= 215 && yCoord < 225)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end
			// Letter R
			else if (xCoord > 395 && xCoord < 425 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 420 && xCoord < 425 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 405 && xCoord < 415 && yCoord > 195 && yCoord < 205) ||
					(xCoord > 420 && xCoord < 425 && yCoord > 205 && yCoord < 215) ||
					(xCoord > 405 && xCoord < 410 && yCoord > 210 && yCoord < 215) ||
					(xCoord > 405 && xCoord < 415 && yCoord >= 215 && yCoord < 230)
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end 
			// Letter S
			else if (xCoord > 430 && xCoord < 460 && yCoord > 190 && yCoord < 230) begin
				if (
					(xCoord > 430 && xCoord < 435 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 455 && xCoord < 460 && yCoord > 190 && yCoord < 195) ||
					(xCoord > 435 && xCoord <= 455 && yCoord > 200 && yCoord < 207) ||
					(xCoord >= 435 && xCoord < 455 && yCoord > 213 && yCoord < 220) ||
					(xCoord > 455 && xCoord < 460 && yCoord > 202 && yCoord < 210) ||
					(xCoord > 430 && xCoord < 435 && yCoord >= 210 && yCoord < 218) || 
					(xCoord > 430 && xCoord < 435 && yCoord > 225 && yCoord < 230) ||
					(xCoord > 455 && xCoord < 460 && yCoord > 225 && yCoord < 230) 
					) begin
					set_color <= COLOR_BLACK;
				end
				else begin
					set_color <= COLOR_GREEN;
				end
			end		
			// Space Invader (Enemy) (60 by 80)
			else if (xCoord > 290 && xCoord < 350 && yCoord > 270 && yCoord < 350) begin
				if (
					(xCoord > 290 && xCoord < 310 && yCoord > 270 && yCoord < 280) ||
					(xCoord > 330 && xCoord < 350 && yCoord > 270 && yCoord < 280) ||
					(xCoord > 290 && xCoord < 300 && yCoord >= 280 && yCoord < 290) ||
					(xCoord > 340 && xCoord < 350 && yCoord >= 280 && yCoord < 290) ||
					(xCoord > 305 && xCoord < 315 && yCoord > 290 && yCoord < 300) ||
					(xCoord > 325 && xCoord < 335 && yCoord > 290 && yCoord < 300) ||
					(xCoord > 290 && xCoord < 305 && yCoord > 310 && yCoord < 320) ||
					(xCoord > 315 && xCoord < 325 && yCoord > 310 && yCoord < 310) ||
					(xCoord > 335 && xCoord < 350 && yCoord > 310 && yCoord < 320) ||
					(xCoord > 290 && xCoord < 300 && yCoord >= 320 && yCoord < 330) ||
					(xCoord > 310 && xCoord < 315 && yCoord >= 320 && yCoord < 330) ||
					(xCoord > 325 && xCoord < 330 && yCoord >= 320 && yCoord < 330) ||
					(xCoord > 340 && xCoord < 350 && yCoord >= 320 && yCoord < 330) ||
					(xCoord > 300 && xCoord < 340 && yCoord > 340 && yCoord < 350)
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
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
// TAP TO PLAY (15 by 20)
		else if (xCoord > 234 && xCoord < 423 && yCoord > 450 && yCoord < 470) begin
			// Letter T
			if ( 
				(xCoord > 234 && xCoord < 249 && yCoord > 450 && yCoord < 470) ||
				(xCoord > 244 && xCoord < 249 && yCoord > 455 && yCoord < 470)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b00;
			end
		end
		// Letter A
		else if (xCoord > 251 && xCoord < 266 && yCoord > 450 && yCoord < 470) begin
			if (
				(xCoord > 251 && xCoord < 254 && yCoord > 450 && yCoord < 453) ||
				(xCoord > 263 && xCoord < 266 && yCoord > 450 && yCoord < 453) ||
				(xCoord > 256 && xCoord < 261 && yCoord > 453 && yCoord < 457) ||
				(xCoord > 256 && xCoord < 261 && yCoord > 456 && yCoord < 470)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end
		// Letter P
		else if (xCoord > 268 && xCoord < 283 && yCoord > 450 && yCoord < 470) begin
			if (
				(xCoord > 280 && xCoord < 283 && yCoord > 450 && yCoord < 453) ||
				(xCoord > 280 && xCoord < 283 && yCoord > 457 && yCoord < 460) ||
				(xCoord > 455 && xCoord < 465 && yCoord > 453 && yCoord < 457) ||
				(xCoord > 273 && xCoord < 283 && yCoord > 460 && yCoord < 470)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
		end
		// Letter T
		else if (xCoord > 303 && xCoord < 318 && yCoord > 450 && yCoord < 470) begin
			if (
				(xCoord > 303 && xCoord < 308 && yCoord > 455 && yCoord < 470) ||
				(xCoord > 313 && xCoord < 318 && yCoord > 455 && yCoord < 470)
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b11;
			end
		end
		// Letter O
		else if (xCoord > 322 && xCoord < 337 && yCoord > 450 && yCoord < 470) begin
			if (
			
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end
		// Letter P
		else if (xCoord > 357 && xCoord < 372 && yCoord > 450 && yCoord < 470) begin
			if (
			
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end
		// Letter L
		else if (xCoord > 374 && xCoord < 389 && yCoord > 450 && yCoord < 47) begin
			if (
			
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end
		// Letter A
		else if (xCoord > 391 && xCoord < 406 && yCoord > 450 && yCoord < 47) begin
			if (
			
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end
		// Letter Y
		else if (xCoord > 408 && xCoord < 423 && yCoord > 450 && yCoord < 47) begin
			if (
			
				) begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b00;
			end
			else begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
			end
		end*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
