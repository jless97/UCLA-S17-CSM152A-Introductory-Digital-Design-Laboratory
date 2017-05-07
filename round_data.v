`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA: CS M152A
// Engineer: Jason Less, Lucas Jenkins, Eddie Huang 
// 
// Create Date:    21:08:17 05/06/2017 
// Design Name: 
// Module Name:    C:/Users/JasonLess/Documents/Lab/lab2_completed/round_data.v
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
module round_data(
  //Inputs
  presignificand, pre_exp, 
  //Outputs
  significand, exp
  );
  
    input [4:0] presignificand;
    input [2:0] pre_exp;
    output [3:0] significand;
    output [2:0] exp;
	 
	 // Temp variables to assign values to output wires via regs
	 reg [4:0] temp_significand;
	 reg [2:0] temp_exp;
	 
    always @ (*) begin
		temp_significand = presignificand;
		temp_exp = pre_exp;
		// If the last bit is 1, begin rounding implementation
		if(presignificand[0] == 1) begin
			// Special case: round up
			// If all the presignificand bits are one
			if ((&presignificand) == 1) begin
				// If the pre_exp is less than 7 (max exp), increment
				// to deal with overflow
				// Also, increment significand by 1 (to handle overflow)
				if (pre_exp < 7) begin
					temp_significand = 4'b1000;
					temp_exp = pre_exp + 1;
				end
				// If the pre_exp is max exp, then leave as is
				// Also, can't alter significand, so leave as is
				else if (pre_exp == 7) begin
					temp_significand = 4'b1111;
					temp_exp = pre_exp;
				end
			end
			// Normal case: round up
			// If presignificand bits aren't all one, roound up
			else begin 
				temp_significand = presignificand[4:1] + 1;
				temp_exp = pre_exp;
			end
		// Normal case: round down
		// The last bit of presignificant is 0, so round down
		end
		else begin
			temp_significand = presignificand[4:1];
			temp_exp = pre_exp;
		end
	 end
	 
	 assign significand = temp_significand;
	 assign exp = temp_exp;
	 
endmodule
