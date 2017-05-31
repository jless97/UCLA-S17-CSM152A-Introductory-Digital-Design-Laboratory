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
    // Damage input
    input wire [10:0] damage_x,
    input wire [10:0] damage_y,
    input wire new_damage,
    //Current X and Y of the screen
    input wire [10:0] xCoord,
    input wire [10:0] yCoord,
    //Output that states whether the current position is a barrier
    wire isBarrier;
    wire [7:0] rgb_color;
    );
    //format (from top left) [which_barrier] [xcoord] [ycoord] [health]
    reg [1:0] [1:0] [1:0] [1:0] barrierInfo;
endmodule
