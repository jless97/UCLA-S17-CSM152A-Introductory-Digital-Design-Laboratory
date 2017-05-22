`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:21 05/03/2017 
// Design Name: 
// Module Name:    counter 
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
module display(
	//Inputs
	placeholder,
	//Outputs
	cathode_vec
   );
	 
	input [3:0] placeholder;
	//cathode_vec of form: [ CG CF CE CD CC CB CA ]
	output [6:0] cathode_vec;

	reg [6:0] cathode_vec_temp;

	always @ (*) begin
		case(placeholder)
			0: cathode_vec_temp = 7'b1000000; 
         1: cathode_vec_temp = 7'b1111001;
         2: cathode_vec_temp = 7'b0100100; 
         3: cathode_vec_temp = 7'b0110000; 
         4: cathode_vec_temp = 7'b0011001; 
         5: cathode_vec_temp = 7'b0010010; 
         6: cathode_vec_temp = 7'b0000010; 
         7: cathode_vec_temp = 7'b1111000; 
         8: cathode_vec_temp = 7'b0000000; 
         9: cathode_vec_temp = 7'b0010000; 
   default: cathode_vec_temp = 7'b1111111;
		endcase
	end
	
	assign cathode_vec = cathode_vec_temp;

endmodule













