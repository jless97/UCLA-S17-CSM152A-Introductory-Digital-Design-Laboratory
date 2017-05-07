`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA: CS M152A
// Engineer: Jason Less, Lucas Jenkins, Eddie Huang
// 
// Create Date:    21:06:49 05/06/2017 
// Design Name: 
// Module Name:    C:/Users/JasonLess/Documents/Lab/lab2_completed/sign_mag_converter.v
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
module sign_mag_converter(
  //Input
  linear_enc_sign, sign,
  //Output
  conv_sig
  );
  
  input [11:0] linear_enc_sign;
  input sign; // = linear_enc_sign[11]
  output [11:0] conv_sig;
  
  // Temp variable to assign conversion of SM to output variable
  reg [11:0] temp_conv_sig;
  
  always @ (*) begin
	 temp_conv_sig = conv_sig;
    // If the 2's complement value is a negative number
	 if(sign == 1) begin
	   // If it is the smallest 2's complement value, then
		// set to largest 2's complement value (avoiding overflow)
	   if(linear_enc_sign == -12'b100000000000) begin
			temp_conv_sig = 12'b011111111111;
      end
		else begin
      temp_conv_sig = (~linear_enc_sign) + 1;
		end
    // If the 2's complement value is positive, leave as is
    end
    else begin
       temp_conv_sig = linear_enc_sign;
     end
   end
	
	assign conv_sig = temp_conv_sig;
	
endmodule
