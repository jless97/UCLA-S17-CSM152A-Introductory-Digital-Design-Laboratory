`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:47:05 05/11/2017 
// Design Name: 
// Module Name:    separate_digits 
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
module separate_digits(
	// Inputs
	minutes, seconds,
	// Outputs
	min_10s, min_1s, sec_10s, sec_1s
    );

	input [5:0] minutes;
	input [5:0] seconds;
	
	output [3:0] min_10s;
	output [3:0] min_1s;
	output [3:0] sec_10s;
	output [3:0] sec_1s;

	assign min_10s = minutes/10;
	assign sec_10s = seconds/10;
	assign min_1s = minutes - (10 * min_10s);
	assign sec_1s = seconds - (10 * sec_10s);

endmodule
