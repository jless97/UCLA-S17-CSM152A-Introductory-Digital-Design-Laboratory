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
module set_barriers(
	// Inputs
	input wire clk,
	input wire rst,
	input wire mode,
	input wire restart,
	//Current X and Y of the screen
	input wire [9:0] xCoord,
	input wire [9:0] yCoord,
	// Damage input
	input wire [9:0] spaceshipLaserXcoord,
	input wire [9:0] spaceshipLaserYcoord,
	input wire [29:0] alienLaserXcoord,
	input wire [29:0] alienLaserYcoord,
	//Output that states whether the current position is a barrier
	output wire [7:0] rgb,
	output wire is_barrier,
	output wire spaceshipLaserHit,
	output wire [11:0] alienLaserHit
	);
	 
`include "barrier_params.vh"
parameter LASER_HEIGHT = 10'd10;
parameter HALF_LASER_HEIGHT = 10'd5;
	//format (from top left) [which_barrier] [xVal] [yVal] [health]
	reg [2:0] barrierInfo [3:0] [3:0] [3:0];
	reg [2:0] i;
	reg [2:0] k;
	reg [2:0] m;
	initial begin
		for(i = 3'b000; i <= 3'b011; i = i+1) begin
			for(k = 3'b000; k <= 3'b011; k = k+1) begin
				for(m = 3'b000; m <= 3'b011; m = m+1) begin
					if(((k == 3'b000 || k == 3'b011) && m == 3'b011) || ((k == 3'b001 || k == 3'b010) && m > 3'b001)) begin
						barrierInfo [i] [k] [m] <= 2'b00;
					end
					else begin
						barrierInfo [i] [k] [m] <= 2'b11;
					end
				end
			end
		end
	end
	 
	//shifted x and y values for calculation of which barrier block we're "in" - values for display
	wire [1:0] currBarrier;
	wire [1:0] currXblk;
	wire [1:0] currYblk;
	wire inBarrier;
	 
	//Get location of barrier for display
	extract_barrier_blk getDisplayVals(
		//Inputs
		.xCoord(xCoord), .yCoord(yCoord), 
		//Outputs
		.currBarrier(currBarrier), .xVal(currXblk), .yVal(currYblk), .inBarrier(displayInBarrier)
		);
	//variables to keep track of damage from spaceship
	wire [1:0] spaceshipDamageBarrier;
	wire [1:0] spaceshipDamageXblk;
	wire [1:0] spaceshipDamageYblk;
	wire isSpaceshipDamage;   
	//Check if the spaceship laser is in the barrier, and extract which barrier it's in
	extract_barrier_blk getSpaceshipDamageVals(
		//Inputs
		.xCoord(spaceshipLaserXcoord), .yCoord(spaceshipLaserYcoord - LASER_HEIGHT),
		//Outputs
		.currBarrier(spaceshipDamageBarrier), .xVal(spaceshipDamageXblk), .yVal(spaceshipDamageYblk), .inBarrier(isSpaceshipDamage)
		);
	//Damage from bullet 0
	wire [1:0] alienDamageBarrier0;
	wire [1:0] alienDamageXblk0;
	wire [1:0] alienDamageYblk0;
	wire isAlienDamage0;
	//Damage from bullet 1
	wire [1:0] alienDamageBarrier1;
	wire [1:0] alienDamageXblk1;
	wire [1:0] alienDamageYblk1;
	wire isAlienDamage1;
	//Damage from bullet 2
	wire [1:0] alienDamageBarrier2;
	wire [1:0] alienDamageXblk2;
	wire [1:0] alienDamageYblk2;
	wire isAlienDamage2;
	/*
	//Damage from bullet 3
	wire [1:0] alienDamageBarrier3;
	wire [1:0] alienDamageXblk3;
	wire [1:0] alienDamageYblk3;
	wire isAlienDamage3;
	//Damage from bullet 4
	wire [1:0] alienDamageBarrier4;
	wire [1:0] alienDamageXblk4;
	wire [1:0] alienDamageYblk4;
	wire isAlienDamage4;
	//Damage from bullet 5
	wire [1:0] alienDamageBarrier5;
	wire [1:0] alienDamageXblk5;
	wire [1:0] alienDamageYblk5;
	wire isAlienDamage5;
	*/
	extract_barrier_blk getAlienDamageVals0(
		.xCoord(alienLaserXcoord[9:0]), .yCoord(alienLaserYcoord[9:0] + LASER_HEIGHT),
		//Outputs
		.currBarrier(alienDamageBarrier0), .xVal(alienDamageXblk0), .yVal(alienDamageYblk0), .inBarrier(isAlienDamage0)
		);
	extract_barrier_blk getAlienDamageVals1(
		.xCoord(alienLaserXcoord[19:10]), .yCoord(alienLaserYcoord[19:10] + LASER_HEIGHT),
		//Outputs
		.currBarrier(alienDamageBarrier1), .xVal(alienDamageXblk1), .yVal(alienDamageYblk1), .inBarrier(isAlienDamage1)
		);
	extract_barrier_blk getAlienDamageVals2(
		.xCoord(alienLaserXcoord[29:20]), .yCoord(alienLaserYcoord[29:20] + LASER_HEIGHT),
		//Outputs
		.currBarrier(alienDamageBarrier2), .xVal(alienDamageXblk2), .yVal(alienDamageYblk2), .inBarrier(isAlienDamage2)
		);
	/*
	extract_barrier_blk getAlienDamageVals3(
		.xCoord(alienLaserXcoord[43:33]), .yCoord(alienLaserYcoord[43:33]+LASER_HEIGHT),
		//Outputs
		.currBarrier(alienDamageBarrier3), .xVal(alienDamageXblk3), .yVal(alienDamageYblk3), .inBarrier(isAlienDamage3)
		);
	extract_barrier_blk getAlienDamageVals4(
		.xCoord(alienLaserXcoord[54:44]), .yCoord(alienLaserYcoord[54:44]+LASER_HEIGHT),
		//Outputs
		.currBarrier(alienDamageBarrier4), .xVal(alienDamageXblk4), .yVal(alienDamageYblk4), .inBarrier(isAlienDamage4)
		);
	extract_barrier_blk getAlienDamageVals5(
		.xCoord(alienLaserXcoord[65:55]), .yCoord(alienLaserYcoord[65:55]+LASER_HEIGHT),
		//Outputs
		.currBarrier(alienDamageBarrier5), .xVal(alienDamageXblk5), .yVal(alienDamageYblk5), .inBarrier(isAlienDamage5)
		);
		*/
	reg [7:0] rgb_temp;
	reg is_barrier_temp;
	reg spaceshipLaserHit_temp;
	reg [11:0] alienLaserHit_temp;
	always @ (posedge clk) begin
		if(rst || mode == 0) begin
			for(i = 3'b000; i <= 3'b011; i = i+1) begin
				for(k = 3'b000; k <= 3'b011; k = k+1) begin
					for(m = 3'b000; m <= 3'b011; m = m+1) begin
						if(((k == 3'b000 || k == 3'b011) && m == 3'b011) || ((k == 3'b001 || k == 3'b010) && m > 3'b001)) begin
							barrierInfo [i] [k] [m] <= 2'b00;
						end
						else begin
							barrierInfo [i] [k] [m] <= 2'b11;
						end
					end
				end
			end
		end
		else if (mode == 1) begin
			if(displayInBarrier && barrierInfo[currBarrier][currXblk][currYblk] != 3'b000) begin
				is_barrier_temp <= 1'b1;
				rgb_temp <= {2'b00, barrierInfo[currBarrier][currXblk][currYblk], 4'b1000};
			end
			else begin
				is_barrier_temp <= 1'b0;
				rgb_temp <= 7'd0;
			end

			if(isSpaceshipDamage && barrierInfo[spaceshipDamageBarrier][spaceshipDamageXblk][spaceshipDamageYblk] != 3'b000) begin
				barrierInfo [spaceshipDamageBarrier][spaceshipDamageXblk][spaceshipDamageYblk] <= barrierInfo [spaceshipDamageBarrier][spaceshipDamageXblk][spaceshipDamageYblk] - 2'b01;
				spaceshipLaserHit_temp <= 1'b1;
			end
			else begin
				spaceshipLaserHit_temp <= 1'b0;
			end
			if(isAlienDamage0 && barrierInfo [alienDamageBarrier0][alienDamageXblk0][alienDamageYblk0] != 3'b000) begin
				barrierInfo [alienDamageBarrier0][alienDamageXblk0][alienDamageYblk0] <= barrierInfo [alienDamageBarrier0][alienDamageXblk0][alienDamageYblk0] - 2'b01;
				alienLaserHit_temp[0] <= 1'b1;
			end
			else begin
				alienLaserHit_temp[0] <= 1'b0;
			end
			if(isAlienDamage1 && barrierInfo [alienDamageBarrier1][alienDamageXblk1][alienDamageYblk1] != 3'b000) begin
				barrierInfo [alienDamageBarrier1][alienDamageXblk1][alienDamageYblk1] <= barrierInfo [alienDamageBarrier1][alienDamageXblk1][alienDamageYblk1] - 2'b01;
				alienLaserHit_temp[1] <= 1'b1;
			end
			else begin
				alienLaserHit_temp[1] <= 1'b0;
			end
			if(isAlienDamage2 && barrierInfo [alienDamageBarrier2][alienDamageXblk2][alienDamageYblk2] != 3'b000) begin
				barrierInfo [alienDamageBarrier2][alienDamageXblk2][alienDamageYblk2] <= barrierInfo [alienDamageBarrier2][alienDamageXblk2][alienDamageYblk2] - 2'b01;
				alienLaserHit_temp[2] <= 1'b1;
			end
			else begin
				alienLaserHit_temp[2] <= 1'b0;
			end
		end
	end
	assign rgb = rgb_temp;
    assign is_barrier = is_barrier_temp;
    assign spaceshipLaserHit = spaceshipLaserHit_temp;
    assign alienLaserHit = alienLaserHit_temp;
endmodule 
