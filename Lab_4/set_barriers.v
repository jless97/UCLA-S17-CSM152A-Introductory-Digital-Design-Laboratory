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
	 input wire restart,
    //Current X and Y of the screen
    input wire [10:0] xCoord,
    input wire [10:0] yCoord,
    // Damage input
    input wire [10:0] damage_x,
    input wire [10:0] damage_y,
    input wire new_damage,
    //Output that states whether the current position is a barrier
    output wire [7:0] rgb,
    output wire is_barrier
    );
	 
	 // Barrier Parameters
    parameter BARR_BLK_SZ = 19;
    parameter BARR_WIDTH = 76;
    parameter BARR_HEIGHT = 57;
    parameter BARR_YSTART = 340;

    //format (from top left) [which_barrier] [xVal] [yVal] [health]
    reg [3:0] barrierInfo[3:0] [3:0] [3:0];
    reg [2:0] i;
    reg [2:0] k;
    reg [2:0] m;
    initial begin
        for(i = 3'b000; i <= 3'b011; i = i+1) begin
            for(k = 3'b000; k <= 3'b011; k = k+1) begin
                for(m = 3'b000; m <= 3'b011; m = m+1) begin
                    if(((k == 2'b00 || k == 2'b11) && m == 2'b11) || ((k == 2'b01 || k == 2'b10) && m > 2'b01)) begin
                        barrierInfo [i] [k] [m] = 3'b000;
                    end
                    else begin
                        barrierInfo [i] [k] [m] = 3'b011;
                    end
                end
            end
        end
    end
	 
    //shifted x and y values for calculation of which barrier block we're "in" - values for display
    reg [10:0] shiftedYCoord;
    wire [1:0] currBarrier;
    wire [1:0] currXblk;
    wire [1:0] currYblk;
    wire inBarrier;
    //x and y values for keeping track of damage
    reg [10:0] shifted_damage_y;
    wire [1:0] damage_barrier;
    wire [1:0] damage_x_blk;
    wire [1:0] damage_y_blk;
    wire isDamage;
	 
    //Get location of barrier for display
    extract_barrier_blk getDisplayVals(
        //Inputs
        .xCoord(xCoord), .shiftedYCoord(shiftedYCoord), 
        //Outputs
        .currBarrier(currBarrier), .xVal(currXblk), .yVal(currYblk), .inBarrier(inBarrier)
        );
		  
    //Get location of which block within the barrier the new damage hit
    extract_barrier_blk getDamageVals(
        //Inputs
        .xCoord(damage_x), .shiftedYCoord(damage_y), 
        //Outputs
        .currBarrier(damage_barrier), .xVal(damage_x_blk), .yVal(damage_y_blk), .inBarrier(isDamage)
        );
		  
    reg is_barrier_temp;
    reg [7:0] rgb_temp;
    always @ (posedge clk) begin
        if(rst || restart) begin
            for(i = 3'b000; i <= 3'b011; i = i+1) begin
                for(k = 3'b000; k <= 3'b011; k = k+1) begin
                    for(m = 3'b000; m <= 3'b011; m = m+1) begin
                        if(((k == 2'b00 || k == 2'b11) && m == 2'b11) || ((k == 2'b01 || k == 2'b10) && m > 2'b01)) begin
                            barrierInfo [i] [k] [m] = 3'b000;
                        end
                        else begin
                            barrierInfo [i] [k] [m] = 3'b011;
                        end
                    end
                end
            end
        end
        if(yCoord >= BARR_YSTART && yCoord <= BARR_YSTART + BARR_HEIGHT) begin
            shiftedYCoord = yCoord - BARR_YSTART;
            if(inBarrier && barrierInfo[currBarrier][currXblk][currYblk] != 2'b00) begin
                is_barrier_temp = 1;
                rgb_temp = {2'b00, barrierInfo[currBarrier][currXblk][currYblk], 4'b1000};
            end
            else begin
                is_barrier_temp = 0;
                rgb_temp = 7'd0;
            end
        end
        else begin
            shiftedYCoord = BARR_YSTART + BARR_HEIGHT + 1;
            is_barrier_temp = 0;
            rgb_temp = 7'd0;
        end
        if(damage_y >= BARR_YSTART && damage_y <= BARR_YSTART + BARR_HEIGHT) begin
            shifted_damage_y = damage_y - BARR_YSTART;
        end
        if(new_damage && isDamage) begin
            if(barrierInfo [damage_barrier] [damage_x_blk] [damage_y_blk] != 2'b00) begin
                barrierInfo [damage_barrier] [damage_x_blk] [damage_y_blk] = barrierInfo [damage_barrier] [damage_x_blk] [damage_y_blk] - 1;
            end
        end
    end
	 
    assign rgb = rgb_temp;
    assign is_barrier = is_barrier_temp;

endmodule 
