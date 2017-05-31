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
    //Current X and Y of the screen
    input wire [10:0] xCoord,
    input wire [10:0] yCoord,
    // Damage input
    input wire [10:0] damage_x,
    input wire [10:0] damage_y,
    input wire new_damage,
    //Output that states whether the current position is a barrier
    output wire [7:0] rgb_color;
    output wire isBarrier;
    );
    parameter BARR_BLK_SZ = 19;
    parameter BARR_WIDTH = 76;
    parameter BARR_HEIGHT = 57;
    parameter BARR_YSTART = 340;

    //format (from top left) [which_barrier] [xVal] [yVal] [health]
    reg [1:0] barrierInfo [1:0] [1:0] [1:0];
    reg [5:0] i;
    initial begin
        for(i = 0; i < 64; i = i+1) begin
            if(!(((i[3:2] == 2'b00 || i[3:2] == 2'b11) && i[1:0] == 2'b11) 
                || ((i[3:2] == 2'b01 || i[3:2] == 2'b10) && i[1:0] > 2'b01))) begin
                barrierInfo [i[5:4]] [i[3:2]] [i[1:0]] = 2'b00;
            end
            else begin
                barrierInfo [i[5:4]] [i[3:2]] [i[1:0]] = 2'b11;
            end
        end
    end
    //shifted x and y values for calculation of which barrier block we're "in" - values for display
    reg [10:0] shiftedYCoord;
    reg [1:0] currBarrier;
    reg [1:0] currXblk;
    reg [1:0] currYblk;
    wire inBarrier;
    //x and y values for keeping track of damage
    reg [10:0] shifted_damage_y;
    reg [1:0] damage_barrier;
    reg [1:0] damage_x_blk;
    reg [1:0] damage_y_blk;
    wire isDamage;
    //Get location of barrier for display
    extract_barrier_blk getDisplayVals(
        //Inputs
        .xCoord(xCoord), .shiftedYCoord(shiftedYCoord), 
        //Outputs
        .currBarrier(currBarrier), .xVal(currXblk), .yVal(currYblk), .inBarrier(inBarrier));
    //Get location of which block within the barrier the new damage hit
    extract_barrier_blk getDamageVals(
        //Inputs
        .xCoord(damage_x), .shiftedYCoord(damage_y), 
        //Outputs
        .currBarrier(damage_barrier), .xVal(damage_x_blk), .yVal(damage_y_blk), .inBarrier(isDamage));
    reg [7:0] rgb_color_temp;
    reg [5:0] j;
    always @ (posedge clk) begin
        if(rst) begin
            for(j = 0; j < 64; j = j+1) begin
                if(!(((j[3:2] == 2'b00 || j[3:2] == 2'b11) && j[1:0] == 2'b11) 
                    || ((j[3:2] == 2'b01 || j[3:2] == 2'b10) && j[1:0] > 2'b01))) begin
                    barrierInfo [j[5:4]] [j[3:2]] [j[1:0]] = 2'b00;
                end
                else begin
                    barrierInfo [j[5:4]] [j[3:2]] [j[1:0]] = 2'b11;
                end
        end
        end
        if(yCoord >= BARR_YSTART && yCoord <= BARR_YSTART + BARR_HEIGHT) begin
            shiftedYCoord = yCoord - BARR_YSTART;
            if(barrierInfo[currBarrier][currXblk][currYblk] == 2'b00) begin
                isBarrier_temp = 0;
                rgb_color_temp = 7'd0;
            end
            else begin
                isBarrier_temp = 1;
                rgb_color_temp = {2{0}, barrierInfo[currBarrier][currXblk][currYblk], 1, 3{0}}
            end
        end
        else begin
            shiftedYCoord = BARR_YSTART + BARR_HEIGHT + 1;
            isBarrier_temp = 0;
            rgb_color_temp = 7'd0;
        end
        if(damage_y >= BARR_YSTART && damage_y <= BARR_YSTART + BARR_HEIGHT) begin
            shifted_damage_y = damage_y - BARR_YSTART;
        end
        if(new_damage && isDamage) begin
            if(barrierInfo [damage_barier] [damage_x_blk] [damage_y_blk] != 2'b00) begin
                barrierInfo [damage_barier] [damage_x_blk] [damage_y_blk] = barrierInfo [damage_barier] [damage_x_blk] [damage_y_blk] - 1;
            end
        end
    end
    assign rgb_color = rgb_color_temp;
    assign isBarrier = isBarrier_temp;

endmodule
